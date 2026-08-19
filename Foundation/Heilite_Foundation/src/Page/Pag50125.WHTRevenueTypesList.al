page 50125 "WHT Revenue Types List"
{
    // version HEI.01

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # Object created

    Caption = 'WHT Revenue Types';
    PageType = List;
    SourceTable = "WHT Revenue Types FND";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1500000)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies code for the Revenue Type.',
                                ENA = 'Specifies code for the Revenue Type.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the description for the WHT Revenue Type.',
                                ENA = 'Specifies the description for the WHT Revenue Type.';
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the integer to group the Revenue Types.',
                                ENA = 'Specifies the integer to group the Revenue Types.';
                }
            }
        }
    }

    actions
    {
    }
}

