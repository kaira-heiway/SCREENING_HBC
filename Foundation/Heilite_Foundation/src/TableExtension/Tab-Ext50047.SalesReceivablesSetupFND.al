tableextension 50047 SalesandReceivablesSetupExtFND extends "Sales & Receivables Setup"
{
    // version NAVW113.04,FINXL10.01-11.00T,DITW113.00.15,HEI.46

    // DITW15.00.00.01 DDR 19/03/2008 Added field
    //                                  2013618 Deposit Warning
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.24 DDR 25/09/2008 Drink-It functionnalities
    //                                 Added fields
    //                                  2013721 Duty Point (option)
    // DITW15.00.00.25 DDR 20/10/2008 Remove comma in Optionstring for field "Duty point
    // DITW15.00.00.26 DDR 28/10/2008 Added fields
    //                                  2013802 Max. Order Discount % Allowed
    // DITW15.00.00.31 DDR 18/02/2009 Added fields
    //                                  2014443 Allow Reverse Document Amount
    //                                Added default value property InitValue = 100 for field "Max. Order Discount % Allowed"
    // DITW15.00.00.32 DDR 12/03/2009 Removed unused space into property Optionstring(ML) field "Duty Point"
    //                                Added fields
    //                                  2014447 Show Posting Warnings
    // DITW15.00.00.33 DDR 08/05/2009 Added fields
    //                                  2013755 DTax per Group Mandatory
    // DITW15.00.00.34 DDR 16/06/2009 Added fields
    //                                  2013628 Empty Goods Item No. Mandatory
    //                                  2014451 Auto.Release Document on Whse.
    // DITW15.00.00.37 DDR 28/01/2010 issue 879 Added fields
    //                                  2034925 Bill-to/Sell-to Building Dim.
    //                     27/05/2010 issue 1121 Added security field "Shipment on Invoice" when field "Duty Point" Shipment
    //                                           Added text constants Text2013660
    //                     02/06/2010 issue 1121 Added security field "Return Receipt on Credit Memo" when field "Duty Point" shipment
    //                     09/06/2010 issue 1028 Added fields
    //                                  2014455 Cr. Warning Incl. Delayed Disc
    // DITW15.00.00.39 DDR 27/04/2011 issue 1323 NAVBE5.00 (SP1) functionnality to insert Customer Std. Sales Codes automatically
    //                                  Added fields
    //                                    2014496 Insert Std. Cust. Sales Lines (see BE5.00 field 11313)
    //                                    2014497 Quotes
    //                                    2014498 Orders
    //                                    2014499 Invoices
    //                                    2014500 Credit Memos
    // DITW15.00.00.39 RBE 27/04/2011 issue 1230 Telesales functionnalities
    //                                  Added fields
    //                                    2013917 Sales History Calculation
    //                 DDR 27/04/2011   Added fields
    //                                    2013921 Copy Comments Cust. to Sell-to
    //                     05/08/2011 issue 1230 Renamed caption field2013921 Copy Comments Cust. to Sell-to
    //                     19/08/2011 issue 1363 Added fields
    //                                    2013732 Default Tax Date
    //                     29/08/2011 issue 1396 Item Exclusivity functionnality
    //                                  Added fields
    //                                    2014424 Item Exclusivity Warning
    //                     11/10/2011 issue 1396
    //                                  Added fields
    //                                    2014425 Exclusivity Group Manadatory
    //                     28/10/2011 issue 1457 Modified many ML captions
    // DITW16.00.00.40 DDR 18/04/2012 DIT-715 #243 Loyalty functionnality
    //                                  Added fields
    //                                    2014510 Loyalty Warnings
    //                     18/06/2012 DIT-715 #243
    //                                  Added fields
    //                                    2014520 Enforce Loyalty on Free Item
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
    //                                  Added fields
    //                                    2013635 Excl. Deposit Gen.Credit Limit
    //                     07/12/2012 DIT-715 #370
    //                                    2013636 Allow Split Deposit per
    //                     12/12/2012 DIT-715 #520 Added fields
    //                                               2014429 Bill-to/Sell-to Prices Calc.
    //                     13/12/2012 DIT-715 #521 Added fields
    //                                 2014419 Prices priority Method
    //                                 2014420 Discounts priority Method
    //                     13/12/2012 DIT-715 #522 Added fields
    //                                 2014504 Bill-to/Sell-to Dimensions
    //                     02/01/2013 DIT-715 #529 Added fields
    //                                 2014505 Bill-to/Sell-to Salespers./P.
    //                     26/04/2013 DIT-715 #551 Added fields
    //                                 2014521 Calculate Loyalty Balance
    // DITW16.00.00.43 DDR 14/05/2013 DIT-715 #605 Added fields
    //                                               2014506 Sales Price Mandatory
    //                     24/05/2013 DIT-715 #497 Removed field 2014425 Exclusivity Group Mandatory
    //                     14/08/2013 DIT-715 #678 Added fields
    //                                               2013610 Excl. Deposit Payment Discount

    // FINXL7.00.001 RBE 20/03/2013: added setup fields
    //                               Created fields 2029610..2029618
    // FINXL8.00.001 BSA 12/06/2015 #67: Created fields : "Print Method"

    // DITW17.00.02 DDR 28/05/2013 DIT-715 #497 merge
    // DDR 19/08/2013 DIT-715 #678 merge
    // DITW17.00.02 AT  04/09/2013 DIT-770 #136 merge WHN-001 HIT0088
    //                             Add field 2014430 "Sales Conditions Based on" (Option)
    // DITW17.00.02 AT  09/09/2013 DIT-770 #145 merge WHN-001 HIT0016
    //                             Created field 50000 "Return reason code mandatory"
    // DITW17.00.02 SR 10/25/2013 DIT-770 #159 : New Field "2014061,2014062" Added
    // DITW17.00.02 SR 08/01/2014 DIT-770 #189 : New Field "2013910 to 2013912" Added
    // DITW17.00.03 DDR 13/02/2014 DIT-770 #389 Sales Conditions Report
    //                                          Added fields for customer sales conditions
    // DITW17.10.03 MSF 18/04/2014 DIT-770 #354 : Min. HL Volume and Min. UOM warning in order intake - PART2
    //                                            Rename "Min. Volume" into "Min. Volume (Cubage)"
    //                                            Added Caption class for Field "Minimum Eq. UOM Quantity"
    //                                            Added Function fctGetUomCaptionClasstelesales
    // DITW17.10.03 MSF 12/05/2014 DIT-770 #354 : Rename the 3 captions in S&R setup: add 'Warning' (min. volume cubage warning).
    //                  16/06/2014 DIT-770 #354 : Move "Min. Equivalent UOM" From "telesales setup" to  "Sales & Receivable Setup"
    //                                            Added Field 2013914 "Min. Equivalent UOM"
    // DITW17.10.03 DDR 17/06/2014 DIT-770 #392 Item Quota Management functionality
    //                                          Added field 2014425 Item Quota Warning
    // DITW17.10.03 MSF 17/06/2014 DIT-770 #617  Autofill end date in Sales and purchase prices.
    //                                           Added field 2034926 "Autofill End Date"
    // DITW17.10.03 DDR 04/07/2014 DIT-770 #768 Added field 2014418 Prices & Discount Find Method"
    // DITW17.10.03 DDR 04/07/2013 DIT-770 #699 Added fields
    //                                            2013760 Enforce Free Reason on Free
    //                                            2013761 Default Qty. Delayed Discount (later)
    //                                            2013762 Default Qty. Delayed Promotion
    // DITW17.10.03 DDR 10/07/2014 DIT-770 #768 Remove field 2014418 Prices & Discount Find Method"
    //                                          Added option 'FirstTypeFilter' field2014419
    // DITW17.10.05 WSA 04/08/14 DIT-770 #761 : Added field "Invoice List Document Nos."
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05 DDR 12/08/2014 DIT-770 #768 Removed option 'FirstTypeFilter' field2014419
    // DITW17.10.05 DDR 19/08/2014 DIT-770 #776 Added Deposit point functionality
    //                                          Added field 2013611 Deposit Point
    // DITW17.10.05 YHE 02/09/2014 DIT-770 #754 : Add fields 2014410, 2014411, 2014412
    // DITW17.10.05 YHE 22/10/2014 : Reserve fields ID.2013915, ID.2013916 for  DIT-770 #960
    // DITW17.10.05 WSA 10/11/2014 DIT-770 #779 : Added field "Event Doc. Nos"
    // DITW17.10.05 WSA 05/12/2014 DIT-770 #185 : Added field "Automatic Loyalty Exchange"
    // DITW17.10.05 WSA 15/12/2014 DIT-770 #185 : Added Field "Loyalty on Bill-to/Sell-to"
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW17.10.05 DDR 06/03/2015 DIT-770 #768 Bugfix merge error optionstring field2014419 Prices Priority Method
    // DITW18.00.06 MSF 26/06/2015 DIT-770 #1347 Added fields
    //                                                       2035390  "Order Pick Ship Filter Till"
    //                                                       2035391  "Combined Pick Ship Filter Till"
    //                                                       2035392  "Order Shpt Ship Filter Till"
    //                                                       2035393  "Comb Shpt Ship Filter Till"
    //                                                       2035394  "Batch PostOrders Print"
    //                                                       2035395  "Batch PostOrders Status Filter"
    //                                                       2035396  "Batch PO Shipment Statusfilter"
    // DITW18.00.06 MSF 21/09/2015 DIT-770 #1261 Added field 2014361  "New Document Per Shipment Date"
    //                                                       2014362  "New Document For Event Returns"
    //                                                       2014363  "Block Events In Process"
    //                                                       2014364  "Invoicing Method"
    //                                                       2014365  "Invoice Period"
    // DITW18.00.06 MSF 02/10/2015 DIT-770 #1604 Added Field 2014107 "Default Route"
    // DITW18.00.06 MVN 15/10/2015 DIT-770 #1507 Added Fields (Copied from T.2013919)
    //                                                 2014063 Returns Item Category Filter
    //                                                 2014064 Returns Item Filter
    // DITW18.00.07 AKH 16/03/2016 DIT-770 #960 Added new fields 2014413 "Max. Volume Warning"
    //                                                           2014414 "Max. Weight Warning"
    // DITW18.00.07 MVN 18/03/2016 DIT-770 #1759 Changed Option String for Field 2014510 "Loyalty Warnings": No Warning,Point Limit,Cost Limit,Both Warnings
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #960 Renumbered fields 2013915 "Max. Volume Warning"
    //                                                            2013916 "Max. Weight Warning"
    // DITW18.00.07 AKH 23/03/2016 DIT-770 #960 Added new field   2013918 "Min. Weight Warning"
    // DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    //                                           Move fields to table2014085 Route Planning Setup
    //                                             2014061 Pickup Ship. Methode Code
    //                                             2035390 Order Pick Ship Filter Till
    //                                             2035391 Combined Pick Ship Filter Till
    //                                             2035392 Order Shpt Ship Filter Till
    //                                             2035393 Comb Shpt Ship Filter Till
    //                                           Delete field2014062 ChangeRoutePlanning Until
    //                                           Rename function fctGetUomCaptionClasstelesales -> GetUomCaptionClassEqUom
    //                                           Rename function GetUnitOfMeasureCaptionClass -> GetUnitOfMeasureCaptionClassEqUom
    // DITW18.00.07 DDR 14/04/2016 DIT-770 #1402 Added fields
    //                                             2014431 Recalculate Line Prices
    //                                             2014448 Show Reopen Warnings
    // DITW18.00.07 DDR 19/04/2016 DIT-770 #1488 Added fields
    //                                             2014108 Route Mandatory
    //                                           Modified name/caption fields 2013910,2013911,2013912
    //                                           Added 'CaptionClass' property field 2013911
    //                                           Added function GetUomCaptionClassHL()
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Field "Late Order Warning"
    // DITW19.00.08 AKH 05/10/2016 BL#10806 (DIT-770 #1800) Added new field 2014413 "Show Warning ShptDate-Workdate"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 03/03/2017 NRQ#0 Changed caption field2034926
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Added new field "Close Lines at Shipment Status"
    // DITW110.00.10 MSF 27/06/2017 NRQ#13550 Return registration and control
    //                              Delete "Fields Returns Item Category Filter"
    //                                     "Returns Item Filter"
    // DITW110.00.10 MSF 18/07/2017 NRQ#16224
    //                                  2014109"Post Linked Return Order"
    // FINXL10.01 AKH 19/07/2017 NRQ#33089 Added new field 2029620 "Customer Auto Dimension Code"
    // FINXL10.01 OFE 30/08/2017 NRQ#10433: Changed field name 2029615"Do Not Allow Zero Price" => "Sales price mandatory"
    // DITW110.00.11 MSF 07/11/2017 NRQ#13577 Autoblock Customer, Item, Vendor card based on setup
    //                                       Added Fields Autoblock Customer On Changes
    //                                                    Autoblock Cust. On  Dimension
    //                                                    Autoblock Cust. On BankAccount
    // DITW110.00.11 VSC 09/10/2017 NRQ#33755 Removed field 2014066 "Close Lines at Shipment Status"
    // DITW110.00.11 VSC 27/11/2017 NRQ#33755 Added Field "Auto Proc. Backord. On Posting"
    // DITW110.00.12A MSF 26/06/2018 NRQ#74597 Order discount should calculate for all – not apply priority
    //                                         Added field  2013763 "Order Discount Priority Method"
    // DITW111.00.13 DDR 10/12/2018 NRQ#95409 Add field 2013764 "Order Promotion Priority Method"
    // DITW111.00.13 MSF 13/12/2018 NRQ#94671 Added field "Show Item Tracking Alter on SO"
    // DITW111.00.13 MSF 04/02/2019 NRQ#87409 Reopen and Release an already approved sales order
    //                                         Added Field "Automatic Document Approval"

    // HEI.01 FDD-PTPGAP002 IBM HORTOC01 19.08.2017
    //   # New field "Reason Code Block Customer"
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New fields for MDM integration
    // HEI.03 FDD-RTRGAP060 IBM HORTOC01 1.09.2017
    //   # New fields
    // HEI.04 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    //   # Added new fields: 50015 "RPM Damage/Loss Jnl. Templ",
    //                       50016 "RPM Damage/Loss Jnl. Batch",
    //                       50017 "RPM Loss G/L Account"
    // HEI.05 DefectId 746 IBM  HORTOC01 01.11.2017 # add new field "Know - How Fee %"
    // HEI.06 FDD-OTCGAP016C IBM NASTAA02 29.11.2017 # Credit Control Check
    //   # Added new fields: 50019 "Check Credit Limit on Release"
    //                       50020 "Check only SO getting Released"
    //                       50021 "Exclude Deposit"
    //                       50022 "Exclude Financial Contract Entries"
    //                       50023 "Exclude Released Sales Orders"
    //                       50024 "Exclude Finance Charge Memo"
    //                       50025 "Exclude Reminders"
    //                       50026 "Exclude Sales Invoices"
    //                       50027 "Exclude Sales Credit Memos"
    //                       50028 "Exclude Sales Return Orders"
    //                       50029 "Exclude Sales Shipments not Inv"
    //                       50030 "Exclude Sales Return Receipts not Inv"
    //                       50031 "Check Overdue Amts on Release"
    //                       50032 "Exclude Overdue Deposit"
    //                       50033 "Excl Overdue Fin Contr Entries"
    //                       50034 "Excl Overdue Fin Charge Memo"
    //                       50035 "Exclude Overdue Reminders"
    // HEI.09 FDD-SLSGAP015 IBM NASTAA02 24.04.2018 # Default Dimensions in the Promotion Charges
    //   # New Field created 50038 - "Free Reason Code Mandatory"
    // HEI.10 FDD-OTCGAP075 IBM NASTAA02 15.05.2018 # No dependency between respective credit risk Master Date fields in the system
    //   # New Fields created 50039 - "Default Risk Score"
    //                        50040 - "Default Risk Grade"
    // HEI.11 IBM HORTOC01 18.05.2018 - new field "Allow Blank RPM Solution"
    // HEI.13 RW-GAPLOG08 IBM LAZARE02 23.10.2018 # New field Activate CIS System for EBM interface
    // HEI.14 FDD RPM Breakages IBM ISYED01 03.06.19
    //   # Added new fields : RPM Chipped comp.%, RPM Chipped comp. Res.no
    // DITW111.00.13A MSF 02/05/2019 NRQ#103938 Renamed Caption Automatic Document Approval-->Automatic approval request by release
    // DITW111.00.13 MSF 04/02/2019 NRQ#87409 Reopen and Release an already approved sales order
    //                                        Added Field "Automatic Document Approval"
    // DITW111.00.13A MSF 02/05/2019 NRQ#103938 Renamed Caption Automatic Document Approval-->Automatic approval request by release
    // HEI.15 IBM MATHEJ01 13.08.19 - #CHG2023306 Update report Proforma Invoice
    //   # Added new field: 50045 - "Beer Density"
    // HEI.16 FDD-HB622 IBM NASTAA02 22.08.2019 # Customer ledger entries automatic application credit notes
    //   # New Field created: 50046 - Enable Auto App Sales Cr Memo
    // HEI.17 CHG2026335 HT653 FDD_La Reunion_EDI_EDI Order IBM GAVANM01 04.10.2019  #new field created:  50047 - EDI Nos.
    // HEI.18 FDD-HT914 IBM BULIMC01 09/10.2019 # new field added 50048 - "Amount Round. Precision Disc."
    // HEI.19 FDD-HT657 IBM NASTAA02 14.11.2019 # Ethiopia Intercompany Automation
    //   # New Fields created: 50052 - Special Order by Default
    // HEI.20 CHG2032964 IBM.LS      05.11.2019
    //   # New Field created: 50050 - Account Group for AIRSI
    // HEI.21 CHG2023313 IBM.AB 05.11.2019
    //   # Field Added 'Item Avlblty Message Enable' (ID: 50051)
    // HEI.22 CHG2026335 IBM GAVANM01 09.01.2020 # new field, 50053 - "Item availability"
    // HEI.23 CHG2035637 IBM.LS 14.01.2020
    //   # New Field created: 50054 - "Block Reason for New Customer"
    // DITW113.00.15 DDR 04/10/2019 NRQ#9775 Add field 2014511 Loyalty Priority Method
    // HEI.24 CHG2010375 IBM.LS 22.01.2020
    //   # New Field created: 50055 - "Enable OTC Billing Automation"
    // DITW110.00.12 MSF 27/04/2018 NRQ#10488 Loyalty Management ËÇô several issues
    // DITW113.00.15 DDR 09/10/2019 NRQ#122793 Rename/Renumber field 2014510 -> 2014512 Loyalty Point Warning + Optionstring
    //                                         Add field 2014513 Loyalty Amount Warning
    // HEI.25 CHG2010375 IBM.LS 17.02.2020
    //   # New Field created: 50056 - "Excl. Inv/CM for E-Mail/Print"
    // HEI.26 CHG2010375 IBM.LS 26.02.2020
    //   # Field Caption changed from "Excl. Inv/CM for E-Mail/Print" to "Doc. Subtype to exclude for auto Email/Print".
    // HEI.27 CHG2010375 IBM KUMARN15 29.04.2020
    //   # Added field "OTC Billing Automate JQ UserID"
    // HEI.28 CHG2060791 IBM Shankj03 28.05.2020
    //   # added field "Export Invoice"
    // HEI.29 FDD-HT1203 CHG2058079 IBM KUMARN15 03.06.2020
    //   # Added field 50059 Skip Custom Reminder Logic
    // HEI.30 CHG2070787 IBM GAVANM01 03.09.2020 - Update all Billing documents in line with Global (for the BAHAMAS)
    //   # Added field 50060 Customer Service E-Mail
    // HEI.31 CHG2096435 HT1805 IBM GAVANM01 12.02.2021 - Invoice Layout
    //   # Added field 50061 - Bank based on invoice currency
    // HEI.32 CHG2109621 HT2170 IBM GAVANM01 10.06.2021 - Posting Setup for Sales Tax (Timbre), transport, free products
    //   # Added fields: 50062 - Timbre Electronique
    //                   50063 - Timbre Resource Code
    //                   50064 - Editable Timbre Docs.
    // HEI.33 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Field created: 50065 - Mandatory Location on Header
    // HEI.34 HB2339 - CHG2109497 IBM NASTAA02 09.07.2021 # Customer Statements to be issued automatically at month end
    //   # New Fields created: 50066 - Cust. Stmt. Acc. Group Filter
    //                         50067 - Cust. Stmt. Report Date
    //                         50068 - Cust. Stmt. Aging Interval
    //                         50069 - Cust. Stmt. Base Calendar
    //                         50070 - Cust. Stmt. Email Address
    // HEI.35 HB2310 CHG2113088 IBM GAVANM01 16.07.2021 #Pre-Email Notification to Customers
    //   # New fields created: 50071 - Prior Due Date Days
    //                         50072 - Remaining Amount limit
    // HEI.36 HB2487 CHG2123592 IBM MAJUMS03 #Cash Application where 92% of Customer pay in advance
    //   # Added fields: 50073 - SO Mandatory For Cash Cust
    //                   50074 - Ref Value for Cash Customers
    // HEI.37 HB2935 CHG2156365 IBM GHOSHS05 #MTC_FIN_Autobilling Error log Deletion Functionality
    //   # New fields created: 50075 - "Autobilling JQ Deletion Period"
    // HEI.38 CHG2168337 HB2821 IBM BHANDS01 13.09.2022 OrderSync Astro WMS Integration
    //   # New field created - "Transportation Cost"
    // HEI.39 CHG2151260-HB2788 IBM SOICAD02 06.11.2022 New field Enable EBMS Interface
    // HEI.40 CHG2164305 IBM COSTES04 20.12.2022 - Primary_Secondary CCC Shipping Cost Allocation
    //   # New fields : Market Type Dim. Code , Market Type Domestic, Market Type Export
    // HEI.41 CHG2131424 IBM SISUM01 01/05/2023 HB2520 Dimension Validation HeiLite
    //   # New field ID 50080
    // HEI.42 CHG2236524 IBM SISUM01 24.02.2024 HB3724-Lareunion-Discard automatic sending of Logistics email
    //   # New field ID 50081
    // HEI.43 CHG2228480-HB3631 COSTES04 07.05.2024 Sierra Leone Automate the separation of deposit and finish product
    //   # New field Cust. Stmt. Report Date 2, Delete Cust. Email Log
    // HEI.44 CHG2236702 IBM COSTES04 26.06.2024 Column Data Availability of WH Shipment & WH Receipt No
    //   # New field Shipment Date Mandatory
    // HEI.45 CHG2228480-HB3631 COSTES04 02.08.2024 Sierra Leone Automate the separation of deposit and finish product
    //   # Remove Cust. Stmt. Report Date 2
    // HEI.46 CHG2260099 COSTES04 18.09.2024 Automatic Archiving of Gate Entry Outbound While Undoing Sales Shipment.
    //   # New field added Gate Entry Archived Required
    // HEI.47 IBM COSTES04 17.01.2025 CHG2279679-HB4118-Automatic restart of deadlock errors for auto billing
    //   # New fields added: "Autobilling JQ Restart",  "Autobilling JQ Min. To Restart", "Autobilling JQ Min. To Notify"
    // HEI.48 CHG2294105 IBM ADHIKG01 15.04.2025 Addition column in delivery note for missing crate, low fills
    //   # New field added "Show Additional Column on DN"
    // HEI.50 IBM COSTES04 27.06.2025 CHG2307645-HB4324-Emailing invoices for goods and empty goods
    //   # New fields: Empties CM Rep. ID, Empties Inv. Rep. ID

    // BC Upgrade MISHRS14 >> Added HEI.48 and HEI.50 Tag for the documentation

    // BC Upgrade SHUKLP03 >> added document subtype code for field 50056.

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
        modify("Credit Warnings")
        {
            CaptionML = ENU = 'Credit Warnings', FRA = 'Alertes crédit';
            OptionCaptionML = ENU = 'Both Warnings,Credit Limit,Overdue Balance,No Warning', FRA = 'Toutes les alertes,Crédit autorisé,Solde échu,Aucune alerte';
        }
        modify("Stockout Warning")
        {

            //Unsupported feature: Change InitValue on ""Stockout Warning"(Field 5)". Please convert manually.

            CaptionML = ENU = 'Stockout Warning', FRA = 'Alerte rupture stock';
        }
        modify("Shipment on Invoice")
        {
            CaptionML = ENU = 'Shipment on Invoice', FRA = 'B.L sur facture';
        }
        modify("Invoice Rounding")
        {
            CaptionML = ENU = 'Invoice Rounding', FRA = 'Arrondi facture';
        }
        modify("Ext. Doc. No. Mandatory")
        {
            CaptionML = ENU = 'Ext. Doc. No. Mandatory', FRA = 'N° doc. ext. obligatoire';
        }
        modify("Customer Nos.")
        {
            CaptionML = ENU = 'Customer Nos.', FRA = 'N° client';
        }
        modify("Quote Nos.")
        {
            CaptionML = ENU = 'Quote Nos.', FRA = 'N° devis';
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
        modify("Posted Shipment Nos.")
        {
            CaptionML = ENU = 'Posted Shipment Nos.', FRA = 'N° expédition enregistrée';
        }
        modify("Reminder Nos.")
        {
            CaptionML = ENU = 'Reminder Nos.', FRA = 'N° relance';
        }
        modify("Issued Reminder Nos.")
        {
            CaptionML = ENU = 'Issued Reminder Nos.', FRA = 'N° relance émise';
        }
        modify("Fin. Chrg. Memo Nos.")
        {
            CaptionML = ENU = 'Fin. Chrg. Memo Nos.', FRA = 'N° facture d''intérêts';
        }
        modify("Issued Fin. Chrg. M. Nos.")
        {
            CaptionML = ENU = 'Issued Fin. Chrg. M. Nos.', FRA = 'N° fact. d''intérêts émise';
        }
        modify("Posted Prepmt. Inv. Nos.")
        {
            CaptionML = ENU = 'Posted Prepmt. Inv. Nos.', FRA = 'N° fact. acompte enreg.';
        }
        modify("Posted Prepmt. Cr. Memo Nos.")
        {
            CaptionML = ENU = 'Posted Prepmt. Cr. Memo Nos.', FRA = 'N° avoir acompte enreg.';
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

            //Unsupported feature: Change InitValue on ""Copy Comments Blanket to Order"(Field 26)". Please convert manually.

            CaptionML = ENU = 'Copy Comments Blanket to Order', FRA = 'Copier com. cde ouv. -> cde';
        }
        modify("Copy Comments Order to Invoice")
        {

            //Unsupported feature: Change InitValue on ""Copy Comments Order to Invoice"(Field 27)". Please convert manually.

            CaptionML = ENU = 'Copy Comments Order to Invoice', FRA = 'Copier com. cde -> facture';
        }
        modify("Copy Comments Order to Shpt.")
        {

            //Unsupported feature: Change InitValue on ""Copy Comments Order to Shpt."(Field 28)". Please convert manually.

            CaptionML = ENU = 'Copy Comments Order to Shpt.', FRA = 'Copier com. cde -> expédition';
        }
        modify("Allow VAT Difference")
        {
            CaptionML = ENU = 'Allow VAT Difference', FRA = 'Autoriser différence TVA';
        }
        modify("Calc. Inv. Disc. per VAT ID")
        {
            CaptionML = ENU = 'Calc. Inv. Disc. per VAT ID', FRA = 'Calc. remise fact. par ident. TVA';
        }
        modify("Logo Position on Documents")
        {
            CaptionML = ENU = 'Logo Position on Documents', FRA = 'Position du logo sur les documents';
            OptionCaptionML = ENU = 'No Logo,Left,Center,Right', FRA = 'Aucun logo,Gauche,Centre,Droite';
        }
        modify("Check Prepmt. when Posting")
        {
            CaptionML = ENU = 'Check Prepmt. when Posting', FRA = 'Vérifier acompte lors de la validation';
        }
        modify("Default Posting Date")
        {
            CaptionML = ENU = 'Default Posting Date', FRA = 'Date comptabilisation par défaut';
            // OptionCaptionML = ENU = 'Work Date,No Date', FRA = 'Date de travail,Aucune date';
        }
        modify("Default Quantity to Ship")
        {
            CaptionML = ENU = 'Default Quantity to Ship', FRA = 'Qté à expédier par défaut';
            OptionCaptionML = ENU = 'Remainder,Blank', FRA = 'Solde,Vide';
        }
        // BC Upgrade NANDIS03  Standard Fields Split in BC on ID 52 and ID 53>>
        // modify("Archive Quotes and Orders")
        // {
        //     CaptionML = ENU='Archive Quotes and Orders',FRA='Archiver devis et commandes';
        // }
        modify("Archive Quotes")
        {
            CaptionML = ENU = 'Archive Quotes', FRA = 'Archiver devis';
        }
        modify("Archive Orders")
        {
            CaptionML = ENU = 'Archive Orders', FRA = 'Archiver commandes';
        }
        // BC Upgrade NANDIS03 Standard Fields Split in BC on ID 52 and ID 53<<
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
            CaptionML = ENU = 'Job Q. Prio. for Post & Print', FRA = 'Priorité de la file d''attente des travaux pour validation et impression';
        }
        modify("Notify On Success")
        {
            CaptionML = ENU = 'Notify On Success', FRA = 'Notification si réussite';
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            CaptionML = ENU = 'VAT Bus. Posting Gr. (Price)', FRA = 'Gpe compta. marché TVA (prix)';
        }
        modify("Direct Debit Mandate Nos.")
        {
            CaptionML = ENU = 'Direct Debit Mandate Nos.', FRA = 'N° mandat de domiciliation européenne';
        }
        modify("Allow Document Deletion Before")
        {
            CaptionML = ENU = 'Allow Document Deletion Before', FRA = 'Autoriser suppr. doc. av.';
        }
        modify("Default Item Quantity")
        {
            CaptionML = ENU = 'Default Item Quantity', FRA = 'Quantité par défaut de l''article';
        }
        modify("Create Item from Description")
        {
            CaptionML = ENU = 'Create Item from Description', FRA = 'Créer une article à partir de la description';
        }
        modify("Posted Return Receipt Nos.")
        {
            CaptionML = ENU = 'Posted Return Receipt Nos.', FRA = 'N° réception retour enregistrée';
        }
        modify("Copy Cmts Ret.Ord. to Ret.Rcpt")
        {

            //Unsupported feature: Change InitValue on ""Copy Cmts Ret.Ord. to Ret.Rcpt"(Field 5801)". Please convert manually.

            CaptionML = ENU = 'Copy Cmts Ret.Ord. to Ret.Rcpt', FRA = 'Copier com. ret. -> réception retour';
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
        modify("Return Receipt on Credit Memo")
        {
            CaptionML = ENU = 'Return Receipt on Credit Memo', FRA = 'Réception retour sur avoir';
        }
        modify("Exact Cost Reversing Mandatory")
        {
            CaptionML = ENU = 'Exact Cost Reversing Mandatory', FRA = 'Coût retour identique obligatoire';
        }
        modify("Customer Group Dimension Code")
        {
            CaptionML = ENU = 'Customer Group Dimension Code', FRA = 'Code axe groupe clients';
        }
        modify("Salesperson Dimension Code")
        {
            CaptionML = ENU = 'Salesperson Dimension Code', FRA = 'Code axe vendeur';
        }
        modify("Freight G/L Acc. No.")
        {
            CaptionML = ENU = 'Freight G/L Acc. No.', FRA = 'N° cpte général transport';
        }

        //Unsupported feature: CodeInsertion on ""Shipment on Invoice"(Field 6)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.37 DDR 27/05/2010
        if not "Shipment on Invoice" and ("Duty Point" = "Duty Point"::"Posted Shipment") then
          FIELDERROR("Shipment on Invoice",STRSUBSTNO(Text2013660,FIELDCAPTION("Duty Point"),"Duty Point"));
        // >>DITW15.00.00.37 DDR
        // <<DITW17.10.05 DDR 19/08/2014 DIT-770 #776
        if not "Shipment on Invoice" and ("Deposit Point" = "Deposit Point"::"Posted Shipment") then
          FIELDERROR("Shipment on Invoice",STRSUBSTNO(Text2013660,FIELDCAPTION("Deposit Point"),"Deposit Point"));
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


        //Unsupported feature: CodeInsertion on ""Return Receipt on Credit Memo"(Field 6601)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.37 DDR 02/06/2010
        if not "Return Receipt on Credit Memo" and ("Duty Point" = "Duty Point"::"Posted Shipment") then
          FIELDERROR("Return Receipt on Credit Memo",STRSUBSTNO(Text2013660,FIELDCAPTION("Duty Point"),"Duty Point"));
        // >>DITW15.00.00.37 DDR
        // <<DITW17.10.05 DDR 19/08/2014 DIT-770 #776
        if not "Return Receipt on Credit Memo" and ("Deposit Point" = "Deposit Point"::"Posted Shipment") then
          FIELDERROR("Return Receipt on Credit Memo",STRSUBSTNO(Text2013660,FIELDCAPTION("Deposit Point"),"Deposit Point"));
        // >>DITW17.10.05 DDR DIT-770 #776
        */
        //end;


        //Unsupported feature: CodeModification on ""Freight G/L Acc. No."(Field 7103).OnValidate". Please convert manually.

        //trigger  No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Freight G/L Acc. No." <> '' THEN BEGIN
          GLAccount.GET("Freight G/L Acc. No.");
          GLAccount.CheckGLAcc;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Freight G/L Acc. No." <> '' then begin
          GLAccount.GET("Freight G/L Acc. No.");
          GLAccount.CheckGLAcc;
        end;
        */
        //end;
        field(50000; "Reason Code Block Customer FND"; Code[20])
        {
            Description = 'HEI.01';
            TableRelation = "Blocked Reason FND".Code;
            Caption = 'Reason Code Block Customer';
        }
        field(50001; "Print WHT on Credit Memo FND"; Boolean)
        {
            Caption = 'Print WHT on Credit Memo';
            Description = 'HEI.02';
        }
        field(50002; "Print Dialog FND"; Boolean)
        {
            Caption = 'Print Dialog';
            Description = 'HEI.02';
        }
        field(50003; "Return Order Mandatory FND"; Boolean)
        {
            Caption = 'Return Order Mandatory';
            Description = 'HEI.02';
        }
        field(50004; "Journal BatchName Forecast FND"; Code[10])
        {
            Caption = 'Sales Forecast Batch Name';
            Description = 'HEI.03';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = FIELD("Jnl Template Name Forecast FND"));
        }
        field(50005; "Jnl Template Name Forecast FND"; Code[10])
        {
            Caption = 'Sales Forecast Template Name';
            Description = 'HEI.03';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(50006; "Accrual Account Forecast FND"; Code[10])
        {
            Caption = 'Sales Forecast Accrual Acc.';
            Description = 'HEI.03';
            TableRelation = "G/L Account"."No.";
        }
        field(50007; "Royalty Account Forecast FND"; Code[10])
        {
            Caption = 'Sales Forecast Royalty Acc.';
            Description = 'HEI.03';
            TableRelation = "G/L Account"."No.";
        }
        field(50008; "Know-How Account Forecast FND"; Code[10])
        {
            Caption = 'Sales Forecast Know-How Acc.';
            Description = 'HEI.03';
            TableRelation = "G/L Account"."No.";
        }
        field(50015; "RPM Damage/Loss Jnl. Templ FND"; Code[10])
        {
            Caption = 'RPM Damage or Loss Jnl. Template Name';
            Description = 'HEI.04';
            TableRelation = "Gen. Journal Template".Name where(Type = FILTER(Assets));
        }
        field(50016; "RPM Damage/Loss Jnl. Batch FND"; Code[10])
        {
            Caption = 'RPM Damage or Loss Jnl. Batch Name';
            Description = 'HEI.04';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = FIELD("RPM Damage/Loss Jnl. Templ FND"));
        }
        field(50017; "RPM Loss G/L Account FND"; Code[20])
        {
            Caption = 'RPM Loss G/L Account';
            Description = 'HEI.04';
            TableRelation = "G/L Account"."No." where("Account Type" = FILTER(Posting),
                                                       "Direct Posting" = FILTER(true));
        }
        field(50018; "Know - How Fee % FND"; Decimal)
        {
            Caption = 'Know - How Fee %';
            Description = 'HEI.05';
        }
        field(50019; "Check Credit Limit Release FND"; Boolean)
        {
            Description = 'HEI.06';
            Caption = 'Check Credit Limit Release';

            trigger OnValidate();
            begin
                //HEI.06>>
                if (xRec."Check Credit Limit Release FND" <> "Check Credit Limit Release FND")
                   and not "Check Credit Limit Release FND"
                then begin
                    "Check only SO get Released FND" := false;
                    "Exclude Deposit FND" := false;
                    "Excl Fin Contract Entries FND" := false;
                    "Exclude Release Sales Ord. FND" := false;
                    "Exclude Fin. Charge Memo FND" := false;
                    "Exclude Reminders FND" := false;
                    "Exclude Sales Invoices FND" := false;
                    "Exclude Sales Credit Memos FND" := false;
                    "Exclude Sales Return Ord. FND" := false;
                    "Excl Sales Ship. not Inv FND" := false;
                    "Excl Sales Ret Rcpt notInv FND" := false;
                end;
                //HEI.06<<
            end;
        }
        field(50020; "Check only SO get Released FND"; Boolean)
        {
            Description = 'HEI.06';
            Caption = 'Check only Sales Orders get Released';
        }
        field(50021; "Exclude Deposit FND"; Boolean)
        {
            Description = 'HEI.06';
            Caption = 'Exclude Deposit';
        }
        field(50022; "Excl Fin Contract Entries FND"; Boolean)
        {
            Caption = 'Exclude Financial Contract Entries';
            Description = 'HEI.06';
        }
        field(50023; "Exclude Release Sales Ord. FND"; Boolean)
        {
            Description = 'HEI.06';
            Caption = 'Exclude Release Sales Orders';
        }
        field(50024; "Exclude Fin. Charge Memo FND"; Boolean)
        {
            Description = 'HEI.06';
            Caption = 'Exclude Finance Charge Memo';
        }
        field(50025; "Exclude Reminders FND"; Boolean)
        {
            Description = 'HEI.06';
            Caption = 'Exclude Reminders';
        }
        field(50026; "Exclude Sales Invoices FND"; Boolean)
        {
            Description = 'HEI.06';
            Caption = 'Exclude Sales Invoices';
        }
        field(50027; "Exclude Sales Credit Memos FND"; Boolean)
        {
            Description = 'HEI.06';
            Caption = 'Exclude Sales Credit Memos';
        }
        field(50028; "Exclude Sales Return Ord. FND"; Boolean)
        {
            Description = 'HEI.06';
            Caption = 'Exclude Sales Return Orders';
        }
        field(50029; "Excl Sales Ship. not Inv FND"; Boolean)
        {
            Caption = 'Exclude Sales Shipments not Inv';
            Description = 'HEI.06';
        }
        field(50030; "Excl Sales Ret Rcpt notInv FND"; Boolean)
        {
            Caption = 'Exclude Sales Return Receipts not Inv';
            Description = 'HEI.06';
        }
        field(50031; "Check Overdue Amts Release FND"; Boolean)
        {
            Caption = 'Check Overdue Amounts on Release';
            Description = 'HEI.06';

            trigger OnValidate();
            begin
                //HEI.06>>
                if (xRec."Check Overdue Amts Release FND" <> "Check Overdue Amts Release FND")
                   and not "Check Overdue Amts Release FND" then begin
                    "Check Overdue Amts Release FND" := false;
                    "Exclude Overdue Deposit FND" := false;
                    "Excl Overdue FinChargeMemo FND" := false;
                    "Excl Overdue FinChargeMemo FND" := false;
                    "Exclude Overdue Reminders FND" := false;
                end;
                //HEI.06<<
            end;
        }
        field(50032; "Exclude Overdue Deposit FND"; Boolean)
        {
            Caption = 'Exclude Deposit';
            Description = 'HEI.06';
        }
        field(50033; "ExclOverdueFinContrEntries FND"; Boolean)
        {
            Caption = 'Exclude Financial Contract Entries';
            Description = 'HEI.06';
        }
        field(50034; "Excl Overdue FinChargeMemo FND"; Boolean)
        {
            Caption = 'Exclude Finance Charge Memo';
            Description = 'HEI.06';
        }
        field(50035; "Exclude Overdue Reminders FND"; Boolean)
        {
            Caption = 'Exclude Reminders';
            Description = 'HEI.06';
        }
        field(50036; "RPMRelatedItemCategoryCode FND"; Text[250])
        {
            Caption = 'RPM Related Item Category Code';
            Description = 'HEI.08';

        }
        field(50037; "Product RelatedItemCatCode FND"; Text[250])
        {
            Caption = 'Product  Related Item Cat Code';
            Description = 'HEI.08';
        }
        field(50038; "Free Reason Code Mandatory FND"; Boolean)
        {
            Caption = 'Free Reason Code Mandatory';
            Description = 'HEI.09';
        }
        field(50039; "Default Risk Score FND"; Integer)
        {
            Caption = 'Default Risk Score';
            Description = 'HEI.10';
            TableRelation = "Risk Score FND";
        }
        field(50040; "Default Risk Grade FND"; Code[20])
        {
            Caption = 'Default Risk Grade';
            Description = 'HEI.10';
            TableRelation = "Risk Grade FND";
        }
        field(50041; "Allow Blank RPM Solution FND"; Boolean)
        {
            Caption = 'Allow Blank RPM Solution Change';
            Description = 'HEI.11';
        }
        field(50042; "Activate CIS System FND"; Boolean)
        {
            Caption = 'Activate CIS System';
            Description = 'HEI.13';
        }
        field(50043; "RPM Chipped comp.% FND"; Decimal)
        {
            Description = 'HEI.14';
            Caption = 'RPM Chipped Component Percentage';
        }
        field(50044; "RPM Chipped comp. Res.no. FND"; Code[10])
        {
            Description = 'HEI.14';
            Caption = 'RPM Chipped Component Resource No.';
            TableRelation = Resource."No.";
        }
        field(50045; "Beer Density FND"; Decimal)
        {
            Description = 'HEI.15';
            Caption = 'Beer Density';
        }
        field(50046; "Enable AutoAppSalesCr Memo FND"; Boolean)
        {
            Caption = 'Enable Automatic Application of Sales Cr Memo';
            Description = 'HEI.16';
        }
        field(50047; "EDI Nos. FND"; Code[10])
        {
            Description = 'HEI.17';
            Caption = 'EDI Nos.';
            TableRelation = "No. Series";
        }
        field(50048; "Amt Round. Precision Disc. FND"; Decimal)
        {
            Caption = 'Amount Rounding Precision Discounts';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.18';
            InitValue = 0.01;
        }
        field(50049; "Enable EBMS Interface FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Enable EBMS Interface';
        }
        field(50050; "Account Group for AIRSI FND"; Code[20])
        {
            Description = 'HEI.20';
            Caption = 'Account Group for AIRSI';
            TableRelation = "Account Group FND";
        }
        field(50051; "Item Avlblty Msg Enable FND"; Boolean)
        {
            Caption = 'Enable Item Availability Message';
            Description = 'HEI.21';
        }
        field(50052; "Special Order by Default FND"; Boolean)
        {
            Caption = 'Special Order by Default';
            Description = 'HEI.19';
        }
        field(50053; "Item availability FND"; Boolean)
        {
            Caption = 'Enable Item availability check on release';
            Description = 'HEI.22';
        }
        field(50054; "Block Reason for New Cust. FND"; Code[20])
        {
            Description = 'HEI.23';
            Caption = 'Block Reason for New Customer';
            TableRelation = "Blocked Reason FND".Code;
        }
        field(50055; "Enable OTC Billing Auto. FND"; Boolean)
        {
            Description = 'HEI.24';
            Caption = 'Enable OTC Billing Automation';
        }
        field(50056; "Excl.Inv/CM forEMail/Print FND"; Code[10])
        {
            Caption = 'Doc. Subtype to exclude for auto Email/Print';
            Description = 'HEI.25';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Sales));
        }  // BC Upgrade SHUKLP03 <<
        field(50057; "OTC Billing Auto JQ UserID FND"; Code[50])
        {
            Caption = 'OTC Billing Automate JQ UserID';
            Description = 'HEI.27';
            TableRelation = "User Setup";
        }
        field(50058; "Export Invoice FND"; Boolean)
        {
            Caption = 'Export Invoice';
        }
        field(50059; "Skip Custom Reminder Logic FND"; Boolean)
        {
            Caption = 'Skip email sending reminder';
            Description = 'HEI.29';
        }
        field(50060; "Customer Service E-Mail FND"; Text[80])
        {
            Description = 'HEI.30';
            Caption = 'Customer Service E-Mail';
        }
        field(50061; "Bank based on inv currency FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.31';
            Caption = 'Bank based on Invoice Currency';
        }
        field(50062; "Timbre Electronique FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.32';
            Caption = 'Timbre Electronique';
        }
        field(50063; "Timbre Resource Code FND"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.32';
            Caption = 'Timbre Resource Code';
            TableRelation = Resource;
        }
        field(50064; "Editable Timbre Docs. FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.32';
            Caption = 'Editable Timbre Documents';
        }
        field(50065; "Mandatory Loc. on Header FND"; Boolean)
        {
            Caption = 'Mandatory Location on Header';
            DataClassification = ToBeClassified;
            Description = 'HEI.33';
        }
        field(50066; "Cust Stmt. Acc Grp Filter FND"; Text[100])
        {
            Caption = 'Customer Statement Account Group Filter';
            DataClassification = ToBeClassified;
            Description = 'HEI.34';
            TableRelation = "Account Group FND";
            ValidateTableRelation = false;
        }
        field(50067; "Cust. Stmt. Report Date FND"; DateFormula)
        {
            Caption = 'Customer Statement Report Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.34';
        }
        field(50068; "Cust. Stmt. Aging Interval FND"; DateFormula)
        {
            Caption = 'Customer Statement Aging Interval';
            DataClassification = ToBeClassified;
            Description = 'HEI.34';
        }
        field(50069; "Cust. Stmt. Base Calendar FND"; Code[10])
        {
            Caption = 'Customer Statement Base Calendar';
            DataClassification = ToBeClassified;
            Description = 'HEI.34';
            TableRelation = "Base Calendar";
        }
        field(50070; "Cust. Stmt. Email Address FND"; Text[80])
        {
            Caption = 'Customer Statement Email Address';
            DataClassification = ToBeClassified;
            Description = 'HEI.34';
        }
        field(50071; "Prior Due Date Days FND"; DateFormula)
        {
            Caption = 'Prior Due Date Days for Customer';
            DataClassification = ToBeClassified;
            Description = 'HEI.35';
        }
        field(50072; "Remaining Amount limit FND"; Decimal)
        {
            Caption = 'Remaining Amount limit for Cust. Due notification';
            DataClassification = ToBeClassified;
            Description = 'HEI.35';
        }
        field(50073; "SO Mandatory For Cash Cust FND"; Boolean)
        {
            Caption = 'Application on SO Mandatory For Cash Customer';
            DataClassification = ToBeClassified;
            Description = 'HEI.36';
        }
        field(50074; "Ref Value for Cash Cust. FND"; Decimal)
        {
            Caption = 'Reference Value for Cash Customers';
            DataClassification = ToBeClassified;
            Description = 'HEI.36';
            MinValue = 0;
        }
        field(50075; "Autobilling JQ Del. Period FND"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.37';
            Caption = 'Autobilling JQ Deletion Period';

            trigger OnValidate();
            begin
                // HEI.37>>
                if STRPOS(FORMAT("Autobilling JQ Del. Period FND"), '-') = 0 then
                    ERROR(STRSUBSTNO(TextDateFormulaError, FIELDCAPTION("Autobilling JQ Del. Period FND"), "Autobilling JQ Del. Period FND"));
                // HEI.37<<
            end;
        }
        field(50076; "Transportation Cost FND"; Boolean)
        {
            Caption = 'Enable Transportation Cost';
            DataClassification = ToBeClassified;
            Description = 'HEI.38';
        }
        field(50077; "Market Type Dim. Code FND"; Code[10])
        {
            Caption = 'Market Type Dim. Code';
            DataClassification = CustomerContent;
            Description = 'HEI.40';
            TableRelation = Dimension;
        }
        field(50078; "Market Type Domestic FND"; Code[20])
        {
            Caption = 'Market Type Domestic';
            DataClassification = CustomerContent;
            Description = 'HEI.40';

            trigger OnLookup();
            var
                DimensionValue: Record "Dimension Value";
                DimensionValueList: Page "Dimension Value List";
            begin
                //HEI.40
                TESTFIELD("Market Type Dim. Code FND");
                DimensionValue.SETRANGE("Dimension Code", "Market Type Dim. Code FND");
                DimensionValue.SETRANGE("Dimension Value Type", DimensionValue."Dimension Value Type"::Standard);
                DimensionValue.SETRANGE(Blocked, false);
                DimensionValueList.LOOKUPMODE(true);
                DimensionValueList.SETTABLEVIEW(DimensionValue);
                if DimensionValueList.RUNMODAL() = ACTION::LookupOK then begin
                    DimensionValueList.GETRECORD(DimensionValue);
                    "Market Type Domestic FND" := DimensionValue.Code;
                end;
            end;
        }
        field(50079; "Market Type Export FND"; Code[20])
        {
            Caption = 'Market Type Export';
            DataClassification = CustomerContent;
            Description = 'HEI.40';

            trigger OnLookup();
            var
                DimensionValue: Record "Dimension Value";
                DimensionValueList: Page "Dimension Value List";
            begin
                //HEI.40
                TESTFIELD("Market Type Dim. Code FND");
                DimensionValue.SETRANGE("Dimension Code", "Market Type Dim. Code FND");
                DimensionValue.SETRANGE("Dimension Value Type", DimensionValue."Dimension Value Type"::Standard);
                DimensionValue.SETRANGE(Blocked, false);
                DimensionValueList.LOOKUPMODE(true);
                DimensionValueList.SETTABLEVIEW(DimensionValue);
                if DimensionValueList.RUNMODAL() = ACTION::LookupOK then begin
                    DimensionValueList.GETRECORD(DimensionValue);
                    "Market Type Export FND" := DimensionValue.Code;
                end;
            end;
        }
        field(50080; "Dim. Comb. Not Appl. FND"; Boolean)
        {
            Caption = 'Dimension Combination Not Applicable';
            DataClassification = ToBeClassified;
            Description = 'HEI.41';
        }
        field(50081; "Email not to sent to Log. FND"; Boolean)
        {
            Caption = 'Email not to be sent to Logistics';
            DataClassification = ToBeClassified;
            Description = 'HEI.42';
        }
        field(50083; "Delete Cust. Email Log FND"; Boolean)
        {
            Caption = 'Delete Cust. Email Log';
            DataClassification = CustomerContent;
            Description = 'HEI.43';
        }
        field(50084; "Shipment Date Mandatory FND"; Boolean)
        {
            Caption = 'Shipment Date Mandatory';
            DataClassification = CustomerContent;
            Description = 'HEI.44';
        }
        field(50085; "Gate Entry Arch. Required FND"; Boolean)
        {
            Caption = 'Gate Entry Archived Required';
            DataClassification = CustomerContent;
            Description = 'HEI.46';
        }
        field(50086; "Autobilling JQ Restart FND"; Boolean)
        {
            Caption = 'Autobilling JQ Restart';
            DataClassification = ToBeClassified;
            Description = 'HEI.47';
        }
        field(50087; "AutobillingJQMin.ToRestart FND"; Integer)
        {
            Caption = 'Autobilling JQ Min. To Restart';
            DataClassification = ToBeClassified;
            Description = 'HEI.47';
        }
        field(50088; "Autobilling JQMin.ToNotify FND"; Integer)
        {
            Caption = 'Autobilling JQ Min. To Notify';
            DataClassification = ToBeClassified;
            Description = 'HEI.47';
        }
        field(50089; "AutobillingJQMaxNo.Restart FND"; Integer)
        {
            Caption = 'Autobilling JQ Max No. Restart';
            DataClassification = CustomerContent;
            Description = 'HEI.47';
        }
        field(50090; "Show Add. Column on DN FND"; Boolean)
        {
            Caption = 'Show Additional Column on DN';
            DataClassification = ToBeClassified;
            Description = 'HEI.48';
        }
        field(50092; "Empties Inv. Rep. ID FND"; Integer)
        {
            Caption = 'Empties Inv. Rep. ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = CONST(Report));
            Description = 'HEI.50';
        }
        field(50093; "Empties CM Rep. ID FND"; Integer)
        {
            Caption = 'Empties CM Rep. ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = CONST(Report));
            Description = 'HEI.50';
        }
        //BC UPGRADE KUMARR78 >> Adding Field for MTC-FDD-MTC-012
        field(50094; "Batch PostOrders Print FND"; Boolean)
        {
            Caption = 'Batch PostOrders Print';
            Description = 'DITW18.00.06 MSF 26/06/2015 DIT-770 #1347';
            DataClassification = ToBeClassified;
        }

        field(50095; "Batch PostOrd.StatusFilter FND"; Enum "Batch PostOrders Status")
        {
            Caption = 'Batch PostOrders Status Filter';
            Description = 'DITW18.00.06 MSF 26/06/2015 DIT-770 #1347';
            DataClassification = ToBeClassified;

        }
        field(50096; "Batch POShip. Statusfilter FND"; Enum "Batch PO Shipment Statusfilter")
        {
            Caption = 'Batch PO Shipment Statusfilter';
            Description = 'DITW18.00.06 MSF 26/06/2015 DIT-770 #1347';
            DataClassification = ToBeClassified;
        }
        //BC UPGRADE KUMARR78 << Adding Field for MTC-FDD-MTC-012


        // field(2013610; "Excl. Deposit Payment Discount"; Boolean)
        // {
        //     CaptionML = ENU = 'Exclude Deposit on Payment Discount',
        //                 FRA = 'Exclure Consigne sur escompte';
        //     Description = 'DITW16.00.00.43 DIT-715 #678';
        // }
        // field(2013611; "Deposit Point"; Option)
        // {
        //     CaptionML = ENU = 'Deposit Point',
        //                 FRA = 'Points consigne';
        //     Description = 'DIT-770 #776';
        //     OptionCaptionML = ENU = 'Posted Invoice,Posted Shipment',
        //                       FRA = 'Facture enregistré,Expédition enregistré';
        //     OptionMembers = "Posted Invoice","Posted Shipment";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW17.10.05 DDR 19/08/2014 DIT-770 #776
        //         if "Deposit Point" = "Deposit Point"::"Posted Shipment" then begin
        //             "Shipment on Invoice" := true;
        //             "Return Receipt on Credit Memo" := true;
        //         end;

        //         // if "Deposit Point" <> xRec."Deposit Point" then
        //         //     if AppMgt.IsObjectLicense(5, CODEUNIT::"Deposit Item Charges Mgt.", 4) <> 0 then
        //         //         DepositChargeMgt.TestNoOpenDutyPointSalesExist(FIELDCAPTION("Deposit Point"));  // BC Upgrade NANDIS03
        //         // >>DITW17.10.05 DDR DIT-770 #776
        //     end;
        // }
        // field(2013618; "Deposit Warnings"; Option)
        // {
        //     CaptionML = ENU = 'Deposit Warnings',
        //                 FRA = 'Alertes consigne';
        //     Description = 'DITW15.00.00.01';
        //     OptionCaptionML = ENU = 'Both Warnings,Deposit Limit,Quantity Limit,Overdue Balance,No Warning',
        //                       FRA = 'Toutes les Alertes,Consigne autorisée,Quantité autorisée,Solde échu,Aucune alerte';
        //     OptionMembers = "Both Warnings","Deposit Limit","Quantity Limit","Overdue Balance","No Warning";
        // }
        // field(2013628; "Empty Goods Item No. Mandatory"; Boolean)
        // {
        //     CaptionML = ENU = 'Empty Goods Item Number Mandatory',
        //                 FRA = 'N° article vidange obligatoire';
        //     Description = 'DITW15.00.00.34';
        // }
        // field(2013635; "Excl. Deposit Credit Warnings"; Boolean)
        // {
        //     CaptionML = ENU = 'Exclude Deposit on Credit Warnings',
        //                 FRA = 'Exclure Consigne sur Alertes crédit';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.42 DDR 07/12/2012 DIT-715 #370
        //         if "Excl. Deposit Credit Warnings" then
        //             TESTFIELD("Allow Split Deposit per");
        //         // >>DITW16.00.00.42 DDR DIT-715 #370
        //     end;
        // }
        // field(2013636; "Allow Split Deposit per"; Option)
        // {
        //     CaptionML = ENU = 'Allow Split Deposit per',
        //                 FRA = 'Autoriser de scinder type consigne par';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     OptionCaptionML = ENU = ' ,Document,Entry',
        //                       FRA = ' ,Document,Ecriture';
        //     OptionMembers = " ",Document,Entry;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.42 DDR 07/12/2012 DIT-715 #370
        //         if "Allow Split Deposit per" = "Allow Split Deposit per"::" " then
        //             "Excl. Deposit Credit Warnings" := false;
        //         // >>DITW16.00.00.42 DDR DIT-715 #370
        //     end;
        // }
        // field(2013721; "Duty Point"; Option)
        // {
        //     CaptionML = ENU = 'Duty Point',
        //                 FRA = 'Point accises';
        //     Description = 'DITW15.00.00.25-.32';
        //     OptionCaptionML = ENU = 'Posted Invoice,Posted Shipment',
        //                       FRA = 'Facture enregistré,Expédition enregistré';
        //     OptionMembers = "Posted Invoice","Posted Shipment";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 27/05/2010 - 02/06/2010
        //         if "Duty Point" = "Duty Point"::"Posted Shipment" then begin
        //             "Shipment on Invoice" := true;
        //             "Return Receipt on Credit Memo" := true;
        //         end;

        //         // if "Duty Point" <> xRec."Duty Point" then
        //         //     if AppMgt.IsObjectLicense(5, CODEUNIT::"Tax Item Charges Mgt.", 4) <> 0 then
        //         //         TaxChargeMgt.TestNoOpenDutyPointSalesExist(FIELDCAPTION("Duty Point"));  // BC Upgrade NANDIS03
        //         // >>DITW15.00.00.37 DDR
        //     end;
        // }
        // field(2013732; "Default Tax Date"; Option)
        // {
        //     CaptionML = ENU = 'Default Tax Date',
        //                 FRA = 'Date de taxe par défaut';
        //     Description = 'DITW15.00.00.39 #1363';
        //     OptionCaptionML = ENU = 'Order Date,Shipment Date',
        //                       FRA = 'Date commande,Date de préparation';
        //     OptionMembers = OrderDate,ShipRecvDate;
        // }
        // field(2013755; "DTax per Group Mandatory"; Boolean)
        // {
        //     CaptionML = ENU = 'Tax Group Mandatory',
        //                 FRA = 'Groupe taxe obligatoire';
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013760; "Enforce Free Reason on Free"; Boolean)
        // {
        //     CaptionML = ENU = 'Enforce Free Reason on Free',
        //                 FRA = 'Forcer motif gratuit à article gratuit';
        //     Description = 'DITW17.10.03 #699';
        // }
        // field(2013761; "Default Qty. Delayed Discount"; Option)
        // {
        //     CaptionML = ENU = 'Default Qty. Delayed Discount',
        //                 FRA = 'Qté par défaut remises retardées';
        //     Description = 'DITW17.10.03 #699 (later)';
        //     OptionCaptionML = ENU = 'Remainder,Blank',
        //                       FRA = 'Solde,Vide';
        //     OptionMembers = Remainder,Blank;
        // }
        // field(2013762; "Default Qty. Delayed Promotion"; Option)
        // {
        //     CaptionML = ENU = 'Default Qty. Delayed Promotion',
        //                 FRA = 'Quantité promotion retardé défaut';
        //     Description = 'DITW17.10.03 #699';
        //     OptionCaptionML = ENU = 'Remainder,Blank',
        //                       FRA = 'Solde,Vide';
        //     OptionMembers = Remainder,Blank;
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
        // field(2013802; "Max. Order Discount % Allowed"; Decimal)
        // {
        //     CaptionML = ENU = 'Max. Order Discount % Allowed',
        //                 FRA = 'Max. % remise commande autorisée';
        //     Description = 'DITW15.00.00.26-.31';
        //     InitValue = 100;
        //     MaxValue = 100;
        //     MinValue = 0;
        // }
        // field(2013910; "Min. Volume Warning"; Option)
        // {
        //     CaptionML = ENU = 'Min. Volume (Cubage) Warning',
        //                 FRA = 'Alerte sur Minimum Volume (cubage)';
        //     Description = 'DITW17.00.02 DIT-770 #189 - DIT-770 #354';
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
        //     Description = 'DITW17.00.02 DIT-770 #354';
        //     TableRelation = "Unit of Measure";
        // }
        // field(2013915; "Max. Volume Warning"; Option)
        // {
        //     CaptionML = ENU = 'Max. Volume (Cubage) Warning',
        //                 FRA = 'Avertissement maximum volume (Cubage)';
        //     Description = 'Reserved DIT-770 #960';
        //     OptionCaptionML = ENU = 'None,Warning,Blocking',
        //                       FRA = 'Aucun,Avertissement,Blocage';
        //     OptionMembers = "None",Warning,Blocking;
        // }
        // field(2013916; "Max. Weight Warning"; Option)
        // {
        //     CaptionML = ENU = 'Max. Weight Warning',
        //                 FRA = 'Avertissement Poids maximum';
        //     Description = 'Reserved DIT-770 #960';
        //     OptionCaptionML = ENU = 'None,Warning,Blocking',
        //                       FRA = 'Aucun,Avertissement,Blocage';
        //     OptionMembers = "None",Warning,Blocking;
        // }
        // field(2013917; "Sales History Calculation"; DateFormula)
        // {
        //     CaptionML = ENU = 'Sales History Calculation',
        //                 FRA = 'Calcul Historique ventes';
        //     Description = 'DITW15.00.00.39 RBE 26/04/2011 #1230.1';
        // }
        // field(2013918; "Min. Weight Warning"; Option)
        // {
        //     CaptionML = ENU = 'Min. Weight Warning',
        //                 FRA = 'Poids Minimum Pour Avertissement';
        //     Description = 'DITW18.00.07 DIT-770 #960';
        //     OptionCaptionML = ENU = 'None,Warning,Blocking',
        //                       FRA = 'Aucun,Avertissement,Blocage';
        //     OptionMembers = "None",Warning,Blocking;
        // }
        // field(2013921; "Copy Comments Cust. to Sell-to"; Boolean)
        // {
        //     CaptionML = ENU = 'Copy Sell-to Customer Comments to Order',
        //                 FRA = 'Copier commentaires du donneur d''ordre vers Commande';
        //     Description = 'DITW15.00.00.39 #1230';
        //     InitValue = true;
        // }
        // field(2013930; "Sales Cond. Type 1"; Option)
        // {
        //     CaptionML = ENU = 'Type 1',
        //                 FRA = 'Type 1';
        //     Description = 'DITW17.00.03 DIT-770 #389';
        //     InitValue = "Charge (Item)";
        //     OptionCaptionML = ENU = ',G/L Account,,,,Charge (Item)',
        //                       FRA = ',Compte général,,,,Frais annexes';
        //     OptionMembers = " ","Account (G/L)",Item,Resource,"Fixed Asset","Charge (Item)";
        // }
        // field(2013931; "Sales Cond. No 1"; Code[20])
        // {
        //     CaptionML = ENU = 'No. 1',
        //                 FRA = 'N° 1';
        //     Description = 'DITW17.00.03 DIT-770 #389';
        //     TableRelation = "Item Charge"."No.";
        // }
        // field(2013932; "Sales Cond. Type 2"; Option)
        // {
        //     CaptionML = ENU = 'Type 2',
        //                 FRA = 'Type 2';
        //     Description = 'DITW17.00.03 DIT-770 #389';
        //     InitValue = "Charge (Item)";
        //     OptionCaptionML = ENU = ',G/L Account,,,,Charge (Item)',
        //                       FRA = ',Compte général,,,,Frais annexes';
        //     OptionMembers = " ","Account (G/L)",Item,Resource,"Fixed Asset","Charge (Item)";
        // }
        // field(2013933; "Sales Cond. No 2"; Code[20])
        // {
        //     CaptionML = ENU = 'No. 2',
        //                 FRA = 'N° 2';
        //     Description = 'DITW17.00.03 DIT-770 #389';
        //     TableRelation = "Item Charge"."No.";
        // }
        // field(2013934; "Sales Cond. Type 3"; Option)
        // {
        //     CaptionML = ENU = 'Type 3',
        //                 FRA = 'Type 3';
        //     Description = 'DITW17.00.03 DIT-770 #389';
        //     InitValue = "Charge (Item)";
        //     OptionCaptionML = ENU = ',G/L Account,,,,Charge (Item)',
        //                       FRA = ',Compte général,,,,Frais annexes';
        //     OptionMembers = " ","Account (G/L)",Item,Resource,"Fixed Asset","Charge (Item)";
        // }
        // field(2013935; "Sales Cond. No 3"; Code[20])
        // {
        //     CaptionML = ENU = 'No. 3',
        //                 FRA = 'N° 3';
        //     Description = 'DITW17.00.03 DIT-770 #389';
        //     TableRelation = "Item Charge"."No.";
        // }
        // field(2013936; "Sales Cond. Type 4"; Option)
        // {
        //     CaptionML = ENU = 'Type 4',
        //                 FRA = 'Type 4';
        //     Description = 'DITW17.00.03 DIT-770 #389';
        //     InitValue = "Charge (Item)";
        //     OptionCaptionML = ENU = ',G/L Account,,,,Charge (Item)',
        //                       FRA = ',Compte général,,,,Frais annexes';
        //     OptionMembers = " ","Account (G/L)",Item,Resource,"Fixed Asset","Charge (Item)";
        // }
        // field(2013937; "Sales Cond. No 4"; Code[20])
        // {
        //     CaptionML = ENU = 'No. 4',
        //                 FRA = 'N° 4';
        //     Description = 'DITW17.00.03 DIT-770 #389';
        //     TableRelation = "Item Charge"."No.";
        // }
        // field(2014060; "Return reason code mandatory"; Boolean)
        // {
        //     CaptionML = ENU = 'Return reason code mandatory',
        //                 FRA = 'Return reason code mandatory';
        //     Description = 'DITW17.00.02 DIT-770 #145';
        // }
        // field(2014065; "Late Order Warning"; Option)
        // {
        //     CaptionML = ENU = 'Late Order Warning',
        //                 FRA = 'Avertissement Commande en Retard';
        //     Description = 'DITW18.00.07 DIT-770 #1282';
        //     OptionCaptionML = ENU = 'No Warning,Warning,Blocked',
        //                       FRA = 'Pas d''avertissement,Avertissement,Blocage';
        //     OptionMembers = "No Warning",Warning,Blocked;
        // }
        // field(2014082; "Auto Proc. Backord. On Posting"; Boolean)
        // {
        //     Caption = 'Auto Process Backorders  On Posting';
        //     Description = 'NRQ#33755';
        // }
        // field(2014107; "Default Route"; Code[20])
        // {
        //     CaptionML = ENU = 'Default Route',
        //                 FRA = 'Route par défaut';
        //     Description = 'DITW18.00.06 MSF 02/10/2015 DIT-770 #1604';
        //     TableRelation = Route;
        // }
        // field(2014108; "Route Mandatory"; Boolean)
        // {
        //     CaptionML = ENU = 'Route Mandatory',
        //                 FRA = 'Route Obligatoire';
        //     Description = 'DITW18.00.07 DIT-770 #1488';
        // }
        // field(2014109; "Post Linked Return Order"; Boolean)
        // {
        //     Caption = 'Post Linked Return Order';
        //     Description = 'NRQ16224';
        // }
        // field(2014310; "Excl. Loan Credit Warnings"; Boolean)
        // {
        //     Caption = 'Exclude Loan on Credit Warnings';
        //     Description = 'DITW111.00.13A #43375';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.42 DDR 07/12/2012 DIT-715 #370
        //         if "Excl. Deposit Credit Warnings" then
        //             TESTFIELD("Allow Split Deposit per");
        //         // >>DITW16.00.00.42 DDR DIT-715 #370
        //     end;
        // }
        // field(2014360; "Event Doc. Nos."; Code[20])
        // {
        //     CaptionML = ENU = 'Event Doc. Nos.',
        //                 FRA = 'N° doc. événements';
        //     Description = 'DITW17.10.05 DIT-770 #779';
        //     TableRelation = "No. Series";
        // }
        // field(2014361; "New Document Per Shipment Date"; Boolean)
        // {
        //     CaptionML = ENU = 'New Document Per Shipment Date',
        //                 FRA = 'Nouveau document par Date de livraison';
        //     Description = 'DITW18.00.06 MSF 21/09/2015 DIT-770 #1261';
        // }
        // field(2014362; "New Document For Event Returns"; Option)
        // {
        //     CaptionML = ENU = 'New Document For Event Returns',
        //                 FRA = 'Nouveau document par retour Evénements';
        //     Description = 'DITW18.00.06 MSF 21/09/2015 DIT-770 #1261';
        //     OptionCaptionML = ENU = ' ,Order,Return Order',
        //                       FRA = ' ,Commande,Retour';
        //     OptionMembers = " ","Order","Return Order";
        // }
        // field(2014363; "Block Events In Process"; Boolean)
        // {
        //     CaptionML = ENU = 'Block Events In Process',
        //                 FRA = 'Bloquer Evenement En Cours';
        //     Description = 'DITW18.00.06 MSF 21/09/2015 DIT-770 #1261';
        // }
        // field(2014364; "Event Invoice Method"; Option)
        // {
        //     CaptionML = ENU = 'Event Invoice Method',
        //                 FRA = 'Méthode facturation évévenment';
        //     Description = 'DITW18.00.06 MSF 21/09/2015 DIT-770 #1261';
        //     OptionCaptionML = ENU = ' ,Shipment,Order,Combine Shipments,Combine Shipments Per Sell-to',
        //                       FRA = ' ,Expédition,Commande,Combiner expeditions,Combiner les expeditions par donneur d''ordre';
        //     OptionMembers = " ",Shipment,"Order","Combine Shipments","Combine Shipments Per Sell-to";
        // }
        // field(2014365; "Event Invoice Period"; Option)
        // {
        //     CaptionML = ENU = 'Event Invoice Period',
        //                 FRA = 'Période facturation événement';
        //     Description = 'DITW18.00.06 MSF 21/09/2015 DIT-770 #1261';
        //     OptionCaptionML = ENU = ' ,Direct Delivery,Order,Event,Daily,Weekly,Half Montly,Montly,10 Days',
        //                       FRA = ' ,Livraison directe,Ordre,Événement,Quotidienne,Hebdomadaire,Demi-Mensuelle,Mensuelle,10 Jours';
        //     OptionMembers = " ","Direct Delivery","Order","Order Manually",Daily,Weekly,"Half Montly",Montly,"10 Days";
        // }
        // field(2014410; "Order Alert Warning"; Boolean)
        // {
        //     CaptionML = ENU = 'Order Alert Warning',
        //                 FRA = 'Alerte Commandes';
        //     Description = 'DITW17.10.05 DIT-770 #754';
        // }
        // field(2014411; "Shipment Date Alert Filter"; DateFormula)
        // {
        //     CaptionML = ENU = 'Shipment Date Alert Filter',
        //                 FRA = 'Filtre alerte date d''expedition';
        //     Description = 'DITW17.10.05 DIT-770 #754';
        // }
        // field(2014412; "Shipment Status Alert Filter"; Option)
        // {
        //     CaptionML = ENU = 'Shipment Status Alert Filter',
        //                 FRA = 'Filtre Alerte Statut expedition';
        //     Description = 'DITW17.10.05 DIT-770 #754';
        //     OptionCaptionML = ENU = 'Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice',
        //                       FRA = 'Ouvert,Prélèvement imprimé,Affecté,Prélevé,Expédié,Retour terminée,Facturée';
        //     OptionMembers = Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;
        // }
        // field(2014413; "Show Warning ShptDate-Workdate"; Boolean)
        // {
        //     CaptionML = ENU = 'Show Shipment Date Warning (Work Date)',
        //                 FRA = 'Afficher avertissement date expédition (Date travail)';
        //     Description = 'DITW19.00.08 BL#10806';
        // }
        // field(2014414; "Show Item Tracking Alert on SO"; Boolean)
        // {
        //     Caption = 'Show Item Tracking Alert on Sales Order';
        //     Description = 'NRQ#94671';
        // }
        // field(2014415; "Automatic Document Approval"; Boolean)
        // {
        //     Caption = 'Automatic Document Approval';
        //     Description = 'DITW111.00.13 MSF 04/02/2019 NRQ#87409 NRQ#103938';
        // }
        // field(2014419; "Prices Priority Method"; Option)
        // {
        //     CaptionML = ENU = 'Prices Priority Method',
        //                 FRA = 'Méthode priorité Prix';
        //     Description = 'DITW16.00.00.42 DIT-715 #521';
        //     OptionCaptionML = ENU = 'Best Price,Cust./Item',
        //                       FRA = 'Meilleur prix,Client/Article';
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
        // field(2014425; "Item Quota Warning"; Option)
        // {
        //     CaptionML = ENU = 'Item Quota Warning',
        //                 FRA = 'Avertissement quota article';
        //     Description = 'DITW17.10.03 DIT-770 #392';
        //     OptionCaptionML = ENU = 'No Warning,Confirmation,Blocked',
        //                       FRA = 'Aucune alerte,Confirmation,Bloqué';
        //     OptionMembers = "No Warning",Confirmation,Blocked;
        // }
        // field(2014429; "Bill-to/Sell-to Prices Calc."; Option)
        // {
        //     CaptionML = ENU = 'Bill-to/Sell-to Prices Calculation',
        //                 FRA = 'Calcul Prix client facturé/donneur d''ordre';
        //     Description = 'DITW16.00.00.42 DIT-715 #520';
        //     OptionCaptionML = ENU = 'Bill-to,Sell-to',
        //                       FRA = 'N° client facturé,N° donneur d''ordre';
        //     OptionMembers = "Bill-to","Sell-to";
        // }
        // field(2014430; "Sales Conditions Based on"; Option)
        // {
        //     CaptionML = ENU = 'Sales Conditions Based on',
        //                 FRA = 'Conditions de vente basés sur';
        //     Description = 'DITW17.00.02 DIT-770 #136';
        //     OptionCaptionML = ENU = 'Order Date,Shipment Date',
        //                       FRA = 'Date commande,Date de préparation';
        //     OptionMembers = OrderDate,ShipRecvDate;
        // }
        // field(2014431; "Recalculate Prices"; Option)
        // {
        //     CaptionML = ENU = 'Recalculate Prices',
        //                 FRA = 'Recalculer Prix';
        //     Description = 'DITW18.00.07 DIT-770 #1402';
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
        //     Description = 'DITW15.00.00.32';
        // }
        // field(2014448; "Show Reopen Warnings"; Boolean)
        // {
        //     CaptionML = ENU = 'Show Reopen Warnings',
        //                 FRA = 'Afficher Alertes sur Ouverture';
        //     Description = 'DITW18.00.07 DIT-770 #1402';
        // }
        // field(2014451; "Auto.Release Document on Whse."; Boolean)
        // {
        //     CaptionML = ENU = 'Automatic Release document with Whse. Shipment',
        //                 FRA = 'Lancer document automatique avec E&xpédition magasin';
        //     Description = 'DITW15.00.00.34';
        // }
        // field(2014455; "Cr. Warning Incl. Delayed Disc"; Boolean)
        // {
        //     CaptionML = ENU = 'Credit Warning Incl. Delayed Discounts',
        //                 FRA = 'Alerte de crédit avec Remises retardées';
        //     Description = 'CARL31-DITW15.00.00.37';
        // }
        // field(2014496; "Insert Std. Cust. Sales Lines"; Option)
        // {
        //     Caption = 'Insert Std. Cust. Sales Lines';
        //     Description = 'DITW15.00.00.39 DDR 27/04/2011 #1323 (BE field 11313)';
        //     OptionCaption = 'Manual,Automatic,Always Ask';
        //     OptionMembers = Manual,Automatic,"Always Ask";
        // }
        // field(2014497; Quotes; Boolean)
        // {
        //     Caption = 'Quotes';
        //     Description = 'DITW15.00.00.39 DDR 27/04/2011 #1323 (BE field 11314)';
        // }
        // field(2014498; Orders; Boolean)
        // {
        //     Caption = 'Orders';
        //     Description = 'DITW15.00.00.39 DDR 27/04/2011 #1323 (BE field 11316)';
        // }
        // field(2014499; Invoices; Boolean)
        // {
        //     Caption = 'Invoices';
        //     Description = 'DITW15.00.00.39 DDR 27/04/2011 #1323 (BE field 11317)';
        // }
        // field(2014500; "Credit Memos"; Boolean)
        // {
        //     Caption = 'Credit Memos';
        //     Description = 'DITW15.00.00.39 DDR 27/04/2011 #1323 (BE field 11319)';
        // }
        // field(2014501; "Invoice List Document Nos."; Code[20])
        // {
        //     CaptionML = ENU = 'Invoice List Document No.',
        //                 FRA = 'N° document liste facture';
        //     Description = 'DITW17.10.05 DIT-770 #761';
        //     TableRelation = "No. Series";
        // }
        // field(2014504; "Bill-to/Sell-to Dimensions"; Option)
        // {
        //     CaptionML = ENU = 'Bill-to/Sell-to Dimensions',
        //                 FRA = 'Axes analytiques client facturé/donneur d''ordre';
        //     Description = 'DITW16.00.00.42 DIT-715 #522';
        //     OptionCaptionML = ENU = 'Bill-to,Sell-to',
        //                       FRA = 'N° client facturé,N° donneur d''ordre';
        //     OptionMembers = "Bill-to","Sell-to";
        // }
        // field(2014505; "Bill-to/Sell-to Salespers./P."; Option)
        // {
        //     CaptionML = ENU = 'Bill-to/Sell-to from Salespers./Purch. Code',
        //                 FRA = 'Vendeur/acheteur de client facturé/donneur d''ordre';
        //     Description = 'DITW16.00.00.42 DIT-715 #529';
        //     OptionCaptionML = ENU = 'Bill-to,Sell-to',
        //                       FRA = 'N° client facturé,N° donneur d''ordre';
        //     OptionMembers = "Bill-to","Sell-to";
        // }
        // field(2014506; "Sales Price Mandatory"; Boolean)
        // {
        //     CaptionML = ENU = 'Sales Price Mandatory',
        //                 FRA = 'Prix vente obligatoire';
        //     Description = 'DITW16.00.00.43 DIT-715 #605';
        // }
        // field(2014511; "Loyalty Priority Method"; Option)
        // {
        //     Caption = 'Loyalty Priority Method';
        //     Description = 'DITW113.00.15 NRQ#9775';
        //     OptionCaption = 'Use all lines (sum),Use best line';
        //     OptionMembers = "Use all lines (sum)","Use best line";
        // }
        // field(2014512; "Loyalty Point Warning"; Option)
        // {
        //     Caption = 'Loyalty Point Warning';
        //     Description = 'DITW16.00.00.40 DIT-715 #243 #1759 - DITW113.00.15 NRQ#122793';
        //     OptionCaption = 'No Warning,Warning,Blocking';
        //     OptionMembers = "No Warning",Warning,Blocking;
        // }
        // field(2014513; "Loyalty Amount Warning"; Option)
        // {
        //     Caption = 'Loyalty Amount Warning';
        //     Description = 'DITW113.00.15 NRQ#122793';
        //     OptionCaption = 'No Warning,Warning,Blocking';
        //     OptionMembers = "No Warning",Warning,Blocking;
        // }
        // field(2014515; "Enable Loyalty"; Boolean)
        // {
        //     Caption = 'Enable Loyalty';
        //     Description = 'DITW17.10.05 DIT-770 #185-NRQ10488 ';
        // }
        // field(2014520; "Enforce Loyalty on Free Item"; Boolean)
        // {
        //     CaptionML = ENU = 'Enforce Loyalty on Free Item',
        //                 FRA = 'Restrict Fidèlité sur Article gratuit';
        //     Description = 'DITW16.00.00.40 DIT-715 #243';
        // }
        // field(2014521; "Calculate Loyalty Balance"; Option)
        // {
        //     CaptionML = ENU = 'Calculate Balance Loyalty Per',
        //                 FRA = 'Calculer Solde Fidélité par';
        //     Description = 'DITW16.00.00.42 DIT-715 #551';
        //     OptionCaptionML = ENU = 'Item,Customer',
        //                       FRA = 'Article,Client';
        //     OptionMembers = Item,All;
        // }
        // field(2014522; "Loyalty on Bill-to/Sell-to"; Option)
        // {
        //     CaptionML = ENU = 'Bill-to/Sell-to Loyalty',
        //                 FRA = 'Fidélisation client facturé/donneur d''ordre';
        //     Description = 'DITW17.10.05 DIT-770 #185';
        //     OptionCaptionML = ENU = 'Bill-to,Sell-to',
        //                       FRA = 'Client facturé,Donneur ordre';
        //     OptionMembers = "Bill-to","Sell-to";
        // }
        // field(2014600; "Autoblock Customer On Changes"; Boolean)
        // {
        //     Caption = 'Autoblock Customer On Changes';
        //     Description = 'NRQ#13577';
        // }
        // field(2014601; "Autoblock Cust. On  Dimension"; Boolean)
        // {
        //     Caption = 'Autoblock Cust. On  Dimension';
        //     Description = 'NRQ#13577';
        // }
        // field(2014602; "Autoblock Cust. On BankAccount"; Boolean)
        // {
        //     Caption = 'Autoblock Cust. On BankAccount';
        //     Description = 'NRQ#13577';
        // }
        // field(2029610; "Use OGM"; Option)
        // {
        //     CaptionML = ENU = 'Use OGM',
        //                 FRA = 'Use OGM';
        //     Description = 'FINXL7.00.001';
        //     OptionCaptionML = ENU = ' ,Document,Customer + Document',
        //                       FRA = ' ,Document,Client + Document';
        //     OptionMembers = " ",Document,"Customer + Document";
        // }
        // field(2029611; "Print OGM"; Boolean)
        // {
        //     CaptionML = ENU = 'Print OGM',
        //                 FRA = 'Print OGM';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029612; "Block Invoicing From Orders"; Boolean)
        // {
        //     CaptionML = ENU = 'Block Invoicing From Orders',
        //                 FRA = 'Bloqué facturation d''ecran commandes';
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
        // field(2029615; "Sales prices mandatory"; Option)
        // {
        //     CaptionML = ENU = 'Sales price warning (Item)',
        //                 FRA = 'Ne permet pas prix égal à zéro',
        //                 FRB = 'Prix de vente alerte (article)',
        //                 NLB = 'Verkoopprijs waarschuwing (artikel)';
        //     Description = 'FINXL10.01';
        //     OptionCaptionML = ENU = 'No Warning,Warning,Blocked',
        //                       FRB = 'Pas d''alerte,Alerte,Bloqué',
        //                       NLB = 'Geen waarschuwing, Waarschuwing Blokkeren';
        //     OptionMembers = "No Warning",Warning,Blocked;
        // }
        // field(2029617; "No Invoicing Without SO Match"; Boolean)
        // {
        //     CaptionML = ENU = 'No Invoicing Without SO Match',
        //                 FRA = 'Pas de facturation sans commande vente correspendant';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029618; "Show Jnl. Template Selection"; Boolean)
        // {
        //     CaptionML = ENU = 'Show Jnl. Template Selection',
        //                 FRA = 'Afficher l''écran de sélection modèle feuille';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029619; "Print Method"; Option)
        // {
        //     CaptionML = ENU = 'Print Method',
        //                 FRA = 'Imprimer Méthode';
        //     Description = 'FINXL8.00.001';
        //     OptionCaptionML = ENU = ' ,Without Header,Without Footer,Without Header & Footer',
        //                       FRA = ' ,Sans Entête,Sans Pied,Sans Entête & Pied';
        //     OptionMembers = " ","Without Header","Without Footer","Without Header & Footer";
        // }
        // field(2029620; "Customer Auto Dimension Code"; Code[20])
        // {
        //     Caption = 'Customer Auto Dimension Code';
        //     Description = 'FINXL10.01';
        //     TableRelation = Dimension;
        // }
        // field(2034925; "Bill-to/Sell-to Building Dim."; Option)
        // {
        //     CaptionML = ENU = 'Bill-to/Sell-to Building Dimension',
        //                 FRA = 'Axe Immeuble client facturé/donneur d''ordre';
        //     Description = 'DITW15.00.00.37';
        //     OptionCaptionML = ENU = 'Bill-to,Sell-to',
        //                       FRA = 'Client facturé,Donneur ordre';
        //     OptionMembers = "Bill-to","Sell-to";
        // }
        // field(2034926; "Autofill End Date"; Boolean)
        // {
        //     CaptionML = ENU = 'Autofill Ending Date on Sales Prices',
        //                 FRA = 'Remplissage auto. date de fin pour les prix de vente';
        //     Description = 'DITW17.10.03 DIT-770 #617';
        // }
        // field(2035394; "Batch PostOrders Print"; Boolean)
        // {
        //     CaptionML = ENU = 'Batch Post Orders Print',
        //                 FRA = 'TPL imprimer Commande vente';
        //     Description = 'DITW18.00.06 MSF 26/06/2015 DIT-770 #1347';
        // }
        // field(2035395; "Batch PostOrders Status Filter"; Option)
        // {
        //     CaptionML = ENU = 'Batch Post Orders Status Filter',
        //                 FRA = 'Filtre status TPL valider cmde. vente imprimé';
        //     Description = 'DITW18.00.06 MSF 26/06/2015 DIT-770 #1347';
        //     OptionCaptionML = ENU = ' ,Released',
        //                       FRA = ' ,Lancé';
        //     OptionMembers = " ",Released;
        // }
        // field(2035396; "Batch PO Shipment Statusfilter"; Option)
        // {
        //     CaptionML = ENU = 'Batch Post Orders Shipment Status Filter',
        //                 FRA = 'Filtre livraison status TPL valider cmde. vente imprimé';
        //     Description = 'DITW18.00.06 MSF 26/06/2015 DIT-770 #1347';
        //     OptionCaptionML = ENU = 'Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice',
        //                       FRA = 'Ouvert,Prélèvement imprimé,Affecté,Prélevé,Expédié,Retour terminée,Facturée';
        //     OptionMembers = Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;
        // }// BC Upgrade NANDIS03
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
        TextDateFormulaError: Label '%1 should contain negative value';
        Text2013660: TextConst ENU = ' must be Yes when %1 is %2.', FRA = ' doit être Oui quand %1 est %2.';
        // TaxChargeMgt: Codeunit "Tax Item Charges Mgt.";  // BC Upgrade NANDIS03
        // DepositChargeMgt: Codeunit "Deposit Item Charges Mgt.";  // BC Upgrade NANDIS03
        //AppMgt: Codeunit ApplicationManagement;  // BC Upgrade NANDIS03
        Text2014060: TextConst ENU = '%1 Should be Blank, both filter can''t be used simultaneously.', FRA = '%1 doit être vide, plusieurs filtres ne peuvent pas être utilisés simultanement.';
}

