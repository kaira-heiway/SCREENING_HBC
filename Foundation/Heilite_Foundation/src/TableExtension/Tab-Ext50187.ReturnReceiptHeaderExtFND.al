tableextension 50187 ReturnReceiptHeaderExtFND extends "Return Receipt Header"
{
    // DITW15.00.00.01 DDR 27/12/2007 Added fields
    //                                  2034647 Drink Tax Group Code
    // DITW15.00.00.01 DDR 02/01/2008 rename field
    //                                  2034647 Customer DTax Group Code + Filter to the source table
    // DITW15.00.00.01 DDR 04/01/2008 added field
    //                                  2013610 Customer DDeposit Group Code
    // DITW15.00.00.01 DDR 31/01/2008 Added Drink-it Reversing Calculation (Rounding) functionnalities
    //                                Added fields
    //                                  2034690 Price Incl. Reversing Calc.
    // DITW15.00.00.01 DDR 27/02/2008 Remove field (see lines)
    //                                  2034690 Price Incl. Reversing Calc.
    //                                Drink-it Return Deposit functionnalities
    //                                  added key "Applies-to Doc. Type,Applies-to Doc. No."
    //                                Added fields
    //                                  2013613 Link Sales Document No.
    //                                Added key
    //                                  "Link Sales Document No."
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.20 DDR 11/06/2008 Certification rules
    // DITW15.00.00.21 DDR 13/06/2008 Added flowfields
    //                                  2014430 Amount
    //                                  2014431 Amount Including VAT
    //                                  2013695 Item Charge Type Filter
    // DITW15.00.00.24 DDR 07/10/2008 Added fields
    //                                  2013722 Duty Tax Type
    // DITW15.00.00.25 DDR 10/10/2008 Added optionstring 'ShippingCost' for field "Item Charge Type"
    //                                Added fields
    //                                  2014077 Truck Code
    //                                  2014078 Driver Code
    //                     21/10/2008 Deleted fields
    //                                  2013722 Duty Tax Type
    // DITW15.00.00.28 DDR 24/11/2008 Added fields
    //                                  2013726 Tax Registration No.
    //                                  2013730 Fiscal Representative No.
    // DITW15.00.00.35 DDR 22/06/2009 Added functions
    //                                  GetReturnRcptLines(),SumReturnRcptLinesTemp(),
    //                                  SumReturnRcptLines2(),IncrAmount(),Increment()
    //                     25/06/2009 Added fields
    //                                  2013824 Gen. Bus. Posting Free Group
    //                     13/10/2009 Added fields
    //                                  2034840 Building No.
    // DITW15.00.00.38 DDR 13/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    2014271 Tax Warehouse Reference
    //                     27/01/2011 issue 1217 (DIT711 137)
    //                                  Modified Caption field2013730 "Fiscal Representative No."
    //                                  Added fields
    //                                    2014460 Tax Office Code
    // DITW15.00.00.39 RBE 20/04/2011 issue 1230 Telesales functionnalities
    //                                  Added fields
    //                                    2013936 Order Type
    //                                    2013937 Entry Type
    //                                  Added key "Entry Type,Order Date,Order Type"
    //                 DDR 06/07/2011 issue 1353 Added fields
    //                                   2014290 Journey Time
    //                     04/08/2011 issue 1353 Modified caption field2014290 "Journey Time"
    //                     19/08/2011 issue 1363
    //                                  Added fields
    //                                    2013733 Tax Date
    // DITW16.00.00.40 DDR 22/12/2011 DIT-715 issue 187
    //                                  Added fields
    //                                    2014277 Transport Mode (flowfield)
    //                                    2014291 Transport Mode Comment (flowfield)
    //                     05/01/2012 DIT-715 #172 Added fields "Allow VAT Calculation (Free)" to calculate VAT on free items
    //                     20/01/2012 DIT-715 #172 Modified workflow (+Rollback)
    //                     13/02/2012 #1460 Renamed/Bugfix option value of "Usage" field (table 77 Report Selections
    // DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392
    //                                Added fields
    //                                  2034850 DIT Sub-Contract Type
    //                                  2034872 Contract Group Code
    //                                  2034915 Service Contract No.
    //                                  2014311 Service Contract Type
    //                 AHU 31/08/2012 DIT-715 #327 Renamed Captions fields2034915,2034310,2014311
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields
    //                                               2013630 Deposit Cust. Posting Group
    //                                               2013631 Deposit Payment Terms Code
    //                                               2013632 Deposit Payment Method Code
    //                                               2013633 Deposit Bal. Account Type
    //                                               2013634 Deposit Bal. Account No.
    //                 AHU 30/01/2013 DIT-715 #395 Added 'DrillDownFormID' property table
    // DITW16.00.00.44 DDR 19/03/2014 DIT-715 #910 Added DIT fields
    //                                               2013825 Free Item Posting Type
    //                                               2013910 Telesales Entry
    //                                               2013969 Pos System-Created Entry
    //                                               2014060 Maximum Weight
    //                                               2014061 Maximum Cubage
    //                                               2014064 Shipping Charge Per
    //                                               2014067 Total Weight
    //                                               2014068 Total Cubage
    //                                               2014087 Distance
    //                                               2014107 Route
    //                                               2014488 Shipment Time
    //                                               2014491 Delivery Time
    //                                               2014495 Delivery Sequence
    //                                               2034920 Contract Next Invoice Date
    // DITW17.00.02 SR 10/16/2013 DIT-770 #155 : New Field Route Added
    //                                         : New Function "ShowShipmentEntry" Added
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 19/12/2013 DIT-770 #163 : Remove the "DIT Sub-Contract Type" filter in "Service Contract No." field
    // DITW17.00.03 DDR 20/03/2014 DIT-715 #910 merge
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added fields
    //                                                          2014410 Physical Location Group Code
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1190 Multisite - Modified function SetSecurityFilterOnRespCenter()
    // DITW17.10.05 WSA 04/08/14 DIT-770 #761 : Added field "Invoice List Customer No."
    // DITW17.10.05 MSF 20/10/2014 DIT-770 #831 Change Id of table 2014577 to  2035391
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                           Added field "Financial Contract No."
    //                                           Rename Caption Contract No. by Service contract No.
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Added blank Option to Contract Type
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field 2014420 "Sundry Customer"
    // DITW18.00.07 MVN 24/02/2016 DIT-770 #1397 Added Field 2014300 "Submission Type (EMCS)"
    // DITW18.00.07 MVN 17/03/2016 DIT-770 #1253 Check Permissions on Loyalty with License
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 New Field Flowfield "Document Shipping Costs"
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field 2014421 "Document Subtype Code"
    // DITW18.00.07 MVN 07/04/2016 DIT-770 #1397 Check Permissions on EMCS
    // DITW18.00.07 AKH 20/04/2016 DIT-770 #1508 Adjusted filtering code
    // DITW18.00.07 AKH 29/04/2016 DIT-770 #1346 Added field 2014080 "Customer Delivery Type"
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time", "Created By"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 16/02/2017 NRQ#20755 Update document subtype code table relation filter
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added Fields
    //                                "Require 2 Drivers"
    //                                "Driver 2 Code"
    //                                "Route Planning No."
    // DITW110.00.11 AKH 02/11/2017 NRQ#43605 Added new field 2035390 "Show Item charge on Invoice"
    // DITW110.00.11 ALE 11/01/2018 NRQ#43605 Removed field 2035394 "Show Item charge on Invoice"

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New fields for MDM integration
    // HEI.02 FDD-SLSGAP001 IBM NASTAA02 07.09.2017 # MDM Customer Card
    //   # Increased "Bill-to Address", "Sell-to Address" and "Ship-to Address" fields length from 50 to 60 characters
    //   # Increased "Bill-to City", "Sell-to City" and "Ship-to City" fields length from 30 to 35 characters

    // HEI.03 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Customer DTax Group Code" field length from 10 to 20 characters
    // HEI.04 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field created: 50001 - "Gate Entry No."
    // HEI.05 FDD-HT658 IBM.GUNERE01 01.10.2019 # Shipping Agent Service Code field added
    // HEI.06 CHG2065153 IBM KUMARN15 23.06.2020
    //   # Added field "Source System Identifier"
    // HEI.07 INC2924918 IBM NASTAA02 01.07.2020 # Your reference field in Sales Return Order should be 50 Characters
    //   # Increased length of Field 11 - Your Reference from 35 to 50 characters
    // HEI.08 CHG2200434 IBM COSTES04 19.05.2023 Column Data Availability of WH Shipment & WH Receipt No
    //   # New field added Posted Whse. Receipt No.
    // HEI.09 CHG2210794 SAHAL01 15.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Created New Fields: 50075 - Zycus Order No.
    //                         50078 - Zycus GR UUID
    //                         50079 - Zycus GR Cancel UUID
    //                         50081 - PO Transaction Interface Zycus
    //                         50082 - GR Transaction Interface Zycus
    //                         50085 - Processed PO Transaction Zycus
    //                         50086 - Processed GR Transaction Zycus
    //--------------------------------------------------------------------------------------------------------------------//
    //BC Upgrade SHARMP16-- Interface related fields commented and shifted to Interface Ext

    // BC Upgrade SHUKLP03 >> Added field 50090 for Document Subtype Code.

    fields
    {
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
            CaptionML = ENU = 'Shipment Date', FRA = 'Date de préparation';
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
            CaptionML = ENU = 'Due Date', FRA = 'Délai';
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
        modify("Customer Price Group")
        {
            CaptionML = ENU = 'Customer Price Group', FRA = 'Groupe prix client';
        }
        modify("Prices Including VAT")
        {
            CaptionML = ENU = 'Prices Including VAT', FRA = 'Prix TTC';
        }
        modify("Invoice Disc. Code")
        {
            CaptionML = ENU = 'Invoice Disc. Code', FRA = 'Code remise facture';
        }
        modify("Customer Disc. Group")
        {
            CaptionML = ENU = 'Customer Disc. Group', FRA = 'Groupe rem. client';
        }
        modify("Language Code")
        {
            CaptionML = ENU = 'Language Code', FRA = 'Code langue';
        }
        modify("Salesperson Code")
        {
            CaptionML = ENU = 'Salesperson Code', FRA = 'Code vendeur';
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
        modify("VAT Registration No.")
        {
            CaptionML = ENU = 'VAT Registration No.', FRA = 'N° identif. intracomm.';
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
            // OptionCaptionML = ENU = 'G/L Account,Bank Account', FRA = 'Général,Banque';
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
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
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
        modify("VAT Base Discount %")
        {
            CaptionML = ENU = 'VAT Base Discount %', FRA = '% remise base TVA';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Campaign No.")
        {
            CaptionML = ENU = 'Campaign No.', FRA = 'N° campagne';
        }
        modify("Sell-to Contact No.")
        {
            CaptionML = ENU = 'Sell-to Contact No.', FRA = 'N° contact donneur d''ordre';
        }
        modify("Bill-to Contact No.")
        {
            CaptionML = ENU = 'Bill-to Contact No.', FRA = 'N° contact';
        }
        modify("Opportunity No.")
        {
            CaptionML = ENU = 'Opportunity No.', FRA = 'N° opportunité';
        }
        modify("Responsibility Center")
        {
            CaptionML = ENU = 'Responsibility Center', FRA = 'Centre de gestion';
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
        modify("Warehouse Handling Time")
        {
            CaptionML = ENU = 'Warehouse Handling Time', FRA = 'Délai entrepôt';
        }
        modify("Late Order Shipping")
        {
            CaptionML = ENU = 'Late Order Shipping', FRA = 'Expédition en retard';
        }
        modify("Return Order No.")
        {
            CaptionML = ENU = 'Return Order No.', FRA = 'N° retour';
        }
        modify("Return Order No. Series")
        {
            CaptionML = ENU = 'Return Order No. Series', FRA = 'Souches de n° retour';
        }
        modify("Allow Line Disc.")
        {
            CaptionML = ENU = 'Allow Line Disc.', FRA = 'Autoriser remise ligne';
        }
        field(50000; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            Description = 'HEI.01';
            TableRelation = "WHT Business Posting Group FND".Code;
        }
        field(50001; "Gate Entry No. FND"; Code[20])
        {
            Caption = 'Gate Entry No.';
            Description = 'HEI.04';
            Editable = false;
            TableRelation = "Gate Entry Header FND";
        }
        field(50002; "Ship Agent Service Code FND"; Code[10])
        {
            CaptionML = ENU = 'Shipping Agent Service Code',
                        FRA = 'Code prestation transporteur';
            Description = 'HEI.05';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(50005; "Posted Whse. Receipt No. FND"; Code[20])
        {
            Caption = 'Posted Whse. Receipt No.';
            DataClassification = CustomerContent;
            Description = 'HEI.08';
        }
        //BC UPGRADE KUMARR78 FDD-MTC-008 >> Adding Field with New ID
        field(50094; "Show Item charge on Inv. FND"; Option)
        {
            Caption = 'Show Item charge on Invoice';
            OptionCaption = ' ,Under item line,Include in item price,Order total';
            OptionMembers = " ","Under item line","Include in item price","Order total";
        }
        //BC UPGRADE KUMARR78 FDD-MTC-008 << Adding Field with New ID
        // BC Upgrade NANDIS03 - shifted thsese to Interface Ext >>
        // field(50060; "Source System Identifier"; Code[10])
        // {
        //     Caption = 'Source System Identifier';
        //     Description = 'HEI.06';
        //     Editable = false;
        //     TableRelation = "Source System Identifier API";
        // }  
        // BC Upgrade NANDIS03 - shifted thsese to Interface Ext <<

        //BC Upgrade SHARMP16 BEGIN>>------ shifted thsese to Interface Ext .
        // field(50075; "Zycus Order No."; Code[20])
        // {
        //     Caption = 'Zycus Order No.';
        //     Description = 'HEI.09';
        //     Editable = false;
        // }
        // field(50078; "Zycus GR UUID"; Text[50])
        // {
        //     Caption = 'Zycus GR UUID';
        //     Description = 'HEI.09';
        //     Editable = false;
        // }
        // field(50079; "Zycus GR Cancel UUID"; Text[50])
        // {
        //     Caption = 'Zycus GR Cancel UUID';
        //     Description = 'HEI.09';
        //     Editable = false;
        // }
        // field(50081; "PO Transaction Interface Zycus"; Code[20])
        // {
        //     Caption = 'PO Transaction Interface Zycus';
        //     Description = 'HEI.09';
        //     Editable = false;
        //     TableRelation = "Interface Setup";
        // }
        // field(50082; "GR Transaction Interface Zycus"; Code[20])
        // {
        //     Caption = 'GR Transaction Interface Zycus';
        //     Description = 'HEI.09';
        //     Editable = false;
        //     TableRelation = "Interface Setup";
        // }
        // field(50085; "Processed PO Transaction Zycus"; Boolean)
        // {
        //     Caption = 'Processed PO Transaction Zycus';
        //     Description = 'HEI.09';
        //     Editable = false;
        // }
        // field(50086; "Processed GR Transaction Zycus"; Boolean)
        // {
        //     Caption = 'Processed GR Transaction Zycus';
        //     Description = 'HEI.09';
        //     Editable = false;
        // }
        //BC Upgrade SHARMP16 END<<------ shifted thsese to Interface Ext .

        //BC Upgrade SHARMP16 Begin>>--------------------Drink-It Fields
        // field(2013610; "Customer DDeposit Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Customer Deposit Group Code',
        //                 FRA = 'Code groupe consigne client';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code WHERE("Source Type" = CONST(Customer));
        // }
        // field(2013613; "Link Sales Document No."; Code[20])
        // {
        //     CaptionML = ENU = 'Link Sales Document No.',
        //                 FRA = 'Lien N° document vente';
        //     Description = 'DITW15.00.00.01';
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
        // field(2013667; "Customer DTax Group Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Customer Tax Group Code',
        //                 FRA = 'Code groupe taxe client';
        //     Description = 'DITW15.00.00.01,HEI.03';
        //     TableRelation = "Drink Tax Group".Code WHERE("Source Type" = CONST(Customer));
        // }
        // field(2013695; "Item Charge Type Filter"; Option)
        // {
        //     CaptionML = ENU = 'Item Charge Type Filter',
        //                 FRA = 'Filtre type frais article';
        //     Description = 'DITW15.00.00.01';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        // }
        // field(2013726; "Customer Tax Registration No."; Text[20])
        // {
        //     CaptionML = ENU = 'Customer Tax Registration No.',
        //                 FRA = 'N° ident. accise client';
        //     Description = 'DITW15.00.00.28';
        // }
        // field(2013730; "Fiscal Representative No."; Code[20])
        // {
        //     CaptionML = ENU = 'Fiscal Representative / Customs Agent No.',
        //                 FRA = 'N° représentant fiscal / Agent des douanes';
        //     Description = 'DITW15.00.00.28-.38 #1217';
        //     TableRelation = "Fiscal Representative";
        // }
        // field(2013733; "Tax Date"; Date)
        // {
        //     CaptionML = ENU = 'Tax Date',
        //                 FRA = 'Date taxe';
        //     Description = 'DITW15.00.00.39 #1363';
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
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     OptionCaptionML = ENU = ' ,Price 0,Discount 100%',
        //                       FRA = ' ,Prix 0,Remise 100%';
        //     OptionMembers = " ",Price,Amount;
        // }
        // field(2013910; "Telesales Entry"; Integer)
        // {
        //     CaptionML = ENU = 'Telesales Entry',
        //                 FRA = 'Ecriture Téléventes';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     TableRelation = "Telesales Entry"."Entry No.";
        // }
        // field(2013936; "Order Type"; Option)
        // {
        //     CaptionML = ENU = 'Order Type',
        //                 FRA = 'Type Commande';
        //     Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
        //     OptionCaptionML = ENU = 'Normal,Pre Order,Empty Goods',
        //                       FRA = 'Normale,Pré Commande,Vidange';
        //     OptionMembers = Normal,"Pre Order","Empty Goods",Depannage;
        // }
        // field(2013937; "Entry Type"; Option)
        // {
        //     CaptionML = ENU = 'Entry Type',
        //                 FRA = 'Type écriture';
        //     Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
        //     OptionCaptionML = ENU = 'Order,,Télévente,,,,,,Télévente Processed',
        //                       FRA = 'Commande,,Télévente,,,,,,Télévente traités';
        //     OptionMembers = "Order",,"Télévente",,,,,,"Télévente Processed";
        // }
        // field(2013969; "Pos System-Created Entry"; Boolean)
        // {
        //     CaptionML = ENU = 'POS System-Created Entry',
        //                 FRA = 'Ecriture système POS';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        // }
        // field(2014060; "Maximum Weight"; Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Maximum Weight',
        //                 FRA = 'Poids maximum';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     MinValue = 0;
        // }
        // field(2014061; "Maximum Cubage"; Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Maximum Volume (Cubage)',
        //                 FRA = 'Volume (Cubage) maximum';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     MinValue = 0;
        // }
        // field(2014064; "Shipping Charge Per"; Option)
        // {
        //     CaptionML = ENU = 'Shipping Charge Per',
        //                 FRA = 'Frais transport par';
        //     Description = 'DITW15.00.00.21';
        //     OptionCaptionML = ENU = 'Shipment,Weight,Volume',
        //                       FRA = 'Expédition,Poids,Volume';
        //     OptionMembers = Shipment,Weight,Volume;
        // }
        // field(2014067; "Total Weight"; Decimal)
        // {
        //     CalcFormula = Sum("Sales Shipment Line".Weight WHERE("Document No." = FIELD("No.")));
        //     CaptionML = ENU = 'Total Weight',
        //                 FRA = 'Poids total';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014068; "Total Cubage"; Decimal)
        // {
        //     CalcFormula = Sum("Sales Shipment Line".Cubage WHERE("Document No." = FIELD("No.")));
        //     CaptionML = ENU = 'Total Volume (Cubage)',
        //                 FRA = 'Volume (Cubage) total';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     FieldClass = FlowField;
        // }
        // field(2014071; "Document Shipping Costs"; Boolean)
        // {
        //     CalcFormula = Exist("Posted Document Shipping Cost" WHERE("Source Type" = CONST(6660),
        //                                                                "Source No." = FIELD("No.")));
        //     CaptionML = ENU = 'Document Shipping Costs',
        //                 FRA = 'Document Frais livraison';
        //     Description = 'DIT-770 #1066';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014077; "Truck Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Truck Code',
        //                 FRA = 'Code camion';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Whse. Shipping Truck";
        // }
        // field(2014078; "Driver Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Driver Code',
        //                 FRA = 'Code chauffeur';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Whse. Shipping Driver";
        // }
        // field(2014080; "Customer Delivery Type"; Code[10])
        // {
        //     CaptionML = ENU = 'Customer Delivery Type',
        //                 FRA = 'Type Livraison Client';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     TableRelation = "Delivery Type".Code WHERE(Type = CONST(Customer));
        // }
        // field(2014087; Distance; Decimal)
        // {
        //     CaptionML = ENU = 'Distance',
        //                 FRA = 'Distance';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     MinValue = 0;
        // }
        // field(2014098; "Require 2 Drivers"; Boolean)
        // {
        //     Caption = 'Require 2 Drivers';
        //     Description = 'NRQ16082';
        // }
        // field(2014099; "Driver 2 Code"; Code[10])
        // {
        //     Caption = 'Driver 2 Code';
        //     Description = 'NRQ16082';
        // }
        // field(2014107; Route; Code[20])
        // {
        //     CaptionML = ENU = 'Route',
        //                 FRA = 'Itinéraire';
        //     Description = 'DITW17.00.02 DIT-770 #155';
        //     TableRelation = Route;
        // }
        // field(2014109; "Route Planning No."; Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'NRQ16082';

        //     trigger OnValidate();
        //     var
        //         RoutePlanningWorksheet: Record "Route Planning Worksheet";
        //     begin
        //     end;
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
        //     CalcFormula = Exist("EMCS Comment Line" WHERE("Table ID" = CONST(6660),
        //                                                    "Document Type" = CONST(0),
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
        //     CaptionML = ENU = 'Submission Type (EMCS)',
        //                 FRA = 'Type de demande (EMCS)';
        //     Description = 'DITW18.00.07 DIT-770 #1397';
        //     OptionCaptionML = ENU = ' ,Type 1,Type 2',
        //                       FRA = ' ,Type 1,Type 2';
        //     OptionMembers = " ","Type 1","Type 2";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW18.00.07 MVN 07/04/2016 DIT-770 #1397
        //         if ApplMgt.IsObjectLicense(5, CODEUNIT::"EMCS EDI Mgt", 4) <> 0 then
        //             // >>DITW18.00.07 MVN DIT-770 #1397
        //             // <<DITW18.00.07 MVN 24/02/2016 DIT-770 #1397
        //             "Submission Type" := EMCSEDIMgt.CheckSubmissionType(1, "Customer DTax Group Code", "Location Code", "Submission Type");
        //         // >>DITW18.00.07 MVN DIT-770 #1397
        //     end;
        // }
        // field(2014313; "Financial Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Financial Contract No.',
        //                 FRA = 'N° Contrat Financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Financial Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract),
        //                                                                       "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2014410; "Physical Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Physical Location Group Code',
        //                 FRA = 'Code groupe magasin réel';
        //     Description = 'DITW18.00.06 DIT-770 #1190';
        //     TableRelation = "Physical Location Group";
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
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = CONST(Purchase));
        }
        // field(2014430; Amount; Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Return Receipt Line".Amount WHERE("Document No." = FIELD("No."),
        //                                                           "Item Charge Type" = FIELD("Item Charge Type Filter")));
        //     CaptionML = ENU = 'Amount',
        //                 FRA = 'Montant';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014431; "Amount Including VAT"; Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Return Receipt Line"."Amount Including VAT" WHERE("Document No." = FIELD("No."),
        //                                                                           "Item Charge Type" = FIELD("Item Charge Type Filter")));
        //     CaptionML = ENU = 'Amount Including VAT',
        //                 FRA = 'Montant TTC';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
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
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        // }
        // field(2014491; "Delivery Time"; Time)
        // {
        //     CaptionML = ENU = 'Delivery Time',
        //                 FRA = 'Heure de Livraison';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        // }
        // field(2014495; "Delivery Sequence"; Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Delivery Sequence',
        //                 FRA = 'Séquence de livraison';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     MinValue = 0;
        // }
        // field(2014496; "Invoice List Customer No."; Code[20])
        // {
        //     CaptionML = ENU = 'Invoice List Customer No.',
        //                 FRA = 'N° client liste facture';
        //     Description = 'DITW17.10.05 DIT-715 #761';
        //     TableRelation = Customer;
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
        //     TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract),
        //                                                                     "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034920; "Contract Next Invoice Date"; Date)
        // {
        //     CaptionML = ENU = 'Contract Next Invoice Date',
        //                 FRA = 'Proch. date facturation du contrat';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        // }
        // field(2035393; "Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Contract Type',
        //                 FRA = 'Type contrat';
        //     Description = 'DIT-715 #392 - DITW18.00.06 DIT-770 #1368';
        //     OptionCaptionML = ENU = ' ,Service,Financial',
        //                       FRA = ' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }
        //BC Upgrade SHARMP16 End<<--------------------Drink-It Fields
    }
    keys
    {
        // key(Key1; "Link Sales Document No.")
        // {
        // }//BC Upgrade SHARMP16 Begin>>--------------------Drink-It Keys
        // key(Key2; "Entry Type", "Order Date", "Order Type")
        // {
        // }//BC Upgrade SHARMP16 Begin>>--------------------Drink-It Keys
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: EmcsCommentLine)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("No. Printed");
    LOCKTABLE;
    PostSalesDelete.DeleteSalesRcptLines(Rec);

    SalesCommentLine.SETRANGE("Document Type",SalesCommentLine."Document Type"::"Posted Return Receipt");
    SalesCommentLine.SETRANGE("No.","No.");
    SalesCommentLine.DELETEALL;

    ApprovalsMgmt.DeletePostedApprovalEntries(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
    EmcsCommentLine.SETRANGE("Table ID",DATABASE::"Return Receipt Header");
    EmcsCommentLine.SETRANGE("Document Type",0);
    EmcsCommentLine.SETRANGE("Document No.","No.");
    EmcsCommentLine.DELETEALL;
    // >>DITW16.00.00.40 DDR DIT-715 #187

    ApprovalsMgmt.DeletePostedApprovalEntries(RECORDID);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
    // EmcsCommentLine: Record "EMCS Comment Line";


    //Unsupported feature: PropertyModification on "Text001(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Posted Document Dimensions;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Posted Document Dimensions;FRA=Axes analytiques document enregistré;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DocTxt(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DocTxt : ENU=Receipt;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DocTxt : ENU=Receipt;FRA=Réception;
    //Variable type has not been exported.

    var
        TotalReturnRcptLine: Record "Return Receipt Line";
        TotalReturnRcptLineLCY: Record "Return Receipt Line";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        Currency: Record Currency;
    // EMCSEDIMgt: Codeunit "EMCS EDI Mgt";
    // ApplMgt: Codeunit ApplicationManagement;
}

