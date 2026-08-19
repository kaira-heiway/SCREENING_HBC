page 50305 "Customer Relationship"
{
    // version HEI.01

    // HEI.01 FDD Indirect Customer Master IBM.NAIKH01 28.09.2018
    //   # created a new Page

    PageType = List;
    SourceTable = "Customer Relationship FND";
    ApplicationArea = All;  // BC Upgrade COSTES04
    UsageCategory = Lists;  // BC Upgrade COSTES04

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
            }
        }
    }

    actions
    {
    }
}

