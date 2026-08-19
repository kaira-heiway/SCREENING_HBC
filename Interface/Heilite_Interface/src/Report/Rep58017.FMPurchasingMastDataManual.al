report 58017 "FM Purchasing MastData  Manual"
{
    // version FM

    // HEI.01 OF_F_CORE Supply Planning 011_Purchasing Master Data V 0.1-ChD Comment FINAL IBM POSTOI01 01.01.2019
    //   # create object
    // BC Upgrade BHARAD11 >>
    // 1. Old Report ID - 50238.
    // 2. Add ApplicationArea and UsageCategory Property in Report.
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'FuturMaster SP Purchasing Master Data';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            MaxIteration = 1;
            RequestFilterFields = Status, "No.";

            trigger OnAfterGetRecord();
            begin
                lPurchaseHeader.COPYFILTERS("Purchase Header");

                FMInterfacefManag.CreatePurchMasterData("Purchase Header", false);
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
        lPurchaseHeader: Record "Purchase Header";
}

