page 90112 "API - Job Queue Log Entries"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    EntityName = 'jobQueueLogEntry';
    EntitySetName = 'jobQueueLogEntries';
    SourceTable = "Job Queue Log Entry";
    Editable = false;
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(userId; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(startDateTime; Rec."Start Date/Time")
                {
                    Caption = 'Start Date/Time';
                }
                field(endDateTime; Rec."End Date/Time")
                {
                    Caption = 'End Date/Time';
                }
                field(objectTypeToRun; Rec."Object Type to Run")
                {
                    Caption = 'Object Type to Run';
                }
                field(objectIdToRun; Rec."Object ID to Run")
                {
                    Caption = 'Object ID to Run';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(errorMessage; Rec."Error Message")
                {
                    Caption = 'Error Message';
                }
                field(jobQueueCategoryCode; Rec."Job Queue Category Code")
                {
                    Caption = 'Job Queue Category Code';
                }
                field(notificationSent; Rec."Notification Sent FND")
                {
                    Caption = 'Notification Sent';
                }
                field(sendDocument; Rec."Send Document FND")
                {
                    Caption = 'Send Document';
                }
                field(jqPosted; Rec."JQ Posted FND")
                {
                    Caption = 'JQ Posted';
                }
                field(jqMailSent; Rec."JQ Mail Sent FND")
                {
                    Caption = 'JQ Mail Sent';
                }
                field(jqPrinted; Rec."JQ Printed FND")
                {
                    Caption = 'JQ Printed';
                }
                field(documentType; Rec."Document Type FND")
                {
                    Caption = 'Document Type';
                }
                field(documentNo; Rec."Document No. FND")
                {
                    Caption = 'Document No.';
                }
                field(postedDocumentNo; Rec."Posted Document No. FND")
                {
                    Caption = 'Posted Document No.';
                }
                field(jqLogisticsMailSent; Rec."JQ Logistics Mail Sent FND")
                {
                    Caption = 'JQ Logistics Mail Sent';
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