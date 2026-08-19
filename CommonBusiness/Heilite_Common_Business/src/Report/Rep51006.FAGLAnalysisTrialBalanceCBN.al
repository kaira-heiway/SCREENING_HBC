report 51006 "FA -G/L Analysis Trial Bal CBN"
{
    // version HEI.01

    // HEI.01 FDD RTRGAP014 IBM COSTES02 28.07.2017
    //   # new report
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\FA -GL Analysis Trial Balance.rdl';

    Caption = 'FA - G/L Analysis Trial Balance';
    ApplicationArea = All;

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            RequestFilterFields = "No.", "FA Class Code", "FA Subclass Code", "Budgeted Asset";
            column(CompanyName; COMPANYNAME)
            {
            }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(DeprBookText; DeprBookText)
            {
            }
            column(FixedAssetCaption; TABLECAPTION + ': ' + FAFilter)
            {
            }
            column(FAFilter; FAFilter)
            {
            }
            column(HeadLineText1; HeadLineText[1])
            {
            }
            column(GroupCodeName; GroupCodeName)
            {
            }
            column(FANo; FANo)
            {
            }
            column(FADescription; FADescription)
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
            column(GroupTotalsPrintDetails; (GroupTotals = 0) or not PrintDetails)
            {
            }
            column(PrintDetailsGroupTotals; PrintDetails and (GroupTotals <> 0))
            {
            }
            column(GroupHeadLine; GroupHeadLine)
            {
            }
            column(No_FixedAsset; "No.")
            {
            }
            column(Description_FixedAsset; Description)
            {
            }
            column(Amounts1; Amounts[1])
            {
                AutoFormatType = 1;
            }
            column(Amounts2; Amounts[2])
            {
                AutoFormatType = 1;
            }
            column(Amounts3; Amounts[3])
            {
                AutoFormatType = 1;
            }
            column(Date1; FORMAT(Date[1]))
            {
            }
            column(Date2; FORMAT(Date[2]))
            {
            }
            column(PrintDetails; PrintDetails)
            {
            }
            column(GroupAmounts1; GroupAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(GroupAmounts2; GroupAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(GroupAmounts3; GroupAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(GroupTotalGroupHeadLine; Text000 + ': ' + GroupHeadLine)
            {
            }
            column(GroupTotalsNotEqualZero; GroupTotals <> 0)
            {
            }
            column(TotalAmounts1; TotalAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(TotalAmounts2; TotalAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(TotalAmounts3; TotalAmounts[3])
            {
                AutoFormatType = 1;
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(FixedAssetGLAnalysisCptn; FixedAssetGLAnalysisCptnLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                if not FADeprBook.GET("No.", DeprBookCode) then
                    CurrReport.SKIP();
                if SkipRecord() then
                    CurrReport.SKIP();

                if GroupTotals = GroupTotals::"FA Posting Group" then
                    if "FA Posting Group" <> FADeprBook."FA Posting Group" then
                        ERROR(Text005, FIELDCAPTION("FA Posting Group"), "No.");

                Date[1] :=
                  FAGenReport.GetLastDate(
                    "No.", DateTypeNo1, EndingDate, DeprBookCode, true);
                Date[2] :=
                  FAGenReport.GetLastDate(
                    "No.", DateTypeNo2, EndingDate, DeprBookCode, true);
                Amounts[1] :=
                  FAGenReport.CalcGLPostedAmount(
                    "No.", PostingTypeNo1, Period1, StartingDate, EndingDate, DeprBookCode);

                Amounts[2] :=
                  FAGenReport.CalcGLPostedAmount(
                    "No.", PostingTypeNo2, Period2, StartingDate, EndingDate, DeprBookCode);

                Amounts[3] :=
                  FAGenReport.CalcGLPostedAmount(
                    "No.", PostingTypeNo3, Period3, StartingDate, EndingDate, DeprBookCode);

                if (Amounts[1] = 0) and (Amounts[2] = 0) and (Amounts[3] = 0) then
                    CurrReport.SKIP();
                for i := 1 to 3 do
                    GroupAmounts[i] := 0;
                MakeGroupHeadLine();
                if LastFAPostingGroup <> "FA Posting Group" then begin
                    ManageFAPostingGroupAccounts("FA Posting Group");
                    LastFAPostingGroup := "FA Posting Group";
                end;
            end;

            trigger OnPreDataItem();
            begin
                case GroupTotals of
                    GroupTotals::"FA Class":
                        SETCURRENTKEY("FA Class Code");
                    GroupTotals::"FA Subclass":
                        SETCURRENTKEY("FA Subclass Code");
                    GroupTotals::"Main Asset":
                        SETCURRENTKEY("Component of Main Asset");
                    GroupTotals::"Global Dimension 1":
                        SETCURRENTKEY("Global Dimension 1 Code");
                    GroupTotals::"FA Location":
                        SETCURRENTKEY("FA Location Code");
                    GroupTotals::"Global Dimension 2":
                        SETCURRENTKEY("Global Dimension 2 Code");
                    GroupTotals::"FA Posting Group":
                        SETCURRENTKEY("FA Posting Group");
                end;

                FAPostingType.CreateTypes();
                FADateType.CreateTypes();
                CheckDateType(DateType1, DateTypeNo1);
                CheckDateType(DateType2, DateTypeNo2);
                CheckPostingType(PostingType1, PostingTypeNo1);
                CheckPostingType(PostingType2, PostingTypeNo2);
                CheckPostingType(PostingType3, PostingTypeNo3);
                MakeGroupTotalText();
                FAGenReport.ValidateDates(StartingDate, EndingDate);
                MakeDateHeadLine();
                MakeAmountHeadLine(3, PostingType1, PostingTypeNo1, Period1);
                MakeAmountHeadLine(4, PostingType2, PostingTypeNo2, Period2);
                MakeAmountHeadLine(5, PostingType3, PostingTypeNo3, Period3);
            end;
        }
        dataitem("Integer"; "Integer")
        {
            column(GLAccountLbl; GLAccountLbl)
            {
            }
            column(GlAccountNameLbl; GlAccountNameLbl)
            {
            }
            column(GlAccountNetChange; GlAccountNetChange)
            {
            }
            column(GLAccountBalanceLbl; GLAccountBalanceLbl)
            {
            }
            column(DebitLbl; DebitLbl)
            {
            }
            column(CreditLbl; CreditLbl)
            {
            }
            column(FAPostingSetupLbl; FAPostingSetupLbl)
            {
            }
            column(Number; Number)
            {
            }
            column(GLAccountNo; TempGLAccount."No.")
            {
            }
            column(GLAccountName; TempGLAccount.Name)
            {
            }
            column(NetChange; TempGLAccount."Net Change")
            {
            }
            column(NetChangeNegative; -TempGLAccount."Net Change")
            {
                AutoFormatType = 1;
            }
            column(BalanceAtDate; TempGLAccount."Balance at Date")
            {
            }
            column(BalanceAtDateNegative; -TempGLAccount."Balance at Date")
            {
                AutoFormatType = 1;
            }
            column(GLAccountType; FORMAT(TempGLAccount."Account Type", 0, 2))
            {
            }
            column(GLAccountFieldCaption; GLAccountFieldCaption)
            {
            }

            trigger OnAfterGetRecord();
            begin
                if Number = 1 then
                    TempGLAccount.FINDFIRST()
                else
                    TempGLAccount.NEXT();
                GLAccountFieldCaption := TempGLAccount.Totaling;
                CLEAR(TempGLAccount.Totaling);
                TempGLAccount.CALCFIELDS("Net Change", TempGLAccount."Balance at Date");
            end;

            trigger OnPreDataItem();
            begin
                TempGLAccount.RESET();
                SETRANGE(Number, 1, TempGLAccount.COUNT);
                TempGLAccount.SETFILTER("Date Filter", '%1..%2', StartingDate, EndingDate);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DepreciationBook; DeprBookCode)
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
                    field(DateField1; DateType1)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Date Field 1';
                        TableRelation = "FA Date Type"."FA Date Type Name" where("G/L Entry" = CONST(true));
                        ToolTip = 'Specifies the first type of date that the report must show. The report has two columns in which two types of dates can be displayed. In each of the fields, select one of the available date types.';
                    }
                    field(DateField2; DateType2)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Date Field 2';
                        TableRelation = "FA Date Type"."FA Date Type Name" where("G/L Entry" = CONST(true));
                        ToolTip = 'Specifies the second type of date that the report must show.';
                    }
                    field(AmountField1; PostingType1)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Amount Field 1';
                        TableRelation = "FA Posting Type"."FA Posting Type Name" where("G/L Entry" = CONST(true));
                        ToolTip = 'Specifies an Amount field that you use to create your own analysis. The report has three columns in which three types of amounts can be displayed. Choose the relevant FA posting type for each column.';
                    }
                    field(Period1; Period1)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Period 1';
                        OptionCaption = '" ,Disposal,Bal. Disposal"';
                        ToolTip = 'Specifies how the report determines the nature of the amounts in the first amount field. (Blank): The amounts consist of fixed asset ledger entries with the posting type that corresponds to the option in the amount field. Disposal: The amounts consists of fixed asset ledger entries with the posting type that corresponds to the option in the amount field if these entries have been posted to disposal accounts. Bal. Disposal: The amounts consist of fixed asset ledger entries with the posting type that corresponds to the option in the amount field if these entries have been posted to balancing disposal accounts.';
                    }
                    field(AmountField2; PostingType2)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Amount Field 2';
                        TableRelation = "FA Posting Type"."FA Posting Type Name" where("G/L Entry" = CONST(true));
                        ToolTip = 'Specifies an Amount field that you use to create your own analysis.';
                    }
                    field(Period2; Period2)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Period 2';
                        OptionCaption = '" ,Disposal,Bal. Disposal"';
                        ToolTip = 'Specifies how the report determines the nature of the amounts in the second amount field. (Blank): The amounts consist of fixed asset ledger entries with the posting type that corresponds to the option in the amount field. Disposal: The amounts consists of fixed asset ledger entries with the posting type that corresponds to the option in the amount field if these entries have been posted to disposal accounts. Bal. Disposal: The amounts consist of fixed asset ledger entries with the posting type that corresponds to the option in the amount field if these entries have been posted to balancing disposal accounts.';
                    }
                    field(AmountField3; PostingType3)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Amount Field 3';
                        TableRelation = "FA Posting Type"."FA Posting Type Name" where("G/L Entry" = CONST(true));
                        ToolTip = 'Specifies an Amount field that you use to create your own analysis.';
                    }
                    field(Period3; Period3)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Period 3';
                        OptionCaption = '" ,Disposal,Bal. Disposal"';
                        ToolTip = 'Specifies how the report determines the nature of the amounts in the third amount field. (Blank): The amounts consist of fixed asset ledger entries with the posting type that corresponds to the option in the amount field. Disposal: The amounts consists of fixed asset ledger entries with the posting type that corresponds to the option in the amount field if these entries have been posted to disposal accounts. Bal. Disposal: The amounts consist of fixed asset ledger entries with the posting type that corresponds to the option in the amount field if these entries have been posted to balancing disposal accounts.';
                    }
                    field(GroupTotals; GroupTotals)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Group Totals';
                        OptionCaption = '" ,FA Class,FA Subclass,FA Location,Main Asset,Global Dimension 1,Global Dimension 2,FA Posting Group"';
                        ToolTip = 'Specifies a group type if you want the report to group the fixed assets and print group totals. For example, if you have set up six FA classes, then select the FA Class option to have group totals printed for each of the six class codes. Select to see the available options. If you do not want group totals to be printed, select the blank option.';
                    }
                    field(PrintperFixedAsset; PrintDetails)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Print per Fixed Asset';
                        ToolTip = 'Specifies if you want the report to print information separately for each fixed asset.';
                    }
                    field(OnlySoldAssets; SalesReport)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Only Sold Assets';
                        ToolTip = 'Specifies if you want the report to show information only for sold fixed assets.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            GetFASetup();
        end;
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        DeprBook.GET(DeprBookCode);
        FAFilter := "Fixed Asset".GETFILTERS;

        if GroupTotals = GroupTotals::"FA Posting Group" then
            FAGenReport.SetFAPostingGroup("Fixed Asset", DeprBook.Code);

        FAGenReport.AppendPostingDateFilter(FAFilter, StartingDate, EndingDate);
        DeprBookText := STRSUBSTNO('%1%2 %3', DeprBook.TABLECAPTION, ':', DeprBookCode);
        if PrintDetails then begin
            FANo := "Fixed Asset".FIELDCAPTION("No.");
            FADescription := "Fixed Asset".FIELDCAPTION(Description);
        end;
    end;

    var
        DeprBook: Record "Depreciation Book";
        FADateType: Record "FA Date Type";
        FADeprBook: Record "FA Depreciation Book";
        FAPostingType: Record "FA Posting Type";
        FASetup: Record "FA Setup";
        TempGLAccount: Record "G/L Account" temporary;
        FAGenReport: Codeunit "FA General Report";
        PrintDetails: Boolean;
        SalesReport: Boolean;
        TypeExist: Boolean;
        DeprBookCode: Code[10];
        LastFAPostingGroup: Code[10];
        Date: array[2] of Date;
        EndingDate: Date;
        StartingDate: Date;
        Amounts: array[3] of Decimal;
        GroupAmounts: array[3] of Decimal;
        TotalAmounts: array[3] of Decimal;
        DateTypeNo1: Integer;
        DateTypeNo2: Integer;
        i: Integer;
        PostingTypeNo1: Integer;
        PostingTypeNo2: Integer;
        PostingTypeNo3: Integer;
        CreditLbl: Label 'Credit';
        CurrReportPageNoCaptionLbl: Label 'Page';
        DebitLbl: Label 'Debit';
        FAPostingSetupLbl: Label 'FA Posting Setup Account Name';
        FixedAssetGLAnalysisCptnLbl: Label 'Fixed Asset - G/L Analysis';
        GLAccountBalanceLbl: Label 'Balance';
        GLAccountLbl: Label 'G/L Account No.';
        GlAccountNameLbl: Label 'G/L Account Name';
        GlAccountNetChange: Label 'Net Change';
        Text000: Label 'Group Total';
        Text001: Label 'Group Totals';
        Text002: Label '%1 must be specified only together with the types %2, %3, %4 or %5.';
        Text003: Label 'The date type %1 is not a valid option.';
        Text004: Label 'The posting type %1 is not a valid option.';
        Text005: Label '%1 has been modified in fixed asset %2.';
        Text006: Label '" ,FA Class,FA Subclass,FA Location,Main Asset,Global Dimension 1,Global Dimension 2,FA Posting Group"';
        TotalCaptionLbl: Label 'Total';
        Period1: Option " ",Disposal,"Bal. Disposal";
        Period2: Option " ",Disposal,"Bal. Disposal";
        Period3: Option " ",Disposal,"Bal. Disposal";
        GroupTotals: Option " ","FA Class","FA Subclass","FA Location","Main Asset","Global Dimension 1","Global Dimension 2","FA Posting Group";
        FAFilter: Text;
        DateType1: Text[30];
        DateType2: Text[30];
        PostingType1: Text[30];
        PostingType2: Text[30];
        PostingType3: Text[30];
        DeprBookText: Text[50];
        FADescription: Text[50];
        FANo: Text[50];
        GroupHeadLine: Text[50];
        HeadLineText: array[5] of Text[50];
        GroupCodeName: Text[80];
        GLAccountFieldCaption: Text[250];

    local procedure SkipRecord(): Boolean;
    begin
        exit(
          "Fixed Asset".Inactive or
          (FADeprBook."Acquisition Date" = 0D) or
          SalesReport and (FADeprBook."Disposal Date" = 0D));
    end;

    local procedure MakeGroupTotalText();
    begin
        case GroupTotals of
            GroupTotals::"FA Class":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("FA Class Code");
            GroupTotals::"FA Subclass":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("FA Subclass Code");
            GroupTotals::"Main Asset":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("Main Asset/Component");
            GroupTotals::"Global Dimension 1":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("Global Dimension 1 Code");
            GroupTotals::"FA Location":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("FA Location Code");
            GroupTotals::"Global Dimension 2":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("Global Dimension 2 Code");
            GroupTotals::"FA Posting Group":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("FA Posting Group");
        end;
        if GroupCodeName <> '' then
            GroupCodeName := STRSUBSTNO('%1%2 %3', Text001, ': ', GroupCodeName);
    end;

    local procedure MakeDateHeadLine();
    begin
        if not PrintDetails then
            exit;
        HeadLineText[1] := DateType1;
        HeadLineText[2] := DateType2;
    end;

    local procedure MakeAmountHeadLine(i: Integer; PostingType: Text[50]; PostingTypeNo: Integer; var Period: Option " ",Disposal,"Bal. Disposal");
    var
        LocalText000: Label '" ,Disposal,Bal. Disposal"';
    begin
        if PostingTypeNo = 0 then
            exit;
        if Period = Period::"Bal. Disposal" then
            if (PostingTypeNo <> FADeprBook.FIELDNO("Write-Down")) and
               (PostingTypeNo <> FADeprBook.FIELDNO(Appreciation)) and
               (PostingTypeNo <> FADeprBook.FIELDNO("Custom 1")) and
               (PostingTypeNo <> FADeprBook.FIELDNO("Custom 2"))
            then
                ERROR(
                  Text002,
                  SELECTSTR(Period + 1, LocalText000),
                  FADeprBook.FIELDCAPTION("Write-Down"),
                  FADeprBook.FIELDCAPTION(Appreciation),
                  FADeprBook.FIELDCAPTION("Custom 1"),
                  FADeprBook.FIELDCAPTION("Custom 2"));

        case PostingTypeNo of
            FADeprBook.FIELDNO("Proceeds on Disposal"),
          FADeprBook.FIELDNO("Gain/Loss"):
                Period := Period::" ";
            FADeprBook.FIELDNO("Book Value on Disposal"):
                Period := Period::Disposal;
        end;
        HeadLineText[i] := STRSUBSTNO('%1 %2', PostingType, SELECTSTR(Period + 1, LocalText000));
    end;

    local procedure MakeGroupHeadLine();
    begin
        case GroupTotals of
            GroupTotals::"FA Class":
                GroupHeadLine := "Fixed Asset"."FA Class Code";
            GroupTotals::"FA Subclass":
                GroupHeadLine := "Fixed Asset"."FA Subclass Code";
            GroupTotals::"Main Asset":
                begin
                    GroupHeadLine := STRSUBSTNO('%1 %2', SELECTSTR(GroupTotals + 1, Text006), "Fixed Asset"."Component of Main Asset");
                    if "Fixed Asset"."Component of Main Asset" = '' then
                        GroupHeadLine := GroupHeadLine + '*****';
                end;
            GroupTotals::"Global Dimension 1":
                GroupHeadLine := "Fixed Asset"."Global Dimension 1 Code";
            GroupTotals::"FA Location":
                GroupHeadLine := "Fixed Asset"."FA Location Code";
            GroupTotals::"Global Dimension 2":
                GroupHeadLine := "Fixed Asset"."Global Dimension 2 Code";
            GroupTotals::"FA Posting Group":
                GroupHeadLine := "Fixed Asset"."FA Posting Group";
        end;
        if GroupHeadLine = '' then
            GroupHeadLine := '*****';
    end;

    local procedure CheckDateType(DateType: Text[30]; var DateTypeNo: Integer);
    begin
        if DateType = '' then
            exit;
        FADateType.SETRANGE("G/L Entry", true);
        if FADateType.FIND('-') then
            repeat
                TypeExist := DateType = FADateType."FA Date Type Name";
                if TypeExist then
                    DateTypeNo := FADateType."FA Date Type No.";
            until (FADateType.NEXT() = 0) or TypeExist;
        if FADateType.FIND('-') then;

        if not TypeExist then
            ERROR(Text003, DateType);
    end;

    local procedure CheckPostingType(PostingType: Text[30]; var PostingTypeNo: Integer);
    begin
        if PostingType = '' then
            exit;
        FAPostingType.SETRANGE("G/L Entry", true);
        if FAPostingType.FIND('-') then
            repeat
                TypeExist := PostingType = FAPostingType."FA Posting Type Name";
                if TypeExist then
                    PostingTypeNo := FAPostingType."FA Posting Type No.";
            until (FAPostingType.NEXT() = 0) or TypeExist;
        if FAPostingType.FIND('-') then;
        if not TypeExist then
            ERROR(Text004, PostingType);
    end;

    procedure SetMandatoryFields(DepreciationBookCodeFrom: Code[10]; StartingDateFrom: Date; EndingDateFrom: Date);
    begin
        DeprBookCode := DepreciationBookCodeFrom;
        StartingDate := StartingDateFrom;
        EndingDate := EndingDateFrom;
    end;

    procedure SetDateType(DateType1From: Text[30]; DateType2From: Text[30]);
    begin
        DateType1 := DateType1From;
        DateType2 := DateType2From;
    end;

    procedure SetPostingType(PostingType1From: Text[30]; PostingType2From: Text[30]; PostingType3From: Text[30]);
    begin
        PostingType1 := PostingType1From;
        PostingType2 := PostingType2From;
        PostingType3 := PostingType3From;
    end;

    procedure SetPeriod(Period1From: Option; Period2From: Option; Period3From: Option);
    begin
        Period1 := Period1From;
        Period2 := Period2From;
        Period3 := Period3From;
    end;

    procedure SetTotalFields(GroupTotalsFrom: Option; PrintDetailsFrom: Boolean; SalesReportFrom: Boolean);
    begin
        GroupTotals := GroupTotalsFrom;
        PrintDetails := PrintDetailsFrom;
        SalesReport := SalesReportFrom;
    end;

    procedure GetFASetup();
    begin
        if DeprBookCode = '' then begin
            FASetup.GET();
            DeprBookCode := FASetup."Default Depr. Book";
        end;
        FAPostingType.CreateTypes();
        FADateType.CreateTypes();
    end;

    local procedure ManageFAPostingGroupAccounts(PostingGroup: Code[10]);
    var
        lFAPostingGroup: Record "FA Posting Group";
    begin
        if not lFAPostingGroup.GET(PostingGroup) then
            exit;

        FillTempGLAccount(lFAPostingGroup."Acquisition Cost Account", lFAPostingGroup.FIELDCAPTION("Acquisition Cost Account"));
        FillTempGLAccount(lFAPostingGroup."Accum. Depreciation Account", lFAPostingGroup.FIELDCAPTION("Accum. Depreciation Account"));
        FillTempGLAccount(lFAPostingGroup."Gains Acc. on Disposal", lFAPostingGroup.FIELDCAPTION("Gains Acc. on Disposal"));
        FillTempGLAccount(lFAPostingGroup."Losses Acc. on Disposal", lFAPostingGroup.FIELDCAPTION("Losses Acc. on Disposal"));
        FillTempGLAccount(lFAPostingGroup."Maintenance Expense Account", lFAPostingGroup.FIELDCAPTION("Maintenance Expense Account"));
        FillTempGLAccount(lFAPostingGroup."Write-Down Account", lFAPostingGroup.FIELDCAPTION("Write-Down Account"));
        FillTempGLAccount(lFAPostingGroup."Appreciation Account", lFAPostingGroup.FIELDCAPTION("Appreciation Account"));
        FillTempGLAccount(lFAPostingGroup."Custom 1 Account", lFAPostingGroup.FIELDCAPTION("Custom 1 Account"));
        FillTempGLAccount(lFAPostingGroup."Custom 2 Account", lFAPostingGroup.FIELDCAPTION("Custom 2 Account"));
        FillTempGLAccount(lFAPostingGroup."Sales Acc. on Disp. (Gain)", lFAPostingGroup.FIELDCAPTION("Sales Acc. on Disp. (Gain)"));
        FillTempGLAccount(lFAPostingGroup."Sales Acc. on Disp. (Loss)", lFAPostingGroup.FIELDCAPTION("Sales Acc. on Disp. (Loss)"));
    end;

    local procedure FillTempGLAccount(GLAccountNo: Code[10]; GLAccountName: Text[50]);
    var
        lGLAccount: Record "G/L Account";
        lChar10: Char;
        lChar13: Char;
        Filtertxt: Text[30];
    begin
        if GLAccountNo = '' then
            exit;

        if not lGLAccount.GET(GLAccountNo) then
            exit;
        lChar13 := 13;
        lChar10 := 10;
        Filtertxt := '*' + GLAccountName + '*';
        TempGLAccount.RESET();
        TempGLAccount.SETRANGE("No.", GLAccountNo);
        if TempGLAccount.FINDFIRST() then begin
            TempGLAccount.RESET();
            TempGLAccount.SETRANGE("No.", GLAccountNo);
            TempGLAccount.SETFILTER(Totaling, '%1', Filtertxt);
            if not TempGLAccount.FINDFIRST() then begin
                if STRLEN(TempGLAccount.Totaling) + STRLEN(GLAccountName) < MAXSTRLEN(TempGLAccount.Totaling) then begin
                    TempGLAccount.Totaling := TempGLAccount.Totaling + FORMAT(lChar13) + FORMAT(lChar10) + GLAccountName;
                    TempGLAccount.MODIFY();
                end;
            end;
        end else begin
            TempGLAccount := lGLAccount;
            TempGLAccount.Totaling := GLAccountName;
            if TempGLAccount.INSERT() then;
        end;
    end;
}

