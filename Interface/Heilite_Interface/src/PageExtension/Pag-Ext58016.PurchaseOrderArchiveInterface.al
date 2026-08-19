namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Purchases.Archive;

pageextension 58016 PurchaseOrderArchiveInterfaExt extends "Purchase Order Archive"
{
    // BC Upgrade SHUKLP03 >> 
    // SRM, Maximo, LSR Interface Fields added
    // BC Upgrade SHUKLP03 << 

    layout
    {
        addafter(Status)
        {
            field("LSR Order No. INT"; PurchaseHeaderAdditional."LSR Order No INT")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LSR Order No field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the LSR Order No field.';

            }
            field("Maximo Status"; Rec."Maximo Status INT")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Maximo Status field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Maximo Status field.';

            }
        }
        addafter(Version)
        {
            group(SRM)
            {
                Caption = 'SRM';
                field("Shopping Card No."; Rec."Shopping Card No. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shopping Card No. field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Shopping Card No. field.';

                }
                field("Shopping Card Creation Date"; PurchaseHeaderArchiveAdditional."Shopping Card Creati Date INT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shopping Card Creation Date field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Shopping Card Creation Date field.';

                }
            }
        }

    }

    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchaseHeaderArchiveAdditional: Record "Purchase Header Arch Addit FND";


}
