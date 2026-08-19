codeunit 58009 "Inbound Interface Process VIP"
{
    // Heilite Navision Old Id - 50093

    // version HEI.01

    // HEI.01 HT1010 IBM NASTAA02 28.11.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # New Codeunit created
    // HEI.02 CHG2112261 IBM SAXENA03 20.05.2021
    //   # Interface Logging processing Execution Time and Webservices Response Times
    //   # Added new application code to to Update Start execution and End execution date
    //     of Table 50161 in Function RUN();

    TableNo = "Interface Entry Header VIP INT";

    trigger OnRun();
    var
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
    begin
        //<<HEI.02
        CLEAR(StartExecutionTime);
        CLEAR(EndExecutionTime);
        StartExecutionTime := CURRENTDATETIME;
        //>>HEI.02

        InterfaceFrameworkMgtVIP.SetSimulateMode(SimulateMode);
        ReturnValue := InterfaceFrameworkMgtVIP.ProcessSingleInboundEntry(Rec);

        //<<HEI.02
        EndExecutionTime := CURRENTDATETIME;
        if InterfaceEntryHeaderVIP.GET(Rec."Entry No.") then begin
            InterfaceEntryHeaderVIP."Start Execution" := StartExecutionTime;
            InterfaceEntryHeaderVIP."End Execution" := EndExecutionTime;
            InterfaceEntryHeaderVIP.MODIFY(false);
        end;
        //>>HEI.02
    end;

    var
        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt. VIP";
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

