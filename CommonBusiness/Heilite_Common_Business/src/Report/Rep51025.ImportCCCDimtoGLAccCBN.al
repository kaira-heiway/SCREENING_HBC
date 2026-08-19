report 51025 "Import CCC Dim to GL Acc CBN"
{
    // version HEI.01

    // INC2141858 IBM ISYED01 06-14-2019
    // # CREATED NEW REPORT TO UPDATE DIMENSIONS TO GL ENTRY
    // BC Upgrade BHARDA11 >>
    // 1. Change Filename logic filemanagement to file.UploadIntoStream.
    // 2. Change sheetname logic using instram SelectSheetsNameStream.
    // 3. Change Openbook to OpenBookStream.
    // 4. Add applicationArea Property to report and requestpage fields.
    // BC Upgrade BHARAD11 <<
    Permissions = TableData "G/L Entry" = rimd;
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
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
                    ApplicationArea = All;
                    CaptionML = ENU = 'Workbook File Name',
                                NLD = 'Werkmapbestandsnaam';
                    ToolTip = 'Specifies the value of the FileName field.';

                    trigger OnAssistEdit();
                    var
                        FileMgt: Codeunit "File Management";
                        ExcelFileExtensionTok: Label '.xlsm';
                    begin
                        // BC Upgrade BHARDA11 >>
                        // FileName := FileMgt.UploadFile(Text006, ExcelFileExtensionTok);
                        File.UploadIntoStream(Text006, '', FromFilter, FileName, InStr);
                        // BC Upgrade BHARDA11 <<
                    end;
                }
                field("Worksheet Name"; SheetName)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Worksheet Name',
                                NLD = 'Werkbladnaam';
                    ToolTip = 'Specifies the value of the SheetName field.';

                    trigger OnAssistEdit();
                    begin
                        // BC Upgrade BHARDA11 >>
                        SheetName := ExcelBuf.SelectSheetsNameStream(InStr);
                        // SheetName := ExcelBuf.SelectSheetsName(FileName);
                        // BC Upgrade BHARDA11 <<
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
        ExcelBuf.DELETEALL;
        ReadExcelSheet;
        AnalyzeData;
    end;

    var
        // BC Upgrade BHARDA11 >>
        InStr: InStream;
        FromFilter: Label 'Excel File (*.xlsx)|*.xlsx';
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        // BC Upgrade BHARDA11 <<
        ExcelBuf: Record "Excel Buffer" temporary;
        FileName: Text;
        SheetName: Text;
        Window: Dialog;
        TotalRecNo: Integer;
        RecNo: Integer;
        Counter1: Integer;
        Text007: Label 'Analyzing Data...\\';
        Text006: Label 'Import Excel File';
        GenJnlTemplateName: Text;
        GenJnlBatchName: Text;
        GenJournalBatch: Record "Gen. Journal Batch";
        Text008: Label 'Dimenssions has been succesfully imported!';
        RowNo: Integer;
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        DimAdded: Boolean;
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimMgt: Codeunit DimensionManagement;
        GLEntry: Record "G/L Entry";
        GLEntryNo: Integer;
        GLEntryAccountNo: Code[20];
        Prostchar: Label '''';
        TmpDimensionSetEntry: Record "Dimension Set Entry" temporary;
        DimensionValue: Record "Dimension Value";

    procedure ReadExcelSheet();
    begin
        // BC Upgrade BHARDA11 >>
        // ExcelBuf.OpenBook(FileName, SheetName);
        ExcelBuf.OpenBookStream(InStr, SheetName);
        // BC Upgrade BHARDA11 <<
        ExcelBuf.ReadSheet;
    end;

    procedure AnalyzeData();
    var
        HeaderExcelBuffer: Record "Excel Buffer" temporary;
        HeaderRowNo: Integer;
        OldRowNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        PostingDate: Date;
        Amount: Decimal;
        LineNo: Integer;
        DimensionValue2: Record "Dimension Value";
    begin
        HeaderExcelBuffer.DELETEALL;
        Window.OPEN(
          Text007 +
          '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.UPDATE(1, 0);
        TotalRecNo := ExcelBuf.COUNT;
        RecNo := 1;
        Counter1 := 0;
        LineNo := 10000;
        if ExcelBuf.FIND('-') then begin
            HeaderExcelBuffer := ExcelBuf;             //Store Header Row
            HeaderRowNo := RecNo;                      //Store Header Row Number
            repeat
                RecNo := RecNo + 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                case true of
                    (ExcelBuf."Row No." > HeaderRowNo) and (HeaderRowNo > 0):
                        begin
                            if ExcelBuf."Row No." <> OldRowNo then begin
                                OldRowNo := ExcelBuf."Row No.";

                                GLEntry.RESET;

                                if ExcelBuf.GET(ExcelBuf."Row No.", 1) then
                                    EVALUATE(GLEntryNo, ExcelBuf."Cell Value as Text");

                                GLEntry.SETRANGE("Entry No.", GLEntryNo);

                                if ExcelBuf.GET(ExcelBuf."Row No.", 2) then
                                    EVALUATE(GLEntryAccountNo, ExcelBuf."Cell Value as Text");

                                GLEntryAccountNo := DELCHR(GLEntryAccountNo, '=', Prostchar);
                                GLEntry.SETRANGE("G/L Account No.", GLEntryAccountNo);

                                if GLEntry.FINDFIRST then begin
                                    CLEAR(TmpDimensionSetEntry);
                                    DimAdded := false;
                                    if ExcelBuf.GET(ExcelBuf."Row No.", 3) then begin
                                        DimMgt.GetDimensionSet(TmpDimensionSetEntry, GLEntry."Dimension Set ID");

                                        DimensionValue.SETRANGE("Dimension Code", 'CCC');
                                        DimensionValue.SETRANGE(Code, ExcelBuf."Cell Value as Text");
                                        if DimensionValue.FINDFIRST then
                                            TmpDimensionSetEntry.SETRANGE("Dimension Code", 'CCC');
                                        if not TmpDimensionSetEntry.FIND('-') then begin
                                            TmpDimensionSetEntry.INIT;
                                            TmpDimensionSetEntry."Dimension Code" := 'CCC';
                                            TmpDimensionSetEntry."Dimension Value Code" := ExcelBuf."Cell Value as Text";
                                            TmpDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                                            TmpDimensionSetEntry.INSERT;
                                            DimAdded := true;
                                        end;
                                        GLEntry."Dimension Set ID" := DimMgt.GetDimensionSetID(TmpDimensionSetEntry);
                                        if (DimensionValue.Code <> '') and (DimensionValue."Dimension Code" = 'CCC') then
                                            GLEntry."Global Dimension 2 Code" := DimensionValue.Code;
                                        GLEntry.MODIFY;

                                    end;
                                end;
                                Counter1 += 1;
                            end;
                        end;
                end;
            until ExcelBuf.NEXT = 0;
        end;
    end;

    local procedure GetValueatcell(RowNo: Integer; ColNo: Integer): Text;
    begin
        if ExcelBuf.GET(RowNo, ColNo) then
            exit(ExcelBuf."Cell Value as Text");
    end;
}

