pageextension 54036 ReleasedProductionOrderExtDTW extends "Released Production Order"
{
    //BC Upgrade GUNREM01 - Created this page extension to add the action.
    //Main page ext is in GEN extension. this ext created to add the action becuase in that actoin we have DTW report.


    layout
    {

    }
    //BC Upgrade GUNREM01 moved this action from GEN To DTW ext >>

    actions
    {
        addafter("Subcontractor - Dispatch List")
        {
            action(ProcessOrderGoodsMovement)
            {
                Caption = 'Process Order Goods Movement';
                Image = "Report";
                //Promoted = false;//Bc Upgrade YADAVM09 
                Promoted = true;//Bc Upgrade YADAVM09 
                                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                PromotedCategory = "Report";
                ApplicationArea = All;
                ToolTip = 'Executes the Process Order Goods Movement action.';

                trigger OnAction();
                var
                    ProductionOrder: Record "Production Order";
                begin
                    //HEI.02>>
                    ProductionOrder.RESET();
                    ProductionOrder.SETRANGE(ProductionOrder.Status, Rec.Status);
                    ProductionOrder.SETRANGE(ProductionOrder."No.", Rec."No.");
                    //  REPORT.RUN(50003, true, true, ProductionOrder);
                    REPORT.RUN(Report::"Process Order Goods Movement", true, true, ProductionOrder);

                    //HEI.02<<
                end;
            }
        }
        //BC Upgrade GUNREM01 moved this action from GEN To DTW ext <<

    }
}
