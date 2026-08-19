report 54022 "IC Transfer Order Batch"
{
    // version HEI.01

    // HEI.01 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
    //   # New Report created to run batch posting of IC Transfer Orders

    // BC Upgrade SHUKLP03 >> NAV Old Id- 50418

    Caption = 'IC Transfer Order Batch';
    ProcessingOnly = true;
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
    UsageCategory = ReportsAndAnalysis; // BC Upgrade SHUKLP03 <<

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("IC Document FND" = FILTER(true));

            trigger OnAfterGetRecord();
            var
                TransferLine: Record "Transfer Line";
                QtyToReceive: Boolean;
                TransferOrderPostReceipt: Codeunit "TransferOrder-Post Receipt";
            begin
                ToLocation.GET("Transfer-to Code");
                if ToLocation."IC Partner Code FND" = '' then
                    CurrReport.SKIP;

                QtyToReceive := false;
                TransferLine.SETRANGE("Document No.", "No.");
                if TransferLine.FINDSET then
                    repeat
                        QtyToReceive := TransferLine."Qty. to Receive" = 0;
                    until (TransferLine.NEXT = 0) or QtyToReceive;

                if not QtyToReceive then
                    TransferOrderPostReceipt.RUN("Transfer Header");
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
        ToLocation: Record Location;
}

