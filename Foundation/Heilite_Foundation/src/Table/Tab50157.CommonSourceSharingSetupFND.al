table 50157 "Common Src Sharing Setup FND"
{
    // version HEI.01

    // HEI.01 FDD-HT817 CHG2034523 IBM GUNERE01 30.10.2019 # Table created, "Enable Common Item Sharing","Global Item No. Series" fields added
    // HEI.02 FDD-HT923 CHG2034529 IBM GUNERE01 30.10.2019 # Table created, "Enable Common Vendor Sharing","Global Vendor No. Series" fields added
    // HEI.03 FDD-HT817 CHG2034523 IBM GUNERE01 30.10.2019 # "Global Item No. Series" table relation fixed
    // HEI.04 FDD-HT923 CHG2034529 IBM GUNERE01 30.10.2019 # "Global Vendor No. Series" table relation fixed
    // HEI.05 FDD-HT788 IBM BULIMC01 12.10.2019 #"Enable Common Customer Sharing","Global Customer No. Series" fields added
    // HEI.06 FDD-HT1398 CHG2065738 IBM.GUNERE01 13.07.2020 # new field added "Database Level Sharing"
    // HEI.07 FDD-HT1398 CHG2065738 IBM.GUNERE01 14.07.2020 # new fields added "WS Username","WS Password", "WS Link",
    //                                                        "Source Sharing Setup WS Link","Global No. Series Mgt. WS Link",
    //                                                        "Global No. Series WS Link"

    DataPerCompany = false;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Enable Common Item Sharing"; Boolean)
        {
            Description = 'HEI.01';
        }
        field(3; "Enable Common Vendor Sharing"; Boolean)
        {
            Description = 'HEI.02';
        }
        field(4; "Global Item No. Series"; Code[10])
        {
            Description = 'HEI.01';
            TableRelation = "Global No. Series FND".Code;
        }
        field(5; "Global Vendor No. Series"; Code[10])
        {
            Description = 'HEI.02';
            TableRelation = "Global No. Series FND".Code;
        }
        field(6; "Enable Common Customer Sharing"; Boolean)
        {
            Description = 'HEI.05';
        }
        field(7; "Global Customer No. Series"; Code[10])
        {
            Caption = 'Global Customer No. Series';
            Description = 'HEI.05';
            TableRelation = "Global No. Series FND".Code;
        }
        field(8; "Database Level Sharing"; Boolean)
        {
            Description = 'HEI.06';
        }
        field(9; "WS Username"; Text[30])
        {
            Caption = 'Web Service Username';
            Description = 'HEI.07';
        }
        field(10; "WS Password"; Text[30])
        {
            Caption = 'Web Service Password';
            Description = 'HEI.07';
        }
        field(11; "WS Link"; Text[250])
        {
            Caption = 'Web Service Link';
            Description = 'HEI.07';
        }
        field(12; "Source Sharing Setup WS Link"; Text[250])
        {
            Description = 'HEI.07';
        }
        field(13; "Global No. Series Mgt. WS Link"; Text[250])
        {
            Description = 'HEI.07';
        }
        field(14; "Global No. Series WS Link"; Text[250])
        {
            Description = 'HEI.07';
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

