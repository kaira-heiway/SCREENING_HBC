table 50009 "Dispute Reason FND"
{
    // version HEI.01

    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP029 IBM ISYED01 28/06/2017
    //   #Created new table for Dispute Reasons
    // HEI.02 FDD-HB2071 - CHG2099230 IBM NASTAA02 04.05.2021 # Update Dispute Module in HL
    //   # New Field created: 3 - Dispute Category Code
    //   # New Primary Key defined: "Dispute Category Code" + Code
    //   # Set 'NotBlank' property to 'Yes' for Field 'Code'
    //   # Added 'DropDown' Field Group for Code + Description


    fields
    {
        field(1; "Code"; Code[20])
        {
            Description = 'HEI.01.OTCGAP029';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Description = 'HEI.01.OTCGAP029';
        }
        field(3; "Dispute Category Code"; Code[20])
        {
            Caption = 'Dispute Category Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "Dispute Category FND";
        }
    }

    keys
    {
        key(Key1; "Dispute Category Code", "Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }
}

