page 54014 "Zone Movement Details"
{//BC Upgrade Kamnay01 Original(Heilite) page id 50019
    // version HEI.01

    PageType = CardPart;
    SourceTable = "Warehouse Activity Header";
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            field("Whse. Entries"; Rec."Whse. Entries FND")
            {
            }
            field("Posted Shipments"; Rec."Posted Shipments FND")
            {
            }
            field("Posted Receipts"; Rec."Posted Receipts FND")
            {
            }
        }
    }

    actions
    {
    }
}

