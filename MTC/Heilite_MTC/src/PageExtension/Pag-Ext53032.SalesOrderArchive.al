pageextension 53032 SalesOrderArchiveExt extends "Sales Order Archive"
{
    // version NAVW110.0,DITW110.00.08

    //     DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time","Created By" Importance Additional
    // DITW18.00.07 VSC 01/07/2016 DIT-770 #1282 Set fields to visible "Creation Date/Time","Created By"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.02 CHG2065153 IBM KUMARN15 23.06.2020
    //   # Added field "Source System Identifier"
    // HEI.03 CHG2084621 HB1742 IBM GAVANM01 23.03.2021 - Sales Quotes functionality
    //   # add field Sales Quote No.

    //Bc Upgrade YADAVM09 Migrated.

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }

        //Unsupported feature: Change ImplicitType on ""Sell-to Address"(Control 8)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Sell-to Address 2"(Control 10)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Sell-to City"(Control 121)". Please convert manually.

        modify(Invoicing)
        {
            CaptionML = ENU = 'Invoicing', FRA = 'Facturation';
        }

        //Unsupported feature: Change ImplicitType on ""Bill-to Address"(Control 40)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Bill-to Address 2"(Control 42)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Bill-to City"(Control 120)". Please convert manually.

        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping', FRA = 'Livraison';
        }

        //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 68)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 70)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 119)". Please convert manually.

        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        }
        modify(Version)
        {
            CaptionML = ENU = 'Version', FRA = 'Version';
        }
        addafter(Status)
        {
            // field("Creation Date/Time";Rec."Creation Date/Time")
            // {
            //     Description = 'DITW18.00.07 DIT-770 #1282';
            //     Importance = Additional;
            // }
            // field("Created By";"Created By")
            // {
            //     Description = 'DITW18.00.07 DIT-770 #1282';
            //     Importance = Additional;
            // }//Bc Upgrade YADAVM09 Drink it field<<
            field("Source System Identifier"; Rec."Source System Identifier FND")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
            field("Sales Quote No."; Rec."Sales Quote No.")
            {
                Description = 'HEI.03';
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
        }
    }
    actions
    {
        modify("Ver&sion")
        {
            CaptionML = ENU = 'Ver&sion', FRA = 'Ver&sion';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Print)
        {
            CaptionML = ENU = 'Print', FRA = 'Imprimer';
        }
        modify(Restore)
        {
            CaptionML = ENU = '&Restore', FRA = '&Restaurer';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

