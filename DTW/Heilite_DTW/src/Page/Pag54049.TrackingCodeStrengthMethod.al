namespace BC_DTWLocal.BC_DTWLocal;

page 54049 "TrackingCode & StrengthMethod"
{
    ApplicationArea = All;
    Caption = 'TrackingCode & StrengthMethod';
    PageType = List;
    SourceTable = "TrackingCode & StrMethod FND";
    UsageCategory = Lists;
    //BC Upgrade Kamnay01 >> Created this page to maintain the tracking code and strength method for mendix

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Tracking Code"; Rec."Tracking Code FND")
                {
                    ToolTip = 'Specifies the value of the Tracking Code field.', Comment = '%';
                }
                field("Strength Method"; Rec."Strength Method FND")
                {
                    ToolTip = 'Specifies the value of the Strength Method field.', Comment = '%';
                }
                field("New Tracking code"; Rec."New Tracking code FND")
                {
                    ToolTip = 'Specifies the value of the New Tracking code field.', Comment = '%';
                }
            }
        }
    }
}
