pageextension 51163 TransferOrderExtCBN extends "Transfer Order"
{
    // version NAVW110.0,FINXL8.00.001,DITW111.00.13A,HEI.18
    //     FINXL8.00.001 BSA 29/05/2015 #180: Added Field "Replenishment Status"
    // FINXL8.00.001 BSA 05/06/2015 #182: Added Field "Emergency Order"

    // DITW15.00.00.25 DDR 10/10/2008 Added fields "Truck Code","Driver Code" into 'Transfer-from' tab
    // DITW15.00.00.36 DDR 17/12/2009 issue 594 Added fields "Fiscal Representative No." into 'Transfer-from' tab
    //                                          Replaced 'Print' button
    // DITW15.00.00.37 DDR 04/01/2010 issue 594 Move field "Fiscal REpresentative no." into 'Transfer-to' tab
    //                     08/02/2010 issue 480 Added menu 'Insert Item Charges' into 'Functions' button
    //                                          Added menu 'Expand/Collapse','Expand All','Collapse All' into 'Lines' button
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 22/06/2010 issue 1151 Added menu 'Quality Tests' into 'Lines' button
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 15/11/2010 issue 1139 SSCC Functionnalities
    //                                       Added menu 'SSCC Tracking Lines' in 'Line' buttton
    //                     21/12/2010 issue 1146 Added field "Auto.Release Transfer on Whse." to release automatically the transfer order
    //                                           Added function ReleaseTransferOrder()
    //                                            (see 'Functions' button menu 'Create Whse. shipment','Create Whse. receipt',
    //                                              'Create Inventory Put-away / Pick')
    //                 DDR 27/01/2011 issue 1217 (DIT711 137) Added fields "Tax Office Code" into 'Shipping' tab
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                           Added parameter line function RTCActionNewLine() into RTCNewLine button
    // DITW15.00.00.39 DDR 12/04/2011 issue 1296 Added AAD/ARC functionnality
    //                                  Added menu "Get EMCS ARC No. to Apply" into 'Functions' button
    //                     06/07/2011 issue 1353 Added fields "Journey Time"
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                              Added to insert first line automatically
    //                     19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields "Delivery Sequence" into 'Transfer-from' tab
    //                     22/12/2011 DIT-715 issue 187 Added 'Comments - Transport Mode' menu into 'Order' button
    //                                                  Added fields into 'Foreign Trade' tab
    //                                                    "Transport Mode","Transport Mode Comment"
    //                     11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  call function SetDisableRefreshLines() before each report
    //                                                  (don't use the <RunObject> property)
    //                     13/06/2012 DIT-715 #338 Added 'Period (Items)' menu into button 'Item\Item Item Availability by'
    //                                             Added 'Items by Period' into button 'Item'
    // DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457 Added fields "Work Order No."
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added SSCC Tracking Lines\Receipt menu

    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Add Flowfield "Document Shipping Costs" to General TAB
    // DITW110.00.12 AKH 30/03/2018 NRQ#16026 Order Shipment Planning: Sync Sales - Transfer
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW111.00.13A MSF 30/04/2019 NRQ#106834 AUTO FEFO and Undo Tracking Lines functions for transfer orders
    //                                           Added Action &Automatic FEFO Tracking for Order
    //                                                       Undo Tracking Lines

    // HEI.01 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Field added: Request Order No.
    //   # Field "Request Order No." is visible just when "Enable Request Order" is ticked on OpCo Setup
    // HEI.02 Defect #3415 IBM NASTAA02 02.11.2018 # Request Order - External Doc. Number
    //   # Added Field "External Document No." visible when "Request Order No." is filled-in
    // HEI.03 RFC-CHG0255774 IBM.AB 15.10.2018
    //   # Code added to validate Shipping Agent Code
    // HEI.04 CHG0255774_FDD_TC_Calculation_Enhancement IBM NANDIS01 08.07.2019
    //   Validation added to show error message when the shipping agent is not ticked as Own Logistics
    // HEI.05 FDD-HT658 IBM.GUNERE01 29.08.2019 # Distance field added
    //                               24.09.2019 # code added to Shipping Agent Service Code - OnValidate
    // HEI.06 FDD-HT604 IBM.GAVANM01 13.01.2020 # WMS integration Heilite BASE and Reflex
    //   # New field added : WMS Export
    // HEI.07 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
    // # New Fields added: "IC Document", "External Document No."
    //   # New variable created: "ExternalDocNoEditable"
    //   # Code added on "OnAfterGetRecord" trigger
    // HEI.08 FDD-HB1438 CHG2065311 IBM SHANKJ03 30.07.2020
    //   # New Field created : PO Reference & Extra PO reference
    // HEI.09 CHG2069358 ibm.AK 25.08.20
    //  # new field added on -"Created By"
    //  HEI.10 CHG2065311 IBM.PANDES01 01.09.2020
    //  # Added code on PO reference field.
    // HEI.11 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
    //   # new field added: LSR Order No
    // HEI.12 FDD-HB899 - CHG2093869 IBM NASTAA02 02.03.2021 # LSR - Transfer and Stock
    //   # Code added on Page Actions: "Create Whse. S&hipment" and "Create &Whse. Receipt"
    // HEI.13 CHG2098629 HB2014 IBM NANDIS01 08.04.2021 - LOG_Automatic creation of Transfer Order for Import PO
    //   # Editable false for "PO Reference"
    //   # Code added in Reopen button
    // HEI.14 FDD-HB1195 CHG2070051 IBM NANDIS01 24.05.2021 Import Purchasing & Receiving process HeiLite-Maximo integration
    //   # TO can not be posted manually if its created from PO
    // HEI.15 CHG2161266 HB3003 NORRIQ KOROLA04 06.10.2022
    //   # PO Reference - OnLookup() - trigger changed
    //   # Reopen - function changed
    //   # "Import Idemtifier" - field added
    // HEI.16 CHG2161266 HB3003 NORRIQ KOROLA04 20.10.2022
    //   # Import Identifier - field name fixed
    // HEI.17 CHG2161266 HB3003 NORRIQ KOROLA04 15.11.2022
    //   # PO Reference field - code transfered from OnValidate to OnAssistEdit
    // HEI.18 CHG2184698 IBM NANDIS01 07.12.2022 #Issue to change the expected receipt date on PO header
    //   Reopen of TO will depend on extra condition of respective PO

    // BC Upgrade SHUKLP03 >>
    // "WMS Export" AND "LSR Order No" shared with Sakshi.
    // Table "Transfer Header" => Trigger OnLookup() code of field "Shipping Agent Service Code" is added on page "Transfer Order".
    // DrinkIT code, fields, actions and procedures are blocked.
    // HEI.03, HEI.04=> Field "Shipping Agent code" blocked because dependency on DrinkIT field ShippingAgent."Vendor No.".
    // Action("Create &Whse. Receipt") of Transfer order shared with Sakshi because interface related objects is used.
    // Action("Create Whse. S&hipment Custom") of Transfer order shared with Sakshi because interface related objects is used in this action.
    // BC Upgrade SHUKLP03 <<


    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the transfer order.', FRA = 'Spécifie le numéro de l''ordre de transfert.';
        }
        modify("Transfer-from Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location from which items are transferred.', FRA = 'Spécifie le code du magasin à partir duquel les articles sont transférés.';
        }
        modify("Transfer-to Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location that you are transferring items to.', FRA = 'Spécifie le code du magasin vers lequel vous transférez les articles.';
        }
        modify("In-Transit Code")
        {
            ToolTipML = ENU = 'Specifies the in-transit code that identifies this transfer.', FRA = 'Indique le code transit identifiant le transfert.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date of the transfer order.', FRA = 'Spécifie la date comptabilisation de l''ordre de transfert.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code for the dimension that has been chosen as Global Dimension 1.', FRA = 'Spécifie le code section analytique de l''axe choisi comme axe principal 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code for the dimension that has been chosen as Global Dimension 2.', FRA = 'Spécifie le code section analytique de l''axe choisi comme axe principal 2.';
        }
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.', FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Indicates whether the transfer order is open or has been released for the next stage of processing.', FRA = 'Indique si l''ordre de transfert est ouvert ou a été lancé pour l''étape suivante.';
        }
        modify("Transfer-from")
        {
            CaptionML = ENU = 'Transfer-from', FRA = 'Prov. transfert';
        }
        modify("Transfer-from Name")
        {
            ToolTipML = ENU = 'Specifies the name of the location from which items are transferred.', FRA = 'Spécifie le nom du magasin à partir duquel les articles sont transférés.';
        }
        modify("Transfer-from Name 2")
        {
            ToolTipML = ENU = 'Specifies an additional part of the name of the location from which items are transferred.', FRA = 'Indique des informations supplémentaires relatives au nom du magasin à partir duquel les articles sont transférés.';
        }
        modify("Transfer-from Address")
        {
            ToolTipML = ENU = 'Specifies the address of the location from which items are transferred.', FRA = 'Spécifie l''adresse du magasin à partir duquel les articles sont transférés.';
        }
        modify("Transfer-from Address 2")
        {
            ToolTipML = ENU = 'Specifies an additional part of the address.', FRA = 'Spécifie une partie supplémentaire pour l''adresse.';
        }
        modify("Transfer-from Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the location from which items are transferred.', FRA = 'Spécifie le code postal à partir duquel les articles sont transférés.';
        }
        modify("Transfer-from City")
        {
            ToolTipML = ENU = 'Specifies the city of the location from which items are transferred.', FRA = 'Spécifie la ville du magasin à partir duquel les articles sont transférés.';
        }
        modify("Transfer-from Contact")
        {
            ToolTipML = ENU = 'Specifies the name of the contact person at the transfer-from location.', FRA = 'Spécifie le nom du contact dans le magasin provenance transfert.';
        }
        modify("Shipment Date")
        {
            ToolTipML = ENU = 'Specifies the date the order is expected to be shipped.', FRA = 'Indique la date d''expédition prévue de la commande.';
        }
        modify("Outbound Whse. Handling Time")
        {
            ToolTipML = ENU = 'Specifies the time it takes for the Transfer-from location to prepare the shipment to the Transfer-to location.', FRA = 'Indique le temps qu''il faut au magasin de provenance du transfert pour préparer l''expédition vers le magasin de destination du transfert.';
        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies the shipment method code that you have entered for this order.', FRA = 'Spécifie le code condition livraison saisi pour cette commande.';
        }
        modify("Shipping Agent Code")
        {
            ToolTipML = ENU = 'Specifies the code for the shipping agent you are using to ship the items on this transfer order.', FRA = 'Indique le code du transporteur que vous utilisez pour expédier les articles de l''ordre de transfert.';

            // BC Upgrade SHUKLP03 >> Code is blocked because dependency on DrinkIT field ShippingAgent."Vendor No.".
            // trigger OnBeforeValidate()
            // begin
            //     //HEI.03>>
            //     IF ShippingAgent.GET(Rec."Shipping Agent Code") THEN BEGIN
            //         //HEI.04>>
            //         //IF ShippingAgent."Vendor No." = '' THEN
            //         IF (ShippingAgent."Vendor No." = '') AND (NOT ShippingAgent."Own Logistics") THEN
            //             //HEI.04<<
            //             ERROR(ShippingAgentVendorIsBlank)
            //         else IF Vend.GET(ShippingAgent."Vendor No.") THEN BEGIN
            //             IF Vend.Blocked <> 0 THEN
            //                 ERROR(VendorBlockForShipAgent);
            //         end;
            //     end;
            //     //HEI.03<<
            // end;
            // BC Upgrade SHUKLP03 >> Code is blocked because dependency on DrinkIT field ShippingAgent."Vendor No.".

        }
        modify("Shipping Agent Service Code")
        {
            ToolTipML = ENU = 'Specifies the code for the shipping agent service that you are using to ship the items on this transfer order.', FRA = 'Spécifie le code prestation transporteur à utiliser pour expédier les articles de l''ordre de transfert.';

            trigger OnAfterValidate()
            begin
                //>> HEI.05 FDD-HT658 IBM.GUNERE01 24.09.2019
                //ShippingAgentServiceCodeOnAfte;
                IF Rec."Shipping Agent Service Code" <> xRec."Shipping Agent Service Code" THEN
                    CurrPage.UPDATE(TRUE);
                //<< HEI.05 FDD-HT658 IBM.GUNERE01 24.09.2019
            end;

            trigger OnLookup(var Text: Text): Boolean
            var
                myInt: Integer;
            begin
                //>> HEI.05
                Rec.FilterShippingAgentServiceCode(); // BC Upgrade SHUKLP03 << Table "Transfer Header" code is added here because we can't add OnLookup code on table.
                //<< HEI.05
            end;

        }
        modify("Shipping Time")
        {
            ToolTipML = ENU = 'Specifies the shipping time, used to calculate the receipt date.', FRA = 'Spécifie le délai d''expédition utilisé pour calculer la date de réception.';
        }
        modify("Shipping Advice")
        {
            ToolTipML = ENU = 'Specifies advice for the warehouse sending the items, about whether a partial delivery is acceptable.', FRA = 'Indique à l''entrepôt qui doit expédier les articles si une livraison partielle est possible ou non.';
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
            ToolTipML = ENU = 'Specifies an additional part of the transfer-to name of the location that you are transferring items to.', FRA = 'Indique des informations supplémentaires relatives au nom du magasin destination du transfert vers lequel les articles sont transférés.';
        }
        modify("Transfer-to Address")
        {
            ToolTipML = ENU = 'Specifies the address of the location that you are transferring items to.', FRA = 'Spécifie l''adresse du magasin vers lequel vous transférez les articles.';
        }
        modify("Transfer-to Address 2")
        {
            ToolTipML = ENU = 'Specifies an additional part of the address of the location to which items are transferred.', FRA = 'Indique des informations supplémentaires relatives à l''adresse du magasin vers lequel les articles sont transférés.';
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
            ToolTipML = ENU = 'Specifies the date that you expect the transfer-to location to receive the shipment.', FRA = 'Spécifie la date à laquelle le magasin destination transfert doit réceptionner l''expédition.';
        }
        modify("Inbound Whse. Handling Time")
        {
            ToolTipML = ENU = 'Specifies the time it takes to make items part of available inventory, after the items have been posted as received.', FRA = 'Indique le temps nécessaire pour que les articles soient inclus dans le stock disponible une fois les articles validés.';
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

        //Unsupported feature: CodeInsertion on ""Transfer-from Code"(Control 14)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        TransferfromCodeOnAfterValidat;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Transfer-to Code"(Control 34)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        TransfertoCodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""In-Transit Code"(Control 8)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        InTransitCodeOnAfterValidate;
        */
        //end;





        //Unsupported feature: CodeModification on ""Shipping Agent Service Code"(Control 74).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShippingAgentServiceCodeOnAfte;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //>> HEI.05 FDD-HT658 IBM.GUNERE01 24.09.2019
        //ShippingAgentServiceCodeOnAfte;
        if "Shipping Agent Service Code" <> xRec."Shipping Agent Service Code" then
          CurrPage.UPDATE(true);
        //<< HEI.05 FDD-HT658 IBM.GUNERE01 24.09.2019
        */
        //end;

        // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
        // addafter("No.")
        // {
        //     field("Trsf-from Ph. Location Gr Code";Rec."Trsf-from Ph. Location Gr Code")
        //     {

        //         trigger OnValidate();
        //         begin
        //             TrsffromPhLocationGrCodeOnAfte;
        //         end;
        //     }
        // }
        // addafter("Transfer-from Code")
        // {
        //     field("Trsf-to Ph. Location Gr Code";"Trsf-to Ph. Location Gr Code")
        //     {

        //         trigger OnValidate();
        //         begin
        //             TrsftoPhLocationGrCodeOnAfterV;
        //         end;
        //     }
        // }
        // addafter("In-Transit Code")
        // {
        //     field("Emergency Order";"Emergency Order")
        //     {
        //     }
        //     field("Logistics Group";"Logistics Group")
        //     {
        //     }
        // }
        // addafter("Posting Date")
        // {
        //     field("Tax Date";"Tax Date")
        //     {
        //     }
        // }
        // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.

        addafter(Status)
        {
            // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
            //     field("Document Shipping Costs";"Document Shipping Costs")
            //     {
            //     }
            //     field(txtStatusCtrl;txtStatus)
            //     {
            //         CaptionML = ENU='Replenishment Status',
            //                     FRA='Etat Réapprovisionnement';
            //         Description = 'FINXL8.00';
            //         Editable = false;
            //         Style = StandardAccent;
            //         StyleExpr = blnNoStock;
            //     }
            // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.

            field("Request Order No."; Rec."Request Order No. FND")
            {
                Description = 'HEI.01';
                Visible = RequestOrderEnabled;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Request Order No. field.';

            }
            field("External Document No."; Rec."External Document No.")
            {
                Visible = ExternalDocNoEnabled;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the External Document No. field.';

            }
            field("IC Document"; Rec."IC Document FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the IC Document field.';

            }
            field("PO Reference"; Rec."PO Reference FND")
            {
                ApplicationArea = All;
                AssistEdit = true;
                DrillDown = false;
                Editable = false;
                Lookup = false;
                ToolTip = 'Specifies the value of the PO Reference field.';

                trigger OnAssistEdit();
                begin
                    //>>HEI.17
                    //>>HEI.10
                    Rec.TESTFIELD("Import Identifier FND", false); //HEI.15
                    PurchHdrRec_1.RESET();

                    PurchLineRec.RESET();
                    PurchLineRec.SETRANGE("Document Type", PurchLineRec."Document Type"::Order);
                    PurchLineRec.SETRANGE("Location Code", Rec."Transfer-from Code");
                    if PurchLineRec.findset() then
                        PurchLineRec_1.COPY(PurchLineRec);

                    CLEAR(PurchTempNo);
                    //PurchLineRec_1.RESET;
                    PurchLineRec_1.SETFILTER("Document No.", '<>%1', '');
                    if PurchLineRec_1.findset() then begin
                        repeat
                            if PurchTempNo <> PurchLineRec_1."Document No." then begin
                                PurchHdrRec.RESET();
                                PurchHdrRec.SETRANGE("No.", PurchLineRec_1."Document No.");
                                PurchHdrRec.SETRANGE(Status, PurchHdrRec.Status::Released);
                                PurchHdrRec.SETRANGE("Import Identifier FND", false);//HEI.15
                                if PurchHdrRec.FINDFIRST() then begin
                                    repeat
                                        PurchHdrRec_1.INIT();
                                        PurchHdrRec_1.TRANSFERFIELDS(PurchHdrRec);
                                        if PurchHdrRec_1.INSERT() then;
                                    until PurchHdrRec.NEXT() = 0;
                                end;
                                PurchTempNo := PurchHdrRec."No.";
                            end;
                        until PurchLineRec_1.NEXT() = 0;
                    end;
                    COMMIT();
                    if PAGE.RUNMODAL(9307, PurchHdrRec_1) = ACTION::LookupOK then begin
                        Rec."PO Reference FND" := PurchHdrRec_1."No.";
                        Rec."Extra PO Reference FND" := PurchHdrRec_1."Your Reference";
                        //EXIT(TRUE);
                    end;
                    //<<HEI.10
                    //<<HEI.17
                end;
            }
            field("Import Identifier"; Rec."Import Identifier FND")
            {
                DrillDown = false;
                Editable = false;
                Lookup = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Import Identifier field.';
            }
            field("Extra PO Reference"; Rec."Extra PO Reference FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Extra PO Reference field.';
            }
            field("Created By"; Rec."Created By FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Created By field.';
            }
            field(ExternalDocumentNo2; Rec."External Document No.")
            {
                Editable = ExternalDocNoEditable;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the External Document No. field.';

            }
        }

        // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.
        // addafter("Shipping Time")
        // {
        //     field("Delivery Sequence"; "Delivery Sequence")
        //     {
        //     }
        // }

        // addafter("Shipping Advice")
        // {
        //     field(Route; Route)
        //     {
        //         ShowMandatory = RouteAsMandatory;

        //         trigger OnValidate();
        //         begin
        //             //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //             CurrPage.UPDATE;
        //             //>> DITW110.00.12 AKH NRQ#16026
        //         end;
        //     }
        // field(Distance; Distance)
        // {
        // }
        // field("Truck Code"; Rec."Truck Code")
        // {
        //     Editable = MultipleRouteOrderEditable;

        //     trigger OnValidate();
        //     begin
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         if xRec."Truck Code" <> Rec."Truck Code" then
        //             CurrPage.UPDATE(true);
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field("Driver Code"; "Driver Code")
        // {
        //     Editable = MultipleRouteOrderEditable;

        //     trigger OnValidate();
        //     begin
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         if xRec."Driver Code" <> Rec."Driver Code" then
        //             CurrPage.UPDATE(true);
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field("Driver 2 Code"; "Driver 2 Code")
        // {
        //     Editable = MultipleRouteOrderEditable;

        //     trigger OnValidate();
        //     begin
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         if xRec."Driver 2 Code" <> Rec."Driver 2 Code" then
        //             CurrPage.UPDATE(true);
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        //     field("Maximum Weight"; "Maximum Weight")
        //     {
        //         Editable = false;
        //         Style = Strong;
        //         StyleExpr = "Maximum WeightEmphasize";
        //         Visible = "Maximum WeightVisible";
        //     }
        //     field("Maximum Cubage"; "Maximum Cubage")
        //     {
        //         Editable = false;
        //         Style = Strong;
        //         StyleExpr = "Maximum CubageEmphasize";
        //         Visible = "Maximum CubageVisible";
        //     }
        //     field("Work Order No."; "Work Order No.")
        //     {
        //     }
        // }
        // addafter("Inbound Whse. Handling Time")
        // {
        //     field("Fiscal Representative No."; "Fiscal Representative No.")
        //     {
        //     }
        //     field("Tax Office Code"; "Tax Office Code")
        //     {
        //     }
        //     field("Journey Time"; "Journey Time")
        //     {
        //         Description = 'DITW15.00.00.39 #1353';
        //     }
        // }
        // addafter("Transport Method")
        // {
        //     field("Transport Mode"; "Transport Mode")
        //     {
        //         Description = 'DIT715 #187';
        //         Editable = false;
        //     }
        // }
        // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.
    }
    actions
    {
        modify("O&rder")
        {
            CaptionML = ENU = 'O&rder', FRA = 'O&rdre';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Documents)
        {
            CaptionML = ENU = 'Documents', FRA = 'Documents';
        }
        modify("S&hipments")
        {
            CaptionML = ENU = 'S&hipments', FRA = '&Expédition';
        }
        modify("Re&ceipts")
        {
            CaptionML = ENU = 'Re&ceipts', FRA = '&Réception';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("Whse. Shi&pments")
        {
            CaptionML = ENU = 'Whse. Shi&pments', FRA = 'E&xpéditions entrep.';
        }
        modify("&Whse. Receipts")
        {
            CaptionML = ENU = '&Whse. Receipts', FRA = 'Ré&ceptions entrep.';
        }
        modify("In&vt. Put-away/Pick Lines")
        {
            CaptionML = ENU = 'In&vt. Put-away/Pick Lines', FRA = 'Lignes prélè&v./rangement stock';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
        modify(Release)
        {
            CaptionML = ENU = 'Release', FRA = 'Lancer';
        }
        modify("Re&lease")
        {
            CaptionML = ENU = 'Re&lease', FRA = '&Lancer';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Reo&pen")
        {
            trigger OnBeforeAction()
            var
                PurchHeader: Record "Purchase Header";
                lrec_PurchHdrAddtnl: Record "Purchase Header Additional FND";
                lrec_PurchLn: Record "Purchase Line";
                ReleaseTransferDoc: Codeunit "Release Transfer Document";
                Onelienreceipt: Boolean;
            begin
                IF Rec."PO Reference FND" <> '' THEN
                    IF PurchHeader.GET(PurchHeader."Document Type"::Order, Rec."PO Reference FND") THEN BEGIN
                        PurchHeader.CALCFIELDS("Import Identifier FND");
                        //HEI.18>>
                        //IF PurchHeader."Import Identifier" THEN
                        //  ERROR(Text50001, Rec."No.", Rec."PO Reference");
                        IF PurchHeader."Import Identifier FND" THEN BEGIN
                            lrec_PurchLn.RESET();
                            lrec_PurchLn.SETRANGE("Document Type", PurchHeader."Document Type");
                            lrec_PurchLn.SETRANGE("Document No.", PurchHeader."No.");
                            lrec_PurchLn.SETFILTER("Quantity Received", '<>%1', 0);
                            IF NOT lrec_PurchLn.ISEMPTY THEN
                                ReleaseTransferDoc.Reopen(Rec)
                            else
                                ERROR(Text50001, Rec."No.", Rec."PO Reference FND");
                        end;
                        //HEI.18<<
                    end;
                //  else
                //    ReleaseTransferDoc.Reopen(Rec);
                //else
                // ReleaseTransferDoc.Reopen(Rec); // BC Upgrade SHUKLP03 << Blocked this code because this is calling on trigger OnAction().
                //HEI.15 <<
                //HEI.13<<
            end;
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            CaptionML = ENU = 'Create Inventor&y Put-away/Pick', FRA = 'Créer prélèv./rangement stoc&k';
        }
        modify("Get Bin Content")
        {
            CaptionML = ENU = 'Get Bin Content', FRA = 'Extraire contenu emplacement';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
        }
        modify(PostAndPrint)
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
        }
        modify("Inventory - Inbound Transfer")
        {
            CaptionML = ENU = 'Inventory - Inbound Transfer', FRA = 'Stocks : Enlogement transfert';
        }


        //Unsupported feature: CodeModification on ""Reo&pen"(Action 48).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleaseTransferDoc.Reopen(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.13>>
        //ReleaseTransferDoc.Reopen(Rec);
        //HEI.15 >>
        //Onelienreceipt := FALSE;
        //IF lrec_PurchHdrAddtnl.GET(lrec_PurchHdrAddtnl."Document Type"::Order,"PO Reference") THEN BEGIN
        //  IF lrec_PurchHdrAddtnl."Import Identifier" THEN BEGIN
        //    lrec_PurchLn.RESET;
        //    lrec_PurchLn.SETRANGE("Document Type",lrec_PurchHdrAddtnl."Document Type");
        //    lrec_PurchLn.SETRANGE("Document No.",lrec_PurchHdrAddtnl."No.");
        //    IF lrec_PurchLn.findset THEN REPEAT
        //      IF (lrec_PurchLn."Quantity Received" <> 0) THEN
        //        Onelienreceipt := TRUE;
        //    UNTIL (lrec_PurchLn.NEXT = 0) OR (Onelienreceipt = TRUE);
        //  end;
        //end;

        //IF ("PO Reference" <> '') THEN BEGIN
        //  IF NOT Onelienreceipt THEN
        if Rec."PO Reference" <> '' then
          if PurchHeader.GET(PurchHeader."Document Type"::Order, "PO Reference") then begin
            PurchHeader.CALCFIELDS("Import Identifier");
            //HEI.18>>
            //IF PurchHeader."Import Identifier" THEN
            //  ERROR(Text50001, Rec."No.", Rec."PO Reference");
            if PurchHeader."Import Identifier" then begin
              lrec_PurchLn.RESET;
              lrec_PurchLn.SETRANGE("Document Type",PurchHeader."Document Type");
              lrec_PurchLn.SETRANGE("Document No.",PurchHeader."No.");
              lrec_PurchLn.SETFILTER("Quantity Received",'<>%1',0);
              if not lrec_PurchLn.ISEMPTY then
                ReleaseTransferDoc.Reopen(Rec)
              else
                ERROR(Text50001, Rec."No.", Rec."PO Reference");
            end;
            //HEI.18<<
          end;
        //  else
        //    ReleaseTransferDoc.Reopen(Rec);
        //else
        ReleaseTransferDoc.Reopen(Rec);
        //HEI.15 <<
        //HEI.13<<
        */
        //end;

        //Unsupported feature: CodeModification on ""Create &Whse. Receipt"(Action 84).OnAction". Please convert manually.

        //trigger  Receipt"(Action 84)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSourceDocInbound.CreateFromInbndTransferOrder(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.12>>
        if LSRInterfaceSetup.GET and LSRInterfaceSetup."Enable LSR Interface" then
          if InterfaceSetup.GET(LSRInterfaceSetup."Transfer Receipt Interface Out") then
          if InterfaceSetup.Enabled then
            if "LSR Order No" <> '' then begin
              LocationTo.GET("Transfer-to Code");
              if LocationTo.Store then
                ERROR(CannotReceiveInHLErr);
            end;
        //HEI.12<<

        // <<DITW15.00.00.38 DDR 21/12/2010 #1146
        ReleaseTransferOrder();
        // >>DITW15.00.00.38 DDR #1146
        GetSourceDocInbound.CreateFromInbndTransferOrder(Rec);
        */
        //end;


        //Unsupported feature: CodeModification on ""Create Inventor&y Put-away/Pick"(Action 94).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CreateInvtPutAwayPick;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.38 DDR 21/12/2010 #1146
        ReleaseTransferOrder();
        // >>DITW15.00.00.38 DDR #1146
        CreateInvtPutAwayPick;
        */
        //end;

        // BC Upgrade SHUKLP03 << DrinkIT actions are blocked.
        //     addafter(Dimensions)
        //     {
        //         action("Shipping Costs")
        //         {
        //             CaptionML = ENU='Shipping Costs',
        //                         FRA='Coûts transport';
        //             Image = Costs;
        //             RunObject = Page "Document Shipping Cost";
        //                             RunPageLink = "Source Type"=CONST(5740),
        //                           "Source No."=FIELD("No."),
        //                           "Sub Type"=CONST(0);
        //         }
        //     }
        //     addfirst(Documents)
        //     {
        //         action("Comments - Transport Mode")
        //         {
        //             CaptionML = ENU='Comments - Transport Mode',
        //                         FRA='Commantaires - Mode de transport';
        //             Description = 'DIT715 #187';
        //             Image = ViewComments;
        //             RunObject = Page "EMCS Comment Sheet";
        //                             RunPageLink = "Table ID"=CONST(5740),
        //                           "Document Type"=CONST(0),
        //                           "Document No."=FIELD("No."),
        //                           "Document Line No."=CONST(0),
        //                           "Field ID"=CONST(2014277);
        //         }
        //     }
        //     addafter("Get Bin Content")
        //     {
        //         action("&Automatic FEFO Tracking for Order")
        //         {
        //             Caption = '&Automatic FEFO Tracking for Order';
        //             Description = 'DITW111.00.13A MSF 30/04/2019 NRQ#106834';
        //             Image = ItemTracking;
        //             ShortCutKey = 'Shift+Ctrl+F';

        //             trigger OnAction();
        //             begin
        //                 // <<DITW111.00.13A MSF 30/04/2019 NRQ#106834
        //                 CurrPage.SAVERECORD;
        //                 COMMIT;
        //                 FEFOTrackingTransferOrder();
        //                 CurrPage.UPDATE(false);
        //             end;
        //         }
        //         action("Undo Tracking Lines")
        //         {
        //             Caption = 'Undo Tracking Lines';
        //             Description = 'DITW111.00.13A MSF 30/04/2019 NRQ#106834';
        //             Image = Undo;

        //             trigger OnAction();
        //             var
        //                 TransferLineReserve : Codeunit "Transfer Line-Reserve";
        //             begin
        //                 //<<DITW111.00.13A MSF 30/04/2019 NRQ#106834
        //                 TransferLineReserve.AutomaticUndoTransferReservation(Rec);
        //             end;
        //         }
        //     }
        //     addafter(PostAndPrint)
        //     {
        //         action("Transfer Order")
        //         {
        //             CaptionML = ENU='Transfer Order',
        //                         FRA='Ordre de transfert';
        //             Ellipsis = true;
        //             Image = Document;

        //             trigger OnAction();
        //             var
        //                 DocPrint : Codeunit "Document-Print";
        //             begin
        //                 // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //                 CurrPage.TransferLines.PAGE.SetDisableRefreshLines(true);
        //                 // >>DITW16.00.00.40 DDR DIT-715 #197
        //                 // <<DITW15.00.00.36 DDR 17/12/2009
        //                 DocPrint.PrintTransferHeader(Rec);
        //                 // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //                 CurrPage.TransferLines.PAGE.SetDisableRefreshLines(false);
        //                 // >>DITW16.00.00.40 DDR DIT-715 #197
        //             end;
        //         }
        //         action("Test AAD Shipment")
        //         {
        //             CaptionML = ENU='Test AAD Shipment',
        //                         FRA='Test Expédition AAD';
        //             Ellipsis = true;
        //             Image = TestFile;

        //             trigger OnAction();
        //             var
        //                 DocPrint : Codeunit "Document-Print";
        //             begin
        //                 // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //                 CurrPage.TransferLines.PAGE.SetDisableRefreshLines(true);
        //                 // >>DITW16.00.00.40 DDR DIT-715 #197
        //                 // <<DITW15.00.00.28 DDR 26/11/2008
        //                 DocPrint.PrintTransferHeaderAAD(Rec);
        //                 // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //                 CurrPage.TransferLines.PAGE.SetDisableRefreshLines(false);
        //                 // >>DITW16.00.00.40 DDR DIT-715 #197
        //             end;
        //         }
        //     }
        // }
        // BC Upgrade SHUKLP03 << DrinkIT actions are blocked.
    }

    // var
    //     lrec_PurchHdrAddtnl: Record "Purchase Header Additional FND";
    //     lrec_PurchLn: Record "Purchase Line";
    //     Onelienreceipt: Boolean;
    //PurchHeader: Record "Purchase Header";
    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Do you want to change %1 in all related records in the warehouse?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Do you want to change %1 in all related records in the warehouse?;FRA=Souhaitez-vous modifier %1 dans tous les enregistrements associés de l'entrepôt ?;
    //Variable type has not been exported.

    var
        //recFinXLSetup: Record "Finance XL Setup"; // BC Upgrade SHUKLP03 << DrinkIT variable
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        InvtSetup: Record "Inventory Setup";
        PurchHdrRec: Record "Purchase Header";
        PurchHdrRec_1: Record "Purchase Header" temporary;
        PurchLineRec: Record "Purchase Line";
        PurchLineRec_1: Record "Purchase Line";
        ShippingAgent: Record "Shipping Agent";
        Vend: Record Vendor;
        WhseSetup: Record "Warehouse Setup";
        PurchPage: Page "Purchase Order List";
        blnNoStock: Boolean;
        ExternalDocNoEditable: Boolean;
        ExternalDocNoEnabled: Boolean;

        "Maximum CubageEmphasize": Boolean;

        "Maximum CubageVisible": Boolean;

        "Maximum WeightEmphasize": Boolean;

        "Maximum WeightVisible": Boolean;
        MultipleRouteOrderEditable: Boolean;
        RequestOrderEnabled: Boolean;

        RouteAsMandatory: Boolean;
        PurchNo: Code[20];
        PurchTempNo: Code[20];
        ShippingAgentVendorIsBlank: Label 'There is no Vendor associated with this Shipping Agent';
        Text50001: Label '"Tranfer Order - %1 can not be opened manually as it is created from Import PO - %2 "';
        VendorBlockForShipAgent: Label '"The Vendor associated with this Shipping Agent is blocked "';
        txtStatus: Text[80];
        txt2036301: TextConst ENU = 'No Stock', FRA = 'Pas d''inv.';


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
    RouteAsMandatory := InvtSetup."Route Mandatory";
    //>> DITW110.00.12 AKH NRQ#16026
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    trigger OnAfterGetRecord();
    begin
        ExternalDocNoEditable := NOT Rec."IC Document FND"; //HEI.07
    end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
    MultipleRouteOrderEditable := true;
    "Maximum WeightVisible" := true;
    "Maximum CubageVisible" := true;
    //>> DITW110.00.12 AKH NRQ#16026
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    trigger OnOpenPage();
    begin
        //HEI.01>>
        GeneralOpCoSetup.GET();
        RequestOrderEnabled := GeneralOpCoSetup."Enable Request Order";
        //HEI.01<<
        ExternalDocNoEnabled := Rec."Request Order No. FND" <> ''; //HEI.02
    end;

    // BC Upgrade SHUKLP03 << DrinkIT procedures are blocked.
    // local procedure fctCalculateReplanStatus();
    // begin
    //     //<<FINXL8.00.001 BSA 29/05/2015 #180
    //     txtStatus := '';
    //     CLEAR(cduOrderTrackingMngt);
    //     txtStatus := cduOrderTrackingMngt.CalculateStatusString(cduOrderTrackingMngt.fctCalculateTransferStatus(Rec));
    //     blnNoStock := (STRPOS(txtStatus, txt2036301) <> 0);
    //     //>>FINXL8.00.001 BSA 29/05/2015 #180
    // end;

    // local procedure ReleaseTransferOrder();
    // begin
    //     // <<DITW15.00.00.38 DDR 21/12/2010 #1146
    //     WhseSetup.GET;
    //     if WhseSetup."Auto.Release Transfer on Whse." then begin
    //         CODEUNIT.RUN(CODEUNIT::"Release Transfer Document", Rec);
    //     end;
    // end;

    // local procedure InTransitCodeOnAfterValidate();
    // begin
    //     // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
    //     CurrPage.UPDATE(true);
    //     // >>DITW16.00.00.39 DDR DIT-715 #141
    // end;

    // local procedure TransferfromCodeOnAfterValidat();
    // begin
    //     // <<DITW15.00.00.37 DDR 31/05/2010
    //     CurrPage.TransferLines.PAGE.UpdateForm(true);
    // end;

    // local procedure TransfertoCodeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.37 DDR 31/05/2010
    //     CurrPage.TransferLines.PAGE.UpdateForm(true);
    // end;

    // local procedure TrsffromPhLocationGrCodeOnAfte();
    // begin
    //     // <<DITW15.00.00.37 DDR 31/05/2010
    //     CurrPage.TransferLines.PAGE.UpdateForm(true);
    // end;

    // local procedure TrsftoPhLocationGrCodeOnAfterV();
    // begin
    //     // <<DITW15.00.00.37 DDR 31/05/2010
    //     CurrPage.TransferLines.PAGE.UpdateForm(true);
    // end;

    // local procedure FormatMaximumControls(NoField: Integer; MaxValue: Decimal; TotalValue: Decimal);
    // var
    //     Bold: Boolean;
    //     Color: Integer;
    // begin
    //     //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
    //     Color := 0;
    //     Bold := false;

    //     if MaxValue < TotalValue then
    //         Color := 255;

    //     Bold := Color <> 0;

    //     "Maximum CubageVisible" := false;
    //     "Maximum WeightVisible" := false;

    //     case NoField of
    //         FIELDNO("Maximum Weight"):
    //             begin
    //                 "Maximum WeightEmphasize" := Bold;
    //             end;
    //         FIELDNO("Maximum Cubage"):
    //             begin
    //                 "Maximum CubageEmphasize" := Bold;
    //             end;
    //     end;

    //     "Maximum CubageVisible" := true;
    //     "Maximum WeightVisible" := true;
    // end;

    // local procedure MaximumCubageOnFormat();
    // begin
    //     //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
    //     CALCFIELDS("Total Cubage");
    //     FormatMaximumControls(FIELDNO("Maximum Cubage"), "Maximum Cubage", "Total Cubage");
    // end;

    // local procedure MaximumWeightOnFormat();
    // begin
    //     //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
    //     CALCFIELDS("Total Weight");
    //     FormatMaximumControls(FIELDNO("Maximum Weight"), "Maximum Weight", "Total Weight");
    // end;
    // BC Upgrade SHUKLP03 << DrinkIT procedures are blocked.


    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

