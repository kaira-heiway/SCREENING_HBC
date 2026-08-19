report 51000 "Import Gen.Jrnl From Excel CBN"
{
    // version HEI.09

    // 
    // FDD-HNK 100078 : 12/18/2015 Isyed01:
    // #Created new report for Import PayRoll Journal from Excel Flat File (#Dimensions implement)
    // 
    // Issue:23 - 02022017 - Hortoc01 - Sierra Leone issue list
    // Issue:3 - Haiti - validate document date
    // 
    // HEI.01 FDD-RTRGAP043 IBM POENAB01 26.07.2017 #Upload Mass Journal Entry Template
    //   #Object created
    // 
    // HEI.02 FDD-RTRGAP043 IBM POENAB01 08.08.2017 #Upload Mass Journal Entry Template
    //   #The header no longer needs to be deleted before import
    //   #Transmit External Document No. to journal
    // 
    // HEI.03 FDD-RTRGAP043 IBM POENAB01 08.08.2017 #Upload Mass Journal Entry Template
    //   # Rework for dimensions
    // 
    // HEI.05 Defect #934 IBM POSTOI01 11.09.2017 #Upload Mass Journal Entry Template
    //   # Change caption from Change Posting Date into Calculate New Posting Date (date formula)
    //   # Modify text constant ExcelFileExtensionTok to .xlsx,xlsm
    // 
    // HEI.06 DefectID #1012 IBM HORTOC01 12.12.2017 # fill in source code on import
    // 
    // HEI.07 Defect #934 IBM.NAIKH01 28.12.2017
    //   # Added New code to add new line in General Journal Line with reversal amount
    // 
    // HEI.08 Defcet #934 IBM.NAIKH01 18.01.2018
    //   # Changed the code with respect to the points mentioned in the mail from IDA.
    // 
    // HEI.09 Defect #2503 IBM POSTOI01 10.08.2018 # some column from the Excel file are not imported in the journal lines
    //   # add code to AnalyzeData function to import the following columns from the Excel file : VAT Bus. Posting Group, VAT Prod. Posting Group, Gen. Bus. Posting Group, Gen. Prod. Posting Group
    //   # add 4 new global text constants: Text50002, Text50003, Text50004, Text50005
    // 
    // HEI.10 defect #3219  IBM.NAIKH01 17.10.2018
    //   # add code to AnalyzeData function to import the following columns from the Excel file : Gen. Posting Type
    //   # add new global text constants: Text50006
    // 
    // HEI.11 defect #3181  IBM.NAIKH01 18.10.2018
    //   # add code to CreateExtourneAutoLine function.
    // HEI.12 Defect #4166 IBM NASTAA02 29.07.2019 # RTR006 | GL Mass upload template
    //   # "Document Date" should not be copied from "Posting Date"
    //   # Code added to function 'AnalyzeData'
    //   # New Text Constant created: Text50007 - Document Date
    // HEI.13 Defect #4246 IBM NASTAA02 05.08.2019 # RTR069 | Error while uploading payroll file in Batch Payroll , gen journal RtR
    //   # Code added to function 'AnalyzeData'
    //     # New Text Constant created: Text50008 - Comment

    //BC Upgrade KAPOOV01 26.05.2026 Added procedure SetInStream 

    CaptionML = ENU = 'Import Gen.Journal From Excel',
                NLD = 'Memoriaal vanuit Excel importeren';
    Permissions = TableData "Dimension Set Entry" = rimd;
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(GenJournalLine; "Gen. Journal Line")
        {

            trigger OnAfterGetRecord();
            begin
                RecNo := RecNo + 1;

                // Clear any entries in the temporary dimension set entry table
                COMMIT();
                DimSetEntryTmp.DELETEALL();
            end;

            trigger OnPostDataItem();
            begin
                //>>HEI.08 NAIKH01

                if ReversalOfAmounts then
                    CreateExtourneAutoLine();

                if (EntryNo > 0) and not ReversalOfAmounts then
                    MESSAGE(Text004, GenJournalLineRecG.TABLECAPTION, Counter1)
                else if (EntryNo > 0) and ReversalOfAmounts then
                    MESSAGE(Text0005, GenJournalLineRecG.TABLECAPTION, Counter1, Counter2);

                //>> // HEI.08
                /*  // HEI.08 Commented
                IF EntryNo > 0 THEN
                  MESSAGE(Text004,GenJournalLineRecG.TABLECAPTION,((EntryNo-StartEntryNo)/10000));
                */

            end;

            trigger OnPreDataItem();
            begin
                RecNo := 0;

                GenJournalTemplateRecG.SETRANGE(Name, ToGenJournalName);
                //IF NOT GenJournalTemplateRecG.FIND('-') THEN BEGIN
                if not GenJournalTemplateRecG.FINDFIRST() then begin
                    if not CONFIRM(
                      Text001, false, GenJournalTemplateRecG.TABLECAPTION, ToGenJournalName)
                    then
                        CurrReport.BREAK();
                    GenJournalTemplateRecG.Name := ToGenJournalName;
                    GenJournalTemplateRecG.INSERT();
                end;

                GenJournalBatchRecG.SETRANGE("Journal Template Name", GenJournalTemplateRecG.Name);
                GenJournalBatchRecG.SETRANGE(Name, ToGenBatch);
                if not GenJournalBatchRecG.FIND('-') then begin
                    if not CONFIRM(
                      Text001, false, GenJournalBatchRecG.TABLECAPTION, ToGenBatch)
                    then
                        CurrReport.BREAK();
                    GenJournalBatchRecG."Journal Template Name" := GenJournalTemplateRecG.Name;
                    GenJournalBatchRecG.Name := ToGenBatch;
                    GenJournalBatchRecG.INSERT();
                end;

                if GenJournalTemplateRecG.Recurring then begin
                    MESSAGE(Text002,
                      GenJournalTemplateRecG.TABLECAPTION, GenJournalTemplateRecG.Name);
                    CurrReport.BREAK();
                end;

                if not CONFIRM(Text003, false,
                  LOWERCASE(FORMAT(SELECTSTR(ImportOption + 1, Text027))),
                  GenJournalLineRecG.FIELDCAPTION("Journal Template Name"), ToGenJournalName) then
                    CurrReport.BREAK();

                if (ImportOption = ImportOption::"Replace entries") then begin
                    GenJournalLineRecG.SETRANGE("Journal Template Name", GenJournalTemplateRecG.Name);
                    GenJournalLineRecG.SETRANGE("Journal Batch Name", GenJournalBatchRecG.Name);
                    if not GenJournalLineRecG.ISEMPTY then
                        GenJournalLineRecG.DELETEALL(true);
                end else begin
                    GenJournalLineRecG.SETRANGE("Journal Template Name", GenJournalTemplateRecG.Name);
                    GenJournalLineRecG.SETRANGE("Journal Batch Name", GenJournalBatchRecG.Name);
                    if GenJournalLineRecG.FIND('+') then begin
                        //CLEAR(GenJournalLineRecG);
                        EntryNo := GenJournalLineRecG."Line No.";
                        StartEntryNo := GenJournalLineRecG."Line No.";
                    end else begin
                        EntryNo := 0;
                        StartEntryNo := 0;
                    end;
                end;

                /*
           //HEI.07
           IF EntryNo<> 0 THEN
             NewEntryNo := EntryNo;
           //HEI.07
                */

                AnalyzeData();

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Import From"; '')
                {
                    ApplicationArea = All;
                }
                field("WorkBook File Name"; FileName)
                {
                    CaptionML = ENU = 'Workbook File Name',
                                NLD = 'Werkmapbestandsnaam';
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        //BC Upgrade ADHIKG01>>
                        // FileName := FileMgt.UploadFile(Text006,ExcelFileExtensionTok);
                        File.UploadIntoStream(Text006, '', FromFilter, FileName, InStr);
                        //BC Upgrade ADHIKG01<<
                    end;
                }
                field("Worksheet Name"; SheetName)
                {
                    CaptionML = ENU = 'Worksheet Name',
                                NLD = 'Werkbladnaam';
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        //BC Upgrade ADHIKG01>>
                        //SheetName := ExcelBuf.SelectSheetsName(FileName);
                        SheetName := ExcelBuf.SelectSheetsNameStream(InStr);
                        //BC Upgrade ADHIKG01<<
                    end;
                }
                field("Import To"; '')
                {
                    ApplicationArea = All;
                }
                field("Gen. Journal Template Name"; ToGenJournalName)
                {
                    CaptionML = ENU = 'Gen. Journal Template Name',
                                NLD = 'Fin. dagboeksjabloon naam';
                    TableRelation = "Gen. Journal Template";
                    ApplicationArea = All;
                }
                field("Gen. Journal Batch Name"; ToGenBatch)
                {
                    CaptionML = ENU = 'Gen. Journal Batch Name',
                                NLD = 'Fin. dagboekbatch naam';
                    TableRelation = "Gen. Journal Batch".Name;
                    ApplicationArea = All;
                }
                field(Option; ImportOption)
                {
                    CaptionML = ENU = 'Option',
                                NLD = 'Optie';
                    OptionCaptionML = ENU = 'Replace entries,Add entries',
                                      NLD = 'Posten vervangen,Posten toevoegen';
                    ApplicationArea = All;
                }
                field(ReversalOfAmounts; ReversalOfAmounts)
                {
                    Caption = 'Reversal Of Amounts';
                    ApplicationArea = All;
                }
                field(ChangePostingDate; ChangePostingDate)
                {
                    Caption = 'Calculate new Posting Date (Date Formula)';
                    MultiLine = true;
                    ApplicationArea = All;
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

        ExcelBuf.DELETEALL();
    end;

    trigger OnPreReport();
    begin
        GLSetup.GET();
        if ToGenJournalName = '' then
            ERROR(STRSUBSTNO(Text000));

        if ToGenBatch = '' then
            ERROR(STRSUBSTNO(Text98150));

        if Dim.FIND('-') then begin
            repeat
                TempDim.INIT();
                TempDim := Dim;
                TempDim."Code Caption" := UPPERCASE(TempDim."Code Caption");
                TempDim.INSERT();
            until Dim.NEXT() = 0;
        end;
        if DimVal.FIND('-') then begin
            repeat
                TempDimVal.INIT();
                TempDimVal := DimVal;
                TempDimVal.INSERT();
            until DimVal.NEXT() = 0;
        end;

        if GLAcc.FIND('-') then begin
            repeat
                TempGLAcc.INIT();
                TempGLAcc := GLAcc;
                TempGLAcc.INSERT();
            until GLAcc.NEXT() = 0;
        end;

        ExcelBuf.LOCKTABLE();
        GenJournalLine.LOCKTABLE();

        GLSetup.GET();
        GlobalDim1Code := GLSetup."Global Dimension 1 Code";
        GlobalDim2Code := GLSetup."Global Dimension 2 Code";
        GlobalDim3Code := GLSetup."Shortcut Dimension 3 Code";
        GlobalDim4Code := GLSetup."Shortcut Dimension 4 Code";
        GlobalDim5Code := GLSetup."Shortcut Dimension 5 Code";
        GlobalDim6Code := GLSetup."Shortcut Dimension 6 Code";
        GlobalDim7Code := GLSetup."Shortcut Dimension 7 Code";
        GlobalDim8Code := GLSetup."Shortcut Dimension 8 Code";

        //<<HEI.03
        GlobalDimOPCOCode := GLSetup."OPCO Dimension Code FND";
        //GlobalDimOPCOCode := 'OPCO';
        //>>HEI.03

        GlobalDim9Code := GLSetup."Mass Upload Dimension 9 FND";
        GlobalDim10Code := GLSetup."Mass Upload Dimension 10 FND";
        GlobalDim11Code := GLSetup."Mass Upload Dimension 11 FND";
        GlobalDim12Code := GLSetup."Mass Upload Dimension 12 FND";
        GlobalDim13Code := GLSetup."Mass Upload Dimension 13 FND";
        GlobalDim14Code := GLSetup."Mass Upload Dimension 14 FND";
        GlobalDim15Code := GLSetup."Mass Upload Dimension 15 FND";
        GlobalDim16Code := GLSetup."Mass Upload Dimension 16 FND";
        GlobalDim17Code := GLSetup."Mass Upload Dimension 17 FND";
        GlobalDim18Code := GLSetup."Mass Upload Dimension 18 FND";
        GlobalDim19Code := GLSetup."Mass Upload Dimension 19 FND";
        GlobalDim20Code := GLSetup."Mass Upload Dimension 20 FND";
        GlobalDim21Code := GLSetup."Mass Upload Dimension 21 FND";
        GlobalDim22Code := GLSetup."Mass Upload Dimension 22 FND";
        GlobalDim23Code := GLSetup."Mass Upload Dimension 23 FND";
        GlobalDim24Code := GLSetup."Mass Upload Dimension 24 FND";
        GlobalDim25Code := GLSetup."Mass Upload Dimension 25 FND";
        GlobalDim26Code := GLSetup."Mass Upload Dimension 26 FND";
        GlobalDim27Code := GLSetup."Mass Upload Dimension 27 FND";
        GlobalDim28Code := GLSetup."Mass Upload Dimension 28 FND";
        GlobalDim29Code := GLSetup."Mass Upload Dimension 29 FND";
        GlobalDim30Code := GLSetup."Mass Upload Dimension 30 FND";

        DimSetEntryTmp.DELETEALL();
        ReadExcelSheet();
    end;

    var
        Text000: Label 'You must specify a Journal name to import to.';
        Text001: Label 'Do you want to create %1 %2.';
        Text002: Label '%1 %2 is recurring. You cannot import entries.';
        Text003: Label 'Are you sure you want to %1 for %2 %3.';
        Text004: Label '%1 table has been successfully updated with %2 entries.';
        Text005: Label '"Imported from Excel "';
        Text006: Label 'Import Excel File';
        Text007: Label 'Analyzing Data...';
        Text008: Label 'You cannot specify more than 8 dimensions in your Excel worksheet.';
        Text009: Label 'POSTING DATE';
        Text010: Label 'Account No.';
        Text011: Label 'The text Account No. can only be specified once in the Excel worksheet.';
        Text012: Label 'The dimensions specified by worksheet must be placed in the lines before the table.';
        Text013: Label '"Dimension "';
        Text014: Label 'Posting Date';
        Text015: Label 'CCCS Code';
        Text016: Label 'Opco Code';
        Text017: Label 'C-Chann Code';
        Text018: Label 'Mov_type Code';
        Text019: Label 'Brand code';
        Text020: Label 'Prim.Packtype Code';
        Text021: Label 'Person Code';
        Text022: Label 'Dimension 8';
        Text025: Label 'G/L Accounts have not been found in the Excel worksheet.';
        Text026: Label 'Dates have not been recognized in the Excel worksheet.';
        ExcelBuf: Record "Excel Buffer";
        Dim: Record Dimension;
        DimVal: Record "Dimension Value";
        TempDim: Record Dimension temporary;
        TempDimVal: Record "Dimension Value" temporary;
        JournalLineDimensionRecG: Record Dimension;
        GLAcc: Record "G/L Account";
        TempGLAcc: Record "G/L Account" temporary;
        GenJournalTemplateRecG: Record "Gen. Journal Template";
        GenJournalBatchRecG: Record "Gen. Journal Batch";
        GenJournalLineRecG: Record "Gen. Journal Line";
        FileName: Text[250];
        SheetName: Text[250];
        ToGenJournalName: Code[10];
        ToGenBatch: Code[10];
        EntryNo: Integer;
        StartEntryNo: Integer;
        DimCode: array[8] of Code[20];
        GlobalDim1Code: Code[20];
        GlobalDim2Code: Code[20];
        TotalRecNo: Integer;
        RecNo: Integer;
        Window: Dialog;
        GlobalDim3Code: Code[20];
        GlobalDim4Code: Code[20];
        GlobalDim5Code: Code[20];
        GlobalDim6Code: Code[20];
        GlobalDim7Code: Code[20];
        GlobalDim8Code: Code[20];
        ImportOption: Option "Replace entries","Add entries";
        Text027: Label 'Replace entries,Add entries';
        Text028: Label 'A filter has been used on the %1 when the budget was exported. When a filter on a dimension has been used, a column with the same dimension must be present in the worksheet imported. The column in the worksheet must specify the dimension value codes the program should use when importing the budget.';
        Text0005: Label '%1 table has been successfully updated with %2 entries and %3 reversed entries.';
        Text98150: Label 'You must specify a Batch name to import to.';
        Text98151: Label 'Document No.';
        Text98152: Label 'Description';
        Text98153: Label 'Business Unit';
        Text98154: Label 'Currency Code';
        Text98155: Label 'Amount';
        CommonDialogMgt: Codeunit "Common Dialog Management CBN";
        DimSetEntryTmp: Record "Dimension Set Entry" temporary;
        ExcelFileExtensionTok: Label '.xls*';
        DimAdded: Boolean;
        dimvalue: Record "Dimension Value";
        DimMgt: Codeunit DimensionManagement;
        ServerFileName: Text;
        GLSetup: Record "General Ledger Setup";
        FileMgt: Codeunit "File Management";
        GenJournalLineRecL: Record "Gen. Journal Line";
        intRecords: Integer;
        ExcelCelLen: Integer;
        Text029: Label 'L_STAFFCAT';
        Text030: Label 'Pack size code';
        Text031: Label 'Write-off';
        Text032: Label 'Trans.Equip Code';
        ReversalOfAmounts: Boolean;
        ChangePostingDate: DateFormula;
        GlobalDim9Code: Code[20];
        GlobalDim10Code: Code[20];
        GlobalDim11Code: Code[20];
        GlobalDim12Code: Code[20];
        GlobalDim13Code: Code[20];
        GlobalDim14Code: Code[20];
        GlobalDim15Code: Code[20];
        GlobalDim16Code: Code[20];
        GlobalDim17Code: Code[20];
        GlobalDim18Code: Code[20];
        GlobalDim19Code: Code[20];
        GlobalDim20Code: Code[20];
        GlobalDim21Code: Code[20];
        GlobalDim22Code: Code[20];
        GlobalDim23Code: Code[20];
        GlobalDim24Code: Code[20];
        GlobalDim25Code: Code[20];
        GlobalDim26Code: Code[20];
        GlobalDim27Code: Code[20];
        GlobalDim28Code: Code[20];
        GlobalDim29Code: Code[20];
        GlobalDim30Code: Code[20];
        Dim9: Label 'Dimension 9';
        Dim10: Label 'Dimension 10';
        Dim11: Label 'Dimension 11';
        Dim12: Label 'Dimension 12';
        Dim13: Label 'Dimension 13';
        Dim14: Label 'Dimension 14';
        Dim15: Label 'Dimension 15';
        Dim16: Label 'Dimension 16';
        Dim17: Label 'Dimension 17';
        Dim18: Label 'Dimension 18';
        Dim19: Label 'Dimension 19';
        Dim20: Label 'Dimension 20';
        Dim21: Label 'Dimension 21';
        Dim22: Label 'Dimension 22';
        Dim23: Label 'Dimension 23';
        Dim24: Label 'Dimension 24';
        Dim25: Label 'Dimension 25';
        Dim26: Label 'Dimension 26';
        Dim27: Label 'Dimension 27';
        Dim28: Label 'Dimension 28';
        Dim29: Label 'Dimension 29';
        Dim30: Label 'Dimension 30';
        Text50000: Label 'External Document No.';
        Text50001: Label 'OPCO';
        GlobalDimOPCOCode: Code[20];
        DocumentNo: Code[20];
        SourceCode: Code[20];
        "--HEI DEFCT 934--": Integer;
        Reversal_Date: Text;
        H_OldRowNo: Integer;
        NewEntryNo: Integer;
        NewGenJnlLine: Record "Gen. Journal Line";
        NewDocNo: Code[20];
        LastDocNo: Code[20];
        LstLnNo: Integer;
        Counter2: Integer;
        ExtDateFormula: DateFormula;
        Counter1: Integer;
        Text50002: Label 'VAT Bus. Posting Group';
        Text50003: Label 'VAT Prod. Posting Group';
        Text50004: Label 'Gen. Bus. Posting Group';
        Text50005: Label 'Gen. Prod. Posting Group';
        Text50006: Label 'Gen. Posting Type';
        GenPostingType: Text;
        Text50007: Label 'Document Date';
        Text50008: Label 'Comment';

        //BC Upgrade ADHIKG01>>
        InStr: InStream;
        FromFilter: Label 'Excel File (*.xlsx)|*.xlsx';
    //BC Upgrade ADHIKG01<<

    procedure ReadExcelSheet();
    begin
        //BC Upgrade ADHIKG01>>
        //ExcelBuf.OpenBook(FileName,SheetName);
        ExcelBuf.OpenBookStream(InStr, SheetName);
        //BC Upgrade ADHIKG01<<
        ExcelBuf.ReadSheet();
    end;

    procedure AnalyzeData();
    var
        TempExcelBuf: Record "Excel Buffer" temporary;
        RegelExcelBuf: Record "Excel Buffer";
        TempGenJournalLineRecL: Record "Gen. Journal Line" temporary;
        HeaderExcelBuffer: Record "Excel Buffer";
        HeaderRowNo: Integer;
        CountDim: Integer;
        TestDate: Date;
        OldRowNo: Integer;
        DimRowNo: Integer;
        DimCode3: Code[20];
        GLSetup: Record "General Ledger Setup";
        GenSetup: Record "General Ledger Setup";
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        //NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade SHUKLP03 << Blocked because it is removed.
        NoSeriesMgt: Codeunit "No. Series";// BC Upgrade SHUKLP03 << 
    begin
        Window.OPEN(
          Text007 +
          '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.UPDATE(1, 0);
        TotalRecNo := ExcelBuf.COUNT;
        RecNo := 0;
        CountDim := 0;
        TempGenJournalLineRecL.DELETEALL();
        DimAdded := false;

        Counter1 := 0;  //<< HEI.08 NAIKH01

        //<<HEI.02 FDD-RTRGAP043
        ExcelBuf.RESET();
        if ExcelBuf.GET(9, 2) then begin
            if UPPERCASE(ExcelBuf."Cell Value as Text") = UPPERCASE(Text009) then begin
                ExcelBuf."Cell Value as Text" := 'P. date';
                ExcelBuf.MODIFY();
            end;
        end;
        ExcelBuf.RESET();
        //>>HEI.02 FDD-RTRGAP043

        /*
        //HEI.07
        IF ExcelBuf.GET(12,9) THEN
          Reversal_Date := FORMAT(ExcelBuf."Cell Value as Text");
        //HEI.07
        */

        if ExcelBuf.FIND('-') then begin
            repeat
                RecNo := RecNo + 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                TempDim.SETRANGE("Code Caption", COPYSTR(UPPERCASE(FormatData(ExcelBuf."Cell Value as Text")), 1,
                                 MAXSTRLEN(TempDim."Code Caption")));
                case true of
                    (STRPOS(UPPERCASE(ExcelBuf."Cell Value as Text"), Text009) <> 0):
                        begin
                            if HeaderRowNo = 0 then begin
                                HeaderRowNo := ExcelBuf."Row No.";
                                TempExcelBuf := ExcelBuf;
                                TempExcelBuf.Comment := ExcelBuf."Cell Value as Text";
                                TempExcelBuf.INSERT();
                            end else
                                ERROR(Text011);
                        end;

                    TempDim.FINDFIRST() and (ExcelBuf."Row No." <> HeaderRowNo):
                        begin
                            if HeaderRowNo <> 0 then
                                ERROR(Text012)
                            else begin
                                TempDim.MARK(true);
                                DimRowNo := ExcelBuf."Row No.";
                                DimCode3 := TempDim.Code;
                            end;
                        end;

                    ExcelBuf."Row No." = HeaderRowNo:
                        begin
                            TempExcelBuf := ExcelBuf;
                            case true of
                                not TempDim.FIND('-'):
                                    begin
                                        TempExcelBuf.Comment := ExcelBuf."Cell Value as Text";
                                        TempExcelBuf.INSERT();
                                    end;
                                TempDim.FIND('-'):
                                    begin
                                        if (TempDim.Code = GLSetup."Shortcut Dimension 1 Code") or
                                          (TempDim.Code = GLSetup."Shortcut Dimension 2 Code") or
                                          (TempDim.Code = GLSetup."Shortcut Dimension 3 Code") or
                                          (TempDim.Code = GLSetup."Shortcut Dimension 4 Code") or
                                          (TempDim.Code = GLSetup."Shortcut Dimension 5 Code") or
                                          (TempDim.Code = GLSetup."Shortcut Dimension 6 Code") or
                                          (TempDim.Code = GLSetup."Shortcut Dimension 7 Code") or
                                          (TempDim.Code = GLSetup."Shortcut Dimension 8 Code") then begin
                                            TempDim.MARK(false);
                                            CountDim := CountDim + 1;
                                            if (CountDim > 8) then
                                                ERROR(Text008);
                                            TempExcelBuf.Comment := Text013 + FORMAT(CountDim);
                                            TempExcelBuf.INSERT();
                                            DimCode[CountDim] := TempDim.Code;
                                        end else begin
                                            TempExcelBuf.Comment := ExcelBuf."Cell Value as Text";
                                            TempExcelBuf.INSERT();
                                        end;
                                    end;
                            end;
                        end;

                    (ExcelBuf."Row No." > HeaderRowNo) and (HeaderRowNo > 0):
                        begin

                            if ExcelBuf."Row No." <> OldRowNo then begin
                                OldRowNo := ExcelBuf."Row No.";
                                CLEAR(TempGenJournalLineRecL);
                                EntryNo := EntryNo + 10000;

                                Counter1 := Counter1 + 1;  // // HEI.08 NAIKH01

                                RegelExcelBuf.RESET();
                                RegelExcelBuf.SETRANGE("Row No.", ExcelBuf."Row No.");
                                GenJournalLineRecL.INIT();


                                /* GenJournalLineRecL.SETRANGE("Journal Template Name",ToGenJournalName);
                                 GenJournalLineRecL.SETRANGE("Journal Batch Name",ToGenBatch);
                                 IF NOT GenJournalLineRecL.ISEMPTY THEN
                                   GenJournalLineRecL.DELETEALL(TRUE);    */


                                if RegelExcelBuf.FIND('-') then begin
                                    repeat
                                        if TempExcelBuf.GET(HeaderRowNo, RegelExcelBuf."Column No.") then begin
                                            RegelExcelBuf.Comment := TempExcelBuf.Comment;
                                            RegelExcelBuf.MODIFY();
                                        end;
                                        if not GenJournalLineRecL.GET(ToGenJournalName, ToGenBatch, EntryNo) then begin
                                            GenJournalLineRecL.INIT();
                                            GenJournalLineRecL."Journal Template Name" := ToGenJournalName;
                                            GenJournalLineRecL."Journal Batch Name" := ToGenBatch;
                                            GenJournalLineRecL."Line No." := EntryNo;
                                            //HEI.06>>
                                            GenJnlTemplate.GET(ToGenJournalName);
                                            GenJournalLineRecL."Source Code" := GenJnlTemplate."Source Code";
                                            //HEI.06<<
                                            GenJournalLineRecL.INSERT();
                                        end;

                                        case RegelExcelBuf.Comment of
                                            Text014:
                                                begin
                                                    EVALUATE(GenJournalLineRecL."Posting Date", RegelExcelBuf."Cell Value as Text");
                                                    //<<HEI.01 FDD-RTRGAP043
                                                    // IF FORMAT(ChangePostingDate) <> '' THEN  //HEI.08 NAIKH01
                                                    //  GenJournalLineRecL."Posting Date" := CALCDATE(ChangePostingDate,GenJournalLineRecL."Posting Date"); //HEI.08 NAIKH01
                                                    //>>HEI.01 FDD-RTRGAP043
                                                    //HEI.12 GenJournalLineRecL."Document Date" :=  GenJournalLineRecL."Posting Date";//Issue:3 - Haiti
                                                    /*  // HEI.08 NAIKH01
                                                    IF DocumentNo = '' THEN BEGIN
                                                      GenJnlTemplate.GET(GenJournalLineRecL."Journal Template Name");
                                                      GenJnlBatch.GET(GenJournalLineRecL."Journal Template Name",GenJournalLineRecL."Journal Batch Name");
                                                      GenJnlBatch.TESTFIELD("No. Series");
                                                      IF GenJnlBatch."No. Series" <> '' THEN BEGIN
                                                        CLEAR(NoSeriesMgt);
                                                          NoSeriesMgt.InitSeries(GenJnlBatch."No. Series",'',0D,DocumentNo,GenJnlBatch."No. Series");
                                                      END;
                                                      SourceCode := GenJnlTemplate."Source Code";
                                                    END;
                                                    */
                                                    //>>HEI.08
                                                    if DocumentNo = '' then
                                                        DocumentNo := GetDocNo(ToGenJournalName, ToGenBatch);

                                                    GenJnlTemplate.GET(GenJournalLineRecL."Journal Template Name");
                                                    //HEI.08

                                                    GenJournalLineRecL.VALIDATE("Document No.", DocumentNo);
                                                    GenJournalLineRecL."Source Code" := GenJnlTemplate."Source Code"; // 934 NAIKh01 SourceCode;
                                                    GenJournalLineRecL.MODIFY();
                                                end;
                                            Text98151:
                                                begin
                                                    if DocumentNo = '' then begin
                                                        GenJournalLineRecL."Document No." :=
                                                         COPYSTR(
                                                           RegelExcelBuf."Cell Value as Text",
                                                           1, MAXSTRLEN(TempGenJournalLineRecL."Document No."));

                                                        GenJournalLineRecL.MODIFY();
                                                    end;
                                                    /* GenJournalLineRecL."Document No." :=
                                                       COPYSTR(
                                                         RegelExcelBuf."Cell Value as Text",
                                                         1,MAXSTRLEN(TempGenJournalLineRecL."Document No."));*/
                                                    //SOICAD01
                                                    //IF GenJournalLineRecL."Document No." = '' THEN BEGIN
                                                    /*
                                                      GenJnlTemplate.GET(GenJournalLineRecL."Journal Template Name");
                                                      GenJnlBatch.GET(GenJournalLineRecL."Journal Template Name",GenJournalLineRecL."Journal Batch Name");
                                                      GenJnlBatch.TESTFIELD("No. Series");
                                                      IF GenJnlBatch."No. Series" <> '' THEN BEGIN
                                                        CLEAR(NoSeriesMgt);
                                                         NoSeriesMgt.InitSeries(GenJnlBatch."No. Series",'',0D,GenJournalLineRecL."Document No.",GenJnlBatch."No. Series");
                                                      END;*/
                                                    //END;
                                                    //
                                                    // GenJournalLineRecL.MODIFY;
                                                end;
                                            //<<HEI.02 FDD-RTRGAP043
                                            Text50000:
                                                begin
                                                    GenJournalLineRecL."External Document No." :=
                                                      COPYSTR(
                                                        RegelExcelBuf."Cell Value as Text",
                                                        1, MAXSTRLEN(TempGenJournalLineRecL."External Document No."));
                                                    GenJournalLineRecL.MODIFY();
                                                end;
                                            //>>HEI.02 FDD-RTRGAP043
                                            Text010:
                                                begin
                                                    RegelExcelBuf."Cell Value as Text" := DELCHR(RegelExcelBuf."Cell Value as Text", '=', '.');
                                                    //HEI:495159:1:1>>
                                                    RegelExcelBuf."Cell Value as Text" := DELCHR(RegelExcelBuf."Cell Value as Text", '=', ',');
                                                    //HEI:495159:1:1<<
                                                    TempGLAcc.SETRANGE(
                                                      "No.",
                                                      COPYSTR(
                                                        RegelExcelBuf."Cell Value as Text",
                                                        1, MAXSTRLEN(TempGenJournalLineRecL."Account No.")));
                                                    if TempGLAcc.FIND('-') then// BEGIN
                                                        GenJournalLineRecL."Account No." := RegelExcelBuf."Cell Value as Text"
                                                    else
                                                        GenJournalLineRecL."Account No." := '';
                                                    GenJournalLineRecL.MODIFY();
                                                end;
                                            Text98152:
                                                begin
                                                    GenJournalLineRecL.Description :=
                                                      COPYSTR(
                                                        RegelExcelBuf."Cell Value as Text",
                                                        1, MAXSTRLEN(GenJournalLineRecL.Description));
                                                    GenJournalLineRecL.MODIFY();
                                                end;
                                            Text98153:
                                                begin
                                                    GenJournalLineRecL."Business Unit Code" :=
                                                      COPYSTR(
                                                        RegelExcelBuf."Cell Value as Text",
                                                        1, MAXSTRLEN(GenJournalLineRecL."Business Unit Code"));
                                                    GenJournalLineRecL.MODIFY();
                                                end;
                                            Text98154:
                                                begin
                                                    GenJournalLineRecL."Currency Code" :=
                                                      COPYSTR(
                                                        RegelExcelBuf."Cell Value as Text",
                                                        1, MAXSTRLEN(GenJournalLineRecL."Currency Code"));
                                                    GenJournalLineRecL.VALIDATE("Currency Code");
                                                    GenJournalLineRecL.MODIFY();
                                                end;
                                            Text98155:
                                                begin
                                                    EVALUATE(GenJournalLineRecL.Amount, RegelExcelBuf."Cell Value as Text");
                                                    //<<HEI.01 FDD-RTRGAP043
                                                    //  IF ReversalOfAmounts THEN  //HEI.07
                                                    // GenJournalLineRecL.Amount := -GenJournalLineRecL.Amount; //HEI.07
                                                    //>>HEI.01 FDD-RTRGAP043
                                                    GenJournalLineRecL.VALIDATE(Amount);
                                                    GenJournalLineRecL.MODIFY();
                                                end;
                                            /*
                                            Text015:
                                              BEGIN
                                                GenJournalLineRecL.VALIDATE("Shortcut Dimension 1 Code",DELCHR(COPYSTR(
                                                    RegelExcelBuf."Cell Value as Text",
                                                    1,MAXSTRLEN(GenJournalLineRecL."Shortcut Dimension 1 Code")),'=','.'));//Issue:23 - add validate
                                                GenJournalLineRecL.MODIFY;
                                              END;
                                            */
                                            //Issue:23>>

                                            //<<********

                                            Text015:
                                                begin
                                                    GenJournalLineRecL."Shortcut Dimension 1 Code" := DELCHR(COPYSTR(
                                                        RegelExcelBuf."Cell Value as Text",
                                                        1, MAXSTRLEN(GenJournalLineRecL."Shortcut Dimension 1 Code")), '=', '.');


                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin

                                                        DimSetEntryTmp.VALIDATE("Dimension Code", 'CCCS');
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", GenJournalLineRecL."Shortcut Dimension 1 Code");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;
                                            //Issue:23<<
                                            Text016:
                                                begin
                                                    GenJournalLineRecL.VALIDATE("Shortcut Dimension 2 Code",
                                                        DELCHR(COPYSTR(
                                                          RegelExcelBuf."Cell Value as Text",
                                                          1, MAXSTRLEN(GenJournalLineRecL."Shortcut Dimension 2 Code")), '=', '.')); //Issue:23 - add validate
                                                    GenJournalLineRecL.MODIFY();

                                                end;

                                            Text017:
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", 'C_CHANNEL');
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");

                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;

                                                    //GenJournalLineRecL."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);Issue:23
                                                    // GenJournalLineRecL.MODIFY(TRUE);Issue:23

                                                end;

                                            Text018:
                                                begin

                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin

                                                        DimSetEntryTmp.VALIDATE("Dimension Code", 'MOV_TYPE');

                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                        //GenJournalLineRecL."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);Issue:23
                                                        // GenJournalLineRecL.MODIFY(TRUE);Issue:23

                                                    end;
                                                end;

                                            Text019:

                                                begin

                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin

                                                        DimSetEntryTmp.VALIDATE("Dimension Code", 'I_2 BRAND');
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");

                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                    //GenJournalLineRecL."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);  Issue:23
                                                    //GenJournalLineRecL.MODIFY(TRUE); Issue:23

                                                end;

                                            Text020:
                                                begin

                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin

                                                        DimSetEntryTmp.VALIDATE("Dimension Code", 'I_3 PRIM.PACKTYPE');
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;

                                                    //GenJournalLineRecL."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);Issue:23
                                                    //GenJournalLineRecL.MODIFY(TRUE);  Issue:23

                                                end;

                                            Text021:
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin

                                                        DimSetEntryTmp.VALIDATE("Dimension Code", 'L_Person');
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                    // GenJournalLineRecL."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);Issue:23
                                                    // GenJournalLineRecL.MODIFY(TRUE); Issue:23

                                                end;
                                            //Issue:23>>
                                            Text029:
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", 'L_STAFFCAT');
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;
                                            Text030:
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", 'I_4 PACK SIZE');
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;
                                            Text031:
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", 'L_WO');
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;
                                            Text032:
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", 'L_TRANSEQP');
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;
                                            //>>****************
                                            //>>HEI.09
                                            Text50002:
                                                begin
                                                    GenJournalLineRecL."VAT Bus. Posting Group" :=
                                                      COPYSTR(
                                                        RegelExcelBuf."Cell Value as Text",
                                                        1, MAXSTRLEN(TempGenJournalLineRecL."VAT Bus. Posting Group"));
                                                    GenJournalLineRecL.MODIFY();
                                                end;
                                            Text50003:
                                                begin
                                                    GenJournalLineRecL."VAT Prod. Posting Group" :=
                                                      COPYSTR(
                                                        RegelExcelBuf."Cell Value as Text",
                                                        1, MAXSTRLEN(TempGenJournalLineRecL."VAT Prod. Posting Group"));
                                                    GenJournalLineRecL.VALIDATE("VAT Prod. Posting Group");
                                                    GenJournalLineRecL.MODIFY();
                                                end;

                                            //<<HEI.10
                                            Text50006:
                                                begin
                                                    GenPostingType := RegelExcelBuf."Cell Value as Text";
                                                    if GenPostingType = 'Purchase' then
                                                        GenJournalLineRecL."Gen. Posting Type" := GenJournalLineRecL."Gen. Posting Type"::Purchase;
                                                    if GenPostingType = 'Sale' then
                                                        GenJournalLineRecL."Gen. Posting Type" := GenJournalLineRecL."Gen. Posting Type"::Sale;
                                                    if GenPostingType = 'Settlement' then
                                                        GenJournalLineRecL."Gen. Posting Type" := GenJournalLineRecL."Gen. Posting Type"::Settlement;
                                                    GenJournalLineRecL.VALIDATE("Gen. Posting Type");
                                                    GenJournalLineRecL.MODIFY();
                                                end;
                                            //>>HEI.10

                                            Text50004:
                                                begin
                                                    GenJournalLineRecL."Gen. Bus. Posting Group" :=
                                                      COPYSTR(
                                                        RegelExcelBuf."Cell Value as Text",
                                                        1, MAXSTRLEN(TempGenJournalLineRecL."Gen. Bus. Posting Group"));
                                                    GenJournalLineRecL.VALIDATE("Gen. Bus. Posting Group");
                                                    GenJournalLineRecL.MODIFY();
                                                end;
                                            Text50005:
                                                begin
                                                    GenJournalLineRecL."Gen. Prod. Posting Group" :=
                                                      COPYSTR(
                                                        RegelExcelBuf."Cell Value as Text",
                                                        1, MAXSTRLEN(TempGenJournalLineRecL."Gen. Prod. Posting Group"));
                                                    GenJournalLineRecL.VALIDATE("Gen. Prod. Posting Group");
                                                    GenJournalLineRecL.MODIFY();
                                                end;
                                            //<<HEI.09

                                            //HEI.12>>
                                            Text50007:
                                                begin
                                                    EVALUATE(GenJournalLineRecL."Document Date", RegelExcelBuf."Cell Value as Text");
                                                    GenJournalLineRecL.MODIFY();
                                                end;
                                            //HEI.12<<

                                            //HEI.13>>
                                            Text50008:
                                                begin
                                                    EVALUATE(GenJournalLineRecL.Comment, RegelExcelBuf."Cell Value as Text");
                                                    GenJournalLineRecL.MODIFY();
                                                end;
                                            //HEI.13<<

                                            GlobalDim1Code:
                                                begin
                                                    GenJournalLineRecL."Shortcut Dimension 1 Code" := DELCHR(COPYSTR(
                                                        RegelExcelBuf."Cell Value as Text",
                                                        1, MAXSTRLEN(GenJournalLineRecL."Shortcut Dimension 1 Code")), '=', '.');
                                                    GenJournalLineRecL.MODIFY();

                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin

                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim1Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", GenJournalLineRecL."Shortcut Dimension 1 Code");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            GlobalDim2Code:
                                                begin
                                                    GenJournalLineRecL.VALIDATE("Shortcut Dimension 2 Code",
                                                      DELCHR(COPYSTR(
                                                        RegelExcelBuf."Cell Value as Text",
                                                        1, MAXSTRLEN(GenJournalLineRecL."Shortcut Dimension 2 Code")), '=', '.'));
                                                    GenJournalLineRecL.MODIFY();

                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin

                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim2Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", GenJournalLineRecL."Shortcut Dimension 2 Code");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            GlobalDim3Code:
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim3Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            GlobalDim4Code:
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim4Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            GlobalDim5Code:
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim5Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            GlobalDim6Code:
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim6Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;


                                            GlobalDim7Code:
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim7Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;


                                            GlobalDim8Code:
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim8Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            //GlobalDimOPCOCode:
                                            'OPCO':
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    //IF ExcelCelLen > 1 THEN BEGIN
                                                    DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDimOPCOCode);
                                                    DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                    if DimSetEntryTmp.INSERT(true) then;
                                                    DimAdded := true;
                                                    //END;
                                                end;
                                            //>>HEI.03

                                            //<<HEI.03
                                            GlobalDim9Code:
                                                //Dim9:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim9Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim10Code:
                                                //Dim10:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim10Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim11Code:
                                                //Dim11:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim11Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim12Code:
                                                //Dim12:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim12Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim13Code:
                                                //Dim13:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim13Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim14Code:
                                                //Dim14:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim14Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim15Code:
                                                //Dim15:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim15Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim16Code:
                                                //>>HEI.03
                                                //Dim16:
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim16Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim17Code:
                                                //Dim17:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim17Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim18Code:
                                                //Dim18:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim18Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim19Code:
                                                //Dim19:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim19Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim20Code:
                                                //Dim20:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim20Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim21Code:
                                                //Dim21:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim21Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim22Code:
                                                //Dim22:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim22Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim23Code:
                                                //Dim23:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim23Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim24Code:
                                                //Dim24:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim24Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim25Code:
                                                //Dim25:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim25Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim26Code:
                                                //Dim26:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim26Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim27Code:
                                                //Dim27:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim27Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim28Code:
                                                //Dim28:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim28Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim29Code:
                                                //Dim29:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim29Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;

                                            //<<HEI.03
                                            GlobalDim30Code:
                                                //Dim30:
                                                //>>HEI.03
                                                begin
                                                    ExcelCelLen := STRLEN(RegelExcelBuf."Cell Value as Text");
                                                    if ExcelCelLen > 1 then begin
                                                        DimSetEntryTmp.VALIDATE("Dimension Code", GlobalDim30Code);
                                                        DimSetEntryTmp.VALIDATE("Dimension Value Code", RegelExcelBuf."Cell Value as Text");
                                                        if DimSetEntryTmp.INSERT(true) then;
                                                        DimAdded := true;
                                                    end;
                                                end;
                                        //>>HEI.01 FDD-RTRGAP043


                                        //Issue:23<<
                                        end;

                                        //Issue:23>>
                                        if DimAdded then begin
                                            GenJournalLineRecL."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);
                                            GenJournalLineRecL.MODIFY(true);
                                        end;
                                    //Issue:23<<

                                    until RegelExcelBuf.NEXT() = 0;
                                end;
                            end;
                        end;
                end;
                DimSetEntryTmp.DELETEALL();
            /*IF DimAdded THEN
               BEGIN
                 //IF  GenJournalLineRecL.FINDSET then REPEAT
                   GenJournalLineRecL.INIT;
                   testdimensionsetid := DimMgt.GetDimensionSetID(DimSetEntryTmp);
                   GenJournalLineRecL."Dimension Set ID" := testdimensionsetid;
                   GenJournalLineRecL.MODIFY(TRUE);
               END; */

            /*
            //<< HEI.07
               IF ExcelBuf."Row No." <> H_OldRowNo THEN BEGIN
                  H_OldRowNo := ExcelBuf."Row No.";
                  IF (EntryNo <> 0) AND (NewEntryNo <> EntryNo) AND ReversalOfAmounts THEN BEGIN
                      GenJournalLineRecL.GET(ToGenJournalName,ToGenBatch,EntryNo);

                      EntryNo:= EntryNo+10000;
                      NewEntryNo := EntryNo;

                      NewGenJnlLine.INIT;
                      NewGenJnlLine.TRANSFERFIELDS(GenJournalLineRecL);
                      NewGenJnlLine."Line No." := EntryNo;
                      IF Reversal_Date <> '' THEN
                        EVALUATE(NewGenJnlLine."Posting Date",Reversal_Date)
                      ELSE
                        NewGenJnlLine."Posting Date" :=  GenJournalLineRecL."Posting Date";
                      NewGenJnlLine.Description := GenJournalLineRecL.Description;
                      NewGenJnlLine.VALIDATE("Currency Code",GenJournalLineRecL."Currency Code");
                      NewGenJnlLine."Amount (LCY)" := GenJournalLineRecL."Amount (LCY)";
                      NewGenJnlLine."Currency Factor" := GenJournalLineRecL."Currency Factor";
                      NewGenJnlLine.VALIDATE("Document No.",GenJournalLineRecL."Document No.");
                      NewGenJnlLine."Account Type" := GenJournalLineRecL."Account Type";
                      NewGenJnlLine."Account No." := GenJournalLineRecL."Account No.";
                      NewGenJnlLine.VALIDATE(Amount,-GenJournalLineRecL.Amount);
                      NewGenJnlLine."Source Code" := GenJournalLineRecL."Source Code";
                      NewGenJnlLine."Document Date":= GenJournalLineRecL."Document Date";
                      NewGenJnlLine."External Document No." := GenJournalLineRecL."External Document No.";

                      NewGenJnlLine.INSERT;
                  END;
              END;
            //>> HEI.07

            */


            until ExcelBuf.NEXT() = 0;
        end;


        intRecords += 1;

        Window.CLOSE();

        //>>HEI.08 NAIKH01

        LastDocNo := GenJournalLineRecL."Document No.";
        LstLnNo := GenJournalLineRecL."Line No.";
        //>>HEI.08


        TempExcelBuf.RESET();
        TempExcelBuf.SETRANGE(Comment, Text010);
        if not TempExcelBuf.FIND('-') then
            ERROR(Text025);
        TempExcelBuf.SETRANGE(Comment, Text014);
        if not TempExcelBuf.FIND('-') then
            ERROR(Text026);

    end;

    procedure FormatData(TextToFormat: Text[250]): Text[250];
    var
        FormatInteger: Integer;
        FormatDecimal: Decimal;
        FormatDate: Code[10];
    begin
        case true of
            EVALUATE(FormatInteger, TextToFormat):
                exit(FORMAT(FormatInteger));
            EVALUATE(FormatDecimal, TextToFormat):
                exit(FORMAT(FormatDecimal));
            EVALUATE(FormatDate, TextToFormat):
                exit(FORMAT(FormatDate));
            else
                exit(TextToFormat);
        end;
    end;

    procedure SetGenJournal(NewToGenJournalName: Code[10]; NewToGenBatch: Code[20]);
    begin
        ToGenJournalName := NewToGenJournalName;
        ToGenBatch := NewToGenBatch;
    end;

    procedure CreateExtourneAutoLine();
    var
        GenJnlExtLine: Record "Gen. Journal Line";
        NewLineNo: Integer;
        GenJnlLine2: Record "Gen. Journal Line";
    begin

        // HEI.08
        //NewDocNo := INCSTR(LastDocNo);  // HEI.09 For Reversal Amt line created should have the same "Document No."
        Counter2 := 0;
        NewLineNo := LstLnNo + 10000;

        GenJnlLine2.RESET();
        GenJnlLine2.SETRANGE("Journal Template Name", ToGenJournalName);
        GenJnlLine2.SETRANGE("Journal Batch Name", ToGenBatch);
        if (ImportOption = ImportOption::"Add entries") then
            GenJnlLine2.SETRANGE("Line No.", StartEntryNo + 10000, LstLnNo)
        else
            GenJnlLine2.SETRANGE("Line No.", 0, LstLnNo);

        if GenJnlLine2.FINDSET() then
            repeat
                GenJnlExtLine.COPY(GenJnlLine2);
                if FORMAT(ChangePostingDate) <> '' then
                    GenJnlExtLine."Posting Date" := CALCDATE(ChangePostingDate, GenJnlExtLine."Posting Date");
                GenJnlExtLine.VALIDATE("Posting Date", CALCDATE(ExtDateFormula, GenJnlExtLine."Posting Date"));
                if GenJnlLine2."Credit Amount" <> 0 then
                    GenJnlExtLine.VALIDATE("Debit Amount", GenJnlLine2."Credit Amount");
                if GenJnlLine2."Debit Amount" <> 0 then
                    GenJnlExtLine.VALIDATE("Credit Amount", GenJnlLine2."Debit Amount");
                GenJnlExtLine."Line No." := NewLineNo;

                //GenJnlExtLine."Document No." := NewDocNo; // HEI.09 Defect 934
                if Counter2 mod 2 = 0 then
                    NewLineNo += 10000;
                GenJnlExtLine.INSERT();
                Counter2 += 2; //HEI.11
                               //Counter2 += 1; // // HEI.08
            until GenJnlLine2.NEXT() = 0;
        // HEI.08
    end;

    procedure GetDocNo(_JournalTemplate: Code[20]; _JournalBatch: Code[20]): Code[20];
    var
        NoSeriesMgt: Codeunit "No. Series";
        GenJnlBatch: Record "Gen. Journal Batch";
        BatchPostingNoSeries: Code[20];
        _DocNo: Code[20];
    begin
        // HEI.08
        GenJnlBatch.RESET();
        GenJnlBatch.SETFILTER(GenJnlBatch."Journal Template Name", _JournalTemplate);
        GenJnlBatch.SETFILTER(GenJnlBatch.Name, _JournalBatch);
        if (GenJnlBatch.FINDFIRST()) then begin
            if (GenJnlBatch."Posting No. Series" <> '') then
                BatchPostingNoSeries := GenJnlBatch."Posting No. Series"
            else if (GenJnlBatch."No. Series" <> '') then
                BatchPostingNoSeries := GenJnlBatch."No. Series"
            else if (GenJnlBatch."Posting No. Series" = '') and (GenJnlBatch."No. Series" = '') then
                _DocNo := '';  //HEI.09
            //ERROR(Text030, JournalBatchName,JournalTemplateName); // HEI.08 NAIKH01
            // ERROR(Text030, ToGenBatch,ToGenJournalName);  // HEI.09 No error should be shown when the No. series is Blank.
            if (GenJnlBatch."Posting No. Series" <> '') or (GenJnlBatch."No. Series" <> '') then  // HEI.09
                                                                                                  // _DocNo := NoSeriesMgt.TryGetNextNo(BatchPostingNoSeries, GenJournalLineRecL."Posting Date"); // BC Upgrade SHUKLP03 << Updated procedure.
                _DocNo := NoSeriesMgt.PeekNextNo(BatchPostingNoSeries, GenJournalLineRecL."Posting Date");  // BC Upgrade SHUKLP03 << Updated procedure.
            if (GenJnlBatch."Posting No. Series" <> '') and (GenJnlBatch."No. Series" = '') then
                GenJournalLineRecL."Posting No. Series" := BatchPostingNoSeries;
            exit(_DocNo);
        end else
            exit('');
        // HEI.08
    end;
    //BC Upgrade KAPOOV01 Added procedure SetInStream >>
    procedure SetInStream(NewInStr: InStream)
    begin
        InStr := NewInStr;
    end;
    //BC Upgrade KAPOOV01 Added procedure SetInStream <<
}

