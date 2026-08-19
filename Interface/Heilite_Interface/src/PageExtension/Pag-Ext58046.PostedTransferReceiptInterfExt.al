pageextension 58046 PostedTransferReceiptInterfExt extends "Posted Transfer Receipt"
{
    /* HEI.04 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
  # new field added: LSR Order No */
    // BC Upgrade BHARAD11 >> 
    // 1.For Interface field LSR Order No I have create this extension.
    // BC Upgrade BHARDA11<<
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("LSR Order No"; Rec."LSR Order No FND")
            {
                ApplicationArea = All;
            }
        }
    }
}
