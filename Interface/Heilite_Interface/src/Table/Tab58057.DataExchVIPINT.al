table 58057 "Data Exch. VIP INT"
{
    // Heilite Navision Old Id - 50197
    // version NAVW110.0,HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 04.08.2017 # New fields Parent Data Exch. No., File Encoding
    // 
    // HEI.02 CHG2020184 IBM POENAB02 26.06.2019 Bank Connectivity interface
    //   # New functions:
    //     # ImportToDataExchCAM053
    //     # ReplaceString
    // HEI.03 CHG2095187 IBM SAXENA03 08.02.2021
    //   # Code written for Paraller Request
    //   # Created new object Table 50197 replica of Standard Table 1220
    //   # Replaced DataExch. record table with DataExch.VIP
    // HEI.04 CHG2112261 IBM SAXENA03 20.05.2021
    //   # Interface Logging processing Execution Time and Webservices Response Times
    //   # Added below fields:50002

    CaptionML = ENU = 'Data Exch.',
                FRA = 'Échange données';
    Permissions = TableData "Data Exch." = i,
                  TableData "Data Exch. Field" = rimd;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            CaptionML = ENU = 'Entry No.',
                        FRA = 'N° séquence';
        }
        field(2; "File Name"; Text[250])
        {
            CaptionML = ENU = 'File Name',
                        FRA = 'Nom du fichier';
        }
        field(3; "File Content"; BLOB)
        {
            CaptionML = ENU = 'File Content',
                        FRA = 'Contenu fichier';
        }
        field(4; "Data Exch. Def Code"; Code[20])
        {
            CaptionML = ENU = 'Data Exch. Def Code',
                        FRA = 'Code déf. échange données';
            TableRelation = "Data Exch. Def";
        }
        field(5; "Data Exch. Line Def Code"; Code[20])
        {
            CaptionML = ENU = 'Data Exch. Line Def Code',
                        FRA = 'Code déf. ligne échange données';
            TableRelation = "Data Exch. Line Def".Code WHERE("Data Exch. Def Code" = FIELD("Data Exch. Def Code"));
        }
        field(6; "Table Filters"; BLOB)
        {
            CaptionML = ENU = 'Table Filters',
                        FRA = 'Filtres de table';
        }
        field(10; "Incoming Entry No."; Integer)
        {
            CaptionML = ENU = 'Incoming Entry No.',
                        FRA = 'N° document entrant';
            TableRelation = "Incoming Document";
        }
        field(11; "Related Record"; RecordID)
        {
            CaptionML = ENU = 'Related Record',
                        FRA = 'Enregistrement associé';
        }
        field(50000; "Parent Data Exch. No."; Integer)
        {
            Caption = 'Parent Data Exch. No.';
            Description = 'HEI.01';
            NotBlank = true;
            TableRelation = "Data Exch.";
        }
        field(50001; "File Encoding"; Text[30])
        {
            Caption = 'File Encoding';
            Description = 'HEI.01';
        }
        field(50002; "Interface Entry Header No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
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

    trigger OnDelete();
    var
        DataExchField: Record "Data Exch. Field";
    begin
        DataExchField.SETRANGE("Data Exch. No.", "Entry No.");
        DataExchField.DELETEALL();
    end;

    var
        ProgressWindowMsg: TextConst ENU = 'Please wait while the operation is being completed.', FRA = 'Veuillez patienter lors de l''exécution de l''opération.';

    procedure InsertRec(FileName: Text[250]; var FileContent: InStream; DataExchDefCode: Code[20]);
    var
        DataExchLineDef: Record "Data Exch. Line Def";
        OutStream: OutStream;
    begin
        INIT();
        VALIDATE("File Name", FileName);
        "File Content".CREATEOUTSTREAM(OutStream);
        COPYSTREAM(OutStream, FileContent);
        VALIDATE("Data Exch. Def Code", DataExchDefCode);
        DataExchLineDef.SETRANGE("Data Exch. Def Code", DataExchDefCode);
        if DataExchLineDef.FINDFIRST() then
            VALIDATE("Data Exch. Line Def Code", DataExchLineDef.Code);
        INSERT();
    end;

    procedure ImportFileContent(DataExchDef: Record "Data Exch. Def"): Boolean;
    var
        DataExchLineDef: Record "Data Exch. Line Def";
        RelatedRecord: RecordID;
    begin
        RelatedRecord := "Related Record";
        DataExchLineDef.SETRANGE("Data Exch. Def Code", DataExchDef.Code);
        if DataExchLineDef.FINDFIRST() then;

        INIT();
        "Data Exch. Def Code" := DataExchDef.Code;
        "Data Exch. Line Def Code" := DataExchLineDef.Code;
        "Related Record" := RelatedRecord;

        DataExchDef.TESTFIELD("Ext. Data Handling Codeunit");
        CODEUNIT.RUN(DataExchDef."Ext. Data Handling Codeunit", Rec);

        if not "File Content".HASVALUE then
            exit(false);

        INSERT();
        exit(true);
    end;

    procedure ImportToDataExch(DataExchDef: Record "Data Exch. Def"): Boolean;
    var
        Source: InStream;
        ProgressWindow: Dialog;
    begin
        if not "File Content".HASVALUE then
            if not ImportFileContent(DataExchDef) then
                exit(false);

        ProgressWindow.OPEN(ProgressWindowMsg);

        "File Content".CREATEINSTREAM(Source);
        SETRANGE("Entry No.", "Entry No.");
        if DataExchDef."Reading/Writing Codeunit" > 0 then
            CODEUNIT.RUN(DataExchDef."Reading/Writing Codeunit", Rec)
        else begin
            DataExchDef.TESTFIELD("Reading/Writing XMLport");
            XMLPORT.IMPORT(DataExchDef."Reading/Writing XMLport", Source, Rec);
        end;

        ProgressWindow.CLOSE();

        exit(true);
    end;

    procedure ExportFromDataExch(DataExchMapping: Record "Data Exch. Mapping");
    var
        DataExchDef: Record "Data Exch. Def";
    begin
        DataExchMapping.TESTFIELD("Mapping Codeunit");

        DataExchDef.GET("Data Exch. Def Code");
        DataExchDef.TESTFIELD("Reading/Writing Codeunit");
        DataExchDef.TESTFIELD("Ext. Data Handling Codeunit");

        if DataExchMapping."Pre-Mapping Codeunit" > 0 then
            CODEUNIT.RUN(DataExchMapping."Pre-Mapping Codeunit", Rec);

        CODEUNIT.RUN(DataExchMapping."Mapping Codeunit", Rec);

        if DataExchMapping."Post-Mapping Codeunit" > 0 then
            CODEUNIT.RUN(DataExchMapping."Post-Mapping Codeunit", Rec);

        CODEUNIT.RUN(DataExchDef."Reading/Writing Codeunit", Rec);

        CODEUNIT.RUN(DataExchDef."Ext. Data Handling Codeunit", Rec);

        if DataExchDef."User Feedback Codeunit" > 0 then
            CODEUNIT.RUN(DataExchDef."User Feedback Codeunit", Rec);
    end;

    procedure ImportToDataExchCAM053(DataExchDef: Record "Data Exch. Def"; BankAccount: Record "Bank Account"): Boolean;
    var
        Source: InStream;
        BankExportImportSetup: Record "Bank Export/Import Setup";
        DataExchDefCodeResponse: Code[20];
        lDataExchTmp: Record "Data Exch." temporary;
        lContentExists: Boolean;
        NewXML: BigText;
        StartRecording: Boolean;
        InStr: InStream;
        txtFromFile: Text;
        txtFromFile1: Text;
        Pos: Integer;
        OutputStream: OutStream;
        lInterfaceEntryHeader: Record "Interface Entry Header INT";
        lInterfaceEntryLine: Record "Interface Entry Line INT";
        lInterfaceEntryHeaderInsert: Record "Interface Entry Header INT";
        lDataExchInsert: Record "Data Exch.";
        Ch: array[3] of Text;
        ValueToClean: Text;
    begin
        //HEI.02>>
        if not "File Content".HASVALUE then
            if not ImportFileContent(DataExchDef) then
                exit(false);

        if DataExchDef."Reading/Writing Codeunit" > 0 then
            CODEUNIT.RUN(DataExchDef."Reading/Writing Codeunit", Rec)
        else begin
            DataExchDef.TESTFIELD("Reading/Writing XMLport");
            XMLPORT.IMPORT(DataExchDef."Reading/Writing XMLport", Source, Rec);
        end;

        exit(true);
        //HEI.02<<
    end;

    local procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text): Text;
    var
        NewString: Text;
    begin
        //HEI.02>>
        while STRPOS(String, FindWhat) > 0 do
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;

        exit(NewString);
        //HEI.02<<
    end;
}

