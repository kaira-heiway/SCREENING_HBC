page 51087 "Transaction Code CBN"
{
    // version HEI 0.1

    // HEI.01 IBM SURYAS01 FDD-HT626 10-jan-2010
    //    # New page

    PageType = List;
    SourceTable = "Transaction Codes FND";
    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists; // BC Upgrade SHUKLP03 <<

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
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Code field.';

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Description field.';

                }
            }
        }
    }

    actions
    {
    }
}

