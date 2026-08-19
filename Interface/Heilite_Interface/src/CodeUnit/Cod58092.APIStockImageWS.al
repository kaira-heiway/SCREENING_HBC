codeunit 58092 "API Stock Image WS"
{
    //BC Upgrade GUNREM01 Old ID-50150
    // version HEI.03

    // HEI.01 FDD-HB899 - CHG2093869 IBM NASTAA02 16.03.2021 # LSR - Transfer and Stock
    //   # New Codeunit created for API Stock Interface
    // HEI.02 INC4083000 - CHG2156647 IBM NASTAA02 29.04.2022 # NAS Service consuming high memory
    //   # Clear variables after Webservice call
    // HEI.03 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables

    //BC Upgrade GUNREM01 
    // # Replaced Temblob acriable record to codeunit
    // # Replaced Dotnet varibles to XML variables. 
    // # Code modified using XML variables

    // BC Upgrade SHUKLP03 >> Modified code because data was not exporting in Payload.

    trigger OnRun();
    begin
    end;

    var

        MessageOutStream: OutStream;
        MessageInStream: InStream;

        APIInterfaceLog2: Record "API Interface Log2 INT";

        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        ErrorOutStream: OutStream;
        //BC Upgrade GUNREM01 >>
        //RequestXml: Record TempBlob temporary;
        RequestXml: Codeunit "Temp Blob";
        // ResponsetXml: Record TempBlob temporary;
        ResponsetXml: Codeunit "Temp Blob";
        // ResponseXmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXmlDocument: XmlDocument;
        //   RequestXmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        RequestXmlDocument: XmlDocument;
        // XmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        XmlNode: XmlNode;
        //BC Upgrade GUNREM01
        MessageResponseOutStream: OutStream;
        MessageResponseInStream: InStream;
        JobQueueEntry: Record "Job Queue Entry";
        LastErrorMsg: Text;
        temptext: Text[250];
        LastPostingErrorMsg: Text;
        LastErrorOutStream: OutStream;
        MissingNodeErr: Label '%1 node missing from XML';
        TextMissingErr: Label 'Text missing for node %1 in XML';
        InvaildValueErr: Label 'Invalid value for %1';
        ErrorMsg: Label 'Error Code: %1, Error Text: %2, Call Stack Trace: %3';
        JobQueueProcessMsg: Label 'Process API Entry No. %1';
        NotExistingOrderErr: Label 'Order ID % was not sent from %2.';

    procedure ProcessStockImage(var Request: BigText);
    VAR
        //BC Upgrade VAMSIU01 >>
        RequestInStream: InStream;
        RequestOutStream: OutStream;
        ResponseInStream: InStream;
        ResponseOutStream: OutStream;
    //BC Upgrade VAMSIU01 <<

    begin
        //RequestXml.Blob.CREATEOUTSTREAM(MessageOutStream);
        RequestXml.CREATEOUTSTREAM(MessageOutStream);  //BC Upgrade GUNREM01 
        Request.WRITE(MessageOutStream);
        //RequestXml.Blob.CREATEINSTREAM(MessageInStream);
        RequestXml.CREATEINSTREAM(MessageInStream); //BC Upgrade GUNREM01 


        if TryLoadXML(Request) then begin
            APIInterfaceLog2.INIT();
            if CheckStockImageMandatoryProcessingNodes() then begin
                APIInterfaceLog2.INSERT();
                //BC Upgrade VAMSIU01 >>
                RequestXml.CreateInStream(RequestInStream);
                APIInterfaceLog2."Request File".CreateOutStream(RequestOutStream);
                CopyStream(RequestOutStream, RequestInStream);
                APIInterfaceLog2.MODIFY();
                //BC Upgrade VAMSIU01 <<

                COMMIT();
                if CODEUNIT.RUN(CODEUNIT::"API Stock Image Mgmt.", APIInterfaceLog2) then begin
                    APIInterfaceLog2.FIND();

                    if APIInterfaceLog2."Response File".HASVALUE then begin
                        //APIInterfaceLog2.CALCFIELDS("Response File");
                        //BC Upgrade SHUKLP03 >>
                        APIInterfaceLog2.CALCFIELDS("Response File");
                        APIInterfaceLog2."Response File".CreateInStream(ResponseInStream);
                        ResponsetXml.CreateOutStream(ResponseOutStream);
                        CopyStream(ResponseOutStream, ResponseInStream);
                        //BC Upgrade SHUKLP03 <<
                    end;

                    APIInterfaceLog2.Status := APIInterfaceLog2.Status::Processed;
                    APIInterfaceLog2.MODIFY();
                end else begin
                    APIInterfaceLog2.FIND();
                    LastErrorMsg := STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK);
                    APIInterfaceLog2.Status := APIInterfaceLog2.Status::Error;
                    APIInterfaceLog2."Error Message".CREATEOUTSTREAM(ErrorOutStream);
                    ErrorOutStream.WRITETEXT(LastErrorMsg);
                    APIInterfaceLog2.MODIFY();
                end;
            end;
        end;
        //BC Upgrade GUNREM01 >>
        // ResponsetXml.Blob.CREATEINSTREAM(MessageResponseInStream);
        ResponsetXml.CREATEINSTREAM(ResponseInStream);// BC Upgrade SHUKLP03
                                                      //BC Upgrade GUNREM01 <<

        CLEAR(Request);
        Request.READ(ResponseInStream); // BC Upgrade SHUKLP03 

        //HEI.02>>
        CLEAR(RequestXmlDocument);
        CLEAR(XmlNode);
        CLEAR(ResponseXmlDocument);
        //HEI.02<<
        //HEI.03>>
        CLEAR(MessageInStream);
        CLEAR(MessageOutStream);
        CLEAR(ErrorOutStream);
        CLEAR(MessageResponseInStream);
        CLEAR(MessageResponseOutStream);
        //HEI.03<<
    end;

    [TryFunction]
    local procedure CheckStockImageMandatoryProcessingNodes();
    var
        APIInterfaceSetup: Record "API Interface Setup2 INT";
        InterfaceSetup: Record "Interface Setup INT";
        APIInterfaceLog3: Record "API Interface Log2 INT";
        RequestInStream: InStream;
        RequestOutStream: OutStream;
    begin
        GetNodeByXPath('/StockImage', 'StockImage', false);
        GetNodeByXPath('/StockImage/Stock', 'Stock', false);

        GetNodeByXPath('/StockImage/Stock/SourceSystem', 'SourceSystem', true);
        //BC Upgrade GUNREM01 >>
        //if not SourceSystemIdentifierAPI.GET(XmlNode.InnerText) then
        if not SourceSystemIdentifierAPI.GET(XmlNode.AsXmlElement().InnerText) then
            //BC Upgrade GUNREM01 <<
            ERROR(InvaildValueErr, 'SourceSystem');
        APIInterfaceLog2.VALIDATE("Source System Identifier", SourceSystemIdentifierAPI.Code);

        GetNodeByXPath('/StockImage/Stock/MessageDateTime', 'MessageDateTime', false);
        //BC Upgrade GUNREM01 >>
        // if not ISNULL(XmlNode) then
        //     if XmlNode.InnerText <> '' then
        //         if EVALUATE(APIInterfaceLog2."Source Request Timestamp", XmlNode.InnerText, 9) then;
        if XmlNode.IsXmlElement then
            if XmlNode.AsXmlElement().InnerText() <> '' then
                if EVALUATE(APIInterfaceLog2."Source Request Timestamp", XmlNode.AsXmlElement().InnerText, 9) then;
        //BC Upgrade GUNREM01 >>

        APIInterfaceLog2."Request Sync. Date/Time" := CURRENTDATETIME;
        //bc Upgrade VAMSIU01 >>
        RequestXml.CreateInStream(RequestInStream);
        APIInterfaceLog2."Request File".CreateOutStream(RequestOutStream);
        CopyStream(RequestOutStream, RequestInStream);
        //BC Upgrade VAMSIU01 <<

        //BC Upgrade GUNREM01 >>
        //  APIInterfaceLog2."Request File" := RequestXml.Blob;
        // RequestXml.CreateOutStream(MessageOutStream);
        // RequestXmlDocument.WriteTo(MessageOutStream);
        // APIInterfaceLog2."Request File".CreateOutStream(MessageOutStream);
        // MessageOutStream.Write(MessageOutStream);
        //BC Upgrade GUNREM01 >>
        APIInterfaceLog2.Entity := 'STOCK';
        APIInterfaceLog2.Operation := 'READ';

        APIInterfaceSetup.GET();
        APIInterfaceSetup.TESTFIELD("API Stock Image Interface");
        APIInterfaceLog2."Interface Code" := APIInterfaceSetup."API Stock Image Interface";
        InterfaceSetup.GET(APIInterfaceSetup."API Stock Image Interface");
        InterfaceSetup.TESTFIELD(Enabled, true);
        APIInterfaceLog2."Call Type" := InterfaceSetup."Call Type";
        APIInterfaceLog2."Processing Codeunit" := CODEUNIT::"API Stock Image Mgmt.";
    end;

    local procedure GetNodeByXPath(XPath: Text; NodeName: Text; CheckValue: Boolean);
    begin
        //BC Upgrade GUNREM01 >>
        // XmlNode := RequestXmlDocument.SelectSingleNode(XPath); // Mandatory
        // if ISNULL(XmlNode) then
        //     ERROR(MissingNodeErr, NodeName);

        // if CheckValue then
        //     if XmlNode.InnerText = '' then
        //         ERROR(TextMissingErr, NodeName);
        if not RequestXmlDocument.SelectSingleNode(XPath, XmlNode) then
            Error(MissingNodeErr, NodeName);
        if XmlNode.AsXmlElement().InnerText() = '' then
            Error(TextMissingErr, NodeName);
        //BC Upgrade GUNREM01 <<

    end;

    // [TryFunction]
    // local procedure TryLoadXML();
    // var
    //     RequestInStream: InStream;
    // begin
    //     //BC Upgrade GUNREM01 >>
    //     // RequestXmlDocument := RequestXmlDocument.XmlDocument;
    //     // RequestXmlDocument.Load(MessageInStream);
    //     RequestXmlDocument := XmlDocument.Create();
    //     XmlDocument.ReadFrom(RequestInStream, RequestXmlDocument);
    //     //BC Upgrade GUNREM01 <<
    // end;

    [TryFunction]
    local procedure TryLoadXML(Message: BigText)
    var
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
    begin
        RequestXmlDocument := XmlDocument.Create();
        TempBlob.CreateOutStream(MessageOutStream);
        Message.Write(MessageOutStream);
        TempBlob.CreateInStream(MessageInStream);
        if not XmlDocument.ReadFrom(MessageInStream, RequestXmlDocument) then
            Error('Failed to parse XML');
    end;


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
}

