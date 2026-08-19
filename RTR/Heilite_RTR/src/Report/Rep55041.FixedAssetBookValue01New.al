report 55041 "Fixed Asset - Book Value 01New"
{
    // version NAVW110.0,HEI.09

    // 
    // HEI.01 FDD_CHG0246293 IBM ISYED01 10.10.2018 #Asset Quantity and Tag No info in FA Card  to incl. Quantiy, Tag No.
    //   # new filed Quantity and Tag No added to Report.
    // 
    // HEI.02 FDD-CHG0252873IBM Isyed01 10.10.2018
    //   # Added Three additional columns in "FA book value 01" report
    //   #"Depreciation Starting Date","Depreciation Ending Date","No. of Depreciation Years" to the report design.
    // HEI.03 FDD_Ethiopia_Customized FA Book Value_V1.0_HT640 IBM HORTOC01 01.07.2019 # new columns
    // HEI.04 FDD-HB1159 BULIMC01 IBM 02.03.2020 #new column added to the report "Acc Imp/App"
    // HEI.05 Defect # 5699 IBM.GUNERE01 # Report Layout Sum for grouptotals fixed
    // HEI.06  YADAVM05 09.03.2023 CHG2187935_HB3211 code added to skip CMG Mandatory check on report
    // HEI.07  YADAVM05 20.03.2023 CHG2187935_HB3211 code added to skip CMG Mandatory check on report
    // HEI.08  YADAVM05 29.03.2023 CHG2198032_HB3211 Changing Documentation part from CHG2187935_HB3211 to CHG2198032_HB3211
    // HEI.09  YADAVM05 17.05.2023 CHG2198032_HB3211 CMG Code Mandatory Additional Ticket
    //  #Blocking code as this Part handled using Mandatory setup
    // BC Upgrade BHARDA11 >>
    // 1. OLD Report ID- 5605.
    // 2. "In NAV, the 'Fixed Asset - Book Value 01' report was modified. However, it contained custom code tagged with 'HEI' that didn't correspond to any events also there are many changes in layout, and this is not possible by report extension. To address this, I created a copy of the report and replaced the original report with a substitute event."
    // 3. Add layout path and change layout extension rdlc to rdl.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Fixed Asset - Book Value 01.rdl';
    Caption = 'Fixed Asset - Book Value 01';
    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            RequestFilterFields = "No.", "FA Class Code", "FA Subclass Code", "Budgeted Asset";
            column(MainHeadLineText_FA; MainHeadLineText)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(DeprBookText_FA; DeprBookText)
            {
            }
            column(TableFilter_FA; TABLECAPTION + ': ' + FAFilter)
            {
            }
            column(Filter_FA; FAFilter)
            {
            }
            column(PrintDetails; PrintDetails)
            {
            }
            column(GroupTotals; SELECTSTR(GroupTotals + 1, GroupTotalsTxt))
            {
            }
            column(GroupCodeName; GroupCodeName)
            {
            }
            column(HeadLineText1; HeadLineText[1])
            {
            }
            column(HeadLineText2; HeadLineText[2])
            {
            }
            column(HeadLineText3; HeadLineText[3])
            {
            }
            column(HeadLineText4; HeadLineText[4])
            {
            }
            column(HeadLineText5; HeadLineText[5])
            {
            }
            column(HeadLineText6; HeadLineText[6])
            {
            }
            column(HeadLineText7; HeadLineText[7])
            {
            }
            column(HeadLineText8; HeadLineText[8])
            {
            }
            column(HeadLineText9; HeadLineText[9])
            {
            }
            column(HeadLineText10; HeadLineText[10])
            {
            }
            column(FANo; FANo)
            {
            }
            column(Desc_FA; FADescription)
            {
            }
            column(GroupHeadLine; GroupHeadLine)
            {
            }
            column(No_FA; "No.")
            {
            }
            column(Quantity_FA; "Fixed Asset"."Quantity FND")
            {
            }
            column(TagNo_FA; "Fixed Asset"."Tag No FND")
            {
            }
            column(FADep_StartingDate; FADeprBook."Depreciation Starting Date")
            {
            }
            column(FADep_EndingDate; FADeprBook."Depreciation Ending Date")
            {
            }
            column(FADep_depYears; FADeprBook."No. of Depreciation Years")
            {
            }
            column(Description_FA; Description)
            {
            }
            column(StartAmounts1; StartAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(NetChangeAmounts1; NetChangeAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(DisposalAmounts1; DisposalAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmounts1; TotalEndingAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(StartAmounts2; StartAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(NetChangeAmounts2; NetChangeAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(DisposalAmounts2; DisposalAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmounts2; TotalEndingAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(BookValueAtStartingDate; BookValueAtStartingDate)
            {
                AutoFormatType = 1;
            }
            column(BookValueAtEndingDate; BookValueAtEndingDate)
            {
                AutoFormatType = 1;
            }
            column(FormatGrpTotGroupHeadLine; FORMAT(Text002 + ': ' + GroupHeadLine))
            {
            }
            column(GroupStartAmounts1; GroupStartAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(GroupNetChangeAmounts1; GroupNetChangeAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(GroupDisposalAmounts1; GroupDisposalAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(GroupStartAmounts2; GroupStartAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(GroupNetChangeAmounts2; GroupNetChangeAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(GroupDisposalAmounts2; GroupDisposalAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(TotalStartAmounts1; TotalStartAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(TotalNetChangeAmounts1; TotalNetChangeAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(TotalDisposalAmounts1; TotalDisposalAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(TotalStartAmounts2; TotalStartAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(TotalNetChangeAmounts2; TotalNetChangeAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(TotalDisposalAmounts2; TotalDisposalAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(NetChangeAmountsReclas1; NetChangeAmountsReclas[1])
            {
                AutoFormatType = 1;
            }
            column(NetChangeAmountsNonReclas1; NetChangeAmountsNonReclas[1])
            {
                AutoFormatType = 1;
            }
            column(GroupNetChangeAmountsReclas1; GroupNetChangeAmountsReclas[1])
            {
            }
            column(GroupNetChangeAmountsNonReclas1; GroupNetChangeAmountsNonReclas[1])
            {
            }
            column(HeadLineTextReclas1; HeadLineTextReclas[1])
            {
            }
            column(HeadLineTextReclas2; HeadLineTextReclas[2])
            {
            }
            column(AccAmount; AccAmount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF NOT FADeprBook.GET("No.", DeprBookCode) THEN
                    CurrReport.SKIP;
                IF SkipRecord THEN
                    CurrReport.SKIP;

                IF GroupTotals = GroupTotals::"FA Posting Group" THEN
                    IF "FA Posting Group" <> FADeprBook."FA Posting Group" THEN
                        ERROR(Text007, FIELDCAPTION("FA Posting Group"), "No.");

                BeforeAmount := 0;
                EndingAmount := 0;
                IF BudgetReport THEN
                    BudgetDepreciation.Calculate(
                      "No.", GetStartingDate(StartingDate), EndingDate, DeprBookCode, BeforeAmount, EndingAmount);

                i := 0;
                WHILE i < NumberOfTypes DO BEGIN
                    i := i + 1;
                    CASE i OF
                        1:
                            PostingType := FADeprBook.FIELDNO("Acquisition Cost");
                        2:
                            PostingType := FADeprBook.FIELDNO(Depreciation);
                        3:
                            PostingType := FADeprBook.FIELDNO("Write-Down");
                        4:
                            PostingType := FADeprBook.FIELDNO(Appreciation);
                        5:
                            PostingType := FADeprBook.FIELDNO("Custom 1");
                        6:
                            PostingType := FADeprBook.FIELDNO("Custom 2");

                    END;
                    IF StartingDate <= 00000101D THEN
                        StartAmounts[i] := 0
                    ELSE
                        StartAmounts[i] := FAGenReport.CalcFAPostedAmount("No.", PostingType, Period1, StartingDate,
                            EndingDate, DeprBookCode, BeforeAmount, EndingAmount, FALSE, TRUE);
                    NetChangeAmounts[i] :=
                      FAGenReport.CalcFAPostedAmount(
                        "No.", PostingType, Period2, StartingDate, EndingDate,
                        DeprBookCode, BeforeAmount, EndingAmount, FALSE, TRUE);
                    //HEI.03>>
                    NetChangeAmountsReclas[i] :=
                    //   FAGenReport.CalcFAPostedAmountSplitAmount(
                      CalcFAPostedAmountSplitAmount(
                        "No.", PostingType, Period2, StartingDate, EndingDate,
                        DeprBookCode, BeforeAmount, EndingAmount, FALSE, TRUE, TRUE);

                    NetChangeAmountsNonReclas[i] :=
                    //   FAGenReport.CalcFAPostedAmountSplitAmount(
                     CalcFAPostedAmountSplitAmount(
                        "No.", PostingType, Period2, StartingDate, EndingDate,
                        DeprBookCode, BeforeAmount, EndingAmount, FALSE, TRUE, FALSE);
                    //HEI.03<<
                    IF GetPeriodDisposal THEN
                        DisposalAmounts[i] := -(StartAmounts[i] + NetChangeAmounts[i])
                    ELSE
                        DisposalAmounts[i] := 0;
                    IF i >= 3 THEN
                        AddPostingType(i - 3);
                END;
                FOR j := 1 TO NumberOfTypes DO
                    TotalEndingAmounts[j] := StartAmounts[j] + NetChangeAmounts[j] + DisposalAmounts[j];
                BookValueAtEndingDate := 0;
                BookValueAtStartingDate := 0;
                FOR j := 1 TO NumberOfTypes DO BEGIN
                    BookValueAtEndingDate := BookValueAtEndingDate + TotalEndingAmounts[j];
                    BookValueAtStartingDate := BookValueAtStartingDate + StartAmounts[j];
                END;

                //HEI.04
                CLEAR(AccAmount);
                FALedgerEntry.SETRANGE("FA No.", "No.");
                FALedgerEntry.SETRANGE("FA Posting Date", StartingDate, EndingDate);
                FALedgerEntry.SETRANGE("Depreciation Book Code", DeprBookCode);
                FALedgerEntry.SETFILTER("FA Posting Type", '%1|%2', FALedgerEntry."FA Posting Type"::Appreciation, FALedgerEntry."FA Posting Type"::"Write-Down");
                IF FALedgerEntry.FINDSET THEN
                    REPEAT
                        AccAmount += FALedgerEntry.Amount;
                    UNTIL FALedgerEntry.NEXT = 0;
                //HEI.04<<

                MakeGroupHeadLine;
                UpdateTotals;
                CreateGroupTotals;
            end;

            trigger OnPostDataItem()
            begin
                CreateTotals;
            end;

            trigger OnPreDataItem()
            begin

                CASE GroupTotals OF
                    GroupTotals::"FA Class":
                        SETCURRENTKEY("FA Class Code");
                    GroupTotals::"FA Subclass":
                        SETCURRENTKEY("FA Subclass Code");
                    GroupTotals::"FA Location":
                        SETCURRENTKEY("FA Location Code");
                    GroupTotals::"Main Asset":
                        SETCURRENTKEY("Component of Main Asset");
                    GroupTotals::"Global Dimension 1":
                        SETCURRENTKEY("Global Dimension 1 Code");
                    GroupTotals::"Global Dimension 2":
                        SETCURRENTKEY("Global Dimension 2 Code");
                    GroupTotals::"FA Posting Group":
                        SETCURRENTKEY("FA Posting Group");
                END;
            end;
        }
    }

    requestpage
    {
        Caption = 'Fixed Asset - Book Value 01';
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DeprBookCode; DeprBookCode)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Depreciation Book';
                        TableRelation = "Depreciation Book";
                        ToolTip = 'Specifies the code for the depreciation book to be included in the report or batch job.';
                    }
                    field(StartingDate; StartingDate)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the date when you want the report to start.';
                    }
                    field(EndingDate; EndingDate)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Ending Date';
                        ToolTip = 'Specifies the date when you want the report to end.';
                    }
                    field(GroupTotals; GroupTotals)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Group Totals';
                        OptionCaption = ' ,FA Class,FA Subclass,FA Location,Main Asset,Global Dimension 1,Global Dimension 2,FA Posting Group';
                        ToolTip = 'Specifies if you want the report to group fixed assets and print totals using the category defined in this field. For example, maintenance expenses for fixed assets can be shown for each fixed asset class.';
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Print per Fixed Asset';
                        ToolTip = 'Specifies if you want the report to print information separately for each fixed asset.';
                    }
                    field(BudgetReport; BudgetReport)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Budget Report';
                        ToolTip = 'Specifies if you want the report to calculate future depreciation and book value. This is valid only if you have selected Depreciation and Book Value for Amount Field 1, 2 or 3.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            GetDepreciationBookCode;
        end;
    }

    labels
    {
        Qtylbl = 'Quantity';
        Tagnolbl = 'Tag No';
        DepSDatelbl = 'Depreciation Start Date';
        DepEDatelbl = 'Depreciation End Date';
        DepYearslbl = 'Depreciation Years';
        AccImpAppLbl = 'Acc Imp/App';
    }

    trigger OnPostReport()
    begin
        //HEI.08
        //FABool := FALSE;HEI.09
        //FAMandatorySingleInstance.InitalizeFA(FABool);HEI.09
        //HEI.08
    end;

    trigger OnPreReport()
    begin
        NumberOfTypes := 6;
        //FABool := TRUE;//HEI.09
        //FAMandatorySingleInstance.InitalizeFA(FABool);//HEI.09
        DeprBook.GET(DeprBookCode);
        IF GroupTotals = GroupTotals::"FA Posting Group" THEN
            FAGenReport.SetFAPostingGroup("Fixed Asset", DeprBook.Code);
        FAGenReport.AppendFAPostingFilter("Fixed Asset", StartingDate, EndingDate);
        FAFilter := "Fixed Asset".GETFILTERS;
        MainHeadLineText := Text000;
        IF BudgetReport THEN
            MainHeadLineText := STRSUBSTNO('%1 %2', MainHeadLineText, Text001);
        DeprBookText := STRSUBSTNO('%1%2 %3', DeprBook.TABLECAPTION, ':', DeprBookCode);
        MakeGroupTotalText;
        FAGenReport.ValidateDates(StartingDate, EndingDate);
        MakeDateText;
        MakeHeadLine;
        IF PrintDetails THEN BEGIN
            FANo := "Fixed Asset".FIELDCAPTION("No.");
            FADescription := "Fixed Asset".FIELDCAPTION(Description);
        END;
        Period1 := Period1::"Before Starting Date";
        Period2 := Period2::"Net Change";
    end;

    var
        Text000: Label 'Fixed Asset - Book Value 01';
        Text001: Label '(Budget Report)';
        Text002: Label 'Group Total';
        Text003: Label 'Group Totals';
        Text004: Label 'in Period';
        Text005: Label 'Disposal';
        Text006: Label 'Addition';
        Text007: Label '%1 has been modified in fixed asset %2.';
        FASetup: Record "FA Setup";
        DeprBook: Record "Depreciation Book";
        FADeprBook: Record "FA Depreciation Book";
        FA: Record "Fixed Asset";
        FAPostingTypeSetup: Record "FA Posting Type Setup";
        FAGenReport: Codeunit "FA General Report";
        BudgetDepreciation: Codeunit "Budget Depreciation";
        DeprBookCode: Code[10];
        FAFilter: Text;
        MainHeadLineText: Text[100];
        DeprBookText: Text[50];
        GroupCodeName: Text[50];
        GroupHeadLine: Text[50];
        FANo: Text[50];
        FADescription: Text[50];
        GroupTotals: Option " ","FA Class","FA Subclass","FA Location","Main Asset","Global Dimension 1","Global Dimension 2","FA Posting Group";
        HeadLineText: array[14] of Text[50];
        StartAmounts: array[7] of Decimal;
        NetChangeAmounts: array[7] of Decimal;
        DisposalAmounts: array[7] of Decimal;
        GroupStartAmounts: array[7] of Decimal;
        GroupNetChangeAmounts: array[7] of Decimal;
        GroupDisposalAmounts: array[7] of Decimal;
        TotalStartAmounts: array[7] of Decimal;
        TotalNetChangeAmounts: array[7] of Decimal;
        TotalDisposalAmounts: array[7] of Decimal;
        TotalEndingAmounts: array[7] of Decimal;
        BookValueAtStartingDate: Decimal;
        BookValueAtEndingDate: Decimal;
        i: Integer;
        j: Integer;
        NumberOfTypes: Integer;
        PostingType: Integer;
        Period1: Option "Before Starting Date","Net Change","at Ending Date";
        Period2: Option "Before Starting Date","Net Change","at Ending Date";
        StartingDate: Date;
        EndingDate: Date;
        PrintDetails: Boolean;
        BudgetReport: Boolean;
        BeforeAmount: Decimal;
        EndingAmount: Decimal;
        AcquisitionDate: Date;
        DisposalDate: Date;
        StartText: Text[30];
        EndText: Text[30];
        PageCaptionLbl: Label 'Page';
        TotalCaptionLbl: Label 'Total';
        GroupTotalsTxt: Label ' ,FA Class,FA Subclass,FA Location,Main Asset,Global Dimension 1,Global Dimension 2,FA Posting Group';
        NetChangeAmountsReclas: array[7] of Decimal;
        NetChangeAmountsNonReclas: array[7] of Decimal;
        qu: Query "Item Analysis View Source";
        HeadLineTextReclas: array[10] of Text[50];
        GroupNetChangeAmountsReclas: array[7] of Decimal;
        GroupNetChangeAmountsNonReclas: array[7] of Decimal;
        DerogDeprBook: Record "Depreciation Book";
        HasDerogatorySetup: Boolean;
        FADeprBook2: Record "FA Depreciation Book";
        DeprBookInfo: array[5] of Text[30];
        DerogDeprBookInfo: array[5] of Text[30];
        Text10800: Label 'Increased in Period';
        Text10801: Label 'Decreased in Period';
        CompanyInfo: Record "Company Information";
        FALedgerEntry: Record "FA Ledger Entry";
        AccAmount: Decimal;
        FALedgerEntry2: Record "FA Ledger Entry";
        FAMandatorySingleInstance: Codeunit "FA Mandatory Single Inst. CBN";
        FABool: Boolean;

    local procedure AddPostingType(PostingType: Option "Write-Down",Appreciation,"Custom 1","Custom 2")
    var
        i: Integer;
        j: Integer;
    begin
        i := PostingType + 3;
        CASE PostingType OF
            PostingType::"Write-Down":
                FAPostingTypeSetup.GET(DeprBookCode, FAPostingTypeSetup."FA Posting Type"::"Write-Down");
            PostingType::Appreciation:
                FAPostingTypeSetup.GET(DeprBookCode, FAPostingTypeSetup."FA Posting Type"::Appreciation);
            PostingType::"Custom 1":
                FAPostingTypeSetup.GET(DeprBookCode, FAPostingTypeSetup."FA Posting Type"::"Custom 1");
            PostingType::"Custom 2":
                FAPostingTypeSetup.GET(DeprBookCode, FAPostingTypeSetup."FA Posting Type"::"Custom 2");
        END;
        IF FAPostingTypeSetup."Depreciation Type" THEN
            j := 2
        ELSE
            IF FAPostingTypeSetup."Acquisition Type" THEN
                j := 1;
        IF j > 0 THEN BEGIN
            StartAmounts[j] := StartAmounts[j] + StartAmounts[i];
            StartAmounts[i] := 0;
            NetChangeAmounts[j] := NetChangeAmounts[j] + NetChangeAmounts[i];
            NetChangeAmounts[i] := 0;

            //HEI.03>>
            NetChangeAmountsReclas[j] := NetChangeAmountsReclas[j] + NetChangeAmountsReclas[i];
            NetChangeAmountsReclas[i] := 0;

            NetChangeAmountsNonReclas[j] := NetChangeAmountsNonReclas[j] + NetChangeAmountsNonReclas[i];
            NetChangeAmountsNonReclas[i] := 0;
            //HEI.03<<
            DisposalAmounts[j] := DisposalAmounts[j] + DisposalAmounts[i];
            DisposalAmounts[i] := 0;
        END;
    end;

    local procedure SkipRecord(): Boolean
    begin
        AcquisitionDate := FADeprBook."Acquisition Date";
        DisposalDate := FADeprBook."Disposal Date";
        EXIT(
          "Fixed Asset".Inactive OR
          (AcquisitionDate = 0D) OR
          (AcquisitionDate > EndingDate) AND (EndingDate > 0D) OR
          (DisposalDate > 0D) AND (DisposalDate < StartingDate))
    end;

    local procedure GetPeriodDisposal(): Boolean
    begin
        IF DisposalDate > 0D THEN
            IF (EndingDate = 0D) OR (DisposalDate <= EndingDate) THEN
                EXIT(TRUE);
        EXIT(FALSE);
    end;

    local procedure MakeGroupTotalText()
    begin
        CASE GroupTotals OF
            GroupTotals::"FA Class":
                GroupCodeName := FORMAT("Fixed Asset".FIELDCAPTION("FA Class Code"));
            GroupTotals::"FA Subclass":
                GroupCodeName := FORMAT("Fixed Asset".FIELDCAPTION("FA Subclass Code"));
            GroupTotals::"FA Location":
                GroupCodeName := FORMAT("Fixed Asset".FIELDCAPTION("FA Location Code"));
            GroupTotals::"Main Asset":
                GroupCodeName := FORMAT("Fixed Asset".FIELDCAPTION("Main Asset/Component"));
            GroupTotals::"Global Dimension 1":
                GroupCodeName := FORMAT("Fixed Asset".FIELDCAPTION("Global Dimension 1 Code"));
            GroupTotals::"Global Dimension 2":
                GroupCodeName := FORMAT("Fixed Asset".FIELDCAPTION("Global Dimension 2 Code"));
            GroupTotals::"FA Posting Group":
                GroupCodeName := FORMAT("Fixed Asset".FIELDCAPTION("FA Posting Group"));
        END;
        IF GroupCodeName <> '' THEN
            GroupCodeName := FORMAT(STRSUBSTNO('%1%2 %3', Text003, ':', GroupCodeName));
    end;

    local procedure MakeDateText()
    begin
        StartText := STRSUBSTNO('%1', StartingDate - 1);
        EndText := STRSUBSTNO('%1', EndingDate);
    end;

    local procedure MakeHeadLine()
    var
        InPeriodText: Text[30];
        DisposalText: Text[30];
    begin
        InPeriodText := Text004;
        DisposalText := Text005;
        HeadLineText[1] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION("Acquisition Cost"), StartText);
        //HeadLineText[2] := STRSUBSTNO('%1 %2',Text006,InPeriodText);//HEI.03

        //HEI.03>>
        HeadLineText[2] := STRSUBSTNO('%1 %2 %3', Text006, InPeriodText, '(Total)');
        HeadLineTextReclas[1] := STRSUBSTNO('%1 %2 %3', Text006, InPeriodText, '(Reclassification)');
        HeadLineTextReclas[2] := STRSUBSTNO('%1 %2 %3', Text006, InPeriodText, '(Except Reclassification)');
        //HEI.03<<

        HeadLineText[3] := STRSUBSTNO('%1 %2', DisposalText, InPeriodText);
        HeadLineText[4] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION("Acquisition Cost"), EndText);
        HeadLineText[5] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION(Depreciation), StartText);
        HeadLineText[6] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION(Depreciation), InPeriodText);
        HeadLineText[7] := STRSUBSTNO(
            '%1 %2 %3', DisposalText, FADeprBook.FIELDCAPTION(Depreciation), InPeriodText);
        HeadLineText[8] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION(Depreciation), EndText);
        HeadLineText[9] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION("Book Value"), StartText);
        HeadLineText[10] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION("Book Value"), EndText);
    end;

    local procedure MakeGroupHeadLine()
    begin
        FOR j := 1 TO NumberOfTypes DO BEGIN
            GroupStartAmounts[j] := 0;
            GroupNetChangeAmounts[j] := 0;
            GroupDisposalAmounts[j] := 0;

            //HEI.03>>
            GroupNetChangeAmountsReclas[j] := 0;
            GroupNetChangeAmountsNonReclas[j] := 0;
            //HEI.03<<
        END;
        CASE GroupTotals OF
            GroupTotals::"FA Class":
                GroupHeadLine := FORMAT("Fixed Asset"."FA Class Code");
            GroupTotals::"FA Subclass":
                GroupHeadLine := FORMAT("Fixed Asset"."FA Subclass Code");
            GroupTotals::"FA Location":
                GroupHeadLine := FORMAT("Fixed Asset"."FA Location Code");
            GroupTotals::"Main Asset":
                BEGIN
                    FA."Main Asset/Component" := FA."Main Asset/Component"::"Main Asset";
                    GroupHeadLine :=
                      FORMAT(STRSUBSTNO('%1 %2', FORMAT(FA."Main Asset/Component"), "Fixed Asset"."Component of Main Asset"));
                    IF "Fixed Asset"."Component of Main Asset" = '' THEN
                        GroupHeadLine := FORMAT(STRSUBSTNO('%1 %2', GroupHeadLine, '*****'));
                END;
            GroupTotals::"Global Dimension 1":
                GroupHeadLine := FORMAT("Fixed Asset"."Global Dimension 1 Code");
            GroupTotals::"Global Dimension 2":
                GroupHeadLine := FORMAT("Fixed Asset"."Global Dimension 2 Code");
            GroupTotals::"FA Posting Group":
                GroupHeadLine := FORMAT("Fixed Asset"."FA Posting Group");
        END;
        IF GroupHeadLine = '' THEN
            GroupHeadLine := FORMAT('*****');
    end;

    local procedure UpdateTotals()
    begin
        FOR j := 1 TO NumberOfTypes DO BEGIN
            GroupStartAmounts[j] := GroupStartAmounts[j] + StartAmounts[j];
            GroupNetChangeAmounts[j] := GroupNetChangeAmounts[j] + NetChangeAmounts[j];

            //HEI.03>>
            GroupNetChangeAmountsReclas[j] := GroupNetChangeAmountsReclas[j] + NetChangeAmountsReclas[j];
            GroupNetChangeAmountsNonReclas[j] := GroupNetChangeAmountsNonReclas[j] + NetChangeAmountsNonReclas[j];
            //HEI.03<<
            GroupDisposalAmounts[j] := GroupDisposalAmounts[j] + DisposalAmounts[j];
            TotalStartAmounts[j] := TotalStartAmounts[j] + StartAmounts[j];
            TotalNetChangeAmounts[j] := TotalNetChangeAmounts[j] + NetChangeAmounts[j];
            TotalDisposalAmounts[j] := TotalDisposalAmounts[j] + DisposalAmounts[j];
        END;
    end;

    local procedure CreateGroupTotals()
    begin
        FOR j := 1 TO NumberOfTypes DO
            TotalEndingAmounts[j] :=
              GroupStartAmounts[j] + GroupNetChangeAmounts[j] + GroupDisposalAmounts[j];
        BookValueAtEndingDate := 0;
        BookValueAtStartingDate := 0;
        FOR j := 1 TO NumberOfTypes DO BEGIN
            BookValueAtEndingDate := BookValueAtEndingDate + TotalEndingAmounts[j];
            BookValueAtStartingDate := BookValueAtStartingDate + GroupStartAmounts[j];
        END;
    end;

    local procedure CreateTotals()
    begin
        FOR j := 1 TO NumberOfTypes DO
            TotalEndingAmounts[j] :=
              TotalStartAmounts[j] + TotalNetChangeAmounts[j] + TotalDisposalAmounts[j];
        BookValueAtEndingDate := 0;
        BookValueAtStartingDate := 0;
        FOR j := 1 TO NumberOfTypes DO BEGIN
            BookValueAtEndingDate := BookValueAtEndingDate + TotalEndingAmounts[j];
            BookValueAtStartingDate := BookValueAtStartingDate + TotalStartAmounts[j];
        END;
    end;

    local procedure GetStartingDate(StartingDate: Date): Date
    begin
        IF StartingDate <= 00000101D THEN
            EXIT(0D);

        EXIT(StartingDate - 1);
    end;

    procedure SetMandatoryFields(DepreciationBookCodeFrom: Code[10]; StartingDateFrom: Date; EndingDateFrom: Date)
    begin
        DeprBookCode := DepreciationBookCodeFrom;
        StartingDate := StartingDateFrom;
        EndingDate := EndingDateFrom;
    end;

    procedure SetTotalFields(GroupTotalsFrom: Option; PrintDetailsFrom: Boolean; BudgetReportFrom: Boolean)
    begin
        GroupTotals := GroupTotalsFrom;
        PrintDetails := PrintDetailsFrom;
        BudgetReport := BudgetReportFrom;
    end;

    procedure GetDepreciationBookCode()
    begin
        IF DeprBookCode = '' THEN BEGIN
            FASetup.GET;
            DeprBookCode := FASetup."Default Depr. Book";
        END;
    end;

    procedure GetDeprBookInfo()
    begin
    end;

    procedure GetDerogDeprBookInfo()
    begin
    end;

    procedure CalcFAPostedAmountSplitAmount(FANo: Code[20]; PostingType: Integer; Period: Option "Before Starting Date","Net Change","at Ending Date"; StartingDate: Date; EndingDate: Date; DeprBookCode: Code[10]; BeforeAmount: Decimal; UntilAmount: Decimal; OnlyReclassified: Boolean; OnlyBookValue: Boolean; ReclasificationEntry: Boolean): Decimal
    var
        FALedgEntry: Record "FA Ledger Entry";
    begin
        //HEI.01>>
        // CLEARALL;
        Clear(FALedgEntry);
        IF PostingType = 0 THEN
            EXIT(0);
        IF EndingDate = 0D THEN
            EndingDate := 99991231D;
        CASE PostingType OF
            FADeprBook.FIELDNO("Book Value"):
                FALedgEntry.SETCURRENTKEY("FA No.", "Depreciation Book Code", "Part of Book Value");
            FADeprBook.FIELDNO("Depreciable Basis"):
                FALedgEntry.SETCURRENTKEY("FA No.", "Depreciation Book Code", "Part of Depreciable Basis");
            ELSE BEGIN
                FALedgEntry.SETCURRENTKEY(
                  "FA No.", "Depreciation Book Code",
                  "FA Posting Category", "FA Posting Type", "FA Posting Date");
                FALedgEntry.SETRANGE("FA Posting Category", FALedgEntry."FA Posting Category"::" ");
            END;
        END;
        FALedgEntry.SETRANGE("FA No.", FANo);
        FALedgEntry.SETRANGE("Depreciation Book Code", DeprBookCode);
        FALedgEntry.SETRANGE("Reclassification Entry", ReclasificationEntry);//FDD-100313
        IF OnlyReclassified THEN
            FALedgEntry.SETRANGE("Reclassification Entry", TRUE);
        IF OnlyBookValue THEN
            FALedgEntry.SETRANGE("Part of Book Value", TRUE);
        CASE PostingType OF
            FADeprBook.FIELDNO("Acquisition Cost"):
                FALedgEntry.SETRANGE("FA Posting Type", FALedgEntry."FA Posting Type"::"Acquisition Cost");
            FADeprBook.FIELDNO(Depreciation):
                FALedgEntry.SETRANGE("FA Posting Type", FALedgEntry."FA Posting Type"::Depreciation);
            FADeprBook.FIELDNO("Write-Down"):
                FALedgEntry.SETRANGE("FA Posting Type", FALedgEntry."FA Posting Type"::"Write-Down");
            FADeprBook.FIELDNO(Appreciation):
                FALedgEntry.SETRANGE("FA Posting Type", FALedgEntry."FA Posting Type"::Appreciation);
            FADeprBook.FIELDNO("Custom 1"):
                FALedgEntry.SETRANGE("FA Posting Type", FALedgEntry."FA Posting Type"::"Custom 1");
            FADeprBook.FIELDNO("Custom 2"):
                FALedgEntry.SETRANGE("FA Posting Type", FALedgEntry."FA Posting Type"::"Custom 2");
            FADeprBook.FIELDNO("Proceeds on Disposal"):
                FALedgEntry.SETRANGE("FA Posting Type", FALedgEntry."FA Posting Type"::"Proceeds on Disposal");
            FADeprBook.FIELDNO("Gain/Loss"):
                FALedgEntry.SETRANGE("FA Posting Type", FALedgEntry."FA Posting Type"::"Gain/Loss");
            FADeprBook.FIELDNO("Salvage Value"):
                FALedgEntry.SETRANGE("FA Posting Type", FALedgEntry."FA Posting Type"::"Salvage Value");
            FADeprBook.FIELDNO("Book Value"):
                FALedgEntry.SETRANGE("Part of Book Value", TRUE);
            FADeprBook.FIELDNO("Depreciable Basis"):
                FALedgEntry.SETRANGE("Part of Depreciable Basis", TRUE);
        END;
        CASE Period OF
            Period::"Before Starting Date":
                FALedgEntry.SETRANGE("FA Posting Date", 0D, StartingDate - 1);
            Period::"Net Change":
                FALedgEntry.SETRANGE("FA Posting Date", StartingDate, EndingDate);
            Period::"at Ending Date":
                FALedgEntry.SETRANGE("FA Posting Date", 0D, EndingDate);
        END;
        FALedgEntry.CALCSUMS(Amount);

        IF (PostingType = FADeprBook.FIELDNO("Book Value")) OR
           (PostingType = FADeprBook.FIELDNO(Depreciation))
        THEN
            CASE Period OF
                Period::"Before Starting Date":
                    FALedgEntry.Amount := FALedgEntry.Amount + BeforeAmount;
                Period::"Net Change":
                    FALedgEntry.Amount := FALedgEntry.Amount - BeforeAmount + UntilAmount;
                Period::"at Ending Date":
                    FALedgEntry.Amount := FALedgEntry.Amount + UntilAmount;
            END;
        EXIT(FALedgEntry.Amount);
        //HEI.01<<
    end;
}

