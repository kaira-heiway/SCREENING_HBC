codeunit 51004 "Payment Block CBN"
{
    // version ESKER1.2.0,HEI.01
    // BC Upgrade BHARDA11 ----No Changes
    Permissions = TableData "Vendor Ledger Entry" = rimd;

    trigger OnRun();
    begin
    end;

    procedure FctSetPaymentOnHold(DocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund; DocNo: Code[20]; VendorNo: Code[20]; PostingDate: Date);
    var
        RecLVendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        RecLVendorLedgerEntry.RESET();
        RecLVendorLedgerEntry.SETCURRENTKEY("Vendor No.", "Document No.", "Posting Date");
        RecLVendorLedgerEntry.SETRANGE("Vendor No.", VendorNo);
        RecLVendorLedgerEntry.SETRANGE("Document Type", DocType);
        RecLVendorLedgerEntry.SETRANGE("Document No.", DocNo);
        RecLVendorLedgerEntry.SETRANGE("Posting Date", PostingDate);
        RecLVendorLedgerEntry.SETFILTER("On Hold", '<>%1', '');
        if RecLVendorLedgerEntry.FINDFIRST then begin
            RecLVendorLedgerEntry."On Hold" := '';
            RecLVendorLedgerEntry.MODIFY;
        end;
    end;
}

