namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;
using Microsoft.Sales.Document;
using Microsoft.EServices.EDocument;

codeunit 58099 "Ortec Interface Web Services"
{
    // HEI.01 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new object
    // HEI.02 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables

    // BC Upgrade SHUKLP03 >> Nav old Id - 50076


    procedure SendSOUpdate(VAR Request: BigText)
    var
        InterfaceSetup: Record "Interface Setup INT";
        OrtecInterfaceSetup: Record "Ortec & KStore Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        InterfaceNotEnabledErr: TextConst ENU = 'Interface %1 is not enabled.';
    begin
        OrtecInterfaceSetup.GET();
        OrtecInterfaceSetup.TESTFIELD("SO Update Interface");
        InterfaceSetup.GET(OrtecInterfaceSetup."SO Update Interface");
        IF NOT InterfaceSetup.Enabled THEN
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'OrtecSOUpdate';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT();
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

}
