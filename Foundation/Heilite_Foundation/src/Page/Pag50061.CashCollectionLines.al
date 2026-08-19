page 50061 "Cash Collection Lines"
{
    // HEI.02

    // 
    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP030 IBM ISYED01 04/07/2017
    //   # added fields to page  Disputed, "Disputed Reason code" .
    // 
    // HEI.02 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order

    AutoSplitKey = true;
    Caption = 'Lines';
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Cash Collection Line FND";
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
                    ShowMandatory = true;
                    ToolTip = 'Specifies the line type.';

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        //TypeOnAfterValidate;
                        //NoOnAfterValidate;
                        SetShowMandatoryConditions()
                        //HEI.02<<
                    end;
                }
                field("No."; Rec."No.")
                {
                    ShowMandatory = TypeIsGLAccount;
                    ToolTip = 'Specifies the number of the general ledger account this reminder line is for.';

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        //NoOnAfterValidate;
                        //HEI.02<<
                    end;
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
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ShowMandatory = TypeIsCustomerLedgerEntry;
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
                    ToolTip = 'Specifies the value of the Amount to Collect field.';
                }
                field("No. of Reminders"; Rec."No. of Reminders")
                {
                    BlankZero = true;
                    ToolTip = 'Specifies the reminder''s level.';
                    Visible = false;
                }
                field("Line Type"; Rec."Line Type")
                {
                    ToolTip = 'Specifies the type of the reminder line.';
                    Visible = false;
                }
                field("Applies-to Document Type"; Rec."Applies-to Document Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Applies-to Document Type field.';
                }
                field("Applies-to Document No."; Rec."Applies-to Document No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Applies-to Document No. field.';
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
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        //HEI.02>>
        SetShowMandatoryConditions();
        //HEI.02<<
    end;

    var
        TransferExtendedText: Codeunit "Transfer Extended Text";
        TypeIsCustomerLedgerEntry: Boolean;
        TypeIsGLAccount: Boolean;
        RemainingAmount_Amount: Decimal;

    local procedure SetShowMandatoryConditions();
    begin
        TypeIsGLAccount := Rec.Type = Rec.Type::"Customer Ledger Entry";
        TypeIsCustomerLedgerEntry := Rec.Type = Rec.Type::"Customer Ledger Entry";
    end;
}

