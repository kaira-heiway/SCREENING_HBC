namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;
using Microsoft.EServices.EDocument;

codeunit 58100 "Maraki Interface Web Service"
{
    // HEI.01 FDD-ET-MARAKI POS Interface IBM NASTAA02 24.06.2018 # Maraki POS Interface
    //   # New Codeunit created for Maraki Interface
    // HEI.02 HT1010 IBM NASTAA02 03.12.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # Used VIP Interface Objects for Maraki
    // HEI.03 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables

    // BC Upgrade SHUKLP03 >> Nav old Id - 50081


    var
        InterfaceNotEnabledErr: TextConst ENU = 'Interface %1 is not enabled.';

    procedure SendSalesDocReq(VAR Request: BigText)
    var
        InterfaceSetup: Record "Interface Setup INT";
        MarakiInterfaceSetup: Record "Maraki Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMappingVIP: Codeunit "Inbound Interface Mapping VIP";
        OutputStream: OutStream;
    begin
        MarakiInterfaceSetup.GET();
        MarakiInterfaceSetup.TESTFIELD("Sales Confirmation Response");
        InterfaceSetup.GET(MarakiInterfaceSetup."Sales Confirmation Response");
        IF NOT InterfaceSetup.Enabled THEN
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'MarakiConfirmation';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT();
        InboundInterfaceMappingVIP.RUN(TempIncomingDocumentAttachment); //HEI.02

        //HEI.03>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMappingVIP);
        CLEAR(OutputStream);
        //HEI.03<<
    end;

    procedure SendStatus(VAR Request: BigText)
    var
        InterfaceSetup: Record "Interface Setup INT";
        MarakiInterfaceSetup: Record "Maraki Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMappingVIP: Codeunit "Inbound Interface Mapping VIP";
        OutputStream: OutStream;
    begin
        MarakiInterfaceSetup.GET();
        MarakiInterfaceSetup.TESTFIELD("Status Update Interface");
        InterfaceSetup.GET(MarakiInterfaceSetup."Status Update Interface");
        IF NOT InterfaceSetup.Enabled THEN
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'StatusUpdate';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT();
        InboundInterfaceMappingVIP.RUN(TempIncomingDocumentAttachment); //HEI.02

        //HEI.03>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMappingVIP);
        CLEAR(OutputStream);
        //HEI.03<<
    end;

}
