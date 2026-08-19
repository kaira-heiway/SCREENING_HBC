page 51013 "Customer Email Log CBN"
{
    // version HEI.02

    // HEI.01 CHG2228480-HB3631 COSTES04 17.04.2024 Sierra Leone Automate the separation of deposit and finish product
    //   # New object created
    // HEI.02 CHG2250653-HB3631 COSTES04 14.08.2024 Customer Statement should show dates in sequency
    //   # Add new action
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea property in page and Fields
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Customer Email Log FND";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field(DateTime; Rec.DateTime)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DateTime field.';
                }
                field("Report Sent"; Rec."Report Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Report Sent field.';
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Error Message field.';
                }
                field("Period From"; Rec."Period From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period From field.';
                }
                field("Period To"; Rec."Period To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period To field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send Email")
            {
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Send Email action.';

                trigger OnAction();
                var
                    SendEmailCustStatement: Codeunit "Send Email Cust.Statement CBN";
                begin
                    if not CONFIRM(STRSUBSTNO(SendEmailMsg, Rec."Customer No.")) then
                        exit;
                    SendEmailCustStatement.SendManualCustomerStatementEmail(Rec);
                end;
            }
            action("Send Email Global")
            {
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Send Email Global action.';

                trigger OnAction();
                var
                    SendEmailCustStatement: Codeunit "SendCust.Stat EmailGlobal CBN";
                begin
                    //HEI.02>>
                    if not CONFIRM(STRSUBSTNO(SendEmailMsg, Rec."Customer No.")) then
                        exit;
                    SendEmailCustStatement.SendManualCustomerStatementEmail(Rec);
                    //HEI.02<<
                end;
            }
        }
    }

    var
        SendEmailMsg: Label 'Do you want to send customer statement for %1?';
}

