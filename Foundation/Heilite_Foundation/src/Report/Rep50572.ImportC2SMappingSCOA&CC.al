report 50572 "Import C2S Mapping SCOA & CC"
{
    // version HEI.02
    // BC Upgrade Kamnay01 Original(Heilite) Table id 50572
    // HEI.01 IBM CHG2132673 BULIMC01 06/05/2022 #new report created to import the C2SName Allocation
    // HEI.02 CHG2190306 IBM SISUM01 08/02/2023 #add new option, Add New Line, in RequestPage and add new lines for theC2S Name that are not in the table
    //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // BC Upgrade KAPOOV01 12.11.2025 # Replaced functions OpenBook,SelectSheetsName with  OpenBookStream,SelectSheetsNameStream as these functions are defined OnPrem in Excel Buffer table.


    Caption = 'Import C2S Mapping SCOA & CC';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Tasks;

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
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Choose the operator: field.';
                }
                field(Control55009; '')
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the '''' field.';
                }
                field("Allocation Type"; '')
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the '''' field.';
                }
                field("General Overhead Costs:"; GenOverheadAllocType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GenOverheadAllocType field.';
                }
                field("Whse. Overhead Costs:"; WhseOverheadAllocType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the WhseOverheadAllocType field.';
                }
                field("Whse. Handling Costs:"; WhseHandlAllocType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the WhseHandlAllocType field.';
                }
                field(Control55013; '')
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the '''' field.';
                }
                field("Own Fleet"; '')
                {
                    Caption = 'Own Fleet';
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Own Fleet field.';
                }
                field("Distance Allocation %:"; DistanceAlloc)
                {
                    Caption = 'Distance Allocation %:';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Distance Allocation %: field.';
                }
                field("No. of Drops Allocation %:"; NoDropsAlloc)
                {
                    Caption = 'No. of Drops Allocation %:';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Drops Allocation %: field.';
                }
                field("Net Weight Allocation %:"; NetWeightAlloc)
                {
                    Caption = 'Net Weight Allocation %:';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net Weight Allocation %: field.';
                }
                field("Add New Lines"; AddNewLines)
                {
                    Caption = 'Add new Lines:';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Add new Lines: field.';
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
        GenOverheadAllocType := GenOverheadAllocType::"Net Weight (Kg)";
        WhseOverheadAllocType := WhseOverheadAllocType::"Net Weight (Kg)";
        WhseHandlAllocType := WhseHandlAllocType::"Picking Factor";
        AddNewLines := true; //HEI.02
    end;

    trigger OnPostReport();
    begin
        Window.CLOSE();

        if Imported then
            MESSAGE(Text50003)
        else
            MESSAGE(Text50004);

        TempWhseCostSetup.DELETEALL();
        TempExcelBuffer.DELETEALL();
    end;

    trigger OnPreReport();
    begin
        CheckOwnFleetAlloc();

        //HEI.02>>
        /*
        IF NOT CONFIRM(Text50000,TRUE) THEN
          CurrReport.QUIT;
        */
        if (not AddNewLines) then
            Answer := CONFIRM(Text50000, true);
        //HEI.02<<

        //HEI.02>>
        if Answer then begin
            //HEI.02<<
            DeleteExistingEntries();
            //HEI.02>>
            EntryNo := 1;
        end else begin
            if (not AddNewLines) then
                CurrReport.QUIT();
            if not CONFIRM(Text50005, true) then
                CurrReport.QUIT();
            if WhseCostAllocSetup.FINDLAST() then
                EntryNo := WhseCostAllocSetup."Entry No." + 1
            else
                EntryNo := 1;
        end;
        //HEI.02<<

        Window.OPEN(Text50002 + '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');

        ReadExcelSheet();
        AnalyzeData();
        InsertSetup();

    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        TempWhseCostSetup: Record "Whse. Cost Alloc Setup FND" temporary;
        WhseCostAllocSetup: Record "Whse. Cost Alloc Setup FND";
        FileMgt: Codeunit "File Management";
        AddNewLines: Boolean;
        Answer: Boolean;
        Imported: Boolean;
        DistanceAlloc: Decimal;
        NetWeightAlloc: Decimal;
        NoDropsAlloc: Decimal;
        Window: Dialog;
        //BC Upgrade KAPOOV01>>
        InStr: InStream;
        Counter: Integer;
        Counter1: Integer;
        EntryNo: Integer;
        NoOfProgresed: Integer;
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        RecNo: Integer;
        RowNo: Integer;
        TotalRecNo: Integer;
        ExcelFileExtensionTok: Label '.xlsx';
        FromFilter: Label 'Excel File (*.xlsx)|*.xlsx';
        Text50000: Label 'The import will delete the existing data. New setup will be created. Do you want to proceed?';
        Text50001: Label 'COGS SCOA Allocation';
        Text50002: Label 'Analyzing Data...\\';
        Text50003: Label 'Import successful!';
        Text50004: Label 'Nothing has been imported!';
        Text50005: Label 'The import will add new lines to the existing data. Do you want to proceed?';
        GenOverheadAllocType: Option " ","Picking Factor","Net Weight (Kg)";
        WhseHandlAllocType: Option " ","Picking Factor","Net Weight (Kg)";
        WhseOverheadAllocType: Option " ","Picking Factor","Net Weight (Kg)";
        CCOperator: Option "??","*";
        TransType: Option Export,Import;
        ClientFileName: Text;
        FileName: Text;
        ServerFileName: Text;
        SheetName: Text[250];
        TimeProgress: Time;
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
        C2SNameOption: Option " ","Warehouse Handling Costs (Variable)","Warehouse Overhead Costs (Fixed)","General Overhead Costs (Fixed)","Delivery To Customers","Own Fleet","Whse Hand. Costs (Variable) OVE","Whse Hand. Costs (Variable) Transp. Exp.","Whse Hand. Costs (Variable) Fixed Exp.";
        DistType: Option Primary,Secondary;
        CostCenterCode: Text;
        SCOA: Text;
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
                    if TempExcelBuffer."Row No." <> OldRowNo then begin
                        CLEAR(SCOA);
                        CLEAR(C2SNameOption);
                        CLEAR(CostCenterCode);
                        CLEAR(DistType);

                        //SCOA
                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 1) then
                            SCOA := TempExcelBuffer."Cell Value as Text" + '*|';

                        //CCC code
                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 2) then
                            if TempExcelBuffer."Cell Value as Text" <> '' then
                                CostCenterCode := FORMAT(CCOperator) + TempExcelBuffer."Cell Value as Text" + FORMAT(CCOperator);

                        //C2SName
                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 3) then
                            EVALUATE(C2SNameOption, TempExcelBuffer."Cell Value as Text");

                        //Distribution Type
                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 4) then
                            EVALUATE(DistType, TempExcelBuffer."Cell Value as Text");

                        //HEI.02>>
                        WhseCostAllocSetup.SETFILTER("C2S Name", '%1', C2SNameOption);
                        if not WhseCostAllocSetup.FINDFIRST() then begin
                            //HEI.02<<

                            TempWhseCostSetup.RESET();
                            TempWhseCostSetup.SETRANGE("CCC Dim. Filter", CostCenterCode);
                            TempWhseCostSetup.SETRANGE("C2S Name", C2SNameOption);
                            TempWhseCostSetup.SETRANGE("Distribution Type", DistType);
                            TempWhseCostSetup.SETFILTER("Period Cost", '<=%1', MAXSTRLEN(TempWhseCostSetup."G/L Account Range") - 10);
                            if not TempWhseCostSetup.FINDFIRST() then begin
                                TempWhseCostSetup.INIT();
                                //HEI.02>>
                                //TempWhseCostSetup."Entry No." := FindEntryNo(TempWhseCostSetup);
                                TempWhseCostSetup."Entry No." := EntryNo;
                                EntryNo += 1;
                                //HEI.02<<
                                TempWhseCostSetup."CCC Dim. Filter" := CostCenterCode;
                                TempWhseCostSetup."C2S Name" := C2SNameOption;
                                TempWhseCostSetup."Distribution Type" := DistType;
                                TempWhseCostSetup."G/L Account Range" := SCOA;
                                TempWhseCostSetup."Period Cost" := STRLEN(TempWhseCostSetup."G/L Account Range"); //count the length of GL Account range
                                if C2SNameOption = C2SNameOption::"Own Fleet" then begin
                                    TempWhseCostSetup."Distance Allocation %" := DistanceAlloc;
                                    TempWhseCostSetup."No. of Drops Allocation %" := NoDropsAlloc;
                                    TempWhseCostSetup."Net Weight Allocation %" := NetWeightAlloc;
                                end else begin
                                    TempWhseCostSetup."Distance Allocation %" := 0;
                                    TempWhseCostSetup."No. of Drops Allocation %" := 0;
                                    TempWhseCostSetup."Net Weight Allocation %" := 0;
                                end;

                                //Allocation Type
                                if C2SNameOption = C2SNameOption::"General Overhead Costs (Fixed)" then
                                    TempWhseCostSetup."Allocation Type" := GenOverheadAllocType
                                else if C2SNameOption = C2SNameOption::"Warehouse Handling Costs (Variable)" then
                                    TempWhseCostSetup."Allocation Type" := WhseHandlAllocType
                                else if C2SNameOption = C2SNameOption::"Warehouse Overhead Costs (Fixed)" then
                                    TempWhseCostSetup."Allocation Type" := WhseOverheadAllocType
                                else
                                    TempWhseCostSetup."Allocation Type" := TempWhseCostSetup."Allocation Type"::" ";

                                TempWhseCostSetup.INSERT();
                            end else begin
                                TempWhseCostSetup."G/L Account Range" += SCOA;
                                TempWhseCostSetup."Period Cost" := STRLEN(TempWhseCostSetup."G/L Account Range");
                                TempWhseCostSetup.MODIFY();
                            end;
                        end; //HEI.02
                    end;
                end;
            until TempExcelBuffer.NEXT() = 0;
        end;
    end;

    local procedure InsertSetup();
    begin
        TempWhseCostSetup.RESET();
        if TempWhseCostSetup.findset() then
            repeat
                WhseCostAllocSetup.RESET();
                WhseCostAllocSetup.SETRANGE("C2S Name", TempWhseCostSetup."C2S Name");
                WhseCostAllocSetup.SETRANGE("Distribution Type", TempWhseCostSetup."Distribution Type");
                WhseCostAllocSetup.SETRANGE("G/L Account Range", DELSTR(TempWhseCostSetup."G/L Account Range", STRLEN(TempWhseCostSetup."G/L Account Range")));
                if not WhseCostAllocSetup.FINDFIRST() then begin
                    WhseCostAllocSetup.INIT();
                    WhseCostAllocSetup.TRANSFERFIELDS(TempWhseCostSetup);
                    WhseCostAllocSetup."G/L Account Range" := DELSTR(TempWhseCostSetup."G/L Account Range", STRLEN(TempWhseCostSetup."G/L Account Range"));
                    WhseCostAllocSetup.INSERT();
                end else begin
                    WhseCostAllocSetup."CCC Dim. Filter" += '|' + TempWhseCostSetup."CCC Dim. Filter";
                    WhseCostAllocSetup.MODIFY();
                end;
                Imported := true;
            until TempWhseCostSetup.NEXT() = 0;
    end;

    local procedure FindEntryNo(var TempWhseCostAlloc: Record "Whse. Cost Alloc Setup FND" temporary): Integer;
    begin
        TempWhseCostAlloc.RESET();
        if not TempWhseCostAlloc.FINDLAST() then
            exit(1)
        else
            exit(TempWhseCostAlloc."Entry No." + 1);
    end;

    local procedure DeleteExistingEntries();
    begin
        WhseCostAllocSetup.RESET();
        if not WhseCostAllocSetup.ISEMPTY then
            WhseCostAllocSetup.DELETEALL();

        TempExcelBuffer.DELETEALL();
    end;

    local procedure CheckOwnFleetAlloc();
    var
        Text001: Label 'Total Allocation % must be 100%.';
    begin
        if (DistanceAlloc + NoDropsAlloc + NetWeightAlloc <> 100) and (DistanceAlloc + NoDropsAlloc + NetWeightAlloc <> 0) then
            ERROR(Text001);
    end;
}

