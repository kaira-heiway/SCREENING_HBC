codeunit 58094 "Intgrtn. Frmwk. Async. Process"
{
    //BC Upgrade GUNREM01 Old ID-50161
    // HEI.01 CHG2084921 IBM KUMARN15 29.10.2020
    //   # New codeunit created

    TableNo = "Job Queue Entry";

    trigger OnRun();
    var
        RecRef: RecordRef;
        IntFrameworkLog: Record "Integration Framework Log INT";
        ErrorOStream: OutStream;
    begin
        Rec.TESTFIELD("Record ID to Process");
        RecRef.GET(Rec."Record ID to Process");
        RecRef.SETTABLE(IntFrameworkLog);
        IntFrameworkLog.FIND;

        if CODEUNIT.RUN(IntFrameworkLog."Processing Codeunit", IntFrameworkLog) then begin
            IntFrameworkLog.FIND;
            IntFrameworkLog.Status := IntFrameworkLog.Status::Processed;
            IntFrameworkLog.MODIFY;
        end else begin
            IntFrameworkLog.FIND;
            IntFrameworkLog.Status := IntFrameworkLog.Status::Error;
            IntFrameworkLog."Error Message".CREATEOUTSTREAM(ErrorOStream);
            ErrorOStream.WRITETEXT(STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK));
            IntFrameworkLog."Display Error" := COPYSTR(GETLASTERRORTEXT, 1, 250);
            IntFrameworkLog.MODIFY;
        end;
    end;

    var
        ErrorMsg: Label 'Error Code: %1, Error Text: %2, Call Stack Trace: %3';
}

