report 58055 "FM Sell in Actuals Week 3Year"
{
    // version FM
    //Bc Upgrade YADAVM09 old id is 50220.
    Caption = 'FuturMaster DP Sell in Actuals Week 3 Years';
    ProcessingOnly = true;
    ApplicationArea = all;//Bc Upgrade YADAVM09<<
    UsageCategory = ReportsAndAnalysis;//Bc Upgrade YADAVM09<<

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            MaxIteration = 1;
            RequestFilterFields = "Item No.";

            trigger OnAfterGetRecord();
            begin
                ILE.COPYFILTERS("Item Ledger Entry");
                FMInterfacefManag.CreateSellInActualsWeek3YR(ILE, false);
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

