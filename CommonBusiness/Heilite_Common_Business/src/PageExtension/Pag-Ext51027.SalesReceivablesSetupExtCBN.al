pageextension 51027 SalesnReceivablesSetupExtCBN extends "Sales & Receivables Setup"
{
    // version NAVW110.0,FINXL10.01DITW111.00.13A,HEI.40
    // DITW15.00.00.01 DDR 19/03/2008 Added Drink-It tab
    //                             Added fields "Deposit Warnings" into Drink-It tab
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.24 DDR 25/09/2008 Added fields "Duty Point" into Drink-It tab
    // DITW15.00.00.26 DDR 28/10/2008 Fields "Max. Order Discount % Allowed" into Drink-It tab
    // DITW15.00.00.31 DDR 18/02/2009 Added fields "Allow Reverse Document Amount" into Drink-It tab
    // DITW15.00.00.33 DDR 08/05/2009 Added fields "DTax per Group Mandatory" into Drink-It tab
    // DITW15.00.00.34 DDR 16/06/2009 Added fields into Drink-It tab
    //                             "Empty Goods Item No. Mandatory","Auto.Release Document on Whse."
    // DITW15.00.00.37 DDR 28/01/2010 issue 879 Added field "Bill-to/Sell-to Building Dim." into Drink-It tab
    //             BGI 09/06/2010 issue 1028 Added boolean cred. warning inclusif delayed discount
    // DITW15.00.00.39 DDR 27/04/2011 issue 1323 NAVBE5.00 (SP1) functionnality to insert Customer Std. Sales Codes automatically
    //                                 Added tab "Std. Customer Sales Codes"
    //                                 Added fields "Insert Std. Cust. Sales Lines" (see BE5.00 field 11313)
    //                                 Added function UpdateForm() (see BE5.00)
    //                                 Moved Drink-tab (InPage 7 -> 9)
    // DITW15.00.00.39 RBE 26/04/2011 issue 1230 Telesales functionnalities
    //                             Added fields "Sales History" into Telesales tab
    //             DDR 27/04/2011   Added fields "Copy Comments Cust. to Sell-to" into Telesales tab
    //                 19/08/2011 issue 1363 Added fields "Calculate Tax on Date" into Drink-it Tab
    //                 29/08/2011 issue 1396 Item Exclusivity functionnality
    //                                     Added fields "Item Exclusivity Warning" into Drink-it tab
    //                 11/10/2011 issue 1396 Added fields "Exclusivity Group Mandatory" into Drink-it tab
    //                 20/10/2011 issue 1396 Disabled field "Exclusivity Group Mandatory"
    // DITW16.00.00.40 DDR 18/04/2012 DIT-715 #243 Loyalty functionnality
    //                             Added fields "Loyalty Warnings" into Drink-it tab
    //                 18/06/2012 DIT-715 #243 Added fields "Enforce Loyalty on Free Item" into Drink-it tab
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields "Excl. Deposit Gen.Credit Limit" into Drink-it tab
    //                 07/12/2012 DIT-715 #370 Added fields "Allow Split Deposit on" into Drink-it tab
    //                 12/12/2012 DIT-715 #520 Added fields "Bill-to/Sell-to Prices Calc." into Drink-it tab
    //                 13/12/2012 DIT-715 #521 Added fields into Drink-it tab
    //                                         "Prices Priority Method","Discounts Priority Method"
    //                 13/12/2012 DIT-715 #522 Added fields "Bill-to/Sell-to Dimensions" into Drink-it tab
    //                 02/01/2013 DIT-715 #529 Added fields "Bill-to/Sell-to Salespers./P." into Drink-it tab
    //                 26/04/2013 DIT-715 #551 Added fields "Calculate Loyalty Balance" into Drink-it tab
    // DITW16.00.00.43 DDR 14/05/2013 DIT-715 #605 Added fields "Sale Price Mandatory" into Drink-it tab
    //                 24/05/2013 DIT-715 #497 Removed field 2014425 Exclusivity Group Mandatory
    //                 14/08/2013 DIT-715 #678 Added field "Excl. Deposit Payment Discount" into Drink-it tab

    // FINXL7.00.001 RBE 20/03/2013: added group Application with setup fields
    //                         Added fields "Use OGM", "Print OGM", "Show Jnl. Template Selection" on Application group
    // FINXL8.00.001 BSA 12/06/2015 #67: Created fields : "Print Method"

    // DITW17.00.02 DDR 14/05/2013 DIT-715 #605
    //         DDR 28/05/2013 DIT-715 #497 merge
    //         DDR 19/08/2013 DIT-715 #678 merge
    // DITW17.00.02 AT  04/09/2013 DIT-700 #136 merge
    // DITW17.00.02 AT  04/09/2013 DIT-770 #136 merge WHN-001 HIT0088
    //             Add field "Sales Conditions Based on" (tab Drink-IT)
    // DITW17.00.02 AT  09/09/2013 DIT-770 #145 merge WHN-001 HIT0016
    //                         Added field "Return reason code mandatory" on page
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 08/01/2014 DIT-770 #189 : New Field Added
    // DITW17.00.03 DDR 13/02/2014 DIT-770 #389 Sales Conditions Report
    //                                     Added fields for customer sales conditions
    // DITW17.10.03 MSF 16/05/2014 DIT-770 #354 :Move the min.equivalent uom from telesales setup to S&R setup, above the Min. Eq. UOM [] Warning.
    // DITW17.10.03 MSF 16/06/2014 DIT-770 #354 :Move "Min. Equivalent UOM" From "telesales setup" to  "Sales & Receivable Setup"
    //                                     Added field "Min. Equivalent UOM"
    // DITW17.10.03 DDR 13/06/2014 DIT-770 #392 Added field "Item Quota Management" (tab Drink-It)
    // DITW17.10.03 MSF 17/06/2014 DIT-770 #617 Autofill end date in Sales and purchase prices.
    //                                     Added field "Autofill End Date" (tab Drink-It)
    // DITW17.10.03 DDR 04/07/2014 DIT-770 #768 Added field "Prices & Discount Find Method" (tab Drink-It)
    // DITW17.10.03 DDR 04/07/2014 DIT-770 #699 Added field "Enforce Free Reason on Free","Default Qty. Delayed Promotion" (tab Drink-It)
    // DITW17.10.03 DDR 10/07/2014 DIT-770 #768 Remove field 2014418 Prices & Discount Find Method"
    // DITW17.10.05 WSA 04/08/14 DIT-770 #761 : Added field "Invoice List Document No." (tab Numbering)
    // DITW17.10.05 DDR 19/08/2014 DIT-770 #776 Added Deposit point functionality
    //                                     Added field 2013611 Deposit Point (tab Drink-It)
    // DITW17.10.05 YHE 02/09/2014 DIT-770 #754 : Add fields ("Shipment Date Alert Filter","Shipment Status Alert Filter")
    // DITW17.10.05 WSA 10/11/2014 DIT-770 #779 : Added Field "Event Doc. Nos."
    // DITW17.10.05 WSA 05/12/2014 DIT-770 #185 : Added field "Automatic Loyalty Exchange"
    // DITW17.10.05 WSA 12/12/2014 DIT-770 #185 : Added field "Loyalty on Bill-to/Sell-to"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 27/11/2014 DIT-770 #654 Set the visibility of checkbox "Block Invoicing from Orders" in group "Application" to "FALSE"
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 26/06/2015 DIT-770 #1347 Added fields
    //                                                 2035390  "Order Pick Ship Filter Till"
    //                                                 2035391  "Combined Pick Ship Filter Till"
    //                                                 2035392  "Order Shpt Ship Filter Till"
    //                                                 2035393  "Comb Shpt Ship Filter Till"
    //                                                 2035394  "Batch PostOrders Print"
    //                                                 2035395  "Batch PostOrders Status Filter"
    //                                                 2035396  "Batch PO Shipment Statusfilter"
    // DITW18.00.06 MSF 21/09/2015 DIT-770 #1261 Added Tab Event Managment
    // DITW18.00.06 MSF 02/10/2015 DIT-770 #1604 Added Field 2014107 "Default Route"
    // DITW18.00.06 MVN 15/10/2015 DIT-770 #1507 Added Fields in DRINK-IT Group "Returned Items":
    //                                             2014063 Returns Item Category Filter
    //                                             2014064 Returns Item Filter
    // DITW18.00.07 AKH 16/03/2016 DIT-770 #960 Added fields "Max. Volume Warning" & "Max. Weight Warning" to "Drink-It" tab
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #960 Moved fields "Max. Volume Warning" & "Max. Weight Warning" to "Telesales" tab
    // DITW18.00.07 AKH 23/03/2016 DIT-770 #960 Added field "Min. Weight Warning" in "Telesales" tab
    // DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    // DITW18.00.07 DDR 14/04/2016 DIT-770 #1402 Added field "Show Reopen Warnings" (tab Drink-It)
    // DITW18.00.07 DDR 19/04/2016 DIT-770 #1488 Added field "Route Mandatory" (tab Drink-It)
    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Field "Late Order Warning" (tab Drink-It\other)
    // DITW18.00.07 DDR 01/07/2016 DIT-770 #1282 Move "Latest Order Date/Time" field into (tab Drink-It\Transport)
    // DITW19.00.08 AKH 05/10/2016 BL#10806 (DIT-770 #1800) Added field "Show Warning ShptDate-Workdate" (tab Drink-It\other)

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 13/04/2017 NRQ#9710 Set the visibility of field "Do Not Allow Zero Price" in group "Application" to "FALSE"
    // DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Added new field "Close Lines at Shipment Status"
    // DITW110.00.10 MSF 27/06/2017 NRQ#13550 Return registration and control
    //                         Remove fields "Returns Item Category Filter" & "Returned items"
    // DITW110.00.10 MSF 18/07/2017 NRQ#16224
    //                             2014109"Post Linked Return Order"
    // FINXL10.01 AKH 19/07/2017 NRQ#33089 Added field 2029620 "Customer Auto Dimension Code" under Application tab
    // DITW110.00.10 AKH 28/07/2017 NRQ#17407 Put the Visible property of field "Do Not Allow Zero Price" in group "Application" back to "TRUE"
    // FINXL10.01 OFE 30/08/2017 NRQ#10433: Changed field name 2029615"Do Not Allow Zero Price" => "Sales price mandatory"
    // DITW110.00.11 MSF 07/11/2017 NRQ#13577 Autoblock Customer, Item, Vendor card based on setup
    //                             Added fields Autoblock Customer On Changes
    //                                         Autoblock Cust. On  Dimension
    //                                         Autoblock Cust. On  BankAccount
    // DITW110.00.11 VSC 09/10/2017 NRQ#33755 Removed field 2014066 "Close Lines at Shipment Status"
    // DITW110.00.11 VSC 27/11/2017 NRQ#33755 Added Field "Auto Proc. Backord. On Posting"
    // DITW110.00.12A MSF 26/06/2018 NRQ#74597 Order discount should calculate for all Ã† not apply priority
    //                                     Added field  2013763 "Order Discount Priority Method"
    // DITW111.00.13 DDR 10/12/2018 NRQ#95409 Add field "Order Promotion Priority Method"
    // DITW111.00.13 MSF 13/12/2018 NRQ#94671 Added field "Show Item Tracking Alter on SO"
    // HEI.01 FDD-PTPGAP002 IBM HORTOC01 19.08.2017
    // # New field "Reason Code Block Customer"
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    // # Added WHT group
    // # New fields for MDM integration in WHT group: Print WHT on Credit Memo, Print Dialog
    // # New field: "Return Order Mandatory"
    // HEI.03 FDD-RTRGAP060 IBM HORTOC01 1.09.2017
    // # New fields and new group "Sales Forecast"
    // HEI.04 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    // # New group "RPM Damage or Loss" created and related fields
    // HEI.05 FDD-OTCGAP016C IBM NASTAA02 29.11.2017 # Credit Control Check
    // # New group "Order Release Checks" created and related fields
    // HEI.06 FDDKDDOTC001 IBM HORTOC01 08.02.2018
    // # code added
    // HEI.07 FDD-SLSGAP015 IBM NASTAA02 24.04.2018 # Default Dimensions in the Promotion Charges
    // # New Field added "Free Reason Code Mandatory"
    // HEI.08 FDD-OTCGAP075 IBM NASTAA02 15.05.2018 # No dependency between respective credit risk Master Date fields in the system
    // # New Fields added "Default Risk Score" and "Default Risk Grade"
    // HEI.09 RW-GAPLOG08 IBM LAZARE02 23.10.2018 # New field Activate CIS System for EBM interface
    // HEI.10 RPM Breakages IBM ISYED01 03.22.2019
    // # added new filed "RPM Chipped comp.%" and "RPM Chipped comp. Res.no."
    // DITW111.00.13 MSF 04/02/2019 NRQ#87409 Reopen and Release an already approved sales order
    //                                     Added Field "Automatic Document Approval"
    // HEI.10 IBM MATHEJ01 13.08.19 - #CHG2023306 Update report Proforma Invoice
    // # Added new field: "Beer Density"
    // HEI.11 FDD-HB622 IBM NASTAA02 22.08.2019 # Customer ledger entries automatic application credit notes
    // # New Field added: "Enable Auto App Sales Cr Memo"
    // HEI.12 CHG2026335 HT653 FDD_La Reunion_EDI_EDI Order IBM GAVANM01 04.10.2019  #new field added:  EDI Nos.
    // HEI.13 FDD-HT914 IBM BULIMC01 09.10.2019 #new field "Amount Round. Precision Disc." displayed in Drink-IT tab - Price&Condition
    // HEI.14 FDD-HT657 IBM NASTAA02 14.11.2019 # Ethiopia Intercompany Automation
    // # New Field added: "Special Order by Default"
    // HEI.15 CHG2032964 IBM.LS 05.11.2019
    // # New Field added: "Account Group for AIRSI"
    // HEI.16 CHG2023313 IBM.AB 05.11.2019
    // # Field Added 'Item Avlblty Message Enable'
    // HEI.17 CHG2026335 IBM GAVANM01 09.01.2020 # new field "Item availability"
    // HEI.18 CHG2035637 IBM.LS 14.01.2020
    // # New Field added: "Block Reason for New Customer"
    // DITW113.00.15 DDR 04/10/2019 NRQ#9775 Add field "Loyalty Priority Method" (DrinkIt tab)
    // HEI.19 CHG2010375 IBM.LS 22.01.2020
    // # New Field added: "Enable OTC Billing Automation"
    // DITW110.00.12 MSF 27/04/2018 NRQ#10488 Loyalty Management â€“ several issues
    //                             Remove Fields "Enforce Loyalty on Free Item"
    // DITW113.00.15 DDR 09/10/2019 NRQ#122793 Add field "Loyalty Amount Point" (DrinkIt tab)
    // HEI.20 CHG2010375 IBM.LS 17.02.2020
    // # New Field added: "Excl. Inv/CM for E-Mail/Print"
    // HEI.21 CHG2010375 IBM KUMARN15 29.04.2020
    // # Added field "OTC Billing Automate JQ UserID", code on OnValidate of Job Queue Category Code
    // HEI.22 CHG2060791 IBM SHANKJ03 28.05.2020
    // # added new field "Export Invoice"
    // HEI.23 FDD-HT1203 IBM KUMARN15 03.06.2020
    // # Added field 50059 Skip Custom Reminder Logic
    // HEI.24 CHG2070787 IBM GAVANM01 03.09.2020 - Update all Billing documents in line with Global (for the BAHAMAS)
    // # Added field 'Customer Service E-Mail' in General tab
    // HEI.25 CHG2096435 HT1805 IBM GAVANM01 12.02.2021 - Invoice Layout
    // # Added field 'Bank based on invoice currency' in General Tab
    // HEI.26 CHG2109621 HT2170 IBM GAVANM01 10.06.2021 - Posting Setup for Sales Tax (Timbre), transport, free products
    // # Added fields: Timbre Electronique, Timbre Resource Code, Editable Timbre Docs.
    // HEI.28 HB2339 - CHG2109497 IBM NASTAA02 09.07.2021 # Customer Statements to be issued automatically at month end
    // # New Group created: "Reports"
    // # New Fields added
    // HEI.29 HB2310 CHG2113088 IBM GAVANM01 16.07.2021 #Pre-Email Notification to Customers
    // # New group created within group Reports: Pre-Email Notification
    // # New fields added: Prior Due Date Days, Remaining Amount limit
    // HEI.30 HB2487 CHG2123592 IBM MAJUMS03 #Cash Application where 92% of Customer pay in advance
    // # Added fields: SO Mandatory For Cash Cust <Application on SO Mandatory For Cash Customer>
    // Ref Value for Cash Customers <Ref Value for Cash Customers>
    // HEI.31 HB2935 CHG2156365 IBM GHOSHS05 #MTC_FIN_Autobilling Error log Deletion Functionality
    // # New fields created: 50075 - "Autobilling JQ Deletion Period"
    // HEI.33 CHG2151260-HB2788 IBM SOICAD02 06.11.2022 New field Enable EBMS Interface
    // HEI.34 CHG2164305 IBM COSTES04 20.12.2022 - Primary_Secondary CCC Shipping Cost Allocation
    // # New fields Market Type Dim. Code , Market Type Domestic, Market Type Export
    // HEI.32 CHG2168337 HB2821 IBM BHANDS01 13.09.2022 OrderSync Astro WMS Integration
    // # New field added in General tab "Transportation Cost"
    // HEI.35 CHG2131424 IBM SISUM01 01/05/2023 HB2520 Dimension Validation HeiLite
    // # New field: "Dim. Comb. Not Appl."
    // HEI.36 CHG2236524 IBM SISUM01 24.02.2024 HB3724-Lareunion-Discard automatic sending of Logistics email
    // # New field: "Email not to be sent to Log." - displayed in General group
    // HEI.37 CHG2228480-HB3631 COSTES04 10.04.2024 Sierra Leone Automate the separation of deposit and finish product
    // # New field Cust. Stmt. Report Date 2
    // HEI.38 CHG2236702 IBM COSTES04 26.06.2024 Column Data Availability of WH Shipment & WH Receipt No
    // # New field Shipment Date Mandatory
    // HEI.39 CHG2228480-HB3631 COSTES04 02.08.2024 Sierra Leone Automate the separation of deposit and finish product
    // # Remove field Cust. Stmt. Report Date 2
    // # Add page part customer statement
    // HEI.40 CHG2260099 COSTES04 18.09.2024 Automatic Archiving of Gate Entry Outbound While Undoing Sales Shipment.
    // # New field added Gate Entry Archived Required
    // HEI.41 IBM COSTES04 17.01.2025 CHG2279679-HB4118-Automatic restart of deadlock errors for auto billing
    // # New fields added: "Autobilling JQ Restart",  "Autobilling JQ Min. To Restart", "Autobilling JQ Min. To Notify"
    // # New fasttab created: Autobilling
    // HEI.42 CHG2294105 IBM ADHIKG01 15.04.2025 Addition column in delivery note for missing crate, low fills
    // # New field added : "Show Additional Column on Delivery Note"
    // HEI.44 IBM COSTES04 27.06.2025 CHG2307645-HB4324-Emailing invoices for goods and empty goods
    // # New fields: Empties CM Rep. ID, Empties Inv. Rep. ID

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'GËÇÜnËÇÜral';
        }
        modify("Discount Posting")
        {
            ToolTipML = ENU = 'Specifies the type of sales discounts to post separately.', FRA = 'SpËÇÜcifie le type de remises vente ËÇª valider sËÇÜparËÇÜment.';
        }
        modify("Credit Warnings")
        {
            ToolTipML = ENU = 'Specifies whether to warn about the customer''s status when you create a sales order or invoice.', FRA = 'SpËÇÜcifie s''il convient de signaler le statut du client lorsque vous crËÇÜez une facture ou une commande vente.';
        }
        modify("Stockout Warning")
        {
            ToolTipML = ENU = 'Specifies if a warning is displayed when you enter a quantity on a sales document that brings the item''s inventory level below zero.', FRA = 'SpËÇÜcifie si un avertissement s''affiche lorsque vous entrez une quantitËÇÜ sur un document vente qui am•áne le niveau de stock de l''article en dessous de zËÇÜro.';
        }
        modify("Shipment on Invoice")
        {
            ToolTipML = ENU = 'Specifies that a posted shipment and a posted invoice are automatically created when you post an invoice.', FRA = 'SpËÇÜcifie qu''une expËÇÜdition validËÇÜe et une facture enregistrËÇÜe sont automatiquement crËÇÜËÇÜes lorsque vous enregistrez une facture.';
        }
        modify("Return Receipt on Credit Memo")
        {
            ToolTipML = ENU = 'Specifies that a posted return receipt and a posted sales credit memo are automatically created when you post a credit memo.', FRA = 'SpËÇÜcifie qu''une rËÇÜception retour enregistrËÇÜe et qu''un avoir vente validËÇÜ sont automatiquement crËÇÜËÇÜs lorsque vous validez un avoir.';
        }
        modify("Invoice Rounding")
        {
            ToolTipML = ENU = 'Specifies that amounts are rounded for sales invoices.', FRA = 'SpËÇÜcifie que les montants sont arrondis pour les factures vente.';
        }
        modify(DefaultItemQuantity)
        {
            CaptionML = ENU = 'Default Item Quantity', FRA = 'QuantitËÇÜ par dËÇÜfaut de l''article';
            ToolTipML = ENU = 'Specifies that the Quantity field is set to 1 when you fill the Item No. field.', FRA = 'SpËÇÜcifie que le champ QuantitËÇÜ est dËÇÜfini sur 1 lorsque vous complËÇÜtez le champ N“ˆ article.';
        }
        modify("Create Item from Description")
        {
            ToolTipML = ENU = 'Specifies whether the system will suggest to create a new item when no item matches the description.', FRA = 'SpËÇÜcifie si le syst•áme sugg•áre de crËÇÜer un article lorsqu''aucun article ne correspond ËÇª la description.';
        }
        modify("Ext. Doc. No. Mandatory")
        {
            ToolTipML = ENU = 'Specifies whether it is mandatory to enter an external document number in the External Document No. field on a sales header or the External Document No. field on a general journal line.', FRA = 'SpËÇÜcifie si la saisie d''un numËÇÜro document externe est obligatoire dans le champ N“ˆ doc. externe d''un en-t›åte vente ou dans le champ N“ˆ doc. externe d''une ligne feuille comptabilitËÇÜ.';
        }
        modify("Appln. between Currencies")
        {
            ToolTipML = ENU = 'Specifies whether it is allowed to apply customer payments in different currencies.', FRA = 'SpËÇÜcifie s''il est autorisËÇÜ de lettrer des r•áglements client dans diffËÇÜrentes devises.';
        }
        modify("Logo Position on Documents")
        {
            ToolTipML = ENU = 'Specifies the position of your company logo on business letters and documents.', FRA = 'SpËÇÜcifie la position du logo de votre sociËÇÜtËÇÜ sur les lettres commerciales et les documents professionnels.';
        }
        modify("Freight G/L Acc. No.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account that must be used for freight charges.', FRA = 'SpËÇÜcifie le compte gËÇÜnËÇÜral qui doit ›åtre utilisËÇÜ pour les frais de transport.';
        }
        modify("Default Posting Date")
        {
            ToolTipML = ENU = 'Specifies how to use the Posting Date field on sales documents.', FRA = 'SpËÇÜcifie comment utiliser le champ Date comptabilisation sur les documents vente.';
        }
        modify("Default Quantity to Ship")
        {
            ToolTipML = ENU = 'Specifies the default value that is inserted in the Qty. to Ship field on sales order lines and in the Return Qty. to Receive field on sales return order lines.', FRA = 'SpËÇÜcifie la valeur par dËÇÜfaut qui est insËÇÜrËÇÜe dans le champ QtËÇÜ ËÇª expËÇÜdier sur les lignes commande vente et dans le champ QtËÇÜ retour ËÇª recevoir sur les lignes retour vente.';
        }
        modify("Copy Comments Blanket to Order")
        {
            ToolTipML = ENU = 'Specifies whether to copy comments from blanket orders to sales orders.', FRA = 'SpËÇÜcifie s''il faut copier les commentaires de commandes ouvertes vers des commandes vente.';
        }
        modify("Copy Comments Order to Invoice")
        {
            ToolTipML = ENU = 'Specifies whether to copy comments from sales orders to sales invoices.', FRA = 'SpËÇÜcifie s''il faut copier les commentaires de commandes ventes vers des factures vente.';
        }
        modify("Copy Comments Order to Shpt.")
        {
            ToolTipML = ENU = 'Specifies whether to copy comments from sales orders to shipments.', FRA = 'SpËÇÜcifie s''il faut copier les commentaires de commandes ventes vers des expËÇÜditions.';
        }
        modify("Copy Cmts Ret.Ord. to Cr. Memo")
        {
            ToolTipML = ENU = 'Specifies whether to copy comments from sales return orders to sales credit memos.', FRA = 'SpËÇÜcifie s''il faut copier les commentaires de retours ventes vers des avoirs vente.';
        }
        modify("Copy Cmts Ret.Ord. to Ret.Rcpt")
        {
            ToolTipML = ENU = 'Specifies that comments are copied from the sales credit memo to the posted return receipt.', FRA = 'SpËÇÜcifie que les commentaires sont copiËÇÜs de l''avoir vente vers la rËÇÜception retour enregistrËÇÜe.';
        }
        modify("Allow VAT Difference")
        {
            ToolTipML = ENU = 'Specifies whether to allow the manual adjustment of VAT amounts in sales documents.', FRA = 'Indique s''il faut autoriser l''ajustement manuel des montants de TVA dans des documents vente.';
        }
        modify("Calc. Inv. Discount")
        {
            ToolTipML = ENU = 'Specifies whether the invoice discount amount is automatically calculated with sales documents.', FRA = 'SpËÇÜcifie si le montant de la remise facture est automatiquement calculËÇÜ avec des documents vente.';
        }
        modify("Calc. Inv. Disc. per VAT ID")
        {
            Visible = true;
            ToolTipML = ENU = 'Specifies that the invoice discount is calculated according to VAT Identifier.', FRA = 'SpËÇÜcifie que la remise facture est calculËÇÜe en fonction de l''Identifiant TVA.';
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            ToolTipML = ENU = 'Specifies a VAT business posting group for customers for whom you want the item price including VAT, to apply.', FRA = 'SpËÇÜcifie un groupe comptabilisation TVA pour les clients pour lesquels vous souhaitez appliquer le prix article TTC.';
        }
        modify("Exact Cost Reversing Mandatory")
        {
            ToolTipML = ENU = 'Specifies that a return transaction cannot be posted unless the Appl.-from Item Entry field on the sales order line Specifies an entry.', FRA = 'SpËÇÜcifie qu''une transaction de retour ne peut pas ›åtre validËÇÜe si le champ ’Écriture article ËÇª lettrer de la ligne commande vente contient une ËÇÜcriture.';
        }
        modify("Check Prepmt. when Posting")
        {
            ToolTipML = ENU = 'Specifies that you cannot ship or invoice an order that has an unpaid prepayment amount.', FRA = 'SpËÇÜcifie que vous ne pouvez pas expËÇÜdier ou facturer une commande dont le montant d''acompte n''est pas rËÇÜglËÇÜ.';
        }
        // BC Uograde NANDIS03 >>
        // modify("Archive Quotes and Orders")
        // {
        //     ToolTipML = ENU='Specifies whether to automatically archive sales quotes and sales orders when a sales quote/order is deleted.',FRA='SpËÇÜcifie si vous archivez automatiquement des devis et des commandes vente lorsqu''une commandes vente/un devis est supprimËÇÜ.';
        // }
        modify("Archive Quotes")
        {
            ToolTipML = ENU = 'Archive Quotes';
        }
        modify("Archive Orders")
        {
            ToolTipML = ENU = 'Archive Orders';
        }
        // BC Uograde NANDIS03 <<
        modify("Allow Document Deletion Before")
        {
            ToolTipML = ENU = 'Specifies if and when posted sales documents can be deleted. If you enter a date, posted sales documents with a posting date on or after this date cannot be deleted.', FRA = 'SpËÇÜcifie si, et quand, des documents vente validËÇÜs peuvent ›åtre supprimËÇÜs. Si vous saisissez une date, les documents vente validËÇÜs dont la date comptabilisation est ËÇÜgale ou postËÇÜrieure ËÇª cette date ne peuvent pas ›åtre supprimËÇÜs.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
        }
        modify("Customer Group Dimension Code")
        {
            ToolTipML = ENU = 'Specifies the dimension code for customer groups in your analysis report.', FRA = 'SpËÇÜcifie le code axe des groupes de clients de votre rapport d''analyse.';
        }
        modify("Salesperson Dimension Code")
        {
            ToolTipML = ENU = 'Specifies the dimension code for salespeople in your analysis report', FRA = 'SpËÇÜcifie le code axe des vendeurs de votre rapport d''analyse.';
        }
        modify("Number Series")
        {
            CaptionML = ENU = 'Number Series', FRA = 'Souche de numËÇÜros';
        }
        modify("Customer Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to customers.', FRA = 'SpËÇÜcifie le code de la souche de numËÇÜros qui est utilisËÇÜe pour affecter des numËÇÜros aux clients.';
        }
        modify("Quote Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to sales quotes.', FRA = 'SpËÇÜcifie le code de la souche de numËÇÜros qui est utilisËÇÜe pour affecter des numËÇÜros aux devis.';
        }
        modify("Blanket Order Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to blanket sales orders.', FRA = 'SpËÇÜcifie le code de la souche de numËÇÜros qui est utilisËÇÜe pour affecter des numËÇÜros aux commandes ouvertes vente.';
        }
        modify("Order Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to sales orders.', FRA = 'SpËÇÜcifie le code de la souche de numËÇÜros qui est utilisËÇÜe pour affecter des numËÇÜros aux commandes vente.';
        }
        modify("Return Order Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series that is used to assign numbers to new sales return orders.', FRA = 'SpËÇÜcifie la souche de numËÇÜros qui est utilisËÇÜe pour affecter des numËÇÜros ËÇª de nouveaux retours vente.';
        }
        modify("Invoice Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to sales invoices.', FRA = 'SpËÇÜcifie le code de la souche de numËÇÜros qui est utilisËÇÜe pour affecter des numËÇÜros aux factures vente.';
        }
        modify("Credit Memo Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to sales credit memos.', FRA = 'SpËÇÜcifie le code de la souche de numËÇÜros qui est utilisËÇÜe pour affecter des numËÇÜros aux avoirs vente.';
        }
        modify("Posted Shipment Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to shipments.', FRA = 'SpËÇÜcifie le code de la souche de numËÇÜros qui est utilisËÇÜe pour affecter des numËÇÜros aux expËÇÜditions.';
        }
        modify("Posted Return Receipt Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to posted return receipts.', FRA = 'SpËÇÜcifie le code de la souche de numËÇÜros qui est utilisËÇÜe pour affecter des numËÇÜros aux rËÇÜceptions retour enregistrËÇÜes.';
        }
        modify("Reminder Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to reminders.', FRA = 'SpËÇÜcifie le code de la souche de numËÇÜros qui est utilisËÇÜe pour affecter des numËÇÜros aux relances.';
        }
        modify("Issued Reminder Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to reminders when they are issued.', FRA = 'SpËÇÜcifie le code de la souche de numËÇÜros qui est utilisËÇÜe pour affecter des numËÇÜros aux relances lorsqu''elles sont ËÇÜmises.';
        }
        modify("Fin. Chrg. Memo Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to finance charge memos.', FRA = 'SpËÇÜcifie le code de la souche de numËÇÜros qui est utilisËÇÜe pour affecter des numËÇÜros aux factures d''intËÇÜr›åts.';
        }
        modify("Issued Fin. Chrg. M. Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to finance charge memos when they are issued.', FRA = 'SpËÇÜcifie le code de la souche de numËÇÜros qui est utilisËÇÜe pour affecter des numËÇÜros aux factures d''intËÇÜr›åts lorsqu''elles sont ËÇÜmises.';
        }
        modify("Direct Debit Mandate Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series for direct-debit mandates.', FRA = 'SpËÇÜcifie la souche de numËÇÜros pour mandats de prËÇÜl•ávement.';
        }
        modify("Background Posting")
        {
            CaptionML = ENU = 'Background Posting', FRA = 'Validation arri•áre-plan';
        }
        // modify(Post)
        // {
        //     CaptionML = ENU = 'Post', FRA = 'Valider';
        // }  // BC Upgrade NANDIS03
        modify("Post with Job Queue")
        {
            ToolTipML = ENU = 'Specifies if your business process uses job queues in the background to post sales and purchase documents, including orders, invoices, return orders, and credit memos.', FRA = 'SpËÇÜcifie si votre processus entreprise utilise des files d''attente des travaux en arri•áre-plan pour valider des documents vente et achat, y compris des commandes, des factures, des retours et des avoirs.';
        }
        // modify("Job Queue Priority for Post")
        // {
        //     ToolTipML = ENU = 'Specifies the priority of the job queue when you run it in the context of background posting. You can set different priorities for the post and post and print settings. The default setting is 1000.', FRA = 'SpËÇÜcifie la prioritËÇÜ de la file d''attente des travaux lorsque vous l''exËÇÜcutez dans le contexte d''une validation en arri•áre-plan. Vous pouvez dËÇÜfinir diffËÇÜrentes prioritËÇÜs pour les param•átres d''impression et de validation. Le param•átre par dËÇÜfaut est 1“000.';
        // }
        // modify("Post & Print")
        // {
        //     CaptionML = ENU = 'Post & Print', FRA = 'Valider et imprimer';
        // }// BC Upgrade NANDIS03
        modify("Post & Print with Job Queue")
        {
            ToolTipML = ENU = 'Specifies if your business process uses job queues to post and print sales documents.', FRA = 'SpËÇÜcifie si votre processus entreprise utilise des files d''attente des travaux pour valider et imprimer des documents vente.';
        }
        // modify("Job Q. Prio. for Post & Print")
        // {
        //     ToolTipML = ENU = 'Specifies the priority of the job queue when you run it in the context of background posting. You can set different priorities for the post and post and print settings. The default setting is 1000.', FRA = 'SpËÇÜcifie la prioritËÇÜ de la file d''attente des travaux lorsque vous l''exËÇÜcutez dans le contexte d''une validation en arri•áre-plan. Vous pouvez dËÇÜfinir diffËÇÜrentes prioritËÇÜs pour les param•átres d''impression et de validation. Le param•átre par dËÇÜfaut est 1“000.';
        // }// BC Upgrade NANDIS03

        // modify(Control7)
        // {
        //     CaptionML = ENU = 'General', FRA = 'GËÇÜnËÇÜral';
        // }// BC Upgrade NANDIS03
        modify("Job Queue Category Code")
        {
            ToolTipML = ENU = 'Specifies the code for the category of the job queue that you want to associate with background posting.', FRA = 'SpËÇÜcifie le code pour la catËÇÜgorie de la file d''attente des travaux que vous voulez associer ËÇª une validation d''arri•áre-plan.';
        }
        modify("Notify On Success")
        {
            ToolTipML = ENU = 'Specifies if a notification is sent when posting and printing is successfully completed.', FRA = 'SpËÇÜcifie si une notification est envoyËÇÜe lorsque la validation et l''impression aboutissent.';
        }

        //Unsupported feature: CodeInsertion on ""Job Queue Category Code"(Control 5)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<< HEI.21
        if "Job Queue Category Code" = '' then
          "OTC Billing Automate JQ UserID" := '';
        //>> HEI.21
        */
        //end;

        addafter("Default Posting Date")
        {
            field("Beer Density"; Rec."Beer Density FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Beer Density field.';
            }
        }
        addafter("Allow VAT Difference")
        {
            field("Block Reason for New Customer"; Rec."Block Reason for New Cust. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Block Reason for New Customer field.';
            }
        }

        addafter("Allow Document Deletion Before")
        {
            field("Reason Code Block Customer"; Rec."Reason Code Block Customer FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Reason Code Block Customer field.';
            }
            field("Return Order Mandatory"; Rec."Return Order Mandatory FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Return Order Mandatory field.';
            }
            field("Default Risk Score"; Rec."Default Risk Score FND")
            {
                Description = 'HEI.08';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Default Risk Score field.';
            }
            field("Default Risk Grade"; Rec."Default Risk Grade FND")
            {
                Description = 'HEI.08';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Default Risk Grade field.';
            }
            field("Activate CIS System"; Rec."Activate CIS System FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Activate CIS System field.';
            }
            field("Enable Auto App Sales Cr Memo"; Rec."Enable AutoAppSalesCr Memo FND")
            {
                Caption = 'Enable Auto App Sales Cr Memo';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable Auto App Sales Cr Memo field.';
            }
            field("Special Order by Default"; Rec."Special Order by Default FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Special Order by Default field.';
            }
            field("Account Group for AIRSI"; Rec."Account Group for AIRSI FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Account Group for AIRSI field.';
            }
            field("Item Avlblty Message Enable"; Rec."Item Avlblty Msg Enable FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable Item Availability Message field.';
            }
            field("Item availability"; Rec."Item availability FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable Item availability check on release field.';
            }
            field("Excl. Inv/CM for E-Mail/Print"; Rec."Excl.Inv/CM forEMail/Print FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Doc. Subtype to exclude for auto Email/Print field.';
            }

            // field("Excl. Inv/CM for E-Mail/Print"; Rec."Excl. Inv/CM for E-Mail/Print")
            // {
            // }  // BC Upgrade NANDIS03
            field("Email not to be sent to Log."; Rec."Email not to sent to Log. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Email not to be sent to Logistics field.';
            }
            field("Export Invoice"; Rec."Export Invoice FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Export Invoice field.';
            }
            field("Skip Custom Reminder Logic"; Rec."Skip Custom Reminder Logic FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Skip email sending reminder field.';
            }
            field("Customer Service E-Mail"; Rec."Customer Service E-Mail FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Service E-Mail field.';
            }
            field("Bank based on invoice currency"; Rec."Bank based on inv currency FND")
            {
                Description = '<HEI.25>';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bank based on invoice currency field.';
            }
            field("Mandatory Location on Header"; Rec."Mandatory Loc. on Header FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Mandatory Location on Header field.';
            }
            field("SO Mandatory For Cash Cust"; Rec."SO Mandatory For Cash Cust FND")
            {

                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Application on SO Mandatory For Cash Customer field.';
                trigger OnValidate();
                begin
                    //HEI.30>>
                    if not Rec."SO Mandatory For Cash Cust FND" then
                        Rec."Ref Value for Cash Cust. FND" := 0;
                    //HEI.30<<
                end;
            }
            field("Ref Value for Cash Customers"; Rec."Ref Value for Cash Cust. FND")
            {
                ApplicationArea = All;
                Editable = Rec."SO Mandatory For Cash Cust FND";
                Enabled = Rec."SO Mandatory For Cash Cust FND";
                ToolTip = 'Specifies the value of the Reference Value for Cash Customers field.';
            }
            field("Enable EBMS Interface"; Rec."Enable EBMS Interface FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable EBMS Interface field.';
            }
            field("Transportation Cost"; Rec."Transportation Cost FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable Transportation Cost field.';
            }
            field("Dim. Comb. Not Appl."; Rec."Dim. Comb. Not Appl. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension Combination Not Applicable field.';
            }
            field("Shipment Date Mandatory"; Rec."Shipment Date Mandatory FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipment Date Mandatory field.';
            }
            field("Gate Entry Archived Required"; Rec."Gate Entry Arch. Required FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gate Entry Archived Required field.';
            }

            field("Show Additional Column on DN"; Rec."Show Add. Column on DN FND")
            {
                Description = 'HEI.42';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Show Additional Column on DN field.';
            }

        }
        addafter("Salesperson Dimension Code")
        {
            group("Market Type Dimension")
            {
                Caption = 'Market Type Dimension';
                field("Market Type Dim. Code"; Rec."Market Type Dim. Code FND")
                {
                    Caption = 'Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Market Type Domestic"; Rec."Market Type Domestic FND")
                {
                    Caption = 'Domestic';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Domestic field.';
                }
                field("Market Type Export"; Rec."Market Type Export FND")
                {
                    Caption = 'Export';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Export field.';
                }
            }
        }
        addafter("Direct Debit Mandate Nos.")
        {
            // field("Invoice List Document Nos."; Rec."Invoice List Document Nos.")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #761';
            // }
            // field("Event Doc. Nos."; Rec."Event Doc. Nos.")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #779';
            // }  // BC Upgrade NANDIS03

            field("EDI Nos."; Rec."EDI Nos. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the EDI Nos. field.';
            }
        }
        //BC UPGRADE KUMARR78 >> Adding Field for MTC-FDD-MTC-012
        addafter("Document Default Line Type")
        {
            group("Batch Post Sales Order Defaults")
            {
                CaptionML = ENU = 'Batch Post Sales Order Defaults',
                            FRA = 'TPL dËÇÜfauts Commande vente';
                Visible = true;

                field("Batch PostOrders Print"; Rec."Batch PostOrders Print FND")
                {
                    CaptionML = ENU = 'Batch Post Orders Print',
                                FRA = 'TPL imprimer Commande vente';
                    ApplicationArea = all;
                }
                field("Batch PostOrders Status Filter"; Rec."Batch PostOrd.StatusFilter FND")
                {
                    AssistEdit = false;
                    ApplicationArea = all;
                }
                field("Batch PO Shipment Statusfilter"; Rec."Batch POShip. Statusfilter FND")
                {
                    AssistEdit = false;
                    ApplicationArea = all;
                }
            }
        }
        //BC UPGRADE KUMARR78 << Adding Field for MTC-FDD-MTC-012
        addafter("Number Series")
        {
            group(WHT)
            {
                Caption = 'WHT';
                field("Print WHT on Credit Memo"; Rec."Print WHT on Credit Memo FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Print WHT on Credit Memo field.';
                }
                field("Print Dialog"; Rec."Print Dialog FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Print Dialog field.';
                }
            }
        }
        addafter(WHT)
        {
            group("Sales Forecast")
            {
                Caption = 'Sales Forecast';
                field("Journal Batch Name Forecast"; Rec."Journal BatchName Forecast FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Forecast Batch Name field.';
                }
                field("Journal Template Name Forecast"; Rec."Jnl Template Name Forecast FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Forecast Template Name field.';
                }
                field("Accrual Account Forecast"; Rec."Accrual Account Forecast FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Forecast Accrual Acc. field.';
                }
                field("Royalty Account Forecast"; Rec."Royalty Account Forecast FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Forecast Royalty Acc. field.';
                }
                field("Know-How Account Forecast"; Rec."Know-How Account Forecast FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Forecast Know-How Acc. field.';
                }
                field("Know - How Fee %"; Rec."Know - How Fee % FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Know - How Fee % field.';
                }
            }
        }
        addafter("Sales Forecast")
        {
            group("Std. Customer Sales Codes")
            {
                Caption = 'Std. Customer Sales Codes';
                // field("Insert Std. Cust. Sales Lines"; Rec."Insert Std. Cust. Sales Lines")
                // {
                //     Description = 'DITW15.00.00.39 DDR 26/04/2011 #1323 (BE5.00)';

                //     trigger OnValidate();
                //     begin
                //         UpdateForm;
                //     end;
                // }  // BC Upgrade NANDIS03
                field(Control1010006; '')
                {
                    CaptionClass = Text19007050;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the '''' field.';
                }
                // field(Quotes; Rec.Quotes)
                // {
                //     Description = 'DITW15.00.00.39 DDR 26/04/2011 #1323 (BE5.00)';
                //     Enabled = QuotesEnable;
                // }
                // field(Orders; Rec.Orders)
                // {
                //     Description = 'DITW15.00.00.39 DDR 26/04/2011 #1323 (BE5.00)';
                //     Enabled = OrdersEnable;
                // }
                // field(Invoices; Rec.Invoices)
                // {
                //     Description = 'DITW15.00.00.39 DDR 26/04/2011 #1323 (BE5.00)';
                //     Enabled = InvoicesEnable;
                // }
                // field("Credit Memos"; Rec."Credit Memos")
                // {
                //     Description = 'DITW15.00.00.39 DDR 26/04/2011 #1323 (BE5.00)';
                //     Enabled = "Credit MemosEnable";
                // }  // BC Upgrade NANDIS03
            }
        }
        // group("Drink-It")
        // {
        //     CaptionML = ENU = 'Drink-It',
        //                 FRA = 'Drink-It';
        //     group(Deposit)
        //     {
        //         CaptionML = ENU = 'Deposit',
        //                     FRA = 'Consigne';
        //         field("Deposit Warnings"; Rec."Deposit Warnings")
        //         {
        //         }
        //         field("Empty Goods Item No. Mandatory"; Rec."Empty Goods Item No. Mandatory")
        //         {
        //         }
        //         field("Excl. Deposit Credit Warnings"; Rec."Excl. Deposit Credit Warnings")
        //         {
        //             Description = 'DIT-715 #370';
        //         }
        //         field("Allow Split Deposit per"; Rec."Allow Split Deposit per")
        //         {
        //             Description = 'DIT-715 #370';
        //         }
        //         field("Excl. Deposit Payment Discount"; Rec."Excl. Deposit Payment Discount")
        //         {
        //         }
        //         field("Deposit Point"; Rec."Deposit Point")
        //         {
        //         }
        //     }

        //     group(Tax)
        //     {
        //         CaptionML = ENU = 'Tax',
        //                     FRA = 'Taxes';
        //         field("Default Tax Date"; Rec."Default Tax Date")
        //         {
        //         }
        //         field("Duty Point"; Rec."Duty Point")
        //         {
        //         }
        //         field("DTax per Group Mandatory"; Rec."DTax per Group Mandatory")
        //         {
        //         }
        //     }
        //     group(Other)
        //     {
        //         CaptionML = ENU = 'Other',
        //                     FRA = 'Autre';
        //         field("Allow Reverse Document Amount"; Rec."Allow Reverse Document Amount")
        //         {
        //         }
        //         field("Show Posting Warnings"; Rec."Show Posting Warnings")
        //         {
        //         }
        //         field("Show Reopen Warnings"; Rec."Show Reopen Warnings")
        //         {
        //         }
        //         field("Show Warning ShptDate-Workdate"; Rec."Show Warning ShptDate-Workdate")
        //         {
        //         }
        //         field("Auto.Release Document on Whse."; Rec."Auto.Release Document on Whse.")
        //         {
        //         }
        //         field("Return reason code mandatory"; Rec."Return reason code mandatory")
        //         {
        //             Description = 'DITW17.00.02 DIT-770 #145';
        //         }
        //         field("Autoblock Customer On Changes"; Rec."Autoblock Customer On Changes")
        //         {
        //         }
        //         field("Autoblock Cust. On  Dimension"; Rec."Autoblock Cust. On  Dimension")
        //         {
        //         }
        //         field("Autoblock Cust. On BankAccount"; Rec."Autoblock Cust. On BankAccount")
        //         {
        //         }
        //         field("Automatic Document Approval"; Rec."Automatic Document Approval")
        //         {
        //         }
        //         field("Free Reason Code Mandatory"; Rec."Free Reason Code Mandatory")
        //         {
        //             Description = 'HEI.07';
        //         }
        //     }
        //     group(Transport)
        //     {
        //         CaptionML = ENU = 'Transport',
        //                     FRA = 'Transport';
        //         field("Default Route"; Rec."Default Route")
        //         {
        //         }
        //         field("Route Mandatory"; Rec."Route Mandatory")
        //         {
        //         }
        //         field("Late Order Warning"; Rec."Late Order Warning")
        //         {
        //             Description = 'DITW18.00.07 DIT-770 #1282';
        //         }
        //         field("Post Linked Return Order"; Rec."Post Linked Return Order")
        //         {
        //         }
        //         field("Auto Proc. Backord. On Posting"; Rec."Auto Proc. Backord. On Posting")
        //         {
        //             Description = 'NRQ#33755';
        //         }
        //         field("Show Item Tracking Alert on SO"; Rec."Show Item Tracking Alert on SO")
        //         {
        //         }
        //     }
        //     group("Event Management")
        //     {
        //         Caption = 'Event Management';
        //         field("Event Invoice Method"; Rec."Event Invoice Method")
        //         {
        //         }
        //         field("Event Invoice Period"; Rec."Event Invoice Period")
        //         {
        //         }
        //     }
        //     group("Price & Condition")
        //     {
        //         CaptionML = ENU = 'Price & Condition',
        //                     FRA = 'Prix & Condition';
        //         field("Sales Conditions Based on"; Rec."Sales Conditions Based on")
        //         {
        //         }
        //         field("Bill-to/Sell-to Prices Calc."; Rec."Bill-to/Sell-to Prices Calc.")
        //         {
        //             Description = 'DIT-715 #520';
        //         }
        //         field("Prices Priority Method"; "Prices Priority Method")
        //         {
        //             Description = 'DIT-715 #521';
        //         }
        //         field("Recalculate Prices"; "Recalculate Prices")
        //         {
        //         }
        //         field("Sales Price Mandatory"; "Sales Price Mandatory")
        //         {
        //         }
        //         field("Amount Round. Precision Disc."; "Amount Round. Precision Disc.")
        //         {
        //         }
        //         field("Bill-to/Sell-to Building Dim."; "Bill-to/Sell-to Building Dim.")
        //         {
        //         }
        //         field("Bill-to/Sell-to Dimensions"; "Bill-to/Sell-to Dimensions")
        //         {
        //             Description = 'DIT-715 #522';
        //         }
        //         field("Bill-to/Sell-to Salespers./P."; "Bill-to/Sell-to Salespers./P.")
        //         {
        //             Description = 'DIT-715 #529';
        //         }
        //         field("Autofill End Date"; "Autofill End Date")
        //         {
        //         }
        //     }
        //     group(Discount)
        //     {
        //         CaptionML = ENU = 'Discount',
        //                     FRA = 'Remise';
        //         field("Discounts Priority Method"; "Discounts Priority Method")
        //         {
        //             Description = 'DIT-715 #521';
        //         }
        //         field("Order Discount Priority Method"; "Order Discount Priority Method")
        //         {
        //         }
        //         field("Max. Order Discount % Allowed"; "Max. Order Discount % Allowed")
        //         {
        //         }
        //         field("Cr. Warning Incl. Delayed Disc"; "Cr. Warning Incl. Delayed Disc")
        //         {
        //         }
        //     }
        //     group(Promotion)
        //     {
        //         CaptionML = ENU = 'Promotion',
        //                     FRA = 'Promotion';
        //         field("Order PromotionPriority Method"; "Order PromotionPriority Method")
        //         {
        //         }
        //         field("Enforce Free Reason on Free"; "Enforce Free Reason on Free")
        //         {
        //         }
        //     }
        //     group(Exclusivity)
        //     {
        //         CaptionML = ENU = 'Exclusivity',
        //                     FRA = 'Exclusivit';
        //         field("Item Exclusivity Warning"; "Item Exclusivity Warning")
        //         {
        //         }
        //     }
        //     group(Loyalty)
        //     {
        //         Caption = 'Loyalty';
        //         field("Loyalty Point Warning"; "Loyalty Point Warning")
        //         {
        //         }
        //         field("Loyalty Amount Warning"; "Loyalty Amount Warning")
        //         {
        //         }
        //         field("Calculate Loyalty Balance"; "Calculate Loyalty Balance")
        //         {
        //         }
        //         field("Loyalty Priority Method"; "Loyalty Priority Method")
        //         {
        //         }
        //         field("Enable Loyalty"; "Enable Loyalty")
        //         {
        //             Description = 'DITW17.10.05 DIT-770 #185';
        //         }
        //         field("Loyalty on Bill-to/Sell-to"; "Loyalty on Bill-to/Sell-to")
        //         {
        //             Description = 'DITW17.10.05 DIT-770 #185';
        //         }
        //     }
        //     group(Quota)
        //     {
        //         CaptionML = ENU = 'Quota',
        //                     FRA = 'Devis';
        //         field("Item Quota Warning"; "Item Quota Warning")
        //         {
        //         }
        //     }
        //     group("Batch Post Sales Order Defaults")
        //     {
        //         CaptionML = ENU = 'Batch Post Sales Order Defaults',
        //                     FRA = 'TPL dËÇÜfauts Commande vente';
        //         field("Batch PostOrders Print"; "Batch PostOrders Print")
        //         {
        //             CaptionML = ENU = 'Batch Post Orders Print',
        //                         FRA = 'TPL imprimer Commande vente';
        //         }
        //         field("Batch PostOrders Status Filter"; "Batch PostOrders Status Filter")
        //         {
        //             AssistEdit = false;
        //         }
        //         field("Batch PO Shipment Statusfilter"; "Batch PO Shipment Statusfilter")
        //         {
        //             AssistEdit = false;
        //         }
        //     }
        //     group("Sponsoring & Donnation")
        //     {
        //         Caption = 'Sponsoring & Donnation';
        //         Description = 'DITW18.00.06 MSF 21/09/2015 DIT-770 #1261';
        //         field("New Document Per Shipment Date"; "New Document Per Shipment Date")
        //         {
        //         }
        //         field("New Document For Event Returns"; "New Document For Event Returns")
        //         {
        //         }
        //         field("Block Events In Process"; "Block Events In Process")
        //         {
        //         }
        //         field("Excl. Loan Credit Warnings"; "Excl. Loan Credit Warnings")
        //         {
        //         }
        //     }
        // }  // BC Upgrade NANDIS03
        // addafter("Std. Customer Sales Codes")
        // {
        //     group(TeleSales)
        //     {
        //         CaptionML = ENU = 'TeleSales',
        //                 FRA = 'TËÇÜlËÇÜvente';
        //         field("Sales History Calculation"; rec."Sales History Calculation")
        //         {
        //             Description = 'DITW15.00.00.39 RBE 26/04/2011 #1230';
        //         }
        //         field("Copy Comments Cust. to Sell-to"; rec."Copy Comments Cust. to Sell-to")
        //         {
        //             Description = 'DITW15.00.00.39 RBE 26/04/2011 #1230';
        //         }
        //         field("Min. Volume Warning"; rec."Min. Volume Warning")
        //         {
        //         }
        //         field("Min. Weight Warning"; rec."Min. Weight Warning")
        //         {
        //         }
        //         field("Min. Equivalent UOM"; rec."Min. Equivalent UOM")
        //         {
        //         }
        //         field("Min. Eq. UOM Quantity Warning"; rec."Min. Eq. UOM Quantity Warning")
        //         {
        //         }
        //         field("Min. HL Volume Warning"; rec."Min. HL Volume Warning")
        //         {
        //         }
        //         field("Max. Volume Warning"; rec."Max. Volume Warning")
        //         {
        //         }
        //         field("Max. Weight Warning"; rec."Max. Weight Warning")
        //         {
        //         }
        //         field("Order Alert Warning"; rec."Order Alert Warning")
        //         {
        //         }
        //         field("Shipment Date Alert Filter"; rec."Shipment Date Alert Filter")
        //         {
        //         }
        //         field("Shipment Status Alert Filter"; rec."Shipment Status Alert Filter")
        //         {
        //         }
        //     }  // BC Upgrade NANDIS03
        // }

        addafter("Notify On Success")
        {
            field("OTC Billing Automate JQ UserID"; Rec."OTC Billing Auto JQ UserID FND")
            {
                Editable = Rec."Job Queue Category Code" <> '';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the OTC Billing Automate JQ UserID field.';
            }
        }
        // addafter("Background Posting")
        // {
        //     group("Customer Sales conditions")
        //     {
        //         CaptionML = ENU = 'Customer Sales conditions',
        //                     FRA = 'Conditions de vente client';
        //         // field("Sales Cond. Type 1"; "Sales Cond. Type 1")
        //         // {
        //         // }
        //         // field("Sales Cond. No 1"; "Sales Cond. No 1")
        //         // {
        //         // }
        //         // field("Sales Cond. Type 2"; "Sales Cond. Type 2")
        //         // {
        //         // }
        //         // field("Sales Cond. No 2"; "Sales Cond. No 2")
        //         // {
        //         // }
        //         // field("Sales Cond. Type 3"; "Sales Cond. Type 3")
        //         // {
        //         // }
        //         // field("Sales Cond. No 3"; "Sales Cond. No 3")
        //         // {
        //         // }
        //         // field("Sales Cond. Type 4"; "Sales Cond. Type 4")
        //         // {
        //         // }
        //         // field("Sales Cond. No 4"; "Sales Cond. No 4")
        //         // {
        //         // }  // BC Upgrade NANDIS03
        //     }
        // }
        // group(Application)
        // {
        //     CaptionML = ENU = 'Application',
        //                 FRA = 'Lettrage';
        //     Description = 'FINXL7.00.001';
        //     field("Block Invoicing From Orders"; "Block Invoicing From Orders")
        //     {
        //         Description = 'FINXL7.00.001';
        //     }
        //     field("Show Posted Document No."; "Show Posted Document No.")
        //     {
        //         Description = 'FINXL7.00.001';
        //     }
        //     field("Keep Orders After Posting"; "Keep Orders After Posting")
        //     {
        //         Description = 'FINXL7.00.001';
        //     }
        //     field("Sales prices mandatory"; "Sales prices mandatory")
        //     {
        //         Description = 'FINXL7.00.001 - NRQ#9710';
        //     }
        //     field("No Invoicing Without SO Match"; "No Invoicing Without SO Match")
        //     {
        //         Description = 'FINXL7.00.001';
        //     }
        //     field("Use OGM"; "Use OGM")
        //     {
        //         Description = 'FINXL7.00.001';
        //     }
        //     field("Print OGM"; "Print OGM")
        //     {
        //         Description = 'FINXL7.00.001';
        //     }
        //     field("Show Jnl. Template Selection"; "Show Jnl. Template Selection")
        //     {
        //         Description = 'FINXL7.00.001';
        //     }
        //     field("Print Method"; "Print Method")
        //     {
        //     }
        //     field("Customer Auto Dimension Code"; "Customer Auto Dimension Code")
        //     {
        //     }
        // }  // BC Upgrade NANDIS03
        addafter("Background Posting")
        {
            group("RPM Damage or Loss")
            {
                Caption = 'RPM';
                Description = 'HEI.04';
                field("RPM Damage/Loss Jnl. Templ"; Rec."RPM Damage/Loss Jnl. Templ FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RPM Damage or Loss Jnl. Template Name field.';
                }
                field("RPM Damage/Loss Jnl. Batch"; Rec."RPM Damage/Loss Jnl. Batch FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RPM Damage or Loss Jnl. Batch Name field.';
                }
                field("RPM Loss G/L Account"; Rec."RPM Loss G/L Account FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RPM Loss G/L Account field.';
                }
                field("RPM Related Item Category Code"; Rec."RPMRelatedItemCategoryCode FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RPM Related Item Category Code field.';
                    trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03 - Added var as Text
                    begin
                        //HEI.06>>
                        CLEAR(ItemCategories);
                        ItemCategories.LOOKUPMODE(true);
                        if not (ItemCategories.RUNMODAL() = ACTION::LookupOK) then
                            exit(false);

                        Text := ItemCategories.GetSelectionFilter();
                        exit(true);
                        //HEI.06<<
                    end;
                }
                field("Product  Related Item Cat Code"; Rec."Product RelatedItemCatCode FND")
                {

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product  Related Item Cat Code field.';
                    trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03 - Added var as Text
                    begin
                        //HEI.06>>
                        CLEAR(ItemCategories);
                        ItemCategories.LOOKUPMODE(true);
                        if not (ItemCategories.RUNMODAL() = ACTION::LookupOK) then
                            exit(false);

                        Text := ItemCategories.GetSelectionFilter();
                        exit(true);
                        //HEI.06<<
                    end;
                }
                field("Allow Blank RPM Solution"; Rec."Allow Blank RPM Solution FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allow Blank RPM Solution Change field.';
                }
                field("RPM Chipped comp.%"; Rec."RPM Chipped comp.% FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RPM Chipped comp.% field.';
                }
                field("RPM Chipped comp. Res.no."; Rec."RPM Chipped comp. Res.no. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RPM Chipped comp. Res.no. field.';
                }
            }
        }
        addafter("RPM Damage or Loss")
        {
            group("Order Release Checks")
            {
                Caption = 'Order Release Checks';
                group(Credit)
                {
                    Caption = 'Credit';
                    field("Check Credit Limit on Release"; Rec."Check Credit Limit Release FND")
                    {

                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Check Credit Limit on Release field.';
                        trigger OnValidate();
                        begin
                            //HEI.05>>
                            if xRec."Check Credit Limit Release FND" <> Rec."Check Credit Limit Release FND" then
                                CheckCreditLimitOnReleaseEnabled := Rec."Check Credit Limit Release FND";
                            //HEI.05<<
                        end;
                    }
                    field("Check only SO getting Released"; Rec."Check only SO get Released FND")
                    {
                        Editable = CheckCreditLimitOnReleaseEnabled;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Check only SO getting Released field.';
                    }
                    field("Exclude Deposit"; Rec."Exclude Deposit FND")
                    {
                        Editable = CheckCreditLimitOnReleaseEnabled;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Exclude Deposit field.';
                    }
                    field("Excl Fin Contract Entries"; Rec."Excl Fin Contract Entries FND")
                    {
                        Editable = CheckCreditLimitOnReleaseEnabled;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Exclude Financial Contract Entries field.';
                    }
                    field("Exclude Released Sales Orders"; Rec."Exclude Release Sales Ord. FND")
                    {
                        Editable = CheckCreditLimitOnReleaseEnabled;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Exclude Released Sales Orders field.';
                    }
                    field("Exclude Finance Charge Memo"; Rec."Exclude Fin. Charge Memo FND")
                    {
                        Editable = CheckCreditLimitOnReleaseEnabled;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Exclude Finance Charge Memo field.';
                    }
                    field("Exclude Reminders"; Rec."Exclude Reminders FND")
                    {
                        Editable = CheckCreditLimitOnReleaseEnabled;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Exclude Reminders field.';
                    }
                    field("Exclude Sales Invoices"; Rec."Exclude Sales Invoices FND")
                    {
                        Editable = CheckCreditLimitOnReleaseEnabled;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Exclude Sales Invoices field.';
                    }
                    field("Exclude Sales Credit Memos"; Rec."Exclude Sales Credit Memos FND")
                    {
                        Editable = CheckCreditLimitOnReleaseEnabled;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Exclude Sales Credit Memos field.';
                    }
                    field("Exclude Sales Return Orders"; Rec."Exclude Sales Return Ord. FND")
                    {
                        Editable = CheckCreditLimitOnReleaseEnabled;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Exclude Sales Return Orders field.';
                    }
                    field("Excl Sales Shipment not Inv"; Rec."Excl Sales Ship. not Inv FND")
                    {
                        Editable = CheckCreditLimitOnReleaseEnabled;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Exclude Sales Shipments not Inv field.';
                    }
                    field("Excl Sales Ret Receipt not Inv"; Rec."Excl Sales Ret Rcpt notInv FND")
                    {
                        Editable = CheckCreditLimitOnReleaseEnabled;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Exclude Sales Return Receipts not Inv field.';
                    }
                }
                group(Overdue)
                {
                    Caption = 'Overdue';
                    field("Check Overdue Amts on Release"; Rec."Check Overdue Amts Release FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Check Overdue Amounts on Release field.';
                        trigger OnValidate();
                        begin
                            //HEI.05>>
                            if xRec."Check Overdue Amts Release FND" <> Rec."Check Overdue Amts Release FND" then
                                CheckOverdueAmtsOnReleaseEnabled := Rec."Check Overdue Amts Release FND";
                            //HEI.05<<
                        end;
                    }
                    field("Exclude Overdue Deposit"; Rec."Exclude Overdue Deposit FND")
                    {
                        Editable = CheckOverdueAmtsOnReleaseEnabled;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Exclude Deposit field.';
                    }
                    field("Excl Overdue Fin Contr Entries"; Rec."ExclOverdueFinContrEntries FND")
                    {
                        Editable = CheckOverdueAmtsOnReleaseEnabled;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Exclude Financial Contract Entries field.';
                    }
                    field("Excl Overdue Fin Charge Memo"; Rec."Excl Overdue FinChargeMemo FND")
                    {
                        Editable = CheckOverdueAmtsOnReleaseEnabled;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Exclude Finance Charge Memo field.';
                    }
                    field("Exclude Overdue Reminders"; Rec."Exclude Overdue Reminders FND")
                    {
                        Editable = CheckOverdueAmtsOnReleaseEnabled;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Exclude Reminders field.';
                    }
                }
            }
        }
        addafter("Order Release Checks")
        {

            group(Taxes)
            {
                Caption = 'Taxes';
                Description = 'HEI.26';
                field("Timbre Electronique"; Rec."Timbre Electronique FND")
                {
                    Description = 'HEI.26';
                    ToolTip = 'Enable the Timbre functionalitites';
                    ApplicationArea = All;
                }
                field("Timbre Resource Code"; Rec."Timbre Resource Code FND")
                {
                    ApplicationArea = All;
                    Description = 'HEI.26';
                    ToolTip = 'Indicate the Resource code to be used for Timbre. It will have a specific Product Posting Group to be able to differentiate from other entries to the same G/L account used for Timbre';
                }
                field("Editable Timbre Docs."; Rec."Editable Timbre Docs. FND")
                {
                    ApplicationArea = All;
                    Caption = 'Editable Timbre in the Documents';
                    Description = 'HEI.26';
                    ToolTip = 'Allow, or not, to edit/delete the Resource line created on the document';
                }
            }
        }
        addafter(Taxes)
        {
            group(Reports)
            {
                field("Cust. Stmt. Acc. Group Filter"; Rec."Cust Stmt. Acc Grp Filter FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Statement Account Group Filter field.';
                }
                field("Cust. Stmt. Report Date"; Rec."Cust. Stmt. Report Date FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Statement Report Date field.';
                }
                field("Cust. Stmt. Aging Interval"; Rec."Cust. Stmt. Aging Interval FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Statement Aging Interval field.';
                }
                field("Cust. Stmt. Base Calendar"; Rec."Cust. Stmt. Base Calendar FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Statement Base Calendar field.';
                }
                field("Cust. Stmt. Email Address"; Rec."Cust. Stmt. Email Address FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Statement Email Address field.';
                }
                field("Delete Cust. Email Log"; Rec."Delete Cust. Email Log FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Delete Cust. Email Log field.';
                }
                group("Pre-Email Notification")
                {
                    Caption = 'Pre-Email Notification to Customers for Invoice Due';
                    field("Prior Due Date Days"; Rec."Prior Due Date Days FND")
                    {
                        Description = 'HEI.29';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Prior Due Date Days for Customer field.';
                    }
                    field("Remaining Amount limit"; Rec."Remaining Amount limit FND")
                    {
                        Description = 'HEI.29';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Remaining Amount limit for Cust. Due notification field.';
                    }
                    part(Control55081; "CustomerStatementSetupListCBN")
                    {
                        caption = 'Customer Statement Setup List';
                        ApplicationArea = All;

                    }
                }
            }
        }
        addafter(Reports)
        {
            group(Autobilling)
            {
                Description = 'HEI.41';
                Caption = 'Autobilling';
                field("Enable OTC Billing Automation"; Rec."Enable OTC Billing Auto. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enable OTC Billing Automation field.';
                }
                field("Autobilling JQ Deletion Period"; Rec."Autobilling JQ Del. Period FND")
                {
                    //DateFormula = true;  // BC Upgrade NANDIS03
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Autobilling JQ Deletion Period field.';
                }
                field("Autobilling JQ Restart"; Rec."Autobilling JQ Restart FND")
                {
                    Description = 'HEI.41';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Autobilling JQ Restart field.';
                }
                field("Autobilling JQ Max No. Restart"; Rec."AutobillingJQMaxNo.Restart FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Autobilling JQ Max No. Restart field.';
                }
                field("Autobilling JQ Min. To Restart"; Rec."AutobillingJQMin.ToRestart FND")
                {
                    Description = 'HEI.41';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Autobilling JQ Min. To Restart field.';
                }
                field("Autobilling JQ Min. To Notify"; Rec."Autobilling JQMin.ToNotify FND")
                {
                    Description = 'HEI.41';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Autobilling JQ Min. To Notify field.';
                }
                field("Empties CM Rep. ID"; Rec."Empties CM Rep. ID FND")
                {
                    Description = 'HEI.44';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Empties CM Rep. ID field.';
                }
                field("Empties Inv. Rep. ID"; Rec."Empties Inv. Rep. ID FND")
                {
                    Description = 'HEI.44';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Empties Inv. Rep. ID field.';
                }



            }
        }
    }

    actions
    {
        modify("Customer Posting Groups")
        {
            CaptionML = ENU = 'Customer Posting Groups', FRA = 'Groupes compta. client';
            ToolTipML = ENU = 'Set up the posting groups to select from when you set up customer cards to link business transactions made for the customer with the appropriate account in the general ledger.', FRA = 'ParamËÇÜtrez les groupes comptabilisation parmi lesquels opËÇÜrer votre sËÇÜlection lorsque vous dËÇÜfinissez les fiches client pour lier les transactions commerciales effectuËÇÜes pour le client au compte gËÇÜnËÇÜral appropriËÇÜ.';
        }
        modify("Customer Price Groups")
        {
            CaptionML = ENU = 'Customer Price Groups', FRA = 'Groupes prix client';
            ToolTipML = ENU = 'Set up the posting groups to select from when you set up customer cards to link business transactions made for the customer with the appropriate account in the general ledger.', FRA = 'ParamËÇÜtrez les groupes comptabilisation parmi lesquels opËÇÜrer votre sËÇÜlection lorsque vous dËÇÜfinissez les fiches client pour lier les transactions commerciales effectuËÇÜes pour le client au compte gËÇÜnËÇÜral appropriËÇÜ.';
        }
        modify("Customer Disc. Groups")
        {
            CaptionML = ENU = 'Customer Disc. Groups', FRA = 'Groupes remises client';
            ToolTipML = ENU = 'Set up discount group codes that you can use as criteria when you define special discounts on a customer, vendor, or item card.', FRA = 'ParamËÇÜtrez des codes groupes remises que vous pouvez utiliser comme crit•áres lorsque vous dËÇÜfinissez des remises spËÇÜciales sur une fiche client, fournisseur ou article.';
        }
        modify(Payment)
        {
            CaptionML = ENU = 'Payment', FRA = 'Paiement';
        }
        modify("Payment Registration Setup")
        {
            CaptionML = ENU = 'Payment Registration Setup', FRA = 'ParamËÇÜtrage de l''enregistrement de paiement';
            ToolTipML = ENU = 'Set up the payment journal template and the balancing account that is used to post received customer payments. Define how you prefer to process customer payments in the Payment Registration window.', FRA = 'ParamËÇÜtrez le mod•ále feuille paiement et le compte de contrepartie qui est utilisËÇÜ pour valider les r•áglements client reËÇíus. DËÇÜfinissez votre prËÇÜfËÇÜrence quant au traitement des r•áglements client dans la fen›åtre Enregistrement de paiement.';
        }
        modify("Payment Methods")
        {
            CaptionML = ENU = 'Payment Methods', FRA = 'Modes de r•áglement';
            ToolTipML = ENU = 'Set up the payment methods that you select from the customer card to define how the customer must pay, for example by bank transfer.', FRA = 'ParamËÇÜtrez les modes de paiement parmi lesquels opËÇÜrer votre sËÇÜlection sur la fiche client pour dËÇÜfinir le moyen de paiement du client, par exemple le virement bancaire.';
        }
        modify("Payment Terms")
        {
            CaptionML = ENU = 'Payment Terms', FRA = 'Conditions de paiement';
            ToolTipML = ENU = 'Set up the payment terms that you select from on customer cards to define when the customer must pay, such as within 14 days.', FRA = 'ParamËÇÜtrez les modalitËÇÜs de paiement parmi lesquelles opËÇÜrer votre sËÇÜlection sur les fiches client pour dËÇÜfinir le moment oËÇö le client doit payer, par exemple dans les 14“jours.';
        }
        modify("Finance Charge Terms")
        {
            CaptionML = ENU = 'Finance Charge Terms', FRA = 'Conditions intËÇÜr›åts de retard';
            ToolTipML = ENU = 'Set up the finance charge terms that you select from on customer cards to define how to calculate interest in case the customer''s payment is late.', FRA = 'ParamËÇÜtrez les conditions intËÇÜr›åts de retard parmi lesquelles opËÇÜrer votre sËÇÜlection sur les fiches client pour dËÇÜfinir le mode de calcul des intËÇÜr›åts en cas de retard de paiement de la part du client.';
        }
        modify("Reminder Terms")
        {
            CaptionML = ENU = 'Reminder Terms', FRA = 'Conditions de relance';
            ToolTipML = ENU = 'Set up reminder terms that you select from on customer cards to define when and how to remind the customer of late payments.', FRA = 'ParamËÇÜtrez les modalitËÇÜs de relance parmi lesquelles opËÇÜrer votre sËÇÜlection sur les fiches client pour dËÇÜfinir le moment et la mani•áre de rappeler au client qu''il est en retard dans ses r•áglements.';
        }
        modify("Rounding Methods")
        {
            CaptionML = ENU = 'Rounding Methods', FRA = 'Modes arrondi';
            ToolTipML = ENU = 'Define how amounts are rounded when you use functions to adjust or suggest item prices or standard costs.', FRA = 'DËÇÜfinissez la mËÇÜthode d''arrondi des montants lorsque vous utilisez les fonctions permettant d''ajuster ou de suggËÇÜrer des prix article ou des coËÇôts standard.';
        }
    }

    var
        GeneralLedgerSetup: Record "General Ledger Setup";

    var

        ItemCategory: Record "Item Category";
        ItemCategories: Page "Item Categories";
        CheckCreditLimitOnReleaseEnabled: Boolean;
        CheckOverdueAmtsOnReleaseEnabled: Boolean;

        "Credit MemosEnable": Boolean;
        EnableCAD: Boolean;

        InvoicesEnable: Boolean;

        OrdersEnable: Boolean;
        QuotesEnable: Boolean;
        Text19007050: TextConst ENU = 'Activate Window for:', FRA = 'Activer fen›åtre pour:';


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW16.00.00.37 DIT-715 #1
    "Credit MemosEnable" := true;
    InvoicesEnable := true;
    OrdersEnable := true;
    QuotesEnable := true;
    // >>DITW16.00.00.37 DIT-715 #1
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger (Variable: GeneralLedgerSetup)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RESET;
    IF NOT GET THEN BEGIN
      INIT;
      INSERT;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RESET;
    if not GET then begin
      INIT;
      INSERT;
    end;
    // <<DITW15.00.00.39 DDR 27/04/2011 #1323 (BE5.00.01)
    UpdateForm;
    // >>DITW15.00.00.39 DDR #1323 (BE5.00.01)
    */
    //end;

    procedure UpdateForm();
    begin
        // <<DITW15.00.00.39 DDR 27/04/2011 #1323 (BE5.00.01)
        // QuotesEnable := "Insert Std. Cust. Sales Lines" <> "Insert Std. Cust. Sales Lines"::Manual;
        // OrdersEnable := "Insert Std. Cust. Sales Lines" <> "Insert Std. Cust. Sales Lines"::Manual;
        // InvoicesEnable := "Insert Std. Cust. Sales Lines" <> "Insert Std. Cust. Sales Lines"::Manual;
        // "Credit MemosEnable" := "Insert Std. Cust. Sales Lines" <> "Insert Std. Cust. Sales Lines"::Manual;  // BC Upgrade NANDIS03

        //HEI.05>>
        CheckCreditLimitOnReleaseEnabled := Rec."Check Credit Limit Release FND";
        CheckOverdueAmtsOnReleaseEnabled := Rec."Check Overdue Amts Release FND";
        //HEI.05<<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

