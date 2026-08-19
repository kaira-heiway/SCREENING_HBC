page 58048 "DMS Cash Rcpt Bal G/L Account"
{
    // Heilite Navision Old Id - 50394

    // version HEI.01

    // HEI.01 CHG2160095 IBM GHOSHS05 21.07.22 -BASE-DDE driver payment integration
    //   # New Page created

    Caption = 'DMS Cash Rcpt Bal G/L Account';
    PageType = List;
    SourceTable = "DMS Cash Rcpt Bal GL Acc FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ToolTip = 'Specifies the value of the Payment Method field.';
                }
                field("Balance G/L Account"; Rec."Balance G/L Account")
                {
                    ToolTip = 'Specifies the value of the Balance G/L Account field.';
                }
                field("Cash Journal Template"; Rec."Cash Journal Template")
                {
                    ToolTip = 'Specifies the value of the Cash Journal Template field.';
                }
                field("Cash Journal Batch"; Rec."Cash Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Cash Journal Batch field.';
                }
            }
        }
    }

    actions
    {
    }
}

