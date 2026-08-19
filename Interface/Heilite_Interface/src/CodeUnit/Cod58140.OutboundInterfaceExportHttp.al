codeunit 58140 "OutboundInterfaceExport_Http"
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

        HttpClient: HttpClient;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        HttpContent: HttpContent;
        Headers: HttpHeaders;
        AuthString: Text;
        Base64Convert: Codeunit "Base64 Convert";
        ResponseText: Text;
        StatusCode: Integer;
        RequestBodyText: Text;
        AuthHeaderValues: List of [Text];
        AuthHeaderText: Text;

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

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        Clear(lastendpoint);
        Clear(SecretpasswordText); //BC Upgrade VAMSIU01 - Added >>
        lastendpoint := OutboundInterface.Endpoint + OutboundInterface."Endpoint 2";
        SecretpasswordText := OutboundInterface."New Password Text"; //BC Upgrade VAMSIU01 - Added >>

        // STEP 1: Set HTTP AUTHORIZATION HEADER
        AuthString := Base64Convert.ToBase64(OutboundInterface."User ID" + ':' + Format(OutboundInterface."New Password Text"));

        // STEP 2: Prepare HTTP Request
        HttpRequest.Method := 'POST';
        HttpRequest.SetRequestUri(lastendpoint);

        // Headers
        HttpRequest.GetHeaders(Headers);
        Headers.Add('Authorization', 'Basic ' + AuthString);
        Headers.Add('SOAPAction', OutboundInterface."SOAP Action");

        // STEP 3: Attach BODY (SOAP XML)
        HttpContent.WriteFrom(ReqInStream);
        HttpContent.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'text/xml; charset=utf-8');

        HttpRequest.Content := HttpContent;

        // STEP 4: Read & display Authorization header + request body before sending
        HttpRequest.Content.ReadAs(RequestBodyText);

        HttpRequest.GetHeaders(Headers);
        if Headers.GetValues('Authorization', AuthHeaderValues) then
            AuthHeaderText := AuthHeaderValues.Get(1)
        else
            AuthHeaderText := '(not set)';

        //BC Upgrade VAMSIU01 - Blocked the Messagees >>
        // Message('Authorization Header : %1\n\nRequest Body (first 500 chars):\n%2', AuthHeaderText,
        //     CopyStr(RequestBodyText, 1, 500));
        //BC Upgrade VAMSIU01 - Blocked the Messagees <<

        // STEP 5: Send Request
        SendRequestTime := CurrentDateTime;

        //HttpClient.Timeout := 4700000;
        HttpClient.Send(HttpRequest, HttpResponse);

        GetResponseTime := CurrentDateTime;

        // STEP 5: Read Response
        HttpResponse.Content.ReadAs(ResponseText);
        StatusCode := HttpResponse.HttpStatusCode;

        if not HttpResponse.IsSuccessStatusCode then
            Error('Error: %1 - %2', HttpResponse.HttpStatusCode, ResponseText);

        // Optional Logging
        if GuiAllowed then
            Message('Success — Status Code: %1\nResponse: %2', StatusCode, ResponseText);


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
