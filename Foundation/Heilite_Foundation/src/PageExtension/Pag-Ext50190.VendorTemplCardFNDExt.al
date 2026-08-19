namespace General.General;

using Microsoft.Purchases.Vendor;

pageextension 50190 VendorTemplCardFNDExt extends "Vendor Templ. Card"
{
    layout
    {
        addafter("No. Series")
        {
            field("Employee FND"; Rec."Employee FND")
            {
                ApplicationArea = All;
            }
        }
    }
}
