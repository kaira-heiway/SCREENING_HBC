tableextension 50030 CustomerAmountExtFND extends "Customer Amount"
{
    // version NAVW16.00

    fields
    {
        modify("Customer No.")
        {
            CaptionML = ENU = 'Customer No.', FRA = 'N° client';
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

