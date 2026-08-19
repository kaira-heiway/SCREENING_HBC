codeunit 58112 "Interface Process Launcher VIP"
{
    //BC Upgrade VAMSIU01 - Old NavID - 50087

    // version HEI.01

    // HEI.01 HT1010 IBM NASTAA02 28.11.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # New Codeunit created
    // HEI.02 RITM2646474 CHG2098904 IBM GAVANM01 01.04.2021 #Set up Credit Limit workflow approval for MZ SellCo
    //   # For Sales Approval App process only one outbound per job run


    trigger OnRun();
    begin
        ProcessInboundEntries;
        ProcessOutboundEntries;
    end;

    var
        SimulateModeErr: Label 'Simulate Mode';

    local procedure ProcessInboundEntries();
    var
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt. VIP";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
    begin
        GeneralInterfaceSetup.GET;

        InterfaceEntryHeaderVIP.SETRANGE(Direction, InterfaceEntryHeaderVIP.Direction::Inbound);
        InterfaceEntryHeaderVIP.SETRANGE(Status, InterfaceEntryHeaderVIP.Status::Pending);
        if InterfaceEntryHeaderVIP.FINDSET then
            repeat
                InterfaceSetup.GET(InterfaceEntryHeaderVIP."Interface Code");
                if InterfaceSetup."VIP Interface" and (InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous) then begin
                    CLEARLASTERROR;
                    COMMIT;
                    if CODEUNIT.RUN(CODEUNIT::"Inbound Interface Process VIP", InterfaceEntryHeaderVIP) then begin
                        InterfaceFrameworkMgtVIP.SetInterfaceProcessed(InterfaceEntryHeaderVIP);
                        InterfaceFrameworkMgtVIP.LogInterfaceEntries(InterfaceEntryHeaderVIP);
                        InterfaceFrameworkMgtVIP.DeleteInterfaceEntries(InterfaceEntryHeaderVIP);
                    end else
                        InterfaceFrameworkMgtVIP.SetInterfaceError(InterfaceEntryHeaderVIP, GETLASTERRORTEXT);
                end;
            until InterfaceEntryHeaderVIP.NEXT = 0;
    end;

    local procedure ProcessOutboundEntries();
    var
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt. VIP";
        CounterPowerAppsOutbounds: Integer;
        PowerAppsInterfaceSetup: Record "PowerApps Interface Setup INT";
    begin
        if PowerAppsInterfaceSetup.GET then;  //HEI.02
        InterfaceEntryHeaderVIP.SETRANGE(Direction, InterfaceEntryHeaderVIP.Direction::Outbound);
        InterfaceEntryHeaderVIP.SETRANGE(Status, InterfaceEntryHeaderVIP.Status::Pending);
        if InterfaceEntryHeaderVIP.FINDSET then
            repeat
                InterfaceSetup.GET(InterfaceEntryHeaderVIP."Interface Code");
                //HEI.02<<
                if InterfaceEntryHeaderVIP."Interface Code" = PowerAppsInterfaceSetup."Approval Interface Request" then
                    CounterPowerAppsOutbounds += 1;
                //HEI.02>>
                if InterfaceSetup."VIP Interface" and (InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous) then begin
                    if (InterfaceEntryHeaderVIP."Interface Code" <> PowerAppsInterfaceSetup."Approval Interface Request") or (CounterPowerAppsOutbounds = 1) then begin  //HEI.02
                        CLEARLASTERROR;
                        COMMIT;
                        if CODEUNIT.RUN(CODEUNIT::"Outbound Interface Process VIP", InterfaceEntryHeaderVIP) then begin
                            InterfaceFrameworkMgtVIP.SetInterfaceProcessed(InterfaceEntryHeaderVIP);
                            InterfaceFrameworkMgtVIP.LogInterfaceEntries(InterfaceEntryHeaderVIP);
                            InterfaceFrameworkMgtVIP.DeleteInterfaceEntries(InterfaceEntryHeaderVIP);
                        end else
                            InterfaceFrameworkMgtVIP.SetInterfaceError(InterfaceEntryHeaderVIP, GETLASTERRORTEXT);
                    end;   //HEI.02
                end;
            until InterfaceEntryHeaderVIP.NEXT = 0;
    end;
}

