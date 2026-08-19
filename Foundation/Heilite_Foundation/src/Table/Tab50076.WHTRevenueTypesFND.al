table 50076 "WHT Revenue Types FND"
{
    // version HEI.01,WHT

    Caption = 'WHT Revenue Types';
    DrillDownPageID = "WHT Revenue Types List";
    LookupPageID = "WHT Revenue Types List";

    fields
    {
        field(1; "Code"; Code[10])
        {
            CaptionML = ENU = 'Code',
                        ENA = 'Code';
        }
        field(2; Description; Text[50])
        {
            CaptionML = ENU = 'Description',
                        ENA = 'Description';
        }
        field(3; Sequence; Integer)
        {
            CaptionML = ENU = 'Sequence',
                        ENA = 'Sequence';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; Sequence)
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

