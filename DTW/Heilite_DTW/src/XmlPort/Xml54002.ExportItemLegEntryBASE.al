xmlport 54002 "Export Item Leg. Entry BASE"
{

    //Bc Upgrade YADAVM09 Drink it field blocked.
    //Bc Upgrade YADAVM09 Migrated 2018 to bc.
    //Bc Upgrade YADAVM09 old id is-50133.
    Direction = Export;
    FieldSeparator = '|';
    Format = VariableText;



    schema
    {
        textelement(Root)
        {
            tableelement("Item Ledger Entry"; "Item Ledger Entry")
            {
                XmlName = 'ILE';
                SourceTableView = WHERE("Document No." = CONST('MIGRSP'));
                fieldelement(ItemNo; "Item Ledger Entry"."Item No.")
                {
                }
                fieldelement(PostingDate; "Item Ledger Entry"."Posting Date")
                {
                }
                fieldelement(Desc; "Item Ledger Entry".Description)
                {
                }
                fieldelement(DocNo; "Item Ledger Entry"."Document No.")
                {
                }
                fieldelement(LocCode; "Item Ledger Entry"."Location Code")
                {
                }
                fieldelement(LotNo; "Item Ledger Entry"."Lot No.")
                {
                }
                fieldelement(Qty; "Item Ledger Entry".Quantity)
                {
                }
                fieldelement(UnitCost; "Item Ledger Entry"."Cost Amount (Actual)")
                {
                }
                fieldelement(UOM; "Item Ledger Entry"."Unit of Measure Code")
                {
                }
                // fieldelement(BinCode;"Item Ledger Entry"."Bin Code")
                // {
                // }//Bc Upgrade YADAVM09 Drink it fields<<
                fieldelement(ItemCatCode; "Item Ledger Entry"."Item Category Code")
                {
                }
                fieldelement(ExpDate; "Item Ledger Entry"."Expiration Date")
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

