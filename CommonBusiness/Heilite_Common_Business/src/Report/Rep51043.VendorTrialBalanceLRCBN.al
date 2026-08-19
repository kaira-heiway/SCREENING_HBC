report 51043 "Vendor Trial Balance LR CBN"
{
    // version NAVFR7.10,DITW17.10.03,IBM 1001,HEI.01

    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields "Item Charge Type Filter","Service contract no. filter"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 28/03/2014 DIT-715 #340 Added Filter "Vendor Posting Group"
    // HNK100040 MRA 14/07/15: New report based on the standard French localization report 10807
    // FDD-HNK 100128 NaikH01 12/02/2016 : Changed the report Layout , Grouped by "Vendor Posting Group"
    // FDD-HNK 100128 IKH 15/03/2016: pb in the total
    // 
    // HEI.01 FDD-HT520 IBM.GUNERE01 26.08.2019
    //   # Report imported from HeiLite 2.0

    //Bc Upgrade YADAVM09 Drink it code commented.
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Vendor Trial Balance LR.rdl';

    CaptionML = ENU = 'Vendor Trial Balance FR',
                FRA = 'Balance fournisseurs FR';
    ApplicationArea = All;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.");
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
            column(STRSUBSTNO_Text005_CurrReport_PAGENO_; STRSUBSTNO(Text005, CurrReport.PAGENO()))
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
                if Vendor.GETFILTER("Global Dimension 1 Filter") <> '' then
                    VendLedgEntry.SETRANGE("Initial Entry Global Dim. 1", Vendor.GETFILTER("Global Dimension 1 Filter"));
                if Vendor.GETFILTER("Global Dimension 2 Filter") <> '' then
                    VendLedgEntry.SETRANGE("Initial Entry Global Dim. 2", Vendor.GETFILTER("Global Dimension 2 Filter"));
                if Vendor.GETFILTER("Currency Filter") <> '' then
                    VendLedgEntry.SETRANGE("Currency Code", Vendor.GETFILTER("Currency Filter"));
                VendLedgEntry.SETRANGE("Posting Date", 0D, PreviousEndDate);
                VendLedgEntry.SETFILTER("Entry Type", '<>%1', VendLedgEntry."Entry Type"::Application);
                /* // Bc Upgrade YADAVM09 Drink it field commented>>
                // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                Vendor.COPYFILTER("Contract Group Filter","Contract Group Code");
                Vendor.COPYFILTER("DIT Sub-Contract Type Filter","DIT Sub-Contract Type");
                Vendor.COPYFILTER("Service Contract No. Filter","Service Contract No.");
                Vendor.COPYFILTER("Item Charge Type Filter","Item Charge Type");
                // >>DITW16.00.00.42 DDR DIT-715 #370
                //<<DITW17.10.03 MSF 28/03/2014 DIT-715 #340
                Vendor.COPYFILTER("Vendor Posting Group Filter","Vendor Posting Group");
                //>>DITW17.10.03 MSF 28/03/2014 DIT-715 #340
                */
                // Bc Upgrade YADAVM09 Drink it field commented<<
                if VendLedgEntry.FIND('-') then
                    repeat
                        PreviousDebitAmountLCY += VendLedgEntry."Debit Amount (LCY)";
                        PreviousCreditAmountLCY += VendLedgEntry."Credit Amount (LCY)";
                    until VendLedgEntry.NEXT() = 0;
                VendLedgEntry.SETRANGE("Posting Date", StartDate, EndDate);
                if VendLedgEntry.FIND('-') then
                    repeat
                        PeriodDebitAmountLCY += VendLedgEntry."Debit Amount (LCY)";
                        PeriodCreditAmountLCY += VendLedgEntry."Credit Amount (LCY)";
                    until VendLedgEntry.NEXT() = 0;
                if not PrintVendWithoutBalance and (PeriodDebitAmountLCY = 0) and (PeriodCreditAmountLCY = 0) then
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
                // FiltreDateCalc.VerifiyDateFilter(TextDate);  // BC Upgrade YADAV09 - Blocked
                HeinekenBCUpgrade.VerifiyDateFilter(TextDate);  // BC Upgrade YADAV09 - Added
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                if COPYSTR(GETFILTER("Date Filter"), STRLEN(GETFILTER("Date Filter")), 1) = '.' then
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
                    field(PrintVendorsWithoutBalance; PrintVendWithoutBalance)
                    {
                        CaptionML = ENU = 'Print Vendors without Balance',
                                    FRA = 'Imprimer fournisseurs sans solde';
                        MultiLine = true;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the PrintVendWithoutBalance field.';
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
        VendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        FiltreDateCalc: Codeunit "DateFilter-Calc";
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";  // BC Upgrade YADAV09
        PrintVendWithoutBalance: Boolean;
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
        Vendor_Trial_BalanceCaptionLbl: TextConst ENU = 'Vendor Trial Balance', FRA = 'Balance fournisseurs';
}

