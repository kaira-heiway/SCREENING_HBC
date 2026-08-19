codeunit 58038 "Outbound Interface Export VIP"
{
    // Heilite Navision Old Id - 50155

    // version HEI.02,FM

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New codeunit for Interface Common Framework
    // HEI.02 S&OP 11.12.2018 POSTOI01 IBM New line in SendDataToWS
    // HEI.03 CHG2095187 IBM SAXENA03 18.02.2021
    //   # Code written for Paraller Request
    //   # Created a new Object to Replace Data Exch. Table with Data Exch. VIP, Replica of CodeUnit 50005
    // HEI.04 CHG2112261 IBM SAXENA03 20.05.2021
    //   # Interface Logging processing Execution Time and Webservices Response Times
    //   # Added Code to update Send request and Get Response field of table 50161 in Function SendDataToWS()

    Permissions = TableData "Data Exch." = rimd;
    //BC Upgrade VAMSIU01 >>
    // TableData "Service Password"=r;
    TableNo = "Data Exch.";
    //BC Upgrade VAMSIU01 <<

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
            //SendDataToWS(Rec, InterfaceSetup);//BC Upgrade VAMSIU01
            SendDataToWSCloud(Rec, InterfaceSetup);//BC Upgrade VAMSIU01
    end;

    var
        ExternalContentErr: Label '%1 is empty.';
        DownloadFromStreamErr: Label 'The file has not been saved.';

    //BC Upgrade VAMSIU01 Changed from Data Exch VIP to Data Exch. in SendDataToWS>>
    [TryFunction]
    local procedure SendDataToWS(DataExchVIP: Record "Data Exch."; InterfaceSetup: Record "Interface Setup INT");
    var
        OutboundInterface: Record "Outbound Interface INT";
        TempBlob: Codeunit "Temp Blob";//BC Upgrade VAMSIU01
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        WebServReqMgt: Codeunit "SOAP Web Service Request Mgt.";
        // RequestXmlDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // ResultXmlDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // ResponseXmlDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // XmlNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";
        // XmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        ReqOutStream: OutStream;
        ReqInStream: InStream;
        RespInStream: InStream;
        URL: Text;
        UserName: Text;
        Password: Text;
        SendRequestTime: DateTime;
        GetResponseTime: DateTime;
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
    begin
        DataExchVIP.CALCFIELDS("File Content");

        CLEAR(TempBlob);
        //<<HEI.04
        CLEAR(SendRequestTime);
        CLEAR(GetResponseTime);
        //>>HEI.04
        // TempBlob.Blob.CREATEOUTSTREAM(ReqOutStream);
        // TempBlob.Blob := DataExchVIP."File Content";
        // TempBlob.Blob.CREATEINSTREAM(ReqInStream);

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        // run the WebServReqMgt functions to send the request
        // WebServReqMgt.SetGlobals2(
        //   ReqInStream,
        //   OutboundInterface.Endpoint + OutboundInterface."Endpoint 2",
        //   OutboundInterface."User ID",
        //   OutboundInterface.GetPassword,
        //   OutboundInterface."SOAP Action");
        WebServReqMgt.DisableHttpsCheck;
        //HEI.02>>
        WebServReqMgt.SetTimeout(4700000);
        //HEI.02<<

        //<<HEI.04
        //WebServReqMgt.SendRequestToWebService2;
        SendRequestTime := CURRENTDATETIME;
        // WebServReqMgt.SendRequestToWebService2;
        GetResponseTime := CURRENTDATETIME;
        if InterfaceEntryHeaderVIP.GET(DataExchVIP."Interface Entry Header No. FND") then begin
            InterfaceEntryHeaderVIP."Send Request" := SendRequestTime;
            InterfaceEntryHeaderVIP."Get Response" := GetResponseTime;
            InterfaceEntryHeaderVIP.MODIFY;
        end;
        //>>HEI.04
    end;

    //BC Upgrade VAMSIU01 Changed from Data Exch VIP to Data Exch. in CreateExportFile>>
    procedure CreateExportFile(DataExchVIP: Record "Data Exch."; ShowDialog: Boolean);
    var
        TempBlob: Codeunit "Temp Blob";
        FileMgt: Codeunit "File Management";
        ExportFileName: Text;
    begin
        DataExchVIP.CALCFIELDS("File Content");
        if not DataExchVIP."File Content".HASVALUE then
            ERROR(ExternalContentErr, DataExchVIP.FIELDCAPTION("File Content"));

        //TempBlob.Blob := DataExchVIP."File Content";
        ExportFileName := DataExchVIP."Data Exch. Def Code" + FORMAT(TODAY, 0, '<Month,2><Day,2><Year4>') + '.xml';
        if FileMgt.BLOBExport(TempBlob, ExportFileName, ShowDialog) = '' then
            ERROR(DownloadFromStreamErr);
    end;
    //BC Upgrade VAMSIU01 start>>
    //BC Upgrade VAMSIU01 Changed from Data Exch VIP to Data Exch. in CreateExportFile>>
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
    //BC Upgrade VAMSIU01 end<<
}

