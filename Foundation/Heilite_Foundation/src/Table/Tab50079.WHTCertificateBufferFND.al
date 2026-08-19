table 50079 "WHT Certificate Buffer FND"
{
    // version HEI.01,WHT

    Caption = 'WHT Certificate Buffer';
    DrillDownPageID = "WHT Certificate Buffer List";
    LookupPageID = "WHT Certificate Buffer List";

    fields
    {
        field(1; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.',
                        ENA = 'Line No.';
        }
        field(2; "Vendor No."; Code[20])
        {
            CaptionML = ENU = 'Vendor No.',
                        ENA = 'Vendor No.';
            Editable = false;
        }
        field(3; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        ENA = 'Document No.';
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
        }
        key(Key2; "Vendor No.", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

