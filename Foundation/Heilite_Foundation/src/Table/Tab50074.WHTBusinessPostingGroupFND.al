table 50074 "WHT Business Posting Group FND"
{
    // version HEI.01,WHT

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 19.08.2017 # MDM Customer Card
    //   # Object created

    Caption = 'WHT Business Posting Group';
    DrillDownPageID = "WHT Business Posting Group Lst";
    LookupPageID = "WHT Business Posting Group Lst";

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

