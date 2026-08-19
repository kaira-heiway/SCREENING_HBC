table 58061 "SEM Interface Setup INT"
{
    // Heilite Navision Old Id - 50213
    // version HEI.03

    // HEI.01 CHG2115040 HB2342 IBM GAVANM01 16.08.2021 #SEM Customer Integration
    //   # New Table created for SEM Interface
    // HEI.02 CHG2178366-HB3189 IBM COSTES04 15.02.2023 Customer Masterdata interface to DOT change
    //   # New field Enable Promotion Interface
    // HEI.03 CHG2187475 IBM COSTES04 09.05.2023  SEM Sales Information
    //   # New fields added : Send Sales Information, Sales Information Interface, Sales Info. Cust. Acc Group, Send Multiple Doc. per File
    //   #No. of Documents per File, Mapping Item Code, Sales Information Distributor, Sales Person Mapping Code, Sales Info. Name Structure,
    //   # Sales Info. Name Structure


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(5; "Enable SEM Interface"; Boolean)
        {
        }
        field(15; "SEM Customer Interface"; Code[20])
        {
            TableRelation = "Interface Setup INT";
        }
        field(30; "Customer Acc Group Filter"; Text[100])
        {
            Caption = 'Customer Account groups to be Included';
            DataClassification = ToBeClassified;
            TableRelation = "Account Group FND";
            ValidateTableRelation = false;
        }
        field(40; "Enable Promotion Interface"; Boolean)
        {
            Caption = 'Enable Promotion Interface';
            DataClassification = CustomerContent;
            Description = 'HEI.02';
        }
        field(100; "Send Sales Information"; Boolean)
        {
            Caption = 'Send Sales Information';
            DataClassification = CustomerContent;
            Description = 'HEI.03';
        }
        field(110; "Sales Information Interface"; Code[20])
        {
            Caption = 'Sales Information Interface';
            DataClassification = CustomerContent;
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT";
        }
        field(120; "Sales Info. Cust. Acc Group"; Text[100])
        {
            Caption = 'Sales Info. Customer Account Group Filter';
            DataClassification = CustomerContent;
            Description = 'HEI.03';
            TableRelation = "Account Group FND";
            ValidateTableRelation = false;
        }
        field(130; "Send Multiple Doc. per File"; Boolean)
        {
            Caption = 'Send Multiple Doc. per File';
            DataClassification = CustomerContent;
            Description = 'HEI.03';
        }
        field(140; "No. of Documents per File"; Integer)
        {
            Caption = 'No. of Documents per File';
            DataClassification = CustomerContent;
            Description = 'HEI.03';
        }
        field(150; "Mapping Item Code"; Text[30])
        {
            Caption = 'Mapping Item Code';
            DataClassification = CustomerContent;
            Description = 'HEI.03';
        }
        field(160; "Sales Information Distributor"; Option)
        {
            Caption = 'Sales Information Distributor';
            DataClassification = CustomerContent;
            Description = 'HEI.03';
            OptionCaption = '" ,Location"';
            OptionMembers = " ",Location;
        }
        field(165; "Sales Person Mapping Code"; Option)
        {
            Caption = 'Sales Person Mapping Code';
            DataClassification = CustomerContent;
            Description = 'HEI.03';
            OptionCaption = '" ,Sales Person,User ID"';
            OptionMembers = " ","Sales Person","User ID";
        }
        field(180; "Sales Info. Currency Code"; Code[10])
        {
            Caption = 'Sales Info. Currency Code';
            DataClassification = CustomerContent;
            Description = 'HEI.03';
            TableRelation = Currency;
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

