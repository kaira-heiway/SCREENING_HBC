pageextension 51203 PurchaseCreditMemoExtCBN extends "Purchase Credit Memo"
{
    // version NAVW110.0.00.16585,FINXL10.01,DITW110.00.09,HEI.01

    //     DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 17/01/2008 some Captions
    //                                New calling functions to insert (item) charges
    // DITW15.00.00.01 DDR 21/01/2008 Remove unused textconst
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    // DITW15.00.00.25 DDR 16/10/2008 Added "Truck Code","Driver Code" into "Shipping" tab
    // DITW15.00.00.25 DDR 21/10/2008 Deleted field2013722 Duty Tax Type
    //                                Added fields "Vendor DTax Group Code" into Invoicing tab
    // DITW15.00.00.33 DDR 07/05/2009 Move field "Customer DTax Group Code" into 'General' tab
    // DITW15.00.00.34 DDR 17/06/2009 Added shortcut key CTRL+F10 to switch status 'open' the current document
    //                                Changed Editable "Status" field
    //                                Added functions DocStatusRelease(),DocStatusOpen(),
    // DITW15.00.00.36 DDR 07/12/2009 issue 981 Bugfix Save/Refresh before release function
    // DITW15.00.00.39 DDR 27/04/2011 issue 1323 NAVBE5.00 (SP1) functionnality to insert Customer Std. Sales Codes automatically
    //                                Added to call function StdVendPurchCode.AutoInsertPurchLines()
    //                                  from OnAfterValidate trigger field "Sell-to Customer No."
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                           Added parameter line function RTCActionNewLine() into RTCNewLine button
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
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added menu 'SSCC Tracking Lines' in 'Line' buttton
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added in General Tab
    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 AT  05/02/2014 DIT-770 #340 : Added Field "Vendor Posting Group"
    //                                          : Added code on Drill Down of "Applies-to Doc. No."
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Physical Location Group Code"
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1191 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // FINXL7.00 RBE 20/03/2013 : Added field "Your Reference","Posting Description" on page
    // FINXL7.00 KLU 25/09/2013 : Added actions for approve/reject (same functionality as approval entries form)
    // FINXL7.00 KLU 03/10/2013 : Check for existing template name
    // FINXL8.00.001 RBE 01/12/2014: Hide factbox: "Purch. Inv./Cr.M. Info"

    // DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 look & feel design/functional issues: part 1: ribbons
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                           Added field 2014319  "Financial Contract No."
    //                                           Rename Caption Contract No. by Service contract No.
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Rename Option DIT Contract,Service Contract by Financial,Service
    //                                           Added blank Option to Contract Type
    // DITW19.00.07 MVN 25/01/2016 DIT-770 #1740 Upgrade
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field "Document Subtype Code" under "Invoicing" tab
    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time","Created By" Importance Additional
    // DITW18.00.07 VSC 01/07/2016 DIT-770 #1282 Set fields to visible "Creation Date/Time","Created By"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL9.00.000.01 ACH 05/01/2016 : Added factbox to show mandatory Dimensions for G/L account
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // FINXL10.01 MTR 16/08/2017 NRQ#30245: Removed old FINXL code related to "Show Totals on Purch. Inv/CM." setup

    // HEI.01 defect #2234 IBM POSTOI01 05.06.2018
    //   # add code OnOpenPage, new variable DocSubtypeEditable, change property Editable for field Document Subtype Code
    // HEI.02 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # Created new Page Action "Purchase Additional"
    // HEI.03 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"
    //   # Made Field "Vendor Posting Group" editable when "Enable FA Vendor Requirement" is TRUE
    //   # Code added on OnOpenPage trigger
    // Hei.04 FDD HT1136 CHG2055070 IBM Shankj03 16.06.2020
    //  # New Field Added License Code
    //  # Code added in triggers
    // HEI.06 HT1136 CHG2084917 IBM.GUNERE01 11.03.2020 # HEI.04 deleted from License Code LookUp and Drilldowns
    //Bc Upgrade YADAVM09 //HEI.01>> of onopen page not added due to dependency on drink it field.
    //Bc Upgrade YADAVM09 custom code on Actions [Post and Release] has moved onbeforeaction trigger.
    //BC UPGRADE ATHUKUS01 FDDSTP_007_GAP 14-16>> Fields Doc. Amount Incl. VAT and Doc. Amount VAT are not used in the page, so we hide them and add new fields with IBM suffix to show those amounts with the correct values. 

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the purchase document. The field is only visible if you have not set up a number series for the type of purchase document, or if the Manual Nos. field is selected for the number series.', FRA = 'Spécifie le numéro du document achat. Le champ n''est visible que si vous n''avez défini aucune souche de numéros pour ce type de document achat, ou si le champ N° manuels est sélectionné pour la souche de numéros.';
        }
        modify("Buy-from Vendor Name")
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
            ToolTipML = ENU = 'Specifies the name of the vendor who sends the items.', FRA = 'Spécifie le nom du fournisseur qui envoie les articles.';
        }
        modify("Buy-from")
        {
            CaptionML = ENU = 'Buy-from', FRA = 'Fournisseur';
        }
        modify("Buy-from Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address of the vendor who ships the items.', FRA = 'Spécifie l''adresse du fournisseur qui expédie les articles.';
        }
        modify("Buy-from Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Buy-from Address 2"(Control 65)". Please convert manually.

        }
        modify("Buy-from Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Buy-from City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city of the vendor who ships the items.', FRA = 'Spécifie la ville du fournisseur qui expédie les articles.';

            //Unsupported feature: Change ImplicitType on ""Buy-from City"(Control 67)". Please convert manually.

        }
        modify("Buy-from Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of your contact at the vendor.', FRA = 'Spécifie le numéro de votre contact au fournisseur.';
        }
        modify("Buy-from Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person to contact about shipment of the item from this vendor.', FRA = 'Spécifie le nom de la personne à contacter à propos de l''expédition de l''article chez le fournisseur.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date when the posting of the purchase document will be recorded.', FRA = 'Spécifie la date à laquelle la validation du document achat sera validée.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the vendor created the purchase document.', FRA = 'Spécifie la date à laquelle le vendeur a créé le document achat.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies when the invoice is due. The program calculates the date using the Payment Terms Code and Document Date fields.', FRA = 'Spécifie la date d''échéance de la facture. Le programme calcule la date à l''aide des champs Code condition paiement et Date document.';
        }
        modify("Expected Receipt Date")
        {
            ToolTipML = ENU = 'Specifies the date you expect to receive the items on the purchase document.', FRA = 'Spécifie la date à laquelle vous pensez recevoir les articles indiqués sur le document achat.';
        }
        modify("Vendor Authorization No.")
        {
            ToolTipML = ENU = 'Specifies the identification number of a compensation agreement.', FRA = 'Spécifie le numéro d''identification d''un accord de compensation.';
        }
        modify("Incoming Document Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the incoming document that this purchase document is created for.', FRA = 'Spécifie le numéro du document entrant pour lequel ce document achat est créé.';
        }
        modify("Vendor Cr. Memo No.")
        {
            ToolTipML = ENU = 'Specifies the number that the vendor uses for the credit memo you are creating in this purchase credit memo header.', FRA = 'Spécifie le numéro que le fournisseur utilise pour l''avoir que vous créez dans cet en-tête avoir achat.';
        }
        modify("Order Address Code")
        {
            ToolTipML = ENU = 'Specifies the order address code linked to the relevant vendor''s order address.', FRA = 'Spécifie le code adresse commande lié à l''adresse de commande du fournisseur concerné.';
        }
        modify("Purchaser Code")
        {
            ToolTipML = ENU = 'Specifies which purchaser is assigned to the vendor.', FRA = 'Spécifie l''acheteur affecté au fournisseur.';
        }
        modify("Campaign No.")
        {
            ToolTipML = ENU = 'Specifies the campaign number the document is linked to.', FRA = 'Spécifie le numéro de campagne auquel le document est lié.';
        }
        modify("Responsibility Center")
        {
            ToolTipML = ENU = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.', FRA = 'Spécifie le code du centre de gestion qui est associé à l''utilisateur, à la société ou au fournisseur.';
        }
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.', FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
        }
        modify("Job Queue Status")
        {
            ToolTipML = ENU = 'Specifies the status of a job queue entry that handles the posting of purchase orders.', FRA = 'Spécifie le statut d''une écriture file d''attente des travaux qui gère la validation des commandes achat.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies whether the record is open, is waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.', FRA = 'Spécifie si l''enregistrement est ouvert, est en attente d''approbation, a été facturé pour acompte ou a été lancé pour l''étape suivante du traitement.';

            //Unsupported feature: Change Editable on "Status(Control 101)". Please convert manually.

        }
        modify("Invoice Details")
        {
            CaptionML = ENU = 'Invoice Details', FRA = 'Détails facture';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code for amounts on the purchase lines.', FRA = 'Spécifie le code devise des montants des lignes achat.';
        }
        modify("Prices Including VAT")
        {
            ToolTipML = ENU = 'Specifies whether the unit price on the line should be displayed including or excluding VAT.', FRA = 'Spécifie si le prix unitaire de la ligne doit être affiché TTC ou hors taxes.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the vendor''s VAT specification to link transactions made for this vendor with the appropriate general ledger account according to the VAT posting setup.', FRA = 'Spécifie le détail TVA du fournisseur pour lier les transactions effectuées pour ce fournisseur au compte général approprié en fonction des paramètres de comptabilisation TVA.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.', FRA = 'Spécifie une formule qui calcule la date d''échéance du paiement, la date d''escompte et le montant de l''escompte sur le document achat.';
        }
        modify("Transaction Type")
        {
            ToolTipML = ENU = 'Specifies the number for the transaction type, for the purpose of reporting to Intrastat.', FRA = 'Spécifie le numéro du type de transaction, à des fins de compte rendu à Intrastat.';
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
            ToolTipML = ENU = 'Specifies the payment discount percent that will be given if you pay for the purchase on or before the date in the Pmt. Discount Date field.', FRA = 'Spécifie le pourcentage d''escompte accordé si vous payez votre achat au plus tard à la date indiquée dans le champ Date d''escompte.';
        }
        modify("Pmt. Discount Date")
        {
            ToolTipML = ENU = 'Specifies the last date on which you can pay the invoice and still receive a payment discount.', FRA = 'Spécifie la dernière date à laquelle vous pouvez régler la facture et bénéficier tout de même de l''escompte.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies a code for the location where you want the items to be placed when they are received.', FRA = 'Spécifie un code pour le magasin dans lequel vous souhaitez que les articles soient stockés lorsqu''ils sont réceptionnés.';
        }
        modify("Shipping and Payment")
        {
            CaptionML = ENU = 'Shipping and Payment', FRA = 'Expédition et paiement';
        }
        modify("Ship-to")
        {
            CaptionML = ENU = 'Ship-to', FRA = 'Destinataire';
        }
        modify("Ship-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the name of the company at the address to which you want the items in the purchase order to be shipped.', FRA = 'Spécifie le nom de la société située à l''adresse à laquelle vous voulez que les articles de la commande achat soient livrés.';
        }
        modify("Ship-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address that you want the items in the purchase order to be shipped to.', FRA = 'Spécifie l''adresse à laquelle vous voulez que les articles du bon de commande soient expédiés.';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 34)". Please convert manually.

        }
        modify("Ship-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 36)". Please convert manually.

        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Ship-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city the items in the purchase order will be shipped to.', FRA = 'Spécifie la ville vers laquelle les articles du bon de commande seront expédiés.';

            //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 38)". Please convert manually.

        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of a contact person for the address where the items in the purchase order should be shipped.', FRA = 'Spécifie le nom d''un contact pour l''adresse à laquelle les articles de la commande achat devraient être expédiés.';
        }
        modify("Pay-to")
        {
            CaptionML = ENU = 'Pay-to', FRA = 'Paiement';
        }
        modify("Pay-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the vendor who is sending the invoice.', FRA = 'Spécifie le fournisseur envoyant la facture.';
        }
        modify("Pay-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address of the vendor sending the invoice.', FRA = 'Spécifie l''adresse du fournisseur envoyant la facture.';

            //Unsupported feature: Change ImplicitType on ""Pay-to Address"(Control 24)". Please convert manually.

        }
        modify("Pay-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Pay-to Address 2"(Control 26)". Please convert manually.

        }
        modify("Pay-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Pay-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city of the vendor sending the invoice.', FRA = 'Spécifie la ville du fournisseur envoyant la facture.';

            //Unsupported feature: Change ImplicitType on ""Pay-to City"(Control 28)". Please convert manually.

        }
        modify("Pay-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of the contact who sends the invoice.', FRA = 'Spécifie le numéro du contact qui envoie la facture.';
        }
        modify("Pay-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person to contact about an invoice from this vendor.', FRA = 'Spécifie le nom de la personne à contacter au sujet d''une facture émise par ce fournisseur.';
        }
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        }
        modify("Transaction Specification")
        {
            ToolTipML = ENU = 'Specifies a code for the purchase header''s transaction specification here.', FRA = 'Spécifie un code pour le régime de l''en-tête achat ici.';
        }
        modify("Transport Method")
        {
            ToolTipML = ENU = 'Specifies the code for the transport method to be used with this purchase header.', FRA = 'Spécifie le code mode de transport à utiliser avec cet en-tête achat.';
        }
        modify("Entry Point")
        {
            ToolTipML = ENU = 'Specifies the code of the port of entry where the items pass into your country/region.', FRA = 'Spécifie le code du point d''entrée par lequel les articles ont pénétré dans votre pays/région.';
        }
        modify("Area")
        {
            ToolTipML = ENU = 'Specifies the code for the area of the vendor''s address.', FRA = 'Spécifie le code de la zone de l''adresse du fournisseur.';
        }
        modify(Application)
        {
            CaptionML = ENU = 'Application', FRA = 'Lettrage';
        }
        modify("Applies-to Doc. Type")
        {
            ToolTipML = ENU = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.', FRA = 'Spécifie le type du document validé avec lequel ce document ou cette ligne feuille sera lettré lorsque vous validez, par exemple pour enregistrer un paiement.';
        }
        modify("Applies-to Doc. No.")
        {
            ToolTipML = ENU = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.', FRA = 'Spécifie le numéro du document validé avec lequel ce document ou cette ligne feuille sera lettré lorsque vous validez, par exemple pour enregistrer un paiement.';
        }
        modify("Applies-to ID")
        {
            ToolTipML = ENU = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.', FRA = 'Spécifie l''ID de lettrage des écritures lorsque vous choisissez l''action Ecr. ouvertes.';
        }
        //Bc Upgrade YADAVM09>>
        modify("Vendor Posting Group")
        {
            Editable = VendorPostGroupEditable;
        }
        //Bc Upgrade YADAVM09<<

        //Unsupported feature: CodeModification on ""Buy-from Vendor Name"(Control 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "No." = '' then
          InitRecord;

        #4..8
          PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0,Rec);

        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11

        // <<DITW15.00.00.39 DDR 27/04/2011 #1323 (BE5.00.01)
        COMMIT;
        StdVendPurchCode.AutoInsertPurchLines(Rec);
        // >>DITW15.00.00.39 DDR #1323 (BE5.00.01)
        */
        //end;


        //Unsupported feature: CodeInsertion on "Status(Control 101)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        StatusOnValidate;
          StatusOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Applies-to Doc. No."(Control 137)". Please convert manually.

        //trigger OnDrillDown();
        //Parameters and return type have not been exported.
        // var
        //   VendLedgEntry : Record "Vendor Ledger Entry";
        //begin
        /*
        //<<DITW17.10.03 TEC1 05/02/2014 DIT-770 #340
        VendLedgEntry.SETCURRENTKEY("Document No.");
        VendLedgEntry.SETRANGE("Contract Type","Contract Type");
        VendLedgEntry.SETRANGE("DIT Sub-Contract Type","DIT Sub-Contract Type");
        //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        case "Contract Type" of
          "Contract Type"::Service :
            VendLedgEntry.SETRANGE("Service Contract No.","Service Contract No.");
          "Contract Type"::Financial :
            VendLedgEntry.SETRANGE("Financial Contract No.","Financial Contract No.");
        end;
        //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        VendLedgEntry.SETRANGE("Contract Group Code","Contract Group Code");
        VendLedgEntry.SETRANGE("Vendor Posting Group","Vendor Posting Group");
        PAGE.RUN(0,VendLedgEntry);
        //>>DITW17.10.03 TEC1 DIT-770 #340
        */
        //end;
        addafter("Buy-from Contact")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = all;//Bc Upgrade YADAVM09
                Description = 'FINXL7.00.001';
                ToolTip = 'Specifies the value of the Your Reference field.';
            }

        }
        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        addafter("Document Date")
        {
            field("Tax Date"; Rec."Tax Date")
            {
            }
        }
        addafter("Job Queue Status")
        {
            field("Vendor DTax Group Code"; Rec."Vendor DTax Group Code")
            {
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
        addafter(Status)
        {
            /* //Bc Upgrade YADAVM09 Drink it field commented>>
            field("Creation Date/Time"; Rec."Creation Date/Time")
            {
                Description = 'DITW18.00.07 DIT-770 #1282';
                Importance = Additional;
            }
            field("Created By"; Rec."Created By")
            {
                Description = 'DITW18.00.07 DIT-770 #1282';
                Importance = Additional;
            }
           
            field("Linked Customer No."; Rec."Linked Customer No.")
            {
                Importance = Additional;
            }
             */ //Bc Upgrade YADAVM09 Drink it field commented<<
            //BC UPGRADE ATHUKUS01 FDD_STP007_GAP 14-16>>
            // field("Doc. Amount Incl. VAT"; Rec."Doc. Amount Incl. VAT")
            // {
            //     Description = 'FINXL7.00.001';
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the value of the Doc. Amount Incl. VAT field.';
            //     //Bc Upgrade YADAVM09                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ToolTip = 'Specifies the value of the Doc. Amount Incl. VAT field.';

            // }
            // field("Doc. Amount VAT"; Rec."Doc. Amount VAT")
            // {
            //     Description = 'FINXL7.00.001';
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the value of the Doc. Amount VAT field.';
            //     //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the Doc. Amount VAT field.';

            // }

            field("Doc. Amount Incl. VAT IBM"; Rec."Doc. Amount Incl. VAT IBM FND")
            {
                Caption = 'Doc. Amount Incl. VAT';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Doc. Amount Incl. VAT field.';

            }
            field("Doc. Amount VAT IBM"; Rec."Doc. Amount VAT IBM FND")
            {
                Caption = 'Doc. Amount VAT';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Doc. Amount VAT field.';
            }
            //BC UPGRADE ATHUKUS01 FDD_STP007_GAP 14-16<<
            field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Fixed Asset Acquisition field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the Fixed Asset Acquisition field.';

            }

            field("License Code"; Rec."License Code FND")
            {
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the License Code field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the License Code field.';

            }
        }
        addafter("Prices Including VAT")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the WHT Business Posting Group field.';

            }
        }
        addafter("VAT Bus. Posting Group")
        {
            /* //Bc Upgrade YADAVM09 field already exists in base extension>>
            field("Vendor Posting Group"; Rec."Vendor Posting Group")
            {
                Editable = VendorPostGroupEditable;
            }
            */ //Bc Upgrade YADAVM09 field already exists in base extension<<

            // BC Upgrade VAMSIU01 - Document Subtype Code Field Added >>
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                ApplicationArea = All;
            }
            // BC Upgrade VAMSIU01 - Document Subtype Code Field Added <<
        }
        /* //Bc Upgrade YADAVM09 Drink it field commented>>
       addafter("Pmt. Discount Date")
       {
           field("Physical Location Group Code"; Rec."Physical Location Group Code")
           {
               Importance = Additional;
               QuickEntry = false;

               trigger OnValidate();
               begin
                   // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                   if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                       CurrPage.UPDATE(true);
                   // >>DITW18.00.06 DDR DIT-770 #1191
               end;
           }
       }

       addafter("Location Code")
       {
           field("Truck Code"; "Truck Code")
           {
           }
           field("Driver Code"; "Driver Code")
           {
           }
       }
       */ //Bc Upgrade YADAVM09 Drink it field commented<<
        addafter("Pay-to Contact")
        {
            field("Vendor Bank Account"; Rec."Vendor Bank Account FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Vendor Bank Account field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the Vendor Bank Account field.';

            }
        }
        modify(DocAmount)
        {
            Visible = false;

        }
        modify(DocAmountVAT)
        {
            Visible = false;
        }
        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        addafter(Application)
        {
            group("Service/Contract")
            {
                CaptionML = ENU = 'Service/Contract',
                            FRA = 'Service/ Contrat';
                field("Contract Type"; Rec."Contract Type")
                {
                    Editable = false;
                }
                field("DIT Sub-Contract Type"; "DIT Sub-Contract Type")
                {
                }
                field("Service Contract No."; "Service Contract No.")
                {
                }
                field("Financial Contract No."; "Financial Contract No.")
                {
                }
                field("Contract Group Code"; "Contract Group Code")
                {
                }
            }
        }
       
        addafter(ApprovalFactBox)
        {
            part("G/L Account Mandatory Dimensions"; "Dimensions FactBox")
            {
                CaptionML = ENU = 'G/L Account Mandatory Dimensions',
                            FRA = 'Dimensions obligatoires compte général';
                Description = 'FINXL9.00.000.01';
                Provider = "46";
                SubPageLink = "No." = FIELD("No.");
                SubPageView = WHERE("Table ID" = CONST(15),
                                    "Value Posting" = CONST("Code Mandatory"));
            }
        }
         
        addafter(Control1901138007)
        {
            part(Control1907232107; "Purchase Line FactBox2")
            {
                Provider = "46";
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = false;
            }
        }
        addafter(WorkflowStatus)
        {
            part(Control2029614; "Purch. Inv./Cr.M. Info")
            {
                Description = 'FINXL7.00.001';
                Provider = "46";
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = false;
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
    }
    actions
    {
        modify("&Credit Memo")
        {
            CaptionML = ENU = '&Credit Memo', FRA = 'Avoi&r';
        }
        modify(PurchaseStatistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify(Vendor)
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
            ToolTipML = ENU = 'View or edit detailed information about the vendor on the purchase document.', FRA = 'Affichez ou modifiez des informations détaillées concernant le fournisseur sur le document achat.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
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
            CaptionML = ENU = 'Re&lease', FRA = 'La&ncer';
            //Bc Upgrade YADAVM09>>
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //>> HEI.06
                GenLedSetRec.RESET();
                GenLedSetRec.GET();
                IF GenLedSetRec."License Dimension Code FND" <> '' THEN BEGIN
                    CLEAR(LicenseCodeValue);
                    PurchaseLine.RESET();
                    PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                    PurchaseLine.SETRANGE("Document No.", Rec."No.");
                    PurchaseLine.SETFILTER(Type, '%1|%2|%3|%4', PurchaseLine.Type::"Charge (Item)", PurchaseLine.Type::"Fixed Asset", PurchaseLine.Type::"G/L Account", PurchaseLine.Type::Item);
                    IF PurchaseLine.FINDFIRST() THEN BEGIN
                        DimSetEntryRec.RESET();
                        DimSetEntryRec.SETRANGE("Dimension Set ID", PurchaseLine."Dimension Set ID");
                        DimSetEntryRec.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                        IF DimSetEntryRec.FINDFIRST() THEN
                            LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
                    END;
                    CLEAR(LicenseCodeValue_1);
                    PurchLineRec.RESET();
                    PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
                    PurchLineRec.SETRANGE("Document No.", Rec."No.");
                    PurchLineRec.SETFILTER(Type, '<>%1', 0);
                    IF PurchLineRec.FINDFIRST() THEN BEGIN
                        REPEAT
                            DimSetEntryRec_1.RESET();
                            DimSetEntryRec_1.SETRANGE("Dimension Set ID", PurchLineRec."Dimension Set ID");
                            DimSetEntryRec_1.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                            IF DimSetEntryRec_1.FINDFIRST() THEN
                                LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

                            IF LicenseCodeValue_1 <> '' THEN BEGIN
                                IF LicenseCodeValue <> LicenseCodeValue_1 THEN
                                    ERROR(Text004);
                            END;
                            IF LicenseCodeValue = LicenseCodeValue_1 THEN BEGIN
                                PurchHdrAddiRec.RESET();
                                IF PurchHdrAddiRec.GET(Rec."Document Type", Rec."No.") THEN BEGIN
                                    PurchHdrAddiRec."License Code" := LicenseCodeValue_1;
                                    PurchHdrAddiRec.MODIFY();
                                END;
                            END;
                        UNTIL PurchLineRec.NEXT() = 0;

                        IF LicenseCodeValue_1 <> '' THEN BEGIN
                            GenLedSetRec.RESET();
                            GenLedSetRec.GET();
                            IF GenLedSetRec."License Dimension Code FND" = '' THEN
                                ERROR(Text000);
                            DimValRec.RESET();
                            DimValRec.GET(GenLedSetRec."License Dimension Code FND", LicenseCodeValue_1);
                            DimMgt.GetDimensionSet(TempDimSetEntry, Rec."Dimension Set ID");
                            //>> HEI.07
                            IF NOT TempDimSetEntry.GET(Rec."Dimension Set ID", GenLedSetRec."License Dimension Code FND") THEN BEGIN
                                TempDimSetEntry.INIT();
                                TempDimSetEntry.VALIDATE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCodeValue_1);
                                TempDimSetEntry."Dimension Value ID" := DimValRec."Dimension Value ID";
                                TempDimSetEntry.INSERT();
                                //    IF NOT TempDimSetEntry.INSERT THEN
                                //      TempDimSetEntry.MODIFY;
                            END ELSE BEGIN
                                IF xRec."License Code FND" <> LicenseCodeValue_1 THEN BEGIN
                                    TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCodeValue_1);
                                    TempDimSetEntry.MODIFY();
                                END;
                            END;
                            //<< HEI.07

                            Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);

                            Rec.MODIFY();
                        END;
                    END;
                END;
                //<< HEI.06
                // <<DITW15.00.00.36 DDR 07/12/2009
                CurrPage.UPDATE(TRUE);
                // >>DITW15.00.00.36 DDR
                // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
                //ReleasePurchDoc.PerformManualRelease(Rec);
                // ReleasePurchDoc.DocStatusRelease(xRec, Rec);////Bc Upgrade YADAVM09 Dependency on drink it code
                // CurrPage.UPDATE; //Bc Upgrade YADAVM09 Dependency on drink it code
                // >>DITW15.00.00.39 DDR #1330 #1407

            end;
            //Bc Upgrade YADAVM09<<
        }
        modify(Reopen)
        {
            CaptionML = ENU = 'Re&open', FRA = 'R&ouvrir';
            ToolTipML = ENU = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.', FRA = 'Rouvrez le document pour le modifier après son approbation. Les documents approuvés ont le statut Lancé et doivent être ouverts pour pouvoir être modifiés.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Get St&d. Vend. Purchase Codes")
        {
            CaptionML = ENU = 'Get St&d. Vend. Purchase Codes', FRA = 'Extraire codes &achat fourn. std';
        }
        modify(CalculateInvoiceDiscount)
        {
            CaptionML = ENU = 'Calculate &Invoice Discount', FRA = 'C&alculer remise facture';
            ToolTipML = ENU = 'Calculate the invoice discount for the entire document.', FRA = 'Calculez la remise facture pour l''ensemble du document.';
        }
        modify(ApplyEntries)
        {
            CaptionML = ENU = 'Apply Entries', FRA = 'Lettrer écritures';
            ToolTipML = ENU = 'Apply open entries for the relevant account type.', FRA = 'Lettrez des écritures ouvertes pour le type de compte concerné.';
        }
        modify(GetPostedDocumentLinesToReverse)
        {
            CaptionML = ENU = 'Get Posted Doc&ument Lines to Reverse', FRA = 'Extraire lignes doc&ument enreg. à contrepasser';
            ToolTipML = ENU = 'Copy one or more posted purchase document lines in order to reverse the original order.', FRA = 'Copiez une ou plusieurs lignes de document achat validé afin de contrepasser la commande d''origine.';
        }
        modify("Copy Document")
        {
            CaptionML = ENU = 'Copy Document', FRA = 'Copier document';
        }
        modify("Move Negative Lines")
        {
            CaptionML = ENU = 'Move Negative Lines', FRA = 'Déplacer lignes négatives';
        }
        modify(IncomingDocument)
        {
            CaptionML = ENU = 'Incoming Document', FRA = 'Document entrant';
        }
        modify(IncomingDocCard)
        {
            CaptionML = ENU = 'View Incoming Document', FRA = 'Afficher le document entrant';
            ToolTipML = ENU = 'View any incoming document records and file attachments that exist for the entry or document.', FRA = 'Affichez tout enregistrement et fichier joint de document entrant qui existe pour l''écriture ou le document.';
        }
        modify(SelectIncomingDoc)
        {
            CaptionML = ENU = 'Select Incoming Document', FRA = 'Sélectionner le document entrant';
            ToolTipML = ENU = 'Select an incoming document record and file attachment that you want to link to the entry or document.', FRA = 'Sélectionnez un fichier joint ou un enregistrement de document entrant que vous voulez associer à l''écriture ou au document.';
        }
        modify(IncomingDocAttachFile)
        {
            CaptionML = ENU = 'Create Incoming Document from File', FRA = 'Créer un document entrant à partir d''un fichier';
            ToolTipML = ENU = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.', FRA = 'Créez un enregistrement de document entrant en sélectionnant un fichier à joindre, puis associez l''enregistrement de document entrant à l''écriture ou au document.';
        }
        modify(RemoveIncomingDoc)
        {
            CaptionML = ENU = 'Remove Incoming Document', FRA = 'Supprimer le document entrant';
            ToolTipML = ENU = 'Remove an external document that has been recorded, manually or automatically, and attached as a file to a document or ledger entry.', FRA = 'Supprimez un document externe qui a été enregistré, manuellement ou automatiquement, et joint en tant que fichier à un document ou en écriture comptable.';
        }
        modify("Request Approval")
        {
            CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';
        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send A&pproval Request', FRA = 'Envoyer demande d''a&pprobation';
            ToolTipML = ENU = 'Send an approval request.', FRA = 'Envoyez une demande d''approbation.';
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


        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';
            //Bc Upgrade YADAVM09>>
            trigger OnBeforeAction()
            begin
                //>> HEI.06
                GenLedSetRec.RESET();
                GenLedSetRec.GET();
                IF GenLedSetRec."License Dimension Code FND" <> '' THEN BEGIN
                    CLEAR(LicenseCodeValue);
                    PurchaseLine.RESET();
                    PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                    PurchaseLine.SETRANGE("Document No.", Rec."No.");
                    PurchaseLine.SETFILTER(Type, '%1|%2|%3|%4', PurchaseLine.Type::"Charge (Item)", PurchaseLine.Type::"Fixed Asset", PurchaseLine.Type::"G/L Account", PurchaseLine.Type::Item);
                    IF PurchaseLine.FINDFIRST() THEN BEGIN
                        DimSetEntryRec.RESET();
                        DimSetEntryRec.SETRANGE("Dimension Set ID", PurchaseLine."Dimension Set ID");
                        DimSetEntryRec.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                        IF DimSetEntryRec.FINDFIRST() THEN
                            LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
                    END;
                    CLEAR(LicenseCodeValue_1);
                    PurchLineRec.RESET();
                    PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
                    PurchLineRec.SETRANGE("Document No.", Rec."No.");
                    PurchLineRec.SETFILTER(Type, '<>%1', 0);
                    IF PurchLineRec.FINDFIRST() THEN BEGIN
                        REPEAT
                            DimSetEntryRec_1.RESET();
                            DimSetEntryRec_1.SETRANGE("Dimension Set ID", PurchLineRec."Dimension Set ID");
                            DimSetEntryRec_1.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                            IF DimSetEntryRec_1.FINDFIRST() THEN
                                LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

                            IF LicenseCodeValue_1 <> '' THEN BEGIN
                                IF LicenseCodeValue <> LicenseCodeValue_1 THEN
                                    ERROR(Text004);
                            END;
                            IF LicenseCodeValue = LicenseCodeValue_1 THEN BEGIN
                                PurchHdrAddiRec.RESET();
                                IF PurchHdrAddiRec.GET(Rec."Document Type", Rec."No.") THEN BEGIN
                                    PurchHdrAddiRec."License Code" := LicenseCodeValue_1;
                                    PurchHdrAddiRec.MODIFY();
                                END;
                            END;
                        UNTIL PurchLineRec.NEXT() = 0;

                        IF LicenseCodeValue_1 <> '' THEN BEGIN
                            GenLedSetRec.RESET();
                            GenLedSetRec.GET();
                            IF GenLedSetRec."License Dimension Code FND" = '' THEN
                                ERROR(Text000);
                            DimValRec.RESET();
                            DimValRec.GET(GenLedSetRec."License Dimension Code FND", LicenseCodeValue_1);
                            DimMgt.GetDimensionSet(TempDimSetEntry, Rec."Dimension Set ID");
                            //>> HEI.07
                            IF NOT TempDimSetEntry.GET(Rec."Dimension Set ID", GenLedSetRec."License Dimension Code FND") THEN BEGIN
                                TempDimSetEntry.INIT();
                                TempDimSetEntry.VALIDATE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCodeValue_1);
                                TempDimSetEntry."Dimension Value ID" := DimValRec."Dimension Value ID";
                                TempDimSetEntry.INSERT();
                                //    IF NOT TempDimSetEntry.INSERT THEN
                                //      TempDimSetEntry.MODIFY;
                            END ELSE BEGIN
                                IF xRec."License Code FND" <> LicenseCodeValue_1 THEN BEGIN
                                    TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCodeValue_1);
                                    TempDimSetEntry.MODIFY();
                                END;
                            END;
                            //<< HEI.07
                            Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);

                            Rec.MODIFY();
                        END;
                    END;
                END;
                //<< HEI.06
            end;
            //Bc Upgrade YADAVM09<<
        }
        modify(Preview)
        {
            CaptionML = ENU = 'Preview Posting', FRA = 'Aperçu compta.';
            ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.', FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';
        }
        modify(TestReport)
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify(PostAndPrint)
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
            ToolTipML = ENU = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.', FRA = 'Finalisez et préparez-vous à imprimer le document ou la feuille. Les valeurs et les quantités sont validées en fonction des comptes associés. Une fenêtre de demande d''état où vous pouvez spécifier ce qu''il faut inclure sur l''élément à imprimer.';
        }
        modify("Remove From Job Queue")
        {
            CaptionML = ENU = 'Remove From Job Queue', FRA = 'Supprimer de la file d''attente des travaux';
            ToolTipML = ENU = 'Remove the scheduled processing of this record from the job queue.', FRA = 'Supprimez le traitement planifié de cet enregistrement à partir de la file d''attente des travaux.';
        }



        //Unsupported feature: CodeModification on "Release(Action 112).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleasePurchDoc.PerformManualRelease(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //>> HEI.06
        GenLedSetRec.RESET;
        GenLedSetRec.GET;
        if GenLedSetRec."License Dimension Code FND" <> '' then begin
          CLEAR(LicenseCodeValue);
          PurchaseLine.RESET;
          PurchaseLine.SETRANGE("Document Type",Rec."Document Type");
          PurchaseLine.SETRANGE("Document No.",Rec."No.");
          PurchaseLine.SETFILTER(Type,'%1|%2|%3|%4',PurchaseLine.Type::"Charge (Item)",PurchaseLine.Type::"Fixed Asset",PurchaseLine.Type::"G/L Account",PurchaseLine.Type::Item);
          if PurchaseLine.FINDFIRST then begin
              DimSetEntryRec.RESET;
              DimSetEntryRec.SETRANGE("Dimension Set ID",PurchaseLine."Dimension Set ID");
              DimSetEntryRec.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code FND");
              if DimSetEntryRec.FINDFIRST then
                LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
          end;
          CLEAR(LicenseCodeValue_1);
          PurchLineRec.RESET;
          PurchLineRec.SETRANGE("Document Type",Rec."Document Type");
          PurchLineRec.SETRANGE("Document No.",Rec."No.");
          PurchLineRec.SETFILTER(Type,'<>%1',0);
          if PurchLineRec.FINDFIRST then begin
            repeat
              DimSetEntryRec_1.RESET;
              DimSetEntryRec_1.SETRANGE("Dimension Set ID",PurchLineRec."Dimension Set ID");
              DimSetEntryRec_1.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code FND");
              if DimSetEntryRec_1.FINDFIRST then
                LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

              if LicenseCodeValue_1 <>'' then begin
                if LicenseCodeValue <> LicenseCodeValue_1 then
                  ERROR(Text004);
              end;
              if LicenseCodeValue = LicenseCodeValue_1 then begin
                PurchHdrAddiRec.RESET;
                if PurchHdrAddiRec.GET(Rec."Document Type",Rec."No.")then begin
                  PurchHdrAddiRec."License Code" := LicenseCodeValue_1;
                  PurchHdrAddiRec.MODIFY;
                end;
              end;
            until PurchLineRec.NEXT = 0;

          if LicenseCodeValue_1 <> '' then begin
            GenLedSetRec.RESET;
            GenLedSetRec.GET;
            if GenLedSetRec."License Dimension Code FND" = '' then
              ERROR(Text000);
            DimValRec.RESET;
            DimValRec.GET(GenLedSetRec."License Dimension Code FND",LicenseCodeValue_1);
            DimMgt.GetDimensionSet(TempDimSetEntry, Rec."Dimension Set ID");
            //>> HEI.07
            if not TempDimSetEntry.GET(Rec."Dimension Set ID",GenLedSetRec."License Dimension Code FND") then begin
              TempDimSetEntry.INIT;
              TempDimSetEntry.VALIDATE("Dimension Code",GenLedSetRec."License Dimension Code FND");
              TempDimSetEntry.VALIDATE("Dimension Value Code",LicenseCodeValue_1);
              TempDimSetEntry."Dimension Value ID" := DimValRec."Dimension Value ID";
              TempDimSetEntry.INSERT;
          //    IF NOT TempDimSetEntry.INSERT THEN
          //      TempDimSetEntry.MODIFY;
            end else
              begin
                if xRec."License Code" <> LicenseCodeValue_1 then begin
                  TempDimSetEntry.VALIDATE("Dimension Value Code",LicenseCodeValue_1);
                  TempDimSetEntry.MODIFY;
                end;
              end;
            //<< HEI.07

            Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);

            Rec.MODIFY;
            end;
          end;
        end;
        //<< HEI.06
        // <<DITW15.00.00.36 DDR 07/12/2009
        CurrPage.UPDATE(true);
        // >>DITW15.00.00.36 DDR
        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
        //ReleasePurchDoc.PerformManualRelease(Rec);
        ReleasePurchDoc.DocStatusRelease(xRec,Rec);
        CurrPage.UPDATE;
        // >>DITW15.00.00.39 DDR #1330 #1407
        */
        //end;


        //Unsupported feature: CodeModification on "Reopen(Action 113).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleasePurchDoc.PerformManualReopen(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
        //ReleasePurchDoc.PerformManualReopen(Rec);
        ReleasePurchDoc.DocStatusOpen(xRec,Rec);
        CurrPage.UPDATE;
        // >>DITW15.00.00.39 DDR #1330 #1407
        */
        //end;


        //Unsupported feature: CodeModification on "Post(Action 59).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Post(CODEUNIT::"Purch.-Post (Yes/No)");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //>> HEI.06
        GenLedSetRec.RESET;
        GenLedSetRec.GET;
        if GenLedSetRec."License Dimension Code FND" <> '' then begin
          CLEAR(LicenseCodeValue);
          PurchaseLine.RESET;
          PurchaseLine.SETRANGE("Document Type",Rec."Document Type");
          PurchaseLine.SETRANGE("Document No.",Rec."No.");
          PurchaseLine.SETFILTER(Type,'%1|%2|%3|%4',PurchaseLine.Type::"Charge (Item)",PurchaseLine.Type::"Fixed Asset",PurchaseLine.Type::"G/L Account",PurchaseLine.Type::Item);
          if PurchaseLine.FINDFIRST then begin
              DimSetEntryRec.RESET;
              DimSetEntryRec.SETRANGE("Dimension Set ID",PurchaseLine."Dimension Set ID");
              DimSetEntryRec.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code FND");
              if DimSetEntryRec.FINDFIRST then
                LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
          end;
          CLEAR(LicenseCodeValue_1);
          PurchLineRec.RESET;
          PurchLineRec.SETRANGE("Document Type",Rec."Document Type");
          PurchLineRec.SETRANGE("Document No.",Rec."No.");
          PurchLineRec.SETFILTER(Type,'<>%1',0);
          if PurchLineRec.FINDFIRST then begin
            repeat
              DimSetEntryRec_1.RESET;
              DimSetEntryRec_1.SETRANGE("Dimension Set ID",PurchLineRec."Dimension Set ID");
              DimSetEntryRec_1.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code FND");
              if DimSetEntryRec_1.FINDFIRST then
                LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

              if LicenseCodeValue_1 <>'' then begin
                if LicenseCodeValue <> LicenseCodeValue_1 then
                  ERROR(Text004);
              end;
              if LicenseCodeValue = LicenseCodeValue_1 then begin
                PurchHdrAddiRec.RESET;
                if PurchHdrAddiRec.GET(Rec."Document Type",Rec."No.")then begin
                  PurchHdrAddiRec."License Code" := LicenseCodeValue_1;
                  PurchHdrAddiRec.MODIFY;
                end;
              end;
            until PurchLineRec.NEXT = 0;

          if LicenseCodeValue_1 <> '' then begin
            GenLedSetRec.RESET;
            GenLedSetRec.GET;
            if GenLedSetRec."License Dimension Code FND" = '' then
              ERROR(Text000);
            DimValRec.RESET;
            DimValRec.GET(GenLedSetRec."License Dimension Code FND",LicenseCodeValue_1);
            DimMgt.GetDimensionSet(TempDimSetEntry, Rec."Dimension Set ID");
            //>> HEI.07
            if not TempDimSetEntry.GET(Rec."Dimension Set ID",GenLedSetRec."License Dimension Code FND") then begin
              TempDimSetEntry.INIT;
              TempDimSetEntry.VALIDATE("Dimension Code",GenLedSetRec."License Dimension Code FND");
              TempDimSetEntry.VALIDATE("Dimension Value Code",LicenseCodeValue_1);
              TempDimSetEntry."Dimension Value ID" := DimValRec."Dimension Value ID";
              TempDimSetEntry.INSERT;
          //    IF NOT TempDimSetEntry.INSERT THEN
          //      TempDimSetEntry.MODIFY;
            end else
              begin
                if xRec."License Code" <> LicenseCodeValue_1 then begin
                  TempDimSetEntry.VALIDATE("Dimension Value Code",LicenseCodeValue_1);
                  TempDimSetEntry.MODIFY;
                end;
              end;
            //<< HEI.07
            Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);

            Rec.MODIFY;
            end;
          end;
        end;
        //<< HEI.06
        Post(CODEUNIT::"Purch.-Post (Yes/No)");
        */
        //end;
        addafter("Co&mments")
        {
            action("Purchase Additional")
            {
                ApplicationArea = all;
                Caption = 'Purchase Additional';
                Image = Purchase;
                RunObject = Page "Purchase Additional";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                              "No." = FIELD("No.");
                ToolTip = 'Executes the Purchase Additional action.';
            }
        }
    }


    //Unsupported feature: PropertyModification on "OpenPostedPurchCrMemoQst(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OpenPostedPurchCrMemoQst : ENU=The credit memo has been posted and archived.\\Do you want to open the posted credit memo from the Posted Purchase Credit Memos window?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OpenPostedPurchCrMemoQst : ENU=The credit memo has been posted and archived.\\Do you want to open the posted credit memo from the Posted Purchase Credit Memos window?;FRA=L'avoir a été validé et archivé.\\Souhaitez-vous ouvrir l'avoir validé à partir de la fenêtre Avoirs achat enregistrés ?;
    //Variable type has not been exported.

    var
        Text2014411: TextConst ENU = 'Do you want to cancel the approval request for %1 %2?', FRA = 'Souhaitez vous annuler la demande d''approbation du/de la %1 %2?';
        StdVendPurchCode: Record "Standard Vendor Purchase Code";
        Text2014412: TextConst ENU = 'Do you want to send the approval request for %1 %2?', FRA = 'Souhaitez vous envoyer la demande d''approbation du/de la %1 %2?';
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        recPurchSetup: Record "Purchases & Payables Setup";
        recGenJournalTemplate: Record "Gen. Journal Template";
        txtTemplateName: Text;
        blnJnlSelected: Boolean;
        //cduSingleInstaceFunctions: Codeunit "Single Instance Functions";//Bc Upgrade YADAVM09 Object not used anywhere in the code
        cduReleasePurchDoc: Codeunit "Release Purchase Document";
        //recFinXLSetup: Record "Finance XL Setup";//Bc Upgrade YADAVM09 Drink it object
        DocSubtypeEditable: Boolean;
        ReasonCodeErr: Label 'You must fill in the Reason Code';
        ArchiveManagement: Codeunit ArchiveManagement;
        VendorPostGroupEditable: Boolean;
        LicenseCode: Code[20];
        DimValRec: Record "Dimension Value";
        GenLedSetRec: Record "General Ledger Setup";
        DimValue: Code[10];
        DimValPage: Page "Dimension Values";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        Text000: Label 'Please select the dimension for License Dimension in General Ledger Setup.';
        Text001: Label 'The seleced value cannot be found in the dimension value table.';
        DimMgt: Codeunit DimensionManagement;
        DimSetEntryRec_2: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        OldDimSetId: Integer;
        PurchRec: Record "Purchase Header";
        PurchLineRec: Record "Purchase Line";
        PurchLine: Record "Purchase Line";
        LicenseCodeValue: Code[20];
        DimSetEntryRec: Record "Dimension Set Entry";
        LicenseCodeValue_1: Code[20];
        DimSetEntryRec_1: Record "Dimension Set Entry";
        HideValidationDialog: Boolean;
        Text051: TextConst ENU = 'You may have changed a dimension.\\Do you want to update the lines?', FRA = 'Vous avez probablement modifié un axe analytique.\\Souhaitez-vous mettre à jour les lignes ?';
        Text003: Label 'You cannot edit the License code when the PO when status is released.';
        Text004: Label 'License Dimension Value should be same for both header and line.';
        NewDImSetId: Integer;
        PurchaseLine: Record "Purchase Line";
        PurchHdrAddiRec: Record "Purchase Header Additional FND";


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetControlAppearance;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);
    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
    SETFILTER("Resp. Center Table Filter",
      UserMgt.GetRespCenterFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",
      UserMgt.GetRespPhysLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",
      UserMgt.GetRespLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 DDR DIT-770 #1191
    // <<DITW15.00.00.39 DDR 27/07/2011 #1407
    CALCFIELDS("Disc.Promo. Order Calculated");
    // >>DITW15.00.00.34 DDR

    #1..4
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    trigger OnOpenPage();

    begin
        //HEI.01>>
        //BC Upgrade VAMSIU01 - added rec to field >>
        IF Rec."Document Subtype Code FND" <> '' THEN
            DocSubtypeEditable := FALSE;
        //HEI.01<<

        //HEI.03>>
        recPurchSetup.GET();
        VendorPostGroupEditable := recPurchSetup."Enable FA Vendor Req. FND";
        //HEI.03<<

    end;


    //Unsupported feature: CodeModification on "PricesIncludingVATOnAfterValid(PROCEDURE 19009096)". Please convert manually.

    //procedure PricesIncludingVATOnAfterValid();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.UPDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.UPDATE;
    /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245
    */
    //end;

    /* Bc Upgrade YADAVM09 Drink it function>>
        local procedure StatusOnAfterValidate();
        begin
            // <<DITW15.00.00.34 DDR 17/06/2009
            CurrPage.UPDATE(false);
        end;

        local procedure StatusOnValidate();
        begin
            // <<DITW15.00.00.34 DDR 17/06/2009
            if xRec.Status = Status then
                exit;

            // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
            if (xRec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Released) then
                ReleasePurchDoc.DocStatusRelease(xRec, Rec)
            else begin
                if Rec.Status = Rec.Status::Open then
                    ReleasePurchDoc.DocStatusOpen(xRec, Rec)
                else
                    // >>DITW15.00.00.39 DDR #1330 #1407
                    Rec.TESTFIELD(Status, xRec.Status);
            end;
        end;
    */ //Bc Upgrade YADAVM09 Drink it function<<
    local procedure UpdateAllLineDimNew(NewParentDimSetID: Integer; OldParentDimSetID: Integer);
    var
        NewDimSetID: Integer;
        ReceivedShippedItemLineDimChangeConfirmed: Boolean;
        PurchLine: Record "Purchase Line";
    begin
        // Update all lines with changed dimensions.
        //HEI.08>>
        if NewParentDimSetID = OldParentDimSetID then
            exit;

        if not HideValidationDialog then
            if not CONFIRM(Text051) then
                exit;

        PurchLine.RESET();
        PurchLine.SETRANGE("Document Type", Rec."Document Type");
        PurchLine.SETRANGE("Document No.", Rec."No.");
        PurchLine.LOCKTABLE();
        if PurchLine.FIND('-') then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(PurchLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if PurchLine."Dimension Set ID" <> NewDimSetID then begin
                    PurchLine."Dimension Set ID" := NewDimSetID;

                    if not HideValidationDialog and GUIALLOWED then
                        VerifyReceivedShippedItemLineDimChange(ReceivedShippedItemLineDimChangeConfirmed);

                    DimMgt.UpdateGlobalDimFromDimSetID(
                      PurchLine."Dimension Set ID", PurchLine."Shortcut Dimension 1 Code", PurchLine."Shortcut Dimension 2 Code");
                    PurchLine.MODIFY();
                end;
            until PurchLine.NEXT() = 0;
        //HEI.08 <<
    end;

    // Blocked below one as its already defined in base. 
    // procedure SetHideValidationDialog(NewHideValidationDialog: Boolean);
    // begin
    //     HideValidationDialog := NewHideValidationDialog;//HEI.08
    // end;

    local procedure VerifyReceivedShippedItemLineDimChange(var ReceivedShippedItemLineDimChangeConfirmed: Boolean);
    begin
        //HEI,08 >>
        if PurchLine.IsReceivedShippedItemDimChanged() then
            if not ReceivedShippedItemLineDimChangeConfirmed then
                ReceivedShippedItemLineDimChangeConfirmed := PurchLine.ConfirmReceivedShippedItemDimChange();
        //HEI.08 <<
    end;



    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

