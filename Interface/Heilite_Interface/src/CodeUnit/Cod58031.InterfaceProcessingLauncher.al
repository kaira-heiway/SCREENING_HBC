codeunit 58031 "Interface Processing Launcher"
{
    // Heilite Navision Old Id - 50009
    // version HEI.01

    // HEI.01 FDD-PURGAP028 IBM GAVANM01 22.03.2019 # Maximo Goods Receipt
    //   # New function "ProcessMaximoPurchReceipts" created to process differently Maximo Purchase Receipts
    // HEI.02 CHG2051212 IBM GUNERE01 19.12.2019 # ProcessInboundEntries, ProcessOutboundEntries funcs. modified
    // HEI.03 INC3036514 IBM NASTAA02 07/09/2020 # Heilite Interface FuturMaster Discount not being proccessed fully
    //   # Code added on functions 'ProcessInboundEntries' and 'ProcessOutboundEntries'
    // HEI.05 FDD-HB1195 CHG2070051 IBM NANDIS01 Import Purchasing & Receiving process HeiLite-Maximo integration
    //   New tag 'Transfer' introduced for Maximo Purchase Receipt process
    // HEI.06 FDD - HB1797 CHG2086227 IBM NANDIS01 13.09.2021 - LOG_GR Acknowledgement Message to Global Maximo (aka req.2 of HB1688)
    // # Block the code of function - ProcessMaximoPurchReceipts


    trigger OnRun();
    begin
        ProcessInboundEntries;
        ProcessOutboundEntries;
        //HEI.06>>
        //ProcessMaximoPurchReceipts; //HEI.01
        //HEI.06<<
    end;

    var
        SimulateModeErr: Label 'Simulate Mode';

    local procedure ProcessInboundEntries();
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
        if InterfaceEntryHeader.FINDSET then
            repeat
                InterfaceSetup.GET(InterfaceEntryHeader."Interface Code");
                //HEI.03>>
                if (InterfaceSetup."Enable Processing Flag" and InterfaceEntryHeader."Processing Flag") or
                  not InterfaceSetup."Enable Processing Flag"
                then
                    //HEI.03<<
                    if InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous then begin
                        //>> HEI.02
                        //CLEARLASTERROR;
                        //COMMIT;
                        //<< HEI.02
                        if CODEUNIT.RUN(CODEUNIT::"Inbound Interface Processing", InterfaceEntryHeader) then begin
                            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
                            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
                            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
                        end else begin
                            InterfaceFrameworkMgt.SetInterfaceError(InterfaceEntryHeader, GETLASTERRORTEXT);
                            InterfaceFrameworkMgt.CreateErrorResponseEntry(InterfaceEntryHeader, GETLASTERRORTEXT);
                        end;
                        //>> HEI.02
                        CLEARLASTERROR;
                        COMMIT;
                        //<< HEI.02
                    end;
            until InterfaceEntryHeader.NEXT = 0;
    end;

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
                //HEI.03>>
                if (InterfaceSetup."Enable Processing Flag" and InterfaceEntryHeader."Processing Flag") or
                   not InterfaceSetup."Enable Processing Flag"
                then
                    //HEI.03<<
                    if InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous then begin
                        //>> HEI.02
                        //CLEARLASTERROR;
                        //COMMIT;
                        //<< HEI.02
                        if CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeader) then begin
                            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
                            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
                            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
                        end else
                            InterfaceFrameworkMgt.SetInterfaceError(InterfaceEntryHeader, GETLASTERRORTEXT);
                        //>> HEI.02
                        CLEARLASTERROR;
                        COMMIT;
                        //<< HEI.02
                    end;
            until InterfaceEntryHeader.NEXT = 0;
    end;

    local procedure ProcessMaximoPurchReceipts();
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        POReceiptNo: Code[20];
        InterfaceEntryLine: Record "Interface Entry Line INT";
        POinERR: Boolean;
        Text001: Label 'PO No. %1 waiting for corrections.';
        POPostingDate: Date;
    begin
        //HEI.01>>
        GeneralInterfaceSetup.GET;
        CLEAR(POReceiptNo);
        CLEAR(POPostingDate);
        InterfaceEntryHeader.SETCURRENTKEY("Source No.");
        InterfaceEntryHeader.SETASCENDING("Source No.", true);
        InterfaceEntryHeader.SETRANGE(Direction, InterfaceEntryHeader.Direction::Inbound);
        InterfaceEntryHeader.SETRANGE(Status, InterfaceEntryHeader.Status::Pending);
        InterfaceEntryHeader.SETRANGE("Interface Code", GeneralInterfaceSetup."Maximo Purch. Rcpt. Interface");
        InterfaceEntryHeader.SETAUTOCALCFIELDS("Maximo Issue Type");
        if InterfaceEntryHeader.FINDSET then
            repeat
                InterfaceSetup.GET(InterfaceEntryHeader."Interface Code");
                if InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous then begin
                    CLEARLASTERROR;
                    COMMIT;

                    case InterfaceEntryHeader."Maximo Issue Type" of
                        'Receipt':
                            if (POReceiptNo <> InterfaceEntryHeader."Source No.") or (POPostingDate <> InterfaceEntryHeader."Posting Date") then begin
                                POReceiptNo := InterfaceEntryHeader."Source No.";
                                POPostingDate := InterfaceEntryHeader."Posting Date";
                                POinERR := false;
                                if CODEUNIT.RUN(CODEUNIT::"Inbound Interface Processing", InterfaceEntryHeader) then begin
                                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
                                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
                                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
                                end else begin
                                    POinERR := true;
                                    InterfaceFrameworkMgt.SetInterfaceError(InterfaceEntryHeader, GETLASTERRORTEXT);
                                    InterfaceFrameworkMgt.CreateErrorResponseEntry(InterfaceEntryHeader, GETLASTERRORTEXT);
                                end;
                            end else //if PO Receipt No already exist then move to log without process
                                if not POinERR then begin
                                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
                                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
                                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
                                end else begin
                                    InterfaceFrameworkMgt.SetInterfaceError(InterfaceEntryHeader, STRSUBSTNO(Text001, InterfaceEntryHeader."Source No."));
                                    InterfaceFrameworkMgt.CreateErrorResponseEntry(InterfaceEntryHeader, STRSUBSTNO(Text001, InterfaceEntryHeader."Source No."));
                                end;
                        'SHIPRECEIPT',
                      'Return',
                      //HEI.05>>
                      //'VoidReceipt':
                      'VoidReceipt',
                      'Transfer':
                            //HEI.05<<
                            if CODEUNIT.RUN(CODEUNIT::"Inbound Interface Processing", InterfaceEntryHeader) then begin
                                InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
                                InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
                                InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
                            end else begin
                                InterfaceFrameworkMgt.SetInterfaceError(InterfaceEntryHeader, GETLASTERRORTEXT);
                                InterfaceFrameworkMgt.CreateErrorResponseEntry(InterfaceEntryHeader, GETLASTERRORTEXT);
                            end;
                    end;
                end;
            until InterfaceEntryHeader.NEXT = 0;
        //HEI.01<<
    end;
}

