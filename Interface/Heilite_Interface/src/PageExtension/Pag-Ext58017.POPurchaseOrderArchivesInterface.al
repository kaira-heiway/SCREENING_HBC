namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

pageextension 58017 POPurchaseOrderArchivesExt extends "PO Purchase Order Archives CBN"
{
    // HEI.04 CHG2121745 IBM BHATTA09 25.11.2021 - SRM - SC fields to be added in HL
    //   # Added "Shopping Card Creation Date" in the page

    layout
    {
        addafter("Shopping Card No.")
        {
            // BC Upgrade SHUKLP03 >>
            field("Shopping Card Creation Date"; PurchaseHeaderArchiveAdditional."Shopping Card Creati Date INT")
            {
                Caption = 'Shopping Card Creation Date';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shopping Card Creation Date field.';
            }
            // BC Upgrade SHUKLP03 <<
        }
    }

    var
        PurchaseHeaderArchiveAdditional: Record "Purchase Header Arch Addit FND";
}
