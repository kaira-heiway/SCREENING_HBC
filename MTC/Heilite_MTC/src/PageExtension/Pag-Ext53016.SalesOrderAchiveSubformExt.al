pageextension 53016 SalesOrderAchiveSubformExt extends "Sales Order Archive Subform"
{
    // version NAVW110.0,HEI.01
    /*  HEI.01 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
        # New Field added - "TIN No." */
        // BC Upgrade BHARDA11 >>
        // 1. Add ApplicationArea Property in "TIN No." Field.
        // BC Upgrade BHARDA11 <<

    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("TIN No."; Rec."TIN No. FND")
            {
                ApplicationArea = All;
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

            //Unsupported feature: Change AccessByPermission on "Dimensions(Action 1907838004)". Please convert manually.

            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(DeferralSchedule)
        {
            CaptionML = ENU = 'Deferral Schedule', FRA = 'Tableau d''échelonnement';
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Line"(Action 1907935204)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Dimensions(Action 1907838004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Co&mments"(Action 1903079504)". Please convert manually.

    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

