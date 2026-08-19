table 58089 "Interm. Data Import VIP INT"
{
    // version NAVW110.0,HEI.01
    //BC Upgrade GUNREM01 -Old ID 50207
    // HEI.01 CHG2095187 IBM SAXENA03 27.01.2021
    //   # Code written for Paraller Request
    //   # Table Intermediate Data Import VIP is created, replicla of 1214.

    CaptionML = ENU = 'Intermediate Data Import',
                FRA = 'Importation données intermédiaires';

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
            CaptionML = ENU = 'ID',
                        FRA = 'ID';
        }
        field(2; "Data Exch. No."; Integer)
        {
            CaptionML = ENU = 'Data Exch. No.',
                        FRA = 'N° échange données';
            NotBlank = true;
            TableRelation = "Data Exch. VIP INT";
        }
        field(3; "Table ID"; Integer)
        {
            CaptionML = ENU = 'Table ID',
                        FRA = 'ID table';
            NotBlank = true;
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table));
        }
        field(4; "Record No."; Integer)
        {
            CaptionML = ENU = 'Record No.',
                        FRA = 'Nombre enregistrements';
        }
        field(5; "Field ID"; Integer)
        {
            CaptionML = ENU = 'Field ID',
                        FRA = 'ID champ';
            TableRelation = Field."No." WHERE(TableNo = FIELD("Table ID"));
        }
        field(6; Value; Text[250])
        {
            CaptionML = ENU = 'Value',
                        FRA = 'Valeur';
        }
        field(7; "Validate Only"; Boolean)
        {
            CaptionML = ENU = 'Validate Only',
                        FRA = 'Valider uniquement';
        }
        field(8; "Parent Record No."; Integer)
        {
            CaptionML = ENU = 'Parent Record No.',
                        FRA = 'N° enregistrement parent';
        }
        field(50000; "Big Value"; BLOB)
        {
            Caption = 'Big Value';
            Description = 'HEI.01';
        }
    }

    keys
    {
        key(Key1; ID)
        {
        }
        key(Key2; "Data Exch. No.", "Table ID", "Record No.", "Field ID")
        {
        }
        key(Key3; "Data Exch. No.", "Table ID", "Field ID")
        {
        }
        key(Key4; "Data Exch. No.", "Record No.", "Table ID", "Field ID")
        {
        }
    }

    fieldgroups
    {
    }

    procedure InsertOrUpdateEntry(EntryNo: Integer; TableID: Integer; FieldID: Integer; ParentRecordNo: Integer; RecordNo: Integer; NewValue: Text[250]);
    begin
        if FindEntry(EntryNo, TableID, FieldID, ParentRecordNo, RecordNo) then begin
            Value := NewValue;
            MODIFY;
        end else begin
            CLEAR(Rec);
            "Data Exch. No." := EntryNo;
            "Table ID" := TableID;
            "Record No." := RecordNo;
            "Field ID" := FieldID;
            Value := NewValue;
            "Parent Record No." := ParentRecordNo;
            "Validate Only" := false;
            INSERT;
        end;
    end;

    procedure FindEntry(EntryNo: Integer; TableID: Integer; FieldID: Integer; ParentRecordNo: Integer; RecordNo: Integer): Boolean;
    begin
        RESET;

        SETRANGE("Data Exch. No.", EntryNo);
        SETRANGE("Table ID", TableID);
        SETRANGE("Field ID", FieldID);
        SETRANGE("Parent Record No.", ParentRecordNo);
        SETRANGE("Record No.", RecordNo);

        exit(FINDFIRST);
    end;

    procedure GetEntryValue(EntryNo: Integer; TableID: Integer; FieldID: Integer; ParentRecordNo: Integer; RecordNo: Integer): Text[250];
    begin
        if FindEntry(EntryNo, TableID, FieldID, ParentRecordNo, RecordNo) then
            exit(Value);

        exit('');
    end;
}

