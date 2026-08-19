report 55018 "Export CIL2"
{
    // version HEI.16

    // HEI.02 FDD-BPMGAP014 IBM ISYED01 08.10.2017
    //   #Migrated Report Export CIL1 from HEI2.0 to Base.
    // 
    // HEI.04 FDD-BPMGAP014 IBM NASTAA02 07.12.2017 # CIL Reporting Package
    //   # Column "Trading Partner" should be filled in with the "Reporting Entity" from Dimension Values
    // 
    // HEI.05 Defect #1329 IBM NASTAA02 04.01.2018 # Impossible to generate MSV Flatfile
    //   # Column "Channel Category" should be filled in with the "Dimension 1 Value Code" from Item Analysis View Entry
    //   # Column "Pack Type" should be filled in with the "Dimension 3 Value Code" from Item Analysis View Entry
    // 
    // HEI.06 Defect #1329 IBM NASTAA02 09.01.2018 # Impossible to generate MSV Flatfile
    //   # Replaced "Quantity in HL" with "Invoiced Quantity in HL" for column "Quantity
    // 
    // HEI.07 Defect #1329 IBM NASTAA02 25.01.2018 # Impossible to generate MSV Flatfile
    //   # Just Items with "Item Inventory Code" = '01' should be exported
    // 
    // HEI.08 Defect #1819 IBM SAPIED01 01.04.2018
    //   # Bug fix
    // HEI.09 INC1013609 IBM HORTOC01 17.01.2019 #bug fix
    // 
    // HEI.10 CHG2030732 PATHAA02 21.10.2019
    //   # Precision of the column-"Quantity" changed to add 3 mandatory Decimals (0:0 to 3:3)
    // 
    // HEI.11 CHG2161959 YADAVM05 02.11.2022# New coulumn added BIB Quantity
    // HEI.12 CHG2161959 YADAVM05 22.11.2022#Formula Change for BIB QUantity
    // HEI.13 CHG2161959 YADAVM05 22.11.2022#Formula Change for BIB QUantity
    //      #Change in Formula in place of Invoice Quantity Invoiced Quantity HL is Picked
    // HEI.14 CHG2191844  YADAVM05 09.02.2023 # Change in codition for ELP Quantity not equal to zero.
    // HEI.15 CHG2213905 YADAVM09 28.07.2023 #Please help us to have correct MSV flat file structure.
    //      #ADD  code to seprate column value of Quantity and BIB Quantity
    // HEI.16 IBM YADAVM09 12/10/23 CHG2218600_HB3954 DRC Interredional transfer exclusion from WIS MSV
    // #Added filter to exclude Transfer entries

    //Bc upgrade YADAVM09 Report is redesign as per excel format.
    //Bc Upgrade YADAVM09 old id 50020.
    //Bc Upgrade YADAVM09,28.04.26 PID-475, PID-503, PID-504, PID-505, PID-535, PID-536, PID-537, PID-758GAP ID: IBM GAP RTR 09.
    //Bc Upgrade YADAVM09 BCUP0167.
    Caption = 'Export CIL2';//Bc Upgrade YADAVM09,28.04.26<<
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;//Bc Upgrade YADAVM09<<

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
                //Bc Upgrade YADAVM09 Commented>>
                //FleCIL2.CREATE(ServerFileName);
                //FleCIL2.TEXTMODE := true;
                //FleCIL2.WRITEMODE := TRUE;              
                // if TempCil2Buffer.FIND('-') then begin
                //     FleCIL2.TEXTMODE := true;
                //     FleRecord := 'Reporting company' + FORMAT(TabChar);
                //     FleRecord += 'Data version' + FORMAT(TabChar);
                //     FleRecord += 'Month' + FORMAT(TabChar);
                //     FleRecord += 'Business type' + FORMAT(TabChar);
                //     FleRecord += 'Product type' + FORMAT(TabChar);
                //     FleRecord += 'Brand' + FORMAT(TabChar);
                //     FleRecord += 'Line extension' + FORMAT(TabChar);
                //     FleRecord += 'Primary Pack type' + FORMAT(TabChar);
                //     FleRecord += 'Market type' + FORMAT(TabChar);
                //     FleRecord += 'Channel category' + FORMAT(TabChar);
                //     FleRecord += 'Country of Consumption' + FORMAT(TabChar);
                //     FleRecord += 'Trading Partner' + FORMAT(TabChar);
                //     FleRecord += 'CL ID' + FORMAT(TabChar);
                //     FleRecord += 'Quantity' + FORMAT(TabChar);
                //     FleRecord += 'BIB Quantity' + FORMAT(TabChar);//HEI.11
                //     FleCIL2.WRITE(FleRecord);
                //     repeat
                //         FleRecord := Compinfo."Reporting Entity" + FORMAT(TabChar);
                //         FleRecord += TempCil2Buffer."Data Version" + FORMAT(TabChar);
                //         FleRecord += TempCil2Buffer.Time + FORMAT(TabChar);
                //         FleRecord += TempCil2Buffer."Business Type" + FORMAT(TabChar);
                //         FleRecord += TempCil2Buffer."Product Type" + FORMAT(TabChar);
                //         FleRecord += TempCil2Buffer.Brand + FORMAT(TabChar);
                //         FleRecord += TempCil2Buffer."Line Extension" + FORMAT(TabChar);
                //         FleRecord += TempCil2Buffer."Pack type" + FORMAT(TabChar);
                //         FleRecord += TempCil2Buffer."Market type" + FORMAT(TabChar);
                //         FleRecord += TempCil2Buffer."Channel category" + FORMAT(TabChar);
                //         FleRecord += TempCil2Buffer.Country + FORMAT(TabChar);
                //         FleRecord += TempCil2Buffer."Trading partner" + FORMAT(TabChar);
                //         FleRecord += TempCil2Buffer."CIL ID" + FORMAT(TabChar);
                //         if ShowActualBudget = ShowActualBudget::"Actual Amounts" then
                //             //FleRecord += FORMAT((ROUND(TempCil2Buffer.Quantity,1)*-1),20,'<Precision,0:0><Standard Format,1>')
                //             FleRecord += FORMAT((TempCil2Buffer.Quantity * -1), 20, '<Precision,3:3><Standard Format,1>') + FORMAT(TabChar)//HEI.15
                //         else
                //             //FleRecord += FORMAT(ROUND(TempCil2Buffer.Quantity,1),20,'<Precision,0:0><Standard Format,1>');     //HEI.10
                //             FleRecord += FORMAT(TempCil2Buffer.Quantity, 20, '<Precision,3:3><Standard Format,1>') + FORMAT(TabChar);//HEI.15
                //         FleRecord += FORMAT((TempCil2Buffer."BIB Quantity" * -1), 20, '<Precision,3:3><Standard Format,1>');//HEI.11
                //         FleCIL2.WRITE(FleRecord);
                //     until TempCil2Buffer.NEXT = 0;
                // end;
                // MESSAGE(Text005);
                //Bc Upgrade YADAVM09 Commented<<
                // #BCUP0-103 BC Upgrade YADAVM09>>
                if TempCil2Buffer.FindSet() then begin
                    if not HeaderWritten then begin
                        FleRecord := 'Reporting company' + FORMAT(TabChar);
                        FleRecord += 'Data version' + FORMAT(TabChar);
                        FleRecord += 'Month' + FORMAT(TabChar);
                        FleRecord += 'Business type' + FORMAT(TabChar);
                        FleRecord += 'Product type' + FORMAT(TabChar);
                        FleRecord += 'Brand' + FORMAT(TabChar);
                        FleRecord += 'Line extension' + FORMAT(TabChar);
                        FleRecord += 'Primary Pack type' + FORMAT(TabChar);
                        FleRecord += 'Market type' + FORMAT(TabChar);
                        FleRecord += 'Channel category' + FORMAT(TabChar);
                        FleRecord += 'Country of Consumption' + FORMAT(TabChar);
                        FleRecord += 'Trading Partner' + FORMAT(TabChar);
                        FleRecord += 'CL ID' + FORMAT(TabChar);
                        FleRecord += 'Quantity' + FORMAT(TabChar);
                        FleRecord += 'BIB Quantity' + FORMAT(TabChar);//HEI.11
                        TxtBuilder.AppendLine(FleRecord);
                        HeaderWritten := true;
                    end;
                    repeat
                        FleRecord := Compinfo."Reporting Entity fnd" + FORMAT(TabChar);
                        FleRecord += TempCil2Buffer."Data Version" + FORMAT(TabChar);
                        FleRecord += TempCil2Buffer.Time + FORMAT(TabChar);
                        FleRecord += TempCil2Buffer."Business Type" + FORMAT(TabChar);
                        FleRecord += TempCil2Buffer."Product Type" + FORMAT(TabChar);
                        FleRecord += TempCil2Buffer.Brand + FORMAT(TabChar);
                        FleRecord += TempCil2Buffer."Line Extension" + FORMAT(TabChar);
                        FleRecord += TempCil2Buffer."Pack type" + FORMAT(TabChar);
                        FleRecord += TempCil2Buffer."Market type" + FORMAT(TabChar);
                        FleRecord += TempCil2Buffer."Channel category" + FORMAT(TabChar);
                        FleRecord += TempCil2Buffer.Country + FORMAT(TabChar);
                        FleRecord += TempCil2Buffer."Trading partner" + FORMAT(TabChar);
                        FleRecord += TempCil2Buffer."CIL ID" + FORMAT(TabChar);
                        if ShowActualBudget = ShowActualBudget::"Actual Amounts" then
                            //FleRecord += FORMAT((ROUND(TempCil2Buffer.Quantity,1)*-1),20,'<Precision,0:0><Standard Format,1>')
                            FleRecord += FORMAT((TempCil2Buffer.Quantity * -1), 20, '<Precision,3:3><Standard Format,1>') + FORMAT(TabChar)//HEI.15
                        else
                            //FleRecord += FORMAT(ROUND(TempCil2Buffer.Quantity,1),20,'<Precision,0:0><Standard Format,1>');     //HEI.10
                            FleRecord += FORMAT(TempCil2Buffer.Quantity, 20, '<Precision,3:3><Standard Format,1>') + FORMAT(TabChar);//HEI.15
                        FleRecord += FORMAT((TempCil2Buffer."BIB Quantity" * -1), 20, '<Precision,3:3><Standard Format,1>');//HEI.11
                        TxtBuilder.AppendLine(FleRecord);
                    until TempCil2Buffer.Next() = 0;
                end;
                // #BCUP0-103 BC Upgrade YADAVM09 <<
            end;

            trigger OnPreDataItem();
            begin
                CompanyInfo.GET;
                if (ShowActualBudget <> 0) and (ShowActualBudget <> 1) then
                    ERROR(Text000);
                //Bc Upgrade YADAVM09 Commented>>
                //if ServerFileName = '' then ERROR(Text001);
                // if EXISTS(ServerFileName) then
                //   if CONFIRM(Text003, false) then ERASE(ServerFileName);
                //Bc Upgrade YADAVM09 Commented<<

                TabChar := 9;

                if ShowActualBudget = ShowActualBudget::"Actual Amounts" then begin
                    ItemAnalysisViewEntry.SETRANGE("Analysis Area", CurrentAnalysisArea);
                    ItemAnalysisViewEntry.SETRANGE("Analysis View Code", CurrentItemAnalysisViewCode);

                    if Datefilter <> '' then
                        ItemAnalysisViewEntry.SETFILTER("Posting Date", Datefilter);
                    if ItemFilter <> '' then
                        ItemAnalysisViewEntry.SETFILTER("Item No.", ItemFilter);
                    //HEI.16
                    GeneralOpCoSetup.GET;
                    if GeneralOpCoSetup."Exclude Interreg. WIS and MSV" then
                        ItemAnalysisViewEntry.SETRANGE("Reporting Type FND", ItemAnalysisViewEntry."Reporting Type FND"::" ");
                    //HEI.16
                    //HEI.03>>
                    if InventoryPostingGroup <> '' then begin
                        ItemAnalysisViewEntry.CALCFIELDS("Inventory Posting Group FND");
                        ItemAnalysisViewEntry.SETFILTER("Inventory Posting Group FND", InventoryPostingGroup);
                    end;
                    //HEI.03<<
                    ItemAnalysisViewEntry.FINDFIRST;
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
                    //HEI.03>>
                    if InventoryPostingGroup <> '' then begin
                        ItemAnalysisViewBudgetEntry.CALCFIELDS("Inventory Posting Group FND");
                        ItemAnalysisViewBudgetEntry.SETFILTER("Inventory Posting Group FND", InventoryPostingGroup);
                    end;
                    //HEI.03<<
                    ItemAnalysisViewBudgetEntry.FINDFIRST;
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
                            if ItemList.RUNMODAL = ACTION::LookupOK then begin
                                Text := ItemList.GetSelectionFilter;
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
                        Description = 'HEI.07';
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
            PeriodTypeFilter := PeriodTypeFilter::Month;
            ItemCategoryCode := '01'; //HEI.07
        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        // FleCIL2.CLOSE; //Bc Upgrade YADAVM09>>

        // FileMgt.DownloadToFile(ServerFileName, ClientFileName);  //Bc Upgrade YADAVM09>>
        //Bc Upgrade YADAVM09<<
        // MakeExcelDataHeader();
        // MakeExcelDataBody();
        // CreateExcelbook();

        TempBlob.CreateOutStream(FileOutStream, TextEncoding::UTF8);
        FileOutStream.WriteText(TxtBuilder.ToText());
        TempBlob.CreateInStream(FileInStream, TextEncoding::UTF8);

        if ClientFileName = '' then
            ClientFileName := 'CIL-2' + Format(Today) + '.txt'
        else
            if not ClientFileName.EndsWith('.txt') then
                ClientFileName += '.txt';

        DownloadFromStream(FileInStream, ExportToLbl, '', 'Text Files (*.txt)|*.txt', ClientFileName);
        // #BCUP0-103 BC Upgrade YADAVM09 <<
        MESSAGE(Text005);
        TempCil2Buffer.DELETEALL();
        //Bc Upgrade YADAVM09<<
    end;

    trigger OnPreReport();
    begin
        Clear(HeaderWritten);//Bc Upgrade YADAVM09<<
        ItemAnalysisView.GET(ItemAnalysisView."Analysis Area"::Sales, 'CIL2');
        CurrentItemAnalysisViewCode := 'CIL2';
        // ServerFileName := FileMgt.ServerTempFileName('txt'); // //Bc Upgrade YADAVM09<<
        //Bc Upgrade YADAVM09>>
        TempCil2Buffer.DELETEALL();
        ExcelBuffer.DeleteAll();
        //Bc Upgrade YADAVM09<<
    end;

    var
        CurrentItemAnalysisViewCode: Code[10];
        // #BCUP0-103 BC Upgrade YADAVM09 >>
        TempBlob: Codeunit "Temp Blob";
        FileOutStream: OutStream;
        FileInStream: InStream;
        TxtBuilder: TextBuilder;
        ExportToLbl: Label 'Export';
        HeaderWritten: Boolean;
        // #BCUP0-103 BC Upgrade YADAVM09 <<
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
        TempCil2Buffer: Record "CIL2 Export Buffer FND" temporary;
        FleCIL2: File;
        FleRecord: Text[1024];
        ServerFileName: Text;
        ClientFileName: Text;
        FileMgt: Codeunit "File Management";
        FileManagement: Codeunit "File Management";
        Text008: Label 'Nothing to Create.';
        Rec_Dimvalue: Record "Dimension Value";
        CompanyInfo: Record "Company Information";
        InventoryPostingGroup: Text;
        DimensionValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        ItemCategoryCode: Code[20];
        ItemAnalysisViewEntry2: Record "Item Analysis View Entry";
        LQuantity: Decimal;
        InvoicedQty: Decimal;
        TotalInvQty: Decimal;
        ELPQuantity: Decimal;
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
           //(PeriodFilter > 5) THEN ERROR(Text004);
           (PeriodFilter > 53) then
            ERROR(Text004);
        if (PeriodTypeFilter = PeriodTypeFilter::Week) then begin
            lrecPeriod.RESET;
            lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
            lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Week);
            lrecPeriod.SETRANGE("Period No.", PeriodFilter);
            if lrecPeriod.FIND('-') then
                Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(lrecPeriod."Period End");
        end;

        if (PeriodTypeFilter = PeriodTypeFilter::Month) and
           (PeriodFilter > 12) then
            ERROR(Text004);
        if (PeriodTypeFilter = PeriodTypeFilter::Month) then begin
            lrecPeriod.RESET;
            lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
            lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Month);
            lrecPeriod.SETRANGE("Period No.", PeriodFilter);
            if lrecPeriod.FIND('-') then
                Datefilter := FORMAT(lrecPeriod."Period Start") + '..' + FORMAT(lrecPeriod."Period End");
        end;

        if (PeriodTypeFilter = PeriodTypeFilter::Quarter) and
           (PeriodFilter > 4) then
            ERROR(Text004);
        if (PeriodTypeFilter = PeriodTypeFilter::Quarter) then begin
            lrecPeriod.RESET;
            lrecPeriod.SETFILTER("Period End", '%1..', DMY2DATE(1, 1, YearFilter));
            lrecPeriod.SETRANGE("Period Type", lrecPeriod."Period Type"::Quarter);
            lrecPeriod.SETRANGE("Period No.", PeriodFilter);
            if lrecPeriod.FIND('-') then
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
        Item: Record Item;
        Item2: Record Item;
    begin
        if ItemAnalysisViewBudgetEntry.FIND('-') then
            repeat
                //HEI.07>>
                Item2.GET(ItemAnalysisViewBudgetEntry."Item No.");
                if Item2."Item Category Code" = ItemCategoryCode then begin
                    //HEI.07<<
                    TempCil2Buffer.INIT();
                    TempCil2Buffer.Time := FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 2, '<month>') +
                                              FORMAT(ItemAnalysisViewBudgetEntry."Posting Date", 4, '<Year4>');
                    TempCil2Buffer."Product Type" := ItemAnalysisViewBudgetEntry."Add. Product type R1 (PPG) FND";

                    if ItemAnalysisView."LineExt.DimCodIncl.inBRAND FND" and (STRPOS(ItemAnalysisViewBudgetEntry."Dimension 2 Value Code", 'L') <> 0) then begin
                        TempCil2Buffer.Brand := COPYSTR(ItemAnalysisViewBudgetEntry."Dimension 2 Value Code", 1, STRPOS(ItemAnalysisViewBudgetEntry."Dimension 2 Value Code", 'L') - 1);
                        TempCil2Buffer."Line Extension" := COPYSTR(ItemAnalysisViewBudgetEntry."Dimension 2 Value Code", STRPOS(ItemAnalysisViewBudgetEntry."Dimension 2 Value Code", 'L'));
                    end else begin
                        TempCil2Buffer.Brand := ItemAnalysisViewBudgetEntry."Dimension 2 Value Code";
                        TempCil2Buffer."Line Extension" := ItemAnalysisViewBudgetEntry."Line Ext. Dim. Val. Code FND";
                    end;

                    Rec_Dimvalue.RESET;
                    if Rec_Dimvalue.GET(ItemAnalysisView."Dimension 2 Code", ItemAnalysisViewBudgetEntry."Dimension 2 Value Code") then
                        TempCil2Buffer."Business Type" := Rec_Dimvalue."Business TypeDimValue Code FND";
                    if ItemBudgetName.GET(ItemAnalysisViewBudgetEntry."Budget Name") then
                        TempCil2Buffer."Data Version" := ItemBudgetName."Data Version Reference FND";
                    //HEI.05>>
                    //IF Rec_Dimvalue.GET(ItemAnalysisView."Dimension 3 Code","Dimension 3 Value Code") THEN
                    //TempCil2Buffer."Pack type" := Rec_Dimvalue."CIL Code";
                    TempCil2Buffer."Pack type" := ItemAnalysisViewBudgetEntry."Dimension 3 Value Code";
                    //HEI.05<<
                    TempCil2Buffer."Market type" := ItemAnalysisViewBudgetEntry."Add. Market type (BPG) FND";
                    //HEI.05>>
                    //IF Rec_Dimvalue.GET(ItemAnalysisView."Dimension 1 Code","Dimension 1 Value Code") THEN
                    //TempCil2Buffer."Channel category" := Rec_Dimvalue."CIL Code";
                    TempCil2Buffer."Channel category" := ItemAnalysisViewBudgetEntry."Dimension 1 Value Code";
                    //HEI.05<<
                    TempCil2Buffer.Country := ItemAnalysisViewBudgetEntry."Add. Cust. Dim.2 FND";
                    //HEI.04>>
                    //TempCil2Buffer."Trading partner" := "Add. Cust. Dim.1";
                    GLSetup.GET;
                    if DimensionValue.GET(GLSetup."OPCO Dimension Code FND", ItemAnalysisViewBudgetEntry."Add. Cust. Dim.1 FND") then
                        TempCil2Buffer."Trading partner" := DimensionValue."Reporting Entity FND";
                    //HEI.04<<
                    if Item.GET(ItemAnalysisViewBudgetEntry."Item No.") then
                        TempCil2Buffer."CIL ID" := Item."CIL ID2 Code RTR";

                    if TempCil2Buffer."Business Type" = '' then
                        TempCil2Buffer."Business Type" := Compinfo."Business Type FND";

                    if TempCil2Buffer.FIND then begin
                        // TempCil2Buffer.Quantity += "Quantity in HL"; //Bc Upgrade YADAVM09- Aptean does not created this field on Item budget.
                        TempCil2Buffer.Quantity += ItemAnalysisViewBudgetEntry."Volume 1 FND";//Bc Upgrade YADAVM09<<
                        TempCil2Buffer.MODIFY;
                    end else begin
                        // TempCil2Buffer.Quantity := "Quantity in HL"; //Bc Upgrade YADAVM09- Aptean does not created this field on Item budget.
                        TempCil2Buffer.Quantity += ItemAnalysisViewBudgetEntry."Volume 1 FND";//Bc Upgrade YADAVM09<<
                                                                                              //if "Quantity in HL" <> 0 then //Bc Upgrade YADAVM09 Commented - Aptean does not created this field on Item budget.
                        if ItemAnalysisViewBudgetEntry."Volume 1 FND" <> 0 then
                            //Bc Upgrade YADAVM09<<
                            TempCil2Buffer.INSERT;
                    end;
                end;
            //HEI.07
            until ItemAnalysisViewBudgetEntry.NEXT = 0;
    end;

    procedure processEntries();
    var
        Item: Record Item;
        Item2: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        BibitemunitofMeasure: Decimal;
        UnitVolumeHL: Decimal;//Bc Upgrade YADAVM09<<
        BIBUnitVolumeHL: Decimal;
    begin
        if ItemAnalysisViewEntry.FIND('-') then
            repeat
                //HEI.07>>
                Item2.GET(ItemAnalysisViewEntry."Item No.");
                if Item2."Item Category Code" = ItemCategoryCode then begin
                    //HEI.07<<
                    TempCil2Buffer.INIT;
                    TempCil2Buffer.Time := FORMAT(ItemAnalysisViewEntry."Posting Date", 2, '<month>') +
                                              FORMAT(ItemAnalysisViewEntry."Posting Date", 4, '<Year4>');
                    TempCil2Buffer."Product Type" := ItemAnalysisViewEntry."Add. Product type R1 (PPG) FND";

                    if ItemAnalysisView."LineExt.DimCodIncl.inBRAND FND" and (STRPOS(ItemAnalysisViewEntry."Dimension 2 Value Code", 'L') <> 0) then begin
                        TempCil2Buffer.Brand := COPYSTR(ItemAnalysisViewEntry."Dimension 2 Value Code", 1, STRPOS(ItemAnalysisViewEntry."Dimension 2 Value Code", 'L') - 1);
                        TempCil2Buffer."Line Extension" := COPYSTR(ItemAnalysisViewEntry."Dimension 2 Value Code", STRPOS(ItemAnalysisViewEntry."Dimension 2 Value Code", 'L'));
                    end else begin
                        TempCil2Buffer.Brand := ItemAnalysisViewEntry."Dimension 2 Value Code";
                        TempCil2Buffer."Line Extension" := ItemAnalysisViewEntry."Line Ext. Dim. Value Code FND";
                    end;

                    Rec_Dimvalue.RESET;
                    if Rec_Dimvalue.GET(ItemAnalysisView."Dimension 2 Code", ItemAnalysisViewEntry."Dimension 2 Value Code") then
                        TempCil2Buffer."Business Type" := Rec_Dimvalue."Business TypeDimValue Code FND";
                    TempCil2Buffer."Data Version" := '100';
                    //HEI.05>>
                    //IF Rec_Dimvalue.GET(ItemAnalysisView."Dimension 3 Code","Dimension 3 Value Code") THEN
                    //TempCil2Buffer."Pack type" := Rec_Dimvalue."CIL Code";
                    TempCil2Buffer."Pack type" := ItemAnalysisViewEntry."Dimension 3 Value Code";
                    //HEI.05<<
                    TempCil2Buffer."Market type" := ItemAnalysisViewEntry."Add. Market type (BPG) FND";
                    //HEI.05>>
                    //IF Rec_Dimvalue.GET(ItemAnalysisView."Dimension 1 Code","Dimension 1 Value Code") THEN
                    //TempCil2Buffer."Channel category" := Rec_Dimvalue."CIL Code";
                    TempCil2Buffer."Channel category" := ItemAnalysisViewEntry."Dimension 1 Value Code";
                    //HEI.05<<
                    TempCil2Buffer.Country := ItemAnalysisViewEntry."Add. Cust. Dim.2 FND";
                    //HEI.04>>
                    //TempCil2Buffer."Trading partner" := "Add. Cust. Dim.1";
                    GLSetup.GET;
                    if DimensionValue.GET(GLSetup."OPCO Dimension Code FND", ItemAnalysisViewEntry."Add. Cust. Dim.1 FND") then
                        TempCil2Buffer."Trading partner" := DimensionValue."Reporting Entity FND";
                    //HEI.04<<
                    if Item.GET(ItemAnalysisViewEntry."Item No.") then
                        TempCil2Buffer."CIL ID" := Item."CIL ID2 Code RTR";

                    if TempCil2Buffer."Business Type" = '' then
                        TempCil2Buffer."Business Type" := Compinfo."Business Type FND";
                    //HEI.11>>
                    if Item.GET(ItemAnalysisViewEntry."Item No.") then;
                    if Item."Inventory Unit of Measure FND" = 'BIB' then begin
                        //YADAVM09 Blocked
                        ItemUnitofMeasure.RESET;
                        ItemUnitofMeasure.SETRANGE("Item No.", ItemAnalysisViewEntry."Item No.");
                        ItemUnitofMeasure.SETFILTER(Code, '%1|%2', 'ELP', 'HL');//HEI.12
                        if ItemUnitofMeasure.FINDSET then
                            repeat
                                LQuantity := 0;
                                InvoicedQty := 0;
                                TotalInvQty := 0;//Bc Upgrade YADAVM09<<
                                if ItemUnitofMeasure.Code = 'ELP' then
                                    ELPQuantity := ItemUnitofMeasure."Qty. per Unit of Measure";
                                if ItemUnitofMeasure.Code = 'HL' then//HEI.12
                                    LQuantity := ItemUnitofMeasure."Qty. per Unit of Measure";
                                if (LQuantity <> 0) and (ELPQuantity <> 0) then begin//HEI.14
                                                                                     // TotalInvQty := (("Quantity in HL" * LQuantity) * (1 / ELPQuantity)) / 100;//HEI.13 //Bc Upgrade YADAVM09 Commented<<
                                                                                     //TotalInvQty := (("Volume 1 101FDW" * LQuantity) * (1 / ELPQuantity)) / 100;//HEI.13 //Bc Upgrade YADAVM09<<
                                    if Item2.Get((ItemAnalysisViewEntry."Item No.")) then
                                        BIBUnitVolumeHL := item."Unit Volume";
                                    TotalInvQty := (((ItemAnalysisViewEntry."Invoiced Quantity" * BIBUnitVolumeHL)) * LQuantity) * (1 / ELPQuantity) / 100;//HEI.16 //Bc Upgrade YADAVM09 Added<<

                                end;
                            until ItemUnitofMeasure.NEXT = 0;
                    end;
                    //HEI.11<<
                    if TempCil2Buffer.FIND then begin
                        //HEI.06>>
                        //TempCil2Buffer.Quantity += "Quantity in HL";
                        //HEI.08>>
                        //CALCSUMS("Invoiced Quantity in HL");//HEI.09
                        //HEI.08<<
                        // TempCil2Buffer.Quantity += "Invoiced Quantity in HL"; //Bc Upgrade YADAVM09<<
                        //Bc Upgrade YADAVM09>>
                        if Item2.Get((ItemAnalysisViewEntry."Item No.")) then
                            UnitVolumeHL := item."Unit Volume";//Bc Upgrade YADAVM09 BCUP0167<<
                        TempCil2Buffer.Quantity += ItemAnalysisViewEntry."Invoiced Quantity" * UnitVolumeHL;
                        //Bc Upgrade YADAVM09<<
                        TempCil2Buffer."BIB Quantity" += TotalInvQty;
                        //HEI.11
                        //HEI.06<<
                        TempCil2Buffer.MODIFY;
                    end else begin
                        //HEI.06>>
                        //TempCil2Buffer.Quantity := "Quantity in HL";
                        //IF "Quantity in HL" <> 0 THEN
                        //TempCil2Buffer.Quantity := "Invoiced Quantity in HL"; //Bc Upgrade YADAVM09<<
                        //Bc Upgrade YADAVM09>>
                        if Item2.Get((ItemAnalysisViewEntry."Item No.")) then
                            UnitVolumeHL := item."Unit Volume";//Bc Upgrade YADAVM09 BCUP0167<<
                        TempCil2Buffer.Quantity += ItemAnalysisViewEntry."Invoiced Quantity" * UnitVolumeHL;
                        //Bc Upgrade YADAVM09<<
                        TempCil2Buffer."BIB Quantity" := TotalInvQty;
                        //HEI.11
                        //   HEI.08>>
                        //   CALCSUMS("Invoiced Quantity in HL");//HEI.09
                        //   HEI.08<<
                        if (ItemAnalysisViewEntry."Invoiced Quantity" * UnitVolumeHL <> 0) or (TotalInvQty <> 0) then
                            //HEI.11   
                            //HEI.06<<
                            TempCil2Buffer.INSERT;
                    end;
                end;
            //HEI.07
            until ItemAnalysisViewEntry.NEXT = 0;
    end;
    //Bc Upgrade YADAVM09>>

    local procedure MakeExcelDataHeader();
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Reporting company', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Data Version', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Month', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Business Type', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Product Type', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Brand', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Line Extension', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Primary Pack Type', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Market Type', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Channel category', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Country of Consumption', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('CIL ID', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Quantity', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('BIB Quantity', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);

    end;

    local procedure MakeExcelDataBody();
    var
    begin
        ExcelBuffer.NewRow();
        if TempCil2Buffer.FINDSET then begin
            repeat
                CompanyInfo.get;
                ExcelBuffer.AddColumn(CompanyInfo."Reporting Entity FND", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil2Buffer."Data Version", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil2Buffer.Time, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil2Buffer."Business Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil2Buffer."Product Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil2Buffer.BRAND, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil2Buffer."Line Extension", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil2Buffer."Pack type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil2Buffer."Market type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil2Buffer."Channel category", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil2Buffer.COUNTRY, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TempCil2Buffer."CIL ID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);

                if ShowActualBudget = ShowActualBudget::"Actual Amounts" then
                    ExcelBuffer.AddColumn(TempCil2Buffer.Quantity * -1, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number)
                else
                    ExcelBuffer.AddColumn(TempCil2Buffer.Quantity, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);

                ExcelBuffer.AddColumn(TempCil2Buffer."BIB Quantity" * -1, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);

                ExcelBuffer.NewRow();
            until TempCil2Buffer.Next() = 0;


        end;
    end;

    local procedure CreateExcelbook();
    begin
        ExcelBuffer.CreateNewBook('CIL-2' + Format(Today));
        ExcelBuffer.WriteSheet('Data', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('CIL-2' + Format(Today));
        ExcelBuffer.OpenExcel();

    end;

    var
        ExcelBuffer: Record "Excel Buffer";
    //Bc Upgrade YADAVM09<<
}

