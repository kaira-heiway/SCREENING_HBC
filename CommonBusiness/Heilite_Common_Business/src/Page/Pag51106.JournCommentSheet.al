page 51106 "Journ. Comment Sheet CBN"
{
    // BC Upgrade MISHRS14 >>
    // Created Page : NAV ID - 50666
    // HEI.01 CHG2336029 SS40 17.03.2026 # Workflow Approval Functionality for Stock Adjustments
    // # New page created
    // BC Upgrade MISHRS14 <<

    ApplicationArea = All;
    Caption = 'Journ. Comment Sheet';
    PageType = List;
    SourceTable = "Jour. Comment Line FND";
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                    ToolTip = 'Specifies the date the comment was created.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comment';
                    ToolTip = 'Specifies the comment itself.';
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                    Caption = 'Journal Template Name';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    Caption = 'Journal Batch Name';
                }
            }
        }
    }
}
