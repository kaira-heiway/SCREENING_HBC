report 51003 "FA Upload CBN"
{
    // version HEI.03

    // HEI.01 CHG2090921 IBM BULIMC01 23/11/2020 #new report created to export/import Fixed Assets and FA Depr. Book
    // HEI.02 CHG2198895 IBM YADAVM05 13/04/2023
    // # CMG code field is added in report as CMG CODE field is Mandatory on Fixed Asset
    // HEI.03 CHG2198895 IBM YADAVM05 08/05/2023
    // # CMG code fild added after Description to overcome CMG Code Error

    // BC Upgrade PATELS08 >>
    // Old Object ID : 50551
    // # Added ApplicationArea and UsageCategory properties for the report.
    // # Blocked local variable 'XlWrkSht' in trigger 'OnPostDataItem' of dataitem 'Fixed Asset'.
    // # In OnAssistEdit() trigger of field 'WorkBook File Name', blocked method 'UploadFile' of codeunit 'File Management' is used which has scope 'OnPrem' and cannot be used for 'Extension' development.
    // # Corrected the signature of 'OnLookup' trigger of field 'FA Depreciation Book' to include 'var' keyword for the Text parameter.
    // # For global variables ImportOption and ExportOption, Blocked attribute '[InDataSet]' because it is deprecated.
    // # Blocked Drink-It Fields is procedures MakeExcelDataHeader, MakeExcelDataBody, AnalyzeSheet1 and AnalyzeSheet2.
    // # In ReadExcelSheet procedure, blocked method OpenBook as it has only On-prem scope.
    // BC Upgrade PATELS08 <<

    // BC Upgrade POENAB02, 31.03.2026, FDD "Mass FA Creation"
    // moved from id 57007 to id 55052

    // BC Upgrade POENAB02, 01.04.2026, FDD "Mass FA Creation"
    // moved from id 55052 to id 50657, to be available in Page Extension 50039 FixedAssetListExt
    //FDD - IBM GAP RTR 33 – PID-765 - Mass FA Creation
    //Bc Upgrade YADAVM09 on request page block on look up code for Depriciation book code and added the table relation.

    Caption = 'FA Upload';
    ProcessingOnly = true;
    // BC Upgrade PATELS08 >>
    ApplicationArea = All;
    UsageCategory = Tasks;
    // BC Upgrade PATELS08 <<


    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);

            trigger OnAfterGetRecord();
            begin
                if (TransType = TransType::Export) and (lOption in [lOption::"Fixed Asset", lOption::Both]) then begin
                    if not HeaderPrinted then
                        MakeExcelDataHeader(1);
                    MakeExcelDataBody(1);

                    Counter += 1;
                    if (Counter >= NoOfRecProgress) then begin
                        NoOfProgresed := NoOfProgresed + Counter;
                        Window.UPDATE(1, ROUND(NoOfProgresed / NoOfRecords * 10000, 1));
                        Counter := 0;
                        TimeProgress := TIME;
                    end;
                end;
            end;

            trigger OnPostDataItem();
            var
                FANo: Code[20];
                lFixedAsset: Record "Fixed Asset";
                HeaderRowNo: Integer;
                OldRowNo: Integer;
            // BC Upgrade PATELS08 >> # Blocked because DotNet variable and also not used.
            // XlWrkSht : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Worksheet" RUNONCLIENT;
            // BC Upgrade PATELS08 <<
            begin
                if (TransType = TransType::Export) and (lOption in [lOption::"Fixed Asset", lOption::Both]) then begin
                    // BC Upgrade PATELS08 >>
                    // TempExcelBuffer.InsertIntoExcelBook(Text50000, '', COMPANYNAME, USERID, false);
                    InsertIntoExcelBook(Text50000, '', COMPANYNAME, USERID);
                    // BC Upgrade PATELS08 <<
                    BookCreated := true;
                end;
            end;

            trigger OnPreDataItem();
            begin
                if TransType = TransType::Export then begin
                    if FANo <> '' then
                        SETFILTER("No.", FANo);
                    NoOfRecords := COUNT;
                    NoOfRecProgress := NoOfRecords div 100;
                    Counter := 0;
                    NoOfProgresed := 0;
                    TimeProgress := TIME;
                end;
            end;
        }
        dataitem("FA Depreciation Book"; "FA Depreciation Book")
        {
            DataItemTableView = SORTING("FA No.", "Depreciation Book Code") ORDER(Ascending);

            trigger OnAfterGetRecord();
            begin
                if TransType = TransType::Export then
                    if lOption in [lOption::"FA Depr. Book", lOption::Both] then begin
                        if not HeaderPrinted then
                            MakeExcelDataHeader(2);
                        MakeExcelDataBody(2);
                    end;
            end;

            trigger OnPostDataItem();
            begin
                if (TransType = TransType::Export) and (lOption in [lOption::"FA Depr. Book", lOption::Both]) then
                    // BC Upgrade PATELS08 >>
                    // TempExcelBuffer.InsertIntoExcelBook(Text50001, '', COMPANYNAME, USERID, BookCreated);
                    InsertIntoExcelBook(Text50001, '', COMPANYNAME, USERID);
                // BC Upgrade PATELS08 <<
            end;

            trigger OnPreDataItem();
            begin
                TempExcelBuffer.DELETEALL();
                HeaderPrinted := false;

                if FANo <> '' then
                    SETFILTER("FA No.", FANo);
                if FADeprBook <> '' then
                    SETFILTER("Depreciation Book Code", FADeprBook);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(TransType; TransType)
                {
                    Caption = 'Direction:';
                    ApplicationArea = All;
                    ToolTip = 'Select the direction of data transfer';

                    trigger OnValidate();
                    begin
                        if TransType = TransType::Import then begin
                            ImportOption := true;
                            ExportOption := false;
                        end else begin
                            ImportOption := false;
                            ExportOption := true;
                        end;
                    end;
                }
                field(lOption; lOption)
                {
                    Caption = 'Import/Export For:';
                    ApplicationArea = All;
                    ToolTip = 'Select whether to import/export Fixed Asset, FA Depr. Book or Both';
                }
                field(Control55008; '')
                {
                    ApplicationArea = All;
                    Caption = 'Note: For import, the excel file should be in the same format as the exported file.';
                    ToolTip = 'For import, the excel file should be in the same format as the exported file.';
                }
                field("Import From"; '')
                {
                    Caption = 'Import From:';
                    Editable = ImportOption;
                    ApplicationArea = All;
                    ToolTip = 'Select the source of data for import. File should be in excel format and in the same format as the exported file.';
                }
                field("WorkBook File Name"; FileName)
                {
                    CaptionML = ENU = 'Workbook File Name',
                                NLD = 'Werkmapbestandsnaam';
                    Editable = ImportOption;
                    ApplicationArea = All;
                    ToolTip = 'Select the excel file to import. File should be in excel format and in the same format as the exported file.';

                    trigger OnAssistEdit();
                    begin
                        // BC UPGRADE PATELS08 >> # Blocked because method 'UploadFile' has scope 'OnPrem' and cannot be used for 'Extension' development.
                        if ImportOption then
                            //   FileName := FileMgt.UploadFile(Text50000,ExcelFileExtensionTok);
                            File.UploadIntoStream(
                            Text50000,
                            '',
                            ExcelFileExtensionTok,
                            FileName,
                            ExcelFileStream);
                        // BC UPGRADE PATELS08 <<
                    end;
                }
                field(Control55002; '')
                {
                    ApplicationArea = All;
                }
                field("Export For:"; '')
                {
                    Caption = 'Export For:';
                    ApplicationArea = All;
                    ToolTip = 'Select whether to export Fixed Asset, FA Depr. Book or Both';
                }
                field(FANo; FANo)
                {
                    Caption = 'Fixed Asset No.';
                    Editable = ExportOption;
                    TableRelation = "Fixed Asset";
                    ApplicationArea = All;
                    ToolTip = 'Select the Fixed Asset No. to export along with its depreciation book. If left blank, all records will be exported.';
                }
                field(FADeprBook; FADeprBook)
                {
                    Caption = 'Depreciation Book';
                    Editable = ExportOption;
                    ApplicationArea = All;
                    TableRelation = "Depreciation Book";//Bc Upgrade YADAVM09<<
                    ToolTip = 'Select the Depreciation Book Code to export. If left blank, all records will be exported.';

                    // BC Upgrade PATELS08 >> # Added var, Correct signature for 'OnLookup' is 'trigger OnLookup(var Text: Text) 
                    // trigger OnLookup(Text : Text) : Boolean;
                    // trigger OnLookup(var Text: Text): Boolean;
                    // // BC Upgrade PATELS08 << 
                    // var
                    //     Rec_FADeprBook: Record "FA Depreciation Book";
                    //     Page_FADeprBooks: Page "FA Depreciation Books";
                    // begin
                    //     CLEAR(Page_FADeprBooks);
                    //     Rec_FADeprBook.SETFILTER("FA No.", FANo);
                    //     Page_FADeprBooks.SETTABLEVIEW(Rec_FADeprBook);
                    //     Page_FADeprBooks.LOOKUPMODE(true);
                    //     if Page_FADeprBooks.RUNMODAL() = ACTION::LookupOK then
                    //         Text := Page_FADeprBooks.GetSelectionFilter()
                    //     else
                    //         exit(false);
                    //     exit(true);
                    // end;//Bc Upgrade YADAVM09<<
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            ExportOption := true;
        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        if TransType = TransType::Export then begin
            Window.OPEN(Text50008);
            TempExcelBuffer.CloseBook();
            TempExcelBuffer.SetFriendlyFilename(GetFileName());
            // BC Upgrade PATELS08 >>
            // TempExcelBuffer.OpenExcel();
            // TempExcelBuffer.GiveUserControl();
            DownloadExcel();
            // BC Upgrade PATELS08 <<
            Window.CLOSE();
        end else begin
            if ImportedVersion then
                MESSAGE('Import successful!')
            else
                MESSAGE('Nothing imported!');
        end;
    end;

    trigger OnPreReport();
    var
        BOM_no: Text;
        ProductionBOMVersion: Record "Production BOM Version";
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMLine: Record "Production BOM Line";
        TempExcelBuffer2: Record "Excel Buffer" temporary;
        IsHeader: Boolean;
    begin
        if TransType = TransType::Export then
            Window.OPEN(Text50003 + Text50004)
        else
            Window.OPEN(Text50007);

        if TransType = TransType::Import then begin
            //import FA
            if lOption in [lOption::"Fixed Asset", lOption::Both] then begin
                TempExcelBuffer.DELETEALL();
                ReadExcelSheet(1);
                AnalyzeSheet1();
            end;
            //import the FA Depr. books
            if lOption in [lOption::"FA Depr. Book", lOption::Both] then begin
                TempExcelBuffer.DELETEALL();
                ReadExcelSheet(2);
                AnalyzeSheet2();
            end;
        end;

        BookCreated := false;
    end;

    var
        TransType: Option Export,Import;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        FileMgt: Codeunit "File Management";
        ServerFileName: Text;
        ClientFileName: Text;
        SheetName: Text[250];
        Text001: Label 'Filters';
        Text002: Label 'Update Workbook';
        ExcelFileExtensionTok: Label 'Excel File (*.xlsx)|*.xlsx';
        OverwriteFileQst: Label 'Do you want to overwrite the existing file?';
        RowNo: Integer;
        DateVar: Date;
        IntVar: Integer;
        DecimalVar: Decimal;
        Text50000: Label 'Fixed Asset';
        Text50001: Label 'FA Depr. Book';
        FileName: Text;
        Text50007: Label 'Import Excel File';
        // BC Upgrade PATELS08 >> # Blocked attribute '[InDataSet]' because it is deprecated and exposure of page variables handled automatically in BC.
        // [InDataSet] 
        // BC Upgrade PATELS08 <<
        ImportOption: Boolean;
        Text50003: Label 'Exporting to Fixed Asset sheet..  @1@@@@@@@@@@@ \';
        Text50004: Label 'Exporting to FA Depr. Book sheet..  @2@@@@@@@@@@@ \';
        Window: Dialog;
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        NoOfProgresed: Integer;
        Counter: Integer;
        TimeProgress: Time;
        NoOfRecords2: Integer;
        NoOfRecProgress2: Integer;
        NoOfProgresed2: Integer;
        Counter2: Integer;
        TimeProgress2: Time;
        Text50006: Label '"Opening the excel file.. "';
        HeaderPrinted: Boolean;
        NoOfRecords3: Integer;
        NoOfRecProgress3: Integer;
        NoOfProgresed3: Integer;
        Counter3: Integer;
        TimeProgress3: Time;
        NoOfRecords4: Integer;
        NoOfRecProgress4: Integer;
        NoOfProgresed4: Integer;
        Counter4: Integer;
        TimeProgress4: Time;
        Text50008: Label 'Please wait for the excel file to open...';
        Text007: Label 'Analyzing Fixed Asset data...\\';
        Text006: Label 'Import Excel File';
        RecNo: Integer;
        TotalRecNo: Integer;
        Counter1: Integer;
        ImportedVersion: Boolean;
        // BC Upgrade PATELS08 >> # Blocked attribute '[InDataSet]' because it is deprecated and exposure of page variables handled automatically in BC.
        // [InDataSet] 
        // BC Upgrade PATELS08 <<
        ExportOption: Boolean;
        FileManagement: Codeunit "File Management";
        FileNameClient: Text;
        FileNameServer: Text;
        DateTxt: Text;
        Text008: Label 'Analyzing FA Depr. Book data...\\';
        InvalidWindowsChrStringTxt: TextConst ENU = '""#%&*:<>?\/{|}~', FRA = '""#%&*:<>?\/{|}~';
        TimeTxt: Text;
        lOption: Option Both,"Fixed Asset","FA Depr. Book";
        BookCreated: Boolean;
        FANo: Code[250];
        FADeprBook: Code[250];
        DimensionManagement: Codeunit DimensionManagement;

        ExcelFileStream: InStream;

    procedure MakeExcelDataHeader(HeaderFor: Integer);
    begin
        TempExcelBuffer.NewRow();
        case HeaderFor of
            1:
                begin
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION(Description), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("CMG code FND"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);//HEI.03
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Search Description"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Description 2"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("FA Class Code"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("FA Subclass Code"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Global Dimension 1 Code"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Global Dimension 2 Code"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Location Code"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("FA Location Code"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Vendor No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Main Asset/Component"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Component of Main Asset"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Budgeted Asset"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Warranty Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Responsible Employee"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Serial No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Last Date Modified"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION(Blocked), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Maintenance Vendor No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Under Maintenance"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Next Service Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION(Inactive), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("No. Series"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("FA Posting Group"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    //TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Professional Tax"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Asset Indicator FND"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("WHT Product Posting Group FND"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Quantity FND"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Tag No FND"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    // BC Upgrade PATELS08 >> # Blocked because Drikit Fields
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Allow Invoice Disc."),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Shortcut Property 1 Code"),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Shortcut Property 2 Code"),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Shortcut Property 3 Code"),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Shortcut Property 4 Code"),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Shortcut Property 5 Code"),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Shortcut Property 6 Code"),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Shortcut Property 7 Code"),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Shortcut Property 8 Code"),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Shortcut Property 9 Code"),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Shortcut Property 10 Code"),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("FA Template Code"),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Depreciation Starting Date"),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Created by Service Item No."),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Fixed Asset on Inventory"),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Financial Contract No."),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    //TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Customer No."),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("Customer No. 114FDW"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);//FDD - IBM GAP RTR 33
                    // BC Upgrade PATELS08 <<
                    // TempExcelBuffer.AddColumn("Fixed Asset".FIELDCAPTION("CMG code"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);//HEI.02
                    HeaderPrinted := true;
                end;
            2:
                begin
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("FA No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Depreciation Book Code"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Depreciation Method"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Depreciation Starting Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Straight-Line %"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("No. of Depreciation Years"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("No. of Depreciation Months"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Fixed Depr. Amount"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Declining-Balance %"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Depreciation Table Code"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Final Rounding Amount"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Ending Book Value"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("FA Posting Group"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Depreciation Ending Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Acquisition Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("G/L Acquisition Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Disposal Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Last Acquisition Cost Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Last Depreciation Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Last Write-Down Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Last Appreciation Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Last Custom 1 Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Last Custom 2 Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Last Salvage Value Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("FA Exchange Rate"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Fixed Depr. Amount below Zero"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Last Date Modified"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("First User-Defined Depr. Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Use FA Ledger Check"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Last Maintenance Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Depr. below Zero %"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Projected Disposal Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Projected Proceeds on Disposal"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Depr. Starting Date (Custom 1)"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Depr. Ending Date (Custom 1)"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Accum. Depr. % (Custom 1)"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Depr. This Year % (Custom 1)"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Property Class (Custom 1)"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION(Description), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Main Asset/Component"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Component of Main Asset"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("FA Add.-Currency Factor"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Use Half-Year Convention"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Use DB% First Fiscal Year"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Temp. Ending Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Temp. Fixed Depr. Amount"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Ignore Def. Ending Book Value"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Default FA Depreciation Book"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);

                    // BC Upgrade PATELS08 >> # Blocked because Drikit Fields
                    // TempExcelBuffer.AddColumn("FA Depreciation Book".FIELDCAPTION("Last Derogatory Date"),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // BC Upgrade PATELS08 <<
                    HeaderPrinted := true;
                end;
        end;
    end;

    procedure MakeExcelDataBody(BodyFor: Integer);
    begin
        TempExcelBuffer.NewRow();
        case BodyFor of
            1:
                begin
                    TempExcelBuffer.AddColumn("Fixed Asset"."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."CMG code FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);//HEI.03
                    TempExcelBuffer.AddColumn("Fixed Asset"."Search Description", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Description 2", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."FA Class Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."FA Subclass Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Global Dimension 1 Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Global Dimension 2 Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Location Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."FA Location Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Vendor No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Main Asset/Component", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Component of Main Asset", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Budgeted Asset", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Warranty Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Responsible Employee", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Serial No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Last Date Modified", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".Blocked, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Maintenance Vendor No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Under Maintenance", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Next Service Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset".Inactive, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."No. Series", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."FA Posting Group", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    //TempExcelBuffer.AddColumn("Fixed Asset"."Professional Tax", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Asset Indicator FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."WHT Product Posting Group FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);//IBM GAP RTR 33 – PID-765  
                    TempExcelBuffer.AddColumn("Fixed Asset"."Quantity FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Fixed Asset"."Tag No FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    // BC Upgrade PATELS08 >> # Blocked because Drikit Fields
                    // TempExcelBuffer.AddColumn("Fixed Asset"."Allow Invoice Disc.",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset"."Shortcut Property 1 Code",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset"."Shortcut Property 2 Code",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset"."Shortcut Property 3 Code",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset"."Shortcut Property 4 Code",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset"."Shortcut Property 5 Code",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset"."Shortcut Property 6 Code",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset"."Shortcut Property 7 Code",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset"."Shortcut Property 8 Code",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset"."Shortcut Property 9 Code",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset"."Shortcut Property 10 Code",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset"."FA Template Code",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset"."Depreciation Starting Date",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset"."Created by Service Item No.",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset"."Fixed Asset on Inventory",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn("Fixed Asset"."Financial Contract No.",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);//IBM GAP RTR 33 – PID-765 
                    // TempExcelBuffer.AddColumn("Fixed Asset"."Customer No.",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);//IBM GAP RTR 33 – PID-765 
                    TempExcelBuffer.AddColumn("Fixed Asset"."Customer No. 114FDW", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);//IBM GAP RTR 33 – PID-765 
                    // BC Upgrade PATELS08 <<
                    //TempExcelBuffer.AddColumn("Fixed Asset"."CMG code",FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);//HEI.02
                end;
            2:
                begin
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."FA No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Depreciation Book Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Depreciation Method", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Depreciation Starting Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Straight-Line %", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."No. of Depreciation Years", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."No. of Depreciation Months", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Fixed Depr. Amount", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Declining-Balance %", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Depreciation Table Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Final Rounding Amount", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Ending Book Value", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."FA Posting Group", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Depreciation Ending Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Acquisition Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."G/L Acquisition Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Disposal Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Last Acquisition Cost Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Last Depreciation Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Last Write-Down Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Last Appreciation Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Last Custom 1 Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Last Custom 2 Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Last Salvage Value Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."FA Exchange Rate", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Fixed Depr. Amount below Zero", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Last Date Modified", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."First User-Defined Depr. Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Use FA Ledger Check", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Last Maintenance Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Depr. below Zero %", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Projected Disposal Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Projected Proceeds on Disposal", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Depr. Starting Date (Custom 1)", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Depr. Ending Date (Custom 1)", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Accum. Depr. % (Custom 1)", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Depr. This Year % (Custom 1)", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Property Class (Custom 1)", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book".Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Main Asset/Component", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Component of Main Asset", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."FA Add.-Currency Factor", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Use Half-Year Convention", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Use DB% First Fiscal Year", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Temp. Ending Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Temp. Fixed Depr. Amount", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Ignore Def. Ending Book Value", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("FA Depreciation Book"."Default FA Depreciation Book", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    // BC Upgrade PATELS08 >> # Blocked because Drikit Fields
                    // TempExcelBuffer.AddColumn("FA Depreciation Book"."Last Derogatory Date",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                    // BC Upgrade PATELS08 <<
                end;

        end;
    end;

    procedure ReadExcelSheet(ImportFor: Integer);
    begin
        // BC UPRADE PATELS08 >> # Method OpenBook has no scope for SAAS, only for on-prem
        // case ImportFor of

        //   1: TempExcelBuffer.OpenBook(FileName,Text50000);
        //   2: TempExcelBuffer.OpenBook(FileName,Text50001);
        // end;

        case ImportFor of
            1:
                TempExcelBuffer.OpenBookStream(ExcelFileStream, Text50000);
            2:
                TempExcelBuffer.OpenBookStream(ExcelFileStream, Text50001);
        end;

        // BC UPRADE PATELS08 <<
        TempExcelBuffer.ReadSheet();
    end;

    procedure AnalyzeSheet1();
    var
        HeaderExcelBuffer: Record "Excel Buffer" temporary;
        HeaderRowNo: Integer;
        OldRowNo: Integer;
        FixedAsset: Record "Fixed Asset";
        MainCompAsset_var: Option " ","Main Asset",Component;
        BudgetedAsset_var: Boolean;
        WarrantyDate_var: Date;
        LastDateModified_var: Date;
        Blocked_var: Boolean;
        UnderMaint_var: Boolean;
        NextServiceDate_var: Date;
        Inactive_var: Boolean;
        ProfTax_var: Option "No Tax","Fixed Asset for more than 30 years 1","Fixed Asset for more than 30 years 2","Fixed Asset less than 30 years";
        AssetIndicator_var: Option OK,"1","2";
        Qty_var: Decimal;
        AllowInvoiceDisc_var: Boolean;
        DeprecStartingDate_var: Date;
        FixedAssetInventory_var: Boolean;
        Customer: Record Customer;
        Text001: Label '"Import failed! The field %1 of table %2 contains a value (%3) that cannot be found in the related table(%4). "';
    begin
        HeaderExcelBuffer.DELETEALL();
        Window.OPEN(
          Text007 +
          '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.UPDATE(1, 0);
        TotalRecNo := TempExcelBuffer.COUNT;
        RecNo := 1;
        Counter1 := 0;

        if TempExcelBuffer.FIND('-') then begin
            HeaderExcelBuffer := TempExcelBuffer;
            HeaderRowNo := RecNo;
            repeat
                RecNo := RecNo + 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                if (TempExcelBuffer."Row No." > HeaderRowNo) and (HeaderRowNo > 0) then begin
                    if TempExcelBuffer."Row No." <> OldRowNo then begin
                        OldRowNo := TempExcelBuffer."Row No.";
                        FixedAsset.INIT();
                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 1) then
                            if not FixedAsset.GET(TempExcelBuffer."Cell Value as Text") then begin
                                FixedAsset.VALIDATE("No.", TempExcelBuffer."Cell Value as Text");
                                FixedAsset.INSERT();
                            end;
                        //Description
                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 2) then
                            FixedAsset.VALIDATE(Description, TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset.Description := '';
                        //HEI.03>>
                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 3) then
                            FixedAsset.VALIDATE("CMG code FND", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."CMG code FND" := '';
                        //HEI.03<<

                        //Search Description
                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 4) then//HEI.03
                            FixedAsset.VALIDATE("Search Description", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."Search Description" := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 5) then//HEI.03
                            FixedAsset.VALIDATE("Description 2", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."Description 2" := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 6) then//HEI.03
                            FixedAsset.VALIDATE("FA Class Code", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."FA Class Code" := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 7) then//HEI.03
                            FixedAsset.VALIDATE("FA Subclass Code", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."FA Subclass Code" := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 8) then//HEI.03
                            FixedAsset.VALIDATE("Global Dimension 1 Code", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."Global Dimension 1 Code" := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 9) then //HEI.03
                            FixedAsset.VALIDATE("Global Dimension 2 Code", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."Global Dimension 2 Code" := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 10) then//HEI.03
                            FixedAsset.VALIDATE("Location Code", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."Location Code" := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 11) then//HEI.03
                            FixedAsset.VALIDATE("FA Location Code", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."FA Location Code" := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 12) then//HEI.03
                            FixedAsset.VALIDATE("Vendor No.", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."Vendor No." := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 13) then begin//HEI.03
                            EVALUATE(MainCompAsset_var, TempExcelBuffer."Cell Value as Text");
                            FixedAsset.VALIDATE("Main Asset/Component", MainCompAsset_var);
                        end
                        else
                            FixedAsset."Main Asset/Component" := FixedAsset."Main Asset/Component"::" ";

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 14) then//HEI.03
                            FixedAsset.VALIDATE("Component of Main Asset", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."Component of Main Asset" := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 15) then begin//HEI.03
                            EVALUATE(BudgetedAsset_var, TempExcelBuffer."Cell Value as Text");
                            if BudgetedAsset_var <> FixedAsset."Budgeted Asset" then
                                FixedAsset.VALIDATE("Budgeted Asset", BudgetedAsset_var)
                            else
                                FixedAsset."Budgeted Asset" := BudgetedAsset_var;
                        end;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 16) then begin//HEI.03
                            EVALUATE(WarrantyDate_var, TempExcelBuffer."Cell Value as Text");
                            FixedAsset.VALIDATE("Warranty Date", WarrantyDate_var);
                        end else
                            FixedAsset."Warranty Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 17) then//HEI.03
                            FixedAsset.VALIDATE("Responsible Employee", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."Responsible Employee" := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 18) then//HEI.03
                            FixedAsset.VALIDATE("Serial No.", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."Serial No." := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 20) then begin//HEI.03
                            EVALUATE(Blocked_var, TempExcelBuffer."Cell Value as Text");
                            FixedAsset.VALIDATE(Blocked, Blocked_var);
                        end;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 21) then//HEI.03
                            FixedAsset.VALIDATE("Maintenance Vendor No.", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."Maintenance Vendor No." := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 22) then begin//HEI.03
                            EVALUATE(UnderMaint_var, TempExcelBuffer."Cell Value as Text");
                            FixedAsset.VALIDATE("Under Maintenance", UnderMaint_var);
                        end;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 23) then begin//HEI.03
                            EVALUATE(NextServiceDate_var, TempExcelBuffer."Cell Value as Text");
                            FixedAsset.VALIDATE("Next Service Date", NextServiceDate_var);
                        end else
                            FixedAsset."Next Service Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 24) then begin//HEI.03
                            EVALUATE(Inactive_var, TempExcelBuffer."Cell Value as Text");
                            FixedAsset.VALIDATE(Inactive, Inactive_var);
                        end;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 25) then//HEI.03
                            FixedAsset.VALIDATE("No. Series", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."No. Series" := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 26) then//HEI.03
                            FixedAsset.VALIDATE("FA Posting Group", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."FA Posting Group" := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 27) then begin//HEI.03
                            EVALUATE(ProfTax_var, TempExcelBuffer."Cell Value as Text");
                            // FixedAsset.VALIDATE("Professional Tax", ProfTax_var);
                        end;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 28) then begin//HEI.03
                            EVALUATE(AssetIndicator_var, TempExcelBuffer."Cell Value as Text");
                            FixedAsset.VALIDATE("Asset Indicator FND", AssetIndicator_var);
                        end;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 29) then//HEI.03
                            FixedAsset.VALIDATE("WHT Product Posting Group FND", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."WHT Product Posting Group FND" := '';


                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 30) then begin//HEI.03
                            EVALUATE(Qty_var, TempExcelBuffer."Cell Value as Text");
                            FixedAsset.VALIDATE("Quantity FND", Qty_var);
                        end else
                            FixedAsset."Quantity FND" := 0;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 31) then//HEI.03
                            FixedAsset.VALIDATE("Tag No FND", TempExcelBuffer."Cell Value as Text")
                        else
                            FixedAsset."Tag No FND" := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 32) then begin//HEI.03
                            EVALUATE(AllowInvoiceDisc_var, TempExcelBuffer."Cell Value as Text");

                            // FixedAsset.VALIDATE("Allow Invoice Disc.",AllowInvoiceDisc_var); // BC Upgrade PATELS08 >> # Blocked because Drikit Fields
                        end;

                        // BC Upgrade PATELS08 >> # Blocked because Drikit Field Dependency
                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",33) then//HEI.03
                        //   FixedAsset.VALIDATE("Shortcut Property 1 Code",TempExcelBuffer."Cell Value as Text")
                        // else FixedAsset."Shortcut Property 1 Code" := ''; 

                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",34) then//HEI.03
                        //   FixedAsset.VALIDATE("Shortcut Property 2 Code",TempExcelBuffer."Cell Value as Text") 
                        // else FixedAsset."Shortcut Property 2 Code" := ''; 

                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",35) then//HEI.03
                        //   FixedAsset.VALIDATE("Shortcut Property 3 Code",TempExcelBuffer."Cell Value as Text")
                        // else FixedAsset."Shortcut Property 3 Code" := '';
                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",36) then//HEI.03
                        //   FixedAsset.VALIDATE("Shortcut Property 4 Code",TempExcelBuffer."Cell Value as Text")
                        // else FixedAsset."Shortcut Property 4 Code" := '';
                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",37) then//HEI.03
                        //   FixedAsset.VALIDATE("Shortcut Property 5 Code",TempExcelBuffer."Cell Value as Text")
                        // else FixedAsset."Shortcut Property 5 Code" := '';
                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",38) then//HEI.03
                        //   FixedAsset.VALIDATE("Shortcut Property 6 Code",TempExcelBuffer."Cell Value as Text")
                        // else FixedAsset."Shortcut Property 6 Code" := '';
                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",39) then
                        //   FixedAsset.VALIDATE("Shortcut Property 7 Code",TempExcelBuffer."Cell Value as Text")
                        // else FixedAsset."Shortcut Property 7 Code" := '';
                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",40) then//HEI.03
                        //   FixedAsset.VALIDATE("Shortcut Property 8 Code",TempExcelBuffer."Cell Value as Text")
                        // else FixedAsset."Shortcut Property 8 Code" := '';
                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",41) then//HEI.03
                        //   FixedAsset.VALIDATE("Shortcut Property 9 Code",TempExcelBuffer."Cell Value as Text")
                        // else FixedAsset."Shortcut Property 9 Code" := '';
                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",42) then//HEI.03
                        //   FixedAsset.VALIDATE("Shortcut Property 10 Code",TempExcelBuffer."Cell Value as Text")
                        // else FixedAsset."Shortcut Property 10 Code" := '';

                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",43) then//HEI.03
                        //   FixedAsset.VALIDATE("FA Template Code",TempExcelBuffer."Cell Value as Text")
                        // else FixedAsset."FA Template Code" := '';


                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",44) then begin//HEI.03
                        //   EVALUATE(DeprecStartingDate_var,TempExcelBuffer."Cell Value as Text");
                        //   FixedAsset.VALIDATE("Depreciation Starting Date",DeprecStartingDate_var);
                        // end else FixedAsset."Depreciation Starting Date" := 0D;
                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",45) then//HEI.03
                        //   FixedAsset.VALIDATE("Created by Service Item No.",TempExcelBuffer."Cell Value as Text")
                        // else FixedAsset."Created by Service Item No." := '';
                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",46) then begin//HEI.03
                        //   EVALUATE(FixedAssetInventory_var,TempExcelBuffer."Cell Value as Text");
                        //   FixedAsset.VALIDATE("Fixed Asset on Inventory",FixedAssetInventory_var);
                        // end;
                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",47) then//HEI.03
                        //   FixedAsset.VALIDATE("Financial Contract No.",TempExcelBuffer."Cell Value as Text")
                        // else FixedAsset."Financial Contract No." := '';
                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",48) then begin//HEI.03
                        //   if Customer.GET(TempExcelBuffer."Cell Value as Text") then
                        //     FixedAsset."Customer No." := TempExcelBuffer."Cell Value as Text"
                        //   else
                        //     ERROR(Text001,FixedAsset.FIELDCAPTION("Customer No."),FixedAsset.TABLECAPTION,TempExcelBuffer."Cell Value as Text",Customer.TABLECAPTION);
                        // end else FixedAsset."Customer No." := '';
                        // BC Upgrade PATELS08 << # Blocked because Drikit Fields

                        FixedAsset.MODIFY();
                        ImportedVersion := true;

                        Counter1 += 1;
                    end;
                end;
            until TempExcelBuffer.NEXT() = 0;
        end;
        Window.CLOSE();
    end;

    procedure AnalyzeSheet2();
    var
        HeaderExcelBuffer: Record "Excel Buffer" temporary;
        HeaderRowNo: Integer;
        OldRowNo: Integer;
        FADeprBook: Record "FA Depreciation Book";
        FixedAssetNo: Code[20];
        DeprBookCode: Code[20];
        DeprMethod_var: Option "Straight-Line","Declining-Balance 1","Declining-Balance 2","DB1/SL","DB2/SL","User-Defined",Manual;
        DepreciationStartingDate_var: Date;
        StraightLine_var: Decimal;
        NoDeprYears_var: Decimal;
        NoDeprMonths_var: Decimal;
        FixedDeprAmount: Decimal;
        DecliningBalance_var: Decimal;
        FinalRoundingAmt_var: Decimal;
        EndingBookValue_var: Decimal;
        DeprEndingDate_var: Date;
        AcquisitionDate_var: Date;
        GLAcquisitionDate_var: Date;
        LastAcquisitionCostDate_var: Date;
        LastDeprDate_var: Date;
        LastWrDownDate_var: Date;
        LastApprecDate_var: Date;
        LastCustom1Date_var: Date;
        LastCustom2Date_var: Date;
        DisposalDate_var: Date;
        SalvageDate_var: Date;
        FAExchRate_var: Decimal;
        FixedAmtbelowZero_var: Decimal;
        LastDateModif_var: Date;
        FirstUserDefDeprDate: Date;
        UseFALedgCheck_var: Boolean;
        LastMaintDate_var: Date;
        DeprBelowZero_var: Decimal;
        ProjectedDisposalDate_var: Date;
        ProjectedProceedsDisposal_var: Decimal;
        DeprStartDateCust1_var: Date;
        DeprEndDateCust1_var: Date;
        AccumDeprCust1_var: Decimal;
        DeprThisYear_var: Decimal;
        PropertyClass_var: Option " ","Personal Property","Real Property";
        MainAssComp_var: Option " ","Main Asset",Component;
        FAddCurrFactor_var: Decimal;
        UseHalfYearConvention_var: Boolean;
        UseDBFirstFiscalYear_var: Boolean;
        TempEndDate_var: Date;
        TempFixedDeprAmount_var: Decimal;
        IgnoreDefEndingBookValue: Boolean;
        DefaultFADeprBook_var: Boolean;
        LastDerogatoryDate_var: Date;
    begin
        HeaderExcelBuffer.DELETEALL();
        Window.OPEN(
          Text008 +
          '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.UPDATE(1, 0);
        TotalRecNo := TempExcelBuffer.COUNT;
        RecNo := 1;
        Counter1 := 0;

        if TempExcelBuffer.FIND('-') then begin
            HeaderExcelBuffer := TempExcelBuffer;
            HeaderRowNo := RecNo;
            repeat
                RecNo := RecNo + 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                if (TempExcelBuffer."Row No." > HeaderRowNo) and (HeaderRowNo > 0) then begin
                    if TempExcelBuffer."Row No." <> OldRowNo then begin
                        OldRowNo := TempExcelBuffer."Row No.";
                        FADeprBook.INIT();

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 1) then
                            FixedAssetNo := TempExcelBuffer."Cell Value as Text";
                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 2) then
                            DeprBookCode := TempExcelBuffer."Cell Value as Text";

                        if not FADeprBook.GET(FixedAssetNo, DeprBookCode) then begin
                            FADeprBook.VALIDATE("FA No.", FixedAssetNo);
                            FADeprBook.VALIDATE("Depreciation Book Code", DeprBookCode);
                            FADeprBook.INSERT();
                        end;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 3) then begin
                            EVALUATE(DeprMethod_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Depreciation Method", DeprMethod_var);
                        end;
                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 4) then begin
                            EVALUATE(DepreciationStartingDate_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Depreciation Starting Date", DepreciationStartingDate_var);
                        end else
                            FADeprBook."Depreciation Starting Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 5) then begin
                            EVALUATE(StraightLine_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Straight-Line %", StraightLine_var);
                        end else
                            FADeprBook."Straight-Line %" := 0;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 8) then begin
                            EVALUATE(FixedDeprAmount, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Fixed Depr. Amount", FixedDeprAmount);
                        end else
                            FADeprBook."Fixed Depr. Amount" := 0;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 6) then begin
                            EVALUATE(NoDeprYears_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("No. of Depreciation Years", NoDeprYears_var);
                        end;
                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 7) then begin
                            EVALUATE(NoDeprMonths_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("No. of Depreciation Months", NoDeprMonths_var);
                        end;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 9) then begin
                            EVALUATE(DecliningBalance_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Declining-Balance %", DecliningBalance_var);
                        end else
                            FADeprBook."Declining-Balance %" := 0;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 10) then
                            FADeprBook.VALIDATE("Depreciation Table Code", TempExcelBuffer."Cell Value as Text")
                        else
                            FADeprBook."Depreciation Table Code" := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 11) then begin
                            EVALUATE(FinalRoundingAmt_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Final Rounding Amount", FinalRoundingAmt_var);
                        end else
                            FADeprBook."Final Rounding Amount" := 0;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 12) then begin
                            EVALUATE(EndingBookValue_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Ending Book Value", EndingBookValue_var);
                        end else
                            FADeprBook."Ending Book Value" := 0;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 13) then
                            FADeprBook.VALIDATE("FA Posting Group", TempExcelBuffer."Cell Value as Text")
                        else
                            FADeprBook."FA Posting Group" := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 14) then begin
                            EVALUATE(DeprEndingDate_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Depreciation Ending Date", DeprEndingDate_var);
                        end else
                            FADeprBook."Depreciation Ending Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 15) then begin
                            EVALUATE(AcquisitionDate_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Acquisition Date", AcquisitionDate_var);
                        end else
                            FADeprBook."Acquisition Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 16) then begin
                            EVALUATE(GLAcquisitionDate_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("G/L Acquisition Date", GLAcquisitionDate_var);
                        end else
                            FADeprBook."G/L Acquisition Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 17) then begin
                            EVALUATE(DisposalDate_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Disposal Date", DisposalDate_var);
                        end else
                            FADeprBook."Disposal Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 18) then begin
                            EVALUATE(LastAcquisitionCostDate_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Last Acquisition Cost Date", LastAcquisitionCostDate_var);
                        end else
                            FADeprBook."Last Acquisition Cost Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 19) then begin
                            EVALUATE(LastDeprDate_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Last Depreciation Date", LastDeprDate_var);
                        end;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 20) then begin
                            EVALUATE(LastWrDownDate_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Last Write-Down Date", LastWrDownDate_var);
                        end else
                            FADeprBook."Last Write-Down Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 21) then begin
                            EVALUATE(LastApprecDate_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Last Appreciation Date", LastApprecDate_var);
                        end else
                            FADeprBook."Last Appreciation Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 22) then begin
                            EVALUATE(LastCustom1Date_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Last Custom 1 Date", LastCustom1Date_var);
                        end else
                            FADeprBook."Last Custom 1 Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 23) then begin
                            EVALUATE(LastCustom2Date_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Last Custom 2 Date", LastCustom2Date_var);
                        end else
                            FADeprBook."Last Custom 2 Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 24) then begin
                            EVALUATE(SalvageDate_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Last Salvage Value Date", SalvageDate_var);
                        end else
                            FADeprBook."Last Salvage Value Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 25) then begin
                            EVALUATE(FAExchRate_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("FA Exchange Rate", FAExchRate_var);
                        end else
                            FADeprBook."FA Exchange Rate" := 0;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 26) then begin
                            EVALUATE(FixedAmtbelowZero_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Fixed Depr. Amount below Zero", FixedAmtbelowZero_var);
                        end else
                            FADeprBook."Fixed Depr. Amount below Zero" := 0;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 27) then begin
                            EVALUATE(LastDateModif_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Last Date Modified", LastDateModif_var);
                        end else
                            FADeprBook."Last Date Modified" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 28) then begin
                            EVALUATE(FirstUserDefDeprDate, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("First User-Defined Depr. Date", FirstUserDefDeprDate);
                        end else
                            FADeprBook."First User-Defined Depr. Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 29) then begin
                            EVALUATE(UseFALedgCheck_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Use FA Ledger Check", UseFALedgCheck_var);
                        end;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 30) then begin
                            EVALUATE(LastMaintDate_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Last Maintenance Date", LastMaintDate_var);
                        end else
                            FADeprBook."Last Maintenance Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 31) then begin
                            EVALUATE(DeprBelowZero_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Depr. below Zero %", DeprBelowZero_var);
                        end else
                            FADeprBook."Depr. below Zero %" := 0;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 32) then begin
                            EVALUATE(ProjectedDisposalDate_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Projected Disposal Date", ProjectedDisposalDate_var);
                        end else
                            FADeprBook."Projected Disposal Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 33) then begin
                            EVALUATE(ProjectedProceedsDisposal_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Projected Proceeds on Disposal", ProjectedProceedsDisposal_var);
                        end else
                            FADeprBook."Projected Proceeds on Disposal" := 0;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 34) then begin
                            EVALUATE(DeprStartDateCust1_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Depr. Starting Date (Custom 1)", DeprStartDateCust1_var);
                        end else
                            FADeprBook."Depr. Starting Date (Custom 1)" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 35) then begin
                            EVALUATE(DeprEndDateCust1_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Depr. Ending Date (Custom 1)", DeprEndDateCust1_var);
                        end else
                            FADeprBook."Depr. Ending Date (Custom 1)" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 36) then begin
                            EVALUATE(AccumDeprCust1_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Accum. Depr. % (Custom 1)", AccumDeprCust1_var);
                        end else
                            FADeprBook."Accum. Depr. % (Custom 1)" := 0;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 37) then begin
                            EVALUATE(DeprThisYear_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Depr. This Year % (Custom 1)", DeprThisYear_var);
                        end else
                            FADeprBook."Depr. This Year % (Custom 1)" := 0;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 38) then begin
                            EVALUATE(PropertyClass_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Property Class (Custom 1)", PropertyClass_var);
                        end else
                            FADeprBook."Property Class (Custom 1)" := FADeprBook."Property Class (Custom 1)"::" ";

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 39) then
                            FADeprBook.VALIDATE(Description, TempExcelBuffer."Cell Value as Text")
                        else
                            FADeprBook.Description := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 40) then begin
                            EVALUATE(MainAssComp_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Main Asset/Component", MainAssComp_var);
                        end else
                            FADeprBook."Main Asset/Component" := FADeprBook."Main Asset/Component"::" ";

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 41) then
                            FADeprBook.VALIDATE("Component of Main Asset", TempExcelBuffer."Cell Value as Text")
                        else
                            FADeprBook."Component of Main Asset" := '';

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 42) then begin
                            EVALUATE(FAddCurrFactor_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("FA Add.-Currency Factor", FAddCurrFactor_var);
                        end else
                            FADeprBook."FA Add.-Currency Factor" := 0;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 43) then begin
                            EVALUATE(UseHalfYearConvention_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Use Half-Year Convention", UseHalfYearConvention_var);
                        end;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 44) then begin
                            EVALUATE(UseDBFirstFiscalYear_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Use DB% First Fiscal Year", UseDBFirstFiscalYear_var);
                        end;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 45) then begin
                            EVALUATE(TempEndDate_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Temp. Ending Date", TempEndDate_var);
                        end else
                            FADeprBook."Temp. Ending Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 46) then begin
                            EVALUATE(TempFixedDeprAmount_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Temp. Fixed Depr. Amount", TempFixedDeprAmount_var);
                        end else
                            FADeprBook."Temp. Fixed Depr. Amount" := 0;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 47) then begin
                            EVALUATE(IgnoreDefEndingBookValue, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Ignore Def. Ending Book Value", IgnoreDefEndingBookValue);
                        end;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 48) then begin
                            EVALUATE(DefaultFADeprBook_var, TempExcelBuffer."Cell Value as Text");
                            FADeprBook.VALIDATE("Default FA Depreciation Book", DefaultFADeprBook_var);
                        end;

                        // BC UPGRADE PATELS08 >> # Replaced the following code snippet because of Drink-It field dependency
                        // if TempExcelBuffer.GET(TempExcelBuffer."Row No.",49) then begin
                        //   EVALUATE(LastDerogatoryDate_var,TempExcelBuffer."Cell Value as Text");
                        //   FADeprBook.VALIDATE("Last Derogatory Date",LastDerogatoryDate_var);
                        // end 
                        // else FADeprBook."Last Derogatory Date" := 0D;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 49) then
                            EVALUATE(LastDerogatoryDate_var, TempExcelBuffer."Cell Value as Text");
                        // BC UPGRADE PATELS08 <<

                        ImportedVersion := true;
                        FADeprBook.MODIFY();
                        Counter1 += 1;

                    end;
                end;
            until TempExcelBuffer.NEXT() = 0;
        end;
        Window.CLOSE();
    end;

    local procedure GetFileName(): Text[250];
    var
        CompanyInformation: Record "Company Information";
        FileName: Text[250];
    begin
        CompanyInformation.GET();
        ClientFileName := 'FA Upload ' +
          USERID + ' ' +
          GetFormattedDate(TODAY);

        exit(DELCHR(ClientFileName, '=', InvalidWindowsChrStringTxt));
    end;

    local procedure GetFormattedDate(ExportDate: Date): Text;
    begin
        if ExportDate <> 0D then
            exit(FORMAT(ExportDate, 10, '<Year4>-<Month,2>-<Day,2>'));
        exit('');
    end;

    // BC Upgrade PATELS08 >>
    local procedure InsertIntoExcelBook(SheetName: Text[250]; ReportHeader: Text[80]; CompanyName: Text[30]; UserID2: Text)
    begin
        if not BookCreated then begin
            TempExcelBuffer.CreateNewBook(SheetName);
            BookCreated := true;
        end else
            TempExcelBuffer.SelectOrAddSheet(SheetName);

        TempExcelBuffer.WriteSheet(ReportHeader, CompanyName, UserID2);
    end;

    local procedure DownloadExcel()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        FileName: Text;
    begin
        TempBlob.CreateOutStream(OutStr);
        TempExcelBuffer.SaveToStream(OutStr, true);

        TempBlob.CreateInStream(InStr);
        FileName := 'Report.xlsx';

        DownloadFromStream(InStr, '', '', '', FileName);
    end;
    // BC Upgrade PATELS08 <<
}

