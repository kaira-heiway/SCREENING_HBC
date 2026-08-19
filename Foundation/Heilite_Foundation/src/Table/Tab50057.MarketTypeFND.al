table 50057 "Market Type FND"
{
    // version HEI.01

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 18.08.2017 # MDM Customer Card
    //   # Object created

    Caption = 'Market Type';
    DrillDownPageID = "Market Type List";
    LookupPageID = "Market Type List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
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

