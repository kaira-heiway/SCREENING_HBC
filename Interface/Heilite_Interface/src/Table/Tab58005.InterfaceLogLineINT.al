table 58005 "Interface Log Line INT"
{
    // Heilite Navision Old Id - 50005
    // version HEI.05

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New table for Interface Common Framework
    // HEI.02 FDD-PURGAP025 IBM LAZARE02 26.07.2018 # New fields E-Mail, Payment Terms Code
    // HEI.03 Cash Van Sales Interface IBM HORTOC01 # new fields
    // HEI.04 FDD_Rwanda_Bralirwa_Esker_ Interface_V0.3_HT75 IBM POSTOI01
    //   # new E-Mail 2 field
    // HEI.06 RW-GAPLOG08 IBM LAZARE02 01.11.2018 # New fields
    // HEI.07 FDD-BA-SLSGAP01 IBM NASTAA02 23.11.2018 # Counterpoint Interface
    //   # New Field created: 25 - Posting Date
    //                        99 - Amount Incl. VAT
    //                        703 - Tax Code
    //                        704 - Event Date
    //                        705 - Reference
    // HEI.10 FDD-PURGAP028 IBM GAVANM01 26.03.2019 # Maximo Goods Receipt
    // # New FlowFields created: 710 - Maximo Source Type
    //                             711 - Maximo Source No.
    // 
    // HEI.11 CHG2035787 IBM KUMARN15 29.10.2019
    //   # For field 42, "Order No." size increased from 20 to 35

    Caption = 'Interface Log Line';

    fields
    {
        field(1; "Header Entry No."; Integer)
        {
            Caption = 'Header Entry No.';
            NotBlank = true;
            TableRelation = "Interface Entry Header INT";
        }
        field(2; "Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Entry No.';
        }
        field(3; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = '" ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)"';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE IF (Type = CONST(Item)) Item
            ELSE IF (Type = CONST(Resource)) Resource
            ELSE IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE IF (Type = CONST("Charge (Item)")) "Item Charge";
            ValidateTableRelation = false;
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(9; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(10; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
            ValidateTableRelation = false;
        }
        field(11; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(12; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            ValidateTableRelation = false;
        }
        field(13; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            ValidateTableRelation = false;
        }
        field(14; "Unit Amount"; Decimal)
        {
            Caption = 'Unit Amount';
            DecimalPlaces = 2 : 5;
        }
        field(15; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            DecimalPlaces = 2 : 2;
        }
        field(16; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
        }
        field(17; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
            Description = 'HEI.05';
        }
        field(18; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;
            ValidateTableRelation = false;
        }
        field(20; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            ValidateTableRelation = false;
        }
        field(21; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            ValidateTableRelation = false;
        }
        field(25; "Posting Date"; Date)
        {
            Description = 'HEI.07';
        }
        field(26; "Global No."; Code[20])
        {
            Caption = 'Global No.';
        }
        field(27; "Discount %"; Decimal)
        {
            Caption = 'Discount %';
            Description = 'HEI.07';
            MaxValue = 100;
            MinValue = 0;
        }
        field(28; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
            Description = 'HEI.05';
        }
        field(29; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(30; "Expected Delivery Date"; Date)
        {
            Caption = 'Expected Delivery Date';
        }
        field(31; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
        }
        field(32; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(35; "Cross Reference No."; Code[20])
        {
        }
        field(36; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(40; "Blanket Order No."; Code[20])
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            Caption = 'Blanket Order No.';
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = CONST("Blanket Order"));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(41; "Blanket Order Line No."; Integer)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            Caption = 'Blanket Order Line No.';
            TableRelation = "Purchase Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"),
                                                              "Document No." = FIELD("Blanket Order No."));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(42; "Order No."; Code[35])
        {
            Caption = 'Order No.';
            Description = 'HEI.11';
        }
        field(43; "Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
        }
        field(44; "Zone Code"; Code[10])
        {
            Caption = 'Zone Code';
        }
        field(45; "New Location Code"; Code[10])
        {
            Caption = 'New Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate();
            var
            // lCurrFieldNo: Integer;
            begin
            end;
        }
        field(46; "New Zone Code"; Code[10])
        {
            Caption = 'New Zone Code';
        }
        field(50; "Delete Record"; Boolean)
        {
            Caption = 'Delete Record';
        }
        field(51; "Legal Entity"; Code[10])
        {
            Caption = 'Legal Entity';
        }
        field(52; "Language Code"; Code[10])
        {
            CaptionML = ENU = 'Language Code',
                        FRA = 'Code langue';
            TableRelation = Language;
            ValidateTableRelation = false;
        }
        field(54; Blocked; Boolean)
        {
            Caption = 'Blocked';

            trigger OnValidate();
            var
            // Lbln_Allowed: Boolean;
            begin
            end;
        }
        field(55; "Sales Unit of Measure"; Code[10])
        {
            Caption = 'Sales Unit of Measure';
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;
        }
        field(56; "Purch. Unit of Measure"; Code[10])
        {
            Caption = 'Purch. Unit of Measure';
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;
        }
        field(60; "Action Code"; Code[10])
        {
            Caption = 'Action Code';
        }
        field(61; "External Contract No."; Code[10])
        {
            Caption = 'External Contract No.';
        }
        field(62; "External Contract Line No."; Code[10])
        {
            Caption = 'External Contract Line No.';
        }
        field(63; "Type ID"; Code[10])
        {
            Caption = 'Type ID';
        }
        field(64; Locked; Boolean)
        {
            Caption = 'Locked';
        }
        field(65; Closed; Boolean)
        {
            Caption = 'Closed';
        }
        field(66; "Last Changed Date/Time"; DateTime)
        {
            Caption = 'Last Changed Date/Time';
        }
        field(67; "CMG Code"; Code[20])
        {
            Caption = 'CMG Code';
        }
        field(68; "Over Percent"; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }
        field(69; "Under Percent"; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }
        field(70; "Over Percent Indicator"; Boolean)
        {
        }
        field(71; "Direct Unit Cost Multiplier"; Decimal)
        {
            Caption = 'Direct Unit Cost Multiplier';
        }
        field(72; Cancelled; Boolean)
        {
            Caption = 'Cancelled';
        }
        field(73; "Cost Center Code"; Code[20])
        {
            Caption = 'Cost Center Code';
        }
        field(74; "Project Code"; Code[20])
        {
            Caption = 'Project Code';
        }
        field(75; "Delivery Finalized"; Boolean)
        {
            Caption = 'Delivery Finalized';
            Editable = false;
        }
        field(76; "Movement Type"; Code[10])
        {
        }
        field(77; Status; Code[10])
        {
            Caption = 'Status';
        }
        field(78; "Direct Cost Per Multiplier"; Decimal)
        {
            Caption = 'Direct Cost Per Multiplier';
        }
        field(79; "Purchasing Organisation"; Code[10])
        {
            Caption = 'Purchasing Organisation';
        }
        field(80; "External Order No."; Code[10])
        {
            Caption = 'External Order No.';
            Editable = false;
        }
        field(81; "External Order Line No."; Code[10])
        {
            Caption = 'External Order Line No.';
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
        field(84; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
        }
        field(85; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
        }
        field(86; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(87; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            TableRelation = IF ("Ship-to Country/Region Code" = CONST('')) "Post Code".City
            ELSE IF ("Ship-to Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Ship-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(88; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = IF ("Ship-to Country/Region Code" = CONST('')) "Post Code"
            ELSE IF ("Ship-to Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Ship-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(89; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
            ValidateTableRelation = false;
        }
        field(91; Notes; BLOB)
        {
            Caption = 'Notes';
        }
        field(92; "Shipment Method"; Code[10])
        {
            Caption = 'Shipment Method';
            TableRelation = "Shipment Method";
            ValidateTableRelation = false;
        }
        field(93; "Shipment Method Location"; Text[30])
        {
            Caption = 'Shipment Method Location';
        }
        field(94; Contact; Text[50])
        {
            Caption = 'Contact';

            trigger OnLookup();
            var
            // ContactBusinessRelation: Record "Contact Business Relation";
            // Cont: Record Contact;
            begin
            end;

            trigger OnValidate();
            var
            // Cont: Record Contact;
            begin
            end;
        }
        field(95; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(96; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(97; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
            ValidateTableRelation = false;
        }
        field(99; "Amount Incl. VAT"; Decimal)
        {
            Description = 'HEI.08';
        }
        field(100; "Auto Receive after Qlty. Test"; Option)
        {
            Caption = 'Auto Receive after Qlty. Test';
            OptionCaption = '" ,After Positive Evaluation,Always"';
            OptionMembers = " ","After Positive Evaluation",Always;
        }
        field(101; "Item Segmentation"; Option)
        {
            Caption = 'Item Segmentation';
            OptionCaption = '" ,CP,WP,PWP,RP"';
            OptionMembers = " ",CP,WP,PWP,RP;
        }
        field(102; "Certification Required"; Boolean)
        {
            Caption = 'Certification Required';
        }
        field(103; "Rotating Item"; Boolean)
        {
            Caption = 'Rotating Item';
        }
        field(105; "Item Tracking Code"; Code[10])
        {
            Caption = 'Item Tracking Code';
            TableRelation = "Item Tracking Code";
            ValidateTableRelation = false;
        }
        field(106; "Machine Reference No."; Text[50])
        {
            Caption = 'Machine Reference No.';
        }
        field(107; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
        }
        field(110; "External Requisition No."; Code[20])
        {
            Caption = 'External Requisition No.';
        }
        field(111; "External Requisition Line No."; Integer)
        {
            Caption = 'External Requisition Line No.';
        }
        field(120; "Loyalty Amount"; Decimal)
        {
            Caption = 'Loyalty Amount';
            Description = 'HEI.07';
        }
        field(201; "Message ID"; Code[35])
        {
            Caption = 'Message ID';
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
        field(300; "Sync. Date"; DateTime)
        {
            CalcFormula = Lookup("Interface Log Header INT"."Sync. Date" WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Synchronize Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(305; "Source Type"; Integer)
        {
            CalcFormula = Lookup("Interface Log Header INT"."Source Type" WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Source Type';
            Editable = false;
            FieldClass = FlowField;
        }
        field(307; "Source No."; Code[20])
        {
            CalcFormula = Lookup("Interface Log Header INT"."Source No." WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Source No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(308; "Source Status"; Option)
        {
            CalcFormula = Lookup("Interface Log Header INT"."Source Status" WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Source Status';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(500; "Data Exch. Entry No."; Integer)
        {
            Caption = 'Data Exch. Entry No.';
            Editable = false;
            TableRelation = "Data Exch.";
        }
        field(505; "Relational Currency Code"; Code[10])
        {
            Caption = 'Relational Currency Code';
            Description = 'HEI.03';
        }
        field(506; "Exchange Rate Amount"; Decimal)
        {
            Caption = 'Exchange Rate Amount';
            Description = 'HEI.03';
        }
        field(507; "SalesPers./Purch. Code"; Code[10])
        {
            Caption = 'SalesPers./Purch. Code';
            Description = 'HEI.03';
        }
        field(508; "Truck Code"; Code[10])
        {
            Caption = 'Truck Code';
            Description = 'HEI.03';
        }
        field(509; "Driver Code"; Code[10])
        {
            Caption = 'Driver Code';
            Description = 'HEI.03';
        }
        field(510; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            Description = 'HEI.03';
        }
        field(511; "Sales Code"; Code[10])
        {
            Description = 'HEI.03';
        }
        field(512; "Item No."; Code[10])
        {
            Description = 'HEI.03';
        }
        field(513; "Bill-to Customer No."; Code[20])
        {
            Description = 'HEI.03';
        }
        field(514; "Account Type"; Option)
        {
            CaptionML = ENU = 'Account Type',
                        FRA = 'Type compte';
            Description = 'HEI.03';
            OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner',
                              FRA = 'Général,Client,Fournisseur,Banque,Immobilisation,Partenaire IC';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(515; "Bal. Account Type"; Option)
        {
            CaptionML = ENU = 'Bal. Account Type',
                        FRA = 'Type compte contrepartie';
            Description = 'HEI.03';
            OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner',
                              FRA = 'Général,Client,Fournisseur,Banque,Immobilisation,Partenaire IC';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(516; "Account No."; Code[20])
        {
            Description = 'HEI.03';
        }
        field(517; "E-Mail 2"; Text[100])
        {
            Description = 'HEI.04';
        }
        field(700; "HeiLite Item No."; Code[20])
        {
            CalcFormula = Lookup("Item Mapping CP FND"."Heilite Item ID" WHERE("CP Item ID" = FIELD("No.")));
            Caption = 'HeiLite Item No.';
            Description = 'HEI.07';
            FieldClass = FlowField;
        }
        field(701; "HeiLite Location Code"; Code[20])
        {
            CalcFormula = Lookup("Location Mapping CP FND"."Location Code" WHERE("CP Store Code" = FIELD("Location Code")));
            Caption = 'HeiLite Location Code';
            Description = 'HEI.07';
            FieldClass = FlowField;
        }
        field(702; "HeiLite Vendor No."; Code[20])
        {
            CalcFormula = Lookup("Vendor Mapping CP FND"."Heilite Vendor No." WHERE("CP Vendor No." = FIELD("Buy-from Vendor No.")));
            Caption = 'HeiLite Vendor No.';
            Description = 'HEI.07';
            FieldClass = FlowField;
        }
        field(703; "Tax Code"; Code[10])
        {
            Description = 'HEI.08';
        }
        field(704; "Event Date"; Date)
        {
            Description = 'HEI.08';
        }
        field(705; Reference; Code[20])
        {
            Description = 'HEI.08';
        }
        field(710; "Maximo Source Type"; Integer)
        {
            CalcFormula = Lookup("Interface Log Header INT"."Source Type" WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Maximo Source Type';
            Description = 'HEI.10';
            Editable = false;
            FieldClass = FlowField;
        }
        field(711; "Maximo Source No."; Code[20])
        {
            CalcFormula = Lookup("Interface Log Header INT"."Source No." WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Maximo Source No.';
            Description = 'HEI.10';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Header Entry No.", "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        BlobIsEmpty: Label 'The entry does not contain any description data.';

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
            MESSAGE(BlobIsEmpty);
    end;
}

