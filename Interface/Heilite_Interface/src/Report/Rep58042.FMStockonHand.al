report 58042 "FM Stock on Hand"
{
    // version FM

    // HEI.01 OF_F_CORE Supply Planning 001_Stock on hand FINAL 1.0 IBM POSTOI01 01.01.2019
    //   # created object
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID- 50221.
    // 2. Add ApplicationArea property in Report.
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'FuturMaster SP Stock On Hand';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            MaxIteration = 1;
            RequestFilterFields = "Item No.";

            trigger OnAfterGetRecord();
            begin
                ILE.COPYFILTERS("Item Ledger Entry");
                FMInterfacefManag.CreateStockOnHand(ILE, FALSE);
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

