table 50089 "MDM Customer Fields FND"
{
    // version HEI.01

    // HEI.01 FDD-SLSGAP001 IBM NASTAA02 20.09.2017 # MDM Customer Card
    //   # New table created

    Caption = 'MDM Customer Fields';

    fields
    {
        field(1; TableNo; Option)
        {
            NotBlank = true;
            OptionCaption = 'Cust,Cust. Attributes';
            OptionMembers = Cust,"Cust. Attributes";

            trigger OnValidate();
            begin
                if TableNo = TableNo::Cust then
                    "Table ID" := 18
                else if TableNo = TableNo::"Cust. Attributes" then
                    "Table ID" := 50072;
            end;
        }
        field(2; "Table ID"; Integer)
        {
            Editable = false;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = CONST(Table));
        }
        field(3; "Field ID"; Integer)
        {
            TableRelation = Field."No." where(TableNo = FIELD("Table ID"));
        }
        field(5; "Table Name"; Text[30])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Name" where("Object Type" = CONST(Table),
                                                                        "Object ID" = FIELD("Table ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Field Name"; Text[30])
        {
            CalcFormula = Lookup(Field.FieldName where(TableNo = FIELD("Table ID"),
                                                        "No." = FIELD("Field ID")));
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
        fieldgroup(DropDown; TableNo, "Field ID", "Field Name")
        {
        }
    }
}

