report 58012 "FM SemiFinish  Manual"
{
    // version FM

    // HEI.01 OF_F_CORE Supply Planning 003_ Semi-Finished product master - V 0.3 FINAL IBM POSTOI01 01.01.2019
    //   # Create object
    // BC Upgrade BHARDA11 >>
    // 1. Old Report Id - 50230.
    // 2. Add ApplicationArea and  UsageCategory property in report.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'FuturMasterSP Semi Finished Products Master';
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
                FMInterfacefManag.CreateSemiFinished(Item, false);
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

