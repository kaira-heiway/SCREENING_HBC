table 50018 "Vendor Type FND"
{
    // version HEI.01

    // HEI.01 FDD–PURGAP05 IBM LAZARE02 08.07.2017 # New table used for MDM data

    Caption = 'Vendor Type';
    DataCaptionFields = "Code", Description;
    LookupPageID = "Vendor Types";

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

