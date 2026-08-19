codeunit 58082 "Counterpoint Interface WS"
{
    //BC Upgrade GUNREM01 Old ID-50065
    // version HEI.02

    // HEI.01 BA-SLSGAP01 IBM LAZARE02 15.10.2018 # New codeunit for Counterpoint interface
    // HEI.02 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables


    trigger OnRun();
    begin
    end;

    var
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';

    procedure SendSales(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CounterpointInterfaceSetup: Record "Counterpoint Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CounterpointInterfaceMgmt: Codeunit "Counterpoint Interface Mgmt.";
        OutputStream: OutStream;
    begin
        CounterpointInterfaceSetup.GET;
        CounterpointInterfaceSetup.TESTFIELD("Sales Interface");
        InterfaceSetup.GET(CounterpointInterfaceSetup."Sales Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendSalesEntries';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

    procedure SendPayments(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CounterpointInterfaceSetup: Record "Counterpoint Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CounterpointInterfaceMgmt: Codeunit "Counterpoint Interface Mgmt.";
        OutputStream: OutStream;
    begin
        CounterpointInterfaceSetup.GET;
        CounterpointInterfaceSetup.TESTFIELD("Payments Interface");
        InterfaceSetup.GET(CounterpointInterfaceSetup."Payments Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendPaymentsEntries';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

    procedure SendPayouts(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CounterpointInterfaceSetup: Record "Counterpoint Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CounterpointInterfaceMgmt: Codeunit "Counterpoint Interface Mgmt.";
        OutputStream: OutStream;
    begin
        CounterpointInterfaceSetup.GET;
        CounterpointInterfaceSetup.TESTFIELD("Payouts Interface");
        InterfaceSetup.GET(CounterpointInterfaceSetup."Payouts Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendPayoutsEntries';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

    procedure SendStockAdjustments(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CounterpointInterfaceSetup: Record "Counterpoint Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CounterpointInterfaceMgmt: Codeunit "Counterpoint Interface Mgmt.";
        OutputStream: OutStream;
    begin
        CounterpointInterfaceSetup.GET;
        CounterpointInterfaceSetup.TESTFIELD("Stock Adjustments Interface");
        InterfaceSetup.GET(CounterpointInterfaceSetup."Stock Adjustments Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendStockAdjustments';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

    procedure SendStockTransfers(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CounterpointInterfaceSetup: Record "Counterpoint Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CounterpointInterfaceMgmt: Codeunit "Counterpoint Interface Mgmt.";
        OutputStream: OutStream;
    begin
        CounterpointInterfaceSetup.GET;
        CounterpointInterfaceSetup.TESTFIELD("Stock Transfers Interface");
        InterfaceSetup.GET(CounterpointInterfaceSetup."Stock Transfers Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendStockTransfers';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

    procedure SendReceiptsNonCore(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CounterpointInterfaceSetup: Record "Counterpoint Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CounterpointInterfaceMgmt: Codeunit "Counterpoint Interface Mgmt.";
        OutputStream: OutStream;
    begin
        CounterpointInterfaceSetup.GET;
        CounterpointInterfaceSetup.TESTFIELD("Receipts Non Core Interface");
        InterfaceSetup.GET(CounterpointInterfaceSetup."Receipts Non Core Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendReceiptsNonCore';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

    procedure SendRTVNonCore(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CounterpointInterfaceSetup: Record "Counterpoint Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CounterpointInterfaceMgmt: Codeunit "Counterpoint Interface Mgmt.";
        OutputStream: OutStream;
    begin
        CounterpointInterfaceSetup.GET;
        CounterpointInterfaceSetup.TESTFIELD("RTV Non Core Interface");
        InterfaceSetup.GET(CounterpointInterfaceSetup."RTV Non Core Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendRTVNonCore';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;
}

