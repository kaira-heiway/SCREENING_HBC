table 50020 "Industry Key FND"
{
    // version HEI.01

    // HEI.01 FDD–PURGAP05 IBM LAZARE02 08.07.2017 # New table used for MDM data

    Caption = 'Industry Key';
    DataCaptionFields = "Code", Description;
    LookupPageID = "Industry Keys";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
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

