namespace BC_DTWLocal.BC_DTWLocal;

using Microsoft.Inventory.Tracking;

pageextension 54059 LotNoInformationListExt_DTW extends "Lot No. Information List"
{//BC Upgrade Kamnay01  Created this page extension to add the field  for "Your Reference" in Lot No. Information List page. This field is required for FDD-DTW 006
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
