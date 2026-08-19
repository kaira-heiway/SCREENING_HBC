// namespace INTERFACES.INTERFACES;

// using Microsoft.Sales.History;

pageextension 58030 PostedSalesInvSubInterfExt extends "Posted Sales Invoice Subform"
/* 
HEI.04 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
      # New Field added: "Suppress POS Interface"
 */
// BC Upgrade BHARDA11 >>
// 1.Add Interface fields in this extension and remove from MTC Extension.
// 2. Add ApplicationArea Property in the fields and Action.
// 3. Remove PAC Interface is out of scope
// BC Upgrade BHARDA11 <<
{
    layout
    {
        addafter("TIN No.")
        {
            field("Suppress POS Interface"; Rec."Suppress POS Interface FND")
            {
                ApplicationArea = All;
            }
        }
    }
}
