pageextension 51213 SalesInvoiceExtCBN extends "Sales Invoice"
{
    // version NAVW110.0.00.16585,FINXL10.00,DITW110.00.09,HEI.05
    //     DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 17/01/2008 some Captions
    //                                New calling functions to insert (item) charges
    // DITW15.00.00.01 DDR 21/01/2008 Remove unused textconst
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    // DITW15.00.00.25 DDR 16/10/2008 Added "Truck Code","Driver Code" into "Shipping" tab
    //                     21/10/2008 Deleted field2013722 Duty Tax Type
    //                                Added fields "Customer DTax Group Code" into Invoicing tab
    // DITW15.00.00.33 DDR 07/05/2009 Move field "Customer DTax Group Code" into 'General' tab
    // DITW15.00.00.34 DDR 17/06/2009 Added shortcut key CTRL+F10 to switch status 'open' the current document
    //                                Changed Editable "Status" field
    //                                Added functions DocStatusRelease(),DocStatusOpen(),
    // DITW15.00.00.36 DDR 07/12/2009 issue 981 Bugfix Save/Refresh before release function
    // DITW15.00.00.37 DDR 18/06/2010 issue 1028 Added Addtional credit limits and delayed discounts to calculate the available credit
    //                                           Added 'SalesOrderDate' parameter CalcAvailableCredit()
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 19/11/2010 issue 1139 SSCC Functionnalities
    //                                  Added menu 'SSCC Tracking Lines' in 'Line' buttton
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                           Added parameter line function RTCActionNewLine() into RTCNewLine button
    // DITW15.00.00.39 DDR 27/04/2011 issue 1322 NAVBE5.00 (SP1) functionnality to insert Customer Std. Sales Codes automatically
    //                                Added to call function StdCustSalesCode.AutoInsertSalesLines()
    //                                  from OnAfterValidate trigger field "Sell-to Customer No."
    // DITW15.00.00.39 DDR 10/05/2011 issue 1330 Upgrade editable Status to work with Approval requests
    //                                           Remove 'ShowConfirmMsg' parameter function DocStatusOpen();
    //                                           Modified functions DocStatusOpen(),DocStatusRelease()
    //                                           Modified validate trigger field "Status"
    //                     27/07/2011 issue 1407 Added flowfields "Disc.Promo. Order Calculated" (see "Zoom view)
    //                                           Moved/Deleted functions into codeunit414 Release Sales Document
    //                                             DocStatusRelease(),DocStatusOpen()
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                              Added to insert first line automatically
    //                     19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    // DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  call function SetDisableRefreshLines() before each report
    //                                                  (don't use the <RunObject> property)
    // DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added 'Service/Contract' tab
    //                                             Added fields into 'Service/Contract' tab
    //                                               "DIT Sub-Contract Type","Contract Group Code","Service Contract No."
    //                                             Moved "Building No." into 'Service/Contract' tab

    // FINXL7.00.001 RBE 20/03/2013 : Added field "Your Reference","Posting Description" on page
    //                                Moved "Currency Code" to the first group
    //                                "Jnl Template Selection" when opening form
    // FINXL7.00.001 KLU 25/09/2013 : Added actions for approve/reject (same functionality as approval entries form)

    // DITW17.00.02 SR 09/09/2013 DIT-770 #135 : Add field "Payment Amount" (group 'Invoicing')
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 AT  05/02/2014 DIT-770 #340 : Added Field "Customer Posting Group"
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added fields "Physical Location Group Code"
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1190 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    // DITW17.10.05 WSA 07/08/14 DIT-770 #761 : Added field "Invoice List Customer No."
    // DITW17.10.05 DDR 07/10/2014 DIT-770 #935 Editable "Building No."
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 look & feel design/functional issues: part 1: ribbons
    // DITW18.00.06 MSF 09/07/2015 DIT-770 1421 Make Field Status Not editable in page 43 , 44 and 6630 like Std
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type
    // DITW18.00.07 AKH 30/03/2016 DIT-770 #1409 Made check on "External Doc. No. Mandatory" depending on the Customer setup
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field "Document Subtype Code" under "Invoicing" tab
    // DITW18.00.07 AKH 13/05/2016 DIT-770 #1409 Restored standard code for check on "External Document No."
    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time","Created By" Importance Additional
    // DITW18.00.07 VSC 01/07/2016 DIT-770 #1282 Set fields to visible "Creation Date/Time","Created By"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL9.00.000.01 ACH 05/01/2016 : Added factbox to show mandatory Dimensions for G/L account
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // HEI.01 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    //   # Code added on Post Action

    // HEI.02 FDD-OTCGAP051 IBM PATHAA02 18.01.18>>
    //   # Code added on OnOpenPage, OnNewRecord, OnInsertRecord
    // HEI.03 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New Field added: "Suppress POS Interface"
    //   # Code added to enable editing of Field "Supress POS Interface"
    // DITW111.00.13A DDR 01/07/2019 NRQ#103938 Added visibility for Action Send Approval
    // HEI.04 FDD-HT634 IBM GAVANM01 27.08.2019 # New field added in Foreign Trade tab - "Country of Origin"
    // HEI.05 CHG2165967 DEBUSD01 26.10.2022 HL block tax and VAT modification in sales order
    //   # change editable field "Customer DTax Group Code", "VAT Bus. Posting Group"

    // BC Upgrade SHUKLP03 >>

    // Moved in the interface >>
    // HEI.03 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New Field added: "Suppress POS Interface"
    //   # Code added to enable editing of Field "Supress POS Interface"
    // Moved in the interface <<
    // HEI.02 => Document Subtype related Code is added. 
    // Document Subtype field is added.
    //DIT fields and code is not added.
    // BC Upgrade SHUKLP03 <<

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
        modify("Sell-to Customer Name")
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
            ToolTipML = ENU = 'Specifies the name of the customer who will receive the products and be billed by default.', FRA = 'Spécifie le nom du client qui recevra les produits et sera facturé par défaut.';
        }
        modify("Sell-to")
        {
            CaptionML = ENU = 'Sell-to', FRA = 'Donneur d''ordre';
        }
        modify("Sell-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address where the customer is located.', FRA = 'Spécifie l''adresse où se trouve le client.';

            //Unsupported feature: Change ImplicitType on ""Sell-to Address"(Control 75)". Please convert manually.

        }
        modify("Sell-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Sell-to Address 2"(Control 77)". Please convert manually.

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

            //Unsupported feature: Change ImplicitType on ""Sell-to City"(Control 79)". Please convert manually.

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

        //Unsupported feature: Change ImplicitType on ""Your Reference"(Control 19)". Please convert manually.

        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on which you created the sales document.', FRA = 'Spécifie la date à laquelle vous avez créé le document vente.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date when the posting of the sales document will be recorded.', FRA = 'Spécifie la date à laquelle la validation du document vente sera validée.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies when the sales invoice must be paid.', FRA = 'Spécifie la date à laquelle la facture vente doit être payée.';
        }
        modify("Incoming Document Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the incoming document that this sales document is created for.', FRA = 'Spécifie le numéro du document entrant pour lequel ce document vente est créé.';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies the number that the customer uses in their own system to refer to this sales document.', FRA = 'Spécifie le numéro que le client doit utiliser dans son propre système pour faire référence à ce document vente.';
        }
        modify("Salesperson Code")
        {
            ToolTipML = ENU = 'Specifies the name of the salesperson who is assigned to the customer.', FRA = 'Spécifie le nom du vendeur affecté au client.';
        }
        modify("Campaign No.")
        {
            ToolTipML = ENU = 'Specifies the number of the campaign that the document is linked to.', FRA = 'Spécifie le numéro de campagne auquel le document est lié.';
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

            //Unsupported feature: Change Description on "Status(Control 112)". Please convert manually.

        }
        modify("Job Queue Status")
        {
            ToolTipML = ENU = 'Specifies the status of a job queue entry or task that handles the posting of sales orders.', FRA = 'Spécifie le statut d''une écriture file d''attente des travaux ou d''une tâche qui gère la validation des commandes vente.';
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
        modify("Quote No.")
        {
            ToolTipML = ENU = 'Specifies the number of the sales quote that the sales order was created from. You can track the number to sales quote documents that you have printed, saved, or emailed.', FRA = 'Spécifie le numéro du devis à partir duquel la commande vente a été créée. Vous pouvez suivre le numéro des documents devis que vous avez imprimés, enregistrés ou envoyés par e-mail.';
        }
        modify("Prices Including VAT")
        {
            ToolTipML = ENU = 'Specifies whether the unit price on the line should be displayed including or excluding VAT.', FRA = 'Spécifie si le prix unitaire de la ligne doit être affiché TTC ou hors taxes.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the customer''s VAT specification to link transactions made for this customer to.', FRA = 'Spécifie le détail TVA du client auquel associer des transactions faites pour ce client.';
            Editable = false; // BC Upgrade SHUKLP03 <<
            //Unsupported feature: Change Editable on ""VAT Bus. Posting Group"(Control 156)". Please convert manually.

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
            ToolTipML = ENU = 'Specifies the type of transaction that the sales document represents, for the purpose of reporting to INTRASTAT.', FRA = 'Spécifie le type de transaction que représente le document vente, à des fins de compte rendu à INTRASTAT.';
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
            ToolTipML = ENU = 'Specifies the payment discount percentage granted if the customer pays on or before the date entered in the Pmt. Discount Date field.', FRA = 'Spécifie le pourcentage escompte accordé si le client paie au plus tard à la date saisie dans le champ Date d''escompte.';
        }
        modify("Pmt. Discount Date")
        {
            ToolTipML = ENU = 'Specifies the last date the customer can pay the invoice and still receive a payment discount.', FRA = 'Indique la dernière date à laquelle le client facturé peut payer et obtenir un escompte.';
        }
        modify("Direct Debit Mandate ID")
        {
            ToolTipML = ENU = 'Specifies the direct-debit mandate that the customer has signed to allow direct debit collection of payments.', FRA = 'Spécifie le mandat de prélèvement que le client a signé pour autoriser un prélèvement automatique des paiements.';
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
            ToolTipML = ENU = 'Specifies the address that products on the sales document will be shipped to.', FRA = 'Spécifie l''adresse à laquelle les produits mentionnés sur le document vente seront expédiés.';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 38)". Please convert manually.

        }
        modify("Ship-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 40)". Please convert manually.

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

            //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 42)". Please convert manually.

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
            ToolTipML = ENU = 'Specifies which shipping agent service is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
        }
        modify("Package Tracking No.")
        {
            ToolTipML = ENU = 'Specifies the shipping agent''s package number.', FRA = 'Spécifie le numéro récépissé du transporteur.';
        }
        modify(BillToOptions)
        {
            CaptionML = ENU = 'Bill-to', FRA = 'Facturation';
            ToolTipML = ENU = 'Specifies the customer that the sales invoice will be sent to. Default (Customer): The same as the customer on the sales invoice. Another Customer: Any customer that you specify in the fields below.', FRA = 'Spécifie le client auquel la facture vente sera envoyée. Par défaut (Client) : identique au client figurant sur la facture vente. Autre client : tout client que vous spécifiez dans les champs ci-dessous.';
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

            //Unsupported feature: Change ImplicitType on ""Bill-to Address"(Control 18)". Please convert manually.

        }
        modify("Bill-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Bill-to Address 2"(Control 20)". Please convert manually.

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

            //Unsupported feature: Change ImplicitType on ""Bill-to City"(Control 22)". Please convert manually.

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

        //Unsupported feature: CodeModification on ""Sell-to Customer Name"(Control 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." then
          if "Sell-to Customer No." <> xRec."Sell-to Customer No." then
            SETRANGE("Sell-to Customer No.");

        if ApplicationAreaSetup.IsFoundationEnabled then
          SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0,Rec);

        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..8

        // <<DITW15.00.00.39 DDR 27/04/2011 #1322 (BE5.00.01)
        COMMIT;
        StdCustSalesCode.AutoInsertSalesLines(Rec);
        // >>DITW15.00.00.39 DDR #1322 (BE5.00.01)
        */
        //end;


        //Unsupported feature: CodeInsertion on "Status(Control 112)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        StatusOnValidate;
          StatusOnAfterValidate;
        */
        //end;
        moveafter("Your Reference"; "Posting Description")

        // BC Upgrade SHUKLP03 >> Blocked DIT fields.
        // addafter("Document Date")
        // {
        //     field("Tax Date";Rec."Tax Date")
        //     {
        //     }
        //     field("Building No.";Rec."Building No.")
        //     {
        //         Editable = false;
        //     }
        // }

        // BC Upgrade SHUKLP03 >> Blocked DIT fields.
        addafter(Status)
        {
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Created Date/Time';
                Editable = false;
            }
            field(SystemCreatedBy; Rec.SystemCreatedBy)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Created By';
                Editable = false;
            }
        }
        // BC Upgrade SHUKLP03 << Blocked DIT fields.

        // BC Upgrade SHUKLP03 >> Moved in the interface ext.
        // addafter("Job Queue Status")
        // {
        //     field("Suppress POS Interface"; Rec."Suppress POS Interface")
        //     {
        //         Description = 'HEI.03';
        //         Editable = SuppressPOSInterfaceEditable;
        //         ApplicationArea = All;
        //     }
        // }
        // BC Upgrade SHUKLP03 << Moved in the interface ext.

        moveafter("VAT Bus. Posting Group"; "Customer Posting Group")
        addafter("VAT Bus. Posting Group")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
            {
                ApplicationArea = All;
            }

            // BC Upgrade SHUKLP03 >> Blocked DIT fields.
            // field("Invoice List Customer No."; Rec."Invoice List Customer No.")
            // {
            //     Description = 'DITW17.10.05 DIT-715 #761';
            // }
            // field("Document Subtype Code"; Rec."Document Subtype Code")
            // {
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT fields.

            // BC Upgrade SHUKLP03 << Added fields.
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                ApplicationArea = all;
            }


        }

        // BC Upgrade SHUKLP03 >> Blocked DIT fields.
        // addafter("Direct Debit Mandate ID")
        // {
        //     field("Payment Amount"; Rec."Payment Amount")
        //     {
        //     }
        //     field("Physical Location Group Code"; Rec."Physical Location Group Code")
        //     {
        //         Importance = Additional;
        //         QuickEntry = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        //             if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
        //                 CurrPage.UPDATE(true);
        //             // >>DITW18.00.06 DDR DIT-770 #1190
        //         end;
        //     }
        // }
        // addafter("Location Code")
        // {
        //     field("Customer DTax Group Code"; "Customer DTax Group Code")
        //     {
        //         Editable = false;
        //     }
        // }
        // addafter(Control34)
        // {
        //     field("Truck Code"; Rec."Truck Code")
        //     {
        //     }
        //     field("Driver Code"; Rec."Driver Code")
        //     {
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT fields.

        addafter("Area")
        {
            field("Country of Origin"; Rec."Country of Origin FND")
            {
                ApplicationArea = All;
            }
            // BC Upgrade SHUKLP03 >> Blocked DIT fields.
            // group("Service/Contract")
            // {
            //     CaptionML = ENU = 'Service/Contract',
            //                 FRA = 'Service/ Contrat';
            //     field("Contract Type"; Rec."Contract Type")
            //     {
            //         Editable = false;
            //     }
            //     field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
            //     {
            //     }
            //     field("Financial Contract No."; Rec."Financial Contract No.")
            //     {
            //     }
            //     field("Service Contract No."; Rec."Service Contract No.")
            //     {
            //     }
            //     field("Contract Group Code"; Rec."Contract Group Code")
            //     {
            //     }
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT fields.

        }
    }
    actions
    {
        modify("&Invoice")
        {
            CaptionML = ENU = '&Invoice', FRA = 'Fa&cture';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify("Function_CustomerCard")
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
            ToolTipML = ENU = 'View or edit detailed information about the customer.', FRA = 'Affichez ou modifiez des informations détaillées sur le client.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
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
        modify(Release)
        {
            CaptionML = ENU = 'Re&lease', FRA = '&Lancer';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(CreatePurchaseInvoice)
        {
            CaptionML = ENU = 'Create Purchase Invoice', FRA = 'Créer une facture achat';
            ToolTipML = ENU = 'Create a new purchase invoice so you can buy items from a vendor.', FRA = 'Créez une facture achat de manière à pouvoir acheter des articles à un fournisseur.';
        }
        modify(GetRecurringSalesLines)
        {
            CaptionML = ENU = 'Get Recurring Sales Lines', FRA = 'Extraire les lignes vente récurrentes';
            ToolTipML = ENU = 'Insert sales document lines that you have set up for the customer as recurring. Recurring sales lines could be for a monthly replenishment order or a fixed freight expense.', FRA = 'Insérez les lignes document vente que vous avez paramétrées comme récurrentes pour le client. Les lignes vente récurrentes peuvent représenter un ordre de réapprovisionnement mensuel ou une dépense de fret fixe.';
        }
        modify(CalculateInvoiceDiscount)
        {
            CaptionML = ENU = 'Calculate &Invoice Discount', FRA = 'C&alculer remise facture';
            ToolTipML = ENU = 'Calculate the invoice discount for the entire sales document when all sales invoice lines are entered.', FRA = 'Calculez la remise facture pour l''intégralité du document vente lorsque toutes les lignes facture vente sont saisies.';
        }
        modify(CopyDocument)
        {
            CaptionML = ENU = 'Copy Document', FRA = 'Copier document';
            ToolTipML = ENU = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.', FRA = 'Copiez les lignes document et les informations d''en-tête d''un autre document vente vers celui-ci. Vous pouvez copier une facture vente validée dans une nouvelle facture vente pour créer rapidement un document similaire.';
        }
        modify("Move Negative Lines")
        {
            CaptionML = ENU = 'Move Negative Lines', FRA = 'Déplacer lignes négatives';
        }
        modify("Incoming Document")
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
        modify("Request Approval")
        {
            CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';

            //Unsupported feature: Change Description on ""Request Approval"(Action 49)". Please convert manually.


            //Unsupported feature: Change Image on ""Request Approval"(Action 49)". Please convert manually.

        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send A&pproval Request', FRA = 'Envoyer demande d''a&pprobation';
            ToolTipML = ENU = 'Send an approval request.', FRA = 'Envoyez une demande d''approbation.';

            //Unsupported feature: Change Description on "SendApprovalRequest(Action 159)". Please convert manually.


            //Unsupported feature: Change Visible on "SendApprovalRequest(Action 159)". Please convert manually.

        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Re&quest', FRA = 'Annuler demande d''appro&bation';
            ToolTipML = ENU = 'Cancel the approval request.', FRA = 'Annulez la demande d''approbation.';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify(PostAndNew)
        {
            CaptionML = ENU = 'Post and New', FRA = 'Valider et Créer';
        }
        modify(PostAndSend)
        {
            CaptionML = ENU = 'Post and &Send', FRA = 'Valider et en&voyer';
            ToolTipML = ENU = 'Finalize and prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.', FRA = 'Finalisez et préparez-vous à envoyer le document en fonction du profil d''envoi du client, par exemple en pièce jointe d''un e-mail. La fenêtre Envoyer le document à s''ouvre en premier pour que vous puissiez confirmer ou sélectionner un profil d''envoi.';
        }
        modify(Preview)
        {
            CaptionML = ENU = 'Preview Posting', FRA = 'Aperçu compta.';
            ToolTipML = ENU = 'View the sales invoice lines before you perform the actual posting.', FRA = 'Affichez les lignes facture vente avant de procéder à la validation effective.';
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
        }
        modify("Remove From Job Queue")
        {
            CaptionML = ENU = 'Remove From Job Queue', FRA = 'Supprimer de la file d''attente des travaux';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';

            trigger OnAfterAction()
            var
            begin
                Rec.InsertFAGLJnlLinesForRPMDamageLoss(Rec); //HEI.01  // BC Upgrade SHUKLP03 <<

            end;
        }


        //Unsupported feature: CodeModification on "Release(Action 123).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleaseSalesDoc.PerformManualRelease(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.36 DDR 07/12/2009
        CurrPage.UPDATE(true);
        // >>DITW15.00.00.36 DDR
        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
        //ReleaseSalesDoc.PerformManualRelease(Rec);
        ReleaseSalesDoc.DocStatusRelease(xRec,Rec);
        CurrPage.UPDATE;
        // >>DITW15.00.00.39 DDR #1330 #1407
        */
        //end;


        //Unsupported feature: CodeModification on "Reopen(Action 124).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleaseSalesDoc.PerformManualReopen(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
        //ReleaseSalesDoc.PerformManualReopen(Rec);
        ReleaseSalesDoc.DocStatusOpen(xRec,Rec);
        CurrPage.UPDATE;
        // >>DITW15.00.00.39 DDR #1330 #1407
        */
        //end;


        //Unsupported feature: CodeModification on "Post(Action 71).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Post(CODEUNIT::"Sales-Post (Yes/No)",NavigateAfterPost::"Posted Document");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Post(CODEUNIT::"Sales-Post (Yes/No)",NavigateAfterPost::"Posted Document");
        InsertFAGLJnlLinesForRPMDamageLoss(Rec); //HEI.01
        */
        //end;
    }

    var
    //UserSetup2: Record "User Setup"; // BC Upgrade SHUKLP03 << Moved in the interface.


    //Unsupported feature: PropertyModification on "OpenPostedSalesInvQst(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OpenPostedSalesInvQst : ENU=The invoice has been posted and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OpenPostedSalesInvQst : ENU=The invoice has been posted and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?;FRA=La facture a été validée et déplacée dans la fenêtre Factures vente enregistrées.\\Souhaitez-vous ouvrir la facture enregistrée ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "EmptyShipToCodeErr(Variable 1052)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //EmptyShipToCodeErr : ENU=The Code field can only be empty if you select Custom Address in the Ship-to field.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //EmptyShipToCodeErr : ENU=The Code field can only be empty if you select Custom Address in the Ship-to field.;FRA=Le champ Code ne peut être vide que si vous sélectionnez Adresse personnalisée dans le champ Destinataire.;
    //Variable type has not been exported.

    var
        Text2014411: TextConst ENU = 'Do you want to cancel the approval request for %1 %2?', FRA = 'Souhaitez vous annuler la demande d''approbation du/de la %1 %2?';
        StdCustSalesCode: Record "Standard Customer Sales Code";
        Text2014412: TextConst ENU = 'Do you want to send the approval request for %1 %2?', FRA = 'Souhaitez vous envoyer la demande d''approbation du/de la %1 %2?';
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        SalesHistoryBtnVisible: Boolean;
        BillToCommentPictVisible: Boolean;
        BillToCommentBtnVisible: Boolean;
        SalesHistoryStnVisible: Boolean;
        recSalesSetup: Record "Sales & Receivables Setup";
        recGenJournalTemplate: Record "Gen. Journal Template";
        txtTemplateName: Text;
        blnJnlSelected: Boolean;
        //cduSingleInstaceFunctions : Codeunit "Single Instance Functions"; // BC Upgrade SHUKLP03 << Blocked DIT variable.
        //recFinXLSetup : Record "Finance XL Setup"; // BC Upgrade SHUKLP03 << Blocked DIT variable.
        IsSaaS: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        SalesSetup: Record "Sales & Receivables Setup";
        DocSubtypeCode: Code[10];
        docsubtypecodesetup: Record "Doc Subtype Code Setup FND"; // BC Upgrade SHUKLP03 << Blocked DIT variable.
        CustTradingEndDate: Label 'The Posting Date exceeds the Trading End Date defined in Customer %1';
        CustForAccGr: Record Customer;
        //SuppressPOSInterfaceEditable: Boolean;  // BC Upgrade SHUKLP03 << Moved in the interface.
        VisibleSendApproval: Boolean;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);
    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);

    UpdatePaymentService;
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
    // <<DITW15.00.00.39 DDR 27/07/2011 #1407
    CALCFIELDS("Disc.Promo. Order Calculated");
    // >>DITW15.00.00.34 DDR

    #1..5
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger (Variable: UserSetup2)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetControlAppearance;
    WorkDescription := GetWorkDescription;
    UpdateShipToBillToGroupVisibility
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetControlAppearance;
    WorkDescription := GetWorkDescription;
    UpdateShipToBillToGroupVisibility;

    //HEI.03>>
    UserSetup2.GET(USERID);
    SuppressPOSInterfaceEditable := UserSetup2."Allow Change Interface Flag";
    //HEI.03<<
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnClosePage". Please convert manually.

    //trigger OnClosePage();
    //begin
    /*
    //<<FINXL7.00.001 RBE 20/03/2013
    if recFinXLSetup.READPERMISSION then
      if recSalesSetup."Show Jnl. Template Selection" then
        cduSingleInstaceFunctions.fctTrackSalesInvoicePage(true,txtTemplateName);
    //>>FINXL7.00.001 RBE 20/03/2013
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsertRecord". Please convert manually.

    //trigger OnInsertRecord(BelowxRec : Boolean) : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if DocNoVisible then
      CheckCreditMaxBeforeInsert;

    if ("Sell-to Customer No." = '') and (GETFILTER("Sell-to Customer No.") <> '') then
      CurrPage.UPDATE(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5

    //HEI.02 FDD-OTCGAP051 IBM PATHAA02 18.01.18>>
    docsubtypecodesetup.GET;
    VALIDATE("Document Subtype Code",DocSubtypeCode);
    //HEI.02 FDD-OTCGAP051 IBM PATHAA02 18.01.18<<
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
    UpdateShipToBillToGroupVisibility;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6


    //HEI.02 FDD-OTCGAP051 IBM PATHAA02 18.01.18>>
    docsubtypecodesetup.GET;
    VALIDATE("Document Subtype Code",DocSubtypeCode);
    //HEI.02 FDD-OTCGAP051 IBM PATHAA02 18.01.18<<
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

    SetDocNoVisible;

    #9..11
    if "No." = '' then
      if OfficeMgt.CheckForExistingInvoice("Sell-to Customer No.") then
        ERROR(''); // Cancel invoice creation
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //<<FINXL7.00.001 RBE 20/03/2013
    if recFinXLSetup.READPERMISSION then begin
      recSalesSetup.GET;
      txtTemplateName := '';
      if cduSingleInstaceFunctions.fctGetSalesInvoicePages > 0 then begin
        txtTemplateName := cduSingleInstaceFunctions.fctGetSalesInvoiceTemplate;
        cduSingleInstaceFunctions.fctTrackSalesInvoicePage(false,txtTemplateName);
      end
      else
        if recSalesSetup."Show Jnl. Template Selection" then begin
          recGenJournalTemplate.RESET;
          recGenJournalTemplate.SETRANGE(Type,recGenJournalTemplate.Type::Sales);
          recGenJournalTemplate.SETRANGE("Credit Memo",false);

          if recGenJournalTemplate.COUNT > 1 then begin
            blnJnlSelected := PAGE.RUNMODAL(0,recGenJournalTemplate) = ACTION::LookupOK;

            if not blnJnlSelected then
              ERROR('');
          end else
            recGenJournalTemplate.FINDFIRST;

          txtTemplateName := recGenJournalTemplate.Name;

          cduSingleInstaceFunctions.fctTrackSalesInvoicePage(false,txtTemplateName);
        end;
    end;
    //>>FINXL7.00.001 RBE 20/03/2013

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
    #6..14

    //HEI.02 FDD-OTCGAP051 IBM PATHAA02 18.01.18>>
    DocSubtypeCode := "Document Subtype Code";
    //HEI.02 FDD-OTCGAP051 IBM PATHAA02 18.01.18<<
    //<<DITW111.00.13A DDR 01/07/2019 NRQ#103938
    VisibleSendApproval := not SalesSetup."Automatic Document Approval";
    //>>DITW111.00.13A DDR 01/07/2019 NRQ#103938
    */
    //end;

    procedure Customer();
    begin
    end;


    //Unsupported feature: CodeModification on "SetExtDocNoMandatoryCondition(PROCEDURE 2)". Please convert manually.

    //procedure SetExtDocNoMandatoryCondition();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesReceivablesSetup.GET;
    ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory"
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //<< DITW18.00.07 AKH 30/03/2016 - 13/05/2016 DIT-770 #1409
    SalesReceivablesSetup.GET;
    ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory";
    if Customer.GET("Sell-to Customer No.") then
      ExternalDocNoMandatory := Customer.ShowExtDocPostingWarning();
    //>> DITW18.00.07 AKH DIT-770 #1409
    */
    //end;

    // BC Upgrade SHUKLP03 >> Blocked DIT Procedure.
    // local procedure StatusOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.34 DDR 17/06/2009
    //     CurrPage.UPDATE(false);
    // end;
    // BC Upgrade SHUKLP03 << Blocked DIT Procedure.

    // BC Upgrade SHUKLP03 >> Added Document subtype code.
    trigger OnOpenPage()
    var
    begin
        //HEI.02 FDD-OTCGAP051 IBM PATHAA02 18.01.18>>
        DocSubtypeCode := Rec."Document Subtype Code FND";
        //HEI.02 FDD-OTCGAP051 IBM PATHAA02 18.01.18<<
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        //HEI.02 FDD-OTCGAP051 IBM PATHAA02 18.01.18>>
        docsubtypecodesetup.GET();
        Rec.VALIDATE("Document Subtype Code FND", DocSubtypeCode);
        //HEI.02 FDD-OTCGAP051 IBM PATHAA02 18.01.18<<
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //HEI.02 FDD-OTCGAP051 IBM PATHAA02 18.01.18>>
        docsubtypecodesetup.GET();
        Rec.VALIDATE("Document Subtype Code FND", DocSubtypeCode);
        //HEI.02 FDD-OTCGAP051 IBM PATHAA02 18.01.18<<
    end;

    // BC Upgrade SHUKLP03 << Added Document subtype code.

    local procedure StatusOnValidate();
    begin
        // BC Upgrade SHUKLP03 >> Blocked DIT code.
        // // <<DITW15.00.00.34 DDR 17/06/2009
        // if xRec.Status = Rec.Status then
        //     exit;

        // // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
        // if (xRec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Released) then
        //     ReleaseSalesDoc.DocStatusRelease(xRec, Rec)
        // else begin
        //     if Rec.Status = Rec.Status::Open then
        //         ReleaseSalesDoc.DocStatusOpen(xRec, Rec)
        //     else
        //         // >>DITW15.00.00.39 DDR #1330 #1407
        // BC Upgrade SHUKLP03 << Blocked DIT code.

        Rec.TESTFIELD(Status, xRec.Status);
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

