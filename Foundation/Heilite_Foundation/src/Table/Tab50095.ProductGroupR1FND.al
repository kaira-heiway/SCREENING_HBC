table 50095 "Product Group R1 FND"
{
    // version HEI.01

    // HEI.01 Defect #1328 #1329 IBM NASTAA02 19.12.2017 # Missing fields in file creation
    //   # New Table created

    CaptionML = ENU = 'Product Group R1',
                FRA = 'Product Group R1';
    DrillDownPageID = "Product Group R1 List";
    LookupPageID = "Product Group R1 List";

    fields
    {
        field(1; "Code"; Code[10])
        {
            CaptionML = ENU = 'Code',
                        FRA = 'Code';
        }
        field(2; Description; Text[30])
        {
            CaptionML = ENU = 'Description',
                        FRA = 'Désignation';
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

