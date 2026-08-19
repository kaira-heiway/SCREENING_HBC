page 52036 "Change Reason Code PPI"
{
    // BC Upgrade KUMARS145 Page Created for the test script PTP099-Open prepayments report.
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Change Reason Code';
    PageType = Card;
    Editable = true;
    SourceTable = "Purch. Inv. Header";
    Permissions = tabledata "Purch. Inv. Header" = rm;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    layout
    {
        area(Content)
        {
            field("Reason Code"; Rec."Reason Code")
            {
                Editable = true;
                ApplicationArea = all;
                ToolTip = 'Change the value of the Reason Code field.';
            }
        }
    }
}
