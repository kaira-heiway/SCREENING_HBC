namespace LatestInterfaceP.LatestInterfaceP;

codeunit 58104 "Interface Proceng LauncherV"
{
    // HEI.01 FDD-PURGAP028 IBM GAVANM01 22.03.2019 # Maximo Goods Receipt
    //   # New function "ProcessMaximoPurchReceipts" created to process differently Maximo Purchase Receipts
    // HEI.02 CHG2051212 IBM GUNERE01 19.12.2019 # ProcessInboundEntries, ProcessOutboundEntries funcs. modified
    // HEI.03 INC3036514 IBM NASTAA02 07/09/2020 # Heilite Interface FuturMaster Discount not being proccessed fully
    //   # Code added on functions 'ProcessInboundEntries' and 'ProcessOutboundEntries'

    // BC Upgrade SHUKLP03 >> Nav old id - 50101
    var

        SimulateModeErr: Label 'Simulate Mode';

    trigger OnRun()
    var
    begin
        //ProcessInboundEntries;
        //ProcessOutboundEntries;
        ProcessMaximoPurchReceipts; //HEI.01
    end;

    LOCAL procedure ProcessInboundEntries()
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
    begin
        InterfaceEntryHeader.SETRANGE(Direction, InterfaceEntryHeader.Direction::Inbound);
        InterfaceEntryHeader.SETRANGE(Status, InterfaceEntryHeader.Status::Pending);
        //HEI.01>>
        GeneralInterfaceSetup.GET;
        InterfaceEntryHeader.SETFILTER("Interface Code", '<>%1', GeneralInterfaceSetup."Maximo Purch. Rcpt. Interface");
        //HEI.01<<
        IF InterfaceEntryHeader.FINDSET THEN
            REPEAT
                InterfaceSetup.GET(InterfaceEntryHeader."Interface Code");
                //HEI.03>>
                IF (InterfaceSetup."Enable Processing Flag" AND InterfaceEntryHeader."Processing Flag") OR
                  NOT InterfaceSetup."Enable Processing Flag"
                THEN
                    //HEI.03<<
                    IF InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous THEN BEGIN
                        //>> HEI.02
                        //CLEARLASTERROR;
                        //COMMIT;
                        //<< HEI.02
                        IF CODEUNIT.RUN(CODEUNIT::"Inbound Interface Processing", InterfaceEntryHeader) THEN BEGIN
                            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
                            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
                            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
                        END ELSE BEGIN
                            InterfaceFrameworkMgt.SetInterfaceError(InterfaceEntryHeader, GETLASTERRORTEXT);
                            InterfaceFrameworkMgt.CreateErrorResponseEntry(InterfaceEntryHeader, GETLASTERRORTEXT);
                        END;
                        //>> HEI.02
                        CLEARLASTERROR;
                        COMMIT;
                        //<< HEI.02
                    END;
            UNTIL InterfaceEntryHeader.NEXT = 0;
    end;

    LOCAL procedure ProcessOutboundEntries()
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
    begin
        InterfaceEntryHeader.SETRANGE(Direction, InterfaceEntryHeader.Direction::Outbound);
        InterfaceEntryHeader.SETRANGE(Status, InterfaceEntryHeader.Status::Pending);
        IF InterfaceEntryHeader.FINDSET THEN
            REPEAT
                InterfaceSetup.GET(InterfaceEntryHeader."Interface Code");
                //HEI.03>>
                IF (InterfaceSetup."Enable Processing Flag" AND InterfaceEntryHeader."Processing Flag") OR
                   NOT InterfaceSetup."Enable Processing Flag"
                THEN
                    //HEI.03<<
                    IF InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous THEN BEGIN
                        //>> HEI.02
                        //CLEARLASTERROR;
                        //COMMIT;
                        //<< HEI.02
                        IF CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeader) THEN BEGIN
                            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
                            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
                            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
                        END ELSE
                            InterfaceFrameworkMgt.SetInterfaceError(InterfaceEntryHeader, GETLASTERRORTEXT);
                        //>> HEI.02
                        CLEARLASTERROR;
                        COMMIT;
                        //<< HEI.02
                    END;
            UNTIL InterfaceEntryHeader.NEXT = 0;
    end;

    LOCAL procedure ProcessMaximoPurchReceipts()
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        POReceiptNo: Code[20];
        InterfaceEntryLine: Record "Interface Entry Line INT";
        POinERR: Boolean;
        POPostingDate: Date;
        Text001: Label 'PO No. %1 waiting for corrections.';
    begin
        //HEI.01>>
        GeneralInterfaceSetup.GET;
        CLEAR(POReceiptNo);
        CLEAR(POPostingDate);
        InterfaceEntryHeader.SETCURRENTKEY("Source No.");
        InterfaceEntryHeader.SETASCENDING("Source No.", TRUE);
        InterfaceEntryHeader.SETRANGE(Direction, InterfaceEntryHeader.Direction::Inbound);
        InterfaceEntryHeader.SETRANGE(Status, InterfaceEntryHeader.Status::Pending);
        InterfaceEntryHeader.SETRANGE("Interface Code", GeneralInterfaceSetup."Maximo Purch. Rcpt. Interface");
        InterfaceEntryHeader.SETAUTOCALCFIELDS("Maximo Issue Type");
        IF InterfaceEntryHeader.FINDSET THEN
            REPEAT
                InterfaceSetup.GET(InterfaceEntryHeader."Interface Code");
                IF InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous THEN BEGIN
                    CLEARLASTERROR;
                    COMMIT;

                    CASE InterfaceEntryHeader."Maximo Issue Type" OF
                        'Receipt':
                            IF (POReceiptNo <> InterfaceEntryHeader."Source No.") OR (POPostingDate <> InterfaceEntryHeader."Posting Date") THEN BEGIN
                                POReceiptNo := InterfaceEntryHeader."Source No.";
                                POPostingDate := InterfaceEntryHeader."Posting Date";
                                POinERR := FALSE;
                                IF CODEUNIT.RUN(CODEUNIT::"Inbound Interface Processing", InterfaceEntryHeader) THEN BEGIN
                                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
                                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
                                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
                                END ELSE BEGIN
                                    POinERR := TRUE;
                                    InterfaceFrameworkMgt.SetInterfaceError(InterfaceEntryHeader, GETLASTERRORTEXT);
                                    InterfaceFrameworkMgt.CreateErrorResponseEntry(InterfaceEntryHeader, GETLASTERRORTEXT);
                                END;
                            END ELSE //if PO Receipt No already exist then move to log without process
                                IF NOT POinERR THEN BEGIN
                                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
                                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
                                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
                                END ELSE BEGIN
                                    InterfaceFrameworkMgt.SetInterfaceError(InterfaceEntryHeader, STRSUBSTNO(Text001, InterfaceEntryHeader."Source No."));
                                    InterfaceFrameworkMgt.CreateErrorResponseEntry(InterfaceEntryHeader, STRSUBSTNO(Text001, InterfaceEntryHeader."Source No."));
                                END;
                        'SHIPRECEIPT',
                      'Return',
                      'VoidReceipt':
                            IF CODEUNIT.RUN(CODEUNIT::"Inbound Interface Processing", InterfaceEntryHeader) THEN BEGIN
                                InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
                                InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
                                InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
                            END ELSE BEGIN
                                InterfaceFrameworkMgt.SetInterfaceError(InterfaceEntryHeader, GETLASTERRORTEXT);
                                InterfaceFrameworkMgt.CreateErrorResponseEntry(InterfaceEntryHeader, GETLASTERRORTEXT);
                            END;
                    END;
                END;
            UNTIL InterfaceEntryHeader.NEXT = 0;
        //HEI.01<<
    end;

}
