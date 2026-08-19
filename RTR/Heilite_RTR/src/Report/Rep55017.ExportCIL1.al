report 55017 "Export CIL1 RTR"
{
    // version HEI.22

    // HEI.01 FDD-BPMGAP014 IBM ISYED01 08.10.2017
    //   #Migrated Report Export CIL1 from HEI2.0 to Base.
    // 
    // HEI.02 Defect #1328 #1329 IBM NASTAA02 19.12.2017 # Missing fields in file creation
    //   # Removed comment marks
    // 
    // HEI.03 Defect #1329 IBM NASTAA02 09.01.2018 # Impossible to generate MSV Flatfile
    //   # Replaced "Quantity in HL" with "Invoiced Quantity in HL" for column "Quantity"
    // 
    // HEI.04 Defect #1329 IBM NASTAA02 25.01.2018 # Impossible to generate MSV Flatfile
    //   # Just Items with "Item Inventory Code" = '01' should be exported
    // 
    // HEI.05 Defect #1819 IBM SAPIED01 01.04.2018
    //   # Bug fix
    // HEI.06 IBM HORTROC01 03.08.2018 - bug fix
    // 
    // HEI.07 CHG2019204 IBM NANDIS01 27.06.2019 # Add Consumption Country Dimension in CIL WIS Dataset (Flat File) - Global Change
    //   Added field "Country of Consumption" for WIS file.
    // 
    // HEI.08 CHG2030732 PATHAA02 21.10.2019
    //   # Precision of the column-"Quantity" changed to add 3 mandatory Decimals (0:0 to 3:3)
    // 
    // HEI.09 FDD-HB1425 BULIMC01 IBM 03.06.2020 #2 new columns added: "Primary Pack Type", "Channel"
    // 
    // HEI.10 CHG2110089 POENAB02 Column CALWEEK in the flat file WIS is not correct as per CIL requirements
    //   # This change was created only for year 2021
    //   # Modified functions: calcdatefilter, processBudgetEntries, processEntries
    // 
    // HEI.11 CHG2141462 POENAB02 IBM 07.01.2021 Column CALWEEK in the flat file WIS is not correct as per CIL requirements
    //   # This change was created only for year 2021
    //   # Modified functions: calcdatefilter, processBudgetEntries, processEntries
    // HEI.12 Corrective Change # CHG2151872 BHATTA09 IBM 23.03.2022 Wis - Extraction
    //   # Old Code commented and modified new code added to remove extra space in calculating week
    // 
    // HEI.13 Change # CHG2161959 YADAVM05 IBM 02.11.2022 Bag In Box conversion
    //   # Add new column in report BIB Quantity
    // HEI.14 Change # CHG2161959 YADAVM05 IBM 22.11.2022 Bag In Box conversion
    //   # Change in Formula for BIB Quantity
    // HEI.15 CHG2184593 POENAB02 IBM 15.12.2022 Column CALWEEK in the flat file WIS is not correct as per CIL requirements
    //   # This change was created only for year 2023
    //   # Modified functions: calcdatefilter, processBudgetEntries, processEntries
    // HEI.16 Change # CHG2161959 YADAVM05 IBM 13.12.2022 Bag In Box conversion
    //   # Change in Formula for BIB Quantity
    // HEI.17 CHG2191844  YADAVM05 09.02.2023 # Change in codition for ELP Quantity not equal to zero.
    // HEI.18 IBM YADAVM09 12/10/23 CHG2218600_HB3954 DRC Interredional transfer exclusion from WIS MSV
    // #Added filter to Exclude transfer entry
    // HEI.19 CHG2232703 POENAB02 IBM 20.12.2023 WIS flat file calendar
    //   # Adjustments for the end of the year of 2023
    // HEI.20 CHG2232703 Yadavm09 IBM 20.12.2023 WIS flat file calendar
    //   # Bug Fix for last week Adjustments for the end of the year of 2023
    // HEI.21 CHG2234742 Yadavm09 IBM 10.01.2024 System error - We can't download MSV
    //   # change the documentation date
    // HEI.22 CHG2280043 POENAB02 IBM 13.12.2024 Please adjust WIS Week 52  2024 dates  as per BRD
    //   # Modified function calcdatefilter
    // HEI.23 CHG2333091 POENAB02 IBM 03.12.2025 Please adjust WIS Week 52  2025 dates  as per BRD
    //   # Modified function calcdatefilter
    // HEI.24 CHG2335439 POENAB02 IBM 12.12.2025 HB4502 Adjustment of week 2 for year 2026
    //   # Modified function calcdatefilter
    //   # Week 2 of year 2026 must include also week 1 of year 2026
    // HEI.25 CHG2335439 POENAB02 IBM 12.12.2025 HB4502 Adjustment of week 2 for year 2026
    //   # Modified function calcdatefilter
    //   # Correct export for week 52 year 2025. In some cases it appeared to be week 1.
    // HEI.26 CHG2335439 POENAB02 IBM 16.12.2025 HB4502 Adjustment of week 2 for year 2026
    //   # Modified function calcdatefilter
    //   # the export of week 1 year 2026 must be included in week 2

    //Bc upgrade YADAVM09 Report is redesign as per excel format.
    //Bc Upgrade YADAVM09 old id 50019.
    //#PID-758: Extra RTR: Exporting sales volume: Sales Analysis by Dimension.
    //Bc Upgrade YADAVM09,28.04.26 PID-475, PID-503, PID-504, PID-505, PID-535, PID-536, PID-537, PID-758GAP ID: IBM GAP RTR 09.

    // BC Upgrade PATELS08 >>
    // # Added Tags HEI.23, HEI.24, HEI.25, HEI.26 to the documentatioN and code related to it in functions processBudgetEntries and processEntries
    // BC Upgrade PATELS08 <<

    //BCUP0-103 BC Upgrade YADAVM09 - Redesigned to Txt Export Format, stopped the excel export

    Caption = 'Export CIL1 RTR';//Bc Upgrade YADAVM09,28.04.26<<
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

            trigger OnAfterGetRecord();
            begin

                if ShowActualBudget = ShowActualBudget::"Actual Amounts" then
                    processEntries()
                else
                    processBudgetEntries();
                //YADAVM09>>
                // FleCIL1.CREATE(ServerFileName);
                // FleCIL1.TEXTMODE := true;
                // if TempCil1Buffer.FINDSET then begin
                //     FleRecord := 'Reporting Entity' + FORMAT(TabChar);
                //     FleRecord += 'Data Version' + FORMAT(TabChar);
                //     FleRecord += 'CALWEEK' + FORMAT(TabChar);
                //     FleRecord += 'Business Type' + FORMAT(TabChar);
                //     FleRecord += 'Product Type' + FORMAT(TabChar);
                //     FleRecord += 'Brand' + FORMAT(TabChar);
                //     FleRecord += 'Line Extension' + FORMAT(TabChar);
                //     FleRecord += 'Primary Pack Type' + FORMAT(TabChar); //HEI.09
                //     FleRecord += 'Market Type' + FORMAT(TabChar);
                //     FleRecord += 'Channel' + FORMAT(TabChar); //HEI.09
                //     FleRecord += 'Country of Consumption' + FORMAT(TabChar); //HEI.07
                //     FleRecord += 'CIL ID' + FORMAT(TabChar);
                //     FleRecord += 'Quantity' + FORMAT(TabChar);
                //     FleRecord += ' BIB Quantity' + FORMAT(TabChar);//HEI.13

                //     FleCIL1.WRITE(FleRecord);
                //     repeat
                //         FleRecord := Compinfo."Reporting Entity" + FORMAT(TabChar);
                //         FleRecord += TempCil1Buffer.YVERSION + FORMAT(TabChar);
                //         FleRecord += TempCil1Buffer.CALWEEK + FORMAT(TabChar);
                //         FleRecord += TempCil1Buffer."Business Type" + FORMAT(TabChar);
                //         FleRecord += TempCil1Buffer.PRODTYP + FORMAT(TabChar);
                //         FleRecord += TempCil1Buffer.BRAND + FORMAT(TabChar);
                //         FleRecord += TempCil1Buffer.LINEXTEN + FORMAT(TabChar);
                //         FleRecord += TempCil1Buffer.P_PACKTYPE + FORMAT(TabChar); //HEI.09
                //         FleRecord += TempCil1Buffer.MARKET + FORMAT(TabChar);
                //         FleRecord += TempCil1Buffer.CHANNEL + FORMAT(TabChar); //HEI.09
                //                                                                //HEI.07>>
                //         FleRecord += TempCil1Buffer.COUNTRY + FORMAT(TabChar);
                //         //HEI.07<<
                //         FleRecord += TempCil1Buffer."CIL ID" + FORMAT(TabChar);
                //         if ShowActualBudget = ShowActualBudget::"Actual Amounts" then
                //             //FleRecord += FORMAT((ROUND(TempCil1Buffer.QVLD02,1)*-1),20,'<Precision,0:0><Standard Format,1>')+FORMAT(TabChar)
                //             FleRecord += FORMAT((TempCil1Buffer.QVLD02 * -1), 20, '<Precision,3:3><Standard Format,1>') + FORMAT(TabChar) //Hei.08
                //         else
                //             //FleRecord += FORMAT(ROUND(TempCil1Buffer.QVLD02,1),20,'<Precision,0:0><Standard Format,1>')+FORMAT(TabChar);
                //             FleRecord += FORMAT(TempCil1Buffer.QVLD02, 20, '<Precision,3:3><Standard Format,1>') + FORMAT(TabChar);    //Hei.08
                //         FleRecord += FORMAT((TempCil1Buffer."BIB Quantity" * -1), 20, '<Precision,3:3><Standard Format,1>') + FORMAT(TabChar);//HEI.13
                //         FleCIL1.WRITE(FleRecord);
                //     until TempCil1Buffer.NEXT = 0;
                // end;

                // MESSAGE(Text005);
                //YADAVM09

                //BCUP0-103 BC Upgrade YADAVM09 >>
                if TempCil1Buffer.FindSet() then begin
                    if not HeaderWritten then begin
                        FleRecord := 'Reporting Entity' + FORMAT(TabChar);
                        FleRecord += 'Data Version' + FORMAT(TabChar);
                        FleRecord += 'CALWEEK' + FORMAT(TabChar);
                        FleRecord += 'Business Type' + FORMAT(TabChar);
                        FleRecord += 'Product Type' + FORMAT(TabChar);
                        FleRecord += 'Brand' + FORMAT(TabChar);
                        FleRecord += 'Line Extension' + FORMAT(TabChar);
                        FleRecord += 'Primary Pack Type' + FORMAT(TabChar); //HEI.09
                        FleRecord += 'Market Type' + FORMAT(TabChar);
                        FleRecord += 'Channel' + FORMAT(TabChar); //HEI.09
                        FleRecord += 'Country of Consumption' + FORMAT(TabChar); //HEI.07
                        FleRecord += 'CIL ID' + FORMAT(TabChar);
                        FleRecord += 'Quantity' + FORMAT(TabChar);
                        FleRecord += 'BIB Quantity'; //HEI.13
                        TxtBuilder.AppendLine(FleRecord);
                        HeaderWritten := true;
                    end;
                    repeat
                        FleRecord := CompanyInfo."Reporting Entity FND" + FORMAT(TabChar);
                        FleRecord += TempCil1Buffer.YVERSION + FORMAT(TabChar);
                        FleRecord += TempCil1Buffer.CALWEEK + FORMAT(TabChar);
                        FleRecord += TempCil1Buffer."Business Type" + FORMAT(TabChar);
                        FleRecord += TempCil1Buffer.PRODTYP + FORMAT(TabChar);
                        FleRecord += TempCil1Buffer.BRAND + FORMAT(TabChar);
                        FleRecord += TempCil1Buffer.LINEXTEN + FORMAT(TabChar);
                        FleRecord += TempCil1Buffer.P_PACKTYPE + FORMAT(TabChar); //HEI.09
                        FleRecord += TempCil1Buffer.MARKET + FORMAT(TabChar);
                        FleRecord += TempCil1Buffer.CHANNEL + FORMAT(TabChar); //HEI.09
                                                                               //HEI.07>>
                        FleRecord += TempCil1Buffer.COUNTRY + FORMAT(TabChar);
                        //HEI.07<<
                        FleRecord += TempCil1Buffer."CIL ID" + FORMAT(TabChar);
                        if ShowActualBudget = ShowActualBudget::"Actual Amounts" then
                            FleRecord += FORMAT((TempCil1Buffer.QVLD02 * -1), 20, '<Precision,3:3><Standard Format,1>') + FORMAT(TabChar) //HEI.08
                        else
                            FleRecord += FORMAT(TempCil1Buffer.QVLD02, 20, '<Precision,3:3><Standard Format,1>') + FORMAT(TabChar);    //HEI.08
                        FleRecord += FORMAT((TempCil1Buffer."BIB Quantity" * -1), 20, '<Precision,3:3><Standard Format,1>'); //HEI.13
                        TxtBuilder.AppendLine(FleRecord);
                    until TempCil1Buffer.Next() = 0;
                end;
                //BCUP0-103 BC Upgrade YADAVM09 <<
            end;

            trigger OnPreDataItem();
            begin

                CompanyInfo.GET();
                if (ShowActualBudget <> 0) and (ShowActualBudget <> 1) then
                    ERROR(Text000);

                //if ServerFileName = '' then ERROR(Text001);//Bc Upgrade YADAVM09<<

                // if EXISTS(ServerFileName) then //Bc Upgrade YADAVM09<<
                //   if CONFIRM(Text003, false) then ERASE(ServerFileName);//Bc Upgrade YADAVM09<<

                TabChar := 9;

                if ShowActualBudget = ShowActualBudget::"Actual Amounts" then begin
                    ItemAnalysisViewEntry.SETRANGE("Analysis Area", CurrentAnalysisArea);
                    ItemAnalysisViewEntry.SETRANGE("Analysis View Code", CurrentItemAnalysisViewCode);
                    //HEI.01>>
                    if InventoryPostingGroup <> '' then begin
                        ItemAnalysisViewEntry.CALCFIELDS("Inventory Posting Group FND");
                        ItemAnalysisViewEntry.SETFILTER("Inventory Posting Group FND", InventoryPostingGroup);
                    end;
                    //HEI.01<<
                    if Datefilter <> '' then
                        ItemAnalysisViewEntry.SETFILTER("Posting Date", Datefilter);
                    if ItemFilter <> '' then
                        ItemAnalysisViewEntry.SETFILTER("Item No.", ItemFilter);
                    //HEI.18
                    GeneralOpCoSetup.GET();
                    if GeneralOpCoSetup."Exclude Interreg. WIS and MSV" then
                        ItemAnalysisViewEntry.SETRANGE("Reporting Type FND", ItemAnalysisViewEntry."Reporting Type FND"::" ");
                    //HEI.18
                    ItemAnalysisViewEntry.FINDFIRST();
                end
                else begin
                    ItemAnalysisViewBudgetEntry.SETRANGE("Analysis Area", CurrentAnalysisArea);
                    ItemAnalysisViewBudgetEntry.SETRANGE("Analysis View Code", CurrentItemAnalysisViewCode);
                    if BudgetFilter <> '' then
                        ItemAnalysisViewBudgetEntry.SETRANGE("Budget Name", BudgetFilter);
                    if Datefilter <> '' then
                        ItemAnalysisViewBudgetEntry.SETFILTER("Posting Date", Datefilter);
                    if ItemFilter <> '' then
                        ItemAnalysisViewBudgetEntry.SETFILTER("Item No.", ItemFilter);
                    //HEI.01>>
                    if InventoryPostingGroup <> '' then begin
                        ItemAnalysisViewBudgetEntry.CALCFIELDS("Inventory Posting Group FND");
                        ItemAnalysisViewBudgetEntry.SETFILTER("Inventory Posting Group FND", InventoryPostingGroup);
                    end;
                    //HEI.01<<
                    ItemAnalysisViewBudgetEntry.FINDFIRST();
                end;

                Compinfo.GET('');
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
                    field(CurrentItemAnalysisViewCode; CurrentItemAnalysisViewCode)
                    {
                        CaptionML = ENU = 'Analysis View Code',
                                    FRA = 'Code vue analytique';
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            ItemAnalysisMgt.LookupItemAnalysisView(
                              CurrentAnalysisArea, CurrentItemAnalysisViewCode, ItemAnalysisView, ItemStatisticsBuffer,
                              Dim1Filter, Dim2Filter, Dim3Filter);
                        end;
                    }
                    field(ShowActualBudget; ShowActualBudget)
                    {
                        CaptionML = ENU = 'Show',
                                    FRA = 'Afficher';
                        OptionCaptionML = ENU = 'Actual Amounts,Budgeted Amounts,Variance,Variance%,Index%',
                                          FRA = 'Réalisé,Budgété,Ecart,% écart,% indice';
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<

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
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<

                        trigger OnValidate();
                        begin
                            if ShowActualBudget = ShowActualBudget::"Actual Amounts" then
                                if BudgetFilter <> '' then ERROR(Text006);
                        end;
                    }
                    field(ItemFilter; ItemFilter)
                    {
                        CaptionML = ENU = 'Item Filter',
                                    FRA = 'Filtre article';
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ItemList: Page "Item List";
                        begin
                            ItemList.LOOKUPMODE(true);
                            if ItemList.RUNMODAL() = ACTION::LookupOK then begin
                                Text := ItemList.GetSelectionFilter();
                                exit(true);
                            end;
                        end;
                    }
                    field(YearFilter; YearFilter)
                    {
                        CaptionML = ENU = 'Year',
                                    FRA = 'Année';
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<

                        trigger OnValidate();
                        begin
                            calcdatefilter();
                        end;
                    }
                    field(PeriodTypeFilter; PeriodTypeFilter)
                    {
                        CaptionML = ENU = 'Period type',
                                    FRA = 'Type période';
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<

                        trigger OnValidate();
                        begin
                            calcdatefilter();
                        end;
                    }
                    field(PeriodFilter; PeriodFilter)
                    {
                        CaptionML = ENU = 'Period',
                                    FRA = 'Période';
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<

                        trigger OnValidate();
                        begin
                            calcdatefilter();
                        end;
                    }
                    field(Calcfilter; Calcfilter)
                    {
                        CaptionML = ENU = 'Calculate',
                                    FRA = 'Calculer';
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<

                        trigger OnValidate();
                        begin
                            calcdatefilter();
                        end;
                    }
                    field(Datefilter; Datefilter)
                    {
                        CaptionML = ENU = 'Date Filter',
                                    FRA = 'Filtre date';
                        Editable = false;
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<
                    }
                    field(ItemCategoryCode; ItemCategoryCode)
                    {
                        Caption = 'Item Category Code';
                        Description = 'HEI.04';
                        TableRelation = "Item Category".Code;
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<
                    }
                    field(ClientFileName; ClientFileName)
                    {
                        CaptionML = ENU = 'File Name',
                                    FRA = 'Nom du fichier';
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<
                        //Bc Upgrade YADAVM09>>
                        // trigger OnAssistEdit();
                        // var
                        //     CommonDialogMgt: Codeunit "File Management";
                        // begin
                        //     ClientFileName := CommonDialogMgt.SaveFileDialog(Text002, ClientFileName, CommonDialogMgt.GetToFilterText('', '.txt'));
                        // end;
                        //Bc Upgrade YADAVM09<<
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            ItemCategoryCode := '01'; //HEI.04
            //BCUP0-103 BC Upgrade YADAVM09 >>
            Clear(HeaderWritten);
            if ClientFileName = '' then
                ClientFileName := 'CIL-1' + Format(Today) + '.txt';
            //BCUP0-103 BC Upgrade YADAVM09 <<
        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    begin

        // FleCIL1.CLOSE;Bc Upgrade YADAVM09<<

        // FileMgt.DownloadToFile(ServerFileName, ClientFileName);Bc Upgrade YADAVM09<<
        //Bc Upgrade YADAVM09>>
        //BCUP0-103 BC Upgrade YADAVM09 - Excel export stopped, replaced with Txt export below >>
        // MakeExcelDataHeader();
        // MakeExcelDataBody();
        // CreateExcelbook();
        TempBlob.CreateOutStream(FileOutStream, TextEncoding::UTF8);
        FileOutStream.WriteText(TxtBuilder.ToText());

        TempBlob.CreateInStream(FileInStream, TextEncoding::UTF8);

        if ClientFileName = '' then
            ClientFileName := 'CIL-1' + Format(Today) + '.txt'
        else
            if not ClientFileName.EndsWith('.txt') then
                ClientFileName += '.txt';

        DownloadFromStream(FileInStream, ExportToLbl, '', 'Text Files (*.txt)|*.txt', ClientFileName);
        //BCUP0-103 BC Upgrade YADAVM09 <<
        MESSAGE(Text005);
        TempCil1Buffer.DELETEALL();
        //Bc Upgrade YADAVM09<<
    end;

    trigger OnPreReport();
    var
        lrecPeriod: Record Date;
    begin

        //ServerFileName := FileMgt.ServerTempFileName('txt');Bc Upgrade YADAVM09<<
        ItemAnalysisView.GET(ItemAnalysisView."Analysis Area"::Sales, 'CIL1');

        //TempCil1Buffer := 1;
        //Bc Upgrade YADAVM09>>
        TempCil1Buffer.DELETEALL();
        // ExcelBuffer.DeleteAll(); //BCUP0-103 BC Upgrade YADAVM09 - Excel export stopped, ExcelBuffer no longer used
        //Bc Upgrade YADAVM09<<
    end;

    var
        CurrentItemAnalysisViewCode: Code[10];
        ShowActualBudget: Option "Actual Amounts","Budgeted Amounts",Variance,"Variance%","Index%";
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
        ItemAnalysisView: Record "Item Analysis View";
        ItemStatisticsBuffer: Record "Item Statistics Buffer";
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
        ItemAnalysisViewEntry: Record "Item Analysis View Entry";
        ItemAnalysisViewBudgetEntry: Record "Item Analysis View Budg. Entry";
        Compinfo: Record "Company Information";
        TempCil1Buffer: Record "CIL1 Export Buffer FND" temporary;
        FleCIL1: File;
        FleRecord: Text[1024];
        ServerFileName: Text;
        ClientFileName: Text;
        FileMgt: Codeunit "File Management";
        FileManagement: Codeunit "File Management";
        Text008: Label 'Nothing to Create.';
        Item: Record Item;
        Rec_Dimvalue: Record "Dimension Value";
        CompanyInfo: Record "Company Information";
        InventoryPostingGroup: Text;
        ItemCategoryCode: Code[20];
        FirstDayOfTheYearText: Text;
        FirstSundayOfTheYear: Date;
        FirstDayOfTheYear: Date;
        NoOfTheDay: Integer;
        TestDate: Date;
        i: Integer;
        NoOfTheDay2: Integer;
        LastDayOfTheYear: Date;
        lrecPeriodTMP: Record Date temporary;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        ELPQuantity: Decimal;
        LQuantity: Decimal;
        TotalInvQty: Decimal;
        InvoicedQty: Decimal;
        GeneralOpCoSetup: Record "General OpCo Setup FND";

    procedure Setdefaults(pCurrentAnalysisArea: Option Sales,Purchase,Inventory; PCurrentItemAnalysisViewCode: Code[10]; PShowActualBudget: Option "Actual Amounts","Budgeted Amounts",Variance,"Variance%","Index%"; PBudgetFilter: Code[250]; PItemFilter: Code[250]);
    begin
        CurrentAnalysisArea := pCurrentAnalysisArea;
        CurrentItemAnalysisViewCode := PCurrentItemAnalysisViewCode;
        ShowActualBudget := PShowActualBudget;
        BudgetFilter := PBudgetFilter;
        ItemFilter := PItemFilter;
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

            //HEI.10>>
            //HEI.11>>
            //IF YearFilter <> 2021 THEN
            if YearFilter < 2021 then
              //HEI.11<<
              begin
                //HEI.10<<
                lrecPeriod.RESET();
                lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
                lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Week);
                lrecPeriod.SETRANGE("Period No.", PeriodFilter);
                //HEI.10>>
            end;
            //HEI.10<<

            //HEI.10>>
            if YearFilter = 2021 then begin
                FirstDayOfTheYearText := '0101' + FORMAT(YearFilter);
                EVALUATE(FirstDayOfTheYear, FirstDayOfTheYearText);
                NoOfTheDay := DATE2DWY(FirstDayOfTheYear, 1);
                LastDayOfTheYear := DMY2DATE(31, 12, YearFilter);

                lrecPeriod.RESET();
                lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
                lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Week);
                lrecPeriod.SETRANGE("Period No.", PeriodFilter - 1);

                if lrecPeriod.FIND('-') then begin
                    //HEI.11>>
                    //IF PeriodFilter <> 53 THEN
                    if PeriodFilter < 52 then
                      //HEI.11<<
                      begin
                        Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(lrecPeriod."Period End");
                        EndDate := lrecPeriod."Period End";
                    end;
                    //HEI.11>>

                    /*IF PeriodFilter = 53 THEN
                      BEGIN
                        Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(CLOSINGDATE(LastDayOfTheYear));
                        EndDate :=lrecPeriod."Period End";
                      END;*/

                    if PeriodFilter = 52 then begin
                        Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(CLOSINGDATE(LastDayOfTheYear));
                        EndDate := lrecPeriod."Period End";
                    end;
                    if PeriodFilter > 52 then begin
                        Datefilter := FORMAT(lrecPeriod."Period Start" - 7) + '..' + FORMAT(CLOSINGDATE(LastDayOfTheYear));
                        EndDate := lrecPeriod."Period End";
                    end;
                    //HEI.11<<
                end;
                if not lrecPeriod.FINDFIRST() then
                    if PeriodFilter = 1 then begin
                        TestDate := FirstDayOfTheYear;
                        for i := 1 to 6 do begin
                            TestDate += 1;
                            NoOfTheDay2 := DATE2DWY(TestDate, 1);
                            if NoOfTheDay2 = 7 then
                                FirstSundayOfTheYear := TestDate;
                        end;
                        Datefilter := FORMAT(FirstDayOfTheYear) + '..' + FORMAT(CLOSINGDATE(FirstSundayOfTheYear));
                        EndDate := CLOSINGDATE(FirstSundayOfTheYear);
                    end;
            end;
            //HEI.10<<

            //HEI.11>>
            if YearFilter = 2022 then begin
                FirstDayOfTheYearText := '0101' + FORMAT(YearFilter);
                EVALUATE(FirstDayOfTheYear, FirstDayOfTheYearText);
                NoOfTheDay := DATE2DWY(FirstDayOfTheYear, 1);
                LastDayOfTheYear := DMY2DATE(31, 12, YearFilter);

                lrecPeriod.RESET();
                lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
                lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Week);
                lrecPeriod.SETRANGE("Period No.", PeriodFilter - 1);

                if lrecPeriod.FIND('-') then begin
                    if PeriodFilter < 52 then begin
                        Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(lrecPeriod."Period End");
                        EndDate := lrecPeriod."Period End";
                    end;
                    if PeriodFilter = 52 then begin
                        Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(CLOSINGDATE(LastDayOfTheYear));
                        EndDate := lrecPeriod."Period End";
                    end;
                    if PeriodFilter > 52 then begin
                        Datefilter := FORMAT(lrecPeriod."Period Start" - 8) + '..' + FORMAT(CLOSINGDATE(LastDayOfTheYear));
                        EndDate := lrecPeriod."Period End";
                    end;
                end;

                if not lrecPeriod.FINDFIRST() then
                    if PeriodFilter = 1 then begin
                        TestDate := FirstDayOfTheYear;
                        for i := 1 to 6 do begin
                            TestDate += 1;
                            NoOfTheDay2 := DATE2DWY(TestDate, 1);
                            if NoOfTheDay2 = 7 then
                                FirstSundayOfTheYear := TestDate;
                        end;
                        Datefilter := FORMAT(FirstDayOfTheYear) + '..' + FORMAT(CLOSINGDATE(FirstSundayOfTheYear));
                        EndDate := CLOSINGDATE(FirstSundayOfTheYear);
                    end;
            end;
            //HEI.11<<

            //HEI.15>>
            if YearFilter = 2023 then begin
                FirstDayOfTheYearText := '0101' + FORMAT(YearFilter);
                EVALUATE(FirstDayOfTheYear, FirstDayOfTheYearText);
                NoOfTheDay := DATE2DWY(FirstDayOfTheYear, 1);
                LastDayOfTheYear := DMY2DATE(31, 12, YearFilter);

                lrecPeriod.RESET();
                lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
                lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Week);
                lrecPeriod.SETRANGE("Period No.", PeriodFilter);

                if lrecPeriod.FIND('-') then begin
                    if PeriodFilter < 52 then begin
                        Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(lrecPeriod."Period End");
                        EndDate := lrecPeriod."Period End";
                    end;
                    if PeriodFilter = 52 then begin
                        //HEI.20>>
                        lrecPeriod.RESET();
                        lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
                        lrecPeriod.SETFILTER("Period Start", '%1..', DMY2DATE(1, 1, YearFilter));
                        lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Week);
                        lrecPeriod.SETRANGE("Period No.", PeriodFilter);
                        if lrecPeriod.FINDFIRST() then;
                        //HEI.20<<

                        //HEI.19>>
                        //Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(CLOSINGDATE(LastDayOfTheYear));
                        Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(CLOSINGDATE(LastDayOfTheYear));
                        //HEI.19<<
                        EndDate := lrecPeriod."Period End";
                    end;
                    if PeriodFilter > 52 then begin
                        Datefilter := FORMAT(lrecPeriod."Period Start" - 8) + '..' + FORMAT(CLOSINGDATE(LastDayOfTheYear));
                        EndDate := lrecPeriod."Period End";
                    end;
                end;

                if PeriodFilter = 1 then begin
                    TestDate := FirstDayOfTheYear;
                    for i := 3 to 9 do begin
                        TestDate += 1;
                        NoOfTheDay2 := DATE2DWY(TestDate, 1);
                        if NoOfTheDay2 = 7 then
                            FirstSundayOfTheYear := TestDate;
                    end;
                    Datefilter := FORMAT(FirstDayOfTheYear) + '..' + FORMAT(CLOSINGDATE(FirstSundayOfTheYear));
                    EndDate := CLOSINGDATE(FirstSundayOfTheYear);
                end;
            end;

            //HEI.22>>
            if YearFilter = 2024 then begin
                FirstDayOfTheYearText := '0101' + FORMAT(YearFilter);
                EVALUATE(FirstDayOfTheYear, FirstDayOfTheYearText);
                NoOfTheDay := DATE2DWY(FirstDayOfTheYear, 1);
                LastDayOfTheYear := DMY2DATE(31, 12, YearFilter);

                lrecPeriod.RESET();
                lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
                lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Week);
                lrecPeriod.SETRANGE("Period No.", PeriodFilter);

                if lrecPeriod.FIND('-') then begin
                    if PeriodFilter < 52 then begin
                        Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(lrecPeriod."Period End");
                        EndDate := lrecPeriod."Period End";
                    end;
                    if PeriodFilter = 52 then begin
                        lrecPeriod.RESET();
                        lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
                        lrecPeriod.SETFILTER("Period Start", '%1..', DMY2DATE(1, 1, YearFilter));
                        lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Week);
                        lrecPeriod.SETRANGE("Period No.", PeriodFilter);
                        if lrecPeriod.FINDFIRST() then;

                        Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(CLOSINGDATE(LastDayOfTheYear));
                        EndDate := lrecPeriod."Period End";
                    end;
                    if PeriodFilter > 52 then begin
                        //Datefilter := FORMAT(lrecPeriod."Period Start" - 7) + '..' + FORMAT(CLOSINGDATE(LastDayOfTheYear));
                        //Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(CLOSINGDATE(LastDayOfTheYear));
                        Datefilter := '';
                        EndDate := lrecPeriod."Period End";
                    end;
                end;
            end;

            if YearFilter = 2025 then begin
                FirstDayOfTheYearText := '0101' + FORMAT(YearFilter);
                EVALUATE(FirstDayOfTheYear, FirstDayOfTheYearText);
                NoOfTheDay := DATE2DWY(FirstDayOfTheYear, 1);
                LastDayOfTheYear := DMY2DATE(31, 12, YearFilter);

                lrecPeriod.RESET();
                lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
                lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Week);
                lrecPeriod.SETRANGE("Period No.", PeriodFilter);

                if lrecPeriod.FIND('-') then begin
                    if PeriodFilter < 52 then begin
                        Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(lrecPeriod."Period End");
                        EndDate := lrecPeriod."Period End";
                    end;
                    if PeriodFilter = 52 then begin
                        lrecPeriod.RESET();
                        lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
                        lrecPeriod.SETFILTER("Period Start", '%1..', DMY2DATE(1, 1, YearFilter));
                        lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Week);
                        lrecPeriod.SETRANGE("Period No.", PeriodFilter);
                        if lrecPeriod.FINDFIRST() then;

                        Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(CLOSINGDATE(LastDayOfTheYear));
                        EndDate := lrecPeriod."Period End";
                    end;
                    if PeriodFilter > 52 then begin
                        Datefilter := '';
                        EndDate := lrecPeriod."Period End";
                    end;
                end;
                if PeriodFilter = 1 then begin
                    TestDate := FirstDayOfTheYear;
                    for i := 3 to 9 do begin
                        TestDate += 1;
                        NoOfTheDay2 := DATE2DWY(TestDate, 1);
                        if NoOfTheDay2 = 7 then
                            FirstSundayOfTheYear := TestDate;
                    end;
                    Datefilter := FORMAT(FirstDayOfTheYear) + '..' + FORMAT(CLOSINGDATE(FirstSundayOfTheYear));
                    EndDate := CLOSINGDATE(FirstSundayOfTheYear);
                end;
            end;
            //HEI.22<<

            // BC Upgrade PATELS08 >>
            // HEI.23 >>
            IF YearFilter = 2026 THEN BEGIN
                FirstDayOfTheYearText := '0101' + FORMAT(YearFilter);
                EVALUATE(FirstDayOfTheYear, FirstDayOfTheYearText);
                NoOfTheDay := DATE2DWY(FirstDayOfTheYear, 1);
                LastDayOfTheYear := DMY2DATE(31, 12, YearFilter);

                lrecPeriod.RESET();
                lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
                lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Week);
                lrecPeriod.SETRANGE("Period No.", PeriodFilter);

                IF lrecPeriod.FIND('-') THEN BEGIN
                    IF PeriodFilter < 52 THEN BEGIN
                        //HEI.24>>
                        //Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(lrecPeriod."Period End");
                        //EndDate :=lrecPeriod."Period End";
                        IF PeriodFilter = 2 THEN BEGIN
                            Datefilter := FORMAT(20260101D) + '..' + FORMAT(lrecPeriod."Period End");
                            EndDate := lrecPeriod."Period End";
                        END
                        ELSE BEGIN
                            Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(lrecPeriod."Period End");
                            EndDate := lrecPeriod."Period End";
                        END;
                        //HEI.24<<
                    END;
                    IF PeriodFilter = 52 THEN BEGIN
                        lrecPeriod.RESET();
                        lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
                        lrecPeriod.SETFILTER("Period Start", '%1..', DMY2DATE(1, 1, YearFilter));
                        lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Week);
                        lrecPeriod.SETRANGE("Period No.", PeriodFilter);
                        IF lrecPeriod.FINDFIRST() THEN;

                        Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(CLOSINGDATE(LastDayOfTheYear));
                        EndDate := lrecPeriod."Period End";
                    END;
                    IF PeriodFilter > 52 THEN BEGIN
                        Datefilter := '';
                        EndDate := lrecPeriod."Period End";
                    END;
                END;
                IF PeriodFilter = 1 THEN BEGIN
                    TestDate := FirstDayOfTheYear;
                    FOR i := 3 TO 9 DO BEGIN
                        TestDate += 1;
                        NoOfTheDay2 := DATE2DWY(TestDate, 1);
                        IF NoOfTheDay2 = 7 THEN
                            FirstSundayOfTheYear := TestDate;
                    END;
                    Datefilter := FORMAT(FirstDayOfTheYear) + '..' + FORMAT(CLOSINGDATE(FirstSundayOfTheYear));
                    EndDate := CLOSINGDATE(FirstSundayOfTheYear);
                END;
            END;
            //HEI.23<

            //IF YearFilter > 2023 THEN //HEI.22
            //HEI.23>>
            //IF YearFilter > 2025 THEN //HEI.22
            IF YearFilter > 2026 THEN
                  //HEI.23<<
                  // BC Upgrade PATELS08 <<
                  begin
                lrecPeriod.RESET();
                lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
                lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Week);
                lrecPeriod.SETRANGE("Period No.", PeriodFilter);

                //HEI.19>>
                if lrecPeriod.FINDFIRST() then begin
                    Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(lrecPeriod."Period End");
                    EndDate := lrecPeriod."Period End";
                end;
                //HEI.19<<
            end;
            //HEI.15<<


        end;
        if (PeriodTypeFilter = PeriodTypeFilter::Month) and
           (PeriodFilter > 12) then
            ERROR(Text004);
        if (PeriodTypeFilter = PeriodTypeFilter::Month) then begin
            lrecPeriod.RESET();
            lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
            lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Month);
            lrecPeriod.SETRANGE("Period No.", PeriodFilter);
            if lrecPeriod.FINDFIRST() then
                Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(lrecPeriod."Period End");
        end;

        if (PeriodTypeFilter = PeriodTypeFilter::Quarter) and
           (PeriodFilter > 4) then
            ERROR(Text004);
        if (PeriodTypeFilter = PeriodTypeFilter::Quarter) then begin
            lrecPeriod.RESET();
            lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
            lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Quarter);
            lrecPeriod.SETRANGE("Period No.", PeriodFilter);
            if lrecPeriod.FINDFIRST() then
                Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(lrecPeriod."Period End");
        end;

        if Calcfilter = Calcfilter::"Net change" then exit;
        if Calcfilter = Calcfilter::"Year to date" then
            Datefilter := '0101' + FORMAT(YearFilter) + '..' + FORMAT(lrecPeriod."Period End");
        if Calcfilter = Calcfilter::"Rest of Year" then
            Datefilter := FORMAT(CALCDATE('<+1D>', lrecPeriod."Period End")) + '..' + FORMAT(DMY2DATE(31, 12, YearFilter));
        if Calcfilter = Calcfilter::"Balance to date" then
            Datefilter := '..' + FORMAT(lrecPeriod."Period End");

    end;

    procedure processBudgetEntries();
    var
        ItemBudgetName: Record "Item Budget Name";
        Item2: Record Item;
    begin
        if ItemAnalysisViewBudgetEntry.FINDSET() then
            repeat
                //HEI.04>>
                Item2.GET(ItemAnalysisViewBudgetEntry."Item No.");
                if Item2."Item Category Code" = ItemCategoryCode then begin
                    //HEI.04<<
                    TempCil1Buffer.INIT();
                    //HEI.10>>
                    //HEI.11>>
                    //IF YearFilter <> 2021 THEN
                    if YearFilter < 2021 then
                        //HEI.11<<
                        //HEI.10<<
                        TempCil1Buffer.CALWEEK := FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<Week>') + '.' +
                                        FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 4, '<Year4>');
                    //HEI.10>>
                    if YearFilter = 2021 then begin
                        if INCSTR(FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<Week>')) <> '54' then
                            TempCil1Buffer.CALWEEK := INCSTR(FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<Week>')) + '.' +
                                                      FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 4, '<Year4>');
                        //HEI.11>>
                        /*
                        IF INCSTR(FORMAT("Posting Date",2,'<Week>')) = '54' THEN
                          TempCil1Buffer.CALWEEK := '1.'+
                                                    FORMAT("Posting Date",4,'<Year4>');
                        */
                        if (INCSTR(FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<Week>')) = '54') and (DATE2DMY(ItemAnalysisViewBudgetEntry."Posting Date", 3) = 2021) and (DATE2DMY(ItemAnalysisViewBudgetEntry."Posting Date", 2) = 1) then
                            TempCil1Buffer.CALWEEK := '1.' +
                                                      FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 4, '<Year4>');
                        if (INCSTR(FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<Week>')) = '53') and (DATE2DMY(ItemAnalysisViewBudgetEntry."Posting Date", 3) = 2021) and (DATE2DMY(ItemAnalysisViewBudgetEntry."Posting Date", 2) = 12) then
                            TempCil1Buffer.CALWEEK := '52.' +
                                                      FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 4, '<Year4>');
                        //HEI.11
                    end;
                    //HEI.10<<
                    //HEI.11>>
                    if YearFilter = 2022 then begin
                        if INCSTR(FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<Week>')) <> '53' then
                            TempCil1Buffer.CALWEEK := INCSTR(FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<Week>')) + '.' +
                                                      FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 4, '<Year4>');
                        if (INCSTR(FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<Week>')) = '53') and (DATE2DMY(ItemAnalysisViewBudgetEntry."Posting Date", 3) = 2022) and (DATE2DMY(ItemAnalysisViewBudgetEntry."Posting Date", 2) = 1) then
                            TempCil1Buffer.CALWEEK := '1.' +
                                                      FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 4, '<Year4>');
                        if (INCSTR(FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<Week>')) = '53') and (DATE2DMY(ItemAnalysisViewBudgetEntry."Posting Date", 3) = 2022) and (DATE2DMY(ItemAnalysisViewBudgetEntry."Posting Date", 2) = 12) then
                            TempCil1Buffer.CALWEEK := '52.' +
                                                      FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 4, '<Year4>');
                    end;
                    //HEI.11<<
                    //HEI.15>>
                    if YearFilter = 2023 then begin
                        TempCil1Buffer.CALWEEK := FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<Week>') + '.' +
                                                  FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 4, '<Year4>');
                        if ItemAnalysisViewBudgetEntry."Posting Date" = 20230101D then
                            TempCil1Buffer.CALWEEK := '1.2023';
                    end;
                    //HEI.22>>
                    if YearFilter = 2024 then begin
                        TempCil1Buffer.CALWEEK := FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<Week>') + '.' +
                                                FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 4, '<Year4>');
                        if ((FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<Week>') = ' 1') and (DATE2DMY(ItemAnalysisViewBudgetEntry."Posting Date", 3) = 2024) and (DATE2DMY(ItemAnalysisViewBudgetEntry."Posting Date", 2) = 12)) then
                            TempCil1Buffer.CALWEEK := '52.' + FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 4, '<Year4>');
                    end;
                    //HEI.22<<

                    //HEI.25>>
                    IF YearFilter = 2025 THEN BEGIN
                        TempCil1Buffer.CALWEEK := FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<Week>') + '.' +
                                            FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 4, '<Year4>');
                        IF ((FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<Week>') = ' 1') AND (DATE2DMY(ItemAnalysisViewBudgetEntry."Posting Date", 3) = 2025) AND (DATE2DMY(ItemAnalysisViewBudgetEntry."Posting Date", 2) = 12)) THEN
                            TempCil1Buffer.CALWEEK := '52.' + FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 4, '<Year4>');
                    END;
                    //HEI.25<<

                    //HEI.22>>
                    //IF YearFilter > 2023 THEN
                    //HEI.25>>
                    //IF YearFilter > 2024 THEN
                    IF YearFilter > 2025 THEN
                        //HEI.25<<
                        //HEI.22<<
                        //HEI.26>>
                        IF ((FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<Week>') = ' 1') AND (DATE2DMY(ItemAnalysisViewBudgetEntry."Posting Date", 3) = 2026) AND (DATE2DMY(ItemAnalysisViewBudgetEntry."Posting Date", 2) = 1) AND
                            (PeriodFilter = 2)) THEN
                            TempCil1Buffer.CALWEEK := ' 2.' + FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 4, '<Year4>')
                        ELSE
                            //HEI.26<<
                        TempCil1Buffer.CALWEEK := FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<Week>') + '.' +
                                        FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 4, '<Year4>');
                    //HEI.15<<
                    TempCil1Buffer.COUNTRY := ItemAnalysisViewBudgetEntry."Add. Cust. Dim.2 FND";

                    if ItemAnalysisView."LineExt.DimCodIncl.inBRAND FND" and (STRPOS(ItemAnalysisViewBudgetEntry."Dimension 2 Value Code", 'L') <> 0) then begin
                        TempCil1Buffer.BRAND := COPYSTR(ItemAnalysisViewBudgetEntry."Dimension 2 Value Code", 1, STRPOS(ItemAnalysisViewBudgetEntry."Dimension 2 Value Code", 'L') - 1);
                        TempCil1Buffer.LINEXTEN := COPYSTR(ItemAnalysisViewBudgetEntry."Dimension 2 Value Code", STRPOS(ItemAnalysisViewBudgetEntry."Dimension 2 Value Code", 'L'));
                    end else begin
                        TempCil1Buffer.BRAND := ItemAnalysisViewBudgetEntry."Dimension 2 Value Code";
                        TempCil1Buffer.LINEXTEN := ItemAnalysisViewBudgetEntry."Line Ext. Dim. Val. Code FND";
                    end;


                    if Item.GET(ItemAnalysisViewBudgetEntry."Item No.") then
                        TempCil1Buffer."CIL ID" := Item."CIL ID Code RTR";
                    Rec_Dimvalue.RESET();
                    if Rec_Dimvalue.GET(ItemAnalysisView."Dimension 2 Code", ItemAnalysisViewBudgetEntry."Dimension 2 Value Code") then
                        TempCil1Buffer."Business Type" := Rec_Dimvalue."Business TypeDimValue Code FND";

                    TempCil1Buffer.MARKET := ItemAnalysisViewBudgetEntry."Add. Market type (BPG) FND";
                    TempCil1Buffer.PRODTYP := ItemAnalysisViewBudgetEntry."Add. Product type (PPG) FND";
                    if ItemBudgetName.GET(ItemAnalysisViewBudgetEntry."Budget Name") then
                        TempCil1Buffer.YVERSION := ItemBudgetName."Data Version Reference FND";

                    if TempCil1Buffer."Business Type" = '' then
                        TempCil1Buffer."Business Type" := Compinfo."Business Type FND";
                    if TempCil1Buffer.FIND() then begin
                        //TempCil1Buffer.QVLD02 += "Quantity in HL"; //Bc Upgrade YADAVM09 Aptean field
                        TempCil1Buffer.QVLD02 += ItemAnalysisViewBudgetEntry."Volume 1 FND";//Bc Upgrade YADAVM09
                        TempCil1Buffer.MODIFY();
                    end else begin
                        //  TempCil1Buffer.QVLD02 := "Quantity in HL"; //Bc Upgrade YADAVM09
                        TempCil1Buffer.QVLD02 += ItemAnalysisViewBudgetEntry."Volume 1 FND";//Bc Upgrade YADAVM09
                                                                                            //if "Quantity in HL" <> 0 then //Bc Upgrade YADAVM09
                        if ItemAnalysisViewBudgetEntry."Volume 1 FND" <> 0 then
                            TempCil1Buffer.INSERT();
                    end;
                end;
            //HEI.04
            until ItemAnalysisViewBudgetEntry.NEXT() = 0;
    end;

    procedure processEntries();
    var
        Item2: Record Item;
        BIBUnitVolumeHL: Decimal;//Bc Upgrade YADAVM09
        ItemUnitVolumeHL: Decimal;
        UnitVolumeHL: Decimal;
    begin
        if ItemAnalysisViewEntry.FINDSET() then
            repeat
                //HEI.04>>
                Item2.GET(ItemAnalysisViewEntry."Item No.");
                //HEI.05>>
                //IF Item2."Item Category Code" <> ItemCategoryCode THEN BEGIN
                if Item2."Item Category Code" = ItemCategoryCode then begin
                    //HEI.05<<
                    //HEI.04<<
                    TempCil1Buffer.INIT();
                    //HEI.10>>
                    //HEI.11>>
                    //IF YearFilter <> 2021 THEN
                    if YearFilter < 2021 then
                        //HEI.11<<
                        //HEI.10<<
                        TempCil1Buffer.CALWEEK := FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<Week>') + '.' +
                                        FORMAT(ItemAnalysisViewEntry."Posting Date", 4, '<Year4>');
                    //HEI.10>>
                    if YearFilter = 2021 then begin
                        if INCSTR(FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<Week>')) <> '54' then
                            TempCil1Buffer.CALWEEK := INCSTR(FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<Week>')) + '.' +
                                                      FORMAT(ItemAnalysisViewEntry."Posting Date", 4, '<Year4>');
                        //HEI.11>>
                        /*
                        IF INCSTR(FORMAT("Posting Date",2,'<Week>')) = '54' THEN
                          TempCil1Buffer.CALWEEK := '1.'+
                                                    FORMAT("Posting Date",4,'<Year4>');
                        */
                        if (INCSTR(FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<Week>')) = '54') and (DATE2DMY(ItemAnalysisViewEntry."Posting Date", 3) = 2021) and (DATE2DMY(ItemAnalysisViewEntry."Posting Date", 2) = 1) then
                            TempCil1Buffer.CALWEEK := '1.' +
                                                      FORMAT(ItemAnalysisViewEntry."Posting Date", 4, '<Year4>');
                        if (INCSTR(FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<Week>')) = '53') and (DATE2DMY(ItemAnalysisViewEntry."Posting Date", 3) = 2021) and (DATE2DMY(ItemAnalysisViewEntry."Posting Date", 2) = 12) then
                            TempCil1Buffer.CALWEEK := '52.' +
                                                      FORMAT(ItemAnalysisViewEntry."Posting Date", 4, '<Year4>');
                        //HEI.11<<
                    end;
                    //HEI.10<<
                    //HEI.11>>
                    if YearFilter = 2022 then begin
                        if INCSTR(FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<Week>')) <> '53' then
/*TempCil1Buffer.CALWEEK := INCSTR(FORMAT("Posting Date",2,'<Week>'))+'.'+
FORMAT("Posting Date",4,'<Year4>')*/;//HEI.12
                        TempCil1Buffer.CALWEEK := DELCHR((INCSTR(FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<Week>')) + '.' +
                                                  FORMAT(ItemAnalysisViewEntry."Posting Date", 4, '<Year4>')), '=', ' ');//HEI.12
                        if (INCSTR(FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<Week>')) = '53') and (DATE2DMY(ItemAnalysisViewEntry."Posting Date", 3) = 2022) and (DATE2DMY(ItemAnalysisViewEntry."Posting Date", 2) = 1) then
                            TempCil1Buffer.CALWEEK := '1.' +
                                                      FORMAT(ItemAnalysisViewEntry."Posting Date", 4, '<Year4>');
                        if (INCSTR(FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<Week>')) = '53') and (DATE2DMY(ItemAnalysisViewEntry."Posting Date", 3) = 2022) and (DATE2DMY(ItemAnalysisViewEntry."Posting Date", 2) = 12) then
                            TempCil1Buffer.CALWEEK := '52.' +
                                                      FORMAT(ItemAnalysisViewEntry."Posting Date", 4, '<Year4>');
                    end;
                    //HEI.11<<
                    //HEI.15>>
                    if YearFilter = 2023 then begin
                        TempCil1Buffer.CALWEEK := FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<Week>') + '.' +
                                                  FORMAT(ItemAnalysisViewEntry."Posting Date", 4, '<Year4>');
                        if ItemAnalysisViewEntry."Posting Date" = 20230101D then
                            TempCil1Buffer.CALWEEK := '1.2023';
                    end;
                    //HEI.22>>
                    if YearFilter = 2024 then begin
                        TempCil1Buffer.CALWEEK := FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<Week>') + '.' +
                                                FORMAT(ItemAnalysisViewEntry."Posting Date", 4, '<Year4>');
                        if ((FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<Week>') = ' 1') and (DATE2DMY(ItemAnalysisViewEntry."Posting Date", 3) = 2024) and (DATE2DMY(ItemAnalysisViewEntry."Posting Date", 2) = 12)) then
                            TempCil1Buffer.CALWEEK := '52.' + FORMAT(ItemAnalysisViewEntry."Posting Date", 4, '<Year4>');
                    end;
                    //HEI.22<<
                    //HEI.22>>
                    //IF YearFilter > 2023 THEN

                    //HEI.25>>
                    IF YearFilter = 2025 THEN BEGIN
                        TempCil1Buffer.CALWEEK := FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<Week>') + '.' +
                                                FORMAT(ItemAnalysisViewEntry."Posting Date", 4, '<Year4>');
                        IF ((FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<Week>') = ' 1') AND (DATE2DMY(ItemAnalysisViewEntry."Posting Date", 3) = 2025) AND (DATE2DMY(ItemAnalysisViewEntry."Posting Date", 2) = 12)) THEN
                            TempCil1Buffer.CALWEEK := '52.' + FORMAT(ItemAnalysisViewEntry."Posting Date", 4, '<Year4>');
                    END;
                    //HEI.25<<

                    //HEI.25>>
                    //IF YearFilter > 2024 THEN
                    IF YearFilter > 2025 THEN
                        //HEI.25<<
                        //HEI.22<<
                        //HEI.26>>
                        IF ((FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<Week>') = ' 1') AND (DATE2DMY(ItemAnalysisViewEntry."Posting Date", 3) = 2026) AND (DATE2DMY(ItemAnalysisViewEntry."Posting Date", 2) = 1) AND
                            (PeriodFilter = 2)) THEN
                            TempCil1Buffer.CALWEEK := ' 2.' + FORMAT(ItemAnalysisViewEntry."Posting Date", 4, '<Year4>')
                        ELSE
                            //HEI.26<<
                        TempCil1Buffer.CALWEEK := FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<Week>') + '.' +
                                        FORMAT(ItemAnalysisViewEntry."Posting Date", 4, '<Year4>');
                    //HEI.15<<
                    TempCil1Buffer.COUNTRY := ItemAnalysisViewEntry."Add. Cust. Dim.2 FND";

                    if ItemAnalysisView."LineExt.DimCodIncl.inBRAND FND" and (STRPOS(ItemAnalysisViewEntry."Dimension 2 Value Code", 'L') <> 0) then begin
                        TempCil1Buffer.BRAND := COPYSTR(ItemAnalysisViewEntry."Dimension 2 Value Code", 1, STRPOS(ItemAnalysisViewEntry."Dimension 2 Value Code", 'L') - 1);
                        TempCil1Buffer.LINEXTEN := COPYSTR(ItemAnalysisViewEntry."Dimension 2 Value Code", STRPOS(ItemAnalysisViewEntry."Dimension 2 Value Code", 'L'));
                    end else begin
                        TempCil1Buffer.BRAND := ItemAnalysisViewEntry."Dimension 2 Value Code";
                        TempCil1Buffer.LINEXTEN := ItemAnalysisViewEntry."Line Ext. Dim. Value Code FND";
                    end;
                    //HEI.09<<
                    TempCil1Buffer.P_PACKTYPE := ItemAnalysisViewEntry."Shortcut 1 Value Code FND";
                    TempCil1Buffer.CHANNEL := ItemAnalysisViewEntry."Shortcut 2 Value Code FND";
                    //HEI.09>>
                    if Item.GET(ItemAnalysisViewEntry."Item No.") then
                        TempCil1Buffer."CIL ID" := Item."CIL ID Code RTR";
                    Rec_Dimvalue.RESET();
                    if Rec_Dimvalue.GET(ItemAnalysisView."Dimension 2 Code", ItemAnalysisViewEntry."Dimension 2 Value Code") then
                        TempCil1Buffer."Business Type" := Rec_Dimvalue."Business TypeDimValue Code FND";

                    TempCil1Buffer.MARKET := ItemAnalysisViewEntry."Add. Market type (BPG) FND";
                    TempCil1Buffer.PRODTYP := ItemAnalysisViewEntry."Add. Product type (PPG) FND";
                    TempCil1Buffer.YVERSION := '100';

                    if TempCil1Buffer."Business Type" = '' then
                        TempCil1Buffer."Business Type" := Compinfo."Business Type FND";
                    //HEI.13>>
                    if Item.GET(ItemAnalysisViewEntry."Item No.") then;
                    if Item."Inventory Unit of Measure FND" = 'BIB' then begin
                        ItemUnitofMeasure.RESET();
                        ItemUnitofMeasure.SETRANGE("Item No.", ItemAnalysisViewEntry."Item No.");
                        ItemUnitofMeasure.SETFILTER(Code, '%1|%2', 'ELP', 'HL');//HEI.14
                        if ItemUnitofMeasure.FINDSET() then
                            repeat
                                Clear(BIBUnitVolumeHL);
                                clear(TotalInvQty);//Bc Upgrade YADAVM09<<
                                LQuantity := 0;
                                InvoicedQty := 0;
                                if ItemUnitofMeasure.Code = 'ELP' then
                                    ELPQuantity := ItemUnitofMeasure."Qty. per Unit of Measure";
                                if ItemUnitofMeasure.Code = 'HL' then//HEI.14
                                    LQuantity := ItemUnitofMeasure."Qty. per Unit of Measure";
                                if (LQuantity <> 0) and (ELPQuantity <> 0) then begin//HEI.17
                                                                                     //     TotalInvQty := (("Quantity in HL" * LQuantity) * (1 / ELPQuantity)) / 100;//HEI.16 //Bc Upgrade YADAVM09 Commented
                                                                                     //TotalInvQty := ((Round("Volume 1 101FDW") * LQuantity) * (1 / ELPQuantity)) / 100;//HEI.16 //Bc Upgrade YADAVM09 Added<<
                                    if Item2.Get((ItemAnalysisViewEntry."Item No.")) then
                                        BIBUnitVolumeHL := item."Unit Volume";
                                    TotalInvQty := (((ItemAnalysisViewEntry."Invoiced Quantity" * BIBUnitVolumeHL)) * LQuantity) * (1 / ELPQuantity) / 100;//HEI.16 //Bc Upgrade YADAVM09 Added<<

                                end;
                            until ItemUnitofMeasure.NEXT() = 0;
                        //end;
                        //HEI.13<<
                    end;

                    if TempCil1Buffer.FIND() then begin
                        //HEI.03>>
                        //TempCil1Buffer.QVLD02 += "Quantity in HL";
                        //HEI.05>>
                        //CALCSUMS(ItemAnalysisViewEntry."Invoiced Quantity in HL");//HEI.06
                        //HEI.05<<
                        TempCil1Buffer."BIB Quantity" += TotalInvQty;
                        //HEI.13
                        //TempCil1Buffer.QVLD02 += "Invoiced Quantity in HL"; //Bc Upgrade YADAVM09
                        //Bc Upgrade YADAVM09
                        if Item2.Get((ItemAnalysisViewEntry."Item No.")) then
                            UnitVolumeHL := item."Unit Volume";
                        //Bc Upgrade YADAVM09
                        TempCil1Buffer.QVLD02 += ItemAnalysisViewEntry."Invoiced Quantity" * UnitVolumeHL;
                        //Bc Upgrade YADAVM09
                        //HEI.03<<
                        TempCil1Buffer.MODIFY();
                    end else begin
                        //HEI.03>>
                        //TempCil1Buffer.QVLD02 := "Quantity in HL";
                        //IF "Quantity in HL" <> 0 THEN BEGIN
                        //HEI.05>>
                        //CALCSUMS(ItemAnalysisViewEntry."Invoiced Quantity in HL");//HEI.06
                        //HEI.05<<
                        TempCil1Buffer."BIB Quantity" := TotalInvQty;
                        //HEI.13
                        //Bc Upgrade YADAVM09>>
                        Clear(UnitVolumeHL);
                        if Item2.Get((ItemAnalysisViewEntry."Item No.")) then
                            UnitVolumeHL := item."Unit Volume";
                        //Bc Upgrade YADAVM09<<
                        //TempCil1Buffer.QVLD02 := "Invoiced Quantity in HL"; //BC Upgrade YADAVM09<<
                        TempCil1Buffer.QVLD02 += ItemAnalysisViewEntry."Invoiced Quantity" * UnitVolumeHL;
                        //BC Upgrade YADAVM09<<
                        if (ItemAnalysisViewEntry."Invoiced Quantity" * UnitVolumeHL <> 0) or (TotalInvQty <> 0) then
                            //HEI.13                                   
                            TempCil1Buffer.INSERT();
                        //HEI.03<<
                    end;
                end;
            //HEI.04
            until ItemAnalysisViewEntry.NEXT() = 0;

    end;
    //Bc Upgrade YADAVM09>>
    //BCUP0-103 BC Upgrade YADAVM09 - Excel export procedures below are no longer called
    // (see OnPostReport). Kept for reference only; safe to delete once the Txt export
    // has been validated in production.

    local procedure MakeExcelDataHeader();
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Reporting Entity', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Data Version', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('CALWEEK', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Business Type', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Product Type', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Brand', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Line Extension', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Primary Pack Type', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Market Type', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Channel', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Country of Consumption', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('CIL ID', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Quantity', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('BIB Quantity', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);

    end;

    local procedure MakeExcelDataBody();
    var
    begin
        ExcelBuffer.NewRow();
        if TempCil1Buffer.FINDSET() then
            repeat
                CompanyInfo.get();
                ExcelBuffer.AddColumn(CompanyInfo."Reporting Entity FND", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil1Buffer.YVERSION, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil1Buffer.CALWEEK, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil1Buffer."Business Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil1Buffer.PRODTYP, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil1Buffer.BRAND, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil1Buffer.LINEXTEN, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil1Buffer.P_PACKTYPE, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil1Buffer.MARKET, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil1Buffer.CHANNEL, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil1Buffer.COUNTRY, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil1Buffer."CIL ID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);

                if ShowActualBudget = ShowActualBudget::"Actual Amounts" then
                    ExcelBuffer.AddColumn(TempCil1Buffer.QVLD02 * -1, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number)
                else
                    ExcelBuffer.AddColumn(TempCil1Buffer.QVLD02, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);

                ExcelBuffer.AddColumn(TempCil1Buffer."BIB Quantity" * -1, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);

                ExcelBuffer.NewRow();
            until TempCil1Buffer.Next() = 0;
    end;


    local procedure CreateExcelbook();
    begin
        ExcelBuffer.CreateNewBook('CIL1');
        ExcelBuffer.WriteSheet('Data', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('CIL-1' + Format(Today));
        ExcelBuffer.OpenExcel();

    end;

    var
        ExcelBuffer: Record "Excel Buffer";
        //BCUP0-103 BC Upgrade YADAVM09 >>
        TempBlob: Codeunit "Temp Blob";
        FileOutStream: OutStream;
        FileInStream: InStream;
        TxtBuilder: TextBuilder;
        ExportToLbl: Label 'Export';
        HeaderWritten: Boolean;
    //BCUP0-103 BC Upgrade YADAVM09 <<

}
