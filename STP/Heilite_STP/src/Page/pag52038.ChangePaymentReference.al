page 52038 "Change Payment Reference"
{
    // BC Upgrade KUMARS145 Page Created for the test script PTP099-Open prepayments report.
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Change Payment Reference';
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
            field("Payment Reference"; Rec."Payment Reference")
            {
                Editable = true;
                ApplicationArea = all;
                ToolTip = 'Change the value of the Payment Reference field.';
            }
        }
    }


}
