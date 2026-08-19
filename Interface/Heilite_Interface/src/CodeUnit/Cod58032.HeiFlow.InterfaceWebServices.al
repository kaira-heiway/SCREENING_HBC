codeunit 58032 "HeiFlow Interface Web Services"
{
    // version HEI.03

    // HEI.01 CHG2132929 IBM POENAB02 05.05.2022 HeiLite GL Postings| Automation for Caribbean OpCo’s SSC
    //   #Object created
    // HEI.02 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables
    // HEI.03 CHG2144425 IBM POENAB02 15.06.2022 HeiLite Vendor Invoice Status| Automation for Caribbean OpCo™s SSC
    //   #New function: SendVendorInvoice

    // BC Upgrade POENAB02: Original (HeiLite) codeunit id 50213
    // BC Upgrade KAPOOV01: 08.04.2026 # Replaced ResponseXML.Add(InputStream) with XmlDocument.ReadFrom(InputStream, ResponseXML) for proper XML parsing.
    // BC Upgrade KAPOOV01: 07.07.2026 # Replaced direct InStream ReadText with ResponseData function to read complete XML response content.
    trigger OnRun();
    begin
    end;

    var
        HeiFLOWInterfaceSetup: Record "HeiFLOW Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';
        SimulateModeErr: Label 'Simulate Mode';
        HeiFlowInterfaceManagement: Codeunit "HeiFlow Interface Management";
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;

    procedure SendJournalLines(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutputStream: OutStream;
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InputStream: InStream;
        //ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument;
    begin
        GeneralInterfaceSetup.Get();
        HeiFLOWInterfaceSetup.Get();
        HeiFLOWInterfaceSetup.TestField("HeiFlow GL Posting Interface");
        HeiFLOWInterfaceSetup.TestField("HeiFlow GL Posting Intf. Resp.");

        InterfaceSetup.Get(HeiFLOWInterfaceSetup."HeiFlow GL Posting Intf. Resp.");
        if not InterfaceSetup.Enabled then
            Error(InterfaceNotEnabledErr, InterfaceSetup.Code);

        InterfaceSetup.Get(HeiFLOWInterfaceSetup."HeiFlow GL Posting Interface");
        if not InterfaceSetup.Enabled then
            Error(InterfaceNotEnabledErr, InterfaceSetup.Code);
        Clear(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'HeiFlowGLImport';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CreateOutStream(OutputStream);
        Request.Write(OutputStream);
        TempIncomingDocumentAttachment.Insert();

        InboundInterfaceMapping.SetSimulateMode(true);
        if not InboundInterfaceMapping.Run(TempIncomingDocumentAttachment) then
            if GetLastErrorText <> SimulateModeErr then begin
                ErrorOccurred := true;
                ErrorMessage := GetLastErrorText;
            end;

        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FindSet(false) then
            repeat
                if InterfaceEntryHeader.Get(TempInboundEntryHdr."Entry No.") then begin
                    HeiFlowInterfaceManagement.CreateJournalConfirmationResponse(InterfaceEntryHeader, InterfaceEntryHeaderOut,
                      HeiFLOWInterfaceSetup."HeiFlow GL Posting Intf. Resp.", ErrorOccurred, ErrorMessage);
                    Codeunit.Run(Codeunit::"Outbound Interface Processing", InterfaceEntryHeaderOut);
                    DataExch.Get(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.Get(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CalcFields("File Content");
                    DataExch2."File Content".CreateInStream(InputStream);
                    //BC upgrade POENAB02 >>
                    //ResponseXML := ResponseXML.XmlDocument;
                    //ResponseXML.Load(InputStream);
                    ResponseXML := XmlDocument.Create();
                    //ResponseXML.Add(InputStream);  // BC Upgrade KAPOOV01: 08.04.2026 Commented
                    XmlDocument.ReadFrom(InputStream, ResponseXML); // BC Upgrade KAPOOV01: 08.04.2026 Added
                    //BC upgrade POENAB02 <<
                    Clear(Request);
                    // BC upgrade POENAB02 >>
                    //Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);

                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);

                    //RespIn.ReadText(RespText); // BC Upgrade KAPOOV01: 07.07.2026 Commented
                    RespText := ResponseData(RespIn);  // BC Upgrade KAPOOV01: 07.07.2026 Added
                    Request.AddText(RespText);
                    // BC upgrade POENAB02 <<
                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
                end;
            until TempInboundEntryHdr.Next() = 0;
        TempInboundEntryHdr.DeleteAll();
        ;

        //HEI.02>>
        Clear(TempIncomingDocumentAttachment);
        Clear(InboundInterfaceMapping);
        Clear(OutputStream);
        Clear(InputStream);
        Clear(ResponseXML);
        //HEI.02<<
    end;

    procedure SendVendorInvoice(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        //ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument;
    begin
        //HEI.03
        GeneralInterfaceSetup.Get();
        HeiFLOWInterfaceSetup.Get();
        HeiFLOWInterfaceSetup.TestField("HeiFlow Vend. Inv. Request");
        HeiFLOWInterfaceSetup.TestField("HeiFlow Vend. Inv. Response");

        InterfaceSetup.Get(HeiFLOWInterfaceSetup."HeiFlow Vend. Inv. Response");
        if not InterfaceSetup.Enabled then
            Error(InterfaceNotEnabledErr, InterfaceSetup.Code);

        InterfaceSetup.Get(HeiFLOWInterfaceSetup."HeiFlow Vend. Inv. Request");
        if not InterfaceSetup.Enabled then
            Error(InterfaceNotEnabledErr, InterfaceSetup.Code);
        Clear(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'HeiFlowVendorReq';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CreateOutStream(OutputStream);
        Request.Write(OutputStream);
        TempIncomingDocumentAttachment.Insert();
        InboundInterfaceMapping.Run(TempIncomingDocumentAttachment);
        TempInboundEntryHdr.DeleteAll();
        Clear(TempIncomingDocumentAttachment);
        Clear(InboundInterfaceMapping);
        Clear(OutputStream);
        Clear(InputStream);
        Clear(ResponseXML);
        //HEI.03<<
    end;
    // BC Upgrade KAPOOV01: 07.07.2026 Added new function >>
    procedure ResponseData(ResInstream: InStream): Text
    var
        RespTextChunk: Text;
        RespTextData: Text;
    begin
        while not ResInstream.EOS do begin
            RespTextChunk := '';
            ResInstream.ReadText(RespTextChunk);
            RespTextData += RespTextChunk;
        end;
        exit(RespTextData);
    end;
    // BC Upgrade KAPOOV01: 07.07.2026 Added new function <<
}

