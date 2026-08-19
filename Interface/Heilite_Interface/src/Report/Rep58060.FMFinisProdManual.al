report 58060 "FM Finis Prod Manual"
{
    // version FM

    // HEI.01 OF_F_CORE Supply Planning 005_ Finished products units of measure - V 0.2 FINAL IBM POSTOI01 01.01.2019
    //   # object created

    // BC Upgrade ATHUKS01 >>
    // 1. Old Report ID- 50228.
    // 2. Add ApplicationArea property in Report.
    // BC Upgrade ATHUKS01 <<

    Caption = 'FuturMaste SP Finished Products UOM';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis; //PATHAA02

    dataset
    {
        dataitem(Item; Item)
        {
            MaxIteration = 1;
            RequestFilterFields = "No.", "Inventory Posting Group", Description;

            trigger OnAfterGetRecord();
            begin
                lItem.COPYFILTERS(Item);
                FMInterfacefManag.CreateFinishedUOMProducts(Item, false);
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

