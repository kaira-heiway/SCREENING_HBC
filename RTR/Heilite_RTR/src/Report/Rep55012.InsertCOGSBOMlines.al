report 55012 "Insert COGS BOM lines"
{
    // version HEI.06

    // HEI.01 CHG2132673 IBM BULIMC01 08/04/2022#COGS Allocation - new report created to insert all the BOM items in COGS Allocation
    // HEI.02 CHG2135085 SAHAL01      19.04.2022
    //   # Added Code to split the cost for Energy & Water, Other Variable Expenses and Production Fix Expenses
    // 
    // HEI.03 INC4159847/CHG2164634 IBM GOKULS01 04/07/2022 # COGS Allocation
    //   # Code changed to update Production BOM Not updating for SFG.
    // 
    // HEI.04 INC4159847/CHG2164634 IBM GOKULS01 11/07/2022 # COGS Allocation
    //   # Code changed to update Cost Prod. Fix. Exp. BuOM value.
    // 
    // HEI.05 CHG2174808 IBM GOKULS01 28/09/2022 # COGS Allocation
    //   # Code changed to update "Prod. BOM header in HL" value.
    // 
    // HEI.06 CHG2177155 DEBUSD01 13.10.2022 #COGS allocation report
    //   # Code changed to update "Prod. BOM header in HL" value.

    // BC Upgrade POENAB02: Original (HeiLite) report id 50556

    //PATHAA02 04.04.26 #FDD-COGS-[PID803,FDD-DTW-022,IBM GAP DTW54]
    //Code added
    //Bc Upgrade YADAVM09 Bug fix BCUP0153.

    CaptionML = ENU = 'Insert COGS BOM lines',
                FRA = 'Nomenclature multi-niveau';

    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Search Description", "Inventory Posting Group";
            dataitem(StockkeepingUnitLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(BOMLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    dataitem("Integer"; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        MaxIteration = 1;

                        trigger OnPostDataItem();
                        begin
                            Level := NextLevel;
                        end;
                    }

                    trigger OnAfterGetRecord();
                    var
                        BomItem: Record Item;
                    begin
                        while BomComponent[Level].Next() = 0 do begin
                            Level := Level - 1;
                            if Level < 1 then
                                CurrReport.Break();
                        end;

                        NextLevel := Level;
                        Clear(CompItem);
                        QtyPerUnitOfMeasure := 1;
                        case BomComponent[Level].Type of
                            BomComponent[Level].Type::Item:
                                begin
                                    CompSKU.Reset();//HEI.03
                                    Clear(CompSKU);//HEI.03
                                    CompSKU.SetRange(CompSKU."Item No.", BomComponent[Level]."No.");
                                    CompSKU.SetRange("Replenishment System", CompSKU."Replenishment System"::"Prod. Order");//HEI.03
                                    CompSKU.SetFilter("Production BOM No.", '<>%1', '');//HEI.03
                                                                                        //CompSKU.SetRange(CompSKU."Location Code",LocationCode);
                                    if CompSKU.FindSet() then begin
                                        if CompSKU."Production BOM No." <> '' then
                                            ProdBOM.Get(CompSKU."Production BOM No.");
                                        CompItem."Production BOM No." := CompSKU."Production BOM No.";
                                    end;
                                    if ProdBOM.Status = ProdBOM.Status::Closed then
                                        CurrReport.Skip();
                                    NextLevel := Level + 1;
                                    if Level > 1 then
                                        if (NextLevel > 50) or (BomComponent[Level]."No." = NoList[Level - 1]) then
                                            Error(ProdBomErr, 50, Item."No.", NoList[Level], Level);
                                    Clear(BomComponent[NextLevel]);
                                    NoListType[NextLevel] := NoListType[NextLevel] ::Item;
                                    NoList[NextLevel] := CompItem."No.";
                                    BomComponent[NextLevel].SetRange("Production BOM No.", CompItem."Production BOM No.");
                                    BomComponent[NextLevel].SetRange("Version Code", '');
                                    BomComponent[NextLevel].SetFilter("Starting Date", '%1|..%2', 0D, StartingDate);
                                    BomComponent[NextLevel].SetFilter("Ending Date", '%1|%2..', 0D, EndingDate);

                                end;
                            BomComponent[Level].Type::"Production BOM":
                                begin
                                    ProdBOM.Get(BomComponent[Level]."No.");
                                    if ProdBOM.Status = ProdBOM.Status::Closed then
                                        CurrReport.Skip();
                                    NextLevel := Level + 1;
                                    if Level > 1 then
                                        if (NextLevel > 50) or (BomComponent[Level]."No." = NoList[Level - 1]) then
                                            Error(ProdBomErr, 50, Item."No.", NoList[Level], Level);
                                    Clear(BomComponent[NextLevel]);
                                    NoListType[NextLevel] := NoListType[NextLevel] ::"Production BOM";
                                    NoList[NextLevel] := ProdBOM."No.";
                                    BomComponent[NextLevel].SetRange("Production BOM No.", NoList[NextLevel]);
                                    BomComponent[NextLevel].SetRange("Version Code", '');
                                    BomComponent[NextLevel].SetFilter("Starting Date", '%1|..%2', 0D, StartingDate);
                                    BomComponent[NextLevel].SetFilter("Ending Date", '%1|%2..', 0D, EndingDate);
                                end;
                        end;

                        if Level > 1 then
                            InsertCOGSAllocationLine(BomComponent[Level - 1]."No.", Level, BomComponent[Level])
                        else
                            InsertCOGSAllocationLine(ItemNo, Level, BomComponent[Level]);
                    end;

                    trigger OnPreDataItem();
                    begin
                        Level := 1;

                        ProdBOM.GET(StockkeepingUnit."Production BOM No.");
                        Item."Production BOM No." := StockkeepingUnit."Production BOM No.";

                        Clear(BomComponent);
                        BomComponent[Level]."Production BOM No." := Item."Production BOM No.";
                        BomComponent[Level].SetRange("Production BOM No.", Item."Production BOM No.");
                        //BomComponent[Level].SetRange("Location Code",LocationCode);
                        BomComponent[Level].SetRange("Version Code", '');
                        BomComponent[Level].SetFilter("Starting Date", '%1|..%2', 0D, StartingDate);
                        BomComponent[Level].SetFilter("Ending Date", '%1|%2..', 0D, EndingDate);
                        NoListType[Level] := NoListType[Level] ::Item;
                        NoList[Level] := Item."No.";
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if Number = 1 then
                        StockkeepingUnit.FindFirst()
                    else
                        StockkeepingUnit.Next();
                end;

                trigger OnPreDataItem();
                begin
                    //SETRANGE(Number,1,StockkeepingUnit.COUNT);//HEI.03
                    SetRange(Number, 1);//HEI.03
                end;
            }

            trigger OnAfterGetRecord();
            begin
                StockkeepingUnit.Reset();
                StockkeepingUnit.SetRange("Item No.", ItemNo);
                //StockkeepingUnit.SetRange("Location Code",LocationCode);
                StockkeepingUnit.SetRange("Variant Code", '');
                StockkeepingUnit.SetFilter("Production BOM No.", '<>%1', '');
            end;

            trigger OnPreDataItem();
            begin
                Item.SetFilter("No.", ItemNo);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        InventorySetup.Get();
        GLSetup.Get();
    end;

    var
        ProdBOM: Record "Production BOM Header";
        BomComponent: array[99] of Record "Production BOM Line";
        CompItem: Record Item;
        UOMMgt: Codeunit "Unit of Measure Management";
        VersionMgt: Codeunit VersionManagement;
        EndingDate: Date;
        NoList: array[99] of Code[20];
        VersionCode: array[99] of Code[20];
        Quantity: array[99] of Decimal;
        QtyPerUnitOfMeasure: Decimal;
        Level: Integer;
        NextLevel: Integer;
        BOMQty: Decimal;
        NoListType: array[99] of Option " ",Item,"Production BOM";
        LocationCode: Code[10];
        StockkeepingUnit: Record "Stockkeeping Unit";
        CompSKU: Record "Stockkeeping Unit";
        Text000: Label '"As of "';
        QtyExplosionofBOMCaptLbl: Label 'Quantity Explosion of BOM';
        CurrReportPageNoCaptLbl: Label 'Page';
        BOMQtyCaptionLbl: Label 'Total Quantity Base UoM';
        BomCompLevelQtyCaptLbl: Label 'BOM Quantity';
        BomCompLevelDescCaptLbl: Label 'Description';
        BomCompLevelNoCaptLbl: Label 'No.';
        LevelCaptLbl: Label 'Level';
        BomCompLevelUOMCodeCaptLbl: Label 'UoM';
        ProdBomErr: Label 'The maximum number of BOM levels, %1, was exceeded. The process stopped at item number %2, BOM header number %3, BOM level %4.';
        LocationCodeCaptLbl: Label 'Location Code';
        VariantCodeCaptLbl: Label 'Variant Code';
        LocationCodeErr: Label 'You must fill the Location Code';
        BomCompLevelScrapLbl: Label 'Scrap %';
        BomCompLevelVersCodeLbl: Label 'BoM Version Code';
        ItemNo: Code[20];
        GLSetup: Record "General Ledger Setup";
        InventorySetup: Record "Inventory Setup";
        StartingDate: Date;

    procedure GetParameters(NewItem: Code[20]; NewStartDate: Date; NewEndDate: Date);
    begin
        ItemNo := NewItem;
        EndingDate := NewEndDate;
        StartingDate := NewStartDate;
    end;

    local procedure InsertCOGSAllocationLine(SubParentNo: Code[20]; Level: Integer; ProdBOMLine: Record "Production BOM Line");
    var
        Item: Record Item;
        Item2: Record Item;
        COGSAlloconSTDPriceLine: Record "COGS Alloc STD Price Line FND";
        ProductionBOMLine: Record "Production BOM Line";
        BasePriceSTDCostCalc: Record "Base Price STD Cost Calc. FND";
        RoutingLine: Record "Routing Line";
        WorkCenter: Record "Work Center";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        ProdBOMHeader: Record "Production BOM Header";
    begin
        //with COGSAlloconSTDPriceLine do begin // BC Upgrade POENAB02
        COGSAlloconSTDPriceLine.Init();

        COGSAlloconSTDPriceLine."Processing Date" := WorkDate();
        COGSAlloconSTDPriceLine.Company := CompanyName;
        COGSAlloconSTDPriceLine."Fiscal Year" := Date2DMY(EndingDate, 3);
        COGSAlloconSTDPriceLine."Period Number" := Date2DMY(EndingDate, 2);
        COGSAlloconSTDPriceLine."Production BOM No." := CompSKU."Production BOM No.";
        COGSAlloconSTDPriceLine."Parent Item No." := ItemNo;
        COGSAlloconSTDPriceLine."Sub-Parent Item No." := SubParentNo;
        COGSAlloconSTDPriceLine."Item No." := ProdBOMLine."No.";
        COGSAlloconSTDPriceLine."Item UoM" := ProdBOMLine."Unit of Measure Code";
        COGSAlloconSTDPriceLine."BOM Level" := Level;

        COGSAlloconSTDPriceLine.Quantity := ProdBOMLine.Quantity;
        COGSAlloconSTDPriceLine."Quantity per" := ProdBOMLine."Quantity per";
        COGSAlloconSTDPriceLine."Scrap %" := ProdBOMLine."Scrap %";
        if COGSAlloconSTDPriceLine."Scrap %" <> 0 then
            COGSAlloconSTDPriceLine."Qty. Including Scrap" := COGSAlloconSTDPriceLine.Quantity + (COGSAlloconSTDPriceLine."Scrap %" / 100) * COGSAlloconSTDPriceLine.Quantity
        else
            COGSAlloconSTDPriceLine."Qty. Including Scrap" := COGSAlloconSTDPriceLine.Quantity;

        if Item.Get(COGSAlloconSTDPriceLine."Item No.") then;//Bc Upgrade YADAVM09 BCUP0153<<
        COGSAlloconSTDPriceLine.Description := Item.Description;
        // BC Upgrade POENAB02 >>
        // code commented, as it is dependent on Aptean developments
        /* 
        "Unit Volume HL" := Item."Unit Volume HL";
        "Quantity HL" := Quantity * Item."Unit Volume HL"; 
        */
        // BC Upgrade POENAB02 <<

        //PATHAA02 04.04.26 >>
        COGSAlloconSTDPriceLine."Unit Volume HL" := Item."Unit Volume";
        COGSAlloconSTDPriceLine."Quantity HL" := COGSAlloconSTDPriceLine.Quantity * Item."Unit Volume";
        //PATHAA02 04.04.26<<

        COGSAlloconSTDPriceLine."Item Category Code" := Item."Item Category Code";

        //convert Item UoM to HL
        ProdBOMHeader.Reset();
        if ProdBOMHeader.Get(COGSAlloconSTDPriceLine."Production BOM No.") then
            COGSAlloconSTDPriceLine."Prod. BOM Header UoM" := ProdBOMHeader."Unit of Measure Code";
        ItemUnitofMeasure.Reset();
        if ItemUnitofMeasure.Get(COGSAlloconSTDPriceLine."Item No.", COGSAlloconSTDPriceLine."Prod. BOM Header UoM") then
            COGSAlloconSTDPriceLine."Prod. BOM Qty. per BUoM" := ItemUnitofMeasure."Qty. per Unit of Measure";
        //HEI.05>>
        //HEI.06>>
        //"Prod. BOM Header in HL" := "Prod. BOM Qty. per BUoM" * "Unit Volume HL";
        COGSAlloconSTDPriceLine."Prod. BOM Header in HL" := COGSAlloconSTDPriceLine."Prod. BOM Qty. per BUoM";
        //HEI.06<<
        //HEI.05<<

        CalcQtyperHL(COGSAlloconSTDPriceLine);

        //Routing info
        COGSAlloconSTDPriceLine."Routing No." := CompSKU."Routing No.";
        RoutingLine.Reset();
        RoutingLine.SetRange("Routing No.", COGSAlloconSTDPriceLine."Routing No.");
        RoutingLine.SetRange("Version Code", '');
        if RoutingLine.FindFirst() then begin
            COGSAlloconSTDPriceLine."Work Center No." := RoutingLine."Work Center No.";
            if RoutingLine."Setup Time" <> 0 then
                COGSAlloconSTDPriceLine."Setup Time" := RoutingLine."Setup Time"
            else
                COGSAlloconSTDPriceLine."Setup Time" := 1;
            if RoutingLine."Run Time" <> 0 then
                COGSAlloconSTDPriceLine."Run Time" := RoutingLine."Run Time"
            else
                COGSAlloconSTDPriceLine."Run Time" := 1;
            if RoutingLine."Batch Size FND" <> 0 then
                COGSAlloconSTDPriceLine."Batch Size" := RoutingLine."Batch Size FND"
            else
                COGSAlloconSTDPriceLine."Batch Size" := 1;
            if RoutingLine."Lot Size" <> 0 then
                COGSAlloconSTDPriceLine."Lot Size" := RoutingLine."Lot Size"
            else
                COGSAlloconSTDPriceLine."Lot Size" := 1;
        end;

        //Check Item Category
        Item2.Reset();
        Item2.SetRange("No.", COGSAlloconSTDPriceLine."Item No.");
        Item2.SetFilter("Item Category Code", InventorySetup."Raw Materials Item CatCode FND"); 
        if Item2.FindFirst() then
            COGSAlloconSTDPriceLine."COGS Allocation" := COGSAlloconSTDPriceLine."COGS Allocation"::"Raw Materials"
        else begin
            Item2.Reset();
            Item2.SetRange("No.", COGSAlloconSTDPriceLine."Item No.");
            Item2.SetFilter("Item Category Code", InventorySetup."Pack. Material ItemCatCode FND"); //BC Upgrade Kamnay01 //Bug fix 
            if Item2.FindFirst() then
                COGSAlloconSTDPriceLine."COGS Allocation" := COGSAlloconSTDPriceLine."COGS Allocation"::"Packaging Materials"
            else
                COGSAlloconSTDPriceLine."COGS Allocation" := COGSAlloconSTDPriceLine."COGS Allocation"::"Prod Fix Exp";
        end;

        //calculate costs

        //Unit Cost for both Raw&Pack and Prod Fix Exp
        if COGSAlloconSTDPriceLine."Work Center No." <> '' then begin
            WorkCenter.Get(COGSAlloconSTDPriceLine."Work Center No.");
            COGSAlloconSTDPriceLine."Unit Cost of Work Center" := WorkCenter."Direct Unit Cost";
        end;

        //Unit cost only for Raw&Pack
        if (COGSAlloconSTDPriceLine."COGS Allocation" = COGSAlloconSTDPriceLine."COGS Allocation"::"Packaging Materials") or (COGSAlloconSTDPriceLine."COGS Allocation" = COGSAlloconSTDPriceLine."COGS Allocation"::"Raw Materials") then begin
            BasePriceSTDCostCalc.Reset();
            BasePriceSTDCostCalc.SetRange("Item No.", COGSAlloconSTDPriceLine."Item No.");
            BasePriceSTDCostCalc.SetFilter("Starting Date", '%1|..%2', 0D, StartingDate);
            BasePriceSTDCostCalc.SetFilter("Ending Date", '%1|%2..', 0D, EndingDate);
            BasePriceSTDCostCalc.SetRange("Unit of Measure Code", COGSAlloconSTDPriceLine."Item UoM");
            if BasePriceSTDCostCalc.FindFirst() then begin
                COGSAlloconSTDPriceLine."Unit Cost Raw&Pack" := BasePriceSTDCostCalc."Direct Unit Cost";
                COGSAlloconSTDPriceLine."Cost Raw or Pack Mat." := COGSAlloconSTDPriceLine."Qty. per HL of FG" * COGSAlloconSTDPriceLine."Unit Cost Raw&Pack";
            end;
        end;

        if COGSAlloconSTDPriceLine."Work Center No." <> '' then begin
            //IF "Setup Time" <> 1 THEN //HEI.03 Not Required
            if COGSAlloconSTDPriceLine."Setup Time" <> 1 then  //HEI.04 code uncommented
                COGSAlloconSTDPriceLine."Cost Prod. Fix. Exp. BuOM" := COGSAlloconSTDPriceLine."Setup Time" * COGSAlloconSTDPriceLine."Unit Cost of Work Center" / COGSAlloconSTDPriceLine."Batch Size"
            //IF "Run Time" <> 1 THEN //HEI.03 Not required
            else //HEI.04 code modified
                COGSAlloconSTDPriceLine."Cost Prod. Fix. Exp. BuOM" := (COGSAlloconSTDPriceLine."Run Time" / COGSAlloconSTDPriceLine."Lot Size" * COGSAlloconSTDPriceLine."Unit Cost of Work Center") / COGSAlloconSTDPriceLine."Batch Size";
            if COGSAlloconSTDPriceLine."Parent Item No." = COGSAlloconSTDPriceLine."Item No." then begin
                if COGSAlloconSTDPriceLine."Unit Volume HL" <> 0 then
                    COGSAlloconSTDPriceLine."Cost. Prod. Fix. per HL of FG" := COGSAlloconSTDPriceLine."Cost Prod. Fix. Exp. BuOM" / COGSAlloconSTDPriceLine."Unit Volume HL";
            end else
                COGSAlloconSTDPriceLine."Cost. Prod. Fix. per HL of FG" := COGSAlloconSTDPriceLine."Cost Prod. Fix. Exp. BuOM" * COGSAlloconSTDPriceLine."Qty. per HL of FG";

            //HEI.02>>
            if WorkCenter."Direct Unit Cost" <> 0 then begin
                COGSAlloconSTDPriceLine."Cost Energy & Water" := ((WorkCenter."Estimated Energy FND" + WorkCenter."Estimated Water Consmp. FND") / WorkCenter."Direct Unit Cost") * COGSAlloconSTDPriceLine."Cost. Prod. Fix. per HL of FG";
                COGSAlloconSTDPriceLine."Cost Other Variable Exp." := (WorkCenter."Other Variable Expenses FND" / WorkCenter."Direct Unit Cost") * COGSAlloconSTDPriceLine."Cost. Prod. Fix. per HL of FG";
                COGSAlloconSTDPriceLine."Cost. Prod. Fix. per HL of FG" := (WorkCenter."Production Fix Expenses FND" / WorkCenter."Direct Unit Cost") * COGSAlloconSTDPriceLine."Cost. Prod. Fix. per HL of FG";
            end;
            //HEI.02<<

        end;

        COGSAlloconSTDPriceLine.Insert();
        //end; // BC Upgrade POENAB02
    end;

    local procedure CalcQtyperHL(var COGSAllocSTDPriceLine: Record "COGS Alloc STD Price Line FND");
    var
        COGSAlloconSTDPriceLine2: Record "COGS Alloc STD Price Line FND";
    begin
        if COGSAllocSTDPriceLine."BOM Level" = 0 then
            COGSAllocSTDPriceLine."Qty. per HL of FG" := 1
        else begin
            COGSAlloconSTDPriceLine2.Reset();
            COGSAlloconSTDPriceLine2.SetCurrentKey(Company, "Fiscal Year", "Period Number", "Parent Item No.");
            COGSAlloconSTDPriceLine2.SetRange(Company, COGSAllocSTDPriceLine.Company);
            COGSAlloconSTDPriceLine2.SetRange("Fiscal Year", COGSAllocSTDPriceLine."Fiscal Year");
            COGSAlloconSTDPriceLine2.SetRange("Period Number", COGSAllocSTDPriceLine."Period Number");
            COGSAlloconSTDPriceLine2.SetRange("Parent Item No.", COGSAllocSTDPriceLine."Parent Item No.");
            COGSAlloconSTDPriceLine2.SetRange("Item No.", COGSAllocSTDPriceLine."Sub-Parent Item No.");
            COGSAlloconSTDPriceLine2.SetRange("BOM Level", COGSAllocSTDPriceLine."BOM Level" - 1);
            if COGSAlloconSTDPriceLine2.FindFirst() then begin
                if COGSAlloconSTDPriceLine2."Prod. BOM Header in HL" <> 0 then
                    COGSAllocSTDPriceLine."Qty. per HL of FG" := COGSAllocSTDPriceLine."Qty. Including Scrap" * COGSAlloconSTDPriceLine2."Qty. per HL of FG" / COGSAlloconSTDPriceLine2."Prod. BOM Header in HL"
                else
                    COGSAllocSTDPriceLine."Qty. per HL of FG" := COGSAllocSTDPriceLine."Qty. Including Scrap" * COGSAlloconSTDPriceLine2."Qty. per HL of FG"
            end;
        end;
    end;
}

