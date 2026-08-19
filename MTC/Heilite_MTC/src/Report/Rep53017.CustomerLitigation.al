report 53017 "Customer - Litigation"
{
    // version HEI.01

    // HEI.01 FDD-OTCGAP057 IBM.NAIKH01 29-06-2017
    //   # Created a new Report to show the Customer under Litigation.

    // BC Upgrade RAHUL>>
    // 1. Added ApplicationArea = All property at report level for BC visibility.
    //    Old: ApplicationArea property not defined at report level.
    //    New: ApplicationArea = All added at report level.
    // 2. Added UsageCategory = ReportsAndAnalysis property at report level for BC search.
    //    Old: UsageCategory not defined.
    //    New: UsageCategory = ReportsAndAnalysis added at report level.
    // 3. No functional logic change required for report execution.
    //    Old: Report logic filters Customer records based on Blocked Reason Code with Type = Litigation.
    //    New: Same logic retained; only BC report discoverability properties added.
    // 4. Report upgrade reference.
    //    Old Report ID: 50001
    //    New: Upgraded for BC with ApplicationArea/UsageCategory compliance.
    // BC Upgrade RAHUL<<


    DefaultLayout = RDLC;
    ApplicationArea = All; // BC Upgrade RAHUL Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade RAHUL Adding Usagecategory

    RDLCLayout = '.\src\ReportsLayout\Customer - Litigation.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Salesperson Code", "Customer Posting Group";
            column(No_Customer; Customer."No.")
            {
            }
            column(CustomerPostingGroup_Customer; Customer."Customer Posting Group")
            {
            }
            column(CustomerDiscGroup_Customer; Customer."Customer Disc. Group")
            {
            }
            column(CustomerPriceGroup_Customer; Customer."Customer Price Group")
            {
            }
            column(PaymentTermsCode_Customer; Customer."Payment Terms Code")
            {
            }
            column(FinChargeTermsCode_Customer; Customer."Fin. Charge Terms Code")
            {
            }
            column(SalespersonCode_Customer; Customer."Salesperson Code")
            {
            }
            column(CurrencyCode_Customer; Customer."Currency Code")
            {
            }
            column(CreditLimitLCY_Customer; Customer."Credit Limit (LCY)")
            {
            }
            column(BalanceLCY_Customer; Customer."Balance (LCY)")
            {
            }
            column(Description; Desc)
            {
            }
            column(CompanyName; CompInfo.Name)
            {
            }
            column(PageNo; CurrReport.PageNo())
            {
            }

            trigger OnAfterGetRecord();
            begin
                BlockedReason.Reset();
                BlockedReason.SetRange(BlockedReason.Code, Customer."Blocked Reason Code FND");
                BlockedReason.SetRange(BlockedReason.Type, BlockedReason.Type::Litigation);
                if not BlockedReason.FindFirst() then
                    CurrReport.Skip();

                Desc := BlockedReason.Description;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        CompInfo.Get();
    end;

    var
        BlockedReason: Record "Blocked Reason FND";
        CompInfo: Record "Company Information";
        Desc: Text[50];
}

