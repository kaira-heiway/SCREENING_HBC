tableextension 50205 SalesCrMemoHeaderExtFND extends "Sales Cr.Memo Header"
{
    // version NAVW110.0.00.15601,FINXL10.00,DITW110.00.11,HEI.17
    /* {
          DITW15.00.00.01 DDR 27/12/2007 Added fields
                                           2034647 Drink Tax Group Code
          DITW15.00.00.01 DDR 02/01/2008 rename field
                                           2034647 Customer DTax Group Code + Filter to the source table
          DITW15.00.00.01 DDR 04/01/2008 added field
                                           2013610 Customer DDeposit Group Code
          DITW15.00.00.01 DDR 31/01/2008 Added Drink-it Reversing Calculation (Rounding) functionnalities
                                         Added fields
                                           2034690 Price Incl. Reversing Calc.
          DITW15.00.00.01 DDR 27/02/2008 Remove field (see lines)
                                           2034690 Price Incl. Reversing Calc.
                                         Added fields
                                           2013613 Link Sales Document No.
                                         Added key
                                           "Link Sales Document No."
          DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
          DITW15.00.00.20 DDR 11/06/2008 Certification rules
          DITW15.00.00.24 DDR 07/10/2008 Added fields
                                           2013722 Duty Tax Type
          DITW15.00.00.25 DDR 16/10/2008 Added fields
                                           2014077 Truck Code
                                           2014078 Driver Code
                              21/10/2008 Deleted fields
                                           2013722 Duty Tax Type
          DITW15.00.00.35 DDR 22/06/2009 Added fields
                                           2013695 Item Charge Type Filter
                                         Added "Item Charge Type Filter" into calcformula property fields
                                           "Amount","Amount Including VAT"
                                         Added functions
                                           GetSalesCrMemoLines(),SumSalesCrMemoLinesTemp(),
                                           SumSalesCrMemoLines2(),IncrAmount(),Increment()
                              25/06/2009 Added fields
                                           2013824 Gen. Bus. Posting Free Group
                              13/10/2009 Added fields
                                           2034840 Building No.
          DITW15.00.00.38 DDR 13/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
                                           Added fields
                                             2014271 Tax Warehouse Reference
          DITW15.00.00.39 RBE 20/04/2011 issue 1230 Telesales functionnalities
                                           Added fields
                                             2013936 Order Type
                                             2013937 Entry Type
                                           Added key "Document No.,Unit of Measure Code       SumIndexFields=Quantity"
                              19/08/2011 issue 1363
                                           Added fields
                                             2013733 Tax Date
          DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added fields "Allow VAT Calculation (Free)" to calculate VAT on free items
                              20/01/2012 DIT-715 #172 Modified workflow (+Rollback)
          DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392
                                         Added fields
                                           2034850 DIT Sub-Contract Type
                                           2034872 Contract Group Code
                                           2034915 Service Contract No.
                                           2014311 Service Contract Type
                          AHU 31/08/2012 DIT-715 #327 Renamed Captions fields2034915,2034310,2014311
          DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields
                                                        2013630 Deposit Cust. Posting Group
                                                        2013631 Deposit Payment Terms Code
                                                        2013632 Deposit Payment Method Code
                                                        2013633 Deposit Bal. Account Type
                                                        2013634 Deposit Bal. Account No.
                          AHU 30/01/2013 DIT-715 #395 Added 'DrillDownFormID' property table
          DITW16.00.00.43 FBL 28/06/2013 DIT-715 #619 Add field 2034920 "Contract Next Invoice Date" (Date)
          DITW16.00.00.44 DDR 19/03/2014 DIT-715 #910 Added DIT fields
                                                        2013726 Customer Tax Registration No.
                                                        2013730 Fiscal Representative No.
                                                        2013825 Free Item Posting Type
                                                        2013910 Telesales Entry
                                                        2013969 Pos System-Created Entry
                                                        2014064 Shipping Charge Per
                                                        2014087 Distance
                                                        2014107 Route
                                                        2014495 Delivery Sequence
          DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
          DITW17.00.02 SR 19/12/2013 DIT-770 #163 : Remove the "DIT Sub-Contract Type" filter in "Service Contract No." field
          DITW17.00.03 DDR 20/03/2014 DIT-715 #910 merge
          DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added fields
                                                                   2014410 Physical Location Group Code
          DITW18.00.06 DDR 25/02/2015 DIT-770 #1190 Multisite - Modified function SetSecurityFilterOnRespCenter()
          DITW17.10.05 WSA 04/08/14 DIT-770 #761 : Added field "Invoice List Customer No."
          DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
          DITW17.10.05 WSA 10/11/2014 DIT-770 #779 Added Events Fields
          DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
          FINXL8.00.001 BSA 12/06/2015 #67 : Print Report with different method
          DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
                                                    Added field "Financial Contract No."
                                                    Rename Caption Contract No. by Service contract No.
                                                    Change ID of field Contract Type to Foundation layer 2035393
                                                    Added blank Option to Contract Type
          DITW18.00.07 VSC 11/01/2016 DIT-770 #1721 Change SalesCrMemoHeader param on function SendReport(,,,) to VAR
          DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field 2014420 "Sundry Customer"
          DITW18.00.07 WSA 23/03/2016 DIT-770 #1723 Added Field Invoice List Document no.
          DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field 2014421 "Document Subtype Code"
          DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code
          DITW18.00.07 AKH 20/04/2016 DIT-770 #1508 Adjusted filtering code
          DITW18.00.07 AKH 29/04/2016 DIT-770 #1346 Added field 2014080 "Customer Delivery Type"
          DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
          DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time", "Created By"
          DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
          DITW110.00.08 DDR 16/02/2017 NRQ#20755 Update document subtype code table relation filter
          DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
          FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
          DITW110.00.11 MSF 25/08/2017 NRQ#17902 Route settlement - Order Payments, Suggest customer and vendor payments
                                           2014109 Route Planning No.
          DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added fields "Require 2 Drivers" & Driver 2 Code & "Trailer Code"

          HEI.01 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
            # New field "WHT Business Posting Group"
          HEI.02 FDD-SLSGAP001 IBM NASTAA02 07.09.2017 # MDM Customer Card
            # Increased "Bill-to Address", "Sell-to Address" and "Ship-to Address" fields length from 50 to 60 characters
            # Increased "Bill-to City", "Sell-to City" and "Ship-to City" fields length from 30 to 35 characters
          HEI.03 FDD-OTCGAP01 IBM ISYED01 28.11.2017
          Added fields XML Printed,Fiscal Document,Fiscal Document No.,Print Station Serial,Print Date/Time to table
          HEI.04 FDD-HNK LOGGAP001 03/12/2017 IBM.CHAUHB01
            # Added new field "Sales Routes"
          HEI.05 FDD-OTCGAP051 IBM NASTAA02 06.03.2018 # Document Subtype Code non-editable for Bonus Credit Memos
            # New Field created: 50013 - "Bonus Credit Memo"
          HEI.06 RW-GAPLOG08 IBM LAZARE02 23.10.2018 # New fields EBM Status, SDC Information Approved for EBM interface
          HEI.07 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
          HEI.08 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
            # New Field created: 50031 - Suppress POS Interface
            # Renamed Field 50019 - "EBM Status" to "Fiscal Printer Status"
            # Renamed Options of Field 50019 from "EBM" to "Fiscal Printer"
          HEI.09 FDD-SR_HT543a IBM HORTOC01 #New field "Vans Sales Route"
          HEI.10 FDD-HT657 IBM NASTAA02 15.11.2019 # Ethiopia Intercompany Automation
            # New Field created: 50041 - Special Order
          HEI.11 CHG2044105 IBM.AB 07.01.2020
            # New field Invoice Receipt No Created
          HEI.12 CHG2010375 IBM.LS 21.01.2020
            # New Field created: 50050 - "Send Document"
            # New Field created: 50051 - "Mail Sent"
          HEI.13 Defect #5296 IBM NASTAA02 02.04.2020 # The translation of shipment date in french is not right
            # Changed French Caption for "Shipment Date" field to 'Date d'exp‚dition'
          HEI.14 CHG2065153 IBM KUMARN15 23.06.2020
            # Added field "Source System Identifier"
          HEI.15 INC2924918 IBM NASTAA02 01.07.2020 # Your reference field in Sales Return Order should be 50 Characters
            # Increased length of Field 11 - Your Reference from 35 to 50 characters
          HEI.16 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
            # New Field created: 50061 -  CAD Amount
          HEI.17 CHG2266917 COSTES04 04.09.2024 Electronic invoice interface
            # New field Sent to Electronic Invoice
        } */


    // BC Upgrade BHARDA11 >>
    // Migration from NAV 2018 to Business Central 26
    // Table Extension: Sales Cr.Memo Header (50198)
    // Changes:
    // 1. Commented out ALL Drink-IT custom fields (Range 2013610..2035393) - Total 47 fields commented
    // 2. Commented out ALL Drink-IT custom keys - Total 2 keys commented:
    //    - Key2: "Link Sales Document No."
    //    - Key3: "Entry Type", "Document Date", "Order Type"
    // 3. Field length changes attempted but NOT IMPLEMENTED (BC does not allow field length modification in extensions):
    //    - "Bill-to Address" : Attempted increase 50→60, BC already has 100 (no change needed)
    //    - "Bill-to Address 2" : Attempted increase 50→60, BC base is 50 (cannot modify)
    //    - "Bill-to City" : Attempted increase 30→35, BC base is 30 (cannot modify)
    //    - "Ship-to Address" : Attempted increase 50→60, BC already has 100 (no change needed)
    //    - "Ship-to Address 2" : Attempted increase 50→60, BC base is 50 (cannot modify)
    //    - "Ship-to City" : Attempted increase 30→35, BC base is 30 (cannot modify)
    //    - "Sell-to Address" : Attempted increase 50→60, BC already has 100 (no change needed)
    //    - "Sell-to Address 2" : Attempted increase 50→60, BC base is 50 (cannot modify)
    //    - "Sell-to City" : Attempted increase 30→35, BC base is 30 (cannot modify)
    //    - "Your Reference" : Attempted increase 35→50, BC base is 35 (cannot modify) (HEI.15)
    //    - "Customer Posting Group" : Field length 20 in BC (no change from NAV)
    //    - "Salesperson Code" : Field length 20 in BC (no change from NAV)
    //    - "Pre-Assigned No. Series" : Field length 20 in BC (no change from NAV)
    //    - "No. Series" : Field length 20 in BC (no change from NAV)
    //    - "Return Order No." : Field length 20 in BC (no change from NAV)

    // 4. Commented out ALL Drink-IT custom procedures/functions - Total 6 functions commented:
    //    - SetSecurityFilterOnRespCenter()
    //    - GetSalesCrMemoLines()
    //    - SumSalesCrMemoLinesTemp()
    //    - SumSalesCrMemoLines2()
    //    - IncrAmount()
    //    - Increment()
    // 5. Modified CalcFormula for field 50061 "CAD Amount" - Removed Drink-IT field reference "Item Charge Type Filter"
    // 
    // Drink-IT Custom Fields Commented:
    // - 2013610: Customer DDeposit Group Code
    // - 2013613: Link Sales Document No.
    // - 2013630-2013634: Deposit fields (Cust. Posting Group, Payment Terms/Method Code, Bal. Account Type/No.)
    // - 2013667: Customer DTax Group Code
    // - 2013695: Item Charge Type Filter
    // - 2013726: Customer Tax Registration No.
    // - 2013730: Fiscal Representative No.
    // - 2013733: Tax Date
    // - 2013823: Gen. Bus. Posting Free Group
    // - 2013825: Free Item Posting Type
    // - 2013910: Telesales Entry
    // - 2013936-2013937: Order Type, Entry Type
    // - 2013969: Pos System-Created Entry
    // - 2014064: Shipping Charge Per
    // - 2014077-2014078: Truck Code, Driver Code
    // - 2014080: Customer Delivery Type
    // - 2014087: Distance
    // - 2014098-2014100: Require 2 Drivers, Driver 2 Code, Trailer Code
    // - 2014107: Route
    // - 2014109: Route Planning No.
    // - 2014313: Financial Contract No.
    // - 2014361-2014363: Event No., Event Status, Event Description
    // - 2014410: Physical Location Group Code
    // - 2014411-2014412: Creation Date/Time, Created By
    // - 2014420: Sundry Customer
    // - 2014421: Document Subtype Code
    // - 2014495: Delivery Sequence
    // - 2014496: Invoice List Customer No.
    // - 2014497: Invoice List Document No.
    // - 2029610: OGM
    // - 2034840: Building No.
    // - 2034850: DIT Sub-Contract Type
    // - 2034872: Contract Group Code
    // - 2034915: Service Contract No.
    // - 2034920: Contract Next Invoice Date
    // - 2035393: Contract Type
    // 
    // Drink-IT Custom Functions Commented:
    // - SetSecurityFilterOnRespCenter(): Responsibility center security filter
    // - GetSalesCrMemoLines(): Get sales credit memo lines with VAT
    // - SumSalesCrMemoLinesTemp(): Sum sales credit memo lines temporary
    // - SumSalesCrMemoLines2(): Internal sum calculation
    // - IncrAmount(): Increment amount calculation
    // - Increment(): Generic increment function
    // BC Upgrade BHARDA11 <<

    // BC Upgrade SHUKLP03 >> Added new field Document Subtype Code (50090).

    // namespace Testing.Testing;

    // using Microsoft.Sales.History;
    /* 
    HEI.06 RW-GAPLOG08 IBM LAZARE02 23.10.2018 # New fields EBM Status, SDC Information Approved for EBM interface
              HEI.07 FDD-SR_HT464_Ortec Interface "IBM HORTOC01 30.05.2019 -" #new fields added "Load No." & "Sequence No."
              HEI.08 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
                # New Field created: 50031 - Suppress POS Interface
                # Renamed Field 50019 - "EBM Status" to "Fiscal Printer Status"
                # Renamed Options of Field 50019 from "EBM" to "Fiscal Printer"
    HEI.17 CHG2266917 COSTES04 04.09.2024 Electronic invoice interface
                # New field Sent to Electronic Invoice
                 HEI.14 CHG2065153 IBM KUMARN15 23.06.2020
                # Added field "Source System Identifier"
                 HEI.17 CHG2266917 COSTES04 04.09.2024 Electronic invoice interface
                # New field Sent to Electronic Invoice
     */
    // BC Upgrade BHARDA11 --- For Interface fields only 
    // BC Upgrade PATELP08>>
    // Changed name of table from "EBM Log" to "EBM Log FND"
    // Changed table ext name from "SalesCrMemoHeaderExt_Interface" to "SalesCrMemoHeaderExt_IntFND"
    // BC Upgrade PATELP08<<


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
            // BC Upgrade BHARDA11 --Field length Change 50 to 60 , Not Possible in Business central, Now field length is 100.
            //Unsupported feature: Change Data type on ""Bill-to Address"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Bill-to Address', FRA = 'Adresse facturation';
            Description = 'HEI.02';
            //Unsupported feature: Change Description on ""Bill-to Address"(Field 7)". Please convert manually.

        }
        modify("Bill-to Address 2")
        {
            // BC Upgrade BHARDA11 --Field length Change 50 to 60 , Not Possible in Business central, Now field length is 50.

            //Unsupported feature: Change Data type on ""Bill-to Address 2"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Bill-to Address 2', FRA = 'Adresse (2ème ligne)';
            Description = 'HEI.02';

            //Unsupported feature: Change Description on ""Bill-to Address 2"(Field 8)". Please convert manually.

        }
        modify("Bill-to City")
        {
            // BC Upgrade BHARDA11 --Field length Change 30 to 35 , Not Possible in Business central, Now field length is 30.

            //Unsupported feature: Change Data type on ""Bill-to City"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Bill-to City', FRA = 'Ville';
            Description = 'HEI.02';

            //Unsupported feature: Change Description on ""Bill-to City"(Field 9)". Please convert manually.

        }
        modify("Bill-to Contact")
        {
            CaptionML = ENU = 'Bill-to Contact', FRA = 'Contact';
        }
        modify("Your Reference")
        {
            // BC Upgrade BHARDA11 --Field length Change 35 to 55 , Not Possible in Business central, Now field length is 35.

            //Unsupported feature: Change Data type on ""Your Reference"(Field 11)". Please convert manually.

            CaptionML = ENU = 'Your Reference', FRA = 'Votre référence';
            Description = 'HEI.15';

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
            // BC Upgrade BHARDA11 --Field length Change 50 to 60 , Not Possible in Business central, Now field length is 100.

            //Unsupported feature: Change Data type on ""Ship-to Address"(Field 15)". Please convert manually.

            CaptionML = ENU = 'Ship-to Address', FRA = 'Adresse destinataire';
            Description = 'HEI.02';
            //Unsupported feature: Change Description on ""Ship-to Address"(Field 15)". Please convert manually.

        }
        modify("Ship-to Address 2")
        {
            // BC Upgrade BHARDA11 --Field length Change 50 to 60 , Not Possible in Business central, Now field length is 50.

            //Unsupported feature: Change Data type on ""Ship-to Address 2"(Field 16)". Please convert manually.

            CaptionML = ENU = 'Ship-to Address 2', FRA = 'Adresse destinataire 2';
            Description = 'HEI.02';

            //Unsupported feature: Change Description on ""Ship-to Address 2"(Field 16)". Please convert manually.

        }
        modify("Ship-to City")
        {
            // BC Upgrade BHARDA11 --Field length Change 30 to 35 , Not Possible in Business central, Now field length is 30.

            //Unsupported feature: Change Data type on ""Ship-to City"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Ship-to City', FRA = 'Ville destinataire';
            Description = 'HEI.02';

            //Unsupported feature: Change Description on ""Ship-to City"(Field 17)". Please convert manually.

        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Ship-to Contact', FRA = 'Contact destinataire';
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
            // BC Upgrade BHARDA11 --Field length Change 20 to 10 , Not Possible in Business central, Now field length is 20.

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
            // BC Upgrade BHARDA11 --Field length Change 20 to 10 , Not Possible in Business central, Now field length is 20.
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
            // BC Upgrade BHARDA11 --Field length Change 50 to 60 , Not Possible in Business central, Now field length is 100.
            //Unsupported feature: Change Data type on ""Sell-to Address"(Field 81)". Please convert manually.

            CaptionML = ENU = 'Sell-to Address', FRA = 'Adresse donneur d''ordre';
            Description = 'HEI.02';
            //Unsupported feature: Change Description on ""Sell-to Address"(Field 81)". Please convert manually.

        }
        modify("Sell-to Address 2")
        {
            // BC Upgrade BHARDA11 --Field length Change 50 to 60 , Not Possible in Business central, Now field length is 50.

            //Unsupported feature: Change Data type on ""Sell-to Address 2"(Field 82)". Please convert manually.

            CaptionML = ENU = 'Sell-to Address 2', FRA = 'Adresse donneur d''ordre 2';
            Description = 'HEI.02';
            //Unsupported feature: Change Description on ""Sell-to Address 2"(Field 82)". Please convert manually.

        }
        modify("Sell-to City")
        {

            //Unsupported feature: Change Data type on ""Sell-to City"(Field 83)". Please convert manually.
            // BC Upgrade BHARDA11 --Field length Change 30 to 35 , Not Possible in Business central, Now field length is 30.
            CaptionML = ENU = 'Sell-to City', FRA = 'Ville donneur d''ordre';
            Description = 'HEI.02';
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
        modify("Pre-Assigned No. Series")
        {
            // BC Upgrade BHARDA11 --- Field Length changes 20 to 10 , Not possible in BC , Field length is 20.
            CaptionML = ENU = 'Pre-Assigned No. Series', FRA = 'Souche de n° pré-attribués';
        }
        modify("No. Series")
        {
            // BC Upgrade BHARDA11 --- Field Length changes 20 to 10 , Not possible in BC , Field length is 20.

            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Pre-Assigned No.")
        {
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
        modify("Prepmt. Cr. Memo No. Series")
        {
            CaptionML = ENU = 'Prepmt. Cr. Memo No. Series', FRA = 'N° de série avoir acompte';
        }
        modify("Prepayment Credit Memo")
        {
            CaptionML = ENU = 'Prepayment Credit Memo', FRA = 'Avoir acompte';
        }
        modify("Prepayment Order No.")
        {
            CaptionML = ENU = 'Prepayment Order No.', FRA = 'N° ordre acompte';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Document Exchange Identifier")
        {
            CaptionML = ENU = 'Document Exchange Identifier', FRA = 'Identifiant Exchange de documents';
        }
        modify("Document Exchange Status")
        {
            CaptionML = ENU = 'Document Exchange Status', FRA = 'Statut d''échange de documents';
            // OptionCaptionML = ENU = 'Not Sent,Sent to Document Exchange Service,Delivered to Recipient,Delivery Failed,Pending Connection to Recipient', FRA = 'Non envoyé,Envoyé au service d''échange de documents,Remis au destinataire,Échec remise,En attente connexion au destinataire';
        }
        modify("Doc. Exch. Original Identifier")
        {
            CaptionML = ENU = 'Doc. Exch. Original Identifier', FRA = 'Identifiant original éch. doc.';
        }
        modify(Paid)
        {
            CaptionML = ENU = 'Paid', FRA = 'Payé';
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
        modify("Return Order No.")
        {
            // BC Upgrade BHARDA11 --- Field Length changes 20 to 10 , Not possible in BC , Field length is 20.
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
        modify("Get Return Receipt Used")
        {
            CaptionML = ENU = 'Get Return Receipt Used', FRA = 'Extraire récep retour utilisée';
        }
        field(50000; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            Description = 'HEI.01';
            TableRelation = "WHT Business Posting Group FND".Code;
        }
        field(50001; "Rem. WHT Prepaid Amt LCY FND"; Decimal)
        {
            CalcFormula = Sum("WHT Entry FND"."Remaining Unrealized Amount" where("Document Type" = CONST("Credit Memo"),
                                                                               "Document No." = FIELD("No.")));
            Caption = 'Rem. WHT Prepaid Amount (LCY)';
            Description = 'HEI.01';
            FieldClass = FlowField;
        }
        field(50002; "Paid WHT Prepaid Amt LCY FND"; Decimal)
        {
            CalcFormula = Sum("WHT Entry FND".Amount where("Document Type" = CONST(Refund),
                                                        "Document No." = FIELD("No.")));
            Caption = 'Paid WHT Prepaid Amount (LCY)';
            Description = 'HEI.01';
            FieldClass = FlowField;
        }
        field(50003; "Total WHT Prepaid Amt LCY FND"; Decimal)
        {
            CalcFormula = Sum("WHT Entry FND"."Unrealized Amount" where("Document Type" = CONST("Credit Memo"),
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
            Description = 'HEI.03';
        }
        field(50008; "Fiscal Document FND"; Boolean)
        {
            Caption = 'Fiscal Document';
            Description = 'HEI.03';
        }
        field(50009; "Fiscal Document No. FND"; Code[50])
        {
            Caption = 'Fiscal Document No.';
            Description = 'HEI.03';
        }
        field(50010; "Print Station Serial FND"; Code[30])
        {
            Caption = 'Print Station Serial';
            Description = 'HEI.03';
        }
        field(50011; "Print Date/Time FND"; DateTime)
        {
            Caption = 'Print Date/Time';
            Description = 'HEI.03';
        }
        field(50012; "Sales Routes FND"; Code[10])
        {
            Caption = 'Sales Routes';
            Description = 'HEI.04';
            TableRelation = "Sales Routes FND";
        }
        field(50013; "Bonus Credit Memo FND"; Boolean)
        {
            Caption = 'Bonus Credit Memo';
            Description = 'HEI.10';
            Editable = false;
        }
        field(50016; "Vans Sales Route FND"; Boolean)
        {
            Caption = 'Vans Sales Route';
            Description = 'HEI.09';
        }



        // BC Upgrade BHARDA11 >> -- Ethiopia Intercompany Automation
        // field(50041; "Special Order"; Boolean)
        // {
        //     Caption = 'Special Order';
        //     Description = 'HEI.10';
        // }
        // BC Upgrade BHARDA11 << -- Ethiopia Intercompany Automation
        field(50043; "Invoice Receipt No. FND"; Text[100])
        {
            Description = 'HEI.11';
        }
        field(50050; "Send Document FND"; Option)
        {
            CaptionML = ENU = 'Send Document',
                        FRA = 'Envoyer Document';
            Description = 'HEI.12';
            Editable = false;
            OptionCaptionML = ENU = ' ,Mail,Print,Mail & Print',
                              FRA = ' ,E-Mail,Imprimer,E-Mail & Imprimer';
            OptionMembers = " ",Mail,Print,"Mail & Print";
        }
        field(50051; "Mail Sent FND"; Boolean)
        {
            Description = 'HEI.12';
            Editable = false;
        }

        field(50061; "CAD Amount FND"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Cr.Memo Line"."CAD Amount FND" where("Document No." = FIELD("No.")));// BC Upgrade BHARDA11 ---Drink-IT Field ("Item Charge Type Filter")
                                                                                                          //    "Item Charge Type" = FIELD("Item Charge Type Filter")));
            CaptionML = ENU = 'CAD Amount',
                        FRA = 'CAD Montant';
            Description = 'HEI.16';
            Editable = false;
            FieldClass = FlowField;
        }

        // BC Upgrade SHUKLP03 >> Document Subtype Code field added.
        field(50090; "Document Subtype Code FND"; Code[10])
        {
            CaptionML = ENU = 'Document Subtype Code',
                         FRA = 'Code Sous-Type Document';
            Description = 'DITW18.00.07 DIT-770 #1508';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Sales | "Fin.Contract"));
        }
        field(50019; "Fiscal Printer Status FND"; Option)
        {
            Caption = 'Fiscal Printer Status';
            Description = 'HEI.06,HEI.07';
            OptionCaption = 'Not Processed,Not Sent to Middleware,Sent to Middleware,Not Sent to Fiscal Printer,Received in Fiscal Printer,2nd Request Not Sent to Middleware,Error in Fiscal Printer or RRA,Fiscal Printer No. Received';
            OptionMembers = "Not Processed","Not Sent to Middleware","Sent to Middleware","Not Sent to Fiscal Printer","Received in Fiscal Printer","2nd Request Not Sent to Middleware","Error in Fiscal Printer or RRA","Fiscal Printer No. Received";
        }

        field(50020; "SDC Information Approved FND"; Boolean)
        {
            CalcFormula = Exist("EBM Log FND" WHERE("Document No." = FIELD("No.")));
            Caption = 'SDC Information Approved';
            Description = 'HEI.06';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50021; "Load No. FND"; Integer)
        {
            Caption = 'Load No.';
            Description = 'HEI.07';
        }
        field(50022; "Sequence No. FND"; Integer)
        {
            Description = 'HEI,07';
        }
        field(50031; "Suppress POS Interface FND"; Boolean)
        {
            Caption = 'Suppress POS Interface';
            Description = 'HEI.08';
        }
        field(50060; "Source System Identifier FND"; Code[10])
        {
            Caption = 'Source System Identifier';
            Description = 'HEI.14';
            Editable = false;
            TableRelation = "Source Sys Identifier API FND";
        }
        field(50066; "Sent to Electronic Invoice FND"; Boolean)
        {
            Caption = 'Sent to Electronic Invoice';
            DataClassification = ToBeClassified;
            Description = 'HEI.17';
        }
        // BC Upgrade SHUKLP03 << Document Subtype Code field added.

        // BC Upgrade BHARDA11 >> ----Drnk-IT Fields
        /*  field(2013610; "Customer DDeposit Group Code"; Code[10])
         {
             CaptionML = ENU = 'Customer Depoist Group Code',
                         FRA = 'Code groupe consigne client';
             Description = 'DITW15.00.00.01';
             TableRelation = "Drink Deposit Group".Code where("Source Type" = CONST(Customer));
         }
         field(2013613; "Link Sales Document No."; Code[20])
         {
             CaptionML = ENU = 'Link Sales Document No.',
                         FRA = 'Lien N° document vente';
             Description = 'DITW15.00.00.01';
         }
         field(2013630; "Deposit Cust. Posting Group"; Code[10])
         {
             CaptionML = ENU = 'Deposit - Customer Posting Group',
                         FRA = 'Consigne - Groupe compta. client';
             Description = 'DITW16.00.00.42 DIT-715 #370';
             TableRelation = "Customer Posting Group";
         }
         field(2013631; "Deposit Payment Terms Code"; Code[10])
         {
             CaptionML = ENU = 'Deposit - Payment Terms Code',
                         FRA = 'Consigne - Code conditions paiement';
             Description = 'DITW16.00.00.42 DIT-715 #370';
             TableRelation = "Payment Terms";
         }
         field(2013632; "Deposit Payment Method Code"; Code[10])
         {
             CaptionML = ENU = 'Deposit - Payment Method Code',
                         FRA = 'Consigne - Code mode de règlement';
             Description = 'DITW16.00.00.42 DIT-715 #370';
             TableRelation = "Payment Method";
         }
         field(2013633; "Deposit Bal. Account Type"; Option)
         {
             CaptionML = ENU = 'Deposit - Bal. Account Type',
                         FRA = 'Consigne - Type Compte Contrepartie';
             Description = 'DITW16.00.00.42 DIT-715 #370';
             OptionCaptionML = ENU = 'G/L Account,Bank Account',
                               FRA = 'Général,Banque';
             OptionMembers = "G/L Account","Bank Account";
         }
         field(2013634; "Deposit Bal. Account No."; Code[20])
         {
             CaptionML = ENU = 'Deposit - Bal. Account No.',
                         FRA = 'Consigne - N° compte contrepartie';
             Description = 'DITW16.00.00.42 DIT-715 #370';
             TableRelation = IF ("Deposit Bal. Account Type" = CONST("G/L Account")) "G/L Account"
             else IF ("Deposit Bal. Account Type" = CONST("Bank Account")) "Bank Account";
         }
         field(2013667; "Customer DTax Group Code"; Code[20])
         {
             CaptionML = ENU = 'Customer Tax Group Code',
                         FRA = 'Code groupe taxe client';
             Description = 'DITW15.00.00.01,HEI.02';
             TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Customer));
         }
         field(2013695; "Item Charge Type Filter"; Option)
         {
             CaptionML = ENU = 'Item Charge Type Filter',
                         FRA = 'Filtre type frais article';
             Description = 'DITW15.00.00.35';
             FieldClass = FlowFilter;
             OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
                               FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
             OptionMembers = " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost";
         }
         field(2013726; "Customer Tax Registration No."; Text[20])
         {
             CaptionML = ENU = 'Customer Tax Registration No.',
                         FRA = 'N° ident. accise client';
             Description = 'DITW16.00.00.44 DIT-715 #910';
         }
         field(2013730; "Fiscal Representative No."; Code[20])
         {
             CaptionML = ENU = 'Fiscal Representative / Customs Agent No.',
                         FRA = 'N° représentant fiscal / Agent des douanes';
             Description = 'DITW16.00.00.44 DIT-715 #910';
             TableRelation = "Fiscal Representative";
         }
         field(2013733; "Tax Date"; Date)
         {
             CaptionML = ENU = 'Tax Date',
                         FRA = 'Date taxe';
             Description = 'DITW15.00.00.39 #1363';
         }
         field(2013823; "Gen. Bus. Posting Free Group"; Code[10])
         {
             CaptionML = ENU = 'Gen. Bus. Posting Group Free item',
                         FRA = 'Groupe article gratuit compta. marché';
             Description = 'DITW15.00.00.35';
             TableRelation = "Gen. Business Posting Group";
         }
         field(2013825; "Free Item Posting Type"; Option)
         {
             CaptionML = ENU = 'Calculate Price on Free',
                         FRA = 'Calculer Prix sur gratuit';
             Description = 'DITW16.00.00.44 DIT-715 #910';
             OptionCaptionML = ENU = ' ,Price 0,Discount 100%',
                               FRA = ' ,Prix 0,Remise 100%';
             OptionMembers = " ",Price,Amount;
         }
         field(2013910; "Telesales Entry"; Integer)
         {
             CaptionML = ENU = 'Telesales Entry',
                         FRA = 'Ecriture Téléventes';
             Description = 'DITW16.00.00.44 DIT-715 #910';
             TableRelation = "Telesales Entry"."Entry No.";
         }
         field(2013936; "Order Type"; Option)
         {
             CaptionML = ENU = 'Order Type',
                         FRA = 'Type Commande';
             Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
             OptionCaptionML = ENU = 'Normal,Pre Order,Empty Goods',
                               FRA = 'Normale,Pré Commande,Vidange';
             OptionMembers = Normal,"Pre Order","Empty Goods",Depannage;
         }
         field(2013937; "Entry Type"; Option)
         {
             CaptionML = ENU = 'Entry Type',
                         FRA = 'Type écriture';
             Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
             OptionCaptionML = ENU = 'Order,,Télévente,,,,,,Télévente Processed',
                               FRA = 'Commande,,Télévente,,,,,,Télévente traités';
             OptionMembers = "Order",,"Télévente",,,,,,"Télévente Processed";
         }
         field(2013969; "Pos System-Created Entry"; Boolean)
         {
             CaptionML = ENU = 'POS System-Created Entry',
                         FRA = 'Ecriture système POS';
             Description = 'DITW15.00.00.39 #1328';
         }
         field(2014064; "Shipping Charge Per"; Option)
         {
             CaptionML = ENU = 'Shipping Charge Per',
                         FRA = 'Frais transport par';
             Description = 'DITW16.00.00.44 DIT-715 #910';
             OptionCaptionML = ENU = 'Shipment,Weight,Volume',
                               FRA = 'Expédition,Poids,Volume';
             OptionMembers = Shipment,Weight,Volume;
         }
         field(2014077; "Truck Code"; Code[10])
         {
             CaptionML = ENU = 'Truck Code',
                         FRA = 'Code camion';
             Description = 'DITW15.00.00.25';
             TableRelation = "Whse. Shipping Truck";
         }
         field(2014078; "Driver Code"; Code[10])
         {
             CaptionML = ENU = 'Driver Code',
                         FRA = 'Code chauffeur';
             Description = 'DITW15.00.00.25';
             TableRelation = "Whse. Shipping Driver";
         }
         field(2014080; "Customer Delivery Type"; Code[10])
         {
             CaptionML = ENU = 'Customer Delivery Type',
                         FRA = 'Type Livraison Client';
             Description = 'DITW18.00.07 DIT-770 #1346';
             TableRelation = "Delivery Type".Code where(Type = CONST(Customer));
         }
         field(2014087; Distance; Decimal)
         {
             CaptionML = ENU = 'Distance',
                         FRA = 'Distance';
             DecimalPlaces = 0 : 5;
             Description = 'DITW16.00.00.44 DIT-715 #910';
             MinValue = 0;
         }
         field(2014098; "Require 2 Drivers"; Boolean)
         {
             Caption = 'Require 2 Drivers';
             Description = 'NRQ16082';
         }
         field(2014099; "Driver 2 Code"; Code[10])
         {
             Caption = 'Driver 2 Code';
             Description = 'NRQ16082';
         }
         field(2014100; "Trailer Code"; Code[10])
         {
             Caption = 'Trailer Code';
             Description = 'NRQ16082';
         }
         field(2014107; Route; Code[20])
         {
             CaptionML = ENU = 'Route',
                         FRA = 'Itinéraire';
             Description = 'DITW16.00.00.44 DIT-715 #910';
             TableRelation = Route;
         }
         field(2014109; "Route Planning No."; Code[20])
         {
             Caption = 'Route Planning No.';
             Description = 'NRQ17902';
             TableRelation = "Route Planning Worksheet";
         }
         field(2014313; "Financial Contract No."; Code[20])
         {
             CaptionML = ENU = 'Financial Contract No.',
                         FRA = 'N° Contrat Financier';
             Description = 'DITW18.00.06 DIT-770 #1368';
             TableRelation = "Financial Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
                                                                               "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
         }
         field(2014361; "Event No."; Code[20])
         {
             CaptionML = ENU = 'Event No.',
                         FRA = 'N° évènement';
             Description = 'DITW17.10.05 DIT-770 #779';
             Editable = false;
             TableRelation = "Sales Header"."No." where("Document Type" = FILTER(6));
         }
         field(2014362; "Event Status"; Option)
         {
             CaptionML = ENU = 'Event Status',
                         FRA = 'Statut évènement';
             Description = 'DITW17.10.05 DIT-770 #779';
             Editable = true;
             OptionCaptionML = ENU = ' ,To Approve,Approved,Rejected',
                               FRA = ' ,A approuver,Approuvé,Rejeté';
             OptionMembers = " ","To Approve",Approved,Rejected;

             trigger OnValidate();
             var
                 AnyServItemInOtherContract: Boolean;
                 SignServContractDoc: Codeunit SignServContractDoc;
                 CloseType: Option " ",Close,CloseEarly;
             begin
             end;
         }
         field(2014363; "Event Description"; Text[50])
         {
             CaptionML = ENU = 'Event Description',
                         FRA = 'Description événement';
             Description = 'DITW17.10.05 DIT-770 #779';
         }
         field(2014410; "Physical Location Group Code"; Code[10])
         {
             CaptionML = ENU = 'Physical Location Group Code',
                         FRA = 'Code groupe magasin réel';
             Description = 'DITW18.00.06 DIT-770 #1190';
             TableRelation = "Physical Location Group";
         }
         field(2014411; "Creation Date/Time"; DateTime)
         {
             CaptionML = ENU = 'Creation Date/Time',
                         FRA = 'Date/Heure Création';
             Description = 'DITW18.00.07 DIT-770 #1282';
             Editable = false;
         }
         field(2014412; "Created By"; Code[50])
         {
             CaptionML = ENU = 'Created By',
                         FRA = 'Créé par';
             Description = 'DITW18.00.07 DIT-770 #1282';
             Editable = false;
             TableRelation = "User Setup";
         }
         field(2014420; "Sundry Customer"; Boolean)
         {
             CaptionML = ENU = 'Sundry Customer',
                         FRA = 'Client Diver';
             Description = 'DITW18.00.07 DIT-770 #1804';
         }
         field(2014421; "Document Subtype Code"; Code[10])
         {
             CaptionML = ENU = 'Document Subtype Code',
                         FRA = 'Code Sous-Type Document';
             Description = 'DITW18.00.07 DIT-770 #1508';
             TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Sales | "Fin.Contract"));
         }
         field(2014495; "Delivery Sequence"; Integer)
         {
             BlankZero = true;
             CaptionML = ENU = 'Delivery Sequence',
                         FRA = 'Séquence de livraison';
             Description = 'DITW16.00.00.44 DIT-715 #910';
             MinValue = 0;
         }
         field(2014496; "Invoice List Customer No."; Code[20])
         {
             CaptionML = ENU = 'Invoice List Customer No.',
                         FRA = 'N° client liste facture';
             Description = 'DITW17.10.05 DIT-715 #761';
             TableRelation = Customer;
         }
         field(2014497; "Invoice List Document No."; Code[20])
         {
             CaptionML = ENU = 'Invoice List Document No.',
                         FRA = 'N° document liste facture';
             Description = 'DITW18.00.07 DIT-770 #1723';
             TableRelation = "Invoice List";
         }
         field(2029610; OGM; Text[30])
         {
             CaptionML = ENU = 'OGM',
                         FRA = 'OGM';
             Description = 'FINXL7.00.001';
         }
         field(2034840; "Building No."; Code[20])
         {
             CaptionML = ENU = 'Building No.',
                         FRA = 'N° immeuble';
             Description = 'DITW15.00.00.35';
             TableRelation = Building;
         }
         field(2034850; "DIT Sub-Contract Type"; Option)
         {
             CaptionML = ENU = 'Sub Contract Type',
                         FRA = 'Sous type contrat';
             Description = 'DIT-715 #392';
             OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
                               FRA = ' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
             OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
         }
         field(2034872; "Contract Group Code"; Code[10])
         {
             CaptionML = ENU = 'Contract Group Code',
                         FRA = 'Code groupe contrat';
             Description = 'DIT-715 #392';
             TableRelation = IF ("Contract Type" = CONST(Service)) "Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
             else IF ("Contract Type" = CONST(Financial)) "Financial Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
         }
         field(2034915; "Service Contract No."; Code[20])
         {
             CaptionML = ENU = 'Service Contract No.',
                         FRA = 'N° contrat de service';
             Description = 'DIT-715 #392 -DITW18.00.06 MSF 31/07/2015 DIT-770 #1368';
             TableRelation = "Service Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
                                                                             "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
         }
         field(2034920; "Contract Next Invoice Date"; Date)
         {
             CaptionML = ENU = 'Contract Next Invoice Date',
                         FRA = 'Proch. date facturation du contrat';
             Description = 'DITW16.00.00.43 DIT715 #619';
         }
         field(2035393; "Contract Type"; Option)
         {
             CaptionML = ENU = 'Contract Type',
                         FRA = 'Type contrat';
             Description = 'DIT-715 #392 - DITW18.00.06 DIT-770 #1368';
             OptionCaptionML = ENU = ' ,Service,Financial',
                               FRA = ' ,Service,Financier';
             OptionMembers = " ",Service,Financial;
         } */
        // BC Upgrade BHARDA11 << ----Drnk-IT Fields
    }
    keys
    {

        //Unsupported feature: PropertyChange on ""Prepayment Order No."(Key)". Please convert manually.

        key(Key10; "Sell-to Customer No.", "External Document No.")
        {
            MaintainSQLIndex = false;
        }
        // BC Upgrade BHARDA11 >> ----Drink-IT Fields 
        /*  key(Key2; "Link Sales Document No.")
         {
         }
         key(Key3; "Entry Type", "Document Date", "Order Type")
         {
         } */
        // BC Upgrade BHARDA11 << ----Drink-IT Fields 
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "DocTxt(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DocTxt : ENU=Credit Memo;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DocTxt : ENU=Credit Memo;FRA=Avoir;
    //Variable type has not been exported.

    var
        Currency: Record Currency;
        TotalSalesCrMemoLine: Record "Sales Cr.Memo Line";
        TotalSalesCrMemoLineLCY: Record "Sales Cr.Memo Line";
        TempVATAmountLine: Record "VAT Amount Line" temporary;

    // BC Upgrade BHARDA11 >> ----Drink-IT Functions (GetSalesCrMemoLines,SumSalesCrMemoLinesTemp,SumSalesCrMemoLines2,IncrAmount,Increment)
    /*  PROCEDURE SetSecurityFilterOnRespCenter();
     BEGIN
         // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1190
         //IF UserSetupMgt.GetSalesFilter <> '' THEN BEGIN
         IF UserSetupMgt.GetSalesTextFilter <> '' THEN BEGIN
             FILTERGROUP(2);
             //SETRANGE("Responsibility Center",UserSetupMgt.GetSalesFilter);
             SETFILTER("Responsibility Center", UserSetupMgt.GetSalesTextFilter);
             FILTERGROUP(0);
         end;
         // >>DITW18.00.06 DDR DIT-770 #1190
     end;

     PROCEDURE GetSalesCrMemoLines(VAR NewSalesCrMemoLine: Record 115);
     VAR
         OldSalesCrMemoLine: Record 115;
     BEGIN
         // <<DITW15.00.00.35 DDR 22/06/2009
         SumSalesCrMemoLines2(NewSalesCrMemoLine, OldSalesCrMemoLine, TRUE);
     end;

     PROCEDURE SumSalesCrMemoLinesTemp(VAR OldSalesCrMemoLine: Record 115; VAR NewTotalSalesCrMemoLine: Record 115; VAR NewTotalSalesCrMemoLineLCY: Record 115; VAR VATAmount: Decimal; VAR VATAmountText: Text[30]);
     VAR
         LText016: Label 'ENU=VAT Amount;FRA=Montant TVA';
         LText017: Label 'ENU=%1% VAT;FRA=TVA %1%';
         SalesCrMemoLine: Record 115;
     BEGIN
         // <<DITW15.00.00.35 DDR 22/06/2009
         SumSalesCrMemoLines2(SalesCrMemoLine, OldSalesCrMemoLine, FALSE);

         VATAmount := TotalSalesCrMemoLine."Amount Including VAT" - TotalSalesCrMemoLine.Amount;
         IF TotalSalesCrMemoLine."VAT %" = 0 THEN
             VATAmountText := LText016
         else
             VATAmountText := STRSUBSTNO(LText017, TotalSalesCrMemoLine."VAT %");
         NewTotalSalesCrMemoLine := TotalSalesCrMemoLine;
         NewTotalSalesCrMemoLineLCY := TotalSalesCrMemoLineLCY;
     end;

     LOCAL PROCEDURE SumSalesCrMemoLines2(VAR NewSalesCrMemoLine: Record 115; VAR OldSalesCrMemoLine: Record 115; InsertSalesCrMemoLine: Boolean);
     VAR
         CurrExchRate: Record 330;
         SalesCrMemoLineQty: Decimal;
         NoVAT: Boolean;
     BEGIN
         NewSalesCrMemoLine.CalcVATAmountLinesTemp(Rec, OldSalesCrMemoLine, TempVATAmountLine);

         IF "Currency Code" = '' THEN
             Currency.InitRoundingPrecision
         else
             Currency.GET("Currency Code");

         OldSalesCrMemoLine.SETRANGE("Document No.", "No.");
         OldSalesCrMemoLine.SETFILTER(Type, '>0');
         OldSalesCrMemoLine.SETFILTER(Quantity, '<>0');
         IF GETFILTER("Item Charge Type Filter") <> '' THEN
             COPYFILTER("Item Charge Type Filter", OldSalesCrMemoLine."Item Charge Type");

         WITH OldSalesCrMemoLine DO BEGIN
             IF FIND('-') THEN
                 REPEAT
                     IF Amount <> 0 THEN
                         IF TotalSalesCrMemoLine.Amount = 0 THEN
                             TotalSalesCrMemoLine."VAT %" := "VAT %"
                         else
                             IF TotalSalesCrMemoLine."VAT %" <> "VAT %" THEN
                                 TotalSalesCrMemoLine."VAT %" := 0;

                     IncrAmount(OldSalesCrMemoLine, TotalSalesCrMemoLine);
                     Increment(TotalSalesCrMemoLine."Net Weight", ROUND(SalesCrMemoLineQty * "Net Weight", 0.00001));
                     Increment(TotalSalesCrMemoLine."Gross Weight", ROUND(SalesCrMemoLineQty * "Gross Weight", 0.00001));
                     Increment(TotalSalesCrMemoLine."Unit Volume", ROUND(SalesCrMemoLineQty * "Unit Volume", 0.00001));
                     Increment(TotalSalesCrMemoLine.Quantity, SalesCrMemoLineQty);
                     IF "Units per Parcel" > 0 THEN
                         Increment(
                           TotalSalesCrMemoLine."Units per Parcel",
                           ROUND(SalesCrMemoLineQty / "Units per Parcel", 1, '>'));

                     IF Rec."Currency Code" <> '' THEN BEGIN
                         NoVAT := Amount = "Amount Including VAT";
                         "Amount Including VAT" :=
                           ROUND(
                             CurrExchRate.ExchangeAmtFCYToLCY(
                               Rec."Posting Date", Rec."Currency Code",
                               TotalSalesCrMemoLine."Amount Including VAT", Rec."Currency Factor")) -
                                 TotalSalesCrMemoLineLCY."Amount Including VAT";
                         IF NoVAT THEN
                             Amount := "Amount Including VAT"
                         else
                             Amount :=
                               ROUND(
                                 CurrExchRate.ExchangeAmtFCYToLCY(
                                   Rec."Posting Date", Rec."Currency Code",
                                   TotalSalesCrMemoLine.Amount, Rec."Currency Factor")) -
                                     TotalSalesCrMemoLineLCY.Amount;
                         "Line Amount" :=
                           ROUND(
                             CurrExchRate.ExchangeAmtFCYToLCY(
                               Rec."Posting Date", Rec."Currency Code",
                               TotalSalesCrMemoLine."Line Amount", Rec."Currency Factor")) -
                                 TotalSalesCrMemoLineLCY."Line Amount";
                         "Line Discount Amount" :=
                           ROUND(
                             CurrExchRate.ExchangeAmtFCYToLCY(
                               Rec."Posting Date", Rec."Currency Code",
                               TotalSalesCrMemoLine."Line Discount Amount", Rec."Currency Factor")) -
                                 TotalSalesCrMemoLineLCY."Line Discount Amount";
                         "Inv. Discount Amount" :=
                           ROUND(
                             CurrExchRate.ExchangeAmtFCYToLCY(
                               Rec."Posting Date", Rec."Currency Code",
                               TotalSalesCrMemoLine."Inv. Discount Amount", Rec."Currency Factor")) -
                                 TotalSalesCrMemoLineLCY."Inv. Discount Amount";
                         "VAT Difference" :=
                           ROUND(
                             CurrExchRate.ExchangeAmtFCYToLCY(
                               Rec."Posting Date", Rec."Currency Code",
                               TotalSalesCrMemoLine."VAT Difference", Rec."Currency Factor")) -
                                 TotalSalesCrMemoLineLCY."VAT Difference";
                         // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
                         "VAT Base Amount" :=
                           ROUND(
                             CurrExchRate.ExchangeAmtFCYToLCY(
                               Rec."Posting Date", Rec."Currency Code",
                               TotalSalesCrMemoLine."VAT Base Amount", Rec."Currency Factor")) -
                                 TotalSalesCrMemoLineLCY."VAT Base Amount";
                         // >>DITW16.00.00.40 DDR DIT-715 #172
                     end;

                     IncrAmount(OldSalesCrMemoLine, TotalSalesCrMemoLineLCY);
                     Increment(TotalSalesCrMemoLineLCY."Unit Cost (LCY)", ROUND(SalesCrMemoLineQty * "Unit Cost (LCY)"));

                     IF InsertSalesCrMemoLine THEN BEGIN
                         NewSalesCrMemoLine := OldSalesCrMemoLine;
                         NewSalesCrMemoLine.INSERT;
                     end;
                 UNTIL NEXT = 0;
         end;
     end;

     LOCAL PROCEDURE IncrAmount(SalesCrMemoLine2: Record 115; VAR TotalSalesCrMemoLine: Record 115);
     BEGIN
         WITH SalesCrMemoLine2 DO BEGIN
             IF "Prices Including VAT" OR
                ("VAT Calculation Type" <> "VAT Calculation Type"::"Full VAT")
             THEN
                 Increment(TotalSalesCrMemoLine."Line Amount", "Line Amount");
             Increment(TotalSalesCrMemoLine.Amount, Amount);
             Increment(TotalSalesCrMemoLine."VAT Base Amount", "VAT Base Amount");
             Increment(TotalSalesCrMemoLine."VAT Difference", "VAT Difference");
             Increment(TotalSalesCrMemoLine."Amount Including VAT", "Amount Including VAT");
             Increment(TotalSalesCrMemoLine."Line Discount Amount", "Line Discount Amount");
             Increment(TotalSalesCrMemoLine."Inv. Discount Amount", "Inv. Discount Amount");
         end;
     end;

     LOCAL PROCEDURE Increment(VAR Number: Decimal; Number2: Decimal);
     BEGIN
         Number := Number + Number2;
     end; */

    // BC Upgrade BHARDA11 << ----Drink-IT Functions (GetSalesCrMemoLines,SumSalesCrMemoLinesTemp,SumSalesCrMemoLines2,IncrAmount,Increment)


}

