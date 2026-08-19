table 50010 "Dispute Resolution FND"
{
    // version HEI.01

    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP029 IBM ISYED01 28/06/2017
    //   #Created new table for Dispute Resolutions


    fields
    {
        field(1; "Code"; Code[20])
        {
            Description = 'HEI.01.OTCGAP029';
        }
        field(2; Description; Text[30])
        {
            Description = 'HEI.01.OTCGAP029';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

