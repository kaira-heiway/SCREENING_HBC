table 50015 "Restricted Field FND"
{
    // version HEI.01

    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP015a IBM ISYED01 11/07/2017
    //   #Added new table Restricted field


    fields
    {
        field(1; "Table ID"; Integer)
        {
            Description = 'HEI.01';
            TableRelation = AllObj."Object ID" where("Object Type" = CONST(Table));
        }
        field(2; "Table Name"; Text[30])
        {
            CalcFormula = Lookup(AllObj."Object Name" where("Object Type" = CONST(Table),
                                                             "Object ID" = FIELD("Table ID")));
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Field ID"; Integer)
        {
            Description = 'HEI.01';
            TableRelation = Field."No." where(TableNo = FIELD("Table ID"));
        }
        field(4; "Field Name"; Text[30])
        {
            CalcFormula = Lookup(Field.FieldName where(TableNo = FIELD("Table ID"),
                                                        "No." = FIELD("Field ID")));
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Table ID", "Field ID")
        {
        }
    }

    fieldgroups
    {
    }
}

