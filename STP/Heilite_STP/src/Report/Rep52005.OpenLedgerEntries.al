report 52005 "Open Ledger Entries"
{
    // version NAVW110.0.00.15601,DITW110.00.09,HEI.01

    // DITW15.00.00.37 DDR 01/06/2010 issue 857 Added "DIT Sub-Contract type Filter","Contract Group Code Filter" to filter the entries
    // DITW16.00.00.37 CEL 20/08/2010 DIT-715 #1 RTC Report/Page functionnalities & Nav SQL performances
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields "Item Charge Type Filter","Service contract no. filter"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 AT 22/01/2014 DIT-770 #163 : Setting a Vendor Posting Group Filter does not influence the result
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID is 50006.
    // 2. Add ApplicationArea in Report and requestpage fields.
    // 3. Remove Drink-IT Fields and related code("Vendor Posting Group Filter").
    // 4. Remove Drink-IT Related Customization.
    // 5. Add layout path and Change extension RDLC to RDL.
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Open Ledger Entries.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.

    Caption = 'Aged Accounts Payable';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            // RequestFilterFields = "No.", "Vendor Posting Group Filter"; // BC Upgrade BHARDA11 ----Drink-IT Field("Vendor Posting Group Filter")
            RequestFilterFields = "No.";
            column(CompanyName; COMPANYNAME)
            {
            }
            column(NewPagePerVendor; NewPagePerVendor)
            {
            }
            column(AgesAsOfEndingDate; STRSUBSTNO(Text006, FORMAT(EndingDate, 0, 4)))
            {
            }
            column(SelectAgeByDuePostngDocDt; STRSUBSTNO(Text007, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(CaptionVendorFilter; TABLECAPTION + ': ' + VendorFilter)
            {
            }
            column(VendorFilter; VendorFilter)
            {
            }
            column(AgingBy; AgingBy)
            {
            }
            column(SelctAgeByDuePostngDocDt1; STRSUBSTNO(Text004, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(HeaderText5; HeaderText[5])
            {
            }
            column(HeaderText4; HeaderText[4])
            {
            }
            column(HeaderText3; HeaderText[3])
            {
            }
            column(HeaderText2; HeaderText[2])
            {
            }
            column(HeaderText1; HeaderText[1])
            {
            }
            column(PrintDetails; PrintDetails)
            {
            }
            column(GrandTotalVLE5RemAmtLCY; GrandTotalVLERemaingAmtLCY[5])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE4RemAmtLCY; GrandTotalVLERemaingAmtLCY[4])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE3RemAmtLCY; GrandTotalVLERemaingAmtLCY[3])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE2RemAmtLCY; GrandTotalVLERemaingAmtLCY[2])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE1RemAmtLCY; GrandTotalVLERemaingAmtLCY[1])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE1AmtLCY; GrandTotalVLEAmtLCY)
            {
                AutoFormatType = 1;
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(No_Vendor; "No.")
            {
            }
            column(AgedAcctPayableCaption; AgedAcctPayableCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(AllAmtsinLCYCaption; AllAmtsinLCYCaptionLbl)
            {
            }
            column(AgedOverdueAmsCaption; AgedOverdueAmsCaptionLbl)
            {
            }
            column(GrandTotalVLE5RemAmtLCYCaption; GrandTotalVLE5RemAmtLCYCaptionLbl)
            {
            }
            column(AmountLCYCaption; AmountLCYCaptionLbl)
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(DocumentNoCaption; DocumentNoCaptionLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(DocumentTypeCaption; DocumentTypeCaptionLbl)
            {
            }
            column(VendorNoCaption; FIELDCAPTION("No."))
            {
            }
            column(VendorNameCaption; FIELDCAPTION(Name))
            {
            }
            column(CurrencyCaption; CurrencyCaptionLbl)
            {
            }
            column(TotalLCYCaption; TotalLCYCaptionLbl)
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                // DataItemLink = "Vendor No." = FIELD("No."), "Vendor Posting Group" = FIELD("Vendor Posting Group Filter"); // BC Upgrade BHARDA11 ----Drink-IT Field("Vendor Posting Group Filter")
                DataItemLink = "Vendor No." = FIELD("No.");//, "Vendor Posting Group" = FIELD("Vendor Posting Group Filter");
                DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code");
                PrintOnlyIfDetail = true;

                trigger OnAfterGetRecord();
                var
                    VendorLedgEntry: Record "Vendor Ledger Entry";
                begin
                    VendorLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                    VendorLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                    VendorLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    // //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                    // Vendor.COPYFILTER("Vendor Posting Group Filter", VendorLedgEntry."Vendor Posting Group"); // BC Upgrade BHARDA11 ----Drink-IT Field("Vendor Posting Group Filter")
                    // //>>DITW17.00.02 AT DIT-770 #163
                    if VendorLedgEntry.FINDSET(false) then
                        repeat
                            InsertTemp(VendorLedgEntry);
                        until VendorLedgEntry.NEXT = 0;

                    if "Closed by Entry No." <> 0 then begin
                        VendorLedgEntry.SETRANGE("Closed by Entry No.", "Closed by Entry No.");
                        if VendorLedgEntry.FINDSET(false) then
                            repeat
                                InsertTemp(VendorLedgEntry);
                            until VendorLedgEntry.NEXT = 0;
                    end;

                    VendorLedgEntry.RESET;
                    VendorLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                    VendorLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                    // Vendor.COPYFILTER("Vendor Posting Group Filter", VendorLedgEntry."Vendor Posting Group"); // BC Upgrade BHARDA11 ----Drink-IT Field("Vendor Posting Group Filter")
                    //>>DITW17.00.02 AT DIT-770 #163
                    if VendorLedgEntry.FINDSET(false) then
                        repeat
                            InsertTemp(VendorLedgEntry);
                        until VendorLedgEntry.NEXT = 0;
                    CurrReport.SKIP;
                end;

                trigger OnPreDataItem();
                begin
                    // BC Upgrade BHARDA11 >>----Drink-IT Customization Code
                    // // <<DITW15.00.00.37 DDR 01/06/2010
                    // Vendor.COPYFILTER("DIT Sub-Contract Type Filter", "DIT Sub-Contract Type");
                    // Vendor.COPYFILTER("Contract Group Filter", "Contract Group Code");
                    // // >>DITW15.00.00.37 DDR
                    // // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                    // Vendor.COPYFILTER("Service Contract No. Filter", "Service Contract No.");
                    // Vendor.COPYFILTER("Item Charge Type Filter", "Item Charge Type");
                    // // >>DITW16.00.00.42 DDR DIT-715 #370
                    // //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                    // Vendor.COPYFILTER("Vendor Posting Group Filter", "Vendor Posting Group");
                    // //>>DITW17.00.02 AT DIT-770 #163
                    // BC Upgrade BHARDA11 <<----Drink-IT Customization Code
                    SETRANGE("Posting Date", EndingDate + 1, DMY2DATE(31, 12, 9999));
                end;
            }
            dataitem(OpenVendorLedgEntry; "Vendor Ledger Entry")
            {
                // DataItemLink = "Vendor No." = FIELD("No."), "Vendor Posting Group" = FIELD("Vendor Posting Group Filter"); // BC Upgrade BHARDA11 >> ----Drink-IT Field("Vendor Posting Group Filter")
                DataItemLink = "Vendor No." = FIELD("No.");//, "Vendor Posting Group" = FIELD("Vendor Posting Group Filter");
                DataItemTableView = SORTING("Vendor No.", Open, Positive, "Due Date", "Currency Code");
                PrintOnlyIfDetail = true;

                trigger OnAfterGetRecord();
                begin
                    if AgingBy = AgingBy::"Posting Date" then begin
                        CALCFIELDS("Remaining Amt. (LCY)");
                        if "Remaining Amt. (LCY)" = 0 then
                            CurrReport.SKIP;
                    end;
                    InsertTemp(OpenVendorLedgEntry);
                    CurrReport.SKIP;
                end;

                trigger OnPreDataItem();
                begin
                    if AgingBy = AgingBy::"Posting Date" then begin
                        SETRANGE("Posting Date", 0D, EndingDate);
                        SETRANGE("Date Filter", 0D, EndingDate);
                    end;
                    // BC Upgrade BHARDA11 >> ----Drink-IT Customization Code
                    // // <<DITW15.00.00.37 DDR 01/06/2010
                    // Vendor.COPYFILTER("DIT Sub-Contract Type Filter", "DIT Sub-Contract Type");
                    // Vendor.COPYFILTER("Contract Group Filter", "Contract Group Code");
                    // // >>DITW15.00.00.37 DDR
                    // // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                    // Vendor.COPYFILTER("Service Contract No. Filter", "Service Contract No.");
                    // Vendor.COPYFILTER("Item Charge Type Filter", "Item Charge Type");
                    // // >>DITW16.00.00.42 DDR DIT-715 #370
                    // //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                    // Vendor.COPYFILTER("Vendor Posting Group Filter", "Vendor Posting Group");
                    // //>>DITW17.00.02 AT DIT-770 #163
                    // BC Upgrade BHARDA11 << ----Drink-IT Customization Code
                end;
            }
            dataitem(CurrencyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                PrintOnlyIfDetail = true;
                dataitem(TempVendortLedgEntryLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                    column(VendorName; Vendor.Name)
                    {
                    }
                    column(VendorNo; Vendor."No.")
                    {
                    }
                    column(VLEEndingDateRemAmtLCY; VendorLedgEntryEndingDate."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVLE1RemAmtLCY; AgedVendorLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt2RemAmtLCY; AgedVendorLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt3RemAmtLCY; AgedVendorLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt4RemAmtLCY; AgedVendorLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt5RemAmtLCY; AgedVendorLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(VendLedgEntryEndDtAmtLCY; VendorLedgEntryEndingDate."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(VendLedgEntryEndDtDueDate; FORMAT(VendorLedgEntryEndingDate."Due Date"))
                    {
                    }
                    column(VendLedgEntryEndDtDocNo; VendorLedgEntryEndingDate."Document No.")
                    {
                    }
                    column(VendLedgEntyEndgDtDocType; FORMAT(VendorLedgEntryEndingDate."Document Type"))
                    {
                    }
                    column(VendLedgEntryEndDtPostgDt; FORMAT(VendorLedgEntryEndingDate."Posting Date"))
                    {
                    }
                    column(AgedVendLedgEnt5RemAmt; AgedVendorLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt4RemAmt; AgedVendorLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt3RemAmt; AgedVendorLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt2RemAmt; AgedVendorLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt1RemAmt; AgedVendorLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(VLEEndingDateRemAmt; VendorLedgEntryEndingDate."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(VendLedgEntryEndingDtAmt; VendorLedgEntryEndingDate.Amount)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(TotalVendorName; STRSUBSTNO(Text005, Vendor.Name))
                    {
                    }
                    column(CurrCode_TempVenLedgEntryLoop; CurrencyCode)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord();
                    var
                        PeriodIndex: Integer;
                    begin
                        if Number = 1 then begin
                            if not TempVendorLedgEntry.FINDSET(false) then
                                CurrReport.BREAK;
                        end else
                            if TempVendorLedgEntry.NEXT = 0 then
                                CurrReport.BREAK;

                        VendorLedgEntryEndingDate := TempVendorLedgEntry;
                        DetailedVendorLedgerEntry.SETRANGE("Vendor Ledger Entry No.", VendorLedgEntryEndingDate."Entry No.");
                        if DetailedVendorLedgerEntry.FINDSET(false) then
                            repeat
                                if (DetailedVendorLedgerEntry."Entry Type" =
                                    DetailedVendorLedgerEntry."Entry Type"::"Initial Entry") and
                                   (VendorLedgEntryEndingDate."Posting Date" > EndingDate) and
                                   (AgingBy <> AgingBy::"Posting Date")
                                then begin
                                    if VendorLedgEntryEndingDate."Document Date" <= EndingDate then
                                        DetailedVendorLedgerEntry."Posting Date" :=
                                          VendorLedgEntryEndingDate."Document Date"
                                    else
                                        if (VendorLedgEntryEndingDate."Due Date" <= EndingDate) and
                                           (AgingBy = AgingBy::"Due Date")
                                        then
                                            DetailedVendorLedgerEntry."Posting Date" :=
                                              VendorLedgEntryEndingDate."Due Date"
                                end;

                                if (DetailedVendorLedgerEntry."Posting Date" <= EndingDate) or
                                   (TempVendorLedgEntry.Open and
                                    (AgingBy = AgingBy::"Due Date") and
                                    (VendorLedgEntryEndingDate."Due Date" > EndingDate) and
                                    (VendorLedgEntryEndingDate."Posting Date" <= EndingDate))
                                then begin
                                    if DetailedVendorLedgerEntry."Entry Type" in
                                       [DetailedVendorLedgerEntry."Entry Type"::"Initial Entry",
                                        DetailedVendorLedgerEntry."Entry Type"::"Unrealized Loss",
                                        DetailedVendorLedgerEntry."Entry Type"::"Unrealized Gain",
                                        DetailedVendorLedgerEntry."Entry Type"::"Realized Loss",
                                        DetailedVendorLedgerEntry."Entry Type"::"Realized Gain",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount (VAT Excl.)",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Tolerance",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount Tolerance",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Tolerance (VAT Excl.)",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Tolerance (VAT Adjustment)",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)"]
                                    then begin
                                        VendorLedgEntryEndingDate.Amount := VendorLedgEntryEndingDate.Amount + DetailedVendorLedgerEntry.Amount;
                                        VendorLedgEntryEndingDate."Amount (LCY)" :=
                                          VendorLedgEntryEndingDate."Amount (LCY)" + DetailedVendorLedgerEntry."Amount (LCY)";
                                    end;
                                    if DetailedVendorLedgerEntry."Posting Date" <= EndingDate then begin
                                        VendorLedgEntryEndingDate."Remaining Amount" :=
                                          VendorLedgEntryEndingDate."Remaining Amount" + DetailedVendorLedgerEntry.Amount;
                                        VendorLedgEntryEndingDate."Remaining Amt. (LCY)" :=
                                          VendorLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedVendorLedgerEntry."Amount (LCY)";
                                    end;
                                end;
                            until DetailedVendorLedgerEntry.NEXT = 0;

                        if VendorLedgEntryEndingDate."Remaining Amount" = 0 then
                            CurrReport.SKIP;

                        case AgingBy of
                            AgingBy::"Due Date":
                                PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Due Date");
                            AgingBy::"Posting Date":
                                PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Posting Date");
                            AgingBy::"Document Date":
                                begin
                                    if VendorLedgEntryEndingDate."Document Date" > EndingDate then begin
                                        VendorLedgEntryEndingDate."Remaining Amount" := 0;
                                        VendorLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
                                        VendorLedgEntryEndingDate."Document Date" := VendorLedgEntryEndingDate."Posting Date";
                                    end;
                                    PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Document Date");
                                end;
                        end;
                        CLEAR(AgedVendorLedgEntry);
                        AgedVendorLedgEntry[PeriodIndex]."Remaining Amount" := VendorLedgEntryEndingDate."Remaining Amount";
                        AgedVendorLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalVendorLedgEntry[PeriodIndex]."Remaining Amount" += VendorLedgEntryEndingDate."Remaining Amount";
                        TotalVendorLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalVLERemaingAmtLCY[PeriodIndex] += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalVendorLedgEntry[1].Amount += VendorLedgEntryEndingDate."Remaining Amount";
                        TotalVendorLedgEntry[1]."Amount (LCY)" += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalVLEAmtLCY += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                    end;

                    trigger OnPostDataItem();
                    begin
                        if not PrintAmountInLCY then
                            UpdateCurrencyTotals;
                    end;

                    trigger OnPreDataItem();
                    begin
                        if not PrintAmountInLCY then
                            TempVendorLedgEntry.SETRANGE("Currency Code", TempCurrency.Code);
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(TotalVendorLedgEntry);

                    if Number = 1 then begin
                        if not TempCurrency.FINDSET(false) then
                            CurrReport.BREAK;
                    end else
                        if TempCurrency.NEXT = 0 then
                            CurrReport.BREAK;

                    if TempCurrency.Code <> '' then
                        CurrencyCode := TempCurrency.Code
                    else
                        CurrencyCode := GLSetup."LCY Code";

                    NumberOfCurrencies := NumberOfCurrencies + 1;
                end;

                trigger OnPostDataItem();
                begin
                    if NewPagePerVendor and (NumberOfCurrencies > 0) then
                        CurrReport.NEWPAGE;
                end;

                trigger OnPreDataItem();
                begin
                    NumberOfCurrencies := 0;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                if NewPagePerVendor then
                    PageGroupNo := PageGroupNo + 1;

                TempCurrency.RESET;
                TempCurrency.DELETEALL;
                TempVendorLedgEntry.RESET;
                TempVendorLedgEntry.DELETEALL;
                CLEAR(GrandTotalVLERemaingAmtLCY);
                GrandTotalVLEAmtLCY := 0;
            end;

            trigger OnPreDataItem();
            begin
                PageGroupNo := 1;
            end;
        }
        dataitem(CurrencyTotals; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
            column(Number_CurrencyTotals; Number)
            {
            }
            column(NewPagePerVend_CurrTotal; NewPagePerVendor)
            {
            }
            column(TempCurrency2Code; TempCurrency2.Code)
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt6RemAmtLCY5; AgedVendorLedgEntry[6]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt1RemAmtLCY1; AgedVendorLedgEntry[1]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt2RemAmtLCY2; AgedVendorLedgEntry[2]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt3RemAmtLCY3; AgedVendorLedgEntry[3]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt4RemAmtLCY4; AgedVendorLedgEntry[4]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt5RemAmtLCY5; AgedVendorLedgEntry[5]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(CurrencySpecificationCaption; CurrencySpecificationCaptionLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                if Number = 1 then begin
                    if not TempCurrency2.FINDSET(false) then
                        CurrReport.BREAK;
                end else
                    if TempCurrency2.NEXT = 0 then
                        CurrReport.BREAK;

                CLEAR(AgedVendorLedgEntry);
                TempCurrencyAmount.SETRANGE("Currency Code", TempCurrency2.Code);
                if TempCurrencyAmount.FINDSET(false) then
                    repeat
                        if TempCurrencyAmount.Date <> DMY2DATE(31, 12, 9999) then
                            AgedVendorLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
                              TempCurrencyAmount.Amount
                        else
                            AgedVendorLedgEntry[6]."Remaining Amount" := TempCurrencyAmount.Amount;
                    until TempCurrencyAmount.NEXT = 0;
            end;

            trigger OnPreDataItem();
            begin
                PageGroupNo := 0;
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
                    field(AgedAsOf; EndingDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged As Of';
                        ToolTip = 'Specifies the date that you want the aging calculated for.';
                    }
                    field(AgingBy; AgingBy)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aging by';
                        OptionCaption = 'Due Date,Posting Date,Document Date';
                        ToolTip = 'Specifies if the aging will be calculated from the due date, the posting date, or the document date.';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period Length';
                        ToolTip = 'Specifies the length of each period, for example, enter "1M" for one month.';
                    }
                    field(PrintAmountInLCY; PrintAmountInLCY)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Amounts in LCY';
                        ToolTip = 'Specifies if you want the report to specify the aging per vendor ledger entry.';
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Details';
                        ToolTip = 'Specifies if you want the report to show the detailed entries that add up the total balance for each vendor.';
                    }
                    field(HeadingType; HeadingType)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Heading Type';
                        OptionCaption = 'Date Interval,Number of Days';
                        ToolTip = 'Specifies if the column heading for the three periods will indicate a date interval or the number of days overdue.';
                    }
                    field(NewPagePerVendor; NewPagePerVendor)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per Vendor';
                        ToolTip = 'Specifies if each vendor''s information is printed on a new page if you have chosen two or more vendors to be included in the report.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            if EndingDate = 0D then
                EndingDate := WORKDATE;
        end;
    }

    labels
    {
    }

    trigger OnPreReport();
    var
    // CaptionManagement: Codeunit CaptionManagement; // BC Upgrade BHARDA11 ----MIssing in Business central.
    begin
        // VendorFilter := CaptionManagement.GetRecordFiltersWithCaptions(Vendor); // BC Upgrade BHARDA11 ::Blocked
        VendorFilter := GetRecordFiltersWithCaptions(Vendor); // BC Upgrade BHARDA11 :: Added

        GLSetup.GET;

        CalcDates;
        CreateHeadings;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        TempVendorLedgEntry: Record "Vendor Ledger Entry" temporary;
        VendorLedgEntryEndingDate: Record "Vendor Ledger Entry";
        TotalVendorLedgEntry: array[5] of Record "Vendor Ledger Entry";
        AgedVendorLedgEntry: array[6] of Record "Vendor Ledger Entry";
        TempCurrency: Record Currency temporary;
        TempCurrency2: Record Currency temporary;
        TempCurrencyAmount: Record "Currency Amount" temporary;
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        GrandTotalVLERemaingAmtLCY: array[5] of Decimal;
        GrandTotalVLEAmtLCY: Decimal;
        VendorFilter: Text;
        PrintAmountInLCY: Boolean;
        EndingDate: Date;
        AgingBy: Option "Due Date","Posting Date","Document Date";
        PeriodLength: DateFormula;
        PrintDetails: Boolean;
        HeadingType: Option "Date Interval","Number of Days";
        NewPagePerVendor: Boolean;
        PeriodStartDate: array[5] of Date;
        PeriodEndDate: array[5] of Date;
        HeaderText: array[5] of Text[30];
        Text000: Label 'Not Due';
        Text001: Label 'Before';
        CurrencyCode: Code[10];
        Text002: Label 'days';
        Text003: Label 'More than';
        Text004: Label 'Aged by %1';
        Text005: Label 'Total for %1';
        Text006: Label 'Aged as of %1';
        Text007: Label 'Aged by %1';
        NumberOfCurrencies: Integer;
        Text009: Label 'Due Date,Posting Date,Document Date';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it, for example, by using 1M+CM instead of CM+1M.';
        PageGroupNo: Integer;
        EnterDateFormulaErr: Label 'Enter a date formula in the Period Length field.';
        Text027: Label '-%1', Comment = 'Negating the period length: %1 is the period length';
        AgedAcctPayableCaptionLbl: Label 'Aged Accounts Payable';
        CurrReportPageNoCaptionLbl: Label 'Page';
        AllAmtsinLCYCaptionLbl: Label 'All Amounts in LCY';
        AgedOverdueAmsCaptionLbl: Label 'Aged Overdue Amounts';
        GrandTotalVLE5RemAmtLCYCaptionLbl: Label 'Balance';
        AmountLCYCaptionLbl: Label 'Original Amount';
        DueDateCaptionLbl: Label 'Due Date';
        DocumentNoCaptionLbl: Label 'Document No.';
        PostingDateCaptionLbl: Label 'Posting Date';
        DocumentTypeCaptionLbl: Label 'Document Type';
        CurrencyCaptionLbl: Label 'Currency Code';
        TotalLCYCaptionLbl: Label 'Total (LCY)';
        CurrencySpecificationCaptionLbl: Label 'Currency Specification';
    // BC Upgrade BHARDA11 >> ---This function was created because the CaptionManagement codeunit is not available in Business Central. So, the same work that the function inside that codeunit was doing will now be handled by this function.
    local procedure GetRecordFiltersWithCaptions(RecVariant: Variant): Text
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
        Filters: Text;
        FieldFilter: Text;
        Name: Text;
        Cap: Text;
        Pos: Integer;
        i: Integer;
    begin
        RecRef.GETTABLE(RecVariant);
        Filters := RecRef.GETFILTERS;
        if Filters = '' then
            exit;

        for i := 1 to RecRef.FIELDCOUNT do begin
            FieldRef := RecRef.FIELDINDEX(i);
            FieldFilter := FieldRef.GETFILTER;
            if FieldFilter <> '' then begin
                Name := STRSUBSTNO('%1: ', FieldRef.NAME);
                Cap := STRSUBSTNO('%1: ', FieldRef.CAPTION);
                Pos := STRPOS(Filters, Name);
                if Pos <> 0 then
                    Filters := INSSTR(DELSTR(Filters, Pos, STRLEN(Name)), Cap, Pos);
            end;
        end;

        exit(Filters);
    end;
    // BC Upgrade BHARDA11 << ----This function was created because the CaptionManagement codeunit is not available in Business Central. So, the same work that the function inside that codeunit was doing will now be handled by this function.
    local procedure CalcDates();
    var
        i: Integer;
        PeriodLength2: DateFormula;
    begin
        if not EVALUATE(PeriodLength2, STRSUBSTNO(Text027, PeriodLength)) then
            ERROR(EnterDateFormulaErr);
        if AgingBy = AgingBy::"Due Date" then begin
            PeriodEndDate[1] := DMY2DATE(31, 12, 9999);
            PeriodStartDate[1] := EndingDate + 1;
        end else begin
            PeriodEndDate[1] := EndingDate;
            PeriodStartDate[1] := CALCDATE(PeriodLength2, EndingDate + 1);
        end;
        for i := 2 to ARRAYLEN(PeriodEndDate) do begin
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CALCDATE(PeriodLength2, PeriodEndDate[i] + 1);
        end;

        i := ARRAYLEN(PeriodEndDate);

        PeriodStartDate[i] := 0D;

        for i := 1 to ARRAYLEN(PeriodEndDate) do
            if PeriodEndDate[i] < PeriodStartDate[i] then
                ERROR(Text010, PeriodLength);
    end;

    local procedure CreateHeadings();
    var
        i: Integer;
    begin
        if AgingBy = AgingBy::"Due Date" then begin
            HeaderText[1] := Text000;
            i := 2;
        end else
            i := 1;
        while i < ARRAYLEN(PeriodEndDate) do begin
            if HeadingType = HeadingType::"Date Interval" then
                HeaderText[i] := STRSUBSTNO('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
            else
                HeaderText[i] :=
                  STRSUBSTNO('%1 - %2 %3', EndingDate - PeriodEndDate[i] + 1, EndingDate - PeriodStartDate[i] + 1, Text002);
            i := i + 1;
        end;
        if HeadingType = HeadingType::"Date Interval" then
            HeaderText[i] := STRSUBSTNO('%1\%2', Text001, PeriodStartDate[i - 1])
        else
            HeaderText[i] := STRSUBSTNO('%1\%2 %3', Text003, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
    end;

    local procedure InsertTemp(var VendorLedgEntry: Record "Vendor Ledger Entry");
    var
        Currency: Record Currency;
    begin
        if TempVendorLedgEntry.GET(VendorLedgEntry."Entry No.") then
            exit;
        TempVendorLedgEntry := VendorLedgEntry;
        TempVendorLedgEntry.INSERT;
        if PrintAmountInLCY then begin
            CLEAR(TempCurrency);
            TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            if TempCurrency.INSERT then;
            exit;
        end;
        if TempCurrency.GET(TempVendorLedgEntry."Currency Code") then
            exit;
        if TempVendorLedgEntry."Currency Code" <> '' then
            Currency.GET(TempVendorLedgEntry."Currency Code")
        else begin
            CLEAR(Currency);
            Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
        end;
        TempCurrency := Currency;
        TempCurrency.INSERT;
    end;

    local procedure GetPeriodIndex(Date: Date): Integer;
    var
        i: Integer;
    begin
        for i := 1 to ARRAYLEN(PeriodEndDate) do
            if Date in [PeriodStartDate[i] .. PeriodEndDate[i]] then
                exit(i);
    end;

    local procedure UpdateCurrencyTotals();
    var
        i: Integer;
    begin
        TempCurrency2.Code := CurrencyCode;
        if TempCurrency2.INSERT then;
        for i := 1 to ARRAYLEN(TotalVendorLedgEntry) do begin
            TempCurrencyAmount."Currency Code" := CurrencyCode;
            TempCurrencyAmount.Date := PeriodStartDate[i];
            if TempCurrencyAmount.FIND then begin
                TempCurrencyAmount.Amount := TempCurrencyAmount.Amount + TotalVendorLedgEntry[i]."Remaining Amount";
                TempCurrencyAmount.MODIFY;
            end else begin
                TempCurrencyAmount."Currency Code" := CurrencyCode;
                TempCurrencyAmount.Date := PeriodStartDate[i];
                TempCurrencyAmount.Amount := TotalVendorLedgEntry[i]."Remaining Amount";
                TempCurrencyAmount.INSERT;
            end;
        end;
        TempCurrencyAmount."Currency Code" := CurrencyCode;
        TempCurrencyAmount.Date := DMY2DATE(31, 12, 9999);
        if TempCurrencyAmount.FIND then begin
            TempCurrencyAmount.Amount := TempCurrencyAmount.Amount + TotalVendorLedgEntry[1].Amount;
            TempCurrencyAmount.MODIFY;
        end else begin
            TempCurrencyAmount."Currency Code" := CurrencyCode;
            TempCurrencyAmount.Date := DMY2DATE(31, 12, 9999);
            TempCurrencyAmount.Amount := TotalVendorLedgEntry[1].Amount;
            TempCurrencyAmount.INSERT;
        end;
    end;

    procedure InitializeRequest(NewEndingDate: Date; NewAgingBy: Option; NewPeriodLength: DateFormula; NewPrintAmountInLCY: Boolean; NewPrintDetails: Boolean; NewHeadingType: Option; NewNewPagePerVendor: Boolean);
    begin
        EndingDate := NewEndingDate;
        AgingBy := NewAgingBy;
        PeriodLength := NewPeriodLength;
        PrintAmountInLCY := NewPrintAmountInLCY;
        PrintDetails := NewPrintDetails;
        HeadingType := NewHeadingType;
        NewPagePerVendor := NewNewPagePerVendor;
    end;
}

