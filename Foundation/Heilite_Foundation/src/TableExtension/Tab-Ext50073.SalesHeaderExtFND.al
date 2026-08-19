tableextension 50073 SalesHeaderExt extends "Sales Header"
{
    // version NAVW110.0.00.19831,FINXL10.01,IPLXL9.00.001,DITW110.00.12,HEI.70,NRQ411703
    /*  DITW15.00.00.01 DDR 27/12/2007 Added field2034647 Drink Tax Group Code
      DITW15.00.00.01 DDR 02/01/2008 rename field
                                       2034647 Customer DTax Group Code + Filter to the source table
      DITW15.00.00.01 DDR 04/01/2008 added field
                                       2013610 Customer DDeposit Group Code
      DITW15.00.00.01 DDR 15/01/2008 added function to insert Charges into function RecreateSalesLines()
      DITW15.00.00.01 DDR 22/01/2008 Added Drink-It Discount & Promotions Item Charges functionnalities
                                     Change calling function to insert Charges into function RecreateSalesLines()
      DITW15.00.00.01 DDR 31/01/2008 Added Drink-it Reversing Calculation (Rounding) functionnalities
                                     Added fields
                                       2034690 Price Incl. Reversing Calc.
      DITW15.00.00.01 DDR 04/02/2008 ** bugfix standard Navision into fieldtrigger "Prices Including VAT"
                                       doesn't not recalculate the sales lines
                                       added function ReCalcReversePrice() for all lines
      DITW15.00.00.01 DDR 27/02/2008 Remove field (see lines)
                                       2034690 Price Incl. Reversing Calc.
                                     Added key "Link Sales Document Type,Link Sales Document No."
      DITW15.00.00.01 DDR 11/03/2008 bugfix tablerelation field2013613 "Link Sales Document No."
                                     Added message if change field "Shipment Method Code"
      DITW15.00.00.01 DDR 19/03/2008 Added Check Limit Amount and Quantity Drink-it functionnalities
                                     Added fields
                                       2013611 Empty Goods Item No. Filter
                                       2034675 Item Charge Type Filter
                                     Added filter into flowfields Amount,"Amount Including VAT"
                                     Renumber fields
                                       2013616 No. of Link Purch. Orders (flowfield)
                                       2013614 Link Sales Document Type
                                       2013613 Link Sales Document No.
                                       2013615 Print Link Document
      DITW15.00.00.01 DDR 21/03/2008 Update function ReCalcReversePrice() to calculate back the item unit price
      DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
      DITW15.00.00.15 DDR 26/03/2008 Update function RecalcBackSalesLines() new parameter
      DITW15.00.00.19 DDR 07/04/2008 Update function RecalcBackSalesLines()
                                     Replace InsertCharges2() -> InsertCharges4()
      DITW15.00.00.20 DDR 06/06/2008 Certification rules
      DITW15.00.00.23 DDR 25/07/2008 Save current record with new item charges into function RecreateSalesLines()
                          01/08/2008 Added function RefreshAndRecalcBackPurcsLines()
      DITW15.00.00.24 DDR 14/08/2008 Added fields
                                       2014060 Maximum Weight
                                       2014061 Maximum Cubage
                                       2014064 Shipping Charge Per
                                       2014067 Total Weight (sum flowfield [Lines])
                                       2014068 Total Cubage (sum flowfield [Lines])
                                       2014087 Distance
                                       2013797 Disc.Promo. Order Calculated
                          29/08/2008 Bugfix to calculate the field "Item charge value" with "Prices Including VAT" field
                          07/10/2008 Added fields
                                       2013722 Duty Tax Type
      DITW15.00.00.25 DDR 16/10/2008 Added fields
                                       2014077 Truck Code
                                       2014078 Driver Code
                                     Added optionstring 'ShippingCost' for field "Item Charge Type Filter"
                                     Update the "Shipping Agent Service Code" when fill in the customer
                          21/10/2008 Deleted fields
                                       2013722 Duty Tax Type
                                     Added transfer Customer DTax Group by "Ship-to Address"
                                     Added function UpdateShippingMax
      DITW15.00.00.26 DDR 17/11/2008 Copy Max. Weight/Cubage from Truck code
                                     Added function UpdateTruckShippingMax()
      DITW15.00.00.28 DDR 24/11/2008 Added fields
                                       2013726 Tax Registration No.
                                       2013730 Fiscal Representative No.
      DITW15.00.00.29 DDR 19/12/2008 Bugfix to remove the (temporary) created delayed lines when delete a released header
                                     Allow to copy Tax registration no. & fiscal representative no. from Ship-to code with Return orders
      DITW15.00.00.30 DDR 16/01/2009 Added functions SuspendStatusCheck(),SetHasBeenShown() when recreate sales lines in batch mode
      DITW15.00.00.31 DDR 17/02/2009 Modified function RecreateSalesLines() to pass the header to lines
      DITW15.00.00.32 DDR 08/04/09 Added Drink tax roundings
      DITW15.00.00.34 DDR 17/06/2009 Added functions GetStatusCaptionClass(),GetFieldCaption(),GetStatusButtonCaption()
                          09/07/2009 Added Text constant Text2013661
                                     Added check to keep same Drink Tax, Deposit groups when existing partial shpt/return lines
                                     Added functions
                                       IsNeedTaxReg(),TestMsgTaxRegistration()
                          10/07/2009 Recreate sales lines when change "shipment method code" (for Drink Discounts/Promotions)
      DITW15.00.00.35 DDR 28/07/2009 issue 669 Added fields
                                       2013824 Gen. Bus. Posting Free Group
                                       2013825 Free Item Posting Type
                                     Bugfix RecreateSalesLines() to remove all attached lines
                          21/08/2009 issue 783 Skipped Extended Text lines if necessary when recreate lines
                          13/10/2009 issue 722 Updated Filters - TableRelation property field "Empty Goods Item No. Filter"
                          26/10/2009 issue 924 Rename captions + optioncaptions
                                       "Free Item Posting Type" -> "Calculate Price on Free"
                                         ' ,Price,Amount' -> 'Full Amount,Price 0,Discount 100%'
                          10/04/2009 Added fields
                                       2034840 Building No.
                                     Added new argument Type6,No6 into function CreateDim()
      DITW15.00.00.36  DDR 23/11/2009 issue 939 Updated parameter function CalcBackUnitPriceItem(),CalcBackDirectCostItem()
                           18/12/2009 issue 736 Added call SetSkipUpdateShippingHeader() when recreate lines from header
      DITW15.00.00.37 DDR 28/01/2010 issue 879 Added option "Bill-to/Sell-to Building Dim." for Building Code
                          04/02/2010 issue 1033 Convert field2013797 Disc.Promo. Order Calculated into flowfield based on lines
                          23/04/2010 issue 1069 avoid recreate item charge lines when call the line function UpdateAmounts
      DITW15.00.00.38 DDR 13/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
                                       Added fields
                                         2014271 Tax Warehouse Reference
                                       Fill in fields from customer or Ship-to address
                                         "Transaction Type","Transport Method","Transaction Specification",
                                         "Exit Point","Area Code"
                      DDR 25/10/2010 issue 1139 SSCC Functionnalities
                                       Include SSCC reservation management
                                       Added text constants Text2035040,Text2035041
                          04/01/2011 issue 1217 (DIT711 105) Modified to check the Tax Registration no.
                          27/01/2011 issue 1217 (DIT711 137)
                                       Modified Caption field2013730 "Fiscal Representative No."
                                       Added fields
                                         2014460 Tax Office Code
                          01/02/2011 issue 941 Modified OptionCaption property field2013825 "Free Item Posting Type"
                          23/02/2011 issue 1286 Modified the source of "Customer DTax Group Code" depending of
                                                  setup "Sell-to/Bill-to DTax Gr. Calc." field (Gen. Ledger Setup)
      DITW15.00.00.39 RBE 20/04/2011 issue 1230 Telesales functionnalities
                                       Added to fill "Sell-To Contact No." from customer "Sell-To Contact No." or Ship-To Address
                                       Added to fill Salesperson from user setup table
                          21/04/2011   Added fields
                                         2014102 Delivery Order
                                         2014495 Delivery Sequence
                                       Added key "Document Type,Shipment Date,Truck Code"
                                       Added "Ship-to Code" for key "Document Type,Sell-to Customer No.,No.,Ship-to Code"
                          26/04/2011   Added key "Telesales Entry,Sell-to Customer No.,Ship-to Code"
                          10/05/2011 issue 718 Added to skip Prepayment with negative DIT item charges
                          09/05/2011 issue 1328 Shop (iPos) Functionnalities
                                       Added fields
                                         2013969 Pos System-Created Entry
                      DDR 06/07/2011 issue 1353
                                       Added functions GetJourneyTime()
                                       Added fields
                                         2014290 Journey Time
                          27/07/2011 issue 1407
                                       Bugfix parameter called function InsertCharges4()
                                       Added fields
                                        2013666 Autom. Item Charge
                                       Added functions DeleteChargeSalesLines()
                          01/08/2011 issue 1353 fill in "Journey time" with "Shipping time" when first one is empty.
                          04/08/2011 issue 1353 Modified caption field2014290 "Journey Time"
                          11/08/2011 issue 1407 Added functions ExistWhseLocationLine()
                          16/08/2011 issue 1407 Added optionstring field2013666 Autom. Item Charge
                          19/08/2011 issue 1363
                                       Added fields
                                         2013733 Tax Date
                          22/08/2011 issue 1399
                                       Added fields
                                         2014103 Whse. Shipment No. (First)
                                         2014104 Whse. Shipment Status (First)
                          27/09/2011 issue 1363 Bugfix to update "Tax Date" from "Shipment Date"
                          28/10/2011 issue 1457 Modified many ML captions
      DITW16.00.00.40 DDR 12/12/2011 issue 1002
                                       Added fields
                                         2014107 Route
                                       Added 'MinValue'property field "Delivery Sequence"
                                       Added keys "Route,Sell-to Customer No.,Shipment Date"
                          22/12/2011 DIT-715 issue 187
                                       Added fields
                                         2014277 Transport Mode (flowfield)
                                         2014291 Transport Mode Comment (flowfield)
                          24/01/2012 DIT-715 issue 203 Bugfix always to copy "Fiscal Representative" from Ship-to address
                          03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
                                           Added function FEFOTrackingOrder()
                                           Bugfix filters function FEFOTrackingOrder()
                          13/02/2012 DIT-715 #240 Bugfix keep "Tax Date" while modifying "Shipment Date" and setup with "Order Date"
                                     DIT-715 #244 Added functions GetCaptionClassUom(),ShowShortcutUomValue()
                          20/02/2012 DIT-715 #245
                                       Added fields
                                         2014065 Truck Size
                                       Modified 'TableRelation' property field2014077 Truck Code
                          27/02/2012 DIT-715 #245 Remove flowfield 2014065 Truck Size
                                                  Added Lookup trigger field2014077 Truck Code
                                                  Modified 'TableRelation' property field2014077 Truck Code
                          21/03/2012 #1331 Bugfix function FEFOTrackingOrder()
      DITW16.00.00.40 DDR 16/04/2012 DIT-715 #247 Sponsoring & Events functionnality
                                                  Added field "Customer Price Group" (link/from Ship-to Address)
                                                  Added function ExistBackOrderLine(),ShowDocumentCard()
                          11/06/2012 DIT-715 #313 Added to update all periodic discout/promo worksheet lines while deleting header
      DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added fields
                                                    2034850 DIT Sub-Contract Type
                                                    2034872 Contract Group Code
                                                    2034915 Service Contract No.
                                                    2014311 Service Contract Type
                          06/08/2012 DIT-715 #327 Added 'Type7,No7' parameters function CreateDim()
                                                  !! Reviewed Nav limitation function CreateDim() max. 12 parameters
                                                  Added function SetCreateDimParam()
                      AHU 13/08/2012 DIT-715 #327 Renamed Captions fields2034915,2034310,2014311
                                                  Added default value field2014311 "Service Contract Type"
                                                  Keep value field2034850 "DIT Sub-Contract Type" while modifying "Service contract
                                                  Added to transfer all Contract Posting Group fields from Customer Template record
      DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields
                                                    2013630 Deposit Cust. Posting Group
                                                    2013631 Deposit Payment Terms Code
                                                    2013632 Deposit Payment Method Code
                                                    2013633 Deposit Bal. Account Type
                                                    2013634 Deposit Bal. Account No.
                                                    2013638 Deposit Posting No.
                                                    2013639 Last Deposit Posting No.
                          12/12/2012 DIT-715 #520 Added calculation prices based on customer field "Bill-to/Sell-to Prices Calc."
                          13/12/2012 DIT-715 #522 Added read dimension based on sales setup field "bill-to/Sell-to Dimensions"
                                                  Added functions GetCustNoCalcDim()
                          14/12/2012 DIT-715 #520 Modified option values field "bill-to/sell-to prices calc."
                                                  Added functions GetCustNoCalcPrices(),IsCustCalcPrices(),IsCustCalcTaxPrices()
                          18/12/2012 DIT-715 #517 Added "Location Filter" with function ShowShortcutUomValue()
                          18/12/2012 DIT-715 #520 Modified function IsCustCalcTaxPrices() Read from GL Setup only
                          19/12/2012 DIT-715 #520 Renamed/Modified function IsCustCalcTaxes()
                                                  Modified function GetCustNoCalcPrices()
                                                  Added function GetCustNoCalcTaxes()
                          19/12/2012 DIT-715 #517 Added "Location Filter" for fields "Total Weight","Total Cubage" (CalcFormula property)
                          02/01/2013 DIT-715 #501 Removed (Telesales #1230) copy Salesperson code from User setup
                          02/01/2013 DIT-715 #529 Added to use sales setup field "Bill-to/Sell-to Salespers./P."
                          01/03/2013 DIT-715 #572 Added to fill in "Order Date" for Quote,Blanket Order-
                          11/03/2013 DIT-715 #582 Bugfix don't change "Tax Date" on "Posting Date" (invoice, credit memo)
      DITW16.00.00.43 DDR 13/05/2013 DIT-715 #604 Added "Default Ship-to Code" from Customer
                          13/05/2013 DIT-715 #606 Added fields
                                                    2014509 Document Status
                      FBL 09/07/2013 DIT-715 #619 Add field 2034920 "Contract Next Invoice Date" (Date)
                      DDR 30/07/2013 DIT-715 #719 Bugfix when no Customer Tax Group by default (only Ship Address)
                      DDR 02/08/2013 DIT-715 #691 Review flow to recreate charge lines while modifying the related header fields
                      DDR 09/08/2013 DIT-715 #655 Keep "Free Item" on sales lines while calling function RecreateSalesLines()
                      DDR 12/08/2013 DIT-715 #720 Added function TestIfEmcsSalesLinesExist(),EmcsSalesLinesExist()
                      DDR 23/08/2013 DIT-715 #691 Bugfix missing to recalculate the item prices including charges
                      DDR 15/10/2013 DIT-715 #763 Bugfix to have the last Sales Header while recreating dit charge lines
                                                    + Revalidate all EMCS fields
                      DDR 19/12/2013 DIT-715 #860 Added HasBeenShow for many Confirm message
                      DDR 17/01/2014 DIT-715 #863 Added to recalculate Composed items (Giftbox)

      FINXL7.00.001 RBE 06/08/2013 : Default value for fields: Transaction Type, Transport Method, Area
      FINXL8.00.001 BSA 23/04/2015 #170: Remove TestField from fields "transaction type", "transport method" and area
      FINXL8.00.001 BSA 27/05/2015 #184: Change Bill-to Customer after posting Shipment
      FINXL8.00.001 BSA 08/06/2015 #151: Change priority for "Vat Bus Posting group" from ship to Adress if Filled In
      FINXL8.00.001 BSA 10/06/2015 #85 : Added Field "Last changed User ID", "Last changed Date/time"
      FINXL9.00.001 DAT 23/12/2015 : Skip updating "Last changed User ID", "Last changed Date/time" from the Sales Line
      FINXL9.00.001 DAT 28/12/2015 : Updating some fields when recreating lines

      DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
      DITW17.00.02 DDR 13/05/2013 DIT-715 #604
                       13/05/2013 DIT-715 #606
                       17/05/2013 DIT-770 #95 Added fields
                                                    2014560 Vessel Info. Code
                   DDR 30/07/2013 DIT-715 #719 merge
                   DDR 01/08/2013 DIT-770 #118 Keep Free item field while recreating lines
                   DDR 06/08/2013 DIT-770 #691 merge
                   DDR 09/08/2013 DIT-715 #655 merge (sse also DIT-770 #118)
                   DDR 13/08/2013 DIT-715 #720 merge
                   DDR 20/08/2013 DIT-770 #95 Modified check on "Vessel Info. Code" (only mandatory Order Document type)
                       23/08/2013 DIT-770 #691 merge
                       28/08/2013 DIT-770 #178 Remove DIT-770 #95

      DITW17.00.02 AT  05/09/2013 DIT-770 #140 merge WHN-001 HIT0102
                                  Add code to set options for payment method/terms
      DITW17.00.02 AT  06/09/2013 DIT-770 #141 merge WHN-001 HIT0089.5
                                  Copy value from new fields on ship-to address record to sales header
      DITW17.00.02 AT  09/09/2013 DIT-770 #145 merge WHN-001 HIT0016
                                  Added code in onmodify trigger
      DITW17.00.02 SR 09/09/2013 DIT-770 #135 : Add field 2014310 "Payment Amount" (Decimal)
      DITW17.00.02 AT  09/09/2013 DIT-770 #146 merge WHN-001 HIT0005
                                  Created field 2014062 "Shipment Date Formula"
                                  Changed code for calculating Shipment Date
                                  Use the customized calendar of the location
      DITW17.00.02 AT  10/09/2013 DIT-770 #148 merge WHN-001 HIT0121
                                  New dit field "Return Date" Issue 268
      DITW17.00.02 AT  12/09/2013 DIT-770 #154
                                  Added code to Update Shipping Agen, Shipping Agent Service Code, Payment Terms, Payment Method on Shipment Method OnValidate
                                  Added fields
                                  2014094 Sell-to Invoice Method
                                  2014095 Sell-to Invoice Period
                                  2014096 Picking Type
                                  2014097 Truck Zone
                                  2014098 Require 2 Drivers
                                  2014099 Driver 2 Code
                                  Added code to Validate Invoice Period
                                  Added Textconstant Text2014095
                                  Added code to default Sell-to Invoice Method & Sell-to Invoice Period from Sell-to Customer
                                  Update option string for Shipping Status
                                  [Previous] - Open,Picklist Printed,Assigned,Partly Picked,,To Ship,Invoice
                                  [New]- Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice
                                  Added code to default Truck Zone & Require 2 Drivers from Customer or Ship-to Code
                                  Added code to validate Route and update Shipment Date as per Shipment Day defined on Route
                                  Added code to check Shipment Date with the matching Day as defined on Route
                                  Update Posting Date with Shipment Date
      DITW17.00.02 DDR 15/10/2013 DIT-715 #763 merge
      DITW17.00.02 AT  01/10/2013 DIT-770 #154 FIX
                                  Removed Fields
                                  2014496 Invoice Posting
                                  2014497 Invoice Period
                                  Renamed Fields
                                  2014094 Invoice Method
                                  2014095 Invoice Period
      DITW17.00.02 AT  10/10/2013 DIT-770 #154
                                  Added fields
                                  2014101 Ship-to Address Key No.
      DITW17.00.02 SR 10/16/2013 DIT-770 #155 : New Function "ShowShipmentEntry" Added
      DITW17.00.02 SR 10/25/2013 DIT-770 #159 : New Key "Route,Shipment Date,Delivery Sequence" Added
                                              : New Function "TestOpenStatus" Added

      DITW17.00.02 AT  14/11/2013 DIT-770 #154
                                  Added fields
                                  2014110 Delivery Time 1 From
                                  2014111 Delivery Time 1 To
                                  2014112 Delivery Time 2 From
                                  2014113 Delivery Time 2 To
      DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
      DITW17.00.02 SR 04/09/2013 DIT-770 #136 : New Code Added for Shipment & Order Date Message
      DITW17.00.02 AT  17/12/2013 DIT-770 #210 : Fix
      DITW17.00.02 DDR 19/12/2013 DIT-715 #860 merge
      DITW17.00.02 AT 20/12/2013 DIT-770 #289 : Blocked Check for TestOpenStatus for Logistic fields
      DITW17.00.02 SR 12/26/2013 DIT-770 #298 : New Code Added to Skip update Ship to Address Details if its blank.
      DITW17.00.02 SR 12/26/2013 DIT-770 #295 : New Field "2034921" Added
                                              : New Code Added to show only Outstanding Quantity
      DITW17.00.02 AT 26/12/2013 DIT-770 #291 : Provide default Shipment date to all Sales Documents, even before selecting Customer.
      DITW17.00.02 SR 19/12/2013 DIT-770 #163 : Remove the "DIT Sub-Contract Type" filter in "Service Contract No." field
      DITW17.00.02 SR 08/01/2014 DIT-770 #189 : New Field "2014079 to 2014084" added
                                              : New code Added to HL Volume Calculation
      DITW17.00.02 AT 26/12/2013 DIT-770 #314 : Ship-to Code Error Fixed
      DITW17.00.02 SR 12/26/2013 DIT-770 #288 : New Code Added
      DITW17.00.02 AT 17/01/2014 DIT-770 #210 : Ship-to Code for Return Order Error Fixed
      DITW17.00.02 DDR 17/01/2014 DIT-770 #863 merge
      DITW17.00.02 AT 23/01/2014 DIT-770 #189 : Added field Total HL Volume
      DITW17.00.02 AT 29/01/2014 DIT-770 #288 : Physical Location issue on changing Sell-to Customer
      DITW17.10.03 AT  05/02/2014 DIT-770 #340 : Added code to update Customer Posting Group
                                               : Allow to blank Sub Contract type
                                               : Added Filter for Customer Posting Group on Opening Apply Entries Screen
      DITW17.00.03 DDR 10/03/2014 DIT-770 #519 Bugfix to fill in "Order Date" while inserting new document
      DITW17.00.02 VSC 12/02/2014 DIT-770 #338 :Change Type of field "Invoice Period" from Dateformula To Option
      DITW17.00.02 VSC 13/02/2014 DIT-770 #338 :New Field "Order No." to combine Shipments per order
      DITW17.00.02 AHU 25/02/2014 DIT-770 #338 : Translation Invoice Period
      DITW17.00.02 VSC 05/03/2014 DIT-770 #338 : New Key "Document Type,Combine Shipments,Route,Bill-to Customer No.,Currency Code,EU 3-Party Trade" for comb. shipmnts.
      DITW17.00.02 VSC 05/03/2014 DIT-770 #338 : New Key "Route" for Batch post sales orders.
      DITW17.00.02 VSC 13/03/2014 DIT-770 #338,69 : Changed Key To > Document Type,Combine Shipments,Route,Delivery Sequence,Bill-to Customer No.,Currency Code,EU 3-Party Trade for comb. shipmnts.
      DITW17.00.02 VSC 05/03/2014 DIT-770 #338,69 : Changed Key "Route" to Route,Delivery Sequence for Batch post sales orders.
      DITW17.10.03 MSF 17/03/2014 DIT-715 #340 : Added function FctmodifyparamcontractIT
                                                 Modify "Customer Posting" Group when enter "Service contract No"
                                                 Add the same options as table 81 to field "Apply To doc Type"
                                                 Add Filter when drill dow on on" Apply to don No."
      DITW17.10.03 VSC 16/04/2014 DIT-770 #387 :If blank in t.222 do not update sales header, but keep existing values (from customer)
      DITW17.10.03 MSF 18/04/2014 DIT-770 #354  Min. HL Volume and Min. UOM warning in order intake - PART2
                                                Rename Field "Total HL Weight" into "Total HL Volume"
                                                Rename Field "Total HL Volume" into "Total UOM"
                                                Rename Field "Min HL Volume (Cubage) into "Min HL Volume"
                                                Added Caption Class for Field "Total UOM" And Field "Min. Eq. UOM Quantity"
                                                Added function fctGetUomCaptionClasstelesales
      DITW17.10.03 DDR 12/05/2014 DIT-770 #361 Bugfix Runmodal error while changing sell-to customer (validate "Route" field)
      DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
      DITW17.10.03 DDR 19/05/2014 DIT-770 #623 New Customer Exception Tax Group functionality
                                               Update "Customer DTax Group Code" Sales lines
      DITW17.10.05 MSF 16/07/2014 DIT-770 #690 error on contract type when posting general journal via EP
                                               Remove Init Value "DIT Contract" on field service contract type
                                               Review c/al when validate("service contract type","service contract type"::"dit contract") only when dit contracts are included in license
      DITW17.10.05 MSF 22/07/2014 DIT-770 #795 Min. HL Volume and Min. UOM warning in order intake - PART3
                                               Delete Fields
                                                              2014079 "Min. Weight"
                                                              2014080 "Min. Cubage"
                                                              2014081 "Min. HL Cubage"
                                                              2014082 "Total HL Weight"
                                                              2014083 "Min. Eq. UOM Quantity"
      DITW17.10.05 WSA 04/08/14 DIT-770 #761 : Added field "Invoice List Customer No."
      DITW17.10.05 MSF 08/08/14 DIT-770 #795 : Min. HL Volume and Min. UOM warning in order intake - PART3
                                               Change Calcformula  for field 2014084 "Total Eq. UOM Quantity"
      DITW17.10.05 DDR 19/08/2014 DIT-770 #776 Added Deposit point functionality
      DITW17.10.05 DDR 03/09/2014 DIT-770 #675 Added Tax Assembly Orders functionality
                                               Added 'FieldNumber' parameter in function  SynchronizeAsmHeader()
      DITW17.10.05 WSA 04/09/2014 DIT-770 #891 : Added code to update shipment info from shipment entry
      DITW17.10.05 YHE 02/09/2014 DIT-770 #754 : Added functions (fctGetHasBeenDeleted,fctDeleteCallerSalesHeader,fctSetHasBeenDeleted,
                                                 fctCheckAlertExistingOrderBeforeInsert,fctCheckAlertExistingOrderBeforeInsert2)+ Added code
      DITW17.10.05 DDR 22/09/2014 DIT-770 #754 Bugfix to calculate Alert date
      DITW17.10.05 DDR 01/10/2014 DIT-770 #885 Update All Charges with shipment and sales setup "Sales Conditions Based on"
      DITW17.10.05 DDR 15/10/2014 DIT-770 #885 Bugfix to keep lines when posted partially
      DITW17.10.05 DDR 15/10/2014 DIT-770 #754 Bugfix function fctCheckAlertExistingOrderBeforeInsert2() skip if customer is not setup
      DITW17.10.05 MSF 20/10/2014 DIT-770 #831 Change Id of table 2014577 to  2035391
      DITW17.10.05 WSA 11/11/2014 DIT-770 #892 Desactivate status check when changing the "Shipping Agnet Code"
      DITW17.10.05 WSA 10/11/2014 DIT-770 #779 Added Event Management fields 2014361,2014362
      DITW17.10.05 DDR 15/12/2014 DIT-770 #1122 Bugfix refresh Tax/Emcs item fields while recreating tax lines
      DITW17.10.03 MSF 16/06/2014 DIT-770 #354 :Move "Min. Equivalent UOM" From "telesales setup" to  "Sales & Receivable Setup"
      DITW18.00.06 AKH 16/02/2015 DIT-770 #1189 Multisite - User access per site:  Limit user access to locations in Warehouse Employee Setup
      DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added fields
                                                               2014410 Physical Location Group Code
                                                               2014500 Resp. Center Table Filter
                                                               2014501 Phys. Location Table Filter
                                                               2014502 Location Table Filter
      DITW18.00.06 DDR 24/02/2015 DIT-770 #1249 TEMP SOLVED for DIT-770 #1190
      DITW18.00.06 DDR 25/02/2015 DIT-770 #1190 Multisite - Bugfix to insert new document
      DITW18.00.06 DDR 26/02/2015 DIT-770 #1190 Multisite - Bugfix to change location from Responsibility center
      DITW18.00.06 DDR 26/02/2015 DIT-770 #1190 Multisite - Added confirm with default customer values
                                                            Removed Phys. Location on 'TableRelation' property field28 Location Code
      DITW18.00.06 DDR 27/02/2015 DIT-770 #1190 Multisite - Bugfix to check customer location code
      DITW18.00.06 DDR 02/03/2015 DIT-770 #1190 Multisite - Bugfix missing validate default customer resp. center
                                                            Modified function SetSecurityFilterOnRespCenter()
      DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
      DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
      DITW17.10.05 AKH 05/01/2015 DIT-770 #664 Created two fields
                                                                 2014069 "Total Weight (Base)"
                                                                 2014070 "Total Cubage (Base)"
                                               Added function fctShowShortcutUomValueBase()
      DITW17.10.05 DDR 26/01/2015 DIT-770 #885 Bugfix recreating item charges while changing "order date" with sales condition on 'order date'
      DITW17.10.05 MSF 12/03/2015 DIT-770 DIT-770 1149 XL: G/L setup - Extra: without values
      DITW17.10.05 MSF 12/03/2015 DIT-770 DIT-770 #690 Remove code on initrecord
      DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362 Restaure CreateDim Function
      DITW18.00 MSF 27/04/2015 DIT-770 #1363 Fix upgrade tag
      DITW18.00.06 MSF 05/05/2015 DIT-770 #1212 #1213 #1214 Added functions
                                                                      UpdateDistanceDeliverySequence
                                                                      Updatelocationfromroute
                                                                      UpdatefromCustrespcenterrelation
                                                                      Modify lookup page for "Driver code" "Driver 2 code" "Truc code"
      DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 Added Field 2014100 "Trailer Code"
      DITW18.00.06 MSF 14/05/2015 DIT-770 #1051 Added Option 10 Days to field "Invoice period"
      DITW18.00.06 MSF 22/05/2015 DIT-770 #994 Return reason code mandatory should only be applied to Sales return orders and orders
      DITW18.00.06 MSF 26/05/2015 DIT-770 #1387 Enable function CheckCreditMaxBeforeInsert
      DITW18.00.06 MSF 05/06/2015 DIT-770 #1416 #1417 Error message when no setup on Resp Center employee location
      DITW18.00.06 MSF 08/06/2015 DIT-770 #994 Remove option  "Document Type"::Invoice & "Document Type"::"Credit Memo" From Condition
      DITW18.00.06 MSF 11/06/2015 DIT-770 #1416 #1417 Restore Code and bug Fix
      DITW18.00.06 MSF 11/06/2015 DIT-770 #1413 Runmodal error when inserting customer on sales order
      DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214   Rename function Updatelocationfromroute to UpdateSalesLineFromRoute()
                                                              Delete function UpdateDistanceDeliverySequence
                                                              Cleane Code
      DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214 Added Field Resp. Center Table Filter 2
                                                            Modify lookup property for field Driver code , Truck code , trailer code
      DITW18.00.06 MSF 26/06/2015 DIT-770 #1347 Order Shipment enhancement Added function DeleteEmptyShipmentEntry
                                           Change ID of field shipment Status to 2014079
      DITW18.00.06 MSF 06/07/05/2015 DIT-770 #1035 Use local variable lrWhseShippingTruck unstead of global variable rename loca
      DITW18.00.06 MSF 08/07/2015 DIT-770 #1212 #1213 #1214 Rename function UpdateSalesLineFromRoute to  UpdateFromRoute
                                                            Change function DrillDownRouteCombinaison
      DITW18.00.06 DDR 13/07/2015 DIT-770 #1258 Added key
                                                  "Shipment Date,Route,Document Type,Status,Shipment status"
      DITW18.00.06 MSF 31/07/2015 DIT-770 #1368  Added function GetContractNo
                                                 Added field  2014313 Financial Contract No.
                                                 Change ID of field  Contract Type to Foundation layed granule 2035393
                                                              Added blank Option to field Contract Type
                                                              Rename Caption "Service contract type" to "Contract Type"
      DITW18.00.06 DDR 07/08/2015 DIT-770 #1368 Various adjustments
      DITW18.00.06 MSF 18/08/2015 DIT-770 #1534 Resp. centre with Phys. Location group and Location code gives conflict
      DITW18.00.06 MSF 15/05/2014 DIT-770 #1611 ached shipped lines are removed after change shipment date or shipment method
      DITW18.00.06 MSF 02/10/2015 DIT-770 #1261 Do not update event line when delete Sales Header
      DITW18.00.06 MSF 02/10/2015 DIT-770 #1604 Get Default route from sales and Receivable Setup
      DITW18.00.06 MSF 05/10/2015 DIT-770 #1534 Remove fix
      DITW18.00.06 DDR 19/10/2015 DIT-770 #1652 Bugfix Recreate promotion items while changing order/shipment date
      DITW18.00.06 MSF 20/10/2015 DIT-770 #1180 Lost Responsibility Center when Revalidate the Same Bill to customer
      DITW18.00.06 MSF 27/10/2015 DIT-770 #1674 Various merge errors
      DITW18.00.06 MVN 28/10/2015 DIT-77O #1623 NO Credit or Deposit Warning for CASH Orders
      DITW18.00.06 DDR 05/11/2015 DIT-770 #1623 Bugfix flow while inserting new customer and having default payment term code
      DITW19.00.07 MVN 30/12/2015 DIT-770 #001  Upgrade Set Global RecreateSalesLines
      DITW19.00.07 MVN 14/03/2016 DIT-770 #1390 Remove Obsolete Procedure SetCreateDimParam/CreateDim_
      DITW18.00.07 AKH 07/01/2016 DIT-770 #1277 Load list does not apply filters well: Merge SWB-001 #240
      DITW18.00.07 AKH 07/01/2016 DIT-770 #1381 Delivery times not filled well in order in case of a Shipment date formula: Merge SWB-001 #251
      DITW18.00.07 MVN 21/01/2016 DIT-770 #1397 Added Field 2014300 "Submission Type"
      DITW18.00.07 AKH 11/02/2016 DIT-770 #1804 Sundry Customer
      DITW18.00.07 KJB 18/02/2016 DIT-770 #1042 Always copy customer comments to sales order comments
      DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Several adjustments
      DITW18.00.07 MVN 24/02/2016 DIT-770 #1397 Changed Field 2014300 for CaptionML: "Submission Type (EMCS)"
      DITW18.00.07 AKH 26/02/2016 DIT-770 #1628 Manually inserted DIT Discounts are not restored on change shipment date (Merge WGR-001 #465)
      DITW18.00.07 VSC 07/03/2016 DIT-770 #1066 Delete Document Shipping Costs
      DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 New Field "Auto Create Shipping Cost" + Function CreateShippingCost
      DITW18.00.07 MVN 11/03/2016 DIT-770 #1253 Check Permissions on Loyalty with License
      DITW18.00.07 MVN 14/03/2016 DIT-770 #1390 Remove Obsolete Procedure SetCreateDimParam/CreateDim_
      DITW18.00.07 WSA 18/03/2016 DIT-770 #1723 Copy "Invoice List Customer No." from bill-to cust
      DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 New Functions HasDocumentShippingCosts an OpenDocumentShippingCosts Like Flowfield, Flowfield it self not posible due to Type Conversion error Integer -> Option
                                                Moved Function CreateShippingCost to CU "Warehouse & Transport Mgt." as CreateSalesShippingCost
                                                Update From Route -> CreateSalesShippingCost
      DITW18.00.07 AKH 23/03/2016 DIT-770 #1804 Adjustments
      DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field 2014421 "Document Subtype Code"
      DITW18.00.07 ASA 06/04/2016 DIT-770 #1939 Shipment date Formula isn't considered when Order no. isn't shown in the order
      DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
                                                Added field2014109 Route Planning No.
                                                Moved functions ChangeShipmentStatus(), ChangeSaleLineStatus() to Sales Header
                                                Remove all old link to ShipmentEntry table2035391
                                                Rename function fctGetUomCaptionClasstelesales -> GetUomCaptionClassEqUom
                                                Rename function GetUomCaptionClass -> GetUomCaptionClassHL
                                                Rename function GetCaptionClassUom -> GetCaptionClassShortcutUom
                                                Update Checking Route-ShipmemtDate
                                                Update Route new transfer fields
                                                Update flow of TestOpenStatus function (allow change after release)
                                                Update Total Weight/Cubage/Volume (base & outstanding)
                                                Merge  function UpdateTruckShippingMax() with UpdateShippingMax()
                                                Delete obsolete function GetShipmentInfo; fctShowShortcutUomValueBase; UpdateFromRoute; DeleteEmptyShipmentEntry
                                                Added  functions fctClearDeliveryTimes; TestRouteTypeVariable; ChangeShipmentStatus
                                                                 UpdateWhseRequestLines; UpdateRoutePlanRqstLines; DeleteRoutePlanRqstLine;
      DITW18.00.07 MVN 07/04/2016 DIT-770 #1397 Check Permissions on EMCS
      DITW18.00.07 VSC 08/04/2016 DIT-770 #1066 Only copy from route if "Auto Create Shipping Cost" is not blank
      DITW18.00.07 DDR 08/04/2016 DIT-770 #1488 Bugfix Insert recreate DIT charges in batch mode
      DITW18.00.07 DDR 11/04/2016 DIT-770 #1488 Bugfix batch mode function UpdateRoutePlanRqstLines
                                                Modified functions ChangeShipmentStatus; ShowShortcutUomValue; GetCaptionClassShortcutUom;
                                                Delete field2034921
      DITW18.00.07 AKH 07/04/2016 DIT-770 #1042 Added function SalesOrderCommentExists()
      DITW18.00.07 VSC 11/04/2016 DIT-770 #1900 For Contracts Get "Customer Posting Group" based on Bill-To Customer
      DITW18.00.07 VSC 14/04/2016 DIT-770 #1265 Undo fix #288 Giving Error on recreate lines. Main problem solved on other issue.
      DITW18.00.07 DDR 14/04/2016 DIT-770 #1109 Bugfix Review flow to show "update" confirmation once
                                                Added HasBeenShowText2014096
                                                Modified functions InitHasBeenShow()
                                                Added functions ClearHasBeenShowAll2()
      DITW18.00.07 DDR 14/04/2016 DIT-770 #1402 Added "Recalculate Prices" setup field + update validation flow
                                                Removed global variable HasRecreateSalesLines
                                                Added return value on function RecreateSalesLines()
      DITW18.00.07 DDR 19/04/2016 DIT-770 #1488 Bugfix double validation "ship-to code"
                                                Bugfix double validation "shipment date" with "Shipment date formula"
      DITW18.00.07 AKH 21/04/2016 DIT-770 #1508 Adjusted TableRelation for field "Document Subtype Code"
      DITW18.00.07 DDR 26/04/2016 DIT-770 #1963 Bugfix missing sales header in function RecalcBackSalesLines()
      DITW18.00.07 DDR 28/04/2016 DIT-770 #1488 Added to sync. route planning with key fields Route, Shipment date
                                                Removed extra checking has price recalculation confirmation
      DITW18.00.07 DDR 29/04/2016 DIT-770 #1346 Added fields 2014080 "Customer Delivery Type"
                                                             2014081 "Delivery Time (sec.)"
      DITW18.00.07 DDR 02/05/2016 DIT-770 #1402 Modified validation of Location Code and update lines in batch mode
      DITW18.00.07 AKH 09/05/2016 DIT-770 #1939 Adjustments
      DITW18.00.07 AKH 09/05/2016 DIT-770 #1804 Bugfix on validating "Sundry Customer"
      DITW18.00.07 AKH 10/05/2016 DIT-770 #1346 Added "Customer Delivery Type" from Ship-to code
      DITW18.00.07 AKH 11/05/2015 DIT-770 #1983 Bugfix for Payment method and Payment terms from Sell-to
      DITW18.00.07 DDR 11/05/2016 DIT-770 #1402 Bugfix double recreatelines on Shipment Date when Tax Date is also based on Shipment Date
                                                Bugfix error on RecreateSalesLines() if no sales line to recalculate
                                                Added filters on posted lines on UpdateSalesLines() for only Location Code
                                                Added no modification currency when posted lines on RecreateSalesLines()
      DITW18.00.07 VSC 09/05/2016 DIT-770 #1973 Wrong filters on route combination
      DITW18.00.07 VSC 04/05/2016 DIT-770 #1968 - 1978 Extended Delivery times with field "Source Type"
      DITW18.00.07 VSC 24/05/2016 DIT-770 #1984 Add Field Receipt Status for inbound.
      DITW18.00.07 DDR 30/05/2016 DIT-770 #642 Added functions SetSkipValidationDimensions() and running on temporary record
      DITW18.00.07 DDR 03/06/2016 DIT-770 #642 Bugfix missing SetSalesHeader() while validating "VAT Base Discount %"
      DITW18.00.07 DDR 06/06/2016 DIT-770 #642 Bugfix keep manual discount while recalculating lines
      DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
      DITW18.00.07 VSC 23/06/2016 DIT-770 #2058 New Generic SetRoute Function. Used on several objects creating a document
      DITW18.00.07 DDR 28/06/2016 DIT-770 #1265 Bugfix RecreateSalesLines from Sell-to/Bill-to
      DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Sales order cut-off time warning
                                                Added Fields "Creation Date/Time","Created By" and "Latest Order Date/Time"
                                                New Functions SetLatestOrderDateTime and CheckCutOffTimeWarning
      DITW18.00.07 DDR 28/06/2016 DIT-770 #1488 Bugfix missing skip status release while recreating lines
      DITW18.00.07 VSC 01/07/2016 DIT-770 #1282 Update on changing route
      DITW18.00.07 VSC 05/07/2016 DIT-770 #1282 Use Today and not workdate
      DITW18.00.07 VSC 04/07/2016 DIT-770 #1066 New Encapsulate function CreateShippingCost() for preventing License error
      DITW18.00.07 VSC 12/07/2016 DIT-770 #1740 Fix merge error field 2030010 "Interface Transaction No." FINXL8.00.002
      DITW19.00.08 DDR 12/08/2016 BL#10314 (DIT-770 #1488) Modified skip "Route" for other document types
      DITW19.00.08 DDR 19/08/2016 BL#10314 Bugfix missing "Responsibility Center" update after release
      DITW19.00.08 MSF 09/09/2016 BL#10387 (DIT-770 #1274) If receipt/return shipment, dont allow to modify the tax reg no or whse ref
                                                           Change Function ShippedSalesLinesExist & ReturnReceiptExist from local to global
      DITW19.00.08 AKH 20/09/2016 BL#10756 (DIT-770 #1215) Added new field 2014413 "Return Location Code"
      DITW19.00.08 AKH 27/10/2016 BL#11231 (DIT-770 #2119) Added functions CheckIfRouteAllowed() & GetRouteFilter()
                                                           Adjusted code in functions SetRoute() & DrillDownRouteCombinaison()
                                                           Added filter on Responsibility Center in TableRelation of field Route
      DITW19.00.08 DDR 01/12/2016 BL#10314 (DIT-770 #2129) Bugfix conflict to validate double "shipping agent code" default values from Route
                                                              within "Shipment Method Code" and Route itself.
      DITW19.00.08 VSC 18/11/2016 BL#10351 (DIT-770 #2002) Remerge Hide Confirm Dialog using interface\nas
      DITW19.00.08 AKH 06/12/2016 BL#10756 (DIT-770 #1215) Adjusted code in "Return Location Code" validation trigger
      DITW19.00.08 AKH 07/12/2016 BL#9612 (DIT-770 #1754) Removed recalculation on "Posting Date" change for document types Invoice & Credit Memo
      DITW19.00.08 AKH 09/12/2016 BL#10756 (DIT-770 #1215) Adjusted code to respect location priority
      DITW19.00.08 AKH 16/12/2016 BL#9797 (DIT-770 #1679) Adjusted synch between "Location Code" & "Resposibility Center" (prevent blank values when validating)
      DITW19.00.08A DDR 28/02/2017 NRQ#18985 Bugfix call of Alert order warnings, runmodal error (insert document only and skip in batch mode)

      DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
      DITW110.00.08 DDR 16/02/2017 NRQ#20755 Update document subtype code table relation filter
      DITW110.00.08 DDR 26/02/2017 NRQ#0 Upgrade add notification functions ConfirmCloseDeleteEmpty()
      DITW110.00.08 DDR 03/03/2017 NRQ#22865 Upgrade error function RereateSalesLines()
      DITW110.00.09 YHE 15/03/2017 NRQ#24111 merge DIT2016 W1 R8A
      DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
      IPLXL9.00.001 IMI 16/02/2016: Added field "Interface Transaction No."
      FINXL9.00.001 ACH 27/07/2016 : Updating some fields when insert record
      FINXL9.00.001 ACH 11/01/2017 : Remove Recycle charge functionnalities
      FINXL9.00.000.01 AKH 13/01/2017 Added code to change "Bill-to Customer No." / "VAT Bus. Posting Group" after shipment posting
      FINXL10.00 AKH 02/03/2017 Deleted field "Approved Amount"
      FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
      DITW110.00.09 DDR 12/04/2017 NRQ#23026 Fix updrade call function
      DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
      DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Added new field "Backorder"; Changes for backorders
      DITW110.00.10 YHE 03/07/2017 NRQ#16068 Add fields ID.2014083-"Total HL Cubage (Base)" , ID.2014085-"Total Eq. UOM Quantity (Base)"
      DITW110.00.10 MSF 07/07/2017 NRQ#16224 Return Registration part 3
                                       Added fields : 2014105 : Suggested Return Item
      DITW110.00.10 AKH 12/07/2017 NRQ#23451 Fixed XL merge error (field "Approved Amount")
      DITW110.00.10 YHE 20/07/2017 NRQ#16068 add "Type = item" filter in CalcFormula property on total fileds
      FINXL10.01 OFE 30/08/2017 NRQ#10433: Added function TestLinePriceMandatory()
      DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added Field Multiple Order Route
                                             Modify Function  UpdateWhseRequestLines
                                             Added Function CheckExistWarehouseLine
      DITW110.00.11 AKH 02/11/2017 NRQ#43605  Added functions IsShippingNoUsed() & IsPostingNoUsed()
      DITW110.00.11 VSC 09/10/2017 NRQ#33755 Remove Backorderupdate from Shipping Status.
      DITW110.00.11 MSF 30/11/2017 NRQ#16082 Delete Check on Multiple Route Order for some fields
      DITW110.00.11 MSF 28/12/2017 NRQ#9570 Added Fields : Approved Credit limit Amount
                                                     To Check Credit Limit Amount
                                                     Extra Approver
      DITW110.00.12 MSF 12/04/2018 NRQ#67279 When recalculate lines by sales condition fiedls  then the Free Reson code  is not saved
      DITW110.00.12 MSF 13/04/2018 NRQ#67279 Fixed Price is not saved when recalculates lines
      DITW111.00.13 MSF 04/09/2018 NRQ#83542  Posted Invoice/credit memo No. series per Document subtype
      DITW111.00.13 MSF 05/09/2018 NRQ#83542  Added function SetDefaultPostingSerialno
      DITW111.00.13 ISL 03/12/2018 NRQ#91391 Changed code to update Whse request when an order is moved to another route
      DITW111.00.13 MSF 06/12/2018 NRQ#94671 Line and header alert for not fully assigned lines - in warehouse shipment and sales order
                                            Added function ExitUndefinedLot
      DITW111.00.13 MSF 13/12/2018 NRQ#94671 check based on Outstanding Qty

      HEI.01 FDD-OTCGAP065 IBM.HORTOC01 11.07.2017
        # Change function UpdateSalesLines
      HEI.02 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
        # New field "WHT Business Posting Group"
        # New function - CheckForLinkSalesDocument
      HEI.03 FDD-SLSGAP001 IBM NASTAA02 07.09.2017 # MDM Customer Card
        # Increased "Bill-to Address", "Sell-to Address" and "Ship-to Address" fields length from 50 to 60 characters
        # Increased "Bill-to City", "Sell-to City" and "Ship-to City" fields length from 30 to 35 characters
      HEI.04 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
        # Increased "Customer DTax Group Code" field length from 10 to 20 characters
      HEI.05 IBM PATHAA02 # Condition added on "Document Subtype code"
      HEI.06 FDD-KDD0TC004 IBM NASTAA02 05.10.2017 # OTC - Returnable Packaging Material - RPM
        # New function "InsertFAGLJnlLinesForRPMDamageLoss" created to insert FA G/L Journal Lines for RPM Damage/Loss
      HEI.07 FDD-KDD0TC005 IBM NASTAA02 9.11.2017 # RPM Billing and Reporting
        # Code added on Post Actions to post the Sales Order and the Sales Return Order which are linked
      HEI.08 FDD-LOGGAP07 IBM PATHAA02 23.11.2017 #Report-Delivery Note
        # New fields created
      HEI.09 FDD-HNK LOGGAP001 03/12/2017 IBM.CHAUHB01
        # Added new field "Sales Routes"
      HEI.10 FDD-OTCGAP051 IBM NASTAA02 06.03.2018 # Document Subtype Code non-editable for Bonus Credit Memos
        # New Field created: 50013 - "Bonus Credit Memo"
      HEI.11 FDD-SLSGAP014 IBM NASTAA02 16.04.2018 # Customer Blocked for Option 'Ship'
        # Used function "CheckBlockedCustOnDocs2" instead of "CheckBlockedCustOnDocs" to check if a Customer is blocked
      HEI.12 FDD FDD-LB-GAPLOG09_Lebanon_Almaza_Picking List Layout_v1.2 , IBM.NAIKH01 03.09.2018
        # Count the no of time the report Order pick is printed.
      HEI.14 FDD-GAPLOG01 IBM HORTOC01 14.09.2018 new field "Van Sales Route"
      HEI.15 FDD - Indirect Customer Master IBM.NAIKH01 01.10.2018
        # Added code on Trigger OnValidate() of fields - "Sell-to Customer No." and "Document Subtype Code"
      HEI.16 RFC-CHG0255774 IBM.AB 15.10.2018
        # Code added to validate Shipping Agent Code
      HEI.19 RFC-CHG0255777 IBM.LS 17.12.2018
        # Code added to create function as "ValidateCustomerMinValue".
      HEI.20 FDD-SLSGAP08 IBM NASTAA02 30.01.2018 # Proforma Invoice BA
        # Increased length of Field 11- Your Reference from 35 to 50 characters
      HEI.21 FDD RPM Breakages IBM ISYED01 03.06.19
        # Added RPM comp.Sales Credit memo No. new filed.
      HEI.22 Bugfixing IBM NASTAA02 09.04.2019 # CTS Posting No. Series
        # If "Document Subtype Code" is set to 'CTS' then "Posting No. Series" should be "Posted Invoice Nos."
      DITW111.00.13A MSF 16/04/2019 NRQ#105344 Order discounts and  promotions should be inserted before approval
                                              Added Function IsCalcDiscountPromOnPosting
      DITW111.00.13 MSF 03/09/2018 NRQ#55906 Sales Approval Workflow for Overdue and deposit limit
                                       Modify Fields "Property Approved Amount" to Flowfield
                                       Delete Fields "To Check Credit Limit Amount"
                                                     "Extra Approver"
                                       Added Functions :  OnCustomerDepositLimitExceeded
                                                          OnCustomerDepositLimitNotExceeded
                                                          CheckAvailableDepositLimit
                                                          CheckOverDueBalance
                                                          OnCustomerOverdueExceeded 
                                                          OnCustomerOverdueNotExceeded
      DITW111.00.13A MSF 22/04/2019 NRQ#103938 Sales Approval Workflow for Credit Limit, Overdue and deposit limit (remains from 9570)
                                               Added Field Approved Type
      DITW111.00.13A MSF 09/05/2019 NRQ#109271 Disable DIT Discounts and or Promotions for a sales documents
                                               Added Field "Disable DIT Disc. Prom."
      HEI.23 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #fields "Load No." & "Sequence No."
      HEI.24 HT453 - CHG2011093 IBM GAVANM01 11.06.2019
        # New fields created: IDs range 50023..50029
      HEI.25 HT453 - CHG2011093 IBM GAVANM01 18.06.2019
        # New field created: InCo Terms, ID 50030
      HEI.26 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
        # New Field created: 50031 - Suppress POS Interface
      HEI.27 CHG0255774_FDD_TC_Calculation_Enhancement IBM NANDIS01 08.07.2019
        Validation added to show error message when the shipping agent is not ticked as Own Logistics
      DITW111.00.13A DDR 03/07/2019 NRQ#103938 Remove field2035395 Approved Type
      HEI.28 FDD-HT581 IBM SURYAS01 08.08.2019 # Created new field - "Free Reason Code"

      HEI.30 FDD-HT634 CHG2024485 IBM GAVANM01 27.08.2019 # New field created - "Country of Origin"
      HEI.31 FDD-HT581 CHG2024482 IBM SURYAS01 28.08.2019
        # Created New Functions - "UpdateFreeReasonCodeDimensions" and "UpdateDimSet"
      NRQ#122316 MSF 04/10/2019  sales price for promotion items
                              Merge PBI NRQ#41769 and NRAQ#88589
      FINXL11.00 HBA 03/05/2018 NRQ#69018: Added field 2029618 "IC Document" (Boolean)
      HEI.33 FDD-HT658 IBM.GUNERE01 01.11.2019 # Shipment Method Code - OnValidate func. modified,
                                                 Sell-to Customer No. - OnValidate func modified,
                                                 Shipping Agent Service Code - OnValidate func modified,
                                                 Route - OnValidate, Distance - OnValidate,
                                                 Truck Code - OnValidate, Driver Code - OnValidate funcs modified
                                                 FilterWhseShippingTrucks, FilterWhseShippingDrivers funcs. created
                                                 CreateShippingCost func. modified.
                                                 Truck Code, Driver Code Tablerelation fix.
      HEI.34 FDD-HT658 IBM.GUNERE01 04.11.2019 # Shipment Method Code - OnValidate func. modified
      HEI.35 RFC-CHG2007388 IBM.KUMARN15 12.09.2019
        # TableRelation property changed for "Sell-to Customer No." and "Sell-to Customer Name"
      HEI.36 FDD-HT657 IBM NASTAA02 15.11.2019 # Ethiopia Intercompany Automation
        # New Field created: 50041 - Special Order
      HEI.37 FDD-HT604 IBM.COSTES02 09.12.2019 # WMS integration Heilite BASE and Reflex
        # New field added : 50042 - WMS Export
      HEI.38 FDD-HT771 IBM SURYAS01 10-jan-2020 - "To calculate Currency Factor when changing the Document Date instead of changing the Posting Date"
       #Added Code in Document Date Onvalidate Trigger and commented code in Posting Date Onvalidate trigger.
       #modified Code in UpdateCurrencyFactor Function
      HEI.39 FDD-HT1075 CHG2039144 IBM.GUNERE01 14.01.2020 # FilterShippingAgentServiceCode func. added
                                                             Shipping Agent Service Code - OnLookUp func. modified
      HEI.40 CHG2010375 IBM.LS 21.01.2020
        # New Field created: 50050 - "Send Document"
        # Code added to update the field - "Send Document".
      HEI.41 CHG2046145 IBM.COSTES02 20.02.2020 # Sales Order Status Addition
      # New field added : 50051 - "Approval Status"
       HEI.42 CHG2046145 IBM.COSTES02 03.03.2020 # Sales Order Status Addition
       # Mew option added : 50051 - "Approval Status"::Not Set
      HEI.44 CHG2046145 IBM.GAVANM01 18.03.2020 # Sales Order Status Addition
        # Rename option Cancelled to Rejected

      HEI.43 FDD-HT1075 CHG2039144 IBM.GUNERE01 16.03.2020 # FilterShippingAgentServiceCode func. modified
      HEI.45 Defect #5296 IBM NASTAA02 26.03.2020 # The translation of shipment date in french is not right
        # Changed French Caption for "Shipment Date" field to 'Date d'exp dition'
      HEI.48 CHG2064512 HB1415 IBM SAMANR01 17.06.2020  #FDD_Fix Due Date of the Invoice Payment
        # Change the logic for Due Date and "Document Date" to "Posting Date"
      HEI.49 CHG2065153 IBM KUMARN15 23.06.2020
        # Added field "Source System Identifier" and "Order Id"
                                   Added Function IsAutoSendDocEnabled
      HEI.50 CHG2065287 IBM SAMANR01 29.06.2020
        # Added code for archive the document
      HEI.51 CHG2062543 IBM SAMANR01 21-07-2020
        # Add code for flow the "Requested Delivery Date" from Sales Header to Planning Worksheet.
      HEI.52 CHG2073467 HB1369 IBM GAVANM01 17.08.2020  Enhancements to the Intercompany automation functionality
        # new field added: 50062 - IC Order No.
      DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix SalesHeader for function RecalcBackSalesLines()
      HEI.53 FDD-HB1268 - CHG2068666 IBM NASTAA02 26.10.2020 # DMS Integration Ivory Coast
        # Function "SetSalesHeader" should be used after 'FINDSET'
      DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix SalesHeader for function RecalcBackSalesLines()
      DITW114.00.15 DDR 26/03/2020 NRQ#140339 Fix "item charge value" with function RecreateSalesLines()
      DITW114.00.15 DDR 01/04/2020 NRQ#140339 Fix Recalculation tax include price on some validation cases
      HEI.54 HB1753 - CHG2083594 IBM NASTAA02 05.02.2021 # Surplus Charges Suriname
        # Code added on functions 'RecreateSalesLines' and 'CreateSalesLine'
      HEI.55 CHG2097320 IBM SAMANR01 02-10-2021
        # Check exists return order and posted return order for the sales order before release
      HEI.56 FDD-HB1234 - CHG2053453 IBM NASTAA02 10.03.2021 # B2B Order Status
        # New Field created: 50064 - Ready for Pick-up
      HEI.57 FDD-HB1233 - CHG2053452 IBM NASTAA02 19.03.2021 # B2B - Order Interface
        # Code added on OnValidate trigger of 'Requested Delivery Date' and 'Shipping Time' Fields
      HEI.58 HB1742CHG2084621 GAVANM01 08.04.2021 # SALES QUOTE FUNCTIONALITY
        # "Quote" value added in the Condition field of Table Relation property, for the fields ID 2 - Sell-to Customer No. and ID 70 - Sell-to Customer Name
      DITW114.00.15 NLAB 13/04/2021 NRQ#177508 Added 2035395 field "Last Limit Type"
      NRQ178517 NLAB 16/04/2021 Merged NRQ#177508
      HEI.59 CHG2119178 IBM.AS 30.06.2021
        # HeiLite Base Stability Changes for Posting functions at JOB NAS
        # Adding GUIAllowed function added in Functions
          Prices Including VAT - OnValidate(),
          Sell-to Customer Template Code - OnValidate(),
          Bill-to Contact No. - OnValidate(),
          Bill-to Customer Template Code - OnValidate(),
          ConfirmDeletion(),
          ConfirmUpdateCurrencyFactor(),
          ConfirmResvDateConflict(),
          CheckCustomerCreated(),
          LinkSalesDocWithOpportunity(),
           ConfirmUpdateDeferralDate(),
          UpdateOpportunity(),
          ValidateCustomerMinValue(),
          OnDelete(),
          MessageIfSalesLinesExist(),
          PriceMessageIfSalesLinesExist(),
          TestMsgTaxRegistration(),
          CheckCutOffTimeWarning()
      HEI.60 CHG2109621 HT2170 IBM GAVANM01 05.08.2021 - Posting Setup for Sales Tax (Timbre), transport, free products
        # code added in function CreateSalesLine
      HEI.61 CHG2134178 INC3809690 IBM GAVANM01 09.11.2021 - #Timbre blocking change of customer in sales order
        # code added in function RecreateSalesLines
      HEI.62 CHG2134201 INC3782664 IBM GAVANM01 09.11.2021 - #issue on Distance from route table is not assigned automatically on warehouse shipement document rwanda
        # code change
      HEI.63 CHG2183672 DEBUSD01 05.12.2022 Fix lock new sales order runmodal page
      HEI.64 CHG2183672 DEBUSD01 12.12.2022 Fix lock new sales order runmodal page
      HEI.65 CHG2193616 IBM BHANDS01 23.02.23 Sales Order API Optimization
        # Change function from local to global UpdateCustomerAddress()
      HEI.66 CHG2193616 IBM BHANDS01 09.03.23 Sales Order API Optimization
        # Added code in CheckAvailableCreditLimit()
      HEI.67 CHG2202264 IBM MARTIR52 26.04.2023 Workflows Panama Based on quantity
        # Added new flowfield "Total Quantity" to sum the items quantities from the lines and consider this on the Workflow function
      HEI.68 CHG2202264 IBM BHANDS01 27.04.2023 Workflows Panama Based on quantity
        # Remove filter in Quantity for perfomance and the flowfeild use the Table Key
      HEI.69 CHG2205042 IBM BHANDS01 17.05.2023 Deadlock Issue
        # Code Optimization
      HEI.70 CC CHG2226741 BHANDS01 18.03.2024 Blank Return Reason
        # Fix from Aptean(Norriq)
        # DITW113.00.15 DDR 21/10/2019 NRQ#22821 Add function TestLineReturnReasonMandatory()
      HEI.71 CHG2301987 BHANDS01 19.06.2025 Return Reason Code empty
        # NRQ#411703 DDR 18/06/2025 Add validation "Return Reason Code" in CreateSalesLine()
          Fix location validation with "Physical Location Group Code" in "Route" field
 */
    // BC Upgrade BHARDA11 >>
    // BC Upgrade BHARDA11 >>
    // Migration from NAV 2018 to Business Central 26
    // Table Extension: Sales Header
    //
    // Changes:
    //
    // 1. Removed/Commented ALL Drink-IT dependent logic in triggers:
    //    - Shipment Method validations (WhseTransportMgt)
    //    - Shipping Agent Vendor validations
    //    - Route planning updates
    //    - Deposit / Contract / Fiscal Representative logic
    //    - Telesales / Truck / Driver validations
    //    - Shipping Cost creation/deletion
    //
    // 2. Removed ALL Drink-IT table references (unsupported in BC):
    //    - WhseShippingDriver (2014063)
    //    - WhseShippingTruck (2014068)
    //    - DocumentSubtypeCodeSetup (2014473)
    //    - Contract tables (2014310, 2014312)
    //    - Building (2034841)
    //    - FINXL Setup (2029610)
    //    - Route / RoutePlanning (2014072)
    //    - Shipping Cost tables/codeunits
    //    - SSCC setup & reservation tables
    //
    // 3. Field length change attempts found but NOT IMPLEMENTED (BC does NOT allow modification):
    //    - "Bill-to Address" (50→60) — BC has 100
    //    - "Bill-to Address 2" (50→60) — BC base 50
    //    - "Bill-to City" (30→35) — BC base 30
    //    - "Ship-to Address" (50→60) — BC has 100
    //    - "Ship-to Address 2" (50→60) — BC base 50
    //    - "Ship-to City" (30→35) — BC base 30
    //    - "Sell-to Address" (50→60) — BC has 100
    //    - "Sell-to Address 2" (50→60) — BC base 50
    //    - "Sell-to City" (30→35) — BC base 30
    //    - "Your Reference" (35→50) — BC base 35
    //    - Posting groups (Customer / VAT / No. Series): all 20 chars in BC
    //
    // 4. Removed all Drink-IT TableRelation filters impossible to convert:
    //    - Location Code → removed DRINK-IT Location filters
    //    - Shipping Agent Code → removed Resp. Center Table Filter dependency
    //    - Sell-to Customer No. → removed Contract Type/Document Subtype checks
    //
    // 5. Drink-IT custom procedures removed/commented completely:
    //    - FilterWhseShippingDrivers()
    //    - FilterWhseShippingTrucks()
    //    - FilterShippingAgentServiceCode() (partial)
    //    - UpdateRoutePlanRqstLines()
    //    - ConfirmUpdateCurrencyFactor()
    //    - Deposit, Event, Contract related functions
    //
    // 6. Keys referencing Drink-IT fields removed/not converted:
    //    - Keys based on Route, Delivery Sequence
    //    - Keys on Link Document No./Type
    //    - Keys on Telesales / Truck / Shipment Status
    //
    // 7. NAV → BC behavioral changes documented:
    //    - Payment Terms Code modifications moved to subscriber (OnBeforeValidatePaymentTermsCode)
    //    - Posting Date logic retained as-is (NAV commented logic kept same)
    //    - Currency Factor updates moved to event subscriber
    //    - OnLookup triggers removed (BC table trigger restriction)
    // 8. Comment Drink-IT All fields
    // 9. For Sell-to Customer No. - OnValidate() Customize code (//HEI.11>>), we suscribe this event  OnValidateSellToCustomerNoOnBeforeCheckBlockedCustOnDocs
    // 10. For Sell-to Customer No. - OnValidate() Customize code (// >>HEI.09 IBM>CHAUHB01 03/02/2018) , we suscribe this event OnCopySelltoCustomerAddressFieldsFromCustomerOnBeforeAssignRespCenter
    // 11. For Sell-to Customer No. - OnValidate() Customize code //WHT ,We Suscribe this event OnAfterCheckSellToCust
    // 12. For Bill-to Customer No. - OnValidate() Customize code (//HEI.11>>), We suscribe this event OnValidateBillToCustomerNoOnBeforeCheckBlockedCustOnDocs
    // 13. For Prices Including VAT - OnValidate() Customize code (//<<HEI.59), We suscribe this event OnAfterConfirmSalesPrice
    // 14. For OnDelete() Customize code ( //<<HEI.59) , We suscribe this event OnBeforeShowPostedDocsToPrintCreatedMsg
    // 15. For Posting Date -  OnValidate() Customize code (//<<HEI.38 ) , We suscribe this event for block the base code  OnValidatePostingDateOnBeforeCheckNeedUpdateCurrencyFactor
    // 16. For Payment Terms Code - OnValidate() Customize code (// >>HEI.48) , We suscribe this event OnBeforeValidatePaymentTermsCode
    // 17. For Function CreateSalesLine Customize code (//HEI.54>>,//HEI.60>>), Wesuscribe this event OnCreateSalesLineOnBeforeAssignType
    // 18. For Function OnBeforeUpdateOpportunity Customize code (//<<HEI.59), We Suscribe this event OnBeforeUpdateOpportunity and create this function GetOpportunityEntryEstimatedValue because we block base unction and add customize code after use base code so this function is in base code
    // 19. Replace TryGetnextno with Getnextno in function InsertFAGLJnlLinesForRPMDamageLoss.
    // 20. There is a function name CheckAvailableCreditLimit have HEI Code //HEI.66>> but in that code drink-it field is used .
    // 21. There is a custom code in the function ConfirmUpdateDeferralDate //<<HEI.59 but the same custom code provide by the base 
    // 22. BC Upgrade BHARDA11 >> ----This code //<<HEI.59 is used in CheckCustomerCreated this function in sales header table , For this we use this event OnCheckCustomerCreatedOnBeforeConfirmProcess
    // 23. BC Upgrade BHARDA11 >> ----This code  //HEI.54>> is in RecreateSalesLines this function in sales header table . we use this event OnBeforeRecreateSalesLinesHandleSupplementTypes
    // 24. BC Upgrade BHARDA11 >> --- There is a code //<<HEI.59 on fuction in navision ConfirmResvDateConflict but the function name change in BC (ConfirmReservationDateConflict) this function is use only in sales header table and we have a custom code //<<HEI.59 in this function
    // 25. BC Upgrade BHARDA11 >> --- This Code  //<<HEI.59 is use in the function ConfirmDeletion in sales header table for that we use this event OnBeforeCheckNoAndShowConfirm

    // BC Upgrade BHARDA11 <<

    // BC Upgrade SHUKLP03 >> Document Subtype code added.
    // Sell-to Customer No. - OnValidate()
    // field 50090 "Document Subtype Code".
    // DIT procedure SetDefaultPostingSerialno() created.
    // Subscribed event OnBeforeInitRecord to add HEI.22 code of procedure InitRecord().
    // Subscribed event OnAfterInitRecord to add code of procedure InitRecord().
    // Subscribed event OnUpdateSalesLinesByFieldNoOnAfterCalcShouldConfirmReservationDateConflict
    // BC Upgrade SHUKLP03 << Document Subtype code added.
    // HEI.23 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #fields "Load No." & "Sequence No."
    //   HEI.26 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //     # New Field created: 50031 - Suppress POS Interface

    // BC Upgrade MISHRS14 >>
    // Changed table extension name to "SalesHeaderInterfaceExtFND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    // BC Upgrade SHUKLP03 >> Added OTC008 testscript changes.

    fields
    {
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order', FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
        }
        modify("Sell-to Customer No.")
        {

            //Unsupported feature: Change TableRelation on ""Sell-to Customer No."(Field 2)". Please convert manually.

            CaptionML = ENU = 'Sell-to Customer No.', FRA = 'N° donneur d''ordre';
            // OptionCaptionML = 
            //BC UPGRADE KUMARR78 --
            // TableRelation = IF ("Document Type" = FILTER(Quote | Order | "Return Order")) Customer WHERE("Avail. for Sales/Return Order" = CONST(true))
            // ELSE
            // Customer; // BC Upgrade BHARDA11
            //BC UPGRADE KUMARR78 --

            //Unsupported feature: Change Description on ""Sell-to Customer No."(Field 2)". Please convert manually.
            trigger OnBeforeValidate()
            var
                SellToCust: Record Customer;
                CustLocationCode: Code[10];
                HasRecreateSalesLines: Boolean;
                DocumentSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";  // BC Upgrade SHUKLP03 <<
            begin
                //HEI.15
                // BC Upgrade SHUKLP03 >> Document subtype code added.
                IF Cust1.GET("Sell-to Customer No.") THEN BEGIN
                    IF DocumentSubtypeCodeSetup.GET THEN;
                    IF (((Cust1."Contract Type FND" = Cust1."Contract Type FND"::"Full Contract") OR
                      (Cust1."Contract Type FND" = Cust1."Contract Type FND"::"CTS Only")) AND
                       ("Document Subtype Code FND" <> DocumentSubtypeCodeSetup."CTS Order")) THEN
                        ERROR(Err002, DocumentSubtypeCodeSetup."CTS Order");
                END;
                // BC Upgrade SHUKLP03 << Document subtype code added.
                //HEI.15
            end;

        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Bill-to Customer No.")
        {
            CaptionML = ENU = 'Bill-to Customer No.', FRA = 'N° client facturé';
            trigger OnAfterValidate()
            var
                Cust: Record Customer;
                BilltoCustomerNoChanged: Boolean;
            begin
                // BC Upgrade BHARDA11 >> -- Drink-IT Field ("Ship Other Bill-to Customer")
                // BilltoCustomerNoChanged := xRec."Bill-to Customer No." <> "Bill-to Customer No.";
                // IF (xRec."Sell-to Customer No." = "Sell-to Customer No.") AND
                //                                                      BilltoCustomerNoChanged
                //                                                   THEN BEGIN
                //     //<< FINXL9.00.000.01 AKH 13/01/2017
                //     IF ShipmentLineExists() AND (recUserSetup."Ship Other Bill-to Customer") THEN
                //         UpdateSalesLines(FIELDCAPTION("Bill-to Customer No."), CurrFieldNo <> 0)
                //     ELSE
                //         //>> FINXL9.00.000.01 AKH 13/01/2017
                //         // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
                //         //RecreateSalesLines(BillToCustomerTxt);
                //         //  HasRecreateSalesLines := RecreateSalesLines(BillToCustomerTxt);
                //         // >>DITW18.00.07 DDR DIT-770 #1402
                //         BilltoCustomerNoChanged := FALSE;
                // END;
                // BC Upgrade BHARDA11 << -- Drink-IT Field ("Ship Other Bill-to Customer")
                //HEI.40>>
                // BC Upgrade SHUKLP03 >> OTC008 => Field (Cust."Send Document") 
                if Cust.get("Bill-to Customer No.") then;
                IF "Document Type" <> "Document Type"::Quote THEN BEGIN
                    IF "Bill-to Customer No." <> '' THEN
                        "Send Document FND" := Cust."Send Document FND"
                    ELSE
                        "Send Document FND" := "Send Document FND"::" ";
                END;
                // BC Upgrade SHUKLP03 << OTC008 => Field (Cust."Send Document")

                //HEI.40<<

            end;
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
            // BC Upgrade BHARDA11 ---- Field length change attempted 50→60 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 100
            //Unsupported feature: Change Data type on ""Bill-to Address"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Bill-to Address', FRA = 'Adresse facturation';
            Description = 'HEI.03';
            //Unsupported feature: Change Description on ""Bill-to Address"(Field 7)". Please convert manually.

        }
        modify("Bill-to Address 2")
        {
            // BC Upgrade BHARDA11 ---- Field length change attempted 50→60 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 50

            //Unsupported feature: Change Data type on ""Bill-to Address 2"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Bill-to Address 2', FRA = 'Adresse (2ème ligne)';
            Description = 'HEI.03';

            //Unsupported feature: Change Description on ""Bill-to Address 2"(Field 8)". Please convert manually.

        }
        modify("Bill-to City")
        {
            // BC Upgrade BHARDA11 ---- Field length change attempted 30→35 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 30

            //Unsupported feature: Change Data type on ""Bill-to City"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Bill-to City', FRA = 'Ville';
            Description = 'HEI.03';

            //Unsupported feature: Change Description on ""Bill-to City"(Field 9)". Please convert manually.

        }
        modify("Bill-to Contact")
        {
            CaptionML = ENU = 'Bill-to Contact', FRA = 'Contact';
        }
        modify("Your Reference")
        {
            // BC Upgrade BHARDA11 ---- Field length change attempted 35→50 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 35
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
            // BC Upgrade BHARDA11 ---- Field length change attempted 50→60 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 100

            //Unsupported feature: Change Data type on ""Ship-to Address"(Field 15)". Please convert manually.

            CaptionML = ENU = 'Ship-to Address', FRA = 'Adresse destinataire';
            Description = 'HEI.03';
            //Unsupported feature: Change Description on ""Ship-to Address"(Field 15)". Please convert manually.

        }
        modify("Ship-to Address 2")
        {
            // BC Upgrade BHARDA11 ---- Field length change attempted 50→60 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 50
            //Unsupported feature: Change Data type on ""Ship-to Address 2"(Field 16)". Please convert manually.

            CaptionML = ENU = 'Ship-to Address 2', FRA = 'Adresse destinataire 2';
            Description = 'HEI.03';

            //Unsupported feature: Change Description on ""Ship-to Address 2"(Field 16)". Please convert manually.

        }
        modify("Ship-to City")
        {
            // BC Upgrade BHARDA11 ---- Field length change attempted 30→35 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 30

            //Unsupported feature: Change Data type on ""Ship-to City"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Ship-to City', FRA = 'Ville destinataire';
            Description = 'HEI.03';
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
            Description = 'HEI.03';
            trigger OnBeforeValidate()
            begin
                // >>HEI.48
                VALIDATE("Payment Terms Code");
                // <<HEI.48
                // BC Upgrade BHARDA11 >>
                /*  Document date is being validated with the posting date because it is commented in NAV as well.
                  However, in Business Central the event is being called from multiple places,
                  so this logic has been left unchanged for now. 
                  The UpdateCurrencyFactor was also commented out earlier, so we have applied that change as well threw eventsuscriber. */
                // BC Upgrade BHARDA11 <<
            end;
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
            trigger OnAfterValidate()
            begin
                // BC Upgrade BHARDA11 >>
                /* All modifications and code changes for this section have been written inside the
                Eventsuscriber (OnBeforeValidatePaymentTermsCode) */
                // BC Upgrade BHARDA11 <<
            end;
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
            trigger OnAfterValidate()
            var
            // WhseTransportMgt: Codeunit "Warehouse & Transport Mgt."; // BC Upgrade BHARDA11 ----Drink-IT Codeunit
            begin
                // BC Upgrade BHARDA11 >> ----Drink-IT codeunit (WhseTransportMgt)
                /*   IF ("Shipment Method Code" <> xRec."Shipment Method Code") AND
                                                                      (xRec."Sell-to Customer No." = "Sell-to Customer No.")
                                                                   THEN BEGIN
                      IF "Shipment Method Code" <> '' THEN BEGIN
                          rShipmentMethod.GET("Shipment Method Code");
                          //>> HEI.34
                          IF "Shipment Method Code" <> xRec."Shipment Method Code" THEN
                              WhseTransportMgt.DeleteSalesShippingCost(xRec, TRUE);
                          //<< HEI.34
                      end;

                  END ELSE BEGIN
                      //>> HEI.33 FDD-HT658 IBM.GUNERE01 30.09.2019
                      IF "Shipment Method Code" <> xRec."Shipment Method Code" THEN
                          IF "Shipment Method Code" = '' THEN
                              WhseTransportMgt.DeleteSalesShippingCost(xRec, TRUE);
                      CreateShippingCost(Rec, TRUE, TRUE); //HEI.34
                                                           //<< HEI.33 FDD-HT658 IBM.GUNERE01 30.09.2019
                  end; */
                // BC Upgrade BHARDA11 << ----Drink-IT Codeunit (WhseTransportMgt)
            end;

        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 28)". Please convert manually.
            // BC Upgrade BHARDA11 Tablerelation using DRINK-IT Field (Location Table Filter)
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
            // BC Upgrade BHARDA11 ----Field Length Change 20 to 10 , Not supported in business central, Field length is 20
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
            trigger OnBeforeValidate()
            begin
                // BC Upgrade BHARDA11 >> 
                /* All modifications and code changes for this section have been written inside the
                OnAfterConfirmSalesPrice */
                // BC Upgrade BHARDA11 <<
            end;
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
            CaptionML = ENU = 'Salesperson Code', FRA = 'Code vendeur';
        }
        modify("Order Class")
        {
            CaptionML = ENU = 'Order Class', FRA = 'Type commande';
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
            // OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêt';
            // BC Upgrade BHARDA11 ---In Nav Applies-to Doc. Type field is option type but in BC the field type is enum
            //Unsupported feature: Change OptionString on ""Applies-to Doc. Type"(Field 52)". Please convert manually.


            //Unsupported feature: Change Description on ""Applies-to Doc. Type"(Field 52)". Please convert manually.

        }
        modify("Applies-to Doc. No.")
        {
            CaptionML = ENU = 'Applies-to Doc. No.', FRA = 'N° doc. lettrage';
        }
        modify("Bal. Account No.")
        {
            CaptionML = ENU = 'Bal. Account No.', FRA = 'N° compte contrepartie';
        }
        modify("Recalculate Invoice Disc.")
        {
            CaptionML = ENU = 'Recalculate Invoice Disc.', FRA = 'Recalculer remise facture';
        }
        modify(Ship)
        {
            CaptionML = ENU = 'Ship', FRA = 'Reste à livrer';
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
        modify("Shipping No.")
        {
            CaptionML = ENU = 'Shipping No.', FRA = 'Utiliser B.L. N°';
        }
        modify("Posting No.")
        {
            CaptionML = ENU = 'Posting No.', FRA = 'N° validation';
        }
        modify("Last Shipping No.")
        {
            CaptionML = ENU = 'Last Shipping No.', FRA = 'N° dern. bon de livraison';
        }
        modify("Last Posting No.")
        {
            CaptionML = ENU = 'Last Posting No.', FRA = 'N° dern. facture';
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
        modify("VAT Registration No.")
        {
            CaptionML = ENU = 'VAT Registration No.', FRA = 'N° identif. intracomm.';
        }
        modify("Combine Shipments")
        {
            CaptionML = ENU = 'Combine Shipments', FRA = 'Regroupement B.L.';
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

            //Unsupported feature: Change TableRelation on ""Sell-to Customer Name"(Field 79)". Please convert manually.

            CaptionML = ENU = 'Sell-to Customer Name', FRA = 'Nom du donneur d''ordre';

            //Unsupported feature: Change Description on ""Sell-to Customer Name"(Field 79)". Please convert manually.

        }
        modify("Sell-to Customer Name 2")
        {
            CaptionML = ENU = 'Sell-to Customer Name 2', FRA = 'Nom du donneur d''ordre 2';
        }
        modify("Sell-to Address")
        {
            // BC Upgrade BHARDA11 ---- Field length change attempted 50→60 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 100
            //Unsupported feature: Change Data type on ""Sell-to Address"(Field 81)". Please convert manually.

            CaptionML = ENU = 'Sell-to Address', FRA = 'Adresse donneur d''ordre';

            //Unsupported feature: Change Description on ""Sell-to Address"(Field 81)". Please convert manually.

        }
        modify("Sell-to Address 2")
        {
            // BC Upgrade BHARDA11 ---- Field length change attempted 50→60 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 50

            //Unsupported feature: Change Data type on ""Sell-to Address 2"(Field 82)". Please convert manually.

            CaptionML = ENU = 'Sell-to Address 2', FRA = 'Adresse donneur d''ordre 2';

            //Unsupported feature: Change Description on ""Sell-to Address 2"(Field 82)". Please convert manually.

        }
        modify("Sell-to City")
        {
            // BC Upgrade BHARDA11 ---- Field length change attempted 30→35 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 30

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
            // OptionCaptionML = ENU = 'G/L Account,Bank Account', FRA = 'Général,Banque';
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
            trigger OnAfterValidate()
            begin
                //<<HEI.38 - Code is added to calculate Currency Factor when changing the Document Date instead of changing the Posting Date
                IF ("Document Type" IN ["Document Type"::Invoice, "Document Type"::"Credit Memo"]) AND
                   NOT ("Posting Date" = xRec."Posting Date")
                THEN
                    PriceMessageIfSalesLinesExist(FIELDCAPTION("Posting Date"));

                IF "Currency Code" <> '' THEN BEGIN
                    UpdateCurrencyFactor();
                    // BC Upgrade BHARDA11 >> ----Drink-IT Function (ConfirmUpdateCurrencyFactor)
                    // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
                    // InitHasBeenShow(HasBeenShowText021, '', FIELDNO("Document Date"));
                    // >>DITW16.00.00.43 DDR DIT-715 #860
                    // IF "Currency Factor" <> xRec."Currency Factor" THEN
                    //     ConfirmUpdateCurrencyFactor;
                    // BC Upgrade BHARDA11 << ----Drink-IT Function (ConfirmUpdateCurrencyFactor)
                END;
                //>>HEI.38
            end;
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

            //Unsupported feature: Change TableRelation on ""Shipping Agent Code"(Field 105)". Please convert manually.
            // TableRelation = IF ("Responsibility Center" = CONST()) "Shipping Agent" WHERE("Responsibility Center" = FIELD("Resp. Center Table Filter"))
            // ELSE IF ("Responsibility Center" = FILTER(<> '')) "Shipping Agent" WHERE("Responsibility Center" = FIELD("Resp. Center Table Filter 2")); // BC Upgrade BHARDA11 ----Drink-IT Field("Responsibility Center")
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';

            //Unsupported feature: Change Description on ""Shipping Agent Code"(Field 105)". Please convert manually.
            trigger OnAfterValidate()
            begin
                //HEI.16>>
                // BC Upgrade BHARDA11 >> ----Drink-IT Field (ShippingAgent."Vendor No.")
                /*  IF "Document Type" = "Document Type"::Order THEN BEGIN
                     IF ShippingAgent.GET("Shipping Agent Code") THEN BEGIN
                         //HEI.27>>
                         //IF ShippingAgent."Vendor No." = '' THEN
                         IF (ShippingAgent."Vendor No." = '') AND (NOT ShippingAgent."Own Logistics") THEN
                             //HEI.27<<
                             ERROR(ShippingAgentVendorIsBlank)
                         ELSE IF Vend.GET(ShippingAgent."Vendor No.") THEN BEGIN
                             IF Vend.Blocked <> 0 THEN
                                 ERROR(VendorBlockForShipAgent);
                         END;
                     END;
                 END; */
                // BC Upgrade BHARDA11 << ----Drink-IT Field (ShippingAgent."Vendor No.")
                //HEI.16<<
            end;

        }
        // BC Upgrade BHARDA11 >>
        // modify("Package Tracking No.")
        // {
        //     CaptionML = ENU = 'Package Tracking No.', FRA = 'N° récépissé';
        // }
        // BC Upgrade BHARDA11 <<
        modify("No. Series")
        {
            // BC Upgrade BHARDA11 ---- Field length change attempted 20→10 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 20

            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Posting No. Series")
        {
            // BC Upgrade BHARDA11 ---- Field length change attempted 20→10 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 20

            CaptionML = ENU = 'Posting No. Series', FRA = 'Souches de n° validation';
        }
        modify("Shipping No. Series")
        {
            // BC Upgrade BHARDA11 ---- Field length change attempted 20→10 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 20

            CaptionML = ENU = 'Shipping No. Series', FRA = 'Souche de n° expédition';
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
            // BC Upgrade BHARDA11 ---- Field length change attempted 20→10 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 20
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify(Reserve)
        {
            CaptionML = ENU = 'Reserve', FRA = 'Réserver';
            // OptionCaptionML = ENU = 'Never,Optional,Always', FRA = 'Jamais,Manuel,Toujours';
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
            //OptionCaptionML = ENU = 'Open,Released,Pending Approval,Pending Prepayment', FRA = 'Ouvert,Lancé,Approbation suspendue,Acompte suspendu';
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
            //OptionCaptionML = ENU = 'New,Pending,Sent', FRA = 'Nouveau,Suspendu,Envoyé';
        }
        modify("Sell-to IC Partner Code")
        {
            CaptionML = ENU = 'Sell-to IC Partner Code', FRA = 'Code parten IC donneur d''ordre';
        }
        modify("Bill-to IC Partner Code")
        {
            CaptionML = ENU = 'Bill-to IC Partner Code', FRA = 'Code du partenaire IC facturé';
        }
        modify("IC Direction")
        {
            CaptionML = ENU = 'IC Direction', FRA = 'Direction IC';
            //OptionCaptionML = ENU = 'Outgoing,Incoming', FRA = 'Sortant,Entrant';
        }
        modify("Prepayment %")
        {
            CaptionML = ENU = 'Prepayment %', FRA = '% acompte';
        }
        modify("Prepayment No. Series")
        {
            // BC Upgrade BHARDA11 ---- Field length change attempted 20→10 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 20

            CaptionML = ENU = 'Prepayment No. Series', FRA = 'N° de série acompte';
        }
        modify("Compress Prepayment")
        {
            CaptionML = ENU = 'Compress Prepayment', FRA = 'Compresser acompte';
        }
        modify("Prepayment Due Date")
        {
            CaptionML = ENU = 'Prepayment Due Date', FRA = 'Échéance acompte';
        }
        modify("Prepmt. Cr. Memo No. Series")
        {
            // BC Upgrade BHARDA11 ---- Field length change attempted 20→10 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 20
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
            //OptionCaptionML = ENU = ' ,Scheduled for Posting,Error,Posting', FRA = ' ,Planifié pour la validation,Erreur,Validation';
        }
        modify("Job Queue Entry ID")
        {
            CaptionML = ENU = 'Job Queue Entry ID', FRA = 'ID écriture file d''attente des travaux';
        }
        modify("Incoming Document Entry No.")
        {
            CaptionML = ENU = 'Incoming Document Entry No.', FRA = 'N° de séquence du document entrant';
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
        modify("Direct Debit Mandate ID")
        {
            CaptionML = ENU = 'Direct Debit Mandate ID', FRA = 'ID mandat domiciliation européenne';
        }
        modify("Invoice Discount Amount")
        {
            CaptionML = ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
        }
        modify("No. of Archived Versions")
        {
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
        // BC Upgrade BHARDA11 >> --Not Found "Sell-to Customer Template Code"
        // modify("Sell-to Customer Template Code")
        // {
        //     CaptionML = ENU = 'Sell-to Customer Template Code', FRA = 'Code modèle donneur d''ordre';
        // }
        // BC Upgrade BHARDA11 << ---"Sell-to Customer Template Code"
        modify("Sell-to Contact No.")
        {
            CaptionML = ENU = 'Sell-to Contact No.', FRA = 'N° contact donneur d''ordre';
            // BC Upgrade BHARDA11 >>
            /* All modifications and code changes for this section have been written inside the
            OnBeforeCheckContactRelatedToCustomerCompany */
            // BC Upgrade BHARDA11 <<
        }
        modify("Bill-to Contact No.")

        {
            CaptionML = ENU = 'Bill-to Contact No.', FRA = 'N° contact facturation';
        }
        // BC Upgrade BHARDA11 >> --- "Bill-to Customer Template Code" not found
        // modify("Bill-to Customer Template Code")
        // {
        //     CaptionML = ENU = 'Bill-to Customer Template Code', FRA = 'Code modèle client facturé';
        // }
        // BC Upgrade BHARDA11 << --- "Bill-to Customer Template Code" not found

        modify("Opportunity No.")
        {
            CaptionML = ENU = 'Opportunity No.', FRA = 'N° opportunité';
        }
        modify("Responsibility Center")
        {

            //Unsupported feature: Change TableRelation on ""Responsibility Center"(Field 5700)". Please convert manually.

            CaptionML = ENU = 'Responsibility Center', FRA = 'Centre de gestion';
        }
        modify("Shipping Advice")
        {
            CaptionML = ENU = 'Shipping Advice', FRA = 'Option d''expédition';
            //OptionCaptionML = ENU = 'Partial,Complete', FRA = 'Partielle,Totale';
        }
        modify("Shipped Not Invoiced")
        {
            CaptionML = ENU = 'Shipped Not Invoiced', FRA = 'Livré non facturé';
        }
        modify("Completely Shipped")
        {
            CaptionML = ENU = 'Completely Shipped', FRA = 'Entièrement expédiée';
        }
        modify("Posting from Whse. Ref.")
        {
            CaptionML = ENU = 'Posting from Whse. Ref.', FRA = 'Validation à partir réf. entrepôt';
        }
        modify("Location Filter")
        {
            CaptionML = ENU = 'Location Filter', FRA = 'Filtre magasin';
        }
        modify(Shipped)
        {
            CaptionML = ENU = 'Shipped', FRA = 'Expédié';
        }
        modify("Requested Delivery Date")
        {
            CaptionML = ENU = 'Requested Delivery Date', FRA = 'Date livraison demandée';
            trigger OnAfterValidate()
            var
                ShippingTime: Text;
            begin
                // >>HEI.51
                // BC Upgrade BHARDA11 >> ----Drink-IT Function (UpdateRoutePlanRqstLines)
                // IF xRec."Requested Delivery Date" <> "Requested Delivery Date" THEN
                //     UpdateRoutePlanRqstLines(FIELDCAPTION("Requested Delivery Date"));
                // BC Upgrade BHARDA11 << ----Drink-IT Function (UpdateRoutePlanRqstLines)
                // <<HEI.51

                // >>HEI.57
                IF "Requested Delivery Date" <> 0D THEN BEGIN
                    ShippingTime := '';
                    ShippingTime := '<-' + FORMAT("Shipping Time") + '>';
                    IF ShippingTime = '<->' THEN BEGIN
                        IF "Requested Delivery Date" >= WORKDATE THEN
                            VALIDATE("Shipment Date", "Requested Delivery Date")
                        ELSE
                            VALIDATE("Shipment Date", WORKDATE);
                    END ELSE BEGIN
                        IF CALCDATE(ShippingTime, "Requested Delivery Date") >= WORKDATE THEN
                            VALIDATE("Shipment Date", CALCDATE(ShippingTime, "Requested Delivery Date"))
                        ELSE
                            VALIDATE("Shipment Date", WORKDATE);
                    END;
                END;
                // <<HEI.57

            end;

        }
        modify("Shipping Time")
        {
            trigger OnAfterValidate()
            var
                ShippingTime: TEXT;
            begin
                //HEI.57>>
                IF "Shipping Time" <> xRec."Shipping Time" THEN
                    IF "Requested Delivery Date" <> 0D THEN BEGIN
                        ShippingTime := '';
                        ShippingTime := '<-' + FORMAT("Shipping Time") + '>';
                        IF ShippingTime = '<->' THEN BEGIN
                            IF "Requested Delivery Date" >= WORKDATE THEN
                                VALIDATE("Shipment Date", "Requested Delivery Date")
                            ELSE
                                VALIDATE("Shipment Date", WORKDATE);
                        END ELSE BEGIN
                            IF CALCDATE(ShippingTime, "Requested Delivery Date") >= WORKDATE THEN
                                VALIDATE("Shipment Date", CALCDATE(ShippingTime, "Requested Delivery Date"))
                            ELSE
                                VALIDATE("Shipment Date", WORKDATE);
                        END;
                    END;
                //HEI.57<<

            end;
        }
        modify("Promised Delivery Date")
        {
            CaptionML = ENU = 'Promised Delivery Date', FRA = 'Date livraison confirmée';
        }

        modify("Outbound Whse. Handling Time")
        {
            CaptionML = ENU = 'Outbound Whse. Handling Time', FRA = 'Délai désenlogement';
        }
        modify("Shipping Agent Service Code")
        {
            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
            // BC Upgrade BHARDA11 >> ---- we can not add Onlookup trigger in base field in table , we can add only in page 
            /*  trigger OnLookup()
             begin
                 //>> HEI.39
                 FilterShippingAgentServiceCode;
                 //<< HEI.39
             end; */
            // BC Upgrade BHARDA11 << ---- we can not add Onlookup trigger in base field in table , we can add only in page 

        }
        modify("Late Order Shipping")
        {
            CaptionML = ENU = 'Late Order Shipping', FRA = 'Expédition en retard';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify(Receive)
        {
            CaptionML = ENU = 'Receive', FRA = 'Recevoir';
        }
        modify("Return Receipt No.")
        {
            CaptionML = ENU = 'Return Receipt No.', FRA = 'N° réception retour';
        }
        modify("Return Receipt No. Series")
        {
            // BC Upgrade BHARDA11 ---- Field length change attempted 20→10 but NOT IMPLEMENTED , Cannot modify field length in BC extension.Field length is 20

            CaptionML = ENU = 'Return Receipt No. Series', FRA = 'Souche de n° réception retour';
        }
        modify("Last Return Receipt No.")
        {
            CaptionML = ENU = 'Last Return Receipt No.', FRA = 'Dernier n° réception retour';
        }
        modify("Allow Line Disc.")
        {
            CaptionML = ENU = 'Allow Line Disc.', FRA = 'Autoriser remise ligne';
        }
        modify("Get Shipment Used")
        {
            CaptionML = ENU = 'Get Shipment Used', FRA = 'Extraire le mode d''expédition utilisé';
        }
        modify("Assigned User ID")
        {
            CaptionML = ENU = 'Assigned User ID', FRA = 'Code utilisateur affecté';
        }

        //Unsupported feature: CodeInsertion on ""Sell-to Customer No."(Field 2).OnValidate". Please convert manually.

        //trigger (Variable: SellToCust)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Sell-to Customer No."(Field 2).OnValidate". Please convert manually.

        //trigger "(Field 2)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckCreditLimitIfLineNotInsertedYet;
        TESTFIELD(Status,Status::Open);
        if ("Sell-to Customer No." <> xRec."Sell-to Customer No.") and
           (xRec."Sell-to Customer No." <> '')
        then begin
          if ("Opportunity No." <> '') and ("Document Type" in ["Document Type"::Quote,"Document Type"::Order]) then
            ERROR(
              Text062,
              FIELDCAPTION("Sell-to Customer No."),
              FIELDCAPTION("Opportunity No."),
              "Opportunity No.",
              "Document Type");
          if HideValidationDialog or not GUIALLOWED then
            Confirmed := true
          else
            Confirmed := CONFIRM(ConfirmChangeQst,false,SellToCustomerTxt);
          if Confirmed then begin
            SalesLine.SETRANGE("Document Type","Document Type");
            SalesLine.SETRANGE("Document No.","No.");
        #20..34
            CheckReturnInfo(SalesLine,false);

            SalesLine.RESET;
          end else begin
            Rec := xRec;
            exit;
          end;
        end;
        #43..55

        GetCust("Sell-to Customer No.");

        Cust.CheckBlockedCustOnDocs(Cust,"Document Type",false,false);
        Cust.TESTFIELD("Gen. Bus. Posting Group");
        "Sell-to Customer Template Code" := '';
        "Sell-to Customer Name" := Cust.Name;
        #63..65
          "Sell-to Contact" := Cust.Contact;
        "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
        "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
        "Tax Area Code" := Cust."Tax Area Code";
        "Tax Liable" := Cust."Tax Liable";
        "VAT Registration No." := Cust."VAT Registration No.";
        "VAT Country/Region Code" := Cust."Country/Region Code";
        "Shipping Advice" := Cust."Shipping Advice";
        "Responsibility Center" := UserSetupMgt.GetRespCenter(0,Cust."Responsibility Center");
        VALIDATE("Location Code",UserSetupMgt.GetLocation(0,Cust."Location Code","Responsibility Center"));

        if "Sell-to Customer No." = xRec."Sell-to Customer No." then
          if ShippedSalesLinesExist or ReturnReceiptExist then begin
            TESTFIELD("VAT Bus. Posting Group",xRec."VAT Bus. Posting Group");
            TESTFIELD("Gen. Bus. Posting Group",xRec."Gen. Bus. Posting Group");
          end;

        "Sell-to IC Partner Code" := Cust."IC Partner Code";
        "Send IC Document" := ("Sell-to IC Partner Code" <> '') and ("IC Direction" = "IC Direction"::Outgoing);

        if Cust."Bill-to Customer No." <> '' then
          VALIDATE("Bill-to Customer No.",Cust."Bill-to Customer No.")
        else begin
          if "Bill-to Customer No." = "Sell-to Customer No." then
            SkipBillToContact := true;
          VALIDATE("Bill-to Customer No.","Sell-to Customer No.");
          SkipBillToContact := false;
        end;
        VALIDATE("Ship-to Code",'');

        GetShippingTime(FIELDNO("Sell-to Customer No."));

        if (xRec."Sell-to Customer No." <> "Sell-to Customer No.") or
           (xRec."Currency Code" <> "Currency Code") or
           (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group") or
           (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")
        then
          RecreateSalesLines(SellToCustomerTxt);

        if not SkipSellToContact then
          UpdateSellToCont("Sell-to Customer No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.15

        if Cust1.GET("Sell-to Customer No.") then begin
        if DocumentSubtypeCodeSetup.GET then;
        if (((Cust1."Contract Type" = Cust1."Contract Type"::"Full Contract") or
          (Cust1."Contract Type" = Cust1."Contract Type"::"CTS Only")) and
           ("Document Subtype Code" <> DocumentSubtypeCodeSetup."CTS Order")) then
           ERROR(Err002,DocumentSubtypeCodeSetup."CTS Order");

        end;

        //HEI.15
        //<< DITW17.10.05 YHE 02/09/2014 DIT-770 #754 - DDR 22/09/2014 DIT-770 #754 - DITW19.00.08A DDR 28/02/2017 NRQ#18985
        SelltoCustomerNoChanged := (xRec."Sell-to Customer No." <> "Sell-to Customer No.");
        // <<DITW110.00.09 DDR 12/04/2017 NRQ#23026
        if ((CurrFieldNo = FIELDNO("Sell-to Customer No.")) or (CurrFieldNo = FIELDNO("Sell-to Customer Name"))) and
          ("Document Type" = "Document Type"::Order)
        // >>DITW110.00.09 DDR NRQ#23026
        then begin
          fctCheckAlertExistingOrder;
          if HasSelectPendingOrder then begin
            "Sell-to Customer No." := xRec."Sell-to Customer No.";
        #40..42
        //>> DITW17.10.05 YHE 02/09/2014 DIT-770 #754 - DITW19.00.08A DDR NRQ#18985

        /// DITW18.00.07 AKH 09/05/2016 DIT-770 #1939 - DITW19.00.08A DDR 28/02/2017 NRQ#18985

        CheckCreditLimitIfLineNotInsertedYet;

        //<< DITW18.00.07 AKH 09/05/2016 DIT-770 #1939 - DITW19.00.08A DDR 28/02/2017 NRQ#18985
        if "No." <> '' then // see CheckCreditLimitIfLineNotInsertedYet
          InitRecOnCustUpdate();
        //>> DITW18.00.07 AKH DIT-770 #1939 - DITW19.00.08A DDR NRQ#18985

        //<<DITW18.00 MSF 27/04/2015 DIT-770 #1363
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159

        /// DITW17.10.05 YHE 02/09/2014 DIT-770 #754 - DDR 22/09/2014 DIT-770 #754 - DITW19.00.08A DDR NRQ#18985
        //>>DITW18.00 MSF 27/04/2015 DIT-770 #1363

        #3..5
          // <<DITW17.10.05 WSA 28/11/2014 DIT-770 #779
          TESTFIELD("Event No.",'');
          // >>DITW17.10.05 WSA 28/11/2014 DIT-770 #779
        #6..12
          // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
          InitHasBeenShow(HasBeenShowSellTo,'',FIELDNO("Sell-to Customer No."));
          if HideValidationDialog or not GUIALLOWED or HasBeenShowSellTo then
          // >>DITW16.00.00.43 DDR DIT-715 #860
        #14..16
          // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
          HasBeenShowSellTo := Confirmed;
          // >>DITW16.00.00.43 DDR DIT-715 #860
        #17..37

            // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
            if "Document Type" = "Document Type"::Order then
              TestIfEmcsSalesLinesExist(FIELDCAPTION("Sell-to Customer No."));
            // >>DITW16.00.00.43 DDR DIT-715 #720
            // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
            fctClearDeliveryTimes;
            // >>DITW18.00.07 DDR DIT-770 #1488
        #38..58
        //HEI.11>>
        //Cust.CheckBlockedCustOnDocs(Cust,"Document Type",FALSE,FALSE);
        Cust.CheckBlockedCustOnDocs2(Cust,"Document Type",false,false,0,false,false,false);
        //HEI.11<<
        #60..68
        "WHT Business Posting Group" := Cust."WHT Business Posting Group";//WHT
        #69..73
        // <<DITW16.00.00.42 DDR 02/01/2013 DIT-715 #529
        "Salesperson Code" := Cust."Salesperson Code";
        // >>DITW16.00.00.42 DDR DIT-715 #529
        //<<DITW18.00.06 MSF 20/10/2015 DIT-770 #1180
        if  not SelltoCustomerNoChanged then
        //>>DITW18.00.06 MSF 20/10/2015 DIT-770 #1180
          "Responsibility Center" := UserSetupMgt.GetRespCenter(0,Cust."Responsibility Center");
        //VALIDATE("Location Code",UserSetupMgt.GetLocation(0,Cust."Location Code","Responsibility Center"));

        // <<DITW16.00.00.42 DDR 12/12/2012 14/12/2012 DIT-715 #520
        if IsCustCalcPrices(Cust,SalesSetup."Bill-to/Sell-to Prices Calc."::"Sell-to") then begin
          if "Document Type" = "Document Type"::Order then
            "Prepayment %" := Cust."Prepayment %";
          "Customer Price Group" := Cust."Customer Price Group";
          "Allow Line Disc." := Cust."Allow Line Disc.";
          "Invoice Disc. Code" := Cust."Invoice Disc. Code";
          "Customer Disc. Group" := Cust."Customer Disc. Group";
        end;
        // >>DITW16.00.00.42 DDR DIT-715 #520

        //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
        "Invoice Method" := Cust."Invoice Method";
        "Invoice Period" := Cust."Invoice Period";
        "Truck Zone":= Cust."Truck Zone";
        "Require 2 Drivers" := Cust."Require 2 Drivers";
        "Picking Type" := Cust."Picking Type";
        "Ship-to Address Key No." := Cust."Ship-to Address Key No.";
        //>>DITW17.00.02 TEC1 DIT-770 #154
        //<< DITW18.00.07 AKH 19/02/2016 - 09/05/2016 DIT-770 #1804
          VALIDATE("Sundry Customer",Cust."Sundry Customer");
        //>> DITW18.00.07 AKH DIT-770 #1804
        // <<DITW15.00.00.01 DDR 27/12/2007
        "Customer DTax Group Code" := Cust."Customer DTax Group Code";
        // >>DITW15.00.00.01 DDR
        // <<DITW15.00.00.01 DDR 27/12/2007
        "Customer DDeposit Group Code" := Cust."Customer DDeposit Group Code";
        // >>DITW15.00.00.01 DDR
        // <<DITW15.00.00.24 DDR 14/08/2008
        Distance := Cust.Distance;
        // >>DITW15.00.00.24 DDR
        // <<DITW16.00.00.40 DDR 12/12/2011 #1002
        "Delivery Sequence" := Cust."Delivery Sequence";
        // >>DITW16.00.00.40 DDR #1002
        // <<DITW19.00.08 DDR 12/08/2016 BL#10314
        if ("Document Type" in ["Document Type"::Order,"Document Type"::"Return Order"]) or
          SalesSetup."Shipment on Invoice" or SalesSetup."Return Receipt on Credit Memo"
        then
        // >>DITW19.00.08 DDR BL#10314
          //<< DITW18.00.07 AKH 27/04/2016 DIT-770 #1346
          "Customer Delivery Type" := Cust."Customer Delivery Type";
          //>> DITW18.00.07 AKH DIT-770 #1346
        // <<DITW15.00.00.28 DDR 24/11/2008
        "Customer Tax Registration No." := Cust."Tax Registration No.";
        "Fiscal Representative No." := Cust."Fiscal Representative No.";
        // >>DITW15.00.00.28 DDR
        // <<DITW15.00.00.38 DDR 13/09/2010 #1217
        "Customer Tax Warehouse Ref." := Cust."Tax Warehouse Reference";
        // >>DITW15.00.00.38 DDR
        // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
        "Tax Office Code" := Cust."Tax Office Code";
        // <<DITW15.00.00.38 DDR #1217 (DIT711 137)
        // <<DITW15.00.00.39 DDR 06/07/2011 #1353
        "Journey Time" := Cust."Journey Time";
        // >>DITW15.00.00.39 DDR #1353

        // <<DITW15.00.00.35 DDR 24/06/2009
        "Gen. Bus. Posting Free Group" := Cust."Gen. Bus. Posting Free Group";
        "Free Item Posting Type" := Cust."Free Item Posting Type";
        // >>DITW15.00.00.35 DDR
        // <<DITW15.00.00.35 DDR 10/04/2009
        "Building No." := Cust."Building No.";
        // >>DITW15.00.00.35 DDR

        // <<HEI.09 IBM>CHAUHB01 03/02/2018
        "Sales Routes" := Cust."Sales Routes";
        // >>HEI.09 IBM>CHAUHB01 03/02/2018
        #76..80
            // <<DITW15.00.00.34 DDR 09/07/2009
            TESTFIELD("Customer DTax Group Code",xRec."Customer DTax Group Code");
            TESTFIELD("Customer DDeposit Group Code",xRec."Customer DDeposit Group Code");
            // >>DITW15.00.00.34 DDR
            TESTFIELD("WHT Business Posting Group",xRec."WHT Business Posting Group");//WHT
        #81..85
        // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
        if xRec."Sell-to Customer No." <> "Sell-to Customer No." then
          "Ship-to Code" := '';
        // >>DITW16.00.00.43 DDR DIT-715 #860

        #86..93
        // <<DITW17.10.03 DDR 12/05/2014 DIT-770 #361


        // <<DITW18.00.06 MSF 15/06/2015 DIT-770 #1413
        if CustSellto."Responsibility Center" <> '' then begin
          // <<DITW18.00.06 DDR 02/03/2015 DIT-770 #1190
          UserSetupMgt.SetRespCenterDoc("Responsibility Center");
          VALIDATE("Responsibility Center",UserSetupMgt.GetRespCenter(0,CustSellto."Responsibility Center"));
          // >>DITW18.00.06 DDR DIT-770 #1190
        end;

          CustLocationCode := UserSetupMgt.GetLocation(0,CustSellto."Location Code","Responsibility Center");

        if (CustLocationCode <> '')  then begin
          // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1190
          if UserSetupMgt.CheckLocation(0,CustLocationCode,"Responsibility Center") then
          // >>DITW18.00.06 DDR DIT-770 #1190
            VALIDATE("Location Code",CustLocationCode)
          else begin
            if HideValidationDialog or not GUIALLOWED then
              Confirmed := true
            else
              Confirmed :=
                CONFIRM(Text2014414 + Text2014415,false,
                  CustSellto.TABLECAPTION,"Sell-to Customer No.",
                  FIELDCAPTION("Location Code"),CustLocationCode);
            if not Confirmed then
              ERROR(Text2014416);
          end;
        end;
        //>>DITW18.00.06 MSF 15/06/2015 DIT-770 #1413

        //<< DITW19.00.08 AKH 20/09/2016 BL#10756
        if (CustSellto."Return Location Code" <>'') then
          VALIDATE("Return Location Code",CustSellto."Return Location Code");
        //>> DITW19.00.08 AKH BL#10756
        SellToCust.GET("Sell-to Customer No.");
        // <<DITW19.00.08 DDR 12/08/2016 BL#10314
        if "Document Type" in ["Document Type"::Order,"Document Type"::"Return Order"] then begin
        // >>DITW19.00.08 DDR BL#10314
          //<<DITW17.00.02 AT  06/06/2012 DIT-770 #146
          VALIDATE("Shipment Date Formula",SellToCust."Shipment Date Formula");
          //>>DITW17.00.02 AT  06/06/2012 DIT-770 #146
          //<< DITW18.00.07 VSC 23/06/2016 DIT-770 #2058
          SetRoute(SellToCust,SalesSetup);
          //>> DITW18.00.07 VSC DIT-770 #2058
        end;
        // <<DITW16.00.00.43 DDR 13/05/2013 DIT-715 #604
        //<< DITW17.10.03 VSC 16/04/2014 DIT-770 #387 :If blank in t.222 do not update sales header, but keep existing values (from customer)
        VALIDATE("Ship-to Code",'');
        //>> DITW17.10.03 VSC 16/04/2014 DIT-770 #387
        //<<DITW17.00.02 AT 26/12/2013 DIT-770 #314
        //VALIDATE("Ship-to Code",Cust."Default Ship-to Code");
        // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
        if SellToCust."Ship-to Code" <> '' then
        // >>DITW18.00.07 DDR DIT-770 #1488
          VALIDATE("Ship-to Code",SellToCust."Ship-to Code");
        //>>DITW17.00.02 AT DIT-770 #314
        // >>DITW16.00.00.43 DDR DIT-715 #604

        //>> HEI.33 FDD-HT658 IBM.GUNERE01 26.09.2019
        CreateShippingCost(Rec,true,false);
        //<< HEI.33 FDD-HT658 IBM.GUNERE01 26.09.2019
        GetShippingTime(FIELDNO("Sell-to Customer No."));
        // <<DITW15.00.00.39 DDR 06/07/2011 #1353
        GetJourneyTime(FIELDNO("Sell-to Customer No."));
        // >>DITW15.00.00.39 DDR #1353
        #97..100
           (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group") or
           // <<DITW15.00.00.35 DDR 24/06/2009
           (xRec."Gen. Bus. Posting Free Group" <> "Gen. Bus. Posting Free Group") or
           // >>DITW15.00.00.35 DDR
           // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
           ((xRec."Order Date" <> "Order Date") and (SalesSetup."Sales Conditions Based on" = SalesSetup."Sales Conditions Based on"::OrderDate)) or
           ((xRec."Shipment Date" <> "Shipment Date") and (SalesSetup."Sales Conditions Based on" = SalesSetup."Sales Conditions Based on"::ShipRecvDate)) or
           (xRec."Customer Price Group" <> "Customer Price Group") or
           (xRec."Customer Disc. Group" <> "Customer Disc. Group") or
           (xRec."Shipment Method Code" <> "Shipment Method Code")
           // >>DITW18.00.07 DDR DIT-770 #1402
        then
          // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
          //RecreateSalesLines(SellToCustomerTxt);
          HasRecreateSalesLines := RecreateSalesLines(SellToCustomerTxt);
          // >>DITW18.00.07 DDR DIT-770 #1402

        // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
        if not HasRecreateSalesLines then begin
          if xRec."Customer DTax Group Code" <> "Customer DTax Group Code" then begin
            // <<DITW17.10.03 DDR 19/05/2014 DIT-770 #623
            UpdateSalesLines(FIELDCAPTION("Customer DTax Group Code"),CurrFieldNo <> 0);
            // >>DITW17.10.03 DDR DIT-770 #623
            RecreateChargeSalesLines(FIELDCAPTION("Customer DTax Group Code"));
          end;
          if xRec."Customer DDeposit Group Code" <> "Customer DDeposit Group Code" then
            RecreateChargeSalesLines(FIELDCAPTION("Customer DDeposit Group Code"));
        end;
        // >>DITW16.00.00.43 DDR DIT-715 #691
        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
        HasRecreateSalesLines := false;
        // >>DITW18.00.07 DDR DIT-770 #1402
        #104..106

        // <<DITW15.00.00.39 RBE 21/04/2011 #1230
        fctFillDeliverySequence();
        // >>DITW15.00.00.39 RBE #1230
        //<<DITW18.00.06 MSF 06/07/2015 DIT-770 #1212 #1213 #1214
        UpdatefromCustrespcenterrelation;
        //>>DITW18.00.06 MSF 06/07/2015 DIT-770 #1212 #1213 #1214
        // <<DITW18.00.07 MVN 07/04/2016 DIT-770 #1397
        if ApplMgt.IsObjectLicense(5,CODEUNIT::"EMCS EDI Mgt",4) <> 0 then
        // >>DITW18.00.07 MVN DIT-770 #1397
          // <<DITW18.00.07 MVN 21/01/2016 DIT-770 #1397
          "Submission Type" := EMCSEDIMgt.GetSubmissionType(1,"Customer DTax Group Code","Location Code");
          // >>DITW18.00.07 MVN DIT-770 #1397
        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        if xRec."Sell-to Customer No." <> "Sell-to Customer No." then
          UpdateRoutePlanRqstLines(FIELDCAPTION("Sell-to Customer No."));
        // >>DITW18.00.07 DDR DIT-770 #1488
        //<<DITW18.00.07 KJB 18/02/2016 DIT-770 #1042
        if "Document Type" = "Document Type"::Order then begin
          SalesSetup.GET;
          if SalesSetup."Copy Comments Cust. to Sell-to" and ("Sell-to Customer No." <> '') then
            CopyCustCommentToSales;
        end;
        //>>DITW18.00.07 KJB DIT-770 #1042

        //<< DITW18.00.07 VSC 28/06/2016 DIT-770 #1282
        CheckLatestOrderDateTime(FIELDNO("Sell-to Customer No."));
        //>> DITW18.00.07 VSC DIT-770 #1282
        */
        //end;


        //Unsupported feature: CodeModification on ""No."(Field 3).OnValidate". Please convert manually.

        //trigger "(Field 3)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "No." <> xRec."No." then begin
          SalesSetup.GET;
          NoSeriesMgt.TestManual(GetNoSeriesCode);
          "No. Series" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
          "No. Series" := '' ;
        end;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Bill-to Customer No."(Field 4).OnValidate". Please convert manually.

        //trigger (Variable: HasRecreateSalesLines)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Bill-to Customer No."(Field 4).OnValidate". Please convert manually.

        //trigger "(Field 4)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        BilltoCustomerNoChanged := xRec."Bill-to Customer No." <> "Bill-to Customer No.";
        if BilltoCustomerNoChanged then
          if xRec."Bill-to Customer No." = '' then
            InitRecord
          else begin
            if HideValidationDialog or not GUIALLOWED then
              Confirmed := true
            else
              Confirmed := CONFIRM(ConfirmChangeQst,false,BillToCustomerTxt);
            if Confirmed then begin
              SalesLine.SETRANGE("Document Type","Document Type");
              SalesLine.SETRANGE("Document No.","No.");

              CheckShipmentInfo(SalesLine,true);
              CheckPrepmtInfo(SalesLine);
              CheckReturnInfo(SalesLine,true);

              SalesLine.RESET;
            end else
              "Bill-to Customer No." := xRec."Bill-to Customer No.";
          end;

        GetCust("Bill-to Customer No.");
        Cust.CheckBlockedCustOnDocs(Cust,"Document Type",false,false);
        Cust.TESTFIELD("Customer Posting Group");
        CheckCrLimit;
        "Bill-to Customer Template Code" := '';
        "Bill-to Name" := Cust.Name;
        "Bill-to Name 2" := Cust."Name 2";
        CopyBillToCustomerAddressFieldsFromCustomer(Cust);
        if not SkipBillToContact then
          "Bill-to Contact" := Cust.Contact;
        "Payment Terms Code" := Cust."Payment Terms Code";
        "Prepmt. Payment Terms Code" := Cust."Payment Terms Code";

        if "Document Type" = "Document Type"::"Credit Memo" then begin
          "Payment Method Code" := '';
          if PaymentTerms.GET("Payment Terms Code") then
            if PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then
              "Payment Method Code" := Cust."Payment Method Code"
        end else
          "Payment Method Code" := Cust."Payment Method Code";

        GLSetup.GET;
        if GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." then begin
          "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
          "VAT Country/Region Code" := Cust."Country/Region Code";
          "VAT Registration No." := Cust."VAT Registration No.";
          "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
        end;
        "Customer Posting Group" := Cust."Customer Posting Group";
        "Currency Code" := Cust."Currency Code";
        "Customer Price Group" := Cust."Customer Price Group";
        "Prices Including VAT" := Cust."Prices Including VAT";
        "Allow Line Disc." := Cust."Allow Line Disc.";
        "Invoice Disc. Code" := Cust."Invoice Disc. Code";
        "Customer Disc. Group" := Cust."Customer Disc. Group";
        "Language Code" := Cust."Language Code";
        "Salesperson Code" := Cust."Salesperson Code";
        "Combine Shipments" := Cust."Combine Shipments";
        Reserve := Cust.Reserve;
        if "Document Type" = "Document Type"::Order then
          "Prepayment %" := Cust."Prepayment %";

        if not BilltoCustomerNoChanged then begin
          if ShippedSalesLinesExist then begin
            TESTFIELD("Customer Disc. Group",xRec."Customer Disc. Group");
            TESTFIELD("Currency Code",xRec."Currency Code");
          end;
        end;

        CreateDim(
          DATABASE::Customer,"Bill-to Customer No.",
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Customer Template","Bill-to Customer Template Code");

        VALIDATE("Payment Terms Code");
        VALIDATE("Prepmt. Payment Terms Code");
        VALIDATE("Payment Method Code");
        VALIDATE("Currency Code");
        VALIDATE("Prepayment %");

        if (xRec."Sell-to Customer No." = "Sell-to Customer No.") and
           BilltoCustomerNoChanged
        then begin
          RecreateSalesLines(BillToCustomerTxt);
          BilltoCustomerNoChanged := false;
        end;
        if not SkipBillToContact then
          UpdateBillToCont("Bill-to Customer No.");

        "Bill-to IC Partner Code" := Cust."IC Partner Code";
        "Send IC Document" := ("Bill-to IC Partner Code" <> '') and ("IC Direction" = "IC Direction"::Outgoing);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW18.00 MSF 27/04/2015 DIT-770 #1363
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //>>DITW18.00 MSF 27/04/2015 DIT-770 #1363
        #2..6
            // <<DITW17.10.05 WSA 28/11/2014 DIT-770 #779
            TESTFIELD("Event No.",'');
            // >>DITW17.10.05 WSA 28/11/2014 DIT-770 #779

            // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
            InitHasBeenShow(HasBeenShowBillTo,'',FIELDNO("Bill-to Customer No."));
            // >>DITW16.00.00.43 DDR DIT-715 #860

            // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
            //IF HideValidationDialog OR NOT GUIALLOWED THEN
            if HideValidationDialog or not GUIALLOWED or HasBeenShowBillTo  then
            // >>DITW16.00.00.43 DDR DIT-715 #860
        #8..10

            // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
            HasBeenShowBillTo := Confirmed;
            // >>DITW16.00.00.43 DDR DIT-715 #860
        #11..19

              // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
              if "Document Type" = "Document Type"::Order then
                TestIfEmcsSalesLinesExist(FIELDCAPTION("Bill-to Customer No."));
              // >>DITW16.00.00.43 DDR DIT-715 #720
        #20..23
        // <<DITW16.00.00.42 DDR 12/12/2012 DIT-715 #520
        GetCust("Sell-to Customer No.");
        CustSellto := Cust;
        // >>DITW16.00.00.42 DDR DIT-715 #520

        GetCust("Bill-to Customer No.");
        //HEI.11>>
        //Cust.CheckBlockedCustOnDocs(Cust,"Document Type",FALSE,FALSE);
        if "Bill-to Customer No." <> "Sell-to Customer No." then
          Cust.CheckBlockedCustOnDocs2(Cust,"Document Type",false,false,1,false,false,false);
        //HEI.11<<
        Cust.TESTFIELD("Customer Posting Group");

        // <<DITW18.00.07 WSA 18/03/2016 DIT-770 #1723
        "Invoice List Customer No." := Cust."Invoice List Customer No.";
        // >>DITW18.00.07 WSA 18/03/2016 DIT-770 #1723

        // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
        if Cust."Split Deposit on Invoice" then
          Cust.TESTFIELD(Cust."Deposit Cust. Posting Group")
        else begin
          "Deposit Cust. Posting Group" := '';
          "Deposit Payment Terms Code" := '';
          "Deposit Payment Method Code" := '';
          "Deposit Bal. Account Type" := 0;
          "Deposit Bal. Account No." := '';
        end;
        // >>DITW16.00.00.42 DDR DIT-715 #370
        // <<DITW18.00.06 DDR 05/11/2015 DIT-770 #1623 (move)
        //CheckCrLimit;
        // >>DITW18.00.06 DDR DIT-770 #1623
        #28..33
        //<<DITW17.00.02 TEC1 05/09/2013 DIT-770 #140
        //<< DITW18.00.07 AKH 11/05/2015 DIT-770 #1983
        if CustSellto."Calculate Payment Terms From" = CustSellto."Calculate Payment Terms From"::"Sell-to Customer" then begin
        //>> DITW18.00.07 AKH DIT-770 #1983
          "Payment Terms Code" := CustSellto."Payment Terms Code";
          if CustSellto."Split Deposit on Invoice" then
            "Deposit Payment Terms Code" := CustSellto."Deposit Payment Terms Code";
        end else begin
        //>>DITW17.00.02 TEC1 DIT-770 #140
          "Payment Terms Code" := Cust."Payment Terms Code";
          "Prepmt. Payment Terms Code" := Cust."Payment Terms Code";
          // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
          if Cust."Split Deposit on Invoice" then
            "Deposit Payment Terms Code" := Cust."Deposit Payment Terms Code";
          // >>DITW16.00.00.42 DDR DIT-715 #370
        //<<DITW17.00.02 TEC1 05/09/2013 DIT-770 #140
        end;
        //>>DITW17.00.02 TEC1 DIT-770 #140
        // <<DITW18.00.06 DDR 05/11/2015 DIT-770 #1623 (move)
        CheckCrLimit;
        // >>DITW18.00.06 DDR DIT-770 #1623

        //<<DITW17.00.02 TEC1 05/09/2013 DIT-770 #140
        //<< DITW18.00.07 AKH 11/05/2015 DIT-770 #1983
        if CustSellto."Calculate Payment Method From" = CustSellto."Calculate Payment Method From"::"Sell-to Customer" then begin
        //>> DITW18.00.07 AKH DIT-770 #1983
          if "Document Type" = "Document Type"::"Credit Memo" then begin
            "Payment Method Code" := '';
            if PaymentTerms.GET("Payment Terms Code") then
              if PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then
                "Payment Method Code" := CustSellto."Payment Method Code"
          end else
            "Payment Method Code" := CustSellto."Payment Method Code";

          if CustSellto."Split Deposit on Invoice" then begin
            if "Document Type" = "Document Type"::"Credit Memo" then begin
              "Deposit Payment Method Code" := '';
               if PaymentTerms.GET("Deposit Payment Terms Code") then
                 if PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then
                   "Deposit Payment Method Code" := CustSellto."Deposit Payment Method Code";
            end else
              "Deposit Payment Method Code" := CustSellto."Deposit Payment Method Code";
          end;
        end else begin
        //>>DITW17.00.02 TEC1 DIT-770 #140
        #37..44
        // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
        if Cust."Split Deposit on Invoice" then begin
          if "Document Type" = "Document Type"::"Credit Memo" then begin
            "Deposit Payment Method Code" := '';
             if PaymentTerms.GET("Deposit Payment Terms Code") then
               if PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then
                 "Deposit Payment Method Code" := Cust."Deposit Payment Method Code";
          end else
            "Deposit Payment Method Code" := Cust."Deposit Payment Method Code";
        end;
        // >>DITW16.00.00.42 DDR DIT-715 #370
        //<<DITW17.00.02 TEC1 05/09/2013 DIT-770 #140
        end;
        //>>DITW17.00.02 TEC1 DIT-770 #140

        "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
        // <<DITW15.00.00.35 DDR 24/06/2009
        "Gen. Bus. Posting Free Group" := Cust."Gen. Bus. Posting Free Group";
        "Free Item Posting Type" := Cust."Free Item Posting Type";
        // >>DITW15.00.00.35 DDR
        // <<DITW15.00.00.39 DDR 27/07/2011 #1407
        "Autom. Item Charge" := Cust."Autom. Item Charge";
        // >>DITW15.00.00.39 DDR #1407

        #45..47
          "WHT Business Posting Group" := Cust."WHT Business Posting Group";//WHT
        #48..52
        // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
        if Cust."Split Deposit on Invoice" then
          "Deposit Cust. Posting Group" := Cust."Deposit Cust. Posting Group";
        // >>DITW16.00.00.42 DDR DIT-715 #370
        "Currency Code" := Cust."Currency Code";
        // <<DITW16.00.00.42 DDR 12/12/2012 14/12/2012 DIT-715 #520
        //"Customer Price Group" := Cust."Customer Price Group";
        //"Allow Line Disc." := Cust."Allow Line Disc.";
        //"Invoice Disc. Code" := Cust."Invoice Disc. Code";
        //"Customer Disc. Group" := Cust."Customer Disc. Group";
        if IsCustCalcPrices(CustSellto,SalesSetup."Bill-to/Sell-to Prices Calc."::"Bill-to") then begin
          if "Ship-to Code" = '' then
            "Customer Price Group" := Cust."Customer Price Group";
          "Allow Line Disc." := Cust."Allow Line Disc.";
          "Invoice Disc. Code" := Cust."Invoice Disc. Code";
          "Customer Disc. Group" := Cust."Customer Disc. Group";
        end;
        // >>DITW16.00.00.42 DDR DIT-715 #520
        "Prices Including VAT" := Cust."Prices Including VAT";
        "Language Code" := Cust."Language Code";

        // <<DITW16.00.00.42 DDR 02/01/2013 DIT-715 #529
        SalesSetup.GET;
        if SalesSetup."Bill-to/Sell-to Salespers./P." = SalesSetup."Bill-to/Sell-to Salespers./P."::"Bill-to" then
        // >>DITW16.00.00.42 DDR DIT-715 #529
          "Salesperson Code" := Cust."Salesperson Code";
        "Combine Shipments" := Cust."Combine Shipments";
        Reserve := Cust.Reserve;
        // <<DITW16.00.00.42 DDR 12/12/2012 14/12/2012 DIT-715 #520
        if IsCustCalcPrices(CustSellto,SalesSetup."Bill-to/Sell-to Prices Calc."::"Bill-to") then begin
        // >>DITW16.00.00.42 DDR DIT-715 #520
          if "Document Type" = "Document Type"::Order then
            "Prepayment %" := Cust."Prepayment %";
        // <<DITW15.00.00.01 DDR 27/12/2007 - DITW15.00.00.25 DDR 21/10/2008 - DITW15.00.00.38 DDR 23/02/2011 #1286
        end;
        // <<DITW15.00.00.01 DDR 27/12/2007 - DITW15.00.00.25 DDR 21/10/2008 - DITW15.00.00.38 DDR 23/02/2011 #1286
        // <<DITW16.00.00.42 DDR 12/12/2012 14/12/2012 DIT-715 #520
        if ("Ship-to Code" = '') and IsCustCalcTaxes(CustSellto,GLSetup."Sell-to/Bill-to DTax Gr. Calc."::"Bill-to/Pay-to No.") then
        // >>DITW16.00.00.42 DDR DIT-715 #520
          "Customer DTax Group Code" := Cust."Customer DTax Group Code";
        // >>DITW15.00.00.38 DDR #1286
        // <<DITW16.00.00.42 DDR 12/12/2012 14/12/2012 DIT-715 #520
        if IsCustCalcPrices(CustSellto,SalesSetup."Bill-to/Sell-to Prices Calc."::"Bill-to") then
        // >>DITW16.00.00.42 DDR DIT-715 #520
          // <<DITW15.00.00.01 DDR 27/12/2007
            "Customer DDeposit Group Code" := Cust."Customer DDeposit Group Code";
          // >>DITW15.00.00.01 DDR
        // <<DITW15.00.00.35 DDR 10/04/2009 - 21/09/2009
        if ("Building No." <> Cust."Building No.") and
          (Cust."Building No." <> '')
        then begin
          if SalesSetup."Bill-to/Sell-to Building Dim." = SalesSetup."Bill-to/Sell-to Building Dim."::"Bill-to" then begin
            Building.GET(Cust."Building No.");
            Building.TESTFIELD(Blocked,false);
            "Building No." := Cust."Building No.";
          end;
        end;
        // >>DITW15.00.00.35 DDR

        // <<DITW16.00.00.40 DDR 16/04/2012 DIT-715 #247
        if ("Ship-to Code" <> '') and ("Sell-to Customer No." <> '') then begin
          ShipToAddr.GET("Sell-to Customer No.","Ship-to Code");
          if ShipToAddr."Customer Price Group" <> '' then
            "Customer Price Group" := ShipToAddr."Customer Price Group";
          // <<DITW16.00.00.43 DDR 30/07/2013 DIT-715 #719
          if ShipToAddr."Customer DTax Group Code" <> '' then
            "Customer DTax Group Code" := ShipToAddr."Customer DTax Group Code";
          // >>DITW16.00.00.43 DDR DIT-715 #719
          //<<DITW17.00.02 TEC1 06/09/2013 DIT-770 #141
          if ShipToAddr."Customer DDeposit Group Code" <> '' then
            "Customer DDeposit Group Code" := ShipToAddr."Customer DDeposit Group Code";
          //>>DITW17.00.02 TEC1 DIT-770 #141
        end;
        // >>DITW16.00.00.40 DDR DIT-715 #247
        #65..69
            // <<DITW15.00.00.34 DDR 09/07/2009
            TESTFIELD("Customer DTax Group Code",xRec."Customer DTax Group Code");
            TESTFIELD("Customer DDeposit Group Code",xRec."Customer DDeposit Group Code");
            // >>DITW15.00.00.34 DDR
        #70..72
        //<<DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362
        CreateDim(
          DATABASE::Customer,GetCustNoCalcDim(),
        #75..77
          DATABASE::"Customer Template","Bill-to Customer Template Code",
          DATABASE::Building,"Building No.",
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(1,"Contract Type"),GetContractNo);
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //>>DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362
        #79..82
        // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
        VALIDATE("Deposit Payment Terms Code");
        VALIDATE("Deposit Payment Method Code");
        // >>DITW16.00.00.42 DDR DIT-715 #370
        #83..88
          //<< FINXL9.00.000.01 AKH 13/01/2017
          if ShipmentLineExists() and (recUserSetup."Ship Other Bill-to Customer") then
            UpdateSalesLines(FIELDCAPTION("Bill-to Customer No."),CurrFieldNo <> 0)
          else
          //>> FINXL9.00.000.01 AKH 13/01/2017
            // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
            //RecreateSalesLines(BillToCustomerTxt);
            HasRecreateSalesLines := RecreateSalesLines(BillToCustomerTxt);
            // >>DITW18.00.07 DDR DIT-770 #1402
          BilltoCustomerNoChanged := false;
        end;

        // <<DITW15.00.00.25 DDR 21/10/2008
        if (xRec."Sell-to Customer No." = "Sell-to Customer No.") and
           (xRec."Bill-to Customer No." = "Bill-to Customer No.") and
           // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
           not HasRecreateSalesLines
           // >>DITW16.00.00.43 DDR DIT-715 #691
        then begin
          if xRec."Customer DTax Group Code" <> "Customer DTax Group Code" then begin
            // <<DITW17.10.03 DDR 19/05/2014 DIT-770 #623
            UpdateSalesLines(FIELDCAPTION("Customer DTax Group Code"),CurrFieldNo <> 0);
            // >>DITW17.10.03 DDR DIT-770 #623
            // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
            RecreateChargeSalesLines(FIELDCAPTION("Customer DTax Group Code"));
          end;
            // >>DITW16.00.00.43 DDR DIT-715 #691
           if xRec."Customer DDeposit Group Code" <> "Customer DDeposit Group Code" then
            // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
            RecreateChargeSalesLines(FIELDCAPTION("Customer DDeposit Group Code"));
            // >>DITW16.00.00.43 DDR DIT-715 #691
        end;
        // >>DITW15.00.00.25 DDR

        // <<DITW15.00.00.39 DDR 27/07/2011 #1407
        if (xRec."Sell-to Customer No." = "Sell-to Customer No.") and
           (xRec."Bill-to Customer No." = "Bill-to Customer No.") and
           (xRec."Autom. Item Charge" <> "Autom. Item Charge")
        then begin
          // <<DITW16.00.00.42 DDR 01/03/2013 DIT-715 #572
          SalesLine.RESET;
          // >>DITW16.00.00.42 DDR DIT-715 #572
          DeleteChargeSalesLines();
        end;
        // >>DITW15.00.00.39 DDR #1407

        #92..96

         // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488 -DITW111.00.13A MSF 22/04/2019 NRQ#103938
        if xRec."Bill-to Customer No." <> "Bill-to Customer No." then begin
          UpdateRoutePlanRqstLines(FIELDCAPTION("Bill-to Customer No."));
          /// DITW111.00.13A DDR 03/07/2019 NRQ#103938
        end;
        // >>DITW18.00.07 DDR DIT-770 #1488-DITW111.00.13A MSF 22/04/2019 NRQ#103938

        //HEI.40>>
        if "Document Type" <> "Document Type"::Quote then begin
          if "Bill-to Customer No." <> '' then
            "Send Document" := Cust."Send Document"
          else
            "Send Document" := "Send Document"::" ";
        end;
        //HEI.40<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Ship-to Code"(Field 12).OnValidate". Please convert manually.

        //trigger (Variable: Cust2)();
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
        if ("Document Type" = "Document Type"::Order) and
           (xRec."Ship-to Code" <> "Ship-to Code")
        then begin
          SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::Order);
          SalesLine.SETRANGE("Document No.","No.");
          SalesLine.SETFILTER("Purch. Order Line No.",'<>0');
          if not SalesLine.ISEMPTY then
            ERROR(
              Text006,
              FIELDCAPTION("Ship-to Code"));
          SalesLine.RESET;
        end;

        if not IsCreditDocType then
          if "Ship-to Code" <> '' then begin
            if xRec."Ship-to Code" <> '' then
              begin
              GetCust("Sell-to Customer No.");
              if Cust."Location Code" <> '' then
                VALIDATE("Location Code",Cust."Location Code");
              "Tax Area Code" := Cust."Tax Area Code";
            end;
            ShipToAddr.GET("Sell-to Customer No.","Ship-to Code");
            "Ship-to Name" := ShipToAddr.Name;
            "Ship-to Name 2" := ShipToAddr."Name 2";
            "Ship-to Address" := ShipToAddr.Address;
            "Ship-to Address 2" := ShipToAddr."Address 2";
            "Ship-to City" := ShipToAddr.City;
            "Ship-to Post Code" := ShipToAddr."Post Code";
            "Ship-to County" := ShipToAddr.County;
            VALIDATE("Ship-to Country/Region Code",ShipToAddr."Country/Region Code");
            "Ship-to Contact" := ShipToAddr.Contact;
            "Shipment Method Code" := ShipToAddr."Shipment Method Code";
            if ShipToAddr."Location Code" <> '' then
              VALIDATE("Location Code",ShipToAddr."Location Code");
            "Shipping Agent Code" := ShipToAddr."Shipping Agent Code";
            "Shipping Agent Service Code" := ShipToAddr."Shipping Agent Service Code";
            if ShipToAddr."Tax Area Code" <> '' then
              "Tax Area Code" := ShipToAddr."Tax Area Code";
            "Tax Liable" := ShipToAddr."Tax Liable";
          end else
            if "Sell-to Customer No." <> '' then begin
              GetCust("Sell-to Customer No.");
              "Ship-to Name" := Cust.Name;
              "Ship-to Name 2" := Cust."Name 2";
              CopyShipToCustomerAddressFieldsFromCustomer(Cust);
              "Ship-to Contact" := Cust.Contact;
              "Shipment Method Code" := Cust."Shipment Method Code";
              "Tax Area Code" := Cust."Tax Area Code";
              "Tax Liable" := Cust."Tax Liable";
              if Cust."Location Code" <> '' then
                VALIDATE("Location Code",Cust."Location Code");
              "Shipping Agent Code" := Cust."Shipping Agent Code";
              "Shipping Agent Service Code" := Cust."Shipping Agent Service Code";
            end;

        GetShippingTime(FIELDNO("Ship-to Code"));

        if (xRec."Sell-to Customer No." = "Sell-to Customer No.") and
           (xRec."Ship-to Code" <> "Ship-to Code")
        then
          if (xRec."VAT Country/Region Code" <> "VAT Country/Region Code") or
             (xRec."Tax Area Code" <> "Tax Area Code")
          then
            RecreateSalesLines(FIELDCAPTION("Ship-to Code"))
          else begin
            if xRec."Shipping Agent Code" <> "Shipping Agent Code" then
              MessageIfSalesLinesExist(FIELDCAPTION("Shipping Agent Code"));
            if xRec."Shipping Agent Service Code" <> "Shipping Agent Service Code" then
              MessageIfSalesLinesExist(FIELDCAPTION("Shipping Agent Service Code"));
            if xRec."Tax Liable" <> "Tax Liable" then
              VALIDATE("Tax Liable");
          end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Event No.",'');
        // >>DITW17.10.05 WSA 28/11/2014 DIT-770 #779
        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
        SalesSetup.GET;
        // >>DITW18.00.07 DDR DIT-770 #1402
        #1..10
          // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
          TestIfEmcsSalesLinesExist(FIELDCAPTION("Ship-to Code"));
          // >>DITW16.00.00.43 DDR DIT-715 #720
          SalesLine.RESET;
          // <<DITW15.00.00.39 RBE 21/04/2011 #1230
          fctFillDeliverySequence();
          // >>DITW15.00.00.39 RBE #1230
          //>>DITW18.00.06 MSF 06/07/2015 DIT-770 #1212 #1213 #1214
          UpdatefromCustrespcenterrelation;
          //<<DITW18.00.06 MSF 06/07/2015 DIT-770 #1212 #1213 #1214
          // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
          fctFillDeliveryTimes("Sell-to Customer No.","Ship-to Code","Shipment Date");
          // >>DITW18.00.07 DDR DIT-770 #1488
        end;

        //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
        if "Ship-to Code" <> '' then begin
          ShipToAddr.GET("Sell-to Customer No.","Ship-to Code");
          //<<DITW17.00.02 SR 12/26/2013 DIT-770 #298
          if ShipToAddr."Truck Zone" <> ShipToAddr."Truck Zone"::" " then
            "Truck Zone":= ShipToAddr."Truck Zone";
          //<<DITW17.00.02 SR 12/26/2013 DIT-770 #298
          if ShipToAddr."Require 2 Drivers" = true then
            "Require 2 Drivers" := ShipToAddr."Require 2 Drivers";
          //<<DITW17.00.02 SR 12/26/2013 DIT-770 #298
          if ShipToAddr."Picking Type" <> ShipToAddr."Picking Type"::" " then
            "Picking Type" := ShipToAddr."Picking Type";
          //<<DITW17.00.02 SR 12/26/2013 DIT-770 #298
          if ShipToAddr."Ship-to Address Key No." <> '' then
            "Ship-to Address Key No." := ShipToAddr."Ship-to Address Key No.";
        end;
        //>>DITW17.00.02 TEC1 DIT-770 #154
        #13..15
            if xRec."Ship-to Code" <> '' then begin
              GetCust("Sell-to Customer No.");
              // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1190
              CustLocationCode := UserSetupMgt.GetLocation(0,Cust."Location Code","Responsibility Center");
              if (CustLocationCode <> '') and (Cust."Location Code" <> '') and (CustLocationCode <> Cust."Location Code") then begin
              // >>DITW18.00.06 DDR DIT-770 #1190
                if Cust."Location Code" <> '' then
                  VALIDATE("Location Code",Cust."Location Code");
              end;
        #21..30
            //<<DITW18.00 MSF 27/04/2015 DIT-770 #1363
            // <<DITW16.00.00.40 DDR 12/12/2011 #1002
            // <<DITW17.00.02 SR 12/26/2013 DIT-770 #298 - DITW19.00.08 DDR 12/08/2016 BL#10314
            if (ShipToAddr.Route <> '') and ("Document Type" in ["Document Type"::Order,"Document Type"::"Return Order"]) then
            // >>DITW17.00.02 SR 12/26/2013 DIT-770 #298 - DITW19.00.08 DDR BL#10314
              VALIDATE(Route,ShipToAddr.Route);
            if ShipToAddr."Delivery Sequence" <> 0 then
              "Delivery Sequence" := ShipToAddr."Delivery Sequence";
            // >>DITW16.00.00.40 DDR #1002
            //<< DITW17.10.03 VSC 16/04/2014 DIT-770 #387 :If blank in t.222 do not update sales header, but keep existing values (from customer)
            if ShipToAddr."Country/Region Code" <> '' then
            //>>DITW18.00 MSF 27/04/2015 DIT-770 #1363
              VALIDATE("Ship-to Country/Region Code",ShipToAddr."Country/Region Code");
            //>> DITW17.10.03 VSC 16/04/2014 DIT-770 #387
            "Ship-to Contact" := ShipToAddr.Contact;
            //<<DITW17.00.02 SR 12/26/2013 DIT-770 #298
            //"Shipment Method Code" := ShipToAddr."Shipment Method Code";
            if ShipToAddr."Shipment Method Code" <> '' then
              // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
              VALIDATE("Shipment Method Code",ShipToAddr."Shipment Method Code");
              // >>DITW18.00.07 DDR DIT-770 #1488
            if ShipToAddr."Location Code" <> '' then
              VALIDATE("Location Code",ShipToAddr."Location Code");
            //"Shipping Agent Code" := ShipToAddr."Shipping Agent Code";
            //"Shipping Agent Service Code" := ShipToAddr."Shipping Agent Service Code";
            //<< DITW19.00.08 AKH 20/09/2016 BL#10756
            if ShipToAddr."Return Location Code" <> '' then
              VALIDATE("Return Location Code",ShipToAddr."Return Location Code");
            //>> DITW19.00.08 AKH BL#10756
            //<<DITW17.00.02 SR 12/26/2013 DIT-770 #298
            if ShipToAddr."Shipping Agent Code" <> '' then
              // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
              VALIDATE("Shipping Agent Code",ShipToAddr."Shipping Agent Code");
              // >>DITW18.00.07 DDR DIT-770 #1488
            //<<DITW17.00.02 SR 12/26/2013 DIT-770 #298
            if ShipToAddr."Shipping Agent Service Code" <> '' then
              // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
              VALIDATE("Shipping Agent Service Code",ShipToAddr."Shipping Agent Service Code");
              // >>DITW18.00.07 DDR DIT-770 #1488
        #38..40
            // <<DITW15.00.00.24 DDR 14/08/2008
            //<<DITW17.00.02 SR 12/26/2013 DIT-770 #298
            if ShipToAddr.Distance <> 0 then
              Distance := ShipToAddr.Distance;
            // >>DITW15.00.00.24 DDR
            // <<DITW15.00.00.25 DDR 21/10/2008
            if ShipToAddr."Customer DTax Group Code" <> '' then
              "Customer DTax Group Code" := ShipToAddr."Customer DTax Group Code";
            // >>DITW15.00.00.25 DDR
            // <<DITW15.00.00.28 DDR 24/11/2008
            if  ShipToAddr."Tax Registration No." <> '' then
              "Customer Tax Registration No." := ShipToAddr."Tax Registration No.";
            // <<DITW16.00.00.40 DDR 24/01/2012 DIT-715 #203
            //<<DITW17.00.02 SR 12/26/2013 DIT-770 #298
            if ShipToAddr."Fiscal Representative No." <> '' then
              "Fiscal Representative No." := ShipToAddr."Fiscal Representative No.";
            // >>DITW16.00.00.40 DDR DIT-715 #203
            // >>DITW15.00.00.28 DDR
            // <<DITW15.00.00.38 DDR 13/09/2010 #1217
            if ShipToAddr."Tax Warehouse Reference" <> '' then
              "Customer Tax Warehouse Ref." := ShipToAddr."Tax Warehouse Reference";
            // >>DITW15.00.00.38 DDR
            // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
            if ShipToAddr."Tax Office Code" <> '' then
              "Tax Office Code" := ShipToAddr."Tax Office Code";
            // <<DITW15.00.00.38 DDR #1217 (DIT711 137)
            // <<DITW15.00.00.39 DDR 06/07/2011 #1353
            if FORMAT(ShipToAddr."Journey Time") <> '' then
              "Journey Time" := ShipToAddr."Journey Time";
            // >>DITW15.00.00.39 DDR #1353
            // <<DITW15.00.00.38 DDR 11/08/2010 #1217
            "Transaction Type" := ShipToAddr."Transaction Type";
            "Transport Method" := ShipToAddr."Transport Method";
            "Transaction Specification" := ShipToAddr."Transaction Specification";
            "Exit Point" := ShipToAddr."Exit Point";
            Area := ShipToAddr.Area;
            // >>DITW15.00.00.38 DDR
            // <<DITW15.00.00.39 RBE 21/04/2011 #1230
            if not SkipSellToContact then begin
              if ShipToAddr."Sell-to Contact No." <> '' then begin
                "Sell-to Contact No." := ShipToAddr."Sell-to Contact No.";
                recContact.GET(ShipToAddr."Sell-to Contact No.");
                "Sell-to Contact" := recContact.Name;
              end;
            end;
            // >>DITW15.00.00.39 RBE 21/04/2011 #1230
            // <<DITW19.00.08 DDR 12/08/2016 BL#10314
            if ("Document Type" in ["Document Type"::Order,"Document Type"::"Return Order"]) or
              SalesSetup."Shipment on Invoice" or SalesSetup."Return Receipt on Credit Memo"
            then begin
            // >>DITW19.00.08 DDR BL#10314
              //<<DITW17.00.02 AT  06/06/2012 DIT-770 #146
              VALIDATE("Shipment Date Formula",ShipToAddr."Shipment Date Formula");
              //>>DITW17.00.02 AT  06/06/2012 DIT-770 #146
              //<< DITW18.00.07 AKH 10/05/2016 DIT-770 #1346
              if (ShipToAddr."Customer Delivery Type" <> '') then
                "Customer Delivery Type" := ShipToAddr."Customer Delivery Type";
              //>> DITW18.00.07 AKH DIT-770 #1346
            // <<DITW19.00.08 DDR 12/08/2016 BL#10314
            end;
            // >>DITW19.00.08 DDR BL#10314

            //<<FINXL8.00.001 BSA 08/06/2015 #151
            if recFINXLSetup.READPERMISSION then begin
              if ShipToAddr."VAT Bus. Posting Group" <> '' then
                "VAT Bus. Posting Group" := ShipToAddr."VAT Bus. Posting Group"
              else begin
                GetCust("Sell-to Customer No.");
                "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
              end;
            end;
            //>>FINXL8.00.001 BSA 08/06/2015 #151
        #41..47
              //"Shipment Method Code" := Cust."Shipment Method Code";
              // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
              VALIDATE("Shipment Method Code",Cust."Shipment Method Code");
              // >>DITW18.00.07 DDR DIT-770 #1488
              "Tax Area Code" := Cust."Tax Area Code";
              "Tax Liable" := Cust."Tax Liable";
              // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1190
              CustLocationCode := UserSetupMgt.GetLocation(0,Cust."Location Code","Responsibility Center");
              if (CustLocationCode <> '') and (Cust."Location Code" <> '') and (CustLocationCode <> Cust."Location Code") then begin
                // >>DITW18.00.06 DDR DIT-770 #1190
                if Cust."Location Code" <> '' then
                  VALIDATE("Location Code",Cust."Location Code");
              end;
              //<< DITW19.00.08 AKH 20/09/2016 BL#10756
              if Cust."Return Location Code" <> '' then
                VALIDATE("Return Location Code",Cust."Return Location Code");
              //>> DITW19.00.08 AKH BL#10756
              // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
              //"Shipping Agent Code" := Cust."Shipping Agent Code";
              //"Shipping Agent Service Code" := Cust."Shipping Agent Service Code";
              VALIDATE("Shipping Agent Code",Cust."Shipping Agent Code");
              VALIDATE("Shipping Agent Service Code",Cust."Shipping Agent Service Code");
              // >>DITW18.00.07 DDR DIT-770 #1488
              // <<DITW16.00.00.42 DDR 02/01/2013 DIT-715 #529
              "Salesperson Code" := Cust."Salesperson Code";
              // >>DITW16.00.00.42 DDR DIT-715 #529

              // <<DITW15.00.00.39 DDR 22/04/2011 #1230
              if not SkipSellToContact then begin
                if Cust."Sell-to Contact No." <> '' then begin
                  "Sell-to Contact No." := Cust."Sell-to Contact No.";
                  recContact.GET(Cust."Sell-to Contact No.");
                  "Sell-to Contact" := recContact.Name;
                end;
              end;
              // >>DITW15.00.00.39 DDR #1230

              // <<DITW15.00.00.01 DDR 27/12/2007 - DITW15.00.00.38 DDR 23/02/2011 #1286
              // <<DITW16.00.00.42 DDR 12/12/2012 14/12/2012 DIT-715 #520
              if IsCustCalcTaxes(Cust,GLSetup."Sell-to/Bill-to DTax Gr. Calc."::"Bill-to/Pay-to No.") then
              // >>DITW16.00.00.42 DDR DIT-715 #520
                Cust2.GET("Bill-to Customer No.")
              else
                Cust2 := Cust;
              "Customer DTax Group Code" := Cust2."Customer DTax Group Code";
              // >>DITW15.00.00.38 DDR #1286
              // <<DITW15.00.00.01 DDR 27/12/2007 - DITW16.00.00.42 DDR 12/12/2012 14/12/2012 DIT-715 #520
              //"Customer DDeposit Group Code" := Cust."Customer DDeposit Group Code";
              if ("Sell-to Customer No." <> "Bill-to Customer No.") and ("Bill-to Customer No." <> '') and
                IsCustCalcPrices(Cust,SalesSetup."Bill-to/Sell-to Prices Calc."::"Bill-to")
              then
                Cust3.GET("Bill-to Customer No.")
              else
                Cust3 := Cust;
              "Customer DDeposit Group Code" := Cust3."Customer DDeposit Group Code";
              // >>DITW15.00.00.01 DDR - DITW16.00.00.42 DDR DIT-715 #520
              // <<DITW15.00.00.24 DDR 14/08/2008
              Distance := Cust.Distance;
              // >>DITW15.00.00.24 DDR
              // <<DITW15.00.00.28 DDR 24/11/2008
              "Customer Tax Registration No." := Cust."Tax Registration No.";
              "Fiscal Representative No." := Cust."Fiscal Representative No.";
              // >>DITW15.00.00.28 DDR
              // <<DITW15.00.00.38 DDR 13/09/2010 #1217
              "Customer Tax Warehouse Ref." := Cust."Tax Warehouse Reference";
              // >>DITW15.00.00.38 DDR
              // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
              "Tax Office Code" := Cust."Tax Office Code";
              // <<DITW15.00.00.38 DDR #1217 (DIT711 137)
              // <<DITW15.00.00.39 DDR 06/07/2011 #1353
              "Journey Time" := Cust."Journey Time";
              // >>DITW15.00.00.39 DDR #1353
              // <<DITW15.00.00.38 DDR 11/08/2010 #1217
              "Transaction Type" := Cust."Transaction Type";
              "Transport Method" := Cust."Transport Method";
              "Transaction Specification" := Cust."Transaction Specification";
              "Exit Point" := Cust."Exit Point";
              Area := Cust.Area;
              // >>DITW15.00.00.38 DDR
              // <<DITW19.00.08 DDR 12/08/2016 BL#10314
              if "Document Type" in ["Document Type"::Order,"Document Type"::"Return Order"] then begin
              // >>DITW19.00.08 DDR BL#10314
                // <<DITW16.00.00.40 DDR 12/12/2011 #1002
                //<< DITW19.00.08 AKH 27/10/2016 BL#11231
                SetRoute(Cust,SalesSetup);
                //>> DITW19.00.08 AKH BL#11231
              // <<DITW19.00.08 DDR 12/08/2016 BL#10314
              end;
              // >>DITW19.00.08 DDR BL#10314

              // <<DITW19.00.08 DDR 12/08/2016 BL#10314
              if ("Document Type" in ["Document Type"::Order,"Document Type"::"Return Order"]) or
                SalesSetup."Shipment on Invoice" or SalesSetup."Return Receipt on Credit Memo"
              then begin
              // >>DITW19.00.08 DDR BL#10314
                "Delivery Sequence" := Cust."Delivery Sequence";
                // >>DITW16.00.00.40 DDR #1002
                //<<DITW17.00.02 AT  06/06/2012 DIT-770 #146
                VALIDATE("Shipment Date Formula",Cust."Shipment Date Formula");
                //>>DITW17.00.02 AT  06/06/2012 DIT-770 #146
              // <<DITW19.00.08 DDR 12/08/2016 BL#10314
              end;
              // >>DITW19.00.08 DDR BL#10314
            end;
        //END; //DITW18.00.06 MSF 10/04/2015 DIT-770 #1339

        // <<DITW15.00.00.29 DDR 22/12/2008
        if ("Document Type" = "Document Type"::"Return Order")
        then begin
          if "Ship-to Code" <> '' then begin
            if xRec."Ship-to Code" <> '' then begin
              GetCust("Sell-to Customer No.");
            end;
            ShipToAddr.GET("Sell-to Customer No.","Ship-to Code");
            if  ShipToAddr."Tax Registration No." <> '' then
              "Customer Tax Registration No." := ShipToAddr."Tax Registration No.";
            // <<DITW16.00.00.40 DDR 24/01/2012 DIT-715 #203
            "Fiscal Representative No." := ShipToAddr."Fiscal Representative No.";
            // >>DITW16.00.00.40 DDR DIT-715 #203
            // <<DITW15.00.00.38 DDR 13/09/2010 #1217
            if ShipToAddr."Tax Warehouse Reference" <> '' then
              "Customer Tax Warehouse Ref." := ShipToAddr."Tax Warehouse Reference";
            // >>DITW15.00.00.38 DDR
            // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
            if ShipToAddr."Tax Office Code" <> '' then
              "Tax Office Code" := ShipToAddr."Tax Office Code";
            // <<DITW15.00.00.38 DDR #1217 (DIT711 137)
            // <<DITW15.00.00.39 DDR 06/07/2011 #1353
            if FORMAT(ShipToAddr."Journey Time") <> '' then
              "Journey Time" := ShipToAddr."Journey Time";
            // >>DITW15.00.00.39 DDR #1353
           //<<DITW17.00.02 AT  17/12/2013 DIT-770 #210
           if ShipToAddr."Customer DTax Group Code" <> '' then
             "Customer DTax Group Code" := ShipToAddr."Customer DTax Group Code";
           //>>DITW17.00.02 AT DIT-770 #210
          end else
            if "Sell-to Customer No." <> '' then begin
              GetCust("Sell-to Customer No.");
              "Customer Tax Registration No." := Cust."Tax Registration No.";
              "Fiscal Representative No." := Cust."Fiscal Representative No.";
              // <<DITW15.00.00.38 DDR 13/09/2010 #1217
              "Customer Tax Warehouse Ref." := Cust."Tax Warehouse Reference";
              // >>DITW15.00.00.38 DDR
             // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
             "Tax Office Code" := Cust."Tax Office Code";
             // <<DITW15.00.00.38 DDR #1217 (DIT711 137)
             // <<DITW15.00.00.39 DDR 06/07/2011 #1353
             "Journey Time" := Cust."Journey Time";
             // >>DITW15.00.00.39 DDR #1353
            end;
        end;
        // >>DITW15.00.00.29 DDR

        // <<DITW16.00.00.40 DDR 16/04/2012 DIT-715 #247
        if "Ship-to Code" <> '' then begin
          if (xRec."Ship-to Code" <> '') and
            ("Bill-to Customer No." <> '')
          then begin
            // <<DITW16.00.00.42 DDR 12/12/2012 14/12/2012 DIT-715 #520
            GetCust("Sell-to Customer No.");
            if IsCustCalcPrices(Cust,SalesSetup."Bill-to/Sell-to Prices Calc."::"Bill-to") then
            // >>DITW16.00.00.42 DDR DIT-715 #520
              GetCust("Bill-to Customer No.");
            "Customer Price Group" := Cust."Customer Price Group";
          end;
          if "Sell-to Customer No." <> '' then begin
            ShipToAddr.GET("Sell-to Customer No.","Ship-to Code");
            if ShipToAddr."Customer Price Group" <> '' then
              "Customer Price Group" := ShipToAddr."Customer Price Group";
            //<<DITW17.00.02 TEC1 06/09/2013 DIT-770 #141
            if ShipToAddr."Customer DDeposit Group Code" <> '' then
              "Customer DDeposit Group Code" := ShipToAddr."Customer DDeposit Group Code";
            if ShipToAddr."Invoice Posting" <> ShipToAddr."Invoice Posting"::" " then
              VALIDATE("Invoice Method", ShipToAddr."Invoice Posting");
            if ShipToAddr."Invoice Period" <> ShipToAddr."Invoice Period" then
              VALIDATE("Invoice Period", ShipToAddr."Invoice Period");
            //>>DITW17.00.02 TEC1 DIT-770 #141
          end;
        end else
          if "Bill-to Customer No." <> '' then begin
            // <<DITW16.00.00.42 DDR 12/12/2012 14/12/2012 DIT-715 #520
            GetCust("Sell-to Customer No.");
            if IsCustCalcPrices(Cust,SalesSetup."Bill-to/Sell-to Prices Calc."::"Bill-to") then
            // >>DITW16.00.00.42 DDR DIT-715 #520
              GetCust("Bill-to Customer No.");
            "Customer Price Group" := Cust."Customer Price Group";

            // <<DITW16.00.00.42 DDR 02/01/2013 DIT-715 #529
            if SalesSetup."Bill-to/Sell-to Salespers./P." = SalesSetup."Bill-to/Sell-to Salespers./P."::"Bill-to" then begin
              GetCust("Bill-to Customer No.");
              "Salesperson Code" := Cust."Salesperson Code";
            end;
            // >>DITW16.00.00.42 DDR DIT-715 #529
          end;
        if xRec."Customer Price Group" <> "Customer Price Group" then
          VALIDATE("Customer Price Group");
        // >>DITW16.00.00.40 DDR DIT-715 #247
        // <<DITW16.00.00.42 DDR 02/01/2013 DIT-715 #529
        if xRec."Salesperson Code" <> "Salesperson Code" then
          VALIDATE("Salesperson Code");
        // >>DITW16.00.00.42 DDR DIT-715 #529
        // <<DITW15.00.00.28 DDR 24/11/2008
        VALIDATE("Fiscal Representative No.");
        // >>DITW15.00.00.28 DDR
        // <<DITW15.00.00.25 DDR 21/10/2008
        UpdateShippingMax();
        // >>DITW15.00.00.25 DDR
        GetShippingTime(FIELDNO("Ship-to Code"));
        // <<DITW15.00.00.39 DDR 06/07/2011 #1353
        GetJourneyTime(FIELDNO("Ship-to Code"));
        // >>DITW15.00.00.39 DDR #1353
        #58..64
            //RecreateSalesLines(FIELDCAPTION("Ship-to Code"))
            // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
            HasRecreateSalesLines := RecreateSalesLines(FIELDCAPTION("Ship-to Code"))
            // >>DITW18.00.07 DDR DIT-770 #1402
          else begin
            if xRec."Shipping Agent Code" <> "Shipping Agent Code" then
              //MessageIfSalesLinesExist(FIELDCAPTION("Shipping Agent Code"));
              // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
              UpdateSalesLines("Shipping Agent Code",(CurrFieldNo = FIELDNO("Ship-to Code")) and ("Route Planning No." = ''));
              // >>DITW18.00.07 DDR DIT-770 #1488
            if xRec."Shipping Agent Service Code" <> "Shipping Agent Service Code" then
              //MessageIfSalesLinesExist(FIELDCAPTION("Shipping Agent Service Code"));
              // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
              UpdateSalesLines("Shipping Agent Service Code",(CurrFieldNo = FIELDNO("Ship-to Code")) and ("Route Planning No." = ''));
              // >>DITW18.00.07 DDR DIT-770 #1488
        #71..73

        //<<DITW17.00.02 AT  27/01/2014 DIT-770 #210
        if ("Document Type" = "Document Type"::"Credit Memo") then
        begin
          if GLSetup.GET() then
          begin
            if GLSetup."Sell-to/Bill-to DTax Gr. Calc." = GLSetup."Sell-to/Bill-to DTax Gr. Calc."::"Sell-to/Buy-from No." then
            begin
              if ShipToAddr.GET("Sell-to Customer No.","Ship-to Code") then
              begin
                if  ShipToAddr."Tax Registration No." <> '' then
                  "Customer Tax Registration No." := ShipToAddr."Tax Registration No.";
                if ShipToAddr."Tax Warehouse Reference" <> '' then
                  "Customer Tax Warehouse Ref." := ShipToAddr."Tax Warehouse Reference";
                if ShipToAddr."Customer DTax Group Code" <> '' then
                  "Customer DTax Group Code" := ShipToAddr."Customer DTax Group Code";
              end;
            end;
          end;
        end;
        //>>DITW17.00.02 AT  27/01/2014 DIT-770 #210

        //<<DITW18.00.06 MSF 08/07/2015 DIT-770 #1212 #1213 #1214
        UpdatefromCustrespcenterrelation();
        //>>DITW18.00.06 MSF 08/07/2015 DIT-770 #1212 #1213 #1214

        // <<DITW16.00.00.43 DDR 30/07/2013 DIT-715 #719
        // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
        if (xRec."Ship-to Code" <> "Ship-to Code") and not HasRecreateSalesLines then begin
        // >>DITW16.00.00.43 DDR DIT-715 #691
        // >>DITW16.00.00.43 DDR DIT-715 #719
          // <<DITW15.00.00.25 DDR 21/10/2008
          if xRec."Customer DTax Group Code" <> "Customer DTax Group Code" then begin
            // <<DITW17.10.03 DDR 19/05/2014 DIT-770 #623
            UpdateSalesLines(FIELDCAPTION("Customer DTax Group Code"),CurrFieldNo <> 0);
            // >>DITW17.10.03 DDR DIT-770 #623
            // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
            RecreateChargeSalesLines(FIELDCAPTION("Customer DTax Group Code"));
            // >>DITW16.00.00.43 DDR DIT-715 #691
          end;
          if xRec."Customer DDeposit Group Code" <> "Customer DDeposit Group Code" then
            // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
            RecreateChargeSalesLines(FIELDCAPTION("Customer DDeposit Group Code"))
            // >>DITW16.00.00.43 DDR DIT-715 #691
          // >>DITW15.00.00.25 DDR
        end;

        //<< DITW18.00.07 VSC 28/06/2016 DIT-770 #1282
        CheckLatestOrderDateTime(FIELDNO("Ship-to Code"));
        //>> DITW18.00.07 VSC DIT-770 #1282

        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        if xRec."Ship-to Code" <> "Ship-to Code" then
          UpdateRoutePlanRqstLines(FIELDCAPTION("Ship-to Code"));
        // >>DITW18.00.07 DDR DIT-770 #1488
        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1109
        ClearHasBeenShowAll2(FIELDNO("Ship-to Code"));
        // >>DITW18.00.07 DDR DIT-770 #1109
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Order Date"(Field 19).OnValidate". Please convert manually.

        //trigger (Variable: HasRecreateSalesLines)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Order Date"(Field 19).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ("Document Type" in ["Document Type"::Quote,"Document Type"::Order]) and
           not ("Order Date" = xRec."Order Date")
        then
          PriceMessageIfSalesLinesExist(FIELDCAPTION("Order Date"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
        SalesSetup.GET;
        // >>DITW18.00.07 DDR DIT-770 #1402
        if ("Document Type" in ["Document Type"::Quote,"Document Type"::Order]) and
           not ("Order Date" = xRec."Order Date") and
           // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
           ("Shipment Date" = xRec."Shipment Date")
           // >>DITW18.00.07 DDR DIT-770 #1402
        then
          // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
          if SalesSetup."Recalculate Prices" <> SalesSetup."Recalculate Prices"::" " then
            HasRecreateSalesLines := RecreateSalesLines(FIELDCAPTION("Order Date"))
          else
          // >>DITW18.00.07 DDR DIT-770 #1402
            PriceMessageIfSalesLinesExist(FIELDCAPTION("Order Date"));

        // <<DITW15.00.00.39 DDR 19/08/2011 #1363
        if not ("Document Type" in ["Document Type"::Invoice,"Document Type"::"Credit Memo"]) and
           (SalesSetup."Default Tax Date" = SalesSetup."Default Tax Date"::OrderDate)
        then
          VALIDATE("Tax Date","Order Date");
        // >>DITW15.00.00.39 DDR #1363
        // <<DITW16.00.00.42 DDR 01/03/2013 DIT-715 #572
        if "Order Date" = 0D then begin
          SalesLine.RESET;
          if "Tax Date" <> 0D then
            SalesLine.SETFILTER("Item Charge Type",'<>%1',SalesLine."Item Charge Type"::Tax);
          // <<DITW17.10.05 DDR 01/10/2014 DIT-770 #885
          if SalesSetup."Sales Conditions Based on" = SalesSetup."Sales Conditions Based on"::OrderDate then begin
          // >>DITW17.10.05 DDR DIT-770 #885
            DeleteChargeSalesLines();
            RecalcBackSalesLines();
          end;
        end else
          // <<DITW17.10.05 DDR 26/01/2015 DIT-770 #885
          if (xRec."Order Date" <> "Order Date") and
            (xRec."Sell-to Customer No." = "Sell-to Customer No.") and
            (SalesSetup."Sales Conditions Based on" = SalesSetup."Sales Conditions Based on"::OrderDate) and
            // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
            (SalesSetup."Recalculate Prices" <> SalesSetup."Recalculate Prices"::" ") and
            not HasRecreateSalesLines
            // >>DITW18.00.07 DDR DIT-770 #1402
          then
            RecreateChargeSalesLines(FIELDCAPTION("Order Date"));
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
        TestNoSeriesDate(
          "Prepayment No.","Prepayment No. Series",
          FIELDCAPTION("Prepayment No."),FIELDCAPTION("Prepayment No. Series"));
        TestNoSeriesDate(
          "Prepmt. Cr. Memo No.","Prepmt. Cr. Memo No. Series",
          FIELDCAPTION("Prepmt. Cr. Memo No."),FIELDCAPTION("Prepmt. Cr. Memo No. Series"));

        if "Incoming Document Entry No." = 0 then
          VALIDATE("Document Date","Posting Date");

        if ("Document Type" in ["Document Type"::Invoice,"Document Type"::"Credit Memo"]) and
           not ("Posting Date" = xRec."Posting Date")
        then
          PriceMessageIfSalesLinesExist(FIELDCAPTION("Posting Date"));

        if "Currency Code" <> '' then begin
          UpdateCurrencyFactor;
          if "Currency Factor" <> xRec."Currency Factor" then
            ConfirmUpdateCurrencyFactor;
        end;

        if "Posting Date" <> xRec."Posting Date" then
          if DeferralHeadersExist then
            ConfirmUpdateDeferralDate;
        SynchronizeAsmHeader;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
        SalesSetup.GET;
        // >>DITW18.00.07 DDR DIT-770 #1402
        #1..10
        // >>HEI.48
        VALIDATE("Payment Terms Code");
        // <<HEI.48

        //<<HEI.38 - Below Code is commented to calculate Currency Factor when changing the Document Date instead of changing the Posting Date
        {
        IF "Incoming Document Entry No." = 0 THEN
          VALIDATE("Document Date","Posting Date");

        IF ("Document Type" IN ["Document Type"::Invoice,"Document Type"::"Credit Memo"]) AND
           NOT ("Posting Date" = xRec."Posting Date")
        THEN
          PriceMessageIfSalesLinesExist(FIELDCAPTION("Posting Date"));

        IF "Currency Code" <> '' THEN BEGIN
          UpdateCurrencyFactor;
          // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
          InitHasBeenShow(HasBeenShowText021,'',FIELDNO("Posting Date"));
          // >>DITW16.00.00.43 DDR DIT-715 #860
          IF "Currency Factor" <> xRec."Currency Factor" THEN
            ConfirmUpdateCurrencyFactor;
        END;
        }

        //>>HEI.38

        ///DITW110.00.11 MSF 21/09/2017 NRQ#16082-DITW110.00.11 MSF 30/11/2017 NRQ#16082
        #24..27
        // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
        //SynchronizeAsmHeader;
        SynchronizeAsmHeader(FIELDNO("Posting Date"));
        // >>DITW17.10.05 DDR DIT-770 #675
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shipment Date"(Field 21).OnValidate". Please convert manually.

        //trigger (Variable: HasRecreateSalesLines)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipment Date"(Field 21).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdateSalesLines(FIELDCAPTION("Shipment Date"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
        SalesSetup.GET;
        // >>DITW18.00.07 DDR DIT-770 #1402

        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
          if CheckExistWarehouseLine then
            ERROR(STRSUBSTNO(Text2014061,"Document Type","No."));
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
        // <<DITW18.00.07 DDR 25/02/2016 DIT-770 #1488
        if not CheckShipmentDate() then begin
          "Shipment Date" := xRec."Shipment Date";
          exit;
        end;
        // >>DITW18.00.07 DDR DIT-770 #1488

        // >>HEI.50
        if ("Document Type" = "Document Type"::Order) and (Status = Status::Released) then
          ArchiveManagement.ArchSalesDocumentNoConfirm(xRec);
        // <<HEI.50


        // <<DITW19.00.08 DDR 12/08/2016 BL#10314
        if ("Document Type" in ["Document Type"::Order,"Document Type"::"Return Order"]) or
          SalesSetup."Shipment on Invoice" or SalesSetup."Return Receipt on Credit Memo"
        then
        // >>DITW19.00.08 DDR BL#10314
          VALIDATE("Posting Date","Shipment Date");

        //<< DITW18.00.07 AKH 07/01/2016 DIT-770 #1381
        fctFillDeliveryTimes("Sell-to Customer No.","Ship-to Code","Shipment Date");
        //>> DITW18.00.07 AKH DIT-770 #1381
        //>>DITW17.00.02 TEC1 DIT-770 #154

        // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #240
        if ("Document Type" in ["Document Type"::Quote,"Document Type"::Order]) and
           not ("Shipment Date" = xRec."Shipment Date") and
           // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
           ("Order Date" = xRec."Order Date") and
           (SalesSetup."Sales Conditions Based on" = SalesSetup."Sales Conditions Based on"::ShipRecvDate)
           // >>DITW18.00.07 DDR DIT-770 #1402
        then begin
          // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
          if not ("Document Type" in ["Document Type"::Invoice,"Document Type"::"Credit Memo"]) and
           (SalesSetup."Default Tax Date" = SalesSetup."Default Tax Date"::ShipRecvDate)
          then
            "Tax Date" := "Shipment Date";
          if SalesSetup."Recalculate Prices" <> SalesSetup."Recalculate Prices"::" " then
            HasRecreateSalesLines := RecreateSalesLines(FIELDCAPTION("Shipment Date"))
          else
          // >>DITW18.00.07 DDR DIT-770 #1402
            PriceMessageIfSalesLinesExist(FIELDCAPTION("Shipment Date"));
          // <<DITW18.00.07 DDR 11/05/2016 DIT-770 #1402
          HasRecreateSalesLines := true;
          // >>DITW18.00.07 DDR DIT-770 #1402
        end;
        if not ("Document Type" in ["Document Type"::Invoice,"Document Type"::"Credit Memo"]) and
         (SalesSetup."Default Tax Date" = SalesSetup."Default Tax Date"::ShipRecvDate) then
          VALIDATE("Tax Date","Shipment Date");
        // >>DITW16.00.00.40 DDR DIT-715 #240

        //<< DITW18.00.07 VSC 28/06/2016 DIT-770 #1282
        CheckLatestOrderDateTime(FIELDNO("Shipment Date"));
        //>> DITW18.00.07 VSC DIT-770 #1282

        // <<DITW16.00.00.42 DDR 01/03/2013 DIT-715 #572
        if "Shipment Date" = 0D then begin
          SalesLine.RESET;
          if "Tax Date" <> 0D then
            SalesLine.SETFILTER("Item Charge Type",'<>%1',SalesLine."Item Charge Type"::Tax);
          // <<DITW17.10.05 DDR 01/10/2014 DIT-770 #885
          if SalesSetup."Sales Conditions Based on" = SalesSetup."Sales Conditions Based on"::ShipRecvDate then begin
          // >>DITW17.10.05 DDR DIT-770 #885
            DeleteChargeSalesLines();
            RecalcBackSalesLines();
          end;
        end;
        // >>DITW16.00.00.42 DDR DIT-715 #572

        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
        if not HasRecreateSalesLines then
        // >>DITW18.00.07 DDR DIT-770 #1402
          // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
          UpdateSalesLines(FIELDCAPTION("Shipment Date"),(CurrFieldNo <> 0) and ("Route Planning No." = ''));
          // >>DITW18.00.07 DDR DIT-770 #1488

        // <<DITW17.10.05 DDR 01/10/2014 DIT-770 #885
        if (xRec."Shipment Date" <> "Shipment Date") and
          (xRec."Sell-to Customer No." = "Sell-to Customer No.") and
          (xRec."Order Date" = "Order Date") and
          (SalesSetup."Sales Conditions Based on" = SalesSetup."Sales Conditions Based on"::ShipRecvDate) and
          // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
          (SalesSetup."Recalculate Prices" <> SalesSetup."Recalculate Prices"::" ") and
          not HasRecreateSalesLines
          // >>DITW18.00.07 DDR DIT-770 #1402
        then
          RecreateChargeSalesLines(FIELDCAPTION("Shipment Date"));
        // >>DITW17.10.05 DDR DIT-770 #885

        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        UpdateRoutePlanRqstLines(FIELDCAPTION("Shipment Date"));
        // >>DITW18.00.07 DDR DIT-770 #1488

        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        UpdateWhseRequestLines(FIELDCAPTION("Shipment Date"));
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1109
        ClearHasBeenShowAll2(FIELDNO("Shipment Date"));
        // >>DITW18.00.07 DDR DIT-770 #1109
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Terms Code"(Field 23).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ("Payment Terms Code" <> '') and ("Document Date" <> 0D) then begin
          PaymentTerms.GET("Payment Terms Code");
          if IsCreditDocType and not PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then begin
            VALIDATE("Due Date","Document Date");
            VALIDATE("Pmt. Discount Date",0D);
            VALIDATE("Payment Discount %",0);
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
        #18..21
            "Prepayment Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");
          VALIDATE("Prepmt. Payment Terms Code","Payment Terms Code");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW18.00.06 MVN 28/10/2015 DIT-77O #1623
        if (xRec."Payment Terms Code" <> "Payment Terms Code") and ("Payment Terms Code" <> '') and
          (CurrFieldNo = FIELDNO("Payment Terms Code"))
        then
          CheckCrLimit;
        //>>DITW18.00.06 MVN 28/10/2015 DIT-77O #1623

        // >>HEI.48
        //IF ("Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
        if ("Payment Terms Code" <> '') and ("Document Date" <> 0D) and ("Posting Date" <> 0D) then begin
          // <<HEI.48
          PaymentTerms.GET("Payment Terms Code");
          if IsCreditDocType and not PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then begin
          // >>HEI.48
            //VALIDATE("Due Date","Document Date");
            VALIDATE("Due Date","Posting Date");
          // <<HEI.48
        #5..7
          // >>HEI.48
            //"Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");
            "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Posting Date");
          // <<HEI.48
        #9..13
          // >>HEI.48
            //VALIDATE("Due Date","Document Date");
            VALIDATE("Due Date","Posting Date");
          // <<HEI.48
        #15..24
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Discount %"(Field 25).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if not (CurrFieldNo in [0,FIELDNO("Posting Date"),FIELDNO("Document Date")]) then
          TESTFIELD(Status,Status::Open);
        GLSetup.GET;
        if "Payment Discount %" < GLSetup."VAT Tolerance %" then
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
          //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
          //TESTFIELD(Status,Status::Open);
          TestOpenStatus;
          //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        #3..8
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
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
        SalesSetup.GET;
        // >>DITW18.00.07 DDR DIT-770 #1402
        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        if "Multiple Order Route" then
          if CurrFieldNo = FIELDNO("Shipment Method Code") then
            ERROR(Text2014062);
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154 - DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        if ("Shipment Method Code" <> xRec."Shipment Method Code") and
           (xRec."Sell-to Customer No." = "Sell-to Customer No.")
        then begin
          if "Shipment Method Code" <> '' then begin
            rShipmentMethod.GET("Shipment Method Code");
            //>> HEI.34
            if "Shipment Method Code" <> xRec."Shipment Method Code" then
              WhseTransportMgt.DeleteSalesShippingCost(xRec,true);
            //<< HEI.34
            CreateShippingCost(Rec,true,true);
            if rShipmentMethod."Shipping Agent" <> '' then
              VALIDATE("Shipping Agent Code",rShipmentMethod."Shipping Agent");
            if rShipmentMethod."Shipping Agent Service Code" <> '' then
              VALIDATE("Shipping Agent Service Code",rShipmentMethod."Shipping Agent Service Code");
            if rShipmentMethod."Payment Terms" <> '' then
              VALIDATE("Payment Terms Code",rShipmentMethod."Payment Terms");
            if rShipmentMethod."Payment Method" <> '' then
              VALIDATE("Payment Method Code",rShipmentMethod."Payment Method");
          end else begin
            //>> HEI.33 FDD-HT658 IBM.GUNERE01 30.09.2019
            if "Shipment Method Code" <> xRec."Shipment Method Code" then
              if "Shipment Method Code" = '' then
                WhseTransportMgt.DeleteSalesShippingCost(xRec,true);
             CreateShippingCost(Rec,true,true); //HEI.34
            //<< HEI.33 FDD-HT658 IBM.GUNERE01 30.09.2019
            // DDR #1488 (to do) rollback thes values as new document within customer and shipto-codee without default shipment method code
          end;
        end;
        //>>DITW17.00.02 TEC1 DIT-770 #154

        // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.34 DDR 10/07/2009
        if ("Shipment Method Code" <> xRec."Shipment Method Code") and
           (xRec."Sell-to Customer No." = "Sell-to Customer No.")
        then begin
          // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
          if SalesSetup."Recalculate Prices" <> SalesSetup."Recalculate Prices"::" " then
            RecreateSalesLines(FIELDCAPTION("Shipment Method Code"))
          else
            PriceMessageIfSalesLinesExist(FIELDCAPTION("Shipment Method Code"))
          // >>DITW18.00.07 DDR DIT-770 #1402
        end;
        // >>DITW15.00.00.34 DDR

        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        if xRec."Shipment Method Code" <> "Shipment Method Code" then
          UpdateRoutePlanRqstLines(FIELDCAPTION("Shipment Method Code"));
        // >>DITW18.00.07 DDR DIT-770 #1488
        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1109
        ClearHasBeenShowAll2(FIELDNO("Shipment Method Code"));
        // >>DITW18.00.07 DDR DIT-770 #1109
        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        UpdateWhseRequestLines(FIELDCAPTION("Shipment Method Code"));
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Field 28).OnValidate". Please convert manually.

        //trigger (Variable: AskConfirm)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Field 28).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        if ("Location Code" <> xRec."Location Code") and
           (xRec."Sell-to Customer No." = "Sell-to Customer No.")
        then
          MessageIfSalesLinesExist(FIELDCAPTION("Location Code"));

        UpdateShipToAddress;
        UpdateOutboundWhseHandlingTime;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159

        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        if "Multiple Order Route" then
          if CurrFieldNo = FIELDNO("Location Code") then
            ERROR(Text2014062);
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1190
        if (("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> xRec."Location Code") and
          ("Location Code" <> ''))
        then begin
           Location.GET("Location Code");
           //<< DITW19.00.08 AKH 16/12/2016 BL#9797
           ResponsibilityCenter := UserSetupMgt.GetFirstRespCenter(0,Location."Physical Location Group Code","Location Code");
           if (ResponsibilityCenter <> '') then
             VALIDATE("Responsibility Center", ResponsibilityCenter);
           //>> DITW19.00.08 AKH BL#9797
        end;
        // >>DITW18.00.06 DDR DIT-770 #1190

        // <<DITW18.00.06 DDR 19/02/2015 25/02/2015 DIT-770 #1190
        if (("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> '')) or
          ("Responsibility Center" <> xRec."Responsibility Center")
        then
          if not UserSetupMgt.CheckLocation(0,"Location Code","Responsibility Center") then
            ERROR(
              Text2014412,
              Location.TABLECAPTION,"Location Code",
              RespCenter.TABLECAPTION,UserSetupMgt.GetSalesFilter);
        // >>DITW18.00.06 DDR DIT-770 #1190

        //IF ("Location Code" <> xRec."Location Code") AND
        //   (xRec."Sell-to Customer No." = "Sell-to Customer No.")
        //THEN
        //  MessageIfSalesLinesExist(FIELDCAPTION("Location Code"));
        if ("Location Code" <> xRec."Location Code") and
           (xRec."Sell-to Customer No." = "Sell-to Customer No.") and
          // <<DITW18.00.06 DDR 19/02/2015 DIT-770 #1190
          ((xRec."Physical Location Group Code" = "Physical Location Group Code") or
          (CurrFieldNo <> FIELDNO("Physical Location Group Code")))
          // >>DITW18.00.06 DDR DIT-770 #1190
        then begin
          // <<DITW18.00.06 DDR 19/02/2015 DIT-770 #1190
          // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1190 - DITW18.00.07 DDR 02/05/2016 DIT-770 #1402
          if (CurrFieldNo <> FIELDNO("Responsibility Center")) and SalesLinesExist then begin
          // >>DITW18.00.06 DDR DIT-770 #1190 - DITW18.00.07 DDR DIT-770 #1402
            // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
            SalesSetup.GET;
            if SalesSetup."Recalculate Prices" <> SalesSetup."Recalculate Prices"::" " then begin
              AskConfirm :=
                (SalesSetup."Recalculate Prices" = SalesSetup."Recalculate Prices"::Confirm) and
                // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
                ("Route Planning No." = '');
                // >>DITW18.00.07 DDR DIT-770 #1488
              InitHasBeenShow(HasBeenShowText2014410,FIELDCAPTION("Location Code"),0);
              // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
              if HideValidationDialog or not GUIALLOWED or HasBeenShowText2014410 or not AskConfirm then
              // >>DITW18.00.07 DDR DIT-770 #1402
                Confirmed := true
              else
                Confirmed :=
                  CONFIRM(
                    Text2014413 +
                    Text004,false,FIELDCAPTION("Location Code"));
              HasBeenShowText2014410 := Confirmed;
              if Confirmed then begin
               // UpdateSalesLines(FIELDCAPTION("Location Code"),FALSE);
                //<<NRQ#122316 MSF 04/10/2019
                RecreateSalesLines(FIELDCAPTION("Location Code"));//MSF
                //>>NRQ#122316 MSF 04/10/2019
              // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
              end else
                ERROR(
                  Text017,FIELDCAPTION("Location Code"));
              // >>DITW18.00.07 DDR DIT-770 #1402
            end else
              // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
              MessageIfSalesLinesExist(FIELDCAPTION("Location Code"));
              // >>DITW18.00.07 DDR DIT-770 #1402
          end;
          // >>DITW18.00.06 DDR DIT-770 #1190
        end;

        // <<DITW18.00.06 DDR 19/02/2015 DIT-770 #1190
        if "Location Code" <> '' then begin
          Location.GET("Location Code");
          if Location."Physical Location Group Code" <> "Physical Location Group Code" then
            "Physical Location Group Code" := Location."Physical Location Group Code";
            //<< DITW19.00.08 AKH 16/12/2016 BL#9797
            "Responsibility Center" := UserMgt.GetFirstRespCenter(0,"Physical Location Group Code","Location Code");
            //>> DITW19.00.08 AKH BL#9797
        end else
          if xRec."Physical Location Group Code" = "Physical Location Group Code" then
            "Physical Location Group Code" := '';
        if xRec."Physical Location Group Code" = "Physical Location Group Code" then
          VALIDATE("Physical Location Group Code");
        // >>DITW18.00.06 DDR DIT-770 #1190
        #6..8

        // <<DITW18.00.07 DDR 30/05/2016 DIT-770 #642
        if xRec."Location Code" <> "Location Code" then
        // >>DITW18.00.07 DDR DIT-770 #642
          //<< DITW18.00.07 VSC 10/03/2016 DIT-770 #1066
          //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
          //<< DITW18.00.07 VSC 04/07/2016 DIT-770 #1066
          //CreateShippingCost(Rec);
          //>> DITW18.00.07 VSC DIT-770 #1066
          //>> DITW18.00.07 VSC DIT-770 #1066
          //>> DITW18.00.07 VSC DIT-770 #1066

        // <<DITW18.00.07 MVN 07/04/2016 DIT-770 #1397
        if ApplMgt.IsObjectLicense(5,CODEUNIT::"EMCS EDI Mgt",4) <> 0 then
        // >>DITW18.00.07 MVN DIT-770 #1397
          // <<DITW18.00.07 MVN 21/01/2016 DIT-770 #1397
          "Submission Type" := EMCSEDIMgt.GetSubmissionType(1,"Customer DTax Group Code","Location Code");
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


        //Unsupported feature: CodeModification on ""Currency Code"(Field 32).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if not (CurrFieldNo in [0,FIELDNO("Posting Date")]) or ("Currency Code" <> xRec."Currency Code") then
          TESTFIELD(Status,Status::Open);
        if (CurrFieldNo <> FIELDNO("Currency Code")) and ("Currency Code" = xRec."Currency Code") then
          UpdateCurrencyFactor
        else
          if "Currency Code" <> xRec."Currency Code" then begin
            UpdateCurrencyFactor;
            RecreateSalesLines(FIELDCAPTION("Currency Code"));
          end else
            if "Currency Code" <> '' then begin
              UpdateCurrencyFactor;
              if "Currency Factor" <> xRec."Currency Factor" then
                ConfirmUpdateCurrencyFactor;
            end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not (CurrFieldNo in [0,FIELDNO("Posting Date")]) or ("Currency Code" <> xRec."Currency Code") then
           //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
           //TESTFIELD(Status,Status::Open);
           TestOpenStatus;
           //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        #3..7
            //<< FINXL9.00.000.01 AKH 12/01/2017
            if not recUserSetup.GET(USERID) then
              recUserSetup.INIT;
            if ShipmentLineExists() and (recUserSetup."Ship Other Bill-to Customer") then
              UpdateSalesLines(FIELDCAPTION("Currency Code"),CurrFieldNo <> 0)
            else
            //>> FINXL9.00.000.01 AKH 12/01/2017
        #8..11
              // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
              InitHasBeenShow(HasBeenShowText021,'',FIELDNO("Currency Code"));
              // >>DITW16.00.00.43 DDR DIT-715 #860
        #12..14
        */
        //end;


        //Unsupported feature: CodeModification on ""Customer Price Group"(Field 34).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        MessageIfSalesLinesExist(FIELDCAPTION("Customer Price Group"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
        SalesSetup.GET;
        if SalesSetup."Recalculate Prices" <> SalesSetup."Recalculate Prices"::" " then
          UpdateSalesLines(FIELDCAPTION("Customer Price Group"),CurrFieldNo <> 0)
        else
        // >>DITW18.00.07 DDR DIT-770 #1402
          MessageIfSalesLinesExist(FIELDCAPTION("Customer Price Group"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Prices Including VAT"(Field 35).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);

        if "Prices Including VAT" <> xRec."Prices Including VAT" then begin
          SalesLine.SETRANGE("Document Type","Document Type");
        #5..14
          SalesLine.SETFILTER("Unit Price",'<>%1',0);
          SalesLine.SETFILTER("VAT %",'<>%1',0);
          if SalesLine.FINDFIRST then begin
            RecalculatePrice :=
              CONFIRM(
                STRSUBSTNO(
                  Text024,
                  FIELDCAPTION("Prices Including VAT"),SalesLine.FIELDCAPTION("Unit Price")),
                true);
            SalesLine.SetSalesHeader(Rec);

            if RecalculatePrice and "Prices Including VAT" then
        #27..29
              Currency.InitRoundingPrecision
            else
              Currency.GET("Currency Code");
            SalesLine.LOCKTABLE;
            LOCKTABLE;
            SalesLine.FINDSET;
            repeat
              SalesLine.TESTFIELD("Quantity Invoiced",0);
              SalesLine.TESTFIELD("Prepmt. Amt. Inv.",0);
              if not RecalculatePrice then begin
        #40..44
                    ROUND(
                      SalesLine."Unit Price" * (1 + (SalesLine."VAT %" / 100)),
                      Currency."Unit-Amount Rounding Precision");
                  if SalesLine.Quantity <> 0 then begin
                    SalesLine."Line Discount Amount" :=
                      ROUND(
        #51..59
                    ROUND(
                      SalesLine."Unit Price" / (1 + (SalesLine."VAT %" / 100)),
                      Currency."Unit-Amount Rounding Precision");
                  if SalesLine.Quantity <> 0 then begin
                    SalesLine."Line Discount Amount" :=
                      ROUND(
        #66..71
                  end;
                end;
              SalesLine.MODIFY;
            until SalesLine.NEXT = 0;
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        #2..17
            //<<HEI.59
            if GUIALLOWED then begin
            //>>HEI.59
              RecalculatePrice :=
                CONFIRM(
                  STRSUBSTNO(
                    Text024,
                    FIELDCAPTION("Prices Including VAT"),SalesLine.FIELDCAPTION("Unit Price")),
                  true);
            //<<HEI.59
            end else
              RecalculatePrice :=true;
            //>>HEI.59
        #24..32
            // <<DITW15.00.00.32 DDR 08/04/2009
            SaveCurrency :=  Currency;
            // >>DITW15.00.00.32 DDR
        #33..36
              // <<DITW15.00.00.32 DDR 08/04/2009
              Currency :=  SaveCurrency;
              Currency.SetRoundingPrecisionDrink(SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Tax,0);
              // >>DITW15.00.00.32 DDR
        #37..47
                  // <<DITW15.00.00.24 DDR 29/08/2008
                  if (SalesLine."Extra Charge Type" = SalesLine."Extra Charge Type"::" ") or
                     (SalesLine."Extra Charge Type" = SalesLine."Extra Charge Type"::Amount) or
                     (SalesLine."Extra Charge Type" = SalesLine."Extra Charge Type"::"Fixed Amount")
                  then
                    SalesLine."Item Charge Value" :=
                      ROUND(
                        SalesLine."Item Charge Value" * (1 + (SalesLine."VAT %" / 100)),
                        Currency."Unit-Amount Rounding Precision");
                  // >>DITW15.00.00.24 DDR
        #48..62
                  // <<DITW15.00.00.24 DDR 29/08/2008
                  if (SalesLine."Extra Charge Type" = SalesLine."Extra Charge Type"::" ") or
                     (SalesLine."Extra Charge Type" = SalesLine."Extra Charge Type"::Amount) or
                     (SalesLine."Extra Charge Type" = SalesLine."Extra Charge Type"::"Fixed Amount")
                  then
                    SalesLine."Item Charge Value" :=
                      ROUND(
                        SalesLine."Item Charge Value" / (1 + (SalesLine."VAT %" / 100)),
                        Currency."Unit-Amount Rounding Precision");
                  // >>DITW15.00.00.24 DDR
        #63..74
              // <<DITW114.00.15 DDR 01/04/2020 NRQ#140339
              HasLineChargeIncludePrice := SalesLine."ItemCharge Incl. Price";
              // >>DITW114.00.15 DDR NRQ#140339
            until SalesLine.NEXT = 0;

            // <<DITW15.00.00.01 DDR 04/02/2008
            // <<DITW114.00.15 DDR 01/04/2020 NRQ#140339
            if RecalculatePrice and HasLineChargeIncludePrice then
            // >>DITW114.00.15 DDR NRQ#140339
              RecalcBackSalesLines();
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
        MessageIfSalesLinesExist(FIELDCAPTION("Invoice Disc. Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        MessageIfSalesLinesExist(FIELDCAPTION("Invoice Disc. Code"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Customer Disc. Group"(Field 40).OnValidate". Please convert manually.

        //trigger  Group"(Field 40)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        MessageIfSalesLinesExist(FIELDCAPTION("Customer Disc. Group"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
        SalesSetup.GET;
        if SalesSetup."Recalculate Prices" <> SalesSetup."Recalculate Prices"::" " then
          UpdateSalesLines(FIELDCAPTION("Customer Disc. Group"),CurrFieldNo <> 0)
        else
        // >>DITW18.00.07 DDR DIT-770 #1402
          MessageIfSalesLinesExist(FIELDCAPTION("Customer Disc. Group"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Salesperson Code"(Field 43).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ApprovalEntry.SETRANGE("Table ID",DATABASE::"Sales Header");
        ApprovalEntry.SETRANGE("Document Type","Document Type");
        ApprovalEntry.SETRANGE("Document No.","No.");
        ApprovalEntry.SETFILTER(Status,'%1|%2',ApprovalEntry.Status::Created,ApprovalEntry.Status::Open);
        if not ApprovalEntry.ISEMPTY then
          ERROR(Text053,FIELDCAPTION("Salesperson Code"));

        CreateDim(
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::Customer,"Bill-to Customer No.",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Customer Template","Bill-to Customer Template Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
        //<<DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362
        CreateDim(
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::Customer,GetCustNoCalcDim(),
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Customer Template","Bill-to Customer Template Code",
          DATABASE::Building,"Building No.",
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(1,"Contract Type"),GetContractNo);
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //>>DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362

        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        if xRec."Salesperson Code" <> "Salesperson Code" then
          UpdateRoutePlanRqstLines(FIELDCAPTION("Salesperson Code"));
        // >>DITW18.00.07 DDR DIT-770 #1488
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-to Doc. No."(Field 53).OnLookup". Please convert manually.

        //trigger  No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Bal. Account No.",'');
        CustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive,"Due Date");
        CustLedgEntry.SETRANGE("Customer No.","Bill-to Customer No.");
        CustLedgEntry.SETRANGE(Open,true);
        #5..19
              CustLedgEntry.SETRANGE(Positive);
            end;

        ApplyCustEntries.SetSales(Rec,CustLedgEntry,SalesHeader.FIELDNO("Applies-to Doc. No."));
        ApplyCustEntries.SETTABLEVIEW(CustLedgEntry);
        ApplyCustEntries.SETRECORD(CustLedgEntry);
        #26..29
            "Currency Code",CustLedgEntry."Currency Code",GenJnlLine."Account Type"::Customer,true);
          "Applies-to Doc. Type" := CustLedgEntry."Document Type";
          "Applies-to Doc. No." := CustLedgEntry."Document No.";
        end;
        CLEAR(ApplyCustEntries);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Bal. Account No.",'');
        // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
        TESTFIELD("Deposit Bal. Account No.",'');
        // >>DITW16.00.00.42 DDR DIT-715 #370
        #2..22
        //<<DITW17.10.03 MSF 17/03/2014 DIT-715 #340
        if "DIT Sub-Contract Type"<>"DIT Sub-Contract Type"::" " then
          CustLedgEntry.SETRANGE("DIT Sub-Contract Type","DIT Sub-Contract Type");
        if "Contract Group Code"<>'' then
          CustLedgEntry.SETRANGE("Contract Group Code","Contract Group Code");
        //<<DITW18.00.06 MSF 31/07/2015 - DDR 07/08/2015 DIT-770 #1368
        if GetContractNo() <> '' then
          CustLedgEntry.SETRANGE("Service Contract No.",GetContractNo);
        //>>DITW18.00.06 MSF 31/07/2015 - DDR 07/08/2015 DIT-770 #1368
        //>>DITW17.10.03 MSF 17/03/2014 DIT-715 #340
        //<<DITW17.10.03 TEC1 05/02/2014 DIT-770 #340
        CustLedgEntry.SETRANGE("Customer Posting Group","Customer Posting Group");
        //>>DITW17.10.03 TEC1 DIT-770 #340


        #23..32
          //<<DITW17.10.03 MSF 17/03/2014 DIT-715 #340
           "DIT Sub-Contract Type" := CustLedgEntry."DIT Sub-Contract Type";
           "Service Contract No." := CustLedgEntry."Service Contract No.";
           //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
           "Financial Contract No." := CustLedgEntry."Financial Contract No.";
           //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
           "Contract Group Code" := CustLedgEntry."Contract Group Code";
           "Customer Posting Group" := CustLedgEntry."Customer Posting Group";
           //>>DITW17.10.03 MSF 17/03/2014 DIT-715 #340
        end;
        CLEAR(ApplyCustEntries);
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-to Doc. No."(Field 53).OnValidate". Please convert manually.

        //trigger  No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Applies-to Doc. No." <> '' then
          TESTFIELD("Bal. Account No.",'');

        if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." <> '') and
           ("Applies-to Doc. No." <> '')
        then begin
        #7..11
          else
            if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and ("Applies-to Doc. No." = '') then
              SetAmountToApply(xRec."Applies-to Doc. No.","Bill-to Customer No.");
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
        #4..14


        //>>DITW17.10.03 MSF 17/03/2014 DIT-715 #340
        FctmodifyparamcontractIT("Applies-to Doc. No.","Applies-to Doc. Type");
        //<<DITW17.10.03 MSF 17/03/2014 DIT-715 #340
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. Account No."(Field 55).OnValidate". Please convert manually.

        //trigger  Account No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Bal. Account No." <> '' then
          case "Bal. Account Type" of
            "Bal. Account Type"::"G/L Account":
        #4..12
                BankAcc.TESTFIELD("Currency Code","Currency Code");
              end;
          end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..15

        //<<DITW17.00.02 SR 09/09/2013 DIT-770 #135
        if ("Bal. Account No." = '') and (xRec."Bal. Account No." <> '') then
          "Payment Amount" := 0;
        //>>DITW17.00.02 SR DIT-770 #135
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Bus. Posting Group"(Field 74).OnValidate". Please convert manually.

        //trigger  Bus();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then begin
          if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") then
            "VAT Bus. Posting Group" := GenBusPostingGrp."Def. VAT Bus. Posting Group";
          RecreateSalesLines(FIELDCAPTION("Gen. Bus. Posting Group"));
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //TESTFIELD(Status,Status::Open);
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        #2..6
        */
        //end;


        //Unsupported feature: CodeModification on ""Transport Method"(Field 77).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdateSalesLines(FIELDCAPTION("Transport Method"),false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdateSalesLines(FIELDCAPTION("Transport Method"),false);
        // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
        CALCFIELDS("Transport Mode");
        // >>DITW16.00.00.40 DDR DIT-715 #187
        */
        //end;


        //Unsupported feature: CodeModification on ""Sell-to Customer Name"(Field 79).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Sell-to Customer No.",Customer.GetCustNo("Sell-to Customer Name"));
        GetShippingTime(FIELDNO("Sell-to Customer Name"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
        //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
        if "Sundry Customer" and
           (xRec."Sell-to Customer Name" <> "Sell-to Customer Name")
        then
          UpdateSundryFields(FIELDCAPTION("Sell-to Customer Name"));

        //>> DITW18.00.07 AKH DIT-770 #1804

        VALIDATE("Sell-to Customer No.",Customer.GetCustNo("Sell-to Customer Name"));
        GetShippingTime(FIELDNO("Sell-to Customer Name"));
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Sell-to Customer Name 2"(Field 80)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
        //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
        if "Sundry Customer" and
          (xRec."Sell-to Customer Name 2" <> "Sell-to Customer Name 2")
        then
          UpdateSundryFields(FIELDCAPTION("Sell-to Customer Name 2"));
        //>> DITW18.00.07 AKH DIT-770 #1804
        */
        //end;


        //Unsupported feature: CodeModification on ""Sell-to Address"(Field 81).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdateShipToAddressFromSellToAddress(FIELDNO("Ship-to Address"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
        //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
        if "Sundry Customer" and
          (xRec."Sell-to Address" <> "Sell-to Address")
        then
          UpdateSundryFields(FIELDCAPTION("Sell-to Address"));
        //>> DITW18.00.07 AKH DIT-770 #1804

        UpdateShipToAddressFromSellToAddress(FIELDNO("Ship-to Address"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Sell-to Address 2"(Field 82).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdateShipToAddressFromSellToAddress(FIELDNO("Ship-to Address 2"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
        //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
        if "Sundry Customer" and
          (xRec."Sell-to Address 2" <> "Sell-to Address 2")
        then
          UpdateSundryFields(FIELDCAPTION("Sell-to Address 2"));
        //>> DITW18.00.07 AKH DIT-770 #1804

        UpdateShipToAddressFromSellToAddress(FIELDNO("Ship-to Address 2"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Sell-to City"(Field 83).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Sell-to City","Sell-to Post Code","Sell-to County","Sell-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        UpdateShipToAddressFromSellToAddress(FIELDNO("Ship-to City"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Sell-to City","Sell-to Post Code","Sell-to County","Sell-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);

        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
        //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
        if "Sundry Customer" and
          (xRec."Sell-to City" <> "Sell-to City")
        then
          UpdateSundryFields(FIELDCAPTION("Sell-to City"));
        //>> DITW18.00.07 AKH DIT-770 #1804

        UpdateShipToAddressFromSellToAddress(FIELDNO("Ship-to City"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Sell-to Post Code"(Field 88).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Sell-to City","Sell-to Post Code","Sell-to County","Sell-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        UpdateShipToAddressFromSellToAddress(FIELDNO("Ship-to Post Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Sell-to City","Sell-to Post Code","Sell-to County","Sell-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);

        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
        //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
        if "Sundry Customer" and (xRec."Sell-to Post Code" <> "Sell-to Post Code") then
          UpdateSundryFields(FIELDCAPTION("Sell-to Post Code"));
        //>> DITW18.00.07 AKH DIT-770 #1804

        UpdateShipToAddressFromSellToAddress(FIELDNO("Ship-to Post Code"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Document Date"(Field 99).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if xRec."Document Date" <> "Document Date" then
          UpdateDocumentDate := true;
        VALIDATE("Payment Terms Code");
        VALIDATE("Prepmt. Payment Terms Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Document Date" <> "Document Date" then
          UpdateDocumentDate := true;
        // >>HEI.48
        //VALIDATE("Payment Terms Code");
        // <<HEI.48
        // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
        VALIDATE("Deposit Payment Terms Code");
        // >>DITW16.00.00.42 DDR DIT-715 #370
        VALIDATE("Prepmt. Payment Terms Code");
        //<<HEI.38 - Code is added to calculate Currency Factor when changing the Document Date instead of changing the Posting Date

        if ("Document Type" in ["Document Type"::Invoice,"Document Type"::"Credit Memo"]) and
           not ("Posting Date" = xRec."Posting Date")
        then
          PriceMessageIfSalesLinesExist(FIELDCAPTION("Posting Date"));

        if "Currency Code" <> '' then begin
          UpdateCurrencyFactor;
          // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860
          InitHasBeenShow(HasBeenShowText021,'',FIELDNO("Document Date"));
          // >>DITW16.00.00.43 DDR DIT-715 #860
          if "Currency Factor" <> xRec."Currency Factor" then
            ConfirmUpdateCurrencyFactor;
        end;

        //>>HEI.38
        */
        //end;


        //Unsupported feature: CodeInsertion on ""External Document No."(Field 100)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        ///DITW110.00.11 MSF 21/09/2017 NRQ#16082-DITW110.00.11 MSF 30/11/2017 NRQ#16082

        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        UpdateRoutePlanRqstLines(FIELDCAPTION("External Document No."));
        // >>DITW18.00.07 DDR DIT-770 #1488
        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        UpdateWhseRequestLines(FIELDCAPTION("External Document No."));
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Method Code"(Field 104).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PaymentMethod.INIT;
        if "Payment Method Code" <> '' then
          PaymentMethod.GET("Payment Method Code");
        #4..8
          "Direct Debit Mandate ID" := '';
        "Bal. Account Type" := PaymentMethod."Bal. Account Type";
        "Bal. Account No." := PaymentMethod."Bal. Account No.";
        if "Bal. Account No." <> '' then begin
          TESTFIELD("Applies-to Doc. No.",'');
          TESTFIELD("Applies-to ID",'');
          CLEAR("Payment Service Set ID");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11
        //IF "Bal. Account No." <> '' THEN BEGIN
        //<<DITW17.00.02 SR 09/09/2013 DIT-770 #135
        if ("Bal. Account No." = '') and (xRec."Bal. Account No." <> '') then
          "Payment Amount" := 0;

        if "Deposit Bal. Account No." <> '' then begin
        #13..16
        //>>DITW17.00.02 SR DIT-770 #135

        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        if xRec."Payment Method Code" <> "Payment Method Code" then
          UpdateRoutePlanRqstLines(FIELDCAPTION("Payment Method Code"));
        // >>DITW18.00.07 DDR DIT-770 #1488
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Agent Code"(Field 105).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        if xRec."Shipping Agent Code" = "Shipping Agent Code" then
          exit;

        "Shipping Agent Service Code" := '';
        GetShippingTime(FIELDNO("Shipping Agent Code"));
        UpdateSalesLines(FIELDCAPTION("Shipping Agent Code"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159 - DITW17.00.02 AT 20/12/2013 DIT-770 #289 - DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159 - DITW17.00.02 AT 20/12/2013 DIT-770 #289 - DITW18.00.07 DDR DIT-770 #1488
        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        if "Multiple Order Route" then
          if CurrFieldNo = FIELDNO("Shipping Agent Code") then
            ERROR(Text2014062);
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        // <<DITW18.00.07 DDR 25/02/2016 DIT-770 #1488
        TestRouteTypeVariable(FIELDNO("Shipping Agent Code"));
        // >>DITW18.00.07 DDR DIT-770 #1488
        //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        if (xRec."Shipping Agent Code" <> Rec."Shipping Agent Code") and ("Shipping Agent Code" <>'') and
          ("Responsibility Center" <> '') then
          UserSetupMgt.CheckShipmentAgent("Responsibility Center","Shipping Agent Code");
        //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214

        #2..4
        // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
        if "Document Type" = "Document Type"::Order then
          TestIfEmcsSalesLinesExist(FIELDCAPTION("Shipping Agent Code"));
        // >>DITW16.00.00.43 DDR DIT-715 #720

        "Shipping Agent Service Code" := '';

        // <<DITW15.00.00.24 DDR 21/08/2008
        "Shipping Charge Per" := "Shipping Charge Per"::Shipment;
        // >>DITW15.00.00.24 DDR
        GetShippingTime(FIELDNO("Shipping Agent Code"));

        // <<DITW15.00.00.39 DDR 06/07/2011 #1353
        GetJourneyTime(FIELDNO("Shipping Agent Code"));
        // >>DITW15.00.00.39 DDR #1353
        // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
        UpdateSalesLines(FIELDCAPTION("Shipping Agent Code"),(CurrFieldNo <> 0) and ("Route Planning No." = ''));
        // >>DITW18.00.07 DDR DIT-770 #1488
        // <<DITW19.00.08 DDR 01/12/2016 BL#10314
        VALIDATE("Shipping Agent Service Code",'');
        // >>DITW19.00.08 DDR BL#10314
        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        UpdateRoutePlanRqstLines(FIELDCAPTION("Shipping Agent Code"));
        // >>DITW18.00.07 DDR DIT-770 #1488
        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1109
        ClearHasBeenShowAll2(FIELDNO("Shipping Agent Code"));
        // >>DITW18.00.07 DDR DIT-770 #1109
        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        UpdateWhseRequestLines(FIELDCAPTION("Shipping Agent Code"));
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082

        //HEI.16>>
        if "Document Type" = "Document Type"::Order then begin
          if ShippingAgent.GET("Shipping Agent Code") then begin
            //HEI.27>>
            //IF ShippingAgent."Vendor No." = '' THEN
            if (ShippingAgent."Vendor No." = '') and (not ShippingAgent."Own Logistics") then
            //HEI.27<<
              ERROR(ShippingAgentVendorIsBlank)
            else if Vend.GET(ShippingAgent."Vendor No.") then begin
              if Vend.Blocked <> 0 then
                ERROR(VendorBlockForShipAgent);
            end;
          end;
        end;
        //HEI.16<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Tax Area Code"(Field 114).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        ValidateTaxAreaCode;
        MessageIfSalesLinesExist(FIELDCAPTION("Tax Area Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        ValidateTaxAreaCode;
        MessageIfSalesLinesExist(FIELDCAPTION("Tax Area Code"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Tax Liable"(Field 115).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        MessageIfSalesLinesExist(FIELDCAPTION("Tax Liable"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        MessageIfSalesLinesExist(FIELDCAPTION("Tax Liable"));
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT Bus. Posting Group"(Field 116).OnValidate". Please convert manually.

        //trigger  Posting Group"(Field 116)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        if xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group" then
          RecreateSalesLines(FIELDCAPTION("VAT Bus. Posting Group"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        if xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group" then
          //<< FINXL9.00.000.01 AKH 13/01/2017
          if not recUserSetup.GET(USERID) then
            recUserSetup.INIT;
          if ShipmentLineExists() and (recUserSetup."Change VAT Bus Group on Inv") then
            UpdateSalesLines(FIELDCAPTION("VAT Bus. Posting Group"),CurrFieldNo <> 0)
          else
          //>> FINXL9.00.000.01 AKH 13/01/2017
          RecreateSalesLines(FIELDCAPTION("VAT Bus. Posting Group"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-to ID"(Field 118).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Applies-to ID" <> '' then
          TESTFIELD("Bal. Account No.",'');
        if ("Applies-to ID" <> xRec."Applies-to ID") and (xRec."Applies-to ID" <> '') then begin
          CustLedgEntry.SETCURRENTKEY("Customer No.",Open);
          CustLedgEntry.SETRANGE("Customer No.","Bill-to Customer No.");
        #6..8
            CustEntrySetApplID.SetApplId(CustLedgEntry,TempCustLedgEntry,'');
          CustLedgEntry.RESET;
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
        #3..11
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT Base Discount %"(Field 119).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if not (CurrFieldNo in [0,FIELDNO("Posting Date"),FIELDNO("Document Date")]) then
          TESTFIELD(Status,Status::Open);
        GLSetup.GET;
        if "VAT Base Discount %" > GLSetup."VAT Tolerance %" then
          ERROR(
        #6..12
        then
          exit;

        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","No.");
        SalesLine.SETFILTER(Type,'<>%1',SalesLine.Type::" ");
        SalesLine.SETFILTER(Quantity,'<>0');
        SalesLine.LOCKTABLE;
        LOCKTABLE;
        if SalesLine.FINDSET then begin
          MODIFY;
          repeat
            if (SalesLine."Quantity Invoiced" <> SalesLine.Quantity) or
               ("Shipping Advice" <> "Shipping Advice"::Partial) or
        #27..32
          until SalesLine.NEXT = 0;
        end;
        SalesLine.RESET;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not (CurrFieldNo in [0,FIELDNO("Posting Date"),FIELDNO("Document Date")]) then
          //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
          //TESTFIELD(Status,Status::Open);
          TestOpenStatus;
          //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        #3..15
        // <<DITW15.00.00.37 DDR 23/04/2010
        SalesLine.RESET;
        SalesLine.SuspendStatusCheck(StatusCheckSuspended);
        SalesLine.SetHideValidationDialog(CurrFieldNo = 0);
        SalesLine.SetBatchInsertCheck(StatusCheckSuspended or (CurrFieldNo = 0));
        // >>DITW15.00.00.37 DDR

        //HEI.53>>
        // <<DITW18.00.07 DDR 03/06/2016 DIT-770 #642 - DITW111.00.13 DDR 31/08/2018 NRQ#83292
        //SalesLine.SetSalesHeader(Rec);
        // >>DITW18.00.07 DDR DIT-770 #642 - DITW111.00.13 DDR NRQ#83292
        //HEI.53<<

        #16..23
          //HEI.53>>
          // <<DITW18.00.07 DDR 03/06/2016 DIT-770 #642 - DITW111.00.13 DDR 31/08/2018 NRQ#83292
          SalesLine.SetSalesHeader(Rec);
          // >>DITW18.00.07 DDR DIT-770 #642 - DITW111.00.13 DDR NRQ#83292
          //HEI.53<<
        #24..35
        */
        //end;


        //Unsupported feature: CodeInsertion on "Status(Field 120)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        UpdateSalesLines(FIELDCAPTION(Status),false);
        UpdateRoutePlanRqstLines(FIELDCAPTION(Status));
        // >>DITW18.00.07 DDR DIT-770 #1488
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepmt. Payment Discount %"(Field 140).OnValidate". Please convert manually.

        //trigger  Payment Discount %"(Field 140)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if not (CurrFieldNo in [0,FIELDNO("Posting Date"),FIELDNO("Document Date")]) then
          TESTFIELD(Status,Status::Open);
        GLSetup.GET;
        if "Payment Discount %" < GLSetup."VAT Tolerance %" then
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
          //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
          //TESTFIELD(Status,Status::Open);
          TestOpenStatus;
          //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        #3..8
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
          DATABASE::Customer,"Bill-to Customer No.",
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Customer Template","Bill-to Customer Template Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362
        CreateDim(
          DATABASE::Campaign,"Campaign No.",
          DATABASE::Customer,GetCustNoCalcDim(),
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Customer Template","Bill-to Customer Template Code",
          DATABASE::Building,"Building No.",
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(1,"Contract Type"),GetContractNo);
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //>>DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362
        */
        //end;


        //Unsupported feature: CodeModification on ""Sell-to Customer Template Code"(Field 5051).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Document Type","Document Type"::Quote);
        TESTFIELD(Status,Status::Open);

        if not InsertMode and
           ("Sell-to Customer Template Code" <> xRec."Sell-to Customer Template Code") and
           (xRec."Sell-to Customer Template Code" <> '')
        then begin
          if HideValidationDialog then
            Confirmed := true
          else
            Confirmed := CONFIRM(ConfirmChangeQst,false,FIELDCAPTION("Sell-to Customer Template Code"));
        #12..30
            (xRec."Currency Code" <> "Currency Code"))
        then
          RecreateSalesLines(FIELDCAPTION("Sell-to Customer Template Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Document Type","Document Type"::Quote);
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        #3..7
          //<<HEI.59
          //IF HideValidationDialog THEN
          if (HideValidationDialog) or ( not GUIALLOWED) then
          //>>HEI.59
        #9..33
        */
        //end;


        //Unsupported feature: CodeModification on ""Sell-to Contact No."(Field 5052).OnValidate". Please convert manually.

        //trigger "(Field 5052)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);

        if ("Sell-to Contact No." <> xRec."Sell-to Contact No.") and
           (xRec."Sell-to Contact No." <> '')
        #5..43

        UpdateSellToCust("Sell-to Contact No.");
        UpdateSellToCustTemplateCode;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        #2..46
        */
        //end;


        //Unsupported feature: CodeModification on ""Bill-to Contact No."(Field 5053).OnValidate". Please convert manually.

        //trigger "(Field 5053)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);

        if ("Bill-to Contact No." <> xRec."Bill-to Contact No.") and
           (xRec."Bill-to Contact No." <> '')
        then begin
          if HideValidationDialog then
            Confirmed := true
          else
            Confirmed := CONFIRM(ConfirmChangeQst,false,FIELDCAPTION("Bill-to Contact No."));
        #10..27
        end;

        UpdateBillToCust("Bill-to Contact No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        #2..5
          //<<HEI.59
          //IF HideValidationDialog THEN
          if (HideValidationDialog) or (not GUIALLOWED) then
          //>>HEI.59
        #7..30
        */
        //end;


        //Unsupported feature: CodeModification on ""Bill-to Customer Template Code"(Field 5054).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Document Type","Document Type"::Quote);
        TESTFIELD(Status,Status::Open);

        if not InsertMode and
           ("Bill-to Customer Template Code" <> xRec."Bill-to Customer Template Code") and
           (xRec."Bill-to Customer Template Code" <> '')
        then begin
          if HideValidationDialog then
            Confirmed := true
          else
            Confirmed := CONFIRM(ConfirmChangeQst,false,FIELDCAPTION("Bill-to Customer Template Code"));
        #12..17
          end;
        end;

        VALIDATE("Ship-to Code",'');
        if BillToCustTemplate.GET("Bill-to Customer Template Code") then begin
          BillToCustTemplate.TESTFIELD("Customer Posting Group");
          "Customer Posting Group" := BillToCustTemplate."Customer Posting Group";
          "Invoice Disc. Code" := BillToCustTemplate."Invoice Disc. Code";
          "Customer Price Group" := BillToCustTemplate."Customer Price Group";
          "Customer Disc. Group" := BillToCustTemplate."Customer Disc. Group";
          "Allow Line Disc." := BillToCustTemplate."Allow Line Disc.";
          VALIDATE("Payment Terms Code",BillToCustTemplate."Payment Terms Code");
          VALIDATE("Payment Method Code",BillToCustTemplate."Payment Method Code");
          "Shipment Method Code" := BillToCustTemplate."Shipment Method Code";
        end;

        CreateDim(
          DATABASE::"Customer Template","Bill-to Customer Template Code",
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::Customer,"Bill-to Customer No.",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center");

        if not InsertMode and
           (xRec."Sell-to Customer Template Code" = "Sell-to Customer Template Code") and
           (xRec."Bill-to Customer Template Code" <> "Bill-to Customer Template Code")
        then
          RecreateSalesLines(FIELDCAPTION("Bill-to Customer Template Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Document Type","Document Type"::Quote);
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        #3..7
          //<<HEI.59
          //IF HideValidationDialog THEN
          if (HideValidationDialog) or(not GUIALLOWED) then
          //>>HEI.59
        #9..20
        // <<DITW16.00.00.43 DDR 13/05/2013 DIT-715 #604
        //VALIDATE("Ship-to Code",'');
        //only from sell-to customer
        CustSellto.GET( "Sell-to Customer No.");
        VALIDATE("Ship-to Code",CustSellto."Ship-to Code");
        // >>DITW16.00.00.43 DDR DIT-715 #604


        if BillToCustTemplate.GET("Bill-to Customer Template Code") then begin
          // <<DITW16.00.00.41 AHU 13/08/2012 DIT-715 #327
          //BillToCustTemplate.TESTFIELD("Customer Posting Group");
          //"Customer Posting Group" := BillToCustTemplate."Customer Posting Group";
          // <<DITW16.00.00.41 AHU 13/08/2012 DIT-715 #327
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          if (GetContractNo <> '') or ("Contract Group Code" <> '') or
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ")
          then begin
            DitPropServSetup.GET;
            if DitPropServSetup."Subcontract Type Posting Group" then
              "Customer Posting Group" := BillToCustTemplate.GetContractPostingGr("DIT Sub-Contract Type",true);
          end else begin
          // >>DITW16.00.00.41 AHU DIT-715 #327
            BillToCustTemplate.TESTFIELD("Customer Posting Group");
            "Customer Posting Group" := BillToCustTemplate."Customer Posting Group";
          end;
          // <<DITW16.00.00.42 DDR 12/12/2012 14/12/2012 DIT-715 #520
          GetCust("Sell-to Customer No.");
          if IsCustCalcPrices(Cust,SalesSetup."Bill-to/Sell-to Prices Calc."::"Bill-to") then begin
          // >>DITW16.00.00.42 DDR DIT-715 #520
            "Invoice Disc. Code" := BillToCustTemplate."Invoice Disc. Code";
            "Customer Price Group" := BillToCustTemplate."Customer Price Group";
            "Customer Disc. Group" := BillToCustTemplate."Customer Disc. Group";
            "Allow Line Disc." := BillToCustTemplate."Allow Line Disc.";
          // <<DITW16.00.00.42 DDR 12/12/2012 DIT-715 #520
          end;
          // >>DITW16.00.00.42 DDR DIT-715 #520
        #29..31
          // <<DITW15.00.00.38 DDR 11/08/2010 #1217
          // <<DITW15.00.00.38 DDR 23/02/2011 #1286
          // <<DITW16.00.00.42 DDR 12/12/2012 14/12/2012 DIT-715 #520
          if IsCustCalcTaxes(CustSellto,GLSetup."Sell-to/Bill-to DTax Gr. Calc."::"Bill-to/Pay-to No.") then
          // >>DITW16.00.00.42 DDR DIT-715 #520
            "Customer DTax Group Code" := BillToCustTemplate."DTax Group Code";
          // >>DITW15.00.00.38 #1286
          // <<DITW16.00.00.42 DDR 12/12/2012 14/12/2012 DIT-715 #520
          if IsCustCalcPrices(Cust,SalesSetup."Bill-to/Sell-to Prices Calc."::"Bill-to") then
          // >>DITW16.00.00.42 DDR DIT-715 #520
            "Customer DDeposit Group Code" := BillToCustTemplate."DDeposit Group Code";
          //"Tax Office Code" := BillToCustTemplate."Tax Office Code";
          "Shipping Agent Code" := BillToCustTemplate."Shipping Agent Code";
          "Shipping Agent Service Code" := BillToCustTemplate."Shipping Agent Service Code";
          "Responsibility Center" := BillToCustTemplate."Responsibility Center";
          "Location Code" := BillToCustTemplate."Location Code";
          Distance := BillToCustTemplate.Distance;
          // >>DITW15.00.00.38 DDR
        end;

        //<<DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362
        #34..36
          DATABASE::Customer,GetCustNoCalcDim(),
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::Building,"Building No.",
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(1,"Contract Type"),GetContractNo);
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //>>DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362
        #40..45
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
        if not UserSetupMgt.CheckRespCenter(0,"Responsibility Center") then
          ERROR(
            Text027,
            RespCenter.TABLECAPTION,UserSetupMgt.GetSalesFilter);

        "Location Code" := UserSetupMgt.GetLocation(0,'',"Responsibility Center");
        UpdateOutboundWhseHandlingTime;
        UpdateShipToAddress;

        CreateDim(
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::Customer,"Bill-to Customer No.",
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Customer Template","Bill-to Customer Template Code");

        if xRec."Responsibility Center" <> "Responsibility Center" then begin
          RecreateSalesLines(FIELDCAPTION("Responsibility Center"));
          "Assigned User ID" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159

        #2..6
        // <<DITW18.00.06 DDR 19/02/2015 DIT-770 #1190
        // "Location Code" := UserSetupMgt.GetLocation(0,'',"Responsibility Center");
        if (CurrFieldNo <> FIELDNO("Location Code")) and
          (CurrFieldNo <> FIELDNO("Physical Location Group Code")) and
          (xRec."Physical Location Group Code" = "Physical Location Group Code") and
          (xRec."Location Code" = "Location Code")
        then begin
            // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1190
            SETRANGE("Phys. Location Table Filter");
            SETRANGE("Location Table Filter");
            // >>DITW18.00.06 DDR DIT-770 #1190
            //<< DITW19.00.08 AKH 16/12/2016 BL#9797
            PhysicalLocationCode := UserSetupMgt.GetphysicalLocation(0,'',"Responsibility Center");
            if (PhysicalLocationCode <> '') then
              VALIDATE("Physical Location Group Code" , PhysicalLocationCode);
            //<< DITW19.00.08 AKH BL#9797
            LocationCode := UserSetupMgt.GetLocation(0,'',"Responsibility Center");
            if (LocationCode <> '') or ("Physical Location Group Code" = '') then
              VALIDATE("Location Code", LocationCode);

          // <<DITW111.00.13 DDR 11/01/2019 NRQ#88589
          // <<DITW18.00.07 DDR 28/06/2016 DIT-770 #1265
          if (xRec."Sell-to Customer No." = "Sell-to Customer No.") and
             (xRec."Bill-to Customer No." = "Bill-to Customer No.")
             /// DITW110.00.12A DDR 13/08/2018 NRQ#41769 - DITW111.00.13 DDR 11/01/2019 NRQ#88589
          then
          // >>DITW18.00.07 DDR DIT-770 #1265
            RecreateSalesLines(FIELDCAPTION("Responsibility Center"));
          // >>DITW111.00.13 DDR NRQ#88589
        end;
        // >>DITW18.00.06 DDR DIT-770 #1190
        UpdateOutboundWhseHandlingTime;

        // <<DITW18.00.07 DDR 30/05/2016 DIT-770 #642
        if xRec."Location Code" <> "Location Code" then
        // >>DITW18.00.07 DDR DIT-770 #642
          //<< DITW18.00.07 VSC 10/03/2016 DIT-770 #1066
          //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
          //<< DITW18.00.07 VSC 04/07/2016 DIT-770 #1066
          CreateShippingCost(Rec,false,false);
          //>> DITW18.00.07 VSC DIT-770 #1066
          //>> DITW18.00.07 VSC DIT-770 #1066
          //>> DITW18.00.07 VSC DIT-770 #1066


        UpdateShipToAddress;

        //<<DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362
        CreateDim(
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::Customer,GetCustNoCalcDim(),
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Customer Template","Bill-to Customer Template Code",
          DATABASE::Building,"Building No.",
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(1,"Contract Type"),GetContractNo);
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //>>DITW18.00.06 MSF 23/04/2015 DIT-770 DIT-770 #1362

        if xRec."Responsibility Center" <> "Responsibility Center" then begin
          // <<DITW18.00.07 DDR 28/06/2016 DIT-770 #1265
          if (xRec."Sell-to Customer No." = "Sell-to Customer No.") and
             (xRec."Bill-to Customer No." = "Bill-to Customer No.") and
             // <<DITW110.00.12A DDR 13/08/2018 NRQ#41769
             (xRec."Location Code" = "Location Code") and
             (xRec."Physical Location Group Code" = "Physical Location Group Code")
             // >>DITW110.00.12A DDR NRQ#41769
          then
          // >>DITW18.00.07 DDR DIT-770 #1265
            RecreateSalesLines(FIELDCAPTION("Responsibility Center"));
          "Assigned User ID" := '';
          //<<DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
          UpdatefromCustrespcenterrelation;
          //>>DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
          // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
          UpdateRoutePlanRqstLines(FIELDCAPTION("Responsibility Center"));
          // >>DITW18.00.07 DDR DIT-770 #1488
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Advice"(Field 5750).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        if InventoryPickConflict("Document Type","No.","Shipping Advice") then
          ERROR(Text066,FIELDCAPTION("Shipping Advice"),FORMAT("Shipping Advice"),TABLECAPTION);
        if WhseShpmntConflict("Document Type","No.","Shipping Advice") then
          ERROR(STRSUBSTNO(Text070,FIELDCAPTION("Shipping Advice"),FORMAT("Shipping Advice"),TABLECAPTION));
        WhseSourceHeader.SalesHeaderVerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        #2..6
        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        if xRec."Shipping Advice" <> "Shipping Advice" then
          UpdateRoutePlanRqstLines(FIELDCAPTION("Shipping Advice"));
        // >>DITW18.00.07 DDR DIT-770 #1488
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Requested Delivery Date"(Field 5790).OnValidate". Please convert manually.

        //trigger (Variable: ShippingTime)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Requested Delivery Date"(Field 5790).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        if "Promised Delivery Date" <> 0D then
          ERROR(
            Text028,
            FIELDCAPTION("Requested Delivery Date"),
            FIELDCAPTION("Promised Delivery Date"));

        if "Requested Delivery Date" <> xRec."Requested Delivery Date" then
          UpdateSalesLines(FIELDCAPTION("Requested Delivery Date"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        #2..9

        // >>HEI.51
        if xRec."Requested Delivery Date" <> "Requested Delivery Date" then
          UpdateRoutePlanRqstLines(FIELDCAPTION("Requested Delivery Date"));
        // <<HEI.51

        //HEI.57>>
        if "Requested Delivery Date" <> 0D then begin
          ShippingTime := '';
          ShippingTime := '<-' + FORMAT("Shipping Time") + '>';
          if ShippingTime = '<->' then begin
            if "Requested Delivery Date" >= WORKDATE then
              VALIDATE("Shipment Date","Requested Delivery Date")
            else
              VALIDATE("Shipment Date",WORKDATE);
          end else begin
            if CALCDATE(ShippingTime,"Requested Delivery Date") >= WORKDATE then
              VALIDATE("Shipment Date",CALCDATE(ShippingTime,"Requested Delivery Date"))
            else
              VALIDATE("Shipment Date",WORKDATE);
          end;
        end;
        //HEI.57<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Promised Delivery Date"(Field 5791).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        if "Promised Delivery Date" <> xRec."Promised Delivery Date" then
          UpdateSalesLines(FIELDCAPTION("Promised Delivery Date"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        if "Promised Delivery Date" <> xRec."Promised Delivery Date" then
          UpdateSalesLines(FIELDCAPTION("Promised Delivery Date"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shipping Time"(Field 5792).OnValidate". Please convert manually.

        //trigger (Variable: ShippingTime)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Time"(Field 5792).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        if "Shipping Time" <> xRec."Shipping Time" then
          UpdateSalesLines(FIELDCAPTION("Shipping Time"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        if "Shipping Time" <> xRec."Shipping Time" then begin
          // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
          if ("Document Type" = "Document Type"::Order) and (FORMAT("Journey Time") = '') then
            TestIfEmcsSalesLinesExist(FIELDCAPTION("Shipping Time"));
          // >>DITW16.00.00.43 DDR DIT-715 #720
            UpdateSalesLines(FIELDCAPTION("Shipping Time"),CurrFieldNo <> 0);
        end;
        //HEI.57>>
        if "Shipping Time" <> xRec."Shipping Time" then
          if "Requested Delivery Date" <> 0D then begin
            ShippingTime := '';
            ShippingTime := '<-' + FORMAT("Shipping Time") + '>';
            if ShippingTime = '<->' then begin
              if "Requested Delivery Date" >= WORKDATE then
                VALIDATE("Shipment Date","Requested Delivery Date")
              else
                VALIDATE("Shipment Date",WORKDATE);
            end else begin
              if CALCDATE(ShippingTime,"Requested Delivery Date") >= WORKDATE then
                VALIDATE("Shipment Date",CALCDATE(ShippingTime,"Requested Delivery Date"))
              else
                VALIDATE("Shipment Date",WORKDATE);
            end;
          end;
        //HEI.57<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Outbound Whse. Handling Time"(Field 5793).OnValidate". Please convert manually.

        //trigger  Handling Time"(Field 5793)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        if ("Outbound Whse. Handling Time" <> xRec."Outbound Whse. Handling Time") and
           (xRec."Sell-to Customer No." = "Sell-to Customer No.")
        then
          UpdateSalesLines(FIELDCAPTION("Outbound Whse. Handling Time"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        #2..5
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shipping Agent Service Code"(Field 5794)". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //begin
        /*
        //>> HEI.39
        FilterShippingAgentServiceCode;
        //<< HEI.39
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Agent Service Code"(Field 5794).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        GetShippingTime(FIELDNO("Shipping Agent Service Code"));
        UpdateSalesLines(FIELDCAPTION("Shipping Agent Service Code"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159 - DITW17.00.02 AT 20/12/2013 DIT-770 #289 - DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159 - DITW17.00.02 AT 20/12/2013 DIT-770 #289 - DITW18.00.07 DDR DIT-770 #1488
        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        if "Multiple Order Route" then
          if CurrFieldNo = FIELDNO("Shipping Agent Service Code") then
            ERROR(Text2014062);
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        // <<DITW18.00.07 DDR 25/02/2016 DIT-770 #1488
        TestRouteTypeVariable(FIELDNO("Shipping Agent Service Code"));
        // >>DITW18.00.07 DDR DIT-770 #1488
        // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
        if "Document Type" = "Document Type"::Order then
          TestIfEmcsSalesLinesExist(FIELDCAPTION("Shipping Agent Service Code"));
        // >>DITW16.00.00.43 DDR DIT-715 #720

        GetShippingTime(FIELDNO("Shipping Agent Service Code"));

        // <<DITW15.00.00.39 DDR 06/07/2011 #1353
        GetJourneyTime(FIELDNO("Shipping Agent Service Code"));
        // >>DITW15.00.00.39 DDR #1353
        // <<DITW16.00.00.40 DDR 27/02/2012 DIT-715 #245
        "Truck Code" := '';
        // >>DITW16.00.00.40 DDR DIT-715 #245
        // <<DITW18.00.06 MSF 14/05/2015 DIT-770 #1035
        "Trailer Code" := '';
        // >>DITW18.00.06 MSF DIT-770 #1035
        // <<DIT15.00.00.24 DDR 14/08/2008 - DITW15.00.00.25 DDR 21/10/2008
        UpdateShippingMax();
        // >>DITW15.00.00.25 DDR
        // <<DITW18.00.07 DDR 29/02/2016 15/04/2015 DIT-770 #1488
        UpdateSalesLines(FIELDCAPTION("Shipping Agent Service Code"),(CurrFieldNo <> 0) and ("Route Planning No." = ''));
        // >>DITW18.00.07 DDR DIT-770 #1488
        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        UpdateRoutePlanRqstLines(FIELDCAPTION("Shipping Agent Service Code"));
        // >>DITW18.00.07 DDR DIT-770 #1488
        // <<DITW18.00.07 DDR 30/05/2016 DIT-770 #642
        if xRec."Shipping Agent Service Code" <> "Shipping Agent Service Code" then begin
        // >>DITW18.00.07 DDR DIT-770 #642
          //<< DITW18.00.07 VSC 10/03/2016 DIT-770 #1066
          //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
          //<< DITW18.00.07 VSC 04/07/2016 DIT-770 #1066
          CreateShippingCost(Rec,false,false);
          //>> HEI.33 FDD-HT658 IBM.GUNERE01 26.09.2019
          if Rec."Shipping Agent Service Code" = '' then
            WhseTransportMgt.DeleteSalesShippingCost(xRec,false);
          //<< HEI.33 FDD-HT658 IBM.GUNERE01 26.09.2019
          //>> DITW18.00.07 VSC DIT-770 #1066
          //>> DITW18.00.07 VSC DIT-770 #1066
          //>> DITW18.00.07 VSC DIT-770 #1066
          //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
          UpdateWhseRequestLines(FIELDCAPTION("Shipping Agent Service Code"))
          //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Allow Line Disc."(Field 7001).OnValidate". Please convert manually.

        //trigger "(Field 7001)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        MessageIfSalesLinesExist(FIELDCAPTION("Allow Line Disc."));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
        //TESTFIELD(Status,Status::Open);
        TestOpenStatus;
        //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
        SalesSetup.GET;
        if SalesSetup."Recalculate Prices" <> SalesSetup."Recalculate Prices"::" " then
          RecreateSalesLines(FIELDCAPTION("Customer Price Group"))
        else
        // >>DITW18.00.07 DDR DIT-770 #1402
          MessageIfSalesLinesExist(FIELDCAPTION("Allow Line Disc."));
        */
        //end;
        field(50000; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            Description = 'HEI.02';
            TableRelation = "WHT Business Posting Group FND".Code;

            trigger OnValidate();
            begin
                //WHT>>
                TESTFIELD(Status, Status::Open);
                if xRec."WHT Business Posting Group FND" <> "WHT Business Posting Group FND" then
                    RecreateSalesLines(FIELDCAPTION("WHT Business Posting Group FND"));
                //WHT<<
            end;
        }
        field(50005; "Posted Warehouse Ship. No. FND"; Code[20])
        {
            Description = 'LOGGAP07';
            Caption = 'Posted Warehouse Shipment No.';
        }
        field(50006; "Whse. Shipment No. FND"; Code[20])
        {
            Description = 'LOGGAP07';
            Caption = 'Warehouse Shipment No.';
        }
        field(50007; "RPM comp.SalesCrd. memoNo. FND"; Boolean)
        {
            Description = 'HEI.21';
            Caption = 'RPM comp.SalesCrd. memoNo.';
        }
        field(50012; "Sales Routes FND"; Code[10])
        {
            Description = 'HEI.09';
            Caption = 'Sales Routes';
            TableRelation = "Sales Routes FND";
        }
        field(50013; "Bonus Credit Memo FND"; Boolean)
        {
            Description = 'HEI.10';
            Caption = 'Bonus Credit Memo';
            Editable = false;
        }
        field(50014; "No. Printed Order Pick FND"; Integer)
        {
            Description = 'HEI.12';
            Caption = 'No. Printed Order Pick';
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
        field(50021; "Load No. FND"; Integer)
        {
            Caption = 'Load No.';
            Description = 'HEI.23';
        }
        field(50022; "Sequence No. FND"; Integer)
        {
            Caption = 'Sequence No.';
            Description = 'HEI,23';
        }
        field(50023; "Bill Of Lading No. FND"; Text[20])
        {
            Description = 'HEI.24';
            Caption = 'Bill Of Lading No.';
        }
        field(50024; "Vessel Name FND"; Text[30])
        {
            Description = 'HEI.24';
            Caption = 'Vessel Name';
        }
        field(50025; "ETD FND"; DateTime)
        {
            Description = 'HEI.24';
            Caption = 'ETD';
        }
        field(50026; "ETA FND"; DateTime)
        {
            Description = 'HEI.24';
            Caption = 'ETA';
        }
        field(50027; "Air Way Bill No FND"; Text[20])
        {
            Description = 'HEI.24';
            Caption = 'Air Way Bill No.';
        }
        field(50028; "Commodity Code FND"; Text[20])
        {
            Description = 'HEI.24';
            Caption = 'Commodity Code';
        }
        field(50029; "Custom Tariff Code FND"; Text[20])
        {
            Description = 'HEI.24';
            Caption = 'Custom Tariff Code';
        }
        field(50030; "InCo Terms FND"; Code[20])
        {
            Description = 'HEI.25';
            Caption = 'InCo Terms';
        }
        field(50031; "Suppress POS Interface FND"; Boolean)
        {
            Caption = 'Suppress POS Interface';
            Description = 'HEI.26';
        }
        field(50032; "Free Reason Code FND"; Code[10])
        {
            Description = 'HEI.28';
            Caption = 'Free Reason Code';
            // TableRelation = "Free Reason Code"; // BC Upgrade BHARDA11 ----Drink-IT Table  ("Free Reason Code")

            trigger OnValidate();
            begin
                /*//<<HEI.29
                SalesLine.RESET;
                SalesLine.SETRANGE("Document No.","No.");
                SalesLine.SETRANGE("Document Type","Document Type");
                SalesLine.SETRANGE(Type,SalesLine.Type::Item);
                IF SalesLine.FINDSET THEN REPEAT
                  SalesLine."Free Reason Code" := "Free Reason Code";
                  //SalesLine.VALIDATE("Free Reason Code");
                  Rec_FreeReasonCode.RESET;
                  IF Rec_FreeReasonCode.GET("Free Reason Code") THEN
                  IF Rec_FreeReasonCode."Gen. Bus. Posting Group" <> '' THEN
                  SalesLine."Gen. Bus. Posting Group" :=  Rec_FreeReasonCode."Gen. Bus. Posting Group";
                  SalesLine.MODIFY;
                UNTIL SalesLine.NEXT = 0;
                //<<HEI.29
                
                SalesLine.RESET;
                SalesLine.SETRANGE("Document No.","No.");
                SalesLine.SETRANGE("Document Type","Document Type");
                SalesLine.SETRANGE(Type,SalesLine.Type::Item);
                IF SalesLine.FINDSET THEN REPEAT
                  SalesLine."Free Reason Code" := "Free Reason Code";
                  SalesLine.MODIFY;
                UNTIL SalesLine.NEXT = 0;
                
                SalesLine.RESET;
                SalesLine.SETRANGE("Document No.","No.");
                SalesLine.SETRANGE("Document Type","Document Type");
                SalesLine.SETRANGE(Type,SalesLine.Type::Item);
                IF SalesLine.FINDSET THEN REPEAT
                Rec_FreeReasonCode.RESET;
                IF Rec_FreeReasonCode.GET("Free Reason Code") THEN
                 IF Rec_FreeReasonCode."Gen. Bus. Posting Group" <> '' THEN
                  SalesLine."Gen. Bus. Posting Group" :=  Rec_FreeReasonCode."Gen. Bus. Posting Group";
                  SalesLine.MODIFY;
                UNTIL SalesLine.NEXT = 0;
                */
                //>>HEI.29

            end;
        }
        field(50033; "Country of Origin FND"; Code[10])
        {
            Caption = 'Country of Origin';
            Description = 'HEI.30';
            TableRelation = "Country/Region";
        }
        field(50034; "EDI Order FND"; Boolean)
        {
            Description = 'HEI.46';
            Caption = 'EDI Order';
            Editable = false;
        }
        field(50035; "Time/Date Received FND"; DateTime)
        {
            Description = 'HEI.46';
            Editable = false;
            Caption = 'Time/Date Received';
        }
        field(50036; "Ealiest delivery Date Time FND"; DateTime)
        {
            Description = 'HEI.46';
            Editable = false;
            Caption = 'Earliest Delivery Date/Time';
        }
        field(50037; "Latest Delivery Date Time FND"; DateTime)
        {
            Description = 'HEI.46';
            Editable = false;
            Caption = 'Latest Delivery Date/Time';
        }
        field(50038; "System Date Time FND"; DateTime)
        {
            Description = 'HEI.46';
            Editable = false;
            Caption = 'System Date/Time';
        }
        field(50039; "Pick Date Time FND"; DateTime)
        {
            Description = 'HEI.46';
            Editable = false;
            Caption = 'Pick Date/Time';
        }
        field(50042; "WMS Export FND"; Boolean)
        {
            Caption = 'WMS Export';
            Description = 'HEI.37';
        }

        // BC Upgrade BHARDA11 >> ---Ethiopia Intercompany Automation
        // field(50041; "Special Order"; Boolean)
        // {
        //     Caption = 'Special Order';
        //     Description = 'HEI.36';
        // }
        // BC Upgrade BHARDA11 << ---Ethiopia Intercompany Automation

        // BC Upgrade SHUKLP03 >> Moved in the interface ext.
        // field(50042; "WMS Export"; Boolean)
        // {
        //     Caption = 'WMS Export';
        //     Description = 'HEI.37';
        // }
        // BC Upgrade SHUKLP03 << Moved in the interface ext.


        field(50050; "Send Document FND"; Option)
        {
            CaptionML = ENU = 'Send Document',
                        FRA = 'Envoyer Document';
            Description = 'HEI.40';
            Editable = false;
            OptionCaptionML = ENU = ' ,Mail,Print,Mail & Print',
                              FRA = ' ,E-Mail,Imprimer,E-Mail & Imprimer';
            OptionMembers = " ",Mail,Print,"Mail & Print";
        }
        field(50052; "Approval Status FND"; Option)
        {
            Caption = 'Approval Status';
            Description = 'HEI.42';
            Editable = false;
            OptionCaption = ' ,Approved,Rejected,Not Set';
            OptionMembers = " ",Approved,Rejected,"Not Set";
        }
        field(50060; "Source System Identifier FND"; Code[10])
        {
            Caption = 'Source System Identifier';
            Description = 'HEI.49';
            Editable = false;
            TableRelation = "Source Sys Identifier API FND";
        }
        field(50061; "Order Id FND"; Text[50])
        {
            Caption = 'Order Id';
            Description = 'HEI.49';
            Editable = false;
        }
        field(50062; "IC Order No. FND"; Code[15])
        {
            Description = 'HEI.52';
            Caption = 'IC Order No.';
            Editable = false;
        }
        field(50064; "Ready for Pick-up FND"; Boolean)
        {
            Caption = 'Ready for Pick-up';
            DataClassification = ToBeClassified;
            Description = 'HEI.56';
            Editable = false;
        }
        field(50065; "Total Quantity FND"; Decimal)
        {
            CalcFormula = Sum("Sales Line".Quantity WHERE("Document Type" = FIELD("Document Type"),
                                                           "Document No." = FIELD("No."),
                                                           Type = FILTER(Item)));
            Description = 'HEI.68';
            Caption = 'Total Quantity';
            Editable = false;
            FieldClass = FlowField;
        }
        // BC Upgrade SHUKLP03 << Created field for RA SO/SRO
        field(60000; "RA SO FND"; Boolean)
        {
            Caption = 'RA SO/SRO';
            DataClassification = ToBeClassified;
        }
        // BC Upgrade SHUKLP03 >> Document subtype code is added.
        field(50090; "Document Subtype Code FND"; Code[10])
        {
            CaptionML = ENU = 'Document Subtype Code',
                        FRA = 'Code Sous-Type Document';
            Description = 'DITW18.00.07 DIT-770 #1804-NRQ#83542';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales | "Fin.Contract"));

            trigger OnValidate();
            var
                DocumentSubtypeCode: Record "Document Subtype Code FND";
                PostingNoSeries: Code[20];
                DocumentSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";
            begin
                //>>HEI.15

                if Cust1.GET("Sell-to Customer No.") then begin
                    if DocumentSubtypeCodeSetup.GET() then;

                    if (((Cust1."Contract Type FND" = Cust1."Contract Type FND"::"CTS Only") or
                      (Cust1."Contract Type FND" = Cust1."Contract Type FND"::"Full Contract")) and
                       ("Document Subtype Code FND" <> DocumentSubtypeCodeSetup."CTS Order")) then
                        ERROR(Err002, DocumentSubtypeCodeSetup."CTS Order");
                end;

                //<<HEI.15

                //<<DITW111.00.13 MSF 04/09/2018 NRQ#83542-DITW111.00.13 MSF 05/09/2018 NRQ#83542
                if xRec."Document Subtype Code FND" <> Rec."Document Subtype Code FND" then
                    if Rec."Document Subtype Code FND" <> '' then begin
                        TESTFIELD("Posting No.", '');
                        PostingNoSeries := DocumentSubtypeCode.GetPostedSerialNoforDocumentSubtype("Document Type".AsInteger(), "Document Subtype Code FND");
                        if PostingNoSeries <> '' then
                            "Posting No. Series" := PostingNoSeries
                        else
                            SetDefaultPostingSerialno();
                    end else
                        SetDefaultPostingSerialno();

                //>>DITW111.00.13 MSF 04/09/2018 NRQ#83542-DITW111.00.13 MSF 05/09/2018 NRQ#83542
                //HEI.01>>
                UpdateSalesLines(FIELDCAPTION("Document Subtype Code FND"), false);
                //HEI.01<<
            end;
        }
        // BC Upgrade SHUKLP03 << Document subtype code is added.

        //BC UPGRADE KUMARR78>> Adding for MTC-FDD-MTC-012
        field(50091; "Logistic Status HNK FND"; Code[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Logistic Status';
        }
        modify("Logistic Status 107FDW")
        {
            trigger OnAfterValidate()
            begin
                "Logistic Status HNK FND" := "Logistic Status 107FDW";
            end;
        }
        //BC UPGRADE KUMARR78>> Adding for MTC-FDD-MTC-012
        // BC Upgrade BHARDA11 >> ----Drink-IT Fields 
        /* field(2013610; "Customer DDeposit Group Code"; Code[10])
        {
            CaptionML = ENU = 'Customer Depoist Group Code',
                        FRA = 'Code groupe consigne client';
            Description = 'DITW15.00.00.01';
            TableRelation = "Drink Deposit Group".Code WHERE("Source Type" = CONST(Customer));

            trigger OnValidate();
            begin
                //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
                TestOpenStatus;
                //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
                // <<DITW15.00.00.25 DDR 21/10/2008
                if xRec."Customer DDeposit Group Code" <> "Customer DDeposit Group Code" then begin
                    // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
                    SalesSetup.GET;
                    if SalesSetup."Recalculate Prices" <> SalesSetup."Recalculate Prices"::" " then
                        // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
                        RecreateChargeSalesLines(FIELDCAPTION("Customer DDeposit Group Code"))
                    // >>DITW16.00.00.43 DDR DIT-715 #691
                    else
                        MessageIfSalesLinesExist(FIELDCAPTION("Customer DDeposit Group Code"));
                    // >>DITW18.00.07 DDR DIT-770 #1402
                end;
                // >>DITW15.00.00.25 DDR
            end;
        }
        field(2013611; "Empty Goods Item No. Filter"; Code[20])
        {
            CaptionML = ENU = 'Empty Goods Item No. Filter',
                        FRA = 'Filtre article vidange n°';
            Description = 'DITW15.00.00.01-.35';
            FieldClass = FlowFilter;
            TableRelation = Item WHERE("Empty Good" = CONST(true));
        }
        field(2013613; "Link Sales Document No."; Code[20])
        {
            CaptionML = ENU = 'Link Sales Document No.',
                        FRA = 'Lien N° document vente';
            Description = 'DITW15.00.00.01';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FIELD("Link Sales Document Type"));
        }
        field(2013614; "Link Sales Document Type"; Option)
        {
            CaptionML = ENU = 'Link Sales Document Type',
                        FRA = 'Lien type document vente';
            Description = 'DITW15.00.00.01';
            OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order',
                              FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2013615; "Print Link Document"; Boolean)
        {
            CaptionML = ENU = 'Print Link Document',
                        FRA = 'Imprimer lien document';
            Description = 'DITW15.00.00.01';
        }
        field(2013616; "No. of Link Sales Orders"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Link Sales Document Type" = FIELD("Document Type"),
                                                      "Link Sales Document No." = FIELD("No.")));
            CaptionML = ENU = 'No. of Link Purchase Orders',
                        FRA = 'Nombre de lien commandes achats';
            Description = 'DITW15.00.00.01';
            Editable = false;
            FieldClass = FlowField;
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

            trigger OnLookup();
            begin
                // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                if ("Deposit Payment Terms Code" <> '') and ("Document Date" <> 0D) then
                    PaymentTerms.GET("Deposit Payment Terms Code");
            end;
        }
        field(2013632; "Deposit Payment Method Code"; Code[10])
        {
            CaptionML = ENU = 'Deposit - Payment Method Code',
                        FRA = 'Consigne - Code mode de règlement';
            Description = 'DITW16.00.00.42 DIT-715 #370';
            TableRelation = "Payment Method";

            trigger OnValidate();
            begin
                // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                PaymentMethod.INIT;
                if "Deposit Payment Method Code" <> '' then
                    PaymentMethod.GET("Deposit Payment Method Code");
                "Deposit Bal. Account Type" := PaymentMethod."Bal. Account Type";
                "Deposit Bal. Account No." := PaymentMethod."Bal. Account No.";
                if "Deposit Bal. Account No." <> '' then begin
                    TESTFIELD("Applies-to Doc. No.", '');
                    TESTFIELD("Applies-to ID", '');
                end;
            end;
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
            ELSE IF ("Deposit Bal. Account Type" = CONST("Bank Account")) "Bank Account";

            trigger OnValidate();
            begin
                if "Deposit Bal. Account No." <> '' then
                    case "Deposit Bal. Account Type" of
                        "Deposit Bal. Account Type"::"G/L Account":
                            begin
                                GLAcc.GET("Deposit Bal. Account No.");
                                GLAcc.CheckGLAcc;
                                GLAcc.TESTFIELD("Direct Posting", true);
                            end;
                        "Deposit Bal. Account Type"::"Bank Account":
                            begin
                                BankAcc.GET("Deposit Bal. Account No.");
                                BankAcc.TESTFIELD(Blocked, false);
                                BankAcc.TESTFIELD("Currency Code", "Currency Code");
                            end;
                    end;
            end;
        }
        field(2013638; "Deposit Posting No."; Code[20])
        {
            CaptionML = ENU = 'Deposit Posting No.',
                        FRA = 'N° facture consigne';
            Description = 'DITW16.00.00.42 DIT-715 #370';
            Editable = false;
            TableRelation = "Sales Invoice Header";
        }
        field(2013639; "Last Deposit Posting No."; Code[20])
        {
            CaptionML = ENU = 'Last Deposit Posting No.',
                        FRA = 'N° dern. facture consigne';
            Description = 'DITW16.00.00.42 DIT-715 #370';
            Editable = false;
            TableRelation = "Sales Invoice Header";
        }
        field(2013666; "Autom. Item Charge"; Option)
        {
            CaptionML = ENU = 'Calculate Item Charges',
                        FRA = 'Calculer Frais annexes';
            Description = 'DITW15.00.00.39 #1407';
            OptionCaptionML = ENU = 'Direct,Release,Posting,Posting (Excl. Item)',
                              FRA = 'Direct,Lancé,Validation,Validation (Excl. Article)';
            OptionMembers = " ",Release,Posting,PostingExclItem;
        }
        field(2013667; "Customer DTax Group Code"; Code[20])
        {
            CaptionML = ENU = 'Customer Tax Group Code',
                        FRA = 'Code groupe taxe client';
            Description = 'DITW15.00.00.01,HEI.04';
            TableRelation = "Drink Tax Group".Code WHERE("Source Type" = CONST(Customer));

            trigger OnValidate();
            begin
                //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
                TestOpenStatus;
                //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                if "Document Type" = "Document Type"::Order then
                    TestIfEmcsSalesLinesExist(FIELDCAPTION("Customer DTax Group Code"));
                // >>DITW16.00.00.43 DDR DIT-715 #720
                // <<DITW15.00.00.34 DDR 09/07/2009
                TestMsgTaxRegistration();
                // >>DITW15.00.00.34 DDR

                // <<DITW15.00.00.25 DDR 21/10/2008
                if xRec."Customer DTax Group Code" <> "Customer DTax Group Code" then begin
                    // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
                    SalesSetup.GET;
                    if SalesSetup."Recalculate Prices" <> SalesSetup."Recalculate Prices"::" " then begin
                        // >>DITW18.00.07 DDR DIT-770 #1402
                        // <<DITW17.10.03 DDR 19/05/2014 DIT-770 #623
                        UpdateSalesLines(FIELDCAPTION("Customer DTax Group Code"), CurrFieldNo <> 0);
                        // >>DITW17.10.03 DDR DIT-770 #623
                        // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
                        RecreateChargeSalesLines(FIELDCAPTION("Customer DTax Group Code"))
                        // >>DITW16.00.00.43 DDR DIT-715 #691
                        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
                    end else
                        MessageIfSalesLinesExist(FIELDCAPTION("Customer DTax Group Code"));
                    // >>DITW18.00.07 DDR DIT-770 #1402
                end;
                // >>DITW15.00.00.25 DDR

                // <<DITW18.00.07 MVN 07/04/2016 DIT-770 #1397
                if ApplMgt.IsObjectLicense(5, CODEUNIT::"EMCS EDI Mgt", 4) <> 0 then
                    // >>DITW18.00.07 MVN DIT-770 #1397
                    // <<DITW18.00.07 MVN 21/01/2016 DIT-770 #1397
                    "Submission Type" := EMCSEDIMgt.GetSubmissionType(1, "Customer DTax Group Code", "Location Code");
                // >>DITW18.00.07 MVN DIT-770 #1397
            end;
        }
        field(2013695; "Item Charge Type Filter"; Option)
        {
            CaptionML = ENU = 'Item Charge Type Filter',
                        FRA = 'Filtre type frais article';
            Description = 'DITW15.00.00.01';
            FieldClass = FlowFilter;
            OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
                              FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
            OptionMembers = " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost";
        }
        field(2013726; "Customer Tax Registration No."; Text[20])
        {
            CaptionML = ENU = 'Customer Tax Registration No.',
                        FRA = 'N° ident. accise client';
            Description = 'DITW15.00.00.28';

            trigger OnValidate();
            begin
                // <<DITW15.00.00.34 DDR 09/07/2009
                TestMsgTaxRegistration();
                // >>DITW15.00.00.34 DDR
            end;
        }
        field(2013730; "Fiscal Representative No."; Code[20])
        {
            CaptionML = ENU = 'Fiscal Representative / Customs Agent No.',
                        FRA = 'N° représentant fiscal / Agent des douanes';
            Description = 'DITW15.00.00.28-.38 #1217';
            TableRelation = "Fiscal Representative";

            trigger OnValidate();
            var
                ShipToAddr: Record "Ship-to Address";
            begin
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                if "Document Type" = "Document Type"::Order then
                    TestIfEmcsSalesLinesExist(FIELDCAPTION("Fiscal Representative No."));
                // >>DITW16.00.00.43 DDR DIT-715 #720
                // <<DITW15.00.00.28 DDR 24/11/2008
                if "Fiscal Representative No." <> '' then begin
                    rFiscalRep.GET("Fiscal Representative No.");
                    if rFiscalRep."TAX Registration No." <> '' then
                        "Customer Tax Registration No." := rFiscalRep."TAX Registration No.";
                    // <<DITW15.00.00.38 DDR 13/09/2010 #1217
                    if rFiscalRep."Tax Warehouse Reference" <> '' then
                        "Customer Tax Warehouse Ref." := rFiscalRep."Tax Warehouse Reference";
                    // >>DITW15.00.00.38 DDR
                    // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
                    if rFiscalRep."Tax Office Code" <> '' then
                        "Tax Office Code" := rFiscalRep."Tax Office Code";
                    // <<DITW15.00.00.38 DDR #1217 (DIT711 137)
                end else begin
                    GetCust("Sell-to Customer No.");
                    "Customer Tax Registration No." := Cust."Tax Registration No.";
                    // <<DITW15.00.00.38 DDR 13/09/2010 #1217
                    "Customer Tax Warehouse Ref." := Cust."Tax Warehouse Reference";
                    // >>DITW15.00.00.38 DDR
                    // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
                    "Tax Office Code" := Cust."Tax Office Code";
                    // <<DITW15.00.00.38 DDR #1217 (DIT711 137)
                    if CurrFieldNo <> FIELDNO("Fiscal Representative No.") then
                        "Fiscal Representative No." := Cust."Fiscal Representative No.";
                    if "Ship-to Code" <> '' then begin
                        ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code");
                        if ShipToAddr."Tax Registration No." <> '' then
                            "Customer Tax Registration No." := ShipToAddr."Tax Registration No.";
                        // <<DITW15.00.00.38 DDR 13/09/2010 #1217
                        if ShipToAddr."Tax Warehouse Reference" <> '' then
                            "Customer Tax Warehouse Ref." := ShipToAddr."Tax Warehouse Reference";
                        // >>DITW15.00.00.38 DDR
                        // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
                        if ShipToAddr."Tax Office Code" <> '' then
                            "Tax Office Code" := ShipToAddr."Tax Office Code";
                        // <<DITW15.00.00.38 DDR #1217 (DIT711 137)
                        // <<DITW16.00.00.40 DDR 24/01/2012 DIT-715 #203
                        //IF (ShipToAddr."Fiscal Representative No." <> '') AND
                        if (CurrFieldNo <> FIELDNO("Fiscal Representative No.")) then
                            "Fiscal Representative No." := ShipToAddr."Fiscal Representative No.";
                        // >>DITW16.00.00.40 DDR DIT-715 #203
                        // <<DITW15.00.00.39 DDR 06/07/2011 #1353
                        if FORMAT(ShipToAddr."Journey Time") <> '' then
                            "Journey Time" := ShipToAddr."Journey Time";
                        // >>DITW15.00.00.39 DDR #1353
                    end;
                end;
                // <<DITW15.00.00.34 DDR 09/07/2009
                TestMsgTaxRegistration();
                // >>DITW15.00.00.34 DDR
            end;
        }
        field(2013733; "Tax Date"; Date)
        {
            CaptionML = ENU = 'Tax Date',
                        FRA = 'Date taxe';
            Description = 'DITW15.00.00.39 #1363';

            trigger OnValidate();
            begin
                // <<DITW17.10.05 DDR 26/01/2015 DIT-770 #885
                SalesSetup.GET;
                // >>DITW17.10.05 DDR DIT-770 #885
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                if "Document Type" = "Document Type"::Order then
                    TestIfEmcsSalesLinesExist(FIELDCAPTION("Tax Date"));
                // >>DITW16.00.00.43 DDR DIT-715 #720
                // <<DITW16.00.00.42 DDR 01/03/2013 DIT-715 #572
                if ("Tax Date" = xRec."Tax Date") and ("Tax Date" = 0D) then begin
                    SalesLine.RESET;
                    SalesLine.SETRANGE("Item Charge Type", SalesLine."Item Charge Type"::Tax);
                    DeleteChargeSalesLines();
                    RecalcBackSalesLines();
                end else
                    // >>DITW16.00.00.42 DDR DIT-715 #572
                    // <<DITW15.00.00.39 DDR 19/08/2011 #1363
                    if ("Tax Date" <> xRec."Tax Date") and
                       (xRec."Sell-to Customer No." = "Sell-to Customer No.") and
                       // <<DITW17.10.05 DDR 01/10/2014 DIT-770 #885 - DDR 26/01/2015 DIT-770 #885
                       ((xRec."Shipment Date" = "Shipment Date") or (SalesSetup."Default Tax Date" = SalesSetup."Default Tax Date"::ShipRecvDate)) and
                       // >>DITW17.10.05 DDR DIT-770 #885
                       // <<DITW17.10.05 DDR 26/01/2015 DIT-770 #885
                       ((xRec."Order Date" = "Order Date") or (SalesSetup."Default Tax Date" = SalesSetup."Default Tax Date"::OrderDate)) and
                       // >>DITW17.10.05 DDR DIT-770 #885
                       // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
                       ((CurrFieldNo <> FIELDNO("Order Date")) and (CurrFieldNo <> FIELDNO("Shipment Date")))
                    // >>DITW18.00.07 DDR DIT-770 #1402
                    then
                        // <<DITW16.00.00.43 DDR 02/08/2013 DIT-715 #691
                        RecreateChargeSalesLines(FIELDCAPTION("Tax Date"));
                // >>DITW16.00.00.43 DDR DIT-715 #691
                // >>DITW15.00.00.39 DDR #1363
                // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
                SynchronizeAsmHeader(FIELDNO("Tax Date"));
                // >>DITW17.10.05 DDR DIT-770 #675
            end;
        }
        field(2013797; "Disc.Promo. Order Calculated"; Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"),
                                                    "Document No." = FIELD("No."),
                                                    "Disc.Promo. Order Calculated" = CONST(true)));
            CaptionML = ENU = 'Disc.Promo. Order Calculated',
                        FRA = 'Remise-Promotion cmde. calculé';
            Description = 'DITW15.00.00.24-.37';
            Editable = false;
            FieldClass = FlowField;
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
            Description = 'DITW15.00.00.35';
            OptionCaptionML = ENU = ' ,Price 0,Discount 100%',
                              FRA = ' ,Prix 0,Remise 100%';
            OptionMembers = " ",Price,Amount;
        }
        field(2013910; "Telesales Entry"; Integer)
        {
            CaptionML = ENU = 'Telesales Entry',
                        FRA = 'Ecriture Téléventes';
            Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
            TableRelation = "Telesales Entry"."Entry No.";
        }
        field(2013969; "Pos System-Created Entry"; Boolean)
        {
            CaptionML = ENU = 'POS System-Created Entry',
                        FRA = 'Ecriture système POS';
            Description = 'DITW15.00.00.39 #1328';
        }
        field(2014060; "Maximum Weight"; Decimal)
        {
            BlankZero = true;
            CaptionML = ENU = 'Maximum Weight',
                        FRA = 'Poids maximum';
            DecimalPlaces = 0 : 5;
            Description = 'DITW15.00.00.24';
            MinValue = 0;
        }
        field(2014061; "Maximum Cubage"; Decimal)
        {
            BlankZero = true;
            CaptionML = ENU = 'Maximum Volume (Cubage)',
                        FRA = 'Volume (Cubage) maximum';
            DecimalPlaces = 0 : 5;
            Description = 'DITW15.00.00.24';
            MinValue = 0;
        }
        field(2014062; "Shipment Date Formula"; DateFormula)
        {
            CaptionML = ENU = 'Shipment Date Formula',
                        FRA = 'Formule date d''expédition';
            Description = 'DITW17.00.02 DIT-770 #146';

            trigger OnValidate();
            var
                lblnExit: Boolean;
                lcuCalendarManagement: Codeunit "Calendar Management";
                ltxtDescription: Text[50];
                ldatTargetDate: Date;
                lrLocation: Record Location;
                liCounter: Integer;
                liTotalDays: Integer;
                loptSourceType: Option Company,Customer,Vendor,Location,"Shipping Agent",Service;
                ldatNewShipmentDate: Date;
            begin
                // <<DITW17.00.02 AT  06/06/2012 DIT-770 #146
                if FORMAT("Shipment Date Formula") <> '' then begin
                    // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
                    if "Location Code" <> '' then begin
                        lrLocation.GET("Location Code");
                        // >>DITW18.00.07 DDR DIT-770 #1488
                        if lrLocation."Base Calendar Code" <> '' then begin
                            CLEAR(lblnExit);
                            CLEAR(ldatTargetDate);
                            CLEAR(liTotalDays);
                            CLEAR(liCounter);

                            liTotalDays := CALCDATE("Shipment Date Formula", WORKDATE) - WORKDATE;

                            if liTotalDays > 0 then begin
                                while not lblnExit do begin
                                    if ldatTargetDate = 0D then
                                        ldatTargetDate := CALCDATE('<+1D>', WORKDATE)
                                    else
                                        ldatTargetDate := CALCDATE('<+1D>', ldatTargetDate);
                                    // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
                                    ldatNewShipmentDate := ldatTargetDate;
                                    // >>DITW18.00.07 DDR DIT-770 #1488

                                    if not lcuCalendarManagement.CheckCustomizedDateStatus(loptSourceType::Location,
                                                                                          lrLocation.Code, '', lrLocation."Base Calendar Code",
                                                                                          ldatTargetDate, ltxtDescription)
                                    then
                                        liCounter += 1;

                                    lblnExit := liCounter = liTotalDays;
                                end;
                                // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
                                if ldatNewShipmentDate <> "Shipment Date" then
                                    VALIDATE("Shipment Date", ldatNewShipmentDate);
                                // >>DITW18.00.07 DDR DIT-770 #1488
                                //<< DITW18.00.07 AKH 07/01/2016 DIT-770 #1381
                                fctFillDeliveryTimes("Sell-to Customer No.", "Ship-to Code", "Shipment Date");
                                //>> DITW18.00.07 AKH DIT-770 #1381
                            end else begin
                                ldatTargetDate := CALCDATE("Shipment Date Formula", WORKDATE);
                                // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
                                if ldatTargetDate <> "Shipment Date" then
                                    VALIDATE("Shipment Date", ldatTargetDate);
                                // >>DITW18.00.07 DDR DIT-770 #1488
                                //<< DITW18.00.07 AKH 07/01/2016 DIT-770 #1381
                                fctFillDeliveryTimes("Sell-to Customer No.", "Ship-to Code", "Shipment Date");
                                //>> DITW18.00.07 AKH DIT-770 #1381
                            end;
                        end else begin
                            ldatTargetDate := CALCDATE("Shipment Date Formula", WORKDATE);
                            // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
                            if ldatTargetDate <> "Shipment Date" then
                                VALIDATE("Shipment Date", ldatTargetDate);
                            // >>DITW18.00.07 DDR DIT-770 #1488
                            //<< DITW18.00.07 AKH 07/01/2016 DIT-770 #1381
                            fctFillDeliveryTimes("Sell-to Customer No.", "Ship-to Code", "Shipment Date");
                            //>> DITW18.00.07 AKH DIT-770 #1381
                        end;
                    end else begin
                        ldatTargetDate := CALCDATE("Shipment Date Formula", WORKDATE);
                        // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
                        if ldatTargetDate <> "Shipment Date" then
                            VALIDATE("Shipment Date", ldatTargetDate);
                        // >>DITW18.00.07 DDR DIT-770 #1488
                        //<< DITW18.00.07 AKH 07/01/2016 DIT-770 #1381
                        fctFillDeliveryTimes("Sell-to Customer No.", "Ship-to Code", "Shipment Date");
                        //>> DITW18.00.07 AKH DIT-770 #1381
                    end;
                end;
            end;
        }
        field(2014063; "Auto Create Shipping Cost"; Option)
        {
            CaptionML = ENU = 'Auto Create Shipping Cost On Source Doc.',
                        FRA = 'Création automatique des frais de livraison sur document d''origine';
            Description = 'DIT-770 #1066';
            OptionCaptionML = ENU = ' ,Never,Always',
                              FRA = ' ,Jamais,Toujours';
            OptionMembers = " ",Never,Always;
        }
        field(2014064; "Shipping Charge Per"; Option)
        {
            CaptionML = ENU = 'Shipping Charge Per',
                        FRA = 'Frais transport par';
            Description = 'DITW15.00.00.21';
            OptionCaptionML = ENU = 'Shipment,Weight,Volume',
                              FRA = 'Expédition,Poids,Volume';
            OptionMembers = Shipment,Weight,Volume;

            trigger OnValidate();
            begin
                // <<DITW15.00.00.24 DDR 14/08/2008
                //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
                TestOpenStatus;
                //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
                if xRec."Shipping Charge Per" <> "Shipping Charge Per" then
                    UpdateSalesLines(FIELDCAPTION("Shipping Charge Per"), CurrFieldNo <> 0);
                // >>DITW15.00.00.24 DDR
            end;
        }
        field(2014065; "Blanket Order Type"; Option)
        {
            Caption = 'Blanket Order Type';
            Description = 'DITW110.00.10 BL#15657';
            OptionCaption = '" ,Backorder,Pre Order"';
            OptionMembers = " ",Backorder,"Pre Order";
        }
        field(2014067; "Total Weight"; Decimal)
        {
            CalcFormula = Sum("Sales Line".Weight WHERE("Document Type" = FIELD("Document Type"),
                                                         "Document No." = FIELD("No."),
                                                         Type = CONST(Item),
                                                         "Location Code" = FIELD("Location Filter"),
                                                         "Outstanding Quantity" = FILTER(> 0)));
            CaptionML = ENU = 'Total Outstanding Weight',
                        FRA = 'Poids total';
            DecimalPlaces = 0 : 5;
            Description = 'DITW15.00.00.24';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014068; "Total Cubage"; Decimal)
        {
            CalcFormula = Sum("Sales Line".Cubage WHERE("Document Type" = FIELD("Document Type"),
                                                         "Document No." = FIELD("No."),
                                                         Type = CONST(Item),
                                                         "Location Code" = FIELD("Location Filter"),
                                                         "Outstanding Quantity" = FILTER(> 0)));
            CaptionML = ENU = 'Total Outstanding Volume (Cubage)',
                        FRA = 'Volume (Cubage) total';
            DecimalPlaces = 0 : 5;
            Description = 'DITW15.00.00.24';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014069; "Total Weight (Base)"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Weight (Base)" WHERE("Document Type" = FIELD("Document Type"),
                                                                  "Document No." = FIELD("No."),
                                                                  Type = CONST(Item),
                                                                  "Location Code" = FIELD("Location Filter")));
            CaptionML = ENU = 'Total Weight',
                        FRA = 'Poids total';
            DecimalPlaces = 0 : 5;
            Description = 'DIT-700 #664';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014070; "Total Cubage (Base)"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Cubage (Base)" WHERE("Document Type" = FIELD("Document Type"),
                                                                  "Document No." = FIELD("No."),
                                                                  Type = CONST(Item),
                                                                  "Location Code" = FIELD("Location Filter")));
            CaptionML = ENU = 'Total Volume (Cubage)',
                        FRA = 'Volume (Cubage) total';
            DecimalPlaces = 0 : 5;
            Description = 'DIT-700 #664';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014077; "Truck Code"; Code[10])
        {
            CaptionML = ENU = 'Truck Code',
                        FRA = 'Code camion';
            Description = 'DITW15.00.00.25 - DITW18.00.06 MSF 07/07/2015 DIT-770 #1212 #1213 #1214,HEI.33';
            TableRelation = "Whse. Shipping Truck";

            trigger OnLookup();
            begin
                //>> HEI.33 FDD-HT658 IBM.GUNERE01 10.09.2019
                FilterWhseShippingTrucks;
                //<< HEI.33 FDD-HT658 IBM.GUNERE01 10.09.2019
            end;

            trigger OnValidate();
            begin
                // <<DITW15.00.00.25 DDR 17/10/2008
                //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159 - DITW17.00.02 AT 20/12/2013 DIT-770 #289 - DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                TestOpenStatus;
                //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159 - DITW17.00.02 AT 20/12/2013 DIT-770 #289 - DITW18.00.07 DDR DIT-770 #1488
                // >>DITW15.00.00.25 DDR
                //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
                if "Multiple Order Route" then
                    if CurrFieldNo = FIELDNO("Truck Code") then
                        ERROR(Text2014062);
                //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
                // <<DITW18.00.07 DDR 25/02/2016 DIT-770 #1488
                TestRouteTypeVariable(FIELDNO("Truck Code"));
                // >>DITW18.00.07 DDR DIT-770 #1488
                //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                if (xRec."Truck Code" <> Rec."Truck Code") and ("Truck Code" <> '') and
                  ("Responsibility Center" <> '') then
                    UserSetupMgt.CheckTruck("Responsibility Center", "Truck Code");
                //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                if "Document Type" = "Document Type"::Order then
                    TestIfEmcsSalesLinesExist(FIELDCAPTION("Truck Code"));
                // >>DITW16.00.00.43 DDR DIT-715 #720
                // <<DITW15.00.00.26 DDR 17/11/2008 - DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                if xRec."Truck Code" <> "Truck Code" then begin
                    UpdateShippingMax();
                    // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Truck Code"));
                    // >>DITW18.00.07 DDR DIT-770 #1488
                    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
                    UpdateWhseRequestLines(FIELDCAPTION("Truck Code"))
                    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
                end;
                // >>DITW15.00.00.26 DDR - DITW18.00.07 DDR DIT-770 #1488
            end;
        }
        field(2014078; "Driver Code"; Code[10])
        {
            CaptionML = ENU = 'Driver Code',
                        FRA = 'Code chauffeur';
            Description = 'DITW15.00.00.25 - DITW18.00.06 MSF 07/07/2015 DIT-770 #1212 #1213 #1214,HEI.33';
            TableRelation = "Whse. Shipping Driver";

            trigger OnLookup();
            begin
                //>> HEI.33 FDD-HT658 IBM.GUNERE01 10.09.2019
                FilterWhseShippingDrivers;
                //<< HEI.33 FDD-HT658 IBM.GUNERE01 10.09.2019
            end;

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                TestOpenStatus;
                // >>DITW18.00.07 DDR DIT-770 #1488
                //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
                if "Multiple Order Route" then
                    if CurrFieldNo = FIELDNO("Driver Code") then
                        ERROR(Text2014062);
                //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
                // <<DITW18.00.07 DDR 25/02/2016 DIT-770 #1488
                TestRouteTypeVariable(FIELDNO("Driver Code"));
                // >>DITW18.00.07 DDR DIT-770 #1488
                // <<DITW15.00.00.25 DDR 17/10/2008
                //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                if (xRec."Driver Code" <> Rec."Driver Code") and ("Driver Code" <> '') and
                  ("Responsibility Center" <> '') then
                    UserSetupMgt.CheckDriver("Responsibility Center", "Driver Code");
                //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                // >>DITW15.00.00.25 DDR
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                if "Document Type" = "Document Type"::Order then
                    TestIfEmcsSalesLinesExist(FIELDCAPTION("Driver Code"));
                // >>DITW16.00.00.43 DDR DIT-715 #720
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                if xRec."Driver Code" <> "Driver Code" then begin
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Driver Code"));
                    // >>DITW18.00.07 DDR DIT-770 #1488
                    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
                    UpdateWhseRequestLines(FIELDCAPTION("Driver Code"))
                    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
                end;
            end;
        }
        field(2014079; "Shipment status"; Option)
        {
            CaptionML = ENU = 'Shipping Status',
                        FRA = 'Statut Expédition';
            Description = 'DITW16.00.00.43 DIT-715 #606/#154  -  DITW18.00.06 MSF 26/06/2015 DIT-770 #1347';
            OptionCaptionML = ENU = 'Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice',
                              FRA = 'Ouvert,Prélèvement imprimé,Affecté,Prélevé,Expédié,Retour terminée,Facturée';
            OptionMembers = Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;

            trigger OnValidate();
            begin
                // <<DITW19.00.08 DDR 12/08/2016 BL#10314
                if not ("Document Type" in ["Document Type"::Order, "Document Type"::"Return Order"]) then
                    FIELDERROR("Document Type");
                // >>DITW19.00.08 DDR BL#10314
                // <<DITW18.00.07 DDR 25/02/2016 DIT-770 #1488
                if xRec."Shipment status" <> "Shipment status" then begin
                    UpdateWhseRequestLines(FIELDCAPTION("Shipment status"));
                    //<< DITW18.00.07 AKH 07/01/2016 DIT-770 #1277 - DITW18.00.07 DDR 25/02/2016 DIT-770 #1488
                    UpdateSalesLines(FIELDCAPTION("Shipment status"), false);
                    //>> DITW18.00.07 AKH DIT-770 #1277 - DITW18.00.07 DDR DIT-770 #1488
                    // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Shipment status"));
                    // >>DITW18.00.07 DDR DIT-770 #1488
                end;
                // >>DITW18.00.07 DDR DIT-770 #1488

                ///<< DITW110.00.11 VSC 09/10/2017 NRQ#33755 - DITW110.00.10 SFI 20/06/2017 BL#15657
            end;
        }
        field(2014080; "Customer Delivery Type"; Code[10])
        {
            CaptionML = ENU = 'Customer Delivery Type',
                        FRA = 'Type Livraison Client';
            Description = 'DITW18.00.07 DIT-770 #1346';
            TableRelation = "Delivery Type".Code WHERE(Type = CONST(Customer));

            trigger OnValidate();
            begin
                // <<DITW19.00.08 DDR 12/08/2016 BL#10314
                if not ("Document Type" in ["Document Type"::Order, "Document Type"::"Return Order"]) and
                  not (SalesSetup."Shipment on Invoice" or SalesSetup."Return Receipt on Credit Memo")
                then
                    FIELDERROR("Document Type");
                // >>DITW19.00.08 DDR BL#10314
            end;
        }
        field(2014081; "Delivery Time (sec.)"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Delivery Time (sec.)" WHERE("Document Type" = FIELD("Document Type"),
                                                                         "Document No." = FIELD("No."),
                                                                         Type = CONST(Item)));
            CaptionML = ENU = 'Delivery Time (sec.)',
                        FRA = 'Temps de Livraison (Sec.)';
            Description = 'DITW18.00.07 DIT-770 #1346';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014082; "Total HL Cubage"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."HL Cubage" WHERE("Document Type" = FIELD("Document Type"),
                                                              "Document No." = FIELD("No."),
                                                              Type = CONST(Item),
                                                              "Location Code" = FIELD("Location Filter"),
                                                              "Outstanding Quantity" = FILTER(> 0)));
            CaptionClass = GetUomCaptionClassHL(FIELDNO("Total HL Cubage"));
            CaptionML = ENU = 'Total Outstanding Volume',
                        FRA = 'Volume total HL';
            DecimalPlaces = 0 : 5;
            Description = 'DITW17.00.02 DIT-770 #189 -  DIT-770 #354';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014083; "Total HL Cubage (Base)"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."HL Cubage (Base)" WHERE("Document Type" = FIELD("Document Type"),
                                                                     "Document No." = FIELD("No."),
                                                                     Type = CONST(Item),
                                                                     "Location Code" = FIELD("Location Filter")));
            CaptionClass = GetUomCaptionClassHL(FIELDNO("Total HL Cubage (Base)"));
            Caption = 'Total Volume';
            DecimalPlaces = 0 : 5;
            Description = 'DITW110.00.10 NRQ#16068';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014084; "Total Eq. UOM Quantity"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Eq. UOM Quantity" WHERE("Document Type" = FIELD("Document Type"),
                                                                     "Document No." = FIELD("No."),
                                                                     Type = CONST(Item),
                                                                     "Location Code" = FIELD("Location Filter"),
                                                                     "Outstanding Quantity" = FILTER(> 0)));
            CaptionClass = GetUomCaptionClassEqUom(FIELDNO("Total Eq. UOM Quantity"));
            CaptionML = ENU = 'Total Outstanding Eq. UOM Quantity',
                        FRA = 'Total Unité de mesure Eq.';
            DecimalPlaces = 0 : 5;
            Description = 'DITW17.00.02 DIT-770 #189 - DIT-770 #354 - DIT-770 #795';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014085; "Total Eq. UOM Quantity (Base)"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Eq. UOM Quantity (Base)" WHERE("Document Type" = FIELD("Document Type"),
                                                                            "Document No." = FIELD("No."),
                                                                            Type = CONST(Item),
                                                                            "Location Code" = FIELD("Location Filter")));
            CaptionClass = GetUomCaptionClassEqUom(FIELDNO("Total Eq. UOM Quantity (Base)"));
            Caption = 'Total Eq. UOM Quantity';
            DecimalPlaces = 0 : 5;
            Description = 'DITW110.00.10 NRQ#16068';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014087; Distance; Decimal)
        {
            CaptionML = ENU = 'Distance',
                        FRA = 'Distance';
            DecimalPlaces = 0 : 5;
            Description = 'DITW15.00.00.24';
            MinValue = 0;

            trigger OnValidate();
            begin
                // <<DITW15.00.00.24 DDR 14/08/2008
                //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159 - DITW17.00.02 AT 20/12/2013 DIT-770 #289 - DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                TestOpenStatus;
                //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159 - DITW17.00.02 AT 20/12/2013 DIT-770 #289 - DITW18.00.07 DDR DIT-770 #1488
                ///DITW110.00.11 MSF 21/09/2017 NRQ#16082-DITW110.00.11 MSF 30/11/2017 NRQ#16082
                WhseTransportMgt.UpdateSalesShippingDistances(Rec); //HEI.33 FDD-HT658 IBM.GUNERE01 06.09.2019
                if xRec.Distance <> Distance then begin
                    UpdateSalesLines(FIELDCAPTION(Distance), false);
                    // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                    UpdateRoutePlanRqstLines(FIELDCAPTION(Distance));
                    // >>DITW18.00.07 DDR DIT-770 #1488
                    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
                    UpdateWhseRequestLines(FIELDCAPTION(Distance));
                    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
                end;
            end;
        }
        field(2014093; "Order No."; Code[20])
        {
            CaptionML = ENU = 'Order No.',
                        FRA = 'N° commande';
            Description = 'DITW17.00.02 DIT-770 #338';
        }
        field(2014094; "Invoice Method"; Option)
        {
            CaptionML = ENU = 'Invoice Method',
                        FRA = 'Méthode de facturation';
            Description = 'DITW17.00.02 DIT-770 #154';
            OptionCaptionML = ENU = ' ,Shipment,Order,Combine Shipments,Combine Shipments Per Sell-to',
                              FRA = ' ,Expédition,Commande,Combiner expeditions,Combiner les expeditions par donneur d''ordre';
            OptionMembers = " ",Shipment,"Order","Combine Shipments","Combine Shipments Per Sell-to";

            trigger OnValidate();
            begin
                //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                VALIDATE("Invoice Period", "Invoice Period"::" ");
                // >>DITW18.00.07 DDR DIT-770 #1488
                if ("Invoice Method" = "Invoice Method"::" ") or
                  ("Invoice Method" = "Invoice Method"::Shipment) or
                  ("Invoice Method" = "Invoice Method"::Order) then
                    "Combine Shipments" := false
                else if ("Invoice Method" = "Invoice Method"::"Combine Shipments") or
                  ("Invoice Method" = "Invoice Method"::"Combine Shipments Per Sell-to") then
                    "Combine Shipments" := true;
                //>>DITW17.00.02 TEC1 DIT-770 #154

                //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
                if "Sundry Customer" and ("Invoice Method" in ["Invoice Method"::"Combine Shipments", "Invoice Method"::"Combine Shipments Per Sell-to"]) then
                    VALIDATE("Invoice Period", "Invoice Period"::Order);
                //>> DITW18.00.07 AKH DIT-770 #1804
            end;
        }
        field(2014095; "Invoice Period"; Option)
        {
            CaptionML = ENU = 'Invoice Period',
                        FRA = 'Période de facturation';
            Description = 'DITW17.00.02 DIT-770 #154, #338 - DIT-770 #1051';
            OptionCaptionML = ENU = ' ,Direct Delivery,Order,Event,Daily,Weekly,Half Montly,Montly,10 Days',
                              FRA = ' ,Livraison directe,Ordre,Événement,Quotidienne,Hebdomadaire,Demi-Mensuelle,Mensuelle,10 Jours';
            OptionMembers = " ","Direct Delivery","Order","Order Manually",Daily,Weekly,"Half Montly",Montly,"10 Days";

            trigger OnValidate();
            begin
                //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
                if "Sundry Customer" and ("Invoice Method" in ["Invoice Method"::"Combine Shipments", "Invoice Method"::"Combine Shipments Per Sell-to"]) then
                    if "Invoice Period" <> "Invoice Period"::Order then
                        FIELDERROR("Invoice Period");
                //>> DITW18.00.07 AKH DIT-770 #1804
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                if xRec."Invoice Period" <> "Invoice Period" then
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Invoice Period"));
                // >>DITW18.00.07 DDR DIT-770 #1488
            end;
        }
        field(2014096; "Picking Type"; Option)
        {
            CaptionML = ENU = 'Picking Type',
                        FRA = 'Type de prélèvement';
            Description = 'DITW17.00.02 DIT-770 #154';
            OptionCaptionML = ENU = ' ,Order,Combined',
                              FRA = ' ,Commande,Regroupée';
            OptionMembers = " ","Order",Combined;

            trigger OnValidate();
            begin
                //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
                //<<DITW17.00.02 AT 20/12/2013 DIT-770 #289 - DITW17.00.02 SR 10/25/2013 DIT-770 #159
                TestOpenStatus;
                //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159 - DITW17.00.02 AT 20/12/2013 DIT-770 #289
                if xRec."Picking Type" <> "Picking Type" then begin
                    // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
                    UpdateSalesLines(FIELDCAPTION("Picking Type"), (CurrFieldNo <> 0) and ("Route Planning No." = ''));
                    // >>DITW18.00.07 DDR DIT-770 #1488
                    // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Picking Type"));
                    // >>DITW18.00.07 DDR DIT-770 #1488
                end;
                //>>DITW17.00.02 TEC1 DIT-770 #154
            end;
        }
        field(2014097; "Truck Zone"; Option)
        {
            CaptionML = ENU = 'Truck Zone',
                        FRA = 'Zone de camion';
            Description = 'DITW17.00.02 DIT-770 #154';
            OptionCaptionML = ENU = ' ,Right,Left',
                              FRA = ' ,Droite,Gauche';
            OptionMembers = " ",Right,Left;

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                TestOpenStatus;
                // >>DITW18.00.07 DDR DIT-770 #1488
                //<<DITW17.00.02 AT 20/12/2013 DIT-770 #289
                if xRec."Truck Zone" <> "Truck Zone" then begin
                    UpdateSalesLines(FIELDCAPTION("Truck Zone"), false);
                    // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Truck Zone"));
                    // >>DITW18.00.07 DDR DIT-770 #1488
                end;
                //>>DITW17.00.02 AT 20/12/2013 DIT-770 #289
            end;
        }
        field(2014098; "Require 2 Drivers"; Boolean)
        {
            CaptionML = ENU = 'Require 2 Drivers',
                        FRA = 'Demande 2 chauffeurs';
            Description = 'DITW17.00.02 DIT-770 #154';

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                if xRec."Require 2 Drivers" <> "Require 2 Drivers" then
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Require 2 Drivers"));
                // >>DITW18.00.07 DDR DIT-770 #1488
            end;
        }
        field(2014099; "Driver 2 Code"; Code[10])
        {
            CaptionML = ENU = 'Driver 2 Code',
                        FRA = 'Code Chauffeur 2';
            Description = 'DITW17.00.02 DIT-770 #154 - DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214';
            TableRelation = IF ("Responsibility Center" = CONST('')) "Whse. Shipping Driver".Code WHERE("Responsibility Center" = FIELD("Resp. Center Table Filter"))
            ELSE IF ("Responsibility Center" = FILTER(<> '')) "Whse. Shipping Driver".Code WHERE("Responsibility Center" = FIELD("Resp. Center Table Filter 2"));

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 25/02/2016 DIT-770 #1488
                TestOpenStatus;
                //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
                if "Multiple Order Route" then
                    if CurrFieldNo = FIELDNO("Driver 2 Code") then
                        ERROR(Text2014062);
                //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
                TestRouteTypeVariable(FIELDNO("Driver 2 Code"));
                // >>DITW18.00.07 DDR DIT-770 #1488
                // <<DITW15.00.00.25 DDR 17/10/2008
                //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                if (xRec."Driver 2 Code" <> Rec."Driver 2 Code") and ("Driver 2 Code" <> '') and
                  ("Responsibility Center" <> '') then
                    UserSetupMgt.CheckDriver("Responsibility Center", "Driver 2 Code");
                //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                if xRec."Driver 2 Code" <> "Driver 2 Code" then begin
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Driver 2 Code"));
                    // >>DITW18.00.07 DDR DIT-770 #1488
                    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
                    UpdateWhseRequestLines(FIELDCAPTION("Driver 2 Code"));
                    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
                end;
            end;
        }
        field(2014100; "Trailer Code"; Code[10])
        {
            CaptionML = ENU = 'Trailer Code',
                        FRA = 'Code Remorque';
            Description = 'DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 - DITW18.00.06 MSF 07/07/2015 DIT-770 #1212 #1213 #1214';
            TableRelation = IF ("Responsibility Center" = CONST('')) "Whse. Shipping Truck".Code WHERE("Responsibility Center" = FIELD("Resp. Center Table Filter"),
                                                                                                      "Transport Unit Type" = CONST(Trailer))
            ELSE IF ("Responsibility Center" = FILTER(<> '')) "Whse. Shipping Truck".Code WHERE("Responsibility Center" = FIELD("Resp. Center Table Filter 2"),
                                                                                                                                                                                        "Transport Unit Type" = CONST(Trailer));

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 25/02/2016 DIT-770 #1488
                TestOpenStatus;
                //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
                if "Multiple Order Route" then
                    if CurrFieldNo = FIELDNO("Trailer Code") then
                        ERROR(Text2014062);
                //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
                TestRouteTypeVariable(FIELDNO("Trailer Code"));
                // >>DITW18.00.07 DDR DIT-770 #1488
                //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                if (xRec."Trailer Code" <> Rec."Trailer Code") and ("Trailer Code" <> '') and
                  ("Responsibility Center" <> '') then
                    UserSetupMgt.CheckTrailer("Responsibility Center", "Trailer Code");
                //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214

                // <<DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 - DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                if xRec."Trailer Code" <> "Trailer Code" then begin
                    UpdateShippingMax();
                    // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Trailer Code"));
                    // >>DITW18.00.07 DDR DIT-770 #1488
                    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
                    UpdateWhseRequestLines(FIELDCAPTION("Trailer Code"));
                    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
                end;
                // >>DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 - DITW18.00.07 DDR DIT-770 #1488
            end;
        }
        field(2014101; "Ship-to Address Key No."; Code[20])
        {
            CaptionML = ENU = 'Ship-to Address Key No.',
                        FRA = 'N° clé adresse destinataire';
            Description = 'DITW17.00.02 DIT-770 #154';
        }
        field(2014102; "Delivery Order"; Code[20])
        {
            CaptionML = ENU = 'Delivery Order',
                        FRA = 'Commande de livraison';
            Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230';
        }
        field(2014103; "Whse. Shipment No. (First)"; Code[20])
        {
            CalcFormula = Min("Warehouse Shipment Line"."No." WHERE("Source Type" = CONST(37),
                                                                     "Source Subtype" = CONST("1"),
                                                                     "Source No." = FIELD("No.")));
            CaptionML = ENU = 'Whse. Shipment No. (First)',
                        FRA = 'N° expédition magasin (Premier)';
            Description = 'DITW15.00.00.39 #1399';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Warehouse Shipment Header";
        }
        field(2014104; "Whse. Shipment Status (First)"; Option)
        {
            CalcFormula = Lookup("Warehouse Shipment Header".Status WHERE("No." = FIELD("Whse. Shipment No. (First)")));
            CaptionML = ENU = 'Whse. Shipment Status (First)',
                        FRA = 'Status expédition magasin (Premier)';
            Description = 'DITW15.00.00.39 #1399';
            Editable = false;
            FieldClass = FlowField;
            OptionCaptionML = ENU = 'Open,Released,Pending Pick,Pending Shipping',
                              FRA = 'Ouvert,Lancé,Prélèvement suspendue,Livraison suspendue';
            OptionMembers = Open,Released,"Pending Pick","Pending Ship";
        }
        field(2014105; "Suggested Return Item"; Boolean)
        {
            Caption = 'Suggested Return Item';
            Description = '-NRQ#16224';
            Editable = true;
        }
        field(2014107; Route; Code[20])
        {
            CaptionML = ENU = 'Route',
                        FRA = 'Itinéraire';
            Description = 'DITW16.00.00.40 #1002 - DITW19.00.08 BL#11231';
            TableRelation = Route WHERE("Responsibility Center" = FIELD("Resp. Center Table Filter"));

            trigger OnValidate();
            var
                lrRoute: Record Route;
                lrxRoute: Record Route;
            begin
                // <<DITW19.00.08 DDR 12/08/2016 BL#10314
                if not ("Document Type" in ["Document Type"::Order, "Document Type"::"Return Order"]) then
                    FIELDERROR("Document Type");
                // >>DITW19.00.08 DDR BL#10314
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                TestOpenStatus;
                //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
                if CheckExistWarehouseLine then
                    ERROR(STRSUBSTNO(Text2014061, "Document Type", "No."));
                //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
                if xRec.Route <> Route then begin
                    // >>DITW18.00.07 DDR DIT-770 #1488
                    if Route <> '' then begin
                        // >>DITW18.00.07 DDR DIT-770 #1488
                        //<<DITW17.10.05 WSA 03/11/2014 DIT-770 #892
                        if lrxRoute.GET(xRec.Route) then;
                        //>>DITW17.10.05 WSA 03/11/2014 DIT-770 #892
                        lrRoute.GET(Route);
                        //<<DITW17.10.05 WSA 03/11/2014 DIT-770 #892 - DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                        if (lrRoute."Shipment Day" <> lrRoute."Shipment Day"::" ") and
                          (lrRoute."Shipment Day" <> lrxRoute."Shipment Day") and
                          ("Order Date" <> 0D)
                        then begin
                            //>>DITW17.10.05 WSA 03/11/2014 DIT-770 #892 - DITW18.00.07 DDR DIT-770 #1488
                            // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                            VALIDATE("Shipment Date", lrRoute.GetShipmentDate("Order Date"));
                            VALIDATE("Posting Date", "Shipment Date");
                            // >>DITW18.00.07 DDR DIT-770 #1488
                        end;

                        //<< DITW18.00.07 VSC 10/03/2016 DIT-770 #1066
                        //<< DITW18.00.07 VSC 08/04/2016 DIT-770 #1066
                        if lrRoute."Auto Create Shipping Cost" <> lrRoute."Auto Create Shipping Cost"::" " then
                            "Auto Create Shipping Cost" := lrRoute."Auto Create Shipping Cost";
                        //>> DITW18.00.07 VSC DIT-770 #1066
                        if Location.GET(lrRoute."Location Code") then
                            "Auto Create Shipping Cost" := Location."Auto Create Shipping Cost";
                        //>> DITW18.00.07 VSC DIT-770 #1066

                        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                        if lrRoute."Shipment Method Code" <> '' then
                            VALIDATE("Shipment Method Code", lrRoute."Shipment Method Code");
                        // >>DITW18.00.07 DDR DIT-770 #1488

                        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                        if lrRoute."Shipping Agent Code" <> '' then begin
                            VALIDATE("Shipping Agent Code", lrRoute."Shipping Agent Code");
                            // <<DITW19.00.08 DDR 01/12/2016 BL#10314
                            if xRec."Shipping Agent Code" = "Shipping Agent Code" then
                                UpdateSalesLines(FIELDCAPTION("Shipping Agent Code"), false);
                            // >>DITW19.00.08 DDR BL#10314
                        end;
                        // >>DITW18.00.07 DDR DIT-770 #1488
                        if lrRoute."Shipping Agent Service Code" <> '' then
                            VALIDATE("Shipping Agent Service Code", lrRoute."Shipping Agent Service Code");

                        // <<DITW18.00.07 DDR 25/02/2016 DIT-770 #1488
                        //<<DITW18.00.06 MSF 16/06/2015 DIT-770 #1212 #1213 #1214
                        // <<DITW18.00.06 MSF 18/08/2015 DIT-770 #1534
                        if lrRoute."Location Code" <> '' then begin
                            // >>DITW18.00.06 MSF 18/08/2015 DIT-770 #1534
                            //<<NRQ#411703 DDR 18/06/2025
                            SETRANGE("Phys. Location Table Filter");
                            SETRANGE("Location Table Filter");
                            //>>NRQ#411703 DDR 18/06/2025
                            // <<DITW18.00.07 DDR 25/02/2016 DIT-770 #1488
                            "Physical Location Group Code" := '';
                            // >>DITW18.00.07 DDR DIT-770 #1488
                            VALIDATE("Location Code", lrRoute."Location Code");
                        end;
                        //<< DITW19.00.08 AKH 20/09/2016 BL#10756
                        if lrRoute."Return Location Code" <> '' then
                            VALIDATE("Return Location Code", lrRoute."Return Location Code");
                        //>> DITW19.00.08 AKH BL#10756

                        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                        if lrRoute."Physical Location Group Code" <> '' then
                            VALIDATE("Physical Location Group Code", lrRoute."Physical Location Group Code");
                        //IF lrRoute."Responsibility Center" <> '' THEN
                        //  VALIDATE("Responsibility Center",lrRoute."Responsibility Center");
                        // >>DITW18.00.07 DDR DIT-770 #1488
                        //<<DITW18.00.06 MSF 26/06/2015 DIT-770 #1347
                        if lrRoute."Driver Code" <> '' then
                            VALIDATE("Driver Code", lrRoute."Driver Code");
                        if lrRoute."Trailer Code" <> '' then
                            VALIDATE("Trailer Code", lrRoute."Trailer Code");
                        if lrRoute."Driver Code 2" <> '' then
                            VALIDATE("Driver 2 Code", lrRoute."Driver Code 2");
                        if lrRoute."Truck Code" <> '' then
                            VALIDATE("Truck Code", lrRoute."Truck Code");
                        //>>DITW18.00.06 MSF 26/06/2015 DIT-770 #1347
                        // >>DITW18.00.07 DDR DIT-770 #1488
                        //>> HEI.33 FDD-HT658 IBM.GUNERE01 09.09.2019
                        GetCust("Sell-to Customer No.");
                        //IF Distance <> Cust.Distance THEN
                        if (Distance <> Cust.Distance) or (Distance = 0) then  //HEI.62
                            if lrRoute.Distance <> 0 then
                                VALIDATE(Distance, lrRoute.Distance);
                        //<< HEI.33 FDD-HT658 IBM.GUNERE01 09.09.2019
                        // <<DITW18.00.07 DDR 30/05/2016 DIT-770 #642
                        if (xRec."Location Code" <> "Location Code") or
                          (xRec."Shipping Agent Service Code" <> "Shipping Agent Service Code")
                        then
                            // >>DITW18.00.07 DDR DIT-770 #642
                            //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
                            //<< DITW18.00.07 VSC 04/07/2016 DIT-770 #1066
                            CreateShippingCost(Rec, false, false);
                        //>> HEI.33 FDD-HT658 IBM.GUNERE01 16.09.2019
                        if xRec.Route <> Rec.Route then
                            WhseTransportMgt.UpdateSalesShippingRoutes(Rec);
                        //<< HEI.33 FDD-HT658 IBM.GUNERE01 16.09.2019
                        //>> DITW18.00.07 VSC DIT-770 #1066
                        //>> DITW18.00.07 VSC DIT-770 #1066
                        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
                        "Multiple Order Route" := lrRoute."Multiple Order Route";
                        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
                    end else begin
                        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
                        "Multiple Order Route" := false;
                        //>> HEI.33 FDD-HT658 IBM.GUNERE01 16.09.2019
                        if xRec.Route <> Rec.Route then
                            WhseTransportMgt.UpdateSalesShippingRoutes(Rec);
                        //<< HEI.33 FDD-HT658 IBM.GUNERE01 16.09.2019
                        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
                        // <<DITW18.00.07 DDR 25/02/2016 DIT-770 #1488
                        DeleteRoutePlanRqstLine();
                        if "Shipping Agent Service Code" <> '' then
                            VALIDATE("Shipping Agent Service Code");
                        // >>DITW18.00.07 DDR DIT-770 #1488
                    end;
                    //>>DITW17.00.02 TEC1 DIT-770 #154

                    //<<DITW17.00.02 AT 20/12/2013 DIT-770 #289
                    //<<DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
                    UpdatefromCustrespcenterrelation;
                    //>>DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
                    UpdateSalesLines(FIELDCAPTION(Route), false);
                    //>>DITW17.00.02 AT 20/12/2013 DIT-770 #289
                    // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                    UpdateRoutePlanRqstLines(FIELDCAPTION(Route));
                    // >>DITW18.00.07 DDR DIT-770 #1488
                    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
                    UpdateWhseRequestLines(FIELDCAPTION(Route));
                    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
                end;

                //<< DITW18.00.07 VSC 01/07/2016 DIT-770 #1282
                CheckLatestOrderDateTime(FIELDNO(Route));
                //>> DITW18.00.07 VSC DIT-770 #1282

                // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1109
                ClearHasBeenShowAll2(FIELDNO(Route));
                // >>DITW18.00.07 DDR DIT-770 #1109
                //HEI.16>>
                if "Document Type" = "Document Type"::Order then begin
                    if RecRoute.GET(Route) then begin
                        if ShippingAgent.GET(RecRoute."Shipping Agent Code") then begin
                            //HEI.27>>
                            //IF ShippingAgent."Vendor No." = '' THEN
                            if (ShippingAgent."Vendor No." = '') and (not ShippingAgent."Own Logistics") then
                                //HEI.27<<
                                ERROR(ShippingAgentVendorIsBlank)
                            else if Vend.GET(ShippingAgent."Vendor No.") then begin
                                if Vend.Blocked <> 0 then
                                    ERROR(VendorBlockForShipAgent);
                            end;
                        end;
                    end;
                end;
                //HEI.16<<
            end;
        }
        field(2014108; "Multiple Order Route"; Boolean)
        {
            Caption = 'Multiple Order Route';
            Description = 'NRQ#16082';
            TableRelation = Route;
        }
        field(2014109; "Route Planning No."; Code[20])
        {
            CaptionML = ENU = 'Route Planning No.',
                        FRA = 'N° Planning Itinéraire';
            Description = 'DITW18.00.07 #1488';
            TableRelation = "Route Planning Worksheet";

            trigger OnValidate();
            begin
                //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
                if CheckExistWarehouseLine then
                    ERROR(STRSUBSTNO(Text2014061, "Document Type", "No."));
                UpdateWhseRequestLines(FIELDCAPTION("Route Planning No."));
                //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
            end;
        }
        field(2014110; "Delivery Time 1 From"; Time)
        {
            CaptionML = ENU = 'Delivery Time 1 From',
                        FRA = 'Heure de livraison 1 de';
            Description = 'DITW17.00.02 DIT-770 #154';

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                if xRec."Delivery Time 1 From" <> "Delivery Time 1 From" then
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Delivery Time 1 From"));
                // >>DITW18.00.07 DDR DIT-770 #1488
            end;
        }
        field(2014111; "Delivery Time 1 To"; Time)
        {
            CaptionML = ENU = 'Delivery Time 1 To',
                        FRA = 'Heure de livraison 1 à';
            Description = 'DITW17.00.02 DIT-770 #154';

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                if xRec."Delivery Time 1 To" <> "Delivery Time 1 To" then
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Delivery Time 1 To"));
                // >>DITW18.00.07 DDR DIT-770 #1488
            end;
        }
        field(2014112; "Delivery Time 2 From"; Time)
        {
            CaptionML = ENU = 'Delivery Time 2 From',
                        FRA = 'Heure de livraison 2 de';
            Description = 'DITW17.00.02 DIT-770 #154';

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                if xRec."Delivery Time 2 From" <> "Delivery Time 2 From" then
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Delivery Time 2 From"));
                // >>DITW18.00.07 DDR DIT-770 #1488
            end;
        }
        field(2014113; "Delivery Time 2 To"; Time)
        {
            CaptionML = ENU = 'Delivery Time 2 To',
                        FRA = 'Heure de livraison 2 à';
            Description = 'DITW17.00.02 DIT-770 #154';

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                if xRec."Delivery Time 2 To" <> "Delivery Time 2 To" then
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Delivery Time 2 To"));
                // >>DITW18.00.07 DDR DIT-770 #1488
            end;
        }
        field(2014114; "Receipt Status"; Option)
        {
            CaptionML = ENU = 'Receipt Status',
                        FRA = 'Satut Recéption';
            Description = 'DITW18.00.07 DIT-770 #1968';
            OptionCaptionML = ENU = 'Open,Order Printed,Order Sent,Order Confirmed,To Receive,Receipt Completed,Invoice',
                              FRA = 'Ouvert,Commande Imprimée,Commande Envoyée,Commande Confirmée,A réceptionner,Réception Complete,Facturée';
            OptionMembers = Open,"Order Printed","Order Sent","Order Confirmed","To Receive","Receipt Completed",Invoice;

            trigger OnValidate();
            begin
                //<< DITW18.00.07 VSC 24/04/2016 DIT-770 #1984
                if xRec."Receipt Status" <> "Receipt Status" then begin
                    UpdateSalesLines(FIELDCAPTION("Receipt Status"), false);
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Receipt Status"));
                end;
                //>> DITW18.00.07 VSC DIT-770 #1984
            end;
        }
        field(2014115; "Latest Order Date/Time"; DateTime)
        {
            CaptionML = ENU = 'Latest Order Date/Time',
                        FRA = 'Derniére Date/ Heure de Commande';
            Description = 'DITW18.00.07 DIT-770 #1282';
            Editable = false;
        }
        field(2014271; "Customer Tax Warehouse Ref."; Text[20])
        {
            CaptionML = ENU = 'Customer Tax Warehouse Reference',
                        FRA = 'Entrepôt fiscal de référence client';
            Description = 'DITW15.00.00.38 #1217';

            trigger OnValidate();
            begin
                //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
                TestOpenStatus;
                //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                if "Document Type" = "Document Type"::Order then
                    TestIfEmcsSalesLinesExist(FIELDCAPTION("Customer Tax Warehouse Ref."));
                // >>DITW16.00.00.43 DDR DIT-715 #720
            end;
        }
        field(2014277; "Transport Mode"; Option)
        {
            CalcFormula = Lookup("Transport Method"."Transport Mode" WHERE(Code = FIELD("Transport Method")));
            CaptionML = ENU = 'Transport Mode (EMCS)',
                        FRA = 'Mode de transport (EMCS)';
            Description = 'DITW16.00.00.40 DIT715 #187';
            Editable = false;
            FieldClass = FlowField;
            OptionCaptionML = ENU = 'Other,Sea,Rail,Road,Air,Post,N/A,Fixed,Waterway',
                              FRA = 'Autre,Mer,Chemin de fer,Route,Air,Poste,N/C,Installation de transport fixes,Transport par voies navigables';
            OptionMembers = Other,Sea,Rail,Road,Air,Post,"N/A","Fixed",Waterway;

            trigger OnValidate();
            begin
                //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
                TestOpenStatus;
                //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                if "Document Type" = "Document Type"::Order then
                    TestIfEmcsSalesLinesExist(FIELDCAPTION("Transport Mode"));
                // >>DITW16.00.00.43 DDR DIT-715 #720
            end;
        }
        field(2014290; "Journey Time"; DateFormula)
        {
            CaptionML = ENU = 'Journey Time (EMCS)',
                        FRA = 'Temps de trajet (EMCS)';
            Description = 'DITW15.00.00.39 #1353';

            trigger OnValidate();
            begin
                //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
                TestOpenStatus;
                //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                if "Document Type" = "Document Type"::Order then
                    TestIfEmcsSalesLinesExist(FIELDCAPTION("Journey Time"));
                // >>DITW16.00.00.43 DDR DIT-715 #720
            end;
        }
        field(2014291; "Transport Mode Comment"; Boolean)
        {
            CalcFormula = Exist("EMCS Comment Line" WHERE("Table ID" = CONST(36),
                                                           "Document Type" = CONST(1),
                                                           "Document No." = FIELD("No."),
                                                           "Document Line No." = CONST(0),
                                                           "Field ID" = CONST(2014277)));
            CaptionML = ENU = 'Transport Mode Comment',
                        FRA = 'Commentaires Mode de transport';
            Description = 'DITW16.00.00.40 DIT715 #187';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014300; "Submission Type"; Option)
        {
            CaptionML = ENU = 'Submission Type  (EMCS)',
                        FRA = 'Type de Message (EMCS)';
            Description = 'DITW18.00.07 DIT-770 #1397';
            OptionCaptionML = ENU = ' ,Type 1,Type 2',
                              FRA = ' ,Type 1,Type 2';
            OptionMembers = " ","Type 1","Type 2";

            trigger OnValidate();
            begin
                // <<DITW18.00.07 MVN 07/04/2016 DIT-770 #1397
                if ApplMgt.IsObjectLicense(5, CODEUNIT::"EMCS EDI Mgt", 4) <> 0 then
                    // >>DITW18.00.07 MVN DIT-770 #1397
                    // <<DITW18.00.07 MVN 21/01/2016 DIT-770 #1397
                    "Submission Type" := EMCSEDIMgt.CheckSubmissionType(1, "Customer DTax Group Code", "Location Code", "Submission Type");
                // >>DITW18.00.07 MVN DIT-770 #1397
            end;
        }
        field(2014310; "Payment Amount"; Decimal)
        {
            CaptionML = ENU = 'Payment Amount',
                        FRA = 'Montant règlement';
            Description = 'DITW17.00.02 DIT-770 #135';

            trigger OnValidate();
            begin
                //<<DITW17.00.02 SR 09/09/2013 DIT-770 #135
                if "Payment Amount" <> 0 then begin
                    if "Bal. Account No." = '' then begin
                        TESTFIELD("Applies-to Doc. No.");
                        TESTFIELD("DIT Sub-Contract Type");
                    end;
                end;
                //>>DITW17.00.02 SR DIT-770 #135
            end;
        }
        field(2014313; "Financial Contract No."; Code[20])
        {
            CaptionML = ENU = 'Financial Contract No.',
                        FRA = 'N° Contrat Financier';
            Description = 'DITW18.00.06 DIT-770 #1368';
            TableRelation = IF ("DIT Sub-Contract Type" = CONST(" ")) "Financial Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract))
            ELSE IF ("DIT Sub-Contract Type" = FILTER(<> " ")) "Financial Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract),
                                                                                                                              "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));

            trigger OnValidate();
            begin
                //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                TestOpenStatus;
                if "Financial Contract No." <> '' then begin
                    //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                    "Contract Type" := "Contract Type"::Financial;
                    TESTFIELD("Service Contract No.", '');
                    //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                    if ("Financial Contract No." <> xRec."Financial Contract No.") and
                       (xRec."Sell-to Customer No." = "Sell-to Customer No.")
                    then
                        MessageIfSalesLinesExist(FIELDCAPTION("Financial Contract No."));

                    if (CurrFieldNo = FIELDNO("Financial Contract No.")) and
                      (xRec."Financial Contract No." <> "Financial Contract No.")
                    then begin
                        "Contract Group Code" := '';
                    end;

                    ContractDIT.GET(ContractDIT."Contract Type"::Contract, "Financial Contract No.");
                    if SalesHeader."Building No." <> '' then
                        ContractDIT.TESTFIELD("Building No.", SalesHeader."Building No.");
                    if ("DIT Sub-Contract Type" <> 0) or
                      ((xRec."DIT Sub-Contract Type" <> 0) and ("DIT Sub-Contract Type" = 0) and
                      (xRec."Financial Contract No." = "Financial Contract No."))
                    then
                        TESTFIELD("DIT Sub-Contract Type", ContractDIT."DIT Sub-Contract Type")
                    else
                        "DIT Sub-Contract Type" := ContractDIT."DIT Sub-Contract Type";
                    if ("Contract Group Code" <> '') or
                      ((xRec."Contract Group Code" <> '') and ("Contract Group Code" = '') and
                      (xRec."Financial Contract No." = "Financial Contract No."))
                    then
                        TESTFIELD("Contract Group Code", ContractDIT."Contract Group Code")
                    else
                        "Contract Group Code" := ContractDIT."Contract Group Code";
                    if ("Building No." <> '') or
                      ((xRec."Building No." <> '') and ("Building No." = '') and
                      (xRec."Financial Contract No." = "Financial Contract No."))
                    then
                        TESTFIELD("Building No.", ContractDIT."Building No.");
                end else
                    //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                    "Contract Type" := "Contract Type"::" ";
                //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368

                if ("Financial Contract No." <> '') or ("Contract Group Code" <> '') or ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") then begin
                    GetCust("Sell-to Customer No.");
                    "Customer Posting Group" := ServPostJnl.GetSourcePostGroupService(Cust."No.", "DIT Sub-Contract Type");
                end;

                // <<DITW19.00.07 MVN 14/03/2016 DIT-770 #1390
                CreateDim(
                  DimMgt.TypeToTableID2034932(1, "Contract Type"), "Financial Contract No.",
                  DATABASE::Building, "Building No.",
                  DATABASE::Customer, GetCustNoCalcDim(),
                  DATABASE::"Salesperson/Purchaser", "Salesperson Code",
                  DATABASE::Campaign, "Campaign No.",
                  DATABASE::"Responsibility Center", "Responsibility Center",
                  DATABASE::"Customer Template", "Bill-to Customer Template Code");
                // >>DITW19.00.07 MVN DIT-770 #1390
            end;
        }
        field(2014360; "Return Date"; Date)
        {
            CaptionML = ENU = 'Return Date',
                        FRA = 'Date Retour';
            Description = 'DITW17.00.02 DIT-770 #148';

            trigger OnValidate();
            begin
                //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #148
                UpdateSalesLines(FIELDCAPTION("Return Date"), CurrFieldNo <> 0);
                //>>DITW17.00.02 TEC1 DIT-770 #148
            end;
        }
        field(2014361; "Event No."; Code[20])
        {
            CaptionML = ENU = 'Event No.',
                        FRA = 'N° évènement';
            Description = 'DITW17.10.05 DIT-770 #779';
            Editable = false;
            TableRelation = "Event Header"."No." WHERE("Document Type" = CONST(Event));
        }
        field(2014362; "Event Status"; Option)
        {
            CaptionML = ENU = 'Event Status',
                        FRA = 'Statut évènement';
            Description = 'DITW17.10.05 DIT-770 #779';
            Editable = false;
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
            Editable = false;
        }
        field(2014410; "Physical Location Group Code"; Code[10])
        {
            CaptionML = ENU = 'Physical Location Group Code',
                        FRA = 'Code groupe magasin réel';
            Description = 'DITW18.00.06 DIT-770 #1190';
            TableRelation = "Physical Location Group" WHERE(Code = FIELD("Phys. Location Table Filter"));

            trigger OnValidate();
            var
                PhysLocationGr: Record "Physical Location Group";
                AskConfirm: Boolean;
                ResponsibilityCenter: Integer;
            begin
                // <<DITW18.00.06 DDR 19/02/2015 DIT-770 #1190
                TestOpenStatus;

                // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1190
                if ("Responsibility Center" = xRec."Responsibility Center") and
                  ("Physical Location Group Code" <> xRec."Physical Location Group Code") and
                  ("Physical Location Group Code" <> '')
                then
                    VALIDATE("Responsibility Center", UserSetupMgt.GetFirstRespCenter(0, "Physical Location Group Code", ''));
                // >>DITW18.00.06 DDR DIT-770 #1190

                if not UserSetupMgt.CheckPhysLocation(0, "Physical Location Group Code", "Responsibility Center") then
                    ERROR(
                      Text2014412,
                      PhysLocationGr.TABLECAPTION, "Physical Location Group Code",
                      RespCenter.TABLECAPTION, UserSetupMgt.GetSalesFilter);

                if (xRec."Physical Location Group Code" <> "Physical Location Group Code") then begin
                    CLEAR(Location);
                    if "Location Code" <> '' then
                        Location.GET("Location Code");
                    if (Location."Physical Location Group Code" <> "Physical Location Group Code") then begin
                        //<< DITW19.00.08 AKH 16/12/2016 BL#9797
                        if ((CurrFieldNo <> FIELDNO("Location Code")) and (CurrFieldNo <> FIELDNO("Responsibility Center")) and (xRec."Responsibility Center" = "Responsibility Center")) then
                            //>> DITW19.00.08 AKH BL#9797
                            VALIDATE("Location Code", '')
                        else
                            "Location Code" := '';
                    end;

                    // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1190
                    if (CurrFieldNo <> 0) and (CurrFieldNo <> FIELDNO("Responsibility Center")) and SalesLinesExist then begin
                        // >>DITW18.00.06 DDR DIT-770 #1190
                        // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
                        SalesSetup.GET;
                        if SalesSetup."Recalculate Prices" <> SalesSetup."Recalculate Prices"::" " then begin
                            AskConfirm :=
                              (SalesSetup."Recalculate Prices" = SalesSetup."Recalculate Prices"::Confirm) and
                              // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
                              ("Route Planning No." = '');
                            // >>DITW18.00.07 DDR DIT-770 #1488
                            // >>DITW18.00.07 DDR DIT-770 #1402
                            InitHasBeenShow(HasBeenShowText2014410, FIELDCAPTION("Physical Location Group Code"), 0);
                            // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
                            if HideValidationDialog or not GUIALLOWED or HasBeenShowText2014410 or not AskConfirm then
                                // >>DITW18.00.07 DDR DIT-770 #1402
                                Confirmed := true
                            else
                                Confirmed :=
                                  CONFIRM(
                                    Text2014413 +
                                    Text004, false, FIELDCAPTION("Physical Location Group Code"));
                            HasBeenShowText2014410 := Confirmed;
                            if Confirmed then begin
                                UpdateSalesLines(FIELDCAPTION("Physical Location Group Code"), false);
                                // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
                            end else
                                ERROR(
                                  Text017, FIELDCAPTION("Physical Location Group Code"));
                            // >>DITW18.00.07 DDR DIT-770 #1402
                            // <<DITW18.00.07 DDR 14/04/2016 DIT-770 #1402
                        end else
                            MessageIfSalesLinesExist(FIELDCAPTION("Location Code"));
                    end;
                    // >>DITW18.00.07 DDR DIT-770 #1402

                    // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Physical Location Group Code"));
                    // >>DITW18.00.07 DDR DIT-770 #1488
                    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
                    UpdateWhseRequestLines(FIELDCAPTION("Physical Location Group Code"));
                    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
                end;
            end;
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
        field(2014413; "Return Location Code"; Code[10])
        {
            CaptionML = ENU = 'Return Location Code',
                        FRA = 'Code Magasin Retour';
            Description = 'DITW19.00.08 BL#10756';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                            Code = FIELD("Location Table Filter"));

            trigger OnValidate();
            var
                AskConfirm: Boolean;
            begin
                //<< DITW19.00.08 AKH 20/09/2016 BL#10756
                TestOpenStatus;
                if (xRec."Return Location Code" <> "Return Location Code") and ("Return Location Code" <> '') then
                //<< DITW19.00.08 AKH 06/12/2016 BL#10756
                begin
                    //>> DITW19.00.08 AKH BL#10756
                    if not UserSetupMgt.CheckLocation(0, "Return Location Code", "Responsibility Center") then
                        ERROR(
                          Text2014412,
                          Location.TABLECAPTION, "Return Location Code",
                          RespCenter.TABLECAPTION, UserSetupMgt.GetSalesFilter);
                    //<< DITW19.00.08 AKH 06/12/2016 BL#10756
                    if (xRec."Sell-to Customer No." = "Sell-to Customer No.")
                    //>> DITW19.00.08 AKH BL#10756
                    then begin
                        if SalesLinesExist then begin
                            SalesSetup.GET;
                            if SalesSetup."Recalculate Prices" <> SalesSetup."Recalculate Prices"::" " then begin
                                AskConfirm :=
                                  (SalesSetup."Recalculate Prices" = SalesSetup."Recalculate Prices"::Confirm) and
                                  ("Route Planning No." = '');
                                InitHasBeenShow(HasBeenShowText2014410, FIELDCAPTION("Return Location Code"), 0);
                                if HideValidationDialog or not GUIALLOWED or HasBeenShowText2014410 or not AskConfirm then
                                    Confirmed := true
                                else
                                    Confirmed :=
                                      CONFIRM(
                                        Text2014413 +
                                        Text004, false, FIELDCAPTION("Return Location Code"));
                                HasBeenShowText2014410 := Confirmed;
                                if Confirmed then begin
                                    UpdateSalesLines(FIELDCAPTION("Return Location Code"), false);
                                end else
                                    ERROR(
                                      Text017, FIELDCAPTION("Return Location Code"));
                            end else
                                MessageIfSalesLinesExist(FIELDCAPTION("Return Location Code"));
                        end;
                    end;
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Return Location Code"));
                    //>> DITW19.00.08 AKH BL#10756
                    //<< DITW19.00.08 AKH 06/12/2016 BL#10756
                end;
                //>> DITW19.00.08 AKH BL#10756
            end;
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
            Description = 'DITW18.00.07 DIT-770 #1804-NRQ#83542';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales | "Fin.Contract"));

            trigger OnValidate();
            var
                DocumentSubtypeCode: Record "Document Subtype Code FND";
                PostingNoSeries: Code[20];
            begin
                //>>HEI.15

                if Cust1.GET("Sell-to Customer No.") then begin
                    if DocumentSubtypeCodeSetup.GET then;

                    if (((Cust1."Contract Type" = Cust1."Contract Type"::"CTS Only") or
                      (Cust1."Contract Type" = Cust1."Contract Type"::"Full Contract")) and
                       ("Document Subtype Code" <> DocumentSubtypeCodeSetup."CTS Order")) then
                        ERROR(Err002, DocumentSubtypeCodeSetup."CTS Order");
                end;

                //<<HEI.15

                //<<DITW111.00.13 MSF 04/09/2018 NRQ#83542-DITW111.00.13 MSF 05/09/2018 NRQ#83542
                if xRec."Document Subtype Code" <> Rec."Document Subtype Code" then begin
                    if Rec."Document Subtype Code" <> '' then begin
                        TESTFIELD("Posting No.", '');
                        PostingNoSeries := DocumentSubtypeCode.GetPostedSerialNoforDocumentSubtype("Document Type", "Document Subtype Code");
                        if PostingNoSeries <> '' then
                            "Posting No. Series" := PostingNoSeries
                        else
                            SetDefaultPostingSerialno;
                    end else
                        SetDefaultPostingSerialno;
                end;
                //>>DITW111.00.13 MSF 04/09/2018 NRQ#83542-DITW111.00.13 MSF 05/09/2018 NRQ#83542
                //HEI.01>>
                UpdateSalesLines(FIELDCAPTION("Document Subtype Code"), false);
                //HEI.01<<
            end;
        }
        field(2014460; "Tax Office Code"; Code[10])
        {
            CaptionML = ENU = 'Tax Office Code',
                        FRA = 'Code Bureau de taxe';
            Description = 'DITW15.00.00.38 #1217';
            TableRelation = "Tax Office";

            trigger OnValidate();
            begin
                //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
                TestOpenStatus;
                //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                if "Document Type" = "Document Type"::Order then
                    TestIfEmcsSalesLinesExist(FIELDCAPTION("Tax Office Code"));
                // >>DITW16.00.00.43 DDR DIT-715 #720
            end;
        }
        field(2014488; "Shipment Time"; Time)
        {
            CaptionML = ENU = 'Shipment Time',
                        FRA = 'Heure d''Expédition';
            Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230';

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                if xRec."Shipment Time" <> "Shipment Time" then
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Shipment Time"));
                // >>DITW18.00.07 DDR DIT-770 #1488
            end;
        }
        field(2014491; "Delivery Time"; Time)
        {
            CaptionML = ENU = 'Delivery Time',
                        FRA = 'Heure de Livraison';
            Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230';

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                if xRec."Delivery Time" <> "Delivery Time" then
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Delivery Time"));
                // >>DITW18.00.07 DDR DIT-770 #1488
            end;
        }
        field(2014495; "Delivery Sequence"; Integer)
        {
            BlankZero = true;
            CaptionML = ENU = 'Delivery Sequence',
                        FRA = 'Séquence de livraison';
            Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230 #1002';
            MinValue = 0;

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                if xRec."Delivery Sequence" <> "Delivery Sequence" then
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Delivery Sequence"));
                // >>DITW18.00.07 DDR DIT-770 #1488
            end;
        }
        field(2014496; "Invoice List Customer No."; Code[20])
        {
            CaptionML = ENU = 'Invoice List Customer No.',
                        FRA = 'N° client liste facture';
            Description = 'DITW17.10.05 DIT-715 #761';
            TableRelation = Customer;
        }
        field(2014500; "Resp. Center Table Filter"; Code[10])
        {
            CaptionML = ENU = 'Resp. Center Table Filter',
                        FRA = 'Filtre Centre de gestion (table)';
            Description = 'DITW18.00.06 DIT-770 #1190';
            FieldClass = FlowFilter;
            TableRelation = "Responsibility Center";
        }
        field(2014501; "Phys. Location Table Filter"; Code[10])
        {
            CaptionML = ENU = 'Phys. Location Table Filter',
                        FRA = 'Filtre groupe magasin réel (table)';
            Description = 'DITW18.00.06 DIT-770 #1190';
            FieldClass = FlowFilter;
            TableRelation = "Physical Location Group";
        }
        field(2014502; "Location Table Filter"; Code[10])
        {
            CaptionML = ENU = 'Location Table Filter',
                        FRA = 'Filtre Magasin (table)';
            Description = 'DITW18.00.06 DIT-770 #1190';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(2014503; "Resp. Center Table Filter 2"; Code[10])
        {
            CaptionML = ENU = 'Resp. Center Table Filter',
                        FRA = 'Filtre Centre de gestion (table)';
            Description = ' DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214';
            FieldClass = FlowFilter;
            TableRelation = "Responsibility Center";
        }
        field(2017760; "Disable DIT Disc. Prom."; Option)
        {
            Caption = 'Disable DIT Discount Promotion';
            Description = 'DITW111.00.13A MSF 09/05/2019 NRQ#109271';
            OptionCaption = '" ,Discount,Promotion,All"';
            OptionMembers = " ",Discount,Promotion,All;

            trigger OnValidate();
            begin
                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type", "Document Type");
                SalesLine.SETRANGE("Document No.", "No.");
                SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                SalesLine.MODIFYALL("Disable DIT Disc. Prom.", "Disable DIT Disc. Prom.");
            end;
        }
        field(2029614; "Last changed User ID"; Code[50])
        {
            Caption = 'Derniére Modification Utilisateur';
            Description = 'FINXL8.00.001';
            TableRelation = User."User Name";
        }
        field(2029615; "Last changed Date/time"; DateTime)
        {
            Caption = 'Date/Heure Derniére Modification';
            Description = 'FINXL8.00.001';
        }
        field(2029618; "IC Document"; Boolean)
        {
            Caption = 'IC Document';
            Description = 'Description=FINXL11.00';
        }
        field(2030010; "Interface Transaction No."; Integer)
        {
            Caption = 'N° transation interface';
            Description = 'IPLXL9.00.001';
        }
        field(2034840; "Building No."; Code[20])
        {
            CaptionML = ENU = 'Building No.',
                        FRA = 'N° immeuble';
            Description = 'DITW15.00.00.35';
            TableRelation = Building;

            trigger OnValidate();
            begin
                // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 - DITW17.00.02 SR 10/25/2013 DIT-770 #159
                TestOpenStatus;
                // >>DITW16.00.00.41 AHU DIT-715 #327 - DITW17.00.02 SR 10/25/2013 DIT-770 #159

                // <<DITW15.00.00.35 DDR 10/04/2009
                if "Building No." <> '' then begin
                    Building.GET("Building No.");
                    Building.TESTFIELD(Blocked, false);
                end;

                // <<DITW19.00.07 MVN 14/03/2016 DIT-770 #1390
                CreateDim(
                  DATABASE::Building, "Building No.",
                  DimMgt.TypeToTableID2034932(1, "Contract Type"), GetContractNo,
                  DATABASE::Customer, GetCustNoCalcDim(),
                  DATABASE::"Salesperson/Purchaser", "Salesperson Code",
                  DATABASE::Campaign, "Campaign No.",
                  DATABASE::"Responsibility Center", "Responsibility Center",
                  DATABASE::"Customer Template", "Bill-to Customer Template Code");
                // >>DITW19.00.07 MVN DIT-770 #1390

                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                if xRec."Building No." <> "Building No." then
                    UpdateRoutePlanRqstLines(FIELDCAPTION("Building No."));
                // >>DITW18.00.07 DDR DIT-770 #1488
            end;
        }
        field(2034850; "DIT Sub-Contract Type"; Option)
        {
            CaptionML = ENU = 'Sub Contract Type',
                        FRA = 'Sous type contrat';
            Description = 'DIT-715 #392';
            OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
                              FRA = ' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
            OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;

            trigger OnValidate();
            begin
                // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
                if (xRec."DIT Sub-Contract Type" <> "DIT Sub-Contract Type") and
                  (CurrFieldNo = FIELDNO("DIT Sub-Contract Type"))
                  //<<DITW17.10.03 TEC1 05/02/2014 DIT-770 #340
                  and ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ")
                //>>DITW17.10.03 TEC1 DIT-770 #340
                then begin
                    VALIDATE("Contract Group Code", '');
                    VALIDATE("Service Contract No.");
                end;
                //<<DITW17.10.03 TEC1 05/02/2014 DIT-770 #340
                if ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") then begin
                    CustSellto.GET("Sell-to Customer No.");
                    //<<DITW17.10.03 MSF 17/03/2014 DIT-715 #340
                    "Customer Posting Group" := ServPostJnl.GetSourcePostGroupService(Cust."No.", "DIT Sub-Contract Type");
                    //>>DITW17.10.03 MSF 17/03/2014 DIT-715 #340
                end;
                //>>DITW17.10.03 TEC1 DIT-770 #340
            end;
        }
        field(2034872; "Contract Group Code"; Code[10])
        {
            CaptionML = ENU = 'Contract Group Code',
                        FRA = 'Code groupe contrat';
            Description = 'DIT-715 #392';
            TableRelation = IF ("Contract Type" = CONST(Service)) "Contract Group".Code WHERE("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
            ELSE IF ("Contract Type" = CONST(Financial)) "Financial Contract Group".Code WHERE("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));

            trigger OnValidate();
            begin
                // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
                //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
                TestOpenStatus;
                //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159

                if "Contract Group Code" <> '' then begin
                    if ("Contract Group Code" <> xRec."Contract Group Code") and
                       (xRec."Sell-to Customer No." = "Sell-to Customer No.")
                    then
                        MessageIfSalesLinesExist(FIELDCAPTION("Contract Group Code"));
                    case "Contract Type" of
                        "Contract Type"::Service:
                            begin
                                if ContractGroup.Code <> "Contract Group Code" then
                                    ContractGroup.GET("Contract Group Code");
                                "DIT Sub-Contract Type" := ContractGroup."DIT Sub-Contract Type";
                            end;
                        "Contract Type"::Financial:
                            begin
                                if ContractGroupDIT.Code <> "Contract Group Code" then
                                    ContractGroupDIT.GET("Contract Group Code");
                                "DIT Sub-Contract Type" := ContractGroupDIT."DIT Sub-Contract Type";
                            end;
                    end;
                end else begin
                    CLEAR(ContractGroup);
                    CLEAR(ContractGroupDIT);
                end;
                if "Service Contract No." <> '' then
                    VALIDATE("Service Contract No.");
            end;
        }
        field(2034915; "Service Contract No."; Code[20])
        {
            CaptionML = ENU = 'Service Contract No.',
                        FRA = 'N° contrat de service';
            Description = 'DIT-715 #392 - DITW18.00.06 DIT-770 #1368';
            TableRelation = IF ("DIT Sub-Contract Type" = CONST(" ")) "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract))
            ELSE IF ("DIT Sub-Contract Type" = FILTER(<> " ")) "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract),
                                                                                                                            "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));

            trigger OnValidate();
            var
                FA2: Record "Fixed Asset";
            begin
                // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
                //<<DITW17.00.02 SR 10/25/2013 DIT-770 #159
                TestOpenStatus;
                //>>DITW17.00.02 SR 10/25/2013 DIT-770 #159

                if "Service Contract No." <> '' then begin
                    //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                    "Contract Type" := "Contract Type"::Service;
                    TESTFIELD("Financial Contract No.", '');
                    //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368

                    if ("Service Contract No." <> xRec."Service Contract No.") and
                       (xRec."Sell-to Customer No." = "Sell-to Customer No.")
                    then
                        MessageIfSalesLinesExist(FIELDCAPTION("Service Contract No."));

                    if (CurrFieldNo = FIELDNO("Service Contract No.")) and
                      (xRec."Service Contract No." <> "Service Contract No.")
                    then begin
                        "Contract Group Code" := '';
                    end;
                    //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
                    ServContract.GET(ServContract."Contract Type"::Contract, "Service Contract No.");
                    if SalesHeader."Building No." <> '' then
                        ServContract.TESTFIELD("Building No.", SalesHeader."Building No.");
                    if ("DIT Sub-Contract Type" <> 0) or
                      ((xRec."DIT Sub-Contract Type" <> 0) and ("DIT Sub-Contract Type" = 0) and
                      (xRec."Service Contract No." = "Service Contract No."))
                    then
                        TESTFIELD("DIT Sub-Contract Type", ServContract."DIT Sub-Contract Type")
                    else
                        "DIT Sub-Contract Type" := ServContract."DIT Sub-Contract Type";
                    if ("Contract Group Code" <> '') or
                      ((xRec."Contract Group Code" <> '') and ("Contract Group Code" = '') and
                      (xRec."Service Contract No." = "Service Contract No."))
                    then
                        TESTFIELD("Contract Group Code", ServContract."Contract Group Code")
                    else
                        "Contract Group Code" := ServContract."Contract Group Code";
                    if ("Building No." <> '') or
                      ((xRec."Building No." <> '') and ("Building No." = '') and
                      (xRec."Service Contract No." = "Service Contract No."))
                    then
                        TESTFIELD("Building No.", ServContract."Building No.");
                    //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
                end else begin
                    //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                    CLEAR("Contract Type");
                    CLEAR("Contract Group Code");
                    //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                end;

                //<<DITW17.10.03 MSF 17/03/2014 DIT-715 #340
                if ("Service Contract No." <> '') or ("Contract Group Code" <> '') or ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") then begin
                    //<< DITW18.00.07 VSC 11/04/2016 DIT-770 #1900
                    GetCust("Bill-to Customer No.");
                    //>> DITW18.00.07 VSC DIT-770 #1900
                    "Customer Posting Group" := ServPostJnl.GetSourcePostGroupService(Cust."No.", "DIT Sub-Contract Type");

                end;
                //>>DITW17.10.03 MSF 17/03/2014 DIT-715 #340

                // <<DITW19.00.07 MVN 14/03/2016 DIT-770 #1390
                CreateDim(
                  DimMgt.TypeToTableID2034932(1, "Contract Type"), "Service Contract No.",
                  DATABASE::Building, "Building No.",
                  DATABASE::Customer, GetCustNoCalcDim(),
                  DATABASE::"Salesperson/Purchaser", "Salesperson Code",
                  DATABASE::Campaign, "Campaign No.",
                  DATABASE::"Responsibility Center", "Responsibility Center",
                  DATABASE::"Customer Template", "Bill-to Customer Template Code");
                // <<DITW19.00.07 MVN DIT-770 #1390
            end;
        }
        field(2034920; "Contract Posting Date"; Date)
        {
            CaptionML = ENU = 'Contract Posting Date',
                        FRA = 'Date comptabilisation du contrat';
            Description = 'DITW16.00.00.43 DIT715 #619';
        }
        field(2035393; "Contract Type"; Option)
        {
            CaptionML = ENU = 'Contract Type',
                        FRA = 'Type contrat';
            Description = 'DIT-715 #392 - DIT-770 #690 - DITW18.00.06 DIT-770 #1368';
            OptionCaptionML = ENU = ' ,Service,Financial',
                              FRA = ' ,Service,Financier';
            OptionMembers = " ",Service,Financial;

            trigger OnValidate();
            begin
                //<<DITW17.10.05 MSF 16/07/2014 DIT-770 #690
                //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                if rPropertyServiceMgtSetup.READPERMISSION or
                   ContractDIT.READPERMISSION
                then begin
                    //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                    //>>DITW17.10.05 MSF 16/07/2014 DIT-770 #690
                    // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
                    if "Contract Type" <> xRec."Contract Type" then begin
                        "Contract Group Code" := '';
                        //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                        if "Service Contract No." <> '' then
                            VALIDATE("Service Contract No.", '');
                        //<<DITW18.00.06 MSF 27/10/2015 DIT-770 #1368
                        if "Financial Contract No." <> '' then
                            //>>DITW18.00.06 MSF 27/10/2015 DIT-770 #1674
                            VALIDATE("Financial Contract No.", '');
                        //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1674
                    end;
                    //<<DITW17.10.05 MSF 16/07/2014 DIT-770 #690
                end;
                //>>DITW17.10.05 MSF 16/07/2014 DIT-770 #690
            end;
        }
        field(2035394; "Approved Credit limit Amount"; Decimal)
        {
            Caption = 'Approved Credit limit Amount';
            Description = 'NRQ#9570';
        }
        field(2035395; "Last Limit Type"; Option)
        {
            Caption = 'Limit Type';
            DataClassification = ToBeClassified;
            Description = 'DITW114.00.15  NRQ#177508';
            OptionCaption = 'Approval Limits,Credit Limits,Request Limits,No Limits,Deposit Limits,Overdue Limits';
            OptionMembers = "Approval Limits","Credit Limits","Request Limits","No Limits","Deposit Limits","Overdue Limits";
        } */
        // BC Upgrade BHARDA11 << ----Drink-IT Fields
    }
    keys
    {

        //Unsupported feature: Deletion on ""Document Type","Sell-to Customer No."(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""Document Type","Combine Shipments","Bill-to Customer No.","Currency Code","EU 3-Party Trade","Dimension Set ID"(Key)". Please convert manually.

        key(Key14; "Document Type", "Sell-to Customer No.", "No.", "Ship-to Code")
        {
        }

        key(Key15; "Document Type", "Combine Shipments", "Bill-to Customer No.", "Currency Code", "EU 3-Party Trade")
        {
        }
        // BC UPgrade BHARDA11 >> ----Drink-IT Fields  ("Link Sales Document Type","Link Sales Document No.","Delivery Sequence",Route)
        // key(Key16; "Link Sales Document Type", "Link Sales Document No.")
        // {
        // }
        // key(Key17; "Document Type", "Shipment Date", "Truck Code")
        // {
        // }
        // key(Key18; "Telesales Entry", "Sell-to Customer No.", "Ship-to Code")
        // {
        // }
        // key(Key19; Route, "Delivery Sequence")
        // {
        // }
        // key(Key20; Route, "Sell-to Customer No.", "Shipment Date")
        // {
        // }
        // key(Key21; Route, "Shipment Date", "Delivery Sequence")
        // {
        // }
        // key(Key23; "Document Type", "Combine Shipments", Route, "Delivery Sequence", "Bill-to Customer No.", "Currency Code", "EU 3-Party Trade")
        // {
        // }
        // key(Key24; "Shipment Date", Route, "Document Type", Status, "Shipment status")
        // {
        // }
        // BC UPgrade BHARDA11 << ----Drink-IT Fields  ("Link Sales Document Type","Link Sales Document No.","Delivery Sequence",Route)

        key(Key22; "Document Type", "Combine Shipments", "Sell-to Customer No.", "Currency Code", "EU 3-Party Trade")
        {
        }

    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: lrecTelesalesEntry)();
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
    if not UserSetupMgt.CheckRespCenter(0,"Responsibility Center") then
      ERROR(
        Text022,
        RespCenter.TABLECAPTION,UserSetupMgt.GetSalesFilter);

    PostSalesDelete.DeleteHeader(
      Rec,SalesShptHeader,SalesInvHeader,SalesCrMemoHeader,ReturnRcptHeader,
      SalesInvHeaderPrepmt,SalesCrMemoHeaderPrepmt);

    ArchiveManagement.AutoArchiveSalesDocument(Rec);

    UpdateOpportunity;
    #13..23
    if not WhseRequest.ISEMPTY then
      WhseRequest.DELETEALL(true);

    SalesLine.SETRANGE("Document Type","Document Type");
    SalesLine.SETRANGE("Document No.","No.");
    SalesLine.SETRANGE(Type,SalesLine.Type::"Charge (Item)");

    DeleteSalesLines;
    SalesLine.SETRANGE(Type);
    DeleteSalesLines;

    SalesCommentLine.SETRANGE("Document Type","Document Type");
    SalesCommentLine.SETRANGE("No.","No.");
    SalesCommentLine.DELETEALL;

    if (SalesShptHeader."No." <> '') or
       (SalesInvHeader."No." <> '') or
       (SalesCrMemoHeader."No." <> '') or
       (ReturnRcptHeader."No." <> '') or
       (SalesInvHeaderPrepmt."No." <> '') or
       (SalesCrMemoHeaderPrepmt."No." <> '')
    then
      MESSAGE(PostedDocsToPrintCreatedMsg);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
      SalesInvHeaderPrepmt,SalesCrMemoHeaderPrepmt,
      // <<DITW110.00.08 DDR 02/01/2017 NRQ#0
      DepositSalesInvHeader,DepositSalesCrMemoHeader);
      // >>DITW110.00.08 DDR NRQ#0
    #10..26
    // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860 - DITW18.00.07 DDR 14/04/2016 DIT-770 #1109
    ClearHasBeenShowAll;
    // >>DITW16.00.00.43 DDR DIT-715 #860 - DITW18.00.07 DDR DIT-770 #1109

    // <<DITW15.00.00.29 DDR 19/12/2008
    if Status = Status::Released then
      DelayedMgt.SalesReopen(Rec);
    // >>DITW15.00.00.29 DDR

    // <<DITW17.00.01 DDR 13/02/2013 DIT-770 #001
    if AppMgt.IsObjectLicense(5,CODEUNIT::"Sales Disc. & Promo.-Post Line",4) <> 0 then
    // >>DITW17.00.01 DDR DIT-770 #001
      // <<DITW16.00.00.40 DDR 11/06/2012 DIT-715 #313
      DiscPromoPostLine.ReopenFromSalesHeader(Rec);
      // >>DITW16.00.00.40 DDR DIT-715 #313

    // <<DITW15.00.00.39 DDR 27/04/2011 #1230
    lrecTelesalesEntry.SETCURRENTKEY("Order No.");
    lrecTelesalesEntry.SETRANGE("Order No.","No.");
    if lrecTelesalesEntry.FINDSET(true,false) then
      repeat
        lrecTelesalesEntry2 := lrecTelesalesEntry;
        lrecTelesalesEntry2."Order No." := '';
        lrecTelesalesEntry2.VALIDATE("Call Status",lrecTelesalesEntry2."Call Status"::" ");
        lrecTelesalesEntry2.MODIFY(true);
      until lrecTelesalesEntry.NEXT = 0;
    // >>DITW15.00.00.39 DDR #1230

    // <<DITW18.00.07 DDR 25/02/2016 07/04/2016 DIT-770 #1488
    if RoutePlanRqst.READPERMISSION then begin
      RoutePlanRqst.SETRANGE("Source Type",DATABASE::"Sales Header");
      RoutePlanRqst.SETRANGE("Source Subtype","Document Type");
      RoutePlanRqst.SETRANGE("Source No.","No.");
      //doesn't work if need "skip" flag parameter
      //RoutePlanRqst.DELETEALL(TRUE);
      if RoutePlanRqst.FINDSET then
        repeat
          RoutePlanRqst2.SetSkipValidationDocument(true);
          RoutePlanRqst2 := RoutePlanRqst;
          RoutePlanRqst2.DELETE(true);
        until RoutePlanRqst.NEXT = 0;
    end;
    // >>DITW18.00.07 DDR DIT-770 #1488

    #27..29
    //<<DITW18.00.06 MSF 02/10/2015 DIT-770 #1261
    SalesLine.SetDeleteFromHeader(true);
    //>>DITW18.00.06 MSF 02/10/2015 DIT-770 #1261
    #31..38
    // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
    EmcsCommentLine.SETRANGE("Table ID",DATABASE::"Sales Header");
    EmcsCommentLine.SETRANGE("Document Type","Document Type");
    EmcsCommentLine.SETRANGE("Document No.","No.");
    EmcsCommentLine.DELETEALL;
    // >>DITW16.00.00.40 DDR DIT-715 #187

    //<< DITW18.00.07 VSC 07/03/2016 DIT-770 #1066
    DocumentShippingCost.RESET;
    DocumentShippingCost.SETRANGE("Source Type",DATABASE::"Sales Header");
    DocumentShippingCost.SETRANGE("Source No.","No.");
    DocumentShippingCost.SETRANGE("Sub Type","Document Type");
    DocumentShippingCost.DELETEALL;
    //>> DITW18.00.07 VSC DIT-770 #1066

    #39..43
       (SalesCrMemoHeaderPrepmt."No." <> '') or
       // <<DITW110.00.08 DDR 02/01/2017 NRQ#0
       (DepositSalesInvHeader."No." <> '') or
       (DepositSalesCrMemoHeader."No." <> '')
       // >>DITW110.00.08 DDR NRQ#0
       //<<HEI.59
       and GUIALLOWED
       //<<HEI.59

    then
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
    InitInsert;
    InsertMode := true;

    SetSellToCustomerFromFilter;

    if GetFilterContNo <> '' then
      VALIDATE("Sell-to Contact No.",GetFilterContNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if not SkipInitialization then
    InitInsert;
    InsertMode := true;
    // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860 - DITW18.00.07 DDR 14/04/2016 DIT-770 #1109
    ClearHasBeenShowAll;
    // >>DITW16.00.00.43 DDR DIT-715 #860 - DITW18.00.07 DDR DIT-770 #1109
    #3..7
    //<<FINXL9.00.001 ACH 27/07/2016
    ///DITW17.10.05 MSF 12/03/2015 DIT-770 DIT-770 1149
    /// DITW19.00.08 VSC 18/11/2016 BL#10351
    if recFINXLSetup.READPERMISSION then begin
      lcduSalesHook.fctOnInsertSalesHeader(Rec,false);
      lcduSalesHook.fctUpdateOnInsertSalesHeader(Rec);
      end;
    //>>FINXL9.00.001 ACH 27/07/2016
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateCustomerAddress;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.43 DDR 19/12/2013 DIT-715 #860 - DITW18.00.07 DDR 14/04/2016 DIT-770 #1109
    ClearHasBeenShowAll;
    // >>DITW16.00.00.43 DDR DIT-715 #860 - DITW18.00.07 DDR DIT-770 #1109
    //<<DITW17.00.02 TEC1 09/09/2013 DIT-770 #145
    if (xRec.Status <> Status) and (Status > Status::Open) then begin
      SalesSetup.GET;
      if SalesSetup."Return reason code mandatory" then begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","No.");
        SalesLine.SETRANGE(Type,SalesLine.Type::Item);
        //<<DITW18.00.06 MSF 22/05/2015 DIT-770 #994
        case "Document Type" of
          "Document Type"::Order :
         begin
          SalesLine.SETFILTER(Quantity,'<%1',0);
          SalesLine.SETFILTER("Return Reason Code",'=%1','');
          if not SalesLine.ISEMPTY then
            ERROR(Text2014411);
         end;
         "Document Type"::"Return Order" :
         begin
          SalesLine.SETFILTER(Quantity,'>%1',0);
          SalesLine.SETFILTER("Return Reason Code",'=%1','');
          if not SalesLine.ISEMPTY then
            ERROR(Text2014411);
         end;
       end;
       //>>DITW18.00.06 MSF 22/05/2015 DIT-770 #994
      end;
    end;
    //>>DITW17.00.02 TEC1 DIT-770 #145
    //<<FINXL8.00.001 BSA 10/06/2015 #85
    if recFINXLSetup.READPERMISSION then begin
      "Last changed User ID" := USERID;
      "Last changed Date/time" := CURRENTDATETIME;
    end;
    //>>FINXL8.00.001 BSA 10/06/2015 #85
    // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
    UpdateRoutePlanRqstLines('');
    // >>DITW18.00.07 DDR DIT-770 #1488

    UpdateCustomerAddress;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.




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
    //ConfirmChangeQst : @@@="%1 = a Field Caption like Currency Code";ENU=Do you want to change %1?;FRA=Souhaitez-vous modifier la valeur du champ %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=You cannot reset %1 because the document still has one or more lines.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=You cannot reset %1 because the document still has one or more lines.;FRA=Impossible de réinitialiser %1 car le document contient une ou plusieurs ligne(s).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=You cannot change %1 because the order is associated with one or more purchase orders.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=You cannot change %1 because the order is associated with one or more purchase orders.;FRA=%1 n'est pas modifiable car cette commande est liée à d'autres commandes achat.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=%1 cannot be greater than %2 in the %3 table.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=%1 cannot be greater than %2 in the %3 table.;FRA=%1 ne peut pas être supérieur(e) à %2 dans la table %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=Deleting this document will cause a gap in the number series for shipments. An empty shipment %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=Deleting this document will cause a gap in the number series for shipments. An empty shipment %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche expédition. Une expédition vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text012(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU=Deleting this document will cause a gap in the number series for posted invoices. An empty posted invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : ENU=Deleting this document will cause a gap in the number series for posted invoices. An empty posted invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des factures enregistrées. Une facture enregistrée vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text014(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : ENU=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : ENU=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche d'avoirs enregistrés. Un avoir enregistré vide %1 va être créé pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text015(Variable 1015)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text015 : ENU=If you change %1, the existing sales lines will be deleted and new sales lines based on the new information on the header will be created.\\Do you want to change %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text015 : ENU=If you change %1, the existing sales lines will be deleted and new sales lines based on the new information on the header will be created.\\Do you want to change %1?;FRA=Si vous modifiez %1, les lignes vente existantes seront supprimées et de nouvelles lignes vente basées sur les nouvelles informations sur l'en-tête seront créées.\\Voulez-vous modifier %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text017(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text017 : ENU=You must delete the existing sales lines before you can change %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text017 : ENU=You must delete the existing sales lines before you can change %1.;FRA=Vous devez supprimer les lignes vente existantes avant de modifier %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text018(Variable 1018)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text018 : ENU=You have changed %1 on the sales header, but it has not been changed on the existing sales lines.\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text018 : ENU=You have changed %1 on the sales header, but it has not been changed on the existing sales lines.\;FRA=Vous avez modifié le champ %1 dans l'en-tête vente, mais cela n'a pas été modifié dans les lignes vente existantes.\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text019(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text019 : ENU=You must update the existing sales lines manually.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text019 : ENU=You must update the existing sales lines manually.;FRA=Vous devez mettre manuellement à jour les lignes vente existantes.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text020(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text020 : ENU=The change may affect the exchange rate used in the price calculation of the sales lines.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text020 : ENU=The change may affect the exchange rate used in the price calculation of the sales lines.;FRA=Cette modification va affecter le taux de change utilisé pour le calcul des prix des lignes vente.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text021(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text021 : ENU=Do you want to update the exchange rate?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text021 : ENU=Do you want to update the exchange rate?;FRA=Souhaitez-vous mettre à jour le taux de change ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text022(Variable 1022)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text022 : ENU=You cannot delete this document. Your identification is set up to process from %1 %2 only.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text022 : ENU=You cannot delete this document. Your identification is set up to process from %1 %2 only.;FRA=Vous ne pouvez pas supprimer ce document. Le paramétrage de votre code utilisateur ne vous permet de travailler que sur %1 %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text024(Variable 1024)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text024 : ENU=You have modified the %1 field. The recalculation of VAT may cause penny differences, so you must check the amounts afterward. Do you want to update the %2 field on the lines to reflect the new value of %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text024 : ENU=You have modified the %1 field. The recalculation of VAT may cause penny differences, so you must check the amounts afterward. Do you want to update the %2 field on the lines to reflect the new value of %1?;FRA=Vous avez modifié le champ %1. Le nouveau calcul de la TVA va engendrer de petites différences. Veuillez vérifier les montants. Souhaitez-vous mettre à jour le champ %2 sur les lignes pour refléter la nouvelle valeur de %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text027(Variable 1027)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text027 : ENU=Your identification is set up to process from %1 %2 only.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text027 : ENU=Your identification is set up to process from %1 %2 only.;FRA=Le paramétrage de votre code utilisateur ne vous permet de travailler que sur %1 %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text028(Variable 1028)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text028 : ENU=You cannot change the %1 when the %2 has been filled in.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text028 : ENU=You cannot change the %1 when the %2 has been filled in.;FRA=Vous ne pouvez pas modifier le champ %1 lorsque le champ %2 a été renseigné.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text030(Variable 1030)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text030 : ENU=Deleting this document will cause a gap in the number series for return receipts. An empty return receipt %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text030 : ENU=Deleting this document will cause a gap in the number series for return receipts. An empty return receipt %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des réceptions retour. Une réception retour vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text031(Variable 1031)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text031 : ENU=You have modified %1.\\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text031 : ENU=You have modified %1.\\;FRA=Vous avez modifié le champ %1.\\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text032(Variable 1032)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text032 : ENU=Do you want to update the lines?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text032 : ENU=Do you want to update the lines?;FRA=Souhaitez-vous mettre les lignes à jour ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text035(Variable 1076)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text035 : ENU=You cannot Release Quote or Make Order unless you specify a customer on the quote.\\Do you want to create customer(s) now?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text035 : ENU=You cannot Release Quote or Make Order unless you specify a customer on the quote.\\Do you want to create customer(s) now?;FRA=Vous ne pouvez pas émettre un devis ou créer une commande à moins de spécifier un client sur le devis.\\Souhaitez-vous créer un client maintenant ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text037(Variable 1078)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text037 : ENU=Contact %1 %2 is not related to customer %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text037 : ENU=Contact %1 %2 is not related to customer %3.;FRA=Le contact %1 %2 n'est pas associé au client %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text038(Variable 1074)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text038 : ENU=Contact %1 %2 is related to a different company than customer %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text038 : ENU=Contact %1 %2 is related to a different company than customer %3.;FRA=Le contact %1 %2 est associé à une société différente de celle du client %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text039(Variable 1086)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text039 : ENU=Contact %1 %2 is not related to a customer.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text039 : ENU=Contact %1 %2 is not related to a customer.;FRA=Le contact %1 %2 n'est associé à aucun client.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text040(Variable 1083)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text040 : ENU=A won opportunity is linked to this order.\It has to be changed to status Lost before the Order can be deleted.\Do you want to change the status for this opportunity now?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text040 : ENU=A won opportunity is linked to this order.\It has to be changed to status Lost before the Order can be deleted.\Do you want to change the status for this opportunity now?;FRA=Une opportunité gagnée est associée à cette commande.\Le statut doit être défini sur Perdue pour pouvoir supprimer la commande.\Souhaitez-vous modifier le statut de cette opportunité maintenant ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text044(Variable 1088)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text044 : ENU=The status of the opportunity has not been changed. The program has aborted deleting the order.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text044 : ENU=The status of the opportunity has not been changed. The program has aborted deleting the order.;FRA=Le statut de l'opportunité n'a pas été modifié. Le système a abandonné la suppression de la commande.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text045(Variable 1081)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text045 : ENU="You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text045 : ENU="You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.";FRA="Vous ne pouvez pas modifier le champ %1 car %2 %3 a %4 = %5 et %6 a déjà été affecté(e) à %7 %8.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text048(Variable 1091)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text048 : ENU=Sales quote %1 has already been assigned to opportunity %2. Would you like to reassign this quote?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text048 : ENU=Sales quote %1 has already been assigned to opportunity %2. Would you like to reassign this quote?;FRA=Le devis %1 a déjà été affecté à l'opportunité %2. Souhaitez-vous le réaffecter ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text049(Variable 1092)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text049 : ENU=The %1 field cannot be blank because this quote is linked to an opportunity.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text049 : ENU=The %1 field cannot be blank because this quote is linked to an opportunity.;FRA=Le champ %1 ne peut pas être vide car ce devis est lié à une opportunité.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text051(Variable 1071)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text051 : ENU=The sales %1 %2 already exists.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text051 : ENU=The sales %1 %2 already exists.;FRA=La vente %1 %2 existe déjà.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text053(Variable 1102)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text053 : ENU=You must cancel the approval process if you wish to change the %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text053 : ENU=You must cancel the approval process if you wish to change the %1.;FRA=Vous devez annuler le processus d'approbation si vous souhaitez modifier le %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text056(Variable 1105)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text056 : ENU=Deleting this document will cause a gap in the number series for prepayment invoices. An empty prepayment invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text056 : ENU=Deleting this document will cause a gap in the number series for prepayment invoices. An empty prepayment invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des factures d'acompte. Une facture d'acompte vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text057(Variable 1108)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text057 : ENU=Deleting this document will cause a gap in the number series for prepayment credit memos. An empty prepayment credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text057 : ENU=Deleting this document will cause a gap in the number series for prepayment credit memos. An empty prepayment credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des avoirs acompte. Un avoir acompte vide %1 va être créé pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text061(Variable 1110)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text061 : ENU=%1 is set up to process from %2 %3 only.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text061 : ENU=%1 is set up to process from %2 %3 only.;FRA=%1 est paramétré pour traiter uniquement à partir de %2 %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text062(Variable 1072)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text062 : ENU=You cannot change %1 because the corresponding %2 %3 has been assigned to this %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text062 : ENU=You cannot change %1 because the corresponding %2 %3 has been assigned to this %4.;FRA=Vous ne pouvez pas modifier %1 car le %2 %3 correspondant a été affecté à ce %4.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text063(Variable 1077)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text063 : ENU=Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text063 : ENU=Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.\\Do you want to continue?;FRA=Il existe des réservations pour cette commande. Ces réservations seront annulées si cette modification entraîne un conflit de dates.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text064(Variable 1090)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text064 : ENU=You may have changed a dimension.\\Do you want to update the lines?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text064 : ENU=You may have changed a dimension.\\Do you want to update the lines?;FRA=Vous avez probablement modifié un axe analytique.\\Souhaitez-vous mettre à jour les lignes ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text066(Variable 1095)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text066 : ENU=You cannot change %1 to %2 because an open inventory pick on the %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text066 : ENU=You cannot change %1 to %2 because an open inventory pick on the %3.;FRA=Vous ne pouvez pas modifier %1 en %2 car un prélèvement stock est ouvert sur %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text070(Variable 1096)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text070 : ENU=You cannot change %1  to %2 because an open warehouse shipment exists for the %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text070 : ENU=You cannot change %1  to %2 because an open warehouse shipment exists for the %3.;FRA=Vous ne pouvez pas modifier %1 en %2 car il existe une expédition entrepôt ouverte pour %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text071(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text071 : ENU=There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text071 : ENU=There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.;FRA=Il existe des factures d'acompte impayées liées au document de type %1 portant le numéro %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text072(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text072 : ENU=There are unpaid prepayment invoices related to the document of type %1 with the number %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text072 : ENU=There are unpaid prepayment invoices related to the document of type %1 with the number %2.;FRA=Il existe des factures d'acompte impayées liées au document de type %1 portant le numéro %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DeferralLineQst(Variable 1044)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DeferralLineQst : ENU=Do you want to update the deferral schedules for the lines?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DeferralLineQst : ENU=Do you want to update the deferral schedules for the lines?;FRA=Souhaitez-vous mettre à jour les tableaux d'échelonnement pour les lignes ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SynchronizingMsg(Variable 1026)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SynchronizingMsg : ENU=Synchronizing ...\ from: Sales Header with %1\ to: Assembly Header with %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SynchronizingMsg : ENU=Synchronizing ...\ from: Sales Header with %1\ to: Assembly Header with %2.;FRA=Synchronisation ...\ de : En-tête vente avec %1\ vers : En-tête assemblage avec %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ShippingAdviceErr(Variable 1029)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShippingAdviceErr : ENU=This order must be a complete shipment.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShippingAdviceErr : ENU=This order must be a complete shipment.;FRA=Cet ordre doit être une expédition traitée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "PostedDocsToPrintCreatedMsg(Variable 1084)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PostedDocsToPrintCreatedMsg : ENU=One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PostedDocsToPrintCreatedMsg : ENU=One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.;FRA=Un ou plusieurs documents validés connexes ont été générés lors de la suppression pour éviter une discontinuité dans la souche de numéros de validation. Vous pouvez afficher ou imprimer les documents à partir de l'archive de document correspondant.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SellToCustomerTxt(Variable 1052)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SellToCustomerTxt : ENU=Sell-to Customer;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SellToCustomerTxt : ENU=Sell-to Customer;FRA=Donneur d'ordre;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "BillToCustomerTxt(Variable 1057)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //BillToCustomerTxt : ENU=Bill-to Customer;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BillToCustomerTxt : ENU=Bill-to Customer;FRA=Client facturé;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DocumentNotPostedClosePageQst(Variable 1061)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DocumentNotPostedClosePageQst : ENU=The document has not been posted.\Are you sure you want to exit?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DocumentNotPostedClosePageQst : ENU=The document has not been posted.\Are you sure you want to exit?;FRA=Le document n'a pas été validé.\Voulez-vous vraiment quitter ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SelectCustomerTemplateQst(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SelectCustomerTemplateQst : ENU=Do you want to select the customer template?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SelectCustomerTemplateQst : ENU=Do you want to select the customer template?;FRA=Voulez-vous sélectionner le modèle client ?;
    //Variable type has not been exported.
    // BC Upgrade BHARDA11 >> ----Drink-IT Function

    // PROCEDURE SetSecurityFilterOnRespCenter();
    // BEGIN
    //     // <<DITW18.00.06 DDR 02/03/2015 DIT-770 #1190
    //     //IF UserSetupMgt.GetSalesFilter <> '' THEN BEGIN
    //     IF UserSetupMgt.GetSalesTextFilter <> '' THEN BEGIN
    //         FILTERGROUP(2);
    //         //SETRANGE("Responsibility Center",UserSetupMgt.GetSalesFilter);
    //         SETFILTER("Responsibility Center", UserSetupMgt.GetSalesTextFilter);
    //         FILTERGROUP(0);
    //     END;
    //     // >>DITW18.00.06 DDR DIT-770 #1190

    //     SETRANGE("Date Filter", 0D, WORKDATE - 1);
    // END;
    // BC Upgrade BHARDA11 << ----Drink-IT Function

    procedure CheckForLinkSalesDocument(SalesHeader: Record "Sales Header")
    var
        lSalesHeader: Record "Sales Header";
        lSalesSetup: Record "Sales & Receivables Setup";
        lCust: Record Customer;
    // ggyy: Codeunit 
    // SalesOrderToReturnOrder: Codeunit "Create Sales Ret.Order"; // BC Upgrade BHARDA11 ----Drink-IT Codeunit("Create Sales Ret.Order")
    begin
        //<<HEI.02
        lSalesSetup.GET();
        IF lSalesSetup."Return Order Mandatory FND" = TRUE THEN BEGIN
            IF lCust.GET(SalesHeader."Sell-to Customer No.") THEN
                // >>HEI.55
                IF lCust."Return Order Mandatory FND" = TRUE THEN BEGIN
                    // BC Upgrade BHARDA11 >>----Drink-IT Codeunit("Create Sales Ret.Order")
                    // IF NOT SalesOrderToReturnOrder.FindLastCreatedOrder(Rec) THEN BEGIN
                    //     IF NOT SalesOrderToReturnOrder.FindLastPostedCreatedOrder(Rec) THEN
                    //         ERROR(Text50000);
                    // END;
                    // BC Upgrade BHARDA11 << ----Drink-IT Codeunit("Create Sales Ret.Order")
                END;
        end;

        /*  BEGIN
           lSalesHeader.SETRANGE("Document Type",lSalesHeader."Document Type"::"Return Order");
           lSalesHeader.SETCURRENTKEY("Link Sales Document Type","Link Sales Document No.");
           lSalesHeader.SETRANGE("Link Sales Document Type",lSalesHeader."Link Sales Document Type"::Order);
           lSalesHeader.SETRANGE("Link Sales Document No.",SalesHeader."No.");
           IF NOT lSalesHeader.FINDFIRST THEN
             ERROR(Text50000);
         END; */

        // <<HEI.55
    END;
    //>>HEI.02
    procedure InsertFAGLJnlLinesForRPMDamageLoss(SalesHeader2: Record "Sales Header")
    var
        SalesSetup2: Record "Sales & Receivables Setup";
        SalesHeader3: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoHeader2: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        FAGLJnlLine: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        TotalRPMAmount: Decimal;
        TotalRPMAmount2: Integer;
        DocumentNo: Code[20];
        ShippingAgent: Record "Shipping Agent";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        //>>HEI.06
        SalesSetup2.GET();
        IF ShippingAgent.GET("Shipping Agent Code") THEN;

        SalesInvoiceHeader.SETRANGE("Posting Description", SalesHeader2."Posting Description");
        IF SalesInvoiceHeader.FINDFIRST()
           AND NOT SalesHeader3.GET(SalesHeader2."Document Type", SalesHeader2."No.")
        THEN BEGIN
            SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
            IF SalesInvoiceLine.FINDSET() THEN BEGIN
                REPEAT
                    IF SalesInvoiceLine."RPM Damage / Loss FND" THEN BEGIN
                        GenJnlBatch.GET(SalesSetup2."RPM Damage/Loss Jnl. Templ FND", SalesSetup2."RPM Damage/Loss Jnl. Batch FND");
                        // DocumentNo := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", "Posting Date"); // BC Upgrade BHARDA11 ---- Replace TryGetNextNo to GetNextNo
                        DocumentNo := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", "Posting Date");// BC Upgrade BHARDA11 ---- Replace TryGetNextNo to GetNextNo
                        TotalRPMAmount += ABS(SalesInvoiceLine.Amount);
                        FAGLJnlLine.InsertFAGLJnlLine(FAGLJnlLine, FAGLJnlLine."Account Type"::"Fixed Asset".AsInteger(), '', -ABS(SalesInvoiceLine.Amount),
                          FAGLJnlLine."FA Posting Type"::"Write-Down".AsInteger(), SalesInvoiceHeader."No.", SalesHeader2."Posting Date",
                          SalesHeader2."Document Date", DocumentNo, TRUE);
                    END ELSE IF SalesInvoiceLine."Trnsprtr. RPM Damage/Loss FND" THEN BEGIN
                        GenJnlBatch.GET(SalesSetup2."RPM Damage/Loss Jnl. Templ FND", SalesSetup2."RPM Damage/Loss Jnl. Batch FND");
                        // DocumentNo := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", "Posting Date"); // BC Upgrade BHARDA11 ---- Replace TryGetNextNo to GetNextNo
                        DocumentNo := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", "Posting Date"); // BC Upgrade BHARDA11 ---- Replace TryGetNextNo to GetNextNo
                        TotalRPMAmount2 += ABS(SalesInvoiceLine.Amount);
                        FAGLJnlLine.InsertFAGLJnlLine(FAGLJnlLine, FAGLJnlLine."Account Type"::"Fixed Asset".AsInteger(), '', -ABS(SalesInvoiceLine.Amount),
                          FAGLJnlLine."FA Posting Type"::"Write-Down".AsInteger(), SalesInvoiceHeader."No.", SalesHeader2."Posting Date",
                          SalesHeader2."Document Date", DocumentNo, TRUE);
                    END;
                UNTIL SalesInvoiceLine.NEXT() = 0;
                IF TotalRPMAmount > 0 THEN
                    FAGLJnlLine.InsertFAGLJnlLine(FAGLJnlLine, FAGLJnlLine."Account Type"::Customer.AsInteger(), SalesHeader2."Bill-to Customer No.", TotalRPMAmount,
                      FAGLJnlLine."FA Posting Type"::" ".AsInteger(), SalesInvoiceHeader."No.", SalesHeader2."Posting Date", SalesHeader2."Document Date", DocumentNo, TRUE);
                // BC Upgrade BHARDA11 >> ----Drink-IT Field(ShippingAgent."Customer No.")
                // IF TotalRPMAmount2 > 0 THEN
                //     FAGLJnlLine.InsertFAGLJnlLine(FAGLJnlLine, FAGLJnlLine."Account Type"::Customer, ShippingAgent."Customer No.", TotalRPMAmount2,
                //       FAGLJnlLine."FA Posting Type"::" ", SalesInvoiceHeader."No.", SalesHeader2."Posting Date", SalesHeader2."Document Date", DocumentNo, TRUE);
                // BC Upgrade BHARDA11 >> ----Drink-IT Field(ShippingAgent."Customer No.")

            END;
        END ELSE BEGIN
            SalesCrMemoHeader2.SETRANGE("Posting Description", SalesHeader2."Posting Description");
            IF SalesCrMemoHeader2.FINDFIRST()
               AND NOT SalesHeader3.GET(SalesHeader2."Document Type", SalesHeader2."No.")
            THEN BEGIN
                SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader2."No.");
                IF SalesCrMemoLine.FINDSET() THEN BEGIN
                    REPEAT
                        IF SalesCrMemoLine."RPM Damage / Loss FND" THEN BEGIN
                            GenJnlBatch.GET(SalesSetup2."RPM Damage/Loss Jnl. Templ FND", SalesSetup2."RPM Damage/Loss Jnl. Batch FND");
                            // DocumentNo := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", "Posting Date"); // BC Upgrade BHARDA11 ---- Replace TryGetNextNo to GetNextNo
                            DocumentNo := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", "Posting Date"); // BC Upgrade BHARDA11 ---- Replace TryGetNextNo to GetNextNo
                            TotalRPMAmount += ABS(SalesCrMemoLine.Amount);
                            FAGLJnlLine.InsertFAGLJnlLine(FAGLJnlLine, FAGLJnlLine."Account Type"::"Fixed Asset".AsInteger(), '', -ABS(SalesCrMemoLine.Amount),
                              FAGLJnlLine."FA Posting Type"::"Write-Down".AsInteger(), SalesCrMemoHeader2."No.", SalesHeader2."Posting Date",
                              SalesHeader2."Document Date", DocumentNo, TRUE);
                        END ELSE IF SalesCrMemoLine."Transporter RPMDamage/Loss FND" THEN BEGIN
                            GenJnlBatch.GET(SalesSetup2."RPM Damage/Loss Jnl. Templ FND", SalesSetup2."RPM Damage/Loss Jnl. Batch FND");
                            DocumentNo := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", "Posting Date"); // BC Upgrade BHARDA11 ---- Replace TryGetNextNo to GetNextNo
                            TotalRPMAmount2 += ABS(SalesCrMemoLine.Amount);
                            FAGLJnlLine.InsertFAGLJnlLine(FAGLJnlLine, FAGLJnlLine."Account Type"::"Fixed Asset".AsInteger(), '', -ABS(SalesCrMemoLine.Amount),
                              FAGLJnlLine."FA Posting Type"::"Write-Down".AsInteger(), SalesCrMemoHeader2."No.", SalesHeader2."Posting Date",
                              SalesHeader2."Document Date", DocumentNo, TRUE);
                        END;
                    UNTIL SalesCrMemoLine.NEXT() = 0;

                    IF TotalRPMAmount > 0 THEN
                        FAGLJnlLine.InsertFAGLJnlLine(FAGLJnlLine, FAGLJnlLine."Account Type"::Customer.AsInteger(), SalesHeader2."Bill-to Customer No.", TotalRPMAmount,
                          FAGLJnlLine."FA Posting Type"::" ".AsInteger(), SalesCrMemoHeader2."No.", SalesHeader2."Posting Date", SalesHeader2."Document Date", DocumentNo, TRUE);
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields (ShippingAgent."Customer No.")
                    // IF TotalRPMAmount2 > 0 THEN
                    //     FAGLJnlLine.InsertFAGLJnlLine(FAGLJnlLine, FAGLJnlLine."Account Type"::Customer, ShippingAgent."Customer No.", TotalRPMAmount2,
                    //       FAGLJnlLine."FA Posting Type"::" ", SalesCrMemoHeader2."No.", SalesHeader2."Posting Date", SalesHeader2."Document Date", DocumentNo, TRUE);
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields (ShippingAgent."Customer No.")

                END;
            END;
        END;
        //<<HEI.06
    end;

    procedure ValidateCustomerMinValue(VAR SalesHeader: Record "Sales Header")
    var
        ContinueL: Boolean;
        CustomerL: Record Customer;
        DimensionL: Record Dimension;
        DimensionValueL: Record "Dimension Value";
        DimensionSetEntryL: Record "Dimension Set Entry";
        CustomerNoL: Code[20];
        Text0000: Label 'The Min. Order Value %1 has not been reached for this Customer - %2! Still do you want to release the Sales Order – %3?';
        Text0001: Label 'Please increase the minimum SO Value atleast %1 before releasing.';
        Text0002: Label 'You cannot release the Sales Order - %1 due to the %2 is set as Blocking for this Customer - %3 which Min. Order Value is %4.';
        Text0003: Label '"Sell-to Customer No." is blank in this Sales Order - %1.';
    begin
        //HEI.19>>
        ContinueL := TRUE;
        CustomerL.GET(SalesHeader."Sell-to Customer No.");
        IF CustomerL."Min. Order Value Limit FND" <> 0 THEN BEGIN
            IF SalesHeader."Prices Including VAT" THEN BEGIN
                SalesHeader.CALCFIELDS("Amount Including VAT");
                IF CustomerL."Min. Order Value Limit FND" > SalesHeader."Amount Including VAT" THEN
                    ContinueL := FALSE;
            END ELSE BEGIN
                SalesHeader.CALCFIELDS(Amount);
                IF CustomerL."Min. Order Value Limit FND" > SalesHeader.Amount THEN
                    ContinueL := FALSE;
            END;
            IF NOT ContinueL THEN BEGIN
                CASE CustomerL."Min. Ord. Value Limit Type FND" OF
                    CustomerL."Min. Ord. Value Limit Type FND"::None:
                        EXIT;

                    CustomerL."Min. Ord. Value Limit Type FND"::Warning:
                        BEGIN
                            //<<HEI.59
                            IF NOT GUIALLOWED THEN
                                EXIT
                            ELSE BEGIN
                                //>>HEI.59
                                IF NOT CONFIRM(Text0000, TRUE, CustomerL."Min. Order Value Limit FND", SalesHeader."Sell-to Customer No.", SalesHeader."No.") THEN
                                    ERROR(Text0001, CustomerL."Min. Order Value Limit FND")
                                ELSE
                                    EXIT;
                                //<<HEI.59
                            END;
                            //>>HEI.59
                        END;

                    CustomerL."Min. Ord. Value Limit Type FND"::Blocking:
                        BEGIN
                            ERROR(Text0002, SalesHeader."No.", CustomerL.FIELDCAPTION("Min. Ord. Value Limit Type FND"),
                              SalesHeader."Sell-to Customer No.", CustomerL."Min. Ord. Value Limit Type FND");
                        END;
                END;
            END;
        END ELSE BEGIN
            DimensionSetEntryL.SETRANGE("Dimension Set ID", SalesHeader."Dimension Set ID");
            IF DimensionSetEntryL.FINDSET() THEN BEGIN
                REPEAT
                    DimensionValueL.GET(DimensionSetEntryL."Dimension Code", DimensionSetEntryL."Dimension Value Code");
                    IF DimensionValueL."Min. Ord. Value Limit Type FND" <> 0 THEN BEGIN
                        IF SalesHeader."Prices Including VAT" THEN BEGIN
                            SalesHeader.CALCFIELDS("Amount Including VAT");
                            IF DimensionValueL."Min. Ord. Value Limit Type FND" > SalesHeader."Amount Including VAT" THEN
                                ContinueL := FALSE;
                        END ELSE BEGIN
                            SalesHeader.CALCFIELDS(Amount);
                            IF DimensionValueL."Min. Ord. Value Limit Type FND" > SalesHeader.Amount THEN
                                ContinueL := FALSE;
                        END;
                        IF NOT ContinueL THEN BEGIN
                            CASE DimensionValueL."Min. Ord. Value Limit Type FND" OF
                                DimensionValueL."Min. Ord. Value Limit Type FND"::None:
                                    EXIT;

                                DimensionValueL."Min. Ord. Value Limit Type FND"::Warning:
                                    BEGIN
                                        //<<HEI.59
                                        IF NOT GUIALLOWED THEN
                                            EXIT
                                        ELSE BEGIN
                                            //<<HEI.59
                                            IF NOT CONFIRM(Text0000, TRUE, DimensionValueL."Min. Ord. Value Limit Type FND", SalesHeader."Sell-to Customer No.", SalesHeader."No.") THEN
                                                ERROR(Text0001, DimensionValueL."Min. Ord. Value Limit Type FND")
                                            ELSE
                                                EXIT;
                                            //<<HEI.59
                                        END;
                                        //>>HEI.59
                                    END;

                                DimensionValueL."Min. Ord. Value Limit Type FND"::Blocking:
                                    BEGIN
                                        ERROR(Text0002, SalesHeader."No.", DimensionValueL.FIELDCAPTION("Min. Ord. Value Limit Type FND"),
                                          SalesHeader."Sell-to Customer No.", DimensionValueL."Min. Ord. Value Limit Type FND");
                                    END;
                            END;
                        END;
                    END;
                UNTIL DimensionSetEntryL.NEXT() = 0;
            END;
        END;
        //HEI.19<<
    end;

    // BC Upgrade SHUKLP03 >> Added DIT procedure SetDefaultPostingSerialno() because used in Document subtype code.
    LOCAL procedure SetDefaultPostingSerialno()
    var
        NoSeriesMgt: Codeunit "No. Series";
    begin
        //<<DITW111.00.13 MSF 05/09/2018 NRQ#83542
        SalesSetup.GET();
        CASE "Document Type" OF
            "Document Type"::Quote, "Document Type"::Order:
                If NoSeriesMgt.IsAutomatic(SalesSetup."Posted Invoice Nos.") Then
                    "Posting No. Series" := SalesSetup."Posted Invoice Nos.";
            "Document Type"::Invoice:
                BEGIN
                    IF ("No. Series" <> '') AND
                      (SalesSetup."Invoice Nos." = SalesSetup."Posted Invoice Nos.")
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        If NoSeriesMgt.IsAutomatic(SalesSetup."Posted Invoice Nos.") then
                            "Posting No. Series" := SalesSetup."Posted Invoice Nos.";
                END;
            "Document Type"::"Return Order":
                If NoSeriesMgt.IsAutomatic(SalesSetup."Posted Credit Memo Nos.") then
                    "Posting No. Series" := SalesSetup."Posted Credit Memo Nos.";
            "Document Type"::"Credit Memo":
                BEGIN
                    IF ("No. Series" <> '') AND
                      (SalesSetup."Credit Memo Nos." = SalesSetup."Posted Credit Memo Nos.")
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        If NoSeriesMgt.IsAutomatic(SalesSetup."Posted Credit Memo Nos.") then
                            "Posting No. Series" := SalesSetup."Posted Credit Memo Nos.";
                END;
        END;
    end;
    // BC Upgrade SHUKLP03 << Added DIT procedure SetDefaultPostingSerialno() because used in Document subtype code.

    procedure PostOrderAndReturnOrderLinked(SalesHeader2: Record "Sales Header")
    var
        SalesHeader3: Record "Sales Header";
    begin
        //HEI.07>>
        // BC Upgrade BHARDA11 >> ---- Drink-IT Field ("Link Sales Document No.","Shipment status")
        // IF SalesHeader3.GET(SalesHeader3."Document Type"::"Return Order", SalesHeader2."No.")
        //    AND (SalesHeader3."Link Sales Document No." = SalesHeader2."No.")
        //    AND (SalesHeader3."Shipment status" = SalesHeader3."Shipment status"::"Return completed")
        // THEN
        //     CODEUNIT.RUN(CODEUNIT::"Sales-Post (Yes/No)", SalesHeader3);
        // BC Upgrade BHARDA11 << ---- Drink-IT Field ("Link Sales Document No.","Shipment status")

        //HEI.07<<
    end;

    PROCEDURE UpdateFreeReasonCodeDimensions()
    VAR
        SalesLine3: Record "Sales Header";
        SalesLine4: Record "Sales Header";
        DefaultDimension: Record "Default Dimension";
        TempDimSetEntry: Record "Dimension Set Entry" TEMPORARY;
        DimMgt: Codeunit DimensionManagement;
    BEGIN
        //<<HEI.31
        DefaultDimension.RESET();
        DefaultDimension.SETRANGE("Table ID", 2013788);
        DefaultDimension.SETRANGE("No.", "Free Reason Code FND");
        IF DefaultDimension.FINDSET() THEN BEGIN
            DimMgt.GetDimensionSet(TempDimSetEntry, "Dimension Set ID");
            REPEAT
                UpdateDimSet(TempDimSetEntry, DefaultDimension."Dimension Code", DefaultDimension."Dimension Value Code");
            UNTIL DefaultDimension.NEXT() = 0;
            VALIDATE("Dimension Set ID", DimMgt.GetDimensionSetID(TempDimSetEntry));
            MODIFY(TRUE);
        END;
        //>>HEI.31
    END;

    PROCEDURE UpdateDimSet(VAR TempDimSetEntry: Record "Dimension Set Entry" temporary; DimCode: Code[20]; DimValueCode: Code[20])
    VAR
        DimVal: Record "Dimension Value";
    BEGIN
        //<<HEI.31
        IF DimCode = '' THEN
            EXIT;
        IF TempDimSetEntry.GET("Dimension Set ID", DimCode) THEN
            TempDimSetEntry.DELETE();
        IF DimValueCode = '' THEN
            DimVal.INIT()
        ELSE
            DimVal.GET(DimCode, DimValueCode);
        TempDimSetEntry."Dimension Code" := DimCode;
        TempDimSetEntry."Dimension Value Code" := DimValueCode;
        TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
        TempDimSetEntry.INSERT();
        //>>HEI.31
    END;

    LOCAL PROCEDURE FilterWhseShippingDrivers();
    VAR
    // WhseShippingDriver: Record 2014063; // BC Upgrade BHARDA11 ----Drnk-IT Table (WhseShippingDriver)
    BEGIN
        //HEI.33>>
        // BC Upgrade BHARDA11 >> ----Drink-It Table(WhseShippingDriver)
        // WhseShippingDriver.RESET;
        // IF "Responsibility Center" = '' THEN
        //     WhseShippingDriver.SETRANGE("Responsibility Center", Rec."Resp. Center Table Filter")
        // ELSE
        //     WhseShippingDriver.SETRANGE("Responsibility Center", Rec."Resp. Center Table Filter 2");

        // IF "Shipping Agent Code" <> '' THEN BEGIN
        //     WhseShippingDriver.SETFILTER("Shipping Agent Code", '%1|%2', '', "Shipping Agent Code");
        // END;

        // IF PAGE.RUNMODAL(0, WhseShippingDriver) = ACTION::LookupOK THEN
        //     Rec."Driver Code" := WhseShippingDriver.Code
        // BC Upgrade BHARDA11 << ----Drink-It Table(WhseShippingDriver)

        //HEI.33<<
    END;

    LOCAL PROCEDURE FilterWhseShippingTrucks()
    VAR
    // WhseShippingTruck: Record 2014068; // BC Upgrade BHARDA11 ----Drink-IT Table(WhseShippingTruck)
    BEGIN
        //HEI.33>>
        // BC Upgrade BHARDA11 >>----Drink-IT Table(WhseShippingTruck)

        // WhseShippingTruck.RESET;
        // IF "Responsibility Center" = '' THEN BEGIN
        //     WhseShippingTruck.SETRANGE("Responsibility Center", "Resp. Center Table Filter");
        //     WhseShippingTruck.SETFILTER("Transport Unit Type", '<>%1', WhseShippingTruck."Transport Unit Type"::Trailer);
        // END ELSE BEGIN
        //     WhseShippingTruck.SETRANGE("Responsibility Center", "Resp. Center Table Filter 2");
        //     WhseShippingTruck.SETFILTER("Transport Unit Type", '<>%1', WhseShippingTruck."Transport Unit Type"::Trailer);
        // END;

        // IF "Shipping Agent Code" <> '' THEN BEGIN
        //     WhseShippingTruck.SETFILTER("Shipping Agent Code", '%1|%2', '', "Shipping Agent Code");
        //     WhseShippingTruck.SETFILTER("Transport Unit Type", '<>%1', WhseShippingTruck."Transport Unit Type"::Trailer);
        // END;

        // IF PAGE.RUNMODAL(0, WhseShippingTruck) = ACTION::LookupOK THEN
        //     "Truck Code" := WhseShippingTruck.Code;
        // BC Upgrade BHARDA11 << ----Drink-IT Table(WhseShippingTruck)

        //HEI.33<<
    END;

    procedure IsAutoSendDocEnabled(): Boolean
    var
        ICPartner: Record "IC Partner";
    begin
        //<<FINXL14.00.15 MSF 13/05/2020 NRQ#117628
        IF "Sell-to IC Partner Code" <> '' THEN BEGIN
            ICPartner.GET("Sell-to IC Partner Code");
            // EXIT(ICPartner."Auto Send IC Document"); // BC Upgrade BHARDA11 ---Drink-IT Field ("Auto Send IC Document")
        END;
    end;

    LOCAL PROCEDURE FilterShippingAgentServiceCode()
    VAR
        ShippingAgentServices: Record "Shipping Agent Services";
    BEGIN
        //>> HEI.39
        ShippingAgentServices.RESET();
        ShippingAgentServices.SETRANGE("Shipping Agent Code", Rec."Shipping Agent Code");
        // BC Upgrade BHARDA11 >> ----Drink-IT Field ("Allow Shipping Cost Per")
        // ShippingAgentServices.SETFILTER("Allow Shipping Cost Per", '%1|%2', ShippingAgentServices."Allow Shipping Cost Per"::Document,
        //                                                                    ShippingAgentServices."Allow Shipping Cost Per"::" "); //HEI.43
        // BC Upgrade BHARDA11 << ----Drink-IT Field ("Allow Shipping Cost Per")

        IF PAGE.RUNMODAL(0, ShippingAgentServices) = ACTION::LookupOK THEN
            VALIDATE("Shipping Agent Service Code", ShippingAgentServices.Code);
        //<< HEI.39
    END;

    procedure SetHideValidationDialogWF(NewHideValidationDialogWF: Boolean)
    begin
        //HEI.63>>
        HideValidationDialogWF := NewHideValidationDialogWF;
    end;

    procedure GetHideValidationDialogWF(): Boolean
    begin
        //HEI.63>>
        EXIT(HideValidationDialogWF);
    end;

    procedure SetShowNotificationDialogWF(NewShowNotificationDialogWF: Boolean)
    begin
        //HEI.64>>
        ShowNotificationDialogWF := NewShowNotificationDialogWF;
    end;


    procedure GetShowNotificationDialogWF(): Boolean
    begin
        //HEI.64>>
        EXIT(ShowNotificationDialogWF);
    end;




    var
        // rFiscalRep: Record 2013672; // BC Upgrade BHARDA11 ----Drink-IT Table

        // CustCheckDeposittLimit: Codeunit 2013615;  // BC Upgrade BHARDA11 ----Drink-IT Codeunit

        Text2013660: Label 'ENU="You have modified the %1 field. Note that the recalculation may cause penny differences, so you must check the amounts afterwards. ";FRA="Vous avez modifi  le champ %1. Le recalcul va provoquer de petites diff rences. Veuillez v rifier les montants. "';
        // DelayedMgt: Codeunit 2013764;  // BC Upgrade BHARDA11 ----Drink-IT Codeunit

        StatusCheckSuspended: Boolean;
        HasBeenShown: Boolean;
        SaveCurrency: Record Currency;
        Text2013661: Label 'ENU=You must specify %1 in %2 or %3 or %4 when %5 %6.;FRA=Vous devez sp cifier %1 dans %2 ou %3 ou %4 quand %5 %6.';
        // Building: Record 2034841; // BC Upgrade BHARDA11 ----Drink-IT Table

        // SSCCSetup: Record 2035040;  // BC Upgrade BHARDA11 ----Drink-IT Table

        TempTrackingSpecification: Record "Tracking Specification" temporary;
        // SSCCLineReserv: Codeunit 2035048;  // BC Upgrade BHARDA11 ----Drink-IT Codeunit

        SSCCExistRecreateLine: Boolean;
        Text2035040: Label 'ENU=You cannot change %1 because reservation, item tracking, or order tracking exists on the sales order.;FRA=Vous ne pouvez pas modifier %1 car une r servation, une tra abilit  ou un cha nage existe sur la commande vente.';
        Text2035041: Label 'ENU=The sales %1 %2 has also SSCC tracking. Do you want to delete it anyway?;FRA=La vente %1 %2 a aussi une tra abilit  SSCC. Souhaitez-vous quand m me la supprimer ?';
        recContact: Record Contact;
        WhseSetup: Record "Warehouse Setup";
        // WhseTransportMgt: Codeunit 2014060; // BC Upgrade BHARDA11 ----Drink-IT Codeunit
        // DiscPromoPostLine: Codeunit 2013762; // BC Upgrade BHARDA11 ----Drink-IT Codeunit

        // DitPropServSetup: Record 2034840;  // BC Upgrade BHARDA11 ----Drink-IT Table

        ContractGroup: Record "Contract Group";
        // ContractGroupDIT: Record 2014312;  // BC Upgrade BHARDA11 ----Drink-IT Table

        ServContract: Record "Service Contract Header";
        // ContractDIT: Record 2014310; // BC Upgrade BHARDA11 ----Drink-IT Table

        DimParamId: ARRAY[10] OF Integer;
        DimParamNo: ARRAY[10] OF Code[20];
        CustSellto: Record Customer;
        // AppMgt: Codeunit ApplicationManagement;
        Text2013662: Label 'ENU=If you change %1, the existing sales tax charge lines will be deleted and new sales tax charge lines based on the new information on the header will be created.\\;FRA=Si vous modifiez l''enregistrement %1, les lignes de frais taxe vente existantes seront supprim es et de nouvelles lignes de frais taxe vente seront cr  es.\\';
        Text2013610: Label 'ENU=If you change %1, the existing sales deposit charge lines will be deleted and new sales deposit charge lines based on the new information on the header will be created.\\;FRA=Si vous modifiez l''enregistrement %1, les lignes de frais consigne vente existantes seront supprim es et de nouvelles lignes de frais consigne vente seront cr  es.\\';
        Text2014410: Label 'ENU=If you change %1, all existing sales charge lines will be deleted and new sales charge lines based on the new information on the header will be created.\\;FRA=Si vous modifiez l''enregistrement %1, toutes les lignes de frais vente existantes seront supprim es et de nouvelles lignes de frais vente seront cr  es.\\';
        Text2014260: Label 'ENU=You cannot change %1 because the order ''%2'' line %3 is associated with a EMCS document.;FRA=%1 n''est pas modifiable car la ligne commande ''%2'' %3 est li e   un document EMCS.';
        Text2014411: Label 'ENU=Return reason code must be filled in on all item lines;FRA=Code Raison Retour doit  tre saisi pour toutes les lignes articles';
        rShipmentMethod: Record "Shipment Method";
        Text2014095: Label 'ENU=Can only be filled in, if Invoice Method is Combine Shipments or Combine Shipments Per Sell-to;FRA=Ne peut pas  tre rempli si methode de facturation est Combiner expeditions ou Combiner les expeditions par donneur d''ordre';
        Text2014096: Label 'ENU=Shipment Date does not match the Route Shipment Day. Do you want to Continue?;FRA=La date d''exp dition ne correspond pas au jour de l''itin raire d''exp dition. Voulez vous continer?';
        iWeekNo: Integer;
        FieldTable: Record Field;
        FirstCalledByField: Record Integer temporary;
        HasBeenShowSellTo: Boolean;
        HasBeenShowBillTo: Boolean;
        HasBeenShowText015: Boolean;
        HasBeenShowText018: Boolean;
        HasBeenShowText020: Boolean;
        HasBeenShowText021: Boolean;
        HasBeenShowText032: Boolean;
        HasBeenShowText2013610: Boolean;
        HasBeenShowText2013662: Boolean;
        HasBeenShowText2014410: Boolean;
        HasBeenShowText2014096: Boolean;
        ServPostJnl: Codeunit "Serv-Posting Journals Mgt.";
        Text2014426: Label 'ENU=Order intake is after latest order date/time : %1;FRA=La prise de commande est apres la derni re date/heure : %1 de commande';
        Text2014412: Label 'ENU=You cannot use the %1 %2 because your identification is set up to process from %3 %4 only.;FRA=Vous ne pouvez pas utiliser le %1 %2 parce que votre identification est configur e pour traiter de %3 %4 seulement.';
        Text2014413: Label 'ENU=If you change %1, all existing will be updated and all sales charge lines will be deleted and new sales charge lines based on the new information on the header will be created.\\;FRA=Si vous changez %1, tous les existants seront mis   jour et toutes les lignes de frais de souscription seront supprim s et de nouvelles lignes de frais d''acquisition sur la base de nouvelles informations sur l''en-t te seront cr  s \\.';
        Text2014414: Label 'ENU=%1 %2 is assigned to %3 %4 and your identification is not set up to process.\\;FRA=%1 %2 est affect e   %3 %4 et votre identification ne soit pas mis en place pour traiter. \\';
        Text2014415: Label 'ENU=Do you want to continue?;FRA=Souhaitez-vous continuer?';
        Text2014416: Label 'ENU=The user has been interrupted the process to respect the warning.;FRA=L''utilisateur a interrompu le processus pour respecter l''alerte.';
        // rPropertyServiceMgtSetup: Record 2034840; // BC Upgrade BHARDA11 ----Drink-IT Table
        SelltoCustomerNoChanged: Boolean;
        ShipToCodeChanged: Boolean;
        HasBeenDeleted: Boolean;
        HasSelectPendingOrder: Boolean;
        // WhseShippingTruckList: Page 2014069;  // BC Upgrade BHARDA11 ----Drink-IT Table
        // recFINXLSetup: Record 2029610; // BC Upgrade BHARDA11 ----Drink-IT Table

        Text2014417: Label 'ENU=The document is empty.\Are you sure you want to delete it?;FRA=Le document est vide.\Etes-vous s r de vouloir le supprimer?';
        Text2029610: Label 'ENU=Recycle charge lines exist. Do you want to recalculate?;FRA=Voulez-vous calcul  des axionnes?';
        Text2029611: Label 'ENU=Do you want to calculate charges?;FRA=Voulez-vous calcul  des axionnes?';
        Text2029612: Label 'ENU=The %1 is not filled in the GL setup, do you like to continue?;FRA=%1 n''est pas remplit dans param tres comptablit  .Voulez-vous continuer ?';
        // EMCSEDIMgt: Codeunit 2014261; 
        // ApplMgt: Codeunit 1;
        // RoutePlanRqst: Record 2014087; // BC Upgrade BHARDA11 ----Drink-IT Codeunit

        // SalesRequestMgt: Codeunit 2014075; // BC Upgrade BHARDA11 ----Drink-IT Codeunit

        SkipValidationDimensions: Boolean;
        recUserSetup: Record "User Setup";
        UserMgt: Codeunit "User Setup Management";
        Text004: Label 'ENU=Do you want to change %1?;FRA=Souhaitez-vous modifier la valeur du champ %1?';
        DepositSalesInvHeader: Record "Sales Invoice Header";
        DepositSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SelectCustomerTemplateQst: Label 'ENU=Do you want to select the customer template?;FRA=Voulez-vous s lectionner le mod le client ?';
        SelectNoSeriesAllowed: Boolean;
        // BackorderMgmt: Codeunit 2014082;// BC Upgrade BHARDA11 ----Drink-IT Codeunit
        Text50000: Label 'ENU=Sales Return order must be present!';
        Text2014060: Label 'ENU=You can only fill in a payment amount if the payment method code has a balancing account or if the Applies-to Doc. no field is filled.';
        Text055: Label 'ENU=%1  must be filled for item %2;NLB=%1  moet ingegeven worden voor Artikel %2';
        Text2014061: Label 'ENU=Modification not allowed. Warehouse line exists for this %1 %2';
        WMSManagement: Codeunit "WMS Management";
        Text2014062: Label 'ENU=Modifcation allowed Only From Order Shipmment planning';
        ShippingAgent: Record "Shipping Agent";
        Vend: Record Vendor;
        Err002: Label 'ENU=The Document Subtype Code must be %1 when the Contract Type is Full Contract or CTS Only';
        xWhseRequest: Record "Warehouse Request";
        Cust1: Record Customer;
        // RecRoute: Record 2014072; // BC Upgrade BHARDA11 ----Drink-IT Table
        ShippingAgentVendorIsBlank: Label 'ENU=There is no Vendor associated with this Shipping Agent';
        VendorBlockForShipAgent: Label 'ENU=The Vendor associated with this Shipping Agent is blocked';
        // DocumentSubtypeCodeSetup: Record 2014473; // BC Upgrade BHARDA11 ----Drink-IT Table
        // Rec_FreeReasonCode: Record 2013788;  // BC Upgrade BHARDA11 ----Drink-IT Table
        ArchiveManagement: Codeunit ArchiveManagement;
        HeinekenGlobal: Codeunit "Heineken Global";
        HideValidationDialogWF: Boolean;
        ShowNotificationDialogWF: Boolean;
}

