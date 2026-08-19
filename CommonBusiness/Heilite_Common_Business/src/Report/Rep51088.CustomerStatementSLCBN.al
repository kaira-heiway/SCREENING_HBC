report 51088 "Customer Statement SL CBN"
{
    // version HEI.01

    // HEI.01 CHG2228480-HB3631 COSTES04 02.08.2024 Sierra Leone Automate the separation of deposit and finish product
    //   # New object created
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea Property in Report and Fields.
    // 2. Add UsageCategory Property in Report.
    // 3. Add Layout Path
    // 4. Remove Drink-It Fields
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Customer Statement SL.rdl';


    dataset
    {
        dataitem(Customer; Customer)
        {
            column(CustNo; Customer."No.")
            {
                IncludeCaption = true;
            }
            column(CustName; Customer.Name)
            {
                IncludeCaption = true;
            }
            column(OpCoLogo; CompanyInfo."OpCo Logo FND")
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(Period; Period)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(BalanceAmount; BalanceAmount)
            {
            }
            column(StatementTitle; StatementTitleTxt)
            {
            }
            column(FooterText; FooterText)
            {
            }
            column(FooterText2; FooterText2)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                // DataItemTableView = '';
                RequestFilterFields = "Posting Date";
                column(EntryNo; "Cust. Ledger Entry"."Entry No.")
                {
                }
                column(PostingDate; "Cust. Ledger Entry"."Posting Date")
                {
                    IncludeCaption = true;
                }
                column(DocumentType; "Cust. Ledger Entry"."Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocumentNo; "Cust. Ledger Entry"."Document No.")
                {
                    IncludeCaption = true;
                }
                column(ExternalDocumentNo; "Cust. Ledger Entry"."External Document No.")
                {
                    IncludeCaption = true;
                }
                // BC Upgrade BHARDA11 >> -----Drink-IT Field ("Item Charge Type")
                // column(ItemChargeType; "Cust. Ledger Entry"."Item Charge Type")
                // {
                //     IncludeCaption = true;
                // }
                column(ItemChargeType; '')
                {
                    // IncludeCaption = true;
                }
                // BC Upgrade BHARDA11 << -----Drink-IT Field ("Item Charge Type")

                column(Description; "Cust. Ledger Entry".Description)
                {
                    IncludeCaption = true;
                }
                column(Amount; "Cust. Ledger Entry".Amount)
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

                trigger OnPreDataItem();
                begin
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields ("Item Charge Type")
                    // if DepositStatement then
                    //     SETRANGE("Item Charge Type", "Cust. Ledger Entry"."Item Charge Type"::Deposit)
                    // else if SalesStatement then
                    //     SETRANGE("Item Charge Type", "Cust. Ledger Entry"."Item Charge Type"::" ");
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields ("Item Charge Type")

                end;
            }

            trigger OnAfterGetRecord();
            begin
                DetailedCustLedgEntry.SETRANGE("Customer No.", Customer."No.");
                DetailedCustLedgEntry.SETFILTER("Posting Date", '<%1', StartDate);
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields ("Item Charge Type")
                // if "Cust. Ledger Entry".GETFILTER("Item Charge Type") <> '' then
                //     DetailedCustLedgEntry.SETFILTER("Item Charge Type", "Cust. Ledger Entry".GETFILTER("Item Charge Type"));
                // BC Upgrade BHARDA11 << ----Drink-IT Fields ("Item Charge Type")

                DetailedCustLedgEntry.CALCSUMS(Amount);

                BalanceAmount := DetailedCustLedgEntry.Amount;
            end;

            trigger OnPreDataItem();
            begin
                StartDate := "Cust. Ledger Entry".GETRANGEMIN("Posting Date");
                if (StartDate <> 0D) and (EndDate <> 0D) then
                    Period := STRSUBSTNO('%1 - %2', FORMAT(StartDate, 0, '<Closing><Day> <Month Text> <Year4>'), FORMAT(EndDate, 0, '<Closing><Day> <Month Text> <Year4>'))
                else
                    Period := "Cust. Ledger Entry".GETFILTER("Posting Date");

                if DepositStatement then begin
                    // "Cust. Ledger Entry".SETRANGE("Item Charge Type", "Cust. Ledger Entry"."Item Charge Type"::Deposit);   // BC Upgrade BHARDA11  ----Drink-IT Fields ("Item Charge Type")
                    StatementTitleTxt := DepositTxt;
                    FooterText2 := FooterDepositTxt2;
                end;

                if SalesStatement then begin
                    // "Cust. Ledger Entry".SETRANGE("Item Charge Type", "Cust. Ledger Entry"."Item Charge Type"::" "); // BC Upgrade BHARDA11  ----Drink-IT Fields ("Item Charge Type")
                    StatementTitleTxt := SalesTxt;
                end;

                FooterText := FooterSalesTxt;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control55000)
                {
                    field(ReportType; ReportType)
                    {
                        ApplicationArea = All;
                        Caption = 'Report Type';
                        ToolTip = 'Specifies the value of the Report Type field.';

                        trigger OnValidate();
                        begin
                            if ReportType = ReportType::Empties then
                                SetDeposit(true)
                            else
                                SetDeposit(false);
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            SetDeposit(false);
        end;
    }

    labels
    {
        ReportTitle = 'CUSTOMER''S STATEMENT OF ACCOUNT'; CustNoLbl = 'Customer No.:'; CustNameLbl = 'Customer Name:'; PeriodLbl = 'Period:'; OpeningBalanceLbl = 'Opening Balance'; ConfirmedByLbl = 'Confirmed By:'; FooterLbl = '"""This is system generated report, signature not required"""'; ForLbl = 'For:'; OtcLeadLbl = 'OTC Lead:'; AccountMngLbl = 'Accounting & Treasury Manager';
    }

    trigger OnPreReport();
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS("OpCo Logo FND");
        CLEAR(StatementTitleTxt);
        CLEAR(FooterText2);
    end;

    var
        CompanyInfo: Record "Company Information";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        DepositStatement: Boolean;
        SalesStatement: Boolean;
        EndDate: Date;
        StartDate: Date;
        BalanceAmount: Decimal;
        DepositTxt: Label 'EMPTIES ACCOUNT';
        FooterDepositTxt: Label 'OTC & Treasury Analyst:';
        FooterDepositTxt2: Label 'Customer Service Coordinator:';
        FooterSalesTxt: Label 'OTC Lead:';
        SalesTxt: Label 'LIQUID ACCOUNT';
        ReportType: Option Liquid,Empties;
        FooterText: Text;
        FooterText2: Text;
        Period: Text;
        StatementTitleTxt: Text;

    procedure SetPeriod(SDate: Date; EDate: Date);
    begin
        StartDate := SDate;
        EndDate := EDate;
    end;

    procedure GetPeriod(): Text;
    begin
        exit(Period);
    end;

    procedure SetDeposit(IsDeposit: Boolean);
    begin
        if IsDeposit then begin
            SalesStatement := false;
            DepositStatement := true;
        end else begin
            DepositStatement := false;
            SalesStatement := true
        end;
    end;

    procedure CustLedgerEntryExist(): Boolean;
    begin
        exit(not "Cust. Ledger Entry".ISEMPTY);
    end;
}

