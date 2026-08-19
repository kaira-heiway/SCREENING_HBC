report 58031 "FM Sell in Actuals Week"
{
    // version FM

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Old Report ID- 50217.
    //BC Upgrade KAPOOV01  <<

    Caption = 'FuturMaster DP Sell in Actuals Week';
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
                FMInterfacefManag.CreateSellInActualsWeek(ILE, false);
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

