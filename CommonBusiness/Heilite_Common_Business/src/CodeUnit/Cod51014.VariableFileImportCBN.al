codeunit 51014 "Variable File Import CBN"
{
    // version NAVW19.00

    Permissions = TableData "Data Exch. Field" = rimd;
    TableNo = "Data Exch.";

    trigger OnRun();
    var
        ReadStream: InStream;
        LineNo: Integer;
        ReadLen: Integer;
        SkippedLineNo: Integer;
        ReadText: Text;
    begin
        rec."File Content".CREATEINSTREAM(ReadStream);
        DataExchDef.GET(rec."Data Exch. Def Code");
        LineNo := 1;
        repeat
            ReadLen := ReadStream.READTEXT(ReadText);
            if ReadLen > 0 then
                ParseLine(ReadText, Rec, LineNo, SkippedLineNo);
        until ReadLen = 0;
    end;

    var
        DataExchDef: Record "Data Exch. Def";

    local procedure ParseLine(Line: Text; DataExch: Record "Data Exch."; var LineNo: Integer; var SkippedLineNo: Integer);
    var
        DataExchColumnDef: Record "Data Exch. Column Def";
        DataExchField: Record "Data Exch. Field";
        DataExchLineDef: Record "Data Exch. Line Def";
        StartPosition: Integer;
        SubLine: Text;
    begin
        DataExchLineDef.SETRANGE("Data Exch. Def Code", DataExch."Data Exch. Def Code");
        DataExchLineDef.FINDFIRST();

        if ((LineNo + SkippedLineNo) <= DataExchDef."Header Lines") or
           ((DataExchLineDef."Data Line Tag" <> '') and (STRPOS(Line, DataExchLineDef."Data Line Tag") <> 1))
        then begin
            SkippedLineNo += 1;
            exit;
        end;

        DataExchColumnDef.SETRANGE("Data Exch. Def Code", DataExch."Data Exch. Def Code");
        DataExchColumnDef.SETRANGE("Data Exch. Line Def Code", DataExchLineDef.Code);
        DataExchColumnDef.findset();

        StartPosition := 1;
        SubLine := Line;
        repeat
            DataExchField.InsertRecXMLField(DataExch."Entry No.", LineNo, DataExchColumnDef."Column No.", '',
              COPYSTR(SubLine, 1, STRPOS(SubLine, DataExchDef.ColumnSeparatorChar())), DataExchLineDef.Code);
            SubLine := COPYSTR(SubLine, STRPOS(SubLine, DataExchDef.ColumnSeparatorChar()) + 1, STRLEN(SubLine));
        until DataExchColumnDef.NEXT() = 0;
        LineNo += 1;
    end;
}

