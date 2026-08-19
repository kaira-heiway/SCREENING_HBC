table 58046 "PowerApps Interface Setup INT"
{
    // Heilite Navision Old Id - 50176
    // HEI.01 CHG2069321 GAVANM01 IBM 13.10.2020 #new table created for PowerApps Interface
    // HEI.02 CHG2094470 HB1870 IBM.GUNERE01 18.06.2021 # "PO Approval Interface Request", "PO Approval Interface Response",
    //                                                    Enable PowerApps PO Intg. fields added


    fields
    {
        field(10; "Primary Key"; Code[10])
        {
        }
        field(20; "Enable PowerApps Integration"; Boolean)
        {
        }
        field(30; "Approval Interface Request"; Code[20])
        {
            TableRelation = "Interface Setup INT".Code;
        }
        field(40; "Approval Interface Response"; Code[20])
        {
            TableRelation = "Interface Setup INT".Code;
        }
        field(50; "PO Approval Interface Request"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT".Code;
        }
        field(60; "PO Approval Interface Response"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT".Code;
        }
        field(70; "Enable PowerApps PO Intg."; Boolean)
        {
            Caption = 'Enable PowerApps PO Integration';
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

