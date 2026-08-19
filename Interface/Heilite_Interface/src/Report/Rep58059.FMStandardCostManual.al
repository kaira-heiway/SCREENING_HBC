report 58059 "FM Standard Cost Manual"
{
    // version FM

    // HEI.01 OF_F_CORE Supply Planning 002_ Standard cost- V 0.2 FINAL IBM POSTOI01 01.01.2019
    //   # create object

    // BC Upgrade ATHUKS01 >>
    // 1. Old Report ID- 50224.
    // 2. Add ApplicationArea property in Report.
    // BC Upgrade ATHUKS01 <<

    ApplicationArea = all;

    UsageCategory = ReportsAndAnalysis; //BC UPGRADE PATHAA02
    Caption = 'FuturMaster SP Standard Costs';
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
                FMInterfacefManag.CreateStandardCost(Item, false);
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

