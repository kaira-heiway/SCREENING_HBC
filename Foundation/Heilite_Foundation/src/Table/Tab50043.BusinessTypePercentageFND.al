table 50043 "Business Type Percentage FND"
{
    // version HEI1.0,EDD072

    // HEI:EDD072:1:1 26/12/14 TECTURA.WSA
    //   # Created new table for Business Type Dimension Combination Percentage
    // HEI.02 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Added table in migration from hei2.0 to Base

    CaptionML = ENU = 'Business Type Percentage',
                FRA = 'Business Type Percentage';

    fields
    {
        field(1; "Dimension 1 Code"; Code[20])
        {
            CaptionML = ENU = 'Dimension 1 Code',
                        FRA = 'Code axe 1';
            Description = 'HEI.01';
            NotBlank = true;
            TableRelation = Dimension.Code;
        }
        field(2; "Dimension 1 Value Code"; Code[20])
        {
            CaptionML = ENU = 'Dimension 1 Value Code',
                        FRA = 'Code section axe 1';
            Description = 'HEI.01';
            NotBlank = true;
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension 1 Code"));
        }
        field(3; "Dimension 2 Code"; Code[20])
        {
            CaptionML = ENU = 'Dimension 2 Code',
                        FRA = 'Code axe 2';
            Description = 'HEI.01';
            NotBlank = true;
            TableRelation = Dimension.Code;
        }
        field(4; "Dimension 2 Value Code"; Code[20])
        {
            CaptionML = ENU = 'Dimension 2 Value Code',
                        FRA = 'Code section axe 2';
            Description = 'HEI.01';
            NotBlank = true;
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension 2 Code"));
        }
        field(5; "Combination Percentage"; Decimal)
        {
            CaptionML = ENU = 'Combination Percentage',
                        FRA = 'Combination Percentage';
            Description = 'HEI.01';
        }
    }

    keys
    {
        key(Key1; "Dimension 1 Code", "Dimension 1 Value Code", "Dimension 2 Code", "Dimension 2 Value Code")
        {
        }
    }

    fieldgroups
    {
    }
}

