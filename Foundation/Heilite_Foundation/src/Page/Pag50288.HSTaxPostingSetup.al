page 50288 "H&S Tax Posting Setup"
{
    // version HEI.01

    // HEI.01 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //   # New Object created

    PageType = List;
    SourceTable = "H&S Tax Posting Setup FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("H&S Tax Posting Group"; Rec."H&S Tax Posting Group")
                {
                    ToolTip = 'Specifies the value of the H&S Tax Posting Group field.';
                }
                field("H&S Tax %"; Rec."H&S Tax %")
                {
                    ToolTip = 'Specifies the value of the H&S Tax % field.';
                }
                field("Purchase H&S Tax Account"; Rec."Purchase H&S Tax Account")
                {
                    ToolTip = 'Specifies the value of the Purchase H&S Tax Account field.';
                }
            }
        }
    }

    actions
    {
    }
}

