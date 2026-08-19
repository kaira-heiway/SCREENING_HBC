page 90111 "API - Job Queue Entries"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    EntityName = 'jobQueueEntry';
    EntitySetName = 'jobQueueEntries';
    SourceTable = "Job Queue Entry";
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
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(userId; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(xml; Rec.XML)
                {
                    Caption = 'XML';
                }
                field(lastReadyState; Rec."Last Ready State")
                {
                    Caption = 'Last Ready State';
                }
                field(expirationDateTime; Rec."Expiration Date/Time")
                {
                    Caption = 'Expiration Date/Time';
                }
                field(earliestStartDateTime; Rec."Earliest Start Date/Time")
                {
                    Caption = 'Earliest Start Date/Time';
                }
                field(objectTypeToRun; Rec."Object Type to Run")
                {
                    Caption = 'Object Type to Run';
                }
                field(objectIdToRun; Rec."Object ID to Run")
                {
                    Caption = 'Object ID to Run';
                }
                field(reportOutputType; Rec."Report Output Type")
                {
                    Caption = 'Report Output Type';
                }
                field(maximumNoOfAttemptsToRun; Rec."Maximum No. of Attempts to Run")
                {
                    Caption = 'Maximum No. of Attempts to Run';
                }
                field(noOfAttemptsToRun; Rec."No. of Attempts to Run")
                {
                    Caption = 'No. of Attempts to Run';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(recordIdToProcess; Rec."Record ID to Process")
                {
                    Caption = 'Record ID to Process';
                }
                field(parameterString; Rec."Parameter String")
                {
                    Caption = 'Parameter String';
                }
                field(recurringJob; Rec."Recurring Job")
                {
                    Caption = 'Recurring Job';
                }
                field(noOfMinutesBetweenRuns; Rec."No. of Minutes between Runs")
                {
                    Caption = 'No. of Minutes between Runs';
                }
                field(runOnMondays; Rec."Run on Mondays")
                {
                    Caption = 'Run on Mondays';
                }
                field(runOnTuesdays; Rec."Run on Tuesdays")
                {
                    Caption = 'Run on Tuesdays';
                }
                field(runOnWednesdays; Rec."Run on Wednesdays")
                {
                    Caption = 'Run on Wednesdays';
                }
                field(runOnThursdays; Rec."Run on Thursdays")
                {
                    Caption = 'Run on Thursdays';
                }
                field(runOnFridays; Rec."Run on Fridays")
                {
                    Caption = 'Run on Fridays';
                }
                field(runOnSaturdays; Rec."Run on Saturdays")
                {
                    Caption = 'Run on Saturdays';
                }
                field(runOnSundays; Rec."Run on Sundays")
                {
                    Caption = 'Run on Sundays';
                }
                field(startingTime; Rec."Starting Time")
                {
                    Caption = 'Starting Time';
                }
                field(endingTime; Rec."Ending Time")
                {
                    Caption = 'Ending Time';
                }
                field(referenceStartingTime; Rec."Reference Starting Time")
                {
                    Caption = 'Reference Starting Time';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(runInUserSession; Rec."Run in User Session")
                {
                    Caption = 'Run in User Session';
                }
                field(userSessionId; Rec."User Session ID")
                {
                    Caption = 'User Session ID';
                }
                field(jobQueueCategoryCode; Rec."Job Queue Category Code")
                {
                    Caption = 'Job Queue Category Code';
                }
                field(errorMessage; Rec."Error Message")
                {
                    Caption = 'Error Message';
                }
                field(userServiceInstanceId; Rec."User Service Instance ID")
                {
                    Caption = 'User Service Instance ID';
                }
                field(userSessionStarted; Rec."User Session Started")
                {
                    Caption = 'User Session Started';
                }
                field(notifyOnSuccess; Rec."Notify On Success")
                {
                    Caption = 'Notify On Success';
                }
                field(userLanguageId; Rec."User Language ID")
                {
                    Caption = 'User Language ID';
                }
                field(printerName; Rec."Printer Name")
                {
                    Caption = 'Printer Name';
                }
                field(reportRequestPageOptions; Rec."Report Request Page Options")
                {
                    Caption = 'Report Request Page Options';
                }
                field(rerunDelaySec; Rec."Rerun Delay (sec.)")
                {
                    Caption = 'Rerun Delay (sec.)';
                }
                field(systemTaskId; Rec."System Task ID")
                {
                    Caption = 'System Task ID';
                }
                field(noOfMinutesToForceReset; Rec."No. of Min. To Force Reset FND")
                {
                    Caption = 'No. of Minutes To Force Reset';
                }
                field(noOfMinutesToNotify; Rec."No. of Minutes To Notify FND")
                {
                    Caption = 'No. of Minutes To Notify';
                }
                field(notifiedTime; Rec."Notified Time FND")
                {
                    Caption = 'Notified Time';
                }
                field(sendDocument; Rec."Send Document FND")
                {
                    Caption = 'Send Document';
                }
                field(documentType; Rec."Document Type FND")
                {
                    Caption = 'Document Type';
                }
                field(documentNo; Rec."Document No. FND")
                {
                    Caption = 'Document No.';
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
                field(postedDocumentNo; Rec."Posted Document No. FND")
                {
                    Caption = 'Posted Document No.';
                }
                field(jqLogisticsMailSent; Rec."JQ Logistics Mail Sent FND")
                {
                    Caption = 'JQ Logistics Mail Sent';
                }
                field(notifyEmailId; Rec."Notify Email ID FND")
                {
                    Caption = 'Notify Email ID';
                }
                field(jobTenantId; Rec."JOB TenantID FND")
                {
                    Caption = 'JOB TenantID';
                }
                field(jobServiceInstanceName; Rec."JOB ServiceInstanceName FND")
                {
                    Caption = 'JOB ServiceInstanceName';
                }
                field(jobServerName; Rec."JOB Server Name FND")
                {
                    Caption = 'JOB Server Name';
                }
                field(noOfAttemptsToReset; Rec."No. of Attempts to Reset FND")
                {
                    Caption = 'No. of Attempts to Reset';
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