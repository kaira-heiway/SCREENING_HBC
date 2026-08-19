table 58011 "General Interface Setup INT"
{
    // Heilite Navision Old Id - 50034
    // version HEI.29

    // HEI.01 FDD-GAPID001 IBM LAZARE02 14.07.2017 # New table for Interface Common Framework
    // HEI.02 FDD-HNK LOGGAP001 03/12/2017 IBM.CHAUHB01, Following field added.
    //   Export Path
    //   Import Path
    //   Route REGION/AGENCY Dimension
    //   Route BANCOS Item UOMCode
    //   Route Item Category Code 1
    //   Route Item Category Code 2
    //   Route Return Reason Code 1
    //   Route Return Reason Code 2
    //   Route CHANNEL DimensionCode
    //   Route CHANNEL Dimension Value
    //   Route UNIDADES Item UOMCode
    //   Route CAJAS Item UOMCode
    // HEI.03 FDD-HNK LOGGAP002 09/12/2018 IBM.CHAUHB01, Following field added.
    //   50012Pepperi Import Path
    //   50013Pepperi Import Archive Path
    //   50014Sales Order Prefix
    //   50015Product Change Prefix
    //   50016Order Tracking UoM
    //   50017Product Exchange UoM
    //   50018General Journal Template
    //   50019Item Main Category
    //   50020Sales Order Nos.
    //   50021Sales Return Order Nos.
    //   50022Cash Paymet Terms
    //   50023Ret. Reason Code-Ord. Tracking
    //   50024 Peperi SO Interface
    // HEI.04  PA-HURGAP010 22.02.2018 IBM HORTOC01
    //   #added new fields
    // HEI.05 FDD-OTCGAP01 IBM ISYED01 28.11.2017
    //   #Added fileds :Default Fiscal Printer Id,Fiscal Printer XML Directory,Fiscal Printer Input Directory,
    //                  Fiscal Printer Input Prc. Dir.,Active Fiscal Printer,Non Fiscal Invoice Report,Fiscal Printer XML Backup,
    //                  Non Fiscal Cr.Memo Report,Fiscal Invoice Report,Fiscal Cr.Memo Report
    // HEI.06 FDD-OTCGAP01 IBM NAIKH01 09.03.2018
    //   # Added new field "Fiscal Cr.Memo Report Code" and "Fiscal Invoice Report Code"
    // HEI.09 FDD-SLSGAP020 IBM HORTOC01 23.10.2018 # Customer Interface
    // HEI.11 CHG2026335 IBM GAVANM01 09.01.2020 # new field, 50036 - "Local Interfaces"
    // HEI.12 CHG2040517 HB1009 GUNERE01 09.01.2020 # new field, 50037 - "Processing Codeunit ID"
    // HEI.13. CHG2041871 IBM PANDES01 21.01.2020
    //  # Removed SRM related fields and moved to new table (SRM interface setup).
    // HEI.14 CHG2040517 HB1009 GUNERE01 14.02.2020 # 50038 - Outbound Process Cdu ID. new field
    // HEI.15 CHG2042951 IBM POENAB02 10.04.2020 # Procurement of Services Maximo - HeiLite
    //  # New field 59050 Services
    // HEI.16 CHG2060197 IBM KUMARN15 14.04.2020
    //   # New field added "Use TLS1.1 TLS1.2"
    // HEI.17 CHG2013123 IBM.LS 12.05.2020
    //   # New Field created: 50051 - "Sugar by Volume Attr ID"
    //   # New Field created: 50052 - "Artificially Sweetened Attr ID"
    // HEI.18 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
    //   # New Fields created : 50053 - IC Item Jnl Template
    //                          50054 - IC Item Jnl Batch
    // HEI.19 FDD-HT1398 CHG2065738 IBM.GUNERE01 13.07.2020 # new fields added "WS Username","WS Password",
    //                                                        "WS Link"
    // HEI.20 FDD-HT1398 CHG2065738 IBM.GUNERE01 14.07.2020 # "WS Username","WS Password","WS Link" fields removed
    // 
    // HEI.21 FDD-HB1496 CHG2068923 IBM SHANKJ03 04.08.2020
    //   # Field Length of "Maximo Location filter" Changed from 30 to 100
    //   # ValidateTableRelation changed to No
    // HEI.23 FDD-HB1916 CHG2095242 IBM NANDIS01 20.04.2021 - Unit of Measure conversion Maximo-HeiLite interface
    //   # New field added - Maximo UnitofMeasure Interface(ID - 50057)
    // HEI.25 CHG2112882 IBM.LS      02.06.2021
    //   # Created New Field: 120 - Ccc Code Attribute ID
    // HEI.26 FDD - HB1797 CHG2086227 IBM NANDIS01 24.08.2021 - LOG_GR Acknowledgement Message to Global Maximo (aka req.2 of HB1688)
    //   # New field added - 50058 - "Maximo Purch. Rcpt. Confirmtn."
    // HEI.27 CHG2147491 HB2802 NORRIQ KOROLA04 22.09.2022
    //   # New field added - 50059 "WH Material Group Dim. Code"
    // HEI.28 CHG2224414 IBM PANDEA04 08.11.2023 #HeiDM xml request payloads
    //   # New field added -59051"Heidm XML Payload Path"
    //   # Updated DataClassification Property to "CustomerContent"
    // HEI.29 CHG2258298 HLP0-5005 IBM VERMAA03 10.07.2024 #Ethiopia Astro interface log deletion
    //   # New field added - 59070 "Interface Code"
    //                       59071 "Synchronize Date Range"
    //                       59072 "Move To Interface Log"

    Caption = 'General Interface Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(5; "HeiLite Business System ID"; Text[60])
        {
            Caption = 'HeiLite Business System ID';
            Enabled = false;
        }
        field(6; "SRM Business Sytem ID"; Text[60])
        {
            Caption = 'SRM Business Sytem ID';
            Enabled = false;
        }
        field(7; "Source System ID"; Code[10])
        {
            Caption = 'Source System ID';
        }
        field(8; "Company Code ID"; Code[10])
        {
            Caption = 'Company Code ID';
        }
        field(10; "Items Global Interface"; Code[20])
        {
            Caption = 'Item Global Interface';
            TableRelation = "Interface Setup INT";
        }
        field(11; "Items Local Finance Interface"; Code[20])
        {
            Caption = 'Item Local Finance Interface';
            TableRelation = "Interface Setup INT";
        }
        field(12; "Items Local Planning Interface"; Code[20])
        {
            Caption = 'Items Local Planning Interface';
            TableRelation = "Interface Setup INT";
        }
        field(13; "Items Local Site Interface"; Code[20])
        {
            Caption = 'Items Local Site Interface';
            TableRelation = "Interface Setup INT";
        }
        field(14; "Vendors Global Interface"; Code[20])
        {
            Caption = 'Vendors Global Interface';
            TableRelation = "Interface Setup INT";
        }
        field(15; "Vend. Local Finance Interface"; Code[20])
        {
            Caption = 'Vendors Local Finance Interface';
            TableRelation = "Interface Setup INT";
        }
        field(16; "Vend. Local Purch. Interface"; Code[20])
        {
            Caption = 'Vendors Local Purchasing Interface';
            TableRelation = "Interface Setup INT";
        }
        field(17; "Vendor Bank Interface"; Code[20])
        {
            Caption = 'Vendor Bank Interface';
            TableRelation = "Interface Setup INT";
        }
        field(18; "Material Interface"; Code[20])
        {
            Caption = 'Material Interface';
            Description = 'HEI.10';
            TableRelation = "Interface Setup INT";
        }
        field(19; "Vendor Interface"; Code[20])
        {
            Caption = 'Vendor Interface';
            Description = 'HEI.10';
            TableRelation = "Interface Setup INT";
        }
        field(40; "MD Default Field Priority"; Integer)
        {
            Caption = 'Master Data Default Field Priority';
            InitValue = 10;
        }
        field(51; "Cost Center Dimension Code"; Code[20])
        {
            Caption = 'Cost Center Dimension Code';
            TableRelation = Dimension;
        }
        field(52; "Project Dimension Code"; Code[20])
        {
            Caption = 'Project Dimension Code';
            TableRelation = Dimension;
        }
        field(70; "CMG Dimension Code"; Code[20])
        {
            Caption = 'CMG Dimension Code';
            TableRelation = Dimension;
        }
        field(83; "XML Encoding"; Text[30])
        {
            Caption = 'XML Encoding';
        }
        field(100; "CMG Attribute ID"; Integer)
        {
            BlankZero = true;
            Caption = 'CMG Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(101; "Brand Attribute ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Brand Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(102; "Line Extension Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Line Extension Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(103; "Product Group Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Product Group Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(104; "Product Type Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Product Type Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(105; "Group 3rdParty Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Group 3rd Party Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(106; "Primary Pack Type Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Primary Pack Type Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(107; "Primary PT Group Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Primary Pack Type Group Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(108; "Primary Pack Size Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Primary Pack Size Attr. ID Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(109; "SPT Outer Layer Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'SPT Outer Layer Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(110; "SPT Unit Per Outer Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'SPT Unit Per Outer Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(111; "SPT In Betw. Layer Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'SPT In Betw. Layer Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(112; "SPT Units In Betw. Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'SPT Units In Betw. Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(113; "Alcohol By Volume Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Alcohol By Volume Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(114; "Alcohol By Weight Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Alcohol By Weight Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(115; "Returnable Indicat. Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Returnable Indicator Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(116; "Sparkling Still Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Sparkling Still Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(117; "Wine Category Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Wine Category Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(118; "Denomination Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Denomination Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(119; "Region Of Origin Attr. ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Region Of Origin Attribute ID';
            TableRelation = "Item Attribute";
        }
        field(120; "Ccc Code Attribute ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Ccc Code Attribute ID';
            Description = 'HEI.25';
            TableRelation = "Item Attribute";
        }
        field(131; "Brand Dim. Code"; Code[20])
        {
            Caption = 'Brand Dimension Code';
            TableRelation = Dimension;
        }
        field(132; "Line Extension Dim. Code"; Code[20])
        {
            Caption = 'Line Extension Dimension Code';
            TableRelation = Dimension;
        }
        field(133; "Product Group Dim. Code"; Code[20])
        {
            Caption = 'Product Group Dimension Code';
            TableRelation = Dimension;
        }
        field(134; "Product Type  Dim. Code"; Code[20])
        {
            Caption = 'Product Type  Dimension Code';
            TableRelation = Dimension;
        }
        field(135; "Group 3rdParty Dim. Code"; Code[20])
        {
            Caption = 'Group 3rd Party Dimension Code';
            TableRelation = Dimension;
        }
        field(136; "Primary Pack Type Dim. Code"; Code[20])
        {
            Caption = 'Primary Pack Type Dimension Code';
            TableRelation = Dimension;
        }
        field(137; "Primary PT Group Dim. Code"; Code[20])
        {
            Caption = 'Primary Pack Type Group Dimension Code';
            TableRelation = Dimension;
        }
        field(138; "Primary Pack Size Dim. Code"; Code[20])
        {
            Caption = 'Primary Pack Size Dimension Code';
            TableRelation = Dimension;
        }
        field(139; "SPT Outer Layer Dim. Code"; Code[20])
        {
            Caption = 'SPT Outer Layer Dimension Code';
            TableRelation = Dimension;
        }
        field(140; "Returnable Indicator Dim. Code"; Code[20])
        {
            Caption = 'Returnable Indicator Dimension Code';
            TableRelation = Dimension;
        }
        field(141; "Trading Partner Dim. Code"; Code[20])
        {
            Caption = 'Trading Partner Dimension Code';
            TableRelation = Dimension;
        }
        field(200; "Maximo Vendor Interface"; Code[20])
        {
            Caption = 'Maximo Vendor Interface';
            TableRelation = "Interface Setup INT";
        }
        field(201; "Maximo Item Interface"; Code[20])
        {
            Caption = 'Maximo Item Interface';
            TableRelation = "Interface Setup INT";
        }
        field(202; "Maximo PR Interface"; Code[20])
        {
            Caption = 'Maximo PR Interface';
            TableRelation = "Interface Setup INT";
        }
        field(203; "Maximo PO Interface"; Code[20])
        {
            Caption = 'Maximo PO Interface';
            TableRelation = "Interface Setup INT";
        }
        field(204; "Maximo Purch. Rcpt. Interface"; Code[20])
        {
            Caption = 'Maximo Purchase Receipt Interface';
            TableRelation = "Interface Setup INT";
        }
        field(205; "Maximo Goods Issue Interface"; Code[20])
        {
            Caption = 'Maximo Goods Issue Interface';
            TableRelation = "Interface Setup INT";
        }
        field(206; "Maximo Stock Adjmt. Interface"; Code[20])
        {
            TableRelation = "Interface Setup INT";
        }
        field(207; "Maximo Unit Cost Interface"; Code[20])
        {
            Caption = 'Maximo Unit Cost Interface';
            TableRelation = "Interface Setup INT";
        }
        field(208; "Maximo Item Vendor Interface"; Code[20])
        {
            Caption = 'Maximo Item Vendor Interface';
            TableRelation = "Interface Setup INT";
        }
        field(209; "Maximo Goods Transf. Interface"; Code[20])
        {
            Caption = 'Maximo Goods Transfer Interface';
            TableRelation = "Interface Setup INT";
        }
        field(210; "Maximo Default Language Code"; Code[10])
        {
            Caption = 'Maximo Default Language Code';
            TableRelation = Language;
        }
        field(212; "Maximo Consumption Prod. Order"; Code[20])
        {
            Caption = 'Maximo Consumption Prod. Order';
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
        }
        field(214; "Maximo Default PR Vendor No."; Code[20])
        {
            Caption = 'Maximo Default PR Vendor No.';
            TableRelation = Vendor;
        }
        field(215; "Ibecor Vendor No."; Code[20])
        {
            Caption = 'Ibecor Vendor No.';
            TableRelation = Vendor;
        }
        field(216; "Maximo Location Filter"; Text[100])
        {
            Caption = 'Maximo Location Filter';
            TableRelation = Location;
            ValidateTableRelation = false;
        }
        field(300; "Interface Job Queue Category"; Code[10])
        {
            Caption = 'Interface Job Queue Category';
            TableRelation = "Job Queue Category";
        }
        field(301; "Notify User ID 1"; Code[50])
        {
            Caption = 'Notify User ID 1';
            TableRelation = "User Setup";
        }
        field(302; "Notify User ID 2"; Code[50])
        {
            Caption = 'Notify User ID 2';
            TableRelation = "User Setup";
        }
        field(305; "Interface Job Queue User ID"; Code[50])
        {
            Caption = 'Interface Job Queue User ID';
            TableRelation = "User Setup";
        }
        field(400; "Enable IC Item Numbering"; Boolean)
        {
            Caption = 'Enable Intercompany Item Numbering';
        }
        field(401; "Item Numbering Format"; Code[20])
        {
            Caption = 'Item Numbering Format';
        }
        field(50000; "Export Path"; Text[100])
        {
            CaptionML = ENU = 'Export Path',
                        FRA = 'Export Path',
                        ESA = 'Export Path';
            Description = 'HEI.02';
        }
        field(50001; "Import Path"; Text[100])
        {
            CaptionML = ENU = 'Import Path',
                        FRA = 'Import Path',
                        ESA = 'Import Path';
            Description = 'HEI.02';
        }
        field(50002; "Route BANCOS Item UOM"; Code[10])
        {
            CaptionML = FRA = 'Route BANCOS Item UOM',
                        ENA = 'Route BANCOS Item UOM',
                        ESA = 'Route BANCOS Item UOM';
            Description = 'HEI.02';
            TableRelation = "Unit of Measure";
        }
        field(50003; "Route UNIDADES Item UOM"; Code[10])
        {
            Description = 'HEI.02';
            TableRelation = "Unit of Measure";
        }
        field(50004; "Route CAJAS Item UOM"; Code[10])
        {
            Description = 'HEI.02';
            TableRelation = "Unit of Measure";
        }
        field(50007; "Route Return Reason Code 1"; Code[50])
        {
            CaptionML = ENU = 'Route Return Reason Code 1',
                        FRA = 'Route Return Reason Code 1',
                        ESA = 'Route Return Reason Code 1';
            Description = 'HEI.02';
        }
        field(50008; "Route Return Reason Code 2"; Code[10])
        {
            CaptionML = ENU = 'Route Reason Code 2',
                        FRA = 'Route Reason Code 2',
                        ESA = 'Route Reason Code 2';
            Description = 'HEI.02';
            TableRelation = "Return Reason";
        }
        field(50009; "Route REGION/AGENCY Dimension"; Code[20])
        {
            CaptionML = ENU = 'Route REGION/AGENCY Dimension',
                        FRA = 'Route REGION/AGENCY Dimension',
                        ESA = 'Route REGION/AGENCY Dimension';
            Description = 'HEI.02';
            TableRelation = Dimension;
        }
        field(50010; "Route CHANNEL Dimension"; Code[20])
        {
            CaptionML = ENU = 'Route CHANNEL Dimension',
                        FRA = 'Route CHANNEL Dimension',
                        ESA = 'Route CHANNEL Dimension';
            Description = 'HEI.02';
            TableRelation = Dimension;
        }
        field(50011; "Route CHANNEL Dimension Value"; Text[150])
        {
            CaptionML = ENU = 'Route CHANNEL Dimension Value',
                        FRA = 'Route CHANNEL Dimension Value',
                        ESA = 'Route CHANNEL Dimension Value';
            Description = 'HEI.02';

            trigger OnValidate();
            var
                DimensionValue: Record "Dimension Value";
            begin
                /*DimensionValue.RESET;
                DimensionValue.SETRANGE("Dimension Code","Route CHANNEL Dimension");
                DimensionValue.SETFILTER(Code,"Route CHANNEL Dimension Value");
                IF NOT DimensionValue.FIND('-') THEN
                  ERROR(Text002);
                */

            end;
        }
        field(50012; "Pepperi Import Path"; Text[80])
        {
            Description = 'HEI.03';
        }
        field(50013; "Pepperi Import Archive Path"; Text[80])
        {
            Description = 'HEI.03';
        }
        field(50014; "Sales Order Prefix"; Text[50])
        {
            Description = 'HEI.03';
        }
        field(50015; "Product Change Prefix"; Text[50])
        {
            Description = 'HEI.03';
        }
        field(50016; "Order Tracking UoM"; Text[30])
        {
            Description = 'HEI.03';
            TableRelation = Field.FieldName WHERE(TableNo = CONST(27));

            trigger OnLookup();
            begin
                Field.RESET();
                Field.SETRANGE(TableNo, 27);
                // if PAGE.RUNMODAL(PAGE::"Field List",Field) = ACTION::LookupOK then
                //   "Order Tracking UoM" := Field.FieldName;  // BC Upgrade NANDIS03 - Field List page is removed from stadrad
            end;
        }
        field(50017; "Product Exchange UoM"; Text[30])
        {
            Description = 'HEI.03';
            TableRelation = Field.FieldName WHERE(TableNo = CONST(27));

            trigger OnLookup();
            begin
                Field.RESET();
                Field.SETRANGE(TableNo, 27);
                // if PAGE.RUNMODAL(PAGE::"Field List", Field) = ACTION::LookupOK then
                //     "Product Exchange UoM" := Field.FieldName;  // BC Upgrade NANDIS03 - Field List page is removed from stadrad
            end;
        }
        field(50018; "General Journal Template"; Code[10])
        {
            Description = 'HEI.03';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(50019; "Item Main Category"; Text[30])
        {
            Description = 'HEI.03';
        }
        field(50020; "AR Collection Prefix"; Text[50])
        {
            Description = 'HEI.03';
        }
        field(50021; "Pepperi Customer No."; Code[10])
        {
            Description = 'HEI.03';
        }
        field(50022; "Cash Paymet Terms"; Code[10])
        {
            Description = 'HEI.03';
            TableRelation = "Payment Terms";
        }
        field(50023; "Ret. Reason Code-Ord. Tracking"; Code[10])
        {
            Description = 'HEI.03';
            TableRelation = "Return Reason";
        }
        field(50024; "Peperi SO Interface"; Code[20])
        {
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT";
        }
        field(50025; "Pepperi Export Path"; Text[80])
        {
            Description = 'HEI.03';
        }
        field(50026; "Pepperi Export Archive Path"; Text[80])
        {
            Description = 'HEI.03';
        }
        field(50027; "Payroll Import Path"; Text[100])
        {
            Caption = 'Payroll Import Path';
            Description = 'HEI.04';

            trigger OnLookup();
            begin
                //"Payroll Import Path" := FileMgt.OpenFileDialog('NAV File Browser', TxtFileExtension, '');  // BC Upgrade NANDIS03 - File Management CU needs to be handled
            end;
        }
        field(50028; "Payroll Import Archive Path"; Text[100])
        {
            Caption = 'Payroll Import Archive Path';
            Description = 'HEI.04';

            trigger OnLookup();
            begin
                //"Payroll Import Archive Path" := FileMgt.OpenFileDialog('NAV File Browser', TxtFileExtension, '');  // BC Upgrade NANDIS03 - File Management CU needs to be handled
            end;
        }
        field(50029; "Payroll Gen. Jnl. Template"; Code[20])
        {
            Caption = 'Payroll Gen. Jnl. Template';
            Description = 'HEI.04';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(50030; "Payroll Gen. Jnl. Batch"; Code[20])
        {
            Caption = 'Payroll Gen. Jnl. Batch';
            Description = 'HEI.04';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Payroll Gen. Jnl. Template"));
        }
        field(50031; "Payroll Interface"; Code[20])
        {
            Caption = 'Payroll Interface';
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT".Code;
        }
        field(50032; "Fiscal Invoice Report Code"; Code[20])
        {
            Description = 'HEI.06';
            TableRelation = "Interface Setup INT";
        }
        field(50033; "Fiscal Cr.Memo Report Code"; Code[20])
        {
            Description = 'HEI.06';
            TableRelation = "Interface Setup INT";
        }
        field(50034; "Automatic Posting Invoice"; Boolean)
        {
            Description = 'HEI.06';
        }
        field(50035; "Automatic Posting Credit Memo"; Boolean)
        {
            Description = 'HEI.06';
        }
        field(50036; "Local Interfaces"; Text[70])
        {
            Description = 'HEI.11';
            TableRelation = "Interface Setup INT";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50037; "Processing Codeunit ID"; Integer)
        {
            Description = 'HEI.12';
        }
        field(50038; "Outbound Process Cdu ID."; Integer)
        {
            Description = 'HEI.14';
        }
        field(50050; "Use TLS1.1 TLS1.2"; Boolean)
        {
            Description = 'HEI.16';
        }
        field(50051; "Sugar by Volume Attr ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Sugar by Volume Attr ID';
            Description = 'HEI.17';
            TableRelation = "Item Attribute";
        }
        field(50052; "Artificially Sweetened Attr ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Artificially Sweetened Attr ID';
            Description = 'HEI.17';
            TableRelation = "Item Attribute";
        }
        field(50053; "IC Item Jnl Template"; Code[10])
        {
            Caption = 'IC Item Journal Template';
            Description = 'HEI.18';
            TableRelation = "Item Journal Template";
        }
        field(50054; "IC Item Jnl Batch"; Code[10])
        {
            Caption = 'IC Item Journal Batch';
            Description = 'HEI.18';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("IC Item Jnl Template"));
        }
        field(50057; "Maximo UnitofMeasure Interface"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.23';
            TableRelation = "Interface Setup INT";
        }
        field(50058; "Maximo Purch. Rcpt. Confirmtn."; Code[20])
        {
            Caption = 'Maximo Purch. Rcpt. Confirmtn.';
            DataClassification = ToBeClassified;
            Description = 'HEI.26';
            TableRelation = "Interface Setup INT";
        }
        field(50059; "WH Material Group Dim. Code"; Code[20])
        {
            Caption = 'WH Material Group Dimension Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.27';
            TableRelation = Dimension;
        }
        field(59036; "Default Fiscal Printer Id"; Text[10])
        {
            Description = 'HEI.05';
        }
        field(59037; "Fiscal Printer XML Directory"; Text[200])
        {
            Description = 'HEI.05';
        }
        field(59038; "Fiscal Printer Input Directory"; Text[200])
        {
            Description = 'HEI.05';
        }
        field(59039; "Fiscal Printer Input Prc. Dir."; Text[30])
        {
            Description = 'HEI.05';
        }
        field(59040; "Active Fiscal Printer"; Boolean)
        {
            Description = 'HEI.05';
        }
        field(59041; "Non Fiscal Invoice Report"; Integer)
        {
            Description = 'HEI.05';
        }
        field(59042; "Fiscal Printer XML Backup"; Text[150])
        {
            Description = 'HEI.05';
        }
        field(59043; "Non Fiscal Cr.Memo Report"; Integer)
        {
            Description = 'HEI.05';
        }
        field(59044; "Fiscal Invoice Report"; Integer)
        {
            Description = 'HEI.05';
        }
        field(59045; "Fiscal Cr.Memo Report"; Integer)
        {
            Description = 'HEI.05';
        }
        field(59046; "Account Group"; Code[20])
        {
            Caption = 'Account Group';
            Description = 'HEI.03';
            TableRelation = "Account Group FND";
            ValidateTableRelation = false;
        }
        field(59047; "Pepperi Item category"; Text[30])
        {
            Description = 'HEI.03';
        }
        field(59048; "Customer Interface"; Code[20])
        {
            Caption = 'Customer Interface';
            Description = 'HEI.09';
            TableRelation = "Interface Setup INT".Code;
        }
        field(59049; "Duplicate Check Limit Distance"; Integer)
        {
            Caption = 'Duplicate Check Limit Distance';
            Description = 'HEI.09';
        }
        field(59050; Services; Text[3])
        {
            Caption = 'Services';
            Description = 'HEI.15';
        }
        field(59051; "Heidm XML Payload Path"; Text[200])
        {
            DataClassification = CustomerContent;
            Description = 'HEI.28';
        }
        field(59070; "Interface Code"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.29';
        }
        field(59071; "Synchronize Date Range"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.29';
        }
        field(59072; "Move To Interface Log"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.29';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    var
        TimeSheetHeader: Record "Time Sheet Header";
        TimeSheetLine: Record "Time Sheet Line";
        Text001: TextConst ENU = '%1 cannot be changed, because there is at least one submitted time sheet line with Type=Job.';
        Text002: Label '%1 cannot be changed, because there is at least one time sheet.';
        "Field": Record "Field";
        FileMgt: Codeunit "File Management";
        TxtFileExtension: Label '*.txt';
}

