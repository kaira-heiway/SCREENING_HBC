table 50152 ClassificationFND
{
    // HEI.01 FDD-HT587 IBM BULIMC01 14/10/2019 # new table created

    Caption = 'Classification';
    DrillDownPageID = Classification;
    LookupPageID = Classification;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
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

