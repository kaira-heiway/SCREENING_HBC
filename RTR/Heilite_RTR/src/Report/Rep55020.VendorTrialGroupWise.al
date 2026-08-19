report 55020 "Vendor Trial Group Wise"
{
    // version HEI.01

    // HEI.01 CHG2244204 Yadavm09 23.05.2024- Vendor_Customer Trial Balance for reconciliation
    //   # New report Created: 50611

    //Bc Upgrade YADAVM09 Drink it fields blocked.
    DefaultLayout = RDLC;

    RDLCLayout = '.\src\Reportslayout\Vendor Trial Group Wise.rdl';
    Caption = 'Vendor Trial Balance Group Wise';
    PreviewMode = PrintLayout;
    ApplicationArea = ALL; //BC Upgrade YADAVM09<<
    UsageCategory = ReportsAndAnalysis;//BC Upgrade YADAVM09<<

    dataset
    {
        dataitem(Vendor; Vendor)
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
            column(No_Vendor; Vendor."No.")
            {
            }
            column(Name_Vendor; Vendor.Name)
            {
            }
            column(VendorPostingGroup_Vendor; Vendor."Vendor Posting Group")
            {
            }
            column(CurrReportPageNoCaptionLbl; CurrReportPageNoCaptionLbl)
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
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = FIELD("No.");
                // DataItemTableView = SORTING("Vendor No.","Global Dimension 1 Code","Global Dimension 2 Code","Posting Date","Currency Code","Item Charge Type","DIT Sub-Contract Type","Service Contract No.","Vendor Posting Group") ORDER(Ascending);//Bc Upgrade YADAVM09 Drink it field<<
                RequestFilterFields = "Vendor No.", "Posting Date";
                column(VendorNo_VendorLedgerEntry; "Vendor Ledger Entry"."Vendor No.")
                {
                }
                column(VendorPostingGroup_VendorLedgerEntry; "Vendor Ledger Entry"."Vendor Posting Group")
                {
                }
                column(AmountLCY; RecDetailedVendorLedgEntry."Amount (LCY)")
                {
                }
                column(DebitAmountLCY; DebAmount)
                {
                }
                column(CreditAmountLCY; ABS(CredAmount))
                {
                }

                trigger OnAfterGetRecord();
                begin
                    //HEI.01
                    if not SplitBalancePostingGroupWise then
                        CurrReport.SKIP;
                    ReportSkip := false;
                    ReportSkip2 := false;
                    if PostingGroup <> "Vendor Ledger Entry"."Vendor Posting Group" then begin
                        ReportSkip2 := true;
                        PostingGroup := "Vendor Ledger Entry"."Vendor Posting Group";
                    end;


                    if not ReportSkip2 then
                        CurrReport.SKIP;


                    if Vendor1.GET("Vendor Ledger Entry"."Vendor No.") then
                        VendorName := Vendor1.Name;

                    //Opening
                    RecDetailedVendorLedgEntry.RESET;
                    RecDetailedVendorLedgEntry.SETCURRENTKEY("Vendor No.", "Posting Date", "Entry Type", "Currency Code");
                    RecDetailedVendorLedgEntry.SETRANGE("Vendor No.", "Vendor No.");
                    //RecDetailedVendorLedgEntry.SETRANGE("Vendor Posting Group","Vendor Posting Group");//Bc Upgrade YADAVM09 Drink it fields<<
                    RecDetailedVendorLedgEntry.SETRANGE("Posting Date", 0D, PeriodStartDate - 1);
                    //Bc Upgrade YADAVM09 Drink it fields>>
                    // Vendor.COPYFILTER("Contract Group Filter","Contract Group Code");
                    // Vendor.COPYFILTER("DIT Sub-Contract Type Filter","DIT Sub-Contract Type");
                    // Vendor.COPYFILTER("Service Contract No. Filter","Service Contract No.");
                    // Vendor.COPYFILTER("Item Charge Type Filter","Item Charge Type");
                    //Bc Upgrade YADAVM09 Drink it fields<<
                    RecDetailedVendorLedgEntry.CALCSUMS("Amount (LCY)");

                    //Debit
                    DtlVendLedgEntry.RESET;
                    DtlVendLedgEntry.SETCURRENTKEY("Vendor No.", "Posting Date", "Entry Type", "Currency Code");
                    DtlVendLedgEntry.SETRANGE("Vendor No.", "Vendor No.");
                    //DtlVendLedgEntry.SETRANGE("Vendor Posting Group", "Vendor Posting Group");//Bc Upgrade YADAVM09 Drink it fields<<
                    DtlVendLedgEntry.SETRANGE("Posting Date", PeriodStartDate, PeriodEndDate);
                    // Vendor.COPYFILTER("Contract Group Filter", "Contract Group Code");//Bc Upgrade YADAVM09 Drink it fields<<
                    // Vendor.COPYFILTER("Service Contract No. Filter", "Service Contract No.");//Bc Upgrade YADAVM09 Drink it fields<<
                    // Vendor.COPYFILTER("Item Charge Type Filter", "Item Charge Type");//Bc Upgrade YADAVM09 Drink it fields<<
                    DtlVendLedgEntry.SETFILTER("Amount (LCY)", '>%1', 0);
                    DtlVendLedgEntry.CALCSUMS("Amount (LCY)");
                    DebAmount := DtlVendLedgEntry."Amount (LCY)";
                    //Credit
                    DtlVendLedgEntry1.RESET;
                    DtlVendLedgEntry1.SETCURRENTKEY("Vendor No.", "Posting Date", "Entry Type", "Currency Code");
                    DtlVendLedgEntry1.SETRANGE("Vendor No.", "Vendor No.");
                    //DtlVendLedgEntry1.SETRANGE("Vendor Posting Group", "Vendor Posting Group");//Bc Upgrade YADAVM09 Drink it fields<<
                    DtlVendLedgEntry1.SETRANGE("Posting Date", PeriodStartDate, PeriodEndDate);
                    // Vendor.COPYFILTER("Contract Group Filter", "Contract Group Code");//Bc Upgrade YADAVM09 Drink it fields<<
                    // Vendor.COPYFILTER("Service Contract No. Filter", "Service Contract No.");//Bc Upgrade YADAVM09 Drink it fields<<
                    // Vendor.COPYFILTER("Item Charge Type Filter", "Item Charge Type");//Bc Upgrade YADAVM09 Drink it fields<<
                    DtlVendLedgEntry1.SETFILTER("Amount (LCY)", '<=%1', 0);
                    DtlVendLedgEntry1.CALCSUMS("Amount (LCY)");
                    CredAmount := DtlVendLedgEntry1."Amount (LCY)";

                    //HEI.01
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.01
                    CLEAR(Vendno);
                    CLEAR(PostingGroup);
                    SETCURRENTKEY("Vendor Posting Group", "Vendor No.");

                    DebAmount := 0;
                    CredAmount := 0;
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
                CurrReport.CREATETOTALS(
                  PeriodBeginBalance, PeriodDebitAmt, PeriodCreditAmt, YTDBeginBalance,
                  YTDDebitAmt, YTDCreditAmt, YTDTotal);
                //HEI.01
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
                    field("Split Balance Posting Group Wise"; SplitBalancePostingGroupWise)
                    {
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
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        PeriodStartDate: Date;
        PeriodEndDate: Date;
        VendFilter: Text;
        DtlVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        RecDetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        Vendno: Code[20];
        ReportSkip: Boolean;
        PostingGroup: Code[20];
        ReportSkip2: Boolean;
        CurrReportPageNoCaptionLbl: TextConst ENU = 'Page', FRA = 'Page';
        VendTrialBalanceCapLbl: TextConst ENU = 'Vendor - Trial Balance', FRA = 'Fourn. : Balance';
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
        Vendor1: Record Vendor;
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
        StartingdateError: Label 'Ending date should be greater then %1';
        BeginingDate: Date;
        SumofMovement: Decimal;
        DebAmount: Decimal;
        DtlVendLedgEntry1: Record "Detailed Vendor Ledg. Entry";
        CredAmount: Decimal;

    local procedure CalcAmounts(DateFrom: Date; DateTo: Date; var BeginBalance: Decimal; var DebitAmt: Decimal; var CreditAmt: Decimal; var TotalBalance: Decimal);
    var
        DtlVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
    begin
        //HEI.01
        Vendor.SETRANGE("Date Filter", 0D, DateFrom - 1);
        Vendor.CALCFIELDS("Net Change (LCY)");
        BeginBalance := -Vendor."Net Change (LCY)";
        Vendor.SETRANGE("Date Filter", DateFrom, DateTo);

        DtlVendLedgEntry.SETCURRENTKEY("Vendor No.", "Posting Date", "Entry Type", "Currency Code");
        DtlVendLedgEntry.SETRANGE("Vendor No.", Vendor."No.");
        DtlVendLedgEntry.SETRANGE("Posting Date", DateFrom, DateTo);
        // Vendor.COPYFILTER("Contract Group Filter", rec."Contract Group Code");//Bc Upgrade YADAVM09 Drink it fields<<
        // Vendor.COPYFILTER("DIT Sub-Contract Type Filter", rec."DIT Sub-Contract Type");//Bc Upgrade YADAVM09 Drink it fields<<
        // Vendor.COPYFILTER("Service Contract No. Filter", "Service Contract No.");//Bc Upgrade YADAVM09 Drink it fields<<
        // Vendor.COPYFILTER("Item Charge Type Filter", rec."Item Charge Type");//Bc Upgrade YADAVM09 Drink it fields<<
        // Vendor.COPYFILTER("Vendor Posting Group Filter", rec."Vendor Posting Group");//Bc Upgrade YADAVM09 Drink it fields<<
        DtlVendLedgEntry.SETFILTER("Amount (LCY)", '>%1', 0);
        DtlVendLedgEntry.CALCSUMS("Amount (LCY)");
        DebitAmt := DtlVendLedgEntry."Amount (LCY)";
        DtlVendLedgEntry.SETFILTER("Amount (LCY)", '<=%1', 0);
        DtlVendLedgEntry.CALCSUMS("Amount (LCY)");
        CreditAmt := DtlVendLedgEntry."Amount (LCY)";

        //HEI.01
    end;
}

