report 51064 "G/L DetailTrialBalanceDRCCBN"
{
    // version NAVFR7.10,DITW17.00.01,IBM 1001,HEI.01

    // HEI.01 FDD-HT1146 IBM SURYAS01 20/04/2020
    // # Created New Report -"G/L DetailTrialBalanceDRCCBN"

    // BC Upgrade SHUKLP03 << DataItemLink of dataitem("G/L Entry"; "G/L Entry") blocked because dependency on DrinkIT "DIT Sub-Contract Type".

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\GL Detail Trial Balance - DRC.rdl';

    CaptionML = ENU = 'G/L Detail Trial Balance - DRC',
                FRA = 'Grand livre comptes généraux DRC';
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Date Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(STRSUBSTNO_Text003_USERID_; STRSUBSTNO(Text003, USERID))
            {
            }
            column(STRSUBSTNO_Text004_PreviousStartDate_; STRSUBSTNO(Text004, PreviousStartDate))
            {
            }
            column(STRSUBSTNO_Text005_CurrReport_PAGENO_; STRSUBSTNO(Text005, CurrReport.PAGENO()))
            {
            }
            column(PageCaption; STRSUBSTNO(Text005, ' '))
            {
            }
            column(UserCaption; STRSUBSTNO(Text003, ''))
            {
            }
            column(G_L_Account__TABLECAPTION__________Filter; "G/L Account".TABLECAPTION + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(GLAccountTypeFilter; GLAccountTypeFilter)
            {
            }
            column(G_L_Account__No__; "No.")
            {
            }
            column(G_L_Account_Name; Name)
            {
            }
            column(G_L_Account__No2; "G/L Account"."No. 2")
            {
            }
            column(G_L_Account__LocalName; "G/L Account"."Local Name FND")
            {
            }
            column(GLEntryCurrencyCode; "G/L Entry"."Currency Code FND")
            {
            }
            column(GLEntryGlobalDim1; "G/L Entry"."Global Dimension 1 Code")
            {
            }
            column(GLEntryGlobalDim2; "G/L Entry"."Global Dimension 2 Code")
            {
            }
            column(G_L_Account__G_L_Account___Debit_Amount_; "G/L Account"."Debit Amount")
            {
            }
            column(G_L_Account__G_L_Account___Credit_Amount_; "G/L Account"."Credit Amount")
            {
            }
            column(G_L_Account___Debit_Amount_____G_L_Account___Credit_Amount_; "G/L Account"."Debit Amount" - "G/L Account"."Credit Amount")
            {
            }
            column(STRSUBSTNO_Text006_PreviousEndDate_; STRSUBSTNO(Text006, PreviousEndDate))
            {
            }
            column(GLAccount2__Debit_Amount_; GLAccount2."Debit Amount")
            {
            }
            column(GLAccount2__Credit_Amount_; GLAccount2."Credit Amount")
            {
            }
            column(GLAccount2__Debit_Amount____GLAccount2__Credit_Amount_; GLAccount2."Debit Amount" - GLAccount2."Credit Amount")
            {
            }
            column(STRSUBSTNO_Text006_EndDate_; STRSUBSTNO(Text006, EndDate))
            {
            }
            column(G_L_Account__G_L_Account___Debit_Amount__Control1120054; "G/L Account"."Debit Amount")
            {
            }
            column(G_L_Account__G_L_Account___Credit_Amount__Control1120056; "G/L Account"."Credit Amount")
            {
            }
            column(G_L_Account___Debit_Amount_____G_L_Account___Credit_Amount__Control1120058; "G/L Account"."Debit Amount" - "G/L Account"."Credit Amount")
            {
            }
            column(ShowBodyGLAccount; ShowBodyGLAccount)
            {
            }
            column(G_L_Account__G_L_Account___Debit_Amount__Control1120062; "G/L Account"."Debit Amount")
            {
            }
            column(G_L_Account__G_L_Account___Credit_Amount__Control1120064; "G/L Account"."Credit Amount")
            {
            }
            column(G_L_Account___Debit_Amount_____G_L_Account___Credit_Amount__Control1120066; "G/L Account"."Debit Amount" - "G/L Account"."Credit Amount")
            {
            }
            column(G_L_Entry___Debit_Amount__Control1120070; "G/L Entry"."Debit Amount")
            {
            }
            column(G_L_Entry___Credit_Amount__Control1120072; "G/L Entry"."Credit Amount")
            {
            }
            column(G_L_Account___Debit_Amount_____G_L_Account___Credit_Amount____GLAccount2__Debit_Amount____GLAccount2__Credit_Amount_; "G/L Account"."Debit Amount" - "G/L Account"."Credit Amount" + GLAccount2."Debit Amount" - GLAccount2."Credit Amount")
            {
            }
            column(G_L_Account_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(G_L_Account_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(G_L_Detail_Trial_BalanceCaption; G_L_Detail_Trial_BalanceCaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Source_CodeCaption; Source_CodeCaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(External_Document_No_Caption; External_Document_No_CaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(LocalNoCaption; LocalAccNoCaptionLbl)
            {
            }
            column(LocalAccNameCaption; LocalAccNameCaptionLbl)
            {
            }
            column(SourceCurrencyCaption; SourceCurrencyCaptionLbl)
            {
            }
            column(GlobalDim1Caption; GlobalDim1CaptionLbl)
            {
            }
            column(GlobalDim2Caption; GlobalDim2CaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(ContinuedCaption; ContinuedCaptionLbl)
            {
            }
            column(To_be_continuedCaption; To_be_continuedCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(IncludeSourceCurr; IncludeSourceCurr)
            {
            }
            column(IncludeGlobDim1; IncludeGlobDim1)
            {
            }
            column(IncludeGlobDim2; IncludeGlobDim2)
            {
            }
            dataitem(Date; Date)
            {
                DataItemTableView = sorting("Period Type");
                PrintOnlyIfDetail = true;
                column(STRSUBSTNO_Text007_EndDate_; STRSUBSTNO(Text007, EndDate))
                {
                }
                column(G_L_Entry___Debit_Amount__Control1120080; "G/L Entry"."Debit Amount")
                {
                }
                column(G_L_Entry___Debit_Amount____GLAccount2__Debit_Amount_; "G/L Entry"."Debit Amount" + GLAccount2."Debit Amount")
                {
                }
                column(G_L_Entry___Credit_Amount__Control1120084; "G/L Entry"."Credit Amount")
                {
                }
                column(G_L_Entry___Credit_Amount____GLAccount2__Credit_Amount_; "G/L Entry"."Credit Amount" + GLAccount2."Credit Amount")
                {
                }
                column(G_L_Entry___Debit_Amount_____G_L_Entry___Credit_Amount__Control1120088; "G/L Entry"."Debit Amount" - "G/L Entry"."Credit Amount")
                {
                }
                column(G_L_Entry___Debit_Amount____GLAccount2__Debit_Amount_______G_L_Entry___Credit_Amount____GLAccount2__Credit_Amount__; ("G/L Entry"."Debit Amount" + GLAccount2."Debit Amount") - ("G/L Entry"."Credit Amount" + GLAccount2."Credit Amount"))
                {
                }
                column(Date__Period_Name_; Date."Period Name")
                {
                }
                column(Date__Period_No__; Date."Period No.")
                {
                }
                column(Year; DATE2DMY("G/L Entry"."Posting Date", 3))
                {
                }
                column(Date_Period_Type; "Period Type")
                {
                }
                column(Date_Period_Start; "Period Start")
                {
                }
                column(Total_Date_RangeCaption; Total_Date_RangeCaptionLbl)
                {
                }
                dataitem("G/L Entry"; "G/L Entry")
                {
                    //DataItemLink = "G/L Account No."=FIELD("No."),"Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),"Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),"Business Unit Code"=FIELD("Business Unit Filter"),"DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type Filter"),"Service Contract No."=FIELD("Service Contract No. Filter");  // BC Upgrade SHUKLP03 << Code blocked because dependency on DrinkIT "DIT Sub-Contract Type".
                    DataItemLinkReference = "G/L Account";
                    DataItemTableView = sorting("G/L Account No.") where("Open FND" = CONST(true));
                    column(G_L_Entry__Debit_Amount_; "Debit Amount")
                    {
                    }
                    column(G_L_Entry__Credit_Amount_; "Credit Amount")
                    {
                    }
                    column(Debit_Amount_____Credit_Amount_; "Debit Amount" - "Credit Amount")
                    {
                    }
                    column(G_L_Entry__Posting_Date_; FORMAT("Posting Date"))
                    {
                    }
                    column(G_L_Entry__Source_Code_; "Source Code")
                    {
                    }
                    column(G_L_Entry__Document_No__; "Document No.")
                    {
                    }
                    column(G_L_Entry__External_Document_No__; "External Document No.")
                    {
                    }
                    column(G_L_Entry_Description; Description)
                    {
                    }
                    column(G_L_Entry__Debit_Amount__Control1120116; "Debit Amount")
                    {
                    }
                    column(G_L_Entry__Credit_Amount__Control1120119; "Credit Amount")
                    {
                    }
                    column(Solde; Solde)
                    {
                    }
                    column(G_L_Entry___Entry_No__; "G/L Entry"."Entry No.")
                    {
                    }
                    column(G_L_Entry__Debit_Amount__Control1120126; "Debit Amount")
                    {
                    }
                    column(G_L_Entry__Credit_Amount__Control1120128; "Credit Amount")
                    {
                    }
                    column(Debit_Amount_____Credit_Amount__Control1120130; "Debit Amount" - "Credit Amount")
                    {
                    }
                    column(Text008_________FORMAT_Date__Period_Type___________Date__Period_Name_; Text008 + ' ' + FORMAT(Date."Period Type") + ' ' + Date."Period Name")
                    {
                    }
                    column(G_L_Entry__Debit_Amount__Control1120136; "Debit Amount")
                    {
                    }
                    column(G_L_Entry__Credit_Amount__Control1120139; "Credit Amount")
                    {
                    }
                    column(Solde_Control1120142; Solde)
                    {
                    }
                    column(TotalByInt; TotalByInt)
                    {
                    }
                    column(G_L_Entry_G_L_Account_No_; "G/L Account No.")
                    {
                    }
                    column(G_L_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                    {
                    }
                    column(G_L_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                    {
                    }
                    column(Previous_pageCaption; Previous_pageCaptionLbl)
                    {
                    }
                    column(Current_pageCaption; Current_pageCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        if ("Debit Amount" = 0) and
                           ("Credit Amount" = 0)
                        then
                            CurrReport.SKIP();
                        Solde := Solde + "Debit Amount" - "Credit Amount";
                    end;

                    trigger OnPreDataItem();
                    begin
                        if DocNumSort then
                            SETCURRENTKEY("G/L Account No.", "Document No.", "Posting Date");
                        SETRANGE("Posting Date", Date."Period Start", Date."Period End");
                    end;
                }

                trigger OnPreDataItem();
                begin
                    SETRANGE("Period Type", TotalBy);
                    SETRANGE("Period Start", StartDate, CLOSINGDATE(EndDate));
                    //   CurrReport.CREATETOTALS("G/L Entry"."Debit Amount", "G/L Entry"."Credit Amount"); BCUPG CREATETOTALSDEPRECATED
                end;
            }

            trigger OnAfterGetRecord();
            begin
                GLAccount2.COPY("G/L Account");
                if GLAccount2."Income/Balance".AsInteger() = 0 then
                    GLAccount2.SETRANGE("Date Filter", PreviousStartDate, PreviousEndDate)
                else
                    GLAccount2.SETRANGE("Date Filter", 0D, PreviousEndDate);
                GLAccount2.CALCFIELDS("Debit Amount", "Credit Amount");
                Solde := GLAccount2."Debit Amount" - GLAccount2."Credit Amount";
                if "Income/Balance".AsInteger() = 0 then
                    SETRANGE("Date Filter", StartDate, EndDate)
                else
                    SETRANGE("Date Filter", 0D, EndDate);
                CALCFIELDS("Debit Amount", "Credit Amount");
                if ("Debit Amount" = 0) and ("Credit Amount" = 0) then
                    CurrReport.SKIP();

                ShowBodyGLAccount := ((GLAccount2."Debit Amount" = "Debit Amount") and (GLAccount2."Credit Amount" = "Credit Amount"))
                  or ("Account Type".AsInteger() <> 0);
            end;

            trigger OnPreDataItem();
            begin
                if GETFILTER("Date Filter") = '' then
                    ERROR(Text001, FIELDCAPTION("Date Filter"));
                if COPYSTR(GETFILTER("Date Filter"), 1, 1) = '.' then
                    ERROR(Text002);
                StartDate := GETRANGEMIN("Date Filter");
                Period.SETRANGE("Period Start", StartDate);
                case TotalBy of
                    TotalBy::" ":
                        Period.SETRANGE("Period Type", Period."Period Type"::Date);
                    TotalBy::Week:
                        Period.SETRANGE("Period Type", Period."Period Type"::Week);
                    TotalBy::Month:
                        Period.SETRANGE("Period Type", Period."Period Type"::Month);
                    TotalBy::Quarter:
                        Period.SETRANGE("Period Type", Period."Period Type"::Quarter);
                    TotalBy::Year:
                        Period.SETRANGE("Period Type", Period."Period Type"::Year);
                end;
                if not Period.FINDFIRST() then
                    ERROR(Text010, StartDate, Period.GETFILTER("Period Type"));
                PreviousEndDate := CLOSINGDATE(StartDate - 1);
                FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := CONVERTSTR(TextDate, '.', ',');
                // FiltreDateCalc.VerifiyDateFilter(TextDate);  // BC Upgrade SHUKLP03 - Blocked
                HeinekenBCUpgrade.VerifiyDateFilter(TextDate);  // BC Upgrade SHUKLP03 - Added
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                if COPYSTR(GETFILTER("Date Filter"), STRLEN(GETFILTER("Date Filter")), 1) = '.' then
                    EndDate := 0D
                else
                    EndDate := GETRANGEMAX("Date Filter");
                CLEAR(Period);
                Period.SETRANGE("Period End", CLOSINGDATE(EndDate));
                case TotalBy of
                    TotalBy::" ":
                        Period.SETRANGE("Period Type", Period."Period Type"::Date);
                    TotalBy::Week:
                        Period.SETRANGE("Period Type", Period."Period Type"::Week);
                    TotalBy::Month:
                        Period.SETRANGE("Period Type", Period."Period Type"::Month);
                    TotalBy::Quarter:
                        Period.SETRANGE("Period Type", Period."Period Type"::Quarter);
                    TotalBy::Year:
                        Period.SETRANGE("Period Type", Period."Period Type"::Year);
                end;
                if not Period.FINDFIRST() then
                    ERROR(Text011, EndDate, Period.GETFILTER("Period Type"));

                // CurrReport.CREATETOTALS(GLAccount2."Debit Amount", GLAccount2."Credit Amount",
                //   "Debit Amount", "Credit Amount",
                //   "G/L Entry"."Debit Amount", "G/L Entry"."Credit Amount");
                //BCUPG CREATETOTALS DEPRECATED //PANDEA04
                TotalByInt := TotalBy;
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
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field(CentralizedBy; TotalBy)
                    {
                        CaptionML = ENU = 'Centralized by',
                                    FRA = 'Centralisé par';
                        OptionCaptionML = ENU = ' ,Week,Month,Quarter,Year',
                                          FRA = ' ,Semaine,Mois,Trimestre,Année';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the TotalBy field.';
                    }
                    field(SortedByDocumentNo; DocNumSort)
                    {
                        CaptionML = ENU = 'Sorted by Document No.',
                                    FRA = 'Trié par n° document';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the DocNumSort field.';
                    }
                    field(IncludeSourceCurr; IncludeSourceCurr)
                    {
                        Caption = 'Include Source Currency';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Include Source Currency field.';
                    }
                    field(IncludeGlobDim1; IncludeGlobDim1)
                    {
                        Caption = 'Include Global Dim 1';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Include Global Dim 1 field.';
                    }
                    field(IncludeGlobDim2; IncludeGlobDim2)
                    {
                        Caption = 'Include Global Dim 2';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Include Global Dim 2 field.';
                    }
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
        TotalBy := TotalBy::Month
    end;

    trigger OnPreReport();
    begin
        Filter := "G/L Account".GETFILTERS;
    end;

    var
        Period: Record Date;
        GLAccount2: Record "G/L Account";
        FiltreDateCalc: Codeunit "DateFilter-Calc";
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";  // BC Upgrade SHUKLP03
        DocNumSort: Boolean;

        IncludeGlobDim1: Boolean;

        IncludeGlobDim2: Boolean;

        IncludeSourceCurr: Boolean;
        ShowBodyGLAccount: Boolean;
        EndDate: Date;
        PreviousEndDate: Date;
        PreviousStartDate: Date;
        StartDate: Date;
        Solde: Decimal;
        TotalByInt: Integer;
        TotalBy: Option " ",Week,Month,Quarter,Year;
        TextDate: Text[30];
        "Filter": Text[250];
        GLAccountTypeFilter: Text[250];
        BalanceCaptionLbl: TextConst ENU = 'Balance', FRA = 'Solde';
        ContinuedCaptionLbl: TextConst ENU = 'Continued', FRA = 'Suite';
        CreditCaptionLbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        Current_pageCaptionLbl: TextConst ENU = 'Current page', FRA = 'Page courante';
        DebitCaptionLbl: TextConst ENU = 'Debit', FRA = 'Débit';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Désignation';
        Document_No_CaptionLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        External_Document_No_CaptionLbl: TextConst ENU = 'External Doc. No.', FRA = 'N° doc. externe';
        G_L_Detail_Trial_BalanceCaptionLbl: TextConst ENU = 'G/L Detail Trial Balance', FRA = 'Grand livre comptes généraux';
        GlobalDim1CaptionLbl: TextConst ENU = 'Global Dim. 1', FRA = 'Axe principal 1';
        GlobalDim2CaptionLbl: TextConst ENU = 'Global Dim. 2', FRA = 'Axe principal 2';
        Grand_TotalCaptionLbl: TextConst ENU = 'Grand Total', FRA = 'Total général';
        LocalAccNameCaptionLbl: TextConst ENU = 'Local Account Name', FRA = 'Nom compte local';
        LocalAccNoCaptionLbl: TextConst ENU = 'Local Account No.', FRA = 'Nº compte local';
        Posting_DateCaptionLbl: TextConst ENU = 'Posting Date', FRA = 'Date comptabilisation';
        Previous_pageCaptionLbl: TextConst ENU = 'Previous page', FRA = 'Page précédente';
        Source_CodeCaptionLbl: TextConst ENU = 'Source Code', FRA = 'Code journal';
        SourceCurrencyCaptionLbl: TextConst ENU = 'Source Currency', FRA = 'Devise origine';
        Text001: TextConst ENU = 'You must fill in the %1 field.', FRA = 'Vous devez renseigner le champ %1.';
        Text002: TextConst ENU = 'You must specify a Starting Date.', FRA = 'Vous devez spécifier une date de début.';
        Text003: TextConst ENU = 'Printed by %1', FRA = 'Imprimé par %1';
        Text004: TextConst ENU = 'Fiscal Year Start Date : %1', FRA = 'Début exercice comptable : %1';
        Text005: TextConst ENU = 'Page %1', FRA = 'Page %1';
        Text006: TextConst ENU = 'Balance at %1 ', FRA = 'Solde au %1 ';
        Text007: TextConst ENU = 'Balance at %1', FRA = 'Solde au %1';
        Text008: TextConst ENU = 'Total', FRA = 'Total';
        Text010: TextConst ENU = 'The selected starting date %1 is not the start of a %2.', FRA = 'La date de début choisie (%1) ne correspond pas au début de %2.';
        Text011: TextConst ENU = 'The selected ending date %1 is not the end of a %2.', FRA = 'La date de fin choisie (%1) ne correspond pas à la fin de %2.';
        Text012: TextConst ENU = 'Fiscal-Year Status: %1', FRA = 'Statut de l''exercice comptable : %1';
        To_be_continuedCaptionLbl: TextConst ENU = 'To be continued', FRA = '‡ suivre';
        Total_Date_RangeCaptionLbl: TextConst ENU = 'Total Date Range', FRA = 'Total plage de dates';
}

