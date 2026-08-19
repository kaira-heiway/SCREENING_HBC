table 50083 "Royalty Fee Setup FND"
{
    // version HEI.01

    // HEI.01 FDD-RTRGAP060 IBM HORTOC01 28.08.2017
    //   # New Object created


    fields
    {
        field(1; "Brand Code"; Code[20])
        {
            Caption = 'Brand Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FILTER('BRAND'));

            trigger OnValidate();
            begin
                if DimensionValue.GET('BRAND', "Brand Code") then
                    "Brand Code Name" := DimensionValue.Name;
            end;
        }
        field(2; "Brand Code Name"; Text[50])
        {
            Caption = 'Brand Code Name';
        }
        field(3; "Royalty %"; Decimal)
        {
            Caption = 'Royalty %';
        }
    }

    keys
    {
        key(Key1; "Brand Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DimensionValue: Record "Dimension Value";
}

