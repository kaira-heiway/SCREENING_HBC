table 50112 "Local Vendor Type FND"
{
    // version HEI.01

    // HEI.01 FDD-BA-PURGAP03- Bottle Recycling Centre - V2.6 IBM.NAIKH01 16.08.2018
    //   # Created a New table

    Caption = 'Vendor Type';
    DataCaptionFields = "Code", Description;
    LookupPageID = "Local Vendor Types";

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

