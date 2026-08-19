report 58016 "FM Actual Production  Manual"
{
    // version FM

    // HEI.01 OF_F_CORE Supply Planning 010_Actual production - V 0.1-ChD Comment FINAL IBM POSTOI01 01.01.2019
    //   # create object
    // BC Upgrade BHARAD11 >>
    // 1. Old Report ID - 50236.
    // 2. Add ApplicationArea and UsageCategory Property in Report.
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'FuturMaster SP Actual Production';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            MaxIteration = 1;
            RequestFilterFields = Status, "No.";

            trigger OnAfterGetRecord();
            begin
                lProductionOrder.COPYFILTERS("Production Order");

                FMInterfacefManag.CreateActualProduction("Production Order", false);
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
        lProductionOrder: Record "Production Order";
}

