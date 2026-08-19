table 50055 "Trading Partner FND"
{
    // version HEI.01

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 18.08.2017 # MDM Customer Card
    //   # Object created

    Caption = 'Trading Partner';
    DrillDownPageID = "Trading Partner List";
    LookupPageID = "Trading Partner List";

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

