table 58028 "Ortec & KStore Interf. Stp INT"
{
    // Heilite Navision Old Id - 50136
    // version HEI.06

    // HEI.01 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new table
    // HEI.02 FDD-SR_HT464_Ortec Interface IBM HORTOC01 09.07.2019 - #new field
    // HEI.03 FDD-HT736 RA Interface IBM GUNERE01 10.08.2019 - #new fields for RA
    // HEI.04 FDD-HT736 RA Interface IBM GUNERE01 21.11.2019 # "Inventory Location Code" field datatype modified, tablerelation modified
    // HEI.05 CHG2182881 IBM SOICAD02 22.11.2022 K store interface bug. Fix for wrong VAT calculation
    //   # Added fields
    //     Def. VAT Bus Pst Group (Dom)
    //     Def. VAT Bus Pst Group (For)
    //     Def. VAT Prod Pst Group
    // HEI.06 CHG2211138 IBM.COSTES04 27.09.2023 # Modification to St Lucia HL to RA Discounts
    //   # Add field RA Previous Days to Expor, RA Ending Date Previous Days

    // BC Upgrade SHUKLP03 >> Document subtype table relation added.

    Caption = 'Ortec & KStore Interface Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Default Route"; Code[20])
        {
            Caption = 'Default Route';
            //TableRelation = Route.Code;  // BC Upgrade NANDIS03 - Dependency on Aptean table
        }
        field(3; "SO Update Interface"; Code[20])
        {
            Caption = 'SO Update Interface';
            TableRelation = "Interface Setup INT".Code;
        }
        field(4; "SO/SRO Interface Request"; Code[20])
        {
            Caption = 'SO/SRO Interface Request';
            TableRelation = "Interface Setup INT".Code;
        }
        field(5; "SO/SRO Interface Response"; Code[20])
        {
            Caption = 'SO/SRO Interface Response';
            TableRelation = "Interface Setup INT".Code;
        }
        field(6; "Cash Payment Term"; Code[20])
        {
            Caption = 'Cash Payment Term';
            TableRelation = "Payment Terms".Code;
        }
        field(7; "Sales Order Prefix"; Code[10])
        {
            Caption = 'Sales Order Prefix';
        }
        field(8; "Sales Return Order Prefix"; Code[10])
        {
            Caption = 'Sales Return Order Prefix';
        }
        field(9; "Payment Prefix"; Code[10])
        {
            Caption = 'Payment Prefix';
        }
        field(10; "Customer Account Group"; Code[20])
        {
            Caption = 'Customer Account Group';
            TableRelation = "Account Group FND".Code;
        }
        field(11; "Item Category Code"; Text[100])
        {
            Caption = 'Item Category Code';
        }
        field(12; "Item Charge Type"; Option)
        {
            Caption = 'Item Charge Type';
            OptionCaption = '" ,Tax,Deposit,Discount,Promotion,,ShippingCost"';
            OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        }
        field(13; "Primary Pack Type Attribute ID"; Integer)
        {
            Caption = 'Primary Pack Type Attribute ID';
            TableRelation = "Item Attribute".ID;
        }
        field(14; "Inventory Location Code"; Text[100])
        {
            Caption = 'Inventory Location Code';
            Description = 'HEI.04';
        }
        field(15; "Customer Price Group Code"; Code[20])
        {
            Caption = 'Customer Price Group Code';
            TableRelation = "Customer Price Group".Code;
        }
        field(16; "Exclude Doc. Subtype Code"; Code[20])
        {
            Caption = 'Exclude Doc. Subtype Code';
            Description = 'Hei.02';
            TableRelation = "Document Subtype Code FND".Code;  // BC Upgrade SHUKLP03 
        }
        field(17; "RA SO/SRO Interface Request"; Code[20])
        {
            Caption = 'Route Adm. SO/SRO Interface Request';
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT".Code;
        }
        field(18; "RA SO/SRO Interface Response"; Code[20])
        {
            Caption = 'Route Adm. SO/SRO Interface Response';
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT".Code;
        }
        field(19; "RA SO G/L Account Difference"; Code[20])
        {
            Caption = 'Sales Order g/l account difference';
            Description = 'HEI.03';
            TableRelation = "G/L Account"."No.";
        }
        field(20; "Max Order Difference Amt."; Decimal)
        {
            Caption = 'Max. Order Difference Amount (LCY)';
            Description = 'HEI.03';
        }
        field(21; "Refund Prefix"; Code[10])
        {
            Description = 'HEI.03';
        }
        field(22; "RA Payment/Refund Request"; Code[20])
        {
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT".Code;
        }
        field(23; "RA Payment/Refund Response"; Code[20])
        {
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT".Code;
        }
        field(24; "Def. VAT Bus Pst Group (Dom)"; Code[10])
        {
            Caption = 'Default VAT Bus Posting Group - Domestic';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
            TableRelation = "VAT Business Posting Group";
        }
        field(25; "Def. VAT Bus Pst Group (For)"; Code[10])
        {
            Caption = 'Default VAT Bus Posting Group - Foreign';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
            TableRelation = "VAT Business Posting Group";
        }
        field(26; "Def. VAT Prod Pst Group"; Code[10])
        {
            Caption = 'Default VAT Prod Posting Group';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
            TableRelation = "VAT Product Posting Group";
        }
        field(30; "RA Previous Days to Export"; Integer)
        {
            Caption = 'Route Adm. Previous Days to Export';
            DataClassification = CustomerContent;
            Description = 'HEI.06';
        }
        field(31; "RA Ending Date Previous Days"; Integer)
        {
            Caption = 'Route Adm. Ending Date Previous Days';
            DataClassification = CustomerContent;
            Description = 'HEI.06';
        }
        // BC Upgrade SHUKLP03 >> Added field for RA Payment Refund Request
        field(32; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = "G/L Account"."No.";
        }
        // BC Upgrade SHUKLP03 << Added field for RA Payment Refund Request

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

