page 58103 GenJnlBatch_HEIFLOW
{
    // version HEI.01

    // HEI.01 CHG2132929 IBM POENAB02 18.03.2022 HeiLite GL Postings| Automation for Caribbean OpCo’s SSC
    //   #Object created

    // BC Upgrade POENAB02: Original (HeiLite) page id 50280

    Editable = false;
    PageType = List;
    SourceTable = "Gen. Journal Batch";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the general journal template associated with the journal batch.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the general journal batch.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the general journal batch.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reason code for the general journal batch.';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the balancing account type for the general journal batch.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the balancing account number for the general journal batch.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for the general journal batch.';
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posting number series for the general journal batch.';
                }
                field("Copy VAT Setup to Jnl. Lines"; Rec."Copy VAT Setup to Jnl. Lines")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to copy the VAT setup to journal lines.';
                }
                field("Allow VAT Difference"; Rec."Allow VAT Difference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to allow VAT differences in the general journal batch.';
                }
                field("Allow Payment Export"; Rec."Allow Payment Export")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to allow payment export for the general journal batch.';
                }
                field("Bank Statement Import Format"; Rec."Bank Statement Import Format")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank statement import format for the general journal batch.';
                }
                field("Template Type"; Rec."Template Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the general journal template associated with the journal batch.';
                }
                field(Recurring; Rec.Recurring)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the general journal batch is recurring.';
                }
                field("Suggest Balancing Amount"; Rec."Suggest Balancing Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to suggest a balancing amount for the general journal batch.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY) FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount in local currency for the general journal batch.';
                }
                field("Payment Method Code"; Rec."Payment Method Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the payment method code for the general journal batch.';
                }
                field(Amount; Rec."Amount FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount for the general journal batch.';
                }
                field("Debit Amount"; Rec."Debit Amount FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the debit amount for the general journal batch.';
                }
                field("Cashier Order Report ID"; Rec."Cashier Order Report ID FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the cashier order report ID for the general journal batch.';
                }
                field("Suggest Payment Param"; Rec."Suggest Payment Param FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to suggest payment parameters for the general journal batch.';
                }
                field("HNK Bank Account"; Rec."HNK Bank Account FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the HNK bank account for the general journal batch.';
                }
                field("Bank Payment Type"; Rec."Bank Payment Type FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank payment type for the general journal batch.';
                }
                field("Cashier ID"; Rec."Cashier ID FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the cashier ID for the general journal batch.';
                }
                field("Debit Amount (LCY)"; Rec."Debit Amount (LCY) FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the debit amount in local currency for the general journal batch.';
                }
                field("Credit Amount (LCY)"; Rec."Credit Amount (LCY) FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the credit amount in local currency for the general journal batch.';
                }
            }
        }
    }

    actions
    {
    }
}

