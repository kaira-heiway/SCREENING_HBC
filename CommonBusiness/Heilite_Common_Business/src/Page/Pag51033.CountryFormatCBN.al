page 51033 "Country Format CBN"
{
    // version HEI.01
    //BC UPGRADE PATHAA02-18/09/25-Done

    PageType = List;
    SourceTable = "Country Format FND";
    ApplicationArea = All;  // BC Upgrade PATHAA02
    UsageCategory = Lists;  // BC Upgrade PATHAA02

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Country/Region"; Rec."Country/Region")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Country/Region field.';
                }
                field("Row No."; Rec."Row No.")
                {
                    ToolTip = 'Specifies the value of the Row No. field.';
                }
                field("Address 1 Element"; Rec."Address 1 Element")
                {
                    ToolTip = 'Specifies the value of the Address 1 Element field.';
                }
                field("Address 2 Element"; Rec."Address 2 Element")
                {
                    ToolTip = 'Specifies the value of the Address 2 Element field.';
                }
                field("Address 3 Element"; Rec."Address 3 Element")
                {
                    ToolTip = 'Specifies the value of the Address 3 Element field.';
                }
                field("Address 4 Element"; Rec."Address 4 Element")
                {
                    ToolTip = 'Specifies the value of the Address 4 Element field.';
                }
                field("Address 5 Element"; Rec."Address 5 Element")
                {
                    ToolTip = 'Specifies the value of the Address 5 Element field.';
                }
                field("Address 6 Element"; Rec."Address 6 Element")
                {
                    ToolTip = 'Specifies the value of the Address 6 Element field.';
                }
                field("Address 7 Element"; Rec."Address 7 Element")
                {
                    ToolTip = 'Specifies the value of the Address 7 Element field.';
                }
                field("Address 8 Element"; Rec."Address 8 Element")
                {
                    ToolTip = 'Specifies the value of the Address 8 Element field.';
                }
            }
        }
    }

    actions
    {
    }
}

