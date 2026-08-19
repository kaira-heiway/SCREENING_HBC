table 50405 "Zycus GL Rule Map FND"
{
    // Heilite Navision Old Id - 50279
    // version HEI.02

    // HEI.01 CHG2210794 MAJUMS03 06.06.2024 Zycus - BASE HL Integration - CMG Rule Map
    //   # Created New Table: 50279 - Zycus GL Rule Map
    // HEI.02 CHG2278614  SHARMP16  09.12.2024 Zycus - BASE HL Integration - CMG Rule Map finetuning
    //   # Created New field: Account Type - Zycus GL Rule Map finetuning

    // BC Upgrade MISHRS14 >>
    // Changed table name to "Zycus GL Rule Map FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<


    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(2; "CMG Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(3; "CTP Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(4; "CCC Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(5; "GL Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(6; "Allowed With Warning"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(7; "Purchase Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
            OptionCaption = 'CCC,WBS';
            OptionMembers = CCC,WBS;
        }
        field(8; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(9; "DateTime Stamp"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(10; "CCC Dim Filter"; Code[60])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(11; "Table ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(12; Inserted; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(13; Modified; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(15; Deleted; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(16; "Current Log Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(17; "Old Log Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(20; "Last Local Change Datetime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(21; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            OptionCaption = 'Income,Balance';
            OptionMembers = Income,Balance;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

