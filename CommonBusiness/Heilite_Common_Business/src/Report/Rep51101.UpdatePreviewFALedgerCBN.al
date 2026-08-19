report 51101 "Update Preview FA Ledger CBN"
{
    // HEI.01 CHG2343884 IBM SAHAL01 10.03.2026 Preview posting blocked on the production
    //   # Created New Report: 50625 - Update Preview FA Ledger

    // BC Upgrade MISHRS14 >>
    // # Created Object
    // # Nav ID : 50625
    // BC Upgrade MISHRS14 <<
    
    Caption = 'Update Preview FA Ledger';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    dataset
    {
        dataitem("FA Ledger Entry"; "FA Ledger Entry")
        {
            RequestFilterFields = "Entry No.";

            trigger OnPreDataItem()
            begin
                //HEI.01>>
                SetFilter("Document No.", '=%1', '***');

                PurchInvHeaderL.Reset();
                PurchInvHeaderL.SetRange("No.", NewDocNo);

                if PurchInvHeaderL.FindFirst() then begin
                    SetFilter("Document Type", '<>%1', "Document Type"::"Credit Memo");
                    SetRange("Posting Date", PurchInvHeaderL."Posting Date");
                    SetRange("External Document No.", PurchInvHeaderL."Vendor Invoice No.");
                end else begin
                    PurchCrMemoHdrL.Reset();
                    PurchCrMemoHdrL.SetRange("No.", NewDocNo);

                    if PurchCrMemoHdrL.FindFirst() then begin
                        SetFilter("Document Type", '<>%1', "Document Type"::Invoice);
                        SetRange("Posting Date", PurchCrMemoHdrL."Posting Date");
                        SetRange("External Document No.", PurchCrMemoHdrL."Vendor Cr. Memo No.");
                    end;
                end;
                //HEI.01<<
            end;

            trigger OnAfterGetRecord()
            begin
                //HEI.01>>
                LineCount += 1;

                if not CountOnly then begin
                    "Document No." := NewDocNo;
                    Modify();
                end;
                //HEI.01<<
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(NewDocNo; NewDocNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Update with New Document No.';
                    }
                    field(CountOnly; CountOnly)
                    {
                        ApplicationArea = All;
                        Caption = 'Count Only';
                    }
                }
            }
        }

        actions
        {
        }
    }
    trigger OnPreReport()
    begin
        //HEI.01>>
        if "FA Ledger Entry".GetFilter("Entry No.") = '' then
            Error(Text000);

        if NewDocNo = '' then
            Error(Text001);
        //HEI.01<<
    end;

    trigger OnPostReport()
    begin
        //HEI.01>>
        if LineCount = 0 then
            Message(Text002, "FA Ledger Entry".GetFilter("Entry No."), NewDocNo)
        else begin
            if CountOnly then
                Message(Text003, LineCount);
        end;
        //HEI.01<<
    end;

    var
        PurchInvHeaderL: Record "Purch. Inv. Header";
        PurchCrMemoHdrL: Record "Purch. Cr. Memo Hdr.";
        LineCount: Integer;
        NewDocNo: Code[20];
        CountOnly: Boolean;
        Text000: Label 'Please enter an Entry No.';
        Text001: Label 'Please enter a correct Document No. to update FA Ledger Entry.';
        Text002: Label 'FA Ledger Entry not found within these Filter: Entry No. - %1, to update this new Document No. - %2.';
        Text003: Label '%1 Lines found.';
}
