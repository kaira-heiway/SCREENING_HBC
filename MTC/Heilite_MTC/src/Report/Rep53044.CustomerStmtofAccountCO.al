report 53044 "Customer Stmt. of Account CO"
{
    // version HEI.04

    // HEI.01 CHG2056933 IBM.KUMARN15 08.05.2020
    //   # New report developed
    // HEI.02 CHG2056933 Defect #5589 IBM GAVANM01 01.09.2020
    //   #code and layout changes as per the defect requests
    // HEI.03 HT1843 - CHG2096439 IBM NASTAA02 08.02.2021 # SL - Customer Statement of Account
    //   # Copied Report 50450 and added new requirements
    //   # Aging for Current/Future should include the 'EndDate' as first date when calculating the amounts, not TODAY
    //   # When Report Type is 'Statement' then the Currency totals should be displayed
    // HEI.04 HT2111 - CHG2105023 IBM NASTAA02 07.04.2021 # Customer Statement of Account Congo
    //   # Copied Report 50467 - Customer Stmt. of Account SL and added new requirements
    // HEI.05 Defect # 6372  IBM NASTAA02 23.06.2021 # OTC Customer statement localization - adjustments
    //   # Layout adjustments
    // HEI.06 Defect # 6377 IBM NASTAA02 08.07.2021 # OTC - Customer statement not showing USD currency - Congo - CHG2105023
    //   # Code added on function "UpdateBuffer"
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID - 50478.
    // 2. Add ApplicationArea and UsageCategory property in report and requestpage fields.
    // 3. Add layout path and Change extension RDLC to RDL.
    // 4. Remove Drink-IT Fields in Dataset columns("Tax Registration No.","Item Charge Type").
    // 5. Remove Drink-IT Record and related code(StandardTextReport: Record "Standard Text Report")
    // 6. Block Language Variable and restructure the related code because language codeunit does not contain the defination of this function GetUserLanguage.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Customer Stmt. of Account CO.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.

    CaptionML = ENU = 'Customer Statement of Account Congo',
                FRA = 'Client – relevé de compte Congo';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(FooterText2; FooterText2)
            {
            }
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
            // column(CompanyTaxNo_Customer; CompanyInfo."Tax Registration No.") // BC Upgrade BHARDA11 ----Drink-IT Field("Tax Registration No.")
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
                DataItemTableView = SORTING("Entry No.") ORDER(Descending);
                column(EntryNo_CustLedgerEntry; "Entry No.")
                {
                }
                column(DocumentType_CustLedgerEntry; "Document Type")
                {
                }
                column(DocumentNo_CustLedgerEntry; "Document No.")
                {
                }
                column(Description_CustLedgerEntry; Description)
                {
                }
                column(Amount_CustLedgerEntry; Amount)
                {
                }
                column(RemainingAmount_CustLedgerEntry; "Remaining Amount")
                {
                }
                column(CLE_Amount; CLE_Amount)
                {
                }
                column(CLE_RemAmount; CLE_RemAmount)
                {
                }
                column(CurrencyCode_CustLedgerEntry; "Currency Code")
                {
                }
                column(DisputeCase_CustLedgerEntry; "Dispute Case FND")
                {
                }
                column(DueDate_CustLedgerEntry; FORMAT("Due Date", 0, '<Day,2>-<Month>-<Year4>'))
                {
                }
                column(DocumentDate_CustLedgerEntry; FORMAT("Document Date", 0, '<Day,2>-<Month>-<Year4>'))
                {
                }
                // column(ItemChargeType_CustLedgerEntry; "Item Charge Type") // BC Upgrade BHARDA11 ----Drink-IT Field("Item Charge Type")
                column(ItemChargeType_CustLedgerEntry; '')
                {
                }
                column(isPayment; isPayment)
                {
                }
                column(WhseDocNo_CustLedgerEntry; WhseDocNo)
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
                column(LineItemChargeTypeCap; LineItemChargeTypeLbl)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    if ("Remaining Amount" = 0)
                      and OpenEntries then  //HEI.02
                        CurrReport.SKIP;

                    NoOfLinesToPrint += 1;

                    if "Currency Code" = '' then
                        "Currency Code" := GLSetup."LCY Code";

                    //HEI.04>>
                    if "Currency Code" = GLSetup."LCY Code" then begin
                        CLE_Amount := ROUND(Amount, 1, '=');
                        CLE_RemAmount := ROUND("Remaining Amount", 1, '=');
                    end else begin
                        CLE_Amount := Amount;
                        CLE_RemAmount := "Remaining Amount";
                    end;
                    //HEI.04<<

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
                        DateChoice::"Due Date":
                            //HEI.04>>
                            //UpdateBuffer("Currency Code", "Due Date", "Remaining Amount","Dispute Case");
                            UpdateBuffer("Currency Code", "Due Date", CLE_RemAmount, "Dispute Case FND");
                        //HEI.04<<
                        //HEI.02<<
                        DateChoice::"Document Date":
                            //HEI.04>>
                            //UpdateBuffer("Currency Code", "Document Date", "Remaining Amount","Dispute Case");
                            UpdateBuffer("Currency Code", "Document Date", CLE_RemAmount, "Dispute Case FND");
                        //HEI.04<<
                        DateChoice::"Posting Date":
                            //HEI.04>>
                            //UpdateBuffer("Currency Code", "Posting Date", "Remaining Amount","Dispute Case");
                            UpdateBuffer("Currency Code", "Posting Date", CLE_RemAmount, "Dispute Case FND");
                    //HEI.04<<
                    end;

                    isPayment := false;
                    if "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::Payment then
                        isPayment := true;
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

                end;
            }
            dataitem(BlankLines; "Integer")
            {
                DataItemTableView = SORTING(Number) ORDER(Ascending);
                column(Number_BlankLines; BlankLines.Number)
                {
                }

                trigger OnPreDataItem();
                begin
                    if NoOfLinesToPrint = 0 then
                        CurrReport.BREAK;

                    SETRANGE(Number, 1, LinesToPrintonOnePage - ((NoOfLinesToPrint + 2 + 4 + (4 * TempAgingBandBuf.COUNT)) mod LinesToPrintonOnePage));
                end;
            }
            dataitem(AgingBand; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
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

                trigger OnAfterGetRecord();
                begin
                    //HEI.03>>
                    AgingBand6_Currency := '';
                    AgingBand6_Amt := 0;
                    AgingBand6_DisputedAmt := 0;
                    //HEI.03<<

                    if Number = 1 then begin
                        if not TempAgingBandBuf.FIND('-') then begin
                            if not TempAgingBandBuf2.FIND('-') then //HEI.03
                                CurrReport.BREAK
                            //HEI.03>>
                            else begin
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
                            end;
                        end else
                            if not TempAgingBandBuf2.GET(TempAgingBandBuf."Currency Code") then begin
                                AgingBand6_Currency := TempAgingBandBuf."Currency Code";
                                AgingBand6_Amt := 0;
                                AgingBand6_DisputedAmt := 0;
                            end else begin
                                AgingBand6_Currency := TempAgingBandBuf2."Currency Code";
                                AgingBand6_Amt := TempAgingBandBuf2."Column 1 Amt.";
                                AgingBand6_DisputedAmt := TempAgingBandBuf2."Disputed Amt. FND";
                            end;
                        //HEI.03<<
                    end else
                        if TempAgingBandBuf.NEXT = 0 then begin
                            if TempAgingBandBuf2.NEXT = 0 then //HEI.03
                                CurrReport.BREAK
                            //HEI.03>>
                            else begin
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
                            end;
                        end else
                            if not TempAgingBandBuf2.GET(TempAgingBandBuf."Currency Code") then begin
                                AgingBand6_Currency := TempAgingBandBuf."Currency Code";
                                AgingBand6_Amt := 0;
                                AgingBand6_DisputedAmt := 0;
                            end else begin
                                AgingBand6_Currency := TempAgingBandBuf2."Currency Code";
                                AgingBand6_Amt := TempAgingBandBuf2."Column 1 Amt.";
                                AgingBand6_DisputedAmt := TempAgingBandBuf2."Disputed Amt. FND";
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
                TempAgingBandBuf.DELETEALL;
                TempAgingBandBuf2.DELETEALL; //HEI.03

                CustCountry := '';
                if CountryRegion.GET("Country/Region Code") then
                    CustCountry := CountryRegion.Name;

                NoOfLinesToPrint := 0;
            end;

            trigger OnPreDataItem();
            var
                // StandardTextReport: Record "Standard Text Report"; // BC Upgrade BHARDA11 ----Drink-IT Table("Standard Text Report")
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
            begin
                VerifyDates;
                AgingBandEndingDate := EndDate;
                CalcAgingBandDates;

                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture, "OpCo Footer image FND", "OpCo Logo FND");
                if CountryRegion.GET(CompanyInfo."Country/Region Code") then
                    CompCountry := CountryRegion.Name;

                GLSetup.GET;

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
                //Footer Text from Report Selection - Standard Text
                FooterText2 := '';
                // BC Upgrade BHARDA11 >> ---_Drink-IT Table(StandardTextReport,"Standard Text Report")
                // StandardTextReport.SETRANGE("Report ID", 50478);
                // StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Footer);
                // if StandardTextReport.FINDSET then
                //     repeat
                //         ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                //         ExtendedTextHeader.SETRANGE("Print on Customer Statement", true);
                //         ExtendedTextHeader.SETRANGE("Language Code", Language.GetUserLanguage);
                //         if not ExtendedTextHeader.FINDFIRST then begin
                //             ExtendedTextHeader.SETRANGE("Language Code");
                //             ExtendedTextHeader.SETRANGE("All Language Codes", true);
                //             if not ExtendedTextHeader.FINDFIRST then
                //                 ExtendedTextHeader.SETRANGE("All Language Codes");
                //         end;
                //         if ExtendedTextHeader.FINDSET then
                //             repeat
                //                 ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                //                 ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                //                 ExtendedTextLine.SETRANGE("Language Code", ExtendedTextHeader."Language Code");
                //                 if ExtendedTextLine.FINDSET then
                //                     repeat
                //                         FooterText2 += ExtendedTextLine.Text + ' ';
                //                     until ExtendedTextLine.NEXT = 0;
                //             until ExtendedTextHeader.NEXT = 0;
                //     until StandardTextReport.NEXT = 0;
                // BC Upgrade BHARDA11 << ---_Drink-IT Table(StandardTextReport,"Standard Text Report")

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

                            case SupportedOutputMethod of
                                SupportedOutputMethod::Print:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPrintOption;
                                SupportedOutputMethod::Preview:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPreviewOption;
                                SupportedOutputMethod::Word:
                                    ChosenOutputMethod := CustomLayoutReporting.GetWordOption;
                                SupportedOutputMethod::PDF:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPDFOption;
                                SupportedOutputMethod::Email:
                                    ChosenOutputMethod := CustomLayoutReporting.GetEmailOption;
                                SupportedOutputMethod::XML:
                                    ChosenOutputMethod := CustomLayoutReporting.GetXMLOption;
                            end;
                        end;
                    }
                    field(ChosenOutput; ChosenOutputMethod)
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
    }

    trigger OnInitReport();
    begin
        EndDate := WORKDATE;
        IncludeAgingBand := true;
        ReportType := ReportType::Both;  //HEI.02
                                         // BC Upgrade BHARDA11 >> ---Restructure  this code because language codeunit does not contain the defination of this function GetUserLanguage 
                                         // if Language.GetUserLanguage() = 'FRA' then
                                         //     EVALUATE(PeriodLength, '30J')
                                         // else if Language.GetUserLanguage() = 'ENU' then
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
        CustDateFilter := FORMAT(StartDate) + '..' + FORMAT(EndDate);
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
        CustomerStatementLbl: TextConst ENU = 'Statement Of Account', FRA = 'Relevé de Compte';
        CompNameLbl: TextConst ENU = 'Company Name', FRA = 'Nom de la société';
        CompAddressLbl: TextConst ENU = 'Address', FRA = 'Adresse';
        CompPostCodeLbl: TextConst ENU = 'Post Code', FRA = 'Code Postal';
        CompCityLbl: TextConst ENU = 'City', FRA = 'Ville';
        CompCountryLbl: TextConst ENU = 'Country', FRA = 'Pays';
        ClientLbl: TextConst ENU = 'CUSTOMER', FRA = 'Client';
        ClientNameLbl: TextConst ENU = 'Customer Name', FRA = 'Nom du client';
        ClientNoLbl: TextConst ENU = 'Customer No.', FRA = 'N° compte client';
        ClientAddressLbl: TextConst ENU = 'Address', FRA = 'Adresse';
        ClientPostCodeLbl: TextConst ENU = 'Post Code', FRA = 'Code Postal';
        ClientCityLbl: TextConst ENU = 'City', FRA = 'Ville';
        ClientCountryLbl: TextConst ENU = 'Country', FRA = 'Pays';
        ClientVATRegNoLbl: TextConst ENU = 'GST Registration No.', FRA = 'N° d''identification TVA';
        CompanyTaxNoLbl: TextConst ENU = 'Company Tax ID', FRA = 'N° fiscal de l''entreprise';
        DateOfDeclLbl: TextConst ENU = 'Date of Declaration', FRA = 'Date de déclaration';
        PageNoLbl: TextConst ENU = 'Page No.', FRA = 'Page N°';
        LineDocumentDateLbl: TextConst ENU = 'Date', FRA = 'Date';
        LineDocumentNoLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        LineDocTypeLbl: TextConst ENU = 'Doc. Type', FRA = 'Nature';
        LineWhseShpmtNoLbl: TextConst ENU = 'Whse. Shpmt. No.', FRA = 'Entrepôt No';
        LineDescriptionLbl: TextConst ENU = 'Description', FRA = 'Description';
        LineAmountLbl: TextConst ENU = 'Doc. Amount', FRA = 'Montant';
        LineCurrencyLbl: TextConst ENU = 'Doc. Currency', FRA = 'Devise';
        LineDueDateLbl: TextConst ENU = 'Payment Due Date', FRA = 'Date d’échéance';
        LineDisputedLbl: TextConst ENU = 'Disputed', FRA = 'Contesté';
        LineAmountPaidLbl: TextConst ENU = 'Partially Paid Amount', FRA = 'Acompte';
        LineUnallocatedAmountLbl: TextConst ENU = 'Unallocated Payment', FRA = 'Non alloué';
        LineBalanceDueLbl: TextConst ENU = 'Balance Due', FRA = 'Solde dû';
        DocCurrSummaryLbl: TextConst ENU = 'Document Currency Summary', FRA = 'Résumé de la monnaie de document';
        AgingSummaryLbl: TextConst ENU = 'Aging Summary', FRA = 'Résumé du vieillissement';
        CurrencyLbl: TextConst ENU = 'Currency', FRA = 'Monnaie';
        AgingTotalLbl: TextConst ENU = 'TOTAL', FRA = 'TOTAL';
        AgingDisputedLbl: TextConst ENU = 'Disputed', FRA = 'Contesté';
        SignatureLbl: TextConst ENU = 'Signature', FRA = 'Signature';
        TempAgingBandBuf2: Record "Aging Band Buffer" temporary;
        CustCountry: Text;
        CompCountry: Text;
        CountryRegion: Record "Country/Region";
        // Language: Record Language;// BC Upgrade BHARDA11 ---Blocked
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
        LineItemChargeTypeLbl: TextConst ENU = 'Item charge type', FRA = 'Type frais annexes';
        FooterText: Text[500];
        TxtFooter: TextConst ENU = 'à capital variable', FRA = 'à capital variable', ENG = 'a capital variable';
        TxtFooter1: TextConst ENU = 'RCCM: n°', FRA = 'Registre de Commerce et du Crédit Mobilier (RCCM): n°';
        TxtFooter2: TextConst ENU = 'Capital Social Initial :', FRA = 'Capital Social Initial :';
        TxtFooter3: Label 'I.N.';
        AgingBand6_Amt: Decimal;
        AgingBand6_DisputedAmt: Decimal;
        AgingBand6_Currency: Code[20];
        FooterText2: Text;
        NotDueLbl: TextConst ENU = 'Not Due', FRA = 'Non échues';
        CLE_Amount: Decimal;
        CLE_RemAmount: Decimal;

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
        AgingCap[6] := NotDueLbl;
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

    local procedure UpdateBuffer(CurrencyCode: Code[10]; Date: Date; Amount: Decimal; IsDisputed: Boolean);
    var
        I: Integer;
        GoOn: Boolean;
    begin
        if Date < EndDate then begin //HEI.03
            TempAgingBandBuf.INIT;
            TempAgingBandBuf."Currency Code" := CurrencyCode;
            if not TempAgingBandBuf.FIND then
                TempAgingBandBuf.INSERT;
            I := 1;
            GoOn := true;
            while (I <= 5) and GoOn do begin
                if Date <= AgingDate[I] then
                    if I = 1 then begin
                        TempAgingBandBuf."Column 1 Amt." := TempAgingBandBuf."Column 1 Amt." + Amount;
                        GoOn := false;
                    end;
                if Date <= AgingDate[I] then
                    if I = 2 then begin
                        TempAgingBandBuf."Column 2 Amt." := TempAgingBandBuf."Column 2 Amt." + Amount;
                        GoOn := false;
                    end;
                if Date <= AgingDate[I] then
                    if I = 3 then begin
                        TempAgingBandBuf."Column 3 Amt." := TempAgingBandBuf."Column 3 Amt." + Amount;
                        GoOn := false;
                    end;
                if Date <= AgingDate[I] then
                    if I = 4 then begin
                        TempAgingBandBuf."Column 4 Amt." := TempAgingBandBuf."Column 4 Amt." + Amount;
                        GoOn := false;
                    end;
                if Date <= AgingDate[I] then
                    if I = 5 then begin
                        TempAgingBandBuf."Column 5 Amt." := TempAgingBandBuf."Column 5 Amt." + Amount;
                        GoOn := false;
                    end;
                I := I + 1;
            end;

            if IsDisputed then
                TempAgingBandBuf."Disputed Amt. FND" := TempAgingBandBuf."Disputed Amt. FND" + Amount;
            TempAgingBandBuf.MODIFY;
            //HEI.03>>
        end else begin
            TempAgingBandBuf2.INIT;
            TempAgingBandBuf2."Currency Code" := CurrencyCode;
            if not TempAgingBandBuf2.FIND then begin
                TempAgingBandBuf2.INSERT;
                //HEI.06>>
                if not TempAgingBandBuf.GET(CurrencyCode) then begin
                    TempAgingBandBuf.INIT;
                    TempAgingBandBuf."Currency Code" := CurrencyCode;
                    TempAgingBandBuf.INSERT;
                end;
                //HEI.06<<
            end;

            TempAgingBandBuf2."Column 1 Amt." := TempAgingBandBuf2."Column 1 Amt." + Amount;

            if IsDisputed then
                TempAgingBandBuf2."Disputed Amt. FND" := TempAgingBandBuf2."Disputed Amt. FND" + Amount;
            TempAgingBandBuf2.MODIFY;
        end;
        //HEI.03<<
    end;
}

