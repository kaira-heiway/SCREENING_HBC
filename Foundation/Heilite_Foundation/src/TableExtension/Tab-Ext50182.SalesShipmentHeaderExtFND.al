tableextension 50182 SalesShipmentHeaderExtFND extends "Sales Shipment Header"
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
    //                                Added fields
    //                                  2013613 Link Sales Document No.
    //                                Added key
    //                                  "Link Sales Document No."
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.20 DDR 11/06/2008 Certification rules
    // DITW15.00.00.21 DDR 13/06/2008 Added fields
    //                                  2014430 Amount
    //                                  2014431 Amount Including VAT
    //                                  2013695 Item Charge Type Filter
    // DITW15.00.00.24 DDR 14/08/2008 Added fields
    //                                  2014060 Maximum Weight
    //                                  2014061 Maximum Cubage
    //                                  2014064 Shipping Charge Per
    //                                  2014067 Total Weight (sum flowfield [Lines])
    //                                  2014068 Total Cubage (sum flowfield [Lines])
    //                                  2014087 Distance
    //                     07/10/2008 Added fields
    //                                  2013722 Duty Tax Type
    // DITW15.00.00.25 DDR 10/10/2008 Added fields
    //                                  2014077 Truck Code
    //                                  2014078 Driver Code
    //                                Added optionstring 'ShippingCost' for field "Item Charge Type"
    //                     21/10/2008 Deleted fields
    //                                  2013722 Duty Tax Type
    // DITW15.00.00.28 DDR 24/11/2008 Added fields
    //                                  2013726 Tax Registration No.
    //                                  2013730 Fiscal Representative No.
    // DITW15.00.00.35 DDR 22/06/2009 Added functions
    //                                  GetSalesShptLines(),SumSalesShptLinesTemp(),
    //                                  SumSalesShptLines2(),IncrAmount(),Increment()
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
    //                                   Added key "Entry Type,Order Date,Order Type"
    //                     21/04/2011    Added fields
    //                                     2014488 Shipment Time
    //                                     2014491 Delivery Time
    //                 DDR 27/04/2011    Added fields
    //                                     2013910 Telesales Entry
    //                                   Added key "Sell-to Customer No.,Posting Date,No.,Ship-to Code"
    //                 DDR 09/05/2011 issue 1328 Shop (iPos) Functionnalities
    //                                  Added fields
    //                                    2013969 Pos System-Created Entry
    //                 DDR 06/07/2011 issue 1353 Added fields
    //                                   2014290 Journey Time
    //                     04/08/2011 issue 1353 Modified caption field2014290 "Journey Time"
    //                     19/08/2011 issue 1363
    //                                  Added fields
    //                                    2013733 Tax Date
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields
    //                                    2014107 Route
    //                                    2014495 Delivery Sequence
    //                     22/12/2011 DIT-715 issue 187
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
    // DITW16.00.00.43 FBL 28/06/2013 DIT-715 #619 Add field 2034920 "Contract Next Invoice Date" (Date)
    // DITW16.00.00.44 DDR 19/03/2014 DIT-715 #910 Added DIT fields
    //                                               2013825 Free Item Posting Type

    // FINXL7.00.001 RBE 20/03/2013 : Added PDF Functionality

    // DITW17.00.02 DDR 17/05/2013 DIT-770 #95 Added fields
    //                                               2014560 Vessel Info. Code
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #95
    // DITW17.00.02 SR 10/16/2013 DIT-770 #155 : New Function "ShowShipmentEntry" Added
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 AT 02/12/2013 DIT-770 #154
    //                             Added fields
    //                             2014096 Picking Type
    //                             2014097 Truck Zone
    //                             2014099 Driver 2 Code
    //                             2014101 Ship-to Address Key No.
    //                             2014110 Delivery Time 1 From
    //                             2014111 Delivery Time 1 To
    //                             2014112 Delivery Time 2 From
    //                             2014113 Delivery Time 2 To
    // DITW17.00.02 SR 19/12/2013 DIT-770 #163 : Remove the "DIT Sub-Contract Type" filter in "Service Contract No." field
    // DITW17.00.03 DDR 20/03/2014 DIT-715 #910 merge
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.00.02 VSC 13/02/2014 DIT-770 #338 :New Field Invoice Period
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added fields
    //                                                          2014410 Physical Location Group Code
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1190 Multisite - Modified function SetSecurityFilterOnRespCenter()
    // DITW17.10.05 WSA 04/08/14 DIT-770 #761 : Added field "Invoice List Customer No."
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05 MSF 20/10/2014 DIT-770 #831 Change Id of table 2014577 to  2035391
    // DITW17.10.05 WSA 10/11/2014 DIT-770 #779  Added events fields
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 Added field  2014100 "Trailer Code"
    // DITW18.00.06 MSF 14/05/2015 DIT-770 #1051 Added option 10 days to field Invoice period
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                           Added field "Financial Contract No."
    //                                           Rename Caption Contract No. by Service contract No.
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Added blank Option to Contract Type
    // DITW18.00.07 MVN 18/01/2016 DIT-770 #1397 Added Field 2014300 "Submission Type"
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field 2014420 "Sundry Customer"
    // DITW18.00.07 MVN 24/02/2016 DIT-770 #1397 Changed Field 2014300 for CaptionML: "Submission Type (EMCS)"
    // DITW18.00.07 MVN 17/03/2016 DIT-770 #1253 Check Permissions on Loyalty with License
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 New Field Flowfield "Document Shipping Costs"
    // DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    //                                           Added field2014109 Route Planning No.
    //                                           Update key "Order No.,Shipment Date"
    //                                           Added key "Route,Sell-to Customer No.,Shipment Date"
    //                                           Delete function ShowShipmentEntry
    // DITW18.00.07 MVN 07/04/2016 DIT-770 #1397 Check Permissions on EMCS
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field 2014421 "Document Subtype Code"
    // DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code
    // DITW18.00.07 AKH 20/04/2016 DIT-770 #1508 Adjusted filtering code
    // DITW18.00.07 DDR 28/04/2016 DIT-770 #1488 Update key "Order No." (removed "shipment date")
    //                                           Added key "Route Planning No."
    // DITW18.00.07 AKH 29/04/2016 DIT-770 #1346 Added fields 2014080 "Customer Delivery Type"
    //                                                        2014081 "Delivery Time (sec.)"
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time", "Created By"
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 16/02/2017 NRQ#20755 Update document subtype code table relation filter

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //   # New field "WHT Business Posting Group"
    // HEI.02 FDD-SLSGAP001 IBM NASTAA02 07.09.2017 # MDM Customer Card
    //   # Increased "Bill-to Address", "Sell-to Address" and "Ship-to Address" fields length from 50 to 60 characters
    //   # Increased "Bill-to City", "Sell-to City" and "Ship-to City" fields length from 30 to 35 characters
    // HEI.03 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Customer DTax Group Code" field length from 10 to 20 characters
    // HEI.04 FDD-HNK LOGGAP001 03/02/2018 IBM.CHAUHB01
    //   # New Field Added "Sales Routes"
    // HEI.05 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field created: 50015 - Gate Entry No.
    // DITW111.00.13A MSF 09/05/2019 NRQ#109271 Disable DIT Discounts and or Promotions for a sales documents
    //                               Added Field "Disable DIT Disc. Prom."
    // HEI.06 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    // FINXL11.00 HBA 03/05/2018 NRQ#69018: Added field 2029618 "IC Document" (Boolean)
    // DITW111.00.13A NLAB 25/06/2019 NRQ#113801 : Merge NRQ#69018
    // HEI.07 FDD-HT657 IBM NASTAA02 15.11.2019 # Ethiopia Intercompany Automation
    //   # New Field created: 50041 - Special Order
    // HEI.08 Defect #5296 IBM NASTAA02 02.04.2020 # The translation of shipment date in french is not right
    //   # Changed French Caption for "Shipment Date" field to 'Date d'expédition'
    // HEI.09 CHG2065153 IBM KUMARN15 23.06.2020
    //   # Added field "Source System Identifier"
    // HEI.10 INC2924918 IBM NASTAA02 01.07.2020 # Your reference field in Sales Return Order should be 50 Characters
    //   # Increased length of Field 11 - Your Reference from 35 to 50 characters
    // HEI.11 HB1582 IBM NASTAA02 02.09.2020 # Actual Delivery Date for Case Fill Rate - CHG2071900
    //   # New Field created: 50063 - Actual Delivery Date
    //   # Code added on OnValidate Trigger of "Actual Delivery Date"
    //   # New Text Constant created: "ActualDeliveryDateErr"
    // HEI.12 CHG2260099 COSTES04 18.09.2024 Automatic Archiving of Gate Entry Outbound While Undoing Sales Shipment.
    //   # New field added Gate Entry Archived

    // BC Upgrade SHUKLP03 >> 50090 Document Subtype code field added.

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
        modify("Order No.")
        {
            CaptionML = ENU = 'Order No.', FRA = 'N° commande';
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
            //OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement';
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
        modify("Order No. Series")
        {
            CaptionML = ENU = 'Order No. Series', FRA = 'Souche de n° commande';
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
        modify("Quote No.")
        {
            CaptionML = ENU = 'Quote No.', FRA = 'N° devis';
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
        modify("Outbound Whse. Handling Time")
        {
            CaptionML = ENU = 'Outbound Whse. Handling Time', FRA = 'Délai désenlogement';
        }
        modify("Shipping Agent Service Code")
        {
            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
        }
        modify("Allow Line Disc.")
        {
            CaptionML = ENU = 'Allow Line Disc.', FRA = 'Autoriser remise ligne';
        }
        field(50005; "Posted Whse. Shipment No. FND"; Code[20])
        {
            Caption = 'Posted Whse. Shipment No.';
            Description = 'LOGGAP07';
        }
        field(50006; "Whse. Shipment No. FND"; Code[20])
        {
            Caption = 'Whse. Shipment No.';
            Description = 'LOGGAP07';
        }
        field(50012; "Sales Routes FND"; Code[10])
        {
            Caption = 'Sales Routes';
            Description = 'HEI.04';
            TableRelation = "Sales Routes FND";
        }
        field(50015; "Gate Entry No. FND"; Code[20])
        {
            Caption = 'Gate Entry No.';
            Description = 'HEI.05';
            Editable = false;
            TableRelation = "Gate Entry Header FND";
        }
        field(50021; "Load No. FND"; Integer)
        {
            Caption = 'Load No.';
            Description = 'HEI.6';
        }
        field(50022; "Sequence No. FND"; Integer)
        {
            Caption = 'Sequence No.';
            Description = 'HEI,6';
        }
        field(50041; "Special Order FND"; Boolean)
        {
            Caption = 'Special Order';
            Description = 'HEI.07';
        }
        field(50060; "Source System Identifier FND"; Code[10])
        {
            Caption = 'Source System Identifier';
            Description = 'HEI.09';
            Editable = false;
            TableRelation = "Source Sys Identifier API FND";
        }
        field(50063; "Actual Delivery Date FND"; Date)
        {
            Caption = 'Actual Delivery Date';
            Description = 'HEI.11';

            trigger OnValidate();
            begin
                //HEI.11>>
                if ("Actual Delivery Date FND" <> 0D) and ("Actual Delivery Date FND" < "Posting Date") then
                    ERROR(ActualDeliveryDateErr, "Actual Delivery Date FND", "Posting Date");
                //HEI.11<<
            end;
        }
        field(50067; "Gate Entry Archived FND"; Boolean)
        {
            Caption = 'Gate Entry Archived';
            DataClassification = CustomerContent;
            Description = 'HEI.12';
        }
        //BC Upgrade SHARMP16 Begin<<  -------- Drink-It fields
        // field(2013610; "Customer DDeposit Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Customer Depoist Group Code',
        //                 FRA = 'Code groupe consigne client';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code where("Source Type" = CONST(Customer));
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
        //     else IF ("Deposit Bal. Account Type" = CONST("Bank Account")) "Bank Account";
        // }
        // field(2013667; "Customer DTax Group Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Customer Tax Group Code',
        //                 FRA = 'Code groupe taxe client';
        //     Description = 'DITW15.00.00.01,HEI.03';
        //     TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Customer));
        // }
        // field(2013695; "Item Charge Type Filter"; Option)
        // {
        //     CaptionML = ENU = 'Item Charge Type Filter',
        //                 FRA = 'Filtre type frais article';
        //     Description = 'DITW15.00.00.01';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost";
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
        //     Description = 'DITW15.00.00.39 DDR 27/04/2011 #1230';
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
        //     OptionCaptionML = ENU = 'Order,,Telesales,,,,,,Telesales Processed',
        //                       FRA = 'Commande,,Télévente,,,,,,Télévente traités';
        //     OptionMembers = "Order",,Telesales,,,,,,"Telesales Processed";
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
        //     Description = 'DITW15.00.00.24';
        //     MinValue = 0;
        // }
        // field(2014061; "Maximum Cubage"; Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Maximum Volume (Cubage)',
        //                 FRA = 'Volume (Cubage) maximum';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.24';
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
        //     CalcFormula = Sum("Sales Shipment Line".Weight where("Document No." = FIELD("No.")));
        //     CaptionML = ENU = 'Total Weight',
        //                 FRA = 'Poids total';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.24';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014068; "Total Cubage"; Decimal)
        // {
        //     CalcFormula = Sum("Sales Shipment Line".Cubage where("Document No." = FIELD("No.")));
        //     CaptionML = ENU = 'Total Volume (Cubage)',
        //                 FRA = 'Volume (Cubage) total';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.24';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014071; "Document Shipping Costs"; Boolean)
        // {
        //     CalcFormula = Exist("Posted Document Shipping Cost" where("Source Type" = CONST(110),
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
        //     TableRelation = "Delivery Type".Code where(Type = CONST(Customer));
        // }
        // field(2014081; "Delivery Time (sec.)"; Decimal)
        // {
        //     CalcFormula = Sum("Sales Shipment Line"."Delivery Time (sec.)" where("Document No." = FIELD("No."),
        //                                                                           Type = CONST(Item)));
        //     CaptionML = ENU = 'Delivery Time (sec.)',
        //                 FRA = 'Temps de Livraison (Sec.)';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014087; Distance; Decimal)
        // {
        //     CaptionML = ENU = 'Distance',
        //                 FRA = 'Distance';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.24';
        //     MinValue = 0;
        // }
        // field(2014095; "Invoice Period"; Option)
        // {
        //     CaptionML = ENU = 'Invoice Period',
        //                 FRA = 'Période de facturation';
        //     Description = 'DITW17.00.02 DIT-770 #338 - DIT-770 #1051';
        //     OptionCaptionML = ENU = ' ,Direct Delivery,Order,Order Manually,Daily,Weekly,Half Montly,Montly,10 Days',
        //                       FRA = ' ,Livraison Directe,Commande,Commande Manuelle,Quotidien,Hebdomadaire,Quainzaine,Mensuel,10 Jours';
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
        // field(2014099; "Driver 2 Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Driver 2 Code',
        //                 FRA = 'Code Chauffeur 2';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        //     TableRelation = "Whse. Shipping Driver";
        // }
        // field(2014100; "Trailer Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Trailer Code',
        //                 FRA = 'Code Remorque';
        //     Description = 'DITW18.00.06 MSF 14/05/2015 DIT-770 #1035';
        //     TableRelation = "Whse. Shipping Truck".Code where("Transport Unit Type" = CONST(Trailer));
        // }
        // field(2014101; "Ship-to Address Key No."; Code[20])
        // {
        //     CaptionML = ENU = 'Ship-to Address Key No.',
        //                 FRA = 'N° clé adresse destinataire';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        // }
        // field(2014107; Route; Code[20])
        // {
        //     CaptionML = ENU = 'Route',
        //                 FRA = 'Itinéraire';
        //     Description = 'DITW16.00.00.40 #1002';
        //     TableRelation = Route;
        // }
        // field(2014109; "Route Planning No."; Code[20])
        // {
        //     CaptionML = ENU = 'Route Planning No.',
        //                 FRA = 'N° Planning Itinéraire';
        //     Description = 'DITW18.00.07 #1488';
        //     TableRelation = "Route Planning Worksheet";
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
        //     CalcFormula = Lookup("Transport Method"."Transport Mode" where(Code = FIELD("Transport Method")));
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
        //     CalcFormula = Exist("EMCS Comment Line" where("Table ID" = CONST(110),
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
        //             // <<DITW18.00.07 MVN 18/01/2016 DIT-770 #1397
        //             "Submission Type" := EMCSEDIMgt.CheckSubmissionType(1, "Customer DTax Group Code", "Location Code", "Submission Type");
        //         // >>DITW18.00.07 MVN DIT-770 #1397
        //     end;
        // }
        // field(2014313; "Financial Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Financial Contract No.',
        //                 FRA = 'N° Contrat Financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Financial Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                       "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2014361; "Event No."; Code[20])
        // {
        //     CaptionML = ENU = 'Event No.',
        //                 FRA = 'N° évènement';
        //     Description = 'DITW17.10.05 DIT-770 #779';
        //     Editable = false;
        //     TableRelation = "Sales Header"."No." where("Document Type" = FILTER(6));
        // }
        // field(2014362; "Event Status"; Option)
        // {
        //     CaptionML = ENU = 'Event Status',
        //                 FRA = 'Statut évènement';
        //     Description = 'DITW17.10.05 DIT-770 #779';
        //     Editable = true;
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

        // BC Upgrade SHUKLP03 >> Document Subtype Code field added.
        field(50090; "Document Subtype Code FND"; Code[10])
        {
            CaptionML = ENU = 'Document Subtype Code',
                        FRA = 'Code Sous-Type Document';
            Description = 'DITW18.00.07 DIT-770 #1508';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Sales | "Fin.Contract"));
        }
        // BC Upgrade SHUKLP03 << Document Subtype Code field added.

        // field(2014430; Amount; Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Sales Shipment Line".Amount where("Document No." = FIELD("No."),
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
        //     CalcFormula = Sum("Sales Shipment Line"."Amount Including VAT" where("Document No." = FIELD("No."),
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
        //     Description = 'DITW16.00.00.40 #1002';
        //     MinValue = 0;
        // }
        // field(2014496; "Invoice List Customer No."; Code[20])
        // {
        //     CaptionML = ENU = 'Invoice List Customer No.',
        //                 FRA = 'N° client liste facture';
        //     Description = 'DITW17.10.05 DIT-715 #761';
        //     TableRelation = Customer;
        // }
        // field(2017760; "Disable DIT Disc. Prom."; Option)
        // {
        //     Caption = 'Disable DIT Discount Promotion';
        //     Description = 'DITW111.00.13A MSF 09/05/2019 NRQ#109271';
        //     OptionCaption = '" ,Discount,Promotion,All"';
        //     OptionMembers = " ",Discount,Promotion,All;
        // }
        // field(2029618; "IC Document"; Boolean)
        // {
        //     Caption = 'IC Document';
        //     Description = 'Description=FINXL11.00';
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
        //     TableRelation = IF ("Contract Type" = CONST(Service)) "Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
        //     else IF ("Contract Type" = CONST(Financial)) "Financial Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034915; "Service Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Service Contract No.',
        //                 FRA = 'N° contrat de service';
        //     Description = 'DIT-715 #392 - DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Service Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                     "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034920; "Contract Next Invoice Date"; Date)
        // {
        //     CaptionML = ENU = 'Contract Next Invoice Date',
        //                 FRA = 'Proch. date facturation du contrat';
        //     Description = 'DITW16.00.00.43 DIT715 #619';
        // }
        // field(2035393; "Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Contract Type',
        //                 FRA = 'Type contrat';
        //     Description = 'DIT-715 #392 -  DITW18.00.06 DIT-770 #1368';
        //     OptionCaptionML = ENU = ' ,Service,Financial',
        //                       FRA = ' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }
        //BC Upgrade SHARMP16 End>>  -------- Drink-It fields
    }
    keys
    {
        // key(Key1; "Link Sales Document No.")
        // {
        // }
        // key(Key2; "Entry Type", "Order Date", "Order Type")
        // {
        // }//  //BC Upgrade SHARMP16 Begin<<  -------- Drink-It keys
        key(Key50000; "Sell-to Customer No.", "Posting Date", "No.", "Ship-to Code")
        {
        }
        // key(Key4; Route, "Sell-to Customer No.", "Shipment Date")
        // {
        // }  //BC Upgrade SHARMP16 Begin<<  -------- Drink-It Keys
        // key(Key5; "Route Planning No.")
        // {
        // }  //BC Upgrade SHARMP16 Begin<<  -------- Drink-It Keys
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
    PostSalesDelete.DeleteSalesShptLines(Rec);

    SalesCommentLine.SETRANGE("Document Type",SalesCommentLine."Document Type"::Shipment);
    SalesCommentLine.SETRANGE("No.","No.");
    SalesCommentLine.DELETEALL;

    ApprovalsMgmt.DeletePostedApprovalEntries(RECORDID);

    if CertificateOfSupply.GET(CertificateOfSupply."Document Type"::"Sales Shipment","No.") then
      CertificateOfSupply.DELETE(true);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
    EmcsCommentLine.SETRANGE("Table ID",DATABASE::"Sales Shipment Header");
    EmcsCommentLine.SETRANGE("Document Type",0);
    EmcsCommentLine.SETRANGE("Document No.","No.");
    EmcsCommentLine.DELETEALL;
    // >>DITW16.00.00.40 DDR DIT-715 #187

    #9..12
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
    //   EmcsCommentLine: Record "EMCS Comment Line";


    //Unsupported feature: PropertyModification on "DocTxt(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DocTxt : ENU=Shipment;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DocTxt : ENU=Shipment;FRA=Expédition;
    //Variable type has not been exported.

    var
        Currency: Record Currency;
        TotalSalesShptLine: Record "Sales Shipment Line";
        TotalSalesShptLineLCY: Record "Sales Shipment Line";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        // EMCSEDIMgt: Codeunit "EMCS EDI Mgt";
        // ApplMgt: Codeunit ApplicationManagement;
        ActualDeliveryDateErr: Label 'Actual Delivery Date %1 cannot be prior to Posting Date %2.';
}

