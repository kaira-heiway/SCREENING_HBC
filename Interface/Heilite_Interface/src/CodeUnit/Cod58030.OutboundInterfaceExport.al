codeunit 58030 "Outbound Interface Export"
{
    // Heilite Navision Old Id - 50005

    // version HEI.02,FM

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New codeunit for Interface Common Framework
    // HEI.02 S&OP 11.12.2018 POSTOI01 IBM New line in SendDataToWS
    // HEI.03 CHG2112261 IBM SAXENA03 20.05.2021
    //   # Interface Logging processing Execution Time and Webservices Response Times
    //   # Added Code to update Send request and Get Response field of table 50001 in Function SendDataToWS()

    Permissions = TableData "Data Exch." = rimd;
    //TableData "Service Password" = r; //BC Upgrade VAMSIU01
    TableNo = "Data Exch.";

    trigger OnRun();
    var
        InterfaceSetup: Record "Interface Setup INT";
        RecRef: RecordRef;
    begin
        //CreateExportFile(Rec,TRUE);

        RecRef.GET(Rec."Related Record");
        RecRef.SETTABLE(InterfaceSetup);
        InterfaceSetup.FIND;

        if InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous then
            SendDataToWSCloud(Rec, InterfaceSetup);//BC Upgrade VAMSIU01 - Added new procedure
        // SendDataToWS(Rec, InterfaceSetup);BC Upgrade VAMSIU01 - Commented old procedure
    end;


    var
        ExternalContentErr: Label '%1 is empty.';
        DownloadFromStreamErr: Label 'The file has not been saved.';

    [TryFunction]
    local procedure SendDataToWS(DataExch: Record "Data Exch."; InterfaceSetup: Record "Interface Setup INT");
    var
        OutboundInterface: Record "Outbound Interface INT";
        TempBlob: Codeunit "Temp Blob";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        WebServReqMgt: Codeunit "SOAP Web Service Request Mgt.";
        //RequestXmlDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";  //BC Upgrade NANDIS03
        RequestXmlDoc: XmlDocument;  //BC Upgrade NANDIS03
        //ResultXmlDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";  //BC Upgrade NANDIS03
        ResultXmlDoc: XmlDocument;  //BC Upgrade NANDIS03
        //ResponseXmlDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";  //BC Upgrade NANDIS03
        ResponseXmlDoc: XmlDocument;  //BC Upgrade NANDIS03
        //XmlNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";  //BC Upgrade NANDIS03
        XmlNodeList: XmlNodeList;  //BC Upgrade NANDIS03
        //XmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";  //BC Upgrade NANDIS03
        XmlNode: XmlNode;  //BC Upgrade NANDIS03
        ReqOutStream: OutStream;
        ReqInStream: InStream;
        RespInStream: InStream;
        URL: Text;
        UserName: Text;
        Password: Text;
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        SendRequestTime: DateTime;
        GetResponseTime: DateTime;
        PasswordSecret: SecretText; // BC FR Upgrade KAIRAR01 -Version 28.1.49322.0 Compatibility Fix
    begin
        DataExch.CALCFIELDS("File Content");

        //<<HEI.03
        CLEAR(SendRequestTime);
        CLEAR(GetResponseTime);
        //>>HEI.03
        CLEAR(TempBlob);
        TempBlob.CREATEOUTSTREAM(ReqOutStream);
        //TempBlob.Blob := DataExch."File Content";  // BC Upgrade NANDIS03
        TempBlob.CREATEINSTREAM(ReqInStream);

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        // run the WebServReqMgt functions to send the request
        //WebServReqMgt.SetGlobals2(ReqInStream,OutboundInterface.Endpoint + OutboundInterface."Endpoint 2",OutboundInterface."User ID",
        //  OutboundInterface.GetPassword,OutboundInterface."SOAP Action");  // BC Upgrade NANDIS03
        // BC FR Upgrade KAIRAR01 -Version 28.1.49322.0 Compatibility Fix >>
        // WebServReqMgt.SetGlobals(ReqInStream, OutboundInterface.Endpoint + OutboundInterface."Endpoint 2", OutboundInterface."User ID", OutboundInterface."Password Key");  // BC Upgrade NANDIS03
        PasswordSecret := OutboundInterface."New Password Text";
        WebServReqMgt.SetGlobals(ReqInStream, OutboundInterface.Endpoint + OutboundInterface."Endpoint 2", OutboundInterface."User ID", PasswordSecret);
        // BC FR Upgrade KAIRAR01 -Version 28.1.49322.0 Compatibility Fix <<
        WebServReqMgt.DisableHttpsCheck;
        //HEI.02>>
        WebServReqMgt.SetTimeout(4700000);
        //HEI.02<<

        //<<HEI.03
        //WebServReqMgt.SendRequestToWebService2;
        SendRequestTime := CURRENTDATETIME;
        //WebServReqMgt.SendRequestToWebService2;  // BC Upgrade NANDIS03

        WebServReqMgt.SendRequestToWebService;  // BC Upgrade NANDIS03
        GetResponseTime := CURRENTDATETIME;
        if InterfaceEntryHeader.GET(DataExch."Interface Entry Header No. FND") then begin
            InterfaceEntryHeader."Send Request" := SendRequestTime;
            InterfaceEntryHeader."Get Response" := GetResponseTime;
            InterfaceEntryHeader.MODIFY(false);
        end;
        //>>HEI.03
    end;

    procedure CreateExportFile(DataExch: Record "Data Exch."; ShowDialog: Boolean);
    var
        //TempBlob: Record TempBlob; // BC Upgrade NANDIS03
        TempBlob: Codeunit "Temp Blob"; // BC Upgrade NANDIS03
        FileMgt: Codeunit "File Management";
        ExportFileName: Text;
    begin
        DataExch.CALCFIELDS("File Content");
        if not DataExch."File Content".HASVALUE then
            ERROR(ExternalContentErr, DataExch.FIELDCAPTION("File Content"));

        //TempBlob.Blob := DataExch."File Content";  // BC Upgrade NANDIS03
        ExportFileName := DataExch."Data Exch. Def Code" + FORMAT(TODAY, 0, '<Month,2><Day,2><Year4>') + '.xml';
        if FileMgt.BLOBExport(TempBlob, ExportFileName, ShowDialog) = '' then
            ERROR(DownloadFromStreamErr);
    end;
    //BC Upgrade VAMSIU01 start>>
    [TryFunction]
    procedure SendDataToWSCloud(DataExch: Record "Data Exch."; InterfaceSetup: Record "Interface Setup INT")
    var
        OutboundInterface: Record "Outbound Interface INT";
        TempBlob: Codeunit "Temp Blob";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        WebServReqMgt: Codeunit "SOAP Web Service Request Mgt.";
        ReqOutStream: OutStream;
        ReqInStream: InStream;
        SourceInStream: InStream;
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        SendRequestTime: DateTime;
        GetResponseTime: DateTime;
        lastendpoint: Text[500];
        InstrText: Text;
        SecretpasswordText: SecretText;//BC Upgrade VAMSIU01 - Added >>
    begin

        // Ensure File Content is loaded
        DataExch.CalcFields("File Content");

        Clear(SendRequestTime);
        Clear(GetResponseTime);
        Clear(TempBlob);

        //Copy DataExch XML into TempBlob
        TempBlob.CreateOutStream(ReqOutStream);
        DataExch."File Content".CreateInStream(SourceInStream);
        CopyStream(ReqOutStream, SourceInStream);

        //Create request InStream (NOW IT HAS DATA)
        TempBlob.CreateInStream(ReqInStream);
        //ReqInStream.ReadText(InstrText);//BC Upgrade VAMSIU01 - Blocked >>

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        Clear(lastendpoint);
        Clear(SecretpasswordText); //BC Upgrade VAMSIU01 - Added >>
        lastendpoint := OutboundInterface.Endpoint + OutboundInterface."Endpoint 2";
        SecretpasswordText := OutboundInterface."New Password Text"; //BC Upgrade VAMSIU01 - Added >>

        WebServReqMgt.SetContentType('text/xml;charset=utf-8');//BC Upgrade VAMSIU01 - Added >>

        //Set SOAP globals (request body is now set)
        //WebServReqMgt.SetGlobals(ReqInStream, lastendpoint, OutboundInterface."User ID", OutboundInterface."Password Key");//BC Upgrade VAMSIU01 - Blocked >>
        WebServReqMgt.SetGlobals(ReqInStream, lastendpoint, OutboundInterface."User ID", SecretpasswordText);//BC Upgrade VAMSIU01 - Added >>

        WebServReqMgt.DisableHttpsCheck;
        WebServReqMgt.SetTimeout(4700000);

        SendRequestTime := CurrentDateTime;
        WebServReqMgt.SetAction(OutboundInterface."SOAP Action");
        WebServReqMgt.SendRequestToWebService;
        GetResponseTime := CurrentDateTime;

        if InterfaceEntryHeader.Get(DataExch."Interface Entry Header No. FND") then begin
            InterfaceEntryHeader."Send Request" := SendRequestTime;
            InterfaceEntryHeader."Get Response" := GetResponseTime;
            InterfaceEntryHeader.Modify(false);
        end;
    end;

    local procedure AddSoapActionHeader(SoapAction: Text; var DotNet_HttpWebRequest: HttpClient);
    begin
        if (SoapAction = '') then
            exit;

    end;
    //BC Upgrade VAMSIU01 end<<
}

