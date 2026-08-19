pageextension 51210 SalesOrderExtCBN extends "Sales Order"
{
    // version NAVW110.0.00.16585,FINXL8.00,DITW110.00.11,HEI.42,NRQ139495-155949
    //     DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
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

    // FINXL7.00.001 RBE 20/03/2013 : Added field "Your Reference" on page
    //                                Added PDF Functionality
    //                                Print Pro-Forma
    //                                Print and Mail Pro-Forma
    // FINXL7.00.001 KLU 25/09/2013 : Added actions for approve/reject (same functionality as approval entries form)
    // FINXL7.00.001 DAT 29/05/2014 #50: Set the property Editable of the field "Your Reference" to TRUE
    // FINXL7.00.001 KLU 27/06/2014 #42 : Added menuitem: "Calculate Recycle Charges"

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
    // DITW111.00.13 MSF 03/09/2018 NRQ#55906 Sales Approval Workflow for Overdue and deposit limit
    //                              Delete Code
    // DITW111.00.13 MSF 06/12/2018 NRQ#94671 Line and header alert for not fully assigned lines - in warehouse shipment and sales order
    //                                        New group Added in Tab General
    // DITW111.00.13 MSF 13/12/2018 NRQ#94671 Added field "Show Item Tracking Alter on SO"
    // DITW111.00.15 MSF 24/09/2019 NRQ#120074 Dimension code missing on sales order line with Sales Item History
    // NRQ155949 NLAB 03/09/2020 Merged NRQ#120074 Dimension code missing on sales order line with Sales Item History
    //                           Fixed Missing "Line Discount %" when validating "Free reason Code"

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
    // HEI.10 RFC-CHG0255777 IBM.LS 18.12.2018
    //   # Code added to call "ValidateCustomerMinValue" function.
    // HEI.11 RFC-CHG0264361 IBM.AB 20.12.2018
    //   # Code added for "Trading End Date FND"
    //   # message is changed for CustTradingEndDate
    // HEI.12 INC2109750 IBM NASTAA02 16.04.2019 # Promotion Group Dimensions
    //   # New function created "UHT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    // HEI.14 defect #3890 IBM GAVANM01 07.06.2019
    //   #add local variable RopdateFreeReasonCodeDimensions" to update the Free Reason Code Dimension for Group Promotions
    // DITW111.00.13 MSF 03/09/2018 NRQ#55906 Sales Approval Workflow for Overdue and deposit limit
    //                              Delete Code
    // DITW111.00.13A MSF 02/05/2019 NRQ#103938 Added visibility for Action Send Approval
    // DITW111.00.13A MSF 09/05/2019 NRQ#109271 Disable DIT Discounts and or Promotions for a sales documents
    //                               Added Field "Disable DIT Disc. Prom."
    // HEI.13 FDD-SR_ute in OnAfterGetRecord() trigger
    //   #Condition EditableMultipleRouteOrder will be based on Route field Multiple Order Route
    // HEI.15 HT453 - CHG2011093 IBM GAVANM01 11.06.2019
    //   # New fields added in Shipping TAB: Bill Of Lading No, Vessel Name, ETD, ETA, Air Way Bill No, Commodity Code, Custom Tariff Code
    // HEI.16 HT453 - CHG2011093 IBM GAVANM01 18.06.2019
    //   # New field added in Shipping TAB: InCo Terms
    // HEI.17 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New Field added: "Suppress POS Interface"
    //   # Code added to enable editing of Field "Supress POS Interface"
    // HEI.18 FDD-HT581 IBM SURYAS01 08.08.2019 # Added new field -"Free Reason Code" in General tab
    // HEI.19 FDD-HT634 IBM GAVANM01 27.08.2019 # New field added in Foreign Trade tab - "Country of Origin"
    // HEI.21 FDD-HB268 IBM SURYAS01 18.09.2019
    //   #Created new Function "MakeFieldEditable"
    //   #Created new global variable FieldEditable
    //   #Called MakeFieldEditable Function in OnopenTrigger and OnAftergetrecord Trigger
    //   #Editable property of field "Disable DIT Disc. Prom." is changed to FieldEditable.
    // HEI.22 CHG2026335 HT653 FDD_La Reunion_EDI_EDI Order IBM GAVANM01 04.10.2019
    //   #new fields added: EDI Order, Time/Date Received , Ealiest delivery Date Time, Latest Delivery Date Time, System Date Time, Pick Date Time
    // HEI.23 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Code added in Release - OnAction
    // HEI.24 FDD-HT657 IBM NASTAA02 15.11.2019 # Ethiopia Intercompany Automation
    //   # New Field added: "Special Order"
    // HEI.25 Defect #4978 IBM NASTAA02 09.12.2019 # Shipment method code in SO duplicated field
    //   # Hiden Field 48 - "Shipment Method Code" with caption 'Code'
    // HEI.26 CHG2026335 HT653 FDD_La Reunion_EDI_EDI Order IBM GAVANM01 08.01.2020
    //   # new tab created: EDI
    //   # the following fields added to the EDI tab: EDI Order, Ealiest delivery Date Time, Latest Delivery Date Time, System Date Time, Pick Date Time
    //   # Time/Date Received removed
    //   # new function 'CheckAvailability'
    //   # new code in Release action
    //   # new code in SendApprovalRequest
    // HEI.27 FDD-HT604 IBM.COSTES02 09.12.2019 # WMS integration Heilite BASE and Reflex
    //   # New field added : 50042 - WMS Export
    // HEI.28 CHG2040870 IBM GAVANM01 22.01.2020 # Control modification apply to fields in Sales Orders
    //   # New global variable: AppliesToEnabled
    //   # code added
    //   # Enabled property changed for fields: "Applies-to Doc. Type"and "Applies-to Doc. No."
    // HEI.29 CHG2046145 IBM.COSTES02 20.02.2020 # Sales Order Status Addition
    //   # Mew field added : 50051 - "Approval Status"
    // HEI.30 CHG2026335 HT653 IBM GAVANM01 27.03.2020 #FDD_La Reunion_EDI_EDI Order
    //   # remove EDI Order field
    // NRQ139495.1 MVN 12/03/2020: Correction according to: DITW113.00.15 NLAB 12/12/2019 NRQ#125738
    // HEI.31 CHG2053242 HB1215 IBM GAVANM01 31.03.2020 Sales Order fixes
    //   # the field Shipment Date appears twice. Remove it from Shipping and Billing tab
    //   # the field Requested Delivery Date moved from Shipping and Billing tab to General Tab
    //   # if document subtype code is empty, then it will be equal to default sales code from setup
    // DITW114.00.15 DDR 26/03/2020 NRQ#119883 Fix multiple item insertion from item history in function MakeSalesOrder()
    // DITW114.00.15 DDR 31/03/2020 NRQ#119883 Fix multiple free item insertions
    // HEI.33 CHG2059200 IBM SAMANR01 04.22.2020
    //   # Add "LoyaltyBalance" fact box
    //   # Add code to fill the Loyalty Balnce Fact box
    // FINXL14.00.15 MSF 13/05/2020 NRQ#117628 Enable /Disable AutoSend To IC
    // HEI.34 CHG2064677 IBM SHANKJ03 02.06.2020
    //   #Added code for selecting burundi layouts
    // HEI.35 CHG2065153 IBM KUMARN15 23.06.2020
    //   # Added field "Source System Identifier"
    // HEI.36 CHG2062340 HB1378 IBM GAVANM01 29.07.2020 #Retrofitting the Brewco – Sellco
    //   # for the action "Auto Send IC Order": delete Visible property, add Enabled property
    // HEI.37 CHG2073467 HB1369 IBM GAVANM01 17.08.2020  Enhancements to the Intercompany automation functionality
    //   # new field added: IC Order No.
    //   # hide action "Send IC Sales Order Cnfmn."
    //   # Properties changed for action Auto. Send IC Order: Promoted=yes, PromotedCategory=Process, PromotedIsBig=yes
    // HEI.38 FDD-HB899 - CHG2093015 IBM NASTAA02  19.01.2021 # LSR - Sales And Payments
    //   # Code added on "Create &Whse. Shipment" and "Cre&ate/Modify Return Order" Actions
    // HEI.39 FDD-HB1234 - CHG2053453 IBM NASTAA02 10.03.2021 # B2B Order Status
    //   # New Field added: "Ready for Pick-up"
    // HEI.40 CHG2084621 HB1742 IBM GAVANM01 23.03.2021 - Sales Quotes functionality
    //   # field Quote No always visible
    // HEI.41 HB2487 CHG2123592 IBM MAJUMS03 # Cash Application where 92% of Customer pay in advance
    //   # Code added on Page Actions
    // HEI.42 CHG2165967 DEBUSD01 26.10.2022 HL block tax and VAT modification in sales order
    //   # change editable field "Customer DTax Group Code", "VAT Bus. Posting Group"
    // HEI.43 CC CHG2201101 IBM BHANDS01 23.05.2023 Telesales process Improvement
    //   # Code Optimization
    // HEI.44 CC CHG2201101 IBM BHANDS01 25.05.2023 Telesales process Improvement Phase 2
    //   # Adding Progress Window to Sales Order creation process
    // HEI.45 CC CHG2201101 IBM BHANDS01 09.06.2023 Telesales process Improvement Phase 2
    //   # Code Optimization

    // BC Upgrade SHUKLP03 >> 
    //     HEI.23 => Action(Release) code is not added because code was related to French Localization.
    // HEI.34 => code is not added because code is written inside DIT action(Order Confirmation (Packing)) and action(Pro-Forma). 
    // HEI.43,HEI.44,HEI.53 and HEI.45 => code is not added because code is written inside DIT Procedure MakeSalesOrder().
    // HEI.09 => Trigger OnOpenPage Code is blocked because of DIT field "Document Subtype Code".
    // Trigger OnNewRecord and OnInsertRecord code is not added because of DIT object Document Subtype Code Setup.
    // HEI.14,  => Trigger OnAfterGetRecord Code is blocked because of DIT object Route.
    // HEI.33 => trigger OnAfterGetCurrRecord code is blocked because dependency on DIT code.
    // HEI.36,HEI.37 => code is not added because DIT action("Auto Send IC Order").
    // The procedure UpdateDimSet() has been rename with UpdateDimSetP() because a procedure with the same name and code has been created on the "Sales Header" table.

    // Moved in the interface >>
    // HEI.17 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New Field added: "Suppress POS Interface"
    //   # Code added to enable editing of Field "Supress POS Interface"
    // HEI.12 INC2109750 IBM NASTAA02 16.04.2019 # Promotion Group Dimensions
    //   # New function created "UHT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    // HEI.27 FDD-HT604 IBM.COSTES02 09.12.2019 # WMS integration Heilite BASE and Reflex
    //   # New field added : 50042 - WMS Export
    // << Moved in the interface.

    // DIT Fields and actions were not added.

    // BC Upgrade SHUKLP03 >> Added document subtype field and it's code of OnInsertRecord, OnNewRecord and OnOpenPage.
    //BC UPGRADE KUMARR78 FDD-MTC-008 >>
    //1. Adding Action Button for Report Pro forma(51091).
    //BC UPGRADE KUMARR78 FDD-MTC-008 <<

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the sales document. The field can be filled automatically or manually and can be set up to be invisible.', FRA = 'Spécifie le numéro du document vente. Le champ peut être rempli automatiquement ou manuellement et être configuré pour être invisible.';
        }
        modify("Sell-to Customer Name")
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
            ToolTipML = ENU = 'Specifies the name of the customer who will receive the products and be billed by default.', FRA = 'Spécifie le nom du client qui recevra les produits et sera facturé par défaut.';
            //BC UPGRADE KUMARR78 ++ 08-04-2026
            trigger OnBeforeValidate()
            var
                CustomerRec: Record Customer;
            begin
                if CustomerRec.Get(Rec."Sell-to Customer No.") then begin
                    if Rec."Document Type" in [Rec."Document Type"::Quote,
                                           Rec."Document Type"::Order,
                                           Rec."Document Type"::"Return Order"] then begin
                        CustomerRec.TestField("Avail.for Sales/ReturnOrd. FND", true);
                    end;
                end;
            end;

            trigger OnLookup(var Text: Text): Boolean
            var
                CustomerRec: Record Customer;
            begin
                CustomerRec.Reset();
                if Rec."Document Type" = Rec."Document Type"::Order then begin
                    CustomerRec.SetRange("Avail.for Sales/ReturnOrd. FND", true);
                    if Page.RunModal(Page::"Customer Lookup", CustomerRec) = Action::LookupOK then
                        Rec.Validate("Sell-to Customer Name", CustomerRec.Name);
                    CurrPage.Update();
                end;

            end;

            trigger OnDrillDown()
            var
                CustomerRec: Record Customer;
            begin
                CustomerRec.Reset();
                if Rec."Document Type" = Rec."Document Type"::Order then
                    CustomerRec.SetRange("Avail.for Sales/ReturnOrd. FND", true);

                if Page.RunModal(Page::"Customer Lookup", CustomerRec) = Action::LookupOK then begin
                    Rec.Validate("Sell-to Customer Name", CustomerRec.Name);
                end;
                CurrPage.Update();
            end;
            //BC UPGRADE KUMARR78 ++ 08-04-2026
            trigger OnAfterValidate()
            var
            begin
                //HEI.11>>
                IF CustForAccGr.GET(Rec."Sell-to Customer No.") THEN BEGIN
                    IF CustForAccGr."Trading End Date FND" <> 0D THEN BEGIN
                        IF WORKDATE() > CustForAccGr."Trading End Date FND" THEN
                            ERROR(CustTradingEndDate, CustForAccGr."Trading End Date FND");
                    END;
                END;
                //HEI.11<<
            end;
        }
        modify("Quote No.")
        {

            //Unsupported feature: Change Level on ""Quote No."(Control 243)". Please convert manually.
            Visible = ShowQuoteNo;

            QuickEntry = FALSE;
        }
        modify("Sell-to")
        {
            CaptionML = ENU = 'Sell-to', FRA = 'Donneur d''ordre';
        }
        modify("Sell-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address where the customer is located.', FRA = 'Spécifie l''adresse où se trouve le client.';

            //Unsupported feature: Change ImplicitType on ""Sell-to Address"(Control 81)". Please convert manually.
            Importance = Additional;
            QuickEntry = FALSE;
        }
        modify("Sell-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Sell-to Address 2"(Control 83)". Please convert manually.

            QuickEntry = FALSE;
            Importance = Additional;

        }
        modify("Sell-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
            QuickEntry = FALSE;
            Importance = Additional;

        }
        modify("Sell-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city where the customer is located.', FRA = 'Spécifie la ville où se trouve le client.';
            Importance = Additional;

            //Unsupported feature: Change ImplicitType on ""Sell-to City"(Control 86)". Please convert manually.

        }
        modify("Sell-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of the contact that the sales document will be sent to.', FRA = 'Spécifie le numéro du contact auquel vous envoyez le document vente.';
            QuickEntry = FALSE;
            Importance = Additional;

        }
        modify("Sell-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person to contact at the customer.', FRA = 'Spécifie le nom de la personne à contacter chez le client.';
            QuickEntry = FALSE;
        }
        modify("No. of Archived Versions")
        {

            //Unsupported feature: Change Level on ""No. of Archived Versions"(Control 198)". Please convert manually.
            Importance = Additional;

            ToolTipML = ENU = 'Specifies the number of archived versions for this sales document.', FRA = 'Spécifie le nombre de versions archivées pour ce document vente.';
        }
        modify("Document Date")
        {
            Importance = Additional;
            //Unsupported feature: Change Level on ""Document Date"(Control 45)". Please convert manually.

            ToolTipML = ENU = 'Specifies the date on which you created the sales document.', FRA = 'Spécifie la date à laquelle vous avez créé le document vente.';
        }
        modify("Posting Date")
        {

            //Unsupported feature: Change Level on ""Posting Date"(Control 12)". Please convert manually.

            ToolTipML = ENU = 'Specifies the date when the posting of the sales document will be recorded.', FRA = 'Spécifie la date à laquelle la validation du document vente sera validée.';
            Importance = Promoted;
            //Unsupported feature: Change Description on ""Posting Date"(Control 12)". Please convert manually.

            trigger OnAfterValidate()
            var
            begin
                //HEI.11>>
                IF Rec."Posting Date" <> xRec."Posting Date" THEN BEGIN
                    IF CustForAccGr.GET(Rec."Sell-to Customer No.") THEN BEGIN
                        IF CustForAccGr."Trading End Date FND" <> 0D THEN BEGIN
                            IF Rec."Posting Date" > CustForAccGr."Trading End Date FND" THEN
                                ERROR(CustTradingEndDate, Rec."Posting Date");
                        END;
                    END;
                END;
                //HEI.11<<
            end;
        }

        //Unsupported feature: Change Level on ""Order Date"(Control 14)". Please convert manually.

        modify("Promised Delivery Date")
        {
            ToolTipML = ENU = 'Specifies the date that you have promised to deliver the order, as a result of the Order Promising function.', FRA = 'Spécifie la date à laquelle vous avez promis de livrer la commande via la fonction Promesse de livraison.';
            QuickEntry = FALSE;
        }
        modify("External Document No.")
        {

            //Unsupported feature: Change Level on ""External Document No."(Control 155)". Please convert manually.

            ToolTipML = ENU = 'Specifies the number that the customer uses in their own system to refer to this sales document.', FRA = 'Spécifie le numéro que le client doit utiliser dans son propre système pour faire référence à ce document vente.';

            //Unsupported feature: Change Description on ""External Document No."(Control 155)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Salesperson Code")
        {

            //Unsupported feature: Change Level on ""Salesperson Code"(Control 10)". Please convert manually.
            Importance = Additional;
            ToolTipML = ENU = 'Specifies the name of the salesperson who is assigned to the customer.', FRA = 'Spécifie le nom du vendeur affecté au client.';
        }
        modify("Campaign No.")
        {
            Importance = Promoted;
        }
        modify("Opportunity No.")
        {
            ToolTipML = ENU = 'Specifies the number of the opportunity that the sales quote is assigned to.', FRA = 'Spécifie le numéro de l''opportunité à laquelle le devis est affecté.';
            Importance = Promoted;
        }
        modify("Responsibility Center")
        {
            ToolTipML = ENU = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.', FRA = 'Spécifie le code du centre de gestion qui est associé à l''utilisateur, à la société ou au fournisseur.';
            QuickEntry = FALSE;
        }
        modify("Job Queue Status")
        {
            Importance = Additional;
            //Unsupported feature: Change Level on ""Job Queue Status"(Control 9)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.', FRA = 'Spécifie si le document est ouvert, est en attente d''approbation, a été facturé pour acompte ou a été lancé pour l''étape suivante du traitement.';
            Importance = Promoted;
            //Unsupported feature: Change Description on "Status(Control 129)". Please convert manually.

        }
        modify("Invoice Details")
        {
            CaptionML = ENU = 'Invoice Details', FRA = 'Détails facture';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency of amounts on the sales document.', FRA = 'Spécifie la devise des montants sur le document vente.';
        }
        modify("Prices Including VAT")
        {
            ToolTipML = ENU = 'Specifies whether the unit price on the line should be displayed including or excluding VAT.', FRA = 'Spécifie si le prix unitaire de la ligne doit être affiché TTC ou hors taxes.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the customer''s VAT specification to link transactions made for this customer to.', FRA = 'Spécifie le détail TVA du client auquel associer des transactions faites pour ce client.';
            Editable = false;
            //Unsupported feature: Change Editable on ""VAT Bus. Posting Group"(Control 221)". Please convert manually.

        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the sales document.', FRA = 'Spécifie une formule qui calcule la date d''échéance du paiement, la date d''escompte et le montant de la remise sur le document de vente.';
        }
        modify("Payment Method Code")
        {
            ToolTipML = ENU = 'Specifies how the customer must pay for products on the sales document.', FRA = 'Spécifie de quelle manière le client doit régler les produits figurant sur le document vente.';
        }
        modify(SelectedPayments)
        {
            CaptionML = ENU = 'Payment Service', FRA = 'Service de paiement';
            ToolTipML = ENU = 'Specifies the online payment service, such as PayPal, that customers can use to pay the sales document.', FRA = 'Spécifie le service de paiement en ligne, tel que PayPal, que les clients peuvent utiliser pour payer le document vente.';
        }
        modify("Transaction Type")
        {
            ToolTipML = ENU = 'Specifies the type of transaction that the sales document represents, for the purpose of reporting to INTRASTAT.', FRA = 'Spécifie le type de transaction que représente le document vente, à des fins de compte rendu à INTRASTAT.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the sales header.', FRA = 'Spécifie le code section analytique associée à l''en-tête vente.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the sales header.', FRA = 'Spécifie le code section analytique associée à l''en-tête vente.';
        }
        modify("Direct Debit Mandate ID")
        {
            ToolTipML = ENU = 'Specifies the direct-debit mandate that the customer has signed to allow direct debit collection of payments.', FRA = 'Spécifie le mandat de prélèvement que le client a signé pour autoriser un prélèvement automatique des paiements.';
        }
        modify("Shipping and Billing")
        {
            CaptionML = ENU = 'Shipping and Billing', FRA = 'Expédition et facturation';
        }
        modify(ShippingOptions)
        {
            CaptionML = ENU = 'Ship-to', FRA = 'Destinataire';
            ToolTipML = ENU = 'Specifies the address that the products on the sales document are shipped to. Default (Sell-to Address): The same as the customer''s sell-to address. Alternate Ship-to Address: One of the customer''s alternate ship-to addresses. Custom Address: Any ship-to address that you specify in the fields below.', FRA = 'Spécifie l''adresse à laquelle les produits figurant sur le document vente sont expédiés. Par défaut (Adresse donneur d''ordre) : identique à l''adresse donneur d''ordre du client. Autre adresse destinataire : une des autres adresses destinataire du client. Adresse personnalisée : toute adresse destinataire que vous spécifiez dans les champs ci-dessous.';
        }
        modify("Ship-to Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            ToolTipML = ENU = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.', FRA = 'Spécifie le code d''une adresse de livraison différente de l''adresse du client, qui est entrée par défaut.';
            Importance = Promoted;
            //Unsupported feature: Change Name on ""Ship-to Code"(Control 36)". Please convert manually.

        }
        modify("Ship-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the name that products on the sales document will be shipped to.', FRA = 'Spécifie le nom auquel les produits mentionnés sur le document vente seront expédiés.';
        }
        modify("Ship-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address that products on the sales document will be shipped to.', FRA = 'Spécifie l''adresse à laquelle les produits mentionnés sur le document vente seront expédiés.';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 40)". Please convert manually.

        }
        modify("Ship-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';
            //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 42)". Please convert manually.

        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Ship-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city that products on the sales document will be shipped to.', FRA = 'Spécifie la ville vers laquelle les produits mentionnés sur le document vente seront expédiés.';

            //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 44)". Please convert manually.

        }
        modify("Ship-to Country/Region Code")
        {
            CaptionML = ENU = 'Country/Region', FRA = 'Pays/région';
        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.', FRA = 'Spécifie le nom de la personne contact à l''adresse d''expédition des produits figurant sur le document vente.';
        }
        modify("Shipment Method")
        {
            CaptionML = ENU = 'Shipment Method', FRA = 'Conditions de livraison';
        }
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            Visible = FALSE;
            //Editable = EditableMultipleRouteOrder; // BC Upgrade SHUKLP03 << Blocked because dependency on DIT object Route and field "Multiple Order Route".
            Description = 'HEI.25';
            ToolTipML = ENU = 'Specifies how items on the sales document are shipped to the customer.', FRA = 'Spécifie le mode d''expédition au client des articles figurant sur le document vente.';

            //Unsupported feature: Change Description on ""Shipment Method Code"(Control 48)". Please convert manually.


            //Unsupported feature: Change Visible on ""Shipment Method Code"(Control 48)". Please convert manually.


            //Unsupported feature: Change Editable on ""Shipment Method Code"(Control 48)". Please convert manually.

        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Agent', FRA = 'Agent';
            ToolTipML = ENU = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';

            //Unsupported feature: Change Editable on ""Shipping Agent Code"(Control 107)". Please convert manually.

        }
        modify("Shipping Agent Service Code")
        {
            CaptionML = ENU = 'Agent Service', FRA = 'Service agent';
            ToolTipML = ENU = 'Specifies the code that represents the default shipping agent service you are using for this sales order.', FRA = 'Spécifie le code qui représente la prestation transporteur par défaut que vous utilisez pour cette commande vente.';

            //Unsupported feature: Change Editable on ""Shipping Agent Service Code"(Control 139)". Please convert manually.

        }
        modify("Package Tracking No.")
        {
            ToolTipML = ENU = 'Specifies the shipping agent''s package number.', FRA = 'Spécifie le numéro récépissé du transporteur.';
        }
        modify(BillToOptions)
        {
            CaptionML = ENU = 'Bill-to', FRA = 'Facturation';
            ToolTipML = ENU = 'Specifies the customer that the sales invoice will be sent to. Default (Customer): The same as the customer on the sales invoice. Another Customer: Any customer that you specify in the fields below.', FRA = 'Spécifie le client auquel la facture vente sera envoyée. Par défaut (Client) : identique au client figurant sur la facture vente. Autre client : tout client que vous spécifiez dans les champs ci-dessous.';
        }
        modify("Bill-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the customer to whom you will send the sales invoice, when different from the customer that you are selling to.', FRA = 'Spécifie le nom du client auquel vous envoyez la facture vente, s''il diffère du client auquel vous vendez.';
        }
        modify("Bill-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address of the customer that you will send the invoice to.', FRA = 'Spécifie l''adresse du client qui sera facturé.';

            //Unsupported feature: Change ImplicitType on ""Bill-to Address"(Control 20)". Please convert manually.

        }
        modify("Bill-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Bill-to Address 2"(Control 22)". Please convert manually.

        }
        modify("Bill-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Bill-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city you will send the invoice to.', FRA = 'Spécifie la ville du client qui sera facturé.';

            //Unsupported feature: Change ImplicitType on ""Bill-to City"(Control 24)". Please convert manually.

        }
        modify("Bill-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of the contact the invoice will be sent to.', FRA = 'Spécifie le numéro du contact auquel vous envoyez la facture.';
        }
        modify("Bill-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person you should contact at the customer who you are sending the invoice to.', FRA = 'Spécifie le nom de la personne que vous devez contacter chez le client auquel vous envoyez la facture.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.', FRA = 'Spécifie le magasin à partir duquel les articles de stock doivent être expédiés par défaut au client figurant sur le document vente.';
            Importance = Promoted;
        }
        modify("Shipping Advice")
        {
            ToolTipML = ENU = 'Specifies if the customer accepts partial shipment of orders.', FRA = 'Spécifie si le client accepte l''expédition partielle des commandes.';
        }
        modify("Outbound Whse. Handling Time")
        {
            ToolTipML = ENU = 'Specifies the outbound warehouse handling time.', FRA = 'Spécifie le délai désenlogement.';
        }
        modify("Shipping Time")
        {
            ToolTipML = ENU = 'Specifies how long it takes from when the sales order is shipped from the warehouse to when the order is delivered.', FRA = 'Spécifie le délai nécessaire entre le moment de l''expédition à partir de l''entrepôt et la livraison de la commande.';

            //Unsupported feature: Change Description on ""Shipping Time"(Control 143)". Please convert manually.

        }
        modify("Late Order Shipping")
        {
            ToolTipML = ENU = 'Specifies that the shipment of one or more lines has been delayed, or that the shipment date is before the work date.', FRA = 'Spécifie que l''expédition d''une ou de plusieurs lignes a été retardée ou que la date d''expédition est antérieure à la date de travail.';
        }
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        }
        modify("EU 3-Party Trade")
        {
            ToolTipML = ENU = 'Specifies whether the sales document is part of a three-party trade.', FRA = 'Spécifie si le document vente fait partie d''une transaction tripartite.';
        }
        modify("Transaction Specification")
        {
            ToolTipML = ENU = 'Specifies a code for the sales document''s transaction specification, for the purpose of reporting to INTRASTAT.', FRA = 'Spécifie un code pour le régime du document vente, à des fins de compte-rendu à INTRASTAT.';
        }
        modify("Transport Method")
        {
            ToolTipML = ENU = 'Specifies the transport method, for the purpose of reporting to INTRASTAT.', FRA = 'Spécifie le mode de transport, à des fins de compte-rendu à INTRASTAT.';
        }
        modify("Exit Point")
        {
            ToolTipML = ENU = 'Specifies the point of exit through which you ship the items out of your country/region, for reporting to Intrastat.', FRA = 'Spécifie le point de sortie par lequel les articles sortent de votre pays/région, à des fins de compte-rendu à Intrastat.';
        }
        modify("Area")
        {
            ToolTipML = ENU = 'Specifies the area of the customer''s address, for the purpose of reporting to INTRASTAT.', FRA = 'Spécifie la région de l''adresse du client, à des fins de compte-rendu à INTRASTAT.';
        }
        modify("Prepayment %")
        {
            ToolTipML = ENU = 'Specifies the prepayment percentage if you want to apply a prepayment to all lines on the sales order.', FRA = 'Spécifie le pourcentage acompte si vous voulez appliquer un acompte à toutes les lignes de la commande vente.';
        }
        modify("Compress Prepayment")
        {
            ToolTipML = ENU = 'Specifies that prepayments on the sales order are combined if they have the same general ledger account for prepayments or the same dimensions.', FRA = 'Spécifie que les acomptes sur la commande vente sont combinés s''ils ont le même compte général pour les acomptes ou les mêmes axes analytiques.';
        }
        modify("Prepmt. Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies the code that represents the payment terms for prepayment invoices related to the sales document.', FRA = 'Spécifie le code qui représente les conditions de paiement pour les factures acompte en relation avec le document vente.';
        }
        modify("Prepayment Due Date")
        {
            ToolTipML = ENU = 'Specifies when the prepayment invoice for this sales order is due.', FRA = 'Spécifie quand la facture d''acompte de cette commande vente est due.';
        }
        modify("Prepmt. Payment Discount %")
        {
            ToolTipML = ENU = 'Specifies the payment discount percent granted on the prepayment if the customer pays on or before the date entered in the Prepmt. Pmt. Discount Date field.', FRA = 'Spécifie le pourcentage escompte accordé sur l''acompte si le client paie au plus tard à la date saisie dans le champ Date escompte acompte.';
        }
        modify("Prepmt. Pmt. Discount Date")
        {
            ToolTipML = ENU = 'Specifies the last date the customer can pay the prepayment invoice and still receive a payment discount on the prepayment amount.', FRA = 'Spécifie la dernière date à laquelle le client peut payer la facture acompte et bénéficier d''un escompte sur le montant d''acompte.';
        }
        //BC UPGRADE KUMARR78 ++ General Work 08-04-2026
        modify("Sell-to Customer No.")
        {

            trigger OnBeforeValidate()
            var
                CustomerRec: Record Customer;
            begin
                if CustomerRec.Get(Rec."Sell-to Customer No.") then begin
                    if Rec."Document Type" in [Rec."Document Type"::Quote,
                                           Rec."Document Type"::Order,
                                           Rec."Document Type"::"Return Order"] then begin
                        CustomerRec.TestField("Avail.for Sales/ReturnOrd. FND", true);
                    end;
                end;
            end;

            trigger OnLookup(var Text: Text): Boolean
            var
                CustomerRec: Record Customer;
            begin
                CustomerRec.Reset();
                if Rec."Document Type" = Rec."Document Type"::Order then begin
                    CustomerRec.SetRange("Avail.for Sales/ReturnOrd. FND", true);
                    if Page.RunModal(Page::"Customer Lookup", CustomerRec) = Action::LookupOK then
                        Rec.Validate("Sell-to Customer No.", CustomerRec."No.");
                    CurrPage.Update();
                end;

            end;

            trigger OnDrillDown()
            var
                CustomerRec: Record Customer;
            begin
                CustomerRec.Reset();
                if Rec."Document Type" = Rec."Document Type"::Order then
                    CustomerRec.SetRange("Avail.for Sales/ReturnOrd. FND", true);

                if Page.RunModal(Page::"Customer Lookup", CustomerRec) = Action::LookupOK then begin
                    Rec.Validate("Sell-to Customer No.", CustomerRec."No.");
                end;
                CurrPage.Update();
            end;


        }
        //BC UPGRADE KUMARR78 ++ General Work 08-04-2026


        //Unsupported feature: CodeModification on ""Sell-to Customer Name"(Control 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." then
          if "Sell-to Customer No." <> xRec."Sell-to Customer No." then
            SETRANGE("Sell-to Customer No.");

        if ApplicationAreaSetup.IsFoundationEnabled then
          SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0,Rec);

        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.11>>
        if CustForAccGr.GET("Sell-to Customer No.") then begin
          if CustForAccGr."Trading End Date FND" <> 0D then begin
            if WORKDATE > CustForAccGr."Trading End Date FND" then
              ERROR(CustTradingEndDate,CustForAccGr."Trading End Date FND");
          end;
        end;
        //HEI.11<<

        // <<DITW19.00.08A DDR 28/02/2017 NRQ#18985
        HasBeenPendingOrder := fctGetHasSelectPendingOrder;
        // >>DITW19.00.08A DDR NRQ#18985
        //<< DITW17.10.05 YHE 02/09/2014 DIT-770 #754
        if fctGetHasBeenDeleted or fctGetHasSelectPendingOrder then begin
          CurrPage.CLOSE;
          exit;
        end;
        //>> DITW17.10.05 YHE 02/09/2014 DIT-770 #754

        #1..4
        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
        if "Sundry Customer" then
          ShowCustomerSundryInfo();
        //>> DITW18.00.07 AKH DIT-770 #1804

        //<< DITW18.00.07 AKH 07/04/2016 DIT-770 #1042 - DITW110.00.08 DDR 02/01/2017 NRQ#0
        if xRec."Sell-to Customer No." <> "Sell-to Customer No." then
          SetSalesCommentLinkVisible();
        //>> DITW18.00.07 AKH DIT-770 #1042 - DITW110.00.08 DDR NRQ#0

        #5..8

        // <<DITW15.00.00.39 DDR 27/04/2011 #1323 (BE5.00.01) - DITW110.00.08 DDR 02/01/2017 NRQ#0
        COMMIT;
        StdCustSalesCode.AutoInsertSalesLines(Rec);
        // >>DITW15.00.00.39 DDR #1323 (BE5.00.01) - DITW110.00.08 DDR NRQ#0

        // <<DITW15.00.00.39 RBE 20/04/2011 - DDR 27/04/2011 #1230
        SalesSetup.GET;
        if SalesSetup."Copy Comments Cust. to Sell-to" then
          CopyCustCommentToSales();
        // >>DITW15.00.00.39 RBE #1230
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Posting Date"(Control 12)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.11>>
        if "Posting Date"  <> xRec."Posting Date" then begin
            if CustForAccGr.GET("Sell-to Customer No.") then begin
              if CustForAccGr."Trading End Date FND" <> 0D then begin
                if "Posting Date" > CustForAccGr."Trading End Date FND" then
                  ERROR(CustTradingEndDate,"Posting Date");
              end;
            end;
        end;
        //HEI.11<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Responsibility Center"(Control 124)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        if "Responsibility Center" <> xRec."Responsibility Center" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 DDR DIT-770 #1190
        */
        //end;


        //Unsupported feature: CodeInsertion on "Status(Control 129)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        StatusOnValidate;
          StatusOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Ship-to Code"(Control 36).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if (xRec."Ship-to Code" <> '') and ("Ship-to Code" = '') then
          ERROR(EmptyShipToCodeErr);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (xRec."Ship-to Code" <> '') and ("Ship-to Code" = '') then
          ERROR(EmptyShipToCodeErr);
        CurrPage.SAVERECORD;//FINXLBE8.00.001 DAT 18/08/2015
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shipping Agent Code"(Control 107)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        if "Shipping Agent Code" <> xRec."Shipping Agent Code" then
          CurrPage.UPDATE(true);
        //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Shipping Agent Code"(Control 107)". Please convert manually.



        //Unsupported feature: CodeInsertion on ""Shipping Agent Service Code"(Control 139)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        if "Shipping Agent Service Code" <> xRec."Shipping Agent Service Code" then
          CurrPage.UPDATE(true);
        //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Shipping Agent Service Code"(Control 139)". Please convert manually.



        //Unsupported feature: CodeInsertion on ""Location Code"(Control 94)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        if "Location Code" <> xRec."Location Code" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 DDR DIT-770 #1190
        */
        //end;
        modify("Shipment Date")
        {
            QuickEntry = false;
        }
        modify("Requested Delivery Date")
        {
            Importance = Additional;
            QuickEntry = false;
        }
        // BC Upgrade SHUKLP03 >> Blocked DIT field.
        // addfirst(General)
        // {
        //     group(Control1100710023)
        //     {
        //         Visible = SalesCommentLinkVisible;
        //         field(Text2014414; Text2014414)
        //         {
        //             DrillDown = true;
        //             Editable = false;
        //             ShowCaption = false;
        //             Style = Unfavorable;
        //             StyleExpr = TRUE;

        //             trigger OnDrillDown();
        //             begin
        //                 //<< DITW18.00.07 AKH 07/04/2016 DIT-770 #1042
        //                 ShowSalesComments();
        //                 CurrPage.UPDATE(false);
        //             end;
        //         }
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT field.
        addafter("Sell-to Customer Name")
        {
            // BC Upgrade SHUKLP03 >> Added field field.
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                ApplicationArea = All;
                Editable = DocSubtypeEditable;
            }
            // BC Upgrade SHUKLP03 << Added field field.

            field("Free Reason Code"; Rec."Free Reason Code FND")
            {
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Contact")
        {
            group("Ship-to")
            {
                CaptionML = ENU = 'Ship-to',
                            FRA = 'Destinataire';
                field("SShip-to Code"; Rec."Ship-to Code")
                {
                    CaptionML = ENU = 'Code',
                                FRA = 'Code';
                    Description = 'DITW18.00.06 MSF 07/09/2015 DIT-770 #1517';
                    Importance = Promoted;
                    QuickEntry = false;
                    ApplicationArea = All;

                    // BC Upgrade SHUKLP03 >> Blocked DIT code.
                    // trigger OnValidate();
                    // begin
                    //     //<< DITW17.10.05 YHE 02/09/2014 DIT-770 #754
                    //     if fctGetHasBeenDeleted or fctGetHasSelectPendingOrder then
                    //         CurrPage.CLOSE
                    //     //>> DITW17.10.05 YHE 02/09/2014 DIT-770 #754
                    // end;
                    // BC Upgrade SHUKLP03 << Blocked DIT code.

                }
                field("SShip-to Name"; Rec."Ship-to Name")
                {
                    CaptionML = ENU = 'Name',
                                FRA = 'Nom destinataire';
                    QuickEntry = false;
                    ApplicationArea = All;
                }
                field("SShip-to Address"; Rec."Ship-to Address")
                {
                    CaptionML = ENU = 'Address',
                                FRA = 'Destinataire';
                    Importance = Additional;
                    QuickEntry = false;
                    ApplicationArea = All;
                }
                field("SShip-to Post Code"; Rec."Ship-to Post Code")
                {
                    CaptionML = ENU = 'Post Code',
                                FRA = 'Code Postale destinataire';
                    Importance = Additional;
                    QuickEntry = false;
                    ApplicationArea = All;
                }
                field("SShip-to City"; Rec."Ship-to City")
                {
                    CaptionML = ENU = 'City',
                                FRA = 'Ville destinataire';
                    Importance = Additional;
                    QuickEntry = false;
                    ApplicationArea = All;
                }
                field("SShip-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    CaptionML = ENU = 'Country/Region',
                                FRA = 'Pays/région';
                    Importance = Additional;
                    ApplicationArea = All;
                }
            }
        }
        addafter("Document Date")
        {
            // BC Upgrade SHUKLP03 >> Blocked DIT field.
            // field("Tax Date"; Rec."Tax Date")
            // {
            //     Importance = Additional;
            //     QuickEntry = false;
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT field.
            field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
            {
                Enabled = AppliesToEnabled;
                ApplicationArea = All;
            }
            field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
            {
                Enabled = AppliesToEnabled;
                ApplicationArea = All;
            }
            // BC Upgrade SHUKLP03 >> Blocked DIT field.
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
            // BC Upgrade SHUKLP03 << Blocked DIT field.

            field("Sales Routes"; Rec."Sales Routes FND")
            {
                ApplicationArea = All;
            }
            // BC Upgrade SHUKLP03 >> Blocked DIT fields.
            // field(RoutePlanningNew; Rec."Route Planning No.")
            // {
            //     Editable = false;
            // }
            // field("Multiple Order Route"; Rec."Multiple Order Route")
            // {
            //     Editable = false;
            //     Importance = Additional;
            // }
            // field("Latest Order Date/Time"; "Latest Order Date/Time")
            // {
            //     Description = 'DITW18.00.07 DIT-770 #1282';
            //     Importance = Additional;
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT fields.

        }
        // BC Upgrade SHUKLP03 >> Blocked DIT fields.
        // addafter("Salesperson Code")
        // {
        //     field("Building No."; "Building No.")
        //     {
        //         Description = '<DITW15.00.00.35>- DIT-770 #354';
        //         Editable = false;
        //         Importance = Additional;
        //         QuickEntry = false;
        //     }
        //     field("Customer DTax Group Code"; "Customer DTax Group Code")
        //     {
        //         Description = '<DITW15.00.00.01>- DITW18.00.06 MSF 07/09/2015 DIT-770 #1517';
        //         Editable = false;
        //         QuickEntry = false;
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT fields.

        addafter("Responsibility Center")
        {
            // BC Upgrade SHUKLP03 >> Blocked DIT fields.
            // field(PickingTypeNew; "Picking Type")
            // {
            //     CaptionML = ENU = 'Picking Type',
            //                 FRA = 'Type de prélèvement';
            //     Importance = Additional;
            //     QuickEntry = false;
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT fields.

            field(ShippingAdviceNew; Rec."Shipping Advice")
            {
                Importance = Additional;
                QuickEntry = false;
                ApplicationArea = All;
            }
            // BC Upgrade SHUKLP03 >> Blocked DIT fields.
            // field("Document Shipping Costs"; HasDocumentShippingCosts)
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
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT fields.

            field("Approval Status"; Rec."Approval Status FND")
            {
                ApplicationArea = All;
            }
        }
        addafter(Status)
        {
            // BC Upgrade SHUKLP03 >> Blocked DIT fields.
            // field("Creation Date/Time"; "Creation Date/Time")
            // {
            //     Description = 'DITW18.00.07 DIT-770 #1282';
            //     Importance = Additional;
            // }
            // field("Created By"; "Created By")
            // {
            //     Description = 'DITW18.00.07 DIT-770 #1282';
            //     Importance = Additional;
            // }
            // field("Last changed User ID"; "Last changed User ID")
            // {
            //     Editable = false;
            // }
            // field("Last changed Date/time"; "Last changed Date/time")
            // {
            //     Editable = false;
            // }
            // field("Suggested Return Item"; "Suggested Return Item")
            // {
            //     Caption = 'Suggested Return Item';
            //     Importance = Additional;

            //     trigger OnValidate();
            //     begin
            //         SuggestedReturnItemAfterValidate;
            //     end;
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT fields.

            // BC Upgrade SHUKLP03 >> Moved in the interface.
            // field("Load No."; Rec."Load No.")
            // {
            //     Visible = true;
            // }
            // field("Sequence No."; "Sequence No.")
            // {
            //     Visible = true;
            // }
            // field("Suppress POS Interface"; "Suppress POS Interface")
            // {
            //     Editable = SuppressPOSInterfaceEditable;
            // }
            // BC Upgrade SHUKLP03 << Moved in the interface.

            // BC Upgrade SHUKLP03 >> Blocked in the table.
            // field("Special Order"; "Special Order")
            // {
            // }
            // BC Upgrade SHUKLP03 << Blocked in the table.

            // BC Upgrade SHUKLP03 >> Moved in the interface ext.
            // field("WMS Export"; Rec."WMS Export")
            // {
            //     Visible = false;
            // }
            // BC Upgrade SHUKLP03 << Moved in the interface ext.

            field("Source System Identifier"; Rec."Source System Identifier FND")
            {
                ApplicationArea = All;
            }
            field("Ready for Pick-up"; Rec."Ready for Pick-up FND")
            {
                ApplicationArea = All;
            }
            // BC Upgrade SHUKLP03 >> Blocked DIT code.
            // group(Control1111000002)
            // {
            //     Description = 'NRQ#94671';
            //     Visible = LotRequired;
            //     field(Text2014416; Text2014416)
            //     {
            //         Editable = false;
            //         ShowCaption = false;
            //         Style = Unfavorable;
            //         StyleExpr = TRUE;
            //     }
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT code.

            field("Doc. Amount Incl. VAT"; Rec."Doc. Amount Incl. VAT FND")
            {
                ApplicationArea = All;
            }
            field("Doc. Amount VAT"; Rec."Doc. Amount VAT FND")
            {
                ApplicationArea = All;
            }
            field("Vans Sales Route"; Rec."Vans Sales Route FND")
            {
                ApplicationArea = All;
            }
            field("IC Order No."; Rec."IC Order No. FND")
            {
                Description = 'HEI.37';
                ApplicationArea = All;
            }
        }

        // BC Upgrade SHUKLP03 >> Blocked DIT code.
        // addafter("Direct Debit Mandate ID")
        // {
        //     field("Payment Amount"; Rec."Payment Amount")
        //     {
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT code.

        addafter("VAT Bus. Posting Group")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
            {
                ApplicationArea = All;
            }

            // BC Upgrade SHUKLP03 >> Blocked DIT code.
            // field("Sundry Customer"; Rec."Sundry Customer")
            // {
            //     Editable = false;
            // }
            // field("Invoice Method"; "Invoice Method")
            // {

            //     trigger OnValidate();
            //     begin
            //         //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154 - DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
            //         RefreshInvoicePeriodEditable;
            //         CurrPage.UPDATE(true);
            //         //>>DITW17.00.02 TEC1 DIT-770 #154 - DITW18.00.07 DDR DIT-770 #1488
            //     end;
            // }
            // field("Invoice Period"; "Invoice Period")
            // {
            //     Editable = InvoicePeriodEditable;
            // }
            // field("Invoice List Customer No."; "Invoice List Customer No.")
            // {
            //     Description = 'DITW17.10.05 DIT-715 #761';
            // }
            // field("Disable DIT Disc. Prom."; "Disable DIT Disc. Prom.")
            // {
            //     Editable = FieldEditable;
            //     Importance = Additional;
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT code.

        }

        // BC Upgrade SHUKLP03 >> Blocked DIT code.
        // addafter(Control85)
        // {
        //     BC Upgrade SHUKLP03 >> Blocked DIT code.
        //     field("Fiscal Representative No."; Rec."Fiscal Representative No.")
        //     {
        //         Description = '<DITW15.00.00.28-.38 #1217>-DIT-770 #354';
        //         Importance = Additional;
        //     }
        //     field("Tax Office Code"; "Tax Office Code")
        //     {
        //         Description = '<DITW15.00.00.38 #1217>- DTI-770 #354';
        //         Importance = Additional;
        //     }
        //     field("Journey Time"; "Journey Time")
        //     {
        //         Description = 'DITW15.00.00.39 #1353';
        //     }
        //     field("Submission Type"; "Submission Type")
        //     {
        //     }
        //     field("Whse. Shipment No. (First)"; "Whse. Shipment No. (First)")
        //     {
        //         Description = '<DITW15.00.00.39 #1399> DTI770 #354';
        //         Importance = Additional;
        //         Lookup = false;
        //     }
        //     field("Whse. Shipment Status (First)"; "Whse. Shipment Status (First)")
        //     {
        //         Description = '<DITW15.00.00.39 #1399> DTI770 #354';
        //         DrillDown = false;
        //         Importance = Additional;
        //         Lookup = false;
        //     }
        //     field("Physical Location Group Code"; "Physical Location Group Code")
        //     {
        //         Importance = Additional;
        //         QuickEntry = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        //             if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
        //                 CurrPage.UPDATE(true);
        //             // >>DITW18.00.06 DDR DIT-770 #1190
        //         end;
        //     }

        // }
        // BC Upgrade SHUKLP03 >> Blocked DIT code.
        // addafter("Location Code")
        // {
        //     field("Return Location Code"; Rec."Return Location Code")
        //     {
        //     }
        // }

        // addafter("Promised Delivery Date")
        // {
        //     field("Delivery Time"; "Delivery Time")
        //     {
        //         Importance = Additional;
        //     }
        // }

        // addafter("Late Order Shipping")
        // {
        //     field("Shipment Date Formula"; "Shipment Date Formula")
        //     {
        //         Description = 'DITW17.00.02 DIT-770 #146 DTI - 770 #354';
        //         Importance = Additional;
        //     }
        //     field("Shipment Time"; "Shipment Time")
        //     {
        //         Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230';
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT code.
        //BC UPGRADE KUMARR78 FDD-MTC-007

        modify("Log Driver 107FDW")
        {
            Editable = true;
        }
        modify("LOG Vehicle Code 107FDW")
        {
            Editable = true;
        }
        modify("Route Planning No. 107FDW")
        {
            Editable = true;
        }
        modify("Trailer 107FDW")
        {
            Editable = true;
        }
        //BC UPGRADE KUMARR78 FDD-MTC-007
        //BC UPGRADE KUMARR78 ++30-06-2026
        addafter("Your Reference")
        {
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                Caption = 'Created At';
                Editable = false;
            }
            field(SystemCreatedBy; CreatedByUserName)
            {
                ApplicationArea = all;
                Caption = 'Created By';
                Editable = false;

            }
            field(SystemModifiedAt; Rec.SystemModifiedAt)
            {
                ApplicationArea = all;
                Caption = 'Modify At';
                Editable = false;

            }
            field(SystemModifiedBy; ModifedByUserName)
            {
                ApplicationArea = all;
                Caption = 'Modify By';
                Editable = false;

            }

        }
        //BC UPGRADE KUMARR78 ++30-06-2026

        addafter("Shipping Advice")
        {
            field("Copy Shipment Method Code"; Rec."Shipment Method Code")
            {
                ApplicationArea = Basic, Suite;
                Description = 'NRQ#16082';
                ToolTipML = ENU = 'Specifies how items on the sales document are shipped to the customer.',
                            FRA = 'Spécifie le mode d''expédition au client des articles figurant sur le document vente.';
            }
            // BC Upgrade SHUKLP03 >> Blocked DIT code.
            // field("Picking Type"; "Picking Type")
            // {
            // }
            // field(Distance; Distance)
            // {
            //     Description = '<DITW15.00.00.24>-NRQ#16082';
            // }
            // field("Truck Code"; "Truck Code")
            // {
            //     Description = '<DITW15.00.00.25 - DITW18.00.06 MSF 07/07/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
            //     Editable = EditableMultipleRouteOrder;

            //     trigger OnValidate();
            //     begin
            //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //         if xRec."Truck Code" <> Rec."Truck Code" then
            //             CurrPage.UPDATE(true)
            //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //     end;
            // }
            // field("Trailer Code"; "Trailer Code")
            // {
            //     Description = '<DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 - DITW18.00.06 MSF 07/07/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
            //     Editable = EditableMultipleRouteOrder;

            //     trigger OnValidate();
            //     begin
            //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //         if xRec."Trailer Code" <> Rec."Trailer Code" then
            //             CurrPage.UPDATE(true)
            //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //     end;
            // }
            // field("Truck Zone"; "Truck Zone")
            // {
            //     Description = '<DITW17.00.02 DIT-770 #154>--NRQ#16082';
            // }
            // field("Driver Code"; "Driver Code")
            // {
            //     Description = '<DITW15.00.00.25 - DITW18.00.06 MSF 07/07/2015 DIT-770 #1212 #1213 #1214>--NRQ#16082';
            //     Editable = EditableMultipleRouteOrder;

            //     trigger OnValidate();
            //     begin
            //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //         if xRec."Driver Code" <> Rec."Driver Code" then
            //             CurrPage.UPDATE(true)
            //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //     end;
            // }
            // field("Driver 2 Code"; "Driver 2 Code")
            // {
            //     Description = '<DITW17.00.02 DIT-770 #154 - DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
            //     Editable = EditableMultipleRouteOrder;

            //     trigger OnValidate();
            //     begin
            //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //         if xRec."Driver 2 Code" <> Rec."Driver 2 Code" then
            //             CurrPage.UPDATE(true)
            //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //     end;
            // }
            // field("Require 2 Drivers"; "Require 2 Drivers")
            // {
            //     Editable = EditableMultipleRouteOrder;
            // }
            // field("Ship-to Address Key No."; "Ship-to Address Key No.")
            // {
            // }
            // field(Route; Route)
            // {
            //     Description = '<DITW16.00.00.40 #1002> - DITW18.00.06 MSF 13/05/2015 DIT-770 #1212 #1213 #1214--NRQ#16082';
            //     ShowMandatory = RouteAsMandatory;

            //     trigger OnDrillDown();
            //     begin
            //         // <<DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
            //         DrillDownRouteCombinaison;
            //         // >>DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
            //     end;
            // }
            // field("Route Planning No."; "Route Planning No.")
            // {
            //     Editable = false;
            // }
            // field("Delivery Sequence"; "Delivery Sequence")
            // {
            //     Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230-NRQ#16082';
            // }
            // field("Shipping Charge Per"; "Shipping Charge Per")
            // {
            //     Description = '<DITW15.00.00.21> DTI - 770 #354';
            //     Editable = false;
            //     Importance = Additional;
            // }
            // field("Maximum Weight"; "Maximum Weight")
            // {
            //     Editable = false;
            //     Style = Strong;
            //     StyleExpr = "Maximum WeightEmphasize";
            //     Visible = "Maximum WeightVisible";
            // }
            // field("Maximum Cubage"; "Maximum Cubage")
            // {
            //     Editable = false;
            //     Style = Strong;
            //     StyleExpr = "Maximum CubageEmphasize";
            //     Visible = "Maximum CubageVisible";
            // }
            // field("Total Weight (Base)"; "Total Weight (Base)")
            // {
            //     Importance = Additional;
            // }
            // field("Total Weight"; "Total Weight")
            // {
            // }
            // field("Total Cubage (Base)"; "Total Cubage (Base)")
            // {
            //     Importance = Additional;
            // }
            // field("Total Cubage"; "Total Cubage")
            // {
            // }
            // field("Total HL Cubage (Base)"; "Total HL Cubage (Base)")
            // {
            // }
            // field("Total HL Cubage"; "Total HL Cubage")
            // {
            // }
            // field("Total Eq. UOM Quantity (Base)"; "Total Eq. UOM Quantity (Base)")
            // {
            //     Importance = Additional;
            // }
            // field("Total Eq. UOM Quantity"; "Total Eq. UOM Quantity")
            // {
            //     Importance = Additional;
            // }
            // field("Delivery Time 1 From"; "Delivery Time 1 From")
            // {
            // }
            // field("Delivery Time 1 To"; Rec."Delivery Time 1 To")
            // {
            // }
            // field("Delivery Time 2 From"; Rec."Delivery Time 2 From")
            // {
            // }
            // field("Delivery Time 2 To"; Rec."Delivery Time 2 To")
            // {
            // }
            // field("Customer Delivery Type"; Rec."Customer Delivery Type")
            // {
            // }
            // field("Delivery Time (sec.)"; Rec."Delivery Time (sec.)")
            // {
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT code.

            field("Bill Of Lading No."; Rec."Bill Of Lading No. FND")
            {
                ApplicationArea = All;
            }
            field("Vessel Name"; Rec."Vessel Name FND")
            {
                ApplicationArea = All;
            }
            field(ETD; Rec."ETD FND")
            {
                ApplicationArea = All;
            }
            field(ETA; Rec."ETA FND")
            {
                ApplicationArea = All;
            }
            field("Air Way Bill No"; Rec."Air Way Bill No FND")
            {
                ApplicationArea = All;
            }
            field("Commodity Code"; Rec."Commodity Code FND")
            {
                ApplicationArea = All;
            }
            field("Custom Tariff Code"; Rec."Custom Tariff Code FND")
            {
                ApplicationArea = All;
            }
            field("InCo Terms"; Rec."InCo Terms FND")
            {
                ApplicationArea = All;
            }
        }

        // BC Upgrade SHUKLP03 >> Blocked DIT code.
        // addafter("Transport Method")
        // {
        //     field("Transport Mode"; Rec."Transport Mode")
        //     {
        //         Description = 'DIT715 #187';
        //         DrillDown = false;
        //         Editable = false;
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT code.

        addafter("Area")
        {
            field("Country of Origin"; Rec."Country of Origin FND")
            {
                ApplicationArea = All;
            }
        }

        // BC Upgrade SHUKLP03 >> Blocked DIT code.
        // addafter(Prepayment)
        // {
        //     group("Service/Contract")
        //     {
        //         CaptionML = ENU = 'Service/Contract',
        //                     FRA = 'Service/ Contrat';
        //         field("Contract Type"; "Contract Type")
        //         {
        //             Editable = false;
        //         }
        //         field("DIT Sub-Contract Type"; "DIT Sub-Contract Type")
        //         {
        //         }
        //         field("Service Contract No."; "Service Contract No.")
        //         {
        //         }
        //         field("Financial Contract No."; "Financial Contract No.")
        //         {
        //         }
        //         field("Contract Group Code"; "Contract Group Code")
        //         {
        //         }
        //     }
        //     group(Marketing)
        //     {
        //         CaptionML = ENU = 'Marketing',
        //                     FRA = 'Marketing';
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT code.

        addafter(Control1900201301)
        {
            group(EDI)
            {
                Caption = 'EDI';
                field("Ealiest delivery Date Time"; Rec."Ealiest delivery Date Time FND")
                {
                    ApplicationArea = All;
                }
                field("Latest Delivery Date Time"; Rec."Latest Delivery Date Time FND")
                {
                    ApplicationArea = All;
                }
                field("System Date Time"; Rec."System Date Time FND")
                {
                    ApplicationArea = All;
                }
                field("Pick Date Time"; Rec."Pick Date Time FND")
                {
                    ApplicationArea = All;
                }
            }
        }
        // BC Upgrade SHUKLP03 >> Blocked DIT code.
        // addafter(Control1900316107)
        // {
        //     part(ItemHistory; "Item History FactBox")
        //     {
        //         CaptionML = ENU = 'Order Totals',
        //                     FRA = 'Historique article';
        //         Description = 'DIT-770 #354';
        //         SubPageLink = "Customer No." = FIELD("Sell-to Customer No.");
        //         Visible = false;
        //     }
        //     part(OrderTotalsOutboundFactbox; "Order Totals (Outbnd.) Factbox")
        //     {
        //         Caption = 'Order Totals (outbound)';
        //         SubPageLink = "Customer No." = FIELD("Sell-to Customer No.");
        //         Visible = false;
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT code.

        // addafter(WorkflowStatus)
        // {
        //     part(LoyaltyBalance; "Loyalty Balance FactBox CBN")
        //     {
        //         SubPageLink = "Customer No." = FIELD("Sell-to Customer No.");
        //         ApplicationArea = All;
        //     }
        // }
        moveafter("Sell-to Customer Name"; "Sell-to")
        moveafter("Quote No."; "Job Queue Status")
        moveafter("Job Queue Status"; "Posting Date")
        moveafter("Document Date"; "External Document No.")
        moveafter("Salesperson Code"; "Responsibility Center")
        moveafter("Responsibility Center"; Status)
        moveafter("Invoice Details"; "Shortcut Dimension 1 Code")
        moveafter("Shortcut Dimension 2 Code"; "Payment Terms Code")
        moveafter("Due Date"; "Payment Discount %")
        moveafter("Pmt. Discount Date"; "Payment Method Code")
        moveafter(SelectedPayments; "Direct Debit Mandate ID")
        moveafter("Direct Debit Mandate ID"; "Prices Including VAT")
        moveafter("VAT Bus. Posting Group"; "Shipping and Billing")
        moveafter("Bill-to City"; "Bill-to Contact")
        moveafter("Bill-to Contact"; "Bill-to Contact No.")
        moveafter("Bill-to Contact No."; "Location Code")
        moveafter("Location Code"; "Outbound Whse. Handling Time")
        moveafter("Promised Delivery Date"; "Shipping Time")
        moveafter("Late Order Shipping"; "Shipping Advice")
        moveafter("Shipping Advice"; "Foreign Trade")
        moveafter("Foreign Trade"; "Currency Code")
        moveafter("Currency Code"; "EU 3-Party Trade")
        moveafter("EU 3-Party Trade"; "Transaction Type")
        moveafter("Transaction Type"; "Transaction Specification")
        moveafter("Sales Routes"; "Shipment Date")
        moveafter("Shipment Date"; "Requested Delivery Date")
        // BC Upgrade SHUKLP03 >> Added on page
        moveafter("Your Reference"; "Quote No.")
        moveafter("Quote No."; "Posting Date")
        moveafter("Posting Date"; "Order Date")
        moveafter("Applies-to Doc. No."; "Route 107FDW")
        moveafter("Sales Routes"; "Route Planning No. 107FDW")
        // BC Upgrade SHUKLP03 << Added on page


    }
    actions
    {


        modify("Create &Warehouse Shipment")
        {
            trigger OnBeforeAction()
            var
            begin
                //HEI.38>>
                IF SourceSystemIdentifierAPI.GET(Rec."Source System Identifier FND") THEN
                    IF SourceSystemIdentifierAPI."Automatic SO Posting" THEN
                        ERROR(CantModifyOrderErr, Rec."Source System Identifier FND");
                //HEI.38<<

                HeinekenGlobal.CheckCustLimitBeforeReleaseSO(Rec); //HEI.41

                //>HEI.04>>
                HeinekenGlobal.CheckPCVNBalance(Rec);
                //>HEI.04>>
            end;
        }
        modify(Release)
        {
            trigger OnBeforeAction()
            var
            begin
                //HEI.23>>
                CompanyInfo.GET();
                //HEI.23<<
                //<<HEI.02
                Rec.CheckForLinkSalesDocument(Rec);
                //>>HEI.02

                HeinekenGlobal.CheckCustLimitBeforeReleaseSO(Rec); //HEI.41
                //>HEI.04>>
                HeinekenGlobal.CheckPCVNBalance(Rec);
                //>HEI.04>>

                //HEI.26>>
                IF NOT CheckAvailability() THEN
                    EXIT;
                //HEI.26<<

                // BC Upgrade SHUKLP03 >> Testscript changes.
                //HEI.04>>
                IF REC."Document Type" = REC."Document Type"::Order THEN
                    IF REC."Requested Delivery Date" = 0D THEN
                        REC.VALIDATE("Requested Delivery Date", REC."Shipment Date");
                //HEI.04<<
                // BC Upgrade SHUKLP03 << Testscript changes.

            end;

            trigger OnAfterAction()
            var
            begin
                //HEI.10>>
                IF (Rec.Status <> xRec.Status) AND (Rec.Status = Rec.Status::Released) THEN BEGIN
                    Rec.ValidateCustomerMinValue(Rec);
                END;
                //HEI.10<<

                //UpdateFreeReasonCodeDimensions(); //HEI.12  // BC Upgrade SHUKLP03 << Blocked because dependency on DIT field.
            end;
        }
        modify(CalculateInvoiceDiscount)
        {
            Visible = false;
        }
        modify("&Print")
        {
            Visible = false;
        }
        // BC Upgrade SHUKLP03 >> Blocked because of DIT field "Link Sales Document Type".
        // addafter(Invoices)
        // {
        //     action("&Return Orders")
        //     {
        //         CaptionML = ENU = '&Return Orders',
        //                     FRA = '&Retours';
        //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
        //         Image = ReturnOrder;
        //         RunObject = Page "Sales List";
        //         RunPageLink = "Link Sales Document Type" = FIELD("Document Type"),
        //                       "Link Sales Document No." = FIELD("No.");
        //     }
        //     action("Return R&eceipts")
        //     {
        //         CaptionML = ENU = 'Return R&eceipts',
        //                     FRA = 'Réceptions retour';
        //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
        //         Image = ReturnReceipt;
        //         RunObject = Page "Posted Return Receipts";
        //         RunPageLink = "Link Sales Document No." = FIELD("No.");
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked because of DIT field "Link Sales Document Type".

        addfirst("Request Approval")
        {
            action("Cre&ate/Modify Return Order")
            {
                Caption = 'Cre&ate/Modify Return Order';
                Description = 'NRQ#16224';
                Image = CreateDocument;
                ShortCutKey = 'Shift+F3';
                ApplicationArea = All;

                trigger OnAction();
                var
                    SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
                begin
                    //HEI.38>>
                    if SourceSystemIdentifierAPI.GET(Rec."Source System Identifier FND") then
                        if SourceSystemIdentifierAPI."Automatic SO Posting" then
                            ERROR(CantModifyOrderErr, Rec."Source System Identifier FND");
                    //HEI.38<<

                    // BC Upgrade SHUKLP03 >> Blocked DIT code.
                    // // <<DITW15.00.00.01 DDR 27/02/2008
                    // CODEUNIT.RUN(CODEUNIT::"Sales Ord. to Ret.Rcpt. (Y/N)",Rec);

                    // if not FIND('=><') then
                    //   INIT;
                    // // >>DITW15.00.00.01 DDR
                    // BC Upgrade SHUKLP03 << Blocked DIT code.

                end;
            }
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
            begin
                //HEI.26>>
                IF NOT CheckAvailability() THEN
                    EXIT;
                //HEI.26<<

                HeinekenGlobal.CheckCustLimitBeforeReleaseSO(Rec); //HEI.41
            end;
        }
        addafter("Pick Instruction")
        {
            action("RPM Balance Accounting")
            {
                Caption = 'RPM Balance Accounting';
                Image = "Report";
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //HEI.04>>
                    Customer.SETRANGE("No.", Rec."Sell-to Customer No.");
                    REPORT.RUNMODAL(REPORT::"RPM Balance Accounting CBN", true, true, Customer);
                    //HEI.04<<
                end;
            }
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            var
            begin
                Rec.PostOrderAndReturnOrderLinked(Rec); //HEI.06
            end;

            trigger OnAfterAction()
            var
            begin
                Rec.InsertFAGLJnlLinesForRPMDamageLoss(Rec); //HEI.04
            end;
        }
        addafter(Post)
        {
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
                    CurrPage.UPDATE();

                    Rec.PostOrderAndReturnOrderLinked(Rec);
                    PostSalesOrder(CODEUNIT::"Sales-Post (Yes/No)", Enum::"Navigate After Posting"::"Posted Document");  // BC Upgrade SHUKLP03 << Replaced with new procedure PostSalesOrder().
                    //Post(CODEUNIT::"Sales-Post + Print", NavigateAfterPost::"Posted Document");  // BC Upgrade SHUKLP03 << Blocked Nav code.
                    Rec.InsertFAGLJnlLinesForRPMDamageLoss(Rec);
                    //HEI.08<<
                end;
            }
        }
        //BC UPGRADE KUMARR78 >> FDD-MTC-008

        addafter(ProformaInvoice)
        {
            action("Pro Forma")
            {
                Image = "Report";
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    Usage: Option "Order Confirmation","Work Order","Pick Instruction",,,,,,,,,,"Order Picking","Picking List","Shipping List","Order Shipment","Combined Picking","Load List","Shipment Specif.","Return Control",,,,,,,,,,,,,,,,,,,,"Pro-forma";
                begin
                    //<<FINXL7.00.001 RBE 20/03/2013
                    //HEI.34 >>
                    SalesSetup.RESET;
                    SalesSetup.GET;
                    SalesHeaderRec := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesHeaderRec);
                    CompanyInfoRec.RESET;
                    CompanyInfoRec.GET;
                    IF SalesSetup."Export Invoice FND" = TRUE THEN
                        REPORT.RUNMODAL(51091, TRUE, TRUE, SalesHeaderRec)

                end;
            }
        }
        //BC UPGRADE KUMARR78<< FDD-MTC-008
        moveafter(CreatePurchaseInvoice; "Archive Document")
    }

    var
        PrepaymentMgt: Codeunit "Prepayment Mgt.";

        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";

        SalesHeader: Record "Sales Header";

        SalesLineBlanket: Record "Sales Line";
        //BackorderMgmt: Codeunit "Backorder Mgt.";  // BC Upgrade SHUKLP03 << DIT 
        LineStyle: Text;
        //Route: Record Route; // BC Upgrade SHUKLP03 << DIT 
        //UserSetup2: Record "User Setup"; // BC Upgrade SHUKLP03 << Moved in the interface

        SalesLine: Record "Sales Line";

        //cduICWebservice: Codeunit "IC Web Service"; // BC Upgrade SHUKLP03 << DIT 
        //TelesalesSetup: Record "Telesales Setup"; // BC Upgrade SHUKLP03 << DIT 
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
        //TempItembuff: Record "Item History Buffer"; // BC Upgrade SHUKLP03 << DIT 
        HasBeenShowDeleteCconfirmation: Boolean;
        //DelayedDisc: Codeunit "Delayed Disc. & Promo  Mgt"; // BC Upgrade SHUKLP03 << DIT 
        DelayDiscountAl: Boolean;
        DelayPromotionAl: Boolean;
        //WhseShippingDriver: Record "Whse. Shipping Driver"; // BC Upgrade SHUKLP03 << DIT 
        //WhseShippingTruck: Record "Whse. Shipping Truck"; // BC Upgrade SHUKLP03 << DIT 
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
        docsubtypecodesetup: Record "Doc Subtype Code Setup FND"; // BC Upgrade SHUKLP03 << DIT 
        HeinekenGlobal: Codeunit "Heineken Global";
        Customer: Record Customer;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        DocSubtypeEditable: Boolean;
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentVendorIsBlank: Label 'There is no Vendor associated with this Shipping Agent';
        VendorBlockForShipAgent: Label 'The Vendor associated with this Shipping Agent is blocked';
        Vend: Record Vendor;
        DocPrint: Codeunit "Document-Print";
        CustAccountGroup: Record "Account Group FND";
        CustTradingEndDate: Label 'Trading End date has been passed on %1. Order can’t be created';
        CustForAccGr: Record Customer;
        Text2014416: Label 'Lot Required or Undefined Lot Tracking quantity';
        LotRequired: Boolean;
        VisibleSendApproval: Boolean;
        // SuppressPOSInterfaceEditable: Boolean;  // BC Upgrade SHUKLP03 << Moved in the interface.
        CompanyInfo: Record "Company Information";
        Text10800: TextConst ENU = 'There are unposted prepayment amounts on the document of type %1 with the number %2.', FRA = 'Il existe des montants acompte non validés sur le document de type %1 portant le numéro %2.';
        Text10801: TextConst ENU = 'There are unpaid prepayment invoices related to the document of type %1 with the number %2.', FRA = 'Il existe des factures d''acompte impayées liées au document de type %1 portant le numéro %2.';
        // InterfaceEntryheader: Record "Interface Entry Header";  // BC Upgrade SHUKLP03 << Moved in the interface.
        // FieldEditable: Boolean; // BC Upgrade SHUKLP03 << Moved in the interface.
        AppliesToEnabled: Boolean;
        LoyaltyMgt: Page "Loyalty Balance FactBox CBN";

        VisibleSendIC: Boolean;
        CompanyInfoRec: Record "Company Information";
        SalesHeaderRec: Record "Sales Header";
        CantModifyOrderErr: Label 'You can not modify an Order sent by %1.';
        ModifedByUserName: Text[100]; //BC UPGRADE KUMARR78 ++30-06-2026
        CreatedByUserName: Text[100]; //BC UPGRADE KUMARR78 ++30-06-2026


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    trigger OnAfterGetCurrRecord();
    begin

        //HEI.33>>
        // LoyaltyMgt.UpdateFactBox("Sell-to Customer No."); // BC Upgrade SHUKLP03 << Blocked because of DIT object related code in procedure.
        //HEI.33<<
    end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger (Variable: SalesLineBlanket)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    trigger OnAfterGetRecord();
    begin
        //HEI.28>>
        if Rec.Status in [Rec.Status::Released, Rec.Status::"Pending Approval", Rec.Status::"Pending Prepayment"] then
            AppliesToEnabled := false
        else
            AppliesToEnabled := true;
        //HEI.28<<

        // BC Upgrade SHUKLP03 >> Blocked because of DIT object route and field "Multiple Order Route"..
        // //HEI.14>>
        // Route.RESET;
        // if Route.GET(Rec.Route) and Route."Multiple Order Route" then
        // //HEI.14<<
        // //IF "Multiple Order Route" THEN   //HEI.14
        // EditableMultipleRouteOrder := false
        // else
        // EditableMultipleRouteOrder := true;
        // BC Upgrade SHUKLP03 << Blocked because of DIT object Route and field "Multiple Order Route".

        // BC Upgrade SHUKLP03 >> Moved in the interface ext.
        // //HEI.17>>
        // UserSetup2.GET(USERID);
        // SuppressPOSInterfaceEditable := UserSetup2."Allow Change Interface Flag";
        // //HEI.17<<

        // //HEI.21<<
        // Rec.MakeFieldEditable;
        // //HEI.21>>
        // BC Upgrade SHUKLP03 << Moved in the interface ext.
        //BC UPGRADE KUMARR78 ++30-06-2026
        GetCreatedByUserName();
        GetModifedByUserName();
        //BC UPGRADE KUMARR78 ++30-06-2026
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        // BC Upgrade SHUKLP03 >> Added code "Document Subtype Code Setup FND".
        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>
        docsubtypecodesetup.GET;
        //DocSubtypeCode := docsubtypecodesetup."Sales - General";//SOICAD bugfix

        //HEI.31>>
        IF DocSubtypeCode = '' THEN
            DocSubtypeCode := docsubtypecodesetup."Default Sales Order";
        //HEI.31<<

        Rec.VALIDATE("Document Subtype Code FND", DocSubtypeCode);//CH
                                                                  //FDD-PTPGAP013 IBM PATHAA02 29.09.2017<<
                                                                  // BC Upgrade SHUKLP03 << Added code "Document Subtype Code Setup FND".

    end;


    //Unsupported feature: CodeInsertion on "OnClosePage". Please convert manually.

    // trigger OnClosePage();
    // var
    //     SalesPost: Codeunit "Sales-Post";
    //begin
    /*
    //<< DITW17.10.05 YHE 02/09/2014 DIT-770 #754 - DITW110.00.08 DDR 26/02/2017 NRQ#0
    if not HasBeenShowDeleteCconfirmation then
      if not fctGetHasBeenDeleted then
        // <<DITW19.00.08A DDR 28/02/2017 NRQ#18985
        if ("No." <> '') and ("Sell-to Customer No." <> '') then begin
        // >>DITW19.00.08A DDR NRQ#18985
          if ConfirmCloseDeleteEmpty then
            SalesPost.DeleteSalesOrder("Document Type","No.");
        // <<DITW19.00.08A DDR 28/02/2017 NRQ#18985
        end else
          if ("No." <> '') and HasBeenPendingOrder then
            SalesPost.DeleteSalesOrder("Document Type","No.");
        // >>DITW19.00.08A DDR NRQ#18985
    //>> DITW17.10.05 YHE 02/09/2014 DIT-770 #754 - DITW110.00.08 DDR NRQ#0
    */
    //end;


    //Unsupported feature: CodeModification on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.SAVERECORD;
    exit(ConfirmDeletion);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW17.10.05 YHE 02/09/2014 DIT-770 #754
    HasBeenShowDeleteCconfirmation := true;
    // >>DITW17.10.05 DDR DIT-770 #754
    CurrPage.SAVERECORD;
    exit(ConfirmDeletion);
    */
    //end;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    JobQueuesUsed := SalesReceivablesSetup.JobQueueActive;
    SetExtDocNoMandatoryCondition;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW15.00.00.25 DDR 09/10/2008
    "Maximum WeightVisible" := true;
    "Maximum CubageVisible" := true;
    //>>DITW15.00.00.25 DDR 09/10/2008
    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
    EditableMultipleRouteOrder := true;
    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
    JobQueuesUsed := SalesReceivablesSetup.JobQueueActive;
    SetExtDocNoMandatoryCondition;
    //<<DITW111.00.13A MSF 02/05/2019 NRQ#103938
    VisibleSendApproval :=true;
    //>>DITW111.00.13A MSF 02/05/2019 NRQ#103938
    //<<FINXL14.00.15 MSF 13/05/2020 NRQ#117628
    VisibleSendIC := true
    //>>FINXL14.00.15 MSF 13/05/2020 NRQ#117628
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsertRecord". Please convert manually.

    //trigger OnInsertRecord(BelowxRec : Boolean) : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if DocNoVisible then
      CheckCreditMaxBeforeInsert;

    if ("Sell-to Customer No." = '') and (GETFILTER("Sell-to Customer No.") <> '') then
      CurrPage.UPDATE(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5

    //FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>
    docsubtypecodesetup.GET;
    //DocSubtypeCode := docsubtypecodesetup."Sales - General";//SOICAD bugfix
    VALIDATE("Document Subtype Code",DocSubtypeCode);//CH
    //FDD-PTPGAP013 IBM PATHAA02 29.09.2017<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger (Variable: SalesLine)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    trigger OnOpenPage();
    begin

        // BC Upgrade SHUKLP03 >> Added code "Document Subtype Code".
        //HEI.09>>
        //DocSubtypeCode := docsubtypecodesetup."Sales - General";//SOICAD bugfix
        DocSubtypeCode := Rec."Document Subtype Code FND";//CH
                                                          //soicad begin delete
                                                          //IF "Document Subtype Code" <> '' THEN
                                                          //  DocSubtypeEditable := FALSE;
                                                          //soicad end delete
        IF DocSubtypeCode <> '' THEN
            DocSubtypeEditable := FALSE;
        //HEI.09<<
        // BC Upgrade SHUKLP03 << Added code "Document Subtype Code".

        //IF "Quote No." <> '' THEN     //HEI.40
        ShowQuoteNo := TRUE;

        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>>>
        DocSubtypeCode := Rec."Document Subtype Code FND";
        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017<<

        // BC Upgrade SHUKLP03 >> Moved in the interface ext.
        // //HEI.21<<
        // Rec.MakeFieldEditable;
        // //HEI.21>>
        // BC Upgrade SHUKLP03 << Moved in the interface ext.

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    begin
        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>
        docsubtypecodesetup.GET();
        //DocSubtypeCode := docsubtypecodesetup."Sales - General";//SOICAD bugfix
        Rec.VALIDATE("Document Subtype Code FND", DocSubtypeCode);//CH
                                                                  //FDD-PTPGAP013 IBM PATHAA02 29.09.2017<<
    end;

    //Unsupported feature: CodeModification on "SetExtDocNoMandatoryCondition(PROCEDURE 5)". Please convert manually.

    //procedure SetExtDocNoMandatoryCondition();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesReceivablesSetup.GET;
    ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory"
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //<< DITW18.00.07 AKH 28/03/2016 - 13/05/2016 DIT-770 #1409
    SalesReceivablesSetup.GET;
    ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory";
    if Customer.GET("Sell-to Customer No.") then
      // <<DITW18.00.07 AKH 30/03/2016 DIT-770 #1409
      ExternalDocNoMandatory := Customer.ShowExtDocMandatory();
      // >>DITW18.00.07 AKH 30/03/2016 DIT-770 #1409
    //>> DITW18.00.07 AKH DIT-770 #1409
    */
    //end;

    // BC Upgrade SHUKLP03 >> Blocked DIT procedures.
    // local procedure FormatMaximumControls(pFieldNo: Integer; pMaxValue: Decimal; pTotalValue: Decimal);
    // var
    //     lblnBold: Boolean;
    //     lcolor: Integer;
    // begin
    //     // <<DIT15.00.00.21 DDR 19/06/2008
    //     lcolor := 0;
    //     lblnBold := false;

    //     if pMaxValue < pTotalValue then
    //         lcolor := 255;

    //     lblnBold := lcolor <> 0;

    //     // <<DITW15.00.00.25 DDR 09/10/2008
    //     "Maximum CubageVisible" := false;
    //     "Maximum WeightVisible" := false;
    //     // >>DITW15.00.00.25 DDR

    //     case pFieldNo of
    //         FIELDNO("Maximum Weight"):
    //             begin
    //                 "Maximum WeightEmphasize" := lblnBold;
    //             end;
    //         FIELDNO("Maximum Cubage"):
    //             begin
    //                 "Maximum CubageEmphasize" := lblnBold;
    //             end;
    //     end;

    //     // <<DITW15.00.00.25 DDR 09/10/2008
    //     "Maximum CubageVisible" := true;
    //     "Maximum WeightVisible" := true;
    //     // >>DITW15.00.00.25 DDR
    // end;

    // local procedure ShowUpdateSalesOrder();
    // var
    //     SalesHeader: Record "Sales Header";
    // begin
    //     // <<DITW15.00.00.39 DDR 19/08/2011 #1364
    //     if "No." = '' then
    //         exit;
    //     CurrPage.SAVERECORD;
    //     COMMIT;
    //     SalesHeader := Rec;
    //     SalesHeader.SETRECFILTER;
    //     REPORT.RUNMODAL(REPORT::"Batch Update Sales Orders", true, false, SalesHeader);
    //     CurrPage.UPDATE(false);
    // end;

    // local procedure StatusOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.34 DDR 17/06/2009
    //     CurrPage.UPDATE(false);
    // end;

    // local procedure StatusOnValidate();
    // begin
    //     // <<DITW15.00.00.34 DDR 17/06/2009
    //     if xRec.Status = Status then
    //         exit;

    //     // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
    //     if (xRec.Status = Status::Open) or (Status = Status::Released) then
    //         ReleaseSalesDoc.DocStatusRelease(xRec, Rec)
    //     else begin
    //         if Status = Status::Open then
    //             ReleaseSalesDoc.DocStatusOpen(xRec, Rec)
    //         else
    //             // >>DITW15.00.00.39 DDR #1330 #1407
    //             TESTFIELD(Status, xRec.Status);
    //     end;
    // end;

    // local procedure MaximumCubageOnFormat();
    // begin
    //     CALCFIELDS("Total Cubage");
    //     FormatMaximumControls(FIELDNO("Maximum Cubage"), "Maximum Cubage", "Total Cubage");
    // end;

    // local procedure MaximumWeightOnFormat();
    // begin
    //     CALCFIELDS("Total Weight");
    //     FormatMaximumControls(FIELDNO("Maximum Weight"), "Maximum Weight", "Total Weight");
    // end;

    // local procedure MakeSalesOrder(var ItemHistoryBuf: Record "Item History Buffer");
    // var
    //     ToSalesLine: Record "Sales Line";
    //     recSalesHeader: Record "Sales Header";
    //     ReleaseSales: Codeunit "Release Sales Document";
    //     NextLineNo: Integer;
    //     lcodOldSalesHeader: Code[20];
    // begin
    //     //DITW17.00.02 VSC 10/01/2014 DIT-770 #299: New Function MakeSalesOrder()
    //     SalesSetup.GET;
    //     TelesalesSetup.GET;
    //     CLEAR(UserSetup);
    //     if USERID <> '' then begin
    //         UserSetup.GET(USERID);
    //     end;

    //     StdCustSalesCode.SETRANGE("Customer No.", "Sell-to Customer No.");
    //     StdCustSalesCode.SETRANGE(Default, true);
    //     if StdCustSalesCode.FINDFIRST then begin
    //         StdCustSalesLine.SETRANGE("Standard Sales Code", StdCustSalesCode.Code);
    //         StdCustSalesLine.SETFILTER(Type, '<>%1', StdCustSalesLine.Type::" ");
    //     end;
    //     StdCustSalesCode.SETRANGE(Default, false);
    //     ItemHistoryBuf.RESET;
    //     if ItemHistoryBuf.ISEMPTY and
    //       (StdCustSalesCode.ISEMPTY or StdCustSalesLine.ISEMPTY)
    //     then begin
    //         //fixme  IF NOT CONFIRM(Text007,FALSE) THEN
    //         //fixme   ERROR('');
    //     end;

    //     recSalesHeader := Rec;
    //     recSalesHeader.MODIFY(true);
    //     if SalesSetup."Copy Comments Cust. to Sell-to" then
    //         recSalesHeader.CopyCustCommentToSales();

    //     ToSalesLine.RESET;
    //     ToSalesLine.SETRANGE("Document Type", recSalesHeader."Document Type");
    //     ToSalesLine.SETRANGE("Document No.", recSalesHeader."No.");
    //     if ToSalesLine.FINDLAST then
    //         NextLineNo := ToSalesLine."Line No." + 10000
    //     else
    //         NextLineNo := 10000;

    //     ToSalesLine.SetSalesHeader(recSalesHeader);
    //     ToSalesLine.SuspendStatusCheck(true);
    //     ToSalesLine.SetHideValidationDialog(true);
    //     ToSalesLine.SetHasBeenShown();

    //     if ItemHistoryBuf.FINDSET then begin
    //         repeat
    //             ToSalesLine.RESET;
    //             ToSalesLine.SETRANGE("Document Type", recSalesHeader."Document Type");
    //             ToSalesLine.SETRANGE("Document No.", recSalesHeader."No.");
    //             ToSalesLine.SETRANGE(Type, ItemHistoryBuf.Type);
    //             ToSalesLine.SETRANGE("No.", ItemHistoryBuf."No.");
    //             // <<DITW114.00.15 DDR 26/03/2020 31/03/2020 NRQ#119883
    //             ToSalesLine.SETRANGE("Free Item", ItemHistoryBuf."Free Item");
    //             ToSalesLine.SETRANGE("Free Reason Code", ItemHistoryBuf."Free Reason Code");
    //             if ToSalesLine.ISEMPTY and not SalesSetup."Enforce Free Reason on Free" and (ItemHistoryBuf."Free Reason Code" = '') then
    //                 ToSalesLine.SETRANGE("Free Reason Code");
    //             // >>DITW114.00.15 DDR NRQ#119883
    //             if ToSalesLine.FINDFIRST then begin
    //                 ToSalesLine.VALIDATE(Quantity, ItemHistoryBuf."Order Quantity");
    //                 ToSalesLine."Free Item" := ItemHistoryBuf."Free Item";
    //                 ToSalesLine."Free Reason Code" := ItemHistoryBuf."Free Reason Code";
    //                 ToSalesLine."Delayed Sequence No." := ItemHistoryBuf."Delayed Sequence No.";
    //                 if ToSalesLine.InsertCharges4(0, false) then
    //                     ToSalesLine.MODIFY(true);
    //             end else begin
    //                 ToSalesLine.INIT;
    //                 ToSalesLine."Line No." := 0;
    //                 ToSalesLine."Document Type" := recSalesHeader."Document Type";
    //                 ToSalesLine."Document No." := recSalesHeader."No.";
    //                 ToSalesLine.VALIDATE(Type, ItemHistoryBuf.Type);
    //                 ToSalesLine.VALIDATE("No.", ItemHistoryBuf."No.");
    //                 ToSalesLine.Description := ItemHistoryBuf.Description;

    //                 if ItemHistoryBuf."Location Code" <> '' then begin
    //                     ToSalesLine."Physical Location Group Code" := '';
    //                     ToSalesLine.VALIDATE("Location Code", ItemHistoryBuf."Location Code");
    //                 end;
    //                 if ItemHistoryBuf."Variant Code" <> '' then
    //                     ToSalesLine.VALIDATE("Variant Code", ItemHistoryBuf."Variant Code");
    //                 if ItemHistoryBuf."Order Unit of Measure Code" <> '' then
    //                     ToSalesLine.VALIDATE("Unit of Measure Code", ItemHistoryBuf."Order Unit of Measure Code");
    //                 if ItemHistoryBuf."Order Quantity" <> 0 then
    //                     ToSalesLine.VALIDATE(Quantity, ItemHistoryBuf."Order Quantity");
    //                 if (ItemHistoryBuf."New Shipment Date" <> recSalesHeader."Shipment Date") and
    //                   (ItemHistoryBuf."New Shipment Date" <> 0D)
    //                 then
    //                     ToSalesLine.VALIDATE("Shipment Date", ItemHistoryBuf."New Shipment Date");
    //                 //<< DITW18.00.06 YHE 24/06/2015 DIT-770 #1366 - NRQ155949 NLAB 03/09/2020
    //                 ToSalesLine.VALIDATE("Free Reason Code", ItemHistoryBuf."Free Reason Code");
    //                 ToSalesLine.VALIDATE("Free Item", ItemHistoryBuf."Free Item");
    //                 //>> DITW18.00.06 YHE 24/06/2015 DIT-770 #1366 - NRQ155949 NLAB 03/09/2020
    //                 ToSalesLine."Delayed Sequence No." := ItemHistoryBuf."Delayed Sequence No.";
    //                 //<<DITW113.00.15 MSF 24/09/2019 NRQ#120074
    //                 ToSalesLine.ValidateCreateDimNo();
    //                 //>>DITW113.00.15 MSF 24/09/2019 NRQ#120074
    //                 ToSalesLine."Line No." := NextLineNo;

    //                 if not ToSalesLine.INSERT then begin
    //                     ToSalesLine."Line No." += 1;
    //                     ToSalesLine.INSERT;
    //                 end;
    //                 ///DITW113.00.15 MSF 24/09/2019 NRQ#120074
    //                 if ToSalesLine.InsertCharges4(0, false) then begin
    //                     ToSalesLine.MODIFY(true);
    //                     if ToSalesLine.RoundThousandLineNo() then
    //                         NextLineNo := ToSalesLine."Line No."
    //                     else
    //                         NextLineNo := ToSalesLine."Line No." + 10000;
    //                 end else
    //                     NextLineNo := ToSalesLine."Line No." + 10000;
    //             end;
    //         until ItemHistoryBuf.NEXT = 0;
    //     end else
    //         StdCustSalesCode.AutoInsertSalesLines(recSalesHeader);

    //     if TelesalesSetup."Auto.Release on Sales Order" then begin
    //         COMMIT;
    //         // <<NRQ139495.1 MVN 12/03/2020: Correction according to: DITW113.00.15 NLAB 12/12/2019 NRQ#125738
    //         //IF ReleaseSales.RUN(recSalesHeader) THEN;
    //         ReleaseSales.PerformManualRelease(recSalesHeader);
    //         // >>NRQ139495.1 MVN 12/03/2020
    //     end;
    // end;

    // procedure SetHasBeenShowDeleteConfirm(HasBeen: Boolean);
    // begin
    //     // <<DITW17.10.05 DDR 22/09/2014 DIT-770 #754
    //     HasBeenShowDeleteCconfirmation := HasBeen;
    // end;

    // local procedure RefreshInvoicePeriodEditable();
    // begin
    //     InvoicePeriodEditable :=
    //       not (
    //         (("Invoice Method" <> "Invoice Method"::"Combine Shipments") and
    //          ("Invoice Method" <> "Invoice Method"::"Combine Shipments Per Sell-to")));
    // end;

    // local procedure SetSalesCommentLinkVisible();
    // begin
    //     //<< DITW18.00.07 AKH 07/04/2016 DIT-770 #1042
    //     SalesCommentLinkVisible := SalesOrderCommentExists(SalesCommentLine);
    // end;

    // local procedure OpenSalesComments();
    // var
    //     lSalesCommLine: Record "Sales Comment Line";
    // begin
    //     //<<DITW18.00.07 KJB 18/02/2016 DIT-770 #1042
    //     if ("No." = '') or ("Sell-to Customer No." = '') then
    //         exit;

    //     FilterSalesComments(lSalesCommLine);

    //     if not lSalesCommLine.ISEMPTY then begin
    //         ShowSalesComments;
    //         BlnIsShownComment := true;
    //         CodOrderNo := "No.";
    //     end;
    //     //>>DITW18.00.07 KJB DIT-770 #1042
    // end;

    // local procedure ShowSalesComments();
    // var
    //     lSalesCommLine: Record "Sales Comment Line";
    //     lSalesCommLinePage: Page "Sales Comment Sheet";
    // begin
    //     //<<DITW18.00.07 KJB 18/02/2016 DIT-770 #1042
    //     FilterSalesComments(lSalesCommLine);
    //     lSalesCommLinePage.SetDefaultValue(true);
    //     lSalesCommLinePage.SETTABLEVIEW(lSalesCommLine);
    //     lSalesCommLinePage.RUN;
    //     lSalesCommLinePage.ACTIVATE;
    //     //>>DITW18.00.07 KJB DIT-770 #1042
    // end;

    // local procedure FilterSalesComments(var pSalesCommLine: Record "Sales Comment Line");
    // begin
    //     //<<DITW18.00.07 KJB 18/02/2016 DIT-770 #1042
    //     pSalesCommLine.RESET;
    //     pSalesCommLine.SETRANGE("Document Type", "Document Type");
    //     pSalesCommLine.SETRANGE("No.", "No.");
    //     pSalesCommLine.SETRANGE("Document Line No.", 0);
    //     pSalesCommLine.SETRANGE("Sales Order", true);
    //     //>>DITW18.00.07 KJB DIT-770 #1042
    // end;
    // BC Upgrade SHUKLP03 << Blocked DIT procedures.


    local procedure SuggestedReturnItemAfterValidate();
    begin
        CurrPage.UPDATE();
    end;

    // BC Upgrade SHUKLP03 >> Blocked because dependency on DIT field "Item Charge Type"
    // local procedure UpdateFreeReasonCodeDimensions();
    // var
    //     SalesLine: Record "Sales Line";
    //     SalesLine2: Record "Sales Line";
    //     DefaultDimension: Record "Default Dimension";
    //     TempDimSetEntry: Record "Dimension Set Entry" temporary;
    //     DimMgt: Codeunit DimensionManagement;
    // begin
    //     //HEI.12>>
    //     SalesLine.SETRANGE("Document No.", Rec."No.");
    //     SalesLine.SETRANGE("Document Type", Rec."Document Type");
    //     //SalesLine.SETRANGE("Item Charge Type", SalesLine."Item Charge Type"::Promotion); // BC Upgrade SHUKLP03 << Blocked DIT.
    //     if SalesLine.FINDSET() then
    //         repeat
    //             //DefaultDimension.SETRANGE("Table ID", DATABASE::"Free Reason Code"); // BC Upgrade SHUKLP03 << Blocked as per excel comment "dependency on Aptean".
    //             //DefaultDimension.SETRANGE("No.", SalesLine."Free Reason Code"); // BC Upgrade SHUKLP03 << Blocked DIT field.
    //             if DefaultDimension.FINDSET() then begin
    //                 SalesLine2.GET(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.");
    //                 DimMgt.GetDimensionSet(TempDimSetEntry, SalesLine2."Dimension Set ID");
    //                 repeat
    //                     UpdateDimSet(TempDimSetEntry, DefaultDimension."Dimension Code", DefaultDimension."Dimension Value Code");
    //                 until DefaultDimension.NEXT() = 0;
    //                 SalesLine2.VALIDATE("Dimension Set ID", DimMgt.GetDimensionSetID(TempDimSetEntry));
    //                 SalesLine2.MODIFY(true);
    //             end;
    //         until SalesLine.NEXT() = 0;
    //     //HEI.12
    // end;
    //BC UPGRADE KUMARR78 ++30-06-2026
    local procedure GetCreatedByUserName()
    var
        User: Record User;
    begin
        Clear(CreatedByUserName);

        if IsNullGuid(Rec.SystemCreatedBy) then
            exit;

        User.Reset();
        User.SetRange("User Security ID", Rec.SystemCreatedBy);

        if User.FindFirst() then
            CreatedByUserName := User."User Name";
    end;

    local procedure GetModifedByUserName()
    var
        User: Record User;
    begin
        Clear(ModifedByUserName);

        if IsNullGuid(Rec.SystemModifiedBy) then
            exit;

        User.Reset();
        User.SetRange("User Security ID", Rec.SystemModifiedBy);
        if User.FindFirst() then
            ModifedByUserName := User."User Name";
    end;
    //BC UPGRADE KUMARR78 ++30-06-2026

    procedure UpdateDimSetP(var TempDimSetEntry: Record "Dimension Set Entry" temporary; DimCode: Code[20]; DimValueCode: Code[20]);
    var
        DimVal: Record "Dimension Value";
    begin
        //HEI.12>>
        if DimCode = '' then
            exit;
        if TempDimSetEntry.GET(Rec."Dimension Set ID", DimCode) then
            TempDimSetEntry.DELETE();
        if DimValueCode = '' then
            DimVal.INIT()
        else
            DimVal.GET(DimCode, DimValueCode);
        TempDimSetEntry."Dimension Code" := DimCode;
        TempDimSetEntry."Dimension Value Code" := DimValueCode;
        TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
        if TempDimSetEntry.INSERT() then;
        //HEI.12<<
    end;

    // BC Upgrade SHUKLP03 >> Moved in the interface ext.
    // procedure MakeFieldEditable();
    // begin
    //     //HEI.21<<
    //     InterfaceEntryheader.RESET;
    //     InterfaceEntryheader.SETRANGE(Status, InterfaceEntryheader.Status::Pending);
    //     InterfaceEntryheader.SETRANGE(Direction, InterfaceEntryheader.Direction::Inbound);
    //     InterfaceEntryheader.SETFILTER("Interface Code", '=%1', 'PEPERRI-IMP');
    //     if InterfaceEntryheader.FINDSET then begin
    //         if "No." = 'O' + InterfaceEntryheader."Salespers./Purch. Code" + '-' + InterfaceEntryheader."Source No." then begin
    //             if InterfaceEntryheader.Closed = true then begin
    //                 //"Disable DIT Disc. Prom." := "Disable DIT Disc. Prom."::Promotion;  // BC Upgrade SHUKLP03 << Blocked DIT field.
    //                 FieldEditable := false;
    //             end else begin
    //                 FieldEditable := true;
    //                 //"Disable DIT Disc. Prom." := "Disable DIT Disc. Prom."::" "; // BC Upgrade SHUKLP03 << Blocked DIT field.
    //             end;
    //         end;
    //     end;
    //     //HEI.21>>
    // end;
    // BC Upgrade SHUKLP03 << Moved in the interface ext.

    local procedure CheckAvailability(): Boolean;
    var
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        SalesLines: Record "Sales Line";
        ItemsNotAvailable: Text;
        Text001: Label 'The following items have an available inventory lower than the entered quantity:\%1\Do you want to continue?';
        SalesSetup: Record "Sales & Receivables Setup";
        ItemStockWarning: Record Item;
    begin
        //HEI.26>>
        SalesSetup.GET();
        if not SalesSetup."Item availability FND" then
            exit(true);

        ItemsNotAvailable := '';
        SalesLines.RESET();
        SalesLines.SETRANGE("Document Type", Rec."Document Type");
        SalesLines.SETRANGE("Document No.", Rec."No.");
        SalesLines.SETRANGE(Type, SalesLines.Type::Item);
        SalesLines.SETFILTER(Quantity, '<>%1', 0);
        SalesLines.SETFILTER("Attached to Line No.", '=%1', 0);
        if SalesLines.FINDFIRST() then
            repeat
                if ItemStockWarning.GET(SalesLines."No.") and
                  ((ItemStockWarning."Stockout Warning" = ItemStockWarning."Stockout Warning"::Yes) or (ItemStockWarning."Stockout Warning" = ItemStockWarning."Stockout Warning"::Default) and SalesSetup."Stockout Warning") then
                    if SalesInfoPaneMgt.CalcAvailability(SalesLines) < 0 then
                        ItemsNotAvailable += SalesLines."No." + ' ';
            until SalesLines.NEXT() = 0;

        if ItemsNotAvailable <> '' then begin
            if not CONFIRM(Text001, true, ItemsNotAvailable) then
                exit(false);
        end;
        exit(true);
        //HEI.26<<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

