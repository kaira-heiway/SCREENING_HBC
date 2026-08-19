
codeunit 58109 "Start Reset Job Queue Entries"
{
    // HEI.01 FDD-GAPID001 IBM LAZARE02 05.10.2017 # New codeunit used to reset job queue entries in error state
    // BC Upgrade SHUKLP03 => Nav old id- 50038

    trigger OnRun()
    var
    begin
        IF CODEUNIT.RUN(CODEUNIT::"Reset Job Queue Entries") THEN;
    end;

}
