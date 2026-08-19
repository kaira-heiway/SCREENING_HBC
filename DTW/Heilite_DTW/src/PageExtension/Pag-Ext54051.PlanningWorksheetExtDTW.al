namespace BC_DTWLocal.BC_DTWLocal;

using Microsoft.Inventory.Requisition;

pageextension 54051 "PlanningWorksheetExt_DTW" extends "Planning Worksheet"
{//BC Upgrade Kamnay01  Created this page extension to add the field  for "Production Unit of Measure" in Planning Worksheet page.
    layout
    {
        addafter("Location Code")
        {
            field("Production Unit of Measure"; Rec."Production Unit of Measure FND")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Production Unit of Measure',
                            FRA = 'Unité de production';
            }
        }
    }
}
