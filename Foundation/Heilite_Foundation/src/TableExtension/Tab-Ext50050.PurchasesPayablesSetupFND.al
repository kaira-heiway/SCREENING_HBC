tableextension 50050 PurchaseandPayableSetupExtFND extends "Purchases & Payables Setup"
{
    // version NAVW110.0,FINXL10.01,DITW110.00.13,HEI.43

    // DITW15.00.00.24 DDR 25/09/2008 Drink-It functionnalities
    //                                 Added fields
    //                                  2013721 Duty Point (option)
    // DITW15.00.00.28,HLW15.00.01.01 DDR 28/11/2008 Added fields
    //                                                 2035340 HiddenVendorItemNoEncriptKey
    //                                               Added text constant Text2035340
    // DITW15.00.00.31 DDR 18/02/2009 Added fields
    //                                  2014443 Allow Reverse Document Amount
    //                     19/02/2009 Removed fields (not used)
    //                                  2035340 HiddenVendorItemNoEncriptKey
    // DITW15.00.00.33 DDR 08/05/2009 Added fields
    //                                  2013755 DTax per Group Mandatory
    // DITW15.00.00.34 DDR 16/06/2009 Added fields
    //                                  2013628 Empty Goods Item No. Mandatory
    //                                  2014451 Auto.Release Document on Whse.
    // DITW15.00.00.37 DDR 27/05/2010 issue 1121 Added security field "Receipt on Invoice" when field "Duty Point" Shipment
    //                                           Added text constants Text2013660
    //                     02/06/2010 issue 1121 Added security field "Return Shipment on Credit Memo" when field "Duty Point" shipment
    // DITW15.00.00.39 DDR 27/04/2011   NAVBE5.00 (SP1) functionnality to insert Customer Std. Sales Codes automatically
    //                                  Added fields
    //                                    2014496 Insert Std. Vend. Purch. Lines (see BE5.00 field 11313)
    //                                    2014497 Quotes
    //                                    2014498 Orders
    //                                    2014499 Invoices
    //                                    2014500 Credit Memos
    //                     19/08/2011 issue 1363 Added fields
    //                                    2013732 Default Tax Date
    //                     29/08/2011 issue 1396 Item Exclusivity functionnality
    //                                  Added fields
    //                                    2014424 Item Exclusivity Warning
    //                     11/10/2011 issue 1396
    //                                  Added fields
    //                                    2014425 Exclusivity Group Manadatory
    //                     28/10/2011 issue 1457 Modified many ML captions
    // DITW16.00.00.42 DDR 07/12/2012 DIT-715 #370
    //                                    2013636 Allow Split Deposit per
    //                     13/12/2012 DIT-715 #521 Added fields
    //                                 2014419 Prices priority method
    //                     13/12/2012 DIT-715 #522 Added fields
    //                                 2014504 Pay-to/Buy-from Dimensions

    // FINXL7.00.001 RBE 20/03/2013: Created field "Show Invoice No."
    //                               added setup fields
    //                               Created field "Show Jnl. Template Selection"
    // FINXL7.00.001 KLU 25/09/2013: Added field "Rcpt. Inv. Approval Margin Min" and "Rcpt. Inv. Approval Margin Max": field used in approval management
    //                               The percentage allowed to differ from to bypass approval
    // FINXL7.00.006 KLU 03/10/2013: Added fields 2029630 .. 2029634

    // DITW17.00.02 DDR 04/07/2013 DIT-770 #99 Added fields
    //                                           2014560 GWC Country/Region Mandatory
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #99
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0013.1
    //                             Added field 2014430 ON HOLD unsatisfactory receipt
    // DITW17.10.03 MSF 17/06/2014 DIT-770 #617  Autofill end date in Sales and purchase prices.
    //                                           Added field 2014505 - Autofill End Date
    // DITW17.10.03 DDR 04/07/2014 DIT-770 #768 Added field 2014418 Prices & Discount Find Method"
    // DITW17.10.03 DDR 10/07/2014 DIT-770 #768 Remove field 2014418 Prices & Discount Find Method"
    //                                          Added option 'FirstTypeFilter' field2014419
    // DITW17.10.05 DDR 12/08/2014 DIT-770 #768 Removed option 'FirstTypeFilter' field2014419
    // DITW17.10.05 DDR 19/08/2014 DIT-770 #776 Added Deposit point functionality
    //                                          Added field 2013611 Deposit Point
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //                                          Disabled fields
    //                                            2014496 _Insert Std. Vend. Purch.Lines
    //                                            2014497 _Quotes
    //                                            2014498 _Orders
    //                                            2014499 _Invoices
    //                                            2014500 _Credit Memos
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW17.10.05 DDR 06/03/2015 DIT-770 #768 Bugfix merge error optionstring field2014419 Prices Priority Method
    // DITW18.00.07 AKH 28/03/2016 DIT-770 #1409 Added new field 20144210 "Vendor Shipment No. Mandatory"
    // DITW18.00.07 DDR 14/04/2016 DIT-770 #1402 Added fields
    //                                             2014447 Show Posting Warnings
    //                                             2014448 Show Reopen Warnings
    // DITW18.00.07 DDR 20/04/2016 DIT-770 #1941 Added field 2014429 "Pay-to/Buy-from Prices Calc."
    // DITW18.00.07 VSC 07/05/2016 DIT-770 #1968 - #1977 Added fields
    //                                             2014107 "Default Route"
    //                                             2014108 "Route Mandatory"
    //                                             2035394 "Batch PostOrders Print"
    //                                             2035395 "Batch PostOrders Status Filter"
    //                                             2035396 "Batch PO Receipt Statusfilter"
    // DITW18.00.07 VSC 25/05/2016 DIT-770 #1968 "Batch PO Receipt Statusfilter" change to receipt options
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW19.00.08 SFI 18/08/2016 BL#10868  (DIT-770 #2141) New fields
    //                                                       2014411 "Max. Autom. VAT Amt. Adjustm."
    //                                                       2014412 "Max. Autom. Amount Adjustm."
    // DITW110.00.08 DDR 03/03/2017 NRQ#0 Changed caption field2014505

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL10.01 AKH 19/07/2017 NRQ#33089 Added new field 2029622 "Vendor Auto Dimension Code"
    // FINXL10.01 OFE 30/08/2017 NRQ#10433: Changed field name 2029615"Do Not Allow Zero Price" => "Purchase price mandatory"
    // FINXL10.01 MTR 16/08/2017 NRQ#30245 Removed old FINXL code related to "Show Totals on Purch. Inv/CM." setup
    //                                     Changed the field name to "Check Totals on Purch. Inv./CM"
    // DITW110.00.11 MSF 07/11/2017 NRQ#13577 Autoblock Customer, Item, Vendor card based on setup
    //                                       Added Fields Autoblock Vendor On Changes
    //                                                    Autoblock Vend. On  Dimension
    //                                                    Autoblock Vend. On BankAccount
    // DITW110.00.12A MSF 26/06/2018 NRQ#74597 Order discount should calculate for all – not apply priority
    //                                         Added field  2013763 "Order Discount Priority Method
    // DITW111.00.13 DDR 10/12/2018 NRQ#95409 Add field 2013764 "Order Promotion Priority Method"
    // DITW111.00.13 MSF 04/02/2019 NRQ#87409 Reopen and Release an already approved sales order
    //                                         Added Field "Automatic Document Approval"

    // HEI.01 FDD-PTPGAP005 IBM SOICAD01 27.06.2017 Purchase to Pay – 3-way matching
    //   #new fields added
    //     "Invoice Toler. Check Enabled"
    //     "Upper Percentage Tolerance"
    //     "Upper Amount Tolerance"
    //     "Lower Percentage Tolerance"
    //     "Lower Amount Tolerance"
    // HEI.02 PTPGAP064 IBM HORTOC01 12.07.2017
    //   # Add new fields "PO subtype code" and "NPO subtype code"
    // HEI.03 HLSRM02 IBM LAZARE02 02.08.2017
    //   #New fields for SRM integration
    // HEI.04 PTPGAP064 IBM POENAB01 16.08.2017
    //   # Changed length of the fields "PO subtype code" and "NPO subtype code" from Code(20) to Code(10)
    // HEI.05 PTPGAP068  IBM COSTES02  21.08.2017
    //   # Added new field "Payment Journal Archive Nos."
    // HEI.06 PTPGAP009  IBM.CHAUHB01  18/08/2017
    //   # Added new field
    //     ESKER SFTP Host Name
    //     ESKER SFTP Port Number
    //     ESKER SFTP Login
    //     ESKER SFTP Password
    //     ESKER SFTP Out Folder
    //     ESKER SFTP ErpAck Folder
    //     ESKER SFTP InMasterData Folder
    //     ESKER Max. Tolerance Amount
    //     ESKER Unpaid Invoices
    //     ESKER Paid Invoices
    // HEI.07 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New fields for MDM integration
    // HEI.08 FDD-PTPGAP002 IBM HORTOC01 19.08.2017
    //   # New field "Reason Code Block Customer"
    // HEI.09 FDD-PTPGAP007 IBM PATHAA02 05.10.17
    //   # New field "Missing BankDetails Reason Code"
    // HEI.10 FDD-HNK PTPGAP067 IBM. ISYED01 24/10/2017
    //   # Newfield added "Prepayment Request Subtype" to table
    //   #Prepayment Doc Type added to the field
    // HEI.11 FDD PTPGAP081 IBM POSTOI01 07.05.2018
    //   # New field 50044 Auto.Arch.Deleted Inv&CrMemos boolean;
    //   # Purchase archiving
    // HEI.12 FDD-AL-PTPGAP02 IBM HORTOC01 05.06.2018 - new field "Allow printing C&TP PO"
    // HEI.13 RFC-CHG0249183 IBM.LS 03.10.2018
    //   # Added new field as "Auto E-mail Active".
    // HEI.14 CHG)246348 IBM.SS
    //   created new field Item Category
    // HEI.15 FDD-HB446 IBM SURYAS01  05/09/2019
    //   #Created New field - "Posted Exp. Costs Doc. Nos."
    // HEI.17 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field created: 50052 - Enable FA Vendor Requirement
    // HEI.18 FDD-HT903 IBM SURYAS01 19-11-2019
    //  #Created new Field : 50053-"Prepmt. Via deduction on final"
    // HEI.21 CHG2025179 FDD PO HT738 IBM.PANDES01 17.02.2020
    //     # Used fields "PO Legal Text" and "PO legal text international" which created against CHG2031909, in report 50326 and 50327.
    //     As per COE there no more existence of change request no CHG2031909 so HEI.16 will not use more.
    // HEI.22 CHG2058828 IBM NANDIS01 20.05.2020 GR IR Writeoff
    //   #New fields added - "GR IR Writeoff Invoice No." and "Posted GRIR Invoice Wrt off No"
    // HEI.23 FDD HT1136 CHG2055070 IBM Shankj03 16.06.2020
    //   # New field added Footer Text & Footer Text International
    // Hei.24  CHG2096764 IBM. PANDES01  12.03.2021
    //  # Added field "Requester ID Mandatory".
    // HEI.25 FDD-HB1886 IBM NASTAA02 30.03.2021 # Specific Invoice Tolerances
    //   # New Field created: 50059 - Tolerance Exceptions
    // HEI.26 FDD-HB1195 CHG2070051 IBM GUNERE01 04.02.2021 # Excluded incoterms, "Location Code for Import Proc." fields added
    // HEI.27 FDD-HB1195 CHG2070051 IBM NANDIS01 24.05.2021 Import Purchasing & Receiving process HeiLite-Maximo integration
    //   Different tag other than HEI.26 used, as TO posting is handled separately
    //   New field ID - 50062 - Name - Zone Code for Import Proc. Code 10
    // HEI.28 FDD-HT2159 - CHG2105031 IBM NASTAA02 04.08.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field created: 50063 - Mandatory Region on Header
    // HEI.29 FDD-HB2638 CHG2136725 IBM NANDIS01 23.02.2022 Block create Corrective Credit memo option in HL
    //   # New field added - Corrective CM Not Allowed - Text - 50  - Field ID - 50064
    // HEI.30 HB2810 -CHG2160301 IBM SHIVAS05 29.07.2022 PO's to be sent to Suppliers
    //   # New field added - Auto Email to Requestor - Boolean, Field ID - 50065
    // HEI.31 CHG2162715 HB3020 NORRIQ KOROLA04 07.12.2022
    //   # SPL Active - field added
    // HEI.32 CHG2162715 HB3020 NORRIQ KOROLA04 14.12.2022
    //   # SPL Account Group - field added
    // HEI.33 CHG2155847 HB2821 IBM NANDIS01 20.01.2023 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # New field - "Astro Whse Rcpt Manl Post" (Boolean - ID - 50068) added
    // HEI.34 CHG2227390 HB3558 SRIVAS07 IBM 19.12.2023 # Role-StP call off handler not to create PO from PQ.
    //   # New field - "Enable PQ to PO check" (Boolean - ID - 50069) added
    // HEI.35 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //  #New field added #H&S Levy Tax
    // HEI.36 CHG2238024 HB3817 IBM SRIVAS07 27.03.24 # Development Receipt process for materials from South Africa to Mozambique.
    //   # New field - "Excluded Countries (Import PO)" (Code - ID - 50071) added
    // HEI.37 CHG2221624 HB3614 IBM SRIVAS07 05.04.2024 # Block Payment for Invoices with Price Difference higher than the tolerance
    //   # Created New Fields: 50072 - Check Tolerance Approval
    // HEI.38 CHG2238024 HB3817 IBM SRIVAS07 09.04.24 # Development Receipt process for materials from South Africa to Mozambique.
    //   # Added Table Relation in - "Excluded Countries (Import PO)"
    // HEI.39 CHG2241988 SAHAL01 15.04.2024 Email Notification of Open POs Sent To Requestors Managers
    //   # Created New Fields: 50075 - Enabled Overdue Notification
    //                         50076 - Overdue Days for Email Notify
    //                         50077 - CC Email ID for PO Send
    //                         50078 - Exclude PO Document Subtype
    // HEI.40 CHG2241988 SAHAL01 26.07.2024 Email Notification of Open POs Sent To Requestors Managers
    //   # Created New Field: 50079 - No. of Emails to Send in Batch
    // HEI.41 CHG2262865 SHARMP16 21.08.2024 Disable Vendor Bank Address Check
    //   # Created New Field: 50080 - Disable Vendor Bank Add Check
    // HEI.42 CHG2257322 SHARMP16 10.09.2024 - Ibecor PO Item Charge Creation with HL Integration Process
    //   # Created New Field: 50081 - Create Region Code for PO
    // HEI.43 CHG2257322 SHARMP16 13.09.2024 - Ibecor PO Item Charge Creation with HL Integration Process
    //   # Change in Table relation Property from Country/Region to Location: 50081 - Create Region Code for PO

    // BC Upgrade SHUKLP03 >> Added document subtype code added.

    fields
    {
        modify("Primary Key")
        {
            CaptionML = ENU = 'Primary Key', FRA = 'Clé primaire';
        }
        modify("Discount Posting")
        {
            CaptionML = ENU = 'Discount Posting', FRA = 'Comptabilisation remise';
            OptionCaptionML = ENU = 'No Discounts,Invoice Discounts,Line Discounts,All Discounts', FRA = 'Remises déduites,Remises facture,Remises ligne,Toutes remises';
        }
        modify("Receipt on Invoice")
        {
            CaptionML = ENU = 'Receipt on Invoice', FRA = 'B.R. sur facture';
        }
        modify("Invoice Rounding")
        {
            CaptionML = ENU = 'Invoice Rounding', FRA = 'Arrondi facture';
        }
        modify("Ext. Doc. No. Mandatory")
        {

            //Unsupported feature: Change InitValue on ""Ext. Doc. No. Mandatory"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Ext. Doc. No. Mandatory', FRA = 'N° doc. ext. obligatoire';
        }
        modify("Vendor Nos.")
        {
            CaptionML = ENU = 'Vendor Nos.', FRA = 'N° fournisseur';
        }
        modify("Quote Nos.")
        {
            CaptionML = ENU = 'Quote Nos.', FRA = 'N° demande de prix';
        }
        modify("Order Nos.")
        {
            CaptionML = ENU = 'Order Nos.', FRA = 'N° commande';
        }
        modify("Invoice Nos.")
        {
            CaptionML = ENU = 'Invoice Nos.', FRA = 'N° facture';
        }
        modify("Posted Invoice Nos.")
        {
            CaptionML = ENU = 'Posted Invoice Nos.', FRA = 'N° facture enregistrée';
        }
        modify("Credit Memo Nos.")
        {
            CaptionML = ENU = 'Credit Memo Nos.', FRA = 'N° avoir';
        }
        modify("Posted Credit Memo Nos.")
        {
            CaptionML = ENU = 'Posted Credit Memo Nos.', FRA = 'N° avoir enregistré';
        }
        modify("Posted Receipt Nos.")
        {
            CaptionML = ENU = 'Posted Receipt Nos.', FRA = 'N° réception enregistrée';
        }
        modify("Blanket Order Nos.")
        {
            CaptionML = ENU = 'Blanket Order Nos.', FRA = 'N° commande ouverte';
        }
        modify("Calc. Inv. Discount")
        {
            CaptionML = ENU = 'Calc. Inv. Discount', FRA = 'Calculer remise facture';
        }
        modify("Appln. between Currencies")
        {
            CaptionML = ENU = 'Appln. between Currencies', FRA = 'Lettrage entre devises';
            OptionCaptionML = ENU = 'None,EMU,All', FRA = 'Aucune devise,Devises U.M.E.,Toutes devises';
        }
        modify("Copy Comments Blanket to Order")
        {

            //Unsupported feature: Change InitValue on ""Copy Comments Blanket to Order"(Field 22)". Please convert manually.

            CaptionML = ENU = 'Copy Comments Blanket to Order', FRA = 'Copier com. cde ouv. -> cde';
        }
        modify("Copy Comments Order to Invoice")
        {

            //Unsupported feature: Change InitValue on ""Copy Comments Order to Invoice"(Field 23)". Please convert manually.

            CaptionML = ENU = 'Copy Comments Order to Invoice', FRA = 'Copier com. cde -> facture';
        }
        modify("Copy Comments Order to Receipt")
        {

            //Unsupported feature: Change InitValue on ""Copy Comments Order to Receipt"(Field 24)". Please convert manually.

            CaptionML = ENU = 'Copy Comments Order to Receipt', FRA = 'Copier com. cde -> réception';
        }
        modify("Allow VAT Difference")
        {
            CaptionML = ENU = 'Allow VAT Difference', FRA = 'Autoriser différence TVA';
        }
        modify("Calc. Inv. Disc. per VAT ID")
        {
            CaptionML = ENU = 'Calc. Inv. Disc. per VAT ID', FRA = 'Calc. remise fact. par ident. TVA';
        }
        modify("Posted Prepmt. Inv. Nos.")
        {
            CaptionML = ENU = 'Posted Prepmt. Inv. Nos.', FRA = 'N° fact. acompte enreg.';
        }
        modify("Posted Prepmt. Cr. Memo Nos.")
        {
            CaptionML = ENU = 'Posted Prepmt. Cr. Memo Nos.', FRA = 'N° avoir acompte enreg.';
        }
        modify("Check Prepmt. when Posting")
        {
            CaptionML = ENU = 'Check Prepmt. when Posting', FRA = 'Vérifier acompte lors de la validation';
        }
        modify("Default Posting Date")
        {
            CaptionML = ENU = 'Default Posting Date', FRA = 'Date comptabilisation par défaut';
            //OptionCaptionML = ENU = 'Work Date,No Date', FRA = 'Date de travail,Aucune date';
        }
        modify("Default Qty. to Receive")
        {
            CaptionML = ENU = 'Default Qty. to Receive', FRA = 'Qté par défaut à recevoir';
            OptionCaptionML = ENU = 'Remainder,Blank', FRA = 'Solde,Vide';
        }
        // modify("Archive Quotes and Orders")
        // {
        //     CaptionML = ENU='Archive Quotes and Orders',FRA='Archiver devis et commandes';
        // }  // BC Upgrade NANDIS03
        modify("Post with Job Queue")
        {
            CaptionML = ENU = 'Post with Job Queue', FRA = 'Valider avec la file d''attente des travaux';
        }
        modify("Job Queue Category Code")
        {
            CaptionML = ENU = 'Job Queue Category Code', FRA = 'Code catégorie de la file d''attente des travaux';
        }
        modify("Job Queue Priority for Post")
        {
            CaptionML = ENU = 'Job Queue Priority for Post', FRA = 'Priorité de la file d''attente des travaux pour validation';
        }
        modify("Post & Print with Job Queue")
        {
            CaptionML = ENU = 'Post & Print with Job Queue', FRA = 'Valider et imprimer avec la file d''attente des travaux';
        }
        modify("Job Q. Prio. for Post & Print")
        {
            CaptionML = ENU = 'Job Queue Priority for Post & Print', FRA = 'Priorité de la file d''attente des travaux pour validation et impression';
        }
        modify("Notify On Success")
        {
            CaptionML = ENU = 'Notify On Success', FRA = 'Notification si réussite';
        }
        modify("Allow Document Deletion Before")
        {
            CaptionML = ENU = 'Allow Document Deletion Before', FRA = 'Autoriser suppr. doc. av.';
        }
        modify("Debit Acc. for Non-Item Lines")
        {

            //Unsupported feature: Change TableRelation on ""Debit Acc. for Non-Item Lines"(Field 1217)". Please convert manually.

            CaptionML = ENU = 'Debit Acc. for Non-Item Lines', FRA = 'Compte débit pour lignes non-article';
        }
        modify("Credit Acc. for Non-Item Lines")
        {

            //Unsupported feature: Change TableRelation on ""Credit Acc. for Non-Item Lines"(Field 1218)". Please convert manually.

            CaptionML = ENU = 'Credit Acc. for Non-Item Lines', FRA = 'Compte crédit pour lignes non-article';
        }
        modify("Posted Return Shpt. Nos.")
        {
            CaptionML = ENU = 'Posted Return Shpt. Nos.', FRA = 'N° expédition retour enregistrée';
        }
        modify("Copy Cmts Ret.Ord. to Ret.Shpt")
        {

            //Unsupported feature: Change InitValue on ""Copy Cmts Ret.Ord. to Ret.Shpt"(Field 5801)". Please convert manually.

            CaptionML = ENU = 'Copy Cmts Ret.Ord. to Ret.Shpt', FRA = 'Copier com. ret. -> expédition retour';
        }
        modify("Copy Cmts Ret.Ord. to Cr. Memo")
        {

            //Unsupported feature: Change InitValue on ""Copy Cmts Ret.Ord. to Cr. Memo"(Field 5802)". Please convert manually.

            CaptionML = ENU = 'Copy Cmts Ret.Ord. to Cr. Memo', FRA = 'Copier com. ret. -> avoir';
        }
        modify("Return Order Nos.")
        {
            CaptionML = ENU = 'Return Order Nos.', FRA = 'N° retour';
        }
        modify("Return Shipment on Credit Memo")
        {
            CaptionML = ENU = 'Return Shipment on Credit Memo', FRA = 'Expédition retour sur avoir';
        }
        modify("Exact Cost Reversing Mandatory")
        {
            CaptionML = ENU = 'Exact Cost Reversing Mandatory', FRA = 'Coût retour identique obligatoire';
        }

        //Unsupported feature: CodeInsertion on ""Receipt on Invoice"(Field 6)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.37 DDR 27/05/2010
        if not "Receipt on Invoice" and ("Duty Point" = "Duty Point"::"Posted Receipt") then
          FIELDERROR("Receipt on Invoice",STRSUBSTNO(Text2013660,FIELDCAPTION("Duty Point"),"Duty Point"));
        // >>DITW15.00.00.37 DDR
        // <<DITW17.10.05 DDR 19/08/2014 DIT-770 #776
        if not "Receipt on Invoice" and ("Deposit Point" = "Deposit Point"::"Posted Receipt") then
          FIELDERROR("Receipt on Invoice",STRSUBSTNO(Text2013660,FIELDCAPTION("Deposit Point"),"Deposit Point"));
        // >>DITW17.10.05 DDR DIT-770 #776
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Queue Priority for Post"(Field 40).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Job Queue Priority for Post" < 0 THEN
          ERROR(Text001);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Job Queue Priority for Post" < 0 then
          ERROR(Text001);
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Q. Prio. for Post & Print"(Field 42).OnValidate". Please convert manually.

        //trigger  Prio();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Job Queue Priority for Post" < 0 THEN
          ERROR(Text001);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Job Queue Priority for Post" < 0 then
          ERROR(Text001);
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Return Shipment on Credit Memo"(Field 6601)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.37 DDR 27/05/2010
        if not "Return Shipment on Credit Memo" and ("Duty Point" = "Duty Point"::"Posted Receipt") then
          FIELDERROR("Return Shipment on Credit Memo",STRSUBSTNO(Text2013660,FIELDCAPTION("Duty Point"),"Duty Point"));
        // >>DITW15.00.00.37 DDR
        // <<DITW17.10.05 DDR 19/08/2014 DIT-770 #776
        if not "Return Shipment on Credit Memo" and ("Deposit Point" = "Deposit Point"::"Posted Receipt") then
          FIELDERROR("Return Shipment on Credit Memo",STRSUBSTNO(Text2013660,FIELDCAPTION("Deposit Point"),"Deposit Point"));
        // >>DITW17.10.05 DDR DIT-770 #776
        */
        //end;
        field(50000; "Upper % Tolerance FND"; Decimal)
        {
            Description = 'HEI.01 PTPGAP005';
            Caption = 'Upper Percentage Tolerance';
            MinValue = 0;
        }
        field(50001; "Upper Amount Tolerance FND"; Decimal)
        {
            Description = 'HEI.01 PTPGAP005';
            Caption = 'Upper Amount Tolerance';
            MinValue = 0;
        }
        field(50002; "Lower % Tolerance FND"; Decimal)
        {
            Description = 'HEI.01 PTPGAP005';
            Caption = 'Lower Percentage Tolerance';
            MinValue = 0;
        }
        field(50003; "Lower Amount Tolerance FND"; Decimal)
        {
            Description = 'HEI.01 PTPGAP005';
            Caption = 'Lower Amount Tolerance';
            MinValue = 0;
        }
        field(50004; "Invoice Toler.CheckEnabled FND"; Boolean)
        {
            Description = 'HEI.01 PTPGAP005';
            Caption = 'Invoice Tolerance Check Enabled';
        }
        field(50005; "NPO Subtype Code FND"; Code[10])
        {
            Description = 'HEI.02,HEI.04';
            Caption = 'NPO Subtype Code';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Purchase));  // BC Upgrade SHUKLP03 
        }
        field(50006; "PO Subtype Code FND"; Code[10])
        {
            Description = 'HEI.02,HEI.04';
            Caption = 'PO Subtype Code';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Purchase));  // BC Upgrade SHUKLP03
        }
        field(50007; "Allow OverConsumption Qty. FND"; Boolean)
        {
            Caption = 'Allow Over Consumption on Qty. on Blanket Orders';
            Description = 'HEI.03';
        }
        field(50008; "Allow OverConsumption Amt. FND"; Boolean)
        {
            Caption = 'Allow Over Consumption on Amt. on Blanket Orders';
            Description = 'HEI.03';
        }
        field(50009; "Approv.Need Before CallOff FND"; Boolean)
        {
            Caption = 'Approval Needed Before Blanket Order Call-Off';
            Description = 'HEI.03';
        }
        field(50010; "Payment Jnl Archive Nos. FND"; Code[10])
        {
            Caption = 'Payment Journal Archive Nos.';
            Description = 'HEI.05';
            TableRelation = "No. Series";
        }
        field(50011; "Auto Release Purch. Order FND"; Boolean)
        {
            Caption = 'Auto Release Purchase Order';
            Description = 'HEI.03';
        }
        field(50012; "Prepayment Request Nos. FND"; Code[10])
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            TableRelation = "No. Series";
            Caption = 'Prepayment Request Nos.';
        }
        field(50015; "ESKER SFTP Host Name FND"; Text[250])
        {
            CaptionML = ENU = 'Host Name',
                        FRA = 'Hï¿½te';
            Description = 'ESKER1.1,HEI.06';
        }
        field(50016; "ESKER SFTP Port Number FND"; Integer)
        {
            BlankZero = true;
            CaptionML = ENU = 'Port Number',
                        FRA = 'Port';
            Description = 'ESKER1.1,HEI.06';
            InitValue = 22;

            trigger OnValidate();
            begin
                //IF "ESKER SFTP Port Number" = 0 THEN
                //  "ESKER SFTP Port Number" := 22;
            end;
        }
        field(50017; "ESKER SFTP Login FND"; Text[250])
        {
            CaptionML = ENU = 'Login',
                        FRA = 'Identifiant';
            Description = 'ESKER1.1,HEI.06';
        }
        field(50018; "ESKER SFTP Password FND"; Text[250])
        {
            CaptionML = ENU = 'Password',
                        FRA = 'Mot de passe';
            Description = 'ESKER1.1,HEI.06';
            ExtendedDatatype = Masked;
        }
        field(50019; "ESKER SFTP Out Folder FND"; Text[50])
        {
            CaptionML = ENU = 'Out Folder',
                        FRA = 'Dossier factures';
            Description = 'ESKER1.1,HEI.06';
        }
        field(50020; "ESKER SFTP ErpAck Folder FND"; Text[50])
        {
            CaptionML = ENU = 'ErpAck Folder',
                        FRA = 'Dossier ErpAck';
            Description = 'ESKER1.1,HEI.06';
        }
        field(50021; "ESKER SFTPInMsterDataFoldr FND"; Text[50])
        {
            CaptionML = ENU = 'InMasterData Folder',
                        FRA = 'Dossier tables rï¿½fï¿½rentielles';
            Description = 'ESKER1.1,HEI.06';
        }
        field(50022; "ESKER Max. Tolerance Amt FND"; Decimal)
        {
            BlankZero = true;
            CaptionML = ENU = 'Max. Tolerance Amount',
                        FRA = 'Montant ï¿½cart max.';
            DecimalPlaces = 0 : 5;
            Description = 'ESKER1.1,HEI.06';
        }
        field(50023; "ESKER Unpaid Invoices FND"; Text[50])
        {
            CaptionML = ENU = 'Unpaid Invoices',
                        FRA = 'Factures non payï¿½es';
            Description = 'ESKER1.1,HEI.06';
        }
        field(50024; "ESKER Paid Invoices FND"; Text[50])
        {
            CaptionML = ENU = 'Paid Invoices',
                        FRA = 'Factures payï¿½es';
            Description = 'ESKER1.1,HEI.06';
        }
        field(50025; "WHT Certificate No. Series FND"; Code[10])
        {
            Caption = 'WHT Certificate No. Series';
            Description = 'HEI.07';
            TableRelation = "No. Series";
        }
        field(50026; "Print Dialog FND"; Boolean)
        {
            Caption = 'Print Dialog';
            Description = 'HEI.07';
        }
        field(50027; "Print WHT Docs. Pay. Post FND"; Boolean)
        {
            Caption = 'Print WHT Docs. on Pay. Post';
            Description = 'HEI.07';
        }
        field(50028; "Reason Code Block Vendor FND"; Code[20])
        {
            Caption = 'Reason Code Block Vendor';
            Description = 'HEI.08';
            TableRelation = "Blocked Reason FND".Code;
        }
        field(50029; "MissingBnkDetailReasonCode FND"; Code[20])
        {
            Description = 'HEI.09';
            Caption = 'Missing Bank Detail Reason Code';
            TableRelation = "Blocked Reason FND".Code;
        }
        field(50030; "NPO Prepayment req.subtype FND"; Code[10])
        {
            Description = 'HEI.10';
            Caption = 'NPO Prepayment Request Subtype';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Purchase));  // BC Upgrade SHUKLP03

            trigger OnValidate();
            begin
                //HEI.06
                if "NPO Prepayment req.subtype FND" <> xRec."NPO Prepayment req.subtype FND" then begin
                end;
            end;
        }
        field(50031; "NPO Prepayment inv.subtype FND"; Code[10])
        {
            Description = 'HEI.06';
            Caption = 'NPO Prepayment Invoice Subtype';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Purchase));  // BC Upgrade SHUKLP03
        }
        field(50032; "NPOPrepaymentCrdMemosubtyp FND"; Code[10])
        {
            Description = 'HEI.06';
            Caption = 'NPO Prepayment Credit Memo Subtype';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Purchase));  // BC Upgrade SHUKLP03
        }
        field(50033; "PO Prepayment inv. subtype FND"; Code[10])
        {
            Description = 'HEI.06';
            Caption = 'PO Prepayment Invoice Subtype';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Purchase));  // BC Upgrade SHUKLP03
        }
        field(50034; "POPrepaymentCrdMemosubtype FND"; Code[10])
        {
            Description = 'HEI.06';
            Caption = 'PO Prepayment Credit Memo Subtype';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Purchase));  // BC Upgrade SHUKLP03
        }
        field(50035; "PO Prepayment req. Subtype FND"; Code[10])
        {
            Caption = 'PO Prepayment Request Subtype';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Purchase));  // BC Upgrade SHUKLP03 
        }
        field(50037; "Print WHT Docs.Credit Memo FND"; Boolean)
        {
            Caption = 'Print WHT Docs. on Credit Memo';
        }
        field(50038; "Expense Claim Invoices Nos FND"; Code[10])
        {
            Caption = 'Expense Claim Invoice Nos.';
            TableRelation = "No. Series";
        }
        field(50039; "Posted Exp Claim Inv. Nos FND"; Code[10])
        {
            Caption = 'Posted Expense Claim Invoice Nos.';
            TableRelation = "No. Series";
        }
        field(50040; "Expense claim crd memos No FND"; Code[10])
        {
            Caption = 'Expense Claim Credit Memo Nos.';
            TableRelation = "No. Series";
        }
        field(50041; "Posted Exp Claim CM Nos FND"; Code[10])
        {
            Caption = 'Posted Expense Claim Credit Memo Nos.';
            TableRelation = "No. Series";
        }
        field(50042; "Expense Claim Subdoc. Type FND"; Code[10])
        {
            Caption = 'Expense Claim Subdocument Type';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Purchase));  // BC Upgrade SHUKLP03
        }
        field(50043; "Expense ClaimCMSubdoc Type FND"; Code[10])
        {
            Caption = 'Expense Claim Credit Memo Subdocument Type';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Purchase));  // BC Upgrade SHUKLP03
        }
        field(50044; "Auto.Arch.Del. Inv&CrMemos FND"; Boolean)
        {
            Caption = 'Auto. Archive/Delete Invoices & Credit Memos';
            Description = 'HEI.11';
        }
        field(50045; "Allow printing C&TP PO FND"; Boolean)
        {
            Caption = 'Allow printing C&TP PO';
            Description = 'HEI.12';
        }
        field(50046; "Allow VATChange C&TP Ord. FND"; Boolean)
        {
            Caption = 'Allow VAT Change C&TP Orders';
            Description = 'HEI.12';
        }
        field(50047; "Item Category FND"; Code[20])
        {
            Caption = 'Item Category';
            Description = 'HEI.14';
        }
        field(50048; "PO Legal Text FND"; BLOB)
        {
            Caption = 'PO Legal Text';
            Description = 'HEI.21';
            SubType = Memo;
        }
        field(50049; "PO Legal Txt International FND"; BLOB)
        {
            Caption = 'PO Legal Text International';
            Description = 'HEI.21';
            SubType = Memo;
        }
        field(50050; "Auto E-mail Active FND"; Boolean)
        {
            Description = 'HEI.13';
            Caption = 'Auto E-mail Active';
        }
        field(50051; "Posted Exp. Cost Doc. Nos. FND"; Code[10])
        {
            CaptionML = ENU = 'Posted Exp. Costs Doc. Nos.',
                        FRA = 'Nº FNP pour les comptes généraux';
            Description = 'HEI.15';
            TableRelation = "No. Series";
        }
        field(50052; "Enable FA Vendor Req. FND"; Boolean)
        {
            Caption = 'Enable FA Vendor Requirement';
            Description = 'HEI.06';
        }
        field(50053; "Prepmt.Via deduction final FND"; Boolean)
        {
            Description = 'HEI.18';
            Caption = 'Prepayment Via Deduction Final';
        }
        field(50054; "GR IR Invoice Writeoff No. FND"; Code[10])
        {
            Description = 'HEI.22';
            Caption = 'GR IR Invoice Write-off No.';
            TableRelation = "No. Series";
        }
        field(50055; "Footer Text FND"; BLOB)
        {
            Caption = 'PO Legal Text';
            Description = 'HEI.23';
            SubType = Memo;
        }
        field(50056; "Footer Text International FND"; BLOB)
        {
            Caption = 'PO Legal Text International';
            Description = 'HEI.23';
            SubType = Memo;
        }
        field(50057; "Posted GRIR Inv. Wrtoff No FND"; Code[10])
        {
            Description = 'HEI.22';
            Caption = 'Posted GRIR Invoice Write-off No.';
            TableRelation = "No. Series";
        }
        field(50058; "Requester ID Mandatory FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Hei.24';
            Caption = 'Requester ID Mandatory';
        }
        field(50059; "Tolerance Exceptions FND"; Integer)
        {
            CalcFormula = Count("Tolerance Exceptions FND");
            Caption = 'Tolerance Exceptions';
            Description = 'HEI.25';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50060; "Excluded Incoterms FND"; Text[100])
        {
            Caption = 'Excluded Incoterms';
            DataClassification = ToBeClassified;
            Description = 'HEI.26';
            TableRelation = "Shipment Method";
            ValidateTableRelation = false;
        }
        field(50061; "Location Code Imp Proc. FND"; Code[10])
        {
            Caption = 'Location Code for Import Process';
            DataClassification = ToBeClassified;
            Description = 'HEI.26';
            TableRelation = Location.Code;
        }
        field(50062; "Zone Code for Import Proc. FND"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.27';
            Caption = 'Zone Code for Import Proc.';
            TableRelation = Zone.Code;
        }
        field(50063; "Mandatory Region on Header FND"; Boolean)
        {
            Caption = 'Mandatory Region on Header';
            DataClassification = ToBeClassified;
            Description = 'HEI.28';
        }
        field(50064; "Corrective CM Not Allowed FND"; Text[50])
        {
            Caption = 'Corrective Credit Memo Not allowed';
            DataClassification = ToBeClassified;
            Description = 'HEI.29';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Purchase));  // BC Upgrade SHUKLP03 <<
            ValidateTableRelation = false;
        }
        field(50065; "Auto Email to Requestor FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.30';
            Caption = 'Auto Email to Requestor';
        }
        field(50066; "SPL Active FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.31';
            Caption = 'SPL Active';
        }
        field(50067; "SPL Account Group FND"; Text[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.32';
            Caption = 'SPL Account Group';
        }
        field(50068; "Astro Whse Rcpt Manl Post FND"; Boolean)
        {
            Caption = 'ASTRO Whse. Receipt Manual Posting';
            DataClassification = ToBeClassified;
            Description = 'HEI.33';
        }
        field(50069; "Enable PQ to PO check FND"; Boolean)
        {
            Caption = 'Enable PQ to PO check';
            DataClassification = ToBeClassified;
            Description = 'HEI.34';
        }
        field(50070; "H&S Levy Tax FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.35';
            Caption = 'H&S Levy Tax';
        }
        field(50071; "Excluded Countries Imp PO FND"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.38';
            Caption = 'Excluded Countries for Import PO';
            TableRelation = "Country/Region";
            ValidateTableRelation = false;
        }
        field(50072; "Check Tolerance Approval FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.37';
            Caption = 'Check Tolerance Approval';
        }
        field(50075; "Enabled Overdue Notifi. FND"; Boolean)
        {
            Caption = 'Enabled Overdue Notification';
            Description = 'HEI.39';
        }
        field(50076; "Overdue Days Email Notify FND"; DateFormula)
        {
            Caption = 'Overdue Days for Email Notification';
            Description = 'HEI.39';
        }
        field(50077; "CC Email ID for PO Send FND"; Text[100])
        {
            Caption = 'CC Email ID for PO Send';
            Description = 'HEI.39';
        }
        field(50078; "Exclude PO Doc. Subtype FND"; Code[50])
        {
            Caption = 'Exclude PO Document Subtype';
            Description = 'HEI.39';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Purchase));  // BC Upgrade SHUKLP03
            ValidateTableRelation = false;
        }
        field(50079; "No. of Emails Send Batch FND"; Integer)
        {
            Caption = 'No. of Emails to Send in Batch';
            Description = 'HEI.40';
        }
        field(50080; "Disable VendorBankAddCheck FND"; Boolean)
        {
            Caption = 'Disable Vendor Bank Address Check';
            Description = 'HEI.41';
        }
        field(50081; "Region Code for POC FND"; Code[10])
        {
            DataClassification = CustomerContent;
            Description = 'HEI.42';
            Caption = 'Region Code for POC';
            TableRelation = Location;
        }
        // field(2013611; "Deposit Point"; Option)
        // {
        //     CaptionML = ENU = 'Deposit Point',
        //                 FRA = 'Points consigne';
        //     Description = 'DIT-770 #776';
        //     OptionCaptionML = ENU = 'Posted Invoice,Posted Receipt',
        //                       FRA = 'Facture enregistré,Réception enregistré';
        //     OptionMembers = "Posted Invoice","Posted Receipt";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW17.10.05 DDR 19/08/2014 DIT-770 #776
        //         if "Deposit Point" = "Deposit Point"::"Posted Receipt" then begin
        //             "Receipt on Invoice" := true;
        //             "Return Shipment on Credit Memo" := true;
        //         end;

        //         if "Deposit Point" <> xRec."Deposit Point" then
        //             if AppMgt.IsObjectLicense(5, CODEUNIT::"Deposit Item Charges Mgt.", 4) <> 0 then
        //                 DepositChargeMgt.TestNoOpenDutyPointSalesExist(FIELDCAPTION("Deposit Point"));
        //         // >>DITW17.10.05 DDR DIT-770 #776
        //     end;
        // }
        // field(2013628; "Empty Goods Item No. Mandatory"; Boolean)
        // {
        //     CaptionML = ENU = 'Empty Goods Item Number Mandatory',
        //                 FRA = 'N° article vidange obligatoire';
        //     Description = 'DITW15.00.00.34';
        // }
        // field(2013636; "Allow Split Deposit per"; Option)
        // {
        //     CaptionML = ENU = 'Allow Split Deposit per',
        //                 FRA = 'Autoriser de scinder type consigne par';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     OptionCaptionML = ENU = ' ,Document,Entry',
        //                       FRA = ' ,Document,Ecriture';
        //     OptionMembers = " ",Document,Entry;
        // }
        // field(2013721; "Duty Point"; Option)
        // {
        //     CaptionML = ENU = 'Duty Point',
        //                 FRA = 'Point accises';
        //     Description = 'DITW15.00.00.24';
        //     OptionCaptionML = ENU = 'Posted Invoice,Posted Receipt',
        //                       FRA = 'Facture enregistré,Réception enregistré';
        //     OptionMembers = "Posted Invoice","Posted Receipt";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 27/05/2010
        //         if "Duty Point" = "Duty Point"::"Posted Receipt" then begin
        //             "Receipt on Invoice" := true;
        //             "Return Shipment on Credit Memo" := true;
        //         end;

        //         if "Duty Point" <> xRec."Duty Point" then
        //             if AppMgt.IsObjectLicense(5, CODEUNIT::"Tax Item Charges Mgt.", 4) <> 0 then
        //                 TaxChargeMgt.TestNoOpenDutyPointPurchExist(FIELDCAPTION("Duty Point"));
        //         // >>DITW15.00.00.37 DDR
        //     end;
        // }
        // field(2013732; "Default Tax Date"; Option)
        // {
        //     CaptionML = ENU = 'Default Tax Date',
        //                 FRA = 'Date de taxe par défaut';
        //     Description = 'DITW15.00.00.39 #1363';
        //     OptionCaptionML = ENU = 'Order Date,Expected Receipt Date',
        //                       FRA = 'Date commande,Date de rangement';
        //     OptionMembers = OrderDate,ShipRecvDate;
        // }
        // field(2013755; "DTax per Group Mandatory"; Boolean)
        // {
        //     CaptionML = ENU = 'Tax Group Mandatory',
        //                 FRA = 'Groupe taxe obligatoire';
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013763; "Order Discount Priority Method"; Option)
        // {
        //     Caption = 'Order Discount Priority Method';
        //     Description = 'NRQ#74597';
        //     OptionCaption = 'Use all orders discount,Use best order line';
        //     OptionMembers = "Use all orders discount","Use best order line";
        // }
        // field(2013764; "Order PromotionPriority Method"; Option)
        // {
        //     Caption = 'Order PromotionPriority Method';
        //     Description = 'DITW111.00.13 NRQ#95409';
        //     OptionMembers = "Use all orders","Use best order";
        // }
        // field(2013910; "Min. Volume Warning"; Option)
        // {
        //     CaptionML = ENU = 'Min. Volume (Cubage) Warning',
        //                 FRA = 'Alerte sur Minimum Volume (cubage)';
        //     Description = 'DITW18.00.07 DIT-770 #1971';
        //     OptionCaptionML = ENU = 'None,Warning,Blocking',
        //                       FRA = 'Aucun,Avertissement,Blocage';
        //     OptionMembers = "None",Warning,Blocking;
        // }
        // field(2013911; "Min. HL Volume Warning"; Option)
        // {
        //     CaptionClass = GetUomCaptionClassHL(FIELDNO("Min. HL Volume Warning"));
        //     CaptionML = ENU = 'Min. Volume Warning',
        //                 FRA = 'Alerte Volume Minimum';
        //     Description = 'DITW17.00.02 DIT-770 #189 DIT-770 #354';
        //     OptionCaptionML = ENU = 'None,Warning,Blocking',
        //                       FRA = 'Aucun,Avertissement,Blocage';
        //     OptionMembers = "None",Warning,Blocking;
        // }
        // field(2013912; "Min. Eq. UOM Quantity Warning"; Option)
        // {
        //     CaptionClass = GetUomCaptionClassEqUom(FIELDNO("Min. Eq. UOM Quantity Warning"));
        //     CaptionML = ENU = 'Min. Eq. UOM Warning ',
        //                 FRA = 'Alerte sur Min. Equiv. Unité mesure ';
        //     Description = 'DITW17.00.02 DIT-770 #189 - DIT-770 #354';
        //     OptionCaptionML = ENU = 'None,Warning,Blocking',
        //                       FRA = 'Aucun,Avertissement,Blocage';
        //     OptionMembers = "None",Warning,Blocking;
        // }
        // field(2013914; "Min. Equivalent UOM"; Code[20])
        // {
        //     CaptionML = ENU = 'Min. Equivalent UOM',
        //                 FRA = 'Min. Equiv. Unité de Mesure';
        //     Description = 'DITW18.00.07 DIT-770 #1971';
        //     TableRelation = "Unit of Measure";
        // }
        // field(2013915; "Max. Volume Warning"; Option)
        // {
        //     CaptionML = ENU = 'Max. Volume (Cubage) Warning',
        //                 FRA = 'Avertissement maximum volume (Cubage)';
        //     Description = 'DITW18.00.07 DIT-770 #1971';
        //     OptionCaptionML = ENU = 'None,Warning,Blocking',
        //                       FRA = 'Aucun,Avertissement,Blocage';
        //     OptionMembers = "None",Warning,Blocking;
        // }
        // field(2013916; "Max. Weight Warning"; Option)
        // {
        //     CaptionML = ENU = 'Max. Weight Warning',
        //                 FRA = 'Avertissement Poids maximum';
        //     Description = 'DITW18.00.07 DIT-770 #1971';
        //     OptionCaptionML = ENU = 'None,Warning,Blocking',
        //                       FRA = 'Aucun,Avertissement,Blocage';
        //     OptionMembers = "None",Warning,Blocking;
        // }
        // field(2013918; "Min. Weight Warning"; Option)
        // {
        //     CaptionML = ENU = 'Min. Weight Warning',
        //                 FRA = 'Poids Minimum Pour Avertissement';
        //     Description = 'DITW18.00.07 DIT-770 #1971';
        //     OptionCaptionML = ENU = 'None,Warning,Blocking',
        //                       FRA = 'Aucun,Avertissement,Blocage';
        //     OptionMembers = "None",Warning,Blocking;
        // }
        // field(2014107; "Default Route"; Code[20])
        // {
        //     CaptionML = ENU = 'Default Route',
        //                 FRA = 'Route par défaut';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     //TableRelation = Route;  // BC Upgrade NANDIS03
        // }
        // field(2014108; "Route Mandatory"; Boolean)
        // {
        //     CaptionML = ENU = 'Route Mandatory',
        //                 FRA = 'Route Obligatoire';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        // }
        // field(2014410; "Vendor Shipment No. Mandatory"; Boolean)
        // {
        //     CaptionML = ENU = 'Vendor Shipment No. Mandatory',
        //                 FRA = 'N° Expédition Fournisseur Obligatoire';
        //     Description = 'DITW18.00.07 DIT-770 #1409';
        // }
        // field(2014411; "Max. Autom. VAT Amt. Adjustm."; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Max. Automatic VAT Amount Adjustment',
        //                 FRA = 'Montant maximum Ajustement automatique TVA';
        //     Description = 'DITW19.00.08 BL#10868';
        // }
        // field(2014412; "Max. Autom. Amount Adjustm."; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Max. Automatic Amount Adjustment',
        //                 FRA = 'Montant maximum Ajustement automatique';
        //     Description = 'DITW19.00.08 BL#10868';
        // }
        // field(2014415; "Automatic Document Approval"; Boolean)
        // {
        //     Caption = 'Automatic Document Approval';
        //     Description = 'DITW111.00.13 MSF 04/02/2019 NRQ#87409';
        // }
        // field(2014419; "Prices Priority Method"; Option)
        // {
        //     CaptionML = ENU = 'Prices Priority Method',
        //                 FRA = 'Méthode priorité Prix';
        //     Description = 'DITW16.00.00.42 DIT-715 #521';
        //     OptionCaptionML = ENU = 'Best Price,Vendor/Item',
        //                       FRA = 'Meilleur prix,Fourn./Article';
        //     OptionMembers = BestPriceValue,FirstType;
        // }
        // field(2014420; "Discounts Priority Method"; Option)
        // {
        //     CaptionML = ENU = 'Line Discounts Priority Method',
        //                 FRA = 'Méthode priorité Remises ligne';
        //     Description = 'DITW16.00.00.42 DIT-715 #521';
        //     OptionCaptionML = ENU = 'Best Discount,Cust./Item',
        //                       FRA = 'Meilleure remise,Client/Article';
        //     OptionMembers = BestDiscValue,FirstType,FirstLine;
        // }
        // field(2014424; "Item Exclusivity Warning"; Option)
        // {
        //     CaptionML = ENU = 'Item Exclusivity Warning',
        //                 FRA = 'Alerte exclusivité article';
        //     Description = 'DITW15.00.00.39 #1396';
        //     OptionCaptionML = ENU = 'No Warning,Confirmation,Blocked',
        //                       FRA = 'Aucune alerte,Confirmation,Bloqué';
        //     OptionMembers = "No Warning",Confirmation,Blocked;
        // }
        // field(2014425; "Exclusivity Group Mandatory"; Boolean)
        // {
        //     CaptionML = ENU = 'Exclusivity Group Mandatory',
        //                 FRA = 'Groupe exclusivité obligatoire';
        //     Description = 'DITW15.00.00.39 #1396';
        // }
        // field(2014429; "Pay-to/Buy-from Prices Calc."; Option)
        // {
        //     CaptionML = ENU = 'Pay-to/Buy-from Prices Calculation',
        //                 FRA = 'Calcul Prix Paiment/Fournisseur';
        //     Description = 'DITW18.00.07 DIT-770 #1941';
        //     OptionCaptionML = ENU = 'Pay-to,Buy-from',
        //                       FRA = 'Personne à payer,Fournisseur';
        //     OptionMembers = "Pay-to","Buy-from";
        // }
        // field(2014430; "ON HOLD unsatisfactory receipt"; Code[3])
        // {
        //     CaptionML = ENU = 'ON HOLD unsatisfactory receipt',
        //                 FRA = 'EN ATTENTE réception insatisfaisante';
        //     Description = 'DITW17.00.02 DIT-770 #144';
        // }
        // field(2014431; "Recalculate Prices"; Option)
        // {
        //     CaptionML = ENU = 'Recalculate Prices',
        //                 FRA = 'Recalculer Prix';
        //     Description = 'DITW18.00.07 DIT-770 #1975';
        //     OptionCaptionML = ENU = ' ,Confirm,Update',
        //                       FRA = ' ,Confirmer,Mettre à Jour';
        //     OptionMembers = " ",Confirm,Update;
        // }
        // field(2014443; "Allow Reverse Document Amount"; Boolean)
        // {
        //     CaptionML = ENU = 'Allow Reverse Document Amount',
        //                 FRA = 'Autoriser Montant inverse document';
        //     Description = 'DITW15.00.00.31';
        // }
        // field(2014447; "Show Posting Warnings"; Boolean)
        // {
        //     CaptionML = ENU = 'Show Posting Warnings',
        //                 FRA = 'Afficher Alertes sur validation';
        //     Description = 'DITW18.00.07 DIT-770 #1402';
        // }
        // field(2014448; "Show Reopen Warnings"; Boolean)
        // {
        //     CaptionML = ENU = 'Show Reopen Warnings',
        //                 FRA = 'Afficher Alertes sur Ouverture';
        //     Description = 'DITW18.00.07 DIT-770 #1402';
        // }
        // field(2014451; "Auto.Release Document on Whse."; Boolean)
        // {
        //     CaptionML = ENU = 'Automatic Release document with Whse. Receipt',
        //                 FRA = 'Lancer document automatique avec E&xpédition magasin';
        //     Description = 'DITW15.00.00.34';
        // }
        // field(2014496; "_Insert Std. Vend. Purch.Lines"; Option)
        // {
        //     CaptionML = ENU = 'Insert Std. Vend. Purch. Lines',
        //                 FRA = 'Insérer lignes achat fourn. std';
        //     Description = 'DITW15.00.00.39 DDR 27/04/2011 #1322 (BE field 11313)';
        //     Enabled = false;
        //     OptionCaptionML = ENU = 'Manual,Automatic,Always Ask',
        //                       FRA = 'Manuel,Automatique,Toujours demander';
        //     OptionMembers = Manual,Automatic,"Always Ask";
        // }
        // field(2014497; _Quotes; Boolean)
        // {
        //     CaptionML = ENU = 'Quotes',
        //                 FRA = 'Devis';
        //     Description = 'DITW15.00.00.39 DDR 27/04/2011 #1322 (BE field 11314)';
        //     Enabled = false;
        // }
        // field(2014498; _Orders; Boolean)
        // {
        //     CaptionML = ENU = 'Orders',
        //                 FRA = 'Commandes';
        //     Description = 'DITW15.00.00.39 DDR 27/04/2011 #1322 (BE field 11316)';
        //     Enabled = false;
        // }
        // field(2014499; _Invoices; Boolean)
        // {
        //     CaptionML = ENU = 'Invoices',
        //                 FRA = 'Factures';
        //     Description = 'DITW15.00.00.39 DDR 27/04/2011 #1322 (BE field 11317)';
        //     Enabled = false;
        // }
        // field(2014500; "_Credit Memos"; Boolean)
        // {
        //     CaptionML = ENU = 'Credit Memos',
        //                 FRA = 'Avoirs';
        //     Description = 'DITW15.00.00.39 DDR 27/04/2011 #1322 (BE field 11319)';
        //     Enabled = false;
        // }
        // field(2014504; "Pay-to/Buy-from Dimensions"; Option)
        // {
        //     CaptionML = ENU = 'Pay-to/Buy-from Dimensions',
        //                 FRA = 'Axes analytiques Personne à payer/Fournisseur';
        //     Description = 'DITW16.00.00.42 DIT-715 #522';
        //     OptionCaptionML = ENU = 'Pay-to,Buy-from',
        //                       FRA = 'Personne à payer,Fournisseur';
        //     OptionMembers = "Pay-to","Buy-from";
        // }
        // field(2014505; "Autofill End Date"; Boolean)
        // {
        //     CaptionML = ENU = 'Autofill Ending Date on Purchase Prices',
        //                 FRA = 'Remplissage auto. date de fin pour les prix d''achat';
        //     Description = 'DITW17.10.03 DIT-770 #617';
        // }
        // field(2014600; "Autoblock Vendor On Changes"; Boolean)
        // {
        //     Caption = 'Autoblock Vendor On Changes';
        //     Description = 'NRQ#13577';
        // }
        // field(2014601; "Autoblock Vend. On  Dimension"; Boolean)
        // {
        //     Caption = 'Autoblock Vendor On  Dimension';
        //     Description = 'NRQ#13577';
        // }
        // field(2014602; "Autoblock Vend. On BankAccount"; Boolean)
        // {
        //     Caption = 'Autoblock Vendor On BankAccount';
        //     Description = 'NRQ#13577';
        // }
        // field(2029610; "Show Invoice No."; Boolean)
        // {
        //     CaptionML = ENU = 'Show Invoice No.',
        //                 FRA = 'Voir le n° de facture';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029611; "Show Jnl. Template Selection"; Boolean)
        // {
        //     CaptionML = ENU = 'Show Jnl. Template Selection',
        //                 FRA = 'Afficher l''écran de sélection modèle feuille';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029612; "Block Invoicing From Orders"; Boolean)
        // {
        //     CaptionML = ENU = 'Block Invoicing From Orders',
        //                 FRA = 'Bloqué facturation d''ecran ordres d''achat';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029613; "Show Posted Document No."; Boolean)
        // {
        //     CaptionML = ENU = 'Show Posted Document No.',
        //                 FRA = 'Montrer no. document validée';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029614; "Keep Orders After Posting"; Boolean)
        // {
        //     CaptionML = ENU = 'Keep Orders After Posting',
        //                 FRA = 'Garder les commandes après avoir enregistré';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029615; "Purchase price mandatory"; Option)
        // {
        //     CaptionML = ENU = 'Purchase price warning (item)',
        //                 FRA = 'Ne permet pas prix égal à zéro',
        //                 FRB = 'Prix d''achat alerte (article)',
        //                 NLB = 'Inkoopprijs waarschuwing (artikel)';
        //     Description = 'FINXL10.01';
        //     OptionCaptionML = ENU = 'No Warning,Warning,Blocked',
        //                       FRB = 'Pas d''alerte,Alerte,Bloqué',
        //                       NLB = 'Geen waarschuwing, Waarschuwing Blokkeren';
        //     OptionMembers = "No Warning",Warning,Blocked;
        // }
        // field(2029616; "No Invoicing Without PO Match"; Boolean)
        // {
        //     CaptionML = ENU = 'No Invoicing Without PO Match',
        //                 FRA = 'Pas de facturation sans ordre d''achat correspendant';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029617; "Receipt Tolerance (Negative)"; Decimal)
        // {
        //     CaptionML = ENU = 'Receipt Tolerance % (Negative)',
        //                 FRA = 'Tolérance réception % (Négatif)';
        //     Description = 'FINXL7.00.001';
        //     MaxValue = 100;
        //     MinValue = 0;
        // }
        // field(2029618; "Receipt Tolerance (Positive)"; Decimal)
        // {
        //     CaptionML = ENU = 'Receipt Tolerance % (Positive)',
        //                 FRA = 'Tolérance réception % (Positif)';
        //     Description = 'FINXL7.00.001';
        //     MaxValue = 100;
        //     MinValue = 0;
        // }
        // field(2029619; "Check Totals on Purch. Inv./CM"; Boolean)
        // {
        //     CaptionML = ENU = 'Check Totals on Purch. Inv./CM',
        //                 FRA = 'Afficher totaux sur fact./avoir achat';
        //     Description = 'FINXL10.01';

        //     trigger OnValidate();
        //     begin
        //         /// FINXL7.00.001 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245
        //     end;
        // }
        // field(2029620; "Rcpt. Inv. Approval Margin Min"; Decimal)
        // {
        //     CaptionML = ENU = 'Approval margin rcpt. to inv. Min.(%)',
        //                 FRA = 'Marge de l''approbation fact. Min.(%)';
        //     Description = 'FINXL7.00.001';
        //     MaxValue = 100;
        //     MinValue = 0;
        // }
        // field(2029621; "Rcpt. Inv. Approval Margin Max"; Decimal)
        // {
        //     CaptionML = ENU = 'Approval margin rcpt. to inv. Max.(%)',
        //                 FRA = 'Marge de l''approbation fact. Max.(%)';
        //     Description = 'FINXL7.00.001';
        //     MaxValue = 100;
        //     MinValue = 0;
        // }
        // field(2029622; "Vendor Auto Dimension Code"; Code[20])
        // {
        //     Caption = 'Vendor Auto Dimension Code';
        //     Description = 'FINXL10.01';
        //     TableRelation = Dimension;
        // }
        // field(2029630; "Insert Std. Vend. Purch. Lines"; Option)
        // {
        //     CaptionML = ENU = 'Insert Std. Vend. Purch. Lines',
        //                 FRA = 'Insérer lignes achat fourn. std';
        //     Description = 'FINXL7.00.006';
        //     OptionCaptionML = ENU = 'Manual,Automatic,Always Ask',
        //                       FRA = 'Manuel,Automatique,Toujours demander';
        //     OptionMembers = Manual,Automatic,"Always Ask";
        // }
        // field(2029631; Quotes; Boolean)
        // {
        //     CaptionML = ENU = 'Quotes',
        //                 FRA = 'Devis';
        //     Description = 'FINXL7.00.006';
        // }
        // field(2029632; Orders; Boolean)
        // {
        //     CaptionML = ENU = 'Orders',
        //                 FRA = 'Commandes';
        //     Description = 'FINXL7.00.006';
        // }
        // field(2029633; Invoices; Boolean)
        // {
        //     CaptionML = ENU = 'Invoices',
        //                 FRA = 'Factures';
        //     Description = 'FINXL7.00.006';
        // }
        // field(2029634; "Credit Memos"; Boolean)
        // {
        //     CaptionML = ENU = 'Credit Memos',
        //                 FRA = 'Avoirs';
        //     Description = 'FINXL7.00.006';
        // }
        // field(2035394; "Batch PostOrders Print"; Boolean)
        // {
        //     CaptionML = ENU = 'Batch Post Orders Print',
        //                 FRA = 'TPL imprimer Commande vente';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        // }
        // field(2035395; "Batch PostOrders Status Filter"; Option)
        // {
        //     CaptionML = ENU = 'Batch Post Orders Status Filter',
        //                 FRA = 'Filtre status TPL valider cmde. vente imprimé';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     OptionCaptionML = ENU = ' ,Released',
        //                       FRA = ' ,Lancé';
        //     OptionMembers = " ",Released;
        // }
        // field(2035396; "Batch PO Receipt Statusfilter"; Option)
        // {
        //     CaptionML = ENU = 'Batch Post Orders Shipment Status Filter',
        //                 FRA = 'Filtre livraison status TPL valider cmde. vente imprimé';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     OptionCaptionML = ENU = 'Open,Order Printed,Order Send,Order Confirmed,To Receive,Receipt Completed,Invoice',
        //                       FRA = 'Commande Ouverte,Commande Imprimée,Commande Envoyée,Commande Confirmée,A Recevoir,Réception Compléte,Facturée';
        //     OptionMembers = Open,"Order Printed","Order Send","Order Confirmed","To Receive","Receipt Completed",Invoice;
        // }  // BC Upgrade NANDIS03

    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text001(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Job Queue Priority must be zero or positive.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Job Queue Priority must be zero or positive.;FRA=La valeur de la priorité file d'attente des travaux doit être nulle ou positive.;
    //Variable type has not been exported.

    var
        //TaxChargeMgt: Codeunit "Tax Item Charges Mgt.";  // BC Upgrade NANDIS03
        //DepositChargeMgt: Codeunit "Deposit Item Charges Mgt.";  // BC Upgrade NANDIS03
        //AppMgt: Codeunit ApplicationManagement;  // BC Upgrade NANDIS03
        Text2029610: Label 'Totals on all Invoices and Credit Memo''s must be recalculated.\Continue ?';
        Text2029611: Label 'Updating totals on Invoices and Credit Memo''s ... \\';
        Text2029612: Label 'Processing Document  #1#########################\\';
        Text2029613: Label 'Overall progress     @2@@@@@@@@@@@@@@@@@@@@@@@@@\\';
        Text2013660: TextConst ENU = ' must be Yes when %1 is %2.', FRA = ' doit être Oui quand %1 est %2.';
        Text2035340: TextConst ENU = 'You cannot reset %1 because table %2 contains one or more records with a %3.', FRA = 'Impossible de réinitialiser %1 comme le tableau %2 comprend un ou plusieurs le record avec %3.';
}

