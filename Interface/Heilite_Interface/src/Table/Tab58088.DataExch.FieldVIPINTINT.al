table 58088 "Data Exch. Field VIP INT"
{
    // Heilite Navision Old Id - 50201

    // version NAVW110.0,HEI.02

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017
    //   # New fields: XML Node Name, XML Node Path, Big Value
    //   # New function InsertValueIntoBigValue
    // HEI.02 CHG2095187 IBM SAXENA03 27.01.2021
    //   # Code written for Paraller Request
    //   # Table Data Exch. Field VIP is created, replicla of Data Exch.

    CaptionML = ENU = 'Data Exch. Field',
                FRA = 'Champ échange données';

    fields
    {
        field(1; "Data Exch. No."; Integer)
        {
            CaptionML = ENU = 'Data Exch. No.',
                        FRA = 'N° échange données';
            NotBlank = true;
            TableRelation = "Data Exch. VIP INT";
        }
        field(2; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.',
                        FRA = 'N° ligne';
            NotBlank = true;
        }
        field(3; "Column No."; Integer)
        {
            CaptionML = ENU = 'Column No.',
                        FRA = 'N° colonne';
            NotBlank = true;
        }
        field(4; Value; Text[250])
        {
            CaptionML = ENU = 'Value',
                        FRA = 'Valeur';
        }
        field(5; "Node ID"; Text[250])
        {
            CaptionML = ENU = 'Node ID',
                        FRA = 'ID noud';
        }
        field(6; "Data Exch. Line Def Code"; Code[20])
        {
            CaptionML = ENU = 'Data Exch. Line Def Code',
                        FRA = 'Code déf. ligne échange données';
            TableRelation = "Data Exch. Line Def".Code;
        }
        field(10; "Parent Node ID"; Text[250])
        {
            CaptionML = ENU = 'Parent Node ID',
                        FRA = 'ID noud parent';
        }
        field(11; "Data Exch. Def Code"; Code[20])
        {
            CalcFormula = Lookup("Data Exch."."Data Exch. Def Code" WHERE("Entry No." = FIELD("Data Exch. No.")));
            CaptionML = ENU = 'Data Exch. Def Code',
                        FRA = 'Code déf. échange données';
            FieldClass = FlowField;
        }
        field(50001; "XML Node Name"; Text[250])
        {
            Caption = 'XML Node Name';
            Description = 'HEI.01';
        }
        field(50002; "XML Node Path"; Text[250])
        {
            Caption = 'XML Node Path';
            Description = 'HEI.01';
        }
        field(50003; "Big Value"; BLOB)
        {
            Caption = 'Big Value';
            Description = 'HEI.01';
        }
    }

    keys
    {
        key(Key1; "Data Exch. No.", "Line No.", "Column No.", "Node ID")
        {
        }
    }

    fieldgroups
    {
    }

    procedure InsertRec(DataExchNo: Integer; LineNo: Integer; ColumnNo: Integer; NewValue: Text[250]; DataExchLineDefCode: Code[20]);
    begin
        INIT;
        VALIDATE("Data Exch. No.", DataExchNo);
        VALIDATE("Line No.", LineNo);
        VALIDATE("Column No.", ColumnNo);
        VALIDATE(Value, NewValue);
        VALIDATE("Data Exch. Line Def Code", DataExchLineDefCode);
        INSERT;
    end;

    procedure InsertRecXMLField(DataExchNo: Integer; LineNo: Integer; ColumnNo: Integer; NodeId: Text[250]; NodeValue: Text; DataExchLineDefCode: Code[20]);
    begin
        InsertRecXMLFieldWithParentNodeID(DataExchNo, LineNo, ColumnNo, NodeId, '', NodeValue, DataExchLineDefCode)
    end;

    procedure InsertRecXMLFieldWithParentNodeID(DataExchNo: Integer; LineNo: Integer; ColumnNo: Integer; NodeId: Text[250]; ParentNodeId: Text[250]; NodeValue: Text; DataExchLineDefCode: Code[20]);
    begin
        INIT;
        VALIDATE("Data Exch. No.", DataExchNo);
        VALIDATE("Line No.", LineNo);
        VALIDATE("Column No.", ColumnNo);
        VALIDATE("Node ID", NodeId);
        VALIDATE(Value, COPYSTR(NodeValue, 1, MAXSTRLEN(Value)));
        VALIDATE("Parent Node ID", ParentNodeId);
        VALIDATE("Data Exch. Line Def Code", DataExchLineDefCode);
        //HEI.01>>
        if STRLEN(NodeValue) > MAXSTRLEN(Value) then
            InsertValueIntoBigValue(NodeValue);
        //HEI.01<<
        INSERT;
    end;

    procedure InsertRecXMLFieldDefinition(DataExchNo: Integer; LineNo: Integer; NodeId: Text[250]; ParentNodeId: Text[250]; NewValue: Text[250]; DataExchLineDefCode: Code[20]);
    begin
        // this record represents the line definition and it has ColumnNo set to -1
        // even if we are not extracting anything from the line, we need to insert the definition
        // so that the child nodes can hook up to their parent.
        InsertRecXMLFieldWithParentNodeID(DataExchNo, LineNo, -1, NodeId, ParentNodeId, NewValue, DataExchLineDefCode)
    end;

    procedure GetFieldName(): Text;
    var
        DataExchColumnDef: Record "Data Exch. Column Def";
        DataExch: Record "Data Exch.";
    begin
        DataExch.GET("Data Exch. No.");
        if DataExchColumnDef.GET(DataExch."Data Exch. Def Code", DataExch."Data Exch. Line Def Code", "Column No.") then
            exit(DataExchColumnDef.Name);
        exit('');
    end;

    procedure DeleteRelatedRecords(DataExchNo: Integer; LineNo: Integer);
    begin
        SETRANGE("Data Exch. No.", DataExchNo);
        SETRANGE("Line No.", LineNo);
        DELETEALL(true);
    end;

    local procedure InsertValueIntoBigValue(Value: Text);
    var
        OutputStream: OutStream;
    begin
        //HEI.01>>
        "Big Value".CREATEOUTSTREAM(OutputStream);
        OutputStream.WRITETEXT(Value);
        //HEI.01<<
    end;

    procedure InsertRec2(DataExchNo: Integer; LineNo: Integer; ColumnNo: Integer; NewValue: Text[250]; DataExchLineDefCode: Code[20]; XmlName: Text[250]; XmlPath: Text[250]);
    begin
        //<<HEI.02
        INIT;
        VALIDATE("Data Exch. No.", DataExchNo);
        VALIDATE("Line No.", LineNo);
        VALIDATE("Column No.", ColumnNo);
        VALIDATE(Value, NewValue);
        VALIDATE("Data Exch. Line Def Code", DataExchLineDefCode);
        VALIDATE("XML Node Name", XmlName);
        VALIDATE("XML Node Path", XmlPath);
        INSERT;
        //>>HEI.02
    end;
}

