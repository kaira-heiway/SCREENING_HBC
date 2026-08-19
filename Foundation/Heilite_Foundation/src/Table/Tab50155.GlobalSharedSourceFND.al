table 50155 "Global Shared Source FND"
{
    // version HEI.01

    // HEI.01 FDD-HT817 CHG2034523 IBM GUNERE01 30.10.2019 # Table created
    // HEI.02 FDD-HT923 CHG2034529 IBM GUNERE01 30.10.2019 # Source Type Vendor added
    // HEI.03 FDD-HT923 CHG2034529 IBM GUNERE01 07.11.2019 # Blocked field added, Blocked field added to the key
    // HEI.05 FDD-HT1398 CHG2065738 IBM.GUNERE01 16.07.2020 # "Company ID" table relation removed

    DataPerCompany = false;

    fields
    {
        field(10; "Source Type"; Option)
        {
            OptionCaption = ',Vendor,Item';
            OptionMembers = ,Vendor,Item;
        }
        field(20; "Global ID"; Code[20])
        {
            TableRelation = IF ("Source Type" = CONST(Vendor)) Vendor."Global Vendor Number FND"
            else IF ("Source Type" = CONST(Item)) Item."No. 2";
        }
        field(30; "Local ID"; Code[20])
        {
        }
        field(40; "Company ID"; Text[30])
        {
            Description = 'HEI.05';
        }
        field(50; Blocked; Boolean)
        {
            Description = 'HEI.03';
        }
    }

    keys
    {
        key(Key1; "Global ID", "Local ID", "Company ID", Blocked)
        {
        }
    }

    fieldgroups
    {
    }
}

