page 50230 "Gate Comment Sheet"
{
    // version HEI.01

    // HEI:EDD001:1:1 12/11/14 TECTURA-HKH
    //   # New Form Created for Gate Entry
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Page from HEI2.0

    AutoSplitKey = true;
    CaptionML = ENU = 'Gate Comment Sheet',
                FRA = 'Gate Comment Sheet';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = Card;
    SourceTable = "Gate Comment Line FND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Code field.';
                }
            }
        }
    }

    actions
    {
    }
}

