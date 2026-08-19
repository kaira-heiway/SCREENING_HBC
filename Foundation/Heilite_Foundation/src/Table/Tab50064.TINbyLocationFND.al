table 50064 "TIN by Location FND"
{
    // version HEI.01

    // HEI.01 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Table created

    Caption = 'TIN by Location';

    fields
    {
        field(1; "VAT Prod. Posting Group"; Code[10])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(2; Location; Code[10])
        {
            Caption = 'Location';
            TableRelation = Location;
        }
        field(3; "VAT Prod. Posting Group by Loc"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group by Location';
            TableRelation = "VAT Product Posting Group";
        }
        field(4; "TIN No."; Text[20])
        {
            CalcFormula = Lookup("VAT Product Posting Group"."TIN No. FND" where(Code = FIELD("VAT Prod. Posting Group by Loc")));
            Caption = 'TIN No.';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "VAT Prod. Posting Group", Location)
        {
        }
    }

    fieldgroups
    {
    }
}

