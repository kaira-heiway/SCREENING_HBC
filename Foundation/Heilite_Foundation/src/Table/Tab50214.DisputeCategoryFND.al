table 50214 "Dispute Category FND"
{
    // version HEI.01

    // HEI.01 FDD-HB2071 - CHG2099230 IBM NASTAA02 04.05.2021 # Update Dispute Module in HL
    //   # New Table created for Dispute Categories

    Caption = 'Dispute Category';
    DrillDownPageID = "Dispute Categories";
    LookupPageID = "Dispute Categories";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[30])
        {
            DataClassification = ToBeClassified;
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

