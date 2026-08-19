report 52024 "Vendor Trial Balance - DRC"
{
    // version NAVFR7.10,DITW17.10.03,IBM 1001,HEI.01

    // HEI.01 FDD-HT1146 IBM SURYAS01 20/04/2020
    // # Created New Report - "Vendor Trial Balance-DRC"
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID is 50423.
    // 2. Add ApplicationArea property in Report and requestpage fields.
    // 3. Add layout path and Change extension RDLC to RDL.
    // 4. Removed Drink-IT Columns from Dataset and from rdl layout.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Vendor Trial Balance - DRC.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.

    CaptionML = ENU = 'Vendor Trial Balance - DRC',
                FRA = 'Balance fournisseurs DRC';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Search Name", "Date Filter", "Vendor Posting Group";
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
            column(STRSUBSTNO_Text005_CurrReport_PAGENO_; STRSUBSTNO(Text005, CurrReport.PAGENO))
            {
            }
            column(PageCaption; STRSUBSTNO(Text005, ' '))
            {
            }
            column(PrintedByCaption; STRSUBSTNO(Text003, ''))
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
            column(Vendor_Trial_BalanceCaption; Vendor_Trial_BalanceCaptionLbl)
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
            column(VendorPostingGroup; Vendor."Vendor Posting Group")
            {
            }

            trigger OnAfterGetRecord();
            begin
                PreviousDebitAmountLCY := 0;
                PreviousCreditAmountLCY := 0;
                PeriodDebitAmountLCY := 0;
                PeriodCreditAmountLCY := 0;
                VendLedgEntry.SETCURRENTKEY("Vendor No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2",
  "Currency Code");
                VendLedgEntry.SETRANGE("Vendor No.", "No.");
                IF Vendor.GETFILTER("Global Dimension 1 Filter") <> '' THEN
                    VendLedgEntry.SETRANGE("Initial Entry Global Dim. 1", Vendor.GETFILTER("Global Dimension 1 Filter"));
                IF Vendor.GETFILTER("Global Dimension 2 Filter") <> '' THEN
                    VendLedgEntry.SETRANGE("Initial Entry Global Dim. 2", Vendor.GETFILTER("Global Dimension 2 Filter"));
                IF Vendor.GETFILTER("Currency Filter") <> '' THEN
                    VendLedgEntry.SETRANGE("Currency Code", Vendor.GETFILTER("Currency Filter"));
                VendLedgEntry.SETRANGE("Posting Date", 0D, PreviousEndDate);
                VendLedgEntry.SETFILTER("Entry Type", '<>%1', VendLedgEntry."Entry Type"::Application);
                // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                // BC Upgrade BHARDA11 >> ----Drink-IT Cistomization
                // Vendor.COPYFILTER("Contract Group Filter", "Contract Group Code");
                // Vendor.COPYFILTER("DIT Sub-Contract Type Filter", "DIT Sub-Contract Type");
                // Vendor.COPYFILTER("Service Contract No. Filter", "Service Contract No.");
                // Vendor.COPYFILTER("Item Charge Type Filter", "Item Charge Type");
                // // >>DITW16.00.00.42 DDR DIT-715 #370
                // //<<DITW17.10.03 MSF 28/03/2014 DIT-715 #340
                // Vendor.COPYFILTER("Vendor Posting Group Filter", "Vendor Posting Group");
                // BC Upgrade BHARDA11 << ----Drink-IT Cistomization
                //>>DITW17.10.03 MSF 28/03/2014 DIT-715 #340
                IF VendLedgEntry.FIND('-') THEN
                    REPEAT
                        PreviousDebitAmountLCY += VendLedgEntry."Debit Amount (LCY)";
                        PreviousCreditAmountLCY += VendLedgEntry."Credit Amount (LCY)";
                    UNTIL VendLedgEntry.NEXT = 0;
                VendLedgEntry.SETRANGE("Posting Date", StartDate, EndDate);
                IF VendLedgEntry.FIND('-') THEN
                    REPEAT
                        PeriodDebitAmountLCY += VendLedgEntry."Debit Amount (LCY)";
                        PeriodCreditAmountLCY += VendLedgEntry."Credit Amount (LCY)";
                    UNTIL VendLedgEntry.NEXT = 0;
                IF NOT PrintVendWithoutBalance AND (PeriodDebitAmountLCY = 0) AND (PeriodCreditAmountLCY = 0) THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem();
            var
                HenekenBcUpg: Codeunit "Heineken BC Upgrade"; // BC Upgrade BHARAD11 ::Added
            begin
                IF GETFILTER("Date Filter") = '' THEN
                    ERROR(Text001, FIELDCAPTION("Date Filter"));
                IF COPYSTR(GETFILTER("Date Filter"), 1, 1) = '.' THEN
                    ERROR(Text002);
                StartDate := GETRANGEMIN("Date Filter");
                PreviousEndDate := CLOSINGDATE(StartDate - 1);
                FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := CONVERTSTR(TextDate, '.', ',');
                // FiltreDateCalc.VerifiyDateFilter(TextDate); // BC Upgrade BHARDA11 ::Blocked
                HenekenBcUpg.VerifiyDateFilter(TextDate); // BC Upgrade BHARDA11 ::Added
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                IF COPYSTR(GETFILTER("Date Filter"), STRLEN(GETFILTER("Date Filter")), 1) = '.' THEN
                    EndDate := 0D
                ELSE
                    EndDate := GETRANGEMAX("Date Filter");
                CurrReport.CREATETOTALS(PreviousDebitAmountLCY, PreviousCreditAmountLCY, PeriodDebitAmountLCY, PeriodCreditAmountLCY);
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
                    field(PrintVendorsWithoutBalance; PrintVendWithoutBalance)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Print Vendors without Balance',
                                    FRA = 'Imprimer fournisseurs sans solde';
                        MultiLine = true;
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
        VendorpostinggroupLBL = 'Vendor posting group';
    }

    trigger OnPreReport();
    begin
        Filter := Vendor.GETFILTERS;
    end;

    var
        Text001: TextConst ENU = 'You must fill in the %1 field.', FRA = 'Vous devez renseigner le champ %1.';
        Text002: TextConst ENU = 'You must specify a Starting Date.', FRA = 'Vous devez spécifier une date de début.';
        Text003: TextConst ENU = 'Printed by %1', FRA = 'Imprimé par %1';
        Text004: TextConst ENU = 'Fiscal Year Start Date : %1', FRA = 'Début exercice comptable : %1';
        Text005: TextConst ENU = 'Page %1', FRA = 'Page %1';
        FiltreDateCalc: Codeunit 358;
        StartDate: Date;
        EndDate: Date;
        PreviousStartDate: Date;
        PreviousEndDate: Date;
        TextDate: Text[30];
        PrintVendWithoutBalance: Boolean;
        "Filter": Text[250];
        VendLedgEntry: Record 380;
        PreviousDebitAmountLCY: Decimal;
        PreviousCreditAmountLCY: Decimal;
        PeriodDebitAmountLCY: Decimal;
        PeriodCreditAmountLCY: Decimal;
        Vendor_Trial_BalanceCaptionLbl: TextConst ENU = 'Vendor Trial Balance', FRA = 'Balance fournisseurs';
        No_CaptionLbl: TextConst ENU = 'No.', FRA = 'N°';
        NameCaptionLbl: TextConst ENU = 'Name', FRA = 'Nom';
        Balance_at_Starting_DateCaptionLbl: TextConst ENU = 'Balance at Starting Date', FRA = 'Solde à la date de début';
        Balance_Date_RangeCaptionLbl: TextConst ENU = 'Balance Date Range', FRA = 'Solde plage de dates';
        Balance_at_Ending_dateCaptionLbl: TextConst ENU = 'Balance at Ending date', FRA = 'Solde à la date de fin';
        DebitCaptionLbl: TextConst ENU = 'Debit', FRA = 'Débit';
        CreditCaptionLbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        DebitCaption_Control1120030Lbl: TextConst ENU = 'Debit', FRA = 'Débit';
        CreditCaption_Control1120032Lbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        DebitCaption_Control1120034Lbl: TextConst ENU = 'Debit', FRA = 'Débit';
        CreditCaption_Control1120036Lbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        Grand_totalCaptionLbl: TextConst ENU = 'Grand total', FRA = 'Total général';
}

