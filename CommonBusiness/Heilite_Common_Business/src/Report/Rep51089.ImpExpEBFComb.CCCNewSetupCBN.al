report 51089 "ImpExp EBF Comb CCC Setup CBN"
{
    // version HEI.06

    // HEI.01 CHG2171687 IBM SISUM01 07/03/2023 #create new object
    // HEI.02 CHG2171687 IBM SISUM01 10/03/2023 #updates and add skip accounts with financial statement = Local
    // HEI.03 CHG2171687 IBM SISUM01 20/03/2023 #add export/import option. Change report name and caption
    // HEI.04 CHG2171687 IBM SISUM01 26/04/2023 #bug fix
    // HEI.05 CHG2171687 IBM SISUM01 19/05/2023 HB3907 EBF Matrix
    //   # test if New EBF verison is enable
    // HEI.06 CHG2171687 IBM SISUM01 22/11/2023 HB3907 EBF Matrix
    //   # test if Validate Dimension Value is enable

    //----------------------------------------------------------------------------------------------------
    //BC Upgrade KAPOOV01 17.12.2025 # Replaced function- UploadFile with UploadIntoStream on trigger OnAssistEdit()-FileName
    //BC Upgrade KAPOOV01 17.12.2025 # Replaced function- SelectSheetsName with SelectSheetsNameStream on trigger OnAssistEdit()-SheetName
    //BC Upgrade KAPOOV01 17.12.2025 # Modified code on trigger OnAssistEdit()-FilePath-1.commented ServerTempFileName as it is removed in BC,2. Commented SaveFileDialog as it is removed in BC.
    //BC Upgrade KAPOOV01 17.12.2025 # Replaced function-OpenBook with OpenBookStream in Procedure-ReadExcelSheet().
    //BC Upgrade KAPOOV01 17.12.2025 # Modified code in function-Export2Excel()-1.replaced CreateBook with CreateNewBook,2.Commented DownloadTempFile, it is Obsoltete in BC,3.Commented MoveAndRenameClientFile, it is Obsoltete in BC

    Caption = 'Import/Export EBF Comb CCC New Setup';
    ProcessingOnly = true;
    UsageCategory = Lists;
    ApplicationArea = All;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Import From"; '')
                {
                    Caption = 'Import From';
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Import From field.';
                }
                field("WorkBook File Name"; FileName)
                {
                    CaptionML = ENU = 'Workbook File Name',
                                NLD = 'Werkmapbestandsnaam';
                    Enabled = ControlImportEnable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FileName field.';

                    trigger OnAssistEdit();
                    begin

                        //BC Upgrade KAPOOV01>>
                        //FileName := FileMgt.UploadFile(Text50001, ExcelFileExtensionTok);
                        File.UploadIntoStream(Text50001, '', FromFilter, FileName, InStr);
                        //BC Upgrade KAPOOV01<<
                    end;
                }
                field("Worksheet Name"; SheetName)
                {
                    CaptionML = ENU = 'Worksheet Name',
                                NLD = 'Werkbladnaam';
                    Enabled = ControlImportEnable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SheetName field.';

                    trigger OnAssistEdit();
                    begin

                        //BC Upgrade KAPOOV01>>
                        //SheetName := TempExcelBuffer.SelectSheetsName(FileName);
                        SheetName := TempExcelBuffer.SelectSheetsNameStream(InStr);
                        //BC Upgrade KAPOOV01<<
                    end;
                }
                field("Choose the operator:"; CCOperator)
                {
                    Caption = 'Choose the operator:';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Choose the operator: field.';
                }
                field("Import/Export"; ImportExport)
                {
                    Caption = 'Import/Export';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Import/Export field.';

                    trigger OnValidate();
                    begin
                        if ImportExport = ImportExport::Import then begin
                            ControlImportEnable := true;
                            ControlExportEnable := false;
                            FilePath := '';
                        end else begin
                            ControlImportEnable := false;
                            ControlExportEnable := true;
                            FileName := '';
                            SheetName := '';
                        end;
                    end;
                }
                field("Export To"; FilePath)
                {
                    Caption = 'Export To';
                    Enabled = ControlExportEnable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Export To field.';

                    trigger OnAssistEdit();
                    begin
                        //BC Upgrade KAPOOV01 commented ServerTempFileName as it is removed in BC >>
                        //ExportServerFileName := FileMgt.ServerTempFileName('xlsx');
                        //BC Upgrade KAPOOV01 commented ServerTempFileName as it is removed in BC <<

                        ExportFileName := 'EBFMatrixSetup' + '_' + COMPANYNAME + '_' + FORMAT(TODAY, 0, '<Day,2><Month,2><Year>') + FORMAT(TIME, 0, '<Hours24,2><Filler Character,0><Minutes,2>');

                        //BC Upgrade KAPOOV01 SaveFileDialog it is removed in BC >>
                        //FilePath := FileMgt.SaveFileDialog(WindowTitle, ExportFileName, 'Excel File (*.xlsx)|*.xlsx');
                        //BC Upgrade KAPOOV01 SaveFileDialog  it is removed in BC <<

                        //BC Upgrade KAPOOV01 commented below code as filepaths not used in BC>>
                        // if (FilePath = '') then
                        //     ERROR(FileError);
                        //BC Upgrade KAPOOV01 commented below code as filepaths not used in BC<<
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

    trigger OnInitReport();
    begin
        //HEI.05>>
        if not EBFCombination.CheckNewEBFMatrixIsActive() then
            ERROR(Text50008);
        //HEI.05<<

        //HEI.03>>
        ControlImportEnable := true;
        ControlExportEnable := false;
        //HEI.03<<
    end;

    trigger OnPostReport();
    begin
        if ImportExport = ImportExport::Import then begin //HEI.03
            Window.CLOSE();

            //HEI.02>>
            if EBFCombinationNotInsertedTmp.FINDFIRST() then
                repeat
                    AccountsNotImported += EBFCombinationNotInsertedTmp."GL Account No." + ',';
                until EBFCombinationNotInsertedTmp.NEXT() = 0;
            if (AccountsNotImported <> '') then
                MESSAGE(Text50006, AccountsNotImported, WhseSetup."SCOA Financial Statement FND");
            //HEI.02<<

            //HEI.04>>
            if EBFCombinationNotInsertCCCValueTmp.FINDFIRST() then
                repeat
                    DimValueNotImported += EBFCombinationNotInsertCCCValueTmp."Dimension Value Code" + ',';
                until EBFCombinationNotInsertCCCValueTmp.NEXT() = 0;
            if (DimValueNotImported <> '') then
                MESSAGE(Text50007, DimValueNotImported);
            //HEI.04<<

            if Imported then
                MESSAGE(Text50003)
            else
                MESSAGE(Text50004);
        end; //HEI.03
    end;

    trigger OnPreReport();
    begin
        if ImportExport = ImportExport::Import then begin //HEI.03
            Answer := CONFIRM(Text50000, true);

            //HEI.02>>
            /*
            IF Answer THEN BEGIN
              DeleteExistingEntries;
            END ELSE BEGIN
              IF NOT CONFIRM(Text50005,TRUE) THEN
                CurrReport.QUIT;
            END;
            */

            if not Answer then
                CurrReport.QUIT();
            //HEI.02<<

            Window.OPEN(Text50002 + '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');

            GLSetup.GET();
            WhseSetup.GET(); //HEI.02
            ReadExcelSheet();
            DecomposeSetup(); //HEI.02
            AnalyzeData();
            ProcessSetup(EBFCombination."Combination Restriction"::" ");
            ProcessSetup(EBFCombination."Combination Restriction"::"Allowed with Warn");
            ProcessSetup(EBFCombination."Combination Restriction"::"Not Allowed");
            //HEI.03>>
        end else
            Export2Excel(ExportServerFileName, FilePath);
        //HEI.03<<

    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        FileMgt: Codeunit "File Management";
        ServerFileName: Text;
        ClientFileName: Text;
        SheetName: Text[250];
        RowNo: Integer;
        FileName: Text;
        Window: Dialog;
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        NoOfProgresed: Integer;
        Counter: Integer;
        TimeProgress: Time;
        RecNo: Integer;
        TotalRecNo: Integer;
        Counter1: Integer;
        Imported: Boolean;
        ExcelFileExtensionTok: Label '.xlsx';
        Text50001: Label 'EBF Combination new setup';
        Text50000: Label 'The setup will be updated. Do you want to proceed?';
        Text50002: Label 'Analyzing Data...\\';
        Text50003: Label 'Import successful!';
        Text50004: Label 'Nothing has been imported!';
        Text50005: Label 'The import will add new lines to the existing data. Do you want to proceed?';
        CCOperator: Option "??";
        GLSetup: Record "General Ledger Setup";
        EBFCombination: Record "Ebf Combination FND";
        CombinationRestriction: Option " ","Not Allowed","Allowed with Warn";
        EBFCombinationTmp: Record "Ebf Combination FND" temporary;
        Answer: Boolean;
        WhseSetup: Record "Warehouse Setup";
        Text50006: Label 'Following Accounts Range %1 don''t have Financial Statement values %2 or they are not defined in Chart of Account and are not impoted in setup.';
        AccountsNotImported: Text;
        EBFCombinationNotInsertedTmp: Record "Ebf Combination FND" temporary;
        ToBeInsert: Boolean;
        GLAccount: Record "G/L Account";
        ImportExport: Option Import,Export;
        FilePath: Text[250];
        ExportServerFileName: Text;
        ExportFileName: Text;

        ControlImportEnable: Boolean;

        ControlExportEnable: Boolean;
        EBFCombinationNotInsertCCCValueTmp: Record "Ebf Combination FND" temporary;
        DimensionValue: Record "Dimension Value";
        DimValueNotImported: Text;
        Text50007: Label 'Following Dimensions Value ranges %1 are not present in Dimension Value.';
        SepValues: Label '|';
        CCCDimOperator: Label '?';
        WindowTitle: Label 'Save to Path';
        FileError: Label 'Path must not be empty.';
        Text50008: Label 'The new EBF version is not enable. The report can''t be use.';
        //BC Upgrade KAPOOV01>>
        InStr: InStream;
        FromFilter: Label 'Excel File (*.xlsx)|*.xlsx';
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
    //BC Upgrade KAPOOV01<<

    procedure ReadExcelSheet();
    begin

        //BC Upgrade KAPOOV01>>
        //TempExcelBuffer.OpenBook(FileName, SheetName);
        TempExcelBuffer.OpenBookStream(InStr, SheetName);
        //BC Upgrade KAPOOV01<<
        TempExcelBuffer.ReadSheet();
    end;

    procedure AnalyzeData();
    var
        HeaderRowNo: Integer;
        OldRowNo: Integer;
        SCOA: Text;
        CostCenterCode: Text;
        C2SNameOption: Option " ","Warehouse Handling Costs (Variable)","Warehouse Overhead Costs (Fixed)","General Overhead Costs (Fixed)","Delivery To Customers","Own Fleet","Whse Hand. Costs (Variable) OVE","Whse Hand. Costs (Variable) Transp. Exp.","Whse Hand. Costs (Variable) Fixed Exp.";
        DistType: Option Primary,Secondary;
    begin
        Window.UPDATE(1, 0);
        TotalRecNo := TempExcelBuffer.COUNT;
        RecNo := 1;
        Counter1 := 0;

        if TempExcelBuffer.FIND('-') then begin
            HeaderRowNo := RecNo;
            repeat
                RecNo := RecNo + 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                if (TempExcelBuffer."Row No." > HeaderRowNo) and (HeaderRowNo > 0) then begin
                    CLEAR(SCOA);
                    CLEAR(CostCenterCode);
                    CLEAR(CombinationRestriction);

                    //SCOA
                    if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 1) then
                        SCOA := TempExcelBuffer."Cell Value as Text";

                    //CCC code
                    if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 2) then
                        if TempExcelBuffer."Cell Value as Text" <> '' then
                            CostCenterCode := FORMAT(CCOperator) + TempExcelBuffer."Cell Value as Text" + FORMAT(CCOperator);

                    //Combination Restriction
                    if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 3) then
                        EVALUATE(CombinationRestriction, TempExcelBuffer."Cell Value as Text");

                    //HEI.02>>
                    ToBeInsert := true;
                    GLAccount.RESET();
                    GLAccount.SETFILTER("No.", SCOA + '*');
                    GLAccount.SETFILTER("Financial Stmt version FND", WhseSetup."SCOA Financial Statement FND");
                    GLAccount.SETFILTER("Account Type", '%1', GLAccount."Account Type"::Posting);
                    if GLAccount.ISEMPTY then begin
                        EBFCombinationNotInsertedTmp."GL Account No." := SCOA + '*';
                        if EBFCombinationNotInsertedTmp.INSERT() then;
                        ToBeInsert := false;
                    end;
                    //HEI.02<<

                    //HEI.04>>
                    //HEI.06>>
                    //IF ToBeInsert THEN BEGIN
                    if ToBeInsert and EBFCombination.CheckValidationDimValueIsActive() then begin
                        //HEI.06<<
                        DimensionValue.SETRANGE("Dimension Code", GLSetup."Shortcut Dimension 2 Code");
                        DimensionValue.SETFILTER(Code, '*' + CostCenterCode + '*');
                        if DimensionValue.ISEMPTY then begin
                            EBFCombinationNotInsertCCCValueTmp."Dimension Value Code" := CostCenterCode;
                            if EBFCombinationNotInsertCCCValueTmp.INSERT() then;
                            ToBeInsert := false;
                        end;
                    end;
                    //HEI.04<<

                    if ToBeInsert then begin //HEI.02
                        EBFCombinationTmp.RESET();
                        EBFCombinationTmp.SETFILTER("GL Account No.", SCOA + '*');
                        EBFCombinationTmp.SETRANGE("Dimension Code", GLSetup."Shortcut Dimension 2 Code");
                        EBFCombinationTmp.SETFILTER("Dimension Value Code", '*' + CostCenterCode + '*');
                        if not EBFCombinationTmp.FINDFIRST() then begin
                            EBFCombinationTmp.INIT();
                            EBFCombinationTmp."GL Account No." := SCOA + '*';
                            EBFCombinationTmp."Dimension Code" := GLSetup."Shortcut Dimension 2 Code";
                            EBFCombinationTmp."Dimension Value Code" := CostCenterCode;
                            EBFCombinationTmp."Combination Restriction" := CombinationRestriction;
                            EBFCombinationTmp.INSERT();
                        end else begin
                            if EBFCombinationTmp."Combination Restriction" <> CombinationRestriction then begin
                                EBFCombinationTmp."Combination Restriction" := CombinationRestriction;
                                EBFCombinationTmp.MODIFY();
                            end;
                        end;
                    end;
                end; //HEI.02
            until TempExcelBuffer.NEXT() = 0;

            EBFCombination.RESET();
            if EBFCombination.FINDFIRST() then
                DeleteExistingEntries();
        end;
    end;

    local procedure ProcessSetup(CombRest: Option " ","Not Allowed","Allowed with Warn");
    var
        NewAccountNo: Code[10];
        OldAccountNo: Code[10];
        FieldLenght: Integer;
        NewDimValue: Code[100];
        OldDimValue: Code[50];
        FirstIteration: Boolean;
        a: Integer;
    begin
        FieldLenght := MAXSTRLEN(EBFCombination."Dimension Value Code");
        FirstIteration := true;
        EBFCombinationTmp.RESET();
        EBFCombinationTmp.SETCURRENTKEY("GL Account No.");
        EBFCombinationTmp.SETASCENDING("GL Account No.", true);
        EBFCombinationTmp.SETFILTER("Combination Restriction", '%1', CombRest);
        if EBFCombinationTmp.FINDSET(false) then
            repeat
                NewAccountNo := EBFCombinationTmp."GL Account No.";

                if (STRLEN(NewDimValue) <> 0) then begin
                    OldDimValue := NewDimValue;
                    NewDimValue += '|' + EBFCombinationTmp."Dimension Value Code";
                end else
                    NewDimValue := EBFCombinationTmp."Dimension Value Code";

                if ((NewAccountNo = OldAccountNo) and (STRLEN(NewDimValue) > FieldLenght)) then begin
                    InsertSetup(OldDimValue, EBFCombinationTmp."GL Account No.", CombRest);
                    NewDimValue := EBFCombinationTmp."Dimension Value Code";
                end;

                if ((NewAccountNo <> OldAccountNo) and (not FirstIteration)) then begin
                    InsertSetup(OldDimValue, OldAccountNo, CombRest);
                    NewDimValue := EBFCombinationTmp."Dimension Value Code";
                end;

                OldAccountNo := NewAccountNo;
                FirstIteration := false;
                Imported := true;
            until EBFCombinationTmp.NEXT() = 0;

        if (NewDimValue <> '') then //HEI.04
            InsertSetup(NewDimValue, NewAccountNo, CombRest);
    end;

    local procedure DeleteExistingEntries();
    begin
        EBFCombination.RESET();
        if not EBFCombination.ISEMPTY then
            EBFCombination.DELETEALL();
    end;

    local procedure InsertSetup(DimValue: Code[50]; GLAccountNo: Code[20]; CombRestrict: Option " ","Not Allowed","Allowed with Warn");
    begin
        EBFCombination.INIT();
        EBFCombination."GL Account No." := GLAccountNo;
        EBFCombination."Dimension Code" := GLSetup."Shortcut Dimension 2 Code";
        EBFCombination."Dimension Value Code" := DimValue;
        EBFCombination."Combination Restriction" := CombRestrict;
        if EBFCombination.INSERT(true) then;
    end;

    local procedure DecomposeSetup();
    var
        CCCDimValueArr: array[100] of Code[20];
        i: Integer;
        CountCCCDimSeparator: Integer;
        LenghtCCCDim: Integer;
        CCCDimValueTxt: Code[50];
    begin
        //HEI.02>>
        EBFCombination.RESET();
        if EBFCombination.FINDSET(false) then
            repeat

                CLEAR(CCCDimValueArr);
                LenghtCCCDim := STRLEN(EBFCombination."Dimension Value Code");
                CCCDimValueTxt := EBFCombination."Dimension Value Code";
                CountCCCDimSeparator := STRLEN(EBFCombination."Dimension Value Code") - STRLEN(DELCHR(EBFCombination."Dimension Value Code", '=', SepValues));


                for i := 1 to CountCCCDimSeparator + 1 do begin
                    if (i = CountCCCDimSeparator + 1) then
                        CCCDimValueArr[i] := DELCHR(CCCDimValueTxt, '=', CCCDimOperator)
                    else begin
                        CCCDimValueArr[i] := DELCHR(COPYSTR(CCCDimValueTxt, 1, STRPOS(CCCDimValueTxt, SepValues) - 1), '=', CCCDimOperator);
                        CCCDimValueTxt := COPYSTR(CCCDimValueTxt, STRPOS(CCCDimValueTxt, SepValues) + 1);
                    end;
                end;

                for i := 1 to CountCCCDimSeparator + 1 do begin
                    EBFCombinationTmp."GL Account No." := EBFCombination."GL Account No.";
                    EBFCombinationTmp."Dimension Code" := EBFCombination."Dimension Code";
                    EBFCombinationTmp."Dimension Value Code" := FORMAT(CCOperator) + CCCDimValueArr[i] + FORMAT(CCOperator);
                    EBFCombinationTmp."Combination Restriction" := EBFCombination."Combination Restriction";
                    EBFCombinationTmp.INSERT();
                end;
            until EBFCombination.NEXT() = 0;
        //HEI.02<<
    end;

    procedure Export2Excel(ServerFileName: Text; FilePath: Text);
    var
        TmpExcelBuffer: Record "Excel Buffer" temporary;
        SheetName: Label 'SCOA';
        GLAccRange: Label 'G/L Account Range';
        CCCDimFilter: Label 'CCC Dim. Filter';
        C2SName: Label 'C2S Name';
        DistribType: Label 'Distribution Type';
        lEBFMatrix: Record "Ebf Combination FND";
        GLAcc: array[200] of Code[20];
        CCCDim: array[200] of Code[20];
        LenghtGLAcc: Integer;
        LenghtCCCDim: Integer;
        i: Integer;
        j: Integer;
        SepValues: Label '|';
        GLOperator: Label '*';
        CCCDimOperator: Label '?';
        GLAccTxt: Text[250];
        CCCDimTxt: Text[250];
        CountGLSeparator: Integer;
        CountCCCDimSeparator: Integer;
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        NoOfProgresed: Integer;
        Counter: Integer;
        TimeProgress: Time;
        Txt: Label 'Export records       @1@@@@@@@@@@@';
        Window: Dialog;
        FileName: Text[250];
        ClientFileName: Text;
        FileMgt: Codeunit "File Management";
        ExportMessage: Label 'Excel file is created to %1.';
        DirectoryName: Text;
        CombinationRestrictionTxt: Label 'Combination Restriction';
    begin
        //HEI.03>>
        if GUIALLOWED then begin
            Window.OPEN(Txt);
            NoOfRecords := lEBFMatrix.COUNT;
            NoOfRecProgress := NoOfRecords div 100;
            Counter := 0;
            NoOfProgresed := 0;
            TimeProgress := TIME;
        end;

        TmpExcelBuffer.RESET();
        TmpExcelBuffer.DELETEALL();

        //header
        TmpExcelBuffer.NewRow();
        TmpExcelBuffer.AddColumn(GLAccRange, false, '', true, false, false, '', TmpExcelBuffer."Cell Type"::Text);
        TmpExcelBuffer.AddColumn(CCCDimFilter, false, '', true, false, false, '', TmpExcelBuffer."Cell Type"::Text);
        TmpExcelBuffer.AddColumn(CombinationRestrictionTxt, false, '', true, false, false, '', TmpExcelBuffer."Cell Type"::Text);

        //body
        if lEBFMatrix.FINDFIRST() then
            repeat

                if GUIALLOWED then begin //HEI.07<<
                    Counter += 1;
                    if Counter >= NoOfRecProgress then begin
                        NoOfProgresed := NoOfProgresed + Counter;
                        Window.UPDATE(1, ROUND(NoOfProgresed / NoOfRecords * 10000, 1));
                        Counter := 0;
                        TimeProgress := TIME;
                    end;
                end;

                CLEAR(GLAcc);
                CLEAR(CCCDim);
                LenghtGLAcc := STRLEN(lEBFMatrix."GL Account No.");
                LenghtCCCDim := STRLEN(lEBFMatrix."Dimension Value Code");
                GLAccTxt := lEBFMatrix."GL Account No.";
                CCCDimTxt := lEBFMatrix."Dimension Value Code";
                CountGLSeparator := STRLEN(lEBFMatrix."GL Account No.") - STRLEN(DELCHR(lEBFMatrix."GL Account No.", '=', SepValues));
                CountCCCDimSeparator := STRLEN(lEBFMatrix."Dimension Value Code") - STRLEN(DELCHR(lEBFMatrix."Dimension Value Code", '=', SepValues));

                for i := 1 to CountGLSeparator + 1 do begin
                    if (i = CountGLSeparator + 1) then
                        GLAcc[i] := DELCHR(GLAccTxt, '=', GLOperator)
                    else begin
                        GLAcc[i] := DELCHR(COPYSTR(GLAccTxt, 1, STRPOS(GLAccTxt, SepValues) - 1), '=', GLOperator);
                        GLAccTxt := COPYSTR(GLAccTxt, STRPOS(GLAccTxt, SepValues) + 1);
                    end;
                end;

                for i := 1 to CountCCCDimSeparator + 1 do begin
                    if (i = CountCCCDimSeparator + 1) then
                        CCCDim[i] := DELCHR(CCCDimTxt, '=', CCCDimOperator)
                    else begin
                        CCCDim[i] := DELCHR(COPYSTR(CCCDimTxt, 1, STRPOS(CCCDimTxt, SepValues) - 1), '=', CCCDimOperator);
                        CCCDimTxt := COPYSTR(CCCDimTxt, STRPOS(CCCDimTxt, SepValues) + 1);
                    end;
                end;

                for i := 1 to CountGLSeparator + 1 do
                    for j := 1 to CountCCCDimSeparator + 1 do begin
                        TmpExcelBuffer.NewRow();
                        TmpExcelBuffer.AddColumn(GLAcc[i], false, '', false, false, false, '', TmpExcelBuffer."Cell Type"::Text);
                        TmpExcelBuffer.AddColumn(CCCDim[j], false, '', false, false, false, '', TmpExcelBuffer."Cell Type"::Text);
                        TmpExcelBuffer.AddColumn(lEBFMatrix."Combination Restriction", false, '', false, false, false, '', TmpExcelBuffer."Cell Type"::Text);
                    end;
            until lEBFMatrix.NEXT() = 0;

        if GUIALLOWED then
            Window.CLOSE();

        //create excel
        //BC Upgrade KAPOOV01>>
        //TmpExcelBuffer.CreateBook(ServerFileName, 'EBFMatrix'); //BC Upgrade KAPOOV01 replaced CreateBook with CreateNewBook as ServerFileName not used in BC.
        ExportFileName := 'EBFMatrixSetup' + '_' + COMPANYNAME + '_' + FORMAT(TODAY, 0, '<Day,2><Month,2><Year>') + FORMAT(TIME, 0, '<Hours24,2><Filler Character,0><Minutes,2>'); //BC Upgrade KAPOOV01 update ExportFileName.
        TempBlob.CreateOutStream(OutStr);  //BC Upgrade KAPOOV01 Create Outstream.
        TmpExcelBuffer.CreateNewBook('EBFMatrix');//BC Upgrade KAPOOV01 replaced CreateBook with CreateNewBook.
        //BC Upgrade KAPOOV01 <<

        TmpExcelBuffer.WriteSheet('EBFMatrix', COMPANYNAME, USERID);
        TmpExcelBuffer.SetFriendlyFilename(ExportFileName + '.xlsx'); //BC Upgrade KAPOOV01 add file name.
        TmpExcelBuffer.CloseBook();
        TmpExcelBuffer.OpenExcel();  //BC Upgrade KAPOOV01 Download excel file.

        //BC Upgrade KAPOOV01 Commented DownloadTempFile, it is Obsoltete in BC >>
        //ClientFileName := FileMgt.DownloadTempFile(ServerFileName);
        //DirectoryName := FileMgt.GetDirectoryName(FilePath);
        //BC Upgrade KAPOOV01 Commented DownloadTempFile, it is Obsoltete in BC <<


        //BC Upgrade KAPOOV01 Commented MoveAndRenameClientFile, it is Obsoltete in BC >>
        //FileName := DELCHR(COPYSTR(FilePath, STRLEN(DirectoryName) + 1), '=', '\');
        //FileMgt.MoveAndRenameClientFile(ClientFileName, FileName, DirectoryName);
        //BC Upgrade KAPOOV01 Commented MoveAndRenameClientFile, it is Obsoltete in BC <<

        //BC Upgrade KAPOOV01 commented below code as Filepath does not exists in BC >>
        //MESSAGE(ExportMessage, FilePath);
        MESSAGE(ExportMessage, ExportFileName); //BC Upgrade KAPOOV01 Replaced FilePath with ExportFileName.
        //BC Upgrade KAPOOV01 <<
        //HEI.03<<
    end;
}

