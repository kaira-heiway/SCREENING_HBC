codeunit 58096 "Process Async. API"
{
    //BC Upgrade VAMSIU01 >>
    // # Old Nav ID - 50142
    // # Added Rec for few lines of code.
    //BC Upgrade VAMSIU01 <<

    // version HEI.03

    // HEI.01 CHG2065153 IBM KUMARN15 23.06.2020
    //   # New codeunit created
    // HEI.02 CHG2188870 DEBUSD01 03.02.2023 Sales Order API Performance change flow
    // HEI.03 CHG2205042 IBM BHANDS01 17.05.2023 Deadlock Issue
    //   # Code Optimization

    TableNo = "Job Queue Entry";

    trigger OnRun();
    var
        RecRef: RecordRef;
        ErrorOutStream: OutStream;
    begin
        // TODO: For future extensibility
        // NOTE: Async processing not part of Sales Order API, JUST TO SHOW IDEA ON EXTENSIBILITY
        Rec.TESTFIELD("Record ID to Process");//BC Upgrade VAMSIU01 - Added Rec
        RecRef.GET(Rec."Record ID to Process");//BC Upgrade VAMSIU01 - Added Rec
        RecRef.SETTABLE(APIInterfaceLog2);
        APIInterfaceLog2.SETAUTOCALCFIELDS(); //HEI.03
        APIInterfaceLog2.FIND;

        //HEI.02>>
        if CODEUNIT.RUN(APIInterfaceLog2."Job Queue Codeunit", APIInterfaceLog2) then begin
            APIInterfaceLog2.FIND;
            if APIInterfaceLog2.Status = APIInterfaceLog2.Status::Pending then begin
                //HEI.02<<
                // Processing succeed
                APIInterfaceLog2.Status := APIInterfaceLog2.Status::Processed;
                //HEI.02>>
                if APIInterfaceLog2."Response Sync. Date/Time" = 0DT then
                    //HEI.02<<
                    APIInterfaceLog2."Response Sync. Date/Time" := CURRENTDATETIME;
                APIInterfaceLog2.MODIFY;
                // TODO: Success response to be created and sent via WS call
            end;
        end else begin
            //HEI.02>>
            APIInterfaceLog2.FIND;
            if APIInterfaceLog2.Status = APIInterfaceLog2.Status::Pending then begin
                //HEI.02<<
                // Processing failed, to be logged
                APIInterfaceLog2.Status := APIInterfaceLog2.Status::Error;
                APIInterfaceLog2."Error Message".CREATEOUTSTREAM(ErrorOutStream);
                ErrorOutStream.WRITETEXT(STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK));
                //HEI.02>>
                if APIInterfaceLog2."Response Sync. Date/Time" = 0DT then
                    //HEI.02<<
                    APIInterfaceLog2."Response Sync. Date/Time" := CURRENTDATETIME;
                APIInterfaceLog2.MODIFY;
                // TODO: Error response to be created and sent via WS call
            end;
        end;
    end;

    var
        APIInterfaceLog2: Record "API Interface Log2 INT";
        ErrorMsg: Label 'Error Code: %1, Error Text: %2, Call Stack Trace: %3';
}

