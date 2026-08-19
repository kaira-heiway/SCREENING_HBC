namespace INTERFACES.INTERFACES;

using System.Automation;

page 90059 "Approval Entry API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    DataAccessIntent = ReadOnly;
    Editable = false;
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Approval Entry API';
    DelayedInsert = true;
    EntityName = 'approvalEntry';
    EntitySetName = 'approvalEntry';
    ODataKeyFields = SystemId;
    PageType = API;
    SourceTable = "Approval Entry";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(tableID; Rec."Table ID")
                {
                    Caption = 'Table ID';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(sequenceNo; Rec."Sequence No.")
                {
                    Caption = 'Sequence No.';
                }
                field(approvalCode; Rec."Approval Code")
                {
                    Caption = 'Approval Code';
                }
                field(senderID; Rec."Sender ID")
                {
                    Caption = 'Sender ID';
                }
                field(salespersPurchCode; Rec."Salespers./Purch. Code")
                {
                    Caption = 'Salespers./Purch. Code';
                }
                field(approverID; Rec."Approver ID")
                {
                    Caption = 'Approver ID';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(dateTimeSentForApproval; Rec."Date-Time Sent for Approval")
                {
                    Caption = 'Date-Time Sent for Approval';
                }
                field(lastDateTimeModified; Rec."Last Date-Time Modified")
                {
                    Caption = 'Last Date-Time Modified';
                }
                field(lastModifiedByUserID; Rec."Last Modified By User ID")
                {
                    Caption = 'Last Modified By User ID';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Approval Due Date';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountLCY; Rec."Amount (LCY)")
                {
                    Caption = 'Amount (LCY)';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(approvalType; Rec."Approval Type")
                {
                    Caption = 'Approval Type';
                }
                field(limitType; Rec."Limit Type")
                {
                    Caption = 'Limit Type';
                }
                field(availableCreditLimitLCY; Rec."Available Credit Limit (LCY)")
                {
                    Caption = 'Available Credit Limit (LCY)';
                }
                field(recordIDToApprove; Rec."Record ID to Approve")
                {
                    Caption = 'Record ID to Approve';
                }
                field(delegationDateFormula; Rec."Delegation Date Formula")
                {
                    Caption = 'Delegation Date Formula';
                }
                field(workflowStepInstanceID; Rec."Workflow Step Instance ID")
                {
                    Caption = 'Workflow Step Instance ID';
                }
                field(pqApproverFND; Rec."PQ Approver FND")
                {
                    Caption = 'PQ Approver';
                }
                field(requestSentFND; Rec."Request Sent FND")
                {
                    Caption = 'Request Sent';
                }
                field(responseReceivedFND; Rec."Response Received FND")
                {
                    Caption = 'Response Received';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }

            }
        }
    }
}
