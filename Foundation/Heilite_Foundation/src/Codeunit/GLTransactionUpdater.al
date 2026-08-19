codeunit 51493 "GL Transaction Updater"
{
    InherentPermissions = X;
    Permissions = tabledata "G/L Entry" = RIMD,
                  tabledata "VAT Entry" = RIMD,
                  tabledata "Vendor Ledger Entry" = RIMD,
                  tabledata "Item Ledger Entry" = RIMD,
                  tabledata "Cust. Ledger Entry" = RIMD,
                  tabledata "Detailed Vendor Ledg. Entry" = RIMD,
                  tabledata "Detailed Cust. Ledg. Entry" = RIMD,
                  tabledata "Bank Account Ledger Entry" = RIMD,
                  tabledata "Employee Ledger Entry" = RIMD,
                  tabledata "Detailed Employee Ledger Entry" = RIMD,
                  tabledata "FA Ledger Entry" = RIMD,
                  tabledata "Maintenance Ledger Entry" = RIMD,
                  tabledata "WHT Entry FND" = RIMD,
                  tabledata ConditionLedgerEntry105FDW = RIMD;

    /// <summary>
    /// Captures Transaction No. into Old Transaction No. for G/L Entries and resets
    /// Transaction No. to 0 across all related ledger tables. Called from OnPreReport.
    /// </summary>
    procedure ResetGLEntryTransactionNos()
    var
        GLEntry: Record "G/L Entry";
    begin
        // G/L Entry — capture existing Transaction No. into Old Transaction No., then reset to 0
        if GLEntry.FindSet(true) then
            repeat
                GLEntry."Old Transaction No." := GLEntry."Transaction No.";
                GLEntry."Transaction No." := 0;
                GLEntry.Modify(false);
            until GLEntry.Next() = 0;
    end;

    /// <summary>
    /// Updates Transaction No. on all related ledger tables where Document No.
    /// matches DocumentNo, setting it to NewTransactionNo.
    /// Uses ModifyAll to bypass OnModify triggers and perform bulk SQL UPDATE.
    /// </summary>
    procedure UpdateRelatedTransactionNos(DocumentNo: Code[20]; NewTransactionNo: Integer)
    var
        VATEntry: Record "VAT Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        //ItemLedgerEntry: Record "Item Ledger Entry";
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        DetailedCustomerLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        EmployeeLedgerEntry: Record "Employee Ledger Entry";
        DetailedEmployeeLedgerEntry: Record "Detailed Employee Ledger Entry";
        FALedgerEntry: Record "FA Ledger Entry";
        MaintenanceLedgerEntry: Record "Maintenance Ledger Entry";
        ConditionLedgerEntry: Record ConditionLedgerEntry105FDW;
        GLEntry: Record "G/L Entry";
        WHTEntry: Record "WHT Entry FND";
    begin
        // Update G/L Entry — filter by Document No., set new Transaction No.
        GLEntry.Reset();
        GLEntry.SetRange("Document No.", DocumentNo);
        GLEntry.ModifyAll("Transaction No.", NewTransactionNo, false);

        VATEntry.Reset();
        VATEntry.SetRange("Document No.", DocumentNo);
        VATEntry.ModifyAll("Transaction No.", NewTransactionNo, false);

        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetRange("Document No.", DocumentNo);
        VendorLedgerEntry.ModifyAll("Transaction No.", NewTransactionNo, false);

        CustomerLedgerEntry.Reset();
        CustomerLedgerEntry.SetRange("Document No.", DocumentNo);
        CustomerLedgerEntry.ModifyAll("Transaction No.", NewTransactionNo, false);

        DetailedVendorLedgerEntry.Reset();
        DetailedVendorLedgerEntry.SetRange("Document No.", DocumentNo);
        DetailedVendorLedgerEntry.ModifyAll("Transaction No.", NewTransactionNo, false);

        DetailedCustomerLedgerEntry.Reset();
        DetailedCustomerLedgerEntry.SetRange("Document No.", DocumentNo);
        DetailedCustomerLedgerEntry.ModifyAll("Transaction No.", NewTransactionNo, false);

        BankAccountLedgerEntry.Reset();
        BankAccountLedgerEntry.SetRange("Document No.", DocumentNo);
        BankAccountLedgerEntry.ModifyAll("Transaction No.", NewTransactionNo, false);

        EmployeeLedgerEntry.Reset();
        EmployeeLedgerEntry.SetRange("Document No.", DocumentNo);
        EmployeeLedgerEntry.ModifyAll("Transaction No.", NewTransactionNo, false);

        DetailedEmployeeLedgerEntry.Reset();
        DetailedEmployeeLedgerEntry.SetRange("Document No.", DocumentNo);
        DetailedEmployeeLedgerEntry.ModifyAll("Transaction No.", NewTransactionNo, false);

        FALedgerEntry.Reset();
        FALedgerEntry.SetRange("Document No.", DocumentNo);
        FALedgerEntry.ModifyAll("Transaction No.", NewTransactionNo, false);

        MaintenanceLedgerEntry.Reset();
        MaintenanceLedgerEntry.SetRange("Document No.", DocumentNo);
        MaintenanceLedgerEntry.ModifyAll("Transaction No.", NewTransactionNo, false);

        WHTEntry.Reset();
        WHTEntry.SetRange("Document No.", DocumentNo);
        WHTEntry.SetFilter("Transaction No.", '<>%1', 0);
        WHTEntry.ModifyAll("Transaction No.", NewTransactionNo, false);

        ConditionLedgerEntry.Reset();
        ConditionLedgerEntry.SetRange("Document No.", DocumentNo);
        ConditionLedgerEntry.ModifyAll("Transaction No.", NewTransactionNo, false);
    end;
}
