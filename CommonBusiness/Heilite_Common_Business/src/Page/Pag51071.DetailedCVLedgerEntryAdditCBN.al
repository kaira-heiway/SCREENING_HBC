page 51071 "Detail CVLedgerEntryAddit CBN"
{
    // version HEI.01

    // HEI.01 CHG2236692 IBM SISUM01 29.02.2024 HB3717_Development to perform revaluation for AR/AP
    //   #new object created

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Detail CVLedgerEntry Addit FND";
    ApplicationArea = All;  // BC Upgrade Manisha
    UsageCategory = Administration;  // BC Upgrade Manisha

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Source Type"; rec."Source Type")
                {
                    ToolTip = 'Specifies the value of the Source Type field.';
                }
                field("Reverse Unrealiz Gain/Loss"; rec."Reverse Unrealiz Gain/Loss")
                {
                    ToolTip = 'Specifies the value of the Reverse Unrealiz Gain/Loss field.';
                }
                field("Detaile CV Ledger Entry No."; rec."Detaile CV Ledger Entry No.")
                {
                    ToolTip = 'Specifies the value of the Detaile CV Ledger Entry No. field.';
                }
            }
        }
    }

    actions
    {
    }
}

