report 58014 "FM ProcFirmOrd  Manual"
{
    // version FM

    // HEI.01 OF_F_CORE Supply Planning 008_Proc and Firm Pl order schedule receipts - V 0.1-ChD Com FINAL IBM POSTOI01 01.01.2019
    //   # create object
    // BC Upgrade BHARDA11 >>
    // 1. Old Report Id - 50233
    // 2. Add ApplicationArea and  UsageCategory property in report.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'FuturMaster SP Production Orders Scheduled Receipts';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Prod. Order Line"; "Prod. Order Line")
        {
            MaxIteration = 1;
            // RequestFilterFields = Status, "No. of Quality Tests"; // BC Upgrade BHARDA11 ----Drink-IT Field("No. of Quality Tests")
            RequestFilterFields = Status;

            trigger OnAfterGetRecord();
            begin
                lProductionOrderLine.COPYFILTERS("Prod. Order Line");
                FMInterfacefManag.CreateProcFirmPlannedOrders("Prod. Order Line", false);
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
        lProductionOrderLine: Record "Prod. Order Line";
}

