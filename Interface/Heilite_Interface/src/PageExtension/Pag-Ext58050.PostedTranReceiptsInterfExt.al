pageextension 58050 PostedTranReceiptsInterfExt extends "Posted Transfer Receipts"
{
    /* HEI.03 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
            # new field added: LSR Order No */
    layout
    {
        addafter("Receipt Date")
        {
            field("LSR Order No"; Rec."LSR Order No FND")
            {
                ApplicationArea = All;
            }
        }
    }
}
