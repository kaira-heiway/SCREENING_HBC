report 51045 "Customer Trial Bal LR CBN"
{
    // version NAVFR7.10,DITW17.10.03,IBM 1001,HEI.01

    // DITW16.00.00.41 AHU 16/08/2012 DIT-715 #327 Added Service contract filters for function CalcAmounts()
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields "Item Charge Type Filter"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 19/12/2013 DIT-770 #163 : Few Filter Added & Removed in Show Result
    // DITW17.10.03 MSF 28/03/2014 DIT-715 #340 Added Filter "Customer posting Group"
    // HNK100089 MRA-IBM 23/07/15: Added to ReqFilterFields fields in Customer "Item Charge Type Filter"
    // HNK100048 MRA-IBM 23/07/15: New report based on the French localization report 10805 with the added modifications of DIT from standard report 129
    // FDD-HNK 100128 NaikH01 12/02/2016 : Changed the report Layout , Grouped by "Customer Posting Group"
    // 
    // HEI.01 FDD-HT520 IBM.GUNERE01 26.08.2019
    //   # Report imported from HeiLite 2.0
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea Property in Report and Actions
    // 2. Create Custom Function  VerifiyDateFilter .
    // 3. Add Layout Path.
    // 4. Remove Drink-IT Fields And Drink-IT Related Code.
    // BC Upgrade BHARDA11 <<
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\src\ReportsLayout\Customer Trial Balance LR.rdl';

    CaptionML = ENU = 'Customer Trial Balance FR',
                FRA = 'Balance clients FR';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            // RequestFilterFields = "No.", "Search Name", "Date Filter", "Customer Posting Group Filter", "Item Charge Type Filter"; // BC Upgrade BHARDA11 ----drink-It Fields ("Customer Posting Group Filter","Item Charge Type Filter")
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
            column(Customer_TABLECAPTION__________Filter; Customer.TABLECAPTION + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY; PreviousDebitAmountLCY - PreviousCreditAmountLCY)
            {
            }
            column(PreviousCreditAmountLCY_PreviousDebitAmountLCY; PreviousCreditAmountLCY - PreviousDebitAmountLCY)
            {
            }
            column(PeriodDebitAmountLCY; PeriodDebitAmountLCY)
            {
            }
            column(PeriodCreditAmountLCY; PeriodCreditAmountLCY)
            {
            }
            column(PreviousDebitAmountLCY_PeriodDebitAmountLCY___PreviousCreditAmountLCY_PeriodCreditAmountLCY_; (PreviousDebitAmountLCY + PeriodDebitAmountLCY) - (PreviousCreditAmountLCY + PeriodCreditAmountLCY))
            {
            }
            column(PreviousCreditAmountLCY_PeriodCreditAmountLCY___PreviousDebitAmountLCY_PeriodDebitAmountLCY_; (PreviousCreditAmountLCY + PeriodCreditAmountLCY) - (PreviousDebitAmountLCY + PeriodDebitAmountLCY))
            {
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY_Control1120069; PreviousDebitAmountLCY - PreviousCreditAmountLCY)
            {
            }
            column(PreviousCreditAmountLCY_PreviousDebitAmountLCY_Control1120072; PreviousCreditAmountLCY - PreviousDebitAmountLCY)
            {
            }
            column(PeriodDebitAmountLCY_Control1120075; PeriodDebitAmountLCY)
            {
            }
            column(PeriodCreditAmountLCY_Control1120078; PeriodCreditAmountLCY)
            {
            }
            column(PreviousDebitAmountLCY_PeriodDebitAmountLCY___PreviousCreditAmountLCY_PeriodCreditAmountLCY__Control1120081; (PreviousDebitAmountLCY + PeriodDebitAmountLCY) - (PreviousCreditAmountLCY + PeriodCreditAmountLCY))
            {
            }
            column(PreviousCreditAmountLCY_PeriodCreditAmountLCY___PreviousDebitAmountLCY_PeriodDebitAmountLCY__Control1120084; (PreviousCreditAmountLCY + PeriodCreditAmountLCY) - (PreviousDebitAmountLCY + PeriodDebitAmountLCY))
            {
            }
            column(Customer_Trial_BalanceCaption; Customer_Trial_BalanceCaptionLbl)
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
            column(CustomerPostingGroup_Customer; Customer."Customer Posting Group")
            {
            }

            trigger OnAfterGetRecord();
            begin
                PreviousDebitAmountLCY := 0;
                PreviousCreditAmountLCY := 0;
                PeriodDebitAmountLCY := 0;
                PeriodCreditAmountLCY := 0;
                CustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2",
  "Currency Code");
                CustLedgEntry.SETRANGE("Customer No.", "No.");
                IF Customer.GETFILTER("Global Dimension 1 Filter") <> '' THEN
                    CustLedgEntry.SETRANGE("Initial Entry Global Dim. 1", Customer.GETFILTER("Global Dimension 1 Filter"));
                IF Customer.GETFILTER("Global Dimension 2 Filter") <> '' THEN
                    CustLedgEntry.SETRANGE("Initial Entry Global Dim. 2", Customer.GETFILTER("Global Dimension 2 Filter"));
                IF Customer.GETFILTER("Currency Filter") <> '' THEN
                    CustLedgEntry.SETRANGE("Currency Code", Customer.GETFILTER("Currency Filter"));
                CustLedgEntry.SETRANGE("Posting Date", 0D, PreviousEndDate);
                CustLedgEntry.SETFILTER("Entry Type", '<>%1', CustLedgEntry."Entry Type"::Application);
                // BC Upgrade BHARDA11 >> ----Drink-IT Code
                // // <<DITW16.00.00.41 AHU 16/08/2012 DIT-715 #327
                // SETFILTER("DIT Sub-Contract Type", Customer.GETFILTER("DIT Sub-Contract Type Filter"));
                // SETFILTER("Service Contract No.", Customer.GETFILTER("Service Contract No. Filter"));
                // SETFILTER("Contract Group Code", Customer.GETFILTER("Contract Group Filter"));
                // // >>DITW16.00.00.41 AHU DIT-715 #327
                // // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                // SETFILTER("Item Charge Type", Customer.GETFILTER("Item Charge Type Filter"));
                // // >>DITW16.00.00.42 DDR DIT-715 #370
                // //<<DITW17.10.03 MSF 28/03/2014 DIT-715 #340
                // SETFILTER("Customer Posting Group", Customer.GETFILTER("Customer Posting Group Filter"));
                // //>>DITW17.10.03 MSF 28/03/2014 DIT-715 #340
                // BC Upgrade BHARDA11 << ----Drink-IT Code
                IF CustLedgEntry.FIND('-') THEN
                    REPEAT
                        PreviousDebitAmountLCY += CustLedgEntry."Debit Amount (LCY)";
                        PreviousCreditAmountLCY += CustLedgEntry."Credit Amount (LCY)";
                    UNTIL CustLedgEntry.NEXT() = 0;
                CustLedgEntry.SETRANGE("Posting Date", StartDate, EndDate);
                IF CustLedgEntry.FIND('-') THEN
                    REPEAT
                        PeriodDebitAmountLCY += CustLedgEntry."Debit Amount (LCY)";
                        PeriodCreditAmountLCY += CustLedgEntry."Credit Amount (LCY)";
                    UNTIL CustLedgEntry.NEXT() = 0;
                IF NOT PrintCustWithoutBalance AND (PeriodDebitAmountLCY = 0) AND (PeriodCreditAmountLCY = 0) THEN
                    CurrReport.SKIP();
            end;

            trigger OnPreDataItem();
            begin
                IF GETFILTER("Date Filter") = '' THEN
                    ERROR(Text001, FIELDCAPTION("Date Filter"));
                IF COPYSTR(GETFILTER("Date Filter"), 1, 1) = '.' THEN
                    ERROR(Text002);
                StartDate := GETRANGEMIN("Date Filter");
                PreviousEndDate := CLOSINGDATE(StartDate - 1);
                FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := CONVERTSTR(TextDate, '.', ',');
                // FiltreDateCalc.VerifiyDateFilter(TextDate); // BC Upgrade BHARDA11 --- Use custom Function
                VerifiyDateFilter(TextDate); // BC Upgrade BHARDA11 --- Use custom Function 
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                IF COPYSTR(GETFILTER("Date Filter"), STRLEN(GETFILTER("Date Filter")), 1) = '.' THEN
                    EndDate := 0D
                else
                    EndDate := GETRANGEMAX("Date Filter");
                // CurrReport.CREATETOTALS(PreviousDebitAmountLCY, PreviousCreditAmountLCY, PeriodDebitAmountLCY, PeriodCreditAmountLCY); //BCUPG CREATETOTALS DEPRECATED //PANDEA04
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
                    field(PrintCustomersWithoutBalance; PrintCustWithoutBalance)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Print Customers without Balance',
                                    FRA = 'Imprimer clients sans solde';
                        MultiLine = true;
                        ToolTip = 'Specifies the value of the PrintCustWithoutBalance field.';
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
        Filter := Customer.GETFILTERS;
    end;

    var
        CustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        FiltreDateCalc: Codeunit "DateFilter-Calc";
        PrintCustWithoutBalance: Boolean;
        EndDate: Date;
        PreviousEndDate: Date;
        PreviousStartDate: Date;
        StartDate: Date;
        PeriodCreditAmountLCY: Decimal;
        PeriodDebitAmountLCY: Decimal;
        PreviousCreditAmountLCY: Decimal;
        PreviousDebitAmountLCY: Decimal;
        TextDate: Text[30];
        "Filter": Text[250];
        Balance_at_Ending_dateCaptionLbl: TextConst ENU = 'Balance at Ending date', FRA = 'Solde à la date de fin';
        Balance_at_Starting_DateCaptionLbl: TextConst ENU = 'Balance at Starting Date', FRA = 'Solde à la date de début';
        Balance_Date_RangeCaptionLbl: TextConst ENU = 'Balance Date Range', FRA = 'Solde plage de dates';
        CreditCaption_Control1120032Lbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        CreditCaption_Control1120036Lbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        CreditCaptionLbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        Customer_Trial_BalanceCaptionLbl: TextConst ENU = 'Customer Trial Balance', FRA = 'Balance clients';
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
    // BC Upgrade BHARDA11 >> -- we create his function in the place of codeunit 358 because this funvtion check only date
    procedure VerifiyDateFilter(Filter: Text[30])
    var

        Text10800: Label 'The selected date is not a starting period.';
    begin
        IF Filter = ',,,' THEN
            ERROR(Text10800);
    end;
    // BC Upgrade BHARDA11 <<  ---- we create his function in the place of codeunit 358 because this funvtion check only date

}

