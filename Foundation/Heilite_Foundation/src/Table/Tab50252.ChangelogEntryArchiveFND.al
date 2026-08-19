table 50252 "Change log Entry Archive FND"
{
    // version HEI.01

    // HEI.01 IBM SAMANR01 14/06/2023 CHG2208488 - HeiLite BASE Change Log Entries Archive
    //   # New Object created for the subjected change


    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            CaptionML = ENU = 'Entry No.',
                        FRA = 'N° séquence';
            DataClassification = ToBeClassified;
        }
        field(2; "Date and Time"; DateTime)
        {
            CaptionML = ENU = 'Date and Time',
                        FRA = 'Date et heure';
            DataClassification = ToBeClassified;
        }
        field(3; Time; Time)
        {
            CaptionML = ENU = 'Time',
                        FRA = 'Heure';
            DataClassification = ToBeClassified;
        }
        field(4; "User ID"; Code[50])
        {
            CaptionML = ENU = 'User ID',
                        FRA = 'Code utilisateur';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup();
            var
                UserMgt: Codeunit "User Management";
            begin
            end;
        }
        field(5; "Table No."; Integer)
        {
            CaptionML = ENU = 'Table No.',
                        FRA = 'N° table';
            DataClassification = ToBeClassified;
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table));
        }
        field(6; "Table Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Table),
                                                                           "Object ID" = FIELD("Table No.")));
            CaptionML = ENU = 'Table Caption',
                        FRA = 'Légende table';
            FieldClass = FlowField;
        }
        field(7; "Field No."; Integer)
        {
            CaptionML = ENU = 'Field No.',
                        FRA = 'N° champ';
            DataClassification = ToBeClassified;
            TableRelation = Field."No." WHERE(TableNo = FIELD("Table No."));
        }
        field(8; "Field Caption"; Text[80])
        {
            CalcFormula = Lookup(Field."Field Caption" WHERE(TableNo = FIELD("Table No."),
                                                              "No." = FIELD("Field No.")));
            CaptionML = ENU = 'Field Caption',
                        FRA = 'Légende champ';
            FieldClass = FlowField;
        }
        field(9; "Type of Change"; Option)
        {
            CaptionML = ENU = 'Type of Change',
                        FRA = 'Type modification';
            DataClassification = ToBeClassified;
            OptionCaptionML = ENU = 'Insertion,Modification,Deletion',
                              FRA = 'Insertion,Modification,Suppression';
            OptionMembers = Insertion,Modification,Deletion;
        }
        field(10; "Old Value"; Text[250])
        {
            CaptionML = ENU = 'Old Value',
                        FRA = 'Ancienne valeur';
            DataClassification = ToBeClassified;
        }
        field(11; "New Value"; Text[250])
        {
            CaptionML = ENU = 'New Value',
                        FRA = 'Nouvelle valeur';
            DataClassification = ToBeClassified;
        }
        field(12; "Primary Key"; Text[250])
        {
            CaptionML = ENU = 'Primary Key',
                        FRA = 'Clé primaire';
            DataClassification = ToBeClassified;
        }
        field(13; "Primary Key Field 1 No."; Integer)
        {
            CaptionML = ENU = 'Primary Key Field 1 No.',
                        FRA = 'N° champ clé primaire 1';
            DataClassification = ToBeClassified;
            TableRelation = Field."No." WHERE(TableNo = FIELD("Table No."));
        }
        field(14; "Primary Key Field 1 Caption"; Text[80])
        {
            CalcFormula = Lookup(Field."Field Caption" WHERE(TableNo = FIELD("Table No."),
                                                              "No." = FIELD("Primary Key Field 1 No.")));
            CaptionML = ENU = 'Primary Key Field 1 Caption',
                        FRA = 'Légende du champ clé primaire 1';
            FieldClass = FlowField;
        }
        field(15; "Primary Key Field 1 Value"; Text[50])
        {
            CaptionML = ENU = 'Primary Key Field 1 Value',
                        FRA = 'Valeur champ clé primaire 1';
            DataClassification = ToBeClassified;
        }
        field(16; "Primary Key Field 2 No."; Integer)
        {
            CaptionML = ENU = 'Primary Key Field 2 No.',
                        FRA = 'N° champ clé primaire 2';
            DataClassification = ToBeClassified;
            TableRelation = Field."No." WHERE(TableNo = FIELD("Table No."));
        }
        field(17; "Primary Key Field 2 Caption"; Text[80])
        {
            CalcFormula = Lookup(Field."Field Caption" WHERE(TableNo = FIELD("Table No."),
                                                              "No." = FIELD("Primary Key Field 2 No.")));
            CaptionML = ENU = 'Primary Key Field 2 Caption',
                        FRA = 'Légende du champ clé primaire 2';
            FieldClass = FlowField;
        }
        field(18; "Primary Key Field 2 Value"; Text[50])
        {
            CaptionML = ENU = 'Primary Key Field 2 Value',
                        FRA = 'Valeur champ clé primaire 2';
            DataClassification = ToBeClassified;
        }
        field(19; "Primary Key Field 3 No."; Integer)
        {
            CaptionML = ENU = 'Primary Key Field 3 No.',
                        FRA = 'N° champ clé primaire 3';
            DataClassification = ToBeClassified;
            TableRelation = Field."No." WHERE(TableNo = FIELD("Table No."));
        }
        field(20; "Primary Key Field 3 Caption"; Text[80])
        {
            CalcFormula = Lookup(Field."Field Caption" WHERE(TableNo = FIELD("Table No."),
                                                              "No." = FIELD("Primary Key Field 3 No.")));
            CaptionML = ENU = 'Primary Key Field 3 Caption',
                        FRA = 'Légende du champ clé primaire 3';
            FieldClass = FlowField;
        }
        field(21; "Primary Key Field 3 Value"; Text[50])
        {
            CaptionML = ENU = 'Primary Key Field 3 Value',
                        FRA = 'Valeur champ clé primaire 3';
            DataClassification = ToBeClassified;
        }
        field(22; "Record ID"; RecordID)
        {
            CaptionML = ENU = 'Record ID',
                        FRA = 'ID d''enregistrement';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

