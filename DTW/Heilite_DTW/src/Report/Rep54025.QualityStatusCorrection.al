report 54025 "Quality Status Correction"
{
    // version HEI.01- one time execution syed

    // HEI.01 INC2116490 IBM NASTAA02 18.04.2019 # Quality Status
    //   # New Report created to update the Quality Status to 'Unrestricted' for no Lot Tracked Items

    // BC Upgrade KUMARR78 >>
    // Report Name  : Quality Status Correction
    // Report ID    : 50143
    // 1. Added Business Central visibility properties.
    //    Old:
    //         - ApplicationArea not defined in NAV.
    //         - UsageCategory not defined.
    //    New:
    //         - ApplicationArea = All
    //         - UsageCategory = ReportsAndAnalysis
    // BC Upgrade KUMARR78 <<

    Caption = 'Quality Status Correction for Warehouse Entries';
    Permissions = TableData "Warehouse Entry" = rimd;
    ProcessingOnly = true;
    ApplicationArea = All; // BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade KUMARR78 Adding Usagecategory


    dataset
    {
        dataitem("Warehouse Entry"; "Warehouse Entry")
        {
            DataItemTableView = WHERE("Inspection Status FND" = const('ON HOLD'));//Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43
            trigger OnAfterGetRecord();
            var
                Item: Record Item;
                inventorySetup: Record "Inventory Setup";
            begin
                Item.RESET();
                Item.GET("Item No.");
                inventorySetup.GET();
                if Item."Item Tracking Code" = '' then begin
                    "Inspection Status FND" := inventorySetup."Quality Unrestricted FND"; //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43
                    MODIFY();
                end;
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

    trigger OnPostReport();
    begin
        MESSAGE('Done!');
    end;
}

