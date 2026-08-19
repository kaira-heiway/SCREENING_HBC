table 50370 "Interf. IncomingDataMappingFND"
{
    // version HEI.01
    // Heilite Navision Old Id - 50033

    // BC UPGRADE PATELS08 >>
    // # Table moved from INTERFACES to Foundation Layer
    // # Table name changed from "Interf. Incoming Data Mapping" to "Interf. IncomingDataMappingFND"
    // BC UPGRADE PATELS08 <<
    Caption = 'Interface Incoming Data Mapping';

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
        field(3; "Incoming Table ID"; Integer)
        {
            Caption = 'Incoming Table ID';
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
        field(4; "Incoming Field ID"; Integer)
        {
            Caption = 'Incoming Field ID';
            TableRelation = Field."No." WHERE(TableNo = FIELD("Incoming Table ID"));
        }
        field(5; "Mapping Field ID"; Integer)
        {
            Caption = 'Mapping Field ID';
            TableRelation = Field."No." WHERE(TableNo = FIELD("Incoming Table ID"));
        }
        field(6; "Use Mapping Constant"; Boolean)
        {
            Caption = 'Use Mapping Constant';
        }
        field(7; "Mapping Constant"; Text[30])
        {
            Caption = 'Mapping Constant';
        }
        field(11; "Table Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Table),
                                                                           "Object ID" = FIELD("Table ID")));
            Caption = 'Table Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Field Caption"; Text[80])
        {
            CalcFormula = Lookup(Field."Field Caption" WHERE(TableNo = FIELD("Table ID"),
                                                              "No." = FIELD("Field ID")));
            Caption = 'Field Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Incoming Table Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Table),
                                                                           "Object ID" = FIELD("Incoming Table ID")));
            Caption = 'Incoming Table Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Incoming Field Caption"; Text[80])
        {
            CalcFormula = Lookup(Field."Field Caption" WHERE(TableNo = FIELD("Incoming Table ID"),
                                                              "No." = FIELD("Incoming Field ID")));
            Caption = 'Incoming Field Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Mapping Field Caption"; Text[80])
        {
            CalcFormula = Lookup(Field."Field Caption" WHERE(TableNo = FIELD("Incoming Table ID"),
                                                              "No." = FIELD("Mapping Field ID")));
            Caption = 'Mapping Field Caption';
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

