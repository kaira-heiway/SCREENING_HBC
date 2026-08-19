codeunit 58004 "Inbound Interface Processing"
{
    // Heilite Navision Old Id - 50010
    // version HEI.01

    // HEI.01 CHG2112261 IBM SAXENA03 20.05.2021
    //   # Interface Logging processing Execution Time and Webservices Response Times
    //   # Added new application code to to Update Start execution and End execution date
    //     of Table 50001 in Function RUN();

    TableNo = "Interface Entry Header INT";

    trigger OnRun();
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
    begin
        //<<HEI.01
        CLEAR(StartExecutionTime);
        CLEAR(EndExecutionTime);
        StartExecutionTime := CURRENTDATETIME;
        //>>HEI.01

        InterfaceFrameworkMgt.SetSimulateMode(SimulateMode);
        ReturnValue := InterfaceFrameworkMgt.ProcessSingleInboundEntry(Rec);

        //<<HEI.01
        EndExecutionTime := CURRENTDATETIME;
        if InterfaceEntryHeader.GET(Rec."Entry No.") then begin
            InterfaceEntryHeader."Start Execution" := StartExecutionTime;
            InterfaceEntryHeader."End Execution" := EndExecutionTime;
            InterfaceEntryHeader.MODIFY(false);
        end;
        //>>HEI.01
    end;

    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        SimulateMode: Boolean;
        ReturnValue: Text;
        StartExecutionTime: DateTime;
        EndExecutionTime: DateTime;

    procedure SetSimulateMode(NewSimulateMode: Boolean);
    begin
        SimulateMode := NewSimulateMode;
    end;

    procedure GetReturnValue(): Text;
    begin
        exit(ReturnValue);
    end;
}

