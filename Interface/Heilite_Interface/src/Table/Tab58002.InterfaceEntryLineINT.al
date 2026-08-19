table 58002 "Interface Entry Line INT"
{
    // Heilite Navision Old Id - 50002
    // version FM,HEI.16

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New table for Interface Common Framework
    // HEI.02 FDD-PURGAP025 IBM LAZARE02 26.07.2018 # New fields E-Mail, Payment Terms Code
    // HEI.03 Cash Van Sales Interface IBM HORTOC01 # new fields
    // HEI.04 FDD_Rwanda_Bralirwa_Esker_ Interface_V0.3_HT75 IBM POSTOI01
    //   # new E-Mail 2 field
    // HEI.05 S&OP IBM LAZARE02 08.10.2018 # New fields
    // HEI.06 RW-GAPLOG08 IBM LAZARE02 01.11.2018 # New fields
    // HEI.07 BA-SLSGAP01 IBM LAZARE02 15.10.2018
    //   # New flow fields for counterpoint interface
    //   # New fields External Document No., VAT Amount, Discount %, Loyalty Amount, Payment Method Code
    //   # New options Payment, Payout to Entry Type field
    // HEI.08 FDD-BA-SLSGAP01 IBM NASTAA02 24.10.2018 # Counterpoint Interface
    //   # New Fields created: 25 - Posting Date
    //                         98 - Amount Incl. VAT
    //                         703 - Tax Code
    //                         704 - Event Date
    //                         705 - Reference
    // 
    // HEI.09 S&OP Core Interfaces IBM POSTOI01 13.02.2019
    //   # New fields ID's 622, 623:
    //         622 - CMG Code
    //         623 - CMG Description
    // HEI.10 FDD-PURGAP028 IBM GAVANM01 26.03.2019 # Maximo Goods Receipt
    //   # New FlowFields created: 710 - Maximo Source Type
    //                             711 - Maximo Source No.
    //                             712 - Posting Date Header
    // 
    // HEI.11 CHG2035787 IBM KUMARN15 13.08.2019
    //   # For field 42, "Order No." size increased from 20 to 35
    // HEI.12 FDD HB1348 CHG2061857 IBM SHANKJ03 25.06.2020
    //   # added new field Vendor Posting group
    //   # Added  New ield From 716-726 For new interface
    // HEI.13 CHG2042951 IBM POENAB02 10.04.2020 # Procurement of Services Maximo - HeiLite
    //  # New field added: 727 Interface Header Status
    // HEI.15 CHG2081323 HB1619 IBM.GUNERE01 20.01.2021 # Direct Cost Per Mult. Limit PO, Currency Code Limit PO fields added
    // HEI.16 CHG2161264 DEBUSD01 10.11.2022 Shipment KPI Interface
    //  # New Fields

    Caption = 'Interface Entry Line';

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
            Description = 'HEI.06';
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
            Description = 'HEI.08';
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
            Description = 'HEI.07';
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
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output,,,,,,Payment,Payout';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output",,,,,,Payment,Payout;
        }
        field(40; "Blanket Order No."; Code[20])
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            Caption = 'Blanket Order No.';
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = CONST("Blanket Order"));
            ValidateTableRelation = false;
        }
        field(41; "Blanket Order Line No."; Integer)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            Caption = 'Blanket Order Line No.';
            TableRelation = "Purchase Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"),
                                                              "Document No." = FIELD("Blanket Order No."));
            ValidateTableRelation = false;
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
                lCurrFieldNo: Integer;
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
                Lbln_Allowed: Boolean;
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
        }
        field(81; "External Order Line No."; Code[10])
        {
            Caption = 'External Order Line No.';
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
        field(98; "Payment Method Code"; Code[10])
        {
            CaptionML = ENU = 'Payment Method Code',
                        FRA = 'Code mode de règlement';
            Description = 'HEI.07';
            TableRelation = "Payment Method";
        }
        field(99; "Amount Incl. VAT"; Decimal)
        {
            Description = 'HEI.08';
        }
        field(100; "Auto Receive after Qlty. Test"; Option)
        {
            Caption = 'Auto Receive after Qlty. Test';
            OptionCaption = ' ,After Positive Evaluation,Always'; //BC UPGRADE PATHAA02
            OptionMembers = " ","After Positive Evaluation",Always;
        }
        field(101; "Item Segmentation"; Option)
        {
            Caption = 'Item Segmentation';
            OptionCaption = ' ,CP,WP,PWP,RP'; //BC UPGRADE PATHAA02
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
        field(112; "Transfer-to Location Code"; Code[10])
        {
            CaptionML = ENU = 'Transfer-to Location Code',
                        FRA = 'Code dest. transfert';
            DataClassification = ToBeClassified;
            Description = 'HEI.16';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(113; "Document Type Text"; Text[20])
        {
            CaptionML = ENU = 'Description',
                        FRA = 'Désignation';
            Description = 'HEI.16';
        }
        field(114; "Posting Date Text"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.16';
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
            CalcFormula = Lookup("Interface Entry Header INT"."Sync. Date" WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Synchronize Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(305; "Source Type"; Integer)
        {
            CalcFormula = Lookup("Interface Entry Header INT"."Source Type" WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Source Type';
            Editable = false;
            FieldClass = FlowField;
        }
        field(307; "Source No."; Code[20])
        {
            CalcFormula = Lookup("Interface Entry Header INT"."Source No." WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Source No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(308; "Source Status"; Option)
        {
            CalcFormula = Lookup("Interface Entry Header INT"."Source Status" WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Source Status';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(500; "Data Exch. Entry No."; Integer)
        {
            Caption = 'Data Exch. Entry No.';
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
        field(600; "Item Category Code"; Code[20])
        {
            CalcFormula = Lookup("Interface Entry Component INT"."Value Code" WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                 "Line Entry No." = FIELD("Entry No."),
                                                                                 "Table ID" = CONST(27),
                                                                                 Code = CONST('ITEM CATEGORY')));
            Caption = 'Item Category Code';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(601; "Item Category Description"; Text[50])
        {
            CalcFormula = Lookup("Interface Entry Component INT".Description WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                "Line Entry No." = FIELD("Entry No."),
                                                                                "Table ID" = CONST(27),
                                                                                Code = CONST('ITEM CATEGORY')));
            Caption = 'Item Category Description';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(602; "Product Type Code"; Code[20])
        {
            CalcFormula = Lookup("Interface Entry Component INT"."Value Code" WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                 "Line Entry No." = FIELD("Entry No."),
                                                                                 "Table ID" = CONST(27),
                                                                                 Code = CONST('PRODUCT TYPE')));
            Caption = 'Product Type Code';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(603; "Product Type Description"; Text[50])
        {
            CalcFormula = Lookup("Interface Entry Component INT".Description WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                "Line Entry No." = FIELD("Entry No."),
                                                                                "Table ID" = CONST(27),
                                                                                Code = CONST('PRODUCT TYPE')));
            Caption = 'Product Type Description';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(604; "Brand Code"; Code[20])
        {
            CalcFormula = Lookup("Interface Entry Component INT"."Value Code" WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                 "Line Entry No." = FIELD("Entry No."),
                                                                                 "Table ID" = CONST(27),
                                                                                 Code = CONST('BRAND')));
            Caption = 'Brand Code';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(605; "Brand Description"; Text[50])
        {
            CalcFormula = Lookup("Interface Entry Component INT".Description WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                "Line Entry No." = FIELD("Entry No."),
                                                                                "Table ID" = CONST(27),
                                                                                Code = CONST('BRAND')));
            Caption = 'Brand Description';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(606; "Line Extension Code"; Code[20])
        {
            CalcFormula = Lookup("Interface Entry Component INT"."Value Code" WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                 "Line Entry No." = FIELD("Entry No."),
                                                                                 "Table ID" = CONST(27),
                                                                                 Code = CONST('LINE EXTENSION')));
            Caption = 'Line Extension Code';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(607; "Line Extension Description"; Text[50])
        {
            CalcFormula = Lookup("Interface Entry Component INT".Description WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                "Line Entry No." = FIELD("Entry No."),
                                                                                "Table ID" = CONST(27),
                                                                                Code = CONST('LINE EXTENSION')));
            Caption = 'Line Extension Description';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(608; "Primary Pack Type Code"; Code[20])
        {
            CalcFormula = Lookup("Interface Entry Component INT"."Value Code" WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                 "Line Entry No." = FIELD("Entry No."),
                                                                                 "Table ID" = CONST(27),
                                                                                 Code = CONST('PRIMARY PACK TYPE')));
            Caption = 'Primary Pack Type Code';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(609; "Primary Pack Type Description"; Text[50])
        {
            CalcFormula = Lookup("Interface Entry Component INT".Description WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                "Line Entry No." = FIELD("Entry No."),
                                                                                "Table ID" = CONST(27),
                                                                                Code = CONST('PRIMARY PACK TYPE')));
            Caption = 'Primary Pack Type Description';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(610; "SPT Outer Layer Code"; Code[20])
        {
            CalcFormula = Lookup("Interface Entry Component INT"."Value Code" WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                 "Line Entry No." = FIELD("Entry No."),
                                                                                 "Table ID" = CONST(27),
                                                                                 Code = CONST('SPT OUTER LAYER')));
            Caption = 'SPT Outer Layer Code';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(611; "SPT Outer Layer Description"; Text[50])
        {
            CalcFormula = Lookup("Interface Entry Component INT".Description WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                "Line Entry No." = FIELD("Entry No."),
                                                                                "Table ID" = CONST(27),
                                                                                Code = CONST('SPT OUTER LAYER')));
            Caption = 'SPT Outer Layer Description';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(612; "SPT Units per Outer Layer"; Code[20])
        {
            CalcFormula = Lookup("Interface Entry Component INT"."Value Code" WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                 "Line Entry No." = FIELD("Entry No."),
                                                                                 "Table ID" = CONST(27),
                                                                                 Code = CONST('SPT UNITS PER OUTER')));
            Caption = 'SPT Units per Outer Layer';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(614; "SPT Inner Layer Code"; Code[20])
        {
            CalcFormula = Lookup("Interface Entry Component INT"."Value Code" WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                 "Line Entry No." = FIELD("Entry No."),
                                                                                 "Table ID" = CONST(27),
                                                                                 Code = CONST('SPT INBETWEEN LAYER')));
            Caption = 'SPT Inner Layer Code';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(615; "SPT Inner Layer Description"; Text[50])
        {
            CalcFormula = Lookup("Interface Entry Component INT".Description WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                "Line Entry No." = FIELD("Entry No."),
                                                                                "Table ID" = CONST(27),
                                                                                Code = CONST('SPT INBETWEEN LAYER')));
            Caption = 'SPT Inner Layer Description';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(616; "SPT Units per In Between Layer"; Code[20])
        {
            CalcFormula = Lookup("Interface Entry Component INT"."Value Code" WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                 "Line Entry No." = FIELD("Entry No."),
                                                                                 "Table ID" = CONST(27),
                                                                                 Code = CONST('SPT UNITS PER INBETW')));
            Caption = 'SPT Units per In Between Layer';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(618; "Returnable Code"; Code[20])
        {
            CalcFormula = Lookup("Interface Entry Component INT"."Value Code" WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                 "Line Entry No." = FIELD("Entry No."),
                                                                                 "Table ID" = CONST(27),
                                                                                 Code = CONST('RETURNABLE INDICATOR')));
            Caption = 'Returnable Code';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(619; "Returnable Description"; Text[50])
        {
            CalcFormula = Lookup("Interface Entry Component INT".Description WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                "Line Entry No." = FIELD("Entry No."),
                                                                                "Table ID" = CONST(27),
                                                                                Code = CONST('RETURNABLE INDICATOR')));
            Caption = 'Returnable Description';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(620; "Primary Pack Size Code"; Code[20])
        {
            CalcFormula = Lookup("Interface Entry Component INT"."Value Code" WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                 "Line Entry No." = FIELD("Entry No."),
                                                                                 "Table ID" = CONST(27),
                                                                                 Code = CONST('PRIMARY PACK SIZE')));
            Caption = 'Primary Pack Size Code';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(621; "Primary Pack Size Description"; Text[50])
        {
            CalcFormula = Lookup("Interface Entry Component INT".Description WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                "Line Entry No." = FIELD("Entry No."),
                                                                                "Table ID" = CONST(27),
                                                                                Code = CONST('PRIMARY PACK SIZE')));
            Caption = 'Primary Pack Size Description';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        //field(622; CMG_Code; Code[20])  // BC Upgrade NANDIS03
        field(622; CMG_Code_New; Code[20])  // BC Upgrade NANDIS03
        {
            CalcFormula = Lookup("Interface Entry Component INT"."Value Code" WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                 "Line Entry No." = FIELD("Entry No."),
                                                                                 "Table ID" = CONST(27),
                                                                                 Code = CONST('COMMON MATERIAL GROU')));
            Caption = 'CMG_Code';
            Description = 'HEI.09';
            FieldClass = FlowField;
        }
        field(623; CMG_Description; Text[50])
        {
            CalcFormula = Lookup("Interface Entry Component INT".Description WHERE("Header Entry No." = FIELD("Header Entry No."),
                                                                                "Line Entry No." = FIELD("Entry No."),
                                                                                "Table ID" = CONST(27),
                                                                                Code = CONST('COMMON MATERIAL GROU')));
            Caption = 'CMG_Description';
            Description = 'HEI.09';
            FieldClass = FlowField;
        }
        field(700; "HeiLite Item No."; Code[20])
        {
            CalcFormula = Lookup("Item Mapping CP FND"."Heilite Item ID" WHERE("CP Item ID" = FIELD("No.")));
            Caption = 'HeiLite Item No.';
            Description = 'HEI.07';
            FieldClass = FlowField;
        }
        field(701; "HeiLite Location Code"; Code[10])
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
            CalcFormula = Lookup("Interface Entry Header INT"."Source Type" WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Maximo Source Type';
            Description = 'HEI.10';
            Editable = false;
            FieldClass = FlowField;
        }
        field(711; "Maximo Source No."; Code[20])
        {
            CalcFormula = Lookup("Interface Entry Header INT"."Source No." WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Maximo Source No.';
            Description = 'HEI.10';
            Editable = false;
            FieldClass = FlowField;
        }
        field(712; "Posting Date Header"; Date)
        {
            CalcFormula = Lookup("Interface Entry Header INT"."Posting Date" WHERE("Entry No." = FIELD("Header Entry No.")));
            Description = 'HEI.10';
            Editable = false;
            FieldClass = FlowField;
        }
        field(714; "Vendor Posting Group"; Code[20])
        {
            Description = 'HEI.12';
        }
        field(715; "Payables Account"; Code[20])
        {
            CaptionML = ENU = 'Payables Account',
                        FRA = 'Compte fournisseur';
            Description = 'HEI.12';
            TableRelation = "G/L Account";
        }
        field(716; "Service Charge Acc."; Code[20])
        {
            CaptionML = ENU = 'Service Charge Acc.',
                        FRA = 'Compte frais forfaitaires';
            Description = 'HEI.12';
            TableRelation = "G/L Account";
        }
        field(717; "Payment Disc. Debit Acc."; Code[20])
        {
            CaptionML = ENU = 'Payment Disc. Debit Acc.',
                        FRA = 'Compte débit escompte';
            Description = 'HEI.12';
            TableRelation = "G/L Account";
        }
        field(718; "Invoice Rounding Account"; Code[20])
        {
            CaptionML = ENU = 'Invoice Rounding Account',
                        FRA = 'Compte arrondi facture';
            Description = 'HEI.12';
            TableRelation = "G/L Account";
        }
        field(719; "Debit Curr. Appln. Rndg. Acc."; Code[20])
        {
            CaptionML = ENU = 'Debit Curr. Appln. Rndg. Acc.',
                        FRA = 'Cpte arr. lettr. dev. débit';
            Description = 'HEI.12';
            TableRelation = "G/L Account";
        }
        field(720; "Credit Curr. Appln. Rndg. Acc."; Code[20])
        {
            CaptionML = ENU = 'Credit Curr. Appln. Rndg. Acc.',
                        FRA = 'Cpte arr. lettr. dev. crédit';
            Description = 'HEI.12';
            TableRelation = "G/L Account";
        }
        field(721; "Debit Rounding Account"; Code[20])
        {
            CaptionML = ENU = 'Debit Rounding Account',
                        FRA = 'Cpte arrondi débit';
            Description = 'HEI.12';
            TableRelation = "G/L Account";
        }
        field(722; "Credit Rounding Account"; Code[20])
        {
            CaptionML = ENU = 'Credit Rounding Account',
                        FRA = 'Cpte arrondi crédit';
            Description = 'HEI.12';
            TableRelation = "G/L Account";
        }
        field(723; "Payment Disc. Credit Acc."; Code[20])
        {
            CaptionML = ENU = 'Payment Disc. Credit Acc.',
                        FRA = 'Compte crédit escompte';
            Description = 'HEI.12';
            TableRelation = "G/L Account";
        }
        field(724; "Payment Tolerance Debit Acc."; Code[20])
        {
            CaptionML = ENU = 'Payment Tolerance Debit Acc.',
                        FRA = 'Compte écart règlement débit';
            Description = 'HEI.12';
            TableRelation = "G/L Account";
        }
        field(725; "Payment Tolerance Credit Acc."; Code[20])
        {
            CaptionML = ENU = 'Payment Tolerance Credit Acc.',
                        FRA = 'Compte écart règlement crédit';
            Description = 'HEI.12';
            TableRelation = "G/L Account";
        }
        field(726; "Prepayment Request Account"; Code[10])
        {
            Description = 'HEI.12';
            TableRelation = "G/L Account"."No.";
        }
        field(727; "Interface Header Status"; Option)
        {
            CalcFormula = Lookup("Interface Entry Header INT".Status WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Status';
            Description = 'HEI.13';
            FieldClass = FlowField;
            OptionCaption = 'Pending,Error,Processed,Cancelled,Manual Entry';
            OptionMembers = Pending,Error,Processed,Cancelled,"Manual Entry";
        }
        field(729; "Direct Cost Per Mult. Limit PO"; Decimal)
        {
            Caption = 'Direct Cost Per Multiplier Limit PO';
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
        }
        field(730; "Currency Code Limit PO"; Code[10])
        {
            Caption = 'Currency Code Limit PO';
            Description = 'HEI.15';
            TableRelation = Currency;
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "Header Entry No.", "Entry No.")
        {
        }
        key(Key2; "External Contract No.", "External Contract Line No.")
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
        //TempBlob : Record TempBlob;  // BC Upgrade NANDIS03
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

