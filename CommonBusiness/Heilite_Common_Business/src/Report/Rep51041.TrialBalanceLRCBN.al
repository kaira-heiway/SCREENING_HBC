report 51041 "Trial Balance LR CBN"
{
    // version NAVFR7.10,IBM 1001,HEI.01

    // HNK100022 MRA-IBM 12/07/15: New report based on the standard French localization report 10803
    // Issue 73 Ivory MRA-IBM 22/07/16: The fields DebitAmt_GLAcc and CreditAmt_GLAcc were filled with "Debit amount" and "Credit Amount" resp. and now
    //                                  replaced with "Net Change" and -"Net Change" resp.
    // 
    // Ivory::Issue 158 - 03/06/2017 - hortoc01
    // 
    // HEI.01 FDD-HT520 IBM.GUNERE01 26.08.2019
    //   # Report imported from HeiLite 2.0
    // HEI.02 IBM BULIMC01 18.03.2020 #changes in the layout
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Trial Balance LR.rdl';

    CaptionML = ENU = 'Trial Balance FR',
                FRA = 'Balance comptes généraux FR';
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Date Filter";
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(PreviousStartDateText; STRSUBSTNO(Text004, PreviousStartDate))
            {
            }
            column(PageCaption; STRSUBSTNO(Text005, ''))
            {
            }
            column(UserCaption; STRSUBSTNO(Text003, ''))
            {
            }
            column(GLAccTableCaptionFilter; "G/L Account".TABLECAPTION + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(No_GLAcc; "No.")
            {
            }
            column(Name_GLAcc; Name)
            {
            }
            column(G_L_Account__No2; "G/L Account"."No. 2")
            {
            }
            column(G_L_Account__LocalName; "G/L Account"."Local Name FND")
            {
            }
            column(GLAcc2DebitAmtCreditAmt; GLAccount2."Debit Amount" - GLAccount2."Credit Amount")
            {
            }
            column(GLAcc2CreditAmtDebitAmt; GLAccount2."Credit Amount" - GLAccount2."Debit Amount")
            {
            }
            column(DebitAmt_GLAcc; "Net Change")
            {
            }
            column(CreditAmt_GLAcc; -"Net Change")
            {
            }
            column(BalAtEndingDateDebitCaption; GLAccount2."Debit Amount" + "Debit Amount" - GLAccount2."Credit Amount" - "Credit Amount")
            {
            }
            column(BalAtEndingDateCreditCaption; GLAccount2."Credit Amount" + "Credit Amount" - GLAccount2."Debit Amount" - "Debit Amount")
            {
            }
            column(TLAccType; TLAccountType)
            {
            }
            column(GLTrialBalCaption; GLTrialBalCaptionLbl)
            {
            }
            column(NoCaption; NoCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(BalAtStartingDateCaption; BalAtStartingDateCaptionLbl)
            {
            }
            column(BalDateRangeCaption; BalDateRangeCaptionLbl)
            {
            }
            column(BalAtEndingdateCaption; BalAtEndingdateCaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(LocalNoCaption; LocalAccNoCaptionLbl)
            {
            }
            column(LocalAccNameCaption; LocalAccNameCaptionLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                CALCFIELDS("Debit Amount", "Credit Amount");
                GLAccount2.COPY("G/L Account");
                if GLAccount2."Income/Balance".AsInteger() = 0 then begin
                    //SETRANGE("Date Filter",PreviousStartDate,PreviousEndDate);//Ivory::Issue 158
                    GLAccount2.SETRANGE("Date Filter", 0D, PreviousEndDate);//Ivory::Issue 158
                    GLAccount2.CALCFIELDS("Debit Amount", "Credit Amount");
                end else begin
                    GLAccount2.SETRANGE("Date Filter", 0D, PreviousEndDate);
                    GLAccount2.CALCFIELDS("Debit Amount", "Credit Amount");
                end;
                if not ImprNonMvt and
                   (GLAccount2."Debit Amount" = 0) and
                   ("Debit Amount" = 0) and
                   (GLAccount2."Credit Amount" = 0) and
                   ("Credit Amount" = 0)
                then
                    CurrReport.SKIP();

                TLAccountType := "G/L Account"."Account Type".AsInteger();
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
                // FiltreDateCalc.VerifiyDateFilter(TextDate);  // BC Upgrade YADAVM09 - Blocked
                HeinekenBCUpgrade.VerifiyDateFilter(TextDate);  // BC Upgrade YADAVM09 - Added
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                if COPYSTR(GETFILTER("Date Filter"), STRLEN(GETFILTER("Date Filter")), 1) = '.' then
                    EndDate := 0D
                else
                    EndDate := GETRANGEMAX("Date Filter");
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
                    field(PrintGLAccsWithoutBalance; ImprNonMvt)
                    {
                        CaptionML = ENU = 'Print G/L Accs. without balance',
                                    FRA = 'Impr. cptes non mouvementés';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ImprNonMvt field.';
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
        Filter := "G/L Account".GETFILTERS;
    end;

    var
        GLAccount2: Record "G/L Account";
        FiltreDateCalc: Codeunit "DateFilter-Calc";
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";  // BC Upgrade YADAVM09
        ImprNonMvt: Boolean;
        EndDate: Date;
        PreviousEndDate: Date;
        PreviousStartDate: Date;
        StartDate: Date;
        TLAccountType: Integer;
        TextDate: Text[30];
        "Filter": Text[250];
        BalAtEndingdateCaptionLbl: TextConst ENU = 'Balance at Ending date', FRA = 'Solde à la date de fin';
        BalAtStartingDateCaptionLbl: TextConst ENU = 'Balance at Starting Date', FRA = 'Solde à la date de début';
        BalDateRangeCaptionLbl: TextConst ENU = 'Balance Date Range', FRA = 'Solde plage de dates';
        CreditCaptionLbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        DebitCaptionLbl: TextConst ENU = 'Debit', FRA = 'Débit';
        GLTrialBalCaptionLbl: TextConst ENU = 'G/L Trial Balance', FRA = 'Balance comptes généraux';
        LocalAccNameCaptionLbl: TextConst ENU = 'Local Account Name', FRA = 'Nom compte local';
        LocalAccNoCaptionLbl: TextConst ENU = 'Local Account No.', FRA = 'Nº compte local';
        NameCaptionLbl: TextConst ENU = 'Name', FRA = 'Nom';
        NoCaptionLbl: TextConst ENU = 'No.', FRA = 'N°';
        Text001: TextConst ENU = 'You must fill in the %1 field.', FRA = 'Vous devez renseigner le champ %1.';
        Text002: TextConst ENU = 'You must specify a Starting Date.', FRA = 'Vous devez spécifier une date de début.';
        Text003: TextConst ENU = 'Printed by %1', FRA = 'Imprimé par %1';
        Text004: TextConst ENU = 'Fiscal Year Start Date : %1', FRA = 'Début exercice comptable : %1';
        Text005: TextConst ENU = 'Page %1', FRA = 'Page %1';
        Text007: TextConst ENU = 'Fiscal-Year Status: %1', FRA = 'Statut de l''exercice comptable : %1';
}

