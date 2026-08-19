report 53036 "Cust. Statement of Acc. - Open"
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
    // HEI.06 FDD- HB1202 CHG2051640 IBM GAVANM01 17.04.2020
    //   # New global var CLEDateFilter, CustAmountTotLCY
    //   # Code added

    // BC Upgrade KUMARR78 >>
    // Report Name  : Cust. Statement of Acc. - Open
    // Old Report ID: 50416 (NAV)
    // 1. Added Business Central visibility properties at report level.
    //    Old: ApplicationArea and UsageCategory not defined.
    //    New:
    //         - ApplicationArea = All
    //         - UsageCategory = ReportsAndAnalysis
    //    Reason: Mandatory for BC report visibility and role-based access.
    // 2. Replaced deprecated CaptionManagement Codeunit usage.
    //    Old:
    //         CaptionManagement: Codeunit CaptionManagement;
    //         CustFilter := CaptionManagement.GetRecordFiltersWithCaptions(Customer);
    //    New:
    //         Created custom local procedure GetRecordFiltersWithCaptions(Customer)
    //         using RecordRef, FieldRef and Translation Helper.
    //    Reason: CaptionManagement codeunit removed in Business Central.
    // 3. Blocked unsupported DIT field "Item Charge Type".
    //    Old:
    //         Customer.GETFILTER("Item Charge Type Filter")
    //         SETFILTER("Item Charge Type", ...)
    //    New:
    //         Logic commented/removed.
    //    Reason: Field not available in BC base application.
    // 4. Renamed conflicting Language record variable.
    //    Old:
    //         Language: Record Language;
    //    New:
    //         RecLanguage: Record Language;
    //    Reason: Conflict with standard Language object in BC.
    // 5. Added ApplicationArea property to Request Page fields.
    //    Old: Some fields did not define ApplicationArea.
    //    New: ApplicationArea = All / Basic, Suite added where required.
    //    Reason: Required for BC UI compliance.
    // 6. Added custom procedure for filter caption handling.
    //    New Procedure:
    //         local procedure GetRecordFiltersWithCaptions(var Customer: Record Customer): Text
    //    Reason: Replacement for removed CaptionManagement codeunit.
    // BC Upgrade KUMARR78 <<

    DefaultLayout = RDLC;
    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding UsageCategory
    RDLCLayout = '.\src\ReportsLayout\Cust. Statement of Acc. - Open.rdl';

    CaptionML = ENU = 'Customer - Statement of Account - Open as of Date',
                FRA = 'Client - Relevé de Compte  -Open as of Date';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
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
            column(PeriodCustDatetFilter; StrSubstNo(Text000, CustDateFilter))
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
            column(PhoneNoCompany; Text026)
            {
            }
            column(RemainingAmtLbl; RemainingAmtLbl)
            {
            }
            column(AgingPeriodCp; StrSubstNo(Text019, AgingInterval))
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
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = sorting("Customer No.", "Posting Date");
                column(PostDate_CustLedgEntry; Format("Posting Date"))
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
                column(CustRemainAmount; CustRemainAmount)
                {
                }
                column(CustBalanceLCY1; CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(CustEntryDueDate; Format(CustEntryDueDate))
                {
                }
                column(EntryNo_CustLedgEntry; "Entry No.")
                {
                    IncludeCaption = true;
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = field("Entry No.");
                    DataItemTableView = sorting("Cust. Ledger Entry No.", "Entry Type", "Posting Date") where("Entry Type" = filter("Appln. Rounding" | "Correction of Remaining Amount"));
                    column(EntryType_DtldCustLedgEntry; Format("Entry Type"))
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
                            SetFilter("Posting Date", CustDateFilter);
                        Correction := 0;
                        ApplicationRounding := 0;
                        //HEI.01<<
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    //HEI.01>>
                    CalcFields(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)", "Dispute Case FND");

                    //HEI.06>>
                    if OpenEntries and ("Remaining Amount" = 0) then
                        CurrReport.Skip;
                    //HEI.06<<

                    CustLedgEntryExists := true;

                    if "Dispute Case FND" then
                        DisputeCase := 'Yes'
                    else
                        DisputeCase := '';

                    if PrintAmountsInLCY then begin
                        CustAmount := "Amount (LCY)";
                        CustRemainAmount := "Remaining Amt. (LCY)";
                        CustCurrencyCode := '';
                    end else begin
                        CustAmount := Amount;
                        CustRemainAmount := "Remaining Amount";
                        CustCurrencyCode := "Currency Code";
                    end;
                    //CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";          //commented by HEI.06
                    CustBalanceLCY := CustBalanceLCY + "Remaining Amt. (LCY)";     //HEI.06

                    if ("Document Type" = "Document Type"::Payment) or ("Document Type" = "Document Type"::Refund) then
                        CustEntryDueDate := 0D
                    else
                        CustEntryDueDate := "Due Date";

                    CustRemainAmountTot += CustRemainAmount;
                    //HEI.01<<
                    CustAmountTotLCY += "Amount (LCY)";  //HEI.06
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.06>>
                    if CLEDateFilter <> '' then
                        SetFilter("Date Filter", CLEDateFilter);
                    //HEI.06<<

                    //HEI.03>>
                    //IF OpenEntries THEN      // commented by HEI.06
                    //  SETRANGE(Open,TRUE);   // commented by HEI.06
                    //HEI.03<<
                    //HEI.01>>
                    if CustDateFilter <> '' then
                        SetFilter("Posting Date", CustDateFilter);
                    CurrReport.CreateTotals(CustAmount, "Amount (LCY)");
                    CustLedgEntryExists := false;

                    //HEI.05>>
                    //BC Upgrade KUMARR78>> Blocking DIT Field
                    // if (Customer.GETFILTER("Item Charge Type Filter") <> '') then
                    //     SETFILTER("Item Charge Type", Customer.GETFILTER("Item Charge Type Filter"));
                    //BC Upgrade KUMARR78<< Blocking DIT Field

                    //HEI.05<<
                    //HEI.01<<
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(CustWiseTotal; Text025)
                {
                }
                column(CustBalStBalStBalAdjLCY; CustAmountTotLCY - StartBalAdjLCY)
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
                        CurrReport.Skip;
                    end;
                    //HEI.01<<
                end;
            }

            trigger OnAfterGetRecord();
            var
                CountryRegionCust: Record "Country/Region";
            begin
                //HEI.01>>
                Clear(CountryRegionNameCust);
                if CountryRegionCust.Get("Country/Region Code") then
                    CountryRegionNameCust := CountryRegionCust.Name;

                Clear(DisputeCase);
                CustRemainAmountTot := 0;
                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                if CustDateFilter <> '' then begin
                    if AgingStartDate <> 0D then begin
                        SetRange("Date Filter", 0D, AgingStartDate - 1);
                        CalcFields("Net Change (LCY)");
                        StartBalanceLCY := "Net Change (LCY)";
                    end;
                    SetFilter("Date Filter", CustDateFilter);
                    CalcFields("Net Change (LCY)");
                    StartBalAdjLCY := "Net Change (LCY)";

                    CustLedgEntry.SetCurrentKey("Customer No.", "Posting Date");
                    CustLedgEntry.SetRange("Customer No.", "No.");
                    CustLedgEntry.SetFilter("Posting Date", CustDateFilter);
                    //HEI.05>>

                    //BC Upgrade KUMARR78 >> Blocking DIT Field
                    // if (Customer.GETFILTER("Item Charge Type Filter") <> '') then
                    //     CustLedgEntry.SETFILTER("Item Charge Type", Customer.GETFILTER("Item Charge Type Filter"));
                    //BC Upgrade KUMARR78 <<  Blocking DIT Field

                    //HEI.05<<
                    if CustLedgEntry.Find('-') then begin
                        repeat
                            CustLedgEntry.SetFilter("Date Filter", CustDateFilter);
                            CustLedgEntry.CalcFields("Amount (LCY)");
                            StartBalAdjLCY := StartBalAdjLCY - CustLedgEntry."Amount (LCY)";
                            "Detailed Cust. Ledg. Entry".SetCurrentKey("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                            "Detailed Cust. Ledg. Entry".SetRange("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                            "Detailed Cust. Ledg. Entry".SetFilter("Entry Type", '%1|%2',
                            "Detailed Cust. Ledg. Entry"."Entry Type"::"Correction of Remaining Amount",
                            "Detailed Cust. Ledg. Entry"."Entry Type"::"Appln. Rounding");
                            "Detailed Cust. Ledg. Entry".SetFilter("Posting Date", CustDateFilter);
                            if "Detailed Cust. Ledg. Entry".Find('-') then
                                repeat
                                    StartBalAdjLCY := StartBalAdjLCY - "Detailed Cust. Ledg. Entry"."Amount (LCY)";
                                until "Detailed Cust. Ledg. Entry".Next = 0;
                            "Detailed Cust. Ledg. Entry".Reset;
                        until CustLedgEntry.Next = 0;
                    end;
                end;

                if (ReportType <> ReportType::Statement) and PrintAmountsInLCY then begin
                    Clear(DisputedAmt);
                    Clear(DebitAmt);
                    Clear(CreditAmt);
                    Clear(UnAlloPaymtAmt);
                    Clear(LineAmt);
                    AgingCustLedgEntry.Reset;
                    AgingCustLedgEntry.SetCurrentKey("Customer No.", "Posting Date");
                    AgingCustLedgEntry.SetRange("Customer No.", "No.");
                    //HEI.05>>

                    //BC Upgrade KUMARR78 >> Blocking DIT Field
                    // if (Customer.GETFILTER("Item Charge Type Filter") <> '') then
                    //     AgingCustLedgEntry.SETFILTER("Item Charge Type", Customer.GETFILTER("Item Charge Type Filter"));
                    //BC Upgrade KUMARR78 << Blocking DIT Field
                    //HEI.05<<
                    for AgingDataLoop := 1 to RowCount do begin
                        AgingCustLedgEntry.SetFilter("Posting Date", AgingPeriodFilter[AgingDataLoop]);
                        AgingCustLedgEntry.SetRange("Dispute Case FND", true);
                        AgingCustLedgEntry.SetRange("Document Type", AgingCustLedgEntry."Document Type"::Invoice);
                        if AgingCustLedgEntry.Find('-') then begin
                            repeat
                                AgingCustLedgEntry.CalcFields("Remaining Amt. (LCY)");
                                DisputedAmt[AgingDataLoop] := DisputedAmt[AgingDataLoop] + AgingCustLedgEntry."Remaining Amt. (LCY)";
                            until AgingCustLedgEntry.Next = 0;
                        end;

                        AgingCustLedgEntry.SetRange("Dispute Case FND", false);
                        AgingCustLedgEntry.SetFilter("Document Type", '<>%1', AgingCustLedgEntry."Document Type"::Payment);
                        if AgingCustLedgEntry.Find('-') then begin
                            repeat
                                AgingCustLedgEntry.CalcFields("Remaining Amt. (LCY)");
                                if AgingCustLedgEntry."Remaining Amt. (LCY)" < 0 then
                                    CreditAmt[AgingDataLoop] := CreditAmt[AgingDataLoop] + AgingCustLedgEntry."Remaining Amt. (LCY)"
                                else
                                    DebitAmt[AgingDataLoop] := DebitAmt[AgingDataLoop] + AgingCustLedgEntry."Remaining Amt. (LCY)";
                            until AgingCustLedgEntry.Next = 0;
                        end;

                        AgingCustLedgEntry.SetRange("Dispute Case FND", false);
                        AgingCustLedgEntry.SetRange("Document Type", AgingCustLedgEntry."Document Type"::Payment);
                        if AgingCustLedgEntry.Find('-') then begin
                            repeat
                                AgingCustLedgEntry.CalcFields("Remaining Amt. (LCY)");
                                UnAlloPaymtAmt[AgingDataLoop] := UnAlloPaymtAmt[AgingDataLoop] + AgingCustLedgEntry."Remaining Amt. (LCY)";
                            until AgingCustLedgEntry.Next = 0;
                        end;

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

                CurrReport.PrintOnlyIfDetail := (StartBalanceLCY = 0);
                CustBalanceLCY := StartBalanceLCY + StartBalAdjLCY;
                //HEI.03>>
                //IF (ReportType = ReportType::Ageing) AND (LineAmt[5] = 0) THEN
                if (ReportType = ReportType::Ageing) and (LineAmt[6] = 0) then
                    //HEI.03<<
                    CurrReport.Skip;
                //HEI.01<<
            end;

            trigger OnPreDataItem();
            begin
                //HEI.01>>
                CurrReport.CreateTotals("Cust. Ledger Entry"."Amount (LCY)", StartBalanceLCY, StartBalAdjLCY, Correction, ApplicationRounding);
                //HEI.01<<
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
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
                    field(PrintOpCoLogo; PrintOpCoLogo)
                    {
                        ApplicationArea = All;//BC Upgrade KUMARR78 Adding ApplicationArea
                        CaptionML = ENU = 'Print OpCo Logo',
                                    FRA = 'Imprimer Logo OpCo';
                    }
                    field(ReportType; ReportType)
                    {
                        ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
                        CaptionML = ENU = 'Report Type',
                                    FRA = 'Type de rapport';
                    }
                    field(AgingStartDate; AgingStartDate)
                    {
                        ApplicationArea = All;//BC Upgrade KUMARR78 Adding ApplicationArea
                        CaptionML = ENU = 'Start Date',
                                    FRA = 'Date de début balance âgée';
                    }
                    field(AgingEndDate; AgingEndDate)
                    {
                        ApplicationArea = All;//BC Upgrade KUMARR78 Adding ApplicationArea
                        CaptionML = ENU = 'End Date',
                                    FRA = 'Date de fin balance âgée';
                    }
                    field(AgingInterval; AgingInterval)
                    {
                        ApplicationArea = All;//BC Upgrade KUMARR78 Adding ApplicationArea
                        CaptionML = ENU = 'Aging Interval',
                                    FRA = 'Intervalle balance âgée';

                        trigger OnValidate();
                        begin
                            //HEI.01>>

                            if (ReportType <> ReportType::Statement) and PrintAmountsInLCY then begin
                                Evaluate(Value, Format(CopyStr(Format(AgingInterval), 1, StrLen(Format(AgingInterval)) - 1)));
                                Factor := DelStr(Format(AgingInterval), 1, StrLen(Format(AgingInterval)) - 1);
                                //HEI.04<<
                                // if Language.Code = 'FRA' then //BC Upgrade KUMARR78 Changing Record Variable Name As conflictes with Standerd.
                                if RecLanguage.Code = 'FRA' then //BC Upgrade KUMARR78 Changing Record Variable Name As conflictes with Standerd.
                                    if not (Factor in ['J', 'JS', 'S', 'T', 'A', 'M']) then
                                        Error(Text021, Value)
                                    else if Value = 0 then
                                        Error(Text022, Value)
                                    else
                                        //HEI.04>>
                                        if not (Factor in ['D', 'M', 'Y']) then
                                            Error(Text021, Value)
                                        else if Value = 0 then
                                            Error(Text022, Value);
                            end else
                                Error(Text023);
                            //HEI.01<<
                        end;
                    }
                    field("Open Entries"; OpenEntries)
                    {
                        ApplicationArea = All;//BC Upgrade KUMARR78 Adding ApplicationArea
                        CaptionML = ENU = 'Open Entries',
                                    FRA = 'Écritures ouvertes';
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
            Clear(AgingInterval);
            //HEI.01<<
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        //HEI.01>>
        ClearAllVariables;
        //HEI.01<<
    end;

    trigger OnPreReport();
    var
        CountryRegionCompnyInfo: Record "Country/Region";
        CustLedgEntryL: Record "Cust. Ledger Entry";
    // CaptionManagement: Codeunit CaptionManagement;  //BC Upgrade KUMARR78 Blocking As Codeunit Removed.
    begin
        //HEI.01>>
        //IF (ReportType <> ReportType::Statement) AND (FORMAT(AgingInterval) = '') THEN
        // ERROR(Text024);

        CompanyInfo.Get;
        if PrintOpCoLogo then
            CompanyInfo.CalcFields("OpCo Logo FND")
        else
            CompanyInfo.CalcFields(Picture);

        Clear(CountryRegionNameCompanyInfo);
        if CountryRegionCompnyInfo.Get(CompanyInfo."Country/Region Code") then
            CountryRegionNameCompanyInfo := CountryRegionCompnyInfo.Name;

        // CustFilter := CaptionManagement.GetRecordFiltersWithCaptions(Customer); //BC Upgrade KUMARR78 Blocking As Codeunit Removed.
        CustFilter := GetRecordFiltersWithCaptions(Customer); //BC Upgrade KUMARR78 Adding for Filter with Caption as Codeunit was removed.


        //HEI.06>>
        if AgingEndDate <> 0D then
            CLEDateFilter := '..' + Format(AgingEndDate)
        else if AgingStartDate <> 0D then
            CLEDateFilter := '..' + Format(AgingStartDate);
        //HEI.06<<

        if (AgingStartDate <> 0D) and (AgingEndDate <> 0D) then
            CustDateFilter := Format(AgingStartDate) + '..' + Format(AgingEndDate)
        else if (AgingStartDate <> 0D) and (AgingEndDate = 0D) then begin
            CustDateFilter := Format(AgingStartDate)
        end else if (AgingStartDate = 0D) and (AgingEndDate <> 0D) then begin
            if CustLedgEntryL.FindFirst then
                AgingStartDate := CustLedgEntryL."Posting Date"
            else if AgingEndDate >= Today then
                AgingStartDate := Today
            else if AgingEndDate >= WorkDate then
                AgingStartDate := WorkDate
            else
                AgingStartDate := DMY2Date(1, 1, 2000);
            CustDateFilter := Format(AgingStartDate) + '..' + Format(AgingEndDate);
        end else if (AgingStartDate = 0D) and (AgingEndDate = 0D) then begin
            if CustLedgEntryL.FindFirst then
                AgingStartDate := CustLedgEntryL."Posting Date"
            else
                AgingStartDate := DMY2Date(1, 1, 2000);
            AgingEndDate := DMY2Date(31, 12, 9999);
            CustDateFilter := Format(AgingStartDate) + '..';
        end;

        if PrintAmountsInLCY then begin
            AmountCaption := "Cust. Ledger Entry".FieldCaption("Amount (LCY)");
            RemainingAmtCaption := "Cust. Ledger Entry".FieldCaption("Remaining Amt. (LCY)");
        end else begin
            AmountCaption := "Cust. Ledger Entry".FieldCaption(Amount);
            RemainingAmtCaption := "Cust. Ledger Entry".FieldCaption("Remaining Amount");
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
                AgingPeriod[i] := CalcDate(AgingInterval, (AgingPeriod[i - 1]));
                //HEI.03>>
                //IF AgingPeriod[i] <= AgingPeriod[6] THEN BEGIN
                if AgingPeriod[i] <= AgingPeriod[7] then begin
                    //HEI.03<<
                    AgingPeriodFilter[RowCount] := Format(AgingPeriod[i - 1]) + '..' + Format(AgingPeriod[i] - 1);
                    //HEI.03>>
                    //AgingIntervalRange[i-1] := '  (' + FORMAT((Value*(i-2))+1) + '..' + (FORMAT(Value*(i-1)) + Factor) + ')';
                    //AgingPeriodRange[i-1] := AgingPeriodFilter[RowCount] + AgingIntervalRange[i-1];
                    AgingIntervalRange[i - 1] := Format((Value * (i - 2)) + 1) + '..' + (Format(Value * (i - 1)) + Factor);
                    AgingPeriodRange[i - 1] := AgingIntervalRange[i - 1];
                    //HEI.03<<
                end else begin
                    j := i;
                    //HEI.03>>
                    //i := 5;
                    i := 6;
                    AgingPeriodRange[i - 1] := '>' + (Format(Value * (i - 2)) + Factor);
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
                                AgingPeriodFilter[RowCount] := Format(AgingPeriod[i - 1]) + '...' + Format(AgingPeriod[7]);
                                AgingPeriodRange[i - 1] := '>' + (Format(Value * (i - 2)) + Factor);
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
                                AgingPeriodFilter[RowCount] := Format(AgingPeriod[j - 1]) + '..' + Format(AgingPeriod[7]);
                                AgingPeriodRange[j - 1] := '>' + (Format(Value * (j - 2)) + Factor);
                                //HEI.03<<
                            end;
                        end;
                    end else begin
                        //HEI.03>>
                        //IF (AgingPeriod[i] - 1) <= AgingPeriod[6] THEN BEGIN
                        //AgingPeriodFilter[RowCount] := FORMAT(AgingPeriod[i-1]) + '..' + FORMAT(AgingPeriod[6]);
                        //AgingPeriodRange[i-1] := AgingPeriodFilter[RowCount] + '  (' + FORMAT(k) + 'D)';
                        if (AgingPeriod[i] - 1) <= AgingPeriod[7] then begin
                            AgingPeriodFilter[RowCount] := Format(AgingPeriod[i - 1]) + '..' + Format(AgingPeriod[7]);
                            AgingPeriodRange[i - 1] := '>' + (Format(Value * (i - 2)) + Factor);
                            //HEI.03<<
                        end;
                        //HEI.03>>
                        //IF AgingPeriod[6] = DMY2DATE(31,12,9999) THEN BEGIN
                        if AgingPeriod[7] = DMY2Date(31, 12, 9999) then begin
                            //HEI.03<<
                            AgingPeriodFilter[RowCount] := Format(AgingPeriod[i - 1]) + '..';
                            AgingPeriodRange[i - 1] := AgingPeriodFilter[RowCount];
                        end;
                    end;
                end;
            end;
        end;
        //HEI.01<<
    end;

    var
        CompanyInfo: Record "Company Information";
        AgingCustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        // Language: Record Language; //BC Upgrade KUMARR78 Blocking Record Variable As conflictes with Standerd.
        RecLanguage: Record Language;//BC Upgrade KUMARR78 Changing Record Variable As conflictes with Standerd.
        AgingInterval: DateFormula;
        CustLedgEntryExists: Boolean;
        OpenEntries: Boolean;
        PrintAmountsInLCY: Boolean;
        PrintOpCoLogo: Boolean;
        Factor: Code[1];
        CustCurrencyCode: Code[10];
        AgingEndDate: Date;
        AgingPeriod: array[7] of Date;
        AgingStartDate: Date;
        CustEntryDueDate: Date;
        ApplicationRounding: Decimal;
        Correction: Decimal;
        CreditAmt: array[6] of Decimal;
        CustAmount: Decimal;
        CustAmountTotLCY: Decimal;
        CustBalanceLCY: Decimal;
        CustRemainAmount: Decimal;
        CustRemainAmountTot: Decimal;
        DebitAmt: array[6] of Decimal;
        DisputedAmt: array[6] of Decimal;
        LineAmt: array[6] of Decimal;
        StartBalAdjLCY: Decimal;
        StartBalanceLCY: Decimal;
        UnAlloPaymtAmt: array[6] of Decimal;
        AgingDataLoop: Integer;
        i: Integer;
        j: Integer;
        k: Integer;
        RowCount: Integer;
        Value: Integer;
        Text004: Label 'Select to get OpCo Logo';
        Text006: Label 'E-Mail ID';
        Text011: Label 'Debit';
        Text012: Label 'Credit';
        Text022: Label 'Please enter the correct Interval number that should be more than Zero (0).';
        Text023: Label 'You cannot alow to enter Aging Interval for only to get the Statement.';
        Text024: Label 'Please enter the Aging Interval to get the Aging Summary in the report.';
        Text025: Label 'Total :';
        ReportType: Option Both,Statement,Ageing;
        CLEDateFilter: Text;
        CustDateFilter: Text;
        CustFilter: Text;
        DisputeCase: Text[3];
        RemainingAmtCaption: Text[30];
        AgingIntervalRange: array[5] of Text[50];
        AgingPeriodFilter: array[5] of Text[50];
        AgingPeriodRange: array[5] of Text[50];
        CountryRegionNameCompanyInfo: Text[50];
        CountryRegionNameCust: Text[50];
        AmountCaption: Text[80];
        ReportCaption: Text[100];
        AdjOpeningBalCaptionLbl: TextConst ENU = 'Adj. of Opening Balance', FRA = 'Ajust. solde d''ouverture';
        BalanceLCYCaptionLbl: TextConst ENU = 'Balance (LCY)', FRA = 'Solde';
        DueDateCaptionLbl: TextConst ENU = 'Due Date', FRA = 'Date d''échéance';
        OpeningBalCaptionLbl: TextConst ENU = 'Opening Balance', FRA = 'Solde d''Ouverture';
        PostingDateCaptionLbl: TextConst ENU = 'Posting Date', FRA = 'Date comptabilis.';
        RemainingAmtLbl: TextConst ENU = 'Remaining Amt. (LCY)', FRA = 'Montant ouvert';
        Text000: TextConst ENU = 'Period: %1', FRA = 'Période : %1';
        Text001: TextConst ENU = 'Page: ', FRA = 'Page:';
        Text002: TextConst ENU = 'of ', FRA = 'of ';
        Text003: TextConst ENU = 'All amounts are in LCY', FRA = 'Tous les montants sont en DS';
        Text005: TextConst ENU = 'Phone No.', FRA = 'N° de téléphone';
        Text007: TextConst ENU = 'Customer No.', FRA = 'N° de client';
        Text008: TextConst ENU = 'VAT Registration No.', FRA = 'Numéro d''enregistrement TVA';
        Text009: TextConst ENU = 'Contact Person', FRA = 'Contact';
        Text010: TextConst ENU = 'Disputed', FRA = 'Contesté';
        Text013: TextConst ENU = 'Un-Allocated Payment', FRA = 'Paiements non lettrés';
        Text014: TextConst ENU = 'Amount (LCY)', FRA = 'Montant';
        Text015: TextConst ENU = 'Aging Summary:', FRA = 'Résumé âgée:';
        Text016: TextConst ENU = 'Customer - Statement of Account', FRA = 'Client - Relevé de compte';
        Text017: TextConst ENU = 'Customer - Statement of Account with Aging Summary ', FRA = 'Client - Relevé de compte';
        Text018: TextConst ENU = 'Customer - Aging Summary', FRA = 'Client - Relevé de compte';
        Text019: TextConst ENU = 'Aging Periods by %1 Interval', FRA = 'Périodes âgée par %1 Intervalle';
        Text020: TextConst ENU = 'Total Amount', FRA = 'Montant Total';
        Text021: TextConst ENU = 'Please enter the correct Unit after Aging Interval Number %1.\ i.e. Unit = D or M or Y', FRA = 'Please enter the correct Unit after Aging Interval Number %1.\ i.e. Unit = J or M or A';
        Text026: TextConst ENU = 'Phone No.', FRA = 'Téléphone';

    local procedure ClearAllVariables();
    begin
        //HEI.01>>
        Clear(PrintOpCoLogo);
        Clear(ReportType);
        Clear(AgingStartDate);
        Clear(AgingEndDate);
        Clear(AgingInterval);
        Clear(Factor);
        Clear(Value);
        Clear(CustFilter);
        Clear(CustDateFilter);
        Clear(RowCount);
        Clear(AgingDataLoop);
        //HEI.01<<
        Clear(CLEDateFilter);  //HEI.06
    end;
    //BC Upgrade KUMARR78 Creating Function >>
    local procedure GetRecordFiltersWithCaptions(var Customer: Record Customer): Text
    var
        TranslationHelper: Codeunit "Translation Helper";
        RecRef: RecordRef;
        FldRef: FieldRef;
        LangCode: Code[10];
        i: Integer;
        CaptionTxt: Text;
        FilterTxt: Text;
        ResultTxt: Text;
    begin
        // You can keep blank to use current language, or hardcode 'ENU'
        LangCode := '';

        RecRef.GetTable(Customer);

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

