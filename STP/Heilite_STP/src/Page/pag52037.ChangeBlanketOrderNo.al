page 52037 "Change Blanket Order No."
{
    // BC Upgrade KUMARS145 Page Created for the test script PTP099-Open prepayments report.
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Change Blanket Order No.';
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
            field("Blanket Order No."; Rec."Blanket Order No. FND")
            {
                Editable = true;
                ApplicationArea = all;
                ToolTip = 'Change the value of the Blanket Order No. field.';
            }
        }
    }
}
