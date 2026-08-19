report 55005 "PPV Allocation"
{
    // version HEI.05

    // HEI.01 CHG2193490 IBM SISUM01 27/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # new object created
    // HEI.02 CHG2193490 IBM POENAB02 03.08.2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # Modified function SetData
    // HEI.03 CHG2193490 IBM POENAB02 04.08.2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # Modified function UpdateQtyPPVAllocationLine
    // HEI.04 CHG2193490 IBM POENAB02 08.08.2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # Modified functions InsertPPVAllocationLine, UpdateAmtPPVAllocationLine
    // HEI.05 CHG2193490 IBM SISUM01 12/09/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # change sign for PPV Adjustment Amount, function UpdateAmtPPVAllocationLine, create 2 new functions for optimization UpdateQtyPPVAllocationLineNew and UpdateAmtPPVAllocationLineNew

    // BC Upgrade POENAB02: Original (HeiLite) report id 50408

    Caption = 'Run PPV Allocation';
    Permissions = TableData "PPV Allocation Header RTR" = rimd,
                  TableData "PPV Allocation Line RTR" = rimd;
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Tasks;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number);
            UseTemporary = true;

            trigger OnAfterGetRecord();
            begin
                CurrReport.Skip();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(PPVAllocationDate; PPVAllocationDateVar)
                {
                    Caption = 'End of month PPV Allocation Date';
                    ToolTip = 'Specifies the end of month PPV Allocation Date.';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        AccountingPerStartingDateVar := CalcDate('<-CM>', PPVAllocationDateVar);
                        AccountingPeriodEndingDateVar := CalcDate('<CM>', PPVAllocationDateVar);
                    end;
                }
                field(AccountingPerStartingDate; AccountingPerStartingDateVar)
                {
                    Caption = 'Accounting Period Starting Date';
                    ToolTip = 'Specifies the accounting period starting date.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(AccountingPeriodEndingDate; AccountingPeriodEndingDateVar)
                {
                    Caption = 'Accounting Period Ending Date';
                    ToolTip = 'Specifies the accounting period ending date.';
                    ApplicationArea = All;
                    Editable = false;
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

    trigger OnPreReport();
    begin
        SetData();
        CheckData();

        if GuiAllowed then
            ProgressWindow.Open(Text003);

        StartTime := Time();
        InsertPPVAllocationLine();
        //HEI.05>>
        UpdateQtyPPVAllocationLineNew();
        UpdateAmtPPVAllocationLineNew();
        //HEI.05<<

        InsertPPVAllocationHeader();

        if GuiAllowed then begin
            ProgressWindow.Close();
            Message(Text002);
            Message('Start time %1 - end time %2', StartTime, Time());
        end;
    end;

    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        InventSetup: Record "Inventory Setup";
        PPVAllocationLine: Record "PPV Allocation Line RTR";
        PPVAllocationHeader: Record "PPV Allocation Header RTR";
        Item: Record Item;

        ProgressWindow: Dialog;

        PPVAllocationDateVar: Date;
        AccountingPerStartingDateVar: Date;
        AccountingPeriodEndingDateVar: Date;
        PPVAllocLineEntryNo: Integer;
        PPVAllocHdrEntryNo: Integer;
        Month: Integer;
        Year: Integer;
        StartTime: Time;
        DoInsert: Boolean;

        Text001: Label 'PPV allocation are already calculated for this period! Please select another date.';
        Text002: Label 'The PPV Allocation have been successfully calculated';
        Text003: Label 'PPV Allocation in progress...';
        Text004: Label 'End of month PPV Allocation Date must not be empty.';

    procedure InsertPPVAllocationLine();
    var
        lqr_PPVItemLedgerEntry: Query "PPV Item Ledger Entry";
    begin
        Clear(lqr_PPVItemLedgerEntry);
        Clear(PPVAllocationHeader);
        lqr_PPVItemLedgerEntry.SetRange(FilterPostingDate, 0D, AccountingPeriodEndingDateVar);
        lqr_PPVItemLedgerEntry.SetFilter(FilterItemCategoryCode, InventSetup."Raw Pack Mat Item Cat Code FND");
        if (InventSetup."Exclude Invent. Val. Zero FND") then
            lqr_PPVItemLedgerEntry.SetRange(FIlterInventoryValueZero, false);

        lqr_PPVItemLedgerEntry.Open();
        while lqr_PPVItemLedgerEntry.Read() do begin
            PPVAllocationLine.SetRange("Item No.", lqr_PPVItemLedgerEntry.Item_No);
            PPVAllocationLine.SetRange("Lot No.", lqr_PPVItemLedgerEntry.Lot_No);
            PPVAllocationLine.SetRange(Month, Month);
            PPVAllocationLine.SetRange(Year, Year);
            if PPVAllocationLine.IsEmpty() then begin
                PPVAllocationLine.Init();
                PPVAllocationLine."Entry No." := PPVAllocLineEntryNo;
                PPVAllocationLine."Processing Date" := Today();
                PPVAllocationLine.Month := Month;
                PPVAllocationLine.Year := Year;
                Item.Get(lqr_PPVItemLedgerEntry.Item_No);
                PPVAllocationLine."Item No." := lqr_PPVItemLedgerEntry.Item_No;
                PPVAllocationLine."Item Category Code" := Item."Item Category Code";
                PPVAllocationLine.Description := lqr_PPVItemLedgerEntry.Description;
                PPVAllocationLine."Lot No." := lqr_PPVItemLedgerEntry.Lot_No;
                PPVAllocationLine."Standard Cost" := Item."Standard Cost";
                PPVAllocationLine.Insert();
                PPVAllocLineEntryNo += 1;
            end;
        end;
        lqr_PPVItemLedgerEntry.Close();
    end;

    local procedure InsertPPVAllocationHeader();
    begin
        PPVAllocationLine.SetRange(Month, Month);
        PPVAllocationLine.SetRange(Year, Year);
        if PPVAllocationLine.FindSet(false) then
            repeat
                PPVAllocationHeader.SetRange("Item No.", PPVAllocationLine."Item No.");
                PPVAllocationHeader.SetRange(Month, Month);
                PPVAllocationHeader.SetRange(Year, Year);
                if PPVAllocationHeader.IsEmpty() then begin
                    PPVAllocationHeader."Entry No." := PPVAllocHdrEntryNo;
                    PPVAllocationHeader."Processing Date" := Today();

                    PPVAllocationHeader.Month := Month;
                    PPVAllocationHeader.Year := Year;

                    PPVAllocationHeader."Standard cost" := PPVAllocationLine."Standard Cost";
                    PPVAllocationHeader."Item No." := PPVAllocationLine."Item No.";
                    PPVAllocationHeader."Item Category Code" := PPVAllocationLine."Item Category Code";
                    Item.Get(PPVAllocationLine."Item No.");
                    PPVAllocationHeader."Inventory Posting Group" := Item."Inventory Posting Group";
                    PPVAllocationHeader."Gen. Product Posting Group" := Item."Gen. Prod. Posting Group";
                    PPVAllocationHeader.Insert();
                    PPVAllocHdrEntryNo += 1;
                end;
            until PPVAllocationLine.Next() = 0;
    end;

    local procedure UpdateQtyPPVAllocationLineNew();
    var
        lq_PPVAllocCalcQty: Query "PPV Allocation Calc Qty";
    begin
        //HEI.05>>
        Clear(lq_PPVAllocCalcQty);
        Clear(PPVAllocationLine);

        lq_PPVAllocCalcQty.SetFilter(FilterItemCategoryCode, InventSetup."Raw Pack Mat Item Cat Code FND");
        if (InventSetup."Exclude Invent. Val. Zero FND") then
            lq_PPVAllocCalcQty.SetRange(FilterInventoryValueZero, false);
        lq_PPVAllocCalcQty.SetRange(FilterPostingDate, AccountingPerStartingDateVar, AccountingPeriodEndingDateVar);
        lq_PPVAllocCalcQty.Open();
        while lq_PPVAllocCalcQty.Read() do begin
            PPVAllocationLine.SetRange("Item No.", lq_PPVAllocCalcQty.Item_No);
            PPVAllocationLine.SetRange("Lot No.", lq_PPVAllocCalcQty.Lot_No);
            PPVAllocationLine.SetRange(Month, Month);
            PPVAllocationLine.SetRange(Year, Year);
            if PPVAllocationLine.FindFirst() then begin
                if (lq_PPVAllocCalcQty.Entry_Type = ItemLedgerEntry."Entry Type"::Purchase) then
                    PPVAllocationLine."Period Purchased Qty." := lq_PPVAllocCalcQty.Sum_Quantity;
                if (lq_PPVAllocCalcQty.Entry_Type = ItemLedgerEntry."Entry Type"::"Positive Adjmt.") then
                    PPVAllocationLine."Positive Adj. Qty" := lq_PPVAllocCalcQty.Sum_Quantity;
                PPVAllocationLine."Period Stock Qty." += lq_PPVAllocCalcQty.Sum_Quantity;
                PPVAllocationLine.Modify();
            end;
        end;
        lq_PPVAllocCalcQty.Close();

        Clear(lq_PPVAllocCalcQty);
        Clear(PPVAllocationLine);
        lq_PPVAllocCalcQty.SetFilter(FilterItemCategoryCode, InventSetup."Raw Pack Mat Item Cat Code FND");
        if (InventSetup."Exclude Invent. Val. Zero FND") then
            lq_PPVAllocCalcQty.SetRange(FilterInventoryValueZero, false);
        lq_PPVAllocCalcQty.SetRange(FilterPostingDate, 0D, AccountingPeriodEndingDateVar);
        lq_PPVAllocCalcQty.Open();
        while lq_PPVAllocCalcQty.Read() do begin
            PPVAllocationLine.SetRange("Item No.", lq_PPVAllocCalcQty.Item_No);
            PPVAllocationLine.SetRange("Lot No.", lq_PPVAllocCalcQty.Lot_No);
            PPVAllocationLine.SetRange(Month, Month);
            PPVAllocationLine.SetRange(Year, Year);
            if PPVAllocationLine.FindFirst() then begin
                if (lq_PPVAllocCalcQty.Entry_Type = ItemLedgerEntry."Entry Type"::Purchase) then
                    PPVAllocationLine."As of Purchased Qty." := lq_PPVAllocCalcQty.Sum_Quantity;
                if (lq_PPVAllocCalcQty.Entry_Type = ItemLedgerEntry."Entry Type"::"Positive Adjmt.") then
                    PPVAllocationLine."As of Positive Adj. Qty." := lq_PPVAllocCalcQty.Sum_Quantity;
                PPVAllocationLine."YTD Stock Qty (Rem. Qty.)" += lq_PPVAllocCalcQty.Sum_Quantity;
                PPVAllocationLine.Modify();
            end;
        end;
        lq_PPVAllocCalcQty.Close();
        //HEI.05<<
    end;

    local procedure UpdateAmtPPVAllocationLineNew();
    var
        lq_PPVAllocCalcAmts: Query "PPV Allocation Calc Amts.";
    begin
        //HEI.05>>
        Clear(lq_PPVAllocCalcAmts);
        Clear(PPVAllocationLine);
        lq_PPVAllocCalcAmts.SetRange(FilterPostingDate, AccountingPerStartingDateVar, AccountingPeriodEndingDateVar);
        lq_PPVAllocCalcAmts.SetRange(FilterPostingDateVE, AccountingPerStartingDateVar, AccountingPeriodEndingDateVar);
        lq_PPVAllocCalcAmts.SetFilter(FilterItemCategoryCode, InventSetup."Raw Pack Mat Item Cat Code FND");
        if (InventSetup."Exclude Invent. Val. Zero FND") then
            lq_PPVAllocCalcAmts.SetRange(FilterInventoryValueZero, false);
        lq_PPVAllocCalcAmts.Open();
        while lq_PPVAllocCalcAmts.Read() do begin
            PPVAllocationLine.SetRange("Item No.", lq_PPVAllocCalcAmts.Item_No);
            PPVAllocationLine.SetRange("Lot No.", lq_PPVAllocCalcAmts.Lot_No);
            PPVAllocationLine.SetRange(Month, Month);
            PPVAllocationLine.SetRange(Year, Year);
            if PPVAllocationLine.FindFirst() then begin
                if (lq_PPVAllocCalcAmts.Entry_Type = ItemLedgerEntry."Entry Type"::Purchase) then
                    PPVAllocationLine."Period Purchased Amount" += lq_PPVAllocCalcAmts.Sum_Purchase_Amount_Actual + lq_PPVAllocCalcAmts.Sum_Purchase_Amount_Expected;
                PPVAllocationLine."Period Stock Balance" += lq_PPVAllocCalcAmts.Sum_Cost_Amount_Actual + lq_PPVAllocCalcAmts.Sum_Cost_Amount_Expected;
                PPVAllocationLine.Modify();
            end;
        end;
        lq_PPVAllocCalcAmts.Close();

        Clear(PPVAllocationLine);
        Clear(lq_PPVAllocCalcAmts);
        lq_PPVAllocCalcAmts.SetRange(FilterPostingDate, 0D, AccountingPeriodEndingDateVar);
        lq_PPVAllocCalcAmts.SetRange(FilterPostingDateVE, 0D, AccountingPeriodEndingDateVar);
        lq_PPVAllocCalcAmts.SetFilter(FilterItemCategoryCode, InventSetup."Raw Pack Mat Item Cat Code FND");
        if (InventSetup."Exclude Invent. Val. Zero FND") then
            lq_PPVAllocCalcAmts.SetRange(FilterInventoryValueZero, false);
        lq_PPVAllocCalcAmts.Open();
        while lq_PPVAllocCalcAmts.Read() do begin
            PPVAllocationLine.SetRange("Item No.", lq_PPVAllocCalcAmts.Item_No);
            PPVAllocationLine.SetRange("Lot No.", lq_PPVAllocCalcAmts.Lot_No);
            PPVAllocationLine.SetRange(Month, Month);
            PPVAllocationLine.SetRange(Year, Year);
            if PPVAllocationLine.FindFirst() then begin
                if (lq_PPVAllocCalcAmts.Entry_Type = ItemLedgerEntry."Entry Type"::Purchase) then
                    PPVAllocationLine."As of Purchased Amount" += lq_PPVAllocCalcAmts.Sum_Purchase_Amount_Actual + lq_PPVAllocCalcAmts.Sum_Purchase_Amount_Expected;
                PPVAllocationLine."YTD Stock Value" += lq_PPVAllocCalcAmts.Sum_Cost_Amount_Actual + lq_PPVAllocCalcAmts.Sum_Cost_Amount_Expected;
                PPVAllocationLine.Modify();
            end;
        end;
        lq_PPVAllocCalcAmts.Close();

        Clear(PPVAllocationLine);
        PPVAllocationLine.SetRange(Month, Month);
        PPVAllocationLine.SetRange(Year, Year);
        if PPVAllocationLine.FindSet(false) then
            repeat
                if (PPVAllocationLine."Period Purchased Qty." <> 0) then
                    PPVAllocationLine."Purchase Unit Cost" := PPVAllocationLine."Period Purchased Amount" / PPVAllocationLine."Period Purchased Qty.";
                if (PPVAllocationLine."As of Purchased Qty." <> 0) then
                    PPVAllocationLine."Avg. Purchased Unit Cost" := PPVAllocationLine."As of Purchased Amount" / PPVAllocationLine."As of Purchased Qty.";
                PPVAllocationLine."Puchased Value of Rem. Stock" := PPVAllocationLine."YTD Stock Qty (Rem. Qty.)" * PPVAllocationLine."Avg. Purchased Unit Cost";
                PPVAllocationLine."Calc. Std. Value of Rem. Stock" := PPVAllocationLine."YTD Stock Qty (Rem. Qty.)" * PPVAllocationLine."Standard Cost";
                PPVAllocationLine."Deviation (Std. Cost Related)" := PPVAllocationLine."YTD Stock Value" - PPVAllocationLine."Calc. Std. Value of Rem. Stock";
                if (PPVAllocationLine."Puchased Value of Rem. Stock" = 0) then
                    PPVAllocationLine."PPV Line Adj. Amount" := 0
                else
                    //HEI.05>>
                    //PPVAllocationLine."PPV Line Adj. Amount" := PPVAllocationLine."YTD Stock Value" - PPVAllocationLine."Puchased Value of Rem. Stock";
                    PPVAllocationLine."PPV Line Adj. Amount" := -(PPVAllocationLine."YTD Stock Value" - PPVAllocationLine."Puchased Value of Rem. Stock");
                //HEI.05<<
                PPVAllocationLine.Modify();
            until PPVAllocationLine.Next() = 0;
        //HEI.05<<
    end;

    local procedure SetData();
    begin
        if (PPVAllocationDateVar = 0D) then
            Error(Text004);

        if PPVAllocationLine.FindLast() then
            PPVAllocLineEntryNo := PPVAllocationLine."Entry No." + 1
        else
            PPVAllocLineEntryNo := 1;

        //HEI.02>>
        if PPVAllocationHeader.FindLast() then
            //HEI.02<<
            PPVAllocHdrEntryNo := PPVAllocationHeader."Entry No." + 1
        else
            PPVAllocHdrEntryNo := 1;

        Month := Date2DMY(PPVAllocationDateVar, 2);
        Year := Date2DMY(PPVAllocationDateVar, 3);

        InventSetup.Get();
    end;

    local procedure CheckData();
    begin
        Clear(PPVAllocationHeader);
        PPVAllocationHeader.SetRange(Month, Month);
        PPVAllocationHeader.SetRange(Year, Year);
        if PPVAllocationHeader.FindFirst() then
            Error(Text001);
    end;
}
