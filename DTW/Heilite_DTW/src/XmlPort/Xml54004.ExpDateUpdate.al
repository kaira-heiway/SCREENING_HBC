xmlport 54004 "ExpDate Update"
{
    //Bc Upgrade YADAVM09 Old id is-50138.
    Direction = Import;
    FieldSeparator = '|';
    Format = VariableText;
    Permissions = TableData "Item Ledger Entry" = rm,
                  TableData "Warehouse Entry" = rm;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                UseTemporary = true;
                textelement(ItemNo)
                {
                }
                textelement(LotNo)
                {
                }
                textelement(ExpDate)
                {
                }

                trigger OnAfterInsertRecord();
                begin
                    EVALUATE(ExpDateD, ExpDate);
                    ItemLedgerEntry.SETRANGE("Lot No.", LotNo);
                    ItemLedgerEntry.SETRANGE("Item No.", ItemNo);
                    ItemLedgerEntry.SETRANGE("Serial No.", '');
                    if ItemLedgerEntry.FINDSET then
                        ItemLedgerEntry.MODIFYALL("Expiration Date", ExpDateD);

                    WarehouseEntry.SETRANGE("Lot No.", LotNo);
                    WarehouseEntry.SETRANGE("Item No.", ItemNo);
                    WarehouseEntry.SETRANGE("Serial No.", '');
                    if WarehouseEntry.FINDSET then
                        WarehouseEntry.MODIFYALL("Expiration Date", ExpDateD);
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

    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        WarehouseEntry: Record "Warehouse Entry";
        ExpDateD: Date;
}

