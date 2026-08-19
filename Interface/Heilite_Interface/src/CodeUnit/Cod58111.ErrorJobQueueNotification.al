namespace Heilite_General.Heilite_General;
using Heilite_Interface.Heilite_Interface;

codeunit 58111 "Error Job Queue Notification"
{
    //     HEI.01 CHG2126942 IBM SAMANR01 20-09-2021
    //   # Create Codeunit for sent error job queue notification to IT Managers

    // BC Upgrade SHUKLP03 => Nav old id- 50125

    var
        ResetJobQueueEntries: Codeunit "Reset Job Queue Entries";

    trigger OnRun()
    var
    begin
        ResetJobQueueEntries.CheckErrorJobQueueEntries();
    end;

}
