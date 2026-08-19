table 50361 "CIL3 Export Buffer FND"
{
    // version HEI.02

    // HEI:EDD072:1:1 18/01/15 TECTURA.WSA
    //   CREATE
    //  HEI.01 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Added table from HEI2.0 to Base.
    // HEI.02 Defect #895 IBM NASTAA02 15.12.2017 # CIL flatfile creation - blank flatfile
    //   # Changed Primary Key

    // BC Upgrade Kamnay01 Original(Heilite) Table id 50042


    Caption = 'CIL3 Export Buffer';

    fields
    {
        field(10; Year; Text[7])
        {
        }
        field(20; Period; Text[25])
        {
        }
        field(30; "Group Account"; Text[25])
        {
        }
        field(40; "Movement Type"; Text[25])
        {
        }
        field(50; "Trading Partner"; Text[25])
        {
        }
        field(60; Quantity; Decimal)
        {
        }
        field(70; "Data Version"; Text[30])
        {
        }
        field(80; "Business Type"; Text[25])
        {
        }
    }

    keys
    {
        key(Key1; "Group Account", "Movement Type", "Trading Partner")
        {
        }
    }

    fieldgroups
    {
    }
}

