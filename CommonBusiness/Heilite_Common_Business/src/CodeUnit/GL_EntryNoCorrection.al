codeunit 51040 "GL Entry No Correction"
{
    InherentPermissions = X;

    Permissions =
        tabledata "G/L Entry" = RIMD,
        tabledata "G/L Register" = RIMD,
        tabledata "Vendor Ledger Entry" = RIMD;

    trigger OnRun()
    var
        GLEntry: Record "G/L Entry";
        TempGLEntry: Record "G/L Entry" temporary;
        NewGLEntry: Record "G/L Entry";
        GLRegister: Record "G/L Register";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        LastEntryNo: Integer;
        LastTransactionNo: Integer;
        FromEntryNo: Integer;
        ToEntryNo: Integer;
    begin
        GLEntry.FindLast();
        LastEntryNo := GLEntry."Entry No.";
        LastTransactionNo := GLEntry."Transaction No." + 1;
        FromEntryNo := LastEntryNo + 1;

        GLEntry.Reset();
        GLEntry.SetRange("Document No.", 'PM00001178');
        if GLEntry.FindSet() then
            repeat
                TempGLEntry := GLEntry;
                TempGLEntry.Insert();
            until GLEntry.Next() = 0;

        if TempGLEntry.FindSet() then
            repeat
                LastEntryNo += 1;
                GLEntry.Reset();
                if not GLEntry.Get(TempGLEntry."Entry No.") then
                    Error('G/L Entry %1 not found. Aborting.', TempGLEntry."Entry No.");
                GLEntry.Delete();

                NewGLEntry := TempGLEntry;
                NewGLEntry."Entry No." := LastEntryNo;
                NewGLEntry."Transaction No." := LastTransactionNo;
                NewGLEntry.Insert();
            until TempGLEntry.Next() = 0;
        ToEntryNo := LastEntryNo;

        GLRegister.SetRange("From Entry No.", 9073);
        if GLRegister.FindFirst() then begin
            GLRegister."From Entry No." := FromEntryNo;
            GLRegister."To Entry No." := ToEntryNo;
            GLRegister.Modify();
        end;

        VendorLedgerEntry.SetRange("Entry No.", 9073);
        if VendorLedgerEntry.FindFirst() then begin
            VendorLedgerEntry.Rename(ToEntryNo);
            VendorLedgerEntry."Transaction No." := LastTransactionNo;
            VendorLedgerEntry.Modify();
        end;

        Commit();
    end;

}
