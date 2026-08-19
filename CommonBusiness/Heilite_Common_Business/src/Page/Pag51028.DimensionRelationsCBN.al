page 51028 "Dimension Relations CBN"
{
    // version HEI.01,Bogdan

    PageType = List;
    SourceTable = "Dimension Relations FND";
    ApplicationArea = All;  // BC Upgrade Priya
    UsageCategory = Lists;  // BC Upgrade Priya

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the value of the Order No. field.';
                }
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ToolTip = 'Specifies the value of the Dimension Code field.';
                }
            }
        }
    }

    actions
    {
    }
}

