page 51107 "Journ. Comment List CBN"
{
    // BC Upgrade MISHRS14 >>
    // Created Page - NAV ID : 50667
    // HEI.01 CHG2336029 SS40 17.03.2026 # Workflow Approval Functionality for Stock Adjustments
    // # New page created
    // BC Upgrade MISHRS14 <<

    ApplicationArea = All;
    Caption = 'Comment List';
    PageType = List;
    SourceTable = "Jour. Comment Line FND";
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;

    DataCaptionFields = "Journal Template Name", "Journal Batch Name";

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
            }
        }
    }
}
