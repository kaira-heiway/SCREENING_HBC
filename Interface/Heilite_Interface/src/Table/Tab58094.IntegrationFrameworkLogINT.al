table 58094 "Integration Framework Log INT"
{
    // version HEI.04

    // HEI.01 CHG2084921 IBM KUMARN15 29.10.2020
    //   # New table created
    // HEI.02 FDD-HB1281 - CHG2056937 IBM NASTAA02 12.04.2021 # B2B Pricing Interface
    //   # New Field created: 120 - Response File
    //                        121 - Response Date/Time
    //   # New Functions created: "ShowResponse", "SendMessage" and "SendDataToWS"
    // HEI.03 HB2427 - CHG2121928 IBM NASTAA02 20.11.2021 # B2B Invoice API
    //   # Field 'Display Error' should be cleared when reprocess is successfully
    //   # New Field created: 10 - Source No.
    // HEI.04 CHG2199256 IBM COSTES04 03.04.2023 B2B-Pricing Interface sending zero pricing
    //   # Skip confirmation when running by job queue

    // BC Upgrade SHUKLP03 >>
    // Nav old ID- 50200
    // Replaced Temp blob table with codeunit also modified code of procedures ShowError(), ShowRequest(), ShowResponse() and SendDataToWS().
    // BC Upgrade SHUKLP03 <<

    // BC Upgrade PATELS08 >>
    // # In procedure SendDataToWS, created variable 'PasswordAsSecretText', refactored WebServReqMgt.SetGlobals call to align with the procedure signature by replacing the obsolete password parameter type with SecretText, resolving deprecation warning.
    // BC Upgrade PATELS08 <<

    Caption = 'Integration Framework Log';

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No';
        }
        field(2; "Interface Code"; Code[20])
        {
            Caption = 'Interface Code';
            TableRelation = "Interface Setup INT";
        }
        field(3; "Request Sync. Date/Time"; DateTime)
        {
            Caption = 'Request Sync. Date/Time';
        }
        field(4; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Pending,Error,Processed';
            OptionMembers = Pending,Error,Processed;
        }
        field(10; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(101; "Error Message"; BLOB)
        {
            Caption = 'Error Message';
        }
        field(102; "Request File"; BLOB)
        {
            Caption = 'Request File';
        }
        field(103; "Display Error"; Text[250])
        {
        }
        field(120; "Response File"; BLOB)
        {
            Caption = 'Response File';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(121; "Response Date/Time"; DateTime)
        {
            Caption = 'Response Date/Time';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(201; "Processing Codeunit"; Integer)
        {
            Caption = 'Processing Codeunit';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Codeunit));
        }
        field(202; "Call Type"; Option)
        {
            Caption = 'Call Type';
            OptionCaption = 'Synchronous,Asynchronous';
            OptionMembers = Synchronous,Asynchronous;
        }
        field(203; "Job Queue Category Code"; Code[10])
        {
            Caption = 'Job Queue Category Code';
            TableRelation = "Job Queue Category";
        }
        field(204; "Job Queue Entry ID"; Guid)
        {
            Caption = 'Job Queue Entry ID';
        }
    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        //TempBlob: Record TempBlob temporary; // BC Upgrade SHUKLP03 << Deprecated.
        TempBlob: Codeunit "Temp Blob"; // BC Upgrade SHUKLP03 <<
        FileManagement: Codeunit "File Management";
        ErrorMsg: Label 'Error Code: %1, Error Text: %2, Call Stack Trace: %3.';
        ProcessLastEntryConf: Label 'This is not the last Entry Log. Do you want to proceed?';

    procedure ShowError();
    var
        ReqOutStream: OutStream;
        ReqInStream: InStream;
        SrcInStream: InStream;
        Filename: Text[50];
    begin
        TESTFIELD(Status, Status::Error);
        CALCFIELDS("Error Message");
        if "Error Message".HASVALUE then begin
            // BC Upgrade SHUKLP03 >>
            TempBlob.CreateOutStream(ReqOutStream);
            "Error Message".CreateInStream(SrcInStream);
            CopyStream(ReqOutStream, SrcInStream);
            TempBlob.CreateInStream(ReqInStream);
            Filename := 'ErrorMessage.txt';
            DownloadFromStream(ReqInStream, 'Download error log', '', 'Text Files (*.txt)|*.txt', Filename);// BC Upgrade SHUKLP03 << FileManagement code Replaced with new code.
            // BC Upgrade SHUKLP03 << 
            //TempBlob.Blob := "Error Message"; // BC Upgrade SHUKLP03 << Blocked replaced with new code.
            //FileManagement.BLOBExport(TempBlob, 'ErrorMessage.txt', true); // BC Upgrade SHUKLP03 << Blocked replaced with new code.
        end;
    end;

    procedure ShowRequest();
    var
        ReqOutStream: OutStream;
        ReqInStream: InStream;
        SrcInStream: InStream;
        Filename: Text[50];

    begin
        CALCFIELDS("Request File");
        if "Request File".HASVALUE then begin
            // BC Upgrade SHUKLP03 >>
            TempBlob.CreateOutStream(ReqOutStream);
            "Request File".CreateInStream(SrcInStream);
            CopyStream(ReqOutStream, SrcInStream);
            TempBlob.CreateInStream(ReqInStream);
            Filename := 'RequestXML.xml';
            DownloadFromStream(ReqInStream, 'Download error log', '', 'Text Files (*.txt)|*.txt', Filename);// BC Upgrade SHUKLP03 << FileManagement code Replaced with new code.
            // BC Upgrade SHUKLP03 << 
            //TempBlob.Blob := "Request File"; // BC Upgrade SHUKLP03 << Blocked replaced with new code.
            //FileManagement.BLOBExport(TempBlob, 'RequestXML.xml', true); // BC Upgrade SHUKLP03 << Blocked replaced with new code.
        end;
    end;

    procedure ShowResponse();
    var
        ReqOutStream: OutStream;
        ReqInStream: InStream;
        SrcInStream: InStream;
        Filename: Text[50];
    begin
        //HEI.02>>
        CALCFIELDS("Response File");
        if "Response File".HASVALUE then begin
            // BC Upgrade SHUKLP03 >>
            TempBlob.CreateOutStream(ReqOutStream);
            "Response File".CreateInStream(SrcInStream);
            CopyStream(ReqOutStream, SrcInStream);
            TempBlob.CreateInStream(ReqInStream);
            Filename := 'ResponseXML.xml';
            DownloadFromStream(ReqInStream, 'Download error log', '', 'Text Files (*.txt)|*.txt', Filename);// BC Upgrade SHUKLP03 << FileManagement code Replaced with new code.
            // BC Upgrade SHUKLP03 << 

            //TempBlob.Blob := "Response File"; // BC Upgrade SHUKLP03 << Blocked replaced with new code.
            //FileManagement.BLOBExport(TempBlob, 'ResponseXML.xml', true); // BC Upgrade SHUKLP03 << Blocked replaced with new code.
        end;
        //HEI.02<<
    end;

    procedure SendMessage();
    var
        InterfaceSetup: Record "Interface Setup INT";
        ErrorOStream: OutStream;
        IntegrationFrameworkLog: Record "Integration Framework Log INT";
        IntegrationFrameworkLog2: Record "Integration Framework Log INT";
    begin
        //HEI.02>>
        if not InterfaceSetup.GET("Interface Code") then
            exit;

        if InterfaceSetup.Direction <> InterfaceSetup.Direction::Outbound then
            exit;

        if GUIALLOWED then//HEI.04
            if IntegrationFrameworkLog.FINDLAST() then
                if IntegrationFrameworkLog."Entry No" <> "Entry No" then
                    if not CONFIRM(ProcessLastEntryConf) then
                        ERROR('');

        if "Response File".HASVALUE then
            if SendDataToWS() then begin
                Status := Status::Processed;
                //HEI.03>>
                if "Display Error" <> '' then
                    "Display Error" := '';
                //HEI.03<<
                MODIFY(true);
            end else begin
                Status := Status::Error;
                "Error Message".CREATEOUTSTREAM(ErrorOStream);
                ErrorOStream.WRITETEXT(STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK));
                "Display Error" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                MODIFY();
            end;
        //HEI.02<<
    end;

    [TryFunction]
    local procedure SendDataToWS();
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        //TempBlob: Record TempBlob temporary;  // BC upgrade SHUKLP03 << Blocked
        TempBlobLocal: Codeunit "Temp Blob";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        WebServReqMgt: Codeunit "SOAP Web Service Request Mgt.";

        // BC Upgrade SHUKLP03 >> We are blocking DotNet variables for now.
        // RequestXmlDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // ResultXmlDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // ResponseXmlDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // XmlNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";
        // XmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // BC Upgrade SHUKLP03 << We are blocking DotNet variables for now.

        ReqOutStream: OutStream;
        ReqInStream: InStream;
        RespInStream: InStream;
        URL: Text;
        UserName: Text;
        Password: Text;
        SrcInStream: InStream; // BC Upgrade SHUKLP03 <<

        // BC Upgrade PATELS08 >>
        PasswordAsSecretText: SecretText;
        // BC Upgrade PATELS08 <<
        lastendpoint: Text[500]; //BC Upgrade VAMSIU01 >>
    begin
        //HEI.02>>
        if not InterfaceSetup.GET("Interface Code") then
            exit;

        CALCFIELDS("Response File");

        CLEAR(TempBlobLocal);
        // BC Upgrade SHUKLP03 >> Blocked because deprecated.
        // TempBlob.Blob.CREATEOUTSTREAM(ReqOutStream);
        // TempBlob.Blob := "Response File";
        // TempBlob.Blob.CREATEINSTREAM(ReqInStream);
        // BC Upgrade SHUKLP03 << Blocked because deprecated.

        // BC Upgrade SHUKLP03 >> Modified code.
        TempBlobLocal.CreateOutStream(ReqOutStream);
        "Response File".CreateInStream(SrcInStream);
        CopyStream(ReqOutStream, SrcInStream);

        TempBlobLocal.CreateInStream(ReqInStream);
        // BC Upgrade SHUKLP03 << Modified code.

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        // WebServReqMgt.SetGlobals(
        //   ReqInStream,
        //   OutboundInterface.Endpoint + OutboundInterface."Endpoint 2",
        //   OutboundInterface."User ID",
        //   OutboundInterface.GetPassword,
        //   OutboundInterface."SOAP Action");  // BC Upgrade SHUKLP03 << Blocking this procedure because discussed with Sakshi we need to take base procedure instead of custom.

        // BC Upgrade PATELS08 >> Refactored WebServReqMgt.SetGlobals call to align with the procedure signature by replacing the obsolete password parameter type with SecretText, resolving deprecation warning.
        // WebServReqMgt.SetGlobals(ReqInStream, OutboundInterface.Endpoint + OutboundInterface."Endpoint 2", OutboundInterface."User ID", OutboundInterface."Password Key");  // BC Upgrade SHUKLP03 <<
        // PasswordAsSecretText := OutboundInterface."Password Key".ToText();

        //BC Upgrade VAMSIU01 >>
        Clear(lastendpoint);
        Clear(PasswordAsSecretText);
        lastendpoint := OutboundInterface.Endpoint + OutboundInterface."Endpoint 2";

        WebServReqMgt.SetContentType('text/xml;charset=utf-8');
        PasswordAsSecretText := OutboundInterface."New Password Text";
        //Message('Password %1', OutboundInterface."New Password Text");
        //BC Upgrade VAMSIU01 <<

        WebServReqMgt.SetGlobals(ReqInStream, OutboundInterface.Endpoint + OutboundInterface."Endpoint 2", OutboundInterface."User ID", PasswordAsSecretText);  // BC Upgrade SHUKLP03 <<
        // BC Upgrade PATELS08 <<

        WebServReqMgt.DisableHttpsCheck();
        WebServReqMgt.SetTimeout(4700000);
        //WebServReqMgt.SendRequestToWebService2; // BC Upgrade SHUKLP03 << Blocking this procedure because discussed with Sakshi we need to take base procedure instead of custom.
        WebServReqMgt.SendRequestToWebService(); // BC Upgrade SHUKLP03 << 
        //HEI.02<<
    end;
}

