namespace DTWMain_Ext.DTWMain_Ext;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.BOM;
using Microsoft.Manufacturing.StandardCost;
using Microsoft.Finance.Dimension;
using Microsoft.Manufacturing.Setup;
using Microsoft.Inventory.Location;
using Microsoft.Manufacturing.WorkCenter;
using Microsoft.Purchases.Pricing;
using ALProject.ALProject;
using Microsoft.Inventory.BOM.Tree;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Manufacturing.Routing;

report 54047 ImplementStandardCostItem
{
    ApplicationArea = All;
    Caption = 'ImplementStandardCostItem';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    //BC Upgrade GUNREM01 >> Created new report for standard cost calculation based on components for finished products FDD DTW 16
    dataset
    {
        dataitem(ItemD; Item)
        {

            //   DataItemTableView = SORTING(No.) ORDER(Ascending) WHERE("Replenishment System"=FILTER("Prod. Order"),"Production BOM No."=CONST(<>''),Routing No.=CONST(<>''))   
            RequestFilterFields = "No.";
            //  DataItemTableView = sorting("No.") order(ascending) where("Replenishment System" = filter("Prod. Order"), "Production BOM No." = const(<> ''), "Routing No." = const(''));
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Replenishment System" = FILTER("Prod. Order"));
            trigger OnAfterGetRecord();
            var
                LastEntryNo: Integer;
                ParentEntryNo: array[1000] of Integer;
                i: Integer;
                j: Integer;
                SemiFinishedStandardCost: Decimal;
                ItemNoSemiFinished: Code[20];
                BOMBuffer: Record "BOM Buffer" temporary;
                TempBomBuffer: Record "BOM Buffer" temporary;
                WorkCenterStandardCost: Decimal;
                FinishedProductStandardCost: Decimal;
            begin
                //IF "Stockkeeping Unit"."Replenishment System" <> "Stockkeeping Unit"."Replenishment System"::"Prod. Order" THEN
                ItemD.TESTFIELD(ItemD."Replenishment System", ItemD."Replenishment System"::"Prod. Order");
                Clear(BOMBuffer);
                BOMBuffer.RESET();
                BOMBuffer.DELETEALL();
                Clear(TempBomBuffer);
                TempBomBuffer.RESET();
                TempBomBuffer.DELETEALL;
                //TempDimensionCodeAmountBuffer.RESET;
                //TempDimensionCodeAmountBuffer.DELETEALL;
                if not TempDimensionCodeAmountBuffer.GET(ItemD."No.", ItemD."New Location Code FND") then begin
                    InitBomBufferITEM("No.", ItemD, BOMBuffer);

                    Clear(BOMBuffer);
                    BOMBuffer.RESET();
                    if BOMBuffer.FINDSET then
                        repeat
                            TempBomBuffer := BOMBuffer;
                            TempBomBuffer.INSERT;
                            LastEntryNo := BOMBuffer."Entry No.";
                        until BOMBuffer.NEXT = 0;

                    Clear(BOMBuffer);
                    BOMBuffer.RESET();
                    BOMBuffer.SETCURRENTKEY("Entry No.");
                    BOMBuffer.SETRANGE("Replenishment System", BOMBuffer."Replenishment System"::"Prod. Order");
                    if BOMBuffer.FINDSET then
                        repeat

                            i += 1;
                            TempBomBuffer.SETRANGE("Entry No.", BOMBuffer."Entry No.", LastEntryNo);
                            TempBomBuffer.SETRANGE(Indentation, BOMBuffer.Indentation + 1);
                            if TempBomBuffer.FINDSET then
                                repeat
                                    TempBomBuffer."Parent Entry No. FND" := BOMBuffer."Entry No.";
                                    TempBomBuffer.MODIFY;
                                until TempBomBuffer.NEXT = 0;
                        //ParentEntryNo[i] := BOMBuffer."Entry No.";
                        //MESSAGE(FORMAT(ParentEntryNo[i]));
                        until BOMBuffer.NEXT = 0;

                    Clear(BOMBuffer);
                    BOMBuffer.RESET();
                    BOMBuffer.DELETEALL();
                    Clear(TempBomBuffer);
                    TempBomBuffer.RESET();
                    if TempBomBuffer.FINDSET then
                        repeat
                            BOMBuffer := TempBomBuffer;

                            BOMBuffer.INSERT;
                        until TempBomBuffer.NEXT = 0;

                    Clear(TempBomBuffer);
                    TempBomBuffer.RESET();
                    TempBomBuffer.SETCURRENTKEY("Parent Entry No. FND");
                    TempBomBuffer.SETASCENDING("Parent Entry No. FND", false);
                    TempBomBuffer.SETRANGE("Replenishment System", TempBomBuffer."Replenishment System"::"Prod. Order");
                    if TempBomBuffer.FINDSET then
                        repeat
                            CLEAR(SemiFinishedStandardCost);
                            CLEAR(WorkCenterStandardCost);
                            Clear(BOMBuffer);
                            BOMBuffer.RESET();
                            BOMBuffer.SETRANGE("Parent Entry No. FND", TempBomBuffer."Entry No.");
                            if BOMBuffer.FINDSET then
                                repeat
                                    case BOMBuffer."Replenishment System" of
                                        BOMBuffer."Replenishment System"::"Prod. Order":
                                            begin
                                                SemiFinishedStandardCost += GetCostPerItemComponent(CheckIfStandarCodeAlreadyExist(BOMBuffer."No.", ItemD."New Location Code FND"), BOMBuffer."Qty. per Parent");
                                            end else begin
                                            case BOMBuffer.Type of
                                                BOMBuffer.Type::Item:
                                                    begin
                                                        //HEI.03>>
                                                        //  SemiFinishedStandardCost += GetCostPerItemComponent(GetItemComponentPrice(BOMBuffer."No.",BOMBuffer."Unit of Measure Code"),BOMBuffer."Qty. per Parent");
                                                        SemiFinishedStandardCost += GetCostPerItemComponent(GetItemComponentBasePrice(BOMBuffer."No.", BOMBuffer."Unit of Measure Code"), BOMBuffer."Qty. per Parent");
                                                        //   //BC Upgrade GUNREM01 >>
                                                        //     SemiFinishedStandardCost += GetCostPerItemComponent(
                                                        //         GetItemCost(BOMBuffer."No.", ItemD."New Location Code"),
                                                        //         BOMBuffer."Qty. per Parent");
                                                        //HEI.03<<
                                                    end;
                                                BOMBuffer.Type::"Work Center":
                                                    begin
                                                        WorkCenterStandardCost += GetCostPerWorkCenterComponent(GetWorkCenterComponentPrice(BOMBuffer."No.", TempBomBuffer."No.", ItemD."New Location Code FND"), 1);
                                                    end;
                                            end;
                                        end;
                                    end;
                                //                                     MESSAGE(
                                //                                     'Parent Item: %1 \ Child: %2 \ Type: %3 \ Qty: %4 \ SemiFinishedCost: %5 \ WorkCenterCost: %6',
                                // TempBomBuffer."No.",
                                //                                     BOMBuffer."No.",
                                //                                     FORMAT(BOMBuffer.Type),
                                //                                     BOMBuffer."Qty. per Parent",
                                //                                     SemiFinishedStandardCost,
                                //                                     WorkCenterStandardCost
                                //                                     );

                                until BOMBuffer.NEXT = 0;
                            InsertStandardCostToBuffer(TempBomBuffer."No.", ItemD."New Location Code FND", SemiFinishedStandardCost + WorkCenterStandardCost);
                        until TempBomBuffer.NEXT = 0;


                end;
            end;

            trigger OnPreDataItem();
            begin

            end;

            trigger OnPostDataItem();
            begin
                //MESSAGE(Text001,'STANDARD');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StandardCostWorksheetName; StandardCostWorksheetName)
                {
                    ApplicationArea = All;
                    Caption = 'Standard Cost Worksheet Name';
                    TableRelation = "Standard Cost Worksheet Name".Name;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        InsertStandardCostIntoJournal;
        if ExistEntries then
            MESSAGE('DONE')
        else
            MESSAGE('There is no Standard cost to calculate!');
        //BC Upgrade Kamnay01 >> STD Cost bug fix 
        ManufacturingSetup.Get();
        ManufacturingSetup."Std Cost Version FND" := false;
        ManufacturingSetup.Modify(false);
        //BC Upgrade Kamnay01 << STD Cost bug fix 
    end;

    trigger OnPreReport();
    var
        StandardCostWorksheet: Record "Standard Cost Worksheet";
    begin
        if StandardCostWorksheetName = '' then
            ERROR(Text005);

        StandardCostWorksheet.RESET;
        StandardCostWorksheet.SETRANGE("Standard Cost Worksheet Name", StandardCostWorksheetName);
        StandardCostWorksheet.DELETEALL;
    end;

    VAR
        Text000: Label 'ENU=Could not find items with BOM levels.';
        Text001: label 'ENU=The new standard cost has been implemented.Check Standard Cost Worksheet %1!';
        Text002: label 'ENU=%1 must have a value!';
        Text003: label 'ENU=There are already some entries into Standard Code Worksheet Batch %1.Do you want to delete them?';
        Text004: label 'ENU=There is no purchase price setup for item no. %1.Please setup it an try again!';
        TempDimensionCodeAmountBuffer: Record "Dimension Code Amount Buffer" temporary;
        StandardCostWorksheetName: Code[20];
        Text005: label 'ENU=Standard cost worksheet name cannot be blank!';
        ExistEntries: Boolean;
        //  ItemG: Record Item;
        RoutingVersion: Record "Routing Version";
        ProductionBOMVersion: Record "Production BOM Version";
        RoutingNo: Code[20];
        BOM: Code[20];
        RoutingExist: Boolean;
        BOMExist: Boolean;
        StandardCostWorksheet: Record "Standard Cost Worksheet";
        ManufacturingSetup: Record "Manufacturing Setup";//BC Upgrade kamnay01 std cost  23-06-2026

    LOCAL PROCEDURE InitBomBufferITEM(ItemFilter: Code[20]; ItemP: Record Item; VAR BOMBuffer: Record "BOM Buffer" temporary);
    VAR
        CalcBOMTree: Codeunit "Calculate BOM Tree";
        HBUDTW: Codeunit "Heineken BC Upgrade DTW";
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";
        CalculateBomTree: Codeunit "Calculate Bom Tree DTW";
        ItemG: Record Item;
    BEGIN
        //HEI.01>>
        BOMBuffer.DELETEALL;

        ItemG.GET(ItemFilter);

        CalcBOMTree.SetItemFilter(ItemG);
        if (not ItemP.HasBOM) and (ItemP."Routing No." = '') then
            ERROR(Text000);

        CalculateBomTree.SetRunParam(TRUE);
        //HEI.04>>
        HeinekenBCUpgrade.ActivateBlankVersionCode(TRUE);
        //HEI.04<<
        CalculateBomTree.GenerateTreeForItems(ItemG, BOMBuffer, 0, ItemG."New Location Code FND", '');
        //HEI.01<<
    END;

    LOCAL PROCEDURE GetItemComponentPric(ItemNo: Code[20]; Uom: Code[10]): Decimal;
    VAR
        PurchasePrice: Record "Purchase Price";
    BEGIN
        PurchasePrice.RESET;
        PurchasePrice.SETRANGE("Item No.", ItemNo);
        PurchasePrice.SETFILTER("Unit of Measure Code", '%1|%2', Uom, '');
        IF PurchasePrice.FINDLAST THEN
            EXIT(PurchasePrice."Direct Unit Cost");

        EXIT(0);
        //ELSE
        //  ERROR(Text004,ItemNo);
    END;

    LOCAL PROCEDURE GetWorkCenterComponentPrice(WorkCenterNo: Code[20]; ParentItemNo: Code[20]; LocationCode: Code[20]): Decimal;
    VAR
        WorkCenter: Record "Work Center";
        RoutingLine: Record "Routing Line";
        BatchSize: Decimal;
        SetupRunTime: Decimal;
        WorkCenterPrice: Decimal;
        Lotsize: Decimal;
    BEGIN
        WorkCenter.GET(WorkCenterNo);
        IF WorkCenter."Unit Cost" = 0 THEN
            EXIT(0);

        RoutingLine.RESET;
        //HEI.04>>
        RoutingLine.SETCURRENTKEY("Routing No.", "Version Code", "No.");
        //HEI.04<<
        RoutingLine.SETRANGE("Routing No.", GetRoutingCode(ParentItemNo, LocationCode));
        //HEI.04>>
        RoutingLine.SETRANGE("Version Code", '');
        //HEI.04<<
        RoutingLine.SETRANGE("No.", WorkCenter."No.");
        //HEI.04>>
        //RoutingLine.CALCFIELDS(RoutingLine."Version Active");
        //RoutingLine.SETRANGE(RoutingLine."Version Active",TRUE);
        //HEI.04<<
        //RoutingLine.SETRANGE("Version Code",'DEFAULT');
        IF RoutingLine.FINDFIRST THEN BEGIN
            BatchSize := RoutingLine."Batch Size FND";
            IF BatchSize = 0 THEN
                BatchSize := 1;
            Lotsize := RoutingLine."Lot Size";
            IF Lotsize = 0 THEN
                Lotsize := 1;

            IF RoutingLine."Setup Time" <> 0 THEN BEGIN
                SetupRunTime := RoutingLine."Setup Time";
                WorkCenterPrice := (SetupRunTime * WorkCenter."Unit Cost") / BatchSize;
                EXIT(WorkCenterPrice);
            END;

            IF RoutingLine."Run Time" <> 0 THEN BEGIN
                SetupRunTime := RoutingLine."Run Time";
                WorkCenterPrice := ((SetupRunTime / Lotsize) * WorkCenter."Unit Cost") / BatchSize;
                EXIT(WorkCenterPrice);
            END;
        END;

        EXIT(0);
    END;

    LOCAL PROCEDURE GetCostPerItemComponent(ItemComponentPrice: Decimal; QtyPerParent: Decimal): Decimal;
    BEGIN
        EXIT(ItemComponentPrice * QtyPerParent);
    END;

    LOCAL PROCEDURE GetCostPerWorkCenterComponent(WorkCenterComponentPrice: Decimal; QtyPerParent: Decimal): Decimal;
    BEGIN
        EXIT(WorkCenterComponentPrice * QtyPerParent);
    END;

    LOCAL PROCEDURE InsertStandardCostToBuffer(ItemNo: Code[20]; LocationCode: Code[20]; NewStandardCost: Decimal);
    BEGIN
        IF NOT TempDimensionCodeAmountBuffer.GET(ItemNo, LocationCode) THEN BEGIN
            TempDimensionCodeAmountBuffer.INIT;
            TempDimensionCodeAmountBuffer."Line Code" := ItemNo;
            TempDimensionCodeAmountBuffer."Column Code" := LocationCode;
            TempDimensionCodeAmountBuffer.Amount := NewStandardCost;
            TempDimensionCodeAmountBuffer.INSERT;
        END;

        //tb sa verific daca existra deja cost daca nu sa inserez
        //insa o dunctie de getcompcost
    END;

    LOCAL PROCEDURE GetRoutingCode(ItemNo: Code[20]; LocationCode: Code[20]): Code[20];
    VAR
        Routingcode: Code[20];
        //  StockkeepingUnit : Record 5700;
        Item: record Item;
    BEGIN
        //Routingcode := COPYSTR(ItemNo,3,STRLEN(ItemNo));
        //Routingcode := '0T' + Routingcode;
        //HEI.04>>
        Item.RESET;
        //HEI.04<<
        Item.GET(ItemNo);
        EXIT(Item."Routing No.");
    END;

    LOCAL PROCEDURE CheckIfStandarCodeAlreadyExist(ItemNo: Code[20]; LocationCode: Code[20]): Decimal;
    BEGIN
        TempDimensionCodeAmountBuffer.GET(ItemNo, LocationCode);
        EXIT(TempDimensionCodeAmountBuffer.Amount);
    END;

    LOCAL PROCEDURE InsertStandardCostIntoJournal();
    VAR
        StandardCostWorksheet: Record "Standard Cost Worksheet";
        ItemG: Record Item;
    BEGIN
        TempDimensionCodeAmountBuffer.RESET;
        IF TempDimensionCodeAmountBuffer.FINDSET THEN
            REPEAT
                //HEI.01>>
                RoutingExist := FALSE;
                BOMExist := FALSE;
                //HEI.04>>
                CLEAR(RoutingNo);
                CLEAR(BOM);
                //HEI.04<<
                IF ItemG.GET(TempDimensionCodeAmountBuffer."Line Code") THEN BEGIN
                    // RoutingNo := ItemG."Production BOM No.";
                    // BOM := ItemG."Routing No.";
                    RoutingNo := ItemG."Routing No.";
                    BOM := ItemG."Production BOM No.";
                    //HEI.04>>
                    //  {
                    // StockKeepingUnit.RESET;
                    //         //HEI.04<<
                    //         StockKeepingUnit.SETRANGE("Item No.", Item."No.");
                    //         StockKeepingUnit.SETRANGE("Location Code", TempDimensionCodeAmountBuffer."Column Code");
                    //         IF StockKeepingUnit.FINDFIRST THEN BEGIN
                    //             RoutingNo := StockKeepingUnit."Routing No.";
                    //             BOM := StockKeepingUnit."Production BOM No.";
                    //         END; //ELSE
                    //  }
                    //ERROR('There is not any Active Routing / BOM version %1' );
                    //HEI.04>>
                    RoutingVersion.RESET;
                    //HEI.04<<
                    RoutingVersion.SETRANGE("Routing No.", RoutingNo);
                    //HEI.04>>
                    //RoutingVersion.SETRANGE(Active,TRUE);
                    //HEI.04<<
                    IF RoutingVersion.FINDFIRST THEN
                        RoutingExist := TRUE
                    ELSE
                        RoutingExist := FALSE;
                    //HEI.04>>
                    ProductionBOMVersion.RESET;
                    //HEI.04<<
                    ProductionBOMVersion.SETRANGE("Production BOM No.", BOM);
                    //HEI.04>>
                    //ProductionBOMVersion.SETRANGE(Active,TRUE);
                    //HEI.04<<
                    IF ProductionBOMVersion.FINDFIRST THEN
                        BOMExist := TRUE
                    ELSE
                        BOMExist := FALSE;
                END;
                IF RoutingExist AND BOMExist THEN BEGIN
                    //HEI.01<<
                    StandardCostWorksheet.INIT;
                    StandardCostWorksheet."Standard Cost Worksheet Name" := StandardCostWorksheetName;
                    StandardCostWorksheet.Type := StandardCostWorksheet.Type::Item;
                    //HEI.02>>
                    //StandardCostWorksheet."No." := TempDimensionCodeAmountBuffer."Line Code";
                    StandardCostWorksheet.VALIDATE("No.", TempDimensionCodeAmountBuffer."Line Code");
                    //HEI.02<<
                    //  StandardCostWorksheet."Location Code" := TempDimensionCodeAmountBuffer."Column Code"; //BC Upgrade GUNREM01 commented field not availabe in BC Standard
                    //HEI.02>>
                    //StandardCostWorksheet."New Standard Cost" := TempDimensionCodeAmountBuffer.Amount;
                    StandardCostWorksheet.VALIDATE("New Standard Cost", TempDimensionCodeAmountBuffer.Amount);
                    //HEI.02<<
                    StandardCostWorksheet.INSERT;
                    ExistEntries := TRUE;
                    //HEI.01>>
                END
                ELSE
                    ERROR('There is no Active Routing / BOM version for Item %1', TempDimensionCodeAmountBuffer."Line Code");
            //HEI.01<<

            UNTIL TempDimensionCodeAmountBuffer.NEXT = 0;
    END;

    LOCAL PROCEDURE GetItemComponentBasePrice(ItemNo: Code[20]; UoM: Code[10]): Decimal;
    VAR
        BasePriceL: Record "Base Price STD Cost Calc. FND";
    BEGIN
        //HEI.03>>
        BasePriceL.SETRANGE("Item No.", ItemNo);
        BasePriceL.SETFILTER("Unit of Measure Code", '%1|%2', UoM, '');
        IF BasePriceL.FINDLAST THEN
            EXIT(BasePriceL."Direct Unit Cost");

        EXIT(0);
        //HEI.03<<
    END;
    //BC Upgrade GUNREM01 >>

    // LOCAL PROCEDURE GetItemStandardCost(ItemNo: Code[20]; UoM: Code[10]): Decimal;
    // VAR
    //     Item: Record Item;
    // BEGIN
    //     IF Item.GET(ItemNo) THEN
    //         EXIT(Item."Standard Cost");

    //     EXIT(0);
    // END;

    // LOCAL PROCEDURE GetItemCost(ItemNo: Code[20]; LocationCode: Code[20]): Decimal;
    // VAR
    //     Item: Record Item;
    // BEGIN
    //     // If already calculated in buffer → use it (roll-up)
    //     IF TempDimensionCodeAmountBuffer.GET(ItemNo, LocationCode) THEN
    //         EXIT(TempDimensionCodeAmountBuffer.Amount);

    //     // Else fallback to standard cost
    //     IF Item.GET(ItemNo) THEN
    //         EXIT(Item."Standard Cost");

    //     EXIT(0);
    // END;
    // //BC Upgrade GUNREM01 <<
}
