xmlport 51001 "Update ILE CBN"
{
    // HEI.01 CHG2126578 IBM.LS      21.12.2021
    //   # Created New XMLport: 50055 - Update ILE

    Caption = 'Update ILE';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;
    Permissions = TableData "Item Ledger Entry" = m;

    schema
    {
        textelement(Root)
        {
            tableelement("Item Ledger Entry"; "Item Ledger Entry")
            {
                AutoSave = false;
                XmlName = 'ILE';
                fieldelement(EntryNo; "Item Ledger Entry"."Entry No.")
                {
                }
                fieldelement(DocumentDate; "Item Ledger Entry"."Document Date")
                {
                }

                trigger OnAfterInsertRecord();
                var
                    ItemLedgerEntryL: Record "Item Ledger Entry";
                begin
                    //HEI.01>>
                    if ItemLedgerEntryL.GET("Item Ledger Entry"."Entry No.") then begin
                        ItemLedgerEntryL."Document Date" := "Item Ledger Entry"."Document Date";
                        ItemLedgerEntryL.MODIFY;
                    end;
                    //HEI.01<<
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort();
    begin
        MESSAGE('Done');
    end;
}

