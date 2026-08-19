codeunit 51023 INC3768532CBN
{
    // HEI.01 MARTIR52
    //   # Correction on "Transaction No." for all the related entries:
    //     - VAT Entry
    //     - Customer Ledger Entry
    //     - Detailed Customer Ledger Entry
    //     - Vendor Ledger Entry
    //     - Detailed Vendor Ledger Entry

    Permissions = TableData "Cust. Ledger Entry" = rm,
                  TableData "Vendor Ledger Entry" = rm,
                  TableData "VAT Entry" = rm,
                  TableData "Detailed Cust. Ledg. Entry" = rm,
                  TableData "Detailed Vendor Ledg. Entry" = rm;

    trigger OnRun();
    begin
        VATEntry.RESET();
        CustLedgerEntry.RESET();
        VendorLedgerEntry.RESET();
        DetailedCustLedgEntry.RESET();
        DetailedVendorLedgEntry.RESET();
        GLEntry.RESET();
        CountingL := 0;

        // Updateing VAT Entry Table
        VATEntry.SETRANGE("Entry No.", 8619951, 8690442);
        if VATEntry.findset() then
            repeat
                N_Tr := 0;
                if VATEntry."Transaction No." < 17599156 then begin
                    N_Tr := VATEntry."Transaction No." + 17599156;
                    VATEntry."Transaction No." := N_Tr;
                    VATEntry.MODIFY();
                end;
            until VATEntry.NEXT() = 0;

        //Updating Customer Ledger Entry Table
        CustLedgerEntry.SETRANGE("Entry No.", 49580328, 49793546);
        if CustLedgerEntry.findset() then
            repeat
                N_Tr := 0;
                if CustLedgerEntry."Transaction No." < 17599156 then begin
                    N_Tr := CustLedgerEntry."Transaction No." + 17599156;
                    CustLedgerEntry."Transaction No." := N_Tr;
                    CustLedgerEntry.MODIFY();
                end;
            until CustLedgerEntry.NEXT() = 0;

        //Updating Detailed Customer Ledger Entry Table
        DetailedCustLedgEntry.SETRANGE("Entry No.", 237978, 239840);
        DetailedCustLedgEntry.SETFILTER("Entry Type", '<>%1', DetailedCustLedgEntry."Entry Type"::Application);
        if DetailedCustLedgEntry.findset() then
            repeat
                N_Tr := 0;
                if (DetailedCustLedgEntry."Transaction No." < 17599156) and (DetailedCustLedgEntry."Transaction No." > 0) then begin
                    N_Tr := DetailedCustLedgEntry."Transaction No." + 17599156;
                    DetailedCustLedgEntry."Transaction No." := N_Tr;
                    DetailedCustLedgEntry.MODIFY();
                end;
            until DetailedCustLedgEntry.NEXT() = 0;

        //Updating Vendor Ledger Entry Table
        VendorLedgerEntry.SETRANGE("Entry No.", 49580653, 49793332);
        if VendorLedgerEntry.findset() then
            repeat
                N_Tr := 0;
                if VendorLedgerEntry."Transaction No." < 17599156 then begin
                    N_Tr := VendorLedgerEntry."Transaction No." + 17599156;
                    VendorLedgerEntry."Transaction No." := N_Tr;
                    VendorLedgerEntry.MODIFY();
                end;
            until VendorLedgerEntry.NEXT() = 0;

        //Updating Detailed Vendor Ledger Entry Table
        DetailedVendorLedgEntry.SETRANGE("Entry No.", 118183, 118861);
        DetailedVendorLedgEntry.SETFILTER("Entry Type", '<>%1', DetailedVendorLedgEntry."Entry Type"::Application);
        if DetailedVendorLedgEntry.findset() then
            repeat
                N_Tr := 0;
                if (DetailedVendorLedgEntry."Transaction No." < 17599156) and (DetailedVendorLedgEntry."Transaction No." <> 0) then begin
                    N_Tr := DetailedVendorLedgEntry."Transaction No." + 17599156;
                    DetailedVendorLedgEntry."Transaction No." := N_Tr;
                    DetailedVendorLedgEntry.MODIFY();
                end;
            until DetailedVendorLedgEntry.NEXT() = 0;

        MESSAGE('Done');
    end;

    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        GLEntry: Record "G/L Entry";
        VATEntry: Record "VAT Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        CountingL: Integer;
        N_Tr: Integer;
}

