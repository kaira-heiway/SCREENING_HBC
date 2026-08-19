codeunit 58047 "Maximo Interface Web Services"
{
    // version HEI.03
    // BC Upgrade GUNREM01 - Old ID 50033

    // HEI.01 FDD-PURGAPINT002 IBM LAZARE02 14.09.2017 # New codeunit to handle received Maximo messages
    // HEI.02 FDD - HB1797 CHG2086227 IBM NANDIS01 13.09.2021 - LOG_GR Acknowledgement Message to Global Maximo (aka req.2 of HB1688)
    //   # Change the Maximo Purch Rcpt to Sync from Async
    // HEI.03 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables
    //BC UPGRADE ATHUKS01 FDDSTP_GAP11 >>
    //1.Added new method CreatXMLDocument for prepare xml to Maximo responses. 
    //2.Added new function ResponseData to read the response data from InStream and return as Text.
    //BC UPGRADE ATHUKS01 FDDSTP_GAP11 <<
    trigger OnRun();
    var
        Mes: BigText;
    begin
    end;

    var
        SimulateModeErr: Label 'Simulate Mode';
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';

    procedure SendPRCreation(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        ErrorText: Text;
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC Upgrade GUNREM01 - Replaced DotNet XmlDocument with XmlDocument variable due to deprecation of DotNet in BC
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        MaximoInterfaceMgt: Codeunit "Maximo Interface Management";
    begin
        GeneralInterfaceSetup.GET;
        GeneralInterfaceSetup.TESTFIELD("Maximo PR Interface");
        InterfaceSetup.GET(GeneralInterfaceSetup."Maximo PR Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'MaximoPRCreation';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.03>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.03<<
    end;

    procedure SendPurchaseReceipt(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        "_HEI.02_": Integer;
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        ErrorText: Text;
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC Upgrade GUNREM01 - Replaced DotNet XmlDocument with XmlDocument variable due to deprecation of DotNet in BC
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        MaximoInterfaceMgt: Codeunit "Maximo Interface Management";
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        GeneralInterfaceSetup.GET;
        GeneralInterfaceSetup.TESTFIELD("Maximo Purch. Rcpt. Interface");
        //HEI.02>>
        GeneralInterfaceSetup.TESTFIELD("Maximo Purch. Rcpt. Confirmtn.");
        //HEI.02<<
        InterfaceSetup.GET(GeneralInterfaceSetup."Maximo Purch. Rcpt. Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'MaximoPurchaseReceipt';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        //HEI.02>>
        //InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        InboundInterfaceMapping.SetSimulateMode(true);
        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then
            if GETLASTERRORTEXT <> SimulateModeErr then begin
                ErrorOccurred := true;
                ErrorMessage := GETLASTERRORTEXT;
            end;

        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FINDSET then
            repeat
                if InterfaceEntryHeader.GET(TempInboundEntryHdr."Entry No.") then begin
                    MaximoInterfaceMgt.CreatePurchRcptConfirmationResponse(InterfaceEntryHeader, InterfaceEntryHeaderOut,
                                                          GeneralInterfaceSetup."Maximo Purch. Rcpt. Confirmtn.", ErrorOccurred, ErrorMessage);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);
                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    //  ResponseXML := XmlDocument.Create();
                    //ResponseXML.Add(InputStream);
                    CreateXMDocument(InputStream, ResponseXML);//BC UPGRADE ATHUKS01 FDDSTP_GAP11
                    //BC Upgrade GUNREM01 <<
                    CLEAR(Request);
                    //BC Upgrade GUNREM01 >>
                    // Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);
                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    //BC Upgrade ATHUKS01 >>
                    //RespIn.ReadText(RespText);
                    RespText := ResponseData(RespIn);
                    Request.AddText(RespText);
                    //BC Upgrade ATHUKS01 <<
                    //BC Upgrade GUNREM01 <<
                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);

                end;
            until TempInboundEntryHdr.NEXT = 0;
        TempInboundEntryHdr.DELETEALL;
        //HEI.02<<

        //HEI.03>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        CLEAR(ResponseXML);
        //HEI.03<<
    end;

    procedure SendGoodsIssue(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
    begin
        GeneralInterfaceSetup.GET;
        GeneralInterfaceSetup.TESTFIELD("Maximo Goods Issue Interface");
        InterfaceSetup.GET(GeneralInterfaceSetup."Maximo Goods Issue Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'MaximoGoodsIssue';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.03>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.03<<
    end;

    procedure SendStockAdjustment(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
    begin
        GeneralInterfaceSetup.GET;
        GeneralInterfaceSetup.TESTFIELD("Maximo Stock Adjmt. Interface");
        InterfaceSetup.GET(GeneralInterfaceSetup."Maximo Stock Adjmt. Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'MaximoStockAdjustment';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.03>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.03<<
    end;

    procedure SendGoodsTransfer(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
    begin
        GeneralInterfaceSetup.GET;
        GeneralInterfaceSetup.TESTFIELD("Maximo Goods Transf. Interface");
        InterfaceSetup.GET(GeneralInterfaceSetup."Maximo Goods Transf. Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'MaximoStockTransfer';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.03>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.03<<
    end;

    //BC UPGRADE ATHUKS01 FDDSTP_GAP11>>
    procedure CreateXMDocument(InputStream: InStream; var ResponseXML: XmlDocument);
    var
        TempText: Text;
        RespText: Text;
        StartPos: Integer;
    begin
        while not InputStream.EOS do begin
            InputStream.ReadText(TempText);
            RespText += TempText;
        end;
        StartPos := StrPos(RespText, '<');
        if StartPos > 1 then
            RespText := CopyStr(RespText, StartPos);
        XmlDocument.ReadFrom(RespText, ResponseXML);
    end;
    //BC UPGRADE ATHUKS01 FDDSTP_GAP11<<
    //BC UPGRADE ATHUKS01>>
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
    //BC UPGRADE ATHUKS01<<
}

