report 58015 "FM StockTraOrd  Manual"
{
    // version FM

    // HEI.01 OF_F_CORE Supply Planning 009_Stock transport order related schedule receipts - V 0.2 FINAl IBM POSTOI01 01.01.2019
    //   # create object
    // BC Upgrade BHARDA11 >>
    // 1. Old Report Id - 50234
    // 2. Add ApplicationArea and  UsageCategory property in report.
    // 3. Remove Drink-IT Field("No. of Packages")
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'FuturMaster SP Stock Transport Order Related Schedule Receipts';
    ProcessingOnly = true;
    dataset
    {
        dataitem("Transfer Line"; "Transfer Line")
        {
            MaxIteration = 1;
            // RequestFilterFields = Status, "No. of Packages"; // BC Upgrade BHARDA11 --Drink-IT Field("No. of Packages")
            RequestFilterFields = Status;

            trigger OnAfterGetRecord();
            begin

                lTransferLines.COPYFILTERS("Transfer Line");
                FMInterfacefManag.CreateStockTranspOrders("Transfer Line", false);
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
        lTransferLines: Record "Transfer Line";
}

