report 58054 "FM SupOpenOrd Manual"
{
    // version FM

    // HEI.01 OF_F_CORE Supply planning 012_Open Orders V 0.1 FINAL IBM POSTOI01 20.05.2019
    //   # create object
    //   # change Caption for the report from SP Open Orders to SP Open Sales Orders

    //Bc Upgrade YADAVM09 old id is 50219.

    Caption = 'FuturMaster SP Open Sales Orders';
    ProcessingOnly = true;
    ApplicationArea = all;//Bc Upgrade YADAVM09<<
    UsageCategory = ReportsAndAnalysis;//Bc Upgrade YADAVM09<<

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            MaxIteration = 1;
            RequestFilterFields = "Sell-to Customer No.", "Location Code", "Shipment Date";

            trigger OnAfterGetRecord();
            begin
                SalesLine.COPYFILTERS("Sales Line");
                FMInterfacefManag.CreateSupplyPlanOpenOrders(SalesLine, false);
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
        FMInterfacefManag: Codeunit "FM Interface Management";
        SalesLine: Record "Sales Line";
}

