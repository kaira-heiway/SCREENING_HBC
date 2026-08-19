report 51068 "BankAccDetTrialBalanceDRCCBN"
{
    // version NAVFR7.10,IBM 1001,HEI.01

    // HEI.01 FDD-HT1146 IBM SURYAS01 20/04/2020
    // #Created New Report -"Bank Acc Det trial Balance - DRC"
    DefaultLayout = RDLC;
    ApplicationArea = ALL;   // BC Upgrade SHUKLP03 <<
    UsageCategory = ReportsAndAnalysis;  // BC Upgrade SHUKLP03 <<
    RDLCLayout = '.\src\ReportsLayout\Bank Acc Det Trial Balance-DRC.rdl';

    CaptionML = ENU = 'Bank Acc. Detail Trial Balance - DRC',
                FRA = 'Grand livre comptes bancaires DRC';

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
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
            column(STRSUBSTNO_Text003____; STRSUBSTNO(Text003, ''))
            {
            }
            column(STRSUBSTNO_Text005____; STRSUBSTNO(Text005, ''))
            {
            }
            column(Bank_Account__TABLECAPTION__________Filter; "Bank Account".TABLECAPTION + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(Bank_Account__No__; "No.")
            {
            }
            column(Bank_Account_Name; Name)
            {
            }
            column(ReportDebitAmountLCY; ReportDebitAmountLCY)
            {
            }
            column(ReportCreditAmountLCY; ReportCreditAmountLCY)
            {
            }
            column(ReportDebitAmountLCY_ReportCreditAmountLCY; ReportDebitAmountLCY - ReportCreditAmountLCY)
            {
            }
            column(STRSUBSTNO_Text006_PreviousEndDate_; STRSUBSTNO(Text006, PreviousEndDate))
            {
            }
            column(PreviousDebitAmountLCY; PreviousDebitAmountLCY)
            {
            }
            column(PreviousCreditAmountLCY; PreviousCreditAmountLCY)
            {
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY; PreviousDebitAmountLCY - PreviousCreditAmountLCY)
            {
            }
            column(DebitAmountLCY; DebitAmountLCY)
            {
            }
            column(CreditAmountLCY; CreditAmountLCY)
            {
            }
            column(ReportDebitAmountLCY_Control1120062; ReportDebitAmountLCY)
            {
            }
            column(ReportCreditAmountLCY_Control1120064; ReportCreditAmountLCY)
            {
            }
            column(ReportDebitAmountLCY_ReportCreditAmountLCY_Control1120066; ReportDebitAmountLCY - ReportCreditAmountLCY)
            {
            }
            column(Bank_Account__Bank_Account___Debit_Amount__LCY__; "Bank Account"."Debit Amount (LCY)")
            {
            }
            column(Bank_Account__Bank_Account___Credit_Amount__LCY__; "Bank Account"."Credit Amount (LCY)")
            {
            }
            column(Bank_Account___Debit_Amount__LCY______Bank_Account___Credit_Amount__LCY__; "Bank Account"."Debit Amount (LCY)" - "Bank Account"."Credit Amount (LCY)")
            {
            }
            column(Bank_Account_Date_Filter; "Date Filter")
            {
            }
            column(Bank_Account_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Bank_Account_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Bank_Acc__Detail_Trial_BalanceCaption; Bank_Acc__Detail_Trial_BalanceCaptionLbl)
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
            dataitem(Date; Date)
            {
                DataItemTableView = sorting("Period Type");
                PrintOnlyIfDetail = true;
                column(DebitPeriodAmount_PreviousDebitAmountLCY___CreditPeriodAmount_PreviousCreditAmountLCY_; (DebitPeriodAmount + PreviousDebitAmountLCY) - (CreditPeriodAmount + PreviousCreditAmountLCY))
                {
                }
                column(CreditPeriodAmount_PreviousCreditAmountLCY; CreditPeriodAmount + PreviousCreditAmountLCY)
                {
                }
                column(DebitPeriodAmount_PreviousDebitAmountLCY; DebitPeriodAmount + PreviousDebitAmountLCY)
                {
                }
                column(STRSUBSTNO_Text006_EndDate_; STRSUBSTNO(Text006, EndDate))
                {
                }
                column(STRSUBSTNO_Text007_EndDate_; STRSUBSTNO(Text007, EndDate))
                {
                }
                column(DebitPeriodAmount; DebitPeriodAmount)
                {
                }
                column(DebitPeriodAmount_PreviousDebitAmountLCY_Control1120082; DebitPeriodAmount + PreviousDebitAmountLCY)
                {
                }
                column(CreditPeriodAmount; CreditPeriodAmount)
                {
                }
                column(CreditPeriodAmount_PreviousCreditAmountLCY_Control1120086; CreditPeriodAmount + PreviousCreditAmountLCY)
                {
                }
                column(DebitPeriodAmount_CreditPeriodAmount; DebitPeriodAmount - CreditPeriodAmount)
                {
                }
                column(DebitPeriodAmount_PreviousDebitAmountLCY___CreditPeriodAmount_PreviousCreditAmountLCY__Control1120090; (DebitPeriodAmount + PreviousDebitAmountLCY) - (CreditPeriodAmount + PreviousCreditAmountLCY))
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
                dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
                {
                    DataItemLink = "Bank Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                    DataItemLinkReference = "Bank Account";
                    DataItemTableView = sorting("Bank Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date");
                    column(Bank_Account_Ledger_Entry__Debit_Amount__LCY__; "Debit Amount (LCY)")
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Credit_Amount__LCY__; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY__; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Source_Code_; "Source Code")
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Document_No__; "Document No.")
                    {
                    }
                    column(OriginalLedgerEntry__External_Document_No__; OriginalLedgerEntry."External Document No.")
                    {
                    }
                    column(OriginalLedgerEntry_Description; OriginalLedgerEntry.Description)
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Debit_Amount__LCY___Control1120116; "Debit Amount (LCY)")
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Credit_Amount__LCY___Control1120119; "Credit Amount (LCY)")
                    {
                    }
                    column(Solde; Solde)
                    {
                    }
                    column(PeriodTypeNo; PeriodTypeNo)
                    {
                    }
                    column(DateRecNo; DateRecNo)
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Debit_Amount__LCY___Control1120126; "Debit Amount (LCY)")
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Credit_Amount__LCY___Control1120128; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY___Control1120130; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Text008_________FORMAT_Date__Period_Type___________Date__Period_Name_; Text008 + ' ' + FORMAT(Date."Period Type") + ' ' + Date."Period Name")
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Debit_Amount__LCY___Control1120136; "Debit Amount (LCY)")
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Credit_Amount__LCY___Control1120139; "Credit Amount (LCY)")
                    {
                    }
                    column(Solde_Control1120142; Solde)
                    {
                    }
                    column(Bank_Account_Ledger_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Bank_Account_Ledger_Entry_Bank_Account_No_; "Bank Account No.")
                    {
                    }
                    column(Bank_Account_Ledger_Entry_Posting_Date; "Posting Date")
                    {
                    }
                    column(Bank_Account_Ledger_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                    {
                    }
                    column(Bank_Account_Ledger_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
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
                        if ("Debit Amount (LCY)" = 0) and
                           ("Credit Amount (LCY)" = 0)
                        then
                            CurrReport.SKIP();
                        Solde := Solde + "Debit Amount (LCY)" - "Credit Amount (LCY)";

                        OriginalLedgerEntry.GET("Entry No.");

                        GeneralDebitAmountLCY += "Debit Amount (LCY)";
                        GeneralCreditAmountLCY += "Credit Amount (LCY)";

                        DebitPeriodAmount += "Debit Amount (LCY)";
                        CreditPeriodAmount += "Credit Amount (LCY)";
                    end;

                    trigger OnPostDataItem();
                    begin
                        ReportDebitAmountLCY += "Debit Amount (LCY)";
                        ReportCreditAmountLCY += "Credit Amount (LCY)";
                    end;

                    trigger OnPreDataItem();
                    begin
                        if DocNumSort then
                            SETCURRENTKEY("Bank Account No.", "Document No.", "Posting Date");
                        if StartDate > Date."Period Start" then
                            Date."Period Start" := StartDate;
                        if EndDate < Date."Period End" then
                            Date."Period End" := EndDate;
                        SETRANGE("Posting Date", Date."Period Start", Date."Period End");
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    DateRecNo += 1;
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Period Type", TotalBy);
                    SETRANGE("Period Start", StartDate, CLOSINGDATE(EndDate));
                    DateRecNo := 0;
                    PeriodTypeNo := "Period Type";
                    //  CurrReport.CREATETOTALS("Bank Account Ledger Entry"."Debit Amount (LCY)", "Bank Account Ledger Entry"."Credit Amount (LCY)");
                    //BCUPG CREATETOTALS DEPRECATED //PANDEA04
                end;
            }

            trigger OnAfterGetRecord();
            begin
                PreviousDebitAmountLCY := 0;
                PreviousCreditAmountLCY := 0;
                BankLedgEntry.SETCURRENTKEY("Bank Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date");
                BankLedgEntry.SETRANGE("Bank Account No.", "No.");
                if "Global Dimension 1 Filter" <> '' then
                    BankLedgEntry.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Filter");
                if "Global Dimension 2 Filter" <> '' then
                    BankLedgEntry.SETRANGE("Global Dimension 2 Code", "Global Dimension 2 Filter");
                BankLedgEntry.SETRANGE("Posting Date", 0D, PreviousEndDate);
                if BankLedgEntry.FIND('-') then
                    repeat
                        PreviousDebitAmountLCY += BankLedgEntry."Debit Amount (LCY)";
                        PreviousCreditAmountLCY += BankLedgEntry."Credit Amount (LCY)";
                    until BankLedgEntry.NEXT() = 0;
                BankLedgEntry2.COPYFILTERS(BankLedgEntry);
                BankLedgEntry2.SETRANGE("Posting Date", StartDate, EndDate);
                if BankLedgEntry2.COUNT > 0 then begin
                    GeneralDebitAmountLCY += PreviousDebitAmountLCY;
                    GeneralCreditAmountLCY += PreviousCreditAmountLCY;
                end;
                Solde := PreviousDebitAmountLCY - PreviousCreditAmountLCY;

                DebitPeriodAmount := 0;
                CreditPeriodAmount := 0;

                DebitAmountLCY += "Debit Amount (LCY)";
                CreditAmountLCY += "Credit Amount (LCY)";
            end;

            trigger OnPreDataItem();
            begin
                if GETFILTER("Date Filter") = '' then
                    ERROR(Text001, FIELDCAPTION("Date Filter"));
                if COPYSTR(GETFILTER("Date Filter"), 1, 1) = '.' then
                    ERROR(Text002);
                StartDate := GETRANGEMIN("Date Filter");
                PreviousEndDate := CLOSINGDATE(StartDate - 1);
                FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := CONVERTSTR(TextDate, '.', ',');
                HEINEKENBCU.VerifiyDateFilter(TextDate);   // BC Upgrade SHUKLP03 <<
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                if COPYSTR(GETFILTER("Date Filter"), STRLEN(GETFILTER("Date Filter")), 1) = '.' then
                    EndDate := 0D
                else
                    EndDate := GETRANGEMAX("Date Filter");

                //CurrReport.CREATETOTALS("Debit Amount (LCY)", "Credit Amount (LCY)");
                //BCUPG CREATETOTALS DEPRECATED //PANDEA04

                DebitAmountLCY := 0;
                CreditAmountLCY := 0;
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
                    field(DocNumSort; DocNumSort)
                    {
                        CaptionML = ENU = 'Sorted by Document No.',
                                    FRA = 'Trié par n° document';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the DocNumSort field.';
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
        TotalBy := TotalBy::Month;
    end;

    trigger OnPreReport();
    begin
        Filter := "Bank Account".GETFILTERS;
    end;

    var
        BankLedgEntry: Record "Bank Account Ledger Entry";
        BankLedgEntry2: Record "Bank Account Ledger Entry";
        OriginalLedgerEntry: Record "Bank Account Ledger Entry";
        FiltreDateCalc: Codeunit "DateFilter-Calc";
        HEINEKENBCU: Codeunit "Heineken BC Upgrade";  // BC Upgrade SHUKLP03 <<
        DocNumSort: Boolean;
        EndDate: Date;
        PreviousEndDate: Date;
        PreviousStartDate: Date;
        StartDate: Date;
        CreditAmountLCY: Decimal;
        CreditPeriodAmount: Decimal;
        DebitAmountLCY: Decimal;
        DebitPeriodAmount: Decimal;
        GeneralCreditAmountLCY: Decimal;
        GeneralDebitAmountLCY: Decimal;
        PreviousCreditAmountLCY: Decimal;
        PreviousDebitAmountLCY: Decimal;
        ReportCreditAmountLCY: Decimal;
        ReportDebitAmountLCY: Decimal;
        Solde: Decimal;
        DateRecNo: Integer;
        PeriodTypeNo: Integer;
        TotalBy: Option Date,Week,Month,Quarter,Year;
        TextDate: Text[30];
        "Filter": Text[250];
        BalanceCaptionLbl: TextConst ENU = 'Balance', FRA = 'Solde';
        Bank_Acc__Detail_Trial_BalanceCaptionLbl: TextConst ENU = 'Bank Acc. Detail Trial Balance', FRA = 'Grand livre comptes bancaires';
        ContinuedCaptionLbl: TextConst ENU = 'Continued', FRA = 'Suite';
        CreditCaptionLbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        Current_pageCaptionLbl: TextConst ENU = 'Current page', FRA = 'Page courante';
        DebitCaptionLbl: TextConst ENU = 'Debit', FRA = 'Débit';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Désignation';
        Document_No_CaptionLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        External_Document_No_CaptionLbl: TextConst ENU = 'External Doc. No.', FRA = 'N° doc. externe';
        Grand_TotalCaptionLbl: TextConst ENU = 'Grand Total', FRA = 'Total général';
        Posting_DateCaptionLbl: TextConst ENU = 'Posting Date', FRA = 'Date comptabilisation';
        Previous_pageCaptionLbl: TextConst ENU = 'Previous page', FRA = 'Page précédente';
        Source_CodeCaptionLbl: TextConst ENU = 'Source Code', FRA = 'Code journal';
        Text001: TextConst ENU = 'You must fill in the %1 field.', FRA = 'Vous devez renseigner le champ %1.';
        Text002: TextConst ENU = 'You must specify a Starting Date.', FRA = 'Vous devez spécifier une date de début.';
        Text003: TextConst ENU = 'Printed by %1', FRA = 'Imprimé par %1';
        Text004: TextConst ENU = 'Fiscal Year Start Date : %1', FRA = 'Début exercice comptable : %1';
        Text005: TextConst ENU = 'Page %1', FRA = 'Page %1';
        Text006: TextConst ENU = 'Balance at %1 ', FRA = 'Solde au %1 ';
        Text007: TextConst ENU = 'Balance at %1', FRA = 'Solde au %1';
        Text008: TextConst ENU = 'Total', FRA = 'Total';
        To_be_continuedCaptionLbl: TextConst ENU = 'To be continued', FRA = '‡ suivre';
        Total_Date_RangeCaptionLbl: TextConst ENU = 'Total Date Range', FRA = 'Total plage de dates';
}

