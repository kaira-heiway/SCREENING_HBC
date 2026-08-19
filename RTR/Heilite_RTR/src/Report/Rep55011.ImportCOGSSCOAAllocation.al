report 55011 "Import COGS SCOA Allocation"
{
    // version HEI.02

    // HEI.01 IBM CHG2132673 BULIMC01 04/03/2022 #new report created to import the COGS Allocation
    // HEI.02 HB2605 - CHG2132673 IBM NASTAA02 13.05.2022 # COGS Allocation
    //   # Code added to include GL Entries without CCC

    // BC Upgrade POENAB02: Original (HeiLite) report id 50549

    Caption = 'Import COGS SCOA Allocation';
    ProcessingOnly = true;
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
                    ToolTip = 'Imports COGS SCOA Allocation setup from an Excel workbook.';
                    ApplicationArea = All;
                }
                field("WorkBook File Name"; FileName)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Workbook File Name',
                                NLD = 'Werkmapbestandsnaam';
                    ToolTipML = ENU = 'Specifies the name of the Excel workbook file to import from.',
                                        NLD = 'Geef de naam op van het Excel-werkmapbestand om van te importeren.';
                    Editable = false;

                    trigger OnAssistEdit();
                    begin
                        //FileName := FileMgt.UploadFile(Text50001, ExcelFileExtensionTok); // BC Upgrade POENAB02
                        if UploadIntoStream(Text50001, '', ExcelFileExtensionTok, FileName, FileInStream) then
                            SheetName := TempExcelBuffer.SelectSheetsNameStream(FileInStream);
                    end;
                }
                field("Worksheet Name"; SheetName)
                {
                    CaptionML = ENU = 'Worksheet Name',
                                NLD = 'Werkbladnaam';
                    ToolTipML = ENU = 'Specifies the name of the worksheet in the Excel workbook to import from.',
                                        NLD = 'Geef de naam op van het werkblad in de Excel-werkmap om van te importeren.';
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnAssistEdit();
                    begin
                        //SheetName := TempExcelBuffer.SelectSheetsName(FileName); // BC Upgrade POENAB02
                        if FileName <> '' then begin
                            if UploadIntoStream(Text50001, '', ExcelFileExtensionTok, FileName, FileInStream) then
                                SheetName := TempExcelBuffer.SelectSheetsNameStream(FileInStream);
                        end else
                            Message('Please select a workbook file first.');
                    end;
                }
                field("Choose the operator:"; CCOperator)
                {
                    Caption = 'Choose the operator:';
                    ApplicationArea = All;
                    ToolTip = 'Choose the operator for Cost Center Code filter.';
                }
                field("Filter for Entries without CCC"; EmptyFilter)
                {
                    Caption = 'Filter for Entries without CCC';
                    ApplicationArea = All;
                    ToolTip = 'Specify the filter to be used for entries without Cost Center Code.';
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
        Window.Close();

        if Imported then
            Message(Text50003)
        else
            Message(Text50004);

        TempGenJnl.DeleteAll();
        ;
        TempExcelBuffer.DeleteAll();
    end;

    trigger OnPreReport();
    begin
        if not Confirm(Text50000, true) then
            CurrReport.Quit();

        Window.Open(Text50002 + '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');

        DeleteExistingEntries();

        ReadExcelSheet();
        AnalyzeData();
        InsertSetup();
    end;

    var
        TransType: Option Export,Import;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        //FileMgt: Codeunit "File Management"; // BC Upgrade POENAB02
        //ServerFileName: Text; // BC Upgrade POENAB02
        //ClientFileName: Text; // BC Upgrade POENAB02       
        SheetName: Text[250];
        ExcelFileExtensionTok: Label '.xlsx';
        RowNo: Integer;
        FileInStream: InStream;
        Text50000: Label 'The import will delete the existing data. New setup will be created. Do you want to proceed?';
        Text50001: Label 'COGS SCOA Allocation';
        FileName: Text;
        Window: Dialog;
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        NoOfProgresed: Integer;
        Counter: Integer;
        TimeProgress: Time;
        Text50002: Label 'Analyzing Data...\\';
        RecNo: Integer;
        TotalRecNo: Integer;
        Counter1: Integer;
        Imported: Boolean;
        CCOperator: Option "??","*";
        Text50003: Label 'Import successful!';
        Text50004: Label 'Nothing has been imported!';
        COGSAllocSetup: Record "G/L COGS Allocation Setup FND";
        TempGenJnl: Record "Gen. Journal Line" temporary;
        EmptyFilter: Text;

    procedure ReadExcelSheet();
    begin
        // BC Upgrade POENAB02: Original (HeiLite) code
        /*
        TempExcelBuffer.OpenBook(FileName, SheetName);
        TempExcelBuffer.ReadSheet;        
        */

        // BC Upgrade POENAB02: New code to replace the original code above
        if FileName = '' then
            Error('Please select a workbook file.');
        if SheetName = '' then
            Error('Please select a worksheet.');

        if not UploadIntoStream(Text50001, '', ExcelFileExtensionTok, FileName, FileInStream) then
            Error('File upload was cancelled.');

        TempExcelBuffer.OpenBookStream(FileInStream, SheetName);
        TempExcelBuffer.ReadSheet();
    end;

    procedure AnalyzeData();
    var
        HeaderRowNo: Integer;
        OldRowNo: Integer;
        SCOA: Text;
        COGS: Text;
        CostCenterCode: Text;
    begin
        Window.Update(1, 0);
        TotalRecNo := TempExcelBuffer.Count();
        RecNo := 1;
        Counter1 := 0;

        if TempExcelBuffer.Find('-') then begin
            HeaderRowNo := RecNo;
            repeat
                RecNo := RecNo + 1;
                Window.Update(1, Round(RecNo / TotalRecNo * 10000, 1));
                if (TempExcelBuffer."Row No." > HeaderRowNo) and (HeaderRowNo > 0) then begin
                    if TempExcelBuffer."Row No." <> OldRowNo then begin
                        Clear(SCOA);
                        Clear(COGS);
                        Clear(CostCenterCode);

                        //SCOA
                        if TempExcelBuffer.Get(TempExcelBuffer."Row No.", 1) then
                            SCOA := TempExcelBuffer."Cell Value as Text" + '*';

                        //CCC code
                        if TempExcelBuffer.Get(TempExcelBuffer."Row No.", 2) then
                            CostCenterCode := TempExcelBuffer."Cell Value as Text"
                        //HEI.02>>
                        else
                            if EmptyFilter <> '' then
                                CostCenterCode := EmptyFilter;
                        //HEI.02<<

                        //COGS Allocation type
                        if TempExcelBuffer.Get(TempExcelBuffer."Row No.", 3) then
                            Evaluate(COGS, TempExcelBuffer."Cell Value as Text");

                        TempGenJnl.Reset();
                        TempGenJnl.SetRange("Account No.", SCOA);
                        TempGenJnl.SetRange(Description, COGS);
                        TempGenJnl.SetFilter(Amount, '<=%1', MaxStrLen(TempGenJnl.Comment) - 10);
                        if not TempGenJnl.FindFirst() then begin
                            TempGenJnl.Init();
                            TempGenJnl."Line No." := FindEntryNo();
                            TempGenJnl."Account No." := SCOA;
                            TempGenJnl.Description := COGS;
                            //HEI.02>>
                            if CostCenterCode = EmptyFilter then
                                TempGenJnl.Comment := EmptyFilter
                            else
                                //HEI.02<<
                                TempGenJnl.Comment := Format(CCOperator) + CostCenterCode + Format(CCOperator);
                            TempGenJnl.Amount := StrLen(TempGenJnl.Comment); //count the length of CCC filters
                            TempGenJnl.Insert(false);
                        end else begin
                            //HEI.02>>
                            if CostCenterCode = EmptyFilter then
                                TempGenJnl.Comment := EmptyFilter
                            else
                                //HEI.02<<
                                TempGenJnl.Comment += '|' + Format(CCOperator) + CostCenterCode + Format(CCOperator);
                            TempGenJnl.Amount := StrLen(TempGenJnl.Comment);
                            TempGenJnl.Modify(false);
                        end;
                    end;
                end;
            until TempExcelBuffer.Next() = 0;
        end;
    end;

    local procedure InsertSetup();
    var
        CogsOption: Option " ","Energy & Water","Inv. Mov. Var. Prod Exp.","Other Variable Expenses","Packaging Materials","Prod Bought in for Resale","Prod Fix Exp","Raw Materials";
    begin
        TempGenJnl.Reset();
        if TempGenJnl.FindSet() then
            repeat
                COGSAllocSetup.Reset();
                COGSAllocSetup."Entry No." := TempGenJnl."Line No.";
                COGSAllocSetup."G/L Account Range for SCOA L3" := TempGenJnl."Account No.";
                COGSAllocSetup."Ccc Code Dim. Filter" := TempGenJnl.Comment;
                Evaluate(CogsOption, TempGenJnl.Description);
                COGSAllocSetup."COGS Allocation" := CogsOption;
                COGSAllocSetup.Insert();
                Imported := true;
            until TempGenJnl.Next() = 0;
    end;

    local procedure FindEntryNo(): Integer;
    begin
        TempGenJnl.Reset();
        if not TempGenJnl.FindLast() then
            exit(1)
        else
            exit(TempGenJnl."Line No." + 1);
    end;

    local procedure DeleteExistingEntries();
    begin
        COGSAllocSetup.Reset();
        if not COGSAllocSetup.IsEmpty then
            COGSAllocSetup.DeleteAll();

        TempExcelBuffer.DeleteAll();
    end;
}

