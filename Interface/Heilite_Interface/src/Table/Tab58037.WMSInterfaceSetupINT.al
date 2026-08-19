table 58037 "WMS Interface Setup INT"
{
    // Heilite Navision Old Id - 50166
    // version HEI.11

    // HEI.01 CHG2043663 FDD-HT318 BULIMC01 IBM 4.12.2019 #new table crated for WMS Interface
    // HEI.02 CHG2043663 FDD-HT604 IBM.COSTES02 09.12.2019 # WMS integration Heilite BASE and Reflex
    //   # New fields added
    //     # 20Sales Order InterfaceCode20
    //     # 21Warehouse Shipment InterfaceCode20
    //     # 22Sales Order Deletion InterfaceCode20
    //     # 23Post Inb. Shipment InterfaceOption
    //     # 24Email ErrorsText50
    //     # 25Email SubjectText50
    // HEI.03 CHG2043663 FDD-HT604 IBM GAVANM01 13.01.2020 # WMS integration Heilite BASE and Reflex
    //   # New fields added:
    //     # 30 - TO Interface
    //     # 31 - TO Deletion Interface
    //     # 32 - Location on REFLEX
    //     # 33 - TO Interface Purchase
    // HEI.04 CHG2043663 FDD-HT604 IBM GAVANM01 18.01.2020 # WMS integration Heilite BASE and Reflex
    //   # New fields added:
    //     # 43 -Warehouse TS Interface
    //     # 44 -Post Inb. TS Interface
    //     # 45 -Email Errors TS
    //     # 46 -Email Subject TS
    // HEI.05 CHG2043663 FDD-HT604 IBM GAVANM01 18.01.2020 # WMS Transfer Receipt
    //   # New field added: id 47 -Warehouse RE Interface
    // HEI.06 CHG2043663 FDD-HT604 IBM.COSTES02 09.12.2019 # WMS integration Heilite BASE and Reflex
    //   # New fields added
    //     # 40Stock Adjustment Template
    //     # 41Stock Adjustment Batch
    //     # 42Stock Adjustment Interface
    //     # 50Warehouse Movement Interface
    // HEI.07 IBM.Rajdeep 14.07.20
    //     #Field No.8-->Proprty-ValidateTableRelation-->Set to No
    // HEI.08 CHG2129985 SAHAL01      01.04.2022
    //   # Created New Fields: 48 - Activate LogoPak Interface
    //                         51 - Prod. Order Interface
    //                         52 - Prod. Order Output Interface
    //                         59 - Prod. Order Output Template
    //                         60 - Prod. Order Output Batch
    //   # Added CaptionML for above fields
    // HEI.09 CHG2128692 HB2155 IBM GAVANM01 10.11.2021 # WMS Interface Sales Return
    //   # New fields added: 53 - SRO Interface
    //                       54 - SRO Deletion Interface
    // HEI.10 FDD-HB2155 CHG2128694 IBM NANDIS01 10.11.2021 WMS PO
    //   # New fields added : 55 - Purchase Order Del Interface - Code - 20
    //                        56 - Purchase Order Del Interface - Code - 20
    //                        57 - Email Errors PO - Text - 50
    //                        58 - Email Subject PO - Text - 50
    // HEI.11 CHG2107450 HB2156 IBM BHANDS01 23.03.2022 # WMS Phase 2 - Transportation costs
    //   # Added new field : 61 - Enable New WMS TC


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Item Category"; Text[40])
        {
            Caption = 'Item Category To Be Included';
            TableRelation = "Item Category".Code;
            ValidateTableRelation = false;
        }
        field(3; "Customer Account Groups"; Text[40])
        {
            Caption = 'Customer Account Groups To Be Included';
            TableRelation = "Account Group FND".Code;
            ValidateTableRelation = false;
        }
        field(4; "WMS Customer Interface"; Code[20])
        {
            TableRelation = "Interface Setup INT".Code;
        }
        field(5; "WMS Item Interface"; Code[20])
        {
            TableRelation = "Interface Setup INT".Code;
        }
        field(6; "Reflex 1st OUM"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(7; "Reflex 2rd OUM"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(8; "Reflex 3rd OUM"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
            ValidateTableRelation = false;
        }
        field(9; "Starting Modified Date"; DateFormula)
        {
            //InitValue = 1D;  // BC Upgrade NANDIS03
            InitValue = '1D';  // BC Upgrade NANDIS03
        }
        field(10; "WMS Integration"; Boolean)
        {
        }
        field(11; "Customer Request Interface"; Code[20])
        {
            TableRelation = "Interface Setup INT".Code;
        }
        field(12; "Item Request Interface"; Code[20])
        {
            TableRelation = "Interface Setup INT".Code;
        }
        field(20; "Sales Order Interface"; Code[20])
        {
            Caption = 'Sales Order Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT".Code;
        }
        field(21; "Warehouse Shipment Interface"; Code[20])
        {
            Caption = 'Warehouse Shipment Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT".Code;
        }
        field(22; "Sales Order Deletion Interface"; Code[20])
        {
            Caption = 'Sales Order Deletion Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT".Code;
        }
        field(23; "Post Inb. Shipment Interface"; Option)
        {
            Caption = 'Post Inb. Shipment Interface';
            Description = 'HEI.02';
            OptionCaption = 'Ship,Ship &Invoice';
            OptionMembers = Ship,"Ship &Invoice";
        }
        field(24; "Email Errors"; Text[50])
        {
            Caption = 'Email Errors';
            Description = 'HEI.02';
        }
        field(25; "Email Subject"; Text[50])
        {
            Caption = 'Email Subject';
            Description = 'HEI.02';
        }
        field(30; "TO Interface"; Code[20])
        {
            Caption = 'Transfer Order Interface Sales';
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT".Code;
        }
        field(31; "TO Deletion Interface"; Code[20])
        {
            Caption = 'Transfer Order Deletion Interface';
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT".Code;
        }
        field(32; "Location on REFLEX"; Text[50])
        {
            Description = 'HEI.03';
            TableRelation = Location.Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(33; "TO Interface Purchase"; Code[20])
        {
            Caption = 'Transfer Order Interface Purchase';
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT".Code;
        }
        field(40; "Stock Adjustment Template"; Code[10])
        {
            Caption = 'Stock Adjustment Template';
            Description = 'HEI.06';
            TableRelation = "Item Journal Template".Name;
        }
        field(41; "Stock Adjustment Batch"; Code[10])
        {
            Caption = 'Stock Adjustment Batch';
            Description = 'HEI.06';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Stock Adjustment Template"));
        }
        field(42; "Stock Adjustment Interface"; Code[20])
        {
            Caption = 'Stock Adjustment Interface';
            Description = 'HEI.06';
            TableRelation = "Interface Setup INT".Code;
        }
        field(43; "Warehouse TS Interface"; Code[20])
        {
            Caption = 'Warehouse Shipment Interface';
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT".Code;
        }
        field(44; "Post Inb. TS Interface"; Option)
        {
            Caption = 'Post Inb. Shipment Interface';
            Description = 'HEI.04';
            OptionCaption = 'Ship,Ship &Invoice';
            OptionMembers = Ship,"Ship &Invoice";
        }
        field(45; "Email Errors TS"; Text[50])
        {
            Caption = 'Email Errors';
            Description = 'HEI.04';
        }
        field(46; "Email Subject TS"; Text[50])
        {
            Caption = 'Email Subject';
            Description = 'HEI.04';
        }
        field(47; "Warehouse RE Interface"; Code[20])
        {
            Caption = 'Warehouse Receipt Interface';
            Description = 'HEI.05';
            TableRelation = "Interface Setup INT".Code;
        }
        field(48; "Activate LogoPak Interface"; Boolean)
        {
            Caption = 'Activate LogoPak Interface';
            Description = 'HEI.08';
        }
        field(50; "Warehouse Movement Interface"; Code[20])
        {
            Caption = 'Warehouse Movement Interface';
            Description = 'HEI.06';
            TableRelation = "Interface Setup INT".Code;
        }
        field(51; "Prod. Order Interface"; Code[20])
        {
            Caption = 'Prod. Order Interface';
            Description = 'HEI.08';
            TableRelation = "Interface Setup INT";
        }
        field(52; "Prod. Order Output Interface"; Code[20])
        {
            Caption = 'Prod. Order Output Interface';
            Description = 'HEI.08';
            TableRelation = "Interface Setup INT";
        }
        field(53; "SRO Interface"; Code[20])
        {
            Caption = 'Sales Return Order Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
            TableRelation = "Interface Setup INT".Code;
        }
        field(54; "SRO Deletion Interface"; Code[20])
        {
            Caption = 'Sales Return Order Deletion Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
            TableRelation = "Interface Setup INT".Code;
        }
        field(55; "Purchase Order Interface"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
            TableRelation = "Interface Setup INT".Code;
        }
        field(56; "Purchase Order Del Interface"; Code[20])
        {
            Caption = 'Purchase Order Deletion Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
            TableRelation = "Interface Setup INT".Code;
        }
        field(57; "Email Errors PO"; Text[50])
        {
            Caption = 'Email Errors PO';
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
        }
        field(58; "Email Subject PO"; Text[50])
        {
            Caption = 'Email Subject PO';
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
        }
        field(59; "Prod. Order Output Template"; Code[10])
        {
            Caption = 'Prod. Order Output Template';
            Description = 'HEI.08';
            TableRelation = "Item Journal Template";
        }
        field(60; "Prod. Order Output Batch"; Code[10])
        {
            Caption = 'Prod. Order Output Batch';
            Description = 'HEI.08';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Prod. Order Output Template"));
        }
        field(61; "Enable New WMS TC"; Boolean)
        {
            Caption = 'Enable New WMS TC';
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
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

