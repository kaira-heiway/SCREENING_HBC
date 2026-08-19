page 51093 "Item Journal FactBox CBN"
{
    // version HEI.01

    // HEI.01 CHG2140470 SAHAL01 29.07.2022 # Created New Page: 50493 - Item Journal FactBox

    Caption = 'Item Journal FactBox';
    PageType = CardPart;
    SourceTable = "Item Journal Line";
    ApplicationArea = All;  // BC Upgrade Manisha
    UsageCategory = Tasks;  // BC Upgrade Manisha

    layout
    {
        area(content)
        {
            field(Quantity; rec.Quantity)
            {
                ToolTip = 'Specifies the number of units of the item to be included on the journal line.';
            }
            field("Actual Posted Consumption"; rec."Actual Posted Consumption FND")
            {
                ToolTip = 'Specifies the value of the Actual Posted Consumption field.';
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        //HEI.01>>
        rec.CALCSUMS(Quantity, "Actual Posted Consumption FND");
        //HEI.01<<
    end;
}

