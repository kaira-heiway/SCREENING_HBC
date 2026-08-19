page 50069 "Issued Cash Collection Lines"
{
    // version NAVW110.0,HEI.02

    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP030 IBM ISYED01 04/07/2017
    //   # added fields to page  Disputed, "Disputed Reason code" .
    //   HEI.02 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order

    AutoSplitKey = true;
    Caption = 'Issued Cash Collection Lines';
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Issue Cash Collection Line FND";
    ApplicationArea = All;  // BC Upgrade Manisha
    UsageCategory = Administration;  // BC Upgrade Manisha

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Type; Rec.Type)
                {
                    OptionCaption = ',Customer Ledger Entry';
                    ToolTip = 'Specifies the line type.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the general ledger account this reminder line is for.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting date of the customer ledger entry that this reminder line is for.';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the document date of the customer ledger entry this reminder line is for.';
                    Visible = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the document type of the customer ledger entry this reminder line is for.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the document number of the customer ledger entry this reminder line is for.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the due date of the customer ledger entry this reminder line is for.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies an entry description, based on the contents of the Type field.';
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ToolTip = 'Specifies the original amount of the customer ledger entry that this reminder line is for.';
                    Visible = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ToolTip = 'Specifies the remaining amount of the customer ledger entry this reminder line is for.';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount to Collect';
                    ToolTip = 'Specifies the amount in the currency of the reminder.';
                }
                field("No. of Reminders"; Rec."No. of Reminders")
                {
                    ToolTip = 'Specifies a number that indicates the reminder level.';
                    Visible = false;
                }
                field("Applies-To Document Type"; Rec."Applies-To Document Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Applies-To Document Type field.';
                }
                field("Applies-To Document No."; Rec."Applies-To Document No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Applies-To Document No. field.';
                }
                field(Disputed; Rec.Disputed)
                {
                    ToolTip = 'Specifies the value of the Disputed field.';
                }
                field("Disputed Reason code"; Rec."Disputed Reason code")
                {
                    ToolTip = 'Specifies the value of the Disputed Reason code field.';
                }
            }
        }
    }

    actions
    {
    }

    var
        DisputeCase: Record "Dispute Case FND";
}

