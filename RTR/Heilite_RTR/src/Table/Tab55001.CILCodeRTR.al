table 55001 "CIL Code RTR"
{
    // version HEI.02

    // HEI:EDD072:1:1 21/12/14 TECTURA.WSA
    //   # Created new table for CIL ID Code
    // HEI.02 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Migrated Table from HEI2.0

    // BC Upgrade Kamnay01 Original(Heilite) Table id 50039

    Caption = 'CIL Code';
    DrillDownPageID = "CIL Code";
    LookupPageID = "CIL Code";

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

