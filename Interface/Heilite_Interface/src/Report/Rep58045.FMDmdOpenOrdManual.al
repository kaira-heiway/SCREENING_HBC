report 58045 "FM DmdOpenOrd Manual"
{
    // version FM

    // BC Upgrade KUMARR78 >>
    //Old Report ID- 50213
    // 1. Added ApplicationArea Property at Report Level
    //    Old: ApplicationArea property was not defined.
    //    New: ApplicationArea = All;
    //    Reason: ApplicationArea property is mandatory in Business Central
    //            to control feature visibility and ensure UI compliance.
    //
    // 2. Added UsageCategory Property at Report Level
    //    Old: UsageCategory property was not defined.
    //    New: UsageCategory = ReportsAndAnalysis;
    //    Reason: UsageCategory is required in Business Central
    //            to make the report searchable via Tell Me functionality.
    //
    // BC Upgrade KUMARR78 <<

    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding Usagecategory
    Caption = 'FuturMaster DP Open Orders';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            MaxIteration = 1;
            RequestFilterFields = "Sell-to Customer No.", "Location Code", "Shipment Date";

            trigger OnAfterGetRecord();
            begin
                SalesLine.CopyFilters("Sales Line");
                FMInterfacefManag.CreateDemandPlanOpenOrders(SalesLine, false);
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

    var
        SalesLine: Record "Sales Line";
        FMInterfacefManag: Codeunit "FM Interface Management";
}

