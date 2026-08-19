table 50126 "Vendor Category FND"
{
    // HEI.01 FDD-PURGAP033 IBM BULIMC01 27.02.2019 # new table created to be related with Vendor Category field from Vendor table.

    Caption = 'Vendor Category';
    DrillDownPageID = "Vendor Categories";
    LookupPageID = "Vendor Categories";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
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

