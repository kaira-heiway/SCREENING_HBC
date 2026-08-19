report 51099 "GL Bulk Application Import CBN"
{
    // HEI.01 CHG2317671 IBM POENAB02 02.10.2025 HB2428 Excel Mapping Report IBM tool for closing GL entries for GL Account with big volume of data
    //   # Object created

    // BC UPGRADE MISHRAS14 >>
    // # Created Report
    // # Nav ID : 50621
    // BC UPGRADE MISHRAS14 <<

    ApplicationArea = All;
    Caption = 'GL Bulk Application Import';
    UsageCategory = ReportsAndAnalysis;
    processingonly = true;

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    
    trigger OnPreReport()
    var
        lApplicationCombination : Integer;
        lEntryNo : Integer;
        lAmount : Decimal;
        lApplyWithEntryNo : Integer;
        lAmountToApplyTo : Decimal;
        lCurrEntry : Integer;
        lAmtFromGLEntryHeiLite : Decimal;
        lAmtToApplyToHeiLite : Decimal;
        lTotalAmtToApplyTo : Decimal;
        lEntryNoOpen : Boolean;
        lEntryNoToApplyOpen : Boolean;
        lGLAccNo : Code[20];
        lGLAccNoToApply : Code[20];
    begin
        GLBulkApplicationTMP.DELETEALL;
        GLBulkApplicationTMP2.DELETEALL;
        IF DelFromGLBulkApplication THEN
        GLBulkApplication.DELETEALL;

        IF GLBulkApplication.FINDFIRST THEN
        ERROR(Text001);

        ReadExcelSheet;

        ExcelBuf.RESET;
        ExcelBuf.FINDLAST;
        MaxRowNo := ExcelBuf."Row No.";

        ExcelBuf.RESET;
        ExcelBuf.SETFILTER("Row No.", '>= %1', 2);

        lCurrEntry := 0;
        IF ExcelBuf.FINDSET(FALSE) THEN
        REPEAT
            GLBulkApplicationTMP.RESET;

            IF ExcelBuf."Column No." = 1 THEN
            BEGIN
                EVALUATE(lApplicationCombination,ExcelBuf."Cell Value as Text");
                lCurrEntry := lCurrEntry + 1;
            END;
            IF ExcelBuf."Column No." = 2 THEN
            BEGIN
                lAmtFromGLEntryHeiLite := 0;
                EVALUATE(lEntryNo,ExcelBuf."Cell Value as Text");
                GLEntry.RESET;
                IF GLEntry.GET(lEntryNo) THEN
                BEGIN
                    lAmtFromGLEntryHeiLite := GLEntry.Amount;
                    lEntryNoOpen := GLEntry."Open FND";
                    lGLAccNo := GLEntry."G/L Account No.";
                END;
            END;
            IF ExcelBuf."Column No." = 3 THEN
            EVALUATE(lAmount,ExcelBuf."Cell Value as Text");
            IF ExcelBuf."Column No." = 4 THEN
            BEGIN
                lAmtToApplyToHeiLite := 0;
                EVALUATE(lApplyWithEntryNo,ExcelBuf."Cell Value as Text");
                GLEntry.RESET;
                IF GLEntry.GET(lApplyWithEntryNo) THEN
                BEGIN
                    lAmtToApplyToHeiLite := GLEntry.Amount;
                    lEntryNoToApplyOpen := GLEntry."Open FND";
                    lGLAccNoToApply := GLEntry."G/L Account No.";
                END;
            END;
            IF ExcelBuf."Column No." = 5 THEN
            BEGIN
                EVALUATE(lAmountToApplyTo,ExcelBuf."Cell Value as Text");
                GLBulkApplicationTMP.RESET;
                GLBulkApplicationTMP."Entry No. PK" := lCurrEntry;
                GLBulkApplicationTMP."Application Combination" := lApplicationCombination;
                GLBulkApplicationTMP."Entry No." := lEntryNo;
                GLBulkApplicationTMP.Amount := lAmount;
                GLBulkApplicationTMP."Entry No. To Apply To" := lApplyWithEntryNo;
                GLBulkApplicationTMP."Amount To Apply To" := lAmountToApplyTo;
                GLBulkApplicationTMP."Amount From GL Entry (HeiLite)" := lAmtFromGLEntryHeiLite;
                GLBulkApplicationTMP."Amount To Apply To (HeiLite)" := lAmtToApplyToHeiLite;
                IF lEntryNoOpen = TRUE THEN
                GLBulkApplicationTMP."Entry No. - Open (HeiLite)" := Text002
                ELSE
                    GLBulkApplicationTMP."Entry No. - Open (HeiLite)" := Text003;
                IF lEntryNoToApplyOpen = TRUE THEN
                GLBulkApplicationTMP."Entry No.ToApply-Open(HeiLite)" := Text002
                ELSE
                    GLBulkApplicationTMP."Entry No.ToApply-Open(HeiLite)" := Text003;
                GLBulkApplicationTMP."G/L Account No." := lGLAccNo;
                GLBulkApplicationTMP."Apply with G/L Account No." := lGLAccNoToApply;
                IF GLBulkApplicationTMP.INSERT THEN;
                GLBulkApplicationTMP2.RESET;
                GLBulkApplicationTMP2.SETRANGE("Application Combination",GLBulkApplicationTMP."Application Combination");
                IF NOT GLBulkApplicationTMP2.FINDFIRST THEN
                BEGIN
                    GLBulkApplicationTMP2."Entry No. PK" := GLBulkApplicationTMP."Entry No. PK";
                    GLBulkApplicationTMP2."Application Combination" := GLBulkApplicationTMP."Application Combination";
                    GLBulkApplicationTMP2.Amount := GLBulkApplicationTMP.Amount;
                    GLBulkApplicationTMP2."Amount From GL Entry (HeiLite)" := GLBulkApplicationTMP."Amount From GL Entry (HeiLite)";
                    IF GLBulkApplicationTMP2.INSERT THEN;
                END;
            END;

        UNTIL ExcelBuf.NEXT = 0;

        GLBulkApplicationTMP2.RESET;
        IF GLBulkApplicationTMP2.FINDFIRST THEN
        REPEAT
            lTotalAmtToApplyTo := 0;
            GLBulkApplicationTMP.RESET;
            GLBulkApplicationTMP.SETRANGE("Application Combination",GLBulkApplicationTMP2."Application Combination");
            IF GLBulkApplicationTMP.FINDSET(FALSE) THEN
            REPEAT
                lTotalAmtToApplyTo += GLBulkApplicationTMP."Amount To Apply To (HeiLite)";
            UNTIL GLBulkApplicationTMP.NEXT = 0;

            IF (GLBulkApplicationTMP2."Amount From GL Entry (HeiLite)" <> lTotalAmtToApplyTo) THEN
            BEGIN
                GLBulkApplicationTMP.RESET;
                GLBulkApplicationTMP.SETRANGE("Application Combination",GLBulkApplicationTMP2."Application Combination");
                IF GLBulkApplicationTMP.FINDSET(FALSE) THEN
                REPEAT
                    GLBulkApplicationTMP."Difference (HeiLite)" := ABS(GLBulkApplicationTMP2."Amount From GL Entry (HeiLite)") - ABS(lTotalAmtToApplyTo);
                    GLBulkApplicationTMP.MODIFY;
                UNTIL GLBulkApplicationTMP.NEXT = 0;
            END;
        UNTIL GLBulkApplicationTMP2.NEXT = 0;

        GLBulkApplicationTMP.RESET;
        IF GLBulkApplicationTMP.FINDSET(FALSE) THEN
        REPEAT
            GLEntry.RESET;
            GLBulkApplication.TRANSFERFIELDS(GLBulkApplicationTMP);
            IF GLBulkApplication.INSERT THEN;
        UNTIL GLBulkApplicationTMP.NEXT = 0;

    end;

    trigger OnPostReport()
    begin
        ExcelBuf.DELETEALL;
        GLBulkApplicationTMP.DELETEALL;
        GLBulkApplicationTMP2.DELETEALL;

        MESSAGE(Text004);
    end;

    var
        FileName: Text[250];
        SheetName: Text[250];
        FileMgt : Codeunit "File Management";
        ExcelBuf: Record "Excel Buffer";
        MaxRowNo : Integer;
        i : Integer;
        GLBulkApplicationTMP : Record "GL Bulk Application FND" temporary;
        NewRow : Boolean;
        GLBulkApplication : Record "GL Bulk Application FND";
        DelFromGLBulkApplication : Boolean;
        GLEntry : Record "G/L Entry";
        GLBulkApplicationTMP2 : Record "GL Bulk Application FND" temporary;
        Text006: Label 'Import Excel File';
        ExcelFileExtensionTok: Label '.xls*';
        Text001: Label 'You cannot add new entries, as records already exist in GL Bulk Application!';
        Text002: Label 'Yes';
        Text003: Label 'No';
        Text004: Label 'Data has been uploaded successfully!';



    procedure ReadExcelSheet()
    var
        InStr: InStream;
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
    begin
        // BC UPGRADE MISHRAS14 >> # Blocked OpenBook as it has only OnPrem scope and replaced by the following logic
        // ExcelBuf.OpenBook(FileName,SheetName);

        UploadIntoStream(
            'Select Excel File',
            '',
            'Excel Files (*.xlsx)|*.xlsx',
            FileName,
            InStr);

        TempBlob.CreateOutStream(OutStr);
        CopyStream(OutStr, InStr);

        TempBlob.CreateInStream(InStr);
        SheetName := ExcelBuf.SelectSheetsNameStream(InStr);

        TempBlob.CreateInStream(InStr);
        ExcelBuf.OpenBookStream(InStr, SheetName);
        ExcelBuf.ReadSheet();
        // BC UPGRADE MISHRAS14 <<
    end;
}
