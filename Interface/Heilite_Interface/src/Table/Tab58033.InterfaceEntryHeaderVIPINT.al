table 58033 "Interface Entry Header VIP INT"
{
    // Heilite Navision Old Id - 50161
    // version HEI.14

    // HEI.01 HT1010 IBM NASTAA02 28.11.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # New Table created
    // HEI.03 CHG2068423 IBM KUMARN15 01.07.2020
    //   # New fields added 69 - Type ID, 90 - Description, 92 - Your Reference, 93 - Version No., 220 - Message Code
    // HEI.04 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    // # New fields added:
    //     115 - Shipment Method Code
    //     116 - ApproverID
    //     117 - Requested Receipt Date
    //     118 - Expected Receipt Date
    //     119 -Vendor Shipment No.
    // HEI.05 CHG2095187 IBM SAXENA03 08.02.2021
    //   # Code written for Paraller Request
    //   # Replaced DataExch. record table with DataExch.VIP
    //   # Replaced DataExch. record table with DataExch.VIP in field 500 in RelatedTable.
    //   # Replaced DataExch. record table with DataExch.VIP in Function ShowXmlDocument()
    // HEI.06 INC3464639 IBM GAVANM01 08.02.2021 #Issue with approval apps Panama: can't convert value to decimal
    //   # new field created: 600 - Overdue
    // HEI.07 CHG2112261 IBM SAXENA03 20.05.2021
    //   # Interface Logging processing Execution Time and Webservices Response Times
    //   # Added below fields:
    //     50001
    //     50002
    //     50003
    //     50004
    // HEI.08 CHG2094470 IBM BHATTA09 20.05.2021
    //   # Added below fields:
    //     106
    //     109
    // HEI.11 CHG2151260-HB2788 SOICAD02 08.11.2022 New fields ID 150 - 157
    // HEI.09 CHG2149734 SAHAL01 07.09.2022
    //   # Created New Fields: 130 - Prod. Order Item No.
    //                         131 - Prod. Order Line No.
    //                         132 - Zone Code
    //                         133 - Bin Code
    //                         135 - Starting Date
    //                         136 - Starting Time
    //                         137 - Starting Date-Time
    //                         138 - EAN
    //                         140 - Quantity
    // HEI.10 CHG2147859 SAHAL01 02.09.2022
    //   # Created New Fields: 8 - Last Parked Date (Local)
    //                         9 - Last Parked Time (Local)
    //   # Added Code
    // HEI.11 CHG2151260-HB2788 SOICAD02 08.11.2022 New fields ID 150 - 157
    // HEI.12 CHG2178366-HB3189 IBM COSTES04 15.02.2023 Customer Masterdata interface to DOT change
    //   # New fields 158 - 172
    // HEI.13 CHG2194603 SISUM01 25.10.2023 HB3289-Electronic invoice interface Panama
    //   # new field id - 700 - URL
    // HEI.14 CHG2210794 SAHAL01 08.03.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Fields: 50 - Action Code
    //                         53 - External Order No.
    //                         54 - External Order Line No.
    //                         56 - Shipment Method Location
    //                         57 - Salesperson/Purchaser Code
    //                         58 - Contact
    // HEI.15 CHG2335817 IBM SAHAL01 29.01.2026 To restrict users not to process Zycus errors in HeiLite
    //   # Added Code

    // BC Upgrade PATELS08 >>
    // # Tag HEI.15 added and the related code.
    // BC Upgrade PATELS08 <<

    //BC Upgrade VAMSIU01 - Start >>
    // # Chnaged the Variables in ShowDocument Procedure from Data Exch. VIP to Data Exch.
    //BC Upgrade VAMSIU01 - End <<
    Caption = 'Interface Entry Header VIP';

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
        field(8; "Last Parked Date (Local)"; Date)
        {
            Caption = 'Last Parked Date (Local)';
            Description = 'HEI.10';
            Editable = false;
        }
        field(9; "Last Parked Time (Local)"; Time)
        {
            Caption = 'Last Parked Time (Local)';
            Description = 'HEI.10';
            Editable = false;
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
            DataClassification = ToBeClassified;
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
        field(28; "Location Code"; Code[10])
        {
        }
        field(29; "Bill-to Customer No."; Code[20])
        {
        }
        field(32; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(33; Address; Text[60])
        {
            Caption = 'Address';
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
        field(50; "Action Code"; Code[2])
        {
            Caption = 'Action Code';
            Description = 'HEI.14';
        }
        field(53; "External Order No."; Code[20])
        {
            Caption = 'External Order No.';
            Description = 'HEI.14';
        }
        field(54; "External Order Line No."; Integer)
        {
            Caption = 'External Order Line No.';
            Description = 'HEI.14';
        }
        field(56; "Shipment Method Location"; Text[30])
        {
            Caption = 'Shipment Method Location';
            Description = 'HEI.14';
        }
        field(57; "Salesperson/Purchaser Code"; Code[10])
        {
            Caption = 'Salesperson/Purchaser Code';
            Description = 'HEI.14';
            TableRelation = "Salesperson/Purchaser";
            ValidateTableRelation = false;
        }
        field(58; Contact; Text[30])
        {
            Caption = 'Contact';
            Description = 'HEI.14';
        }
        field(67; Closed; Boolean)
        {
            Caption = 'Closed';
        }
        field(69; "Type ID"; Code[10])
        {
            Caption = 'Type ID';
            Description = 'HEI.03';
        }
        field(74; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
            ValidateTableRelation = false;
        }
        field(90; Description; Text[50])
        {
            Caption = 'Description';
            Description = 'HEI.03';
        }
        field(91; Notes; BLOB)
        {
            Caption = 'Notes';
        }
        field(92; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
            Description = 'HEI.03';
        }
        field(93; "Version No."; Code[10])
        {
            Caption = 'Version No.';
            Description = 'HEI.03';
        }
        field(100; "Invoice Discount Amount"; Decimal)
        {
            Caption = 'Invoice Discount Amount';
        }
        field(106; Comment; Text[80])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(109; "Delivery Method"; Text[50])
        {
            Caption = 'Delivery Method';
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(115; "Shipment Method Code"; Code[10])
        {
            CaptionML = ENU = 'Shipment Method Code',
                        FRA = 'Code condition livraison';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "Shipment Method";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(116; ApproverID; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "User Setup";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(117; "Requested Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(118; "Expected Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(119; "Vendor Shipment No."; Code[35])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(130; "Prod. Order Item No."; Code[20])
        {
            Caption = 'Prod. Order Item No.';
            Description = 'HEI.09';
            TableRelation = Item;
        }
        field(131; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            Description = 'HEI.09';
        }
        field(132; "Zone Code"; Code[10])
        {
            Caption = 'Zone Code';
            Description = 'HEI.09';
            TableRelation = Zone.Code;
        }
        field(133; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            Description = 'HEI.09';
            TableRelation = Bin.Code;
        }
        field(135; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            Description = 'HEI.09';
        }
        field(136; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
            Description = 'HEI.09';
        }
        field(137; "Starting Date-Time"; DateTime)
        {
            Caption = 'Starting Date-Time';
            Description = 'HEI.09';
        }
        field(138; EAN; Code[20])
        {
            Caption = 'EAN';
            Description = 'HEI.09';
        }
        field(140; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.09';
        }
        field(150; "Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(151; "Legal Form"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(152; Name2; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(153; Name3; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(154; Name4; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(155; Name5; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(156; Name6; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(157; Name7; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(158; Name8; Text[50])
        {
            Caption = 'Name8';
            DataClassification = CustomerContent;
            Description = 'HEI.12';
        }
        field(159; Name9; Text[50])
        {
            Caption = 'Name9';
            DataClassification = CustomerContent;
            Description = 'HEI.12';
        }
        field(160; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
            Description = 'HEI.12';
        }
        field(161; "Address 3"; Text[60])
        {
            Caption = 'Address 3';
            DataClassification = CustomerContent;
            Description = 'HEI.12';
        }
        field(162; "Address 4"; Text[60])
        {
            Caption = 'Address 4';
            DataClassification = CustomerContent;
            Description = 'HEI.12';
        }
        field(163; "Address 5"; Text[60])
        {
            Caption = 'Address 5';
            DataClassification = CustomerContent;
            Description = 'HEI.12';
        }
        field(164; "Business Segment Name"; Text[50])
        {
            Caption = 'Business Segment Name';
            DataClassification = CustomerContent;
            Description = 'HEI.12';
        }
        field(165; "Business Seg. Org. Name"; Text[50])
        {
            Caption = 'Business Seg. Org. Name';
            DataClassification = CustomerContent;
            Description = 'HEI.12';
        }
        field(166; "Customer Type"; Code[20])
        {
            Caption = 'Customer Type';
            DataClassification = CustomerContent;
            Description = 'HEI.12';
        }
        field(167; "Customer Type Name"; Text[50])
        {
            Caption = 'Customer Type Name';
            DataClassification = CustomerContent;
            Description = 'HEI.12';
        }
        field(168; "Customer Subtype"; Code[20])
        {
            Caption = 'Customer Subtype';
            DataClassification = CustomerContent;
            Description = 'HEI.12';
        }
        field(169; "Customer Subtype Name"; Text[50])
        {
            Caption = 'Customer Subtype Name';
            DataClassification = CustomerContent;
            Description = 'HEI.12';
        }
        field(170; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
            DataClassification = CustomerContent;
            Description = 'HEI.12';
        }
        field(171; "External Contract No."; Code[10])
        {
            Caption = 'External Contract No.';
            DataClassification = CustomerContent;
            Description = 'HEI.12';
        }
        field(172; "Flag for Deletion"; Boolean)
        {
            Caption = 'Flag for Deletion';
            DataClassification = CustomerContent;
            Description = 'HEI.12';
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
        field(220; "Message Code"; Code[20])
        {
            Caption = 'Message Code';
            Description = 'HEI.03';
        }
        field(500; "Data Exch. Entry No."; Integer)
        {
            Caption = 'Data Exch. Entry No.';
            //TableRelation = "Data Exch. VIP";
            TableRelation = "Data Exch.";//BC Upgrade VAMSIU01 Changed from Data Exch VIP to Data Exch.>>
            ValidateTableRelation = false;
        }
        field(505; "Inbound Interface Entry No."; Integer)
        {
            Caption = 'Inbound Interface Entry No.';
        }
        field(600; Overdue; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
        }
        field(700; URL; Text[250])
        {
            Caption = 'URL';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(50001; "Start Execution"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(50002; "End Execution"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(50003; "Send Request"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(50004; "Get Response"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
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
    var
        DateFilterCalcL: Codeunit "DateFilter-Calc";
        NowL: DateTime;
    begin
        "Sync. Date" := CURRENTDATETIME;
        //HEI.10>>
        NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
        "Last Parked Date (Local)" := DT2DATE(NowL);
        "Last Parked Time (Local)" := DT2TIME(NowL);
        //HEI.10<<
    end;

    trigger OnModify();
    var
        DateFilterCalcL: Codeunit "DateFilter-Calc";
        NowL: DateTime;
    begin
        //HEI.10>>
        NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
        "Last Parked Date (Local)" := DT2DATE(NowL);
        "Last Parked Time (Local)" := DT2TIME(NowL);
        //HEI.10<<
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
    var
        // BC Upgrade PATELS08 >>
        //HEI.15 >>
        InterfaceSetupL : Record "Interface Setup INT";
        Text000L: Label 'Reprocessing of Inbound VIP Interface entry is blocked for Interface Code %1. Please reach out to the source system to send the Interface entry again to HeiLite.';
        //HEI.15 <<
        // BC Upgrade PATELS08 <<
    begin
        TESTFIELD(Status, Status::Error);
        // BC Upgrade PATELS08 >>
        //HEI.15>>
        IF InterfaceSetupL.GET("Interface Code") AND ("Interface Code" <> '') THEN BEGIN
        IF (InterfaceSetupL.Direction = InterfaceSetupL.Direction::Inbound) AND InterfaceSetupL."Block to Reprocess VIP Error" THEN
            ERROR(Text000L,"Interface Code");
        END;
        //HEI.15<<
        // BC Upgrade PATELS08 <<
        Status := Status::Pending;
        "Error Message" := '';
        MODIFY();
    end;

    procedure ProcessManually();
    var
        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt. VIP";
    begin
        if Direction = Direction::Inbound then begin
            CODEUNIT.RUN(CODEUNIT::"Inbound Interface Process VIP", Rec);
            InterfaceFrameworkMgtVIP.SetInterfaceProcessed(Rec);
            InterfaceFrameworkMgtVIP.LogInterfaceEntries(Rec);
            InterfaceFrameworkMgtVIP.DeleteInterfaceEntries(Rec);
        end else begin
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Process VIP", Rec);
            InterfaceFrameworkMgtVIP.SetInterfaceProcessed(Rec);
            InterfaceFrameworkMgtVIP.LogInterfaceEntries(Rec);
            InterfaceFrameworkMgtVIP.DeleteInterfaceEntries(Rec);
        end;
    end;

    procedure ProcessErrorEntry();
    begin
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
        //TempBlob: Record TempBlob;  // BC Upgrade NANDIS03 - BLocked as TempBlob Record is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Added as TempBlob Record is obsolete is this CU is introduced
        FileManagement: Codeunit "File Management";
        InStr: InStream;
        OutStr: OutStream;
    begin
        if Notes.HASVALUE then begin
            CALCFIELDS(Notes);
            Notes.CREATEINSTREAM(InStr);
            //TempBlob.Blob.CREATEOUTSTREAM(OutStr);  // BC Upgrade NANDIS03 - BLocked as TempBlob Record is obsolete
            TempBlob.CREATEOUTSTREAM(OutStr);  // BC Upgrade NANDIS03 - Added as TempBlob Record is obsolete
            COPYSTREAM(OutStr, InStr);
            FileManagement.BLOBExport(TempBlob, '.txt', true);
        end else
            MESSAGE(BlobIsEmptyErr);
    end;

    procedure ShowXmlDocument();
    var
        //BC Upgrade VAMSIU01 >>
        // DataExchVIP: Record "Data Exch. VIP";
        DataExchVIP: Record "Data Exch.";
        //BC Upgrade VAMSIU01 <<
        //TempBlob: Record TempBlob;  // BC Upgrade NANDIS03 - BLocked as TempBlob Record is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Added as TempBlob Record is obsolete is this CU is introduced
        FileManagement: Codeunit "File Management";
        InStr: InStream;
        OutStr: OutStream;
        FileName: Text;
    begin
        //<<HEI.05
        /*
        IF DataExch.GET("Data Exch. Entry No.") THEN
          IF (DataExch."Parent Data Exch. No." <> 0) AND (DataExch."Entry No." <> DataExch."Parent Data Exch. No.") THEN
            DataExch.GET(DataExch."Parent Data Exch. No.");
        WITH DataExch DO
        */
        if DataExchVIP.GET("Data Exch. Entry No.") then
            if (DataExchVIP."Parent Data Exch. No. FND" <> 0) and (DataExchVIP."Entry No." <> DataExchVIP."Parent Data Exch. No. FND") then
                DataExchVIP.GET(DataExchVIP."Parent Data Exch. No. FND");

        // BC Upgrade MISHRS14 >>  
        // Blocked with statement and prefixed variables with DataExchVIP       
        // with DataExchVIP do
        //     //>>HEI.05
        //     if "File Content".HASVALUE then begin
        //         CALCFIELDS("File Content");
        //         "File Content".CREATEINSTREAM(InStr);
        //         //TempBlob.Blob.CREATEOUTSTREAM(OutStr);  // BC Upgrade NANDIS03 - BLocked as TempBlob Record is obsolete
        //         TempBlob.CREATEOUTSTREAM(OutStr);  // BC Upgrade NANDIS03 - Added as TempBlob Record is obsolete
        //         COPYSTREAM(OutStr, InStr);
        //         FileManagement.BLOBExport(TempBlob, '.xml', true);
        //     end else
        //         MESSAGE(NoXmlAttachedErr);

        //with DataExchVIP do
        //>>HEI.05
        if DataExchVIP."File Content".HASVALUE then begin
            DataExchVIP.CALCFIELDS(DataExchVIP."File Content");
            DataExchVIP."File Content".CREATEINSTREAM(InStr);
            //TempBlob.Blob.CREATEOUTSTREAM(OutStr);  // BC Upgrade NANDIS03 - BLocked as TempBlob Record is obsolete
            TempBlob.CREATEOUTSTREAM(OutStr);  // BC Upgrade NANDIS03 - Added as TempBlob Record is obsolete
            FileName := Rec."Interface Code" + '-' + Format(Rec."Entry No.") + '.xml';//BC Upgrade SHARMP16--Interface

            COPYSTREAM(OutStr, InStr);
            FileManagement.BLOBExport(TempBlob, '.xml', true);
        end else
            MESSAGE(NoXmlAttachedErr);

        // BC Upgrade MISHRS14 <<

    end;
}

