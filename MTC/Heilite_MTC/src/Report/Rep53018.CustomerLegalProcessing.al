report 53018 "Customer - Legal Processing"
{
    // version HEI.01

    // HEI.01 FDD-OTCGAP026 IBM.Hortoc01 11-07-2017
    //   # Created a new Report to show the Customer Legal.

    // BC Upgrade RAHUL>>
    // 1. Added ApplicationArea = All property at report level for BC visibility.
    //    Old: ApplicationArea property not defined at report level.
    //    New: ApplicationArea = All added at report level.
    // 2. Added UsageCategory = ReportsAndAnalysis property at report level for BC search.
    //    Old: UsageCategory not defined.
    //    New: UsageCategory = ReportsAndAnalysis added at report level.
    // 3. Updated page number call to BC supported syntax.
    //    Old: column(PageNo; CurrReport.PAGENO)
    //    New: column(PageNo; CurrReport.PageNo())
    // 4. No functional logic change required for report execution.
    //    Old: Report skips Customer records if Blocked Reason Code is not of Type = Legal.
    //    New: Same logic retained; only BC compatibility adjustment for PageNo.
    // 5. Report upgrade reference.
    //    Old Report ID: 50002
    //    New: Upgraded for BC with ApplicationArea/UsageCategory compliance and PageNo fix.
    // BC Upgrade RAHUL<<

    DefaultLayout = RDLC;
    ApplicationArea = All; // BC Upgrade RAHUL Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade RAHUL Adding Usagecategory

    RDLCLayout = '.\src\ReportsLayout\Customer - Legal Processing.rdl';


    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Salesperson Code", "Customer Posting Group", "Blocked Reason Code FND";
            column(No_Customer; Customer."No.")
            {
            }
            column(CustomerPostingGroup_Customer; Customer."Customer Posting Group")
            {
                IncludeCaption = true;
            }
            column(CustomerDiscGroup_Customer; Customer."Customer Disc. Group")
            {
                IncludeCaption = true;
            }
            column(PaymentTermsCode_Customer; Customer."Payment Terms Code")
            {
                IncludeCaption = true;
            }
            column(FinChargeTermsCode_Customer; Customer."Fin. Charge Terms Code")
            {
                IncludeCaption = true;
            }
            column(SalespersonCode_Customer; Customer."Salesperson Code")
            {
                IncludeCaption = true;
            }
            column(CurrencyCode_Customer; Customer."Currency Code")
            {
                IncludeCaption = true;
            }
            column(CreditLimitLCY_Customer; Customer."Credit Limit (LCY)")
            {
                IncludeCaption = true;
            }
            column(BalanceLCY_Customer; Customer."Balance (LCY)")
            {
                IncludeCaption = true;
            }
            column(CustomerPriceGroup_Customer; Customer."Customer Price Group")
            {
                IncludeCaption = true;
            }
            column(Description; BlockedReason.Description)
            {
                IncludeCaption = true;
            }
            column(CompanyName; CompInfo.Name)
            {
            }
            column(PageNo; CurrReport.PAGENO())
            {
            }
            column(Text001; Text001)
            {
            }
            column(Text002; Text002)
            {
            }

            trigger OnAfterGetRecord();
            begin
                if not BlockedReason.GET(Customer."Blocked Reason Code FND", BlockedReason.Type::Legal) then
                    CurrReport.SKIP();

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
        CompInfo.GET();
    end;

    var
        BlockedReason: Record "Blocked Reason FND";
        CompInfo: Record "Company Information";
        Text001: Label 'Customer No.';
        Text002: Label 'Legal Reason';
        Desc: Text[50];
}

