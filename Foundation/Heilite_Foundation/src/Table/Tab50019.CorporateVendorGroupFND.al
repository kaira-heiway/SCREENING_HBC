table 50019 "Corporate Vendor Group FND"
{
    // version HEI.01

    // HEI.01 FDD–PURGAP05 IBM LAZARE02 08.07.2017 # New table used for MDM data

    Caption = 'Corporate Vendor Group';
    DataCaptionFields = "Code", Description;
    LookupPageID = "Corporate Vendor Groups";

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

