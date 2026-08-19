table 50063 "TIN FND"
{
    // version HEI.01

    // HEI.01  BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Table created

    Caption = 'TIN';
    DrillDownPageID = TIN;
    LookupPageID = TIN;

    fields
    {
        field(1; "TIN Code"; Code[10])
        {
        }
        field(2; "TIN No."; Text[20])
        {
        }
    }

    keys
    {
        key(Key1; "TIN Code", "TIN No.")
        {
        }
    }

    fieldgroups
    {
    }
}

