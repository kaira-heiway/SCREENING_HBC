codeunit 58044 "EBMS Interface Web Service"
{
    // version HEI.01
    //BC Upgrade GUNREM01 - Old ID 50145

    // HEI.01 CHG2151260-HB2788 COSTES04 23.12.2022 Object created

    trigger OnRun();
    begin
    end;

    var
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';

    procedure SendSalesDocRes(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EBMInterfaceSetup: Record "EBMS Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutputStream: OutStream;
        InboundInterfaceMappingVIP: Codeunit "Inbound Interface Mapping VIP";
    begin
        EBMInterfaceSetup.GET;
        EBMInterfaceSetup.TESTFIELD("Sales Confirmation Interface");
        InterfaceSetup.GET(EBMInterfaceSetup."Sales Confirmation Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EBMSConfirmation';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMappingVIP.RUN(TempIncomingDocumentAttachment);
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMappingVIP);
        CLEAR(OutputStream);
    end;

    procedure SendStatus(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EBMInterfaceSetup: Record "EBMS Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutputStream: OutStream;
        InboundInterfaceMappingVIP: Codeunit "Inbound Interface Mapping VIP";
    begin
        EBMInterfaceSetup.GET;
        EBMInterfaceSetup.TESTFIELD("Sales Confirmation Interface");
        InterfaceSetup.GET(EBMInterfaceSetup."Sales Confirmation Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'StatusUpdate';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMappingVIP.RUN(TempIncomingDocumentAttachment);
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMappingVIP);
        CLEAR(OutputStream);
    end;
}

