report 58032 "FM Sell in Actuals Month 3Year"
{
    // version FM

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Old Report ID- 50218.
    //BC Upgrade KAPOOV01  <<

    Caption = 'FuturMaster DP Sell in Actuals Month 3 Years';
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
                FMInterfacefManag.CreateSellInActualsMonth3YR(ILE, false);
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

