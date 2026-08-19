tableextension 50031 VendorAmountExtFND extends "Vendor Amount"
{
    // version NAVW16.00

    fields
    {
        modify("Vendor No.")
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';
        }
        modify("Amount (LCY)")
        {
            CaptionML = ENU = 'Amount (LCY)', FRA = 'Montant DS';
        }
        modify("Amount 2 (LCY)")
        {
            CaptionML = ENU = 'Amount 2 (LCY)', FRA = 'Montant 2 DS';
        }
    }

    //Unsupported feature: PropertyChange. Please convert manually.

}

