report 55010 "Allocate COGS Costs"
{
    // version HEI.29

    // HEI.01 CHG2132673 IBM BULIMC01 10/03/2022#COGS Allocation - new report created to allocate COGS costs
    // HEI.02 HB2605 - CHG2132673 IBM NASTAA02 11.03.2022 # COGS Allocation
    //   # Code changes
    // HEI.03 CHG2132673 IBM BULIMC01 21/04/2022#COGS Allocation - new report changes
    // HEI.04 CHG2135085 SAHAL01      24.03.2022
    //   # Added Code to split the cost for Energy & Water, Other Variable Expenses and Production Fix Expenses
    // HEI.05 CHG2132673 IBM BULIMC01 28/04/2022#COGS Allocation
    //   #new functions created for the automatic run - GetDates and JobQRun
    // HEI.06 HB2605 - CHG2132673 IBM NASTAA02 13.05.2022 # COGS Allocation
    //   # Code added to include GL Entries without CCC
    // HEI.07 RITM3055469 IBM NASTAA02 14/06/2022 # Split C2S / COGS Allocation Job Queue
    //   # Code changed to update 'COGS Job Queue Run' without GUIALLOWED also
    // HEI.08 INC4159847/CHG2164634  IBM GOKULS01 04/07/2022 # COGS Allocation
    //   # Code changed to update calculation on Total std. cost (actual).
    //   # Code changed to update dimension from Item card
    //   # Code changed to pick form SKU without Production BOM No.
    // 
    // HEI.09 INC4159847/CHG2164634  IBM GOKULS01 11/07/2022 #COGS Allocation
    //   # Code changed to update Cost Prod. Fix. Exp. BuOM value.
    // 
    // HEI.10 CHG2165828 IBM SAMANR01 12/07/2022 #C2S job Permission issue
    //   # Add table 50238 & 50241 "rimd" permission on report property
    // 
    // HEI.11 CHG2164634 IBM GOKULS01 14/07/2022 #COGS Allocation
    //   # Code changed for Total std. cost (actual).
    // 
    // HEI.12 CHG2177067 IBM SISUM01 13/10/2022 #Correct the G/L amounts in function CalcPeriodCosts()
    // HEI.13 CHG2177067 IBM SISUM01 26/10/2022 #Fix for HEI.12
    // HEI.14 CHG2177067 IBM SISUM01 11/11/2022 #Fix if dimension filter is blank in COGS Setup
    // HEI.15 CHG2171815 HB3141 NORRIQ ZOGHLE01 23.01.2023 Caluclate COGS Allocations based on Inventory Posting Group
    //   # Calculate COGS Allocations based on Inventory Setup with Inventory Posting group instead of costing method
    // 
    // HEI.16 CHG2171815 IBM PATHAA02 24.01.23
    //  # Enhancement of COGS allocation table (HB2605) for average items.
    //  # Calculate "Cost. Prod. Fix. per HL of FG" based on Condition.
    // 
    // 
    // HEI.18 CHG2190464 IBM SISUM01 14/02/23 #insert finished item not sold in the period
    // HEI.19 CHG2190464 IBM SISUM01 23/02/23  # if there's no sales for the period, then skip the search of the bom line
    // HEI.17 CHG2172818 PRASAA03 31.01.2023 EPM COGS Allocation: Average items enhancement
    //   # Added code and function to calculate unit cost of item from Value Entries for standard cost calculation
    // HEI.20 CHG2172818 PRASAA03 28.02.2023 EPM COGS Allocation: Average items enhancement
    //   # Changed Average cost calculation formulae.
    // HEI.21 CHG2172818 PRASAA03 01.03.2023 EPM COGS Allocation: Average items enhancement
    //   # Changed Average cost calculation formulae.
    // HEI.22 CHG2172818 PRASAA03 02.03.2023 EPM COGS Allocation: Average items enhancement
    //   # Changed Average cost calculation formulae.
    // HEI.23 CHG2172818 PRASAA03 04.04.2023 EPM COGS Allocation: Average items enhancement
    //   # Included Invoiced quantity Zero Value entries.
    // HEI.24 CHG2172818 PRASAA03 24.08.2023 EPM COGS Allocation: Average items enhancement
    //   # CalcUnitCostFromVE function logic changed.
    // HEI.25 CHG2172818 PRASAA03 29.11.2023 EPM COGS Allocation: Average items enhancement
    //   # For Average cost, code changed to calculate Product Brought_resale Avg Cost HL.
    // HEI.26 CHG2172818 PRASAA03 07.12.2023 EPM COGS Allocation: Average items enhancement
    //   # condition changed for product brought in for resale.
    // HEI.27 CHG2172818 PRASAA03 13.12.2023 EPM COGS Allocation: Average items enhancement
    //   # condition changed for product brought in for resale HL.
    // HEI.28 CHG2253600 IBM PATHAA02 31.05.2024 #COGS-Corrective change
    //   # condition changed for "Prod Bought_Resale Avg Cost_HL" for Inventory Posting Group
    // HEI.29 CHG2256333 IBM PATHAA02 19.06.2024 #COGS-Corrective change
    //   # condition changed for "Prod Bought_Resale Avg Cost_HL" for Inventory Posting Group to avoid "Attempt to Divide by Zero" Error

    // BC Upgrade POENAB02: Original (HeiLite) report id 50550
    // #FDD-COGS-[PID803,FDD-DTW-022,IBM GAP DTW54] 


    Caption = 'Allocate COGS Costs';
    Permissions = TableData "COGS Alloc on STD Price FND" = rimd,
                  TableData "COGS Alloc STD Price Line FND" = rimd;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis; //PATHAA02 04.04.26
    ApplicationArea = All; //PATHAA02 04.04.26

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartingDate; StartingDate)
                    {
                        Caption = 'Starting Date:';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the starting date for the period for which you want to allocate COGS costs.';

                        trigger OnValidate();
                        begin
                            //HEI.04>>
                            if StartingDate <> 0D then
                                EndingDate := CalcDate('<CM>', StartingDate);
                            //HEI.04<<
                        end;
                    }
                    field(EndingDate; EndingDate)
                    {
                        Caption = 'Ending Date:';
                        Editable = false;
                        ApplicationArea = All;
                        ToolTip = 'Displays the ending date for the period for which you want to allocate COGS costs.';
                    }
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
        //HEI.03<<
        CalculateTotalStdPrice();
        CalculateTotalUnallocated();
        //HEI.03>>

        if Allocated then begin
            if GuiAllowed then begin//HEI.05
                Window.Close();
                ; //HEI.18
                Message(Text001);
            end; //HEI.18
                 //HEI.05<<
            if RunJobQ then begin
                RunningCalendar."COGS Job Queue Run" := true;
                RunningCalendar.Modify();
            end;
        end;
        //HEI.05>>
    end;

    trigger OnPreReport();
    var
        ValueEntryItemCatCode: Query "Value Entry - Item Cat Code";
        ItemRec: Record Item;
        DefaultDimension: Record "Default Dimension";
    begin
        InventorySetup.Get();
        GLSetup.Get();
        WarehouseSetup.Get(); //HEI.03

        CheckExistingAllocation(); //HEI.03

        if GuiAllowed then //HEI.05
                           //Window.OPEN(Text002); //HEI.18
                           //HEI.19>>
                           //Window.OPEN(Text002 + Text003 + Text004); //HEI.18
            Window.Open(Text002 + Text003);
        //HEI.19<<

        CalcPeriodCosts();

        //HEI.18>>
        Item.SetCurrentKey("Item Category Code"); //HEI.19
        Item.SetFilter("Item Category Code", InventorySetup."Finished Goods ItemCatCode FND");
        Item.SetFilter("Costing Method", Format(InventorySetup."COGS Costing Method FND"));
        if Item.FindSet(false) then begin
            if GuiAllowed then begin
                NoOfRecords := Item.Count();
                NoOfRecProgress := NoOfRecords div 100;
                Counter := 0;
                NoOfProgresed := 0;
                TimeProgress := Time;
            end;

            repeat
                Clear(BrandNo);
                Clear(LineExtNo);
                Clear(PackType);

                if DefaultDimension.Get(27, Item."No.", GLSetup."Brand Dimension Code FND") then
                    BrandNo := DefaultDimension."Dimension Value Code";

                if DefaultDimension.Get(27, Item."No.", GLSetup."Line ext Dimension Code FND") then
                    LineExtNo := DefaultDimension."Dimension Value Code";

                if DefaultDimension.Get(27, Item."No.", GLSetup."Primary Pack Type Dim FND") then
                    PackType := DefaultDimension."Dimension Value Code";

                SalesBuffer.Init();
                SalesBuffer."Item No." := Item."No.";
                SalesBuffer."Dimension Level 1 Value Code" := BrandNo;
                SalesBuffer."Dimension Level 2 Value Code" := LineExtNo;
                SalesBuffer."Dimension Level 3 Value Code" := PackType;
                SalesBuffer.Insert();

                if GuiAllowed then begin
                    Counter += 1;
                    if Counter >= NoOfRecProgress then begin
                        NoOfProgresed := NoOfProgresed + Counter;
                        Window.Update(1, Round(NoOfProgresed / NoOfRecords * 10000, 1));
                        Counter := 0;
                        TimeProgress := Time;
                    end;
                end;

            until Item.Next() = 0;
        end;
        //HEI.18<<


        //Find Value Entries for a specific Item Category Code
        ValueEntryItemCatCode.SetRange(Posting_Date, StartingDate, EndingDate);
        ValueEntryItemCatCode.SetRange(Item_Category_Code, InventorySetup."Finished Goods ItemCatCode FND");
        //HEI.15<<
        if InventorySetup."COGS Allocation Calc.based FND" = InventorySetup."COGS Allocation Calc.based FND"::"Costing Method" then
            //HEI.15>>
            ValueEntryItemCatCode.SetFilter(Costing_Method, Format(InventorySetup."COGS Costing Method FND")); //HEI.03

        ValueEntryItemCatCode.Open();
        while ValueEntryItemCatCode.Read() do begin

            //HEI.18>>
            /*
            CLEAR(BrandNo);
            CLEAR(LineExtNo);
            CLEAR(PackType);
            */
            //HEI.18<<

            /*DimSetEntry.RESET;
            IF DimSetEntry.GET(ValueEntryItemCatCode.Dimension_Set_ID,GLSetup."Brand Dimension Code") THEN
              BrandNo := DimSetEntry."Dimension Value Code";

            DimSetEntry.RESET;
            IF DimSetEntry.GET(ValueEntryItemCatCode.Dimension_Set_ID,GLSetup."Line ext Dimension Code") THEN
              LineExtNo := DimSetEntry."Dimension Value Code";

            DimSetEntry.RESET;
            IF DimSetEntry.GET(ValueEntryItemCatCode.Dimension_Set_ID,GLSetup."Primary Pack Type Dim") THEN
              PackType := DimSetEntry."Dimension Value Code";*/ //HEI.08 code change for dimension

            //HEI.18>>
            /*
            //>>HEI.08
            ItemRec.RESET;
            ItemRec.GET(ValueEntryItemCatCode.Item_No);
            DefaultDimension.RESET;
            IF DefaultDimension.GET(27,ItemRec."No.",GLSetup."Brand Dimension Code") THEN
              BrandNo := DefaultDimension."Dimension Value Code";

            DefaultDimension.RESET;
            IF DefaultDimension.GET(27,ItemRec."No.",GLSetup."Line ext Dimension Code") THEN
              LineExtNo := DefaultDimension."Dimension Value Code";

            DefaultDimension.RESET;
            IF DefaultDimension.GET(27,ItemRec."No.",GLSetup."Primary Pack Type Dim") THEN
              PackType := DefaultDimension."Dimension Value Code";
            //<<HEI.08

            SalesBuffer.RESET;
            SalesBuffer.SETRANGE("Item No.",ValueEntryItemCatCode.Item_No);
            SalesBuffer.SETRANGE("Dimension Level 1 Value Code",BrandNo);
            SalesBuffer.SETRANGE("Dimension Level 2 Value Code",LineExtNo);
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code",PackType);
            IF NOT SalesBuffer.FINDFIRST THEN BEGIN
              SalesBuffer."Item No." := ValueEntryItemCatCode.Item_No;
              SalesBuffer."Dimension Level 1 Value Code" := BrandNo;
              SalesBuffer."Dimension Level 2 Value Code" := LineExtNo;
              SalesBuffer."Dimension Level 3 Value Code" := PackType;
              SalesBuffer.Expenses := -ValueEntryItemCatCode.Invoiced_Quantity_in_HL;
              SalesBuffer."Sold Amt" := -ValueEntryItemCatCode.Invoiced_Quantity; //HEI.03
              SalesBuffer.INSERT;
            END ELSE BEGIN
              SalesBuffer.Expenses += -ValueEntryItemCatCode.Invoiced_Quantity_in_HL;
              SalesBuffer."Sold Amt" += -ValueEntryItemCatCode.Invoiced_Quantity; //HEI.03
              SalesBuffer.MODIFY;
            END;
            */

            SalesBuffer.SetRange("Item No.", ValueEntryItemCatCode.Item_No);
            if SalesBuffer.FindFirst() then begin
                // BC Upgrade POENAB02 >>
                // commented, as it is part of Aptean changes
                // SalesBuffer.Expenses += -ValueEntryItemCatCode.Sum_Invoiced_Quantity_in_HL;
                SalesBuffer.Expenses += -ValueEntryItemCatCode.Sum_Invoiced_Quantity_in_HL; //PATHAA02
                // BC Upgrade POENAB02 <<
                SalesBuffer."Sold Amt" += -ValueEntryItemCatCode.Sum_Invoiced_Quantity; //HEI.03
                SalesBuffer.Modify();
            end;

            //HE.19>>
            /*
            IF GUIALLOWED THEN BEGIN
              SLEEP(1000);
              Window.UPDATE(2,ValueEntryItemCatCode.Item_No);
            END;
            */
            //HEI.19<<

            //HEI.18<<

        end;
        ValueEntryItemCatCode.Close(); //HEI.18

        SalesBuffer.Reset();
        if SalesBuffer.FindSet(false) then begin
            Allocated := true; //HEI.07
            if GuiAllowed then begin //HEI.05
                                     //Allocated := TRUE; //HEI.07
                NoOfRecords := SalesBuffer.Count();
                NoOfRecProgress := NoOfRecords div 100;
                Counter := 0;
                NoOfProgresed := 0;
                TimeProgress := Time();
            end; //HEI.05

            repeat

                InsertCOGSLines(SalesBuffer);

                if GuiAllowed then begin //HEI.05
                    Counter += 1;
                    if Counter >= NoOfRecProgress then begin
                        NoOfProgresed := NoOfProgresed + Counter;
                        //HEI.18>>
                        //Window.UPDATE(1,ROUND(NoOfProgresed / NoOfRecords * 10000,1));
                        Window.Update(2, Round(NoOfProgresed / NoOfRecords * 10000, 1));
                        //HEI.18<<
                        Counter := 0;
                        TimeProgress := Time();
                    end;
                end; //HEI.05
            until SalesBuffer.Next() = 0;
        end;

    end;

    var
        StartingDate: Date;
        EndingDate: Date;
        InventorySetup: Record "Inventory Setup";
        DimSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        SalesBuffer: Record "Brand Dim Hierarchy FND" temporary;
        LineExtNo: Code[20];
        BrandNo: Code[20];
        PackType: Code[20];
        Allocated: Boolean;
        Text001: Label 'COGS costs have been successfully allocated.';
        Window: Dialog;
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        NoOfProgresed: Integer;
        Counter: Integer;
        TimeProgress: Time;
        Text003: Label 'Loading          @2@@@@@@@@\';
        TempCOGSAllocSetup: Record "G/L COGS Allocation Setup FND" temporary;
        StockkeepingUnit: Record "Stockkeeping Unit";
        InsertCOGSBOMlines: Report "Insert COGS BOM lines";
        WarehouseSetup: Record "Warehouse Setup";
        RunJobQ: Boolean;
        RunningCalendar: Record "C2S/COGS Running Calendar FND";
        gQr_GLQuery: Query "Calc GL Entry Amount by Dim";
        Item: Record Item;
        ValueEntry: Record "Value Entry";
        i: Integer;
        Text002: Label 'Insert FG       @1@@@@@@@@\';

    local procedure InsertCOGSLines(var SalesBuffer: Record "Brand Dim Hierarchy FND");
    var
        COGSAllocationonSTDPrice: Record "COGS Alloc on STD Price FND";
        Item: Record Item;
    begin
        //with COGSAllocationonSTDPrice do begin //HEI.02 // BC Upgrade POENAB02
        COGSAllocationonSTDPrice.Init();
        //"Entry No." := FindLastEntryNo; //HEI.02
        COGSAllocationonSTDPrice.Company := CompanyName;
        COGSAllocationonSTDPrice."Fiscal Year" := Date2DMY(StartingDate, 3);
        COGSAllocationonSTDPrice."Period Number" := Date2DMY(StartingDate, 2);
        COGSAllocationonSTDPrice."Processing Date" := WorkDate();
        COGSAllocationonSTDPrice."SKU of Sold Products" := SalesBuffer."Item No.";
        COGSAllocationonSTDPrice.Brand := SalesBuffer."Dimension Level 1 Value Code";
        COGSAllocationonSTDPrice."Line Extension" := SalesBuffer."Dimension Level 2 Value Code";
        COGSAllocationonSTDPrice."Pack Type" := SalesBuffer."Dimension Level 3 Value Code";
        COGSAllocationonSTDPrice."Volumes Sold HL" := SalesBuffer.Expenses;
        COGSAllocationonSTDPrice."Volumes Sold" := SalesBuffer."Sold Amt"; //HEI.03
        //HEI.03<<
        //StockkeepingUnit.GET(Location,"SKU of Sold Products",'');
        //StockkeepingUnit.RESET; //HEI.03 commented
        Clear(StockkeepingUnit); //HEI.03
        StockkeepingUnit.SetRange("Item No.", COGSAllocationonSTDPrice."SKU of Sold Products");
        StockkeepingUnit.SetRange("Variant Code", '');
        StockkeepingUnit.SetFilter("Production BOM No.", '<>%1', '');
        if StockkeepingUnit.FindFirst() then;

        Item.Get(COGSAllocationonSTDPrice."SKU of Sold Products");
        COGSAllocationonSTDPrice."Costing Method" := Item."Costing Method".AsInteger();

        InsertCOGSParentLine(COGSAllocationonSTDPrice, StockkeepingUnit);
        //HEI.15<<
        if InventorySetup."COGS Allocation Calc.based FND" = InventorySetup."COGS Allocation Calc.based FND"::"Inventory Posting Group" then begin
            if Item."Inventory Posting Group" = InventorySetup."pdct. BoughtResale Inv.Pos FND" then begin
                CalcUnitCostFromVE(COGSAllocationonSTDPrice."Cost Posted to G/L", COGSAllocationonSTDPrice."Valued Quantity HL", COGSAllocationonSTDPrice."SKU of Sold Products");//HEI.17
                                                                                                                                                                                  // IF Item."Unit Volume HL" <> 0 THEN //HEI.29
                                                                                                                                                                                  //HEI.17>>
                if COGSAllocationonSTDPrice."Valued Quantity HL" <> 0 then
                    if COGSAllocationonSTDPrice."Volumes Sold HL" <> 0 then //HEI.29
                                                                            //"Prod Bought_Resale Avg Cost_HL" := ("Cost Posted to G/L"/"Valued Quantity HL");//HEI.20 //HEI.28
                        COGSAllocationonSTDPrice."Prod Bought_Resale Avg Cost_HL" := (Abs(COGSAllocationonSTDPrice."Cost Posted to G/L") / COGSAllocationonSTDPrice."Volumes Sold HL");//HEI.28
                                                                                                                                                                                       // BC Upgrade POENAB02 >>
                                                                                                                                                                                       // commented, as it is part of Aptean changes                                                                                            //HEI.29<<
                                                                                                                                                                                       /* 
                                                                                                                                                                                       if (COGSAllocationonSTDPrice."Volumes Sold HL" = 0) and (Item."Unit Volume HL" <> 0) then
                                                                                                                                                                                           COGSAllocationonSTDPrice."Prod Bought_Resale Avg Cost_HL" := (1 / Item."Unit Volume HL") * Item."Unit Cost"; 
                                                                                                                                                                                       */
                                                                                                                                                                                       //PATHAA02 04.04.26>>
                if (COGSAllocationonSTDPrice."Volumes Sold HL" = 0) and (Item."Unit Volume" <> 0) then
                    COGSAllocationonSTDPrice."Prod Bought_Resale Avg Cost_HL" := (1 / Item."Unit Volume") * Item."Unit Cost";
                //PATHAA02 04.04.26<<
                // BC Upgrade POENAB02 <<
                //HEI.29>>
                //"Prod Bought_Resale Avg Cost_HL" := (1 / Item."Unit Volume HL") * ("Cost Posted to G/L"/"Valued Quantity HL");//HEI.20
                //"Prod Bought_Resale Avg Cost_HL" := (1 / Item."Unit Volume HL") * Item."Unit Cost";//HEI.17
                //HEI.17<<
                COGSAllocationonSTDPrice."Prod Bought_Resale Avg Cost" := COGSAllocationonSTDPrice."Volumes Sold HL" * COGSAllocationonSTDPrice."Prod Bought_Resale Avg Cost_HL";
            end else if Item."Inventory Posting Group" = InventorySetup."Finish Pdct.prod. Inv.Pos FND" then begin
                //insert BOM lines
                if (SalesBuffer.Expenses <> 0) then begin //HEI.19
                    InsertCOGSBOMlines.GetParameters(COGSAllocationonSTDPrice."SKU of Sold Products", StartingDate, EndingDate);
                    InsertCOGSBOMlines.Run();
                end; //HEI.19
            end;
            //HEI.15>>
        end else if COGSAllocationonSTDPrice."Costing Method" = "Costing Method"::Average.AsInteger() then begin
            //"Prod Bought_Resale Avg Cost_HL" := StockkeepingUnit."Unit Cost"; //HEI.03 commented
            //HEI.03<<
            CalcUnitCostFromVE(COGSAllocationonSTDPrice."Cost Posted to G/L", COGSAllocationonSTDPrice."Valued Quantity HL", COGSAllocationonSTDPrice."SKU of Sold Products");//HEI.21
                                                                                                                                                                              //IF Item."Unit Volume HL" <> 0 THEN //HEI.22
                                                                                                                                                                              //HEI.25>>
            if COGSAllocationonSTDPrice."Valued Quantity HL" <> 0 then
                if COGSAllocationonSTDPrice."Volumes Sold HL" <> 0 then
                    COGSAllocationonSTDPrice."Prod Bought_Resale Avg Cost_HL" := (Abs(COGSAllocationonSTDPrice."Cost Posted to G/L") / COGSAllocationonSTDPrice."Volumes Sold HL");
            //BC Upgrade POENAB02 >>
            // comented, as it is part of Aptean changes                                                                                           //HEI.25<<
            /* 
            if ("Volumes Sold HL" = 0) and (Item."Unit Volume HL" <> 0) then
                "Prod Bought_Resale Avg Cost_HL" := (1 / Item."Unit Volume HL") * Item."Unit Cost"; 
            */
            //PATHAA02 04.04.26>>
            if (COGSAllocationonSTDPrice."Volumes Sold HL" = 0) and (Item."Unit Volume" <> 0) then
                COGSAllocationonSTDPrice."Prod Bought_Resale Avg Cost_HL" := (1 / Item."Unit Volume") * Item."Unit Cost";
            //PATHAA02 04.04.26<<

            //BC Upgrade POENAB02 <<
            /*
            IF "Valued Quantity HL" <> 0 THEN //HEI.22
              "Prod Bought_Resale Avg Cost_HL" := ("Cost Posted to G/L"/"Valued Quantity HL");//HEI.21
              //"Prod Bought_Resale Avg Cost_HL" := (1 / Item."Unit Volume HL") * Item."Unit Cost";//HEI.21
            //HEI.03>>
            */
            //HEI.25<<
            COGSAllocationonSTDPrice."Prod Bought_Resale Avg Cost" := COGSAllocationonSTDPrice."Volumes Sold HL" * COGSAllocationonSTDPrice."Prod Bought_Resale Avg Cost_HL";
        end else begin
            //insert BOM lines
            if (SalesBuffer.Expenses <> 0) then begin //HEI.19
                InsertCOGSBOMlines.GetParameters(COGSAllocationonSTDPrice."SKU of Sold Products", StartingDate, EndingDate);
                InsertCOGSBOMlines.Run();
            end; //HEI.19
        end;

        //Insert Period Costs
        AllocatePeriodCosts(COGSAllocationonSTDPrice);
        //HEI.26>>
        if (COGSAllocationonSTDPrice."Volumes Sold HL" < 0) and (COGSAllocationonSTDPrice."Prod Bought_Resale Avg Cost" > 0) then
            COGSAllocationonSTDPrice."Prod Bought_Resale Avg Cost" := -1 * COGSAllocationonSTDPrice."Prod Bought_Resale Avg Cost";
        //HEI.26<<
        COGSAllocationonSTDPrice."Prod Bought_Resale Avg Cost_HL" := Abs(COGSAllocationonSTDPrice."Prod Bought_Resale Avg Cost_HL");//HEI.27
                                                                                                                                    //HEI.03>>
        COGSAllocationonSTDPrice.Insert();
        //end; //HEI.02 //BC Upgrade POENAB02
    end;

    //end;

    local procedure CalcPeriodCosts();
    var
        GLEntry: Record "G/L Entry";
        COGSAllocSetup: Record "G/L COGS Allocation Setup FND";
        GLAccount: Record "G/L Account";
    begin
        //HEI.12>>
        /*
        COGSAllocSetup.RESET;
        IF COGSAllocSetup.FINDSET(FALSE,FALSE) THEN
          REPEAT
            //HEI.03<<
            GLAccount.RESET;
            GLAccount.SETFILTER("No.",COGSAllocSetup."G/L Account Range for SCOA L3");
            //GLAccount.SETFILTER("Financial Statement version",'%1|%2',GLAccount."Financial Statement version"::Common,GLAccount."Financial Statement version"::Heineken); //HEI.03 commented
            GLAccount.SETFILTER("Financial Statement version",WarehouseSetup."SCOA Financial Statement"); //HEI.03
            IF GLAccount.FINDSET(FALSE,FALSE) THEN
              REPEAT
            //HEI.03>>
                GLEntry.RESET;
                GLEntry.SETCURRENTKEY("G/L Account No.","Posting Date");
                //GLEntry.SETFILTER("G/L Account No.",COGSAllocSetup."G/L Account Range for SCOA L3"); //HEI.03
                GLEntry.SETRANGE("G/L Account No.",GLAccount."No."); //HEI.03
                GLEntry.SETRANGE("Posting Date",StartingDate,EndingDate);
                IF GLEntry.FINDSET(FALSE,FALSE) THEN
                  REPEAT
                    DimSetEntry.RESET;
                    DimSetEntry.SETRANGE("Dimension Set ID",GLEntry."Dimension Set ID");
                    IF GLEntry."Global Dimension 2 Code" <> '' THEN BEGIN //HEI.06
                      DimSetEntry.SETRANGE("Dimension Code",GLSetup."Shortcut Dimension 2 Code");
                      DimSetEntry.SETFILTER("Dimension Value Code",COGSAllocSetup."Ccc Code Dim. Filter");
                    END; //HEI.06
                    IF DimSetEntry.FINDFIRST THEN BEGIN
                      TempCOGSAllocSetup.RESET;
                      TempCOGSAllocSetup.SETCURRENTKEY("COGS Allocation");
                      TempCOGSAllocSetup.SETRANGE("COGS Allocation",COGSAllocSetup."COGS Allocation");
                      IF NOT TempCOGSAllocSetup.FINDFIRST THEN BEGIN
                        TempCOGSAllocSetup.INIT;
                        TempCOGSAllocSetup.TRANSFERFIELDS(COGSAllocSetup);
                        //HEI.06>>
                        IF GLEntry."Global Dimension 2 Code" = '' THEN
                          TempCOGSAllocSetup."Ccc Code Dim. Filter" := '';
                        //HEI.06<<
                        TempCOGSAllocSetup."Period Cost" := GLEntry.Amount;
                        TempCOGSAllocSetup.INSERT;
                      END ELSE BEGIN
                        TempCOGSAllocSetup."Period Cost" += GLEntry.Amount;
                        TempCOGSAllocSetup.MODIFY;
                      END;
                    END;
                  UNTIL GLEntry.NEXT = 0;
              UNTIL GLAccount.NEXT = 0;
          UNTIL COGSAllocSetup.NEXT = 0;
        */

        //HEI.14>>
        TempCOGSAllocSetup.Reset();
        TempCOGSAllocSetup.SetCurrentKey("COGS Allocation");
        GLEntry.Reset();
        GLEntry.SetCurrentKey("G/L Account No.", "Posting Date");
        //HEI.14<<

        COGSAllocSetup.Reset();
        if COGSAllocSetup.FindSet() then
            repeat //HEI.13

                //HEI.14>>
                if (COGSAllocSetup."Ccc Code Dim. Filter" = '') then begin
                    GLAccount.Reset();
                    GLAccount.SetFilter("No.", COGSAllocSetup."G/L Account Range for SCOA L3");
                    GLAccount.SetFilter("Financial Stmt version FND", WarehouseSetup."SCOA Financial Statement FND");
                    if GLAccount.FindSet(false) then
                        repeat
                            GLEntry.SetRange("G/L Account No.", GLAccount."No.");
                            GLEntry.SetRange("Posting Date", StartingDate, EndingDate);
                            GLEntry.CalcSums(Amount);
                            TempCOGSAllocSetup.SetRange("COGS Allocation", COGSAllocSetup."COGS Allocation");
                            if not TempCOGSAllocSetup.FindFirst() then begin
                                TempCOGSAllocSetup.Init();
                                TempCOGSAllocSetup.TransferFields(COGSAllocSetup);
                                TempCOGSAllocSetup."Period Cost" := GLEntry.Amount;
                                TempCOGSAllocSetup.Insert();
                            end else begin
                                TempCOGSAllocSetup."Period Cost" += GLEntry.Amount;
                                TempCOGSAllocSetup.Modify();
                            end;
                        until GLAccount.Next() = 0;
                end else begin
                    //HEI.14<<
                    Clear(gQr_GLQuery);
                    //HEI.19>>
                    //gQr_GLQuery.SETFILTER(No,COGSAllocSetup."G/L Account Range for SCOA L3");
                    gQr_GLQuery.SetFilter(GLAccountNoFilter, COGSAllocSetup."G/L Account Range for SCOA L3");
                    //HEI.19<<
                    gQr_GLQuery.SetFilter(FinancialStatementVersion, WarehouseSetup."SCOA Financial Statement FND");
                    gQr_GLQuery.SetRange(PostingDate, StartingDate, EndingDate);
                    gQr_GLQuery.SetFilter(DimensionCode, GLSetup."Shortcut Dimension 2 Code");
                    gQr_GLQuery.SetFilter(DimensionValueCode, COGSAllocSetup."Ccc Code Dim. Filter");
                    gQr_GLQuery.Open();
                    while gQr_GLQuery.Read() do begin
                        //HEI.14>>
                        /*
                        TempCOGSAllocSetup.RESET;
                        TempCOGSAllocSetup.SETCURRENTKEY("COGS Allocation");
                        */
                        //HEI.14<<
                        TempCOGSAllocSetup.SetRange("COGS Allocation", COGSAllocSetup."COGS Allocation");
                        if not TempCOGSAllocSetup.FindFirst() then begin
                            TempCOGSAllocSetup.Init();
                            TempCOGSAllocSetup.TransferFields(COGSAllocSetup);
                            TempCOGSAllocSetup."Period Cost" := gQr_GLQuery.Amount;
                            TempCOGSAllocSetup.Insert();
                        end else begin
                            TempCOGSAllocSetup."Period Cost" += gQr_GLQuery.Amount;
                            TempCOGSAllocSetup.Modify();
                        end;
                    end;
                    gQr_GLQuery.Close();
                end; //HEI.14
            until COGSAllocSetup.Next() = 0; //HEI.13
        //HEI.12<<

    end;

    local procedure AllocatePeriodCosts(var COGSAllocationonSTDPrice: Record "COGS Alloc on STD Price FND");
    begin
        CLEAR(TempCOGSAllocSetup);
        if TempCOGSAllocSetup.FindSet(false) then
            repeat
                case TempCOGSAllocSetup."COGS Allocation" of
                    TempCOGSAllocSetup."COGS Allocation"::"Energy & Water":
                        COGSAllocationonSTDPrice."Period G/L Cost Energy & Water" := TempCOGSAllocSetup."Period Cost";

                    TempCOGSAllocSetup."COGS Allocation"::"Inv. Mov. Var. Prod Exp.":
                        COGSAllocationonSTDPrice."Period G/L Cost InvMovVarProEx" := TempCOGSAllocSetup."Period Cost";

                    TempCOGSAllocSetup."COGS Allocation"::"Other Variable Expenses":
                        COGSAllocationonSTDPrice."Period G/L Cost Other Var Exp" := TempCOGSAllocSetup."Period Cost";

                    TempCOGSAllocSetup."COGS Allocation"::"Packaging Materials":
                        COGSAllocationonSTDPrice."Period G/L Cost Pack Materials" := TempCOGSAllocSetup."Period Cost";

                    TempCOGSAllocSetup."COGS Allocation"::"Prod Bought in for Resale":
                        COGSAllocationonSTDPrice."Period G/L Cost ProdBghtResale" := TempCOGSAllocSetup."Period Cost";

                    TempCOGSAllocSetup."COGS Allocation"::"Prod Fix Exp":
                        COGSAllocationonSTDPrice."Period G/L Cost Prod Fix Exp" := TempCOGSAllocSetup."Period Cost";

                    TempCOGSAllocSetup."COGS Allocation"::"Raw Materials":
                        COGSAllocationonSTDPrice."Period G/L Cost Raw Materials" := TempCOGSAllocSetup."Period Cost";
                end;
            until TempCOGSAllocSetup.Next() = 0;
    end;

    local procedure CheckExistingAllocation();
    var
        COGSAllocSTDPrice: Record "COGS Alloc on STD Price FND";
        COGSAllocSTDPriceLine: Record "COGS Alloc STD Price Line FND";
    begin
        //HEI.03<<
        //Delete COGS All Price for the same period
        COGSAllocSTDPrice.SetRange(Company, CompanyName);
        COGSAllocSTDPrice.SetRange("Fiscal Year", Date2DMY(StartingDate, 3));
        COGSAllocSTDPrice.SetRange("Period Number", Date2DMY(StartingDate, 2));
        COGSAllocSTDPrice.DeleteAll();
        ;

        //Delete the COGS lines for the same period
        COGSAllocSTDPriceLine.SetRange(Company, CompanyName);
        COGSAllocSTDPriceLine.SetRange("Fiscal Year", Date2DMY(StartingDate, 3));
        COGSAllocSTDPriceLine.SetRange("Period Number", Date2DMY(StartingDate, 2));
        COGSAllocSTDPriceLine.DeleteAll();
        //HEI.03>>
    end;

    local procedure InsertCOGSParentLine(COGSAllocSTDPrice: Record "COGS Alloc on STD Price FND"; SKU: Record "Stockkeeping Unit");
    var
        Item: Record Item;
        COGSAlloconSTDPriceLine: Record "COGS Alloc STD Price Line FND";
        ProdBOMHeader: Record "Production BOM Header";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        BasePriceSTDCostCalc: Record "Base Price STD Cost Calc. FND";
        WorkCenter: Record "Work Center";
        RoutingLine: Record "Routing Line";
    begin
        //HEI.03>>
        //with COGSAlloconSTDPriceLine do begin // BC Upgrade POENAB02
        COGSAlloconSTDPriceLine.Init();

        COGSAlloconSTDPriceLine."Processing Date" := WorkDate();
        COGSAlloconSTDPriceLine.Company := CompanyName;
        COGSAlloconSTDPriceLine."Fiscal Year" := COGSAllocSTDPrice."Fiscal Year";
        COGSAlloconSTDPriceLine."Period Number" := COGSAllocSTDPrice."Period Number";
        COGSAlloconSTDPriceLine."Parent Item No." := COGSAllocSTDPrice."SKU of Sold Products";
        COGSAlloconSTDPriceLine."Item No." := COGSAllocSTDPrice."SKU of Sold Products";
        COGSAlloconSTDPriceLine."BOM Level" := 0;
        COGSAlloconSTDPriceLine.Quantity := COGSAllocSTDPrice."Volumes Sold";
        COGSAlloconSTDPriceLine."Quantity HL" := COGSAllocSTDPrice."Volumes Sold HL";
        COGSAlloconSTDPriceLine."COGS Allocation" := COGSAlloconSTDPriceLine."COGS Allocation"::"Finished Goods";
        COGSAlloconSTDPriceLine."Production BOM No." := SKU."Production BOM No.";
        COGSAlloconSTDPriceLine."Routing No." := SKU."Routing No.";

        Item.Get(COGSAlloconSTDPriceLine."Item No.");
        COGSAlloconSTDPriceLine.Description := Item.Description;
        // BC Upgrade POENAB02 >>
        // commented, as it is part of Aptean changes
        // "Unit Volume HL" := Item."Unit Volume HL";
        //PATHAA02 04.04.26>>
        COGSAlloconSTDPriceLine."Unit Volume HL" := Item."Unit Volume";
        //PATHAA02 04.04.26<<

        // BC Upgrade POENAB02 <<
        COGSAlloconSTDPriceLine."Item Category Code" := Item."Item Category Code";
        COGSAlloconSTDPriceLine."Qty. per HL of FG" := 1;

        //convert Item UoM to HL
        ProdBOMHeader.Reset();
        if ProdBOMHeader.Get(COGSAlloconSTDPriceLine."Production BOM No.") then
            COGSAlloconSTDPriceLine."Prod. BOM Header UoM" := ProdBOMHeader."Unit of Measure Code";
        ItemUnitofMeasure.Reset();
        if ItemUnitofMeasure.Get(COGSAlloconSTDPriceLine."Item No.", COGSAlloconSTDPriceLine."Prod. BOM Header UoM") then
            COGSAlloconSTDPriceLine."Prod. BOM Qty. per BUoM" := ItemUnitofMeasure."Qty. per Unit of Measure";
        COGSAlloconSTDPriceLine."Prod. BOM Header in HL" := COGSAlloconSTDPriceLine."Prod. BOM Qty. per BUoM" * COGSAlloconSTDPriceLine."Unit Volume HL";

        //Routing info
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

        //Unit Cost for both Raw&Pack and Prod Fix Exp
        if COGSAlloconSTDPriceLine."Work Center No." <> '' then begin
            WorkCenter.Get(COGSAlloconSTDPriceLine."Work Center No.");
            COGSAlloconSTDPriceLine."Unit Cost of Work Center" := WorkCenter."Direct Unit Cost";
        end;

        if COGSAlloconSTDPriceLine."Work Center No." <> '' then begin
            if COGSAlloconSTDPriceLine."Setup Time" <> 1 then
                COGSAlloconSTDPriceLine."Cost Prod. Fix. Exp. BuOM" := COGSAlloconSTDPriceLine."Setup Time" * COGSAlloconSTDPriceLine."Unit Cost of Work Center" / COGSAlloconSTDPriceLine."Batch Size"
            //IF "Run Time" <> 1 THEN //HEI.09 Code commented and modified
            else
                COGSAlloconSTDPriceLine."Cost Prod. Fix. Exp. BuOM" += (COGSAlloconSTDPriceLine."Run Time" / COGSAlloconSTDPriceLine."Lot Size" * COGSAlloconSTDPriceLine."Unit Cost of Work Center") / COGSAlloconSTDPriceLine."Batch Size";
        end;

        //IF "Unit Volume HL" <> 0 THEN //HEI.16-commented
        // "Cost. Prod. Fix. per HL of FG" := "Cost Prod. Fix. Exp. BuOM" / "Unit Volume HL"; //HEI.16-commented

        //HEI.16<<
        if (((InventorySetup."COGS Allocation Calc.based FND" = InventorySetup."COGS Allocation Calc.based FND"::"Costing Method") and (Item."Costing Method" = Item."Costing Method"::Standard)) or

           ((InventorySetup."COGS Allocation Calc.based FND" = InventorySetup."COGS Allocation Calc.based FND"::"Inventory Posting Group") and
            (Item."Inventory Posting Group" = InventorySetup."Finish Pdct.prod. Inv.Pos FND"))) then begin

            if COGSAlloconSTDPriceLine."Unit Volume HL" <> 0 then
                COGSAlloconSTDPriceLine."Cost. Prod. Fix. per HL of FG" := COGSAlloconSTDPriceLine."Cost Prod. Fix. Exp. BuOM" / COGSAlloconSTDPriceLine."Unit Volume HL";
        end;
        //HEI.16>>

        //HEI.04>>
        if WorkCenter."Direct Unit Cost" <> 0 then begin
            if COGSAlloconSTDPriceLine."Cost. Prod. Fix. per HL of FG" <> 0 then begin //HEI.16
                COGSAlloconSTDPriceLine."Cost Energy & Water" := ((WorkCenter."Estimated Energy FND" + WorkCenter."Estimated Water Consmp. FND") / WorkCenter."Direct Unit Cost") * COGSAlloconSTDPriceLine."Cost. Prod. Fix. per HL of FG";
                COGSAlloconSTDPriceLine."Cost Other Variable Exp." := (WorkCenter."Other Variable Expenses FND" / WorkCenter."Direct Unit Cost") * COGSAlloconSTDPriceLine."Cost. Prod. Fix. per HL of FG";
                COGSAlloconSTDPriceLine."Cost. Prod. Fix. per HL of FG" := (WorkCenter."Production Fix Expenses FND" / WorkCenter."Direct Unit Cost") * COGSAlloconSTDPriceLine."Cost. Prod. Fix. per HL of FG";
            end; //HEI.16
        end;
        //HEI.04<<

        COGSAlloconSTDPriceLine.Insert();
        //end; // BC Upgrade POENAB02
        //HEI.03<<
    end;

    local procedure CalculateTotalStdPrice();
    var
        COGSAllocSTDPrice: Record "COGS Alloc on STD Price FND";
        COGSPriceLineL: Record "COGS Alloc STD Price Line FND";
    begin
        //HEI.03<<
        COGSAllocSTDPrice.Reset();
        ;
        COGSAllocSTDPrice.SetCurrentKey(Company, "Fiscal Year", "Period Number");
        COGSAllocSTDPrice.SetRange(Company, CompanyName);
        COGSAllocSTDPrice.SetRange("Fiscal Year", Date2DMY(StartingDate, 3));
        COGSAllocSTDPrice.SetRange("Period Number", Date2DMY(StartingDate, 2));
        if COGSAllocSTDPrice.FindSet(false) then
            repeat
                COGSAllocSTDPrice.CALCFIELDS("Raw Materials_HL", "Packaging Materials_HL", "Prod Fix Exp_COGS_HL");

                /*COGSAllocSTDPrice."Total Standard Cost/HL" := COGSAllocSTDPrice."Raw Materials_HL" + COGSAllocSTDPrice."Packaging Materials_HL" + COGSAllocSTDPrice."Prod Fix Exp_COGS_HL";
                COGSAllocSTDPrice."Total Standard Cost" := COGSAllocSTDPrice."Volumes Sold HL" * COGSAllocSTDPrice."Total Standard Cost/HL";
                COGSAllocSTDPrice."Raw Materials" := COGSAllocSTDPrice."Volumes Sold HL" * COGSAllocSTDPrice."Raw Materials_HL";
                COGSAllocSTDPrice."Packaging Materials" := COGSAllocSTDPrice."Volumes Sold HL" * COGSAllocSTDPrice."Packaging Materials_HL";
                COGSAllocSTDPrice."Prod Fix Exp_COGS" := COGSAllocSTDPrice."Volumes Sold HL" * COGSAllocSTDPrice."Prod Fix Exp_COGS_HL";*///HEI.11 code moved below for calculation issue
                                                                                                                                          //HEI.04>>
                COGSPriceLineL.Reset();
                COGSPriceLineL.SetCurrentKey(Company, "Fiscal Year", "Period Number", "Item No.", "Work Center No.");
                COGSPriceLineL.SetRange(Company, CompanyName);
                COGSPriceLineL.SetRange("Fiscal Year", Date2DMY(StartingDate, 3));
                COGSPriceLineL.SetRange("Period Number", Date2DMY(StartingDate, 2));
                COGSPriceLineL.SetRange("Parent Item No.", COGSAllocSTDPrice."SKU of Sold Products");
                COGSPriceLineL.SetFilter("Work Center No.", '<>%1', '');
                if COGSPriceLineL.FindSet(false) then begin
                    repeat
                        COGSAllocSTDPrice."Energy & Water_Prod_HL" += COGSPriceLineL."Cost Energy & Water";
                        COGSAllocSTDPrice."Other Variable Expenses_HL" += COGSPriceLineL."Cost Other Variable Exp.";
                    until COGSPriceLineL.Next() = 0;
                    COGSAllocSTDPrice."Energy & Water_Prod" := COGSAllocSTDPrice."Energy & Water_Prod_HL" * COGSAllocSTDPrice."Volumes Sold HL";
                    COGSAllocSTDPrice."Other Variable Expenses" := COGSAllocSTDPrice."Other Variable Expenses_HL" * COGSAllocSTDPrice."Volumes Sold HL";
                    COGSAllocSTDPrice."Total Standard Cost/HL" := COGSAllocSTDPrice."Energy & Water_Prod_HL" + COGSAllocSTDPrice."Other Variable Expenses_HL"; //HEI.08
                end;
                //HEI.04<<
                //HEI.11 // Code moved from above
                COGSAllocSTDPrice."Total Standard Cost/HL" += COGSAllocSTDPrice."Raw Materials_HL" + COGSAllocSTDPrice."Packaging Materials_HL" + COGSAllocSTDPrice."Prod Fix Exp_COGS_HL";
                COGSAllocSTDPrice."Total Standard Cost" := COGSAllocSTDPrice."Volumes Sold HL" * COGSAllocSTDPrice."Total Standard Cost/HL";
                COGSAllocSTDPrice."Raw Materials" := COGSAllocSTDPrice."Volumes Sold HL" * COGSAllocSTDPrice."Raw Materials_HL";
                COGSAllocSTDPrice."Packaging Materials" := COGSAllocSTDPrice."Volumes Sold HL" * COGSAllocSTDPrice."Packaging Materials_HL";
                COGSAllocSTDPrice."Prod Fix Exp_COGS" := COGSAllocSTDPrice."Volumes Sold HL" * COGSAllocSTDPrice."Prod Fix Exp_COGS_HL";
                //HEI.11
                COGSAllocSTDPrice.Modify();
            until COGSAllocSTDPrice.Next() = 0;
        //HEI.03>>

    end;

    local procedure CalculateTotalUnallocated();
    var
        COGSAllocSTDPriceQuery: Query "COGS Alloc. STD. Price";
        COGSAllocSTDPrice: Record "COGS Alloc on STD Price FND";
    begin
        //HEI.03<<
        COGSAllocSTDPrice.SetCurrentKey(Company, "Fiscal Year", "Period Number");
        COGSAllocSTDPrice.SetRange(Company, CompanyName);
        COGSAllocSTDPrice.SetRange("Fiscal Year", Date2DMY(StartingDate, 3));
        COGSAllocSTDPrice.SetRange("Period Number", Date2DMY(StartingDate, 2));
        if COGSAllocSTDPrice.FindSet(false) then
            repeat
                COGSAllocSTDPriceQuery.SetRange(Company, COGSAllocSTDPrice.Company);
                COGSAllocSTDPriceQuery.SetRange(FiscalYear, COGSAllocSTDPrice."Fiscal Year");
                COGSAllocSTDPriceQuery.SetRange(PeriodNumber, COGSAllocSTDPrice."Period Number");
                COGSAllocSTDPriceQuery.Open();
                while COGSAllocSTDPriceQuery.Read() do begin
                    COGSAllocSTDPrice.Unallocated := ABS((COGSAllocSTDPriceQuery.Sum_TotalCost + COGSAllocSTDPriceQuery.SumCost_Raw_Pack) -
                                  (COGSAllocSTDPrice."Period G/L Cost Energy & Water" + COGSAllocSTDPrice."Period G/L Cost InvMovVarProEx" + COGSAllocSTDPrice."Period G/L Cost Other Var Exp" +
                                  COGSAllocSTDPrice."Period G/L Cost Pack Materials" + COGSAllocSTDPrice."Period G/L Cost Prod Fix Exp" +
                                  COGSAllocSTDPrice."Period G/L Cost ProdBghtResale" + COGSAllocSTDPrice."Period G/L Cost Raw Materials"));
                    COGSAllocSTDPrice.Modify();
                end;
                COGSAllocSTDPriceQuery.Close();
            until COGSAllocSTDPrice.Next() = 0;
        //HEI.03>>
    end;

    procedure GetDates(NewStartDate: Date; NewEndDate: Date);
    begin
        //HEI.05<<
        StartingDate := NewStartDate;
        EndingDate := NewEndDate;
        //HEI.05<<
    end;

    procedure JobQueueRun(lRunJobQ: Boolean; var Rec: Record "C2S/COGS Running Calendar FND");
    begin
        //HEI.05<<
        RunJobQ := lRunJobQ;
        RunningCalendar := Rec;
        //HEI.05<<
    end;

    local procedure CalcUnitCostFromVE(var CostPostToGl: Decimal; var ValudQtyHl: Decimal; ItemNo: Code[20]);
    var
        ValueEntries: Record "Value Entry";
    begin
        //HEI.17>>
        CostPostToGl := 0;
        ValudQtyHl := 0;

        ValueEntries.Reset();
        ValueEntries.SetCurrentKey("Item No.", "Posting Date", "Item Ledger Entry Type", "Invoiced Quantity");
        ValueEntries.SetRange("Item No.", ItemNo);
        ValueEntries.SetRange("Posting Date", StartingDate, EndingDate);
        ValueEntries.SetRange("Item Ledger Entry Type", ValueEntries."Item Ledger Entry Type"::Sale);
        //ValueEntries.SETFILTER("Invoiced Quantity",'<>%1',0);//HEI.23//HEI.24
        if ValueEntries.FindSet(false) then begin
            // BC Upgrade POENAB02 >>
            // code commented and adjusted, as it is part of Aptean developments
            /* 
            ValueEntries.CALCSUMS("Cost Posted to G/L", "Valued Quantity in HL");
            CostPostToGl := ValueEntries."Cost Posted to G/L";
            ValudQtyHl := ValueEntries."Valued Quantity in HL";//HEI.24
             */
            ValueEntries.CalcSums("Cost Posted to G/L");
            CostPostToGl := ValueEntries."Cost Posted to G/L";
            // BC Upgrade POENAB02 <<
            //ValudQtyHl := ValueEntries."Invoiced Quantity in HL";//HEI.24
            ValudQtyHl := ValueEntries."Invoiced Quantity HL FND";//PATHAA02 05.04.26
        end;
        //HEI.17<<
    end;
}

