codeunit 58034 "HeiFLOW API WS"
{
    // version HEI.05

    // HEI.01 CHG2132748 IBM SAXENA03 09.11.2021
    //   # HeiLite Base integration with HeiFlow  Master Data
    //   # Created a new CodeUnit as HeiFLOW API WebService CodeUnit
    //   # This Codeunit will be exposed from WebService and Export/Import Customer and Vendor Table records.
    // 
    // HEI.02 CHG2138427 IBM SAXENA03 06.01.2022
    //   # Added new XML attribute IsActive
    // HEI.03 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables
    // HEI.05 CHG2220628 IBM POENAB02 26.09.2023 HEILITE PROD server upgrade activities
    //   # Modified functions CreateExcelBook, MasterExpotToExcel
    //   # Due to PROD server upgrade this functionality is being commented.
    //   # Export to Excel functionality was not used for HeiFlow go lives, as the integration is being done using web services.

    // BC Upgrade POENAB02: Original (HeiLite) codeunit id 50202

    trigger OnRun();
    begin
    end;

    var
        //BC Upgrade POENAB02 >>
        //RequestXml: Record TempBlob temporary;
        RequestXml: Codeunit "Temp Blob";
        //BC Upgrade POENAB02 <<
        MessageOutStream: OutStream;
        MessageInStream: InStream;
        //BC Upgrade POENAB02 >>
        //RequestXmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        RequestXmlDocument: XmlDocument;
        //BC Upgrade POENAB02 <<
        APIInterfaceLog2: Record "API Interface Log2 INT";
        //BC Upgrade POENAB02 >>
        //XmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        XmlNode: XmlNode;
        //BC Upgrade POENAB02 <<
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        MissingNodeErr: Label '%1 node missing from XML';
        TextMissingErr: Label 'Text missing for node %1 in XML';
        InvaildValueErr: Label 'Invalid value for %1';
        ErrorOutStream: OutStream;
        ErrorMsg: Label 'Error Code: %1, Error Text: %2, Call Stack Trace: %3';
        //BC Upgrade POENAB02 >>
        /*
        ResponsetXml: Record TempBlob temporary;
        ResponseXmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        */
        ResponsetXml: Codeunit "Temp Blob";
        ResponseXmlDocument: XmlDocument;
        //BC Upgrade POENAB02 <<
        MessageResponseOutStream: OutStream;
        MessageResponseInStream: InStream;
        MessageRequestOutStream: OutStream;
        LastErrorMsg: Text;
        HeiFlowInterfaceSetup: Record "HeiFLOW Interface Setup INT";
        CompanyInfo: Record "Company Information";
        SetupDisableErr: Label 'HeiFLOW Interface is not Enable';
        TempExcelBuffer: Record "Excel Buffer" temporary;
    // BC Upgrade POENAB02 >>
    // below variables are commented, as they are not used
    /* 
    MessageRequestInStream: InStream;
    JobQueueEntry: Record "Job Queue Entry";
    JobQueueProcessMsg: Label 'Process API Entry No. %1';
    LastPostingErrorMsg: Text;
    LastErrorOutStream: OutStream;
    NotExistingOrderErr: Label 'Order ID % was not sent from %2.';
    grec_GenInterfaceSetup: Record "General Interface Setup INT";
    CustomerIsActive: Boolean;
    VendorIsActive: Boolean;
    RecordCount: Integer;
    FileMgt: Codeunit "File Management";
    ClientFileName: Text;
    ServerFileName: Text;
    ExportedFilePath: Text;
    PrintExcel: Boolean; 
    */
    // BC Upgrade POENAB02 <<


    procedure ProcessMessage(var Message: BigText);
    var
        MsgId: Text;
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        //BC Upgrade POENAB02 >>
        /* 
        DotNetEncoding: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Text.Encoding";
        StreamReader: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.StreamReader";
        DotNetStream: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.Stream";
        TempBLOB: Record TempBlob; 
        */
        //BC Upgrade POENAB02 <<
        //BC Upgrade KAPOOV01 >>
        RequestInStream: InStream;
        RequestOutStream: OutStream;
        ResponseInStream: InStream;
        ResponseOutStream: OutStream;
    //BC Upgrade KAPOOV01 <<
    begin
        HeiFlowInterfaceSetup.Get();
        if not HeiFlowInterfaceSetup."Interface Enable/Disable" then
            Error(SetupDisableErr);

        CompanyInfo.Get();
        //BC Upgrade POENAB02 >>
        //RequestXml.Blob.CREATEOUTSTREAM(MessageOutStream);
        RequestXml.CreateOutStream(MessageOutStream);
        //BC Upgrade POENAB02 <<
        Message.Write(MessageOutStream);
        //BC Upgrade POENAB02 >>
        //RequestXml.Blob.CREATEINSTREAM(MessageInStream);
        RequestXml.CreateInStream(MessageInStream);
        //BC Upgrade POENAB02 <<
        if TryLoadXML(Message) then begin
            APIInterfaceLog2.INIT();
            if CheckForMandatoryProcessingNodes() then begin
                APIInterfaceLog2.Insert();
                //BC Upgrade KAPOOV01 >>
                RequestXml.CreateInStream(RequestInStream);
                APIInterfaceLog2."Request File".CreateOutStream(RequestOutStream);
                CopyStream(RequestOutStream, RequestInStream);
                APIInterfaceLog2.MODIFY;
                //BC Upgrade KAPOOV01 <<

                if APIInterfaceLog2."Call Type" = APIInterfaceLog2."Call Type"::Synchronous then begin
                    Commit();
                    //IF CODEUNIT.RUN(APIInterfaceLog2."Processing Codeunit",APIInterfaceLog2) THEN BEGIN
                    if ProcessMasterData() then begin
                        // Processing succeed, Success response to be created and sent
                        APIInterfaceLog2.Find();
                        //HEI.04>>
                        APIInterfaceLog2.Validate(Status, APIInterfaceLog2.Status::Processed);
                        //HEI.03<<
                        //BC Upgrade POENAB02 >>
                        //APIInterfaceLog2."Response File" := ResponsetXml.Blob;
                        // ResponsetXml.CreateOutStream(MessageResponseOutStream);
                        // ResponseXmlDocument.WriteTo(MessageResponseOutStream);
                        // APIInterfaceLog2."Response File".CreateOutStream(MessageResponseOutStream);
                        // MessageResponseOutStream.Write(MessageResponseOutStream);
                        //BC Upgrade POENAB02 <<
                        //BC Upgrade KAPOOV01 >>
                        ResponsetXml.CreateInStream(ResponseInStream);
                        APIInterfaceLog2."Response File".CreateOutStream(ResponseOutStream);
                        CopyStream(ResponseOutStream, ResponseInStream);
                        //APIInterfaceLog2."Response File" := ResponsetXml.Blob;
                        //BC Upgrade KAPOOV01 <<
                        APIInterfaceLog2."Response Sync. Date/Time" := CurrentDateTime;
                        APIInterfaceLog2.Modify();

                        //HEI.02>>
                        Commit();
                        //HEI.02<<
                    end else begin
                        // Processing failed, to be logged, error response to be sent
                        APIInterfaceLog2.Find();
                        LastErrorMsg := StrSubstNo(ErrorMsg, GetLastErrorCode, GetLastErrorText, GetLastErrorCallStack);
                        //HEI.04>>
                        // BC Upgrade POENAB02 >>
                        /*
                        if APIInterfaceLog2.Entity = 'CUSTOMER' then
                            CreateResponseforCustomer(APIInterfaceLog2."Message ID", false, LastErrorMsg)
                        else if APIInterfaceLog2.Entity = 'VENDOR' then
                            CreateResponseforVendor(APIInterfaceLog2."Message ID", false, LastErrorMsg)
                        else
                            //HEI.04<<
                            CreateResponse(APIInterfaceLog2."Message ID", false, LastErrorMsg);
                        */
                        case APIInterfaceLog2.Entity of
                            'CUSTOMER':
                                CreateResponseforCustomer(APIInterfaceLog2."Message ID", false, LastErrorMsg);
                            'VENDOR':
                                CreateResponseforVendor(APIInterfaceLog2."Message ID", false, LastErrorMsg);
                            else
                                CreateResponse(APIInterfaceLog2."Message ID", false, LastErrorMsg);
                        end;
                        // BC Upgrade POENAB02 <<
                        //HEI.03>>
                        //APIInterfaceLog2.Status := APIInterfaceLog2.Status::Error;
                        APIInterfaceLog2.Validate(Status, APIInterfaceLog2.Status::Error);
                        //HEI.03<<
                        APIInterfaceLog2."Error Message".CreateOutStream(ErrorOutStream);
                        ErrorOutStream.WriteText(LastErrorMsg);
                        //BC Upgrade POENAB02 >>
                        //APIInterfaceLog2."Response File" := ResponsetXml.Blob;
                        // ResponsetXml.CreateOutStream(MessageResponseOutStream);
                        // ResponseXmlDocument.WriteTo(MessageResponseOutStream);
                        // APIInterfaceLog2."Response File".CreateOutStream(MessageResponseOutStream);
                        // MessageResponseOutStream.Write(MessageResponseOutStream);
                        //BC Upgrade POENAB02 <<
                        //BC Upgrade KAPOOV01 >>
                        //APIInterfaceLog2."Response File" := ResponsetXml.Blob; 
                        ResponsetXml.CreateInStream(ResponseInStream);
                        APIInterfaceLog2."Response File".CreateOutStream(ResponseOutStream);
                        CopyStream(ResponseOutStream, ResponseInStream);
                        //BC Upgrade KAPOOV01 <<
                        APIInterfaceLog2."Response Sync. Date/Time" := CurrentDateTime;
                        APIInterfaceLog2.Modify();
                    end;
                end;
            end else begin
                // Mandatory processing nodes missing in XML file, nothing to be logged, error response to be sent
                //BC Upgrade POENAB02 >>
                /*
                XmlNode := RequestXmlDocument.SelectSingleNode('/msg/msgId');  // Optional
                if not ISNULL(XmlNode) then
                    MsgId := XmlNode.InnerText;
                */
                if RequestXmlDocument.SelectSingleNode('/msg/msgId', XmlNode) then
                    if XmlNode.AsXmlElement().InnerText() <> '' then
                        MsgId := XmlNode.AsXmlElement().InnerText();
                //BC Upgrade POENAB02 <<
                CreateResponse(MsgId, false, StrSubstNo(ErrorMsg, GetLastErrorCode, GetLastErrorText, GetLastErrorCallStack))
            end;
        end else begin
            // Wrong XML file, nothing to be logged, error response to be sent
            //BC Upgrade POENAB02 >>
            /*
            XmlNode := RequestXmlDocument.SelectSingleNode('/msg/msgId');  // Optional
            if not ISNULL(XmlNode) then
                MsgId := XmlNode.InnerText;
            */
            if RequestXmlDocument.SelectSingleNode('/msg/msgId', XmlNode) then
                if XmlNode.AsXmlElement().InnerText() <> '' then
                    MsgId := XmlNode.AsXmlElement().InnerText();
            //BC Upgrade POENAB02 <<
            CreateResponse(MsgId, false, StrSubstNo(ErrorMsg, GetLastErrorCode, GetLastErrorText, GetLastErrorCallStack))
        end;

        /*
        ResponsetXml.Blob.CREATEINSTREAM(MessageResponseInStream);
        CLEAR(Message);
        Message.READ(MessageResponseInStream);
        */

        //Unicode>>
        Clear(Message);
        //BC Upgrade POENAB02 >>
        /*
        ResponsetXml.Blob.CREATEINSTREAM(MessageResponseInStream);
        DotNetStream := MessageResponseInStream;
        StreamReader := StreamReader.StreamReader(DotNetStream, true);
        Message.ADDTEXT(StreamReader.ReadToEnd());
        */
        ResponsetXml.CreateInStream(MessageResponseInStream, TextEncoding::UTF8);
        Message.Read(MessageResponseInStream);
        //BC Upgrade POENAB02 <<
        //Unicode<<


        if APIInterfaceLog2.Entity = 'CUSTOMER' then begin
            HeiFlowInterfaceSetup."Last Modified Customer" := GetLastModifiedDateCustomerLocal();
            HeiFlowInterfaceSetup.Modify(false);
        end;
        if APIInterfaceLog2.Entity = 'VENDOR' then begin
            HeiFlowInterfaceSetup."Last Modified Vendor" := GetLastModifiedDateVendorLocal();
            HeiFlowInterfaceSetup.Modify(false);
        end;

        //AS

        //HEI.03>>
        Clear(RequestXml);
        Clear(MessageOutStream);
        Clear(MessageInStream);
        Clear(RequestXmlDocument);
        Clear(XmlNode);
        Clear(ErrorOutStream);
        Clear(ResponseXmlDocument);
        Clear(MessageResponseInStream);
        //HEI.03<<

    end;

    [TryFunction]
    local procedure TryLoadXML(Message: BigText);
    var
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        ParseXmlErr: Label 'Failed to parse XML';

    begin
        // NOTE: NO WRITE TRANSACTION IN THIS FUNCTION
        //BC Upgrade POENAB02 >>
        /*
        RequestXmlDocument := RequestXmlDocument.XmlDocument;
        RequestXmlDocument.Load(MessageInStream);
        */
        // RequestXmlDocument := XmlDocument.Create();
        // XmlDocument.ReadFrom(MessageInStream, RequestXmlDocument);
        //BC Upgrade POENAB02 <<
        //BC Upgrade KAPOOV01 >>
        RequestXmlDocument := XmlDocument.Create();
        TempBlob.CreateOutStream(MessageOutStream);
        Message.Write(MessageOutStream);
        TempBlob.CreateInStream(MessageInStream);
        if not XmlDocument.ReadFrom(MessageInStream, RequestXmlDocument) then
            Error(ParseXmlErr);
        //BC Upgrade KAPOOV01 <<
    end;

    [TryFunction]
    local procedure CheckForMandatoryProcessingNodes();
    var
        APIInterfaceSetup2: Record "API Interface Setup2 INT";
        InterfaceSetup: Record "Interface Setup INT";
        RequestInStream: InStream;
        RequestOutStream: OutStream;
    begin
        // NOTE: NO WRITE TRANSACTION IN THIS FUNCTION
        GetNodeByXPath('/msg/sourceSystemIdentifier', 'sourceSystemIdentifier');
        if not SourceSystemIdentifierAPI.Get(XmlNode.AsXmlElement().InnerText()) then
            Error(InvaildValueErr, 'sourceSystemIdentifier');
        APIInterfaceLog2.Validate("Source System Identifier", SourceSystemIdentifierAPI.Code);

        GetNodeByXPath('/msg/entity', 'entity');
        //HEI.04>>
        //IF NOT (UPPERCASE(XmlNode.InnerText) IN ['SALES']) THEN
        // BC Upgrade POENAB02 >>
        /*
        if not (UPPERCASE(XmlNode.InnerText) in ['CUSTOMER', 'VENDOR']) then
            ERROR(InvaildValueErr, 'entity');
        APIInterfaceLog2.Entity := UPPERCASE(XmlNode.InnerText);
        */
        if not (UpperCase(XmlNode.AsXmlElement().InnerText()) in ['CUSTOMER', 'VENDOR']) then
            Error(InvaildValueErr, 'entity');
        APIInterfaceLog2.Entity := COPYSTR(UpperCase(XmlNode.AsXmlElement().InnerText()), 1, MaxStrLen(APIInterfaceLog2.Entity));
        // BC Upgrade POENAB02 <<

        GetNodeByXPath('/msg/operation', 'operation');
        //HEI.04>>
        //IF NOT (UPPERCASE(XmlNode.InnerText) IN ['CREATE','UPDATE','DELETE']) THEN
        // BC Upgrade POENAB02 >>
        //if not (UPPERCASE(XmlNode.InnerText) in ['CREATE', 'UPDATE', 'DELETE', 'REQINFO']) then
        if not (UpperCase(XmlNode.AsXmlElement().InnerText()) in ['CREATE', 'UPDATE', 'DELETE', 'REQINFO']) then
            // BC Upgrade POENAB02 <<
            //HEI.04<<
            Error(InvaildValueErr, 'operation');
        // BC Upgrade POENAB02 >>
        // APIInterfaceLog2.Operation := UPPERCASE(XmlNode.InnerText);
        APIInterfaceLog2.Operation := CopyStr(UpperCase(XmlNode.AsXmlElement().InnerText()), 1, MaxStrLen(APIInterfaceLog2.Operation));
        // BC Upgrade POENAB02 <<

        //GetNodeByXPath('/msg/payload','payload'); //AS

        // BC Upgrade POENAB02 >>
        /*
        XmlNode := RequestXmlDocument.SelectSingleNode('/msg/msgId');  // Optional
        if not ISNULL(XmlNode) then
            if XmlNode.InnerText <> '' then
                APIInterfaceLog2."Message ID" := XmlNode.InnerText;

        XmlNode := RequestXmlDocument.SelectSingleNode('/msg/payloadFormat');  // Optional
        if not ISNULL(XmlNode) then
            if XmlNode.InnerText <> '' then
                if EVALUATE(APIInterfaceLog2."File Format", XmlNode.InnerText) then;

        XmlNode := RequestXmlDocument.SelectSingleNode('/msg/msgTimestamp');  // Optional
        if not ISNULL(XmlNode) then
            if XmlNode.InnerText <> '' then
                if EVALUATE(APIInterfaceLog2."Source Request Timestamp", XmlNode.InnerText, 9) then;
        */
        if RequestXmlDocument.SelectSingleNode('/msg/msgId', XmlNode) then
            if XmlNode.AsXmlElement().InnerText() <> '' then
                APIInterfaceLog2."Message ID" := COPYSTR(XmlNode.AsXmlElement().InnerText(), 1, MAXSTRLEN(APIInterfaceLog2."Message ID"));

        if RequestXmlDocument.SelectSingleNode('/msg/payloadFormat', XmlNode) then
            if XmlNode.AsXmlElement().InnerText() <> '' then
                if EVALUATE(APIInterfaceLog2."File Format", XmlNode.AsXmlElement().InnerText()) then;

        if RequestXmlDocument.SelectSingleNode('/msg/msgTimestamp', XmlNode) then
            if XmlNode.AsXmlElement().InnerText() <> '' then
                if EVALUATE(APIInterfaceLog2."Source Request Timestamp", XmlNode.AsXmlElement().InnerText(), 9) then;
        // BC Upgrade POENAB02 <<

        APIInterfaceLog2."Request Sync. Date/Time" := CurrentDateTime;

        //BC Upgrade POENAB02 >>
        //APIInterfaceLog2."Request File" := RequestXml.Blob;
        // RequestXml.CreateOutStream(MessageRequestOutStream);
        // RequestXmlDocument.WriteTo(MessageRequestOutStream);
        // APIInterfaceLog2."Request File".CreateOutStream(MessageRequestOutStream);
        // MessageRequestOutStream.Write(MessageRequestOutStream);
        //BC Upgrade POENAB02 <<
        //BC Upgrade KAPOOV01 >>
        RequestXml.CreateInStream(RequestInStream);
        APIInterfaceLog2."Request File".CreateOutStream(RequestOutStream);
        CopyStream(RequestOutStream, RequestInStream);

        //BC Upgrade KAPOOV01 <<

        case APIInterfaceLog2.Entity of
            'CUSTOMER':
                begin
                    //APIInterfaceSetup2.GET;
                    HeiFlowInterfaceSetup.Get();
                    //APIInterfaceSetup2.TESTFIELD("SO/SRO Interface Request");
                    HeiFlowInterfaceSetup.TestField("HeiFLOW Customer");
                    //APIInterfaceLog2."Interface Code" := APIInterfaceSetup2."SO/SRO Interface Request";
                    APIInterfaceLog2."Interface Code" := HeiFlowInterfaceSetup."HeiFLOW Customer";
                    InterfaceSetup.Get(HeiFlowInterfaceSetup."HeiFLOW Customer");
                    APIInterfaceLog2."Call Type" := InterfaceSetup."Call Type";
                    APIInterfaceLog2."Source Type" := 18;
                    InterfaceSetup.TestField(Enabled, true);
                    APIInterfaceLog2."Job Queue Category Code" := ''; // From which setup for sequencial operation if conflicting? Leave blank for parallel processing
                                                                      //APIInterfaceLog2."Processing Codeunit" := CODEUNIT::Codeunit50224;
                end;
            //HEI.04>>
            'VENDOR':
                begin
                    HeiFlowInterfaceSetup.Get();
                    HeiFlowInterfaceSetup.TestField("HeiFLOW Vendor");
                    APIInterfaceLog2."Interface Code" := HeiFlowInterfaceSetup."HeiFLOW Vendor";
                    InterfaceSetup.Get(HeiFlowInterfaceSetup."HeiFLOW Vendor");
                    APIInterfaceLog2."Call Type" := InterfaceSetup."Call Type";
                    APIInterfaceLog2."Source Type" := 23;
                    InterfaceSetup.TestField(Enabled, true);
                    APIInterfaceLog2."Job Queue Category Code" := '';
                    //APIInterfaceLog2."Processing Codeunit" := CODEUNIT::Codeunit50224;
                end;
        //HEI.04<<
        end;
    end;

    local procedure CreateResponse(MsgId: Text; IsSuccess: Boolean; ErrorText: Text);
    var
        // BC Upgrade POENAB02 >>
        /*
        RootXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        */
        RootXmlNode: XmlElement;
        TempXmlNode: XmlElement;
    // BC Upgrade POENAB02 <<
    begin
        // BC Upgrade POENAB02 >>
        /*
        ResponseXmlDocument := ResponseXmlDocument.XmlDocument;
        RootXmlNode := ResponseXmlDocument.CreateElement('msgResponse');
        ResponseXmlDocument.AppendChild(RootXmlNode);
        TempXmlNode := ResponseXmlDocument.CreateElement('msgId');
        TempXmlNode.InnerText := MsgId;
        RootXmlNode.AppendChild(TempXmlNode);
        TempXmlNode := ResponseXmlDocument.CreateElement('isSuccess');
        if IsSuccess then
            TempXmlNode.InnerText := 'true'
        else
            TempXmlNode.InnerText := 'false';
        RootXmlNode.AppendChild(TempXmlNode);
        TempXmlNode := ResponseXmlDocument.CreateElement('error');
        TempXmlNode.InnerText := ErrorText;
        RootXmlNode.AppendChild(TempXmlNode);

        ResponsetXml.Blob.CREATEOUTSTREAM(MessageResponseOutStream);
        ResponseXmlDocument.Save(MessageResponseOutStream);

        //HEI.03>>
        CLEAR(RootXmlNode);
        CLEAR(TempXmlNode);
        //HEI.03<< 
        */
        ResponseXmlDocument := XmlDocument.Create();
        RootXmlNode := XmlElement.Create('msgResponse');
        ResponseXmlDocument.Add(RootXmlNode);

        TempXmlNode := XmlElement.Create('msgId');
        TempXmlNode.Add(XmlText.Create(MsgId));
        RootXmlNode.Add(TempXmlNode);

        TempXmlNode := XmlElement.Create('isSuccess');
        if IsSuccess then
            TempXmlNode.Add(XmlText.Create('true'))
        else
            TempXmlNode.Add(XmlText.Create('false'));
        RootXmlNode.Add(TempXmlNode);

        TempXmlNode := XmlElement.Create('error');
        TempXmlNode.Add(XmlText.Create(ErrorText));
        RootXmlNode.Add(TempXmlNode);

        ResponsetXml.CreateOutStream(MessageResponseOutStream, TextEncoding::UTF8);
        ResponseXmlDocument.WriteTo(MessageResponseOutStream);
        // BC Upgrade POENAB02 <<
    end;

    local procedure GetNodeByXPath(XPath: Text; NodeName: Text);
    begin
        // BC Upgrade POENAB02 >>
        /* 
        XmlNode := RequestXmlDocument.SelectSingleNode(XPath); // Mandatory
        if ISNULL(XmlNode) then
            ERROR(MissingNodeErr, NodeName);
        if XmlNode.InnerText = '' then
            ERROR(TextMissingErr, NodeName); 
        */
        if not RequestXmlDocument.SelectSingleNode(XPath, XmlNode) then
            Error(MissingNodeErr, NodeName);
        if XmlNode.AsXmlElement().InnerText() = '' then
            Error(TextMissingErr, NodeName);
        // BC Upgrade POENAB02 <<
    end;

    local procedure GetNodeByXPath2(XPath: Text; NodeName: Text; CheckValue: Boolean);
    begin
        // BC Upgrade POENAB02 >>
        /*
        //HEI.03>>
        XmlNode := RequestXmlDocument.SelectSingleNode(XPath); // Mandatory
        if ISNULL(XmlNode) then
            ERROR(MissingNodeErr, NodeName);

        if CheckValue then
            if XmlNode.InnerText = '' then
                ERROR(TextMissingErr, NodeName);
        */
        if not RequestXmlDocument.SelectSingleNode(XPath, XmlNode) then
            Error(MissingNodeErr, NodeName);
        if XmlNode.AsXmlElement().InnerText() = '' then
            Error(TextMissingErr, NodeName);
        //HEI.03<<
    end;

    // BC Upgrade POENAB02 >>
    /* 
    local procedure CreateResponseforCustomer(MsgId: Text; IsSuccess: Boolean; ErrorText: Text);
    var
        RootXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        lrec_Ibecor_POData: Record "Ibecor PO Staging Data INT";
        Customers: Record Customer;
        CustomerCountry: Text;
        MasterAddress: Text;
        TempXmlNodeTier2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier3: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier4: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier5: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier6: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier7: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier8: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier9: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier10: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier11: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier12: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier13: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier14: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier15: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier16: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier17: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier18: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier19: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier20: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier21: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier22: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier23: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier24: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier25: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier26: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier27: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    begin
        //HEI.04>>
        ResponseXmlDocument := ResponseXmlDocument.XmlDocument;
        RootXmlNode := ResponseXmlDocument.CreateElement('msgResponse');
        ResponseXmlDocument.AppendChild(RootXmlNode);

        TempXmlNode := ResponseXmlDocument.CreateElement('msgId');
        TempXmlNode.InnerText := MsgId;
        RootXmlNode.AppendChild(TempXmlNode);

        TempXmlNode := ResponseXmlDocument.CreateElement('isSuccess');
        if IsSuccess then
            TempXmlNode.InnerText := 'true'
        else
            TempXmlNode.InnerText := 'false';
        RootXmlNode.AppendChild(TempXmlNode);

        if not IsSuccess then begin
            TempXmlNode := ResponseXmlDocument.CreateElement('error');
            TempXmlNode.InnerText := ErrorText;
            RootXmlNode.AppendChild(TempXmlNode);
        end;

        //RecordCount:=0;
        Customers.RESET;
        Customers.SETCURRENTKEY("Last Date Modified");
        if HeiFlowInterfaceSetup."Last Modified Customer" <> 0D then
            Customers.SETFILTER("Last Date Modified", '>%1', HeiFlowInterfaceSetup."Last Modified Customer");
        if Customers.FINDSET(false, false) then
            repeat

                TempXmlNode := ResponseXmlDocument.CreateElement('Details');
                RootXmlNode.AppendChild(TempXmlNode);

                CLEAR(CustomerCountry);
                if Customers."Country/Region Code" <> '' then
                    CustomerCountry := Customers."Country/Region Code"
                else
                    CustomerCountry := CompanyInfo."Country/Region Code";

                CLEAR(MasterAddress);
                MasterAddress := GetMasterAddr(Customers."House No.", Customers.Address
                                , Customers."Address 2", Customers."Street 3 FND"
                                , Customers."Street 4 FND", Customers."Street 5 FND");

                TempXmlNodeTier2 := ResponseXmlDocument.CreateElement('Id');
                TempXmlNodeTier2.InnerText := FORMAT('');
                TempXmlNode.AppendChild(TempXmlNodeTier2);

                TempXmlNodeTier3 := ResponseXmlDocument.CreateElement('CompanyMasterDataId');
                TempXmlNodeTier3.InnerText := FORMAT(CompanyInfo."Legal Entity Code FND");
                TempXmlNode.AppendChild(TempXmlNodeTier3);

                TempXmlNodeTier4 := ResponseXmlDocument.CreateElement('UniqueID');
                TempXmlNodeTier4.InnerText := '';
                TempXmlNode.AppendChild(TempXmlNodeTier4);

                TempXmlNodeTier5 := ResponseXmlDocument.CreateElement('ERPSystem');
                TempXmlNodeTier5.InnerText := COMPANYNAME;
                TempXmlNode.AppendChild(TempXmlNodeTier5);

                TempXmlNodeTier6 := ResponseXmlDocument.CreateElement('Number');
                TempXmlNodeTier6.InnerText := FORMAT(Customers."No.");
                TempXmlNode.AppendChild(TempXmlNodeTier6);

                TempXmlNodeTier7 := ResponseXmlDocument.CreateElement('Name');
                TempXmlNodeTier7.InnerText := FORMAT(Customers.Name);
                TempXmlNode.AppendChild(TempXmlNodeTier7);

                TempXmlNodeTier8 := ResponseXmlDocument.CreateElement('CompanyCode');
                TempXmlNodeTier8.InnerText := FORMAT(CompanyInfo."Legal Entity Code FND");
                TempXmlNode.AppendChild(TempXmlNodeTier8);

                TempXmlNodeTier9 := ResponseXmlDocument.CreateElement('Country');
                TempXmlNodeTier9.InnerText := FORMAT(CustomerCountry);
                TempXmlNode.AppendChild(TempXmlNodeTier9);

                TempXmlNodeTier10 := ResponseXmlDocument.CreateElement('City');
                TempXmlNodeTier10.InnerText := FORMAT(Customers.City);
                TempXmlNode.AppendChild(TempXmlNodeTier10);

                TempXmlNodeTier11 := ResponseXmlDocument.CreateElement('PostalCode');
                TempXmlNodeTier11.InnerText := FORMAT(Customers."Post Code");
                TempXmlNode.AppendChild(TempXmlNodeTier11);

                TempXmlNodeTier12 := ResponseXmlDocument.CreateElement('Street');
                TempXmlNodeTier12.InnerText := MasterAddress;
                TempXmlNode.AppendChild(TempXmlNodeTier12);

                TempXmlNodeTier13 := ResponseXmlDocument.CreateElement('Region');
                TempXmlNodeTier13.InnerText := FORMAT(Customers.Area);
                TempXmlNode.AppendChild(TempXmlNodeTier13);

                TempXmlNodeTier14 := ResponseXmlDocument.CreateElement('TaxNumber');
                TempXmlNodeTier14.InnerText := FORMAT(Customers."Tax Number 1");
                TempXmlNode.AppendChild(TempXmlNodeTier14);

                TempXmlNodeTier15 := ResponseXmlDocument.CreateElement('TaxNumber2');
                TempXmlNodeTier15.InnerText := FORMAT(Customers."Tax Number 2 FND");
                TempXmlNode.AppendChild(TempXmlNodeTier15);

                TempXmlNodeTier16 := ResponseXmlDocument.CreateElement('VatRegNumber');
                TempXmlNodeTier16.InnerText := FORMAT(Customers."VAT Registration No.");
                TempXmlNode.AppendChild(TempXmlNodeTier16);

                TempXmlNodeTier17 := ResponseXmlDocument.CreateElement('PaymentMethod');
                TempXmlNodeTier17.InnerText := FORMAT(Customers."Payment Method Code");
                TempXmlNode.AppendChild(TempXmlNodeTier17);

                TempXmlNodeTier18 := ResponseXmlDocument.CreateElement('TermSoftPayment');
                TempXmlNodeTier18.InnerText := FORMAT(Customers."Payment Terms Code");
                TempXmlNode.AppendChild(TempXmlNodeTier18);
                //>>HEI.02
                if Customers.Blocked = Customers.Blocked::" " then
                    CustomerIsActive := true
                else
                    CustomerIsActive := false;

                TempXmlNodeTier19 := ResponseXmlDocument.CreateElement('IsActive');
                TempXmlNodeTier19.InnerText := FORMAT(CustomerIsActive);
                TempXmlNode.AppendChild(TempXmlNodeTier19);
            //<<HEI.02
            //RecordCount:= RecordCount+1;

            //UNTIL (RecordCount >= 10) OR (Customers.NEXT = 0);
            until (Customers.NEXT = 0);
        ResponsetXml.Blob.CREATEOUTSTREAM(MessageResponseOutStream);
        ResponseXmlDocument.Save(MessageResponseOutStream);
        //HEI.04<<

        //HEI.03>>
        CLEAR(RootXmlNode);
        CLEAR(TempXmlNode);
        CLEAR(TempXmlNodeTier2);
        CLEAR(TempXmlNodeTier3);
        CLEAR(TempXmlNodeTier4);
        CLEAR(TempXmlNodeTier5);
        CLEAR(TempXmlNodeTier6);
        CLEAR(TempXmlNodeTier7);
        CLEAR(TempXmlNodeTier8);
        CLEAR(TempXmlNodeTier9);
        CLEAR(TempXmlNodeTier10);
        CLEAR(TempXmlNodeTier11);
        CLEAR(TempXmlNodeTier12);
        CLEAR(TempXmlNodeTier13);
        CLEAR(TempXmlNodeTier14);
        CLEAR(TempXmlNodeTier15);
        CLEAR(TempXmlNodeTier16);
        CLEAR(TempXmlNodeTier17);
        CLEAR(TempXmlNodeTier18);
        CLEAR(TempXmlNodeTier19);
        CLEAR(TempXmlNodeTier20);
        CLEAR(TempXmlNodeTier21);
        CLEAR(TempXmlNodeTier22);
        CLEAR(TempXmlNodeTier23);
        CLEAR(TempXmlNodeTier24);
        CLEAR(TempXmlNodeTier25);
        CLEAR(TempXmlNodeTier26);
        CLEAR(TempXmlNodeTier27);
        //HEI.03<<
    end; 
    */

    local procedure CreateResponseforCustomer(MsgId: Text; IsSuccess: Boolean; ErrorText: Text);
    var
        //lrec_Ibecor_POData: Record "Ibecor PO Staging Data INT"; // Unused
        Customers: Record Customer;
        CustomerCountry: Text;
        MasterAddress: Text;
        CustomerIsActive: Boolean;
        RootXmlNode: XmlElement;
        TempXmlNode: XmlElement;
    begin
        //HEI.04>>
        ResponseXmlDocument := XmlDocument.Create();
        RootXmlNode := XmlElement.Create('msgResponse');
        ResponseXmlDocument.Add(RootXmlNode);

        TempXmlNode := AddTextElement(RootXmlNode, 'msgId', MsgId);
        if IsSuccess then
            TempXmlNode := AddTextElement(RootXmlNode, 'isSuccess', 'true')
        else
            TempXmlNode := AddTextElement(RootXmlNode, 'isSuccess', 'false');

        if not IsSuccess then
            TempXmlNode := AddTextElement(RootXmlNode, 'error', ErrorText);

        //RecordCount:=0;
        Customers.Reset();
        Customers.SetCurrentKey("Last Date Modified");
        if HeiFlowInterfaceSetup."Last Modified Customer" <> 0D then
            Customers.SetFilter("Last Date Modified", '>%1', HeiFlowInterfaceSetup."Last Modified Customer");
        if Customers.FindSet() then
            repeat

                TempXmlNode := XmlElement.Create('Details');
                RootXmlNode.Add(TempXmlNode);

                Clear(CustomerCountry);
                if Customers."Country/Region Code" <> '' then
                    CustomerCountry := Customers."Country/Region Code"
                else
                    CustomerCountry := CompanyInfo."Country/Region Code";

                Clear(MasterAddress);
                MasterAddress := GetMasterAddr(Customers."House No. FND", Customers.Address
                                , Customers."Address 2", Customers."Street 3 FND"
                                , Customers."Street 4 FND", Customers."Street 5 FND");
                AddTextElement(TempXmlNode, 'Id', '');
                AddTextElement(TempXmlNode, 'CompanyMasterDataId', Format(CompanyInfo."Legal Entity Code FND"));
                AddTextElement(TempXmlNode, 'UniqueID', '');
                AddTextElement(TempXmlNode, 'ERPSystem', CompanyName);
                AddTextElement(TempXmlNode, 'Number', Format(Customers."No."));
                AddTextElement(TempXmlNode, 'Name', Format(Customers.Name));
                AddTextElement(TempXmlNode, 'CompanyCode', Format(CompanyInfo."Legal Entity Code FND"));
                AddTextElement(TempXmlNode, 'Country', Format(CustomerCountry));
                AddTextElement(TempXmlNode, 'City', Format(Customers.City));
                AddTextElement(TempXmlNode, 'PostalCode', Format(Customers."Post Code"));
                AddTextElement(TempXmlNode, 'Street', MasterAddress);
                // AddTextElement(TempXmlNode, 'Region', FORMAT(Customers.Area)); // 'Area' field not available in Customer table
                AddTextElement(TempXmlNode, 'TaxNumber', Format(Customers."Tax Number 1 FND"));
                AddTextElement(TempXmlNode, 'TaxNumber2', Format(Customers."Tax Number 2 FND"));
                AddTextElement(TempXmlNode, 'VatRegNumber', Format(Customers."VAT Registration No."));
                AddTextElement(TempXmlNode, 'PaymentMethod', Format(Customers."Payment Method Code"));
                AddTextElement(TempXmlNode, 'TermSoftPayment', Format(Customers."Payment Terms Code"));
                //>>HEI.02
                if Customers.Blocked = Customers.Blocked::" " then
                    CustomerIsActive := true
                else
                    CustomerIsActive := false;

                AddTextElement(TempXmlNode, 'IsActive', Format(CustomerIsActive));
            //<<HEI.02
            //RecordCount:= RecordCount+1;

            //UNTIL (RecordCount >= 10) OR (Customers.NEXT = 0);
            until (Customers.Next() = 0);
        ResponsetXml.CreateOutStream(MessageResponseOutStream, TextEncoding::UTF8);
        ResponseXmlDocument.WriteTo(MessageResponseOutStream);
        //HEI.04<<

        //HEI.03>>
        //HEI.03<<
    end;
    // BC Upgrade POENAB02 <<

    // BC Upgrade POENAB02 >>
    /* 
    local procedure CreateResponseforVendor(MsgId: Text; IsSuccess: Boolean; ErrorText: Text);
    var
        RootXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        lrec_Ibecor_POData: Record "Ibecor PO Staging Data INT";
        Vendors: Record Vendor;
        VendorCountry: Text;
        MasterAddress: Text;
        TempXmlNodeTier2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier3: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier4: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier5: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier6: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier7: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier8: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier9: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier10: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier11: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier12: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier13: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier14: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier15: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier16: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier17: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier18: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier19: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier20: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier21: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier22: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier23: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier24: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier25: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier26: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNodeTier27: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    begin
        //HEI.04>>
        ResponseXmlDocument := ResponseXmlDocument.XmlDocument;
        RootXmlNode := ResponseXmlDocument.CreateElement('msgResponse');
        ResponseXmlDocument.AppendChild(RootXmlNode);

        TempXmlNode := ResponseXmlDocument.CreateElement('msgId');
        TempXmlNode.InnerText := MsgId;
        RootXmlNode.AppendChild(TempXmlNode);

        TempXmlNode := ResponseXmlDocument.CreateElement('isSuccess');
        if IsSuccess then
            TempXmlNode.InnerText := 'true'
        else
            TempXmlNode.InnerText := 'false';
        RootXmlNode.AppendChild(TempXmlNode);

        if not IsSuccess then begin
            TempXmlNode := ResponseXmlDocument.CreateElement('error');
            TempXmlNode.InnerText := ErrorText;
            RootXmlNode.AppendChild(TempXmlNode);
        end;

        //RecordCount :=0;
        Vendors.RESET;
        Vendors.SETCURRENTKEY("Last Date Modified");
        if HeiFlowInterfaceSetup."Last Modified Vendor" <> 0D then
            Vendors.SETFILTER("Last Date Modified", '>%1', HeiFlowInterfaceSetup."Last Modified Vendor");
        if Vendors.FINDSET(false, false) then
            repeat

                TempXmlNode := ResponseXmlDocument.CreateElement('Details');
                RootXmlNode.AppendChild(TempXmlNode);

                CLEAR(VendorCountry);
                if Vendors."Country/Region Code" <> '' then
                    VendorCountry := Vendors."Country/Region Code"
                else
                    VendorCountry := CompanyInfo."Country/Region Code";

                CLEAR(MasterAddress);
                MasterAddress := GetMasterAddr(Vendors."House Number", Vendors.Address
                                , Vendors."Address 2", Vendors."Street 3 FND"
                                , Vendors."Street 4 FND", Vendors."Street 5 FND");

                TempXmlNodeTier2 := ResponseXmlDocument.CreateElement('Id');
                TempXmlNodeTier2.InnerText := FORMAT('');
                TempXmlNode.AppendChild(TempXmlNodeTier2);

                TempXmlNodeTier3 := ResponseXmlDocument.CreateElement('CompanyMasterDataId');
                TempXmlNodeTier3.InnerText := FORMAT(CompanyInfo."Legal Entity Code FND");
                TempXmlNode.AppendChild(TempXmlNodeTier3);

                TempXmlNodeTier4 := ResponseXmlDocument.CreateElement('UniqueID');
                TempXmlNodeTier4.InnerText := '';
                TempXmlNode.AppendChild(TempXmlNodeTier4);

                TempXmlNodeTier5 := ResponseXmlDocument.CreateElement('ERPSystem');
                TempXmlNodeTier5.InnerText := COMPANYNAME;  //AS
                TempXmlNode.AppendChild(TempXmlNodeTier5);

                TempXmlNodeTier6 := ResponseXmlDocument.CreateElement('Number');
                TempXmlNodeTier6.InnerText := FORMAT(Vendors."No.");
                TempXmlNode.AppendChild(TempXmlNodeTier6);

                TempXmlNodeTier7 := ResponseXmlDocument.CreateElement('Name');
                TempXmlNodeTier7.InnerText := FORMAT(Vendors.Name);
                TempXmlNode.AppendChild(TempXmlNodeTier7);

                TempXmlNodeTier8 := ResponseXmlDocument.CreateElement('CompanyCode');
                TempXmlNodeTier8.InnerText := FORMAT(CompanyInfo."Legal Entity Code FND");
                TempXmlNode.AppendChild(TempXmlNodeTier8);

                TempXmlNodeTier9 := ResponseXmlDocument.CreateElement('City');
                TempXmlNodeTier9.InnerText := FORMAT(Vendors.City);
                TempXmlNode.AppendChild(TempXmlNodeTier9);

                TempXmlNodeTier10 := ResponseXmlDocument.CreateElement('PostalCode');
                TempXmlNodeTier10.InnerText := FORMAT(Vendors."Post Code");
                TempXmlNode.AppendChild(TempXmlNodeTier10);

                TempXmlNodeTier11 := ResponseXmlDocument.CreateElement('Street');
                TempXmlNodeTier11.InnerText := MasterAddress;
                TempXmlNode.AppendChild(TempXmlNodeTier11);


                TempXmlNodeTier12 := ResponseXmlDocument.CreateElement('Country');
                TempXmlNodeTier12.InnerText := FORMAT(VendorCountry);
                TempXmlNode.AppendChild(TempXmlNodeTier12);

                TempXmlNodeTier13 := ResponseXmlDocument.CreateElement('TaxNumber');
                TempXmlNodeTier13.InnerText := FORMAT(Vendors."Tax Number 2 FND");
                TempXmlNode.AppendChild(TempXmlNodeTier13);

                TempXmlNodeTier14 := ResponseXmlDocument.CreateElement('TaxNumber2');
                TempXmlNodeTier14.InnerText := FORMAT(Vendors."Tax Number 3 FND");
                TempXmlNode.AppendChild(TempXmlNodeTier14);

                TempXmlNodeTier15 := ResponseXmlDocument.CreateElement('VatRegNumber');
                TempXmlNodeTier15.InnerText := FORMAT(Vendors."VAT Registration No.");
                TempXmlNode.AppendChild(TempXmlNodeTier15);
                //>>HEI.02
                if Vendors.Blocked = Vendors.Blocked::" " then
                    VendorIsActive := true
                else
                    VendorIsActive := false;

                TempXmlNodeTier16 := ResponseXmlDocument.CreateElement('IsActive');
                TempXmlNodeTier16.InnerText := FORMAT(VendorIsActive);
                TempXmlNode.AppendChild(TempXmlNodeTier16);
            //<<HEI.02
            //RecordCount := RecordCount+1;

            //UNTIL (RecordCount >=10) OR  (Vendors.NEXT = 0);
            until (Vendors.NEXT = 0);
        //
        //

        ResponsetXml.Blob.CREATEOUTSTREAM(MessageResponseOutStream);
        ResponseXmlDocument.Save(MessageResponseOutStream);
        //HEI.04<<

        //HEI.03>>
        CLEAR(RootXmlNode);
        CLEAR(TempXmlNode);
        CLEAR(TempXmlNodeTier2);
        CLEAR(TempXmlNodeTier3);
        CLEAR(TempXmlNodeTier4);
        CLEAR(TempXmlNodeTier5);
        CLEAR(TempXmlNodeTier6);
        CLEAR(TempXmlNodeTier7);
        CLEAR(TempXmlNodeTier8);
        CLEAR(TempXmlNodeTier9);
        CLEAR(TempXmlNodeTier10);
        CLEAR(TempXmlNodeTier11);
        CLEAR(TempXmlNodeTier12);
        CLEAR(TempXmlNodeTier13);
        CLEAR(TempXmlNodeTier14);
        CLEAR(TempXmlNodeTier15);
        CLEAR(TempXmlNodeTier16);
        //HEI.03<<
    end; 
    */

    local procedure CreateResponseforVendor(MsgId: Text; IsSuccess: Boolean; ErrorText: Text);
    var
        //lrec_Ibecor_POData: Record "Ibecor PO Staging Data INT"; // Unused
        Vendors: Record Vendor;
        VendorCountry: Text;
        MasterAddress: Text;
        VendorIsActive: Boolean;
        RootXmlNode: XmlElement;
        TempXmlNode: XmlElement;
    begin
        //HEI.04>>
        ResponseXmlDocument := XmlDocument.Create();
        RootXmlNode := XmlElement.Create('msgResponse');
        ResponseXmlDocument.Add(RootXmlNode);

        TempXmlNode := AddTextElement(RootXmlNode, 'msgId', MsgId);
        if IsSuccess then
            TempXmlNode := AddTextElement(RootXmlNode, 'isSuccess', 'true')
        else
            TempXmlNode := AddTextElement(RootXmlNode, 'isSuccess', 'false');

        if not IsSuccess then
            TempXmlNode := AddTextElement(RootXmlNode, 'error', ErrorText);

        //RecordCount :=0;
        Vendors.Reset();
        Vendors.SetCurrentKey("Last Date Modified");
        if HeiFlowInterfaceSetup."Last Modified Vendor" <> 0D then
            Vendors.SetFilter("Last Date Modified", '>%1', HeiFlowInterfaceSetup."Last Modified Vendor");
        if Vendors.FindSet() then
            repeat

                TempXmlNode := XmlElement.Create('Details');
                RootXmlNode.Add(TempXmlNode);

                Clear(VendorCountry);
                if Vendors."Country/Region Code" <> '' then
                    VendorCountry := Vendors."Country/Region Code"
                else
                    VendorCountry := CompanyInfo."Country/Region Code";

                Clear(MasterAddress);
                MasterAddress := GetMasterAddr(Vendors."House Number FND", Vendors.Address
                                , Vendors."Address 2", Vendors."Street 3 FND"
                                , Vendors."Street 4 FND", Vendors."Street 5 FND");

                AddTextElement(TempXmlNode, 'Id', '');
                AddTextElement(TempXmlNode, 'CompanyMasterDataId', Format(CompanyInfo."Legal Entity Code FND"));
                AddTextElement(TempXmlNode, 'UniqueID', '');
                AddTextElement(TempXmlNode, 'ERPSystem', CompanyName);
                AddTextElement(TempXmlNode, 'Number', Format(Vendors."No."));
                AddTextElement(TempXmlNode, 'Name', Format(Vendors.Name));
                AddTextElement(TempXmlNode, 'CompanyCode', Format(CompanyInfo."Legal Entity Code FND"));
                AddTextElement(TempXmlNode, 'City', Format(Vendors.City));
                AddTextElement(TempXmlNode, 'PostalCode', Format(Vendors."Post Code"));
                AddTextElement(TempXmlNode, 'Street', MasterAddress);
                AddTextElement(TempXmlNode, 'Country', Format(VendorCountry));
                AddTextElement(TempXmlNode, 'TaxNumber', Format(Vendors."Tax Number 2 FND"));
                AddTextElement(TempXmlNode, 'TaxNumber2', Format(Vendors."Tax Number 3 FND"));
                AddTextElement(TempXmlNode, 'VatRegNumber', Format(Vendors."VAT Registration No."));
                //>>HEI.02
                if Vendors.Blocked = Vendors.Blocked::" " then
                    VendorIsActive := true
                else
                    VendorIsActive := false;

                AddTextElement(TempXmlNode, 'IsActive', Format(VendorIsActive));
            //<<HEI.02
            //RecordCount := RecordCount+1;

            //UNTIL (RecordCount >=10) OR  (Vendors.NEXT = 0);
            until (Vendors.NEXT() = 0);
        //
        //

        ResponsetXml.CreateOutStream(MessageResponseOutStream, TextEncoding::UTF8);
        ResponseXmlDocument.WriteTo(MessageResponseOutStream);
        //HEI.04<<

        //HEI.03>>
        //HEI.03<<
    end;
    // BC Upgrade POENAB02 <<

    [TryFunction]
    local procedure ProcessMasterData();
    begin
        // BC Upgrade POENAB02 >>
        /* 
        if APIInterfaceLog2.Entity = 'CUSTOMER' then begin
            if APIInterfaceLog2.Operation = 'REQINFO' then
                //CreateResponseforPurchase(APIInterfaceLog2."Message ID",TRUE,'')
                CreateResponseforCustomer(APIInterfaceLog2."Message ID", true, '')
        end else if APIInterfaceLog2.Entity = 'VENDOR' then begin
            if APIInterfaceLog2.Operation = 'REQINFO' then
                //CreateResponseforPurchase(APIInterfaceLog2."Message ID",TRUE,'')
                CreateResponseforVendor(APIInterfaceLog2."Message ID", true, '')
        end else
            //HEI.04<<
            CreateResponse(APIInterfaceLog2."Message ID", true, '');
        //HEI.03>>
        //APIInterfaceLog2.Status := APIInterfaceLog2.Status::Processed; 
        */

        case APIInterfaceLog2.Entity of
            'CUSTOMER':
                if APIInterfaceLog2.Operation = 'REQINFO' then
                    CreateResponseforCustomer(APIInterfaceLog2."Message ID", true, '');
            'VENDOR':
                if APIInterfaceLog2.Operation = 'REQINFO' then
                    CreateResponseforVendor(APIInterfaceLog2."Message ID", true, '')
                else
                    CreateResponse(APIInterfaceLog2."Message ID", true, '');
        end;
        // BC Upgrade POENAB02 <<
    end;

    // BC Upgrade POENAB02 >>
    local procedure AddTextElement(var Parent: XmlElement; NodeName: Text; NodeValue: Text): XmlElement;
    var
        Child: XmlElement;
    begin
        Child := XmlElement.Create(NodeName);
        Child.Add(XmlText.Create(NodeValue));
        Parent.Add(Child);
        exit(Child);
    end;
    // BC Upgrade POENAB05 <<


    local procedure GetLastModifiedDateCustomerLocal(): Date;
    var
        Customers: Record Customer;
    begin
        Customers.Reset();
        Customers.SetCurrentKey("Last Date Modified");
        Customers.SetFilter("Last Date Modified", '<>%1', 0D);
        if Customers.FindLast() then
            exit(Customers."Last Date Modified");
    end;

    local procedure GetLastModifiedDateVendorLocal(): Date;
    var
        Vendors: Record Vendor;
    begin
        Vendors.Reset();
        Vendors.SetCurrentKey("Last Date Modified");
        Vendors.SetFilter("Last Date Modified", '<>%1', 0D);
        if Vendors.FindLast() then
            exit(Vendors."Last Date Modified");
    end;

    local procedure GetMasterAddr(HouseNo: Text; Add: Text; Add2: Text; Street3: Text; Street4: Text; Street5: Text): Text;
    var
        MasterAdd: Text;
    begin
        if HouseNo <> '' then
            MasterAdd := HouseNo + ', ';

        if Add <> '' then
            MasterAdd += Add + ', ';

        if Add2 <> '' then
            MasterAdd += Add2 + ', ';

        if Street3 <> '' then
            MasterAdd += Street3 + ', ';

        if Street4 <> '' then
            MasterAdd += Street4 + ', ';

        if Street5 <> '' then
            MasterAdd += Street5;

        exit(MasterAdd);
    end;

    procedure MasterExpotToExcel(MasterType: Option " ",Customer,Vendor);
    begin
        //HEI.05>>
        /*
        PrintExcel :=TRUE;
        ExcelBuffer.DELETEALL;
        IF MasterType = MasterType::Customer THEN BEGIN
          MakeExcelDataHeader(MasterType::Customer);
          MakeExcelDataBody(MasterType::Customer);
          CreateExcelBook(MasterType::Customer);
          MESSAGE('%1','File Sucessfully Exported on Path '+ExportedFilePath);
        END;
        
        IF MasterType = MasterType::Vendor THEN BEGIN
          MakeExcelDataHeader(MasterType::Vendor);
          MakeExcelDataBody(MasterType::Vendor);
          CreateExcelBook(MasterType::Vendor);
          MESSAGE('%1','File Sucessfully Exported on Path '+ExportedFilePath);
        END;
        */
        //HEI.05<<

    end;

    local procedure MakeExcelInfo();
    begin
    end;

    // BC Upgrade POENAB05 >>
    /* 
    local procedure MakeExcelDataHeader(MasterType: Option " ",Customer,Vendor);
    begin
        if MasterType = MasterType::Customer then begin
            ExcelBuffer.AddColumn('Id', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('CompanyMasterDataId', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('UniqueId', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('ERPSystem', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Number', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Name', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('CompanyCode', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Country', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('City', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('PostalCode', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Street', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Region', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('TaxNumber', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('TaxNumber2', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('VATRegNumber', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('PaymentMethod', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('TermSoftPayment', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('IsActive', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        end;

        if MasterType = MasterType::Vendor then begin
            ExcelBuffer.AddColumn('Id', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('CompanyMasterDataId', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('UniqueId', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('ERPSystem', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Number', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Name', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('CompanyCode', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('City', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('PostalCode', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Street', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Country', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('TaxNumber', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('TaxNumber2', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('VATRegNumber', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('IsActive', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);

        end;
    end; 
    */

    local procedure MakeExcelDataHeader(MasterType: Option " ",Customer,Vendor);
    begin
        if MasterType = MasterType::Customer then begin
            TempExcelBuffer.AddColumn('Id', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('CompanyMasterDataId', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('UniqueId', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('ERPSystem', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('Number', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('Name', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('CompanyCode', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('Country', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('City', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('PostalCode', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('Street', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('Region', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('TaxNumber', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('TaxNumber2', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('VATRegNumber', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('PaymentMethod', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('TermSoftPayment', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('IsActive', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        end;

        if MasterType = MasterType::Vendor then begin
            TempExcelBuffer.AddColumn('Id', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('CompanyMasterDataId', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('UniqueId', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('ERPSystem', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('Number', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('Name', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('CompanyCode', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('City', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('PostalCode', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('Street', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('Country', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('TaxNumber', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('TaxNumber2', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('VATRegNumber', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('IsActive', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);

        end;
    end;
    // BC Upgrade POENAB05 <<


    // BC Upgrade POENAB05 >>
    /* 
    local procedure MakeExcelDataBody(MasterType: Option " ",Customer,Vendor);
    var
        CustomerCountry: Text;
        CompanyInfo: Record "Company Information";
        MasterAddress: Text;
        CustomerIsActive: Boolean;
        VendorCountry: Text;
        VendorIsActive: Boolean;
        Customers: Record Customer;
        Vendors: Record Vendor;
    begin
        CompanyInfo.GET;

        if MasterType = MasterType::Customer then begin
            Customers.RESET;
            Customers.SETCURRENTKEY("No.");
            if Customers.FINDSET(false, false) then
                repeat
                    CLEAR(CustomerCountry);
                    if Customers."Country/Region Code" <> '' then
                        CustomerCountry := Customers."Country/Region Code"
                    else
                        CustomerCountry := CompanyInfo."Country/Region Code";

                    CLEAR(MasterAddress);
                    MasterAddress := GetMasterAddr(Customers."House No.", Customers.Address
                                    , Customers."Address 2", Customers."Street 3 FND"
                                    , Customers."Street 4 FND", Customers."Street 5 FND");

                    if Customers.Blocked = Customers.Blocked::" " then
                        CustomerIsActive := true
                    else
                        CustomerIsActive := false;


                    ExcelBuffer.NewRow;
                    ExcelBuffer.AddColumn('', false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(CompanyInfo."Legal Entity Code FND", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(COMPANYNAME, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Customers."No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Customers.Name, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(CompanyInfo."Legal Entity Code FND", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(CustomerCountry, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Customers.City, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Customers."Post Code", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(MasterAddress, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Customers.Area, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Customers."Tax Number 1", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Customers."Tax Number 2 FND", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Customers."VAT Registration No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Customers."Payment Method Code", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Customers."Payment Terms Code", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(CustomerIsActive, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                until (Customers.NEXT = 0);
        end;

        if MasterType = MasterType::Vendor then begin
            Vendors.RESET;
            Vendors.SETCURRENTKEY("No.");
            if Vendors.FINDSET(false, false) then
                repeat
                    CLEAR(VendorCountry);
                    if Vendors."Country/Region Code" <> '' then
                        VendorCountry := Vendors."Country/Region Code"
                    else
                        VendorCountry := CompanyInfo."Country/Region Code";

                    CLEAR(MasterAddress);
                    MasterAddress := GetMasterAddr(Vendors."House Number", Vendors.Address
                                    , Vendors."Address 2", Vendors."Street 3 FND"
                                    , Vendors."Street 4 FND", Vendors."Street 5 FND");
                    if Vendors.Blocked = Vendors.Blocked::" " then
                        VendorIsActive := true
                    else
                        VendorIsActive := false;

                    ExcelBuffer.NewRow;
                    ExcelBuffer.AddColumn('', false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(CompanyInfo."Legal Entity Code FND", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(COMPANYNAME, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Vendors."No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Vendors.Name, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(CompanyInfo."Legal Entity Code FND", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Vendors.City, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Vendors."Post Code", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(MasterAddress, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(VendorCountry, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Vendors."Tax Number 2 FND", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Vendors."Tax Number 3 FND", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Vendors."VAT Registration No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(VendorIsActive, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                until (Vendors.NEXT = 0);
        end;
    end; 
    */

    local procedure MakeExcelDataBody(MasterType: Option " ",Customer,Vendor);
    var
        Customers: Record Customer;
        Vendors: Record Vendor;
        CompanyInfo: Record "Company Information";
        CustomerCountry: Text;
        MasterAddress: Text;
        TempCustomerIsActive: Boolean;
        VendorCountry: Text;
        TempVendorIsActive: Boolean;
    begin
        CompanyInfo.Get();

        if MasterType = MasterType::Customer then begin
            Customers.Reset();
            Customers.SetCurrentKey("No.");
            if Customers.FindSet() then
                repeat
                    Clear(CustomerCountry);
                    if Customers."Country/Region Code" <> '' then
                        CustomerCountry := Customers."Country/Region Code"
                    else
                        CustomerCountry := CompanyInfo."Country/Region Code";

                    Clear(MasterAddress);
                    MasterAddress := GetMasterAddr(Customers."House No. FND", Customers.Address
                                    , Customers."Address 2", Customers."Street 3 FND"
                                    , Customers."Street 4 FND", Customers."Street 5 FND");

                    if Customers.Blocked = Customers.Blocked::" " then
                        TempCustomerIsActive := true
                    else
                        TempCustomerIsActive := false;


                    TempExcelBuffer.NewRow();
                    TempExcelBuffer.AddColumn('', false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(CompanyInfo."Legal Entity Code FND", false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(CompanyName, false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Customers."No.", false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Customers.Name, false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(CompanyInfo."Legal Entity Code FND", false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(CustomerCountry, false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Customers.City, false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Customers."Post Code", false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(MasterAddress, false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    // BC Upgrade POENAB02 >>
                    // commented, as it is part of Aptean developments
                    // TempExcelBuffer.AddColumn(Customers.Area, false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    // BC Upgrade POENAB02 <<
                    TempExcelBuffer.AddColumn(Customers."Tax Number 1 FND", false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Customers."Tax Number 2 FND", false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Customers."VAT Registration No.", false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Customers."Payment Method Code", false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Customers."Payment Terms Code", false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(TempCustomerIsActive, false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                until (Customers.NEXT() = 0);
        end;

        if MasterType = MasterType::Vendor then begin
            Vendors.Reset();
            Vendors.SetCurrentKey("No.");
            if Vendors.FindSet() then
                repeat
                    Clear(VendorCountry);
                    if Vendors."Country/Region Code" <> '' then
                        VendorCountry := Vendors."Country/Region Code"
                    else
                        VendorCountry := CompanyInfo."Country/Region Code";

                    Clear(MasterAddress);
                    MasterAddress := GetMasterAddr(Vendors."House Number FND", Vendors.Address
                                    , Vendors."Address 2", Vendors."Street 3 FND"
                                    , Vendors."Street 4 FND", Vendors."Street 5 FND");
                    if Vendors.Blocked = Vendors.Blocked::" " then
                        TempVendorIsActive := true
                    else
                        TempVendorIsActive := false;

                    TempExcelBuffer.NewRow();
                    TempExcelBuffer.AddColumn('', false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(CompanyInfo."Legal Entity Code FND", false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(CompanyName, false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Vendors."No.", false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Vendors.Name, false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(CompanyInfo."Legal Entity Code FND", false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Vendors.City, false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Vendors."Post Code", false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(MasterAddress, false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(VendorCountry, false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Vendors."Tax Number 2 FND", false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Vendors."Tax Number 3 FND", false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Vendors."VAT Registration No.", false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(TempVendorIsActive, false, '', false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                until (Vendors.Next() = 0);
        end;
    end;
    // BC Upgrade POENAB05 <<

    local procedure CreateExcelBook(MasterType: Option " ",Customer,Vendor);
    begin
        //HEI.05>>
        /*
        CLEAR(ExportedFilePath);
        //Server side: process data with temporary file
        //ClientFileName:='C:\IBM\Ankit\RITM2804546\CustomerDATA.xlsx';
        ServerFileName := FileMgt.ServerTempFileName('xlsx');
        //ExcelBuffer.CreateBook(ServerFileName,'CustomerData');
        
        IF MasterType = MasterType::Customer THEN
          ExcelBuffer.CreateBook(ServerFileName,'CustomerData');
        
        IF MasterType = MasterType::Vendor THEN
          ExcelBuffer.CreateBook(ServerFileName,'VendorData');
        
        ExcelBuffer.WriteSheet('ReportHdr',COMPANYNAME,USERID);
        ExcelBuffer.DELETEALL(FALSE);
        
        ExcelBuffer.CloseBook;
        
        ClientFileName:=FileMgt.DownloadTempFile(ServerFileName);
        
        IF MasterType=MasterType::Customer THEN BEGIN
          FileMgt.MoveAndRenameClientFile(ClientFileName,'CustomerDataListHeiflow'+'_'+TENANTID+'_'+COMPANYNAME+'_'+FORMAT(TODAY,0,'<Day,2>-<Month,2>-<Year,2>')+
          FORMAT(TIME,0, '<Hours24,2>;<Minutes,2>;<Seconds,2> ')+'.xlsx','\\145.47.94.228\interface');
          ExportedFilePath:= '\\145.47.94.228\interface\'+'CustomerDataListHeiflow'+'_'+TENANTID+'_'+COMPANYNAME+'_'+FORMAT(TODAY,0,'<Day,2>-<Month,2>-<Year,2>')+
                              FORMAT(TIME,0, '<Hours24,2>;<Minutes,2>;<Seconds,2> ')+'.xlsx';
        END;
        
        IF MasterType=MasterType::Vendor THEN BEGIN
          FileMgt.MoveAndRenameClientFile(ClientFileName,'VendorDataListHeiflow'+'_'+TENANTID+'_'+COMPANYNAME+'_'+FORMAT(TODAY,0,'<Day,2>-<Month,2>-<Year,2>')+
          FORMAT(TIME,0, '<Hours24,2>;<Minutes,2>;<Seconds,2>')+'.xlsx','\\145.47.94.228\interface');
        
          ExportedFilePath:= '\\145.47.94.228\interface\'+'VendorDataListHeiflow'+'_'+TENANTID+'_'+COMPANYNAME+'_'+FORMAT(TODAY,0,'<Day,2>-<Month,2>-<Year,2>')+
                              FORMAT(TIME,0, '<Hours24,2>;<Minutes,2>;<Seconds,2> ')+'.xlsx';
        
        END;
        */
        //HEI.05<<

    end;

    //event RequestXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event RequestXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event RequestXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event RequestXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event RequestXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event RequestXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event ResponseXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event ResponseXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event ResponseXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event ResponseXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event ResponseXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event ResponseXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;
}

