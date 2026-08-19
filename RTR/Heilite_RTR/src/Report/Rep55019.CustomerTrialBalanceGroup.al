report 55019 "Customer Trial Balance Group"
{
    // version HEI.01

    // HEI.01 CHG2244204 Yadavm09 30.05.2024 - Vendor_Customer Trial Balance for reconciliation
    //   # New Report Created: 50612

    //Bc Upgrade YADAVM09 Drink it fields Blocked.
    //Bc Upgrade YDDAVM09 Report property changes.
    //Bc Upgrade YADAVM09 BCUP0-24 Bug Fix.
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Customer Trial Balance Group.rdl';
    PreviewMode = PrintLayout;
    Caption = 'Customer Trial Balance Group Wise';//BC Upgrade YADAVM09<<
    ApplicationArea = ALL; //BC Upgrade YADAVM09<<
    UsageCategory = ReportsAndAnalysis;//BC Upgrade YADAVM09<<


    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Date Filter";
            column(PeriodBeginBalance; PeriodBeginBalance)
            {
            }
            column(PeriodDebitAmt; PeriodDebitAmt)
            {
            }
            column(PeriodCreditAmt; ABS(PeriodCreditAmt))
            {
            }
            column(CurrReportPageNoCaptionLbl; CurrReportPageNoCaptionLbl)
            {
            }
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(CustomerPostingGroup_Customer; Customer."Customer Posting Group")
            {
            }
            column(VendTrialBalanceCapLbl; VendTrialBalanceCapLbl)
            {
            }
            column(AmountsinLCYCaptionLbl; AmountsinLCYCaptionLbl)
            {
            }
            column(VendWithEntryPeriodCaptLbl; VendWithEntryPeriodCaptLbl)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(NameCaptLbl; NameCaptLbl)
            {
            }
            column(BeginningBalanceCaptLbl; BeginningBalanceCaptLbl)
            {
            }
            column(NetChangeCaptionLbl; NetChangeCaptionLbl)
            {
            }
            column(DebitCaptionLbl; DebitCaptionLbl)
            {
            }
            column(CreditCaptionLbl; CreditCaptionLbl)
            {
            }
            column(MovementCaptionLbl; MovementCaptionLbl)
            {
            }
            column(EndingBalanceCaptionlbl; EndingBalanceCaptionlbl)
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(NoCaptionLbl; NoCaptionLbl)
            {
            }
            column(DateFilter_Vendor; PeriodFilter)
            {
            }
            column(PeriodStartDate; FORMAT(PeriodStartDate))
            {
            }
            column(PeriodEndDate; FORMAT(PeriodEndDate))
            {
            }
            column(SplitBalancePostingGroupWises; SplitBalancePostingGroupWise)
            {
            }
            column(BeginingDate; BeginingDate)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                RequestFilterFields = "Customer No.", "Date Filter";
                column(AmountLCY; RecDetailedCustLedgEntry."Amount (LCY)")
                {
                }
                column(CustomerPostingGroup_CustLedgerEntry; "Cust. Ledger Entry"."Customer Posting Group")
                {
                }
                column(CustomerNo_CustLedgerEntry; "Cust. Ledger Entry"."Customer No.")
                {
                }
                column(DebitAmountLCY; DebitAmount)
                {
                }
                column(CreditAmountLCY; ABS(CreditAmount))
                {
                }

                trigger OnAfterGetRecord();
                begin
                    //HEI.01
                    if not SplitBalancePostingGroupWise then
                        CurrReport.SKIP();

                    ReportSkip2 := false;
                    if PostingGroup <> "Cust. Ledger Entry"."Customer Posting Group" then begin
                        ReportSkip2 := true;
                        PostingGroup := "Cust. Ledger Entry"."Customer Posting Group";
                    end;

                    if not ReportSkip2 then
                        CurrReport.SKIP();

                    if Customer1.GET("Cust. Ledger Entry"."Customer No.") then
                        VendorName := Customer1.Name;

                    //Opening
                    RecDetailedCustLedgEntry.RESET();
                    RecDetailedCustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Entry Type", "Currency Code");
                    RecDetailedCustLedgEntry.SETRANGE("Customer No.", "Customer No.");
                    //RecDetailedCustLedgEntry.SETRANGE("Customer Posting Group","Customer Posting Group");//Bc Upgrade YADAVM09 Drink it fields<<
                    RecDetailedCustLedgEntry.SETRANGE("Posting Date", 0D, PeriodStartDate - 1);
                    // Customer.COPYFILTER("Contract Group Filter","Contract Group Code");//Bc Upgrade YADAVM09 Drink it fields<<
                    // Customer.COPYFILTER("DIT Sub-Contract Type Filter","DIT Sub-Contract Type");//Bc Upgrade YADAVM09 Drink it fields<<
                    // Customer.COPYFILTER("Service Contract No. Filter","Service Contract No.");//Bc Upgrade YADAVM09 Drink it fields<<
                    // Customer.COPYFILTER("Item Charge Type Filter","Item Charge Type");//Bc Upgrade YADAVM09 Drink it fields<<
                    RecDetailedCustLedgEntry.CALCSUMS("Amount (LCY)");

                    //Debit
                    DtlCustLedgEntry.RESET();
                    //DtlCustLedgEntry.SETCURRENTKEY("Customer No.","Customer Posting Group","Posting Date","Currency Code");//Bc Upgrade YADAVM09 Drink it fields<<
                    DtlCustLedgEntry.SETRANGE("Customer No.", "Customer No.");
                    //DtlCustLedgEntry.SETRANGE("Customer Posting Group","Customer Posting Group");//Bc Upgrade YADAVM09 Drink it fields<<
                    DtlCustLedgEntry.SETRANGE("Posting Date", PeriodStartDate, PeriodEndDate);
                    // Customer.COPYFILTER("Contract Group Filter","Contract Group Code");//Bc Upgrade YADAVM09 Drink it fields<<
                    // Customer.COPYFILTER("DIT Sub-Contract Type Filter","DIT Sub-Contract Type");//Bc Upgrade YADAVM09 Drink it fields<<
                    // Customer.COPYFILTER("Service Contract No. Filter","Service Contract No.");//Bc Upgrade YADAVM09 Drink it fields<<
                    // Customer.COPYFILTER("Item Charge Type Filter","Item Charge Type");//Bc Upgrade YADAVM09 Drink it fields<<
                    DtlCustLedgEntry.SETFILTER("Amount (LCY)", '>%1', 0);
                    DtlCustLedgEntry.CALCSUMS("Amount (LCY)");
                    DebitAmount := DtlCustLedgEntry."Amount (LCY)";
                    SumofMovement := DtlCustLedgEntry."Debit Amount (LCY)" - DtlCustLedgEntry."Credit Amount (LCY)";

                    //Credit
                    DtlCustLedgEntry.RESET();
                    //DtlCustLedgEntry.SETCURRENTKEY("Customer No.", "Customer Posting Group", "Posting Date", "Currency Code");//Bc Upgrade YADAVM09 Drink it fields<<
                    DtlCustLedgEntry.SETRANGE("Customer No.", "Customer No.");
                    //DtlCustLedgEntry.SETRANGE("Customer Posting Group", "Customer Posting Group");//Bc Upgrade YADAVM09 Drink it fields<<
                    DtlCustLedgEntry.SETRANGE("Posting Date", PeriodStartDate, PeriodEndDate);//Bc Upgrade YADAVM09 BCUP0-24 <<
                    // Customer.COPYFILTER("Contract Group Filter", "Contract Group Code");//Bc Upgrade YADAVM09 Drink it fields<<
                    // Customer.COPYFILTER("DIT Sub-Contract Type Filter", "DIT Sub-Contract Type");//Bc Upgrade YADAVM09 Drink it fields<<
                    // Customer.COPYFILTER("Service Contract No. Filter", "Service Contract No.");//Bc Upgrade YADAVM09 Drink it fields<<
                    // Customer.COPYFILTER("Item Charge Type Filter", "Item Charge Type");//Bc Upgrade YADAVM09 Drink it fields<<
                    DtlCustLedgEntry.SETFILTER("Amount (LCY)", '<=%1', 0);
                    DtlCustLedgEntry.CALCSUMS("Amount (LCY)");
                    CreditAmount := DtlCustLedgEntry."Amount (LCY)";
                    //HEI.01
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.01
                    CLEAR(Vendno);
                    CLEAR(PostingGroup);
                    SETCURRENTKEY("Customer Posting Group", "Customer No.");
                    DebitAmount := 0;
                    CreditAmount := 0
                    //HEI.01
                end;
            }

            trigger OnAfterGetRecord();
            begin
                //HEI.01
                CalcAmounts(
                  PeriodStartDate, PeriodEndDate,
                  PeriodBeginBalance, PeriodDebitAmt, PeriodCreditAmt, YTDTotal);
                //HEI.01
            end;

            trigger OnPreDataItem();
            begin

                //HEI.01
                PeriodFilter := GETFILTER("Date Filter");
                PeriodStartDate := GETRANGEMIN("Date Filter");
                PeriodEndDate := GETRANGEMAX("Date Filter");
                BeginingDate := PeriodStartDate - 1;
                if PeriodStartDate >= PeriodEndDate then
                    ERROR(StartingdateError, PeriodStartDate);
