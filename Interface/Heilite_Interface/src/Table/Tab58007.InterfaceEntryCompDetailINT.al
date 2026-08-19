table 58007 "Interface Entry Comp.DetailINT"
{
    // Heilite Navision Old Id - 50012
    // version HEI.01

    Caption = 'Interface Entry Component Detail';

    fields
    {
        field(1; "Header Entry No."; Integer)
        {
            Caption = 'Header Entry No.';
            TableRelation = "Interface Entry Header INT";
        }
        field(2; "Line Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Line Entry No.';
            TableRelation = "Interface Entry Line INT";
        }
        field(3; "Table ID"; Integer)
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
        field(4; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(5; "Field ID"; Integer)
        {
            Caption = 'Field ID';
            TableRelation = Field."No." WHERE(TableNo = FIELD("Table ID"));
        }
        field(6; "Table Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Table),
                                                                           "Object ID" = FIELD("Table ID")));
            Caption = 'Table Caption';
            FieldClass = FlowField;
        }
        field(7; "Field Caption"; Text[80])
        {
            CalcFormula = Lookup(Field."Field Caption" WHERE(TableNo = FIELD("Table ID"),
                                                              "No." = FIELD("Field ID")));
            Caption = 'Field Caption';
            FieldClass = FlowField;
        }
        field(8; "Is Primary Key"; Boolean)
        {
            Caption = 'Is Primary Key';
        }
        field(9; "Is Master Table Related"; Boolean)
        {
            Caption = 'Is Master Table Related';
        }
        field(10; "Data Exch. No."; Integer)
        {
            Caption = 'Data Exch. No.';
            NotBlank = true;
            TableRelation = "Data Exch.";
        }
        field(11; "Record No."; Integer)
        {
            Caption = 'Record No.';
        }
        field(12; Value; Text[250])
        {
            Caption = 'Value';
        }
        field(13; "Validate Only"; Boolean)
        {
            Caption = 'Validate Only';
        }
        field(14; "Parent Record No."; Integer)
        {
            Caption = 'Parent Record No.';
        }
        field(15; "Incoming Value"; Text[250])
        {
            Caption = 'Incoming Value';
        }
        field(16; "Validate Priority"; Integer)
        {
            Caption = 'Validate Priority';
        }
    }

    keys
    {
        key(Key1; "Header Entry No.", "Line Entry No.", "Table ID", "Code", "Field ID")
        {
        }
        key(Key2; "Parent Record No.")
        {
        }
        key(Key3; "Header Entry No.", "Line Entry No.", "Table ID", "Code", "Validate Priority", "Field ID")
        {
        }
    }

    fieldgroups
    {
    }
}

