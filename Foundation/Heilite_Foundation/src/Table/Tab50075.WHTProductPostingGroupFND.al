table 50075 "WHT Product Posting Group FND"
{
    // version HEI.01,WHT

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 19.08.2017 # MDM Customer Card
    //   # Object created

    Caption = 'WHT Product Posting Group';
    DrillDownPageID = "WHT Product Posting Group List";
    LookupPageID = "WHT Product Posting Group List";

    fields
    {
        field(1; "Code"; Code[10])
        {
            CaptionML = ENU = 'Code',
                        ENA = 'Code';
        }
        field(2; Description; Text[30])
        {
            CaptionML = ENU = 'Description',
                        ENA = 'Description';
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
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }
}

