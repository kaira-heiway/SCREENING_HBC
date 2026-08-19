page 53051 "Sales Delivery Date"
{
    // BC Upgrade BHARDA11 >>
    // 1. OLD Page ID - 50167.
    // 2. Remove Field Direction because it is Obsolete. 
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Sales delivery Date FND";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Date"; Rec."Sales Date")
                {
                    ApplicationArea = All;
                }
                field("Sales Shipment Date"; Rec."Sales Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Execution DateTime"; Rec."Execution DateTime")
                {
                    ApplicationArea = All;
                }
                // BC Upgrade BHARDA11 >> ----Direction field is Obsolete in Business central
                // field(Direction; Rec.Direction)
                // {
                //     ApplicationArea = All;
                // }
                // BC Upgrade BHARDA11 << ----Direction field is Obsolete in Business central

            }
        }
    }

    actions
    {
    }
}

