pageextension 53017 PostedTransferShipmentExt extends "Posted Transfer Shipment"
{
    // version NAVW110.0,DITW110.00.08,HEI.01
    /* HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
        # New Fields added: "To Gate Entry No.", "From Gate Entry No."
        HEI.03 FDD-HT658 CHG2024493 IBM.GUNERE01 29.10.2019 # "Document Shipping Costs" field added
      HEI.04 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
        # new field added: LSR Order No
         */
    // BC Upgrade BHARDA11 >> 
    // 1. Remove Drink-IT Fields and related code("Trsf-from Ph. Location Gr Code","Trsf-to Ph. Location Gr Code","Tax Date","Document Shipping Costs","Delivery Sequence","Truck Code","Driver Code","Work Order No.","Fiscal Representative No.","Tax Office Code","Journey Time","Transport Mode")
    // 2. Add ApplicationArea property in fields
    // BC Upgrade BHARDA11 <<
    DeleteAllowed = false;
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
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
        modify("In-Transit Code")
        {
            ToolTipML = ENU = 'Specifies the in-transit code that is used for this transfer.', FRA = 'Indique le code transit utilisé pour ce transfert.';
        }
        modify("Transfer Order No.")
        {

            //Unsupported feature: Change Lookup on ""Transfer Order No."(Control 53)". Please convert manually.

            ToolTipML = ENU = 'Specifies the number of the transfer order on which the transfer shipment was based.', FRA = 'Indique le numéro de l''ordre de transfert sur lequel l''expédition transfert est basée.';
        }
        modify("Transfer Order Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the transfer order was created.', FRA = 'Spécifie la date à laquelle l''ordre de transfert a été créé.';
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

        //Unsupported feature: Change SubPageLink on "TransferShipmentLines(Control 49)". Please convert manually.


        //Unsupported feature: Change PagePartID on "TransferShipmentLines(Control 49)". Please convert manually.

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
            ToolTipML = ENU = 'Specifies a code that represents the shipment method.', FRA = 'Spécifie un code qui représente les conditions de livraison.';
        }
        modify("Shipping Agent Code")
        {
            ToolTipML = ENU = 'Specifies the code for the shipping agent you have used for this transfer shipment.', FRA = 'Indique le code du transporteur utilisé pour cette expédition transfert.';
        }
        modify("Shipping Agent Service Code")
        {
            ToolTipML = ENU = 'Specifies the code for the shipping agent service you have used for this transfer shipment.', FRA = 'Indique le code prestation transporteur utilisé pour cette expédition transfert.';
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
            ToolTipML = ENU = 'Specifies an additional part of the address of the location.', FRA = 'Spécifie la partie supplémentaire de l''adresse du magasin.';
        }
        modify("Transfer-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the location.', FRA = 'Spécifie le code postal du magasin.';
        }
        modify("Transfer-to City")
        {
            ToolTipML = ENU = 'Specifies the city of the location to which items are transferred.', FRA = 'Spécifie la ville du magasin vers lequel les articles sont transférés.';
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


        //Unsupported feature: PropertyDeletion on ""In-Transit Code"(Control 31)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""In-Transit Code"(Control 31)". Please convert manually.


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


        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 27)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 27)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Method Code"(Control 67)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Method Code"(Control 67)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Code"(Control 69)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Code"(Control 69)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Service Code"(Control 71)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Service Code"(Control 71)". Please convert manually.


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


        //Unsupported feature: PropertyDeletion on ""Receipt Date"(Control 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Receipt Date"(Control 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Foreign Trade"(Control 1907468901)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transaction Type"(Control 63)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transaction Type"(Control 63)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transaction Specification"(Control 65)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transaction Specification"(Control 65)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transport Method"(Control 74)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transport Method"(Control 74)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Area(Control 76)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Area(Control 76)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Entry/Exit Point"(Control 78)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Entry/Exit Point"(Control 78)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

        addafter("No.")
        {

        }
        addafter("Transfer-from Code")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Trsf-from Ph. Location Gr Code","Trsf-to Ph. Location Gr Code","Tax Date","Document Shipping Costs")
            // field("Trsf-from Ph. Location Gr Code"; Rec."Trsf-from Ph. Location Gr Code")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
            // field("Trsf-to Ph. Location Gr Code"; Rec."Trsf-to Ph. Location Gr Code")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
            //  field("Tax Date"; Rec."Tax Date")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
            // field("Document Shipping Costs"; Rec."Document Shipping Costs")
            // {
            //     ApplicationArea = All;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Trsf-from Ph. Location Gr Code","Trsf-to Ph. Location Gr Code","Tax Date","Document Shipping Costs")

        }

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

        }
        addafter("Shipping Agent Service Code")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Field("Delivery Sequence","Truck Code","Driver Code","Work Order No.","Fiscal Representative No.","Tax Office Code","Journey Time","Transport Mode")
            // field("Delivery Sequence"; Rec."Delivery Sequence")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
            // field("Truck Code"; Rec."Truck Code")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
            // field("Driver Code"; Rec."Driver Code")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
            // field("Work Order No."; Rec."Work Order No.")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
            // field("Fiscal Representative No."; Rec."Fiscal Representative No.")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
            // field("Tax Office Code"; Rec."Tax Office Code")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
            // field("Journey Time"; Rec."Journey Time")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
            // field("Transport Mode"; Rec."Transport Mode")
            // {
            //     ApplicationArea = All;
            //     Description = 'DIT715 #187';
            //     Editable = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Field("Delivery Sequence","Truck Code","Driver Code","Work Order No.","Fiscal Representative No.","Tax Office Code","Journey Time","Transport Mode")

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

            //Unsupported feature: Change ActionType on ""&Print"(Action 51)". Please convert manually.

            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            Promoted = true;
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000003(Action 1900000003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Shipment"(Action 50)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Statistics(Action 56)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Co&mments"(Action 57)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Dimensions(Action 58)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.

        // modify("&Print")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: PropertyDeletion on ""&Print"(Action 51)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Print"(Action 51)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Print"(Action 51)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Print"(Action 51)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Print"(Action 51)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Navigate"(Action 52)". Please convert manually.

        addafter("Co&mments")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
            // action("Comments - Transport Mode")
            // {
            //     CaptionML = ENU = 'Comments - Transport Mode',
            //                 FRA = 'Commantaires - Mode de transport';
            //     Description = 'DIT715 #187';
            //     Image = ViewComments;
            //     RunObject = Page 2014270;
            //     RunPageLink = Table ID=CONST(5744),
            //                   Document Type=CONST(0),
            //                   Document No.=FIELD(No.),
            //                   Document Line No.=CONST(0),
            //                   Field ID=CONST(2014277);
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Customization

        }
        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
        // addfirst(ActionContainer1900000004)
        // {
        //     group("F&unctions")
        //     {
        //         CaptionML = ENU='F&unctions',
        //                     FRA='Fonction&s';
        //         action("Send e-AAD Request")
        //         {
        //             CaptionML = ENU='Send e-AAD Request',
        //                         FRA='Envoyer requête e-DAA';
        //             Image = SendElectronicDocument;

        //             trigger OnAction();
        //             var
        //                 EMCSExport : Codeunit "2014262";
        //             begin
        //                 // <<DITW15.00.00.38 DDR 03/09/2010 #1217
        //                 EMCSExport.CreateOutboxTransferShipment(Rec);
        //                 // >>DITW15.00.00.38 DDR
        //             end;
        //         }
        //         action("Send e-Cancelling Request")
        //         {
        //             CaptionML = ENU='Send e-Cancelling Request',
        //                         FRA='Envoyer e-Annulation requête';
        //             Image = SendElectronicDocument;

        //             trigger OnAction();
        //             var
        //                 EMCSExport : Codeunit "2014267";
        //             begin
        //                 // <<DITW15.00.00.38 DDR 08/10/2010 #1217
        //                 EMCSExport.CreateOutboxTransferShipment(Rec);
        //                 // >>DITW15.00.00.38 DDR
        //             end;
        //         }
        //     }
        // }
        // addfirst("&Print")
        // {
        //     action("&Shipment")
        //     {
        //         CaptionML = ENU='&Shipment',
        //                     FRA='E&xpédition';
        //         Image = Print;

        //         trigger OnAction();
        //         var
        //             TransShptHeader : Record "5744";
        //         begin
        //             // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //             CurrPage.TransferShipmentLines.PAGE.SetDisableRefreshLines(TRUE);
        //             // >>DITW16.00.00.40 DDR DIT-715 #197
        //             //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
        //             TransShptHeader := Rec;
        //             //>> DITW18.00.07 AKH DIT-770 #1508
        //             // <<DITW15.00.00.36 DDR 17/12/2009
        //             CurrPage.SETSELECTIONFILTER(TransShptHeader);
        //             TransShptHeader.PrintRecords(TRUE);
        //             // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //             CurrPage.TransferShipmentLines.PAGE.SetDisableRefreshLines(FALSE);
        //             // >>DITW16.00.00.40 DDR DIT-715 #197
        //         end;
        //     }
        //     action("&AAD Document")
        //     {
        //         CaptionML = ENU='&AAD Document',
        //                     FRA='Document D&AA';
        //         Image = Print;

        //         trigger OnAction();
        //         var
        //             DocPrint : Codeunit "229";
        //         begin
        //             // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //             CurrPage.TransferShipmentLines.PAGE.SetDisableRefreshLines(TRUE);
        //             // >>DITW16.00.00.40 DDR DIT-715 #197
        //             // <<DITW15.00.00.36 DDR 17/12/2009
        //             DocPrint.PrintTransferShptHeaderAAD(Rec,FALSE);
        //             // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //             CurrPage.TransferShipmentLines.PAGE.SetDisableRefreshLines(FALSE);
        //             // >>DITW16.00.00.40 DDR DIT-715 #197
        //         end;
        //     }
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Customization
    }

    var
        TransferHeader: Record 5740;
        ExternalDocNoEnabled: Boolean;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

