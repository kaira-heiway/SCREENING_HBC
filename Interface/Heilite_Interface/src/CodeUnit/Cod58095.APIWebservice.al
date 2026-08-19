codeunit 58095 "API Webservice"
{
    //BC Upgrade VAMSIU01 >>
    // # Old Nav ID - 50140
    // # Created new procedures for TryLoadXML,CreateResponse,GetNodeByXPath,GetNodeByXPath2,CreateOrderStatusResponse,
    //   CreateResponseforPurchase,CreateOrderSimulationResponse
    // # Removed Dotnet Variables and Add replacement Datatypes.
    // # Blocked some code temporarily
    //BC Upgrade VAMSIU01 <<

    // version HEI.14

    // HEI.01 CHG2065153 IBM KUMARN15 23.06.2020
    //   # New codeunit created
    // HEI.02 FDD-HB899 - CHG2093015 IBM NASTAA02  15.01.2021 # LSR - Sales And Payments
    //   # New code added to 'ProcessMessage' function to enable the posting
    // HEI.03 FDD-HB1234 - CHG2053453 IBM NASTAA02 17.02.2021 # B2B Order Status
    //   # Code added to 'ProcessMessage' function to Validate the Status of API Interface Log
    //   # New API interface created: "ProcessOrderStatus"
    // HEI.04 FDD-HB2174 - CHG2104952 IBM NANDIS01 01.06.2021 # Raw & Pack interface HL-Ibecor
    //   # New Ibecor process to be used same mapping
    // HEI.05 INC4083000 - CHG2156647 IBM NASTAA02 03.05.2022 # NAS Service consuming high memory
    //   # Clear variables after Webservice call
    // HEI.06 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables
    // HEI.10 CHG2188870 DEBUSD01 03.02.2023 Sales Order API Performance change flow
    // HEI.11 CHG2188870 DEBUSD01 06.02.2023 Sales Order API Performance change flow
    //   # Remove field JobQueueEntry."Delete Log Entry on Success"
    // HEI.12 CHG2188870 DEBUSD01 08.02.2023 Sales Order API Performance change flow
    //   # Add default job queue category code for processing SO/SRO
    // HEI.07 CHG2167376 HB3082 NORRIQ KOROLA 11.11.2022
    //   # CreateResponseforPurchase - function modified
    // HEI.08 CHG2167376 HB3082 NORRIQ KOROLA 23.11.2022
    //   # CreateResponseforPurchase - function modified
    // HEI.09 CHG2167376 HB3082 IBM NANDIS01 01.02.2023 # Ibecor-HL Integration, adding Import license and inspection codes in POs
    //   # "License Required" and "Credit Info Required" will be going to Ibecor back depending on condition
    // HEI.13 CHG2174235 IBM COSTES04 20.03.2023 Interface Order Simulation
    //   # New functions CreateSalesSimulation
    // HEI.14 CHG2174235 IBM COSTES04 03.07.2023 Interface Order Simulation
    //   # Add Transport Tag
    //   # new function IsTransportItemCharge

    // BC Upgrade PATELP08>>
    // Changed name of table from "B2B Item Charges Inc./Exc." to "B2B Item Charges Inc./Exc. FND"
    // BC Upgrade PATELP08<<

    // BC Upgarde SHUKLP03 >> Unblocked some temp blocked code.	

    trigger OnRun();
    var
        BT: BigText;
    begin
    end;

    var
        //RequestXml : Record TempBlob temporary;//BC Upgrade VAMSIU01
        RequestXml: Codeunit "Temp Blob";//BC Upgrade VAMSIU01
        MessageOutStream: OutStream;
        MessageInStream: InStream;
        //RequestXmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";//BC Upgrade VAMSIU01
        RequestXmlDocument: XmlDocument;//BC Upgrade VAMSIU01
        InterfaceSetup: Record "Interface Setup INT";
        APIInterfaceSetup2: Record "API Interface Setup2 INT";
        APIInterfaceLog2: Record "API Interface Log2 INT";
        //XmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";//BC Upgrade VAMSIU01
        XmlNode: XmlNode;//BC Upgrade VAMSIU01
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        LastCodeStatusSkipErr: Label '#SKIPSTATUS#';
        MissingNodeErr: Label '%1 node missing from XML';
        TextMissingErr: Label 'Text missing for node %1 in XML';
        InvaildValueErr: Label 'Invalid value for %1';
        ErrorOutStream: OutStream;
        ErrorMsg: Label 'Error Code: %1, Error Text: %2, Call Stack Trace: %3';
        //ResponsetXml: Record TempBlob temporary;//BC Upgrade VAMSIU01
        ResponsetXml: Codeunit "Temp Blob";//BC Upgrade VAMSIU01
        //ResponseXmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXmlDocument: XmlDocument; //BC Upgrade VAMSIU01
        MessageResponseOutStream: OutStream;
        MessageResponseInStream: InStream;
        MessageRequestOutStream: OutStream;
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueProcessMsg: Label 'Process API Entry No. %1';
        LastErrorMsg: Text;
        LastPostingErrorMsg: Text;
        LastErrorOutStream: OutStream;
        NotExistingOrderErr: Label 'Order ID % was not sent from %2.';
        grec_GenInterfaceSetup: Record "General Interface Setup INT";
        grec_IbecorInterfaceSetup: Record "Ibecor Interface Setup INT";
        B2BInterfaceSetup: Record "B2B Interface Setup INT";
        B2BInterfaceSetupRead: Boolean;

    procedure ProcessMessage(var Message: BigText);
    var
        MsgId: Text;
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        RunNormalMode: Boolean;
        //BC Upgrade VAMSIU01 >>
        RequestInStream: InStream;
        RequestOutStream: OutStream;
        ResponseInStream: InStream;
        ResponseOutStream: OutStream;
    //BC Upgrade VAMSIU01 <<

    begin
        //BC Upgrade VAMSIU01 >>
        //RequestXml.Blob.CREATEOUTSTREAM(MessageOutStream);
        RequestXml.CreateOutStream(MessageOutStream);
        //BC Upgrade VAMSIU01 <<
        Message.WRITE(MessageOutStream);
        //BC Upgrade VAMSIU01 >>
        //RequestXml.Blob.CREATEINSTREAM(MessageInStream);
        RequestXml.CreateInStream(MessageInStream);
        //BC Upgrade VAMSIU01 <<
        if TryLoadXML(Message) then begin
            APIInterfaceLog2.INIT;
            if CheckForMandatoryProcessingNodes then begin
                APIInterfaceLog2.INSERT;
                //BC Upgrade VAMSIU01 >>
                RequestXml.CreateInStream(RequestInStream);
                APIInterfaceLog2."Request File".CreateOutStream(RequestOutStream);
                CopyStream(RequestOutStream, RequestInStream);
                APIInterfaceLog2.MODIFY;
                //BC Upgrade VAMSIU01 <<

                if APIInterfaceLog2."Call Type" = APIInterfaceLog2."Call Type"::Synchronous then begin
                    Commit();
                    //HEI.10>>
                    RunNormalMode := false;
                    SourceSystemIdentifierAPI.GET(APIInterfaceLog2."Source System Identifier");
                    if SourceSystemIdentifierAPI."Execute Checking" and (APIInterfaceLog2."Checking Codeunit" <> 0) then begin
                        //Synchronous with checking
                        if CODEUNIT.RUN(APIInterfaceLog2."Checking Codeunit", APIInterfaceLog2) then begin
                            APIInterfaceLog2.FIND;
                            CreateResponse(APIInterfaceLog2."Message ID", true, '');
                            APIInterfaceLog2.VALIDATE("Checking Status", APIInterfaceLog2."Checking Status"::Processed);

                            //BC Upgrade VAMSIU01 >>
                            ResponsetXml.CreateInStream(ResponseInStream);
                            APIInterfaceLog2."Response File".CreateOutStream(ResponseOutStream);
                            CopyStream(ResponseOutStream, ResponseInStream);
                            //APIInterfaceLog2."Response File" := ResponsetXml.Blob;
                            //BC Upgrade VAMSIU01 <<

                            APIInterfaceLog2."Response Sync. Date/Time" := CURRENTDATETIME;
                            APIInterfaceLog2.MODIFY;
                            // try process message
                            if (APIInterfaceLog2.Entity = 'SALES') and (APIInterfaceLog2.Operation = 'CREATE') then begin
                                JobQueueEntry.INIT;
                                JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
                                JobQueueEntry."Object ID to Run" := CODEUNIT::"Process Async. API";
                                JobQueueEntry."Record ID to Process" := APIInterfaceLog2.RECORDID;
                                JobQueueEntry.Description := STRSUBSTNO(JobQueueProcessMsg, APIInterfaceLog2."Entry No.");
                                //HEI.12>>
                                JobQueueEntry."Job Queue Category Code" := APIInterfaceSetup2."API Job Queue Category Code";
                                //HEI.12<<
                                if (APIInterfaceLog2."Source Subtype" = APIInterfaceLog2."Source Subtype"::"5") and (APIInterfaceSetup2."SRO AttemptDelay Process (sec)" <> -1) then
                                    JobQueueEntry."Earliest Start Date/Time" := (CURRENTDATETIME + (1000 * APIInterfaceSetup2."SRO AttemptDelay Process (sec)"));
                                if not ((APIInterfaceLog2."Source Subtype" = APIInterfaceLog2."Source Subtype"::"5") and (APIInterfaceSetup2."SRO AttemptDelay Process (sec)" = -1)) then begin
                                    CODEUNIT.RUN(CODEUNIT::"Job Queue - Enqueue", JobQueueEntry);
                                    APIInterfaceLog2."Job Queue Codeunit" := CODEUNIT::"Process Sales API";  //BC Upgrade VAMSIU01 - Blocked Temporarily
                                    APIInterfaceLog2."Job Queue Sync. Date/Time" := JobQueueEntry."Earliest Start Date/Time";
                                    APIInterfaceLog2."Job Queue Entry ID" := JobQueueEntry.ID;
                                    //HEI.12>>
                                    APIInterfaceLog2."Job Queue Category Code" := JobQueueEntry."Job Queue Category Code";
                                    //HEI.12<<
                                    APIInterfaceLog2.MODIFY;
                                end;
                            end else
                                //Synchronus other Entity and or Operation
                                RunNormalMode := true;
                        end else begin
                            //checking failed
                            APIInterfaceLog2.FIND;
                            if GETLASTERRORTEXT <> LastCodeStatusSkipErr then begin
                                LastErrorMsg := STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK);
                                //HEI.04>>
                                if APIInterfaceLog2.Entity = 'PURCHASE' then
                                    CreateResponseforPurchase(APIInterfaceLog2."Message ID", false, LastErrorMsg)
                                else
                                    //HEI.04<<
                                    CreateResponse(APIInterfaceLog2."Message ID", false, LastErrorMsg);
                                //HEI.03>>
                                APIInterfaceLog2.VALIDATE(Status, APIInterfaceLog2.Status::Error);
                                //HEI.03<<
                                APIInterfaceLog2.VALIDATE("Checking Status", APIInterfaceLog2."Checking Status"::Error);
                                APIInterfaceLog2."Error Message".CREATEOUTSTREAM(ErrorOutStream);
                                ErrorOutStream.WRITETEXT(LastErrorMsg);
                            end else begin
                                //no process api interface log pending status (SO error or missing, SRO will run later)
                                CLEARLASTERROR;
                                APIInterfaceLog2.VALIDATE("Checking Status", APIInterfaceLog2."Checking Status"::Processed);
                                APIInterfaceLog2.VALIDATE(Status, APIInterfaceLog2.Status::Pending);
                                CreateResponse(APIInterfaceLog2."Message ID", true, '');
                            end;
                            //BC Upgrade VAMSIU01 >>
                            //APIInterfaceLog2."Response File" := ResponsetXml.Blob; 
                            ResponsetXml.CreateInStream(ResponseInStream);
                            APIInterfaceLog2."Response File".CreateOutStream(ResponseOutStream);
                            CopyStream(ResponseOutStream, ResponseInStream);
                            //BC Upgrade VAMSIU01 <<

                            APIInterfaceLog2."Response Sync. Date/Time" := CURRENTDATETIME;
                            APIInterfaceLog2.MODIFY;
                        end;
                    end else
                        //synchronous without checking
                        RunNormalMode := true;

                    if RunNormalMode then begin
                        //HEI.10<<
                        if CODEUNIT.RUN(APIInterfaceLog2."Processing Codeunit", APIInterfaceLog2) then begin
                            // Processing succeed, Success response to be created and sent
                            APIInterfaceLog2.FIND;
                            //HEI.04>>
                            if APIInterfaceLog2.Entity = 'PURCHASE' then begin
                                if APIInterfaceLog2.Operation = 'REQINFO' then
                                    CreateResponseforPurchase(APIInterfaceLog2."Message ID", true, '')
                                else
                                    CreateResponse(APIInterfaceLog2."Message ID", true, '');
                            end else
                                //HEI.04<<
                                CreateResponse(APIInterfaceLog2."Message ID", true, '');
                            //HEI.03>>
                            //APIInterfaceLog2.Status := APIInterfaceLog2.Status::Processed;
                            APIInterfaceLog2.VALIDATE(Status, APIInterfaceLog2.Status::Processed);
                            //HEI.03<<

                            //BC Upgrade VAMSIU01 >>
                            //APIInterfaceLog2."Response File" := ResponsetXml.Blob;
                            ResponsetXml.CreateInStream(ResponseInStream);
                            APIInterfaceLog2."Response File".CreateOutStream(ResponseOutStream);
                            CopyStream(ResponseOutStream, ResponseInStream);
                            //BC Upgrade VAMSIU01 <<

                            APIInterfaceLog2."Response Sync. Date/Time" := CURRENTDATETIME;
                            APIInterfaceLog2.MODIFY;

                            //HEI.02>>
                            COMMIT;
                            SourceSystemIdentifierAPI.GET(APIInterfaceLog2."Source System Identifier");
                            if SourceSystemIdentifierAPI."Automatic SO Posting" then
                                if CODEUNIT.RUN(CODEUNIT::"Auto Posting API Interfaces", APIInterfaceLog2) then begin
                                    APIInterfaceLog2.FIND;
                                    if not (APIInterfaceLog2."Posting Status" = APIInterfaceLog2."Posting Status"::Error) then begin
                                        APIInterfaceLog2."Posting Status" := APIInterfaceLog2."Posting Status"::Processed;
                                        APIInterfaceLog2.MODIFY;
                                    end;
                                end else begin
                                    APIInterfaceLog2.FIND;
                                    LastPostingErrorMsg := STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK);
                                    APIInterfaceLog2."Posting Status" := APIInterfaceLog2."Posting Status"::Error;
                                    APIInterfaceLog2."Posting Error Message".CREATEOUTSTREAM(LastErrorOutStream);
                                    LastErrorOutStream.WRITETEXT(LastPostingErrorMsg);
                                    APIInterfaceLog2.MODIFY;
                                    WarehouseShipmentHeader.SETRANGE("Source No. FND", APIInterfaceLog2."Source No.");
                                    if WarehouseShipmentHeader.FINDFIRST then
                                        WarehouseShipmentHeader.DELETE(true);
                                end;
                            //HEI.02<<
                        end else begin
                            // Processing failed, to be logged, error response to be sent
                            APIInterfaceLog2.FIND;
                            LastErrorMsg := STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK);
                            //HEI.04>>
                            if APIInterfaceLog2.Entity = 'PURCHASE' then
                                CreateResponseforPurchase(APIInterfaceLog2."Message ID", false, LastErrorMsg)
                            else
                                //HEI.04<<
                                CreateResponse(APIInterfaceLog2."Message ID", false, LastErrorMsg);
                            //HEI.03>>
                            //APIInterfaceLog2.Status := APIInterfaceLog2.Status::Error;
                            APIInterfaceLog2.VALIDATE(Status, APIInterfaceLog2.Status::Error);
                            //HEI.03<<
                            APIInterfaceLog2."Error Message".CREATEOUTSTREAM(ErrorOutStream);
                            ErrorOutStream.WRITETEXT(LastErrorMsg);

                            //BC Upgrade VAMSIU01 >>
                            //APIInterfaceLog2."Response File" := ResponsetXml.Blob;
                            ResponsetXml.CreateInStream(ResponseInStream);
                            APIInterfaceLog2."Response File".CreateOutStream(ResponseOutStream);
                            CopyStream(ResponseOutStream, ResponseInStream);
                            //BC Upgrade VAMSIU01 <<

                            APIInterfaceLog2."Response Sync. Date/Time" := CURRENTDATETIME;
                            APIInterfaceLog2.MODIFY;
                        end;
                        //HEI.10>>
                    end;
                    //HEI.10<<
                end else begin
                    // TODO: For future extensibility
                    // NOTE: Async processing not part of Sales Order API, JUST TO SHOW IDEA ON EXTENSIBILITY
                    JobQueueEntry.INIT;
                    JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
                    JobQueueEntry."Object ID to Run" := CODEUNIT::"Process Async. API";
                    JobQueueEntry."Record ID to Process" := APIInterfaceLog2.RECORDID;
                    JobQueueEntry.Description := STRSUBSTNO(JobQueueProcessMsg, APIInterfaceLog2."Entry No.");
                    JobQueueEntry."Job Queue Category Code" := APIInterfaceLog2."Job Queue Category Code";
                    CODEUNIT.RUN(CODEUNIT::"Job Queue - Enqueue", JobQueueEntry);
                    //HEI.10>>
                    APIInterfaceLog2."Job Queue Codeunit" := CODEUNIT::"Job Queue - Enqueue";
                    APIInterfaceLog2."Job Queue Sync. Date/Time" := JobQueueEntry."Earliest Start Date/Time";
                    //HEI.10<<
                    APIInterfaceLog2."Job Queue Entry ID" := JobQueueEntry.ID;
                    APIInterfaceLog2.MODIFY;
                end;
            end else begin
                // Mandatory processing nodes missing in XML file, nothing to be logged, error response to be sent
                //BC Upgrade VAMSIU01>>
                // XmlNode := RequestXmlDocument.SelectSingleNode('/msg/msgId');  // Optional
                // if not ISNULL(XmlNode) then  
                //     MsgId := XmlNode.InnerText;
                if RequestXmlDocument.SelectSingleNode('/msg/msgId', XmlNode) then
                    if XmlNode.IsXmlElement then
                        MsgId := XmlNode.AsXmlElement().InnerText();
                //BC Upgrade VAMSIU01<<
                CreateResponse(MsgId, false, STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK))
            end;
        end else begin
            // Wrong XML file, nothing to be logged, error response to be sent
            //BC Upgrade VAMSIU01>>
            // XmlNode := RequestXmlDocument.SelectSingleNode('/msg/msgId');  // Optional
            // if not ISNULL(XmlNode) then
            //     MsgId := XmlNode.InnerText;
            if RequestXmlDocument.SelectSingleNode('/msg/msgId', XmlNode) then
                if XmlNode.IsXmlElement then
                    MsgId := XmlNode.AsXmlElement().InnerText();
            //BC Upgrade VAMSIU01<<
            CreateResponse(MsgId, false, STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK))
        end;

        //BC Upgrade VAMSIU01 >>
        //ResponsetXml.Blob.CREATEINSTREAM(MessageResponseInStream);
        ResponsetXml.CreateInStream(MessageResponseInStream);
        //BC Upgrade VAMSIU01 <<
        CLEAR(Message);
        Message.READ(MessageResponseInStream);

        //HEI.05>>
        CLEAR(RequestXmlDocument);
        Clear(XmlNode);
        CLEAR(ResponseXmlDocument);
        //HEI.05<<
        //HEI.06>>
        CLEAR(MessageOutStream);
        CLEAR(MessageInStream);
        CLEAR(MessageResponseInStream);
        CLEAR(ErrorOutStream);
        CLEAR(LastErrorOutStream);
        //HEI.06<<
        //BC Upgrade VAMSIU01 >>
        Clear(RequestInStream);
        Clear(RequestOutStream);
        Clear(ResponseInStream);
        Clear(ResponseOutStream);
        //BC Upgrade VAMSIU01 <<
    end;

    //BC Upgrade VAMSIU01>>

    // [TryFunction]
    // local procedure TryLoadXML();
    // begin
    // NOTE: NO WRITE TRANSACTION IN THIS FUNCTION
    // RequestXmlDocument := RequestXmlDocument.XmlDocument;
    // RequestXmlDocument.Load(MessageInStream);
    // end; 

    //BC Upgrade VAMSIU01<<

    //BC Upgrade VAMSIU01 >>
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
    //BC Upgrade VAMSIU01 <<

    [TryFunction]
    local procedure CheckForMandatoryProcessingNodes();
    var
        RequestInStream: InStream;
        RequestOutStream: OutStream;
    begin
        // NOTE: NO WRITE TRANSACTION IN THIS FUNCTION

        GetNodeByXPath('/msg/sourceSystemIdentifier', 'sourceSystemIdentifier');
        //if not SourceSystemIdentifierAPI.GET(XmlNode.InnerText) then //BC Upgrade VAMSIU01
        if not SourceSystemIdentifierAPI.Get(XmlNode.AsXmlElement().InnerText()) then //BC Upgrade VAMSIU01
            ERROR(InvaildValueErr, 'sourceSystemIdentifier');
        APIInterfaceLog2.VALIDATE("Source System Identifier", SourceSystemIdentifierAPI.Code);

        GetNodeByXPath('/msg/entity', 'entity');
        //HEI.04>>
        //IF NOT (UPPERCASE(XmlNode.InnerText) IN ['SALES']) THEN
        //if not (UPPERCASE(XmlNode.InnerText) in ['SALES', 'PURCHASE']) then //BC Upgrade VAMSIU01
        if not (UpperCase(XmlNode.AsXmlElement().InnerText()) in ['SALES', 'PURCHASE']) then //BC Upgrade VAMSIU01
            ERROR(InvaildValueErr, 'entity');
        //APIInterfaceLog2.Entity := UPPERCASE(XmlNode.InnerText); //BC Upgrade VAMSIU01
        APIInterfaceLog2.Entity := UpperCase(XmlNode.AsXmlElement().InnerText()); //BC Upgrade VAMSIU01

        GetNodeByXPath('/msg/operation', 'operation');
        //HEI.04>>
        //IF NOT (UPPERCASE(XmlNode.InnerText) IN ['CREATE','UPDATE','DELETE']) THEN
        //if not (UPPERCASE(XmlNode.InnerText) in ['CREATE', 'UPDATE', 'DELETE', 'REQINFO']) then //BC Upgrade VAMSIU01
        //HEI.04<<
        if not (UpperCase(XmlNode.AsXmlElement().InnerText()) in ['CREATE', 'UPDATE', 'DELETE', 'REQINFO']) then //BC Upgrade VAMSIU01
            ERROR(InvaildValueErr, 'operation');
        //APIInterfaceLog2.Operation := UPPERCASE(XmlNode.InnerText); //BC Upgrade VAMSIU01
        APIInterfaceLog2.Operation := CopyStr(UpperCase(XmlNode.AsXmlElement().InnerText()), 1, MaxStrLen(APIInterfaceLog2.Operation)); //BC Upgrade VAMSIU01

        GetNodeByXPath('/msg/payload', 'payload');

        // XmlNode := RequestXmlDocument.SelectSingleNode('/msg/msgId');  // Optional
        // if not ISNULL(XmlNode) then
        //     if XmlNode.InnerText <> '' then
        if RequestXmlDocument.SelectSingleNode('/msg/msgId', XmlNode) then
            if XmlNode.IsXmlElement then
                if XmlNode.AsXmlElement().InnerText() <> '' then
                    //APIInterfaceLog2."Message ID" := XmlNode.InnerText; //BC Upgrade VAMSIU01
                    APIInterfaceLog2."Message ID" := COPYSTR(XmlNode.AsXmlElement().InnerText(), 1, MAXSTRLEN(APIInterfaceLog2."Message ID")); //BC Upgrade VAMSIU01

        // XmlNode := RequestXmlDocument.SelectSingleNode('/msg/payloadFormat');  // Optional
        // if not ISNULL(XmlNode) then
        //     if XmlNode.InnerText <> '' then
        if RequestXmlDocument.SelectSingleNode('/msg/payloadFormat', XmlNode) then
            if XmlNode.IsXmlElement then
                if XmlNode.AsXmlElement().InnerText() <> '' then
                    if EVALUATE(APIInterfaceLog2."File Format", XmlNode.AsXmlElement().InnerText()) then;//BC Upgrade VAMSIU01
                                                                                                         //if EVALUATE(APIInterfaceLog2."File Format", XmlNode.InnerText) then; //BC Upgrade VAMSIU01

        // XmlNode := RequestXmlDocument.SelectSingleNode('/msg/msgTimestamp');  // Optional
        // if not ISNULL(XmlNode) then
        //     if XmlNode.InnerText <> '' then
        if RequestXmlDocument.SelectSingleNode('/msg/msgTimestamp', XmlNode) then
            if XmlNode.IsXmlElement then
                if XmlNode.AsXmlElement().InnerText() <> '' then
                    if EVALUATE(APIInterfaceLog2."Source Request Timestamp", XmlNode.AsXmlElement().InnerText(), 9) then;//BC Upgrade VAMSIU01
        //if EVALUATE(APIInterfaceLog2."Source Request Timestamp", XmlNode.InnerText, 9) then;//BC Upgrade VAMSIU01 

        APIInterfaceLog2."Request Sync. Date/Time" := CURRENTDATETIME;

        //BC Upgrade VAMSIU01 >>
        RequestXml.CreateInStream(RequestInStream);
        APIInterfaceLog2."Request File".CreateOutStream(RequestOutStream);
        CopyStream(RequestOutStream, RequestInStream);

        //BC Upgrade VAMSIU01 <<
        case APIInterfaceLog2.Entity of
            'SALES':
                begin
                    //HEI.13>>
                    if APIInterfaceLog2.Operation = 'REQINFO' then begin
                        GetB2BInterfaceSetup;
                        B2BInterfaceSetup.TESTFIELD("Order Simulation Interface");
                        InterfaceSetup.GET(B2BInterfaceSetup."Order Simulation Interface");
                        APIInterfaceLog2."Interface Code" := B2BInterfaceSetup."Order Simulation Interface";
                        APIInterfaceLog2."Call Type" := InterfaceSetup."Call Type";
                        InterfaceSetup.TESTFIELD(Enabled, true);
                        APIInterfaceLog2."Processing Codeunit" := CODEUNIT::"Process Sales API"; //BC Upgrade VAMSIU01 - Blocked Temporarily
                    end else begin
                        //HEI.13<<
                        APIInterfaceSetup2.GET;
                        APIInterfaceSetup2.TESTFIELD("SO/SRO Interface Request");
                        APIInterfaceLog2."Interface Code" := APIInterfaceSetup2."SO/SRO Interface Request";
                        InterfaceSetup.GET(APIInterfaceSetup2."SO/SRO Interface Request");
                        APIInterfaceLog2."Call Type" := InterfaceSetup."Call Type";
                        InterfaceSetup.TESTFIELD(Enabled, true);
                        APIInterfaceLog2."Job Queue Category Code" := ''; // From which setup for sequencial operation if conflicting? Leave blank for parallel processing
                        APIInterfaceLog2."Processing Codeunit" := CODEUNIT::"Process Sales API"; //BC Upgrade VAMSIU01 - Blocked Temporarily
                        //HEI.10>>
                        if APIInterfaceLog2.Operation = 'CREATE' then //BC Upgrade VAMSIU01 - Blocked Temporarily
                            APIInterfaceLog2."Checking Codeunit" := CODEUNIT::"Checking Sales API"; //BC Upgrade VAMSIU01 - Blocked Temporarily
                        //HEI.10<<
                    end;
                end;
            //HEI.04>>
            'PURCHASE':
                begin
                    grec_IbecorInterfaceSetup.GET;
                    grec_IbecorInterfaceSetup.TESTFIELD("IBECOR PO");
                    APIInterfaceLog2."Interface Code" := grec_IbecorInterfaceSetup."IBECOR PO";
                    InterfaceSetup.GET(grec_IbecorInterfaceSetup."IBECOR PO");
                    APIInterfaceLog2."Call Type" := InterfaceSetup."Call Type";
                    InterfaceSetup.TESTFIELD(Enabled, true);
                    APIInterfaceLog2."Job Queue Category Code" := '';
                    APIInterfaceLog2."Processing Codeunit" := CODEUNIT::"Process Purchase API";
                end;
        //HEI.04<<
        end;
        //HEI.10>>
        APIInterfaceLog2."Job Queue Codeunit" := APIInterfaceLog2."Processing Codeunit";
        //HEI.10<<
    end;

    //BC Upgrade VAMSIU01 >>

    // local procedure CreateResponse(MsgId: Text; IsSuccess: Boolean; ErrorText: Text);
    // var
    // RootXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";//BC Upgrade VAMSIU01
    // TempXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";//BC Upgrade VAMSIU01
    //     RootXmlNode: XmlNode;//BC Upgrade VAMSIU01
    //     TempXmlNode: XmlNode;//BC Upgrade VAMSIU01
    // begin
    // ResponseXmlDocument := ResponseXmlDocument.XmlDocument;
    // RootXmlNode := ResponseXmlDocument.CreateElement('msgResponse');
    // ResponseXmlDocument.AppendChild(RootXmlNode);
    // TempXmlNode := ResponseXmlDocument.CreateElement('msgId');
    // TempXmlNode.InnerText := MsgId;
    // RootXmlNode.AppendChild(TempXmlNode);
    // TempXmlNode := ResponseXmlDocument.CreateElement('isSuccess');
    // if IsSuccess then
    //     TempXmlNode.InnerText := 'true'
    // else
    //     TempXmlNode.InnerText := 'false';
    // RootXmlNode.AppendChild(TempXmlNode);
    // TempXmlNode := ResponseXmlDocument.CreateElement('error');
    // TempXmlNode.InnerText := ErrorText;
    // RootXmlNode.AppendChild(TempXmlNode);

    // //ResponsetXml.Blob.CREATEOUTSTREAM(MessageResponseOutStream);//BC Upgrade VAMSIU01
    // ResponsetXml.CreateOutStream(MessageResponseOutStream);//BC Upgrade VAMSIU01
    // ResponseXmlDocument.WriteTo(MessageResponseOutStream);//BC Upgrade VAMSIU01
    // //ResponseXmlDocument.Save(MessageResponseOutStream);

    // //HEI.05>>
    // CLEAR(RootXmlNode);
    // CLEAR(TempXmlNode);
    // //HEI.05<<
    // CLEAR(MessageResponseOutStream); //HEI.06
    // end;
    //BC Upgrade VAMSIU01 <<

    //BC Upgrade VAMSIU01 >>
    local procedure CreateResponse(MsgId: Text; IsSuccess: Boolean; ErrorText: Text)
    var
        RootXmlElement: XmlElement;
        TempXmlElement: XmlElement;
    begin
        ResponseXmlDocument := XmlDocument.Create();
        RootXmlElement := XmlElement.Create('msgResponse');
        ResponseXmlDocument.Add(RootXmlElement);

        TempXmlElement := XmlElement.Create('msgId');
        TempXmlElement.Add(XmlText.Create(MsgId));
        RootxmlElement.Add(TempXmlElement);

        TempXmlElement := XmlElement.Create('isSuccess');
        if IsSuccess then
            TempXmlElement.Add(XmlText.Create('true'))
        else
            TempXmlElement.Add(XmlText.Create('false'));
        RootXmlElement.Add(TempXmlElement);

        if not IsSuccess then begin
            TempXmlElement := XmlElement.Create('error');
            TempXmlElement.Add(XmlText.Create(ErrorText));
            RootxmlElement.Add(TempXmlElement);
        end;

        ResponsetXml.CREATEOUTSTREAM(MessageResponseOutStream, TextEncoding::UTF8);
        ResponseXmlDocument.WriteTo(MessageResponseOutStream);
    end;
    //BC Upgrade VAMSIU01 <<

    //BC Upgrade VAMSIU01 >>
    // local procedure GetNodeByXPath(XPath: Text; NodeName: Text);
    // begin
    //     XmlNode := RequestXmlDocument.SelectSingleNode(XPath); // Mandatory
    //     if ISNULL(XmlNode) then
    //         ERROR(MissingNodeErr, NodeName);
    //     if XmlNode.InnerText = '' then
    //         ERROR(TextMissingErr, NodeName);
    // end;
    //BC Upgrade VAMSIU01 <<

    //BC Upgrade VAMSIU01 >>
    local procedure GetNodeByXPath(XPath: Text; NodeName: Text);

    begin
        if not RequestXmlDocument.SelectSingleNode(XPath, XmlNode) then
            Error(MissingNodeErr, NodeName);
        if XmlNode.AsXmlElement().InnerText() = '' then
            Error(TextMissingErr, NodeName);
    end;
    //BC Upgrade VAMSIU01 <<


    procedure ProcessOrderStatus(var Request: BigText);
    var
        //BC Upgrade VAMSIU01 >>
        RequestInStream: InStream;
        RequestOutStream: OutStream;
        ResponseInStream: InStream;
        ResponseOutStream: OutStream;
    //BC Upgrade VAMSIU01 <<
    begin
        //HEI.03>>
        //BC Upgrade VAMSIU01 >>
        //RequestXml.Blob.CREATEOUTSTREAM(MessageOutStream); 
        RequestXml.CreateOutStream(MessageOutStream);
        //BC Upgrade VAMSIU01 << 
        Request.WRITE(MessageOutStream);
        //BC Upgrade VAMSIU01 >>
        RequestXml.CreateInStream(MessageInStream);
        //RequestXml.Blob.CREATEINSTREAM(MessageInStream);
        //BC Upgrade VAMSIU01 << 

        if TryLoadXML(Request) then begin
            APIInterfaceLog2.INIT;
            if CheckSOStatusMandatoryProcessingNodes then begin
                APIInterfaceLog2.INSERT;
                //BC Upgrade VAMSIU01 >>
                RequestXml.CreateInStream(RequestInStream);
                APIInterfaceLog2."Request File".CreateOutStream(RequestOutStream);
                CopyStream(RequestOutStream, RequestInStream);
                APIInterfaceLog2.MODIFY;
                //BC Upgrade VAMSIU01 <<
                COMMIT;
                //BC Upgrade VAMSIU01 >>
                if CODEUNIT.RUN(CODEUNIT::"API Order Status Mgmt.", APIInterfaceLog2) then begin
                    APIInterfaceLog2.FIND;
                    CreateOrderStatusResponse;
                    APIInterfaceLog2.VALIDATE(Status, APIInterfaceLog2.Status::Processed);
                    //BC Upgrade VAMSIU01 >>
                    //APIInterfaceLog2."Response File" := ResponsetXml.Blob; 
                    ResponsetXml.CreateInStream(ResponseInStream);
                    APIInterfaceLog2."Response File".CreateOutStream(ResponseOutStream);
                    CopyStream(ResponseOutStream, ResponseInStream);
                    //BC Upgrade VAMSIU01 << 
                    APIInterfaceLog2."Response Sync. Date/Time" := CURRENTDATETIME;
                    APIInterfaceLog2.MODIFY;
                end else begin
                    APIInterfaceLog2.FIND;
                    LastErrorMsg := STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK);
                    APIInterfaceLog2.VALIDATE(Status, APIInterfaceLog2.Status::Error);
                    APIInterfaceLog2."Error Message".CREATEOUTSTREAM(ErrorOutStream);
                    ErrorOutStream.WRITETEXT(LastErrorMsg);
                    APIInterfaceLog2.MODIFY;
                end;
                //BC Upgrade VAMSIU01 << Blocked Temporarily
            end;
        end;

        //ResponsetXml.Blob.CREATEINSTREAM(MessageResponseInStream);//BC Upgrade VAMSIU01
        ResponsetXml.CreateInStream(ResponseInStream);//BC Upgrade SHUKLP03
        CLEAR(Request);
        Request.READ(ResponseInStream);//BC Upgrade SHUKLP03
        //HEI.03<<

        //HEI.05>>
        CLEAR(RequestXmlDocument);
        CLEAR(XmlNode);
        CLEAR(ResponseXmlDocument);
        //HEI.05<<
        //HEI.06>>
        CLEAR(MessageOutStream);
        CLEAR(MessageInStream);
        CLEAR(MessageResponseInStream);
        CLEAR(ErrorOutStream);
        //HEI.06<<
    end;

    [TryFunction]
    local procedure CheckSOStatusMandatoryProcessingNodes();
    var
        APIInterfaceSetup: Record "API Interface Setup2 INT";
        InterfaceSetup: Record "Interface Setup INT";
        APIInterfaceLog3: Record "API Interface Log2 INT";

        RequestInStream: InStream;
        RequestOutStream: OutStream;
    begin
        //HEI.03>>
        GetNodeByXPath2('/OrderStatus', 'OrderStatus', false);
        GetNodeByXPath2('/OrderStatus/Order', 'Order', false);

        GetNodeByXPath2('/OrderStatus/Order/SourceSystem', 'SourceSystem', true);
        //if not SourceSystemIdentifierAPI.GET(XmlNode.InnerText) then  //BC Upgrade VAMSIU01
        if not SourceSystemIdentifierAPI.Get(XmlNode.AsXmlElement().InnerText()) then   //BC Upgrade VAMSIU01
            ERROR(InvaildValueErr, 'SourceSystem');
        APIInterfaceLog2.VALIDATE("Source System Identifier", SourceSystemIdentifierAPI.Code);

        GetNodeByXPath2('/OrderStatus/Order/OrderID', 'OrderID', true);
        // APIInterfaceLog2."Order ID" := XmlNode.InnerText;//BC Upgrade VAMSIU01
        APIInterfaceLog2."Order ID" := XmlNode.AsXmlElement().InnerText();//BC Upgrade VAMSIU01

        APIInterfaceLog3.RESET;
        APIInterfaceLog3.SETRANGE("Order ID", APIInterfaceLog2."Order ID");
        APIInterfaceLog3.SETRANGE("Source System Identifier", APIInterfaceLog2."Source System Identifier");
        APIInterfaceLog3.SETRANGE(Entity, 'SALES');
        APIInterfaceLog3.SETRANGE(Operation, 'CREATE');
        APIInterfaceLog3.SETRANGE("Source Type", 36);
        if APIInterfaceLog3.FINDLAST then
            APIInterfaceLog2.VALIDATE("Source No.", APIInterfaceLog3."Source No.");

        APIInterfaceLog2."Request Sync. Date/Time" := CURRENTDATETIME;
        //BC Upgrade VAMSIU01 >>
        //APIInterfaceLog2."Request File" := RequestXml.Blob;
        RequestXml.CreateInStream(RequestInStream);
        APIInterfaceLog2."Request File".CreateOutStream(RequestOutStream);
        CopyStream(RequestOutStream, RequestInStream);
        //BC Upgrade VAMSIU01 <<
        APIInterfaceLog2.Entity := 'SALES';
        APIInterfaceLog2.Operation := 'READ';
        APIInterfaceLog2."Source Type" := 36;

        APIInterfaceSetup.GET;
        APIInterfaceSetup.TESTFIELD("API Order Status Interface");
        APIInterfaceLog2."Interface Code" := APIInterfaceSetup."API Order Status Interface";
        InterfaceSetup.GET(APIInterfaceSetup."API Order Status Interface");
        InterfaceSetup.TESTFIELD(Enabled, true);
        APIInterfaceLog2."Call Type" := InterfaceSetup."Call Type";
        APIInterfaceLog2."Processing Codeunit" := CODEUNIT::"API Order Status Mgmt."; //BC Upgrade VAMSIU01 - Blocked Temporarily 
        //HEI.03<<
    end;

    //BC Upgrade VAMSIU01 >>
    // local procedure GetNodeByXPath2(XPath: Text; NodeName: Text; CheckValue: Boolean);
    // begin
    //     //HEI.03>>
    //     XmlNode := RequestXmlDocument.SelectSingleNode(XPath); // Mandatory
    //     if ISNULL(XmlNode) then
    //         ERROR(MissingNodeErr, NodeName);

    //     if CheckValue then
    //         if XmlNode.InnerText = '' then
    //             ERROR(TextMissingErr, NodeName);
    //     //HEI.03<<
    // end;
    //BC upgrade VAMSIU01 <<

    //BC Upgrade VAMSIU01 >>
    local procedure GetNodeByXPath2(XPath: Text; NodeName: Text; CheckValue: Boolean)

    begin
        if not RequestXmlDocument.SelectSingleNode(XPath, XmlNode) then
            ERROR(MissingNodeErr, NodeName);
        if CheckValue then
            if XmlNode.AsXmlElement().InnerText() = '' then
                ERROR(TextMissingErr, NodeName);
    end;
    //BC Upgrade VAMSIU01 <<


    //BC Upgrade VAMSIU01 >>

    // local procedure CreateOrderStatusResponse();
    // var
    //     RootXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    // begin
    // ResponseXmlDocument := ResponseXmlDocument.XmlDocument;
    // RootXmlNode := ResponseXmlDocument.CreateElement('OrderStatus');
    // ResponseXmlDocument.AppendChild(RootXmlNode);

    // TempXmlNode := ResponseXmlDocument.CreateElement('OrderID');
    // TempXmlNode.InnerText := APIInterfaceLog2."Order ID";
    // RootXmlNode.AppendChild(TempXmlNode);

    // TempXmlNode := ResponseXmlDocument.CreateElement('SourceSystem');
    // TempXmlNode.InnerText := APIInterfaceLog2."Source System Identifier";
    // RootXmlNode.AppendChild(TempXmlNode);

    // TempXmlNode := ResponseXmlDocument.CreateElement('OrderStatus');
    // TempXmlNode.InnerText := APIInterfaceLog2."Message ID";
    // RootXmlNode.AppendChild(TempXmlNode);

    // TempXmlNode := ResponseXmlDocument.CreateElement('MessageDateTime');
    // TempXmlNode.InnerText := FORMAT(CURRENTDATETIME, 0, 9);
    // RootXmlNode.AppendChild(TempXmlNode);

    // ResponsetXml.Blob.CREATEOUTSTREAM(MessageResponseOutStream);
    // ResponseXmlDocument.Save(MessageResponseOutStream);

    // //HEI.05>>
    // CLEAR(RootXmlNode);
    // CLEAR(TempXmlNode);
    // //HEI.05<<
    // CLEAR(MessageResponseOutStream); //HEI.06
    // end;

    //BC Upgrade VAMSIU01 <<

    //BC Upgrade VAMSIU01 >>
    local procedure CreateOrderStatusResponse()
    var
        XmlDoc: XmlDocument;
        RootXmlElement: XmlElement;
        TempXmlElement: XmlElement;
        MessageResponseOutStream: OutStream;
    begin
        XmlDoc := XmlDocument.Create();
        RootXmlElement := XmlElement.Create('OrderStatus');
        XmlDoc.Add(RootXmlElement);

        TempXmlElement := XmlElement.Create('OrderID');
        TempXmlElement.Add(XmlText.Create(APIInterfaceLog2."Order ID"));
        RootXmlElement.Add(TempXmlElement);

        TempXmlElement := XmlElement.Create('SourceSystem');
        TempXmlElement.Add(XmlText.Create(APIInterfaceLog2."Source System Identifier"));
        RootXmlElement.Add(TempXmlElement);

        TempXmlElement := XmlElement.Create('OrderStatus');
        TempXmlElement.Add(XmlText.Create(APIInterfaceLog2."Message ID"));
        RootXmlElement.Add(TempXmlElement);

        TempXmlElement := XmlElement.Create('MessageDateTime');
        TempXmlElement.Add(XmlText.Create(FORMAT(CURRENTDATETIME, 0, 9)));
        RootXmlElement.Add(TempXmlElement);

        ResponsetXml.CREATEOUTSTREAM(MessageResponseOutStream);
        XmlDoc.WriteTo(MessageResponseOutStream);

        Clear(RootXmlElement);
        Clear(TempXmlElement);
        Clear(MessageResponseOutStream);

    end;
    //BC Upgrade VAMSIU01 <<

    local procedure CreateResponseforPurchase(MsgId: Text; IsSuccess: Boolean; ErrorText: Text);
    var
        RootxmlElement: XmlElement;
        TempXmlElement: XmlElement;
        lrec_Ibecor_POData: Record "Ibecor PO Staging Data INT";
        lrec_PFIHeader: Record "PFI Header INT";
        TempXmlElementTier2: XmlElement;
        TempXmlNodeTier3: XmlElement;
        TempXmlNodeTier4: XmlElement;
        TempXmlNodeTier5: XmlElement;
        TempXmlNodeTier6: XmlElement;
        TempXmlNodeTier7: XmlElement;
        TempXmlNodeTier8: XmlElement;
        TempXmlNodeTier9: XmlElement;
        TempXmlNodeTier10: XmlElement;
        TempXmlNodeTier11: XmlElement;
        TempXmlNodeTier12: XmlElement;
        TempXmlNodeTier13: XmlElement;
        TempXmlNodeTier14: XmlElement;
        TempXmlNodeTier15: XmlElement;
        TempXmlNodeTier16: XmlElement;
        TempXmlNodeTier17: XmlElement;
        TempXmlNodeTier18: XmlElement;
        TempXmlNodeTier19: XmlElement;
        TempXmlNodeTier20: XmlElement;
        TempXmlNodeTier21: XmlElement;
        TempXmlNodeTier22: XmlElement;
        TempXmlNodeTier23: XmlElement;
        TempXmlNodeTier24: XmlElement;
        TempXmlNodeTier25: XmlElement;
        TempXmlNodeTier26: XmlElement;
        TempXmlNodeTier27: XmlElement;
        TempXmlNodeTier28: XmlElement;
        TempXmlNodeTier29: XmlElement;
    begin
        ResponseXmlDocument := XmlDocument.Create();
        RootxmlElement := XmlElement.Create('msgResponse');
        ResponseXmlDocument.Add(RootxmlElement);

        TempXmlElement := XmlElement.Create('msgId');
        TempXmlElement.Add(XmlText.Create(MsgId));
        RootxmlElement.Add(TempXmlElement);

        TempXmlElement := XmlElement.Create('isSuccess');

        if IsSuccess then
            TempXmlElement.Add(XmlText.Create('true'))
        else
            TempXmlElement.Add(XmlText.Create('false'));

        RootXmlElement.Add(TempXmlElement);

        if not IsSuccess then begin
            TempXmlElement := XmlElement.Create('error');
            TempXmlElement.Add(XmlText.Create(ErrorText));
            RootxmlElement.Add(TempXmlElement);
        end;

        lrec_Ibecor_POData.RESET;
        lrec_Ibecor_POData.SETRANGE("Record Type", lrec_Ibecor_POData."Record Type"::Header);
        lrec_Ibecor_POData.SETRANGE(lrec_Ibecor_POData."Document No", MsgId);
        lrec_Ibecor_POData.SETRANGE("Movement Status", lrec_Ibecor_POData."Movement Status"::"Ready to Send");
        if lrec_Ibecor_POData.FINDSET then
            repeat

                TempXmlElement := XmlElement.Create('orders');
                RootxmlElement.Add(TempXmlElement);

                TempXmlElementTier2 := XmlElement.Create('DocDate');
                TempXmlElementTier2.Add(XmlText.Create(Format(lrec_Ibecor_POData."Document No")));
                TempXmlElement.Add(TempXmlElementTier2);

                TempXmlNodeTier3 := XmlElement.Create('DocDate');
                TempXmlNodeTier3.Add(XmlText.Create(Format(lrec_Ibecor_POData."Document Date")));
                TempXmlElement.Add(TempXmlNodeTier3);

                TempXmlNodeTier4 := XmlElement.Create('OpcoCode');
                TempXmlNodeTier4.Add(XmlText.Create(Format(lrec_Ibecor_POData."Opco Code")));
                TempXmlElement.Add(TempXmlNodeTier4);

                TempXmlNodeTier5 := XmlElement.Create('BillToCustomerGlobalId');
                TempXmlNodeTier5.Add(XmlText.Create(Format(lrec_Ibecor_POData."Bill to Customer GID")));
                TempXmlElement.Add(TempXmlNodeTier5);

                TempXmlNodeTier6 := XmlElement.Create('YourReference');
                TempXmlNodeTier6.Add(XmlText.Create(Format(lrec_Ibecor_POData."Ibecor Doc No.")));
                TempXmlElement.Add(TempXmlNodeTier6);

                TempXmlNodeTier7 := XmlElement.Create('IbecorDossierNo');
                TempXmlNodeTier7.Add(XmlText.Create(Format(lrec_Ibecor_POData."Ibecor Dossier No")));
                TempXmlElement.Add(TempXmlNodeTier7);

                TempXmlNodeTier9 := XmlElement.Create('LogisticOfficer');
                TempXmlNodeTier9.Add(XmlText.Create(Format(lrec_Ibecor_POData."Logistics Officer")));
                TempXmlElement.Add(TempXmlNodeTier9);

                TempXmlNodeTier10 := XmlElement.Create('DocAmount');
                TempXmlNodeTier10.Add(XmlText.Create(Format(lrec_Ibecor_POData.Amount)));
                TempXmlElement.Add(TempXmlNodeTier10);

                TempXmlNodeTier11 := XmlElement.Create('CurrencyCode');
                TempXmlNodeTier11.Add(XmlElement.Create(Format(lrec_Ibecor_POData."Currency Code")));
                TempXmlElement.Add(TempXmlNodeTier11);

                TempXmlNodeTier12 := XmlElement.Create('Approver');
                TempXmlNodeTier12.Add(XmlText.Create(Format(lrec_Ibecor_POData.Approver)));
                TempXmlElement.Add(TempXmlNodeTier12);

                TempXmlNodeTier13 := XmlElement.Create('Requestor');
                TempXmlNodeTier13.Add(XmlText.Create(Format(lrec_Ibecor_POData.Requestor)));
                TempXmlElement.Add(TempXmlNodeTier13);

                TempXmlNodeTier14 := XmlElement.Create('DossierInfo');
                TempXmlElement.Add(TempXmlNodeTier14);

                TempXmlNodeTier15 := XmlElement.Create('Description');
                if (lrec_Ibecor_POData."Ibecor Doc No." <> '') and
                   lrec_PFIHeader.Get(lrec_Ibecor_POData."Ibecor Doc No.") then
                    TempXmlNodeTier15.Add(XmlText.Create(lrec_PFIHeader.Description))
                else
                    TempXmlNodeTier15.Add(XmlText.Create(''));
                TempXmlNodeTier14.Add(TempXmlNodeTier15);

                TempXmlNodeTier16 := XmlElement.Create('LicenseInfo');
                TempXmlNodeTier14.Add(TempXmlNodeTier16);

                TempXmlNodeTier17 := XmlElement.Create('LicenseRequired');
                if lrec_Ibecor_POData."License Required" then
                    TempXmlNodeTier17.Add(XmlText.Create('True'))
                else
                    TempXmlNodeTier17.Add(XmlText.Create('False'));
                TempXmlNodeTier16.Add(TempXmlNodeTier17);

                TempXmlNodeTier18 := XmlElement.Create('LicenseNumber');
                TempXmlNodeTier18.Add(XmlText.Create(Format(lrec_Ibecor_POData."Licence Number")));
                TempXmlNodeTier16.Add(TempXmlNodeTier18);

                TempXmlNodeTier19 := XmlElement.Create('BankOrOrganismLicense');
                TempXmlNodeTier19.Add(XmlText.Create(Format(lrec_Ibecor_POData."Bank Of Organism License")));
                TempXmlNodeTier16.Add(TempXmlNodeTier19);

                TempXmlNodeTier20 := XmlElement.Create('DateValidityLicense');
                TempXmlNodeTier20.Add(XmlText.Create(Format(lrec_Ibecor_POData."License Expiration Date")));
                TempXmlNodeTier16.Add(TempXmlNodeTier20);

                TempXmlNodeTier29 := XmlElement.Create('CoDCoCNumber');
                TempXmlNodeTier29.Add(XmlText.Create(Format(lrec_Ibecor_POData."CoD/CoC Number")));
                TempXmlNodeTier16.Add(TempXmlNodeTier29);

                TempXmlNodeTier21 := XmlElement.Create('CredocInfo');
                TempXmlNodeTier14.Add(TempXmlNodeTier21);

                TempXmlNodeTier22 := XmlElement.Create('CredocRequired');
                if lrec_Ibecor_POData."Credit Info Required" then
                    TempXmlNodeTier22.Add(XmlText.Create('True'))
                else
                    TempXmlNodeTier22.Add(XmlText.Create('False'));
                TempXmlNodeTier21.Add(TempXmlNodeTier22);


                if lrec_Ibecor_POData."Credit Info Required" then begin
                    TempXmlNodeTier23 := XmlElement.Create('NumberCredocSupplier');
                    TempXmlNodeTier23.Add(XmlText.Create(Format(lrec_Ibecor_POData."Credit Number")));
                    TempXmlNodeTier21.Add(TempXmlNodeTier23);

                    TempXmlNodeTier24 := XmlElement.Create('AmountCredocSupplier');
                    TempXmlNodeTier24.Add(XmlText.Create(Format(lrec_Ibecor_POData."Credit amount Of Supplier")));
                    TempXmlNodeTier21.Add(TempXmlNodeTier24);

                    TempXmlNodeTier25 := XmlElement.Create('DateValidityCredit');
                    TempXmlNodeTier25.Add(XmlText.Create(Format(lrec_Ibecor_POData."Credit Validity Of Supplier")));
                    TempXmlNodeTier21.Add(TempXmlNodeTier25);

                    TempXmlNodeTier26 := XmlElement.Create('LastDateOfShipment');
                    TempXmlNodeTier26.Add(XmlText.Create(Format(lrec_Ibecor_POData."Last Date Of Shipment")));
                    TempXmlNodeTier21.Add(TempXmlNodeTier26);

                    TempXmlNodeTier27 := XmlElement.Create('BankOrOrganismSupplier');
                    TempXmlNodeTier27.Add(XmlText.Create(Format(lrec_Ibecor_POData."Bank Of Organism Supplier")));
                    TempXmlNodeTier21.Add(TempXmlNodeTier27);

                    TempXmlNodeTier28 := XmlElement.Create('BankReferenceNumber');
                    TempXmlNodeTier28.Add(XmlText.Create(Format(lrec_Ibecor_POData."Bank Reference Number")));
                    TempXmlNodeTier21.Add(TempXmlNodeTier28);
                end;

                lrec_Ibecor_POData."Movement Status" := lrec_Ibecor_POData."Movement Status"::"Sent to Ibecor";
                lrec_Ibecor_POData."Last Send Date" := TODAY;
                lrec_Ibecor_POData."Sending Version" += 1;
                lrec_Ibecor_POData.MODIFY;
            until lrec_Ibecor_POData.NEXT = 0;

        ResponsetXml.CREATEOUTSTREAM(MessageResponseOutStream);
        ResponseXmlDocument.WriteTo(MessageResponseOutStream);

        CLEAR(RootxmlElement);
        CLEAR(TempXmlElement);
        CLEAR(TempXmlElementTier2);
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
    end;

    //BC Upgrade VAMSIU01 -Start

    // local procedure CreateResponseforPurchase(MsgId: Text; IsSuccess: Boolean; ErrorText: Text);
    // var
    //     RootXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     lrec_Ibecor_POData: Record "Ibecor PO Staging Data INT";
    //     lrec_PFIHeader: Record "PFI Header INT";
    //     TempXmlNodeTier2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier3: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier4: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier5: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier6: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier7: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier8: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier9: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier10: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier11: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier12: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier13: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier14: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier15: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier16: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier17: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier18: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier19: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier20: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier21: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier22: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier23: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier24: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier25: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier26: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier27: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier28: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeTier29: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    // begin
    //     //HEI.04>>
    //     ResponseXmlDocument := ResponseXmlDocument.XmlDocument;
    //     RootXmlNode := ResponseXmlDocument.CreateElement('msgResponse');
    //     ResponseXmlDocument.AppendChild(RootXmlNode);

    //     TempXmlNode := ResponseXmlDocument.CreateElement('msgId');
    //     TempXmlNode.InnerText := MsgId;
    //     RootXmlNode.AppendChild(TempXmlNode);


    //     TempXmlNode := ResponseXmlDocument.CreateElement('isSuccess');
    //     if IsSuccess then
    //         TempXmlNode.InnerText := 'true'
    //     else
    //         TempXmlNode.InnerText := 'false';
    //     RootXmlNode.AppendChild(TempXmlNode);

    //     if not IsSuccess then begin
    //         TempXmlNode := ResponseXmlDocument.CreateElement('error');
    //         TempXmlNode.InnerText := ErrorText;
    //         RootXmlNode.AppendChild(TempXmlNode);
    //     end;

    //     lrec_Ibecor_POData.RESET;
    //     lrec_Ibecor_POData.SETRANGE("Record Type", lrec_Ibecor_POData."Record Type"::Header);
    //     lrec_Ibecor_POData.SETRANGE(lrec_Ibecor_POData."Document No", MsgId);
    //     lrec_Ibecor_POData.SETRANGE("Movement Status", lrec_Ibecor_POData."Movement Status"::"Ready to Send");
    //     if lrec_Ibecor_POData.FINDSET then
    //         repeat

    //             TempXmlNode := ResponseXmlDocument.CreateElement('orders');
    //             RootXmlNode.AppendChild(TempXmlNode);

    //             TempXmlNodeTier2 := ResponseXmlDocument.CreateElement('DocNumber');
    //             TempXmlNodeTier2.InnerText := FORMAT(lrec_Ibecor_POData."Document No");
    //             TempXmlNode.AppendChild(TempXmlNodeTier2);

    //             TempXmlNodeTier3 := ResponseXmlDocument.CreateElement('DocDate');
    //             TempXmlNodeTier3.InnerText := FORMAT(lrec_Ibecor_POData."Document Date");
    //             TempXmlNode.AppendChild(TempXmlNodeTier3);

    //             TempXmlNodeTier4 := ResponseXmlDocument.CreateElement('OpcoCode');
    //             TempXmlNodeTier4.InnerText := FORMAT(lrec_Ibecor_POData."Opco Code");
    //             TempXmlNode.AppendChild(TempXmlNodeTier4);

    //             TempXmlNodeTier5 := ResponseXmlDocument.CreateElement('BillToCustomerGlobalId');
    //             TempXmlNodeTier5.InnerText := FORMAT(lrec_Ibecor_POData."Bill to Customer GID");
    //             TempXmlNode.AppendChild(TempXmlNodeTier5);

    //             TempXmlNodeTier6 := ResponseXmlDocument.CreateElement('YourReference');
    //             TempXmlNodeTier6.InnerText := FORMAT(lrec_Ibecor_POData."Ibecor Doc No.");
    //             TempXmlNode.AppendChild(TempXmlNodeTier6);

    //             TempXmlNodeTier7 := ResponseXmlDocument.CreateElement('IbecorDossierNo');
    //             TempXmlNodeTier7.InnerText := FORMAT(lrec_Ibecor_POData."Ibecor Dossier No");
    //             TempXmlNode.AppendChild(TempXmlNodeTier7);

    //             TempXmlNodeTier9 := ResponseXmlDocument.CreateElement('LogisticOfficer');
    //             TempXmlNodeTier9.InnerText := FORMAT(lrec_Ibecor_POData."Logistics Officer");
    //             TempXmlNode.AppendChild(TempXmlNodeTier9);

    //             TempXmlNodeTier10 := ResponseXmlDocument.CreateElement('DocAmount');
    //             TempXmlNodeTier10.InnerText := FORMAT(lrec_Ibecor_POData.Amount);
    //             TempXmlNode.AppendChild(TempXmlNodeTier10);

    //             TempXmlNodeTier11 := ResponseXmlDocument.CreateElement('CurrencyCode');
    //             TempXmlNodeTier11.InnerText := FORMAT(lrec_Ibecor_POData."Currency Code");
    //             TempXmlNode.AppendChild(TempXmlNodeTier11);

    //             TempXmlNodeTier12 := ResponseXmlDocument.CreateElement('Approver');
    //             TempXmlNodeTier12.InnerText := FORMAT(lrec_Ibecor_POData.Approver);
    //             TempXmlNode.AppendChild(TempXmlNodeTier12);

    //             TempXmlNodeTier13 := ResponseXmlDocument.CreateElement('Requestor');
    //             TempXmlNodeTier13.InnerText := FORMAT(lrec_Ibecor_POData.Requestor);
    //             TempXmlNode.AppendChild(TempXmlNodeTier13);

    //             TempXmlNodeTier14 := ResponseXmlDocument.CreateElement('DossierInfo');
    //             TempXmlNode.AppendChild(TempXmlNodeTier14);

    //             TempXmlNodeTier15 := ResponseXmlDocument.CreateElement('Description');
    //             if (lrec_Ibecor_POData."Ibecor Doc No." <> '') then
    //                 if lrec_PFIHeader.GET(lrec_Ibecor_POData."Ibecor Doc No.") then
    //                     TempXmlNodeTier15.InnerText := lrec_PFIHeader.Description
    //                 else
    //                     TempXmlNodeTier15.InnerText := '';
    //             TempXmlNodeTier14.AppendChild(TempXmlNodeTier15);

    //             TempXmlNodeTier16 := ResponseXmlDocument.CreateElement('LicenseInfo');
    //             TempXmlNodeTier14.AppendChild(TempXmlNodeTier16);

    //             TempXmlNodeTier17 := ResponseXmlDocument.CreateElement('LicenseRequired');
    //             //IF (lrec_Ibecor_POData."Licence Number" <> '') THEN  //HEI.09
    //             if lrec_Ibecor_POData."License Required" then  //HEI.09
    //                 TempXmlNodeTier17.InnerText := 'True'
    //             else
    //                 TempXmlNodeTier17.InnerText := 'False';
    //             TempXmlNodeTier16.AppendChild(TempXmlNodeTier17);

    //             TempXmlNodeTier18 := ResponseXmlDocument.CreateElement('LicenseNumber');
    //             TempXmlNodeTier18.InnerText := FORMAT(lrec_Ibecor_POData."Licence Number");
    //             TempXmlNodeTier16.AppendChild(TempXmlNodeTier18);

    //             TempXmlNodeTier19 := ResponseXmlDocument.CreateElement('BankOrOrganismLicense');
    //             TempXmlNodeTier19.InnerText := FORMAT(lrec_Ibecor_POData."Bank Of Organism License");
    //             TempXmlNodeTier16.AppendChild(TempXmlNodeTier19);

    //             TempXmlNodeTier20 := ResponseXmlDocument.CreateElement('DateValidityLicense');
    //             TempXmlNodeTier20.InnerText := FORMAT(lrec_Ibecor_POData."License Expiration Date");
    //             TempXmlNodeTier16.AppendChild(TempXmlNodeTier20);

    //             //HEI.07 >>
    //             //HEI.08 >>
    //             //TempXmlNodeTier28 := ResponseXmlDocument.CreateElement('BankReferenceNumber');
    //             //TempXmlNodeTier28.InnerText := FORMAT(lrec_Ibecor_POData."Bank Reference Number");
    //             //TempXmlNodeTier16.AppendChild(TempXmlNodeTier28);
    //             //HEI.08 <<
    //             TempXmlNodeTier29 := ResponseXmlDocument.CreateElement('CoDCoCNumber');
    //             TempXmlNodeTier29.InnerText := FORMAT(lrec_Ibecor_POData."CoD/CoC Number");
    //             TempXmlNodeTier16.AppendChild(TempXmlNodeTier29);
    //             //HEI.07 <<

    //             TempXmlNodeTier21 := ResponseXmlDocument.CreateElement('CredocInfo');
    //             TempXmlNodeTier14.AppendChild(TempXmlNodeTier21);

    //             TempXmlNodeTier22 := ResponseXmlDocument.CreateElement('CredocRequired');
    //             //IF (lrec_Ibecor_POData."Credit Number" <> '') THEN  //HEI.09
    //             if lrec_Ibecor_POData."Credit Info Required" then  //HEI.09
    //                 TempXmlNodeTier22.InnerText := 'True'
    //             else
    //                 TempXmlNodeTier22.InnerText := 'False';
    //             TempXmlNodeTier21.AppendChild(TempXmlNodeTier22);

    //             if lrec_Ibecor_POData."Credit Info Required" then begin  //HEI.09
    //                 TempXmlNodeTier23 := ResponseXmlDocument.CreateElement('NumberCredocSupplier');
    //                 TempXmlNodeTier23.InnerText := FORMAT(lrec_Ibecor_POData."Credit Number");
    //                 TempXmlNodeTier21.AppendChild(TempXmlNodeTier23);

    //                 TempXmlNodeTier24 := ResponseXmlDocument.CreateElement('AmountCredocSupplier');
    //                 TempXmlNodeTier24.InnerText := FORMAT(lrec_Ibecor_POData."Credit amount Of Supplier");
    //                 TempXmlNodeTier21.AppendChild(TempXmlNodeTier24);

    //                 TempXmlNodeTier25 := ResponseXmlDocument.CreateElement('DateValidityCredit');
    //                 TempXmlNodeTier25.InnerText := FORMAT(lrec_Ibecor_POData."Credit Validity Of Supplier");
    //                 TempXmlNodeTier21.AppendChild(TempXmlNodeTier25);

    //                 TempXmlNodeTier26 := ResponseXmlDocument.CreateElement('LastDateOfShipment');
    //                 TempXmlNodeTier26.InnerText := FORMAT(lrec_Ibecor_POData."Last Date Of Shipment");
    //                 TempXmlNodeTier21.AppendChild(TempXmlNodeTier26);

    //                 TempXmlNodeTier27 := ResponseXmlDocument.CreateElement('BankOrOrganismSupplier');
    //                 TempXmlNodeTier27.InnerText := FORMAT(lrec_Ibecor_POData."Bank Of Organism Supplier");
    //                 TempXmlNodeTier21.AppendChild(TempXmlNodeTier27);
    //                 //HEI.08 >>
    //                 TempXmlNodeTier28 := ResponseXmlDocument.CreateElement('BankReferenceNumber');
    //                 TempXmlNodeTier28.InnerText := FORMAT(lrec_Ibecor_POData."Bank Reference Number");
    //                 TempXmlNodeTier21.AppendChild(TempXmlNodeTier28);
    //                 //HEI.08 <<
    //             end;  //HEI.09
    //             lrec_Ibecor_POData."Movement Status" := lrec_Ibecor_POData."Movement Status"::"Sent to Ibecor";
    //             lrec_Ibecor_POData."Last Send Date" := TODAY;
    //             lrec_Ibecor_POData."Sending Version" += 1;
    //             lrec_Ibecor_POData.MODIFY;
    //         until lrec_Ibecor_POData.NEXT = 0;

    //     ResponsetXml.Blob.CREATEOUTSTREAM(MessageResponseOutStream);
    //     ResponseXmlDocument.Save(MessageResponseOutStream);
    //     //HEI.04<<

    //     //HEI.06>>
    //     CLEAR(RootXmlNode);
    //     CLEAR(TempXmlNode);
    //     CLEAR(TempXmlNodeTier2);
    //     CLEAR(TempXmlNodeTier3);
    //     CLEAR(TempXmlNodeTier4);
    //     CLEAR(TempXmlNodeTier5);
    //     CLEAR(TempXmlNodeTier6);
    //     CLEAR(TempXmlNodeTier7);
    //     CLEAR(TempXmlNodeTier8);
    //     CLEAR(TempXmlNodeTier9);
    //     CLEAR(TempXmlNodeTier10);
    //     CLEAR(TempXmlNodeTier11);
    //     CLEAR(TempXmlNodeTier12);
    //     CLEAR(TempXmlNodeTier13);
    //     CLEAR(TempXmlNodeTier14);
    //     CLEAR(TempXmlNodeTier15);
    //     CLEAR(TempXmlNodeTier16);
    //     CLEAR(TempXmlNodeTier17);
    //     CLEAR(TempXmlNodeTier18);
    //     CLEAR(TempXmlNodeTier19);
    //     CLEAR(TempXmlNodeTier20);
    //     CLEAR(TempXmlNodeTier21);
    //     CLEAR(TempXmlNodeTier22);
    //     CLEAR(TempXmlNodeTier23);
    //     CLEAR(TempXmlNodeTier24);
    //     CLEAR(TempXmlNodeTier25);
    //     CLEAR(TempXmlNodeTier26);
    //     CLEAR(TempXmlNodeTier27);
    //     //HEI.06<<
    // end;
    //BC Upgrade VAMSIU01 End

    procedure ProcessOrderSimulation(var Message: BigText);
    var
        MsgId: Text;
        //BC Upgrade VAMSIU01 >>
        RequestInStream: InStream;
        RequestOutStream: OutStream;
        ResponseInStream: InStream;
        ResponseOutStream: OutStream;
    //BC Upgrade VAMSIU01 <<
    begin
        //HEI.13>>
        //RequestXml.Blob.CREATEOUTSTREAM(MessageOutStream);//BC Upgrade VAMSIU01
        RequestXml.CreateOutStream(MessageOutStream);//BC Upgrade VAMSIU01
        Message.WRITE(MessageOutStream);
        RequestXml.CreateInStream(MessageInStream);//BC Upgrade VAMSIU01
        //RequestXml.Blob.CREATEINSTREAM(MessageInStream);//BC Upgrade VAMSIU01
        if TryLoadXML(Message) then begin

            APIInterfaceLog2.INIT;
            if CheckForMandatoryProcessingNodes then begin

                APIInterfaceLog2.INSERT;
                //BC Upgrade VAMSIU01 >>
                RequestXml.CreateInStream(RequestInStream);
                APIInterfaceLog2."Request File".CreateOutStream(RequestOutStream);
                CopyStream(RequestOutStream, RequestInStream);
                APIInterfaceLog2.MODIFY;
                //BC Upgrade VAMSIU01 <<
                if APIInterfaceLog2."Call Type" = APIInterfaceLog2."Call Type"::Synchronous then begin
                    COMMIT;
                    if CODEUNIT.RUN(APIInterfaceLog2."Processing Codeunit", APIInterfaceLog2) then begin
                        // Processing succeed, Success response to be created and sent
                        APIInterfaceLog2.FIND;
                        CreateOrderSimulationResponse(APIInterfaceLog2);
                        APIInterfaceLog2.VALIDATE(Status, APIInterfaceLog2.Status::Processed);
                        //BC Upgrade VAMSIU01 >>
                        ResponsetXml.CreateInStream(ResponseInStream);
                        APIInterfaceLog2."Response File".CreateOutStream(ResponseOutStream);
                        CopyStream(ResponseOutStream, ResponseInStream);
                        //APIInterfaceLog2."Response File" := ResponsetXml.Blob;
                        //BC Upgrade VAMSIU01 <<
                        APIInterfaceLog2."Response Sync. Date/Time" := CURRENTDATETIME;
                        APIInterfaceLog2.MODIFY;
                    end else begin
                        // Processing failed, to be logged, error response to be sent
                        APIInterfaceLog2.FIND;
                        LastErrorMsg := STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK);
                        CreateResponse(APIInterfaceLog2."Message ID", false, LastErrorMsg);
                        APIInterfaceLog2.VALIDATE(Status, APIInterfaceLog2.Status::Error);
                        APIInterfaceLog2."Error Message".CREATEOUTSTREAM(ErrorOutStream);
                        ErrorOutStream.WRITETEXT(LastErrorMsg);
                        //BC Upgrade VAMSIU01 >>
                        ResponsetXml.CreateInStream(ResponseInStream);
                        APIInterfaceLog2."Response File".CreateOutStream(ResponseOutStream);
                        CopyStream(ResponseOutStream, ResponseInStream);
                        //APIInterfaceLog2."Response File" := ResponsetXml.Blob;
                        //BC Upgrade VAMSIU01 <<
                        APIInterfaceLog2."Response Sync. Date/Time" := CURRENTDATETIME;
                        APIInterfaceLog2.MODIFY;
                    end;
                end;
            end else begin
                LastErrorMsg := STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK);
                CreateResponse(APIInterfaceLog2."Message ID", false, LastErrorMsg);
                LastErrorMsg := STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK);
                CreateResponse(APIInterfaceLog2."Message ID", false, LastErrorMsg);
                APIInterfaceLog2.VALIDATE(Status, APIInterfaceLog2.Status::Error);
                APIInterfaceLog2."Error Message".CREATEOUTSTREAM(ErrorOutStream);
                ErrorOutStream.WRITETEXT(LastErrorMsg);
                //BC Upgrade VAMSIU01 >>
                ResponsetXml.CreateInStream(ResponseInStream);
                APIInterfaceLog2."Response File".CreateOutStream(ResponseOutStream);
                CopyStream(ResponseOutStream, ResponseInStream);
                //APIInterfaceLog2."Response File" := ResponsetXml.Blob;
                //BC Upgrade VAMSIU01 <<
                APIInterfaceLog2."Response Sync. Date/Time" := CURRENTDATETIME;
            end;
        end;
        //ResponsetXml.Blob.CREATEINSTREAM(MessageResponseInStream);//BC Upgrade VAMSIU01
        ResponsetXml.CreateInStream(MessageResponseInStream);//BC Upgrade VAMSIU01
        CLEAR(Message);
        Message.READ(MessageResponseInStream);

        CLEAR(RequestXmlDocument);
        //CLEAR(XmlNode);//BC Upgrade VAMSIU01
        CLEAR(ResponseXmlDocument);
        CLEAR(MessageOutStream);
        CLEAR(MessageInStream);
        CLEAR(MessageResponseInStream);
        CLEAR(ErrorOutStream);
        CLEAR(LastErrorOutStream);
        //HEI.13<<
    end;

    //BC Upgrade VAMSIU01 - Start
    local procedure CreateOrderSimulationResponse(var APIInterfaceLog2: Record "API Interface Log2 INT")
    var
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        TempVATAmountLine2: Record "VAT Amount Line" temporary;
        XmlDoc: XmlDocument;
        RootXmlElement: XmlElement;
        TempXmlElement: XmlElement;
        TempXmlElementHeader: XmlElement;
        TempXmlElementLines: XmlElement;
        TempXmlElementLine: XmlElement;
        TempXmlElementVATLine: XmlElement;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;
        ListPrice: Decimal;
        ListPriceUnit: Decimal;
        DiscountAmount: Decimal;
        TotalDiscountAmount: Decimal;
        TotalLineAmount: Decimal;
        VATAmount: Decimal;
        DocumentAmount: Decimal;
        TransportAmount: Decimal;
        MessageResponseOutStream: OutStream;
    begin
        if APIInterfaceLog2.Entity <> 'SALES' then
            exit;

        SalesHeader.GET(APIInterfaceLog2."Source Subtype", APIInterfaceLog2."Source No.");

        XmlDoc := XmlDocument.Create();
        RootXmlElement := XmlElement.Create('msg');
        XmlDoc.Add(RootXmlElement);

        TempXmlElement := XmlElement.Create('transactionId');
        TempXmlElement.Add(XmlText.Create(APIInterfaceLog2."Message ID"));
        RootXmlElement.Add(TempXmlElement);

        TempXmlElement := XmlElement.Create('senderID');
        TempXmlElement.Add(XmlText.Create('BASE'));
        RootXmlElement.Add(TempXmlElement);

        TempXmlElement := XmlElement.Create('entity');
        TempXmlElement.Add(XmlText.Create(APIInterfaceLog2.Entity));
        RootXmlElement.Add(TempXmlElement);

        TempXmlElement := XmlElement.Create('order');
        RootXmlElement.Add(TempXmlElement);

        TempSalesLine.DELETEALL;
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.CalcVATAmountLines(0, SalesHeader, SalesLine, TempVATAmountLine);

        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        if SalesLine.FINDSET then
            repeat
                GetItemListPrice(SalesLine, ListPrice, TotalLineAmount, TransportAmount);
                TempSalesLine := SalesLine;
                TempSalesLine.Amount := TempSalesLine."Line Amount" + ListPrice;// Total List Price
                TempSalesLine."Amount Including VAT" := SalesLine."Line Amount" + TotalLineAmount; // Total Line Amount excluding Transport
                TempSalesLine."Line Amount" := ROUND(TempSalesLine.Amount / TempSalesLine.Quantity);//List Price
                TempSalesLine."Inv. Discount Amount" := SalesLine."Line Amount" + TotalLineAmount - TempSalesLine.Amount;//Total discount
                TempSalesLine."Line Discount Amount" := ROUND(TempSalesLine."Inv. Discount Amount" / TempSalesLine.Quantity);//Unit Discount
                TempSalesLine.INSERT(false);
                TotalDiscountAmount += TempSalesLine."Inv. Discount Amount";
                DocumentAmount += TempSalesLine.Amount;
            until SalesLine.NEXT = 0;

        TempVATAmountLine.RESET;
        TempVATAmountLine.SETFILTER("VAT %", '<>%1', 0);
        if TempVATAmountLine.FINDSET then
            repeat
                TempVATAmountLine2.SETRANGE("VAT %", TempVATAmountLine."VAT %");
                if TempVATAmountLine2.FINDFIRST then begin
                    TempVATAmountLine2."VAT Amount" += TempVATAmountLine."VAT Amount";
                    TempVATAmountLine2.MODIFY;
                end else begin
                    TempVATAmountLine2 := TempVATAmountLine;
                    TempVATAmountLine2.INSERT;
                end;
                VATAmount += TempVATAmountLine."VAT Amount";
            until TempVATAmountLine.NEXT = 0;

        TempXmlElementHeader := XmlElement.Create('hasWarnings');
        TempXmlElementHeader.Add(XmlText.Create('FALSE'));
        TempXmlElement.Add(TempXmlElementHeader);

        TempXmlElementHeader := XmlElement.Create('SubtotalWithoutTax');
        TempXmlElementHeader.Add(XmlText.Create(FORMAT(DocumentAmount + TotalDiscountAmount, 0, '<Precision,2:2><Standard Format,2>')));
        TempXmlElement.Add(TempXmlElementHeader);

        TempXmlElementHeader := XmlElement.Create('Transport');
        TempXmlElementHeader.Add(XmlText.Create(FORMAT(SalesHeader."Amount Including VAT", 0, '<Precision,2:2><Standard Format,2>')));
        TempXmlElement.Add(TempXmlElementHeader);

        TempXmlElementHeader := XmlElement.Create('Discount');
        TempXmlElementHeader.Add(XmlText.Create(FORMAT(-TotalDiscountAmount, 0, '<Precision,2:2><Standard Format,2>')));
        TempXmlElement.Add(TempXmlElementHeader);

        TempXmlElementHeader := XmlElement.Create('TotalWithTax');
        TempXmlElementHeader.Add(XmlText.Create(FORMAT(TotalDiscountAmount + DocumentAmount + VATAmount, 0, '<Precision,2:2><Standard Format,2>')));
        TempXmlElement.Add(TempXmlElementHeader);

        TempXmlElementLines := XmlElement.Create('VATDetails');
        TempXmlElement.Add(TempXmlElementLines);

        TempVATAmountLine2.RESET;
        if TempVATAmountLine2.FINDSET then begin
            repeat
                TempXmlElementLine := XmlElement.Create('VAT');
                TempXmlElementLines.Add(TempXmlElementLine);

                TempXmlElementVATLine := XmlElement.Create('VAT_PercentRate');
                TempXmlElementVATLine.Add(XmlText.Create(FORMAT(TempVATAmountLine2."VAT %", 0, '<Precision,2:2><Standard Format,2>')));
                TempXmlElementLine.Add(TempXmlElementVATLine);

                TempXmlElementVATLine := XmlElement.Create('VAT_TaxInEuro');
                TempXmlElementVATLine.Add(XmlText.Create(FORMAT(TempVATAmountLine2."VAT Amount", 0, '<Precision,2:2><Standard Format,2>')));
                TempXmlElementLine.Add(TempXmlElementVATLine);
            until TempVATAmountLine2.NEXT = 0;
        end else begin
            TempXmlElementLine := XmlElement.Create('VAT');
            TempXmlElementLines.Add(TempXmlElementLine);

            TempXmlElementVATLine := XmlElement.Create('VAT_PercentRate');
            TempXmlElementVATLine.Add(XmlText.Create(FORMAT(0, 0, '<Precision,2:2><Standard Format,2>')));
            TempXmlElementLine.Add(TempXmlElementVATLine);

            TempXmlElementVATLine := XmlElement.Create('VAT_TaxInEuro');
            TempXmlElementVATLine.Add(XmlText.Create(FORMAT(0, 0, '<Precision,2:2><Standard Format,2>')));
            TempXmlElementLine.Add(TempXmlElementVATLine);
        end;
        TempSalesLine.RESET;
        if TempSalesLine.FINDSET then
            repeat
                TempXmlElementLines := XmlElement.Create('Items');
                TempXmlElement.Add(TempXmlElementLines);

                ListPriceUnit := ROUND(TempSalesLine."Line Amount", 0.01);

                //SKU
                TempXmlElementLine := XmlElement.Create('sku');
                TempXmlElementLine.Add(XmlText.Create(TempSalesLine."No."));
                TempXmlElementLines.Add(TempXmlElementLine);

                //UOM
                TempXmlElementLine := XmlElement.Create('unitOfMeasure');
                TempXmlElementLine.Add(XmlText.Create(TempSalesLine."Unit of Measure Code"));
                TempXmlElementLines.Add(TempXmlElementLine);

                //UnitPrice
                TempXmlElementLine := XmlElement.Create('listPrice');
                TempXmlElementLine.Add(XmlText.Create(FORMAT(ListPriceUnit, 0, '<Precision,2:2><Standard Format,2>')));
                TempXmlElementLines.Add(TempXmlElementLine);

                //discount
                TempXmlElementLine := XmlElement.Create('discountAmount');
                TempXmlElementLine.Add(XmlText.Create(FORMAT(-TempSalesLine."Line Discount Amount", 0, '<Precision,2:2><Standard Format,2>')));
                TempXmlElementLines.Add(TempXmlElementLine);

                //VAT
                TempXmlElementLine := XmlElement.Create('taxPercentRate');
                TempXmlElementLine.Add(XmlText.Create(FORMAT(TempSalesLine."VAT %", 0, '<Precision,2:2><Standard Format,2>')));
                TempXmlElementLines.Add(TempXmlElementLine);
            until TempSalesLine.NEXT = 0;

        ResponsetXml.CREATEOUTSTREAM(MessageResponseOutStream);
        XmlDoc.WriteTo(MessageResponseOutStream);
    end;
    //BC Upgrade VAMSIU01 - End

    // local procedure CreateOrderSimulationResponse(var APIInterfaceLog2: Record "API Interface Log2 INT");
    // var
    //     TempVATAmountLine: Record "VAT Amount Line" temporary;
    //     TempVATAmountLine2: Record "VAT Amount Line" temporary;
    //     RootXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeHeader: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeLines: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeLine: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     TempXmlNodeVATLine: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     SalesHeader: Record "Sales Header";
    //     SalesLine: Record "Sales Line";
    //     TempSalesLine: Record "Sales Line" temporary;
    //     ListPrice: Decimal;
    //     ListPriceUnit: Decimal;
    //     DiscountAmount: Decimal;
    //     TotalDiscountAmount: Decimal;
    //     TotalLineAmount: Decimal;
    //     VATAmount: Decimal;
    //     DocumentAmount: Decimal;
    //     TransportAmount: Decimal;
    // begin
    //     //HEI.13>>
    //     if APIInterfaceLog2.Entity <> 'SALES' then
    //         exit;

    //     SalesHeader.GET(APIInterfaceLog2."Source Subtype", APIInterfaceLog2."Source No.");

    //     ResponseXmlDocument := ResponseXmlDocument.XmlDocument;
    //     RootXmlNode := ResponseXmlDocument.CreateElement('msg');
    //     ResponseXmlDocument.AppendChild(RootXmlNode);
    //     TempXmlNode := ResponseXmlDocument.CreateElement('transactionId');
    //     TempXmlNode.InnerText := APIInterfaceLog2."Message ID";
    //     RootXmlNode.AppendChild(TempXmlNode);
    //     TempXmlNode := ResponseXmlDocument.CreateElement('senderID');
    //     TempXmlNode.InnerText := 'BASE';
    //     RootXmlNode.AppendChild(TempXmlNode);
    //     TempXmlNode := ResponseXmlDocument.CreateElement('entity');
    //     TempXmlNode.InnerText := APIInterfaceLog2.Entity;
    //     RootXmlNode.AppendChild(TempXmlNode);

    //     TempXmlNode := ResponseXmlDocument.CreateElement('order');
    //     ;
    //     RootXmlNode.AppendChild(TempXmlNode);

    //     TempSalesLine.DELETEALL;
    //     SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
    //     SalesLine.SETRANGE("Document No.", SalesHeader."No.");
    //     SalesLine.CalcVATAmountLines(0, SalesHeader, SalesLine, TempVATAmountLine);

    //     SalesLine.SETRANGE(Type, SalesLine.Type::Item);
    //     if SalesLine.FINDSET then
    //         repeat
    //             GetItemListPrice(SalesLine, ListPrice, TotalLineAmount, TransportAmount);
    //             TempSalesLine := SalesLine;
    //             TempSalesLine.Amount := TempSalesLine."Line Amount" + ListPrice;// Total List Price
    //             TempSalesLine."Amount Including VAT" := SalesLine."Line Amount" + TotalLineAmount; // Total Line Amount excluding Transport
    //             TempSalesLine."Line Amount" := ROUND(TempSalesLine.Amount / TempSalesLine.Quantity);//List Price
    //             TempSalesLine."Inv. Discount Amount" := SalesLine."Line Amount" + TotalLineAmount - TempSalesLine.Amount;//Total discount
    //             TempSalesLine."Line Discount Amount" := ROUND(TempSalesLine."Inv. Discount Amount" / TempSalesLine.Quantity);//Unit Discount
    //             TempSalesLine.INSERT(false);
    //             TotalDiscountAmount += TempSalesLine."Inv. Discount Amount";
    //             DocumentAmount += TempSalesLine.Amount;
    //         until SalesLine.NEXT = 0;


    //     TempVATAmountLine.RESET;
    //     TempVATAmountLine.SETFILTER("VAT %", '<>%1', 0);
    //     if TempVATAmountLine.FINDSET then
    //         repeat
    //             TempVATAmountLine2.SETRANGE("VAT %", TempVATAmountLine."VAT %");
    //             if TempVATAmountLine2.FINDFIRST then begin
    //                 TempVATAmountLine2."VAT Amount" += TempVATAmountLine."VAT Amount";
    //                 TempVATAmountLine2.MODIFY;
    //             end else begin
    //                 TempVATAmountLine2 := TempVATAmountLine;
    //                 TempVATAmountLine2.INSERT;
    //             end;
    //             VATAmount += TempVATAmountLine."VAT Amount";
    //         until TempVATAmountLine.NEXT = 0;

    //     TempXmlNodeHeader := ResponseXmlDocument.CreateElement('hasWarnings');
    //     TempXmlNodeHeader.InnerText := 'FALSE';
    //     TempXmlNode.AppendChild(TempXmlNodeHeader);

    //     TempXmlNodeHeader := ResponseXmlDocument.CreateElement('SubtotalWithoutTax');
    //     TempXmlNodeHeader.InnerText := FORMAT(DocumentAmount + TotalDiscountAmount, 0, '<Precision,2:2><Standard Format,2>');
    //     TempXmlNode.AppendChild(TempXmlNodeHeader);

    //     //HEI.14>>
    //     TempXmlNodeHeader := ResponseXmlDocument.CreateElement('Transport');
    //     TempXmlNodeHeader.InnerText := FORMAT(SalesHeader."Doc. Amount Incl. VAT", 0, '<Precision,2:2><Standard Format,2>');
    //     TempXmlNode.AppendChild(TempXmlNodeHeader);
    //     //HEI.14<<

    //     TempXmlNodeHeader := ResponseXmlDocument.CreateElement('Discount');
    //     TempXmlNodeHeader.InnerText := FORMAT(-TotalDiscountAmount, 0, '<Precision,2:2><Standard Format,2>');
    //     TempXmlNode.AppendChild(TempXmlNodeHeader);

    //     TempXmlNodeHeader := ResponseXmlDocument.CreateElement('TotalWithTax');
    //     TempXmlNodeHeader.InnerText := FORMAT(TotalDiscountAmount + DocumentAmount + VATAmount, 0, '<Precision,2:2><Standard Format,2>');
    //     TempXmlNode.AppendChild(TempXmlNodeHeader);

    //     TempXmlNodeLines := ResponseXmlDocument.CreateElement('VATDetails');
    //     ;
    //     TempXmlNode.AppendChild(TempXmlNodeLines);
    //     TempVATAmountLine2.RESET;
    //     if TempVATAmountLine2.FINDSET then begin//HEI.14
    //         repeat
    //             TempXmlNodeLine := ResponseXmlDocument.CreateElement('VAT');
    //             TempXmlNodeLines.AppendChild(TempXmlNodeLine);

    //             TempXmlNodeVATLine := ResponseXmlDocument.CreateElement('VAT_PercentRate');
    //             TempXmlNodeVATLine.InnerText := FORMAT(TempVATAmountLine2."VAT %", 0, '<Precision,2:2><Standard Format,2>');
    //             TempXmlNodeLine.AppendChild(TempXmlNodeVATLine);

    //             TempXmlNodeVATLine := ResponseXmlDocument.CreateElement('VAT_TaxInEuro');
    //             TempXmlNodeVATLine.InnerText := FORMAT(TempVATAmountLine2."VAT Amount", 0, '<Precision,2:2><Standard Format,2>');
    //             TempXmlNodeLine.AppendChild(TempXmlNodeVATLine);
    //         until TempVATAmountLine2.NEXT = 0;
    //         //HEI.14>>
    //     end else begin
    //         TempXmlNodeLine := ResponseXmlDocument.CreateElement('VAT');
    //         TempXmlNodeLines.AppendChild(TempXmlNodeLine);

    //         TempXmlNodeVATLine := ResponseXmlDocument.CreateElement('VAT_PercentRate');
    //         TempXmlNodeVATLine.InnerText := FORMAT(0, 0, '<Precision,2:2><Standard Format,2>');
    //         TempXmlNodeLine.AppendChild(TempXmlNodeVATLine);

    //         TempXmlNodeVATLine := ResponseXmlDocument.CreateElement('VAT_TaxInEuro');
    //         TempXmlNodeVATLine.InnerText := FORMAT(0, 0, '<Precision,2:2><Standard Format,2>');
    //         TempXmlNodeLine.AppendChild(TempXmlNodeVATLine);
    //     end;
    //     //HEI.14<<
    //     TempSalesLine.RESET;
    //     if TempSalesLine.FINDSET then
    //         repeat
    //             TempXmlNodeLines := ResponseXmlDocument.CreateElement('Items');
    //             ;
    //             TempXmlNode.AppendChild(TempXmlNodeLines);

    //             ListPriceUnit := ROUND(TempSalesLine."Line Amount", 0.01);//HEI.14

    //             //SKU
    //             TempXmlNodeLine := ResponseXmlDocument.CreateElement('sku');
    //             TempXmlNodeLine.InnerText := TempSalesLine."No.";
    //             TempXmlNodeLines.AppendChild(TempXmlNodeLine);

    //             //UOM
    //             TempXmlNodeLine := ResponseXmlDocument.CreateElement('unitOfMeasure');
    //             TempXmlNodeLine.InnerText := TempSalesLine."Unit of Measure Code";
    //             TempXmlNodeLines.AppendChild(TempXmlNodeLine);

    //             //UnitPrice
    //             TempXmlNodeLine := ResponseXmlDocument.CreateElement('listPrice');
    //             TempXmlNodeLine.InnerText := FORMAT(ListPriceUnit, 0, '<Precision,2:2><Standard Format,2>');
    //             TempXmlNodeLines.AppendChild(TempXmlNodeLine);

    //             //discount
    //             TempXmlNodeLine := ResponseXmlDocument.CreateElement('discountAmount');
    //             TempXmlNodeLine.InnerText := FORMAT(-TempSalesLine."Line Discount Amount", 0, '<Precision,2:2><Standard Format,2>');
    //             TempXmlNodeLines.AppendChild(TempXmlNodeLine);

    //             //VAT
    //             TempXmlNodeLine := ResponseXmlDocument.CreateElement('taxPercentRate');
    //             TempXmlNodeLine.InnerText := FORMAT(TempSalesLine."VAT %", 0, '<Precision,2:2><Standard Format,2>');
    //             TempXmlNodeLines.AppendChild(TempXmlNodeLine);
    //         until TempSalesLine.NEXT = 0;

    //     ResponsetXml.Blob.CREATEOUTSTREAM(MessageResponseOutStream);
    //     ResponseXmlDocument.Save(MessageResponseOutStream);

    //     CLEAR(RootXmlNode);
    //     CLEAR(TempXmlNode);
    //     CLEAR(TempXmlNodeHeader);
    //     CLEAR(TempXmlNodeLines);
    //     CLEAR(TempXmlNodeLine);
    //     CLEAR(TempXmlNodeVATLine);
    //     CLEAR(MessageResponseOutStream);
    //     //HEI.13<<
    // end;

    local procedure GetB2BInterfaceSetup();
    begin
        //HEI.13>>
        if not B2BInterfaceSetupRead then
            B2BInterfaceSetup.GET;

        B2BInterfaceSetupRead := true;
        //HEI.13<<
    end;

    local procedure GetItemListPrice(SalesLine: Record "Sales Line"; var ListPrice: Decimal; var TotalLineAmount: Decimal; var TransportAmount: Decimal): Decimal;
    var
        AttachedSalesLine: Record "Sales Line";
        LineAmount: Decimal;
    begin
        //HEI.13>>
        CLEAR(ListPrice);
        CLEAR(TotalLineAmount);
        AttachedSalesLine.SETRANGE("Document Type", SalesLine."Document Type");
        AttachedSalesLine.SETRANGE("Document No.", SalesLine."Document No.");
        AttachedSalesLine.SETRANGE("Attached to Line No.", SalesLine."Line No.");
        if AttachedSalesLine.FINDSET then
            repeat
                if IsItemChargeIncluded(AttachedSalesLine."No.") then begin
                    ListPrice += AttachedSalesLine."Line Amount";
                end;
                //HEI.14>>
                if IsTransportItemCharge(AttachedSalesLine."No.") then
                    TransportAmount += AttachedSalesLine."Line Amount"
                //HEI.14<<
                else
                    TotalLineAmount += AttachedSalesLine."Line Amount";
            until AttachedSalesLine.NEXT = 0;
        //HEI.13<<
    end;

    local procedure IsTransportItemCharge(ItemChargeNo: Code[20]): Boolean;
    var
        B2BItemChargesIncExc: Record "B2B Item Charges Inc./Exc. FND";
        SalesLine: Record "Sales Line";
        TransportAmount: Decimal;
    begin
        //HEI.14>>
        B2BItemChargesIncExc.SETRANGE("Item Charge No.", ItemChargeNo);
        B2BItemChargesIncExc.SETRANGE("Include in Transport Amount", true);
        exit(not B2BItemChargesIncExc.ISEMPTY);
        //HEI.14<<
    end;

    local procedure IsItemChargeIncluded(ItemChargeNo: Code[20]): Boolean;
    var
        DOTListPrice: Record "B2B Item Charges Inc./Exc. FND";
    begin
        //HEI.13>>
        DOTListPrice.SETRANGE("Item Charge No.", ItemChargeNo);
        DOTListPrice.SETRANGE("Exclude from List Price", true);
        exit(DOTListPrice.ISEMPTY);
        //HEI.13<<
    end;

}

