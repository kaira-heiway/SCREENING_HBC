codeunit 51019 "VLE-Clear Batch & AppID CBN"
{
    // version HEI.01

    // HEI.01 CHG2200646 IBM POENAB02 13.04.2023 Unable to clear migrated values
    //   # Object created
    //   # Clears "Batch payment name" and "Applies-to ID" from Vendor Ledger Entry, for the records that contain incorrect values
    //   # INC4601006, INC4526204

    Permissions = TableData "Vendor Ledger Entry" = rm;

    trigger OnRun();
    begin
        VendorLedgerEntry.SETFILTER("Applies-to ID", '<>%1', '');
        if VendorLedgerEntry.findset() then
            repeat
                GenJournalLine.SETRANGE("Document No.", VendorLedgerEntry."Applies-to ID");
                if not GenJournalLine.FINDFIRST() then begin
                    RecUser.SETRANGE(RecUser."User Name", VendorLedgerEntry."Applies-to ID");
                    if not RecUser.FINDFIRST() then begin
                        VendorLedgerEntry."Applies-to ID" := '';
                        VendorLedgerEntry."Batch payment name FND" := '';
                        VendorLedgerEntry.MODIFY();
                    end;
                end;
            until VendorLedgerEntry.NEXT() = 0;

        VendorLedgerEntry.RESET();
        VendorLedgerEntry.SETRANGE("Applies-to ID", '');
        VendorLedgerEntry.SETFILTER("Batch payment name FND", '<>%1', '');
        if VendorLedgerEntry.findset() then
            repeat
                VendorLedgerEntry."Batch payment name FND" := '';
                VendorLedgerEntry.MODIFY();
            until VendorLedgerEntry.NEXT() = 0;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        RecUser: Record User;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
}

