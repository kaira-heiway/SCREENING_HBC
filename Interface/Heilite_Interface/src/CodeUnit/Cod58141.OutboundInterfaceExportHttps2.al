codeunit 58141 "OutboundInterfaceExport_Http2"
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
        ReqOutStream: OutStream;
        ReqInStream: InStream;
        SourceInStream: InStream;
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        SendRequestTime: DateTime;
        GetResponseTime: DateTime;
        lastendpoint: Text[500];
        SecretpasswordText: SecretText;

        HttpClient: HttpClient;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        HttpContent: HttpContent;
        Headers: HttpHeaders;
        ContentHeaders: HttpHeaders;
        AuthString: Text;
        Base64Convert: Codeunit "Base64 Convert";
        ResponseText: Text;
        FullResponseText: Text;
        HeaderNames: List of [Text];
        HeaderValues: List of [Text];
        HeaderName: Text;
        HeaderValue: Text;
        i: Integer;
        TypeHelper: Codeunit "Type Helper";
        FileContentText: Text;

    begin
        DataExch.CalcFields("File Content");

        Clear(SendRequestTime);
        Clear(GetResponseTime);
        Clear(TempBlob);

        TempBlob.CreateOutStream(ReqOutStream);
        DataExch."File Content".CreateInStream(SourceInStream);
        CopyStream(ReqOutStream, SourceInStream);

        TempBlob.CreateInStream(ReqInStream);

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        Clear(lastendpoint);
        Clear(SecretpasswordText);
        lastendpoint := OutboundInterface.Endpoint + OutboundInterface."Endpoint 2";
        SecretpasswordText := OutboundInterface."New Password Text";

        AuthString := Base64Convert.ToBase64(OutboundInterface."User ID" + ':' + Format(OutboundInterface."New Password Text"));

        HttpRequest.Method := 'POST';
        HttpRequest.SetRequestUri(lastendpoint);

        HttpRequest.GetHeaders(Headers);
        Headers.Add('Authorization', 'Basic ' + AuthString);
        Headers.Add('SOAPAction', OutboundInterface."SOAP Action");

        HttpContent.WriteFrom(ReqInStream);
        HttpContent.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'text/xml; charset=utf-8');

        HttpRequest.Content := HttpContent;

        SendRequestTime := CurrentDateTime;
        HttpClient.Send(HttpRequest, HttpResponse);
        GetResponseTime := CurrentDateTime;

        HttpResponse.Content.ReadAs(ResponseText);

        FullResponseText := StrSubstNo('HTTP/1.1 %1 %2', Format(HttpResponse.HttpStatusCode), HttpResponse.ReasonPhrase);
        FullResponseText += TypeHelper.CRLFSeparator();


        Headers := HttpResponse.Headers();
        HeaderNames := Headers.Keys();
        for i := 1 to HeaderNames.Count do begin
            HeaderName := HeaderNames.Get(i);
            Clear(HeaderValues);
            Headers.GetValues(HeaderName, HeaderValues);
            foreach HeaderValue in HeaderValues do
                FullResponseText += StrSubstNo('%1: %2', HeaderName, HeaderValue) + TypeHelper.CRLFSeparator();
        end;

        HttpResponse.Content.GetHeaders(ContentHeaders);
        HeaderNames := ContentHeaders.Keys();
        for i := 1 to HeaderNames.Count do begin
            HeaderName := HeaderNames.Get(i);
            Clear(HeaderValues);
            ContentHeaders.GetValues(HeaderName, HeaderValues);
            foreach HeaderValue in HeaderValues do
                FullResponseText += StrSubstNo('%1: %2', HeaderName, HeaderValue) + TypeHelper.CRLFSeparator();
        end;

        FullResponseText += TypeHelper.CRLFSeparator() + ResponseText;

        if not HttpResponse.IsSuccessStatusCode then
            Error('Error: %1 - %2', HttpResponse.HttpStatusCode, FullResponseText);

        Message('Response: %1', FullResponseText);

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

