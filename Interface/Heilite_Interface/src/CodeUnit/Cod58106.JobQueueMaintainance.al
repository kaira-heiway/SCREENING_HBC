namespace LatestInterfaceP.LatestInterfaceP;
using System.Environment;
using System.Threading;

codeunit 58106 "Job Queue Maintainance"
{
    // HEI.01 CHG2128094 SAMANR01 04-02-2021
    //   Object created for reset the job queue after NAS service restart
    // HEI.02 CHG2128094 SAMANR01 07-02-2021
    //   Modify the logic about reset jobs. Schedule task validation added before reset the jobs.
    // HEI.03 CHG2174515 SAMANR01 29-09-2022
    //    New function "ResetJobQueue" created to include existing functionally for the JOBS reset
    //    where will we have the ability to reset specific JOB by the JOBID,ObjectType,ObjectID
    // HEI.04 CHG2176276 SAXENA03 10-07-2022
    //    Added code to RESET Job Queues in function "ResetJobQueue"

    // BC Upgrade SHUKLP03 >> Nav old id - 50210

    var
        JobQueueEntry: Record "Job Queue Entry";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        Companies: Record Company;
        ScheduledTask: Record "Scheduled Task";

    trigger OnRun()
    var
    begin
        GeneralInterfaceSetup.GET();
        JobQueueEntry.RESET();
        JobQueueEntry.SETFILTER(Status, '%1', JobQueueEntry.Status::Ready);
        JobQueueEntry.SETFILTER("User ID", GeneralInterfaceSetup."Interface Job Queue User ID");
        IF JobQueueEntry.FINDSET() THEN
            REPEAT
                IF (JobQueueEntry."Earliest Start Date/Time" < CURRENTDATETIME) THEN BEGIN
                    IF NOT (ScheduledTask.GET(JobQueueEntry."System Task ID")) THEN BEGIN
                        JobQueueEntry.Restart();
                        JobQueueEntry.MODIFY(TRUE);
                    END;
                    //HEI.02>>
                    IF ScheduledTask.GET(JobQueueEntry."System Task ID") THEN BEGIN
                        IF ScheduledTask."Not Before" = 0DT THEN
                            JobQueueEntry.Restart();
                        JobQueueEntry.MODIFY(TRUE);
                    END;
                    //HEI.02<<
                END;
            UNTIL JobQueueEntry.NEXT() = 0;
    end;

    procedure PrintCurrentTime()
    begin
        //HEI.03>>
        MESSAGE(FORMAT(CURRENTDATETIME));
        //HEI.03<<
    end;

    procedure ResetJobQueue(pGid_JobID: Text[250])
    begin
        //HEI.04>>
        JobQueueEntry.RESET();
        IF JobQueueEntry.GET(pGid_JobID) THEN BEGIN
            JobQueueEntry.Restart();
            //   {
            //     IF ScheduledTask.GET(JobQueueEntry."System Task ID") THEN BEGIN
            //                 TASKSCHEDULER.CANCELTASK(JobQueueEntry."System Task ID");
            //                 CLEAR(JobQueueEntry."System Task ID");
            //             END;

            //             JobQueueEntry."Earliest Start Date/Time" := CURRENTDATETIME + 100000;
            //             JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            //             JobQueueEntry.MODIFY(TRUE);
            //             CODEUNIT.RUN(CODEUNIT::"Job Queue - Enqueue", JobQueueEntry);

            //             IF ScheduledTask.GET(JobQueueEntry."System Task ID") THEN BEGIN
            //                 ScheduledTask."User Language ID" := 1033;
            //                 ScheduledTask."User Format ID" := 2057;
            //                 ScheduledTask."User Time Zone" := 'W. Europe Standard Time';
            //                 ScheduledTask.MODIFY();
            //             END;
            //         }

            //HEI.04<<
        end;
    end;

}
