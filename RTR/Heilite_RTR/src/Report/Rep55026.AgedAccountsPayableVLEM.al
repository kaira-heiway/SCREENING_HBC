report 55026 "Aged Accounts Payable VLEM"
{
    // version HEI.02 IBM

    // DITW15.00.00.37 DDR 01/06/2010 issue 857 Added "DIT Sub-Contract type Filter","Contract Group Code Filter" to filter the entries
    // DITW16.00.00.37 CEL 20/08/2010 DIT-715 #1 RTC Report/Page functionnalities & Nav SQL performances
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields "Item Charge Type Filter","Service contract no. filter"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 AT 22/01/2014 DIT-770 #163 : Setting a Vendor Posting Group Filter does not influence the result
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // 
    // HEI.01 Defect 721 , IBM.NAIKH01 15.12.2017
    //   # Added New Fields Document Sub Type, Sensitive Block,Currency in the Report.
    //   # Added New Options - "Show Header" and "Open Entries" on the Request Page.
    //   # Added "Payment Status","Debit Amount" on the ReqFilterField of VLE.
    // 
    // HEI.02 Defect #1517, IBM.POSTOI01, 20.02.2018
    //   # Added new global variable DocumentType , option type
    //   # Added new variable on Request window
    //   # Added new code in TempVendortLedgEntryLoop
    // HEI.03 HT607 IBM NASTAA02 29.07.2019 # Translation of Reports
    //   # Added french captions

    // BC Upgrade KUMARR78>>
    // 1. Added Business Central report discoverability properties.
    //    Old: Report was missing BC mandatory properties for search/visibility.
    //    New:
    //      - ApplicationArea = All;
    //      - UsageCategory = ReportsAndAnalysis;
    //
    // 2. Blocked DIT-specific fields and filters which are not available in BC standard tables.
    //    Reason: DIT customization fields do not exist in BC base application.
    //    Changes:
    //      - Vendor dataitem:
    //          Old: RequestFilterFields = "No.", "Vendor Posting Group Filter";
    //          New: RequestFilterFields = "No.";
    //      - Vendor Ledger Entry dataitems:
    //          Old: DataItemLink included "Vendor Posting Group Filter" and COPYFILTER usage for DIT fields.
    //          New: DataItemLink set only on "Vendor No." and removed COPYFILTER calls for non-existing DIT fields.
    //      - Blocked additional DIT filters in OnPreDataItem triggers:
    //          * "DIT Sub-Contract Type Filter"
    //          * "Contract Group Filter"
    //          * "Service Contract No. Filter"
    //          * "Item Charge Type Filter"
    //          * "Vendor Posting Group Filter"
    //
    // 3. Replaced NAV dependency on Codeunit "Caption Management" (removed in BC).
    //    Old NAV logic:
    //      CaptionManagement: Codeunit "Caption Management";
    //      VendorFilter := CaptionManagement.GetRecordFiltersWithCaptions(Vendor);
    //    Issue:
    //      - Codeunit "Caption Management" does not exist in Business Central.
    //      - Function GetRecordFiltersWithCaptions() is not available in BC standard.
    //    New BC logic:
    //      VendorFilter := GetRecordFiltersWithCaptions(Vendor);
    //
    // 4. Implemented custom GetRecordFiltersWithCaptions() to preserve report header filter output.
    //    Reason:
    //      - Report prints VendorFilter in header (TABLECAPTION + ': ' + VendorFilter).
    //      - Required to keep same functional output after upgrade.
    //    New Addition:
    //      local procedure GetRecordFiltersWithCaptions(var Vendor: Record Vendor): Text
    //      Implementation details:
    //      - Uses RecordRef.GetTable(Vendor) to access runtime filters.
    //      - Iterates through fields using RecRef.FieldCount and FieldIndex(i).
    //      - Reads applied filter text using FieldRef.GetFilter().
    //      - Builds readable filter string format: "<Field Caption>: <Filter>" separated by comma.
    //      - Uses FieldRef.Caption when LanguageCode is blank.
    //      - If translation is needed, supports translated captions via:
    //          TranslationHelper.GetTranslatedFieldCaption(LanguageCode, TableID, FieldId)
    //
    // 5. Ensured report behavior remains consistent post upgrade.
    //    - VendorFilter variable continues to be populated and displayed.
    //    - Core logic (CalcDates, CreateHeadings, InsertTemp, aging calculations) remains unchanged.
    //    - No impact on report dataset output other than removal of unsupported DIT filter fields.
    // 6. Old Report ID- 50017
    // BC Upgrade KUMARR78<<


    DefaultLayout = RDLC;
    ApplicationArea = All; // BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade KUMARR78 Adding Usagecategory
    RDLCLayout = '.\src\ReportsLayout\Aged Accounts Payable VLEM.rdl';
    CaptionML = ENU = 'Aged Accounts Payable VLEM',
                FRA = 'Comptabilité Fournisseur âgée VLEM';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;

            // RequestFilterFields = "No.", "Vendor Posting Group Filter"; // BC Upgrade KUMARR78 Blocking DIT Field
            RequestFilterFields = "No."; // BC Upgrade KUMARR78 Changing Expression as Field DIT Field Were being Used
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
            column(ShowHeader; ShowHeader)
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
            column(VLENumberlbl2; VLENumberlbl2)
            {
            }
            column(DocumentDatelbl1; DocumentDatelbl1)
            {
            }
            column(PostingDescriptionlbl1; PostingDescriptionlbl1)
            {
            }
            column(PaymentMethodlbl1; PaymentMethodlbl1)
            {
            }
            column(vendorblocklbl1; vendorblocklbl1)
            {
            }
            column(externaldocumentnumberlbl1; externaldocumentnumberlbl1)
            {
            }
            column(OriginalAmtLYClbl1; OriginalAmtLYClbl1)
            {
            }
            dataitem("<Vendor Ledger Entry>"; "Vendor Ledger Entry")
            {
                // DataItemLink = "Vendor No." = FIELD("No."), "Vendor Posting Group" = FIELD("Vendor Posting Group Filter"); // BC Upgrade KUMARR78 Blocking DIT Field
                DataItemLink = "Vendor No." = FIELD("No."); // BC Upgrade KUMARR78 Adding As DIT Field were used.
                DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code");
                PrintOnlyIfDetail = true;

                trigger OnAfterGetRecord();
                var
                    VendorLedgEntry: Record "Vendor Ledger Entry";
                begin
                    VendorLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                    VendorLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                    VendorLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);

                    //HEI.01
                    if OpenEntries then
                        VendorLedgEntry.SETRANGE(Open, true);

                    //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                    // Vendor.COPYFILTER("Vendor Posting Group Filter", VendorLedgEntry."Vendor Posting Group"); // BC Upgrade KUMARR78 Blocking DIT Field
                    //>>DITW17.00.02 AT DIT-770 #163
                    if VendorLedgEntry.FINDSET() then
                        repeat
                            InsertTemp(VendorLedgEntry);
                        until VendorLedgEntry.NEXT() = 0;

                    if "Closed by Entry No." <> 0 then begin
                        VendorLedgEntry.SETRANGE("Closed by Entry No.", "Closed by Entry No.");
                        //HEI.01
                        if OpenEntries then
                            VendorLedgEntry.SETRANGE(Open, true);

                        if VendorLedgEntry.FINDSET() then
                            repeat
                                InsertTemp(VendorLedgEntry);
                            until VendorLedgEntry.NEXT() = 0;
                    end;

                    VendorLedgEntry.RESET();
                    VendorLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                    VendorLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    //HEI.01
                    if OpenEntries then
                        VendorLedgEntry.SETRANGE(Open, true);

                    //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                    // Vendor.COPYFILTER("Vendor Posting Group Filter", VendorLedgEntry."Vendor Posting Group"); // BC Upgrade KUMARR78 Blocking DIT Field
                    //>>DITW17.00.02 AT DIT-770 #163
                    if VendorLedgEntry.FINDSET() then
                        repeat
                            InsertTemp(VendorLedgEntry);
                        until VendorLedgEntry.NEXT() = 0;
                    CurrReport.SKIP();
                end;

                trigger OnPreDataItem();
                begin
                    // <<DITW15.00.00.37 DDR 01/06/2010
                    // Vendor.COPYFILTER("DIT Sub-Contract Type Filter", "DIT Sub-Contract Type"); // BC Upgrade KUMARR78 Blocking DIT Field
                    // Vendor.COPYFILTER("Contract Group Filter", "Contract Group Code"); // BC Upgrade KUMARR78 Blocking DIT Field
                    // >>DITW15.00.00.37 DDR
                    // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                    // Vendor.COPYFILTER("Service Contract No. Filter", "Service Contract No."); // BC Upgrade KUMARR78 Blocking DIT Field
                    // Vendor.COPYFILTER("Item Charge Type Filter", "Item Charge Type"); // BC Upgrade KUMARR78 Blocking DIT Field
                    // >>DITW16.00.00.42 DDR DIT-715 #370
                    //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                    // Vendor.COPYFILTER("Vendor Posting Group Filter", "Vendor Posting Group"); // BC Upgrade KUMARR78 Blocking DIT Field
                    //>>DITW17.00.02 AT DIT-770 #163

                    SETRANGE("Posting Date", EndingDate + 1, DMY2DATE(31, 12, 9999));
                end;
            }
            dataitem(OpenVendorLedgEntry; "Vendor Ledger Entry")
            {
                // DataItemLink = "Vendor No." = FIELD("No."), "Vendor Posting Group" = FIELD("Vendor Posting Group Filter");// BC Upgrade KUMARR78 Blocking DIT Field
                DataItemLink = "Vendor No." = FIELD("No."); // BC Upgrade KUMARR78 Adding As DIT Were being Used.
                DataItemTableView = SORTING("Vendor No.", Open, Positive, "Due Date", "Currency Code");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Vendor Posting Group", Amount, "Due Date", "Payment Status FND", "Debit Amount", Open;

                trigger OnAfterGetRecord();
                begin
                    if AgingBy = AgingBy::"Posting Date" then begin
                        CALCFIELDS("Remaining Amt. (LCY)");
                        if "Remaining Amt. (LCY)" = 0 then
                            CurrReport.SKIP();
                    end;
                    InsertTemp(OpenVendorLedgEntry);
                    CurrReport.SKIP();
                end;

                trigger OnPreDataItem();
                begin
                    if AgingBy = AgingBy::"Posting Date" then begin
                        SETRANGE("Posting Date", 0D, EndingDate);
                        SETRANGE("Date Filter", 0D, EndingDate);
                    end;

                    // <<DITW15.00.00.37 DDR 01/06/2010
                    // Vendor.COPYFILTER("DIT Sub-Contract Type Filter", "DIT Sub-Contract Type");// BC Upgrade KUMARR78 Blocking DIT Field
                    // Vendor.COPYFILTER("Contract Group Filter", "Contract Group Code");// BC Upgrade KUMARR78 Blocking DIT Field
                    // >>DITW15.00.00.37 DDR
                    // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                    // Vendor.COPYFILTER("Service Contract No. Filter", "Service Contract No.");// BC Upgrade KUMARR78 Blocking DIT Field
                    // Vendor.COPYFILTER("Item Charge Type Filter", "Item Charge Type");// BC Upgrade KUMARR78 Blocking DIT Field
                    // >>DITW16.00.00.42 DDR DIT-715 #370
                    //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                    // Vendor.COPYFILTER("Vendor Posting Group Filter", "Vendor Posting Group");// BC Upgrade KUMARR78 Blocking DIT Field
                    //>>DITW17.00.02 AT DIT-770 #163
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
                    column(VendorBlocked; Vendor.Blocked)
                    {
                        AutoFormatType = 1;
                    }
                    column(VendorSensitiveBlock; FORMAT(Vendor."Sensitive Payment Block FND"))
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
                    column(VendorLedgEntryEndingDate_No; VendorLedgEntryEndingDate."Entry No.")
                    {
                    }
                    column(VendorLedgEntryEndingDate_PostingDate; VendorLedgEntryEndingDate."Posting Date")
                    {
                    }
                    column(VendorLedgEntryEndingDate_DocDate; VendorLedgEntryEndingDate."Document Date")
                    {
                    }
                    column(VendorLedgEntryEndingDate_OriginalAmt; VendorLedgEntryEndingDate."Original Amount")
                    {
                    }
                    column(VendorLedgEntryEndingDate_OriginalAmtLYC; VendorLedgEntryEndingDate."Original Amt. (LCY)")
                    {
                    }
                    column(VendorLedgEntryEndingDate_Desc; VendorLedgEntryEndingDate.Description)
                    {
                    }
                    column(VendorLedgEntryEndingDate_PMC; VendorLedgEntryEndingDate."Payment Method Code")
                    {
                    }
                    column(VendorLedgEntryEndingDate_EDNo; VendorLedgEntryEndingDate."External Document No.")
                    {
                    }
                    column(VendorLedgEntryEndingDate_Paymentstatus; PaymentStatus2)
                    {
                    }
                    column(VendorLedgEntryEndingDate_ReasonCode; VendorLedgEntryEndingDate."Reason Code")
                    {
                    }
                    column(VendorLedgEntryEndingDate_CurrCode; VendorLedgEntryEndingDate."Currency Code")
                    {
                    }
                    // BC Upgrade SHUKLP03
                    column(VendorLedgEntryEndingDate_DocSubType; VendorLedgEntryEndingDate."Document Subtype Code FND")// BC Upgrade SHUKLP03
                    {
                    }
                    column(VendorLedgEntryEndingDate_Open; FORMAT(VendorLedgEntryEndingDate.Open))
                    {
                    }

                    trigger OnAfterGetRecord();
                    var
                        PeriodIndex: Integer;
                    begin
                        if Number = 1 then begin
                            if not TempVendorLedgEntry.FINDSET() then
                                CurrReport.BREAK();
                        end else
                            if TempVendorLedgEntry.NEXT() = 0 then
                                CurrReport.BREAK();

                        VendorLedgEntryEndingDate := TempVendorLedgEntry;
                        //HEI.03>>
                        if GLOBALLANGUAGE = 1036 then begin
                            PaymentStatus := VendorLedgEntryEndingDate."Payment Status FND";
                            PaymentStatus2 := FORMAT(PaymentStatus);
                        end else
                            PaymentStatus2 := FORMAT(VendorLedgEntryEndingDate."Payment Status FND");
                        //HEI.03<<
                        DetailedVendorLedgerEntry.SETRANGE("Vendor Ledger Entry No.", VendorLedgEntryEndingDate."Entry No.");
                        if DetailedVendorLedgerEntry.FINDSET() then
                            repeat
                                if (DetailedVendorLedgerEntry."Entry Type" =
                                    DetailedVendorLedgerEntry."Entry Type"::"Initial Entry") and
                                   (VendorLedgEntryEndingDate."Posting Date" > EndingDate) and
                                   (AgingBy <> AgingBy::"Posting Date")
                                then //begin //Bc Upgrade YADAVM09 Warning Resolution<<
                                    if VendorLedgEntryEndingDate."Document Date" <= EndingDate then
                                        DetailedVendorLedgerEntry."Posting Date" :=
                                          VendorLedgEntryEndingDate."Document Date"
                                    else
                                        if (VendorLedgEntryEndingDate."Due Date" <= EndingDate) and
                                           (AgingBy = AgingBy::"Due Date")
                                        then
                                            DetailedVendorLedgerEntry."Posting Date" :=
                                              VendorLedgEntryEndingDate."Due Date";
                                //end;//Bc Upgrade YADAVM09 Warning Resolution<<

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
                            until DetailedVendorLedgerEntry.NEXT() = 0;

                        if VendorLedgEntryEndingDate."Remaining Amount" = 0 then
                            CurrReport.SKIP();

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

                        //NAIKH01
                        VendorLedgEntryEndingDate.CALCFIELDS("Original Amount");
                        VendorLedgEntryEndingDate.CALCFIELDS("Original Amt. (LCY)");
                    end;

                    trigger OnPostDataItem();
                    begin
                        if not PrintAmountInLCY then
                            UpdateCurrencyTotals();
                    end;

                    trigger OnPreDataItem();
                    begin
                        if not PrintAmountInLCY then
                            TempVendorLedgEntry.SETRANGE("Currency Code", TempCurrency.Code);

                        //HEI.01
                        if OpenEntries then
                            TempVendorLedgEntry.SETRANGE(Open, true);

                        //HEI.02
                        if DocumentType <> DocumentType::All then
                            TempVendorLedgEntry.SETRANGE("Document Type", DocumentType - 1);
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(TotalVendorLedgEntry);

                    if Number = 1 then begin
                        if not TempCurrency.FINDSET() then
                            CurrReport.BREAK();
                    end else
                        if TempCurrency.NEXT() = 0 then
                            CurrReport.BREAK();

                    if TempCurrency.Code <> '' then
                        CurrencyCode := TempCurrency.Code
                    else
                        CurrencyCode := GLSetup."LCY Code";

                    NumberOfCurrencies := NumberOfCurrencies + 1;
                end;

                trigger OnPostDataItem();
                begin
                    if NewPagePerVendor and (NumberOfCurrencies > 0) then
                        CurrReport.NEWPAGE();
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

                TempCurrency.RESET();
                TempCurrency.DELETEALL();
                TempVendorLedgEntry.RESET();
                TempVendorLedgEntry.DELETEALL();
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
                    if not TempCurrency2.FINDSET() then
                        CurrReport.BREAK();
                end else
                    if TempCurrency2.NEXT() = 0 then
                        CurrReport.BREAK();

                CLEAR(AgedVendorLedgEntry);
                TempCurrencyAmount.SETRANGE("Currency Code", TempCurrency2.Code);
                if TempCurrencyAmount.FINDSET() then
                    repeat
                        if TempCurrencyAmount.Date <> DMY2DATE(31, 12, 9999) then
                            AgedVendorLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
                              TempCurrencyAmount.Amount
                        else
                            AgedVendorLedgEntry[6]."Remaining Amount" := TempCurrencyAmount.Amount;
                    until TempCurrencyAmount.NEXT() = 0;
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
                        CaptionML = ENU = 'Aged As Of',
                                    FRA = 'Âgée en Date du';
                        ToolTip = 'Specifies the date that you want the aging calculated for.';
                    }
                    field(AgingBy; AgingBy)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Aging by',
                                    FRA = 'Âgée par';
                        OptionCaptionML = ENU = 'Due Date,Posting Date,Document Date',
                                          FRA = 'Date d''échéance,Date comptabilisation,Date document';
                        ToolTip = 'Specifies if the aging will be calculated from the due date, the posting date, or the document date.';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Period Length',
                                    FRA = 'Base Période';
                        ToolTip = 'Specifies the length of each period, for example, enter "1M" for one month.';
                    }
                    field(PrintAmountInLCY; PrintAmountInLCY)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Print Amounts in LCY',
                                    FRA = 'Imprimer montants DS';
                        ToolTip = 'Specifies if you want the report to specify the aging per vendor ledger entry.';
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Print Details',
                                    FRA = 'Imprimer détails';
                        ToolTip = 'Specifies if you want the report to show the detailed entries that add up the total balance for each vendor.';
                    }
                    field(HeadingType; HeadingType)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Heading Type',
                                    FRA = 'Type titre';
                        OptionCaptionML = ENU = 'Date Interval,Number of Days',
                                          FRA = 'Intervalle de dates,Nombre de jours';
                        ToolTip = 'Specifies if the column heading for the three periods will indicate a date interval or the number of days overdue.';
                    }
                    field(NewPagePerVendor; NewPagePerVendor)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'New Page per Vendor',
                                    FRA = 'Nouvelle page par Fournisseur';
                        ToolTip = 'Specifies if each vendor''s information is printed on a new page if you have chosen two or more vendors to be included in the report.';
                    }
                    field(ShowHeader; ShowHeader)
                    {
                        ApplicationArea = all; // BC Upgrade KUMARR78
                        CaptionML = ENU = 'Show Header',
                                    FRA = 'Afficher en-tête';
                        ToolTip = 'Select showheader if you want to see header';
                    }
                    field(OpenEntries; OpenEntries)
                    {
                        ApplicationArea = all; // BC Upgrade KUMARR78
                        CaptionML = ENU = 'Open Entries',
                                    FRA = 'Écritures ouvertes';
                        ToolTip = 'Select open entries';
                    }
                    field(DocumentType; DocumentType)
                    {
                        ApplicationArea = all; // BC Upgrade KUMARR78
                        CaptionML = ENU = 'Document Type',
                                    FRA = 'Type de Document';
                        OptionCaptionML = ENU = 'All,'' '',Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment',
                                          FRA = 'Tous,'' '',Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêt,Réception achat,Interest Rate Credit,RPM Dégâts ou perte,FFE Paiement sécurité';
                        ToolTip = 'Select Document type';
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
                EndingDate := WORKDATE();
        end;
    }

    labels
    {
        label(DocumentDatelbl; ENU = 'Document Date',
                              FRA = 'Date du Document')
        label(PostingDescriptionlbl; ENU = 'Posting Description',
                                    FRA = 'Désignation')
        label(PaymentMethodlbl; ENU = 'Payment Method',
                               FRA = 'Mode de Paiement')
        label(vendorblocklbl; ENU = 'Vendor blocked',
                             FRA = 'Fournisseur bloqué')
        label(OriginalAmtLYClbl; ENU = 'Original AmountLYC',
                                FRA = 'Montant Initial DS')
        label(PaymentStatuslbl; ENU = 'Payment Status',
                               FRA = 'Statut de Paiement')
        label(ReasonCodelbl; ENU = 'Reason Code',
                            FRA = 'Code de raison')
        label(DocSubtypeCodeLbl; ENU = 'Doc Subtype',
                                FRA = 'Sous-type de doc')
        label(OriginalAmountLbl; ENU = 'Original Amount',
                                FRA = 'Montant Initial')
        label(RemainingAmountLbl; ENU = 'Remaining Amount',
                                 FRA = 'Montant Ouvert')
        label(RemainingAmountLCYLbl; ENU = 'Remaining Amount LCY',
                                    FRA = 'Montant Ouvert DS')
        label(AmountLbl; ENU = 'Amount',
                        FRA = 'Montant')
        label(AmountLCYLbl; ENU = 'Amount LCY',
                           FRA = 'Montant DS')
        label(BalanceLbl; ENU = 'Balance',
                         FRA = 'Solde')
        label(CurrencyCodeLbl; ENU = 'Currency Code',
                              FRA = 'Code de Devise')
        label(SensitiveBlockLbl; ENU = 'Sensitive Block',
                                FRA = 'Factures bloquées')
    }

    trigger OnInitReport();
    begin
        //<<HEI.01
        ShowHeader := true;
        //>>HEI.01
    end;

    trigger OnPreReport();
    var
    //CaptionManagement: Codeunit "Caption Management"; //BC Upgrade KUMARR78 Blocking As Codeunit Removed.
    begin
        // VendorFilter := CaptionManagement.GetRecordFiltersWithCaptions(Vendor);//BC Upgrade KUMARR78 Blocking As Codeunit Removed.
        VendorFilter := GetRecordFiltersWithCaptions(Vendor); //BC Upgrade KUMARR78 Adding for Filter with Caption as Codeunit was removed.

        GLSetup.GET();

        CalcDates();
        CreateHeadings();
    end;

    var
        TempCurrency: Record Currency temporary;
        TempCurrency2: Record Currency temporary;
        TempCurrencyAmount: Record "Currency Amount" temporary;
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        GLSetup: Record "General Ledger Setup";
        AgedVendorLedgEntry: array[6] of Record "Vendor Ledger Entry";
        TempVendorLedgEntry: Record "Vendor Ledger Entry" temporary;
        TotalVendorLedgEntry: array[5] of Record "Vendor Ledger Entry";
        VendorLedgEntryEndingDate: Record "Vendor Ledger Entry";
        PeriodLength: DateFormula;
        NewPagePerVendor: Boolean;
        OpenEntries: Boolean;
        PrintAmountInLCY: Boolean;
        PrintDetails: Boolean;
        ShowHeader: Boolean;
        CurrencyCode: Code[10];
        EndingDate: Date;
        PeriodEndDate: array[5] of Date;
        PeriodStartDate: array[5] of Date;
        GrandTotalVLEAmtLCY: Decimal;
        GrandTotalVLERemaingAmtLCY: array[5] of Decimal;
        NumberOfCurrencies: Integer;
        PageGroupNo: Integer;
        CurrencySpecificationCaptionLbl: Label 'Currency Specification';
        Text005: Label 'Total for %1';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it, for example, by using 1M+CM instead of CM+1M.';
        Text027: Label '-%1', Comment = 'Negating the period length: %1 is the period length';
        DocumentType: Option All,"' '",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,"Bank Reverse","Bank Charge","Loan Pay Out","Loan Pay Back","Purchase Receipt","Interest Rate Credit","RPM Damage or Loss","FFE Security Payment";
        HeadingType: Option "Date Interval","Number of Days";
        AgingBy: Option "Due Date","Posting Date","Document Date";
        PaymentStatus: Option "En attente","Paiement approuvé","Paiement rejeté";
        PaymentStatus2: Text;
        VendorFilter: Text;
        HeaderText: array[5] of Text[30];
        AgedAcctPayableCaptionLbl: TextConst ENU = 'Aged Accounts Payable', FRA = 'Comptabilité Fournisseur âgée ';
        AgedOverdueAmsCaptionLbl: TextConst ENU = 'Aged Overdue Amounts', FRA = 'Montant échus âgés';
        AllAmtsinLCYCaptionLbl: TextConst ENU = 'All Amounts in LCY', FRA = 'Tous les montants DS';
        AmountLCYCaptionLbl: TextConst ENU = 'Original Amount', FRA = 'Montant Initial';
        CurrencyCaptionLbl: TextConst ENU = 'Currency Code', FRA = 'Code de Devise';
        CurrReportPageNoCaptionLbl: TextConst ENU = 'Page', FRA = 'Page';
        DocumentDatelbl1: TextConst ENU = 'Document Date', FRA = 'Date du Document';
        DocumentNoCaptionLbl: TextConst ENU = 'Document No.', FRA = 'Numéro de Document';
        DocumentTypeCaptionLbl: TextConst ENU = 'Document Type', FRA = 'Type de Document';
        DueDateCaptionLbl: TextConst ENU = 'Due Date', FRA = 'Date d''écheance';
        EnterDateFormulaErr: TextConst ENU = 'Enter a date formula in the Period Length field.', FRA = 'Saisir une formule de date dans le champ Base période.';
        externaldocumentnumberlbl1: TextConst ENU = 'External Doc No', FRA = 'Numéro de Document Externe';
        GrandTotalVLE5RemAmtLCYCaptionLbl: TextConst ENU = 'Balance', FRA = 'Solde';
        OriginalAmtLYClbl1: TextConst ENU = 'Original Amount LCY', FRA = 'Montant Initial DS';
        PaymentMethodlbl1: TextConst ENU = 'Payment Method', FRA = 'Mode de Paiement';
        PostingDateCaptionLbl: TextConst ENU = 'Posting Date', FRA = 'Date Comptabilisation';
        PostingDescriptionlbl1: TextConst ENU = 'Posting Description', FRA = 'Désignation';
        Text000: TextConst ENU = 'Not Due', FRA = 'Non echues';
        Text001: TextConst ENU = 'Before', FRA = 'Avant';
        Text002: TextConst ENU = 'days', FRA = 'jours';
        Text003: TextConst ENU = 'More than', FRA = 'Plus que';
        Text004: TextConst ENU = 'Aged by %1', FRA = 'Âgée par %1';
        Text006: TextConst ENU = 'Aged as of %1', FRA = 'Âgée en date du %1';
        Text007: TextConst ENU = 'Aged by %1', FRA = 'Âgée par %1';
        Text009: TextConst ENU = 'Due Date,Posting Date,Document Date', FRA = 'Date d''écheance,Date Comptabilisation,Date du Document';
        TotalLCYCaptionLbl: TextConst ENU = 'Total (LCY)', FRA = 'Total DS';
        vendorblocklbl1: TextConst ENU = 'Vendor Blocked', FRA = 'Fournisseur bloqué';
        VLENumberlbl2: TextConst ENU = 'Vendor Ledg Entry No.', FRA = 'Écritures comptables fournisseur';

    local procedure CalcDates();
    var
        PeriodLength2: DateFormula;
        i: Integer;
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
        TempVendorLedgEntry.INSERT();
        if PrintAmountInLCY then begin
            CLEAR(TempCurrency);
            TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            if TempCurrency.INSERT() then;
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
        TempCurrency.INSERT();
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
        if TempCurrency2.INSERT() then;
        for i := 1 to ARRAYLEN(TotalVendorLedgEntry) do begin
            TempCurrencyAmount."Currency Code" := CurrencyCode;
            TempCurrencyAmount.Date := PeriodStartDate[i];
            if TempCurrencyAmount.FIND() then begin
                TempCurrencyAmount.Amount := TempCurrencyAmount.Amount + TotalVendorLedgEntry[i]."Remaining Amount";
                TempCurrencyAmount.MODIFY();
            end else begin
                TempCurrencyAmount."Currency Code" := CurrencyCode;
                TempCurrencyAmount.Date := PeriodStartDate[i];
                TempCurrencyAmount.Amount := TotalVendorLedgEntry[i]."Remaining Amount";
                TempCurrencyAmount.INSERT();
            end;
        end;
        TempCurrencyAmount."Currency Code" := CurrencyCode;
        TempCurrencyAmount.Date := DMY2DATE(31, 12, 9999);
        if TempCurrencyAmount.FIND() then begin
            TempCurrencyAmount.Amount := TempCurrencyAmount.Amount + TotalVendorLedgEntry[1].Amount;
            TempCurrencyAmount.MODIFY();
        end else begin
            TempCurrencyAmount."Currency Code" := CurrencyCode;
            TempCurrencyAmount.Date := DMY2DATE(31, 12, 9999);
            TempCurrencyAmount.Amount := TotalVendorLedgEntry[1].Amount;
            TempCurrencyAmount.INSERT();
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

    //BC Upgrade KUMARR78 Creating Function >>
    local procedure GetRecordFiltersWithCaptions(var Vendor: Record Vendor): Text
    var
        TranslationHelper: Codeunit "Translation Helper";
        RecRef: RecordRef;
        FldRef: FieldRef;
        FilterTxt: Text;
        ResultTxt: Text;
        i: Integer;
        CaptionTxt: Text;
        LangCode: Code[10];
    begin
        // You can keep blank to use current language, or hardcode 'ENU'
        LangCode := '';

        RecRef.GetTable(Vendor);

        // Loop through all fields and build filter string for fields that have filter applied
        for i := 1 to RecRef.FieldCount do begin
            FldRef := RecRef.FieldIndex(i);
            FilterTxt := FldRef.GetFilter();

            if FilterTxt <> '' then begin
                // Translate caption if possible
                if LangCode <> '' then
                    CaptionTxt := TranslationHelper.GetTranslatedFieldCaption(LangCode, RecRef.Number, FldRef.Number)
                else
                    CaptionTxt := FldRef.Caption;

                if ResultTxt <> '' then
                    ResultTxt += ', ';

                ResultTxt += StrSubstNo('%1: %2', CaptionTxt, FilterTxt);
            end;
        end;

        exit(ResultTxt);
    end;
    //BC Upgrade KUMARR78 Creating Function <<

}

