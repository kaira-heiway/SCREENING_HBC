codeunit 58089 "API Payment WS"
{
    //BC Upgrade GUNREM01 Old ID-50133
    // version HEI.04

    // HEI.01 FDD-HB1268 - CHG2068666 IBM NASTAA02 26.10.2020 # DMS Integration Ivory Coast
    //   # New Codeunit created for API Payment Interface
    // HEI.02 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # New code added to 'SendAPIPayments' function to enable the posting
    // HEI.03 INC4083000 - CHG2156647 IBM NASTAA02 29.04.2022 # NAS Service consuming high memory
    //   # Clear variables after Webservice call
    // HEI.04 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables

    //BC Upgrade GUNREM01 >>
    //# Replaced temblob record to code unit.
    //# Replaced Dotnet variables with xml variables
    //# Modified code using XML variable
    //BC Upgrade GUNREM01 <<

    trigger OnRun();
    begin
    end;

    var
        //  RequestXml: Record TempBlob temporary;
        RequestXml: Codeunit "Temp Blob"; //BC Upgrade GUNREM01 Replaced record
        MessageOutStream: OutStream;
        MessageInStream: InStream;
        // RequestXmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        RequestXmlDocument: XmlDocument; //BC Upgrade GUNREM01 Replaced Dotnet
        APIInterfaceLog: Record "API Interface Log2 INT";
        //  XmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        XmlNode: XmlNode; //BC Upgrade GUNREM01 Replaced Dotnet
        ErrorOutStream: OutStream;
        // ResponseXmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXmlDocument: XmlDocument; //BC Upgrade GUNREM01 Replaced Dotnet
        LastErrorMsg: Text;
        MissingNodeErr: Label '%1 node missing from XML';
        TextMissingErr: Label 'Text missing for node %1 in XML';
        ErrorMsg: Label 'Error Code: %1, Error Text: %2, Call Stack Trace: %3';
        LastPostingErrorMsg: Text;
        ResponsetXml: Codeunit "Temp Blob";//BC Upgrade VAMSIU01
        InvaildValueErr: Label 'Invalid value for %1';
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        LastErrorOutStream: OutStream;

    procedure SendAPIPayments(var Request: BigText);
    var
        //BC Upgrade VAMSIU01 >>
        RequestInStream: InStream;
        RequestOutStream: OutStream;
        ResponseInStream: InStream;
        ResponseOutStream: OutStream;
        //BC Upgrade VAMSIU01 <<
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
    begin
        //BC Upgrade GUNREM01 >>
        // RequestXml.Blob.CREATEOUTSTREAM(MessageOutStream);
        // Request.WRITE(MessageOutStream);
        // RequestXml.Blob.CREATEINSTREAM(MessageInStream);
        RequestXml.CREATEOUTSTREAM(MessageOutStream);
        Request.WRITE(MessageOutStream);
        RequestXml.CREATEINSTREAM(MessageInStream);
        //BC Upgrade GUNREM01 >>

        if TryLoadXML(Request) then begin
            APIInterfaceLog.INIT();
            if CheckMandatoryProcessingNodes() then begin
                APIInterfaceLog.INSERT();
                //BC Upgrade VAMSIU01 >>
                RequestXml.CreateInStream(RequestInStream);
                APIInterfaceLog."Request File".CreateOutStream(RequestOutStream);
                CopyStream(RequestOutStream, RequestInStream);
                APIInterfaceLog.MODIFY();
                //BC Upgrade VAMSIU01 <<
                COMMIT();
                if CODEUNIT.RUN(CODEUNIT::"API Payment Interface Mgmt.", APIInterfaceLog) then begin
                    APIInterfaceLog.FIND();
                    APIInterfaceLog.Status := APIInterfaceLog.Status::Processed;
                    //BC Upgrade VAMSIU01 >>
                    ResponsetXml.CreateInStream(ResponseInStream);
                    APIInterfaceLog."Response File".CreateOutStream(ResponseOutStream);
                    CopyStream(ResponseOutStream, ResponseInStream);
                    //APIInterfaceLog2."Response File" := ResponsetXml.Blob;
                    //BC Upgrade VAMSIU01 <<

                    APIInterfaceLog.MODIFY();

                    //HEI.02>>
                    COMMIT();
                    if SourceSystemIdentifierAPI.GET(APIInterfaceLog."Source System Identifier") and
                      (SourceSystemIdentifierAPI."Automatic Payment Posting")
                    then
                        if CODEUNIT.RUN(CODEUNIT::"Auto Posting API Interfaces", APIInterfaceLog) then begin
                            APIInterfaceLog.FIND();
                            if not (APIInterfaceLog."Posting Status" = APIInterfaceLog."Posting Status"::Error) then begin
                                APIInterfaceLog."Posting Status" := APIInterfaceLog."Posting Status"::Processed;
                                APIInterfaceLog.MODIFY();
                            end;
                        end else begin
                            APIInterfaceLog.FIND();
                            LastPostingErrorMsg := STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK);
                            APIInterfaceLog."Posting Status" := APIInterfaceLog."Posting Status"::Error;
                            APIInterfaceLog."Posting Error Message".CREATEOUTSTREAM(LastErrorOutStream);
                            LastErrorOutStream.WRITETEXT(LastPostingErrorMsg);
                            APIInterfaceLog.MODIFY();
                        end;
                    //HEI.02<<
                end else begin
                    APIInterfaceLog.FIND();
                    LastErrorMsg := STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK);
                    APIInterfaceLog.Status := APIInterfaceLog.Status::Error;
                    APIInterfaceLog."Error Message".CREATEOUTSTREAM(ErrorOutStream);
                    ErrorOutStream.WRITETEXT(LastErrorMsg);
                    APIInterfaceLog.MODIFY();
                end;
            end;
        end;

        //HEI.03>>
        CLEAR(RequestXmlDocument);
        CLEAR(XmlNode);
        CLEAR(ResponseXmlDocument);
        //HEI.03<<
        //HEI.04>>
        CLEAR(MessageOutStream);
        CLEAR(MessageInStream);
        CLEAR(ErrorOutStream);
        CLEAR(LastErrorOutStream);
        //HEI.04<<
    end;

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

    [TryFunction]
    local procedure CheckMandatoryProcessingNodes();
    var
        APIInterfaceSetup: Record "API Interface Setup2 INT";
        InterfaceSetup: Record "Interface Setup INT";
        Outstrm: OutStream;
        Instrm: InStream;
        XMLDOC: XmlDocument;
        RequestInStream: InStream;
        RequestOutStream: OutStream;

    begin
        GetNodeByXPath('/Payments', 'Payments');
        GetNodeByXPath('/Payments/Payment', 'Payment');

        APIInterfaceLog."Request Sync. Date/Time" := CURRENTDATETIME;
        //BC Upgrade VAMSIU01 >>
        RequestXml.CreateInStream(RequestInStream);
        APIInterfaceLog."Request File".CreateOutStream(RequestOutStream);
        CopyStream(RequestOutStream, RequestInStream);

        //BC Upgrade VAMSIU01 <<
        APIInterfaceLog.Entity := 'PAYMENT';
        APIInterfaceLog.Operation := 'CREATE';
        APIInterfaceLog."Source Type" := 81;
        APIInterfaceLog."Processing Codeunit" := Codeunit::"API Payment Interface Mgmt.";

        APIInterfaceSetup.GET();
        APIInterfaceSetup.TESTFIELD("API Payment Interface");
        APIInterfaceLog."Interface Code" := APIInterfaceSetup."API Payment Interface";
        InterfaceSetup.GET(APIInterfaceSetup."API Payment Interface");
        InterfaceSetup.TESTFIELD(Enabled, true);
        APIInterfaceLog."Call Type" := APIInterfaceLog."Call Type"::Synchronous;
    end;

    local procedure GetNodeByXPath(XPath: Text; NodeName: Text);

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

