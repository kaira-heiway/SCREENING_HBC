report 51024 "Implement Standard Cost CBN"
{
    // version HEI.01

    // HEI.01 RFC-CHG0257267 IBM.SS 17.01.2019
    //   code added InsertStandardCostToBuffer function
    // HEI.02 CHG2079789 IBM POENAB02 19.08.2020 # LRE & DRC -Defect fix for #5640 and 5898
    //   When using Implementing standard cost in standard cost worksheet fields are not filled correctly
    //   Modified function InsertStandardCostIntoJournal
    // HEI.03 CHG2090557 IBM.LS      06.08.2021
    //   # Added Code
    // HEI.04 CHG2135085 SAHAL01      22.03.2022
    //   # Added and Commented Code to calculate cost on blank Version Code
    // BC Upgrade BHARDA11 >>
    // 1. Old REport ID - 50094.
    // 2. Add ApplicationArea property in Report and requestpage field.
    // 3. Create Variables HeanikenBCUpgrade: Codeunit "Heineken BC Upgrade",HeinkiBCCustomFunctionCU: Codeunit "Heineken BC Custom Functions"
    // 4. Change CalcBOMTree to HeanikenBCUpgrade and HeinkiBCCustomFunctionCU.
    // 5. Remove Drink-IT Field("Location Code").
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Implement Standard Cost';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Stockkeeping Unit"; "Stockkeeping Unit")
        {
            DataItemTableView = SORTING("Location Code", "Item No.", "Variant Code") WHERE("Replenishment System" = FILTER("Prod. Order"));
            RequestFilterFields = "Item No.", "Location Code";

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
                "Stockkeeping Unit".TESTFIELD("Stockkeeping Unit"."Replenishment System", "Stockkeeping Unit"."Replenishment System"::"Prod. Order");
                BOMBuffer.RESET;
                BOMBuffer.DELETEALL;
                TempBomBuffer.RESET;
                TempBomBuffer.DELETEALL;
                //TempDimensionCodeAmountBuffer.RESET;
                //TempDimensionCodeAmountBuffer.DELETEALL;
                if not TempDimensionCodeAmountBuffer.GET("Stockkeeping Unit"."Item No.", "Stockkeeping Unit"."Location Code") then begin
                    InitBomBufferSKU("Item No.", "Stockkeeping Unit", BOMBuffer);

                    BOMBuffer.RESET;
                    if BOMBuffer.FINDSET then
                        repeat
                            TempBomBuffer := BOMBuffer;
                            TempBomBuffer.INSERT;
                            LastEntryNo := BOMBuffer."Entry No.";
                        until BOMBuffer.NEXT = 0;

                    BOMBuffer.RESET;
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

                    BOMBuffer.RESET;
                    BOMBuffer.DELETEALL;

                    TempBomBuffer.RESET;
                    if TempBomBuffer.FINDSET then
                        repeat
                            BOMBuffer := TempBomBuffer;
                            BOMBuffer.INSERT;
                        until TempBomBuffer.NEXT = 0;

                    TempBomBuffer.RESET;
                    TempBomBuffer.SETCURRENTKEY("Parent Entry No. FND");
                    TempBomBuffer.SETASCENDING("Parent Entry No. FND", false);
                    TempBomBuffer.SETRANGE("Replenishment System", TempBomBuffer."Replenishment System"::"Prod. Order");
                    if TempBomBuffer.FINDSET then
                        repeat
                            CLEAR(SemiFinishedStandardCost);
                            CLEAR(WorkCenterStandardCost);
                            BOMBuffer.RESET;
                            BOMBuffer.SETRANGE("Parent Entry No. FND", TempBomBuffer."Entry No.");
                            if BOMBuffer.FINDSET then
                                repeat
                                    case BOMBuffer."Replenishment System" of
                                        BOMBuffer."Replenishment System"::"Prod. Order":
                                            begin
                                                SemiFinishedStandardCost += GetCostPerItemComponent(CheckIfStandarCodeAlreadyExist(BOMBuffer."No.", "Stockkeeping Unit"."Location Code"), BOMBuffer."Qty. per Parent");
                                            end else begin
                                            case BOMBuffer.Type of
                                                BOMBuffer.Type::Item:
                                                    begin
                                                        //HEI.03>>
                                                        //SemiFinishedStandardCost += GetCostPerItemComponent(GetItemComponentPrice(BOMBuffer."No.",BOMBuffer."Unit of Measure Code"),BOMBuffer."Qty. per Parent");
                                                        SemiFinishedStandardCost += GetCostPerItemComponent(GetItemComponentBasePrice(BOMBuffer."No.", BOMBuffer."Unit of Measure Code"), BOMBuffer."Qty. per Parent");
                                                        //HEI.03<<
                                                    end;
                                                BOMBuffer.Type::"Work Center":
                                                    begin
                                                        WorkCenterStandardCost += GetCostPerWorkCenterComponent(GetWorkCenterComponentPrice(BOMBuffer."No.", TempBomBuffer."No.", "Stockkeeping Unit"."Location Code"), 1);
                                                    end;
                                            end;
                                        end;
                                    end;
                                until BOMBuffer.NEXT = 0;
                            InsertStandardCostToBuffer(TempBomBuffer."No.", "Stockkeeping Unit"."Location Code", SemiFinishedStandardCost + WorkCenterStandardCost);
                        until TempBomBuffer.NEXT = 0;


                end;
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

    var
        Text000: Label 'Could not find items with BOM levels.';
        Text001: Label 'The new standard cost has been implemented.Check Standard Cost Worksheet %1!';
        Text002: Label '%1 must have a value!';
        Text003: Label 'There are already some entries into Standard Code Worksheet Batch %1.Do you want to delete them?';
        Text004: Label 'There is no purchase price setup for item no. %1.Please setup it an try again!';
        TempDimensionCodeAmountBuffer: Record "Dimension Code Amount Buffer" temporary;
        StandardCostWorksheetName: Code[20];
        Text005: Label 'Standard cost worksheet name cannot be blank!';
        ExistEntries: Boolean;
        Item: Record Item;
        StockKeepingUnit: Record "Stockkeeping Unit";
        RoutingVersion: Record "Routing Version";
        ProductionBOMVersion: Record "Production BOM Version";
        RoutingNo: Code[20];
        BOM: Code[20];
        RoutingExist: Boolean;
        BOMExist: Boolean;
        StandardCostWorksheet: Record "Standard Cost Worksheet";

    local procedure InitBomBufferSKU(ItemFilter: Code[20]; StockkeepingUnit: Record "Stockkeeping Unit"; var BOMBuffer: Record "BOM Buffer");
    var
        CalcBOMTree: Codeunit "Calculate BOM Tree";
        Item: Record Item;
        HeanikenBCUpgrade: Codeunit "Heineken BC Upgrade"; // BC Upgrade BHARDA11 
        HeinkiBCCustomFunctionCU: Codeunit "Heineken BC Custom Functions";//BC Upgrade BHARDA11 
    begin
        //HEI.01>>
        BOMBuffer.DELETEALL;
        Item.SETFILTER("No.", ItemFilter);
        Item.FINDFIRST;
        CalcBOMTree.SetItemFilter(Item);
        if (not StockkeepingUnit.HasBOM) and (StockkeepingUnit."Routing No." = '') then
            ERROR(Text000);
        HeanikenBCUpgrade.SetRunParam(true); // CalcBOMTree.SetRunParam(true); // BC Upgrade BHARDA11 ----Change CalcBOMTree to HeanikenBCUpgrade
        //HEI.04>>
        HeanikenBCUpgrade.ActivateBlankVersionCode(true); //CalcBOMTree.ActivateBlankVersionCode(true); // BC Upgrade BHARDA11 ----Change CalcBOMTree to HeanikenBCUpgrade
                                                          //HEI.04<<
        HeinkiBCCustomFunctionCU.GenerateTreeForItemsSKU(Item, BOMBuffer, 0, StockkeepingUnit."Location Code", StockkeepingUnit."Variant Code");// CalcBOMTree.GenerateTreeForItemsSKU(Item, BOMBuffer, 0, StockkeepingUnit."Location Code", StockkeepingUnit."Variant Code"); // BC Upgrade BHARDA11 ----Change CalcBOMTree to HeinkiBCCustomFunctionCU
        //HEI.01<<
    end;

    local procedure GetItemComponentPrice(ItemNo: Code[20]; Uom: Code[10]): Decimal;
    var
        PurchasePrice: Record "Purchase Price";
    begin
        PurchasePrice.RESET;
        PurchasePrice.SETRANGE("Item No.", ItemNo);
        PurchasePrice.SETFILTER("Unit of Measure Code", '%1|%2', Uom, '');
        if PurchasePrice.FINDLAST then
            exit(PurchasePrice."Direct Unit Cost");

        exit(0);
        //ELSE
        //  ERROR(Text004,ItemNo);
    end;

    local procedure GetWorkCenterComponentPrice(WorkCenterNo: Code[20]; ParentItemNo: Code[20]; LocationCode: Code[20]): Decimal;
    var
        WorkCenter: Record "Work Center";
        RoutingLine: Record "Routing Line";
        BatchSize: Decimal;
        SetupRunTime: Decimal;
        WorkCenterPrice: Decimal;
        Lotsize: Decimal;
    begin
        WorkCenter.GET(WorkCenterNo);
        if WorkCenter."Unit Cost" = 0 then
            exit(0);

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
        if RoutingLine.FINDFIRST then begin
            BatchSize := RoutingLine."Batch Size FND";
            if BatchSize = 0 then
                BatchSize := 1;
            Lotsize := RoutingLine."Lot Size";
            if Lotsize = 0 then
                Lotsize := 1;

            if RoutingLine."Setup Time" <> 0 then begin
                SetupRunTime := RoutingLine."Setup Time";
                WorkCenterPrice := (SetupRunTime * WorkCenter."Unit Cost") / BatchSize;
                exit(WorkCenterPrice);
            end;

            if RoutingLine."Run Time" <> 0 then begin
                SetupRunTime := RoutingLine."Run Time";
                WorkCenterPrice := ((SetupRunTime / Lotsize) * WorkCenter."Unit Cost") / BatchSize;
                exit(WorkCenterPrice);
            end;
        end;

        exit(0);
    end;

    local procedure GetCostPerItemComponent(ItemComponentPrice: Decimal; QtyPerParent: Decimal): Decimal;
    begin
        exit(ItemComponentPrice * QtyPerParent);
    end;

    local procedure GetCostPerWorkCenterComponent(WorkCenterComponentPrice: Decimal; QtyPerParent: Decimal): Decimal;
    begin
        exit(WorkCenterComponentPrice * QtyPerParent);
    end;

    local procedure InsertStandardCostToBuffer(ItemNo: Code[20]; LocationCode: Code[20]; NewStandardCost: Decimal);
    begin
        if not TempDimensionCodeAmountBuffer.GET(ItemNo, LocationCode) then begin
            TempDimensionCodeAmountBuffer.INIT;
            TempDimensionCodeAmountBuffer."Line Code" := ItemNo;
            TempDimensionCodeAmountBuffer."Column Code" := LocationCode;
            TempDimensionCodeAmountBuffer.Amount := NewStandardCost;
            TempDimensionCodeAmountBuffer.INSERT;
        end;

        //tb sa verific daca existra deja cost daca nu sa inserez
        //insa o dunctie de getcompcost
    end;

    local procedure GetRoutingCode(ItemNo: Code[20]; LocationCode: Code[20]): Code[20];
    var
        Routingcode: Code[20];
        StockkeepingUnit: Record "Stockkeeping Unit";
    begin
        //Routingcode := COPYSTR(ItemNo,3,STRLEN(ItemNo));
        //Routingcode := '0T' + Routingcode;
        //HEI.04>>
        StockkeepingUnit.RESET;
        //HEI.04<<
        StockkeepingUnit.GET(LocationCode, ItemNo, '');
        exit(StockkeepingUnit."Routing No.");
    end;

    local procedure CheckIfStandarCodeAlreadyExist(ItemNo: Code[20]; LocationCode: Code[20]): Decimal;
    begin
        TempDimensionCodeAmountBuffer.GET(ItemNo, LocationCode);
        exit(TempDimensionCodeAmountBuffer.Amount);
    end;

    local procedure InsertStandardCostIntoJournal();
    var
        StandardCostWorksheet: Record "Standard Cost Worksheet";
        RoutingHeaderL: Record "Routing Header";
        ProdBOMHeaderL: Record "Production BOM Header";
        Text001L: Label 'Routing No. %1 is not Certified.';
        Text002L: Label 'BOM %1 is not Certified.';
    begin
        TempDimensionCodeAmountBuffer.RESET;
        if TempDimensionCodeAmountBuffer.FINDSET then
            repeat
                //HEI.01>>
                RoutingExist := false;
                BOMExist := false;
                //HEI.04>>
                CLEAR(RoutingNo);
                CLEAR(BOM);
                //HEI.04<<
                if Item.GET(TempDimensionCodeAmountBuffer."Line Code") then begin
                    //HEI.04>>
                    StockKeepingUnit.RESET;
                    //HEI.04<<
                    StockKeepingUnit.SETRANGE("Item No.", Item."No.");
                    StockKeepingUnit.SETRANGE("Location Code", TempDimensionCodeAmountBuffer."Column Code");
                    if StockKeepingUnit.FINDFIRST then begin
                        RoutingNo := StockKeepingUnit."Routing No.";
                        BOM := StockKeepingUnit."Production BOM No.";
                    end; //ELSE
                         //ERROR('There is not any Active Routing / BOM version %1' );
                         //HEI.04>>
                    RoutingVersion.RESET;
                    //HEI.04<<
                    RoutingVersion.SETRANGE("Routing No.", RoutingNo);
                    //HEI.04>>
                    //RoutingVersion.SETRANGE(Active,TRUE);
                    //HEI.04<<
                    if RoutingVersion.FINDFIRST then
                        RoutingExist := true
                    else
                        RoutingExist := false;
                    //HEI.04>>
                    ProductionBOMVersion.RESET;
                    //HEI.04<<
                    ProductionBOMVersion.SETRANGE("Production BOM No.", BOM);
                    //HEI.04>>
                    //ProductionBOMVersion.SETRANGE(Active,TRUE);
                    //HEI.04<<
                    if ProductionBOMVersion.FINDFIRST then
                        BOMExist := true
                    else
                        BOMExist := false;
                end;
                if RoutingExist and BOMExist then begin
                    //HEI.04>>
                    RoutingHeaderL.RESET;
                    RoutingHeaderL.SETRANGE("No.", RoutingNo);
                    RoutingHeaderL.SETRANGE(Status, RoutingHeaderL.Status::Certified);
                    if RoutingHeaderL.ISEMPTY then
                        ERROR(Text001L, RoutingNo);

                    ProdBOMHeaderL.RESET;
                    ProdBOMHeaderL.SETRANGE("No.", BOM);
                    ProdBOMHeaderL.SETRANGE(Status, ProdBOMHeaderL.Status::Certified);
                    if ProdBOMHeaderL.ISEMPTY then
                        ERROR(Text002L, BOM);
                    //HEI.04<<
                    //HEI.01<<
                    StandardCostWorksheet.INIT;
                    StandardCostWorksheet."Standard Cost Worksheet Name" := StandardCostWorksheetName;
                    StandardCostWorksheet.Type := StandardCostWorksheet.Type::Item;
                    //HEI.02>>
                    //StandardCostWorksheet."No." := TempDimensionCodeAmountBuffer."Line Code";
                    StandardCostWorksheet.VALIDATE("No.", TempDimensionCodeAmountBuffer."Line Code");
                    //HEI.02<<
                    // StandardCostWorksheet."Location Code" := TempDimensionCodeAmountBuffer."Column Code"; // BC Upgrade BHARDA11 ----Drink-IT Field("Location Code")
                    //HEI.02>>
                    //StandardCostWorksheet."New Standard Cost" := TempDimensionCodeAmountBuffer.Amount;
                    StandardCostWorksheet.VALIDATE("New Standard Cost", TempDimensionCodeAmountBuffer.Amount);
                    //HEI.02<<
                    StandardCostWorksheet.INSERT;
                    ExistEntries := true;
                    //HEI.01>>
                end
                else
                    ERROR('There is no Active Routing / BOM version for Item %1', TempDimensionCodeAmountBuffer."Line Code");
            //HEI.01<<

            until TempDimensionCodeAmountBuffer.NEXT = 0;
    end;

    local procedure GetItemComponentBasePrice(ItemNo: Code[20]; UoM: Code[10]): Decimal;
    var
        BasePriceL: Record "Base Price STD Cost Calc. FND";
    begin
        //HEI.03>>
        BasePriceL.SETRANGE("Item No.", ItemNo);
        BasePriceL.SETFILTER("Unit of Measure Code", '%1|%2', UoM, '');
        if BasePriceL.FINDLAST then
            exit(BasePriceL."Direct Unit Cost");

        exit(0);
        //HEI.03<<
    end;
}

