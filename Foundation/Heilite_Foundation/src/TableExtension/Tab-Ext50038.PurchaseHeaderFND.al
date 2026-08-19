tableextension 50038 PurchaseHeaderExtFND extends "Purchase Header"
{
    // version NAVW110.0.00.19831,FINXL10.00,MANXL7.00.001,DITW110.00.12,NRQ157810,HEI.54
    //     DITW15.00.00.01 DDR 27/12/2007 Added field2034647 Drink Tax Group Code
    // DITW15.00.00.01 DDR 02/01/2008 rename field
    //                                  2034647 Vendor DTax Group Code + Filter to the source table
    // DITW15.00.00.01 DDR 04/01/2008 added field
    //                                  2013610 Vendor DDeposit Group Code
    // DITW15.00.00.01 DDR 15/01/2008 added function to insert Charges into function RecreatepurchLines()
    // DITW15.00.00.01 DDR 31/01/2008 Added Drink-it Reversing Calculation (Rounding) functionnalities
    //                                Added fields
    //                                 2034690 Price Incl. Reversing Calc.
    // DITW15.00.00.01 DDR 04/02/2008 added function ReCalcReversePrice() for all lines
    // DITW15.00.00.01 DDR 27/02/2008 Remove field (see lines)
    //                                  2034690 Price Incl. Reversing Calc.
    //                                Added key "Link Purch. Document Type,Link Purch. Document No."
    // DITW15.00.00.01 DDR 19/03/2008 Added message if change field "Shipment Method Code"
    //                                Added fields
    //                                  2034675 Item Charge Type Filter
    //                                Added filter into flowfields Amount,"Amount Including VAT"
    //                                Renumber fields
    //                                  2013616 No. of Link Purch. Orders (flowfield)
    //                                  2013614 Link Purch. Document Type
    //                                  2013613 Link Purch. Document No.
    //                                  2013615 Print Link Document
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.15 DDR 26/03/2008 Update function RecalcBackPurchLines() new parameter
    // DITW15.00.00.19 DDR 07/04/2008 Update function RecalcBackPurchLines()
    //                                Replace InsertCharges2() -> InsertCharges4()
    // DITW15.00.00.20 DDR 06/06/2008 Certification rules
    // DITW15.00.00.21 DDR 18/06/2008 Added fields
    //                                  2014060 Maximum Weight
    //                                  2014061 Maximum Cubage
    //                                  2014062 Shipping Charge Type
    //                                  2014063 Shipping Charge No.
    //                                  2014064 Shipping Charge Per
    //                                  2014067 Total Weight (sum flowfield [Lines])
    //                                  2014068 Total Cubage (sum flowfield [Lines])
    //                                  2014075 Shipping Agent Code
    //                                  2014076 Shipping Agent Service Code
    //                                  2014081 Shipping Unit Cost
    //                                  2014082 Shipping Cost Amount
    //                                Added key
    //                                  "Shipping Agent Service Code,Shipping Agent Code,Location Code"
    //                                Added function UpdateShippingUnitCost()
    // DITW15.00.00.23 DDR 25/07/2008 Save current record with new item charges into function RecreatePurchLines()
    //                     01/08/2008 Added function RefreshAndRecalcBackPurcsLines()
    // DITW15.00.00.23.04 DDR 15/09/2008 Added Shipping agent code when fill in Sell-to Customer and no Ship-to code
    // DITW15.00.00.24 DDR 14/08/2008 Bugfix transfer Agent & agent service code from customer when use "Ship-To-Code"
    //                                Added fields
    //                                  2014087 Distance
    //                                  2013797 Disc.Promo. Order Calculated
    //                     29/08/2008 Bugfix to calculate the field "Item charge value" with "Prices Including VAT" field
    //                     07/10/2008 Added fields
    //                                  2013722 Duty Tax Type
    // DITW15.00.00.25 DDR 10/10/2008 Added optionstring 'ShippingCost' for field "Item Charge Type Filter"
    //                     16/10/2008 Added fields
    //                                  2014077 Truck Code
    //                                  2014078 Driver Code
    //                                Remove function UpdateShippingUnitCost()
    //                                Remove fields
    //                                  2014062 "Shipping Charge Type"
    //                                  2014063 "Shipping Charge No."
    //                                  2014081 "Shipping Unit Cost"
    //                                  2014082 "Shipping Cost Amount"
    //                     21/10/2008 Deleted fields
    //                                  2013722 Duty Tax Type
    //                                  2014062 Shipping Charge Type
    //                                  2014063 Shipping Charge No.
    //                                  2014081 Shipping Unit Cost
    //                                  2014082 Shipping Cost Amount
    //                                 Added Vendor DTax Group by "Order Address"
    //                                 Added function UpdateShippingMax()
    // DITW15.00.00.26 DDR 17/11/2008 Copy Max. Weight/Cubage from Truck code
    //                                Added function UpdateTruckShippingMax()
    // DITW15.00.00.28 DDR 24/11/2008 Added fields
    //                                  2013726 Tax Registration No.
    //                                  2013730 Fiscal Representative No.
    // DITW15.00.00.32 DDR 08/04/09 Added Drink tax roundings
    // DITW15.00.00.34 DDR 17/06/2009 Added functions GetStatusCaptionClass(),GetFieldCaption()
    //                     09/07/2009 Added Text constant Text2013661
    //                                Added check to keep same Drink Tax, Deposit groups when existing partial shpt/return lines
    //                                Added functions
    //                                  IsNeedTaxReg(),TestMsgTaxRegistration()
    //                     10/07/2009 Recreate sales lines when change "shipment method code" (for Drink Discounts/Promotions)
    // DITW15.00.00.35 DDR 22/06/2009 Added fields
    //                                  2013611 Empty Goods Item No. Filter
    //                     24/06/2009 issue 669 Added fields
    //                                  2013824 Gen. Bus. Posting Free Group
    //                                  2013825 Free Item Posting Type
    //                     28/07/2009 issue 669 Bugfix RecreateSalesLines() to remove all attached lines
    //                     18/08/2009 issue 766 Bugfix function IsNeedReg() replace customer with vendor
    //                     21/08/2009 issue 783 Skipped Extended Text lines if necessary when recreate lines
    //                     13/10/2009 issue 722 Updated Filters - TableRelation property field "Empty Goods Item No. Filter"
    //                     26/10/2009 issue 924 Rename captions + optioncaptions
    //                                  "Free Item Posting Type" -> "Calculate Price on Free"
    //                                    ' ,Price,Amount' -> 'Full Amount,Price 0,Discount 100%'
    // DITW15.00.00.36 DDR 23/11/2009 issue 939 Updated parameter function CalcBackUnitPriceItem(),CalcBackDirectCostItem()
    //                     18/12/2009 issue 736 Added call SetSkipUpdateShippingHeader() when recreate lines from header
    // DITW15.00.00.37 DDR 04/02/2010 issue 1033 Convert field2013797 Disc.Promo. Order Calculated into flowfield based on lines
    //                     23/04/2010 issue 1069 Avoid recreate item charge lines when call the line function UpdateAmounts
    //                                           Added function SuspendStatusCheck()
    // DITW15.00.00.38 DDR 13/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    2014271 Tax Warehouse Reference
    //                                  Fill in fields from customer or Ship-to address
    //                                    "Transaction Type","Transport Method","Transaction Specification",
    //                                    "Exit Point","Area Code"
    //                     25/10/2010 issue 1139 SSCC Functionnalities
    //                                  Include SSCC reservation management
    //                                  Added text constants Text2035041
    //                     04/01/2011 issue 1217 (DIT711 105) Modified to check the Tax Registration no.
    //                     27/01/2011 issue 1217 (DIT711 137)
    //                                  Modified Caption field2013730 "Fiscal Representative No."
    //                                  Added fields
    //                                    2014460 Tax Office Code
    //                     01/02/2011 issue 941 Modified OptionCaption property field2013825 "Free Item Posting Type"
    //                     23/02/2011 issue 1286 Modified the source of "Vendor DTax Group Code" depending of
    //                                             setup "Sell-to/Bill-to DTax Gr. Calc." (= Buy-from No/Pay-to No.) field (Gen. Ledger Set
    //                     10/05/2011 issue 718 Added to skip Prepayment with negative DIT item charges
    // DITW15.00.00.39 DDR 06/07/2011 issue 1353
    //                                  Added functions GetJourneyTime()
    //                                  Added fields
    //                                    2014290 Journey Time
    //                     27/07/2011 issue 1407
    //                                  Bugfix parameter called function InsertCharges4()
    //                                  Added fields
    //                                   2013666 Autom. Item Charge
    //                                  Added functions DeleteChargePurchLines()
    //                     01/08/2011 issue 1353 fill in "Journey time" with "Shipping time" when first one is empty.
    //                     04/08/2011 issue 1353 Modified caption field2014290 "Journey Time"
    //                     11/08/2011 issue 1407 Added functions ExistWhseLocationLine()
    //                     16/08/2011 issue 1407 Added optionstring field2013666 Autom. Item Charge
    //                     19/08/2011 issue 1363
    //                                  Added fields
    //                                    2013733 Tax Date
    //                    22/08/2011 issue 1399
    //                                  Added fields
    //                                    2014103 Whse. Shipment No. (First)
    //                                    2014104 Whse. Shipment Status (First)
    //                    31/08/2011 issue 1403 Added fields + key
    //                                    2034929 Service Order No.
    //                    27/09/2011 issue 1363 Bugfix to update "Tax Date" from "Expected Receipt Date"
    //                    28/10/2011 issue 1457 Modified many ML captions
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields
    //                                    2014495 Delivery Sequence
    //                     22/12/2011 DIT-715 issue 187
    //                                  Added fields
    //                                    2014277 Transport Mode (flowfield)
    //                                    2014291 Transport Mode Comment (flowfield)
    //                     24/01/2012 DIT-715 issue 203 Bugfix always to copy "Fiscal Representative" from Order address
    //                                DIT-715 #244 Added functions GetCaptionClassUom(),ShowShortcutUomValue()
    //                     20/02/2012 DIT-715 #245
    //                                  Added fields
    //                                    2014065 Truck Size
    //                                  Modified 'TableRelation' property field2014077 Truck Code
    //                     27/02/2012 DIT-715 #245 Remove flowfield 2014065 Truck Size
    //                                             Added Lookup trigger field2014077 Truck Code
    //                                             Modified 'TableRelation' property field2014077 Truck Code
    //                     11/06/2012 DIT-715 #313 Added to update all periodic discout/promo worksheet lines while deleting header
    // DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 Plant Maintenance Functionnality
    //                                             Renamed field 2034929 Service Order No. -> field 2014426
    // DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added fields
    //                                               2034850 DIT Sub-Contract Type
    //                                               2034872 Contract Group Code
    //                                               2034915 Service Contract No.
    //                                               2014311 Service Contract Type
    //                     06/08/2012 DIT-715 #327 Added 'Type5,No5' parameters function CreateDim()
    //                 AHU 13/08/2012 DIT-715 #327 Renamed Captions fields2034915,2034310,2014311
    //                                             Added default value field2014311 "Service Contract Type"
    //                                             Keep value field2034850 "DIT Sub-Contract Type" while modifying "Service contract
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields
    //                                               2013630 Deposit Vendor Posting Group
    //                                               2013631 Deposit Payment Terms Code
    //                                               2013632 Deposit Payment Method Code
    //                                               2013633 Deposit Bal. Account Type
    //                                               2013634 Deposit Bal. Account No.
    //                                               2013638 Deposit Posting No.
    //                                               2013639 Last Deposit Posting No.
    //                     13/12/2012 DIT-715 #522 Added read dimension based on sales setup field "Pay-to/Buy-from Dimensions"
    //                                             Added functions GetVendCalcDim()
    //                     18/12/2012 DIT-715 #517 Added "Location Filter" with function ShowShortcutUomValue()
    //                     19/12/2012 DIT-715 #517 Added "Location Filter" for fields "Total Weight","Total Cubage" (CalcFormula property)
    //                     01/03/2013 DIT-715 #572 Added to fill in "Order Date" for Quote,Blanket Order
    //                     11/03/2013 DIT-715 #582 Bugfix don't change "Tax Date" on "Posting Date" (invoice, credit memo)
    //                 DDR 02/08/2013 DIT-715 #691 Review flow to recreate charge lines while modifying the related header fields
    //                 DDR 09/08/2013 DIT-715 #655 Keep "Free Item" on sales lines while calling function RecreatePurchLines()
    //                 DDR 23/08/2013 DIT-715 #691 Bugfix missing to recalculate the item prices including charges
    //                 DDR 15/10/2013 DIT-715 #763 Bugfix to have the last Sales Header while recreating dit charge lines
    //                                               + Revalidate all EMCS fields
    //                 DDR 19/12/2013 DIT-715 #860 Added HasBeenShow for many Confirm message
    //                 DDR 17/01/2014 DIT-715 #863 Added to recalculate Composed items (Giftbox)
    //                                             Bugfix function GetFieldNoFromName()

    // FINXL7.00.001 RBE 06/08/2013 : Default value for fields: Transaction Type, Transport Method, Area
    // FINXL7.00.001 KLU 25/09/2013 : Added field "Approved Amount"
    // FINXL7.00.006 KLU 03/10/2013 : Run fctAutoInsertPurchaseLines

    // MANXL7.00.001 DAT 05/03/2014 #17: Added field "Valid Until" for blanket orders
    //                                   Added key: "Document Type,Document Date,Valid Until"
    // MANXL7.00.001 WSA 11/07/2014 #87: Added code MANXL security
    // FINXL8.00.001 BSA 23/04/2015 #170: Remove TestField from fields "transaction type", "transport method" and area
    // FINXL8.00.001 BSA 27/05/2015 #183: Change pay-to vendor after posting receipt.
    // FINXL8.00.001 BSA 03/06/2015 #182: Added Field : "Emergency Order"
    // FINXL8.00.001 BSA 10/06/2015 #85 : Added Field "Last changed User ID", "Last changed Date/time"
    // FINXL8.00.001 BSA 16/06/2015 #124 : Added Field "OGM"
    // FINXL8.00.001 BSA 05/06/2015 #182 : Added Check to prevent insertion of std vendor lines from Planning worksheet
    // FINXL9.00.001 DAT 23/12/2015 : Skip updating "Last changed User ID", "Last changed Date/time" from the Purchase Line

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 04/06/2013 DIT-770 #99 Added update field "Ship-to Country/Region Code" into Lines
    //                  04/07/2013 DIT-770 #99 Added fields
    //                                           2014560 GWC Country/Region Code"
    //              DDR 01/08/2013 DIT-770 #118 Keep Free item field while recreating lines
    //              DDR 06/08/2013 DIT-770 #691 merge
    //              DDR 09/08/2013 DIT-715 #655 merge (sse also DIT-770 #118)
    //                  23/08/2013 DIT-770 #691 merge
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #99
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0012.1
    //                             Added Field
    //                             2014430 Requester ID
    //                             Code add in OnInsert trigger
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0012.3
    //                             Translation of "Requester ID"
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0014.1
    //                             interdoc approval
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "2035390" Added
    //                                         : New Code Added to validate Link Customer No. from Vendor
    //                                         : Code Added to Validate Customer Default Dimension in Order
    // DITW17.00.02 DDR 15/10/2013 DIT-715 #763 merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 AT  26/11/2013 DIT-770 #150
    //                             Allow to Change VAT Business Posting Group for Invoice & Credit Memo when Receip Lines selected
    // DITW17.00.02 AT  04/12/2013 DIT-770 #150
    //                             On Change of VAT Business Posting Group,It should not delete the purchase line.
    //                             It should only change the VAT Bus. Posting group in the lines and thereby recalculate VAT fields only.
    // DITW17.00.02 DDR 19/12/2013 DIT-715 #860 merge
    // DITW17.00.02 SR 19/12/2013 DIT-770 #163 : Remove the "DIT Sub-Contract Type" filter in "Service Contract No." field
    // DITW17.00.02 DDR 16/01/2014 DIT-770 #322 Bugfix to get default dimensions from Vendor
    // DITW17.00.02 DDR 17/01/2014 DIT-770 #863 merge
    // DITW17.00.02 AT  20/01/2014 DIT-770 #313 : "Requester ID" Size increased from 20 to 50
    // DITW17.10.03 AT  05/02/2014 DIT-770 #340 : Added code to update Vendor Posting Group
    //                                          : Allow to blank Sub Contract type
    //                                          : Added filter on Vendor Posting Group on Opening Applies to Entry
    // DITW17.00.03 DDR 10/03/2014 DIT-770 #519 Bugfix to fill in "Order Date" while inserting new document
    // DITW17.10.03 MSF 17/03/2014 DIT-715 #340 :Add the same options as table 81 to field "Apply To doc Type"
    // DITW17.10.03 MSF 06/05/2014 DIT-770 #662 :Impossible to use currencies in purchase invoice 'Divide by zero"
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields
    //                                                          2014410 Physical Location Group Code
    //                                                          2014500 Resp. Center Table Filter
    //                                                          2014501 Phys. Location Table Filter
    //                                                          2014502 Location Table Filter
    // DITW18.00.06 DDR 24/02/2015 DIT-770 #1249 TEMP SOLVED for DIT-770 #1191
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1191 Multisite - Bugfix to insert new document
    // DITW18.00.06 DDR 26/02/2015 DIT-770 #1191 Multisite - Bugfix to change location from Responsibility center
    // DITW18.00.06 DDR 26/02/2015 DIT-770 #1191 Multisite - Added confirm with default customer values
    //                                                       Removed Phys. Location on 'TableRelation' property field28 Location Code
    // DITW18.00.06 DDR 27/02/2015 DIT-770 #1191 Multisite - Bugfix to check customer location code
    // DITW18.00.06 DDR 02/03/2015 DIT-770 #1191 Multisite - Bugfix missing validate default customer resp. center
    //                                                       Modified function SetSecurityFilterOnRespCenter()
    // DITW17.10.05 MSF 16/07/2014 DIT-770 #690 error on contract type when posting general journal via EP
    //                                          Remove Init Value Financial on field service contract type
    //                                          Review c/al when validate("Contract Type","Contract Type"::Financial) only when dit contracts are included in license
    // DITW17.10.05 MSF 17/07/2014 DIT-770 #698 (Customer)Vendor suspended tax determined per document line + internal taxes (PART 2)
    //                                          Update "Vendor DTax Group Code" Pruchase lines
    // DITW17.10.05 DDR 19/08/2014 DIT-770 #776 Added Deposit point functionality
    // DITW17.10.05 DDR 15/12/2014 DIT-770 #1122 Bugfix refresh Tax/Emcs item fields while recreating tax lines
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW17.10.05 DDR 26/01/2015 DIT-770 #885 Bugfix recreating item charges while changing "order date" with sales condition on 'order date'
    // DITW17.10.05 MSF 12/03/2015 DIT-770 DIT-770 1149 XL: G/L setup - Extra: without values
    // DITW17.10.05 MSF 12/03/2015 DIT-770 DIT-770 #690
    // DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362 Fix Dimension Priorirties
    // DITW18.00.06 MSF 13/05/2015 DIT-770 #1212 #1213 #1214 Modify lookup page for "Driver code" "Shipment Agent code" "Truc code"
    // DITW18.00.06 MSF 05/06/2015 DIT-770 #1416 #1417 Error message when no setup on Resp Center employee location
    // DITW18.00.06 MSF 11/06/2015 DIT-770 #1416 #1417 Restore Code and Bug Fix
    // DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214 CLeane code
    // DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214 Added Field Resp. Center Table Filter 2
    //                                                       Modify lookup property for field Driver code , Truck code , trailer code
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                           Added field 2014319  "Financial Contract No."
    //                                           Rename Caption Contract No. by Service contract No.
    //                                           Added function GetContractNo
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Added blank Option to Contract Type
    //                                           Rename option Service contract,DIT contract to Service,Financial
    // DITW18.00.06 DDR 07/08/2015 DIT-770 #1368 Various adjustments
    // DITW18.00.06 MSF 08/09/2015 DIT-770 #1534 :Resp. centre with Phys. Location group and Location code gives conflict
    // DITW18.00.06 MSF 10/09/2015 DIT-770 #1600 Location (blank) error in purchase documents
    // DITW18.00.06 MSF 15/05/2014 DIT-770 #1611 ached shipped lines are removed after change shipment date or shipment method
    // DITW18.00.06 MSF 17/09/2015 DIT-770 #1600 Location (blank) error in purchase documents
    // DITW18.00.06 DDR 19/10/2015 DIT-770 #1652 Bugfix Recreate promotion items while changing order/shipment date
    // DITW18.00.07 AKH 11/02/2016 DIT-770 #1804 Sundry Vendor
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Several adjustments
    // DITW18.00.07 MVN 24/02/2016 DIT-770 #1397 Added Field 2014300 "Submission Type" (EMCS)
    // DITW18.00.07 VSC 07/03/2016 DIT-770 #1066 Delete Document Shipping Costs
    // DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 New Field "Auto Create Shipping Cost" + Function CreateShippingCost
    // DITW18.00.07 MVN 17/03/2016 DIT-770 #1253 Check Permissions on Loyalty with License
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 New Functions HasDocumentShippingCosts an OpenDocumentShippingCosts Like Flowfield, Flowfield it self not posible due to Type Conversion error Integer -> Option
    //                                           Copy default Shipping Agent and service code from vendor.
    //                                           Moved Function CreateShippingCost to CU "Warehouse & Transport Mgt." as CreatePurchShippingCost
    // DITW18.00.07 AKH 23/03/2016 DIT-770 #1804 Adjustments
    // DITW18.00.07 MVN 07/04/2016 DIT-770 #1397 Auto Fill Field 2014300 "Submission Type" (EMCS)
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field 2014421 "Document Subtype Code"
    // DITW18.00.07 DDR 14/04/2016 DIT-770 #1109 Bugfix Review flow to show "update" confirmation once
    //                                           Added HasBeenShowText2014096
    //                                           Modified functions InitHasBeenShow()
    //                                           Added functions ClearHasBeenShowAll2()
    // DITW18.00.07 AKH 20/04/2016 DIT-770 #1941 Added price calculation based on vendor field "Pay-to/Buy-from Prices Calc."
    // DITW18.00.07 DDR 26/04/2016 DIT-770 #1963 Bugfix missing purchase header in function RecalcBackPurchLines()
    // DITW18.00.07 AKH 27/04/2016 DIT-770 #1346 Added fields 2014080 "Vendor Delivery Type"
    //                                                        2014081 "Delivery Time (sec.)"
    // DITW18.00.07 DDR 02/05/2016 DIT-770 #1402 Modified validation of Location Code and update lines in batch mode
    // DITW18.00.07 AKH 10/05/2016 DIT-770 #1346 Added "Vendor Delivery Type" from Order Address code
    // DITW18.00.07 AKH 11/05/2016 DIT-770 #1941 Bugfix for Payment method and Payment terms from Buy-from
    //                                           Corrected option value for ResultType in function IsVendCalcTaxes()
    // DITW18.00.07 VSC 29/04/2016 DIT-770 #1968 Synch from Sales Header
    // DITW18.00.07 VSC 09/05/2016 DIT-770 #1971 - #1976 Totals on Purchase Order Header (weight, cubage, volume HL, shortcut unit of measures)
    // DITW18.00.07 VSC 23/05/2016 DIT-770 #1968 - #1978 Synch from Sales Header
    // DITW18.00.07 VSC 24/05/2016 DIT-770 #1968 Add Field "Receipt Status" (inbound)
    // DITW18.00.07 VSC 24/05/2016 DIT-770 #1984 Synch Sales conditions to purchase (in order and Route Planning)
    // DITW18.00.07 VSC 25/05/2016 DIT-770 #1968 Bugfix Merge error > sales to purch.
    // DITW18.00.07 VSC 25/05/2016 DIT-770 #1968 Rework "Delivery Sequence" never use from customer/ship-to
    // DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 Purchase: Update and/or recalculate lines after release
    // DITW18.00.07 VSC 27/05/2016 DIT-770 #1975 Aditional  #159 - #289 -  #1488
    // DITW18.00.07 VSC 27/05/2016 DIT-770 #1975 -> #1402 Merge small first part.
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW18.00.07 VSC 21/06/2016 DIT-770 #1228 Fix field error
    // DITW18.00.07 VSC 23/06/2016 DIT-770 #2058 New Generic SetRoute Function. Used on several objects creating a document
    // DITW18.00.07 DDR 28/06/2016 DIT-770 #1265 Bugfix RecreateSalesLines from Sell-to/Bill-to
    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time", "Created By"
    // DITW18.00.07 DDR 28/06/2016 DIT-770 #1488 Bugfix missing skip status release while recreating lines
    // DITW18.00.07 VSC 05/07/2016 DIT-770 #1282 Use Today and not workdate
    // DITW18.00.07 VSC 04/07/2016 DIT-770 #1066 New Encapsulate function CreateShippingCost() for preventing License error
    // DITW19.00.08 DDR 12/08/2016 BL#10314 (DIT-770 #1488) Modified skip "Route" for other document types
    // DITW19.00.08 DDR 19/08/2016 BL#10314 Bugfix missing "Responsibility Center" update after release
    // DITW19.00.08 MSF 05/09/2016 BL#10387 (DIT-770 #1274) If receipt/return shipment, dont allow to modify the tax reg no or whse ref
    //                                                      Change Function ReceivedPurchLinesExist & ReturnShipmentExist from local to global

    // DITW19.00.08 MSF 09/09/2016 BL#10387 (DIT-770 #1274) Function ReceivedPurchLinesExist & ReturnShipmentExist
    //                                                      Use local Variable Instead of Global Variable
    // DITW19.00.08 AKH 27/10/2016 BL#11231 (DIT-770 #2119) Added functions CheckIfRouteAllowed() & GetRouteFilter()
    //                                                      Adjusted code in functions SetRoute() & DrillDownRouteCombinaison()
    //                                                      Added filter on Responsibility Center in TableRelation of field Route
    // DITW19.00.08 DDR 01/12/2016 BL#10314 (DIT-770 #2129) Bugfix conflict to validate double "shipping agent code" default values from Route
    //                                                         within "Shipment Method Code" and Route itself.
    // DITW19.00.08 VSC 05/12/2016 BL#9711 (DIT-770 #1921) Fix check for Neg. Invoice Totals. And Fix ENU Caption. to "%1 must not be more than %2."

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 16/02/2017 NRQ#20755 Update document subtype code table relation filter
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // DITW110.00.09 DDR 21/03/2017 NRQ#13144 Fix 1st paramater function GetSubmissionType()
    // FINXL9.00.001 ACH 11/08/2016 : Default value for fields: Transaction Type, Transport Method, Area
    // FINXL9.00.000.01 AKH 13/01/2017 Added code to change "Pay-to Vendor No." / "VAT Bus. Posting Group" after receipt posting
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.10 MSF 19/05/2017 NRQ#13382 Purchase documents do not get Dimension Values from Vendor
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 MSF 15/06/2017 NRQ#13382 Vendor dimension overwriten when validate Linked customer
    //                                        Added parameter to function CreateDim
    // FINXL10.01 OFE 30/08/2017 NRQ#10433: Added function TestLinePriceMandatory()
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added Field Multiple Order Route
    //                                        Added Function UpdateWhseRequestLines
    //                                        Added Function CheckExistWarehouseLine
    // DITW110.00.11 MSF 13/11/2017 NRQ#16082 Wrong Filter used should be on Purchase line instead of Sales lines
    // DITW110.00.11 MSF 30/11/2017 NRQ#16082 Delete Check on Multiple Route Order for some fields
    // DITW110.00.12 MSF 12/04/2018 NRQ#67279 When recalculate lines by sales condition fiedls  then the Free Reson code  is not saved
    // DITW111.00.13 MSF 04/09/2018 NRQ#83542  Posted Invoice/credit memo No. series per Document subtype
    // DITW111.00.13 MSF 05/09/2018 NRQ#83542  Added function SetDefaultPostingSerialno

    // HEI.01 PTPGAP066 IBM SOICAD01 29.06.2017 Purchase to Pay– Bank account for payment
    //   # New field Vendor Bank Account, FlowField IBAN
    // HEI.02 HLSRM02-05 IBM LAZARE02 27.07.2017
    //   #New fields for SRM integration
    //   #Skip confirm dialog box for dimension update when HideValidationDialog is true
    // HEI.03 PURGAP05 IBM LAZARE02 31.07.2017
    //   #Extend City fields to 35; Extend Address and Address 2 fields to 60
    // HEI.04 PTPGAP064 IBM POENAB01 16.08.2017
    //   # Transmit "Document Subtype Code" from Purchases & Payables Setup
    // HEI.05 PTPGAP009  IBM.CHAUHB01  18/08/2017
    //   # Added new field
    //     RUID
    // HEI.06 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //   # New fields for MDM integration
    // HEI.07 FDD-PTPGAP007 IBM PATHAA02 29.08.2017
    //   # Code written on Payment Method Code-OnValidate
    // HEI.08 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "ShipToCity" local variable length from 30 to 35 characters
    // HEI.09 FDD-PURGAPINT002 IBM LAZARE02 25.09.2017
    //   # New field "Maximo Requisition No."
    // HEI.10 FDD-PTPGAP013 IBM PATHAA02 28.09.2017
    //   # New field "Payment status"
    // HEI.11 PTPGAP041 IBM PATHAA02 28.09.2017
    //   # New Field "Payment User"
    //   # new Field "Status Date"
    // HEI.12 PTPGAP007 IBM PATHAA02 05.10.17
    //   # code added on "Buy-from vendor No."-OnValidate
    // HEI.13 FDD-PTPGAP067 IBM SOICAD01
    //   new field pre "Prep. to reverse"
    // HEI.14 HLSRM02-05,FDD-PURGAPINT002 IBM LAZARE02 04.12.2017
    //   # New publisher OnAfterTransferSavedFields
    // HEI.15 FDD-PTPGAP071 IBM PATHAA02,LAZARE02
    //  Dimensions are not allowed to be changed coming from PO
    //  # Condition added in function ShowDocDim;
    // HEI.16 HLSRM03 IBM LAZARE02 11.12.2017
    //   # New function GetBlanketOrderPrice
    // HEI.17 Defect#1337 IBM.CHAUHB01 20/12/2017
    //   # Added code to validate Vendor Bank Account Field
    // HEI.18 PTPGAP085 - IBM HORTOC01 20.03.2018
    //   # validate on hold field,add new fields
    // HEI.19 PTPGAP004b SOICAD
    // HEI.20 FDD PTPGAP081 IBM POSTOI01 07.05.2018
    //   # modify OnDelete trigger
    //   # Purchase Archive requirements - only purchase incoices and purchase credit memos with Document Subtype Code =PO/NPO/EXP.CLAIM should be archived
    // HEI.21 RFC-CHG0249183 IBM.LS 04.10.2018
    //   # Added code to create function as SendEmailPurchaseOrder.
    // HEI.22 RFC-CHG0246348 IBM.AB 18.10.2018
    //   # Added new field "Purch. Reason Code"
    //   # Added code to make Purch. Reason Code mandatory
    //   # Added Code In Purch. Reason Code not to change if Status is Released
    // HEI.23 RFC-CHG0255774 IBM.AB 15.10.2018
    //   # Code added to validate Shipping Agent Code
    // HEI.24 FDD_Rwanda_Bralirwa_Esker_ Interface_V0.3_HT75 IBM POSTOI01
    //   # new key : Document Type, Status, Pay-to Vendor No.
    // HEI.25 FDD-BA-PURGAP03- Bottle Recycling Centre - V2.6 IBM.NAIKH01 21.11.2018
    //   # Added a new Field 50036 "BRC Purchase Order" to differentiate the BRC PO and standard PO.
    // HEI.26 RFC-CHG0246348 IBM.SS 16.01.2019
    //   Code added for Item category
    // HEI.27 FDD-PURGAP030 - Send updated PO to supplier with specified  changes_V1.1, IBM.NAIKH01 , 21.01.2019
    //   # Added new field 50039 "Changed"

    // HEI.29 RFC-CHG0249183 IBM.LS 16.04.2019
    //   # Added code to bypass the error on releasing the PO while Vendor E-mail address is blank.
    // DITW111.00.13A MSF 16/04/2019 NRQ#105344 Order discounts and Æpromotions should be inserted before approval
    //                                         Added Function IsCalcDiscountPromOnPosting
    // DITW111.00.13A MSF 09/05/2019 NRQ#109271 Disable DIT Discounts and or Promotions for a sales documents
    //                               Added Field "Disable DIT Disc. Prom."
    // HEI.30 FDD-PURGAP027 IBM NASTAA02 14.06.2019 # Maximo POs Approval Flow
    //   # Changed Caption of Field "Payment User" from "PQ Approver" to "Payment User"
    //   # Added new FlowField 50040 - PQ Approver
    // HEI.35 DefectID #4382 CHG2032888 IBM GAVANM01 04.10.2019 # CONFIRM function skipped when GUIALLOWED=false
    // HEI.31 CHG0255774_FDD_TC_Calculation_Enhancement IBM NANDIS01 08.07.2019
    //   Validation added to show error message when the shipping agent is not ticked as Own Logistics
    // HEI.32 Defect #4394 IBM NASTAA02 27.08.2019 # Automail functionality Bug
    //   # Added filter on "Document Subtype Code" in function "SendEmailPurchaseOrder"
    // NRQ#122316 MSF 04/10/2019  sales price for promotion items
    //                         Merge PBI NRQ#41769 and NRAQ#88589
    // HEI.34 FDD-HT658 CHG2024493 IBM.GUNERE01 22.10.2019 # Buy-from Vendor No. - OnValidate func. modified
    //                                                       Shipment Method Code - OnValidate func. modified,
    //                                                       Shipping Agent Service Code - OnValidate func modified,
    //                                                       Route - OnValidate, Distance - OnValidate,
    //                                                       Truck Code - OnValidate, Driver Code - OnValidate funcs modified
    //                                                       FilterWhseShippingTrucks, FilterWhseShippingDrivers funcs. created
    //                                                       CreateShippingCost func. modified.
    //                                                       Truck Code, Driver Code Tablerelation fix.
    // HEI.36 FDD-HT658 CHG2024493 IBM.GUNERE01 04.11.2019 # Shipment Method Code - OnValidate, Buy-from Vendor No. OnValidate func. modified
    // HEI.37 FDD-HT771 IBM SURYAS01 10-jan-2020 - "To calculate Currency Factor when changing the Document Date instead of changing the Posting Date"
    //  #Added Code in "Document Date Onvalidate" Trigger and commented code in "Posting Date Onvalidate" trigger.
    //  #modified Code in UpdateCurrencyFactor Function
    // HEI.38 FDD-HT1075 CHG2039144 IBM.GUNERE01 15.01.2020 # FilterShippingAgentServiceCode func. added
    //                                                        Shipping Agent Service Code - OnLookUp func. modified
    //                                                        CreateShippingCost func. property changed to global from local
    // HEI.39 FDD- HT821 IBM SHANKJ03 11.02.2020
    //  # Maximo Status flowfield added
    // HEI.40 FDD-HB858 - CHG2027215 SHANKJ03 IBM 23.01.2020
    //   # Added Calcformula for House Number Field
    // HEI.41 CHG2038388 FDD-HB1005 IBM GUNERE01 17.02.2020 # "Shopping Card No." field added
    // HEI.42 FDD-HT1075 CHG2039144 IBM.GUNERE01 16.03.2020 # FilterShippingAgentServiceCode func. modified
    // HEI.43 CHG2055070 IBM.SHANKJ013
    //   #Added field License Code

    // FINXL14.00.15 MSF 13/05/2020 NRQ#117628 Enable /Disable AutoSend To IC
    //                              Added Function IsAutoSendDocEnabled
    // HEI.44 CHG2058828 IBM NANDIS01 20.05.2020 GR IR Writeoff
    //   # Code added to take the posted no series for GR IR Invoice
    // HEI.45 Defect6005 BULIMC01 IBM 16.09.2020 #bug fix related to HEI.44 change (No Series)
    // DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix SalesHeader for function RecalcBackSalesLines()
    // NRQ#157810 MSF 23/09/2020 Merge DIT PBI NRQ#34181 (partial Merge only for purchase)
    // DITW114.00.15 DDR 26/03/2020 NRQ#140339 Fix "item charge value" with function RecreatePurchLines()
    // DITW114.00.15 DDR 01/04/2020 NRQ#140339 Fix Recalculation tax include price on some validation cases
    // HEI.46 CHG2088611 IBM SHANKJ03 25.11.2020
    //   # uncommented code for Purch. Reason Code

    // HEI.47 CHG2091605 IBM NANDIS01 18.12.2020 invoice reference issue
    //   # Change in function InitRecord against fix on CHG2058828 - HEI.44
    // NRQ#168174 MSF 07/01/2021 Error message when creating a purchase credit memo
    // HEI.48 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New flowfield created: 50046 - LSR Order No
    // HEI.49 CHG2096764 IBM pandes01  15.03.2021
    //  # Added code for Requesters ID.
    // CHG2112934 NRQ182941 HGUI 31/05/2021 Posting CRMemo error message (deposit vendor credit memo no must have value) (NexGen Corrective Change No.-CHG2112934)
    // HEI.50 CHG2119178 IBM.AS 30.06.2021
    //   # HeiLite Base Stability Changes for Posting functions at JOB NAS
    //   # Adding GUIAllowed function added in Functions OnDelete(), MessageIfPurchLinesExist(),  PriceMessageIfPurchLinesExist(),
    //   TestMsgTaxRegistration(), SendEmailPurchaseOrder(), Prices Including VAT - OnValidate(), VAT Base Discount % - OnValidate(),
    //   Buy-from Contact No. - OnValidate(), Pay-to Contact No. - OnValidate(), ConfirmUpdateCurrencyFactor(), ConfirmResvDateConflict(),
    //   UpdateAllLineDim(), IsApprovedForPosting(), ConfirmUpdateDeferralDate(),
    // HEI.51 Defect #6462 IBM NASTAA02 08.09.2021 # Defect on invoice - License code
    //   # Code added on function 'CreateDim'
    // HEI.52 CHG2103752 IBM BHATTA09 07.09.2021
    //   # New Option PendClose added in Maximo Status field
    // HEI.53 CHG2161266 NORRIQ KOROLA04 06.10.2022
    //   # TO Reference, Import Identifier - fields added
    // HEI.54 CHG2261624 SAHAL01 22.08.2024 S&OP Fit import purchase requisitions
    //   # Added Code
    // HEI.55 CHG2317685 SAHAL01 17.10.2025 Block Functionality Enhancement for Vendors
    //   # Added Code
    // HEI.56 CHG2352814 PATELS08 14.05.2026 - Add column with Expected Physical delivery date (Imp) on PO general header and purchase lines tables.
    // # Added Field "Exp Physical Del Date(Imp)"


    // BC Upgrade SHUKLP03 >> Added in interface ext. because of dependency on table "Purchase Header Additional FND".
    // "Maximo Status","LSR Order No."
    // BC Upgrade SHUKLP03 << Added in interface ext. because of dependency on table "Purchase Header Additional FND".

    // BC Upgrade MISHRS14 >>
    // Added code of Tag - HEI.55 inside OnAfterValidat() trigger of procedures- Buy-from Vendor No. and Pay-to Vendor No.
    // BC Upgrade MISHRS14 <<
    /**********************************/
    //BC UPGRADE ATHUKS01>>
    //1.Modified Code in SendEmailPurchaseOrder function Which is related to Send email with BC functions & Temp Blob. 
    //2.FDD STP 007 - Created new fields (50094_Doc. Amount Incl. VAT IBM), (50095 Doc. Amount VAT IBM) for IBM calculation. 
    //3.Added new field (Call From OnDelete) for flagging the call from OnDelete trigger and used this field in SendEmailPurchaseOrder function to avoid the error while deleting the record.
    //4. Added code in OnDelete trigger to set value for new field (Call From OnDelete) and clear this field value at the end of SendEmailPurchaseOrder function.
    //BC UPGRADE ATHUKS01<<  
    // BC Upgrade BHARDA11 >>
    // 1. FDD STP 002 -  Maping  fields and get data from vendor master.The logic that was working in Navision has been implemented here using the same logic and conditions. The only difference is that the field names were different in Navision, whereas here the field names have been changed.
    // 2. FDD STP 002 - Create New field in 50091 ID  "Vendor Tax Registration No." and flow this field in Posted Sales Invoice and Posted Purchase Receipt .
    // 3. FDD STP 003 - update Field "Created By" and "Creation Date/Time IBM" hile insert the new record.
    // BC Upgrade BHARAD11 <<

    // BC UPGRADE PATELS08 >>
    // # Tag HEI.56 added to documentation.
    // # New Field "Exp Physical Del Date(Imp)" created.
    // BC UPGRADE PATELS08 <<

    fields
    {
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order', FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
        }
        modify("Buy-from Vendor No.")
        {
            CaptionML = ENU = 'Buy-from Vendor No.', FRA = 'N° fournisseur';
            //BC UPGRADE SHARMP16 begin<<
            trigger OnAfterValidate()
            var
                myInt: Integer;

                // BC Upgrade MISHRS14 >> #HEI.55
                PurchasesUtilsL: Codeunit "Purchases-Utils";
            // BC Upgrade MISHRS14 <<
            // BC Upgrade BHARDA11 >> 

            begin
                if Vend.Get(Rec."Buy-from Vendor No.") then
                    //BC UPGRADE SHARMP16 Comment code because for logic Drink-IT fields used begin<<
                    //     IF Vend."Shipping Agent Code" <> '' THEN
                    //         Rec."Shipping Agent Code" := Vend."Shipping Agent Code"
                    //     //>> HEI.36
                    //     else
                    //         "Shipping Agent Code" := '';
                    // //<< HEI.36
                    // IF Vend."Shipping Agent Service Code" <> '' THEN
                    //     rec.VALIDATE("Shipping Agent Service Code", Vend."Shipping Agent Service Code")
                    // //>> HEI.36
                    // else
                    //     Rec.VALIDATE("Shipping Agent Service Code", '');
                    //<< HEI.36
                    //BC UPGRADE SHARMP16 Comment code because for logic Drink-IT fields used end>>
                    //HEI.12 PATHAA02>>
                    //IF Vend.GET("Buy-from Vendor No.") THEN
                    "Vendor Bank Account FND" := Vend."Preferred Bank Account Code";

                //HEI.12 PATHAA02<<
                // BC Upgrade BHARDA11 >> --FDD STP 002
                if Vend.get("Buy-from Vendor No.") then
                    "Business Group 104FDW" := Vend."Business Group 104FDW";
                "Vendor Tx Registration No. FND" := Vend."Tax Registration No. 113FDW";
                // BC Upgrade MISHRS14 >>  --FDD STP 002
                //HEI.55>>
                PurchasesUtilsL.CheckBlockedVendorOnDocuments(Vend, Rec);
                //HEI.55<<
                // BC Upgrade MISHRS14 <<

                //BC Upgrade SAIA01 WHT Posting field Update >>
                "WHT Business Posting Group FND" := Vend."WHT Business Posting Group FND";//WHT
                //BC Upgrade SAIA01 WHT Posting field Update <<
                CreateShippingCost(Rec, TRUE, FALSE); //HEI.34 FDD-HT658 IBM.GUNERE01 26.09.2019

            end;
            //BC UPGRADE SHARMP16 end>>

        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Pay-to Vendor No.")
        {
            CaptionML = ENU = 'Pay-to Vendor No.', FRA = 'N° fournisseur à payer';
            //BC UPGRADE SHARMP16 begin<<
            trigger OnAfterValidate()
            var
                myInt: Integer;

                // BC Upgrade MISHRS14 >> #HEI.55
                PurchasesUtilsL: Codeunit "Purchases-Utils";
                //
                // BC Upgrade BHARAD11 >>
                Vend, VendBuyfrom : Record Vendor;
                PaymentTerms: Record "Payment Terms";
            // BC Upgrade BHARAD11 <<
            begin
                // PurchasesUtils.OnAfterValidatePurchaseHeaderPaytoVendorNo(Rec,xRec,CurrFieldNo);//HEI.01 PTPGAP066 //BC UPGRADE SHARMP16 commented because CU will be handled differently.

                // BC Upgrade MISHRS14 >>
                //HEI.55>>
                PurchasesUtilsL.CheckBlockedVendorOnDocuments(Vend, Rec);
                //HEI.55<<
                // BC Upgrade MISHRS14 << 
                // BC Upgrade BHARDA11 >> --FDD STP 002
                if Vend.get("Buy-from Vendor No.") then
                    "Business Group 104FDW" := Vend."Business Group 104FDW";

                if "Buy-from Vendor No." = xRec."Pay-to Vendor No." then
                    if ReceivedPurchLinesExist() or ReturnShipmentExist() then
                        Rec.TestField("Business Group 104FDW", xRec."Business Group 104FDW");
                // IF Vend."Split Deposit on Invoice" THEN
                "Vendor Posting Grp 104FDW" := Vend."Vendor Posting Grp 104FDW";
                VendBuyfrom := Vend;
                // IF VendBuyfrom."Split Deposit on Invoice" THEN
                "Payment Terms Code 104FDW" := VendBuyfrom."Payment Terms Code 104FDW";
                "Vendor Tx Registration No. FND" := VendBuyfrom."Tax Registration No. 113FDW";
                // IF PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN
                "Payment Method Code 104FDW" := VendBuyfrom."Payment Method Code 104FDW";

                IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                    "Payment Method Code 104FDW" := '';
                    IF PaymentTerms.GET("Payment Method Code 104FDW") THEN
                        IF PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN
                            "Payment Method Code 104FDW" := Vend."Payment Method Code 104FDW";
                end else
                    "Payment Method Code 104FDW" := Vend."Payment Method Code 104FDW";

                // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                VALIDATE("Payment Terms Code 104FDW");
                VALIDATE("Payment Method Code 104FDW");
                // >>DITW16.00.00.42 DDR DIT-715 #370
                // IF Vend."Split Deposit on Invoice" THEN
                //     Vend.TESTFIELD(Vend."Deposit Vendor Posting Group")
                // Vend."Tax Registration No. 113FDW"
                // IF xRec."Business Group 104FDW" <> "Business Group 104FDW" THEN
                //     RecreateChargePurchaseLines(FIELDCAPTION("Business Group 104FDW"));
                // BC Upgrade BHARDA11 << --FDD STP 002
            end;
            //BC UPGRADE SHARMP16  end>>

        }
        modify("Pay-to Name")
        {
            CaptionML = ENU = 'Pay-to Name', FRA = 'Nom';
        }
        modify("Pay-to Name 2")
        {
            CaptionML = ENU = 'Pay-to Name 2', FRA = 'Nom 2';
        }
        modify("Pay-to Address")
        {

            //Unsupported feature: Change Data type on ""Pay-to Address"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Pay-to Address', FRA = 'Adresse';

            //Unsupported feature: Change Description on ""Pay-to Address"(Field 7)". Please convert manually.

        }
        modify("Pay-to Address 2")
        {

            //Unsupported feature: Change Data type on ""Pay-to Address 2"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Pay-to Address 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change Description on ""Pay-to Address 2"(Field 8)". Please convert manually.

        }
        modify("Pay-to City")
        {

            //Unsupported feature: Change Data type on ""Pay-to City"(Field 9)". Please convert manually.


            //Unsupported feature: Change TableRelation on ""Pay-to City"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Pay-to City', FRA = 'Ville';

            //Unsupported feature: Change Description on ""Pay-to City"(Field 9)". Please convert manually.

        }
        modify("Pay-to Contact")
        {
            CaptionML = ENU = 'Pay-to Contact', FRA = 'Contact';
        }
        modify("Your Reference")
        {
            CaptionML = ENU = 'Your Reference', FRA = 'Votre référence';
        }
        modify("Ship-to Code")
        {

            //Unsupported feature: Change TableRelation on ""Ship-to Code"(Field 12)". Please convert manually.

            CaptionML = ENU = 'Ship-to Code', FRA = 'Code destinataire';

        }
        modify("Ship-to Name")
        {
            CaptionML = ENU = 'Ship-to Name', FRA = 'Nom du destinataire';
            //BC UPGRADE SHARMP16 begin>>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.46>>
                IF PurchSetup.GET() THEN BEGIN
                    PurchaseLine.SETRANGE("Document Type", "Document Type");
                    PurchaseLine.SETRANGE("Document No.", "No.");
                    PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::Item);
                    PurchaseLine.SETFILTER("Item Category Code", PurchSetup."Item Category FND");
                    IF NOT PurchaseLine.FINDFIRST() THEN
                        ItemCategoryBool := FALSE
                    else
                        ItemCategoryBool := TRUE;
                end;
                IF ItemCategoryBool THEN BEGIN
                    IF ("SRM Order No. FND" = '') AND (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order")) THEN BEGIN
                        PurchHdrArch.RESET();
                        PurchHdrArch.SETRANGE(PurchHdrArch."Document Type", "Document Type");
                        PurchHdrArch.SETRANGE(PurchHdrArch."No.", "No.");
                        IF PurchHdrArch.FINDFIRST() THEN BEGIN
                            PurchHeader.RESET();
                            PurchHeader.SETRANGE(PurchHeader."No.", "No.");
                            IF PurchHeader.FINDFIRST() THEN BEGIN
                                IF PurchHeader."Purch. Reason Code FND" = '' THEN
                                    ERROR(ReasonCodeErr);
                            end;
                        end;
                    end;
                end;
                //HEI.46<<
            end;
            //BC UPGRADE SHARMP16 end<<
        }
        modify("Ship-to Name 2")
        {
            CaptionML = ENU = 'Ship-to Name 2', FRA = 'Nom du destinataire 2';
            //BC UPGRADE SHARMP16 begin>>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.46>>
                IF PurchSetup.GET() THEN BEGIN
                    PurchaseLine.SETRANGE("Document Type", "Document Type");
                    PurchaseLine.SETRANGE("Document No.", "No.");
                    PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::Item);
                    PurchaseLine.SETFILTER("Item Category Code", PurchSetup."Item Category FND");
                    IF NOT PurchaseLine.FINDFIRST() THEN
                        ItemCategoryBool := FALSE
                    else
                        ItemCategoryBool := TRUE;
                end;
                IF ItemCategoryBool THEN BEGIN
                    IF ("SRM Order No. FND" = '') AND (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order")) THEN BEGIN
                        PurchHdrArch.RESET();
                        PurchHdrArch.SETRANGE(PurchHdrArch."Document Type", "Document Type");
                        PurchHdrArch.SETRANGE(PurchHdrArch."No.", "No.");
                        IF PurchHdrArch.FINDFIRST() THEN BEGIN
                            PurchHeader.RESET();
                            PurchHeader.SETRANGE(PurchHeader."No.", "No.");
                            IF PurchHeader.FINDFIRST() THEN BEGIN
                                IF PurchHeader."Purch. Reason Code FND" = '' THEN
                                    ERROR(ReasonCodeErr);
                            end;
                        end;
                    end;
                end;
                //HEI.46<<

            end;
            //BC UPGRADE SHARMP16 end<<
        }
        modify("Ship-to Address")
        {

            //Unsupported feature: Change Data type on ""Ship-to Address"(Field 15)". Please convert manually.

            CaptionML = ENU = 'Ship-to Address', FRA = 'Adresse destinataire';

            //Unsupported feature: Change Description on ""Ship-to Address"(Field 15)". Please convert manually.
            //BC UPGRADE SHARMP16 begin>>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.46>>
                IF PurchSetup.GET() THEN BEGIN
                    PurchaseLine.SETRANGE("Document Type", "Document Type");
                    PurchaseLine.SETRANGE("Document No.", "No.");
                    PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::Item);
                    PurchaseLine.SETFILTER("Item Category Code", PurchSetup."Item Category FND");
                    IF NOT PurchaseLine.FINDFIRST() THEN
                        ItemCategoryBool := FALSE
                    else
                        ItemCategoryBool := TRUE;
                end;
                IF ItemCategoryBool THEN BEGIN
                    IF ("SRM Order No. FND" = '') AND (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order")) THEN BEGIN
                        PurchHdrArch.RESET();
                        PurchHdrArch.SETRANGE(PurchHdrArch."Document Type", "Document Type");
                        PurchHdrArch.SETRANGE(PurchHdrArch."No.", "No.");
                        IF PurchHdrArch.FINDFIRST() THEN BEGIN
                            PurchHeader.RESET();
                            PurchHeader.SETRANGE(PurchHeader."No.", "No.");
                            IF PurchHeader.FINDFIRST() THEN BEGIN
                                IF PurchHeader."Purch. Reason Code FND" = '' THEN
                                    ERROR(ReasonCodeErr);
                            end;
                        end;
                    end;
                end;
                //HEI.46<<

            end;
            //BC UPGRADE SHARMP16 end<<
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


            //Unsupported feature: Change TableRelation on ""Ship-to City"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Ship-to City', FRA = 'Ville destinataire';

            //Unsupported feature: Change Description on ""Ship-to City"(Field 17)". Please convert manually.
            //BC UPGRADE SHARMP16 begin>>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.46>>
                IF PurchSetup.GET() THEN BEGIN
                    PurchaseLine.SETRANGE("Document Type", "Document Type");
                    PurchaseLine.SETRANGE("Document No.", "No.");
                    PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::Item);
                    PurchaseLine.SETFILTER("Item Category Code", PurchSetup."Item Category FND");
                    IF NOT PurchaseLine.FINDFIRST() THEN
                        ItemCategoryBool := FALSE
                    else
                        ItemCategoryBool := TRUE;
                end;
                IF ItemCategoryBool THEN BEGIN
                    IF ("SRM Order No. FND" = '') AND (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order")) THEN BEGIN
                        PurchHdrArch.RESET();
                        PurchHdrArch.SETRANGE(PurchHdrArch."Document Type", "Document Type");
                        PurchHdrArch.SETRANGE(PurchHdrArch."No.", "No.");
                        IF PurchHdrArch.FINDFIRST() THEN BEGIN
                            PurchHeader.RESET();
                            PurchHeader.SETRANGE(PurchHeader."No.", "No.");
                            IF PurchHeader.FINDFIRST() THEN BEGIN
                                IF PurchHeader."Purch. Reason Code FND" = '' THEN
                                    ERROR(ReasonCodeErr);
                            end;
                        end;
                    end;
                end;
                //HEI.46<<

            end;
            //BC UPGRADE SHARMP16 end<<
        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Ship-to Contact', FRA = 'Contact destinataire';
            //BC UPGRADE SHARMP16 begin>>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.46>>
                IF ("SRM Order No. FND" = '') AND (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order")) THEN BEGIN
                    PurchHdrArch.RESET();
                    PurchHdrArch.SETRANGE(PurchHdrArch."Document Type", "Document Type");
                    PurchHdrArch.SETRANGE(PurchHdrArch."No.", "No.");
                    IF PurchHdrArch.FINDFIRST() THEN BEGIN
                        IF "Purch. Reason Code FND" = '' THEN
                            ERROR(ReasonCodeErr);
                    end;
                end;
                //HEI.46<<
            end;
            //BC UPGRADE SHARMP16 end<<
        }
        modify("Order Date")
        {
            CaptionML = ENU = 'Order Date', FRA = 'Date commande';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Expected Receipt Date")
        {
            CaptionML = ENU = 'Expected Receipt Date', FRA = 'Date réception prévue';
            //BC UPGRADE SHARMP16 begin<<
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.26>>
                IF PurchSetup.GET() THEN BEGIN
                    PurchaseLine.SETRANGE("Document No.", "No.");
                    PurchaseLine.SETFILTER(PurchaseLine."Document Type", '%1', PurchaseLine."Document Type");
                    PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::Item);
                    PurchaseLine.SETFILTER("Item Category Code", PurchSetup."Item Category FND");
                    IF NOT PurchaseLine.FINDFIRST() THEN
                        ItemCategoryBool := FALSE
                    else
                        ItemCategoryBool := TRUE;
                    IF ItemCategoryBool THEN BEGIN
                        //HEI.26<<
                        //HEI.22>>
                        IF ("SRM Order No. FND" = '') AND (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order")) THEN BEGIN
                            PurchHdrArch.RESET();
                            PurchHdrArch.SETRANGE(PurchHdrArch."Document Type", "Document Type");
                            PurchHdrArch.SETRANGE(PurchHdrArch."No.", "No.");
                            IF PurchHdrArch.FINDFIRST() THEN BEGIN
                                IF "Purch. Reason Code FND" = '' THEN
                                    ERROR(ReasonCodeErr);
                            end;
                        end;
                        //HEI.22<<
                        //HEI.26>>
                    end;
                end;
            end;
            //BC UPGRADE SHARMP16 end>>
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
            //BC UPGRADE SHARMP16 begin<<
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //>> HEI.34 FDD-HT658 IBM.GUNERE01 27.09.2019
                IF xRec."Shipment Method Code" <> Rec."Shipment Method Code" THEN
                    //IF Rec."Shipment Method Code" = '' THEN //HEI.36
                    //  WhseTransportMgt.DeletePurchShippingCost(xRec, TRUE);//BC UPGRADE SHARMP16 Codeunit Compile later.
                    //<< HEI.34 FDD-HT658 IBM.GUNERE01 27.09.2019

                    CreateShippingCost(Rec, TRUE, TRUE); //HEI.34 FDD-HT658 IBM.GUNERE01 27.09.2019
            end;
            //BC UPGRADE SHARMP16 end>>
        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 28)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
            trigger OnAfterValidate()
            var
            begin
                //rec.UpdateLines;//Bc Upgrade SHARMP16 GAPFitChanges
            end;
        }
        modify("Shortcut Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 1 Code"(Field 29)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 2 Code"(Field 30)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Vendor Posting Group")
        {
            CaptionML = ENU = 'Vendor Posting Group', FRA = 'Groupe compta. fournisseur';

            //Unsupported feature: Change Description on ""Vendor Posting Group"(Field 31)". Please convert manually.

        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Currency Factor")
        {
            CaptionML = ENU = 'Currency Factor', FRA = 'Facteur devise';
        }
        modify("Prices Including VAT")
        {
            CaptionML = ENU = 'Prices Including VAT', FRA = 'Prix TTC';
        }
        modify("Invoice Disc. Code")
        {
            CaptionML = ENU = 'Invoice Disc. Code', FRA = 'Code remise facture';
        }
        modify("Language Code")
        {
            CaptionML = ENU = 'Language Code', FRA = 'Code langue';
        }
        modify("Purchaser Code")
        {

            //Unsupported feature: Change TableRelation on ""Purchaser Code"(Field 43)". Please convert manually.

            CaptionML = ENU = 'Purchaser Code', FRA = 'Code acheteur';
        }
        modify("Order Class")
        {
            CaptionML = ENU = 'Order Class', FRA = 'Type commande';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 46)". Please convert manually.

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
            // OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêt';

            //Unsupported feature: Change OptionString on ""Applies-to Doc. Type"(Field 52)". Please convert manually.


            //Unsupported feature: Change Description on ""Applies-to Doc. Type"(Field 52)". Please convert manually.

        }
        modify("Applies-to Doc. No.")
        {
            CaptionML = ENU = 'Applies-to Doc. No.', FRA = 'N° doc. lettrage';
        }
        modify("Bal. Account No.")
        {

            //Unsupported feature: Change TableRelation on ""Bal. Account No."(Field 55)". Please convert manually.

            CaptionML = ENU = 'Bal. Account No.', FRA = 'N° compte contrepartie';
        }
        modify("Recalculate Invoice Disc.")
        {

            //Unsupported feature: Change CalcFormula on ""Recalculate Invoice Disc."(Field 56)". Please convert manually.

            CaptionML = ENU = 'Recalculate Invoice Disc.', FRA = 'Recalculer remise facture';
        }
        modify(Receive)
        {
            CaptionML = ENU = 'Receive', FRA = 'Reste à recevoir';
        }
        modify(Invoice)
        {
            CaptionML = ENU = 'Invoice', FRA = 'Reste à facturer';
        }
        modify("Print Posted Documents")
        {
            CaptionML = ENU = 'Print Posted Documents', FRA = 'Imprimer les documents validés';
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
        modify("Receiving No.")
        {
            CaptionML = ENU = 'Receiving No.', FRA = 'Utiliser B.R. n°';
        }
        modify("Posting No.")
        {
            CaptionML = ENU = 'Posting No.', FRA = 'N° validation';
        }
        modify("Last Receiving No.")
        {
            CaptionML = ENU = 'Last Receiving No.', FRA = 'N° dern. bon de réception';
        }
        modify("Last Posting No.")
        {
            CaptionML = ENU = 'Last Posting No.', FRA = 'N° dern. facture';
        }
        modify("Vendor Order No.")
        {
            CaptionML = ENU = 'Vendor Order No.', FRA = 'N° commande fournisseur';
        }
        modify("Vendor Shipment No.")
        {
            CaptionML = ENU = 'Vendor Shipment No.', FRA = 'N° B.L. fournisseur';
        }
        modify("Vendor Invoice No.")
        {
            CaptionML = ENU = 'Vendor Invoice No.', FRA = 'N° facture fournisseur';
            //BC UPGRADE ATHUKUS01 FDDSTP_007>> 
            trigger OnBeforeValidate()
            var
                lrecVendLedgEntry: Record "Vendor Ledger Entry";
                Text2036301: Label 'Purchase %1 %2 already exists for this vendor.';
                lrecPurchaseH: Record "Purchase Header";
            begin
                IF "Document Type" IN ["Document Type"::Invoice, "Document Type"::"Credit Memo"] THEN
                    IF "Vendor Invoice No." <> '' THEN BEGIN
                        lrecVendLedgEntry.RESET();
                        lrecVendLedgEntry.SETCURRENTKEY("External Document No.");
                        CASE "Document Type" OF
                            "Document Type"::Invoice:
                                lrecVendLedgEntry.SETRANGE("Document Type", lrecVendLedgEntry."Document Type"::Invoice);
                            "Document Type"::"Credit Memo":
                                lrecVendLedgEntry.SETRANGE("Document Type", lrecVendLedgEntry."Document Type"::"Credit Memo");
                        END;
                        lrecVendLedgEntry.SETRANGE("External Document No.", "Vendor Invoice No.");
                        lrecVendLedgEntry.SETRANGE("Vendor No.", "Pay-to Vendor No.");
                        IF NOT lrecVendLedgEntry.ISEMPTY() THEN
                            ERROR(Text2036301, "Document Type", "Vendor Invoice No.");

                        lrecPurchaseH.SETRANGE("Document Type", "Document Type");
                        lrecPurchaseH.SETFILTER("No.", '<>%1', "No.");
                        lrecPurchaseH.SETRANGE("Pay-to Vendor No.", "Pay-to Vendor No.");
                        lrecPurchaseH.SETRANGE("Vendor Invoice No.", "Vendor Invoice No.");
                        IF NOT lrecPurchaseH.ISEMPTY() THEN
                            ERROR(Text2036301, "Document Type", "Vendor Invoice No.");
                    END;
            end;
            //BC UPGRADE ATHUKUS01 FDDSTP_007<<
        }
        modify("Vendor Cr. Memo No.")
        {
            CaptionML = ENU = 'Vendor Cr. Memo No.', FRA = 'N° avoir fournisseur';
        }
        modify("VAT Registration No.")
        {
            CaptionML = ENU = 'VAT Registration No.', FRA = 'N° identif. intracomm.';
        }
        modify("Sell-to Customer No.")
        {
            CaptionML = ENU = 'Sell-to Customer No.', FRA = 'N° donneur d''ordre';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
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

            //Unsupported feature: Change TableRelation on ""VAT Country/Region Code"(Field 78)". Please convert manually.

            CaptionML = ENU = 'VAT Country/Region Code', FRA = 'Code pays/région TVA';
        }
        modify("Buy-from Vendor Name")
        {
            CaptionML = ENU = 'Buy-from Vendor Name', FRA = 'Nom du fournisseur';
        }
        modify("Buy-from Vendor Name 2")
        {
            CaptionML = ENU = 'Buy-from Vendor Name 2', FRA = 'Nom du fournisseur 2';
        }
        modify("Buy-from Address")
        {
            CaptionML = ENU = 'Buy-from Address', FRA = 'Adresse fournisseur';

            //Unsupported feature: Change Description on ""Buy-from Address"(Field 81)". Please convert manually.

        }
        modify("Buy-from Address 2")
        {

            //Unsupported feature: Change Data type on ""Buy-from Address 2"(Field 82)". Please convert manually.

            CaptionML = ENU = 'Buy-from Address 2', FRA = 'Adresse fournisseur 2';

            //Unsupported feature: Change Description on ""Buy-from Address 2"(Field 82)". Please convert manually.

        }
        modify("Buy-from City")
        {

            //Unsupported feature: Change Data type on ""Buy-from City"(Field 83)". Please convert manually.


            //Unsupported feature: Change TableRelation on ""Buy-from City"(Field 83)". Please convert manually.

            CaptionML = ENU = 'Buy-from City', FRA = 'Ville fournisseur';

            //Unsupported feature: Change Description on ""Buy-from City"(Field 83)". Please convert manually.

        }
        modify("Buy-from Contact")
        {
            CaptionML = ENU = 'Buy-from Contact', FRA = 'Contact fournisseur';
        }
        modify("Pay-to Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Pay-to Post Code"(Field 85)". Please convert manually.

            CaptionML = ENU = 'Pay-to Post Code', FRA = 'Code postal';
        }
        modify("Pay-to County")
        {
            CaptionML = ENU = 'Pay-to County', FRA = 'Région';
        }
        modify("Pay-to Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Pay-to Country/Region Code"(Field 87)". Please convert manually.

            CaptionML = ENU = 'Pay-to Country/Region Code', FRA = 'Code pays/région paiement';
        }
        modify("Buy-from Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Buy-from Post Code"(Field 88)". Please convert manually.

            CaptionML = ENU = 'Buy-from Post Code', FRA = 'Code postal fournisseur';
        }
        modify("Buy-from County")
        {
            CaptionML = ENU = 'Buy-from County', FRA = 'Région fournisseur';
        }
        modify("Buy-from Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Buy-from Country/Region Code"(Field 90)". Please convert manually.

            CaptionML = ENU = 'Buy-from Country/Region Code', FRA = 'Code pays/région fournisseur';
        }
        modify("Ship-to Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Ship-to Post Code"(Field 91)". Please convert manually.

            CaptionML = ENU = 'Ship-to Post Code', FRA = 'Code postal destinataire';
            //BC UPGRADE SHARMP16 begin<<
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.46>>
                IF ("SRM Order No. FND" = '') AND (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order")) THEN BEGIN
                    PurchHdrArch.RESET();
                    PurchHdrArch.SETRANGE(PurchHdrArch."Document Type", "Document Type");
                    PurchHdrArch.SETRANGE(PurchHdrArch."No.", "No.");
                    IF PurchHdrArch.FINDFIRST() THEN BEGIN
                        IF "Purch. Reason Code FND" = '' THEN
                            ERROR(ReasonCodeErr);
                    end;
                end;
                //HEI.46<<

            end;
            //BC UPGRADE SHARMP16 end>>
        }
        modify("Ship-to County")
        {
            CaptionML = ENU = 'Ship-to County', FRA = 'Région destinataire';
        }
        modify("Ship-to Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Ship-to Country/Region Code"(Field 93)". Please convert manually.

            CaptionML = ENU = 'Ship-to Country/Region Code', FRA = 'Code pays/région destinataire';
        }
        modify("Bal. Account Type")
        {
            CaptionML = ENU = 'Bal. Account Type', FRA = 'Type compte contrepartie';
            // OptionCaptionML = ENU = 'G/L Account,Bank Account', FRA = 'Général,Banque';
        }
        modify("Order Address Code")
        {

            //Unsupported feature: Change TableRelation on ""Order Address Code"(Field 95)". Please convert manually.

            CaptionML = ENU = 'Order Address Code', FRA = 'Code adresse commande';
            // BC Upgrade BHARAD11 >> --FDD STP 002
            trigger OnAfterValidate()
            var
                Vend3: Record Vendor;
            begin
                // IF ("Buy-from Vendor No." <> "Pay-to Vendor No.") AND ("Pay-to Vendor No." <> '') AND
                //     IsVendCalcPrices(Vend, PurchSetup."Pay-to/Buy-from Prices Calc."::"Pay-to")
                //  THEN
                //     Vend3.GET("Pay-to Vendor No.")
                // ELSE
                //     Vend3 := Vend;
                if Vend3.get("Buy-from Vendor No.") then
                    "Business Group 104FDW" := Vend3."Business Group 104FDW";
                // "Vendor Tax Registration No." := Vend3."Tax Registration No. 113FDW";

            end;
            // BC Upgrade BHARAD11 << --FDD STP 002
        }
        modify("Entry Point")
        {
            CaptionML = ENU = 'Entry Point', FRA = 'Pays provenance';
        }
        modify(Correction)
        {
            CaptionML = ENU = 'Correction', FRA = 'Correction';
        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
            //BC UPGRADE SHARMP16 begin<<
            trigger OnAfterValidate()
            var
                SkipJobCurrFactorUpdate: Boolean;
            begin
                //<<HEI.37 - Added Code to calculate Currency Factor when changing the Document Date instead of changing the Posting Date
                IF ("Document Type" IN ["Document Type"::Invoice, "Document Type"::"Credit Memo"]) AND
                   NOT ("Posting Date" = xRec."Posting Date")
                THEN
                    PriceMessageIfPurchLinesExist(FIELDCAPTION("Posting Date"));

                IF "Currency Code" <> '' THEN BEGIN
                    UpdateCurrencyFactor();
                    // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
                    //InitHasBeenShow(HasBeenShowText022, '', FIELDNO("Document Date"));////BC UPGRADE SHARMP16 Drink-IT customization
                    // >>DITW16.00.00.43 DDR DIT-715 #860
                    IF "Currency Factor" <> xRec."Currency Factor" THEN
                        SkipJobCurrFactorUpdate := NOT Rec.ConfirmCurrencyFactorUpdate();//BC UPGRADE SHARMP16 change name of function from ConfirmUpdateCurrencyFactor to ConfirmCurrencyFactorUpdate
                end;
                //>>HEI.37

            end;
            //BC UPGRADE SHARMP16 end>>
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
            //BC UPGRADE SHARMP16 begin<<
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.07 FDD-PTPGAP007 IBM PATHAA02>>
                IF PaymentMethod."Mandatory Bank details FND" THEN BEGIN
                    VendorBankAccount.RESET();
                    VendorBankAccount.SETRANGE("Vendor No.", "Buy-from Vendor No.");
                    IF VendorBankAccount.ISEMPTY THEN
                        ERROR(Text50000)
                    // HEI.17>>
                    else BEGIN
                        VendorBankAccount.SETRANGE(Code, "Vendor Bank Account FND");
                        IF VendorBankAccount.FINDFIRST() THEN
                            HeinekenGlobal.ValidateVendBankAccFields("Buy-from Vendor No.", "Vendor Bank Account FND");
                    end;
                    // HEI.17<<
                end;
                //HEI.07 FDD-PTPGAP007 IBM PATHAA02<<

            end;
            //BC UPGRADE SHARMP16 end>>
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Posting No. Series")
        {
            CaptionML = ENU = 'Posting No. Series', FRA = 'Souches de n° validation';
        }
        modify("Receiving No. Series")
        {
            CaptionML = ENU = 'Receiving No. Series', FRA = 'Souche de n° réception';
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
        modify("Applies-to ID")
        {
            CaptionML = ENU = 'Applies-to ID', FRA = 'ID lettrage';
        }
        modify("VAT Base Discount %")
        {
            CaptionML = ENU = 'VAT Base Discount %', FRA = '% remise base TVA';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            // OptionCaptionML = ENU = 'Open,Released,Pending Approval,Pending Prepayment', FRA = 'Ouvert,Lancé,Approbation suspendue,Acompte suspendu';
        }
        modify("Invoice Discount Calculation")
        {
            CaptionML = ENU = 'Invoice Discount Calculation', FRA = 'Calcul remise facture';
            OptionCaptionML = ENU = 'None,%,Amount', FRA = 'Aucun,%,Montant';
        }
        modify("Invoice Discount Value")
        {
            CaptionML = ENU = 'Invoice Discount Value', FRA = 'Valeur remise facture';
        }
        modify("Send IC Document")
        {
            CaptionML = ENU = 'Send IC Document', FRA = 'Envoyer le document IC';
        }
        modify("IC Status")
        {
            CaptionML = ENU = 'IC Status', FRA = 'Statut IC';
            // OptionCaptionML = ENU = 'New,Pending,Sent', FRA = 'Nouveau,Suspendu,Envoyé';
        }
        modify("Buy-from IC Partner Code")
        {
            CaptionML = ENU = 'Buy-from IC Partner Code', FRA = 'Code parten IC fournisseur';
        }
        modify("Pay-to IC Partner Code")
        {
            CaptionML = ENU = 'Pay-to IC Partner Code', FRA = 'Code du partenaire IC à payer';
        }
        modify("IC Direction")
        {
            CaptionML = ENU = 'IC Direction', FRA = 'Direction IC';
            // OptionCaptionML = ENU = 'Outgoing,Incoming', FRA = 'Sortant,Entrant';
        }
        modify("Prepayment No.")
        {
            CaptionML = ENU = 'Prepayment No.', FRA = 'N° acompte';
        }
        modify("Last Prepayment No.")
        {
            CaptionML = ENU = 'Last Prepayment No.', FRA = 'N° dernier acompte';
        }
        modify("Prepmt. Cr. Memo No.")
        {
            CaptionML = ENU = 'Prepmt. Cr. Memo No.', FRA = 'N° avoir acompte';
        }
        modify("Last Prepmt. Cr. Memo No.")
        {
            CaptionML = ENU = 'Last Prepmt. Cr. Memo No.', FRA = 'N° avoir dernier acompte';
        }
        modify("Prepayment %")
        {
            CaptionML = ENU = 'Prepayment %', FRA = '% acompte';
        }
        modify("Prepayment No. Series")
        {
            CaptionML = ENU = 'Prepayment No. Series', FRA = 'N° de série acompte';
        }
        modify("Compress Prepayment")
        {

            //Unsupported feature: Change InitValue on ""Compress Prepayment"(Field 136)". Please convert manually.

            CaptionML = ENU = 'Compress Prepayment', FRA = 'Compresser acompte';
        }
        modify("Prepayment Due Date")
        {
            CaptionML = ENU = 'Prepayment Due Date', FRA = 'Échéance acompte';
        }
        modify("Prepmt. Cr. Memo No. Series")
        {
            CaptionML = ENU = 'Prepmt. Cr. Memo No. Series', FRA = 'N° de série avoir acompte';
        }
        modify("Prepmt. Posting Description")
        {
            CaptionML = ENU = 'Prepmt. Posting Description', FRA = 'Libellé écriture acompte';
        }
        modify("Prepmt. Pmt. Discount Date")
        {
            CaptionML = ENU = 'Prepmt. Pmt. Discount Date', FRA = 'Date escompte acompte';
        }
        modify("Prepmt. Payment Terms Code")
        {
            CaptionML = ENU = 'Prepmt. Payment Terms Code', FRA = 'Code conditions paiement acompte';
        }
        modify("Prepmt. Payment Discount %")
        {
            CaptionML = ENU = 'Prepmt. Payment Discount %', FRA = '% escompte acompte';
        }
        modify("Quote No.")
        {
            CaptionML = ENU = 'Quote No.', FRA = 'N° devis';
        }
        modify("Job Queue Status")
        {
            CaptionML = ENU = 'Job Queue Status', FRA = 'Statut de la file d''attente des travaux';
            // OptionCaptionML = ENU = ' ,Scheduled for Posting,Error,Posting', FRA = ' ,Planifié pour la validation,Erreur,Validation';
        }
        modify("Job Queue Entry ID")
        {
            CaptionML = ENU = 'Job Queue Entry ID', FRA = 'ID écriture file d''attente des travaux';
        }
        modify("Incoming Document Entry No.")
        {
            CaptionML = ENU = 'Incoming Document Entry No.', FRA = 'N° de séquence du document entrant';
        }
        modify("Creditor No.")
        {
            CaptionML = ENU = 'Creditor No.', FRA = 'N° créditeur';
        }
        modify("Payment Reference")
        {
            CaptionML = ENU = 'Payment Reference', FRA = 'Référence paiement';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Invoice Discount Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Invoice Discount Amount"(Field 1305)". Please convert manually.

            CaptionML = ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
        }
        modify("No. of Archived Versions")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Archived Versions"(Field 5043)". Please convert manually.

            CaptionML = ENU = 'No. of Archived Versions', FRA = 'Nbre versions archivées';
        }
        modify("Doc. No. Occurrence")
        {
            CaptionML = ENU = 'Doc. No. Occurrence', FRA = 'Occurrence n° doc.';
        }
        modify("Campaign No.")
        {
            CaptionML = ENU = 'Campaign No.', FRA = 'N° campagne';
        }
        modify("Buy-from Contact No.")
        {
            CaptionML = ENU = 'Buy-from Contact No.', FRA = 'N° contact fournisseur';
        }
        modify("Pay-to Contact No.")
        {
            CaptionML = ENU = 'Pay-to Contact No.', FRA = 'N° contact à payer';
        }
        modify("Responsibility Center")
        {

            //Unsupported feature: Change TableRelation on ""Responsibility Center"(Field 5700)". Please convert manually.

            CaptionML = ENU = 'Responsibility Center', FRA = 'Centre de gestion';
        }
        modify("Completely Received")
        {

            //Unsupported feature: Change CalcFormula on ""Completely Received"(Field 5752)". Please convert manually.

            CaptionML = ENU = 'Completely Received', FRA = 'Entièrement réceptionné';
        }
        modify("Posting from Whse. Ref.")
        {
            CaptionML = ENU = 'Posting from Whse. Ref.', FRA = 'Validation à partir réf. entrepôt';
        }
        modify("Location Filter")
        {
            CaptionML = ENU = 'Location Filter', FRA = 'Filtre magasin';
        }
        modify("Requested Receipt Date")
        {
            CaptionML = ENU = 'Requested Receipt Date', FRA = 'Date réception demandée';
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.26>>
                IF PurchSetup.GET() THEN BEGIN
                    PurchaseLine.SETRANGE("Document No.", "No.");
                    PurchaseLine.SETFILTER(PurchaseLine."Document Type", '%1', PurchaseLine."Document Type");
                    PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::Item);
                    PurchaseLine.SETFILTER("Item Category Code", PurchSetup."Item Category FND");
                    IF NOT PurchaseLine.FINDFIRST() THEN
                        ItemCategoryBool := FALSE
                    else
                        ItemCategoryBool := TRUE;
                    IF ItemCategoryBool THEN BEGIN
                        //HEI.26<<
                        //HEI.22>>
                        IF ("SRM Order No. FND" = '') AND (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order")) THEN BEGIN
                            PurchHdrArch.RESET();
                            PurchHdrArch.SETRANGE(PurchHdrArch."Document Type", "Document Type");
                            PurchHdrArch.SETRANGE(PurchHdrArch."No.", "No.");
                            IF PurchHdrArch.FINDFIRST() THEN BEGIN
                                IF "Purch. Reason Code FND" = '' THEN
                                    ERROR(ReasonCodeErr);
                            end;
                        end;
                        //HEI.22<<
                        //HEI.26>>
                    end;
                end;
                //HEI.26<<
            end;
        }
        modify("Promised Receipt Date")
        {
            CaptionML = ENU = 'Promised Receipt Date', FRA = 'Date réception confirmée';
        }
        modify("Lead Time Calculation")
        {
            CaptionML = ENU = 'Lead Time Calculation', FRA = 'Délai de réappro.';
        }
        modify("Inbound Whse. Handling Time")
        {
            CaptionML = ENU = 'Inbound Whse. Handling Time', FRA = 'Délai enlogement';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Vendor Authorization No.")
        {
            CaptionML = ENU = 'Vendor Authorization No.', FRA = 'N° autorisation fournisseur';
        }
        modify("Return Shipment No.")
        {
            CaptionML = ENU = 'Return Shipment No.', FRA = 'N° expédition retour';
        }
        modify("Return Shipment No. Series")
        {
            CaptionML = ENU = 'Return Shipment No. Series', FRA = 'Souche de n° expédition retour';
        }
        modify(Ship)
        {
            CaptionML = ENU = 'Ship', FRA = 'Livrer';
        }
        modify("Last Return Shipment No.")
        {
            CaptionML = ENU = 'Last Return Shipment No.', FRA = 'Dernier n° expédition retour';
        }
        modify("Assigned User ID")
        {
            CaptionML = ENU = 'Assigned User ID', FRA = 'Code utilisateur affecté';
        }
        modify("Pending Approvals")
        {

            //Unsupported feature: Change CalcFormula on ""Pending Approvals"(Field 9001)". Please convert manually.

            CaptionML = ENU = 'Pending Approvals', FRA = 'Approbations en attente';
        }

        //Unsupported feature: CodeInsertion on ""Buy-from Vendor No."(Field 2).OnValidate". Please convert manually.

        //trigger (Variable: BuyFromVend)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Buy-from Vendor No."(Field 2).OnValidate". Please convert manually.

        //trigger "(Field 2)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        InitRecOnVendUpdate;
        TESTFIELD(Status,Status::Open);
        IF ("Buy-from Vendor No." <> xRec."Buy-from Vendor No.") AND
           (xRec."Buy-from Vendor No." <> '')
        THEN BEGIN
          CheckDropShipmentLineExists;
          IF HideValidationDialog THEN
            Confirmed := TRUE
          else
            Confirmed := CONFIRM(ConfirmChangeQst,FALSE,BuyFromVendorTxt);
          IF Confirmed THEN BEGIN
            IF InitFromVendor("Buy-from Vendor No.",FIELDCAPTION("Buy-from Vendor No.")) THEN
              EXIT;

            CheckReceiptInfo(PurchLine,FALSE);
            CheckPrepmtInfo(PurchLine);
            CheckReturnInfo(PurchLine,FALSE);

            PurchLine.RESET;
          end else BEGIN
            Rec := xRec;
            EXIT;
          end;
        end;

        GetVend("Buy-from Vendor No.");
        Vend.CheckBlockedVendOnDocs(Vend,FALSE);
        Vend.TESTFIELD("Gen. Bus. Posting Group");
        "Buy-from Vendor Name" := Vend.Name;
        "Buy-from Vendor Name 2" := Vend."Name 2";
        CopyBuyFromVendorAddressFieldsFromVendor(Vend);
        IF NOT SkipBuyFromContact THEN
          "Buy-from Contact" := Vend.Contact;
        "Gen. Bus. Posting Group" := Vend."Gen. Bus. Posting Group";
        "VAT Bus. Posting Group" := Vend."VAT Bus. Posting Group";
        "Tax Area Code" := Vend."Tax Area Code";
        "Tax Liable" := Vend."Tax Liable";
        "VAT Country/Region Code" := Vend."Country/Region Code";
        "VAT Registration No." := Vend."VAT Registration No.";
        VALIDATE("Lead Time Calculation",Vend."Lead Time Calculation");
        "Responsibility Center" := UserSetupMgt.GetRespCenter(1,Vend."Responsibility Center");
        VALIDATE("Sell-to Customer No.",'');
        VALIDATE("Location Code",UserSetupMgt.GetLocation(1,Vend."Location Code","Responsibility Center"));

        IF "Buy-from Vendor No." = xRec."Pay-to Vendor No." THEN
          IF ReceivedPurchLinesExist OR ReturnShipmentExist THEN BEGIN
            TESTFIELD("VAT Bus. Posting Group",xRec."VAT Bus. Posting Group");
            TESTFIELD("Gen. Bus. Posting Group",xRec."Gen. Bus. Posting Group");
          end;

        "Buy-from IC Partner Code" := Vend."IC Partner Code";
        "Send IC Document" := ("Buy-from IC Partner Code" <> '') AND ("IC Direction" = "IC Direction"::Outgoing);

        IF Vend."Pay-to Vendor No." <> '' THEN
          VALIDATE("Pay-to Vendor No.",Vend."Pay-to Vendor No.")
        else BEGIN
          IF "Buy-from Vendor No." = "Pay-to Vendor No." THEN
            SkipPayToContact := TRUE;
          VALIDATE("Pay-to Vendor No.","Buy-from Vendor No.");
          SkipPayToContact := FALSE;
        end;
        "Order Address Code" := '';

        VALIDATE("Order Address Code");

        IF (xRec."Buy-from Vendor No." <> "Buy-from Vendor No.") OR
           (xRec."Currency Code" <> "Currency Code") OR
           (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group") OR
           (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")
        THEN
          RecreatePurchLines(BuyFromVendorTxt);

        IF NOT SkipBuyFromContact THEN
          UpdateBuyFromCont("Buy-from Vendor No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        InitRecOnVendUpdate;
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        if ("Buy-from Vendor No." <> xRec."Buy-from Vendor No.") and
           (xRec."Buy-from Vendor No." <> '')
        then begin
          CheckDropShipmentLineExists;
          //IF HideValidationDialog THEN
          // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
          InitHasBeenShow(HasBeenShowBuyFrom,'',FIELDNO("Buy-from Vendor No."));
          if HideValidationDialog or not GUIALLOWED or HasBeenShowBuyFrom then
          // >>DITW16.00.00.43 DDR DIT-715 #860
            Confirmed := true
          else
            Confirmed := CONFIRM(ConfirmChangeQst,false,BuyFromVendorTxt);

          // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
          HasBeenShowBuyFrom := Confirmed;
          // >>DITW16.00.00.43 DDR DIT-715 #860

          if Confirmed then begin
            if InitFromVendor("Buy-from Vendor No.",FIELDCAPTION("Buy-from Vendor No.")) then
              exit;

            CheckReceiptInfo(PurchLine,false);
            CheckPrepmtInfo(PurchLine);
            CheckReturnInfo(PurchLine,false);

            PurchLine.RESET;
            //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968
            fctClearDeliveryTimes;
            //>> DITW18.00.07 VSC DIT-770 #1968
          end else begin
            Rec := xRec;
            exit;
          end;
        end;

        GetVend("Buy-from Vendor No.");
        Vend.CheckBlockedVendOnDocs(Vend,false);
        #28..31
        if not SkipBuyFromContact then
        #33..35
        "WHT Business Posting Group" := Vend."WHT Business Posting Group";//WHT
        #36..38
        //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
        VALIDATE("Sundry Vendor",Vend."Sundry Vendor");
        //>> DITW18.00.07 AKH DIT-770 #1804
        "VAT Registration No." := Vend."VAT Registration No.";
        VALIDATE("Lead Time Calculation",Vend."Lead Time Calculation");
        //<<DITW18.00.06 MSF 17/09/2015 DIT-770 #1600
        if Vend."Responsibility Center" <> '' then
        //>>DITW18.00.06 MSF 17/09/2015 DIT-770 #1600
          "Responsibility Center" := UserSetupMgt.GetRespCenter(1,Vend."Responsibility Center");
        VALIDATE("Sell-to Customer No.",'');
        //VALIDATE("Location Code",UserSetupMgt.GetLocation(1,Vend."Location Code","Responsibility Center"));
        //<< DITW18.00.07 AKH 20/04/2016 DIT-770 #1941
        if IsVendCalcPrices(Vend,PurchSetup."Pay-to/Buy-from Prices Calc."::"Buy-from") then begin
          if "Document Type" = "Document Type"::Order then
            "Prepayment %" := Vend."Prepayment %";
          "Invoice Disc. Code" := Vend."Invoice Disc. Code";
        end;
        //>> DITW18.00.07 AKH DIT-770 #1941
        // <<DITW15.00.00.01 DDR 27/12/2007
        "Vendor DTax Group Code" := Vend."Vendor DTax Group Code";
        // >>DITW15.00.00.01 DDR
        // <<DITW15.00.00.01 DDR 27/12/2007
        "Vendor DDeposit Group Code" := Vend."Vendor DDeposit Group Code";
        // >>DITW15.00.00.01 DDR
        // <<DITW15.00.00.38 DDR 12/08/2010 #1217
        Distance := Vend.Distance;
        // >>DITW15.00.00.38 DDR
        //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968
        "Delivery Sequence" := Vend."Delivery Sequence";
        // <<DITW19.00.08 DDR 12/08/2016 BL#10314
        if "Document Type" in ["Document Type"::Order,"Document Type"::"Return Order"] then
        // >>DITW19.00.08 DDR BL#10314
          //<< DITW18.00.07 VSC 23/06/2016 DIT-770 #2058
          SetRoute(Vend,PurchSetup);
        //>> DITW18.00.07 VSC DIT-770 #1968
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1984 - #154
        "Truck Zone":= Vend."Truck Zone";
        "Require 2 Drivers" := Vend."Require 2 Drivers";
        //>> DITW18.00.07 VSC DIT-770 #1984 - #154


        // <<DITW15.00.00.28 DDR 24/11/2008
        "Vendor Tax Registration No." := Vend."Tax Registration No.";
        "Fiscal Representative No." := Vend."Fiscal Representative No.";
        // >>DITW15.00.00.28 DDR
        // <<DITW15.00.00.38 DDR 13/09/2010 #1217
        "Vendor Tax Warehouse Ref." := Vend."Tax Warehouse Reference";
        // >>DITW15.00.00.38 DDR
        // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
        "Tax Office Code" := Vend."Tax Office Code";
        // <<DITW15.00.00.38 DDR #1217 (DIT711 137)
        // <<DITW15.00.00.39 DDR 06/07/2011 #1353
        "Journey Time" := Vend."Journey Time";
        // >>DITW15.00.00.39 DDR #1353
        // <<DITW15.00.00.35 DDR 24/06/2009
        "Gen. Bus. Posting Free Group" := Vend."Gen. Bus. Posting Free Group";
        "Free Item Posting Type" := Vend."Free Item Posting Type";
        // >>DITW15.00.00.35 DDR
        // <<DITW19.00.08 DDR 12/08/2016 BL#10314
        if ("Document Type" in ["Document Type"::Order,"Document Type"::"Return Order"]) or
          PurchSetup."Receipt on Invoice" or PurchSetup."Return Shipment on Credit Memo"
        then
        // >>DITW19.00.08 DDR BL#10314
          //<< DITW18.00.07 AKH 27/04/2016 DIT-770 #1346
          "Vendor Delivery Type" := Vend."Vendor Delivery Type";
          //>> DITW18.00.07 AKH DIT-770 #1346

        //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
        if Vend."Shipping Agent Code" <> '' then
          "Shipping Agent Code" := Vend."Shipping Agent Code"
        //>> HEI.36
        else
          "Shipping Agent Code" := '';
        //<< HEI.36
        if Vend."Shipping Agent Service Code" <> '' then
          VALIDATE("Shipping Agent Service Code",Vend."Shipping Agent Service Code")
        //>> HEI.36
        else
          VALIDATE("Shipping Agent Service Code",'');
        //<< HEI.36
        //>> DITW18.00.07 VSC DIT-770 #1066

        if "Buy-from Vendor No." = xRec."Pay-to Vendor No." then
          if ReceivedPurchLinesExist or ReturnShipmentExist then begin
            TESTFIELD("VAT Bus. Posting Group",xRec."VAT Bus. Posting Group");
            TESTFIELD("Gen. Bus. Posting Group",xRec."Gen. Bus. Posting Group");
            // <<DITW15.00.00.34 DDR 09/07/2009
            TESTFIELD("Vendor DTax Group Code",xRec."Vendor DTax Group Code");
            TESTFIELD("Vendor DDeposit Group Code",xRec."Vendor DDeposit Group Code");
            // >>DITW15.00.00.34 DDR
          end;

        "Buy-from IC Partner Code" := Vend."IC Partner Code";
        "Send IC Document" := ("Buy-from IC Partner Code" <> '') and ("IC Direction" = "IC Direction"::Outgoing);

        // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
        if xRec."Buy-from Vendor No." <> "Buy-from Vendor No." then
          "Order Address Code" := '';
        // >>DITW16.00.00.43 DDR DIT-715 #860

        if Vend."Pay-to Vendor No." <> '' then
          VALIDATE("Pay-to Vendor No.",Vend."Pay-to Vendor No.")
        else begin
          if "Buy-from Vendor No." = "Pay-to Vendor No." then
            SkipPayToContact := true;
          VALIDATE("Pay-to Vendor No.","Buy-from Vendor No.");
          SkipPayToContact := false;
        end;

        CreateShippingCost(Rec,true,false); //HEI.34 FDD-HT658 IBM.GUNERE01 26.09.2019

        // <<DITW18.00.06 MSF 11/06/2015 DIT-770 #1416 #1417
        if Vend."Responsibility Center" <> '' then begin
          // <<DITW18.00.06 DDR 02/03/2015 DIT-770 #1191
          UserSetupMgt.SetRespCenterDoc("Responsibility Center");
          //<<DITW18.00.06 MSF 17/09/2015 DIT-770 #1600
          VALIDATE("Responsibility Center",UserSetupMgt.GetRespCenter(1,Vend."Responsibility Center"));
          //>>DITW18.00.06 MSF 17/09/2015 DIT-770 #1600
          // >>DITW18.00.06 DDR DIT-770 #1191
        end;
        // >>DITW18.00.06 DDR DIT-770 #1191
        // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1191
        //VALIDATE("Location Code",UserSetupMgt.GetLocation(1,Vend."Location Code","Responsibility Center"));
        VendLocationCode := UserSetupMgt.GetLocation(1,Vend."Location Code","Responsibility Center");
        if VendLocationCode <> '' then begin
          // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1191
          if UserSetupMgt.CheckLocation(1,VendLocationCode,"Responsibility Center") then
          // >>DITW18.00.06 DDR DIT-770 #1191
            VALIDATE("Location Code",VendLocationCode)
          else begin
            if HideValidationDialog or not GUIALLOWED then
              Confirmed := true
            else
              Confirmed :=
                CONFIRM(Text2014414 + Text2014415,false,
                  Vend.TABLECAPTION,"Buy-from Vendor No.",
                  FIELDCAPTION("Location Code"),VendLocationCode);
            if not Confirmed then
              ERROR(Text2014416);
          end;
        end;
        // >>DITW18.00.06 MSF 11/06/2015 DIT-770 #1416 #1417
        // <<DITW15.00.00.39 DDR 06/07/2011 #1353
        GetJourneyTime(FIELDNO("Buy-from Vendor No."));
        // >>DITW15.00.00.39 DDR #1353

        #62..65
        if (xRec."Buy-from Vendor No." <> "Buy-from Vendor No.") or
           (xRec."Currency Code" <> "Currency Code") or
           (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group") or
           (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group") or
           // <<DITW15.00.00.35 DDR 24/06/2009
           (xRec."Gen. Bus. Posting Free Group" <> "Gen. Bus. Posting Free Group")
           // >>DITW15.00.00.35 DDR
        then
          RecreatePurchLines(BuyFromVendorTxt);

        // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
        if not HasRecreatePurchaseLines then begin
          if xRec."Vendor DTax Group Code" <> "Vendor DTax Group Code" then begin
            RecreateChargePurchaseLines(FIELDCAPTION("Vendor DTax Group Code"));
            // <<DITW17.10.05 MSF 17/07/2014 DIT-770 #698
            UpdatePurchLines(FIELDCAPTION("Vendor DTax Group Code"),CurrFieldNo <> 0);
            // >>DITW17.10.05 MSF DIT-770 #698

          end;
          if xRec."Vendor DDeposit Group Code" <> "Vendor DDeposit Group Code" then
            RecreateChargePurchaseLines(FIELDCAPTION("Vendor DDeposit Group Code"));
        end;
        // >>DITW16.00.00.43 DDR DIT-715 #691

        if not SkipBuyFromContact then
          UpdateBuyFromCont("Buy-from Vendor No.");
        //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968 -> DITW15.00.00.39 RBE 21/04/2011 #1230
        fctFillDeliverySequence;
        //>> DITW18.00.07 VSC DIT-770 #1968 -> DITW15.00.00.39 RBE 21/04/2011 #1230
        //<<DITW17.00.02 SR 12/09/2013 DIT-770 #153
        VALIDATE("Linked Customer No.",Vend."Linked Customer No.");
        //>>DITW17.00.02 SR DIT-770 #153
        //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        if xRec."Pay-to Vendor No." <> "Pay-to Vendor No." then
          UpdateRoutePlanRqstLines(FIELDCAPTION("Pay-to Vendor No."));
        //>> DITW18.00.07 VSC DIT-770 #1984 - #1981-> DIT-770 #1488
        // <<DITW18.00.07 MVN 04/06/2016 DIT-770 #1397
        if "Document Type" = "Document Type"::"Return Order" then begin
          if ApplMgt.IsObjectLicense(5,CODEUNIT::"EMCS EDI Mgt",4) <> 0 then
            // <<DITW110.00.09 DDR 21/03/2017 NRQ#13144
            "Submission Type" := EMCSEDIMgt.GetSubmissionType(2,"Vendor DTax Group Code","Location Code");
            // >>DITW110.00.09 DDR NRQ#13144
        end;
        // >>DITW18.00.07 MVN DIT-770 #1397
        //HEI.12 PATHAA02>>
        if Vend.GET("Buy-from Vendor No.") then
          "Vendor Bank Account" := Vend."Preferred Bank Account Code";
        //HEI.12 PATHAA02<<
        */
        //end;


        //Unsupported feature: CodeModification on ""No."(Field 3).OnValidate". Please convert manually.

        //trigger "(Field 3)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." <> xRec."No." THEN BEGIN
          PurchSetup.GET;
          NoSeriesMgt.TestManual(GetNoSeriesCode);
          "No. Series" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "No." <> xRec."No." then begin
        #2..4
        end;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Pay-to Vendor No."(Field 4).OnValidate". Please convert manually.

        //trigger (Variable: OrderAddr)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Pay-to Vendor No."(Field 4).OnValidate". Please convert manually.

        //trigger "(Field 4)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        IF (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") AND
           (xRec."Pay-to Vendor No." <> '')
        THEN BEGIN
          IF HideValidationDialog THEN
            Confirmed := TRUE
          else
            Confirmed := CONFIRM(ConfirmChangeQst,FALSE,PayToVendorTxt);
          IF Confirmed THEN BEGIN
            PurchLine.SETRANGE("Document Type","Document Type");
            PurchLine.SETRANGE("Document No.","No.");

            CheckReceiptInfo(PurchLine,TRUE);
            CheckPrepmtInfo(PurchLine);
            CheckReturnInfo(PurchLine,TRUE);

            PurchLine.RESET;
          end else
            "Pay-to Vendor No." := xRec."Pay-to Vendor No.";
        end;

        GetVend("Pay-to Vendor No.");
        Vend.CheckBlockedVendOnDocs(Vend,FALSE);
        Vend.TESTFIELD("Vendor Posting Group");

        "Pay-to Name" := Vend.Name;
        "Pay-to Name 2" := Vend."Name 2";
        CopyPayToVendorAddressFieldsFromVendor(Vend);
        IF NOT SkipPayToContact THEN
          "Pay-to Contact" := Vend.Contact;
        "Payment Terms Code" := Vend."Payment Terms Code";
        "Prepmt. Payment Terms Code" := Vend."Payment Terms Code";

        IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
          "Payment Method Code" := '';
          IF PaymentTerms.GET("Payment Terms Code") THEN
            IF PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN
              "Payment Method Code" := Vend."Payment Method Code"
        end else
          "Payment Method Code" := Vend."Payment Method Code";

        "Shipment Method Code" := Vend."Shipment Method Code";
        "Vendor Posting Group" := Vend."Vendor Posting Group";
        GLSetup.GET;
        IF GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." THEN BEGIN
          "VAT Bus. Posting Group" := Vend."VAT Bus. Posting Group";
          "VAT Country/Region Code" := Vend."Country/Region Code";
          "VAT Registration No." := Vend."VAT Registration No.";
          "Gen. Bus. Posting Group" := Vend."Gen. Bus. Posting Group";
        end;
        "Prices Including VAT" := Vend."Prices Including VAT";
        "Currency Code" := Vend."Currency Code";
        "Invoice Disc. Code" := Vend."Invoice Disc. Code";
        "Language Code" := Vend."Language Code";
        "Purchaser Code" := Vend."Purchaser Code";
        VALIDATE("Payment Terms Code");
        VALIDATE("Prepmt. Payment Terms Code");
        VALIDATE("Payment Method Code");
        VALIDATE("Currency Code");
        VALIDATE("Creditor No.",Vend."Creditor No.");

        IF "Document Type" = "Document Type"::Order THEN
          VALIDATE("Prepayment %",Vend."Prepayment %");

        IF "Pay-to Vendor No." = xRec."Pay-to Vendor No." THEN BEGIN
          IF ReceivedPurchLinesExist THEN
            TESTFIELD("Currency Code",xRec."Currency Code");
        end;

        CreateDim(
          DATABASE::Vendor,"Pay-to Vendor No.",
          DATABASE::"Salesperson/Purchaser","Purchaser Code",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center");

        IF (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") AND
           (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.")
        THEN
          RecreatePurchLines(PayToVendorTxt);

        IF NOT SkipPayToContact THEN
          UpdatePayToCont("Pay-to Vendor No.");

        "Pay-to IC Partner Code" := Vend."IC Partner Code";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        if (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") and
           (xRec."Pay-to Vendor No." <> '')
        then begin
          //IF HideValidationDialog THEN
          // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
          InitHasBeenShow(HasBeenShowPayTo,'',FIELDNO("Pay-to Vendor No."));
          if HideValidationDialog or not GUIALLOWED or HasBeenShowPayTo then
          // >>DITW16.00.00.43 DDR DIT-715 #860
            Confirmed := true
          else
            Confirmed := CONFIRM(ConfirmChangeQst,false,PayToVendorTxt);

          // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
          HasBeenShowPayTo := Confirmed;
          // >>DITW16.00.00.43 DDR DIT-715 #860

          if Confirmed then begin
        #10..12
            CheckReceiptInfo(PurchLine,true);
            CheckPrepmtInfo(PurchLine);
            CheckReturnInfo(PurchLine,true);

            PurchLine.RESET;
          end else
            "Pay-to Vendor No." := xRec."Pay-to Vendor No.";
        end;

        //<< DITW18.00.07 AKH 20/04/2016 DIT-770 #1941
        GetVend("Buy-from Vendor No.");
        VendBuyfrom := Vend;
        //>> DITW18.00.07 AKH DIT-770 #1941

        GetVend("Pay-to Vendor No.");
        Vend.CheckBlockedVendOnDocs(Vend,false);
        Vend.TESTFIELD("Vendor Posting Group");
        // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
        if Vend."Split Deposit on Invoice" then
          Vend.TESTFIELD(Vend."Deposit Vendor Posting Group")
        else begin
          "Deposit Vendor Posting Group" := '';
          "Deposit Payment Terms Code" := '';
          "Deposit Payment Method Code" := '';
          "Deposit Bal. Account Type" := 0;
          "Deposit Bal. Account No." := '';
        end;
        // >>DITW16.00.00.42 DDR DIT-715 #370
        #25..28
        if not SkipPayToContact then
          "Pay-to Contact" := Vend.Contact;
        //<< DITW18.00.07 AKH 20/04/2016 - 11/05/2016 DIT-770 #1941
        if VendBuyfrom."Calculate Payment Terms From" = VendBuyfrom."Calculate Payment Terms From"::"Buy-from Vendor" then begin
          "Payment Terms Code" := VendBuyfrom."Payment Terms Code";
          if VendBuyfrom."Split Deposit on Invoice" then
            "Deposit Payment Terms Code" := VendBuyfrom."Deposit Payment Terms Code";
        end else begin
        //>> DITW18.00.07 AKH DIT-770 #1941
          "Payment Terms Code" := Vend."Payment Terms Code";
          "Prepmt. Payment Terms Code" := Vend."Payment Terms Code";
          // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
          if Vend."Split Deposit on Invoice" then
            "Deposit Payment Terms Code" := Vend."Deposit Payment Terms Code";
          // >>DITW16.00.00.42 DDR DIT-715 #370
          //<< DITW18.00.07 AKH 20/04/2016 DIT-770 #1941
        end;
        //>> DITW18.00.07 AKH DIT-770 #1941
        //>> DITW18.00.07 AKH 20/04/2016  - 11/05/2016 DIT-770 #1941
        if VendBuyfrom."Calculate Payment Method From" = VendBuyfrom."Calculate Payment Method From"::"Buy-from Vendor" then begin
          if "Document Type" = "Document Type"::"Credit Memo" then begin
            "Payment Method Code" := '';
            if PaymentTerms.GET("Payment Terms Code") then
              if PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then
                "Payment Method Code" := VendBuyfrom."Payment Method Code"
          end else
            "Payment Method Code" := VendBuyfrom."Payment Method Code";

          if VendBuyfrom."Split Deposit on Invoice" then begin
            if "Document Type" = "Document Type"::"Credit Memo" then begin
              "Deposit Payment Method Code" := '';
               if PaymentTerms.GET("Deposit Payment Terms Code") then
                 if PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then
                   "Deposit Payment Method Code" := VendBuyfrom."Deposit Payment Method Code";
            end else
              "Deposit Payment Method Code" := VendBuyfrom."Deposit Payment Method Code";
          end;
        end else begin
        //>> DITW18.00.07 AKH DIT-770 #1941
          if "Document Type" = "Document Type"::"Credit Memo" then begin
            "Payment Method Code" := '';
            if PaymentTerms.GET("Payment Terms Code") then
              if PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then
                "Payment Method Code" := Vend."Payment Method Code"
          end else
            "Payment Method Code" := Vend."Payment Method Code";

          // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
          if Vend."Split Deposit on Invoice" then begin
            if "Document Type" = "Document Type"::"Credit Memo" then begin
              "Deposit Payment Method Code" := '';
              if PaymentTerms.GET("Deposit Payment Terms Code") then
                if PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then
                  "Deposit Payment Method Code" := Vend."Deposit Payment Method Code";
            end else
              "Deposit Payment Method Code" := Vend."Deposit Payment Method Code";
          end;
          // >>DITW16.00.00.42 DDR DIT-715 #370
        //<< DITW18.00.07 AKH 20/04/2016 DIT-770 #1941
        end;
        //>> DITW18.00.07 AKH DIT-770 #1941
        //HEI.54>>
        //"Shipment Method Code" := Vend."Shipment Method Code";
        VALIDATE("Shipment Method Code",Vend."Shipment Method Code");
        //HEI.54<<
        "Vendor Posting Group" := Vend."Vendor Posting Group";
        // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
        if Vend."Split Deposit on Invoice" then
          "Deposit Vendor Posting Group" := Vend."Deposit Vendor Posting Group";
        // >>DITW16.00.00.42 DDR DIT-715 #370
        // <<DITW15.00.00.35 DDR 24/06/2009
        "Gen. Bus. Posting Free Group" := Vend."Gen. Bus. Posting Free Group";
        "Free Item Posting Type" := Vend."Free Item Posting Type";
        // >>DITW15.00.00.35 DDR
        // <<DITW15.00.00.39 DDR 27/07/2011 #1407
        "Autom. Item Charge" := Vend."Autom. Item Charge";
        // >>DITW15.00.00.39 DDR #1407

        GLSetup.GET;
        if GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." then begin
        #46..49
        end;
        "Prices Including VAT" := Vend."Prices Including VAT";
        "Currency Code" := Vend."Currency Code";
        //<< DITW18.00.07 AKH 20/04/2016 DIT-770 #1941
        if IsVendCalcPrices(VendBuyfrom,PurchSetup."Pay-to/Buy-from Prices Calc."::"Pay-to") then
        //>> DITW18.00.07 AKH DIT-770 #1941
          "Invoice Disc. Code" := Vend."Invoice Disc. Code";

        #54..58
        // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
        VALIDATE("Deposit Payment Terms Code");
        VALIDATE("Deposit Payment Method Code");
        // >>DITW16.00.00.42 DDR DIT-715 #370
        VALIDATE("Currency Code");
        VALIDATE("Creditor No.",Vend."Creditor No.");
        //<< DITW18.00.07 AKH 20/04/2016 DIT-770 #1941
        if IsVendCalcPrices(VendBuyfrom,PurchSetup."Pay-to/Buy-from Prices Calc."::"Pay-to") then
        //>> DITW18.00.07 AKH DIT-770 #1941
          if "Document Type" = "Document Type"::Order then
            VALIDATE("Prepayment %",Vend."Prepayment %");

        // <<DITW15.00.00.01 DDR 27/12/2007 - DITW15.00.00.25 DDR 21/10/2008 - DITW15.00.00.38 DDR 23/02/2011 #1286
        if ("Order Address Code" = '') and
          //<< DITW18.00.07 AKH 20/04/2016 DIT-770 #1941
          IsVendCalcTaxes(VendBuyfrom,GLSetup."Sell-to/Bill-to DTax Gr. Calc."::"Bill-to/Pay-to No.")
          //>> DITW18.00.07 AKH DIT-770 #1941
        then
          "Vendor DTax Group Code" := Vend."Vendor DTax Group Code";
        // >>DITW15.00.00.38 DDR #1286

        //<< DITW18.00.07 AKH 20/04/2016 DIT-770 #1941
        if IsVendCalcPrices(VendBuyfrom,PurchSetup."Pay-to/Buy-from Prices Calc."::"Pay-to") then
        //>> DITW18.00.07 AKH DIT-770 #1941
          // <<DITW15.00.00.01 DDR 27/12/2007
          "Vendor DDeposit Group Code" := Vend."Vendor DDeposit Group Code";
          // >>DITW15.00.00.01 DDR

        if "Pay-to Vendor No." = xRec."Pay-to Vendor No." then begin
          if ReceivedPurchLinesExist then begin
            TESTFIELD("Currency Code",xRec."Currency Code");
            // <<DITW15.00.00.34 DDR 09/07/2009
            TESTFIELD("Vendor DTax Group Code",xRec."Vendor DTax Group Code");
            TESTFIELD("Vendor DDeposit Group Code",xRec."Vendor DDeposit Group Code");
            // >>DITW15.00.00.34 DDR
          end;
        end;
        //<<DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362
        CreateDim(
          // <<DITW16.00.00.42 DDR 13/12/2012 DIT-715 #522
          //DATABASE::Vendor,"Pay-to Vendor No.",
          DATABASE::Vendor,GetVendNoCalcDim(),
          // >>DITW16.00.00.42 DDR DIT-715 #522
          DATABASE::"Salesperson/Purchaser","Purchaser Code",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(2,"Contract Type"),GetContractNo(),
          //<<DITW110.00.10 MSF 15/06/2017 NRQ#13382
          DATABASE::Customer,"Linked Customer No.");
          //>>DITW110.00.10 MSF 15/06/2017 NRQ#13382
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
        //>>DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362

        if (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and
           (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.")
        then
          //<< FINXL9.00.000.01 AKH 13/01/2017
          if ReceiptLineExists() and (recUserSetup."Receive Other Pay-to Vendor") then
            UpdatePurchLines(FIELDCAPTION("VAT Bus. Posting Group"),CurrFieldNo <> 0)
          else
            //>> FINXL9.00.000.01 AKH 13/01/2017
            RecreatePurchLines(PayToVendorTxt);

        // <<DITW15.00.00.25 DDR 21/10/2008
        if (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and
           (xRec."Pay-to Vendor No." = "Pay-to Vendor No.") and
           // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
           not HasRecreatePurchaseLines
           // >>DITW16.00.00.43 DDR DIT-715 #691
        then begin
          if xRec."Vendor DTax Group Code" <> "Vendor DTax Group Code" then begin
            // <<DITW17.10.05 MSF 17/07/2014 DIT-770 #698
            UpdatePurchLines(FIELDCAPTION("Vendor DTax Group Code"),CurrFieldNo <> 0);
            // >>DITW17.10.05 MSF DIT-770 #698
            // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
            RecreateChargePurchaseLines(FIELDCAPTION("Vendor DTax Group Code"));
            // >>DITW16.00.00.43 DDR DIT-715 #691
          end;
          if xRec."Vendor DDeposit Group Code" <> "Vendor DDeposit Group Code" then
            // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
            RecreateChargePurchaseLines(FIELDCAPTION("Vendor DDeposit Group Code"));
            // >>DITW16.00.00.43 DDR DIT-715 #691
        end;
        // >>DITW15.00.00.25 DDR

        // <<DITW15.00.00.39 DDR 27/07/2011 #1407
        if (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and
           (xRec."Pay-to Vendor No." = "Pay-to Vendor No.") and
           (xRec."Autom. Item Charge" <> "Autom. Item Charge")
        then begin
          // <<DITW16.00.00.42 DDR 01/03/2013 DIT-715 #572
          PurchLine.RESET;
          // >>DITW16.00.00.42 DDR DIT-715 #572
          DeleteChargePurchLines();
        end;
        // >>DITW15.00.00.39 DDR #1407

        if not SkipPayToContact then
        #82..84

        //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        if xRec."Pay-to Vendor No." <> "Pay-to Vendor No." then
          UpdateRoutePlanRqstLines(FIELDCAPTION("Pay-to Vendor No."));
        //>> DITW18.00.07 VSC DIT-770 #1984 - #1981-> DIT-770 #1488
        PurchasesUtils.OnAfterValidatePurchaseHeaderPaytoVendorNo(Rec,xRec,CurrFieldNo);//HEI.01 PTPGAP066
        */
        //end;


        //Unsupported feature: CodeModification on ""Pay-to City"(Field 9).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Pay-to City","Pay-to Post Code","Pay-to County","Pay-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Pay-to City","Pay-to Post Code","Pay-to County","Pay-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Pay-to Contact"(Field 10).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        LookupContact("Pay-to Vendor No.","Pay-to Contact No.",Contact);
        IF PAGE.RUNMODAL(0,Contact) = ACTION::LookupOK THEN
          VALIDATE("Pay-to Contact No.",Contact."No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        LookupContact("Pay-to Vendor No.","Pay-to Contact No.",Contact);
        if PAGE.RUNMODAL(0,Contact) = ACTION::LookupOK then
          VALIDATE("Pay-to Contact No.",Contact."No.");
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Ship-to Code"(Field 12).OnValidate". Please convert manually.

        //trigger (Variable: VendLocationCode)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Ship-to Code"(Field 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Document Type" = "Document Type"::Order) AND
           (xRec."Ship-to Code" <> "Ship-to Code")
        THEN BEGIN
          PurchLine.SETRANGE("Document Type",PurchLine."Document Type"::Order);
          PurchLine.SETRANGE("Document No.","No.");
          PurchLine.SETFILTER("Sales Order Line No.",'<>0');
          IF NOT PurchLine.ISEMPTY THEN
            ERROR(
              YouCannotChangeFieldErr,
              FIELDCAPTION("Ship-to Code"));
        end;

        IF "Ship-to Code" <> '' THEN BEGIN
          ShipToAddr.GET("Sell-to Customer No.","Ship-to Code");
          SetShipToAddress(
            ShipToAddr.Name,ShipToAddr."Name 2",ShipToAddr.Address,ShipToAddr."Address 2",
            ShipToAddr.City,ShipToAddr."Post Code",ShipToAddr.County,ShipToAddr."Country/Region Code");
          "Ship-to Contact" := ShipToAddr.Contact;
          "Shipment Method Code" := ShipToAddr."Shipment Method Code";
          IF ShipToAddr."Location Code" <> '' THEN
            VALIDATE("Location Code",ShipToAddr."Location Code");
        end else BEGIN
          TESTFIELD("Sell-to Customer No.");
          Cust.GET("Sell-to Customer No.");
          SetShipToAddress(
            Cust.Name,Cust."Name 2",Cust.Address,Cust."Address 2",
            Cust.City,Cust."Post Code",Cust.County,Cust."Country/Region Code");
          "Ship-to Contact" := Cust.Contact;
          "Shipment Method Code" := Cust."Shipment Method Code";
          IF Cust."Location Code" <> '' THEN
            VALIDATE("Location Code",Cust."Location Code");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Document Type" = "Document Type"::Order) and
           (xRec."Ship-to Code" <> "Ship-to Code")
        then begin
        #4..6
          if not PurchLine.ISEMPTY then
        #8..10
        end;

        if "Ship-to Code" <> '' then begin
        #14..19
          if ShipToAddr."Location Code" <> '' then
            VALIDATE("Location Code",ShipToAddr."Location Code");
          // <<DITW15.00.00.38 DDR 11/08/2010 #1217
          "Transaction Type" := ShipToAddr."Transaction Type";
          "Transport Method" := ShipToAddr."Transport Method";
          "Transaction Specification" := ShipToAddr."Transaction Specification";
          "Entry Point" := ShipToAddr."Exit Point";
          Area := ShipToAddr.Area;
          // >>DITW15.00.00.38 DDR
          // <<DITW16.00.00.40 DDR 12/12/2011 #1002
          Distance := ShipToAddr.Distance;
          "Delivery Sequence" := ShipToAddr."Delivery Sequence";
          // >>DITW16.00.00.40 DDR #1002
        end else begin
        #23..29
          // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1191
          VendLocationCode := UserSetupMgt.GetLocation(1,Cust."Location Code","Responsibility Center");
          if (VendLocationCode <> '') and (Cust."Location Code" <> '') and (VendLocationCode <> Cust."Location Code") then begin
          // >>DITW18.00.06 DDR DIT-770 #1191
            if Cust."Location Code" <> '' then
              VALIDATE("Location Code",Cust."Location Code");
          end;
          // <<DITW15.00.00.38 DDR 11/08/2010 #1217
          "Transaction Type" := Cust."Transaction Type";
          "Transport Method" := Cust."Transport Method";
          "Transaction Specification" := Cust."Transaction Specification";
          "Entry Point" := Cust."Exit Point";
          Area := Cust.Area;
          // >>DITW15.00.00.38 DDR
          // <<DITW16.00.00.40 DDR 12/12/2011 #1002
          Distance := Cust.Distance;
          // <<DITW19.00.08 DDR 12/08/2016 BL#10314
          if ("Document Type" in ["Document Type"::Order,"Document Type"::"Return Order"]) or
            PurchSetup."Receipt on Invoice" or PurchSetup."Return Shipment on Credit Memo"
          then begin
          // >>DITW19.00.08 DDR BL#10314
            "Delivery Sequence" := Cust."Delivery Sequence";
          end;
          // >>DITW16.00.00.40 DDR #1002
        end;

        if (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and
           (xRec."Ship-to Code" <> "Ship-to Code")
        then
          if (xRec."VAT Country/Region Code" <> "VAT Country/Region Code") or
             (xRec."Tax Area Code" <> "Tax Area Code")
          then
            RecreatePurchLines(FIELDCAPTION("Ship-to Code"))
          else begin
            if xRec."Tax Liable" <> "Tax Liable" then
              VALIDATE("Tax Liable");
          end;

        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1109
        ClearHasBeenShowAll2(FIELDNO("Ship-to Code"));
        // >>DITW18.00.07 DDR DIT-770 #1109
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Ship-to Name"(Field 13)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.46>>
         if PurchSetup.GET then begin
          PurchaseLine.SETRANGE("Document Type","Document Type");
          PurchaseLine.SETRANGE("Document No.","No.");
          PurchaseLine.SETFILTER(Type,'%1',PurchaseLine.Type::Item);
          PurchaseLine.SETFILTER("Item Category Code",PurchSetup."Item Category");
          if not PurchaseLine.FINDFIRST then
            ItemCategoryBool := false
          else
            ItemCategoryBool := true;
         end;
        if ItemCategoryBool then begin
         if ("SRM Order No." = '') and (("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::"Return Order")) then begin
            PurchHdrArch.RESET;
            PurchHdrArch.SETRANGE(PurchHdrArch."Document Type","Document Type");
            PurchHdrArch.SETRANGE(PurchHdrArch."No.","No.");
            if PurchHdrArch.FINDFIRST then begin
              PurchHeader.RESET;
              PurchHeader.SETRANGE(PurchHeader."No.","No.");
              if PurchHeader.FINDFIRST then begin
                if PurchHeader."Purch. Reason Code" = '' then
                  ERROR(ReasonCodeErr);
              end;
            end;
         end;
        end;
        //HEI.46<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Ship-to Name 2"(Field 14)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.46>>
           if PurchSetup.GET then begin
          PurchaseLine.SETRANGE("Document Type","Document Type");
          PurchaseLine.SETRANGE("Document No.","No.");
          PurchaseLine.SETFILTER(Type,'%1',PurchaseLine.Type::Item);
          PurchaseLine.SETFILTER("Item Category Code",PurchSetup."Item Category");
          if not PurchaseLine.FINDFIRST then
            ItemCategoryBool := false
          else
            ItemCategoryBool := true;
         end;
        if ItemCategoryBool then begin
         if ("SRM Order No." = '') and (("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::"Return Order")) then begin
            PurchHdrArch.RESET;
            PurchHdrArch.SETRANGE(PurchHdrArch."Document Type","Document Type");
            PurchHdrArch.SETRANGE(PurchHdrArch."No.","No.");
            if PurchHdrArch.FINDFIRST then begin
              PurchHeader.RESET;
              PurchHeader.SETRANGE(PurchHeader."No.","No.");
              if PurchHeader.FINDFIRST then begin
                if PurchHeader."Purch. Reason Code" = '' then
                  ERROR(ReasonCodeErr);
              end;
            end;
         end;
        end;
        //HEI.46<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Ship-to Address"(Field 15)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.46>>
        if PurchSetup.GET then begin
          PurchaseLine.SETRANGE("Document Type","Document Type");
          PurchaseLine.SETRANGE("Document No.","No.");
          PurchaseLine.SETFILTER(Type,'%1',PurchaseLine.Type::Item);
          PurchaseLine.SETFILTER("Item Category Code",PurchSetup."Item Category");
          if not PurchaseLine.FINDFIRST then
            ItemCategoryBool := false
          else
            ItemCategoryBool := true;
         end;
        if ItemCategoryBool then begin
         if ("SRM Order No." = '') and (("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::"Return Order")) then begin
            PurchHdrArch.RESET;
            PurchHdrArch.SETRANGE(PurchHdrArch."Document Type","Document Type");
            PurchHdrArch.SETRANGE(PurchHdrArch."No.","No.");
            if PurchHdrArch.FINDFIRST then begin
              PurchHeader.RESET;
              PurchHeader.SETRANGE(PurchHeader."No.","No.");
              if PurchHeader.FINDFIRST then begin
                if PurchHeader."Purch. Reason Code" = '' then
                  ERROR(ReasonCodeErr);
              end;
            end;
         end;
        end;
        //HEI.46<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Ship-to City"(Field 17).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Ship-to City","Ship-to Post Code","Ship-to County","Ship-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Ship-to City","Ship-to Post Code","Ship-to County","Ship-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        //HEI.46>>
         if PurchSetup.GET then begin
          PurchaseLine.SETRANGE("Document Type","Document Type");
          PurchaseLine.SETRANGE("Document No.","No.");
          PurchaseLine.SETFILTER(Type,'%1',PurchaseLine.Type::Item);
          PurchaseLine.SETFILTER("Item Category Code",PurchSetup."Item Category");
          if not PurchaseLine.FINDFIRST then
            ItemCategoryBool := false
          else
            ItemCategoryBool := true;
         end;
        if ItemCategoryBool then begin
         if ("SRM Order No." = '') and (("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::"Return Order")) then begin
            PurchHdrArch.RESET;
            PurchHdrArch.SETRANGE(PurchHdrArch."Document Type","Document Type");
            PurchHdrArch.SETRANGE(PurchHdrArch."No.","No.");
            if PurchHdrArch.FINDFIRST then begin
              PurchHeader.RESET;
              PurchHeader.SETRANGE(PurchHeader."No.","No.");
              if PurchHeader.FINDFIRST then begin
                if PurchHeader."Purch. Reason Code" = '' then
                  ERROR(ReasonCodeErr);
              end;
            end;
         end;
        end;
        //HEI.46<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Ship-to Contact"(Field 18)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.46>>
            if ("SRM Order No." = '') and (("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::"Return Order")) then begin
            PurchHdrArch.RESET;
            PurchHdrArch.SETRANGE(PurchHdrArch."Document Type","Document Type");
            PurchHdrArch.SETRANGE(PurchHdrArch."No.","No.");
            if PurchHdrArch.FINDFIRST then begin
              if "Purch. Reason Code" = '' then
                  ERROR(ReasonCodeErr);
            end;
        end;
        //HEI.46<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Order Date"(Field 19).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        IF ("Document Type" IN ["Document Type"::Quote,"Document Type"::Order]) AND
           NOT ("Order Date" = xRec."Order Date")
        THEN
          PriceMessageIfPurchLinesExist(FIELDCAPTION("Order Date"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975
        TestOpenStatus;
        //TESTFIELD(Status,Status::Open);
        //>> DITW18.00.07 VSC  DIT-770 #1975
        if ("Document Type" in ["Document Type"::Quote,"Document Type"::Order]) and
           not ("Order Date" = xRec."Order Date")
        then
          PriceMessageIfPurchLinesExist(FIELDCAPTION("Order Date"));

        // <<DITW15.00.00.39 DDR 19/08/2011 #1363
        PurchSetup.GET;
        if not ("Document Type" in ["Document Type"::Invoice,"Document Type"::"Credit Memo"]) and
           (PurchSetup."Default Tax Date" = PurchSetup."Default Tax Date"::OrderDate)
        then
          VALIDATE("Tax Date","Order Date");
        // >>DITW15.00.00.39 DDR #1363
        // <<DITW16.00.00.42 DDR 01/03/2013 DIT-715 #572
        if "Order Date" = 0D then begin
          PurchLine.RESET;
          if "Tax Date" <> 0D then
            PurchLine.SETFILTER("Item Charge Type",'<>%1',PurchLine."Item Charge Type"::Tax);
          DeleteChargePurchLines();
          RecalcBackPurchLines();
        end else
          // <<DITW17.10.05 DDR 26/01/2015 DIT-770 #885
          if (xRec."Order Date" <> "Order Date") and
            (xRec."Buy-from Vendor No." = "Buy-from Vendor No.")
          then
            RecreateChargePurchaseLines(FIELDCAPTION("Order Date"));
          // >>DITW17.10.05 DDR DIT-770 #885

        // >>DITW16.00.00.42 DDR DIT-715 #572
        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1109
        ClearHasBeenShowAll2(FIELDNO("Order Date"));
        // >>DITW18.00.07 DDR DIT-770 #1109
        */
        //end;


        //Unsupported feature: CodeModification on ""Posting Date"(Field 20).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestNoSeriesDate(
          "Posting No.","Posting No. Series",
          FIELDCAPTION("Posting No."),FIELDCAPTION("Posting No. Series"));
        #4..7
          "Prepmt. Cr. Memo No.","Prepmt. Cr. Memo No. Series",
          FIELDCAPTION("Prepmt. Cr. Memo No."),FIELDCAPTION("Prepmt. Cr. Memo No. Series"));

        IF "Incoming Document Entry No." = 0 THEN
          VALIDATE("Document Date","Posting Date");

        IF ("Document Type" IN ["Document Type"::Invoice,"Document Type"::"Credit Memo"]) AND
           NOT ("Posting Date" = xRec."Posting Date")
        THEN
          PriceMessageIfPurchLinesExist(FIELDCAPTION("Posting Date"));

        IF "Currency Code" <> '' THEN BEGIN
          UpdateCurrencyFactor;
          IF "Currency Factor" <> xRec."Currency Factor" THEN
            SkipJobCurrFactorUpdate := NOT ConfirmUpdateCurrencyFactor;
        end;

        IF "Posting Date" <> xRec."Posting Date" THEN
          IF DeferralHeadersExist THEN
            ConfirmUpdateDeferralDate;

        IF PurchLinesExist THEN
          JobUpdatePurchLines(SkipJobCurrFactorUpdate);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        if "Multiple Order Route" then
          if CurrFieldNo = FIELDNO("Posting Date") then
            ERROR(STRSUBSTNO(Text2014061,"Document Type","No."));
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        #1..10
        //<<HEI.37 - Below Code is commented to calculate Currency Factor when changing the Document Date instead of changing the Posting Date
        {
        #11..18

        IF "Currency Code" <> '' THEN BEGIN
          UpdateCurrencyFactor;
          // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
          InitHasBeenShow(HasBeenShowText022,'',FIELDNO("Posting Date"));
          // >>DITW16.00.00.43 DDR DIT-715 #860
        #21..23
        }
        //>>HEI.37
        if "Posting Date" <> xRec."Posting Date" then
          if DeferralHeadersExist then
            ConfirmUpdateDeferralDate;

        if PurchLinesExist then
          JobUpdatePurchLines(SkipJobCurrFactorUpdate);
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Expected Receipt Date"(Field 21).OnValidate". Please convert manually.

        //trigger (Variable: TempDate)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Expected Receipt Date"(Field 21).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Expected Receipt Date" <> 0D THEN
          UpdatePurchLines(FIELDCAPTION("Expected Receipt Date"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 23/05/2016 DIT-770 #1968 - #1981 -> #1488
        if not CheckExpectedReceiptDate() then begin
          "Expected Receipt Date" := xRec."Expected Receipt Date";
          exit;
        end;
        //>> DITW18.00.07 VSC DIT-770 #1968 - #1981 -> #1488
        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
          if CheckExistWarehouseLine then
            ERROR(STRSUBSTNO(Text2014061,"Document Type","No."));
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082

        // <<DITW15.00.00.39 DDR 19/08/2011 - 27/09/2011 #1363
        TempDate := "Expected Receipt Date";
        "Expected Receipt Date" := xRec."Expected Receipt Date";
        PurchSetup.GET;
        if PurchSetup."Default Tax Date" = PurchSetup."Default Tax Date"::ShipRecvDate then
          VALIDATE("Tax Date",TempDate);
        "Expected Receipt Date" := TempDate;
        // >>DITW15.00.00.39 DDR #1363

        //<< DITW18.00.07 VSC 23/05/2016 DIT-770 #1968 - #1978 -> #154
        //<< DITW18.00.07 VSC 23/05/2016 DIT-770 #1968 - #1981 -> #1488
        VALIDATE("Posting Date","Expected Receipt Date");
        //<< DITW18.00.07 VSC 23/05/2016 DIT-770 #1968 - #1978 -> #1381
        fctFillDeliveryTimes("Buy-from Vendor No.","Order Address Code","Expected Receipt Date");
        //>> DITW18.00.07 VSC  DIT-770 #1968 - #1978 -> #1381
        //>> DITW18.00.07 VSC 23/05/2016 DIT-770 #1968 - #1978 -> #154

        // <<DITW17.10.05 DDR 26/01/2015 DIT-770 #885
        // <<DITW16.00.00.42 DDR 01/03/2013 DIT-715 #572
        if "Expected Receipt Date" = 0D then begin
          PurchLine.RESET;
          if "Tax Date" <> 0D then
            PurchLine.SETFILTER("Item Charge Type",'<>%1',PurchLine."Item Charge Type"::Tax);
          //IF PurchSetup."Purch. Conditions Based on" = PurchSetup."Purch. Conditions Based on"::ShipRecvDate THEN BEGIN
            DeleteChargePurchLines();
            RecalcBackPurchLines();
          //end;
        end;
        // >>DITW16.00.00.42 DDR DIT-715 #572
        // >>DITW17.10.05 DDR DIT-770 #885

        if "Expected Receipt Date" <> 0D then
          UpdatePurchLines(FIELDCAPTION("Expected Receipt Date"),CurrFieldNo <> 0);

        // <<DITW17.10.05 DDR 01/10/2014 DIT-770 #885
        if (xRec."Expected Receipt Date" <> "Expected Receipt Date") and
          (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and
          (xRec."Order Date" = "Order Date")
          //AND
          //(PurchSetup."Purch. Conditions Based on" = PurchSetup."Purch. Conditions Based on"::ShipRecvDate)
        then
          RecreateChargePurchaseLines(FIELDCAPTION("Expected Receipt Date"));
        // >>DITW17.10.05 DDR DIT-770 #885

        //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        UpdateRoutePlanRqstLines(FIELDCAPTION("Expected Receipt Date"));
        //>> DITW18.00.07 VSC DIT-770 #1984 - #1981-> DIT-770 #1488

        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1109
        ClearHasBeenShowAll2(FIELDNO("Ship-to Code"));
        // >>DITW18.00.07 DDR DIT-770 #1109
        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        UpdateWhseRequestLines(FIELDCAPTION("Expected Receipt Date"));
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082

        //HEI.26>>
        if PurchSetup.GET then begin
          PurchaseLine.SETRANGE("Document No.","No.");
          PurchaseLine.SETFILTER(PurchaseLine."Document Type",'%1',PurchaseLine."Document Type");
          PurchaseLine.SETFILTER(Type,'%1',PurchaseLine.Type::Item);
          PurchaseLine.SETFILTER("Item Category Code",PurchSetup."Item Category");
          if not PurchaseLine.FINDFIRST then
            ItemCategoryBool := false
          else
            ItemCategoryBool := true;
          if ItemCategoryBool then begin
        //HEI.26<<
        //HEI.22>>
            if ("SRM Order No." = '') and (("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::"Return Order")) then begin
            PurchHdrArch.RESET;
            PurchHdrArch.SETRANGE(PurchHdrArch."Document Type","Document Type");
            PurchHdrArch.SETRANGE(PurchHdrArch."No.","No.");
            if PurchHdrArch.FINDFIRST then begin
              if "Purch. Reason Code" = '' then
                  ERROR(ReasonCodeErr);
            end;
        end;
        //HEI.22<<
        //HEI.26>>
          end;
        end;
        //HEI.26<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Terms Code"(Field 23).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
          PaymentTerms.GET("Payment Terms Code");
          IF IsCreditDocType AND NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN BEGIN
            VALIDATE("Due Date","Document Date");
            VALIDATE("Pmt. Discount Date",0D);
            VALIDATE("Payment Discount %",0);
          end else BEGIN
            "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");
            "Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation","Document Date");
            IF NOT UpdateDocumentDate THEN
              VALIDATE("Payment Discount %",PaymentTerms."Discount %")
          end;
        end else BEGIN
          VALIDATE("Due Date","Document Date");
          IF NOT UpdateDocumentDate THEN BEGIN
            VALIDATE("Pmt. Discount Date",0D);
            VALIDATE("Payment Discount %",0);
          end;
        end;
        IF xRec."Payment Terms Code" = "Prepmt. Payment Terms Code" THEN
          VALIDATE("Prepmt. Payment Terms Code","Payment Terms Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Payment Terms Code" <> '') and ("Document Date" <> 0D) then begin
          PaymentTerms.GET("Payment Terms Code");
          if IsCreditDocType and not PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then begin
        #4..6
          end else begin
            "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");
            "Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation","Document Date");
            if not UpdateDocumentDate then
              VALIDATE("Payment Discount %",PaymentTerms."Discount %")
          end;
        end else begin
          VALIDATE("Due Date","Document Date");
          if not UpdateDocumentDate then begin
            VALIDATE("Pmt. Discount Date",0D);
            VALIDATE("Payment Discount %",0);
          end;
        end;
        if xRec."Payment Terms Code" = "Prepmt. Payment Terms Code" then
          VALIDATE("Prepmt. Payment Terms Code","Payment Terms Code");
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Discount %"(Field 25).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT (CurrFieldNo IN [0,FIELDNO("Posting Date"),FIELDNO("Document Date")]) THEN
          TESTFIELD(Status,Status::Open);
        GLSetup.GET;
        IF "Payment Discount %" < GLSetup."VAT Tolerance %" THEN
          "VAT Base Discount %" := "Payment Discount %"
        else
          "VAT Base Discount %" := GLSetup."VAT Tolerance %";
        VALIDATE("VAT Base Discount %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not (CurrFieldNo in [0,FIELDNO("Posting Date"),FIELDNO("Document Date")]) then
          //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
          //TESTFIELD(Status,Status::Open);
          TestOpenStatus;
          //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        GLSetup.GET;
        if "Payment Discount %" < GLSetup."VAT Tolerance %" then
          "VAT Base Discount %" := "Payment Discount %"
        else
          "VAT Base Discount %" := GLSetup."VAT Tolerance %";
        VALIDATE("VAT Base Discount %");
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipment Method Code"(Field 27).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        if "Multiple Order Route" then
          if CurrFieldNo = FIELDNO("Shipment Method Code") then
            ERROR(STRSUBSTNO(Text2014061,"Document Type","No."));
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082

        //<< DITW18.00.07 VSC 27/05/2016 DIT-770 #1975 -> #1402
        PurchSetup.GET;
        //>> DITW18.00.07 VSC DIT-770 #1975 -> #1402

        // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.34 DDR 10/07/2009
        if ("Shipment Method Code" <> xRec."Shipment Method Code") and
           (xRec."Buy-from Vendor No." = "Buy-from Vendor No.")
        then begin
          //<< DITW18.00.07 VSC 27/05/2016 DIT-770 #1975 -> #1402
          if PurchSetup."Recalculate Prices" <> PurchSetup."Recalculate Prices"::" " then
            RecreatePurchLines(FIELDCAPTION("Shipment Method Code"))
          else
            PriceMessageIfPurchLinesExist(FIELDCAPTION("Shipment Method Code"))
          //>> DITW18.00.07 VSC DIT-770 #1975 -> #1402
        end;

        //>> HEI.34 FDD-HT658 IBM.GUNERE01 27.09.2019
        if xRec."Shipment Method Code" <> Rec."Shipment Method Code" then
          //IF Rec."Shipment Method Code" = '' THEN //HEI.36
            WhseTransportMgt.DeletePurchShippingCost(xRec,true);
        //<< HEI.34 FDD-HT658 IBM.GUNERE01 27.09.2019

        CreateShippingCost(Rec,true,true); //HEI.34 FDD-HT658 IBM.GUNERE01 27.09.2019

        // >>DITW15.00.00.34 DDR
        //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        if xRec."Shipment Method Code" <> "Shipment Method Code" then
          UpdateRoutePlanRqstLines(FIELDCAPTION("Shipment Method Code"));
        //<< DITW18.00.07 VSC DIT-770 #1984 - #1981-> DIT-770 #1488
        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1109
        ClearHasBeenShowAll2(FIELDNO("Ship-to Code"));
        // >>DITW18.00.07 DDR DIT-770 #1109
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Field 28).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        IF ("Location Code" <> xRec."Location Code") AND
           (xRec."Buy-from Vendor No." = "Buy-from Vendor No.")
        THEN
          MessageIfPurchLinesExist(FIELDCAPTION("Location Code"));

        UpdateShipToAddress;

        IF "Location Code" = '' THEN BEGIN
          IF InvtSetup.GET THEN
            "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
        end else BEGIN
          IF Location.GET("Location Code") THEN;
          "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159

        // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1191
        if (("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> xRec."Location Code") and
          ("Location Code" <> ''))
        then begin
          Location.GET("Location Code");
          //<< DITW18.00.07 VSC 10/03/2016 DIT-770 #1066
          "Auto Create Shipping Cost" := Location."Auto Create Shipping Cost";
          //>> DITW18.00.07 VSC DIT-770 #1066
          VALIDATE("Responsibility Center",UserSetupMgt.GetFirstRespCenter(1,Location."Physical Location Group Code","Location Code"));
        end;
        // >>DITW18.00.06 DDR DIT-770 #1191

        // <<DITW18.00.06 DDR 19/02/2015 25/02/2015 DIT-770 #1191
        if (("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> '')) or
          ("Responsibility Center" <> xRec."Responsibility Center")
        then
          if not UserSetupMgt.CheckLocation(1,"Location Code","Responsibility Center") then
            ERROR(
              Text2014412,
              Location.TABLECAPTION,"Location Code",
              RespCenter.TABLECAPTION,UserSetupMgt.GetPurchasesFilter);
        // >>DITW18.00.06 DDR DIT-770 #1191

        if ("Location Code" <> xRec."Location Code") and
           (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and
          // <<DITW18.00.06 DDR 19/02/2015 DIT-770 #1191
          ((xRec."Physical Location Group Code" = "Physical Location Group Code") or
          (CurrFieldNo <> FIELDNO("Physical Location Group Code")))
          // >>DITW18.00.06 DDR DIT-770 #1191
        then begin
          // <<DITW18.00.06 DDR 19/02/2015 DIT-770 #1191
          // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1191 - DITW18.00.07 DDR 02/05/2016 DIT-770 #1402
          if (CurrFieldNo <> FIELDNO("Responsibility Center")) and PurchLinesExist then begin
          // >>DITW18.00.06 DDR DIT-770 #1191 - DITW18.00.07 DDR DIT-770 #1402
            InitHasBeenShow(HasBeenShowText2014410,FIELDCAPTION("Location Code"),0);
            if HideValidationDialog or not GUIALLOWED or HasBeenShowText2014410 then
              Confirmed := true
            else
              Confirmed :=
                CONFIRM(
                  Text2014413 +
                  Text004,false,FIELDCAPTION("Location Code"));
            HasBeenShowText2014410 := Confirmed;
          end;
          if Confirmed then
            UpdatePurchLines(FIELDCAPTION("Location Code"),CurrFieldNo <> 0);
          // >>DITW18.00.06 DDR DIT-770 #1191
        end;

        // <<DITW18.00.06 DDR 19/02/2015 DIT-770 #1191
        if "Location Code" <> '' then begin
          Location.GET("Location Code");
          if Location."Physical Location Group Code" <> "Physical Location Group Code" then
            "Physical Location Group Code" := Location."Physical Location Group Code";
          //<< DITW18.00.07 VSC 10/03/2016 DIT-770 #1066
          "Auto Create Shipping Cost" := Location."Auto Create Shipping Cost";
          //>> DITW18.00.07 VSC DIT-770 #1066
        end else
          if xRec."Physical Location Group Code" = "Physical Location Group Code" then
            "Physical Location Group Code" := '';
        if xRec."Physical Location Group Code" = "Physical Location Group Code" then
          VALIDATE("Physical Location Group Code");
        // >>DITW18.00.06 DDR DIT-770 #1191
        #6..8
        if "Location Code" = '' then begin
          if InvtSetup.GET then
            "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
        end else begin
          if Location.GET("Location Code") then;
          "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
          //<< DITW18.00.07 VSC 10/03/2016 DIT-770 #1066
          "Auto Create Shipping Cost" := Location."Auto Create Shipping Cost";
          //>> DITW18.00.07 VSC DIT-770 #1066
        end;

        //<< DITW18.00.07 VSC 10/03/2016 DIT-770 #1066
        //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
        //<< DITW18.00.07 VSC 04/07/2016 DIT-770 #1066
        //CreateShippingCost(Rec); //HEI.34 FDD-HT658 IBM.GUNERE01 25.09.2019
        //>> DITW18.00.07 VSC DIT-770 #1066
        //>> DITW18.00.07 VSC DIT-770 #1066
        //>> DITW18.00.07 VSC DIT-770 #1066

        // <<DITW18.00.07 MVN 04/06/2016 DIT-770 #1397
        if "Document Type" = "Document Type"::"Return Order" then begin
          if ApplMgt.IsObjectLicense(5,CODEUNIT::"EMCS EDI Mgt",4) <> 0 then
            // <<DITW110.00.09 DDR 21/03/2017 NRQ#13144
            "Submission Type" := EMCSEDIMgt.GetSubmissionType(2,"Vendor DTax Group Code","Location Code");
            // >>DITW110.00.09 DDR NRQ#13144
        end;
        // >>DITW18.00.07 MVN DIT-770 #1397
        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        if xRec."Location Code" <> "Location Code" then
          UpdateRoutePlanRqstLines(FIELDCAPTION("Location Code"));
        // >>DITW18.00.07 DDR DIT-770 #1488
        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        UpdateWhseRequestLines(FIELDCAPTION("Location Code"));
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        */
        //end;


        //Unsupported feature: CodeModification on ""Shortcut Dimension 1 Code"(Field 29).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
        if xRec."Shortcut Dimension 1 Code" <> "Shortcut Dimension 1 Code" then
        // >>DITW16.00.00.43 DDR DIT-715 #860
          ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
        */
        //end;


        //Unsupported feature: CodeModification on ""Shortcut Dimension 2 Code"(Field 30).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
        if xRec."Shortcut Dimension 2 Code" <> "Shortcut Dimension 2 Code" then
        // >>DITW16.00.00.43 DDR DIT-715 #860
          ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Vendor Posting Group"(Field 31)". Please convert manually.



        //Unsupported feature: CodeModification on ""Currency Code"(Field 32).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT (CurrFieldNo IN [0,FIELDNO("Posting Date")]) OR ("Currency Code" <> xRec."Currency Code") THEN
          TESTFIELD(Status,Status::Open);
        IF (CurrFieldNo <> FIELDNO("Currency Code")) AND ("Currency Code" = xRec."Currency Code") THEN
          UpdateCurrencyFactor
        else
          IF "Currency Code" <> xRec."Currency Code" THEN BEGIN
            UpdateCurrencyFactor;
            IF PurchLinesExist THEN
              IF CONFIRM(ChangeCurrencyQst,FALSE,FIELDCAPTION("Currency Code")) THEN BEGIN
                SetHideValidationDialog(TRUE);
                RecreatePurchLines(FIELDCAPTION("Currency Code"));
                SetHideValidationDialog(FALSE);
              end else
                ERROR(Text018,FIELDCAPTION("Currency Code"));
          end else
            IF "Currency Code" <> '' THEN BEGIN
              UpdateCurrencyFactor;
              IF "Currency Factor" <> xRec."Currency Factor" THEN
                ConfirmUpdateCurrencyFactor;
            end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not (CurrFieldNo in [0,FIELDNO("Posting Date")]) or ("Currency Code" <> xRec."Currency Code") then
           //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
           //TESTFIELD(Status,Status::Open);
           TestOpenStatus;
           //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        if (CurrFieldNo <> FIELDNO("Currency Code")) and ("Currency Code" = xRec."Currency Code") then
          UpdateCurrencyFactor
        else
          if "Currency Code" <> xRec."Currency Code" then begin
            UpdateCurrencyFactor;
            if PurchLinesExist then
              //IF CONFIRM(ChangeCurrencyQst,FALSE,FIELDCAPTION("Currency Code")) THEN BEGIN  //HEI.35 commented
              //HEI.35>>
              begin
                if not GUIALLOWED then
                  Confirmed := true
                else
                  Confirmed := CONFIRM(ChangeCurrencyQst,false,FIELDCAPTION("Currency Code"));
                if Confirmed then begin
              //HEI.35<<
                SetHideValidationDialog(true);
               //<< FINXL9.00.000.01 AKH 13/01/2017
               if not recUserSetup.GET(USERID) then
                recUserSetup.INIT;
                if ReceiptLineExists() and (recUserSetup."Receive Other Pay-to Vendor") then
                  UpdatePurchLines(FIELDCAPTION("Currency Code"),CurrFieldNo <> 0)
                else
               //>> FINXL9.00.000.01 AKH 13/01/2017
                RecreatePurchLines(FIELDCAPTION("Currency Code"));
                SetHideValidationDialog(false);
              end else
                ERROR(Text018,FIELDCAPTION("Currency Code"));
            end  //HEI.35
          end else
            if "Currency Code" <> '' then begin
              UpdateCurrencyFactor;
              // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
              InitHasBeenShow(HasBeenShowText022,'',FIELDNO("Currency Code"));
              // >>DITW16.00.00.43 DDR DIT-715 #860
              if "Currency Factor" <> xRec."Currency Factor" then
                ConfirmUpdateCurrencyFactor;
            end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Currency Factor"(Field 33).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Currency Factor" <> xRec."Currency Factor" THEN
          UpdatePurchLines(FIELDCAPTION("Currency Factor"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Currency Factor" <> xRec."Currency Factor" then
          UpdatePurchLines(FIELDCAPTION("Currency Factor"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: CodeModification on ""Prices Including VAT"(Field 35).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);

        IF "Prices Including VAT" <> xRec."Prices Including VAT" THEN BEGIN
          PurchLine.SETRANGE("Document Type","Document Type");
          PurchLine.SETRANGE("Document No.","No.");
          PurchLine.SETFILTER("Direct Unit Cost",'<>%1',0);
          PurchLine.SETFILTER("VAT %",'<>%1',0);
          IF PurchLine.FIND('-') THEN BEGIN
            RecalculatePrice :=
              CONFIRM(
                STRSUBSTNO(
                  Text025 +
                  Text027,
                  FIELDCAPTION("Prices Including VAT"),PurchLine.FIELDCAPTION("Direct Unit Cost")),
                TRUE);
            PurchLine.SetPurchHeader(Rec);

            IF RecalculatePrice AND "Prices Including VAT" THEN
              PurchLine.MODIFYALL(Amount,0,TRUE);

            IF "Currency Code" = '' THEN
              Currency.InitRoundingPrecision
            else
              Currency.GET("Currency Code");

            PurchLine.findset;
            REPEAT
              PurchLine.TESTFIELD("Quantity Invoiced",0);
              PurchLine.TESTFIELD("Prepmt. Amt. Inv.",0);
              IF NOT RecalculatePrice THEN BEGIN
                PurchLine."VAT Difference" := 0;
                PurchLine.UpdateAmounts;
              end else
                IF "Prices Including VAT" THEN BEGIN
                  PurchLine."Direct Unit Cost" :=
                    ROUND(
                      PurchLine."Direct Unit Cost" * (1 + PurchLine."VAT %" / 100),
                      Currency."Unit-Amount Rounding Precision");
                  IF PurchLine.Quantity <> 0 THEN BEGIN
                    PurchLine."Line Discount Amount" :=
                      ROUND(
                        PurchLine.Quantity * PurchLine."Direct Unit Cost" * PurchLine."Line Discount %" / 100,
                        Currency."Amount Rounding Precision");
                    PurchLine.VALIDATE("Inv. Discount Amount",
                      ROUND(
                        PurchLine."Inv. Discount Amount" * (1 + PurchLine."VAT %" / 100),
                        Currency."Amount Rounding Precision"));
                  end;
                end else BEGIN
                  PurchLine."Direct Unit Cost" :=
                    ROUND(
                      PurchLine."Direct Unit Cost" / (1 + PurchLine."VAT %" / 100),
                      Currency."Unit-Amount Rounding Precision");
                  IF PurchLine.Quantity <> 0 THEN BEGIN
                    PurchLine."Line Discount Amount" :=
                      ROUND(
                        PurchLine.Quantity * PurchLine."Direct Unit Cost" * PurchLine."Line Discount %" / 100,
                        Currency."Amount Rounding Precision");
                    PurchLine.VALIDATE("Inv. Discount Amount",
                      ROUND(
                        PurchLine."Inv. Discount Amount" / (1 + PurchLine."VAT %" / 100),
                        Currency."Amount Rounding Precision"));
                  end;
                end;
              PurchLine.MODIFY;
            UNTIL PurchLine.NEXT = 0;
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159

        if "Prices Including VAT" <> xRec."Prices Including VAT" then begin
          // <<DITW15.00.00.19 DDR 07/04/2008
          PurchLine.RESET;
          // >>DITW15.00.00.19 DDR
        #4..7
          if PurchLine.FIND('-') then begin
            //>>HEI.50
            if GUIALLOWED then begin
            //<<HEI.50
        #9..14
                true);
            //>>HEI.50
            end else begin
              RecalculatePrice := true;
            end;
            //<<HEI.50
            PurchLine.SetPurchHeader(Rec);

            if RecalculatePrice and "Prices Including VAT" then
              PurchLine.MODIFYALL(Amount,0,true);

            if "Currency Code" = '' then
              Currency.InitRoundingPrecision
            else
              Currency.GET("Currency Code");
            // <<DITW15.00.00.32 DDR 08/04/2009
            SaveCurrency :=  Currency;
            // >>DITW15.00.00.32 DDR

            PurchLine.findset;
            repeat
              // <<DITW15.00.00.32 DDR 08/04/2009
              Currency :=  SaveCurrency;
              Currency.SetRoundingPrecisionDrink(PurchLine."Item Charge Type" = PurchLine."Item Charge Type"::Tax,0);
              // >>DITW15.00.00.32 DDR
              PurchLine.TESTFIELD("Quantity Invoiced",0);
              PurchLine.TESTFIELD("Prepmt. Amt. Inv.",0);
              if not RecalculatePrice then begin
                PurchLine."VAT Difference" := 0;
                PurchLine.InitOutstandingAmount;
              end else
                if "Prices Including VAT" then begin
        #35..38
                  // <<DITW15.00.00.24 DDR 29/08/2008
                  if (PurchLine."Extra Charge Type" = PurchLine."Extra Charge Type"::" ") or
                     (PurchLine."Extra Charge Type" = PurchLine."Extra Charge Type"::Amount) or
                     (PurchLine."Extra Charge Type" = PurchLine."Extra Charge Type"::"Fixed Amount")
                  then
                    PurchLine."Item Charge Value" :=
                      ROUND(
                        PurchLine."Item Charge Value" * (1 + (PurchLine."VAT %" / 100)),
                        Currency."Unit-Amount Rounding Precision");
                  // >>DITW15.00.00.24 DDR
                  if PurchLine.Quantity <> 0 then begin
        #40..47
                  end;
                end else begin
        #50..53
                  // <<DITW15.00.00.24 DDR 29/08/2008
                  if (PurchLine."Extra Charge Type" = PurchLine."Extra Charge Type"::" ") or
                     (PurchLine."Extra Charge Type" = PurchLine."Extra Charge Type"::Amount) or
                     (PurchLine."Extra Charge Type" = PurchLine."Extra Charge Type"::"Fixed Amount")
                  then
                    PurchLine."Item Charge Value" :=
                      ROUND(
                        PurchLine."Item Charge Value" / (1 + (PurchLine."VAT %" / 100)),
                        Currency."Unit-Amount Rounding Precision");
                  // >>DITW15.00.00.24 DDR
                  if PurchLine.Quantity <> 0 then begin
        #55..62
                  end;
                end;
              PurchLine.MODIFY;
              // <<DITW114.00.15 DDR 01/04/2020 NRQ#140339
              HasLineChargeIncludePrice := PurchLine."ItemCharge Incl. Price";
              // >>DITW114.00.15 DDR NRQ#140339
            until PurchLine.NEXT = 0;
            // <<DITW15.00.00.01 DDR 04/02/2008
            // <<DITW114.00.15 DDR 01/04/2020 NRQ#140339
            if RecalculatePrice and HasLineChargeIncludePrice then
            // >>DITW114.00.15 DDR NRQ#140339
              RecalcBackPurchLines();
            // >>DITW15.00.00.01 DDR
          end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Invoice Disc. Code"(Field 37).OnValidate". Please convert manually.

        //trigger  Code"(Field 37)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        MessageIfPurchLinesExist(FIELDCAPTION("Invoice Disc. Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        MessageIfPurchLinesExist(FIELDCAPTION("Invoice Disc. Code"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Purchaser Code"(Field 43).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ApprovalEntry.SETRANGE("Table ID",DATABASE::"Purchase Header");
        ApprovalEntry.SETRANGE("Document Type","Document Type");
        ApprovalEntry.SETRANGE("Document No.","No.");
        ApprovalEntry.SETFILTER(Status,'%1|%2',ApprovalEntry.Status::Created,ApprovalEntry.Status::Open);
        IF NOT ApprovalEntry.ISEMPTY THEN
          ERROR(Text042,FIELDCAPTION("Purchaser Code"));

        CreateDim(
          DATABASE::"Salesperson/Purchaser","Purchaser Code",
          DATABASE::Vendor,"Pay-to Vendor No.",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        if not ApprovalEntry.ISEMPTY then
          ERROR(Text042,FIELDCAPTION("Purchaser Code"));

        //<<DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362
        CreateDim(
          DATABASE::"Salesperson/Purchaser","Purchaser Code",
          //DATABASE::Vendor,"Pay-to Vendor No.",
          DATABASE::Vendor,GetVendNoCalcDim(),
          // >>DITW16.00.00.42 DDR DIT-715 #522
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(2,"Contract Type"),GetContractNo(),
          //<<DITW110.00.10 MSF 15/06/2017 NRQ#13382
          DATABASE::Customer,"Linked Customer No.");
          //>>DITW110.00.10 MSF 15/06/2017 NRQ#13382
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
        //>>DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362
        //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        if xRec."Purchaser Code" <> "Purchaser Code" then
        UpdateRoutePlanRqstLines(FIELDCAPTION("Purchaser Code"));
        //<< DITW18.00.07 VSC DIT-770 #1984 - #1981-> DIT-770 #1488
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-to Doc. No."(Field 53).OnLookup". Please convert manually.

        //trigger  No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Bal. Account No.",'');
        VendLedgEntry.SETCURRENTKEY("Vendor No.",Open,Positive,"Due Date");
        VendLedgEntry.SETRANGE("Vendor No.","Pay-to Vendor No.");
        VendLedgEntry.SETRANGE(Open,TRUE);
        IF "Applies-to Doc. No." <> '' THEN BEGIN
          VendLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          VendLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          IF VendLedgEntry.FINDFIRST THEN;
          VendLedgEntry.SETRANGE("Document Type");
          VendLedgEntry.SETRANGE("Document No.");
        end else
          IF "Applies-to Doc. Type" <> 0 THEN BEGIN
            VendLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
            IF VendLedgEntry.FINDFIRST THEN;
            VendLedgEntry.SETRANGE("Document Type");
          end else
            IF Amount <> 0 THEN BEGIN
              VendLedgEntry.SETRANGE(Positive,Amount < 0);
              IF VendLedgEntry.FINDFIRST THEN;
              VendLedgEntry.SETRANGE(Positive);
            end;
        ApplyVendEntries.SetPurch(Rec,VendLedgEntry,PurchHeader.FIELDNO("Applies-to Doc. No."));
        ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
        ApplyVendEntries.SETRECORD(VendLedgEntry);
        ApplyVendEntries.LOOKUPMODE(TRUE);
        IF ApplyVendEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
          ApplyVendEntries.GetVendLedgEntry(VendLedgEntry);
          GenJnlApply.CheckAgainstApplnCurrency(
            "Currency Code",VendLedgEntry."Currency Code",GenJnlLine."Account Type"::Vendor,TRUE);
          "Applies-to Doc. Type" := VendLedgEntry."Document Type";
          "Applies-to Doc. No." := VendLedgEntry."Document No.";
        end;
        CLEAR(ApplyVendEntries);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Bal. Account No.",'');
        // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
        TESTFIELD("Deposit Bal. Account No.",'');
        // >>DITW16.00.00.42 DDR DIT-715 #370
        VendLedgEntry.SETCURRENTKEY("Vendor No.",Open,Positive,"Due Date");
        VendLedgEntry.SETRANGE("Vendor No.","Pay-to Vendor No.");
        VendLedgEntry.SETRANGE(Open,true);
        if "Applies-to Doc. No." <> '' then begin
          VendLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          VendLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          if VendLedgEntry.FINDFIRST then;
          VendLedgEntry.SETRANGE("Document Type");
          VendLedgEntry.SETRANGE("Document No.");
        end else
          if "Applies-to Doc. Type" <> 0 then begin
            VendLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
            if VendLedgEntry.FINDFIRST then;
            VendLedgEntry.SETRANGE("Document Type");
          end else
            if Amount <> 0 then begin
              VendLedgEntry.SETRANGE(Positive,Amount < 0);
              if VendLedgEntry.FINDFIRST then;
              VendLedgEntry.SETRANGE(Positive);
            end;

        //<<DITW17.10.03 TEC1 05/02/2014 DIT-770 #340
        VendLedgEntry.SETRANGE("Vendor Posting Group","Vendor Posting Group");
        //>>DITW17.10.03 TEC1 DIT-770 #340

        #22..24
        ApplyVendEntries.LOOKUPMODE(true);
        if ApplyVendEntries.RUNMODAL = ACTION::LookupOK then begin
          ApplyVendEntries.GetVendLedgEntry(VendLedgEntry);
          GenJnlApply.CheckAgainstApplnCurrency(
            "Currency Code",VendLedgEntry."Currency Code",GenJnlLine."Account Type"::Vendor,true);
          "Applies-to Doc. Type" := VendLedgEntry."Document Type";
          "Applies-to Doc. No." := VendLedgEntry."Document No.";
        end;
        CLEAR(ApplyVendEntries);
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-to Doc. No."(Field 53).OnValidate". Please convert manually.

        //trigger  No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Applies-to Doc. No." <> '' THEN
          TESTFIELD("Bal. Account No.",'');

        IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND (xRec."Applies-to Doc. No." <> '') AND
           ("Applies-to Doc. No." <> '')
        THEN BEGIN
          SetAmountToApply("Applies-to Doc. No.","Buy-from Vendor No.");
          SetAmountToApply(xRec."Applies-to Doc. No.","Buy-from Vendor No.");
        end else
          IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND (xRec."Applies-to Doc. No." = '') THEN
            SetAmountToApply("Applies-to Doc. No.","Buy-from Vendor No.")
          else
            IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND ("Applies-to Doc. No." = '') THEN
              SetAmountToApply(xRec."Applies-to Doc. No.","Buy-from Vendor No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Applies-to Doc. No." <> '' then begin
          TESTFIELD("Bal. Account No.",'');
          // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
          TESTFIELD("Deposit Bal. Account No.",'');
          // >>DITW16.00.00.42 DDR DIT-715 #370
        end;

        if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." <> '') and
           ("Applies-to Doc. No." <> '')
        then begin
          SetAmountToApply("Applies-to Doc. No.","Buy-from Vendor No.");
          SetAmountToApply(xRec."Applies-to Doc. No.","Buy-from Vendor No.");
        end else
          if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." = '') then
            SetAmountToApply("Applies-to Doc. No.","Buy-from Vendor No.")
          else
            if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and ("Applies-to Doc. No." = '') then
              SetAmountToApply(xRec."Applies-to Doc. No.","Buy-from Vendor No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. Account No."(Field 55).OnValidate". Please convert manually.

        //trigger  Account No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bal. Account No." <> '' THEN
          CASE "Bal. Account Type" OF
            "Bal. Account Type"::"G/L Account":
              BEGIN
                GLAcc.GET("Bal. Account No.");
                GLAcc.CheckGLAcc;
                GLAcc.TESTFIELD("Direct Posting",TRUE);
              end;
            "Bal. Account Type"::"Bank Account":
              BEGIN
                BankAcc.GET("Bal. Account No.");
                BankAcc.TESTFIELD(Blocked,FALSE);
                BankAcc.TESTFIELD("Currency Code","Currency Code");
              end;
          end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bal. Account No." <> '' then
          case "Bal. Account Type" of
            "Bal. Account Type"::"G/L Account":
              begin
                GLAcc.GET("Bal. Account No.");
                GLAcc.CheckGLAcc;
                GLAcc.TESTFIELD("Direct Posting",true);
              end;
            "Bal. Account Type"::"Bank Account":
              begin
                BankAcc.GET("Bal. Account No.");
                BankAcc.TESTFIELD(Blocked,false);
                BankAcc.TESTFIELD("Currency Code","Currency Code");
              end;
          end;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Vendor Shipment No."(Field 67)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        if "Multiple Order Route" then
          if CurrFieldNo = FIELDNO("Vendor Shipment No.") then
            ERROR(STRSUBSTNO(Text2014061,"Document Type","No."));
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Vendor Invoice No."(Field 68)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        // var
        //     lrecVendLedgEntry : Record "Vendor Ledger Entry";
        //     lrecPurchaseH : Record "Purchase Header";
        //     PurchaseHeaderAdditional : Record "Purchase Header Additional FND";
        //begin
        /*
        //<<FINXL7.00.001 RBE 06/08/2013
        // Check External Document number
        if recFINXLSetup.READPERMISSION then begin
          if "Document Type" in ["Document Type"::Invoice,"Document Type"::"Credit Memo"] then
            if "Vendor Invoice No." <> '' then begin
              lrecVendLedgEntry.RESET;
              lrecVendLedgEntry.SETCURRENTKEY("External Document No.");
              case "Document Type" of
                "Document Type"::Invoice: lrecVendLedgEntry.SETRANGE("Document Type",lrecVendLedgEntry."Document Type"::Invoice);
                "Document Type"::"Credit Memo": lrecVendLedgEntry.SETRANGE("Document Type",lrecVendLedgEntry."Document Type"::"Credit Memo");
              end;
              lrecVendLedgEntry.SETRANGE("External Document No.","Vendor Invoice No.");
              lrecVendLedgEntry.SETRANGE("Vendor No.","Pay-to Vendor No.");
              if not lrecVendLedgEntry.ISEMPTY() then
                ERROR(Text2036301,"Document Type","Vendor Invoice No.");

              lrecPurchaseH.SETRANGE("Document Type","Document Type");
              lrecPurchaseH.SETFILTER("No.",'<>%1',"No.");
              lrecPurchaseH.SETRANGE("Pay-to Vendor No.","Pay-to Vendor No.");
              lrecPurchaseH.SETRANGE("Vendor Invoice No.","Vendor Invoice No.");
              if not lrecPurchaseH.ISEMPTY() then
                ERROR(Text2036301,"Document Type","Vendor Invoice No.");
            end;
        end;
        //>>FINXL7.00.001 RBE 06/08/2013

        // <<DITW110.00.11 ASA 08/12/2017 ALE 09/01/2018 DDR 16/01/2018 NRQ#34181
        PurchaseHeaderAdditional.GET("Document Type","No.");
        if ("Vendor Invoice No." <> '') and (PurchaseHeaderAdditional."Deposit Vendor Invoice No." = '') then
        PurchaseHeaderAdditional."Deposit Vendor Invoice No.":=
             FormatDepositVendorInvoiceCrMemo("Vendor Invoice No.",FIELDCAPTION("Vendor Invoice No."),
             PurchaseHeaderAdditional.FIELDCAPTION("Deposit Vendor Invoice No."),(CurrFieldNo <> 0));
             PurchaseHeaderAdditional.MODIFY;
        // >>DITW110.00.11 ASA-ALE NRQ#34181
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Vendor Cr. Memo No."(Field 69)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        // var
        //     PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        //begin
        /*
        // <<DITW110.00.11 ASA 08/12/2017 ALE 09/01/2018 DDR 16/01/2018 NRQ#34181-NRQ#168174 MSF 07/01/2021
        PurchaseHeaderAdditional.GET("Document Type","No.");
        if ("Vendor Cr. Memo No." <> '') and (PurchaseHeaderAdditional."Deposit Vendor Cr. Memo No."='') then
          //<< NRQ182941 HGUI 31/05/2021
          PurchaseHeaderAdditional."Deposit Vendor Cr. Memo No.":=
          //>> NRQ182941 HGUI 31/05/2021
              FormatDepositVendorInvoiceCrMemo("Vendor Cr. Memo No.",FIELDCAPTION("Vendor Cr. Memo No."),
              PurchaseHeaderAdditional.FIELDCAPTION("Deposit Vendor Cr. Memo No."),(CurrFieldNo <> 0));
              PurchaseHeaderAdditional.MODIFY;
        // >>DITW110.00.11 ASA-ALE NRQ#34181-NRQ#168174 MSF 07/01/2021
        */
        //end;


        //Unsupported feature: CodeModification on ""Sell-to Customer No."(Field 72).OnValidate". Please convert manually.

        //trigger "(Field 72)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Document Type" = "Document Type"::Order) AND
           (xRec."Sell-to Customer No." <> "Sell-to Customer No.")
        THEN BEGIN
          PurchLine.SETRANGE("Document Type",PurchLine."Document Type"::Order);
          PurchLine.SETRANGE("Document No.","No.");
          PurchLine.SETFILTER("Sales Order Line No.",'<>0');
          IF NOT PurchLine.ISEMPTY THEN
            ERROR(
              YouCannotChangeFieldErr,
              FIELDCAPTION("Sell-to Customer No."));

          PurchLine.SETRANGE("Sales Order Line No.");
          PurchLine.SETFILTER("Special Order Sales Line No.",'<>0');
          IF NOT PurchLine.ISEMPTY THEN
            ERROR(
              YouCannotChangeFieldErr,
              FIELDCAPTION("Sell-to Customer No."));
        end;

        IF "Sell-to Customer No." = '' THEN
          VALIDATE("Location Code",UserSetupMgt.GetLocation(1,'',"Responsibility Center"))
        else
          VALIDATE("Ship-to Code",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Document Type" = "Document Type"::Order) and
           (xRec."Sell-to Customer No." <> "Sell-to Customer No.")
        then begin
        #4..6
          if not PurchLine.ISEMPTY then
        #8..13
          if not PurchLine.ISEMPTY then
        #15..17
        end;

        if "Sell-to Customer No." = '' then
          VALIDATE("Location Code",UserSetupMgt.GetLocation(1,'',"Responsibility Center"))
        else
          VALIDATE("Ship-to Code",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Bus. Posting Group"(Field 74).OnValidate". Please convert manually.

        //trigger  Bus();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        IF (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") AND
           (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group")
        THEN BEGIN
          IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
            "VAT Bus. Posting Group" := GenBusPostingGrp."Def. VAT Bus. Posting Group";
          RecreatePurchLines(FIELDCAPTION("Gen. Bus. Posting Group"));
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        if (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and
           (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group")
        then begin
          if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") then
            "VAT Bus. Posting Group" := GenBusPostingGrp."Def. VAT Bus. Posting Group";
          RecreatePurchLines(FIELDCAPTION("Gen. Bus. Posting Group"));
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Transport Method"(Field 77).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdatePurchLines(FIELDCAPTION("Transport Method"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdatePurchLines(FIELDCAPTION("Transport Method"),CurrFieldNo <> 0);

        // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
        CALCFIELDS("Transport Mode");
        // >>DITW16.00.00.40 DDR DIT-715 #187
        */
        //end;


        //Unsupported feature: CodeModification on ""Buy-from Vendor Name"(Field 79).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Buy-from Vendor No.",Vendor.GetVendorNo("Buy-from Vendor Name"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
        //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
        if "Sundry Vendor" and
          (xRec."Buy-from Vendor Name" <> "Buy-from Vendor Name")
        then
          UpdateSundryFields(FIELDCAPTION("Buy-from Vendor Name"));
        //>> DITW18.00.07 AKH DIT-770 #1804

        VALIDATE("Buy-from Vendor No.",Vendor.GetVendorNo("Buy-from Vendor Name"));
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Buy-from Vendor Name 2"(Field 80)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
        //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
        if "Sundry Vendor" and
          (xRec."Buy-from Vendor Name 2" <> "Buy-from Vendor Name 2")
        then
          UpdateSundryFields(FIELDCAPTION("Buy-from Vendor Name 2"));
        //>> DITW18.00.07 AKH DIT-770 #1804
        */
        //end;


        //Unsupported feature: CodeModification on ""Buy-from Address"(Field 81).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdatePayToAddressFromBuyFromAddress(FIELDNO("Pay-to Address"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
        //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
        if "Sundry Vendor" and
          (xRec."Buy-from Address" <> "Buy-from Address")
        then
          UpdateSundryFields(FIELDCAPTION("Buy-from Address"));
        //>> DITW18.00.07 AKH DIT-770 #1804

        UpdatePayToAddressFromBuyFromAddress(FIELDNO("Pay-to Address"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Buy-from Address 2"(Field 82).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdatePayToAddressFromBuyFromAddress(FIELDNO("Pay-to Address 2"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
        //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
        if "Sundry Vendor" and
          (xRec."Buy-from Address 2" <> "Buy-from Address 2")
        then
          UpdateSundryFields(FIELDCAPTION("Buy-from Address 2"));
        //>> DITW18.00.07 AKH DIT-770 #1804

        UpdatePayToAddressFromBuyFromAddress(FIELDNO("Pay-to Address 2"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Buy-from City"(Field 83).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Buy-from City","Buy-from Post Code","Buy-from County","Buy-from Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        UpdatePayToAddressFromBuyFromAddress(FIELDNO("Pay-to City"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Buy-from City","Buy-from Post Code","Buy-from County","Buy-from Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);

        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
        //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
        if "Sundry Vendor" and
          (xRec."Buy-from City" <> "Buy-from City")
        then
          UpdateSundryFields(FIELDCAPTION("Buy-from City"));
        //>> DITW18.00.07 AKH DIT-770 #1804

        UpdatePayToAddressFromBuyFromAddress(FIELDNO("Pay-to City"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Buy-from Contact"(Field 84).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        LookupContact("Buy-from Vendor No.","Buy-from Contact No.",Contact);
        IF PAGE.RUNMODAL(0,Contact) = ACTION::LookupOK THEN
          VALIDATE("Buy-from Contact No.",Contact."No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        LookupContact("Buy-from Vendor No.","Buy-from Contact No.",Contact);
        if PAGE.RUNMODAL(0,Contact) = ACTION::LookupOK then
          VALIDATE("Buy-from Contact No.",Contact."No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Pay-to Post Code"(Field 85).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Pay-to City","Pay-to Post Code","Pay-to County","Pay-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Pay-to City","Pay-to Post Code","Pay-to County","Pay-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Buy-from Post Code"(Field 88).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Buy-from City","Buy-from Post Code","Buy-from County","Buy-from Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        UpdatePayToAddressFromBuyFromAddress(FIELDNO("Pay-to Post Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Buy-from City","Buy-from Post Code","Buy-from County","Buy-from Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);

        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
        //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
        if "Sundry Vendor" and
          (xRec."Buy-from Post Code" <> "Buy-from Post Code")
        then
          UpdateSundryFields(FIELDCAPTION("Buy-from Post Code"));
        //>> DITW18.00.07 AKH DIT-770 #1804

        UpdatePayToAddressFromBuyFromAddress(FIELDNO("Pay-to Post Code"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Ship-to Post Code"(Field 91).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Ship-to City","Ship-to Post Code","Ship-to County","Ship-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Ship-to City","Ship-to Post Code","Ship-to County","Ship-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        //HEI.46>>
            if ("SRM Order No." = '') and (("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::"Return Order")) then begin
            PurchHdrArch.RESET;
            PurchHdrArch.SETRANGE(PurchHdrArch."Document Type","Document Type");
            PurchHdrArch.SETRANGE(PurchHdrArch."No.","No.");
            if PurchHdrArch.FINDFIRST then begin
              if "Purch. Reason Code" = '' then
                  ERROR(ReasonCodeErr);
            end;
        end;
        //HEI.46<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Order Address Code"(Field 95).OnValidate". Please convert manually.

        //trigger (Variable: Vend2)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Order Address Code"(Field 95).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Order Address Code" <> '' THEN BEGIN
          OrderAddr.GET("Buy-from Vendor No.","Order Address Code");
          "Buy-from Vendor Name" := OrderAddr.Name;
          "Buy-from Vendor Name 2" := OrderAddr."Name 2";
        #5..9
          "Buy-from County" := OrderAddr.County;
          "Buy-from Country/Region Code" := OrderAddr."Country/Region Code";

          IF IsCreditDocType THEN BEGIN
            SetShipToAddress(
              OrderAddr.Name,OrderAddr."Name 2",OrderAddr.Address,OrderAddr."Address 2",
              OrderAddr.City,OrderAddr."Post Code",OrderAddr.County,OrderAddr."Country/Region Code");
            "Ship-to Contact" := OrderAddr.Contact;
          end
        end else BEGIN
          GetVend("Buy-from Vendor No.");
          "Buy-from Vendor Name" := Vend.Name;
          "Buy-from Vendor Name 2" := Vend."Name 2";
          CopyPayToVendorAddressFieldsFromVendor(Vend);

          IF IsCreditDocType THEN BEGIN
            "Ship-to Name" := Vend.Name;
            "Ship-to Name 2" := Vend."Name 2";
            CopyShipToVendorAddressFieldsFromVendor(Vend);
            "Ship-to Contact" := Vend.Contact;
            "Shipment Method Code" := Vend."Shipment Method Code";
            IF Vend."Location Code" <> '' THEN
              VALIDATE("Location Code",Vend."Location Code");
          end
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968
        if ("Document Type" = "Document Type"::Order) and
           (xRec."Order Address Code" <> "Order Address Code")
        then begin
          //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968 -> #1230
          fctFillDeliverySequence;
          //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968 -> #1230
          //>>DITW18.00.06 MSF 06/07/2015 DIT-770 #1212 #1213 #1214
          //<<DITW18.00.06 MSF 06/07/2015 DIT-770 #1212 #1213 #1214
          //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
          fctFillDeliveryTimes("Buy-from Vendor No.","Order Address Code","Expected Receipt Date");
          //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        end;
        //>> DITW18.00.07 VSC DIT-770 #1968

        if "Order Address Code" <> '' then begin
        #2..12
          // <<DITW15.00.00.25 DDR 21/10/2008
          if OrderAddr."Vendor DTax Group Code" <> '' then
            "Vendor DTax Group Code" := OrderAddr."Vendor DTax Group Code";
          // >>DITW15.00.00.25 DDR
          // <<DITW15.00.00.28 DDR 24/11/2008
          if  OrderAddr."Tax Registration No." <> '' then
            "Vendor Tax Registration No." := OrderAddr."Tax Registration No.";
          // <<DITW16.00.00.40 DDR 24/01/2012 DIT-715 #203
          //IF OrderAddr."Fiscal Representative No." <> '' THEN
          "Fiscal Representative No." := OrderAddr."Fiscal Representative No.";
          // >>DITW16.00.00.40 DDR DIT-715 #203
          // >>DITW15.00.00.28 DDR
          // <<DITW15.00.00.38 DDR 13/09/2010 #1217
          if OrderAddr."Tax Warehouse Reference" <> '' then
            "Vendor Tax Warehouse Ref." := OrderAddr."Tax Warehouse Reference";
          // >>DITW15.00.00.38 DDR
          // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
          if OrderAddr."Tax Office Code" <> '' then
            "Tax Office Code" := OrderAddr."Tax Office Code";
          // <<DITW15.00.00.38 DDR #1217 (DIT711 137)
          // <<DITW15.00.00.39 DDR 06/07/2011 #1353
          if FORMAT(OrderAddr."Journey Time") <> '' then
            "Journey Time" := OrderAddr."Journey Time";
          // >>DITW15.00.00.39 DDR #1353

          //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968 -> DIT-770 #154
          //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968 -> DIT-770 #298
          //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1968
          if OrderAddr."Truck Zone" <> OrderAddr."Truck Zone"::" " then
            "Truck Zone":= OrderAddr."Truck Zone";
          if OrderAddr."Require 2 Drivers" then
            "Require 2 Drivers" := OrderAddr."Require 2 Drivers";
          //>> DITW18.00.07 VSC DIT-770 #1968 -> DIT-770 #298
          //<< DITW18.00.07 VSC DIT-770 #1968 -> DIT-770 #154

          // <<DITW15.00.00.38 DDR 11/08/2010 #1217
          "Transaction Type" := OrderAddr."Transaction Type";
          "Transport Method" := OrderAddr."Transport Method";
          "Transaction Specification" := OrderAddr."Transaction Specification";
          "Entry Point" := OrderAddr."Entry Point";
          Area := OrderAddr.Area;
          // >>DITW15.00.00.38 DDR
          //<< DITW18.00.07 AKH 10/05/2016 DIT-770 #1346
          // <<DITW19.00.08 DDR 12/08/2016 BL#10314
          if (OrderAddr."Vendor Delivery Type" <> '') and
             (("Document Type" in ["Document Type"::Order,"Document Type"::"Return Order"]) or
              PurchSetup."Receipt on Invoice" or PurchSetup."Return Shipment on Credit Memo")
          then
          // >>DITW19.00.08 DDR BL#10314
            "Vendor Delivery Type" := OrderAddr."Vendor Delivery Type";
          //>> DITW18.00.07 AKH DIT-770 #1346

          if IsCreditDocType then begin
        #14..17
          end
        end else begin
        #20..24
          // <<DITW15.00.00.25 DDR 21/10/2008 - DITW15.00.00.38 DDR 23/02/2011 #1286
          GLSetup.GET;
          //<< DITW18.00.07 AKH 20/04/2016 DIT-770 #1941
          //IF (GLSetup."Sell-to/Bill-to DTax Gr. Calc." = GLSetup."Sell-to/Bill-to DTax Gr. Calc."::"Bill-to/Pay-to No.") AND
          if IsVendCalcTaxes(Vend,GLSetup."Sell-to/Bill-to DTax Gr. Calc."::"Bill-to/Pay-to No.") and
          //>> DITW18.00.07 AKH DIT-770 #1941
            ("Buy-from Vendor No." <> "Pay-to Vendor No.") and ("Pay-to Vendor No." <> '')
          then
            Vend2.GET("Pay-to Vendor No.")
          else
            Vend2 := Vend;
          "Vendor DTax Group Code" := Vend2."Vendor DTax Group Code";
          // >>DITW15.00.00.38 DDR #1286
          //<< DITW18.00.07 AKH 20/04/2016 DIT-770 #1941
          if ("Buy-from Vendor No." <> "Pay-to Vendor No.") and ("Pay-to Vendor No." <> '') and
             IsVendCalcPrices(Vend,PurchSetup."Pay-to/Buy-from Prices Calc."::"Pay-to")
          then
            Vend3.GET("Pay-to Vendor No.")
          else
            Vend3 := Vend;
          "Vendor DDeposit Group Code" := Vend3."Vendor DDeposit Group Code";
          //>> DITW18.00.07 AKH DIT-770 #1941
          // <<DITW15.00.00.38 DDR 12/08/2010 #1217
          Distance := Vend.Distance;
          // >>DITW15.00.00.38 DDR
          // <<DITW15.00.00.28 DDR 24/11/2008
          "Vendor Tax Registration No." := Vend."Tax Registration No.";
          "Fiscal Representative No." := Vend."Fiscal Representative No.";
          // >>DITW15.00.00.28 DDR
          // <<DITW15.00.00.38 DDR 13/09/2010 #1217
          "Vendor Tax Warehouse Ref." := Vend."Tax Warehouse Reference";
          // >>DITW15.00.00.38 DDR
          // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
          "Tax Office Code" := Vend."Tax Office Code";
          // <<DITW15.00.00.38 DDR #1217 (DIT711 137)
          // <<DITW15.00.00.39 DDR 06/07/2011 #1353
          "Journey Time" := Vend."Journey Time";
          // >>DITW15.00.00.39 DDR #1353
          // <<DITW15.00.00.38 DDR 11/08/2010 #1217
          "Transaction Type" := Vend."Transaction Type";
          "Transport Method" := Vend."Transport Method";
          "Transaction Specification" := Vend."Transaction Specification";
          "Entry Point" := Vend."Entry Point";
          Area := Vend.Area;
          // >>DITW15.00.00.38 DDR

          if IsCreditDocType then begin
        #26..30
            if Vend."Location Code" <> '' then
              VALIDATE("Location Code",Vend."Location Code");
          end
        end;
        // <<DITW15.00.00.28 DDR 24/11/2008
        VALIDATE("Fiscal Representative No.");
        // >>DITW15.00.00.28 DDR
        // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
        if (xRec."Order Address Code" <> "Order Address Code") and not HasRecreatePurchaseLines then begin
        // >>DITW16.00.00.43 DDR DIT-715 #691
        // <<DITW15.00.00.25 DDR 21/10/2008
         if xRec."Vendor DTax Group Code" <> "Vendor DTax Group Code" then begin
            // <<DITW17.10.05 MSF 17/07/2014 DIT-770 #698
            UpdatePurchLines(FIELDCAPTION("Vendor DTax Group Code"),CurrFieldNo <> 0);
            // >>DITW17.10.05 MSF DIT-770 #698
            // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
            RecreateChargePurchaseLines(FIELDCAPTION("Vendor DTax Group Code"));
            // >>DITW16.00.00.43 DDR DIT-715 #691
         end ;
          if xRec."Vendor DDeposit Group Code" <> "Vendor DDeposit Group Code" then
            // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
            RecreateChargePurchaseLines(FIELDCAPTION("Vendor DDeposit Group Code"))
            // >>DITW16.00.00.43 DDR DIT-715 #691
        // >>DITW15.00.00.25 DDR
        end;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Document Date"(Field 99).OnValidate". Please convert manually.

        //trigger (Variable: SkipJobCurrFactorUpdate)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Document Date"(Field 99).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."Document Date" <> "Document Date" THEN
          UpdateDocumentDate := TRUE;
        VALIDATE("Payment Terms Code");
        VALIDATE("Prepmt. Payment Terms Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Document Date" <> "Document Date" then
          UpdateDocumentDate := true;
        VALIDATE("Payment Terms Code");
        // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
        VALIDATE("Deposit Payment Terms Code");
        // >>DITW16.00.00.42 DDR DIT-715 #370
        VALIDATE("Prepmt. Payment Terms Code");

        //<<MANXL7.00.001 WSA 11/07/2014 #87
        if recMANXLSetup.READPERMISSION then
        //>>MANXL7.00.001 WSA 11/07/2014 #87
          //<<MANXL7.00.001 DAT 05/03/2014 #17
          if (xRec."Document Date" <> "Document Date") and ("Document Type" = "Document Type"::"Blanket Order") then begin
            if ("Document Date" > "Valid Until") and ("Valid Until" <> 0D) then
              ERROR(err2036301,FIELDCAPTION("Document Date"),"Document Date",FIELDCAPTION("Valid Until"),"Valid Until");
            RecreatePurchLines(FIELDCAPTION("Document Date"));
          end;
          //>>MANXL7.00.001 DAT 05/03/2014 #17

        //<<HEI.37 - Added Code to calculate Currency Factor when changing the Document Date instead of changing the Posting Date
        if ("Document Type" in ["Document Type"::Invoice,"Document Type"::"Credit Memo"]) and
           not ("Posting Date" = xRec."Posting Date")
        then
          PriceMessageIfPurchLinesExist(FIELDCAPTION("Posting Date"));

        if "Currency Code" <> '' then begin
          UpdateCurrencyFactor;
          // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
          InitHasBeenShow(HasBeenShowText022,'',FIELDNO("Document Date"));
          // >>DITW16.00.00.43 DDR DIT-715 #860
          if "Currency Factor" <> xRec."Currency Factor" then
            SkipJobCurrFactorUpdate := not ConfirmUpdateCurrencyFactor;
        end;
        //>>HEI.37
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Payment Method Code"(Field 104).OnValidate". Please convert manually.

        //trigger (Variable: VendorBankAccount)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Method Code"(Field 104).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PaymentMethod.INIT;
        IF "Payment Method Code" <> '' THEN
          PaymentMethod.GET("Payment Method Code");
        "Bal. Account Type" := PaymentMethod."Bal. Account Type";
        "Bal. Account No." := PaymentMethod."Bal. Account No.";
        IF "Bal. Account No." <> '' THEN BEGIN
          TESTFIELD("Applies-to Doc. No.",'');
          TESTFIELD("Applies-to ID",'');
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PaymentMethod.INIT;
        if "Payment Method Code" <> '' then
        #3..5
        if "Bal. Account No." <> '' then begin
          TESTFIELD("Applies-to Doc. No.",'');
          TESTFIELD("Applies-to ID",'');
        end;

        //HEI.07 FDD-PTPGAP007 IBM PATHAA02>>
        if PaymentMethod."Mandatory Bank details" then begin
          VendorBankAccount.RESET;
          VendorBankAccount.SETRANGE("Vendor No.","Buy-from Vendor No.");
          if VendorBankAccount.ISEMPTY then
           ERROR(Text50000)
          // HEI.17>>
          else begin
           VendorBankAccount.SETRANGE(Code,"Vendor Bank Account");
           if VendorBankAccount.FINDFIRST then
             HeinekenGlobal.ValidateVendBankAccFields("Buy-from Vendor No.","Vendor Bank Account");
          end;
          // HEI.17<<
        end;
        //HEI.07 FDD-PTPGAP007 IBM PATHAA02<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Posting No. Series"(Field 108).OnLookup". Please convert manually.

        //trigger  Series"(Field 108)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WITH PurchHeader DO BEGIN
          PurchHeader := Rec;
          PurchSetup.GET;
          TestNoSeries;
          IF NoSeriesMgt.LookupSeries(GetPostingNoSeriesCode,"Posting No. Series") THEN
            VALIDATE("Posting No. Series");
          Rec := PurchHeader;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        with PurchHeader do begin
        #2..4
          if NoSeriesMgt.LookupSeries(GetPostingNoSeriesCode,"Posting No. Series") then
            VALIDATE("Posting No. Series");
          Rec := PurchHeader;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Posting No. Series"(Field 108).OnValidate". Please convert manually.

        //trigger  Series"(Field 108)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Posting No. Series" <> '' THEN BEGIN
          PurchSetup.GET;
          TestNoSeries;
          NoSeriesMgt.TestSeries(GetPostingNoSeriesCode,"Posting No. Series");
        end;
        TESTFIELD("Posting No.",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Posting No. Series" <> '' then begin
        #2..4
        end;
        TESTFIELD("Posting No.",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""Receiving No. Series"(Field 109).OnLookup". Please convert manually.

        //trigger  Series"(Field 109)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WITH PurchHeader DO BEGIN
          PurchHeader := Rec;
          PurchSetup.GET;
          PurchSetup.TESTFIELD("Posted Receipt Nos.");
          IF NoSeriesMgt.LookupSeries(PurchSetup."Posted Receipt Nos.","Receiving No. Series") THEN
            VALIDATE("Receiving No. Series");
          Rec := PurchHeader;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        with PurchHeader do begin
        #2..4
          if NoSeriesMgt.LookupSeries(PurchSetup."Posted Receipt Nos.","Receiving No. Series") then
            VALIDATE("Receiving No. Series");
          Rec := PurchHeader;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Receiving No. Series"(Field 109).OnValidate". Please convert manually.

        //trigger  Series"(Field 109)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Receiving No. Series" <> '' THEN BEGIN
          PurchSetup.GET;
          PurchSetup.TESTFIELD("Posted Receipt Nos.");
          NoSeriesMgt.TestSeries(PurchSetup."Posted Receipt Nos.","Receiving No. Series");
        end;
        TESTFIELD("Receiving No.",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Receiving No. Series" <> '' then begin
        #2..4
        end;
        TESTFIELD("Receiving No.",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""Tax Area Code"(Field 114).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        MessageIfPurchLinesExist(FIELDCAPTION("Tax Area Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        MessageIfPurchLinesExist(FIELDCAPTION("Tax Area Code"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Tax Liable"(Field 115).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        MessageIfPurchLinesExist(FIELDCAPTION("Tax Liable"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        MessageIfPurchLinesExist(FIELDCAPTION("Tax Liable"));
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT Bus. Posting Group"(Field 116).OnValidate". Please convert manually.

        //trigger  Posting Group"(Field 116)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        IF (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") AND
           (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")
        THEN
          RecreatePurchLines(FIELDCAPTION("VAT Bus. Posting Group"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        //<< FINXL9.00.000.01 AKH 13/01/2017
        if not recUserSetup.GET(USERID) then
          recUserSetup.INIT;
        //>> FINXL9.00.000.01 AKH 13/01/2017
        if (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and
           (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")
        then
          //<< FINXL9.00.000.01 AKH 13/01/2017
          /// DITW17.00.02 AT 04/12/2013 DIT-770 #150
          if ReceiptLineExists() and (recUserSetup."Change VAT Bus Group on Inv") then
            UpdatePurchLines(FIELDCAPTION("VAT Bus. Posting Group"),CurrFieldNo <> 0)
          else
          //>> FINXL9.00.000.01 AKH 13/01/2017
          RecreatePurchLines(FIELDCAPTION("VAT Bus. Posting Group"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-to ID"(Field 118).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Applies-to ID" <> '' THEN
          TESTFIELD("Bal. Account No.",'');
        IF ("Applies-to ID" <> xRec."Applies-to ID") AND (xRec."Applies-to ID" <> '') THEN BEGIN
          VendLedgEntry.SETCURRENTKEY("Vendor No.",Open);
          VendLedgEntry.SETRANGE("Vendor No.","Pay-to Vendor No.");
          VendLedgEntry.SETRANGE(Open,TRUE);
          VendLedgEntry.SETRANGE("Applies-to ID",xRec."Applies-to ID");
          IF VendLedgEntry.FINDFIRST THEN
            VendEntrySetApplID.SetApplId(VendLedgEntry,TempVendLedgEntry,'');
          VendLedgEntry.RESET;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Applies-to ID" <> '' then begin
          TESTFIELD("Bal. Account No.",'');
          // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
          TESTFIELD("Deposit Bal. Account No.",'');
          // >>DITW16.00.00.42 DDR DIT-715 #370
        end;
        if ("Applies-to ID" <> xRec."Applies-to ID") and (xRec."Applies-to ID" <> '') then begin
          VendLedgEntry.SETCURRENTKEY("Vendor No.",Open);
          VendLedgEntry.SETRANGE("Vendor No.","Pay-to Vendor No.");
          VendLedgEntry.SETRANGE(Open,true);
          VendLedgEntry.SETRANGE("Applies-to ID",xRec."Applies-to ID");
          if VendLedgEntry.FINDFIRST then
            VendEntrySetApplID.SetApplId(VendLedgEntry,TempVendLedgEntry,'');
          VendLedgEntry.RESET;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT Base Discount %"(Field 119).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GLSetup.GET;
        IF "VAT Base Discount %" > GLSetup."VAT Tolerance %" THEN BEGIN
          IF HideValidationDialog THEN
            Confirmed := TRUE
          else
            Confirmed :=
              CONFIRM(
                Text007 +
                Text008,FALSE,
                FIELDCAPTION("VAT Base Discount %"),
                GLSetup.FIELDCAPTION("VAT Tolerance %"),
                GLSetup.TABLECAPTION);
          IF NOT Confirmed THEN
            "VAT Base Discount %" := xRec."VAT Base Discount %";
        end;

        IF ("VAT Base Discount %" = xRec."VAT Base Discount %") AND
           (CurrFieldNo <> 0)
        THEN
          EXIT;

        PurchLine.SETRANGE("Document Type","Document Type");
        PurchLine.SETRANGE("Document No.","No.");
        PurchLine.SETFILTER(Type,'<>%1',PurchLine.Type::" ");
        PurchLine.SETFILTER(Quantity,'<>0');
        PurchLine.LOCKTABLE;
        IF PurchLine.findset THEN BEGIN
          MODIFY;
          REPEAT
            PurchLine.UpdateAmounts;
            PurchLine.MODIFY;
          UNTIL PurchLine.NEXT = 0;
        end;
        PurchLine.RESET;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GLSetup.GET;
        if "VAT Base Discount %" > GLSetup."VAT Tolerance %" then begin
          //>>HEI.50
          //IF HideValidationDialog THEN
          if ((HideValidationDialog) or (not GUIALLOWED)) then
          //<<HEI.50
            Confirmed := true
          else
        #6..8
                Text008,false,
        #10..12
          if not Confirmed then
            "VAT Base Discount %" := xRec."VAT Base Discount %";
        end;

        if ("VAT Base Discount %" = xRec."VAT Base Discount %") and
           (CurrFieldNo <> 0)
        then
          exit;

        // <<DITW15.00.00.37 DDR 23/04/2010
        PurchLine.RESET;
        PurchLine.SuspendStatusCheck(StatusCheckSuspended);
        PurchLine.SetHideValidationDialog(CurrFieldNo = 0);
        PurchLine.SetBatchInsertCheck(StatusCheckSuspended or (CurrFieldNo = 0));
        // >>DITW15.00.00.37 DDR
        #22..26
        if PurchLine.findset then begin
          MODIFY;
          repeat
            PurchLine.UpdateAmounts;
            PurchLine.MODIFY;
          until PurchLine.NEXT = 0;
        end;
        PurchLine.RESET;
        */
        //end;


        //Unsupported feature: CodeInsertion on "Status(Field 120)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<< DITW18.00.07 VSC 24/05/2016 DIT-770 #1984 -> #1488
        UpdatePurchLines(FIELDCAPTION(Status),CurrFieldNo <> 0);
        UpdateRoutePlanRqstLines(FIELDCAPTION(Status));
        //>> DITW18.00.07 VSC DIT-770 #1984 -> #1488
        */
        //end;


        //Unsupported feature: CodeModification on ""Send IC Document"(Field 123).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Send IC Document" THEN BEGIN
          TESTFIELD("Buy-from IC Partner Code");
          TESTFIELD("IC Direction","IC Direction"::Outgoing);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Send IC Document" then begin
          TESTFIELD("Buy-from IC Partner Code");
          TESTFIELD("IC Direction","IC Direction"::Outgoing);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""IC Direction"(Field 129).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "IC Direction" = "IC Direction"::Incoming THEN
          "Send IC Document" := FALSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "IC Direction" = "IC Direction"::Incoming then
          "Send IC Document" := false;
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepayment %"(Field 134).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."Prepayment %" <> "Prepayment %" THEN
          UpdatePurchLines(FIELDCAPTION("Prepayment %"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Prepayment %" <> "Prepayment %" then
          UpdatePurchLines(FIELDCAPTION("Prepayment %"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepayment No. Series"(Field 135).OnLookup". Please convert manually.

        //trigger  Series"(Field 135)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WITH PurchHeader DO BEGIN
          PurchHeader := Rec;
          PurchSetup.GET;
          PurchSetup.TESTFIELD("Posted Prepmt. Inv. Nos.");
          IF NoSeriesMgt.LookupSeries(GetPostingPrepaymentNoSeriesCode,"Prepayment No. Series") THEN
            VALIDATE("Prepayment No. Series");
          Rec := PurchHeader;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        with PurchHeader do begin
        #2..4
          if NoSeriesMgt.LookupSeries(GetPostingPrepaymentNoSeriesCode,"Prepayment No. Series") then
            VALIDATE("Prepayment No. Series");
          Rec := PurchHeader;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepayment No. Series"(Field 135).OnValidate". Please convert manually.

        //trigger  Series"(Field 135)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Prepayment No. Series" <> '' THEN BEGIN
          PurchSetup.GET;
          PurchSetup.TESTFIELD("Posted Prepmt. Inv. Nos.");
          NoSeriesMgt.TestSeries(GetPostingPrepaymentNoSeriesCode,"Prepayment No. Series");
        end;
        TESTFIELD("Prepayment No.",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Prepayment No. Series" <> '' then begin
        #2..4
        end;
        TESTFIELD("Prepayment No.",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepmt. Cr. Memo No. Series"(Field 138).OnLookup". Please convert manually.

        //trigger  Cr();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WITH PurchHeader DO BEGIN
          PurchHeader := Rec;
          PurchSetup.GET;
          PurchSetup.TESTFIELD("Posted Prepmt. Cr. Memo Nos.");
          IF NoSeriesMgt.LookupSeries(GetPostingPrepaymentNoSeriesCode,"Prepmt. Cr. Memo No. Series") THEN
            VALIDATE("Prepmt. Cr. Memo No. Series");
          Rec := PurchHeader;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        with PurchHeader do begin
        #2..4
          if NoSeriesMgt.LookupSeries(GetPostingPrepaymentNoSeriesCode,"Prepmt. Cr. Memo No. Series") then
            VALIDATE("Prepmt. Cr. Memo No. Series");
          Rec := PurchHeader;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepmt. Cr. Memo No. Series"(Field 138).OnValidate". Please convert manually.

        //trigger  Cr();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Prepmt. Cr. Memo No. Series" <> '' THEN BEGIN
          PurchSetup.GET;
          PurchSetup.TESTFIELD("Posted Prepmt. Cr. Memo Nos.");
          NoSeriesMgt.TestSeries(GetPostingPrepaymentNoSeriesCode,"Prepmt. Cr. Memo No. Series");
        end;
        TESTFIELD("Prepmt. Cr. Memo No.",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Prepmt. Cr. Memo No. Series" <> '' then begin
        #2..4
        end;
        TESTFIELD("Prepmt. Cr. Memo No.",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepmt. Payment Terms Code"(Field 143).OnValidate". Please convert manually.

        //trigger  Payment Terms Code"(Field 143)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Prepmt. Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
          PaymentTerms.GET("Prepmt. Payment Terms Code");
          IF IsCreditDocType AND NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN BEGIN
            VALIDATE("Prepayment Due Date","Document Date");
            VALIDATE("Prepmt. Pmt. Discount Date",0D);
            VALIDATE("Prepmt. Payment Discount %",0);
          end else BEGIN
            "Prepayment Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");
            "Prepmt. Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation","Document Date");
            IF NOT UpdateDocumentDate THEN
              VALIDATE("Prepmt. Payment Discount %",PaymentTerms."Discount %")
          end;
        end else BEGIN
          VALIDATE("Prepayment Due Date","Document Date");
          IF NOT UpdateDocumentDate THEN BEGIN
            VALIDATE("Prepmt. Pmt. Discount Date",0D);
            VALIDATE("Prepmt. Payment Discount %",0);
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Prepmt. Payment Terms Code" <> '') and ("Document Date" <> 0D) then begin
          PaymentTerms.GET("Prepmt. Payment Terms Code");
          if IsCreditDocType and not PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then begin
        #4..6
          end else begin
            "Prepayment Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");
            "Prepmt. Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation","Document Date");
            if not UpdateDocumentDate then
              VALIDATE("Prepmt. Payment Discount %",PaymentTerms."Discount %")
          end;
        end else begin
          VALIDATE("Prepayment Due Date","Document Date");
          if not UpdateDocumentDate then begin
            VALIDATE("Prepmt. Pmt. Discount Date",0D);
            VALIDATE("Prepmt. Payment Discount %",0);
          end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepmt. Payment Discount %"(Field 144).OnValidate". Please convert manually.

        //trigger  Payment Discount %"(Field 144)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT (CurrFieldNo IN [0,FIELDNO("Posting Date"),FIELDNO("Document Date")]) THEN
          TESTFIELD(Status,Status::Open);
        GLSetup.GET;
        IF "Payment Discount %" < GLSetup."VAT Tolerance %" THEN
          "VAT Base Discount %" := "Payment Discount %"
        else
          "VAT Base Discount %" := GLSetup."VAT Tolerance %";
        VALIDATE("VAT Base Discount %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not (CurrFieldNo in [0,FIELDNO("Posting Date"),FIELDNO("Document Date")]) then
          //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
          //TESTFIELD(Status,Status::Open);
          TestOpenStatus;
          //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        GLSetup.GET;
        if "Payment Discount %" < GLSetup."VAT Tolerance %" then
          "VAT Base Discount %" := "Payment Discount %"
        else
          "VAT Base Discount %" := GLSetup."VAT Tolerance %";
        VALIDATE("VAT Base Discount %");
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Queue Status"(Field 160).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Job Queue Status" = "Job Queue Status"::" " THEN
          EXIT;
        JobQueueEntry.ShowStatusMsg("Job Queue Entry ID");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Job Queue Status" = "Job Queue Status"::" " then
          exit;
        JobQueueEntry.ShowStatusMsg("Job Queue Entry ID");
        */
        //end;


        //Unsupported feature: CodeModification on ""Incoming Document Entry No."(Field 165).OnValidate". Please convert manually.

        //trigger "(Field 165)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Incoming Document Entry No." = xRec."Incoming Document Entry No." THEN
          EXIT;
        IF "Incoming Document Entry No." = 0 THEN
          IncomingDocument.RemoveReferenceToWorkingDocument(xRec."Incoming Document Entry No.")
        else
          IncomingDocument.SetPurchDoc(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Incoming Document Entry No." = xRec."Incoming Document Entry No." then
          exit;
        if "Incoming Document Entry No." = 0 then
          IncomingDocument.RemoveReferenceToWorkingDocument(xRec."Incoming Document Entry No.")
        else
          IncomingDocument.SetPurchDoc(Rec);
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Reference"(Field 171).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Payment Reference" <> '' THEN
          TESTFIELD("Creditor No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Payment Reference" <> '' then
          TESTFIELD("Creditor No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Campaign No."(Field 5050).OnValidate". Please convert manually.

        //trigger "(Field 5050)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CreateDim(
          DATABASE::Campaign,"Campaign No.",
          DATABASE::Vendor,"Pay-to Vendor No.",
          DATABASE::"Salesperson/Purchaser","Purchaser Code",
          DATABASE::"Responsibility Center","Responsibility Center");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362
        CreateDim(
          DATABASE::Campaign,"Campaign No.",
          // <<DITW16.00.00.42 DDR 13/12/2012 DIT-715 #522
          //DATABASE::Vendor,"Pay-to Vendor No.",
          DATABASE::Vendor,GetVendNoCalcDim(),
          // >>DITW16.00.00.42 DDR DIT-715 #522
          DATABASE::"Salesperson/Purchaser","Purchaser Code",
          DATABASE::"Responsibility Center","Responsibility Center",
          // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(2,"Contract Type"),GetContractNo(),
          //<<DITW110.00.10 MSF 15/06/2017 NRQ#13382
          DATABASE::Customer,"Linked Customer No.");
          //>>DITW110.00.10 MSF 15/06/2017 NRQ#13382
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
        //>>DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362
        */
        //end;


        //Unsupported feature: CodeModification on ""Buy-from Contact No."(Field 5052).OnLookup". Please convert manually.

        //trigger "(Field 5052)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Buy-from Vendor No." <> '' THEN
          IF Cont.GET("Buy-from Contact No.") THEN
            Cont.SETRANGE("Company No.",Cont."Company No.")
          else BEGIN
            ContBusinessRelation.RESET;
            ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
            ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Vendor);
            ContBusinessRelation.SETRANGE("No.","Buy-from Vendor No.");
            IF ContBusinessRelation.FINDFIRST THEN
              Cont.SETRANGE("Company No.",ContBusinessRelation."Contact No.")
            else
              Cont.SETRANGE("No.",'');
          end;

        IF "Buy-from Contact No." <> '' THEN
          IF Cont.GET("Buy-from Contact No.") THEN ;
        IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
          xRec := Rec;
          VALIDATE("Buy-from Contact No.",Cont."No.");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Buy-from Vendor No." <> '' then
          if Cont.GET("Buy-from Contact No.") then
            Cont.SETRANGE("Company No.",Cont."Company No.")
          else begin
        #5..8
            if ContBusinessRelation.FINDFIRST then
              Cont.SETRANGE("Company No.",ContBusinessRelation."Contact No.")
            else
              Cont.SETRANGE("No.",'');
          end;

        if "Buy-from Contact No." <> '' then
          if Cont.GET("Buy-from Contact No.") then ;
        if PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK then begin
          xRec := Rec;
          VALIDATE("Buy-from Contact No.",Cont."No.");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Buy-from Contact No."(Field 5052).OnValidate". Please convert manually.

        //trigger "(Field 5052)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);

        IF ("Buy-from Contact No." <> xRec."Buy-from Contact No.") AND
           (xRec."Buy-from Contact No." <> '')
        THEN BEGIN
          IF HideValidationDialog THEN
            Confirmed := TRUE
          else
            Confirmed := CONFIRM(ConfirmChangeQst,FALSE,FIELDCAPTION("Buy-from Contact No."));
          IF Confirmed THEN BEGIN
            IF InitFromContact("Buy-from Contact No.","Buy-from Vendor No.",FIELDCAPTION("Buy-from Contact No.")) THEN
              EXIT
          end else BEGIN
            Rec := xRec;
            EXIT;
          end;
        end;

        IF ("Buy-from Vendor No." <> '') AND ("Buy-from Contact No." <> '') THEN BEGIN
          Cont.GET("Buy-from Contact No.");
          ContBusinessRelation.RESET;
          ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
          ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Vendor);
          ContBusinessRelation.SETRANGE("No.","Buy-from Vendor No.");
          IF ContBusinessRelation.FINDFIRST THEN
            IF ContBusinessRelation."Contact No." <> Cont."Company No." THEN
              ERROR(Text038,Cont."No.",Cont.Name,"Buy-from Vendor No.");
        end;

        UpdateBuyFromVend("Buy-from Contact No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159

        if ("Buy-from Contact No." <> xRec."Buy-from Contact No.") and
           (xRec."Buy-from Contact No." <> '')
        then begin
          //>>HEI.50
          //IF HideValidationDialog THEN
          if ((HideValidationDialog) or (not GUIALLOWED)) then
          //<<HEI.50
            Confirmed := true
          else
            Confirmed := CONFIRM(ConfirmChangeQst,false,FIELDCAPTION("Buy-from Contact No."));
          if Confirmed then begin
            if InitFromContact("Buy-from Contact No.","Buy-from Vendor No.",FIELDCAPTION("Buy-from Contact No.")) then
              exit
          end else begin
            Rec := xRec;
            exit;
          end;
        end;

        if ("Buy-from Vendor No." <> '') and ("Buy-from Contact No." <> '') then begin
        #20..24
          if ContBusinessRelation.FINDFIRST then
            if ContBusinessRelation."Contact No." <> Cont."Company No." then
              ERROR(Text038,Cont."No.",Cont.Name,"Buy-from Vendor No.");
        end;

        UpdateBuyFromVend("Buy-from Contact No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Pay-to Contact No."(Field 5053).OnLookup". Please convert manually.

        //trigger "(Field 5053)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Pay-to Vendor No." <> '' THEN
          IF Cont.GET("Pay-to Contact No.") THEN
            Cont.SETRANGE("Company No.",Cont."Company No.")
          else BEGIN
            ContBusinessRelation.RESET;
            ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
            ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Vendor);
            ContBusinessRelation.SETRANGE("No.","Pay-to Vendor No.");
            IF ContBusinessRelation.FINDFIRST THEN
              Cont.SETRANGE("Company No.",ContBusinessRelation."Contact No.")
            else
              Cont.SETRANGE("No.",'');
          end;

        IF "Pay-to Contact No." <> '' THEN
          IF Cont.GET("Pay-to Contact No.") THEN ;
        IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
          xRec := Rec;
          VALIDATE("Pay-to Contact No.",Cont."No.");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Pay-to Vendor No." <> '' then
          if Cont.GET("Pay-to Contact No.") then
            Cont.SETRANGE("Company No.",Cont."Company No.")
          else begin
        #5..8
            if ContBusinessRelation.FINDFIRST then
              Cont.SETRANGE("Company No.",ContBusinessRelation."Contact No.")
            else
              Cont.SETRANGE("No.",'');
          end;

        if "Pay-to Contact No." <> '' then
          if Cont.GET("Pay-to Contact No.") then ;
        if PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK then begin
          xRec := Rec;
          VALIDATE("Pay-to Contact No.",Cont."No.");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Pay-to Contact No."(Field 5053).OnValidate". Please convert manually.

        //trigger "(Field 5053)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);

        IF ("Pay-to Contact No." <> xRec."Pay-to Contact No.") AND
           (xRec."Pay-to Contact No." <> '')
        THEN BEGIN
          IF HideValidationDialog THEN
            Confirmed := TRUE
          else
            Confirmed := CONFIRM(ConfirmChangeQst,FALSE,FIELDCAPTION("Pay-to Contact No."));
          IF Confirmed THEN BEGIN
            IF InitFromContact("Pay-to Contact No.","Pay-to Vendor No.",FIELDCAPTION("Pay-to Contact No.")) THEN
              EXIT
          end else BEGIN
            "Pay-to Contact No." := xRec."Pay-to Contact No.";
            EXIT;
          end;
        end;

        IF ("Pay-to Vendor No." <> '') AND ("Pay-to Contact No." <> '') THEN BEGIN
          Cont.GET("Pay-to Contact No.");
          ContBusinessRelation.RESET;
          ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
          ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Vendor);
          ContBusinessRelation.SETRANGE("No.","Pay-to Vendor No.");
          IF ContBusinessRelation.FINDFIRST THEN
            IF ContBusinessRelation."Contact No." <> Cont."Company No." THEN
              ERROR(Text038,Cont."No.",Cont.Name,"Pay-to Vendor No.");
        end;

        UpdatePayToVend("Pay-to Contact No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159

        if ("Pay-to Contact No." <> xRec."Pay-to Contact No.") and
           (xRec."Pay-to Contact No." <> '')
        then begin
          //>>HEI.50
          //IF HideValidationDialog THEN
          if ((HideValidationDialog) or (not GUIALLOWED)) then
          //<<HEI.50
            Confirmed := true
          else
            Confirmed := CONFIRM(ConfirmChangeQst,false,FIELDCAPTION("Pay-to Contact No."));
          if Confirmed then begin
            if InitFromContact("Pay-to Contact No.","Pay-to Vendor No.",FIELDCAPTION("Pay-to Contact No.")) then
              exit
          end else begin
            "Pay-to Contact No." := xRec."Pay-to Contact No.";
            exit;
          end;
        end;

        if ("Pay-to Vendor No." <> '') and ("Pay-to Contact No." <> '') then begin
        #20..24
          if ContBusinessRelation.FINDFIRST then
            if ContBusinessRelation."Contact No." <> Cont."Company No." then
              ERROR(Text038,Cont."No.",Cont.Name,"Pay-to Vendor No.");
        end;

        UpdatePayToVend("Pay-to Contact No.");
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Responsibility Center"(Field 5700).OnValidate". Please convert manually.

        //trigger (Variable: LocationCode)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Responsibility Center"(Field 5700).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        IF NOT UserSetupMgt.CheckRespCenter(1,"Responsibility Center") THEN
          ERROR(
            Text028,
            RespCenter.TABLECAPTION,UserSetupMgt.GetPurchasesFilter);

        "Location Code" := UserSetupMgt.GetLocation(1,'',"Responsibility Center");
        IF "Location Code" = '' THEN BEGIN
          IF InvtSetup.GET THEN
            "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
        end else BEGIN
          IF Location.GET("Location Code") THEN;
          "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
        end;

        UpdateShipToAddress;

        CreateDim(
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::Vendor,"Pay-to Vendor No.",
          DATABASE::"Salesperson/Purchaser","Purchaser Code",
          DATABASE::Campaign,"Campaign No.");

        IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
          RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
          "Assigned User ID" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        if not UserSetupMgt.CheckRespCenter(1,"Responsibility Center") then
        #3..6
        // <<DITW18.00.06 DDR 19/02/2015 DIT-770 #1191
        //"Location Code" := UserSetupMgt.GetLocation(1,'',"Responsibility Center");
        if (CurrFieldNo <> FIELDNO("Location Code")) and
          (CurrFieldNo <> FIELDNO("Physical Location Group Code")) and
          (xRec."Physical Location Group Code" = "Physical Location Group Code") and
          (xRec."Location Code" = "Location Code")
        then begin
            // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1191
            SETRANGE("Phys. Location Table Filter");
            SETRANGE("Location Table Filter");
            // >>DITW18.00.06 DDR DIT-770 #1191
            VALIDATE("Physical Location Group Code", UserSetupMgt.GetphysicalLocation(1,'',"Responsibility Center"));
            LocationCode := UserSetupMgt.GetLocation(1,'',"Responsibility Center");
            if (LocationCode <> '') or ("Physical Location Group Code" = '') then
              VALIDATE("Location Code", LocationCode);
          // <<DITW111.00.13 DDR 11/01/2019 NRQ#88589
          // <<DITW18.00.07 DDR 28/06/2016 DIT-770 #1265
          if (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and
             (xRec."Pay-to Vendor No." = "Pay-to Vendor No.")
             /// DITW110.00.12A DDR 13/08/2018 NRQ#41769 - DITW111.00.13 DDR 11/01/2019 NRQ#88589
          then
          // >>DITW18.00.07 DDR DIT-770 #1265
            RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
          // >>DITW111.00.13 DDR NRQ#88589
        end;
        // >>DITW18.00.06 DDR DIT-770 #1191

        if "Location Code" = '' then begin
          if InvtSetup.GET then
            "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
        end else begin
          if Location.GET("Location Code") then;
          "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
        end;
        #15..17
        //<<DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362
        CreateDim(
          DATABASE::"Responsibility Center","Responsibility Center",
          // <<DITW16.00.00.42 DDR 13/12/2012 DIT-715 #522
          //DATABASE::Vendor,"Pay-to Vendor No.",
          DATABASE::Vendor,GetVendNoCalcDim(),
          // >>DITW16.00.00.42 DDR DIT-715 #522
          DATABASE::"Salesperson/Purchaser","Purchaser Code",
          DATABASE::Campaign,"Campaign No.",
          // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(2,"Contract Type"),GetContractNo(),
          //<<DITW110.00.10 MSF 15/06/2017 NRQ#13382
          DATABASE::Customer,"Linked Customer No.");
          //>>DITW110.00.10 MSF 15/06/2017 NRQ#13382
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
        //>>DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362
        if xRec."Responsibility Center" <> "Responsibility Center" then begin
          // <<DITW18.00.07 DDR 28/06/2016 DIT-770 #1265
          if (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and
             (xRec."Pay-to Vendor No." = "Pay-to Vendor No.") and
             // <<DITW110.00.12A DDR 13/08/2018 NRQ#41769
             (xRec."Location Code" = "Location Code") and
             (xRec."Physical Location Group Code" = "Physical Location Group Code")
             // >>DITW110.00.12A DDR NRQ#41769
          then
          // >>DITW18.00.07 DDR DIT-770 #1265
            RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
          "Assigned User ID" := '';
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Requested Receipt Date"(Field 5790).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        IF "Promised Receipt Date" <> 0D THEN
          ERROR(
            Text034,
            FIELDCAPTION("Requested Receipt Date"),
            FIELDCAPTION("Promised Receipt Date"));

        IF "Requested Receipt Date" <> xRec."Requested Receipt Date" THEN
          UpdatePurchLines(FIELDCAPTION("Requested Receipt Date"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        if "Promised Receipt Date" <> 0D then
        #3..7
        if "Requested Receipt Date" <> xRec."Requested Receipt Date" then
          UpdatePurchLines(FIELDCAPTION("Requested Receipt Date"),CurrFieldNo <> 0);

        //HEI.26>>
        if PurchSetup.GET then begin
          PurchaseLine.SETRANGE("Document No.","No.");
          PurchaseLine.SETFILTER(PurchaseLine."Document Type",'%1',PurchaseLine."Document Type");
          PurchaseLine.SETFILTER(Type,'%1',PurchaseLine.Type::Item);
          PurchaseLine.SETFILTER("Item Category Code",PurchSetup."Item Category");
          if not PurchaseLine.FINDFIRST then
            ItemCategoryBool := false
          else
            ItemCategoryBool := true;
          if ItemCategoryBool then begin
        //HEI.26<<
        //HEI.22>>
        if ("SRM Order No." = '') and (("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::"Return Order")) then begin
            PurchHdrArch.RESET;
            PurchHdrArch.SETRANGE(PurchHdrArch."Document Type","Document Type");
            PurchHdrArch.SETRANGE(PurchHdrArch."No.","No.");
            if PurchHdrArch.FINDFIRST then begin
              if "Purch. Reason Code" = '' then
                  ERROR(ReasonCodeErr);
            end;
        end;
        //HEI.22<<
        //HEI.26>>
          end;
        end;
        //HEI.26<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Promised Receipt Date"(Field 5791).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        IF "Promised Receipt Date" <> xRec."Promised Receipt Date" THEN
          UpdatePurchLines(FIELDCAPTION("Promised Receipt Date"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        if "Promised Receipt Date" <> xRec."Promised Receipt Date" then
          UpdatePurchLines(FIELDCAPTION("Promised Receipt Date"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: CodeModification on ""Lead Time Calculation"(Field 5792).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        LeadTimeMgt.CheckLeadTimeIsNotNegative("Lead Time Calculation");

        IF "Lead Time Calculation" <> xRec."Lead Time Calculation" THEN
          UpdatePurchLines(FIELDCAPTION("Lead Time Calculation"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        LeadTimeMgt.CheckLeadTimeIsNotNegative("Lead Time Calculation");

        if "Lead Time Calculation" <> xRec."Lead Time Calculation" then
          UpdatePurchLines(FIELDCAPTION("Lead Time Calculation"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: CodeModification on ""Inbound Whse. Handling Time"(Field 5793).OnValidate". Please convert manually.

        //trigger  Handling Time"(Field 5793)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        IF "Inbound Whse. Handling Time" <> xRec."Inbound Whse. Handling Time" THEN
          UpdatePurchLines(FIELDCAPTION("Inbound Whse. Handling Time"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        if "Inbound Whse. Handling Time" <> xRec."Inbound Whse. Handling Time" then
          UpdatePurchLines(FIELDCAPTION("Inbound Whse. Handling Time"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: CodeModification on ""Return Shipment No. Series"(Field 5802).OnLookup". Please convert manually.

        //trigger  Series"(Field 5802)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WITH PurchHeader DO BEGIN
          PurchHeader := Rec;
          PurchSetup.GET;
          PurchSetup.TESTFIELD("Posted Return Shpt. Nos.");
          IF NoSeriesMgt.LookupSeries(PurchSetup."Posted Return Shpt. Nos.","Return Shipment No. Series") THEN
            VALIDATE("Return Shipment No. Series");
          Rec := PurchHeader;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        with PurchHeader do begin
        #2..4
          if NoSeriesMgt.LookupSeries(PurchSetup."Posted Return Shpt. Nos.","Return Shipment No. Series") then
            VALIDATE("Return Shipment No. Series");
          Rec := PurchHeader;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Return Shipment No. Series"(Field 5802).OnValidate". Please convert manually.

        //trigger  Series"(Field 5802)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Return Shipment No. Series" <> '' THEN BEGIN
          PurchSetup.GET;
          PurchSetup.TESTFIELD("Posted Return Shpt. Nos.");
          NoSeriesMgt.TestSeries(PurchSetup."Posted Return Shpt. Nos.","Return Shipment No. Series");
        end;
        TESTFIELD("Return Shipment No.",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Return Shipment No. Series" <> '' then begin
        #2..4
        end;
        TESTFIELD("Return Shipment No.",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""Assigned User ID"(Field 9000).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT UserSetupMgt.CheckRespCenter2(1,"Responsibility Center","Assigned User ID") THEN
          ERROR(
            Text049,"Assigned User ID",
            RespCenter.TABLECAPTION,UserSetupMgt.GetPurchasesFilter2("Assigned User ID"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not UserSetupMgt.CheckRespCenter2(1,"Responsibility Center","Assigned User ID") then
        #2..4
        */
        //end;
        //BC UPGRADE SHARMP16 Comment fields begin<<
        // field(11620;ABN;
        // Text[14])
        // {
        //     Caption = 'ABN';
        //     Description = 'wht';
        //     Editable = false;
        //     Numeric = true;
        // }
        // field(11622;"ABN Division Part No.";
        // Text[3])
        // {
        //     Caption = 'ABN Division Part No.';
        //     Description = 'WHT';
        // }
        //BC UPGRADE SHARMP16 Comment fields end>>
        field(50000; "Vendor Bank Account FND";
        Code[10])
        {
            Caption = 'Vendor Bank Account';
            Description = 'HEI.01';
            TableRelation = "Vendor Bank Account".Code where("Vendor No." = FIELD("Buy-from Vendor No."));

            trigger OnValidate();
            begin
                // HEI.17>>
                if "Payment Method Code" <> '' then begin
                    if PaymentMethod.GET("Payment Method Code") then
                        if PaymentMethod."Mandatory Bank details FND" then begin
                            VendorBankAccount.RESET();
                            VendorBankAccount.SETRANGE("Vendor No.", "Buy-from Vendor No.");
                            if VendorBankAccount.ISEMPTY then
                                ERROR(Text50000)
                            else begin
                                VendorBankAccount.SETRANGE(Code, "Vendor Bank Account FND");
                                if VendorBankAccount.FINDFIRST() then
                                    HeinekenGlobal.ValidateVendBankAccFields("Buy-from Vendor No.", "Vendor Bank Account FND");
                            end;
                        end;
                end;
                // HEI.17<<
            end;
        }
        field(50001; "IBAN FND"; Code[50])
        {
            CalcFormula = Lookup("Vendor Bank Account".IBAN where("Vendor No." = FIELD("Pay-to Vendor No."),
                                                                   Code = FIELD("Vendor Bank Account FND")));
            Description = 'HEI.01';
            Caption = 'IBAN';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Payment User FND"; Code[50])
        {
            Caption = 'Payment User';
            Description = 'HEI.11,HEI.28,HEI.30';
            TableRelation = "User Setup";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(50003; "Payment Status FND"; Option)
        {
            Description = 'HEI.10';
            Caption = 'Payment Status';
            OptionCaption = 'Pending Review,Payment Approved,Payment Rejected';
            OptionMembers = "Pending Review","Payment Approved","Payment Rejected";
        }
        field(50004; "Status Date FND"; Date)
        {
            Description = 'HEI.11';
            Caption = 'Status Date';
        }
        field(50005; "SRM Contract No. FND"; Code[10])
        {
            Caption = 'SRM Contract No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50006; "SRM Contract Name FND"; Text[50])
        {
            Caption = 'SRM Contract Name';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50007; "SRM Contract Type FND"; Code[10])
        {
            Caption = 'Contract Type';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = "SRM Contract Type FND";
        }
        field(50008; "Valid From FND"; Date)
        {
            Caption = 'Valid From';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50009; "Valid To FND"; Date)
        {
            Caption = 'Valid To';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50010; "Channel FND"; Code[1])
        {
            Caption = 'Channel';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = "Channel FND";
        }
        field(50011; "Shipment Method Location FND"; Text[30])
        {
            Caption = 'Shipment Method Location';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50012; "Closed FND"; Boolean)
        {
            Caption = 'Closed';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50013; "SRM Order No. FND"; Code[10])
        {
            Caption = 'SRM Order No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50014; "SRM Version No. FND"; Code[10])
        {
            Caption = 'SRM Version No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50015; "RUID FND"; Text[100])
        {
            CaptionML = ENU = 'RUID',
                        FRA = 'RUID';
            Description = 'ESKER1.0,HEI.05';
        }
        field(50016; "Consumption Date FND"; Date)
        {
            Caption = 'Consumption Date';
            Description = 'HEI.02';
        }
        field(50020; "Target Value Currency FND"; Code[10])
        {
            Caption = 'Target Value Currency';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = Currency;
        }
        field(50021; "Target Value Amount FND"; Decimal)
        {
            Caption = 'Target Value Amount';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50022; "Blanket Order No. FND"; Code[20])
        {
            Caption = 'Blanket Order No.';
            Description = 'HEI.02';
            TableRelation = "Purchase Header"."No." where("Document Type" = CONST("Blanket Order"),
                                                           "Buy-from Vendor No." = FIELD("Buy-from Vendor No."));
        }
        field(50023; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            Description = 'HEI.06';
            TableRelation = "WHT Business Posting Group FND".Code;
        }
        field(50024; "Actual Vendor No. FND"; Code[20])
        {
            Caption = 'Actual Vendor No.';
            Description = 'HEI.06';
        }
        field(50030; "Maximo Requisition No. FND"; Code[20])
        {
            Caption = 'Maximo Requisition No.';
            Description = 'HEI.09';
            Editable = false;
        }
        field(50031; "Prep. to reverse FND"; Code[20])
        {
            Caption = 'Prep. to reverse';
        }

        //BC Upgrade VAMSIU01 - Added back Document Subtype in Table relation filter.
        field(50032; "Purchase Order No. FND"; Code[20])
        {
            TableRelation = "Purchase Header"."No." where("Document Type" = FILTER(Order),
                                                           "Document Subtype Code FND" = FILTER(''),
                                                           "Buy-from Vendor No." = FIELD("Buy-from Vendor No."),
                                                           Status = FILTER(Released));//BC UPGRADE SHARMP16 related to Drink-IT 

            Caption = 'Purchase Order No.';
        }
        field(50033; "On Hold UserID FND"; Code[50])
        {
            CalcFormula = Lookup("Purchase Additional Fields FND"."On Hold UserID" where(TableID = FILTER(38),
                                                                                      "Document Type" = FIELD("Document Type"),
                                                                                      "Document No." = FIELD("No.")));
            Caption = 'On Hold UserID';
            Description = 'HEI.18';
            FieldClass = FlowField;
        }
        field(50034; "On Hold Date FND"; Date)
        {
            CalcFormula = Lookup("Purchase Additional Fields FND"."On Hold Date" where(TableID = CONST(38),
                                                                                    "Document Type" = FIELD("Document Type"),
                                                                                    "Document No." = FIELD("No.")));
            Caption = 'On Hold Date';
            Description = 'HEI.18';
            FieldClass = FlowField;
        }
        field(50036; "BRC Purchase Order FND"; Boolean)
        {
            Description = 'HEI.25';
            Caption = 'BRC Purchase Order';
        }
        field(50038; "Purch. Reason Code FND"; Code[10])
        {
            Description = 'HEI.22';
            Caption = 'Purchase. Reason Code';
            TableRelation = "Reason Code_Purchase FND".Code;

            trigger OnValidate();
            begin
                //HEI.22>>
                Rec.TestStatusOpen();
                //rec.TestOpenStatus;//BC UPGRADE SHARMP16 code commented because function name change in BC from TestOpenStatus to TestStatusOpen
                //HEI.22<<
            end;
        }
        field(50039; "Changed FND"; Boolean)
        {
            Description = 'HEI.27';
            Caption = 'Changed';
        }
        field(50040; "PQ Approver FND"; Code[50])
        {
            CalcFormula = Lookup("Purchase Header Additional FND"."PQ Approver" where("Document Type" = FIELD("Document Type"),
                                                                                   "No." = FIELD("No.")));
            Caption = 'PQ Approver';
            Description = 'HEI.30';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "User Setup";
        }
        field(50041; "Fixed Asset Acquisition FND"; Boolean)
        {
            Caption = 'Fixed Asset Acquisition';
            Description = 'HEI.34';
            Editable = false;
        }
        field(50042; "House Number FND"; Code[10])
        {
            CalcFormula = Lookup("Purchase Header Additional FND"."House Number" where("Document Type" = FIELD("Document Type"),
                                                                                    "No." = FIELD("No.")));
            Description = 'HEI.40';
            Caption = 'House Number';
            FieldClass = FlowField;
        }
        // BC Upgrade SHUKLP03 >> Added in the interface ext.
        // field(50043; "Maximo Status"; Option)
        // {
        //     CalcFormula = Lookup("Purchase Header Additional FND"."Maximo Status" WHERE("Document Type" = FIELD("Document Type"),
        //                                                                              "No." = FIELD("No.")));
        //     Caption = 'Maximo Status';
        //     Description = 'HEI.39,HEI.52';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     OptionMembers = " ",Approved,Canceled,Closed,"Waiting on Approval",PendClose;
        // }
        // BC Upgrade SHUKLP03 << Added in the interface ext.
        field(50044; "Shopping Card No. FND"; Code[10])
        {
            CalcFormula = Lookup("Purchase Header Additional FND"."Shopping Card No." where("Document Type" = FIELD("Document Type"),
                                                                                         "No." = FIELD("No.")));
            Description = 'HEI.41';
            Caption = 'Shopping Card No.';
            FieldClass = FlowField;
        }
        field(50045; "License Code FND"; Code[20])
        {
            CalcFormula = Lookup("Purchase Header Additional FND"."License Code" where("Document Type" = FIELD("Document Type"),
                                                                                    "No." = FIELD("No.")));
            Description = 'HEI.43';
            Caption = 'License Code';
            FieldClass = FlowField;
        }
        // BC Upgrade SHUKLP03 >> Added in the interface ext.
        // field(50046; "LSR Order No."; Code[20])
        // {
        //     CalcFormula = Lookup("Purchase Header Additional FND"."LSR Order No" WHERE("Document Type" = FIELD("Document Type"),
        //                                                                             "No." = FIELD("No.")));
        //     Description = 'HEI.48';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // BC Upgrade SHUKLP03 << Added in the interface ext.
        field(50047; "TO Reference FND"; Code[20])
        {
            CalcFormula = Lookup("Purchase Line"."TO Reference FND" where("Document Type" = FIELD("Document Type"),
                                                                       "Document No." = FIELD("No."),
                                                                       "TO Reference FND" = FILTER(<> '')));//BC UPGRADE SHARMP16-- PurchProcesstesting
            Description = 'HEI.53';
            Caption = 'TO Reference';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50048; "Import Identifier FND"; Boolean)
        {
            CalcFormula = Lookup("Purchase Header Additional FND"."Import Identifier" where("Document Type" = FIELD("Document Type"),
                                                                                         "No." = FIELD("No.")));
            Description = 'HEI.53';
            Caption = 'Import Identifier';
            Editable = false;
            FieldClass = FlowField;
        }

        //BC UPGRADE VAMSIU01 - Document Subtype code field added >>
        field(50090; "Document Subtype Code FND"; Code[10])
        {
            CaptionML = ENU = 'Document Subtype Code',
                        FRA = 'Code Sous-Type Document';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = CONST(Purchase));

            trigger OnValidate();
            var
                DocumentSubtypeCode: Record "Document Subtype Code FND";
                PostingNoSeries: Code[20];
            begin
                //<<DITW111.00.13 MSF 04/09/2018 NRQ#83542-DITW111.00.13 MSF 05/09/2018 NRQ#83542
                if xRec."Document Subtype Code FND" <> Rec."Document Subtype Code FND" then begin
                    if Rec."Document Subtype Code FND" <> '' then begin
                        TESTFIELD("Posting No.", '');
                        PostingNoSeries := DocumentSubtypeCode.GetPostedSerialNoforDocumentSubtype("Document Type", "Document Subtype Code FND");
                        if PostingNoSeries <> '' then
                            "Posting No. Series" := PostingNoSeries
                        else
                            SetDefaultPostingSerialno();
                    end else
                        SetDefaultPostingSerialno();
                end;
                //>>DITW111.00.13 MSF 04/09/2018 NRQ#83542-DITW111.00.13 MSF 05/09/2018 NRQ#83542
            end;
        }
        // BC Upgrade BHARDA11 >> --Field Addded FDD STP 002
        field(50091; "Vendor Tx Registration No. FND"; Text[20])
        {
            Caption = 'Tax Registration No.';
            DataClassification = ToBeClassified;
        }
        field(50094; "Doc. Amount Incl. VAT IBM FND"; Decimal)
        {
            Caption = 'Doc. Amount Incl. VAT';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Document Type" IN ["Document Type"::Invoice, "Document Type"::"Credit Memo"] THEN BEGIN
                    PurchLine.RESET();
                    PurchLine.SETRANGE("Document Type", rec."Document Type");
                    PurchLine.SETRANGE("Document No.", rec."No.");
                    IF NOT PurchLine.FIND('-') THEN BEGIN
                        PurchLine.SETFILTER(Type, '<>%1', PurchLine.Type::" ");
                    END;
                    IF PurchLine.FIND('-') THEN
                        IF PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Normal VAT" THEN BEGIN
                            IF "Currency Code" = '' THEN
                                Currency.InitRoundingPrecision()
                            ELSE BEGIN
                                Currency.GET("Currency Code");
                                Currency.TESTFIELD("Amount Rounding Precision");
                            END;
                            DocBaseAmount :=
                              ROUND(
                                "Doc. Amount Incl. VAT IBM FND" / (1 + (1 - "VAT Base Discount %" / 100) * PurchLine."VAT %" / 100),
                                Currency."Amount Rounding Precision");
                            "Doc. Amount VAT IBM FND" :=
                              ROUND(
                                DocBaseAmount * (1 - "VAT Base Discount %" / 100) * PurchLine."VAT %" / 100,
                                Currency."Amount Rounding Precision");
                        END ELSE
                            DocBaseAmount := "Doc. Amount Incl. VAT IBM FND";
                END;

                //>>FINXL7.00.001 RBE 06/08/2013
            end;
        }
        field(50095; "Doc. Amount VAT IBM FND"; Decimal)
        {
            Caption = 'Doc. Amount VAT';
            trigger OnValidate()
            var
                Sign: Decimal;
            begin
                IF "Document Type" IN ["Document Type"::Invoice, "Document Type"::"Credit Memo"] THEN BEGIN
                    IF ("Doc. Amount Incl. VAT IBM FND" < 0) THEN
                        Sign := -1
                    ELSE
                        Sign := 1;

                    IF ("Doc. Amount VAT IBM FND" * Sign) > ("Doc. Amount Incl. VAT IBM FND" * Sign) THEN
                        ERROR(Text2029610,
                              FIELDCAPTION("Doc. Amount VAT IBM FND"),
                              FIELDCAPTION("Doc. Amount Incl. VAT IBM FND"));
                END;

            end;

        }
        // BC Upgrade BHARDA11 << Field Addded FDD STP 002
        //BC Upgrade SHARMP16 BEGIN<< ---IBM GAP STP 48
        field(50096; "Created By IBM FND"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = "User Setup";
            Editable = false;
            ValidateTableRelation = true;
        }
        field(50098; "Creation Date/Time IBM FND"; DateTime)
        {
            Caption = 'Creation Date/Time';
            Editable = false;
        }
        field(50099; "Last Changed User ID IBM FND"; Code[50])
        {
            Caption = 'Last Changed User ID';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(50100; "Last Changed Date/Time IBM FND"; DateTime)
        {
            Caption = 'Last Changed Date/Time';
            Editable = false;

        }
        field(50101; "Requester ID IBM FND"; code[50])
        {
            Caption = 'Requester ID IBM';
            TableRelation = "User Setup";
            ValidateTableRelation = true;

        }
        //BC UPGRADE VAMSIU01 - Document Subtype code field added <<
        //BC UPGRADE ATHUKUS01 FDDSTP_007 >>
        field(50102; "Call From OnDelete FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Call From OnDelete';
        }

        // BC UPGRADE PATELS08 >>
        field(50103; "Exp Physical Del Date(Imp) FND"; Date)
        {
            CaptionML = ENU = 'Expected Physical Delivery Date (Imp)';
            Description = 'HEI.56';
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header Additional FND"."Exp Physical Del Date(Imp)" WHERE("No." = FIELD("No."), "Document Type" = FIELD("Document Type")));
            // BC UPGRADE PATELS08 <<
        }
        //BC UPGRADE ATHUKUS01 FDDSTP_007 <<
        //BC UPGRADE SHARMP16 begin<< //drink-it fields
        // field(2013610;"Vendor DDeposit Group Code";Code[10])
        // {
        //     CaptionML = ENU='Customer Deposit Group Code',
        //                 FRA='Code groupe consigne client';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code WHERE ("Source Type"=CONST(Vendor));

        //     trigger OnValidate();
        //     begin
        //         //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //         //TESTFIELD(Status,Status::Open);
        //         TestOpenStatus;
        //         //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        //         // <<DITW15.00.00.25 DDR 21/10/2008
        //         if xRec."Vendor DDeposit Group Code" <> "Vendor DDeposit Group Code" then
        //           // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
        //           RecreateChargePurchaseLines(FIELDCAPTION("Vendor DDeposit Group Code"))
        //           // >>DITW16.00.00.43 DDR DIT-715 #691
        //         // >>DITW15.00.00.25 DDR
        //     end;
        // }
        // field(2013611;"Empty Goods Item No. Filter";Code[20])
        // {
        //     CaptionML = ENU='Empty Goods Item No. Filter',
        //                 FRA='Filtre article vidange n°';
        //     Description = 'DITW15.00.00.35';
        //     FieldClass = FlowFilter;
        //     TableRelation = Item WHERE ("Empty Good"=CONST(true));
        // }
        // field(2013613;"Link Purch. Document No.";Code[20])
        // {
        //     CaptionML = ENU='Link Purch. Document No.',
        //                 FRA='Lien N° document achat';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Purchase Header"."No." WHERE ("Document Type"=FIELD("Link Purch. Document Type"));
        // }
        // field(2013614;"Link Purch. Document Type";Option)
        // {
        //     CaptionML = ENU='Link Purch. Document Type',
        //                 FRA='Lien type document achat';
        //     Description = 'DITW15.00.00.01';
        //     OptionCaptionML = ENU='Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order',
        //                       FRA='Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
        //     OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        // }
        // field(2013615;"Print Link Document";Boolean)
        // {
        //     CaptionML = ENU='Print Link Document',
        //                 FRA='Imprimer lien document';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013616;"No. of Link Purchase Orders";Integer)
        // {
        //     CalcFormula = Count("Purchase Header" WHERE ("Link Purch. Document Type"=FIELD("Document Type"),
        //                                                  "Link Purch. Document No."=FIELD("No.")));
        //     CaptionML = ENU='No. of Link Purchase Orders',
        //                 FRA='Nombre de lien commandes achats';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013630;"Deposit Vendor Posting Group";Code[10])
        // {
        //     CaptionML = ENU='Deposit - Vendor Posting Group',
        //                 FRA='Consigne - Groupe compta. fournisseur';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = "Vendor Posting Group";
        // }
        // field(2013631;"Deposit Payment Terms Code";Code[10])
        // {
        //     CaptionML = ENU='Deposit - Payment Terms Code',
        //                 FRA='Consigne - Code conditions paiement';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = "Payment Terms";

        //     trigger OnLookup();
        //     begin
        //         // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
        //         if ("Deposit Payment Terms Code" <> '') and ("Document Date" <> 0D) then
        //           PaymentTerms.GET("Deposit Payment Terms Code");
        //     end;
        // }
        // field(2013632;"Deposit Payment Method Code";Code[10])
        // {
        //     CaptionML = ENU='Deposit - Payment Method Code',
        //                 FRA='Consigne - Code mode de règlement';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = "Payment Method";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
        //         PaymentMethod.INIT;
        //         if "Deposit Payment Method Code" <> '' then
        //           PaymentMethod.GET("Deposit Payment Method Code");
        //         "Deposit Bal. Account Type" := PaymentMethod."Bal. Account Type";
        //         "Deposit Bal. Account No." := PaymentMethod."Bal. Account No.";
        //         if "Deposit Bal. Account No." <> '' then begin
        //           TESTFIELD("Applies-to Doc. No.",'');
        //           TESTFIELD("Applies-to ID",'');
        //         end;
        //     end;
        // }
        // field(2013633;"Deposit Bal. Account Type";Option)
        // {
        //     CaptionML = ENU='Deposit - Bal. Account Type',
        //                 FRA='Consigne - Type Compte Contrepartie';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     OptionCaptionML = ENU='G/L Account,Bank Account',
        //                       FRA='Général,Banque';
        //     OptionMembers = "G/L Account","Bank Account";
        // }
        // field(2013634;"Deposit Bal. Account No.";Code[20])
        // {
        //     CaptionML = ENU='Deposit - Bal. Account No.',
        //                 FRA='Consigne - N° compte contrepartie';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = IF ("Deposit Bal. Account Type"=CONST("G/L Account")) "G/L Account"
        //                     else IF ("Deposit Bal. Account Type"=CONST("Bank Account")) "Bank Account";

        //     trigger OnValidate();
        //     begin
        //         if "Deposit Bal. Account No." <> '' then
        //           case "Deposit Bal. Account Type" of
        //             "Deposit Bal. Account Type"::"G/L Account":
        //               begin
        //                 GLAcc.GET("Deposit Bal. Account No.");
        //                 GLAcc.CheckGLAcc;
        //                 GLAcc.TESTFIELD("Direct Posting",true);
        //               end;
        //             "Deposit Bal. Account Type"::"Bank Account":
        //               begin
        //                 BankAcc.GET("Deposit Bal. Account No.");
        //                 BankAcc.TESTFIELD(Blocked,false);
        //                 BankAcc.TESTFIELD("Currency Code","Currency Code");
        //               end;
        //           end;
        //     end;
        // }
        // field(2013638;"Deposit Posting No.";Code[20])
        // {
        //     CaptionML = ENU='Deposit Posting No.',
        //                 FRA='N° facture consigne';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     Editable = false;
        //     TableRelation = Table0;
        // }
        // field(2013639;"Last Deposit Posting No.";Code[20])
        // {
        //     CaptionML = ENU='Last Deposit Posting No.',
        //                 FRA='N° dern. facture consigne';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     Editable = false;
        //     TableRelation = Table0;
        // }
        // field(2013666;"Autom. Item Charge";Option)
        // {
        //     CaptionML = ENU='Calculate Item Charges',
        //                 FRA='Calculer Frais annexes';
        //     Description = 'DITW15.00.00.39 #1407';
        //     OptionCaptionML = ENU='Direct,Release,Posting,Posting (Excl. Item)',
        //                       FRA='Direct,Lancé,Validation,Validation (Excl. Article)';
        //     OptionMembers = " ",Release,Posting,PostingExclItem;
        // }
        // field(2013667;"Vendor DTax Group Code";Code[10])
        // {
        //     CaptionML = ENU='Vendor Tax Group Code',
        //                 FRA='Code groupe taxe fournisseur';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Vendor));

        //     trigger OnValidate();
        //     begin
        //         //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //         //TESTFIELD(Status,Status::Open);
        //         TestOpenStatus;
        //         //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        //         // <<DITW15.00.00.34 DDR 09/07/2009
        //         TestMsgTaxRegistration();
        //         // >>DITW15.00.00.34 DDR

        //         // <<DITW15.00.00.25 DDR 21/10/2008
        //         if xRec."Vendor DTax Group Code" <> "Vendor DTax Group Code" then begin
        //           // <<DITW17.10.05 MSF 17/07/2014 DIT-770 #698
        //           UpdatePurchLines(FIELDCAPTION("Vendor DTax Group Code"),CurrFieldNo <> 0);
        //           // >>DITW17.10.05 MSF DIT-770 #698
        //           // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
        //           RecreateChargePurchaseLines(FIELDCAPTION("Vendor DTax Group Code"))
        //           // >>DITW16.00.00.43 DDR DIT-715 #691
        //         end;
        //         // >>DITW15.00.00.25 DDR

        //         // <<DITW18.00.07 MVN 04/06/2016 DIT-770 #1397
        //         if "Document Type" = "Document Type"::"Return Order" then begin
        //           if ApplMgt.IsObjectLicense(5,CODEUNIT::"EMCS EDI Mgt",4) <> 0 then
        //             // <<DITW110.00.09 DDR 21/03/2017 NRQ#13144
        //             "Submission Type" := EMCSEDIMgt.GetSubmissionType(2,"Vendor DTax Group Code","Location Code");
        //             // >>DITW110.00.09 DDR NRQ#13144
        //         end;
        //         // >>DITW18.00.07 MVN DIT-770 #1397
        //     end;
        // }
        // field(2013695;"Item Charge Type Filter";Option)
        // {
        //     CaptionML = ENU='Item Charge Type Filter',
        //                 FRA='Filtre type frais article';
        //     Description = 'DITW15.00.00.01';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU=' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA=' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        // }
        // field(2013726;"Vendor Tax Registration No.";Text[20])
        // {
        //     CaptionML = ENU='Vendor Tax Registration No.',
        //                 FRA='N° ident. accise fournisseur';
        //     Description = 'DITW15.00.00.28';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.34 DDR 09/07/2009
        //         TestMsgTaxRegistration();
        //         // >>DITW15.00.00.34 DDR
        //     end;
        // }
        // field(2013730;"Fiscal Representative No.";Code[20])
        // {
        //     CaptionML = ENU='Fiscal Representative / Customs Agent No.',
        //                 FRA='N° représentant fiscal / Agent des douanes';
        //     Description = 'DITW15.00.00.28-.38 #1217';
        //     TableRelation = "Fiscal Representative";

        //     trigger OnValidate();
        //     var
        //         OrderAddr : Record "Order Address";
        //     begin
        //         // <<DITW15.00.00.28 DDR 24/11/2008
        //         if "Fiscal Representative No." <> '' then begin
        //           rFiscalRep.GET("Fiscal Representative No.");
        //           if  rFiscalRep."TAX Registration No." <> '' then
        //             "Vendor Tax Registration No." := rFiscalRep."TAX Registration No.";
        //           // <<DITW15.00.00.38 DDR 13/09/2010 #1217
        //           if rFiscalRep."Tax Warehouse Reference" <> '' then
        //             "Vendor Tax Warehouse Ref." := rFiscalRep."Tax Warehouse Reference";
        //           // >>DITW15.00.00.38 DDR
        //           // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
        //           if rFiscalRep."Tax Office Code" <> '' then
        //             "Tax Office Code" := rFiscalRep."Tax Office Code";
        //           // >>DITW15.00.00.38 DDR #1217 (DIT711 137)
        //         end else begin
        //           GetVend("Buy-from Vendor No.");
        //           "Vendor Tax Registration No." := Vend."Tax Registration No.";
        //           // <<DITW15.00.00.38 DDR 13/09/2010 #1217
        //           "Vendor Tax Warehouse Ref." := Vend."Tax Warehouse Reference";
        //           // >>DITW15.00.00.38 DDR
        //           // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
        //           "Tax Office Code" := Vend."Tax Office Code";
        //           // <<DITW15.00.00.38 DDR #1217 (DIT711 137)
        //           if CurrFieldNo <> FIELDNO("Fiscal Representative No.") then
        //             "Fiscal Representative No." := Vend."Fiscal Representative No.";
        //           if "Order Address Code" <> '' then begin
        //             OrderAddr.GET("Buy-from Vendor No.","Order Address Code");
        //             if  OrderAddr."Tax Registration No." <> '' then
        //               "Vendor Tax Registration No." := OrderAddr."Tax Registration No.";
        //             // <<DITW15.00.00.38 DDR 13/09/2010 #1217
        //             if OrderAddr."Tax Warehouse Reference" <> '' then
        //               "Vendor Tax Warehouse Ref." := OrderAddr."Tax Warehouse Reference";
        //             // >>DITW15.00.00.38 DDR
        //             // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
        //             if OrderAddr."Tax Office Code" <> '' then
        //               "Tax Office Code" := OrderAddr."Tax Office Code";
        //             // <<DITW15.00.00.38 DDR #1217 (DIT711 137)
        //             // <<DITW16.00.00.40 DDR 24/01/2012 DIT-715 #203
        //             if (CurrFieldNo <> FIELDNO("Fiscal Representative No.")) then
        //               "Fiscal Representative No." := OrderAddr."Fiscal Representative No.";
        //             // >>DITW16.00.00.40 DDR DIT-715 #203
        //             // <<DITW15.00.00.39 DDR 06/07/2011 #1353
        //             if FORMAT(OrderAddr."Journey Time") <> '' then
        //               "Journey Time" := OrderAddr."Journey Time";
        //             // >>DITW15.00.00.39 DDR #1353
        //           end;
        //         end;
        //         // <<DITW15.00.00.34 DDR 09/07/2009
        //         TestMsgTaxRegistration();
        //         // >>DITW15.00.00.34 DDR
        //     end;
        // }
        // field(2013733;"Tax Date";Date)
        // {
        //     CaptionML = ENU='Tax Date',
        //                 FRA='Date taxe';
        //     Description = 'DITW15.00.00.39 #1363';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW17.10.05 DDR 26/01/2015 DIT-770 #885
        //         PurchSetup.GET;
        //         // >>DITW17.10.05 DDR DIT-770 #885
        //         // <<DITW16.00.00.42 DDR 01/03/2013 DIT-715 #572
        //         if ("Tax Date" = xRec."Tax Date") and ("Tax Date" = 0D) then begin
        //           PurchLine.RESET;
        //           PurchLine.SETRANGE("Item Charge Type",PurchLine."Item Charge Type"::Tax);
        //           DeleteChargePurchLines();
        //           RecalcBackPurchLines();
        //         end else
        //         // >>DITW16.00.00.42 DDR DIT-715 #572
        //           // <<DITW15.00.00.39 DDR 19/08/2011 #1363
        //           if ("Tax Date" <> xRec."Tax Date") and
        //              (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and
        //              // <<DITW17.10.05 DDR 01/10/2014 DIT-770 #885 - DDR 26/01/2015 DIT-770 #885
        //              ((xRec."Expected Receipt Date" = "Expected Receipt Date") or (PurchSetup."Default Tax Date" = PurchSetup."Default Tax Date"::ShipRecvDate)) and
        //              // >>DITW17.10.05 DDR DIT-770 #885
        //              // <<DITW17.10.05 DDR 26/01/2015 DIT-770 #885
        //              ((xRec."Order Date" = "Order Date") or (PurchSetup."Default Tax Date" = PurchSetup."Default Tax Date"::OrderDate))
        //              // >>DITW17.10.05 DDR DIT-770 #885
        //           then
        //             // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
        //             RecreateChargePurchaseLines(FIELDCAPTION("Tax Date"));
        //             // >>DITW16.00.00.43 DDR DIT-715 #691
        //           // >>DITW15.00.00.39 DDR #1363
        //     end;
        // }
        // field(2013797;"Disc.Promo. Order Calculated";Boolean)
        // {
        //     CalcFormula = Exist("Purchase Line" WHERE ("Document Type"=FIELD("Document Type"),
        //                                                "Document No."=FIELD("No."),
        //                                                "Disc.Promo. Order Calculated"=CONST(true)));
        //     CaptionML = ENU='Disc.Promo. Order Calculated',
        //                 FRA='Remise-Promotion cmde. calculé';
        //     Description = 'DITW15.00.00.24-.37';
        //     FieldClass = FlowField;
        // }
        // field(2013823;"Gen. Bus. Posting Free Group";Code[10])
        // {
        //     CaptionML = ENU='Gen. Bus. Posting Group Free item',
        //                 FRA='Groupe article gratuit compta. marché';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Gen. Business Posting Group";
        // }
        // field(2013825;"Free Item Posting Type";Option)
        // {
        //     CaptionML = ENU='Calculate Price on Free',
        //                 FRA='Calculer Prix sur gratuit';
        //     Description = 'DITW15.00.00.35';
        //     OptionCaptionML = ENU=' ,Price 0,Discount 100%',
        //                       FRA=' ,Prix 0,Remise 100%';
        //     OptionMembers = " ",Price,Amount;
        // }
        // field(2014060;"Maximum Weight";Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU='Maximum Weight',
        //                 FRA='Poids maximum';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.21';
        //     MinValue = 0;
        // }
        // field(2014061;"Maximum Cubage";Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU='Maximum Volume (Cubage)',
        //                 FRA='Volume (Cubage) maximum';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.21';
        //     MinValue = 0;
        // }
        // field(2014063;"Auto Create Shipping Cost";Option)
        // {
        //     CaptionML = ENU='Auto Create Shipping Cost On Source Doc.',
        //                 FRA='Création automatique des frais de livraison sur document d''origine';
        //     Description = 'DIT-770 #1066';
        //     OptionCaptionML = ENU=' ,Never,Always',
        //                       FRA=' ,Jamais,Toujours';
        //     OptionMembers = " ",Never,Always;
        // }
        // field(2014064;"Shipping Charge Per";Option)
        // {
        //     CaptionML = ENU='Shipping Charge Per',
        //                 FRA='Frais transport par';
        //     Description = 'DITW15.00.00.21';
        //     OptionCaptionML = ENU='Shipment,Weight,Volume',
        //                       FRA='Expédition,Poids,Volume';
        //     OptionMembers = Shipment,Weight,Volume;

        //     trigger OnValidate();
        //     begin
        //         // <<DIT15.00.00.21 DDR 19/06/2008 - DITW15.00.00.25 DDR 17/10/2008
        //         //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //         //TESTFIELD(Status,Status::Open);
        //         TestOpenStatus;
        //         //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159
        //         if xRec."Shipping Charge Per" <> "Shipping Charge Per" then
        //           UpdatePurchLines(FIELDCAPTION("Shipping Charge Per"),CurrFieldNo <> 0);
        //         // >>DIT15.00.00.25 DDR
        //     end;
        // }
        // field(2014067;"Total Weight";Decimal)
        // {
        //     CalcFormula = Sum("Purchase Line".Weight WHERE ("Document Type"=FIELD("Document Type"),
        //                                                     "Document No."=FIELD("No."),
        //                                                     "Location Code"=FIELD("Location Filter")));
        //     CaptionML = ENU='Total Weight',
        //                 FRA='Poids total';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014068;"Total Cubage";Decimal)
        // {
        //     CalcFormula = Sum("Purchase Line".Cubage WHERE ("Document Type"=FIELD("Document Type"),
        //                                                     "Document No."=FIELD("No."),
        //                                                     "Location Code"=FIELD("Location Filter")));
        //     CaptionML = ENU='Total Volume (Cubage)',
        //                 FRA='Volume (Cubage) total';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014069;"Total Weight (Base)";Decimal)
        // {
        //     CalcFormula = Sum("Purchase Line".Weight WHERE ("Document Type"=FIELD("Document Type"),
        //                                                     "Document No."=FIELD("No."),
        //                                                     "Location Code"=FIELD("Location Filter")));
        //     CaptionML = ENU='Total Weight',
        //                 FRA='Poids total';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW18.00.07 DIT-770 #1971';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014070;"Total Cubage (Base)";Decimal)
        // {
        //     CalcFormula = Sum("Purchase Line".Cubage WHERE ("Document Type"=FIELD("Document Type"),
        //                                                     "Document No."=FIELD("No."),
        //                                                     "Location Code"=FIELD("Location Filter")));
        //     CaptionML = ENU='Total Volume (Cubage)',
        //                 FRA='Volume (Cubage) total';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW18.00.07 DIT-770 #1971';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014075;"Shipping Agent Code";Code[10])
        // {
        //     CaptionML = ENU='Shipping Agent Code',
        //                 FRA='Code transporteur';
        //     Description = 'DITW15.00.00.21 - DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214';
        //     TableRelation = IF ("Responsibility Center"=CONST('')) "Shipping Agent" WHERE ("Responsibility Center"=FIELD("Resp. Center Table Filter"))
        //                     else IF ("Responsibility Center"=FILTER(<>'')) "Shipping Agent" WHERE ("Responsibility Center"=FIELD("Resp. Center Table Filter 2"));

        //     trigger OnValidate();
        //     begin

        //         //<< DITW18.00.07 VSC 27/05/2016 DIT-770 #1975 -> #159 - #289 -  #1488
        //         //TESTFIELD(Status,Status::Open);
        //         TestOpenStatus;
        //         //>> DITW18.00.07 VSC DIT-770 #1975 -> #159 - #289 -  #1488
        //         //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         if "Multiple Order Route" then
        //           if CurrFieldNo = FIELDNO("Shipping Agent Code") then
        //             ERROR(STRSUBSTNO(Text2014061,"Document Type","No."));
        //         //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         //<< DITW18.00.07 VSC 27/05/2016 DIT-770 #1975 - #1488
        //         TestRouteTypeVariable(FIELDNO("Shipping Agent Code"));
        //         //>> DITW18.00.07 VSC DIT-770 #1975 - #1488

        //         // <<DIT15.00.00.21 DDR 19/06/2008 - DITW15.00.00.23.04 DDR 15/09/2008 - DITW15.00.00.25 DDR 17/10/2008
        //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        //         if (xRec."Shipping Agent Code" <> Rec."Shipping Agent Code") and ("Shipping Agent Code" <>'') and
        //           ("Responsibility Center" <> '') then
        //           UserSetupMgt.CheckShipmentAgent("Responsibility Center","Shipping Agent Code");
        //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214

        //         //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975
        //         TestOpenStatus;
        //         //TESTFIELD(Status,Status::Open);
        //         //>> DITW18.00.07 VSC  DIT-770 #1975
        //         if xRec."Shipping Agent Code" = "Shipping Agent Code" then
        //           exit;

        //         "Shipping Agent Service Code" := '';

        //         // <<DITW15.00.00.39 DDR 06/07/2011 #1353
        //         GetJourneyTime(FIELDNO("Shipping Agent Code"));
        //         // >>DITW15.00.00.39 DDR #1353

        //         "Shipping Charge Per" := "Shipping Charge Per"::Shipment;

        //         UpdatePurchLines(FIELDCAPTION("Shipping Agent Code"),CurrFieldNo <> 0);
        //         // >>DIT15.00.00.25 DDR

        //         // <<DITW19.00.08 DDR 01/12/2016 BL#10314
        //         VALIDATE("Shipping Agent Service Code",'');
        //         // >>DITW19.00.08 DDR BL#10314

        //         // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1109
        //         ClearHasBeenShowAll2(FIELDNO("Ship-to Code"));
        //         // >>DITW18.00.07 DDR DIT-770 #1109
        //         //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         UpdateWhseRequestLines(FIELDCAPTION("Shipping Agent Code"));
        //         //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         //HEI.23>>
        //         if "Document Type" = "Document Type"::Order then begin
        //           if ShippingAgent.GET("Shipping Agent Code") then begin
        //             //HEI.31
        //             //IF ShippingAgent."Vendor No." = '' THEN
        //             if (ShippingAgent."Vendor No." = '') and (not ShippingAgent."Own Logistics") then
        //             //HEI.31
        //               ERROR(ShippingAgentVendorIsBlank)
        //             else if Vend.GET(ShippingAgent."Vendor No.") then begin
        //               if Vend.Blocked <> 0 then
        //                 ERROR(VendorBlockForShipAgent);
        //             end;
        //           end;
        //         end;
        //         //HEI.23<<
        //     end;
        // }
        // field(2014076; "Shipping Agent Service Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Shipping Agent Service Code',
        //                 FRA = 'Code prestation transporteur';
        //     Description = 'DITW15.00.00.21';
        //     TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = FIELD("Shipping Agent Code"));

        //     trigger OnLookup();
        //     begin
        //         //>> HEI.38
        //         FilterShippingAgentServiceCode;
        //         //<< HEI.38
        //     end;

        //     trigger OnValidate();
        //     begin
        //         // <<DIT15.00.00.21 DDR 19/06/2008 - DITW15.00.00.25 DDR 17/10/2008
        //         //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975
        //         TestOpenStatus;
        //         //TESTFIELD(Status,Status::Open);
        //         //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         if "Multiple Order Route" then
        //           if CurrFieldNo = FIELDNO("Shipping Agent Service Code") then
        //             ERROR(STRSUBSTNO(Text2014061,"Document Type","No."));
        //         //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         //>> DITW18.00.07 VSC  DIT-770 #1975
        //         // <<DITW15.00.00.39 DDR 06/07/2011 #1353
        //         GetJourneyTime(FIELDNO("Shipping Agent Service Code"));
        //         // >>DITW15.00.00.39 DDR #1353
        //         // <<DITW16.00.00.40 DDR 27/02/2012 DIT-715 #245
        //         "Truck Code" := '';
        //         // >>DITW16.00.00.40 DDR DIT-715 #245
        //         UpdateShippingMax();
        //         UpdatePurchLines(FIELDCAPTION("Shipping Agent Service Code"),CurrFieldNo <> 0);
        //         // >>DIT15.00.00.25 DDR
        //         //<< DITW18.00.07 VSC 10/03/2016 DIT-770 #1066
        //         //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
        //         //<< DITW18.00.07 VSC 04/07/2016 DIT-770 #1066

        //         //>> HEI.34 FDD-HT658 IBM.GUNERE01 26.09.2019
        //         if xRec."Shipping Agent Service Code" <> Rec."Shipping Agent Service Code" then
        //           if Rec."Shipping Agent Service Code" = '' then
        //             WhseTransportMgt.DeletePurchShippingCost(xRec,false);
        //         //<< HEI.34 FDD-HT658 IBM.GUNERE01 26.09.2019
        //         CreateShippingCost(Rec,false,false);
        //         //>> DITW18.00.07 VSC DIT-770 #1066
        //         //>> DITW18.00.07 VSC DIT-770 #1066
        //         //>> DITW18.00.07 VSC DIT-770 #1066
        //         //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         UpdateWhseRequestLines(FIELDCAPTION("Shipping Agent Service Code"));
        //         //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //     end;
        // }
        // field(2014077;"Truck Code";Code[10])
        // {
        //     CaptionML = ENU='Truck Code',
        //                 FRA='Code camion';
        //     Description = 'DITW18.00.07 DIT-770 #1968,HEI.34';
        //     TableRelation = "Whse. Shipping Truck";

        //     trigger OnLookup();
        //     begin
        //         //>> HEI.34 FDD-HT658 IBM.GUNERE01 10.09.2019
        //         FilterWhseShippingTrucks;
        //         //<< HEI.34 FDD-HT658 IBM.GUNERE01 10.09.2019
        //     end;

        //     trigger OnValidate();
        //     begin
        //         //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968 -> DIT-770 #159, #289, #1488
        //         TestOpenStatus;
        //         //>> DITW18.00.07 VSC DIT-770 #1968 -> DIT-770 #159, #289, #1488
        //         //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         if "Multiple Order Route" then
        //           if CurrFieldNo = FIELDNO("Truck Code") then
        //             ERROR(STRSUBSTNO(Text2014061,"Document Type","No."));
        //         //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        //         TestRouteTypeVariable(FIELDNO("Truck Code"));
        //         //>> DITW18.00.07 VSC DIT-770 #1968
        //         //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968 ->DIT-770 #1212 #1213 #1214
        //         if (xRec."Truck Code" <> Rec."Truck Code") and ("Truck Code" <>'') and
        //           ("Responsibility Center" <> '') then
        //           UserSetupMgt.CheckTruck("Responsibility Center","Truck Code");
        //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        //         // <<DITW15.00.00.26 DDR 17/11/2008 - DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        //         if xRec."Truck Code" <> "Truck Code" then begin
        //           UpdateShippingMax();
        //           //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Truck Code"));
        //           //<< DITW18.00.07 VSC DIT-770 #1968
        //           //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //           UpdateWhseRequestLines(FIELDCAPTION("Truck Code"));
        //           //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         end;
        //         //>> DITW18.00.07 VSC DIT-770 #1984 - #1981-> DIT-770 #1488
        //     end;
        // }
        // field(2014078;"Driver Code";Code[10])
        // {
        //     CaptionML = ENU='Driver Code',
        //                 FRA='Code chauffeur';
        //     Description = 'DITW18.00.07 DIT-770 #1968,HEI.34';
        //     TableRelation = "Whse. Shipping Driver";

        //     trigger OnLookup();
        //     begin
        //         //>> HEI.34 FDD-HT658 IBM.GUNERE01 10.09.2019
        //         FilterWhseShippingDrivers;
        //         //<< HEI.34 FDD-HT658 IBM.GUNERE01 10.09.2019
        //     end;

        //     trigger OnValidate();
        //     begin
        //         //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        //         TestOpenStatus;
        //         //>> DITW18.00.07 VSC DIT-770 #1984 - #1981-> DIT-770 #1488
        //         //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         if "Multiple Order Route" then
        //           if CurrFieldNo = FIELDNO("Driver Code") then
        //             ERROR(STRSUBSTNO(Text2014061,"Document Type","No."));
        //         //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        //         TestRouteTypeVariable(FIELDNO("Driver Code"));
        //         //>> DITW18.00.07 VSC DIT-770 #1984 - #1981-> DIT-770 #1488

        //         //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968 -> DIT-770 #1212 #1213 #1214
        //         if (xRec."Driver Code" <> Rec."Driver Code") and ("Driver Code" <>'') and
        //           ("Responsibility Center" <> '') then
        //           UserSetupMgt.CheckDriver("Responsibility Center","Driver Code");
        //         //>> DITW18.00.07 VSC DIT-770 #1968 -> DIT-770 #1212 #1213 #1214
        //         //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        //         if xRec."Driver Code" <> "Driver Code" then begin
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Driver Code"));
        //         //>> DITW18.00.07 VSC DIT-770 #1984 - #1981-> DIT-770 #1488
        //           //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //           UpdateWhseRequestLines(FIELDCAPTION("Driver Code"));
        //           //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         end;
        //     end;
        // }
        // field(2014079;"Shipment status";Option)
        // {
        //     CaptionML = ENU='Shipping Status',
        //                 FRA='Statut Expédition';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     OptionCaptionML = ENU='Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice',
        //                       FRA='Ouvert,Prélèvement imprimé,Affecté,Prélevé,Expédié,Retour terminée,Facturée';
        //     OptionMembers = Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 12/08/2016 BL#10314
        //         if not ("Document Type" in ["Document Type"::Order,"Document Type"::"Return Order"]) then
        //           FIELDERROR("Document Type");
        //         // >>DITW19.00.08 DDR BL#10314
        //         //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        //         if xRec."Shipment status" <> "Shipment status" then begin
        //           //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968 -> DIT-770 #1277, #1488
        //           UpdatePurchLines(FIELDCAPTION("Shipment status"),CurrFieldNo <> 0);
        //           //>> DITW18.00.07 VSC DIT-770 #1968 -> DIT-770 #1277, #1488
        //           //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Shipment status"));
        //           //>> DITW18.00.07 VSC DIT-770 #1984 - #1981-> DIT-770 #1488
        //         end;
        //         //>> DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        //     end;
        // }
        // field(2014080;"Vendor Delivery Type";Code[10])
        // {
        //     CaptionML = ENU='Vendor Delivery Type',
        //                 FRA='Type Livraison Fournisseur';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     TableRelation = "Delivery Type".Code WHERE (Type=CONST(Vendor));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 12/08/2016 BL#10314
        //         if not ("Document Type" in ["Document Type"::Order,"Document Type"::"Return Order"]) and
        //           not (PurchSetup."Receipt on Invoice" or PurchSetup."Return Shipment on Credit Memo")
        //         then
        //           FIELDERROR("Document Type");
        //         // >>DITW19.00.08 DDR BL#10314
        //     end;
        // }
        // field(2014081;"Delivery Time (sec.)";Decimal)
        // {
        //     CalcFormula = Sum("Purchase Line"."Delivery Time (sec.)" WHERE ("Document Type"=FIELD("Document Type"),
        //                                                                     "Document No."=FIELD("No."),
        //                                                                     Type=CONST(Item)));
        //     CaptionML = ENU='Delivery Time (sec.)',
        //                 FRA='Temps de Livraison (Sec.)';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014082;"Total HL Cubage";Decimal)
        // {
        //     CalcFormula = Sum("Purchase Line"."HL Cubage" WHERE ("Document Type"=FIELD("Document Type"),
        //                                                          "Document No."=FIELD("No."),
        //                                                          "Location Code"=FIELD("Location Filter"),
        //                                                          "Outstanding Quantity"=FILTER(>0)));
        //     CaptionClass = GetUomCaptionClassHL(FIELDNO("Total HL Cubage"));
        //     CaptionML = ENU='Total Outstanding Volume',
        //                 FRA='Total Volume Restant';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW18.00.07 DIT-770 #1971';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014084;"Total Eq. UOM Quantity";Decimal)
        // {
        //     CalcFormula = Sum("Sales Line"."Eq. UOM Quantity" WHERE ("Document Type"=FIELD("Document Type"),
        //                                                              "Document No."=FIELD("No."),
        //                                                              "Location Code"=FIELD("Location Filter"),
        //                                                              "Outstanding Quantity"=FILTER(>0)));
        //     CaptionClass = GetUomCaptionClassEqUom(FIELDNO("Total Eq. UOM Quantity"));
        //     CaptionML = ENU='Total Outstanding Eq. UOM Quantity',
        //                 FRA='Total Volume Unité de mesure Eq.';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW18.00.07 DIT-770 #1971';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014087;Distance;Decimal)
        // {
        //     CaptionML = ENU='Distance',
        //                 FRA='Distance';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.24';
        //     MinValue = 0;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.25 DDR 17/08/2008
        //         //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159 - DITW17.00.02 AT 20/12/2013 DIT-770 #289 - DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        //         TestOpenStatus;
        //         WhseTransportMgt.UpdatePurchShippingDistances(Rec); //HEI.34 FDD-HT658 IBM.GUNERE01 06.09.2019
        //         //TESTFIELD(Status,Status::Open);
        //         ///DITW110.00.11 MSF 21/09/2017 NRQ#16082 -DITW110.00.11 MSF 30/11/2017 NRQ#16082
        //         //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159 - DITW17.00.02 AT 20/12/2013 DIT-770 #289 - DITW18.00.07 DDR DIT-770 #1488
        //         if xRec.Distance <> Distance then begin
        //           UpdatePurchLines(FIELDCAPTION(Distance),CurrFieldNo <> 0);
        //           //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //           UpdateWhseRequestLines(FIELDCAPTION(Distance));
        //           //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         end;
        //     end;
        // }
        // field(2014097;"Truck Zone";Option)
        // {
        //     CaptionML = ENU='Truck Zone',
        //                 FRA='Zone de camion';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     OptionCaptionML = ENU=' ,Right,Left',
        //                       FRA=' ,Droite,Gauche';
        //     OptionMembers = " ",Right,Left;

        //     trigger OnValidate();
        //     begin
        //         //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        //         TestOpenStatus;
        //         //>> DITW18.00.07 VSC DIT-770 #1984 - #1981-> DIT-770 #1488
        //         //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968 -> DIT-770 #289
        //         if xRec."Truck Zone" <> "Truck Zone" then begin
        //           UpdatePurchLines(FIELDCAPTION("Truck Zone"),CurrFieldNo <> 0);
        //           //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Truck Zone"));
        //           //>> DITW18.00.07 VSC DIT-770 #1968 -> #1488
        //         end;
        //         //>> DITW18.00.07 VSC DIT-770 #1968 -> DIT-770 #289
        //     end;
        // }
        // field(2014098;"Require 2 Drivers";Boolean)
        // {
        //     CaptionML = ENU='Require 2 Drivers',
        //                 FRA='Demande 2 chauffeurs';
        //     Description = 'DITW18.00.07 DIT-770 #1968';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968
        //         if xRec."Require 2 Drivers" <> "Require 2 Drivers" then begin
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Require 2 Drivers"));
        //         //>> DITW18.00.07 VSC DIT-770 #1968
        //           //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //           UpdateWhseRequestLines(FIELDCAPTION("Require 2 Drivers"));
        //           //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         end;
        //     end;
        // }
        // field(2014099;"Driver 2 Code";Code[10])
        // {
        //     CaptionML = ENU='Driver 2 Code',
        //                 FRA='Code Chauffeur 2';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     TableRelation = IF ("Responsibility Center"=CONST('')) "Whse. Shipping Driver".Code WHERE ("Responsibility Center"=FIELD("Resp. Center Table Filter"))
        //                     else IF ("Responsibility Center"=FILTER(<>'')) "Whse. Shipping Driver".Code WHERE ("Responsibility Center"=FIELD("Resp. Center Table Filter 2"));

        //     trigger OnValidate();
        //     begin
        //         //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968
        //         TestOpenStatus;
        //         //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         if "Multiple Order Route" then
        //           if CurrFieldNo = FIELDNO("Driver 2 Code") then
        //             ERROR(STRSUBSTNO(Text2014061,"Document Type","No."));
        //         //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         TestRouteTypeVariable(FIELDNO("Driver 2 Code"));
        //         if (xRec."Driver 2 Code" <> Rec."Driver 2 Code") and ("Driver 2 Code" <>'') and
        //           ("Responsibility Center" <> '') then
        //           UserSetupMgt.CheckDriver("Responsibility Center","Driver 2 Code");
        //         if xRec."Driver 2 Code" <> "Driver 2 Code" then begin
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Driver 2 Code"));
        //         //>> DITW18.00.07 VSC DIT-770 #1968
        //           //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //           UpdateWhseRequestLines(FIELDCAPTION("Driver 2 Code"));
        //           //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         end;
        //     end;
        // }
        // field(2014100;"Trailer Code";Code[10])
        // {
        //     CaptionML = ENU='Trailer Code',
        //                 FRA='Code Remorque';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     TableRelation = IF ("Responsibility Center"=CONST('')) "Whse. Shipping Truck".Code WHERE ("Responsibility Center"=FIELD("Resp. Center Table Filter"),
        //                                                                                               "Transport Unit Type"=CONST(Trailer))
        //                                                                                               else IF ("Responsibility Center"=FILTER(<>'')) "Whse. Shipping Truck".Code WHERE ("Responsibility Center"=FIELD("Resp. Center Table Filter 2"),
        //                                                                                                                                                                                 "Transport Unit Type"=CONST(Trailer));

        //     trigger OnValidate();
        //     begin
        //         //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968
        //         TestOpenStatus;
        //         //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         if "Multiple Order Route" then
        //           if CurrFieldNo = FIELDNO("Trailer Code") then
        //             ERROR(STRSUBSTNO(Text2014061,"Document Type","No."));
        //         //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         TestRouteTypeVariable(FIELDNO("Trailer Code"));

        //         if (xRec."Trailer Code" <> Rec."Trailer Code") and ("Trailer Code"<>'') and
        //           ("Responsibility Center" <> '') then
        //           UserSetupMgt.CheckTrailer("Responsibility Center","Trailer Code");

        //         if xRec."Trailer Code" <> "Trailer Code" then begin
        //           UpdateShippingMax();
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Trailer Code"));
        //           //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //           UpdateWhseRequestLines(FIELDCAPTION("Trailer Code"));
        //           //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         end;
        //         //>> DITW18.00.07 VSC DIT-770 #1968
        //     end;
        // }
        // field(2014103;"Whse. Receipt No. (First)";Code[20])
        // {
        //     CalcFormula = Min("Warehouse Receipt Line"."No." WHERE ("Source Type"=CONST(39),
        //                                                             "Source Subtype"=CONST("1"),
        //                                                             "Source No."=FIELD("No.")));
        //     CaptionML = ENU='Whse. Receipt No. (First)',
        //                 FRA='N° réception magasin (Premier)';
        //     Description = 'DITW15.00.00.39 #1399';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     TableRelation = "Warehouse Receipt Header";
        // }
        // field(2014104;"Whse. Receipt Status (First)";Option)
        // {
        //     CalcFormula = Lookup("Warehouse Receipt Header"."Document Status" WHERE ("No."=FIELD("Whse. Receipt No. (First)")));
        //     CaptionML = ENU='Whse. Receipt Status (First)',
        //                 FRA='Status réception magasin (Premier)';
        //     Description = 'DITW15.00.00.39 #1399';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     OptionCaptionML = ENU=' ,Partially Received,Completely Received',
        //                       FRA=' ,Partiellement réceptionné,Entièrement réceptionné';
        //     OptionMembers = " ","Partially Received","Completely Received";
        // }
        // field(2014107;Route;Code[20])
        // {
        //     CaptionML = ENU='Route',
        //                 FRA='Itinéraire';
        //     Description = 'DITW18.00.07 DIT-770 #1968 - DITW19.00.08 BL#11231';
        //     TableRelation = Route WHERE ("Responsibility Center"=FIELD("Resp. Center Table Filter"));

        //     trigger OnValidate();
        //     var
        //         lrRoute : Record Route;
        //         lrxRoute : Record Route;
        //     begin
        //         //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //           if CheckExistWarehouseLine then
        //             ERROR(STRSUBSTNO(Text2014061,"Document Type","No."));
        //         //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         // <<DITW19.00.08 DDR 12/08/2016 BL#10314
        //         if not ("Document Type" in ["Document Type"::Order,"Document Type"::"Return Order"]) then
        //           FIELDERROR("Document Type");
        //         // >>DITW19.00.08 DDR BL#10314
        //         //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968
        //         // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        //         TestOpenStatus;
        //         if xRec.Route <> Route then begin
        //         // >>DITW18.00.07 DDR DIT-770 #1488
        //           if Route <> '' then begin
        //           // >>DITW18.00.07 DDR DIT-770 #1488
        //             //<<DITW17.10.05 WSA 03/11/2014 DIT-770 #892
        //             if lrxRoute.GET(xRec.Route) then;
        //             //>>DITW17.10.05 WSA 03/11/2014 DIT-770 #892
        //             lrRoute.GET(Route);
        //             //<<DITW17.10.05 WSA 03/11/2014 DIT-770 #892 - DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        //             if (lrRoute."Shipment Day" <> lrRoute."Shipment Day"::" ") and
        //               (lrRoute."Shipment Day" <> lrxRoute."Shipment Day") and
        //               ("Order Date" <> 0D)
        //             then begin
        //             //>>DITW17.10.05 WSA 03/11/2014 DIT-770 #892 - DITW18.00.07 DDR DIT-770 #1488
        //               VALIDATE("Expected Receipt Date",lrRoute.GetShipmentDate("Order Date"));
        //               VALIDATE("Posting Date","Expected Receipt Date");
        //               // >>DITW18.00.07 DDR DIT-770 #1488
        //             end;

        //             //<< DITW18.00.07 VSC 10/03/2016 DIT-770 #1066
        //             //<< DITW18.00.07 VSC 08/04/2016 DIT-770 #1066
        //             if lrRoute."Auto Create Shipping Cost" <> lrRoute."Auto Create Shipping Cost"::" " then
        //               "Auto Create Shipping Cost" := lrRoute."Auto Create Shipping Cost";
        //             //>> DITW18.00.07 VSC DIT-770 #1066
        //             if Location.GET(lrRoute."Location Code") then
        //               "Auto Create Shipping Cost" := Location."Auto Create Shipping Cost";
        //             //>> DITW18.00.07 VSC DIT-770 #1066

        //             // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        //             if lrRoute."Shipment Method Code" <> '' then
        //               VALIDATE("Shipment Method Code",lrRoute."Shipment Method Code");
        //             // >>DITW18.00.07 DDR DIT-770 #1488

        //             // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        //             if lrRoute."Shipping Agent Code" <> '' then begin
        //               VALIDATE("Shipping Agent Code",lrRoute."Shipping Agent Code");
        //               // <<DITW19.00.08 DDR 01/12/2016 BL#10314
        //               if xRec."Shipping Agent Code" = "Shipping Agent Code" then
        //                 UpdatePurchLines(FIELDCAPTION("Shipping Agent Code"),CurrFieldNo <> 0);
        //               // >>DITW19.00.08 DDR BL#10314
        //             end;
        //             // >>DITW18.00.07 DDR DIT-770 #1488
        //             if lrRoute."Shipping Agent Service Code" <> '' then
        //               VALIDATE("Shipping Agent Service Code",lrRoute."Shipping Agent Service Code");
        //             // <<DITW18.00.06 MSF 18/08/2015 DIT-770 #1534
        //             if lrRoute."Location Code" <> '' then begin
        //             // >>DITW18.00.06 MSF 18/08/2015 DIT-770 #1534
        //               // <<DITW18.00.07 DDR 25/02/2016 DIT-770 #1488
        //               "Physical Location Group Code" := '';
        //               // >>DITW18.00.07 DDR DIT-770 #1488
        //               VALIDATE("Location Code",lrRoute."Location Code");
        //             end;
        //             // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        //             if lrRoute."Physical Location Group Code" <> '' then
        //               VALIDATE("Physical Location Group Code",lrRoute."Physical Location Group Code");
        //             //IF lrRoute."Responsibility Center" <> '' THEN
        //             //  VALIDATE("Responsibility Center",lrRoute."Responsibility Center");
        //             // >>DITW18.00.07 DDR DIT-770 #1488
        //             //<<DITW18.00.06 MSF 26/06/2015 DIT-770 #1347
        //             if lrRoute."Driver Code" <> '' then
        //               VALIDATE("Driver Code",lrRoute."Driver Code");
        //             if lrRoute."Trailer Code" <> '' then
        //               VALIDATE("Trailer Code",lrRoute."Trailer Code");
        //             if lrRoute."Driver Code 2" <> '' then
        //               VALIDATE("Driver 2 Code",lrRoute."Driver Code 2");
        //             if lrRoute."Truck Code" <> '' then
        //               VALIDATE("Truck Code",lrRoute."Truck Code");
        //             //>>DITW18.00.06 MSF 26/06/2015 DIT-770 #1347
        //             //>> HEI.34 FDD-HT658 IBM.GUNERE01 06.09.2019
        //             GetVend("Buy-from Vendor No.");
        //             if Distance <> Vend.Distance then
        //               if lrRoute.Distance <> 0 then
        //                 VALIDATE(Distance,lrRoute.Distance);
        //             //<< HEI.34 FDD-HT658 IBM.GUNERE01 06.09.2019
        //             //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
        //             //<< DITW18.00.07 VSC 04/07/2016 DIT-770 #1066
        //             CreateShippingCost(Rec,false,false);
        //             //>> HEI.34 FDD-HT658 IBM.GUNERE01 16.09.2019
        //             if xRec.Route <> Rec.Route then
        //               WhseTransportMgt.UpdatePurchShippingRoutes(Rec);
        //             //<< HEI.34 FDD-HT658 IBM.GUNERE01 16.09.2019
        //             //>> DITW18.00.07 VSC DIT-770 #1066
        //             //>> DITW18.00.07 VSC DIT-770 #1066
        //             //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //             "Multiple Order Route" := lrRoute."Multiple Order Route";
        //             //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //           end else begin
        //              //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //             //>> HEI.34 FDD-HT658 IBM.GUNERE01 16.09.2019
        //             if xRec.Route <> Rec.Route then
        //               WhseTransportMgt.UpdatePurchShippingRoutes(Rec);
        //             //<< HEI.34 FDD-HT658 IBM.GUNERE01 16.09.2019
        //             "Multiple Order Route" := false;
        //              //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //             // <<DITW18.00.07 DDR 25/02/2016 DIT-770 #1488
        //             DeleteRoutePlanRqstLine();
        //             if "Shipping Agent Service Code" <> '' then
        //               VALIDATE("Shipping Agent Service Code");
        //             // >>DITW18.00.07 DDR DIT-770 #1488
        //           end;
        //           //>>DITW17.00.02 TEC1 DIT-770 #154

        //           UpdatePurchLines(FIELDCAPTION(Route),CurrFieldNo <> 0);
        //           UpdateRoutePlanRqstLines(FIELDCAPTION(Route));
        //           //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //           UpdateWhseRequestLines(FIELDCAPTION(Route));
        //           //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082

        //         end;
        //         ClearHasBeenShowAll2(FIELDNO(Route));

        //         //HEI.23>>
        //         if "Document Type" = "Document Type"::Order then begin
        //           if RecRoute.GET(Route) then begin
        //               if ShippingAgent.GET(RecRoute."Shipping Agent Code") then begin
        //                 //HEI.31>>
        //                 //IF ShippingAgent."Vendor No." = '' THEN
        //                 if (ShippingAgent."Vendor No." = '') and (not ShippingAgent."Own Logistics") then
        //                 //HEI.31<<
        //                   ERROR(ShippingAgentVendorIsBlank)
        //                 else if Vend.GET(ShippingAgent."Vendor No.") then begin
        //                   if Vend.Blocked <> 0 then
        //                     ERROR(VendorBlockForShipAgent);
        //                 end;
        //               end;
        //           end;
        //         end;
        //         //HEI.23<<
        //     end;
        // }
        // field(2014108;"Multiple Order Route";Boolean)
        // {
        //     Caption = 'Multiple Order Route';
        //     Description = 'NRQ#16082';
        //     TableRelation = Route;
        // }
        // field(2014109;"Route Planning No.";Code[20])
        // {
        //     CaptionML = ENU='Route Planning No.',
        //                 FRA='N° Planning Itinéraire';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     TableRelation = "Route Planning Worksheet";

        //     trigger OnValidate();
        //     begin
        //         //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         if CheckExistWarehouseLine then
        //           ERROR(STRSUBSTNO(Text2014061,"Document Type","No."));
        //         //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //           //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //           UpdateWhseRequestLines(FIELDCAPTION("Route Planning No."));
        //           //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //     end;
        // }
        // field(2014110;"Delivery Time 1 From";Time)
        // {
        //     CaptionML = ENU='Delivery Time 1 From',
        //                 FRA='Heure de livraison 1 de';
        //     Description = 'DITW18.00.07 DIT-770 #1968';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW18.00.07 VSC 06/05/2016 DIT-770 #1968
        //         if xRec."Delivery Time 1 From" <> "Delivery Time 1 From" then
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Delivery Time 1 From"));
        //         //>> DITW18.00.07 VSC DIT-770 #1968
        //     end;
        // }
        // field(2014111;"Delivery Time 1 To";Time)
        // {
        //     CaptionML = ENU='Delivery Time 1 To',
        //                 FRA='Heure de livraison 1 à';
        //     Description = 'DITW18.00.07 DIT-770 #1968';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW18.00.07 VSC 06/05/2016 DIT-770 #1968
        //         if xRec."Delivery Time 1 To" <> "Delivery Time 1 To" then
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Delivery Time 1 To"));
        //         //>> DITW18.00.07 VSC DIT-770 #1968
        //     end;
        // }
        // field(2014112;"Delivery Time 2 From";Time)
        // {
        //     CaptionML = ENU='Delivery Time 2 From',
        //                 FRA='Heure de livraison 2 de';
        //     Description = 'DITW18.00.07 DIT-770 #1968';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW18.00.07 VSC 06/05/2016 DIT-770 #1968
        //         if xRec."Delivery Time 2 From" <> "Delivery Time 2 From" then
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Delivery Time 2 From"));
        //         //>> DITW18.00.07 VSC DIT-770 #1968
        //     end;
        // }
        // field(2014113;"Delivery Time 2 To";Time)
        // {
        //     CaptionML = ENU='Delivery Time 2 To',
        //                 FRA='Heure de livraison 2 à';
        //     Description = 'DITW18.00.07 DIT-770 #1968';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW18.00.07 VSC 06/05/2016 DIT-770 #1968
        //         if xRec."Delivery Time 2 To" <> "Delivery Time 2 To" then
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Delivery Time 2 To"));
        //         //>> DITW18.00.07 VSC DIT-770 #1968
        //     end;
        // }
        // field(2014114;"Receipt Status";Option)
        // {
        //     CaptionML = ENU='Receipt Status',
        //                 FRA='Satut Recéption';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     OptionCaptionML = ENU='Open,Order Printed,Order Sent,Order Confirmed,To Receive,Receipt Completed,Invoice',
        //                       FRA='Ouvert,Commande Imprimée,Commande Envoyée,Commande Confirmée,A réceptionner,Réception Complete,Facturée';
        //     OptionMembers = Open,"Order Printed","Order Sent","Order Confirmed","To Receive","Receipt Completed",Invoice;

        //     trigger OnValidate();
        //     begin
        //         //<< DITW18.00.07 VSC 24/05/2016 DIT-770 #1984
        //         if xRec."Receipt Status" <> "Receipt Status" then begin
        //           UpdatePurchLines(FIELDCAPTION("Receipt Status"),CurrFieldNo <> 0);
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Receipt Status"));
        //         end;
        //         //>> DITW18.00.07 VSC DIT-770 #1984
        //     end;
        // }
        // field(2014271;"Vendor Tax Warehouse Ref.";Text[20])
        // {
        //     CaptionML = ENU='Vendor Tax Warehouse Reference',
        //                 FRA='Entrepôt fiscal de référence fournisseur';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014277;"Transport Mode";Option)
        // {
        //     CalcFormula = Lookup("Transport Method"."Transport Mode" WHERE (Code=FIELD("Transport Method")));
        //     CaptionML = ENU='Transport Mode (EMCS)',
        //                 FRA='Mode de transport (EMCS)';
        //     Description = 'DITW16.00.00.40 DIT715 #187';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     OptionCaptionML = ENU='Other,Sea,Rail,Road,Air,Post,N/A,Fixed,Waterway',
        //                       FRA='Autre,Mer,Chemin de fer,Route,Air,Poste,N/C,Installation de transport fixes,Transport par voies navigables';
        //     OptionMembers = Other,Sea,Rail,Road,Air,Post,"N/A","Fixed",Waterway;
        // }
        // field(2014290;"Journey Time";DateFormula)
        // {
        //     CaptionML = ENU='Journey Time (EMCS)',
        //                 FRA='Temps de trajet (EMCS)';
        //     Description = 'DITW15.00.00.39 #1353';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975
        //         TestOpenStatus;
        //         //TESTFIELD(Status,Status::Open);
        //         //>> DITW18.00.07 VSC  DIT-770 #1975
        //     end;
        // }
        // field(2014291;"Transport Mode Comment";Boolean)
        // {
        //     CalcFormula = Exist("EMCS Comment Line" WHERE ("Table ID"=CONST(38),
        //                                                    "Document Type"=CONST(1),
        //                                                    "Document No."=FIELD("No."),
        //                                                    "Document Line No."=CONST(0),
        //                                                    "Field ID"=CONST(2014277)));
        //     CaptionML = ENU='Transport Mode Comment',
        //                 FRA='Commentaires Mode de transport';
        //     Description = 'DITW16.00.00.40 DIT715 #187';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014300;"Submission Type";Option)
        // {
        //     CaptionML = ENU='Submission Type  (EMCS)',
        //                 FRA='Type de Message (EMCS)';
        //     Description = 'DITW18.00.07 DIT-770 #1397';
        //     OptionCaptionML = ENU=' ,Type 1,Type 2',
        //                       FRA=' ,Type 1,Type 2';
        //     OptionMembers = " ","Type 1","Type 2";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW18.00.07 MVN 07/04/2016 DIT-770 #1397
        //         if ApplMgt.IsObjectLicense(5,CODEUNIT::"EMCS EDI Mgt",4) <> 0 then
        //         // >>DITW18.00.07 MVN DIT-770 #1397
        //           // <<DITW18.00.07 MVN 24/02/2016 DIT-770 #1397
        //             // <<DITW110.00.09 DDR 21/03/2017 NRQ#13144
        //             "Submission Type" := EMCSEDIMgt.GetSubmissionType(2,"Vendor DTax Group Code","Location Code");
        //             // >>DITW110.00.09 DDR NRQ#13144
        //           // >>DITW18.00.07 MVN DIT-770 #1397
        //     end;
        // }
        // field(2014313;"Financial Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Financial Contract No.',
        //                 FRA='N° Contrat Financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        //     TableRelation = IF ("DIT Sub-Contract Type"=CONST(" ")) "Financial Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract))
        //                     else IF ("DIT Sub-Contract Type"=FILTER(<>" ")) "Financial Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                                                                       "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //         //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975
        //         TestOpenStatus;
        //         //TESTFIELD(Status,Status::Open);
        //         //>> DITW18.00.07 VSC  DIT-770 #1975
        //         if "Financial Contract No." <> '' then begin
        //           //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           "Contract Type" := "Contract Type"::Financial;
        //           TESTFIELD("Service Contract No.",'');
        //           //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           if ("Financial Contract No." <> xRec."Financial Contract No.") and
        //              (xRec."Sell-to Customer No." = "Sell-to Customer No.")
        //           then
        //             MessageIfPurchLinesExist(FIELDCAPTION("Financial Contract No."));

        //           if (CurrFieldNo = FIELDNO("Financial Contract No.")) and
        //             (xRec."Financial Contract No." <> "Financial Contract No.")
        //           then begin
        //             "Contract Group Code" := '';
        //           end;
        //           ContractDIT.GET(ContractDIT."Contract Type"::Contract,"Financial Contract No.");
        //           //IF purchHeader."Building No." <> '' THEN
        //           //  ContractDIT.TESTFIELD("Building No.",purchHeader."Building No.");
        //           if ("DIT Sub-Contract Type" <> 0) or
        //             ((xRec."DIT Sub-Contract Type" <> 0) and ("DIT Sub-Contract Type" = 0) and
        //             (xRec."Financial Contract No." = "Financial Contract No."))
        //           then
        //             TESTFIELD("DIT Sub-Contract Type",ContractDIT."DIT Sub-Contract Type")
        //           else
        //             "DIT Sub-Contract Type" := ContractDIT."DIT Sub-Contract Type";
        //           if ("Contract Group Code" <> '') or
        //             ((xRec."Contract Group Code" <> '') and ("Contract Group Code" = '') and
        //             (xRec."Financial Contract No." = "Financial Contract No."))
        //           then
        //             TESTFIELD("Contract Group Code",ContractDIT."Contract Group Code")
        //           else
        //             "Contract Group Code" := ContractDIT."Contract Group Code";
        //         end else begin
        //           //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           CLEAR("Contract Type");
        //           //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           CLEAR("Contract Group Code");
        //         end;

        //         CreateDim(
        //           DimMgt.TypeToTableID2034932(2,"Contract Type"),"Financial Contract No.",
        //           // <<DITW16.00.00.42 DDR 13/12/2012 DIT-715 #522
        //           //DATABASE::Vendor,"Pay-to Vendor No.",
        //           DATABASE::Vendor,GetVendNoCalcDim(),
        //           // >>DITW16.00.00.42 DDR DIT-715 #522
        //           DATABASE::"Salesperson/Purchaser","Purchaser Code",
        //           DATABASE::Campaign,"Campaign No.",
        //           DATABASE::"Responsibility Center","Responsibility Center",
        //           //<<DITW110.00.10 MSF 15/06/2017 NRQ#13382
        //           DATABASE::Customer,"Linked Customer No.");
        //           //>>DITW110.00.10 MSF 15/06/2017 NRQ#13382
        //         // >>DITW16.00.00.41 AHU DIT-715 #327
        //     end;
        // }
        // field(2014410;"Physical Location Group Code";Code[10])
        // {
        //     CaptionML = ENU='Physical Location Group Code',
        //                 FRA='Code groupe magasin réel';
        //     Description = 'DITW18.00.06 DIT-770 #1191';
        //     TableRelation = "Physical Location Group" WHERE (Code=FIELD("Phys. Location Table Filter"));

        //     trigger OnValidate();
        //     var
        //         PhysLocationGr : Record "Physical Location Group";
        //     begin
        //         // <<DITW18.00.06 DDR 19/02/2015 DIT-770 #1191
        //         //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975
        //         TestOpenStatus;
        //         //TESTFIELD(Status,Status::Open);
        //         //>> DITW18.00.07 VSC  DIT-770 #1975
        //         // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1191
        //         if ("Responsibility Center" = xRec."Responsibility Center") and
        //           ("Physical Location Group Code" <> xRec."Physical Location Group Code") and
        //           ("Physical Location Group Code" <> '')
        //         then
        //           VALIDATE("Responsibility Center",UserSetupMgt.GetFirstRespCenter(1,"Physical Location Group Code",''));
        //         // >>DITW18.00.06 DDR DIT-770 #1191

        //         if not UserSetupMgt.CheckPhysLocation(1,"Physical Location Group Code","Responsibility Center") then
        //           ERROR(
        //             Text2014412,
        //             PhysLocationGr.TABLECAPTION,"Physical Location Group Code",
        //             RespCenter.TABLECAPTION,UserSetupMgt.GetPurchasesFilter);

        //         if (xRec."Physical Location Group Code" <> "Physical Location Group Code") then begin
        //           CLEAR(Location);
        //           if "Location Code" <> '' then
        //             Location.GET("Location Code");
        //           if (Location."Physical Location Group Code" <> "Physical Location Group Code") then begin
        //             if ((CurrFieldNo <> FIELDNO("Location Code")) and (xRec."Responsibility Center" = "Responsibility Center")) then
        //               VALIDATE("Location Code",'')
        //             else
        //               "Location Code" := '';
        //           end;

        //           // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1191
        //           if (CurrFieldNo <> 0) and (CurrFieldNo <> FIELDNO("Responsibility Center")) and PurchLinesExist then begin
        //           // >>DITW18.00.06 DDR DIT-770 #1191
        //             // HasBeenShowText2014410 = HasBeenShowText2014413
        //             InitHasBeenShow(HasBeenShowText2014410,FIELDCAPTION("Physical Location Group Code"),0);
        //             if HideValidationDialog or not GUIALLOWED or HasBeenShowText2014410 then
        //               Confirmed := true
        //             else
        //               Confirmed :=
        //                 CONFIRM(
        //                   Text2014413 +
        //                   Text004,false,FIELDCAPTION("Physical Location Group Code"));
        //             HasBeenShowText2014410 := Confirmed;
        //           end;
        //           if Confirmed then
        //             UpdatePurchLines(FIELDCAPTION("Physical Location Group Code"),CurrFieldNo <> 0);
        //         end;
        //         //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         UpdateWhseRequestLines(FIELDCAPTION("Physical Location Group Code"));
        //         //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //     end;
        // }
        // field(2014411;"Creation Date/Time";DateTime)
        // {
        //     CaptionML = ENU='Creation Date/Time',
        //                 FRA='Date/Heure Création';
        //     Description = 'DITW18.00.07 DIT-770 #1282';
        //     Editable = false;
        // }
        // field(2014412;"Created By";Code[50])
        // {
        //     CaptionML = ENU='Created By',
        //                 FRA='Créé par';
        //     Description = 'DITW18.00.07 DIT-770 #1282';
        //     Editable = false;
        //     TableRelation = "User Setup";
        // }
        // field(2014420;"Sundry Vendor";Boolean)
        // {
        //     CaptionML = ENU='Sundry Vendor',
        //                 FRA='Fournisseur Divers';
        //     Description = 'DITW18.00.07 DIT-770 #1804';
        // }
        // field(2014421;"Document Subtype Code";Code[10])
        // {
        //     CaptionML = ENU='Document Subtype Code',
        //                 FRA='Code Sous-Type Document';
        //     Description = 'DITW18.00.07 DIT-770 #1508-NRQ#83542';
        //     TableRelation = "Document Subtype Code".Code WHERE ("Report Selection Type"=CONST(Purchase));

        //     trigger OnValidate();
        //     var
        //         DocumentSubtypeCode : Record "Document Subtype Code";
        //         PostingNoSeries : Code[20];
        //     begin
        //         //<<DITW111.00.13 MSF 04/09/2018 NRQ#83542-DITW111.00.13 MSF 05/09/2018 NRQ#83542
        //         if xRec."Document Subtype Code" <> Rec."Document Subtype Code" then begin
        //           if Rec."Document Subtype Code" <> '' then begin
        //             TESTFIELD("Posting No.",'');
        //             PostingNoSeries := DocumentSubtypeCode.GetPostedSerialNoforDocumentSubtype("Document Type","Document Subtype Code");
        //             if PostingNoSeries <> '' then
        //               "Posting No. Series" := PostingNoSeries
        //             else
        //               SetDefaultPostingSerialno;
        //           end else
        //             SetDefaultPostingSerialno;
        //         end;
        //         //>>DITW111.00.13 MSF 04/09/2018 NRQ#83542-DITW111.00.13 MSF 05/09/2018 NRQ#83542
        //     end;
        // }
        // field(2014426;"Service Order No.";Code[20])
        // {
        //     CaptionML = ENU='Service Order No.',
        //                 FRA='N° commande de service';
        //     Description = 'DITW15.00.00.39 #1403 - DIT-715 #297';
        //     Editable = false;
        //     TableRelation = "Service Header"."No." WHERE ("Document Type"=CONST(Order));
        // }
        // field(2014430;"Requester ID";Code[50])
        // {
        //     CaptionML = ENU='Requester ID',
        //                 FRA='ID demandeur';
        //     Description = 'DITW17.00.02 DIT-770 #144';
        //     TableRelation = "User Setup";
        // }
        // field(2014460;"Tax Office Code";Code[10])
        // {
        //     CaptionML = ENU='Tax Office Code',
        //                 FRA='Code Bureau de taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Office";
        // }
        // field(2014495;"Delivery Sequence";Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU='Delivery Sequence',
        //                 FRA='Séquence de livraison';
        //     Description = 'DITW16.00.00.40 #1002';
        //     MinValue = 0;
        // }
        // field(2014500;"Resp. Center Table Filter";Code[10])
        // {
        //     CaptionML = ENU='Resp. Center Table Filter',
        //                 FRA='Filtre Centre de gestion (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1191';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Responsibility Center";
        // }
        // field(2014501;"Phys. Location Table Filter";Code[10])
        // {
        //     CaptionML = ENU='Phys. Location Table Filter',
        //                 FRA='Filtre groupe magasin réel (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1191';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014502;"Location Table Filter";Code[10])
        // {
        //     CaptionML = ENU='Location Table Filter',
        //                 FRA='Filtre Magasin (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1191';
        //     FieldClass = FlowFilter;
        //     TableRelation = Location;
        // }
        // field(2014503;"Resp. Center Table Filter 2";Code[10])
        // {
        //     CaptionML = ENU='Resp. Center Table Filter',
        //                 FRA='Filtre Centre de gestion (table)';
        //     Description = ' DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Responsibility Center";
        // }
        // field(2017760;"Disable DIT Disc. Prom.";Option)
        // {
        //     Caption = 'Disable DIT Discount Promotion';
        //     Description = 'DITW111.00.13A MSF 09/05/2019 NRQ#109271';
        //     OptionCaption = '" ,Discount,Promotion,All"';
        //     OptionMembers = " ",Discount,Promotion,All;

        //     trigger OnValidate();
        //     begin
        //         PurchLine.RESET;
        //         PurchLine.SETRANGE("Document Type","Document Type");
        //         PurchLine.SETRANGE("Document No.","No.");
        //         PurchLine.SETRANGE(Type,PurchLine.Type::Item);
        //         PurchLine.MODIFYALL("Disable DIT Disc. Prom.","Disable DIT Disc. Prom.");
        //     end;
        // }
        // field(2029611;"Doc. Amount Incl. VAT";Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Doc. Amount Incl. VAT',
        //                 FRA='Montant doc. TTC';
        //     Description = 'FINXL7.00.001';

        //     trigger OnValidate();
        //     begin
        //         //<<FINXL7.00.001 RBE 06/08/2013
        //         if recFINXLSetup.READPERMISSION then begin
        //           if "Document Type" in ["Document Type"::Invoice,"Document Type"::"Credit Memo"] then begin
        //             PurchLine.RESET;
        //             PurchLine.SETRANGE("Document Type","Document Type");
        //             PurchLine.SETRANGE("Document No.","No.");
        //             if not PurchLine.FIND('-') then begin
        //               PurchLine.SETFILTER(Type,'<>%1',PurchLine.Type::" ");
        //             end;
        //             if PurchLine.FIND('-') then
        //               if PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Normal VAT" then begin
        //                 if "Currency Code" = '' then
        //                   Currency.InitRoundingPrecision
        //                 else begin
        //                   Currency.GET("Currency Code");
        //                   Currency.TESTFIELD("Amount Rounding Precision");
        //                 end;
        //                 DocBaseAmount :=
        //                   ROUND(
        //                     "Doc. Amount Incl. VAT" / (1 + (1 - "VAT Base Discount %" / 100) * PurchLine."VAT %" / 100),
        //                     Currency."Amount Rounding Precision");
        //                 "Doc. Amount VAT" :=
        //                   ROUND(
        //                     DocBaseAmount * (1 - "VAT Base Discount %" / 100) * PurchLine."VAT %" / 100,
        //                     Currency."Amount Rounding Precision");
        //               end else
        //                 DocBaseAmount := "Doc. Amount Incl. VAT";
        //           end;
        //         end;
        //         //>>FINXL7.00.001 RBE 06/08/2013
        //     end;
        // }
        // field(2029612;"Doc. Amount VAT";Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Doc. Amount VAT',
        //                 FRA='Montant TVA doc.';
        //     Description = 'FINXL7.00.001';

        //     trigger OnValidate();
        //     var
        //         Sign : Decimal;
        //     begin
        //         //<<FINXL7.00.001 RBE 06/08/2013
        //         //<< DITW19.00.08 VSC 05/12/2016 BL#9711 (DIT-770 #1921)
        //         if recFINXLSetup.READPERMISSION then begin
        //           if "Document Type" in ["Document Type"::Invoice,"Document Type"::"Credit Memo"] then begin
        //             if ("Doc. Amount Incl. VAT" < 0) then
        //               Sign := -1
        //             else
        //               Sign := 1;


        //             if ("Doc. Amount VAT" * Sign) > ("Doc. Amount Incl. VAT" * Sign) then
        //               ERROR(Text2029610,
        //                     FIELDCAPTION("Doc. Amount VAT"),
        //                     FIELDCAPTION("Doc. Amount Incl. VAT"));
        //           end;
        //         end;
        //         //>> DITW19.00.08 VSC BL#9711 (DIT-770 #1921)
        //         //>>FINXL7.00.001 RBE 06/08/2013
        //     end;
        // }
        // field(2029613;"Approved Amount";Decimal)
        // {
        //     CaptionML = ENU='Approved Amount',
        //                 FRA='Montant Approuvé';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029614;"Emergency Order";Boolean)
        // {
        //     CaptionML = ENU='Emergency',
        //                 FRA='Urgence';
        //     Description = 'FINXL8.00.001';
        // }
        // field(2029615;"Last changed User ID";Code[50])
        // {
        //     CaptionML = ENU='Last changed User ID',
        //                 FRA='Derniére Modification Utilisateur';
        //     Description = 'FINXL8.00.001';
        //     TableRelation = User."User Name";
        // }
        // field(2029616;"Last changed Date/time";DateTime)
        // {
        //     CaptionML = ENU='Last changed Date/time',
        //                 FRA='Date/Heure Derniére Modification';
        //     Description = 'FINXL8.00.001';
        // }
        // field(2029617;OGM;Text[30])
        // {
        //     CaptionML = ENU='OGM',
        //                 FRA='OGM';
        //     Description = 'FINXL8.00.001';
        // }
        // field(2034850;"DIT Sub-Contract Type";Option)
        // {
        //     CaptionML = ENU='Sub Contract Type',
        //                 FRA='Sous type contrat';
        //     Description = 'DIT-715 #392';
        //     OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA=' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;

        //     trigger OnValidate();
        //     begin
        //         //<<DITW17.10.05 MSF 16/07/2014 DIT-770 #690
        //         if rPropertyPurchServMgtSetup.READPERMISSION then begin
        //         //>>DITW17.10.05 MSF 16/07/2014 DIT-770 #690
        //           // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        //           if (xRec."DIT Sub-Contract Type" <> "DIT Sub-Contract Type") and
        //             (CurrFieldNo = FIELDNO("DIT Sub-Contract Type")) and
        //             //<<DITW17.10.03 TEC1 05/02/2014 DIT-770 #340
        //             ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ")
        //             //>>DITW17.10.03 TEC1 DIT-770 #340
        //           then begin
        //             VALIDATE("Contract Group Code",'');
        //           //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //             case "Contract Type" of
        //               "Contract Type"::Service :
        //                 VALIDATE("Service Contract No.",'');
        //               "Contract Type"::Financial :
        //               VALIDATE("Financial Contract No.",'');
        //             end;
        //           //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //           end;
        //           //<<DITW17.10.03 TEC1 05/02/2014 DIT-770 #340
        //           if ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") then
        //           begin
        //             BuyfromVendor.GET("Buy-from Vendor No.");
        //             "Vendor Posting Group" := BuyfromVendor."Vendor Posting Group";
        //           end;
        //           //>>DITW17.10.03 TEC1 DIT-770 #340
        //         end; //DITW17.10.05 MSF 16/07/2014 DIT-770 #690
        //     end;
        // }
        // field(2034872;"Contract Group Code";Code[10])
        // {
        //     CaptionML = ENU='Contract Group Code',
        //                 FRA='Code groupe contrat';
        //     Description = 'DIT-715 #392';
        //     TableRelation = IF ("Contract Type"=CONST(Service)) "Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"))
        //                     else IF ("Contract Type"=CONST(Financial)) "Financial Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        //         //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //         TestOpenStatus;
        //         //TESTFIELD(Status,Status::Open);
        //         //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159

        //         if "Contract Group Code" <> '' then begin
        //           if ("Contract Group Code" <> xRec."Contract Group Code") and
        //              (xRec."Sell-to Customer No." = "Sell-to Customer No.")
        //           then
        //             MessageIfPurchLinesExist(FIELDCAPTION("Contract Group Code"));

        //             case "Contract Type" of
        //               "Contract Type"::Service:
        //                 begin
        //                  if ContractGroup.Code <> "Contract Group Code" then
        //                    ContractGroup.GET("Contract Group Code");
        //                  "DIT Sub-Contract Type" := ContractGroup."DIT Sub-Contract Type";
        //                 end;
        //               "Contract Type"::Financial:
        //                 begin
        //                  if ContractGroupDIT.Code <> "Contract Group Code" then
        //                    ContractGroupDIT.GET("Contract Group Code");
        //                  "DIT Sub-Contract Type" := ContractGroupDIT."DIT Sub-Contract Type";
        //                 end;
        //             end;
        //         end else begin
        //           CLEAR(ContractGroup);
        //           CLEAR(ContractGroupDIT);
        //         end;
        //         if "Service Contract No." <> '' then
        //           VALIDATE("Service Contract No.");
        //         //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //         if "Financial Contract No." <> '' then
        //           VALIDATE("Financial Contract No.");
        //         //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //     end;
        // }
        // field(2034915;"Service Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Service Contract No.',
        //                 FRA='N° contrat de service';
        //     Description = 'DIT-715 #392 - DITW18.00.06 DIT-770 #1368';
        //     TableRelation = IF ("DIT Sub-Contract Type"=CONST(" ")) "Service Purch. Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract))
        //                     else IF ("DIT Sub-Contract Type"=FILTER(<>" ")) "Service Purch. Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                                                                            "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));

        //     trigger OnValidate();
        //     var
        //         FA2 : Record "Fixed Asset";
        //     begin
        //         // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        //         //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1975 -> #159
        //         TestOpenStatus;
        //         //TESTFIELD(Status,Status::Open);
        //         //>> DITW18.00.07 VSC  DIT-770 #1975 -> #159

        //         if "Service Contract No." <> '' then begin
        //           //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           "Contract Type" := "Contract Type"::Service;
        //           TESTFIELD("Financial Contract No.",'');
        //           //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           if ("Service Contract No." <> xRec."Service Contract No.") and
        //              (xRec."Sell-to Customer No." = "Sell-to Customer No.")
        //           then
        //             MessageIfPurchLinesExist(FIELDCAPTION("Service Contract No."));

        //           if (CurrFieldNo = FIELDNO("Service Contract No.")) and
        //             (xRec."Service Contract No." <> "Service Contract No.")
        //           then begin
        //             "Contract Group Code" := '';
        //           end;
        //           ServContract.GET(ServContract."Contract Type"::Contract,"Service Contract No.");
        //           if ("DIT Sub-Contract Type" <> 0) or
        //             ((xRec."DIT Sub-Contract Type" <> 0) and ("DIT Sub-Contract Type" = 0) and
        //             (xRec."Service Contract No." = "Service Contract No."))
        //           then
        //             TESTFIELD("DIT Sub-Contract Type",ServContract."DIT Sub-Contract Type")
        //           else
        //             "DIT Sub-Contract Type" := ServContract."DIT Sub-Contract Type";
        //           if ("Contract Group Code" <> '') or
        //             ((xRec."Contract Group Code" <> '') and ("Contract Group Code" = '') and
        //             (xRec."Service Contract No." = "Service Contract No."))
        //           then
        //             TESTFIELD("Contract Group Code",ServContract."Contract Group Code")
        //           else
        //             "Contract Group Code" := ServContract."Contract Group Code";
        //         end else begin
        //           //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           CLEAR("Contract Type");
        //           //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           CLEAR("Contract Group Code");
        //         end;

        //         CreateDim(
        //           DimMgt.TypeToTableID2034932(2,"Contract Type"),"Service Contract No.",
        //           // <<DITW16.00.00.42 DDR 13/12/2012 DIT-715 #522
        //           //DATABASE::Vendor,"Pay-to Vendor No.",
        //           DATABASE::Vendor,GetVendNoCalcDim(),
        //           // >>DITW16.00.00.42 DDR DIT-715 #522
        //           DATABASE::"Salesperson/Purchaser","Purchaser Code",
        //           DATABASE::Campaign,"Campaign No.",
        //           DATABASE::"Responsibility Center","Responsibility Center",
        //           //<<DITW110.00.10 MSF 15/06/2017 NRQ#13382
        //           DATABASE::Customer,"Linked Customer No.");
        //           //>>DITW110.00.10 MSF 15/06/2017 NRQ#13382
        //         // >>DITW16.00.00.41 AHU DIT-715 #327
        //     end;
        // }
        // field(2035390;"Linked Customer No.";Code[20])
        // {
        //     CaptionML = ENU='Linked Customer No.',
        //                 FRA='N° Cilent Lié';
        //     Description = 'DITW17.00.02 DIT-770 #153';
        //     TableRelation = Customer."No.";

        //     trigger OnValidate();
        //     begin
        //         //<<DITW17.00.02 SR 12/09/2013 DIT-770 #153
        //         ///DITW17.00.02 DDR 16/01/2014 DIT-770 #322-DITW110.00.10 MSF 15/06/2017 NRQ#13382
        //          CreateDim(
        //             DATABASE::Customer,"Linked Customer No.",
        //             //<<DITW110.00.10 MSF 15/06/2017 NRQ#13382
        //             DATABASE::Vendor,GetVendNoCalcDim(),
        //             //>>DITW110.00.10 MSF 15/06/2017 NRQ#13382
        //             DATABASE::"Salesperson/Purchaser","Purchaser Code",
        //             DATABASE::Campaign,"Campaign No.",
        //             DATABASE::"Responsibility Center","Responsibility Center",
        //           //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //             DimMgt.TypeToTableID2034932(2,"Contract Type"),GetContractNo());
        //           //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //           if (xRec."Linked Customer No." <> "Linked Customer No.") then
        //             RecreatePurchLines(FIELDCAPTION("Linked Customer No."))
        //         //>>DITW17.00.02 SR DIT-770 #153
        //     end;
        // }
        // field(2035393;"Contract Type";Option)
        // {
        //     CaptionML = ENU='Contract Type',
        //                 FRA='Type contrat';
        //     Description = 'DIT-715 #392 - DIT-770 #690 - DIT-770 #1368';
        //     OptionCaptionML = ENU=' ,Service,Financial',
        //                       FRA=' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        //         //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //         if rPropertyPurchServMgtSetup.READPERMISSION or
        //            ContractDIT.READPERMISSION
        //         then begin
        //         //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           "Contract Group Code" := '';
        //           //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           if "Service Contract No." <> '' then
        //             VALIDATE("Service Contract No.",'');
        //           if "Financial Contract No." <> '' then
        //             VALIDATE("Financial Contract No.",'');
        //           //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //         end;
        //     end;
        // }
        // field(2036301;"Valid Until";Date)
        // {
        //     CaptionML = ENU='Valid Until',
        //                 FRA='Valide jusqu''au';
        //     Description = 'MANXL7.00.001';

        //     trigger OnValidate();
        //     begin
        //         //<<MANXL7.00.001 DAT 05/03/2014 #17
        //         if (xRec."Valid Until" <> "Valid Until") and ("Document Type" = "Document Type"::"Blanket Order") then begin
        //           if ("Document Date" > "Valid Until") and ("Document Date" <> 0D) then
        //             ERROR(err2036301,FIELDCAPTION("Document Date"),"Document Date",FIELDCAPTION("Valid Until"),"Valid Until");
        //           RecreatePurchLines(FIELDCAPTION("Valid Until"));
        //         end;
        //         //>>MANXL7.00.001 DAT 05/03/2014 #17
        //     end;
        // }
        //BC UPGRADE SHARMP16 end<< //drink-it fields
    }
    keys
    {
        //BC UPGRADE SHARMP16 keys commented Drink-IT fields used begin<<
        // key(Key1; "Link Purch. Document Type", "Link Purch. Document No.")
        // {
        // }
        // key(Key2; "Shipping Agent Service Code", "Shipping Agent Code", "Location Code")
        // {
        // }
        // key(Key3; "Service Order No.")
        // {
        // }
        // key(Key4; "Document Type", "Document Date", "Valid Until")
        // {
        // }
        //BC UPGRADE SHARMP16 keys commented Drink-IT fields used end<<
        // key(Key10; "Document Type", Status, "Pay-to Vendor No.") //BC Version 28.0 Compatibility Fix
        // {
        // }
        key(Key51000; "Document Type", Status, "Pay-to Vendor No.") //BC Version 28.0 Compatibility Fix
        {
        }
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: EmcsCommentLine)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: DocSubTypeCode)();
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
    IF NOT UserSetupMgt.CheckRespCenter(1,"Responsibility Center") THEN
      ERROR(
        Text023,
        RespCenter.TABLECAPTION,UserSetupMgt.GetPurchasesFilter);

    PostPurchDelete.DeleteHeader(
      Rec,PurchRcptHeader,PurchInvHeader,PurchCrMemoHeader,
      ReturnShptHeader,PurchInvHeaderPrepmt,PurchCrMemoHeaderPrepmt);

    ArchiveManagement.AutoArchivePurchDocument(Rec);

    VALIDATE("Applies-to ID",'');
    VALIDATE("Incoming Document Entry No.",0);

    ApprovalsMgmt.DeleteApprovalEntries(RECORDID);
    PurchLine.LOCKTABLE;

    WhseRequest.SETRANGE("Source Type",DATABASE::"Purchase Line");
    WhseRequest.SETRANGE("Source Subtype","Document Type");
    WhseRequest.SETRANGE("Source No.","No.");
    WhseRequest.DELETEALL(TRUE);

    PurchLine.SETRANGE("Document Type","Document Type");
    PurchLine.SETRANGE("Document No.","No.");
    #25..30
    PurchCommentLine.SETRANGE("No.","No.");
    PurchCommentLine.DELETEALL;

    IF (PurchRcptHeader."No." <> '') OR
       (PurchInvHeader."No." <> '') OR
       (PurchCrMemoHeader."No." <> '') OR
       (ReturnShptHeader."No." <> '') OR
       (PurchInvHeaderPrepmt."No." <> '') OR
       (PurchCrMemoHeaderPrepmt."No." <> '')
    THEN
      MESSAGE(PostedDocsToPrintCreatedMsg);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if not UserSetupMgt.CheckRespCenter(1,"Responsibility Center") then
    #2..7
      ReturnShptHeader,PurchInvHeaderPrepmt,PurchCrMemoHeaderPrepmt,
      // <<DITW110.00.08 DDR 02/01/2017 NRQ#0
      SecPurchInvHeader,SecPurchCrMemoHeader);
      // >>DITW110.00.08 DDR NRQ#0

    //<<HEI.20
    //HEI.20 comment line ArchiveManagement.AutoArchivePurchDocument(Rec);
    PurchSetup.GET;
    if PurchSetup."Auto.Arch.Deleted Inv&CrMemos" and ("Document Type" in ["Document Type"::Invoice, "Document Type"::"Credit Memo"]) then begin
      if ("Document Subtype Code" = PurchSetup."PO Subtype Code") or  ("Document Subtype Code" = PurchSetup."NPO Subtype Code") or
         ("Document Subtype Code" = PurchSetup."Expense Claim Subdocument Type") or ("Document Subtype Code" = PurchSetup."Expense Claim CM Subdoc Type") then begin

        ArchiveManagement.AutoArchivePurchDocument(Rec);
        end;
      end;
    //>>HEI.20
    #11..15

    // <<DITW16.00.00.40 DDR 11/06/2012 DIT-715 #313
    DiscPromoPostLine.ReopenFromPurchHeader(Rec);
    // >>DITW16.00.00.40 DDR DIT-715 #313

    #16..20
    WhseRequest.DELETEALL(true);

    //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
    if RoutePlanRqst.READPERMISSION then begin
      RoutePlanRqst.SETRANGE("Source Type",DATABASE::"Purchase Header");
      RoutePlanRqst.SETRANGE("Source Subtype","Document Type");
      RoutePlanRqst.SETRANGE("Source No.","No.");
      //doesn't work if need "skip" flag parameter
      //RoutePlanRqst.DELETEALL(TRUE);
      if RoutePlanRqst.findset then
        repeat
          RoutePlanRqst2.SetSkipValidationDocument(true);
          RoutePlanRqst2 := RoutePlanRqst;
          RoutePlanRqst2.DELETE(true);
        until RoutePlanRqst.NEXT = 0;
    end;
    //>> DITW18.00.07 VSC DIT-770 #1984 - #1981-> DIT-770 #1488
    #22..33
    // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
    EmcsCommentLine.SETRANGE("Table ID",DATABASE::"Purchase Header");
    EmcsCommentLine.SETRANGE("Document Type","Document Type");
    EmcsCommentLine.SETRANGE("Document No.","No.");
    EmcsCommentLine.DELETEALL;
    // >>DITW16.00.00.40 DDR DIT-715 #187

    //<< DITW18.00.07 VSC 07/03/2016 DIT-770 #1066
    DocumentShippingCost.RESET;
    DocumentShippingCost.SETRANGE("Source Type",DATABASE::"Purchase Header");
    DocumentShippingCost.SETRANGE("Source No.","No.");
    DocumentShippingCost.SETRANGE("Sub Type","Document Type");
    DocumentShippingCost.DELETEALL;
    //>> DITW18.00.07 VSC DIT-770 #1066

    // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860 - DITW18.00.07 DDR 14/04/2016 DIT-770 #1109
    ClearHasBeenShowAll;
    // >>DITW16.00.00.43 DDR DIT-715 #860 - DITW18.00.07 DDR DIT-770 #1109

    if (PurchRcptHeader."No." <> '') or
       (PurchInvHeader."No." <> '') or
       (PurchCrMemoHeader."No." <> '') or
       (ReturnShptHeader."No." <> '') or
       (PurchInvHeaderPrepmt."No." <> '') or
       (PurchCrMemoHeaderPrepmt."No." <> '') or
       // <<DITW110.00.08 DDR 02/01/2017 NRQ#0
       (SecPurchInvHeader."No." <> '') or
       (SecPurchCrMemoHeader."No." <> '')
       // >>DITW110.00.08 DDR NRQ#0
    then
      //>>HEI.50
      if GUIALLOWED then
      //<<HEI.50
        MESSAGE(PostedDocsToPrintCreatedMsg);
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInsert". Please convert manually.

    //trigger (Variable: HideDialog)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT SkipInitialization THEN
      InitInsert;

    IF GETFILTER("Buy-from Vendor No.") <> '' THEN
      IF GETRANGEMIN("Buy-from Vendor No.") = GETRANGEMAX("Buy-from Vendor No.") THEN
        VALIDATE("Buy-from Vendor No.",GETRANGEMIN("Buy-from Vendor No."));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if not SkipInitialization then
      InitInsert;

    // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860 - DITW18.00.07 DDR 14/04/2016 DIT-770 #1109
    ClearHasBeenShowAll;
    // >>DITW16.00.00.43 DDR DIT-715 #860 - DITW18.00.07 DDR DIT-770 #1109

    if GETFILTER("Buy-from Vendor No.") <> '' then
      if GETRANGEMIN("Buy-from Vendor No.") = GETRANGEMAX("Buy-from Vendor No.") then
        VALIDATE("Buy-from Vendor No.",GETRANGEMIN("Buy-from Vendor No."));

    //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144
    //>> HEI.49
    if PurchSetup."Requester ID Mandatory" then begin
      //IF "Requester ID" = CREATEGUID THEN
      if not GUIALLOWED then
        "Requester ID" := '';

        //"Requester ID" := USERID()
         "Requester ID" := '';
    end else
    //IF "Requester ID" = '' THEN
      //"Requester ID" := USERID();
      "Requester ID" := USERID();
    //>> HEI.49
    //>>DITW17.00.02 TEC1 DIT-770 #144

    /// DITW17.10.05 MSF 12/03/2015 DIT-770 DIT-770 1149
    /// DITW19.00.08 VSC 18/11/2016 BL#10351
    //<<FINXL9.00.001 ACH 11/08/2016
    if recFINXLSetup.READPERMISSION then begin
      lcduPurchaseHook.fctOnInsertPurchasesHeader(Rec,false);
      lcduPurchaseHook.fctUpdateOnInsertPurchHeader(Rec);
      end;
    //>>FINXL9.00.001 ACH 11/08/2016
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateVendorAddress;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860 - DITW18.00.07 DDR 14/04/2016 DIT-770 #1109
    ClearHasBeenShowAll;
    // >>DITW16.00.00.43 DDR DIT-715 #860 - DITW18.00.07 DDR DIT-770 #1109
    //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1984 - #1981 -> DIT-770 #1488
    UpdateRoutePlanRqstLines('');
    //<< DITW18.00.07 VSC DIT-770 #1984 - #1981 -> DIT-770 #1488
    //<<FINXL8.00.001 BSA 10/06/2015 #85
    if recFINXLSetup.READPERMISSION then begin
      "Last changed User ID" := USERID;
      "Last changed Date/time" := CURRENTDATETIME;
    end;
    //>>FINXL8.00.001 BSA 10/06/2015 #85
    UpdateVendorAddress;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    // var
    //     BuyFromVend : Record Vendor;
    //     VendLocationCode : Code[10];
    //     recStdVendPurchaseCode : Record "Standard Vendor Purchase Code";

    // var
    //     OrderAddr : Record "Order Address";

    // var
    //     VendLocationCode : Code[10];

    // var
    //     TempDate : Date;

    // var
    //     HasLineChargeIncludePrice : Boolean;

    // var
    //     Vend2 : Record Vendor;
    //     Vend3 : Record Vendor;

    // var
    //     SkipJobCurrFactorUpdate : Boolean;

    // var
    //     VendorBankAccount : Record "Vendor Bank Account";
    //     BankAccount : Record "Bank Account";

    // var
    //     LocationCode : Code[10];

    // var
    //     EmcsCommentLine : Record "EMCS Comment Line";
    //     DocumentShippingCost : Record "Document Shipping Cost";
    //     RoutePlanRqst2 : Record "Route Planning Request";

    // var
    //     DocSubTypeCode : Record "Document Subtype Code";

    // var
    //     HideDialog : Boolean;
    //     lcduPurchaseHook : Codeunit "Purchase Hook";

    // var
    //     DocSubtypeCodeSetup : Record "Doc Subtype Code Setup FND";

    // var
    //     lrPurchLine : Record "Purchase Line";
    //     lrPurchLineTmp : Record "Purchase Line" temporary;
    //     lblnExtendedChargesAdded : Boolean;
    //     lblnIsItemCharge : Boolean;

    // var
    //     lrec_purchlines : Record "Purchase Line";

    // var
    //     PurchasesUtils : Codeunit "Purchases-Utils";

    // var
    //     lrPurchLine : Record "Purchase Line";

    // var
    //     lrPurchLine : Record "Purchase Line";
    //BC Upgrade SHARMP16 BEGIN<< ---IBM GAP STP 48
    trigger OnAfterModify()
    var
        myInt: Integer;
    begin
        "Last changed User ID IBM FND" := USERID;
        "Last changed Date/time IBM FND" := CURRENTDATETIME;
    end;
    // BC Upgrade BHARDA11 >> -- FDD STP 003
    trigger OnBeforeInsert()
    begin
        Rec."Created By IBM FND" := UserId();
        Rec."Creation Date/Time IBM FND" := CurrentDateTime;
    end;
    // BC Upgrade BHARDA11 << -- FDD STP 003
    trigger OnAfterInsert()
    var
        myInt: Integer;
    begin
        //>> HEI.49
        IF PurchSetup."Requester ID Mandatory FND" THEN BEGIN
            //IF "Requester ID" = CREATEGUID THEN
            IF NOT GUIALLOWED THEN
                "Requester ID IBM FND" := '';

            //"Requester ID" := USERID()
            "Requester ID IBM FND" := '';
        END ELSE
            //IF "Requester ID" = '' THEN
            //"Requester ID" := USERID();
            "Requester ID IBM FND" := USERID();
        //>> HEI.49
    end;
    //BC Upgrade SHARMP16 END>> ---IBM GAP STP 48

    var
        BankAccount: Record "Bank Account";
        Currency: Record Currency;
        SaveCurrency: Record Currency;
        FieldTable: Record "Field";
        FirstCalledByField: Record "Integer" temporary;
        Item: Record Item;
        //   rFiscalRep: Record "Fiscal Representative";
        // cduWhseTransport: Codeunit "Warehouse & Transport Mgt.";
        PaymentMethod: Record "Payment Method";
        SecPurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        SecPurchInvHeader: Record "Purch. Inv. Header";
        PurchHdrArch: Record "Purchase Header Archive";
        //  RecRoute: Record Route;
        PurchaseLine: Record "Purchase Line";
        ShippingAgent: Record "Shipping Agent";
        // SSCCSetup: Record "SSCC Setup";
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        recUserSetup: Record "User Setup";
        BuyfromVendor: Record Vendor;
        // rPropertyPurchServMgtSetup: Record "Property Purch Serv Mgt. Setup";
        // recFINXLSetup: Record "Finance XL Setup";
        Vend: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        WhseSetup: Record "Warehouse Setup";
        //  PurchasesUtils: Codeunit "Purchases-Utils";
        HeinekenGlobal: Codeunit "Heineken Global";
        ReservePurchLine: Codeunit "Purch. Line-Reserve";

        UserMgt: Codeunit "User Setup Management";
        // WhseShippingDriver: Record "Whse. Shipping Driver";
        // WhseShippingDriverList: Page "Whse. Shipping Driver List";

        // WhseShippingTruck: Record "Whse. Shipping Truck";
        // WhseShippingTruckList: Page "Whse. Shipping Truck List";
        ShippingAgents: Page "Shipping Agents";
        blnIsworksheetline: Boolean;
        HasBeenShowBuyFrom: Boolean;
        HasBeenShowPayTo: Boolean;
        HasBeenShowText016: Boolean;
        HasBeenShowText020: Boolean;
        HasBeenShowText021: Boolean;
        HasBeenShowText022: Boolean;
        HasBeenShowText032: Boolean;
        HasBeenShowText2013610: Boolean;
        HasBeenShowText2013662: Boolean;
        HasBeenShowText2014096: Boolean;
        HasBeenShowText2014410: Boolean;
        // WhseTransportMgt: Codeunit "Warehouse & Transport Mgt.";
        // DiscPromoPostLine: Codeunit "Purch.Disc. & Promo.-Post Line";
        // ContractGroup: Record "Contract Group";
        // ContractGroupDIT: Record "Financial Contract Group";
        // ServContract: Record "Service Purch. Contract Header";
        // ContractDIT: Record "Financial Contract Header";
        HasRecreatePurchaseLines: Boolean;
        ItemCategoryBool: Boolean;
        StatusCheckSuspended: Boolean;
        DocBaseAmount: Decimal;
        ReasonCodeErr: Label 'You must fill in the Reason Code';
        ShippingAgentVendorIsBlank: Label 'There is no Vendor associated with this Shipping Agent';
        Text50000: Label 'There should be atleast one bank linked to this Vendor.';
        Text50001: Label 'Dimension changes are not allowed in PO Invoices';
        Text2013611: Label 'D';
        Text2013612: Label 'The last character of %1 will truncate to be copied into %2.\';
        Text2014061: Label 'Modification allowed only form Route planning worksheet';
        VendorBlockForShipAgent: Label 'The Vendor associated with this Shipping Agent is blocked';
        err2036301: TextConst ENU = '%1 (%2) cannot be bigger than %3 (%4).', FRA = '%1 (%2) ne peut pas être supérieur à %3 (%4).';
        Text004: TextConst ENU = 'Do you want to change %1?', FRA = 'Souhaitez-vous modifier la valeur du champ %1?';
        Text055: TextConst ENU = '%1  must be filled for item %2', NLB = '%1  moet ingegeven worden voor Artikel %2';
        Text2013610: TextConst ENU = 'If you change %1, the existing purchase deposit charge lines will be deleted and new purchase deposit charge lines based on the new information on the header will be created.\\', FRA = 'Si vous modifiez l''enregistrement %1, les lignes de frais consigne achat existantes seront supprimées et de nouvelles lignes de frais consigne achat seront créées.\\';
        Text2013660: TextConst ENU = 'You have modified the %1 field. Note that the recalculation may cause penny differences, so you must check the amounts afterwards. ', FRA = 'Vous avez modifié le champ %1. Le recalcul va provoquer de petites différences. Veuillez vérifier les montants. ';
        Text2013661: TextConst ENU = 'You must specify %1 in %2 or %3 or %4 when %5 %6.', FRA = 'Vous devez spécifier %1 dans %2 ou %3 ou %4 quand %5 %6.';
        Text2013662: TextConst ENU = 'If you change %1, the existing purchase tax charge lines will be deleted and new purchase tax charge lines based on the new information on the header will be created.\\', FRA = 'Si vous modifiez l''enregistrement %1, les lignes de frais taxe achat existantes seront supprimées et de nouvelles lignes de frais taxe achat seront créées.\\';
        Text2014001: TextConst ENU = 'Do You want to change VAT Bus. Posting Group in the lines? ', FRA = 'Voulez-changer le groupe comptable marché TVA dans les lignes ? ';
        // EMCSEDIMgt: Codeunit "EMCS EDI Mgt";
        // ApplMgt: Codeunit ApplicationManagement;
        // VendBuyfrom: Record Vendor;
        // RoutePlanRqst: Record "Route Planning Request";
        // PurchRequestMgt: Codeunit "Route Purchase-Request Mgt.";
        Text2014096: TextConst ENU = 'Shipment Date does not match the Route Shipment Day. Do you want to Continue?', FRA = 'La date d''expédition ne correspond pas au jour de l''itinéraire d''expédition. Voulez vous continer?';
        Text2014410: TextConst ENU = 'If you change %1, all existing purchase charge lines will be deleted and new purchase charge lines based on the new information on the header will be created.\\', FRA = 'Si vous modifiez l''enregistrement %1, toutes les lignes de frais achat existantes seront supprimées et de nouvelles lignes de frais achat seront créées.\\';
        Text2014412: TextConst ENU = 'You cannot use the %1 %2 because your identification is set up to process from %3 %4 only.', FRA = 'Vous ne pouvez pas utiliser le %1 %2 parce que votre identification est configurée pour traiter de %3 %4 seulement.';
        Text2014413: TextConst ENU = 'If you change %1, all existing will be updated and all sales charge lines will be deleted and new sales charge lines based on the new information on the header will be created.\\', FRA = 'Si vous changez %1, tous les existants seront mis à jour et toutes les lignes de frais de souscription seront supprimés et de nouvelles lignes de frais d''acquisition sur la base de nouvelles informations sur l''en-tête seront créés \\.';
        Text2014414: TextConst ENU = '%1 %2 is assigned to %3 %4 and your identification is not set up to process.\\', FRA = '%1 %2 est affectée à %3 %4 et votre identification ne soit pas mis en place pour traiter. \\';
        Text2014415: TextConst ENU = 'Do you want to continue?', FRA = 'Souhaitez-vous continuer?';
        Text2014416: TextConst ENU = 'The user has been interrupted the process to respect the warning.', FRA = 'L''utilisateur a interrompu le processus pour respecter l''alerte.';
        Text2029610: TextConst ENU = '%1 must no be more than %2.', FRA = '%1 ne doit pas être supérieur à %2.';
        //  recMANXLSetup: Record "Manufacturing XL Setup";
        Text2029612: TextConst ENU = 'The %1 is not filled in the GL setup, do you like to continue?', FRA = '%1 n''est pas remplit dans paramétres comptablité .Voulez-vous continuer ?';
        // SSCCLineReserv: Codeunit "SSCC Line-Reserve";
        Text2035041: TextConst ENU = 'The sales %1 %2 has also SSCC tracking. Do you want to delete it anyway?', FRA = 'La vente %1 %2 a aussi une traçabilité SSCC. Souhaitez-vous quand même la supprimer ?';
        Text2036301: TextConst ENU = 'Purchase %1 %2 already exists for this vendor.', FRA = 'Le document %1 achat %2 existe déjà pour ce fournisseur.';
    //grec_InterfaceSetup: Record "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension 
    //grec_GeneralInterfaceSetup: Record "General Interface Setup";

    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ConfirmChangeQst(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ConfirmChangeQst : @@@="%1 = a Field Caption like Currency Code";ENU=Do you want to change %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ConfirmChangeQst : @@@="%1 = a Field Caption like Currency Code";ENU=Do you want to change %1?;FRA=Souhaitez-vous modifier la valeur du champ %1?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=You cannot reset %1 because the document still has one or more lines.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=You cannot reset %1 because the document still has one or more lines.;FRA=Impossible de réinitialiser %1 car le document contient une ou plusieurs ligne(s).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "YouCannotChangeFieldErr(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //YouCannotChangeFieldErr : @@@=%1 - fieldcaption;ENU=You cannot change %1 because the order is associated with one or more sales orders.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //YouCannotChangeFieldErr : @@@=%1 - fieldcaption;ENU=You cannot change %1 because the order is associated with one or more sales orders.;FRA=Vous ne pouvez pas modifier %1 car la commande est associée à une ou plusieurs commande(s) vente.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=%1 is greater than %2 in the %3 table.\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=%1 is greater than %2 in the %3 table.\;FRA=%1 est supérieur(e) à %2 dans la table %3.\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=Confirm change?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=Confirm change?;FRA=Accepter la modification ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for receipts. An empty receipt %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for receipts. An empty receipt %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des réceptions. Une réception vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text012(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for posted invoices. An empty posted invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for posted invoices. An empty posted invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des factures enregistrées. Une facture enregistrée vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text014(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche d'avoirs enregistrés. Un avoir enregistré vide %1 va être créé pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text016(Variable 1016)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text016 : ENU=If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text016 : ENU=If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\\;FRA=Si vous modifiez l'enregistrement %1, les lignes achat existantes seront supprimées et de nouvelles lignes achat seront créées.\\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text018(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text018 : ENU=You must delete the existing purchase lines before you can change %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text018 : ENU=You must delete the existing purchase lines before you can change %1.;FRA=Vous devez supprimer les lignes achat existantes avant de modifier %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text019(Variable 1018)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text019 : ENU=You have changed %1 on the purchase header, but it has not been changed on the existing purchase lines.\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text019 : ENU=You have changed %1 on the purchase header, but it has not been changed on the existing purchase lines.\;FRA=Vous avez modifié le champ %1 dans l'en-tête achat, mais cela n'a pas été modifié dans les lignes achat existantes.\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text020(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text020 : ENU=You must update the existing purchase lines manually.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text020 : ENU=You must update the existing purchase lines manually.;FRA=Vous devez mettre manuellement à jour les lignes achat existantes.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text021(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text021 : ENU=The change may affect the exchange rate used on the price calculation of the purchase lines.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text021 : ENU=The change may affect the exchange rate used on the price calculation of the purchase lines.;FRA=Cette modification risque d'affecter le taux de change utilisé pour le calcul des prix des lignes achat.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text022(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text022 : ENU=Do you want to update the exchange rate?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text022 : ENU=Do you want to update the exchange rate?;FRA=Souhaitez-vous mettre à jour le taux de change ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text023(Variable 1022)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text023 : ENU=You cannot delete this document. Your identification is set up to process from %1 %2 only.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text023 : ENU=You cannot delete this document. Your identification is set up to process from %1 %2 only.;FRA=Vous ne pouvez pas supprimer ce document. Le paramétrage de votre code utilisateur ne vous permet de travailler que sur %1 %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text025(Variable 1024)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text025 : ENU="You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text025 : ENU="You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. ";FRA="Vous avez modifié le champ %1. Le recalcul de la TVA va provoquer de petites différences. Veuillez vérifier les montants. ";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text027(Variable 1026)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text027 : ENU=Do you want to update the %2 field on the lines to reflect the new value of %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text027 : ENU=Do you want to update the %2 field on the lines to reflect the new value of %1?;FRA=Souhaitez-vous mettre à jour le champ %2 sur les lignes pour refléter la nouvelle valeur de %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text028(Variable 1027)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text028 : ENU=Your identification is set up to process from %1 %2 only.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text028 : ENU=Your identification is set up to process from %1 %2 only.;FRA=Le paramétrage de votre code utilisateur ne vous permet de travailler que sur %1 %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text029(Variable 1028)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text029 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for return shipments. An empty return shipment %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text029 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for return shipments. An empty return shipment %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des expéditions retour. Une expédition retour vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text032(Variable 1031)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text032 : ENU=You have modified %1.\\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text032 : ENU=You have modified %1.\\;FRA=Vous avez modifié le champ %1.\\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text033(Variable 1032)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text033 : ENU=Do you want to update the lines?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text033 : ENU=Do you want to update the lines?;FRA=Souhaitez-vous mettre les lignes à jour ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text034(Variable 1072)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text034 : ENU=You cannot change the %1 when the %2 has been filled in.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text034 : ENU=You cannot change the %1 when the %2 has been filled in.;FRA=Vous ne pouvez pas modifier le champ %1 lorsque le champ %2 a été renseigné.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text037(Variable 1076)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text037 : ENU=Contact %1 %2 is not related to vendor %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text037 : ENU=Contact %1 %2 is not related to vendor %3.;FRA=Le contact %1 %2 n'est pas associé au fournisseur %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text038(Variable 1075)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text038 : ENU=Contact %1 %2 is related to a different company than vendor %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text038 : ENU=Contact %1 %2 is related to a different company than vendor %3.;FRA=Le contact %1 %2 est associé à une société différente de celle du fournisseur %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text039(Variable 1077)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text039 : ENU=Contact %1 %2 is not related to a vendor.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text039 : ENU=Contact %1 %2 is not related to a vendor.;FRA=Le contact %1 %2 n'est pas associé à un fournisseur.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text040(Variable 1079)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text040 : ENU="You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text040 : ENU="You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.";FRA="Vous ne pouvez pas modifier le champ %1 car %2 %3 a %4 = %5 et %6 a déjà été affecté(e) à %7 %8.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text042(Variable 1084)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text042 : ENU=You must cancel the approval process if you wish to change the %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text042 : ENU=You must cancel the approval process if you wish to change the %1.;FRA=Vous devez annuler le processus d'approbation si vous souhaitez modifier le %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text045(Variable 1086)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text045 : ENU=Deleting this document will cause a gap in the number series for prepayment invoices. An empty prepayment invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text045 : ENU=Deleting this document will cause a gap in the number series for prepayment invoices. An empty prepayment invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des factures d'acompte. Une facture d'acompte vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text046(Variable 1087)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text046 : ENU=Deleting this document will cause a gap in the number series for prepayment credit memos. An empty prepayment credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text046 : ENU=Deleting this document will cause a gap in the number series for prepayment credit memos. An empty prepayment credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des avoirs acompte. Un avoir acompte vide %1 va être créé pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text049(Variable 1092)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text049 : ENU=%1 is set up to process from %2 %3 only.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text049 : ENU=%1 is set up to process from %2 %3 only.;FRA=%1 est paramétré pour traiter uniquement à partir de %2 %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text050(Variable 1067)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text050 : ENU=Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text050 : ENU=Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.\\Do you want to continue?;FRA=Il existe des réservations pour cette commande. Ces réservations seront annulées si cette modification entraîne un conflit de dates.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text051(Variable 1025)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text051 : ENU=You may have changed a dimension.\\Do you want to update the lines?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text051 : ENU=You may have changed a dimension.\\Do you want to update the lines?;FRA=Vous avez probablement modifié un axe analytique.\\Souhaitez-vous mettre à jour les lignes ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text052(Variable 1091)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text052 : ENU=The %1 field on the purchase order %2 must be the same as on sales order %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text052 : ENU=The %1 field on the purchase order %2 must be the same as on sales order %3.;FRA=Le champ %1 sur la commande achat %2 doit être identique à celui de la commande vente %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text053(Variable 1095)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text053 : ENU=There are unposted prepayment amounts on the document of type %1 with the number %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text053 : ENU=There are unposted prepayment amounts on the document of type %1 with the number %2.;FRA=Il existe des montants acompte non validés sur le document de type %1 portant le numéro %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text054(Variable 1096)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text054 : ENU=There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text054 : ENU=There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.;FRA=Il existe des factures d'acompte impayées liées au document de type %1 portant le numéro %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DeferralLineQst(Variable 1055)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DeferralLineQst : @@@="%1=The posting date on the document.";ENU=You have changed the %1 on the purchase header, do you want to update the deferral schedules for the lines with this date?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DeferralLineQst : @@@="%1=The posting date on the document.";ENU=You have changed the %1 on the purchase header, do you want to update the deferral schedules for the lines with this date?;FRA=Vous avez modifié la %1 sur l'en-tête achat, voulez-vous mettre à jour les tableaux d'échelonnement pour les lignes en remplaçant la date par celle-ci ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ChangeCurrencyQst(Variable 1073)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ChangeCurrencyQst : ENU=If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created. You may need to update the price information manually.\\Do you want to change %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ChangeCurrencyQst : ENU=If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created. You may need to update the price information manually.\\Do you want to change %1?;FRA=Si vous modifiez %1, les lignes achat existantes seront supprimées et de nouvelles lignes achat basées sur les nouvelles informations de l'en-tête seront créées. Vous devrez peut-être mettre à jour les informations de prix manuellement.\\Voulez-vous modifier %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "PostedDocsToPrintCreatedMsg(Variable 1083)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PostedDocsToPrintCreatedMsg : ENU=One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PostedDocsToPrintCreatedMsg : ENU=One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.;FRA=Un ou plusieurs documents validés connexes ont été générés lors de la suppression pour éviter une discontinuité dans la souche de numéros de validation. Vous pouvez afficher ou imprimer les documents à partir de l'archive de document correspondant.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "BuyFromVendorTxt(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //BuyFromVendorTxt : ENU=Buy-from Vendor;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BuyFromVendorTxt : ENU=Buy-from Vendor;FRA=Fournisseur;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "PayToVendorTxt(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PayToVendorTxt : ENU=Pay-to Vendor;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PayToVendorTxt : ENU=Pay-to Vendor;FRA=Fournisseur à payer;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DocumentNotPostedClosePageQst(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DocumentNotPostedClosePageQst : ENU=The document has not been posted.\Are you sure you want to exit?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DocumentNotPostedClosePageQst : ENU=The document has not been posted.\Are you sure you want to exit?;FRA=Le document n'a pas été validé.\Voulez-vous vraiment quitter ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DocTxt(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DocTxt : ENU=Purchase Order;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DocTxt : ENU=Purchase Order;FRA=Commande achat;
    //Variable type has not been exported.
    //BC UPGRADE SHARMP16 begin<<
    procedure GetBlanketOrderPrice()
    var
        PurchaseLine: Record "Purchase Line";
        PurchBlanketOrderLine: Record "Purchase Line";
    //  SRMInterfaceManagement: Codeunit "SRM Interface Management";commented because Codeunit used will be compiled differently
    begin
        //HEI.16>>
        PurchaseLine.SETRANGE("Document Type", "Document Type");
        PurchaseLine.SETRANGE("Document No.", "No.");
        IF PurchaseLine.findset() THEN
            REPEAT
                IF PurchBlanketOrderLine.GET(PurchBlanketOrderLine."Document Type"::"Blanket Order", PurchaseLine."Blanket Order No.", PurchaseLine."Blanket Order Line No.") THEN;
                // IF SRMInterfaceManagement.IsSRMPurchaseBlanketOrderLine(PurchBlanketOrderLine) THEN BEGIN //BC UPGRADE SHARMP16commented because  Codeunit used will be compiled differently
                //     SRMInterfaceManagement.GetBlanketOrderPurchPrice(PurchBlanketOrderLine, PurchaseLine, TRUE);//BC UPGRADE SHARMP16commented because  Codeunit used will be compiled differently
                PurchaseLine.MODIFY(TRUE);
            //  end;//BC UPGRADE SHARMP16commented because  Codeunit used will be compiled differently
            UNTIL PurchaseLine.NEXT() = 0;
        //HEI.16<<

    end;

    local procedure ValidateVendBankAccFields(VendorNo: Code[20]; VendBankAccNo: Code[20])
    var
        VendorBankAccount: Record "Vendor Bank Account";
    begin
        // HEI.17>>
        IF VendorBankAccount.GET(VendorNo, VendBankAccNo) THEN BEGIN
            VendorBankAccount.TESTFIELD(Code);
            VendorBankAccount.TESTFIELD(Name);
            VendorBankAccount.TESTFIELD(Address);
            VendorBankAccount.TESTFIELD("Country/Region Code");
            VendorBankAccount.TESTFIELD(IBAN);
            VendorBankAccount.TESTFIELD("SWIFT Code");
            VendorBankAccount.TESTFIELD("Bank Branch No.");
            VendorBankAccount.TESTFIELD("Bank Account No.");
        end;
        // HEI.17<<

    end;

    //BC Upgrade VAMSIU01- Uncommented the commented code for Document Subtype
    // trigger OnAfterDelete() //BC UPGRADE ATHUKUS01 FDDSTP_007 
    trigger OnBeforeDelete()
    var
        ArchiveManagement: Codeunit ArchiveManagement;
    begin
        //<<HEI.20
        //HEI.20 comment line ArchiveManagement.AutoArchivePurchDocument(Rec);

        PurchSetup.GET();
        IF PurchSetup."Auto.Arch.Del. Inv&CrMemos FND" AND ("Document Type" IN ["Document Type"::Invoice, "Document Type"::"Credit Memo"]) THEN BEGIN
            IF (Rec."Document Subtype Code FND" = PurchSetup."PO Subtype Code FND") OR (rec."Document Subtype Code FND" = PurchSetup."NPO Subtype Code FND") OR//BC UPGRADE SHARMP16 Drink-IT fields
               ("Document Subtype Code FND" = PurchSetup."Expense Claim Subdoc. Type FND") OR ("Document Subtype Code FND" = PurchSetup."Expense ClaimCMSubdoc Type FND") THEN BEGIN//BC UPGRADE SHARMP16 Drink-IT fields
                Rec."Call From OnDelete FND" := true;
                ArchiveManagement.AutoArchivePurchDocument(Rec);
            end;
        end;
        //>>HEI.20

    end;

    procedure SendEmailPurchaseOrder(VAR PurchaseHeader: Record "Purchase Header"; IsAutoSend: Boolean; IsMessageShow: Boolean)
    var
        CompanyInformationL: Record "Company Information";
        EmailAttachment: Record "Email Attachments";
        PurchaseHeaderL: Record "Purchase Header";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        UserSetupL: Record "User Setup";
        VendorL: Record Vendor;
        ReportSelectionsL: Record "Report Selections";
        Base64Convert: Codeunit "Base64 Convert";
        email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        FileInStream: InStream;
        Text0000: Label 'There is no Sender E-mail address available neither in "SMTP Mail Setup", nor "Company Information". Please add it before sending the E-mail.';
        Text0001: Label 'There is no E-mail address available for this Vendor %1 in "Vendor Card". Please add it before sending the E-mail.';
        Text0002: Label 'There is no E-mail address available for this Creator %1 in "User Setup". Please add it before sending the E-mail.';
        Text0003: Label 'There is no Report attached for Purchase %1 document in %2.';
        Text0004: Label 'Purchase %1 - %2';
        Text0005: Label 'Purchase %1_%2.pdf';
        Text0006: Label 'Dear %1,';
        Text0007: Label 'Please find the attached %1.';
        Text0008: Label 'E-mail sent successfully for this %1.';
        FileOutStream: OutStream;
        AttachmentBase64: Text;
        SenderEmailL: Text[100];
        FileNameL: Text[250];
        RecipientsL: Text[250];
        DocCaptionL: Text[250];
        User: Record User;
        AllObjWithCaption: Record AllObjWithCaption;
        ReportParameters: Text;
        OutStream: OutStream;
        ReportLbl: Label '<?xml version="1.0" standalone="yes"?><ReportParameters name= "%1" id="%2"><Options><Field name="ArchiveDocument">false</Field><Field name="LogInteraction">true</Field></Options><DataItems><DataItem name="Purchase Header">VERSION(1) SORTING(Field1,Field3) WHERE(Field3=1(%3))</DataItem><DataItem name="Purchase Line">VERSION(1) SORTING(Field1,Field3,Field4)</DataItem><DataItem name="Totals">VERSION(1) SORTING(Field1)</DataItem><DataItem name="VATCounter">VERSION(1) SORTING(Field1)</DataItem><DataItem name="VATCounterLCY">VERSION(1) SORTING(Field1)</DataItem><DataItem name="PrepmtLoop">VERSION(1) SORTING(Field1)</DataItem><DataItem name="PrepmtVATCounter">VERSION(1) SORTING(Field1)</DataItem><DataItem name="LetterText">VERSION(1) SORTING(Field1)</DataItem></DataItems></ReportParameters>';
    begin
        //HEI.21>>
        PurchasesPayablesSetup.GET();
        IF IsAutoSend AND PurchasesPayablesSetup."Auto E-mail Active FND" THEN BEGIN
            PurchaseHeaderL.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseHeaderL.SETRANGE("No.", PurchaseHeader."No.");
            IF PurchaseHeaderL.FINDFIRST() THEN BEGIN
                //SMTPMailSetupL.GET;
                CompanyInformationL.GET();
                User.Get(PurchaseHeaderL.SystemCreatedBy);
                UserSetupL.GET(User."User Name");
                VendorL.GET(PurchaseHeaderL."Buy-from Vendor No.");

                // IF SMTPMailL."User ID" <> '' THEN//BC UPGRADE SHARMP16 Need to change the logic
                //     SenderEmailL := SMTPMailSetupL."User ID"//BC UPGRADE SHARMP16 Need to change the logic
                // else//BC UPGRADE SHARMP16 Need to change the logic
                SenderEmailL := CompanyInformationL."E-Mail";

                IF SenderEmailL = '' THEN
                    ERROR(Text0000);
                //HEI.29>>
                IF UserSetupL."E-Mail" = '' THEN
                    ERROR(Text0002, UserSetupL."User ID");
                //>>HEI.50
                //IF VendorL."E-Mail" = '' THEN
                IF ((VendorL."E-Mail" = '') AND (GUIALLOWED)) THEN
                    //<<HEI.50
                    MESSAGE(Text0001, VendorL."No.")
                else BEGIN

                    //BC UPGRADE SHARMP16 ReportSelectionsLreport will be compiled seprately begin<<
                    // IF PurchaseHeaderL."Document Type" = PurchaseHeaderL."Document Type"::Order THEN
                    //     ReportSelectionsL.SETRANGE(Usage, ReportSelectionsL.Usage::"P.Order")
                    // else IF PurchaseHeaderL."Document Type" = PurchaseHeaderL."Document Type"::"Return Order" THEN
                    //     ReportSelectionsL.SETRANGE(Usage, ReportSelectionsL.Usage::"P.Return");
                    // ReportSelectionsL.SETRANGE("Use for Email Attachment", TRUE);
                    // ReportSelectionsL.SETFILTER("Report ID", '<>%1', 0);
                    // ReportSelectionsL.SETRANGE("Document Subtype Code", PurchaseHeaderL."Document Subtype Code"); //HEI.32
                    // IF NOT ReportSelectionsL.FINDFIRST THEN
                    //     ERROR(Text0003, PurchaseHeader."Document Type", ReportSelectionsL.TABLECAPTION);
                    //BC UPGRADE SHARMP16 ReportSelectionsLreport will be compiled seprately end>>

                    // //BC UPGRADE SHARMP16 SMTP will be handled differnetly>
                    // FileNameL := COPYSTR(FileManagementL.ServerTempFileName('pdf'), 1, 250);
                    // RecipientsL := VendorL."E-Mail";
                    // DocCaptionL := STRSUBSTNO(Text0004, FORMAT(PurchaseHeaderL."Document Type"), PurchaseHeaderL."No.");

                    // //REPORT.SAVEASPDF(ReportSelectionsL."Report ID", FileNameL, PurchaseHeaderL);// //BC UPGRADE SHARMP16 ReportSelectionsLreport will be compiled seprately begin<<
                    // SMTPMailL.CreateMessage('',
                    //                         SenderEmailL,
                    //                         RecipientsL,
                    //                         STRSUBSTNO(DocCaptionL),
                    //                         '',
                    //                         TRUE);
                    // SMTPMailL.AddCC(UserSetupL."E-Mail");
                    // SMTPMailL.AddAttachment(FileNameL, STRSUBSTNO(Text0005, PurchaseHeaderL."Document Type", PurchaseHeaderL."No."));
                    // SMTPMailL.AppendBody(STRSUBSTNO(Text0006, VendorL.Name));
                    // SMTPMailL.AppendBody('<br><br>');
                    // SMTPMailL.AppendBody(STRSUBSTNO(Text0007, DocCaptionL));
                    // SMTPMailL.AppendBody('<br><br>');
                    // SMTPMailL.Send;
                    // //>>HEI.50
                    // //IF IsMessageShow THEN
                    // IF ((IsMessageShow) AND (GUIALLOWED)) THEN
                    //     //<<HEI.50
                    //     MESSAGE(Text0008, DocCaptionL);
                    // //BC UPGRADE SHARMP16 SMTP will be handled differnetly>

                    // //BC UPGRADE SHARMP16 new logic>>
                    //FileNameL := FileManagement.ServerTempFileName('pdf');  // BC Upgrade SHARMP16 - Code needs to updated

                    // Save the report as PDF
                    // Report.SaveAs(ReportSelectionsL."Report ID", FileNameL, ReportFormat::Pdf, PurchaseHeaderL);//BC UPGRADE SHARMP16 Uncomment this when report will be compiled
                    //FileManagement.BLOBImportFromServerFile(TempBlob, FileNameL);  // BC Upgrade SHARMP16  Code needs to updated
                    //AttachmentBase64 := Base64Convert.ToBase64(FileInStream);

                    IF PurchaseHeaderL."Document Type" = PurchaseHeaderL."Document Type"::Order THEN
                        ReportSelectionsL.SETRANGE(Usage, ReportSelectionsL.Usage::"P.Order")
                    else IF PurchaseHeaderL."Document Type" = PurchaseHeaderL."Document Type"::"Return Order" THEN
                        ReportSelectionsL.SETRANGE(Usage, ReportSelectionsL.Usage::"P.Return");
                    ReportSelectionsL.SETRANGE("Use for Email Attachment", TRUE);
                    ReportSelectionsL.SETFILTER("Report ID", '<>%1', 0);
                    ReportSelectionsL.SETRANGE("Document Subtype Code FND", PurchaseHeaderL."Document Subtype Code FND"); //HEI.32
                    IF NOT ReportSelectionsL.FINDFIRST() THEN
                        ERROR(Text0003, PurchaseHeader."Document Type", ReportSelectionsL.TABLECAPTION);

                    RecipientsL := VendorL."E-Mail";
                    DocCaptionL := STRSUBSTNO(Text0004, FORMAT(PurchaseHeaderL."Document Type"), PurchaseHeaderL."No.");
                    if AllObjWithCaption.Get(AllObjWithCaption."Object Type"::Report, ReportSelectionsL."Report ID") then;

                    ReportParameters := StrSubstNo(ReportLbl, AllObjWithCaption."Object Caption", ReportSelectionsL."Report ID", PurchaseHeaderL."No.");
                    TempBlob.CreateOutStream(OutStream);
                    Report.SaveAs(ReportSelectionsL."Report ID", ReportParameters, ReportFormat::Pdf, OutStream);
                    TempBlob.CreateInStream(FileInStream);
                    // Create email message
                    EmailMessage.Create(VendorL."E-Mail",
                        StrSubstNo(Text0004, Format(PurchaseHeaderL."Document Type"), PurchaseHeaderL."No."), '', true);
                    // Add CC if needed
                    if UserSetupL."E-Mail" <> '' then
                        EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, UserSetupL."E-Mail");
                    // Add body
                    EmailMessage.AppendToBody(StrSubstNo(Text0006, VendorL.Name));
                    EmailMessage.AppendToBody('<br><br>');
                    EmailMessage.AppendToBody(StrSubstNo(Text0007, Format(PurchaseHeaderL."Document Type"), PurchaseHeaderL."No."));
                    EmailMessage.AppendToBody('<br><br>');

                    EmailMessage.AddAttachment(
       StrSubstNo(Text0005, PurchaseHeaderL."Document Type", PurchaseHeaderL."No.") + '.pdf',
       'application/pdf',
       FileInStream);
                    // Send email
                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                end;
            end;

        end;
    end;

    procedure CreateShippingCost(VAR PurchHeader: Record "Purchase Header"; CreateFromRelations: Boolean; FromShippingMethodCode: Boolean)
    var
        myInt: Integer;
    begin
        //>> HEI.34 FDD-HT658 IBM.GUNERE01 27.09.2019
        IF CreateFromRelations THEN BEGIN
            IF Vend.GET(PurchHeader."Buy-from Vendor No.") THEN
                //  Vend.CALCFIELDS("No. of Shipping Agent Rel.");//BCUpgrade sharmp16--PurchProcessTestChange
                IF Vend."No. of Shipping Agent Rel. FND" > 0 THEN;
            //BC UPGRADE SHARMP16 code commented because CU WhseTransportMgt will be compiled later begin<<
            //        // WhseTransportMgt.CreatePurchShippingCostFromShipAgtRelations(PurchHeader) //HEI.34 FDD-HT658 IBM.GUNERE01 25.09.2019
            //     else
            //         WhseTransportMgt.CreatePurchShippingCost(PurchHeader);
            // end
            // //<< HEI.34 FDD-HT658 IBM.GUNERE01 27.09.2019
            // else IF (PurchHeader."Shipping Agent Service Code" <> '') THEN //AND
            //                                                                //   (PurchHeader."Auto Create Shipping Cost" = PurchHeader."Auto Create Shipping Cost"::Always) THEN
            //     WhseTransportMgt.CreatePurchShippingCost(PurchHeader)
            // //>> HEI.34 FDD-HT658 IBM.GUNERE01 16.09.2019
            // else
            //     WhseTransportMgt.DeletePurchShippingCost(PurchHeader, FromShippingMethodCode);
            //<< HEI.34 FDD-HT658 IBM.GUNERE01 16.09.2019
            //BC UPGRADE SHARMP16 code commented because CU WhseTransportMgt will be compiled later end>>
        end;
    end;
    //Bc Upgrade SHARMP16 GAPFitChanges begin<<
    // procedure UpdateLines()
    // var
    //     PurchLine: Record "Purchase Line";
    // begin
    //     PurchLine.Reset();
    //     PurchLine.SetRange("Document Type", Rec."Document Type"::Order);
    //     PurchLine.SetRange("Document No.", Rec."No.");
    //     PurchLine.SetRange(Type, PurchLine.Type::Item);
    //     if PurchLine.FindSet() then begin
    //         PurchLine.ModifyAll("Location Code", Rec."Location Code");
    //     end;
    // end;//BC Upgrade SHARMP16-- purchprocesstesting
    //BC UPGRADE SHARMP16 end>>
    //Bc Upgrade SHARMP16 GAPFitChanges end>>

    //BC Upgrade VAMSIU01 - DIT(Aptean) Procedure Which is used in Document Subtype Field validation >>
    procedure SetDefaultPostingSerialNo()
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        PurchSetup.Get();

        case Rec."Document Type" of
            Rec."Document Type"::Quote,
            Rec."Document Type"::Order:
                Rec."Posting No. Series" := PurchSetup."Posted Invoice Nos.";

            Rec."Document Type"::Invoice:
                begin
                    if (Rec."No. Series" <> '') and
                       (PurchSetup."Invoice Nos." = PurchSetup."Posted Invoice Nos.")
                    then
                        Rec."Posting No. Series" := Rec."No. Series"
                    else
                        Rec."Posting No. Series" := PurchSetup."Posted Invoice Nos.";
                end;

            Rec."Document Type"::"Return Order":
                Rec."Posting No. Series" := PurchSetup."Posted Credit Memo Nos.";

            Rec."Document Type"::"Credit Memo":
                begin
                    if (Rec."No. Series" <> '') and
                       (PurchSetup."Credit Memo Nos." = PurchSetup."Posted Credit Memo Nos.")
                    then
                        Rec."Posting No. Series" := Rec."No. Series"
                    else
                        Rec."Posting No. Series" := PurchSetup."Posted Credit Memo Nos.";
                end;
        end;
    end;

    //BC Upgrade VAMSIU01 - DIT(Aptean) Procedure Which is used in Document Subtype Field validation >>
}

