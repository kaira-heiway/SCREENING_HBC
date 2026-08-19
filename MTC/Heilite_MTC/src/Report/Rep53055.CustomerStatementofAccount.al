report 53055 "Customer Statement of Account"
{
    // version HEI.01

    // HEI.01 RFC-CHG0264787 IBM.LS 08.01.2019
    //   # New Report created for Customer - Statement of Account with Aging Summary.
    // HEI.02 Defect #3948 IBM NASTAA02 11.07.2019 # Logo mal positionné
    //   # Company Photo will be displayed based on setup made in General OpCo Setup, Field "Picture Cust Statment of Acc"
    // HEI.03 IBM MATHEJ01 19.08.19 - #CHG2021752 Modified to add new functionalities
    //   # Added new control "Open Entries" in request page
    //   # Created new boolean variable OpenEntries
    //   # Removed caption 'Aging' from "Start Date" and "End Date"
    //   # Modified RDLC design to update the order of the column and added new design for Aging Summary.
    //   # Modified Functions: OnPreReport,Customer - OnAfterGetRecord,Cust. Ledger Entry - OnPreDataItem
    // HEI.04 FDD-HT639 IBM BULIMC01 24.09.2019 #report translated into French
    //     # new condition in RequestPage for AgingIntervals
    // HEI.05 FDD-HB1004 IBM COSTES02  17.02.2020 # New filter on item charge type
    // HEI.06 FDD-FDD-HT639 IBM SURYAS01 20/05/2020
    //   #Created New Column  : "UnAllocatedPayCp" in layout of Aging Summary Table
    // HEI.07 CHG2110861 IBM SAMANR01 21-06-2021
    //   #Created New Column : Original Amount in layout
    // HEI.08 HB2339 - CHG2109497 IBM NASTAA02 12.07.2021 # Customer Statements to be issued automatically at month end
    //   # New Function created "InitAllVariables"
    //   # Code added on "Customer" - OnPreDataItem
    //**************************************//
    //BC UPGRADE ATHUKS01// 
    // 1. Old Report ID - 50225.
    // 2. Add ApplicationArea and UsageCategory property in report and requestpage fields.
    // 3. Commented Drink IT code of ("Item Charge Type").
    // 4. Block Language Variable and restructure the related code because language codeunit does not contain the defination of this function GetUserLanguage.
    // Code is managed with GlobalLanguage method.

    //BC UPGRADE KUMARR78 >>
    //FDD No.-->   FDD-MTC-004
    //GAP Np.--> IBM GAP MTC 71
    //Date - FUT Completeion Date 20-03-2026
    //Create manually customer account statement
    //Adding RequestFields and Filters with tags
    //BC UPGRADE KUMARR78 <<
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Customer Statement of Account.rdl';

    CaptionML = ENU = 'Customer - Statement of Account',
                FRA = 'Client - Relevé de Compte';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = ALL;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");

            // RequestFilterFields = "No.";//BC UPGRADE KUMARR78 Blocking to Add Field
            RequestFilterFields = "No.", "Customer Posting Group", "CM Incl. EG Limit Filter APS";//BC UPGRADE KUMARR78 Adding Field in Reqst Page
            column(PrintAmountsInLCY; PrintAmountsInLCY)
            {
            }
            column(PrintOpCoLogo; PrintOpCoLogo)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(OpCoLogo; CompanyInfo."OpCo Logo FND")
            {
            }
            column(PeriodCustDatetFilter; STRSUBSTNO(Text000, CustDateFilter))
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name + ' ' + CompanyInfo."Name 2")
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_CityPostCode; CompanyInfo.City + ' - ' + CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo_CountryRegionName; CountryRegionNameCompanyInfo)
            {
            }
            column(CompanyInfo_PhoneNo; ': ' + CompanyInfo."Phone No." + ' ' + CompanyInfo."Phone No. 2")
            {
            }
            column(CompanyInfo_EMail; ': ' + CompanyInfo."E-Mail")
            {
            }
            column(AmountCaption; AmountCaption)
            {
            }
            column(RemainingAmtCaption; RemainingAmtCaption)
            {
            }
            column(OrginalAmountCaption; OrginalAmountCaption)
            {
            }
            column(ShowOrginalAmt; PrintOrginalAmt)
            {
            }
            column(Name_Cust; Name + "Name 2")
            {
            }
            column(Address_Cust; Address)
            {
            }
            column(Address2_Cust; "Address 2")
            {
            }
            column(CityPostCode_Cust; City + ' - ' + "Post Code")
            {
            }
            column(CountryRegionName_Cust; CountryRegionNameCust)
            {
            }
            column(Contact_Cust; ': ' + Contact)
            {
            }
            column(PhoneNo_Cust; ': ' + "Phone No.")
            {
            }
            column(EMail_Cust; ': ' + "E-Mail")
            {
            }
            column(No_Cust; ': ' + "No.")
            {
            }
            column(VATRegistrationNo_Cust; ': ' + "VAT Registration No.")
            {
            }
            column(PhoneNoCP; Text005)
            {
            }
            column(EmailIDCp; Text006)
            {
            }
            column(CustNoCp; Text007)
            {
            }
            column(VATRegisNoCp; Text008)
            {
            }
            column(ContactPersonCp; Text009)
            {
            }
            column(StartBalanceLCY; StartBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(StartBalAdjLCY; StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceLCY; CustBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCYAdjLCY; StartBalanceLCY + StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(ReportCaption; ReportCaption)
            {
            }
            column(PageNoCp; Text001)
            {
            }
            column(OfCp; Text002)
            {
            }
            column(AllAmtsLCYCp; Text003)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(BalanceLCYCaption; BalanceLCYCaptionLbl)
            {
            }
            column(AdjOpeningBalCaption; AdjOpeningBalCaptionLbl)
            {
            }
            column(OpeningBalCaption; OpeningBalCaptionLbl)
            {
            }
            column(ReportType; ReportType)
            {
            }
            column(AgingInterval; AgingInterval)
            {
            }
            column(AgingPeriod_1; AgingPeriodRange[1])
            {
            }
            column(AgingPeriod_2; AgingPeriodRange[2])
            {
            }
            column(AgingPeriod_3; AgingPeriodRange[3])
            {
            }
            column(AgingPeriod_4; AgingPeriodRange[4])
            {
            }
            column(AgingPeriod_5; AgingPeriodRange[5])
            {
            }
            column(DisputeCaseCp; Text010)
            {
            }
            column(InvoicesCp; Text011)
            {
            }
            column(CreditMemoCp; Text012)
            {
            }
            column(UnAllocatedPayCp; Text013)
            {
            }
            column(LineAmountCp; Text014)
            {
            }
            column(SummaryCp; Text015)
            {
            }
            column(AgingPeriodCp; STRSUBSTNO(Text019, AgingInterval))
            {
            }
            column(TotalAmountCp; Text020)
            {
            }
            column(DisputedAmt_1; DisputedAmt[1])
            {
            }
            column(DisputedAmt_2; DisputedAmt[2])
            {
            }
            column(DisputedAmt_3; DisputedAmt[3])
            {
            }
            column(DisputedAmt_4; DisputedAmt[4])
            {
            }
            column(DisputedAmt_5; DisputedAmt[5])
            {
            }
            column(DisputedAmt_Total; DisputedAmt[6])
            {
            }
            column(DebitAmt_1; DebitAmt[1])
            {
            }
            column(DebitAmt_2; DebitAmt[2])
            {
            }
            column(DebitAmt_3; DebitAmt[3])
            {
            }
            column(DebitAmt_4; DebitAmt[4])
            {
            }
            column(DebitAmt_5; DebitAmt[5])
            {
            }
            column(DebitAmt_Total; DebitAmt[6])
            {
            }
            column(CreditAmt_1; CreditAmt[1])
            {
            }
            column(CreditAmt_2; CreditAmt[2])
            {
            }
            column(CreditAmt_3; CreditAmt[3])
            {
            }
            column(CreditAmt_4; CreditAmt[4])
            {
            }
            column(CreditAmt_5; CreditAmt[5])
            {
            }
            column(CreditAmt_Total; CreditAmt[6])
            {
            }
            column(UnAlloPaymtAmt_1; UnAlloPaymtAmt[1])
            {
            }
            column(UnAlloPaymtAmt_2; UnAlloPaymtAmt[2])
            {
            }
            column(UnAlloPaymtAmt_3; UnAlloPaymtAmt[3])
            {
            }
            column(UnAlloPaymtAmt_4; UnAlloPaymtAmt[4])
            {
            }
            column(UnAlloPaymtAmt_5; UnAlloPaymtAmt[5])
            {
            }
            column(UnAlloPaymtAmt_Total; UnAlloPaymtAmt[6])
            {
            }
            column(LineAmt_1; LineAmt[1])
            {
            }
            column(LineAmt_2; LineAmt[2])
            {
            }
            column(LineAmt_3; LineAmt[3])
            {
            }
            column(LineAmt_4; LineAmt[4])
            {
            }
            column(LineAmt_5; LineAmt[5])
            {
            }
            column(LineAmt_Total; LineAmt[6])
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", "Posting Date");
                column(PostDate_CustLedgEntry; FORMAT("Posting Date"))
                {
                }
                column(DocType_CustLedgEntry; "Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocNo_CustLedgEntry; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_CustLedgEntry; Description)
                {
                    IncludeCaption = true;
                }
                column(DisputeCase; DisputeCase)
                {
                }
                column(CustCurrencyCode; CustCurrencyCode)
                {
                }
                column(CustAmount; CustAmount)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(OriginalAmt; OriginalAmt)
                {
                }
                column(CustRemainAmount; CustRemainAmount)
                {
                }
                column(CustBalanceLCY1; CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(CustEntryDueDate; FORMAT(CustEntryDueDate))
                {
                }
                column(EntryNo_CustLedgEntry; "Entry No.")
                {
                    IncludeCaption = true;
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Cust. Ledger Entry No.", "Entry Type", "Posting Date") WHERE("Entry Type" = FILTER("Appln. Rounding" | "Correction of Remaining Amount"));
                    column(EntryType_DtldCustLedgEntry; FORMAT("Entry Type"))
                    {
                    }
                    column(Correction; Correction)
                    {
                        AutoFormatType = 1;
                    }
                    column(CustBalanceLCY2; CustBalanceLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(ApplicationRounding; ApplicationRounding)
                    {
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        //HEI.01>>
                        case "Entry Type" of
                            "Entry Type"::"Appln. Rounding":
                                ApplicationRounding := ApplicationRounding + "Amount (LCY)";

                            "Entry Type"::"Correction of Remaining Amount":
                                Correction := Correction + "Amount (LCY)";
                        end;
                        CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                        //HEI.01<<
                    end;

                    trigger OnPreDataItem();
                    begin
                        //HEI.01>>
                        if CustDateFilter <> '' then
                            SETFILTER("Posting Date", CustDateFilter);
                        Correction := 0;
                        ApplicationRounding := 0;
                        //HEI.01<<
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    //HEI.01>>
                    CALCFIELDS(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)", "Dispute Case FND");
                    // >>HEI.07
                    CALCFIELDS("Original Amount", "Original Amt. (LCY)");
                    // <<HEI.07

                    CustLedgEntryExists := true;

                    if "Dispute Case FND" then
                        DisputeCase := 'Yes'
                    else
                        DisputeCase := '';

                    if PrintAmountsInLCY then begin
                        CustAmount := "Amount (LCY)";
                        // >>HEI.07
                        if PrintOrginalAmt = true then
                            OriginalAmt := "Original Amt. (LCY)"
                        else
                            OriginalAmt := 0;
                        // <<HEI.07
                        CustRemainAmount := "Remaining Amt. (LCY)";
                        CustCurrencyCode := '';
                    end else begin
                        CustAmount := Amount;
                        // >>HEI.07
                        if PrintOrginalAmt = true then
                            OriginalAmt := "Original Amount"
                        else
                            OriginalAmt := 0;
                        // <<HEI.07
                        CustRemainAmount := "Remaining Amount";
                        CustCurrencyCode := "Currency Code";
                    end;
                    CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";

                    if ("Document Type" = "Document Type"::Payment) or ("Document Type" = "Document Type"::Refund) then
                        CustEntryDueDate := 0D
                    else
                        CustEntryDueDate := "Due Date";

                    CustRemainAmountTot += CustRemainAmount;
                    //HEI.01<<
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.03>>
                    if OpenEntries then
                        SETRANGE(Open, true);
                    //HEI.03<<
                    //HEI.01>>
                    if CustDateFilter <> '' then
                        SETFILTER("Posting Date", CustDateFilter);
                    //CurrReport.CREATETOTALS(CustAmount, "Amount (LCY)");
                    CustLedgEntryExists := false;
                    //BC UPGRADE ATHUKS01 >>  Drink IT field 
                    //HEI.05>>
                    // if (Customer.GETFILTER("Item Charge Type Filter") <> '') then
                    //     SETFILTER("Item Charge Type", Customer.GETFILTER("Item Charge Type Filter"));
                    //HEI.05<<
                    //HEI.01<<
                    //BC UPGRADE ATHUKS01 << Drink IT field 

                    //BC UPGRADE KUMARR78 >> Adding Filter(Replacing "Item Charge Type with "CM Incl. EG. Lim. Warn APS")("Item Charge Type Filter" with "CM Incl. EG Limit Filter APS")
                    if (Customer.GETFILTER("CM Incl. EG Limit Filter APS") <> '') then
                        SETFILTER("CM Incl. EG. Lim. Warn APS", Customer.GETFILTER("CM Incl. EG Limit Filter APS"));
                    //BC UPGRADE KUMARR78 << Adding Filter

                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(CustWiseTotal; Text025)
                {
                }
                column(CustBalStBalStBalAdjLCY; CustBalanceLCY - StartBalanceLCY - StartBalAdjLCY)
                {
                    AutoFormatType = 1;
                }
                column(CustRemainAmountTot; CustRemainAmountTot)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    //HEI.01>>
                    if not CustLedgEntryExists and (StartBalanceLCY = 0) then begin
                        StartBalanceLCY := 0;
                        CurrReport.SKIP();
                    end;
                    //HEI.01<<
                end;
            }

            trigger OnAfterGetRecord();
            var
                CountryRegionCust: Record "Country/Region";
            begin
                //HEI.01>>
                CLEAR(CountryRegionNameCust);
                if CountryRegionCust.GET("Country/Region Code") then
                    CountryRegionNameCust := CountryRegionCust.Name;

                CLEAR(DisputeCase);
                CustRemainAmountTot := 0;
                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                if CustDateFilter <> '' then begin
                    if AgingStartDate <> 0D then begin
                        SETRANGE("Date Filter", 0D, AgingStartDate - 1);
                        CALCFIELDS("Net Change (LCY)");
                        StartBalanceLCY := "Net Change (LCY)";
                    end;
                    SETFILTER("Date Filter", CustDateFilter);
                    CALCFIELDS("Net Change (LCY)");
                    StartBalAdjLCY := "Net Change (LCY)";

                    CustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date");
                    CustLedgEntry.SETRANGE("Customer No.", "No.");
                    CustLedgEntry.SETFILTER("Posting Date", CustDateFilter);
                    //BC UPGRADE ATHUKS01 >>  Drink IT field 
                    //HEI.05>>
                    //  if (Customer.GETFILTER("Item Charge Type Filter") <> '') then
                    //    CustLedgEntry.SETFILTER("Item Charge Type", Customer.GETFILTER("Item Charge Type Filter"));
                    //HEI.05<<
                    //BC UPGRADE ATHUKS01 <<  Drink IT field 

                    //BC UPGRADE KUMARR78 >> Adding Filter(Replacing "Item Charge Type with "CM Incl. EG. Lim. Warn APS")("Item Charge Type Filter" with "CM Incl. EG Limit Filter APS")
                    if (Customer.GETFILTER("CM Incl. EG Limit Filter APS") <> '') then
                        CustLedgEntry.SETFILTER("CM Incl. EG. Lim. Warn APS", Customer.GETFILTER("CM Incl. EG Limit Filter APS"));
                    //BC UPGRADE KUMARR78 << Adding Filter


                    if CustLedgEntry.FIND('-') then
                        repeat
                            CustLedgEntry.SETFILTER("Date Filter", CustDateFilter);
                            CustLedgEntry.CALCFIELDS("Amount (LCY)");
                            StartBalAdjLCY := StartBalAdjLCY - CustLedgEntry."Amount (LCY)";
                            "Detailed Cust. Ledg. Entry".SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                            "Detailed Cust. Ledg. Entry".SETRANGE("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                            "Detailed Cust. Ledg. Entry".SETFILTER("Entry Type", '%1|%2',
                            "Detailed Cust. Ledg. Entry"."Entry Type"::"Correction of Remaining Amount",
                            "Detailed Cust. Ledg. Entry"."Entry Type"::"Appln. Rounding");
                            "Detailed Cust. Ledg. Entry".SETFILTER("Posting Date", CustDateFilter);
                            if "Detailed Cust. Ledg. Entry".FIND('-') then
                                repeat
                                    StartBalAdjLCY := StartBalAdjLCY - "Detailed Cust. Ledg. Entry"."Amount (LCY)";
                                until "Detailed Cust. Ledg. Entry".NEXT() = 0;
                            "Detailed Cust. Ledg. Entry".RESET();
                        until CustLedgEntry.NEXT() = 0;

                end;

                if (ReportType <> ReportType::Statement) and PrintAmountsInLCY then begin
                    CLEAR(DisputedAmt);
                    CLEAR(DebitAmt);
                    CLEAR(CreditAmt);
                    CLEAR(UnAlloPaymtAmt);
                    CLEAR(LineAmt);
                    AgingCustLedgEntry.RESET();
                    AgingCustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date");
                    AgingCustLedgEntry.SETRANGE("Customer No.", "No.");
                    //BC UPGRADE ATHUKS01 >>  Drink IT field 
                    //HEI.05>>
                    //if (Customer.GETFILTER("Item Charge Type Filter") <> '') then
                    //    AgingCustLedgEntry.SETFILTER("Item Charge Type", Customer.GETFILTER("Item Charge Type Filter"));
                    //HEI.05<<
                    //BC UPGRADE KUMARR78 >> Adding Filter(Replacing "Item Charge Type with "CM Incl. EG. Lim. Warn APS")("Item Charge Type Filter" with "CM Incl. EG Limit Filter APS")
                    if (Customer.GETFILTER("CM Incl. EG Limit Filter APS") <> '') then
                        AgingCustLedgEntry.SETFILTER("CM Incl. EG. Lim. Warn APS", Customer.GETFILTER("CM Incl. EG Limit Filter APS"));
                    //BC UPGRADE KUMARR78 << Adding Filter//BC UPGRADE ATHUKS01 <<  Drink IT field 


                    for AgingDataLoop := 1 to RowCount do begin
                        AgingCustLedgEntry.SETFILTER("Posting Date", AgingPeriodFilter[AgingDataLoop]);
                        AgingCustLedgEntry.SETRANGE("Dispute Case FND", true);
                        AgingCustLedgEntry.SETRANGE("Document Type", AgingCustLedgEntry."Document Type"::Invoice);
                        if AgingCustLedgEntry.FIND('-') then
                            repeat
                                AgingCustLedgEntry.CALCFIELDS("Remaining Amt. (LCY)");
                                DisputedAmt[AgingDataLoop] := DisputedAmt[AgingDataLoop] + AgingCustLedgEntry."Remaining Amt. (LCY)";
                            until AgingCustLedgEntry.NEXT() = 0;


                        AgingCustLedgEntry.SETRANGE("Dispute Case FND", false);
                        AgingCustLedgEntry.SETFILTER("Document Type", '<>%1', AgingCustLedgEntry."Document Type"::Payment);
                        if AgingCustLedgEntry.FIND('-') then
                            repeat
                                AgingCustLedgEntry.CALCFIELDS("Remaining Amt. (LCY)");
                                if AgingCustLedgEntry."Remaining Amt. (LCY)" < 0 then
                                    CreditAmt[AgingDataLoop] := CreditAmt[AgingDataLoop] + AgingCustLedgEntry."Remaining Amt. (LCY)"
                                else
                                    DebitAmt[AgingDataLoop] := DebitAmt[AgingDataLoop] + AgingCustLedgEntry."Remaining Amt. (LCY)";
                            until AgingCustLedgEntry.NEXT() = 0;


                        AgingCustLedgEntry.SETRANGE("Dispute Case FND", false);
                        AgingCustLedgEntry.SETRANGE("Document Type", AgingCustLedgEntry."Document Type"::Payment);
                        if AgingCustLedgEntry.FIND('-') then
                            repeat
                                AgingCustLedgEntry.CALCFIELDS("Remaining Amt. (LCY)");
                                UnAlloPaymtAmt[AgingDataLoop] := UnAlloPaymtAmt[AgingDataLoop] + AgingCustLedgEntry."Remaining Amt. (LCY)";
                            until AgingCustLedgEntry.NEXT() = 0;


                        LineAmt[AgingDataLoop] := DisputedAmt[AgingDataLoop] + DebitAmt[AgingDataLoop] +
                                                  CreditAmt[AgingDataLoop] + UnAlloPaymtAmt[AgingDataLoop];
                        //HEI.03>>
                        //DisputedAmt[5] += DisputedAmt[AgingDataLoop];
                        //DebitAmt[5] += DebitAmt[AgingDataLoop];
                        //CreditAmt[5] += CreditAmt[AgingDataLoop];
                        //UnAlloPaymtAmt[5] += UnAlloPaymtAmt[AgingDataLoop];
                        //LineAmt[5] += LineAmt[AgingDataLoop];
                        DisputedAmt[6] += DisputedAmt[AgingDataLoop];
                        DebitAmt[6] += DebitAmt[AgingDataLoop];
                        CreditAmt[6] += CreditAmt[AgingDataLoop];
                        UnAlloPaymtAmt[6] += UnAlloPaymtAmt[AgingDataLoop];
                        LineAmt[6] += LineAmt[AgingDataLoop];
                        //HEI.03<<
                    end;
                end;

                CurrReport.PRINTONLYIFDETAIL := (StartBalanceLCY = 0);
                CustBalanceLCY := StartBalanceLCY + StartBalAdjLCY;
                //HEI.03>>
                //IF (ReportType = ReportType::Ageing) AND (LineAmt[5] = 0) THEN
                if (ReportType = ReportType::Ageing) and (LineAmt[6] = 0) then
                    //HEI.03<<
                    CurrReport.SKIP();
                //HEI.01<<
            end;

            trigger OnPreDataItem();
            begin
                //BC UPGRADE ATHUKS01 >>  ReportSUM
                //HEI.01>>
                //CurrReport.CREATETOTALS("Cust. Ledger Entry"."Amount (LCY)", StartBalanceLCY, StartBalAdjLCY, Correction, ApplicationRounding);
                //HEI.01<<
                //BC UPGRADE ATHUKS01 <<  ReportSUM 
                //HEI.08>>
                if CustomerNo <> '' then
                    SETRANGE("No.", CustomerNo);
                //HEI.08<<
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
                    field(PrintAmountsInLCY; PrintAmountsInLCY)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Show Amounts in LCY',
                                    FRA = 'Afficher montants DS';
                        ToolTipML = ENU = 'Specifies if the reported amounts are shown in the local currency.',
                                    FRA = 'Indique s''il faut afficher les montants déclarés dans la devise locale.';
                    }
                    field(PrintOrginalAmt; PrintOrginalAmt)
                    {
                        Caption = 'Show Original Amount';
                        ApplicationArea = all;
                        ToolTip = 'Show Original Amount';
                    }
                    field(PrintOpCoLogo; PrintOpCoLogo)
                    {
                        CaptionML = ENU = 'Print OpCo Logo',
                                    FRA = 'Imprimer Logo OpCo';
                        ApplicationArea = all;
                        ToolTip = 'PrintOpCoLogo';

                    }
                    field(ReportType; ReportType)
                    {
                        CaptionML = ENU = 'Report Type',
                                    FRA = 'Type de rapport';
                        ApplicationArea = all;
                        ToolTip = 'ReportType';

                    }
                    field(AgingStartDate; AgingStartDate)
                    {
                        CaptionML = ENU = 'Start Date',
                                    FRA = 'Date de début balance âgée';
                        ApplicationArea = all;
                        ToolTip = 'AgingStartDate';
                    }
                    field(AgingEndDate; AgingEndDate)
                    {
                        CaptionML = ENU = 'End Date',
                                    FRA = 'Date de fin balance âgée';
                        ApplicationArea = all;
                        ToolTip = 'AgingEndDate';

                    }
                    field(AgingInterval; AgingInterval)
                    {
                        CaptionML = ENU = 'Aging Interval',
                                    FRA = 'Intervalle balance âgée';
                        ApplicationArea = all;
                        ToolTip = 'AgingInterval';


                        trigger OnValidate();
                        begin
                            //HEI.01>>
                            if (ReportType <> ReportType::Statement) and PrintAmountsInLCY then begin
                                EVALUATE(Value, FORMAT(COPYSTR(FORMAT(AgingInterval), 1, STRLEN(FORMAT(AgingInterval)) - 1)));
                                Factor := DELSTR(FORMAT(AgingInterval), 1, STRLEN(FORMAT(AgingInterval)) - 1);
                                //HEI.04<<
                                //BC UPGRADE ATHUKS01>>
                                //if LanguageR.Code = 'FRA' then
                                if GlobalLanguage() = 1036 then //FRA
                                                                //BC UPGRADE ATHUKS01<<
                                    if not (Factor in ['J', 'JS', 'S', 'T', 'A', 'M']) then
                                        ERROR(Text021, Value)
                                    else
                                        If Value = 0 then
                                            ERROR(Text022Lbl, Value)
                                        else
                                            //HEI.04>>
                                            if not (Factor in ['D', 'M', 'Y']) then
                                                ERROR(Text021, Value)
                                            else
                                                if Value = 0 then
                                                    ERROR(Text022Lbl, Value);
                            end else
                                ERROR(Text023);
                            //HEI.01<<
                        end;
                    }
                    field("Open Entries"; OpenEntries)
                    {
                        CaptionML = ENU = 'Open Entries',
                                    FRA = 'Écritures ouvertes';
                        ApplicationArea = all;
                        ToolTip = 'Open Entries';

                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            //HEI.01>>
            CLEAR(AgingInterval);
            //HEI.01<<
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        //HEI.01>>
        ClearAllVariables();
        //HEI.01<<
    end;

    trigger OnPreReport();
    var
        //BC UPGRADE ATHUKS01 >>     
        // CaptionManagement: Codeunit CaptionManagement;
        //BC UPGRADE ATHUKS01 <<  
        CountryRegionCompnyInfo: Record "Country/Region";
        CustLedgEntryL: Record "Cust. Ledger Entry";
    begin
        //HEI.01>>
        if (ReportType <> ReportType::Statement) and (FORMAT(AgingInterval) = '') then
            ERROR(Text024);

        CompanyInfo.GET();
        if PrintOpCoLogo then
            CompanyInfo.CALCFIELDS("OpCo Logo FND")
        else
            CompanyInfo.CALCFIELDS(Picture);

        CLEAR(CountryRegionNameCompanyInfo);
        if CountryRegionCompnyInfo.GET(CompanyInfo."Country/Region Code") then
            CountryRegionNameCompanyInfo := CountryRegionCompnyInfo.Name;
        //BC UPGRADE ATHUKS01 >>   
        // CustFilter := CaptionManagement.GetRecordFiltersWithCaptions(Customer);
        CustFilter := Customer.GetFilters();
        //BC UPGRADE ATHUKS01 <<   

        if (AgingStartDate <> 0D) and (AgingEndDate <> 0D) then
            CustDateFilter := FORMAT(AgingStartDate) + '..' + FORMAT(AgingEndDate)
        else if (AgingStartDate <> 0D) and (AgingEndDate = 0D) then begin
            CustDateFilter := FORMAT(AgingStartDate)
        end else if (AgingStartDate = 0D) and (AgingEndDate <> 0D) then begin
            if CustLedgEntryL.FINDFIRST() then
                AgingStartDate := CustLedgEntryL."Posting Date"
            else if AgingEndDate >= TODAY then
                AgingStartDate := TODAY
            else if AgingEndDate >= WORKDATE then
                AgingStartDate := WORKDATE()
            else
                AgingStartDate := DMY2DATE(1, 1, 2000);
            CustDateFilter := FORMAT(AgingStartDate) + '..' + FORMAT(AgingEndDate);
        end else if (AgingStartDate = 0D) and (AgingEndDate = 0D) then begin
            if CustLedgEntryL.FINDFIRST() then
                AgingStartDate := CustLedgEntryL."Posting Date"
            else
                AgingStartDate := DMY2DATE(1, 1, 2000);
            AgingEndDate := DMY2DATE(31, 12, 9999);
            CustDateFilter := FORMAT(AgingStartDate) + '..';
        end;

        //with "Cust. Ledger Entry" do
        if PrintAmountsInLCY then begin
            AmountCaption := "Cust. Ledger Entry".FIELDCAPTION("Amount (LCY)");
            RemainingAmtCaption := "Cust. Ledger Entry".FIELDCAPTION("Remaining Amt. (LCY)");
            // >>HEI.07
            if PrintOrginalAmt then
                OrginalAmountCaption := "Cust. Ledger Entry".FIELDCAPTION("Original Amt. (LCY)")
            else
                OrginalAmountCaption := '';
            // <<HEI.07
        end else begin
            AmountCaption := "Cust. Ledger Entry".FIELDCAPTION(Amount);
            RemainingAmtCaption := "Cust. Ledger Entry".FIELDCAPTION("Remaining Amount");
            // >>HEI.07
            if PrintOrginalAmt then
                OrginalAmountCaption := "Cust. Ledger Entry".FIELDCAPTION("Original Amount")
            else
                OrginalAmountCaption := '';
            // <<HEI.07
        end;

        case ReportType of
            ReportType::Both:
                ReportCaption := Text017;
            ReportType::Statement:
                ReportCaption := Text016;
            ReportType::Ageing:
                ReportCaption := Text018;
        end;

        if (ReportType <> ReportType::Statement) and PrintAmountsInLCY then begin
            AgingPeriod[1] := AgingStartDate;
            //HEI.03>>
            //AgingPeriod[6] := AgingEndDate;
            AgingPeriod[7] := AgingEndDate;

            //FOR i := 2 TO 5 DO BEGIN
            for i := 2 to 6 do begin
                //HEI.03<<
                k := 0;
                RowCount += 1;
                AgingPeriod[i] := CALCDATE(AgingInterval, (AgingPeriod[i - 1]));
                //HEI.03>>
                //IF AgingPeriod[i] <= AgingPeriod[6] THEN BEGIN
                if AgingPeriod[i] <= AgingPeriod[7] then begin
                    //HEI.03<<
                    AgingPeriodFilter[RowCount] := FORMAT(AgingPeriod[i - 1]) + '..' + FORMAT(AgingPeriod[i] - 1);
                    //HEI.03>>
                    //AgingIntervalRange[i-1] := '  (' + FORMAT((Value*(i-2))+1) + '..' + (FORMAT(Value*(i-1)) + Factor) + ')';
                    //AgingPeriodRange[i-1] := AgingPeriodFilter[RowCount] + AgingIntervalRange[i-1];
                    AgingIntervalRange[i - 1] := FORMAT((Value * (i - 2)) + 1) + '..' + (FORMAT(Value * (i - 1)) + Factor);
                    AgingPeriodRange[i - 1] := AgingIntervalRange[i - 1];
                    //HEI.03<<
                end else begin
                    j := i;
                    //HEI.03>>
                    //i := 5;
                    i := 6;
                    AgingPeriodRange[i - 1] := '>' + (FORMAT(Value * (i - 2)) + Factor);
                    //HEI.03<<
                end;
                //HEI.03>>
                //IF i = 5 THEN BEGIN
                if i = 6 then begin
                    //HEI.03<<
                    if (i = j) or (j = 0) then begin
                        //HEI.03>>
                        //IF (AgingPeriod[6] <> 0D) AND (AgingPeriod[i-1] <> 0D) THEN
                        //k := AgingPeriod[6] - AgingPeriod[i-1] + 1;
                        if (AgingPeriod[7] <> 0D) and (AgingPeriod[i - 1] <> 0D) then
                            k := AgingPeriod[7] - AgingPeriod[i - 1] + 1;
                        //HEI.03<<
                        if k = 0 then
                            k := 1;
                    end;
                    if j <> 0 then begin
                        if i = j then begin
                            //HEI.03>>
                            //IF AgingPeriod[i-1] <= AgingPeriod[6] THEN BEGIN
                            //AgingPeriodFilter[RowCount] := FORMAT(AgingPeriod[i-1]) + '...' + FORMAT(AgingPeriod[6]);
                            //AgingPeriodRange[i-1] := AgingPeriodFilter[RowCount] + '  (' + FORMAT(k) + 'D)';
                            if AgingPeriod[i - 1] <= AgingPeriod[7] then begin
                                AgingPeriodFilter[RowCount] := FORMAT(AgingPeriod[i - 1]) + '...' + FORMAT(AgingPeriod[7]);
                                AgingPeriodRange[i - 1] := '>' + (FORMAT(Value * (i - 2)) + Factor);
                                //HEI.03<<
                            end;
                        end else begin
                            //HEI.03>>
                            //IF (AgingPeriod[6] <> 0D) AND (AgingPeriod[j-1] <> 0D) THEN
                            //k := AgingPeriod[6] - AgingPeriod[j-1] + 1;
                            if (AgingPeriod[7] <> 0D) and (AgingPeriod[j - 1] <> 0D) then
                                k := AgingPeriod[7] - AgingPeriod[j - 1] + 1;
                            //HEI.03<<
                            if k = 0 then
                                k := 1;
                            //HEI.03>>
                            //IF AgingPeriod[i-j] <= AgingPeriod[6] THEN BEGIN
                            //AgingPeriodFilter[RowCount] := FORMAT(AgingPeriod[j-1]) + '..' + FORMAT(AgingPeriod[6]);
                            //AgingPeriodRange[j-1] := AgingPeriodFilter[RowCount] + '  (' + FORMAT(k) + 'D)';
                            if AgingPeriod[i - j] <= AgingPeriod[7] then begin
                                AgingPeriodFilter[RowCount] := FORMAT(AgingPeriod[j - 1]) + '..' + FORMAT(AgingPeriod[7]);
                                AgingPeriodRange[j - 1] := '>' + (FORMAT(Value * (j - 2)) + Factor);
                                //HEI.03<<
                            end;
                        end;
                    end else begin
                        //HEI.03>>
                        //IF (AgingPeriod[i] - 1) <= AgingPeriod[6] THEN BEGIN
                        //AgingPeriodFilter[RowCount] := FORMAT(AgingPeriod[i-1]) + '..' + FORMAT(AgingPeriod[6]);
                        //AgingPeriodRange[i-1] := AgingPeriodFilter[RowCount] + '  (' + FORMAT(k) + 'D)';
                        if (AgingPeriod[i] - 1) <= AgingPeriod[7] then begin
                            AgingPeriodFilter[RowCount] := FORMAT(AgingPeriod[i - 1]) + '..' + FORMAT(AgingPeriod[7]);
                            AgingPeriodRange[i - 1] := '>' + (FORMAT(Value * (i - 2)) + Factor);
                            //HEI.03<<
                        end;
                        //HEI.03>>
                        //IF AgingPeriod[6] = DMY2DATE(31,12,9999) THEN BEGIN
                        if AgingPeriod[7] = DMY2DATE(31, 12, 9999) then begin
                            //HEI.03<<
                            AgingPeriodFilter[RowCount] := FORMAT(AgingPeriod[i - 1]) + '..';
                            AgingPeriodRange[i - 1] := AgingPeriodFilter[RowCount];
                        end;
                    end;
                end;
            end;
            //end;
            //HEI.01<<
        end;
    end;

    var
        Text000: TextConst ENU = 'Period: %1', FRA = 'Période : %1';
        CustLedgEntry: Record "Cust. Ledger Entry";
        PrintAmountsInLCY: Boolean;
        CustFilter: Text;
        CustDateFilter: Text;
        AmountCaption: Text[80];
        RemainingAmtCaption: Text[30];
        CustAmount: Decimal;
        CustRemainAmount: Decimal;
        CustBalanceLCY: Decimal;
        CustCurrencyCode: Code[10];
        CustEntryDueDate: Date;
        StartBalanceLCY: Decimal;
        StartBalAdjLCY: Decimal;
        Correction: Decimal;
        ApplicationRounding: Decimal;
        CustLedgEntryExists: Boolean;
        Text001: TextConst ENU = 'Page: ', FRA = 'Page:';
        Text002: TextConst ENU = 'of ', FRA = 'of ';
        Text003: TextConst ENU = 'All amounts are in LCY', FRA = 'Tous les montants sont en DS';
        Text004: Label 'Select to get OpCo Logo';
        Text005: TextConst ENU = 'Phone No.', FRA = 'N° de téléphone';
        Text006: Label 'E-Mail ID';
        Text007: TextConst ENU = 'Customer No.', FRA = 'N° de client';
        Text008: TextConst ENU = 'VAT Registration No.', FRA = 'Numéro d''enregistrement TVA';
        Text009: TextConst ENU = 'Contact Person', FRA = 'Contact';
        Text010: TextConst ENU = 'Disputed', FRA = 'Contesté';
        Text011: Label 'Debit';
        Text012: Label 'Credit';
        Text013: TextConst ENU = 'Un-Allocated Payment', FRA = 'Paiements non lettrés';
        Text014: TextConst ENU = 'Amount (LCY)', FRA = 'Montant';
        Text015: TextConst ENU = 'Aging Summary:', FRA = 'Résumé âgée:';
        Text016: TextConst ENU = 'Customer - Statement of Account', FRA = 'Client - Relevé de compte';
        Text017: TextConst ENU = 'Customer - Statement of Account with Aging Summary ', FRA = 'Client - Relevé de compte';
        Text018: TextConst ENU = 'Customer - Aging Summary', FRA = 'Client - Relevé de compte';
        Text019: TextConst ENU = 'Aging Periods by %1 Interval', FRA = 'Périodes âgée par %1 Intervalle';
        Text020: TextConst ENU = 'Total Amount', FRA = 'Montant Total';
        Text021: TextConst ENU = 'Please enter the correct Unit after Aging Interval Number %1.\ i.e. Unit = D or M or Y', FRA = 'Please enter the correct Unit after Aging Interval Number %1.\ i.e. Unit = J or M or A';
        Text022Lbl: Label 'Please enter the correct Interval number that should be more than Zero (0).';
        Text023: Label 'You cannot alow to enter Aging Interval for only to get the Statement.';
        Text024: Label 'Please enter the Aging Interval to get the Aging Summary in the report.';
        Text025: Label 'Total :';
        Text026: TextConst ENU = 'Phone No.', FRA = 'Téléphone';
        RemainingAmtLbl: TextConst ENU = 'Remaining Amt. (LCY)', FRA = 'Montant ouvert';
        PostingDateCaptionLbl: TextConst ENU = 'Posting Date', FRA = 'Date comptabilis.';
        DueDateCaptionLbl: TextConst ENU = 'Due Date', FRA = 'Date d''échéance';
        BalanceLCYCaptionLbl: TextConst ENU = 'Balance (LCY)', FRA = 'Solde';
        OpeningBalCaptionLbl: TextConst ENU = 'Opening Balance', FRA = 'Solde d''Ouverture';
        AdjOpeningBalCaptionLbl: TextConst ENU = 'Adj. of Opening Balance', FRA = 'Ajust. solde d''ouverture';
        CompanyInfo: Record "Company Information";
        CountryRegionNameCompanyInfo: Text[50];
        CountryRegionNameCust: Text[50];
        DisputeCase: Text[3];
        PrintOpCoLogo: Boolean;
        ReportCaption: Text[100];
        ReportType: Option Both,Statement,Ageing;
        AgingStartDate: Date;
        AgingEndDate: Date;
        AgingInterval: DateFormula;
        AgingPeriod: array[7] of Date;
        Factor: Code[1];
        Value: Integer;
        AgingPeriodFilter: array[5] of Text[50];
        AgingPeriodRange: array[5] of Text[50];
        AgingIntervalRange: array[5] of Text[50];
        i: Integer;
        j: Integer;
        k: Integer;
        CustRemainAmountTot: Decimal;
        AgingCustLedgEntry: Record "Cust. Ledger Entry";
        RowCount: Integer;
        AgingDataLoop: Integer;
        DisputedAmt: array[6] of Decimal;
        DebitAmt: array[6] of Decimal;
        CreditAmt: array[6] of Decimal;
        UnAlloPaymtAmt: array[6] of Decimal;
        LineAmt: array[6] of Decimal;
        OpenEntries: Boolean;
        LanguageR: Record Language;
        OriginalAmt: Decimal;
        OrginalAmountCaption: Text[100];
        PrintOrginalAmt: Boolean;
        CustomerNo: Code[20];

    local procedure ClearAllVariables();
    begin
        //HEI.01>>
        CLEAR(PrintOpCoLogo);
        CLEAR(ReportType);
        CLEAR(AgingStartDate);
        CLEAR(AgingEndDate);
        CLEAR(AgingInterval);
        CLEAR(Factor);
        CLEAR(Value);
        CLEAR(CustFilter);
        CLEAR(CustDateFilter);
        CLEAR(RowCount);
        CLEAR(AgingDataLoop);
        //HEI.01<<
    end;

    procedure InitAllVariables(AmountInLCY: Boolean; OpCoLogo: Boolean; TypeReport: Integer; StartDate: Date; EndDate: Date; AgingInt: DateFormula; CLEOpen: Boolean; CustNo: Code[20]);
    begin
        //HEI.08>>
        PrintAmountsInLCY := AmountInLCY;
        PrintOpCoLogo := OpCoLogo;
        ReportType := TypeReport;
        AgingStartDate := StartDate;
        AgingEndDate := EndDate;
        AgingInterval := AgingInt;
        OpenEntries := CLEOpen;
        CustomerNo := CustNo;
        //HEI.08<<
    end;
}

