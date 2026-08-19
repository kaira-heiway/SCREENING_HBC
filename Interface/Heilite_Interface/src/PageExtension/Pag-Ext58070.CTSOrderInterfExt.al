// namespace INTERFACES.INTERFACES;

pageextension 58070 CTSOrderInterfExt extends "CTS Order"
{
    /*  // HEI.10 FDD-ET-MARAKI POS Interface IBM POSTOI01 # Maraki POS Interface
    //   # show field Suppress POS Interface field */
    layout
    {
        addafter("Approval Status")
        {
            field("Suppress POS Interface"; Rec."Suppress POS Interface FND")
            {
                ApplicationArea = All;
            }
        }
    }
}
