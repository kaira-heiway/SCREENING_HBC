pageextension 51185 CustomerCardExtCBN extends "Customer Card"
{
    //     DITW15.00.00.01 DDR 21/12/2007 Added Drink-it Tax Item Charges functionnalities
    // DITW15.00.00.01 DDR 21/12/2007 added tab "Drink Tax"
    //                                added fields
    //                                  2034647 Drink Tax Group Code
    //                                added menu item charges into Sales button
    // DITW15.00.00.01 DDR 03/01/2008 Rename tab "Drink Tax" -> "Drink-It"
    //                                added fields
    //                                  2013610 Item DDeposit Group Code
    // DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    // DITW15.00.00.01 DDR 08/01/2008 Added "Empty Goods Tracking" into Customer menu button
    // DITW15.00.00.01 DDR 09/01/2008 Remove key sorting for Tax/Depoist Item charges menu
    // DITW15.00.00.01 DDR 21/01/2008 Added Drink-it Disc.& Promotion functionalities
    //                                added "No. of Drink Disc. Groups","No. of Promotion Groups"
    //                                added menu into Customer, Sales & Purchases
    // DITW15.00.00.01 DDR 31/01/2008 Added Drink-it Reversing Calculation (Rounding) functionnalities
    //                                Added column "Price Incl. Reversing Calc."
    // DITW15.00.00.01 DDR 05/02/2008 Change captions menu (Drink-it)
    // DITW15.00.00.01 DDR 19/03/2008 Added field2013614 Deposit Limit into Drink-It tab
    //                                Added menu Deposit Limits into Sales button
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    // DITW15.00.00.24 DDR 14/08/2008 Added field2014087 Distance into "Shipping" tab
    //                 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    // DITW15.00.00.25 DDR 21/10/2008 Deleted field2013722 Duty Tax Type
    // DITW15.00.00.28 DDR 24/11/2008 Added tab "Drink-It"
    //                                Added fields "Tax Registration No.","Fiscal Representative No." into tab Drink-It
    //                                Added field "Deposit Balance (LCY)" in "General" tab
    //                                Added "Print" MenuButton
    //                                Added menu "Empty Goods Statement" into "Print" button

    // DITW15.00.00.32 DDR 02/04/2009 Bad Caption field "Distance" (shipping tab)
    // DITW15.00.00.32 DDR 06/04/2009 Added field "AAD Std. Text (Area 23) Code" into Drink-It tab
    // DITW15.00.00.33 DDR 11/05/2009 Removed field "AAD Std. Text (Area 23) Code" into Drink-It tab
    // DITW15.00.00.35 DDR 24/06/2009 issue 669 Added field into Drink-It tab
    //                                  "Gen. Bus. Posting Free Group","Free Item Posting Type"
    //                                issue 772 save record before lookup Drink Discount/Promotion groups
    //                     10/04/2009 Added "Building" tab
    //                     28/08/2009 Added menu "Service Contracts Lines"
    //                     23/09/2009 issue 814 Split customer posting group per contract type (+ copy default value)
    //                                  Added 'Contract' tab + fields
    // DITW15.00.00.37 DDR 02/04/2010 issue 1110 Added field "Transport Time" into Drink-It tab
    //                 BGI 09/06/2010 issue 1028 added menu "additional credit limit" on Sales button
    // DITW16.00.00.37 DDR 13/01/2011 DIT-715 issue 42 RTC Upgrade: Added lookup triggers for flowfields
    //                                             "No. of Drink Disc. Groups","No. of Promotion Groups"
    // DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    (General) "Customer Template Code"
    //                                    (Foreign Trade) "Transaction Type","Transport Method","Transaction Specification",
    //                                      "Exit Point","Area Code"
    //                                  Modified controls for 'LookupFormID' property
    //                                    "Customer DTax Group Code","Customer DDeposit Group Code"
    //                     13/09/2010   Added fields
    //                                    (Drink-it) "Tax Warehouse Reference","Tax Office Code"
    //                     19/11/2010 issue 1139 SSCC Functionnalities
    //                                  Added menu 'SSCC Entries' into 'Sales' menu button
    // DITW15.00.00.39 RBE 20/04/2011 issue 1230 Telesales functionnalities
    //                                  Added fields "Telesales Level Group Code","Telesales Level Based" into 'Telesales' tab
    //                                  Added fields "Delivery Sequence" into 'Shipping' tab
    //                     22/04/2011   Added 'Customized Calendar' menu into 'Customer' button
    // DITW15.00.00.39 DDR 27/04/2011 issue 1230 Telesales functionnalities
    //                                  Added fields "Default Standard Sales Code"
    //                     24/06/2011 issue 1230 Copied fields "Base Calendar Code","Customized Calendar" into 'Telesales' tab
    //                     04/07/2011 issue 951 Merged tabs Building and Contract together
    //                     06/07/2011 issue 1353 Added fields "Journey Time" into 'Drink-it' tab
    //                     15/07/2011 issue 1230 Added 'Telesales Overview' menu into 'Customer' button
    //                     27/07/2011 issue 1407 (Drink-it tab) Added fields "Autom. Item Charge"
    //                     29/08/2011 issue 1396 Added fields "No. of Exclusivity Groups" into 'Drink-it' tab
    //                                           Added 'Exclusivity Groups' menu into 'Customer' button
    //                                           Added 'Item Exclusivity' menu into 'Sales' button
    //                     30/08/2011 issue 1397 Added (back) split Building & Contract
    //                                           Added local control to calculate the Sub Contract Balance (LCY)
    //                                           Added functions DrillDownContractBalanceLCY(),CalcContractBalanceLCY()
    //                     23/09/2011 issue 1397 Bugfix functions CalcContractBalanceLCY()
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields "Minimum Volume","Minimum Weight","Route"
    //                                             "Shipping Calendar Base Code"
    // DITW16.00.00.40 PRODW14.00.00.08.19 DDR 20/12/2011 issue 1466
    //                                           Bugfix menu 'Sales\Standards' wrong called form to open + Captions 'Quality Standards'
    //                     06/04/2012 DIT-715 #243 Loyalty functionnality
    //                                  Added fields "Loyalty Warnings" into 'Drink-it' tab
    //                                  Added 'Item Loyalty Statistics' menu into 'Customer' button
    //                                  Added 'Loyalty Groups' menu into 'Customer' button
    //                                  Added 'Item Loyalty' menu into 'Sales' button
    //                                  Added 'Loyalty Statement' menu into 'Print' button
    //                     29/06/2012 DIT-715 #243 Modified Loyalty Captions
    // DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 Plant Maintenance Functionnality
    //                                  Added fields "Contract Cust. Post. Gr. Plant" into 'Contract' tab
    //                                  Added 'Plant' menu button
    // DITW16.00.00.41 AHU 07/08/2012 DIT-715 #327 Moved functions to table18 Customer
    //                                               DrillDownContractBalanceLCY(),CalcContractBalanceLCY()
    //                 AHU 16/08/2012 DIT-715 #327 Added "Customer Posting Group","Balance (LCY)" into 'Contract' tab
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields into 'Drink-It' tab
    //                                               "Deposit Cust. Posting Group","Deposit Payment Terms Code",
    //                                               "Deposit Payment Method Code","Split Deposit on Invoice"
    //                                             Added fields into 'General' tab
    //                 DDR 12/12/2012 DIT-715 #520 Added fields "Bill-to/Sell-to Prices Calc." into 'Invoicing' tab
    //                 AHU 18/12/2012 DIT-715 #327 Updated control1100076018
    //                                             Added 'Blanket Contracts';'DIT Contracts' menu into 'Customer' buttonj
    //                 DDR 19/12/2012 DIT-715 #520 Added fields "Sell-to/Bill-to DTax Gr. Calc." into 'Invoicing' tab
    //                 AHU 19/12/2012 DIT-715 #378 Added fields "Item DDisc. Group Code","Item DDisc. Group Code 2"
    // DITW16.00.00.43 DDR 13/05/2013 DIT-715 #604 Added fields "Default Ship-to Code" (shipping tab)
    //                 AHU 28/05/2013 DIT-715 #497 Added fields "Exclusivity"
    //                 DDR 10/06/2013 DIT-715 #623 Bugfix Drilldown fields "Loan in Use Balance","Maintenance Balance",
    //                                              "Plant Mainteance Balance"
    //                 AHU 12/06/2013 DIT-715 #617 Added 'DIT Contract' group into 'Contract' tab
    //                                             Added factbox2035463 <Cust DContract Stats. FactBox>
    //                                             Modified Captions Blanket Contracts
    //                                             Added 'DIT Contract Volumes' menu 'Cust' button
    //                 AHU 20/06/2013 DIT-715 #617 Added DrillDown trigger flowfields
    //                                               "Sales (Qty.) HL","Sales Indirect (Qty.) HL",
    //                                               "Sales Indirect (Qty.) HL","Sales Free (Qty.) HL"
    //                                             Modified 'DIT Contract Volumes' menu properties

    // FINXL7.00.001 RBE 20/03/2013 : Added VAT Validation
    // FINXL7.00.001 YHE 13/06/2014 #44 : Added "Postal address"
    // FINXL7.00.001 WSA 15/07/2014 #88 : Removed fct fctValidateVAT
    // FINXL8.00.001 BSA 11/06/2015 #67 : Added FIELD "Send Document"
    // FINXL8.00.001 BSA 23/06/2015 #161: Apply Template when Create New Customer
    // FINXL8.00.001 BSA 24/06/2015 #63 : Copy Customer Card, Prices and Discounts

    // DITW17.00.02 DDR 13/05/2013 DIT-715 #604
    //                  17/05/2013 DIT-770 #95 Added tab 'EMCS UK'
    //                                             Added fields "Vessel Info. Mandatory" (EMCS UK tab)
    //              DDR 28/05/2013 DIT-715 #497 merge
    //              DDR 10/06/2013 DIT-715 #623 merge
    //              DDR 17/06/2013 DIT-715 #617 merge
    //              DDR 21/06/2013 DIT-715 #617 merge
    //              DDR 09/08/2013 DIT-770 #102 Modified 'LookupPageID' property field "Drink Tax Group"
    //                                          Added 'Tax Groups' Action into 'Relation' button
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #95 (Keep #102)
    // DITW17.00.02 AT  05/09/2013 DIT-770 #140 merge WHN-001 HIT0102
    //                             Add fields 2013762..213763 to set options for payment method/terms
    // DITW17.00.02 SR 06/09/2013 DIT-770 #134 : Add menuitem 'Fixed Asset List' (group 'Related Items')
    // DITW17.00.02 AT  09/09/2013 DIT-770 #146 merge WHN-001 HIT0005
    //                             Added field "Shipment Date Formula" on Shipping Group
    // DITW17.00.02 SR 10/09/2013 DIT-770 #143 : Added actions for change log view
    // DITW17.00.02 AT  12/09/2013 DIT-770 #132 merge WHN-006 HIT0122.1
    //                             New DIT fields Issue 212
    // DITW17.00.02 AT  12/09/2013 DIT-770 #154
    //                             Repositioned Shipment Method before Shipping Agent
    //                             Added fields
    //                             2014094 Invoice Method
    //                             2014095 Invoice Period
    //                             2014060 Picking Type
    //                             2014061 Truck Zone
    //                             2014063 Require 2 Driver
    //                             Added code to Make Editable/UnEditable Combine Shipment
    //                             Added code to autoset values for Combine Shipment
    //                             Added Action for Delivery Times Page
    //                             Added code for Drilldown on Route
    // DITW17.00.02 AT  24/09/2013 DIT-770 #132
    //                             Added Fields
    //                                   Free Item
    //                                   Free Reason Code
    // DITW17.00.02 AT  26/09/2013 DIT-770 #182
    //                             Added menuitem Delayed Promotions in Sales Menu
    // DITW17.00.02 AT  10/10/2013 DIT-770 #154
    //                             Added fields
    //                             2014064 Ship-to Address Key No.
    // DITW17.00.02 SR 10/10/2013 DIT-770 #205 : New Action "Telesales Call Update" Added
    // DITW17.00.02 RPG 05/11/2013 DIT-770 #235
    //                             Added New Fields "Bill-to Contact No.", "Bill-to Contact", "Invoice Address from", "Empty goods statement on",
    //                               "Accumulate items on Invoice", "Shipment specification" on Invoicing Fasttab
    //                             Added New Field "Delivery Note Copies" on Shipping Fasttab
    //                             Added Code in OnInit and ActivateFields function
    // DITW17.00.02 AT  14/11/2013 DIT-770 #154
    //                             Added fields
    //                             2014065 No. Of Route
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 12/05/2013 DIT-770 #151 : New Field Added "Starting Date" etc. in Communication Tab
    // DITW17.00.02 AT  17/12/2013 DIT-770 #163 : Added fields
    //                                   2034851 Loan Interest Cust. Post. Grp.
    //                                   2034852 Bank Charge Cust. Post. Grp.
    // DITW17.00.02 AT  23/01/2014 DIT-770 #189 : Added Fields in Drink-It Tab
    //                                             "Min HL Volume"
    //                                             "Min. Eq. UOM quantity"
    //                                             "Minimum Weight"
    // DITW17.00.03 DDR 13/02/2014 DIT-770 #389 Sales Conditions Report
    // DITW17.10.03 MSF 08/04/2014 DIT-770 #340 :DIT-770 340  Variable customer posting group  (Point 12 Remove Bank chagre cust. posting group)
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #623 New Customer Exception Tax Group functionality
    //                                          Added menu to "Customer Exception Tax Groups"
    // DITW17.10.03 MSF 10/06/2014 DIT-770 #728 : Deposit Tracking must be based on sell-to not bill-to
    //                                            Modify Action Empty Good tracking
    // DITW17.10.03 MSF 12/06/2014 DIT-770 #728  Remove Code
    // DITW17.10.03 DDR 13/06/14 DIT-770 #392 Item Quota Management Functionality
    //                                        Added menu "Quota Group","Item Quota Group"
    //                                        Added field "No. of Quota Groups"
    // DITW17.10.05 WSA 04/08/14 DIT-770 #761 : Added field "Invoice List Customer No."
    //                                          Added Action Invoice List
    // DITW17.10.05 MSF 15/08/2014 DIT-770 #862 Added field "Deposit Item Net Chg (LCY) src"
    // DITW17.10.05 YHE 02/09/2014 DIT-770 #754 : Add fields "Shipment Date Alert Filter",  "Shipment Status Alter Filter"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 05/05/2015 DIT-770 #1376 Delete caption for field Picking type
    // DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 look & feel design/functional issues: part 1: ribbons
    // DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214 Added Action Customer responsibility center relations
    // DITW18.00.06 MSF 16/07/2015 DIT-770 #1410 Added field "Our Account No."
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Modify DIT by Financial
    // DITW18.00.06 BCE 12/08/2015 DIT-770 #1535 Added field "Plant Maintenance Plant"
    // DITW18.00.06 MSF 20/08/2015 DIT-770 #1167 Captions : Double Route + Shipping tab customer (Part of redesign and Look&Feel)
    //                                                     Move field No. of routes to tab Shipping, under field Route.
    // DITW18.00.06 MVN 22/09/2015 DIT-770 #1524 Added StyleExpr on "Deposit Limit (LCY)"
    // DITW18.00.06A DDR 24/11/2015 DIT-770 #1701 Added fields "Credit Limit" (General tab)
    //                                                         "Deposit Limit" (Drinkit tab)
    //                                            Bugfix (see #1524) replace function SetStyle() by SetStyleDeposit()
    // DITW18.00.07 AKH 11/02/2016 DIT-770 #1804 Displayed field "Sundry Customer" under Invoicing tab
    // DITW18.00.07 KJB 18/02/2016 DIT-770 #1042 Add shortcut 'Ctrl+B' to comments menu button
    // DITW18.00.07 AKH 29/02/2016 DIT-770 #1425 Automatic Drop Shipments and Special orders: Added field "Purchasing Code"
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties
    // DITW18.00.07 AKH 28/03/2016 DIT-770 #1409 Added two fields "ExtDocNoMandatoryYes" & "ExtDocNoMandatoryNo"
    // DITW18.00.07 VSC 18/05/2016 DIT-770 #1972 Merge FINXL EDI Interface
    // FINXL8.00.001 IMI 10/06/2015: Added field GLN
    //               IMI 04/08/2015: Added field "Interface Partner"
    // DITW18.00.07 AKH 07/04/2016 DIT-770 #1042 Removed shortcut 'Ctrl+B' from comments menu button
    // DITW18.00.07 AKH 27/04/2016 DIT-770 #1346 Added field "Customer Delivery Type" under Shipping tab
    // DITW18.00.07 VSC 04/05/2016 DIT-770 #1968 Add Action Page Link "Delivery Times" where "Source Type" = Customer
    // DITW18.00.07 VSC 09/05/2016 DIT-770 #1968 Extended filter to Change on table "Route Combination" where "Source Type" = Customer
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW19.00.07 MSF 04/07/2016 DIT-770 #1965  Item and Item list/ customer and Customer List - navigate ribbon
    //                                            Check And fix  Ribbon
    // DITW18.00.07 DDR 01/07/2016 DIT-770 #1228 Added 'LookupPageID' property to field "Purchasing Code"
    // DITW19.00.08 AKH 20/09/2016 BL#10756 (DIT-770 #1215) Added field "Return Location Code" under tab Shipping

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 03/03/2017 NRQ#23042 Look&Feel review General tab
    //                                        Moved fields "Start/End Selling Date/Reason" into General tab
    //                                        Moved fields "External Document" into Invoice tab
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // IPLXL9.00.001 IMI 04/08/2015: Added field "Interface Partner"
    // FINXL9.00.001 MTR 15/09/2016 : Moved "Postal address" field from General to Communication Tab
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 MSF 07/07/2017 NRQ#16224 Return Registration part 3
    //                                  Added fields : "Empty Returned Items Based On"
    // DITW110.00.10 MSF 14/07/2017 NRQ#16224 Modify lookup Page for customerDeposit group
    // DITW110.00.11 AKH 02/11/2017 NRQ#43605 Added field "Loyalty Statement On", "Cross. Ref. on Del. Note" & "Exp. Date on Del. Note under Drink-It tab
    // DITW110.00.11 MSF 08/11/2017 NRQ#13577 Move Customer Template Under Name 2
    // DITW110.00.11 SFI 12/12/2017 NRQ#10509 Sales and purchase gross net prices
    // NRQ6581 MSF 14/03/2018 Pepperi Document Promotions Development
    //                        Added Action Promotion
    //                        Sales Promotion Breakdown
    //                        Report Sales Price-Breakdown List
    // NRQ61583 MSF 04/06/18 Added fields "Last Net sales price"

    // HEI.01 FDD-OTCGAP057 IBM.NAIKH01 29-06-2017
    //   # Added a new Field "Blocked Reason Code"
    // HEI.02 FDD-OTCGAP060 IBM.NAIKH01 30-06-2017
    //   # Added a new Field "Netting Agreement"
    //   # Added a new Field "Vendor No"
    // HEI.03 FDD-OTCGAP015a IBM.ISYED01 10-07-2017
    //   # Added a new Field "Risk indicator"
    // HEI.04 FDD-HNK-HeiliteBASE-FDD-OTCGAP016b IBM ISYED01 10/07/2017
    //   # added code blocked reason code is selected without a block on the customer, the user will receive an error.
    //   # When a customer is blocked ( so a value in the blocked field is selected) the user cannot close the page until selecting a reason code.
    // HEI.05 FDD-HNK-HeiliteBASE-OTCGAP030 IBM ISYED01 04/07/2017
    //   # added Blocked Reason Code” filed
    // HEI.06 FDD-SLSGAP001 IBM POENAB01 19.08.2017 # MDM Customer Card
    //   # added "Blockage Reason" and Litigious in General Group
    //   # added group Foreign Trade
    //   # added fields "Tax Registration Number", "National Identity Card", "Approval Of Alcohol", "Trade Register" in Foreign Trade group
    //   # added field "WHT Business Posting Group"
    //   # added field "Return Order Mandatory"
    //   # added action "Customer Attributes"
    // HEI.07 FDD-SLSGAP001 IBM POENAB01 19.08.2017 # MDM Customer Card
    //   # Added action "Copy Dimensions to Default Dimensions"
    // HEI.08 FDD-SLSGAP001 IBM POENAB01 28.08.2017 # MDM Customer Card
    //   # Added field "Account Group FND" in General tab
    // HEI.09 FDD-SLSGAP001 IBM NASTAA02 14.09.2017 # MDM Customer Card
    //   # Created function "CreateCustomerFromCustomerTemplate" to choose one Customer Template when creating a new Customer
    // HEI.10 FDD-SLSGAP001 IBM NASTAA02 06.10.2017 # MDM Customer Card
    //   # Removed some fields
    // HEI.11 FDD FDD-KDDOTC007 IBM.NAIKH01 11.10.2017
    //   # Added New Fields "Open Sales RPM Value" and "RPM Exposure"
    //   # Added New code on trigger "OnAfterGetRecord"
    // HEI.12 FDD FDD-KDDOTC003 IBMIsyed01 11.10.2017
    //   #added new fields "Additional RPM Return","Packaging Credit Value (PCV)","FFE Security Amount","Check FFE Bal/FFE security Amt"
    // HEI.13 FDD-KDD0TC005 IBM NASTAA02 09.11.2017 # RPM Billing and Reporting
    //   # New page action created to run the report RPM Balance Accounting
    // HEI.14 Defect #1066 IBM NASTAA02 23.11.2017 # Bank sensitive details change
    //   # New field added "Sensitive Block"
    // HEI.15 Bugfixing IBM NASTAA02 04.01.2018 # Local Algeria
    //   # Deleted field 50006 - Blockage Reason
    // HEI.16 FDD-HNK LOGGAP001 03/02/2018 IBM.CHAUHB01
    //   # Display Field "Sales Routes" under Route TAB
    // HEI.17 FDD PTPGAP084 IBM POSTOI01 05.04.2018
    //   # show new field "Sensitive Workflow Block"
    // HEI.18 FDD-OTCGAP075 IBM NASTAA02 15.05.2018 # No dependency between respective credit risk Master Date fields in the system
    //   # Made Field "Risk Category" non editable
    // HEI.19 FDD Indirect Customer Master IBM.NAIKH01 28.09.2018
    //     # Added a new field "Contract Type" and "Customer Relationship"
    //   # Added code on trigger OnOpenPage() and OnAfterGetRecord().
    //   # Added code on Function "CreateCustomerFromCustomerTemplate"
    // HEI.21 RFC-CHG0255777 IBM.LS 17.12.2018
    //   # New Fields added: "Min. Order Value Limit"
    //                       "Min. Order Value Limit Type"
    // HEI.22 RFC-CHG0264361 IBM.AB 20.12.2018
    //   # New Fields added: "Trading End Date"
    //   # Code added for Trading End Date enablement
    // HEI.23 FDD-BA-SLSGAP02 IBM NASTAA02 08.01.2018 # County Code
    //   # Added Field "County"
    //   HEI.25 FDD RPM Breakages IBM ISYED01 03.06.2019
    //   # added new filed Compensate RPM Differences
    // HEI.26 FDD-SR_HT464-ORTEC IBM HORTOC01 # new action created "Handling Time & Trucks" & new fields added "Longitude Coordinate" + "Latitude Coordinate"
    // HEI.27 FDD-ET-HT695 IBM NASTAA02 05.07.2019 # RPM Payment Reconciliation and Offset
    //   # New Field added: "Deposit Payment Quantity"
    // HEI.28 Defect #4021 IBM NASTAA02 10.07.2019 # Field Contract Type on customer card is not active to edit
    //   # Code added on OnValidate Trigger of "Account Group FND" Field to update "Contract Type" Edit Property
    // HEI.29 FDD-HT658 IBM.GUNERE01 23.09.2019 # "No. of Shipping Agent Rel." field added
    // HEI.30 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Code added in OnOpenPage, OnAfterGetCurrRecord
    //   # New action "<Page Payment Addresses>" in ActionGroup BTCust
    //   # Fields added in Payments group: "Balance (LCY)", "Payment in progress (LCY)", "Balance (LCY)" - "Payment in progress (LCY)"
    // HEI.31 RFC-CHG2007388 IBM.KUMARN15 12.09.2019
    //   # Code change in function CreateCustomerFromCustomerTemplate
    // HEI.32 CHG2035637 IBM.LS 14.01.2020
    //   # Code added to update the following fields Blocked and "Blocked Reason Code".
    // HEI.33  FDD-HB1609 CHG2074002 IBM BULIMC01 26.08.2020 #new boolean field added to the "Deposits & Empty Goods" tab: "Free Goods Accounting (HNK)"
    // HEI.34 CHG2091356 SAMANR01 07.01.2021
    //   # Code added to update customer default dimension when send for approval
    // HEI.35 CHG2129700 INC3758798 IBM GAVANM01 06.10.2021 #SEM ID is not available for Mendix
    //   # SEM ID added in the General tab

    // HEI.36 CHG2171412 MARTIR52 IBM 20.08.2022 #CustomerCard Slow:
    //   # RefreshonActivate property disabled
    // HEI.37 CHG2178940 IBM COSTES04  16.01.2023 # Add Required Freshness field on Customer Card
    //   # Add new field Required Freshness
    // HEI.38 CHG2194603 HB3289 COSTES04 15.11.2023 Electronic invoice interface
    //   # New fields Reg. Structure Grouping Code, Reg. Structure Grouping Description
    // HEI.39 CHG2228480-HB3631 COSTES04 17.04.2024 Sierra Leone Automate the separation of deposit and finish product
    //   # New action Customer Statement
    // HEI.40 CHG2320253 NANDIS03 02.09.2025 #Customer card performance optimization
    //   # Setcurrentkey added to optimize the customer card open function

    // version NAVW111.00.00.21836,FINXL10.01,IPLXL9.00.001,DITW111.00.13,NRQ#101918,HEI.40
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea Property in All fields and Actions.
    // 2. Remove Drink-IT Actions , Fields and Related code.
    // 3. Remove Drink-IT Groups.
    // 4. Migrate Related Codeunits , Pages and Reports
    // 5. Remove Duplicate Actions and Fields
    // 6. Comment function CreateCustomerFromTemplate and replace with CreateCustomerFromCustomerTemplate with the help of this event (OnBeforeCreateCustomerFromTemplate)
    // BC Upgrade BHARDA11 <<

    // BC Upgrade SHUKLP03 >> OTC008 Testscript changes.

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.', FRA = 'Spécifie le numéro du client. Le champ est renseigné automatiquement à partir d''une souche de numéros définie, ou vous saisissez manuellement le numéro, car vous avez activé la saisie manuelle de numéro dans le paramétrage de la souche de numéros.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the customer''s name. This name will appear on all sales documents for the customer. You can enter a maximum of 50 characters, both numbers and letters.', FRA = 'Spécifie le nom du client. Ce nom apparaîtra sur tous les documents vente destinés au client. Vous pouvez entrer au maximum 50 caractères, des chiffres et des lettres.';
        }
        modify("Name 2")
        {
            Importance = Promoted;
            Visible = true;
        }
        moveafter("Search Name"; "Name 2")
        // moveafter("Name 2"; CreditLimit)
        // modify("Name 2";)
        moveafter("IC Partner Code"; "Salesperson Code")
        moveafter("Salesperson Code"; "Responsibility Center")
        moveafter("Responsibility Center"; "Service Zone Code")
        moveafter("Service Zone Code"; "Document Sending Profile")
        moveafter("Document Sending Profile"; CreditLimit)
        moveafter(CreditLimit; "Credit Limit (LCY)")
        moveafter("Credit Limit (LCY)"; Blocked)
        // moveafter(Blocked;"Blocked Reason Code")
        moveafter("Balance (LCY)"; "Balance Due (LCY)")
        moveafter("Address 2"; "Post Code")
        moveafter("Post Code"; City)
        moveafter(City; County)

        // moveafter()
        modify("Search Name")
        {
            Importance = Promoted;
            Visible = true;
            ToolTipML = ENU = 'Specifies an alternate name that you can use to search for a customer.', FRA = 'Spécifie un autre nom que vous pouvez utiliser pour chercher un client.';
        }
        modify("IC Partner Code")
        {
            ToolTipML = ENU = 'Specifies the customer''s IC partner code, if the customer is one of your intercompany partners.', FRA = 'Spécifie le code de partenaire IC du client si ce dernier est l''un de vos partenaires intersociétés.';
        }
        modify("Balance (LCY)")
        {
            ToolTipML = ENU = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.', FRA = 'Spécifie le montant règlement que le client doit régler pour les ventes terminées. Cette valeur est également appelée le solde du client.';
        }
        modify("Balance Due (LCY)")
        {
            ToolTipML = ENU = 'Specifies payments from the customer that are overdue per today''s date.', FRA = 'Spécifie les paiements effectués par le client échus pour la date du jour.';
        }
        modify("Credit Limit (LCY)")
        {
            ToolTipML = ENU = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.', FRA = 'Spécifie le montant maximal selon lequel vous autorisez au client à dépasser le solde de paiement avant que des alertes ne soient émises.';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies which transactions with the customer that cannot be blocked, for example, because the customer is insolvent.', FRA = 'Spécifie les transactions avec le client qui ne peuvent pas être bloquées, par exemple, parce que le client est déclaré insolvable.';
        }
        modify("Salesperson Code")
        {
            ToolTipML = ENU = 'Specifies a code for the salesperson who normally handles this customer''s account.', FRA = 'Spécifie un code pour le vendeur qui s''occupe habituellement du compte de ce client.';
        }
        modify("Responsibility Center")
        {
            ToolTipML = ENU = 'Specifies the code for the responsibility center that will administer this customer by default.', FRA = 'Spécifie le code du centre de gestion qui gère ce client par défaut.';
        }
        modify("Service Zone Code")
        {
            ToolTipML = ENU = 'Contains the code for the service zone that is assigned to the customer.', FRA = 'Contient le code de la zone service affectée au client.';
        }

        modify("Document Sending Profile")
        {
            ToolTipML = ENU = 'Specifies the preferred method of sending documents to this customer, so that you do not have to select a sending option every time that you post and send a document to the customer. Sales documents to this customer will be sent using the specified sending profile and will override the default document sending profile.', FRA = 'Spécifie la méthode préférée d''envoi de documents à ce client afin que vous n''ayez pas à sélectionner une option d''envoi chaque fois que vous validez et envoyez un document au client. Les documents vente à ce client seront envoyés en utilisant le profil d''envoi spécifié et remplaceront le profil d''envoi de document par défaut.';
        }
        modify(TotalSales2)
        {
            CaptionML = ENU = 'Total Sales', FRA = 'Total des ventes';
            ToolTipML = ENU = 'Specifies your total sales turnover with the customer in the current fiscal year. It is calculated from amounts excluding VAT on all completed and open invoices and credit memos.', FRA = 'Spécifie votre rotation totale des ventes avec le client au cours de l''exercice comptable en cours. Il est calculé à partir des montants HT sur toutes les factures et avoirs terminés et ouverts.';
        }
        modify("CustSalesLCY - CustProfit - AdjmtCostLCY")
        {
            CaptionML = ENU = 'Costs (LCY)', FRA = 'Coûts DS';
            ToolTipML = ENU = 'Specifies how much cost you have incurred from the customer in the current fiscal year.', FRA = 'Spécifie les coûts que vous avez subis pour le client pour l''exercice comptable en cours.';
        }
        modify(AdjCustProfit)
        {
            CaptionML = ENU = 'Profit (LCY)', FRA = 'Marge DS';
            ToolTipML = ENU = 'Specifies how much profit you have made from the customer in the current fiscal year.', FRA = 'Spécifie la marge que vous avez réalisée pour le client pour l''exercice comptable en cours.';
        }
        modify(AdjProfitPct)
        {
            CaptionML = ENU = 'Profit %', FRA = '% marge sur vente';
            ToolTipML = ENU = 'Specifies how much profit you have made from the customer in the current fiscal year, expressed as a percentage of the customer''s total sales.', FRA = 'Spécifie la marge que vous avez réalisée pour le client pour l''exercice comptable en cours, exprimée en pourcentage des ventes totales du client.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the customer card was last modified.', FRA = 'Indique la date à laquelle la fiche client a été modifiée pour la dernière fois.';
        }
        modify("Address & Contact")
        {
            CaptionML = ENU = 'Address & Contact', FRA = 'Adresse et contact';
        }
        modify(AddressDetails)
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
        }
        modify(Address)
        {
            ToolTipML = ENU = 'Specifies the customer''s address. This address will appear on all sales documents for the customer.', FRA = 'Spécifie l''adresse du client. Cette adresse s''affiche sur tous les documents de vente pour le client.';

            //Unsupported feature: Change ImplicitType on "Address(Control 6)". Please convert manually.

        }
        modify("Address 2")
        {
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Address 2"(Control 8)". Please convert manually.

        }
        modify("Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify(City)
        {
            ToolTipML = ENU = 'Specifies the customer''s city.', FRA = 'Spécifie la ville du client.';

            //Unsupported feature: Change ImplicitType on "City(Control 10)". Please convert manually.

        }
        modify("Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region of the address.', FRA = 'Spécifie le pays/la région de l''adresse.';
        }
        modify(ShowMap)
        {
            ToolTipML = ENU = 'Specifies the customer''s address on your preferred map website.', FRA = 'Spécifie l''adresse du client sur votre site Web de mappage par défaut.';
        }
        modify(ContactDetails)
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        moveafter(ContactName; "Phone No.")
        moveafter("Phone No."; "E-Mail")
        moveafter("E-Mail"; "Fax No.")
        moveafter("Fax No."; "Home Page")
        addafter("Home Page")
        {
            field("Our Account No."; Rec."Our Account No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Our Account No. field.';
            }
        }
        moveafter("Our Account No."; "Language Code")

        modify("Primary Contact No.")
        {
            CaptionML = ENU = 'Primary Contact Code', FRA = 'Code contact principal';
            ToolTipML = ENU = 'Specifies the primary contact number for the customer.', FRA = 'Spécifie le numéro de contact principal du client.';
        }
        modify(ContactName)
        {
            CaptionML = ENU = 'Contact Name', FRA = 'Nom contact';
            ToolTipML = ENU = 'Specifies the name of the person you regularly contact when you do business with this customer.', FRA = 'Spécifie le nom de la personne que vous contactez régulièrement lorsque vous traitez avec ce client.';
        }
        modify("Phone No.")
        {
            ToolTipML = ENU = 'Specifies the customer''s telephone number.', FRA = 'Spécifie le numéro de téléphone du client.';
        }
        modify("E-Mail")
        {
            ToolTipML = ENU = 'Specifies the customer''s email address.', FRA = 'Spécifie l''adresse de messagerie du client.';
        }
        modify("Fax No.")
        {
            ToolTipML = ENU = 'Specifies the customer''s fax number.', FRA = 'Spécifie le numéro de télécopie du client.';
        }
        modify("Home Page")
        {
            ToolTipML = ENU = 'Specifies the customer''s home page address.', FRA = 'Spécifie la page d''accueil du client.';
        }
        modify("Language Code")
        {
            ToolTipML = ENU = 'Specifies the language to be used on printouts for this customer.', FRA = 'Spécifie la langue à utiliser sur des impressions destinées à ce client.';
        }
        modify(Invoicing)
        {
            CaptionML = ENU = 'Invoicing', FRA = 'Facturation';
        }
        modify("Bill-to Customer No.")
        {
            CaptionML = ENU = 'Bill-to Customer', FRA = 'Client facturé';
            ToolTipML = ENU = 'Specifies a different customer who will be invoiced for products that you sell to the customer in the Name field on the customer card.', FRA = 'Spécifiez un autre client qui sera facturé pour les produits que vous vendez au client dans le champ Nom de la fiche client.';
        }
        modify("VAT Registration No.")
        {
            ToolTipML = ENU = 'Specifies the customer''s VAT registration number for customers in EU countries/regions.', FRA = 'Spécifie le numéro d''identification intra-communautaire du client dans des pays/régions de l''Union européenne.';
        }
        moveafter("VAT Registration No."; GLN)
        modify("EORI Number")
        {
            Visible = false;
        }
        modify("Use GLN in Electronic Document")
        {
            Visible = false;
        }

        modify(GLN)
        {
            ToolTipML = ENU = 'Specifies the customer in connection with electronic document sending.', FRA = 'Spécifie le client en relation avec l''envoi de documents électroniques.';
        }
        modify("Copy Sell-to Addr. to Qte From")
        {

            ToolTipML = ENU = 'Specifies which customer address is inserted on sales quotes that you create for the customer.', FRA = 'Spécifie que l''adresse client est insérée sur les devis que vous créez pour ce client.';
        }
        addafter("Copy Sell-to Addr. to Qte From")
        {
            field("Invoice Copies"; Rec."Invoice Copies")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Invoice Copies field.';
            }
        }


        modify(PricesandDiscounts)
        {
            CaptionML = ENU = 'Prices and Discounts', FRA = 'Prix et remises';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the default currency for the customer.', FRA = 'Spécifie la devise par défaut pour le client.';
        }
        modify("Customer Price Group")
        {
            ToolTipML = ENU = 'Specifies the customer price group code, which you can use to set up special sales prices in the Sales Prices window.', FRA = 'Spécifie le code groupe prix client que vous pouvez utiliser pour configurer des prix spécifiques dans la fenêtre Prix vente.';
        }
        modify("Customer Disc. Group")
        {
            ToolTipML = ENU = 'Specifies the customer discount group code, which you can use as a criterion to set up special discounts in the Sales Line Discounts window.', FRA = 'Spécifie le code groupe remises client que vous pouvez utiliser comme critère pour configurer des remises spécifiques dans la fenêtre Remises ligne vente.';
        }
        modify("Allow Line Disc.")
        {
            ToolTipML = ENU = 'Specifies if a sales line discount is calculated when a special sales price is offered according to setup in the Sales Prices window.', FRA = 'Spécifie si une remise ligne vente est calculée lorsqu''un prix vente spécial est proposé en fonction du paramétrage de la fenêtre Prix vente.';
        }
        modify("Invoice Disc. Code")
        {
            ToolTipML = ENU = 'Specifies a code for the invoice discount terms that you have defined for the customer.', FRA = 'Spécifie un code pour les conditions de remise facture que vous avez définies pour le client.';
        }
        modify("Prices Including VAT")
        {
            ToolTipML = ENU = 'Specifies if the Unit Price and Line Amount fields on sales lines for this customer should be shown with or without VAT.', FRA = 'Spécifie si les champs Prix unitaire et Montant ligne sur les lignes vente pour ce client doivent être affichés avec ou sans la TVA.';
        }
        modify(Payments)
        {
            CaptionML = ENU = 'Payments', FRA = 'Paiements';
        }
        modify("Prepayment %")
        {
            ToolTipML = ENU = 'Contains a prepayment percentage that applies to all orders for this customer, regardless of the items or services on the order lines.', FRA = 'Contient un pourcentage acompte s''appliquant à toutes les commandes de ce client, indépendamment des articles ou des services figurant sur les lignes commande.';
        }
        modify("Application Method")
        {
            ToolTipML = ENU = 'Specifies how to apply payments to entries for this customer.', FRA = 'Spécifie la manière de lettrer des paiements avec des écritures pour ce client.';
        }
        modify("Partner Type")
        {
            ToolTipML = ENU = 'Specifies for direct debit collections if the customer that the payment is collected from is a person or a company.', FRA = 'Spécifie, pour les recouvrements prélèvement, si le client auprès duquel le paiement est collecté est une personne ou une société.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies a code that indicates the payment terms that you require of the customer.', FRA = 'Spécifie un code qui indique les conditions de paiement que vous exigez du client.';
        }
        modify("Payment Method Code")
        {
            ToolTipML = ENU = 'Specifies how the customer usually submits payment, such as bank transfer or check.', FRA = 'Spécifie le mode de paiement généralement utilisé par le client, tel que par virement bancaire ou par chèque.';
        }
        modify("Reminder Terms Code")
        {
            ToolTipML = ENU = 'Specifies how reminders about late payments are handled for this customer.', FRA = 'Spécifie la manière dont les relances concernant les retards de paiement sont traitées pour ce client.';
        }
        modify("Fin. Charge Terms Code")
        {
            ToolTipML = ENU = 'Specifies finance charges are calculated for the customer.', FRA = 'Spécifie les intérêts calculés pour le client.';
        }
        modify("Cash Flow Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies a payment term that will be used to calculate cash flow for the customer.', FRA = 'Spécifie les conditions de paiement qui serviront à calculer la trésorerie pour le client.';
        }
        modify("Print Statements")
        {
            ToolTipML = ENU = 'Specifies whether to include this customer when you print the Statement report.', FRA = 'Spécifie s''il faut inclure ou non ce client lorsque vous imprimez le relevé de compte.';
        }
        modify("Last Statement No.")
        {
            ToolTipML = ENU = 'Specifies the number of the last statement that was printed for this customer.', FRA = 'Spécifie le numéro du dernier relevé imprimé pour ce client.';
        }
        modify("Block Payment Tolerance")
        {
            ToolTipML = ENU = 'Specifies that the customer is not allowed a payment tolerance.', FRA = 'Spécifie que le client n''a droit à aucun écart de règlement.';
        }
        modify("Preferred Bank Account Code")
        {
            ToolTipML = ENU = 'Specifies the customer''s bank account that will be used by default when you process refunds to the customer and direct debit collections.', FRA = 'Spécifie le compte bancaire client qui sera utilisé par défaut lorsque vous traitez des remboursements client et des collections prélèvement automatique.';
        }
        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping', FRA = 'Livraison';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies from which location sales to this customer will be processed by default.', FRA = 'Spécifie à partir de quel magasin les ventes à ce client seront traitées par défaut.';
        }
        modify("Combine Shipments")
        {
            ToolTipML = ENU = 'Specifies if several orders delivered to the customer can appear on the same sales invoice.', FRA = 'Spécifie si plusieurs commandes livrées au client peuvent se trouver sur la même facture vente.';

            //Unsupported feature: Change Editable on ""Combine Shipments"(Control 32)". Please convert manually.

        }
        modify(Reserve)
        {
            ToolTipML = ENU = 'Specifies whether items will never, automatically (Always), or optionally be reserved for this customer.', FRA = 'Spécifie si les articles ne seront jamais réservés ou seront réservés automatiquement (toujours) ou éventuellement pour ce client.';
        }
        modify("Shipping Advice")
        {
            ToolTipML = ENU = 'Specifies if the customer accepts partial shipment of orders.', FRA = 'Spécifie si le client accepte l''expédition partielle des commandes.';
        }
        modify("Shipment Method")
        {
            CaptionML = ENU = 'Shipment Method', FRA = 'Conditions de livraison';
        }
        moveafter("Shipment Method Code"; "Shipping Agent Code")
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            ToolTipML = ENU = 'Specifies which shipment method to use when you ship items to the customer.', FRA = 'Spécifie les conditions de livraison à utiliser lorsque vous livrez des articles à ce client.';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Agent', FRA = 'Agent';
            ToolTipML = ENU = 'Specifies which shipping company is used when you ship items to the customer.', FRA = 'Spécifie le transporteur utilisé lorsque vous livrez des articles à ce client.';
        }
        modify("Shipping Agent Service Code")
        {
            CaptionML = ENU = 'Agent Service', FRA = 'Service agent';
            ToolTipML = ENU = 'Specifies the code for the shipping agent service to use for this customer.', FRA = 'Spécifie le code prestation transporteur à utiliser pour ce client.';
        }
        modify("Shipping Time")
        {

            //Unsupported feature: Change Level on ""Shipping Time"(Control 119)". Please convert manually.

            ToolTipML = ENU = 'Specifies the shipping time of the order.', FRA = 'Spécifie le délai d''expédition de la commande.';
        }
        modify("Base Calendar Code")
        {

            //Unsupported feature: Change Level on ""Base Calendar Code"(Control 141)". Please convert manually.

            ToolTipML = ENU = 'Specifies a customizable calendar for shipment planning that holds the customer''s working days and holidays.', FRA = 'Spécifie un calendrier personnalisable pour la planification d''expédition qui contient les vacances et jours ouvrés du client.';
        }
        modify("Customized Calendar")
        {

            //Unsupported feature: Change Level on ""Customized Calendar"(Control 146)". Please convert manually.

            CaptionML = ENU = 'Customized Calendar', FRA = 'Calendrier personnalisé';
            ToolTipML = ENU = 'Specifies that you have set up a customized version of a base calendar.', FRA = 'Spécifie que vous avez configuré une version personnalisée d''un calendrier de base.';
        }

        modify(Balance)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
        }
        modify("Balance (LCY)2")
        {
            CaptionML = ENU = 'Money Owed - Current', FRA = 'Montant dû - Actuel';
            ToolTipML = ENU = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.', FRA = 'Spécifie le montant règlement que le client doit régler pour les ventes terminées. Cette valeur est également appelée le solde du client.';
        }


        modify(TotalMoneyOwed)
        {
            CaptionML = ENU = 'Money Owed - Total', FRA = 'Montant dû - Total';
            ToolTipML = ENU = 'Specifies the payment amount that the customer owes for completed sales plus sales that are still ongoing. The value is the sum of the values in the Money Owed - Current and Money Owed - Expected fields.', FRA = 'Spécifie le montant des paiements que le client doit pour les ventes terminées plus les ventes qui sont encore en cours. La valeur correspond à la somme des valeurs dans les champs Montant dû - Actuel et Montant dû - Prévu.';
        }
        modify(CreditLimit)
        {
            CaptionML = ENU = 'Credit Limit', FRA = 'Crédit autorisé';
            ToolTipML = ENU = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.', FRA = 'Spécifie le montant maximal selon lequel vous autorisez au client à dépasser le solde de paiement avant que des alertes ne soient émises.';
        }
        modify(CalcCreditLimitLCYExpendedPct)
        {
            CaptionML = ENU = 'Usage Of Credit Limit', FRA = 'Utilisation du crédit autorisé';
            ToolTipML = ENU = 'Specifies how much of the customer''s payment balance consists of credit.', FRA = 'Spécifie la partie de crédit du solde de paiement du client.';
        }
        modify(Control108)
        {
            CaptionML = ENU = 'Payments', FRA = 'Paiements';
        }
        modify("Balance Due")
        {
            ToolTipML = ENU = 'Specifies the sum of outstanding payments from the customer.', FRA = 'Spécifie la somme des paiements en attente de la part des clients.';
        }
        modify("Payments (LCY)")
        {
            CaptionML = ENU = 'Payments This Year', FRA = 'Paiements cette année';
            ToolTipML = ENU = 'Specifies the sum of payments received from the customer in the current fiscal year.', FRA = 'Spécifie la somme des paiements reçus du client pour l''exercice comptable en cours.';
        }
        modify("CustomerMgt.AvgDaysToPay(""No."")")
        {
            CaptionML = ENU = 'Average Collection Period (Days)', FRA = 'Délai de règlement moyen (jours)';
            ToolTipML = ENU = 'Specifies how long the customer typically takes to pay invoices in the current fiscal year.', FRA = 'Spécifie combien de temps il faut généralement au client pour payer ses factures au cours de l''exercice comptable actuel.';
        }
        modify(DaysPaidPastDueDate)
        {
            CaptionML = ENU = 'Average Late Payments (Days)', FRA = 'Moyenne retard de paiements (jours)';
            ToolTipML = ENU = 'Specifies the average number of days the customer is late with payments.', FRA = 'Spécifie le nombre moyen de jours de retard de paiement du client.';
        }
        modify("Sales This Year")
        {
            CaptionML = ENU = 'Sales This Year', FRA = 'Ventes cette année';
        }
        // BC Upgrade BHARDA11 >> ---NOt Found in BC
        // modify(GetAmountOnPostedInvoices)
        // {
        //     ToolTipML = ENU = 'Specifies your sales to the customer in the current fiscal year based on posted sales invoices. The figure in parenthesis Specifies the number of posted sales invoices.', FRA = 'Spécifie vos ventes au client pendant l''exercice comptable en cours en fonction des factures vente enregistrées. Le chiffre entre parenthèses indique le nombre de factures vente enregistrées.';
        // }
        // modify(GetAmountOnCrMemo)
        // {
        //     ToolTipML = ENU = 'Specifies your expected refunds to the customer in the current fiscal year based on posted sales credit memos. The figure in parenthesis shows the number of posted sales credit memos.', FRA = 'Spécifie vos remboursements prévus au client pendant l''exercice comptable en cours en fonction d''avoirs vente enregistrés. Le chiffre entre parenthèses indique le nombre d''avoirs vente enregistrés.';
        // }
        // modify(GetAmountOnOutstandingInvoices)
        // {
        //     ToolTipML = ENU = 'Specifies your expected sales to the customer in the current fiscal year based on ongoing sales invoices. The figure in parenthesis shows the number of ongoing sales invoices.', FRA = 'Spécifie vos ventes prévues au client pendant l''exercice comptable en cours en fonction des factures vente en cours. Le chiffre entre parenthèses indique le nombre de factures vente en cours.';
        // }
        // modify(GetAmountOnOutstandingCrMemos)
        // {
        //     ToolTipML = ENU = 'Specifies your refunds to the customer in the current fiscal year based on ongoing sales credit memos. The figure in parenthesis shows the number of ongoing sales credit memos.', FRA = 'Spécifie vos remboursements au client pendant l''exercice comptable en cours en fonction d''avoirs vente en cours. Le chiffre entre parenthèses indique le nombre d''avoirs vente en cours.';
        // }
        // BC Upgrade BHARDA11 << ---NOt Found in BC
        modify(Totals)
        {
            CaptionML = ENU = 'Total Sales', FRA = 'Total des ventes';
            ToolTipML = ENU = 'Specifies your total sales turnover with the customer in the current fiscal year. It is calculated from amounts excluding VAT on all completed and open invoices and credit memos.', FRA = 'Spécifie votre rotation totale des ventes avec le client au cours de l''exercice comptable en cours. Il est calculé à partir des montants HT sur toutes les factures et avoirs terminés et ouverts.';
        }
        modify(CustInvDiscAmountLCY)
        {
            CaptionML = ENU = 'Invoice Discounts', FRA = 'Remises facture';
            ToolTipML = ENU = 'Specifies the total of all invoice discounts that you have granted to the customer in the current fiscal year.', FRA = 'Spécifie le total de toutes les remises facture que vous avez accordées au client pour l''exercice comptable en cours.';
        }
        // modify(PriceAndLineDisc)
        // {
        //     CaptionML = ENU = 'Special Prices & Discounts', FRA = 'Prix et remises spéciaux';
        // }
        modify(Details)
        {
            CaptionML = ENU = 'Details', FRA = 'Détails';
        }

        //Unsupported feature: PropertyDeletion on ""Search Name"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Search Name"(Control 18)". Please convert manually.


        //Unsupported feature: CodeInsertion on ""Combine Shipments"(Control 32)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
        if "Invoice Method" <> "Invoice Method"::" " then
          blnEditable := false
        else
          blnEditable := true;

        if (("Invoice Method" <> "Invoice Method"::"Combine Shipments") or
           ("Invoice Method" <> "Invoice Method"::"Combine Shipments Per Sell-to")) then
          "Combine Shipments" := true;

        if (("Invoice Method" <> "Invoice Method"::Shipment) or
           ("Invoice Method" <> "Invoice Method"::Order)) then
          "Combine Shipments" := false;
        //>>DITW17.00.02 TEC1 DIT-770 #154
        */
        //end;

        addafter("No.")
        {
            // field("Customer Template Code"; Rec."Customer Template Code")
            // {
            //     Importance = Additional;
            // }
            field("Account Group FND"; Rec."Account Group FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Account Group field.';
                trigger OnValidate();
                begin
                    //HEI.22>>
                    if Rec."Account Group FND" <> xRec."Account Group FND" then begin
                        if (Rec."Account Group FND" <> '') and (CustaccountGroup.GET(Rec."Account Group FND")) then begin
                            if CustaccountGroup."Trading End Date Enable" then
                                TEDIsEditable := true
                            else
                                TEDIsEditable := false;
                        end;
                        //HEI.28>>
                        if (Rec."Account Group FND" <> '') and AccountGroup.GET(Rec."Account Group FND") then
                            Vsb := AccountGroup."Contract type Editable";
                        //HEI.28<<
                    end;
                    //HEI.22<<
                end;
            }
        }
        // moveafter("Search Name"; "Name 2")

        addafter("Document Sending Profile")
        {
            field("Send Document"; Rec."Send Document FND") // BC Upgrade SHUKLP03 << OTC008
            {
                ApplicationArea = All;
                Caption = 'Send Document';
                Importance = Additional;
                OptionCaptionML = ENU = ' ,Mail,Print,Mail & print',
                                  FRA = ' ,E-Mail,Imprimer,E-Mail & Imprimer';
            }

            // BC Upgrade BHARDA11 >> ----Drink-IT Fields
            // field("Send Document"; Rec."Send Document")
            // {
            //     Importance = Additional;
            //     OptionCaptionML = ENU = ' ,Mail,Print,Mail & print',
            //                       FRA = ' ,E-Mail,Imprimer,E-Mail & Imprimer';
            // }
            // field("Credit Limit"; Rec."Credit Limit")
            // {

            //     trigger OnValidate();
            //     begin
            //         // <<DITW18.00.06A DDR 24/11/2015 DIT-770 #1701
            //         StyleTxt := SetStyle;
            //         // >>DITW18.00.06A DDR DIT-770 #1701
            //     end;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields

        }
        addafter(Blocked)
        {
            field("Blocked Reason Code"; Rec."Blocked Reason Code FND")
            {
                ApplicationArea = All;
                LookupPageID = "Blocked Reasons";
                ToolTip = 'Specifies the value of the Blocked Reason Code field.';
            }
            // BC Upgrade BHARDA11 >> Enable French Localization
            // field(BlockedCustomer; BlockedCustomer)
            // {
            //     ApplicationArea = All;
            //     Visible = FoundationOnly;
            //     Enabled = DynamicEditable;
            //     Caption = 'Blocked';
            //     // ApplicationArea = All;
            // }
            // BC Upgrade BHARDA11 << Enable French Localization

            field("Sensitive Payment Block"; Rec."Sensitive Payment Block FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sensitive Payment Block field.';
            }
            field("Sensitive Workflow Block"; Rec."Sensitive Workflow Block FND")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Sensitive Workflow Block field.';
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields
            // field("Plant Maintenance Plant"; Rec."Plant Maintenance Plant")
            // {
            // }
            // field("Sundry Customer"; Rec."Sundry Customer")
            // {
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields
        }

        addafter("Balance Due (LCY)")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields 
            // field("Deposit Cust. Balance (LCY)"; Rec."Deposit Cust. Balance (LCY)")
            // {

            //     trigger OnDrillDown();
            //     var
            //         CustDeposit: Record Customer;
            //     begin
            //         // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 - DITW110.00.08 DDR 02/01/2017 NRQ#0
            //         CustDeposit.COPY(Rec);
            //         CustDeposit.SETRANGE("Item Charge Type Filter", "Item Charge Type Filter"::Deposit);
            //         CustDeposit.OpenCustomerLedgerEntries(false);
            //     end;
            // }
            // field("Deposit Item Balance (LCY)"; Rec."Deposit Item Balance (LCY)")
            // {
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields
            field("Deposit Payment Quantity"; Rec."Deposit Payment Quantity FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Deposit Payment Quantity field.';
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Field
            // field("Deposit Item Net Chg (LCY) src"; Rec."Deposit Item Net Chg (LCY) src")
            // {
            //     Description = '<DTI-770 #705>- MSF ';
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Field

        }
        moveafter("Deposit Payment Quantity"; TotalSales2)

        addafter("Last Date Modified")
        {
            field("Risk Category"; Rec."Risk Category FND")
            {
                ApplicationArea = All;
                LookupPageID = "Risk Grades CBN";
                ToolTip = 'Specifies the value of the Risk Category field.';
            }
            field("Risk Score"; Rec."Risk Score FND")
            {
                ApplicationArea = All;
                LookupPageID = "Risk Scores";
                ToolTip = 'Specifies the value of the Risk Score field.';
            }
            field(Litigious; Rec."Litigious FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Litigious field.';
            }
            field("Return Order Mandatory"; Rec."Return Order Mandatory FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Return Order Mandatory field.';
            }
            field("Interest Rate Credit Amount"; Rec."Interest Rate Credit Amt FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Interest Rate Credit Amount field.';
            }
            field("Open Sales RPM Value"; Rec."Open Sales RPM Value FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Open Sales RPM Value field.';
            }
            field("RPM Exposure"; Rec."RPM Exposure FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RPM Exposure field.';
            }
            field("Additional RPM Return"; Rec."Additional RPM Return FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Additional RPM Return field.';
            }
            field("Packaging Credit Value (PCV)"; Rec."Packaging Credit Value PCV FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Packaging Credit Value (PCV) field.';
            }
            field("FFE Security Amount"; Rec."FFE Security Amount FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the FFE Security Amount field.';
            }
            field("Check FFE Bal/FFE security Amt"; Rec."Check Bal/FFE security Amt FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Check FFE Bal/FFE security Amt field.';
            }
            field("Min. Order Value Limit"; Rec."Min. Order Value Limit FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Min. Order Value Limit field.';
            }
            field("Min. Order Value Limit Type"; Rec."Min. Order Value Limit FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Min. Order Value Limit Type field.';
            }
            field("Trading End Date"; Rec."Trading End Date FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Trading End Date field.';
            }
            field("Contract Type"; Rec."Contract Type FND")
            {
                ApplicationArea = All;
                Editable = Vsb;
                ToolTip = 'Specifies the value of the Contract Type field.';
            }
            field("Customer Relationship"; Rec."Customer Relationship FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Relationship field.';
            }
            field("Compensate RPM Differences"; Rec."Compensate RPM Differences FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Compensate RPM Differences field.';
            }
            field("SEM Id"; Rec."SEM Id FND")
            {
                ApplicationArea = All;
                Importance = Standard;
                ToolTip = 'Specifies the value of the SEM Id field.';
            }
        }
        moveafter(City; County)
        addafter(County)
        {

            field("Territory Code"; Rec."Territory Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Territory Code field.';
            }
        }
        moveafter("Territory Code"; "Country/Region Code")
        addafter("Country/Region Code")
        {
            field("Longitude Coordinate"; Rec."Longitude Coordinate FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Longitude Coordinate field.';
            }
            field("Latitude Coordinate"; Rec."Latitude Coordinate FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Latitude Coordinate field.';
            }

            field("Reg. Structure Grouping Code"; Rec."Reg. Structure Group. Code FND")
            {
                ApplicationArea = All;

                Description = 'HEI.38';
                ToolTip = 'Specifies the value of the Reg. Structure Grouping Code field.';
            }
            field("Reg, Structure Grouping Desc."; Rec."Reg. Struct. Group. Desc. FND")
            {
                ApplicationArea = All;

                Description = 'HEI.38';
                ToolTip = 'Specifies the value of the Reg, Structure Grouping Desc. field.';
            }
        }
        addafter("Home Page")
        {
            // field("Our Account No."; Rec."Our Account No.")
            // {
            //     Description = 'DITW18.00.06 MSF 16/07/2015 DIT-770 #1410';
            // }
        }
        addafter(ContactDetails)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields
            // field("Interface Partner"; Rec."Interface Partner")
            // {
            //     Description = 'IPXL9.00.001';
            // }
            // field("Postal address"; Rec."Postal address")
            // {
            //     Description = 'FINXL7.00.001';
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields

            group(Control1101000000)
            {
                grid(Control1101000001)
                {
                    GridLayout = Rows;
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields

                    // group(Control1101000002)
                    // {
                    //     field("Start Selling Date"; Rec."Start Selling Date")
                    //     {
                    //         Importance = Additional;
                    //     }
                    //     field("Start Selling Reason Code"; Rec."Start Selling Reason Code")
                    //     {
                    //         Importance = Additional;
                    //     }
                    // }
                    // group(Control1101000003)
                    // {
                    //     field("End Selling Date"; Rec."End Selling Date")
                    //     {
                    //         Importance = Additional;
                    //     }
                    //     field("End Selling Reason Code"; Rec."End Selling Reason Code")
                    //     {
                    //         Importance = Additional;
                    //     }
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields

                }
            }
        }
        addafter("Bill-to Customer No.")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields
            // field("Bill-to Contact No."; Rec."Bill-to Contact No.")
            // {
            // }
            // field("Bill-to Contact"; Rec."Bill-to Contact")
            // {
            //     Editable = BilltoContactEditable;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields

        }
        addafter(GLN)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields
            // field(ExtDocNoMandatoryYes; Rec."Ext. Doc. No. Mandatory")
            // {
            //     CaptionML = ENU = 'Ext. Doc. No. Mandatory',
            //                 FRA = 'N° doc. ext. obligatoire';
            //     OptionCaptionML = ENU = 'Default(Yes),No,Yes(Posting),Yes(Order release),Yes(Both)',
            //                       FRA = 'Par défaut (oui),Non,Oui (Validation),Oui (lancer commande),Oui(Tous)';
            //     Visible = ShowExtDocNoMandatoryDefaultYes;
            // }
            // field(ExtDocNoMandatoryNo; Rec."Ext. Doc. No. Mandatory")
            // {
            //     CaptionML = ENU = 'Ext. Doc. No. Mandatory',
            //                 FRA = 'N° doc. ext. obligatoire';
            //     OptionCaptionML = ENU = 'Default(No),No,Yes(Posting),Yes(Order release),Yes(Both)',
            //                       FRA = 'Par défaut (Non),Oui,Non (Validation),Non (lancer commande),Non(Tous)';
            //     Visible = ShowExtDocNoMandatoryDefaultNo;
            // }
            // field("Invoice Address from"; Rec."Invoice Address from")
            // {
            // }
            // field("Empty Goods Statement On"; Rec."Empty Goods Statement On")
            // {
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields

        }
        addfirst(PostingDetails)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields
            // field("Bill-to/Sell-to Prices Calc."; Rec."Bill-to/Sell-to Prices Calc.")
            // {
            //     Description = 'DITW17.00.02 DIT-770 #140';
            // }
            // field("Sell-to/Bill-to DTax Gr. Calc."; Rec."Sell-to/Bill-to DTax Gr. Calc.")
            // {
            //     Description = 'DIT-715 #520';
            // }
            // field("Calculate Payment Terms From"; Rec."Calculate Payment Terms From")
            // {
            //     Description = 'DITW17.00.02 DIT-770 #140';
            // }
            // field("Calculate Payment Method From"; Rec."Calculate Payment Method From")
            // {
            //     Description = 'DIT-715 #520';
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields
        }
        addafter("VAT Bus. Posting Group")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
            }
        }
        addafter(PostingDetails)
        {
            field("Netting Agreement"; Rec."Netting Agreement FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Netting Agreement field.';
            }
            field("Vendor No."; Rec."Vendor No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor No. field.';
            }
        }
        addfirst(Payments)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields
            // field("Invoice Method"; Rec."Invoice Method")
            // {

            //     trigger OnValidate();
            //     begin
            //         //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
            //         if "Invoice Method" <> "Invoice Method"::" " then
            //             blnEditable := false
            //         else
            //             blnEditable := true;

            //         if (("Invoice Method" = "Invoice Method"::"Combine Shipments") or
            //            ("Invoice Method" = "Invoice Method"::"Combine Shipments Per Sell-to")) then
            //             "Combine Shipments" := true;

            //         if (("Invoice Method" = "Invoice Method"::Shipment) or
            //            ("Invoice Method" = "Invoice Method"::Order)) then
            //             "Combine Shipments" := false;
            //         //>>DITW17.00.02 TEC1 DIT-770 #154
            //     end;
            // }
            // field("Invoice Period"; Rec."Invoice Period")
            // {
            // }
            // field("Accumulate items on Invoice"; Rec."Accumulate items on Invoice")
            // {
            // }
            // field("Shipment specification"; Rec."Shipment specification")
            // {
            // }
            // field("Invoice List Customer No."; Rec."Invoice List Customer No.")
            // {
            // }
            // field("Purchasing Code"; Rec."Purchasing Code")
            // {
            //     LookupPageID = "Purchasing Codes";
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields
        }
        // addafter("Block Payment Tolerance")
        // {
        // field("Payment Balance (LCY)"; Rec."Balance (LCY)")  // BC FR Upgrade KAIRAR01
        // {
        //     ApplicationArea = Basic, Suite;
        //     ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';

        //     trigger OnDrillDown();
        //     var
        //         CustLedgEntry: Record "Cust. Ledger Entry";
        //         DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        //     begin
        //         //HEI.30>>
        //         DtldCustLedgEntry.SETFILTER("Customer No.", Rec."No.");
        //         Rec.COPYFILTER("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
        //         Rec.COPYFILTER("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
        //         Rec.COPYFILTER("Currency Filter", DtldCustLedgEntry."Currency Code");
        //         CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
        //         //HEI.30<<
        //     end;
        // }
        // BC Upgrade BHARDA11 >> --- Field not found "Payment in progress (LCY)"
        // field("Payment in progress (LCY)"; Rec."Payment in progress (LCY)")
        // {
        //     ApplicationArea = Basic, Suite;
        //     ToolTipML = ENU = 'Displays the customer''s payments in progress.',
        //                 FRA = 'Affiche les paiements du client en cours.';
        // }

        // field("""Balance (LCY)"" - ""Payment in progress (LCY)"""; Rec."Balance (LCY)" - Rec."Payment in progress (LCY)")
        // {
        //     ApplicationArea = Basic, Suite;
        //     CaptionML = ENU = 'Net amount (LCY)',
        //                 FRA = 'Montant net DS';
        //     Editable = false;
        // }
        // BC Upgrade BHARDA11 << --- Field not found "Payment in progress (LCY)"

        // }
        addfirst(Shipping)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Field
            // field("Bill-to Adress Code"; Rec."Bill-to Adress Code")
            // {
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Field

            // field("Ship-to Code"; Rec."Ship-to Code")
            // {
            // }
        }
        addafter("Location Code")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Field
            // field("Return Location Code"; Rec."Return Location Code")
            // {
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Field
        }
        addafter("Shipping Advice")
        {
            field("Required Freshness"; Rec."Required Freshness FND")
            {
                ApplicationArea = All;
                Caption = 'Required Freshness (%)';
                Editable = false;
                ToolTip = 'Specifies the value of the Required Freshness (%) field.';
            }
        }
        addafter("Shipping Agent Service Code")
        {
            field("No. of Shipping Agent Rel."; Rec."No. of Shipping Agent Rel. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No. of Shipping Agent Service Relations field.';
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields
            // field("Transaction Type"; Rec."Transaction Type")
            // {
            // }
            // field("Transport Method"; Rec."Transport Method")
            // {
            // }
            // field("Transaction Specification"; Rec."Transaction Specification")
            // {
            // }
            // field("Exit Point"; Rec."Exit Point")
            // {
            // }
            // field("Area"; Rec.Area)
            // {
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields

            group(Route)
            {
                CaptionML = ENU = 'Route',
                            FRA = 'Route';
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields

                // field(Control1100076024; Rec.Route)
                // {

                //     trigger OnDrillDown();
                //     var
                //         lrRouteCombination: Record "Route Combination";
                //         lpRouteCombination: Page "Route Combinations";
                //     begin
                //         //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
                //         lrRouteCombination.RESET;
                //         FILTERGROUP(2);
                //         //<< DITW18.00.07 VSC 09/05/2016 DIT-770 #1968
                //         lrRouteCombination.SETRANGE("Source Type", lrRouteCombination."Source Type"::Customer);
                //         //>> DITW18.00.07 VSC DIT-770 #1968
                //         lrRouteCombination.SETRANGE("No.", "No.");
                //         //lrRouteCombination.SETRANGE(Code,Route);
                //         FILTERGROUP(2);
                //         lpRouteCombination.SETTABLEVIEW(lrRouteCombination);
                //         lpRouteCombination.RUNMODAL;
                //         //>>DITW17.00.02 TEC1 DIT-770 #154
                //     end;
                // }
                // field("No. of Routes"; Rec."No. of Routes")
                // {
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Fields

                field("Sales Routes"; Rec."Sales Routes FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Routes field.';
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields
                // field(Distance; Distance)
                // {
                // }
                // field("Delivery Sequence"; Rec."Delivery Sequence")
                // {
                // }
                // field("Minimum Cubage"; Rec."Minimum Cubage")
                // {
                // }
                // field("Minimum Weight"; Rec."Minimum Weight")
                // {
                // }
                // field("Picking Type"; Rec."Picking Type")
                // {
                //     Description = '<DITW17.00.02 DIT-770 #154> - DITW18.00.06 MSF 05/05/2015 DIT-770 #1376';
                // }
                // field("Shipment Date Formula"; Rec."Shipment Date Formula")
                // {
                //     Description = 'DITW17.00.02 DIT-770 #146';
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Fields

            }
        }
        moveafter("Sales Routes"; "Shipping Time")

        addafter("Base Calendar Code")
        {
            // field("Customize Calender"; CalendarMgmt.CustomizedCalendarExistText(CustomizedCalendar."Source Type"::Customer, Rec."No.", '', Rec."Base Calendar Code"))
            // {

            // }
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields
            // field("Truck Zone"; Rec."Truck Zone")
            // {
            // }
            // field("Require 2 Drivers"; Rec."Require 2 Drivers")
            // {
            // }
            // field("Ship-to Address Key No."; Rec."Ship-to Address Key No.")
            // {
            // }
            // field("Delivery Note Copies"; Rec."Delivery Note Copies")
            // {
            // }
            // field("Shipment Date Alert Filter"; Rec."Shipment Date Alert Filter")
            // {
            // }
            // field("Shipment Status Alert Filter"; Rec."Shipment Status Alert Filter")
            // {
            // }
            // field("Customer Delivery Type"; Rec."Customer Delivery Type")
            // {
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT fields
        }
        addafter(Shipping)
        {
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Tax Registration Number"; Rec."Tax Registration Number FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax Registration Number field.';
                }
                field("National Identity Card"; Rec."National Identity Card FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the National Identity Card field.';
                }
                field("Approval Of Alcohol"; Rec."Approval Of Alcohol FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approval Of Alcohol field.';
                }
                // BC Upgrade SHUKLP03 >> Delivary note report => PID 70
                field("Exp. Date on Del. Note"; Rec."Exp. Date on Del. Note FND")
                {
                    ApplicationArea = ALL;
                }
                field("Cross. Ref. on Del. Note"; Rec."Cross. Ref. on Del. Note FND")
                {
                    ApplicationArea = ALL;
                }
                // BC Upgrade SHUKLP03 << Delivary note report => PID 70
            }
        }
        moveafter("Base Calendar Code"; "Customized Calendar")
        addafter(PricesandDiscounts)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Group
            // group("Drink-It")
            // {
            //     CaptionML = ENU = 'Drink-It',
            //                 FRA = 'Drink-It';
            //     field("Autom. Item Charge"; Rec."Autom. Item Charge")
            //     {
            //     }
            //     group(Taxes)
            //     {
            //         CaptionML = ENU = 'Taxes',
            //                     FRA = 'Impôts et Taxes';
            //         field("Customer DTax Group Code"; Rec."Customer DTax Group Code")
            //         {
            //             LookupPageID = "Drink Customer Tax Groups";
            //         }
            //         field("Tax Registration No."; Rec."Tax Registration No.")
            //         {
            //         }
            //         field("Tax Warehouse Reference"; Rec."Tax Warehouse Reference")
            //         {
            //         }
            //         field("Fiscal Representative No."; Rec."Fiscal Representative No.")
            //         {
            //         }
            //         field("Journey Time"; Rec."Journey Time")
            //         {
            //             Description = 'DITW15.00.00.39 #1353';
            //         }
            //         field("Transport Time Text"; Rec."Transport Time Text")
            //         {
            //         }
            //         field("Tax Office Code"; Rec."Tax Office Code")
            //         {
            //         }
            //     }
            //     group("Deposits & Empty Goods")
            //     {
            //         CaptionML = ENU = 'Deposits & Empty Goods',
            //                     FRA = 'Consignes et articles vidanges';
            //         field("Customer DDeposit Group Code"; Rec."Customer DDeposit Group Code")
            //         {
            //             Description = '<DITW15.00.00.01>-NRQ#16224';
            //             LookupPageID = "Customer Drink Deposit Groups";
            //         }
            //         field("Deposit Limit"; Rec."Deposit Limit")
            //         {

            //             trigger OnLookup(Text: Text): Boolean;
            //             begin
            //                 // <<DITW18.00.06A DDR 24/11/2015 DIT-770 #1701
            //                 StyleTxt := SetStyleDeposit;
            //                 // >>DITW18.00.06A DDR DIT-770 #1701
            //             end;
            //         }
            //         field("Deposit Limit (LCY)"; Rec."Deposit Limit (LCY)")
            //         {
            //             StyleExpr = StyleTxt;

            //             trigger OnValidate();
            //             begin
            //                 //<<DITW18.00.06 MVN 22/09/2015 DIT-770 #1524 - DITW18.00.06A DDR 24/11/2015 DIT-770 #1701
            //                 StyleTxt := SetStyleDeposit;
            //                 //>>DITW18.00.06 MVN 22/09/2015 DIT-770 #1524 - DITW18.00.06A DDR DIT-770 #1701
            //             end;
            //         }
            //         field("Split Deposit on Invoice"; Rec."Split Deposit on Invoice")
            //         {
            //         }
            //         field("Deposit Cust. Posting Group"; Rec."Deposit Cust. Posting Group")
            //         {
            //         }
            //         field("Deposit Payment Terms Code"; Rec."Deposit Payment Terms Code")
            //         {
            //         }
            //         field("Deposit Payment Method Code"; Rec."Deposit Payment Method Code")
            //         {
            //         }
            //         field("Empty Returned Items Based On"; Rec."Empty Returned Items Based On")
            //         {
            //         }
            //         field("Free Goods Accounting (HNK)"; Rec."Free Goods Accounting (HNK)")
            //         {
            //         }
            //     }
            //     // BC Upgrade BHARDA11 << ----Drink-IT Group
            //     group(Discounts)
            //     {
            //         CaptionML = ENU = 'Discounts',
            //                     FRA = 'Remises';
            //         field("No. of Drink Disc. Groups"; Rec."No. of Drink Disc. Groups")
            //         {
            //             DrillDown = false;

            //             trigger OnLookup(var Text: Text): Boolean;
            //             var
            //                 DDiscountRel: Record "Drink Discount Relation";
            //             begin
            //                 // <<DITW16.00.00.37 DDR 13/01/2011 DIT-715 #42
            //                 CurrPage.SAVERECORD;
            //                 COMMIT;
            //                 DDiscountRel.FILTERGROUP(2);
            //                 DDiscountRel.SETRANGE("Source Type", DDiscountRel."Source Type"::Customer);
            //                 DDiscountRel.SETRANGE("Source No.", "No.");
            //                 DDiscountRel.FILTERGROUP(0);
            //                 PAGE.RUNMODAL(0, DDiscountRel);
            //                 CurrPage.UPDATE(false);
            //             end;
            //         }
            //         field("No. of Promotion Groups"; Rec."No. of Promotion Groups")
            //         {
            //             DrillDown = false;

            //             trigger OnLookup(var Text: Text): Boolean;
            //             var
            //                 DPromotionRel: Record "Drink Promotion Relation";
            //             begin
            //                 // <<DITW16.00.00.37 DDR 13/01/2011 DIT-715 #42
            //                 CurrPage.SAVERECORD;
            //                 COMMIT;
            //                 DPromotionRel.FILTERGROUP(2);
            //                 DPromotionRel.SETRANGE("Source Type", DPromotionRel."Source Type"::Customer);
            //                 DPromotionRel.SETRANGE("Source No.", "No.");
            //                 DPromotionRel.FILTERGROUP(0);
            //                 PAGE.RUNMODAL(0, DPromotionRel);
            //                 CurrPage.UPDATE(false);
            //             end;
            //         }
            //         field("Min HL Volume"; Rec."Min HL Volume")
            //         {
            //         }
            //         field("Min. Eq. UOM quantity"; Rec."Min. Eq. UOM quantity")
            //         {
            //         }
            //         field("Last Net sales price"; Rec."Last Net sales price")
            //         {
            //         }
            //     }
            //     // BC Upgrade BHARDA11 >> ----Drink-IT Fields
            //     // group(Promotions)
            //     // {
            //     //     CaptionML = ENU = 'Promotions',
            //     //                     FRA = 'Promotions';
            //     //     field("Gen. Bus. Posting Free Group"; Rec."Gen. Bus. Posting Free Group")
            //     //     {
            //     //     }
            //     //     field("Free Item Posting Type"; Rec."Free Item Posting Type")
            //     //     {
            //     //     }
            //     //     field("Free Item"; Rec."Free Item")
            //     //     {
            //     //     }
            //     //     field("Free Reason Code"; Rec."Free Reason Code")
            //     //     {
            //     //         Description = 'DITW17.00.02 DIT-770 #132';
            //     //     }
            //     // }

            //     // group(Others)
            //     // {
            //     //     CaptionML = ENU = 'Others',
            //     //                     FRA = 'Autres';
            //     //     field("No. of Exclusivity Groups"; Rec."No. of Exclusivity Groups")
            //     //     {
            //     //     }
            //     //     field("No. of Loyalty Groups"; Rec."No. of Loyalty Groups")
            //     //     {
            //     //         Description = 'DIT715 #243';
            //     //     }
            //     //     field("No. of Quota Groups"; Rec."No. of Quota Groups")
            //     //     {
            //     //     }
            //     //     field(Exclusivity; Rec.Exclusivity)
            //     //     {
            //     //     }
            //     //     field("Loyalty Statement On"; Rec."Loyalty Statement On")
            //     //     {
            //     //     }
            //     //     field("Cross. Ref. on Del. Note"; Rec."Cross. Ref. on Del. Note")
            //     //     {
            //     //     }
            //     //     field("Exp. Date on Del. Note"; Rec."Exp. Date on Del. Note")
            //     //     {
            //     //     }
            //     // }
            //     // BC Upgrade BHARDA11 << ----Drink-IT Fields
            // }
            // BC Upgrade BHARDA11 << ---- Drink-IT Group
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields

            // group(Building)
            // {
            //     CaptionML = ENU = 'Building',
            //                 FRA = 'Immeuble';
            //     field("Building No."; Rec."Building No.")
            //     {
            //         Importance = Promoted;

            //         trigger OnValidate();
            //         begin
            //             BuildingNoOnAfterValidate;
            //         end;
            //     }
            //     field("Building Desciption"; Rec."Building Desciption")
            //     {
            //         DrillDown = false;
            //     }
            //     field("Building Address"; Rec."Building Address")
            //     {
            //         DrillDown = false;
            //     }
            //     field("Building Address 2"; Rec."Building Address 2")
            //     {
            //         DrillDown = false;
            //     }
            //     field("Building Post Code"; Rec."Building Post Code")
            //     {
            //         DrillDown = false;
            //     }
            //     field("Building City"; Rec."Building City")
            //     {
            //         DrillDown = false;
            //     }
            //     field("Building Country/Region Code"; Rec."Building Country/Region Code")
            //     {
            //         DrillDown = false;
            //     }
            //     field("Building Employment Date"; Rec."Building Employment Date")
            //     {
            //         DrillDown = false;
            //     }
            //     field("Building Last Inactive Date"; Rec."Building Last Inactive Date")
            //     {
            //         DrillDown = false;
            //         Importance = Promoted;
            //     }
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields
            // group(Properties)
            // {
            //     CaptionML = ENU = 'Properties',
            //                 FRA = 'Propriétés';
            //     field("Shortcut Property 1 Code"; Rec."Shortcut Property 1 Code")
            //     {
            //     }
            //     field("Shortcut Property 2 Code"; Rec."Shortcut Property 2 Code")
            //     {
            //     }
            //     field("Shortcut Property 3 Code"; Rec."Shortcut Property 3 Code")
            //     {
            //     }
            //     field("Shortcut Property 4 Code"; Rec."Shortcut Property 4 Code")
            //     {
            //     }
            //     field("Shortcut Property 5 Code"; Rec."Shortcut Property 5 Code")
            //     {
            //     }
            //     field("Shortcut Property 6 Code"; Rec."Shortcut Property 6 Code")
            //     {
            //     }
            //     field("Shortcut Property 7 Code"; Rec."Shortcut Property 7 Code")
            //     {
            //     }
            //     field("Shortcut Property 8 Code"; Rec."Shortcut Property 8 Code")
            //     {
            //     }
            //     field("Shortcut Property 9 Code"; Rec."Shortcut Property 9 Code")
            //     {
            //     }
            //     field("Shortcut Property 10 Code"; Rec."Shortcut Property 10 Code")
            //     {
            //     }
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields
        }
        addafter(Shipping)
        {
            group(Contract)
            {
                CaptionML = ENU = 'Contract',
                            FRA = 'Contrat';
                group(Control1100066007)
                {
                    CaptionML = ENU = 'General',
                                FRA = 'Général';
                    field("Customer Posting Group 2"; Rec."Customer Posting Group")
                    {
                        ApplicationArea = All;
                        Importance = Promoted;
                        ToolTip = 'Specifies the value of the Customer Posting Group field.';
                    }
                    field("Balance (LCY) 2"; Rec."Balance (LCY)")
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Customer Balance (LCY)',
                                    FRA = 'Solde client DS';
                        ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';

                        trigger OnDrillDown();
                        var
                            DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                            CustLedgEntry: Record "Cust. Ledger Entry";
                        begin
                            DtldCustLedgEntry.SETRANGE("Customer No.", Rec."No.");
                            Rec.COPYFILTER("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                            Rec.COPYFILTER("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                            Rec.COPYFILTER("Currency Filter", DtldCustLedgEntry."Currency Code");
                            // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                            // BC Upgrade BHARDA11 >> ----Drink-IT Fields
                            // Rec.COPYFILTER("DIT Sub-Contract Type Filter", DtldCustLedgEntry."DIT Sub-Contract Type");
                            // Rec.COPYFILTER("Service Contract No. Filter", DtldCustLedgEntry."Service Contract No.");
                            // Rec.COPYFILTER("Item Charge Type Filter", DtldCustLedgEntry."Item Charge Type");
                            // BC Upgrade BHARDA11 << ----Drink-IT Fields

                            // >>DITW16.00.00.42 DDR DIT-715 #370
                            CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
                        end;
                    }
                }
                group("Contract types")
                {
                    CaptionML = ENU = 'Contract types',
                                FRA = 'Types de contrat';
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields
                    // field("Contract Cust. Post. Gr. Stand"; Rec."Contract Cust. Post. Gr. Stand")
                    // {
                    //     Enabled = false;
                    //     Importance = Promoted;
                    //     Visible = false;
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields

                    field("BalanceSubContractLCY[1]"; BalanceSubContractLCY[1])
                    {
                        AutoFormatType = 1;
                        CaptionML = ENU = 'No Type - Balance (LCY)',
                                    FRA = 'Non type - Solde DS';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the value of the BalanceSubContractLCY[1] field.';
                        ApplicationArea = All;

                        trigger OnDrillDown();
                        begin
                            // DrillDownContractBalanceLCY("DIT Sub-Contract Type Filter"::" "); // BC Upgrade BHARDA11 ----Drink-IT Function(DrillDownContractBalanceLCY)
                        end;
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields

                    // field("Contract Cust. Post. Gr. Rent"; Rec."Contract Cust. Post. Gr. Rent")
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields

                    field("BalanceSubContractLCY[2]"; BalanceSubContractLCY[2])
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Rent - Balance (LCY)',
                                    FRA = 'Location - Solde DS';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the value of the BalanceSubContractLCY[2] field.';

                        trigger OnDrillDown();
                        begin
                            // DrillDownContractBalanceLCY("DIT Sub-Contract Type Filter"::" "); // BC Upgrade BHARDA11 ----Drink-IT Function(DrillDownContractBalanceLCY)

                        end;
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field
                    // field("Contract Cust. Post. Gr. Loan"; Rec."Contract Cust. Post. Gr. Loan")
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Field

                    field("BalanceSubContractLCY[3]"; BalanceSubContractLCY[3])
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Loan - Balance (LCY)',
                                    FRA = 'Prêt - Solde DS';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the value of the BalanceSubContractLCY[3] field.';

                        trigger OnDrillDown();
                        begin
                            // DrillDownContractBalanceLCY("DIT Sub-Contract Type Filter"::Loan); // BC Upgrade BHARDA11 ----Drink-IT Function(DrillDownContractBalanceLCY)
                        end;
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field

                    // field("Contract Cust. Post. Gr. LoanU"; Rec."Contract Cust. Post. Gr. LoanU")
                    // {
                    // }
                    // BC Upgrade BHARDA11 <, ----Drink-IT Field

                    field("BalanceSubContractLCY[4]"; BalanceSubContractLCY[4])
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Loan in Use - Balance (LCY)',
                                    FRA = 'Prêt à usage - Solde DS';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the value of the BalanceSubContractLCY[4] field.';

                        trigger OnDrillDown();
                        begin
                            // <<DITW16.00.00.43 DDR 10/06/2013 DIT-715 #623
                            // DrillDownContractBalanceLCY("DIT Sub-Contract Type Filter"::LoanInUse); // BC Upgrade BHARDA11 ----Drink-IT Function(DrillDownContractBalanceLCY)
                            // >>DITW16.00.00.43 DDR DIT-715 #623
                        end;
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field

                    // field("Contract Cust. Post. Gr. Maint"; Rec."Contract Cust. Post. Gr. Maint")
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Field

                    field("BalanceSubContractLCY[5]"; BalanceSubContractLCY[5])
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Maintenance - Balance (LCY)',
                                    FRA = 'Maintenance - Solde DS';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the value of the BalanceSubContractLCY[5] field.';

                        trigger OnDrillDown();
                        begin
                            // <<DITW16.00.00.43 DDR 10/06/2013 DIT-715 #623
                            // DrillDownContractBalanceLCY("DIT Sub-Contract Type Filter"::Maintenance); // BC Upgrade BHARDA11 ----Drink-IT Function(DrillDownContractBalanceLCY)
                            // >>DITW16.00.00.43 DDR DIT-715 rgba(44, 95, 47, 1)
                        end;
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field

                    // field("Contract Cust. Post. Gr. Other"; Rec."Contract Cust. Post. Gr. Other")
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Field

                    field("BalanceSubContractLCY[6]"; BalanceSubContractLCY[6])
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Other - Balance (LCY)',
                                    FRA = 'Autre - Solde DS';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the value of the BalanceSubContractLCY[6] field.';

                        trigger OnDrillDown();
                        begin
                            // DrillDownContractBalanceLCY("DIT Sub-Contract Type Filter"::Other); // BC Upgrade BHARDA11 ----Drink-IT Function(DrillDownContractBalanceLCY)
                        end;
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields
                    // field("Contract Cust. Post. Gr. Plant"; Rec."Contract Cust. Post. Gr. Plant")
                    // {
                    //     Description = 'DIT-715 #297';
                    // }
                    // field("BalanceSubContractLCY[7]"; BalanceSubContractLCY[7])
                    // {
                    //     CaptionML = ENU = 'Plant Maint. - Balance (LCY)',
                    //                 FRA = 'Maintenance usine - Solde DS';
                    //     Description = 'DIT-715 #297';
                    //     Editable = false;
                    //     Importance = Additional;

                    //     trigger OnDrillDown();
                    //     begin
                    //         // <<DITW16.00.00.43 DDR 10/06/2013 DIT-715 #623
                    //         // DrillDownContractBalanceLCY("DIT Sub-Contract Type Filter"::PlantMaintenance); // BC Upgrade BHARDA11 ----Drink-IT Function(DrillDownContractBalanceLCY)
                    //         // >>DITW16.00.00.43 DDR DIT-715 #623
                    //     end;
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields
                }
                group("Financial Contract")
                {
                    CaptionML = ENU = 'Financial Contract',
                                FRA = 'Contrat financier';
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field

                    // field("Item DDisc. Group Code"; Rec."Item DDisc. Group Code")
                    // {
                    //     Description = 'DIT-715 #378';
                    // }
                    // field("Item DDisc. Group Code 2"; Rec."Item DDisc. Group Code 2")
                    // {
                    //     Description = 'DIT-715 #378';
                    // }
                    // field("Sales (Qty.) HL"; Rec."Sales (Qty.) HL")
                    // {
                    //     Importance = Additional;

                    //     trigger OnDrillDown();
                    //     begin
                    //         // <<DITW16.00.00.43 AHU 20/06/2013 DIT-715 #617
                    //         // DrillDownFlowSalesQtyHL(0); // BC Upgrade BHARDA11 ----Drink-IT Function (DrillDownFlowSalesQtyHL)
                    //         // >>DITW16.00.00.43 AHU DIT-715 #617
                    //     end;
                    // }
                    // field("Sales Indirect (Qty.) HL"; Rec."Sales Indirect (Qty.) HL")
                    // {
                    //     Importance = Additional;

                    //     trigger OnDrillDown();
                    //     begin
                    //         // <<DITW16.00.00.43 AHU 20/06/2013 DIT-715 #617
                    //         // DrillDownFlowIndSalesQtyHL(0); // BC Upgrade BHARDA11 ----Drink-IT Function (DrillDownFlowSalesQtyHL)
                    //         // >>DITW16.00.00.43 AHU DIT-715 #617
                    //     end;
                    // }
                    // field("Sales Free (Qty.) HL"; Rec."Sales Free (Qty.) HL")
                    // {
                    //     Importance = Additional;

                    //     trigger OnDrillDown();
                    //     begin
                    //         // <<DITW16.00.00.43 AHU 20/06/2013 DIT-715 #617
                    //         // DrillDownFlowSalesQtyHL(1); // BC Upgrade BHARDA11 ----Drink-IT Function (DrillDownFlowSalesQtyHL)
                    //         // >>DITW16.00.00.43 AHU DIT-715 #617
                    //     end;
                    // }
                    // field("Sales Indirect Free (Qty.) HL"; Rec."Sales Indirect Free (Qty.) HL")
                    // {
                    //     Importance = Additional;

                    //     trigger OnDrillDown();
                    //     begin
                    //         // <<DITW16.00.00.43 AHU 20/06/2013 DIT-715 #617
                    //         // DrillDownFlowIndSalesQtyHL(1); // BC Upgrade BHARDA11 ----Drink-IT Function (DrillDownFlowSalesQtyHL)
                    //         // >>DITW16.00.00.43 AHU DIT-715 #617
                    //     end;
                    // }
                    // field("Loan Interest Cust. Post. Grp."; Rec."Loan Interest Cust. Post. Grp.")
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Field

                }
            }
            group(TeleSales)
            {
                CaptionML = ENU = 'TeleSales',
                            FRA = 'Télévente';
                // BC Upgrade BHARDA11 >> ---_Drink-IT Fields
                // field("Caller-ID"; Rec."Caller-ID")
                // {
                //     Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
                //     Importance = Promoted;
                // }
                // field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                // {
                //     Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
                // }
                // field("No. of Calls"; Rec."No. of Calls")
                // {
                //     Editable = false;
                //     Importance = Promoted;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Field
                field("Copy Base Calendar Code"; Rec."Base Calendar Code")
                {
                    ApplicationArea = All;
                    DrillDown = false;
                    ToolTip = 'Specifies the value of the Base Calendar Code field.';
                }
                // BC Upgrade BHARDA11 >>---- Drink-IT work
                // field("Copy Customized Calendar"; CalendarMgmt.CustomizedCalendarExistText(CustomizedCalendar."Source Type"::Customer, REc."No.", '', REc."Base Calendar Code"))
                // {
                //     ApplicationArea = All;
                //     CaptionML = ENU = 'Customized Calendar',
                //                 FRA = 'Calendrier personnalisé';
                //     Editable = false;

                //     trigger OnDrillDown();
                //     begin
                //         CurrPage.SAVERECORD;
                //         Rec.TESTFIELD("Base Calendar Code");
                //         CalendarMgmt.ShowCustomizedCalendar(CustomizedCalEntry."Source Type"::Customer, Rec."No.", '', Rec."Base Calendar Code");
                //     end;
                // }
                // BC Upgrade BHARDA11 << ---- Drink-IT work

            }

        }
        addafter(WorkflowStatus)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Page
            // part(Control1100086015; "Cust DContract Stats. FactBox")
            // {
            //     SubPageLink = "No." = FIELD("No.");
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Page

        }
        // moveafter(Blocked; BlockedCustomer)
    }
    actions
    {
        modify("&Customer")
        {
            CaptionML = ENU = '&Customer', FRA = '&Client';

            //Unsupported feature: Change Name on ""&Customer"(Action 74)". Please convert manually.


            //Unsupported feature: Change Visible on ""&Customer"(Action 74)". Please convert manually.

        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';

            //Unsupported feature: Change Name on "Dimensions(Action 84)". Please convert manually.

        }
        modify("Bank Accounts")
        {
            CaptionML = ENU = 'Bank Accounts', FRA = 'Comptes bancaires';
            ToolTipML = ENU = 'View or set up the customer''s bank accounts. You can set up any number of bank accounts for each customer.', FRA = 'Affichez ou configurez les comptes bancaires de votre client. Vous pouvez configurer autant de comptes bancaires que vous le souhaitez pour chaque client.';

            //Unsupported feature: Change Name on ""Bank Accounts"(Action 99)". Please convert manually.

        }
        modify("Direct Debit Mandates")
        {
            CaptionML = ENU = 'Direct Debit Mandates', FRA = 'Mandats de domiciliation européenne';
            ToolTipML = ENU = 'View the direct-debit mandates that reflect agreements with customers to collect invoice payments from their bank account.', FRA = 'Affichez les mandats de prélèvement que vous définissez afin de refléter les accords passés avec les clients pour le recouvrement des paiements des factures sur leur compte bancaire.';
        }
        modify(ShipToAddresses)
        {
            CaptionML = ENU = 'Ship-&to Addresses', FRA = '&Adresses destinataire';
            ToolTipML = ENU = 'View or edit alternate shipping addresses where the customer wants items delivered if different from the regular address.', FRA = 'Affichez ou modifiez les autres adresses de livraison où le client souhaite faire livrer les articles, si elles sont différentes de l''adresse habituelle.';
        }
        modify(Contact)
        {
            CaptionML = ENU = 'C&ontact', FRA = 'C&ontact';
            ToolTipML = ENU = 'View or edit detailed information about the contact person at the customer.', FRA = 'Affichez ou modifiez des informations détaillées concernant la personne à contacter chez le client.';
        }
        // BC Upgrade BHARDA11 >> Not Found
        // modify("Cross Re&ferences")
        // {
        //     CaptionML = ENU = 'Cross Re&ferences', FRA = '&Références externes';
        //     ToolTipML = ENU = 'Set up the customer''s own identification of items that you sell to the customer. Cross-references to the customer''s item number means that the item number is automatically shown on sales documents instead of the number that you use.', FRA = 'Configurez la manière dont le client identifie les articles que vous lui vendez. Les références externes au numéro d''article du client impliquent que le numéro d''article est automatiquement affiché sur les documents vente au lieu du numéro que vous utilisez.';
        // }
        // BC Upgrade BHARDA11 << Not Found

        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';

            //Unsupported feature: Change Name on ""Co&mments"(Action 78)". Please convert manually.

        }
        modify(ApprovalEntries)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify(CustomerReportSelections)
        {
            CaptionML = ENU = 'Document Layouts', FRA = 'Présentations document';
            ToolTipML = ENU = 'Set up a layout for different types of documents such as invoices, quotes, and credit memos.', FRA = 'Configurez une présentation pour différents types de documents tels que des factures, des devis et avoirs.';
        }
        modify(ActionGroupCRM)
        {
            CaptionML = ENU = 'Dynamics CRM', FRA = 'Dynamics CRM';
        }
        modify(CRMGotoAccount)
        {
            CaptionML = ENU = 'Account', FRA = 'Compte';
            ToolTipML = ENU = 'Open the coupled Microsoft Dynamics CRM account.', FRA = 'Ouvrez le compte Microsoft Dynamics CRM couplé.';
        }
        modify(CRMSynchronizeNow)
        {
            CaptionML = ENU = 'Synchronize Now', FRA = 'Synchroniser maintenant';
            ToolTipML = ENU = 'Send or get updated data to or from Microsoft Dynamics CRM.', FRA = 'Envoyez/recevez des données mises à jour à/de Microsoft Dynamics CRM.';
        }
        modify(UpdateStatisticsInCRM)
        {
            CaptionML = ENU = 'Update Account Statistics', FRA = 'Mettre à jour les statistiques compte';
            ToolTipML = ENU = 'Send customer statistics data to Dynamics CRM to update the Account Statistics FactBox.', FRA = 'Envoyez les données statistiques client à Dynamics CRM pour mettre à jour le récapitulatif Statistiques compte';
        }
        modify(Coupling)
        {
            CaptionML = Comment = 'Coupling is a noun Coupling', ENU = 'Coupling', FRA = 'Couplage';
            ToolTipML = ENU = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.', FRA = 'Créez, modifiez ou supprimez un couplage entre l''enregistrement Microsoft Dynamics NAV et un enregistrement Microsoft Dynamics CRM.';
        }
        modify(ManageCRMCoupling)
        {
            CaptionML = ENU = 'Set Up Coupling', FRA = 'Configurer le couplage';
            ToolTipML = ENU = 'Create or modify the coupling to a Microsoft Dynamics CRM account.', FRA = 'Créez ou modifiez le couplage avec un compte Microsoft Dynamics CRM.';
        }
        modify(DeleteCRMCoupling)
        {
            CaptionML = ENU = 'Delete Coupling', FRA = 'Supprimer le couplage';
            ToolTipML = ENU = 'Delete the coupling to a Microsoft Dynamics CRM account.', FRA = 'Supprimez le couplage avec un compte Microsoft Dynamics CRM.';
        }
        modify(History)
        {
            CaptionML = ENU = 'History', FRA = 'Historique';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the history of transactions that have been posted for the selected record.', FRA = 'Affichez l''historique des transactions qui ont été validées pour l''enregistrement sélectionné.';
        }
        // modify(Statistics)
        // {

        //     //Unsupported feature: Change Level on "Statistics(Action 76)". Please convert manually.

        //     CaptionML = ENU = 'Statistics', FRA = 'Statistiques';

        //     //Unsupported feature: Change Name on "Statistics(Action 76)". Please convert manually.

        // }
        modify("S&ales")
        {

            //Unsupported feature: Change Level on ""S&ales"(Action 79)". Please convert manually.

            CaptionML = ENU = 'S&ales', FRA = '&Ventes';
        }
        modify("Entry Statistics")
        {

            //Unsupported feature: Change Level on ""Entry Statistics"(Action 77)". Please convert manually.

            CaptionML = ENU = 'Entry Statistics', FRA = 'Statistiques écritures';
        }
        modify("Statistics by C&urrencies")
        {

            //Unsupported feature: Change Level on ""Statistics by C&urrencies"(Action 112)". Please convert manually.

            CaptionML = ENU = 'Statistics by C&urrencies', FRA = 'Statistiques par &devise';
        }
        modify("Item &Tracking Entries")
        {

            //Unsupported feature: Change Level on ""Item &Tracking Entries"(Action 6500)". Please convert manually.

            CaptionML = ENU = 'Item &Tracking Entries', FRA = '&Ecritures traçabilité';
        }
        modify("Prices and Discounts")
        {
            CaptionML = ENU = 'Prices and Discounts', FRA = 'Prix et remises';
        }
        modify("Invoice &Discounts")
        {
            CaptionML = ENU = 'Invoice &Discounts', FRA = 'Remises &facture';
            ToolTipML = ENU = 'Set up different discounts that are applied to invoices for the customer. An invoice discount is automatically granted to the customer when the total on a sales invoice exceeds a certain amount.', FRA = 'Configurez des remises différentes qui seront appliquées aux factures client. Une remise facture est automatiquement accordée au client lorsque le total sur la facture vente dépasse un certain montant.';
        }
        // BC Upgrade BHARDA11 >> --- firlds Removed in BC
        // modify(Prices)
        // {
        //     CaptionML = ENU = 'Prices', FRA = 'Prix';
        //     ToolTipML = ENU = 'View or set up different prices for items that you sell to the customer. An item price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', FRA = 'Affichez ou paramétrez des prix différents pour les articles que vous vendez au client. Un prix article est automatiquement affecté sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin.';
        // }
        // modify("Line Discounts")
        // {
        //     CaptionML = ENU = 'Line Discounts', FRA = 'Remises ligne';
        //     ToolTipML = ENU = 'Set up different discounts for items that you sell to the customer. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', FRA = 'Paramétrez des remises différentes pour les articles que vous vendez au client. Une remise article est automatiquement affectée sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin.';
        // }
        // BC Upgrade BHARDA11 << --- firlds Removed in BC
        modify("Prepa&yment Percentages")
        {
            CaptionML = ENU = 'Prepa&yment Percentages', FRA = 'Pourcentages acom&pte';
        }
        modify("Recurring Sales Lines")
        {
            CaptionML = ENU = 'Recurring Sales Lines', FRA = 'Lignes vente récurrentes';
            ToolTipML = ENU = 'Set up recurring sales lines for the customer, such as a monthly replenishment order, that can quickly be inserted on a sales document for the customer.', FRA = 'Définissez des lignes vente récurrentes pour le client, par exemple un ordre de réapprovisionnement mensuel, qui peuvent être rapidement insérées dans un document vente pour le client.';
        }
        modify(Documents)
        {
            CaptionML = ENU = 'Documents', FRA = 'Documents';
        }
        modify(Quotes)
        {
            CaptionML = ENU = 'Quotes', FRA = 'Devis';
            ToolTipML = ENU = 'View a list of ongoing sales quotes for the customer.', FRA = 'Affichez une liste des devis vente en cours pour le client.';
        }
        modify(Orders)
        {
            CaptionML = ENU = 'Orders', FRA = 'Commandes';
            ToolTipML = ENU = 'View a list of ongoing sales orders for the customer.', FRA = 'Affichez une liste des commandes vente en cours pour le client.';
        }
        modify("Return Orders")
        {
            CaptionML = ENU = 'Return Orders', FRA = 'Retours';
        }
        modify("Issued Documents")
        {
            CaptionML = ENU = 'Issued Documents', FRA = 'Documents émis';
        }
        modify("Issued &Reminders")
        {
            CaptionML = ENU = 'Issued &Reminders', FRA = '&Relances émises';
            ToolTipML = ENU = 'View the reminders that you have sent to the customer.', FRA = 'Affichez les rappels que vous avez envoyés au client.';
        }
        modify("Issued &Finance Charge Memos")
        {
            CaptionML = ENU = 'Issued &Finance Charge Memos', FRA = 'Fact&ures d''intérêts émises';
            ToolTipML = ENU = 'View the finance charge memos that you have sent to the customer.', FRA = 'Affichez les factures d''intérêts que vous avez envoyées au client.';
        }
        modify("Blanket Orders")
        {
            CaptionML = ENU = 'Blanket Orders', FRA = 'Commandes ouvertes';
        }
        modify("&Jobs")
        {
            CaptionML = ENU = '&Jobs', FRA = '&Projets';
        }
        modify(Service)
        {
            CaptionML = ENU = 'Service', FRA = 'Service';
        }
        modify("Service Orders")
        {

            //Unsupported feature: Change Level on ""Service Orders"(Action 128)". Please convert manually.

            CaptionML = ENU = 'Service Orders', FRA = 'Commandes service';
        }
        modify("Ser&vice Contracts")
        {

            //Unsupported feature: Change Level on ""Ser&vice Contracts"(Action 126)". Please convert manually.

            CaptionML = ENU = 'Ser&vice Contracts', FRA = 'Co&ntrats de service';
        }
        modify("Service &Items")
        {

            //Unsupported feature: Change Level on ""Service &Items"(Action 127)". Please convert manually.

            CaptionML = ENU = 'Service &Items', FRA = 'Ar&ticles de service';
        }
        // modify(ActionContainer9)
        // {

        //     //Unsupported feature: Change Name on "ActionContainer9(Action 9)". Please convert manually.


        //     //Unsupported feature: Change Level on "ActionContainer9(Action 9)". Please convert manually.

        //     CaptionML = FRA = 'Carte de crédit';
        // }
        modify(NewBlanketSalesOrder)
        {
            CaptionML = ENU = 'Blanket Sales Order', FRA = 'Commande ouverte vente';
            ToolTipML = ENU = 'Create a blanket sales order for the customer.', FRA = 'Créez une commande ouverte vente pour le client.';
        }
        modify(NewSalesQuote)
        {
            CaptionML = ENU = 'Sales Quote', FRA = 'Devis';
            ToolTipML = ENU = 'Create a new sales quote where you offer items or services to a customer.', FRA = 'Créez un devis proposant des articles ou des services à un client.';
        }
        modify(NewSalesInvoice)
        {
            CaptionML = ENU = 'Sales Invoice', FRA = 'Facture vente';
            ToolTipML = ENU = 'Create a sales invoice for the customer.', FRA = 'Créez une facture vente pour le client.';
        }
        modify(NewSalesOrder)
        {
            CaptionML = ENU = 'Sales Order', FRA = 'Commande vente';
            ToolTipML = ENU = 'Create a sales order for the customer.', FRA = 'Créez une commande vente pour le client.';
        }
        modify(NewSalesCreditMemo)
        {
            CaptionML = ENU = 'Sales Credit Memo', FRA = 'Avoir vente';
            ToolTipML = ENU = 'Create a new sales credit memo to revert a posted sales invoice.', FRA = 'Créez un avoir vente pour annuler une facture vente validée.';
        }
        modify(NewSalesReturnOrder)
        {
            CaptionML = ENU = 'Sales Return Order', FRA = 'Retour vente';
            ToolTipML = ENU = 'Create a sales return order for the customer.', FRA = 'Créez un retour vente pour le client.';
        }
        modify(NewServiceQuote)
        {
            CaptionML = ENU = 'Service Quote', FRA = 'Devis service';
            ToolTipML = ENU = 'Create a service quote for the customer.', FRA = 'Créez un devis service pour le client.';
        }
        modify(NewServiceInvoice)
        {
            CaptionML = ENU = 'Service Invoice', FRA = 'Facture service';
            ToolTipML = ENU = 'Create a service invoice for the customer.', FRA = 'Créez une facture service pour le client.';
        }
        modify(NewServiceOrder)
        {
            CaptionML = ENU = 'Service Order', FRA = 'Commande service';
            ToolTipML = ENU = 'Create a service order for the customer.', FRA = 'Créez une commande service pour le client.';
        }
        modify(NewServiceCreditMemo)
        {
            CaptionML = ENU = 'Service Credit Memo', FRA = 'Avoir service';
            ToolTipML = ENU = 'Create a service credit memo for the customer.', FRA = 'Créez un avoir service pour le client.';
        }
        modify(NewReminder)
        {
            CaptionML = ENU = 'Reminder', FRA = 'Relance';
            ToolTipML = ENU = 'Create a remainder for the customer.', FRA = 'Créez un solde pour le client.';

            //Unsupported feature: Change Description on "NewReminder(Action 1903839805)". Please convert manually.


            //Unsupported feature: Change Visible on "NewReminder(Action 1903839805)". Please convert manually.

        }
        modify(NewFinanceChargeMemo)
        {
            CaptionML = ENU = 'Finance Charge Memo', FRA = 'Facture d''intérêts';
            ToolTipML = ENU = 'Create a finance charge memo for the customer.', FRA = 'Créez une facture d''intérêts pour le client.';
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
        modify(Workflow)
        {
            CaptionML = ENU = 'Workflow', FRA = 'Flux de travail';
        }
        modify(CreateApprovalWorkflow)
        {
            CaptionML = ENU = 'Create Approval Workflow', FRA = 'Créer flux de travail approbation';
            ToolTipML = ENU = 'Set up an approval workflow for creating or changing customers, by going through a few pages that will guide you.', FRA = 'Configurez un flux de travail approbation pour créer ou modifier des clients, en consultant quelques pages qui vous guideront.';
        }
        modify(ManageApprovalWorkflows)
        {
            CaptionML = ENU = 'Manage Approval Workflows', FRA = 'Gérer les flux de travail approbation';
            ToolTipML = ENU = 'View or edit existing approval workflows for creating or changing customers.', FRA = 'Affichez ou modifiez des flux de travail approbation existants pour créer ou modifier des clients.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(Templates)
        {
            CaptionML = ENU = 'Templates', FRA = 'Modèles';
            ToolTipML = ENU = 'View or edit customer templates.', FRA = 'Affichez ou modifiez des modèles client.';
        }
        modify(ApplyTemplate)
        {
            CaptionML = ENU = 'Apply Template', FRA = 'Appliquer modèle';
            ToolTipML = ENU = 'Apply a customer template to quickly register this customer.', FRA = 'Appliquez un modèle client pour enregistrer rapidement ce client.';
        }
        modify(SaveAsTemplate)
        {
            CaptionML = ENU = 'Save as Template', FRA = 'Sauvegarder comme modèle';
            ToolTipML = ENU = 'Save the customer card as a template that can be reused to create new customer cards. Customer templates contain preset information to help you fill fields on customer cards.', FRA = 'Enregistrez la fiche client comme modèle que vous pourrez réutiliser pour créer de nouvelles fiches client. Les modèles client contiennent des informations prédéfinies pour vous aider à compléter les fiches client.';
        }
        modify("Post Cash Receipts")
        {
            CaptionML = ENU = 'Post Cash Receipts', FRA = 'Reporter règlements';
            ToolTipML = ENU = 'Create a cash receipt journal line for the customer, for example, to post a payment receipt.', FRA = 'Créez une ligne feuille règlement pour le client, par exemple, pour valider un reçu de paiement.';
        }
        modify("Sales Journal")
        {
            CaptionML = ENU = 'Sales Journal', FRA = 'Feuille vente';
        }
        modify(Category_Report)
        {

            //Unsupported feature: Change Name on "ActionContainer1900000006(Action 1900000006)". Please convert manually.

            CaptionML = FRA = 'États';
        }

        modify("Report Customer Detailed Aging")
        {

            //Unsupported feature: Change Level on ""Report Customer Detailed Aging"(Action 1906813206)". Please convert manually.

            CaptionML = ENU = 'Customer Detailed Aging', FRA = 'Écritures client ouvertes';
            ToolTipML = ENU = 'View a detailed list of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.', FRA = 'Affichez une liste détaillée des totaux dus de chaque client, divisée en trois périodes. Cet état sert à décider quand émettre des relances, à évaluer la solvabilité d''un client ou à préparer des analyses de liquidités.';
        }
        modify("Report Customer - Labels")
        {

            //Unsupported feature: Change Level on ""Report Customer - Labels"(Action 1907586706)". Please convert manually.

            CaptionML = ENU = 'Customer - Labels', FRA = 'Clients : Étiquettes';
            ToolTipML = ENU = 'View mailing labels with the customers'' names and addresses.', FRA = 'Affichez des étiquettes de routage comportant le nom et l''adresse des clients.';
        }
        modify("Report Customer - Balance to Date")
        {

            //Unsupported feature: Change Level on ""Report Customer - Balance to Date"(Action 1902299006)". Please convert manually.

            CaptionML = ENU = 'Customer - Balance to Date', FRA = 'Clients : Écritures ouvertes';
            ToolTipML = ENU = 'View a list with customers'' payment history up until a certain date. You can use the report to extract your total sales income at the close of an accounting period or fiscal year.', FRA = 'Affichez une liste reprenant l''historique des paiements des clients jusqu''à une certaine date. Vous pouvez utiliser l''état pour extraire vos revenus de vente totaux à la clôture d''une période comptable ou d''un exercice.';
        }

        addafter(BackgroundStatement_Promoted)
        {

        }
        modify("Report Statement")
        {
            CaptionML = ENU = 'Statement', FRA = 'Relevé';
            ToolTipML = ENU = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.', FRA = 'Affichez une liste des transactions d''un client pour une période sélectionnée, par exemple, à envoyer au client à la clôture d''une période comptable. Vous pouvez choisir d''afficher tous les soldes échus, sans tenir compte de la période spécifiée, ou d''inclure un cumul date.';
        }

        //Unsupported feature: PropertyDeletion on "NewReminder(Action 1903839805)". Please convert manually.



        //Unsupported feature: CodeModification on "SendApprovalRequest(Action 55).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ApprovalsMgmt.CheckCustomerApprovalsWorkflowEnabled(Rec) then
          ApprovalsMgmt.OnSendCustomerForApproval(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // >>HEI.34
        CopyToDefaultDimensions("No.");
        // <<HEI.34
        if ApprovalsMgmt.CheckCustomerApprovalsWorkflowEnabled(Rec) then
          ApprovalsMgmt.OnSendCustomerForApproval(Rec);
        */
        //end;
        addfirst("&Customer")
        {
            group(BTPlant)
            {
                CaptionML = ENU = '&Plant',
                            FRA = '&Usine';
                // Visible = BTPlantVisible; // Bc Upgrade BHARDA11 ----Drink-IT Variable and logic use in onopenpage                 // Visible = BTPlantVisible; // Bc Upgrade BHARDA11 ----Drink-IT Variable

                // action(Dimensions)
                // {
                //     CaptionML = ENU = 'Dimensions',
                //                 FRA = 'Axes analytiques';
                //     Image = Dimensions;
                //     RunObject = Page "Default Dimensions";
                //     RunPageLink = "Table ID" = CONST(18),
                //                   "No." = FIELD("No.");
                //     ShortCutKey = 'Shift+Ctrl+D';
                // }
                // action("Bank Accounts")
                // {
                //     CaptionML = ENU = 'Bank Accounts',
                //                 FRA = 'Comptes bancaires';
                //     Image = BankAccount;
                //     RunObject = Page "Customer Bank Account List";
                //     RunPageLink = "Customer No." = FIELD("No.");
                // }
                action("Ship-&to Addresses")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Ship-&to Addresses',
                                FRA = '&Adresses destinataire';
                    RunObject = Page "Ship-to Address List";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ToolTip = 'Executes the Ship-&to Addresses action.';
                }
                action("C&ontact")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'C&ontact',
                                FRA = 'C&ontact';
                    ToolTip = 'Executes the C&ontact action.';

                    trigger OnAction();
                    begin
                        Rec.ShowContact();
                    end;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Code
                // action("Customized Calendar")
                // {
                //     CaptionML = ENU = 'Customized Calendar',
                //                 FRA = 'Calendrier personnalisé';
                //     Description = 'DITW15.00.00.39 DDR 22/04/2011 #1230';
                //     Ellipsis = true;

                //     trigger OnAction();
                //     begin
                // <<DITW15.00.00.39 DDR 22/04/2011 #1230
                // CurrPage.SAVERECORD;
                // Rec.TESTFIELD("Base Calendar Code");
                // CalendarMgmt.ShowCustomizedCalendar(CustomizedCalEntry."Source Type"::Customer, REc."No.", '', Rec."Base Calendar Code");
                // end;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Code
                // action("Co&mments")
                // {
                //     CaptionML = ENU = 'Co&mments',
                //                 FRA = 'Co&mmentaires';
                //     Image = ViewComments;
                //     RunObject = Page "Comment Sheet";
                //     RunPageLink = "Table Name" = CONST(Customer),
                //                   "No." = FIELD("No.");
                //     ShortCutKey = 'Ctrl+B';
                // }
                // BC Upgrade BHARDA11 >> ----Drink-It Pages
                // separator(Separator1100076058)
                // {
                // }

                // action("&Plant Maintenances")
                // {
                //     CaptionML = ENU = '&Plant Maintenances',
                //                 FRA = '&Maintenance Usine';
                //     RunObject = Page "Service Contract List PM";
                //     RunPageLink = "Customer No." = FIELD("No.");
                //     RunPageView = SORTING("Customer No.", "Ship-to Code");
                // }
                // action("Plant Maintenance Lines")
                // {
                //     CaptionML = ENU = 'Plant Maintenance Lines',
                //                 FRA = 'Lignes maintenance usine';
                //     RunObject = Page "Cust. Serv. Contract Lines PM";
                //     RunPageLink = "Customer No." = FIELD("No.");
                //     RunPageView = SORTING("Customer No.", "Ship-to Code");
                // }
                // action("Equ&ipments")
                // {
                //     CaptionML = ENU = 'Equ&ipments',
                //                 FRA = 'Equ&ipements';
                //     RunObject = Page "Service Items List PM";
                //     RunPageLink = "Customer No." = FIELD("No.");
                //     RunPageView = SORTING("Customer No.", "Ship-to Code", "Item No.", "Serial No.");
                // }
                // separator(Separator1100076067)
                // {
                // }
                // BC Upgrade BHARDA11 << ----Drink-It Pages
                action("Online Map")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Online Map',
                                FRA = 'Online Map';
                    ToolTip = 'Executes the Online Map action.';

                    trigger OnAction();
                    begin
                        Rec.DisplayMap();
                    end;
                }
            }
        }
        // addafter("S&ales_Promoted")

        addafter(Contact)
        {
            // BC Upgrade BHARDA11 >> ----Page not Available in BC
            // action("&Payment Addresses")
            // {
            //     ApplicationArea = Basic, Suite;
            //     CaptionML = ENU = '&Payment Addresses',
            //                 FRA = 'Adresses de rè&glement';
            //     Image = Addresses;
            //     RunObject = Page "Payment Addresses";
            //     RunPageLink = "Account Type" = CONST(Customer),
            //                   "Account No." = FIELD("No.");
            // }
            // BC Upgrade BHARDA11 << ----Page not Available in BC

        }
        addafter(CustomerReportSelections)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields
            // action(Action1100083056)
            // {
            //     CaptionML = ENU = 'Customized Calendar',
            //                 FRA = 'Calendrier personnalisé';
            //     Description = 'DITW15.00.00.39 DDR 22/04/2011 #1230';
            //     Ellipsis = true;
            //     Image = CalendarChanged;

            //     trigger OnAction();
            //     begin
            //         // <<DITW15.00.00.39 DDR 22/04/2011 #1230
            //         CurrPage.SAVERECORD;
            //         REc.TESTFIELD("Base Calendar Code");
            //         CalendarMgmt.ShowCustomizedCalendar(CustomizedCalEntry."Source Type"::Customer, "No.", '', "Base Calendar Code");
            //     end;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields

            // BC Upgrade BHARDA11 >> ----Page not Available in BC
            // action("Cust.- resp. center relation")
            // {
            //     CaptionML = ENU = 'Responsibility Center Relations',
            //                 FRA = 'Relations centre de gestion client';
            //     Description = 'DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214';
            //     Image = Responsibility;
            //     RunObject = Page "Cust.- resp. center relations";
            //     RunPageLink = "Customer No." = FIELD("No.");
            // }
            // BC Upgrade BHARDA11 << ----Page not Available in BC

            action("Customer Attributes")
            {
                ApplicationArea = All;
                Caption = 'Customer Attributes';
                Image = Customer;
                RunObject = Page "Customer Attributes Card CBN";
                RunPageLink = "Customer No." = FIELD("No.");
                ToolTip = 'Executes the Customer Attributes action.';

                trigger OnAction();
                var
                    lCustomerAttributes: Record "Customer Attributes FND";
                begin
                    //<<HEI.06
                    lCustomerAttributes.RESET();
                    if not lCustomerAttributes.GET(Rec."No.") then begin
                        lCustomerAttributes."Customer No." := REc."No.";
                        lCustomerAttributes.INSERT();
                    end;
                    //>>HEI.06
                end;
            }
            action("Handling Time & Trucks")
            {
                ApplicationArea = All;
                Caption = 'Handling Time & Trucks';
                Image = Timeline;
                RunObject = Page "CustHandlingTimeTruck CBN";
                RunPageLink = "Customer No." = FIELD("No.");
                ToolTip = 'Executes the Handling Time & Trucks action.';
            }
            action("Customer Email Log FND")
            {
                ApplicationArea = All;
                Caption = 'Customer Email Log';
                Image = Email;
                RunObject = Page "Customer Email Log CBN";
                RunPageLink = "Customer No." = FIELD("No.");
                ToolTip = 'Executes the Customer Email Log action.';
            }
            // BC Upgade BHARDA11 >> ----Drink-IT Pages
            // group("Relation Groups")
            // {
            //     CaptionML = ENU = 'Relation Groups',
            //                 FRA = 'Groupes de relations';
            //     Image = Relationship;
            //     action("Tax Groups")
            //     {
            //         CaptionML = ENU = 'Tax Groups',
            //                     FRA = 'Groupes taxes';
            //         Image = Relationship;
            //         RunObject = Page "Drink Customer Tax Groups";
            //         RunPageLink = "Source Type" = CONST(Customer);
            //         RunPageView = WHERE("Source Type" = CONST(Customer));
            //     }
            //     action("Exception Tax Groups")
            //     {
            //         CaptionML = ENU = 'Exception Tax Groups',
            //                     FRA = 'Groupes taxe excéption';
            //         Image = Relationship;
            //         RunObject = Page "Customer Exception Tax Groups";
            //     }
            //     action("Deposit Groups")
            //     {
            //         CaptionML = ENU = 'Deposit Groups',
            //                     FRA = 'Groupes consignes';
            //         Image = Relationship;
            //         RunObject = Page "Drink Deposit Groups";
            //         RunPageLink = "Source Type" = CONST(Customer);
            //         RunPageView = WHERE("Source Type" = CONST(Customer));
            //     }
            //     action("Discount &Groups (Drink-It)")
            //     {
            //         CaptionML = ENU = 'Discount &Groups (Drink-It)',
            //                     FRA = 'Groupes &Remise (Drink-It)';
            //         Image = Relationship;
            //         RunObject = Page "Relation Drink Discount Groups";
            //         RunPageLink = "Source Type" = CONST(Customer),
            //                       "Source No." = FIELD("No.");
            //     }
            //     action("Promotion Grou&ps")
            //     {
            //         CaptionML = ENU = 'Promotion Grou&ps',
            //                     FRA = 'Grou&pes Promotion';
            //         Image = Relationship;
            //         RunObject = Page "Relation Promotion Groups";
            //         RunPageLink = "Source Type" = CONST(Customer),
            //                       "Source No." = FIELD("No.");
            //     }
            //     action("&Exclusivity Groups")
            //     {
            //         CaptionML = ENU = '&Exclusivity Groups',
            //                     FRA = 'Groupes &Exculisivité';
            //         Image = Relationship;
            //         RunObject = Page "Relation Exclusivity Groups";
            //         RunPageLink = "Source Type" = CONST(Customer),
            //                       "Source No." = FIELD("No.");
            //     }
            //     action("Loyalty Groups")
            //     {
            //         CaptionML = ENU = 'Loyalty Groups',
            //                     FRA = 'Groupes Fidélité';
            //         Description = 'DIT715 #243';
            //         Image = Relationship;
            //         RunObject = Page "Relation Loyalty Groups";
            //         RunPageLink = "Source Type" = CONST(Customer),
            //                       "Source No." = FIELD("No.");
            //     }
            //     action("&Quota Groups")
            //     {
            //         CaptionML = ENU = '&Quota Groups',
            //                     FRA = 'Groupes &Devis';
            //         Image = Relationship;
            //         RunObject = Page "Relation Quota Groups";
            //         RunPageLink = "Source Type" = CONST(Customer),
            //                       "Source No." = FIELD("No.");
            //     }
            //     action("Delivery Time")
            //     {
            //         CaptionML = ENU = 'Delivery Time',
            //                     FRA = 'Heure de Livraison';
            //         Image = Relationship;
            //         RunObject = Page "Delivery Times";
            //         RunPageLink = "No." = FIELD("No.");
            //         RunPageView = SORTING("No.", "Address Code")
            //                       WHERE("Source Type" = CONST(Customer));
            //     }
            // }

            // action(Properties)
            // {
            //     CaptionML = ENU = 'Properties',
            //                 FRA = 'Propriétés';
            //     Description = 'FINXL9.00';
            //     Image = Category;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Master Data Properties";
            //     RunPageLink = "Table ID" = CONST(18),
            //                   Code = FIELD("No.");
            // }
            // BC Upgade BHARDA11 >> ----Drink-IT Pages
        }
        addafter("Ledger E&ntries")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Page
            // action("Telesales Overview (Entries)")
            // {
            //     CaptionML = ENU = 'Telesales Overview (Entries)',
            //                 FRA = 'Détails televente (Ecritures)';
            //     Image = Entries;
            //     RunObject = Page "Telesales Entries";
            //     RunPageLink = "Customer No." = FIELD("No."),
            //                   "Calling Date" = FIELD("Date Filter"),
            //                   "Ship-to Code" = FIELD("Ship-to Filter"),
            //                   "Call Status" = FIELD("Call Status Filter"),
            //                   Closed = FIELD("Call Closed Filter");
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Page

            action("Posted Customer Diff (RPM) CBN")
            {
                ApplicationArea = All;
                Caption = 'Posted Customer Diff (RPM)';
                Image = PostedReceipt;
                ToolTip = 'Executes the Posted Customer Diff (RPM) action.';

                trigger OnAction();
                begin
                    //HEI.25>>
                    PostedCustomerDiffRPMRec.SETFILTER("Sell-to customer no.", Rec."No.");
                    if PostedCustomerDiffRPMRec.FINDSET() then begin
                    end
                    else
                        if PostedCustomerDiffRPMRec.ISEMPTY then begin
                            PostedCustomerDiffRPMRec.SETFILTER("Sales return order no.", '');
                            if PostedCustomerDiffRPMRec.FINDSET() then begin
                            end
                        end;
                    PostedCustomerDiffRPMPage.SetPageNamecalledfrom(CurrPage.OBJECTID(false));
                    PostedCustomerDiffRPMPage.SETTABLEVIEW(PostedCustomerDiffRPMRec);
                    PostedCustomerDiffRPMPage.SETRECORD(PostedCustomerDiffRPMRec);
                    PostedCustomerDiffRPMPage.RUN();
                    //HEI.25<<
                end;
            }
            group(Statistics)
            {
                CaptionML = ENU = 'Statistics',
                            FRA = 'Statistiques';
                Image = Statistics;
            }
        }
        // BC Upgrade BHARDA11 >> ----Drink-IT Pages
        // addfirst("Statistics by C&urrencies")
        // {
        //     action("Loyalty Statistics")
        //     {
        //         CaptionML = ENU = 'Loyalty Statistics',
        //                     FRA = 'Statistiques fidélités';
        //         Description = 'DIT715 #243';
        //         Image = Statistics;
        //         RunObject = Page "Customer Loyalty by Item";
        //         RunPageLink = "No." = FIELD("No.");
        //     }
        //     group("Tracking Entries")
        //     {
        //         CaptionML = ENU = 'Tracking Entries',
        //                     FRA = 'Ecritures traçablité';
        //         Image = ItemTrackingLedger;
        //         action("Empty Goods Trac&king")
        //         {
        //             CaptionML = ENU = 'Empty Goods Trac&king',
        //                         FRA = 'Traçabilité article vidange';
        //             Description = 'DITW18.00.06 GVC 19/05/2015  DIT-770  #1335';
        //             Image = ItemTrackingLines;
        //             Promoted = false;
        //             //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //             //PromotedCategory = "Report";
        //             RunObject = Page "Empty Goods Tracking Overview";
        //             RunPageLink = "Source Type Filter" = CONST(Customer),
        //                           "Source No. Filter" = FIELD("No."),
        //                           "Date Filter" = FIELD("Date Filter"),
        //                           "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
        //                           "Global Dimension 2 Filter" = FIELD("Global Dimension 1 Filter");
        //         }
        //     }
        // }
        // BC Upgrade BHARDA11 >> ----Drink-IT Pages
        // addfirst("Item &Tracking Entries")
        // {
        //     action("SSCC Tracking Entries")
        //     {
        //         CaptionML = ENU = 'SSCC Tracking Entries',
        //                     FRA = 'Ecritures traçablité SSCC';
        //         Image = ItemTrackingLedger;

        //         trigger OnAction();
        //         var
        //             SSCCTrackingMgt: Codeunit "SSCC Tracking Management";
        //         begin
        //             // <<DITW15.00.00.38 DDR 19/11/2010 #1139
        //             SSCCTrackingMgt.CallSSCCTrackingEntryForm(1, "No.", '', '', '', '', '', 0);
        //         end;
        //     }
        // }
        // addafter("Line Discounts")
        // {
        // BC Upgrade BHARDA11 >> ----Drink-IT Page
        //     action("Sales Net Prices")
        //     {
        //         Caption = 'Sales Net Prices';
        //         Image = Price;
        //         RunObject = Page "Sales Net Price";
        //         RunPageLink = "Customer No." = FIELD("No.");
        //     }
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Page
        // BC Upgrade BHARDA11 >> ----Drink-IT Groups
        // addfirst(ActionGroup82)
        // {
        // action("D&iscount Charges")
        // {
        //     CaptionML = ENU = 'D&iscount Charges',
        //                 FRA = 'Frais de remise';
        //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
        //     Image = TaxSetup;
        //     RunObject = Page "Sales Discount Item Charges";
        //     RunPageLink = "Sales Type" = CONST(Customer),
        //                   "Sales Code" = FIELD("No.");
        // }
        // action("Promotio&n Charges")
        // {
        //     CaptionML = ENU = 'Promotio&n Charges',
        //                 FRA = 'Frais de promotion';
        //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
        //     Image = TaxSetup;
        //     RunObject = Page "Sales Promotion Item Charges";
        //     RunPageLink = "Sales Type" = CONST(Customer),
        //                   "Sales Code" = FIELD("No.");
        // }
        // group("Drink-It Charges")
        // {
        //     CaptionML = ENU = 'Drink-It Charges',
        //                 FRA = 'Frais Drink-IT';
        //     Image = TaxSetup;
        //     action("Ta&x Charges")
        //     {
        //         CaptionML = ENU = 'Ta&x Charges',
        //                     FRA = 'Taxe d''impôt';
        //         Description = 'DITW15.00.00.01';
        //         Image = TaxSetup;
        //         RunObject = Page "Sales Tax Item Charges";
        //         RunPageLink = "Sales Type" = CONST(Customer),
        //                       "Sales Code" = FIELD("No.");
        //     }
        // action(Action1100710010)
        // {
        //     CaptionML = ENU = 'Exception Tax Groups',
        //                 FRA = 'Groupes taxe excéption';
        //     Image = TaxSetup;
        //     RunObject = Page "Customer Exception Tax Groups";
        //     RunPageLink = "Exception DTax Group Code" = FIELD("Customer DTax Group Code");
        // }
        // action("D&eposit Charges")
        // {
        //     CaptionML = ENU = 'D&eposit Charges',
        //                 FRA = 'Friais de dépôt';
        //     Description = 'DITW15.00.00.01';
        //     Image = TaxSetup;
        //     RunObject = Page "Sales Deposit Item Charges";
        //     RunPageLink = "Sales Type" = CONST(Customer),
        //                   "Sales Code" = FIELD("No.");
        // }
        // action(Action1100710008)
        // {
        //     CaptionML = ENU = 'D&iscount Charges',
        //                 FRA = 'Frais de remise';
        //     Image = TaxSetup;
        //     RunObject = Page "Sales Discount Item Charges";
        //     RunPageLink = "Sales Type" = CONST(Customer),
        //                   "Sales Code" = FIELD("No.");
        // }
        // action(Action1100710007)
        // {
        //     CaptionML = ENU = 'Promotio&n Charges',
        //                 FRA = 'Frais de promotion';
        //     Image = TaxSetup;
        //     RunObject = Page "Sales Promotion Item Charges";
        //     RunPageLink = "Sales Type" = CONST(Customer),
        //                   "Sales Code" = FIELD("No.");
        // }
        // }
        //
        // group("Credit Limits")
        // {
        //     CaptionML = ENU = 'Credit Limits',
        //                 FRA = 'Limite crédit';
        //     Image = LimitedCredit;
        //     action("Deposit Li&mits")
        //     {
        //         CaptionML = ENU = 'Deposit Li&mits',
        //                     FRA = 'Limite dépôt';
        //         Image = LimitedCredit;
        //         RunObject = Page "Sales Deposit Limits";
        //         RunPageLink = "Sales Type" = CONST(Customer),
        //                       "Sales Code" = FIELD("No.");
        //         RunPageView = SORTING("Sales Type", "Sales Code");
        //     }
        //     action("Additional Credit Limits")
        //     {
        //         CaptionML = ENU = 'Additional Credit Limits',
        //                     FRA = 'Limites crédit complémentaires';
        //         Image = LimitedCredit;
        //         RunObject = Page "Additional Credit Limits";
        //         RunPageLink = "Customer No." = FIELD("No.");
        //     }
        // }
        // BC Upgrade BHARDA11 >> ----Drink-IT Pages

        // group(Others)
        // {
        //     CaptionML = ENU = 'Others',
        //                 FRA = 'Autres';
        //     Image = Item;
        //     action("Items &Exclusivity")
        //     {
        //         CaptionML = ENU = 'Items &Exclusivity',
        //                     FRA = 'Articles &Exclusivité';
        //         Image = Item;
        //         RunObject = Page "Sales Items Exclusivity";
        //         RunPageLink = "Sales Type" = CONST(Customer),
        //                       "Sales Code" = FIELD("No.");
        //     }
        //     action("Items Loyalty")
        //     {
        //         CaptionML = ENU = 'Items Loyalty',
        //                     FRA = 'Articles fidelité';
        //         Description = 'DIT715 #243';
        //         Image = Item;
        //         RunObject = Page "Sales Loyalty Points & Amounts";
        //         RunPageLink = "Sales Type" = CONST(Customer),
        //                       "Sales Code" = FIELD("No.");
        //     }
        //     action("Items &Quota")
        //     {
        //         CaptionML = ENU = 'Items &Quota',
        //                     FRA = 'Articles &Quota';
        //         Image = Item;
        //         RunObject = Page "Sales Items Quota";
        //         RunPageLink = "Sales Type" = CONST(Customer),
        //                       "Sales Code" = FIELD("No.");
        //     }
        //     action("Delayed Promotions")
        //     {
        //         CaptionML = ENU = 'Delayed Promotions',
        //                     FRA = 'Promotions retardé';
        //         RunObject = Page "Delayed Disc.& Promo. Worksht.";
        //         RunPageLink = "Entry Type" = FILTER(Promotion),
        //                       "Status Customer No." = FIELD("No.");
        //     }
        //     action("Quality Standards")
        //     {
        //         CaptionML = ENU = 'Quality Standards',
        //                     FRA = 'Standards de qualité';
        //         Image = TaskQualityMeasure;
        //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //         //PromotedCategory = Process;
        //         RunObject = Page "Sales Standards";
        //         RunPageLink = "Sales Type" = CONST(Customer),
        //                       "Sales Code" = FIELD("No.");
        //         RunPageView = SORTING("Sales Type", "Sales Code", "Item No.", "Starting Date", "Variant Code", "Qlty. Measure Code");
        //     }
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Pages
        // } // BC Upgrade BHARDA11 << ----Drink-IT Groups
        addafter("Return Orders")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT pages
            // action("Invoice List")
            // {
            //     CaptionML = ENU = 'Invoice List',
            //                 FRA = 'Liste des factures';
            //     Description = 'DITW17.10.05  DIT-770 #761';
            //     Image = List;
            //     Promoted = true;
            //     PromotedCategory = Category9;
            //     RunObject = Page "Invoice List";
            //     RunPageLink = "Customer No." = FIELD("No.");
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT pages

        }
        addafter("&Jobs")
        {
            action("<Action1100066010>")
            {
                CaptionML = ENU = 'Fixed Asset List',
                            FRA = 'Liste des immobilisations';
                Image = FixedAssets;
                ToolTip = 'Executes the <Action1100066010> action.';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //<< DITW17.00.02 SR 06/09/2013 DIT-770 #134
                    // fctShowDITContractFAList;  // BC Upgrade BHARDA11 ----Drink-IT Function
                    //>>DITW17.00.02 SR DIT-770 #134
                end;
            }
            group("Change Log")
            {
                CaptionML = ENU = 'Change Log',
                            FRA = 'Journal Modification';
                Image = Log;
                group("Change Log Entries")
                {
                    // ApplicationArea = All;
                    CaptionML = ENU = 'Change Log Entries',
                                FRA = 'Journal Modification';
                    Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
                    Image = Log;
                    action("<Action1000000002>")
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'by Customer',
                                    FRA = 'Client';
                        Image = Log;
                        RunObject = Page "Change Log Entries";
                        RunPageLink = "Table No." = FILTER(18),
                                      "Primary Key Field 1 Value" = FIELD("No.");
                        ToolTip = 'Executes the <Action1000000002> action.';
                    }
                    action("by Default Dimension")
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'by Default Dimension',
                                    FRA = 'Affectation analytique';
                        Image = Log;
                        RunObject = Page "Change Log Entries";
                        RunPageLink = "Table No." = FILTER(352),
                                      "Primary Key Field 1 Value" = FILTER(18),
                                      "Primary Key Field 2 Value" = FIELD("No.");
                        ToolTip = 'Executes the by Default Dimension action.';
                    }
                    action("by Bank Account")
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'by Bank Account',
                                    FRA = 'Compte bancaire client';
                        Image = Log;
                        RunObject = Page "Change Log Entries";
                        RunPageLink = "Table No." = FILTER(287),
                                      "Primary Key Field 1 Value" = FIELD("No.");
                        ToolTip = 'Executes the by Bank Account action.';
                    }
                }
            }
        }
        addfirst(Service)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Group

            // group(ActionGroup1100710004)
            // {
            //     CaptionML = ENU = 'Service',
            //                 FRA = 'Service';
            //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
            //     Image = ServiceItem;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Group

        }
        // BC Upgrade BHARDA11 >> ----Drink-IT Pages
        // addfirst("Service &Items")
        // {
        //     action("Service Contract Lines")
        //     {
        //         CaptionML = ENU = 'Service Contract Lines',
        //                     FRA = 'Lignes contrat de service';
        //         Image = ServiceLedger;
        //         RunObject = Page "Cust. Service Contract Lines";
        //         RunPageLink = "Customer No." = FIELD("No.");
        //         RunPageView = SORTING("Customer No.", "Ship-to Code");
        //     }
        //     action(Buildings)
        //     {
        //         CaptionML = ENU = 'Buildings',
        //                     FRA = 'Immeubles';
        //         Image = Zones;
        //         Promoted = true;
        //         PromotedCategory = Category9;
        //         RunObject = Page "Relation Buildings";
        //         RunPageLink = "Customer No." = FIELD("No.");
        //     }
        //     action("Blanket Financial Contracts")
        //     {
        //         CaptionML = ENU = 'Blanket Financial Contracts',
        //                     FRA = 'Contrats financier ouverts';
        //         Image = ServiceAgreement;
        //         RunObject = Page "Blanket Contract List";
        //         RunPageLink = "Contract Type" = CONST(Blanket),
        //                       "Customer No." = FIELD("No.");
        //     }
        //     action("Financial Contracts")
        //     {
        //         CaptionML = ENU = 'Financial Contracts',
        //                     FRA = 'Contrats financiers';
        //         Image = ServiceAgreement;
        //         RunObject = Page "Financial Contract List";
        //         RunPageLink = "Contract Type" = CONST(Contract),
        //                       "Customer No." = FIELD("No.");
        //     }
        //     action("Financial Contracts (Customer Volume)")
        //     {
        //         CaptionML = ENU = 'Financial Contracts (Customer Volume)',
        //                     FRA = 'Contrat financier (Volume client)';
        //         RunObject = Page "Financial Contract List";
        //         RunPageLink = "Contract Type" = CONST(Contract),
        //                       "Volume Customer No." = FIELD("No.");
        //     }
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Pages
        addafter(SaveAsTemplate)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Page
            // action("Copy Customer From Package")
            // {
            //     CaptionML = ENU = 'Copy Customer From Package',
            //                 FRA = 'Copier le client à partir du paquet';
            //     Description = 'FINXL8.00.001';
            //     Ellipsis = true;
            //     Image = Customer;
            //     Visible = true;

            //     trigger OnAction();
            //     var
            //         lpgeCopyCustomer: Page "Copy Customer (NORRIQXL)";
            //     begin
            //         //<<FINXL8.00.001 BSA 24/06/2015 #63
            //         lpgeCopyCustomer.fctSetParam("No.", '', '');
            //         lpgeCopyCustomer.RUNMODAL();
            //         //>>FINXL8.00.001 BSA 24/06/2015 #63
            //     end;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Page
            action("Copy Dimensions to Default Dimensions")
            {
                ApplicationArea = All;
                Caption = 'Copy Dimensions to Default Dimensions';
                Ellipsis = true;
                Image = CopyDimensions;
                ToolTip = 'Executes the Copy Dimensions to Default Dimensions action.';

                trigger OnAction();
                begin
                    //<<HEI.07
                    REc.CopyToDefaultDimensions(Rec."No.");
                    //>>HEI.07
                end;
            }
            // BC Upgrade BHARDA11 >>---- Drink-IT Pages and Reports

            // action("Sales Gross-net Price")
            // {
            //     Caption = 'Sales Gross-net Price';
            //     Description = 'NRQ6581';
            //     Image = "Report";
            //     Promoted = true;
            //     PromotedCategory = Category9;

            //     trigger OnAction();
            //     var
            //         lrptSalesGrossNetPrice: Report "Sales Gross-net Price";
            //         lrCustomer: Record Customer;
            //     begin
            //         // << DITW110.00.11 SFI 12/12/2017 NRQ#10509
            //         CurrPage.SETSELECTIONFILTER(lrCustomer);
            //         lrptSalesGrossNetPrice.SETTABLEVIEW(lrCustomer);
            //         lrptSalesGrossNetPrice.RUN;
            //         // >> DITW110.00.11 SFI NRQ#10509
            //     end;
            // }
            // action("Sales promotions per Customer")
            // {
            //     Caption = 'Sales promotions per Customer';
            //     Description = 'NRQ6581';
            //     Image = "Report";
            //     Promoted = true;
            //     PromotedCategory = Category9;

            //     trigger OnAction();
            //     var
            //         SalespromotionsperCustomer: Report "Sales promotions per Customer";
            //         lrCustomer: Record Customer;
            //     begin
            //         lrCustomer.SETFILTER("No.", "No.");
            //         SalespromotionsperCustomer.SETTABLEVIEW(lrCustomer);
            //         SalespromotionsperCustomer.RUN;
            //     end;
            // }
            // group(Telesales)
            // {
            //     CaptionML = ENU = 'Telesales',
            //                 FRA = 'Télévente';
            //     Image = Calls;
            //     action("Telesales Call Update")
            //     {
            //         CaptionML = ENU = 'Telesales Call Update',
            //                     FRA = 'Mettre à jour appels Télévente';
            //         Image = ExecuteBatch;

            //         trigger OnAction();
            //         var
            //             ReCustomer: Record Customer;
            //             RepTelesalesCallUpdate: Report "Telesales Call Update";
            //         begin
            //             //DITW17.00.02 SR 10/10/2013 DIT-770 #205
            //             RepTelesalesCallUpdate.GetCustFilter("No.", "Ship-to Code");
            //             RepTelesalesCallUpdate.RUNMODAL;
            //             CurrPage.UPDATE(false);
            //             //>>DITW17.00.02 SR DIT-770 #205
            //         end;
            //     }
            // }
            // BC Upgrade BHARDA11 << Drink-IT Pages and Reports
            group("&Print")
            {
                CaptionML = ENU = '&Print',
                            FRA = '&Imprimer';
            }
        }
        // BC Upgrade BHARDA11 >> ----Drink-IT Pages 
        // addfirst(ActionContainer1900000006)
        // {

        // group(Sales)
        // {
        //     CaptionML = ENU = 'Sales',
        //                 FRA = 'Ventes';
        //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
        //     action("Empty Goods Statement")
        //     {
        //         CaptionML = ENU = 'Empty Goods Statement',
        //                     FRA = 'Relevé vidanges';
        //         Image = "Report";
        //         Promoted = false;
        //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //         //PromotedCategory = "Report";

        //         trigger OnAction();
        //         var
        //             lcduDrinkDoc: Codeunit "Drink Document-Print";
        //         begin
        //             // <<DITW15.00.00.28 DDR 02/12/2008
        //             lcduDrinkDoc.PrintEmptyGoodStatmtCust(Rec);
        //         end;
        //     }
        //     action("Loyalty Statement")
        //     {
        //         CaptionML = ENU = 'Loyalty Statement',
        //                     FRA = 'Relevé Fidélité';
        //         Image = "report";
        //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //         //PromotedCategory = "Report";

        //         trigger OnAction();
        //         var
        //             lcduDrinkDoc: Codeunit "Drink Document-Print";
        //         begin
        //             // <<DITW16.00.00.40 DDR 27/04/2012 DIT-715 #243
        //             lcduDrinkDoc.PrintLoyaltyStatmtCust(Rec);
        //         end;
        //     }
        //     action("Sales Gross-net Price report")
        //     {
        //         CaptionML = DEU = 'VK Brutto-Netto Preise (XLS)',
        //                     ENU = 'Sales Gross-net Price report';
        //         Image = "Report";

        //         trigger OnAction();
        //         var
        //             lrptSalesGrossNetPrice: Report "Sales Gross-net Price";
        //             lrCustomer: Record Customer;
        //         begin
        //             // << DITW110.00.11 SFI 12/12/2017 BL#XXXXX
        //             CurrPage.SETSELECTIONFILTER(lrCustomer);
        //             lrptSalesGrossNetPrice.SETTABLEVIEW(lrCustomer);
        //             lrptSalesGrossNetPrice.RUN;
        //             // >> DITW110.00.11 SFI BL#XXXXX
        //         end;
        //     }
        //     action("Customer Sales Conditions (Landscape)")
        //     {
        //         CaptionML = ENU = 'Customer Sales Conditions (Landscape)',
        //                     FRA = 'Conditions ventes client (Paysage)';
        //         Description = 'DITW18.00.06 GVC 07/05/2015  DIT-770  #1335';
        //         Image = "report";
        //         Promoted = false;
        //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //         //PromotedCategory = "Report";

        //         trigger OnAction();
        //         var
        //             CustSalesCond1_lRep: Report "Cust Sales Cond Landscape";
        //             tmpCust_lRec: Record Customer;
        //         begin
        //             CurrPage.SETSELECTIONFILTER(tmpCust_lRec);
        //             CustSalesCond1_lRep.SETTABLEVIEW(tmpCust_lRec);
        //             CustSalesCond1_lRep.RUN;
        //         end;
        //     }
        //     action("Customer Sales Conditions (Portrait)")
        //     {
        //         CaptionML = ENU = 'Customer Sales Conditions (Portrait)',
        //                     FRA = 'Conditions ventes client (Portrait)';
        //         Description = 'DITW18.00.06 GVC 07/05/2015  DIT-770  #1335';
        //         Image = "report";
        //         Promoted = false;
        //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //         //PromotedCategory = "Report";

        //         trigger OnAction();
        //         var
        //             CustSalesCond_lRep: Report "Cust Sales Cond Portrait";
        //             tmpCust_lRec: Record Customer;
        //         begin
        //             CurrPage.SETSELECTIONFILTER(tmpCust_lRec);
        //             CustSalesCond_lRep.SETTABLEVIEW(tmpCust_lRec);
        //             CustSalesCond_lRep.RUN;
        //         end;
        //     }
        //     action("Sales Price-Breakdown List")
        //     {
        //         Caption = 'Sales Price-Breakdown List';
        //         Description = 'NRQ6581';
        //         Image = "Report";
        //         RunObject = Report "Sales Price-Breakdown List";

        //         trigger OnAction();
        //         begin
        //             RunReport(REPORT::"Sales Price-Breakdown List", "No.");
        //         end;
        //     }
        // }
        // group("Financial Management")
        // {
        //     CaptionML = ENU = 'Financial Management',
        //                 FRA = 'Gestion financière';
        //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
        // }


        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Pages 
        // moveafter(BackgroundStatement_Promoted;"Report Customer - Labels")
        addafter("Report Statement")
        {
            group(General1)
            {
                Caption = 'General';

                action("Customer Statement")
                {
                    ApplicationArea = All;
                    Image = "Report";
                    ToolTip = 'Executes the Customer Statement action.';

                    trigger OnAction()
                    begin
                        RunReport(REPORT::"Customer Statement SL CBN", Rec."No.");//HEI.39
                    end;
                }
                action("RPM Balance Accounting")
                {
                    ApplicationArea = All;
                    Caption = 'RPM Balance Accounting';
                    Image = "Report";
                    ToolTip = 'Executes the RPM Balance Accounting action.';

                    trigger OnAction();
                    begin
                        RunReport(REPORT::"RPM Balance Accounting CBN", Rec."No."); //HEI.13
                    end;
                }

            }




        }



        movebefore("Customer Statement"; "Report Statement")
    }

    var
        NewMode: Boolean;//Bc Upgrade YADAVM09
        SalesLine: Record "Sales Line";
        SalesAmt1: Decimal;
        SalesAmt2: Decimal;
        ValueEntry: Record "Value Entry";
        ValueEntryAmt: Decimal;


    //Unsupported feature: PropertyModification on "OverduePaymentsMsg(Variable 1033)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OverduePaymentsMsg : @@@=Overdue Payments as of 27-02-2012;ENU=Overdue Payments as of %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OverduePaymentsMsg : @@@=Overdue Payments as of 27-02-2012;ENU=Overdue Payments as of %1;FRA=Paiements échus au %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "PostedInvoicesMsg(Variable 1036)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PostedInvoicesMsg : @@@=Invoices (5);ENU=Posted Invoices (%1);
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PostedInvoicesMsg : @@@=Invoices (5);ENU=Posted Invoices (%1);FRA=Factures enregistrées (%1);
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CreditMemosMsg(Variable 1037)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CreditMemosMsg : @@@=Credit Memos (3);ENU=Posted Credit Memos (%1);
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreditMemosMsg : @@@=Credit Memos (3);ENU=Posted Credit Memos (%1);FRA=Avoirs enregistrés (%1);
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OutstandingInvoicesMsg(Variable 1039)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OutstandingInvoicesMsg : @@@=Ongoing Invoices (4);ENU=Ongoing Invoices (%1);
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OutstandingInvoicesMsg : @@@=Ongoing Invoices (4);ENU=Ongoing Invoices (%1);FRA=Factures en cours (%1);
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OutstandingCrMemosMsg(Variable 1038)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OutstandingCrMemosMsg : @@@=Ongoing Credit Memos (4);ENU=Ongoing Credit Memos (%1);
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OutstandingCrMemosMsg : @@@=Ongoing Credit Memos (4);ENU=Ongoing Credit Memos (%1);FRA=Avoirs en cours (%1);
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ShowMapLbl(Variable 1066)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShowMapLbl : ENU=Show on Map;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShowMapLbl : ENU=Show on Map;FRA=Afficher sur une carte;
    //Variable type has not been exported.




    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CreateCustomerFromTemplate;
    ActivateFields;
    StyleTxt := SetStyle;
    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    CRMIsCoupledToRecord := CRMIntegrationEnabled and CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
    OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
    OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
    GetSalesPricesAndSalesLineDisc;
    DynamicEditable := CurrPage.EDITABLE;

    CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);

    EventFilter := WorkflowEventHandling.RunWorkflowOnSendCustomerForApprovalCode + '|' +
      WorkflowEventHandling.RunWorkflowOnCustomerChangedCode;

    EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::Customer,EventFilter);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //HEI.09 >>
    //CreateCustomerFromTemplate;
    CreateCustomerFromCustomerTemplate;
    //HEI.09 <<
    #2..7
    // <<DITW15.00.00.39 DDR 30/08/2011 #1397 - DITW16.00.00.41 AHU 07/08/2012 DIT-715 #327
    GetCalcContractBalanceLCY(BalanceSubContractLCY);
    // >>DITW15.00.00.39 DDR #1397 - DITW16.00.00.41 AHU DIT-715 #327
    //HEI.30>>
    CompanyInfo.GET;
    if not CompanyInfo."Enable French Localization" then
    //HEI.30<<
    GetSalesPricesAndSalesLineDisc;

    //HEI.30>>
    if CompanyInfo."Enable French Localization" then
      if FoundationOnly then
        GetSalesPricesAndSalesLineDisc;
    //HEI.30<<
    #9..16
    //HEI.28>>
    if AccountGroup.GET("Account Group FND") then
      Vsb := AccountGroup."Contract type Editable";
    //HEI.28<<
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger (Variable: SalesLine)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ActivateFields;
    StyleTxt := SetStyle;
    BlockedCustomer := (Blocked = Blocked::All);
    BalanceExhausted := 10000 <= CalcCreditLimitLCYExpendedPct;
    DaysPastDueDate := AgedAccReceivable.InvoicePaymentDaysAverage("No.");
    AttentionToPaidDay := DaysPastDueDate > 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6


    //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
    if "Invoice Method" <> "Invoice Method"::" " then
      blnEditable := false
    else
      blnEditable := true;

    if (("Invoice Method" = "Invoice Method"::"Combine Shipments") or
       ("Invoice Method" = "Invoice Method"::"Combine Shipments Per Sell-to")) then
      "Combine Shipments" := true;

    if (("Invoice Method" = "Invoice Method"::Shipment) or
       ("Invoice Method" = "Invoice Method"::Order)) then
      "Combine Shipments" := false;
    //>>DITW17.00.02 TEC1 DIT-770 #154
    //HEI.03>>
    if Blocked <> Blocked::" " then
      BlockedCustomer := (Blocked = Blocked::All);
    //HEI.03<<

    //>> HEI.11
    SalesAmt1:=0.0;
    SalesAmt2:=0.0;
    SalesLine.RESET;
    SalesLine.SETRANGE("Bill-to Customer No.","No.");
    SalesLine.SETRANGE(Status,SalesLine.Status::Released);  //New Code
    //SalesLine.SETRANGE("Item Charge Type",SalesLine."Item Charge Type"::Deposit);  //As per comments from IDA
    SalesLine.SETFILTER("RPM Solution",'%1|%2',SalesLine."RPM Solution"::"Full-for Empty without revenue impact (FFE w/o revenue)",SalesLine."RPM Solution"::"Full-for-Empty with revenue impact (FFE with revenue)");
    if SalesLine.FINDSET then begin
      repeat
        if SalesLine."Document Type" = SalesLine."Document Type"::Order then
          SalesAmt1 += SalesLine.Amount
           else
            if SalesLine."Document Type" = SalesLine."Document Type"::"Return Order" then
              SalesAmt2 += SalesLine.Amount;
        until SalesLine.NEXT =0;
    end;

    "Open Sales RPM Value" := SalesAmt1 - SalesAmt2;

    //<<HEI.11
    //>> HEI.11
    ValueEntryAmt:=0.0;
    ValueEntry.RESET;
    ValueEntry.SETCURRENTKEY("Source Type","Source No.","Global Dimension 1 Code","Global Dimension 2 Code","Item No.","Posting Date","Initial Entry Due Date","Entry Type",Adjustment,"Item Charge Type","Item Charge No.");  //HEI.40
    ValueEntry.SETRANGE("Item Charge Type",ValueEntry."Item Charge Type"::Deposit);
    ValueEntry.SETRANGE("Source Type",ValueEntry."Source Type"::Customer);
    ValueEntry.SETRANGE("Source No.","No.");
    //ValueEntry.SETRANGE("Global Dimension 1 Code","Global Dimension 1 Filter");
    //ValueEntry.SETRANGE("Global Dimension 2 Code","Global Dimension 1 Filter");
    //ValueEntry.SETRANGE("Empty Goods Item No.","Empty Goods Item No. Filter");
    ValueEntry.SETFILTER("RPM Solution",'%1|%2',ValueEntry."RPM Solution"::"Full-for Empty without revenue impact (FFE w/o revenue)",ValueEntry."RPM Solution"::"Full-for-Empty with revenue impact (FFE with revenue)");
    if ValueEntry.FINDSET then begin
      repeat
        ValueEntryAmt += ValueEntry."Sales Deposit Amount (Actual)";
       until ValueEntry.NEXT = 0;
      end;

    "RPM Exposure" := ValueEntryAmt + "Open Sales RPM Value";
    //>> HEI.11

    //HEI.22>>
    if ("Account Group FND" <> '') and (CustaccountGroup.GET("Account Group FND")) then begin
      if CustaccountGroup."Trading End Date Enable" then
        TEDIsEditable := true
      else
        TEDIsEditable := false;
    end;
    //HEI.22<<

    //<<HEI.19
    if AccountGroup.GET("Account Group FND") then begin
      if AccountGroup."Contract type Editable" then
          Vsb := true
        else
          Vsb := false
    end;
    //>>HEI.19
    */
    //end;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FoundationOnly := ApplicationAreaSetup.IsFoundationEnabled;

    SetCustomerNoVisibilityOnFactBoxes;

    ContactEditable := true;

    OpenApprovalEntriesExistCurrUser := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    //<<DITW17.00.02 RPG 05/11/2013 DIT-770 #235
    BilltoContactEditable := true;
    //<<DITW17.00.02 RPG DIT-770 #235

    OpenApprovalEntriesExistCurrUser := true;
    */
    //end;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if GUIALLOWED then
      if "No." = '' then
        if DocumentNoVisibility.CustomerNoSeriesIsDefault then
          NewMode := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //<<FINXL8.00.001 BSA 23/06/2015 #161
    if recFinXLSetup.READPERMISSION then
      AutomaticApplyTemplate;
    //>>FINXL8.00.001 BSA 23/06/2015 #161

    #1..4
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ActivateFields;

    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    SetNoFieldVisible;
    IsOfficeAddin := OfficeManagement.IsAvailable;

    CurrPage.PriceAndLineDisc.PAGE.InitPage(false);

    ShowCharts := "No." <> '';
    if ShowCharts then begin
      CurrPage.AgedAccReceivableChart.PAGE.SetPerCustomer;
      CurrPage.AgedAccReceivableChart2.PAGE.SetPerCustomer;
    end;
    SETFILTER("Date Filter",CustomerMgt.GetCurrentYearFilter);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
    RunModeCaptionPM := SetCaptionClassPM();
    if RunModeCaptionPM then begin
      CurrPage.CAPTION := Text2014310_0;
    end;
    FILTERGROUP(0);
    BTCustVisible := not RunModeCaptionPM;
    BTPlantVisible := RunModeCaptionPM;
    // >>DITW16.00.00.41 DDR DIT-715 #297
    //<< DITW18.00.07 AKH 28/03/2016 DIT-770 #1409
    EnableShowExternalDocMandatory();
    //>> DITW18.00.07 AKH DIT-770 #1409

    #1..6
    //HEI.30>>
    CompanyInfo.GET;
    if not CompanyInfo."Enable French Localization" then
    //HEI.30<<
    CurrPage.PriceAndLineDisc.PAGE.InitPage(false);

    //HEI.30>>
    if CompanyInfo."Enable French Localization" then
      if FoundationOnly then
        CurrPage.PriceAndLineDisc.PAGE.InitPage(false);
    //HEI.30<<
    #8..14
    //HEI.22>>
    TEDIsEditable := true;
    //HEI.22<<

    //<<HEI.19
    if AccountGroup.GET("Account Group FND") then begin
      if AccountGroup."Contract type Editable" then
          Vsb := true
        else
          Vsb := false
    end;
    //>>HEI.19
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnQueryClosePage". Please convert manually.

    //trigger OnQueryClosePage(CloseAction : Action) : Boolean;
    //begin
    /*
    //HEI.04>>
    HeinekenGlobal."ValidateBlockCustomer&ReasonCode"(Rec."No.");
    //HEI.04<<
    */
    //end;


    //Unsupported feature: CodeModification on "ActivateFields(PROCEDURE 3)". Please convert manually.

    //procedure ActivateFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetSocialListeningFactboxVisibility;
    ContactEditable := "Primary Contact No." = '';
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetSocialListeningFactboxVisibility;
    ContactEditable := "Primary Contact No." = '';

    //<<DITW17.00.02 RPG 05/11/2013 DIT-770 #235
    BilltoContactEditable := "Bill-to Contact No." = '';
    //<<DITW17.00.02 RPG DIT-770 #235
    */
    //end;
    trigger OnOpenPage()
    begin
        //HEI.22>>
        TEDIsEditable := TRUE;
        //HEI.22<<

        //<<HEI.19
        IF AccountGroup.GET(Rec."Account Group FND") THEN BEGIN
            IF AccountGroup."Contract type Editable" THEN
                Vsb := TRUE
            ELSE
                Vsb := FALSE
        END;
        //>>HEI.19
    end;


    trigger OnAfterGetRecord()
    begin
        //HEI.03>>
        IF Rec.Blocked <> Rec.Blocked::" " THEN
            BlockedCustomer := (Rec.Blocked = Rec.Blocked::All);
        //HEI.03<<

        //>> HEI.11
        SalesAmt1 := 0.0;
        SalesAmt2 := 0.0;
        SalesLine.RESET();
        SalesLine.SETRANGE("Bill-to Customer No.", Rec."No.");
        // SalesLine.SETRANGE(Status, SalesLine.Status::Released);  //New Code // BC Upgrade BHARDA11 ---Drink-IT Field
        //SalesLine.SETRANGE("Item Charge Type",SalesLine."Item Charge Type"::Deposit);  //As per comments from IDA
        SalesLine.SETFILTER("RPM Solution FND", '%1|%2', SalesLine."RPM Solution FND"::"Full-for Empty without revenue impact (FFE w/o revenue)", SalesLine."RPM Solution FND"::"Full-for-Empty with revenue impact (FFE with revenue)");
        IF SalesLine.FINDSET() THEN BEGIN
            REPEAT
                IF SalesLine."Document Type" = SalesLine."Document Type"::Order THEN
                    SalesAmt1 += SalesLine.Amount
                ELSE
                    IF SalesLine."Document Type" = SalesLine."Document Type"::"Return Order" THEN
                        SalesAmt2 += SalesLine.Amount;
            UNTIL SalesLine.NEXT() = 0;
        END;

        Rec."Open Sales RPM Value FND" := SalesAmt1 - SalesAmt2;

        //<<HEI.11
        //>> HEI.11
        ValueEntryAmt := 0.0;
        ValueEntry.RESET();
        // ValueEntry.SETCURRENTKEY("Source Type", "Source No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Item No.", "Posting Date", "Initial Entry Due Date", "Entry Type", Adjustment, "Item Charge Type", "Item Charge No.");  //HEI.40 // BC Upgrade BHARDA11 ----Drink-IT Fields ("Initial Entry Due Date","Item Charge Type")
        ValueEntry.SETCURRENTKEY("Source Type", "Source No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Item No.", "Posting Date", "Entry Type", Adjustment, "Item Charge No.");  //HEI.40 
        // ValueEntry.SETRANGE("Item Charge Type", ValueEntry."Item Charge Type"::Deposit); // BC Upgrade BHARDA11 ----Drink-IT Field ("Item Charge Type")
        ValueEntry.SETRANGE("Source Type", ValueEntry."Source Type"::Customer);
        ValueEntry.SETRANGE("Source No.", Rec."No.");
        //ValueEntry.SETRANGE("Global Dimension 1 Code","Global Dimension 1 Filter");
        //ValueEntry.SETRANGE("Global Dimension 2 Code","Global Dimension 1 Filter");
        //ValueEntry.SETRANGE("Empty Goods Item No.","Empty Goods Item No. Filter");
        ValueEntry.SETFILTER("RPM Solution FND", '%1|%2', ValueEntry."RPM Solution FND"::"Full-for Empty without revenue impact (FFE w/o revenue)", ValueEntry."RPM Solution FND"::"Full-for-Empty with revenue impact (FFE with revenue)");
        IF ValueEntry.FINDSET() THEN BEGIN
            REPEAT
            // ValueEntryAmt += ValueEntry."Sales Deposit Amount (Actual)"; // BC Upgrade BHARAD11 ----Drink-IT Field ("Sales Deposit Amount (Actual)")
            UNTIL ValueEntry.NEXT() = 0;
        END;

        REc."RPM Exposure FND" := ValueEntryAmt + Rec."Open Sales RPM Value FND";
        //>> HEI.11

        //HEI.22>>
        IF (REc."Account Group FND" <> '') AND (CustaccountGroup.GET(REc."Account Group FND")) THEN BEGIN
            IF CustaccountGroup."Trading End Date Enable" THEN
                TEDIsEditable := TRUE
            ELSE
                TEDIsEditable := FALSE;
        END;
        //HEI.22<<

        //<<HEI.19
        IF AccountGroup.GET(REc."Account Group FND") THEN BEGIN
            IF AccountGroup."Contract type Editable" THEN
                Vsb := TRUE
            ELSE
                Vsb := FALSE
        END;
        //>>HEI.19
    end;
    // BC Upgrade BHARDA11 >> ---- Code is  already written in Codeunit 50015 
    // trigger OnQueryClosePage(CloseAction: Action): Boolean
    // begin
    //     //HEI.04>>
    //     HeinekenGlobal."ValidateBlockCustomer&ReasonCode"(Rec."No.");
    //     //HEI.04<<
    // end;

    // BC Upgrade BHARDA11 << ---- Code is  already written in Codeunit 50015 
    trigger OnAfterGetCurrRecord()
    begin
        // BC Upgrade BHARDA11 --- CreateCustomerFromTemplate base function is comment in navision and custom function call
        //HEI.09 >>
        //CreateCustomerFromTemplate;
        CreateCustomerFromCustomerTemplate();
        //HEI.09 <<
        //HEI.28>>
        IF AccountGroup.GET(Rec."Account Group FND") THEN
            Vsb := AccountGroup."Contract type Editable";
        //HEI.28<<
    end;

    var
        BlockedCustomer: Boolean;
        CalendarMgmt: Codeunit "Calendar Management";
        DynamicEditable: Boolean;
        // TeleSalesSetup : Record 2013919;
        BalanceSubContractLCY: ARRAY[7] OF Decimal;
        RunModeCaptionPM: Boolean;
        Text2014310_0: Label 'ENU=Plant Card;FRA=Fiche usine';
        // BTCustVisible: Boolean INDATASET;
        // BTPlantVisible: Boolean INDATASET;
        blnEditable: Boolean;
        BilltoContactEditable: Boolean;
        ShowExtDocNoMandatoryDefaultNo: Boolean;
        ShowExtDocNoMandatoryDefaultYes: Boolean;
        // recFinXLSetup: Record 2029610; // BC Upgrade BHARDA11 ----Drink-IT Table
        DisputeErr: Label 'ENU=Open dispute cases exist for customer %1 Do you want to continue?';
        "Cust.LedEntry": Record "Cust. Ledger Entry";
        DisputeExists: Boolean;
        Error001: Label 'ENU=Blocked Reason code must have a value in Customer No. %1';
        Error002: Label 'ENU=Blocked must not be blank in Customer No. %1';
        HeinekenGlobal: Codeunit "Heineken Global";
        PostedCustomerDiffRPMPage: Page "Posted Customer Diff (RPM) CBN";
        PostedCustomerDiffRPMRec: Record "Posted Customer Diff RPM FND";
        TEDIsEditable: Boolean;
        CustaccountGroup: Record "Account Group FND";
        AccountGroup: Record "Account Group FND";
        Vsb: Boolean;
        CompanyInfo: Record "Company Information";
        // Training: Codeunit 50237; 
        CustomizedCalEntry: Record "Customized Calendar Entry";
    // BC Upgrade BHARDA11 >> Drink-IT Function (AutomaticApplyTemplate)
    // local procedure AutomaticApplyTemplate();
    // var
    //     RecRef: RecordRef;
    //     lrecRefCustomer: RecordRef;
    //     CuConf: Codeunit "Config. Template Management";
    //     CodePackageID: Code[10];
    //     ConfigTemplateHeader: Record "Config. Template Header";
    //     lrecGeneralLedgerSetup: Record "General Ledger Setup";
    // begin
    //     //<<FINXL8.00.001 BSA 23/06/2015 #161
    //     lrecGeneralLedgerSetup.GET;
    //     if lrecGeneralLedgerSetup."Apply template" then begin
    //         RecRef.GETTABLE(Rec);
    //         ConfigTemplateHeader.SETRANGE("Table ID", RecRef.NUMBER);
    //         if PAGE.RUNMODAL(PAGE::"Config. Template List", ConfigTemplateHeader, ConfigTemplateHeader.Code) = ACTION::LookupOK then begin
    //             lrecRefCustomer.GETTABLE(Rec);
    //             CuConf.InsertTemplate2(lrecRefCustomer, ConfigTemplateHeader);
    //             lrecRefCustomer.SETTABLE(Rec);
    //         end;
    //     end;
    //     //>>FINXL8.00.001 BSA 23/06/2015 #161
    // end;

    local procedure BuildingNoOnAfterValidate();
    begin
        CurrPage.UPDATE(true);
        COMMIT();
        // Rec.CALCFIELDS("Building Employment Date", "Building Last Inactive Date"); // BC Upgrade BHARDA11 --- Drink-IT Fields
    end;

    local procedure NoofDrinkDiscGroupsOnActivate();
    begin
        // <<DITW15.00.00.35 DDR 19/08/2009
        CurrPage.UPDATE(true);
        // >>DITW15.00.00.35 DDR
    end;

    local procedure NoofPromotionGroupsOnActivate();
    begin
        // <<DITW15.00.00.35 DDR 19/08/2009
        CurrPage.UPDATE(true);
        // >>DITW15.00.00.35 DDR
    end;

    local procedure NoofExclusivityGroupsOnActivat();
    begin
        CurrPage.UPDATE(true);
    end;

    local procedure NoofLoyaltyGroupsOnActivate();
    begin
        CurrPage.UPDATE(true);
    end;

    local procedure NoofQuotaGroupsOnActivat();
    begin
        CurrPage.UPDATE(true);
    end;

    procedure EnableShowExternalDocMandatory();
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        //<< DITW18.00.07 AKH 28/03/2016 DIT-770 #1409
        SalesSetup.GET();
        ShowExtDocNoMandatoryDefaultYes := SalesSetup."Ext. Doc. No. Mandatory";
        ShowExtDocNoMandatoryDefaultNo := not ShowExtDocNoMandatoryDefaultYes;
    end;
    //Bc Upgrade YADAVM09>>
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        if GuiAllowed then
            if Rec."No." = '' then
                if DocumentNoVisibility.CustomerNoSeriesIsDefault() then
                    NewMode := true;
    end;
    //Bc Upgrade YADAVM09<<
    local procedure CreateCustomerFromCustomerTemplate()
    var
        // CustomerTemplateList: Page "Customer Template List"; // BC Upgrade BHARDA11 --- Not Found in BC REplace with "Customer Templ. List"
        // CustomerTemplate: Record "Customer Template";  // BC Upgrade BHARDA11 --- Not Found in BC Replace with "Customer Templ."
        SalesReceivablesSetupL: Record "Sales & Receivables Setup";
        CustomerTemplateList: Page "Customer Templ. List"; // BC Upgrade BHARDA11 --- Not Found in BC
        CustomerTemplate: Record "Customer Templ.";  // BC Upgrade BHARDA11 --- Not Found in BC
    begin
        // HEI.09 >>
        // BC Upgrade BHARDA11 >> --- 
        // if NewMode then begin // Bc Upgrade BHARDA11 ----Remove this NewMode because the newmode is True Bydefauld and we handel this function by event OnBeforeCreateCustomerFromTemplate
        IF NewMode THEN BEGIN //Bc Upgrade YADAVM09
            CustomerTemplateList.SETTABLEVIEW(CustomerTemplate);
            CustomerTemplateList.SETRECORD(CustomerTemplate);
            if CustomerTemplateList.RUNMODAL() = ACTION::OK then begin
                CustomerTemplateList.GETRECORD(CustomerTemplate);
                // REc."Customer Template Code" := CustomerTemplate.Code; // BC Upgrade BHARDA11 ----Drink-IT Field("Customer Template Code")
                Rec."Global Dimension 1 Code" := CustomerTemplate."Global Dimension 1 Code";
                Rec."Global Dimension 2 Code" := CustomerTemplate."Global Dimension 2 Code";
                Rec."Customer Posting Group" := CustomerTemplate."Customer Posting Group";
                Rec."Currency Code" := CustomerTemplate."Currency Code";
                Rec."Customer Price Group" := CustomerTemplate."Customer Price Group";
                Rec."Payment Terms Code" := CustomerTemplate."Payment Terms Code";
                Rec."Shipment Method Code" := CustomerTemplate."Shipment Method Code";
                Rec."Invoice Disc. Code" := CustomerTemplate."Invoice Disc. Code";
                Rec."Customer Disc. Group" := CustomerTemplate."Customer Disc. Group";
                Rec."Country/Region Code" := CustomerTemplate."Country/Region Code";
                Rec."Payment Method Code" := CustomerTemplate."Payment Method Code";
                Rec."Gen. Bus. Posting Group" := CustomerTemplate."Gen. Bus. Posting Group";
                Rec."VAT Bus. Posting Group" := CustomerTemplate."VAT Bus. Posting Group";
                Rec."Allow Line Disc." := CustomerTemplate."Allow Line Disc.";
                //<<HEI.31
                //    Rec.Account Group" := CustomerTemplate."Account Group FND";
                Rec.VALIDATE("Account Group FND", CustomerTemplate."Account Group FND");
                //>>HEI.31
                // BC Upgrade BHARDA11 >> ----Drink-It Fields("Customer DDeposit Group Code","Customer DTax Group Code","No. of Drink Disc. Groups","No. of Promotion Groups",Distance,"Ext. Doc. No. Mandatory",Exclusivity,"Tax Office Code","Empty Returned Items Based On","Loan Interest Cust. Post. Grp.","Contract Cust. Post. Gr. Stand","Contract Cust. Post. Gr. Rent","Contract Cust. Post. Gr. Loan","Contract Cust. Post. Gr. LoanU","Contract Cust. Post. Gr. Maint","Contract Cust. Post. Gr. Other","Contract Cust. Post. Gr. Plant","Empty Goods Statement On","Credit Limit","Invoice Method","Customer DDeposit Group Code","Gen. Bus. Posting Free Group","Free Item Posting Type")
                // Rec."Customer DDeposit Group Code" := CustomerTemplate."DDeposit Group Code";
                // Rec."Customer DTax Group Code" := CustomerTemplate."DTax Group Code";
                // Rec."No. of Drink Disc. Groups" := CustomerTemplate."No. of Drink Disc. Groups";
                // Rec."No. of Promotion Groups" := CustomerTemplate."No. of Promotion Groups";
                // Rec.Distance := CustomerTemplate.Distance;
                // Rec."Ext. Doc. No. Mandatory" := CustomerTemplate."E    xt. Doc. No. Mandatory";
                // Rec.Exclusivity := CustomerTemplate.Exclusivity;
                // Rec."Tax Office Code" := CustomerTemplate."Tax Office Code";
                // Rec."Empty Returned Items Based On" := CustomerTemplate."Empty Returned Items Based On";
                // Rec."Loan Interest Cust. Post. Grp." := CustomerTemplate."Loan Interest Cust. Post. Grp.";
                // Rec."Contract Cust. Post. Gr. Stand" := CustomerTemplate."Contract Cust. Post. Gr. Stand";
                // Rec."Contract Cust. Post. Gr. Rent" := CustomerTemplate."Contract Cust. Post. Gr. Rent";
                // Rec."Contract Cust. Post. Gr. Loan" := CustomerTemplate."Contract Cust. Post. Gr. Loan";
                // Rec."Contract Cust. Post. Gr. LoanU" := CustomerTemplate."Contract Cust. Post. Gr. LoanU";
                // Rec."Contract Cust. Post. Gr. Maint" := CustomerTemplate."Contract Cust. Post. Gr. Maint";
                // Rec."Contract Cust. Post. Gr. Other" := CustomerTemplate."Contract Cust. Post. Gr. Other";
                // Rec."Contract Cust. Post. Gr. Plant" := CustomerTemplate."Contract Cust. Post. Gr. Plant";
                // Rec."Empty Goods Statement On" := CustomerTemplate."Empty goods statement on";
                // BC Upgrade BHARDA11 << ----Drink-It Fields("Customer DDeposit Group Code","Customer DTax Group Code","No. of Drink Disc. Groups","No. of Promotion Groups",Distance,"Ext. Doc. No. Mandatory",Exclusivity,"Tax Office Code","Empty Returned Items Based On","Loan Interest Cust. Post. Grp.","Contract Cust. Post. Gr. Stand","Contract Cust. Post. Gr. Rent","Contract Cust. Post. Gr. Loan","Contract Cust. Post. Gr. LoanU","Contract Cust. Post. Gr. Maint","Contract Cust. Post. Gr. Other","Contract Cust. Post. Gr. Plant","Empty Goods Statement On","Credit Limit")

                Rec."Location Code" := CustomerTemplate."Location Code";
                Rec."Base Calendar Code" := CustomerTemplate."Base Calendar Code";
                Rec."Responsibility Center" := CustomerTemplate."Responsibility Center";

                Rec."Application Method" := CustomerTemplate."Application Method";
                Rec."Reminder Terms Code" := CustomerTemplate."Reminder Terms Code";
                Rec."Fin. Charge Terms Code" := CustomerTemplate."Fin. Charge Terms Code";
                Rec."Shipping Agent Code" := CustomerTemplate."Shipping Agent Code";
                Rec."Shipping Agent Service Code" := CustomerTemplate."Shipping Agent Service Code";
                //<<HEI.19
                // Rec."Credit Limit" := CustomerTemplate."Credit Limit"; // BC Upgrade BHARDA11 ----Drink-IT Field
                Rec."Credit Limit (LCY)" := CustomerTemplate."Credit Limit (LCY)";
                Rec."RPM Exposure FND" := CustomerTemplate."RPM Exposure FND";
                Rec."Risk Category FND" := CustomerTemplate."Risk Category FND";
                Rec."Risk Score FND" := CustomerTemplate."Risk Score FND";
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Invoice Method","Customer DDeposit Group Code","Gen. Bus. Posting Free Group","Free Item Posting Type")
                // Rec."Invoice Method" := CustomerTemplate."Invoice Method";
                // Rec."Customer DDeposit Group Code" := CustomerTemplate."Customer DDeposit Group Code";
                // Rec."Gen. Bus. Posting Free Group" := CustomerTemplate."Gen. Bus. Posting Free Group";

                // Rec."Free Item Posting Type" := CustomerTemplate."Free Item Posting Type";
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Invoice Method","Customer DDeposit Group Code","Gen. Bus. Posting Free Group","Free Item Posting Type")
                Rec."WHT Business Posting Group FND" := CustomerTemplate."WHT Business Posting Group FND";
                //>>HEI.19
                //HEI.32>>
                SalesReceivablesSetupL.GET();
                Rec.VALIDATE(Blocked, CustomerTemplate.Blocked);
                if CustomerTemplate.Blocked <> CustomerTemplate.Blocked::" " then begin
                    SalesReceivablesSetupL.TESTFIELD("Block Reason for New Cust. FND");
                    Rec."Blocked Reason Code FND" := SalesReceivablesSetupL."Block Reason for New Cust. FND";
                end;
                //HEI.32<<
                CurrPage.UPDATE();
            end;
            NewMode := false;//Bc Upgrade YADAVM09
        end; // BC Upgrade BHARDA11 --- Cmnt end;
        // BC Upgrade BHARDA11 << --- 

    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

