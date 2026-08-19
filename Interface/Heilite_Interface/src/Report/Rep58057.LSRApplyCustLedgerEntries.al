report 58057 "LSR Apply Cust. Ledger Entries"
{
    // version HEI.03

    // HEI.01 CHG2213859 COSTES04 15.09.2023 Customer Ledger entries apply matching entries
    //   # New report developed
    // HEI.02 CHG2213859 SISUM01 22.09.2023 Customer Ledger entries apply matching entries
    //   # Change code in Cust. Ledger Entry - OnAfterGetRecord
    // HEI.03 CHG2228831 IBM SISUM01 10.01.2024 HB3670-Bahamas-Enhancement to Customer Ledger Entries apply matching Entries
    //   # for manual run, the app date can be set by user in request page

    //Bc Upgrade YADAVM09 Old id is 50477.
    //Bc Upgrade YADAVM09 change parameters of function Apply.

    Caption = 'LSR Apply Cust. Ledger Entries';
    Permissions = TableData "Cust. Ledger Entry" = r;
    ProcessingOnly = true;
    ApplicationArea = All;//Bc Upgrade YADAVM09<<
    UsageCategory = ReportsAndAnalysis;//Bc Upgrade YADAVM09<<

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            RequestFilterFields = "Posting Date", "Customer No.", "External Document No.", "Document No.";

            trigger OnAfterGetRecord();
            var
                lCustLedgEntry: Record "Cust. Ledger Entry";
                ApplyUnapplyParameters: Record "Apply Unapply Parameters";
            begin
                RemainingAmount := "Remaining Amount";

                if GUIALLOWED then begin
                    W.UPDATE(1, "Cust. Ledger Entry"."Customer No.");
                    W.UPDATE(2, "Cust. Ledger Entry"."Document No.");
                end;

                ApplyCustLedgerEntry.SETRANGE("Customer No.", "Customer No.");
                ApplyCustLedgerEntry.SETRANGE("Document Type", "Document Type"::Invoice);
                ApplyCustLedgerEntry.SETRANGE("Source System Identifier FND", LSRInterfaceSetup."Source System Identifier");
                ApplyCustLedgerEntry.SETRANGE(Open, true);
                ApplyCustLedgerEntry.SETRANGE("External Document No.", "External Document No.");
                ApplyCustLedgerEntry.SETAUTOCALCFIELDS("Remaining Amount");
                if ApplyCustLedgerEntry.FINDSET(false) then
                    repeat
                        RemainingAmount -= ApplyCustLedgerEntry."Remaining Amount";
                        ApplyCustLedgerEntry2.COPYFILTERS(ApplyCustLedgerEntry);
                        ApplyCustLedgerEntry2.GET(ApplyCustLedgerEntry."Entry No.");
                        //HEI.02>>
                        if (ApplyCustLedgerEntry2."Applies-to ID" = '') then
                            //HEI.02<<
                            CustEntrySetApplID.SetApplId(ApplyCustLedgerEntry2, "Cust. Ledger Entry", '');
                        //HEI.02>>
                        //CustEntrySetApplID.SetApplId("Cust. Ledger Entry",ApplyCustLedgerEntry2,'');
                        //CustEntryApplyPostedEntries.Apply(ApplyCustLedgerEntry2,NewDocumentNo,ApplicationDate);
                        lCustLedgEntry.SETRANGE("Entry No.", "Cust. Ledger Entry"."Entry No.");
                        lCustLedgEntry.FINDFIRST();
                        if (lCustLedgEntry."Applies-to ID" = '') then
                            CustEntrySetApplID.SetApplId(lCustLedgEntry, ApplyCustLedgerEntry2, '');
                        //CustEntryApplyPostedEntries.Apply(lCustLedgEntry, NewDocumentNo, ApplicationDate);//Bc Upgrade YADAVM09<<
                        ApplyUnapplyParameters.Get("Entry No.");//Bc Upgrade YADAVM09<<
                        CustEntryApplyPostedEntries.Apply(lCustLedgEntry, ApplyUnapplyParameters);//Bc Upgrade YADAVM09<<
                    //HEI.02<<

                    until (ApplyCustLedgerEntry.NEXT = 0) or (RemainingAmount <= 0);
            end;

            trigger OnPostDataItem();
            begin
                if GUIALLOWED then
                    W.CLOSE;
            end;

            trigger OnPreDataItem();
            begin
                if GUIALLOWED then begin
                    if GETFILTERS = '' then
                        ERROR(PostingDateFilterErr);
                    ApplicationDate := ReqApplicationDate; //HEI.03
                end else
                    SETRANGE("Posting Date", TODAY - 1, TODAY);

                SETRANGE("Source System Identifier FND", LSRInterfaceSetup."Source System Identifier");
                SETRANGE("Document Type", CustLedgerEntry."Document Type"::Payment);
                SETRANGE(Open, true);
                SETAUTOCALCFIELDS("Remaining Amount");
                if GUIALLOWED then
                    W.OPEN(Text001);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                //Caption = 'General';//Bc Upgrade YADAVM09<<
                group(Options)
                {
                    Caption = 'Options';
                    field("Application Posting Date"; ReqApplicationDate)
                    {
                        Caption = 'Application Posting Date';
                        ApplicationArea = All;
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

    trigger OnPreReport();
    begin
        LSRInterfaceSetup.GET;
        LSRInterfaceSetup.TESTFIELD("Source System Identifier");
    end;

    var
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        ApplyCustLedgerEntry: Record "Cust. Ledger Entry";
        ApplyCustLedgerEntry2: Record "Cust. Ledger Entry";
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        CustEntryApplyPostedEntries: Codeunit "CustEntry-Apply Posted Entries";
        RemainingAmount: Decimal;
        NewDocumentNo: Code[20];
        ApplicationDate: Date;
        ReqApplicationDate: Date;
        W: Dialog;
        Text001: Label 'Customer No. : #1#########\Document No.: #2########';
        PostingDateFilterErr: Label 'Please select Posting Date filter.';
}

