report 51065 "Cust.DetailTrialBal DRC CBN"
{
    // version NAVFR7.10,DITW17.10.03,IBM 1001,HEI.01

    // HEI.01 FDD-HT1146 IBM SURYAS01 20/04/2020
    // #Created New Report - "Cust. Detail Trial Bal-DRC"
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea Property in Report and Actions
    // 2. Create Custom Function  VerifiyDateFilter .
    // 3. Add Layout Path.
    // 4. Remove Drink-IT Fields And Drink-IT Related Code.
    // BC Upgrade BHARDA11 <<
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\src\ReportsLayout\Cust. Detail Trial Bal - DRC.rdl';

    CaptionML = ENU = 'Customer Detail Trial Balance - DRC',
                FRA = 'Grand livre clients DRC';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            // RequestFilterFields = "No.", "Date Filter", "Customer Posting Group Filter", "Item Charge Type Filter"; // BC Upgrade BHARDA11 ----Drink-IT Fields ("Customer Posting Group Filter", "Item Charge Type Filter")
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
            column(PageCaption; STRSUBSTNO(Text005, ''))
            {
            }
            column(PrintedByCaption; STRSUBSTNO(Text003, ''))
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
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
            column(ReportDebitAmountLCY_Control1120062; ReportDebitAmountLCY)
            {
            }
            column(ReportCreditAmountLCY_Control1120064; ReportCreditAmountLCY)
            {
            }
            column(ReportDebitAmountLCY_ReportCreditAmountLCY_Control1120066; ReportDebitAmountLCY - ReportCreditAmountLCY)
            {
            }
            column(GeneralDebitAmountLCY; GeneralDebitAmountLCY)
            {
            }
            column(GeneralCreditAmountLCY; GeneralCreditAmountLCY)
            {
            }
            column(GeneralDebitAmountLCY_GeneralCreditAmountLCY; GeneralDebitAmountLCY - GeneralCreditAmountLCY)
            {
            }
            column(Customer_Date_Filter; "Date Filter")
            {
            }
            column(Customer_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Customer_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Customer_Currency_Filter; "Currency Filter")
            {
            }
            column(Customer_Detail_Trial_BalanceCaption; Customer_Detail_Trial_BalanceCaptionLbl)
            {
            }
            column(This_report_also_includes_customers_that_only_have_balances_Caption; This_report_also_includes_customers_that_only_have_balances_CaptionLbl)
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
            column(Document_Date_caption; Document_date_captionLbl)
            {
            }
            dataitem(Date; Date)
            {
                DataItemTableView = sorting("Period Type");
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
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Customer No." = FIELD("No."),
                                   "Posting Date" = FIELD("Date Filter"),
                                   "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                   "Currency Code" = FIELD("Currency Filter");
                    DataItemLinkReference = Customer;
                    DataItemTableView = sorting("Customer No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code")
                                        where("Entry Type" = FILTER(<> Application));
                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY__; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY__; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY__; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Posting_Date_; FORMAT("Posting Date"))
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Source_Code_; "Source Code")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Document_No__; "Document No.")
                    {
                    }
                    column(OriginalLedgerEntry__External_Document_No__; OriginalLedgerEntry."External Document No.")
                    {
                    }
                    column(OriginalLedgerEntry_Description; OriginalLedgerEntry.Description)
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY___Control1120116; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY___Control1120119; "Credit Amount (LCY)")
                    {
                    }
                    column(BalanceLCY; BalanceLCY)
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY___Control1120126; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY___Control1120128; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY___Control1120130; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Text008_________FORMAT_Date__Period_Type___________Date__Period_Name_; Text008 + ' ' + FORMAT(Date."Period Type") + ' ' + Date."Period Name")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY___Control1120136; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY___Control1120139; "Credit Amount (LCY)")
                    {
                    }
                    column(BalanceLCY_Control1120142; BalanceLCY)
                    {
                    }
                    column(DatePeriodTypeInt; DatePeriodTypeInt)
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Customer_No_; "Customer No.")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Posting_Date; "Posting Date")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Initial_Entry_Global_Dim__1; "Initial Entry Global Dim. 1")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Initial_Entry_Global_Dim__2; "Initial Entry Global Dim. 2")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Currency_Code; "Currency Code")
                    {
                    }
                    column(Previous_pageCaption; Previous_pageCaptionLbl)
                    {
                    }
                    column(Current_pageCaption; Current_pageCaptionLbl)
                    {
                    }
                    column(PostingYearValue; FORMAT(DATE2DMY("Posting Date", 3)))
                    {
                    }
                    dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                    {
                        DataItemLink = "Entry No." = FIELD("Cust. Ledger Entry No.");
                        column(CustLedgerEntry_DocumentDate; FORMAT("Cust. Ledger Entry"."Document Date"))
                        {
                        }
                    }

                    trigger OnAfterGetRecord();
                    begin
                        IF ("Debit Amount (LCY)" = 0) AND
                           ("Credit Amount (LCY)" = 0)
                        THEN
                            CurrReport.SKIP();
                        BalanceLCY := BalanceLCY + "Debit Amount (LCY)" - "Credit Amount (LCY)";

                        OriginalLedgerEntry.GET("Cust. Ledger Entry No.");

                        GeneralDebitAmountLCY := GeneralDebitAmountLCY + "Debit Amount (LCY)";
                        GeneralCreditAmountLCY := GeneralCreditAmountLCY + "Credit Amount (LCY)";

                        DebitPeriodAmount := DebitPeriodAmount + "Debit Amount (LCY)";
                        CreditPeriodAmount := CreditPeriodAmount + "Credit Amount (LCY)";
                    end;

                    trigger OnPostDataItem();
                    begin
                        ReportDebitAmountLCY := ReportDebitAmountLCY + "Debit Amount (LCY)";
                        ReportCreditAmountLCY := ReportCreditAmountLCY + "Credit Amount (LCY)";
                    end;

                    trigger OnPreDataItem();
                    begin
                        IF DocNumSort THEN
                            SETCURRENTKEY("Customer No.", "Document No.", "Posting Date");
                        IF StartDate > Date."Period Start" THEN
                            Date."Period Start" := StartDate;
                        IF EndDate < Date."Period End" THEN
                            Date."Period End" := EndDate;
                        SETRANGE("Posting Date", Date."Period Start", Date."Period End");
                        // BC Upgrade BHARDA11 >> ----Drink-IT Code
                        // // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                        // Customer.COPYFILTER("DIT Sub-Contract Type Filter", "DIT Sub-Contract Type");
                        // Customer.COPYFILTER("Contract Group Filter", "Contract Group Code");
                        // Customer.COPYFILTER("Service Contract No. Filter", "Service Contract No.");
                        // Customer.COPYFILTER("Item Charge Type Filter", "Item Charge Type");
                        // // >>DITW16.00.00.42 DDR DIT-715 #370
                        // //<<DITW17.10.03 MSF 28/03/2014 DIT-715 #340
                        // Customer.COPYFILTER("Customer Posting Group Filter", "Customer Posting Group");
                        // //>>DITW17.10.03 MSF 28/03/2014 DIT-715 #340
                        // BC Upgrade BHARDA11 << ----Drink-IT Code

                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    DatePeriodTypeInt := Date."Period Type";
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Period Type", TotalBy);
                    SETRANGE("Period Start", StartDate, CLOSINGDATE(EndDate));
                    CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (BalanceLCY = 0);

                    // CurrReport.CREATETOTALS("Detailed Cust. Ledg. Entry"."Debit Amount (LCY)", "Detailed Cust. Ledg. Entry"."Credit Amount (LCY)");//BCUPG CREATETOTALS DEPRECATED //PANDEA04
                end;
            }

            trigger OnAfterGetRecord();
            begin
                PreviousDebitAmountLCY := 0;
                PreviousCreditAmountLCY := 0;
                CustLedgEntry.SETCURRENTKEY(
  "Customer No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code");
                CustLedgEntry.SETRANGE("Customer No.", "No.");
                CustLedgEntry.SETRANGE("Posting Date", 0D, PreviousEndDate);
                CustLedgEntry.SETFILTER("Entry Type", '%1|%2|%3|%4|%5|%6|%7|%8', CustLedgEntry."Entry Type"::"Initial Entry", CustLedgEntry."Entry Type"::"Unrealized Loss",
                  CustLedgEntry."Entry Type"::"Unrealized Gain", CustLedgEntry."Entry Type"::"Realized Loss", CustLedgEntry."Entry Type"::"Realized Gain",
                  CustLedgEntry."Entry Type"::"Payment Discount", CustLedgEntry."Entry Type"::"Payment Discount (VAT Excl.)",
                  CustLedgEntry."Entry Type"::"Payment Discount (VAT Adjustment)");
                // BC Upgrade BHARDA11 >> ----Drink-IT Code
                // // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                // Customer.COPYFILTER("DIT Sub-Contract Type Filter", CustLedgEntry."DIT Sub-Contract Type");
                // Customer.COPYFILTER("Contract Group Filter", CustLedgEntry."Contract Group Code");
                // Customer.COPYFILTER("Service Contract No. Filter", CustLedgEntry."Service Contract No.");
                // Customer.COPYFILTER("Item Charge Type Filter", CustLedgEntry."Item Charge Type");
                // // >>DITW16.00.00.42 DDR DIT-715 #370
                // //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                // Customer.COPYFILTER("Customer Posting Group Filter", CustLedgEntry."Customer Posting Group");
                // //>>DITW17.00.02 AT DIT-770 #163
                // BC Upgrade BHARDA11 << ----Drink-IT Code
                IF CustLedgEntry.FIND('-') THEN
                    REPEAT
                        PreviousDebitAmountLCY := PreviousDebitAmountLCY + CustLedgEntry."Debit Amount (LCY)";
                        PreviousCreditAmountLCY := PreviousCreditAmountLCY + CustLedgEntry."Credit Amount (LCY)";
                    UNTIL CustLedgEntry.NEXT() = 0;
                CustLedgEntry2.COPYFILTERS(CustLedgEntry);
                CustLedgEntry2.SETRANGE("Posting Date", StartDate, EndDate);
                IF ExcludeBalanceOnly THEN BEGIN
                    IF CustLedgEntry2.COUNT > 0 THEN BEGIN
                        GeneralDebitAmountLCY := GeneralDebitAmountLCY + PreviousDebitAmountLCY;
                        GeneralCreditAmountLCY := GeneralCreditAmountLCY + PreviousCreditAmountLCY;
                    end;
                end else BEGIN
                    GeneralDebitAmountLCY := GeneralDebitAmountLCY + PreviousDebitAmountLCY;
                    GeneralCreditAmountLCY := GeneralCreditAmountLCY + PreviousCreditAmountLCY;
                end;
                BalanceLCY := PreviousDebitAmountLCY - PreviousCreditAmountLCY;

                DebitPeriodAmount := 0;
                CreditPeriodAmount := 0;
                CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (BalanceLCY = 0);
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
                // FiltreDateCalc.VerifiyDateFilter(TextDate); // BC Upgrade BHARDA11 ---Use Custom Function
                VerifiyDateFilter(TextDate); // BC Upgrade BHARDA11 ---Use Custom Function
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                IF COPYSTR(GETFILTER("Date Filter"), STRLEN(GETFILTER("Date Filter")), 1) = '.' THEN
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
                    field(DocNumSort; DocNumSort)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Sorted by Document No.',
                                    FRA = 'Trié par n° document';
                        ToolTip = 'Specifies the value of the DocNumSort field.';
                    }
                    field(ExcludeBalanceOnly; ExcludeBalanceOnly)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Exclude Customers That Have a Balance Only',
                                    FRA = 'Exclure seulement les clients qui ont un solde ouvert';
                        MultiLine = true;
                        ToolTip = 'Specifies the value of the ExcludeBalanceOnly field.';
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
        Filter := Customer.GETFILTERS;
    end;

    var
        OriginalLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        FiltreDateCalc: Codeunit "DateFilter-Calc";
        DocNumSort: Boolean;
        ExcludeBalanceOnly: Boolean;
        EndDate: Date;
        PreviousEndDate: Date;
        PreviousStartDate: Date;
        StartDate: Date;
        BalanceLCY: Decimal;
        CreditPeriodAmount: Decimal;
        DebitPeriodAmount: Decimal;
        GeneralCreditAmountLCY: Decimal;
        GeneralDebitAmountLCY: Decimal;
        PreviousCreditAmountLCY: Decimal;
        PreviousDebitAmountLCY: Decimal;
        ReportCreditAmountLCY: Decimal;
        ReportDebitAmountLCY: Decimal;
        DatePeriodTypeInt: Integer;
        Document_date_captionLbl: Label 'Document Date';
        TotalBy: Option Date,Week,Month,Quarter,Year;
        TextDate: Text[30];
        "Filter": Text[250];
        BalanceCaptionLbl: TextConst ENU = 'Balance', FRA = 'Solde';
        ContinuedCaptionLbl: TextConst ENU = 'Continued', FRA = 'Suite';
        CreditCaptionLbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        Current_pageCaptionLbl: TextConst ENU = 'Current page', FRA = 'Page courante';
        Customer_Detail_Trial_BalanceCaptionLbl: TextConst ENU = 'Customer Detail Trial Balance', FRA = 'Grand livre clients';
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
        This_report_also_includes_customers_that_only_have_balances_CaptionLbl: TextConst ENU = 'This report also includes customers that only have balances.', FRA = 'Cet état inclut aussi les clients ne présentant que des soldes.';
        To_be_continuedCaptionLbl: TextConst ENU = 'To be continued', FRA = '‡ suivre';
        Total_Date_RangeCaptionLbl: TextConst ENU = 'Total Date Range', FRA = 'Total plage de dates';
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

