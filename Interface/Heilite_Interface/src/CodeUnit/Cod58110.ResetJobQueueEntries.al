namespace Heilite_Interface.Heilite_Interface;
using System.Threading;
using Microsoft.Sales.Setup;
using System.Security.User;
using Microsoft.Sales.Posting;
using System.Email;
using System.Environment;

codeunit 58110 "Reset Job Queue Entries"
{
    // HEI.01 FDD-GAPID001 IBM LAZARE02 05.10.2017 # New codeunit used to reset job queue entries in error state
    // HEI.02 CHG2077873 IBM KUMARN15 02.09.2020 # Code change in function CheckJobQueueEntries
    // HEI.03 CHG2103110 IBM SAMANR01 19.03.2021 # Code change in function CheckJobQueueEntries- to consider all the job queue category code.
    // HEI.04 CHG2106712 SAMANR01 19.04.2020
    //   # New function created for notification sent per Error job queue entry
    // HEI.06 CHG2126942 IBM SAMANR01 20-09-2021
    //   # Block code because same function call in CU50125 and create separate job
    // HEI.07 IBM COSTES04 29.01.2025 CHG2279679-HB4118-Automatic restart of deadlock errors for auto billing
    //   # Add maximum number of reset
    // HEI.08 IBM COSTES04 12.08.2025 CHG2315964 - Job Quentry Restart - LaReunion
    //   # Create Log Entry in case of the first run

    // BC Upgrade SHUKLP03 >>
    // Nav Old id - 50039
    // Modified code of procedure CreateWindowsEvent().
    // Replaced SMTP with Email and Email message in procedure CreateErrorJobNotification() and CreateNotification()
    // BC Upgrade SHUKLP03 <<

    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        GeneralInterfaceSetupRead: Boolean;
        JobQueueCategory: Record "Job Queue Category";
        Char13: Char;
        Char10: Char;
        SalesSetup: Record "Sales & Receivables Setup";
        SalesSetupRead: Boolean;
        JobQueueEntryFailedTxt: Label 'Job Queue Entry %1 failed. Error message: %2.';
        JobQueueEntryResetTxt: Label 'Job Queue Entry %1 did not complete after %2 minutes and had to be reset.';
        JobQueueDetailsTxt: Label 'Job Queue %1. Start time: %2. Error message: %3';
        MailSubjectTxt: Label 'Job Queue Entry failure. Your action is needed.';
        JobQueueEntryFailedTxt1: Label 'Job Queue Entry %1 failed.';
        JobQueueEntryFailedTxt2: Label 'Error message: %1 %2 %3 %4';


    trigger OnRun()
    var
    begin
        CheckJobQueueEntries();
        // >>HEI.04
        //CheckErrorJobQueueEntries;//HEI.06
        // <<HEI.04
    end;

    procedure CheckJobQueueEntries()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueLogEntry: Record "Job Queue Log Entry";
        LastEntryNo: Integer;
        LastSuccessEntry: Integer;
        LastSuccessTime: DateTime;
        TimeToForceReset: Integer;
        TimeToSendNotification: Integer;
        RecentlyNotified: Boolean;
        LastHeartbeat: DateTime;
        Now: DateTime;
        ErrMsg: Text;
        SkipReset: Boolean;
    begin
        GetGeneralInterfaceSetup();
        GetSalesSetup();//HEI.07
                        // >>HEI.03
        JobQueueCategory.RESET();
        IF JobQueueCategory.FINDSET() THEN
            REPEAT
                // <<HEI.03
                JobQueueEntry.SETFILTER(Status, '<>%1', JobQueueEntry.Status::"On Hold");
                //<< HEI.02
                // JobQueueEntry.SETFILTER("Job Queue Category Code",GeneralInterfaceSetup."Interface Job Queue Category");
                //JobQueueEntry.SETFILTER("Job Queue Category Code",'%1|%2',GeneralInterfaceSetup."Interface Job Queue Category",'VIP_INTERF');
                JobQueueEntry.SETFILTER("Job Queue Category Code", JobQueueCategory.Code);// >>HEI.03
                                                                                          //>> HEI.02

                IF JobQueueEntry.FINDSET() THEN
                    REPEAT
                        IF (JobQueueEntry."Object Type to Run" = JobQueueEntry."Object Type to Run"::Report) OR
                           ((JobQueueEntry."Object Type to Run" = JobQueueEntry."Object Type to Run"::Codeunit) AND
                            (JobQueueEntry."Object ID to Run" <> CODEUNIT::"Start Reset Job Queue Entries"))
                        THEN BEGIN
                            TimeToForceReset := JobQueueEntry."No. of Min. To Force Reset FND" * 60000;
                            TimeToSendNotification := JobQueueEntry."No. of Minutes To Notify FND" * 60000;
                            //HEI.07>>
                            //IF (TimeToForceReset <> 0) OR (TimeToSendNotification <> 0) THEN BEGIN
                            CLEAR(SkipReset);
                            IF (SalesSetup."Autobilling JQ Restart FND") AND (JobQueueEntry."Object ID to Run" = CODEUNIT::"Sales Post via Job Queue") THEN
                                IF (JobQueueEntry."No. of Attempts to Reset FND" >= SalesSetup."AutobillingJQMaxNo.Restart FND") THEN
                                    SkipReset := TRUE;
                            IF ((TimeToForceReset <> 0) OR (TimeToSendNotification <> 0)) AND (NOT SkipReset) THEN BEGIN
                                //HEI.07<<
                                JobQueueLogEntry.RESET();
                                JobQueueLogEntry.SETCURRENTKEY(ID);
                                JobQueueLogEntry.SETRANGE(ID, JobQueueEntry.ID);
                                IF JobQueueLogEntry.FINDLAST() THEN
                                    LastEntryNo := JobQueueLogEntry."Entry No."
                                ELSE
                                    LastEntryNo := 0;
                                JobQueueLogEntry.SETFILTER("Entry No.", '<%1', LastEntryNo);
                                JobQueueLogEntry.SETRANGE("Error Message", '');
                                IF JobQueueLogEntry.FINDLAST() THEN BEGIN
                                    LastSuccessEntry := JobQueueLogEntry."Entry No.";
                                    LastSuccessTime := JobQueueLogEntry."End Date/Time";
                                END ELSE BEGIN
                                    LastSuccessEntry := 0;
                                    LastSuccessTime := 0DT;
                                END;

                                CASE JobQueueEntry.Status OF
                                    JobQueueEntry.Status::Error:
                                        BEGIN
                                            JobQueueLogEntry.SETFILTER("Entry No.", '>%1', LastSuccessEntry);
                                            JobQueueLogEntry.SETRANGE(Status, JobQueueLogEntry.Status::Error);
                                            JobQueueLogEntry.SETRANGE("Error Message", JobQueueEntry."Error Message");
                                            JobQueueLogEntry.FINDLAST(); // Find last log entry with this error

                                            // Reset job status
                                            IF TimeToForceReset <> 0 THEN BEGIN
                                                IF JobQueueLogEntry.COUNT = 1 THEN
                                                    // Reset status first time the error occurs after last successful run
                                                    JobQueueEntry.SetStatus(JobQueueEntry.Status::Ready)
                                                ELSE
                                                    // Same error happened before
                                                    // Reset status to ready if certain period passed since last reset
                                                    IF CURRENTDATETIME - JobQueueLogEntry."Start Date/Time" > TimeToForceReset THEN // Also reset if certain time has passed since reset
                                                        JobQueueEntry.SetStatus(JobQueueEntry.Status::Ready); // This also clears "User Session Started" and sets "Earliest Start Date/Time"
                                                //HEI.07>>
                                                JobQueueEntry."No. of Attempts to Reset FND" += 1;
                                                JobQueueEntry.MODIFY();
                                                //HEI.07<<
                                            END;

                                            // Create notification
                                            IF (TimeToSendNotification <> 0) AND (LastSuccessTime <> 0DT) THEN BEGIN
                                                IF CURRENTDATETIME - LastSuccessTime > TimeToSendNotification THEN BEGIN // Notification due
                                                    IF JobQueueEntry."Notified Time FND" = 0DT THEN
                                                        RecentlyNotified := FALSE
                                                    ELSE
                                                        RecentlyNotified := CURRENTDATETIME - JobQueueEntry."Notified Time FND" < TimeToSendNotification;
                                                    IF NOT RecentlyNotified THEN
                                                        // Notification sent for every TimeToLogError interval
                                                        CreateNotification(JobQueueEntry, JobQueueLogEntry); // Also sets "Notification Sent" and "Notified Time"
                                                END;
                                            END;
                                        END;
                                    JobQueueEntry.Status::Ready,
                                    JobQueueEntry.Status::"In Process",
                                    JobQueueEntry.Status::Finished:
                                        BEGIN
                                            IF JobQueueEntry."User Session Started" <> 0DT THEN
                                                LastHeartbeat := JobQueueEntry."User Session Started"
                                            ELSE
                                                LastHeartbeat := JobQueueEntry."Earliest Start Date/Time";
                                            Now := CURRENTDATETIME;
                                            //MESSAGE('Now = %1, LastHeartBeat = %2, Diff = %3', Now,LastHeartbeat,Now-LastHeartbeat);
                                            IF (TimeToForceReset <> 0) AND (Now - LastHeartbeat > TimeToForceReset) THEN BEGIN
                                                //if status is Ready then set OnHold first
                                                IF JobQueueEntry.Status = JobQueueEntry.Status::Ready THEN
                                                    JobQueueEntry.SetStatus(JobQueueEntry.Status::"On Hold");
                                                // reset Jobqueue status to ready
                                                JobQueueEntry.SetStatus(JobQueueEntry.Status::Ready); // This also clears "User Session Started" and sets "Earliest Start Date/Time"
                                                                                                      // So the status will only be reset once for ever TimeToForceReset interval

                                                // Log the resetting as an error in the log
                                                JobQueueLogEntry.LOCKTABLE();
                                                //HEI.08>>
                                                //JobQueueLogEntry.GET(LastEntryNo);
                                                IF NOT JobQueueLogEntry.GET(LastEntryNo) THEN BEGIN
                                                    JobQueueEntry.InsertLogEntry(JobQueueLogEntry);
                                                    LastSuccessTime := LastHeartbeat;
                                                END;
                                                //HEI.08<<
                                                ErrMsg := STRSUBSTNO(JobQueueEntryResetTxt, JobQueueEntry.Description, TimeToForceReset / 60000);
                                                IF JobQueueLogEntry.Status <> JobQueueLogEntry.Status::Error THEN BEGIN
                                                    JobQueueLogEntry.Status := JobQueueLogEntry.Status::Error;
                                                    JobQueueLogEntry."Error Message" := COPYSTR(ErrMsg, 1, MAXSTRLEN(JobQueueLogEntry."Error Message"));
                                                    JobQueueLogEntry.MODIFY();
                                                END;

                                                // Notification: If timeout repeated for too long, then log the error in the windows event logs and in the NAV notifications
                                                IF (TimeToSendNotification <> 0) AND (LastSuccessTime <> 0DT) THEN BEGIN
                                                    IF CURRENTDATETIME - LastSuccessTime > TimeToSendNotification THEN BEGIN // Notification due
                                                        IF JobQueueEntry."Notified Time FND" = 0DT THEN
                                                            RecentlyNotified := FALSE
                                                        ELSE
                                                            RecentlyNotified := CURRENTDATETIME - JobQueueEntry."Notified Time FND" < TimeToSendNotification;
                                                        IF NOT RecentlyNotified THEN BEGIN
                                                            CreateNotification(JobQueueEntry, JobQueueLogEntry);
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                END;
                            END;
                        END;
                    UNTIL JobQueueEntry.NEXT() = 0;
            UNTIL JobQueueCategory.NEXT() = 0;// >>HEI.03
    end;

    LOCAL procedure GetGeneralInterfaceSetup()
    begin
        IF NOT GeneralInterfaceSetupRead THEN
            GeneralInterfaceSetup.GET();
        GeneralInterfaceSetupRead := TRUE;
    end;

    LOCAL procedure CreateNotification(VAR JobQueueEntry: Record "Job Queue Entry"; VAR JobQueueLogEntry: Record "Job Queue Log Entry")
    var
        UserSetup: Record "User Setup";
        FromUserSetup: Record "User Setup";
        TempUser: Record "User Setup";
        //SMTPMail: Codeunit "SMTP Mail"; // BC Upgrade SHUKLP03 << Blocked because deprecated.
        EmailCU: Codeunit Email;   // BC Upgrade SHUKLP03 << 
        EmailMsg: Codeunit "Email Message";  // BC Upgrade SHUKLP03 << 
        Msg: Text;
    begin
        Msg := STRSUBSTNO(JobQueueEntryFailedTxt, JobQueueLogEntry.Description, JobQueueLogEntry."Error Message");

        // Create an entry in Window Event log
        CreateWindowsEvent(Msg);

        // Create list of users to receive the notification
        GeneralInterfaceSetup.GET();
        IF GeneralInterfaceSetup."Notify User ID 1" <> '' THEN
            IF UserSetup.GET(GeneralInterfaceSetup."Notify User ID 1") THEN BEGIN
                TempUser := UserSetup;
                IF TempUser.INSERT() THEN;
            END;
        IF GeneralInterfaceSetup."Notify User ID 2" <> '' THEN
            IF UserSetup.GET(GeneralInterfaceSetup."Notify User ID 2") THEN BEGIN
                TempUser := UserSetup;
                IF TempUser.INSERT() THEN;
            END;
        FromUserSetup.GET(GeneralInterfaceSetup."Interface Job Queue User ID");

        // Send mail to users
        IF TempUser.FIND('-') THEN
            REPEAT
                IF TempUser."E-Mail" <> '' THEN BEGIN
                    // SMTPMail.CreateMessage('HeiLite BASE Interfaces', FromUserSetup."E-Mail", TempUser."E-Mail", MailSubjectTxt, Msg, TRUE); // BC Upgrade SHUKLP03 << Blocked because deprecated.
                    // SMTPMail.Send;  // BC Upgrade SHUKLP03 << Blocked because deprecated.
                    EmailMsg.Create(TempUser."E-Mail", MailSubjectTxt, Msg, TRUE);  // BC Upgrade SHUKLP03 << 
                    EmailCU.Send(EmailMsg, Enum::"Email Scenario"::Default);   // BC Upgrade SHUKLP03 << 
                END;
            UNTIL TempUser.NEXT() = 0;
        // Must always mark as sent, even if no recipents were setup, because else reseter job will retry notification every time
        // and create a lot of windows events.

        // >>HEI.04
        // {
        // JobQueueLogEntry.LOCKTABLE;
        //         JobQueueLogEntry.GET(JobQueueLogEntry."Entry No.");
        //         JobQueueLogEntry."Notification Sent" := TRUE;
        //         JobQueueLogEntry.MODIFY;
        //         JobQueueEntry.LOCKTABLE;
        // }
        // <<HEI.04
        JobQueueEntry.GET(JobQueueEntry.ID);
        JobQueueEntry."Notified Time FND" := CURRENTDATETIME;
        JobQueueEntry.MODIFY();
    end;

    LOCAL procedure CreateWindowsEvent(Message: Text)
    var
        //ServerInstance: Record "Server Instance";	// BC Upgrade SHUKLP03 << 'Server Instance' has scope 'OnPrem', we can't use in Saas.
        ActiveSession: Record "Active Session"; // BC Upgrade SHUKLP03 << replaced 'Server Instance' with 'Active Session'.

        // BC Upgrade SHUKLP03 >> Blocked DotNet variable
        // EventLog: DotNet System.Diagnostics.EventLog.'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	
        // EventLogEntryType: DotNet System.Diagnostics.EventLogEntryType.'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	
        // BC Upgrade SHUKLP03 << Blocked DotNet variable

        EventSource: Text;
        EventId: Integer;
        EveId: Text; // BC Upgrade SHUKLP03 <<
    begin
        //Get eventsource fro current server, typically 'MicrosoftDynamicsNavServer$DynamicsNAV90'
        //ServerInstance.GET(DATABASE.SERVICEINSTANCEID);
        //EventSource := 'MicrosoftDynamicsNavServer$' + ServerInstance."Server Instance Name";
        EventSource := 'MicrosoftDynamicsNavServer'; // Use general NAV Server source
        EventId := 201; // Randomly chosen constant enevt id to identify JobQueueResetter warnings
        //EventLog.WriteEntry(EventSource, Message, EventLogEntryType.Warning, EventId); // BC Upgrade SHUKLP03 << Blocked code because dependency on DotNet variable.
        Session.LogMessage(EveId, Message, Verbosity::Warning, "DataClassification"::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Source', 'JobQueueResetter'); // BC Upgrade SHUKLP03 << Replaced with BC Saas code.
    end;

    procedure CheckErrorJobQueueEntries()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueLogEntry: Record "Job Queue Log Entry";
        LastEntryNo: Integer;
        LastSuccessEntry: Integer;
        LastSuccessTime: DateTime;
        TimeToForceReset: Integer;
        TimeToSendNotification: Integer;
        RecentlyNotified: Boolean;
        LastHeartbeat: DateTime;
        Now: DateTime;
        ErrMsg: Text;
    begin
        // >>HEI.04
        GetGeneralInterfaceSetup();
        JobQueueEntry.RESET();
        JobQueueEntry.SETRANGE(Status, JobQueueEntry.Status::Error);
        IF JobQueueEntry.FINDSET() THEN
            REPEAT
                JobQueueLogEntry.RESET();
                JobQueueLogEntry.SETCURRENTKEY(ID);
                JobQueueLogEntry.SETRANGE(ID, JobQueueEntry.ID);
                JobQueueLogEntry.SETRANGE(Status, JobQueueLogEntry.Status::Error);
                JobQueueLogEntry.SETRANGE("Notification Sent FND", FALSE);
                IF JobQueueLogEntry.FINDLAST() THEN
                    CreateErrorJobNotification(JobQueueEntry, JobQueueLogEntry);
            UNTIL JobQueueEntry.NEXT() = 0;
        // <<HEI.04
    end;

    LOCAL procedure CreateErrorJobNotification(VAR JobQueueEntry: Record "Job Queue Entry"; VAR JobQueueLogEntry: Record "Job Queue Log Entry")
    var
        UserSetup: Record "User Setup";
        FromUserSetup: Record "User Setup";
        TempUser: Record "User Setup";
        //SMTPMail: Codeunit "SMTP Mail";  // BC Upgrade SHUKLP03 << Blocked because deprecated.
        EmailCU: Codeunit Email; // BC Upgrade SHUKLP03 << 
        EmailMsg: Codeunit "Email Message"; // BC Upgrade SHUKLP03 << 
        Msg: Text;
        lRec_JobQueueLogEntry: Record "Job Queue Log Entry";
    begin
        // >>HEI.04

        // BC Upgrade SHUKLP03 >> Updated Msg assigned fields because "Error Message 2","Error Message 3" and "Error Message 4" are derecated from table Job Queue Log Entry.
        // Msg := STRSUBSTNO(JobQueueEntryFailedTxt1, FORMAT(JobQueueLogEntry."Object ID to Run") + ': ' + JobQueueLogEntry.Description)
        //        + STRSUBSTNO(JobQueueEntryFailedTxt2, JobQueueLogEntry."Error Message", JobQueueLogEntry."Error Message 2",
        //                    JobQueueLogEntry."Error Message 3", JobQueueLogEntry."Error Message 4");

        Msg := STRSUBSTNO(JobQueueEntryFailedTxt1, FORMAT(JobQueueLogEntry."Object ID to Run") + ': ' + JobQueueLogEntry.Description)
               + STRSUBSTNO(JobQueueEntryFailedTxt2, JobQueueLogEntry."Error Message");
        // BC Upgrade SHUKLP03 >> Updated Msg assigned fields because "Error Message 2","Error Message 3" and "Error Message 4" are derecated from table Job Queue Log Entry.

        // Create an entry in Window Event log
        CreateWindowsEvent(Msg);

        // Create list of users to receive the notification
        GeneralInterfaceSetup.GET();
        FromUserSetup.GET(GeneralInterfaceSetup."Interface Job Queue User ID");

        // Send mail to users
        IF (JobQueueEntry."Notify Email ID FND" <> '') AND (FromUserSetup."E-Mail" <> '') THEN BEGIN
            // SMTPMail.CreateMessage('HeiLite BASE Interfaces', FromUserSetup."E-Mail", JobQueueEntry."Notify Email ID", MailSubjectTxt, Msg, TRUE);  // BC Upgrade SHUKLP03 << Blocked because deprecated.
            // SMTPMail.Send;  // BC Upgrade SHUKLP03 << Blocked because deprecated.
            EmailMsg.Create(JobQueueEntry."Notify Email ID FND", MailSubjectTxt, Msg, TRUE);  // BC Upgrade SHUKLP03 << 
            EmailCU.Send(EmailMsg, Enum::"Email Scenario"::Default);  // BC Upgrade SHUKLP03 << 

            lRec_JobQueueLogEntry.RESET();
            lRec_JobQueueLogEntry.SETCURRENTKEY(ID);
            lRec_JobQueueLogEntry.SETRANGE(lRec_JobQueueLogEntry.ID, JobQueueEntry.ID);
            lRec_JobQueueLogEntry.SETRANGE(Status, lRec_JobQueueLogEntry.Status::Error);
            IF lRec_JobQueueLogEntry.FINDSET() THEN
                REPEAT
                    lRec_JobQueueLogEntry."Notification Sent FND" := TRUE;
                    lRec_JobQueueLogEntry.MODIFY();
                UNTIL lRec_JobQueueLogEntry.NEXT() = 0;
        END;
        // <<HEI.04
    end;

    LOCAL procedure GetSalesSetup()
    begin
        //HEI.07>>
        IF NOT SalesSetupRead THEN
            SalesSetup.GET();

        SalesSetupRead := TRUE;
        //HEI.07<<
    end;

}
