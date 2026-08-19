namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Sales.Receivables;

pageextension 58025 CustomerLedgerEntriesInterfExt extends "Customer Ledger Entries"
{
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 17.08.2017 # MDM Customer Card
    //   # New fields:
    //     - Rem. Amt for WHT
    //     - Rem. Amt
    //     - WHT Amount
    //     - WHT Amount (LCY)

    layout
    {
        addafter("Direct Debit Mandate ID")
        {
            // BC Upgrade SHUKLP03 << 
            field("WHT Amount"; Rec."WHT Amount FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Amount field.';
            }
            field("WHT Amount (LCY)"; Rec."WHT Amount (LCY) FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Amount (LCY) field.';
            }
            field("Rem. Amt"; Rec."Rem. Amt FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Rem. Amt field.';
            }
            field("Rem. Amt for WHT"; Rec."Rem. Amt for WHT FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Rem. Amt for WHT field.';
            }
            // BC Upgrade SHUKLP03 << 
        }
    }
}
