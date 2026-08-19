codeunit 58084 "EDI Interface Web Services"
{
    //BC Upgrade GUNREM01 Old ID-50103
    // version HEI.02

    // HEI.01 CHG2026335 HT653 FDD_La Reunion_EDI_EDI Order IBM GAVANM01 04.10.2019 - #new object
    // HEI.02 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables


    trigger OnRun();
    begin
    end;

    var
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';

    procedure SendSOUpdate(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EDIInterfaceSetup: Record "EDI Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
    begin
        EDIInterfaceSetup.GET;
        EDIInterfaceSetup.TESTFIELD("SO/SRO Interface Request");
        InterfaceSetup.GET(EDIInterfaceSetup."SO/SRO Interface Request");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EDISOUpdate';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream, TEXTENCODING::UTF8);
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

