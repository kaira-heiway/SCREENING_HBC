pageextension 51171 PurchaseOrderExt extends "Purchase Order"
{
    //    FINXL7.00.001 RBE 20/03/2013 : Added field "Your Reference" on page
    // FINXL7.00.001 KLU 25/09/2013 : Added actions for approve/reject (same functionality as approval entries form)
    // FINXL8.00.001 RBE 01/12/2014: Email functionality
    // FINXL8.00.001 BSA 03/06/2015 #182: Added Field : "Emergency Order"
    // FINXL8.00.001 BSA 10/06/2015 #85 : Added Field "Last changed User ID", "Last changed Date/time"

    // DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 27/12/2007 Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 14/01/2008 Remove seperation line from Function button
    // DITW15.00.00.01 DDR 17/01/2008 some Captions
    //                                New calling functions to insert (item) charges
    // DITW15.00.00.01 DDR 27/02/2008 Drink-it Return Deposit functionnalities
    //                                Added menu "Create &Return Order" into Function button + shortcut Shift+F3
    //                                Added menu "&Return Orders" into "Order" button
    //                                Added field "No. of Return Orders" (general tab)
    // DITW15.00.00.01 DDR 11/03/2008 Added menu "Return Receipts" into "Order" button
    //                                Remove counter return orders
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //                                Correct menu "&Return Orders" into "Order" button
    // DITW15.00.00.21 DDR 18/06/2008 Added new tab "Shipping Agent"
    //                                Added function FormatMaximumControls()
    //                                Added form property CalcFields("Total Weight","Total Cubage")
    //                                Added fields (not editable)
    //                                  "Maximum Weight","Maximum Cubage",
    //                                  "Shipping Charge Type","Shipping Charge No.","Shipping Charge Per",
    //                                  "Total Weight","Total Cubage","Shipping Agent Code","Shipping Agent Service Code"
    //                                  "Shipping Unit Cost","Shipping Cost Amount"
    //                                Added field (editable)
    //                                  "Shipping Charge Per"
    //                                Replace Print Button by menu-Button
    // DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    // DITW15.00.00.23 DDR 08/08/2008 Certification rules
    //                                  Remove "Lot &No. Info." button
    //                                  Change MenuItem access keys conflict.
    //                                     "Return &Shipments" -> "R&eturn Shipments" (Order button)
    //                                     "&Return Orders" -> "Ret&urn Orders" (Order button)
    //                                     "&Create Return Order" -> "Cre&ate Return Order" (Function button)

    // DITW15.00.00.23.04 DDR 15/09/2008 Refresh Purchase Header before release document when shipping matrix to update
    // DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    // DITW15.00.00.25 DDR 09/10/2008 Bugfix refreshing fields "Maximum Weight","Maximum Cubage" with color
    //                                 into function FormatMaximumControls()
    //                                Added fields "Truck Code","Driver Code","Distance" into Shipping Agent tab
    //                                Editable fields "Shipping Agent Code","Shipping Agent Service Code"
    //                                Non-Editable "Shipping Charge Per"
    //                                Remove fields "Shipping Charge Type","Shipping Charge No.",
    //                                  "Shipping Unit Cost","Shipping Cost Amount"
    //                                Refresh Header before call Posting document
    //                     21/10/2008 Deleted field2013722 Duty Tax Type
    //                                Added fields "Vendor DTax Group Code" into Invoicing tab
    // DITW15.00.00.28 DDR 24/11/2008 Added "Fiscal Representative No." into Shipping tab
    // DITW15.00.00.31 DDR 17/02/2009 Correct Caption field "Total Cubage" into Shipping Agent tab
    // DITW15.00.00.33 DDR 07/05/2009 Move field "Customer DTax Group Code" into 'General' tab
    // DITW15.00.00.34 DDR 16/06/2009 Added auto-release document into menu 'Create Whse. shipment'
    //                     17/06/2009 Added shortcut key CTRL+F10 to switch status 'open' the current document
    //                                Changed Editable "Status" field
    //                                Added functions DocStatusRelease(),DocStatusOpen(),
    // DITW15.00.00.36 DDR 07/12/2009 issue 981 Bugfix Save/Refresh before release function
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 30/09/2010 issue 1217 Added 'Get EMCS ARC No. to Apply' menu into 'Functions' menu
    //                 DDR 27/01/2011 issue 1217 (DIT711 137) Added fields "Tax Office Code" into 'Shipping' tab
    // DITW15.00.00.38 PRODW14.00.00.17 DDR 08/02/2011 issue 1271
    //                                Added menu 'Quality Tests' into 'Line' Button
    // DITW15.00.00.39 DDR 27/04/2011 issue 1322 NAVBE5.00 (SP1) functionnality to insert Customer Std. Sales Codes automatically
    //                                Added to call function StdVendPurchCode.AutoInsertPurchLines()
    //                                  from OnAfterValidate trigger field "Sell-to Customer No."
    // DITW15.00.00.39 DDR 10/05/2011 issue 1330 Upgrade editable Status to work with Prepayments
    //                                           Remove 'ShowConfirmMsg' parameter function DocStatusOpen();
    //                                           Modified functions DocStatusOpen(),DocStatusRelease()
    //                                           Modified validate trigger field "Status"
    //                     28/06/2011 issue 1330 Bugfix conflict between status "Pending Approval" and "Pending Prepayment"
    //                                             when releasing (attempt)
    //                     27/07/2011 issue 1407 Added flowfields "Disc.Promo. Order Calculated" (see "Zoom view)
    //                                           Moved/Deleted functions into codeunit414 Release Sales Document
    //                                             DocStatusRelease(),DocStatusOpen()
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                              Added to insert first line automatically
    //                     19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    // DITW15.00.00.39 DDR 22/08/2011 issue 1399 Added fields into 'Shipping' tab
    //                                             "Whse. Shipment No. (First)","Whse. Shipment Status (First)"
    // DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  call function SetDisableRefreshLines() before each report
    //                                                  (don't use the <RunObject> property)
    //                     12/06/2012 DIT-715 #328 Removed 'BlankZero' property field "Whse. Shipment Status (First)"
    //                     13/06/2012 DIT-715 #338 Added 'Period (Items)' menu into button 'Item\Item Item Availability by'
    //                                             Added 'Items by Period' into button 'Item'
    // DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added 'Service/Contract' tab
    //                                             Added fields into 'Service/Contract' tab
    //                                               "DIT Sub-Contract Type","Contract Group Code","Service Contract No."
    //                                             Moved "Building No." into 'Service/Contract' tab
    //                 DDR 27/09/2012 DIT-715 #458 Bugfix width of subform60 PurchLines
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added menu 'SSCC Tracking Lines' in 'Line' buttton
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    //                                             NORRIQ owm - Online Warehouse Management
    //                                             Copyright 2008 by NORRIQ A/S, www.norriq.dk
    //                                               New menu "Show N-owm activities" on Order Action.

    // DITW17.00.02 DDR 06/06/2013 DIT-770 #99 Added fields "Ship-to Country/Region Code" into 'Shipping' tab
    //                  04/07/2013 DIT-770 #99 Added fields "GWC Country/Region Code" into 'Foreign Trade' tab
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #99
    // DITW17.00.02 AT  09/09/2013 DIT-770 #170 merge WHN-001 HIT0279
    //                             Status field NOT Editable
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0012.1
    //                             added requester id field
    //                             added action quote approvals
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0012.2
    //                             changed caption of "Quote no."
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0012.3
    //                             Translations
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0019.1
    //                             Order may only be printed if status = released
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added in General Tab
    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 DDR 28/11/2013 DIT-770 #272 Upgrade N-OWM4.5 Nav2013 R1
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Physical Location Group Code" (General tab)
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1191 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    // DITW17.10.04 AKH 24/11/2014 DIT-770 #1001 Added Action "Print and Mail"
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214 Filter on "Resp. Center Table Filter 2"
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type
    //                                           Set FIeld Contract Type to Editable = FALSE
    // DITW18.00.06 DDR 07/08/2015 DIT-770 #1368 Added field "Vendor Posting Group" into 'Service/Contract' tab
    // DITW18.00.07 AKH 11/02/2016 DIT-770 #1804 Sundry Vendor
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Several adjustments
    // DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Add HasDocumentShippingCosts to General TAB
    // DITW18.00.07 AKH 28/03/2016 DIT-770 #1409 Added "ShowMandatory" property for "Vendor Shipment No." field
    // DITW18.00.07 AKH 27/04/2016 DIT-770 #1346 Added field "Vendor Delivery Type" & "Delivery Time (sec.)" under Shipping Agent tab
    // DITW18.00.07 VSC 09/05/2016 DIT-770 #1968 - #1977 Default & Mandatory Route setup + Route default values + shipment date calculation
    // DITW18.00.07 VSC 09/05/2016 DIT-770 #1971 - #1976 Totals on Purchase Order Header (weight, cubage, volume HL, shortcut unit of measures)
    // DITW18.00.07 AKH 13/05/2016 DIT-770 #1409 Restored standard code for check on "External Document No."
    // DITW18.00.07 VSC 25/05/2016 DIT-770 #1968 Add New field "Receipt Status"
    // DITW18.00.07 VSC 25/05/2016 DIT-770 #1970 Rename Tab Shipping Agent to Receiving
    //                                           Remove field "Shipping Charge Per"
    //                                           Move fields to Tab General:"Expected Receipt Date","Requested Receipt Date","Promised Receipt Date","Receipt Status"
    //                                           Set importance to Additional for fields "Requested Receipt Date", "Promised Receipt Date","Tax Date","Vendor DTax Group Code","Vendor Invoice No." and "Linked Customer No."
    //                                           Set Quickentry on "Buy-from Vendor No.","Vendor Order No.",Route,"Expected Receipt Date","Purchaser Code"
    // DITW18.00.07 VSC 26/05/2016 DIT-770 #1984 Get Setup , Remove Action &Print (double as Action order).
    //                                           Action Print > &Order  Promoted in Category Report
    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time","Created By" Importance Additional
    // DITW18.00.07 VSC 01/07/2016 DIT-770 #1282 Set fields to visible "Creation Date/Time","Created By"
    // DITW19.00.08 MSF 30/08/2016 BL#10387 (DIT-770 #1274) Vendor - Tax information depending on Receiving-From/Shipped-From addresses
    // DITW19.00.08 MSF 05/09/2016 BL#10387 (DIT-770 #1274) If receipt/return shipment, dont allow to modify the tax reg no or whse ref
    // DITW19.00.08 MSF 09/09/2016 BL#10387 (DIT-770 #1274) Review Code

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 03/02/2017 NRQ#20678 upgrade Usage optionstring
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.09 DDR 20/04/2017 NRQ#13107 Add all country code fields
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added fields
    //                                         Route Planning No.
    //                                         Multiple Route Order
    //                                         "Trailer Code"
    //                                         Field Editable IF NOT Multile Route Order
    // DITW110.00.11 MSF 30/11/2017 NRQ#16082 Remove Condition EditableMultipleRouteOrder  on SOme fields
    // DITW111.00.13A MSF 09/05/2019 NRQ#109271 Disable DIT Discounts and or Promotions for a sales documents
    //                                     Added Field "Disable DIT Disc. Prom."

    // HEI.01 PTPGAP066 IBM SOICAD01 29.06.2017 Purchase to Pay– Bank account for payment
    // FINXL11.00 HBA 03/05/2018 NRQ#69018: Added Action "Auto. Send IC Order"
    // DITW111.00.13A NLAB 25/06/2019 NRQ#113801 : Merge NRQ#69018

    //   # New field Vendor Bank Account

    // HEI.02 HLSRM02-05 IBM LAZARE02 31.07.2017
    //   #New fields for SRM integration added to SRM tab

    // HEI.03 FDD-PTPGAP007 IBM PATHAA02 28.08.2017
    // # Made property "Show mandatory" to True for the field "Vendor Bank Account"

    // HEI.04 FDD-PURGAPINT005 IBM NASTAA02 28.09.2017 # Purchase Order Layout Template Procurement
    //   # Print button should be enabled just when "SRM Order No." is empty

    // HEI.05 FDD-PTPGAP067 IBM Isyed01
    //   # added code to update document sub type for PO if we are printing prepayment invoice and prepayment redit memo.

    // HEI.06 HLSRM03 IBM LAZARE02 11.12.2017
    //   # New action Get Blanket Order Price
    // HEI.07  FDD-AL-PTPGAP02 IBM HORTOC01 16.05.2018 - new subpage

    // HEI.08 defect #2234 IBM POSTOI01 05.06.2018
    //   #new code OnOpenPage, new variable DocSubtypeEditable, change property Editable on Document Subtype Code field
    // HEI.09 SoicaD Filtering by doc subtype
    // HEI.10 RFC-CHG0249183 IBM.LS 04.10.2018
    //   # Added code to call SendEmailPurchaseOrder function. Code commented here and added in Codeunit-415.
    //   # Added field - "BRC Purchase Order".

    // HEI.11 RFC-CHG0246348 IBM.AB 08.10.2018
    //   # Field Purchase Reason Code added
    //   # Code added to make under Reopen action to archive and make Purchase Reason Code blank
    // HEI.12 RFC-CHG0246348 IBM.SS 16.01.2019
    //   Code added for Item category
    // HEI.13 FDD-PURGAP027 - Maximo POs approval flow, IBM.POENAB02 , 28.02.2019
    //   # New field added in "General" group - 50002 Payment User. Set EDITABLE property for this field to FALSE.
    // HEI.14 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # Removed Field "Payment User"
    //   # Added Field “PQ Approver”
    //   # Created new Page Action "Purchase Additional"
    // HEI.15 FDD-Ethiopia_Prepayment HT628 IBM POSTOI01 04.07.2019
    //   # modify OnAfterGetCurrentRecord
    //   # add new glovbal variable ActivePrepayment : IncludeInDataset= True
    //   # change the Editable property for the following fields : "Prepayment%, "Compress Prepayment", "Prepmt.Payment Terms Code", "Prepmt.Payment Discount %"
    // HEI.16 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"
    //   # Made Field "Vendor Posting Group" non-editable
    // FINXL11.00 HBA 03/05/2018 NRQ#69018: Added Action "Auto. Send IC Order"
    // DITW111.00.13A NLAB 25/06/2019 NRQ#113801 : Merge NRQ#69018
    // HEI.18 FDD-HB858 - CHG2027215 SHANKJ03 IBM 23.01.2020
    //   # Added field House Number
    // HEI.19 CHG2038388 FDD-HB1005 IBM GUNERE01 17.02.2020 # "Shopping Card No." field added to SRM tab
    // HEI.20 FDD-HT657 IBM NASTAA02 27.02.2020 # Ethiopia Intercompany Automation
    //   # New Field added: "IC Document"
    //   # Code added on OnAfterGetRecord trigger
    // FINXL14.00.15 MSF 13/05/2020 NRQ#117628 Enable /Disable AutoSend To IC
    // Hei.21 FDD HT1136 CHG2055070 IBM Shankj03 16.06.2020
    //  # New Field Added License Code
    //  # Code added in triggers
    // HEI.22 CHG2062340 HB1378 IBM GAVANM01 29.07.2020 #Retrofitting the Brewco – Sellco
    //   # for the action "Auto Send IC Order": delete Visible property, add Enabled property
    // HEI.23 CHG2073467 HB1369 IBM GAVANM01 17.08.2020  Enhancements to the Intercompany automation functionality
    //   # new field added: IC Order No.
    //   # hide action "Send IC Purchase Order"
    //   # Properties changed for action Auto. Send IC Order: Promoted=yes, PromotedCategory=Process, PromotedIsBig=yes
    // HEI.24 CHG2081091 IBM SHANKJ03  01.10.2020
    //   # new field added Mail sent & Mail sent date time
    // HEI.26 CHG2083064 IBM.GUNERE01  21.10.2020 # Mail Sent, Mail sent date time fields set to editable false
    // HEI.27 HT1136 CHG2084917 IBM.GUNERE01 11.03.2020 # Added Code in License Code Onvalidate trigger
    // HEI.28 CHG2088873 IBM.GUNERE01 11.26.2020 # License Code onDrillDown, Post and Release funcs. modified
    // HEI.29 CHG2073468 HB1369 IBM GAVANM01 04.01.2021 Enhancements to Intercompany Part 3
    //   # New field added: PurchaseHeaderAdditional."Special Order No."
    // HEI.30 CHG2081323 HB1619 IBM.GUNERE01 20.01.2021 # Limit PO field added in SRM Tab
    // HEI.31 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New field added in General tab: LSR Order No
    // Hei.32  CHG2096764 IBM. PANDES01  12.03.2021
    //  # Added code for Requesters ID.
    // HEI.33 FDD-HB1195 CHG2070051 IBM GUNERE01 04.02.2021 # Import Identifier field added to Receiving tab
    // HEI.34 CHG2105495- Defect - 6206 IBM NANDIS01 07.04.2021 - Haiti fix for defect 6206 Location error when approving PO/PQ
    //   # Defect raised from Haiti opco - location code should be mandatory while sending the doc to approver
    // HEI.35 CHG2098629 HB2014 IBM NANDIS01 08.04.2021 - LOG_Automatic creation of Transfer Order for Import PO
    //   # Called a new function and added in ReOpen and Release button
    //   # Shown field - "Exp Physical Del Date(Imp)" and "TO Reference" from Purchase Header Additional table
    // HEI.36 FDD-HB2174 CHG2104952 IBM NANDIS01 27.07.2021 Ibecor - PO API
    //   # New Tab - Ibecor created and PFI Doc No. and other fields shown
    //   # New button - Ibecor Situational FIle created
    //   # Visibility of Ibecor tab controlled - code added in OnInit trigger
    // HEI.37 CHG2121745 IBM BHATTA09 23.08.2021
    //   # New Field added - Shopping Card Creation Date
    // HEI.38 CHG2103752 IBM BHATTA09 07.09.2021
    //   # Maximo Status field editability property Changed and code added
    //   # Maximo Status field added in Maximo tab
    // HEI.39 CHG2123487 IBM BHATTA  20.10.2021
    //   # Code added for CMG Dimension mandatory for Shipping Cost type Item Charges
    // HEI.40 FDD-HB2155 CHG2128694 IBM NANDIS01 28.10.2021 WMS PO
    //   # field shown - "WMS Export"
    // HEI.41 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # New fields added in Ibecor TAB
    //   # Caption changed to "Shipment No." for field PurchaseHeaderAdditional."Order No." from Order No., and made the field uneditable
    // HEI.42 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # Removed filter from properties of button "Ibecor Situational File"
    //   # Code added in button - Ibecor Situational FIle
    // HEI.43 CHG2155847 HB2821 IBM NANDIS01 08.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Field - "Astro Unique ID" shown in new tab - Astro WMS
    // HEI.44 CHG2155847 HB2821 IBM NANDIS01 26.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Field name changed to "Astro WMS PO" from "Astro Unique ID"  and added new button "Process PO for Astro WMS"
    // HEI.45 CHG2167376 HB3082 NORRIQ KOROLA 11.11.2022
    //   # Location Code, Bank who issued the License,License Expiration Date,CoD/CoC Number - fields added
    // HEI.46 CHG2167376 HB3082 NORRIQ KOROLA 22.11.2022
    //   # Ibecor FastTab changed
    // HEI.47 CHG2167376 HB3082 IBM NANDIS01 01.02.2023 # Ibecor-HL Integration, adding Import license and inspection codes in POs
    //   # New fields shown - "License Required" and "Credit Info Required"
    // HEI.48 CHG2198834 CC IBM NANDIS01 13.04.2023 #Issue with STP report that collects eligible PO’s to be sent to ASTRO
    //   # Astro WMS Tab will be visible as per User setup, new wizard to remove unique id created
    // HEI.49 CHG2198834 CC IBM NANDIS01 19.04.2023 #Issue with STP report that collects eligible PO’s to be sent to ASTRO
    //   # Message box made clear for users
    // HEI.50 CHG2170300 HB3129 IBM SRIVAS07 26-04-23 # Block editing of dimensions during PO Invoice Processing
    //   # Added EBF Combination restrictions in Release and Send for Approval Actions.
    // HEI.51 CHG2214459 IBM SRIVAS07 01.08.2023 - to amend the logic to get the license Number from the dimension license code
    //   # Added Code for Update the License Name in "Purchase Header Additional FND" Table, in License Code - OnDrillDown()
    // HEI.52 CHG2215561 IBM SRIVAS07 21.08.2023 - Message not transferred to Ibecor
    //   # Added code in "License Code" - OnValidate()
    // HEI.53 CHG2215561 IBM SRIVAS07 23.08.2023 - Message not transferred to Ibecor
    //   # Added code in "License Code" - OnValidate()
    // HEI.54 CHG2215561 IBM SRIVAS07 28.08.2023 - Message not transferred to Ibecor
    //   # Added code in "License Code" - OnValidate() - Auto Refresh Page and Reset locTempDimensionSetEntry.
    // HEI.55 CHG2218301 HB3550 IBM SRIVAS07 18.10.2023 - Reduce the manual Purchase Order deletion Development
    //   # Adde code in OnOpen Action
    // HEI.56 CHG2210794 SAHAL01 23.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - PO Transaction Interface Zycus
    //                      - Processed PO Transaction Zycus
    // HEI.57 CHG2210794 SAHAL01 30.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Fields - Zycus GR UUID
    //                      - GR Transaction Interface Zycus
    //                      - Processed GR Transaction Zycus
    // HEI.58 CHG2251877 MAJUMS03 05.07.2024 Warehouse Receipt Lines creation issue
    //   # Code added under OnValidate() Trigger of "Delivery Finalized" field to proper update of "Warehouse Rcpt/Shpt No." of Warehouse Request to fix
    //   the bug related to "Delivery Finalized" field in Purchase Line table and "Warehouse Rcpt/Shpt No." of Warehouse Request table. Code written on
    //   Page level to update "Warehouse Rcpt/Shpt No." of Warehouse Request table before triggering the function under Codeunit and to avoid COMMIT.
    //   # TableData Warehouse Request=rm Permission added.
    // HEI.59 CHG2251877 MAJUMS03 05.07.2024 Warehouse Receipt Lines creation issue
    //   # Code modified.
    //   # TableData Warehouse Request=rm Permission is modified as Warehouse Request=rimd.
    //------------------------------------------------------------------------------------------------
    //BC Upgrade SHARMP16-- Interface related code and fields shifted to Interface Ext. 
    //HEI.08 Code skipped because --- Drink-It fields used.
    //HEI.09 Code skipped because --- Drink-It fields used.
    //HEI.36-- Code shifted to Interface Extension
    //HEI.46 --Code shifted to Interface Extension
    //Hei.32--Code shifted to Interface Extension
    //HEI.12--Code shifted to Interface Extension
    //HEI.11--Code shifted to Interface Extension
    //HEI.42--Code shifted to Interface Extension
    //HEI.07--Code shifted to Interface Extension
    //HEI.21--Code shifted to Interface Extension
    //HEI.21--Code shifted to Interface Extension
    // BC Upgrade SHUKLP03 >> Added field "LSR Order No." and "WMS Export" in the interface ext.
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.', FRA = 'Spécifie le numéro d''un compte général, d''un article, d''un coût supplémentaire ou d''une immobilisation, selon la sélection effectuée dans le champ Type.';
        }
        modify("Buy-from Vendor No.")
        {
            QuickEntry = True;
        }
        modify("Buy-from Vendor Name")
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
            ToolTipML = ENU = 'Specifies detailed information about the vendor on the selected purchase document.', FRA = 'Spécifie des informations détaillées concernant le fournisseur sur le document achat sélectionné.';
            QuickEntry = False;
        }
        modify("Buy-from")
        {
            CaptionML = ENU = 'Buy-from', FRA = 'Fournisseur';
        }
        modify("Buy-from Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the vendor''s buy-from address.', FRA = 'Spécifie l''adresse fournisseur du fournisseur.';
            QuickEntry = False;
        }
        modify("Buy-from Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies an additional part of the vendor''s buy-from address.', FRA = 'Spécifie un complément à l''adresse fournisseur du fournisseur.';

            //Unsupported feature: Change ImplicitType on ""Buy-from Address 2"(Control 91)". Please convert manually.

            QuickEntry = False;
        }
        modify("Buy-from Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            QuickEntry = False;
        }
        modify("Buy-from City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';

            //Unsupported feature: Change ImplicitType on ""Buy-from City"(Control 93)". Please convert manually.

            QuickEntry = False;
        }
        modify("Buy-from Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            QuickEntry = False;
        }
        modify("Buy-from Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            QuickEntry = False;
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date of the vendor''s invoice.', FRA = 'Spécifie la date de la facture du fournisseur.';
            QuickEntry = False;
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date of the record.', FRA = 'Spécifie la date comptabilisation de l''enregistrement.';
            QuickEntry = False;
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies when the purchase invoice is due for payment.', FRA = 'Spécifie la date à laquelle la facture achat doit être payée.';
        }
        modify("Vendor Invoice No.")
        {
            ToolTipML = ENU = 'Specifies the vendor''s own invoice number.', FRA = 'Spécifie le numéro de facture propre au fournisseur.';
            Importance = Additional;
        }
        modify("Purchaser Code")
        {
            ToolTipML = ENU = 'Specifies which purchaser is associated with the order.', FRA = 'Spécifie l''acheteur associé à la commande.';
            QuickEntry = True;
        }
        modify("No. of Archived Versions")
        {
            QuickEntry = False;
        }
        modify("Order Date")
        {
            ToolTipML = ENU = 'Specifies the date when the item is ordered. It is calculated backwards from the Planned Receipt Date field in combination with the Lead Time Calculation field.', FRA = 'Spécifie la date de commande de l''article. Elle est calculée en amont à partir du champ Date planifiée de réception et du champ Délai de réappro.';
            QuickEntry = False;
        }
        modify("Quote No.")
        {
            CaptionML = ENU = 'Purchase Quote No.', FRA = 'N° devis ventes';

            //Unsupported feature: Change Description on ""Quote No."(Control 237)". Please convert manually.

        }
        modify("Vendor Order No.")
        {
            ToolTipML = ENU = 'Specifies the vendor''s order number.', FRA = 'Spécifie le numéro de commande du fournisseur.';
            QuickEntry = True;
        }
        // modify("Vendor Shipment No.")
        // {
        //    // ShowMandatory = VendorShipmentNoMandatory;
        // }

        //Unsupported feature: Change Description on "Status(Control 133)". Please convert manually.


        //Unsupported feature: Change Visible on "PurchLines(Control 60)". Please convert manually.

        modify("Invoice Details")
        {
            CaptionML = ENU = 'Invoice Details', FRA = 'Détails facture';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency of amounts on the purchase document.', FRA = 'Spécifie la devise des montants sur le document achat.';
        }
        modify("Expected Receipt Date")
        {
            ToolTipML = ENU = 'Specifies the date you expect the items to be available in your warehouse. If you leave the field blank, it will be calculated as follows: Planned Receipt Date + Safety Lead Time + Inbound Warehouse Handling Time = Expected Receipt Date.', FRA = 'Spécifie la date à laquelle les articles doivent être disponibles dans l''entrepôt. Si vous laissez ce champ vide, le calcul est effectué comme suit : Date planifiée de réception + Délai de sécurité + Délai enlogement + Date réception prévue.';
            Visible = false;//BC Upgarde SHARMP16-- PO page related changes
            //Unsupported feature: Change Description on ""Expected Receipt Date"(Control 54)". Please convert manually.

        }
        modify("Prices Including VAT")
        {
            ToolTipML = ENU = 'Specifies whether the unit price on the line should be displayed including or excluding VAT.', FRA = 'Spécifie si le prix unitaire de la ligne doit être affiché TTC ou hors taxes.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies which VAT business posting group was used when the VAT entry was posted.', FRA = 'Spécifie le groupe comptabilisation marché TVA utilisé lorsque l''écriture TVA a été validée.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies the code that represents the payment terms that apply to the purchase order.', FRA = 'Spécifie le code qui représente les conditions de paiement qui s''appliquent à la commande achat.';
        }
        modify("Payment Method Code")
        {
            ToolTipML = ENU = 'Specifies how payment for the purchase document must be submitted.', FRA = 'Spécifie la manière dont le paiement du document achat doit être réalisé.';
        }
        modify("Pmt. Discount Date")
        {
            ToolTipML = ENU = 'Specifies the last date on which the amount in the purchase order must be paid for the order to qualify for a payment discount.', FRA = 'Spécifie la dernière date à laquelle le montant de la commande achat doit être payé pour que la commande puisse faire l''objet d''un escompte.';
        }

        //Unsupported feature: Change Description on ""Shipment Method Code"(Control 52)". Please convert manually.


        //Unsupported feature: Change Editable on ""Shipment Method Code"(Control 52)". Please convert manually.

        modify("Sell-to Customer No.")
        {
            ToolTipML = ENU = 'Specifies the number of the customer that the items are shipped to directly from your vendor, as a drop shipment.', FRA = 'Spécifie le numéro du client à qui les articles sont livrés directement par votre fournisseur, en tant que livraison directe.';
        }
        modify("Shipping and Payment")
        {
            CaptionML = ENU = 'Shipping and Payment', FRA = 'Expédition et paiement';
        }

        modify("Ship-to Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify("Ship-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Ship-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the vendor''s buy-from address.', FRA = 'Spécifie l''adresse fournisseur du fournisseur.';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 44)". Please convert manually.

        }
        modify("Ship-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies an additional part of the vendor''s buy-from address.', FRA = 'Spécifie un complément à l''adresse fournisseur du fournisseur.';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 46)". Please convert manually.

        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify("Ship-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';

            //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 48)". Please convert manually.

        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }

        modify("Pay-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Pay-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the vendor''s buy-from address.', FRA = 'Spécifie l''adresse fournisseur du fournisseur.';

            //Unsupported feature: Change ImplicitType on ""Pay-to Address"(Control 26)". Please convert manually.

        }
        modify("Pay-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies an additional part of the vendor''s buy-from address.', FRA = 'Spécifie un complément à l''adresse fournisseur du fournisseur.';

            //Unsupported feature: Change ImplicitType on ""Pay-to Address 2"(Control 28)". Please convert manually.

        }
        modify("Pay-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify("Pay-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';

            //Unsupported feature: Change ImplicitType on ""Pay-to City"(Control 30)". Please convert manually.

        }
        modify("Pay-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
        }
        modify("Pay-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        }
        modify(Prepayment)
        {
            CaptionML = ENU = 'Prepayment', FRA = 'Acompte';
        }
        addafter(Status)
        {
            field("Creation Date/Time IBM"; Rec."Creation Date/Time IBM FND")
            {
                ApplicationArea = All;
            }
            field("Created By IBM"; Rec."Created By IBM FND")
            {
                ApplicationArea = All;
            }

        }

        //Unsupported feature: Change Editable on ""Prepayment %"(Control 197)". Please convert manually.


        //Unsupported feature: Change Editable on ""Compress Prepayment"(Control 199)". Please convert manually.


        //Unsupported feature: Change Editable on ""Prepmt. Payment Terms Code"(Control 215)". Please convert manually.


        //Unsupported feature: Change Editable on ""Prepmt. Payment Discount %"(Control 217)". Please convert manually.


        //Unsupported feature: CodeModification on ""Buy-from Vendor No."(Control 4).OnValidate". Please convert manually.

        //trigger "(Control 4)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
          if "Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
            SETRANGE("Buy-from Vendor No.");

        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
        if "Sundry Vendor" then
          ShowVendorSundryInfo();
        //>> DITW18.00.07 AKH DIT-770 #1804

        #1..5

        // <<DITW15.00.00.39 DDR 27/04/2011 #1323 (BE5.00.01)
        COMMIT;
        StdVendPurchCode.AutoInsertPurchLines(Rec);
        // >>DITW15.00.00.39 DDR #1323 (BE5.00.01)
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Responsibility Center"(Control 131)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        if "Responsibility Center" <> xRec."Responsibility Center" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 DDR DIT-770 #1191
        */
        //end;


        //Unsupported feature: CodeInsertion on "Status(Control 133)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        StatusOnValidate;
          StatusOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Control 104)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        if "Location Code" <> xRec."Location Code" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 DDR DIT-770 #1191
        */
        //end;

        modify("Promised Receipt Date")
        {
            Visible = false;
        }//BC Upgarde SHARMP16-- PO page related changes
        modify("Order Address Code")
        {
            Visible = false;
        }//BC Upgarde SHARMP16-- PO page related changes
        addafter("No. of Archived Versions")
        {
            field("Expected Receipt Date_Gen"; Rec."Expected Receipt Date")
            {
                ApplicationArea = all;
                Caption = 'Expected Receipt Date';
            }
            field("Promised Receipt Date_Gen"; Rec."Promised Receipt Date")
            {
                ApplicationArea = all;
                Caption = 'Promised Receipt Date';
            }
            field("Order Address Code_1"; Rec."Order Address Code")
            {
                ApplicationArea = all;
                Caption = 'Order Address Code';
            }
        }//BC Upgarde SHARMP16-- PO page related changes
        addafter("Buy-from Address 2")
        {
            field("House Number"; Rec."House Number FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the House Number field.';
            }
        }
        addafter("Buy-from City")
        {
            // field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
            // {
            //     CaptionML = ENU = 'Country/Region',
            //                 FRA = 'Pays/région';
            //     Importance = Additional;
            // }//BC upgrade SHARMP16--- Already on page
        }
        addafter("Document Date")
        {
            // field("Tax Date"; Rec."Tax Date")
            // {
            //     Importance = Additional;
            //     QuickEntry = false;
            // }//Bc upgrade SHARMP16-- Drink-IT fields
            // group(Control1100710018)
            // {
            //Bc upgrade SHARMP16 BEGIN>>-- Drink-IT fields
            //         field(RouteNew; Rec.Route)
            //         {
            //             Description = '<DITW18.00.07 DIT-770 #1968 - DITW19.00.08 BL#11231>--NRQ#16082';
            //             QuickEntry = true;
            //             ShowMandatory = RouteAsMandatory;

            //             trigger OnDrillDown();
            //             begin
            //                 //FIXME<<DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
            //                 DrillDownRouteCombinaison;
            //                 // >>DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
            //             end;
            //         }
            //         field(RoutePlanningNew; Rec."Route Planning No.")
            //         {
            //             Editable = false;
            //         }
            //     }
            //     field("Multiple Order Route"; Rec."Multiple Order Route")
            //     {
            //         Editable = false;
            //     }
            //     field("Vendor Tax Registration No."; Rec."Vendor Tax Registration No.")
            //     {
            //         Description = 'DITW15.00.00.28,DITW19.00.08 BL#10387';
            //         Editable = EditableVendorTax;
            //     }
            //     field("Vendor Tax Warehouse Ref."; Rec."Vendor Tax Warehouse Ref.")
            //     {
            //         Description = 'DITW15.00.00.38 #1217,DITW19.00.08 BL#10387';
            //         Editable = EditableVendorTax;
            //     }
            // }
            // addafter("Due Date")
            // {
            //     field("Disable DIT Disc. Prom."; Rec."Disable DIT Disc. Prom.")
            //     {
            //     }
            // }//Bc upgrade SHARMP16-- Drink-IT fields

            // addafter("Expected Receipt Date")
            // {
            //     field("Requested Receipt Date"; Rec."Requested Receipt Date")
            //     {
            //         Importance = Additional;
            //         QuickEntry = false;
            //     }
            //     field("Promised Receipt Date"; Rec."Promised Receipt Date")
            //     {
            //         Importance = Additional;
            //         QuickEntry = false;
            //     }
            //     field("Your Reference"; Rec."Your Reference")
            //     {
            //         Description = 'FINXL7.00.001';
            //     }
            // }//BC Upgrade SHARMP16-- already defined on page
        }
        addafter("Responsibility Center")
        {
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Description = '<DITW18.00.06 DIT-770 #1191>-NRQ#16082';
            //     Editable = EditableMultipleRouteOrder;
            //     Importance = Additional;
            //     QuickEntry = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
            //         if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
            //             CurrPage.UPDATE(true);
            //         // >>DITW18.00.06 DDR DIT-770 #1191
            //     end;
            // }//BC Upgrade SHARMP16-- Drink-It field
            // field(LocationCodeNew; Rec."Location Code")
            // {
            //     ApplicationArea = All;
            //     Description = 'NRQ#16082';
            //     QuickEntry = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
            //         // if rec."Location Code" <> xRec."Location Code" then
            //         //     CurrPage.UPDATE(true);//BC Upgrade SHARMP16-- Drink-IT code
            //         // >>DITW18.00.06 DDR DIT-770 #1191
            //     end;
            // }//BC Upgrade SHARMP16-- DRINK-IT field.
        }
        addafter("Assigned User ID")
        {
            field("Requester ID"; Rec."Requester ID IBM FND") // BC Upgrade BHARDA11 -- FDD STP 004 
            {
                ApplicationArea = All;
                Description = 'DITW17.00.02 DIT-770 #144';
            }//Bc upgrade SHARMP16 BEGIN>>-- Drink-IT fields
        }
        addafter(Status)
        {
            //BC Upgrade SHARMP16-Drink-it fields BEGIN>>
            //     field("Creation Date/Time"; Rec."Creation Date/Time")
            //     {
            //         Description = 'DITW18.00.07 DIT-770 #1282';
            //         Importance = Additional;
            //     }
            //     field("Created By"; Rec."Created By")
            //     {
            //         Description = 'DITW18.00.07 DIT-770 #1282';
            //         Importance = Additional;
            //     }
            //     field("Document Shipping Costs"; Rec.HasDocumentShippingCosts)
            //     {
            //         CaptionML = ENU = 'Document Shipping Costs',
            //                     FRA = 'Document Frais livraison';

            //         trigger OnDrillDown();
            //         begin
            //             //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
            //             OpenDocumentShippingCosts;
            //             //>> DITW18.00.07 VSC DIT-770 #1066
            //         end;
            //     }
            //     field("Emergency Order"; Rec."Emergency Order")
            //     {
            //     }
            //     field("PQ Approver"; Rec."PQ Approver")
            //     {
            //     }
            //     field("Last changed User ID"; Rec."Last changed User ID")
            //     {
            //         Editable = false;
            //     }
            //     field("Last changed Date/time"; Rec."Last changed Date/time")
            //     {
            //         Editable = false;
            //     }
            //     field("Linked Customer No."; Rec."Linked Customer No.")
            //     {
            //         Importance = Additional;
            //     }
            // }
            // addafter("Job Queue Status")
            // {
            //     field("Vendor DTax Group Code"; Rec."Vendor DTax Group Code")
            //     {
            //         Importance = Additional;
            //     }
            //     field("Receipt Status"; Rec."Receipt Status")
            //     {
            //         Description = 'DITW18.00.07 #1968';
            //     }//BC Upgrade SHARMP16-Drink-it fields ENd<<
            field("PQ Approver"; Rec."PQ Approver FND")
            {
                ApplicationArea = all;
            }//BC Upgrade SHARMP16-- Page formatting changes
            // BC Upgrade BHARAD11 >>
            field("Last Changed User ID IBM"; Rec."Last Changed User ID IBM FND")
            {
                ApplicationArea = All;
            }
            field("Last Changed Date/Time IBM"; Rec."Last Changed Date/Time IBM FND")
            {
                ApplicationArea = All;
            }
            // BC Upgrade BHARAD11 <<
            field("Purch. Reason Code"; Rec."Purch. Reason Code FND")
            {
                ApplicationArea = All;
                Caption = 'Purchase Reason Code';
                ToolTip = 'Specifies the value of the Purchase Reason Code field.';
            }
            field("BRC Purchase Order"; Rec."BRC Purchase Order FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the BRC Purchase Order field.';
            }
            field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Fixed Asset Acquisition field.';
            }
            // field("IC Document"; PurchaseHeaderAdditional."IC Document")
            // {
            //     Description = 'HEI.20';
            //     Editable = false;
            // }//BC Upgrade SHARMP16 --- Drink-IT field
            field("License Code"; PurchaseHeaderAdditional."License Code")
            {
                ApplicationArea = All;
                Editable = LicensiEdit;
                ToolTip = 'Specifies the value of the License Code field.';

                trigger OnDrillDown();
                begin
                    // Hei.21 >>
                    if LicensiEdit = true then begin
                        OldDimSetId := 0;
                        NewDImSetId := 0;
                        OldDimSetId := Rec."Dimension Set ID";
                        if Rec.Status = Rec.Status::Open then begin
                            GenLedSetRec.RESET();
                            GenLedSetRec.GET();
                            if GenLedSetRec."License Dimension Code FND" = '' then
                                ERROR(Text000);
                            DimValRec.RESET();
                            DimValRec.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                            CLEAR(DimValPage);
                            DimValPage.SETRECORD(DimValRec);
                            DimValPage.SETTABLEVIEW(DimValRec);
                            DimValPage.LOOKUPMODE(true);
                            if DimValPage.RUNMODAL() = ACTION::LookupOK then begin
                                DimValPage.GETRECORD(DimValRec);
                                LicenseCode := DimValRec.Code;
                                PurchaseHeaderAdditional.RESET();
                                if PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
                                    PurchaseHeaderAdditional."License Code" := DimValRec.Code;
                                    PurchaseHeaderAdditional."License Name" := DimValRec.Name; //HEI.51
                                                                                               //HEI.45 >>
                                    PurchaseHeaderAdditional."Bank who issued the License" := DimValRec."Bank issued the License FND";
                                    PurchaseHeaderAdditional."License Expiration Date" := DimValRec."License Expiration Date FND";
                                    PurchaseHeaderAdditional."CoD/CoC Number" := DimValRec."CoD/CoC Number FND";
                                    //HEI.45 <<
                                    PurchaseHeaderAdditional.MODIFY();
                                end;

                                DimValRec.GET(GenLedSetRec."License Dimension Code FND", LicenseCode);
                                DimMgt.GetDimensionSet(TempDimSetEntry, Rec."Dimension Set ID");
                                //>> HEI.28
                                if not TempDimSetEntry.GET(Rec."Dimension Set ID", GenLedSetRec."License Dimension Code FND") then begin
                                    TempDimSetEntry.INIT();
                                    TempDimSetEntry.VALIDATE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                    TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCode);
                                    TempDimSetEntry."Dimension Set ID" := Rec."Dimension Set ID";
                                    TempDimSetEntry."Dimension Value ID" := DimValRec."Dimension Value ID";
                                    TempDimSetEntry.INSERT();
                                    //IF NOT TempDimSetEntry.INSERT THEN
                                    //  TempDimSetEntry.MODIFY;
                                    //TempDimSetEntry.INSERT            (TRUE);
                                end else begin
                                    if xRec."License Code FND" <> LicenseCode then begin
                                        TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCode);
                                        TempDimSetEntry.MODIFY();
                                    end;
                                end;
                                //<< HEI.28
                                Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);

                                Rec.MODIFY();
                                NewDImSetId := Rec."Dimension Set ID";
                                //VALIDATE("License Code", DimValRec.Code);
                                //Updating All Lines
                                PurchLineRec.RESET();
                                PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
                                PurchLineRec.SETRANGE("Document No.", Rec."No.");
                                if PurchLineRec.FINDFIRST() then begin
                                    if not GUIALLOWED then
                                        rec.SetHideValidationDialog(true);
                                    COMMIT();
                                    UpdateAllLineDimNew(NewDImSetId, OldDimSetId);
                                end;

                            end;
                        end else
                            ERROR(Text003);
                    end else
                        ERROR(Text005, Rec."No.");
                    // Hei.21 <<
                end;

                trigger OnValidate();
                var
                    locTempDimensionSetEntry: Record "Dimension Set Entry" temporary;
                    locPurchaseHeaderAdditional: Record "Purchase Header Additional FND";
                    locPurchaseLine: Record "Purchase Line";
                begin
                    // Hei.27 >>
                    //HEI.27 >>
                    if rec."License Code FND" = '' then begin
                        GenLedSetRec.RESET();
                        GenLedSetRec.GET();

                        //IF GenLedSetRec."License Dimension Code" = '' THEN BEGIN //HEI.27
                        //>>HEI.27
                        //header
                        locTempDimensionSetEntry.RESET();
                        DimSetEntryRec_2.RESET();
                        DimSetEntryRec_2.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                        if DimSetEntryRec_2.findset() then begin
                            repeat
                                locTempDimensionSetEntry.INIT();
                                locTempDimensionSetEntry := DimSetEntryRec_2;
                                locTempDimensionSetEntry.INSERT();
                            until DimSetEntryRec_2.NEXT() = 0;
                        end;
                        locTempDimensionSetEntry.RESET();
                        locTempDimensionSetEntry.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                        if locTempDimensionSetEntry.FINDFIRST() then
                            locTempDimensionSetEntry.DELETE(true);

                        Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(locTempDimensionSetEntry);
                        Rec.MODIFY();
                        locTempDimensionSetEntry.RESET(); //HEI.54
                        locTempDimensionSetEntry.DELETEALL();

                        //lines
                        locPurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                        locPurchaseLine.SETRANGE("Document No.", Rec."No.");
                        locPurchaseLine.findset();
                        repeat
                            locTempDimensionSetEntry.RESET();
                            DimSetEntryRec_2.RESET();
                            DimSetEntryRec_2.SETRANGE("Dimension Set ID", locPurchaseLine."Dimension Set ID");
                            if DimSetEntryRec_2.findset() then begin
                                repeat
                                    locTempDimensionSetEntry.INIT();
                                    locTempDimensionSetEntry := DimSetEntryRec_2;
                                    locTempDimensionSetEntry.INSERT();
                                until DimSetEntryRec_2.NEXT() = 0;
                            end;
                            locTempDimensionSetEntry.RESET();
                            locTempDimensionSetEntry.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                            if locTempDimensionSetEntry.FINDFIRST() then
                                locTempDimensionSetEntry.DELETE(true);

                            locPurchaseLine."Dimension Set ID" := DimMgt.GetDimensionSetID(locTempDimensionSetEntry);
                            locPurchaseLine.MODIFY();
                            locTempDimensionSetEntry.DELETEALL();
                        until locPurchaseLine.NEXT() = 0;


                        //   DimSetEntryRec_2.RESET;
                        //   DimSetEntryRec_2.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
                        //   IF DimSetEntryRec_2.FINDFIRST THEN BEGIN
                        //     DimSetEntryRec_2.DELETE;
                        //     Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryRec_2);
                        //     Rec.MODIFY;
                        //   end;

                        if locPurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
                            locPurchaseHeaderAdditional."License Code" := '';
                            locPurchaseHeaderAdditional."License Name" := '';//HEI.52
                                                                             //HEI.53>>
                            locPurchaseHeaderAdditional."Bank who issued the License" := '';
                            locPurchaseHeaderAdditional."License Expiration Date" := 0D;
                            locPurchaseHeaderAdditional."CoD/CoC Number" := '';
                            //HEI.53<<
                            locPurchaseHeaderAdditional.MODIFY();
                        end;
                        //<< HEI.27
                        //end;
                    end;
                    //HEI.27 <<
                    GenLedSetRec.RESET();
                    GenLedSetRec.GET();
                    if GenLedSetRec."License Dimension Code FND" = '' then
                        ERROR(Text000);
                    //>> HEI.27
                    // DimValRec.RESET;
                    // DimValRec.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
                    // DimValRec.SETRANGE(Code,LicenseCode);
                    // IF NOT DimValRec.FINDFIRST THEN
                    //  ERROR(Text001);
                    //<< HEI.27
                    //Hei.27 <<
                    CurrPage.UPDATE();//HEI.54
                end;
            }
            field("Special Order No."; PurchaseHeaderAdditional."Special Order No.")
            {
                ApplicationArea = All;
                Description = 'HEI.27';
                Editable = false;
                ToolTip = 'Specifies the value of the Special Order No. field.';
            }
            field("IC Order No."; PurchaseHeaderAdditional."IC Order No.")
            {
                ApplicationArea = All;
                Description = 'HEI.23';
                Editable = false;
                ToolTip = 'Specifies the value of the IC Order No. field.';
            }
            field("Mail Sent"; PurchaseHeaderAdditional."Mail Sent")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Mail Sent field.';
            }
            field("Mail Sent Date Time"; PurchaseHeaderAdditional."Mail Sent Date Time")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Mail Sent Date Time field.';
            }
            // BC Upgrade SHUKLP03 >> Added in interface ext.
            // field("LSR Order No."; PurchaseHeaderAdditional."LSR Order No")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
            // BC Upgrade SHUKLP03 << Added in interface ext.
            field("TO Reference"; PurchaseHeaderAdditional."TO Reference")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the TO Reference field.';
            }
            field("Expctd Physical Delvry Date(Imp)"; PurchaseHeaderAdditional."Exp Physical Del Date(Imp)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Expected Physical Delivery Date(Imp) field.';
                trigger OnValidate();
                var
                    lrec_PurchHdrAdd: Record "Purchase Header Additional FND";
                    lrec_PurchLn: Record "Purchase Line";
                begin
                    //HEI.35>>
                    rec.TESTFIELD(Status, rec.Status::Open);
                    if (PurchaseHeaderAdditional."Exp Physical Del Date(Imp)" <> 0D) then begin
                        if lrec_PurchHdrAdd.GET(lrec_PurchHdrAdd."Document Type"::Order, rec."No.") then begin
                            lrec_PurchHdrAdd."Exp Physical Del Date(Imp)" := PurchaseHeaderAdditional."Exp Physical Del Date(Imp)";
                            lrec_PurchHdrAdd.MODIFY();
                            lrec_PurchLn.RESET();
                            lrec_PurchLn.SETRANGE("Document Type", lrec_PurchLn."Document Type"::Order);
                            lrec_PurchLn.SETRANGE("Document No.", rec."No.");
                            if lrec_PurchLn.findset() then
                                repeat
                                    lrec_PurchLn."Exp Physical Del Date(Imp) FND" := PurchaseHeaderAdditional."Exp Physical Del Date(Imp)";
                                    lrec_PurchLn.MODIFY();
                                until lrec_PurchLn.NEXT() = 0;
                        end;
                    end else begin
                        if (PurchaseHeaderAdditional."Exp Physical Del Date(Imp)" = 0D) then begin
                            if lrec_PurchHdrAdd.GET(lrec_PurchHdrAdd."Document Type"::Order, rec."No.") then begin
                                lrec_PurchHdrAdd."Exp Physical Del Date(Imp)" := 0D;
                                lrec_PurchHdrAdd.MODIFY();
                                lrec_PurchLn.RESET();
                                lrec_PurchLn.SETRANGE("Document Type", lrec_PurchLn."Document Type"::Order);
                                lrec_PurchLn.SETRANGE("Document No.", rec."No.");
                                if lrec_PurchLn.findset() then
                                    repeat
                                        lrec_PurchLn."Exp Physical Del Date(Imp) FND" := 0D;
                                        lrec_PurchLn.MODIFY();
                                    until lrec_PurchLn.NEXT() = 0;
                            end;
                        end;
                    end;
                    //HEI.35<<
                end;
            }
            // BC Upgrade SHUKLP03 >> Added in interface ext.
            // field("PurchaseHeaderAdditional.""WMS Export"""; PurchaseHeaderAdditional."WMS Export")
            // {
            //     ApplicationArea = All;
            //     Caption = 'WMS Export';
            //     Editable = false;
            // }
            // BC Upgrade SHUKLP03 << Added in interface ext.
        }
        addafter(PurchLines)
        {
            part(Control55005; "Purchase Order Subform SRM CBN")
            {
                ApplicationArea = Suite;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
                Visible = ShowSRMSubpage;
            }
        }
        addafter("Prices Including VAT")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            // field("Vendor Posting Group"; Rec."Vendor Posting Group")
            // {
            //     Editable = false;
            // }//BC Upgrade SHARMP16-already defined on page
            // field("Sundry Vendor"; Rec."Sundry Vendor")
            // {
            // }//BC Upgrade SHARMP16-Drink-it fields.
        }
        addafter("Ship-to City")
        {
            // field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
            // {
            //     CaptionML = ENU = 'Country/Region',
            //                 FRA = 'Pays/région';
            //     Importance = Additional;
            // }BC Upgrade SHARMP16-already defined in Base
        }
        //BC Upgrade SHARMP16-Drink-it fields BEGIN>>
        // addafter("Ship-to Code")
        // {
        //     field("Fiscal Representative No."; Rec."Fiscal Representative No.")
        //     {
        //     }
        //     field("Tax Office Code"; Rec."Tax Office Code")
        //     {
        //     }
        //     field("Journey Time"; Rec."Journey Time")
        //     {
        //     }
        //     field("Whse. Receipt No. (First)"; Rec."Whse. Receipt No. (First)")
        //     {
        //         Lookup = false;
        //     }
        //     field("Whse. Receipt Status (First)"; Rec."Whse. Receipt Status (First)")
        //     {
        //         DrillDown = false;
        //         Lookup = false;
        //     }//BC Upgrade SHARMP16-Drink-it fields ENd<<
        //}
        addafter("Pay-to City")
        {
            // field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
            // {
            //     CaptionML = ENU = 'Country/Region',
            //                 FRA = 'Pays/région';
            //     Importance = Additional;
            // }//BC Upgrade SHARMP16-- already on page
        }
        addafter("Pay-to Contact")
        {
            field("Vendor Bank Account"; Rec."Vendor Bank Account FND")
            {
                ApplicationArea = All;
                ShowMandatory = true;
                ToolTip = 'Specifies the value of the Vendor Bank Account field.';
            }
            field(IBAN; Rec."IBAN FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the IBAN field.';
            }
        }
        addafter("Vendor Cr. Memo No.")
        {
            // BC Upgrade VAMSIU01 - Document Subtype Code Field Added >>
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                ApplicationArea = All;
            }
            // BC Upgrade VAMSIU01 - Document Subtype Code Field Added <<
        }

        //BC Upgrade SHARMP16 BEGIN>> --- PO formatting changes
        modify("Transaction Type")
        {
            Visible = false;//BC Upgarde SHARMP16-- PO page related changes
        }
        addafter("Payment Method Code")
        {
            field("Transaction Type_Gen"; Rec."Transaction Type")
            {
                ApplicationArea = all;
            }
        }//BC Upgarde SHARMP16-- PO page related changes
        addbefore("Shipment Method Code")
        {
            field("Location Code_Copy"; Rec."Location Code")
            {
                ApplicationArea = all;
            }
        }//BC Upgarde SHARMP16-- PO page related changes

        addafter("Lead Time Calculation")
        {
            field("Sell-to Customer No._gen"; Rec."Sell-to Customer No.")
            {
                ApplicationArea = all;
            }
        }
        //BC Upgrade SHARMP16 END<< --- PO formatting changes
        // BC Upgrade BHARAD11 >> --FDD STP 002
        addafter("Vendor Invoice No.")
        {
            field("Business Group 104FDW"; Rec."Business Group 104FDW")
            {
                ApplicationArea = All;
            }
            field("Vendor Posting Grp 104FDW"; Rec."Vendor Posting Grp 104FDW")
            {
                ApplicationArea = All;
            }
            field("Vendor Tax Registration No."; Rec."Vendor Tx Registration No. FND")
            {
                ApplicationArea = All;
            }
        }
        // BC Upgrade BHARAD11 << --FDD STP 002
        addafter(Prepayment)
        {
            group(Receiving)
            {
                CaptionML = ENU = 'Receiving',
                            FRA = 'Recéption';
                //BC Upgrade SHARMP16-Drink-it fields BEGIN>>
                // field(Route; Rec.Route)
                // {
                //     Description = '<DITW18.00.07 DIT-770 #1968 - DITW19.00.08 BL#11231>-NRQ#16082';

                //     trigger OnDrillDown();
                //     begin
                //         //<< DITW18.00.07 VSC 09/05/2016 DIT-770 #1968
                //         DrillDownRouteCombinaison;
                //     end;
                // }
                // field("Route Planning No."; Rec."Route Planning No.")
                // {
                //     Editable = false;
                // }
                // field("Shipping Agent Code"; Rec."Shipping Agent Code")
                // {
                //     Description = '<DITW15.00.00.21 - DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
                //     Editable = EditableMultipleRouteOrder;

                //     trigger OnValidate();
                //     begin
                //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                //         if xRec."Shipping Agent Code" <> Rec."Shipping Agent Code" then
                //             CurrPage.UPDATE
                //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                //     end;
                // }
                // field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                // {
                //     Description = '<DITW15.00.00.21>-NRQ#16082';
                //     Editable = EditableMultipleRouteOrder;
                // }
                // field("Copy Shipment Method Code"; Rec."Shipment Method Code")
                // {
                //     Description = '-NRQ#16082';
                //     Editable = EditableMultipleRouteOrder;
                // }
                // field("PurchaseHeaderAdditional.""Import Identifier"""; PurchaseHeaderAdditional."Import Identifier")
                // {
                //     Caption = 'Import Identifier';
                //     Editable = false;
                // }
                // field(Distance; Rec.Distance)
                // {
                //     Description = '<DITW15.00.00.24>--NRQ#16082';
                // }
                // field("Truck Code"; Rec."Truck Code")
                // {
                //     Description = '<DITW18.00.07 DIT-770 #1968>-NRQ#16082';
                //     Editable = EditableMultipleRouteOrder;

                //     trigger OnValidate();
                //     begin
                //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                //         if xRec."Truck Code" <> Rec."Truck Code" then
                //             CurrPage.UPDATE
                //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                //     end;
                // }
                // field("Trailer Code"; Rec."Trailer Code")
                // {
                //     Description = '<DITW18.00.07 DIT-770 #1968>-NRQ#16082';
                //     Editable = EditableMultipleRouteOrder;
                // }
                // field("Driver Code"; Rec."Driver Code")
                // {
                //     Description = '<DITW18.00.07 DIT-770 #1968>-NRQ#16082';
                //     Editable = EditableMultipleRouteOrder;

                //     trigger OnValidate();
                //     begin
                //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                //         if xRec."Truck Code" <> Rec."Truck Code" then
                //             CurrPage.UPDATE
                //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                //     end;
                // }
                // field("Truck Zone"; Rec."Truck Zone")
                // {
                //     Description = 'DITW18.00.07 #1968-NRQ#16082';
                // }
                // field("Require 2 Drivers"; Rec."Require 2 Drivers")
                // {
                //     Description = '<DITW18.00.07 DIT-770 #1968>-NRQ#16082';
                //     Editable = EditableMultipleRouteOrder;
                // }
                // field("Driver 2 Code"; Rec."Driver 2 Code")
                // {
                //     Description = '<DITW18.00.07 DIT-770 #1968>-NRQ#16082';
                //     Editable = EditableMultipleRouteOrder;
                // }
                // field("Delivery Sequence"; Rec."Delivery Sequence")
                // {
                //     Description = 'DITW18.00.07 #1968';
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
                // field("Total Weight"; Rec."Total Weight")
                // {
                //     Editable = false;
                // }
                // field("Total Cubage"; Rec."Total Cubage")
                // {
                //     Editable = false;
                // }
                // field("Delivery Time 1 From"; Rec."Delivery Time 1 From")
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
                // }//BC Upgrade SHARMP16-Drink-it fields ENd<<
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the document.';
                }
                //BC Upgrade SHARMP16-Drink-it fields BEGIN>>
                // field("Vendor Delivery Type"; Rec."Vendor Delivery Type")
                // {
                // }
                // field("Delivery Time (sec.)"; Rec."Delivery Time (sec.)")
                // {
                // }//BC Upgrade SHARMP16-Drink-it fields ENd<<
            }

            group("Service/Contract")
            {
                CaptionML = ENU = 'Service/Contract',
                            FRA = 'Service/ Contrat';
                //BC Upgrade SHARMP16-Drink-it fields BEGIN>>
                // field("Contract Type"; Rec."Contract Type")
                // {
                //     Editable = false;
                // }
                // field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
                // {
                // }
                // field("Service Contract No."; Rec."Service Contract No.")
                // {
                //     Visible = false;
                // }
                // field("Financial Contract No."; Rec."Financial Contract No.")
                // {
                //     Visible = false;
                // }
                // field("Contract Group Code"; Rec."Contract Group Code")
                // {
                // }//BC Upgrade SHARMP16-Drink-it fields ENd>>
            }
            //BC Upgrade SHARMP16 BEGIN>>--- Interface related fields....
            //     group(Maximo)
            //     {
            //         Caption = 'Maximo';
            //         field("Maximo Requisition No."; Rec."Maximo Requisition No.")
            //         {
            //             ApplicationArea = All;
            //         }
            //         field("Maximo Status"; Rec."Maximo Status")
            //         {
            //             ApplicationArea = All;
            //             Editable = MaximoStatusIsEditable;
            //         }
            //     }
            //     group(SRM)
            //     {
            //         Caption = 'SRM';
            //         field("SRM Contract No."; Rec."SRM Contract No.")
            //         {
            //             ApplicationArea = All;
            //         }
            //         field("SRM Contract Name"; Rec."SRM Contract Name")
            //         {
            //         }
            //         field("SRM Contract Type"; Rec."SRM Contract Type")
            //         {
            //         }
            //         field("Valid From"; Rec."Valid From")
            //         {
            //         }
            //         field("Valid To"; Rec."Valid To")
            //         {
            //         }
            //         field("Shopping Card No."; Rec."Shopping Card No.")
            //         {
            //         }
            //         field("Shopping Card Creation Date"; PurchaseHeaderAdditional."Shopping Card Creation Date")
            //         {
            //         }
            //         field("Shipment Method Location"; Rec."Shipment Method Location")
            //         {
            //         }
            //         field(Channel; Rec.Channel)
            //         {
            //         }
            //         field(Closed; Rec.Closed)
            //         {
            //         }
            //         field("SRM Order No."; Rec."SRM Order No.")
            //         {
            //         }
            //         field("Target Value Currency"; Rec."Target Value Currency")
            //         {
            //         }
            //         field("Target Value Amount"; Rec."Target Value Amount")
            //         {
            //         }
            //         field("PurchaseHeaderAdditional.""Limit PO"""; PurchaseHeaderAdditional."Limit PO")
            //         {
            //             Caption = 'Limit PO';
            //             Editable = false;
            //         }
            //     }
            //     group(Ibecor)
            //     {
            //         Caption = 'Ibecor';
            //         Visible = EnableIbecorInterface;
            //         field("PurchaseHeaderAdditional.""PFI Document No."""; PurchaseHeaderAdditional."PFI Document No.")
            //         {
            //             Caption = 'PFI Document No.';
            //             Editable = false;
            //         }
            //         field("PurchaseHeaderAdditional.""Ibecor Dossier No."""; PurchaseHeaderAdditional."Ibecor Dossier No.")
            //         {
            //             Caption = 'Ibecor Dossier No.';
            //             Editable = false;
            //         }
            //         group("Letter of Credit Information")
            //         {
            //             Caption = 'Letter of Credit Information';
            //             field("PurchaseHeaderAdditional.""Credit Info Required"""; PurchaseHeaderAdditional."Credit Info Required")
            //             {
            //                 Caption = 'Credit Information Required';
            //                 Enabled = false;
            //             }
            //             field("PurchaseHeaderAdditional.""Credit Number"""; PurchaseHeaderAdditional."Credit Number")
            //             {
            //                 Caption = 'Credit Number';

            //                 trigger OnValidate();
            //                 var
            //                     lrecPurchAddtnlHdr: Record "Purchase Header Additional FND";
            //                 begin
            //                     //HEI.36>>
            //                     //Free Text anytime can be modified
            //                     if (PurchaseHeaderAdditional."Credit Number" <> '') then begin
            //                         if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
            //                             lrecPurchAddtnlHdr."Credit Number" := PurchaseHeaderAdditional."Credit Number";
            //                             lrecPurchAddtnlHdr.MODIFY;
            //                         end
            //                     end else begin
            //                         if (PurchaseHeaderAdditional."Credit Number" = '') then begin
            //                             if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
            //                                 lrecPurchAddtnlHdr."Credit Number" := '';
            //                                 lrecPurchAddtnlHdr.MODIFY;
            //                             end;
            //                         end;
            //                     end;
            //                     //HEI.36<<
            //                 end;
            //             }
            //             field("PurchaseHeaderAdditional.""Credit Amount Of supplier"""; PurchaseHeaderAdditional."Credit Amount Of supplier")
            //             {
            //                 Caption = 'Credit Amount Of Supplier';

            //                 trigger OnValidate();
            //                 var
            //                     lrecPurchAddtnlHdr: Record "Purchase Header Additional FND";
            //                 begin
            //                     //HEI.36>>
            //                     //Free Text anytime can be modified
            //                     if (PurchaseHeaderAdditional."Credit Amount Of supplier" <> 0) then begin
            //                         if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
            //                             lrecPurchAddtnlHdr."Credit Amount Of supplier" := PurchaseHeaderAdditional."Credit Amount Of supplier";
            //                             lrecPurchAddtnlHdr.MODIFY;
            //                         end
            //                     end else begin
            //                         if (PurchaseHeaderAdditional."Credit Amount Of supplier" = 0) then begin
            //                             if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
            //                                 lrecPurchAddtnlHdr."Credit Amount Of supplier" := 0;
            //                                 lrecPurchAddtnlHdr.MODIFY;
            //                             end;
            //                         end;
            //                     end;
            //                     //HEI.36<<
            //                 end;
            //             }
            //             field("PurchaseHeaderAdditional.""Bank Who Issued Credit"""; PurchaseHeaderAdditional."Bank Who Issued Credit")
            //             {
            //                 Caption = 'Bank Who Issued Credit';

            //                 trigger OnValidate();
            //                 var
            //                     lrecPurchAddtnlHdr: Record "Purchase Header Additional FND";
            //                 begin
            //                     //HEI.36>>
            //                     //Free Text anytime can be modified
            //                     if (PurchaseHeaderAdditional."Bank Who Issued Credit" <> '') then begin
            //                         if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
            //                             lrecPurchAddtnlHdr."Bank Who Issued Credit" := PurchaseHeaderAdditional."Bank Who Issued Credit";
            //                             lrecPurchAddtnlHdr.MODIFY;
            //                         end
            //                     end else begin
            //                         if (PurchaseHeaderAdditional."Bank Who Issued Credit" = '') then begin
            //                             if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
            //                                 lrecPurchAddtnlHdr."Bank Who Issued Credit" := '';
            //                                 lrecPurchAddtnlHdr.MODIFY;
            //                             end;
            //                         end;
            //                     end;
            //                     //HEI.36<<
            //                 end;
            //             }
            //             field("PurchaseHeaderAdditional.""Last Date Of Shipment"""; PurchaseHeaderAdditional."Last Date Of Shipment")
            //             {
            //                 Caption = 'Last Date Of Shipment';

            //                 trigger OnValidate();
            //                 var
            //                     lrecPurchAddtnlHdr: Record "Purchase Header Additional FND";
            //                 begin
            //                     //HEI.36>>
            //                     //Free Text anytime can be modified
            //                     if (PurchaseHeaderAdditional."Last Date Of Shipment" <> 0D) then begin
            //                         if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
            //                             lrecPurchAddtnlHdr."Last Date Of Shipment" := PurchaseHeaderAdditional."Last Date Of Shipment";
            //                             lrecPurchAddtnlHdr.MODIFY;
            //                         end
            //                     end else begin
            //                         if (PurchaseHeaderAdditional."Last Date Of Shipment" = 0D) then begin
            //                             if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
            //                                 lrecPurchAddtnlHdr."Last Date Of Shipment" := 0D;
            //                                 lrecPurchAddtnlHdr.MODIFY;
            //                             end;
            //                         end;
            //                     end;
            //                     //HEI.36<<
            //                 end;
            //             }
            //             field("PurchaseHeaderAdditional.""Credit Validity Date"""; PurchaseHeaderAdditional."Credit Validity Date")
            //             {
            //                 Caption = 'Credit Validity Date';

            //                 trigger OnValidate();
            //                 var
            //                     lrecPurchAddtnlHdr: Record "Purchase Header Additional FND";
            //                 begin
            //                     //HEI.36>>
            //                     //Free Text anytime can be modified
            //                     if (PurchaseHeaderAdditional."Credit Validity Date" <> 0D) then begin
            //                         if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
            //                             lrecPurchAddtnlHdr."Credit Validity Date" := PurchaseHeaderAdditional."Credit Validity Date";
            //                             lrecPurchAddtnlHdr.MODIFY;
            //                         end
            //                     end else begin
            //                         if (PurchaseHeaderAdditional."Credit Validity Date" = 0D) then begin
            //                             if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
            //                                 lrecPurchAddtnlHdr."Credit Validity Date" := 0D;
            //                                 lrecPurchAddtnlHdr.MODIFY;
            //                             end;
            //                         end;
            //                     end;
            //                     //HEI.36<<
            //                 end;
            //             }
            //             field(BankReferenceNumber; PurchaseHeaderAdditional."Bank Reference Number")
            //             {
            //                 Caption = 'Bank Reference Number';

            //                 trigger OnValidate();
            //                 var
            //                     lrecPurchAddtnlHdr: Record "Purchase Header Additional FND";
            //                 begin
            //                     //HEI.46 >>
            //                     if lrecPurchAddtnlHdr.GET(PurchaseHeaderAdditional."Document Type", PurchaseHeaderAdditional."No.") then begin
            //                         lrecPurchAddtnlHdr."Bank Reference Number" := PurchaseHeaderAdditional."Bank Reference Number";
            //                         lrecPurchAddtnlHdr.MODIFY;
            //                         CurrPage.UPDATE(false);
            //                     end;
            //                     //HEI.46 <<
            //                 end;
            //             }

            //             group("License Information")
            //             {
            //                 Caption = 'License Information';
            //                 field("PurchaseHeaderAdditional.""License Required"""; PurchaseHeaderAdditional."License Required")
            //                 {
            //                     Caption = 'License Required';
            //                     Enabled = false;
            //                 }
            //                 field("PurchaseHeaderAdditional.""License Name"""; PurchaseHeaderAdditional."License Name")
            //                 {
            //                     Caption = 'License Code';
            //                     Editable = false;
            //                 }
            //                 field("PurchaseHeaderAdditional.""Bank who issued the License"""; PurchaseHeaderAdditional."Bank who issued the License")
            //                 {
            //                     Caption = 'Bank Name';
            //                     Editable = false;
            //                 }
            //                 field("PurchaseHeaderAdditional.""License Expiration Date"""; PurchaseHeaderAdditional."License Expiration Date")
            //                 {
            //                     Caption = 'Date Validity License';
            //                     Editable = false;
            //                 }
            //                 field("PurchaseHeaderAdditional.""CoD/CoC Number"""; PurchaseHeaderAdditional."CoD/CoC Number")
            //                 {
            //                     Caption = 'CoD/CoC Number';
            //                     Editable = false;
            //                 }
            //             }
            //             group("Other Information")
            //             {
            //                 Caption = 'Other Information';
            //                 field("PurchaseHeaderAdditional.""Expected Date Departure"""; PurchaseHeaderAdditional."Expected Date Departure")
            //                 {
            //                     Caption = 'Expected Date Departure';
            //                 }
            //                 field("PurchaseHeaderAdditional.""Departure Date"""; PurchaseHeaderAdditional."Departure Date")
            //                 {
            //                     Caption = 'Departure Date';
            //                 }
            //                 field("PurchaseHeaderAdditional.""Date Orig. Docs Sent"""; PurchaseHeaderAdditional."Date Orig. Docs Sent")
            //                 {
            //                     Caption = 'Date Orig. Docs Sent';
            //                 }
            //                 field("PurchaseHeaderAdditional.""Date Copy Docs Sent"""; PurchaseHeaderAdditional."Date Copy Docs Sent")
            //                 {
            //                     Caption = 'Date Copy Docs Sent';
            //                 }
            //                 field("PurchaseHeaderAdditional.""Order Form To Supplier Date"""; PurchaseHeaderAdditional."Order Form To Supplier Date")
            //                 {
            //                     Caption = 'Order Form To Supplier Date';
            //                 }
            //                 field("PurchaseHeaderAdditional.""Expected Date to Ex Works"""; PurchaseHeaderAdditional."Expected Date to Ex Works")
            //                 {
            //                     Caption = 'Expected Date to Ex Works';
            //                 }
            //                 field("PurchaseHeaderAdditional.""Vessel Name"""; PurchaseHeaderAdditional."Vessel Name")
            //                 {
            //                     Caption = 'Vessel Name';
            //                 }
            //                 field("PurchaseHeaderAdditional.""Expected Date Arrival"""; PurchaseHeaderAdditional."Expected Date Arrival")
            //                 {
            //                     Caption = 'Expected Date Arrival';
            //                 }
            //                 field("PurchaseHeaderAdditional.""B/L-AWB"""; PurchaseHeaderAdditional."B/L-AWB")
            //                 {
            //                     Caption = 'B/L-AWB';
            //                 }
            //                 field("PurchaseHeaderAdditional.""Shipment Description"""; PurchaseHeaderAdditional."Shipment Description")
            //                 {
            //                     Caption = 'Shipment Description';
            //                 }
            //                 field("PurchaseHeaderAdditional.""Order No."""; PurchaseHeaderAdditional."Order No.")
            //                 {
            //                     Caption = 'Shipment No.';
            //                     Editable = false;
            //                 }
            //                 field("PurchaseHeaderAdditional.""Tracking Information"""; PurchaseHeaderAdditional."Tracking Information")
            //                 {
            //                     Caption = 'Tracking Information';
            //                 }
            //                 field("PurchaseHeaderAdditional.""Reference SDV"""; PurchaseHeaderAdditional."Reference SDV")
            //                 {
            //                     Caption = 'Reference SDV';
            //                 }
            //                 field("PurchaseHeaderAdditional.""Date Receipt Docs Supplier"""; PurchaseHeaderAdditional."Date Receipt Docs Supplier")
            //                 {
            //                     Caption = 'Date Receipt Docs Supplier';
            //                     Importance = Additional;
            //                 }
            //                 field("PurchaseHeaderAdditional.""Date Receipt Docs Forwarder"""; PurchaseHeaderAdditional."Date Receipt Docs Forwarder")
            //                 {
            //                     Caption = 'Date Receipt Docs Forwarder';
            //                     Importance = Additional;
            //                 }
            //                 field("PurchaseHeaderAdditional.""Volume in m3"""; PurchaseHeaderAdditional."Volume in m3")
            //                 {
            //                     Caption = 'Volume in m3';
            //                     Importance = Additional;
            //                 }
            //                 field("PurchaseHeaderAdditional.""Nbr cont. 20 feet"""; PurchaseHeaderAdditional."Nbr cont. 20 feet")
            //                 {
            //                     Caption = 'Nbr cont. 20 feet';
            //                     Importance = Additional;
            //                 }
            //                 field("PurchaseHeaderAdditional.""Nbr cont. 40 feet"""; PurchaseHeaderAdditional."Nbr cont. 40 feet")
            //                 {
            //                     Caption = 'Nbr cont. 40 feet';
            //                     Importance = Additional;
            //                 }
            //                 field("PurchaseHeaderAdditional.""Arrival Date Destination Port"""; PurchaseHeaderAdditional."Arrival Date Destination Port")
            //                 {
            //                     Caption = 'Date Of Arrival in Port of Destination';
            //                     Importance = Additional;
            //                 }
            //             }
            //         }
            //         group("Astro WMS")
            //         {
            //             Caption = 'Astro WMS';
            //             Visible = AstroRemovalVisibility;
            //             field("PurchaseHeaderAdditional.""Astro WMS PO"""; PurchaseHeaderAdditional."Astro WMS PO")
            //             {
            //                 Caption = 'Astro WMS PO';
            //                 Visible = false;
            //             }
            //             // field("Enter Astro Unique ID to Remove"; Rec.EnterUniqueid)
            //             // {
            //             // }//BC Upgrade SHARMP16--- Astro related out of scope.
            //         }
            //         group("Zycus Interface")
            //         {
            //             Caption = 'Zycus Interface';
            //             Visible = VisibleZycusInterface;
            //             field("PurchaseHeaderAdditional.""Zycus Order No."""; PurchaseHeaderAdditional."Zycus Order No.")
            //             {
            //                 Caption = 'Zycus Order No.';
            //                 Editable = false;
            //             }
            //             group("Zycus PO Interface")
            //             {
            //                 Caption = 'Zycus PO Interface';
            //                 field("PurchaseHeaderAdditional.""PO Transaction Interface Zycus"""; PurchaseHeaderAdditional."PO Transaction Interface Zycus")
            //                 {
            //                     Caption = 'PO Transaction Interface Zycus';
            //                     Editable = false;
            //                 }
            //                 field("PurchaseHeaderAdditional.""Processed PO Transaction Zycus"""; PurchaseHeaderAdditional."Processed PO Transaction Zycus")
            //                 {
            //                     Caption = 'Processed PO Transaction Zycus';
            //                     Editable = false;
            //                 }
            //             }
            //             group("Zycus GR Interface")
            //             {
            //                 Caption = 'Zycus GR Interface';
            //                 field("PurchaseHeaderAdditional.""Zycus GR UUID"""; PurchaseHeaderAdditional."Zycus GR UUID")
            //                 {
            //                     Caption = 'Zycus GR UUID';
            //                     Editable = false;
            //                 }
            //                 field("PurchaseHeaderAdditional.""GR Transaction Interface Zycus"""; PurchaseHeaderAdditional."GR Transaction Interface Zycus")
            //                 {
            //                     Caption = 'GR Transaction Interface Zycus';
            //                     Editable = false;
            //                 }
            //                 field("PurchaseHeaderAdditional.""Processed GR Transaction Zycus"""; PurchaseHeaderAdditional."Processed GR Transaction Zycus")
            //                 {
            //                     Caption = 'Processed GR Transaction Zycus';
            //                     Editable = false;
            //                 }
            //             }
            //         }
            //     }
            // BC Upgrade SHARMP16 end<< ----- Interface related fields.
        }
        addafter(Control1901138007)
        {
            // part(Control1907232107; "Purchase Line FactBox2")
            // {
            //     Provider = "60";
            //     SubPageLink = "Document Type" = FIELD("Document Type"),
            //                   "Document No." = FIELD("Document No."),
            //                   "Line No." = FIELD("Line No.");
            //     Visible = true;
            // }//BC upgrade SHARMP16-- Compile later
        }

    }
    actions
    {
        modify("O&rder")
        {
            CaptionML = ENU = 'O&rder', FRA = '&Commande';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }


        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Documents)
        {
            CaptionML = ENU = 'Documents', FRA = 'Documents';
        }
        modify(Receipts)
        {
            CaptionML = ENU = 'Receipts', FRA = 'Bons de réception';
        }
        modify(Invoices)
        {
            CaptionML = ENU = 'Invoices', FRA = 'Factures';
        }
        modify(PostedPrepaymentInvoices)
        {
            CaptionML = ENU = 'Prepa&yment Invoices', FRA = 'Factures acom&pte';
        }
        modify(PostedPrepaymentCrMemos)
        {
            CaptionML = ENU = 'Prepayment Credi&t Memos', FRA = 'A&voirs acompte';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("In&vt. Put-away/Pick Lines")
        {
            CaptionML = ENU = 'In&vt. Put-away/Pick Lines', FRA = 'Lignes prélè&v./rangement stock';
        }
        modify("Whse. Receipt Lines")
        {
            CaptionML = ENU = 'Whse. Receipt Lines', FRA = 'Lignes réception entrep.';
        }
        modify("Dr&op Shipment")
        {
            CaptionML = ENU = 'Dr&op Shipment', FRA = 'Livraison &directe';
        }
        modify("Warehouse_GetSalesOrder")
        {
            CaptionML = ENU = 'Get &Sales Order', FRA = 'Ex&traire commande vente';
            ToolTipML = ENU = 'Select the sales order that must be linked to the purchase order, for drop shipment. ', FRA = 'Sélectionnez la commande vente à associer à la commande achat pour une livraison directe. ';
        }
        modify("Speci&al Order")
        {
            CaptionML = ENU = 'Speci&al Order', FRA = 'C&ommande spéciale';
        }
        modify("Get &Sales Order")
        {
            CaptionML = ENU = 'Get &Sales Order', FRA = 'Ex&traire commande vente';
        }
        modify(Approval)
        {
            CaptionML = ENU = 'Approval', FRA = 'Approbation';
        }
        modify(Approve)
        {
            CaptionML = ENU = 'Approve', FRA = 'Approuver';
            ToolTipML = ENU = 'Approve the requested changes.', FRA = 'Approuvez les modifications demandées.';
        }
        modify(Reject)
        {
            CaptionML = ENU = 'Reject', FRA = 'Rejeter';
        }
        modify(Delegate)
        {
            CaptionML = ENU = 'Delegate', FRA = 'Déléguer';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comments', FRA = 'Commentaires';
        }

        modify(Release)
        {
            CaptionML = ENU = 'Re&lease', FRA = '&Lancer';
            trigger OnBeforeAction()
            var
                FinanceUtil: Codeunit "Financial-Utils";
            begin
                //HEI.50>>
                FinanceUtil.OnBeforeSendPurchaseOrderApprovalRequest(Rec);
                //HEI.50<<
                //>>HEI.39
                CheckCMGMandatory();
                //<<HEI.39
                // //Hei.32
                PurchasesPSetup.GET;//BCUpgrade sharmp16--PurchaseProcesstestchanges
                // IF PurchasesPSetup."Requester ID Mandatory" THEN BEGIN
                //     IF rec."SRM Order No." = '' THEN;
                //     // Rec.TESTFIELD("Requester ID");//BC Upgrade SHARMP16-- DRink-IT field
                // end;
                // //Hei.32

                //HEI.35>>
                IF PurchaseHeaderAdditional.GET(rec."Document Type"::Order, rec."No.") THEN BEGIN
                    IF PurchaseHeaderAdditional."Import Identifier" THEN BEGIN
                        rec.TESTFIELD("Location Code");
                        PurchaseHeaderAdditional.TESTFIELD("Exp Physical Del Date(Imp)");
                        PurchLineRec.RESET();
                        PurchLineRec.SETRANGE("Document Type", PurchLineRec."Document Type"::Order);
                        PurchLineRec.SETRANGE("Document No.", rec."No.");
                        PurchLineRec.SETRANGE(Type, PurchLineRec.Type::Item);
                        IF PurchLineRec.findset() THEN
                            REPEAT
                                PurchLineRec.TESTFIELD("Exp Physical Del Date(Imp) FND");
                                IF (PurchLineRec."Location Code" <> PurchasesPSetup."Location Code Imp Proc. FND") THEN
                                    ERROR(Text50000, PurchLineRec."Document No.", PurchLineRec."Line No.", PurchasesPSetup."Location Code Imp Proc. FND");
                                IF (PurchLineRec."Location Code" = rec."Location Code") THEN
                                    ERROR(Text50001, PurchLineRec."Document No.");
                            UNTIL PurchLineRec.NEXT() = 0;
                    end;
                end;
                //HEI.35<<

                //HEI.21 >>
                GenLedSetRec.RESET();
                GenLedSetRec.GET();
                IF GenLedSetRec."License Dimension Code FND" <> '' THEN BEGIN
                    CLEAR(LicenseCodeValue);
                    PurchRec.RESET();
                    PurchRec.SETRANGE("Document Type", Rec."Document Type");
                    PurchRec.SETRANGE("No.", Rec."No.");
                    IF PurchRec.FINDFIRST() THEN BEGIN
                        DimSetEntryRec.RESET();
                        DimSetEntryRec.SETRANGE("Dimension Set ID", PurchRec."Dimension Set ID");
                        DimSetEntryRec.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                        IF DimSetEntryRec.FINDFIRST() THEN
                            LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
                    end;
                    CLEAR(LicenseCodeValue_1);
                    PurchLineRec.RESET();
                    PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
                    PurchLineRec.SETRANGE("Document No.", Rec."No.");
                    IF PurchLineRec.FINDFIRST() THEN BEGIN
                        REPEAT
                            DimSetEntryRec_1.RESET();
                            DimSetEntryRec_1.SETRANGE("Dimension Set ID", PurchLineRec."Dimension Set ID");
                            DimSetEntryRec_1.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                            IF DimSetEntryRec_1.FINDFIRST() THEN
                                LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

                            IF LicenseCodeValue_1 <> '' THEN BEGIN
                                IF LicenseCodeValue <> LicenseCodeValue_1 THEN
                                    ERROR(Text004);
                            end;
                        UNTIL PurchLineRec.NEXT() = 0;
                    end;
                end;
                //HEI.21 <<
                // <<DITW15.00.00.23.04 DDR 15/09/2008 - DITW15.00.00.36 DDR 07/12/2009
                CurrPage.UPDATE(TRUE);
                // >>DITW15.00.00.23.04 DDR
                // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
                //ReleasePurchDoc.PerformManualRelease(Rec);
                //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
                // IF "Sundry Vendor" THEN
                //     TestSundryMandatoryFields();
                // //>> DITW18.00.07 DIT-770 #1804
                // ReleasePurchDoc.DocStatusRelease(xRec, Rec);
                // CurrPage.UPDATE;//BC Upgrade SHARMP16 -- Drink_IT fields
                // >>DITW15.00.00.39 DDR #1330 #1407


            end;

            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                //HEI.35>>
                IF rec.Status = rec.Status::Released THEN
                    g_CU_PurchasesUtils.ManageTOfromPO(Rec);
                //HEI.35<<
                //HEI.10>>
                CurrPage.UPDATE(FALSE);
                //HEI.10<<
            end;
        }
        modify(Reopen)
        {
            CaptionML = ENU = 'Re&open', FRA = 'R&ouvrir';
            ToolTipML = ENU = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed', FRA = 'Rouvrez le document pour le modifier après son approbation. Les documents approuvés ont le statut Lancé et doivent être ouverts pour pouvoir être modifiés.';
            trigger OnAfterAction()
            var
                PurchUnility: Codeunit "Purchases-Utils";
            begin


                // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
                //ReleasePurchDoc.PerformManualReopen(Rec);
                // ReleasePurchDoc.DocStatusOpen(xRec, Rec);//BC Upgrade SHARMP16-- DRINK-IT code
                // CurrPage.UPDATE;//BC Upgrade SHARMP16-- DRINK-IT code
                // >>DITW15.00.00.39 DDR #1330 #1407
                //HEI.35>>
                //HEI.55>>
                //IF Status = Status::Open THEN
                IF (rec.Status = rec.Status::Open) AND PurchUnility.TODeletionRestriction(Rec) THEN
                    g_CU_PurchasesUtils.ManageTOfromPO(Rec);
                //HEI.55<<
                //HEI.35<<

            end;
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(CalculateInvoiceDiscount)
        {
            CaptionML = ENU = 'Calculate &Invoice Discount', FRA = 'C&alculer remise facture';
            ToolTipML = ENU = 'Calculate the discount that can be granted based on all lines in the purchase document.', FRA = 'Calculez la remise qui peut être accordée en fonction de toutes les lignes du document achat.';
        }
        modify(CopyDocument)
        {
            CaptionML = ENU = 'Copy Document', FRA = 'Copier document';
        }
        modify(MoveNegativeLines)
        {
            CaptionML = ENU = 'Move Negative Lines', FRA = 'Déplacer lignes négatives';
        }

        modify("Functions_GetSalesOrder")
        {
            CaptionML = ENU = 'Get &Sales Order', FRA = 'Ex&traire commande vente';
            ToolTipML = ENU = 'Select the sales order that must be linked to the purchase order, for drop shipment. ', FRA = 'Sélectionnez la commande vente à associer à la commande achat pour une livraison directe. ';
        }

        modify(Action187)
        {
            CaptionML = ENU = 'Get &Sales Order', FRA = 'Ex&traire commande vente';
        }
        modify("Archive Document")
        {
            CaptionML = ENU = 'Archi&ve Document', FRA = 'Archi&ver document';
        }

        modify(IncomingDocument)
        {
            CaptionML = ENU = 'Incoming Document', FRA = 'Document entrant';
        }
        modify(IncomingDocCard)
        {
            CaptionML = ENU = 'View Incoming Document', FRA = 'Afficher le document entrant';
            ToolTipML = ENU = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes', FRA = 'Affichez tous les fichiers joints et tous les enregistrements de document entrant qui existent pour l''écriture ou le document, par exemple à des fins d''audit.';
        }
        modify(SelectIncomingDoc)
        {
            CaptionML = ENU = 'Select Incoming Document', FRA = 'Sélectionner le document entrant';
        }
        modify(IncomingDocAttachFile)
        {
            CaptionML = ENU = 'Create Incoming Document from File', FRA = 'Créer un document entrant à partir d''un fichier';
            ToolTipML = ENU = 'Create an incoming document from a file that you select from the disk. The file will be attached to the incoming document record.', FRA = 'Créez un document entrant à partir d''un fichier que vous sélectionnez sur le disque. Le fichier sera joint à l''enregistrement de document entrant.';
        }
        modify(RemoveIncomingDoc)
        {
            CaptionML = ENU = 'Remove Incoming Document', FRA = 'Supprimer le document entrant';
        }
        modify("Request Approval")
        {
            CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';
        }
        modify(SendApprovalRequest)
        {

            CaptionML = ENU = 'Send A&pproval Request', FRA = 'Envoyer demande d''a&pprobation';

            trigger OnBeforeAction()
            var
                FinanceUtil: Codeunit "Financial-Utils";
            begin
                //HEI.50>>
                FinanceUtil.OnBeforeSendPurchaseOrderApprovalRequest(Rec);
                //HEI.50<<
                //HEI.39>>
                CheckCMGMandatory();
                //HEI.39<<
                // //Hei.32
                // PurchasesPSetup.GET;
                // IF PurchasesPSetup."Requester ID Mandatory" THEN BEGIN
                //     IF "SRM Order No." = '' THEN
                //         Rec.TESTFIELD("Requester ID");
                // end;
                // //Hei.32//BC Upgrade SHARMP16--- Interface code. 

                //HEI.35>>
                PurchasesPSetup.Get();//Bc Upgrade SHARMP16 GAPFitChanges
                IF PurchaseHeaderAdditional.GET(rec."Document Type"::Order, rec."No.") THEN BEGIN
                    IF PurchaseHeaderAdditional."Import Identifier" THEN BEGIN
                        rec.TESTFIELD("Location Code");
                        PurchaseHeaderAdditional.TESTFIELD("Exp Physical Del Date(Imp)");
                        PurchLineRec.RESET();
                        PurchLineRec.SETRANGE("Document Type", PurchLineRec."Document Type"::Order);
                        PurchLineRec.SETRANGE("Document No.", rec."No.");
                        PurchLineRec.SETRANGE(Type, PurchLineRec.Type::Item);
                        IF PurchLineRec.findset() THEN
                            REPEAT
                                PurchLineRec.TESTFIELD("Exp Physical Del Date(Imp) FND");
                                IF (PurchLineRec."Location Code" <> PurchasesPSetup."Location Code Imp Proc. FND") THEN
                                    ERROR(Text50000, PurchLineRec."Document No.", PurchLineRec."Line No.", PurchasesPSetup."Location Code Imp Proc. FND");
                                IF (PurchLineRec."Location Code" = rec."Location Code") THEN
                                    ERROR(Text50001, PurchLineRec."Document No.");
                            UNTIL PurchLineRec.NEXT() = 0;
                    end;
                end;
                //HEI.35<<

                //HEI.34>>
                grec_InventorySetup.GET();
                IF grec_InventorySetup."Location Mandatory" THEN BEGIN
                    PurchLineRec.RESET();
                    PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
                    PurchLineRec.SETRANGE("Document No.", Rec."No.");
                    PurchLineRec.SETRANGE(Type, PurchLineRec.Type::Item);
                    IF PurchLineRec.findset() THEN
                        REPEAT
                            PurchLineRec.TESTFIELD("Location Code");
                        UNTIL PurchLineRec.NEXT() = 0;
                end;
                //HEI.34<<

                //HEI.21 >>
                GenLedSetRec.RESET();
                GenLedSetRec.GET();
                IF GenLedSetRec."License Dimension Code FND" <> '' THEN BEGIN
                    CLEAR(LicenseCodeValue);
                    PurchRec.RESET();
                    PurchRec.SETRANGE("Document Type", Rec."Document Type");
                    PurchRec.SETRANGE("No.", Rec."No.");
                    IF PurchRec.FINDFIRST() THEN BEGIN
                        DimSetEntryRec.RESET();
                        DimSetEntryRec.SETRANGE("Dimension Set ID", PurchRec."Dimension Set ID");
                        DimSetEntryRec.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                        IF DimSetEntryRec.FINDFIRST() THEN
                            LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
                    end;
                    CLEAR(LicenseCodeValue_1);
                    PurchLineRec.RESET();
                    PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
                    PurchLineRec.SETRANGE("Document No.", Rec."No.");
                    IF PurchLineRec.FINDFIRST() THEN BEGIN
                        REPEAT
                            DimSetEntryRec_1.RESET();
                            DimSetEntryRec_1.SETRANGE("Dimension Set ID", PurchLineRec."Dimension Set ID");
                            DimSetEntryRec_1.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                            IF DimSetEntryRec_1.FINDFIRST() THEN
                                LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

                            IF LicenseCodeValue_1 <> '' THEN BEGIN
                                IF LicenseCodeValue <> LicenseCodeValue_1 THEN
                                    ERROR(Text004);
                            end;
                        UNTIL PurchLineRec.NEXT() = 0;
                    end;
                end;
                //HEI.21 <<

            end;
        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Re&quest', FRA = 'Annuler demande d''appro&bation';
            ToolTipML = ENU = 'Cancel the approval request.', FRA = 'Annulez la demande d''approbation.';
        }
        modify("Create &Whse. Receipt")
        {
            CaptionML = ENU = 'Create &Whse. Receipt', FRA = 'Créer &réception entrepôt';
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //HEI.58>>
                IF WHRequest.GET(WHRequest.Type::Inbound, rec."Location Code", DATABASE::"Purchase Line", WHRequest."Source Subtype"::"1", rec."No.") THEN BEGIN
                    //BC Upgrade SHARMP16 BEGIN>>------------Warehouse Rcpt/Shpt No. field -- Drink-IT field
                    // IF WHRequest."Warehouse Rcpt/Shpt No." <> '' THEN BEGIN
                    //     //IF WHRequest.GET(WHRequest."Warehouse Rcpt/Shpt No.") THEN BEGIN //HEI.59
                    //     IF NOT WHRcptHdr.GET(WHRequest."Warehouse Rcpt/Shpt No.") THEN BEGIN //HEI.59
                    //         WHRequest."Warehouse Rcpt/Shpt No." := '';
                    //         WHRequest.MODIFY;
                    //     end;
                    // end;
                    //BC Upgrade SHARMP16 end<<------------Warehouse Rcpt/Shpt No. field-- Drink-IT field
                end;
                //HEI.58<<

            end;
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            CaptionML = ENU = 'Create Inventor&y Put-away/Pick', FRA = 'Créer prélèv./rangement stoc&k';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
        }
        modify(Preview)
        {
            CaptionML = ENU = 'Preview Posting', FRA = 'Aperçu compta.';
            ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.', FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
        }
        modify("Post &Batch")
        {
            CaptionML = ENU = 'Post &Batch', FRA = 'Valider par l&ot';
        }
        modify("Remove From Job Queue")
        {
            CaptionML = ENU = 'Remove From Job Queue', FRA = 'Supprimer de la file d''attente des travaux';
        }
        modify("Prepa&yment")
        {
            CaptionML = ENU = 'Prepa&yment', FRA = 'Acom&pte';
        }
        modify("Prepayment Test &Report")
        {
            CaptionML = ENU = 'Prepayment Test &Report', FRA = 'Impression &test acompte';
        }
        modify(PostPrepaymentInvoice)
        {
            CaptionML = ENU = 'Post Prepayment &Invoice', FRA = 'Valider &facture acompte';
            trigger OnBeforeAction()
            var
            begin
                Rec.TestField("Document Subtype Code FND"); //BC Upgrade VAMSIU01 - Added>>
            end;
        }
        modify("Post and Print Prepmt. Invoic&e")
        {
            CaptionML = ENU = 'Post and Print Prepmt. Invoic&e', FRA = 'Valider et imprimer factur&e acompte';
        }
        modify(PostPrepaymentCreditMemo)
        {
            CaptionML = ENU = 'Post Prepayment &Credit Memo', FRA = 'Valider &avoir acompte';
        }
        modify("Post and Print Prepmt. Cr. Mem&o")
        {
            CaptionML = ENU = 'Post and Print Prepmt. Cr. Mem&o', FRA = 'Valider et imprimer av&oir acompte';
        }
        modify(Print)
        {
            CaptionML = ENU = 'Print', FRA = 'Imprimer';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Order', FRA = '&Imprimer';
            ToolTipML = ENU = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.', FRA = 'Préparez-vous à imprimer le document. La fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';

            //Unsupported feature: Change Name on ""&Print"(Action 82)". Please convert manually.

            Enabled = TRUE;
        }
        modify(SendCustom)
        {
            CaptionML = ENU = 'Send', FRA = 'Envoyer';
            ToolTipML = ENU = 'Prepare to send the document according to the vendor''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.', FRA = 'Préparez-vous à envoyer le document en fonction du profil d''envoi du fournisseur, par exemple en pièce jointe d''un e-mail. La fenêtre Envoyer le document à s''ouvre en premier pour que vous puissiez confirmer ou sélectionner un profil d''envoi.';
        }


        //Unsupported feature: CodeModification on "Release(Action 137).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleasePurchDoc.PerformManualRelease(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.50>>
        FinanceUtil.OnBeforeSendPurchaseOrderApprovalRequest(Rec);
        //HEI.50<<
        //>>HEI.39
        CheckCMGMandatory;
        //<<HEI.39
        //Hei.32
        PurchasesPSetup.GET;
        if PurchasesPSetup."Requester ID Mandatory" then begin
          if "SRM Order No." = '' then
          Rec.TESTFIELD("Requester ID");
        end;
        //Hei.32

        //HEI.35>>
        if PurchaseHeaderAdditional.GET("Document Type"::Order,"No.") then begin
          if PurchaseHeaderAdditional."Import Identifier" then begin
            TESTFIELD("Location Code");
            PurchaseHeaderAdditional.TESTFIELD("Exp Physical Del Date(Imp)");
            PurchLineRec.RESET;
            PurchLineRec.SETRANGE("Document Type",PurchLineRec."Document Type"::Order);
            PurchLineRec.SETRANGE("Document No.","No.");
            PurchLineRec.SETRANGE(Type,PurchLineRec.Type::Item);
            if PurchLineRec.findset then repeat
              PurchLineRec.TESTFIELD("Exp Physical Del Date(Imp)");
              if (PurchLineRec."Location Code" <> PurchasesPSetup."Location Code for Import Proc.") then
                ERROR(Text50000,PurchLineRec."Document No.",PurchLineRec."Line No.",PurchasesPSetup."Location Code for Import Proc.");
              if (PurchLineRec."Location Code" = "Location Code") then
                ERROR(Text50001,PurchLineRec."Document No.");
            until PurchLineRec.NEXT = 0;
          end;
        end;
        //HEI.35<<

        //HEI.21 >>
        GenLedSetRec.RESET;
        GenLedSetRec.GET;
        if GenLedSetRec."License Dimension Code" <> '' then begin
          CLEAR(LicenseCodeValue);
          PurchRec.RESET;
          PurchRec.SETRANGE("Document Type",Rec."Document Type");
          PurchRec.SETRANGE("No.",Rec."No.");
          if PurchRec.FINDFIRST then begin
              DimSetEntryRec.RESET;
              DimSetEntryRec.SETRANGE("Dimension Set ID",PurchRec."Dimension Set ID");
              DimSetEntryRec.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
              if DimSetEntryRec.FINDFIRST then
                LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
          end;
          CLEAR(LicenseCodeValue_1);
          PurchLineRec.RESET;
          PurchLineRec.SETRANGE("Document Type",Rec."Document Type");
          PurchLineRec.SETRANGE("Document No.",Rec."No.");
          if PurchLineRec.FINDFIRST then begin
            repeat
              DimSetEntryRec_1.RESET;
              DimSetEntryRec_1.SETRANGE("Dimension Set ID",PurchLineRec."Dimension Set ID");
              DimSetEntryRec_1.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
              if DimSetEntryRec_1.FINDFIRST then
                LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

              if LicenseCodeValue_1 <>'' then begin
                if LicenseCodeValue <> LicenseCodeValue_1 then
                  ERROR(Text004);
              end;
            until PurchLineRec.NEXT = 0;
          end;
        end;
        //HEI.21 <<
        // <<DITW15.00.00.23.04 DDR 15/09/2008 - DITW15.00.00.36 DDR 07/12/2009
        CurrPage.UPDATE(true);
        // >>DITW15.00.00.23.04 DDR
        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
        //ReleasePurchDoc.PerformManualRelease(Rec);
        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
        if "Sundry Vendor" then
          TestSundryMandatoryFields();
        //>> DITW18.00.07 DIT-770 #1804
        ReleasePurchDoc.DocStatusRelease(xRec,Rec);
        CurrPage.UPDATE;
        // >>DITW15.00.00.39 DDR #1330 #1407
        //HEI.35>>
        if Status = Status::Released then
          g_CU_PurchasesUtils.ManageTOfromPO(Rec);
        //HEI.35<<
        //HEI.10>>
        CurrPage.UPDATE(false);
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeModification on "Reopen(Action 138).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleasePurchDoc.PerformManualReopen(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.12>>
        if PurchSetup.GET then begin
          PurchaseLine.SETRANGE("Document No.","No.");
          PurchaseLine.SETFILTER("Document Type",'%1',"Document Type"::Order);
          PurchaseLine.SETFILTER(Type,'%1',PurchaseLine.Type::Item);
          PurchaseLine.SETFILTER("Item Category Code",PurchSetup."Item Category");
          if not PurchaseLine.FINDFIRST then
            ItemCategoryBool := false
          else
            ItemCategoryBool := true;
          if ItemCategoryBool then begin
        //HEI.12<<
          //HEI.11>>
          if "SRM Order No." = '' then begin
            ArchiveManagement.ArchivePurchDocumentOnReopen(Rec);
            CurrPage.UPDATE(false);
          end;
          //HEI.11<<
        //HEI.12>>
          end;
        end;
        //HEI.12<<

        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
        //ReleasePurchDoc.PerformManualReopen(Rec);
        ReleasePurchDoc.DocStatusOpen(xRec,Rec);
        CurrPage.UPDATE;
        // >>DITW15.00.00.39 DDR #1330 #1407
        //HEI.35>>
        //HEI.55>>
        //IF Status = Status::Open THEN
          if (Status = Status::Open) and PurchUnility.TODeletionRestriction(Rec) then
          g_CU_PurchasesUtils.ManageTOfromPO(Rec);
        //HEI.55<<
        //HEI.35<<
        */
        //end;


        //Unsupported feature: CodeModification on "SendApprovalRequest(Action 57).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
          ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.50>>
        FinanceUtil.OnBeforeSendPurchaseOrderApprovalRequest(Rec);
        //HEI.50<<
        //HEI.39>>
        CheckCMGMandatory;
        //HEI.39<<
        //Hei.32
        PurchasesPSetup.GET;
        if PurchasesPSetup."Requester ID Mandatory" then begin
          if "SRM Order No." = '' then
          Rec.TESTFIELD("Requester ID");
        end;
        //Hei.32

        //HEI.35>>
        if PurchaseHeaderAdditional.GET("Document Type"::Order,"No.") then begin
          if PurchaseHeaderAdditional."Import Identifier" then begin
            TESTFIELD("Location Code");
            PurchaseHeaderAdditional.TESTFIELD("Exp Physical Del Date(Imp)");
            PurchLineRec.RESET;
            PurchLineRec.SETRANGE("Document Type",PurchLineRec."Document Type"::Order);
            PurchLineRec.SETRANGE("Document No.","No.");
            PurchLineRec.SETRANGE(Type,PurchLineRec.Type::Item);
            if PurchLineRec.findset then repeat
              PurchLineRec.TESTFIELD("Exp Physical Del Date(Imp)");
              if (PurchLineRec."Location Code" <> PurchasesPSetup."Location Code for Import Proc.") then
                ERROR(Text50000,PurchLineRec."Document No.",PurchLineRec."Line No.",PurchasesPSetup."Location Code for Import Proc.");
              if (PurchLineRec."Location Code" = "Location Code") then
                ERROR(Text50001,PurchLineRec."Document No.");
            until PurchLineRec.NEXT = 0;
          end;
        end;
        //HEI.35<<

        //HEI.34>>
        grec_InventorySetup.GET;
        if grec_InventorySetup."Location Mandatory" then begin
          PurchLineRec.RESET;
          PurchLineRec.SETRANGE("Document Type",Rec."Document Type");
          PurchLineRec.SETRANGE("Document No.",Rec."No.");
          PurchLineRec.SETRANGE(Type,PurchLineRec.Type::Item);
          if PurchLineRec.findset then repeat
            PurchLineRec.TESTFIELD("Location Code");
          until PurchLineRec.NEXT = 0;
        end;
        //HEI.34<<

        //HEI.21 >>
        GenLedSetRec.RESET;
        GenLedSetRec.GET;
        if GenLedSetRec."License Dimension Code" <> '' then begin
          CLEAR(LicenseCodeValue);
          PurchRec.RESET;
          PurchRec.SETRANGE("Document Type",Rec."Document Type");
          PurchRec.SETRANGE("No.",Rec."No.");
          if PurchRec.FINDFIRST then begin
              DimSetEntryRec.RESET;
              DimSetEntryRec.SETRANGE("Dimension Set ID",PurchRec."Dimension Set ID");
              DimSetEntryRec.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
              if DimSetEntryRec.FINDFIRST then
                LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
          end;
          CLEAR(LicenseCodeValue_1);
          PurchLineRec.RESET;
          PurchLineRec.SETRANGE("Document Type",Rec."Document Type");
          PurchLineRec.SETRANGE("Document No.",Rec."No.");
          if PurchLineRec.FINDFIRST then begin
            repeat
              DimSetEntryRec_1.RESET;
              DimSetEntryRec_1.SETRANGE("Dimension Set ID",PurchLineRec."Dimension Set ID");
              DimSetEntryRec_1.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
              if DimSetEntryRec_1.FINDFIRST then
                LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

              if LicenseCodeValue_1 <>'' then begin
                if LicenseCodeValue <> LicenseCodeValue_1 then
                  ERROR(Text004);
              end;
            until PurchLineRec.NEXT = 0;
          end;
        end;
        //HEI.21 <<
        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
          ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
        */
        //end;


        //Unsupported feature: CodeModification on ""Create &Whse. Receipt"(Action 149).OnAction". Please convert manually.

        //trigger  Receipt"(Action 149)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSourceDocInbound.CreateFromPurchOrder(Rec);

        if not FIND('=><') then
          INIT;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.58>>
        if WHRequest.GET(WHRequest.Type::Inbound,"Location Code",DATABASE::"Purchase Line",WHRequest."Source Subtype"::"1","No.") then begin
          if WHRequest."Warehouse Rcpt/Shpt No." <> '' then begin
            //IF WHRequest.GET(WHRequest."Warehouse Rcpt/Shpt No.") THEN BEGIN //HEI.59
            if not WHRcptHdr.GET(WHRequest."Warehouse Rcpt/Shpt No.") then begin //HEI.59
              WHRequest."Warehouse Rcpt/Shpt No." := '';
              WHRequest.MODIFY;
            end;
          end;
        end;
        //HEI.58<<
        // <<DITW19.00.07 MVN 25/01/2016 DIT-770 #1740 Upgrade: Variables
        // <<DITW15.00.00.34 DDR 16/06/2009
        PurchSetup.GET();
        if PurchSetup."Auto.Release Document on Whse."then begin
          // <<DITW15.00.00.39 DDR 27/07/2011 #1407
          ReleasePurchDoc.DocStatusRelease(xRec,Rec);
          // >>DITW15.00.00.39 DDR #1407
          if (xRec.Status <> Status) and (Status = Status::Released) then
            MESSAGE(Text2014410,"Document Type","No.");
        end;
        // >>DITW15.00.00.34 DDR
        // >>DITW19.00.07 MVN DIT-770 #1740

        #1..4
        */
        //end;


        //Unsupported feature: CodeModification on "Post(Action 79).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Post(CODEUNIT::"Purch.-Post (Yes/No)");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.25 DDR 20/10/2008
        CurrPage.UPDATE;
        // >>DITW15.00.00.25 DDR
        Post(CODEUNIT::"Purch.-Post (Yes/No)");
        */
        //end;


        //Unsupported feature: CodeModification on ""Post and &Print"(Action 80).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Post(CODEUNIT::"Purch.-Post + Print");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.25 DDR 20/10/2008
        CurrPage.UPDATE;
        // >>DITW15.00.00.25 DDR
        Post(CODEUNIT::"Purch.-Post + Print");
        */
        //end;


        //Unsupported feature: CodeModification on ""Post &Batch"(Action 81).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders",true,true,Rec);
        CurrPage.UPDATE(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.25 DDR 20/10/2008
        CurrPage.UPDATE;
        // >>DITW15.00.00.25 DDR
        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders",true,true,Rec);
        CurrPage.UPDATE(false);
        */
        //end;


        //Unsupported feature: CodeModification on "PostPrepaymentInvoice(Action 203).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
          PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec,false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.25 DDR 20/10/2008
        CurrPage.UPDATE;
        // >>DITW15.00.00.25 DDR

        //HEI.05>>
        Rec.TESTFIELD("Document Subtype Code");
        //HEI.05<<
        if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
          PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec,false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Post and Print Prepmt. Invoic&e"(Action 210).OnAction". Please convert manually.

        //trigger  Invoic&e"(Action 210)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
          PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec,true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.25 DDR 20/10/2008
        CurrPage.UPDATE;
        // >>DITW15.00.00.25 DDR
        if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
          PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec,true);
        */
        //end;


        //Unsupported feature: CodeModification on "PostPrepaymentCreditMemo(Action 204).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
          PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec,false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.25 DDR 20/10/2008
        CurrPage.UPDATE;
        // >>DITW15.00.00.25 DDR
        if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
          PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec,false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Post and Print Prepmt. Cr. Mem&o"(Action 211).OnAction". Please convert manually.

        //trigger  Cr();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
          PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec,true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.25 DDR 20/10/2008
        CurrPage.UPDATE;
        // >>DITW15.00.00.25 DDR
        if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
          PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec,true);
        */
        //end;


        //Unsupported feature: CodeModification on ""&Print"(Action 82).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PurchaseHeader := Rec;
        CurrPage.SETSELECTIONFILTER(PurchaseHeader);
        PurchaseHeader.PrintRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144 - DITW110.00.08 DDR 02/01/2017 NRQ#0
        //TESTFIELD(Status,Status::Released);
        //>>DITW17.00.02 TEC1 10/09/2013 DIT-770 #144
        PurchaseHeader := Rec;
        CurrPage.SETSELECTIONFILTER(PurchaseHeader);
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.PurchLines.PAGE.SetDisableRefreshLines(true);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        PurchaseHeader.PrintRecords(true);
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.PurchLines.PAGE.SetDisableRefreshLines(false);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        */
        //end;
        addafter("Co&mments")
        {
            // action("Shipping Costs")
            // {
            //     CaptionML = ENU='Shipping Costs',
            //                 FRA='Coûts transport';
            //     Image = Costs;
            //     RunObject = Page "Document Shipping Cost";
            //                     RunPageLink = "Source Type"=CONST(38),
            //                   "Source No."=FIELD("No."),
            //                   "Sub Type"=FIELD("Document Type");
            // }//BC Upgrade SHARMP16-Drink-it action
            action("Purchase Additional")
            {
                Promoted = true;//BC Upgarde SHARMP16-- PO page related changes
                PromotedCategory = Category8;//BC Upgarde SHARMP16-- PO page related changes
                ApplicationArea = all;
                Caption = 'Purchase Additional';
                Image = Purchase;
                RunObject = Page "Purchase Additional";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                              "No." = FIELD("No.");
                ToolTip = 'Executes the Purchase Additional action.';
            }

            //BC upgrade SHARMP16 BEGIN>>--------- Interface related code.
            // action("Ibecor Situational File")
            // {
            //     Caption = 'Ibecor Situational File';
            //     Image = Filed;

            //     trigger OnAction();
            //     var
            //         IbecorSituationalFile: Record "Ibecor Situational File";
            //         StoreLastShipmentNo: Code[10];
            //     begin
            //         //HEI.42>>
            //         IbecorSituationalFile.RESET;
            //         IbecorSituationalFile.SETRANGE("Order No.", "No.");
            //         IbecorSituationalFile.SETRANGE("Shipment Type", IbecorSituationalFile."Shipment Type"::Registered);
            //         if IbecorSituationalFile.FINDFIRST then
            //             PAGE.RUNMODAL(PAGE::"Ibecor Situational File", IbecorSituationalFile)
            //         else begin
            //             IbecorSituationalFile.SETRANGE("Shipment Type", IbecorSituationalFile."Shipment Type"::Current);
            //             if IbecorSituationalFile.FINDLAST then
            //                 StoreLastShipmentNo := IbecorSituationalFile."Shipment No.";
            //             IbecorSituationalFile.SETRANGE("Shipment No.", StoreLastShipmentNo);
            //             PAGE.RUNMODAL(PAGE::"Ibecor Situational File", IbecorSituationalFile)
            //         end;
            //         //HEI.42<<
            //     end;
            // }
            //BC upgrade SHARMP16 end<<--------- Interface related code.
            //action("Process PO for Astro WMS")
            // {
            //     Image = Process;

            //     trigger OnAction();
            //     begin
            //         //HEI.44>>
            //         if CONFIRM(STRSUBSTNO(Text50002, rec."No."), true) then begin
            //             // ASTRODispatchSyncStP.SetPONumber(rec."No.");
            //             // ASTRODispatchSyncStP.RUN;//BC Upgrade SHARMP16--- Astro related code out of scope.
            //         end;
            //         //HEI.44<<
            //     end;
            // }
        }
        addafter("In&vt. Put-away/Pick Lines")
        {
            action("Quote Approvals")
            {
                Promoted = true;//BC Upgarde SHARMP16-- PO page related changes
                PromotedCategory = category8;//BC Upgarde SHARMP16-- PO page related changes
                CaptionML = ENU = 'Quote Approvals',
                            FRA = 'Approbations devis';
                ApplicationArea = All;
                ToolTip = 'Executes the Quote Approvals action.';

                // trigger OnAction();
                // var
                //     ApprovalEntries : Page "Approval Entries";
                // begin
                //     //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144
                //     ApprovalEntries.Setfilters(DATABASE::"Purchase Header","Document Type"::Quote,"Quote No.");
                //     ApprovalEntries.RUN;
                //     //>>DITW17.00.02 TEC1 DIT-770 #144
                // end;//BC Upgrade SHARMP16 -- Drink-IT code
            }
            action("Ret&urn Orders")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Ret&urn Orders',
                            FRA = 'Re&tours';
                Image = ReturnOrder;
                RunObject = Page "Purchase Return Order List";
                ToolTip = 'Executes the Ret&urn Orders action.';
                // RunPageLink = "Link Purch. Document Type" = FIELD("Document Type"),
                //               "Link Purch. Document No." = FIELD("No.");//BC Upgrade SHARMP16-- Drink-It fields used.
            }
            action("R&eturn Shipments")
            {
                CaptionML = ENU = 'R&eturn Shipments',
                            FRA = 'Expédition R&etour';
                Image = ReturnShipment;
                ApplicationArea = all;
                RunObject = Page "Posted Return Shipments";
                ToolTip = 'Executes the R&eturn Shipments action.';
                //   RunPageLink = "Link Purch. Document No." = FIELD("No.");////BC Upgrade SHARMP16-- Drink-It fields used.
            }
        }

        addafter("Speci&al Order")
        {
            separator(Separator1161021000)
            {
            }
            action("<Action1161021001>")
            {

                CaptionML = ENU = 'Show N-owm activities',
                            FRA = 'Visualiser Activitées N-owm';
                Image = NewResource;
                ApplicationArea = All;
                ToolTip = 'Executes the <Action1161021001> action.';

                trigger OnAction();
                var
                //   owmUtils : Codeunit "N-owm Utils";//BC Upgrade SHARMP16 -- Drink-IT code.
                begin
                    //  owmUtils.ShowActivityStatus(owmUtils.ActPutAway, "No.", '');  //DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806//BC Upgrade SHARMP16 -- Drink-IT code.
                end;
            }
        }
        // addafter(CalculateInvoiceDiscount)
        // {
        //     // action("Change Sundry vendor fields")
        //     // {
        //     //     CaptionML = ENU='Change Sundry vendor fields',
        //     //                 FRA='Modifier champs fournisseurs divers';
        //     //     Image = ChangeCustomer;
        //     //     Promoted = true;
        //     //     PromotedIsBig = true;
        //     //     Visible = "Sundry Vendor";

        //     //     trigger OnAction();
        //     //     begin
        //     //         //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
        //     //         ShowVendorSundryInfo();
        //     //         //>> DITW18.00.07 DIT-770 #1804
        //     //         //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
        //     //         CurrPage.UPDATE(true);
        //     //         //>> DITW18.00.07 DIT-770 #1804
        //     //     end;
        //     // }BC Upgrade SHARMP16 -- Drink-IT code
        // }

        addafter(MoveNegativeLines)
        {
            action("Cre&ate Return Order")
            {
                CaptionML = ENU = 'Cre&ate Return Order',
                            FRA = 'Créer commande retour';
                Image = ReturnOrder;
                ShortCutKey = 'Shift+F3';
                ApplicationArea = All;
                ToolTip = 'Executes the Cre&ate Return Order action.';

                // trigger OnAction();
                // begin
                //     // <<DITW15.00.00.01 DDR 27/02/2008
                //     CODEUNIT.RUN(CODEUNIT::"Purch Ord. to Ret.Shpt. (Y/N)",Rec);

                //     if not FIND('=><') then
                //       INIT;
                //     // >>DITW15.00.00.01 DDR
                // end;//Bc Upgrade SHARMP16-- DRINK-IT code.
            }

            action(GetBlanketOrderPrice)
            {
                Caption = 'Get Blanket Order Price';
                Image = Price;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                ToolTip = 'Executes the Get Blanket Order Price action.';
                trigger OnAction();
                begin
                    //HEI.06>>
                    if CONFIRM(GetBlanketOrderPriceQst) then
                        rec.GetBlanketOrderPrice();
                    //HEI.06<<
                end;
            }

            separator(Separator1100083000)
            {
            }
        }
        //BC Upgrade SHARMP16 BEGIN>>-Astro
        // addafter("Archive Document")
        // {
        //     action("Wizard to Remove Astro UniqueID")
        //     {
        //         ApplicationArea = all;
        //         Caption = 'Remove Astro UniqueID';
        //         Image = RemoveFilterLines;
        //         Visible = AstroRemovalVisibility;

        //         trigger OnAction();
        //         var
        //             Textl50000: Label 'Do you want to remove the Astro Lines?';
        //             PurchaseLine: Record "Purchase Line";
        //             Textl50001: Label 'No such Astro Unique ID %1 available in this PO - %2';
        //             Textl50002: Label 'Please enter a valid Astro Unique ID to process';
        //             Textl50003: Label 'Astro Unique ID removed successfully';
        //         begin
        //             //HEI.48>>
        //             if not CONFIRM(Textl50000, true) then
        //                 exit
        //             else begin
        //                 if (EnterUniqueid <> '') then begin
        //                     PurchaseLine.RESET;
        //                     PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
        //                     PurchaseLine.SETRANGE("Document No.", Rec."No.");
        //                     PurchaseLine.SETRANGE("Astro Unique ID", EnterUniqueid);
        //                     if PurchaseLine.findset then begin
        //                         PurchaseLine.MODIFYALL("Astro Unique ID", '');
        //                         EnterUniqueid := '';
        //                         MESSAGE(Textl50003);
        //                     end else
        //                         ERROR(Textl50001);
        //                 end else begin
        //                     EnterUniqueid := '';
        //                     ERROR(Textl50002);
        //                 end;
        //             end;
        //             //HEI.48<<
        //         end;
        //     }
        // }
        // addafter("Send Intercompany Purchase Order")
        // {
        //     action(AutoSendICOrder)
        //     {
        //         ApplicationArea = all;
        //         Caption = 'Auto. Send IC Order';
        //         Description = 'NRQ69018-FINXL14.00.15 MSF 13/05/2020 NRQ#117628';
        //         Enabled = NOT VisibleSendIC;
        //         Image = Intercompany;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;

        //         trigger OnAction();
        //         var
        //             //   ICLog: Record "IC Log Entry";//BC Upgrade SHARMP16
        //             PurchAdditionalIC: Record "Purchase Header Additional FND";
        //         //   ICLog1: Record "IC Log Entry";//BC Upgrade SHARMP16
        //         begin
        //             // //<<FINXL11.00 HBA 03/05/2018 NRQ#69018
        //             // cduICWebservice.fctCopyICDocument("Document Type", "No.", 'PURCHASE');
        //             // //>>FINXL11.00 HBA 03/05/2018 NRQ#69018Hei. Upgrade SHARMP16
        //         end;
        //     }
        // }
        //BC Upgrade SHARMP16 end<<-Astro
        // addafter(Separator189)
        // {
        //     // action("Register Route Shipment entries")
        //     // {
        //     //     CaptionML = ENU='Register Route Shipment entries',
        //     //                 FRA='Registre route écritures éxpéditions';
        //     //     Image = Register;
        //     //     RunObject = Page "Route Register Entries";
        //     //                     RunPageLink = "Route Planning No."=FIELD("Route Planning No."),
        //     //                   "Source Type"=CONST(36),
        //     //                   "Source Subtype"=FIELD("Document Type"),
        //     //                   "Source No."=FIELD("No.");
        //     // }--BC Upgrade SHARMP16-- Drink-IT
        // }
        //BC Upgrade SHARMP16 BEGIN>>-Drink-it code.
        // addafter("&Print")
        // {
        //     action("&Shipping Agent Notice")
        //     {
        //         CaptionML = ENU='&Shipping Agent Notice',
        //                     FRA='&Mention du transporteur';
        //         Image = Print;

        //         trigger OnAction();
        //         var
        //             DocPrint : Codeunit "Document-Print";
        //         begin
        //             //? DITW110.00.08 DDR 02/01/2017 NRQ#0 TO BE REPLACED (don't use codeunit229 Document-Print)

        //             // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //             CurrPage.PurchLines.PAGE.SetDisableRefreshLines(true);
        //             // >>DITW16.00.00.40 DDR DIT-715 #197
        //             // <<DIT15.00.00.21 DDR 26/06/2008
        //             DocPrint.PrintPurchHeaderAgentNotice(Rec);
        //             // >>DIT15.00.00.21 DDR
        //             // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //             CurrPage.PurchLines.PAGE.SetDisableRefreshLines(false);
        //             // >>DITW16.00.00.40 DDR DIT-715 #197
        //         end;
        //     }
        // }//BC Upgrade SHARMP16 end<<-Drink-it code.
    }





    //Unsupported feature: PropertyModification on "OpenPostedPurchaseOrderQst(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OpenPostedPurchaseOrderQst : ENU=The order has been posted and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OpenPostedPurchaseOrderQst : ENU=The order has been posted and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?;FRA=La commande a été validée et déplacée dans la fenêtre Factures achat enregistrées.\\Souhaitez-vous ouvrir la facture enregistrée ?;
    //Variable type has not been exported.
    var
        DimSetEntryRec: Record "Dimension Set Entry";
        DimSetEntryRec_1: Record "Dimension Set Entry";
        DimSetEntryRec_2: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimValRec: Record "Dimension Value";
        GenLedSetRec: Record "General Ledger Setup";
        grec_InventorySetup: Record "Inventory Setup";
        PurchRcptHdrRec: Record "Purch. Rcpt. Header";
        PurchRec: Record "Purchase Header";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchHdrArch: Record "Purchase Header Archive";
        PurchaseLine: Record "Purchase Line";
        PurchLine: Record "Purchase Line";
        PurchLine2: Record "Purchase Line";
        PurchLineRec: Record "Purchase Line";
        PurchasesPSetup: Record "Purchases & Payables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        ShippingAgent: Record "Shipping Agent";
        StdVendPurchCode: Record "Standard Vendor Purchase Code";
        UserSetup: Record "User Setup";
        Vend: Record Vendor;
        WHRcptHdr: Record "Warehouse Receipt Header";
        //    PurchSetup: Record "Purchases & Payables Setup";
        WHRequest: Record "Warehouse Request";
        //    ReleasePurchDoc: Codeunit "Release Purchase Document";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        DimMgt: Codeunit DimensionManagement;
        g_CU_PurchasesUtils: Codeunit "Purchases-Utils";
        ReleasePurchDoc: Codeunit "Release Purchase Document";

        DimValPage: Page "Dimension Values";

        ActivePrepayment: Boolean;
        //   ASTRODispatchSyncStP: Report "ASTRO Dispatch Sync StP";
        AstroRemovalVisibility: Boolean;
        DocSubtypeEditable: Boolean;
        EditableMultipleRouteOrder: Boolean;
        EditableVendorTax: Boolean;
        HideValidationDialog: Boolean;
        ItemCategoryBool: Boolean;
        LicensiEdit: Boolean;

        "Maximum CubageEmphasize": Boolean;

        "Maximum CubageVisible": Boolean;

        "Maximum WeightEmphasize": Boolean;

        "Maximum WeightVisible": Boolean;

        PayToCommentBtnVisible: Boolean;

        PayToCommentPictVisible: Boolean;
        PrintEnabled: Boolean;

        PurchHistoryBtn1Visible: Boolean;

        PurchHistoryBtnVisible: Boolean;

        RouteAsMandatory: Boolean;
        ShowSRMSubpage: Boolean;
        VendorShipmentNoMandatory: Boolean;
        VisibleSendIC: Boolean;
        EnterUniqueid: Code[9];
        LicenseCode: Code[20];
        LicenseCodeValue: Code[20];
        LicenseCodeValue_1: Code[20];
        NewDImSetId: Integer;
        OldDimSetId: Integer;
        GetBlanketOrderPriceQst: Label 'Do you want to get the blanket order price?';
        ReasonCodeErr: Label 'You must fill in the Reason Code';
        ShippingAgentVendorIsBlank: Label 'There is no Vendor associated with this Shipping Agent';
        Text000: Label 'Please select the dimension for License Dimension in General Ledger Setup.';
        Text001: Label 'The seleced value cannot be found in the dimension value table.';
        Text003: Label 'You cannot edit the License code when the PO when status is released.';
        Text004: Label 'License Dimension Value should be same for both header and line.';
        Text005: Label 'You cannot change the license code as receipts for %1 is already done.';
        Text50000: Label 'Location Code must have a value in Purhase Line- Document Type- Order,Document No- %1,Line Number- %2. %3 must be captured for Import PO';
        //grec_IbecorInterfaceSetup: Record "Ibecor Interface Setup INT";//BC Upgrade SHARMP16--Interface related code.
        // EnableIbecorInterface: Boolean;//BC Upgrade SHARMP16--Interface related code.
        //  MaximoStatusIsEditable: Boolean;//BC Upgrade SHARMP16--Interface related code.
        Text50002: Label 'Do you want to create the outbound entries for this PO %1 for Astro WMS Interface?';
        VendorBlockForShipAgent: Label 'The Vendor associated with this Shipping Agent is blocked';
        Text051: TextConst ENU = 'You may have changed a dimension.\\Do you want to update the lines?', FRA = 'Vous avez probablement modifié un axe analytique.\\Souhaitez-vous mettre à jour les lignes ?';
        Text50001: TextConst ENU = 'Location Code must have a value in Purchase Header:Document Type=Order, Document No.= %1. Phisycal delivery location must be captured for Import PO.';
        //cduICWebservice: Codeunit "IC Web Service";
        Text2014410: TextConst ENU = '%1 %2 has been automatically released.', FRA = 'Le/la %1 %2 a été automatiquement lancé(e).';
        Text2014411: TextConst ENU = 'Do you want to cancel the approval request for %1 %2?', FRA = 'Souhaitez vous annuler la demande d''approbation du/de la %1 %2?';
        Text2014412: TextConst ENU = 'Do you want to send the approval request for %1 %2?', FRA = 'Souhaitez vous envoyer la demande d''approbation du/de la %1 %2?';
    // VisibleZycusInterface: Boolean;//BC Upgrade SHARMP16--Interface related code.

    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetControlAppearance;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);
    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
    SETFILTER("Resp. Center Table Filter",
      UserMgt.GetRespCenterFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",
      UserMgt.GetRespPhysLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",
      UserMgt.GetRespLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 DDR DIT-770 #1191
    //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
    if "Responsibility Center" <> '' then
      SETFILTER("Resp. Center Table Filter 2",'%1|%2','',"Responsibility Center");
    //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
    // <<DITW15.00.00.39 DDR 27/07/2011 #1407
    CALCFIELDS("Disc.Promo. Order Calculated");
    // >>DITW15.00.00.34 DDR

    #1..4

    //<< DITW18.00.07 VSC 04/05/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
    //<< DITW18.00.07 VSC 26/05/2016 DIT-770 #1984
    /// DITW110.00.08 DDR 02/01/2017 NRQ#0
    RouteAsMandatory := PurchSetup."Route Mandatory";
    //>> DITW18.00.07 VSC 26/05/2016 DIT-770 #1984
    //<< DITW18.00.07 VSC DIT-770 #1984 - #1981-> DIT-770 #1488
    //<<DITW19.00.08 MSF 09/09/2016 BL#10387
    EditableVendorTax := not ReceivedPurchLinesExist ;
    //>>DITW19.00.08 MSF 09/09/2016 BL#10387
    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
     if not "Multiple Order Route" then
      EditableMultipleRouteOrder := true
    else
      EditableMultipleRouteOrder := false;
    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082

    //<<FINXL14.00.15 MSF 13/05/2020 NRQ#117628
    VisibleSendIC := not IsAutoSendDocEnabled ;
    //>>FINXL14.00.15 MSF 13/05/2020 NRQ#117628

    //>>HEI.01
    PrintEnabled := "SRM Order No." = '';
    //<<HEI.01
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
    MaximumCubageOnFormat;
    MaximumWeightOnFormat;
    // >>DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141

    //HEI.07>>
    PurchSetup.GET;
    ShowSRMSubpage := ("SRM Order No." <> '') and PurchSetup."Allow VAT Change C&TP Orders";
    //HEI.07<<

    //>>HEI.15
    if ("Blanket Order No." <> '') or ("SRM Contract No." <> '') then
      ActivePrepayment := false
    else
      ActivePrepayment := true;
    //<<HEI.15


    //HEI.35>>
    //IF PurchaseHeaderAdditional.GET("Document Type","No.") THEN; //HEI.20
    if PurchaseHeaderAdditional.GET("Document Type","No.") then //HEI.20
      PurchaseHeaderAdditional.CALCFIELDS("TO Reference");
    //HEI.35<<
    // HEI.21 >>
    // PurchRcptHdrRec.RESET;
    // PurchRcptHdrRec.SETRANGE("Order No.",Rec."No.");
    // IF PurchRcptHdrRec.FINDFIRST THEN
    PurchLine2.SETRANGE("Document Type",Rec."Document Type");
    PurchLine2.SETRANGE("Document No.",Rec."No.");
    PurchLine2.SETFILTER("Quantity Received",'>%1',0);
      if PurchLine2.FINDFIRST then
        LicensiEdit := false;
    // HEI.21 <<

    //>>HEI.38
    if "Maximo Requisition No." <> '' then
      MaximoStatusIsEditable := false;
    //<<HEI.38
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger (Variable: ZycusInterfaceSetupL)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    JobQueueUsed := PurchasesPayablesSetup.JobQueueActive;
    SetExtDocNoMandatoryCondition;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
    "Maximum WeightVisible" := true;
    "Maximum CubageVisible" := true;
    // >>DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
    //<<DITW19.00.08 MSF 09/09/2016 BL#10387
    EditableVendorTax := true;
    //>>DITW19.00.08 MSF 09/09/2016 BL#10387
    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
    EditableMultipleRouteOrder :=true;
    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
    //<<FINXL14.00.15 MSF 13/05/2020 NRQ#117628
    VisibleSendIC := true;
    //>>FINXL14.00.15 MSF 13/05/2020 NRQ#117628

    JobQueueUsed := PurchasesPayablesSetup.JobQueueActive;
    SetExtDocNoMandatoryCondition;

    //HEI.05>>
    //soicad delete

    // PurchSetup.GET();
    // IF PurchSetup."NPO Prepayment request subtype" <> '' THEN
    //  "Document Subtype Code" := PurchSetup."NPO Prepayment request subtype";

    //HEI.05<<

    //HEI.36>>
    if grec_IbecorInterfaceSetup.GET then begin
      if grec_IbecorInterfaceSetup."Interface Enable/Disable" then
        EnableIbecorInterface := true
      else
        EnableIbecorInterface := false;
    end;
    //HEI.36<<
    //>>HEI.38
    MaximoStatusIsEditable := true;
    //<<HEI.38

    //HEI.48>>
    if UserSetup.GET(USERID) then
      if UserSetup."Allow deletion ASTRO Whs Rcpt" then
        AstroRemovalVisibility := true
      else
        AstroRemovalVisibility := false;
    //HEI.48<<

    //HEI.56>>
    if ZycusInterfaceSetupL.GET and ZycusInterfaceSetupL."Enabled Zycus Integration" then
      VisibleZycusInterface := true;
    //HEI.56<<
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNewRecord". Please convert manually.

    //trigger (Variable: DocumentSubtypeCodeSetup)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Responsibility Center" := UserMgt.GetPurchasesFilter;

    if (not DocNoVisible) and ("No." = '') then
      SetBuyFromVendorFromFilter;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    //HEI.05>>
    // soicad delete
    // PurchSetup.GET();
    // IF PurchSetup."NPO Prepayment request subtype" <> '' THEN
    // "Document Subtype Code" := PurchSetup."NPO Prepayment request subtype";
    //HEI.05<<
    //HEI.09>>
    DocumentSubtypeCodeSetup.GET;
    DocumentSubtypeCodeSetup.TESTFIELD("Purchase - General");
    "Document Subtype Code" := DocumentSubtypeCodeSetup."Purchase - General";
    //HEI.09<<
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger (Variable: DocumentSubtypeCodeSetup)();
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
    SetDocNoVisible;

    if UserMgt.GetPurchasesFilter <> '' then begin
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
      FILTERGROUP(0);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetDocNoVisible;
    // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1191
    //IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
    if UserMgt.GetPurchasesTextFilter <> '' then begin
      FILTERGROUP(2);
      //SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
      SETFILTER("Responsibility Center",UserMgt.GetPurchasesTextFilter);
      FILTERGROUP(0);

      //<< DITW18.00.07 VSC 26/05/2016 DIT-770 #1984 - DITW110.00.08 DDR 02/01/2017 NRQ#0
      PurchSetup.GET;
      //>> DITW18.00.07 VSC 26/05/2016 DIT-770 #1984 - DITW110.00.08 DDR NRQ#0
    end;
    // >>DITW18.00.06 DDR DIT-770 #1191

    //HEI.08>>
    if "Document Subtype Code" <> '' then
      DocSubtypeEditable := false;
    //HEI.08<<

    //HEI.07>>
    PurchSetup.GET;
    ShowSRMSubpage := ("SRM Order No." <> '') and PurchSetup."Allow VAT Change C&TP Orders";
    //HEI.07<<
    LicensiEdit := true;//HEI.21
    //HEI.09>>
    DocumentSubtypeCodeSetup.GET;
    DocumentSubtypeCodeSetup.TESTFIELD("Purchase - General");
    FILTERGROUP(2);
    SETFILTER("Document Subtype Code",'%1|%2','',DocumentSubtypeCodeSetup."Purchase - General");
    FILTERGROUP(0);
    //HEI.09<<
    */
    //end;


    //Unsupported feature: CodeModification on "SetExtDocNoMandatoryCondition(PROCEDURE 3)". Please convert manually.

    //procedure SetExtDocNoMandatoryCondition();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchasesPayablesSetup.GET;
    VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    PurchasesPayablesSetup.GET;
    VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory";
    //<< DITW18.00.07 AKH 28/03/2016 DIT-770 #1409
    VendorShipmentNoMandatory := PurchasesPayablesSetup."Vendor Shipment No. Mandatory";
    //>> DITW18.00.07 AKH DIT-770 #1409
    */
    //end;
    //BC Upgrade SHARMP16 BEGIN>>------------------------Drink-IT code
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
    //         ReleasePurchDoc.DocStatusRelease(xRec, Rec)
    //     else begin
    //         if Status = Status::Open then
    //             ReleasePurchDoc.DocStatusOpen(xRec, Rec)
    //         else
    //             // >>DITW15.00.00.39 DDR #1330 #1407
    //             TESTFIELD(Status, xRec.Status);
    //     end;
    // end;

    // local procedure MaximumCubageOnFormat();
    // begin
    //     rec.CALCFIELDS("Total Cubage");
    //     FormatMaximumControls(FIELDNO("Maximum Cubage"), "Maximum Cubage", "Total Cubage");
    // end;

    // local procedure MaximumWeightOnFormat();
    // begin
    //     rec.CALCFIELDS("Total Weight");
    //     FormatMaximumControls(FIELDNO("Maximum Weight"), "Maximum Weight", "Total Weight");
    // end;
    //BC Upgrade SHARMP16 end<<------------------------Drink-IT code

    local procedure UpdateAllLineDimNew(NewParentDimSetID: Integer; OldParentDimSetID: Integer);
    var
        ReceivedShippedItemLineDimChangeConfirmed: Boolean;
        NewDimSetID: Integer;
    begin
        // Update all lines with changed dimensions.
        // Hei.21 <<
        if NewParentDimSetID = OldParentDimSetID then
            exit;

        if not HideValidationDialog then
            if not CONFIRM(Text051) then
                exit;

        PurchLine.RESET();
        PurchLine.SETRANGE("Document Type", rec."Document Type");
        PurchLine.SETRANGE("Document No.", rec."No.");
        PurchLine.LOCKTABLE();
        if PurchLine.FIND('-') then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(PurchLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if PurchLine."Dimension Set ID" <> NewDimSetID then begin
                    PurchLine."Dimension Set ID" := NewDimSetID;

                    if not HideValidationDialog and GUIALLOWED then
                        VerifyReceivedShippedItemLineDimChange(ReceivedShippedItemLineDimChangeConfirmed);

                    DimMgt.UpdateGlobalDimFromDimSetID(
                      PurchLine."Dimension Set ID", PurchLine."Shortcut Dimension 1 Code", PurchLine."Shortcut Dimension 2 Code");
                    PurchLine.MODIFY();
                end;
            until PurchLine.NEXT() = 0;
        // Hei.21<<
    end;

    local procedure VerifyReceivedShippedItemLineDimChange(var ReceivedShippedItemLineDimChangeConfirmed: Boolean);
    begin
        // Hei.21>>
        if PurchLine.IsReceivedShippedItemDimChanged() then
            if not ReceivedShippedItemLineDimChangeConfirmed then
                ReceivedShippedItemLineDimChangeConfirmed := PurchLine.ConfirmReceivedShippedItemDimChange();
        // Hei.21<<
    end;

    local procedure CheckCMGMandatory();
    var
        lDimSetEntry: Record "Dimension Set Entry";
        lGenLedgSetup: Record "General Ledger Setup";
        lItemCharge: Record "Item Charge";
        lPurchLine: Record "Purchase Line";
        CMGMandatory: Label 'You must select a Dimension Value for Dimension Code %1 for Line No %2 in Purchase Order %3';
        TradePlan: Record "Trade Plan FDW";
    begin
        //HEI.39>>
        lPurchLine.RESET();
        lPurchLine.SETRANGE("Document Type", rec."Document Type");
        lPurchLine.SETRANGE("Document No.", rec."No.");
        lPurchLine.SETRANGE(Type, lPurchLine.Type::"Charge (Item)");
        if lPurchLine.findset() then begin
            repeat
                if (lItemCharge.GET(lPurchLine."No.")) then begin// and (lItemCharge."Item Charge Type" = lItemCharge."Item Charge Type"::ShippingCost) then begin //BC Upgrade SHARMP16 --functional query
                    TradePlan.Reset();
                    TradePlan.SetRange("No.", lItemCharge."No.");
                    TradePlan.SetRange("Use in Purchase", true);
                    if TradePlan.FindFirst() then begin
                        lGenLedgSetup.GET();
                        lDimSetEntry.RESET();
                        lDimSetEntry.SETRANGE(lDimSetEntry."Dimension Set ID", lPurchLine."Dimension Set ID");
                        lDimSetEntry.SETRANGE(lDimSetEntry."Dimension Code", lGenLedgSetup."CMG Dimension Code FND");
                        if not lDimSetEntry.FINDFIRST() then
                            ERROR(CMGMandatory, lGenLedgSetup."CMG Dimension Code FND", lPurchLine."Line No.", lPurchLine."Document No.");
                    end;//BC Upgrade SHARMP16 --functional query
                end;

            until lPurchLine.NEXT() = 0;
        end;
        //HEI.39<<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    //BC Upgrade SHARMP16 -- Purchprocesschanges BEGIN>>
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        IF PurchaseHeaderAdditional.GET(rec."Document Type", rec."No.") THEN //HEI.20
            PurchaseHeaderAdditional.CALCFIELDS("TO Reference");
    end;
    //BC Upgrade SHARMP16 -- Purchprocesschanges END<<

    //BC UPGRADE VAMSIU01 - Adding Document Subtype related code >>
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        DocumentSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";
    begin
        //HEI.09>>
        DocumentSubtypeCodeSetup.GET;
        DocumentSubtypeCodeSetup.TESTFIELD("Purchase - General");
        Rec."Document Subtype Code FND" := DocumentSubtypeCodeSetup."Purchase - General";
        //HEI.09<<
    end;

    trigger OnOpenPage()
    var
        DocumentSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";
    begin
        //HEI.08>>
        if Rec."Document Subtype Code FND" <> '' then
            DocSubtypeEditable := false;
        //HEI.08<<

        //HEI.09>>
        DocumentSubtypeCodeSetup.GET;
        DocumentSubtypeCodeSetup.TESTFIELD("Purchase - General");
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Document Subtype Code FND", '%1|%2', '', DocumentSubtypeCodeSetup."Purchase - General");
        Rec.FILTERGROUP(0);
        //HEI.09<<
    end;
    //BC UPGRADE VAMSIU01 - Adding Document Subtype related code <<

}
