codeunit 58056 "Ibecor Interface Mgmt"
{
    //BC Upgrade GUNREM01 old ID-50180
    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 25.06.2021 Ibecor - PO API
    //   # New Codeunit created for Ibecor Interface


    trigger OnRun();
    begin
    end;

    var
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';

    procedure SendPFI(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        IbecorInterfaceSetup: Record "Ibecor Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
    begin
        //HEI.01>>
        IbecorInterfaceSetup.GET;
        IbecorInterfaceSetup.TESTFIELD("IBECOR PFI");
        InterfaceSetup.GET(IbecorInterfaceSetup."IBECOR PFI");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'Ibecorpfi';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //HEI.01<<
    end;
}

