page 50291 "H&S Tax Posting Group"
{
    // version HEI.01

    // HEI.01 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //   # New Object created

    PageType = List;
    SourceTable = "H&S Tax Posting Group FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

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
        area(processing)
        {
            action(setup)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'setup';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "H&S Tax Posting Setup";
                RunPageLink = "H&S Tax Posting Group" = FIELD(Code);
                ToolTip = 'Executes the setup action.';
                // BC Upgrade NANDIS03                ToolTip = 'Executes the setup action.';

            }
        }
    }
}

