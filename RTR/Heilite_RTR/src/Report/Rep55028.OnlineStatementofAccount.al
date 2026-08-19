report 55028 "Online Statement of Account"
{
    // version IBM 1001,HEI.01

    // FDD-HNK 100050 : 18/08/2015 Isyed01:
    // #Created New Report for Online Statement of Account
    // HEI.01 IBM MATHEJ01 19.08.19 - #CHG2023308 Customer Statement of Account for Lebonan
    //   # Imported the report Online Statement of Account (ID: 80040) from Heilite 2.0 system to Heilite BASE.
    //   # Modified the layout to correct the report output.

    // BC Upgrade RAHUL>>
    // 1. Added ApplicationArea = All property at report level for Business Central visibility.
    //    Old: ApplicationArea property not defined at report level.
    //    New: ApplicationArea = All added at report level.
    //
    // 2. Added UsageCategory = ReportsAndAnalysis property at report level for Business Central search.
    //    Old: UsageCategory not defined.
    //    New: UsageCategory = ReportsAndAnalysis added at report level.
    //
    // 3. Report upgrade reference.
    //    Old Report ID: 50196
    //    New: Report upgraded for Business Central with ApplicationArea
    //         and UsageCategory compliance.
    // BC Upgrade RAHUL<<

    DefaultLayout = RDLC;
    ApplicationArea = All; // BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade KUMARR78 Adding UsageCategory
    RDLCLayout = '.\src\ReportsLayout\Online Statement of Account.rdl';


    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Customer Posting Group", "Date Filter";
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(GLADESC; GLAccDesc)
            {
            }
            column(GLAccountNo; GLAcc."No.")
            {
            }
            column(Startdate; Format(Startdate, 0))
            {
            }
            column(Enddate; Format(Enddate, 0))
            {
            }
            column(Currency; Customer."Currency Code")
            {
                IncludeCaption = true;
            }
            column(CustDebitAmount; Cust."Debit Amount")
            {
            }
            column(CustCreditAmount; Cust."Credit Amount")
            {
            }
            column(CustNetAmount; Cust."Net Change")
            {
            }
            column(CustomerName; Customer.Name)
            {
                IncludeCaption = true;
            }
            column(CustomerCode; Customer."No.")
            {
                IncludeCaption = true;
            }
            column(ReportDate; ReportDate)
            {
            }
            column(VATREGNO; CompanyInformation."VAT Registration No.")
            {
                IncludeCaption = true;
            }
            column(OpeningAmt; OpeningAmt)
            {
            }
            column(ClosingAmt; ClosingAmt)
            {
            }
            dataitem("Customer Posting Group"; "Customer Posting Group")
            {
                DataItemLink = Code = field("Customer Posting Group");
                DataItemTableView = sorting(Code);
                PrintOnlyIfDetail = true;
                column(ReceivableAccount; "Customer Posting Group"."Receivables Account")
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord();
                begin
                    //FDD-HNK 100050 : 18/08/2015 Isyed01:
                    if CustPostGrp.Get(Customer."Customer Posting Group") then
                        if GLAcc.Get(CustPostGrp."Receivables Account") then
                            GLAccDesc := GLAcc.Name;
                end;
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Customer No.", "Posting Date", "Document No.") order(ascending);
                column(PostingDate; "Cust. Ledger Entry"."Posting Date")
                {
                    IncludeCaption = true;
                }
                column(VoucherNo; "Cust. Ledger Entry"."Document No.")
                {
                    IncludeCaption = true;
                }
                column(Type; "Cust. Ledger Entry"."Document Type")
                {
                    IncludeCaption = true;
                }
                column(Description; "Cust. Ledger Entry".Description)
                {
                    IncludeCaption = true;
                }
                column(ExternalDocNo; "Cust. Ledger Entry"."External Document No.")
                {
                    IncludeCaption = true;
                }
                column(DebitAmount; "Cust. Ledger Entry"."Debit Amount")
                {
                    IncludeCaption = true;
                }
                column(CreditAmount; "Cust. Ledger Entry"."Credit Amount")
                {
                    IncludeCaption = true;
                }
                column(labelDescription; "Cust. Ledger Entry".Description)
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord();
                begin
                    //FDD-HNK 100050 : 18/08/2015 Isyed01:
                    /*
                    CustLedgEntry.RESET;
                    CustLedgEntry.SETCURRENTKEY("Customer No.","Posting Date","Document No.",Open);
                    CustLedgEntry.SETRANGE("Customer No.","Customer No.");
                    "Cust. Ledger Entry".CALCFIELDS("Debit Amount","Credit Amount",Amount);
                    CurrOpeningAmt := OpeningAmt;
                    ClosingAmt := CurrOpeningAmt + Amount;
                    OpeningAmt := ClosingAmt;
                    */

                    "Cust. Ledger Entry".CalcFields("Debit Amount", "Credit Amount", Amount);
                    CurrOpeningAmt := OpeningAmt;
                    ClosingAmt := CurrOpeningAmt + Amount;
                    OpeningAmt := ClosingAmt;

                end;

                trigger OnPreDataItem();
                begin
                    ////FDD-HNK 100050 : 18/08/2015 Isyed01:
                    /*SETRANGE("Cust. Ledger Entry"."Posting Date",Startdate,Enddate)*/

                end;
            }

            trigger OnAfterGetRecord();
            begin
                //FDD-HNK 100050 : 18/08/2015 Isyed01:


                OpeningAmt := 0;
                CurrOpeningAmt := 0;
                ClosingAmt := 0;

                if CustPostGrp.Get(Customer."Customer Posting Group") then
                    if GLAcc.Get(CustPostGrp."Receivables Account") then
                        GLAccDesc := GLAcc.Name;


                Cust.Reset();
                Cust.SetRange("No.", "No.");
#pragma warning disable AA0210
                Cust.SetFilter("Date Filter", '%1..%2', 0D, Startdate - 1);
#pragma warning restore AA0210
                Cust.FindFirst();
                Cust.CalcFields("Net Change", "Credit Amount", "Debit Amount");
                OpeningAmt := Cust."Net Change";


                for i := 1 to 5 do begin
                    CustLedgEntry.Reset();
                    CustLedgEntry.SetCurrentKey("Customer No.", "Posting Date", "Document No.", Open);
                    CustLedgEntry.SetRange("Customer No.", "No.");
                    if i = 5 then
                        CustLedgEntry.SetFilter("Posting Date", '%1..%2', PeriodStartDate[i], PeriodStartDate[i + 1])
                    else
                        CustLedgEntry.SetFilter("Posting Date", '%1..%2', PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                    CustLedgEntry.SetRange(Open, true);
                    if CustLedgEntry.FindFirst() then
                        repeat
                            CustLedgEntry.CalcFields(CustLedgEntry."Remaining Amount");
                            CustBalance[i] += CustLedgEntry."Remaining Amount";
                        until CustLedgEntry.Next() = 0;
                end;
                //<<FDD-HNK 100050 : 18/08/2015 Isyed01:
            end;

            trigger OnPreDataItem();
            begin

                CurrReport.CreateTotals(CustBalance);
                CurrReport.CreateTotals("Cust. Ledger Entry"."Credit Amount", "Cust. Ledger Entry"."Debit Amount");
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
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        label(lblReportName; ENU = 'Statement of Account Detailed',
                            FRA = 'Relevé de compte détaillée')
        label(lblUserName; ENU = 'User Name:',
                          FRA = 'Nom d''utilisateur:')
        label(lblFromDate; ENU = 'From Date:',
                          FRA = 'De Date:')
        label(lblToDate; ENU = 'To:',
                        FRA = 'à:')
        label(lblDate; ENU = 'Date:',
                      FRA = 'Date:')
        label(lblPage; ENU = 'Page:',
                      FRA = 'Page:')
        label(lblCurrency; ENU = 'Currency:',
                          FRA = 'Devise:')
        label(lblCustomerCode; ENU = 'Customer Code:',
                              FRA = 'Code client :')
        label(lblAccount; ENU = 'Account:',
                         FRA = 'Compte :')
        label(lblPostingDate; ENU = 'Date',
                             FRA = 'Date')
        label(lblVoucherNo; ENU = 'Voucher No.',
                           FRA = 'No. bon')
        label(lblType; ENU = 'Type',
                      FRA = 'Type')
        label(lblLabel; ENU = 'Label',
                       FRA = 'Label')
        label(lblOpeningBalance; ENU = 'Opening Balance:',
                                FRA = 'Solde D''Ouverture:')
        label(lblDebitAmount; ENU = 'Debit Amount',
                             FRA = 'débit Montant')
        label(lblCreditAmount; ENU = 'Credit Amount',
                              FRA = 'Montant de crédit')
        label(lblBalance; ENU = 'Balance',
                         FRA = 'Balance')
        label(lblTotal; ENU = 'Total',
                       FRA = 'Total')
        label(lblVat; ENU = 'Vat#:',
                     FRA = 'Vat#:')
    }

    trigger OnPreReport();
    begin
        //FDD-HNK 100050 : 18/08/2015 Isyed01:

        CompanyInformation.Get();

        ReportDate := Format(Today, 0, '<Day,2>.<Month TEXT,3> <Year,2>');

        CustFilter := Customer.GetFilters;
        Startdate := Customer.GetRangeMin("Date Filter");
        Enddate := Customer.GetRangeMax("Date Filter");

        //PeriodStartDate[1] := 11310000D;
        PeriodStartDate[6] := Enddate;
        PeriodStartDate[5] := CalcDate('<-30D>', PeriodStartDate[6]);
        PeriodStartDate[4] := CalcDate('<-30D>', PeriodStartDate[5]);
        PeriodStartDate[3] := CalcDate('<-30D>', PeriodStartDate[4]);
        PeriodStartDate[2] := CalcDate('<-30D>', PeriodStartDate[3]);
    end;

    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CompanyInformation: Record "Company Information";
        CustPostGrp: Record "Customer Posting Group";
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        OpeningAmt: Decimal;
        CurrOpeningAmt: Decimal;
        ClosingAmt: Decimal;
        i: Integer;
        ReportDate: Text[50];
        GLAccDesc: Text[100];
        Startdate: Date;
        Enddate: Date;
        CustBalance: array[5] of Decimal;
        PeriodStartDate: array[6] of Date;
        CustFilter: Text;
}

