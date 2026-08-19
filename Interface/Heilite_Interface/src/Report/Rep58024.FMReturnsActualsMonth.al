report 58024 "FM Returns Actuals Month"
{
    //BC Upgrade GUNREM01 Old ID-50588
    // version FM,HEI.01

    // HEI.01 CHG2174570 IBM.SCO 06.12.22 S&OP New Interface Demand Planning for Returns
    //   # new report

    Caption = 'FutureMaster DP Returns Actuals Month';
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
                FMInterfacefManag.CreateReturnActualsMonth(ItemLedgerEntry, false);
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

