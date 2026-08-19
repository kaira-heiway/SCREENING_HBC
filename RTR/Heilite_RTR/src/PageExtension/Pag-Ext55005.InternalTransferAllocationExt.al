pageextension 55005 InternalTransferAllocationExt extends "Internal Transfer Allocation"
{
    actions
    {
        addafter("Lot No. Shipping History")
        {
            action("Posted Document Shipping Costs")
            {
                Caption = 'Posted Document Shipping Costs';
                Image = Shipment;
                ApplicationArea = All;
                ToolTip = 'View the posted document shipping costs.';
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PostedDocShippCost: Record "Posted Trade Cost Order APS";
                    TransferShipmentHeader: Record "Transfer Shipment Header";
                    PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
                    PostedDocShippCostPage: Page "Posted Trade Cost Orders APS";
                begin
                    Clear(PostedDocShippCostPage);
                    PostedDocShippCost.SetRange("Posted Whse. Shipment No.", Rec."No.");
                    if not PostedDocShippCost.FindFirst() then
                        if TransferShipmentHeader.Get(Rec."Source No.") then begin
                            PostedWhseReceiptLine.Reset();
                            PostedWhseReceiptLine.SetRange("Source No.", TransferShipmentHeader."Transfer Order No.");
                            if PostedWhseReceiptLine.FindFirst() then
                                PostedDocShippCost.SetRange("Posted Whse. Receipt No.", PostedWhseReceiptLine."No.");
                        end;
                    PostedDocShippCostPage.SetTableView(PostedDocShippCost);
                    PostedDocShippCostPage.LookupMode(true);
                    if PostedDocShippCostPage.RunModal() = Action::LookupOK then;
                end;
            }
        }
    }
}
