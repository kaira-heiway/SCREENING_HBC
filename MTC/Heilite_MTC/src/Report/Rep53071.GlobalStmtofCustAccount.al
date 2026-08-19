report 53071 "Global Stmt. of Cust Account"
{
    // version HEI.01

    // HEI.01 CHG2056933 IBM.KUMARN15 08.05.2020
    //   # New report developed
    // HEI.02 CHG2056933 Defect #5589 IBM GAVANM01 01.09.2020
    //   #code and layout changes as per the defect requests
    // HEI.03 HT1843 - CHG2096439 IBM NASTAA02 08.02.2021 # SL - Customer Statement of Account
    //   # Copied Report 50450 and added new requirements
    //   # Aging for Current/Future should include the 'EndDate' as first date when calculating the amounts, not TODAY
    //   # When Report Type is 'Statement' then the Currency totals should be displayed
    // HEI.04 HT2041 IBM NASTAA02 01.04.2021 # Customer Statement of Account Haiti
    //   # Copied Report 50467 - Customer Stmt. of Account SL and added new requirements
    // HEI.05 CHG2123536 HB2489 IBM MAJUMS03 23.09.2021 Update Global Statement.
    //   # Copied Report 50475 - Customer Stmt. of Account HT and enhanced the report by adding new requirement.
    // HEI.06 CHG2136952 HB2677 IBM BHANDS01 01.12.2021 Update Global Statement.
    //   # Enhanced the report by adding new requirement.
    // BC Upgrade BHARDA11 >>
    // 1. OLD Report ID - 50504.\
    // 2. Add Layout Path and change layout extension RDLC to RDL.
    // 3. Comment the Code related with codeunit 50085 because This (SendEMailwithAttachment) codeunit was marked on hold by Manisha after discussion with Saikat.
    // 4. REmove Drink-IT Field and related code("Tax Registration No.","Cust. Ledger Entry"."Item Charge Type")
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Global Stmt. of Cust Account.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.

    CaptionML = ENU = 'Customer Statement of Account',
                FRA = 'Client – relevé de compte';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(Address_Customer; Customer.Address)
            {
            }
            column(Address2_Customer; Customer."Address 2")
            {
            }
            column(PostCode_Customer; Customer."Post Code")
            {
            }
            column(City_Customer; Customer.City)
            {
            }
            column(CompanyText; CompanyText)
            {
            }
            column(VATRegistrationNo_Customer; Customer."VAT Registration No.")
            {
            }
            column(Country_Customer; CustCountry)
            {
            }
            column(CompanyInfo_OpCoFooter; CompanyInfo."OpCo Footer image FND")
            {
            }
            column(Name_CompanyInfo; CompanyInfo.Name)
            {
            }
            column(Address_CompanyInfo; CompanyInfo.Address)
            {
            }
            column(Address2_CompanyInfo; CompanyInfo."Address 2")
            {
            }
            column(City_CompanyInfo; CompanyInfo.City)
            {
            }
            column(PostCode_CompanyInfo; CompanyInfo."Post Code")
            {
            }
            column(Picture_CompanyInfo; CompanyInfo.Picture)
            {
            }
            column(Country_CompanyInfo; CompCountry)
            {
            }
            column(StatementDate; EndDate)
            {
            }
            column(CustomerStatementCap; CustomerStatementLbl)
            {
            }
            column(CompNameCap; CompNameLbl)
            {
            }
            column(CompAddressCap; CompAddressLbl)
            {
            }
            column(CompPostCodeCap; CompPostCodeLbl)
            {
            }
            column(CompCityCap; CompCityLbl)
            {
            }
            column(CompPayCap; CompCountryLbl)
            {
            }
            column(ClientCap; ClientLbl)
            {
            }
            column(ClientNameCap; ClientNameLbl)
            {
            }
            column(ClientNoCap; ClientNoLbl)
            {
            }
            column(ClientAddressCap; ClientAddressLbl)
            {
            }
            column(ClientPostCodeCap; ClientPostCodeLbl)
            {
            }
            column(ClientCityCap; ClientCityLbl)
            {
            }
            column(ClientPayCap; ClientCountryLbl)
            {
            }
            column(ClientVATRegNoCap; ClientVATRegNoLbl)
            {
            }
            column(CompanyTaxNoCap; CompanyTaxNoLbl)
            {
            }
            column(DateOfDeclCap; DateOfDeclLbl)
            {
            }
            column(PageNoCap; PageNoLbl)
            {
            }
            column(DocCurrSummaryCap; DocCurrSummaryLbl)
            {
            }
            column(AgingSummaryCap; AgingSummaryLbl)
            {
            }
            column(CurrencyCap; CurrencyLbl)
            {
            }
            column(IncludeAgingBand; IncludeAgingBand)
            {
            }
            column(SignatureCap; SignatureLbl)
            {
            }
            column(CompanyTaxNo_Customer; Customer."Tax Registration No. 113FDW") // BC Upgrade SHUKLP03 ----Drink-IT Fields(Customer."Tax Registration No.")
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(PeriodCustDatetFilter; CustDateFilter)
            {
            }
            column(PeriodCaption; Text000)
            {
            }
            column(ReportType; ReportType)
            {
            }
            column(NIF; CustomerAttributes.NIF)
            {
            }
            column(PhoneNo_CompanyInfo; CompanyInfo."Phone No.")
            {
            }
            column(Email_CompanyInfo; CompanyInfo."E-Mail")
            {
            }
            column(CustomerEmail; Customer."E-Mail")
            {
            }
            column(PhoneLbl; PhoneLbl)
            {
            }
            column(EmailLbl; EmailLbl)
            {
            }
            column(NIFLbl; NIFLbl)
            {
            }
            column(FooterTextLbl; FooterText)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.")
                                    ORDER(Descending);
                column(DocumentDate_CustLedgerEntry; FORMAT("Cust. Ledger Entry"."Document Date", 0, '<Day,2>-<Month>-<Year4>'))
                {
                }
                column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(DocumentType_CustLedgerEntry; "Cust. Ledger Entry"."Document Type")
                {
                }
                column(Description_CustLedgerEntry; "Cust. Ledger Entry".Description)
                {
                }
                column(Amount_CustLedgerEntry; "Cust. Ledger Entry".Amount)
                {
                }
                column(CurrencyCode_CustLedgerEntry; "Cust. Ledger Entry"."Currency Code")
                {
                }
                column(DueDate_CustLedgerEntry; FORMAT("Cust. Ledger Entry"."Due Date", 0, '<Day,2>-<Month>-<Year4>'))
                {
                }
                column(DisputeCase_CustLedgerEntry; "Cust. Ledger Entry"."Dispute Case FND")
                {
                }
                column(RemainingAmount_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Amount")
                {
                }
                column(WhseDocNo_CustLedgerEntry; WhseDocNo)
                {
                }
                column(EntryNo_CustLedgerEntry; "Cust. Ledger Entry"."Entry No.")
                {
                }
                column(LineDocumentDateCap; LineDocumentDateLbl)
                {
                }
                column(LineDocumentNoCap; LineDocumentNoLbl)
                {
                }
                column(LineDocTypeCap; LineDocTypeLbl)
                {
                }
                column(LineWhseShpmtNoCap; LineWhseShpmtNoLbl)
                {
                }
                column(LineDescriptionCap; LineDescriptionLbl)
                {
                }
                column(LineAmountCap; LineAmountLbl)
                {
                }
                column(LineCurrencyCap; LineCurrencyLbl)
                {
                }
                column(LineDueDateCap; LineDueDateLbl)
                {
                }
                column(LineDisputedCap; LineDisputedLbl)
                {
                }
                column(LineAmountPaidCap; LineAmountPaidLbl)
                {
                }
                column(LineUnallocatedAmountCap; LineUnallocatedAmountLbl)
                {
                }
                column(LineBalanceDueCap; LineBalanceDueLbl)
                {
                }
                column(isPayment; isPayment)
                {
                }
                column(LineItemChargeTypeCap; LineItemChargeTypeLbl)
                {
                }
                column(ItemChargeType_CustLedgerEntry; "Cust. Ledger Entry"."CM Incl. EG. Lim. Warn APS") // BC Upgrade SHUKLP03 ----Drink-IT Field( "Cust. Ledger Entry"."Item Charge Type")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    IF ("Remaining Amount" = 0)
                      AND OpenEntries THEN  //HEI.02
                        CurrReport.SKIP;

                    NoOfLinesToPrint += 1;

                    IF "Currency Code" = '' THEN
                        "Currency Code" := GLSetup."LCY Code";

                    WhseDocNo := '';
                    CASE "Document Type" OF
                        "Cust. Ledger Entry"."Document Type"::Invoice:
                            BEGIN
                                IF SalesInvoiceHeader.GET("Document No.") THEN BEGIN
                                    WhseDocNo := SalesInvoiceHeader."Whse. Shipment No. FND";
                                END;
                            END;
                        "Cust. Ledger Entry"."Document Type"::"Credit Memo":
                            BEGIN
                                IF SalesCrMemoHeader.GET("Document No.") THEN BEGIN
                                    WhseDocNo := SalesCrMemoHeader."Whse. Shipment No. FND";
                                END;
                            END;
                    END;

                    //IF IncludeAgingBand THEN  //commented by HEI.02
                    //IF ReportType <> ReportType::Statement THEN  //HEI.02 //HEI.03
                    // BC Upgrade SHUKLP03 >> ----Drink-IT Field("Item Charge Type")
                    CASE DateChoice OF
                        //HEI.02>>
                        DateChoice::"Due Date":
                            //>>HEI.05
                            //UpdateBuffer("Currency Code", "Due Date", "Remaining Amount","Dispute Case");
                            //<<HEI.05
                            //>>HEI.05
                            UpdateBuffer("Currency Code", "Due Date", "Remaining Amount", "Dispute Case FND", "Cust. Ledger Entry"."CM Incl. EG. Lim. Warn APS");
                        //<<HEI.05
                        DateChoice::"Document Date":
                            //>>HEI.05
                            //UpdateBuffer("Currency Code", "Document Date", "Remaining Amount","Dispute Case");
                            //<<HEI.05
                            //>>HEI.05
                            UpdateBuffer("Currency Code", "Document Date", "Remaining Amount", "Dispute Case FND", "Cust. Ledger Entry"."CM Incl. EG. Lim. Warn APS");
                        //<<HEI.05
                        DateChoice::"Posting Date":
                            //>>HEI.05
                            //UpdateBuffer("Currency Code", "Posting Date", "Remaining Amount","Dispute Case");
                            //<<HEI.05
                            //>>HEI.05
                            UpdateBuffer("Currency Code", "Posting Date", "Remaining Amount", "Dispute Case FND", "Cust. Ledger Entry"."CM Incl. EG. Lim. Warn APS");
                    //<<HEI.05
                    END;
                    // BC Upgrade SHUKLP03 << ----Drink-IT Field("Item Charge Type")


                    isPayment := FALSE;
                    IF "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::Payment THEN
                        isPayment := TRUE;
                end;

                trigger OnPreDataItem();
                begin
                    /*//commented by HEI.02>>
                    SETRANGE("Posting Date",0D,EndDate);
                    SETRANGE("Date Filter",0D,EndDate);
                    *///commented by HEI.02<<
                    //HEI.02>>
                    SETRANGE("Posting Date", StartDate, EndDate);
                    SETRANGE("Date Filter", StartDate, EndDate);
                    //HEI.02<<

                    //>>HEI.05
                    // BC Upgrade SHUKLP03 >> ----Drink-IT Field("Item Charge Type")
                    IF NewReportType = NewReportType::Full THEN BEGIN
                        "Cust. Ledger Entry".SETFILTER("Cust. Ledger Entry"."CM Incl. EG. Lim. Warn APS", '%1|%2', "Cust. Ledger Entry"."CM Incl. EG. Lim. Warn APS"::" ", "Cust. Ledger Entry"."CM Incl. EG. Lim. Warn APS"::Deposit);
                    END ELSE IF NewReportType = NewReportType::Liquids THEN BEGIN
                        "Cust. Ledger Entry".SETRANGE("Cust. Ledger Entry"."CM Incl. EG. Lim. Warn APS", "Cust. Ledger Entry"."CM Incl. EG. Lim. Warn APS"::" ");
                    END ELSE IF NewReportType = NewReportType::Deposit THEN BEGIN
                        "Cust. Ledger Entry".SETRANGE("Cust. Ledger Entry"."CM Incl. EG. Lim. Warn APS", "Cust. Ledger Entry"."CM Incl. EG. Lim. Warn APS"::Deposit);
                    END;
                    // BC Upgrade SHUKLP03 << ----Drink-IT Field("Item Charge Type")

                    //<<HEI.05

                end;
            }
            dataitem(BlankLines; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    ORDER(Ascending);
                column(Number_BlankLines; BlankLines.Number)
                {
                }

                trigger OnPreDataItem();
                begin
                    IF NoOfLinesToPrint = 0 THEN
                        CurrReport.BREAK;

                    //>>HEI.05
                    //SETRANGE(Number,1,LinesToPrintonOnePage - ((NoOfLinesToPrint + 2 + 4 + (4 * TempAgingBandBuf.COUNT)) MOD LinesToPrintonOnePage));
                    //<<HEI.05
                    //>>HEI.05
                    SETRANGE(Number, 1, LinesToPrintonOnePage - ((NoOfLinesToPrint + 2 + 4 + (5 * TempAgingBandBuf.COUNT)) MOD LinesToPrintonOnePage));
                    //<<HEI.05
                end;
            }
            dataitem(AgingBand; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                column(Number_AgingBand; AgingBand.Number)
                {
                }
                column(Currency_AgingBand; TempAgingBandBuf."Currency Code")
                {
                }
                column(Band1_AgingBand; TempAgingBandBuf."Column 1 Amt.")
                {
                }
                column(Band2_AgingBand; TempAgingBandBuf."Column 2 Amt.")
                {
                }
                column(Band3_AgingBand; TempAgingBandBuf."Column 3 Amt.")
                {
                }
                column(Band4_AgingBand; TempAgingBandBuf."Column 4 Amt.")
                {
                }
                column(Band5_AgingBand; TempAgingBandBuf."Column 5 Amt.")
                {
                }
                column(Disputed_AgingBand; TempAgingBandBuf."Disputed Amt. FND")
                {
                }
                column(AgingCap1_AgingBand; AgingCap[1])
                {
                }
                column(AgingCap2_AgingBand; AgingCap[2])
                {
                }
                column(AgingCap3_AgingBand; AgingCap[3])
                {
                }
                column(AgingCap4_AgingBand; AgingCap[4])
                {
                }
                column(AgingCap5_AgingBand; AgingCap[5])
                {
                }
                column(AgingCap6_AgingBand; AgingCap[6])
                {
                }
                column(AgingTotalCap; AgingTotalLbl)
                {
                }
                column(AgingDisputedCap; AgingDisputedLbl)
                {
                }
                column(AgingBand6_Currency; AgingBand6_Currency)
                {
                }
                column(AgingBand6_Amt; AgingBand6_Amt)
                {
                }
                column(AgingBand6_DisputedAmt; AgingBand6_DisputedAmt)
                {
                }
                column(BandE1_AgingBand; TempAgingBandBuf."Column E1 Amt. FND")
                {
                }
                column(BandE2_AgingBand; TempAgingBandBuf."Column E2 Amt. FND")
                {
                }
                column(BandE3_AgingBand; TempAgingBandBuf."Column E3 Amt. FND")
                {
                }
                column(BandE4_AgingBand; TempAgingBandBuf."Column E4 Amt. FND")
                {
                }
                column(BandE5_AgingBand; TempAgingBandBuf."Column E5 Amt. FND")
                {
                }
                column(DisputedE_AgingBand; TempAgingBandBuf."Disputed EAmt. FND")
                {
                }
                column(AgingBandE6_Currency; AgingBandE6_Currency)
                {
                }
                column(AgingBandE6_Amt; AgingBandE6_Amt)
                {
                }
                column(AgingBandE6_DisputedAmt; AgingBandE6_DisputedAmt)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    //HEI.03>>
                    AgingBand6_Currency := '';
                    AgingBand6_Amt := 0;
                    AgingBand6_DisputedAmt := 0;
                    //HEI.03<<
                    //>>HEI.05
                    AgingBandE6_Currency := '';
                    AgingBandE6_Amt := 0;
                    AgingBandE6_DisputedAmt := 0;
                    //<<HEI.05
                    IF Number = 1 THEN BEGIN
                        IF NOT TempAgingBandBuf.FIND('-') THEN BEGIN
                            IF NOT TempAgingBandBuf2.FIND('-') THEN //HEI.03
                                CurrReport.BREAK
                            //HEI.03>>
                            ELSE BEGIN
                                AgingBand6_Currency := TempAgingBandBuf2."Currency Code";
                                AgingBand6_Amt := TempAgingBandBuf2."Column 1 Amt.";
                                AgingBand6_DisputedAmt := TempAgingBandBuf2."Disputed Amt. FND";
                                TempAgingBandBuf."Currency Code" := TempAgingBandBuf2."Currency Code";
                                TempAgingBandBuf."Column 1 Amt." := 0;
                                TempAgingBandBuf."Column 2 Amt." := 0;
                                TempAgingBandBuf."Column 3 Amt." := 0;
                                TempAgingBandBuf."Column 4 Amt." := 0;
                                TempAgingBandBuf."Column 5 Amt." := 0;
                                TempAgingBandBuf."Disputed Amt. FND" := 0;
                                //>>HEI.05
                                AgingBandE6_Currency := TempAgingBandBuf2."Currency Code";
                                AgingBandE6_Amt := TempAgingBandBuf2."Column E1 Amt. FND";
                                AgingBandE6_DisputedAmt := TempAgingBandBuf2."Disputed EAmt. FND";
                                TempAgingBandBuf."Currency Code" := TempAgingBandBuf2."Currency Code";
                                TempAgingBandBuf."Column E1 Amt. FND" := 0;
                                TempAgingBandBuf."Column E2 Amt. FND" := 0;
                                TempAgingBandBuf."Column E3 Amt. FND" := 0;
                                TempAgingBandBuf."Column E4 Amt. FND" := 0;
                                TempAgingBandBuf."Column E5 Amt. FND" := 0;
                                TempAgingBandBuf."Disputed EAmt. FND" := 0;
                                //<<HEI.05
                            END;
                        END ELSE
                            IF NOT TempAgingBandBuf2.GET(TempAgingBandBuf."Currency Code") THEN BEGIN
                                AgingBand6_Currency := TempAgingBandBuf."Currency Code";
                                AgingBand6_Amt := 0;
                                AgingBand6_DisputedAmt := 0;
                                //>>HEI.05
                                AgingBandE6_Currency := TempAgingBandBuf."Currency Code";
                                AgingBandE6_Amt := 0;
                                AgingBandE6_DisputedAmt := 0;
                                //<<HEI.05
                            END ELSE BEGIN
                                AgingBand6_Currency := TempAgingBandBuf2."Currency Code";
                                //AgingBand6_Amt := TempAgingBandBuf2."Column E1 Amt.";   //commented by HEI.05
                                AgingBand6_Amt := TempAgingBandBuf2."Column 1 Amt.";      //HEI.05
                                AgingBand6_DisputedAmt := TempAgingBandBuf2."Disputed EAmt. FND";
                                //>>HEI.05
                                AgingBandE6_Currency := TempAgingBandBuf2."Currency Code";
                                AgingBandE6_Amt := TempAgingBandBuf2."Column E1 Amt. FND";
                                AgingBandE6_DisputedAmt := TempAgingBandBuf2."Disputed EAmt. FND";
                                //<<HEI.05
                            END;
                        //HEI.03<<
                    END ELSE
                        IF TempAgingBandBuf.NEXT = 0 THEN BEGIN
                            IF TempAgingBandBuf2.NEXT = 0 THEN //HEI.03
                                CurrReport.BREAK
                            //HEI.03>>
                            ELSE BEGIN
                                AgingBand6_Currency := TempAgingBandBuf2."Currency Code";
                                AgingBand6_Amt := TempAgingBandBuf2."Column 1 Amt.";
                                AgingBand6_DisputedAmt := TempAgingBandBuf2."Disputed Amt. FND";
                                TempAgingBandBuf."Currency Code" := TempAgingBandBuf2."Currency Code";
                                TempAgingBandBuf."Column 1 Amt." := 0;
                                TempAgingBandBuf."Column 2 Amt." := 0;
                                TempAgingBandBuf."Column 3 Amt." := 0;
                                TempAgingBandBuf."Column 4 Amt." := 0;
                                TempAgingBandBuf."Column 5 Amt." := 0;
                                TempAgingBandBuf."Disputed Amt. FND" := 0;
                                //>>HEI.05
                                AgingBandE6_Currency := TempAgingBandBuf2."Currency Code";
                                AgingBandE6_Amt := TempAgingBandBuf2."Column E1 Amt. FND";
                                AgingBandE6_DisputedAmt := TempAgingBandBuf2."Disputed EAmt. FND";
                                TempAgingBandBuf."Currency Code" := TempAgingBandBuf2."Currency Code";
                                TempAgingBandBuf."Column E1 Amt. FND" := 0;
                                TempAgingBandBuf."Column E2 Amt. FND" := 0;
                                TempAgingBandBuf."Column E3 Amt. FND" := 0;
                                TempAgingBandBuf."Column E4 Amt. FND" := 0;
                                TempAgingBandBuf."Column E5 Amt. FND" := 0;
                                TempAgingBandBuf."Disputed EAmt. FND" := 0;
                                //<<HEI.05
                            END;
                        END ELSE
                            IF NOT TempAgingBandBuf2.GET(TempAgingBandBuf."Currency Code") THEN BEGIN
                                AgingBand6_Currency := TempAgingBandBuf."Currency Code";
                                AgingBand6_Amt := 0;
                                AgingBand6_DisputedAmt := 0;
                                //>>HEI.05
                                AgingBandE6_Currency := TempAgingBandBuf."Currency Code";
                                AgingBandE6_Amt := 0;
                                AgingBandE6_DisputedAmt := 0;
                                //<<HEI.05
                            END ELSE BEGIN
                                AgingBand6_Currency := TempAgingBandBuf2."Currency Code";
                                AgingBand6_Amt := TempAgingBandBuf2."Column 1 Amt.";
                                AgingBand6_DisputedAmt := TempAgingBandBuf2."Disputed Amt. FND";
                                //>>HEI.05
                                AgingBandE6_Currency := TempAgingBandBuf2."Currency Code";
                                AgingBandE6_Amt := TempAgingBandBuf2."Column E1 Amt. FND";
                                AgingBandE6_DisputedAmt := TempAgingBandBuf2."Disputed EAmt. FND";
                                //<<HEI.05
                            END;
                    //HEI.03<<
                end;

                trigger OnPreDataItem();
                begin
                    //IF NOT IncludeAgingBand THEN  //commented by HEI.02
                    //HEI.03>>
                    //IF ReportType = ReportType::Statement THEN  //HEI.02
                    //CurrReport.BREAK;
                    //HEI.03<<
                end;
            }

            trigger OnAfterGetRecord();
            begin
                IF CustomerAttributes.GET("No.") THEN;  //HEI.02
                TempAgingBandBuf.DELETEALL;
                TempAgingBandBuf2.DELETEALL; //HEI.03

                CustCountry := '';
                IF CountryRegion.GET("Country/Region Code") THEN
                    CustCountry := CountryRegion.Name;

                NoOfLinesToPrint := 0;

                //HEI.06 >>
                // BC Upgrade BHARDA11 >> ---- This (SendEMailwithAttachment) codeunit was marked on hold by Manisha after discussion with Saikat.
                // IF SendEmail THEN
                //     SendEMailwithAttachment.SendMailGlobalCustStatementReport(StartDate, EndDate, OpenEntries, NewReportType, PeriodLength, DateChoice, SupportedOutputMethod, ChosenOutputMethod, PrintRemaining, Customer);
                // BC Upgrade BHARDA11 << ---- This (SendEMailwithAttachment) codeunit was marked on hold by Manisha after discussion with Saikat.

                //HEI.06 <<
            end;

            trigger OnPreDataItem();
            var
                CountryInfo: Record "Country/Region";
            begin

                VerifyDates;
                AgingBandEndingDate := EndDate;
                CalcAgingBandDates;

                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture, "OpCo Footer image FND", "OpCo Logo FND");
                IF CountryRegion.GET(CompanyInfo."Country/Region Code") THEN
                    CompCountry := CountryRegion.Name;

                GLSetup.GET;

                FooterText := CompanyInfo.Name + ' ' + TxtFooter;
                IF CompanyInfo."RCCM Legal entity code FND" <> '' THEN
                    FooterText := FooterText + ', ' + TxtFooter1 + ' ' + CompanyInfo."RCCM Legal entity code FND";
                IF CompanyInfo."Cap. Social FND" <> '' THEN
                    FooterText := FooterText + ', ' + TxtFooter2 + ' ' + CompanyInfo."Cap. Social FND";
                IF CompanyInfo."WHT Registration ID FND" <> '' THEN
                    FooterText := FooterText + ', ' + CompanyInfo."WHT Registration ID FND";
                IF CompanyInfo."VAT Registration No." <> '' THEN
                    FooterText := FooterText + ' - ' + TxtFooter3 + ' ' + CompanyInfo."VAT Registration No.";
                IF CompanyInfo.Address <> '' THEN
                    FooterText := FooterText + ' - ' + CompanyInfo.Address;
                IF CompanyInfo."Address 2" <> '' THEN
                    FooterText := FooterText + ' ' + CompanyInfo."Address 2";
                IF CompanyInfo.City <> '' THEN
                    FooterText := FooterText + ', ' + CompanyInfo.City;

                //HEI.04>>
                CLEAR(CompanyText);
                CompanyText := CompanyInfo.Name;
                IF (CompanyInfo.Address <> '') THEN
                    CompanyText += ', ' + CompanyInfo.Address;
                IF (CompanyInfo."Address 2" <> '') THEN
                    CompanyText += ', ' + CompanyInfo."Address 2";
                IF (CompanyInfo."Post Code" <> '') THEN
                    CompanyText += ', ' + CompanyInfo."Post Code";
                IF (CompanyInfo.City <> '') THEN
                    CompanyText += ' ' + CompanyInfo.City;
                IF (CompanyInfo."Country/Region Code" <> '') THEN
                    IF CountryInfo.GET(CompanyInfo."Country/Region Code") THEN
                        CompanyText += ', ' + CountryInfo.Name;
                IF CompanyInfo."VAT Registration No." <> '' THEN
                    CompanyText += ', ' + 'VAT No.: ' + CompanyInfo."VAT Registration No.";
                IF CompanyInfo."Phone No." <> '' THEN
                    CompanyText += ', ' + 'Telephone: ' + CompanyInfo."Phone No.";
                IF CompanyInfo."E-Mail" <> '' THEN
                    CompanyText += ', ' + 'E-mail: ' + CompanyInfo."E-Mail";
                //HEI.04<<
            end;
        }
    }

    requestpage
    {
        Caption = 'Customer Statement of Account - Sierra Leone';
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field("Start Date"; StartDate)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Start Date',
                                    FRA = 'Date début';
                        ToolTipML = ENU = 'Specifies the date from which the report or batch job processes information.',
                                    FRA = 'Spécifie la date à partir de laquelle l''état ou le traitement par lots traite les informations.';
                    }
                    field("End Date"; EndDate)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'End Date',
                                    FRA = 'Date fin';
                        ToolTipML = ENU = 'Specifies the date to which the report or batch job processes information.',
                                    FRA = 'Spécifie la date à laquelle l''état ou le traitement par lots traite les informations.';
                    }
                    field("Open Entries"; OpenEntries)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Open Entries',
                                    FRA = 'Écritures ouvertes';
                    }
                    group("Aging Band")
                    {
                        CaptionML = ENU = 'Aging Band',
                                    FRA = 'Cumul';
                        field(IncludeAgingBand; IncludeAgingBand)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Include Aging Band',
                                        FRA = 'Inclure cumul date';
                            ToolTipML = ENU = 'Specifies if you want an aging band to be included in the document. If you place a check mark here, you must also fill in the Aging Band Period Length and Aging Band by fields.',
                                        FRA = 'Indique si vous souhaitez inclure un cumul date dans le document. Si vous activez ce champ, vous devez également renseigner les champs Base période cumul date et Cumul par.';
                            Visible = false;
                        }
                        field(ReportType; ReportType)
                        {
                            ApplicationArea = All;
                            CaptionML = ENU = 'Report Type',
                                        FRA = 'Type de rapport';
                            Visible = false;
                        }
                        field(NewReportType; NewReportType)
                        {
                            ApplicationArea = All;
                            Caption = 'Report Type';
                        }
                        field(AgingBandPeriodLengt; PeriodLength)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Aging Band Period Length',
                                        FRA = 'Base période cumul date';
                            ToolTipML = ENU = 'Specifies the length of each of the four periods in the aging band, for example, enter "1M" for one month. The most recent period will end on the last day of the period in the Date Filter field.',
                                        FRA = 'Spécifie la longueur de chacune des quatre périodes dans le cumul date ; par exemple, saisissez « 1M » pour un mois. La période la plus récente se termine le dernier jour de la période dans le champ Filtre date.';
                        }
                        field(AgingBandBy; DateChoice)
                        {
                            ApplicationArea = All;
                            Caption = 'Aging Band By';
                            OptionCaptionML = ENU = 'Due Date,Document Date,Posting Date',
                                              FRA = 'Date d''échéance,Date document,Date comptabilisation';
                        }
                    }
                }
                group("Output Options")
                {
                    CaptionML = ENU = 'Output Options',
                                FRA = 'Options sortie';
                    field(ReportOutput; SupportedOutputMethod)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Report Output',
                                    FRA = 'Sortie état';
                        OptionCaptionML = Comment = 'Each item is a verb/action - to print, to preview, to export to Word, export to PDF, send email, export to XML for RDLC layouts only',
                                          ENU = 'Print,Preview,Word,PDF,Email,XML - RDLC layouts only',
                                          FRA = 'Imprimer,Aperçu,Word,PDF,E-mail,XML - Présentations RDLC uniquement';
                        ToolTipML = ENU = 'Specifies the output of the scheduled report, such as PDF or Word.',
                                    FRA = 'Spécifie le type de sortie de l''état planifié, tel que PDF ou Word.';

                        trigger OnValidate();
                        var
                            CustomLayoutReporting: Codeunit "Custom Layout Reporting";
                        begin
                            ShowPrintRemaining := (SupportedOutputMethod = SupportedOutputMethod::Email);

                            CASE SupportedOutputMethod OF
                                SupportedOutputMethod::Print:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPrintOption;
                                SupportedOutputMethod::Preview:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPreviewOption;
                                SupportedOutputMethod::Word:
                                    ChosenOutputMethod := CustomLayoutReporting.GetWordOption;
                                SupportedOutputMethod::PDF:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPDFOption;
                                SupportedOutputMethod::Email:
                                    //HEI.06 >>
                                    BEGIN
                                        //      ChosenOutputMethod := CustomLayoutReporting.GetEmailOption;
                                        ChosenOutputMethod := CustomLayoutReporting.GetPreviewOption;
                                        SendEmail := TRUE;
                                    END;
                                //HEI.06 <<
                                SupportedOutputMethod::XML:
                                    ChosenOutputMethod := CustomLayoutReporting.GetXMLOption;
                            END;
                        end;
                    }
                    field(ChosenOutput; ChosenOutputMethod)
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }
                    field(SendEmail; SendEmail)
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }
                    group(EmailOptions)
                    {
                        CaptionML = ENU = 'Email Options',
                                    FRA = 'Options e-mail';
                        Visible = ShowPrintRemaining;
                        field(PrintMissingAddresses; PrintRemaining)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Print remaining statements',
                                        FRA = 'Imprimer relevés restants';
                            ToolTipML = ENU = 'Specifies that amounts that remain to be paid will be included.',
                                        FRA = 'Spécifie que les montants restant à payer seront inclus.';
                        }
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
        CreationDateLbl = 'Creation Date:'; StmtDateAdOfLbl = 'Statement Date as of:'; CurrentFutureLbl = 'Current/Future';
    }

    trigger OnInitReport();
    begin
        EndDate := WORKDATE;
        IncludeAgingBand := TRUE;
        ReportType := ReportType::Both;  //HEI.02
                                         // BC Upgrade BHARDA11 >> ---Restructure  this code because language codeunit does not contain the defination of this function GetUserLanguage 
                                         // IF Language.GetUserLanguage() = 'FRA' THEN
                                         //     EVALUATE(PeriodLength, '30J')
                                         // ELSE IF Language.GetUserLanguage() = 'ENU' THEN
                                         //     EVALUATE(PeriodLength, '30D');

        if GlobalLanguage() = 1036 then // French
            EVALUATE(PeriodLength, '30J')
        else if GlobalLanguage() = 1033 then // English (US)
            EVALUATE(PeriodLength, '30D');
        // BC Upgrade BHARDA11 << ---Restructure  this code because language codeunit does not contain the defination of this function GetUserLanguage 
        LinesToPrintonOnePage := 48;
    end;

    trigger OnPreReport();
    begin

        //CustDateFilter := FORMAT(StartDate) + '..' + FORMAT(EndDate);
        CustDateFilter := FORMAT(StartDate, 0, '<Month,2>/<Day,2>/<Year4>') + '..' + FORMAT(EndDate, 0, '<Month,2>/<Day,2>/<Year4>');
    end;

    var
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        StartDate: Date;
        EndDate: Date;
        AgingBandEndingDate: Date;
        IncludeAgingBand: Boolean;
        PeriodLength: DateFormula;
        PeriodLength2: DateFormula;
        BlankEndDateErr: TextConst ENU = 'End Date must have a value.', FRA = 'Date fin doit avoir une valeur.';
        StartDateLaterTheEndDateErr: TextConst ENU = 'Start date must be earlier than End date.', FRA = 'Date début doit être antérieure à Date fin.';
        AgingBandPeriodErr: TextConst ENU = 'You must specify the Aging Band Period Length.', FRA = 'Vous devez spécifier une base période pour le(s) cumul(s) date.';
        AgingBandEndErr: TextConst ENU = 'You must specify Aging Band Ending Date.', FRA = 'Vous devez spécifier une date de fin pour le cumul date.';
        AgingDate: array[6] of Date;
        PeriodLengthErr: TextConst ENU = 'Period Length is out of range.', FRA = 'La période ne correspond pas à l''intervalle défini.';
        Aging: array[6] of Integer;
        AgingCap: array[6] of Text;
        TempAgingBandBuf: Record "Aging Band Buffer" temporary;
        CustomerStatementLbl: TextConst ENU = 'Statement Of Account', FRA = 'Relevé de compte client';
        CompNameLbl: TextConst ENU = 'OpCo Name', FRA = 'Nom de la société';
        CompAddressLbl: TextConst ENU = 'Address', FRA = 'Adresse';
        CompPostCodeLbl: TextConst ENU = 'Post Code', FRA = 'Code Postal';
        CompCityLbl: TextConst ENU = 'City', FRA = 'Ville';
        CompCountryLbl: TextConst ENU = 'Country', FRA = 'Pays';
        ClientLbl: TextConst ENU = 'CUSTOMER', FRA = 'Client';
        ClientNameLbl: TextConst ENU = 'Customer Name', FRA = 'Nom du client';
        ClientNoLbl: TextConst ENU = 'Customer No.', FRA = 'N° du client';
        ClientAddressLbl: TextConst ENU = 'Address', FRA = 'Adresse';
        ClientPostCodeLbl: TextConst ENU = 'Post Code', FRA = 'Code Postal';
        ClientCityLbl: TextConst ENU = 'City', FRA = 'Ville';
        ClientCountryLbl: TextConst ENU = 'Country', FRA = 'Pays';
        ClientVATRegNoLbl: TextConst ENU = 'GST Registration No.', FRA = 'N° d''identification TVA';
        CompanyTaxNoLbl: TextConst ENU = 'Company Tax ID', FRA = 'N° fiscal de l''entreprise';
        DateOfDeclLbl: TextConst ENU = 'Date of Declaration', FRA = 'Date de déclaration';
        PageNoLbl: TextConst ENU = 'Page No.', FRA = 'Page No.';
        LineDocumentDateLbl: TextConst ENU = 'Document Date', FRA = 'Date document';
        LineDocumentNoLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        LineDocTypeLbl: TextConst ENU = 'Doc. Type', FRA = 'Type de document';
        LineWhseShpmtNoLbl: TextConst ENU = 'Whse. Shpmt. No.', FRA = 'Entrepôt No';
        LineDescriptionLbl: TextConst ENU = 'Description', FRA = 'Description';
        LineAmountLbl: TextConst ENU = 'Doc. Amount', FRA = 'Montant Du Document';
        LineCurrencyLbl: TextConst ENU = 'Doc. Currency', FRA = 'Monnaie de Document';
        LineDueDateLbl: TextConst ENU = 'Payment Due Date', FRA = 'Date d’échéance du paiement';
        LineDisputedLbl: TextConst ENU = 'Disputed', FRA = 'Contesté';
        LineAmountPaidLbl: TextConst ENU = 'Partially Paid Amount', FRA = 'Montant partiellement payé';
        LineUnallocatedAmountLbl: TextConst ENU = 'Unallocated Payment', FRA = 'Montant non alloué';
        LineBalanceDueLbl: TextConst ENU = 'Balance Due', FRA = 'Solde dû';
        DocCurrSummaryLbl: TextConst ENU = 'Document Currency Summary', FRA = 'Résumé de la monnaie de document';
        AgingSummaryLbl: TextConst ENU = 'Ageing Summary', FRA = 'Résumé du vieillissement';
        CurrencyLbl: TextConst ENU = 'Currency', FRA = 'Monnaie';
        AgingTotalLbl: TextConst ENU = 'TOTAL', FRA = 'TOTAL';
        AgingDisputedLbl: TextConst ENU = 'Disputed', FRA = 'Contesté';
        SignatureLbl: TextConst ENU = 'Signature', FRA = 'Signature';
        TempAgingBandBuf2: Record "Aging Band Buffer" temporary;
        CustCountry: Text;
        CompCountry: Text;
        CountryRegion: Record "Country/Region";
        // Language: Record Language; // BC Upgrade BHARDA11 ::Blocked
        WhseDocNo: Text;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        NoOfLinesToPrint: Integer;
        LinesToPrintonOnePage: Integer;
        DateChoice: Option "Due Date","Document Date","Posting Date";
        SupportedOutputMethod: Option Print,Preview,Word,PDF,Email,XML;
        ChosenOutputMethod: Integer;
        PrintRemaining: Boolean;

        ShowPrintRemaining: Boolean;
        OpenEntries: Boolean;
        Text000: TextConst ENU = 'Period:', FRA = 'Période:';
        CustDateFilter: Text;
        ReportType: Option Both,Statement,Ageing;
        PhoneLbl: TextConst ENU = 'Phone No.:', FRA = 'N° téléphone:';
        EmailLbl: Label 'Email:';
        NIFLbl: TextConst ENU = 'NIF:', FRA = 'N° impot:';
        CustomerAttributes: Record "Customer Attributes FND";
        PeriodLength1: DateFormula;
        PeriodLbl: TextConst Comment = 'Negating the period length: %1 is the period length', ENU = '-1D-%1', FRA = '-1J-%1';
        PeriodSeparatorLbl: TextConst Comment = 'Negating the period length: %1 is the period length', ENU = '-%1', FRA = '-%1';
        PeriodLength3: DateFormula;
        isPayment: Boolean;
        LineItemChargeTypeLbl: TextConst ENU = 'Item Charge Type', FRA = 'Type frais annexes';
        FooterText: Text[500];
        TxtFooter: TextConst ENU = 'à capital variable', FRA = 'à capital variable', ENG = 'a capital variable';
        TxtFooter1: TextConst ENU = 'RCCM: n°', FRA = 'Registre de Commerce et du Crédit Mobilier (RCCM): n°';
        TxtFooter2: TextConst ENU = 'Capital Social Initial :', FRA = 'Capital Social Initial :';
        TxtFooter3: Label 'I.N.';
        CurrentFutureCaption: Label 'Current/Future';
        AgingBand6_Amt: Decimal;
        AgingBand6_DisputedAmt: Decimal;
        AgingBand6_Currency: Code[20];
        CompanyText: Text;
        "//***HEI.05***//": Text;
        NewReportType: Option Full,Liquids,Deposit;
        AgingBandE6_Amt: Decimal;
        AgingBandE6_DisputedAmt: Decimal;
        AgingBandE6_Currency: Code[20];
        CustomerNo: Code[20];
        SendEmail: Boolean;
    // SendEMailwithAttachment: Codeunit "Send E-Mail with Attachment"; //50085; // BC Upgrade BHARAD11 ---This codeunit was marked on hold by Manisha after discussion with Saikat.

    local procedure CalcAgingBandDates();
    begin
        //IF NOT IncludeAgingBand THEN   //commented by HEI.02
        //HEI.03>>
        //IF ReportType = ReportType::Statement THEN  //HEI.02
        //EXIT;
        //HEI.03<<

        IF AgingBandEndingDate = 0D THEN
            ERROR(AgingBandEndErr);
        IF FORMAT(PeriodLength) = '' THEN
            ERROR(AgingBandPeriodErr);
        EVALUATE(PeriodLength2, STRSUBSTNO(PeriodSeparatorLbl, PeriodLength));
        EVALUATE(PeriodLength1, STRSUBSTNO(PeriodLbl, PeriodLength));

        AgingDate[6] := TODAY; //HEI.03
        AgingDate[5] := AgingBandEndingDate;
        AgingDate[4] := CALCDATE(PeriodLength1, AgingDate[5]);
        AgingDate[3] := CALCDATE(PeriodLength2, AgingDate[4]);
        AgingDate[2] := CALCDATE(PeriodLength2, AgingDate[3]);
        AgingDate[1] := CALCDATE(PeriodLength2, AgingDate[2]);
        IF AgingDate[2] <= AgingDate[1] THEN
            ERROR(PeriodLengthErr);

        //HEI.03>>
        Aging[6] := AgingDate[6] - AgingDate[6];
        //Aging[5] := AgingBandEndingDate - AgingDate[5];
        Aging[5] := AgingBandEndingDate - AgingDate[5] + 1;
        //HEI.03>>
        Aging[4] := AgingBandEndingDate - AgingDate[4] - 1;
        Aging[3] := AgingBandEndingDate - AgingDate[3] - 1;
        Aging[2] := AgingBandEndingDate - AgingDate[2] - 1;
        Aging[1] := AgingBandEndingDate - AgingDate[1] - 1;

        AgingCap[5] := STRSUBSTNO('%1-%2', Aging[5], Aging[4]);
        AgingCap[4] := STRSUBSTNO('%1-%2', Aging[4] + 1, Aging[3]);
        AgingCap[3] := STRSUBSTNO('%1-%2', Aging[3] + 1, Aging[2]);
        AgingCap[2] := STRSUBSTNO('%1-%2', Aging[2] + 1, Aging[1]);
        //HEI.03>>
        //AgingCap[1] := STRSUBSTNO('>%1',Aging[1] + 1);
        AgingCap[1] := STRSUBSTNO('>%1', Aging[1]);
        AgingCap[6] := CurrentFutureCaption;
        //HEI.03<<
    end;

    local procedure VerifyDates();
    begin
        IF EndDate = 0D THEN
            ERROR(BlankEndDateErr);
        //HEI.02>>
        IF StartDate > EndDate THEN
            ERROR(StartDateLaterTheEndDateErr);
        //HEI.02<<
    end;

    local procedure UpdateBuffer(CurrencyCode: Code[10]; Date: Date; Amount: Decimal; IsDisputed: Boolean; ItemChargeType: Option " ",Tax,Deposit,Discount,Promotion,,ShippingCost);
    var
        I: Integer;
        GoOn: Boolean;
    begin
        IF Date < EndDate THEN BEGIN //HEI.03
            TempAgingBandBuf.INIT;
            TempAgingBandBuf."Currency Code" := CurrencyCode;
            IF NOT TempAgingBandBuf.FIND THEN
                TempAgingBandBuf.INSERT;
            I := 1;
            GoOn := TRUE;
            WHILE (I <= 5) AND GoOn DO BEGIN
                IF Date <= AgingDate[I] THEN
                    IF I = 1 THEN BEGIN
                        //>>HEI.05
                        //TempAgingBandBuf."Column 1 Amt." := TempAgingBandBuf."Column 1 Amt." + Amount;
                        //<<HEI.05
                        //>>HEI.05
                        IF ItemChargeType IN [ItemChargeType::" "] THEN BEGIN
                            TempAgingBandBuf."Column 1 Amt." := TempAgingBandBuf."Column 1 Amt." + Amount;
                        END ELSE IF ItemChargeType IN [ItemChargeType::Deposit] THEN BEGIN
                            TempAgingBandBuf."Column E1 Amt. FND" := TempAgingBandBuf."Column E1 Amt. FND" + Amount;
                        END;
                        //<<HEI.05
                        GoOn := FALSE;
                    END;
                IF Date <= AgingDate[I] THEN
                    IF I = 2 THEN BEGIN
                        //>>HEI.05
                        //TempAgingBandBuf."Column 2 Amt." := TempAgingBandBuf."Column 2 Amt." + Amount;
                        //<<HEI.05
                        //>>HEI.05
                        IF ItemChargeType IN [ItemChargeType::" "] THEN BEGIN
                            TempAgingBandBuf."Column 2 Amt." := TempAgingBandBuf."Column 2 Amt." + Amount;
                        END ELSE IF ItemChargeType IN [ItemChargeType::Deposit] THEN BEGIN
                            TempAgingBandBuf."Column E2 Amt. FND" := TempAgingBandBuf."Column E2 Amt. FND" + Amount;
                        END;
                        //<<HEI.05
                        GoOn := FALSE;
                    END;
                IF Date <= AgingDate[I] THEN
                    IF I = 3 THEN BEGIN
                        //>>HEI.05
                        //TempAgingBandBuf."Column 3 Amt." := TempAgingBandBuf."Column 3 Amt." + Amount;
                        //<<HEI.05
                        //>>HEI.05
                        IF ItemChargeType IN [ItemChargeType::" "] THEN BEGIN
                            TempAgingBandBuf."Column 3 Amt." := TempAgingBandBuf."Column 3 Amt." + Amount;
                        END ELSE IF ItemChargeType IN [ItemChargeType::Deposit] THEN BEGIN
                            TempAgingBandBuf."Column E3 Amt. FND" := TempAgingBandBuf."Column E3 Amt. FND" + Amount;
                        END;
                        //<<HEI.05
                        GoOn := FALSE;
                    END;
                IF Date <= AgingDate[I] THEN
                    IF I = 4 THEN BEGIN
                        //>>HEI.05
                        //TempAgingBandBuf."Column 4 Amt." := TempAgingBandBuf."Column 4 Amt." + Amount;
                        //<<HEI.05
                        //>>HEI.05
                        IF ItemChargeType IN [ItemChargeType::" "] THEN BEGIN
                            TempAgingBandBuf."Column 4 Amt." := TempAgingBandBuf."Column 4 Amt." + Amount;
                        END ELSE IF ItemChargeType IN [ItemChargeType::Deposit] THEN BEGIN
                            TempAgingBandBuf."Column E4 Amt. FND" := TempAgingBandBuf."Column E4 Amt. FND" + Amount;
                        END;
                        //<<HEI.05
                        GoOn := FALSE;
                    END;
                IF Date <= AgingDate[I] THEN
                    IF I = 5 THEN BEGIN
                        //>>HEI.05
                        //TempAgingBandBuf."Column 5 Amt." := TempAgingBandBuf."Column 5 Amt." + Amount;
                        //<<HEI.05
                        //>>HEI.05
                        IF ItemChargeType IN [ItemChargeType::" "] THEN BEGIN
                            TempAgingBandBuf."Column 5 Amt." := TempAgingBandBuf."Column 5 Amt." + Amount;
                        END ELSE IF ItemChargeType IN [ItemChargeType::Deposit] THEN BEGIN
                            TempAgingBandBuf."Column E5 Amt. FND" := TempAgingBandBuf."Column E5 Amt. FND" + Amount;
                        END;
                        //<<HEI.05
                        GoOn := FALSE;
                    END;
                I := I + 1;
            END;

            //>>HEI.05
            /*
            IF IsDisputed THEN
              TempAgingBandBuf."Disputed Amt." := TempAgingBandBuf."Disputed Amt." + Amount;
            */
            //<<HEI.05
            //>>HEI.05
            IF IsDisputed THEN BEGIN
                IF ItemChargeType IN [ItemChargeType::" "] THEN BEGIN
                    TempAgingBandBuf."Disputed Amt. FND" := TempAgingBandBuf."Disputed Amt. FND" + Amount;
                END ELSE IF ItemChargeType IN [ItemChargeType::Deposit] THEN BEGIN
                    TempAgingBandBuf."Disputed EAmt. FND" := TempAgingBandBuf."Disputed EAmt. FND" + Amount;
                END;
            END;
            //<<HEI.05
            TempAgingBandBuf.MODIFY;
            //HEI.03>>
        END ELSE BEGIN
            TempAgingBandBuf2.INIT;
            TempAgingBandBuf2."Currency Code" := CurrencyCode;
            IF NOT TempAgingBandBuf2.FIND THEN
                TempAgingBandBuf2.INSERT;

            //>>HEI.05
            //TempAgingBandBuf2."Column 1 Amt." := TempAgingBandBuf2."Column 1 Amt." + Amount;
            //<<HEI.05
            //>>HEI.05
            IF ItemChargeType IN [ItemChargeType::" "] THEN BEGIN
                TempAgingBandBuf2."Column 1 Amt." := TempAgingBandBuf2."Column 1 Amt." + Amount;
            END ELSE IF ItemChargeType IN [ItemChargeType::Deposit] THEN BEGIN
                TempAgingBandBuf2."Column E1 Amt. FND" := TempAgingBandBuf2."Column E1 Amt. FND" + Amount;
            END;
            //<<HEI.05
            //>>HEI.05
            /*
            IF IsDisputed THEN
              TempAgingBandBuf2."Disputed Amt." := TempAgingBandBuf2."Disputed Amt." + Amount;
            */
            //<<HEI.05
            //>>HEI.05
            IF IsDisputed THEN BEGIN
                IF ItemChargeType IN [ItemChargeType::" "] THEN BEGIN
                    TempAgingBandBuf2."Disputed Amt. FND" := TempAgingBandBuf2."Disputed Amt. FND" + Amount;
                END ELSE IF ItemChargeType IN [ItemChargeType::Deposit] THEN BEGIN
                    TempAgingBandBuf2."Disputed EAmt. FND" := TempAgingBandBuf2."Disputed EAmt. FND" + Amount;
                END;
            END;
            //<<HEI.05
            TempAgingBandBuf2.MODIFY;
        END;
        //HEI.03<<

    end;
}

