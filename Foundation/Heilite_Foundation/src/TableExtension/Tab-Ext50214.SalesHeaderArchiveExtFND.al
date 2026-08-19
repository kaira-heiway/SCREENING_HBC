tableextension 50214 SalesHeaderArchiveExtFND extends "Sales Header Archive"
{
    // version NAVW110.0,DITW110.00.08,HEI.01
    //   DITW15.00.00.01 DDR 31/01/2008 Added Drink-it Reversing Calculation (Rounding) functionnalities
    //                                  Added fields
    //                                     2013610 Customer DDeposit Group Code
    //                                     2034647 Customer DTax Group Code
    //                                     2034690 Price Incl. Reversing Calc.
    //   DITW15.00.00.01 DDR 27/02/2008 Remove field (see lines)
    //                                    2034690 Price Incl. Reversing Calc.
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.20 DDR 11/06/2008 Certification rules
    //   DITW15.00.00.24 DDR 07/10/2008 Added fields
    //                                    2013722 Duty Tax Type
    //   DITW15.00.00.25 DDR 21/10/2008 Deleted fields
    //                                    2013722 Duty Tax Type
    //   DITW15.00.00.33 DDR 08/05/2009 Added fields
    //                                    2013611 Empty Goods Item No. Filter
    //                                    2013613 Link Sales Document No.
    //                                    2013614 Link Sales Document Type
    //                                    2013615 Print Link Document
    //                                    2013616 No. of Link Sales Orders
    //                                    2013695 Item Charge Type Filter
    //                                    2013726 Customer Tax Registration No.
    //                                    2013730 Fiscal Representative No.
    //                                    2013797 Disc.Promo. Order Calculated
    //                                    2014060 Maximum Weight
    //                                    2014061 Maximum Cubage
    //                                    2014064 Shipping Charge Per
    //                                    2014067 Total Weight
    //                                    2014068 Total Cubage
    //                                    2014077 Truck Code
    //                                    2014078 Driver Code
    //                                    2014087 Distance
    //   DITW15.00.00.35 DDR 25/06/2009 Added fields
    //                                    2013824 Gen. Bus. Posting Free Group
    //                       13/10/2009 issue 722 Updated Filters - TableRelation property field "Empty Goods Item No. Filter"
    //                                  Added fields
    //                                    2034840 Building No.
    //                                  Added Test status open for fields
    //                                          Customer DDeposit Group Code,Customer DTax Group Cod
    //   DITW15.00.00.37 DDR 04/02/2010 issue 1033 Convert field2013797 Disc.Promo. Order Calculated into flowfield based on lines
    //   DITW15.00.00.38 DDR 13/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                    Added fields
    //                                      2014271 Tax Warehouse Reference
    //                       27/01/2011 issue 1217 (DIT711 137)
    //                                    Modified Caption field2013730 "Fiscal Representative No."
    //                                    Added fields
    //                                      2014460 Tax Office Code
    //   DITW15.00.00.39 DDR 06/07/2011 issue 1353 Added fields
    //                                     2014290 Journey Time
    //                       04/08/2011 issue 1353 Modified caption field2014290 "Journey Time"
    //                       19/08/2011 issue 1363
    //                                    Added fields
    //                                      2013733 Tax Date
    //   DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields
    //                                     2014107 Route
    //   DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field 2014420 "Sundry Customer"
    //   DITW18.00.07 MVN 24/02/2016 DIT-770 #1397 Added all missing DIT Fields
    //   DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field 2014421 "Document Subtype Code"
    //   DITW18.00.07 AKH 21/04/2016 DIT-770 #1508 Adjusted TableRelation for field "Document Subtype Code"
    //   DITW18.00.07 AKH 27/04/2016 DIT-770 #1346 Added field 2014080 "Customer Delivery Type"
    //   DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    //   DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time", "Created By"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.08 DDR 16/02/2017 NRQ#20755 Update document subtype code table relation filter
    //   HEI.01 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //     # New fields for MDM integration
    //   HEI.02 FDD-SLSGAP001 IBM NASTAA02 07.09.2017 # MDM Customer Card
    //     # Increased "Bill-to Address", "Sell-to Address" and "Ship-to Address" fields length from 50 to 60 characters
    //     # Increased "Bill-to City", "Sell-to City" and "Ship-to City" fields length from 30 to 35 characters
    //   HEI.03 FDD-SLSGAP001 IBM NASTAA02 19.09.2017 # MDM Customer Card
    //     # Increased "Customer DTax Group Code" field length from 10 to 20 characters
    //   HEI.05 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    //   HEI.06 FDD-HT657 IBM NASTAA02 15.11.2019 # Ethiopia Intercompany Automation
    //     # New Field created: 50041 - Special Order
    //   HEI.08 CHG2065153 IBM KUMARN15 23.06.2020
    //     # Added field "Source System Identifier" and "Order Id"
    //   HEI.09 INC2924918 IBM NASTAA02 01.07.2020 # Your reference field in Sales Return Order should be 50 Characters
    //     # Increased length of Field 11 - Your Reference from 35 to 50 characters

    //   BC Upgrade KUMARS145 Table Ext creatd
    //   BC Upgrade KUMARS145 Trigger change commented dependent on Drinkit "Customer DTax Group Code". 
    //   BC Upgrade KUMARS145 Bill-to Address is having the text length of 100 which was 60 in Nav.
    //   BC Upgrade KUMARS145 Bill-to Address 2 we can't change the character length in BC.
    //   BC Upgrade KUMARS145 Ship-to Address is having the text length of 100 which was 60 in Nav.
    //   BC Upgrade KUMARS145 Ship-to Address 2 we can't change the character length in BC.
    //   BC Upgrade KUMARS145 Sell-to Address is having the text length of 100 which was 60 in Nav.
    //   BC Upgrade KUMARS145 Sell-to Address 2 we can't change the character length in BC.
    //   BC Upgrade KUMARS145 Requested field length changes (Bill-to City, DTax Group Code, Your Reference) are NOT implemented. 

    // BC Upgrade SHUKLP03 >> Added field 50090 for Document Subtype Code.


    // version NAVW110.0,DITW110.00.08,HEI.01
    //   DITW15.00.00.01 DDR 31/01/2008 Added Drink-it Reversing Calculation (Rounding) functionnalities
    //                                  Added fields
    //                                     2013610 Customer DDeposit Group Code
    //                                     2034647 Customer DTax Group Code
    //                                     2034690 Price Incl. Reversing Calc.
    //   DITW15.00.00.01 DDR 27/02/2008 Remove field (see lines)
    //                                    2034690 Price Incl. Reversing Calc.
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.20 DDR 11/06/2008 Certification rules
    //   DITW15.00.00.24 DDR 07/10/2008 Added fields
    //                                    2013722 Duty Tax Type
    //   DITW15.00.00.25 DDR 21/10/2008 Deleted fields
    //                                    2013722 Duty Tax Type
    //   DITW15.00.00.33 DDR 08/05/2009 Added fields
    //                                    2013611 Empty Goods Item No. Filter
    //                                    2013613 Link Sales Document No.
    //                                    2013614 Link Sales Document Type
    //                                    2013615 Print Link Document
    //                                    2013616 No. of Link Sales Orders
    //                                    2013695 Item Charge Type Filter
    //                                    2013726 Customer Tax Registration No.
    //                                    2013730 Fiscal Representative No.
    //                                    2013797 Disc.Promo. Order Calculated
    //                                    2014060 Maximum Weight
    //                                    2014061 Maximum Cubage
    //                                    2014064 Shipping Charge Per
    //                                    2014067 Total Weight
    //                                    2014068 Total Cubage
    //                                    2014077 Truck Code
    //                                    2014078 Driver Code
    //                                    2014087 Distance
    //   DITW15.00.00.35 DDR 25/06/2009 Added fields
    //                                    2013824 Gen. Bus. Posting Free Group
    //                       13/10/2009 issue 722 Updated Filters - TableRelation property field "Empty Goods Item No. Filter"
    //                                  Added fields
    //                                    2034840 Building No.
    //                                  Added Test status open for fields
    //                                          Customer DDeposit Group Code,Customer DTax Group Cod
    //   DITW15.00.00.37 DDR 04/02/2010 issue 1033 Convert field2013797 Disc.Promo. Order Calculated into flowfield based on lines
    //   DITW15.00.00.38 DDR 13/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                    Added fields
    //                                      2014271 Tax Warehouse Reference
    //                       27/01/2011 issue 1217 (DIT711 137)
    //                                    Modified Caption field2013730 "Fiscal Representative No."
    //                                    Added fields
    //                                      2014460 Tax Office Code
    //   DITW15.00.00.39 DDR 06/07/2011 issue 1353 Added fields
    //                                     2014290 Journey Time
    //                       04/08/2011 issue 1353 Modified caption field2014290 "Journey Time"
    //                       19/08/2011 issue 1363
    //                                    Added fields
    //                                      2013733 Tax Date
    //   DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields
    //                                     2014107 Route
    //   DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field 2014420 "Sundry Customer"
    //   DITW18.00.07 MVN 24/02/2016 DIT-770 #1397 Added all missing DIT Fields
    //   DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field 2014421 "Document Subtype Code"
    //   DITW18.00.07 AKH 21/04/2016 DIT-770 #1508 Adjusted TableRelation for field "Document Subtype Code"
    //   DITW18.00.07 AKH 27/04/2016 DIT-770 #1346 Added field 2014080 "Customer Delivery Type"
    //   DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    //   DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time", "Created By"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.08 DDR 16/02/2017 NRQ#20755 Update document subtype code table relation filter
    //   HEI.01 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //     # New fields for MDM integration
    //   HEI.02 FDD-SLSGAP001 IBM NASTAA02 07.09.2017 # MDM Customer Card
    //     # Increased "Bill-to Address", "Sell-to Address" and "Ship-to Address" fields length from 50 to 60 characters
    //     # Increased "Bill-to City", "Sell-to City" and "Ship-to City" fields length from 30 to 35 characters
    //   HEI.03 FDD-SLSGAP001 IBM NASTAA02 19.09.2017 # MDM Customer Card
    //     # Increased "Customer DTax Group Code" field length from 10 to 20 characters
    //   HEI.05 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    //   HEI.06 FDD-HT657 IBM NASTAA02 15.11.2019 # Ethiopia Intercompany Automation
    //     # New Field created: 50041 - Special Order
    //   HEI.08 CHG2065153 IBM KUMARN15 23.06.2020
    //     # Added field "Source System Identifier" and "Order Id"
    //   HEI.09 INC2924918 IBM NASTAA02 01.07.2020 # Your reference field in Sales Return Order should be 50 Characters
    //     # Increased length of Field 11 - Your Reference from 35 to 50 characters

    //   BC Upgrade KUMARS145 Table Ext creatd
    //   BC Upgrade KUMARS145 Trigger change commented dependent on Drinkit "Customer DTax Group Code". 
    //   BC Upgrade KUMARS145 Bill-to Address is having the text length of 100 which was 60 in Nav.
    //   BC Upgrade KUMARS145 Bill-to Address 2 we can't change the character length in BC.
    //   BC Upgrade KUMARS145 Ship-to Address is having the text length of 100 which was 60 in Nav.
    //   BC Upgrade KUMARS145 Ship-to Address 2 we can't change the character length in BC.
    //   BC Upgrade KUMARS145 Sell-to Address is having the text length of 100 which was 60 in Nav.
    //   BC Upgrade KUMARS145 Sell-to Address 2 we can't change the character length in BC.
    //   BC Upgrade KUMARS145 Requested field length changes (Bill-to City, DTax Group Code, Your Reference) are NOT implemented. 


    fields
    {
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            // OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order', FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
        }
        modify("Sell-to Customer No.")
        {
            CaptionML = ENU = 'Sell-to Customer No.', FRA = 'N° donneur d''ordre';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Bill-to Customer No.")
        {
            CaptionML = ENU = 'Bill-to Customer No.', FRA = 'N° client facturé';
        }
        modify("Bill-to Name")
        {
            CaptionML = ENU = 'Bill-to Name', FRA = 'Nom';
        }
        modify("Bill-to Name 2")
        {
            CaptionML = ENU = 'Bill-to Name 2', FRA = 'Nom 2';
        }
        modify("Bill-to Address")
        {
            //Unsupported feature: Change Data type on ""Bill-to Address"(Field 7)". Please convert manually.
            CaptionML = ENU = 'Bill-to Address', FRA = 'Adresse facturation';
            //Unsupported feature: Change Description on ""Bill-to Address"(Field 7)". Please convert manually.
        }
        modify("Bill-to Address 2")
        {
            //Unsupported feature: Change Data type on ""Bill-to Address 2"(Field 8)". Please convert manually.
            CaptionML = ENU = 'Bill-to Address 2', FRA = 'Adresse (2ème ligne)';
            //Unsupported feature: Change Description on ""Bill-to Address 2"(Field 8)". Please convert manually.
        }
        modify("Bill-to City")
        {
            //Unsupported feature: Change Data type on ""Bill-to City"(Field 9)". Please convert manually.
            CaptionML = ENU = 'Bill-to City', FRA = 'Ville';
            //Unsupported feature: Change Description on ""Bill-to City"(Field 9)". Please convert manually.
        }
        modify("Bill-to Contact")
        {
            CaptionML = ENU = 'Bill-to Contact', FRA = 'Contact';
        }
        modify("Your Reference")
        {
            //Unsupported feature: Change Data type on ""Your Reference"(Field 11)". Please convert manually.
            CaptionML = ENU = 'Your Reference', FRA = 'Votre référence';
            //Unsupported feature: Change Description on ""Your Reference"(Field 11)". Please convert manually.
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
        modify("Shipment Date")
        {
            CaptionML = ENU = 'Shipment Date', FRA = 'Date d''expédition';
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
        modify("Customer Posting Group")
        {
            CaptionML = ENU = 'Customer Posting Group', FRA = 'Groupe compta. client';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Currency Factor")
        {
            CaptionML = ENU = 'Currency Factor', FRA = 'Facteur devise';
        }
        modify("Price Group Code")
        {
            CaptionML = ENU = 'Price Group Code', FRA = 'Code tarif';
        }
        modify("Prices Including VAT")
        {
            CaptionML = ENU = 'Prices Including VAT', FRA = 'Prix TTC';
        }
        modify("Invoice Disc. Code")
        {
            CaptionML = ENU = 'Invoice Disc. Code', FRA = 'Code remise facture';
        }
        modify("Cust./Item Disc. Gr.")
        {
            CaptionML = ENU = 'Cust./Item Disc. Gr.', FRA = 'Groupe rem. client/article';
        }
        modify("Language Code")
        {
            CaptionML = ENU = 'Language Code', FRA = 'Code langue';
        }
        modify("Salesperson Code")
        {
            CaptionML = ENU = 'Salesperson Code', FRA = 'Code vendeur';
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
        modify(Ship)
        {
            CaptionML = ENU = 'Ship', FRA = 'Expédier';
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
        modify("Shipping No.")
        {
            CaptionML = ENU = 'Shipping No.', FRA = 'Utiliser B.L. N°';
        }
        modify("Posting No.")
        {
            CaptionML = ENU = 'Posting No.', FRA = 'N° validation';
        }
        modify("Last Shipping No.")
        {
            CaptionML = ENU = 'Last Shipping No.', FRA = 'N° dern. bon de livraison';
        }
        modify("Last Posting No.")
        {
            CaptionML = ENU = 'Last Posting No.', FRA = 'N° dern. facture';
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
        modify("VAT Registration No.")
        {
            CaptionML = ENU = 'VAT Registration No.', FRA = 'N° identif. intracomm.';
        }
        modify("Combine Shipments")
        {
            CaptionML = ENU = 'Combine Shipments', FRA = 'Regrouper les B.L.';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("EU 3-Party Trade")
        {
            CaptionML = ENU = 'EU 3-Party Trade', FRA = 'Trans. tripartite UE';
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
        modify("Sell-to Customer Name")
        {
            CaptionML = ENU = 'Sell-to Customer Name', FRA = 'Nom du donneur d''ordre';
        }
        modify("Sell-to Customer Name 2")
        {
            CaptionML = ENU = 'Sell-to Customer Name 2', FRA = 'Nom du donneur d''ordre 2';
        }
        modify("Sell-to Address")
        {
            //Unsupported feature: Change Data type on ""Sell-to Address"(Field 81)". Please convert manually.
            CaptionML = ENU = 'Sell-to Address', FRA = 'Adresse donneur d''ordre';
            //Unsupported feature: Change Description on ""Sell-to Address"(Field 81)". Please convert manually.
        }
        modify("Sell-to Address 2")
        {
            //Unsupported feature: Change Data type on ""Sell-to Address 2"(Field 82)". Please convert manually.
            CaptionML = ENU = 'Sell-to Address 2', FRA = 'Adresse donneur d''ordre 2';
            //Unsupported feature: Change Description on ""Sell-to Address 2"(Field 82)". Please convert manually.
        }
        modify("Sell-to City")
        {
            //Unsupported feature: Change Data type on ""Sell-to City"(Field 83)". Please convert manually.
            CaptionML = ENU = 'Sell-to City', FRA = 'Ville donneur d''ordre';
            //Unsupported feature: Change Description on ""Sell-to City"(Field 83)". Please convert manually.
        }
        modify("Sell-to Contact")
        {
            CaptionML = ENU = 'Sell-to Contact', FRA = 'Contact donneur d''ordre';
        }
        modify("Bill-to Post Code")
        {
            CaptionML = ENU = 'Bill-to Post Code', FRA = 'Code postal';
        }
        modify("Bill-to County")
        {
            CaptionML = ENU = 'Bill-to County', FRA = 'Région';
        }
        modify("Bill-to Country/Region Code")
        {
            CaptionML = ENU = 'Bill-to Country/Region Code', FRA = 'Code pays/région facturation';
        }
        modify("Sell-to Post Code")
        {
            CaptionML = ENU = 'Sell-to Post Code', FRA = 'Code postal donneur d''ordre';
        }
        modify("Sell-to County")
        {
            CaptionML = ENU = 'Sell-to County', FRA = 'Région donneur d''ordre';
        }
        modify("Sell-to Country/Region Code")
        {
            CaptionML = ENU = 'Sell-to Country/Region Code', FRA = 'Code pays/région donneur d''ordre';
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
            //OptionCaptionML = ENU = 'G/L Account,Bank Account', FRA = 'Général,Banque';
        }
        modify("Exit Point")
        {
            CaptionML = ENU = 'Exit Point', FRA = 'Pays destination';
        }
        modify(Correction)
        {
            CaptionML = ENU = 'Correction', FRA = 'Correction';
        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
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
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("Package Tracking No.")
        {
            CaptionML = ENU = 'Package Tracking No.', FRA = 'N° récépissé';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Posting No. Series")
        {
            CaptionML = ENU = 'Posting No. Series', FRA = 'Souches de n° validation';
        }
        modify("Shipping No. Series")
        {
            CaptionML = ENU = 'Shipping No. Series', FRA = 'Souche de n° expédition';
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
        modify(Reserve)
        {
            CaptionML = ENU = 'Reserve', FRA = 'Réserver';
            // OptionCaptionML = ENU = 'Never,Optional,Always', FRA = 'Jamais,Manuel,Toujours';
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
            //OptionCaptionML = ENU = 'New,Pending,Sent', FRA = 'Nouveau,Suspendu,Envoyé';
        }
        modify("Sell-to IC Partner Code")
        {
            CaptionML = ENU = 'Sell-to IC Partner Code', FRA = 'Code parten IC donneur d''ordre';
        }
        modify("Bill-to IC Partner Code")
        {
            CaptionML = ENU = 'Bill-to IC Partner Code', FRA = 'Code du partenaire IC facturé';
        }
        modify("IC Direction")
        {
            CaptionML = ENU = 'IC Direction', FRA = 'Direction IC';
            //OptionCaptionML = ENU = 'Outgoing,Incoming', FRA = 'Sortant,Entrant';
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
        modify("Sales Quote No.")
        {
            CaptionML = ENU = 'Sales Quote No.', FRA = 'N° devis';
        }
        modify("Work Description")
        {
            CaptionML = ENU = 'Work Description', FRA = 'Description du travail';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        // modify("Credit Card No.")
        // {
        //     CaptionML = ENU = 'Credit Card No.', FRA = 'N° de carte de crédit';
        // }
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
        // modify("Sell-to Customer Template Code")
        // {
        //     CaptionML = ENU = 'Sell-to Customer Template Code', FRA = 'Code modèle donneur d''ordre';
        // }
        modify("Sell-to Contact No.")
        {
            CaptionML = ENU = 'Sell-to Contact No.', FRA = 'N° contact donneur d''ordre';
        }
        modify("Bill-to Contact No.")
        {
            CaptionML = ENU = 'Bill-to Contact No.', FRA = 'N° contact';
        }
        // modify("Bill-to Customer Template Code")
        // {
        //     CaptionML = ENU = 'Bill-to Customer Template Code', FRA = 'Code modèle client facturé';
        // }
        modify("Opportunity No.")
        {
            CaptionML = ENU = 'Opportunity No.', FRA = 'N° opportunité';
        }
        modify("Responsibility Center")
        {
            CaptionML = ENU = 'Responsibility Center', FRA = 'Centre de gestion';
        }
        modify("Shipping Advice")
        {
            CaptionML = ENU = 'Shipping Advice', FRA = 'Option d''expédition';
            // OptionCaptionML = ENU = 'Partial,Complete', FRA = 'Partielle,Totale';
        }
        modify("Completely Shipped")
        {
            CaptionML = ENU = 'Completely Shipped', FRA = 'Entièrement expédiée';
        }
        modify("Posting from Whse. Ref.")
        {
            CaptionML = ENU = 'Posting from Whse. Ref.', FRA = 'Validation à partir réf. entrepôt';
        }
        modify("Location Filter")
        {
            CaptionML = ENU = 'Location Filter', FRA = 'Filtre magasin';
        }
        modify("Requested Delivery Date")
        {
            CaptionML = ENU = 'Requested Delivery Date', FRA = 'Date livraison demandée';
        }
        modify("Promised Delivery Date")
        {
            CaptionML = ENU = 'Promised Delivery Date', FRA = 'Date livraison confirmée';
        }
        modify("Shipping Time")
        {
            CaptionML = ENU = 'Shipping Time', FRA = 'Délai d''expédition';
        }
        modify("Outbound Whse. Handling Time")
        {
            CaptionML = ENU = 'Outbound Whse. Handling Time', FRA = 'Délai désenlogement';
        }
        modify("Shipping Agent Service Code")
        {
            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
        }
        modify("Late Order Shipping")
        {
            CaptionML = ENU = 'Late Order Shipping', FRA = 'Expédition en retard';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify(Receive)
        {
            CaptionML = ENU = 'Receive', FRA = 'Réceptionner';
        }
        modify("Return Receipt No.")
        {
            CaptionML = ENU = 'Return Receipt No.', FRA = 'N° réception retour';
        }
        modify("Return Receipt No. Series")
        {
            CaptionML = ENU = 'Return Receipt No. Series', FRA = 'Souche de n° réception retour';
        }
        modify("Last Return Receipt No.")
        {
            CaptionML = ENU = 'Last Return Receipt No.', FRA = 'Dernier n° réception retour';
        }
        modify("Allow Line Disc.")
        {
            CaptionML = ENU = 'Allow Line Disc.', FRA = 'Autoriser remise ligne';
        }
        modify("Get Shipment Used")
        {
            CaptionML = ENU = 'Get Shipment Used', FRA = 'Extraire le mode d''expédition utilisé';
        }
        modify("Assigned User ID")
        {
            CaptionML = ENU = 'Assigned User ID', FRA = 'Code utilisateur affecté';
        }
        field(50000; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            Description = 'HEI.01';
            TableRelation = "WHT Business Posting Group FND".Code;
        }
        field(50012; "Sales Routes FND"; Code[10])
        {
            Description = 'HEI.04';
            TableRelation = "Sales Routes FND";
        }
        // BC Upgrade KUMARS145 Fields in available in INTERFACES/src/TableExtension/Tab-Ext58037.SalesHeaderArchiveExt.al ......>>
        // field(50021; "Load No."; Integer)
        // {
        //     Caption = 'Load No.';
        //     Description = 'HEI.05';
        // }
        // field(50022; "Sequence No."; Integer)
        // {
        //     Description = 'HEI,05';
        // }
        // BC Upgrade KUMARS145 Fields in available in INTERFACES/src/TableExtension/Tab-Ext58037.SalesHeaderArchiveExt.al ......<<
        field(50041; "Special Order FND"; Boolean)
        {
            Caption = 'Special Order';
            Description = 'HEI.06';
        }
        field(50060; "Source System Identifier FND"; Code[10])
        {
            Caption = 'Source System Identifier';
            Description = 'HEI.08';
            Editable = false;
            TableRelation = "Source Sys Identifier API FND";
        }
        field(50061; "Order Id FND"; Text[50])
        {
            Caption = 'Order Id';
            Description = 'HEI.08';
            Editable = false;
        }

        field(50021; "Load No. FND"; Integer)
        {
            Caption = 'Load No.';
            Description = 'HEI.05';
        }
        field(50022; "Sequence No. FND"; Integer)
        {
            Caption = 'Sequence No.';
            Description = 'HEI,05';
        }
        // BC Upgrade KUMARS145 Drinkit Fields ...>>
        // field(2013610; "Customer DDeposit Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Customer Deposit Group Code',
        //                 FRA = 'Code groupe consigne client';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code WHERE("Source Type" = CONST(Customer));
        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 13/10/2009
        //         TESTFIELD(Status, Status::Open);
        //     end;
        // }
        // field(2013611; "Empty Goods Item No. Filter"; Code[20])
        // {
        //     CaptionML = ENU = 'Empty Goods Item No. Filter',
        //                 FRA = 'Filtre article vidange n°';
        //     Description = 'DITW15.00.00.33-.35';
        //     FieldClass = FlowFilter;
        //     TableRelation = Item WHERE("Empty Good" = CONST(true));
        // }
        // field(2013613; "Link Sales Document No."; Code[20])
        // {
        //     CaptionML = ENU = 'Link Sales Document No.',
        //                 FRA = 'Lien N° document vente';
        //     Description = 'DITW15.00.00.33';
        //     TableRelation = "Sales Header Archive"."No." WHERE("Document Type" = FIELD("Link Sales Document Type"));
        // }
        // field(2013614; "Link Sales Document Type"; Option)
        // {
        //     CaptionML = ENU = 'Link Sales Document Type',
        //                 FRA = 'Lien type document vente';
        //     Description = 'DITW15.00.00.33';
        //     OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order',
        //                       FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
        //     OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        // }
        // field(2013615; "Print Link Document"; Boolean)
        // {
        //     CaptionML = ENU = 'Print Link Document',
        //                 FRA = 'Imprimer lien document';
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013616; "No. of Link Sales Orders"; Integer)
        // {
        //     CalcFormula = Count("Sales Header Archive" WHERE("Link Sales Document Type" = FIELD("Document Type"),
        //                                                       "Link Sales Document No." = FIELD("No.")));
        //     CaptionML = ENU = 'No. of Link Purchase Orders',
        //                 FRA = 'Nombre de lien commandes achats';
        //     Description = 'DITW15.00.00.33';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013630; "Deposit Cust. Posting Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Deposit - Customer Posting Group',
        //                 FRA = 'Consigne - Groupe compta. client';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = "Customer Posting Group";
        // }
        // field(2013631; "Deposit Payment Terms Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Deposit - Payment Terms Code',
        //                 FRA = 'Consigne - Code conditions paiement';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = "Payment Terms";
        // }
        // field(2013632; "Deposit Payment Method Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Deposit - Payment Method Code',
        //                 FRA = 'Consigne - Code mode de règlement';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = "Payment Method";
        // }
        // field(2013633; "Deposit Bal. Account Type"; Option)
        // {
        //     CaptionML = ENU = 'Deposit - Bal. Account Type',
        //                 FRA = 'Consigne - Type Compte Contrepartie';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     OptionCaptionML = ENU = 'G/L Account,Bank Account',
        //                       FRA = 'Général,Banque';
        //     OptionMembers = "G/L Account","Bank Account";
        // }
        // field(2013634; "Deposit Bal. Account No."; Code[20])
        // {
        //     CaptionML = ENU = 'Deposit - Bal. Account No.',
        //                 FRA = 'Consigne - N° compte contrepartie';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = IF ("Deposit Bal. Account Type" = CONST("G/L Account")) "G/L Account"
        //     ELSE IF ("Deposit Bal. Account Type" = CONST("Bank Account")) "Bank Account";
        // }
        // field(2013638; "Deposit Posting No."; Code[20])
        // {
        //     CaptionML = ENU = 'Deposit Posting No.',
        //                 FRA = 'N° facture consigne';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     Editable = false;
        //     TableRelation = "Sales Invoice Header";
        // }
        // field(2013639; "Last Deposit Posting No."; Code[20])
        // {
        //     CaptionML = ENU = 'Last Deposit Posting No.',
        //                 FRA = 'N° dern. facture consigne';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     Editable = false;
        //     TableRelation = "Sales Invoice Header";
        // }
        // field(2013666; "Autom. Item Charge"; Option)
        // {
        //     CaptionML = ENU = 'Calculate Item Charges',
        //                 FRA = 'Calculer Frais annexes';
        //     Description = 'DITW15.00.00.39 #1407';
        //     OptionCaptionML = ENU = 'Direct,Release,Posting,Posting (Excl. Item)',
        //                       FRA = 'Direct,Lancé,Validation,Validation (Excl. Article)';
        //     OptionMembers = " ",Release,Posting,PostingExclItem;
        // }
        // field(2013667; "Customer DTax Group Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Customer Tax Group Code',
        //                 FRA = 'Code groupe taxe client';
        //     Description = 'DITW15.00.00.01,HEI.03';
        //     TableRelation = "Drink Tax Group".Code WHERE("Source Type" = CONST(Customer));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 13/10/2009
        //         TESTFIELD(Status, Status::Open);
        //     end;
        // }
        // field(2013695; "Item Charge Type Filter"; Option)
        // {
        //     CaptionML = ENU = 'Item Charge Type Filter',
        //                 FRA = 'Filtre type frais article';
        //     Description = 'DITW15.00.00.33';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost";
        // }
        // field(2013726; "Customer Tax Registration No."; Text[20])
        // {
        //     CaptionML = ENU = 'Customer Tax Registration No.',
        //                 FRA = 'N° ident. accise client';
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013730; "Fiscal Representative No."; Code[20])
        // {
        //     CaptionML = ENU = 'Fiscal Representative / Customs Agent No.',
        //                 FRA = 'N° représentant fiscal / Agent des douanes';
        //     Description = 'DITW15.00.00.33-.38 #1217';
        //     TableRelation = "Fiscal Representative";
        // }
        // field(2013733; "Tax Date"; Date)
        // {
        //     CaptionML = ENU = 'Tax Date',
        //                 FRA = 'Date taxe';
        //     Description = 'DITW15.00.00.39 #1363';
        // }
        // field(2013797; "Disc.Promo. Order Calculated"; Boolean)
        // {
        //     CaptionML = ENU = 'Disc.Promo. Order Calculated',
        //                 FRA = 'Remise-Promotion cmde. calculé';
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013823; "Gen. Bus. Posting Free Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Gen. Bus. Posting Group Free item',
        //                 FRA = 'Groupe article gratuit compta. marché';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Gen. Business Posting Group";
        // }
        // field(2013825; "Free Item Posting Type"; Option)
        // {
        //     CaptionML = ENU = 'Calculate Price on Free',
        //                 FRA = 'Calculer Prix sur gratuit';
        //     Description = 'DITW15.00.00.35';
        //     OptionCaptionML = ENU = ' ,Price 0,Discount 100%',
        //                       FRA = ' ,Prix 0,Remise 100%';
        //     OptionMembers = " ",Price,Amount;
        // }
        // field(2013910; "Telesales Entry"; Integer)
        // {
        //     CaptionML = ENU = 'Telesales Entry',
        //                 FRA = 'Ecriture Téléventes';
        //     Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
        //     TableRelation = "Telesales Entry"."Entry No.";
        // }
        // field(2013969; "Pos System-Created Entry"; Boolean)
        // {
        //     CaptionML = ENU = 'POS System-Created Entry',
        //                 FRA = 'Ecriture système POS';
        //     Description = 'DITW15.00.00.39 #1328';
        // }
        // field(2014060; "Maximum Weight"; Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Maximum Weight',
        //                 FRA = 'Poids maximum';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.33';
        //     MinValue = 0;
        // }
        // field(2014061; "Maximum Cubage"; Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Maximum Volume (Cubage)',
        //                 FRA = 'Volume (Cubage) maximum';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.33';
        //     MinValue = 0;
        // }
        // field(2014062; "Shipment Date Formula"; DateFormula)
        // {
        //     CaptionML = ENU = 'Shipment Date Formula',
        //                 FRA = 'Formule date d''expédition';
        //     Description = 'DITW17.00.02 DIT-770 #146';

        //     trigger OnValidate();
        //     var
        //         lblnExit: Boolean;
        //         lcuCalendarManagement: Codeunit "Calendar Management";
        //         ltxtDescription: Text[50];
        //         ldatTargetDate: Date;
        //         lrLocation: Record Location;
        //         liCounter: Integer;
        //         liTotalDays: Integer;
        //         loptSourceType: Option Company,Customer,Vendor,Location,"Shipping Agent",Service;
        //     begin
        //     end;
        // }
        // field(2014064; "Shipping Charge Per"; Option)
        // {
        //     CaptionML = ENU = 'Shipping Charge Per',
        //                 FRA = 'Frais transport par';
        //     Description = 'DITW15.00.00.33';
        //     OptionCaptionML = ENU = 'Shipment,Weight,Volume',
        //                       FRA = 'Expédition,Poids,Volume';
        //     OptionMembers = Shipment,Weight,Volume;
        // }
        // field(2014067; "Total Weight"; Decimal)
        // {
        //     CalcFormula = Sum("Sales Line Archive".Weight WHERE("Document Type" = FIELD("Document Type"),
        //                                                          "Document No." = FIELD("No.")));
        //     CaptionML = ENU = 'Total Weight',
        //                 FRA = 'Poids total';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.33';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014068; "Total Cubage"; Decimal)
        // {
        //     CalcFormula = Sum("Sales Line Archive".Cubage WHERE("Document Type" = FIELD("Document Type"),
        //                                                          "Document No." = FIELD("No.")));
        //     CaptionML = ENU = 'Total Volume (Cubage)',
        //                 FRA = 'Volume (Cubage) total';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.33';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014069; "Total Weight (Base)"; Decimal)
        // {
        //     CalcFormula = Sum("Sales Line".Weight WHERE("Document Type" = FIELD("Document Type"),
        //                                                  "Document No." = FIELD("No."),
        //                                                  "Location Code" = FIELD("Location Filter")));
        //     CaptionML = ENU = 'Total Weight (Base)',
        //                 FRA = 'Poids Total (Base)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DIT-700 #664';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014070; "Total Cubage (Base)"; Decimal)
        // {
        //     CalcFormula = Sum("Sales Line".Cubage WHERE("Document Type" = FIELD("Document Type"),
        //                                                  "Document No." = FIELD("No."),
        //                                                  "Location Code" = FIELD("Location Filter")));
        //     CaptionML = ENU = 'Total Volume (Cubage) (Base)',
        //                 FRA = 'Volume Total (Cubage) (Base)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DIT-700 #664';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014077; "Truck Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Truck Code',
        //                 FRA = 'Code camion';
        //     Description = 'DITW15.00.00.33';
        //     TableRelation = "Whse. Shipping Truck";
        // }
        // field(2014078; "Driver Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Driver Code',
        //                 FRA = 'Code chauffeur';
        //     Description = 'DITW15.00.00.33';
        //     TableRelation = "Whse. Shipping Driver";
        // }
        // field(2014079; "Shipment status"; Option)
        // {
        //     CaptionML = ENU = 'Shipping Status',
        //                 FRA = 'Statut Expédition';
        //     Description = 'DITW16.00.00.43 DIT-715 #606/#154  -  DITW18.00.06 MSF 26/06/2015 DIT-770 #1347';
        //     OptionCaptionML = ENU = 'Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice',
        //                       FRA = 'Ouvert,Prélèvement imprimé,Affecté,Prélevé,Expédié,Retour terminée,Facturée';
        //     OptionMembers = Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;

        //     trigger OnValidate();
        //     var
        //         WarehouseRequest: Record "Warehouse Request";
        //         lcduReleaseSalesDocument: Codeunit "Release Sales Document";
        //     begin
        //     end;
        // }
        // field(2014080; "Customer Delivery Type"; Code[10])
        // {
        //     CaptionML = ENU = 'Customer Delivery Type',
        //                 FRA = 'Type Livraison Client';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     TableRelation = "Delivery Type".Code WHERE(Type = CONST(Customer));
        // }
        // field(2014082; "Total HL Weight"; Decimal)
        // {
        //     CalcFormula = Sum("Sales Line"."HL Cubage" WHERE("Document Type" = FIELD("Document Type"),
        //                                                       "Document No." = FIELD("No."),
        //                                                       "Location Code" = FIELD("Location Filter"),
        //                                                       "Outstanding Quantity" = FILTER(> 0)));
        //     CaptionML = ENU = 'Total HL Volume',
        //                 FRA = 'Volume Total HL';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW17.00.02 DIT-770 #189 -  DIT-770 #354';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014084; "Total Eq. UOM Quantity"; Decimal)
        // {
        //     CalcFormula = Sum("Sales Line"."Eq. UOM Quantity" WHERE("Document Type" = FIELD("Document Type"),
        //                                                              "Document No." = FIELD("No."),
        //                                                              Type = CONST(Item)));
        //     CaptionML = ENU = 'Total Eq. UOM',
        //                 FRA = 'Total Equiv. Unité de Mesure';
        //     Description = 'DITW17.00.02 DIT-770 #189 - DIT-770 #354 - DIT-770 #795';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014085; "Total HL Volume"; Decimal)
        // {
        //     CalcFormula = Sum("Sales Line".Cubage WHERE("Document Type" = FIELD("Document Type"),
        //                                                  "Document No." = FIELD("No."),
        //                                                  "Location Code" = FIELD("Location Filter"),
        //                                                  "Outstanding Quantity" = FILTER(> 0)));
        //     CaptionML = ENU = 'Total UOM',
        //                 FRA = 'Total Unité de Mesure';
        //     Description = 'DITW17.00.02 DIT-770 #189-AT - DIT-770 #354';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014087; Distance; Decimal)
        // {
        //     CaptionML = ENU = 'Distance',
        //                 FRA = 'Distance';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.33';
        //     MinValue = 0;
        // }
        // field(2014093; "Order No."; Code[20])
        // {
        //     CaptionML = ENU = 'Order No.',
        //                 FRA = 'N° commande';
        //     Description = 'DITW17.00.02 DIT-770 #338';
        // }
        // field(2014094; "Invoice Method"; Option)
        // {
        //     CaptionML = ENU = 'Invoice Method',
        //                 FRA = 'Méthode de facturation';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        //     OptionCaptionML = ENU = ' ,Shipment,Order,Combine Shipments,Combine Shipments Per Sell-to',
        //                       FRA = ' ,Expédition,Commande,Combiner expeditions,Combiner les expeditions par donneur d''ordre';
        //     OptionMembers = " ",Shipment,"Order","Combine Shipments","Combine Shipments Per Sell-to";
        // }
        // field(2014095; "Invoice Period"; Option)
        // {
        //     CaptionML = ENU = 'Invoice Period',
        //                 FRA = 'Période de facturation';
        //     Description = 'DITW17.00.02 DIT-770 #154, #338 - DIT-770 #1051';
        //     OptionCaptionML = ENU = ' ,Direct Delivery,Order,Event,Daily,Weekly,Half Montly,Montly,10 Days',
        //                       FRA = ' ,Livraison directe,Ordre,Événement,Quotidienne,Hebdomadaire,Demi-Mensuelle,Mensuelle,10 Jours';
        //     OptionMembers = " ","Direct Delivery","Order","Order Manually",Daily,Weekly,"Half Montly",Montly,"10 Days";
        // }
        // field(2014096; "Picking Type"; Option)
        // {
        //     CaptionML = ENU = 'Picking Type',
        //                 FRA = 'Type de prélèvement';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        //     OptionCaptionML = ENU = ' ,Order,Combined',
        //                       FRA = ' ,Commande,Regroupée';
        //     OptionMembers = " ","Order",Combined;
        // }
        // field(2014097; "Truck Zone"; Option)
        // {
        //     CaptionML = ENU = 'Truck Zone',
        //                 FRA = 'Zone de camion';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        //     OptionCaptionML = ENU = ' ,Right,Left',
        //                       FRA = ' ,Droite,Gauche';
        //     OptionMembers = " ",Right,Left;
        // }
        // field(2014098; "Require 2 Drivers"; Boolean)
        // {
        //     CaptionML = ENU = 'Require 2 Drivers',
        //                 FRA = 'Demande 2 chauffeurs';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        // }
        // field(2014099; "Driver 2 Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Driver 2 Code',
        //                 FRA = 'Code Chauffeur 2';
        //     Description = 'DITW17.00.02 DIT-770 #154 - DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214';
        //     TableRelation = IF ("Responsibility Center" = CONST('')) "Whse. Shipping Driver".Code WHERE("Responsibility Center" = FIELD("Resp. Center Table Filter"))
        //     ELSE IF ("Responsibility Center" = FILTER(<> '')) "Whse. Shipping Driver".Code WHERE("Responsibility Center" = FIELD("Resp. Center Table Filter 2"));
        // }
        // field(2014100; "Trailer Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Trailer Code',
        //                 FRA = 'Code Remorque';
        //     Description = 'DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 - DITW18.00.06 MSF 07/07/2015 DIT-770 #1212 #1213 #1214';
        //     TableRelation = IF ("Responsibility Center" = CONST('')) "Whse. Shipping Truck".Code WHERE("Responsibility Center" = FIELD("Resp. Center Table Filter"),
        //                                                                                               "Transport Unit Type" = CONST(Trailer))
        //     ELSE IF ("Responsibility Center" = FILTER(<> '')) "Whse. Shipping Truck".Code WHERE("Responsibility Center" = FIELD("Resp. Center Table Filter 2"),
        //                                                                                                                                                                                 "Transport Unit Type" = CONST(Trailer));
        // }
        // field(2014101; "Ship-to Address Key No."; Code[20])
        // {
        //     CaptionML = ENU = 'Ship-to Address Key No.',
        //                 FRA = 'N° clé adresse destinataire';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        // }
        // field(2014102; "Delivery Order"; Code[20])
        // {
        //     CaptionML = ENU = 'Delivery Order',
        //                 FRA = 'Commande de livraison';
        //     Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230';
        // }
        // field(2014103; "Whse. Shipment No. (First)"; Code[20])
        // {
        //     CalcFormula = Min("Warehouse Shipment Line"."No." WHERE("Source Type" = CONST(37),
        //                                                              "Source Subtype" = CONST("1"),
        //                                                              "Source No." = FIELD("No.")));
        //     CaptionML = ENU = 'Whse. Shipment No. (First)',
        //                 FRA = 'N° expédition magasin (Premier)';
        //     Description = 'DITW15.00.00.39 #1399';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     TableRelation = "Warehouse Shipment Header";
        // }
        // field(2014104; "Whse. Shipment Status (First)"; Option)
        // {
        //     CalcFormula = Lookup("Warehouse Shipment Header".Status WHERE("No." = FIELD("Whse. Shipment No. (First)")));
        //     CaptionML = ENU = 'Whse. Shipment Status (First)',
        //                 FRA = 'Status expédition magasin (Premier)';
        //     Description = 'DITW15.00.00.39 #1399';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     OptionCaptionML = ENU = 'Open,Released,Pending Pick,Pending Shipping',
        //                       FRA = 'Ouvert,Lancé,Prélèvement suspendue,Livraison suspendue';
        //     OptionMembers = Open,Released,"Pending Pick","Pending Ship";
        // }
        // field(2014107; Route; Code[20])
        // {
        //     CaptionML = ENU = 'Route',
        //                 FRA = 'Itinéraire';
        //     Description = 'DITW16.00.00.40 #1002';
        //     TableRelation = Route;
        // }
        // field(2014110; "Delivery Time 1 From"; Time)
        // {
        //     CaptionML = ENU = 'Delivery Time 1 From',
        //                 FRA = 'Heure de livraison 1 de';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        // }
        // field(2014111; "Delivery Time 1 To"; Time)
        // {
        //     CaptionML = ENU = 'Delivery Time 1 To',
        //                 FRA = 'Heure de livraison 1 à';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        // }
        // field(2014112; "Delivery Time 2 From"; Time)
        // {
        //     CaptionML = ENU = 'Delivery Time 2 From',
        //                 FRA = 'Heure de livraison 2 de';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        // }
        // field(2014113; "Delivery Time 2 To"; Time)
        // {
        //     CaptionML = ENU = 'Delivery Time 2 To',
        //                 FRA = 'Heure de livraison 2 à';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        // }
        // field(2014271; "Customer Tax Warehouse Ref."; Text[20])
        // {
        //     CaptionML = ENU = 'Customer Tax Warehouse Reference',
        //                 FRA = 'Entrepôt fiscal de référence client';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014277; "Transport Mode"; Option)
        // {
        //     CalcFormula = Lookup("Transport Method"."Transport Mode" WHERE(Code = FIELD("Transport Method")));
        //     CaptionML = ENU = 'Transport Mode (EMCS)',
        //                 FRA = 'Mode de transport (EMCS)';
        //     Description = 'DITW16.00.00.40 DIT715 #187';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     OptionCaptionML = ENU = 'Other,Sea,Rail,Road,Air,Post,N/A,Fixed,Waterway',
        //                       FRA = 'Autre,Mer,Chemin de fer,Route,Air,Poste,N/C,Installation de transport fixes,Transport par voies navigables';
        //     OptionMembers = Other,Sea,Rail,Road,Air,Post,"N/A","Fixed",Waterway;
        // }
        // field(2014290; "Journey Time"; DateFormula)
        // {
        //     CaptionML = ENU = 'Journey Time (EMCS)',
        //                 FRA = 'Temps de trajet (EMCS)';
        //     Description = 'DITW15.00.00.39 #1353';
        // }
        // field(2014291; "Transport Mode Comment"; Boolean)
        // {
        //     CalcFormula = Exist("EMCS Comment Line" WHERE("Table ID" = CONST(36),
        //                                                    "Document Type" = CONST(1),
        //                                                    "Document No." = FIELD("No."),
        //                                                    "Document Line No." = CONST(0),
        //                                                    "Field ID" = CONST(2014277)));
        //     CaptionML = ENU = 'Transport Mode Comment',
        //                 FRA = 'Commentaires Mode de transport';
        //     Description = 'DITW16.00.00.40 DIT715 #187';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014300; "Submission Type"; Option)
        // {
        //     CaptionML = ENU = 'Submission Type  (EMCS)',
        //                 FRA = 'Type de Message (EMCS)';
        //     Description = 'DITW18.00.07 DIT-770 #1397';
        //     OptionCaptionML = ENU = ' ,Type 1,Type 2',
        //                       FRA = ' ,Type 1,Type 2';
        //     OptionMembers = " ","Type 1","Type 2";
        // }
        // field(2014310; "Payment Amount"; Decimal)
        // {
        //     CaptionML = ENU = 'Payment Amount',
        //                 FRA = 'Montant règlement';
        //     Description = 'DITW17.00.02 DIT-770 #135';
        // }
        // field(2014313; "Financial Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Financial Contract No.',
        //                 FRA = 'N° Contrat Financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        // }
        // field(2014360; "Return Date"; Date)
        // {
        //     CaptionML = ENU = 'Return Date',
        //                 FRA = 'Date Retour';
        //     Description = 'DITW17.00.02 DIT-770 #148';
        // }
        // field(2014361; "Event No."; Code[20])
        // {
        //     CaptionML = ENU = 'Event No.',
        //                 FRA = 'N° évènement';
        //     Description = 'DITW17.10.05 DIT-770 #779';
        //     Editable = false;
        //     TableRelation = "Event Header"."No." WHERE("Document Type" = CONST(Event));
        // }
        // field(2014362; "Event Status"; Option)
        // {
        //     CaptionML = ENU = 'Event Status',
        //                 FRA = 'Statut évènement';
        //     Description = 'DITW17.10.05 DIT-770 #779';
        //     Editable = false;
        //     OptionCaptionML = ENU = ' ,To Approve,Approved,Rejected',
        //                       FRA = ' ,A approuver,Approuvé,Rejeté';
        //     OptionMembers = " ","To Approve",Approved,Rejected;

        //     trigger OnValidate();
        //     var
        //         AnyServItemInOtherContract: Boolean;
        //         SignServContractDoc: Codeunit SignServContractDoc;
        //         CloseType: Option " ",Close,CloseEarly;
        //     begin
        //     end;
        // }
        // field(2014363; "Event Description"; Text[50])
        // {
        //     CaptionML = ENU = 'Event Description',
        //                 FRA = 'Description événement';
        //     Description = 'DITW17.10.05 DIT-770 #779';
        //     Editable = false;
        // }
        // field(2014410; "Physical Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Physical Location Group Code',
        //                 FRA = 'Code groupe magasin réel';
        //     Description = 'DITW18.00.06 DIT-770 #1190';
        //     TableRelation = "Physical Location Group" WHERE(Code = FIELD("Phys. Location Table Filter"));

        //     trigger OnValidate();
        //     var
        //         PhysLocationGr: Record "Physical Location Group";
        //     begin
        //     end;
        // }
        // field(2014411; "Creation Date/Time"; DateTime)
        // {
        //     CaptionML = ENU = 'Creation Date/Time',
        //                 FRA = 'Date/Heure Création';
        //     Description = 'DITW18.00.07 DIT-770 #1282';
        //     Editable = false;
        // }
        // field(2014412; "Created By"; Code[50])
        // {
        //     CaptionML = ENU = 'Created By',
        //                 FRA = 'Créé par';
        //     Description = 'DITW18.00.07 DIT-770 #1282';
        //     Editable = false;
        //     TableRelation = "User Setup";
        // }
        // field(2014420; "Sundry Customer"; Boolean)
        // {
        //     CaptionML = ENU = 'Sundry Customer',
        //                 FRA = 'Client Diver';
        //     Description = 'DITW18.00.07 DIT-770 #1804';
        // }
        field(50090; "Document Subtype Code FND"; Code[10])
        {
            CaptionML = ENU = 'Document Subtype Code',
                        FRA = 'Code Sous-Type Document';
            Description = 'DITW18.00.07 DIT-770 #1508';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales | "Fin.Contract"));
        }
        // field(2014460; "Tax Office Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Tax Office Code',
        //                 FRA = 'Code Bureau de taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Office";
        // }
        // field(2014488; "Shipment Time"; Time)
        // {
        //     CaptionML = ENU = 'Shipment Time',
        //                 FRA = 'Heure d''Expédition';
        //     Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230';
        // }
        // field(2014491; "Delivery Time"; Time)
        // {
        //     CaptionML = ENU = 'Delivery Time',
        //                 FRA = 'Heure de Livraison';
        //     Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230';
        // }
        // field(2014495; "Delivery Sequence"; Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Delivery Sequence',
        //                 FRA = 'Séquence de livraison';
        //     Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230 #1002';
        //     MinValue = 0;
        // }
        // field(2014496; "Invoice List Customer No."; Code[20])
        // {
        //     CaptionML = ENU = 'Invoice List Customer No.',
        //                 FRA = 'N° client liste facture';
        //     Description = 'DITW17.10.05 DIT-715 #761';
        //     TableRelation = Customer;
        // }
        // field(2014500; "Resp. Center Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Resp. Center Table Filter',
        //                 FRA = 'Filtre Centre de gestion (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1190';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Responsibility Center";
        // }
        // field(2014501; "Phys. Location Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Phys. Location Table Filter',
        //                 FRA = 'Filtre groupe magasin réel (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1190';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014502; "Location Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Location Table Filter',
        //                 FRA = 'Filtre Magasin (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1190';
        //     FieldClass = FlowFilter;
        //     TableRelation = Location;
        // }
        // field(2014503; "Resp. Center Table Filter 2"; Code[10])
        // {
        //     CaptionML = ENU = 'Resp. Center Table Filter',
        //                 FRA = 'Filtre Centre de gestion (table)';
        //     Description = ' DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Responsibility Center";
        // }
        // field(2029613; "Approved Amount"; Decimal)
        // {
        //     CaptionML = ENU = 'Approved Amount',
        //                 FRA = 'Montant Approuvé';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2034840; "Building No."; Code[20])
        // {
        //     CaptionML = ENU = 'Building No.',
        //                 FRA = 'N° immeuble';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = Building;
        // }
        // field(2034850; "DIT Sub-Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Sub Contract Type',
        //                 FRA = 'Sous type contrat';
        //     Description = 'DIT-715 #392';
        //     OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA = ' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        // }
        // field(2034872; "Contract Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Contract Group Code',
        //                 FRA = 'Code groupe contrat';
        //     Description = 'DIT-715 #392';
        //     TableRelation = IF ("Contract Type" = CONST(Service)) "Contract Group".Code WHERE("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
        //     ELSE IF ("Contract Type" = CONST(Financial)) "Financial Contract Group".Code WHERE("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034915; "Service Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Service Contract No.',
        //                 FRA = 'N° contrat de service';
        //     Description = 'DIT-715 #392 - DITW18.00.06 DIT-770 #1368';

        //     trigger OnValidate();
        //     var
        //         FA2: Record "Fixed Asset";
        //     begin
        //     end;
        // }
        // field(2034920; "Contract Posting Date"; Date)
        // {
        //     CaptionML = ENU = 'Contract Posting Date',
        //                 FRA = 'Date comptabilisation du contrat';
        //     Description = 'DITW16.00.00.43 DIT715 #619';
        // }
        // field(2034921; "Outstanding Quantity"; Decimal)
        // {
        //     CalcFormula = Sum("Sales Line"."Outstanding Quantity" WHERE("Document Type" = FIELD("Document Type"),
        //                                                                  "Document No." = FIELD("No.")));
        //     CaptionML = ENU = 'Outstanding Quantity',
        //                 FRA = 'Quantité Réstante';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW17.10.02 DIT-770 #295';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035393; "Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Contract Type',
        //                 FRA = 'Type contrat';
        //     Description = 'DIT-715 #392 - DIT-770 #690 - DITW18.00.06 DIT-770 #1368';
        //     OptionCaptionML = ENU = ' ,Service,Financial',
        //                       FRA = ' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }
        // BC Upgrade KUMARS145 Drinkit Fields ...<<

    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.

}