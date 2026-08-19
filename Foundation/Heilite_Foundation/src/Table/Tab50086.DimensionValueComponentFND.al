table 50086 "Dimension Value Component FND"
{
    // version HEI.01

    Caption = 'Dimension Value Component';

    fields
    {
        field(1; "Dimension 1 Code"; Code[20])
        {
            Caption = 'Dimension 1 Code';
            NotBlank = true;
            TableRelation = Dimension.Code;
        }
        field(2; "Dimension 1 Value Code"; Code[20])
        {
            Caption = 'Dimension 1 Value Code';
            NotBlank = true;
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension 1 Code"));
        }
        field(3; "Dimension 2 Code"; Code[20])
        {
            Caption = 'Dimension 2 Code';
            NotBlank = true;
            TableRelation = Dimension.Code;
        }
        field(4; "Dimension 2 Value Code"; Code[20])
        {
            Caption = 'Dimension 2 Value Code';
            NotBlank = true;
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension 2 Code"));
        }
    }

    keys
    {
        key(Key1; "Dimension 1 Code", "Dimension 1 Value Code", "Dimension 2 Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        MaxLengthExceededErr: Label 'The maximum length has been exceeded for dimension code %1, value %2.';

    procedure CreateDimValueName(DimCode: Code[20]; DimValueCode: Code[20]);
    var
        DimensionValue: Record "Dimension Value";
        DimensionValueComponent: Record "Dimension Value Component FND";
        DimValueName: Text;
    begin
        DimensionValueComponent.SETRANGE("Dimension 1 Code", DimCode);
        DimensionValueComponent.SETRANGE("Dimension 1 Value Code", DimValueCode);
        if DimensionValueComponent.findset() then
            repeat
                DimValueName := DimValueName + DimensionValueComponent."Dimension 2 Value Code";
                if STRLEN(DimValueName) > MAXSTRLEN(DimensionValue.Name) then
                    ERROR(MaxLengthExceededErr, DimCode, DimValueCode);
            until DimensionValueComponent.NEXT() = 0;
        DimensionValue.GET(DimCode, DimValueCode);
        DimensionValue.VALIDATE(Name, DimValueName);
        DimensionValue.MODIFY(true);
    end;
}

