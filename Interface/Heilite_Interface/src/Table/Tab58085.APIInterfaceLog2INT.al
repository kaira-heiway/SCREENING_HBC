table 58085 "API Interface Log2 INT"
{
    // Heilite Navision Old Id - 50186   
    // version HEI.10

    // HEI.01 CHG2065153 IBM KUMARN15 23.06.2020
    //   # New table created
    // HEI.02 FDD-HB1268 - CHG2068666 IBM NASTAA02 17.12.2020 # DMS Integration Ivory Coast
    //   # Code added to function 'OpenCreatedRecord'
    // HEI.03 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # New Fields created: 22 - Re-processing Date/Time Post
    //                         23 - Re-processed Posting
    //                         30 - Posting Status
    //                         31 - Posting Error Message
    //                         35 - Payment Jnl Template
    //                         36 - Payment Jnl Batch
    //   # New Functions created
    //   # Code added on Function "OpenCreatedRecord"
    // HEI.04 FDD-HB1234 - CHG2053453 IBM NASTAA02 17.02.2021 # B2B Order Status
    //   # New Field created: 37 - Order ID
    // HEI.05 INC3770544 - CHG2130622 IBM NASTAA02 15.10.2021 # API Entries are unable to be Reprocessed
    //   # Code added to trigger the Auto-Posting when 'Reprocess' is used
    // HEI.06 HB2469 - CHG2122312 IBM NASTAA02 17.11.2021 # Payment API with B2B DOT Interface into HL
    //   # Code added to Function 'OpenPostedDocument'
    // HEI.07 INC4085876 - CHG2156796 IBM NASTAA02 02.05.2022 # Base Error code : 503
    //   # Code added to Function 'Reprocess' in order to re-process the entries with Status = 'Pending'
    // HEI.08 CHG2188870 DEBUSD01 03.02.2023 Sales Order API Performance change flow
    //   # Add field: 24 No. of Re-processed
    //   # Add field: 48 Checking Status
    //   # Add field: 49 Checking Codeunit
    //   # Add field: 54 JobQueue Codeunit
    //   # Add field: 55 Job Queue Sync Date/Time
    //   # Add key  : "Parent Entry No.,Entry No.,Status,Manual,Request Sync. Date/Time"
    //              : "Parent Entry No.,Entry No.,Posting Status,Manual,Request Sync. Date/Time"
    //   # Add functions : SetHideValidationDialog(),IsReadyReprocess(),SetReadyReprocessFilters(),IsReadyReprocessPost(),SetReadyReprocessPostFilters()
    //                     HasRequestFile(),HasResponseFile(),HasErrorFile(),HasPostingErrorFile(),GetLastParentRecEntryNo()
    // HEI.09 CHG2194055 DEBUSD01 07.03.2023 Sales Order API Performance change flow
    //   # Fix functions IsReadyReprocessPost(),SetReadyReprocessPostFilters()
    // HEI.10 CHG2194055 BHANDS01 13.06.2023 API Sales Order Posting Reprocessing Batch
    //   # New field created 56 "Re-processed Posting Batch"
    //   # Code added in Reprocess2()

    // BC Upgrade SHUKLP03 >>
    //Changed from TempBlob Recode to TempBlob Codeunit.
    // BC Upgrade SHUKLP03 <<

    Caption = 'API Interface Log2';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Interface Code"; Code[20])
        {
            Caption = 'Interface Code';
            Description = 'Derived from Entity';
            TableRelation = "Interface Setup INT";
        }
        field(3; "Request Sync. Date/Time"; DateTime)
        {
            Caption = 'Request Sync. Date/Time';
        }
        field(4; "Response Sync. Date/Time"; DateTime)
        {
            Caption = 'Response Sync. Date/Time';
        }
        field(5; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Pending,Error,Processed,Cancelled';
            OptionMembers = Pending,Error,Processed,Cancelled;
        }
        field(6; "Error Message"; BLOB)
        {
            Caption = 'Error Message';
        }
        field(7; "Message ID"; Text[50])
        {
            Caption = 'Message ID';
            Description = 'Optional';
        }
        field(8; "Source System Identifier"; Code[10])
        {
            Caption = 'Source System Identifier';
            TableRelation = "Source Sys Identifier API FND";
        }
        field(9; Entity; Text[10])
        {
            Caption = 'Entity';
        }
        field(10; Operation; Text[10])
        {
            Caption = 'Operation';
        }
        field(11; "File Format"; Option)
        {
            Caption = 'File Format';
            Description = 'Optional';
            OptionCaption = 'XML,JSON';
            OptionMembers = XML,JSON;
        }
        field(12; "Source Request Timestamp"; DateTime)
        {
            Caption = 'Source Request Timestamp';
            Description = 'Optional';
        }
        field(13; "Source Type"; Integer)
        {
            Caption = 'Source Type';
        }
        field(14; "Source Subtype"; Option)
        {
            Caption = 'Source Subtype';
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(15; "Source No."; Code[20])
        {
            Caption = 'Source No.';
        }
        field(16; "Request File"; BLOB)
        {
            Caption = 'Request File';
        }
        field(17; "Response File"; BLOB)
        {
            Caption = 'Response File';
        }
        field(18; "Parent Entry No."; Integer)
        {
            Caption = 'Parent Entry No.';
            TableRelation = "API Interface Log2 INT";
        }
        field(19; Manual; Boolean)
        {
            Caption = 'Manual';
        }
        field(20; "Re-processing Date/Time"; DateTime)
        {
            Caption = 'Re-processing Date/Time';
        }
        field(21; "Re-processed"; Boolean)
        {
            CalcFormula = Exist("API Interface Log2 INT" WHERE("Parent Entry No." = FIELD("Entry No."),
                                                            Manual = CONST(true),
                                                            Status = CONST(Processed)));
            Caption = 'Re-processed';
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Re-processing Date/Time Post"; DateTime)
        {
            Caption = 'Re-processing Posting Date/Time';
            Description = 'HEI.03';
        }
        field(23; "Re-processed Posting"; Boolean)
        {
            CalcFormula = Exist("API Interface Log2 INT" WHERE("Parent Entry No." = FIELD("Entry No."),
                                                            Manual = CONST(true),
                                                            "Posting Status" = CONST(Processed)));
            Caption = 'Re-processed Posting';
            Description = 'HEI.03';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "No. of Re-processed"; Integer)
        {
            CalcFormula = Count("API Interface Log2 INT" WHERE("Parent Entry No." = FIELD("Entry No."),
                                                            "Message ID" = FIELD("Message ID")));
            Caption = 'No. of Re-processed';
            Description = 'HEI.08';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Posting Status"; Option)
        {
            Caption = 'Posting Status';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            OptionCaption = 'Pending,Processed,Error';
            OptionMembers = Pending,Processed,Error;
        }
        field(31; "Posting Error Message"; BLOB)
        {
            Caption = 'Posting Error Message';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(35; "Payment Jnl Template"; Code[10])
        {
            Caption = 'Payment Journal Template';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Gen. Journal Template";
        }
        field(36; "Payment Jnl Batch"; Code[10])
        {
            Caption = 'Payment Journall Batch';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Gen. Journal Batch";
        }
        field(37; "Order ID"; Text[50])
        {
            Caption = 'Order ID';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(48; "Checking Status"; Option)
        {
            Caption = 'Checking Status';
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
            OptionCaption = '" ,Processed,Error"';
            OptionMembers = " ",Processed,Error;
        }
        field(49; "Checking Codeunit"; Integer)
        {
            Caption = 'Checking Codeunit';
            Description = 'HEI.08';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Codeunit));
        }
        field(50; "Processing Codeunit"; Integer)
        {
            Caption = 'Processing Codeunit';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Codeunit));
        }
        field(51; "Call Type"; Option)
        {
            Caption = 'Call Type';
            OptionCaption = 'Synchronous,Asynchronous';
            OptionMembers = Synchronous,Asynchronous;
        }
        field(52; "Job Queue Category Code"; Code[10])
        {
            Caption = 'Job Queue Category Code';
            TableRelation = "Job Queue Category";
        }
        field(53; "Job Queue Entry ID"; Guid)
        {
            Caption = 'Job Queue Entry ID';
        }
        field(54; "Job Queue Codeunit"; Integer)
        {
            Caption = 'Job Queue Codeunit';
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(55; "Job Queue Sync. Date/Time"; DateTime)
        {
            Caption = 'Job Queue Sync. Date/Time';
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(56; "Re-processed Posting Batch"; Boolean)
        {
            Caption = 'Re-processed Posting from Batch';
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Parent Entry No.", "Entry No.", Status, Manual, "Request Sync. Date/Time")
        {
        }
        key(Key3; "Parent Entry No.", "Entry No.", "Posting Status", Manual, "Request Sync. Date/Time")
        {
        }
    }

    fieldgroups
    {
    }

    var
        //TempBlob : Record  temporary;
        TempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
        APIInterfaceSetup2: Record "API Interface Setup2 INT";
        MaxReprocessReachedErr: Label 'cannot re-process more than %1 times.';
        ErrorMsg: Label 'Error Code: %1, Error Text: %2, Call Stack Trace: %3';
        EntryCreatedMsg: Label 'Entry %1 created.';
        WrongStatusErr: Label 'Status can not be %1.';
        HideValidationDialog: Boolean;

    procedure ShowError();
    var
        InStr: InStream;
        OutStr: OutStream;
    begin
        TESTFIELD(Status, Status::Error);
        CALCFIELDS("Error Message");
        if "Error Message".HASVALUE then begin
            "Error Message".CREATEINSTREAM(InStr);
            TempBlob.CREATEOUTSTREAM(OutStr);  // BC Upgrade SHUKLP03 >> Changed from TempBlob to TempBlob Codeunit
            COPYSTREAM(OutStr, InStr);
            FileManagement.BLOBExport(TempBlob, 'ErrorMessage.txt', true);
        end;
    end;

    procedure ShowRequest();
    var
        InStr: InStream;
        OutStr: OutStream;
    begin
        CALCFIELDS("Request File");
        if "Request File".HASVALUE then begin
            "Request File".CREATEINSTREAM(InStr);
            TempBlob.CREATEOUTSTREAM(OutStr);  // BC Upgrade SHUKLP03 >> Changed from TempBlob to TempBlob Codeunit
            COPYSTREAM(OutStr, InStr);
            FileManagement.BLOBExport(TempBlob, 'RequestXML.xml', true);
        end;
    end;

    procedure ShowResponse();
    var
        InStr: InStream;
        OutStr: OutStream;
    begin
        CALCFIELDS("Response File");
        if "Response File".HASVALUE then begin
            "Response File".CREATEINSTREAM(InStr);
            TempBlob.CREATEOUTSTREAM(OutStr);  // BC Upgrade SHUKLP03 >> Changed from TempBlob to TempBlob Codeunit
            COPYSTREAM(OutStr, InStr);
            FileManagement.BLOBExport(TempBlob, 'ResponseXML.xml', true);
        end;
    end;

    procedure Reprocess(): Integer;
    var
        APIInterfaceLog2: Record "API Interface Log2 INT";
    begin
        //HEI.08>>
        Reprocess2(APIInterfaceLog2);
        exit(APIInterfaceLog2."Entry No.");
        //HEI.08<<
    end;

    procedure Reprocess2(var APIInterfaceLog2: Record "API Interface Log2 INT"): Boolean;
    var
        CountAPIInterfaceLog2: Record "API Interface Log2 INT";
        ErrorOutStream: OutStream;
    begin
        //HEI.08>>
        CLEAR(APIInterfaceLog2);
        //HEI.08<<
        //HEI.07>>
        //TESTFIELD(Status,Status::Error);
        if not (Status in [Status::Error, Status::Pending]) then
            ERROR(WrongStatusErr, Status);
        //HEI.07<<

        TESTFIELD(Manual, false);
        CALCFIELDS("Re-processed");
        TESTFIELD("Re-processed", false);
        APIInterfaceSetup2.GET();
        CountAPIInterfaceLog2.SETRANGE("Parent Entry No.", "Entry No.");
        CountAPIInterfaceLog2.SETRANGE(Manual, true);
        if "Message ID" <> '' then
            CountAPIInterfaceLog2.SETRANGE("Message ID", "Message ID");
        if CountAPIInterfaceLog2.COUNT >= APIInterfaceSetup2."Reprocess Count" then
            //HEI.08>>
            //ERROR(MaxReprocessReachedErr,APIInterfaceSetup2."Reprocess Count");
            FIELDERROR("Entry No.", STRSUBSTNO(MaxReprocessReachedErr, APIInterfaceSetup2."Reprocess Count"));
        //HEI.08<<

        //HEI.08>>
        APIInterfaceLog2.LOCKTABLE();
        //HEI.08<<
        APIInterfaceLog2 := Rec;
        APIInterfaceLog2."Entry No." := 0;
        CALCFIELDS("Request File");
        APIInterfaceLog2."Request File" := "Request File";
        APIInterfaceLog2."Request Sync. Date/Time" := CURRENTDATETIME;
        APIInterfaceLog2."Response Sync. Date/Time" := 0DT;
        APIInterfaceLog2.Status := APIInterfaceLog2.Status::Pending;
        APIInterfaceLog2."Parent Entry No." := "Entry No.";
        APIInterfaceLog2.Manual := true;
        //HEI.10>>
        if Rec."Re-processed Posting Batch" then
            APIInterfaceLog2."Re-processed Posting Batch" := false;
        //HEI.10<<
        APIInterfaceLog2.INSERT();
        //HEI.08>>
        if (not HideValidationDialog) and GUIALLOWED then
            //HEI.08<<
            MESSAGE(EntryCreatedMsg, APIInterfaceLog2."Entry No.");

        if APIInterfaceLog2."Call Type" = APIInterfaceLog2."Call Type"::Synchronous then begin
            COMMIT();
            if CODEUNIT.RUN(APIInterfaceLog2."Processing Codeunit", APIInterfaceLog2) then begin
                // Processing succeed
                APIInterfaceLog2.FIND();
                APIInterfaceLog2.Status := APIInterfaceLog2.Status::Processed;
                //HEI.08>>
                if APIInterfaceLog2."Checking Status" = APIInterfaceLog2."Checking Status"::Error then
                    APIInterfaceLog2."Checking Status" := APIInterfaceLog2."Checking Status"::Processed;
                //HEI.08<<
                APIInterfaceLog2."Re-processing Date/Time" := CURRENTDATETIME;
                APIInterfaceLog2.MODIFY();
            end else begin
                // Processing failed
                APIInterfaceLog2.FIND();
                APIInterfaceLog2.Status := APIInterfaceLog2.Status::Error;
                APIInterfaceLog2."Error Message".CREATEOUTSTREAM(ErrorOutStream);
                ErrorOutStream.WRITETEXT(STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK));
                APIInterfaceLog2."Re-processing Date/Time" := CURRENTDATETIME;
                APIInterfaceLog2.MODIFY();
            end;
        end else begin
            // TODO: For future extensibility, enqueue JQ with reprocessing flag (Manual) to have different flow if needed
        end;
        //HEI.08>>
        exit(APIInterfaceLog2.Status = APIInterfaceLog2.Status::Processed);
        //HEI.08<<
    end;

    procedure OpenCreatedRecord();
    var
        SalesHeader: Record "Sales Header";
        GenJournalLine: Record "Gen. Journal Line";
        APIInterfaceSetup: Record "API Interface Setup2 INT";
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
    begin
        //HEI.02>>
        if Entity = 'PAYMENT' then begin
            APIInterfaceSetup.GET();
            TESTFIELD("Source Type", 81);
            //HEI.03>>
            //GenJournalLine.SETRANGE("Journal Template Name",APIInterfaceSetup."Cash Journal Template");
            //GenJournalLine.SETRANGE("Journal Batch Name",APIInterfaceSetup."Cash Journal Batch");
            GenJournalLine.SETRANGE("Document No.", "Source No.");
            GenJournalLine.SETRANGE("Journal Template Name", "Payment Jnl Template");
            GenJournalLine.SETRANGE("Journal Batch Name", "Payment Jnl Batch");
            if GenJournalLine.FINDFIRST() then
                //HEI.03<<
                PAGE.RUN(PAGE::"Cash Receipt Journal", GenJournalLine);
        end else begin
            //HEI.02<<

            TESTFIELD("Source Type");
            TESTFIELD("Source No.");
            case "Source Type" of
                DATABASE::"Sales Header":
                    begin
                        case "Source Subtype" of
                            "Source Subtype"::"1":
                                begin
                                    if SalesHeader.GET(SalesHeader."Document Type"::Order, "Source No.") then
                                        PAGE.RUN(PAGE::"Sales Order", SalesHeader);
                                end;
                            "Source Subtype"::"5":
                                begin
                                    if SalesHeader.GET(SalesHeader."Document Type"::"Return Order", "Source No.") then
                                        PAGE.RUN(PAGE::"Sales Return Order", SalesHeader)
                                        ;
                                end;
                        end;
                    end;
            end;
        end; //HEI.02
    end;

    procedure ShowPostingError();
    var
        InStr: InStream;
        OutStr: OutStream;
    begin
        //HEI.03>>
        TESTFIELD("Posting Status", "Posting Status"::Error);
        CALCFIELDS("Posting Error Message");
        if "Posting Error Message".HASVALUE then begin
            "Posting Error Message".CREATEINSTREAM(InStr);
            TempBlob.CREATEOUTSTREAM(OutStr);  // BC Upgrade SHUKLP03 >> Changed from TempBlob to TempBlob Codeunit
            COPYSTREAM(OutStr, InStr);
            FileManagement.BLOBExport(TempBlob, 'PostingErrorMessage.txt', true);
        end;
        //HEI.03<<
    end;

    procedure ReprocessPosting(ManualCreationReprocess: Boolean): Integer;
    var
        APIInterfaceLog2: Record "API Interface Log2 INT";
    begin
        //HEI.08>>
        ReprocessPosting2(ManualCreationReprocess, APIInterfaceLog2);
        exit(APIInterfaceLog2."Entry No.");
        //HEI.08<<
    end;

    procedure ReprocessPosting2(ManualCreationReprocess: Boolean; var APIInterfaceLog2: Record "API Interface Log2 INT"): Boolean;
    var
        CountAPIInterfaceLog2: Record "API Interface Log2 INT";
        ErrorOutStream: OutStream;
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
    begin
        //HEI.08>>
        CLEAR(APIInterfaceLog2);
        //HEI.08<<
        //HEI.03>>
        //HEI.05>>
        if ManualCreationReprocess then
            TESTFIELD("Posting Status", "Posting Status"::Pending)
        else
            //HEI.05<<
            TESTFIELD("Posting Status", "Posting Status"::Error);
        //TESTFIELD(Manual,FALSE); //HEI.05

        CALCFIELDS("Re-processed Posting");
        TESTFIELD("Re-processed Posting", false);

        APIInterfaceSetup2.GET();
        CountAPIInterfaceLog2.SETRANGE("Parent Entry No.", "Entry No.");
        CountAPIInterfaceLog2.SETRANGE(Manual, true);
        if "Message ID" <> '' then
            CountAPIInterfaceLog2.SETRANGE("Message ID", "Message ID");
        if CountAPIInterfaceLog2.COUNT >= APIInterfaceSetup2."Reprocess Count" then
            //HEI.08>>
            //ERROR(MaxReprocessReachedErr,APIInterfaceSetup2."Reprocess Count");
            FIELDERROR("Entry No.", STRSUBSTNO(MaxReprocessReachedErr, APIInterfaceSetup2."Reprocess Count"));
        //HEI.08<<

        //HEI.08>>
        APIInterfaceLog2.LOCKTABLE();
        //HEI.08<<
        APIInterfaceLog2 := Rec;
        APIInterfaceLog2."Entry No." := 0;
        CALCFIELDS("Request File");
        APIInterfaceLog2."Request File" := "Request File";
        APIInterfaceLog2."Request Sync. Date/Time" := CURRENTDATETIME;
        APIInterfaceLog2."Response Sync. Date/Time" := 0DT;
        APIInterfaceLog2.Status := APIInterfaceLog2.Status::Processed;
        APIInterfaceLog2."Parent Entry No." := "Entry No.";
        APIInterfaceLog2.Manual := true;
        APIInterfaceLog2.INSERT();
        //HEI.08>>
        if (not HideValidationDialog) and GUIALLOWED then
            //HEI.08<<
            MESSAGE(EntryCreatedMsg, APIInterfaceLog2."Entry No.");

        COMMIT();
        if CODEUNIT.RUN(CODEUNIT::"Auto Posting API Interfaces", APIInterfaceLog2) then begin
            // Processing succeed
            APIInterfaceLog2.FIND();
            APIInterfaceLog2."Posting Status" := APIInterfaceLog2."Posting Status"::Processed;
            APIInterfaceLog2."Re-processing Date/Time" := CURRENTDATETIME;
            APIInterfaceLog2.MODIFY();
        end else begin
            // Processing failed
            APIInterfaceLog2.FIND();
            APIInterfaceLog2."Posting Status" := APIInterfaceLog2."Posting Status"::Error;
            APIInterfaceLog2."Posting Error Message".CREATEOUTSTREAM(ErrorOutStream);
            ErrorOutStream.WRITETEXT(STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK));
            APIInterfaceLog2."Re-processing Date/Time" := CURRENTDATETIME;
            APIInterfaceLog2.MODIFY();

            //Delete Whse Shipment in case of posting error
            WarehouseShipmentLine.SETRANGE("Source Type", 37);
            WarehouseShipmentLine.SETRANGE("Source Subtype", WarehouseShipmentLine."Source Subtype"::"1");
            WarehouseShipmentLine.SETRANGE("Source No.", APIInterfaceLog2."Source No.");
            if WarehouseShipmentLine.FINDFIRST() then
                if WarehouseShipmentHeader.GET(WarehouseShipmentLine."No.") then
                    WarehouseShipmentHeader.DELETE(true);

            //Delete Whse Receipt in case of posting error
            WarehouseReceiptLine.SETRANGE("Source Type", 37);
            WarehouseReceiptLine.SETRANGE("Source Subtype", WarehouseReceiptLine."Source Subtype"::"5");
            WarehouseReceiptLine.SETRANGE("Source No.", APIInterfaceLog2."Source No.");
            if WarehouseReceiptLine.FINDFIRST() then
                if WarehouseReceiptHeader.GET(WarehouseReceiptLine."No.") then
                    WarehouseReceiptHeader.DELETE(true);
        end;
        //HEI.08>>
        exit(APIInterfaceLog2."Posting Status" = APIInterfaceLog2."Posting Status"::Processed);
        //HEI.08<<
    end;

    procedure OpenPostedDocument();
    var
        GenJournalLine: Record "Gen. Journal Line";
        APIInterfaceSetup: Record "API Interface Setup2 INT";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        //HEI.03>>
        TESTFIELD("Source Type");
        TESTFIELD("Source No.");
        case "Source Type" of
            DATABASE::"Sales Header":
                begin
                    case "Source Subtype" of
                        "Source Subtype"::"1":
                            begin
                                SalesInvoiceHeader.SETRANGE("Order No.", "Source No.");
                                if SalesInvoiceHeader.FINDFIRST() then
                                    PAGE.RUN(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
                            end;
                        "Source Subtype"::"5":
                            begin
                                SalesCrMemoHeader.SETRANGE("Return Order No.", "Source No.");
                                if SalesCrMemoHeader.FINDFIRST() then
                                    PAGE.RUN(PAGE::"Posted Sales Credit Memo", SalesCrMemoHeader);
                            end;
                    end;
                end;
            //HEI.06>>
            DATABASE::"Gen. Journal Line":
                begin
                    CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Payment);
                    CustLedgerEntry.SETRANGE("Document No.", "Source No.");
                    if CustLedgerEntry.FINDFIRST() then
                        PAGE.RUN(PAGE::"Customer Ledger Entries", CustLedgerEntry);
                end;
        //HEI.06<<
        end;
        //HEI.03<<
    end;

    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean);
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    procedure IsReadyReprocess(): Boolean;
    begin
        //HEI.08>>
        exit((Status in [Status::Error, Status::Pending]) and not (Manual or "Re-processed"));
        //HEI.08<<
    end;

    procedure SetReadyReprocessFilters();
    begin
        //HEI.08>>
        SETFILTER(Status, '%1|%2', Status::Pending, Status::Error);
        SETRANGE(Manual, false);
        SETRANGE("Parent Entry No.", 0);
        //HEI.09>>
        SETRANGE("Re-processed", false);
        //HEI.09<<
        //HEI.08<<
    end;

    procedure IsReadyReprocessPost(ManualCreationReprocess: Boolean): Boolean;
    begin
        //HEI.08>>
        //HEI.09>>
        exit(
           (Status = Status::Processed) and not "Re-processed Posting" and
           ((ManualCreationReprocess and ("Posting Status" = "Posting Status"::Pending)) or
           (not ManualCreationReprocess and ("Posting Status" = "Posting Status"::Error))));
        //HEI.09<<
        //HEI.08<<
    end;

    procedure SetReadyReprocessPostFilters(ManualCreationReprocess: Boolean);
    begin
        //HEI.08>>
        //HEI.09>>
        SETRANGE(Status, Status::Processed);
        SETRANGE("Re-processed Posting", false);
        if ManualCreationReprocess then
            SETRANGE("Posting Status", "Posting Status"::Pending)
        else
            SETRANGE("Posting Status", "Posting Status"::Error);
        //HEI.09<<
        //HEI.08<<
    end;

    procedure HasRequestFile(): Boolean;
    begin
        //HEI.08>>
        Rec.CALCFIELDS("Request File");
        exit(Rec."Request File".HASVALUE);
        //HEI.08<<
    end;

    procedure HasResponseFile(): Boolean;
    begin
        //HEI.08>>
        Rec.CALCFIELDS("Response File");
        exit(Rec."Response File".HASVALUE);
        //HEI.08<<
    end;

    procedure HasErrorFile(): Boolean;
    begin
        //HEI.08>>
        Rec.CALCFIELDS("Error Message");
        exit(Rec."Error Message".HASVALUE);
        //HEI.08<<
    end;

    procedure HasPostingErrorFile(): Boolean;
    begin
        //HEI.08>>
        Rec.CALCFIELDS("Posting Error Message");
        exit(Rec."Posting Error Message".HASVALUE);
        //HEI.08<<
    end;

    procedure GetLastParentRecEntryNo(): Integer;
    var
        Rec2: Record "API Interface Log2 INT";
    begin
        //HEI.08>>
        Rec2.COPY(Rec);
        Rec2.ASCENDING(false);
        if Rec2."Parent Entry No." <> 0 then
            Rec2.SETRANGE("Parent Entry No.", "Parent Entry No.")
        else
            Rec2.SETRANGE("Parent Entry No.", "Entry No.");
        if not Rec2.ISEMPTY then
            if Rec2.FINDFIRST() then
                exit(Rec2."Entry No.");
        //HEI.08<<
    end;
}

