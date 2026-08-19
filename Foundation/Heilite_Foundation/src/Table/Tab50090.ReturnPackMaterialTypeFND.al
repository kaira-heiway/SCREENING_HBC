table 50090 "Return Pack Material Type FND"
{
    // version HEI.01

    // HEI.10 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    //   # New table

    Caption = 'Returnable Packaging Material Type';
    DrillDownPageID = "Return Packaging Material Type";
    LookupPageID = "Return Packaging Material Type";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
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

