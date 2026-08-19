pageextension 53013 PostedSalesShipmentsExt extends "Posted Sales Shipments"
{
    /* 
    DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 Added field "Trailer Code"
DITW18.00.07 VSC 15/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code

DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
DITW110.00.09 DDR 22/03/2017 NRQ#9661 Add EMCS fields
DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
  # New Field added "Gate Entry No."
HEI.02 CHG2065153 IBM KUMARN15 23.06.2020
  # Added field "Source System Identifier"
HEI.03 HB1582 IBM NASTAA02 02.09.2020 # Actual Delivery Date for Case Fill Rate - CHG2071900
  # New Field added: "Actual Delivery Date"
  # New Page Action added: "Update Actual Delivery Date"
     */
    // version NAVW110.0.00.16585,DITW110.00.09,HEI.01
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea property in Fields and actions.
    // 2. Remove Drink-IT Fields and related Code.
    // 3. Remove Drink-IT Related Actions.
    // BC Upgrade BHARDA11 <<

    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the shipment number.', FRA = 'Spécifie le numéro d''expédition.';
        }
        modify("Sell-to Customer No.")
        {
            ToolTipML = ENU = 'Specifies the number of the customer the items were shipped to.', FRA = 'Spécifie le numéro du client auquel les articles ont été expédiés.';
        }
        modify("Sell-to Customer Name")
        {
            ToolTipML = ENU = 'Specifies the name of the customer that you shipped the items in the shipment to.', FRA = 'Spécifie le nom du client à qui vous avez expédié les articles mentionnés sur l''expédition.';
        }
        modify("Sell-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Sell-to Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region of the address.', FRA = 'Spécifie le pays/la région de l''adresse.';
        }
        modify("Sell-to Contact")
        {
            ToolTipML = ENU = 'Specifies the name of the person to contact at the customer that the items were sold to.', FRA = 'Spécifie le nom de la personne à contacter chez le client à qui les articles ont été vendus.';
        }
        modify("Bill-to Customer No.")
        {
            ToolTipML = ENU = 'Specifies the number of the customer you sent the invoice for the shipment to.', FRA = 'Spécifie le numéro du client auquel la facture liée à l''expédition a été envoyée.';
        }
        modify("Bill-to Name")
        {
            ToolTipML = ENU = 'Specifies the name of the customer that you sent the invoice to.', FRA = 'Spécifie le nom du client auquel la facture a été envoyée.';
        }
        modify("Bill-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Bill-to Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region of the address.', FRA = 'Spécifie le pays/la région de l''adresse.';
        }
        modify("Bill-to Contact")
        {
            ToolTipML = ENU = 'Specifies the name of the person you regularly contact when you communicate with the customer to whom you sent the invoice.', FRA = 'Spécifie le nom de la personne que vous contactez régulièrement lorsque vous communiquez avec le client auquel vous avez envoyé la facture.';
        }
        modify("Ship-to Code")
        {
            ToolTipML = ENU = 'Specifies the code for the customers additional shipment address.', FRA = 'Spécifie le code de l''adresse complémentaire d''expédition du client.';
        }
        modify("Ship-to Name")
        {
            ToolTipML = ENU = 'Specifies the name of the customer that the items were shipped to.', FRA = 'Spécifie le nom du client auquel les articles ont été expédiés.';
        }
        modify("Ship-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Ship-to Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region of the address.', FRA = 'Spécifie le pays/la région de l''adresse.';
        }
        modify("Ship-to Contact")
        {
            ToolTipML = ENU = 'Specifies the name of the person you regularly contact at the address that the items were shipped to.', FRA = 'Spécifie le nom de la personne que vous contactez régulièrement à l''adresse à laquelle les articles ont été livrés.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the shipment was posted.', FRA = 'Spécifie la date de validation de l''expédition.';
        }
        modify("Salesperson Code")
        {
            ToolTipML = ENU = 'Specifies which salesperson is associated with the shipment.', FRA = 'Spécifie le nom du vendeur associé à l''expédition.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code of the shipment.', FRA = 'Spécifie le code devise de l''expédition.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location from which the items were shipped.', FRA = 'Spécifie le lieu à partir duquel les articles ont été expédiés.';

            //Unsupported feature: Change Editable on ""Location Code"(Control 61)". Please convert manually.

        }
        modify("No. Printed")
        {
            ToolTipML = ENU = 'Specifies how many times the shipment has been printed.', FRA = 'Spécifie combien de fois l''expédition a été imprimée.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on which you created the sales document.', FRA = 'Spécifie la date à laquelle vous avez créé le document vente.';
        }
        modify("Requested Delivery Date")
        {
            ToolTipML = ENU = 'Specifies the date that the customer has asked for the order to be delivered.', FRA = 'Spécifie la date à laquelle le client a demandé à être livré.';
        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies the shipment method for the shipment.', FRA = 'Spécifie le mode de transport de l''expédition.';
        }
        modify("Shipping Agent Code")
        {
            ToolTipML = ENU = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
        }
        modify("Shipping Agent Service Code")
        {
            ToolTipML = ENU = 'Specifies which shipping agent service is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
        }
        modify("Package Tracking No.")
        {
            ToolTipML = ENU = 'Specifies the shipping agent''s package number.', FRA = 'Spécifie le numéro récépissé du transporteur.';
        }
        modify("Shipment Date")
        {
            ToolTipML = ENU = 'Specifies the shipment date.', FRA = 'Spécifie la date d''expédition.';
        }

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Customer No."(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Customer No."(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Customer Name"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Customer Name"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Post Code"(Control 23)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Post Code"(Control 23)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Country/Region Code"(Control 19)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Country/Region Code"(Control 19)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact"(Control 31)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact"(Control 31)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Customer No."(Control 99)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Customer No."(Control 99)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Name"(Control 97)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Name"(Control 97)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Post Code"(Control 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Post Code"(Control 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Country/Region Code"(Control 25)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Country/Region Code"(Control 25)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact"(Control 87)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact"(Control 87)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Code"(Control 83)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Code"(Control 83)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Name"(Control 81)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Name"(Control 81)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Post Code"(Control 17)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Post Code"(Control 17)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Country/Region Code"(Control 13)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Country/Region Code"(Control 13)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Contact"(Control 71)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Contact"(Control 71)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 67)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 67)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Salesperson Code"(Control 53)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Salesperson Code"(Control 53)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 59)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 59)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 57)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 57)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Currency Code"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Currency Code"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 61)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 61)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 61)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No. Printed"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No. Printed"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Date"(Control 1102601003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Date"(Control 1102601003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Requested Delivery Date"(Control 1102601006)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Requested Delivery Date"(Control 1102601006)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Method Code"(Control 1102601008)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Method Code"(Control 1102601008)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Code"(Control 1102601010)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Code"(Control 1102601010)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Service Code"(Control 5)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Service Code"(Control 5)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Package Tracking No."(Control 9)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Package Tracking No."(Control 9)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 1102601012)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 1102601012)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

        addafter("Currency Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
        }
        addafter("No. Printed")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Physical Location Group Code", "Building No.", "Fiscal Representative No.", "Customer Tax Registration No.", "Customer Tax Warehouse Ref.")
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Building No."; Rec."Building No.")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Fiscal Representative No."; Rec."Fiscal Representative No.")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Customer Tax Registration No."; Rec."Customer Tax Registration No.")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Customer Tax Warehouse Ref."; Rec."Customer Tax Warehouse Ref.")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Physical Location Group Code", "Building No.", "Fiscal Representative No.", "Customer Tax Registration No.", "Customer Tax Warehouse Ref.")

        }
        addafter("Shipment Date")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields(Distance, "Truck Code", "Trailer Code", "Driver Code", "Driver 2 Code", Route, "Route Planning No.", "Picking Type", "Maximum Weight", "Maximum Cubage", "Total Weight", "Total Cubage", "Order Type", "Tax Date", "Customer DTax Group Code", "Submission Type", "Tax Office Code", "Journey Time")
            // field(Distance; Rec.Distance)
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Truck Code"; Rec."Truck Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Trailer Code"; Rec."Trailer Code")
            // {
            //     Description = 'DITW18.00.06 MSF 14/05/2015 DIT-770 #1035';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Driver Code"; Rec."Driver Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Driver 2 Code"; Rec."Driver 2 Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field(Route; Rec.Route)
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Route Planning No."; Rec."Route Planning No.")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Picking Type"; Rec."Picking Type")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Maximum Weight"; Rec."Maximum Weight")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Maximum Cubage"; Rec."Maximum Cubage")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Total Weight"; Rec."Total Weight")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Total Cubage"; Rec."Total Cubage")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Order Type"; Rec."Order Type")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }

            // field("Tax Date"; Rec."Tax Date")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Customer DTax Group Code"; Rec."Customer DTax Group Code")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Submission Type"; Rec."Submission Type")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Tax Office Code"; Rec."Tax Office Code")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Journey Time"; Rec."Journey Time")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields(Distance, "Truck Code", "Trailer Code", "Driver Code", "Driver 2 Code", Route, "Route Planning No.", "Picking Type", "Maximum Weight", "Maximum Cubage", "Total Weight", "Total Cubage", "Order Type", "Tax Date", "Customer DTax Group Code", "Submission Type", "Tax Office Code", "Journey Time")
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
            field("Gate Entry No."; Rec."Gate Entry No. FND")
            {
                ApplicationArea = All;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Posted Warehouse Shipment No."; Rec."Posted Whse. Shipment No. FND")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Whse. Shipment No."; Rec."Whse. Shipment No. FND")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Source System Identifier"; Rec."Source System Identifier FND")
            {
                ApplicationArea = All;
            }
            field("Actual Delivery Date"; Rec."Actual Delivery Date FND")
            {
                ApplicationArea = All;
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

            //Unsupported feature: Change RunObject on "Statistics(Action 28)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "Statistics(Action 28)". Please convert manually.

            Promoted = true;
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';

            //Unsupported feature: Change RunObject on ""Co&mments"(Action 33)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Co&mments"(Action 33)". Please convert manually.

        }
        modify(Dimensions)
        {

            //Unsupported feature: Change AccessByPermission on "Dimensions(Action 1102601000)". Please convert manually.

            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(CertificateOfSupplyDetails)
        {
            CaptionML = ENU = 'Certificate of Supply Details', FRA = 'Détails certificat d''approvisionnement';

            //Unsupported feature: Change RunObject on "CertificateOfSupplyDetails(Action 3)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "CertificateOfSupplyDetails(Action 3)". Please convert manually.

        }
        modify(PrintCertificateofSupply)
        {
            CaptionML = ENU = 'Print Certificate of Supply', FRA = 'Imprimer le certificat d''approvisionnement';
            Promoted = false;
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("&Track Package")
        {
            CaptionML = ENU = '&Track Package', FRA = '&Suivre colis';
        }
        modify("&Print")
        {

            //Unsupported feature: Change Ellipsis on ""&Print"(Action 21)". Please convert manually.

            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            Promoted = true;
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            Promoted = true;
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000003(Action 1900000003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Shipment"(Action 15)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Statistics(Action 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Co&mments"(Action 33)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Dimensions(Action 1102601000)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""F&unctions"(Action 1102601001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Track Package"(Action 1102601002)". Please convert manually.



        //Unsupported feature: CodeModification on ""&Print"(Action 21).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(SalesShptHeader);
        SalesShptHeader.PrintRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
        SalesShptHeader := Rec;
        //>> DITW18.00.07 AKH DIT-770 #1508
        CurrPage.SETSELECTIONFILTER(SalesShptHeader);
        SalesShptHeader.PrintRecords(TRUE);
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""&Print"(Action 21)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Navigate"(Action 22)". Please convert manually.

        addafter(PrintCertificateofSupply)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Page(2014097)
            // action("Shipping Costs")
            // {
            //     ApplicationArea = All;
            //     CaptionML = ENU = 'Shipping Costs',
            //                 FRA = 'Coûts transport';
            //     Image = Costs;
            //     RunObject = Page 2014097;
            //     RunPageLink = Source Type=CONST(110),
            //                   Source No.=FIELD(No.);
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Page(2014097)
            action("Update Actual Delivery Date")
            {
                ApplicationArea = All;
                Caption = 'Update Actual Delivery Date';
                Image = UpdateShipment;
                RunObject = Page "Update Actual Delivery Date";
            }
        }
    }


    //Unsupported feature: PropertyModification on "PrintCertificateofSupply(Action 7).OnAction.CertificateOfSupply(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PrintCertificateofSupply : "Certificate of Supply";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PrintCertificateofSupply : 780;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on ""&Print"(Action 21).OnAction.SalesShptHeader(Variable 1102)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //"&Print" : "Sales Shipment Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"&Print" : 110;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OnOpenPage.OfficeMgt(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OnOpenPage.OfficeMgt : "Office Management";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnOpenPage.OfficeMgt : 1630;
    //Variable type has not been exported.


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;
    if FINDFIRST then;
    IsOfficeAddin := OfficeMgt.IsAvailable;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;
    IF FINDFIRST THEN;
    IsOfficeAddin := OfficeMgt.IsAvailable;
    */
    //end;
}

