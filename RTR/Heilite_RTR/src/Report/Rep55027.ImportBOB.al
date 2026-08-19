report 55027 "Import BOB"
{
    // version HEI.01

    // BC Upgrade RAHUL >>
    // Report Name : Import BOB
    // Old Report ID : 50200 (NAV)
    //
    // 1. File upload logic upgraded for Business Central SaaS compatibility.
    //    - Blocked FileMgt.UploadFile() as direct file system access is not supported in BC cloud.
    //    - Implemented File.UploadIntoStream() to upload Excel files using stream-based handling.
    //    - Introduced InStream to read uploaded Excel content securely.
    //
    // 2. Excel Buffer processing converted from file-based to stream-based access.
    //    - Blocked ExcelBuf.OpenBook(FileName, SheetName).
    //    - Added ExcelBuf.OpenBookStream(InStr, SheetName).
    //    Reason: BC SaaS does not allow direct access to local or server file paths.
    //
    // 3. Worksheet selection logic updated to support stream-based Excel handling.
    //    - Blocked ExcelBuf.SelectSheetsName(FileName).
    //    - Added ExcelBuf.SelectSheetsNameStream(InStr).
    //
    // 4. Deprecated field validation removed due to schema changes in Business Central.
    //    - Blocked VALIDATE(Type, BankAccReconciliationLine.Type::"Bank Account Ledger Entry").
    //    Reason: Field "Type" no longer exists on table Bank Acc. Reconciliation Line in BC.
    //
    // 5. Report metadata enhanced for Business Central UI visibility.
    //    - Added ApplicationArea = All.
    //    - Added UsageCategory = ReportsAndAnalysis.
    //    Ensures report is searchable and accessible in BC Role Explorer.
    //
    // 6. Variables added/used specifically for BC upgrade support.
    //    - InStr       : InStream  (used for Excel stream processing)
    //    - OutStr      : OutStream
    //    - FromFilter  : Label     (Excel file filter for upload dialog)
    //    - FileName    : Text      (uploaded Excel file name)
    //    - SheetName   : Text      (selected worksheet name)
    //
    // 7. No functional or business logic changes introduced.
    //    - Excel data import behavior remains identical to NAV version.
    //    - Only technical upgrades applied to meet Business Central SaaS standards.
    //
    // 8. Report remains ProcessingOnly with unchanged execution flow.
    //    - OnPreReport triggers Excel read and data analysis as earlier.
    //
    // BC Upgrade RAHUL <<

    ProcessingOnly = true;
    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding UsageCategory

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field("Import From"; '')
                {
                    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea to the Action Button
                }
                field("WorkBook File Name"; FileName)
                {
                    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea to the Action Button
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
                    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea to the Action Button
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

    trigger OnPreReport();
    begin
        ExcelBuf.DeleteAll();
        ReadExcelSheet();
        AnalyzeData();
    end;

    var
        ToBankAccReconciliation: Record "Bank Acc. Reconciliation";

        // BC Upgrade KUMARR78 >>
        ExcelBuf: Record "Excel Buffer" temporary;
        TempBlob: Codeunit "Temp Blob";
        Window: Dialog;
        // BC Upgrade KUMARR78 <<
        InStr: InStream;
        Counter1: Integer;
        LineNo: Integer;
        RecNo: Integer;
        TotalRecNo: Integer;
        FromFilter: Label 'Excel File (*.xlsx)|*.xlsx';
        Text006: Label 'Import Excel File';
        Text007: Label 'Analyzing Data...\\';
        Text008: Label 'There is nothing to import';
        OutStr: OutStream;
        FileName: Text;
        SheetName: Text;

    procedure ReadExcelSheet();
    begin
        // ExcelBuf.OpenBook(FileName, SheetName); // BC Upgrade KUMARR78 Blocking.
        ExcelBuf.OpenBookStream(InStr, SheetName);// BC Upgrade KUMARR78 Adding.
        ExcelBuf.ReadSheet();
    end;

    procedure AnalyzeData();
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        TransDate: Date;
        Amt: Decimal;
        i: Integer;
        NextLineNo: Integer;
        TotalLines: Integer;
        Desc: Text;
    begin
        Clear(ExcelBuf);
        if ExcelBuf.FindLast() then
            TotalLines := ExcelBuf."Row No.";
        if TotalLines < 2 then
            Error(Text008);
        Clear(ExcelBuf);
        for i := 2 to TotalLines do begin
            if ExcelBuf.Get(i, 2) then
                Evaluate(TransDate, ExcelBuf."Cell Value as Text");
            if ExcelBuf.Get(i, 3) then
                Desc := ExcelBuf."Cell Value as Text";
            if ExcelBuf.Get(i, 5) then
                Evaluate(Amt, ExcelBuf."Cell Value as Text");
            BankAccReconciliationLine.SetRange("Statement Type", ToBankAccReconciliation."Statement Type");
            BankAccReconciliationLine.SetRange("Bank Account No.", ToBankAccReconciliation."Bank Account No.");
            BankAccReconciliationLine.SetRange("Statement No.", ToBankAccReconciliation."Statement No.");
            if BankAccReconciliationLine.FindLast() then
                NextLineNo := BankAccReconciliationLine."Statement Line No." + 10000
            else
                NextLineNo := 10000;

            BankAccReconciliationLine.Init();
            BankAccReconciliationLine."Statement Type" := ToBankAccReconciliation."Statement Type";
            BankAccReconciliationLine."Bank Account No." := ToBankAccReconciliation."Bank Account No.";
            BankAccReconciliationLine."Statement No." := ToBankAccReconciliation."Statement No.";
            BankAccReconciliationLine."Statement Line No." := NextLineNo;
            BankAccReconciliationLine.Insert(true);
            BankAccReconciliationLine.Validate("Transaction Date", TransDate);
            // BankAccReconciliationLine.VALIDATE(Type, BankAccReconciliationLine.Type::"Bank Account Ledger Entry");//BC Upgrade KUMARR78 Blocking As Field Removed in BC.
            if Amt <> 0 then
                BankAccReconciliationLine.Validate("Statement Amount", Amt);
            BankAccReconciliationLine.Validate("Transaction Text", Desc);
            BankAccReconciliationLine.Modify(true);
        end;
    end;

    procedure SetTemplate(var BankAccReconciliationSrc: Record "Bank Acc. Reconciliation");
    begin
        ToBankAccReconciliation := BankAccReconciliationSrc;
    end;
}

