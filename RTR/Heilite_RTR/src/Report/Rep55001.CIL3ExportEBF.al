report 55001 "CIL3 Export - EBF RTR"
{
    // version HEI.05

    // HEI.02 FDD-BPMGAP014 IBM ISYED01 08.10.2017
    //   #Migrated Report Export CIL1 from HEI2.0 to Base.
    // 
    // HEI.03 DEFECT895 IBM ISYED01 03/11/2017
    //   #The field "Posting Heineken" is not needed. It was replaced by the field "Financial statement version".
    //   #The reports should include the GL Accounts with the values "Heineken" and "Common"
    // 
    // HEI.04 FDD-BPMGAP014 IBM NASTAA02 07.12.2017 # CIL Reporting Package
    //   # Column "Trading Partner" should be filled in with the "Reporting Entity" from Dimension Values
    // 
    // HEI.05 Defect #1378 IBM NASTAA02 16.01.2018 # Intercompany flat file to CIL - amount
    //   # The Amount "Value in Local Currency" should be generated with 2 decimals
    // HEI.06 CHG2078875 IBM BULIMC01 25/08/2020 #clear the Trading Partner values for all the GL Accounts
    //Bc Upgrade YADAVM09,28.04.26 PID-475, PID-503, PID-504, PID-505, PID-535, PID-536, PID-537, PID-758GAP ID: IBM GAP RTR 09.


    Caption = 'CIL3 Export - EBF';//Bc Upgrade YADAVM09,28.04.26<<
    ProcessingOnly = true;
    // ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

            trigger OnAfterGetRecord();
            begin
                AnalysisView.GET(CurrentAnalysisViewCode);
                if ShowActualBudget = ShowActualBudget::"Actual Amounts" then begin
                    if InclOpening then processOBaccountfilter();
                    if Datefilter <> '' then
                        AnalysisViewEntry.SETFILTER("Posting Date", Datefilter);
                    processaccountfilter();
                end
                else begin
                    if InclOpening then processOBaccountfilterBudget();
                    if Datefilter <> '' then
                        AnalysisViewBudgetEntry.SETFILTER("Posting Date", Datefilter);
                    processaccountfilterBudget();
                end;


                // FleCIL3.CREATE(ServerFileName);//BC Upgrade YADAVM09 Temp Blocked
                // FleCIL3.TEXTMODE := true;//BC Upgrade YADAVM09 Temp Blocked
                //BC Upgrade YADAVM09>>
                // if TempCil3Buffer.FINDSET() then begin
                //      FleCIL3.TEXTMODE := true;
                //     FleRecord := 'Reporting entity' + FORMAT(TabChar);
                //     FleRecord += 'Data Version' + FORMAT(TabChar);
                //     FleRecord += 'Calendar Month/Year' + FORMAT(TabChar);
                //     FleRecord += 'Business type' + FORMAT(TabChar);
                //     FleRecord += 'Group Account' + FORMAT(TabChar);

                //     FleRecord += 'Local Cost Center' + FORMAT(TabChar);
                //     FleRecord += 'Trading partner' + FORMAT(TabChar);
                //     FleRecord += 'Value in Local Currency';
                //     //FleCIL3.WRITE(FleRecord);//BC Upgrade YADAVM09 Temp Blocked
                //     repeat
                //         FleRecord := CompanyInfo."Reporting Entity" + FORMAT(TabChar);
                //         FleRecord += TempCil3Buffer."Data Version" + FORMAT(TabChar);
                //         FleRecord += TempCil3Buffer.Period + TempCil3Buffer.Year + FORMAT(TabChar);
                //         FleRecord += TempCil3Buffer."Business Type" + FORMAT(TabChar);
                //         FleRecord += TempCil3Buffer."Group Account" + FORMAT(TabChar);
                //         FleRecord += TempCil3Buffer."Movement Type" + FORMAT(TabChar);
                //         FleRecord += TempCil3Buffer."Trading Partner" + FORMAT(TabChar);
                //         //HEI.05>>
                //         //FleRecord += (FORMAT(FormatAmount(TempCil3Buffer.Quantity),20,'<Precision,5:5><Standard Format,1>'));
                //         FleRecord += (FORMAT(FormatAmount(TempCil3Buffer.Quantity), 20, '<Precision,2:2><Standard Format,1>'));
                //     //HEI.05<<
                //     // FleCIL3.WRITE(FleRecord);//BC Upgrade YADAVM09 Temp Blocked
                //     until TempCil3Buffer.NEXT() = 0;
                // end;

                // MESSAGE(Text005);
                //BC Upgrade YADAVM09<<

                // #BCUP0-103 BC Upgrade KAIRAR01 >>
                if TempCil3Buffer.FindSet() then begin
                    if not HeaderWritten then begin
                        FleRecord := 'Reporting entity' + FORMAT(TabChar);
                        FleRecord += 'Data Version' + FORMAT(TabChar);
                        FleRecord += 'Calendar Month/Year' + FORMAT(TabChar);
                        FleRecord += 'Business type' + FORMAT(TabChar);
                        FleRecord += 'Group Account' + FORMAT(TabChar);
                        FleRecord += 'Local Cost Center' + FORMAT(TabChar);
                        FleRecord += 'Trading partner' + FORMAT(TabChar);
                        FleRecord += 'Value in Local Currency';
                        TxtBuilder.AppendLine(FleRecord);
                        HeaderWritten := true;
                    end;
                    repeat
                        FleRecord := CompanyInfo."Reporting Entity FND" + FORMAT(TabChar);
                        FleRecord += TempCil3Buffer."Data Version" + FORMAT(TabChar);
                        FleRecord += TempCil3Buffer.Period + TempCil3Buffer.Year + FORMAT(TabChar);
                        FleRecord += TempCil3Buffer."Business Type" + FORMAT(TabChar);
                        FleRecord += TempCil3Buffer."Group Account" + FORMAT(TabChar);
                        FleRecord += TempCil3Buffer."Movement Type" + FORMAT(TabChar);
                        FleRecord += TempCil3Buffer."Trading Partner" + FORMAT(TabChar);
                        FleRecord += (FORMAT(FormatAmount(TempCil3Buffer.Quantity), 20, '<Precision,2:2><Standard Format,1>'));
                        TxtBuilder.AppendLine(FleRecord);
                    until TempCil3Buffer.Next() = 0;
                end;
                // #BCUP0-103 BC Upgrade KAIRAR01 <<
            end;

            trigger OnPreDataItem();
            begin
                CompanyInfo.GET();
                if (ShowActualBudget <> 0) and (ShowActualBudget <> 1) then
                    ERROR(Text000);

                // if ServerFileName = '' then ERROR(Text001);////Bc Upgrade YADAVM09,28.04.26<<

                // if EXISTS(ServerFileName) then//BC Upgrade YADAVM09 Temp Blocked
                //   if CONFIRM(Text003,false) then ERASE(ServerFileName);//BC Upgrade YADAVM09 Temp Blocked

                TabChar := 9;

                if ShowActualBudget = ShowActualBudget::"Actual Amounts" then begin
                    AnalysisViewEntry.SETRANGE("Analysis View Code", CurrentAnalysisViewCode);
                    if Datefilter <> '' then
                        AnalysisViewEntry.SETFILTER("Posting Date", Datefilter);
                end
                else begin
                    AnalysisViewBudgetEntry.SETRANGE("Analysis View Code", CurrentAnalysisViewCode);
                    if BudgetFilter <> '' then
                        AnalysisViewBudgetEntry.SETRANGE("Budget Name", BudgetFilter);
                    if Datefilter <> '' then
                        AnalysisViewBudgetEntry.SETFILTER("Posting Date", Datefilter);
                end;

                TempCil3Buffer.DELETEALL();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;//Bc Upgrade YADAVM09<<
        CaptionML = ENU = 'Analysis View Code',
                    FRA = 'Code vue analytique';

        layout
        {
            area(content)
            {
                group("&Options")
                {
                    CaptionML = ENU = '&Options',
                                FRB = '&Options';
                    field(CurrentAnalysisViewCode; CurrentAnalysisViewCode)
                    {
                        CaptionML = ENU = 'Analysis View Code',
                                    FRA = 'Code vue analytique';
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            AnalysisViewList: Page "Analysis View List";
                        begin
                            AnalysisViewList.LOOKUPMODE := true;
                            AnalysisViewList.SETRECORD(AnalysisView);
                            if AnalysisViewList.RUNMODAL() = ACTION::LookupOK then begin
                                AnalysisViewList.GETRECORD(AnalysisView);
                                CurrentAnalysisViewCode := AnalysisView.Code;
                                Text := AnalysisView.Code;
                                exit(true);
                            end;
                        end;
                    }
                    field(ShowActualBudget; ShowActualBudget)
                    {
                        CaptionML = ENU = 'Show',
                                    FRA = 'Afficher';
                        OptionCaptionML = ENU = 'Actual Amounts,Budgeted Amounts,Variance,Variance%,Index%',
                                          FRA = 'Réalisé,Budgété,Ecart,% écart,% indice';
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            if ShowActualBudget = ShowActualBudget::"Actual Amounts" then
                                BudgetFilter := '';
                        end;
                    }
                    field(BudgetFilter; BudgetFilter)
                    {
                        CaptionML = ENU = 'Budget Filter',
                                    FRA = 'Filtre budget';
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            if ShowActualBudget = ShowActualBudget::"Actual Amounts" then
                                if BudgetFilter <> '' then ERROR(Text006);
                        end;
                    }
                    field(GLAccFilter; GLAccFilter)
                    {
                        CaptionML = ENU = 'G/L Account Filter',
                                    FRA = 'Filtre compte général';
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            GLAccList: Page "G/L Account List";
                        begin
                            GLAccList.LOOKUPMODE(true);
                            if not (GLAccList.RUNMODAL() = ACTION::LookupOK) then
                                exit(false)
                            else
                                Text := GLAccList.GetSelectionFilter();
                            exit(true);
                        end;
                    }
                    field(YearFilter; YearFilter)
                    {
                        CaptionML = ENU = 'Year',
                                    FRA = 'Année';
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            calcdatefilter();
                        end;
                    }
                    field(PeriodTypeFilter; PeriodTypeFilter)
                    {
                        CaptionML = ENU = 'Period type',
                                    FRA = 'Type période';
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            calcdatefilter();
                        end;
                    }
                    field(PeriodFilter; PeriodFilter)
                    {
                        CaptionML = ENU = 'Period',
                                    FRA = 'Période';
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            calcdatefilter();
                        end;
                    }
                    field(Calcfilter; Calcfilter)
                    {
                        CaptionML = ENU = 'Calculate',
                                    FRA = 'Calculer';
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            calcdatefilter();
                        end;
                    }
                    field(ClosingEntryFilter; ClosingEntryFilter)
                    {
                        CaptionML = ENU = 'Closing Entries',
                                    FRA = 'Ecritures de clôture';
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            calcdatefilter();
                        end;
                    }
                    field(InclOpening; InclOpening)
                    {
                        Caption = 'Include Opening Balance';
                        ApplicationArea = All;
                    }
                    field(MOV_TYPEValue; MOV_TYPEValue)
                    {
                        Caption = 'OB Dimension value';
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            dimvaluelist: Page "Dimension Values";
                            lrecdimval: Record "Dimension Value";
                        begin
                            dimvaluelist.LOOKUPMODE := true;
                            lrecdimval.SETRANGE("Dimension Code", 'MOV_TYPE');
                            dimvaluelist.SETRECORD(lrecdimval);
                            dimvaluelist.SETTABLEVIEW(lrecdimval);
                            if dimvaluelist.RUNMODAL() = ACTION::LookupOK then begin
                                dimvaluelist.GETRECORD(lrecdimval);
                                MOV_TYPEValue := lrecdimval.Code;
                                Text := lrecdimval.Code;
                                exit(true);
                            end;
                        end;
                    }
                    field(Datefilter; Datefilter)
                    {
                        CaptionML = ENU = 'Date Filter',
                                    FRA = 'Filtre date';
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field(RoundingFactor; RoundingFactor)
                    {
                        CaptionML = ENU = 'Rounding Factor',
                                    FRA = 'Unité d''affichage';
                        OptionCaptionML = ENU = 'None,1,1000,1000000',
                                          FRA = 'Standard,1,1000,1000000';
                        ApplicationArea = All;
                    }
                    field(ClientFileName; ClientFileName)
                    {
                        CaptionML = ENU = 'File Name',
                                    FRA = 'Nom du fichier';
                        ApplicationArea = All;

                        trigger OnAssistEdit();
                        var
                            CommonDialogMgt: Codeunit "File Management";
                        begin
                            //ClientFileName := CommonDialogMgt.SaveFileDialog(Text002,ClientFileName,CommonDialogMgt.GetToFilterText('','.txt'));//BC Upgrade YADAVM09 Temp Blocked
                        end;
                    }
                }
            }
        }

        actions
        {
        }
        //Bc Upgrade YADAVM09,28.04.26>>
        trigger OnOpenPage();
        begin
            Clear(HeaderWritten);
        end;
        //Bc Upgrade YADAVM09,28.04.26<<
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        //FleCIL3.CLOSE;//BC Upgrade YADAVM09 Temp Blocked
        //FileMgt.DownloadToFile(ServerFileName,ClientFileName);//BC Upgrade YADAVM09 Temp Blocked
        //Bc Upgrade YADAVM09>>
        // #BCUP0-103 BC Upgrade KAIRAR01 >>
        // MakeExcelDataHeader();
        // MakeExcelDataBody();
        // CreateExcelbook();
        TempBlob.CreateOutStream(FileOutStream, TextEncoding::UTF8);
        FileOutStream.WriteText(TxtBuilder.ToText());

        TempBlob.CreateInStream(FileInStream, TextEncoding::UTF8);
        if ClientFileName = '' then
            ClientFileName := 'CIL3-EBF' + Format(Today) + '.txt'
        else
            ClientFileName := ClientFileName + '.txt';

        DownloadFromStream(FileInStream, ExportToLbl, '', '', ClientFileName);
        // #BCUP0-103 BC Upgrade KAIRAR01 <<
        MESSAGE(Text005);
        TempCil3Buffer.DELETEALL;
        //Bc Upgrade YADAVM09<<
    end;

    trigger OnPreReport();
    begin

        //ServerFileName := FileMgt.ServerTempFileName('txt');//BC Upgrade YADAVM09 Temp Blocked
        GLSetUp.GET();
        //Bc Upgrade YADAVM09>>
        TempCil3Buffer.DELETEALL();
        ExcelBuffer.DeleteAll();
        //Bc Upgrade YADAVM09<<
    end;

    var
        CurrentAnalysisViewCode: Code[10];
        ShowActualBudget: Option "Actual Amounts","Budgeted Amounts",Variance,"Variance%","Index%";
        GLAccFilter: Code[250];
        BudgetFilter: Code[250];
        ItemFilter: Code[250];
        YearFilter: Integer;
        PeriodTypeFilter: Option Week,Month,Quarter;
        PeriodFilter: Integer;
        Calcfilter: Option "Net change","Year to date","Balance to date","Rest of Year";
        Datefilter: Text[250];
        Filename: Text[1024];
        ItemAnalysisMgt: Codeunit "Item Analysis Management";
        CurrentAnalysisArea: Option Sales,Purchase,Inventory;
        AnalysisView: Record "Analysis View";
        ItemStatisticsBuffer: Record "Item Statistics Buffer";
        GLSetUp: Record "General Ledger Setup";
        Dim1Filter: Code[250];
        Dim2Filter: Code[250];
        Dim3Filter: Code[250];
        Text000: TextConst ENU = 'You can only export Actual amounts and Budgeted amounts.\Please change the option in the Show field.', FRA = 'Vous pouvez uniquement exporter les montants réalisés et budgétés.\Modifiez l''option dans le champ Afficher.';
        Text001: Label 'No filename specified';
        Text002: TextConst ENU = 'Export to', FRA = ' ';
        Text003: Label 'File already exists. Overwrite file?';
        Text004: Label 'Period is not valid for this period type';
        Text005: Label 'File created succesfully';
        Text006: Label 'Budget filter only allowed for Budget Amounts';
        EndDate: Date;
        TabChar: Char;
        AnalysisViewEntry: Record "Analysis View Entry";
        AnalysisViewBudgetEntry: Record "Analysis View Budget Entry";
        CompanyInfo: Record "Company Information";
        TempCil3Buffer: Record "CIL3 Export Buffer FND" temporary;//BC Upgrade YADAVM09 Temp Blocked
        FleCIL3: File;
        FleRecord: Text[1024];
        ServerFileName: Text;
        ClientFileName: Text;
        FileMgt: Codeunit "File Management";
        FileManagement: Codeunit "File Management";
        Text008: Label 'Nothing to Create.';
        InclOpening: Boolean;
        OBDatefilter: Text[250];
        ReportingPeriod: Text[2];
        MOV_TYPEValue: Code[20];
        ClosingEntryFilter: Option Include,Exclude;
        RoundingFactor: Option "None","1","1000","1000000";
        QtyBusTypes: Integer;
        BusType: array[20] of Code[20];
        Perc: array[20] of Decimal;
        i: Integer;
        DimensionValue: Record "Dimension Value";

    procedure processBudgetEntries(var_Groupaccount: Code[20]; Var_Movtyp: Code[20]; Var_OB: Boolean);
    var
        lrec_GLACC: Record "G/L Account";
        GLBudgetName: Record "G/L Budget Name";
    begin
        if AnalysisViewBudgetEntry.FIND('-') then
            repeat
                QtyBusTypes := GetBusTypes(BusType, Perc, AnalysisViewBudgetEntry."Dimension 4 Value Code", AnalysisViewBudgetEntry."Dimension 4 Value Code", AnalysisViewBudgetEntry."G/L Account No.");
                for i := 1 to QtyBusTypes do begin
                    TempCil3Buffer.INIT();
                    if GLBudgetName.GET(AnalysisViewBudgetEntry."Budget Name") then
                        TempCil3Buffer."Data Version" := GLBudgetName."Data Version Refrence FND";

                    TempCil3Buffer.Year := FORMAT(AnalysisViewBudgetEntry."Posting Date", 4, '<Year4>');

                    if Var_OB then
                        TempCil3Buffer.Period := ''
                    else
                        TempCil3Buffer.Period := ReportingPeriod;

                    TempCil3Buffer."Business Type" := BusType[i];

                    if var_Groupaccount = '' then
                        TempCil3Buffer."Group Account" := AnalysisViewBudgetEntry."G/L Account No."
                    else
                        TempCil3Buffer."Group Account" := var_Groupaccount;

                    TempCil3Buffer."Movement Type" := AnalysisViewBudgetEntry."Dimension 4 Value Code";

                    lrec_GLACC.GET(AnalysisViewBudgetEntry."G/L Account No.");
                    TempCil3Buffer."Trading Partner" := '';
                    //HEI.06
                    if lrec_GLACC."No Trading Partner FND" then
                        TempCil3Buffer."Trading Partner" := ''
                    else
                        //HEI.04>>
                        //TempCil3Buffer."Trading Partner" := "Dimension 1 Value Code";
                        if DimensionValue.GET(GLSetUp."OPCO Dimension Code FND", AnalysisViewBudgetEntry."Dimension 1 Value Code") then
                            TempCil3Buffer."Trading Partner" := DimensionValue."Reporting Entity FND";
                    //HEI.04<<
                    if TempCil3Buffer."Business Type" = '' then
                        TempCil3Buffer."Business Type" := CompanyInfo."Business Type FND";

                    if TempCil3Buffer.FIND() then begin
                        if Perc[i] <> 0 then
                            TempCil3Buffer.Quantity += AnalysisViewBudgetEntry.Amount * Perc[i] / 100
                        else
                            TempCil3Buffer.Quantity += AnalysisViewBudgetEntry.Amount;
                        TempCil3Buffer.MODIFY();
                    end else begin
                        if Perc[i] <> 0 then
                            TempCil3Buffer.Quantity := AnalysisViewBudgetEntry.Amount * Perc[i] / 100
                        else
                            TempCil3Buffer.Quantity := AnalysisViewBudgetEntry.Amount;
                        if AnalysisViewBudgetEntry.Amount <> 0 then TempCil3Buffer.INSERT();
                    end;
                end;
            until AnalysisViewBudgetEntry.NEXT() = 0;
    end;

    procedure processEntries(var_Groupaccount: Code[20]; Var_Movtyp: Code[20]; Var_ob: Boolean);
    var
        lrec_GLACC: Record "G/L Account";
    begin
        if AnalysisViewEntry.FINDSET() then
            repeat
                QtyBusTypes := GetBusTypes(BusType, Perc, AnalysisViewEntry."Dimension 4 Value Code", AnalysisViewEntry."Dimension 4 Value Code", AnalysisViewEntry."Account No.");
                for i := 1 to QtyBusTypes do begin
                    TempCil3Buffer.INIT();
                    TempCil3Buffer."Data Version" := '100';

                    TempCil3Buffer.Year := FORMAT(AnalysisViewEntry."Posting Date", 4, '<Year4>');

                    if Var_ob then
                        TempCil3Buffer.Period := ''
                    else
                        TempCil3Buffer.Period := ReportingPeriod;

                    TempCil3Buffer."Business Type" := BusType[i];

                    if var_Groupaccount = '' then
                        TempCil3Buffer."Group Account" := AnalysisViewEntry."Account No."
                    else
                        TempCil3Buffer."Group Account" := var_Groupaccount;

                    TempCil3Buffer."Movement Type" := AnalysisViewEntry."Dimension 4 Value Code";

                    lrec_GLACC.GET(AnalysisViewEntry."Account No.");
                    TempCil3Buffer."Trading Partner" := '';
                    //HEI.06
                    if lrec_GLACC."No Trading Partner FND" then
                        TempCil3Buffer."Trading Partner" := ''
                    else
                        //HEI.04>>
                        //TempCil3Buffer."Trading Partner" := "Dimension 1 Value Code";
                        if DimensionValue.GET(GLSetUp."OPCO Dimension Code FND", AnalysisViewEntry."Dimension 1 Value Code") then
                            TempCil3Buffer."Trading Partner" := DimensionValue."Reporting Entity FND";
                    //HEI.04<<
                    if TempCil3Buffer."Business Type" = '' then
                        TempCil3Buffer."Business Type" := CompanyInfo."Business Type FND";

                    if TempCil3Buffer.FIND() then begin
                        if Perc[i] <> 0 then
                            TempCil3Buffer.Quantity += AnalysisViewEntry.Amount * Perc[i] / 100
                        else
                            TempCil3Buffer.Quantity += AnalysisViewEntry.Amount;
                        TempCil3Buffer.MODIFY();
                    end else begin
                        if Perc[i] <> 0 then
                            TempCil3Buffer.Quantity := AnalysisViewEntry.Amount * Perc[i] / 100
                        else
                            TempCil3Buffer.Quantity := AnalysisViewEntry.Amount;
                        if AnalysisViewEntry.Amount <> 0 then TempCil3Buffer.INSERT();
                    end;
                end;
            until AnalysisViewEntry.NEXT() = 0;
    end;

    procedure calcdatefilter();
    var
        lrecPeriod: Record Date;
    begin
        if (YearFilter = 0) or
           (PeriodFilter = 0) then
            exit;

        if (PeriodTypeFilter = PeriodTypeFilter::Month) and
           (PeriodFilter = 12) and
           (Calcfilter = Calcfilter::"Rest of Year") then
            ERROR(Text004);


        if (PeriodTypeFilter = PeriodTypeFilter::Week) and
           (PeriodFilter > 53) then
            ERROR(Text004);

        if (PeriodTypeFilter = PeriodTypeFilter::Week) then begin
            lrecPeriod.RESET();
            lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
            lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Week);
            lrecPeriod.SETRANGE("Period No.", PeriodFilter);
            if lrecPeriod.FIND('-') then
                if ClosingEntryFilter = ClosingEntryFilter::Exclude then
                    lrecPeriod."Period End" := NORMALDATE(lrecPeriod."Period End");
            Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(lrecPeriod."Period End");
            ReportingPeriod := FORMAT(lrecPeriod."Period End", 2, '<Month>');
        end;



        if (PeriodTypeFilter = PeriodTypeFilter::Month) and
           (PeriodFilter > 12) then
            ERROR(Text004);
        if (PeriodTypeFilter = PeriodTypeFilter::Month) then begin
            lrecPeriod.RESET();
            lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
            lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Month);
            lrecPeriod.SETRANGE("Period No.", PeriodFilter);
            if lrecPeriod.FIND('-') then
                if ClosingEntryFilter = ClosingEntryFilter::Exclude then
                    lrecPeriod."Period End" := NORMALDATE(lrecPeriod."Period End");

            Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(lrecPeriod."Period End");
            ReportingPeriod := FORMAT(lrecPeriod."Period End", 2, '<Month>');

        end;

        if (PeriodTypeFilter = PeriodTypeFilter::Quarter) and
           (PeriodFilter > 4) then
            ERROR(Text004);
        if (PeriodTypeFilter = PeriodTypeFilter::Quarter) then begin
            lrecPeriod.RESET();
            lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
            lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Quarter);
            lrecPeriod.SETRANGE("Period No.", PeriodFilter);
            if lrecPeriod.FIND('-') then
                if ClosingEntryFilter = ClosingEntryFilter::Exclude then
                    lrecPeriod."Period End" := NORMALDATE(lrecPeriod."Period End");
            Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(lrecPeriod."Period End");
            ReportingPeriod := FORMAT(lrecPeriod."Period End", 2, '<Month>');

        end;

        OBDatefilter := '..' + FORMAT(lrecPeriod."Period Start" - 1);

        if Calcfilter = Calcfilter::"Net change" then exit;
        if Calcfilter = Calcfilter::"Year to date" then begin
            Datefilter := '0101' + FORMAT(YearFilter) + '..' + FORMAT(lrecPeriod."Period End");
            ReportingPeriod := FORMAT(lrecPeriod."Period End", 2, '<Month>');
        end;
        if Calcfilter = Calcfilter::"Rest of Year" then begin
            Datefilter := FORMAT(CALCDATE('<+1D>', lrecPeriod."Period End")) + '..' + FORMAT(DMY2DATE(31, 12, YearFilter));
            ReportingPeriod := '12';
        end;

        if Calcfilter = Calcfilter::"Balance to date" then begin
            Datefilter := '..' + FORMAT(lrecPeriod."Period End");
            ReportingPeriod := FORMAT(lrecPeriod."Period End", 2, '<Month>');
        end;
    end;

    procedure processaccountfilter();
    var
        lrecAcc: Record "G/L Account";
        LrecAnalysisViewEntry: Record "Analysis View Entry";
    begin
        lrecAcc.RESET();
        lrecAcc.SETRANGE("Income/Balance", lrecAcc."Income/Balance"::"Income Statement");
        //HEI.03>>
        //lrecAcc.SETRANGE("Posting Heineken",TRUE);//old
        lrecAcc.SETFILTER("Financial Stmt version FND", '%1|%2', lrecAcc."Financial Stmt version FND"::Common, lrecAcc."Financial Stmt version FND"::Heineken);
        //HEI.03>>
        if GLAccFilter <> '' then
            lrecAcc.SETFILTER(lrecAcc."No.", GLAccFilter);

        if lrecAcc.FINDSET() then
            repeat
                if lrecAcc."MR Code FND" <> '' then
                    if lrecAcc.Totaling = '' then begin
                        AnalysisViewEntry.SETRANGE("Account No.", lrecAcc."No.");
                        processEntries(lrecAcc."MR Code FND", '', false);
                    end else begin
                        AnalysisViewEntry.SETFILTER("Account No.", lrecAcc.Totaling);
                        if lrecAcc."MR Code FND" = '' then
                            processEntries(lrecAcc."No.", '', false)
                        else
                            processEntries(lrecAcc."MR Code FND", '', false);
                    end;
            until lrecAcc.NEXT() = 0;
    end;

    procedure processaccountfilterBudget();
    var
        lrecAcc: Record "G/L Account";
        LrecAnalysisViewBudgetEntry: Record "Analysis View Budget Entry";
    begin
        lrecAcc.RESET();
        lrecAcc.SETRANGE("Income/Balance", lrecAcc."Income/Balance"::"Income Statement");
        //HEI.03>>
        //lrecAcc.SETRANGE("Posting Heineken",TRUE);//old
        lrecAcc.SETFILTER("Financial Stmt version FND", '%1|%2', lrecAcc."Financial Stmt version FND"::Common, lrecAcc."Financial Stmt version FND"::Heineken);
        //HEI.03>>
        if GLAccFilter <> '' then
            lrecAcc.SETFILTER(lrecAcc."No.", GLAccFilter);

        if lrecAcc.FINDSET() then
            repeat
                if lrecAcc."MR Code FND" <> '' then
                    if lrecAcc.Totaling = '' then begin
                        AnalysisViewBudgetEntry.SETRANGE("G/L Account No.", lrecAcc."No.");
                        processBudgetEntries(lrecAcc."MR Code FND", '', false);
                    end else begin
                        AnalysisViewBudgetEntry.SETFILTER("G/L Account No.", lrecAcc.Totaling);
                        if lrecAcc."MR Code FND" = '' then
                            processBudgetEntries('', '', false)
                        else
                            processBudgetEntries(lrecAcc."MR Code FND", '', false);
                    end;
            until lrecAcc.NEXT() = 0;
    end;

    procedure processOBaccountfilter();
    var
        lrecAcc: Record "G/L Account";
        LrecAnalysisViewEntry: Record "Analysis View Entry";
    begin
        lrecAcc.RESET();
        lrecAcc.SETRANGE("Income/Balance", lrecAcc."Income/Balance"::"Income Statement");
        //HEI.03>>
        //lrecAcc.SETRANGE("Posting Heineken",TRUE);//old
        lrecAcc.SETFILTER("Financial Stmt version FND", '%1|%2', lrecAcc."Financial Stmt version FND"::Common, lrecAcc."Financial Stmt version FND"::Heineken);
        //HEI.03>>
        if GLAccFilter <> '' then
            lrecAcc.SETFILTER(lrecAcc."No.", GLAccFilter);

        AnalysisViewEntry.SETFILTER("Posting Date", OBDatefilter);
        if lrecAcc."MR Code FND" <> '' then
            if lrecAcc.FINDSET() then
                repeat
                    if lrecAcc.Totaling = '' then begin
                        AnalysisViewEntry.SETRANGE("Account No.", lrecAcc."No.");
                        processEntries(lrecAcc."MR Code FND", MOV_TYPEValue, true);
                    end else begin
                        AnalysisViewEntry.SETFILTER("Account No.", lrecAcc.Totaling);
                        if lrecAcc."MR Code FND" = '' then
                            processEntries(lrecAcc."No.", MOV_TYPEValue, true)
                        else
                            processEntries(lrecAcc."MR Code FND", MOV_TYPEValue, true);
                    end;
                until lrecAcc.NEXT() = 0;
    end;

    procedure processOBaccountfilterBudget();
    var
        lrecAcc: Record "G/L Account";
        LrecAnalysisViewBudgetEntry: Record "Analysis View Budget Entry";
    begin
        lrecAcc.RESET();
        lrecAcc.SETRANGE("Income/Balance", lrecAcc."Income/Balance"::"Income Statement");
        //HEI.03>>
        //lrecAcc.SETRANGE("Posting Heineken",TRUE);//old
        lrecAcc.SETFILTER("Financial Stmt version FND", '%1|%2', lrecAcc."Financial Stmt version FND"::Common, lrecAcc."Financial Stmt version FND"::Heineken);
        //HEI.03>>
        if GLAccFilter <> '' then
            lrecAcc.SETFILTER(lrecAcc."No.", GLAccFilter);

        AnalysisViewBudgetEntry.SETFILTER("Posting Date", OBDatefilter);
        if lrecAcc.FINDSET() then
            repeat
                if lrecAcc."MR Code FND" <> '' then
                    if lrecAcc.Totaling = '' then begin
                        AnalysisViewBudgetEntry.SETRANGE("G/L Account No.", lrecAcc."No.");
                        processBudgetEntries(lrecAcc."MR Code FND", MOV_TYPEValue, true);
                    end else begin
                        AnalysisViewBudgetEntry.SETFILTER("G/L Account No.", lrecAcc.Totaling);
                        if lrecAcc."MR Code FND" = '' then
                            processBudgetEntries(lrecAcc."No.", MOV_TYPEValue, true)
                        else
                            processBudgetEntries(lrecAcc."MR Code FND", MOV_TYPEValue, true);
                    end;
            until lrecAcc.NEXT() = 0;
    end;

    local procedure FormatAmount(p_Amount: Decimal) Amount: Decimal;
    begin
        if p_Amount = 0 then
            exit;

        case RoundingFactor of
            RoundingFactor::None:
                Amount := ROUND(p_Amount, 0.01);
            RoundingFactor::"1":
                Amount := ROUND(p_Amount, 1);
            RoundingFactor::"1000":
                Amount := ROUND(p_Amount / 1000, 0.01);
            RoundingFactor::"1000000":
                Amount := ROUND(p_Amount / 1000000, 0.01);
        end;
    end;

    procedure Setdefaults(PCurrentItemAnalysisViewCode: Code[10]; PShowActualBudget: Option "Actual Amounts","Budgeted Amounts",Variance,"Variance%","Index%"; PBudgetFilter: Code[250]; PGLFilter: Code[250]);
    begin
        CurrentAnalysisViewCode := PCurrentItemAnalysisViewCode;
        ShowActualBudget := PShowActualBudget;
        BudgetFilter := PBudgetFilter;
        GLAccFilter := PGLFilter;
    end;

    procedure GetBusTypes(var BusType: array[20] of Code[20]; var Perc: array[20] of Decimal; DimValue3Code: Code[20]; DimValue4Code: Code[20]; AccountNo: Code[20]): Integer;
    var
        DimValues: Record "Dimension Value";
        BusTypePerc: Record "Business Type Percentage FND";
        DefaultDim: Record "Default Dimension";
    begin
        CLEAR(BusType);
        CLEAR(Perc);
        i := 0;

        if DimValue3Code <> '' then begin
            DimValues.SETRANGE("Dimension Code", GLSetUp."Brand Dimension Code FND");
            DimValues.SETRANGE(Code, DimValue3Code);
            if DimValues.FINDFIRST() then
                BusType[1] := DimValues."Business Type Dime. Code FND";
        end;

        if BusType[1] = '' then begin
            if DimValue4Code <> '' then begin
                BusTypePerc.SETRANGE("Dimension 1 Code", AnalysisView."Dimension 4 Code");
                BusTypePerc.SETRANGE("Dimension 1 Value Code", AnalysisViewEntry."Dimension 4 Value Code");
                BusTypePerc.SETRANGE("Dimension 2 Code", GLSetUp."Business Type Dim Code FND");
                if BusTypePerc.FINDSET() then
                    repeat
                        i += 1;
                        BusType[i] := BusTypePerc."Dimension 2 Value Code";
                        Perc[i] := BusTypePerc."Combination Percentage";
                    until BusTypePerc.NEXT() = 0;
            end;
        end;

        if BusType[1] = '' then begin
            DefaultDim.SETRANGE("Table ID", 15);
            DefaultDim.SETRANGE("No.", AccountNo);
            DefaultDim.SETRANGE("Dimension Code", GLSetUp."Business Type Dim Code FND");
            if DefaultDim.FINDFIRST() then
                BusType[1] := DefaultDim."Dimension Value Code";
        end;

        if i = 0 then
            i := 1;
        exit(i);
    end;
    //Bc Upgrade YADAVM09>>
    local procedure MakeExcelDataHeader();
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Reporting entity', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Data Version', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);//Bc Upgrade YADAVM09,28.04.26<<
        ExcelBuffer.AddColumn('Calendar Month/Year', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);//Bc Upgrade YADAVM09,28.04.26<<
        ExcelBuffer.AddColumn('Business type', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Group Account', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Local Cost Center', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);//Bc Upgrade YADAVM09,28.04.26<<
        ExcelBuffer.AddColumn('Trading partner', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Value in Local Currency', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);

    end;

    local procedure MakeExcelDataBody();
    var
    begin
        ExcelBuffer.NewRow();
        if TempCil3Buffer.FINDSET then
            repeat
                CompanyInfo.get;
                ExcelBuffer.AddColumn(CompanyInfo."Reporting Entity FND", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil3Buffer."Data Version", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil3Buffer.Period + TempCil3Buffer.Year + FORMAT(TabChar), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);//Bc Upgrade YADAVM09,28.04.26<<
                ExcelBuffer.AddColumn(TempCil3Buffer."Business Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil3Buffer."Group Account", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil3Buffer."Movement Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil3Buffer."Trading Partner", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn((FORMAT(FormatAmount(TempCil3Buffer.Quantity), 20, '<Precision,5:5><Standard Format,1>')), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);//Bc Upgrade YADAVM09,28.04.26<<
                ExcelBuffer.NewRow();
            until TempCil3Buffer.Next() = 0;

    end;

    local procedure CreateExcelbook();
    begin
        ExcelBuffer.CreateNewBook('CIL-3' + Format(Today));
        ExcelBuffer.WriteSheet('Data', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('CIL-3' + Format(Today));
        ExcelBuffer.OpenExcel();

    end;

    var
        ExcelBuffer: Record "Excel Buffer";
        // #BCUP0-103 BC Upgrade KAIRAR01 >>
        TempBlob: Codeunit "Temp Blob";
        FileOutStream: OutStream;
        FileInStream: InStream;
        TxtBuilder: TextBuilder;
        ExportToLbl: Label 'Export';
        HeaderWritten: Boolean;
    // #BCUP0-103 BC Upgrade KAIRAR01 <<
    //Bc Upgrade YADAVM09<<

}