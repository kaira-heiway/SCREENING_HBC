pageextension 53036 SalesReturnOrderArcSubformExt extends "Sales Return Order Arc Subform"
{
    // version NAVW110.0,HEI.01

    // HEI.01 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //  # New Field added - "TIN No."

    //************************//
    //BC UPGRADE SIVA 01-02-20206// 
    //1.HEI.01 Added TIN No. 
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("TIN No."; Rec."TIN No. FND")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Comments)
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(DeferralSchedule)
        {
            CaptionML = ENU = 'Deferral Schedule', FRA = 'Tableau d''échelonnement';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

