pageextension 51121 PurchaseQuoteArchiveExtCBN extends "Purchase Quote Archive"
{
    // version NAVW110.0,DITW110.00.08, Source Table-Purchase Header Archive
    //     DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time","Created By" Importance Additional
    // DITW18.00.07 VSC 01/07/2016 DIT-770 #1282 Set fields to visible "Creation Date/Time","Created By"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # Created new Page Action "Purchase Additional"
    // HEI.02 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"
    // HEI.03 CHG2024557 FDD-HT821 IBM SHANKJ03 10.02.2020
    //   # New Field added: Maximo status

    //*********************************************************************
    //BC UPGRADE PATHAA02-05.11.25
    //SRM and Maximo fields found
    //Dependency on Page50337-Purch Order Archive Add(Yash-Done, not found in 2nd nov 25 repo so copied from avnish repo) and Table5109-Purchase Header Archive Ext(Manisha-Done, took from 2nd nov common repo)
    //HEI.01-Done, HEI.02-Done,HEI.03-Done
    //BC Upgrade SHUKLP03 >> Added field "Maximo status" in the interface ext.
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }

        //Unsupported feature: Change ImplicitType on ""Buy-from Address"(Control 8)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Buy-from Address 2"(Control 10)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Buy-from City"(Control 95)". Please convert manually.

        modify(Invoicing)
        {
            CaptionML = ENU = 'Invoicing', FRA = 'Facturation';
        }

        //Unsupported feature: Change ImplicitType on ""Pay-to Address"(Control 38)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Pay-to Address 2"(Control 40)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Pay-to City"(Control 96)". Please convert manually.

        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping', FRA = 'Livraison';
        }

        //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 66)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 68)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 97)". Please convert manually.

        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        }
        modify(Version)
        {
            CaptionML = ENU = 'Version', FRA = 'Version';
        }
        //BC UPGRADE PATHAA02-DIT>>
        // addafter("Responsibility Center")
        // {

        // field("Creation Date/Time"; Rec."Creation Date/Time")
        // {
        //     Description = 'DITW18.00.07 DIT-770 #1282';
        //     Importance = Additional;
        // }//F2014411
        // field("Created By"; Rec."Created By")
        // {
        //     Description = 'DITW18.00.07 DIT-770 #1282';
        //     Importance = Additional;
        // }//F2014412            
        // }
        //BC UPGRADE PATHAA02-DIT<<
        addafter(Status)
        {
            // BC Upgrade SHUKLP03 >> Added in the interface ext.
            // field("Maximo Status"; Rec."Maximo Status")
            // {
            // }
            // BC Upgrade SHUKLP03 << Added in the interface ext.
            field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Fixed Asset Acquisition field.';
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
        addafter(Print)
        {
            //HEI.01>>
            action("Purchase Additional")
            {
                Caption = 'Purchase Additional';
                Image = Purchase;
                RunObject = Page "Purch Order Archive Add CBN";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                              "No." = FIELD("No.");
                ApplicationArea = All;
                ToolTip = 'Executes the Purchase Additional action.';
            }
            //HEI.01<<
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

