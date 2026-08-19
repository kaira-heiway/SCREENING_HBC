pageextension 58047 PostedTransferShipmentInterfEx extends "Posted Transfer Shipment"
{
    /* 
HEI.04 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
        # new field added: LSR Order No
 */
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
