namespace BC_DTWLocal.BC_DTWLocal;

using Microsoft.Inventory.Tracking;

pageextension 54060 LotNoInformationCardExt_DTW extends "Lot No. Information Card"
{//BC Upgrade Kamnay01  Created this page extension to add the field  for "Your Reference" in Lot No. Information Card page. This field is required for FDD-DTW 006
    layout
    {
        addafter("Item No.")
        {
            field("Your Reference"; Rec."Your Reference FND")
            {
                ApplicationArea = All;
            }
        }
    } 
}
