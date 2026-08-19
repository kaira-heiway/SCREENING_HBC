table 55003 "CIL2 Code RTR"
{
    // version HEI.02

    // HEI:EDD072:1:1 12/06/15 MRA-IBM
    //   # Created new table for CIL ID Code
    // HEI.02 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //  #Migrated table from HEI.2.0 to Base

    // BC Upgrade Kamnay01 Original(Heilite) Table id 50041

    Caption = 'CIL2 Code';
    DrillDownPageID = "CIL2 Code";
    LookupPageID = "CIL2 Code";

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

