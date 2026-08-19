report 55038 "Dim. Value Comb. Ins Or Del"
{
    // version HEI.03

    // HEI.01 CHG2131424 IBM SISUM01 09/06/2023 HB2520 Dimension Validation HeiLite
    //   #create new object
    // HEI.02 CHG2219620 IBM SISUM01 12/09/2023 Code Optimizations for Report  Dim. Value Comb. Ins Or Del
    //   #code change in CreateDimValueComb function
    // HEI.03 CHG2221449 IBM SISUM01 26/09/2023  Apply Commit command every 1.000.000 rows to clear the Database transaction logs
    //   #code change in CreateDimValueComb function

    // BC Upgrade KUMARR78 >>
    // Report Name : Dim. Value Comb. Ins Or Del
    // Report ID   : 50583
    // 1. Added ApplicationArea property at report level.
    //    Old:
    //         - ApplicationArea property was not defined in NAV.
    //    New:
    //         - ApplicationArea = All;
    //         - Ensures feature visibility compliance in Business Central.
    //
    // 2. Added UsageCategory property at report level.
    //    Old:
    //         - UsageCategory property was not defined in NAV.
    //    New:
    //         - UsageCategory = ReportsAndAnalysis;
    //         - Makes the report searchable via Tell Me in BC.
    //
    // 3. Added ApplicationArea property to all request page fields.
    //    Old:
    //         - Request page fields did not have ApplicationArea defined.
    //    New:
    //         - ApplicationArea = All added to:
    //             • Import/Export From
    //             • Import/Export Option
    //             • WorkBook File Name
    //             • Worksheet Name
    //             • Dimension Code 1
    //             • Dimension Code 2
    //             • Export To
    //             • Import File Name
    //         - Required for BC UI visibility compliance.
    //
    // 4. Replaced FileMgt.UploadFile with File.UploadIntoStream.
    //    Old:
    //         - FileMgt.UploadFile(...) used (not supported in SaaS).
    //    New:
    //         - File.UploadIntoStream(..., InStr);
    //         - Compatible with Business Central SaaS (stream-based file handling).
    //
    // 5. Replaced ExcelBuffer.OpenBook with OpenBookStream.
    //    Old:
    //         - TempExcelBuffer.OpenBook(FileName, SheetName);
    //    New:
    //         - TempExcelBuffer.OpenBookStream(InStr, SheetName);
    //         - Required for SaaS where file paths are not accessible.
    //
    // 6. Replaced SelectSheetsName with SelectSheetsNameStream.
    //    Old:
    //         - TempExcelBuffer.SelectSheetsName(FileName);
    //    New:
    //         - TempExcelBuffer.SelectSheetsNameStream(InStr);
    //         - Stream-based sheet selection for BC SaaS compatibility.
    //
    // 7. Removed ServerTempFileName usage.
    //    Old:
    //         - FileMgt.ServerTempFileName('txt');
    //    New:
    //         - Code commented as ServerTempFileName is removed in BC.
    //         - Avoids unsupported server file system access.
    //
    // 8. Removed SaveFileDialog usage.
    //    Old:
    //         - FileMgt.SaveFileDialog(...);
    //    New:
    //         - Code commented as SaveFileDialog is not supported in BC SaaS.
    //         - File path handling removed.
    //
    // 9. Removed client/server file path validations.
    //    Old:
    //         - Direct file path validation and ERROR(FileError).
    //    New:
    //         - Code commented as file paths are not used in BC SaaS.
    //
    // 10. Blocked unused ExportDimValueComb function.
    //     Old:
    //          - ExportDimValueComb() used File system operations (CREATE, MOVE, DownloadTempFile).
    //     New:
    //          - Entire function commented.
    //          - Prevents unsupported file system operations in SaaS.
    //          - Keeps report upgrade-safe.
    //
    // 11. Introduced InStream variable for file handling.
    //     Old:
    //          - FileName based file handling.
    //     New:
    //          - InStr: InStream used for Excel processing.
    //          - Required for BC cloud compatibility.
    // BC Upgrade KUMARR78 <<

    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding UsageCategory
    Caption = 'Dim. Value Comb. Ins Or Del';
    Permissions = tabledata "Dimension Value Combination" = rimd;
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field("Import/Export From"; '')
                {
                    ApplicationArea = All; //BC UPGRDAE KUMARR78 Adding ApplicationArea
                    Caption = 'Import/Export From';
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Import/Export Option"; ImportExport)
                {
                    ApplicationArea = All; //BC UPGRDAE KUMARR78 Adding ApplicationArea
                    trigger OnValidate();
                    begin
                        case ImportExport of
                            /*
                            ImportExport::"Export combinations":
                              BEGIN
                                CtrlUnblockImpEnable  := FALSE;
                                CtrlExportEnable      := TRUE;
                              END;
                            */
                            ImportExport::"Insert all dimension comb for block":
                                CtrlUnblockImpEnable := false;

                            ImportExport::"Delete unblocked dimension combination":
                                CtrlUnblockImpEnable := true;
                        end;

                    end;
                }
                field("WorkBook File Name"; FileName)
                {
                    CaptionML = ENU = 'Workbook File Name Unblocked Dim Comb',
                                NLD = 'Werkmapbestandsnaam';
                    Enabled = CtrlUnblockImpEnable;
                    ApplicationArea = All; //BC UPGRDAE KUMARR78 Adding ApplicationArea

                    trigger OnAssistEdit();
                    begin
                        // BC Upgrade KUMARR78 >>
                        // FileName := FileMgt.UploadFile(Text006, ExcelFileExtensionTok);
                        File.UploadIntoStream(Text50000, '', FromFilter, FileName, InStr);
                        // BC Upgrade KUMARR78 <<
                    end;
                }
                field("Worksheet Name"; SheetName)
                {
                    CaptionML = ENU = 'Worksheet Name Unblocked Dim Comb',
                                NLD = 'Werkbladnaam';
                    Enabled = CtrlUnblockImpEnable;
                    ApplicationArea = All; //BC UPGRDAE KUMARR78 Adding ApplicationArea

                    trigger OnAssistEdit();
                    begin

                        // BC Upgrade KUMARR78 >>
                        // SheetName := TempExcelBuffer.SelectSheetsName(FileName);
                        SheetName := TempExcelBuffer.SelectSheetsNameStream(InStr);
                        // BC Upgrade KUMARR78 <<


                    end;
                }
                field("Dimension Code 1"; DimCode1)
                {
                    Caption = 'Dimension Code 1 Unblocked Dim Comb';
                    DrillDown = false;
                    Enabled = CtrlUnblockImpEnable;
                    Lookup = true;
                    LookupPageId = Dimensions;
                    TableRelation = Dimension.Code;
                    ApplicationArea = All; //BC UPGRDAE KUMARR78 Adding ApplicationArea
                }
                field("Dimension Code 2"; DimCode2)
                {
                    Caption = 'Dimension Code 2 Unblocked Dim Comb';
                    Enabled = CtrlUnblockImpEnable;
                    Lookup = true;
                    LookupPageId = Dimensions;
                    TableRelation = Dimension.Code;
                    ApplicationArea = All; //BC UPGRDAE KUMARR78 Adding ApplicationArea
                }
                field("Export To"; FilePath)
                {
                    Caption = 'Export Dimension Value Comb To';
                    Enabled = CtrlExportEnable;
                    Visible = false;
                    ApplicationArea = All; //BC UPGRDAE KUMARR78 Adding ApplicationArea

                    trigger OnAssistEdit();
                    begin

                        ExportFileName := 'DimValueComb' + '_' + CompanyName + '_' + Format(Today, 0, '<Day,2><Month,2><Year>') + Format(Time, 0, '<Hours24,2><Filler Character,0><Minutes,2>');

                        //BC Upgrade KUMARR78 >> commented ServerTempFileName as it is removed in BC
                        //ExportServerFileName := FileMgt.ServerTempFileName('txt');
                        //BC Upgrade KUMARR78 << commented ServerTempFileName as it is removed in BC

                        ExportFileName := 'DimValueComb' + '_' + COMPANYNAME + '_' + FORMAT(TODAY, 0, '<Day,2><Month,2><Year>') + FORMAT(TIME, 0, '<Hours24,2><Filler Character,0><Minutes,2>');

                        //BC Upgrade KUMARR78 >> SaveFileDialog it is removed in BC
                        //FilePath := FileMgt.SaveFileDialog(WindowTitle, ExportFileName, 'Flat File (*.txt)|*.txt')
                        //BC Upgrade KUMARR78 << SaveFileDialog  it is removed in BC

                        //BC Upgrade KUMARR78 >> commented below code as filepaths not used in BC
                        // if (FilePath = '') then
                        //     ERROR(FileError);
                        //BC Upgrade KUMARR78 << commented below code as filepaths not used in BC

                    end;
                }
                field("Import File Name"; ImportBlockedFileName)
                {
                    CaptionML = ENU = 'File Name Blocked Dim Comb',
                                NLD = 'Werkmapbestandsnaam';
                    Enabled = CtrlUnblockImpEnable;
                    Visible = false;
                    ApplicationArea = All; //BC UPGRDAE KUMARR78 Adding ApplicationArea

                    trigger OnAssistEdit();
                    begin

                        // BC Upgrade KUMARR78 >>
                        //  ImportBlockedFileName := FileMgt.UploadFile(Text50003, FlatFileExtension);
                        File.UploadIntoStream(Text50003, '', FlatFileExtension, FileName, InStr);
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

    trigger OnInitReport();
    begin
        ImportExport := ImportExport::"Insert all dimension comb for block";
        CtrlUnblockImpEnable := false;
        CtrlExportEnable := true;
    end;

    trigger OnPreReport();
    begin

        case ImportExport of
            ImportExport::"Delete unblocked dimension combination":
                begin
                    if (DimCode1 = '') or (DimCode2 = '') then
                        Error(Text50001);
                    if GuiAllowed then
                        Window.Open(Text50002 + '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
                    ReadExcelSheet();
                    AnalyzeData();
                end;
            ImportExport::"Insert all dimension comb for block":
                begin

                    if GuiAllowed then begin
                        Window.Open('Insert data: ' + '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
                        Window.Update(1, 0);
                        RecNo := 1;
                        Counter1 := 0;
                    end;

                    TimeStart := Time;

                    DimValue.SetRange("Dimension Code", 'BRAND');
                    CartesianProduct := DimValue.Count();
                    DimValue.SetRange("Dimension Code", 'LINE_EXT');
                    //HEI.02>>
                    //CartesianProduct := CartesianProduct * DimValue.COUNT();
                    CountLineExtDimValue := DimValue.Count();
                    CartesianProduct := CartesianProduct * CountLineExtDimValue;
                    /*
                    WHILE i < CartesianProduct DO
                      BEGIN
                        CreateDimValueComb();
                      END;
                    */
                    CreateDimValueComb();
                    //HEI.02<<
                    Message('Start Time %1 - End Time %2', TimeStart, Time);
                end;
        /*
        ImportExport::"Export combinations":
          BEGIN
            TimeStart := TIME;
            IF GUIALLOWED THEN BEGIN
              Window.OPEN('Export dimenison combination values: ' + '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
              Window.UPDATE(1,0);
              RecNo := 1;
              Counter1 := 0;
            END;

            ExportDimValueComb();
            MESSAGE('Start Time %1 - End Time %2',TimeStart, TIME);

          END;
        */
        end;

    end;

    var
        // BC Upgrade KUMARR78 <<
        DimValue: Record "Dimension Value";
        DimensionValueComb: Record "Dimension Value Combination";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        NameValueBuffer: Record "Name/Value Buffer";
        FileMgt: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        CtrlExportEnable: Boolean;
        CtrlUnblockImpEnable: Boolean;
        DimCode1: Code[10];
        DimCode2: Code[10];
        DimCodeValue1: Code[20];
        DimCodeValue2: Code[20];
        Window: Dialog;
        DimValueCombFile: File;
        // BC Upgrade KUMARR78 >>
        InStr: InStream;
        CartesianProduct: Integer;
        Counter: Integer;
        Counter1: Integer;
        CountLineExtDimValue: Integer;
        i: Integer;
        j: Integer;
        NoOfProgresed: Integer;
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        RecNo: Integer;
        RowNo: Integer;
        SetNo: Integer;
        TotalRecNo: Integer;
        ExcelFileExtensionTok: Label '.xlsx';
        FileError: Label 'File must not be empty';
        FlatFileExtension: Label '.txt';
        FromFilter: Label 'Excel File (*.xlsx)|*.xlsx';
        Text50000: Label 'Unblock Dimension Value Combination';
        Text50001: Label 'Dimension Code 1 and Dimension Code 2 must not be blank.';
        Text50002: Label 'Analyzing Data...\\';
        Text50003: Label 'Insert Blocked Dimension Value Combination';
        WindowTitle: Label '"Export to flat file "';
        ImportExport: Option "Insert all dimension comb for block","Delete unblocked dimension combination";
        OutStr: OutStream;
        OutStreamObj: OutStream;
        ClientFileName: Text;
        DirectoryName: Text;
        ExportFileName: Text;
        ExportServerFileName: Text;
        FileName: Text;
        ImportBlockedFileName: Text;
        ServerFileName: Text;
        FilePath: Text[250];
        SheetName: Text[250];
        TimeProgress: Time;
        TimeStart: Time;

    procedure ReadExcelSheet();
    begin
        //BC Upgrade KUMARR78 >>
        //TempExcelBuffer.OpenBook(FileName, SheetName);
        TempExcelBuffer.OpenBookStream(InStr, SheetName);
        //BC Upgrade KUMARR78 <<
        TempExcelBuffer.ReadSheet();
    end;

    procedure AnalyzeData();
    var
        HeaderRowNo: Integer;
        OldRowNo: Integer;
    begin
        if GuiAllowed then begin
            Window.Update(1, 0);
            TotalRecNo := TempExcelBuffer.Count;
            RecNo := 1;
            Counter1 := 0;
        end;

        if TempExcelBuffer.Find('-') then begin
            HeaderRowNo := RecNo;
            repeat
                if GuiAllowed then begin
                    RecNo := RecNo + 1;
                    Window.Update(1, Round(RecNo / TotalRecNo * 10000, 1));
                end;
                if (TempExcelBuffer."Row No." > HeaderRowNo) and (HeaderRowNo > 0) then begin
                    Clear(DimCodeValue1);
                    Clear(DimCodeValue2);

                    if TempExcelBuffer.Get(TempExcelBuffer."Row No.", 1) then
                        DimCodeValue1 := TempExcelBuffer."Cell Value as Text";

                    if TempExcelBuffer.Get(TempExcelBuffer."Row No.", 2) then
                        DimCodeValue2 := TempExcelBuffer."Cell Value as Text";

                    if DimensionValueComb.Get(DimCode1, DimCodeValue1, DimCode2, DimCodeValue2) then
                        DimensionValueComb.Delete();
                end;
            until TempExcelBuffer.Next() = 0;
        end;

        //HEI.02>>
        if GuiAllowed then begin
            Window.Close();
            Message('Update is finished (deleting the records that are allowed)');
        end;
        //HEI.02<<
    end;

    local procedure CreateDimValueComb();
    var
        DimensionValueComb: Record "Dimension Value Combination";
        lQueryBlockedComb: Query "Dim. Value Comb. List To Block";
    begin
        //query tehnical solution

        //HEI.02>>
        /*
        IF DimCode1 <> '' THEN
          lQueryBlockedComb.SETFILTER(Code_Filter,'>%1',DimCode1);//to be doblecheck
        */
        //HEI.02<<

        lQueryBlockedComb.OPEN;
        while lQueryBlockedComb.READ do begin
            //HEI.02>>
            /*
            IF GUIALLOWED THEN BEGIN
              RecNo := RecNo + 1;
              Window.UPDATE(1,ROUND(RecNo / CartesianProduct * 10000,1));
            END;
            */
            //HEI.02<<
            DimensionValueComb."Dimension 1 Code" := lQueryBlockedComb.Dimension_Code_BRAND;
            DimensionValueComb."Dimension 1 Value Code" := lQueryBlockedComb.Code_BRAND;
            DimensionValueComb."Dimension 2 Code" := lQueryBlockedComb.Dimension_Code_LINE_EXT;
            DimensionValueComb."Dimension 2 Value Code" := lQueryBlockedComb.Code_LINE_EXT;
            DimensionValueComb.Insert();

            //HEI.02>>
            //i += 1;
            RecNo += 1;
            //HEI.02<<

            SetNo += 1;
            //HEI.02>>
            //IF (SetNo = 100 * DimValue.COUNT()) THEN BEGIN
            if (SetNo > 1000000) then begin
                //HEI.02<<
                Commit(); //HEI.03

                SetNo := 0;

                //HEI.02>>
                if GuiAllowed then
                    Window.Update(1, Round(RecNo / CartesianProduct * 10000, 1));
                //DimCode1 := lQueryBlockedComb.Code_BRAND;
                //lQueryBlockedComb.CLOSE;
                //EXIT;
                //HEI.02<<
            end;

        end;
        lQueryBlockedComb.CLOSE;

    end;

    local procedure CreateDimValueCombVers2();
    var
        DimensionValueComb: Record "Dimension Value Combination";
        DimensionValueCombTmp: Record "Dimension Value Combination" temporary;
        lQueryBlockedComb: Query "Dim. Value Comb. List To Block";
    begin
        //use tmp table var and then transfer data to physical table

        if DimensionValueCombTmp.IsEmpty then begin
            lQueryBlockedComb.OPEN;
            while lQueryBlockedComb.READ do begin
                if GuiAllowed then begin
                    RecNo := RecNo + 1;
                    Window.Update(1, Round(RecNo / CartesianProduct * 10000, 1));
                end;
                DimensionValueCombTmp."Dimension 1 Code" := lQueryBlockedComb.Dimension_Code_BRAND;
                DimensionValueCombTmp."Dimension 1 Value Code" := lQueryBlockedComb.Code_BRAND;
                DimensionValueCombTmp."Dimension 2 Code" := lQueryBlockedComb.Dimension_Code_LINE_EXT;
                DimensionValueCombTmp."Dimension 2 Value Code" := lQueryBlockedComb.Code_LINE_EXT;
                DimensionValueCombTmp.Insert();
            end;
            lQueryBlockedComb.CLOSE;
        end;


        RecNo := 0;

        if DimensionValueCombTmp.FindSet(false) then
            repeat
                if GuiAllowed then begin
                    RecNo := RecNo + 1;
                    Window.Update(1, Round(RecNo / CartesianProduct * 10000, 1));
                end;
                DimensionValueComb.Init();
                DimensionValueComb.TransferFields(DimensionValueCombTmp);
                DimensionValueComb.Insert(true);
                i += 1;
            until DimensionValueCombTmp.Next() = 0;
    end;

    local procedure CreateDimValueCombVers3();
    var
        DimensionValue1: Record "Dimension Value";
        DimensionValue2: Record "Dimension Value";
        DimensionValueComb: Record "Dimension Value Combination";
    begin
        //repeat in repeat

        if DimCode1 <> '' then
            DimensionValue1.SetFilter(Code, '>%1', DimCode1);
        DimensionValue1.SetRange("Dimension Code", 'BRAND');
        if DimensionValue1.FindSet(false) then
            repeat
                DimensionValue2.SetRange("Dimension Code", 'LINE_EXT');
                if DimensionValue2.FindSet(false) then
                    repeat
                        if GuiAllowed then begin
                            RecNo := RecNo + 1;
                            Window.Update(1, Round(RecNo / CartesianProduct * 10000, 1));
                        end;
                        DimensionValueComb."Dimension 1 Code" := DimensionValue1."Dimension Code";
                        DimensionValueComb."Dimension 1 Value Code" := DimensionValue1.Code;
                        DimensionValueComb."Dimension 2 Code" := DimensionValue2."Dimension Code";
                        DimensionValueComb."Dimension 2 Value Code" := DimensionValue2.Code;
                        DimensionValueComb.Insert();
                    until DimensionValue2.Next() = 0;
                SetNo += 1;
                if SetNo = 100 then begin
                    //HEI.02>>
                    //i += SetNo * DimValue.COUNT();
                    i += SetNo * CountLineExtDimValue;
                    //HEI.02<<
                    SetNo := 0;
                    DimCode1 := DimensionValue1.Code;
                    exit;
                end;
            until DimensionValue1.Next() = 0;
    end;

    //BC UPGRADE KUMARR78 >>Blocking As Function is not being used in Report
    // local procedure ExportDimValueComb();
    // var
    //     lQueryBlockedComb: Query "Dim. Value Comb. List To Block";
    //     IsOpen: Boolean;
    // begin
    //     i := 0;

    //     while i < CartesianProduct do begin

    //         if DimCode1 <> '' then
    //             lQueryBlockedComb.SETFILTER(Code_Filter, '>%1', DimCode1);
    //         lQueryBlockedComb.OPEN;
    //         while lQueryBlockedComb.READ do begin
    //             if GuiAllowed then begin
    //                 RecNo := RecNo + 1;
    //                 Window.Update(1, Round(RecNo / CartesianProduct * 10000, 1));
    //             end;
    //             if (SetNo = 0) then begin
    //                 j += 1;
    //                 DimValueCombFile.CREATE(ExportServerFileName);
    //                 DimValueCombFile.CREATEOUTSTREAM(OutStreamObj);
    //                 IsOpen := true;
    //             end else
    //                 OutStreamObj.WriteText();
    //             OutStreamObj.WRITETEXT(lQueryBlockedComb.Dimension_Code_BRAND + ';');
    //             OutStreamObj.WRITETEXT(lQueryBlockedComb.Code_BRAND + ';');
    //             OutStreamObj.WRITETEXT(lQueryBlockedComb.Dimension_Code_LINE_EXT + ';');
    //             OutStreamObj.WRITETEXT(lQueryBlockedComb.Code_LINE_EXT);
    //             i += 1;
    //             SetNo += 1;
    //             if (SetNo = 3000 * DimValue.Count()) then begin
    //                 //i := 84000000;
    //                 SetNo := 0;
    //                 DimCode1 := lQueryBlockedComb.Code_BRAND;
    //                 lQueryBlockedComb.CLOSE;
    //                 DimValueCombFile.CLOSE;
    //                 ClientFileName := FileMgt.DownloadTempFile(ExportServerFileName);
    //                 DirectoryName := FileMgt.GetDirectoryName(FilePath);
    //                 FileName := Format(j) + '_' + DelChr(CopyStr(FilePath, StrLen(DirectoryName) + 1), '=', '\');
    //                 FileMgt.MoveAndRenameClientFile(ClientFileName, FileName, DirectoryName);
    //                 IsOpen := false;
    //                 break;
    //             end;
    //         end;
    //     end;

    //     if IsOpen then begin
    //         lQueryBlockedComb.CLOSE;
    //         DimValueCombFile.CLOSE;

    //         ClientFileName := FileMgt.DownloadTempFile(ExportServerFileName);
    //         DirectoryName := FileMgt.GetDirectoryName(FilePath);
    //         FileName := Format(j) + '_' + DelChr(CopyStr(FilePath, StrLen(DirectoryName) + 1), '=', '\');
    //         FileMgt.MoveAndRenameClientFile(ClientFileName, FileName, DirectoryName);
    //     end;
    // end;
    //BC UPGRADE KUMARR78 <<Blocking As Function is not being used in Report
}

