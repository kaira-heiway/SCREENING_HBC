report 58030 "FM Sell in Actuals Month"
{
    // version FM

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Old Report ID- 50216.
    //BC Upgrade KAPOOV01  <<

    Caption = 'FuturMaste DP Sell in Actuals Month';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            MaxIteration = 1;
            RequestFilterFields = "Item No.";

            trigger OnAfterGetRecord();
            begin
                ILE.COPYFILTERS("Item Ledger Entry");
                FMInterfacefManag.CreateSellInActualsMonth(ILE, false);
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
        ILE: Record "Item Ledger Entry";
}

