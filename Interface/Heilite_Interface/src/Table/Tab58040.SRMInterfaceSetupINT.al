table 58040 "SRM Interface Setup INT"
{
    // Heilite Navision Old Id - 50169
    // version HEI.05

    // HEI.01 CHG2041871 PANDES01 24-01-2020
    //  # New table SRM Interface Setup created.
    // HEI.02 CHG2021732 FDD-HB755 IBM.GUNERE01 10.02.2020 # "SRM G/L Account Position", "SRM G/L Account Position Val." fields added
    // HEI.03 CHG2095081 IBM.PANDES01 14-04-2021
    //  #Added one field Default Unit of Measure
    // HEI.04 CHG2148350 FDD-HB2777 IBM NANDIS01 16.02.2023 # develop confirmation check interface for HL
    //   # New fields created "GR Validation Req Interface" (ID - 35, Type Code) and "GR Validation Res Interface"(ID - 36, Type - Code)
    // HEI.05 CHG2190299 FDD-HB3316 IBM NANDIS01 24.05.2023 # POSM eshop SRM- HL interface
    //   # New fields created "POSM GR-Creation" (ID - 37, Type Code), "POSM GR Confirmation"(ID - 38, Type Code)


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "SRM Business Sytem ID"; Text[60])
        {
            Caption = 'SRM Business Sytem ID';
            Enabled = false;
        }
        field(3; "SRM Vendor Request Interface"; Code[20])
        {
            Caption = 'SRM Vendor Request Interface';
            TableRelation = "Interface Setup INT";
        }
        field(4; "SRM Vendor Response Interface"; Code[20])
        {
            Caption = 'SRM Vendor Response Interface';
            TableRelation = "Interface Setup INT";
        }
        field(5; "SRM Material Request Interface"; Code[20])
        {
            Caption = 'SRM Material Request Interface';
            TableRelation = "Interface Setup INT";
        }
        field(6; "SRM Material Response Interf."; Code[20])
        {
            Caption = 'SRM Material Response Interface';
            TableRelation = "Interface Setup INT";
        }
        field(7; "Contract Creation Interface"; Code[20])
        {
            Caption = 'Contract Creation Interface';
            TableRelation = "Interface Setup INT";
        }
        field(8; "Contract Confirm. Interface"; Code[20])
        {
            Caption = 'Contract Confirmation Interface';
            TableRelation = "Interface Setup INT";
        }
        field(9; "Contract Call-Off Interface"; Code[20])
        {
            Caption = 'Contract Call-Off Interface';
            TableRelation = "Interface Setup INT";
        }
        field(10; "PO Validation Req. Interface"; Code[20])
        {
            Caption = 'PO Validation Request Interface';
            TableRelation = "Interface Setup INT";
        }
        field(11; "PO Validation Resp. Interface"; Code[20])
        {
            Caption = 'PO Validation Response Interface';
            TableRelation = "Interface Setup INT";
        }
        field(12; "PO Creation Interface"; Code[20])
        {
            Caption = 'PO Creation Interface';
            TableRelation = "Interface Setup INT";
        }
        field(13; "PO Confirmation Interface"; Code[20])
        {
            Caption = 'PO Confirmation Interface';
            TableRelation = "Interface Setup INT";
        }
        field(14; "GR Creation Interface"; Code[20])
        {
            Caption = 'GR Creation Interface';
            TableRelation = "Interface Setup INT";
        }
        field(15; "GR Confirmation Interface"; Code[20])
        {
            Caption = 'GR Confirmation Interface';
            TableRelation = "Interface Setup INT";
        }
        field(16; "Account Assignment Interface"; Code[20])
        {
            Caption = 'Account Assignment Interface';
            TableRelation = "Interface Setup INT";
        }
        field(17; "G/L Account Interface"; Code[20])
        {
            Caption = 'G/L Account Interface';
            TableRelation = "Interface Setup INT";
        }
        field(18; "Account Assgn. Dim. Filter"; Text[100])
        {
            Caption = 'Account Assignment Dimension Filter';
            TableRelation = Dimension;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(19; "SRM Cost Center Object Type"; Code[20])
        {
            Caption = 'SRM Cost Center Object Type';
        }
        field(20; "SRM Project Object Type"; Code[20])
        {
            Caption = 'SRM Project Object Type';
        }
        field(21; "SRM G/L Account Object Type"; Code[20])
        {
            Caption = 'SRM G/L Account Object Type';
        }
        field(22; "SRM Exch. Rate Rndg. Precision"; Decimal)
        {
            Caption = 'SRM Exchange Rate Rounding Precision';
            DecimalPlaces = 0 : 7;
            InitValue = 0.01;
        }
        field(23; "GR Creation Movement Type"; Code[10])
        {
            Caption = 'GR Creation Movement Type';
        }
        field(24; "GR Cancellation Movement Type"; Code[10])
        {
            Caption = 'GR Cancellation Movement Type';
        }
        field(25; "RD Movement Type"; Code[10])
        {
            Caption = 'Return Delivery Movement Type';
        }
        field(26; "RD Cancellation Movement Type"; Code[10])
        {
            Caption = 'Return Delivery Cancellation Movement Type';
        }
        field(27; "Contract Default G/L Acc. No."; Code[20])
        {
            Caption = 'Contract Default G/L Acc. No.';
            TableRelation = "G/L Account";
        }
        field(28; "SRM Create Action Code"; Code[10])
        {
            Caption = 'SRM Create Action Code';
        }
        field(29; "SRM Change Action Code"; Code[10])
        {
            Caption = 'SRM Change Action Code';
        }
        field(30; "SRM Close Action Code"; Code[10])
        {
            Caption = 'SRM Close Action Code';
        }
        field(31; "SRM Default Vendor"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(32; "SRM G/L Account Position"; Integer)
        {
            Description = 'HEI.02';
        }
        field(33; "SRM G/L Account Position Val."; Code[1])
        {
            Description = 'HEI.02';
        }
        field(34; "Default Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Unit of Measure";
        }
        field(35; "GR Validation Req Interface"; Code[20])
        {
            Caption = 'GR Validation Request Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT";
        }
        field(36; "GR Validation Res Interface"; Code[20])
        {
            Caption = 'GR Validation Response Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT";
        }
        field(37; "POSM GR Creation"; Code[20])
        {
            Caption = 'POSM GR Creation Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
            TableRelation = "Interface Setup INT";
        }
        field(38; "POSM GR Confirmation"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
            TableRelation = "Interface Setup INT";
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
}

