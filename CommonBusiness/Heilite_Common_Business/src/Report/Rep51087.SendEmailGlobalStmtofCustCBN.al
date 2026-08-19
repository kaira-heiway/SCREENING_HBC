report 51087 "SendEmail Cust Stmt Global CBN"
{
    // version HEI.03

    // HEI.01 CHG2136952 HB2677 IBM BHANDS01 01.12.2021
    //   # Copied Report 50504 - To send the report with custom E mail body along with report as attachment.
    // HEI.02 CHG2250653-HB3631 COSTES04 14.08.2024 Customer Statement should show dates in sequency
    //   # Change Cust Ledger Entry Tablix sorting
    // HEI.03 CHG2250653-HB3631 COSTES04 17.09.2024 Customer Statement should show dates in sequency
    //   # New column No. Of Days OVerdue
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Send Email Global Stmt of Cust.rdl';

    CaptionML = ENU = 'Customer Statement of Account',
                FRA = 'Client – relevé de compte';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

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
            // column(CompanyTaxNo_Customer;Customer."Tax Registration No.") // BC Upgrade BHARDA11 -- Drink-IT Field ("Tax Registration No.")
            column(CompanyTaxNo_Customer; '')
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
                DataItemTableView = sorting("Entry No.") ORDER(Descending);
                column(DocumentDate_CustLedgerEntry; FORMAT("Cust. Ledger Entry"."Document Date", 0, '<Day,2>-<Month>-<Year4>'))
                {
                }
                column(DocumentDate_CLE; "Cust. Ledger Entry"."Document Date")
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
                // column(ItemChargeType_CustLedgerEntry; "Cust. Ledger Entry"."Item Charge Type") // BC Upgrade BHARDA11 ---- Drink-IT Field ("Item Charge Type")
                column(ItemChargeType_CustLedgerEntry; '')
                {
                }
                column(NoOfDaysOverdue; NoOfDaysOverdue)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    if ("Remaining Amount" = 0)
                      and OpenEntries then  //HEI.02
                        CurrReport.SKIP();

                    NoOfLinesToPrint += 1;

                    if "Currency Code" = '' then
                        "Currency Code" := GLSetup."LCY Code";

                    WhseDocNo := '';
                    case "Document Type" of
                        "Cust. Ledger Entry"."Document Type"::Invoice:
                            begin
                                if SalesInvoiceHeader.GET("Document No.") then begin
                                    WhseDocNo := SalesInvoiceHeader."Whse. Shipment No. FND";
                                end;
                            end;
                        "Cust. Ledger Entry"."Document Type"::"Credit Memo":
                            begin
                                if SalesCrMemoHeader.GET("Document No.") then begin
                                    WhseDocNo := SalesCrMemoHeader."Whse. Shipment No. FND";
                                end;
                            end;
                    end;

                    //IF IncludeAgingBand THEN  //commented by HEI.02
                    //IF ReportType <> ReportType::Statement THEN  //HEI.02 //HEI.03
                    case DateChoice of
                    //HEI.02>>
                    // BC Upgrade BHARA11 >> ---DRink-It Field "Cust. Ledger Entry"."Item Charge Type" 
                    // // DateChoice::"Due Date":
                    // //>>HEI.05
                    // //UpdateBuffer("Currency Code", "Due Date", "Remaining Amount","Dispute Case");
                    // //<<HEI.05
                    // //>>HEI.05
                    // UpdateBuffer("Currency Code", "Due Date", "Remaining Amount", "Dispute Case", "Cust. Ledger Entry"."Item Charge Type");
                    // //<<HEI.05
                    // DateChoice::"Document Date":
                    //     //>>HEI.05
                    //     //UpdateBuffer("Currency Code", "Document Date", "Remaining Amount","Dispute Case");
                    //     //<<HEI.05
                    //     //>>HEI.05
                    //     UpdateBuffer("Currency Code", "Document Date", "Remaining Amount", "Dispute Case", "Cust. Ledger Entry"."Item Charge Type");
                    // //<<HEI.05
                    // DateChoice::"Posting Date":
                    //     //>>HEI.05
                    //     //UpdateBuffer("Currency Code", "Posting Date", "Remaining Amount","Dispute Case");
                    //     //<<HEI.05
                    //     //>>HEI.05
                    //     UpdateBuffer("Currency Code", "Posting Date", "Remaining Amount", "Dispute Case", "Cust. Ledger Entry"."Item Charge Type");
                    // BC Upgrade BHARA11 << ---DRink-It Field "Cust. Ledger Entry"."Item Charge Type" 
                    //<<HEI.05

                    end;

                    isPayment := false;
                    if "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::Payment then
                        isPayment := true;
                    //HEI.03>>
                    CLEAR(NoOfDaysOverdue);
                    if ("Cust. Ledger Entry"."Due Date" < TODAY) and ("Cust. Ledger Entry"."Remaining Amount" > 0) then
                        NoOfDaysOverdue := TODAY - "Due Date";
                    //HEI.03<<
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
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields ("Item Charge Type")
                    // if NewReportType = NewReportType::Full then begin
                    //     "Cust. Ledger Entry".SETFILTER("Cust. Ledger Entry"."Item Charge Type", '%1|%2', "Cust. Ledger Entry"."Item Charge Type"::" ", "Cust. Ledger Entry"."Item Charge Type"::Deposit);
                    // end else if NewReportType = NewReportType::Liquids then begin
                    //     "Cust. Ledger Entry".SETRANGE("Cust. Ledger Entry"."Item Charge Type", "Cust. Ledger Entry"."Item Charge Type"::" ");
                    // end else if NewReportType = NewReportType::Deposit then begin
                    //     "Cust. Ledger Entry".SETRANGE("Cust. Ledger Entry"."Item Charge Type", "Cust. Ledger Entry"."Item Charge Type"::Deposit);
                    // end;
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields ("Item Charge Type")

                    //<<HEI.05
                    "Cust. Ledger Entry".SETAUTOCALCFIELDS("Remaining Amount");//HEI.03

                end;
            }
            dataitem(BlankLines; "Integer")
            {
                DataItemTableView = sorting(Number) ORDER(Ascending);
                column(Number_BlankLines; BlankLines.Number)
                {
                }

                trigger OnPreDataItem();
                begin
                    if NoOfLinesToPrint = 0 then
                        CurrReport.BREAK();

                    //>>HEI.05
                    //SETRANGE(Number,1,LinesToPrintonOnePage - ((NoOfLinesToPrint + 2 + 4 + (4 * TempAgingBandBuf.COUNT)) MOD LinesToPrintonOnePage));
                    //<<HEI.05
                    //>>HEI.05
                    SETRANGE(Number, 1, LinesToPrintonOnePage - ((NoOfLinesToPrint + 2 + 4 + (5 * TempAgingBandBuf.COUNT)) mod LinesToPrintonOnePage));
                    //<<HEI.05
                end;
            }
            dataitem(AgingBand; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = FILTER(1 ..));
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
                // column(Disputed_AgingBand; TempAgingBandBuf."Disputed Amt.")
                column(Disputed_AgingBand; '') // BC Upgrade BHARDA11 ---Temp Blocked
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
                // BC Upgrade BHARDA11 >> ----Temp Blocked
                // column(BandE1_AgingBand; TempAgingBandBuf."Column E1 Amt.")
                // {
                // }
                // column(BandE2_AgingBand; TempAgingBandBuf."Column E2 Amt.")
                // {
                // }
                // column(BandE3_AgingBand; TempAgingBandBuf."Column E3 Amt.")
                // {
                // }
                // column(BandE4_AgingBand; TempAgingBandBuf."Column E4 Amt.")
                // {
                // }
                // column(BandE5_AgingBand; TempAgingBandBuf."Column E5 Amt.")
                // {
                // }
                // column(DisputedE_AgingBand; TempAgingBandBuf."Disputed EAmt.")
                // {
                // }
                column(BandE1_AgingBand; '')
                {
                }
                column(BandE2_AgingBand; '')
                {
                }
                column(BandE3_AgingBand; '')
                {
                }
                column(BandE4_AgingBand; '')
                {
                }
                column(BandE5_AgingBand; '')
                {
                }
                column(DisputedE_AgingBand; '')
                {
                }
                // BC Upgrade BHARDA11 << ----Temp Blocked
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
                    if Number = 1 then begin
                        if not TempAgingBandBuf.FIND('-') then begin
                            if not TempAgingBandBuf2.FIND('-') then //HEI.03
                                CurrReport.BREAK()
                            //HEI.03>>
                            else begin
                                AgingBand6_Currency := TempAgingBandBuf2."Currency Code";
                                AgingBand6_Amt := TempAgingBandBuf2."Column 1 Amt.";
                                AgingBand6_DisputedAmt := TempAgingBandBuf2."Disputed Amt. FND";  // BC Upgrade BHARDA11 ---- Temp Blocked
                                TempAgingBandBuf."Currency Code" := TempAgingBandBuf2."Currency Code";
                                TempAgingBandBuf."Column 1 Amt." := 0;
                                TempAgingBandBuf."Column 2 Amt." := 0;
                                TempAgingBandBuf."Column 3 Amt." := 0;
                                TempAgingBandBuf."Column 4 Amt." := 0;
                                TempAgingBandBuf."Column 5 Amt." := 0;
                                TempAgingBandBuf."Disputed Amt. FND" := 0; // BC Upgrade BHARDA11 ---- Temp Blocked
                                //>>HEI.05
                                AgingBandE6_Currency := TempAgingBandBuf2."Currency Code";
                                AgingBandE6_Amt := TempAgingBandBuf2."Column E1 Amt. FND"; // BC Upgrade BHARDA11 ---- Temp Blocked
                                AgingBandE6_DisputedAmt := TempAgingBandBuf2."Disputed EAmt. FND";  // BC Upgrade BHARDA11 ---- Temp Blocked
                                TempAgingBandBuf."Currency Code" := TempAgingBandBuf2."Currency Code";
                                // BC Upgrade BHARDA11 >> ---- Temp Blocked
                                TempAgingBandBuf."Column E1 Amt. FND" := 0;
                                TempAgingBandBuf."Column E2 Amt. FND" := 0;
                                TempAgingBandBuf."Column E3 Amt. FND" := 0;
                                TempAgingBandBuf."Column E4 Amt. FND" := 0;
                                TempAgingBandBuf."Column E5 Amt. FND" := 0;
                                TempAgingBandBuf."Disputed EAmt. FND" := 0;
                                // BC Upgrade BHARDA11 << ---- Temp Blocked
                                //<<HEI.05
                            end;
                        end else
                            if not TempAgingBandBuf2.GET(TempAgingBandBuf."Currency Code") then begin
                                AgingBand6_Currency := TempAgingBandBuf."Currency Code";
                                AgingBand6_Amt := 0;
                                AgingBand6_DisputedAmt := 0;
                                //>>HEI.05
                                AgingBandE6_Currency := TempAgingBandBuf."Currency Code";
                                AgingBandE6_Amt := 0;
                                AgingBandE6_DisputedAmt := 0;
                                //<<HEI.05
                            end else begin
                                AgingBand6_Currency := TempAgingBandBuf2."Currency Code";
                                //AgingBand6_Amt := TempAgingBandBuf2."Column E1 Amt.";   //commented by HEI.05
                                AgingBand6_Amt := TempAgingBandBuf2."Column 1 Amt.";      //HEI.05
                                AgingBand6_DisputedAmt := TempAgingBandBuf2."Disputed EAmt. FND"; // BC Upgrade BHARDA11 ---- Temp Blocked
                                //>>HEI.05
                                AgingBandE6_Currency := TempAgingBandBuf2."Currency Code";
                                AgingBandE6_Amt := TempAgingBandBuf2."Column E1 Amt. FND"; // BC Upgrade BHARDA11 ---- Temp Blocked
                                AgingBandE6_DisputedAmt := TempAgingBandBuf2."Disputed EAmt. FND";  // BC Upgrade BHARDA11 ---- Temp Blocked
                                //<<HEI.05
                            end;
                        //HEI.03<<
                    end else
                        if TempAgingBandBuf.NEXT() = 0 then begin
                            if TempAgingBandBuf2.NEXT() = 0 then //HEI.03
                                CurrReport.BREAK()
                            //HEI.03>>
                            else begin
                                AgingBand6_Currency := TempAgingBandBuf2."Currency Code";
                                AgingBand6_Amt := TempAgingBandBuf2."Column 1 Amt.";
                                AgingBand6_DisputedAmt := TempAgingBandBuf2."Disputed Amt. FND"; // BC Upgrade BHARDA11 ---- Temp Blocked
                                TempAgingBandBuf."Currency Code" := TempAgingBandBuf2."Currency Code";
                                TempAgingBandBuf."Column 1 Amt." := 0;
                                TempAgingBandBuf."Column 2 Amt." := 0;
                                TempAgingBandBuf."Column 3 Amt." := 0;
                                TempAgingBandBuf."Column 4 Amt." := 0;
                                TempAgingBandBuf."Column 5 Amt." := 0;
                                // TempAgingBandBuf."Disputed Amt." := 0; // BC Upgrade BHARDA11 ---- Temp Blocked
                                //>>HEI.05
                                AgingBandE6_Currency := TempAgingBandBuf2."Currency Code";
                                // AgingBandE6_Amt := TempAgingBandBuf2."Column E1 Amt.";  // BC Upgrade BHARDA11 ---- Temp Blocked
                                // AgingBandE6_DisputedAmt := TempAgingBandBuf2."Disputed EAmt."; // BC Upgrade BHARDA11 ---- Temp Blocked
                                TempAgingBandBuf."Currency Code" := TempAgingBandBuf2."Currency Code";
                                // BC Upgrade BHARDA11 >> ---- Temp Blocked
                                TempAgingBandBuf."Column E1 Amt. FND" := 0;
                                TempAgingBandBuf."Column E2 Amt. FND" := 0;
                                TempAgingBandBuf."Column E3 Amt. FND" := 0;
                                TempAgingBandBuf."Column E4 Amt. FND" := 0;
                                TempAgingBandBuf."Column E5 Amt. FND" := 0;
                                TempAgingBandBuf."Disputed EAmt. FND" := 0;
                                //<<HEI.05

                            end;
                        end else
                            if not TempAgingBandBuf2.GET(TempAgingBandBuf."Currency Code") then begin
                                AgingBand6_Currency := TempAgingBandBuf."Currency Code";
                                AgingBand6_Amt := 0;
                                AgingBand6_DisputedAmt := 0;
                                //>>HEI.05
                                AgingBandE6_Currency := TempAgingBandBuf."Currency Code";
                                AgingBandE6_Amt := 0;
                                AgingBandE6_DisputedAmt := 0;
                                //<<HEI.05
                            end else begin
                                AgingBand6_Currency := TempAgingBandBuf2."Currency Code";
                                AgingBand6_Amt := TempAgingBandBuf2."Column 1 Amt.";
                                AgingBand6_DisputedAmt := TempAgingBandBuf2."Disputed Amt. FND";  // BC Upgrade BHARA11  ---- Temp Blocked 
                                //>>HEI.05
                                AgingBandE6_Currency := TempAgingBandBuf2."Currency Code";
                                AgingBandE6_Amt := TempAgingBandBuf2."Column E1 Amt. FND"; // BC Upgrade BHARA11  ---- Temp Blocked 
                                AgingBandE6_DisputedAmt := TempAgingBandBuf2."Disputed EAmt. FND";  // BC Upgrade BHARA11  ---- Temp Blocked 
                                //<<HEI.05
                            end;
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
                if CustomerAttributes.GET("No.") then;  //HEI.02
                TempAgingBandBuf.DELETEALL();
                TempAgingBandBuf2.DELETEALL(); //HEI.03

                CustCountry := '';
                if CountryRegion.GET("Country/Region Code") then
                    CustCountry := CountryRegion.Name;

                NoOfLinesToPrint := 0;
            end;

            trigger OnPreDataItem();
            var
                CountryInfo: Record "Country/Region";
            begin
                //HEI.01 >>
                if CustomerNo <> '' then
                    SETRANGE("No.", CustomerNo);
                //HEI.01 <<

                VerifyDates();
                AgingBandEndingDate := EndDate;
                CalcAgingBandDates();

                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(Picture, "OpCo Footer image FND", "OpCo Logo FND");
                if CountryRegion.GET(CompanyInfo."Country/Region Code") then
                    CompCountry := CountryRegion.Name;

                GLSetup.GET();

                FooterText := CompanyInfo.Name + ' ' + TxtFooter;
                if CompanyInfo."RCCM Legal entity code FND" <> '' then
                    FooterText := FooterText + ', ' + TxtFooter1 + ' ' + CompanyInfo."RCCM Legal entity code FND";
                if CompanyInfo."Cap. Social FND" <> '' then
                    FooterText := FooterText + ', ' + TxtFooter2 + ' ' + CompanyInfo."Cap. Social FND";
                if CompanyInfo."WHT Registration ID FND" <> '' then
                    FooterText := FooterText + ', ' + CompanyInfo."WHT Registration ID FND";
                if CompanyInfo."VAT Registration No." <> '' then
                    FooterText := FooterText + ' - ' + TxtFooter3 + ' ' + CompanyInfo."VAT Registration No.";
                if CompanyInfo.Address <> '' then
                    FooterText := FooterText + ' - ' + CompanyInfo.Address;
                if CompanyInfo."Address 2" <> '' then
                    FooterText := FooterText + ' ' + CompanyInfo."Address 2";
                if CompanyInfo.City <> '' then
                    FooterText := FooterText + ', ' + CompanyInfo.City;

                //HEI.04>>
                CLEAR(CompanyText);
                CompanyText := CompanyInfo.Name;
                if (CompanyInfo.Address <> '') then
                    CompanyText += ', ' + CompanyInfo.Address;
                if (CompanyInfo."Address 2" <> '') then
                    CompanyText += ', ' + CompanyInfo."Address 2";
                if (CompanyInfo."Post Code" <> '') then
                    CompanyText += ', ' + CompanyInfo."Post Code";
                if (CompanyInfo.City <> '') then
                    CompanyText += ' ' + CompanyInfo.City;
                if (CompanyInfo."Country/Region Code" <> '') then
                    if CountryInfo.GET(CompanyInfo."Country/Region Code") then
                        CompanyText += ', ' + CountryInfo.Name;
                if CompanyInfo."VAT Registration No." <> '' then
                    CompanyText += ', ' + 'VAT No.: ' + CompanyInfo."VAT Registration No.";
                if CompanyInfo."Phone No." <> '' then
                    CompanyText += ', ' + 'Telephone: ' + CompanyInfo."Phone No.";
                if CompanyInfo."E-Mail" <> '' then
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
                        ApplicationArea = Basic, Suite;

                        CaptionML = ENU = 'Open Entries',
                                    FRA = 'Écritures ouvertes';
                        ToolTip = 'Specifies the value of the OpenEntries field.';
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
                            ApplicationArea = Basic, Suite;

                            CaptionML = ENU = 'Report Type',
                                        FRA = 'Type de rapport';
                            Visible = false;
                            ToolTip = 'Specifies the value of the ReportType field.';
                        }
                        field(NewReportType; NewReportType)
                        {
                            ApplicationArea = Basic, Suite;

                            Caption = 'Report Type';
                            ToolTip = 'Specifies the value of the Report Type field.';
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
                            ApplicationArea = Basic, Suite;

                            Caption = 'Aging Band By';
                            OptionCaptionML = ENU = 'Due Date,Document Date,Posting Date',
                                              FRA = 'Date d''échéance,Date document,Date comptabilisation';
                            ToolTip = 'Specifies the value of the Aging Band By field.';
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

                            case SupportedOutputMethod of
                                SupportedOutputMethod::Print:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPrintOption();
                                SupportedOutputMethod::Preview:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPreviewOption();
                                SupportedOutputMethod::Word:
                                    ChosenOutputMethod := CustomLayoutReporting.GetWordOption();
                                SupportedOutputMethod::PDF:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPDFOption();
                                SupportedOutputMethod::Email:
                                    ChosenOutputMethod := CustomLayoutReporting.GetEmailOption();
                                SupportedOutputMethod::XML:
                                    ChosenOutputMethod := CustomLayoutReporting.GetXMLOption();
                            end;
                        end;
                    }
                    field(ChosenOutput; ChosenOutputMethod)
                    {
                        Visible = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ChosenOutputMethod field.';
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
        CreationDateLbl = 'Creation Date:'; StmtDateAdOfLbl = 'Statement Date as of:'; CurrentFutureLbl = 'Current/Future'; NoOfDaysOverdueLbl = 'No. of Days Overdue'; TotalLbl = 'Total';
    }

    trigger OnInitReport();
    begin
        EndDate := WORKDATE();
        IncludeAgingBand := true;
        ReportType := ReportType::Both;  //HEI.02
                                         // BC Upgrade BHARA11 >> ---- Temp Blocked 
                                         // if Language.GetUserLanguage() = 'FRA' then
                                         //     EVALUATE(PeriodLength, '30J')
                                         // else if Language.GetUserLanguage() = 'ENU' then
                                         //     EVALUATE(PeriodLength, '30D');
                                         // BC Upgrade BHARA11 << ---- Temp Blocked 
        LinesToPrintonOnePage := 48;
    end;

    trigger OnPreReport();
    begin

        //CustDateFilter := FORMAT(StartDate) + '..' + FORMAT(EndDate);
        CustDateFilter := FORMAT(StartDate, 0, '<Month,2>/<Day,2>/<Year4>') + '..' + FORMAT(EndDate, 0, '<Month,2>/<Day,2>/<Year4>');
    end;

    var
        TempAgingBandBuf: Record "Aging Band Buffer" temporary;
        TempAgingBandBuf2: Record "Aging Band Buffer" temporary;
        CompanyInfo: Record "Company Information";
        CountryRegion: Record "Country/Region";
        CustomerAttributes: Record "Customer Attributes FND";
        GLSetup: Record "General Ledger Setup";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        LanguageMgt: Codeunit Language;
        PeriodLength: DateFormula;
        PeriodLength1: DateFormula;
        PeriodLength2: DateFormula;
        PeriodLength3: DateFormula;
        IncludeAgingBand: Boolean;
        isPayment: Boolean;
        OpenEntries: Boolean;
        PrintRemaining: Boolean;
        // 
        ShowPrintRemaining: Boolean;
        AgingBand6_Currency: Code[20];
        AgingBandE6_Currency: Code[20];
        CustomerNo: Code[20];
        AgingBandEndingDate: Date;
        AgingDate: array[6] of Date;
        EndDate: Date;
        StartDate: Date;
        AgingBand6_Amt: Decimal;
        AgingBand6_DisputedAmt: Decimal;
        AgingBandE6_Amt: Decimal;
        AgingBandE6_DisputedAmt: Decimal;
        Aging: array[6] of Integer;
        ChosenOutputMethod: Integer;
        LinesToPrintonOnePage: Integer;
        NoOfDaysOverdue: Integer;
        NoOfLinesToPrint: Integer;
        CurrentFutureCaption: Label 'Current/Future';
        EmailLbl: Label 'Email:';
        TxtFooter3: Label 'I.N.';
        ReportType: Option Both,Statement,Ageing;
        DateChoice: Option "Due Date","Document Date","Posting Date";
        NewReportType: Option Full,Liquids,Deposit;
        SupportedOutputMethod: Option Print,Preview,Word,PDF,Email,XML;
        "//***HEI.05***//": Text;
        AgingCap: array[6] of Text;
        CompanyText: Text;
        CompCountry: Text;
        CustCountry: Text;
        CustDateFilter: Text;
        WhseDocNo: Text;
        FooterText: Text[500];
        AgingBandEndErr: TextConst ENU = 'You must specify Aging Band Ending Date.', FRA = 'Vous devez spécifier une date de fin pour le cumul date.';
        AgingBandPeriodErr: TextConst ENU = 'You must specify the Aging Band Period Length.', FRA = 'Vous devez spécifier une base période pour le(s) cumul(s) date.';
        AgingDisputedLbl: TextConst ENU = 'Disputed', FRA = 'Contesté';
        AgingSummaryLbl: TextConst ENU = 'Ageing Summary', FRA = 'Résumé du vieillissement';
        AgingTotalLbl: TextConst ENU = 'TOTAL', FRA = 'TOTAL';
        BlankEndDateErr: TextConst ENU = 'End Date must have a value.', FRA = 'Date fin doit avoir une valeur.';
        ClientAddressLbl: TextConst ENU = 'Address', FRA = 'Adresse';
        ClientCityLbl: TextConst ENU = 'City', FRA = 'Ville';
        ClientCountryLbl: TextConst ENU = 'Country', FRA = 'Pays';
        ClientLbl: TextConst ENU = 'CUSTOMER', FRA = 'Client';
        ClientNameLbl: TextConst ENU = 'Customer Name', FRA = 'Nom du client';
        ClientNoLbl: TextConst ENU = 'Customer No.', FRA = 'N° du client';
        ClientPostCodeLbl: TextConst ENU = 'Post Code', FRA = 'Code Postal';
        ClientVATRegNoLbl: TextConst ENU = 'GST Registration No.', FRA = 'N° d''identification TVA';
        CompAddressLbl: TextConst ENU = 'Address', FRA = 'Adresse';
        CompanyTaxNoLbl: TextConst ENU = 'Company Tax ID', FRA = 'N° fiscal de l''entreprise';
        CompCityLbl: TextConst ENU = 'City', FRA = 'Ville';
        CompCountryLbl: TextConst ENU = 'Country', FRA = 'Pays';
        CompNameLbl: TextConst ENU = 'OpCo Name', FRA = 'Nom de la société';
        CompPostCodeLbl: TextConst ENU = 'Post Code', FRA = 'Code Postal';
        CurrencyLbl: TextConst ENU = 'Currency', FRA = 'Monnaie';
        CustomerStatementLbl: TextConst ENU = 'Statement Of Account', FRA = 'Relevé de compte client';
        DateOfDeclLbl: TextConst ENU = 'Date of Declaration', FRA = 'Date de déclaration';
        DocCurrSummaryLbl: TextConst ENU = 'Document Currency Summary', FRA = 'Résumé de la monnaie de document';
        LineAmountLbl: TextConst ENU = 'Doc. Amount', FRA = 'Montant Du Document';
        LineAmountPaidLbl: TextConst ENU = 'Partially Paid Amount', FRA = 'Montant partiellement payé';
        LineBalanceDueLbl: TextConst ENU = 'Balance Due', FRA = 'Solde dû';
        LineCurrencyLbl: TextConst ENU = 'Doc. Currency', FRA = 'Monnaie de Document';
        LineDescriptionLbl: TextConst ENU = 'Description', FRA = 'Description';
        LineDisputedLbl: TextConst ENU = 'Disputed', FRA = 'Contesté';
        LineDocTypeLbl: TextConst ENU = 'Doc. Type', FRA = 'Type de document';
        LineDocumentDateLbl: TextConst ENU = 'Document Date', FRA = 'Date document';
        LineDocumentNoLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        LineDueDateLbl: TextConst ENU = 'Payment Due Date', FRA = 'Date d’échéance du paiement';
        LineItemChargeTypeLbl: TextConst ENU = 'Item Charge Type', FRA = 'Type frais annexes';
        LineUnallocatedAmountLbl: TextConst ENU = 'Unallocated Payment', FRA = 'Montant non alloué';
        LineWhseShpmtNoLbl: TextConst ENU = 'Whse. Shpmt. No.', FRA = 'Entrepôt No';
        NIFLbl: TextConst ENU = 'NIF:', FRA = 'N° impot:';
        PageNoLbl: TextConst ENU = 'Page No.', FRA = 'Page No.';
        PeriodLbl: TextConst Comment = 'Negating the period length: %1 is the period length', ENU = '-1D-%1', FRA = '-1J-%1';
        PeriodLengthErr: TextConst ENU = 'Period Length is out of range.', FRA = 'La période ne correspond pas à l''intervalle défini.';
        PeriodSeparatorLbl: TextConst Comment = 'Negating the period length: %1 is the period length', ENU = '-%1', FRA = '-%1';
        PhoneLbl: TextConst ENU = 'Phone No.:', FRA = 'N° téléphone:';
        SignatureLbl: TextConst ENU = 'Signature', FRA = 'Signature';
        StartDateLaterTheEndDateErr: TextConst ENU = 'Start date must be earlier than End date.', FRA = 'Date début doit être antérieure à Date fin.';
        Text000: TextConst ENU = 'Period:', FRA = 'Période:';
        TxtFooter: TextConst ENU = 'à capital variable', FRA = 'à capital variable', ENG = 'a capital variable';
        TxtFooter1: TextConst ENU = 'RCCM: n°', FRA = 'Registre de Commerce et du Crédit Mobilier (RCCM): n°';
        TxtFooter2: TextConst ENU = 'Capital Social Initial :', FRA = 'Capital Social Initial :';

    local procedure CalcAgingBandDates();
    begin
        //IF NOT IncludeAgingBand THEN   //commented by HEI.02
        //HEI.03>>
        //IF ReportType = ReportType::Statement THEN  //HEI.02
        //EXIT;
        //HEI.03<<

        if AgingBandEndingDate = 0D then
            ERROR(AgingBandEndErr);
        if FORMAT(PeriodLength) = '' then
            ERROR(AgingBandPeriodErr);
        EVALUATE(PeriodLength2, STRSUBSTNO(PeriodSeparatorLbl, PeriodLength));
        EVALUATE(PeriodLength1, STRSUBSTNO(PeriodLbl, PeriodLength));

        AgingDate[6] := TODAY; //HEI.03
        AgingDate[5] := AgingBandEndingDate;
        AgingDate[4] := CALCDATE(PeriodLength1, AgingDate[5]);
        AgingDate[3] := CALCDATE(PeriodLength2, AgingDate[4]);
        AgingDate[2] := CALCDATE(PeriodLength2, AgingDate[3]);
        AgingDate[1] := CALCDATE(PeriodLength2, AgingDate[2]);
        if AgingDate[2] <= AgingDate[1] then
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
        if EndDate = 0D then
            ERROR(BlankEndDateErr);
        //HEI.02>>
        if StartDate > EndDate then
            ERROR(StartDateLaterTheEndDateErr);
        //HEI.02<<
    end;

    local procedure UpdateBuffer(CurrencyCode: Code[10]; Date: Date; Amount: Decimal; IsDisputed: Boolean; ItemChargeType: Option " ",Tax,Deposit,Discount,Promotion,,ShippingCost);
    var
        GoOn: Boolean;
        I: Integer;
    begin
        if Date < EndDate then begin //HEI.03
            TempAgingBandBuf.INIT();
            TempAgingBandBuf."Currency Code" := CurrencyCode;
            if not TempAgingBandBuf.FIND() then
                TempAgingBandBuf.INSERT();
            I := 1;
            GoOn := true;
            while (I <= 5) and GoOn do begin
                if Date <= AgingDate[I] then
                    if I = 1 then begin
                        //>>HEI.05
                        //TempAgingBandBuf."Column 1 Amt." := TempAgingBandBuf."Column 1 Amt." + Amount;
                        //<<HEI.05
                        //>>HEI.05

                        if ItemChargeType in [ItemChargeType::" "] then begin
                            TempAgingBandBuf."Column 1 Amt." := TempAgingBandBuf."Column 1 Amt." + Amount;
                        end else if ItemChargeType in [ItemChargeType::Deposit] then begin
                            TempAgingBandBuf."Column E1 Amt. FND" := TempAgingBandBuf."Column E1 Amt. FND" + Amount;
                        end;

                        //<<HEI.05
                        GoOn := false;
                    end;
                if Date <= AgingDate[I] then
                    if I = 2 then begin
                        //>>HEI.05
                        //TempAgingBandBuf."Column 2 Amt." := TempAgingBandBuf."Column 2 Amt." + Amount;
                        //<<HEI.05
                        //>>HEI.05

                        if ItemChargeType in [ItemChargeType::" "] then begin
                            TempAgingBandBuf."Column 2 Amt." := TempAgingBandBuf."Column 2 Amt." + Amount;
                        end else if ItemChargeType in [ItemChargeType::Deposit] then begin
                            TempAgingBandBuf."Column E2 Amt. FND" := TempAgingBandBuf."Column E2 Amt. FND" + Amount;
                        end;

                        //<<HEI.05
                        GoOn := false;
                    end;
                if Date <= AgingDate[I] then
                    if I = 3 then begin
                        //>>HEI.05
                        //TempAgingBandBuf."Column 3 Amt." := TempAgingBandBuf."Column 3 Amt." + Amount;
                        //<<HEI.05
                        //>>HEI.05

                        if ItemChargeType in [ItemChargeType::" "] then begin
                            TempAgingBandBuf."Column 3 Amt." := TempAgingBandBuf."Column 3 Amt." + Amount;
                        end else if ItemChargeType in [ItemChargeType::Deposit] then begin
                            TempAgingBandBuf."Column E3 Amt. FND" := TempAgingBandBuf."Column E3 Amt. FND" + Amount;
                        end;

                        //<<HEI.05
                        GoOn := false;
                    end;
                if Date <= AgingDate[I] then
                    if I = 4 then begin
                        //>>HEI.05
                        //TempAgingBandBuf."Column 4 Amt." := TempAgingBandBuf."Column 4 Amt." + Amount;
                        //<<HEI.05
                        //>>HEI.05

                        if ItemChargeType in [ItemChargeType::" "] then begin
                            TempAgingBandBuf."Column 4 Amt." := TempAgingBandBuf."Column 4 Amt." + Amount;
                        end else if ItemChargeType in [ItemChargeType::Deposit] then begin
                            TempAgingBandBuf."Column E4 Amt. FND" := TempAgingBandBuf."Column E4 Amt. FND" + Amount;
                        end;

                        //<<HEI.05
                        GoOn := false;
                    end;
                if Date <= AgingDate[I] then
                    if I = 5 then begin
                        //>>HEI.05
                        //TempAgingBandBuf."Column 5 Amt." := TempAgingBandBuf."Column 5 Amt." + Amount;
                        //<<HEI.05
                        //>>HEI.05

                        if ItemChargeType in [ItemChargeType::" "] then begin
                            TempAgingBandBuf."Column 5 Amt." := TempAgingBandBuf."Column 5 Amt." + Amount;
                        end else if ItemChargeType in [ItemChargeType::Deposit] then begin
                            TempAgingBandBuf."Column E5 Amt. FND" := TempAgingBandBuf."Column E5 Amt. FND" + Amount;
                        end;

                        //<<HEI.05
                        GoOn := false;
                    end;
                I := I + 1;
            end;

            //>>HEI.05
            /*
            IF IsDisputed THEN
              TempAgingBandBuf."Disputed Amt." := TempAgingBandBuf."Disputed Amt." + Amount;
            */
            //<<HEI.05
            //>>HEI.05

            if IsDisputed then begin
                if ItemChargeType in [ItemChargeType::" "] then begin
                    TempAgingBandBuf."Disputed Amt. FND" := TempAgingBandBuf."Disputed Amt. FND" + Amount;
                end else if ItemChargeType in [ItemChargeType::Deposit] then begin
                    TempAgingBandBuf."Disputed EAmt. FND" := TempAgingBandBuf."Disputed EAmt. FND" + Amount;
                end;
            end;

            //<<HEI.05
            TempAgingBandBuf.MODIFY();
            //HEI.03>>
        end else begin
            TempAgingBandBuf2.INIT();
            TempAgingBandBuf2."Currency Code" := CurrencyCode;
            if not TempAgingBandBuf2.FIND() then
                TempAgingBandBuf2.INSERT();

            //>>HEI.05
            //TempAgingBandBuf2."Column 1 Amt." := TempAgingBandBuf2."Column 1 Amt." + Amount;
            //<<HEI.05
            //>>HEI.05

            if ItemChargeType in [ItemChargeType::" "] then begin
                TempAgingBandBuf2."Column 1 Amt." := TempAgingBandBuf2."Column 1 Amt." + Amount;
            end else if ItemChargeType in [ItemChargeType::Deposit] then begin
                TempAgingBandBuf2."Column E1 Amt. FND" := TempAgingBandBuf2."Column E1 Amt. FND" + Amount;
            end;

            //<<HEI.05
            //>>HEI.05
            /*
            IF IsDisputed THEN
              TempAgingBandBuf2."Disputed Amt." := TempAgingBandBuf2."Disputed Amt." + Amount;
            */
            //<<HEI.05
            //>>HEI.05

            if IsDisputed then begin
                if ItemChargeType in [ItemChargeType::" "] then begin
                    TempAgingBandBuf2."Disputed Amt. FND" := TempAgingBandBuf2."Disputed Amt. FND" + Amount;
                end else if ItemChargeType in [ItemChargeType::Deposit] then begin
                    TempAgingBandBuf2."Disputed EAmt. FND" := TempAgingBandBuf2."Disputed EAmt. FND" + Amount;
                end;
            end;

            //<<HEI.05
            TempAgingBandBuf2.MODIFY();
        end;
        //HEI.03<<

    end;

    procedure InitAllParameters(StartDateP: Date; EndDateP: Date; OpenEntriesP: Boolean; NewReportTypeP: Option Full,Liquids,Deposit; PeriodLengthP: DateFormula; DateChoiceP: Option "Due Date","Document Date","Posting Date"; SupportedOutputMethodP: Option Print,Preview,Word,PDF,Email,XML; ChosenOutputMethodP: Integer; PrintRemainingP: Boolean; CustomerNoP: Code[20]);
    begin
        //HEI.01>>
        StartDate := StartDateP;
        EndDate := EndDateP;
        OpenEntries := OpenEntriesP;
        NewReportType := NewReportTypeP;
        PeriodLength := PeriodLengthP;
        DateChoice := DateChoiceP;
        SupportedOutputMethod := SupportedOutputMethodP;
        ChosenOutputMethod := ChosenOutputMethodP;
        PrintRemaining := PrintRemainingP;
        CustomerNo := CustomerNoP;
    end;
}

