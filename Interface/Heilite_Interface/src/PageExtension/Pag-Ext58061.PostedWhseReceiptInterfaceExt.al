namespace LatestInterfaceP.LatestInterfaceP;

using Microsoft.Warehouse.History;

pageextension 58061 PostedWhseReceiptInterfaceExt extends "Posted Whse. Receipt"
{
    // HEI.04 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New fields added in General tab: LSR Order No, LSR Receipt No

    layout
    {
        addafter("Assignment Time")
        {
            field("LSR Order No."; Rec."LSR Order No. FND") // BC Upgrade SHUKLP03 << 
            {
                ApplicationArea = All;
            }
            field("LSR Receipt No."; Rec."LSR Receipt No. FND") // BC Upgrade SHUKLP03 << 
            {
                ApplicationArea = All;
            }
        }

    }
}
