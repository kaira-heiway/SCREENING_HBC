pageextension 53019 PostedTransferReceiptExt extends "Posted Transfer Receipt"
{
    // version NAVW110.0,DITW110.00.08,HEI.01
    /* DITW15.00.00.25 DDR 10/10/2008 Added fields "Truck Code","Driver Code" into 'Transfer-from' tab
    DITW15.00.00.35 DDR 14/10/2009 issue 788 Added Form property DeleteAllowed = No
    DITW15.00.00.36 DDR 17/12/2009 issue 594 Added fields "Fiscal Representative No." into 'Transfer-from' tab
    DITW15.00.00.37 DDR 04/01/2010 issue 594 Move field "Fiscal REpresentative no." into 'Transfer-to' tab
                        28/05/2010 issue 480 Added fields
                                     "Trsf-from Ph. Location Gr Code","Trsf-to Ph. Location Gr Code"
    DITW15.00.00.38 DDR 05/10/2010 issue 1217 EMCS (e-AAD) Functionnalities
                                              Added 'Unsatisfactory Comment' menu button in 'Line' button
                                              Added functions ShowLineUnstatisfactoryCmts()
                                              Added 'Send Report Receipt Request' menus in 'Functions' buttons
                        26/11/2010 issue 1217 (DIT711 87) Design align button 'Functions'
                    DDR 27/01/2011 issue 1217 (DIT711 137) Added fields "Tax Office Code" into 'Shipping' tab
    DITW15.00.00.39 DDR 06/07/2011 issue 1353 Added fields "Journey Time"
                        19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
                                                     call function SetDisableRefreshLines() before each report
                                                     (don't use the <RunObject> property)

    DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Add Flowfield "Document Shipping Costs" to General TAB
    DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code

    DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
      # New Fields added: "To Gate Entry No.", "From Gate Entry No."
    DITW110.00.12 AKH 30/03/2018 NRQ#16026 Order Shipment Planning: Sync Sales - Transfer
    HEI.02 FDD-HT743 IBM BULIMC01 23.07.2019 # new field added: "Route"
    HEI.03 FDD-HT743 IBM BULIMC01 10.09.2019 # new field added: "No. Printed"
    HEI.04 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
      # new field added: LSR Order No */
    // BC Upgrade BHARDA11 >>
    // 1. Remove Drink-IT Fields("Trsf-from Ph. Location Gr Code", "Trsf-to Ph. Location Gr Code", "Tax Date","Document Shipping Costs","Delivery Sequence", "Truck Code", "Driver Code", "Route", "Work Order No.","Fiscal Representative No.", "Tax Office Code", "Journey Time", "Transport Mode")
    // 2. Add ApplicationArea property in custom fields.
    // 3. Move "LSR Order No" to Interface extension.
    // BC Upgrade BHARAD11 <<
    DeleteAllowed = false;
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the transfer receipt.', FRA = 'Spécifie le numéro de la réception transfert.';
        }
        modify("Transfer-from Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location that you are transferring items from.', FRA = 'Spécifie le code du magasin à partir duquel vous transférez les articles.';
        }
        modify("Transfer-to Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location that you are transferring items to.', FRA = 'Spécifie le code du magasin vers lequel vous transférez les articles.';
        }
        modify("In-Transit Code")
        {
            ToolTipML = ENU = 'Specifies the in-transit code that identifies this transfer.', FRA = 'Indique le code transit identifiant le transfert.';
        }
        modify("Transfer Order No.")
        {

            //Unsupported feature: Change Lookup on ""Transfer Order No."(Control 53)". Please convert manually.

            ToolTipML = ENU = 'Specifies the number of the transfer order on which the transfer receipt was based.', FRA = 'Indique le numéro de l''ordre de transfert sur lequel la réception transfert est basée.';
        }
        modify("Transfer Order Date")
        {
            ToolTipML = ENU = 'Specifies the date you created the transfer order.', FRA = 'Spécifie la date de création de l''ordre de transfert.';
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

        //Unsupported feature: Change SubPageLink on "TransferReceiptLines(Control 49)". Please convert manually.


        //Unsupported feature: Change PagePartID on "TransferReceiptLines(Control 49)". Please convert manually.

        modify("Transfer-from")
        {
            CaptionML = ENU = 'Transfer-from', FRA = 'Prov. transfert';
        }
        modify("Transfer-from Name")
        {
            ToolTipML = ENU = 'Specifies the name of the location that you are transferring items from.', FRA = 'Spécifie le nom du magasin à partir duquel vous transférez les articles.';
        }
        modify("Transfer-from Name 2")
        {
            ToolTipML = ENU = 'Specifies an additional part of the name of the location that you are transferring items from.', FRA = 'Indique des informations supplémentaires relatives au nom du magasin à partir duquel les articles sont transférés.';
        }
        modify("Transfer-from Address")
        {
            ToolTipML = ENU = 'Specifies the address of the location that you are transferring items from.', FRA = 'Spécifie l''adresse du magasin à partir duquel les articles sont transférés.';
        }
        modify("Transfer-from Address 2")
        {
            ToolTipML = ENU = 'Specifies an additional part of the address of the location.', FRA = 'Spécifie la partie supplémentaire de l''adresse du magasin.';
        }
        modify("Transfer-from Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the location that you are transferring items from.', FRA = 'Spécifie le code postal du magasin à partir duquel vous transférez les articles.';
        }
        modify("Transfer-from City")
        {
            ToolTipML = ENU = 'Specifies the city of the location that you are transferring items from.', FRA = 'Spécifie la ville du magasin à partir duquel vous transférez les articles.';
        }
        modify("Transfer-from Contact")
        {
            ToolTipML = ENU = 'Specifies the name of the contact person at the transfer-from location.', FRA = 'Spécifie le nom du contact dans le magasin provenance transfert.';
        }
        modify("Shipment Date")
        {
            ToolTipML = ENU = 'Specifies the shipment date of the transfer order.', FRA = 'Spécifie la date d''expédition de l''ordre de transfert.';
        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies a code that represents the shipment method for the receipt.', FRA = 'Spécifie un code qui représente les conditions de livraison de la réception.';
        }
        modify("Shipping Agent Code")
        {
            ToolTipML = ENU = 'Specifies the code for the shipping agent that delivered this transfer shipment to the transfer-to location.', FRA = 'Indique le code du transporteur qui a livré cette expédition transfert au magasin destination transfert.';
        }
        modify("Shipping Agent Service Code")
        {
            ToolTipML = ENU = 'Specifies the code for the shipping agent service that applies to the transfer shipment received at the transfer-to location.', FRA = 'Indique le code prestation transporteur qui s''applique à cette expédition transfert reçue au magasin destination transfert.';
        }
        modify("Transfer-to")
        {
            CaptionML = ENU = 'Transfer-to', FRA = 'Dest. transfert';
        }
        modify("Transfer-to Name")
        {
            ToolTipML = ENU = 'Specifies the name of the location that you are transferring items to.', FRA = 'Spécifie le nom du magasin vers lequel vous transférez les articles.';
        }
        modify("Transfer-to Name 2")
        {
            ToolTipML = ENU = 'Specifies an additional part of the name of the location that you are transferring items to.', FRA = 'Indique des informations supplémentaires relatives au nom du magasin vers lequel les articles sont transférés.';
        }
        modify("Transfer-to Address")
        {
            ToolTipML = ENU = 'Specifies the address of the location that you are transferring items to.', FRA = 'Spécifie l''adresse du magasin vers lequel vous transférez les articles.';
        }
        modify("Transfer-to Address 2")
        {
            ToolTipML = ENU = 'Specifies an additional part of the address of the location that you are transferring items to.', FRA = 'Indique des informations supplémentaires relatives à l''adresse du magasin vers lequel les articles sont transférés.';
        }
        modify("Transfer-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the location that you are transferring items to.', FRA = 'Spécifie le code postal du magasin vers lequel vous transférez les articles.';
        }
        modify("Transfer-to City")
        {
            ToolTipML = ENU = 'Specifies the city of the location that you are transferring items to.', FRA = 'Spécifie la ville du magasin vers lequel vous transférez les articles.';
        }
        modify("Transfer-to Contact")
        {
            ToolTipML = ENU = 'Specifies the name of the contact person at the transfer-to location.', FRA = 'Spécifie le nom du contact dans le magasin destination transfert.';
        }
        modify("Receipt Date")
        {
            ToolTipML = ENU = 'Specifies the receipt date of the transfer order.', FRA = 'Spécifie la date de réception de l''ordre de transfert.';
        }
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        }
        modify("Transaction Type")
        {
            ToolTipML = ENU = 'Specifies the transaction type of the transfer.', FRA = 'Spécifie le type de transaction du transfert.';
        }
        modify("Transaction Specification")
        {
            ToolTipML = ENU = 'Specifies the transaction specification code that was used in the transfer.', FRA = 'Spécifie le code régime de la transaction utilisé dans le transfert.';
        }
        modify("Transport Method")
        {
            ToolTipML = ENU = 'Specifies the code for the transport method used for the item on this line.', FRA = 'Spécifie le code pour le mode de transport utilisé pour l''article de cette ligne.';
        }
        modify("Area")
        {
            ToolTipML = ENU = 'Specifies the code for an area at the customer or vendor with which you are trading the items on the line.', FRA = 'Spécifie le code de la zone du client ou du fournisseur avec lequel vous traitez les articles de la ligne.';
        }
        modify("Entry/Exit Point")
        {
            ToolTipML = ENU = 'Specifies the code of either the port of entry at which the items passed into your country/region, or the port of exit.', FRA = 'Spécifie le code du port d''entrée par lequel les articles sont entrés dans votre pays/région ou du port de sortie.';
        }

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "General(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Code"(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Code"(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to Code"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to Code"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""In-Transit Code"(Control 27)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""In-Transit Code"(Control 27)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer Order No."(Control 53)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer Order No."(Control 53)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer Order Date"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer Order Date"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from"(Control 1904655901)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Name"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Name"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Name 2"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Name 2"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Address"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Address"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Address 2"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Address 2"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Post Code"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Post Code"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from City"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from City"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Contact"(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Contact"(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Method Code"(Control 67)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Method Code"(Control 67)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Code"(Control 62)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Code"(Control 62)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Service Code"(Control 64)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Service Code"(Control 64)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to"(Control 1901454601)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to Name"(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to Name"(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to Name 2"(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to Name 2"(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to Address"(Control 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to Address"(Control 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to Address 2"(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to Address 2"(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to Post Code"(Control 40)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to Post Code"(Control 40)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to City"(Control 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to City"(Control 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to Contact"(Control 46)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-to Contact"(Control 46)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Receipt Date"(Control 31)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Receipt Date"(Control 31)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Foreign Trade"(Control 1907468901)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transaction Type"(Control 78)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transaction Type"(Control 78)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transaction Specification"(Control 76)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transaction Specification"(Control 76)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transport Method"(Control 74)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transport Method"(Control 74)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Area(Control 72)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Area(Control 72)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Entry/Exit Point"(Control 70)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Entry/Exit Point"(Control 70)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

        // addafter("No.")
        // {
        // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Trsf-from Ph. Location Gr Code", "Trsf-to Ph. Location Gr Code", "Tax Date","Document Shipping Costs")
        // field("Trsf-from Ph. Location Gr Code"; Rec."Trsf-from Ph. Location Gr Code")
        // {
        //     Editable = false;
        // }
        // field("Trsf-to Ph. Location Gr Code"; Rec."Trsf-to Ph. Location Gr Code")
        // {
        //     Editable = false;
        // }
        // field("Tax Date"; Rec."Tax Date")
        // {
        //     Editable = false;
        // }
        // field("Document Shipping Costs"; Rec."Document Shipping Costs")
        // {
        //     ApplicationArea = All;
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Fields("Trsf-from Ph. Location Gr Code", "Trsf-to Ph. Location Gr Code", "Tax Date","Document Shipping Costs")

        // }

        addafter("Shortcut Dimension 2 Code")
        {

            field("To Gate Entry No."; Rec."To Gate Entry No. FND")
            {
                ApplicationArea = All;
            }
            field("From Gate Entry No."; Rec."From Gate Entry No. FND")
            {
                ApplicationArea = All;
            }
            field("No. Printed"; Rec."No. Printed FND")
            {
                ApplicationArea = All;
            }

        }
        // addafter("Shipping Agent Service Code")
        // {
        // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Delivery Sequence", "Truck Code", "Driver Code", "Route", "Work Order No.")

        // field("Delivery Sequence"; Rec."Delivery Sequence")
        // {
        //     Editable = false;
        // }
        // field("Truck Code"; Rec."Truck Code")
        // {
        //     Editable = false;
        // }
        // field("Driver Code"; Rec."Driver Code")
        // {
        //     Editable = false;
        // }
        // field(Route; Rec.Route)
        // {
        //     ApplicationArea = All;
        // }
        // field("Work Order No."; Rec."Work Order No.")
        // {
        //     Editable = false;
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Fields("Delivery Sequence", "Truck Code", "Driver Code", "Route", "Work Order No.")
        // }
        // addafter("Receipt Date")
        // {
        // BC Upgrade BHARAD11 >> ----Drink-IT Fields("Fiscal Representative No.", "Tax Office Code", "Journey Time", "Transport Mode")
        // field("Fiscal Representative No."; Rec."Fiscal Representative No.")
        // {
        //     Editable = false;
        // }
        // field("Tax Office Code"; Rec."Tax Office Code")
        // {
        //     Editable = false;
        // }
        // field("Journey Time"; Rec."Journey Time")
        // {
        //     Editable = false;
        // }
        //  field("Transport Mode"; Rec."Transport Mode")
        // {
        //     Editable = false;
        // }
        // BC Upgrade BHARAD11 << ----Drink-IT Fields("Fiscal Representative No.", "Tax Office Code", "Journey Time", "Transport Mode")
        // }

    }
    actions
    {
        modify("&Receipt")
        {
            CaptionML = ENU = '&Receipt', FRA = '&Réception';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';

            //Unsupported feature: Change RunObject on "Statistics(Action 56)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "Statistics(Action 56)". Please convert manually.

            Promoted = true;
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';

            //Unsupported feature: Change RunObject on ""Co&mments"(Action 57)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Co&mments"(Action 57)". Please convert manually.

        }
        modify(Dimensions)
        {

            //Unsupported feature: Change AccessByPermission on "Dimensions(Action 58)". Please convert manually.

            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("&Print")
        {

            //Unsupported feature: Change Ellipsis on ""&Print"(Action 51)". Please convert manually.

            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            Promoted = true;
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            Promoted = true;
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000003(Action 1900000003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Receipt"(Action 50)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Statistics(Action 56)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Co&mments"(Action 57)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Dimensions(Action 58)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.



        //Unsupported feature: CodeModification on ""&Print"(Action 51).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(TransRcptHeader);
        TransRcptHeader.PrintRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.TransferReceiptLines.PAGE.SetDisableRefreshLines(TRUE);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
        TransRcptHeader := Rec;
        //>> DITW18.00.07 AKH DIT-770 #1508
        CurrPage.SETSELECTIONFILTER(TransRcptHeader);
        TransRcptHeader.PrintRecords(TRUE);
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.TransferReceiptLines.PAGE.SetDisableRefreshLines(FALSE);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""&Print"(Action 51)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Navigate"(Action 52)". Please convert manually.

        // addafter(Dimensions)
        // {
        // BC Upgrade BHARAD11 >> ----Drink-IT Customization
        // action("Shipping Costs")
        // {
        //     CaptionML = ENU = 'Shipping Costs',
        //                 FRA = 'Coûts transport';
        //     Image = Costs;
        //     RunObject = Page 2014097;
        //     RunPageLink = Source Type=CONST(5746),
        //                   Source No.=FIELD(No.);
        // }
        // BC Upgrade BHARAD11 << ----Drink-IT Customization

        // }
        // BC Upgrade BHARAD11 >> ----Drink-IT Customization
        // addfirst(ActionContainer1900000004)
        // {
        //     group("F&unctions")
        //     {
        //         CaptionML = ENU = 'F&unctions',
        //                     FRA = 'Fonction&s';
        //         separator()
        //         {
        //         }
        //         action("Send Report Receipt Request")
        //         {
        //             CaptionML = ENU = 'Send Report Receipt Request',
        //                         FRA = 'Envoyer le rapport requête recéption';
        //             Image = SendElectronicDocument;

        //             trigger OnAction();
        //             var
        //                 EMCSExport: Codeunit "2014265";
        //             begin
        //                 // <<DITW15.00.00.38 DDR 05/10/2010
        //                 EMCSExport.CreateOutboxTransferReceipt(Rec);
        //                 // >>DITW15.00.00.38 DDR
        //             end;
        //         }
        //     }
        // }
        // BC Upgrade BHARAD11 << ----Drink-IT Customization
    }


    //Unsupported feature: PropertyModification on ""&Print"(Action 51).OnAction.TransRcptHeader(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //"&Print" : "Transfer Receipt Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"&Print" : 5746;
    //Variable type has not been exported.

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