#pragma warning disable ALAL0003
                CurrReport.CREATETOTALS(
                  PeriodBeginBalance, PeriodDebitAmt, PeriodCreditAmt, YTDBeginBalance,
                  YTDDebitAmt, YTDCreditAmt, YTDTotal);
                //HEI.01
#pragma warning disable ALAL0003
            end;
        }
    }

    requestpage
    {
        SaveValues = false;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Split Balance Posting Group Wise"; SplitBalancePostingGroupWise)
                    {
                        Caption = 'Split balance posting group wise';//Bc Upgrade YADAVM09<<
                        ToolTip = 'Split balances by posting group during posting.';
                        ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            SplitBalancePostingGroupWise := true;
        end;
    }

    labels
    {
    }

    var
        DtlCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        RecDetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        Customer1: Record Customer;
        PeriodStartDate: Date;
        PeriodEndDate: Date;
        Vendno: Code[20];
        PostingGroup: Code[20];
        ReportSkip2: Boolean;
        CurrReportPageNoCaptionLbl: TextConst ENU = 'Page', FRA = 'Page';
        VendTrialBalanceCapLbl: TextConst ENU = 'Customer - Trial Balance', FRA = 'Fourn. : Balance';
        AmountsinLCYCaptionLbl: TextConst ENU = 'Amounts in LCY', FRA = 'Montants en DS';
        VendWithEntryPeriodCaptLbl: TextConst ENU = 'Only includes vendors with entries in the period', FRA = 'Inclut uniquement les fournisseurs pour lesquels il existe des écritures dans la période';
        NameCaptLbl: Label 'Name';
        BeginningBalanceCaptLbl: Label 'Beginning Balance';
        NetChangeCaptionLbl: Label 'Net Change';
        DebitCaptionLbl: Label 'Debit';
        CreditCaptionLbl: Label 'Credit';
        MovementCaptionLbl: Label 'Movement';
        EndingBalanceCaptionlbl: Label 'Ending Balance';
        NoCaptionLbl: Label 'No';

        VendorName: Text;
        SplitBalancePostingGroupWise: Boolean;
        PeriodBeginBalance: Decimal;
        PeriodDebitAmt: Decimal;
        PeriodCreditAmt: Decimal;
        YTDBeginBalance: Decimal;
        YTDDebitAmt: Decimal;
        YTDCreditAmt: Decimal;
        YTDTotal: Decimal;
        PeriodFilter: Text;
        StartingdateError: Label 'Ending date should be less then %1';
        BeginingDate: Date;
        SumofMovement: Decimal;
        DebitAmount: Decimal;
        CreditAmount: Decimal;

    local procedure CalcAmounts(DateFrom: Date; DateTo: Date; var BeginBalance: Decimal; var DebitAmt: Decimal; var CreditAmt: Decimal; var TotalBalance: Decimal);
    var
        DetailedVendorLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        //HEI.01
        Customer.SETRANGE("Date Filter", 0D, DateFrom - 1);
        Customer.CALCFIELDS("Net Change (LCY)");
        BeginBalance := Customer."Net Change (LCY)";
        Customer.SETRANGE("Date Filter", DateFrom, DateTo);

        DetailedVendorLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Entry Type", "Currency Code");
        DetailedVendorLedgEntry.SETRANGE("Customer No.", Customer."No.");
        DetailedVendorLedgEntry.SETRANGE("Posting Date", DateFrom, DateTo);
        // Customer.COPYFILTER("Contract Group Filter", "Contract Group Code");//Bc Upgrade YADAVM09 Drink it fields<<
        // Customer.COPYFILTER("DIT Sub-Contract Type Filter", "DIT Sub-Contract Type");//Bc Upgrade YADAVM09 Drink it fields<<
        // Customer.COPYFILTER("Service Contract No. Filter", "Service Contract No.");//Bc Upgrade YADAVM09 Drink it fields<<
        // Customer.COPYFILTER("Item Charge Type Filter", "Item Charge Type");//Bc Upgrade YADAVM09 Drink it fields<<
        // Customer.COPYFILTER("Customer Posting Group Filter", "Customer Posting Group");//Bc Upgrade YADAVM09 Drink it fields<<
        DetailedVendorLedgEntry.SETFILTER("Amount (LCY)", '>%1', 0);
        DetailedVendorLedgEntry.CALCSUMS("Amount (LCY)");
        DebitAmt := DetailedVendorLedgEntry."Amount (LCY)";

        DetailedVendorLedgEntry.SETFILTER("Amount (LCY)", '<=%1', 0);
        DetailedVendorLedgEntry.CALCSUMS("Amount (LCY)");
        CreditAmt := DetailedVendorLedgEntry."Amount (LCY)";
        TotalBalance := BeginBalance + DebitAmt - CreditAmt;
        //HEI.01
    end;
}

