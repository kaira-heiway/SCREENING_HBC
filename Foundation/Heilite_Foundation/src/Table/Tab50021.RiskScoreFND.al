table 50021 "Risk Score FND"
{
    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP015a IBM ISYED01 11/07/2017
    //   #Added new table Risk Score

    DrillDownPageID = "Risk Scores";
    LookupPageID = "Risk Scores";

    fields
    {
        field(1; "Code"; Integer)
        {
            MinValue = 0;
        }
        field(2; Description; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Code", Description)
        {
        }
    }

    fieldgroups
    {
    }
}

