pageextension 58014 PurchaseQuoteSubformIntExt extends "Purchase Quote Subform"
{
    // HEI.01 FDD-PRDGAP031 IBM PATHAA02 09.11.2017
    // #Code on OnAfterGetRecord
    // HEI.02 Defect#818 14/12/2017 IBM.CHAUHB01 Added fields "Machine Reference Number"
    // HEI.03 FDD_Ethiopia_Tolerance field for SPOT PO  Overdelivery_V0.1_HT630 IBM HORTOC01 28.06.2019 # new field added "Tolerance Received Over %"
    // HEI.04 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //   # SPL Code, SPL Name - fields added
    //BC Upgrade SHARMP16 -- Interface fields from main Ext page.
    layout
    {
        addafter("Expected Receipt Date")//Bc Upgrade SHARMP16 PurchProcesschanges
        {
            field("Maximo Requisition No."; Rec."Maximo Requisition No. FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Maximo Requisition No. field.';
            }
            field("Maximo Requisition Line No."; Rec."Maximo Requis. Line No. FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Maximo Requisition Line No. field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}