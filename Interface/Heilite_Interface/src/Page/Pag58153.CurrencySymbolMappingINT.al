page 58153 "Currency Symbol Mapping INT"
{
    Caption = 'Currency Symbol Mapping';
    PageType = List;
    SourceTable = "Currency Symbol Mapping INT";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Symbol"; Rec."Symbol") { ApplicationArea = All; }
                field("HTML Code"; Rec."HTML Code") { ApplicationArea = All; }
                field("Description"; Rec."Description") { ApplicationArea = All; }
            }
        }
    }
}
