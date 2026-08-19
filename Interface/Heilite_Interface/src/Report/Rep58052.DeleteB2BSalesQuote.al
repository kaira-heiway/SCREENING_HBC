report 58052 "Delete B2B Sales Quote"
{
    // version HEI.01

    // HEI.01 CHG2174235 IBM COSTES04 20.03.2023 Interface Order Simulation
    //   # new object for DOT order simulation

    // BC Upgrade KUMARR78 >>
    //
    // Report Name : Delete B2B Sales Quote
    // Old Report ID : 50581
    // 1. Added ApplicationArea property at Report level.
    //    Old:
    //         - ApplicationArea property was not defined in NAV.
    //    New:
    //         - ApplicationArea = All;
    //    Reason:
    //         - Required for feature visibility compliance in Business Central.
    // 2. Added UsageCategory property at Report level.
    //    Old:
    //         - UsageCategory property was not defined in NAV.
    //    New:
    //         - UsageCategory = ReportsAndAnalysis;
    //    Reason:
    //         - Enables report discoverability via Tell Me search in Business Central.
    // BC Upgrade KUMARR78 <<

    ProcessingOnly = true;
    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding Usagecategory

    dataset
    {
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
        B2BInterfaceSetup.GET;
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Quote);
        SalesHeader.SETRANGE("Source System Identifier FND", B2BInterfaceSetup."Default Souce System Ident.");
        SalesHeader.SetRange("Document Date", 0D, CalcDate('<-1D>', Today));
        if SalesHeader.FindSet() then
            repeat
                if SalesHeader.Status = SalesHeader.Status::Released then
                    ReleaseSalesDocument.Reopen(SalesHeader);
                SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                SalesLine.DeleteAll(true);

                SalesHeader2.Get(SalesHeader."Document Type", SalesHeader."No.");
                SalesHeader2.Delete(true);
            until SalesHeader.Next() = 0;
    end;

    var
        B2BInterfaceSetup: Record "B2B Interface Setup INT";
        SalesHeader: Record "Sales Header";
        SalesHeader2: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ReleaseSalesDocument: Codeunit "Release Sales Document";
}

