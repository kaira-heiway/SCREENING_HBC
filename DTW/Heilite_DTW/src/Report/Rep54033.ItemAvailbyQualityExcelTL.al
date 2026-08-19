report 54033 "Item Avail. by Quality-ExcelTL"
{
    // HEI.01 CHG2126578 IBM POENAB02 17.09.2021 HT2116 Brasco (Congo) Inventory Aging reports
    //   # Object created
    // HEI.02 CHG2126578 IBM.LS     16.12.2021
    //   # Added Code for Document Date export
    // HEI.03 CHG2139978 IBM POENAB02 17.12.2021 HT2116 Brasco (Congo) Inventory Aging reports
    //   # For data item "Item Ledger Entry" -> removed filter from DataItemTableView, "WHERE(Open=FILTER(Yes))"
    //   # Code added in Item Ledger Entry - OnAfterGetRecord
    //   # Code added in MakeExcelDataBody
    // HEI.04 CHG2139978 IBM.LS     23.12.2021
    //   # Added Remaining Quantity on ReqFilterFields
    //   # Added Code to apply Remaining Quantity filter
    //   # Added Code for Remaining Quantity export
    // BC Upgrade BHARDA11 >>
    // 1. OLD Report ID- 50539.
    // 2. Add ApplicationArea property in Report.
    // 3. Remove all Drink-IT Fields and related code(StockkeepingUnit."Deposit Value", Item."Inventory Unit of Measure", ItemLedgerEntryTMP."Vol-Strength Spec. Value", "Quantity in HL", "Strength Spec. Value", ItemLedgerEntryTMP."Bin Code", ItemLedgerEntryTMP."Company Tax Warehouse Ref.")
    // 4. Re-Structure export to excel  ExcelBuffer code. 
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Inventory Aging Brasco';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.", "Item Category Code";
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("Item No.", "Location Code", Open, "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.") ORDER(Ascending);
                RequestFilterFields = "Location Code", "Zone Code FND", "Lot No.", "Quality Status FND", "Expiration Date", "Posting Date", "Remaining Quantity"; // BC Upgrade BHARDA11 ----Drink-IT Field("Bin Code")

                trigger OnAfterGetRecord();
                var
                    lSKUUnitCost: Decimal;
                    lSKUDepositValue: Decimal;
                    TMPDec: Decimal;
                    lItemUnitOfMeasure: Record "Item Unit of Measure";
                    lValueToCalFromIUM: Decimal;
                    ItemLedgerEntryL: Record "Item Ledger Entry";
                begin
                    ItemTMP.RESET;
                    if not ItemTMP.GET("Item No.") then begin
                        lSKUUnitCost := 0;
                        lSKUDepositValue := 0;
                        StockkeepingUnit.RESET();
                        StockkeepingUnit.SETRANGE("Location Code", "Location Code");
                        StockkeepingUnit.SETRANGE("Item No.", "Item No.");
                        if StockkeepingUnit.FINDFIRST() then begin
                            lSKUUnitCost := StockkeepingUnit."Unit Cost";
                            // lSKUDepositValue := StockkeepingUnit."Deposit Value"; // BC Upgrade BHARAD11 ----Drink-IT Field(StockkeepingUnit."Deposit Value")
                        end;

                        ItemTMP."No." := "Item No.";
                        ItemTMP."Gross Weight" := lSKUUnitCost;
                        ItemTMP."Net Weight" := lSKUDepositValue;
                        if ItemTMP.INSERT() then;
                    end;


                    ItemLedgerEntryTMP.RESET();
                    //HEI.04>>
                    //ItemLedgerEntryTMP.SETCURRENTKEY("Item No.","Location Code",Open,"Variant Code","Unit of Measure Code","Lot No.","Serial No.");
                    ItemLedgerEntryTMP.SETCURRENTKEY("Item No.", "Location Code", "Lot No.", "Remaining Quantity");
                    //HEI.04<<
                    ItemLedgerEntryTMP.SETRANGE("Item No.", Item."No.");
                    ItemLedgerEntryTMP.SETRANGE("Location Code", "Location Code");
                    //HEI.03>>
                    /*
                    ItemLedgerEntryTMP.SETRANGE("Zone Code","Zone Code");
                    ItemLedgerEntryTMP.SETRANGE("Bin Code","Bin Code");
                    */
                    //HEI.03<<
                    ItemLedgerEntryTMP.SETRANGE("Lot No.", "Lot No.");
                    //HEI.04>>
                    if GETFILTER("Remaining Quantity") <> '' then
                        ItemLedgerEntryTMP.SETFILTER("Remaining Quantity", GETFILTER("Remaining Quantity"));
                    //HEI.04<<
                    if ItemLedgerEntryTMP.FINDFIRST() then begin
                        WEQuantityBase := 0;
                        QtyVUOM := 0;

                        //ItemLedgerEntryTMP."Qty. per Unit of Measure" += Quantity;
                        /*
                        IF "Qty. per Unit of Measure" <> 0 THEN
                          ItemLedgerEntryTMP."Qty. per Unit of Measure" += "Remaining Quantity"/"Qty. per Unit of Measure"
                          ELSE
                            ItemLedgerEntryTMP."Qty. per Unit of Measure" += 0;//Qty IUOM
                        */

                        lValueToCalFromIUM := 1;
                        // BC Upgrade BHARDA11 >> ----Drink-IT Field(Item."Inventory Unit of Measure")
                        // if lItemUnitOfMeasure.GET("Item No.", Item."Inventory Unit of Measure") then
                        //     lValueToCalFromIUM := lItemUnitOfMeasure."Qty. per Unit of Measure";
                        // BC Upgrade BHARDA11 << ----Drink-IT Field(Item."Inventory Unit of Measure")

                        if lValueToCalFromIUM <> 0 then
                            //ItemLedgerEntryTMP."Qty. per Unit of Measure" += ("Remaining Quantity" * "Qty. per Unit of Measure") / lValueToCalFromIUM
                            //HEI.03>>
                            //ItemLedgerEntryTMP."Qty. per Unit of Measure" += "Remaining Quantity" / lValueToCalFromIUM
                            ItemLedgerEntryTMP."Qty. per Unit of Measure" += Quantity / lValueToCalFromIUM
                        //HEI.03<<
                        else
                            ItemLedgerEntryTMP."Qty. per Unit of Measure" += 0; //Qty IUOM

                        /*
                        IF "Qty. per Unit of Measure" <> 0 THEN
                          WEQuantityBase := Quantity/"Qty. per Unit of Measure"
                          ELSE
                            WEQuantityBase := 0;
                        ItemLedgerEntryTMP."Vol-Strength Spec. Value" += WEQuantityBase; //Quantity (Base)
                        */
                        //ItemLedgerEntryTMP."Vol-Strength Spec. Value" += "Remaining Quantity" * "Qty. per Unit of Measure"; //Quantity (Base)
                        //HEI.03>>
                        //ItemLedgerEntryTMP."Vol-Strength Spec. Value" += "Remaining Quantity"; //Quantity (Base)
                        // ItemLedgerEntryTMP."Vol-Strength Spec. Value" += Quantity; //Quantity (Base) // BC Upgrade BHARDA11  ----Drink-IT Field(ItemLedgerEntryTMP."Vol-Strength Spec. Value")
                        //HEI.03<<

                        //HEI.04>>
                        ItemLedgerEntryTMP."Remaining Quantity" += "Remaining Quantity";
                        //HEI.04<<

                        ItemLedgerEntryTMP."Purchase Amount (Expected)" += WEQuantityBase; //for Value

                        // QtyVUOM := "Quantity in HL"; // BC Upgrade BHARDA11 ----Drink-IT Field("Quantity in HL")
                        ItemLedgerEntryTMP."Sales Amount (Actual)" += QtyVUOM;

                        ItemLedgerEntryTMP.MODIFY();
                    end
                    else begin
                        CLEAR(DimValueCode1);
                        CLEAR(DimValName1);
                        CLEAR(QtyIUOM);
                        CLEAR(QtyVUOM);
                        WEQuantityBase := 0;

                        ItemLedgerEntryTMP."Entry No." := ItemLedgerEntryTMPEntryNo;
                        ItemLedgerEntryTMP."Item No." := Item."No.";
                        ItemLedgerEntryTMP."Location Code" := "Location Code";
                        ItemLedgerEntryTMP."Zone Code FND" := "Zone Code FND";
                        // ItemLedgerEntryTMP."Bin Code" := "Bin Code"; // BC Upgrade BHARAD11 ----Drink-IT Field("Bin Code")
                        ItemLedgerEntryTMP."Lot No." := "Lot No.";

                        ItemLedgerEntryTMP."Item Category Code" := Item."Item Category Code";

                        if DefaulltDimension.GET(DATABASE::Item, Item."No.", 'CMG') then
                            DimValueCode1 := DefaulltDimension."Dimension Value Code";
                        if DimensionValue.GET('CMG', DimValueCode1) then
                            DimValName1 := DimensionValue.Name;

                        ItemLedgerEntryTMP."Source No." := DimValueCode1;
                        ItemLedgerEntryTMP."Vendor Name FND" := DimValName1;

                        ItemLedgerEntryTMP.Description := Item.Description; //Description

                        //ItemLedgerEntryTMP."Qty. per Unit of Measure" := Quantity;//Qty IUOM
                        /*
                        IF "Qty. per Unit of Measure" <> 0 THEN
                          ItemLedgerEntryTMP."Qty. per Unit of Measure" := "Remaining Quantity"/"Qty. per Unit of Measure"
                          ELSE
                            ItemLedgerEntryTMP."Qty. per Unit of Measure" := 0;//Qty IUOM
                        */
                        lValueToCalFromIUM := 1;
                        // BC Upgrade BHARDA11 >> ----Drink-IT Field(Item."Inventory Unit of Measure")
                        // if lItemUnitOfMeasure.GET("Item No.", Item."Inventory Unit of Measure") then
                        //     lValueToCalFromIUM := lItemUnitOfMeasure."Qty. per Unit of Measure";
                        // BC Upgrade BHARDA11 << ----Drink-IT Field(Item."Inventory Unit of Measure")
                        if lValueToCalFromIUM <> 0 then
                            //ItemLedgerEntryTMP."Qty. per Unit of Measure" := ("Remaining Quantity" * "Qty. per Unit of Measure") / lValueToCalFromIUM
                            //HEI.03>>
                            //ItemLedgerEntryTMP."Qty. per Unit of Measure" := "Remaining Quantity" / lValueToCalFromIUM
                            ItemLedgerEntryTMP."Qty. per Unit of Measure" := Quantity / lValueToCalFromIUM
                        //HEI.03<<
                        else
                            ItemLedgerEntryTMP."Qty. per Unit of Measure" := 0; //Qty IUOM

                        // ItemLedgerEntryTMP."Return Reason Code" := Item."Inventory Unit of Measure"; //UOM// BC Upgrade BHARDA11 >> ----Drink-IT Field(Item."Inventory Unit of Measure")

                        /*
                        IF "Qty. per Unit of Measure" <> 0 THEN
                          WEQuantityBase := Quantity/"Qty. per Unit of Measure"
                          ELSE
                            WEQuantityBase := 0;
                        ItemLedgerEntryTMP."Vol-Strength Spec. Value" := WEQuantityBase; //Quantity (Base)
                        */
                        //ItemLedgerEntryTMP."Vol-Strength Spec. Value" := "Remaining Quantity" * "Qty. per Unit of Measure"; //Quantity (Base)
                        //HEI.03>>
                        //ItemLedgerEntryTMP."Vol-Strength Spec. Value" := "Remaining Quantity"; //Quantity (Base)
                        // ItemLedgerEntryTMP."Vol-Strength Spec. Value" := Quantity; //Quantity (Base) // BC Upgrade BHARDA11 >> ----Drink-IT Field(ItemLedgerEntryTMP."Vol-Strength Spec. Value")
                        //HEI.03<<

                        //HEI.04>>
                        ItemLedgerEntryTMP."Remaining Quantity" := "Remaining Quantity";
                        //HEI.04<<

                        ItemLedgerEntryTMP."Variant Code" := Item."Base Unit of Measure"; //BOUM

                        ItemLedgerEntryTMP."Purchase Amount (Expected)" := WEQuantityBase; //for Value
                                                                                           // BC Upgrade BHARDA11 >> ----Drink-IT Field(("Strength Spec. Value")
                                                                                           // CALCFIELDS("Strength Spec. Value");
                                                                                           // ItemLedgerEntryTMP."Purchase Amount (Actual)" := "Strength Spec. Value";//StrengthSpecValueactual
                                                                                           // BC Upgrade BHARDA11 << ----Drink-IT Field(("Strength Spec. Value")

                        //HEI.04>>
                        ItemLedgerEntryL.SETCURRENTKEY("Item No.", "Location Code", "Lot No.", "Remaining Quantity", "Document Date", "Entry No.");
                        ItemLedgerEntryL.SETRANGE("Item No.", Item."No.");
                        ItemLedgerEntryL.SETRANGE("Location Code", "Location Code");
                        ItemLedgerEntryL.SETRANGE("Lot No.", "Lot No.");
                        ItemLedgerEntryL.SETFILTER("Remaining Quantity", '<>0');
                        ItemLedgerEntryL.ASCENDING(false);
                        if ItemLedgerEntryL.FINDFIRST then begin
                            "Posting Date" := ItemLedgerEntryL."Posting Date";
                            "Document Date" := ItemLedgerEntryL."Document Date";
                        end;
                        //HEI.04<<

                        ItemLedgerEntryTMP."Posting Date" := "Posting Date";
                        //HEI.02>>
                        ItemLedgerEntryTMP."Document Date" := "Document Date";
                        //HEI.02<<
                        ItemLedgerEntryTMP."Zone Code FND" := "Zone Code FND";
                        // ItemLedgerEntryTMP."Bin Code" := "Bin Code"; // BC Upgrade BHARAD11 ----Drink-IT Field(ItemLedgerEntryTMP."Bin Code")

                        // QtyVUOM := "Quantity in HL";// BC Upgrade BHARAD11 ----Drink-IT Field("Quantity in HL")
                        ItemLedgerEntryTMP."Sales Amount (Actual)" := QtyVUOM;

                        ItemLedgerEntryTMP."Quality Status FND" := "Quality Status FND";
                        ItemLedgerEntryTMP."Expiration Date" := "Expiration Date";

                        CLEAR(RemShelfLifeDays);
                        CLEAR(RemShelfLifeDaysValue);
                        if "Expiration Date" <> 0D then begin
                            RemShelfLifeDays := ("Expiration Date" - TODAY);
                            RemShelfLifeDaysValue := FORMAT(RemShelfLifeDays);
                        end else
                            RemShelfLifeDaysValue := '';
                        // ItemLedgerEntryTMP."Company Tax Warehouse Ref." := RemShelfLifeDaysValue; //Rem. Shelf Life Days // BC Upgrade BHARDA11 ----Drink-IT Field(ItemLedgerEntryTMP."Company Tax Warehouse Ref.")

                        ItemLedgerEntryTMP.INSERT();
                    end;

                    ItemLedgerEntryTMPEntryNo += 1;

                end;
            }
        }
    }

    requestpage
    {

        layout
        {
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
        MakeExcelDataHeader;
        MakeExcelDataBody;
        CreateExcelbook;

        ItemLedgerEntryTMP.DELETEALL;
        ItemTMP.DELETEALL;
    end;

    trigger OnPreReport();
    begin
        ItemLedgerEntryTMP.DELETEALL;
        ItemLedgerEntryTMPEntryNo := 1;
        ItemTMP.DELETEALL;
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        ItemLedgerEntryTMP: Record "Item Ledger Entry" temporary;
        ItemLedgerEntryTMPEntryNo: Integer;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        QtyIUOM: Decimal;
        DimValueCode1: Code[20];
        DimValName1: Text[50];
        DefaulltDimension: Record "Default Dimension";
        DimensionValue: Record "Dimension Value";
        QtyVUOM: Decimal;
        SKUUnitCost: Decimal;
        SKUDepositValue: Decimal;
        StockkeepingUnit: Record "Stockkeeping Unit";
        WEQuantityBase: Decimal;
        StrengthSpecValueactual: Integer;
        RemShelfLifeDaysValue: Text[10];
        RemShelfLifeDays: Integer;
        ItemTMP: Record Item temporary;

    procedure MakeExcelDataHeader();
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Location', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item Category Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('CMG Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);  //SIR
        ExcelBuf.AddColumn('CMG Description', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text); //SIR
        ExcelBuf.AddColumn('Item Number', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item Description', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity Inv UoM', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('UOM', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity (Base)', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        //HEI.04>>
        ExcelBuf.AddColumn('Remaining Quantity', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        //HEI.04<<
        ExcelBuf.AddColumn('UOM Base', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Stock Keeping Unit Cost', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Value', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        //HEI.04>>
        ExcelBuf.AddColumn('Value based on Remaining Quantity', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        //HEI.04<<
        ExcelBuf.AddColumn('Deposit Unit  Cost', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Deposit Value', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Lot No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Extra Content[%w/w]', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Date of Receipt/Production', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        //HEI.02>>
        ExcelBuf.AddColumn('Document Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        //HEI.02<<
        ExcelBuf.AddColumn('Zone Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Bin code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity HL', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quality Status', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Expiry Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Rem. Shelf Life Days', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody();
    var
        lItem: Record Item;
        TMPDec: Decimal;
    begin
        ItemLedgerEntryTMP.RESET;
        if ItemLedgerEntryTMP.FINDFIRST then
            repeat
                //HEI.03>>
                // if (ItemLedgerEntryTMP."Vol-Strength Spec. Value") <> 0 then begin// BC Upgrade BHARDA11 >> ----Drink-IT Field(ItemLedgerEntryTMP."Vol-Strength Spec. Value")
                //HEI.03<<
                /*
                //switch values
                TMPDec := ItemLedgerEntryTMP."Vol-Strength Spec. Value";
                ItemLedgerEntryTMP."Vol-Strength Spec. Value" := ItemLedgerEntryTMP."Qty. per Unit of Measure";
                ItemLedgerEntryTMP."Qty. per Unit of Measure" := TMPDec;
                */

                ExcelBuf.NewRow;
                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Location Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //Location Code
                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Item Category Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //Item Category Code
                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Source No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //CMG Code
                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Vendor Name FND", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //CMG Description
                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Item No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //Item No.
                ExcelBuf.AddColumn(ItemLedgerEntryTMP.Description, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //Item Description
                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Qty. per Unit of Measure", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number); //Qty IUOM
                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Return Reason Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//UOM

                // ExcelBuf.AddColumn(ItemLedgerEntryTMP."Vol-Strength Spec. Value", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number); //Quantity (Base) // BC Upgrade BHARDA11 ----Drink-IT Field(ItemLedgerEntryTMP."Vol-Strength Spec. Value") , so we add 0 in the place of ItemLedgerEntryTMP."Vol-Strength Spec. Value"
                ExcelBuf.AddColumn(0, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number); //Quantity (Base)

                //HEI.04>>
                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Remaining Quantity", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number); //Remaining Quantity
                                                                                                                                                       //HEI.04<<

                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Variant Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //BOUM

                SKUUnitCost := 0;
                SKUDepositValue := 0;
                StockkeepingUnit.RESET;
                StockkeepingUnit.SETRANGE("Location Code", ItemLedgerEntryTMP."Location Code");
                StockkeepingUnit.SETRANGE("Item No.", ItemLedgerEntryTMP."Item No.");
                if StockkeepingUnit.FINDFIRST then begin
                    SKUUnitCost := StockkeepingUnit."Unit Cost";
                    // SKUDepositValue := StockkeepingUnit."Deposit Value"; // BC Upgrade BHARDA11 ----Drink-IT Field(StockkeepingUnit."Deposit Value")
                end;

                ItemTMP.RESET;
                if SKUDepositValue = 0 then
                    if ItemTMP.GET(ItemLedgerEntryTMP."Item No.") then
                        SKUDepositValue := ItemTMP."Net Weight";

                ItemTMP.RESET;
                if SKUUnitCost = 0 then
                    if ItemTMP.GET(ItemLedgerEntryTMP."Item No.") then
                        SKUUnitCost := ItemTMP."Gross Weight";

                ExcelBuf.AddColumn(SKUUnitCost, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number); //SKUUnitCost
                                                                                                                           //ExcelBuf.AddColumn(ItemLedgerEntryTMP."Purchase Amount (Expected)"*SKUUnitCost,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number); //Value
                                                                                                                           // ExcelBuf.AddColumn(ItemLedgerEntryTMP."Vol-Strength Spec. Value" * SKUUnitCost, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number); //Value // BC Upgrade BHARDA11 ----Drink-IT Field(ItemLedgerEntryTMP."Vol-Strength Spec. Value") , so we add 0 in the place of ItemLedgerEntryTMP."Vol-Strength Spec. Value"
                ExcelBuf.AddColumn(0, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number); //Value // BC Upgrade BHARDA11 ----Drink-IT Field(ItemLedgerEntryTMP."Vol-Strength Spec. Value") , so we add 0 in the place of ItemLedgerEntryTMP."Vol-Strength Spec. Value"
                                                                                                                 //HEI.04>>
                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Remaining Quantity" * SKUUnitCost, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number); //Value based on Remaining Quantity
                                                                                                                                                                     //HEI.04<<
                ExcelBuf.AddColumn(SKUDepositValue, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number); //SKUDepositValue
                                                                                                                               //ExcelBuf.AddColumn(ItemLedgerEntryTMP."Vol-Strength Spec. Value"*SKUDepositValue,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number); //Deposit Value
                                                                                                                               // ExcelBuf.AddColumn(ItemLedgerEntryTMP."Vol-Strength Spec. Value" * SKUDepositValue, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number); //Deposit Value // BC Upgrade BHARDA11 ----Drink-IT Field(ItemLedgerEntryTMP."Vol-Strength Spec. Value") , so we add 0 in the place of ItemLedgerEntryTMP."Vol-Strength Spec. Value"
                ExcelBuf.AddColumn(0, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number); //Deposit Value // BC Upgrade BHARDA11 ----Drink-IT Field(ItemLedgerEntryTMP."Vol-Strength Spec. Value") , so we add 0 in the place of ItemLedgerEntryTMP."Vol-Strength Spec. Value"

                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Lot No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //Lot number
                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Purchase Amount (Actual)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);//StrengthSpecValueactual
                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Posting Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date); //Posting Date
                                                                                                                                       //HEI.02>>
                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Document Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date); //Document Date
                                                                                                                                        //HEI.02<<
                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Zone Code FND", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //Zone Code
                // ExcelBuf.AddColumn(ItemLedgerEntryTMP."Bin Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //Bin Code // BC Upgrade BHARAD11 ----Drink-IT Field(ItemLedgerEntryTMP."Bin Code")
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //Bin Code // BC Upgrade BHARAD11 ----Drink-IT Field(ItemLedgerEntryTMP."Bin Code")

                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Sales Amount (Actual)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number); //Quantity HL

                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Quality Status FND", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //Quality Status
                ExcelBuf.AddColumn(ItemLedgerEntryTMP."Expiration Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //Expiration Date
                // ExcelBuf.AddColumn(ItemLedgerEntryTMP."Company Tax Warehouse Ref.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //Rem. Shelf Life Days // BC Upgrade BHARAD11 ----Drink-IT Field(ItemLedgerEntryTMP."Company Tax Warehouse Ref.")
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //Rem. Shelf Life Days // BC Upgrade BHARAD11 ----Drink-IT Field(ItemLedgerEntryTMP."Company Tax Warehouse Ref.")

            //HEI.03>>
            // end;// BC Upgrade BHARDA11 << ----Drink-IT Field(ItemLedgerEntryTMP."Vol-Strength Spec. Value")
            //HEI.03<<
            until ItemLedgerEntryTMP.NEXT = 0;

    end;

    procedure CreateExcelbook();
    begin
        // BC Upgrade BHARAD11 >> ---Re-Structure ExcelBuffer code
        // ExcelBuf.CreateBookAndOpenExcel('', 'Inventory Aging', '', COMPANYNAME, USERID);
        // ERROR('');
        ExcelBuf.CreateNewBook('Inventory Aging');
        ExcelBuf.WriteSheet('Data', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename('InventoryAging');
        ExcelBuf.OpenExcel();
        // BC Upgrade BHARAD11 << ---Re-Structure ExcelBuffer code
    end;
}

