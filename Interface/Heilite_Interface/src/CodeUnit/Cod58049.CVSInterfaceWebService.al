codeunit 58049 "CVS Interface Web Service"
{
    //BC Upgrade GUNREM01 - Old ID 50055

    // HEI.01 CHG2095187 IBM SAXENA03 11.03.2021
    //   # Code written for Paraller Request
    //   # Peace of code commented and added new code to replace FINDLAST with Entry No. in below Function
    //     SendCurrencyRequest()
    //     SendCurrencyExchRateRequest()
    //     SendSalesPersonPurchaserRequest()
    //     SendCustomerRequest()
    //     SendCustomerPriceRequest()
    //     SendSalesmanCustomerRequest()
    //     SendProductRequest()
    //     SendSalesPriceRequest()
    //     SendBrandRequest()
    //     SendRouteRequest()
    //     SendWarehouseProductRequest()

    //BC Upgrade GUNREM01  Changed the Dotnet variables to xml document and changed the code using XML Document

    trigger OnRun();
    begin
    end;

    var
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';
        InterfaceEntryHeader: Record "Interface Entry Header INT";

    procedure SendCurrencyRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //BC Upgrade GUNREM01 >>
        //  ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC Upgrade GUNREM01 - Replaced DotNet XmlDocument with XmlDocument variable due to deprecation of DotNet in BC
        //BC Upgrade GUNREM01 <<
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        CashVanSalesInterfaceManag: Codeunit "Cash Van Sales Interface Manag";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        CashVanSalesInterfaceSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("CVS Currency Request Interface");
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Currency Request Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'CVSCurrencyRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;


        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
        end;
        //<<HEI.01
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            CashVanSalesInterfaceManag.ProcessCurrencyRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
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
                    CashVanSalesInterfaceManag.ProcessCurrencyRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    ResponseXML := XmlDocument.Create();
                    ResponseXML.Add(InputStream);
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
        //>>HEI.01

    end;

    procedure SendCurrencyExchRateRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        CashVanSalesInterfaceManag: Codeunit "Cash Van Sales Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        // ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC Upgrade GUNREM01 - Replaced DotNet XmlDocument with XmlDocument variable due to deprecation of DotNet in BC
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        CashVanSalesInterfaceSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("CVS Curr Exch. Rate Req Interf");
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Curr Exch. Rate Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'CVSCurrencyExchRateRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
        end;
        //<<HEI.01
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            CashVanSalesInterfaceManag.ProcessCurrencyExchRateRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
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
                    CashVanSalesInterfaceManag.ProcessCurrencyExchRateRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    ResponseXML := XmlDocument.Create();
                    ResponseXML.Add(InputStream);
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
        //>>HEI.01

    end;

    procedure SendSalesPersonPurchaserRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC upgrade GUNREM01 Replaced DotNet XmlDocument with XmlDocument variable due to deprecation of DotNet in BC 
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CashVanSalesInterfaceManag: Codeunit "Cash Van Sales Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        CashVanSalesInterfaceSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("CVS SalesP/Purch. Req. Interf");
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS SalesP/Purch. Req. Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'CVSSalesPersonPurchaserRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
        end;
        //<<HEI.01
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            CashVanSalesInterfaceManag.ProcessSalesPersonRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
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
                    CashVanSalesInterfaceManag.ProcessSalesPersonRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    ResponseXML := XmlDocument.Create();
                    ResponseXML.Add(InputStream);
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
        //>>HEI.01

    end;

    procedure SendCustomerRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        // ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC Upgrade GUNREM01 - Replaced DotNet XmlDocument with XmlDocument variable due to deprecation of DotNet in BC

        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CashVanSalesInterfaceManag: Codeunit "Cash Van Sales Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        CashVanSalesInterfaceSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("CVS Customer Request Interface");
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Customer Request Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'CVSCustomerRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
        end;
        //<<HEI.01
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            CashVanSalesInterfaceManag.ProcessCustomerRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
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
                    CashVanSalesInterfaceManag.ProcessCustomerRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    ResponseXML := XmlDocument.Create();
                    ResponseXML.Add(InputStream);
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


        //>>HEI.01

    end;

    procedure SendCustomerPriceRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        // ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC Upgrade GUNREM01 - Replaced DotNet XmlDocument with XmlDocument variable due to deprecation of DotNet in BC

        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CashVanSalesInterfaceManag: Codeunit "Cash Van Sales Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        CashVanSalesInterfaceSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("CVS Cust Price List Req Interf");
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Cust Price List Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'CVSCustomerPriceRequest';
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
        //<<HEI.01
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            CashVanSalesInterfaceManag.ProcessCustomerPriceListRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
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
                    CashVanSalesInterfaceManag.ProcessCustomerPriceListRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    ResponseXML := XmlDocument.Create();
                    ResponseXML.Add(InputStream);
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
        //>>HEI.01

    end;

    procedure SendSalesmanCustomerRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //   ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC Upgrade GUNREM01 - Replaced DotNet XmlDocument with XmlDocument variable due to deprecation of DotNet in BC

        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CashVanSalesInterfaceManag: Codeunit "Cash Van Sales Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        CashVanSalesInterfaceSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("CVS Salesman Cust Req Interf");
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Salesman Cust Req Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'CVSSalesmanCustomerRequest';
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
        //<<HEI.01
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            CashVanSalesInterfaceManag.ProcessSalesmanCustomerRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
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
                    CashVanSalesInterfaceManag.ProcessSalesmanCustomerRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    ResponseXML := XmlDocument.Create();
                    ResponseXML.Add(InputStream);
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
        //>>HEI.01

    end;

    procedure SendProductRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC Upgrade GUNREM01 - Replaced DotNet XmlDocument with XmlDocument variable due to deprecation of DotNet in BC

        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CashVanSalesInterfaceManag: Codeunit "Cash Van Sales Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        CashVanSalesInterfaceSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("CVS Item Request Interface");
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Item Request Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'CVSItemRequest';
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
        //<<HEI.01
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            CashVanSalesInterfaceManag.ProcessItemRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
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
                    CashVanSalesInterfaceManag.ProcessItemRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    ResponseXML := XmlDocument.Create();
                    ResponseXML.Add(InputStream);
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
        //>>HEI.01

    end;

    procedure SendSalesPriceRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC Upgrade GUNREM01 - Replaced DotNet XmlDocument with XmlDocument variable due to deprecation of DotNet in BC
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CashVanSalesInterfaceManag: Codeunit "Cash Van Sales Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        CashVanSalesInterfaceSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("CVS Sales Price Request Interf");
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Sales Price Request Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'CVSSalesPriceRequest';
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
        //<<HEI.01
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            CashVanSalesInterfaceManag.ProcessProductPriceListRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
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
                    CashVanSalesInterfaceManag.ProcessProductPriceListRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);

                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    ResponseXML := XmlDocument.Create();
                    ResponseXML.Add(InputStream);
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
        //>>HEI.01

    end;

    procedure SendBrandRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC Upgrade GUNREM01 - Replaced DotNet XmlDocument with XmlDocument variable due to deprecation of DotNet in BC

        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CashVanSalesInterfaceManag: Codeunit "Cash Van Sales Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        CashVanSalesInterfaceSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("CVS Brand Request Interface");
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Brand Request Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'CVSBrandRequest';
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
        //<<HEI.01
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            CashVanSalesInterfaceManag.ProcessBrandRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
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
                    CashVanSalesInterfaceManag.ProcessBrandRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    ResponseXML := XmlDocument.Create();
                    ResponseXML.Add(InputStream);
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
        //>>HEI.01

    end;

    procedure SendRouteRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        // ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC Upgrade GUNREM01 - Replaced DotNet XmlDocument with XmlDocument variable due to deprecation of DotNet in BC

        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CashVanSalesInterfaceManag: Codeunit "Cash Van Sales Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin

        CashVanSalesInterfaceSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("CVS Route Request Interface");
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Route Request Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'CVSRouteRequest';
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
        //<<HEI.01
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            CashVanSalesInterfaceManag.ProcessRouteRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
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
                    CashVanSalesInterfaceManag.ProcessRouteRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    ResponseXML := XmlDocument.Create();
                    ResponseXML.Add(InputStream);
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
        //>>HEI.01

    end;

    procedure SendWarehouseProductRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //   ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC Upgrade GUNREM01 - Replaced DotNet XmlDocument with XmlDocument variable due to deprecation of DotNet in BC

        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CashVanSalesInterfaceManag: Codeunit "Cash Van Sales Interface Manag";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        //BC Upgrade GUNREM01 >>
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    //BC Upgrade GUNREM01 <<
    begin
        CashVanSalesInterfaceSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("CVS WarehouseProduct Req Inter");
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS WarehouseProduct Req Inter");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'CVSWarehouseProductRequest';
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
        //<<HEI.01
        /*
        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FINDSET THEN
          REPEAT
            CashVanSalesInterfaceManag.ProcessWarehouseProductRequest(InterfaceEntryHeader,InterfaceEntryHeaderOut);
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
                    CashVanSalesInterfaceManag.ProcessWarehouseProductRequest(InterfaceEntryHeader, InterfaceEntryHeaderOut);
                    CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);

                    DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.GET(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CALCFIELDS("File Content");
                    DataExch2."File Content".CREATEINSTREAM(InputStream);
                    //BC Upgrade GUNREM01 >>
                    // ResponseXML := ResponseXML.XmlDocument;
                    // ResponseXML.Load(InputStream);
                    ResponseXML := XmlDocument.Create();
                    ResponseXML.Add(InputStream);
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
        //>>HEI.01

    end;

    procedure SendTransferOrderRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
    begin
        CashVanSalesInterfaceSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("CVS Transfer Order Interf");
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Transfer Order Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'CVSTransferOrderRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
    end;

    procedure SendSalesOrderRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
    begin
        CashVanSalesInterfaceSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("CVS Sales Orders Interface");
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Sales Orders Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'CVSSalesOrderRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
    end;

    procedure SendCashReceiptJnlRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
    begin
        CashVanSalesInterfaceSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("CVS Cash Receipt Interf");
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Cash Receipt Interf");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'CVSCashReceiptJnlRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
    end;
}

