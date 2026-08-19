table 58001 "Interface Entry Header INT"
{
    // Heilite Navision Old Id - 50001
    // version HEI.16

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New table for Interface Common Framework
    // HEI.02 FDD-HNK LOGGAP001 03/12/2017 IBM.CHAUHB01
    //   #New field added: Delivery Date,Mod/Post Date,Return Qty.
    // HEI.03 Cash Van Sales Interface IBM HORTOC01 # new fields
    // HEI.04 FDD_Rwanda_Bralirwa_Esker_ Interface_V0.3_HT75 IBM POSTOI01
    //   # new field RUID 50027
    //   # new field DocumentURL 50028
    //   # new field ImageURL 50029
    // HEI.05 FDD-BA-SLSGAP01 IBM NASTAA02 26.11.2018 # Counterpoint Interface
    //   # New Field created: 700 - Simulation Done
    // HEI.06 FDD-PA-SLSGAP023 IBM BULIMC01 21.02.2019 # New field Pepperi Interface
    // HEI.07 FDD-PURGAP028 IBM GAVANM01 27.03.2019 # Maximo Goods Receipt
    //   # New field created: 50030 - Maximo Issue Type
    // HEI.08 FDD-SR_HT543b KStore Interface IBM HORTOC01 06.06.2019 = new flowfield "Negative Line Exist"
    // HEI.09 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New Field created: 100 - Invoice Discount Amount
    // HEI.10 CHG2026335 HT653 FDD_La Reunion_EDI_EDI Order IBM GAVANM01 04.10.2019
    //   #new fields created: 50031 - Pick Date Time, 50032 - System Date Time, 50033 - Latest Delivery Date Time
    // HEI.11 FDD-HT664 IBM SURYAS01 18-02-2020
    //   #Created new field -"50035 - XML File to Send"
    // HEI.12
    //   # Created new field "Maximo Status"
    // HEI.13 CHG2052621 IBM SHANKJ03 16.07.2020
    //   # Created new field CMG Code
    // HEI.14 INC3036514 IBM NASTAA02 07/09/2020 # Heilite Interface FuturMaster Discount not being proccessed fully
    //   # New Field created: Processing Flag
    //   # Code added to functions "ProcessManually" and "ProcessErrorEntry"
    // 
    // HEI.15 CHG2112261 IBM SAXENA03 20.05.2021
    //   # Interface Logging processing Execution Time and Webservices Response Times
    //   # Added below fields:
    //     50044
    //     50045
    //     50046
    //     50047
    // HEI.16 FDD-HB2060 CHG2103752 IBM NANDIS01 02-03-2022 - Final delivery and PO closure HL  Global Maximo
    //   # Added new option - PendClose in the field "Maximo Status"

    // BC Upgrade MISHRS14 >>
    // Blocked with statement and prefixed variables with DataExch in procedure - ShowXMLDocument
    // BC Upgrade MISHRS14 <<

    Caption = 'Interface Entry Header';

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
            TableRelation = "Interface Setup INT";
        }
        field(3; Direction; Option)
        {
            Caption = 'Direction';
            OptionCaption = 'Inbound,Outbound';
            OptionMembers = Inbound,Outbound;
        }
        field(4; "Sync. Date"; DateTime)
        {
            Caption = 'Synchronize Date';
        }
        field(5; "Archive Date"; DateTime)
        {
            Caption = 'Archive Date';
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Pending,Error,Processed,Cancelled,Manual Entry';
            OptionMembers = Pending,Error,Processed,Cancelled,"Manual Entry";
        }
        field(7; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
        }
        field(10; "Source Type"; Integer)
        {
            Caption = 'Source Type';
        }
        field(11; "Source Subtype"; Option)
        {
            Caption = 'Source Subtype';
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(12; "Source No."; Code[20])
        {
            Caption = 'Source No.';
        }
        field(15; "Source Status"; Option)
        {
            Caption = 'Source Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(16; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(17; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(18; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;
            ValidateTableRelation = false;
        }
        field(19; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
            ValidateTableRelation = false;
        }
        field(20; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            ValidateTableRelation = false;
        }
        field(21; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(22; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount';
        }
        field(23; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
        }
        field(24; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 14;
        }
        field(25; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            TableRelation = Vendor;
            ValidateTableRelation = false;
        }
        field(26; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(27; "Global No."; Code[20])
        {
            Caption = 'Global No.';
        }
        field(30; "Expected Delivery Date"; Date)
        {
            Caption = 'Expected Delivery Date';
        }
        field(31; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
        }
        field(32; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(33; Address; Text[60])
        {
            Caption = 'Address';
        }
        field(34; "Address 2"; Text[60])
        {
            Caption = 'Address 2';
        }
        field(35; Contact; Text[50])
        {
            Caption = 'Contact';

            trigger OnLookup();
            var
                ContactBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
            end;

            trigger OnValidate();
            var
                Cont: Record Contact;
            begin
            end;
        }
        field(36; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code"
            ELSE IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(37; City; Text[35])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            ELSE IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(38; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
            ValidateTableRelation = false;
        }
        field(39; County; Text[30])
        {
            CaptionML = ENU = 'County',
                        FRA = 'Région';
        }
        field(40; "Legal Entity"; Code[10])
        {
            Caption = 'Legal Entity';
        }
        field(41; "House Number"; Code[10])
        {
            Caption = 'House Number';
        }
        field(42; "House Number Supplement"; Code[10])
        {
            Caption = 'House Number Supplement';
        }
        field(45; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(50; "Delete Record"; Boolean)
        {
            Caption = 'Delete Record';
        }
        field(54; Blocked; Boolean)
        {
            Caption = 'Blocked';

            trigger OnValidate();
            var
                Lbln_Allowed: Boolean;
            begin
            end;
        }
        field(61; "Action Code"; Code[10])
        {
            Caption = 'Action Code';
        }
        field(62; "External Contract No."; Code[20])
        {
            Caption = 'External Contract No.';
        }
        field(63; "External Contract Name"; Text[50])
        {
            Caption = 'External Contract Name';
        }
        field(64; "Contract Type"; Code[10])
        {
            Caption = 'Contract Type';
        }
        field(65; "Valid From"; Date)
        {
            Caption = 'Valid From';
        }
        field(66; "Valid To"; Date)
        {
            Caption = 'Valid To';
        }
        field(67; Closed; Boolean)
        {
            Caption = 'Closed';
        }
        field(68; Channel; Code[1])
        {
            Caption = 'Channel';
        }
        field(69; "Type ID"; Code[10])
        {
            Caption = 'Type ID';
        }
        field(70; "Purchasing Organisation"; Code[10])
        {
            Caption = 'Purchasing Organisation';
        }
        field(71; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
            ValidateTableRelation = false;
        }
        field(72; "Shipment Method"; Code[10])
        {
            Caption = 'Shipment Method';
            TableRelation = "Shipment Method";
            ValidateTableRelation = false;
        }
        field(73; "Shipment Method Location"; Text[30])
        {
            Caption = 'Shipment Method Location';
        }
        field(74; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
            ValidateTableRelation = false;
        }
        field(75; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
            ValidateTableRelation = false;
        }
        field(76; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(77; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(78; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(80; "External Order No."; Code[20])
        {
            Caption = 'External Order No.';
            Editable = false;
        }
        field(82; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
            ValidateTableRelation = false;
        }
        field(83; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
            ValidateTableRelation = false;
        }
        field(90; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(91; Notes; BLOB)
        {
            Caption = 'Notes';
        }
        field(92; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
        }
        field(93; "Version No."; Code[10])
        {
            Caption = 'Version No.';
        }
        field(94; "Processing Flag"; Boolean)
        {
            Caption = 'Processing Flag';
            Description = 'HEI.14';
        }
        field(100; "Invoice Discount Amount"; Decimal)
        {
            Caption = 'Invoice Discount Amount';
            Description = 'HEI.09';
        }
        field(110; "External Requisition No."; Code[20])
        {
            Caption = 'External Requisition No.';
        }
        field(200; "Message Name"; Text[30])
        {
        }
        field(201; "Message ID"; Code[35])
        {
            Caption = 'Message ID';
        }
        field(202; "Message Creation DateTime"; DateTime)
        {
            Caption = 'Message Creation DateTime';
        }
        field(203; "Msg. Sender Business System ID"; Text[60])
        {
            Caption = 'Sender Business System ID';
        }
        field(204; "Msg. Recv. Business System ID"; Text[60])
        {
            Caption = 'Receiver Business System ID';
        }
        field(205; "Source System ID"; Code[10])
        {
            Caption = 'Source System ID';
        }
        field(206; "Company Code ID"; Code[10])
        {
            Caption = 'Company Code ID';
        }
        field(210; "Severity Code"; Code[10])
        {
            Caption = 'Severity Code';
        }
        field(211; "Log Message"; Text[200])
        {
            Caption = 'Log Message';
        }
        field(220; "Message Code"; Code[20])
        {
            Caption = 'Message Code';
        }
        field(221; "Message Type"; Code[20])
        {
            Caption = 'Message Type';
        }
        field(222; "Message Class"; Code[20])
        {
            Caption = 'Message Class';
        }
        field(230; "Object Type"; Code[10])
        {
            Caption = 'Object Type';
        }
        field(500; "Data Exch. Entry No."; Integer)
        {
            Caption = 'Data Exch. Entry No.';
            TableRelation = "Data Exch.";
            ValidateTableRelation = false;
        }
        field(505; "Inbound Interface Entry No."; Integer)
        {
            Caption = 'Inbound Interface Entry No.';
        }
        field(700; "Simulation Done"; Boolean)
        {
            Description = 'HEI.05';
        }
        field(50000; "Delivery Date"; DateTime)
        {
        }
        field(50001; "Mod/Post Date"; DateTime)
        {
        }
        field(50002; "Return Qty."; Decimal)
        {
        }
        field(50020; "Transfer-from Code"; Code[10])
        {
            Description = 'HEI.03';
        }
        field(50021; "Transfer-to Code"; Code[10])
        {
            Description = 'HEI.03';
        }
        field(50022; "In-Tranzit Code"; Code[10])
        {
            Description = 'HEI.03';
        }
        field(50023; "Truck Code"; Code[10])
        {
            Description = 'HEI.03';
        }
        field(50024; "Driver Code"; Code[10])
        {
            Description = 'HEI.03';
        }
        field(50025; "Location Code"; Code[10])
        {
            Description = 'HEI.03';
        }
        field(50026; "Bill-to Customer No."; Code[20])
        {
            Description = 'HEI.03';
        }
        field(50027; RUID; Text[100])
        {
            Description = 'HEI.04';
        }
        field(50028; DocumentURL; Text[250])
        {
            Description = 'HEI.04';
        }
        field(50029; ImageURL; Text[250])
        {
            Description = 'HEI.04';
        }
        field(50030; "Maximo Issue Type"; Text[50])
        {
            CalcFormula = Lookup("Interface Entry Line INT"."Description 2" WHERE("Header Entry No." = FIELD("Entry No.")));
            Description = 'HEI.07';
            FieldClass = FlowField;
        }
        field(50031; "Pick Date Time"; DateTime)
        {
            Description = 'HEI.10';
        }
        field(50032; "System Date Time"; DateTime)
        {
            Description = 'HEI.10';
        }
        field(50033; "Latest Delivery Date Time"; DateTime)
        {
            Description = 'HEI.10';
        }
        field(50035; "XML File to Send"; BLOB)
        {
            Description = 'HEI.11';
        }
        field(50036; "CMG Code"; Code[20])
        {
            Caption = 'CMG_Code';
            Description = 'HEI.13';
        }
        field(50043; "Maximo Status"; Option)
        {
            Caption = 'Maximo Status';
            Description = 'HEI.12,HEI.16';
            Editable = false;
            OptionMembers = " ",Approved,Canceled,Closed,"Waiting on Approval",PendClose;
        }
        field(50044; "Start Execution"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
        }
        field(50045; "End Execution"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
        }
        field(50046; "Send Request"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
        }
        field(50047; "Get Response"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
        }
        field(60000; "Pepperi Interface"; Boolean)
        {
            CalcFormula = Lookup("Interface Setup INT"."Pepperi Interface" WHERE(Code = FIELD("Interface Code")));
            Caption = 'Pepperi Interface';
            Description = 'HEI.06';
            FieldClass = FlowField;
        }
        field(70000; "Negative Line Exist"; Boolean)
        {
            CalcFormula = Exist("Interface Entry Line INT" WHERE("Header Entry No." = FIELD("Entry No."),
                                                              Quantity = FILTER(< 0)));
            Description = 'HEI.08';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; Direction, Status)
        {
        }
        key(Key3; "Interface Code", Status)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        "Sync. Date" := CURRENTDATETIME;
    end;

    var
        NoErrorMsg: Label 'There is no error message.';
        BlobIsEmptyErr: Label 'The entry does not contain any description data.';
        NoXmlAttachedErr: Label 'There is no xml document attached to this entry.';

    procedure OpenRecord();
    var
        RecRef: RecordRef;
        RecRefVariant: Variant;
    begin
        if "Source Type" <> 0 then begin
            RecRef.OPEN("Source Type");
            RecRefVariant := RecRef;
            PAGE.RUN(RecRefVariant);
        end;
    end;

    procedure ShowErrorMessage();
    var
        e: Text;
    begin
        e := "Error Message";
        if e = '' then
            e := NoErrorMsg;
        MESSAGE(e);
    end;

    procedure ClearError();
    begin
        TESTFIELD(Status, Status::Error);
        Status := Status::Pending;
        "Error Message" := '';
        MODIFY();
    end;

    procedure ProcessManually();
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //HEI.14>>
        InterfaceSetup.GET("Interface Code");
        if InterfaceSetup."Enable Processing Flag" then
            TESTFIELD("Processing Flag");
        //HEI.14<<

        if Direction = Direction::Inbound then begin
            CODEUNIT.RUN(CODEUNIT::"Inbound Interface Processing", Rec);
            InterfaceFrameworkMgt.SetInterfaceProcessed(Rec);
            InterfaceFrameworkMgt.LogInterfaceEntries(Rec);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(Rec);
        end else begin
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", Rec);
            InterfaceFrameworkMgt.SetInterfaceProcessed(Rec);
            InterfaceFrameworkMgt.LogInterfaceEntries(Rec);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(Rec);
        end;
    end;

    procedure ProcessErrorEntry();
    var
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //HEI.14>>
        InterfaceSetup.GET("Interface Code");
        if InterfaceSetup."Enable Processing Flag" then
            TESTFIELD("Processing Flag");
        //HEI.14<<

        ClearError();
        ProcessManually();
    end;

    procedure SaveManualEntry();
    begin
        if Status <> Status::"Manual Entry" then
            exit;

        Status := Status::Pending;
        MODIFY();
    end;

    procedure ShowNotes();
    var
        //TempBlob: Record TempBlob;  // BC Upgrade NANDIS03
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03
        FileManagement: Codeunit "File Management";
        InStr: InStream;
        OutStr: OutStream;
    begin
        if Notes.HASVALUE then begin
            CALCFIELDS(Notes);
            Notes.CREATEINSTREAM(InStr);
            //TempBlob.Blob.CREATEOUTSTREAM(OutStr);  // BC Upgrade NANDIS03
            TempBlob.CREATEOUTSTREAM(OutStr);  // BC Upgrade NANDIS03
            COPYSTREAM(OutStr, InStr);
            FileManagement.BLOBExport(TempBlob, '.txt', true);
        end else
            MESSAGE(BlobIsEmptyErr);
    end;

    procedure ShowXmlDocument();
    var
        DataExch: Record "Data Exch.";
        //TempBlob: Record TempBlob;  // BC Upgrade NANDIS03
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03
        FileManagement: Codeunit "File Management";
        InStr: InStream;
        OutStr: OutStream;
        FileName: text;
    begin
        if DataExch.GET("Data Exch. Entry No.") then
            if (DataExch."Parent Data Exch. No. FND" <> 0) and (DataExch."Entry No." <> DataExch."Parent Data Exch. No. FND") then
                DataExch.GET(DataExch."Parent Data Exch. No. FND");


        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variables with DataExch in procedure - ShowXMLDocument
        // with DataExch do
        //     if "File Content".HASVALUE then begin
        //         CALCFIELDS("File Content");
        //         "File Content".CREATEINSTREAM(InStr);
        //         //TempBlob.Blob.CREATEOUTSTREAM(OutStr);  // BC Upgrade NANDIS03
        //         TempBlob.CREATEOUTSTREAM(OutStr);  // BC Upgrade NANDIS03
        //         COPYSTREAM(OutStr, InStr);
        //         FileManagement.BLOBExport(TempBlob, '.xml', true);
        //     end else
        //         MESSAGE(NoXmlAttachedErr);

        //with DataExch do
        if DataExch."File Content".HASVALUE then begin
            DataExch.CALCFIELDS("File Content");
            DataExch."File Content".CREATEINSTREAM(InStr);
            //TempBlob.Blob.CREATEOUTSTREAM(OutStr);  // BC Upgrade NANDIS03
            TempBlob.CREATEOUTSTREAM(OutStr);  // BC Upgrade NANDIS03
            COPYSTREAM(OutStr, InStr);
            FileName := Rec."Interface Code" + '.xml'; // BC Upgrade BHARDA11 
            // FileManagement.BLOBExport(TempBlob, '.xml', true);
            FileManagement.BLOBExport(TempBlob, FileName, true); // BC Upgrade BHARAD11 --Add file name
        end else
            MESSAGE(NoXmlAttachedErr);
        // BC Upgrade MISHRS14 <<
    end;
}

