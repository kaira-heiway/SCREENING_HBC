codeunit 58042 "PowerApps Web Service"
{
    // version HEI.03
    //BC Upgrade GUNERE01 - Old ID 50121
    // HEI.01 CHG2069321 GAVANM01 IBM 13.10.2020 #PowerApps Integration
    // HEI.02 CHG2094470 HB1870 IBM.GUNERE01 18.06.2021 # ApprovalPOResponse func. created
    // HEI.03 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables


    trigger OnRun();
    begin
    end;

    var
        PowerAppsInterfaceSetup: Record "PowerApps Interface Setup INT";
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';
        OutputStream: OutStream;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping VIP";
        ErrorOccurred: Boolean;
        ErrorMessage: Text;

    procedure ApprovalResponse(var Request: BigText) ErrorMessage: Text;
    var
        InterfaceSetup: Record "Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
    begin
        PowerAppsInterfaceSetup.GET;
        PowerAppsInterfaceSetup.TESTFIELD("Enable PowerApps Integration", true);
        PowerAppsInterfaceSetup.TESTFIELD("Approval Interface Response");
        InterfaceSetup.GET(PowerAppsInterfaceSetup."Approval Interface Response");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'PowerAppsApprovalResponse';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
        end;

        //HEI.03>>
        CLEAR(OutputStream);
        CLEAR(InboundInterfaceMapping);
        CLEAR(TempIncomingDocumentAttachment);
        //HEI.03<<

        exit(ErrorMessage);
    end;

    procedure ApprovalPOResponse(var Request: BigText) ErrorMessage: Text;
    var
        InterfaceSetup: Record "Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
    begin
        //>> HEI.02
        PowerAppsInterfaceSetup.GET;
        PowerAppsInterfaceSetup.TESTFIELD("Enable PowerApps PO Intg.", true);
        PowerAppsInterfaceSetup.TESTFIELD("PO Approval Interface Response");
        InterfaceSetup.GET(PowerAppsInterfaceSetup."PO Approval Interface Response");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'PowerAppsPOApprovalResponse';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
        end;

        //HEI.03>>
        CLEAR(OutputStream);
        CLEAR(InboundInterfaceMapping);
        CLEAR(TempIncomingDocumentAttachment);
        //HEI.03<<

        exit(ErrorMessage);
        //<< HEI.02
    end;
}

