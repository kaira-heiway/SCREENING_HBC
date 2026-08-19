codeunit 58062 "FM Interface Web Service"
{
    // version FM,HEI.05
    //BC upgrade GUNREM01 Old ID-50061
    // HEI.03 S&OP IBM POSTOI01 15.02.2019 # New function for Production Requisition interface
    // HEI.04 S&OP IBM POSTOI01 15.02.2019 # New function for Production Orders interface
    // HEI.05 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables


    trigger OnRun();
    begin
    end;

    var
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';
        InterfaceEntryHeader: Record "Interface Entry Header INT";

    procedure SendPurchaseRequisition(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        FM2InterfaceSetup: Record "FuturMaster Interf Setup_2 INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CounterpointInterfaceMgmt: Codeunit "Counterpoint Interface Mgmt.";
        OutputStream: OutStream;
    begin
        //HEI.03>>
        FM2InterfaceSetup.GET;
        FM2InterfaceSetup.TESTFIELD("Purch. Requisitions Interface");
        InterfaceSetup.GET(FM2InterfaceSetup."Purch. Requisitions Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendPurchaseRequisition';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //HEI.03<<

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.05<<
    end;

    procedure SendProductionOrders(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        FM2InterfaceSetup: Record "FuturMaster Interf Setup_2 INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CounterpointInterfaceMgmt: Codeunit "Counterpoint Interface Mgmt.";
        OutputStream: OutStream;
    begin
        //HEI.04>>
        FM2InterfaceSetup.GET;
        FM2InterfaceSetup.TESTFIELD("Production Orders Interface");
        InterfaceSetup.GET(FM2InterfaceSetup."Production Orders Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendProductionOrders';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //HEI.04<<

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.05<<
    end;
}

