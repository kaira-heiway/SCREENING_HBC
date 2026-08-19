table 50369 "Setup Checklist FND"
{
    // HEI.01 CHG2143950 IBM BULIMC01 27/01/2022#new table created for setup purposes

    // BC Upgrade POENAB02: Original (HeiLite) table id 50236

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                ID := GetID();
            end;
        }
        field(2; ID; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Task Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Setup,Prerequisite;
        }
        field(4; "Table ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = CONST(Table));

            trigger OnValidate();
            begin
                "No. of Database Records" := GetNoOfDatabaseRecords();
            end;
        }
        field(5; "Table Name"; Text[30])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Name" where("Object ID" = FIELD("Table ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Field ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Field."No." where(TableNo = FIELD("Table ID"));
        }
        field(7; "Field Name"; Text[30])
        {
            CalcFormula = Lookup(Field.FieldName where(TableNo = FIELD("Table ID"),
                                                        "No." = FIELD("Field ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Recommended Value"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Page Tab"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Page ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = CONST(Page));
        }
        field(12; "No. of Database Records"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code", ID)
        {
        }
    }

    fieldgroups
    {
    }

    procedure GetNoOfDatabaseRecords(): Integer;
    var
        ConfigXMLExchange: Codeunit "Config. XML Exchange";
        RecRef: RecordRef;
    begin
        if "Table ID" = 0 then
            exit(0);

        RecRef.OPEN("Table ID", false, COMPANYNAME);
        exit(RecRef.COUNT);
    end;

    local procedure GetID(): Integer;
    var
        SetupChecklist: Record "Setup Checklist FND";
    begin
        SetupChecklist.RESET();
        SetupChecklist.SETRANGE(Code, Rec.Code);
        if SetupChecklist.FINDLAST() then
            exit(SetupChecklist.ID + 1)
        else
            exit(1);
    end;
}

