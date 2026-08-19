report 58023 "FM StockTraOrdVirtual  Manual"
{
    //BC Upgrade GUNREM01 Old ID-50570
    // version FM

    // HEI.01 CHG2139842 IBM.AK 04.03.22 [New FM Outbound Interface-Stock Transfer Order Virtual Warehouse]
    // # New Report- To run the Interface Manually

    Caption = 'FuturMaster SP Stock Transport Order Virtual Related Schedule Receipts';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis; //BC UPGRADE PATHAA02

    dataset
    {
        dataitem("Transfer Line"; "Transfer Line")
        {
            MaxIteration = 1;
            RequestFilterFields = Status;// "No. of Packages"; //BC Upgrade GUNREM01 DIT field

            trigger OnAfterGetRecord();
            begin
                lTransferLines.COPYFILTERS("Transfer Line");
                FMInterfacefManag.CreateStockTOVirtualLoc(lTransferLines, false);
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
        lTransferLines: Record "Transfer Line";
}

