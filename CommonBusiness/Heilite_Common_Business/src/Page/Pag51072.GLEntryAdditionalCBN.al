page 51072 "G/L Entry Additional CBN"
{
    // version HEI.01

    // HEI.01 CHG2236692 IBM SISUM01 29.02.2024 HB3717_Development to perform revaluation for AR/AP
    //   #new object created

    Caption = 'G/L Entry Additional';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "G/L Entry Additional FND";
    ApplicationArea = All;
    UsageCategory = Lists; // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("CV No."; Rec."CV No.")
                {
                    ToolTip = 'Specifies the value of the Customer/Vendor No. field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("G/L Entry No."; Rec."G/L Entry No.")
                {
                    ToolTip = 'Specifies the value of the G/L Entry No. field.';
                }
            }
        }
    }

    actions
    {
    }
}

