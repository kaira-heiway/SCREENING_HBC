xmlport 54000 "Export Item Journal Line BASE"
{

    //Bc Upgrade YADAVM09 Migrated 2018 to bc.
    //Bc Upgrade YADAVM09 old id is-50132.

    Direction = Export;
    FieldSeparator = '|';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Item Journal Line"; "Item Journal Line")
            {
                XmlName = 'IJL';
                SourceTableView = WHERE("Journal Template Name" = CONST('MIGRATION'), "Journal Batch Name" = CONST('MIGR_INV'));
                fieldelement(ItemNo; "Item Journal Line"."Item No.")
                {
                }
                fieldelement(Desc; "Item Journal Line".Description)
                {
                }
                fieldelement(UOM; "Item Journal Line"."Unit of Measure Code")
                {
                }
                fieldelement(LotNo; "Item Journal Line"."Lot No.")
                {
                }
                fieldelement(LocCode; "Item Journal Line"."Location Code")
                {
                }
                fieldelement(ZoneCode; "Item Journal Line"."Zone Code FND")
                {
                }
                fieldelement(BinCode; "Item Journal Line"."Bin Code")
                {
                }
                fieldelement(Qty; "Item Journal Line".Quantity)
                {
                }
                fieldelement(UnitCost; "Item Journal Line"."Unit Cost")
                {
                }
                fieldelement(ItemCategoryCode; "Item Journal Line"."Item Category Code")
                {
                }
                fieldelement(ExpirationDate; "Item Journal Line"."Expiration Date")
                {
                }
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
}

