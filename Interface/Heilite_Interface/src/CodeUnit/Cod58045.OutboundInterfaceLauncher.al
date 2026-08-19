codeunit 58045 "Outbound Interface Launcher"
{
    // version HEI.01
    //BC Upgrade GUNREM01 - Old ID 50014

    trigger OnRun();
    begin
    end;

    var
        SimulateModeErr: Label 'Simulate Mode';

    local procedure ProcessOutboundEntries();
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
    begin
        InterfaceEntryHeader.SETRANGE(Direction, InterfaceEntryHeader.Direction::Outbound);
        InterfaceEntryHeader.SETRANGE(Status, InterfaceEntryHeader.Status::Pending);
        if InterfaceEntryHeader.FINDSET then
            repeat
                InterfaceSetup.GET(InterfaceEntryHeader."Interface Code");
                if InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous then begin
                    CLEARLASTERROR;
                    COMMIT;
                    if CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeader) then begin
                        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
                        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
                        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
                    end else
                        InterfaceFrameworkMgt.SetInterfaceError(InterfaceEntryHeader, GETLASTERRORTEXT);
                end;
            until InterfaceEntryHeader.NEXT = 0;
    end;
}

