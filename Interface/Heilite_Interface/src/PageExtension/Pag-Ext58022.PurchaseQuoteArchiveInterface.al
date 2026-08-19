namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Purchases.Archive;

pageextension 58022 PurchaseQuoteArchiveInterfaExt extends "Purchase Quote Archive"
{
    // HEI.03 CHG2024557 FDD-HT821 IBM SHANKJ03 10.02.2020
    //   # New Field added: Maximo status

    layout
    {
        addafter(Status)
        {
            field("Maximo Status"; Rec."Maximo Status INT")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Maximo Status field.';
                //BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Maximo Status field.';

            }

        }
    }
}