page 51034 "Payment Jour Archive Tree CBN"
{
    // version HEI.03

    // HEI.01 PTPGAP068 IBM COSTES02 18.08.2017 Payment reconciliation grouping/archiving
    //   # New page created based on standard Payment Journal page
    // HEI.02 PTPGAP083 IBM NASTAA02 05.03.2018 # Mark Reversed Rejected Payments
    //   # Added "Due Date" Field
    //   # Added "Reversed" Field
    // 
    // HEI.03 PTPGAP078 IBM POSTOI01 18.05.2018
    //   # show new field 50043
    //   # show new field 50044

    // BC Upgrade KUMARS145 Nav ID Page 50124 "Payment Journal Archive Tree"

    AutoSplitKey = true;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Payment Journal Tree Archive';
    DelayedInsert = true;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Bank,Prepare,Approve';
    SaveValues = true;
    SourceTable = "Gen. Journal Line Archive FND";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = Rec."Tree Level";
                ShowAsTree = true;
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Journal Template Name';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Journal Batch Name';
                }
                field("Archive Document No."; Rec."Archive Document No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Archive Document No.';
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Version No.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a document number for the journal line.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Style = Attention;
                    ToolTip = 'Specifies the date on the document that provides the basis for the entry on the journal line.';
                    Visible = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of document that the entry on the journal line is.';
                }
                field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the incoming document that this general journal line is created for.';
                    Visible = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                }
                field("Applies-to Ext. Doc. No."; Rec."Applies-to Ext. Doc. No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the external document number that will be exported in the payment file.';
                    Visible = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of account that the entry on the journal line will be posted to.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the account number that the entry on the journal line will be posted to.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Vendor Name';
                }
                field("<Account No.>"; Rec."Vendor Bank Account")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Vendor Bank Account';
                }
                field("Vendor Bank Acc. Name"; Rec."Vendor Bank Acc. Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Vendor Bank Acc. Name';
                }
                field("Vendor Bank Acc. Branch No."; Rec."Vendor Bank Acc. Branch No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Vendor Bank Acc. Branch No.';
                }
                field("Vendor Bank Acc. No."; Rec."Vendor Bank Acc. No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Vendor Bank Acc. No.';
                }
                field("Vandor Bank Acc. Swift Code"; Rec."Vandor Bank Acc. Swift Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Vandor Bank Acc. Swift Code';
                }
                field("HNK Bank Account"; Rec."HNK Bank Account")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the HNK Bank Account';
                }
                field("HNK Check No."; Rec."HNK Check No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the HNK Check No.';
                }
                field("Recipient Bank Account"; Rec."Recipient Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the bank account that the amount will be transferred to after it has been exported from the payment journal.';
                }
                field("Message to Recipient"; Rec."Message to Recipient")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the message exported to the payment file when you use the Export Payments to File function in the Payment Journal window.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a description of the entry. The field is automatically filled when the Account No. field is filled.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the salesperson or purchaser who is linked to the journal line.';
                    Visible = false;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the number of the campaign the journal line is linked to.';
                    Visible = false;
                }
                // BC Upgrade KUMARS145 Drinkit Fields Commented ...>>
                // field("Contract Type"; Rec."Contract Type")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Service Contract No."; Rec."Service Contract No.")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("Financial Contract No."; Rec."Financial Contract No.")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // BC Upgrade KUMARS145 Drinkit Fields Commented ...<<
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Posting Group';
                    Visible = false;
                }
                // BC Upgrade KUMARS145 Drinkit Fields Commented ...>>
                // field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("Contract Group Code"; Rec."Contract Group Code")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("Building No."; Rec."Building No.")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("Item Charge Type"; Rec."Item Charge Type")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // BC Upgrade KUMARS145 Drinkit Fields Commented ...<<
            }
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = Suite;
                AssistEdit = true;
                ToolTip = 'Specifies the code of the currency for the amounts on the journal line.';
            }
            field("Gen. Posting Type"; Rec."Gen. Posting Type")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the general posting type that will be used when you post the entry on this journal line.';
                Visible = false;
            }
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the code of the general business posting group that will be used when you post the entry on the journal line.';
                Visible = false;
            }
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the code of the general product posting group that will be used when you post the entry on the journal line.';
                Visible = false;
            }
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the VAT business posting group code that will be used when you post the entry on the journal line.';
                Visible = false;
            }
            field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the code of the VAT product posting group that will be used when you post the entry on the journal line.';
                Visible = false;
            }
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = Basic, Suite;
                ShowMandatory = true;
                ToolTip = 'Specifies the payment method that was used to make the payment that resulted in the entry.';
            }
            field("Payment Reference"; Rec."Payment Reference")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the payment of the purchase invoice.';
            }
            field("Creditor No."; Rec."Creditor No.")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the vendor who sent the purchase invoice.';
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = Basic, Suite;
                ShowMandatory = true;
                ToolTip = 'Specifies the total amount (including VAT) that the journal line consists of.';
            }
            field("Debit Amount"; Rec."Debit Amount")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a debit amount. The amount must be entered in the currency represented by the currency code on the line.';
                Visible = false;
            }
            field("Credit Amount"; Rec."Credit Amount")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a credit amount. The amount must be entered in the currency represented by the currency code on the line.';
                Visible = false;
            }
            field("VAT Amount"; Rec."VAT Amount")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the amount of VAT included in the total amount.';
                Visible = false;
            }
            field("VAT Difference"; Rec."VAT Difference")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the difference between the calculate VAT amount and the VAT amount that you have entered manually.';
                Visible = false;
            }
            field("Bal. VAT Amount"; Rec."Bal. VAT Amount")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the amount of Bal. VAT included in the total amount.';
                Visible = false;
            }
            field("Bal. VAT Difference"; Rec."Bal. VAT Difference")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the difference between the calculate VAT amount and the VAT amount that you have entered manually.';
                Visible = false;
            }
            field("Bal. Account Type"; Rec."Bal. Account Type")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the code for the balancing account type that should be used in this journal line.';
            }
            field("Bal. Account No."; Rec."Bal. Account No.")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the number of the general ledger, customer, vendor, or bank account to which a balancing entry for the journal line will posted (for example, a cash account for cash purchases).';
            }
            field("Bal. Gen. Posting Type"; Rec."Bal. Gen. Posting Type")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the general posting type that will be used when you post the entry on the journal line.';
                Visible = false;
            }
            field("Bal. Gen. Bus. Posting Group"; Rec."Bal. Gen. Bus. Posting Group")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the code of the general business posting group that will be used when you post the entry on the journal line.';
                Visible = false;
            }
            field("Bal. Gen. Prod. Posting Group"; Rec."Bal. Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the code of the general product posting group that will be used when you post the entry on the journal line.';
                Visible = false;
            }
            field("Bal. VAT Bus. Posting Group"; Rec."Bal. VAT Bus. Posting Group")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the code of the VAT business posting group that will be used when you post the entry on the journal line.';
                Visible = false;
            }
            field("Bal. VAT Prod. Posting Group"; Rec."Bal. VAT Prod. Posting Group")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the code of the VAT product posting group that will be used when you post the entry on the journal line.';
                Visible = false;
            }
            field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = Suite;
                ToolTip = 'Specifies the code for Shortcut Dimension 1.';
                Visible = false;
            }
            field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = Suite;
                ToolTip = 'Specifies the code for Shortcut Dimension 2.';
                Visible = false;
            }
            field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
            }
            field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
            }
            field("Applies-to ID"; Rec."Applies-to ID")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the entries that will be applied to by the journal line if you use the Apply Entries facility.';
                Visible = false;
            }
            field("Bank Payment Type"; Rec."Bank Payment Type")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the code for the payment type to be used for the entry on the payment journal line.';
            }
            field("Check Printed"; Rec."Check Printed")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies whether a check has been printed for the amount on the payment journal line.';
                Visible = false;
            }
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the reason code that has been entered on the journal lines.';
                Visible = false;
            }
            field(Comment; Rec.Comment)
            {
                ApplicationArea = all;
                ToolTip = 'Specifies a comment related to registering a payment.';
                Visible = false;
            }
            field("Exported to Payment File"; Rec."Exported to Payment File")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies that the payment journal line was exported to a payment file.';
            }
            field("Has Payment Export Error"; Rec."Has Payment Export Error")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies that an error occurred when you used the Export Payments to File function in the Payment Journal window.';
            }
            field("Vendor Bank Account"; Rec."Vendor Bank Account")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the Vendor Bank Account';
            }
            field("Due Date"; Rec."Due Date")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the Due Date';
                Description = 'HEI.02';
            }
            field(Reversed; Rec.Reversed)
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the Reserved';
                Description = 'HEI.02';
            }
        }

        area(factboxes)
        {
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord();
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        TempGenJournalLine: Record "Gen. Journal Line";
    begin
    end;

    trigger OnDeleteRecord(): Boolean;
    var
        TempGenJournalLine: Record "Gen. Journal Line" temporary;
        foundRec: Boolean;
        VendorLedgerEntry_G: Record "Vendor Ledger Entry";
    begin
    end;

    trigger OnOpenPage();
    var
        JnlSelected: Boolean;
    begin
    end;

    var
        Text000: Label 'Void Check %1?';
        Text001: Label 'Void all printed checks?';
        CurrentJnlBatchName: Code[10];
        CurrentJnlTemplateName: Code[10];
        DocumentNo: Code[20];
}

