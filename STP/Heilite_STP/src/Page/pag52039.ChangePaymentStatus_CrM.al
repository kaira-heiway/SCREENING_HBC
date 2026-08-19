page 52039 "Change Payment Status CrM"
{
    // BC Upgrade KUMARS145 Page Created for the test script PTP154-Approve Invoice (no workflow).

    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Change Payment Status';
    PageType = Card;
    Editable = true;
    SourceTable = "Purch. Cr. Memo Hdr.";
    Permissions = tabledata "Purch. Inv. Header" = rm;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    layout
    {
        area(Content)
        {
            field("Payment Status"; Rec."Payment Status FND")
            {
                Editable = true;
                ApplicationArea = all;
                ToolTip = 'Change the value of the Payment Status field.';
            }
        }
    }
}
