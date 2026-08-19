tableextension 50032 ItemAmountExtFND extends "Item Amount"
{
    // version NAVW16.00

    fields
    {
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Amount 2")
        {
            CaptionML = ENU = 'Amount 2', FRA = 'Montant 2';
        }
    }

    //Unsupported feature: PropertyChange. Please convert manually.

}

