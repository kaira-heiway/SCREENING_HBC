report 51046 "Bank Acc.Trial Balance LR CBN"
{
    // version NAVFR7.10,HEI.01

    // HEI.01 FDD-HT520 IBM.GUNERE01 26.08.2019
    //   # Report imported from HeiLite 2.0
    DefaultLayout = RDLC;
    ApplicationArea = ALL;   // BC Upgrade SHUKLP03 <<
    UsageCategory = ReportsAndAnalysis;  // BC Upgrade SHUKLP03 <<
    RDLCLayout = '.\src\ReportsLayout\Bank Acc. Trial Balance LR.rdl';

    CaptionML = ENU = 'Bank Acc. Trial Balance FR',
                FRA = 'Balance comptes bancaires FR';

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Search Name", "Date Filter";
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
            column(STRSUBSTNO_Text005_____; STRSUBSTNO(Text005, ' '))
            {
            }
            column(PrintedByCaption; STRSUBSTNO(Text003, ''))
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
            column(BankAccount2__Debit_Amount__LCY_____BankAccount2__Credit_Amount__LCY__; BankAccount2."Debit Amount (LCY)" - BankAccount2."Credit Amount (LCY)")
            {
            }
            column(BankAccount2__Credit_Amount__LCY_____BankAccount2__Debit_Amount__LCY__; BankAccount2."Credit Amount (LCY)" - BankAccount2."Debit Amount (LCY)")
            {
            }
            column(Bank_Account__Debit_Amount__LCY__; "Debit Amount (LCY)")
            {
            }
            column(Bank_Account__Credit_Amount__LCY__; "Credit Amount (LCY)")
            {
            }
            column(BankAccount2__Debit_Amount__LCY______Debit_Amount__LCY_____BankAccount2__Credit_Amount__LCY______Credit_Amount__LCY__; BankAccount2."Debit Amount (LCY)" + "Debit Amount (LCY)" - BankAccount2."Credit Amount (LCY)" - "Credit Amount (LCY)")
            {
            }
            column(BankAccount2__Credit_Amount__LCY______Credit_Amount__LCY_____BankAccount2__Debit_Amount__LCY______Debit_Amount__LCY__; BankAccount2."Credit Amount (LCY)" + "Credit Amount (LCY)" - BankAccount2."Debit Amount (LCY)" - "Debit Amount (LCY)")
            {
            }
            column(BankAccount2__Debit_Amount__LCY_____BankAccount2__Credit_Amount__LCY___Control1120069; BankAccount2."Debit Amount (LCY)" - BankAccount2."Credit Amount (LCY)")
            {
            }
            column(BankAccount2__Credit_Amount__LCY_____BankAccount2__Debit_Amount__LCY___Control1120072; BankAccount2."Credit Amount (LCY)" - BankAccount2."Debit Amount (LCY)")
            {
            }
            column(Bank_Account__Debit_Amount__LCY___Control1120075; "Debit Amount (LCY)")
            {
            }
            column(Bank_Account__Credit_Amount__LCY___Control1120078; "Credit Amount (LCY)")
            {
            }
            column(DataItem1120081; BankAccount2."Debit Amount (LCY)" + "Debit Amount (LCY)" - BankAccount2."Credit Amount (LCY)" - "Credit Amount (LCY)")
            {
            }
            column(DataItem1120084; BankAccount2."Credit Amount (LCY)" + "Credit Amount (LCY)" - BankAccount2."Debit Amount (LCY)" - "Debit Amount (LCY)")
            {
            }
            column(Bank_Account_Trial_BalanceCaption; Bank_Account_Trial_BalanceCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Balance_at_Starting_DateCaption; Balance_at_Starting_DateCaptionLbl)
            {
            }
            column(Balance_Date_RangeCaption; Balance_Date_RangeCaptionLbl)
            {
            }
            column(Balance_at_Ending_dateCaption; Balance_at_Ending_dateCaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(DebitCaption_Control1120030; DebitCaption_Control1120030Lbl)
            {
            }
            column(CreditCaption_Control1120032; CreditCaption_Control1120032Lbl)
            {
            }
            column(DebitCaption_Control1120034; DebitCaption_Control1120034Lbl)
            {
            }
            column(CreditCaption_Control1120036; CreditCaption_Control1120036Lbl)
            {
            }
            column(Grand_totalCaption; Grand_totalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                BankAccount2 := "Bank Account";
                BankAccount2.SETRANGE("Date Filter", 0D, PreviousEndDate);
                BankAccount2.CALCFIELDS("Debit Amount (LCY)", "Credit Amount (LCY)");
                if not PrintBanksWithoutBalance and
                   (BankAccount2."Debit Amount (LCY)" = 0) and
                   ("Debit Amount (LCY)" = 0) and
                   (BankAccount2."Credit Amount (LCY)" = 0) and
                   ("Credit Amount (LCY)" = 0)
                then
                    CurrReport.SKIP();
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
                HEINEKENBCU.VerifiyDateFilter(TextDate);  // BC Upgrade SHUKLP03 <<
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                if COPYSTR(GETFILTER("Date Filter"), STRLEN(GETFILTER("Date Filter")), 1) = '.' then
                    EndDate := 0D
                else
                    EndDate := GETRANGEMAX("Date Filter");
                // CurrReport.CREATETOTALS(BankAccount2."Debit Amount (LCY)", BankAccount2."Credit Amount (LCY)"); //BCUPG CREATETOTALS DEPRECATED //PANDEA04
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
                    field(PrintBanksWithoutBalance; PrintBanksWithoutBalance)
                    {
                        CaptionML = ENU = 'Print Banks without Balance',
                                    FRA = 'Imprimer banques sans solde';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the PrintBanksWithoutBalance field.';
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

    trigger OnPreReport();
    begin
        Filter := "Bank Account".GETFILTERS;
    end;

    var
        BankAccount2: Record "Bank Account";
        FiltreDateCalc: Codeunit "DateFilter-Calc";
        HEINEKENBCU: Codeunit "Heineken BC Upgrade";  // BC Upgrade SHUKLP03 <<
        PrintBanksWithoutBalance: Boolean;
        EndDate: Date;
        PreviousEndDate: Date;
        PreviousStartDate: Date;
        StartDate: Date;
        TextDate: Text[30];
        "Filter": Text[250];
        Balance_at_Ending_dateCaptionLbl: TextConst ENU = 'Balance at Ending date', FRA = 'Solde à la date de fin';
        Balance_at_Starting_DateCaptionLbl: TextConst ENU = 'Balance at Starting Date', FRA = 'Solde à la date de début';
        Balance_Date_RangeCaptionLbl: TextConst ENU = 'Balance Date Range', FRA = 'Solde plage de dates';
        Bank_Account_Trial_BalanceCaptionLbl: TextConst ENU = 'Bank Account Trial Balance', FRA = 'Balance comptes bancaires';
        CreditCaption_Control1120032Lbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        CreditCaption_Control1120036Lbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        CreditCaptionLbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        DebitCaption_Control1120030Lbl: TextConst ENU = 'Debit', FRA = 'Débit';
        DebitCaption_Control1120034Lbl: TextConst ENU = 'Debit', FRA = 'Débit';
        DebitCaptionLbl: TextConst ENU = 'Debit', FRA = 'Débit';
        Grand_totalCaptionLbl: TextConst ENU = 'Grand total', FRA = 'Total général';
        NameCaptionLbl: TextConst ENU = 'Name', FRA = 'Nom';
        No_CaptionLbl: TextConst ENU = 'No.', FRA = 'N°';
        Text001: TextConst ENU = 'You must fill in the %1 field.', FRA = 'Vous devez renseigner le champ %1.';
        Text002: TextConst ENU = 'You must specify a Starting Date.', FRA = 'Vous devez spécifier une date de début.';
        Text003: TextConst ENU = 'Printed by %1', FRA = 'Imprimé par %1';
        Text004: TextConst ENU = 'Fiscal Year Start Date : %1', FRA = 'Début exercice comptable : %1';
        Text005: TextConst ENU = 'Page %1', FRA = 'Page %1';
}

