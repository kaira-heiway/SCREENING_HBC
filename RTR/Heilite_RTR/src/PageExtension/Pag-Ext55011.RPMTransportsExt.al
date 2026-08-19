pageextension 55011 RPMTransportsExt extends "RPM Transports"
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
                    PostedDocShippCostPage: Page "Posted Trade Cost Orders APS";
                begin
                    Clear(PostedDocShippCostPage);
                    PostedDocShippCost.SetRange("Posted Whse. Shipment No.", Rec."No.");
                    if PostedDocShippCost.FindFirst() then begin
                        PostedDocShippCostPage.SetTableView(PostedDocShippCost);
                        PostedDocShippCostPage.LookupMode(true);
                        if PostedDocShippCostPage.RunModal() = Action::LookupOK then;
                    end else begin
                        PostedDocShippCost.SetRange("Posted Whse. Receipt No.", Rec."No.");
                        if PostedDocShippCost.FindFirst() then begin
                            PostedDocShippCostPage.SetTableView(PostedDocShippCost);
                            PostedDocShippCostPage.LookupMode(true);
                            if PostedDocShippCostPage.RunModal() = Action::LookupOK then;
                        end;
                    end;
                end;
            }
        }
    }
}
