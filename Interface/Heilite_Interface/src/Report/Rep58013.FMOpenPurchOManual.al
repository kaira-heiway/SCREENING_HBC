report 58013 "FM OpenPurchO  Manual"
{
    // version FM

    // HEI.01 OF_F_CORE Supply Planning 007_Open purchase orders - V 0.1-ChD (No) Comment FINAL IBM POSTOI01 01.01.2019
    //   # create object
    // BC Upgrade BHARDA11 >>
    // 1. Old Report Id - 50232
    // 2. Add ApplicationArea and  UsageCategory property in report.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'FuturMaster SP Open Purchase Order';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            MaxIteration = 1;
            RequestFilterFields = "Location Code", "Posting Group";

            trigger OnAfterGetRecord();
            begin
                lPurchaseLine.COPYFILTERS("Purchase Line");
                FMInterfacefManag.CreateSupplyPlanPurchOpenOrders("Purchase Line", false);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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
        FMInterfacefManag: Codeunit "FM Interface Management";
        lPurchaseLine: Record "Purchase Line";
}

