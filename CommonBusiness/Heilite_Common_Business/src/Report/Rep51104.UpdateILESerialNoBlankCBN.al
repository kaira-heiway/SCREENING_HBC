report 51104 "Update ILE SerialNo Blank CBN"
{
    
    // BC Upgrade MISHRS14 >>
    // HEI.01 CHG2329306 IBM SS40 04.12.2025 Correct Phys.Inv.Jrnl for items 9900&9928 (RE02) (ref. INC5944773)
    //# Object created
    // NAV ID- 50622
    // BC Upgrade MISHRS14 <<

    Caption = 'Update ILE SerialNo Blank';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Permissions = tabledata "Item Ledger Entry" = rimd;

    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.")
                                where("Serial No." = filter('<>'''''));

            RequestFilterFields = "Entry No.";

            trigger OnPreDataItem()
            begin
                //HEI.01 >>
                if GetFilter("Entry No.") = '' then
                    Error(Text004Lbl);

                Confirmed := Confirm(Text002Lbl, false);
                if not Confirmed then
                    CurrReport.Break();

                BatchCount := Count();
                DeletedCount := 0;

                if BatchCount = 0 then
                    CurrReport.Break();

                Window.Open(
                  StrSubstNo(
                    Text001Lbl,
                    BatchCount,
                    DeletedCount,
                    "Entry No.",
                    "Serial No."));
                //HEI.01 <<
            end;

            trigger OnAfterGetRecord()
            begin
                //HEI.01 >>
                "Serial No." := '';
                Modify();

                DeletedCount += 1;

                Window.Update(1, BatchCount);
                Window.Update(2, DeletedCount);
                Window.Update(3, "Entry No.");
                Window.Update(4, "Serial No.");
                //HEI.01 <<
            end;

            trigger OnPostDataItem()
            begin
                //HEI.01 >>
                if BatchCount > 0 then
                    Window.Close();

                Message(Text003Lbl, DeletedCount);
                //HEI.01 <<
            end;
        }
    }

    var
        Window: Dialog;
        BatchCount: Integer;
        DeletedCount: Integer;
        Confirmed: Boolean;
        Text001Lbl: Label
          'Deleting Serial No...\=======\Total to Delete: #1######\Deleted So Far: #2######\--------------------------------------\Currently Deleting: #3######################\Serial No.: #4######################';
        Text002Lbl: Label
          'This will permanently delete Serial No from Item Ledger Entry. Do you want to continue?';
        Text003Lbl: Label
          'Deleted %1 Entries Serial No.';
        Text004Lbl: Label
          'Please specify a filter for Entry No.';
}
