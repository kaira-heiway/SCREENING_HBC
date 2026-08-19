report 58046 "FMr Products Manual"
{
    // version FM
    // BC Upgrade KUMARR78 >>
    //Old Report ID- 50214
    // 1. Added ApplicationArea Property at Report Level
    //    Old: ApplicationArea property was not defined.
    //    New: ApplicationArea = All;
    //    Reason: ApplicationArea property is mandatory in Business Central
    //            to control feature visibility and ensure UI compliance.
    //
    // 2. Added UsageCategory Property at Report Level
    //    Old: UsageCategory property was not defined.
    //    New: UsageCategory = ReportsAndAnalysis;
    //    Reason: UsageCategory is required in Business Central
    //            to make the report searchable via Tell Me functionality.
    //
    // BC Upgrade KUMARR78 <<

    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding Usagecategory

    Caption = 'FuturMaster DP Products Master Data';
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
                FMInterfacefManag.CreateMasterDataProducts(Item, false);
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
        lItem: Record Item;
        FMInterfacefManag: Codeunit "FM Interface Management";
}

