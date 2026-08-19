report 55023 "Import Dimenssions to GL Acc"
{
    // version HEI.01

    // INC2141858 IBM ISYED01 06-14-2019
    // # CREATED NEW REPORT TO UPDATE DIMENSIONS TO GL ENTRY

    // BC Upgrade KUMARR78>>
    // 1. Added Business Central report discoverability properties for visibility/search.
    //    Old: ApplicationArea and UsageCategory not defined at report level.
    //    New:
    //        - ApplicationArea = All;
    //        - UsageCategory = ReportsAndAnalysis;
    // 2. Updated Excel file upload logic to use stream-based approach (BC compliant).
    //    Old: FileName := FileMgt.UploadFile(Text006, ExcelFileExtensionTok);
    //    New: File.UploadIntoStream(Text006, '', FromFilter, FileName, InStr);
    // 3. Updated worksheet selection logic to stream-based method.
    //    Old: SheetName := ExcelBuf.SelectSheetsName(FileName);
    //    New: SheetName := ExcelBuf.SelectSheetsNameStream(InStr);
    // 4. Updated Excel open book logic to stream-based method.
    //    Old: ExcelBuf.OpenBook(FileName, SheetName);
    //    New: ExcelBuf.OpenBookStream(InStr, SheetName);
    // 5. Added new stream variables required for BC Excel import.
    //    New variables added:
    //        - InStr: InStream;
    //        - OutStr: OutStream;
    //        - TempBlob: Codeunit "Temp Blob";
    //        - FromFilter: Label 'Excel File (*.xlsx)|*.xlsx';
    // 6. Old/New reference.
    //     Old Report ID: 50028
    //     New: Upgraded for BC compatibility using stream-based Excel import and report visibility properties.

    // BC Upgrade KUMARR78<<


    Permissions = TableData "G/L Entry" = rimd;
    ProcessingOnly = true;
    ApplicationArea = All; // BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade KUMARR78 Adding Usagecategory

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
        TmpDimensionSetEntry: Record "Dimension Set Entry" temporary;
        DimensionValue: Record "Dimension Value";
        ExcelBuf: Record "Excel Buffer" temporary;
        GLEntry: Record "G/L Entry";
        GenJournalBatch: Record "Gen. Journal Batch";
        GeneralLedgerSetup: Record "General Ledger Setup";
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        DimMgt: Codeunit DimensionManagement;
        DimAdded: Boolean;
        GLEntryAccountNo: Code[20];
        Window: Dialog;
        Counter1: Integer;
        GLEntryNo: Integer;
        RecNo: Integer;
        RowNo: Integer;
        TotalRecNo: Integer;
        Prostchar: Label '''';
        Text006: Label 'Import Excel File';
        Text007: Label 'Analyzing Data...\\';
        Text008: Label 'Dimenssions has been succesfully imported!';
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
        PostingDate: Date;
        Amount: Decimal;
        HeaderRowNo: Integer;
        LineNo: Integer;
        OldRowNo: Integer;
    begin
        HeaderExcelBuffer.DELETEALL();
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

                                GLEntry.RESET();

                                if ExcelBuf.GET(ExcelBuf."Row No.", 1) then
                                    EVALUATE(GLEntryNo, ExcelBuf."Cell Value as Text");

                                GLEntry.SETRANGE("Entry No.", GLEntryNo);

                                if ExcelBuf.GET(ExcelBuf."Row No.", 2) then
                                    EVALUATE(GLEntryAccountNo, ExcelBuf."Cell Value as Text");

                                GLEntryAccountNo := DELCHR(GLEntryAccountNo, '=', Prostchar);
                                GLEntry.SETRANGE("G/L Account No.", GLEntryAccountNo);

                                if GLEntry.FINDFIRST() then begin
                                    CLEAR(TmpDimensionSetEntry);
                                    DimAdded := false;
                                    if ExcelBuf.GET(ExcelBuf."Row No.", 3) then begin
                                        DimMgt.GetDimensionSet(TmpDimensionSetEntry, GLEntry."Dimension Set ID");

                                        DimensionValue.SETRANGE("Dimension Code", 'MVMT');
                                        DimensionValue.SETRANGE(Code, ExcelBuf."Cell Value as Text");
                                        if DimensionValue.FINDFIRST() then
                                            TmpDimensionSetEntry.SETRANGE("Dimension Code", 'MVMT');
                                        if not TmpDimensionSetEntry.FIND('-') then begin
                                            TmpDimensionSetEntry.INIT();
                                            TmpDimensionSetEntry."Dimension Code" := 'MVMT';
                                            TmpDimensionSetEntry."Dimension Value Code" := ExcelBuf."Cell Value as Text";
                                            TmpDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                                            TmpDimensionSetEntry.INSERT();
                                            DimAdded := true;
                                        end;
                                        GLEntry."Dimension Set ID" := DimMgt.GetDimensionSetID(TmpDimensionSetEntry);
                                        GLEntry.MODIFY();

                                    end;
                                end;
                                Counter1 += 1;
                            end;
                        end;
                end;
            until ExcelBuf.NEXT() = 0;
        end;
    end;

    local procedure GetValueatcell(RowNo: Integer; ColNo: Integer): Text;
    begin
        if ExcelBuf.GET(RowNo, ColNo) then
            exit(ExcelBuf."Cell Value as Text");
    end;
}

