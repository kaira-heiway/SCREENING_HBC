namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

pageextension 58018 POPurchaseOrderInterfaceExt extends "PO Purchase Order CBN"
{
    // HEI.15 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New field added in General tab: LSR Order No

    layout
    {
        addafter("Mail Sent Date Time")
        {
            // BC Upgrade SHUKLP03 >> Added in interface ext.
            field("LSR Order No."; PurchaseHeaderAdditional."LSR Order No INT")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the LSR Order No field.';
            }
            // BC Upgrade SHUKLP03 << Added in interface ext.

        }

    }

    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";

}
