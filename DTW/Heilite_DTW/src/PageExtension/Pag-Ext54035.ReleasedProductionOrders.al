pageextension 54035 ReleasedProductionOrdersExtDTW extends "Released Production Orders"
{
    //BC Upgrade GUNREM01 - Created this page extension to add the action.
    //Main page ext is in GEN extension. this ext created to add the action becuase in that actoin we have DTW report.


    layout
    {
        addafter("Bin Code")
        {             //BC Upgrade Kamnay01>>field added

            field("Unit of Measure Code"; Rec."Unit of Measure Code FND")
            {
                ApplicationArea = All;
                ToolTipML = ENU = 'Specifies the unit of measure used for production. This field is used to calculate the quantity of components needed for production based on the production quantity and the unit of measure conversion.', FRA = 'Spécifie l''unité de mesure utilisée pour la production. Ce champ est utilisé pour calculer la quantité de composants nécessaires à la production en fonction de la quantité de production et de la conversion d''unité de mesure.';
            }
            //BC Upgrade Kamnay01>>field added

            // field("Gyle No."; Rec."Gyle No.")
            // {
            //     ApplicationArea = All;
            //     CaptionML = ENU = 'Ref No.',
            //                 FRA = 'Gyle N°';
            // } PATHAA02-12.04.26 
        }
    }
    //BC Upgrade GUNREM01 moved this action from GEN To DTW ext >>
    actions
    {
        addafter("Production Order Statistics")
        {
            action(ProcessOrderGoodsMovement)
            {
                Caption = 'Process Order Goods Movement';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ApplicationArea = All;
                ToolTip = 'Executes the Process Order Goods Movement action.';

                trigger OnAction();
                var
                    ProductionOrder: Record "Production Order";
                begin
                    //HEI.01>>
                    ProductionOrder.RESET();
                    ProductionOrder.SETRANGE(ProductionOrder.Status, Rec.Status);
                    ProductionOrder.SETRANGE(ProductionOrder."No.", Rec."No.");
                    // REPORT.RUN(50003, true, true, ProductionOrder);
                    REPORT.RUN(Report::"Process Order Goods Movement", true, true, ProductionOrder);

                    //HEI.01<<
                end;
            }
        }
        //BC Upgrade GUNREM01 moved this action from GEN To DTW ext <<

    }
}
