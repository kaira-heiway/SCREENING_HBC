table 50189 "Role Center Tile Setup FND"
{
    // HEI.01 CHG2070663 IBM POENAB02 18.09.2020 Role Centre Production Bottling Role Centre
    //   New object created

    Caption = 'Role Center Tile Setup';

    fields
    {
        field(1; "Location Code"; Code[10])
        {
            Description = 'HEI.01';
            TableRelation = Location;
        }
        field(2; "Zone Code"; Code[10])
        {
            Description = 'HEI.01';
            TableRelation = Zone.Code where("Use As In-Transit FND" = CONST(false));
        }
        field(3; "Dimension Code"; Code[10])
        {
            Description = 'HEI.01';
            TableRelation = Dimension;
        }
        field(4; "Dimension Filter Value"; Text[100])
        {
            Description = 'HEI.01';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(5; "Role Center Tile Code"; Text[30])
        {
            Description = 'HEI.01';
        }
    }

    keys
    {
        key(Key1; "Location Code", "Zone Code", "Dimension Code", "Dimension Filter Value")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        //HEI.01
        if (("Location Code" = '') and ("Zone Code" = '')) then
            ERROR(Text50000);
        //HEI.01
    end;

    trigger OnModify();
    begin
        //HEI.01
        if (("Location Code" = '') and ("Zone Code" = '')) then
            ERROR(Text50000);
        //HEI.01
    end;

    var
        Text50000: Label 'Location Code and Zone Code are both empty! At least one of them should be completed!';
}

