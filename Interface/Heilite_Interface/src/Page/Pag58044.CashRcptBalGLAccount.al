page 58044 "Cash Rcpt Bal G/L Account"
{
    // Heilite Navision Old Id - 50387

    // version HEI.01

    // HEI.01 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # New Page created to store Balance G/L Accouts for Payment Interface
    
    // BC Upgrade PATELP08>>
    // Changed name of table from "Cash Rcpt Bal G/L Account" to "Cash Rcpt Bal G/L Account FND"
    // BC Upgrade PATELP08<<

    Caption = 'Cash Receipt Balance G/L Account';
    PageType = List;
    SourceTable = "Cash Rcpt Bal G/L Account FND";
    ApplicationArea = All; // BC Upgrade NANDIS03
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
                field("Cash Journal Template"; Rec."Cash Journal Template")
                {
                    ToolTip = 'Specifies the value of the Cash Journal Template field.';
                }
                field("Cash Journal Batch"; Rec."Cash Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Cash Journal Batch field.';
                }
                field("Balance G/L Account"; Rec."Balance G/L Account")
                {
                    ToolTip = 'Specifies the value of the Balance G/L Account field.';
                }
            }
        }
    }

    actions
    {
    }
}

