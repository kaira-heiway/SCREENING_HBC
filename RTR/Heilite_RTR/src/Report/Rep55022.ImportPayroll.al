report 55022 "Import Payroll"
{
    // version HEI.01,D4579

    // HEI.01 FDD-AL-HRPGAP01 IBM HORTOC01 19.09.2017
    //     # new report - import payroll from Excel - Algeria
    // HEI.02 Defect 3874 IBM POENAB02 05.06.2019
    //   # Solving issue for Ivory Coast. The dimensions were not imported in the journal.
    // HEI.03 Defect 4579 IBM MONATU01 18.12.2019
    //   # Rebuild function "AnalyzeData"
    //   # Create functions : Get_HeaderRowNo,ClearJournal,DimenssionExist, DimValueExist,DimValuesExist2,SetMainDim,Get_SetDimID
    // HEI.04 Defect 4579 IBM BULIMC01 06.02.2020 #add Dimension Code MVMT Type and solving some issues found into HEI.03 code
    // HEI.05 Defect 5270 IBM BULIMC01 02.03.2020 #Source Code field added

    // BC Upgrade KUMARR78>>
    // 1. File upload logic updated from FileManagement to stream-based processing.
    //    Old: FileName := FileMgt.UploadFile(Text006, ExcelFileExtensionTok);
    //    New: File.UploadIntoStream(Text006, '', FromFilter, FileName, InStr);

    // 2. Worksheet selection updated to use InStream method.
    //    Old: SheetName := ExcelBuf.SelectSheetsName(FileName);
    //    New: SheetName := ExcelBuf.SelectSheetsNameStream(InStr);

    // 3. Excel open book updated to use stream-based method.
    //    Old: ExcelBuf.OpenBook(FileName, SheetName);
    //    New: ExcelBuf.OpenBookStream(InStr, SheetName);

    // 4. Added Business Central report discoverability properties.
    //    Old: Report missing mandatory BC properties.
    //    New:
    //        ApplicationArea = All;
    //        UsageCategory = ReportsAndAnalysis;
    // 5. Variables added for stream processing.
    //    New variables:
    //        InStr: InStream;
    //        FromFilter: Label 'Excel File (*.xlsx)|*.xlsx';
    //        TempBlob: Codeunit "Temp Blob";
    //        OutStr: OutStream;
    // BC Upgrade KUMARR78<<


    ApplicationArea = All; // BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade KUMARR78 Adding Usagecategory

    Permissions = TableData "Dimension Set Entry" = ri;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.");
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("WorkBook File Name"; FileName)
                {
                    ApplicationArea = All; // BC Upgrade KUMARR78 Adding ApplicationArea  
                    CaptionML = ENU = 'Workbook File Name',
                                NLD = 'Werkmapbestandsnaam';

                    trigger OnAssistEdit();
                    var
                        FileMgt: Codeunit "File Management";
                        ExcelFileExtensionTok: Label '.xlsm';
                    begin
                        // BC Upgrade KUMARR78 >>
                        // FileName := FileMgt.UploadFile(Text006, ExcelFileExtensionTok);
                        File.UploadIntoStream(Text006, '', FromFilter, FileName, InStr);
                        // BC Upgrade KUMARR78 <<
                    end;
                }
                field("Worksheet Name"; SheetName)
                {
                    ApplicationArea = All; // BC Upgrade KUMARR78 Adding ApplicationArea  
                    CaptionML = ENU = 'Worksheet Name',
                                NLD = 'Werkbladnaam';

                    trigger OnAssistEdit();
                    begin
                        // BC Upgrade KUMARR78 >>
                        SheetName := ExcelBuf.SelectSheetsNameStream(InStr);
                        // SheetName := ExcelBuf.SelectSheetsName(FileName);
                        // BC Upgrade KUMARR78 <<
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        if Counter1 <> 0 then
            MESSAGE(Text008, GenJnlTemplateName, GenJnlBatchName);
    end;

    trigger OnPreReport();
    begin
        ExcelBuf.DELETEALL();
        ReadExcelSheet();
        GenJnlBatchName := "Gen. Journal Line".GETFILTER("Gen. Journal Line"."Journal Batch Name");
        GenJnlTemplateName := "Gen. Journal Line".GETFILTER("Gen. Journal Line"."Journal Template Name");
        AnalyzeData();
    end;

    var
        // BC Upgrade KUMARR78 >>
        InStr: InStream;
        FromFilter: Label 'Excel File (*.xlsx)|*.xlsx';
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        // BC Upgrade KUMARR78 <<
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        ExcelBuf: Record "Excel Buffer" temporary;
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalTemplate: Record "Gen. Journal Template";
        GeneralLedgerSetup: Record "General Ledger Setup";
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        DimMgt: Codeunit DimensionManagement;
        DimAdded: Boolean;
        Window: Dialog;
        Counter1: Integer;
        RecNo: Integer;
        RowNo: Integer;
        TotalRecNo: Integer;
        Text006: Label 'Import Excel File';
        Text007: Label 'Analyzing Data...\\';
        Text008: Label 'Gen. Journal template %1, batch %2 has been succesfully imported!';
        FileName: Text;
        GenJnlBatchName: Text;
        GenJnlTemplateName: Text;
        SheetName: Text;

    procedure ReadExcelSheet();
    begin
        // ExcelBuf.OpenBook(FileName, SheetName); // BC Upgrade KUMARR78 Blocking.
        ExcelBuf.OpenBookStream(InStr, SheetName);// BC Upgrade KUMARR78 Adding.
        ExcelBuf.ReadSheet();
    end;

    procedure AnalyzeData();
    var
        DimensionValue2: Record "Dimension Value";
        HeaderExcelBuffer: Record "Excel Buffer" temporary;
        GenJournalLine: Record "Gen. Journal Line";
        DimValue1: Code[20];
        DimValue2: Code[20];
        PostingDate: Date;
        Amount: Decimal;
        "//<<HEI.03 UGMA.D4579": Integer;
        "//>>HEI.03 UGMA.D4579": Integer;
        HeaderRowNo: Integer;
        LineNo: Integer;
        OldRowNo: Integer;
    begin
        HeaderExcelBuffer.DELETEALL();
        GeneralLedgerSetup.GET();
        GeneralOpCoSetup.GET();
        Window.OPEN(
          Text007 +
          '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.UPDATE(1, 0);
        TotalRecNo := ExcelBuf.COUNT;
        RecNo := 1;
        Counter1 := 0;
        LineNo := 10000;

        //>>HEI.03 //commented by HEI.04<<
        /*HeaderRowNo:=Get_HeaderRowNo(ExcelBuf);   //Store Header Row Number
        RecNo      := HeaderRowNo +1 ;            //In this row data start
        ExcelBuf.RESET;
        ClearJournal(GenJnlTemplateName,GenJnlBatchName);
        WHILE ExcelBuf.GET(RecNo,1) DO BEGIN
        
            Window.UPDATE(1,ROUND(RecNo / TotalRecNo * 10000,1));
            GenJournalLine.INIT;
            GenJournalLine.VALIDATE("Journal Template Name",GenJnlTemplateName);
            GenJournalLine.VALIDATE("Journal Batch Name",GenJnlBatchName);
            GenJournalLine.VALIDATE("Line No.",LineNo);
            LineNo += 10000;
            IF ExcelBuf.GET(RecNo,1) THEN BEGIN
              EVALUATE(PostingDate,ExcelBuf."Cell Value as Text");
              GenJournalLine.VALIDATE("Posting Date",PostingDate)
            END;
            IF ExcelBuf.GET(RecNo,3) THEN BEGIN
              EVALUATE(PostingDate,ExcelBuf."Cell Value as Text");
              GenJournalLine.VALIDATE("Document Date",PostingDate);
            END;
            GenJournalLine.VALIDATE("Account Type",GenJournalLine."Account Type"::"G/L Account");
            IF ExcelBuf.GET(RecNo,7) THEN
              GenJournalLine.VALIDATE("Account No.",ExcelBuf."Cell Value as Text");
            IF ExcelBuf.GET(RecNo,8) THEN
              GenJournalLine.VALIDATE(Description,ExcelBuf."Cell Value as Text");
            IF ExcelBuf.GET(RecNo,9) THEN BEGIN
              EVALUATE(Amount,ExcelBuf."Cell Value as Text");
              GenJournalLine.VALIDATE(Amount,Amount);
            END;
            IF ExcelBuf.GET(RecNo,14) THEN
              GenJournalLine.VALIDATE(Comment,ExcelBuf."Cell Value as Text");
        
            TempDimensionSetEntry.DELETEALL;
            DimAdded := FALSE;
            IF ExcelBuf.GET(RecNo,16) THEN BEGIN
              SetMainDim(GeneralLedgerSetup."Cost Center Dimension Code",ExcelBuf."Cell Value as Text",GenJournalLine);
              DimValue1 := ExcelBuf."Cell Value as Text";
            END;
        
            IF ExcelBuf.GET(RecNo,17) THEN BEGIN
              SetMainDim(GeneralOpCoSetup."Employee Payroll Dimension",ExcelBuf."Cell Value as Text",GenJournalLine);
              DimValue2 := ExcelBuf."Cell Value as Text";
            END;
        
            GenJournalLine."Dimension Set ID" := Get_SetDimID(GeneralLedgerSetup."Cost Center Dimension Code",DimValueExist2(GeneralLedgerSetup."Cost Center Dimension Code",DimValue1),
            GeneralOpCoSetup."Employee Payroll Dimension",DimValueExist2(GeneralOpCoSetup."Employee Payroll Dimension",DimValue2));
            GenJournalLine.INSERT;
        
            Counter1+=1;
            RecNo := RecNo + 1;
        END; */
        //<<HEI.03 commented by HEI.04

        //HEI.04 << uncommented
        if ExcelBuf.FIND('-') then begin
            // ClearJournal(GenJnlTemplateName,GenJnlBatchName); commented by HEI.04
            HeaderExcelBuffer := ExcelBuf;             //Store Header Row
            HeaderRowNo := RecNo; //HEI.04
            repeat
                RecNo := RecNo + 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                if (ExcelBuf."Row No." > HeaderRowNo) and (HeaderRowNo > 0) then begin
                    if ExcelBuf."Row No." <> OldRowNo then begin
                        OldRowNo := ExcelBuf."Row No.";
                        GenJournalLine.INIT();
                        GenJournalLine.VALIDATE("Journal Template Name", GenJnlTemplateName);
                        GenJournalLine.VALIDATE("Journal Batch Name", GenJnlBatchName);

                        GenJournalLine.VALIDATE("Line No.", LineNo);
                        LineNo += 10000;

                        //HEI.05<<
                        if GenJournalTemplate.GET(GenJournalLine."Journal Template Name") then
                            GenJournalLine.VALIDATE("Source Code", GenJournalTemplate."Source Code");
                        //HEI.05>>

                        if ExcelBuf.GET(ExcelBuf."Row No.", 1) then begin
                            EVALUATE(PostingDate, ExcelBuf."Cell Value as Text");
                            GenJournalLine.VALIDATE("Posting Date", PostingDate);
                        end;
                        if ExcelBuf.GET(ExcelBuf."Row No.", 2) then
                            GenJournalLine.VALIDATE("Document No.", ExcelBuf."Cell Value as Text");
                        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                        if ExcelBuf.GET(ExcelBuf."Row No.", 3) then
                            GenJournalLine.VALIDATE("Account No.", ExcelBuf."Cell Value as Text");
                        if ExcelBuf.GET(ExcelBuf."Row No.", 4) then
                            GenJournalLine.VALIDATE(Description, ExcelBuf."Cell Value as Text");
                        if ExcelBuf.GET(ExcelBuf."Row No.", 5) then begin
                            EVALUATE(Amount, ExcelBuf."Cell Value as Text");
                            GenJournalLine.VALIDATE(Amount, Amount);
                        end;
                        TempDimensionSetEntry.DELETEALL();
                        DimAdded := false;
                        if ExcelBuf.GET(ExcelBuf."Row No.", 6) then begin
                            TempDimensionSetEntry."Dimension Code" := GeneralLedgerSetup."Cost Center Dimension Code FND";
                            TempDimensionSetEntry."Dimension Value Code" := ExcelBuf."Cell Value as Text";
                            //HEI.02>>
                            DimensionValue2.RESET();
                            DimensionValue2.SETFILTER(DimensionValue2."Dimension Code", '%1', GeneralLedgerSetup."Cost Center Dimension Code FND");
                            DimensionValue2.SETFILTER(DimensionValue2.Code, '%1', ExcelBuf."Cell Value as Text");
                            if DimensionValue2.FINDFIRST() then
                                TempDimensionSetEntry."Dimension Value ID" := DimensionValue2."Dimension Value ID";
                            TempDimensionSetEntry.INSERT();
                            //HEI.02<<
                            DimAdded := true;
                            GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", ExcelBuf."Cell Value as Text"); //HEI.04
                        end;
                        if ExcelBuf.GET(ExcelBuf."Row No.", 7) then begin
                            // TempDimensionSetEntry."Dimension Code" := GeneralOpCoSetup."Employee Payroll Dimension"; //HEI.04
                            TempDimensionSetEntry."Dimension Code" := GeneralLedgerSetup."Shortcut Dimension 3 Code"; //HEI.04
                            TempDimensionSetEntry."Dimension Value Code" := ExcelBuf."Cell Value as Text";
                            //HEI.02>>
                            DimensionValue2.RESET();
                            // DimensionValue2.SETFILTER(DimensionValue2."Dimension Code",'%1',GeneralOpCoSetup."Employee Payroll Dimension"); //hei.04
                            DimensionValue2.SETFILTER("Dimension Code", '%1', GeneralLedgerSetup."Shortcut Dimension 3 Code"); //HEI.04
                            DimensionValue2.SETFILTER(DimensionValue2.Code, '%1', ExcelBuf."Cell Value as Text");
                            if DimensionValue2.FINDFIRST() then
                                TempDimensionSetEntry."Dimension Value ID" := DimensionValue2."Dimension Value ID";
                            TempDimensionSetEntry.INSERT();
                            //HEI.02<<
                            DimAdded := true;
                        end;
                        if DimAdded then begin
                            GenJournalLine.VALIDATE("Dimension Set ID", DimMgt.GetDimensionSetID(TempDimensionSetEntry));
                            //GenJournalLine.MODIFY;
                        end;
                        GenJournalLine.INSERT();

                        Counter1 += 1;
                    end;
                end;
            until ExcelBuf.NEXT() = 0;
        end;
        //HEI.04>> uncommented
        Window.CLOSE();

    end;

    procedure SetParam(GenJournalTemplate: Text; GenJournalBatch: Text);
    begin
        GenJnlBatchName := GenJournalBatch;
        GenJnlTemplateName := GenJournalTemplate;
    end;

    local procedure "//>>HEI.03"();
    begin
    end;

    local procedure Get_HeaderRowNo(var ExcelFile: Record "Excel Buffer") RowNo: Integer;
    begin
        RowNo := 1;
        ExcelFile.RESET();
        ExcelFile.SETRANGE("Column No.", 1);
        ExcelFile.SETFILTER("Cell Value as Text", 'Posting Date');
        if ExcelFile.FINDFIRST() then exit(ExcelFile."Row No.");
        exit(1);
    end;

    local procedure ClearJournal(TmplName: Code[20]; BatchName: Code[20]);
    var
        GJL: Record "Gen. Journal Line";
        Mess_1: TextConst ENU = 'Batch journal %1 has lines already, Would you like delete it before import?', ESM = 'Sección diario %1 tiene linea creadas, ¿Desea eliminarlas antes de importar?', ENC = 'Batch journal %1 has lines already, Would you like delete it before import?';
    begin
        GJL.RESET();
        GJL.SETRANGE("Journal Template Name", TmplName);
        GJL.SETRANGE("Journal Batch Name", BatchName);
        if GJL.FINDSET() then
            if CONFIRM(Mess_1, true, BatchName) then GJL.DELETEALL();
    end;

    local procedure DimenssionExist(DimensionCode: Code[20]; DimensionValueCode: Code[20]) resul: Boolean;
    var
        Dims: Record Dimension;
        DimensionValue: Record "Dimension Value";
        Err_0: TextConst ENU = 'Dimension %1 doesn''t exist in system, please review it', ESM = 'Dimension %1 no existe en el listado del sistema', ENC = 'Dimension %1 doesn''t exist in system, please review it';
        Err_1: TextConst ENU = 'Value %1 for dimension %2 not valid or doesn''t exist in system, please review', ESM = 'Valor%1 para  la dimensión %2 no es válido o no puede encontrarse en el listado de valores de dimensión', ENC = 'Value %1 for dimension %2 not valid or doesn''t exist in system, please review';
    begin
        if not Dims.GET(DimensionCode) then ERROR(STRSUBSTNO(Err_0, DimensionCode));
        if STRLEN(DimensionValueCode) = 0 then exit(true);
        if not DimensionValue.GET(DimensionCode, DimensionValueCode) then ERROR(STRSUBSTNO(Err_1, DimensionValueCode, DimensionCode));
        exit(true);
    end;

    local procedure DimValueExist(DimCode: Code[20]; DimValue: Code[20]) result: Boolean;
    var
        dimvalues: Record "Dimension Value";
    begin
        if dimvalues.GET(DimCode, DimValue) then exit(true);
        exit(false);
    end;

    local procedure DimValueExist2(DimCode: Code[20]; DimValue: Code[20]) Value: Code[20];
    var
        dimvalues: Record "Dimension Value";
    begin
        if dimvalues.GET(DimCode, DimValue) then exit(DimValue);
        exit('');
    end;

    local procedure SetMainDim(DimCode: Code[20]; DimValue: Code[20]; var GenJournalLine: Record "Gen. Journal Line");
    var
        GLS: Record "General Ledger Setup";
    begin
        if DimenssionExist(DimCode, DimValue) then begin
            GLS.RESET();
            GLS.GET();
            if GLS."Global Dimension 1 Code" = DimCode then GenJournalLine."Shortcut Dimension 1 Code" := DimValue;
            if GLS."Global Dimension 2 Code" = DimCode then GenJournalLine."Shortcut Dimension 2 Code" := DimValue
        end;
    end;

    local procedure Get_SetDimID(Dim1: Code[20]; DimValue1: Code[20]; Dim2: Code[20]; DimValue2: Code[20]) SetID: Integer;
    var
        SetDimEntry: Record "Dimension Set Entry";
        SetDimEntry_2: Record "Dimension Set Entry";
        LasEntryNo: Integer;
        NoDims: Integer;
    begin

        if ((STRLEN(DimValue1) <> 0) and (STRLEN(DimValue2) <> 0)) then begin
            SetDimEntry.RESET();
            SetDimEntry.SETRANGE("Dimension Code", Dim1);
            SetDimEntry.SETRANGE("Dimension Value Code", DimValue1);
            if SetDimEntry.FINDFIRST() then
                repeat
                    SetDimEntry_2.RESET();
                    SetDimEntry_2.SETRANGE("Dimension Set ID", SetDimEntry."Dimension Set ID");
                    if SetDimEntry_2.COUNT = 2 then begin
                        SetDimEntry_2.SETRANGE("Dimension Code", Dim2);
                        SetDimEntry_2.SETRANGE("Dimension Value Code", DimValue2);
                        if SetDimEntry_2.FINDFIRST() then exit(SetDimEntry."Dimension Set ID");
                    end;
                until SetDimEntry.NEXT() = 0;
        end else begin
            if STRLEN(DimValue1) <> 0 then begin
                SetDimEntry.RESET();
                SetDimEntry.SETRANGE("Dimension Code", Dim1);
                SetDimEntry.SETRANGE("Dimension Value Code", DimValue1);
                if SetDimEntry.FINDFIRST() then
                    repeat
                        SetDimEntry_2.RESET();
                        SetDimEntry_2.SETRANGE("Dimension Set ID", SetDimEntry."Dimension Set ID");
                        if SetDimEntry_2.COUNT = 1 then
                            if SetDimEntry_2.FINDFIRST() then exit(SetDimEntry."Dimension Set ID");
                    until SetDimEntry.NEXT() = 0;
            end else if STRLEN(DimValue2) <> 0 then begin
                SetDimEntry.RESET();
                SetDimEntry.SETRANGE("Dimension Code", Dim2);
                SetDimEntry.SETRANGE("Dimension Value Code", DimValue2);
                if SetDimEntry.FINDFIRST() then
                    repeat
                        SetDimEntry_2.RESET();
                        SetDimEntry_2.SETRANGE("Dimension Set ID", SetDimEntry."Dimension Set ID");
                        if SetDimEntry_2.COUNT = 1 then
                            if SetDimEntry_2.FINDFIRST() then exit(SetDimEntry."Dimension Set ID");
                    until SetDimEntry.NEXT() = 0;
            end;
        end;

        SetDimEntry.RESET();
        if SetDimEntry.FINDLAST() then
            LasEntryNo := SetDimEntry."Dimension Set ID" + 1
        else
            LasEntryNo := 1;
        if (STRLEN(DimValue1) <> 0) and DimenssionExist(Dim1, DimValue1) then begin
            SetDimEntry.INIT();
            SetDimEntry."Dimension Set ID" := LasEntryNo;
            SetDimEntry."Dimension Code" := Dim1;
            SetDimEntry."Dimension Value Code" := DimValue1;
            SetDimEntry.INSERT();
        end;
        if (STRLEN(DimValue2) <> 0) and DimenssionExist(Dim2, DimValue2) then begin
            SetDimEntry.INIT();
            SetDimEntry."Dimension Set ID" := LasEntryNo;
            SetDimEntry."Dimension Code" := Dim2;
            SetDimEntry."Dimension Value Code" := DimValue2;
            SetDimEntry.INSERT();
        end;
        exit(LasEntryNo);
    end;

    local procedure "//<<HEI.03"();
    begin
    end;
}

