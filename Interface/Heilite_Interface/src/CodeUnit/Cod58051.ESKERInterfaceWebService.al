codeunit 58051 "ESKER Interface Web Service"
{
    //BC Upgrade GUNREM01 Old ID- 50056
    // version ESKER,HEI.05

    // HEI.01 CHG2022396 Esker Ethiopia IBM POSTOI01 09.07.2019
    //   # new SendWHTRequest created
    // HEI.02 CHG2022396 Esker Ethiopia IBM POSTOI01 09.07.2019
    //   # new SendLCRequest created
    // HEI.03 FDD HB1348 CHG2061857 IBM SHANKJ03 25.06.2020
    // # New SendVendorPostingGrpRequest Created
    // 
    // HEI.04 CHG2095187 IBM SAXENA03 11.03.2021
    //   # Code written for Paraller Request
    //   # Peace of code commented and added new code to replace FINDLAST with Entry No. in below Function
    //     SendCostCenterRequest()
    //     SendCompanyRequest()
    //     SendGLAccountRequest()
    //     SendBrandRequest()
    //     SendVendorRequest()
    //     SendCurrencyRequest()
    //     SendTaxCodeRequest()
    //     SendPaymTermRequest()
    //     SendBankDetailRequest()
    //     SendPOHeaderRequest()
    //     SendPOLineRequest()
    //     SendPaymStatusRequest()
    //     SendWHTRequest()
    //     SendLCRequest()
    //     SendVendorPostingGrpRequest()
    // HEI.05 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables
    // BC UPGRADE ATHUKS01 ESKER >>  
    //1 Added new code for Prepare XML for ESKER Response.
    //2 Added new function ResponseData to read the response data from InStream and return as Text.
    // BC UPGRADE ATHUKS01 ESKER <<


    trigger OnRun();
    begin
    end;

    var
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        TxtG50002: TextConst ENU = 'POSTING ERROR: %1', FRA = 'ERREUR VALIDATION: %1';
        TxtG50001: Label 'No document to post !';

    procedure SendCostCenterRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC upgrade GUNREM01 Replaced Dotnet variable
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        EskerInterfaceManag: Codeunit "ESKER Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        EskerInterfaceSetup.GET;
        EskerInterfaceSetup.TESTFIELD(EskerInterfaceSetup."Esker CostCenters Req Interf");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker CostCenters Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EskerCCRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
            //ERROR(ErrorMessage);
        end;
        //<<HEI.04
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            EskerInterfaceManag.ProcessCostCenterRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.NEXT = 0;
        */
        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FINDSET then
            repeat
                if InterfaceEntryHeader.GET(TempInboundEntryHdr."Entry No.") then begin
                    EskerInterfaceManag.ProcessCostCenterRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    // BC UPGRADE ATHUKS01 ESKER>>
                    // ResponseXML := XmlDocument.Create();
                    // ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC UPGRADE ATHUKS01 ESKER<<
                    //BC Upgrade GUNREM01 <<
                    CLEAR(Request);
                    //BC Upgrade GUNREM01 >>
                    //  Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);
                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    //BC Upgrade ATHUKS01 >>
                    //RespIn.ReadText(RespText);
                    RespText := ResponseData(RespIn);
                    //BC Upgrade ATHUKS01 <<
                    Request.AddText(RespText);
                    //BC Upgrade GUNREM01 <<

                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
                end;
            until TempInboundEntryHdr.NEXT = 0;
        TempInboundEntryHdr.DELETEALL;
        //<<HEI.04

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        CLEAR(ResponseXML);
        //HEI.05<<

    end;

    procedure SendCompanyRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        // ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC upgrade GUNREM01 Replaced Dotnet variable
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        EskerInterfaceManag: Codeunit "ESKER Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        EskerInterfaceSetup.GET;
        EskerInterfaceSetup.TESTFIELD(EskerInterfaceSetup."Esker Company Req Interf");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker Company Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EskerCompRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
            //ERROR(ErrorMessage);
        end;
        //<<HEI.04
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            EskerInterfaceManag.ProcessCompanyRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.NEXT = 0;
        */
        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FINDSET then
            repeat
                if InterfaceEntryHeader.GET(TempInboundEntryHdr."Entry No.") then begin
                    EskerInterfaceManag.ProcessCompanyRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    // BC UPGRADE ATHUKS01 ESKER>>
                    // ResponseXML := XmlDocument.Create();
                    // ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC UPGRADE ATHUKS01 ESKER<<
                    //BC Upgrade GUNREM01 <<
                    CLEAR(Request);
                    //BC Upgrade GUNREM01 >>
                    //  Request.ADDTEXT(ResponseXML.InnerXml);
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
        //>>HEI.04

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        CLEAR(ResponseXML);
        //HEI.05<<

    end;

    procedure SendGLAccountRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //   ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC upgrade GUNREM01 Replaced Dotnet variable
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        EskerInterfaceManag: Codeunit "ESKER Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        EskerInterfaceSetup.GET;
        EskerInterfaceSetup.TESTFIELD(EskerInterfaceSetup."Esker GLAccount Req Interf");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker GLAccount Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EskerGLAccRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
            //ERROR(ErrorMessage);
        end;
        //<<HEI.04
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            EskerInterfaceManag.ProcessGLAccountRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.NEXT = 0;
        */
        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FINDSET then
            repeat
                if InterfaceEntryHeader.GET(TempInboundEntryHdr."Entry No.") then begin
                    EskerInterfaceManag.ProcessGLAccountRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    // BC UPGRADE ATHUKS01 ESKER<<
                    //ResponseXML := XmlDocument.Create();
                    //ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC UPGRADE ATHUKS01 ESKER>>
                    //BC Upgrade GUNREM01 <<
                    CLEAR(Request);
                    //BC Upgrade GUNREM01 >>
                    //  Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);
                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    //BC Upgrade ATHUKS01 >>
                    //RespIn.ReadText(RespText);
                    RespText := ResponseData(RespIn);
                    //BC Upgrade ATHUKS01 >>
                    Request.AddText(RespText);
                    //BC Upgrade GUNREM01 <<

                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
                end;
            until TempInboundEntryHdr.NEXT = 0;
        TempInboundEntryHdr.DELETEALL;
        //>>HEI.04

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        CLEAR(ResponseXML);
        //HEI.05<<

    end;

    procedure SendBrandRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC upgrade GUNREM01 Replaced Dotnet variable
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        EskerInterfaceManag: Codeunit "ESKER Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        EskerInterfaceSetup.GET;
        EskerInterfaceSetup.TESTFIELD(EskerInterfaceSetup."Esker Brand Req Interf");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker Brand Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EskerBrandRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
            //ERROR(ErrorMessage);
        end;
        //<<HEI.04
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            EskerInterfaceManag.ProcessBrandRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.NEXT = 0;
        */
        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FINDSET then
            repeat
                if InterfaceEntryHeader.GET(TempInboundEntryHdr."Entry No.") then begin
                    EskerInterfaceManag.ProcessBrandRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    // BC UPGRADE ATHUKS01 ESKER<<
                    //ResponseXML := XmlDocument.Create();
                    //ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC UPGRADE ATHUKS01 ESKER>>
                    //BC Upgrade GUNREM01 <<
                    CLEAR(Request);
                    //BC Upgrade GUNREM01 >>
                    //  Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);
                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    //BC Upgrade ATHUKS01 >>
                    //RespIn.ReadText(RespText);
                    RespText := ResponseData(RespIn);
                    //BC Upgrade ATHUKS01 <<
                    Request.AddText(RespText);
                    //BC Upgrade GUNREM01 <<

                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
                end;
            until TempInboundEntryHdr.NEXT = 0;
        TempInboundEntryHdr.DELETEALL;
        //>>HEI.04

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        CLEAR(ResponseXML);
        //HEI.05<<

    end;

    procedure SendVendorRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC upgrade GUNREM01 Replaced Dotnet variable
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        EskerInterfaceManag: Codeunit "ESKER Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        EskerInterfaceSetup.GET;
        EskerInterfaceSetup.TESTFIELD(EskerInterfaceSetup."Esker Vendor Req Interf");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker Vendor Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EskerVendorRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
            //ERROR(ErrorMessage);
        end;
        //<<HEI.04
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            EskerInterfaceManag.ProcessVendorRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.NEXT = 0;
        */
        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FINDSET then
            repeat
                if InterfaceEntryHeader.GET(TempInboundEntryHdr."Entry No.") then begin
                    EskerInterfaceManag.ProcessVendorRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    // BC UPGRADE ATHUKS01 ESKER<<
                    //ResponseXML := XmlDocument.Create();
                    //ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC UPGRADE ATHUKS01 ESKER>>
                    //BC Upgrade GUNREM01 <<
                    CLEAR(Request);
                    //BC Upgrade GUNREM01 >>
                    //  Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);
                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    //BC Upgrade ATHUKS01 >>
                    //RespIn.ReadText(RespText);
                    RespText := ResponseData(RespIn);
                    //BC Upgrade ATHUKS01 <<
                    Request.AddText(RespText);
                    //BC Upgrade GUNREM01 <<

                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
                end;
            until TempInboundEntryHdr.NEXT = 0;
        TempInboundEntryHdr.DELETEALL;
        //>>HEI.04

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        CLEAR(ResponseXML);
        //HEI.05<<

    end;

    procedure SendCurrencyRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC upgrade GUNREM01 Replaced Dotnet variable
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        EskerInterfaceManag: Codeunit "ESKER Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        EskerInterfaceSetup.GET;
        EskerInterfaceSetup.TESTFIELD(EskerInterfaceSetup."Esker Currency Req Interf");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker Currency Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EskerCurrRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
            //ERROR(ErrorMessage);
        end;
        //<<HEI.04
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            EskerInterfaceManag.ProcessCurrencyRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.NEXT = 0;
        */
        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FINDSET then
            repeat
                if InterfaceEntryHeader.GET(TempInboundEntryHdr."Entry No.") then begin
                    EskerInterfaceManag.ProcessCurrencyRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    // BC UPGRADE ATHUKS01 ESKER<<
                    //ResponseXML := XmlDocument.Create();
                    //ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC UPGRADE ATHUKS01 ESKER>>
                    //BC Upgrade GUNREM01 <<
                    CLEAR(Request);
                    //BC Upgrade GUNREM01 >>
                    //  Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);
                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    //BC Upgrade ATHUKS01>>
                    //RespIn.ReadText(RespText);
                    RespText := ResponseData(RespIn);
                    //BC Upgrade ATHUKS01<<
                    Request.AddText(RespText);
                    //BC Upgrade GUNREM01 <<

                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
                end;
            until TempInboundEntryHdr.NEXT = 0;
        TempInboundEntryHdr.DELETEALL;
        //>>HEI.04

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        CLEAR(ResponseXML);
        //HEI.05<<

    end;

    procedure SendTaxCodeRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC upgrade GUNREM01 Replaced Dotnet variable
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        EskerInterfaceManag: Codeunit "ESKER Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        EskerInterfaceSetup.GET;
        EskerInterfaceSetup.TESTFIELD(EskerInterfaceSetup."Esker TaxCode Req Interf");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker TaxCode Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EskerTaxCodRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
            //ERROR(ErrorMessage);
        end;
        //<<HEI.04
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            EskerInterfaceManag.ProcessTaxCodeRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.NEXT = 0;
        */
        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FINDSET then
            repeat
                if InterfaceEntryHeader.GET(TempInboundEntryHdr."Entry No.") then begin
                    EskerInterfaceManag.ProcessTaxCodeRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    // BC UPGRADE ATHUKS01 ESKER<<
                    //ResponseXML := XmlDocument.Create();
                    //ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC UPGRADE ATHUKS01 ESKER>>
                    //BC Upgrade GUNREM01 <<
                    CLEAR(Request);
                    //BC Upgrade GUNREM01 >>
                    //  Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);
                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    //BC Upgrade ATHUKS01 >>
                    //RespIn.ReadText(RespText);
                    RespText := ResponseData(RespIn);
                    //BC Upgrade ATHUKS01 <<
                    Request.AddText(RespText);
                    //BC Upgrade GUNREM01 <<

                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
                end;
            until TempInboundEntryHdr.NEXT = 0;
        TempInboundEntryHdr.DELETEALL;
        //>>HEI.04

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        CLEAR(ResponseXML);
        //HEI.05<<

    end;

    procedure SendPaymTermRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        // ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC upgrade GUNREM01 Replaced Dotnet variable
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        EskerInterfaceManag: Codeunit "ESKER Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        EskerInterfaceSetup.GET;
        EskerInterfaceSetup.TESTFIELD(EskerInterfaceSetup."Esker PaymTerm Req Interf");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker PaymTerm Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EskerPayStsRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
            //ERROR(ErrorMessage);
        end;
        //<<HEI.04
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            EskerInterfaceManag.ProcessPaymTermRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.NEXT = 0;
        */
        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FINDSET then
            repeat
                if InterfaceEntryHeader.GET(TempInboundEntryHdr."Entry No.") then begin
                    EskerInterfaceManag.ProcessPaymTermRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    // BC UPGRADE ATHUKS01 ESKER<<
                    //ResponseXML := XmlDocument.Create();
                    //ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC UPGRADE ATHUKS01 ESKER>>
                    //BC Upgrade GUNREM01 <<
                    CLEAR(Request);
                    //BC Upgrade GUNREM01 >>
                    //  Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);
                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    //BC Upgrade ATHUKS01>>
                    //RespIn.ReadText(RespText);
                    RespText := ResponseData(RespIn);
                    //BC Upgrade ATHUKS01<<
                    Request.AddText(RespText);
                    //BC Upgrade GUNREM01 <<
                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
                end;
            until TempInboundEntryHdr.NEXT = 0;
        TempInboundEntryHdr.DELETEALL;
        //>>HEI.04

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        CLEAR(ResponseXML);
        //HEI.05<<

    end;

    procedure SendBankDetailRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC upgrade GUNREM01 Replaced Dotnet variable
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        EskerInterfaceManag: Codeunit "ESKER Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
        MaximoInterfaceWebServices: Codeunit "Maximo Interface Web Services";
    //BC Upgrade GUNREM01 <<
    begin
        EskerInterfaceSetup.GET;
        EskerInterfaceSetup.TESTFIELD(EskerInterfaceSetup."Esker BankDetail Req Interf");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker BankDetail Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EskerBkDetRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
            //ERROR(ErrorMessage);
        end;
        //<<HEI.04
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            EskerInterfaceManag.ProcessBankDetailRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.NEXT = 0;
        */
        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FINDSET then
            repeat
                if InterfaceEntryHeader.GET(TempInboundEntryHdr."Entry No.") then begin
                    EskerInterfaceManag.ProcessBankDetailRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    // BC UPGRADE ATHUKS01 ESKER<<
                    // ResponseXML := XmlDocument.Create();
                    // ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC UPGRADE ATHUKS01 ESKER>>
                    //BC Upgrade GUNREM01 <<
                    CLEAR(Request);
                    //BC Upgrade GUNREM01 >>
                    //  Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);
                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    //BC Upgrade ATHUKS01 >> 
                    //RespIn.ReadText(RespText);
                    RespText := ResponseData(RespIn);
                    //BC Upgrade ATHUKS01 <<
                    Request.AddText(RespText);
                    //BC Upgrade GUNREM01 <<
                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
                end;
            until TempInboundEntryHdr.NEXT = 0;
        TempInboundEntryHdr.DELETEALL;
        //>>HEI.04

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        CLEAR(ResponseXML);
        //HEI.05<<

    end;

    procedure SendPOHeaderRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC upgrade GUNREM01 Replaced Dotnet variable
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        EskerInterfaceManag: Codeunit "ESKER Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        EskerInterfaceSetup.GET;
        EskerInterfaceSetup.TESTFIELD(EskerInterfaceSetup."Esker POHeader Req Interf");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker POHeader Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EskerPOHdrRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
            //ERROR(ErrorMessage);
        end;
        //<<HEI.04
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            EskerInterfaceManag.ProcessPOHeaderRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.NEXT = 0;
        */
        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FINDSET then
            repeat
                if InterfaceEntryHeader.GET(TempInboundEntryHdr."Entry No.") then begin
                    EskerInterfaceManag.ProcessPOHeaderRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    // BC UPGRADE ATHUKS01 ESKER<<
                    // ResponseXML := XmlDocument.Create();
                    // ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC UPGRADE ATHUKS01 ESKER>>
                    //BC Upgrade GUNREM01 <<
                    CLEAR(Request);
                    //BC Upgrade GUNREM01 >>
                    //  Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);
                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    RespIn.ReadText(RespText);
                    Request.AddText(RespText);
                    //BC Upgrade GUNREM01 <<

                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
                end;
            until TempInboundEntryHdr.NEXT = 0;
        TempInboundEntryHdr.DELETEALL;
        //>>HEI.04

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        CLEAR(ResponseXML);
        //HEI.05<<

    end;

    procedure SendPOLineRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC upgrade GUNREM01 Replaced Dotnet variable
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        EskerInterfaceManag: Codeunit "ESKER Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        EskerInterfaceSetup.GET;
        EskerInterfaceSetup.TESTFIELD(EskerInterfaceSetup."Esker POLine Req Interf");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker POLine Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EskerPOHLineRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
            //ERROR(ErrorMessage);
        end;
        //<<HEI.04
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            EskerInterfaceManag.ProcessPOLineRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.NEXT = 0;
        */
        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FINDSET then
            repeat
                if InterfaceEntryHeader.GET(TempInboundEntryHdr."Entry No.") then begin
                    EskerInterfaceManag.ProcessPOLineRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    // BC UPGRADE ATHUKS01 ESKER<<
                    //ResponseXML := XmlDocument.Create();
                    //ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC UPGRADE ATHUKS01 ESKER>>
                    //BC Upgrade GUNREM01 <<
                    CLEAR(Request);
                    //BC Upgrade GUNREM01 >>
                    //  Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);
                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    RespIn.ReadText(RespText);
                    Request.AddText(RespText);
                    //BC Upgrade GUNREM01 <<

                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
                end;
            until TempInboundEntryHdr.NEXT = 0;
        TempInboundEntryHdr.DELETEALL;
        //>>HEI.04

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        CLEAR(ResponseXML);
        //HEI.05<<

    end;

    procedure SendPaymStatusRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //   ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC upgrade GUNREM01 Replaced Dotnet variable
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        EskerInterfaceManag: Codeunit "ESKER Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        EskerInterfaceSetup.GET;
        EskerInterfaceSetup.TESTFIELD(EskerInterfaceSetup."Esker PaymStatus Req Interf");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker PaymStatus Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EskerPaymStatusRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
            //ERROR(ErrorMessage);
        end;
        //<<HEI.04
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            EskerInterfaceManag.ProcessPaymStatusRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.NEXT = 0;
        */
        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FINDSET then
            repeat
                if InterfaceEntryHeader.GET(TempInboundEntryHdr."Entry No.") then begin
                    EskerInterfaceManag.ProcessPaymStatusRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    // BC UPGRADE ATHUKS01 ESKER<<
                    // ResponseXML := XmlDocument.Create();
                    // ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC UPGRADE ATHUKS01 ESKER>>
                    //BC Upgrade GUNREM01 <<
                    CLEAR(Request);
                    //BC Upgrade GUNREM01 >>
                    //  Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);
                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    //BC Upgrade ATHUKS01>>
                    //RespIn.ReadText(RespText);
                    RespText := ResponseData(RespIn);
                    //BC Upgrade ATHUKS01<<
                    Request.AddText(RespText);
                    //BC Upgrade GUNREM01 <<

                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
                end;
            until TempInboundEntryHdr.NEXT = 0;
        TempInboundEntryHdr.DELETEALL;
        //>>HEI.04

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        CLEAR(ResponseXML);
        //HEI.05<<

    end;

    procedure SendInvCreation(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
    begin

        EskerInterfaceSetup.GET;
        EskerInterfaceSetup.TESTFIELD(EskerInterfaceSetup."Esker InvPosting Interf");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker InvPosting Interf");

        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendInvCreation';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        //HEI.05<<
    end;

    procedure PostInvoice(PurchHeader: Record "Purchase Header");
    var
        PurchPost: Codeunit "Purch.-Post";
        locPurchHeader: Record "Purchase Header";
        ErrorMsg: Text;
    begin
        if locPurchHeader.GET(PurchHeader."Document Type", PurchHeader."No.") then begin
            CLEAR(PurchPost);
            //   PurchPost.SetPostingDate(false, false, 0D);
            SetPostingDate(false, false, 0D);
            if PurchPost.RUN(locPurchHeader) then begin
                if locPurchHeader.MARKEDONLY then
                    locPurchHeader.MARK(false);
            end else begin
                ErrorMsg := STRSUBSTNO(TxtG50002, GETLASTERRORTEXT);
                FctDeletePurchDocs(locPurchHeader);
                ERROR(ErrorMsg);
            end;
        end else
            ERROR(TxtG50001);
    end;
    //BC Upgrade GUNREM01 -Created new fucntion(In NAV this function is there in Purch-Post codeunit. but BC the fucntion got removed) >>
    procedure SetPostingDate(NewReplacePostingDate: Boolean; NewReplaceDocumentDate: Boolean; NewPostingDate: Date)

    begin
        PostingDateExists := TRUE;
        ReplacePostingDate := NewReplacePostingDate;
        ReplaceDocumentDate := NewReplaceDocumentDate;
        PostingDate := NewPostingDate;
    end;
    //BC Upgrade GUNREM01 -Created new fucntion(In NAV this function is there in Purch-Post codeunit. but BC the fucntion got removed) >>

    local procedure FctDeletePurchDocs(PurchHeader2: Record "Purchase Header");
    var
        PurchHeaderToDel: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        ReturnShptHeader: Record "Return Shipment Header";
        PrepmtPurchInvHeader: Record "Purch. Inv. Header";
        PrepmtPurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchCommentLine: Record "Purch. Comment Line";
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        WhseRequest: Record "Warehouse Request";
        PurchPost: Codeunit "Purch.-Post";
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        AllLinesDeleted: Boolean;
    begin
        PurchHeaderToDel.GET(PurchHeader2."Document Type", PurchHeader2."No.");
        if PurchHeaderToDel."RUID FND" <> '' then begin
            PurchHeaderToDel."RUID FND" := '';
            PurchHeaderToDel.MODIFY;
        end;
        COMMIT;
        AllLinesDeleted := true;
        ItemChargeAssgntPurch.RESET;
        ItemChargeAssgntPurch.SETRANGE("Document Type", PurchHeaderToDel."Document Type");
        ItemChargeAssgntPurch.SETRANGE("Document No.", PurchHeaderToDel."No.");
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", PurchHeaderToDel."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeaderToDel."No.");
        PurchLine.LOCKTABLE;
        if PurchLine.FIND('-') then
            repeat
                PurchLine.CALCFIELDS("Qty. Assigned");
                if ((PurchLine."Qty. Assigned" = PurchLine."Quantity Invoiced") and
                    (PurchLine."Qty. Assigned" <> 0)) or
                   (PurchLine.Type <> PurchLine.Type::"Charge (Item)")
                then begin
                    if PurchLine.Type = PurchLine.Type::"Charge (Item)" then begin
                        ItemChargeAssgntPurch.SETRANGE("Document Line No.", PurchLine."Line No.");
                        ItemChargeAssgntPurch.DELETEALL;
                    end;
                    if PurchLine.HASLINKS then
                        PurchLine.DELETELINKS;

                    PurchLine.DELETE;
                end else
                    AllLinesDeleted := false;
                UpdateAssSalesOrder(PurchLine);
            until PurchLine.NEXT = 0;

        if AllLinesDeleted then begin
            //BC Upgrade GUNREM01 -DIT Fucntion >>
            // PurchPost.DeleteHeader(
            //   PurchHeaderToDel, PurchRcptHeader, PurchInvHeader, PurchCrMemoHeader,
            //   ReturnShptHeader, PrepmtPurchInvHeader, PrepmtPurchCrMemoHeader);
            //BC Upgrade GUNREM01 -DIT Fucntion <<
            ReservePurchLine.DeleteInvoiceSpecFromHeader(PurchHeaderToDel);

            PurchCommentLine.SETRANGE("Document Type", PurchHeaderToDel."Document Type");
            PurchCommentLine.SETRANGE("No.", PurchHeaderToDel."No.");
            PurchCommentLine.DELETEALL;

            WhseRequest.SETRANGE("Source Type", DATABASE::"Purchase Line");
            WhseRequest.SETRANGE("Source Subtype", PurchHeaderToDel."Document Type");
            WhseRequest.SETRANGE("Source No.", PurchHeaderToDel."No.");
            WhseRequest.DELETEALL(true);

            if PurchHeaderToDel.HASLINKS then
                PurchHeaderToDel.DELETELINKS;

            PurchHeaderToDel.DELETE;
        end;
        COMMIT;
    end;

    local procedure UpdateAssSalesOrder(PurchLine: Record "Purchase Line");
    var
        SalesLine: Record "Sales Line";
    begin
        if not PurchLine."Special Order" then
            exit;
        SalesLine.RESET;
        SalesLine.SETRANGE("Special Order Purchase No.", PurchLine."Document No.");
        SalesLine.SETRANGE("Special Order Purch. Line No.", PurchLine."Line No.");
        SalesLine.SETRANGE("Purchasing Code", PurchLine."Purchasing Code");
        if SalesLine.FINDFIRST then begin
            SalesLine."Special Order Purchase No." := '';
            SalesLine."Special Order Purch. Line No." := 0;
            SalesLine.MODIFY;
        end;
    end;

    procedure SendWHTRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC upgrade GUNREM01 Replaced Dotnet variable
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        EskerInterfaceManag: Codeunit "ESKER Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        //>>HEI.01
        EskerInterfaceSetup.GET;
        EskerInterfaceSetup.TESTFIELD(EskerInterfaceSetup."Esker WHT Req Interf");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker WHT Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EskerWHTRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
            //ERROR(ErrorMessage);
        end;
        //<<HEI.04
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            EskerInterfaceManag.ProcessWHTRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.NEXT = 0;
        //<<HEI.01
        */
        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FINDSET then
            repeat
                if InterfaceEntryHeader.GET(TempInboundEntryHdr."Entry No.") then begin
                    EskerInterfaceManag.ProcessWHTRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    // BC UPGRADE ATHUKS01 ESKER<<
                    // ResponseXML := XmlDocument.Create();
                    // ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC UPGRADE ATHUKS01 ESKER>>
                    //BC Upgrade GUNREM01 <<
                    CLEAR(Request);
                    //BC Upgrade GUNREM01 >>
                    //  Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);
                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    //BC Upgrade ATHUKS01 >>
                    //RespIn.ReadText(RespText);
                    RespText := ResponseData(RespIn);
                    //BC Upgrade ATHUKS01<<
                    Request.AddText(RespText);
                    //BC Upgrade GUNREM01 <<
                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
                end;
            until TempInboundEntryHdr.NEXT = 0;
        TempInboundEntryHdr.DELETEALL;
        //>>HEI.04

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        CLEAR(ResponseXML);
        //HEI.05<<

    end;

    procedure SendLCRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC upgrade GUNREM01 Replaced Dotnet variable
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        EskerInterfaceManag: Codeunit "ESKER Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        //>>HEI.02
        EskerInterfaceSetup.GET;
        EskerInterfaceSetup.TESTFIELD(EskerInterfaceSetup."Esker LC Req Interf");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker LC Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EskerLCRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
            //ERROR(ErrorMessage);
        end;
        //<<HEI.04
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            EskerInterfaceManag.ProcessLCRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.NEXT = 0;
        //<<HEI.02
        */
        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FINDSET then
            repeat
                if InterfaceEntryHeader.GET(TempInboundEntryHdr."Entry No.") then begin
                    EskerInterfaceManag.ProcessLCRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    // BC UPGRADE ATHUKS01 ESKER>>
                    // ResponseXML := XmlDocument.Create();
                    //ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC UPGRADE ATHUKS01 ESKER<<
                    //BC Upgrade GUNREM01 <<
                    CLEAR(Request);
                    //BC Upgrade GUNREM01 >>
                    //  Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);
                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    RespIn.ReadText(RespText);
                    Request.AddText(RespText);
                    //BC Upgrade GUNREM01 <<

                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
                end;
            until TempInboundEntryHdr.NEXT = 0;
        TempInboundEntryHdr.DELETEALL;
        //>>HEI.04

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        CLEAR(ResponseXML);
        //HEI.05<<

    end;

    procedure SendVendorPostingGrpRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        // ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC upgrade GUNREM01 Replaced Dotnet variable
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        EskerInterfaceManag: Codeunit "ESKER Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        //HEI.03 >>
        EskerInterfaceSetup.GET;
        EskerInterfaceSetup.TESTFIELD(EskerInterfaceSetup."Esker VendorPostGrp Req Interf");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker VendorPostGrp Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'EskerVendorPstGrpRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
            //ERROR(ErrorMessage);
        end;
        //<<HEI.04
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            EskerInterfaceManag.ProcessVendorPstGrpRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.NEXT = 0;
        //HEI.03 <<
        */
        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.FINDSET then
            repeat
                if InterfaceEntryHeader.GET(TempInboundEntryHdr."Entry No.") then begin
                    EskerInterfaceManag.ProcessVendorPstGrpRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    // BC UPGRADE ATHUKS01 ESKER<<
                    //ResponseXML := XmlDocument.Create();
                    //ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC UPGRADE ATHUKS01 ESKER>>
                    //BC Upgrade GUNREM01 <<
                    CLEAR(Request);
                    //BC Upgrade GUNREM01 >>
                    //  Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);
                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    //BC Upgrade ATHUKS01>>
                    //RespIn.ReadText(RespText);
                    RespText := ResponseData(RespIn);
                    //BC Upgrade ATHUKS01<<
                    Request.AddText(RespText);
                    //BC Upgrade GUNREM01 <<
                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
                end;
            until TempInboundEntryHdr.NEXT = 0;
        TempInboundEntryHdr.DELETEALL;
        //>>HEI.04

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        CLEAR(InputStream);
        CLEAR(ResponseXML);
        //HEI.05<<

    end;

    //BC UPGRADE ATHUSK01>>
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
    //BC UPGRADE ATHUSK01>>

    var
        //BC Upgrade GUNREM01 >>
        PostingDate: Date;
        PostingDateExists: Boolean;
        ReplacePostingDate: Boolean;
        ReplaceDocumentDate: Boolean;
    //BC Upgrade GUNREM01 <<
}

