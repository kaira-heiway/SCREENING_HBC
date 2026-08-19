page 50093 "Types of Delivery"
{
    // version HEI.01

    Caption = 'Types of Delivery';
    PageType = List;
    SourceTable = "Type of Delivery FND";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control50005; Links)
            {
                ApplicationArea = All;
            }
            systempart(Control50006; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

