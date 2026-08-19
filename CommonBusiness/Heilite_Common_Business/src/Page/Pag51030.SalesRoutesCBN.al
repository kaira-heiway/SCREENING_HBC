page 51030 "Sales Routes CBN"
{
    // version HEI.01
    //BC UPGRADE PATHAA02-18/09/25-Done

    DelayedInsert = false;
    MultipleNewLines = false;
    PageType = List;
    SourceTable = "Sales Routes FND";
    ApplicationArea = All;  // BC Upgrade PATHAA02
    UsageCategory = Lists;  // BC Upgrade PATHAA02

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
    }
}

