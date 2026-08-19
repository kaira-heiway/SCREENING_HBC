page 53031 "CTS Order"
{
    // version NAVW110.0.00.16585,FINXL8.00,DITW110.00.11,HEI.09
    // DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 14/01/2008 Remove seperation line from Function button
    // DITW15.00.00.01 DDR 17/01/2008 some Captions
    //                                New calling functions to insert (item) charges
    // DITW15.00.00.01 DDR 21/01/2008 Correct menuitem "Get Price" into function button
    // DITW15.00.00.01 DDR 27/02/2008 Drink-it Return Deposit functionnalities
    //                                Added menu "Create &Return Order" into Function button + shortcut Shift+F3
    //                                Added menu "&Return Orders" into "Order" button
    //                                Added field "No. of Return Orders" (general tab)
    // DITW15.00.00.01 DDR 11/03/2008 Added menu "Return Receipts" into "Order" button
    //                                Remove counter return orders
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.20 DDR 06/06/2008 Certification rules
    // DITW15.00.00.24 DDR 14/08/2008 Added "shipping Agent" Tab
    //                                Added function FormatMaximumControls()
    //                                Added form property CalcFields("Total Weight","Total Cubage")
    //                                Added fields (not editable)
    //                                  "Maximum Weight","Maximum Cubage",
    //                                  "Total Weight","Total Cubage"
    //                 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    // DITW15.00.00.25 DDR 09/10/2008 Bugfix refreshing fields "Maximum Weight","Maximum Cubage" with color
    //                                 into function FormatMaximumControls()
    //                                Added fields "Truck Code","Driver Code" into Shipping Agent tab
    //                                Refresh Header before call Posting document
    //                     21/10/2008 Deleted field2013722 Duty Tax Type
    //                                Added fields "Customer DTax Group Code" into Invoicing tab
    // DITW15.00.00.26 DDR 31/10/2008 Added menu into "Function" button
    //                                  Get Delayed Discount
    //                                  Get Delayed Promotion
    // DITW15.00.00.28 DDR 24/11/2008 Added "Fiscal Representative No." into Shipping tab
    //                                Added menu "Test ADD Document" into "Print" button
    // DITW15.00.00.31 DDR 19/02/2009 Removed menus (not used)
    //                                 "Cre&ate/Modify Packing List" from Functions button
    //                                 "Order Confirmation (Packing)" from Print button
    // DITW15.00.00.32 DDR 16/03/2009 Removed menus (not used)
    //                                 "Order Confirmation (Packing)" from Print button
    // DITW15.00.00.33 DDR 07/05/2009 Move field "Customer DTax Group Code" into 'General' tab
    //  HLW15.00.01.01 DDR 05/06/2008 Added packing list functionality on button functions and print
    //                                               Added menu "Packing Order Confirmation" into "Print" Button
    // DITW15.00.00.34 DDR 16/06/2009 Added auto-release document into menu 'Create Whse. shipment'
    //                     17/06/2009 Added shortcut key CTRL+F10 to switch status 'open' the current document
    //                                Changed Editable "Status" field
    //                                Added functions DocStatusRelease(),DocStatusOpen(),
    //                     07/07/2009 Design move all bottom buttons in form
    // DITW15.00.00.35 DDR 24/04/2009 Added "Building No." into General tab
    // DITW15.00.00.36 DDR 07/12/2009 issue 981 Bugfix Save/Refresh before release function
    // DITW15.00.00.37 DDR 18/06/2010 issue 1028 Added Addtional credit limits and delayed discounts to calculate the available credit
    //                                           Added 'SalesOrderDate' parameter CalcAvailableCredit()
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 19/11/2010 issue 1139 SSCC Functionnalities
    //                                  Added menu 'SSCC Tracking Lines' in 'Line' buttton
    //                 DDR 27/01/2011 issue 1217 (DIT711 137) Added fields "Tax Office Code" into 'Shipping' tab
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                           Added parameter line function RTCActionNewLine() into RTCNewLine button
    // DITW15.00.00.39 DDR 27/04/2011 issue 1323 NAVBE5.00 (SP1) functionnality to insert Customer Std. Sales Codes automatically
    //                                Added to call function StdCustSalesCode.AutoInsertSalesLines()
    //                                  from OnAfterValidate trigger field "Sell-to Customer No."
    // DITW15.00.00.39 RBE 20/04/2011 issue 1230 Telesales functionnalities
    //                                  Added call function CopyCustCommentToSales() into field "Sell-to Customer No."
    //                                  Added Picking List & Shipping List into button "Print"
    //                                  Added field "Order Type","Entry Type"
    //                     21/04/2011 Added columns "Delivery Sequence","Shipment Time","Delivery Time","Promised Delivery Date",
    //                                  "Location Code","Shipping Time"
    // DITW15.00.00.39 DDR 10/05/2011 issue 1330 Upgrade editable Status to work with Prepayments
    //                                           Remove 'ShowConfirmMsg' parameter function DocStatusOpen();
    //                                           Modified functions DocStatusOpen(),DocStatusRelease()
    //                                           Modified validate trigger field "Status"
    //                     28/06/2011 issue 1330 Bugfix conflict between status "Pending Approval" and "Pending Prepayment"
    //                                             when releasing (attempt)
    //                     06/07/2011 issue 1353 Added fields "Journey Time"
    //                     27/07/2011 issue 1407 Added flowfields "Disc.Promo. Order Calculated" (see "Zoom view)
    //                                           Moved/Deleted functions into codeunit414 Release Sales Document
    //                                             DocStatusRelease(),DocStatusOpen()
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                              Added to insert first line automatically
    //                     19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    //                                issue 1364 Added 'Update Sales Order' menu into button "Functions"
    //                                           Added functions ShowUpdateSalesOrder()
    //                     22/08/2011 issue 1399 Added fields into 'Shipping' tab
    //                                             "Whse. Shipment No. (First)","Whse. Shipment Status (First)"
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields "Delivery Sequence","Route" (Shipping Agent tab)
    //                     22/12/2011 DIT-715 issue 187 Added 'Comments - Transport Mode' menu into 'Order' button
    //                                                  Added fields into 'Foreign Trade' tab
    //                                                    "Transport Mode","Transport Mode Comment"
    //                     11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  call function SetDisableRefreshLines() before each report
    //                                                  (don't use the <RunObject> property)
    //                     03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
    //                                           Added menuitem "Automatic FEFO Tracking" in menu Line & Functions
    //                     12/06/2012 DIT-715 #328 Removed 'BlankZero' property field "Whse. Shipment Status (First)"
    //                     13/06/2012 DIT-715 #338 Added 'Period (Items)' menu into button 'Item\Item Item Availability by'
    //                                             Added 'Items by Period' into button 'Item'
    // DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added 'Service/Contract' tab
    //                                             Added fields into 'Service/Contract' tab
    //                                               "DIT Sub-Contract Type","Contract Group Code","Service Contract No."
    //                                             Moved "Building No." into 'Service/Contract' tab
    // DITW16.00.00.43 DDR 13/05/2013 DIT-715 #604 Added fields "Ship-to" into 'General' tab
    //                     13/05/2013 DIT-715 #606 Added fields  "Document Status"
    //                     23/05/2013 DIT-715 #604 Added fields "Ship-to Code" into 'General' tab
    //                     06/08/2013 DIT-715 #720 Added 'Send e-AAD Request' & 'Send e-Cancelling Request' menu into 'Functions' button
    //                                             Redesign 'Functions' button (grouping menus)
    //                                             Added 'Cancellation Reason Comments' menu into 'Line' button
    // DITW16.00.00.43 DDR 23/08/2013 DIT-715 #720 Added 'AAD Document (EMCS)' menu into 'Print' button
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    //                                             NORRIQ owm - Online Warehouse Management
    //                                             Copyright 2008 by NORRIQ A/S, www.norriq.dk
    //                                               New menu "Show N-owm activities" on Order Action.
    // 
    // FINXL7.00.001 RBE 20/03/2013 : Added field "Your Reference" on page
    //                                Added PDF Functionality
    //                                Print Pro-Forma
    //                                Print and Mail Pro-Forma
    // FINXL7.00.001 KLU 25/09/2013 : Added actions for approve/reject (same functionality as approval entries form)
    // FINXL7.00.001 DAT 29/05/2014 #50: Set the property Editable of the field "Your Reference" to TRUE
    // FINXL7.00.001 KLU 27/06/2014 #42 : Added menuitem: "Calculate Recycle Charges"
    // 
    // DITW17.00.02 DDR 13/05/2013 DIT-715 #604
    //                  13/05/2013 DIT-715 #606
    //                  17/05/2013 DIT-770 #95 Added fields "Vessel Info. Code" into 'Foreign Trade' tab
    //                  23/05/2013 DIT-715 #604
    //                  06/06/2013 DIT-770 #99 Added fields "Ship-to Country/Region Code" into 'Shipping' tab
    //              DDR 13/08/2013 DIT-715 #720 merge
    //              DDR 23/08/2013 DIT-715 #720 merge
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #95
    //                  29/08/2013 DIT-770 #179 Remove DIT-715 #511 EMCS-German
    // DITW17.00.02 SR 09/09/2013 DIT-770 #135 : Add field "Payment Amount" (group 'Invoicing')
    // DITW17.00.02 AT  09/09/2013 DIT-770 #146 merge WHN-001 HIT0005
    //                             Added field "Shipment Date Formula" on Shipping Group
    // DITW17.00.02 AT  09/09/2013 DIT-770 #170 merge WHN-001 HIT0279
    //                             Status field NOT Editable
    // DITW17.00.02 AT  10/09/2013 DIT-770 #148 merge WHN-001 HIT0121
    //                             New dit field "Return Date" Issue 268
    // DITW17.00.02 AT  12/09/2013 DIT-770 #154
    //                             Repositioned Shipment Method before Shipping Agent
    //                             Added fields
    //                             2014094 Sell-to Invoice Method
    //                             2014095 Sell-to Invoice Period
    //                             2014096 Picking Type
    //                             2014097 Truck Zone
    //                             2014098 Require 2 Drivers
    //                             2014099 Driver 2
    //                             Merged Tab Shipping & Shipping Agent into Shipping
    //                             Added several fields on General tab, changed visible via Show more fields
    //                             Altered Quick Entry of all fields
    // DITW17.00.02 AT  10/10/2013 DIT-770 #154
    //                             Added fields
    //                             2014101 Ship-to Address Key No.
    // DITW17.00.02 SR 10/16/2013 DIT-770 #155 : New Action "Change Shipping status" Added
    //                                         : Change the Editable Propert False in "Shipment status" field.
    //                                         : New Code Added
    //                                         : New Action Order Shipment Added
    //                                         : New Action "Register Shipment Entries" Added
    // DITW17.00.02 AT  14/11/2013 DIT-770 #154
    //                             Added fields
    //                             2014110 Delivery Time 1 From
    //                             2014111 Delivery Time 1 To
    //                             2014112 Delivery Time 2 From
    //                             2014113 Delivery Time 2 To
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 DDR 28/11/2013 DIT-770 #272 Upgrade N-OWM4.5 Nav2013 R1
    // DITW17.00.02 AT  10/12/2013 DIT-770 #251 : Added New Action Returned Items
    // DITW17.00.02 SR 12/26/2013 DIT-770 #296 : New Code Added to change the shipment status
    // DITW17.00.02 SR 08/01/2014 DIT-770 #189 : New Field Added
    // DITW17.00.02 AT 10/01/2014 DIT-770 #235 : Added Filter while calling Reports
    // DITW17.00.02 VSC 10/01/2014 DIT-770 #299: New Function MakeSalesOrder()
    // DITW17.00.02 VSC 10/01/2014 DIT-770 #299: New Menu Option Sales Item History
    // DITW17.00.02 AT 23/01/2014 DIT-770 #189 : Added field Total HL Volume
    // DITW17.10.03 MSF 18/04/2014 DIT-770 #354 : Min. HL Volume and Min. UOM warning in order intake - PART2
    //                                            Regroup position for fields in tab shipment
    //                                            Remove Field "Gen. Bus Posting Group Free Item" Form tab general
    //                                            Remove Field "Total weight" Form tab general
    //                                            Make some Fields Visible = False by default
    //                                            Added Faxtbox "Item History FactBox" (Visible by default)
    // DITW17.10.03 MSF 23/04/2014 DIT-770 #542 :  Sales Return control document
    //                                             New Action "Return control"
    //                                             Added option "Return control" on variable usage
    // DITW17.10.03 VSC 07/05/2014 DIT-770 #681: Filter printing the Picking instruction.
    // DITW17.10.03 MSF 12/05/2014 DIT-770 #354 : Min. HL Volume and Min. UOM warning in order intake - PART2
    //                                            set Order information above sales line by default
    //                                            Set Fields visible by default (Importance additional)  :
    //                                                               "Gen. Bus Posting Group Free Item" Form tab general
    //                                                               "Fiscal Representative No."
    //                                                               "Tax Office Code"
    //                                                               "Whse. Shipment Status (First)"
    //                                                               "Whse. Shipment No. (First)"
    //                                                               "Shipment Date Formula"
    //                                                               "Shipping Charge Per"
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.03 MSF 02/06/2014 DIT-770 #354   Added code
    // DITW17.10.03 MSF 03/06/2014 DIT-770 #354   Calc Total Quantity from Sales Order (Item History Factbox)
    // DITW17.10.03 MSF 16/06/2014 DIT-770 #354   SET Min. Wheight Visible = FALSE on tab shipping
    // DITW17.10.03 DDR 04/07/2014 DIT-770 #699 Renamed Caption 'Get Delayed Promotion' -> 'Pre-Promotion Order Alert'
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added fields "Physical Location Group Code" (General tab)
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1190 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    // DITW17.10.05 MSF 22/07/2014 DIT-770 #795 Min. HL Volume and Min. UOM warning in order intake - PART3
    //                                          Delete Fields
    //                                                         2014079 "Min. Weight"
    //                                                         2014080 "Min. Cubage"
    //                                                         2014081 "Min. HL Cubage"
    //                                                         2014082 "Total HL Weight"
    //                                                         2014083 "Min. Eq. UOM Quantity"
    // DITW17.10.05 WSA 04/08/14 DIT-770 #761 : Added field "Invoice List Customer No."
    // DITW17.10.05 YHE 02/09/2014 DIT-770 #754 : added code on Close page when no record
    // DITW17.10.05 MSF 16/09/2014 DIT-770 #925
    // DITW17.10.05 DDR 22/09/2014 DIT-770 #754 Bugfix to skip closing (delete) message
    //                                          Added SetHasBeenShowDeleteConfirm function
    // DITW17.10.05 DDR 07/10/2014 DIT-770 #935 Editable "Building No."
    // DITW17.10.05 MSF 08/10/2014 DIT-770 #831 Change ID of table 2013912 to 2035390
    //                                                       Page  2013912 to 2035390
    //                                                             2013911 to 2035391
    //                  20/10/2014 DIT-770 #831 Change Id of table 2014577 to 2035391
    // DITW17.10.05 MSF 23/10/2014 DIT-770 #612 Delayed promotions filter wrong in sales order. On bill-to should be sell-to.
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 24/11/2014 DIT-770 #1001 Added Action Group "Print and Mail"
    // DITW17.10.04 AKH 27/11/2014 DIT-770 #654 Set the visibility of actions "Approve" and "Reject" to FALSE in ActionGroup "Approval"
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // FINXL7.00.001 RBE 20/03/2013 : Added field "Your Reference" on page
    //                                Added PDF Functionality
    //                                Print Pro-Forma
    //                                Print and Mail Pro-Forma
    // FINXL7.00.001 KLU 25/09/2013 : Added actions for approve/reject (same functionality as approval entries form)
    // FINXL7.00.001 DAT 29/05/2014 #50: Set the property Editable of the field "Your Reference" to TRUE
    // FINXL7.00.001 KLU 27/06/2014 #42 : Added menuitem: "Calculate Recycle Charges"
    // FINXL8.00.001 RBE 01/12/2014 : Removed Print & Mail action
    //                                Changed Pro-forma mail function
    // FINXL8.00.001 BSA 10/06/2015 #85 : Added Field "Last changed User ID", "Last changed Date/time"
    // 
    // DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 Added Field 2014100 "Trailer Code"
    // DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 look & feel design/functional issues: part 1: ribbons
    // DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214 Clean Code
    // DITW18.00.06 YHE 24/06/2015 DIT-770 #1366 activate validate trigger related to action "Sales Item History"
    // DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214 Added Filter on "Resp. Center Table Filter 2"
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Option DIT Contract, Service contract to Financial,Service
    //                                           Rename Field Service contract Type => Contract Type
    // DITW18.00.06 DDR 07/08/2015 DIT-770 #1368 Added field "Customer Posting Group" into 'Service/Contract' tab
    // DITW18.00.06 MSF 07/09/2015 DIT-770 #1517 Consider UOM changes for Returns in SO
    //                                           Modify ShortCutkey into action Return item
    //                                           change quick entry = False for field "Customer Tax Group Code"
    // DITW18.00.06 MVN 15/10/2015 DIT-770 #1507 Changed Table/Page Link in <Action1100066045>
    // DITW18.00.07 MVN 15/01/2016 DIT-770 #1397 Added Field 2014300 "Submission Type" (Shipping)
    // DITW18.00.07 AKH 11/02/2016 DIT-770 #1804 Sundry Customer
    // DITW18.00.07 KJB 18/02/2016 DIT-770 #1042 Add code to show sales comment lines when opening order
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Several adjustments
    // DITW18.00.07 MVN 24/02/2016 DIT-770 #1397 Changed Position of Field 2014300 to "Journey Time"
    // DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Add HasDocumentShippingCosts to General TAB
    // DITW18.00.07 AKH 28/03/2016 DIT-770 #1409 Changed condition to set "ShowMandatory" property for "External Document No." field
    // DITW18.00.07 AKH 30/03/2016 DIT-770 #1409 Adjustment
    // DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    // DITW18.00.07 AKH 07/04/2016 DIT-770 #1042 Replaced sales comments popup : show comments directly in the page
    // DITW18.00.07 DDR 11/04/2016 DIT-770 #1488 Bugfix all function calls PrintSalesOrder (codeunit 229)
    //                                           Modified text constant Text2014413
    // DITW18.00.07 DDR 19/04/2016 DIT-770 #1488 Added Route Mandatory & '' property
    // DITW18.00.07 DDR 28/04/2016 DIT-770 #1488 Changed Caption 'Combined shipment' -> 'Load List'
    // DITW18.00.07 AKH 28/04/2016 DIT-770 #1346 Added fields "Customer Delivery Type" & "Delivery Time (sec.)" under Shipping tab
    // DITW18.00.07 AKH 13/05/2016 DIT-770 #1409 Restored standard code for check on "External Document No."
    // DITW18.00.07 AKH 20/05/2016 DIT-770 #1067 Changed action "Returned Items"
    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time","Created By" and "Latest Order Date/Time" Importance Additional
    // DITW18.00.07 VSC 01/07/2016 DIT-770 #1282 Set fields to visible "Creation Date/Time","Created By" and "Latest Order Date/Time"
    // DITW18.00.07 DDR 01/07/2016 DIT-770 #1282 Set fields to visible move "Latest Order Date/Time"
    // DITW18.00.07 DDR 01/07/2016 DIT-770 #1282 Move "Latest Order Date/Time" field
    // DITW19.00.08 AKH 20/09/2016 BL#10756 (DIT-770 #1215) Added field "Return Location Code" under tab Shipping
    // DITW19.00.08 VSC 05/12/2016 BL#10330 (DIT-770 #2122) Re index options Report Usage And Remove Double print option Combined Shipment = Load List.
    // DITW19.00.08A DDR 28/02/2017 NRQ#18985 Bugfix Alert Order Warning to delete empty document after selecting another sales order
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 26/02/2017 NRQ#0 Upgrade add notification for empty-delete document() on OnQueryClose trigger
    // DITW110.00.09 YHE 15/03/2017 NRQ#24111 merge DIT2016 W1 R8A
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXLBE8.00.001 DAT 18/08/2015 : Save the record after changing the "Ship-to Code"
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL9.00.000.01 ACH 10/01/2017 : Recycle charges functionnalities
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.09 DDR 20/04/2017 NRQ#13107 Add all country code fields
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Added action "Process backorder lines"
    // DITW110.00.10 MSF 07/07/2017 NRQ#16224 Return Registration part 3
    //                              Added Parameter To function LoadReturnedItemsPage
    //                              Added Action Suggest Return Items
    //                              Adde Fields Suggested Return Item
    // DITW110.00.10 MSF 14/07/2017 NRQ#16224 Added fields : Rename Action Create Return Order
    //                                                       Several Adjustment
    // DITW110.00.10 YHE 17/07/2017 NRQ#16068 Display fields : ID.2014083-"Total HL Cubage (Base)", ID.2014085-"Total Eq. UOM Quantity (Base)"
    // DITW110.00.10 YHE 20/07/2017 NRQ#16068 Add factbox ID.2035400-"Order Totals (Outbnd.) Factbox"
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added fields  Multiple Route Order
    //                              Editable Field IF not Multiple Route ORder + Warehouse line Exist
    // DITW110.00.11 VSC 09/10/2017 NRQ#33755 EditableMultipleRouteOrder not on "Shipping Status" and "External Document No."
    // DITW110.00.11 MSF 30/11/2017 NRQ#16082 Remove Condition EditableMultipleRouteOrder  on SOme fields
    // DITW110.00.11 MSF 28/12/2017 NRQ#9570 DIT Sales approval for Credit limit
    // 
    // HEI.01 FDD-OTCGAP063 IBM.NAIKH01 04/07/2017 -Block Invoice Discount Amount and Percentage value on the Sales Order
    //   # Page Action "CalculateInvoiceDiscount" Visible set to False
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 18.08.2017 # MDM Customer Card
    //   # Code added in Release - OnAction()
    // HEI.03 FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>
    //   # Code added on OnOpenPage, OnNewRecord, OnInsertRecord
    // HEI.04 FDD-KDDOTCGAP003 IBM ISYED01 10.10.2017
    //   # code added to release function
    // HEI.05 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    //   # Code added on Post Action
    // HEI.06 FDD-KDD0TC005 IBM NASTAA02 9.11.2017 # RPM Billing and Reporting
    //   # Code added on Post Actions to post the Sales Order and the Sales Return Order which are linked
    //   # New page action created to run the report RPM Balance Accounting
    // HEI.07 FDD-HNK LOGGAP001 03/02/2018 IBM.CHAUHB01
    //   # Display Field "Sales Routes" under General TAB
    // HEI.08 defect #2130 IBM POSTOI01 30.05.2018
    //   #add new page action Post & Print
    // HEI.09 defect #2234 IBM POSTOI01 05.06.2018
    //   #add new code to OnOpenPage to set the Editable value for Document Subtype Code
    // HEI.10 FDD-ET-MARAKI POS Interface IBM POSTOI01 # Maraki POS Interface
    //   # show field Suppress POS Interface field
    // HEI.11 CHG2046145 IBM.GAVANM01 16.03.2020 # Sales Order Status Addition
    //   # New field added : 50051 - "Approval Status"
    // HEI.12 CHG2053242 HB1215 IBM GAVANM01 31.03.2020 Sales Order fixes
    //   # the field Shipment Date appears twice. Remove it from Shipping and Billing tab
    //   # the field Requested Delivery Date moved from Shipping and Billing tab to General Tab

    // BC Upgrade BHARDA11 >>
    // 1. Old Page ID - 50212. 
    /* 2. Removed Drink-IT related fields: 
   - "Sales Routes"
   - "DIT Sub-Contract Type"
   - "Contract Group Code"
   - "Service Contract No."
   - "Financial Contract No."
   - "Building No."
   - "Customer DTax Group Code"
   - "Picking Type"
   - "Document Shipping Costs"
   - "Shipment status"
   - "Creation Date/Time"
   - "Created By"
   - "Last changed User ID"
   - "Last changed Date/time"
   - "Suggested Return Item"
   - "Distance"
   - "Truck Code"
   - "Trailer Code"
   - "Truck Zone"
   - "Driver Code"
   - "Driver 2 Code"
   - "Require 2 Drivers"
   - "Ship-to Address Key No."
   - "Route"
   - "Route Planning No."
   - "Delivery Sequence"
   - "Shipping Charge Per"
   - "Maximum Weight"
   - "Maximum Cubage"
   - "Total Weight (Base)"
   - "Total Weight"
   - "Total Cubage (Base)"
   - "Total Cubage"
   - "Total HL Cubage (Base)"
   - "Total HL Cubage"
   - "Total Eq. UOM Quantity (Base)"
   - "Total Eq. UOM Quantity"
   - "Delivery Time 1 From"
   - "Delivery Time 1 To"
   - "Delivery Time 2 From"
   - "Delivery Time 2 To"
   - "Customer Delivery Type"
   - "Delivery Time (sec.)"
   - "Transport Mode"
   - "Contract Type"
   - "DIT Sub-Contract Type"
   - "Service Contract No."
   - "Financial Contract No."
   - "Contract Group Code"
   - "Invoice List Customer No."
   - "Invoice Method"
   - "Invoice Period"
   - "Sundry Customer"
   - "Payment Amount"
   - "Return Location Code"
   - "Shipment Date Formula"
   - "Shipment Time"
   - "Physical Location Group Code"
   - "Whse. Shipment No. (First)"
   - "Whse. Shipment Status (First)"
3. Removed Drink-IT related actions:
   - "Comments - Transport Mode"
   - "Show N-owm activities"
   - "Return control"
   - "Process backorder lines"
   - "Get Pre-Promotion Order Alert"
   - "Get Delayed Discount"
   - "Update Order"
   - "Sales Item History"
   - "Calculate Recycle Charges"
   - "Returned Items"
   - "Suggest Return Items"
   - "Register Route Shipment entries"
   - "Send e-AAD Request"
   - "Send e-Cancelling Request"
   - "RPM Balance Accounting"
   - "Change Shipping status"
   - "Order Shipment"

   4. Removed or commented out Drink-IT related functions: 
   - "FormatMaximumControls"
   - "ShowUpdateSalesOrder"
   - "StatusOnAfterValidate"
   - "StatusOnValidate"
   - "MaximumCubageOnFormat"
   - "MaximumWeightOnFormat"
   - "MakeSalesOrder"
   - "SetHasBeenShowDeleteConfirm"
   - "RefreshInvoicePeriodEditable"
   - "SetSalesCommentLinkVisible"
   - "OpenSalesComments"
   - "ShowSalesComments"
   - "FilterSalesComments"

   5. Add ApplicationArea Property in all fields and actions.
   6. Comment code "ApplicationAreaSetup.IsFoundationEnabled" because IsFoundationEnabled is missing in "Application AreacSetup" table.
   7. Move "Suppress POS Interface" field to Interface extension. */
    // BC Upgrade BHARDA11 <<

    // BC Upgrade SHUKLP03 >> "Document Subtype Code" code added

    ApplicationArea = All;
    UsageCategory = Documents;
    Caption = 'CTS Order';
    PageType = Document;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval',
                                 FRA = 'Nouveau,Traitement,État,Approuver,Lancer,Comptabilisation,Préparer,Facture,Demande d''approbation';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML = ENU = 'General',
                            FRA = 'Général';
                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                // group(General1)
                // {
                //     Visible = SalesCommentLinkVisible;
                //     field(Text2014414; Text2014414)
                //     {
                //         DrillDown = true;
                //         Editable = false;
                //         ShowCaption = false;
                //         Style = Unfavorable;
                //         StyleExpr = TRUE;

                //         trigger OnDrillDown();
                //         begin
                //             //<< DITW18.00.07 AKH 07/04/2016 DIT-770 #1042
                //             ShowSalesComments();
                //             CurrPage.UPDATE(FALSE);
                //         end;
                //     }
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Customization
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the number of the sales document. The field can be filled automatically or manually and can be set up to be invisible.',
                                FRA = 'Spécifie le numéro du document vente. Le champ peut être rempli automatiquement ou manuellement et être configuré pour être invisible.';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Customer',
                                FRA = 'Client';
                    ShowMandatory = true;
                    ToolTipML = ENU = 'Specifies the name of the customer who will receive the products and be billed by default.',
                                FRA = 'Spécifie le nom du client qui recevra les produits et sera facturé par défaut.';

                    trigger OnValidate();
                    begin
                        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                        // // <<DITW19.00.08A DDR 28/02/2017 NRQ#18985
                        // HasBeenPendingOrder := fctGetHasSelectPendingOrder;
                        // // >>DITW19.00.08A DDR NRQ#18985
                        // //<< DITW17.10.05 YHE 02/09/2014 DIT-770 #754
                        // IF fctGetHasBeenDeleted OR fctGetHasSelectPendingOrder THEN BEGIN
                        //     CurrPage.CLOSE;
                        //     EXIT;
                        // END;
                        // //>> DITW17.10.05 YHE 02/09/2014 DIT-770 #754

                        // IF GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." THEN
                        //     IF "Sell-to Customer No." <> xRec."Sell-to Customer No." THEN
                        //         SETRANGE("Sell-to Customer No.");

                        // //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
                        // IF "Sundry Customer" THEN
                        //     ShowCustomerSundryInfo();
                        // //>> DITW18.00.07 AKH DIT-770 #1804

                        // //<< DITW18.00.07 AKH 07/04/2016 DIT-770 #1042 - DITW110.00.08 DDR 02/01/2017 NRQ#0
                        // IF xRec."Sell-to Customer No." <> "Sell-to Customer No." THEN
                        //     SetSalesCommentLinkVisible();
                        // //>> DITW18.00.07 AKH DIT-770 #1042 - DITW110.00.08 DDR NRQ#0

                        // IF ApplicationAreaSetup.IsFoundationEnabled THEN
                        //     SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);

                        // CurrPage.UPDATE;

                        // // <<DITW15.00.00.39 DDR 27/04/2011 #1323 (BE5.00.01) - DITW110.00.08 DDR 02/01/2017 NRQ#0
                        // COMMIT;
                        // StdCustSalesCode.AutoInsertSalesLines(Rec);
                        // // >>DITW15.00.00.39 DDR #1323 (BE5.00.01) - DITW110.00.08 DDR NRQ#0

                        // // <<DITW15.00.00.39 RBE 20/04/2011 - DDR 27/04/2011 #1230
                        // SalesSetup.GET;
                        // IF SalesSetup."Copy Comments Cust. to Sell-to" THEN
                        //     CopyCustCommentToSales();
                        // // >>DITW15.00.00.39 RBE #1230
                        // BC Upgrade BHARDA11 << ----Drink-IT Customization

                    end;
                }
                // BC Upgrade SHUKLP03 >> Added Fields("Document Subtype Code")
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                    Editable = DocSubtypeEditable;
                }
                // BC Upgrade BHARDA11 << Added Fields("Document Subtype Code")
                group("Sell-to")
                {
                    CaptionML = ENU = 'Sell-to',
                                FRA = 'Donneur d''ordre';
                    field("Sell-to Address"; Rec."Sell-to Address")
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Address',
                                    FRA = 'Adresse';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTipML = ENU = 'Specifies the address where the customer is located.',
                                    FRA = 'Spécifie l''adresse où se trouve le client.';
                    }
                    field("Sell-to Address 2"; Rec."Sell-to Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Address 2',
                                    FRA = 'Adresse (2ème ligne)';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTipML = ENU = 'Specifies additional address information.',
                                    FRA = 'Spécifie des informations d''adresse supplémentaires.';
                    }
                    field("Sell-to Post Code"; Rec."Sell-to Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Post Code',
                                    FRA = 'Code postal';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTipML = ENU = 'Specifies the postal code.',
                                    FRA = 'Spécifie le code postal.';
                    }
                    field("Sell-to City"; Rec."Sell-to City")
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'City',
                                    FRA = 'Ville';
                        Importance = Additional;
                        ToolTipML = ENU = 'Specifies the city where the customer is located.',
                                    FRA = 'Spécifie la ville où se trouve le client.';
                    }
                    field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                    {
                        Importance = Additional;
                    }
                    field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                    {
                        CaptionML = ENU = 'Contact No.',
                                    FRA = 'N° contact';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTipML = ENU = 'Specifies the number of the contact that the sales document will be sent to.',
                                    FRA = 'Spécifie le numéro du contact auquel vous envoyez le document vente.';

                        trigger OnValidate();
                        begin
                            IF Rec.GETFILTER("Sell-to Contact No.") = xRec."Sell-to Contact No." THEN
                                IF Rec."Sell-to Contact No." <> xRec."Sell-to Contact No." THEN
                                    Rec.SETRANGE("Sell-to Contact No.");
                        end;
                    }
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Contact',
                                FRA = 'Contact';
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies the name of the person to contact at the customer.',
                                FRA = 'Spécifie le nom de la personne à contacter chez le client.';
                }
                group("Ship-to")
                {
                    CaptionML = ENU = 'Ship-to',
                                FRA = 'Destinataire';
                    // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                    // field("SShip-to Code"; Rec."Ship-to Code")
                    // {
                    //     CaptionML = ENU = 'Code',
                    //                 FRA = 'Code';
                    //     Description = 'DITW18.00.06 MSF 07/09/2015 DIT-770 #1517';
                    //     Importance = Promoted;
                    //     QuickEntry = false;

                    //     trigger OnValidate();
                    //     begin
                    //         //<< DITW17.10.05 YHE 02/09/2014 DIT-770 #754
                    //         IF fctGetHasBeenDeleted OR fctGetHasSelectPendingOrder THEN
                    //             CurrPage.CLOSE
                    //         //>> DITW17.10.05 YHE 02/09/2014 DIT-770 #754
                    //     end;
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Customization

                    field("SShip-to Name"; Rec."Ship-to Name")
                    {
                        CaptionML = ENU = 'Name',
                                    FRA = 'Nom destinataire';
                        QuickEntry = false;
                    }
                    field("SShip-to Address"; Rec."Ship-to Address")
                    {
                        CaptionML = ENU = 'Address',
                                    FRA = 'Destinataire';
                        Importance = Additional;
                        QuickEntry = false;
                    }
                    field("SShip-to Post Code"; Rec."Ship-to Post Code")
                    {
                        CaptionML = ENU = 'Post Code',
                                    FRA = 'Code Postale destinataire';
                        Importance = Additional;
                        QuickEntry = false;
                    }
                    field("SShip-to City"; Rec."Ship-to City")
                    {
                        CaptionML = ENU = 'City',
                                    FRA = 'Ville destinataire';
                        Importance = Additional;
                        QuickEntry = false;
                    }
                    field("SShip-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                    {
                        CaptionML = ENU = 'Country/Region',
                                    FRA = 'Pays/région';
                        Importance = Additional;
                    }
                }
                group(Control1100710019)
                {
                    field("No. of Archived Versions"; Rec."No. of Archived Versions")
                    {
                        Importance = Additional;
                        ToolTipML = ENU = 'Specifies the number of archived versions for this sales document.',
                                    FRA = 'Spécifie le nombre de versions archivées pour ce document vente.';
                    }
                    field("Your Reference"; Rec."Your Reference")
                    {
                        Description = 'FINXL7.00.001';
                    }
                    field("Quote No."; Rec."Quote No.")
                    {
                        ApplicationArea = All;
                        QuickEntry = false;
                        ToolTip = 'Specifies the number of the sales quote that the sales order was created from. You can track the number to sales quote documents that you have printed, saved, or emailed.';
                        Visible = ShowQuoteNo;
                    }
                    field("Job Queue Status"; Rec."Job Queue Status")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the status of a job queue entry or task that handles the posting of sales orders.';
                        Visible = JobQueuesUsed;
                    }
                }
                group(Control1100710020)
                {
                    field("Posting Date"; Rec."Posting Date")
                    {
                        ApplicationArea = Basic, Suite;
                        Description = 'NRQ#16082';
                        Importance = Promoted;
                        ToolTipML = ENU = 'Specifies the date when the posting of the sales document will be recorded.',
                                    FRA = 'Spécifie la date à laquelle la validation du document vente sera validée.';
                    }
                    field("Order Date"; Rec."Order Date")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        QuickEntry = false;
                        ToolTip = 'Specifies the date on which the exchange rate applies to prices listed in a foreign currency on the sales order.';
                    }
                    field("Document Date"; Rec."Document Date")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        ToolTipML = ENU = 'Specifies the date on which you created the sales document.',
                                    FRA = 'Spécifie la date à laquelle vous avez créé le document vente.';
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Tax Date")
                    // field("Tax Date"; Rec."Tax Date")
                    // {
                    //     Importance = Additional;
                    //     QuickEntry = false;
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields("Tax Date")
                    field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                    {
                        ApplicationArea = All;
                    }
                    field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                    {
                        ApplicationArea = All;
                    }
                }
                group(General2)
                {
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields and customization
                    // field(RouteNew; Route)
                    // {
                    //     Description = '<DITW16.00.00.40 #1002 - DITW19.00.08 BL#11231>-NRQ#16082';
                    //     ShowMandatory = RouteAsMandatory;

                    //     trigger OnDrillDown();
                    //     begin
                    //         // <<DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
                    //         DrillDownRouteCombinaison;
                    //         // >>DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
                    //     end;

                    //     trigger OnValidate();
                    //     begin
                    //         CurrPage.UPDATE;
                    //     end;
                    // }
                    field("Route 107FDW"; Rec."Route 107FDW")
                    {
                        ApplicationArea = All;
                    }
                    field("Sales Routes"; Rec."Sales Routes FND")
                    {
                        ApplicationArea = All;
                    }
                    field("Route Planning No. 107FDW"; Rec."Route Planning No. 107FDW")
                    {
                        ApplicationArea = All;
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Route Planning No.","Multiple Order Route","Latest Order Date/Time")
                    // field(RoutePlanningNew; "Route Planning No.")
                    // {
                    //     Editable = false;
                    // }
                    // field("Multiple Order Route"; Rec."Multiple Order Route")
                    // {
                    //     Editable = false;
                    //     Importance = Additional;
                    // }
                    // field("Latest Order Date/Time"; Rec."Latest Order Date/Time")
                    // {
                    //     Description = 'DITW18.00.07 DIT-770 #1282';
                    //     Importance = Additional;
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields("Route Planning No.", "Multiple Order Route", "Latest Order Date/Time")
                    field(ShipmentDateNew; Rec."Shipment Date")
                    {
                        Description = 'NRQ#16082';
                        QuickEntry = false;
                    }
                    field("Requested Delivery Date"; Rec."Requested Delivery Date")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTipML = ENU = 'Specifies the date that the customer has asked for the order to be delivered.',
                                    FRA = 'Spécifie la date à laquelle le client a demandé à être livré.';
                    }

                    field("External Document No."; Rec."External Document No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Description = 'NRQ#16082';
                        Importance = Promoted;
                        QuickEntry = false;
                        ShowMandatory = ExternalDocNoMandatory;
                        ToolTipML = ENU = 'Specifies the number that the customer uses in their own system to refer to this sales document.',
                                    FRA = 'Spécifie le numéro que le client doit utiliser dans son propre système pour faire référence à ce document vente.';
                    }
                    field("Salesperson Code"; Rec."Salesperson Code")
                    {
                        ApplicationArea = Suite;
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTipML = ENU = 'Specifies the name of the salesperson who is assigned to the customer.',
                                    FRA = 'Spécifie le nom du vendeur affecté au client.';

                        trigger OnValidate();
                        begin
                            SalespersonCodeOnAfterValidate;
                        end;
                    }
                    field("Responsibility Center"; Rec."Responsibility Center")
                    {
                        ApplicationArea = ALL;
                    }
                    field(SystemCreatedAt; Rec.SystemCreatedAt)
                    {
                        Caption = 'Created Date/Time';
                        Editable = false;
                        ApplicationArea = ALL;
                    }
                    field(SystemCreatedBy; Rec.SystemCreatedBy)
                    {
                        Caption = 'Created By';
                        Editable = false;
                        ApplicationArea = ALL;
                    }

                }
                field(ShippingAdviceNew; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    QuickEntry = false;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields and Custmization("Building No.", "Customer DTax Group Code", "Responsibility Center", "Picking Type", "Document Shipping Costs", "Shipment status")
                // field("Building No."; Rec."Building No.")
                // {
                //     ApplicationArea = All;
                //     Description = '<DITW15.00.00.35>- DIT-770 #354';
                //     Editable = false;
                //     Importance = Additional;
                //     QuickEntry = false;
                // }
                // field("Customer DTax Group Code"; Rec."Customer DTax Group Code")
                // {
                //     ApplicationArea = All;
                //     Description = '<DITW15.00.00.01>- DITW18.00.06 MSF 07/09/2015 DIT-770 #1517';
                //     QuickEntry = false;
                // }
                // field("Responsibility Center"; Rec."Responsibility Center")
                // {
                //     AccessByPermission = TableData 5714 = R;
                //     Importance = Additional;
                //     QuickEntry = false;
                //     ToolTipML = ENU = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.',
                //                 FRA = 'Spécifie le code du centre de gestion qui est associé à l''utilisateur, à la société ou au fournisseur.';

                //     trigger OnValidate();
                //     begin
                //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
                //         IF "Responsibility Center" <> xRec."Responsibility Center" THEN
                //             CurrPage.UPDATE(TRUE);
                //         // >>DITW18.00.06 DDR DIT-770 #1190
                //     end;
                // }
                // field(PickingTypeNew; "Picking Type")
                // {
                //     CaptionML = ENU = 'Picking Type',
                //                 FRA = 'Type de prélèvement';
                //     Importance = Additional;
                //     QuickEntry = false;
                // }

                // field("Document Shipping Costs"; Rec.HasDocumentShippingCosts)
                // {
                //     CaptionML = ENU = 'Document Shipping Costs',
                //                 FRA = 'Document Frais livraison';

                //     trigger OnDrillDown();
                //     begin
                //         //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
                //         OpenDocumentShippingCosts;
                //         //>> DITW18.00.07 VSC DIT-770 #1066
                //     end;
                // }
                // field("Shipment status"; Rec."Shipment status")
                // {
                //     ApplicationArea = All;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Fields and Customization ("Building No.", "Customer DTax Group Code", "Responsibility Center", "Picking Type", "Document Shipping Costs", "Shipment status")
                field("Approval Status"; Rec."Approval Status FND")
                {
                    ApplicationArea = All;
                }
                //BC UPGRADE KUMARR78 ++ 05-05-2026 
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                //BC UPGRADE KUMARR78 ++ 05-05-2026 

                // BC Upgrade BHARDA11 >> ----Drink-IT Fields and Customization(
                // field(Status; Rec.Status)
                // {
                //     ApplicationArea = All;
                //     Description = 'DITW17.00.02 DIT-770 #170';
                //     Importance = Promoted;
                //     QuickEntry = false;
                //     ToolTipML = ENU = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.',
                //                 FRA = 'Spécifie si le document est ouvert, est en attente d''approbation, a été facturé pour acompte ou a été lancé pour l''étape suivante du traitement.';

                //     trigger OnValidate();
                //     begin
                //         StatusOnValidate;
                //         StatusOnAfterValidate;
                //     end;
                // }
                // field("Creation Date/Time"; Rec."Creation Date/Time")
                // {
                //     ApplicationArea = All;
                //     Description = 'DITW18.00.07 DIT-770 #1282';
                //     Importance = Additional;
                // }
                // field("Created By"; Rec."Created By")
                // {
                //     ApplicationArea = All;
                //     Description = 'DITW18.00.07 DIT-770 #1282';
                //     Importance = Additional;
                // }
                // field("Last changed User ID"; Rec."Last changed User ID")
                // {
                //     Editable = false;
                // }
                // field("Last changed Date/time"; Rec."Last changed Date/time")
                // {
                //     Editable = false;
                // }
                // field("Suggested Return Item"; Rec."Suggested Return Item")
                // {
                //     Caption = 'Suggested Return Item';
                //     Importance = Additional;

                //     trigger OnValidate();
                //     begin
                //         SuggestedReturnItemAfterValidate;
                //     end;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Field("Status", "Creation Date/Time", "Created By", "Last changed User ID", "Last changed Date/time", "Suggested Return Item")

            }
            part(SalesLines; "Sales Order Subform")
            {
                ApplicationArea = Basic, Suite;
                Editable = DynamicEditable;
                Enabled = Rec."Sell-to Customer No." <> '';
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            group("Invoice Details")
            {
                CaptionML = ENU = 'Invoice Details',
                            FRA = 'Détails facture';
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the dimension value code associated with the sales header.',
                                FRA = 'Spécifie le code section analytique associée à l''en-tête vente.';

                    trigger OnValidate();
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the dimension value code associated with the sales header.',
                                FRA = 'Spécifie le code section analytique associée à l''en-tête vente.';

                    trigger OnValidate();
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTipML = ENU = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the sales document.',
                                FRA = 'Spécifie une formule qui calcule la date d''échéance du paiement, la date d''escompte et le montant de la remise sur le document de vente.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies when the sales invoice must be paid.';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percentage granted if the customer pays on or before the date entered in the Pmt. Discount Date field.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the last date the customer can pay the invoice and still receive a payment discount.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTipML = ENU = 'Specifies how the customer must pay for products on the sales document.',
                                FRA = 'Spécifie de quelle manière le client doit régler les produits figurant sur le document vente.';

                    trigger OnValidate();
                    begin
                        UpdatePaymentService;
                    end;
                }
                group(Control76)
                {
                    Visible = PaymentServiceVisible;
                    field(SelectedPayments; Rec.GetSelectedPaymentServicesText())
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Payment Service',
                                    FRA = 'Service de paiement';
                        Editable = false;
                        Enabled = PaymentServiceEnabled;
                        MultiLine = true;
                        ToolTipML = ENU = 'Specifies the online payment service, such as PayPal, that customers can use to pay the sales document.',
                                    FRA = 'Spécifie le service de paiement en ligne, tel que PayPal, que les clients peuvent utiliser pour payer le document vente.';

                        trigger OnAssistEdit();
                        begin
                            Rec.ChangePaymentServiceSetting();
                        end;
                    }
                }
                field("Direct Debit Mandate ID"; Rec."Direct Debit Mandate ID")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the direct-debit mandate that the customer has signed to allow direct debit collection of payments.',
                                FRA = 'Spécifie le mandat de prélèvement que le client a signé pour autoriser un prélèvement automatique des paiements.';
                }
                // BC Upgrade BHARDA11 >>---- ("Payment Amount")
                // field("Payment Amount"; Rec."Payment Amount")
                // {
                //     ApplicationArea = All;
                // }
                // BC Upgrade BHARDA11 <<---- ("Payment Amount")
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies whether the unit price on the line should be displayed including or excluding VAT.',
                                FRA = 'Spécifie si le prix unitaire de la ligne doit être affiché TTC ou hors taxes.';

                    trigger OnValidate();
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the customer''s VAT specification to link transactions made for this customer to.',
                                FRA = 'Spécifie le détail TVA du client auquel associer des transactions faites pour ce client.';

                    trigger OnValidate();
                    begin
                        // BC Upgrade BHARDA11 >> ---IsFoundationEnabled is not found in "Application Area Setup" Table
                        // IF ApplicationAreaSetup.IsFoundationEnabled THEN
                        //     SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);
                        // CurrPage.UPDATE;
                        // BC Upgrade BHARDA11 << ---IsFoundationEnabled is not found in "Application Area Setup" Table

                    end;
                }
                field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
                {
                    ApplicationArea = All;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Sundry Customer", "Invoice Method", "Invoice Period", "Invoice List Customer No.")
                // field("Sundry Customer"; Rec."Sundry Customer")
                // {
                //     Editable = false;
                // }
                // field("Invoice Method"; Rec."Invoice Method")
                // {

                //     trigger OnValidate();
                //     begin
                //         //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154 - DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                //         RefreshInvoicePeriodEditable;
                //         CurrPage.UPDATE(TRUE);
                //         //>>DITW17.00.02 TEC1 DIT-770 #154 - DITW18.00.07 DDR DIT-770 #1488
                //     end;
                // }
                // field("Invoice Period"; Rec."Invoice Period")
                // {
                //     Editable = InvoicePeriodEditable;
                // }
                // field("Invoice List Customer No."; Rec."Invoice List Customer No.")
                // {
                //     ApplicationArea = All;
                //     Description = 'DITW17.10.05 DIT-715 #761';
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Fields("Sundry Customer", "Invoice Method", "Invoice Period", "Invoice List Customer No.")
            }
            group("Shipping and Billing")
            {
                CaptionML = ENU = 'Shipping and Billing',
                            FRA = 'Expédition et facturation';
                group(Control91)
                {
                    group(Control90)
                    {
                        field(ShippingOptions; ShipToOptions)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Ship-to',
                                        FRA = 'Destinataire';
                            OptionCaptionML = ENU = 'Default (Sell-to Address),Alternate Shipping Address,Custom Address',
                                              FRA = 'Par défaut (Adresse donneur d''ordre),Autre adresse de livraison,Adresse personnalisée';
                            ToolTipML = ENU = 'Specifies the address that the products on the sales document are shipped to. Default (Sell-to Address): The same as the customer''s sell-to address. Alternate Ship-to Address: One of the customer''s alternate ship-to addresses. Custom Address: Any ship-to address that you specify in the fields below.',
                                        FRA = 'Spécifie l''adresse à laquelle les produits figurant sur le document vente sont expédiés. Par défaut (Adresse donneur d''ordre) : identique à l''adresse donneur d''ordre du client. Autre adresse destinataire : une des autres adresses destinataire du client. Adresse personnalisée : toute adresse destinataire que vous spécifiez dans les champs ci-dessous.';

                            trigger OnValidate();
                            var
                                ShipToAddress: Record "Ship-to Address";
                                ShipToAddressList: Page "Ship-to Address List";
                            begin
                                CASE ShipToOptions OF
                                    ShipToOptions::"Default (Sell-to Address)":
                                        BEGIN
                                            Rec.VALIDATE("Ship-to Code", '');
                                            Rec.CopySellToAddressToShipToAddress();
                                        END;
                                    ShipToOptions::"Alternate Shipping Address":
                                        BEGIN
                                            ShipToAddress.SETRANGE("Customer No.", Rec."Sell-to Customer No.");
                                            ShipToAddressList.LOOKUPMODE := TRUE;
                                            ShipToAddressList.SETTABLEVIEW(ShipToAddress);

                                            IF ShipToAddressList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                                ShipToAddressList.GETRECORD(ShipToAddress);
                                                Rec.VALIDATE("Ship-to Code", ShipToAddress.Code);
                                            END ELSE
                                                ShipToOptions := ShipToOptions::"Custom Address";
                                        END;
                                    ShipToOptions::"Custom Address":
                                        Rec.VALIDATE("Ship-to Code", '');
                                END;
                            end;
                        }
                        group(Control4)
                        {
                            Visible = NOT (ShipToOptions = ShipToOptions::"Default (Sell-to Address)");
                            field("Ship-to Code"; Rec."Ship-to Code")
                            {
                                ApplicationArea = Basic, Suite;
                                CaptionML = ENU = 'Code',
                                            FRA = 'Code';
                                Editable = ShipToOptions = ShipToOptions::"Alternate Shipping Address";
                                Importance = Promoted;
                                ToolTipML = ENU = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.',
                                            FRA = 'Spécifie le code d''une adresse de livraison différente de l''adresse du client, qui est entrée par défaut.';

                                trigger OnValidate();
                                begin
                                    IF (xRec."Ship-to Code" <> '') AND (Rec."Ship-to Code" = '') THEN
                                        ERROR(EmptyShipToCodeErr);
                                    CurrPage.SAVERECORD;//FINXLBE8.00.001 DAT 18/08/2015
                                end;
                            }
                            field("Ship-to Name"; Rec."Ship-to Name")
                            {
                                ApplicationArea = Basic, Suite;
                                CaptionML = ENU = 'Name',
                                            FRA = 'Nom';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                ToolTipML = ENU = 'Specifies the name that products on the sales document will be shipped to.',
                                            FRA = 'Spécifie le nom auquel les produits mentionnés sur le document vente seront expédiés.';
                            }
                            field("Ship-to Address"; Rec."Ship-to Address")
                            {
                                ApplicationArea = Basic, Suite;
                                CaptionML = ENU = 'Address',
                                            FRA = 'Adresse';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                ToolTipML = ENU = 'Specifies the address that products on the sales document will be shipped to.',
                                            FRA = 'Spécifie l''adresse à laquelle les produits mentionnés sur le document vente seront expédiés.';
                            }
                            field("Ship-to Address 2"; Rec."Ship-to Address 2")
                            {
                                ApplicationArea = Basic, Suite;
                                CaptionML = ENU = 'Address 2',
                                            FRA = 'Adresse (2ème ligne)';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                ToolTipML = ENU = 'Specifies additional address information.',
                                            FRA = 'Spécifie des informations d''adresse supplémentaires.';
                            }
                            field("Ship-to Post Code"; Rec."Ship-to Post Code")
                            {
                                ApplicationArea = Basic, Suite;
                                CaptionML = ENU = 'Post Code',
                                            FRA = 'Code postal';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                ToolTipML = ENU = 'Specifies the postal code.',
                                            FRA = 'Spécifie le code postal.';
                            }
                            field("Ship-to City"; Rec."Ship-to City")
                            {
                                ApplicationArea = Basic, Suite;
                                CaptionML = ENU = 'City',
                                            FRA = 'Ville';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                ToolTipML = ENU = 'Specifies the city that products on the sales document will be shipped to.',
                                            FRA = 'Spécifie la ville vers laquelle les produits mentionnés sur le document vente seront expédiés.';
                            }
                            field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                            {
                                ApplicationArea = Basic, Suite;
                                CaptionML = ENU = 'Country/Region',
                                            FRA = 'Pays/région';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                            }
                            field("Ship-to Contact"; Rec."Ship-to Contact")
                            {
                                ApplicationArea = Basic, Suite;
                                CaptionML = ENU = 'Contact',
                                            FRA = 'Contact';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                ToolTipML = ENU = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.',
                                            FRA = 'Spécifie le nom de la personne contact à l''adresse d''expédition des produits figurant sur le document vente.';
                            }
                        }
                    }
                    group("Shipment Method")
                    {
                        CaptionML = ENU = 'Shipment Method',
                                    FRA = 'Conditions de livraison';
                        field("Shipment Method Code"; Rec."Shipment Method Code")
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Code',
                                        FRA = 'Code';
                            Editable = EditableMultipleRouteOrder;
                            Importance = Additional;
                            ToolTipML = ENU = 'Specifies how items on the sales document are shipped to the customer.',
                                        FRA = 'Spécifie le mode d''expédition au client des articles figurant sur le document vente.';
                        }
                        field("Shipping Agent Code"; Rec."Shipping Agent Code")
                        {
                            ApplicationArea = Suite;
                            CaptionML = ENU = 'Agent',
                                        FRA = 'Agent';
                            Editable = EditableMultipleRouteOrder;
                            ToolTipML = ENU = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.',
                                        FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';

                            trigger OnValidate();
                            begin
                                //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                                // IF Rec."Shipping Agent Code" <> xRec."Shipping Agent Code" THEN
                                //     CurrPage.UPDATE(TRUE);
                                // BC Upgrade BHARDA11 << ----Drink-IT Customization
                                //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                            end;
                        }
                        field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                        {
                            ApplicationArea = Suite;
                            CaptionML = ENU = 'Agent Service',
                                        FRA = 'Service agent';
                            Editable = EditableMultipleRouteOrder;
                            ToolTipML = ENU = 'Specifies the code that represents the default shipping agent service you are using for this sales order.',
                                        FRA = 'Spécifie le code qui représente la prestation transporteur par défaut que vous utilisez pour cette commande vente.';

                            trigger OnValidate();
                            begin
                                //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                                // IF Rec."Shipping Agent Service Code" <> xRec."Shipping Agent Service Code" THEN
                                //     CurrPage.UPDATE(TRUE);
                                // BC Upgrade BHARDA11 << ----Drink-IT Customization
                                //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                            end;
                        }
                        field("Package Tracking No."; Rec."Package Tracking No.")
                        {
                            ApplicationArea = Suite;
                            Importance = Additional;
                            ToolTipML = ENU = 'Specifies the shipping agent''s package number.',
                                        FRA = 'Spécifie le numéro récépissé du transporteur.';
                        }
                    }
                }
                group(Control85)
                {
                    field(BillToOptions; BillToOptions)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Bill-to',
                                    FRA = 'Facturation';
                        OptionCaptionML = ENU = 'Default (Customer),Another Customer',
                                          FRA = 'Par défaut (Clients),Autre client';
                        ToolTipML = ENU = 'Specifies the customer that the sales invoice will be sent to. Default (Customer): The same as the customer on the sales invoice. Another Customer: Any customer that you specify in the fields below.',
                                    FRA = 'Spécifie le client auquel la facture vente sera envoyée. Par défaut (Client) : identique au client figurant sur la facture vente. Autre client : tout client que vous spécifiez dans les champs ci-dessous.';

                        trigger OnValidate();
                        begin
                            IF BillToOptions = BillToOptions::"Default (Customer)" THEN
                                Rec.VALIDATE("Bill-to Customer No.", Rec."Sell-to Customer No.");
                        end;
                    }
                    group(Control82)
                    {
                        Visible = BillToOptions = BillToOptions::"Another Customer";
                        field("Bill-to Name"; Rec."Bill-to Name")
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Name',
                                        FRA = 'Nom';
                            Importance = Promoted;
                            ToolTipML = ENU = 'Specifies the customer to whom you will send the sales invoice, when different from the customer that you are selling to.',
                                        FRA = 'Spécifie le nom du client auquel vous envoyez la facture vente, s''il diffère du client auquel vous vendez.';

                            trigger OnValidate();
                            begin
                                IF Rec.GETFILTER("Bill-to Customer No.") = xRec."Bill-to Customer No." THEN
                                    IF Rec."Bill-to Customer No." <> xRec."Bill-to Customer No." THEN
                                        Rec.SETRANGE("Bill-to Customer No.");
                                // BC Upgrade BHARDA11 >> ---IsFoundationEnabled is not found in "Application Area Setup" Table

                                // IF ApplicationAreaSetup.IsFoundationEnabled THEN
                                //     SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);
                                // BC Upgrade BHARDA11 << ---IsFoundationEnabled is not found in "Application Area Setup" Table

                                CurrPage.UPDATE;
                            end;
                        }
                        field("Bill-to Address"; Rec."Bill-to Address")
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Address',
                                        FRA = 'Adresse';
                            Importance = Additional;
                            ToolTipML = ENU = 'Specifies the address of the customer that you will send the invoice to.',
                                        FRA = 'Spécifie l''adresse du client qui sera facturé.';
                        }
                        field("Bill-to Address 2"; Rec."Bill-to Address 2")
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Address 2',
                                        FRA = 'Adresse (2ème ligne)';
                            Importance = Additional;
                            ToolTipML = ENU = 'Specifies additional address information.',
                                        FRA = 'Spécifie des informations d''adresse supplémentaires.';
                        }
                        field("Bill-to Post Code"; Rec."Bill-to Post Code")
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Post Code',
                                        FRA = 'Code postal';
                            Importance = Additional;
                            ToolTipML = ENU = 'Specifies the postal code.',
                                        FRA = 'Spécifie le code postal.';
                        }
                        field("Bill-to City"; Rec."Bill-to City")
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'City',
                                        FRA = 'Ville';
                            Importance = Additional;
                            ToolTipML = ENU = 'Specifies the city you will send the invoice to.',
                                        FRA = 'Spécifie la ville du client qui sera facturé.';
                        }
                        field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                        {
                            Importance = Additional;
                        }
                        field("Bill-to Contact"; Rec."Bill-to Contact")
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Contact',
                                        FRA = 'Contact';
                            ToolTipML = ENU = 'Specifies the name of the person you should contact at the customer who you are sending the invoice to.',
                                        FRA = 'Spécifie le nom de la personne que vous devez contacter chez le client auquel vous envoyez la facture.';
                        }
                        field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                        {
                            CaptionML = ENU = 'Contact No.',
                                        FRA = 'N° contact';
                            Importance = Additional;
                            ToolTipML = ENU = 'Specifies the number of the contact the invoice will be sent to.',
                                        FRA = 'Spécifie le numéro du contact auquel vous envoyez la facture.';
                        }
                    }
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = All;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Fiscal Representative No.", "Tax Office Code", "Journey Time", "Submission Type", "Whse. Shipment No. (First)", "Whse. Shipment Status (First)", "Physical Location Group Code")
                // field("Fiscal Representative No."; Rec."Fiscal Representative No.")
                // {
                //     ApplicationArea = All;
                //     Description = '<DITW15.00.00.28-.38 #1217>-DIT-770 #354';
                //     Importance = Additional;
                // }
                // field("Tax Office Code"; Rec."Tax Office Code")
                // {
                //     ApplicationArea = All;
                //     Description = '<DITW15.00.00.38 #1217>- DTI-770 #354';
                //     Importance = Additional;
                // }
                // field("Journey Time"; Rec."Journey Time")
                // {
                //     ApplicationArea = All;
                //     Description = 'DITW15.00.00.39 #1353';
                // }
                // field("Submission Type"; Rec."Submission Type")
                // {
                //     ApplicationArea = All;
                // }
                // field("Whse. Shipment No. (First)"; Rec."Whse. Shipment No. (First)")
                // {
                //     ApplicationArea = All;
                //     Description = '<DITW15.00.00.39 #1399> DTI770 #354';
                //     Importance = Additional;
                //     Lookup = false;
                // }
                // field("Whse. Shipment Status (First)"; Rec."Whse. Shipment Status (First)")
                // {
                //     ApplicationArea = All;
                //     Description = '<DITW15.00.00.39 #1399> DTI770 #354';
                //     DrillDown = false;
                //     Importance = Additional;
                //     Lookup = false;
                // }
                // field("Physical Location Group Code"; Rec."Physical Location Group Code")
                // {
                //     ApplicationArea = All;
                //     Importance = Additional;
                //     QuickEntry = false;

                //     trigger OnValidate();
                //     begin
                //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
                //         IF "Physical Location Group Code" <> xRec."Physical Location Group Code" THEN
                //             CurrPage.UPDATE(TRUE);
                //         // >>DITW18.00.06 DDR DIT-770 #1190
                //     end;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Fields("Fiscal Representative No.", "Tax Office Code", "Journey Time", "Submission Type", "Whse. Shipment No. (First)", "Whse. Shipment Status (First)", "Physical Location Group Code")
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTipML = ENU = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.',
                                FRA = 'Spécifie le magasin à partir duquel les articles de stock doivent être expédiés par défaut au client figurant sur le document vente.';

                    trigger OnValidate();
                    begin
                        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
                        IF Rec."Location Code" <> xRec."Location Code" THEN
                            CurrPage.UPDATE(TRUE);
                        // >>DITW18.00.06 DDR DIT-770 #1190
                    end;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Return Location Code")
                // field("Return Location Code"; Rec."Return Location Code")
                // {
                //     ApplicationArea = All;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Fields("Return Location Code")
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTipML = ENU = 'Specifies the outbound warehouse handling time.',
                                FRA = 'Spécifie le délai désenlogement.';
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies the date that you have promised to deliver the order, as a result of the Order Promising function.',
                                FRA = 'Spécifie la date à laquelle vous avez promis de livrer la commande via la fonction Promesse de livraison.';
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Delivery Time")
                // field("Delivery Time"; Rec."Delivery Time")
                // {
                //     ApplicationArea = All;
                //     Importance = Additional;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Fields("Delivery Time")
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                    Description = 'DTI - 770 #354';
                    Importance = Additional;
                    ToolTipML = ENU = 'Specifies how long it takes from when the sales order is shipped from the warehouse to when the order is delivered.',
                                FRA = 'Spécifie le délai nécessaire entre le moment de l''expédition à partir de l''entrepôt et la livraison de la commande.';
                }
                field("Late Order Shipping"; Rec."Late Order Shipping")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTipML = ENU = 'Specifies that the shipment of one or more lines has been delayed, or that the shipment date is before the work date.',
                                FRA = 'Spécifie que l''expédition d''une ou de plusieurs lignes a été retardée ou que la date d''expédition est antérieure à la date de travail.';
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Shipment Date Formula", "Shipment Time")
                // field("Shipment Date Formula"; Rec."Shipment Date Formula")
                // {
                //     ApplicationArea = All;
                //     Description = 'DITW17.00.02 DIT-770 #146 DTI - 770 #354';
                //     Importance = Additional;
                // }
                // field("Shipment Time"; Rec."Shipment Time")
                // {
                //     ApplicationArea = All;
                //     Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230';
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Fields("Shipment Date Formula", "Shipment Time")
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTipML = ENU = 'Specifies if the customer accepts partial shipment of orders.',
                                FRA = 'Spécifie si le client accepte l''expédition partielle des commandes.';

                    trigger OnValidate();
                    begin
                        IF Rec."Shipping Advice" <> xRec."Shipping Advice" THEN
                            IF NOT CONFIRM(Text001, FALSE, Rec.FIELDCAPTION("Shipping Advice")) THEN
                                ERROR(Text002);
                    end;
                }
                field("Copy Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Description = 'NRQ#16082';
                    Editable = EditableMultipleRouteOrder;
                    ToolTipML = ENU = 'Specifies how items on the sales document are shipped to the customer.',
                                FRA = 'Spécifie le mode d''expédition au client des articles figurant sur le document vente.';
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Picking Type", "Distance", "Truck Code", "Trailer Code", "Truck Zone", "Driver Code", "Driver 2 Code", "Require 2 Drivers", "Ship-to Address Key No.", "Route", "Route Planning No.", "Delivery Sequence", "Shipping Charge Per", "Maximum Weight", "Maximum Cubage", "Total Weight (Base)", "Total Weight", "Total Cubage (Base)", "Total Cubage", "Total HL Cubage (Base)", "Total HL Cubage", "Total Eq. UOM Quantity (Base)", "Total Eq. UOM Quantity", "Delivery Time 1 From", "Delivery Time 1 To", "Delivery Time 2 From", "Delivery Time 2 To", "Customer Delivery Type", "Delivery Time (sec.)")
                //BC UPGRADE KUMARR78 ++ 05-05-2026
                // field("Picking Type"; Rec."Picking Type")
                // {
                //     ApplicationArea = All;
                // }
                // field(Distance; Distance)
                // {
                //     ApplicationArea = All;
                //     Description = '<DITW15.00.00.24>-NRQ#16082';
                // }
                //BC UPGRADE KUMARR78 ++ 05-05-2026
                field("Truck Code"; Rec."Vehicle Code 101FDW")
                {
                    ApplicationArea = All;
                    Description = '<DITW15.00.00.25 - DITW18.00.06 MSF 07/07/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
                    Editable = EditableMultipleRouteOrder;

                    trigger OnValidate();
                    begin
                        //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                        IF xRec."Vehicle Code 101FDW" <> Rec."Vehicle Code 101FDW" THEN
                            CurrPage.UPDATE(TRUE)
                        //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                    end;

                }
                //BC UPGRADE KUMARR78 ++ 05-05-2026
                field("Trailer Code"; Rec."Trailer 107FDW")
                {
                    ApplicationArea = All;
                    Description = '<DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 - DITW18.00.06 MSF 07/07/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
                    Editable = EditableMultipleRouteOrder;

                    trigger OnValidate();
                    begin
                        //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                        IF xRec."Trailer 107FDW" <> Rec."Trailer 107FDW" THEN
                            CurrPage.UPDATE(TRUE)
                        //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                    end;
                }
                //BC UPGRADE KUMARR78 ++ 05-05-2026
                // field("Truck Zone"; Rec."Truck Zone")
                // {
                //     ApplicationArea = All;
                //     Description = '<DITW17.00.02 DIT-770 #154>--NRQ#16082';
                // }
                //BC UPGRADE KUMARR78 ++ 05-05-2026

                field("Driver Code"; Rec."Log Driver 107FDW")
                {
                    ApplicationArea = All;
                    Description = '<DITW15.00.00.25 - DITW18.00.06 MSF 07/07/2015 DIT-770 #1212 #1213 #1214>--NRQ#16082';
                    Editable = EditableMultipleRouteOrder;

                    trigger OnValidate();
                    begin
                        //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                        IF xRec."Log Driver 107FDW" <> Rec."Log Driver 107FDW" THEN
                            CurrPage.UPDATE(TRUE)
                        //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                    end;
                }
                //BC UPGRADE KUMARR78 ++ 05-05-2026

                // field("Driver 2 Code"; Rec."Driver 2 Code")
                // {
                //     ApplicationArea = All;
                //     Description = '<DITW17.00.02 DIT-770 #154 - DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
                //     Editable = EditableMultipleRouteOrder;

                //     trigger OnValidate();
                //     begin
                //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                //         IF xRec."Driver 2 Code" <> Rec."Driver 2 Code" THEN
                //             CurrPage.UPDATE(TRUE)
                //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                //     end;
                // }
                // field("Require 2 Drivers"; Rec."Require 2 Drivers")
                // {
                //     Editable = EditableMultipleRouteOrder;
                // }
                // field("Ship-to Address Key No."; Rec."Ship-to Address Key No.")
                // {
                //     ApplicationArea = All;
                // }
                //BC UPGRADE KUMARR78 ++ 05-05-2026

                field(Route; Rec."Route 107FDW")
                {
                    ApplicationArea = All;
                    Description = '<DITW16.00.00.40 #1002> - DITW18.00.06 MSF 13/05/2015 DIT-770 #1212 #1213 #1214--NRQ#16082';
                    ShowMandatory = RouteAsMandatory;

                    trigger OnDrillDown();
                    begin
                        // <<DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
                        // DrillDownRouteCombinaison;
                        // >>DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
                    end;
                }
                //BC UPGRADE KUMARR78 ++ 05-05-2026

                //BC UPGRADE KUMARR78 ++ 05-05-2026

                field("Route Planning No."; Rec."Route Planning No. 107FDW")
                {
                    Editable = false;
                }
                //BC UPGRADE KUMARR78 ++ 05-05-2026

                // field("Delivery Sequence"; Rec."Delivery Sequence")
                // {
                //     ApplicationArea = All;
                //     Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230-NRQ#16082';
                // }
                // field("Shipping Charge Per"; Rec."Shipping Charge Per")
                // {
                //     ApplicationArea = All;
                //     Description = '<DITW15.00.00.21> DTI - 770 #354';
                //     Editable = false;
                //     Importance = Additional;
                // }
                // field("Maximum Weight"; Rec."Maximum Weight")
                // {
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = "Maximum WeightEmphasize";
                //     Visible = "Maximum WeightVisible";
                // }
                // field("Maximum Cubage"; Rec."Maximum Cubage")
                // {
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = "Maximum CubageEmphasize";
                //     Visible = "Maximum CubageVisible";
                // }
                // field("Total Weight (Base)"; Rec."Total Weight (Base)")
                // {
                //     ApplicationArea = All;
                //     Importance = Additional;
                // }
                // field("Total Weight"; Rec."Total Weight")
                // {
                //     ApplicationArea = All;
                // }
                // field("Total Cubage (Base)"; Rec."Total Cubage (Base)")
                // {
                //     ApplicationArea = All;
                //     Importance = Additional;
                // }
                // field("Total Cubage"; Rec."Total Cubage")
                // {
                //     ApplicationArea = All;
                // }
                // field("Total HL Cubage (Base)"; Rec."Total HL Cubage (Base)")
                // {
                //     ApplicationArea = All;
                // }
                // field("Total HL Cubage"; Rec."Total HL Cubage")
                // {
                //     ApplicationArea = All;
                // }
                // field("Total Eq. UOM Quantity (Base)"; Rec."Total Eq. UOM Quantity (Base)")
                // {
                //     ApplicationArea = All;
                //     Importance = Additional;
                // }
                // field("Total Eq. UOM Quantity"; Rec."Total Eq. UOM Quantity")
                // {
                //     ApplicationArea = All;
                //     Importance = Additional;
                // }
                // field("Delivery Time 1 From"; Rec."Delivery Time 1 From")
                // {
                //     ApplicationArea = All;
                // }
                // field("Delivery Time 1 To"; Rec."Delivery Time 1 To")
                // {
                //     ApplicationArea = All;
                // }
                // field("Delivery Time 2 From"; Rec."Delivery Time 2 From")
                // {
                //     ApplicationArea = All;
                // }
                // field("Delivery Time 2 To"; Rec."Delivery Time 2 To")
                // {
                //     ApplicationArea = All;
                // }
                // field("Customer Delivery Type"; Rec."Customer Delivery Type")
                // {
                //     ApplicationArea = All;
                // }
                // field("Delivery Time (sec.)"; Rec."Delivery Time (sec.)")
                // {
                //     ApplicationArea = All;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Fields("Picking Type", "Distance", "Truck Code", "Trailer Code", "Truck Zone", "Driver Code", "Driver 2 Code", "Require 2 Drivers", "Ship-to Address Key No.", "Route", "Route Planning No.", "Delivery Sequence", "Shipping Charge Per", "Maximum Weight", "Maximum Cubage", "Total Weight (Base)", "Total Weight", "Total Cubage (Base)", "Total Cubage", "Total HL Cubage (Base)", "Total HL Cubage", "Total Eq. UOM Quantity (Base)", "Total Eq. UOM Quantity", "Delivery Time 1 From", "Delivery Time 1 To", "Delivery Time 2 From", "Delivery Time 2 To", "Customer Delivery Type", "Delivery Time (sec.)")
            }
            group("Foreign Trade")
            {
                CaptionML = ENU = 'Foreign Trade',
                            FRA = 'International';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTipML = ENU = 'Specifies the currency of amounts on the sales document.',
                                FRA = 'Spécifie la devise des montants sur le document vente.';

                    trigger OnAssistEdit();
                    begin
                        CLEAR(ChangeExchangeRate);
                        IF Rec."Posting Date" <> 0D THEN
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        ELSE
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE;
                        SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies whether the sales document is part of a three-party trade.',
                                FRA = 'Spécifie si le document vente fait partie d''une transaction tripartite.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the type of transaction that the sales document represents, for the purpose of reporting to INTRASTAT.',
                                FRA = 'Spécifie le type de transaction que représente le document vente, à des fins de compte rendu à INTRASTAT.';
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies a code for the sales document''s transaction specification, for the purpose of reporting to INTRASTAT.',
                                FRA = 'Spécifie un code pour le régime du document vente, à des fins de compte-rendu à INTRASTAT.';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the transport method, for the purpose of reporting to INTRASTAT.',
                                FRA = 'Spécifie le mode de transport, à des fins de compte-rendu à INTRASTAT.';
                }

                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Transport Mode")
                // field("Transport Mode"; Rec."Transport Mode")
                // {
                //     ApplicationArea = All;
                //     Description = 'DIT715 #187';
                //     DrillDown = false;
                //     Editable = false;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Fields("Transport Mode")
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the point of exit through which you ship the items out of your country/region, for reporting to Intrastat.',
                                FRA = 'Spécifie le point de sortie par lequel les articles sortent de votre pays/région, à des fins de compte-rendu à Intrastat.';
                }
                field("Area"; Rec."Area")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the area of the customer''s address, for the purpose of reporting to INTRASTAT.',
                                FRA = 'Spécifie la région de l''adresse du client, à des fins de compte-rendu à INTRASTAT.';
                }
                //         field(Area;Area)
                // {
                //                        ToolTipML = ENU='Specifies the area of the customer''s address, for the purpose of reporting to INTRASTAT.',
                //                         FRA='Spécifie la région de l''adresse du client, à des fins de compte-rendu à INTRASTAT.';
                // }
            }
            group(Prepayments)
            {
                CaptionML = ENU = 'Prepayment',
                            FRA = 'Acompte';
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTipML = ENU = 'Specifies the prepayment percentage if you want to apply a prepayment to all lines on the sales order.',
                                FRA = 'Spécifie le pourcentage acompte si vous voulez appliquer un acompte à toutes les lignes de la commande vente.';

                    trigger OnValidate();
                    begin
                        Prepayment37OnAfterValidate;
                    end;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies that prepayments on the sales order are combined if they have the same general ledger account for prepayments or the same dimensions.',
                                FRA = 'Spécifie que les acomptes sur la commande vente sont combinés s''ils ont le même compte général pour les acomptes ou les mêmes axes analytiques.';
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the code that represents the payment terms for prepayment invoices related to the sales document.',
                                FRA = 'Spécifie le code qui représente les conditions de paiement pour les factures acompte en relation avec le document vente.';
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTipML = ENU = 'Specifies when the prepayment invoice for this sales order is due.',
                                FRA = 'Spécifie quand la facture d''acompte de cette commande vente est due.';
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the payment discount percent granted on the prepayment if the customer pays on or before the date entered in the Prepmt. Pmt. Discount Date field.',
                                FRA = 'Spécifie le pourcentage escompte accordé sur l''acompte si le client paie au plus tard à la date saisie dans le champ Date escompte acompte.';
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the last date the customer can pay the prepayment invoice and still receive a payment discount on the prepayment amount.',
                                FRA = 'Spécifie la dernière date à laquelle le client peut payer la facture acompte et bénéficier d''un escompte sur le montant d''acompte.';
                }
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Contract Type", "DIT Sub-Contract Type", "Service Contract No.", "Financial Contract No.", "Contract Group Code")
            // group("Service/Contract")
            // {
            //     CaptionML = ENU = 'Service/Contract',
            //                 FRA = 'Service/ Contrat';
            //     field("Contract Type"; Rec."Contract Type")
            //     {
            //         Editable = false;
            //     }
            //     field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Service Contract No."; Rec."Service Contract No.")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Financial Contract No."; Rec."Financial Contract No.")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Contract Group Code"; Rec."Contract Group Code")
            //     {
            //         ApplicationArea = All;
            //     }
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Contract Type", "DIT Sub-Contract Type", "Service Contract No.", "Financial Contract No.", "Contract Group Code")
            group(Marketing)
            {
                CaptionML = ENU = 'Marketing',
                            FRA = 'Marketing';
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the number of the campaign that the document is linked to.';
                }
                field("Opportunity No."; Rec."Opportunity No.")
                {
                    ApplicationArea = RelationshipMgmt;
                    Importance = Promoted;
                    ToolTipML = ENU = 'Specifies the number of the opportunity that the sales quote is assigned to.',
                                FRA = 'Spécifie le numéro de l''opportunité à laquelle le devis est affecté.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
            }
        }
        area(factboxes)
        {
            part("Pending Approval FactBox"; "Pending Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = CONST(36),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part("Sales Hist. Sell-to FactBox"; "Sales Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
            }
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
            // part(ItemHistory; 2035391)
            // {
            //     CaptionML = ENU = 'Order Totals',
            //                 FRA = 'Historique article';
            //     Description = 'DIT-770 #354';
            //     SubPageLink = Customer No.=FIELD(Sell-to Customer No.);
            //         Visible = false;
            // }
            // part(OrderTotalsOutboundFactbox; 2035400)
            // {
            //     Caption = 'Order Totals (outbound)';
            //     SubPageLink = Customer No.=FIELD(Sell-to Customer No.);
            //         Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Customization
            part("Sales Line FactBox"; "Sales Line FactBox")
            {
                ApplicationArea = Suite;
                Provider = SalesLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
            }
            part("Item Invoicing FactBox"; "Item Invoicing FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                Visible = false;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ShowFilter = false;
                Visible = false;
            }
            part("Resource Details FactBox"; "Resource Details FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part("Item Warehouse FactBox"; "Item Warehouse FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part("Sales Hist. Bill-to FactBox"; "Sales Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                CaptionML = ENU = 'O&rder',
                            FRA = '&Commande';
                Image = "Order";
                action(Statistics)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Statistics',
                                FRA = 'Statistiques';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ShortCutKey = 'F7';
                    ToolTipML = ENU = 'View statistical information, such as the value of posted entries, for the record.',
                                FRA = 'Affichez les informations statistiques telles que la valeur des écritures validées pour l''enregistrement.';

                    trigger OnAction();
                    var
                        Handled: Boolean;
                    begin
                        OnBeforeStatisticsAction(Rec, Handled);
                        IF NOT Handled THEN BEGIN
                            Rec.OpenSalesOrderStatistics();
                            SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
                        END
                    end;
                }
                action(Card)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Card',
                                FRA = 'Fiche';
                    Image = EditLines;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTipML = ENU = 'View or create the standard sales lines that are represented by the code on the recurring sales line.',
                                FRA = 'Affichez ou créez les lignes ventes standard qui sont représentées par le code sur la ligne vente récurrente.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Dimensions',
                                FRA = 'Axes analytiques';
                    Enabled = Rec."No." <> '';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.',
                                FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Approvals',
                                FRA = 'Approbations';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedOnly = true;
                    ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.',
                                FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';

                    trigger OnAction();
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalEntry: Record "Approval Entry"; // BC Upgrade BHARDA11:: Added
                    begin
                        // ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No."); // BC Upgrade BHARDA11 ::Blocked
                        // BC Upgrade BHARDA11 >> ::Added
                        ApprovalEntry.SetRange("Document Type", Rec."Document Type");
                        ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordId);
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        // BC Upgrade BHARDA11 << ::Added
                        ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    CaptionML = ENU = 'Co&mments',
                                FRA = 'Co&mmentaires';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                // BC Upgrade BHARAD11 >> ----Drink-IT Customization
                // action("Comments - Transport Mode")
                // {
                //     CaptionML = ENU='Comments - Transport Mode',
                //                 FRA='Commantaires - Mode de transport';
                //     Description = 'DIT715 #187';
                //     Image = ViewComments;
                //     RunObject = Page 2014270;
                //                     RunPageLink = Table ID=CONST(36),
                //                   Document Type=CONST(1),
                //                   Document No.=FIELD(No.),
                //                   Document Line No.=CONST(0),
                //                   Field ID=CONST(2014277);
                // }
                // BC Upgrade BHARAD11 << ----Drink-IT Customization
                action(AssemblyOrders)
                {
                    AccessByPermission = TableData "BOM Component" = R;
                    CaptionML = ENU = 'Assembly Orders',
                                FRA = 'Ordres d''assemblage';
                    Image = AssemblyOrder;

                    trigger OnAction();
                    var
                        AssembleToOrderLink: Record "Assemble-to-Order Link";
                    begin
                        AssembleToOrderLink.ShowAsmOrders(Rec);
                    end;
                }
            }
            group(ActionGroupCRM)
            {
                CaptionML = ENU = 'Dynamics CRM',
                            FRA = 'Dynamics CRM';
                Visible = CRMIntegrationEnabled;
                action(CRMGoToSalesOrder)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Sales Order',
                                FRA = 'Commande vente';
                    Enabled = CRMIntegrationEnabled AND CRMIsCoupledToRecord;
                    Image = CoupledOrder;
                    ToolTipML = ENU = 'View the selected sales order.',
                                FRA = 'Affichez la commande vente sélectionnée.';

                    trigger OnAction();
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RECORDID);
                    end;
                }
                // action("Shipping Costs")
                // {
                //     CaptionML = ENU = 'Shipping Costs',
                //                 FRA = 'Coûts transport';
                //     Image = Costs;
                //     RunObject = Page 2014096;
                //     RunPageLink = Source Type=CONST(36),
                //                   Source No.=FIELD(No.),
                //                   Sub Type=FIELD(Document Type);
                // }
            }
            group(Documents)
            {
                CaptionML = ENU = 'Documents',
                            FRA = 'Documents';
                Image = Documents;
                action("S&hipments")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'S&hipments',
                                FRA = 'Li&vraisons';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTipML = ENU = 'View a list of the sales shipments you have posted.',
                                FRA = 'Affichez une liste des expéditions vente que vous avez validées.';
                }
                action(Invoices)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Invoices',
                                FRA = 'Factures';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTipML = ENU = 'View the history of posted sales invoices that have been posted for the document.',
                                FRA = 'Affichez l''historique des factures vente validées qui ont été enregistrées pour le document.';
                }
                // action("&Return Orders")
                // {
                //     CaptionML = ENU='&Return Orders',
                //                 FRA='&Retours';
                //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
                //     Image = ReturnOrder;
                //     RunObject = Page 45;
                //                     RunPageLink = Link Sales Document Type=FIELD(Document Type),
                //                   Link Sales Document No.=FIELD(No.);
                // }
                // action("Return R&eceipts")
                // {
                //     CaptionML = ENU='Return R&eceipts',
                //                 FRA='Réceptions retour';
                //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
                //     Image = ReturnReceipt;
                //     RunObject = Page 6662;
                //                     RunPageLink = Link Sales Document No.=FIELD(No.);
                // }
            }
            group(Warehouse)
            {
                CaptionML = ENU = 'Warehouse',
                            FRA = 'Entrepôt';
                Image = Warehouse;
                action("In&vt. Put-away/Pick Lines")
                {
                    CaptionML = ENU = 'In&vt. Put-away/Pick Lines',
                                FRA = 'Lignes prélè&v./rangement stock';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Sales Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
                action("Whse. Shipment Lines")
                {
                    CaptionML = ENU = 'Whse. Shipment Lines',
                                FRA = 'Lignes expédition entrep.';
                    Image = ShipmentLines;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = CONST(37),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
                // action("<Action1161021001>")
                // {
                //     CaptionML = ENU='Show N-owm activities',
                //                 FRA='Visualiser Activitées N-owm';
                //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
                //     Image = NewResource;

                //     trigger OnAction();
                //     var
                //         owmUtils : Codeunit "6062406";
                //     begin
                //         owmUtils.ShowActivityStatus(owmUtils.ActPick,"No.",'');  //DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
                //     end;
                // }
            }
            group(Prepayment)
            {
                CaptionML = ENU = 'Prepayment',
                            FRA = 'Acompte';
                Image = Prepayment;
                action(PagePostedSalesPrepaymentInvoices)
                {
                    CaptionML = ENU = 'Prepa&yment Invoices',
                                FRA = 'Factures acom&pte';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
                action(PagePostedSalesPrepaymentCrMemos)
                {
                    CaptionML = ENU = 'Prepayment Credi&t Memos',
                                FRA = 'A&voirs acompte';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }

            }
        }
        area(processing)
        {
            group(Approval)
            {
                CaptionML = ENU = 'Approval',
                            FRA = 'Approbation';
                action(Approve)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Approve',
                                FRA = 'Approuver';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTipML = ENU = 'Approve the requested changes.',
                                FRA = 'Approuvez les modifications requises.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Reject',
                                FRA = 'Rejeter';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTipML = ENU = 'Reject the approval request.',
                                FRA = 'Rejetez la demande d''approbation.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Delegate',
                                FRA = 'Déléguer';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTipML = ENU = 'Delegate the approval to a substitute approver.',
                                FRA = 'Déléguez l''approbation à un approbateur remplaçant.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Comments',
                                FRA = 'Commentaires';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTipML = ENU = 'View or add comments.',
                                FRA = 'Affichez ou ajoutez des commentaires.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group(Release1)
            {
                CaptionML = ENU = 'Release',
                            FRA = 'Lancer';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Re&lease',
                                FRA = '&Lancer';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction();
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        //<<HEI.02
                        Rec.CheckForLinkSalesDocument(Rec);
                        //>>HEI.02
                        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                        // // <<DITW15.00.00.36 DDR 07/12/2009
                        CurrPage.UPDATE(TRUE);
                        // // >>DITW15.00.00.36 DDR
                        // //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
                        // IF "Sundry Customer" THEN
                        //     TestSundryMandatoryFields();
                        // BC Upgrade BHARDA11 << ----Drink-IT Customization
                        //>HEI.04>>
                        HeinekenGlobal.CheckPCVNBalance(Rec);
                        //>HEI.04>>
                        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                        //>> DITW18.00.07 DIT-770 #1804
                        // ReleaseSalesDoc.DocStatusRelease(xRec, Rec);
                        ReleaseSalesDoc.PerformManualRelease(Rec);//BC UPGRADE KUMARR78 ++
                        CurrPage.UPDATE;
                        // >>DITW15.00.00.39 DDR #1330 #1407
                        // BC Upgrade BHARDA11 << ----Drink-IT Customization
                    end;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                //BC UPGRADE KUMARR78 ++ 05-05-2026 
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Re&open',
                                FRA = 'R&ouvrir';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F10';
                    ToolTipML = ENU = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.',
                                FRA = 'Rouvrez le document pour le modifier après son approbation. Les documents approuvés ont le statut Lancé et doivent être ouverts pour pouvoir être modifiés.';

                    trigger OnAction();
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
                        //ReleaseSalesDoc.PerformManualReopen(Rec);
                        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                        //BC UPGRADE KUMARR78 ++ 05-05-2026 
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                        CurrPage.UPDATE;
                        //BC UPGRADE KUMARR78 ++ 05-05-2026 

                        // BC Upgrade BHARDA11 << ----Drink-IT Customization
                        // >>DITW15.00.00.39 DDR #1330 - #1407
                    end;
                }
                //BC UPGRADE KUMARR78 ++ 05-05-2026 
                // BC Upgrade BHARDA11 << ----Drink-IT Customization
            }
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions',
                            FRA = 'Fonction&s';
                Image = "Action";
                action(CreatePurchaseInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Create Purchase Invoice',
                                FRA = 'Créer une facture achat';
                    Image = NewPurchaseInvoice;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category8;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    ToolTipML = ENU = 'Create a new purchase invoice so you can buy items from a vendor.',
                                FRA = 'Créez une facture achat de manière à pouvoir acheter des articles à un fournisseur.';

                    trigger OnAction();
                    var
                        SelectedSalesLine: Record "Sales Line";
                        PurchInvFromSalesInvoice: Codeunit "Purch. Doc. From Sales Doc.";
                    begin
                        CurrPage.SalesLines.PAGE.SETSELECTIONFILTER(SelectedSalesLine);
                        PurchInvFromSalesInvoice.CreatePurchaseInvoice(Rec, SelectedSalesLine);
                    end;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                // action("Change Sundry customer fields")
                // {
                //     CaptionML = ENU='Change Sundry customer fields',
                //                 FRA='champs client divers';
                //     Image = ChangeCustomer;
                //     Promoted = true;
                //     PromotedIsBig = true;
                //     Visible = "Sundry Customer";

                //     trigger OnAction();
                //     begin
                //         //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
                //         ShowCustomerSundryInfo();
                //         //>> DITW18.00.07 DIT-770 #1804
                //         //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
                //         CurrPage.UPDATE(TRUE);
                //         //>> DITW18.00.07 DIT-770 #1804
                //     end;
                // }
                // action("Process backorder lines")
                // {
                //     Caption = 'Process backorder lines';
                //     Image = ClosePeriod;

                //     trigger OnAction();
                //     var
                //         BackorderMgmt : Codeunit "2014082";
                //     begin
                //         // << DITW110.00.10 SFI 20/06/2017 BL#15657
                //         BackorderMgmt.ProcessBackorderLines(Rec,0);
                //     end;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Customization
                group("Get Delayed Discount-Promotion")
                {
                    CaptionML = ENU = 'Get Delayed Discount-Promotion',
                                FRA = 'Extraire remise - promotion retardée';
                    // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                    // action("Get Delayed Discount")
                    // {
                    //     CaptionML = ENU='Get Delayed Discount',
                    //                 FRA='Extraire remise retardée';
                    //     Ellipsis = true;
                    //     Image = Error;
                    //     Promoted = true;
                    //     PromotedIsBig = true;
                    //     Visible = DelayDiscountAl;

                    //     trigger OnAction();
                    //     var
                    //         lcduDelayedLineMgt : Codeunit "2013764";
                    //     begin
                    //         // <<DITW15.00.00.26 DDR 31/10/2008
                    //         lcduDelayedLineMgt.GetSalesLineDelayed(Rec,3);
                    //         // >>DITW15.00.00.26 DDR
                    //     end;
                    // }
                    // action("Get Pre-Promotion Order")
                    // {
                    //     CaptionML = ENU='Get Pre-Promotion Order',
                    //                 FRA='Extraire commande prépromotion';
                    //     Ellipsis = true;
                    //     Image = Error;
                    //     Promoted = true;
                    //     PromotedIsBig = true;
                    //     Visible = DelayPromotionAl;

                    //     trigger OnAction();
                    //     var
                    //         lcduDelayedLineMgt : Codeunit "2013764";
                    //     begin
                    //         // <<DITW15.00.00.26 DDR 31/10/2008
                    //         lcduDelayedLineMgt.GetSalesLineDelayed(Rec,4);
                    //         // >>DITW15.00.00.26 DDR
                    //     end;
                    // }
                }
                // action("Get Blanket order lines")
                // {
                //     Caption = 'Get Blanket order lines';
                //     Image = Error;
                //     Promoted = true;
                //     PromotedIsBig = true;
                //     Visible = GetBlanketOrderLinesAvail;

                //     trigger OnAction();
                //     var
                //         BackorderMgmt : Codeunit "2014082";
                //     begin
                //         // << DITW110.00.10 SFI 20/06/2017 BL#15657
                //         // Only one of the actions is visible at any time
                //         BackorderMgmt.GetBlanketOrderLines(Rec);
                //     end;
                // }
                // action("Get Blanket order lines")
                // {
                //     Caption = 'Get Blanket order lines';
                //     Image = GetLines;
                //     Promoted = true;
                //     PromotedIsBig = true;
                //     Visible = NOT GetBlanketOrderLinesAvail;

                //     trigger OnAction();
                //     var
                //         BackorderMgmt : Codeunit "2014082";
                //     begin
                //         // << DITW110.00.10 SFI 20/06/2017 BL#15657
                //         // Only one of the actions is visible at any time
                //         BackorderMgmt.GetBlanketOrderLines(Rec);
                //     end;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Customization
                action("Get St&d. Cust. Sales Codes")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Get St&d. Cust. Sales Codes',
                                FRA = 'Extraire &codes vente client std';
                    Ellipsis = true;
                    Image = CustomerCode;
                    ToolTipML = ENU = 'View a list of the standard sales codes that have been assigned to the current customer.',
                                FRA = 'Affichez une liste des codes vente standard affectés au client actuel.';

                    trigger OnAction();
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }

                action("Archive Document")
                {
                    CaptionML = ENU = 'Archi&ve Document',
                                FRA = 'Archi&ver document';
                    Image = Archive;

                    trigger OnAction();
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Send IC Sales Order Cnfmn.")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    CaptionML = ENU = 'Send IC Sales Order Cnfmn.',
                                FRA = 'Confirmation envoi commande vente IC';
                    Image = IntercompanyOrder;

                    trigger OnAction();
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                            ICInOutboxMgt.SendSalesDoc(Rec, FALSE);
                    end;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                // action("&Automatic FEFO Tracking for Order")
                // {
                //     CaptionML = ENU = '&Automatic FEFO Tracking for Order',
                //                 FRA = 'Traçabilité &automatique FEFO pour commande';
                //     Description = '#1331';
                //     Image = ItemTracking;
                //     ShortCutKey = 'Shift+Ctrl+F';

                //     trigger OnAction();
                //     begin
                //         // <<DITW16.00.00.40 DDR 03/02/2012 #1331
                //         CurrPage.SAVERECORD;
                //         COMMIT;
                //         FEFOTrackingOrder();
                //         CurrPage.UPDATE(FALSE);
                //     end;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Customization
                action(CopyDocument)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Copy Document',
                                FRA = 'Copier document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    ToolTipML = ENU = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.',
                                FRA = 'Copiez les lignes document et les informations d''en-tête d''un autre document vente vers celui-ci. Vous pouvez copier une facture vente validée dans une nouvelle facture vente pour créer rapidement un document similaire.';

                    trigger OnAction();
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                        IF Rec.GET(Rec."Document Type", Rec."No.") THEN;
                    end;
                }
                action(MoveNegativeLines)
                {
                    CaptionML = ENU = 'Move Negative Lines',
                                FRA = 'Déplacer lignes négatives';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

                    trigger OnAction();
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                // action("Update Order")
                // {
                //     CaptionML = ENU = 'Update Order',
                //                 FRA = 'Mettre à jour la commande';
                //     Ellipsis = true;

                //     trigger OnAction();
                //     begin
                //         // <<DITW15.00.00.39 DDR 19/08/2011 #1364
                //         ShowUpdateSalesOrder();
                //     end;
                // }
                // action("Sales Item History")
                // {
                //     CaptionML = ENU = 'Sales Item History',
                //                 FRA = 'Historique ventes article';
                //     Image = MakeOrder;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     ShortCutKey = 'Shift+Ctrl+N';

                //     trigger OnAction();
                //     var
                //         ItemHistoryBuf: Record "2035390" temporary;
                //         FormProposal: Page "2035390";
                //         ReturnAction: Action;
                //     begin

                //         TESTFIELD(Status, Status::Open);

                //         TESTFIELD("Sell-to Customer No.");

                //         ItemHistoryBuf.SETRANGE("Customer No.", "Sell-to Customer No.");
                //         ItemHistoryBuf.SETFILTER("Ship-to Code", "Ship-to Code");
                //         ItemHistoryBuf.SETFILTER("Ship-to Filter", "Ship-to Code");
                //         ItemHistoryBuf."Customer No." := "Sell-to Customer No.";
                //         ItemHistoryBuf."Posting Date" := "Posting Date";
                //         ItemHistoryBuf."Ship-to Code" := "Ship-to Code";
                //         ItemHistoryBuf."Shipment Date" := "Shipment Date";
                //         ItemHistoryBuf."Item Ledger Entry No." := 0; //fixme "Entry No.";
                //         FormProposal.SetCurrOrder(Rec);
                //         FormProposal.LOOKUPMODE := TRUE;
                //         //FormProposal.SETRECORD(ItemHistoryBuf);
                //         FormProposal.SETTABLEVIEW(ItemHistoryBuf);
                //         ReturnAction := FormProposal.RUNMODAL;
                //         FormProposal.GetReturnActionForm(ReturnAction);
                //         IF NOT (ReturnAction IN [ACTION::OK, ACTION::LookupOK]) THEN
                //             EXIT;

                //         FormProposal.GetBuffer(ItemHistoryBuf);
                //         MakeSalesOrder(ItemHistoryBuf);
                //     end;
                // }
                // action("Calculate Recycle Charges")
                // {
                //     Caption = 'Calculate Recycle Charges';
                //     Description = 'FINXL7.00.001 KLU 27/06/2014 #42';
                //     Image = Reuse;

                //     trigger OnAction();
                //     var
                //         cduSalesHook: Codeunit "2029625";
                //     begin
                //         //<<FINXL9.00.000.01 ACH 10/01/2017
                //         cduSalesHook.fctRecycleChargeSalesHeader(Rec);
                //         //>>FINXL9.00.000.01 ACH 10/01/2017
                //     end;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Customization
                group(IncomingDocument)
                {
                    CaptionML = ENU = 'Incoming Document',
                                FRA = 'Document entrant';
                    Image = Documents;
                    action(IncomingDocCard)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'View Incoming Document',
                                    FRA = 'Afficher le document entrant';
                        Enabled = HasIncomingDocument;
                        Image = ViewOrder;
                        ToolTipML = ENU = 'View any incoming document records and file attachments that exist for the entry or document.',
                                    FRA = 'Affichez tout enregistrement et fichier joint de document entrant qui existe pour l''écriture ou le document.';

                        trigger OnAction();
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                        end;
                    }
                    action(SelectIncomingDoc)
                    {
                        AccessByPermission = TableData "Incoming Document" = R;
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Select Incoming Document',
                                    FRA = 'Sélectionner le document entrant';
                        Image = SelectLineToApply;
                        ToolTipML = ENU = 'Select an incoming document record and file attachment that you want to link to the entry or document.',
                                    FRA = 'Sélectionnez un fichier joint ou un enregistrement de document entrant que vous voulez associer à l''écriture ou au document.';

                        trigger OnAction();
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            Rec.VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RECORDID));
                        end;
                    }
                    action(IncomingDocAttachFile)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Create Incoming Document from File',
                                    FRA = 'Créer un document entrant à partir d''un fichier';
                        Ellipsis = true;
                        Enabled = NOT HasIncomingDocument;
                        Image = Attach;
                        ToolTipML = ENU = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.',
                                    FRA = 'Créez un enregistrement de document entrant en sélectionnant un fichier à joindre, puis associez l''enregistrement de document entrant à l''écriture ou au document.';

                        trigger OnAction();
                        var
                            IncomingDocumentAttachment: Record "Incoming Document Attachment";
                        begin
                            IncomingDocumentAttachment.NewAttachmentFromSalesDocument(Rec);
                        end;
                    }
                    action(RemoveIncomingDoc)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Remove Incoming Document',
                                    FRA = 'Supprimer le document entrant';
                        Enabled = HasIncomingDocument;
                        Image = RemoveLine;
                        ToolTipML = ENU = 'Remove incoming document records and file attachments.',
                                    FRA = 'Supprimez des fichiers joints et des enregistrements de document entrant.';

                        trigger OnAction();
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            IF IncomingDocument.GET(Rec."Incoming Document Entry No.") THEN
                                IncomingDocument.RemoveLinkToRelatedRecord;
                            Rec."Incoming Document Entry No." := 0;
                            Rec.MODIFY(TRUE);
                        end;
                    }
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                // action("Returned Items")
                // {
                //     CaptionML = ENU = 'Returned Items',
                //                 FRA = 'Articles Retournés';
                //     Image = ReturnShipment;
                //     ShortCutKey = 'Ctrl+Alt+R';

                //     trigger OnAction();
                //     var
                //         ReturnRegistrationMgt: Codeunit "2014069";
                //     begin
                //         //<< DITW18.00.07 AKH 20/05/2016 DIT-770 #1067-DITW110.00.10 MSF 07/07/2017 NRQ#16224
                //         TESTFIELD("Route Planning No.");
                //         ReturnRegistrationMgt.LoadReturnedItemsPage("Route Planning No.", "No.", 36, 1);
                //         //>> DITW18.00.07 AKH DIT-770 #1067
                //     end;
                // }
                // action("Suggest Return Items")
                // {
                //     Caption = 'Suggest Return Items';
                //     Description = 'NRQ#16224';
                //     Image = SuggestLines;

                //     trigger OnAction();
                //     var
                //         SuggestReturnItems: Report "2014073";
                //         SalesHeader: Record "36";
                //     begin
                //         //<<DITW110.00.10 MSF 07/07/2017 NRQ#16224
                //         SalesHeader.SETRANGE("Document Type", "Document Type");
                //         SalesHeader.SETRANGE("No.", "No.");
                //         //<<DITW110.00.10 MSF 14/07/2017 NRQ#16224
                //         SalesHeader.SETRANGE("Suggested Return Item", FALSE);
                //         //>>DITW110.00.10 MSF 14/07/2017 NRQ#16224
                //         SuggestReturnItems.SETTABLEVIEW(SalesHeader);
                //         SuggestReturnItems.RUN;
                //     end;
                // }
                // action("Register Route Shipment entries")
                // {
                //     CaptionML = ENU = 'Register Route Shipment entries',
                //                 FRA = 'Registre route écritures éxpéditions';
                //     Image = Register;
                //     RunObject = Page 2014088;
                //     RunPageLink = Route Planning No.=FIELD(Route Planning No.),
                //                   Source Type=CONST(36),
                //                   Source Subtype=FIELD(Document Type),
                //                   Source No.=FIELD(No.);
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Customization
            }
            group(Plan)
            {
                CaptionML = ENU = 'Plan',
                            FRA = 'Planifier';
                Image = Planning;
                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                // action(OrderPromising)
                // {
                //     AccessByPermission = TableData 99000880=R;
                //     CaptionML = ENU='Order &Promising',
                //                 FRA='Pro&messe de livraison';
                //     Image = OrderPromising;

                //     trigger OnAction();
                //     var
                //         OrderPromisingLine : Record "99000880" temporary;
                //     begin
                //         OrderPromisingLine.SETRANGE("Source Type","Document Type");
                //         OrderPromisingLine.SETRANGE("Source ID","No.");
                //         PAGE.RUNMODAL(PAGE::"Order Promising Lines",OrderPromisingLine);
                //     end;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Customization
                action("Demand Overview")
                {
                    CaptionML = ENU = 'Demand Overview',
                                FRA = 'Aperçu demande';
                    Image = Forecast;
                    trigger OnAction();
                    var
                        DemandOverview: Page "Demand Overview";
                        DemandType: Enum "Demand Order Source Type"; //BC Version 28.0 Compatibility
                    begin
                        DemandType := DemandType::"Sales Demand"; //BC Version 28.0 Compatibility
                        DemandOverview.SetCalculationParameter(TRUE);
                        // DemandOverview.Initialize(0D, 1, Rec."No.", '', '');
                        DemandOverview.SetParameters(0D, DemandType, Rec."No.", '', ''); //BC Version 28.0 Compatibility
                        DemandOverview.RUNMODAL();
                    end;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                // action("Pla&nning")
                // {
                //     CaptionML = ENU = 'Pla&nning',
                //                 FRA = 'Pla&nification';
                //     Image = Planning;

                //     trigger OnAction();
                //     var
                //         SalesPlanForm: Page "99000883";
                //     begin
                //         SalesPlanForm.SetSalesOrder("No.");
                //         SalesPlanForm.RUNMODAL;
                //     end;
                // }
                // action("Cre&ate/Modify Packing List")
                // {
                //     CaptionML = ENU = 'Cre&ate/Modify Packing List',
                //                 FRA = '&Créer/ Modifier liste d''emballage';
                //     Image = CreatePutawayPick;

                //     trigger OnAction();
                //     var
                //         SalesLineRecL: Record "37";
                //         PickingListLineRecL: Record "2014413";
                //     begin
                //         // <<HLW15.00.01.01 BGI 09/05/2008
                //         PickingListLineRecL.SETRANGE("Table ID", DATABASE::"Sales Header");
                //         PickingListLineRecL.SETRANGE("Document Type", "Document Type");
                //         PickingListLineRecL.SETRANGE("Document No.", "No.");
                //         IF NOT PickingListLineRecL.FINDFIRST THEN BEGIN
                //             SalesLineRecL.SETRANGE("Document Type", "Document Type");
                //             SalesLineRecL.SETRANGE("Document No.", "No.");
                //             SalesLineRecL.SETFILTER(Type, STRSUBSTNO('%1|%2', SalesLineRecL.Type::" ", SalesLineRecL.Type::Item));
                //             IF SalesLineRecL.FINDSET THEN BEGIN
                //                 REPEAT
                //                     PickingListLineRecL."Table ID" := DATABASE::"Sales Header";
                //                     PickingListLineRecL."Document Type" := SalesLineRecL."Document Type";
                //                     PickingListLineRecL."Document No." := SalesLineRecL."Document No.";
                //                     PickingListLineRecL."Line No." := SalesLineRecL."Line No.";
                //                     PickingListLineRecL.VALIDATE(Type, SalesLineRecL.Type);
                //                     PickingListLineRecL.VALIDATE("No.", SalesLineRecL."No.");
                //                     PickingListLineRecL.VALIDATE("Variant Code", SalesLineRecL."Variant Code");
                //                     PickingListLineRecL.VALIDATE("Unit of Measure Code", SalesLineRecL."Unit of Measure Code");
                //                     PickingListLineRecL.VALIDATE("Location Code", SalesLineRecL."Location Code");
                //                     PickingListLineRecL.VALIDATE("Bin Code", SalesLineRecL."Bin Code");
                //                     PickingListLineRecL.VALIDATE(Quantity, SalesLineRecL.Quantity);
                //                     PickingListLineRecL.INSERT;
                //                 UNTIL SalesLineRecL.NEXT = 0;
                //             END;
                //         END;
                //         PAGE.RUN(PAGE::"Packing List Lines", PickingListLineRecL);
                //         // >>HLW15.00.01.01 BGI 09/05/2008
                //     end;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Customization
            }
            group("Request Approval")
            {
                CaptionML = ENU = 'Request Approval',
                            FRA = 'Approbation demande achat';
                Image = SendApprovalRequest;
                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                // action("Cre&ate/Modify Return Order")
                // {
                //     Caption = 'Cre&ate/Modify Return Order';
                //     Description = 'NRQ#16224';
                //     Image = CreateDocument;
                //     ShortCutKey = 'Shift+F3';

                //     trigger OnAction();
                //     begin
                //         // <<DITW15.00.00.01 DDR 27/02/2008
                //         CODEUNIT.RUN(CODEUNIT::"Sales Ord. to Ret.Rcpt. (Y/N)", Rec);

                //         IF NOT FIND('=><') THEN
                //             INIT;
                //         // >>DITW15.00.00.01 DDR
                //     end;
                // }
                // separator()
                // {
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Customization
                group(Approval2)
                {
                    CaptionML = ENU = 'Approval',
                                FRA = 'Approbation';
                    // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                    //BC UPGRADE KUMARR78 ++ 05-05-2026
                    action(SendApprovalRequest)
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Send A&pproval Request',
                                    FRA = 'Envoyer demande d''a&pprobation';
                        Enabled = NOT OpenApprovalEntriesExist;
                        Image = SendApprovalRequest;
                        Promoted = true;
                        PromotedCategory = Category9;
                        PromotedOnly = true;
                        ToolTipML = ENU = 'Send an approval request.',
                                    FRA = 'Envoyez une demande d''approbation.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit 1535;
                        begin
                            //<<DITW110.00.11 MSF 28/12/2017 NRQ#9570
                            //VALIDATE("To Check Credit Limit Amount",ApprovalsMgmt.CreateToCheckCreditlimitAmount("To Check Credit Limit Amount","To Check Credit Limit Amount",Rec));
                            CurrPage.SAVERECORD;
                            //>>DITW110.00.11 MSF 28/12/2017 NRQ#9570
                            IF ApprovalsMgmt.CheckSalesApprovalPossible(Rec) THEN
                                ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                        end;
                    }
                    //BC UPGRADE KUMARR78 ++ 05-05-2026

                    // BC Upgrade BHARDA11 << ----Drink-IT Customization
                    action(CancelApprovalRequest)
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Cancel Approval Re&quest',
                                    FRA = 'Annuler demande d''appro&bation';
                        Enabled = CanCancelApprovalForRecord;
                        Image = CancelApprovalRequest;
                        Promoted = true;
                        PromotedCategory = Category9;
                        PromotedOnly = true;
                        ToolTipML = ENU = 'Cancel the approval request.',
                                    FRA = 'Annulez la demande d''approbation.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit 1535;
                        begin
                            ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                        end;
                    }
                }
            }
            group(Warehouse1)
            {
                CaptionML = ENU = 'Warehouse',
                            FRA = 'Entrepôt';
                Image = Warehouse;
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData "Posted Invt. Pick Header" = R;
                    CaptionML = ENU = 'Create Inventor&y Put-away/Pick',
                                FRA = 'Créer prélèv./rangement stoc&k';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    begin
                        Rec.CreateInvtPutAwayPick;

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT;
                    end;
                }
                action("Create &Whse. Shipment")
                {
                    AccessByPermission = TableData "Warehouse Shipment Header" = R;
                    CaptionML = ENU = 'Create &Whse. Shipment',
                                FRA = 'Créer &expédition entrepôt';
                    Image = NewShipment;
                    ApplicationArea = all;
                    //BC UPGRADE KUMARR78 ++ 06-05-2026>>
                    Promoted = true;
                    // PromotedCategory = Process;
                    PromotedIsBig = true;
                    //BC UPGRADE KUMARR78 ++ 06-05-2026 <<

                    trigger OnAction();
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin

                        //>HEI.04>>
                        HeinekenGlobal.CheckPCVNBalance(Rec);
                        //>HEI.04>>
                        // <<DITW15.00.00.34 DDR 16/06/2009
                        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                        // SalesSetup.GET();
                        // IF SalesSetup."Auto.Release Document on Whse." THEN BEGIN
                        //     // <<DITW15.00.00.39 DDR 27/07/2011 #1407
                        //     ReleaseSalesDoc.DocStatusRelease(xRec, Rec);
                        //     // >>DITW15.00.00.39 DDR #1407
                        //     IF (xRec.Status <> Status) AND (Status = Status::Released) THEN
                        //         MESSAGE(Text2014410, "Document Type", "No.");
                        // END;
                        // BC Upgrade BHARDA11 << ----Drink-IT Customization
                        // >>DITW15.00.00.34 DDR
                        Rec.PerformManualRelease();//BC UPGRADE KUMARR78 ++ 06-05-2026
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT;
                    end;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                // action("Change Shipping Status")
                // {
                //     CaptionML = ENU = 'Change Shipping Status',
                //                 FRA = 'Modifier satut expédition';
                //     Image = ReleaseDoc;
                //     ShortCutKey = 'Shift+Ctrl+F9';

                //     trigger OnAction();
                //     begin
                //         //<<DITW17.00.02 SR 10/16/2013 DIT-770 #155 - DITW18.00.07 DDR 25/02/2016 DIT-770 #1488
                //         // ChangeShipmentStatus(); // BC Upgrade BHARDA11 ----Drink-IT Customization
                //         //>>DITW17.00.02 SR 10/16/2013 DIT-770 #155 - DITW18.00.07 DDR DIT-770 #1488
                //     end;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Customization
            }
            group(EMCS)
            {
                CaptionML = ENU = 'EMCS',
                            FRA = 'EMCS';
                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                // action("Send e-AAD Request")
                // {
                //     CaptionML = ENU = 'Send e-AAD Request',
                //                 FRA = 'Envoyer requête e-DAA';

                //     trigger OnAction();
                //     var
                //         EMCSExport: Codeunit "2014262";
                //     begin
                //         //<<DITW17.00.02 DDR 28/08/2013 DIT-770 #178 - 29/08/2013 DIT-770 #179
                //         EMCSExport.CreateOutboxSalesOrder(Rec);
                //         //>>DITW17.00.02 DDR 28/08/2013 DIT-770 #178 - 29/08/2013 DIT-770 #179
                //     end;
                // }
                // action("Send e-Cancelling Request")
                // {
                //     CaptionML = ENU = 'Send e-Cancelling Request',
                //                 FRA = 'Envoyer e-Annulation requête';

                //     trigger OnAction();
                //     var
                //         EMCSExport: Codeunit "2014267";
                //     begin
                //         // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                //         IF EMCSExport.CheckSalesOrderUndo(Rec) THEN
                //             EMCSExport.CreateOutboxSalesOrder(Rec);
                //         // >>DITW16.00.00.43 DDR DIT-715 #720
                //     end;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Customization
            }
            group("P&osting")
            {
                CaptionML = ENU = 'P&osting',
                            FRA = '&Validation';
                Image = Post;
                action(Posts)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'P&ost',
                                FRA = '&Valider';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'F9';
                    ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.',
                                FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';

                    trigger OnAction();
                    begin
                        // <<DITW15.00.00.25 DDR 20/10/2008
                        // CurrPage.UPDATE; // BC Upgrade BHARDA11  ----Drink-IT Customization
                        // >>DITW15.00.00.25 DDR
                        Rec.PostOrderAndReturnOrderLinked(Rec); //HEI.06
                        Post(CODEUNIT::"Sales-Post (Yes/No)", NavigateAfterPost::"Posted Document");
                        Rec.InsertFAGLJnlLinesForRPMDamageLoss(Rec); //HEI.04
                    end;
                }
                action(PostAndPrint)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Post and &Print',
                                FRA = 'Valider et i&mprimer';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction();
                    begin
                        //HEI.08>>
                        CurrPage.UPDATE;

                        Rec.PostOrderAndReturnOrderLinked(Rec);
                        Post(CODEUNIT::"Sales-Post + Print", NavigateAfterPost::"Posted Document");
                        Rec.InsertFAGLJnlLinesForRPMDamageLoss(Rec);
                        //HEI.08<<
                    end;
                }
                action(PostAndNew)
                {
                    CaptionML = ENU = 'Post and New',
                                FRA = 'Valider et créer';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction();
                    begin
                        Rec.PostOrderAndReturnOrderLinked(Rec); //HEI.06
                        Post(CODEUNIT::"Sales-Post (Yes/No)", NavigateAfterPost::"New Document");
                    end;
                }
                action(PostAndSend)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Post and Send',
                                FRA = 'Valider et envoyer';
                    Ellipsis = true;
                    Image = PostMail;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    ToolTipML = ENU = 'Finalize and prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.',
                                FRA = 'Finalisez et préparez-vous à envoyer le document en fonction du profil d''envoi du client, par exemple en pièce jointe d''un e-mail. La fenêtre Envoyer le document à s''ouvre en premier pour que vous puissiez confirmer ou sélectionner un profil d''envoi.';

                    trigger OnAction();
                    begin
                        Rec.PostOrderAndReturnOrderLinked(Rec); //HEI.06
                        Post(CODEUNIT::"Sales-Post and Send", NavigateAfterPost::Nowhere);
                    end;
                }
                action("Test Report")
                {
                    CaptionML = ENU = 'Test Report',
                                FRA = 'Impression test';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.',
                                FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';

                    trigger OnAction();
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Remove From Job Queue',
                                FRA = 'Supprimer de la file d''attente des travaux';
                    Image = RemoveLine;
                    ToolTipML = ENU = 'Remove the scheduled processing of this record from the job queue.',
                                FRA = 'Supprimez le traitement planifié de cet enregistrement à partir de la file d''attente des travaux.';
                    Visible = JobQueueVisible;

                    trigger OnAction();
                    begin
                        Rec.CancelBackgroundPosting;
                    end;
                }
                action(PreviewPosting)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Preview Posting',
                                FRA = 'Aperçu compta.';
                    Image = ViewPostedOrder;
                    ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.',
                                FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';

                    trigger OnAction();
                    begin
                        ShowPreview;
                    end;
                }
                group("Prepa&yment")
                {
                    CaptionML = ENU = 'Prepa&yment',
                                FRA = 'Acom&pte';
                    Image = Prepayment;
                    action("Prepayment &Test Report")
                    {
                        CaptionML = ENU = 'Prepayment &Test Report',
                                    FRA = 'Impression &test acompte';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;

                        trigger OnAction();
                        begin
                            ReportPrint.PrintSalesHeaderPrepmt(Rec);
                        end;
                    }
                    action(PostPrepaymentInvoice)
                    {
                        CaptionML = ENU = 'Post Prepayment &Invoice',
                                    FRA = 'Valider &facture acompte';
                        Ellipsis = true;
                        Image = PrepaymentPost;

                        trigger OnAction();
                        var
                            SalesPostYNPrepmt: Codeunit 443;
                        begin
                            // <<DITW15.00.00.25 DDR 20/10/2008
                            // CurrPage.UPDATE; // BC Upgrade BHARDA11 ----Drink-IT Customization
                            // >>DITW15.00.00.25 DDR
                            IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                                SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        CaptionML = ENU = 'Post and Print Prepmt. Invoic&e',
                                    FRA = 'Valider et imprimer factur&e acompte';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;

                        trigger OnAction();
                        var
                            SalesPostYNPrepmt: Codeunit 443;
                        begin
                            // <<DITW15.00.00.25 DDR 20/10/2008
                            // CurrPage.UPDATE; // BC Upgrade BHARDA11 ----Drink-IT Customization
                            // >>DITW15.00.00.25 DDR
                            IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                                SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, TRUE);
                        end;
                    }
                    action(PostPrepaymentCreditMemo)
                    {
                        CaptionML = ENU = 'Post Prepayment &Credit Memo',
                                    FRA = 'Valider &avoir acompte';
                        Ellipsis = true;
                        Image = PrepaymentPost;

                        trigger OnAction();
                        var
                            SalesPostYNPrepmt: Codeunit 443;
                        begin
                            // <<DITW15.00.00.25 DDR 20/10/2008
                            // CurrPage.UPDATE; // BC Upgrade BHARDA11----Drink-IT Customization
                            // >>DITW15.00.00.25 DDR
                            IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                                SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        CaptionML = ENU = 'Post and Print Prepmt. Cr. Mem&o',
                                    FRA = 'Valider et imprimer av&oir acompte';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;

                        trigger OnAction();
                        var
                            SalesPostYNPrepmt: Codeunit 443;
                        begin
                            // <<DITW15.00.00.25 DDR 20/10/2008
                            // CurrPage.UPDATE; // BC Upgrade BHARDA11----Drink-IT Customization
                            // >>DITW15.00.00.25 DDR
                            IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                                SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, TRUE);
                        end;
                    }
                }
            }
            group(Print)
            {
                CaptionML = ENU = 'Print',
                            FRA = 'Imprimer';
                Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
                Image = Print;
                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                // action("Order Confirmation (Packing)")
                // {
                //     CaptionML = ENU = 'Order Confirmation (Packing)',
                //                 FRA = 'Confirmation de commande (Emballage)';
                //     Image = Print;

                //     trigger OnAction();
                //     begin
                //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                //         CurrPage.SalesLines.PAGE.SetDisableRefreshLines(TRUE);
                //         // >>DITW16.00.00.40 DDR DIT-715 #197
                //         // <<DITW15.00.00.28-HLW15.00.01.01 DDR 28/11/2008
                //         DocPrint.PrintSalesHeaderPacking(Rec);
                //         // >>DITW15.00.00.28-HLW15.00.01.01 DDR
                //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                //         CurrPage.SalesLines.PAGE.SetDisableRefreshLines(FALSE);
                //         // >>DITW16.00.00.40 DDR DIT-715 #197
                //     end;
                // }
                // action("Work Order")
                // {
                //     CaptionML = ENU = 'Work Order',
                //                 FRA = 'Ordre de fabrication';
                //     Ellipsis = true;
                //     Image = Print;

                //     trigger OnAction();
                //     begin
                //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                //         CurrPage.SalesLines.PAGE.SetDisableRefreshLines(TRUE);
                //         // >>DITW16.00.00.40 DDR DIT-715 #197
                //         DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                //         CurrPage.SalesLines.PAGE.SetDisableRefreshLines(FALSE);
                //         // >>DITW16.00.00.40 DDR DIT-715 #197
                //     end;
                // }
                // action("Pick Instruction")
                // {
                //     CaptionML = ENU = 'Pick Instruction',
                //                 FRA = 'Instruction prélèvement';
                //     Image = Print;

                //     trigger OnAction();
                //     var
                //         SalesHeader: Record "36";
                //     begin
                //         //<< DITW17.10.03 VSC 07/05/2014 DIT-770 #681: Filter printing the Picking instruction.
                //         //DocPrint.PrintSalesOrder(Rec,Usage::"Pick Instruction");
                //         // <<DITW18.00.07 DDR 11/04/2016 DIT-770 #1488
                //         SalesHeader := Rec;
                //         SalesHeader.SETRECFILTER;
                //         SalesHeader.SETRANGE("Shipment Date", "Shipment Date");
                //         // >>DITW18.00.07 DDR DIT-770 #1488
                //         DocPrint.PrintSalesOrder(SalesHeader, Usage::"Pick Instruction");
                //         //>> DITW17.10.03 VSC 07/05/2014 DIT-770 #681
                //     end;
                // }
                // action("Order Shipment")
                // {
                //     CaptionML = ENU = 'Order Shipment',
                //                 FRA = 'Expéditon';
                //     Image = Print;

                //     trigger OnAction();
                //     var
                //         SalesHeader: Record "36";
                //     begin
                //         //<< DITW17.10.03 VSC 07/05/2014 DIT-770 #681: Filter printing the Order Shipmend.
                //         // <<DITW18.00.07 DDR 11/04/2016 DIT-770 #1488
                //         SalesHeader := Rec;
                //         SalesHeader.SETRECFILTER;
                //         SalesHeader.SETRANGE("Shipment Date", "Shipment Date");
                //         // >>DITW18.00.07 DDR DIT-770 #1488
                //         DocPrint.PrintSalesOrder(SalesHeader, Usage::"Order Shipment");//DITW17.00.02 SR 10/16/2013 DIT-770 #155
                //         //>> DITW17.10.03 VSC 07/05/2014 DIT-770 #681
                //     end;
                // }
                // action("Combined Picking")
                // {
                //     CaptionML = ENU = 'Combined Picking',
                //                 FRA = 'Prélèvement groupée';
                //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
                //     Image = Print;

                //     trigger OnAction();
                //     var
                //         SalesHeader: Record "36";
                //     begin
                //         //<< DITW17.10.03 VSC 07/05/2014 DIT-770 #681: Filter printing the Combined Picking.
                //         // <<DITW18.00.07 DDR 11/04/2016 DIT-770 #1488
                //         SalesHeader := Rec;
                //         SalesHeader.SETRECFILTER;
                //         SalesHeader.SETRANGE("Shipment Date", "Shipment Date");
                //         // >>DITW18.00.07 DDR DIT-770 #1488
                //         DocPrint.PrintSalesOrder(SalesHeader, Usage::"Combined Picking");//DITW17.00.02 SR 10/16/2013 DIT-770 #155
                //         //>> DITW17.10.03 VSC 07/05/2014 DIT-770 #681
                //     end;
                // }
                // action("Load List")
                // {
                //     CaptionML = ENU = 'Load List',
                //                 FRA = 'Liste de chargements';
                //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
                //     Image = Print;

                //     trigger OnAction();
                //     var
                //         SalesHeader: Record "36";
                //     begin
                //         //<<DITW17.10.05 MSF 16/09/2014 DIT-770 #925
                //         //DocPrint.PrintSalesOrder(Rec,Usage::"Combined Shipment");//DITW17.00.02 SR 10/16/2013 DIT-770 #155
                //         // <<DITW18.00.07 DDR 11/04/2016 DIT-770 #1488
                //         SalesHeader := Rec;
                //         SalesHeader.SETRECFILTER;
                //         SalesHeader.SETRANGE("Shipment Date", "Shipment Date");
                //         SalesHeader.SETFILTER(Route, Route);
                //         // >>DITW18.00.07 DDR DIT-770 #1488
                //         //<< DITW19.00.08 VSC 05/12/2016 BL#10330 (DIT-770 #2122)
                //         DocPrint.PrintSalesOrder(SalesHeader, Usage::"Load List");
                //         //>> DITW19.00.08 VSC BL#10330 (DIT-770 #2122)
                //         //>>DITW17.10.05 MSF 16/09/2014 DIT-770 #925
                //     end;
                // }
                // action("Return Control")
                // {
                //     CaptionML = ENU = 'Return Control',
                //                 FRA = 'Contrôle retours';
                //     Image = Print;

                //     trigger OnAction();
                //     var
                //         SalesHeader: Record "36";
                //     begin
                //         //<<DITW17.10.03 MSF 23/04/2014 DIT-770 #542 - DITW18.00.07 DDR 11/04/2016 DIT-770 #1488
                //         SalesHeader := Rec;
                //         SalesHeader.SETRECFILTER;
                //         SalesHeader.SETRANGE("Shipment Date", "Shipment Date");
                //         DocPrint.PrintSalesOrder(SalesHeader, Usage::"Return Control");
                //         //>>DITW17.10.03 MSF 23/04/2014 DIT-770 #542 - DITW18.00.07 DDR DIT-770 #1488
                //     end;
                // }
                // separator()
                // {
                // }
                // action("Packing List")
                // {
                //     CaptionML = ENU = 'Packing List',
                //                 FRA = 'Liste emballage';
                //     Image = Print;

                //     trigger OnAction();
                //     var
                //         SalesHeaderRecL: Record "36";
                //     begin
                //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                //         CurrPage.SalesLines.PAGE.SetDisableRefreshLines(TRUE);
                //         // >>DITW16.00.00.40 DDR DIT-715 #197
                //         // <<HLW15.00.01.01 BGI 09/05/2008
                //         SalesHeaderRecL.SETRANGE("Document Type", "Document Type");
                //         SalesHeaderRecL.SETRANGE("No.", "No.");
                //         REPORT.RUN(REPORT::"Packing List", TRUE, FALSE, SalesHeaderRecL);
                //         // >>HLW15.00.01.01 BGI 09/05/2008
                //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                //         CurrPage.SalesLines.PAGE.SetDisableRefreshLines(FALSE);
                //         // >>DITW16.00.00.40 DDR DIT-715 #197
                //     end;
                // }
                // action("Pro-Forma")
                // {
                //     CaptionML = ENU = 'Pro-Forma',
                //                 FRA = 'Pro-forma';
                //     Description = 'FINXL7.00.001';
                //     Image = Print;

                //     trigger OnAction();
                //     begin
                //         //<<FINXL7.00.001 RBE 20/03/2013
                //         DocPrint.PrintSalesOrder(Rec, Usage::"Pro-forma");
                //         //>>FINXL7.00.001 RBE 20/03/2013
                //     end;
                // }
                // action("Print and Mail Pro-Forma")
                // {
                //     CaptionML = ENU = 'Print and Mail Pro-Forma',
                //                 FRA = 'Imprimer et envoyer par mail le pro-forma';
                //     Description = 'FINXL7.00.001';
                //     Image = Print;

                //     trigger OnAction();
                //     begin
                //         //<<FINXL8.00.001 RBE 01/12/2014
                //         DocPrint.fctEMailSalesOrder(Rec, Usage::"Pro-forma");
                //         //>>FINXL8.00.001 RBE 01/12/2014
                //     end;
                // }
                // separator()
                // {
                // }
                // action("Test AAD Document")
                // {
                //     CaptionML = ENU = 'Test AAD Document',
                //                 FRA = 'Tester document AAD';
                //     Ellipsis = true;
                //     Image = Print;

                //     trigger OnAction();
                //     begin
                //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                //         CurrPage.SalesLines.PAGE.SetDisableRefreshLines(TRUE);
                //         // >>DITW16.00.00.40 DDR DIT-715 #197
                //         // <<DITW15.00.00.28 DDR 26/11/2008
                //         DocPrint.PrintSalesHeaderAAD(Rec);
                //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                //         CurrPage.SalesLines.PAGE.SetDisableRefreshLines(FALSE);
                //         // >>DITW16.00.00.40 DDR DIT-715 #197
                //     end;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Customization
                action("RPM Balance Accounting")
                {
                    Caption = 'RPM Balance Accounting';
                    Image = "Report";

                    trigger OnAction();
                    begin
                        //HEI.04>>
                        Customer.SETRANGE("No.", Rec."Sell-to Customer No.");
                        REPORT.RUNMODAL(REPORT::"RPM Balance Accounting CBN", TRUE, TRUE, Customer);
                        //HEI.04<<
                    end;
                }
            }
            group("&Order Confirmation")
            {
                CaptionML = ENU = '&Order Confirmation',
                            FRA = '&Confirmation de commande';
                Image = Email;
                action("Email Confirmation")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Email Confirmation',
                                FRA = 'Envoyer confirmation par e-mail';
                    Ellipsis = true;
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTipML = ENU = 'Send a sales order confirmation by email. The attachment is sent as a .pdf.',
                                FRA = 'Envoyez une confirmation commande vente par e-mail. La pièce jointe est envoyée en .pdf.';

                    trigger OnAction();
                    begin
                        DocPrint.EmailSalesHeader(Rec);
                    end;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                // group(Action96)
                // {
                //     Visible = false;
                //     action("Print Confirmation")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         CaptionML = ENU = 'Print Confirmation',
                //                     FRA = 'Imprimer confirmation';
                //         Ellipsis = true;
                //         Image = Print;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         PromotedOnly = true;
                //         ToolTipML = ENU = 'Print a sales order confirmation.',
                //                     FRA = 'Imprimez une confirmation commande vente.';
                //         Visible = NOT IsOfficeHost;

                //         trigger OnAction();
                //         begin
                //             // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                //             CurrPage.SalesLines.PAGE.SetDisableRefreshLines(TRUE);
                //             // >>DITW16.00.00.40 DDR DIT-715 #197
                //             DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                //             // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                //             CurrPage.SalesLines.PAGE.SetDisableRefreshLines(FALSE);
                //             // >>DITW16.00.00.40 DDR DIT-715 #197
                //         end;
                //     }
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Customization
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        CustCheckCrLimit: Codeunit "Cust-Check Cr. Limit";
    begin
        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
        // // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        // SETFILTER("Resp. Center Table Filter",
        //   UserMgt.GetRespCenterFilter(0, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // SETFILTER("Phys. Location Table Filter",
        //   UserMgt.GetRespPhysLocationFilter(0, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // SETFILTER("Location Table Filter",
        //   UserMgt.GetRespLocationFilter(0, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // // >>DITW18.00.06 DDR DIT-770 #1190
        // //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        // IF "Responsibility Center" <> '' THEN
        //     SETFILTER("Resp. Center Table Filter 2", '%1|%2', '', "Responsibility Center");
        // //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        // // <<DITW15.00.00.39 DDR 27/07/2011 #1407
        // CALCFIELDS("Disc.Promo. Order Calculated");
        // // >>DITW15.00.00.34 DDR
        // //<<06/06/2014 DIT-770 #354
        // //<<DITW17.10.03 MSF 12/05/2014 DIT-770 #354
        // CurrPage.ItemHistory.PAGE.GetCustomer("Sell-to Customer No.");
        // //>>DITW17.10.03 MSF 12/05/2014 DIT-770 #354
        // // <<DITW110.00.10 YHE 20/07/2017 NRQ#16068
        // CurrPage.OrderTotalsOutboundFactbox.PAGE.GetCustomer("Sell-to Customer No.");
        // // >>DITW110.00.10 YHE 20/07/2017 NRQ#16068
        // //>>06/06/2014 DIT-770 #354
        // //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154 - DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        // RefreshInvoicePeriodEditable;
        // //>>DITW17.00.02 TEC1 DIT-770 #154 - DITW18.00.07 DDR DIT-770 #1488
        // // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
        // RouteAsMandatory := SalesSetup."Route Mandatory";
        // // >>DITW18.00.07 DDR DIT-770 #1488
        // BC Upgrade BHARDA11 << ----Drink-IT Customization

        DynamicEditable := CurrPage.EDITABLE;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RECORDID);
        CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RECORDID);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RECORDID);

        UpdatePaymentService;
        IF CallNotificationCheck THEN BEGIN
            CustCheckCrLimit.SalesHeaderCheck(Rec);
            Rec.CheckItemAvailabilityInLines;
            CallNotificationCheck := FALSE;
        END;
    end;

    trigger OnAfterGetRecord();
    var
        SalesLineBlanket: Record "Sales Line";
        // BackorderMgmt: Codeunit "2014082"; // BC Upgrade BHARDA11 >> ----Drink-IT Table(2014082)
        LineStyle: Text;
    begin
        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
        // // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
        // MaximumCubageOnFormat;
        // MaximumWeightOnFormat;
        // // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1

        // // << DITW110.00.10 SFI 20/06/2017 BL#15657
        // SalesLineBlanket.RESET;
        // SalesLineBlanket.SETRANGE("Document Type", SalesLineBlanket."Document Type"::"Blanket Order");
        // SalesLineBlanket.SETRANGE(Type, SalesLineBlanket.Type::Item);
        // SalesLineBlanket.SETFILTER("Outstanding Quantity", '<>0');
        // SalesLineBlanket.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
        // SalesLineBlanket.SETRANGE("Bill-to Customer No.", "Bill-to Customer No.");
        // GetBlanketOrderLinesAvail := FALSE;
        // IF SalesLineBlanket.FIND('-') THEN BEGIN
        //     REPEAT
        //         LineStyle := BackorderMgmt.GetLineStyle(SalesLineBlanket);
        //         IF LineStyle IN ['Attention', 'Favorable'] THEN
        //             GetBlanketOrderLinesAvail := TRUE;
        //     UNTIL (SalesLineBlanket.NEXT = 0) OR GetBlanketOrderLinesAvail;
        // END;
        // // >> DITW110.00.10 SFI BL#15657

        // //<<DITW17.10.03 MSF 03/06/2014 DIT-770 #354
        // CurrPage.ItemHistory.PAGE.GetTotalQuantityfromSalesOrder(Rec);
        // //>>DITW17.10.03 MSF 03/06/2014 DIT-770 #354
        // //<<DITW17.10.03 MSF 02/06/2014 DIT-770
        // CurrPage.ItemHistory.PAGE.GetShortcutUomValue("Document Type", "No.");
        // //>>DITW17.10.03 MSF 02/06/2014 DIT-770
        // // <<DITW110.00.10 YHE 20/07/2017 NRQ#16068
        // CurrPage.OrderTotalsOutboundFactbox.PAGE.GetTotalQuantityfromSalesOrder(Rec);
        // // >>DITW110.00.10 YHE 20/07/2017 NRQ#16068
        // //<<DITW17.10.05 MSF 23/10/2014 DIT-770 #612
        // IF DelayedDisc.NoofDelayedLines(Rec, 3) <> 0 THEN
        //     DelayDiscountAl := TRUE
        // ELSE
        //     DelayDiscountAl := FALSE;
        // IF DelayedDisc.NoofDelayedLines(Rec, 4) <> 0 THEN
        //     DelayPromotionAl := TRUE
        // ELSE
        //     DelayPromotionAl := FALSE;
        // //>>DITW17.10.05 MSF 23/10/2014 DIT-770 #612
        // //<< DITW18.00.07 AKH 07/04/2016 DIT-770 #1042
        // SetSalesCommentLinkVisible();
        // //>> DITW18.00.07 AKH DIT-770 #1042
        // ///DITW110.00.10 MSF 12/07/2017 NRQ#16224

        // SetControlVisibility;
        // UpdateShipToBillToGroupVisibility;
        // //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //BC UPGRADE KUMARR78 ++ 05-05-2026
        // IF "Multiple Order Route" THEN
        //     EditableMultipleRouteOrder := FALSE
        // ELSE
        //     EditableMultipleRouteOrder := TRUE;
        // //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082

        EditableMultipleRouteOrder := TRUE;////soicad //BC UPGRADE KUMARR78 ++ 05-05-2026 
        // BC Upgrade BHARDA11 << ----Drink-IT Customization
    end;

    trigger OnClosePage();
    var
        SalesPost: Codeunit "Sales-Post";
    begin
        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
        // //<< DITW17.10.05 YHE 02/09/2014 DIT-770 #754 - DITW110.00.08 DDR 26/02/2017 NRQ#0
        // IF NOT HasBeenShowDeleteCconfirmation THEN
        //     IF NOT fctGetHasBeenDeleted THEN
        //         // <<DITW19.00.08A DDR 28/02/2017 NRQ#18985
        //         IF ("No." <> '') AND ("Sell-to Customer No." <> '') THEN BEGIN
        //             // >>DITW19.00.08A DDR NRQ#18985
        //             IF ConfirmCloseDeleteEmpty THEN
        //                 SalesPost.DeleteSalesOrder("Document Type", "No.");
        //             // <<DITW19.00.08A DDR 28/02/2017 NRQ#18985
        //         END ELSE
        //             IF ("No." <> '') AND HasBeenPendingOrder THEN
        //                 SalesPost.DeleteSalesOrder("Document Type", "No.");
        // // >>DITW19.00.08A DDR NRQ#18985
        // //>> DITW17.10.05 YHE 02/09/2014 DIT-770 #754 - DITW110.00.08 DDR NRQ#0
        // BC Upgrade BHARDA11 << ----Drink-IT Customization
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        // <<DITW17.10.05 YHE 02/09/2014 DIT-770 #754
        // HasBeenShowDeleteCconfirmation := TRUE; // BC Upgrade BHARDA11 ----Drink-IT Customization
        // >>DITW17.10.05 DDR DIT-770 #754
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnInit();
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
        // // <<DITW15.00.00.25 DDR 09/10/2008
        // "Maximum WeightVisible" := TRUE;
        // "Maximum CubageVisible" := TRUE;
        // //>>DITW15.00.00.25 DDR 09/10/2008
        // //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        // EditableMultipleRouteOrder := TRUE;
        // //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        // BC Upgrade BHARDA11 << ----Drink-IT Customization
        JobQueuesUsed := SalesReceivablesSetup.JobQueueActive;
        SetExtDocNoMandatoryCondition;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        IF DocNoVisible THEN
            Rec.CheckCreditMaxBeforeInsert;

        IF (Rec."Sell-to Customer No." = '') AND (Rec.GETFILTER("Sell-to Customer No.") <> '') THEN
            CurrPage.UPDATE(FALSE);

        // BC Upgrade SHUKLP03 >> Added Field("Document Subtype Code")
        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>
        docsubtypecodesetup.GET();
        Rec.VALIDATE("Document Subtype Code FND", DocSubtypeCode);//CH 
                                                                  //FDD-PTPGAP013 IBM PATHAA02 29.09.2017<<
                                                                  // BC Upgrade SHUKLP03 << Added Field("Document Subtype Code")
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        //<<DITW17.10.05 YHE 02/09/2014 DIT-770 #754
        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
        // IF fctCheckAlertExistingOrderBeforeInsert THEN
        //     CurrPage.CLOSE;
        // BC Upgrade BHARDA11 << ----Drink-IT Customization
        //>>DITW17.10.05 YHE 02/09/2014 DIT-770 #754

        Rec."Responsibility Center" := UserMgt.GetSalesFilter;
        IF (NOT DocNoVisible) AND (Rec."No." = '') THEN
            Rec.SetSellToCustomerFromFilter;

        Rec.SetDefaultPaymentServices;
        UpdateShipToBillToGroupVisibility;

        // BC Upgrade SHUKLP03 >> Added Field("Document Subtype Code")
        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>
        docsubtypecodesetup.GET();
        Rec.VALIDATE("Document Subtype Code FND", DocSubtypeCode);//CH 
        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017<<
        // BC Upgrade SHUKLP03 << Added Field("Document Subtype Code")
    end;

    trigger OnOpenPage();
    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        SalesLine: Record "Sales Line";
        OfficeMgt: Codeunit "Office Management";
    begin
        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
        // // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
        // SalesSetup.GET;
        // // >>DITW18.00.07 DDR DIT-770 #1488
        // // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1190
        // //IF UserMgt.GetSalesFilter <> '' THEN BEGIN
        // IF UserMgt.GetSalesTextFilter <> '' THEN BEGIN
        //     FILTERGROUP(2);
        //     //SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
        //     SETFILTER("Responsibility Center", UserMgt.GetSalesTextFilter);
        //     FILTERGROUP(0);
        // END;
        // // >>DITW18.00.06 DDR DIT-770 #1190
        // BC Upgrade BHARDA11 << ----Drink-IT Customization
        //HEI.09>>
        // BC Upgrade SHUKLP03 >> Added Field("Document Subtype Code")
        IF Rec."Document Subtype Code FND" <> '' THEN
            DocSubtypeEditable := FALSE;
        //HEI.09<<

        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>>>
        DocSubtypeCode := Rec."Document Subtype Code FND";
        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017<<
        // BC Upgrade SHUKLP03 << Added Field("Document Subtype Code")

        Rec.SETRANGE("Date Filter", 0D, WORKDATE - 1);

        SetDocNoVisible;

        //<< DITW18.00.07 AKH 07/04/2016 DIT-770 #1042
        // SetSalesCommentLinkVisible();  // BC Upgrade BHARDA11 ----Drink-IT Customization
        //>> DITW18.00.07 AKH DIT-770 #1042
        ///DITW110.00.10 MSF 14/07/2017 NRQ#16224
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        IsOfficeHost := OfficeMgt.IsAvailable;

        IF Rec."Quote No." <> '' THEN
            ShowQuoteNo := TRUE;

        // BC Upgrade SHUKLP03 >> Added Field("Document Subtype Code")
        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>>>
        DocSubtypeCode := Rec."Document Subtype Code FND";
        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017<<
        // BC Upgrade SHUKLP03 << Added Field("Document Subtype Code")
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        IF NOT DocumentIsPosted THEN
            EXIT(Rec.ConfirmCloseUnposted);
    end;

    var
        ApplicationAreaSetup: Record "Application Area Setup";
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ApprovalsMgmt: Codeunit 1535;
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        UserMgt: Codeunit "User Setup Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction",,,,,,,,,,"Order Picking","Picking List","Shipping List","Order Shipment","Combined Picking","Load List","Shipment Specif.","Return Control",,,,,,,,,,,,,,,,,,,,"Pro-forma";
        NavigateAfterPost: Option "Posted Document","New Document",Nowhere;


        JobQueueVisible: Boolean;
        Text001: TextConst ENU = 'Do you want to change %1 in all related records in the warehouse?', FRA = 'Souhaitez-vous modifier %1 dans tous les enregistrements associés de l''entrepôt ?';
        Text002: TextConst ENU = 'The update has been interrupted to respect the warning.', FRA = 'La mise à jour a été interrompue pour respecter l''alerte.';
        DynamicEditable: Boolean;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        ExternalDocNoMandatory: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        ShowWorkflowStatus: Boolean;
        IsOfficeHost: Boolean;
        CanCancelApprovalForRecord: Boolean;
        JobQueuesUsed: Boolean;
        ShowQuoteNo: Boolean;
        DocumentIsPosted: Boolean;
        OpenPostedSalesOrderQst: TextConst ENU = 'The order has been posted and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?', FRA = 'La commande a été validée et déplacée dans la fenêtre Factures vente enregistrées.\\Souhaitez-vous ouvrir la facture enregistrée ?';
        PaymentServiceVisible: Boolean;
        PaymentServiceEnabled: Boolean;
        CallNotificationCheck: Boolean;
        ShipToOptions: Option "Default (Sell-to Address)","Alternate Shipping Address","Custom Address";
        BillToOptions: Option "Default (Customer)","Another Customer";
        EmptyShipToCodeErr: TextConst ENU = 'The Code field can only be empty if you select Custom Address in the Ship-to field.', FRA = 'Le champ Code ne peut être vide que si vous sélectionnez Adresse personnalisée dans le champ Destinataire.';
        // TelesalesSetup: Record 2013919; // BC Upgrade BHARDA11 ----Drink-IT Table Record()
        SalesSetup: Record "Sales & Receivables Setup";
        UserSetup: Record "User Setup";
        StdCustSalesLine: Record "Standard Sales Line";
        Text2014410: TextConst ENU = '%1 %2 has been automatically released.', FRA = 'Le/la %1 %2 a été automatiquement lancé(e).';
        Text2014411: TextConst ENU = 'Do you want to cancel the approval request for %1 %2?', FRA = 'Souhaitez vous annuler la demande d''approbation du/de la %1 %2?';
        StdCustSalesCode: Record "Standard Customer Sales Code";
        Text2014412: TextConst ENU = 'Do you want to send the approval request for %1 %2?', FRA = 'Souhaitez vous envoyer la demande d''approbation du/de la %1 %2?';
        ReleaseSalesDoc: Codeunit "Release Sales Document";

        SalesHistoryBtnVisible: Boolean;

        BillToCommentPictVisible: Boolean;

        BillToCommentBtnVisible: Boolean;

        SalesHistoryStnVisible: Boolean;

        "Maximum CubageVisible": Boolean;

        "Maximum WeightVisible": Boolean;

        "Maximum WeightEmphasize": Boolean;

        "Maximum CubageEmphasize": Boolean;

        InvoicePeriodEditable: Boolean;
        Text2014413: TextConst ENU = 'Set the Shipment status to Return completed?', FRA = 'Voulez vous modifier le status expédition à retour complet ?';
        // TempItembuff: Record 2035390;// BC Upgrade BHARDA11 ----Drink-IT Table Record(2035390)
        HasBeenShowDeleteCconfirmation: Boolean;
        // DelayedDisc: Codeunit 2013764;// BC Upgrade BHARDA11 ----Drink-IT Codeunit(2013764)
        DelayDiscountAl: Boolean;
        DelayPromotionAl: Boolean;
        // WhseShippingDriver: Record 2014063;// BC Upgrade BHARDA11 ----Drink-IT Table Record(2014063)
        // WhseShippingTruck: Record 2014068;// BC Upgrade BHARDA11 ----Drink-IT Table Record(2014068)
        blncommentOpened: Boolean;
        BlnIsShownComment: Boolean;
        CodOrderNo: Code[20];

        RouteAsMandatory: Boolean;
        Text2014414: TextConst ENU = 'Sales Comments exist for this order.Choose the link to see them', FRA = 'Des lignes commentaire existent pour cette commande. Choisissez le lien pour les afficher';

        SalesCommentLinkVisible: Boolean;
        SalesCommentLine: Record "Sales Comment Line";
        SalesCommentSheet: Page "Sales Comment Sheet";
        HasBeenPendingOrder: Boolean;
        GetBlanketOrderLinesAvail: Boolean;
        EditableMultipleRouteOrder: Boolean;
        DocSubtypeCode: Code[20];
        docsubtypecodesetup: Record "Doc Subtype Code Setup FND";// BC Upgrade SHUKLP03
        HeinekenGlobal: Codeunit "Heineken Global";
        Customer: Record Customer;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        DocSubtypeEditable: Boolean;

    local procedure Post(PostingCodeunitID: Integer; Navigate: Option);
    var
        SalesHeader: Record "Sales Header";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        InstructionMgt: Codeunit "Instruction Mgt.";
    // Codeunit9170: Codeunit 9170;
    begin
        // BC Upgrade BHARDA11 >> ---IsFoundationEnabled is not found in "Application Area Setup" Table
        // IF ApplicationAreaSetup.IsFoundationEnabled THEN
        //     LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
        // BC Upgrade BHARDA11 << ---IsFoundationEnabled is not found in "Application Area Setup" Table


        Rec.SendToPosting(PostingCodeunitID);
        DocumentIsPosted := NOT SalesHeader.GET(Rec."Document Type", Rec."No.");

        IF Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);

        IF PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" THEN
            EXIT;

        CASE Navigate OF
            NavigateAfterPost::"Posted Document":
                IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) THEN
                    ShowPostedConfirmationMessage;
            NavigateAfterPost::"New Document":
                IF DocumentIsPosted THEN BEGIN
                    SalesHeader.INIT;
                    SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.INSERT(TRUE);
                    PAGE.RUN(PAGE::"Sales Order", SalesHeader);
                END;
        END;
    end;

    local procedure ApproveCalcInvDisc();
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SalespersonCodeOnAfterValidate();
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension1CodeOnAfterV();
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension2CodeOnAfterV();
    begin
        CurrPage.UPDATE;
    end;

    local procedure PricesIncludingVATOnAfterValid();
    begin
        CurrPage.UPDATE;
    end;

    local procedure Prepayment37OnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;

    local procedure SetDocNoVisible();
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::Order, Rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition();
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        Customer: Record Customer;
    begin
        //<< DITW18.00.07 AKH 28/03/2016 - 13/05/2016 DIT-770 #1409
        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
        // SalesReceivablesSetup.GET;
        // ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory";
        // IF Customer.GET("Sell-to Customer No.") THEN
        //     // <<DITW18.00.07 AKH 30/03/2016 DIT-770 #1409
        //     ExternalDocNoMandatory := Customer.ShowExtDocMandatory();
        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
        // >>DITW18.00.07 AKH 30/03/2016 DIT-770 #1409
        //>> DITW18.00.07 AKH DIT-770 #1409
    end;

    local procedure ShowPreview();
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure SetControlVisibility();
    var
        ApprovalsMgmt: Codeunit 1535;
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        SetExtDocNoMandatoryCondition;

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;

    local procedure ShowPostedConfirmationMessage();
    var
        OrderSalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        IF NOT OrderSalesHeader.GET(Rec."Document Type", Rec."No.") THEN BEGIN
            SalesInvoiceHeader.SETRANGE("No.", Rec."Last Posting No.");
            IF SalesInvoiceHeader.FINDFIRST THEN
                IF InstructionMgt.ShowConfirm(OpenPostedSalesOrderQst, InstructionMgt.ShowPostedConfirmationMessageCode) THEN
                    PAGE.RUN(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
        END;
    end;

    local procedure UpdatePaymentService();
    var
        PaymentServiceSetup: Record "Payment Service Setup";
    begin
        PaymentServiceVisible := PaymentServiceSetup.IsPaymentServiceVisible;
        PaymentServiceEnabled := PaymentServiceSetup.CanChangePaymentService(Rec);
    end;

    local procedure UpdateShipToBillToGroupVisibility();
    begin
        CASE TRUE OF
            (Rec."Ship-to Code" = '') AND Rec.ShipToAddressEqualsSellToAddress:
                ShipToOptions := ShipToOptions::"Default (Sell-to Address)";
            (Rec."Ship-to Code" = '') AND (NOT Rec.ShipToAddressEqualsSellToAddress):
                ShipToOptions := ShipToOptions::"Custom Address";
            Rec."Ship-to Code" <> '':
                ShipToOptions := ShipToOptions::"Alternate Shipping Address";
        END;

        IF Rec."Bill-to Customer No." = Rec."Sell-to Customer No." THEN
            BillToOptions := BillToOptions::"Default (Customer)"
        ELSE
            BillToOptions := BillToOptions::"Another Customer";
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStatisticsAction(var SalesHeader: Record "Sales Header"; var Handled: Boolean);
    begin
    end;

    procedure CheckNotificationsOnce();
    begin
        CallNotificationCheck := TRUE;
    end;

    // BC Upgrade BHARDA11 >> ----Drink-IT Functions(FormatMaximumControls, ShowUpdateControls, ShowUpdateSalesOrder, StatusOnAfterValidate, StatusOnValidate, MaximumCubageOnFormat, MaximumWeightOnFormat)

    // local procedure FormatMaximumControls(pFieldNo: Integer; pMaxValue: Decimal; pTotalValue: Decimal);
    // var
    //     lblnBold: Boolean;
    //     lcolor: Integer;
    // begin
    //     // <<DIT15.00.00.21 DDR 19/06/2008
    //     lcolor := 0;
    //     lblnBold := FALSE;

    //     IF pMaxValue < pTotalValue THEN
    //         lcolor := 255;

    //     lblnBold := lcolor <> 0;

    //     // <<DITW15.00.00.25 DDR 09/10/2008
    //     "Maximum CubageVisible" := FALSE;
    //     "Maximum WeightVisible" := FALSE;
    //     // >>DITW15.00.00.25 DDR

    //     CASE pFieldNo OF
    //         FIELDNO("Maximum Weight"):
    //             BEGIN
    //                 "Maximum WeightEmphasize" := lblnBold;
    //             END;
    //         FIELDNO("Maximum Cubage"):
    //             BEGIN
    //                 "Maximum CubageEmphasize" := lblnBold;
    //             END;
    //     END;

    //     // <<DITW15.00.00.25 DDR 09/10/2008
    //     "Maximum CubageVisible" := TRUE;
    //     "Maximum WeightVisible" := TRUE;
    //     // >>DITW15.00.00.25 DDR
    // end;

    // local procedure ShowUpdateSalesOrder();
    // var
    //     SalesHeader: Record 36;
    // begin
    //     // <<DITW15.00.00.39 DDR 19/08/2011 #1364
    //     IF "No." = '' THEN
    //         EXIT;
    //     CurrPage.SAVERECORD;
    //     COMMIT;
    //     SalesHeader := Rec;
    //     SalesHeader.SETRECFILTER;
    //     REPORT.RUNMODAL(REPORT::"Batch Update Sales Orders", TRUE, FALSE, SalesHeader);
    //     CurrPage.UPDATE(FALSE);
    // end;

    // local procedure StatusOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.34 DDR 17/06/2009
    //     CurrPage.UPDATE(FALSE);
    // end;

    // local procedure StatusOnValidate();
    // begin
    //     // <<DITW15.00.00.34 DDR 17/06/2009
    //     IF xRec.Status = Status THEN
    //         EXIT;

    //     // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
    //     IF (xRec.Status = Status::Open) OR (Status = Status::Released) THEN
    //         ReleaseSalesDoc.DocStatusRelease(xRec, Rec)
    //     ELSE BEGIN
    //         IF Status = Status::Open THEN
    //             ReleaseSalesDoc.DocStatusOpen(xRec, Rec)
    //         ELSE
    //             // >>DITW15.00.00.39 DDR #1330 #1407
    //             TESTFIELD(Status, xRec.Status);
    //     END;
    // end;

    // local procedure MaximumCubageOnFormat();
    // begin
    //     Rec.CALCFIELDS("Total Cubage");
    //     FormatMaximumControls(FIELDNO("Maximum Cubage"), "Maximum Cubage", "Total Cubage");
    // end;

    // local procedure MaximumWeightOnFormat();
    // begin
    //     CALCFIELDS("Total Weight");
    //     FormatMaximumControls(FIELDNO("Maximum Weight"), "Maximum Weight", "Total Weight");
    // end;
    // BC Upgrade BHARDA11 << ----Drink-IT Functions(FormatMaximumControls, ShowUpdateControls, ShowUpdateSalesOrder, StatusOnAfterValidate, StatusOnValidate, MaximumCubageOnFormat, MaximumWeightOnFormat)
    // BC Upgrade BHARDA11 << ----Drink-IT Function(MakeSalesOrder,SetHasBeenShowDeleteConfirm)
    // local procedure MakeSalesOrder(var ItemHistoryBuf: Record "2035390");
    // var
    //     ToSalesLine: Record "37";
    //     recSalesHeader: Record "36";
    //     ReleaseSales: Codeunit "414";
    //     NextLineNo: Integer;
    //     lcodOldSalesHeader: Code[20];
    // begin
    //     //DITW17.00.02 VSC 10/01/2014 DIT-770 #299: New Function MakeSalesOrder()
    //     SalesSetup.GET;
    //     TelesalesSetup.GET;
    //     CLEAR(UserSetup);
    //     IF USERID <> '' THEN BEGIN
    //         UserSetup.GET(USERID);
    //     END;

    //     StdCustSalesCode.SETRANGE("Customer No.", "Sell-to Customer No.");
    //     StdCustSalesCode.SETRANGE(Default, TRUE);
    //     IF StdCustSalesCode.FINDFIRST THEN BEGIN
    //         StdCustSalesLine.SETRANGE("Standard Sales Code", StdCustSalesCode.Code);
    //         StdCustSalesLine.SETFILTER(Type, '<>%1', StdCustSalesLine.Type::" ");
    //     END;
    //     StdCustSalesCode.SETRANGE(Default, FALSE);
    //     ItemHistoryBuf.RESET;
    //     IF ItemHistoryBuf.ISEMPTY AND
    //       (StdCustSalesCode.ISEMPTY OR StdCustSalesLine.ISEMPTY)
    //     THEN BEGIN
    //         //fixme  IF NOT CONFIRM(Text007,FALSE) THEN
    //         //fixme   ERROR('');
    //     END;

    //     recSalesHeader := Rec;
    //     recSalesHeader.MODIFY(TRUE);
    //     IF SalesSetup."Copy Comments Cust. to Sell-to" THEN
    //         recSalesHeader.CopyCustCommentToSales();

    //     ToSalesLine.RESET;
    //     ToSalesLine.SETRANGE("Document Type", recSalesHeader."Document Type");
    //     ToSalesLine.SETRANGE("Document No.", recSalesHeader."No.");
    //     IF ToSalesLine.FINDLAST THEN
    //         NextLineNo := ToSalesLine."Line No." + 10000
    //     ELSE
    //         NextLineNo := 10000;

    //     ToSalesLine.SetSalesHeader(recSalesHeader);
    //     ToSalesLine.SuspendStatusCheck(TRUE);
    //     ToSalesLine.SetHideValidationDialog(TRUE);
    //     ToSalesLine.SetHasBeenShown();

    //     IF ItemHistoryBuf.FINDSET THEN BEGIN
    //         REPEAT
    //             ToSalesLine.RESET;
    //             ToSalesLine.SETRANGE("Document Type", recSalesHeader."Document Type");
    //             ToSalesLine.SETRANGE("Document No.", recSalesHeader."No.");
    //             ToSalesLine.SETRANGE(Type, ItemHistoryBuf.Type);
    //             ToSalesLine.SETRANGE("No.", ItemHistoryBuf."No.");
    //             IF ToSalesLine.FINDFIRST THEN BEGIN
    //                 ToSalesLine.VALIDATE(Quantity, ItemHistoryBuf."Order Quantity");
    //                 ToSalesLine."Free Item" := ItemHistoryBuf."Free Item";
    //                 ToSalesLine."Free Reason Code" := ItemHistoryBuf."Free Reason Code";
    //                 ToSalesLine."Delayed Sequence No." := ItemHistoryBuf."Delayed Sequence No.";

    //                 IF ToSalesLine.InsertCharges4(0, FALSE) THEN
    //                     ToSalesLine.MODIFY(TRUE);
    //             END ELSE BEGIN
    //                 ToSalesLine.INIT;
    //                 ToSalesLine."Line No." := 0;
    //                 ToSalesLine."Document Type" := recSalesHeader."Document Type";
    //                 ToSalesLine."Document No." := recSalesHeader."No.";
    //                 ToSalesLine.VALIDATE(Type, ItemHistoryBuf.Type);
    //                 ToSalesLine.VALIDATE("No.", ItemHistoryBuf."No.");
    //                 ToSalesLine.Description := ItemHistoryBuf.Description;

    //                 IF ItemHistoryBuf."Location Code" <> '' THEN BEGIN
    //                     ToSalesLine."Physical Location Group Code" := '';
    //                     ToSalesLine.VALIDATE("Location Code", ItemHistoryBuf."Location Code");
    //                 END;
    //                 IF ItemHistoryBuf."Variant Code" <> '' THEN
    //                     ToSalesLine.VALIDATE("Variant Code", ItemHistoryBuf."Variant Code");
    //                 IF ItemHistoryBuf."Order Unit of Measure Code" <> '' THEN
    //                     ToSalesLine.VALIDATE("Unit of Measure Code", ItemHistoryBuf."Order Unit of Measure Code");
    //                 IF ItemHistoryBuf."Order Quantity" <> 0 THEN
    //                     ToSalesLine.VALIDATE(Quantity, ItemHistoryBuf."Order Quantity");
    //                 IF (ItemHistoryBuf."New Shipment Date" <> recSalesHeader."Shipment Date") AND
    //                   (ItemHistoryBuf."New Shipment Date" <> 0D)
    //                 THEN
    //                     ToSalesLine.VALIDATE("Shipment Date", ItemHistoryBuf."New Shipment Date");
    //                 //<< DITW18.00.06 YHE 24/06/2015 DIT-770 #1366
    //                 ToSalesLine.VALIDATE("Free Item", ItemHistoryBuf."Free Item");
    //                 ToSalesLine.VALIDATE("Free Reason Code", ItemHistoryBuf."Free Reason Code");
    //                 //>> DITW18.00.06 YHE 24/06/2015 DIT-770 #1366
    //                 ToSalesLine."Delayed Sequence No." := ItemHistoryBuf."Delayed Sequence No.";

    //                 ToSalesLine."Line No." := NextLineNo;

    //                 IF NOT ToSalesLine.INSERT THEN BEGIN
    //                     ToSalesLine."Line No." += 1;
    //                     ToSalesLine.INSERT;
    //                 END;
    //                 ToSalesLine.ValidateCreateDimNo();

    //                 IF ToSalesLine.InsertCharges4(0, FALSE) THEN BEGIN
    //                     ToSalesLine.MODIFY(TRUE);
    //                     IF ToSalesLine.RoundThousandLineNo() THEN
    //                         NextLineNo := ToSalesLine."Line No."
    //                     ELSE
    //                         NextLineNo := ToSalesLine."Line No." + 10000;
    //                 END ELSE
    //                     NextLineNo := ToSalesLine."Line No." + 10000;
    //             END;
    //         UNTIL ItemHistoryBuf.NEXT = 0;
    //     END ELSE
    //         StdCustSalesCode.AutoInsertSalesLines(recSalesHeader);

    //     IF TelesalesSetup."Auto.Release on Sales Order" THEN BEGIN
    //         COMMIT;
    //         IF ReleaseSales.RUN(recSalesHeader) THEN;
    //     END;
    // end;

    // procedure SetHasBeenShowDeleteConfirm(HasBeen: Boolean);
    // begin
    //     // <<DITW17.10.05 DDR 22/09/2014 DIT-770 #754
    //     HasBeenShowDeleteCconfirmation := HasBeen;
    // end;
    // BC Upgrade BHARDA11 >> ----Drink-IT Function(MakeSalesOrder,SetHasBeenShowDeleteConfirm)
    // BC Upgrade BHARDA11 >> ----Drink-IT Customization
    // local procedure RefreshInvoicePeriodEditable();
    // begin
    //     InvoicePeriodEditable :=
    //       NOT (
    //         ((Rec."Invoice Method" <> Rec."Invoice Method"::"Combine Shipments") AND
    //          (Rec."Invoice Method" <> Rec."Invoice Method"::"Combine Shipments Per Sell-to")));
    // end;
    // BC Upgrade BHARDA11 << ----Drink-IT Customization
    // BC Upgrade BHARAD11 >> ----Drink-IT Functions(FilterSalesComments,ShowSalesComments,OpenSalesComments,SetSalesCommentLinkVisible)
    // local procedure SetSalesCommentLinkVisible();
    // begin
    //     //<< DITW18.00.07 AKH 07/04/2016 DIT-770 #1042
    //     SalesCommentLinkVisible := SalesOrderCommentExists(SalesCommentLine);
    // end;

    // local procedure OpenSalesComments();
    // var
    //     lSalesCommLine: Record "44";
    // begin
    //     //<<DITW18.00.07 KJB 18/02/2016 DIT-770 #1042
    //     IF ("No." = '') OR ("Sell-to Customer No." = '') THEN
    //         EXIT;

    //     FilterSalesComments(lSalesCommLine);

    //     IF NOT lSalesCommLine.ISEMPTY THEN BEGIN
    //         ShowSalesComments;
    //         BlnIsShownComment := TRUE;
    //         CodOrderNo := "No.";
    //     END;
    //     //>>DITW18.00.07 KJB DIT-770 #1042
    // end;

    // local procedure ShowSalesComments();
    // var
    //     lSalesCommLine: Record "44";
    //     lSalesCommLinePage: Page "67";
    // begin
    //     //<<DITW18.00.07 KJB 18/02/2016 DIT-770 #1042
    //     FilterSalesComments(lSalesCommLine);
    //     lSalesCommLinePage.SetDefaultValue(TRUE);
    //     lSalesCommLinePage.SETTABLEVIEW(lSalesCommLine);
    //     lSalesCommLinePage.RUN;
    //     lSalesCommLinePage.ACTIVATE;
    //     //>>DITW18.00.07 KJB DIT-770 #1042
    // end;

    // local procedure FilterSalesComments(var pSalesCommLine: Record "44");
    // begin
    //     //<<DITW18.00.07 KJB 18/02/2016 DIT-770 #1042
    //     pSalesCommLine.RESET;
    //     pSalesCommLine.SETRANGE("Document Type", "Document Type");
    //     pSalesCommLine.SETRANGE("No.", "No.");
    //     pSalesCommLine.SETRANGE("Document Line No.", 0);
    //     pSalesCommLine.SETRANGE("Sales Order", TRUE);
    //     //>>DITW18.00.07 KJB DIT-770 #1042
    // end;
    // BC Upgrade BHARDA11 << ----Drink-IT Functions(FilterSalesComments,ShowSalesComments,OpenSalesComments,SetSalesCommentLinkVisible)

    local procedure SuggestedReturnItemAfterValidate();
    begin
        CurrPage.UPDATE;
    end;
}

