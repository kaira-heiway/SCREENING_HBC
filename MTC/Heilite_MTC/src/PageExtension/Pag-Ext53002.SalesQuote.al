pageextension 53002 SalesQuoteExtension extends "Sales Quote"
{
    // version NAVW110.0.00.16177,DITW110.00.09
    // DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    //   DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.01 DDR 17/01/2008 some Captions
    //                                  New calling functions to insert (item) charges
    //   DITW15.00.00.01 DDR 21/01/2008 Remove unused textconst
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    //   DITW15.00.00.25 DDR 21/10/2008 Deleted field2013722 Duty Tax Type
    //   DITW15.00.00.37 DDR 18/06/2010 issue 1028 Added Addtional credit limits and delayed discounts to calculate the available credit
    //                                             Added 'SalesOrderDate' parameter CalcAvailableCredit()
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                       02/08/2010 DIT717 #16 Celenia update
    //                   CEL 13/08/2010           Modification RTC buttons
    //   DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                             Added parameter line function RTCActionNewLine() into RTCNewLine button
    //   DITW15.00.00.39 DDR 27/04/2011 issue 1322 NAVBE5.00 (SP1) functionnality to insert Customer Std. Sales Codes automatically
    //                                  Added to call function StdCustSalesCode.AutoInsertSalesLines()
    //                                    from OnAfterValidate trigger field "Sell-to Customer No."
    //   DITW15.00.00.39 DDR 27/04/2011 issue 1230 Telesales functionnalities
    //   DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                                Added to insert first line automatically
    //                       19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab

    //   FINXL7.00.001 RBE 20/03/2013 : Added PDF functionality
    //   FINXL7.00.001 KLU 25/09/2013 : Added actions for approve/reject (same functionality as approval entries form)
    //   FINXL8.00.001 RBE 01/12/2014 : Removed Print & Mail action

    //   DITW17.00.01 DDR 13/02/2013 DIT - 770 #001 Upgrade
    //   DITW17.10.02 DDR 22/11/2013 DIT - 770 #000 Upgrade R2
    //   DITW17.10.03 DDR 19/05/2014 DIT - 770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW18.00.06 DDR 19/02/2015 DIT - 770 #1190 Multisite - Added fields "Physical Location Group Code"
    //   DITW18.00.06 DDR 25/02/2015 DIT - 770 #1190 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    //   DITW17.10.04 DDR 07/08/2014 DIT - 770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.04 AKH 19/12/2014 DIT - 770 #1022 Merge DIT W1 R4 in R5
    //   DITW18.00.07 VSC 28/06/2016 DIT - 770 #1282 Added Fields "Creation Date/Time","Created By" Importance Additional
    //   DITW18.00.07 VSC 01/07/2016 DIT - 770 #1282 Set fields to visible "Creation Date/Time","Created By"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //   DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    //   DITW111.00.13A DDR 01/07/2019 NRQ#103938 Added visibility for Action Send Approval

    //   HEI.01 CHG2084621 HB1742 IBM GAVANM01 13.04.2021 - Sales Quotes functionality
    // # new global var MakeInvoiceVisible
    // # 'Visible' property set to MakeInvoiceVisible for action 'MakeInvoice'
    //BC Upgrade GUNREM01 Added code in Onopenpage
    //HEI.01 - BC Upgrade GUNREM01 Trigger OnNewrecord code not added becuase it drink-it table

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the sales document. The field can be filled automatically or manually and can be set up to be invisible.', FRA = 'Spécifie le numéro du document vente. Le champ peut être rempli automatiquement ou manuellement et être configuré pour être invisible.';
        }
        //BC UPGRADE KUMARR78 --
        // modify("Sell-to Customer Name")
        // {
        //     CaptionML = ENU = 'Customer', FRA = 'Client';
        //     ToolTipML = ENU = 'Specifies the name of the customer who will receive the products and be billed by default. The value is automatically inserted from the customer card when you fill the Sell-to Customer No. field. The value will appear on the printed sales document.', FRA = 'Spécifie le nom du client qui recevra les produits et sera facturé par défaut. La valeur est insérée automatiquement depuis la fiche client lorsque vous remplissez le champ N° donneur d''ordre. La valeur s''affichera sur le document vente imprimé.';
        // } //BC UPGRADE KUMARR78 --
        modify("Sell-to")
        {
            CaptionML = ENU = 'Sell-to', FRA = 'Donneur d''ordre';
        }
        modify("Sell-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address where the customer is located.', FRA = 'Spécifie l''adresse où se trouve le client.';

            //Unsupported feature: Change ImplicitType on ""Sell-to Address"(Control 71)". Please convert manually.

        }
        modify("Sell-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Sell-to Address 2"(Control 73)". Please convert manually.

        }
        modify("Sell-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Sell-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city where the customer is located.', FRA = 'Spécifie la ville où se trouve le client.';

            //Unsupported feature: Change ImplicitType on ""Sell-to City"(Control 74)". Please convert manually.

        }
        modify("Sell-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of the contact that the sales document will be sent to.', FRA = 'Spécifie le numéro du contact auquel vous envoyez le document vente.';
        }
        modify("Sell-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person to contact at the customer.', FRA = 'Spécifie le nom de la personne à contacter chez le client.';
        }
        modify("No. of Archived Versions")
        {
            ToolTipML = ENU = 'Specifies the number of archived versions for this sales document.', FRA = 'Spécifie le nombre de versions archivées pour ce document vente.';
        }
        modify("Order Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the exchange rate applies to prices listed in a foreign currency on the sales order.', FRA = 'Spécifie la date à laquelle le taux de change s''applique aux prix répertoriés dans une devise étrangère de la commande vente.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on which you created the sales document.', FRA = 'Spécifie la date à laquelle vous avez créé le document vente.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies when the sales invoice must be paid.', FRA = 'Spécifie la date à laquelle la facture vente doit être payée.';
        }
        modify("Requested Delivery Date")
        {
            ToolTipML = ENU = 'Specifies the date that the customer has asked for the order to be delivered.', FRA = 'Spécifie la date à laquelle le client a demandé à être livré.';
        }
        modify("Salesperson Code")
        {
            ToolTipML = ENU = 'Specifies the name of the salesperson who is assigned to the customer.', FRA = 'Spécifie le nom du vendeur affecté au client.';
        }
        modify("Campaign No.")
        {
            ToolTipML = ENU = 'Specifies the campaign number the document is linked to.', FRA = 'Spécifie le numéro de campagne auquel le document est lié.';
        }
        modify("Opportunity No.")
        {
            ToolTipML = ENU = 'Specifies the number of the opportunity that the sales quote is assigned to.', FRA = 'Spécifie le numéro de l''opportunité à laquelle le devis est affecté.';
        }
        modify("Responsibility Center")
        {
            ToolTipML = ENU = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.', FRA = 'Spécifie le code du centre de gestion qui est associé à l''utilisateur, à la société ou au fournisseur.';
        }
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.', FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.', FRA = 'Spécifie si le document est ouvert, est en attente d''approbation, a été facturé pour acompte ou a été lancé pour l''étape suivante du traitement.';
        }
        modify("Work Description")
        {
            CaptionML = ENU = 'Work Description', FRA = 'Description du travail';
        }
        modify(WorkDescription)
        {
            ToolTipML = ENU = 'Specifies the products or service being offered', FRA = 'Spécifie les produits ou services offerts';
        }
        modify("Invoice Details")
        {
            CaptionML = ENU = 'Invoice Details', FRA = 'Détails facture';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency of amounts on the sales document.', FRA = 'Spécifie la devise des montants sur le document vente.';
        }
        modify("Shipment Date")
        {
            ToolTipML = ENU = 'Specifies the date you expect to ship items on the sales document.', FRA = 'Spécifie la date à laquelle vous pensez expédier les articles indiqués sur le document vente.';
        }
        modify("Prices Including VAT")
        {
            ToolTipML = ENU = 'Specifies whether the unit price on the line should be displayed including or excluding VAT.', FRA = 'Spécifie si le prix unitaire de la ligne doit être affiché TTC ou hors taxes.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the customer''s VAT specification to link transactions made for this customer to.', FRA = 'Spécifie le détail TVA du client auquel associer des transactions faites pour ce client.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the sales document.', FRA = 'Spécifie une formule qui calcule la date d''échéance du paiement, la date d''escompte et le montant de la remise sur le document de vente.';
        }
        modify(SelectedPayments)
        {
            CaptionML = ENU = 'Payment Service', FRA = 'Service de paiement';
            ToolTipML = ENU = 'Specifies the online payment service, such as PayPal, that customers can use to pay the sales document.', FRA = 'Spécifie le service de paiement en ligne, tel que PayPal, que les clients peuvent utiliser pour payer le document vente.';
        }
        modify("Transaction Type")
        {
            ToolTipML = ENU = 'Specifies the type of transaction that the sales document represents, for the purpose of reporting to Intrastat.', FRA = 'Spécifie le type de transaction que représente le document vente, à des fins de compte rendu à Intrastat.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        modify("Payment Discount %")
        {
            ToolTipML = ENU = 'Specifies the payment discount percentage that is granted if the customer pays on or before the date entered in the Pmt. Discount Date field. The discount percentage is specified in the Payment Terms Code field.', FRA = 'Spécifie le pourcentage d''escompte possible qui est accordé si le client paye à la date entrée dans le champ Date d''escompte, ou de manière anticipée. Le pourcentage remise est spécifié dans le champ Code condition paiement.';
        }
        modify("Pmt. Discount Date")
        {
            ToolTipML = ENU = 'Specifies the last date the customer can pay the invoice and still receive a payment discount.', FRA = 'Indique la dernière date à laquelle le client facturé peut payer et obtenir un escompte.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.', FRA = 'Spécifie le magasin à partir duquel les articles de stock doivent être expédiés par défaut au client figurant sur le document vente.';
        }
        modify("Shipping and Billing")
        {
            CaptionML = ENU = 'Shipping and Billing', FRA = 'Expédition et facturation';
        }
        modify(ShippingOptions)
        {
            CaptionML = ENU = 'Ship-to', FRA = 'Destinataire';
            ToolTipML = ENU = 'Specifies the address that the products on the sales document are shipped to. Default (Sell-to Address): The same as the customer''s sell-to address. Alternate Ship-to Address: One of the customer''s alternate ship-to addresses. Custom Address: Any ship-to address that you specify in the fields below.', FRA = 'Spécifie l''adresse à laquelle les produits figurant sur le document vente sont expédiés. Par défaut (Adresse donneur d''ordre) : identique à l''adresse donneur d''ordre du client. Autre adresse destinataire : une des autres adresses destinataire du client. Adresse personnalisée : toute adresse destinataire que vous spécifiez dans les champs ci-dessous.';
            //OptionCaptionML = ENU = 'Default (Sell-to Address),Alternate Shipping Address,Custom Address', FRA = 'Par défaut (Adresse donneur d''ordre),Autre adresse de livraison,Adresse personnalisée';
        }
        modify("Ship-to Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            ToolTipML = ENU = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.', FRA = 'Spécifie le code d''une adresse de livraison différente de l''adresse du client, qui est entrée par défaut.';
        }
        modify("Ship-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the name that products on the sales document will be shipped to.', FRA = 'Spécifie le nom auquel les produits mentionnés sur le document vente seront expédiés.';
        }
        modify("Ship-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address that products on the sales document will be shipped to. By default, the field is filled with the value in the Address field on the customer card or with the value in the Address field in the Ship-to Address window.', FRA = 'Spécifie l''adresse à laquelle les produits mentionnés sur le document vente seront expédiés. Par défaut, le champ est renseigné avec la valeur du champ Adresse de la fiche client ou du champ Adresse de la fenêtre Adresse destinataire.';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 40)". Please convert manually.

        }
        modify("Ship-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 42)". Please convert manually.

        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Ship-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city that products on the sales document will be shipped to.', FRA = 'Spécifie la ville vers laquelle les produits mentionnés sur le document vente seront expédiés.';

            //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 93)". Please convert manually.

        }
        modify("Ship-to Country/Region Code")
        {
            CaptionML = ENU = 'Country/Region', FRA = 'Pays/région';
        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.', FRA = 'Spécifie le nom de la personne contact à l''adresse d''expédition des produits figurant sur le document vente.';
        }
        modify("Shipment Method")
        {
            CaptionML = ENU = 'Shipment Method', FRA = 'Conditions de livraison';
        }
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            ToolTipML = ENU = 'Specifies how items on the sales document are shipped to the customer.', FRA = 'Spécifie le mode d''expédition au client des articles figurant sur le document vente.';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Agent', FRA = 'Agent';
            ToolTipML = ENU = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
        }
        modify("Shipping Agent Service Code")
        {
            CaptionML = ENU = 'Agent service', FRA = 'Service agent';
            ToolTipML = ENU = 'Specifies which shipping agent service is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier les articles figurant sur le document vente au client.';
        }
        modify("Package Tracking No.")
        {
            ToolTipML = ENU = 'Specifies the shipping agent''s package number.', FRA = 'Spécifie le numéro récépissé du transporteur.';
        }
        modify(BillToOptions)
        {
            CaptionML = ENU = 'Bill-to', FRA = 'Facturation';
            ToolTipML = ENU = 'Specifies the customer that the sales invoice will be sent to. Default (Customer): The same as the customer on the sales invoice. Another Customer: Any customer that you specify in the fields below.', FRA = 'Spécifie le client auquel la facture vente sera envoyée. Par défaut (Client) : identique au client figurant sur la facture vente. Autre client : tout client que vous spécifiez dans les champs ci-dessous.';
            //OptionCaptionML = ENU = 'Default (Customer),Another Customer', FRA = 'Par défaut (Clients),Autre client';
        }
        modify("Bill-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the customer to whom you will send the sales invoice, when different from the customer that you are selling to.', FRA = 'Spécifie le nom du client auquel vous envoyez la facture vente, s''il diffère du client auquel vous vendez.';
        }
        modify("Bill-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address of the customer that you will send the invoice to.', FRA = 'Spécifie l''adresse du client qui sera facturé.';

            //Unsupported feature: Change ImplicitType on ""Bill-to Address"(Control 20)". Please convert manually.

        }
        modify("Bill-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Bill-to Address 2"(Control 22)". Please convert manually.

        }
        modify("Bill-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Bill-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city you will send the invoice to.', FRA = 'Spécifie la ville du client qui sera facturé.';

            //Unsupported feature: Change ImplicitType on ""Bill-to City"(Control 89)". Please convert manually.

        }
        modify("Bill-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of the contact the invoice will be sent to.', FRA = 'Spécifie le numéro du contact auquel vous envoyez la facture.';
        }
        modify("Bill-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person you should contact at the customer who you are sending the invoice to.', FRA = 'Spécifie le nom de la personne que vous devez contacter chez le client auquel vous envoyez la facture.';
        }
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        }
        modify("EU 3-Party Trade")
        {
            ToolTipML = ENU = 'Specifies whether the sales document is part of a three-party trade.', FRA = 'Spécifie si le document vente fait partie d''une transaction tripartite.';
        }
        modify("Transaction Specification")
        {
            ToolTipML = ENU = 'Specifies a code for the sales document''s transaction specification, for the purpose of reporting to INTRASTAT.', FRA = 'Spécifie un code pour le régime du document vente, à des fins de compte-rendu à INTRASTAT.';
        }
        modify("Transport Method")
        {
            ToolTipML = ENU = 'Specifies the transport method, for the purpose of reporting to INTRASTAT.', FRA = 'Spécifie le mode de transport, à des fins de compte-rendu à INTRASTAT.';
        }
        modify("Exit Point")
        {
            ToolTipML = ENU = 'Specifies the point of exit through which you ship the items out of your country/region, for reporting to Intrastat.', FRA = 'Spécifie le point de sortie par lequel les articles sortent de votre pays/région, à des fins de compte-rendu à Intrastat.';
        }
        modify("Area")
        {
            ToolTipML = ENU = 'Specifies the area of the customer''s address, for the purpose of reporting to INTRASTAT.', FRA = 'Spécifie la région de l''adresse du client, à des fins de compte-rendu à INTRASTAT.';
        }
        //BC UPGRADE KUMARR78 ++ General Work 08-04-2026
        modify("Sell-to Customer No.")
        {
            trigger OnBeforeValidate()
            var
                CustomerRec: Record Customer;
            begin
                if CustomerRec.Get(Rec."Sell-to Customer No.") then begin
                    if Rec."Document Type" in [Rec."Document Type"::Quote] then begin
                        CustomerRec.TestField("Avail.for Sales/ReturnOrd. FND", true);
                    end;
                end;
            end;

            trigger OnLookup(var Text: Text): Boolean
            var
                CustomerRec: Record Customer;
            begin
                CustomerRec.Reset();
                if Rec."Document Type" = Rec."Document Type"::Quote then begin
                    CustomerRec.SetRange("Avail.for Sales/ReturnOrd. FND", true);
                    if Page.RunModal(Page::"Customer Lookup", CustomerRec) = Action::LookupOK then
                        Rec.Validate("Sell-to Customer No.", CustomerRec."No.");
                    CurrPage.Update();
                end;

            end;

            trigger OnDrillDown()
            var
                CustomerRec: Record Customer;
            begin
                CustomerRec.Reset();
                if Rec."Document Type" = Rec."Document Type"::Quote then
                    CustomerRec.SetRange("Avail.for Sales/ReturnOrd. FND", true);

                if Page.RunModal(Page::"Customer Lookup", CustomerRec) = Action::LookupOK then begin
                    Rec.Validate("Sell-to Customer No.", CustomerRec."No.");
                end;
                CurrPage.Update();
            end;
        }
        modify("Sell-to Customer Name")
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
            ToolTipML = ENU = 'Specifies the name of the customer who will receive the products and be billed by default. The value is automatically inserted from the customer card when you fill the Sell-to Customer No. field. The value will appear on the printed sales document.', FRA = 'Spécifie le nom du client qui recevra les produits et sera facturé par défaut. La valeur est insérée automatiquement depuis la fiche client lorsque vous remplissez le champ N° donneur d''ordre. La valeur s''affichera sur le document vente imprimé.';
            trigger OnBeforeValidate()
            var
                CustomerRec: Record Customer;
            begin
                if CustomerRec.Get(Rec."Sell-to Customer No.") then begin
                    if Rec."Document Type" in [Rec."Document Type"::Quote] then begin
                        CustomerRec.TestField("Avail.for Sales/ReturnOrd. FND", true);
                    end;
                end;
            end;

            trigger OnLookup(var Text: Text): Boolean
            var
                CustomerRec: Record Customer;
            begin
                CustomerRec.Reset();
                if Rec."Document Type" = Rec."Document Type"::Quote then begin
                    CustomerRec.SetRange("Avail.for Sales/ReturnOrd. FND", true);
                    if Page.RunModal(Page::"Customer Lookup", CustomerRec) = Action::LookupOK then
                        Rec.Validate("Sell-to Customer Name", CustomerRec.Name);
                    CurrPage.Update();
                end;

            end;

            trigger OnDrillDown()
            var
                CustomerRec: Record Customer;
            begin
                CustomerRec.Reset();
                if Rec."Document Type" = Rec."Document Type"::Quote then
                    CustomerRec.SetRange("Avail.for Sales/ReturnOrd. FND", true);

                if Page.RunModal(Page::"Customer Lookup", CustomerRec) = Action::LookupOK then begin
                    Rec.Validate("Sell-to Customer Name", CustomerRec.Name);
                end;
                CurrPage.Update();
            end;
        }
        //BC UPGRADE KUMARR78 ++ General Work 08-04-2026

        //Unsupported feature: CodeModification on ""Sell-to Customer Name"(Control 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." then
          if "Sell-to Customer No." <> xRec."Sell-to Customer No." then
            SETRANGE("Sell-to Customer No.");

        CurrPage.UPDATE;

        if ApplicationAreaSetup.IsFoundationEnabled then
          SalesCalcDiscByType.ApplyDefaultInvoiceDiscount(0,Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..8

        // <<DITW15.00.00.39 DDR 27/04/2011 #1322 (BE5.00.01)
        CurrPage.UPDATE;
        COMMIT;
        StdCustSalesCode.AutoInsertSalesLines(Rec);
        // >>DITW15.00.00.39 DDR #1322 (BE5.00.01)
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Order Date"(Control 12)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW17.00.01 DDR 21/03/2013 DIT-770 #001
        CurrPage.UPDATE(true);
        // >>DITW17.00.01 DDR DIT-770 #001
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Document Date"(Control 15)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW17.00.01 DDR 21/03/2013 DIT-770 #001
        CurrPage.UPDATE(true);
        // >>DITW17.00.01 DDR DIT-770 #001
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Requested Delivery Date"(Control 118)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW17.00.01 DDR 21/03/2013 DIT-770 #001
        CurrPage.UPDATE(true);
        // >>DITW17.00.01 DDR DIT-770 #001
        */
        //end;


        //BC Upgrade GUNREM01 Commented Drink-IT code
        /*
        addafter("Document Date")
          {
                

             field("Tax Date"; "Tax Date")
              {

                  trigger OnValidate();
                  begin
                      // <<DITW17.00.01 DDR 21/03/2013 DIT-770 #001
                      CurrPage.UPDATE(true);
                      // >>DITW17.00.01 DDR DIT-770 #001
                  end;
              }
          }
          addafter(Status)
          {
              field("Creation Date/Time"; "Creation Date/Time")
              {
                  Description = 'DITW18.00.07 DIT-770 #1282';
                  Importance = Additional;
              }
              field("Created By"; "Created By")
              {
                  Description = 'DITW18.00.07 DIT-770 #1282';
                  Importance = Additional;
              }
          }
          addafter("Pmt. Discount Date")
          {
              field("Physical Location Group Code"; "Physical Location Group Code")
              {
                  Importance = Additional;
                  QuickEntry = false;

                  trigger OnValidate();
                  begin
                      // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
                      if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                          CurrPage.UPDATE(true);
                      // >>DITW18.00.06 DDR DIT-770 #1190
                  end;
              }
          }
          */     //BC Upgrade GUNREM01 Commenetd Drink-IT 
    }


    actions
    {
        modify("&Quote")
        {
            CaptionML = ENU = '&Quote', FRA = '&Devis';
        }
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("&View")
        {
            CaptionML = ENU = '&View', FRA = '&Afficher';
        }
        modify(Customer)
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
            ToolTipML = ENU = 'View details on the selected customer.', FRA = 'Affichez des détails sur le client sélectionné.';
        }
        modify("C&ontact")
        {
            CaptionML = ENU = 'C&ontact', FRA = 'Con&tact';
            ToolTipML = ENU = 'View details on the selected contact.', FRA = 'Affichez des détails sur le contact sélectionné.';
        }

        // modify(ActionGroup59)
        // {
        //     CaptionML = ENU = '&Quote', FRA = '&Devis';
        // } //BC Upgrade GUNREM01 Commented becuase in bc &Quote is group
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Print)
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            ToolTipML = ENU = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.', FRA = 'Préparez-vous à imprimer le document. Une fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';
        }
        modify(Email)
        {
            CaptionML = ENU = 'Send by &Email', FRA = 'Envoyer par &e-mail';
            ToolTipML = ENU = 'Prepare to mail the document. The Send Email window opens prefilled with the customer''s email address so you can add or edit information.', FRA = 'Préparez-vous à envoyer le document par e-mail. La fenêtre Envoyer e-mail s''ouvre préremplie avec l''adresse e-mail du client pour que vous puissiez ajouter ou modifier des informations.';
        }
        modify(GetRecurringSalesLines)
        {
            CaptionML = ENU = 'Get Recurring Sales Lines', FRA = 'Extraire les lignes vente récurrentes';
            ToolTipML = ENU = 'Get standard sales lines that are available to assign to customers.', FRA = 'Obtenez des lignes vente standard qui sont disponibles pour être affectées à des clients.';
        }
        modify(CopyDocument)
        {
            CaptionML = ENU = 'Copy Document', FRA = 'Copier document';
            ToolTipML = ENU = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.', FRA = 'Copiez les lignes document et les informations d''en-tête d''un autre document vente vers celui-ci. Vous pouvez copier une facture vente validée dans une nouvelle facture vente pour créer rapidement un document similaire.';
        }
        modify(Approval)
        {
            CaptionML = ENU = 'Approval', FRA = 'Approbation';
        }
        modify(Approve)
        {
            CaptionML = ENU = 'Approve', FRA = 'Approuver';
            ToolTipML = ENU = 'Approve the requested changes.', FRA = 'Approuvez les modifications requises.';
        }
        modify(Reject)
        {
            CaptionML = ENU = 'Reject', FRA = 'Rejeter';
            ToolTipML = ENU = 'Reject the approval request.', FRA = 'Rejetez la demande d''approbation.';
        }
        modify(Delegate)
        {
            CaptionML = ENU = 'Delegate', FRA = 'Déléguer';
            ToolTipML = ENU = 'Delegate the approval to a substitute approver.', FRA = 'Déléguez l''approbation à un approbateur remplaçant.';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comments', FRA = 'Commentaires';
            ToolTipML = ENU = 'View or add comments.', FRA = 'Affichez ou ajoutez des commentaires.';
        }
        modify(Create)
        {
            CaptionML = ENU = 'Create', FRA = 'Créer';
        }
        modify("MakeOrder")
        {
            CaptionML = ENU = 'Make &Order', FRA = '&Créer commande';
            ToolTipML = ENU = 'Convert the sales quote to a sales order.', FRA = 'Convertissez le devis en commande vente.';
        }
        modify(MakeInvoice)
        {
            CaptionML = ENU = 'Make Invoice', FRA = 'Établir facture';
            ToolTipML = ENU = 'Convert the sales quote to a sales invoice.', FRA = 'Convertissez le devis en facture vente.';
            Visible = MakeInvoiceVisisble;

            //Unsupported feature: Change Description on "MakeInvoice(Action 37)". Please convert manually.


            //Unsupported feature: Change Visible on "MakeInvoice(Action 37)". Please convert manually.

        }
        modify("C&reate Customer")
        {
            CaptionML = ENU = 'C&reate Customer', FRA = 'C&réer client';
        }
        // modify("Create &To-do")
        // {
        //     CaptionML = ENU = 'Create &To-do', FRA = 'Créer ac&tion';
        // } //BC upgrade GUNREM01 Commented Becuase in BC this action is named with "Create &Task"

        // modify(ActionGroup3)
        // {
        //     CaptionML = ENU = 'Release', FRA = 'Lancer';
        // }
        modify(Release)
        {
            CaptionML = ENU = 'Re&lease', FRA = '&Lancer';
        }
        modify(Reopen)
        {
            CaptionML = ENU = 'Re&open', FRA = 'R&ouvrir';
            ToolTipML = ENU = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.', FRA = 'Rouvrez le document pour le modifier après son approbation. Les documents approuvés ont le statut Lancé et doivent être ouverts pour pouvoir être modifiés.';
            ShortCutKey = 'Ctrl+F10';
        }
        modify("Request Approval")
        {
            CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';
        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send A&pproval Request', FRA = 'Envoyer demande d''a&pprobation';
            ToolTipML = ENU = 'Send an approval request.', FRA = 'Envoyez une demande d''approbation.';

            //Unsupported feature: Change Description on "SendApprovalRequest(Action 190)". Please convert manually.


            //Unsupported feature: Change Visible on "SendApprovalRequest(Action 190)". Please convert manually.

        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Re&quest', FRA = 'Annuler demande d''appro&bation';
            ToolTipML = ENU = 'Cancel the approval request.', FRA = 'Annulez la demande d''approbation.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(CalculateInvoiceDiscount)
        {
            CaptionML = ENU = 'Calculate &Invoice Discount', FRA = 'C&alculer remise facture';
            ToolTipML = ENU = 'Calculate the invoice discount that applies to the sales quote.', FRA = 'Calculez la remise facture qui s''applique au devis.';
        }
        modify("Archive Document")
        {
            CaptionML = ENU = 'Archi&ve Document', FRA = 'Archi&ver document';
        }
        modify(IncomingDocument)
        {
            CaptionML = ENU = 'Incoming Document', FRA = 'Document entrant';
        }
        modify(IncomingDocCard)
        {
            CaptionML = ENU = 'View Incoming Document', FRA = 'Afficher le document entrant';
        }
        modify(SelectIncomingDoc)
        {
            CaptionML = ENU = 'Select Incoming Document', FRA = 'Sélectionner le document entrant';
        }
        modify(IncomingDocAttachFile)
        {
            CaptionML = ENU = 'Create Incoming Document from File', FRA = 'Créer un document entrant à partir d''un fichier';
        }
        modify(RemoveIncomingDoc)
        {
            CaptionML = ENU = 'Remove Incoming Document', FRA = 'Supprimer le document entrant';
        }

    }
    //BC Upgrade GUNREM01 >> Added
    trigger OnOpenPage()
    begin
        MakeInvoiceVisisble := false; //HEI.01
    end;
    //BC Upgrade GUNREM01 << Added


    //Unsupported feature: PropertyModification on "EmptyShipToCodeErr(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //EmptyShipToCodeErr : ENU=The Code field can only be empty if you select Custom Address in the Ship-to field.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //EmptyShipToCodeErr : ENU=The Code field can only be empty if you select Custom Address in the Ship-to field.;FRA=Le champ Code ne peut être vide que si vous sélectionnez Adresse personnalisée dans le champ Destinataire.;
    //Variable type has not been exported.

    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        //HEI.01<<
        IF DocSubtypeCodeSetup.GET THEN
            Rec.VALIDATE("Document Subtype Code FND", DocSubtypeCodeSetup."Order Generated from Quote");
        //HEI.01>>

    end;

    var

        MakeInvoiceVisisble: boolean;
        StdCustSalesCode: Record "Standard Customer Sales Code";
        SalesSetup: Record "Sales & Receivables Setup";
        VisibleSendApproval: Boolean;
        DocSubtypeCodeSetup: Record "Doc Subtype Code Setup FND"; //BC Upgrade SHUKLP03 <<



    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ActivateFields;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);
    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    UpdatePaymentService;
    SetControlAppearance;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
    SETFILTER("Resp. Center Table Filter",
      UserMgt.GetRespCenterFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",
      UserMgt.GetRespPhysLocationFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",
      UserMgt.GetRespLocationFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 DDR DIT-770 #1190

    #1..6
    */
    //end;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Responsibility Center" := UserMgt.GetSalesFilter;
    if (not DocNoVisible) and ("No." = '') then
      SetSellToCustomerFromFilter;

    SetDefaultPaymentServices;
    SetControlAppearance;
    UpdateShipToBillToGroupVisibility;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7

    //HEI.01<<
    if DocSubtypeCodeSetup.GET then
      VALIDATE("Document Subtype Code",DocSubtypeCodeSetup."Order Generated from Quote");
    //HEI.01>>
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if UserMgt.GetSalesFilter <> '' then begin
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
      FILTERGROUP(0);
    end;

    ActivateFields;

    SetDocNoVisible;
    IsOfficeAddin := OfficeMgt.IsAvailable;
    SetControlAppearance;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //<<DITW111.00.13A DDR 01/07/2019 NRQ#103938
    SalesSetup.GET;
    //>>DITW111.00.13A DDR 01/07/2019 NRQ#103938
    // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1190
    //IF UserMgt.GetSalesFilter <> '' THEN BEGIN
    if UserMgt.GetSalesTextFilter <> '' then begin
      FILTERGROUP(2);
      //SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
      SETFILTER("Responsibility Center",UserMgt.GetSalesTextFilter);
      FILTERGROUP(0);
    end;
    // >>DITW18.00.06 DDR DIT-770 #1190
    #6..11

    //<<DITW111.00.13A DDR 01/07/2019 NRQ#103938
    VisibleSendApproval := not SalesSetup."Automatic Document Approval";
    //>>DITW111.00.13A DDR 01/07/2019 NRQ#103938
    MakeInvoiceVisible := false;  //HEI.01
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


}

