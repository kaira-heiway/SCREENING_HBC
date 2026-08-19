report 58026 "FM Returns Actuals Month 3Year"
{
    //BC Upgrade GUNREM01 Old ID-50590
    // version FM,HEI.01

    // HEI.01 CHG2174570 IBM.SCO 06.12.22 S&OP New Interface Demand Planning for Returns
    //   # new report

    Caption = 'FM Returns Actuals Month 3Year';
    ProcessingOnly = true;
    //BC UPGRADE KUMARR78 Adding++
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    //BC UPGRADE KUMARR78 Adding++

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            MaxIteration = 1;
            RequestFilterFields = "Item No.";

            trigger OnAfterGetRecord();
            begin
                CurrReport.BREAK;
            end;

            trigger OnPreDataItem();
            begin
                ItemLedgerEntry.COPYFILTERS("Item Ledger Entry");
                FMInterfacefManag.CreateReturnActualsMonth3YR(ItemLedgerEntry, false);
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
        ItemLedgerEntry: Record "Item Ledger Entry";
}

