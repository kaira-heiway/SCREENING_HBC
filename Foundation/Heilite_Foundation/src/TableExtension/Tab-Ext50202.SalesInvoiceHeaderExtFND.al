tableextension 50202 SalesInvoiceHeaderExtFND extends "Sales Invoice Header"
{
    // version NAVW110.0.00.15601,FINXL10.00,DITW110.00.11,HEI.22
    //     DITW15.00.00.01 DDR 27/12/2007 Added fields
    //                                        2034647 Drink Tax Group Code
    //       DITW15.00.00.01 DDR 02/01/2008 rename field
    //                                        2034647 Customer DTax Group Code + Filter to the source table
    //       DITW15.00.00.01 DDR 04/01/2008 added field
    //                                        2013610 Customer DDeposit Group Code
    //       DITW15.00.00.01 DDR 31/01/2008 Added Drink-it Reversing Calculation (Rounding) functionnalities
    //                                      Added fields
    //                                        2034690 Price Incl. Reversing Calc.
    //       DITW15.00.00.01 DDR 27/02/2008 Remove field (see lines)
    //                                        2034690 Price Incl. Reversing Calc.
    //                                      Added fields
    //                                        2013613 Link Sales Document No.
    //                                      Added key
    //                                        "Link Sales Document No."
    //       DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //       DITW15.00.00.20 DDR 11/06/2008 Certification rules
    //       DITW15.00.00.24 DDR 14/08/2008 Added fields
    //                                        2014087 Distance
    //                           07/10/2008 Added fields
    //                                        2013722 Duty Tax Type
    //       DITW15.00.00.25 DDR 16/10/2008 Added fields
    //                                        2014077 Truck Code
    //                                        2014078 Driver Code
    //                           21/10/2008 Deleted fields
    //                                        2013722 Duty Tax Type
    //       DITW15.00.00.35 DDR 22/06/2009 Added fields
    //                                        2013695 Item Charge Type Filter
    //                                      Added "Item Charge Type Filter" into calcformula property fields
    //                                        "Amount","Amount Including VAT"
    //                                      Added functions
    //                                        GetSalesInvLines(),SumSalesInvLinesTemp(),
    //                                        SumSalesInvLines2(),IncrAmount(),Increment()
    //                           25/06/2009 Added fields
    //                                        2013824 Gen. Bus. Posting Free Group
    //                           13/10/2009 Added fields
    //                                        2034840 Building No.
    //       DITW15.00.00.38 DDR 13/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                        Added fields
    //                                          2014271 Tax Warehouse Reference
    //       DITW15.00.00.39 RBE 20/04/2011 issue 1230 Telesales functionnalities
    //                                        Added fields
    //                                          2013936 Order Type
    //                                          2013937 Entry Type
    //                                        Added key "Entry Type,Order Date,Order Type"
    //                       DDR 09/05/2011 issue 1328 Shop (iPos) Functionnalities
    //                                        Added fields
    //                                          2013969 Pos System-Created Entry
    //                           19/08/2011 issue 1363
    //                                        Added fields
    //                                          2013733 Tax Date
    //       DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added fields "Allow VAT Calculation (Free)" to calculate VAT on free items
    //                           20/01/2012 DIT-715 #172 Modified workflow (+Rollback)
    //       DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392
    //                                      Added fields
    //                                        2034850 DIT Sub-Contract Type
    //                                        2034872 Contract Group Code
    //                                        2034915 Service Contract No.
    //                                        2014311 Service Contract Type
    //                       AHU 31/08/2012 DIT-715 #327 Renamed Captions fields2034915,2034310,2014311
    //       DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields
    //                                                     2013630 Deposit Cust. Posting Group
    //                                                     2013631 Deposit Payment Terms Code
    //                                                     2013632 Deposit Payment Method Code
    //                                                     2013633 Deposit Bal. Account Type
    //                                                     2013634 Deposit Bal. Account No.
    //       DITW16.00.00.43 FBL 28/06/2013 DIT-715 #619 Add field 2034920 "Contract Next Invoice Date" (Date)
    //       DITW16.00.00.44 DDR 19/03/2014 DIT-715 #910 Added DIT fields
    //                                                     2013726 Customer Tax Registration No.
    //                                                     2013730 Fiscal Representative No.
    //                                                     2013825 Free Item Posting Type
    //                                                     2013910 Telesales Entry
    //                                                     2014064 Shipping Charge Per
    //                                                     2014107 Route
    //                                                     2014495 Delivery Sequence
    //       DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //       DITW17.00.02 RPG 18/12/2013 DIT-770 #235 Added new function "PrintShipmentSpecs"
    //       DITW17.00.02 SR 19/12/2013 DIT-770 #163 : Remove the "DIT Sub-Contract Type" filter in "Service Contract No." field
    //       DITW17.00.03 DDR 20/03/2014 DIT-715 #910 merge
    //       DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    //       DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added fields
    //                                                                2014410 Physical Location Group Code
    //       DITW18.00.06 DDR 25/02/2015 DIT-770 #1190 Multisite - Modified function SetSecurityFilterOnRespCenter()
    //       DITW17.10.05 WSA 04/08/14 DIT-770 #761 : Added fields "Invoice List Customer No." "Invoice List Document No."
    //                                                Added Key(Invoice List Customer No.,Currency Code,Posting Date)
    //       DITW17.10.05 WSA 10/11/2014 DIT-770 #779 Added Events fields
    //       DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //       DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //       FINXL8.00.001 RBE 01/12/2014: Changed Mail Functionality
    //       FINXL8.00.001 BSA 12/06/2015 #67 : Add possibility to print report without Header/Footer
    //       DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                                 Added field "Financial Contract No."
    //                                                 Rename Caption Contract No. by Service contract No.
    //                                                 Change ID of field Contract Type to Foundation layer 2035393
    //                                                 Added blank Option to Contract Type
    //       DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field 2014420 "Sundry Customer"
    //       DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field 2014421 "Document Subtype Code"
    //       DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code
    //       DITW18.00.07 AKH 20/04/2016 DIT-770 #1508 Adjusted filtering code
    //       DITW17.00.07 WSA 21/04/2016 DIT-770 #1723 Added TR in field Invoice List Document No.
    //       DITW18.00.07 AKH 29/04/2016 DIT-770 #1346 Added field 2014080 "Customer Delivery Type"
    //       DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    //       DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time", "Created By"

    //       DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //       DITW110.00.08 DDR 16/02/2017 NRQ#20755 Update document subtype code table relation filter
    //                                              Upgrade function PrintShipmentSpecs()
    //       DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //       FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    //       DITW110.00.11 MSF 25/08/2017 NRQ#17902 Route settlement - Order Payments, Suggest customer and vendor payments
    //                                        2014109 Route Planning No.
    //       DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added fields "Require 2 Drivers" & Driver 2 Code & "Trailer Code"

    //       HEI.01 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //         # New field "WHT Business Posting Group"
    //       HEI.02 FDD-SLSGAP001 IBM NASTAA02 07.09.2017 # MDM Customer Card
    //         # Increased "Bill-to Address", "Sell-to Address" and "Ship-to Address" fields length from 50 to 60 characters
    //         # Increased "Bill-to City", "Sell-to City" and "Ship-to City" fields length from 30 to 35 characters
    //       HEI.03 FDD-SLSGAP001 IBM NASTAA02 19.09.2017 # MDM Customer Card
    //         # Increased "Customer DTax Group Code" field length from 10 to 20 characters
    //       HEI.04 FDD-OTCGAP01 IBM ISYED01 28.11.2017
    //       Added fields XML Printed,Fiscal Document,Fiscal Document No.,Print Station Serial,Print Date/Time to table
    //       HEI.05 FDD-HNK LOGGAP001 03/12/2017 IBM.CHAUHB01
    //         # Added new field "Sales Routes"
    //       HEI.06 FDD-OTCGAP051 IBM NASTAA02 06.03.2018 # Document Subtype Code non-editable for Bonus Credit Memos
    //         # New Field created: 50013 - "Bonus Credit Memo"
    //       HEI.08 RW-GAPLOG08 IBM LAZARE02 23.10.2018 # New fields EBM Status, SDC Information Approved for EBM interface
    //       DITW111.00.13A MSF 09/05/2019 NRQ#109271 Disable DIT Discounts and or Promotions for a sales documents
    //                                     Added Field "Disable DIT Disc. Prom."
    //       HEI.09 LB-GAPLOG01 IBM HORTOC01 1.08.19
    //         # added new fileds Vans Sales Route,Doc. Amount Incl. VAT,Doc. Amount VAT
    //       HEI.09 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."

    //       HEI.10 HT453 - CHG2011093 IBM GAVANM01 11.06.2019
    //         # New fields created: IDs range 50023..50029
    //       HEI.11 HT453 - CHG2011093 IBM GAVANM01 18.06.2019
    //         # New field created: InCo Terms , ID 50030
    //       HEI.12 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //         # New Field created: 50031 - Suppress POS Interface
    //         # Renamed Field 50019 - "EBM Status" to "Fiscal Printer Status"
    //         # Renamed Options of Field 50019 from "EBM" to "Fiscal Printer"
    //       HEI.13 FDD-HT634 CHG2024485 IBM GAVANM01 27.08.2019 # New field created - "Country of Origin"
    //       HEI.14 FDD-HT657 IBM NASTAA02 15.11.2019 # Ethiopia Intercompany Automation
    //         # New Field created: 50041 - Special Order
    //       HEI.15 CHG2044105 IBM.AB 07.01.2020
    //         # New field Invoice Receipt No Created
    //       HEI.16 CHG2010375 IBM.LS 21.01.2020
    //         # New Field created: 50050 - "Send Document"
    //         # New Field created: 50051 - "Mail Sent"
    //       HEI.17 Defect #5296 IBM NASTAA02 26.03.2020 # The translation of shipment date in french is not right
    //         # Changed French Caption for "Shipment Date" field to 'Date d'exp dition'
    //       HEI.19 CHG2065153 IBM KUMARN15 23.06.2020
    //         # Added field "Source System Identifier"
    //       HEI.20 INC2924918 IBM NASTAA02 01.07.2020 # Your reference field in Sales Return Order should be 50 Characters
    //         # Increased length of Field 11 - Your Reference from 35 to 50 characters
    //       HEI.21 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //         # New Field created: 50061 - "CAD Amount"
    //       HEI.22 CHG2266917 COSTES04 04.09.2024 Electronic invoice interface
    // # New field Sent to Electronic Invoice

    // BC Upgrade BHARDA11 >>
    // Migration from NAV 2018 to Business Central 26
    // Table Extension: Sales Invoice Header
    // Changes:
    // 1. Commented out field "Package Tracking No." - Modified field, not available in standard BC table structure
    // 2. Commented out field "Coupled to CRM" - Field renamed/removed in BC
    // 3. Updated CalcFormula for field 50061 "CAD Amount" - Removed Drink IT field reference "Item Charge Type"
    // 4. Commented out ALL Drink IT custom fields (Range 2013610..2035393)
    // 5. Commented out ALL Drink IT custom keys
    // 7. Crate new Tabe Extn for Interface Fields ("Fiscal Printer Status","SDC Information Approved","Load No.","Sequence No.","Suppress POS Interface","Source System Identifier")
    // 8. Field length changes attempted but NOT IMPLEMENTED (BC does not allow field length modification in extensions):
    //    - "Bill-to Address" (Field 7): Attempted increase 50→60, BC already has 100 (no change needed)
    //    - "Bill-to Address 2" (Field 8): Attempted increase 50→60, BC base is 50 (cannot modify)
    //    - "Bill-to City" (Field 9): Attempted increase 30→35, BC base is 30 (cannot modify)
    //    - "Ship-to Address" (Field 15): Attempted increase 50→60, BC already has 100 (no change needed)
    //    - "Ship-to Address 2" (Field 16): Attempted increase 50→60, BC base is 50 (cannot modify)
    //    - "Ship-to City" (Field 17): Attempted increase 30→35, BC base is 30 (cannot modify)
    //    - "Sell-to Address" (Field 81): Attempted increase 50→60, BC already has 100 (no change needed)
    //    - "Sell-to Address 2" (Field 82): Attempted increase 50→60, BC base is 50 (cannot modify)
    //    - "Sell-to City" (Field 83): Attempted increase 30→35, BC base is 30 (cannot modify)
    //    - "Your Reference" (Field 11): Attempted increase 35→50, BC base is 35 (cannot modify)
    //    - "Customer Posting Group" (Field 40): Field length decreased 20→10 in BC (cannot modify)
    //    - "Salesperson Code" (Field 42): Field length decreased 20→10 in BC (cannot modify)
    //    - "Gen. Bus. Posting Group" (Field 63): Field length decreased 20→10 in BC (cannot modify)
    //    - "No. Series" (Field 107): Field length decreased 20→10 in BC (cannot modify)
    //    - "Order No. Series" (Field 108): Field length decreased 20→10 in BC (cannot modify)
    //    - "Pre-Assigned No." (Field 109): Field length decreased 20→10 in BC (cannot modify)
    //    - "Prepayment No. Series" (Field 117): Field length decreased 20→10 in BC (cannot modify)
    // 9. Commented out ALL Drink IT custom procedures/functions
    // Drink IT Custom Fields Commented
    // Drink IT Custom Functions Commented:
    // - GetSalesInvLines(), SumSalesInvLinesTemp(), SumSalesInvLines2()
    // - IncrAmount(), Increment()
    // - PrintShipmentSpecs(), EmailShipmentSpecs()
    // BC Upgrade BHARDA11 <<

    // BC Upgrade SHUKLP03 >> Added 50090 Document Subtype Code field.
    //BC UPGRADE KUMARR78 >>
    // Changing for (FDD OTC 091/090)
    //Adding Field and Table Relation for Driver Code. 
    //BC UPGARDE KUMARR78 <<

    //       HEI.08 RW-GAPLOG08 IBM LAZARE02 23.10.2018 # New fields EBM Status, SDC Information Approved for EBM interface
    //       HEI.09 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    //       HEI.12 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //         # New Field created: 50031 - Suppress POS Interface
    //         # Renamed Field 50019 - "EBM Status" to "Fiscal Printer Status"
    //         # Renamed Options of Field 50019 from "EBM" to "Fiscal Printer"
    //       HEI.19 CHG2065153 IBM KUMARN15 23.06.2020
    //         # Added field "Source System Identifier"
    // BC Upgrade BHARDA11 ---Interface Objects

    // BC Upgrade MISHRS14 >>
    // Changed table extension name to "SalesInvoiceHeaderInterfaceFND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<
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
            // BC Upgrade BHARDA11 --- Field ("Bill-to Address")length increase 50 to 60but in business central length is already 100.
            //Unsupported feature: Change Data type on ""Bill-to Address"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Bill-to Address', FRA = 'Adresse facturation';
            Description = 'HEI.02';

            //Unsupported feature: Change Description on ""Bill-to Address"(Field 7)". Please convert manually.

        }
        modify("Bill-to Address 2")
        {
            // BC Upgrade BHARDA11 --- Field ("Bill-to Address 2")length increase 50 to 60 but in business central we can not increase field length.

            //Unsupported feature: Change Data type on ""Bill-to Address 2"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Bill-to Address 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change Description on ""Bill-to Address 2"(Field 8)". Please convert manually.

        }
        modify("Bill-to City")
        {
            // BC Upgrade BHARDA11 --- Field("Bill-to City") length increase 30 to 35 but in business central we can not increase field length.
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
            // BC Upgrade BHARDA11 --- Field("Your Reference") length increase 35 to 50 but in business central we can not increase field length.
            //Unsupported feature: Change Data type on ""Your Reference"(Field 11)". Please convert manually.

            CaptionML = ENU = 'Your Reference', FRA = 'Votre référence';
            Description = 'HEI.20';
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
            // BC Upgrade BHARDA11 --- Field("Ship-to Address") length increase 50 to 60 but in business central we can not increase field length. Here Length is already 100

            //Unsupported feature: Change Data type on ""Ship-to Address"(Field 15)". Please convert manually.

            CaptionML = ENU = 'Ship-to Address', FRA = 'Adresse destinataire';
            Description = 'HEI.02';
            //Unsupported feature: Change Description on ""Ship-to Address"(Field 15)". Please convert manually.

        }
        modify("Ship-to Address 2")
        {

            //Unsupported feature: Change Data type on ""Ship-to Address 2"(Field 16)". Please convert manually.
            // BC Upgrade BHARDA11 --- Field("Ship-to Address 2") length increase 50 to 60 but in business central we can not increase field length.

            CaptionML = ENU = 'Ship-to Address 2', FRA = 'Adresse destinataire 2';

            //Unsupported feature: Change Description on ""Ship-to Address 2"(Field 16)". Please convert manually.

        }
        modify("Ship-to City")
        {
            // BC Upgrade BHARDA11 --- Field("Ship-to City") length increase 30 to 35 but in business central we can not increase field length.
            //Unsupported feature: Change Data type on ""Ship-to City"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Ship-to City', FRA = 'Ville destinataire';
            Description = 'HEI.02';
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
            // BC Upgrade BHARDA11 --- Field "Customer Posting Group" length Decrease 20 to 10 , We can not change the field  length in Business central.
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
            // BC Upgrade BHARDA11 --- Field "Salesperson Code" length Decrease 20 to 10 , We can not change the field  length in Business central.
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
            //  OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement';
        }
        modify("Applies-to Doc. No.")
        {
            CaptionML = ENU = 'Applies-to Doc. No.', FRA = 'N° doc. lettrage';
        }
        modify("Bal. Account No.")
        {
            CaptionML = ENU = 'Bal. Account No.', FRA = 'N° compte contrepartie';
        }
        modify(Amount)
        {

            //Unsupported feature: Change CalcFormula on "Amount(Field 60)". Please convert manually.

            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Amount Including VAT")
        {

            //Unsupported feature: Change CalcFormula on ""Amount Including VAT"(Field 61)". Please convert manually.

            CaptionML = ENU = 'Amount Including VAT', FRA = 'Montant TTC';

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
            // BC Upgrade BHARDA11 --- Field (Gen. Bus. Posting Group) length decrease 20 to 10, We can not change the field length in Business central
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
            // BC Upgrade BHARDA11 ---- Field Length increase 50 to 60 , we can not change field length here Length is 100
            //Unsupported feature: Change Data type on ""Sell-to Address"(Field 81)". Please convert manually.

            CaptionML = ENU = 'Sell-to Address', FRA = 'Adresse donneur d''ordre';
            Description = 'HEI.02';
            //Unsupported feature: Change Description on ""Sell-to Address"(Field 81)". Please convert manually.

        }
        modify("Sell-to Address 2")
        {
            // BC Upgrade BHARDA11 ---- Field  "Sell-to Address 2" Length increase 50 to 60 , we can not change field length here Length is 50

            //Unsupported feature: Change Data type on ""Sell-to Address 2"(Field 82)". Please convert manually.

            CaptionML = ENU = 'Sell-to Address 2', FRA = 'Adresse donneur d''ordre 2';

            //Unsupported feature: Change Description on ""Sell-to Address 2"(Field 82)". Please convert manually.

        }
        modify("Sell-to City")
        {
            // BC Upgrade BHARDA11 ---- Field  "Sell-to City" Length increase 30 to 35 , we can not change field length here Length is 30

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
            //  OptionCaptionML = ENU = 'G/L Account,Bank Account', FRA = 'Général,Banque';
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
        // BC Upgrade BHARDA11 >> 
        // modify("Package Tracking No.")
        // {
        //     CaptionML = ENU='Package Tracking No.',FRA='N° récépissé';
        // }
        // BC Upgrade BHARDA11 >> 
        modify("Pre-Assigned No. Series")
        {
            CaptionML = ENU = 'Pre-Assigned No. Series', FRA = 'Souche de n° pré-attribués';
        }
        modify("No. Series")
        {
            // BC Upgrade BHARDA11 ---- Field length decrease 20 to 10, we can not change field length.
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Order No. Series")
        {
            // BC Upgrade BHARDA11 ---- Field length decrease 20 to 10, we can not change field length.
            CaptionML = ENU = 'Order No. Series', FRA = 'Souche de n° commande';
        }
        modify("Pre-Assigned No.")
        {
            // BC Upgrade BHARDA11 --- Field length Decrease 20 to 10 , we can not change field length 
            CaptionML = ENU = 'Pre-Assigned No.', FRA = 'N° pré-attribués';
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
        modify("Prepayment No. Series")
        {
            // BC Upgrade BHARDA11 ---- Field length decrease 20 to 10, we can not change field length.
            CaptionML = ENU = 'Prepayment No. Series', FRA = 'N° de série acompte';
        }
        modify("Prepayment Invoice")
        {
            CaptionML = ENU = 'Prepayment Invoice', FRA = 'Facture acompte';
        }
        modify("Prepayment Order No.")
        {
            CaptionML = ENU = 'Prepayment Order No.', FRA = 'N° ordre acompte';
        }
        modify("Quote No.")
        {
            CaptionML = ENU = 'Quote No.', FRA = 'N° devis';
        }
        modify("Work Description")
        {
            CaptionML = ENU = 'Work Description', FRA = 'Description du travail';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Payment Service Set ID")
        {
            CaptionML = ENU = 'Payment Service Set ID', FRA = 'ID ensemble de services de paiement';
        }
        modify("Document Exchange Identifier")
        {
            CaptionML = ENU = 'Document Exchange Identifier', FRA = 'Identifiant Exchange de documents';
        }
        modify("Document Exchange Status")
        {
            CaptionML = ENU = 'Document Exchange Status', FRA = 'Statut d''échange de documents';
            //  OptionCaptionML = ENU = 'Not Sent,Sent to Document Exchange Service,Delivered to Recipient,Delivery Failed,Pending Connection to Recipient', FRA = 'Non envoyé,Envoyé au service d''échange de documents,Remis au destinataire,Échec de la remise,En attente de la connexion au destinataire';
        }
        modify("Doc. Exch. Original Identifier")
        {
            CaptionML = ENU = 'Doc. Exch. Original Identifier', FRA = 'Identifiant original éch. doc.';
        }
        // BC Upgrade BHARDA11 >>
        // modify("Coupled to CRM")
        // {
        //     CaptionML = ENU = 'Coupled to Dynamics CRM', FRA = 'Couplé vers Dynamics CRM';
        // }
        // BC Upgrade BHARDA11 <<
        modify("Direct Debit Mandate ID")
        {
            CaptionML = ENU = 'Direct Debit Mandate ID', FRA = 'ID mandat domiciliation européenne';
        }
        modify(Closed)
        {
            CaptionML = ENU = 'Closed', FRA = 'Clôturé';
        }
        modify("Remaining Amount")
        {
            CaptionML = ENU = 'Remaining Amount', FRA = 'Montant ouvert';
        }
        modify("Cust. Ledger Entry No.")
        {
            CaptionML = ENU = 'Cust. Ledger Entry No.', FRA = 'N° écriture comptable clt';
        }
        modify("Invoice Discount Amount")
        {
            CaptionML = ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
        }
        modify(Cancelled)
        {
            CaptionML = ENU = 'Cancelled', FRA = 'Annulé';
        }
        modify(Corrective)
        {
            CaptionML = ENU = 'Corrective', FRA = 'Correctif';
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
        modify("Allow Line Disc.")
        {
            CaptionML = ENU = 'Allow Line Disc.', FRA = 'Autoriser remise ligne';
        }
        modify("Get Shipment Used")
        {
            CaptionML = ENU = 'Get Shipment Used', FRA = 'Extraire le mode d''expédition utilisé';
        }
        field(50000; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            Description = 'HEI.01';
            TableRelation = "WHT Business Posting Group FND";
        }
        field(50002; "Rem. WHT Prepaid Amt LCY FND"; Decimal)
        {
            CalcFormula = Sum("WHT Entry FND"."Remaining Unrealized Amount" where("Document Type" = CONST(Invoice),
                                                                               "Document No." = FIELD("No.")));
            Caption = 'Paid WHT Prepaid Amount (LCY) FND';
            Description = 'HEI.01';
            FieldClass = FlowField;
        }
        field(50003; "Paid WHT Prepaid Amt LCY FND"; Decimal)
        {
            CalcFormula = Sum("WHT Entry FND".Amount where("Document Type" = CONST(Payment),
                                                        "Document No." = FIELD("No.")));
            Caption = 'Total WHT Prepaid Amount (LCY)';
            Description = 'HEI.01';
            FieldClass = FlowField;
        }
        field(50004; "Total WHT Prepaid Amt LCY FND"; Decimal)
        {
            CalcFormula = Sum("WHT Entry FND"."Unrealized Amount" where("Document Type" = CONST(Invoice),
                                                                     "Document No." = FIELD("No.")));
            Caption = 'Total WHT Prepaid Amount (LCY)';
            Description = 'HEI.01';
            FieldClass = FlowField;
        }
        field(50005; "Posted Whse. Shpmt No. FND"; Code[20])
        {
            Caption = 'Posted Whse. Shipment No.';
            Description = 'LOGGAP07';
        }
        field(50006; "Whse. Shipment No. FND"; Code[20])
        {
            Caption = 'Whse. Shipment No.';
            Description = 'LOGGAP07';
        }
        field(50007; "XML Printed FND"; Boolean)
        {
            Caption = 'XML Printed';
            Description = 'HEI.04';
        }
        field(50008; "Fiscal Document FND"; Boolean)
        {
            Caption = 'Fiscal Document';
            Description = 'HEI.04';
        }
        field(50009; "Fiscal Document No. FND"; Code[50])
        {
            Caption = 'Fiscal Document No.';
            Description = 'HEI.04';
        }
        field(50010; "Print Station Serial FND"; Code[30])
        {
            Caption = 'Print Station Serial';
            Description = 'HEI.04';
        }
        field(50011; "Print Date/Time FND"; DateTime)
        {
            Caption = 'Print Date/Time';
            Description = 'HEI.04';
        }
        field(50012; "Sales Routes FND"; Code[10])
        {
            Caption = 'Sales Routes';
            Description = 'HEI.05';
            TableRelation = "Sales Routes FND";
        }
        field(50013; "Bonus Credit Memo FND"; Boolean)
        {
            Caption = 'Bonus Credit Memo';
            Description = 'HEI.06';
            Editable = false;
        }
        field(50016; "Vans Sales Route FND"; Boolean)
        {
            Caption = 'Vans Sales Route';
            Description = 'HEI.14';
        }
        field(50017; "Doc. Amount Incl. VAT FND"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'Doc. Amount Incl. VAT',
                        FRA = 'Montant doc. TTC';
            Description = 'HEI.14';
        }
        field(50018; "Doc. Amount VAT FND"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'Doc. Amount VAT',
                        FRA = 'Montant TVA doc.';
            Description = 'HEI.14';

            trigger OnValidate();
            var
                Sign: Decimal;
            begin
            end;
        }


        field(50023; "Bill Of Lading No. FND"; Text[20])
        {
            Caption = 'Bill Of Lading No.';
            Description = 'HEI.10';
        }
        field(50024; "Vessel Name FND"; Text[30])
        {
            Caption = 'Vessel Name';
            Description = 'HEI.10';
        }
        field(50025; "ETD FND"; DateTime)
        {
            Caption = 'ETD';
            Description = 'HEI.10';
        }
        field(50026; "ETA FND"; DateTime)
        {
            Caption = 'ETA';
            Description = 'HEI.10';
        }
        field(50027; "Air Way Bill No FND"; Text[20])
        {
            Caption = 'Air Way Bill No';
            Description = 'HEI.10';
        }
        field(50028; "Commodity Code FND"; Text[20])
        {
            Caption = 'Commodity Code';
            Description = 'HEI.10';
        }
        field(50029; "Custom Tariff Code FND"; Text[20])
        {
            Caption = 'Custom Tariff Code';
            Description = 'HEI.10';
        }
        field(50030; "InCo Terms FND"; Code[20])
        {
            Caption = 'InCo Terms';
            Description = 'HEI.11';
        }

        field(50033; "Country of Origin FND"; Code[10])
        {
            Caption = 'Country of Origin';
            Description = 'HEI.13';
            TableRelation = "Country/Region";
        }
        field(50041; "Special Order FND"; Boolean)
        {
            Caption = 'Special Order';
            Description = 'HEI.14';
        }
        field(50043; "Invoice Receipt No. FND"; Text[100])
        {
            Caption = 'Invoice Receipt No.';
            Description = 'HEI.15';
        }
        field(50050; "Send Document FND"; Option)
        {
            CaptionML = ENU = 'Send Document',
                        FRA = 'Envoyer Document';
            Description = 'HEI.16';
            Editable = false;
            OptionCaptionML = ENU = ' ,Mail,Print,Mail & Print',
                              FRA = ' ,E-Mail,Imprimer,E-Mail & Imprimer';
            OptionMembers = " ",Mail,Print,"Mail & Print";
        }
        field(50051; "Mail Sent FND"; Boolean)
        {
            Caption = 'Mail Sent';
            Description = 'HEI.16';
            Editable = false;
        }

        field(50061; "CAD Amount FND"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            // CalcFormula = Sum("Sales Invoice Line"."CAD Amount" where("Document No." = FIELD("No."),
            //                                                            "Item Charge Type" = FIELD("Item Charge Type Filter")));
            CalcFormula = Sum("Sales Invoice Line"."CAD Amount FND" where("Document No." = FIELD("No.")));  // BC Upgrade BHARDA11 --- Add ));
                                                                                                            //    "Item Charge Type" = FIELD("Item Charge Type Filter"))); // BC Upgrade BHARDA11 ----Drink-IT Field ("Item Charge Type")
            CaptionML = ENU = 'CAD Amount',
                        FRA = 'CAD Montant';
            Description = 'HEI.21';
            Editable = false;
            FieldClass = FlowField;
        }

        field(50019; "Fiscal Printer Status FND"; Option)
        {
            Caption = 'Fiscal Printer Status';
            Description = 'HEI.08,HEI.12';
            OptionCaption = 'Not Processed,Not Sent to Middleware,Sent to Middleware,Not Sent to Fiscal Printer,Received in Fiscal Printer,2nd Request Not Sent to Middleware,Error in Fiscal Printer or RRA,Fiscal Printer No. Received';
            OptionMembers = "Not Processed","Not Sent to Middleware","Sent to Middleware","Not Sent to Fiscal Printer","Received in Fiscal Printer","2nd Request Not Sent to Middleware","Error in Fiscal Printer or RRA","Fiscal Printer No. Received";
        }
        field(50020; "SDC Information Approved FND"; Boolean)
        {
            // CalcFormula = Exist("EBM Log" WHERE("Document No." = FIELD("No.")));
            Caption = 'SDC Information Approved';
            // Description = 'HEI.08';
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(50021; "Load No. FND"; Integer)
        {
            Caption = 'Load No.';
            Description = 'HEI.09';
        }
        field(50022; "Sequence No. FND"; Integer)
        {
            Caption = 'Sequence No.';
            Description = 'HEI,09';
        }
        field(50031; "Suppress POS Interface FND"; Boolean)
        {
            Caption = 'Suppress POS Interface';
            Description = 'HEI.12';
        }
        field(50060; "Source System Identifier FND"; Code[10])
        {
            Caption = 'Source System Identifier';
            Description = 'HEI.19';
            Editable = false;
            TableRelation = "Source Sys Identifier API FND";
        }
        // BC Upgrade BHARDA11 >> ----Drink-IT Fields
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
        //     Description = 'DITW15.00.00.35';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost";
        // }
        // field(2013726; "Customer Tax Registration No."; Text[20])
        // {
        //     CaptionML = ENU = 'Customer Tax Registration No.',
        //                 FRA = 'N° ident. accise client';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        // }
        // field(2013730; "Fiscal Representative No."; Code[20])
        // {
        //     CaptionML = ENU = 'Fiscal Representative / Customs Agent No.',
        //                 FRA = 'N° représentant fiscal / Agent des douanes';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
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
        //     Description = 'DITW15.00.00.39 #1328';
        // }
        // field(2014064; "Shipping Charge Per"; Option)
        // {
        //     CaptionML = ENU = 'Shipping Charge Per',
        //                 FRA = 'Frais transport par';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     OptionCaptionML = ENU = 'Shipment,Weight,Volume',
        //                       FRA = 'Expédition,Poids,Volume';
        //     OptionMembers = Shipment,Weight,Volume;
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
        // field(2014087; Distance; Decimal)
        // {
        //     CaptionML = ENU = 'Distance',
        //                 FRA = 'Distance';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.24';
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
        // field(2014100; "Trailer Code"; Code[10])
        // {
        //     Caption = 'Trailer Code';
        //     Description = 'NRQ16082';
        // }
        // field(2014107; Route; Code[20])
        // {
        //     CaptionML = ENU = 'Route',
        //                 FRA = 'Itinéraire';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     TableRelation = Route;
        // }
        // field(2014109; "Route Planning No."; Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'NRQ17902';
        //     TableRelation = "Route Planning Worksheet";
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
        field(50090; "Document Subtype Code FND"; Code[10])
        {
            CaptionML = ENU = 'Document Subtype Code',
                        FRA = 'Code Sous-Type Document';
            Description = 'DITW18.00.07 DIT-770 #1508';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Sales | "Fin.Contract"));
        }
        //BC UPGRADE KUMARR78 >> Field Adding for (Truck/Vehicle) Code
        field(50091; "Vehicle Code HNK FND"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vehicle Code';
            TableRelation = Vehicle101FDW;
        }
        //BC UPGRADE KUMARR78 << Field Adding for Truck/Vehicle Code
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
        // field(2014497; "Invoice List Document No."; Code[20])
        // {
        //     CaptionML = ENU = 'Invoice List Document No.',
        //                 FRA = 'N° document liste facture';
        //     Description = 'DITW17.10.05 DIT-715 #761,DIT-770 #1723';
        //     TableRelation = "Invoice List"."Document No.";
        // }
        // field(2017760; "Disable DIT Disc. Prom."; Option)
        // {
        //     Caption = 'Disable DIT Discount Promotion';
        //     Description = 'DITW111.00.13A MSF 09/05/2019 NRQ#109271';
        //     OptionCaption = '" ,Discount,Promotion,All"';
        //     OptionMembers = " ",Discount,Promotion,All;
        // }
        // field(2029610; OGM; Text[30])
        // {
        //     CaptionML = ENU = 'OGM',
        //                 FRA = 'OGM';
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
        //     Description = 'DIT-715 #392- DITW18.00.06 MSF 31/07/2015 DIT-770 #1368';
        //     OptionCaptionML = ENU = ' ,Service,Financial',
        //                       FRA = ' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Fields
    }
    keys
    {
        // BC Upgrade BHARDA11 >> ---- Drink-IT Fields ("Link Sales Document No.","Entry Type","Order Type","Invoice List Customer No.")
        // key(Key14; "Link Sales Document No.")
        // {
        //     Enabled = false;
        // }
        // key(Key15; "Entry Type", "Order Date", "Order Type")
        // {
        // }
        // key(Key16; "Invoice List Customer No.", "Currency Code", "Posting Date")
        // {
        // }
        // BC Upgrade BHARDA11 << ---- Drink-IT Fields ("Link Sales Document No.","Entry Type","Order Type","Invoice List Customer No.")

    }
    // BC Upgrade BHARDA11 >> ---Drink-IT Functions (GetSalesInvLines(),SumSalesInvLinesTemp(), SumSalesInvLines2(),IncrAmount(),Increment(),EmailShipmentSpecs)
    // PROCEDURE GetSalesInvLines(VAR NewSalesInvLine: Record 113);
    // VAR
    //     OldSalesInvLine: Record 113;
    // BEGIN
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     SumSalesInvLines2(NewSalesInvLine, OldSalesInvLine, TRUE);
    // end;

    // PROCEDURE SumSalesInvLinesTemp(VAR OldSalesInvLine: Record 113; VAR NewTotalSalesInvLine: Record 113; VAR NewTotalSalesInvLineLCY: Record 113; VAR VATAmount: Decimal; VAR VATAmountText: Text[30]);
    // VAR
    //     LText016: Label 'ENU=VAT Amount;FRA=Montant TVA';
    //     LText017: Label 'ENU=%1% VAT;FRA=TVA %1%';
    //     SalesInvLine: Record 113;
    // BEGIN
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     SumSalesInvLines2(SalesInvLine, OldSalesInvLine, FALSE);

    //     VATAmount := TotalSalesInvLine."Amount Including VAT" - TotalSalesInvLine.Amount;
    //     IF TotalSalesInvLine."VAT %" = 0 THEN
    //         VATAmountText := LText016
    //     else
    //         VATAmountText := STRSUBSTNO(LText017, TotalSalesInvLine."VAT %");
    //     NewTotalSalesInvLine := TotalSalesInvLine;
    //     NewTotalSalesInvLineLCY := TotalSalesInvLineLCY;
    // end;

    // LOCAL PROCEDURE SumSalesInvLines2(VAR NewSalesInvLine: Record 113; VAR OldSalesInvLine: Record 113; InsertSalesInvLine: Boolean);
    // VAR
    //     CurrExchRate: Record 330;
    //     SalesInvLineQty: Decimal;
    //     NoVAT: Boolean;
    // BEGIN
    //     NewSalesInvLine.CalcVATAmountLinesTemp(Rec, OldSalesInvLine, TempVATAmountLine);

    //     IF "Currency Code" = '' THEN
    //         Currency.InitRoundingPrecision
    //     else
    //         Currency.GET("Currency Code");

    //     OldSalesInvLine.SETRANGE("Document No.", "No.");
    //     OldSalesInvLine.SETFILTER(Type, '>0');
    //     OldSalesInvLine.SETFILTER(Quantity, '<>0');
    //     IF GETFILTER("Item Charge Type Filter") <> '' THEN
    //         COPYFILTER("Item Charge Type Filter", OldSalesInvLine."Item Charge Type");

    //     WITH OldSalesInvLine DO BEGIN
    //         IF FIND('-') THEN
    //             REPEAT
    //                 IF Amount <> 0 THEN
    //                     IF TotalSalesInvLine.Amount = 0 THEN
    //                         TotalSalesInvLine."VAT %" := "VAT %"
    //                     else
    //                         IF TotalSalesInvLine."VAT %" <> "VAT %" THEN
    //                             TotalSalesInvLine."VAT %" := 0;

    //                 IncrAmount(OldSalesInvLine, TotalSalesInvLine);
    //                 Increment(TotalSalesInvLine."Net Weight", ROUND(SalesInvLineQty * "Net Weight", 0.00001));
    //                 Increment(TotalSalesInvLine."Gross Weight", ROUND(SalesInvLineQty * "Gross Weight", 0.00001));
    //                 Increment(TotalSalesInvLine."Unit Volume", ROUND(SalesInvLineQty * "Unit Volume", 0.00001));
    //                 Increment(TotalSalesInvLine.Quantity, SalesInvLineQty);
    //                 IF "Units per Parcel" > 0 THEN
    //                     Increment(
    //                       TotalSalesInvLine."Units per Parcel",
    //                       ROUND(SalesInvLineQty / "Units per Parcel", 1, '>'));

    //                 IF Rec."Currency Code" <> '' THEN BEGIN
    //                     NoVAT := Amount = "Amount Including VAT";
    //                     "Amount Including VAT" :=
    //                       ROUND(
    //                         CurrExchRate.ExchangeAmtFCYToLCY(
    //                           Rec."Posting Date", Rec."Currency Code",
    //                           TotalSalesInvLine."Amount Including VAT", Rec."Currency Factor")) -
    //                             TotalSalesInvLineLCY."Amount Including VAT";
    //                     IF NoVAT THEN
    //                         Amount := "Amount Including VAT"
    //                     else
    //                         Amount :=
    //                           ROUND(
    //                             CurrExchRate.ExchangeAmtFCYToLCY(
    //                               Rec."Posting Date", Rec."Currency Code",
    //                               TotalSalesInvLine.Amount, Rec."Currency Factor")) -
    //                                 TotalSalesInvLineLCY.Amount;
    //                     "Line Amount" :=
    //                       ROUND(
    //                         CurrExchRate.ExchangeAmtFCYToLCY(
    //                           Rec."Posting Date", Rec."Currency Code",
    //                           TotalSalesInvLine."Line Amount", Rec."Currency Factor")) -
    //                             TotalSalesInvLineLCY."Line Amount";
    //                     "Line Discount Amount" :=
    //                       ROUND(
    //                         CurrExchRate.ExchangeAmtFCYToLCY(
    //                           Rec."Posting Date", Rec."Currency Code",
    //                           TotalSalesInvLine."Line Discount Amount", Rec."Currency Factor")) -
    //                             TotalSalesInvLineLCY."Line Discount Amount";
    //                     "Inv. Discount Amount" :=
    //                       ROUND(
    //                         CurrExchRate.ExchangeAmtFCYToLCY(
    //                           Rec."Posting Date", Rec."Currency Code",
    //                           TotalSalesInvLine."Inv. Discount Amount", Rec."Currency Factor")) -
    //                             TotalSalesInvLineLCY."Inv. Discount Amount";
    //                     "VAT Difference" :=
    //                       ROUND(
    //                         CurrExchRate.ExchangeAmtFCYToLCY(
    //                           Rec."Posting Date", Rec."Currency Code",
    //                           TotalSalesInvLine."VAT Difference", Rec."Currency Factor")) -
    //                             TotalSalesInvLineLCY."VAT Difference";
    //                     // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
    //                     "VAT Base Amount" :=
    //                       ROUND(
    //                         CurrExchRate.ExchangeAmtFCYToLCY(
    //                           Rec."Posting Date", Rec."Currency Code",
    //                           TotalSalesInvLine."VAT Base Amount", Rec."Currency Factor")) -
    //                             TotalSalesInvLineLCY."VAT Base Amount";
    //                     // >>DITW16.00.00.40 DDR DIT-715 #172
    //                 end;

    //                 IncrAmount(OldSalesInvLine, TotalSalesInvLineLCY);
    //                 Increment(TotalSalesInvLineLCY."Unit Cost (LCY)", ROUND(SalesInvLineQty * "Unit Cost (LCY)"));

    //                 IF InsertSalesInvLine THEN BEGIN
    //                     NewSalesInvLine := OldSalesInvLine;
    //                     NewSalesInvLine.INSERT;
    //                 end;
    //             UNTIL NEXT = 0;
    //     end;
    // end;

    // LOCAL PROCEDURE IncrAmount(SalesInvLine2: Record 113; VAR TotalSalesInvLine: Record 113);
    // BEGIN
    //     WITH SalesInvLine2 DO BEGIN
    //         IF "Prices Including VAT" OR
    //            ("VAT Calculation Type" <> "VAT Calculation Type"::"Full VAT")
    //         THEN
    //             Increment(TotalSalesInvLine."Line Amount", "Line Amount");
    //         Increment(TotalSalesInvLine.Amount, Amount);
    //         Increment(TotalSalesInvLine."VAT Base Amount", "VAT Base Amount");
    //         Increment(TotalSalesInvLine."VAT Difference", "VAT Difference");
    //         Increment(TotalSalesInvLine."Amount Including VAT", "Amount Including VAT");
    //         Increment(TotalSalesInvLine."Line Discount Amount", "Line Discount Amount");
    //         Increment(TotalSalesInvLine."Inv. Discount Amount", "Inv. Discount Amount");
    //     end;
    // end;

    // LOCAL PROCEDURE Increment(VAR Number: Decimal; Number2: Decimal);
    // BEGIN
    //     Number := Number + Number2;
    // end;

    // PROCEDURE PrintShipmentSpecs(ShowRequestForm: Boolean);
    // VAR
    //     DocumentSendingProfile: Record 60;
    //     DummyReportSelections: Record 77;
    // BEGIN
    //     //<< DITW110.00.08 DDR 17/02/2017 NRQ#0 #20755
    //     /// DITW17.00.02 RPG 18/12/2013 DIT-770 #235
    //     /// DITW18.00 MSF 27/04/2015 DIT-770 #1363
    //     /// DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
    //     DocumentSendingProfile.TrySendToPrinter(
    //       DummyReportSelections.AddUsageDIT(DummyReportSelections.UsageDIT::"Shpt.Spec."), Rec, "Bill-to Customer No.", ShowRequestForm);
    // end;

    // PROCEDURE EmailShipmentSpecs(ShowDialog: Boolean);
    // VAR
    //     DocumentSendingProfile: Record 60;
    //     DummyReportSelections: Record 77;
    // BEGIN
    //     // <<DITW110.00.08 DDR 16/02/2017 NRQ#20755
    //     DocumentSendingProfile.TrySendToEMail(
    //       DummyReportSelections.AddUsageDIT(DummyReportSelections.UsageDIT::"Shpt.Spec."), Rec, FIELDNO("No."), DocTxt, FIELDNO("Bill-to Customer No."), ShowDialog);
    // end;
    // BC Upgrade BHARDA11 << ---Drink-IT Functions (GetSalesInvLines(),SumSalesInvLinesTemp(), SumSalesInvLines2(),IncrAmount(),Increment(),EmailShipmentSpecs)


    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "DocTxt(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DocTxt : ENU=Invoice;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DocTxt : ENU=Invoice;FRA=Facture;
    //Variable type has not been exported.

    var
        // DocTxt: Label 
        // TotalSalesInvLine: Record "Sales Invoice Line";
        // TotalSalesInvLineLCY: Record "Sales Invoice Line";
        // TempVATAmountLine: Record "VAT Amount Line" temporary;
        Currency: Record Currency;
    // cduSingleInstaceFunctions: Codeunit "Single Instance Functions";
}

