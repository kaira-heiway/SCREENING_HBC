table 50385 "Master Data Val Priority FND"
{
    // Heilite Navision Old Id - 50082
    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 28.08.2016 # New table for handling the order for validating fields

    // BC Upgrade MISHRS14 >>
    // Changed Table name from "Master Data Validate Priority" to "Master Data Val Priority FND" as its moved from Interface to Foundation Layer
    // BC Upgrade MISHRS14 <<

    Caption = 'Master Data Validate Priority';

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table));

            trigger OnLookup();
            var
                TempAllObjWithCaption: Record AllObjWithCaption temporary;
            begin
            end;

            trigger OnValidate();
            var
                TempAllObjWithCaption: Record AllObjWithCaption temporary;
            begin
            end;
        }
        field(2; "Field ID"; Integer)
        {
            Caption = 'Field ID';
            TableRelation = Field."No." WHERE(TableNo = FIELD("Table ID"));
        }
        field(10; "Validate Priority"; Integer)
        {
            Caption = 'Validate Priority';
            InitValue = 10;
        }
        field(20; "Table Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Table),
                                                                           "Object ID" = FIELD("Table ID")));
            Caption = 'Table Caption';
            FieldClass = FlowField;
        }
        field(21; "Field Caption"; Text[80])
        {
            CalcFormula = Lookup(Field."Field Caption" WHERE(TableNo = FIELD("Table ID"),
                                                              "No." = FIELD("Field ID")));
            Caption = 'Field Caption';
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

