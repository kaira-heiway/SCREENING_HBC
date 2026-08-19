page 55003 "PPV Allocation Line"
{
    // version HEI.01

    // HEI.01 CHG2193490 IBM SISUM01 26/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # new object created

    // BC Upgrade KUMARS145 Page Created.

    Caption = 'PPV Allocation Line';
    UsageCategory = None;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "PPV Allocation Line RTR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the unique sequence number of the entry.';
                }
                field("Processing Date"; Rec."Processing Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the date on which this entry was processed.';
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = all;
                    ToolTip = 'Indicates the calendar month to which the entry applies.';
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = all;
                    ToolTip = 'Indicates the calendar year to which the entry applies.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the item number related to this entry.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Describes the item or transaction.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the item category used for reporting and analysis.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the lot number associated with the item for traceability.';
                }
                field("Period Purchased Qty."; Rec."Period Purchased Qty.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the total quantity purchased during the selected period.';
                    trigger OnDrillDown();
                    begin
                        ReferenceDate := DMY2DATE(1, Rec.Month, Rec.Year);
                        DirllDownItemLedgerEntry(ILEENtryType::Purchase, ReferenceDate, CALCDATE('<CM>', ReferenceDate));
                    end;
                }
                field("Period Purchased Amount"; Rec."Period Purchased Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the total purchase amount during the selected period (in LCY unless otherwise specified).';

                    trigger OnDrillDown();
                    begin
                        ReferenceDate := DMY2DATE(1, Rec.Month, Rec.Year);
                        DirllDownItemLedgerEntry(ILEENtryType::Purchase, ReferenceDate, CALCDATE('<CM>', ReferenceDate));
                    end;
                }
                field("Purchase Unit Cost"; Rec."Purchase Unit Cost")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the unit cost used on purchase transactions for the item.';
                }
                field("As of Purchased Qty."; Rec."As of Purchased Qty.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the cumulative purchased quantity up to the specified “as of” date.';

                    trigger OnDrillDown();
                    begin
                        ReferenceDate := DMY2DATE(1, Rec.Month, Rec.Year);
                        DirllDownItemLedgerEntry(ILEENtryType::Purchase, 0D, CALCDATE('<CM>', ReferenceDate));
                    end;
                }
                field("As of Purchased Amount"; Rec."As of Purchased Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the cumulative purchased amount up to the specified “as of” date (in LCY unless otherwise specified).';

                    trigger OnDrillDown();
                    begin
                        ReferenceDate := DMY2DATE(1, Rec.Month, Rec.Year);
                        DirllDownItemLedgerEntry(ILEENtryType::Purchase, 0D, CALCDATE('<CM>', ReferenceDate));
                    end;
                }
                field("Avg. Purchased Unit Cost"; Rec."Avg. Purchased Unit Cost")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the average unit cost derived from purchase entries over the selected scope.';
                }
                field("Positive Adj. Qty"; Rec."Positive Adj. Qty")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the quantity added to inventory through positive adjustments during the period.';

                    trigger OnDrillDown();
                    begin
                        ReferenceDate := DMY2DATE(1, Rec.Month, Rec.Year);
                        DirllDownItemLedgerEntry(ILEENtryType::"Positive Adjmt.", ReferenceDate, CALCDATE('<CM>', ReferenceDate));
                    end;
                }
                field("As of Positive Adj. Qty."; Rec."As of Positive Adj. Qty.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the cumulative quantity posted as positive adjustments up to the “as of” date.';

                    trigger OnDrillDown();
                    begin
                        ReferenceDate := DMY2DATE(1, Rec.Month, Rec.Year);
                        DirllDownItemLedgerEntry(ILEENtryType::"Positive Adjmt.", 0D, CALCDATE('<CM>', ReferenceDate));
                    end;
                }
                field("Period Stock Qty."; Rec."Period Stock Qty.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the ending inventory quantity for the selected period.';

                    trigger OnDrillDown();
                    begin
                        ReferenceDate := DMY2DATE(1, Rec.Month, Rec.Year);
                        DirllDownItemLedgerEntry(ILEENtryType::" ", ReferenceDate, CALCDATE('<CM>', ReferenceDate));
                    end;
                }
                field("Period Stock Balance"; Rec."Period Stock Balance")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the inventory value (balance) at period end (in LCY unless otherwise specified).';

                    trigger OnDrillDown();
                    begin
                        ReferenceDate := DMY2DATE(1, Rec.Month, Rec.Year);
                        DirllDownItemLedgerEntry(ILEENtryType::" ", ReferenceDate, CALCDATE('<CM>', ReferenceDate));
                    end;
                }
                field("YTD Stock Qty (Rem. Qty.)"; Rec."YTD Stock Qty (Rem. Qty.)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the year‑to‑date remaining inventory quantity.';

                    trigger OnDrillDown();
                    begin
                        ReferenceDate := DMY2DATE(1, Rec.Month, Rec.Year);
                        DirllDownItemLedgerEntry(ILEENtryType::" ", 0D, CALCDATE('<CM>', ReferenceDate));
                    end;
                }
                field("YTD Stock Value"; Rec."YTD Stock Value")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the year‑to‑date inventory value (in LCY unless otherwise specified).';

                    trigger OnDrillDown();
                    begin
                        ReferenceDate := DMY2DATE(1, Rec.Month, Rec.Year);
                        DirllDownItemLedgerEntry(ILEENtryType::" ", 0D, CALCDATE('<CM>', ReferenceDate));
                    end;
                }
                field("Puchased Value of Rem. Stock"; Rec."Puchased Value of Rem. Stock")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the purchase-based value of the remaining stock (in LCY).';
                }
                field("Standard Cost"; Rec."Standard Cost")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the standard cost per unit defined for the item.';
                }
                field("Calc. Std. Value of Rem. Stock"; Rec."Calc. Std. Value of Rem. Stock")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the calculated value of remaining stock using standard cost (in LCY).';
                }
                field("Deviation (Std. Cost Related)"; Rec."Deviation (Std. Cost Related)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the variance between actual/purchase-based value and standard-cost value.';
                }
                field("PPV Line Adj. Amount"; Rec."PPV Line Adj. Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the purchase price variance (PPV) line adjustment amount (in LCY).';
                }
            }
        }
    }

    actions
    {
    }

    var
        ILEENtryType: Option " ",Purchase,"Positive Adjmt.";
        ILE: Record "Item Ledger Entry";
        ItemLedgEntryPage: Page "Item Ledger Entries";
        ReferenceDate: Date;

    local procedure DirllDownItemLedgerEntry(EntryType: Option " ",Purchase,"Positive Adjmt."; StartDate: Date; EndDate: Date);
    begin
        CLEAR(ItemLedgEntryPage);
        ILE.SETRANGE("Posting Date", StartDate, EndDate);
        ILE.SETRANGE("Item No.", Rec."Item No.");
        ILE.SETRANGE("Lot No.", Rec."Lot No.");
        case EntryType of
            EntryType::"Positive Adjmt.":
                ILE.SETRANGE("Entry Type", ILE."Entry Type"::"Positive Adjmt.");
            EntryType::Purchase:
                ILE.SETRANGE("Entry Type", ILE."Entry Type"::Purchase);
        end;
        ItemLedgEntryPage.SETTABLEVIEW(ILE);
        ItemLedgEntryPage.RUN();
    end;
}

