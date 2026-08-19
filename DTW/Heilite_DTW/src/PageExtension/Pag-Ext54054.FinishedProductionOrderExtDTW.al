namespace BC_DTWLocal.BC_DTWLocal;

using Microsoft.Manufacturing.Document;

pageextension 54054 "FinishedProductionOrderExt_DTW" extends "Finished Production Order"
{//BC Upgrade Kamnay01  Created this page extension to add the field  for "Unit of Measure Code" in Finished Production Order page. This field is required for FDD-DTW-003
    layout
    {
        addafter("No.")
        {
            field("Unit of Measure Code"; Rec."Unit of Measure Code FND")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Unit of Measure Code',
                            FRA = 'Code de l''unité de mesure';
            }


        }
    }
}
