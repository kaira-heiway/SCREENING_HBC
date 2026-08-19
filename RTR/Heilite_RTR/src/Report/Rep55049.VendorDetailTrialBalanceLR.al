report 55049 "Vendor Detail Trial Balance LR"
{
    // version NAVFR7.10,DITW17.10.03,HEI.01

    // DITW16.00.00.41 AHU 16/08/2012 DIT-715 #327 Added Service contract filters for function CalcAmounts()
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields "Item Charge Type Filter"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 19/12/2013 DIT-770 #163 : Few Filter Added & Removed in Show Result
    // DITW17.00.02 AT 22/01/2014 DIT-770 #163 : Setting a Vendor Posting Group Filter does not influence the result
    // HNK100040 MRA 14/07/15: New report based on the standard French localization report 10808 with the added DIT modifications from the standard NAV report 304.
    // FDD-HNK 100128 NaikH01 12/02/2016 : #Added New DataItem "Vendor Ledger Entry" and new Column "Document Date".
    //                                     # Added "Document Date" in report Layout.
    // 
    // HEI.01 FDD-HT520 IBM.GUNERE01 26.08.2019
    //   # Report imported from HeiLite 2.0
    // HEI.02 Defect #4834 IBM.POENAB02 09.12.2019
    //   # Aplying "Vendor Posting Group" filter in Detailed Vendor Ledger Entry
    //   # Modified Detailed Vendor Ledg. Entry - OnPreDataItem, OnInitReport
    // HEI.03 Defect 6161 IBM BULIMC01 25/03/2021 #layout adjustments.

    //Bc Upgrade YADAVM09 Drink it fields blocked.
    //Bc Upgrade YADAVM09 old id is-50313.

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Vendor Detail Trial Balance LR.rdl';

    CaptionML = ENU = 'Vendor Detail Trial Balance FR',
                FRA = 'Grand livre fournisseurs FR';
    UsageCategory = ReportsAndAnalysis;//Bc Upgrade YADAVM09<<
    ApplicationArea = All;//Bc Upgrade YADAVM09<<

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            // RequestFilterFields = "No.","Date Filter","Vendor Posting Group Filter","Item Charge Type Filter";
            RequestFilterFields = "No.", "Date Filter";//Bc Upgrade YADAVM09 "Vendor Posting Group Filter","Item Charge Type Filter" drink it fields<<
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(STRSUBSTNO_Text003_USERID_; STRSUBSTNO(Text003lbl, USERID))
            {
            }
            column(STRSUBSTNO_Text004_PreviousStartDate_; STRSUBSTNO(Text004, PreviousStartDate))
            {
            }
            column(STRSUBSTNO_Text005_CurrReport_PAGENO_; STRSUBSTNO(Text005, CurrReport.PAGENO))
            {
            }
            column(PageCaption; STRSUBSTNO(Text005, ' '))
            {
            }
            column(PrintedByCaption; STRSUBSTNO(Text003Lbl, ''))
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(Vendor_TABLECAPTION__________Filter; Vendor.TABLECAPTION + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Name; Name)
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
            column(Vendor_Date_Filter; "Date Filter")
            {
            }
            column(Vendor_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Vendor_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Vendor_Currency_Filter; "Currency Filter")
            {
            }
            column(Vendor_Detail_Trial_BalanceCaption; Vendor_Detail_Trial_BalanceCaptionLbl)
            {
            }
            column(This_report_also_includes_vendors_that_only_have_balances_Caption; This_report_also_includes_vendors_that_only_have_balances_CaptionLbl)
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
            column(Document_Date_Caption; Document_Date_CaptionLbl)
            {
            }
            dataitem(Date; Date)
            {
                DataItemTableView = SORTING("Period Type");
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
                column(Date__Period_Name_; Date."Period Name")
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
                dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor No." = FIELD("No."), "Posting Date" = FIELD("Date Filter"), "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"), "Currency Code" = FIELD("Currency Filter");
                    DataItemLinkReference = Vendor;
                    DataItemTableView = SORTING("Vendor No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code") WHERE("Entry Type" = FILTER(<> Application));
                    column(Detailed_Vendor_Ledg__Entry__Debit_Amount__LCY__; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Credit_Amount__LCY__; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY__; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Posting_Date_; FORMAT("Posting Date"))
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Source_Code_; "Source Code")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Document_No__; "Document No.")
                    {
                    }
                    column(OriginalLedgerEntry__External_Document_No__; OriginalLedgerEntry."External Document No.")
                    {
                    }
                    column(OriginalLedgerEntry_Description; OriginalLedgerEntry.Description)
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Debit_Amount__LCY___Control1120116; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Credit_Amount__LCY___Control1120119; "Credit Amount (LCY)")
                    {
                    }
                    column(BalanceLCY; BalanceLCY)
                    {
                    }
                    column(Det_Vendor_L_E___Entry_No__; "Detailed Vendor Ledg. Entry"."Entry No.")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Debit_Amount__LCY___Control1120126; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Credit_Amount__LCY___Control1120128; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY___Control1120130; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Text008_________FORMAT_Date__Period_Type___________Date__Period_Name_; Text008 + ' ' + FORMAT(Date."Period Type") + ' ' + Date."Period Name")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Debit_Amount__LCY___Control1120136; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Credit_Amount__LCY___Control1120139; "Credit Amount (LCY)")
                    {
                    }
                    column(BalanceLCY_Control1120142; BalanceLCY)
                    {
                    }
                    column(FooterEnable; not (Date."Period Type" = Date."Period Type"::Year))
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Vendor_No_; "Vendor No.")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Posting_Date; "Posting Date")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Initial_Entry_Global_Dim__1; "Initial Entry Global Dim. 1")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Initial_Entry_Global_Dim__2; "Initial Entry Global Dim. 2")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Currency_Code; "Currency Code")
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
                    dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Entry No." = FIELD("Vendor Ledger Entry No.");
                        column(VendorLedgerEntry_DocumentDate; FORMAT("Vendor Ledger Entry"."Document Date"))
                        {
                        }
                    }

                    trigger OnAfterGetRecord();
                    begin
                        if ("Debit Amount (LCY)" = 0) and
                           ("Credit Amount (LCY)" = 0)
                        then
                            CurrReport.SKIP;
                        BalanceLCY := BalanceLCY + "Debit Amount (LCY)" - "Credit Amount (LCY)";

                        OriginalLedgerEntry.GET("Vendor Ledger Entry No.");

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
                        if DocNumSort then
                            SETCURRENTKEY("Vendor No.", "Document No.", "Posting Date");
                        if StartDate > Date."Period Start" then
                            Date."Period Start" := StartDate;
                        if EndDate < Date."Period End" then
                            Date."Period End" := EndDate;
                        SETRANGE("Posting Date", Date."Period Start", Date."Period End");
                        //HEI.02>>
                        // SETFILTER("Vendor Posting Group", VLEVnedPostGrFilter);//Bc Upgrade YADAVM09 Drink it field<<
                        //HEI.02<<
                    end;
                }

                trigger OnPreDataItem();
                begin
                    SETRANGE("Period Type", TotalBy);
                    SETRANGE("Period Start", StartDate, CLOSINGDATE(EndDate));
                    CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly or (BalanceLCY = 0);

                    CurrReport.CREATETOTALS("Detailed Vendor Ledg. Entry"."Debit Amount (LCY)", "Detailed Vendor Ledg. Entry"."Credit Amount (LCY)");
                end;
            }

            trigger OnAfterGetRecord();
            begin
                PreviousDebitAmountLCY := 0;
                PreviousCreditAmountLCY := 0;
                VendLedgEntry.SETCURRENTKEY(
  "Vendor No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code");
                VendLedgEntry.SETRANGE("Vendor No.", "No.");
                VendLedgEntry.SETRANGE("Posting Date", 0D, PreviousEndDate);
                VendLedgEntry.SETFILTER("Entry Type", '%1|%2|%3|%4|%5|%6|%7|%8', VendLedgEntry."Entry Type"::"Initial Entry", VendLedgEntry."Entry Type"::"Unrealized Loss",
                  VendLedgEntry."Entry Type"::"Unrealized Gain", VendLedgEntry."Entry Type"::"Realized Loss", VendLedgEntry."Entry Type"::"Realized Gain",
                  VendLedgEntry."Entry Type"::"Payment Discount", VendLedgEntry."Entry Type"::"Payment Discount (VAT Excl.)",
                  VendLedgEntry."Entry Type"::"Payment Discount (VAT Adjustment)");
                //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                //Vendor.COPYFILTER("Vendor Posting Group Filter", "Vendor Posting Group");//Bc Upgrade YADAVM09 Drink it field<<
                //>>DITW17.00.02 AT DIT-770 #163
                //Vendor.COPYFILTER("Item Charge Type Filter", "Item Charge Type");//Bc Upgrade YADAVM09 Drink it field<<
                // >>DITW16.00.00.42 DDR DIT-715 #370
                if VendLedgEntry.FIND('-') then
                    repeat
                        PreviousDebitAmountLCY := PreviousDebitAmountLCY + VendLedgEntry."Debit Amount (LCY)";
                        PreviousCreditAmountLCY := PreviousCreditAmountLCY + VendLedgEntry."Credit Amount (LCY)";
                    until VendLedgEntry.NEXT = 0;
                VendLedgEntry2.COPYFILTERS(VendLedgEntry);
                VendLedgEntry2.SETRANGE("Posting Date", StartDate, EndDate);
                if ExcludeBalanceOnly then begin
                    if VendLedgEntry2.COUNT > 0 then begin
                        GeneralDebitAmountLCY := GeneralDebitAmountLCY + PreviousDebitAmountLCY;
                        GeneralCreditAmountLCY := GeneralCreditAmountLCY + PreviousCreditAmountLCY;
                    end;
                end else begin
                    GeneralDebitAmountLCY := GeneralDebitAmountLCY + PreviousDebitAmountLCY;
                    GeneralCreditAmountLCY := GeneralCreditAmountLCY + PreviousCreditAmountLCY;
                end;
                BalanceLCY := PreviousDebitAmountLCY - PreviousCreditAmountLCY;

                DebitPeriodAmount := 0;
                CreditPeriodAmount := 0;
                CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly or (BalanceLCY = 0);
            end;

            trigger OnPreDataItem();
            begin
                if GETFILTER("Date Filter") = '' then
                    ERROR(Text001Err, FIELDCAPTION("Date Filter"));
                if COPYSTR(GETFILTER("Date Filter"), 1, 1) = '.' then
                    ERROR(Text002Err);
                StartDate := GETRANGEMIN("Date Filter");
                PreviousEndDate := CLOSINGDATE(StartDate - 1);
                FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := CONVERTSTR(TextDate, '.', ',');
                //FiltreDateCalc.VerifiyDateFilter(TextDate);// BC Upgrade YADAVM09 - Blocked.
                HeinekenBCUpgrade.VerifiyDateFilter(TextDate);  // BC Upgrade YADAVM09 - Added.
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
                    field(DocNumSort; DocNumSort)
                    {
                        CaptionML = ENU = 'Sorted by Document No.',
                                    FRA = 'Trié par n° document';
                        ToolTip = 'Sort records by document number.';
                        ApplicationArea = All;//Bc Upgrade YADAVM09<
                    }
                    field(ExcludeBalanceOnly; ExcludeBalanceOnly)
                    {
                        CaptionML = ENU = 'Exclude Vendors That Have A Balance Only',
                                    FRA = 'Exclure seulement les fournisseurs qui ont un solde ouvert';
                        MultiLine = true;
                        ToolTip = 'Exclude entries that contain only balance amounts.';
                        ApplicationArea = All;//Bc Upgrade YADAVM09<<
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
        Filter := Vendor.GETFILTERS;

        //HEI.02>>
        VLEVnedPostGrFilter := "Vendor Ledger Entry".GETFILTER("Vendor Posting Group");
        //HEI.02<<
    end;

    var
        VendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        OriginalLedgerEntry: Record "Vendor Ledger Entry";
        VendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
        FiltreDateCalc: Codeunit "DateFilter-Calc";
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";//Bc Upgrade YADAVM09<<
        Text001Err: TextConst ENU = 'You must fill in the %1 field.', FRA = 'Vous devez renseigner le champ %1.';
        Text002Err: TextConst ENU = 'You must specify a Starting Date.', FRA = 'Vous devez spécifier une date de début.';
        Text003Lbl: TextConst ENU = 'Printed by %1', FRA = 'Imprimé par %1';
#pragma warning disable AA0074
        Text004: TextConst ENU = 'Fiscal Year Start Date : %1', FRA = 'Début exercice comptable : %1';
#pragma warning restore AA0074
#pragma warning disable AA0074
        Text005: TextConst ENU = 'Page %1', FRA = 'Page %1';
#pragma warning restore AA0074
#pragma warning disable AA0074
        Text006: TextConst ENU = 'Balance at %1 ', FRA = 'Solde au %1 ';
#pragma warning restore AA0074
#pragma warning disable AA0074
        Text007: TextConst ENU = 'Balance at %1', FRA = 'Solde au %1';
#pragma warning restore AA0074
#pragma warning disable AA0074
        Text008: TextConst ENU = 'Total', FRA = 'Total';
#pragma warning restore AA0074

        StartDate: Date;
        EndDate: Date;
        PreviousStartDate: Date;
        PreviousEndDate: Date;
        TextDate: Text[30];
        BalanceLCY: Decimal;
        TotalBy: Option Date,Week,Month,Quarter,Year;
#pragma warning disable AA0204
        DocNumSort: Boolean;
#pragma warning restore AA0204
        "Filter": Text[250];
        PreviousDebitAmountLCY: Decimal;
        PreviousCreditAmountLCY: Decimal;

        GeneralDebitAmountLCY: Decimal;
        GeneralCreditAmountLCY: Decimal;
        ReportDebitAmountLCY: Decimal;
        ReportCreditAmountLCY: Decimal;

        DebitPeriodAmount: Decimal;
        CreditPeriodAmount: Decimal;

#pragma warning disable AA0204
        ExcludeBalanceOnly: Boolean;
#pragma warning restore AA0204
        Vendor_Detail_Trial_BalanceCaptionLbl: TextConst ENU = 'Vendor Detail Trial Balance', FRA = 'Grand livre fournisseurs';
        This_report_also_includes_vendors_that_only_have_balances_CaptionLbl: TextConst ENU = 'This report also includes vendors that only have balances.', FRA = 'Cet état inclut aussi les fournisseurs ne présentant que des soldes.';
        Posting_DateCaptionLbl: TextConst ENU = 'Posting Date', FRA = 'Date comptabilisation';
        Source_CodeCaptionLbl: TextConst ENU = 'Source Code', FRA = 'Code journal';
        Document_No_CaptionLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        External_Document_No_CaptionLbl: TextConst ENU = 'External Doc. No.', FRA = 'N° doc. externe';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Désignation';
        DebitCaptionLbl: TextConst ENU = 'Debit', FRA = 'Débit';
        CreditCaptionLbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        BalanceCaptionLbl: TextConst ENU = 'Balance', FRA = 'Solde';
        ContinuedCaptionLbl: TextConst ENU = 'Continued', FRA = 'Suite';
        To_be_continuedCaptionLbl: TextConst ENU = 'To be continued', FRA = '‡ suivre';
        Grand_TotalCaptionLbl: TextConst ENU = 'Grand Total', FRA = 'Total général';
        Total_Date_RangeCaptionLbl: TextConst ENU = 'Total Date Range', FRA = 'Total plage de dates';
        Previous_pageCaptionLbl: TextConst ENU = 'Previous page', FRA = 'Page précédente';
        Current_pageCaptionLbl: TextConst ENU = 'Current page', FRA = 'Page courante';
        Document_Date_CaptionLbl: Label 'Document Date';
        VLEVnedPostGrFilter: Text;

}

