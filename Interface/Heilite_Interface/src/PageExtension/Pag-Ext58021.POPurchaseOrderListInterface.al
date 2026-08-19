namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

pageextension 58021 POPurchaseOrderListInterfacExt extends "PO Purchase Order List CBN"
{
    // HEI.10 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New field added in General tab: LSR Order No

    layout
    {
        addafter("Mail Sent Date Time")
        {
            // BC Upgrade SHUKLP03 >> Added in interface ext.
            field("LSR Order No."; PurchaseHeaderAdditional."LSR Order No INT")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the LSR Order No field.';
            }
            // BC Upgrade SHUKLP03 << Added in interface ext.
        }
    }

    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
}
