report 58043 "FM Comp Prod Manual"
{
    // version FM

    // HEI.01 OF_F_CORE Supply Planning 004_ Component product master - V 0.3 FINAL IBM POSTOI01 01.01.2019
    //   # create object
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID- 50222.
    // 2. Add ApplicationArea property in Report.
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'FuturMaster SP Component Products Master Data';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            MaxIteration = 1;
            RequestFilterFields = "No.", "Inventory Posting Group", Description;

            trigger OnAfterGetRecord();
            begin
                lItem.COPYFILTERS(Item);
                FMInterfacefManag.CreateComponentDataProducts(Item, FALSE);
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
        lItem: Record Item;
}

