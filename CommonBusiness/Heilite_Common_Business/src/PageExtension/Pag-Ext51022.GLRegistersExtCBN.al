pageextension 51022 GLRegistersExtCBN extends "G/L Registers"
{
    //     HEI.01 FDD-HT704 IBM BULIMC01 29.07.2019
    //   # new page action created "Cash Collection Receipt"
    // HEI.02 CHG2255472 IBM YADAVM09 06.08.2024 HB3976_Journal Template Name and Batch to be populated on Journal Entry
    //   # Added fields "Journal Template Name"
    layout
    {
        addafter("Journal Batch Name")
        {
            field("Journal Templ. Name"; Rec."Journal Templ. Name")
            {
                ApplicationArea = all;
                Caption = 'Journal Template Name';
                ToolTip = 'Specifies the value of the Journal Template Name field.';
            }
        }
    }

    actions
    {
        addafter("G/L Register")
        {
            action("Report Cash Collection receipt")
            {
                Caption = 'Cash Collection Receipt';
                ToolTip = 'View cash collection receipts.';
                ApplicationArea = Suite;
                Image = GLRegisters;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    CustLedgerEntry: Record "Cust. Ledger Entry";
                begin
                    //HEI.01<<
                    CustLedgerEntry.RESET();
                    CustLedgerEntry.SETRANGE("Entry No.", rec."From Entry No.", rec."To Entry No.");
                    REPORT.RUN(50293, TRUE, TRUE, CustLedgerEntry);
                    //HEI.01>>
                end;
            }
        }
    }

    var
        myInt: Integer;
}