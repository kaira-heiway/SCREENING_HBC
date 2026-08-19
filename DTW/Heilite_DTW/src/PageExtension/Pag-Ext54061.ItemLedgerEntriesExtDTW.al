namespace BC_DTWLocal.BC_DTWLocal;

using Microsoft.Inventory.Ledger;

pageextension 54061 ItemLedgerEntriesExt_DTW extends "Item Ledger Entries"
{//BC Upgrade Kamnay01  Created this page extension to add the field  for "Your Reference" in Item Ledger Entries page. This field is required for FDD-DTW 006
    layout
    {
        addafter("Entry No.")
        {
            field("Your Reference"; Rec."Your Reference FND")
            {
                ApplicationArea = All;
            }
             //BC Upgrade GUNREM01 IBM GAP DTW 73 >> added new field to flow the flow the value from item journal to item leder entry.
            field("Scrap code"; Rec."Scrap code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Scrap Code field.';
            }
            //BC Upgrade GUNREM01 IBM GAP DTW 73 << added new field to flow the flow the value from item journal to item leder entry.
        }
    }
}
