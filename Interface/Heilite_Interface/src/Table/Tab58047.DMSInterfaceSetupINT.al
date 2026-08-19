table 58047 "DMS Interface Setup INT"
{
    // Heilite Navision Old Id - 50177
    // version HEI.02

    // HEI.01 FDD-HB1268 - CHG2068666 IBM NASTAA02 26.10.2020 # DMS Integration Ivory Coast
    //   # New Table created for DMS Interfaces
    // HEI.02 CHG2221799 IBM SISUM01 19.12.2023 HB3600 La Reunion DMS - Best Before Date
    //   # add field Lot Sent Enable


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(5; "Enable DMS Interfaces"; Boolean)
        {
            Caption = 'Enable DMS Interfaces';
        }
        field(10; "DMS Item Interface"; Code[20])
        {
            Caption = 'DMS Item Interface';
            TableRelation = "Interface Setup INT";
        }
        field(11; "DMS Customer Interface"; Code[20])
        {
            Caption = 'DMS Customer Interface';
            TableRelation = "Interface Setup INT";
        }
        field(12; "DMS Shipment Interface"; Code[20])
        {
            Caption = 'DMS Shipment Interface';
            TableRelation = "Interface Setup INT";
        }
        field(13; "DMS Payment Interface"; Code[20])
        {
            Caption = 'DMS Payment Interface';
            TableRelation = "Interface Setup INT";
        }
        field(20; "Item Category Filter"; Text[100])
        {
            Caption = 'Item Category Filter';
            TableRelation = "Item Category";
            ValidateTableRelation = false;
        }
        field(21; "Product Hierarchy"; Text[30])
        {
            Caption = 'Product Hierarchy';
        }
        field(30; "Customer Acc Group Filter"; Text[100])
        {
            Caption = 'Customer Account Group Filter';
            TableRelation = "Account Group FND";
            ValidateTableRelation = false;
        }
        field(31; "Facility Type"; Text[30])
        {
            Caption = 'Facility Type';
        }
        field(32; "Branch Server ID"; Text[30])
        {
            Caption = 'Branch Server ID';
        }
        field(33; "Tax Loc Hierarchy Server ID"; Text[30])
        {
            Caption = 'Tax Location Hierarchy Server ID';
        }
        field(40; "Cash Journal Template"; Code[10])
        {
            Caption = 'Cash Journal Template';
            TableRelation = "Gen. Journal Template";
        }
        field(41; "Cash Journal Batch"; Code[10])
        {
            Caption = 'Cash Journal Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Cash Journal Template"));
        }
        field(50; OrderType; Code[20])
        {
            Caption = 'Order Type';
            DataClassification = ToBeClassified;
        }
        field(51; "PO Status"; Code[20])
        {
            Caption = 'PO Status';
            DataClassification = ToBeClassified;
        }
        field(52; "PO Type"; Code[20])
        {
            Caption = 'PO Type';
            DataClassification = ToBeClassified;
        }
        field(53; "Vendor ID"; Code[20])
        {
            Caption = 'Vendor ID';
            DataClassification = ToBeClassified;
        }
        field(54; "Branch Server ID Ship"; Text[30])
        {
            Caption = 'Branch Server ID Shipment';
            DataClassification = ToBeClassified;
        }
        field(55; "Lot Sent Enable"; Boolean)
        {
            Caption = 'Lot Sent Enable';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
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

