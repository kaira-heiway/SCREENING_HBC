page 51040 "Royalty Fees Setup CBN"
{
    // version HEI.01

    // HEI.01 FDD-RTRGAP060 IBM HORTOC01 28.08.2017
    //   # New Object created

    PageType = List;
    SourceTable = "Royalty Fee Setup FND";
    ApplicationArea = All;  // BC Upgrade SHARMP16
    UsageCategory = Administration;  // BC Upgrade SHARMP16

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Brand Code"; Rec."Brand Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Brand Code field.';
                }
                field("Brand Code Name"; Rec."Brand Code Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Brand Code Name field.';
                }
                field("Royalty %"; Rec."Royalty %")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Royalty % field.';
                }
            }
        }
    }

    actions
    {
    }
}

