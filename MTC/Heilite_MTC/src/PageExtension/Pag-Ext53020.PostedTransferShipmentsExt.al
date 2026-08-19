pageextension 53020 PostedTransferShipmentsExt extends "Posted Transfer Shipments"
{
    // version NAVW110.0,DITW110.00.08,HEI.05
    /*  DITW15.00.00.25 DDR 10/10/2008 Added fields
                                           "Shipping Agent Code","Shipping Agent Service Code","Shipment Method Code"
                                           "Transaction Type","Transport Method","Entry/Exit Point",Area
                                           "Transaction Specification","Truck Code","Driver Code"
          DITW15.00.00.37 DDR 28/05/2010 issue 480 Added fields
                                           "Trsf-from Ph. Location Gr Code","Trsf-to Ph. Location Gr Code"
          DITW15.00.00.38 DDR 17/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
                                           Added columns
                                             "Tax Registration No.","Fiscal Representative No.",
                                             "Tax Warehouse Reference"
          DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code

          DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

          HEI.01 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
            # New Field added: "IC Document"
          HEI.02 FDD-HB1438 CHG2065311 IBM SHANKJ03 30.07.2020
            # New Field created : PO Reference & Extra PO reference
          HEI.03 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
            # new field added: LSR Order No
          HEI.04 CHG2200434 IBM COSTES04 19.05.2023 Column Data Availability of WH Shipment & WH Receipt No
            # New field added Posted Whse. Shipment No.
          HEI.05 CHG2216722 IBM SISUM01 02.10.2023  Request for email functionality for Transfer Order Creation
            # Add the new field id 50021 */
            // BC Upgrade BHARDA11 >>
            // 1. Add ApplicationArea Property in All custom Fields.
            // 2. Remove Drink-IT Fields("Trsf-from Ph. Location Gr Code", "Trsf-to Ph. Location Gr Code","Truck Code", "Driver Code", "Fiscal Representative No.", "Tax Registration No.", "Tax Warehouse Reference")
            // 3. Move LSR Order No Field to Interface Extension
            // BC Upgrade BHARAD11 <<
    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the transfer shipment.', FRA = 'Spécifie le numéro du transfert expédition.';
        }
        modify("Transfer-from Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location that you are transferring items from.', FRA = 'Spécifie le code du magasin à partir duquel vous transférez les articles.';
        }
        modify("Transfer-to Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location that you are transferring items to.', FRA = 'Spécifie le code du magasin vers lequel vous transférez les articles.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date for this document.', FRA = 'Spécifie la date comptabilisation de ce document.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code for the dimension that has been chosen as Global Dimension 1.', FRA = 'Spécifie le code section analytique de l''axe choisi comme axe principal 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code for the dimension that has been chosen as Global Dimension 2.', FRA = 'Spécifie le code section analytique de l''axe choisi comme axe principal 2.';
        }
        modify("Shipment Date")
        {
            ToolTipML = ENU = 'Specifies the shipment date of the transfer order.', FRA = 'Spécifie la date d''expédition de l''ordre de transfert.';
        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies a code that represents the shipment method.', FRA = 'Spécifie un code qui représente les conditions de livraison.';

            //Unsupported feature: Change Name on ""Shipment Method Code"(Control 1102601003)". Please convert manually.

        }
        modify("Shipping Agent Code")
        {
            ToolTipML = ENU = 'Specifies the code for the shipping agent you have used for this transfer shipment.', FRA = 'Indique le code du transporteur utilisé pour cette expédition transfert.';

            //Unsupported feature: Change Name on ""Shipping Agent Code"(Control 1102601005)". Please convert manually.

        }
        modify("Receipt Date")
        {
            ToolTipML = ENU = 'Specifies the receipt date of the transfer order.', FRA = 'Spécifie la date de réception de l''ordre de transfert.';
        }

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Code"(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Code"(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to Code"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to Code"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 1102601001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 1102601001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Method Code"(Control 1102601003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Code"(Control 1102601005)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Receipt Date"(Control 1102601007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Receipt Date"(Control 1102601007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

        // addafter("No.")
        // {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Trsf-from Ph. Location Gr Code", "Trsf-to Ph. Location Gr Code")
            // field("Trsf-from Ph. Location Gr Code"; Rec."Trsf-from Ph. Location Gr Code")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Trsf-to Ph. Location Gr Code"; Rec."Trsf-to Ph. Location Gr Code")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Trsf-from Ph. Location Gr Code", "Trsf-to Ph. Location Gr Code")

        // }

        addafter("Shortcut Dimension 2 Code")
        {
            field("Transaction Type"; Rec."Transaction Type")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Transaction Specification"; Rec."Transaction Specification")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Transport Method"; Rec."Transport Method")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Entry/Exit Point"; Rec."Entry/Exit Point")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Area"; Rec."Area")
            {
                ApplicationArea = All;
            }
            field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
            {
                ApplicationArea = All;
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Truck Code", "Driver Code", "Fiscal Representative No.", "Tax Registration No.", "Tax Warehouse Reference")
            // field("Truck Code"; Rec."Truck Code")
            // {
            //     ApplicationArea = All;
            // }
            // field("Driver Code"; Rec."Driver Code")
            // {
            //     ApplicationArea = All;
            // }
            // field("Fiscal Representative No."; Rec."Fiscal Representative No.")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Tax Registration No."; Rec."Tax Registration No.")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Tax Warehouse Reference"; Rec."Tax Warehouse Reference")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Truck Code", "Driver Code", "Fiscal Representative No.", "Tax Registration No.", "Tax Warehouse Reference")
        }
        addafter("Receipt Date")
        {
            field("IC Document"; Rec."IC Document FND")
            {
                ApplicationArea = All;
            }
            field("PO Reference"; Rec."PO Reference FND")
            {
                ApplicationArea = All;
            }
            field("Extra PO Reference"; Rec."Extra PO Reference FND")
            {
                ApplicationArea = All;
            }
            field("Transfer Order No."; Rec."Transfer Order No.")
            {
                ApplicationArea = All;
            }

            field("Posted Whse. Shipment No."; Rec."Posted Whse. Shipment No. FND")
            {
                ApplicationArea = All;
            }
            field("Email Sent-Ship"; Rec."Email Sent-Ship FND")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
        }
    }
    actions
    {
        modify("&Shipment")
        {
            CaptionML = ENU = '&Shipment', FRA = 'E&xpédition';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';

            //Unsupported feature: Change RunObject on "Statistics(Action 19)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "Statistics(Action 19)". Please convert manually.

            Promoted = true;
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';

            //Unsupported feature: Change RunObject on ""Co&mments"(Action 20)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Co&mments"(Action 20)". Please convert manually.

        }
        modify(Dimensions)
        {

            //Unsupported feature: Change AccessByPermission on "Dimensions(Action 1102601000)". Please convert manually.

            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("&Print")
        {

            //Unsupported feature: Change Ellipsis on ""&Print"(Action 22)". Please convert manually.

            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            Promoted = true;
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            Promoted = true;
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000003(Action 1900000003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Shipment"(Action 17)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Statistics(Action 19)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Co&mments"(Action 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Dimensions(Action 1102601000)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.



        //Unsupported feature: CodeModification on ""&Print"(Action 22).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(TransShptHeader);
        TransShptHeader.PrintRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
        TransShptHeader := Rec;
        //>> DITW18.00.07 AKH DIT-770 #1508
        CurrPage.SETSELECTIONFILTER(TransShptHeader);
        TransShptHeader.PrintRecords(TRUE);
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""&Print"(Action 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Navigate"(Action 21)". Please convert manually.


    }


    //Unsupported feature: PropertyModification on "TransShptHeader(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //TransShptHeader : "Transfer Shipment Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TransShptHeader : 5744;
    //Variable type has not been exported.

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

