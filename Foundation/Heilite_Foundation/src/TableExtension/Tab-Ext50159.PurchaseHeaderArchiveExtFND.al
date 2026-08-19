tableextension 50159 PurchaseHeaderArchiveExtFND extends "Purchase Header Archive"
{
    //    DITW15.00.00.01 DDR 31/01/2008 Added Drink-it Reversing Calculation (Rounding) functionnalities
    //                                Added fields
    //                                  2103610 Vendor DDeposit Group Code
    //                                  2034647 Vendor DTax Group Code
    //                                  2034690 Price Incl. Reversing Calc.
    // DITW15.00.00.01 DDR 27/02/2008 Remove field (see lines)
    //                                  2034690 Price Incl. Reversing Calc.
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.20 DDR 11/06/2008 Certification rules
    // DITW15.00.00.24 DDR 07/10/2008 Added fields
    //                                  2013722 Duty Tax Type
    // DITW15.00.00.25 DDR 21/10/2008 Deleted fields
    //                                  2013722 Duty Tax Type
    // DITW15.00.00.33 DDR 08/05/2009 Added fields
    //                                  2013613 Link Purch. Document No.
    //                                  2013614 Link Purch. Document Type
    //                                  2013615 Print Link Document
    //                                  2013616 No. of Link Purchase Orders
    //                                  2013695 Item Charge Type Filter
    //                                  2013726 Vendor Tax Registration No.
    //                                  2013730 Fiscal Representative No.
    //                                  2013797 Disc.Promo. Order Calculated
    //                                  2014060 Maximum Weight
    //                                  2014061 Maximum Cubage
    //                                  2014064 Shipping Charge Per
    //                                  2014067 Total Weight
    //                                  2014068 Total Cubage
    //                                  2014075 Shipping Agent Code
    //                                  2014076 Shipping Agent Service Code
    //                                  2014077 Truck Code
    //                                  2014078 Driver Code
    //                                  2014087 Distance
    // DITW15.00.00.35 DDR 25/06/2009 Added fields
    //                                  2013824 Gen. Bus. Posting Free Group
    //                     13/10/2009 issue 722 Added fields
    //                                  2013611 Empty Goods Item No. Filter
    //                                Updated Filters - TableRelation property field "Empty Goods Item No. Filter"
    // DITW15.00.00.37 DDR 04/02/2010 issue 1033 Convert field2013797 Disc.Promo. Order Calculated into flowfield based on lines
    // DITW15.00.00.38 DDR 13/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    2014271 Tax Warehouse Reference
    //                     27/01/2011 issue 1217 (DIT711 137)
    //                                  Modified Caption field2013730 "Fiscal Representative No."
    //                                  Added fields
    //                                    2014460 Tax Office Code
    // DITW15.00.00.39 DDR 19/08/2011 issue 1363
    //                                  Added fields
    //                                    2013733 Tax Date
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field 2014420 "Sundry Vendor"
    // DITW18.00.07 MVN 24/02/2016 DIT-770 #1397 Added missing DIT Fields
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field 2014421 "Document Subtype Code"
    // DITW18.00.07 AKH 27/04/2016 DIT-770 #1346 Added field 2014080 "Vendor Delivery Type"
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time", "Created By"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 16/02/2017 NRQ#20755 Update document subtype code table relation filter

    // HEI.01 PURGAP05 IBM LAZARE02 17.08.2017
    //   #Extend City fields to 35; Extend Address and Address 2 fields to 60

    // HEI.02 HLSRM02-05 IBM LAZARE02 17.08.2017
    //   #New fields for SRM integration

    // HEI.03 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New fields for MDM integration

    // HEI.04 FDD-PURGAPINT002 IBM LAZARE02 25.09.2017
    //   # New field "Maximo Requisition No."
    // HEI.06 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field created: 50041 - Fixed Asset Acquisition
    // HEI.07  CHG2024557 FDD-HT821 IBM SHANKJ03 10.02.2020
    //   # New field added Maximo status
    // HEI.08 CHG2121745 BHATTA09 23.08.2021
    //   # New field added Shopping Card No. 50044
    // BC Upgrade SHUKLP03 >> Added to the interface extension due to a dependency on the "Purchase Header Archive Addit" table for compilation.
    // field "Maximo Status"
    // BC Upgrade SHUKLP03 << Added to the interface extension due to a dependency on the "Purchase Header Archive Addit" table for compilation.

    // BC Upgrade SHUKLP03 >> Document subtype code field added.

    fields
    {
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            // OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order', FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
        }
        modify("Buy-from Vendor No.")
        {
            CaptionML = ENU = 'Buy-from Vendor No.', FRA = 'N° fournisseur';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Pay-to Vendor No.")
        {
            CaptionML = ENU = 'Pay-to Vendor No.', FRA = 'N° fournisseur à payer';
        }
        modify("Pay-to Name")
        {
            CaptionML = ENU = 'Pay-to Name', FRA = 'Nom';
        }
        modify("Pay-to Name 2")
        {
            CaptionML = ENU = 'Pay-to Name 2', FRA = 'Nom 2';
        }
        modify("Pay-to Address")
        {

            //Unsupported feature: Change Data type on ""Pay-to Address"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Pay-to Address', FRA = 'Adresse';

            //Unsupported feature: Change Description on ""Pay-to Address"(Field 7)". Please convert manually.

        }
        modify("Pay-to Address 2")
        {

            //Unsupported feature: Change Data type on ""Pay-to Address 2"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Pay-to Address 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change Description on ""Pay-to Address 2"(Field 8)". Please convert manually.

        }
        modify("Pay-to City")
        {

            //Unsupported feature: Change Data type on ""Pay-to City"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Pay-to City', FRA = 'Ville';

            //Unsupported feature: Change Description on ""Pay-to City"(Field 9)". Please convert manually.

        }
        modify("Pay-to Contact")
        {
            CaptionML = ENU = 'Pay-to Contact', FRA = 'Contact';
        }
        modify("Your Reference")
        {
            CaptionML = ENU = 'Your Reference', FRA = 'Votre référence';
        }
        modify("Ship-to Code")
        {
            CaptionML = ENU = 'Ship-to Code', FRA = 'Code destinataire';
        }
        modify("Ship-to Name")
        {
            CaptionML = ENU = 'Ship-to Name', FRA = 'Nom du destinataire';
        }
        modify("Ship-to Name 2")
        {
            CaptionML = ENU = 'Ship-to Name 2', FRA = 'Nom du destinataire 2';
        }
        modify("Ship-to Address")
        {

            //Unsupported feature: Change Data type on ""Ship-to Address"(Field 15)". Please convert manually.

            CaptionML = ENU = 'Ship-to Address', FRA = 'Adresse destinataire';

            //Unsupported feature: Change Description on ""Ship-to Address"(Field 15)". Please convert manually.

        }
        modify("Ship-to Address 2")
        {

            //Unsupported feature: Change Data type on ""Ship-to Address 2"(Field 16)". Please convert manually.

            CaptionML = ENU = 'Ship-to Address 2', FRA = 'Adresse destinataire 2';

            //Unsupported feature: Change Description on ""Ship-to Address 2"(Field 16)". Please convert manually.

        }
        modify("Ship-to City")
        {

            //Unsupported feature: Change Data type on ""Ship-to City"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Ship-to City', FRA = 'Ville destinataire';

            //Unsupported feature: Change Description on ""Ship-to City"(Field 17)". Please convert manually.

        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Ship-to Contact', FRA = 'Contact destinataire';
        }
        modify("Order Date")
        {
            CaptionML = ENU = 'Order Date', FRA = 'Date commande';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Expected Receipt Date")
        {
            CaptionML = ENU = 'Expected Receipt Date', FRA = 'Date réception prévue';
        }
        modify("Posting Description")
        {
            CaptionML = ENU = 'Posting Description', FRA = 'Libellé écriture';
        }
        modify("Payment Terms Code")
        {
            CaptionML = ENU = 'Payment Terms Code', FRA = 'Code condition paiement';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Date d''échéance';
        }
        modify("Payment Discount %")
        {
            CaptionML = ENU = 'Payment Discount %', FRA = '% escompte';
        }
        modify("Pmt. Discount Date")
        {
            CaptionML = ENU = 'Pmt. Discount Date', FRA = 'Date d''escompte';
        }
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Shipment Method Code', FRA = 'Code condition livraison';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Vendor Posting Group")
        {
            CaptionML = ENU = 'Vendor Posting Group', FRA = 'Groupe compta. fournisseur';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Currency Factor")
        {
            CaptionML = ENU = 'Currency Factor', FRA = 'Facteur devise';
        }
        modify("Prices Including VAT")
        {
            CaptionML = ENU = 'Prices Including VAT', FRA = 'Prix TTC';
        }
        modify("Invoice Disc. Code")
        {
            CaptionML = ENU = 'Invoice Disc. Code', FRA = 'Code remise facture';
        }
        modify("Language Code")
        {
            CaptionML = ENU = 'Language Code', FRA = 'Code langue';
        }
        modify("Purchaser Code")
        {
            CaptionML = ENU = 'Purchaser Code', FRA = 'Code acheteur';
        }
        modify("Order Class")
        {
            CaptionML = ENU = 'Order Class', FRA = 'Type commande';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("No. Printed")
        {
            CaptionML = ENU = 'No. Printed', FRA = 'Nbre impressions';
        }
        modify("On Hold")
        {
            CaptionML = ENU = 'On Hold', FRA = 'En attente';
        }
        modify("Applies-to Doc. Type")
        {
            CaptionML = ENU = 'Applies-to Doc. Type', FRA = 'Type doc. lettrage';
            // OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement';
        }
        modify("Applies-to Doc. No.")
        {
            CaptionML = ENU = 'Applies-to Doc. No.', FRA = 'N° doc. lettrage';
        }
        modify("Bal. Account No.")
        {
            CaptionML = ENU = 'Bal. Account No.', FRA = 'N° compte contrepartie';
        }
        modify(Receive)
        {
            CaptionML = ENU = 'Receive', FRA = 'Réceptionner';
        }
        modify(Invoice)
        {
            CaptionML = ENU = 'Invoice', FRA = 'Facturer';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Amount Including VAT")
        {
            CaptionML = ENU = 'Amount Including VAT', FRA = 'Montant TTC';
        }
        modify("Receiving No.")
        {
            CaptionML = ENU = 'Receiving No.', FRA = 'Utiliser B.R. n°';
        }
        modify("Posting No.")
        {
            CaptionML = ENU = 'Posting No.', FRA = 'N° validation';
        }
        modify("Last Receiving No.")
        {
            CaptionML = ENU = 'Last Receiving No.', FRA = 'N° dern. bon de réception';
        }
        modify("Last Posting No.")
        {
            CaptionML = ENU = 'Last Posting No.', FRA = 'N° dern. facture';
        }
        modify("Vendor Order No.")
        {
            CaptionML = ENU = 'Vendor Order No.', FRA = 'N° commande fournisseur';
        }
        modify("Vendor Shipment No.")
        {
            CaptionML = ENU = 'Vendor Shipment No.', FRA = 'N° B.L. fournisseur';
        }
        modify("Vendor Invoice No.")
        {
            CaptionML = ENU = 'Vendor Invoice No.', FRA = 'N° facture fournisseur';
        }
        modify("Vendor Cr. Memo No.")
        {
            CaptionML = ENU = 'Vendor Cr. Memo No.', FRA = 'N° avoir fournisseur';
        }
        modify("VAT Registration No.")
        {
            CaptionML = ENU = 'VAT Registration No.', FRA = 'N° identif. intracomm.';
        }
        modify("Sell-to Customer No.")
        {
            CaptionML = ENU = 'Sell-to Customer No.', FRA = 'N° donneur d''ordre';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("Transaction Type")
        {
            CaptionML = ENU = 'Transaction Type', FRA = 'Nature transaction';
        }
        modify("Transport Method")
        {
            CaptionML = ENU = 'Transport Method', FRA = 'Mode de transport';
        }
        modify("VAT Country/Region Code")
        {
            CaptionML = ENU = 'VAT Country/Region Code', FRA = 'Code pays/région TVA';
        }
        modify("Buy-from Vendor Name")
        {
            CaptionML = ENU = 'Buy-from Vendor Name', FRA = 'Nom du fournisseur';
        }
        modify("Buy-from Vendor Name 2")
        {
            CaptionML = ENU = 'Buy-from Vendor Name 2', FRA = 'Nom du fournisseur 2';
        }
        modify("Buy-from Address")
        {

            //Unsupported feature: Change Data type on ""Buy-from Address"(Field 81)". Please convert manually.

            CaptionML = ENU = 'Buy-from Address', FRA = 'Adresse fournisseur';

            //Unsupported feature: Change Description on ""Buy-from Address"(Field 81)". Please convert manually.

        }
        modify("Buy-from Address 2")
        {

            //Unsupported feature: Change Data type on ""Buy-from Address 2"(Field 82)". Please convert manually.

            CaptionML = ENU = 'Buy-from Address 2', FRA = 'Adresse fournisseur 2';

            //Unsupported feature: Change Description on ""Buy-from Address 2"(Field 82)". Please convert manually.

        }
        modify("Buy-from City")
        {

            //Unsupported feature: Change Data type on ""Buy-from City"(Field 83)". Please convert manually.

            CaptionML = ENU = 'Buy-from City', FRA = 'Ville fournisseur';

            //Unsupported feature: Change Description on ""Buy-from City"(Field 83)". Please convert manually.

        }
        modify("Buy-from Contact")
        {
            CaptionML = ENU = 'Buy-from Contact', FRA = 'Contact fournisseur';
        }
        modify("Pay-to Post Code")
        {
            CaptionML = ENU = 'Pay-to Post Code', FRA = 'Code postal';
        }
        modify("Pay-to County")
        {
            CaptionML = ENU = 'Pay-to County', FRA = 'Région';
        }
        modify("Pay-to Country/Region Code")
        {
            CaptionML = ENU = 'Pay-to Country/Region Code', FRA = 'Code pays/région paiement';
        }
        modify("Buy-from Post Code")
        {
            CaptionML = ENU = 'Buy-from Post Code', FRA = 'Code postal fournisseur';
        }
        modify("Buy-from County")
        {
            CaptionML = ENU = 'Buy-from County', FRA = 'Région fournisseur';
        }
        modify("Buy-from Country/Region Code")
        {
            CaptionML = ENU = 'Buy-from Country/Region Code', FRA = 'Code pays/région fournisseur';
        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'Ship-to Post Code', FRA = 'Code postal destinataire';
        }
        modify("Ship-to County")
        {
            CaptionML = ENU = 'Ship-to County', FRA = 'Région destinataire';
        }
        modify("Ship-to Country/Region Code")
        {
            CaptionML = ENU = 'Ship-to Country/Region Code', FRA = 'Code pays/région destinataire';
        }
        modify("Bal. Account Type")
        {
            CaptionML = ENU = 'Bal. Account Type', FRA = 'Type compte contrepartie';
            // OptionCaptionML = ENU = 'G/L Account,Bank Account', FRA = 'Général,Banque';
        }
        modify("Order Address Code")
        {
            CaptionML = ENU = 'Order Address Code', FRA = 'Code adresse commande';
        }
        modify("Entry Point")
        {
            CaptionML = ENU = 'Entry Point', FRA = 'Pays provenance';
        }
        modify(Correction)
        {
            CaptionML = ENU = 'Correction', FRA = 'Correction';
        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
        }
        modify("Area")
        {
            CaptionML = ENU = 'Area', FRA = 'Dépt destination/provenance';
        }
        modify("Transaction Specification")
        {
            CaptionML = ENU = 'Transaction Specification', FRA = 'Régime';
        }
        modify("Payment Method Code")
        {
            CaptionML = ENU = 'Payment Method Code', FRA = 'Code mode de règlement';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Posting No. Series")
        {
            CaptionML = ENU = 'Posting No. Series', FRA = 'Souches de n° validation';
        }
        modify("Receiving No. Series")
        {
            CaptionML = ENU = 'Receiving No. Series', FRA = 'Souche de n° réception';
        }
        modify("Tax Area Code")
        {
            CaptionML = ENU = 'Tax Area Code', FRA = 'Code zone recouvrement';
        }
        modify("Tax Liable")
        {
            CaptionML = ENU = 'Tax Liable', FRA = 'Soumis à recouvrement';
        }
        modify("VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify("Applies-to ID")
        {
            CaptionML = ENU = 'Applies-to ID', FRA = 'ID lettrage';
        }
        modify("VAT Base Discount %")
        {
            CaptionML = ENU = 'VAT Base Discount %', FRA = '% remise base TVA';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            // OptionCaptionML = ENU = 'Open,Released,Pending Approval,Pending Prepayment', FRA = 'Ouvert,Lancé,Approbation suspendue,Acompte suspendu';
        }
        modify("Invoice Discount Calculation")
        {
            CaptionML = ENU = 'Invoice Discount Calculation', FRA = 'Calcul remise facture';
            OptionCaptionML = ENU = 'None,%,Amount', FRA = 'Aucun,%,Montant';
        }
        modify("Invoice Discount Value")
        {
            CaptionML = ENU = 'Invoice Discount Value', FRA = 'Valeur remise facture';
        }
        modify("Send IC Document")
        {
            CaptionML = ENU = 'Send IC Document', FRA = 'Envoyer le document IC';
        }
        modify("IC Status")
        {
            CaptionML = ENU = 'IC Status', FRA = 'Statut IC';
            // OptionCaptionML = ENU = 'New,Pending,Sent', FRA = 'Nouveau,Suspendu,Envoyé';
        }
        modify("Buy-from IC Partner Code")
        {
            CaptionML = ENU = 'Buy-from IC Partner Code', FRA = 'Code parten IC fournisseur';
        }
        modify("Pay-to IC Partner Code")
        {
            CaptionML = ENU = 'Pay-to IC Partner Code', FRA = 'Code du partenaire IC à payer';
        }
        modify("IC Direction")
        {
            CaptionML = ENU = 'IC Direction', FRA = 'Direction IC';
            // OptionCaptionML = ENU = 'Outgoing,Incoming', FRA = 'Sortant,Entrant';
        }
        modify("Prepayment No.")
        {
            CaptionML = ENU = 'Prepayment No.', FRA = 'N° acompte';
        }
        modify("Last Prepayment No.")
        {
            CaptionML = ENU = 'Last Prepayment No.', FRA = 'N° dernier acompte';
        }
        modify("Prepmt. Cr. Memo No.")
        {
            CaptionML = ENU = 'Prepmt. Cr. Memo No.', FRA = 'N° avoir acompte';
        }
        modify("Last Prepmt. Cr. Memo No.")
        {
            CaptionML = ENU = 'Last Prepmt. Cr. Memo No.', FRA = 'N° avoir dernier acompte';
        }
        modify("Prepayment %")
        {
            CaptionML = ENU = 'Prepayment %', FRA = '% acompte';
        }
        modify("Prepayment No. Series")
        {
            CaptionML = ENU = 'Prepayment No. Series', FRA = 'N° de série acompte';
        }
        modify("Compress Prepayment")
        {
            CaptionML = ENU = 'Compress Prepayment', FRA = 'Compresser acompte';
        }
        modify("Prepayment Due Date")
        {
            CaptionML = ENU = 'Prepayment Due Date', FRA = 'Échéance acompte';
        }
        modify("Prepmt. Cr. Memo No. Series")
        {
            CaptionML = ENU = 'Prepmt. Cr. Memo No. Series', FRA = 'N° de série avoir acompte';
        }
        modify("Prepmt. Posting Description")
        {
            CaptionML = ENU = 'Prepmt. Posting Description', FRA = 'Libellé écriture acompte';
        }
        modify("Prepmt. Pmt. Discount Date")
        {
            CaptionML = ENU = 'Prepmt. Pmt. Discount Date', FRA = 'Date escompte acompte';
        }
        modify("Prepmt. Payment Terms Code")
        {
            CaptionML = ENU = 'Prepmt. Payment Terms Code', FRA = 'Code conditions paiement acompte';
        }
        modify("Prepmt. Payment Discount %")
        {
            CaptionML = ENU = 'Prepmt. Payment Discount %', FRA = '% escompte acompte';
        }
        modify("No. of Archived Versions")
        {
            CaptionML = ENU = 'No. of Archived Versions', FRA = 'Nbre versions archivées';
        }
        modify("Purchase Quote No.")
        {
            CaptionML = ENU = 'Purchase Quote No.', FRA = 'N° demande de prix';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Interaction Exist")
        {
            CaptionML = ENU = 'Interaction Exist', FRA = 'Interaction';
        }
        modify("Time Archived")
        {
            CaptionML = ENU = 'Time Archived', FRA = 'Heure d''archivage';
        }
        modify("Date Archived")
        {
            CaptionML = ENU = 'Date Archived', FRA = 'Date d''archivage';
        }
        modify("Archived By")
        {
            CaptionML = ENU = 'Archived By', FRA = 'Archivé par';
        }
        modify("Version No.")
        {
            CaptionML = ENU = 'Version No.', FRA = 'N° version';
        }
        modify("Doc. No. Occurrence")
        {
            CaptionML = ENU = 'Doc. No. Occurrence', FRA = 'Occurrence n° doc.';
        }
        modify("Campaign No.")
        {
            CaptionML = ENU = 'Campaign No.', FRA = 'N° campagne';
        }
        modify("Buy-from Contact No.")
        {
            CaptionML = ENU = 'Buy-from Contact No.', FRA = 'N° contact fournisseur';
        }
        modify("Pay-to Contact No.")
        {
            CaptionML = ENU = 'Pay-to Contact No.', FRA = 'N° contact à payer';
        }
        modify("Responsibility Center")
        {
            CaptionML = ENU = 'Responsibility Center', FRA = 'Centre de gestion';
        }
        modify("Completely Received")
        {
            CaptionML = ENU = 'Completely Received', FRA = 'Entièrement réceptionné';
        }
        modify("Posting from Whse. Ref.")
        {
            CaptionML = ENU = 'Posting from Whse. Ref.', FRA = 'Validation à partir réf. entrepôt';
        }
        modify("Location Filter")
        {
            CaptionML = ENU = 'Location Filter', FRA = 'Filtre magasin';
        }
        modify("Requested Receipt Date")
        {
            CaptionML = ENU = 'Requested Receipt Date', FRA = 'Date réception demandée';
        }
        modify("Promised Receipt Date")
        {
            CaptionML = ENU = 'Promised Receipt Date', FRA = 'Date réception confirmée';
        }
        modify("Lead Time Calculation")
        {
            CaptionML = ENU = 'Lead Time Calculation', FRA = 'Délai de réappro.';
        }
        modify("Inbound Whse. Handling Time")
        {
            CaptionML = ENU = 'Inbound Whse. Handling Time', FRA = 'Délai enlogement';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Vendor Authorization No.")
        {
            CaptionML = ENU = 'Vendor Authorization No.', FRA = 'N° autorisation fournisseur';
        }
        modify("Return Shipment No.")
        {
            CaptionML = ENU = 'Return Shipment No.', FRA = 'N° expédition retour';
        }
        modify("Return Shipment No. Series")
        {
            CaptionML = ENU = 'Return Shipment No. Series', FRA = 'Souche de n° expédition retour';
        }
        modify(Ship)
        {
            CaptionML = ENU = 'Ship', FRA = 'Expédier';
        }
        modify("Last Return Shipment No.")
        {
            CaptionML = ENU = 'Last Return Shipment No.', FRA = 'Dernier n° expédition retour';
        }
        modify("Assigned User ID")
        {
            CaptionML = ENU = 'Assigned User ID', FRA = 'Code utilisateur affecté';
        }
        field(50005; "SRM Contract No. FND"; Code[10])
        {
            Caption = 'SRM Contract No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50006; "SRM Contract Name FND"; Text[50])
        {
            Caption = 'SRM Contract Name';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50007; "SRM Contract Type FND"; Code[10])
        {
            Caption = 'Contract Type';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = "SRM Contract Type FND";
        }
        field(50008; "Valid From FND"; Date)
        {
            Caption = 'Valid From';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50009; "Valid To FND"; Date)
        {
            Caption = 'Valid To';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50010; "Channel FND"; Code[1])
        {
            Caption = 'Channel';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = "Channel FND";
        }
        field(50011; "Shipment Method Location FND"; Text[30])
        {
            Caption = 'Shipment Method Location';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50012; "Closed FND"; Boolean)
        {
            Caption = 'Closed';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50013; "SRM Order No. FND"; Code[10])
        {
            Caption = 'SRM Order No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50014; "SRM Version No. FND"; Code[10])
        {
            Caption = 'SRM Version No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50020; "Target Value Currency FND"; Code[10])
        {
            Caption = 'Target Value Currency';
            Description = 'HEI.02';
            TableRelation = Currency;
        }
        field(50021; "Target Value Amount FND"; Decimal)
        {
            Caption = 'Target Value Amount';
            Description = 'HEI.02';
        }
        field(50022; "Blanket Order No. FND"; Code[20])
        {
            Caption = 'Blanket Order No.';
            Description = 'HEI.02';
            TableRelation = "Purchase Header"."No." where("Document Type" = CONST("Blanket Order"));
        }
        field(50023; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            Description = 'HEI.03';
            TableRelation = "WHT Business Posting Group FND".Code;
        }
        field(50024; "Actual Vendor No. FND"; Code[20])
        {
            Caption = 'Actual Vendor No.';
            Description = 'HEI.03';
        }
        field(50030; "Maximo Requisition No. FND"; Code[20])
        {
            Caption = 'Maximo Requisition No.';
            Description = 'HEI.04';
            Editable = false;
        }
        field(50041; "Fixed Asset Acquisition FND"; Boolean)
        {
            Caption = 'Fixed Asset Acquisition';
            Description = 'HEI.06';
        }
        // BC Upgrade SHUKLP03 >> Added in the interface ext.

        //BC Upgrade SHARMP16 BEGIN<< ---IBM GAP STP 48
        field(50096; "Created By IBM FND"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = "User Setup";
            Editable = false;
            ValidateTableRelation = true;
        }
        field(50098; "Creation Date/Time IBM FND"; DateTime)
        {
            Caption = 'Creation Date/Time';
            Editable = false;
        }
        field(50099; "Last Changed User ID IBM FND"; Code[50])
        {
            Caption = 'Last Changed User ID';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(50100; "Last Changed Date/Time IBM FND"; DateTime)
        {
            Caption = 'Last Changed Date/Time';
            Editable = false;

        }
        field(50101; "Requester ID IBM FND"; code[50])
        {
            Caption = 'Requester ID IBM';
            TableRelation = "User Setup";
            ValidateTableRelation = true;

        }
        //BC Upgrade SHARMP16 END>> ---IBM GAP STP 48
        // field(50043; "Maximo Status"; Option)
        // {
        //     CalcFormula = Lookup("Purchase Header Archive Addit"."Maximo Status" WHERE("Document Type" = FIELD("Document Type"),
        //                                                                                 "No." = FIELD("No.")));
        //     Caption = 'Maximo Status';
        //     Description = 'HEI.07';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     OptionMembers = " ",Approved,Canceled,Closed,"Waiting on Approval";
        // }
        // BC Upgrade SHUKLP03 << Added in the interface ext.

        field(50044; "Shopping Card No. FND"; Code[10])
        {
            caption = 'Shopping Card No.';
            CalcFormula = Lookup("Purchase Header Additional FND"."Shopping Card No." where("Document Type" = FIELD("Document Type"),
                                                                                         "No." = FIELD("No.")));
            Description = 'HEI.08';
            FieldClass = FlowField;
        }
        // BC Upgrade SHUKLP03 >> Added field.
        field(50090; "Document Subtype Code FND"; Code[10])
        {
            CaptionML = ENU = 'Document Subtype Code',
                        FRA = 'Code Sous-Type Document';
            Description = 'DITW18.00.07 DIT-770 #1508';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = CONST(Purchase));
        }
        // BC Upgrade SHUKLP03 << Added field.

        /* //BC Upgrade Yadavm09 Drink it field commented>>
        field(2013610;"Vendor DDeposit Group Code";Code[10])
        {
            CaptionML = ENU='Customer Deposit Group Code',
                        FRA='Code groupe consigne client';
            Description = 'DITW15.00.00.01';
            TableRelation = "Drink Deposit Group".Code WHERE ("Source Type"=CONST(Vendor));
        }
        field(2013611;"Empty Goods Item No. Filter";Code[20])
        {
            CaptionML = ENU='Empty Goods Item No. Filter',
                        FRA='Filtre article vidange n°';
            Description = 'DITW15.00.00.33-.35';
            FieldClass = FlowFilter;
            TableRelation = Item WHERE ("Empty Good"=CONST(true));
        }
        field(2013613;"Link Purch. Document No.";Code[20])
        {
            CaptionML = ENU='Link Purch. Document No.',
                        FRA='Lien N° document achat';
            Description = 'DITW15.00.00.01';
            TableRelation = "Purchase Header Archive"."No." WHERE ("Document Type"=FIELD("Link Purch. Document Type"));
        }
        field(2013614;"Link Purch. Document Type";Option)
        {
            CaptionML = ENU='Link Purch. Document Type',
                        FRA='Lien type document achat';
            Description = 'DITW15.00.00.01';
            OptionCaptionML = ENU='Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order',
                              FRA='Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2013615;"Print Link Document";Boolean)
        {
            CaptionML = ENU='Print Link Document',
                        FRA='Imprimer lien document';
            Description = 'DITW15.00.00.01';
        }
        field(2013616;"No. of Link Purchase Orders";Integer)
        {
            CalcFormula = Count("Purchase Header Archive" WHERE ("Link Purch. Document Type"=FIELD("Document Type"),
                                                                 "Link Purch. Document No."=FIELD("No.")));
            CaptionML = ENU='No. of Link Purchase Orders',
                        FRA='Nombre de lien commandes achats';
            Description = 'DITW15.00.00.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013630;"Deposit Vendor Posting Group";Code[10])
        {
            CaptionML = ENU='Deposit - Vendor Posting Group',
                        FRA='Consigne - Groupe compta. fournisseur';
            Description = 'DITW16.00.00.42 DIT-715 #370';
            TableRelation = "Vendor Posting Group";
        }
        field(2013631;"Deposit Payment Terms Code";Code[10])
        {
            CaptionML = ENU='Deposit - Payment Terms Code',
                        FRA='Consigne - Code conditions paiement';
            Description = 'DITW16.00.00.42 DIT-715 #370';
            TableRelation = "Payment Terms";
        }
        field(2013632;"Deposit Payment Method Code";Code[10])
        {
            CaptionML = ENU='Deposit - Payment Method Code',
                        FRA='Consigne - Code mode de règlement';
            Description = 'DITW16.00.00.42 DIT-715 #370';
            TableRelation = "Payment Method";
        }
        field(2013633;"Deposit Bal. Account Type";Option)
        {
            CaptionML = ENU='Deposit - Bal. Account Type',
                        FRA='Consigne - Type Compte Contrepartie';
            Description = 'DITW16.00.00.42 DIT-715 #370';
            OptionCaptionML = ENU='G/L Account,Bank Account',
                              FRA='Général,Banque';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(2013634;"Deposit Bal. Account No.";Code[20])
        {
            CaptionML = ENU='Deposit - Bal. Account No.',
                        FRA='Consigne - N° compte contrepartie';
            Description = 'DITW16.00.00.42 DIT-715 #370';
            TableRelation = IF ("Deposit Bal. Account Type"=CONST("G/L Account")) "G/L Account"
                            else IF ("Deposit Bal. Account Type"=CONST("Bank Account")) "Bank Account";
        }
        field(2013638;"Deposit Posting No.";Code[20])
        {
            CaptionML = ENU='Deposit Posting No.',
                        FRA='N° facture consigne';
            Description = 'DITW16.00.00.42 DIT-715 #370';
            Editable = false;
            TableRelation = Table0;
        }
        field(2013639;"Last Deposit Posting No.";Code[20])
        {
            CaptionML = ENU='Last Deposit Posting No.',
                        FRA='N° dern. facture consigne';
            Description = 'DITW16.00.00.42 DIT-715 #370';
            Editable = false;
            TableRelation = Table0;
        }
        field(2013666;"Autom. Item Charge";Option)
        {
            CaptionML = ENU='Calculate Item Charges',
                        FRA='Calculer Frais annexes';
            Description = 'DITW15.00.00.39 #1407';
            OptionCaptionML = ENU='Direct,Release,Posting,Posting (Excl. Item)',
                              FRA='Direct,Lancé,Validation,Validation (Excl. Article)';
            OptionMembers = " ",Release,Posting,PostingExclItem;
        }
        field(2013667;"Vendor DTax Group Code";Code[10])
        {
            CaptionML = ENU='Vendor Tax Group Code',
                        FRA='Code groupe taxe fournisseur';
            Description = 'DITW15.00.00.01';
            TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Vendor));
        }
        field(2013695;"Item Charge Type Filter";Option)
        {
            CaptionML = ENU='Item Charge Type Filter',
                        FRA='Filtre type frais article';
            Description = 'DITW15.00.00.01';
            FieldClass = FlowFilter;
            OptionCaptionML = ENU=' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
                              FRA=' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
            OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        }
        field(2013726;"Vendor Tax Registration No.";Text[20])
        {
            CaptionML = ENU='Vendor Tax Registration No.',
                        FRA='N° ident. accise fournisseur';
            Description = 'DITW15.00.00.28';
        }
        field(2013730;"Fiscal Representative No.";Code[20])
        {
            CaptionML = ENU='Fiscal Representative / Customs Agent No.',
                        FRA='N° représentant fiscal / Agent des douanes';
            Description = 'DITW15.00.00.28-.38 #1217';
            TableRelation = "Fiscal Representative";
        }
        field(2013733;"Tax Date";Date)
        {
            CaptionML = ENU='Tax Date',
                        FRA='Date taxe';
            Description = 'DITW15.00.00.39 #1363';
        }
        field(2013797;"Disc.Promo. Order Calculated";Boolean)
        {
            CaptionML = ENU='Disc.Promo. Order Calculated',
                        FRA='Remise-Promotion cmde. calculé';
            Description = 'DITW15.00.00.24';
        }
        field(2013823;"Gen. Bus. Posting Free Group";Code[10])
        {
            CaptionML = ENU='Gen. Bus. Posting Group Free item',
                        FRA='Groupe article gratuit compta. marché';
            Description = 'DITW15.00.00.35';
            TableRelation = "Gen. Business Posting Group";
        }
        field(2013825;"Free Item Posting Type";Option)
        {
            CaptionML = ENU='Calculate Price on Free',
                        FRA='Calculer Prix sur gratuit';
            Description = 'DITW15.00.00.35';
            OptionCaptionML = ENU=' ,Price 0,Discount 100%',
                              FRA=' ,Prix 0,Remise 100%';
            OptionMembers = " ",Price,Amount;
        }
        field(2014060;"Maximum Weight";Decimal)
        {
            BlankZero = true;
            CaptionML = ENU='Maximum Weight',
                        FRA='Poids maximum';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.21';
            MinValue = 0;
        }
        field(2014061;"Maximum Cubage";Decimal)
        {
            BlankZero = true;
            CaptionML = ENU='Maximum Volume (Cubage)',
                        FRA='Volume (Cubage) maximum';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.21';
            MinValue = 0;
        }
        field(2014064;"Shipping Charge Per";Option)
        {
            CaptionML = ENU='Shipping Charge Per',
                        FRA='Frais transport par';
            Description = 'DITW15.00.00.21';
            OptionCaptionML = ENU='Shipment,Weight,Volume',
                              FRA='Expédition,Poids,Volume';
            OptionMembers = Shipment,Weight,Volume;
        }
        field(2014067;"Total Weight";Decimal)
        {
            CalcFormula = Sum("Purchase Line Archive".Weight WHERE ("Document Type"=FIELD("Document Type"),
                                                                    "Document No."=FIELD("No.")));
            CaptionML = ENU='Total Weight',
                        FRA='Poids total';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.21';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014068;"Total Cubage";Decimal)
        {
            CalcFormula = Sum("Purchase Line Archive".Cubage WHERE ("Document Type"=FIELD("Document Type"),
                                                                    "Document No."=FIELD("No.")));
            CaptionML = ENU='Total Volume (Cubage)',
                        FRA='Volume (Cubage) total';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.21';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014075;"Shipping Agent Code";Code[10])
        {
            CaptionML = ENU='Shipping Agent Code',
                        FRA='Code transporteur';
            Description = 'DITW15.00.00.21';
            TableRelation = "Shipping Agent";
        }
        field(2014076;"Shipping Agent Service Code";Code[10])
        {
            CaptionML = ENU='Shipping Agent Service Code',
                        FRA='Code prestation transporteur';
            Description = 'DITW15.00.00.21';
            TableRelation = "Shipping Agent Services".Code WHERE ("Shipping Agent Code"=FIELD("Shipping Agent Code"));
        }
        field(2014077;"Truck Code";Code[10])
        {
            CaptionML = ENU='Truck Code',
                        FRA='Code camion';
            Description = 'DITW15.00.00.25';
            TableRelation = "Whse. Shipping Truck";
        }
        field(2014078;"Driver Code";Code[10])
        {
            CaptionML = ENU='Driver Code',
                        FRA='Code chauffeur';
            Description = 'DITW15.00.00.25';
            TableRelation = "Whse. Shipping Driver";
        }
        field(2014080;"Vendor Delivery Type";Code[10])
        {
            CaptionML = ENU='Vendor Delivery Type',
                        FRA='Type Livraison Fournisseur';
            Description = 'DITW18.00.07 DIT-770 #1346';
            TableRelation = "Delivery Type".Code WHERE (Type=CONST(Vendor));
        }
        field(2014087;Distance;Decimal)
        {
            CaptionML = ENU='Distance',
                        FRA='Distance';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.24';
            MinValue = 0;
        }
        field(2014103;"Whse. Receipt No. (First)";Code[20])
        {
            CalcFormula = Min("Warehouse Receipt Line"."No." WHERE ("Source Type"=CONST(39),
                                                                    "Source Subtype"=CONST("1"),
                                                                    "Source No."=FIELD("No.")));
            CaptionML = ENU='Whse. Receipt No. (First)',
                        FRA='N° réception magasin (Premier)';
            Description = 'DITW15.00.00.39 #1399';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Warehouse Receipt Header";
        }
        field(2014104;"Whse. Receipt Status (First)";Option)
        {
            CalcFormula = Lookup("Warehouse Receipt Header"."Document Status" WHERE ("No."=FIELD("Whse. Receipt No. (First)")));
            CaptionML = ENU='Whse. Receipt Status (First)',
                        FRA='Status réception magasin (Premier)';
            Description = 'DITW15.00.00.39 #1399';
            Editable = false;
            FieldClass = FlowField;
            OptionCaptionML = ENU=' ,Partially Received,Completely Received',
                              FRA=' ,Partiellement réceptionné,Entièrement réceptionné';
            OptionMembers = " ","Partially Received","Completely Received";
        }
        field(2014271;"Vendor Tax Warehouse Ref.";Text[20])
        {
            CaptionML = ENU='Vendor Tax Warehouse Reference',
                        FRA='Entrepôt fiscal de référence fournisseur';
            Description = 'DITW15.00.00.38 #1217';
        }
        field(2014277;"Transport Mode";Option)
        {
            CalcFormula = Lookup("Transport Method"."Transport Mode" WHERE (Code=FIELD("Transport Method")));
            CaptionML = ENU='Transport Mode (EMCS)',
                        FRA='Mode de transport (EMCS)';
            Description = 'DITW16.00.00.40 DIT715 #187';
            Editable = false;
            FieldClass = FlowField;
            OptionCaptionML = ENU='Other,Sea,Rail,Road,Air,Post,N/A,Fixed,Waterway',
                              FRA='Autre,Mer,Chemin de fer,Route,Air,Poste,N/C,Installation de transport fixes,Transport par voies navigables';
            OptionMembers = Other,Sea,Rail,Road,Air,Post,"N/A","Fixed",Waterway;
        }
        field(2014290;"Journey Time";DateFormula)
        {
            CaptionML = ENU='Journey Time (EMCS)',
                        FRA='Temps de trajet (EMCS)';
            Description = 'DITW15.00.00.39 #1353';
        }
        field(2014291;"Transport Mode Comment";Boolean)
        {
            CalcFormula = Exist("EMCS Comment Line" WHERE ("Table ID"=CONST(38),
                                                           "Document Type"=CONST(1),
                                                           "Document No."=FIELD("No."),
                                                           "Document Line No."=CONST(0),
                                                           "Field ID"=CONST(2014277)));
            CaptionML = ENU='Transport Mode Comment',
                        FRA='Commentaires Mode de transport';
            Description = 'DITW16.00.00.40 DIT715 #187';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014300;"Submission Type";Option)
        {
            CaptionML = ENU='Submission Type  (EMCS)',
                        FRA='Type de Message (EMCS)';
            Description = 'DITW18.00.07 DIT-770 #1397';
            OptionCaptionML = ENU=' ,Type 1,Type 2',
                              FRA=' ,Type 1,Type 2';
            OptionMembers = " ","Type 1","Type 2";
        }
        field(2014313;"Financial Contract No.";Code[20])
        {
            CaptionML = ENU='Financial Contract No.',
                        FRA='N° Contrat Financier';
            Description = 'DITW18.00.06 DIT-770 #1368';
        }
        field(2014410;"Physical Location Group Code";Code[10])
        {
            CaptionML = ENU='Physical Location Group Code',
                        FRA='Code groupe magasin réel';
            Description = 'DITW18.00.06 DIT-770 #1191';
            TableRelation = "Physical Location Group" WHERE (Code=FIELD("Phys. Location Table Filter"));

            trigger OnValidate();
            var
                PhysLocationGr : Record "Physical Location Group";
            begin
            end;
        }
        field(2014411;"Creation Date/Time";DateTime)
        {
            CaptionML = ENU='Creation Date/Time',
                        FRA='Date/Heure Création';
            Description = 'DITW18.00.07 DIT-770 #1282';
            Editable = false;
        }
        field(2014412;"Created By";Code[50])
        {
            CaptionML = ENU='Created By',
                        FRA='Créé par';
            Description = 'DITW18.00.07 DIT-770 #1282';
            Editable = false;
            TableRelation = "User Setup";
        }
        field(2014420;"Sundry Vendor";Boolean)
        {
            CaptionML = ENU='Sundry Vendor',
                        FRA='Fournisseur Divers';
            Description = 'DITW18.00.07 DIT-770 #1804';
        }
        field(2014421;"Document Subtype Code";Code[10])
        {
            CaptionML = ENU='Document Subtype Code',
                        FRA='Code Sous-Type Document';
            Description = 'DITW18.00.07 DIT-770 #1508';
            TableRelation = "Document Subtype Code FND".Code WHERE ("Report Selection Type"=CONST(Purchase));
        }
        field(2014426;"Service Order No.";Code[20])
        {
            CaptionML = ENU='Service Order No.',
                        FRA='N° commande de service';
            Description = 'DITW15.00.00.39 #1403 - DIT-715 #297';
            Editable = false;
            TableRelation = "Service Header"."No." WHERE ("Document Type"=CONST(Order));
        }
        field(2014430;"Requester ID";Code[50])
        {
            CaptionML = ENU='Requester ID',
                        FRA='ID demandeur';
            Description = 'DITW17.00.02 DIT-770 #144';
            TableRelation = "User Setup";
        }
        field(2014460;"Tax Office Code";Code[10])
        {
            CaptionML = ENU='Tax Office Code',
                        FRA='Code Bureau de taxe';
            Description = 'DITW15.00.00.38 #1217';
            TableRelation = "Tax Office";
        }
        field(2014495;"Delivery Sequence";Integer)
        {
            BlankZero = true;
            CaptionML = ENU='Delivery Sequence',
                        FRA='Séquence de livraison';
            Description = 'DITW16.00.00.40 #1002';
            MinValue = 0;
        }
        field(2014500;"Resp. Center Table Filter";Code[10])
        {
            CaptionML = ENU='Resp. Center Table Filter',
                        FRA='Filtre Centre de gestion (table)';
            Description = 'DITW18.00.06 DIT-770 #1191';
            FieldClass = FlowFilter;
            TableRelation = "Responsibility Center";
        }
        field(2014501;"Phys. Location Table Filter";Code[10])
        {
            CaptionML = ENU='Phys. Location Table Filter',
                        FRA='Filtre groupe magasin réel (table)';
            Description = 'DITW18.00.06 DIT-770 #1191';
            FieldClass = FlowFilter;
            TableRelation = "Physical Location Group";
        }
        field(2014502;"Location Table Filter";Code[10])
        {
            CaptionML = ENU='Location Table Filter',
                        FRA='Filtre Magasin (table)';
            Description = 'DITW18.00.06 DIT-770 #1191';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(2014503;"Resp. Center Table Filter 2";Code[10])
        {
            CaptionML = ENU='Resp. Center Table Filter',
                        FRA='Filtre Centre de gestion (table)';
            Description = ' DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214';
            FieldClass = FlowFilter;
            TableRelation = "Responsibility Center";
        }
        field(2029611;"Doc. Amount Incl. VAT";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU='Doc. Amount Incl. VAT',
                        FRA='Montant doc. TTC';
            Description = 'FINXL7.00.001';
        }
        field(2029612;"Doc. Amount VAT";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU='Doc. Amount VAT',
                        FRA='Montant TVA doc.';
            Description = 'FINXL7.00.001';
        }
        field(2029613;"Approved Amount";Decimal)
        {
            CaptionML = ENU='Approved Amount',
                        FRA='Montant Approuvé';
            Description = 'FINXL7.00.001';
        }
        field(2034850;"DIT Sub-Contract Type";Option)
        {
            CaptionML = ENU='Sub Contract Type',
                        FRA='Sous type contrat';
            Description = 'DIT-715 #392';
            OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
                              FRA=' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
            OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        }
        field(2034872;"Contract Group Code";Code[10])
        {
            CaptionML = ENU='Contract Group Code',
                        FRA='Code groupe contrat';
            Description = 'DIT-715 #392';
            TableRelation = IF ("Contract Type"=CONST(Service)) "Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"))
                            else IF ("Contract Type"=CONST(Financial)) "Financial Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
        }
        field(2034915;"Service Contract No.";Code[20])
        {
            CaptionML = ENU='Service Contract No.',
                        FRA='N° contrat de service';
            Description = 'DIT-715 #392 - DITW18.00.06 DIT-770 #1368';

            trigger OnValidate();
            var
                FA2 : Record "Fixed Asset";
            begin
            end;
        }
        field(2035390;"Linked Customer No.";Code[20])
        {
            CaptionML = ENU='Linked Customer No.',
                        FRA='N° Cilent Lié';
            Description = 'DITW17.00.02 DIT-770 #153';
            TableRelation = Customer."No.";
        }
        field(2035393;"Contract Type";Option)
        {
            CaptionML = ENU='Contract Type',
                        FRA='Type contrat';
            Description = 'DIT-715 #392 - DIT-770 #690 - DIT-770 #1368';
            OptionCaptionML = ENU=' ,Service,Financial',
                              FRA=' ,Service,Financier';
            OptionMembers = " ",Service,Financial;
        }
        field(2036301;"Valid Until";Date)
        {
            CaptionML = ENU='Valid Until',
                        FRA='Valide jusqu''au';
            Description = 'MANXL7.00.001';
        }
        */ //BC Upgrade Yadavm09 Drink it field commented>>
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

