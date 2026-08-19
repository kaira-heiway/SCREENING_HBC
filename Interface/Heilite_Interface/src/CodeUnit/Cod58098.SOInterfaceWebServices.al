namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;
using Microsoft.EServices.EDocument;

codeunit 58098 "SO Interface Web Services"
{
    // HEI.01 FDD-SR_HT543b IBM HORTOC01 06.06.2019 # new object
    // HEI.02 FDD-HT736 IBM GUNERE01 10.09.2019 # SendRASalesOrderRequest,SendPmtRfdRequest funcs. added
    // HEI.03 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables

    // BC Upgrade SHUKLP03 >> Nav old Id - 50078
    var
        InterfaceNotEnabledErr: TextConst ENU = 'Interface %1 is not enabled.';


    procedure SendSalesOrderRequest(VAR Request: BigText)
    var
        InterfaceSetup: Record "Interface Setup INT";
        OrtecKStoreInterfaceSetup: Record "Ortec & KStore Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
    begin
        OrtecKStoreInterfaceSetup.GET();
        OrtecKStoreInterfaceSetup.TESTFIELD("SO/SRO Interface Request");
        InterfaceSetup.GET(OrtecKStoreInterfaceSetup."SO/SRO Interface Request");
        IF NOT InterfaceSetup.Enabled THEN
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SalesOrderRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT();
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.03>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.03<<
    end;

    procedure SendRASalesOrderRequest(VAR Request: BigText)
    var
        InterfaceSetup: Record "Interface Setup INT";
        OrtecKStoreInterfaceSetup: Record "Ortec & KStore Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
    begin
        //>> HEI.02 FDD-HT736 IBM GUNERE01 10.09.2019
        OrtecKStoreInterfaceSetup.GET();
        OrtecKStoreInterfaceSetup.TESTFIELD("RA SO/SRO Interface Request");
        InterfaceSetup.GET(OrtecKStoreInterfaceSetup."RA SO/SRO Interface Request");
        IF NOT InterfaceSetup.Enabled THEN
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'RASalesOrderRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT();
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //<< HEI.02 FDD-HT736 IBM GUNERE01 10.09.2019

        //HEI.03>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.03<<
    end;

    procedure SendPmtRfdRequest(VAR Request: BigText)
    var
        InterfaceSetup: Record "Interface Setup INT";
        OrtecInterfaceSetup: Record "Ortec & KStore Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
    begin
        //>> HEI.02 FDD-HT736 IBM GUNERE01 10.09.2019
        OrtecInterfaceSetup.GET();
        OrtecInterfaceSetup.TESTFIELD("RA Payment/Refund Request");
        InterfaceSetup.GET(OrtecInterfaceSetup."RA Payment/Refund Request");
        IF NOT InterfaceSetup.Enabled THEN
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'PaymentRefundRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT();
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //<< HEI.02 FDD-HT736 IBM GUNERE01 10.09.2019

        //HEI.03>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.03<<
    end;


}
