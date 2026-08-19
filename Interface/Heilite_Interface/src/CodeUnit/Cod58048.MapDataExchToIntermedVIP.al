codeunit 58048 "MapDataExch To Intermed VIP"
{
    //BC Upgrade VAMSIU01- Navision Old Id - 50157

    // version NAVW110.0,HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 25.08.2017 # Copy Big Value from Data Exch. field to Intermediate Data Import
    // HEI.02 CHG2095187 IBM SAXENA03 18.02.2021
    //   # Code written for Paraller Request
    //   # Created a new Object to Replace Data Exch. Table with Data Exch. VIP, Replica of Codeunit 1214
    //   # Replace Data Exch. Field with Data Exch.Field VIP of InsertDataValues Funtion()

    TableNo = "Data Exch. VIP INT";

    trigger OnRun();
    begin
        ProcessAllLinesColumnMapping(Rec);
    end;

    var
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;
        TargetTableFieldDefinitionMustBeSpecifiedErr: TextConst ENU = 'You must specify a target table for the column definition.', FRA = 'Vous devez spécifier une table cible pour la définition de colonne.';

    procedure ProcessAllLinesColumnMapping(DataExchVIP: Record "Data Exch. VIP INT");
    var
        DataExchLineDef: Record "Data Exch. Line Def";
    begin
        // TempNameValueBuffer - used to "keep track" of node id - record No. relation for determining parent/child relation
        TempNameValueBuffer.RESET;
        TempNameValueBuffer.DELETEALL;

        DataExchLineDef.SETRANGE("Data Exch. Def Code", DataExchVIP."Data Exch. Def Code");
        DataExchLineDef.SETRANGE("Parent Code", '');
        if DataExchLineDef.FINDSET then
            repeat
                ProcessColumnMapping(DataExchVIP, DataExchLineDef);
            until DataExchLineDef.NEXT = 0;
    end;

    local procedure ProcessColumnMapping(DataExchVIP: Record "Data Exch. VIP INT"; DataExchLineDef: Record "Data Exch. Line Def");
    var
        DataExchFieldVIP: Record "Data Exch. Field VIP INT";
        ChildDataExchLineDef: Record "Data Exch. Line Def";
        CurrentLineNo: Integer;
    begin
        DataExchFieldVIP.SETRANGE("Data Exch. No.", DataExchVIP."Entry No.");
        DataExchFieldVIP.SETRANGE("Data Exch. Line Def Code", DataExchLineDef.Code);

        if not DataExchFieldVIP.FINDSET then
            exit;

        CurrentLineNo := -1;

        repeat
            InsertRecordDefinition(DataExchFieldVIP, DataExchLineDef, CurrentLineNo);
            InsertDataValues(DataExchFieldVIP, DataExchLineDef, CurrentLineNo);
        until DataExchFieldVIP.NEXT = 0;

        // Process Child Line Definitions
        ChildDataExchLineDef.SETRANGE("Data Exch. Def Code", DataExchLineDef."Data Exch. Def Code");
        ChildDataExchLineDef.SETRANGE("Parent Code", DataExchLineDef.Code);

        if not ChildDataExchLineDef.FINDSET then
            exit;

        repeat
            ProcessColumnMapping(DataExchVIP, ChildDataExchLineDef);
        until ChildDataExchLineDef.NEXT = 0;
    end;

    local procedure InsertRecordDefinition(DataExchFieldVIP: Record "Data Exch. Field VIP INT"; DataExchLineDef: Record "Data Exch. Line Def"; var CurrentLineNo: Integer);
    var
        DataExchFieldMapping: Record "Data Exch. Field Mapping";
    begin
        // Check if definition is already inserted
        if CurrentLineNo = DataExchFieldVIP."Line No." then
            exit;

        // Find the table definition we need to write to.
        DataExchFieldMapping.SETRANGE("Data Exch. Def Code", DataExchLineDef."Data Exch. Def Code");
        DataExchFieldMapping.SETRANGE("Data Exch. Line Def Code", DataExchLineDef.Code);
        DataExchFieldMapping.SETRANGE("Table ID", DATABASE::"Interm. Data Import VIP INT");
        DataExchFieldMapping.SETFILTER("Column No.", '>0');
        if DataExchFieldMapping.ISEMPTY then
            ERROR(TargetTableFieldDefinitionMustBeSpecifiedErr);

        CurrentLineNo := DataExchFieldVIP."Line No.";

        // Save Node ID / Line No relation
        AddNodeIDLineNoPair(DataExchFieldVIP."Node ID", CurrentLineNo);
    end;

    local procedure InsertDataValues(DataExchFieldVIP: Record "Data Exch. Field VIP INT"; DataExchLineDef: Record "Data Exch. Line Def"; LineNo: Integer);
    var
        DataExchFieldMapping: Record "Data Exch. Field Mapping";
        IntermediateDataImportVIP: Record "Interm. Data Import VIP INT";
        TransformationRule: Record "Transformation Rule";
        ParentLineNo: Integer;
    begin
        if DataExchFieldVIP."Column No." < 1 then
            exit;

        // Skip if no mapping
        if not DataExchFieldMapping.GET(
             DataExchLineDef."Data Exch. Def Code", DataExchLineDef.Code,
             DATABASE::"Interm. Data Import VIP INT", DataExchFieldVIP."Column No.")
        then
            exit;

        IntermediateDataImportVIP.INIT;
        IntermediateDataImportVIP.VALIDATE("Data Exch. No.", DataExchFieldVIP."Data Exch. No.");
        IntermediateDataImportVIP.VALIDATE("Table ID", DataExchFieldMapping."Target Table ID");
        IntermediateDataImportVIP.VALIDATE("Record No.", LineNo);
        IntermediateDataImportVIP.VALIDATE("Field ID", DataExchFieldMapping."Target Field ID");
        if TransformationRule.GET(DataExchFieldMapping."Transformation Rule") then
            IntermediateDataImportVIP.VALIDATE(Value, TransformationRule.TransformText(DataExchFieldVIP.Value))
        else
            IntermediateDataImportVIP.VALIDATE(Value, DataExchFieldVIP.Value);
        IntermediateDataImportVIP.VALIDATE("Validate Only", DataExchFieldMapping.Optional);
        if DataExchFieldVIP."Parent Node ID" <> '' then begin
            TempNameValueBuffer.SETRANGE(Name, DataExchFieldVIP."Parent Node ID");
            TempNameValueBuffer.FINDFIRST;
            EVALUATE(ParentLineNo, TempNameValueBuffer.Value);
            IntermediateDataImportVIP.VALIDATE("Parent Record No.", ParentLineNo);
        end;

        //HEI.01>>
        if DataExchFieldVIP."Big Value".HASVALUE then begin
            DataExchFieldVIP.CALCFIELDS("Big Value");
            IntermediateDataImportVIP."Big Value" := DataExchFieldVIP."Big Value";
        end;
        //HEI.01<<

        IntermediateDataImportVIP.INSERT(true);
    end;

    local procedure AddNodeIDLineNoPair(NodeID: Text[250]; LineNo: Integer);
    var
        ID: Integer;
    begin
        TempNameValueBuffer.RESET;
        ID := 1;
        if TempNameValueBuffer.FINDLAST then
            ID := TempNameValueBuffer.ID + 1;

        CLEAR(TempNameValueBuffer);
        TempNameValueBuffer.ID := ID;
        TempNameValueBuffer.Name := NodeID;
        TempNameValueBuffer.Value := FORMAT(LineNo);
        TempNameValueBuffer.INSERT(true);
    end;
}

