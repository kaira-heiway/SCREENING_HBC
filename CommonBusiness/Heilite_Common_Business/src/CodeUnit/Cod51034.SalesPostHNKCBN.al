namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;
using Microsoft.Sales.Posting;
using Microsoft.Sales.History;
using Microsoft.Sales.Setup;
using Microsoft.CRM.Team;
using Microsoft.CRM.Campaign;
using Microsoft.Projects.Project.Job;
using Microsoft.Finance.ReceivablesPayables;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Warehouse.Setup;
using Microsoft.Warehouse.Journal;
using Microsoft.Warehouse.Structure;
using Microsoft.Inventory.Location;
using Microsoft.Finance.Currency;
using Microsoft.Sales.Receivables;
using Microsoft.Warehouse.Document;
using Microsoft.Sales.Customer;
using System.Utilities;
using Microsoft.Finance.Dimension;
using Microsoft.Warehouse.History;
using Microsoft.Sales.Document;

codeunit 51034 "Sales-Post HNK CBN"
{
    //  DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 21/12/2007 Added Drink-it Tax Item Charges functionnalities
    // DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    // DITW15.00.00.01 DDR 07/01/2008 bugfix copy field "Empty goods item no."
    //                                added field "Item Charge Quantity per"
    // DITW15.00.00.01 DDR 10/01/2008 Added field "Due Tax"
    // DITW15.00.00.01 DDR 22/01/2008 Added Drink-it Discount & Promotion Item Charges functionnalities
    // DITW15.00.00.01 DDR 28/01/2008 Update for Warehouse attached item lines and quantites after posting
    // DITW15.00.00.01 DDR 01/02/2008 Bugfix Auto Suggest ItemCharges Assgnt whith partial posting lines
    // DITW15.00.00.01 DDR 04/02/2008 Added Drink-it Reversing Calculation (Rounding) functionnalities
    // DITW15.00.00.01 DDR 11/02/2008 Added Drink-It Periodic Discounts & Promotions functionnalities
    // DITW15.00.00.01 DDR 18/02/2008 Discount item charge amounts into Item Journal "Discount Amount" (std. field)
    // DITW15.00.00.01 DDR 20/02/2008 remove field2013783 "Applies-to D/P Line No."
    //                                Added field2013785 Periodic Disc.-Promo Entry No.
    // DITW15.00.00.01 DDR 27/02/2008 Remove field2034690 Price Incl. Reversing Calc.
    //                                 replacing with "ItemCharge Incl. Price"
    // DITW15.00.00.01 DDR 27/02/2008 Drink-it Return Deposit functionnalities
    // DITW15.00.00.01 DDR 10/03/2008 change parameter function AutoSuggestItemChargeAssgnt()
    //                                added discount amount into PostItemCharge() for Periodic Cr.Memos discounts
    //                                bugfix Standard Navision into CopyAndCheckItemCharge() with partial shipment/return & invoice
    //                                transfer due date into itemjnlline
    // DITW15.00.00.01 DDR 21/03/2008 Update function CalcUnitPriceSalesLine() to calculate back the item unit price
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.16 DDR 26/03/2008 Update Tax function CalcUnitPriceSalesLine() new parameter
    //                                Bugfix fill field "Periodic Disc.-Promo Entry No."
    // DITW15.00.00.17 DDR 03/04/2008 Bugfix to post the Periodic D/P worksheet
    //                                Bugfix skip item promotion to call function CalcUnitPriceSalesLine()
    //                                Update function PostAssocReturnOrders()
    // DITW15.00.00.18 DDR 04/04/2008 Bugfix Navision to close the process completely (lock when called by batch report)
    //                                  rewrite function PostAssocReturnOrders()
    //                                Bugfix Partial Item Charges
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.19 DDR 07/04/2008 Review workflow price incl & back calculation
    //                                Remove setcurrentkey into function CopyAndCheckItemCharge()
    //                                Check Return Item Empty Goods with Negative Quantity
    // DITW15.00.00.20 DDR 27/05/2008 Added function SumSalesLinesTempTotal()
    // DITW15.00.00.20 DDR 06/06/2008 Certification rules
    //                     11/06/2008 Licence permission to write into table 5823 G/L - Item Ledger Relation
    // DITW15.00.00.21 DDR 13/06/2008 Added transfer Amount fields into Shipment & Return Receipt Lines
    //                                Added function GetTempSalesLinesShptRec()
    //                                Added Qty invoiced transport calculation on receiption

    // DITW15.00.00.23 DDR 23/07/2008 Change parameter function CalcUnitPriceSalesLine()
    //                                remove function CalcUnitPriceSalesLine() from RoundAmount()
    //                     12/08/2008 Save prepayment Amounts into Ship or Receive
    //                                Certification Rules
    //                                  Remove local variable dd (function CopyAndCheckItemCharge)
    //                                                        lcduPurchPost (trigger OnRun)
    //                                                        lrTempPurchLine3 (trigger OnRun)
    // DITW15.00.00.23.04 DDR 15/09/2008 Bugfix Update Whse Header fields "Shipping Qty. Not Invd.","Shipping Quantity Invoiced"
    //                                   Bugfix Weight,Cubage into Purchase Receipt Line when partial posting
    // DITW15.00.00.24 DDR 29/08/2008 Added new parameter into std function DivideAmount()
    //                     25/09/2008 Added fields to fill in Item journal(s)
    //                     07/10/2008 Added field "Duty Tax Type" to transfer into Item  journal
    // DITW15.00.00.25 DDR 10/10/2008 Copied fields "Driver Code","Truck Code" from Whse Header to Posted Header + Customer entry
    //                     17/10/2008 Updated fields "Weight","Volume" for all posted documents
    //                                Changed flow using "Duty Point" (sales setup) to post (invoice) tax item charges
    //                                Added function IsTaxDutyPointLine()
    //                     21/10/2008 Remove flow "Duty Tax Type"
    //                     22/10/2008 Added parameter 'pblnIsDutyPoint' for function PostItemChargePerOrder()
    // DITW15.00.00.26 DDR 31/10/2008 Added Delayed Discount/Promotion Mgt.
    //                                Added check for maximum & limit (per user) discounts
    //                                Added function UpdateSalesShptLineFromInv()
    //                                Added textconst Text2013760
    //                                Added Driver & Truck code into Shipment Line, Return Receipt Line,Purch Receipt Line
    //                     21/11/2008 Bugfix to copy Driver & Truck into Customer entry
    // DITW15.00.00.28 DDR 27/11/2008 Added to create AAD document entries
    //                     02/12/2008 Bugfix rounding standard into function CopyAndCheckItemCharge()
    // DITW15.00.00.29 DDR 19/12/2008 Bugfix partial invoicing, the item charges (Discount/Promotion) are not updated correctly
    //                                  when the quantity is negative into function PostItemChargePerOrder()
    // DITW15.00.00.30 DDR 19/01/2009 Added/Bugfix copy field from header into item journal line
    // DITW15.00.00.31 DDR 17/02/2009 Navision bug Function TestGetRcptPPmtAmtToDeduct() local variable "OrderNo" Code 10 -> Code 20
    //                     19/02/2009 Removed function CheckEmptyGoodNeg()
    //                                Added to save "Last Price Calculated Date" into Item Journal lines
    // DITW15.00.00.32 DDR 12/03/2009 Bugfix to create any item charge (from return order) into item jnl line
    //                                  while use Duty point 'Posted shipment'
    //                     25/03/2009 Bugfix to post Due tax (Duty COS) into G/L Entry & Value Entry with Ret.Orders & Credit Memos
    //                                  while use Duty point 'Posted shipment'.
    //                     09/04/2009 Added Drink Tax Rounding
    //                                Added mandatory "Tariff No." with AAD Documents
    // DITW15.00.00.33 DDR 08/05/2009 Added text constant Text2013660,Text2013661
    //                                Added field "Duty Suspended"
    //                                Added checking Drink Tax Group mandatory fields
    // DITW15.00.00.34 DDR 08/06/2009 Skipped checking AAD Nos Series when item has no attached Tax item charges
    //                     09/06/2009 Removed function UpdateSalesShptLineFromInv()
    //                     16/06/2009 Added checking on "Empty goods item no." if mandatory
    //                     03/07/2009 Added transfer fields "Tariff no.","Tax Formula" into Item journal
    //                     07/07/2009 Bugfix error partial Tax due when duty point is shipment.
    //                     09/07/2009 Bugfix check "Tax registration" is mandatory in Header
    // DITW15.00.00.35 DDR 22/06/2009 Added checking if exists shipment or return receipt document when duty point if shipment
    //                                 (case 'shipment on invoice' or 'return receipt on cr.memo = No)
    //                                Added text constant Text2013613
    //                                Added function SumChargeSalesLinesTemp()
    //                                Added flowfilters into functions
    //                                  GetSalesLines(),SumSalesLines2()
    //                     26/06/2009 issue 669 Added transfer fields to Item journal
    //                                "Gen. Prod. Posting Free Group",
    //                                 "Free Item Posting Type","Free Item","Free Calculation Type","Include Free Qty. in Minimum"
    //                     23/07/2009 Added function GetAttachedSalesLines()
    //                     14/08/2009 Added copy "Gen. Bus. Posting Group" from attached Item Charge lines
    //                     05/08/2009 Move Packing List lines to posted lines
    //                     21/08/2009 issue 784 missing to transfer 'Free' fields to item journal
    //                     02/10/2009 issue 792 Added to check dimension value posting with (Sell-to) Customer
    //                     08/10/2009 issue 781 Fill in "Discount Amount" into Item Journal for Item charges
    //                     16/10/2009 issue 802 Update Qty. Assigned of Tax item charges while duty point = receipt
    // DITW15.00.00.36 DDR 18/11/2009 issue 676 Missing splitting and recalculating qty to ship/invoice whith G/L account per order
    //                                          Added function CopyAndCheckItemChargeOther()
    //                     18/12/2009 issue 939 Error to recalculate price back
    // DITW15.00.00.37 DDR 07/01/2010 issue 959 Bugfix keep the AAD No. after all received (sales return order)
    //                     20/01/2010 issue 1020 Added transfer fields into Item journal
    //                                             "Location Group Code","Company Tax Registration No.","Physical Location Group Code"
    //                     28/01/2010 issue 879 Added "Building No." into General journal
    //                     29/01/2010 issue 1054 Added transfer fields into Item journal
    //                                             "AAD No. Series","AAD No.","Tariff No."
    //                                           Removed call to AAD document functions
    //                     03/02/2010 issue 1032 Added invoice discount for sales amounts with discount item charge types
    //                     04/02/2010 issue 1033 Bugfix Skip to delete existing discounts while (re)open status for posted lines
    //                     09/02/2010 issue 1065 Bugfix the due tax (unit) amount item charges to post the item journal while
    //                                            item qty. per unit of measure is different of 1 and duty point is shipment/receipt
    //                     09/02/2010 issue 1032 Bugfix Skip line discount amount for discount item charge
    //                                           Bugfix calculate discount & amount for item journal with Discounts item charges
    //                     04/03/2010 issue 1065 Bugfix bad Qty assigned saved
    //                     12/03/2010 issue 1065 Bugfix bad tax amounts with free items
    //                     09/04/2010 issue 959 Bugfix with return orders and get reverse lines and AAD no. is filled,
    //                                            skip test on AAD series nos.
    //                     12/04/2010 issue 1112 Bugfix sign tax item charge with negative quantities (not field "opposite sign")
    //                                          + Workaround to solve a Navision 5.00 (SP1) Standard bug to recalculate
    //                                             the Item Charge Assignment (Sales) "unit cost" when there is an invoice discount amount
    //                     23/04/2010 issue 1123 Bugfix automatically assign all item charges after posted by ship only
    //                     27/04/2010 issue 1095 Bugfix check if all item charges are assigned (qty to assign <> 0)
    //                     29/04/2010 issue 1114 Bugfix to have discount/promotion per order into value entries
    //                                              because call Release function after the functions CopyAndCheckItemCharge(),
    //                                               CopyAndCheckItemChargeOther()
    //                     07/05/2010 issue 959 Bugfix keep AAD No. after the last shipment/return receipt
    //                     18/05/2010 issue 1137 Added function CheckAttachedItemCharges()
    //                     27/05/2010 issue 1121 Added security to check field "Shipment on Invoice" when field "Duty Point"
    //                     01/06/2010 issue 959 Bugfix test AAD mandatory on Qty. to ship or Return Qty to Receive
    //                     03/06/2010 issue 1121 Added security to check field "Return Receipt on Credit Memo" when field "Duty Point"
    //                     03/06/2010 issue 1125 Bugfix function CheckAttachedItemCharges() with promotion item charges
    //                     09/06/2010 issue 1153 Remove test unit cost for item charge assignments
    //                     18/06/2010 issue 1165 Bugfix skipped testing for all other sales line types to check attached lines
    //                     18/06/2010 issue 1028 Added check again for credit limits
    //                     28/06/2010 issue 1182 Allowed to check the item charge assignement lines with delayed disc/promo.
    // DITW16.00.00.37 DDR 16/06/2010 Upgrade NAV 2009 SP1
    // DITW15.00.00.38 DDR 05/07/2010 issue 1109 Added to split Due Taxes Item charge assignements by Lot/Serial tracking line
    //                                             and when Duty point Shipment
    //                     13/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                           AAD Checking Rule Modified (combination Cust/Item Tax Groups)
    //                                           Added checking fields + item journal
    //                                             "LRN No. Series","LRN No.","ARC No.","SAD No.","Product Tax Code"
    //                     17/09/2010            Modified to check "ARC No." when mandatory
    //                     22/09/2010            Validate field "Packaging Type Code" to fill in the default "No. of Packages"
    //                     30/09/2010            Validate EDI when posting a (sales) Return order within ARC no.
    //                     04/10/2010            Added call function to check the EMCS sales order documents
    //                     11/10/2010            Check license to skip EMCS if not need
    //                                           Bugfix to check if LRN is mandatory
    // DITW15.00.00.38 DDR 14/10/2010 issue 1139 SSCC Functionnalities
    //                                           Added check on SSCC no. and quantities (required)
    //                     17/11/2010            Added to prepare sscc tracking for itemjnlline
    //                                           Added codeunit 'Permission' property for table2035045 "SSCC Entry Relation"
    //                                           Added functions InsertShptEntryRelationSSCC(),InsertReturnEntryRelationSSCC(),
    //                                             TransfReservToItemJnlLineSSCC()
    //                                           Added Text constants Text2035042,Text2035043
    //                     03/12/2010 issue 1222 Bugfix manual Item charges (read record to show error message)
    //                     09/12/2010            (DIT711 99) Bugfix Modified test mandatory on tax whse reference (Export only).
    //                     09/12/2010 issue 1242 Bugfix manual item charges to calculate for unit price & cost.
    //                     10/12/2010 issue 1117 Bugfix post excise value entry with item tracking (combine shipment)
    //                     10/12/2010 issue 1139 (DIT711 101) Bugfix to prepare SSCC Tracking reservation and transfer to item journal
    //                     10/12/2010 issue 1221 Added fields to copy into General journal line
    //                                  "Customer Tax Registration No.","Customer Tax Warehouse Ref."
    //                     14/12/2010 issue 1097 Added to check if duty tax line is mandatory
    //                                           Modified AAD tests for performance
    //                     17/12/2010 issue 703 Added fields "Tax Item No."
    //                     04/01/2011 issue 1217 (DIT711 105)
    //                                              field "Customer Tax Registration no." is not mandatory when destination types
    //                                                (Tax Warehouse,Registered Consignee,Temporary Registered,Direct Delivery)
    //                                              field "Customer Tax Warehouse Ref." is not mandatory when destination types
    //                                                (Registered Consignee,Temporary Registered,Direct Delivery,Exempted Organisation)
    //                     26/01/2011 issue 1117 Bugfix error on qty. assigned when posting partial invoice
    //                     04/02/2011 issue 1141 Added parameter function PostFromSalesShptLine() for Periodic Disc-Promo
    //                     16/02/2011 issue 1217 (DIT711 146) Check fields to create EMCS documents
    //                                                          "Shipping Agent Code","Shipping Agent Code","Shipping Time"
    //                     16/02/2011 issue 1217 (DIT711 148) Added transfer value field "Pack Qty. per Unit of Measure" into Item journal
    //                     21/02/2011 issue 1217 (DIT711 146) Bugfix check only the Shippent agent header fields.
    //                     22/02/2011 issue 1139 (DIT711 152) Bugfix function SaveTempWhseSplitSpec() to read SSCC tracking lines
    //                     24/02/2011 issue 1287 Bugfix opposite sign with item charge (like standard Navision)
    //                     08/03/2011 issue 1217 (DIT711 158) Bugfix skip "Shipping Agent" checking for inbound (only Purchase Return)
    //                                                               remove "Shipping Agent" checking equal header value
    //                     11/03/2011 issue 703 Bugfix to calculate Tax item no. with "Item Charge Quantity per"
    //                     15/03/2011 isue 1161 Bugfix missing AAD/ARC mandatory checking on Invoice
    //                     18/03/2011 issue 703 Copy the "Source no." into "Tax Item no." following setup
    // DITW15.00.00.39 DDR 12/04/2011 issue 1296 Added link to Warehouse documents for EMCS/EDI Inbound
    // DITW15.00.00.39 DDR 03/05/2011 issue 1325 Skip SSCC when not read permission (not in license)
    // DITW16.00.00.39 DDR 04/05/2011 DIT-715 issue 98 Bugfix missing copy data into new W16 local variable TempWhseTrackingSpecification
    //                                          in function PostItemJnlLine()
    //                     05/05/2011 DIT-715 issue 118 Allow (split) to post Line Discount Accounts when Line Discount 100%
    //                     03/05/2011 issue 1325 Skip SSCC when not read permission (not in license)
    //                     09/05/2011 issue 1328 Shop (iPos) Functionnalities
    //                                           Added function UpdateAssocPosSalesEntries()
    //                     05/07/2011 issue 1349 Bugfix don't update EMCS/EDI inbox when return receipt line has quantity zero
    //                     27/07/2011 issue 1407 Added to insert item charges on posting (field "Autom. Item Charge")
    //                     01/08/2011 issue 1353 Remove test on "Shipping Time"
    //                     04/08/2011 issue 1369 Skip to clear the field "Applies-to AAD Trck. Entry No."
    //                     05/08/2011 issue 1230 Added to transfer field "Ship-to/Order Address code" into item journal line
    //                     11/08/2011 issue 1407 Skip  item charges on posting (field "Autom. Item Charge") while posting by Whse
    //                     16/08/2011 issue 1407 Added to insert promotion charge lines when "Autom. Item Charge" is 'PostingExclIem'
    //                     19/08/2011 issue 1363 Added to transfer field "Tax Date" into item journal & document
    //                     22/08/2011 issue 1399 Added to hide all dialog boxes when no guiallowed
    // DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187 EMCS phase v3 Added functions CopyEmcsCommentLines()
    //                     05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)" to calculate VAT on free items
    //                     20/01/2012 DIT-715 #172 Modified workflow (+Rollback)
    //                                             Bugfix partial invoice and all item charges line discount 100% (incl. Free items)
    //                     24/01/2012 DIT-715 #172 Bugfix VAT on free items
    //                     24/02/2012 DIT-715 #211 (#172) Bugfix calculate Line Discount on normal item while splitting invoice
    //                     26/04/2012 DIT-715 #243 Loyalty functionnality
    //                                             Added function PostLoyaltyJnlLine()
    //                     23/05/2012 DIT-715 #345 Updated functions CreatePrepaymentLines() for all DIT item charges
    //                     18/06/2012 DIT-715 #243 Modified function PodyLoyaltyJnlLine() to convert Loyalty unit cost = 1 (locked)
    //                     02/07/2012 DIT-715 #243 Modified to call function Loyalty when unit value is zero
    // DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added to transfer fields into gen. journal line
    //                                               "DIT Sub-Contract Type","Service Contract No.","Service Contract Line No."
    //                                               "Contract Group Code","Service Contract Type"
    //                 AHU 16/08/2012 DIT-715 #392 Bugfix to transfer header contract fields into general journal
    //                                        #327 Added checking "Service contract No."
    //                 AHU 27/08/2012 DIT-715 #393 Added functions UpdateInvAssocContractDit()
    //                 AHU 27/08/2012 DIT-715 #426 Modified functions UpdateInvAssocContractDit()
    //                                             Added functions UpdateCrMAssocContractDit()
    //                 AHU 31/08/2012 DIT-715 #327 Bugfix to skip on "Document Type" for updating DIT Contracts
    //                                             Bugfix fields "Service Contract Type" when no GenJnlLine."Service Contract No."
    //                 AHU 03/09/2012 DIT-715 #426 Bugfix functions UpdateInvAssocContractDit() for updating DIT Contract Header
    //                                             Added message while posting DIT Contracts
    //                                             Added text constants Text2014310,Text2014311
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added splitting customer total (General Journal Line) per Item charge Type
    //                     07/12/2012 DIT-715 #370 Added fields "Split Deposit on" into Drink-it tab
    //                     17/12/2012 DIT-715 #430 Bugfix to calculate "Qty. to Assign" in item charge Tax sales lines (duty on shipment)
    //                     08/01/2013 DIT-715 #533 Skip EMCS on Combined Invoice documents
    //                 AHU 15/01/2013 DIT-715 #393 Bugfix function UpdateInvAssocContractDit()
    //                 DDR 18/01/2013 DIT-715 #370 Bugfix while filling the deposit into Item jnl line (bad Invoice No.)
    //                 AHU 22/01/2013 DIT-715 #393 Bugfix function UpdateInvAssocContractDit()
    //                 AHU 25/01/2013 DIT-715 #426 Modified function UpdateInvAssocContractDit()
    //                 DDR 27/02/2013 DIT-715 #556 (#370) Bugfix function DeleteHeader()
    //                 DDR 28/02/2013 DIT-715 #540 Bugfix function CopyAndCheckItemCharges() when posting from Whse
    //                 AHU 15/04/2013 DIT-715 #395 Renamed
    //                                                PostFromSalesCrMemo() - > PostFromSalesDocument()
    //                                                PostFromSalesCrMemoLine() -> PostFromSalesDocumentLine()
    //                                             Added periodic discount for Posted Invoice documents
    //                                             Added checking license to call disc/promo periodic
    // DITW16.00.00.43 DDR 03/05/2013 DIT-715 #634 Bugfix to transfer SSCC tracking lines to post Whse. shipment lines
    //                     13/05/2013 DIT-715 #606 Added field "Shipment Status" from Sales Header
    //                     14/05/2013 DIT-715 #605 Added check when "Sales Price Mandatory"
    //                 FBL 09/07/2013 DIT-715 #619 Don't check contract last invoice date when document is created manually (not in batch)
    //                                             Only check sales price mandatory when it's not linked to a DIT contract
    //                 FBL 10/07/2013 DIT-715 #620 Change check on contract line into check on contract header
    //                 DDR 13/08/2013 DIT-715 #720 Added check for EMCS on Sales order if ARC undo has been done
    //                 DDR 14/08/2013 DIT-715 #678 Added to calculate Deposit Amount into General Journal Line seperately
    //                                             Added using Sales setup field "Excl. Deposit Payment Discount"
    //                 DDR 21/08/2013 DIT-715 #678 Bugfix test to fill in the Deposit Amounts into General journal line
    //                 DDR 22/08/2013 DIT-715 #720 Bugfix lost salesheader while checking EMCS posted shipment
    //                 DDR 02/09/2013 DIT-715 #733 Added to call EMCS/EDI functions after receipts and return shipments
    //                 DDR 25/09/2013 DIT-715 #519 Upgrade calculation using "Tax Item No."
    //                 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    //   NORRIQ owm - Online Warehouse Management
    //                                               Copyright 2008 by NORRIQ A/S, www.norr1iq.dk
    //   - Added code to OnRun
    //   - Added several IF GUIALLOWED to be able to run from NAS
    //                 DDR 13/11/2013 DIT-715 #753 Bugfix missing "Service Contract Type" in Cust/Vendor entries
    //                 DDR 27/11/2013 DIT-715 #727 Modified Global variables array length
    //                                               TotalSalesLineChargeType,TotalSalesLineChargeTypeLCY,PostingNoCharge
    //                                               GenJnlLineDocNoCharge,GenJnlLineExtDocNoCharge,GenJnlLineDocTypeCharge
    //                 DDR 02/12/2013 DIT-715 #862 Bugfix to read tracking if SSCC only
    //                 DDR 10/12/2013 DIT-715 #865 Bugfix calculate item jnl quantity with Composed items
    //                 DDR 20/12/2013 DIT-715 #864 Bugfix to calculate "Unit Volume HL" with "Tax item no."
    //                 DDR 05/12/2013 DIT-715 #761 Bugfix extended sscc non-specific
    //                 DDR 20/01/2014 DIT-715 #882 Bugfix when use or not "Unit of Measure Code" on item charges
    //                 DDR 21/01/2014 DIT-715 #882 Bugfix sign of item charges
    //                 DDR 22/01/2014 DIT-715 #882 Bugfix qty base with use or not "Unit of Measure Code" on item charges
    //                                             Bugfix sign of discount amount on item charges
    //                 DDR 30/01/2014 DIT-715 #633 Bugfix Loyalty posting (cost not on ship)
    // DITW16.00.00.44 DDR 17/02/2014 DIT-715 #906 Bugfix to split item charges (giftbox) with item tracking lines
    //                                             Added correction DIT-770 #375
    // DITW16.00.00.44 DDR 28/03/2014 DIT-715 #915 Added more checking attached DIT item charges

    // FINXL7.00.001 RBE 20/03/2013 : Added code for filling in description on g/l sales line in g/l entry
    //                                Added code for hiding shipment message when posting invoice
    //                                Merge hotfix 2693133
    //                                OGM Funxtionality
    //                                Added permission on table 2029611
    //                                Post Intrastat from Saleslines with G/L Accounts
    //                                added code to show invoice no. after posting
    //                                keep orders after posting when everything is invoiced
    //                                no invoicing without sales order
    // FINXL8.00.001 BSA 07/05/2015 #158 : Fix added code to show invoice no. after posting

    // DITW16.00.00.45 DDR 27/10/2014 DIT-715 #941 Modified giftbox calc. "Unit Volume HL"

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 03/05/2013 DIT-715 #634
    //                  13/05/2013 DIT-715 #606
    //                  14/05/2013 DIT-715 #605
    //                  17/05/2013 DIT-770 #95 Added check when "Vessel Info. Mandatory"
    //                  04/06/2013 DIT-770 #99 Added fields "Ship-to Country/Region Code" for Item journal
    //                  04/07/2013 DIT-770 #88 Bugfix upgrade: Free item & VAT on Free
    //                  04/07/2013 DIT-770 #99 Removed fields "Ship-to Country/Region Code"
    //                  24/07/2013 DIT-770 #101 Added fields ItemJnlLine "Cust/Vendor DTax Group Code"
    //              DDR 13/08/2013 DIT-715 #720 merge
    //              DDR 19/08/2013 DIT-770 #101 Remove double field ItemJnlLine "Cust/Vendor DTax Group Code"
    //              DDR 19/08/2013 DIT-715 #678 merge
    //              DDR 20/08/2013 DIT-770 #95 Modified check on "Vessel Info. Code" (only mandatory Order Document type)
    //              DDR 21/08/2013 DIT-715 #678 merge
    //              DDR 22/08/2013 DIT-715 #720 merge
    //              DDR 28/08/2013 DIT-770 #178 Remove DIT-770 #95 #99 #101
    //              DDR 04/09/2013 DIT-715 #733 merge
    // DITW17.00.02 SR 09/09/2013 DIT-770 #135 : If "Payment Amount" filled in on doc. then only apply that amount and leave the rest open
    //                                         : Error regarding sign of applying cust. ledger entry
    // DITW17.00.02 AT  12/09/2013 DIT-770 #154
    //                             Added function InvoiceMethod to validate Invoice Method restrictions
    // DITW17.00.02 AT  24/09/2013 DIT-770 #132
    //                             Added code to flow Free Reason Code to Item Jnl Line
    // DITW17.00.02 DDR 01/10/2013 DIT-715 #519 Merge
    // DITW17.00.02 DDR 14/11/2013 DIT-715 #827 merge
    // DITW17.00.02 DDR 14/11/2013 DIT-770 #230 Added fields "DDiscount Level Position""DDiscount Include Tax","DDiscount Include Deposit"
    //                                            "DDiscount Include Discount"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 DDR 27/11/2013 DIT-715 #727 merge
    // DITW17.00.02 DDR 28/11/2013 DIT-770 #272 Upgrade N-OWM4.5 Nav2013 R1
    // DITW17.00.02 SR 10/25/2013 DIT-770 #159 : New code Added
    // DITW17.00.02 DDR 03/12/2013 DIT-715 #862 Merge
    // DITW17.00.02 AT  06/12/2013 DIT-770 #222 : If Post Inv. Line Desc. to G/L then Allow Line Description to G/L Entries
    // DITW17.00.02 DDR 10/12/2013 DIT-715 #865 merge
    // DITW17.00.02 SR 19/12/2013 DIT-770 #163 : New Code Added to Pass Posting Group
    // DITW17.00.02 DDR 20/12/2013 DIT-715 #864 merge
    // DITW17.00.02 DDR 08/01/2014 DIT-770 #307
    // DITW17.00.02 DDR 14/01/2014 DIT-715 #761 Merge
    // DITW17.00.02 DDR 21/01/2014 DIT-715 #882 Merge
    // DITW17.00.02 DDR 21/01/2014 DIT-715 #893 Merge
    // DITW17.00.02 DDR 23/01/2014 DIT-715 #882-893 Merge
    // DITW17.00.02 DDR 30/01/2014 DIT-715 #633 Merge (already solved)
    // DITW17.00.03 DDR 07/02/2014 DIT-770 #375 Bugfix qty base with "Unit of Measure Code" of item charges and incl. item tracking
    // DITW17.00.03 DDR 17/02/2014 DIT-715 #906 Merge
    // DITW17.00.03 DDR 17/03/2014 DIT-770 #553 OWM Scanning check Nav license
    // DITW17.00.03 DDR 28/03/2014 DIT-715 #915 Merge
    // DITW17.10.03 MSF 23/04/2014 DIT-770 #651 : Error when posting sales invoice from sales order on G/L description: BUG seen because of NL localisation
    // DITW17.10.03 DDR 05/05/2014 DIT-770 #619 Bugfix wrong GenJnlLine variable in function PostCustomerEntry()
    // DITW17.10.03 DDR 13/05/2014 DIT-770 #391 Upgrade errror standard Nav2013 R2
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #623 New Customer Exception Tax Group functionality
    //                                          Read "Cust Dtax Group Code" Sales lines
    // DITW17.10.03 MSF 28/05/2014 DIT-770 #715 Upgrade W1 Rollup 6 ChangeLog.W1.36366 file 474255
    // DITW17.10.05 DDR 19/08/2014 DIT-770 #776 Added Deposit point functionality
    // DITW17.10.05 WSA 02/09/2014 DIT-770 #626 Added control of payment amount
    // DITW17.10.05 MSF 10/10/2014 DIT-770 #921 Added RIMD table 6661 "Return Receipt Line"
    // DITW17.10.05 MSF 24/10/2014 DIT-770 #770 bufix function CopyAndCheckItemCharge() when tax duty point shipment and
    //                                           post invoice only (+ item line not shipped)
    //                                           Bugfix function CheckItemCharge() standard NAV2013
    // DITW17.10.05 DDR 29/10/2014 DIT-715 #941 merge
    // DITW17.10.05 WSA 31/10/2014 DIT-770 #185 Added code to support Loyalty Gain
    // DITW17.10.05 DDR 05/11/2014 DIT-770 #185 Code to support Loyalty Gain
    // DITW17.10.05 MSF 20/11/2014 DIT-770 #701 Added function GetLocationGroup
    //              MSF 21/11/2014 DIT-770 #701 Bug Fix
    //              MSF 26/11/2014 DIT-770 #701 Bug Fix
    //              MSF 08/12/2014 DIT-770 #701 Bug Fix
    //              MSF 11/12/2014 DIT-770 #701 Bug Fix
    // DITW17.10.05 DDR 15/12/2014 DIT-770 #770 Bug fix wrong assigned item charge quantity test
    // DITW17.10.05 MSF 05/01/2014 DIT-770 #537 Interest invoice should not bother when no Last invoice date
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW17.10.05 MSF 09/01/2015 DIT-770 #1145  The credit memo's are not applied to the open loan entry anymore
    // DITW17.10.05 DDR 20/01/2015 DIT-770 #581 Recalculate Deposit RoundUp/Down
    // DITW17.10.05 WSA 04/01/2015 DIT-770 #1210 Added code to fix check dimension on sell-to or bill-to depend on setup
    // DITW17.10.05 WSA 23/02/2015 DIT-770 #779 Added Code to update event lines qtys
    // DITW18.00.06 MSF 03/07/2013 DIT-770 #1230  Contract invoice next date check is wrong
    //                                            Change the check on  Contract Posting Date instead of order date
    // DITW18.00.06 MSF 03/07/2013 DIT-770 #1469 It is not possible to post a rent invoice when first period is a broken period.
    // DITW18.00.06 MSF 30/07/2015 DIT-770 #1513 Wrong Next invoice date when Setup multiple line in Contract
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Option DIT Contract, Service contract to Financial,Service
    //                                           Rename Field Service contract Type => Contract Type
    // DITW18.00.06 DDR 07/08/2015 DIT-770 #1368 Various adjustments
    // DITW18.00.06 WSA 26/10/2015 DIT-770 #1530 Adjust sign for loyalty in sales return Order
    // DITW18.00.06 DDR 20/10/2015 DIT-770 #1449 Added fields "Production BOM No.","Prod. BOM Version Code","BOM Line No.",
    //                                             "BOM Item No.","BOM Qty. per Unit of Measure"
    // DITW18.00.06 DDR 23/10/2015 DIT-770 #1395 Added Giftbox Other charges
    // DITW18.00.06 DDR 26/10/2015 DIT-770 #1412 Removed validation "Packaging Type Code"
    // DITW19.00.07 MVN 30/12/2015 DIT-770 #1740 TrackingQtyHandled removed in 2016
    //                                           Some variables were removed or set Local in 2016
    //                                           Upgrade functions CreateGLItemChargeRelation() for posting preview mode
    // DITW18.00.06A DDR 11/12/2015 DIT-770 #1678 Bugfix post item charge std. NAV
    // DITW18.00.06A DDR 15/12/2015 DIT-770 #1684 Bugfix item charge calculate on item journal with "Qty. per Unit of Measure" &"Item Charge Quantity per"
    // DITW18.00.06A DDR 08/01/2016 DIT-770 #1678 Bugfix post discount per order conflict giftbox
    // DITW18.00.07 DDR 11/01/2016 merge DIT-770 #1678 fob correction
    // DITW18.00.07 VSC 07/03/2016 DIT-770 #1066 Post Shipping Costs + New Functions PostShippingCosts and UpdatePostedShippingCost
    // DITW18.00.07 MVN 23/03/2016 DIT-770 #1918 Loyalty Points Calculation
    // DITW18.00.07 VSC 17/03/2016 DIT-770 #1228 Drop Shipment Post
    // DITW18.00.07 VSC 18/03/2016 DIT-770 #1228 Add Param to Function PostAssocItemJnlLine for posting Attached Lines
    // DITW18.00.07 AKH 28/03/2016 DIT-770 #1409 Made check on based on the "Ext. Doc. No. Mandatory" value in Customer card
    // DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    // DITW18.00.07 MVN 06/04/2016 DIT-770 #1883 Set Global Variable "GLEntryDesc" to Length 80
    // DITW18.00.07 MVN 08/04/2016 DIT-770 #1918 Added new Fields to PostLoyaltyJnlLine
    // DITW18.00.07 DDR 11/04/2016 DIT-770 #1488 Added to update route planning after partial posting
    // DITW18.00.07 VSC 13/04/2016 DIT-770 #1492 Fix merge error missing code
    // DITW18.00.07 DDR 25/04/2016 DIT-770 #1684 Bugfix remove deposit quantity recalculation while posting
    // DITW18.00.07 DDR 28/04/2016 DIT-770 #1488 Modified to recalculated posted document in Route Planning
    // DITW18.00.07 AKH 29/04/2016 DIT-770 #1346 Added code to handle calculation of delivery times in posted documents (lines)
    // DITW18.00.07 AKH 12/05/2016 DIT-770 #1346 Adjusted code : use of "Outstanding Qty. (Base)" instead of Quantity
    //                                                           Commented double code for calculation in shipment lines
    // DITW18.00.07 VSC 13/05/2016 DIT-770 #1915 Calculate actual Cubage and Weight
    // DITW18.00.07 AKH 20/05/2016 DIT-770 #1067 Added code for shipment staus change after shipment post
    // DITW18.00.07 DDR 30/05/2016 DIT-770 #642 Bugfix functions SumSalesLines2() with temporary header record
    // DITW18.00.07 VSC 02/06/2016 DIT-770 #1932 Calculate Actual "No. of Packages" based on Qty. to Ship.
    // DITW18.00.07 DDR 29/06/2016 DIT-770 #1228 Bugfix remove double call update charges
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields "Strength Spec. Code","Strength Spec. Value","Vol-Strength Spec. Code";"Vol-Strength Spec. Value"
    //                                                      Added functions DivideVolStrength()
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Removed "strength Spec. Value","vol-strength Spec. Value"
    //                                      Removed functions DivideVolStrength()
    // DITW19.00.08 AKH 07/12/2016 BL#9612 (DIT-770 #1754) Disabled check on "Shipment Date" of Sales Lines against Contract Lines
    //                                                     Adjusted code for Contract Header and Lines update

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 20/02/2017 NRQ#21523 Upgrade error functions TestLineShpRcvTaxMandatory, TestLineInvTaxMandatory, PostItemJnlLineItemCharges, CopyAndCheckItemCharge
    //                                        Upgrade error workflow & variables RequestSplitChargeType,RequestDutyPoint_
    // DITW110.00.08 DDR 27/02/2017 NRQ#22601 Bugfix hidden deposit item charge splitted on posted invoice document
    // DITW110.00.08 DDR 02/03/2017 NRQ#22858 Upgrade error functions TestLineTaxArcMandatory()
    // DITW110.00.08 DDR 02/03/2017 NRQ#22895 Upgrade missing "shipment status" on lines after posting (if 'Return completed' value)
    // DITW110.00.08 DDR 03/03/2017 NRQ#22865 Upgrade error functions PostItemChargePerOrder()
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // DITW110.00.09 DDR 22/03/2017 NRQ#9661 Fix EMCS multi-shipments

    // FINXL10.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL9.00.000.01 ACH 10/01/2017 : Recycle charge functionnalities
    // FINXL10.00 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL10.00 AKH 20/01/2017 Adjusted code after upgrade
    // IPLXL10.00 AKH 24/03/2017 NRQ#0 Created function HandleEDIMessages()
    // FINXL10.00 AKH 24/03/2017 NRQ#0 Made variable CurrExchRate local in function PostIntrastatLine()
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4

    // DITW110.00.09 DDR 05/04/2017 NRQ#25340 Fix function CheckAttachedItemCharges() for warehouse & inventory pick/putaway
    // DITW110.00.09 YHE 13/04/2017 NRQ#13619 post neg qty in sales line with whse "Whse ship mandatory", "Whse receive not mandatory"
    // DITW110.00.09 DDR 14/04/2017 NRQ#13065 Fix EMCS multi-Return shipments
    // DITW110.00.09 DDR 14/04/2017 NRQ#9661 Fix EMCS multi-shipments
    // DITW110.00.09 YHE 19/04/2017 NRQ#13131 Fix sign for "Deposit Amount" and  "Deposit Amount (LCY)"
    // DITW110.00.10 DDR 02/05/2017 NRQ#10450 Drop Shipment switched on main posting flow (disabled secondary flow)
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 DDR 14/06/2017 NRQ#10450 Fix the wrong test activation in function TestTaxShippingAgent()
    // DITW110.00.10 MSF 16/06/2017 NRQ#13173 Value entry of deposit isn't created when invoicing an item line composed of more than one lot no.
    // DITW110.00.10 DDR 30/06/2017 NRQ#10450 Fix multi drop purchase orders
    // DITW110.00.10 MSF 18/07/2017 NRQ#16224  Enable Posting Linked Return Oder by Setup
    // DITW110.00.10 DDR 20/07/2017 NRQ#13173 Impossible to delete Sales order after posting Sales invoice
    // DITW110.00.10 MSF 20/07/2017 NRQ#33039 Fix deposits & taxes (line discount%) don't post GL entry anymore
    // DITW110.00.10 DDR 26/07/2017 NRQ#33039 Update Fix
    // DITW110.00.10 AKH 28/07/2017 NRQ#17189 Added Payment Method Code to function GetPaymentChargeType()
    // DITW110.00.11 SFI 30/08/2017 BL#14417 Added changes for deposit valuation
    // DITW110.00.11 DDR 08/09/2017 NRQ#36849 Fix upgrade'17 missing checking item charge function CopyAndCheckItemCharge()
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Obsolete Code Deleted
    // DITW110.00.11 DDR 05/10/2017 NRQ#22843 Fix move call of function PostShippingCosts()
    // DITW110.00.11 DDR 09/10/2017 NRQ#22843 Fix move call of function PostShippingCosts()
    // DITW110.00.11 DDR 03/10/2017 NRQ#20081 Fix missing "Contract Posting Date" to update contract header "Last Invoice Date"
    // DITW110.00.11 VSC 27/11/2017 NRQ#33755 Handle Backorders - License Issue
    // DITW110.00.12 MSF 26/03/2018 NRQ#64208 Transfer Return Registration control lignes to Posted return registration Control
    // DITW110.00.12 MSF 27/03/2018 NRQ#64208 Modified parameters  MovetoPostedReturnRegisterControl
    // DITW110.00.12A MSF 04/07/2018 NRQ#75686 Invoice and credit memo with entry application may give error
    //                                         Added Function CheckIsEntryToApply
    // DITW110.00.12A MSF 05/07/2018 NRQ#75686 Apply Entries depend on one field in General ledger Setup
    // DITW110.00.12A DDR 02/08/2018 NRQ#75686 Fix/review Invoice and credit memo customer application combination "Appln. per Charge Type" (G/L setup) & "Allow Split Deposit per" (Sales Setup)
    // DITW111.00.13 VSC 06/11/2018 NRQ#87436 Update Completely Shipped And Shipment status

    // HEI.01 FDD-KDDOTCGAP003 IBM ISYED01 10.10.2017
    //   #added code to check the RPM to the Sales line.
    // DITW110.00.11 VSC 09/10/2017 NRQ#33755 Handle Backorders
    // HEI.02 FDD-KDD0TC005 IBM NASTAA02 9.11.2017 # RPM Billing and Reporting
    //   # New functions created to post the Return Order together with the Sales Order
    // HEI.03 FDD-KDD0TC001 IBM HORTOC01 15.11.2017 #code added
    // FCE 01 09/01/2018- Hotfix to get the Warehouse Shipment posted
    // HEI.04 FDD-SLSGAP014 IBM NASTAA02 16.04.2018 # Customer Blocked for Option 'Ship'
    //   # Used function "CheckBlockedCustOnDocs2" instead of "CheckBlockedCustOnDocs" to check if a Customer is blocked
    // HEI.05 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Code added for checking mandatory gate entry
    //   # Added code for updating posted Gate Entry Details
    // HEI.06 Bugfix INC0047982 RW IBM HORTOC01 22.11.2018 # code commented to not overwrite the doc type and doc no on whse posting
    // HEI.07 RPM Breakages IBM ISYED01 03.18.2019.
    //   #added new functions to support RPM Breakages DeleteCustDifflineafterPostingWhse, MoveCustDiffLines.
    // HEI.08 FDD-HT658 IBM.GUNERE01 02.09.2019 # PostShippingCosts func. modified
    //                               01.10.2019 # InsertReturnReceiptHeader func. modified
    //                               21.10.2019 # PostShippingCosts func. modified
    // HEI.09 FDD-HT581 SURYAS01 IBM 27.09.2019
    //   #Added Code in "FillInvoicePostingBuffer" Function
    // HEI.10 FDD-HT88 IBM BULIMC01 13.11.2019 #new change in the code for RPM Breakages
    // DITW111.00.13 DDR 11/12/2018 NRQ#35372 Fix "Allow VAT Calculation (Free)" (Upgrade Nav2013)
    // DITW111.00.13A DDR 24/06/2019 NRQ#113530 Fix wrong double insert with promotion having attached item charges in function CheckAttachedItemCharges()
    // DITW111.00.13A DDR 02/07/2019 NRQ#113530 Fix find error in function CheckAttachedItemCharges()
    // DITW111.00.13A MSF 27/11/2019 NRQ#117628  Change Function Call For IC webservice to avoid the commit recaords
    // HEI.11 CHG2039144 FDD-HT949 IBM.GUNERE01 29.11.2019 # GetWarehouseSetup, CalcTotalPerUOMShippingCosts funcs. added
    // DITW113.00.15 DDR 04/10/2019 NRQ#10495 Rename Loyalty 'Cost' -> 'Amount' (all fields)
    // DITW113.00.15 DDR 10/10/2019 NRQ#10495 Fix sign with Loyalty point to post loyalty journal
    //                                        Remove call function ConvertUnitCost1()
    // DITW113.00.15 DDR 11/10/2019 NRQ#120300 Fix partial Loyalty posting
    // HEI.12 FDD-HB1111 IBM NASTAA02 28.02.2020 # Adding Fields to existing Tables - Sales Reports enhancements
    //   # Code added on function "PostSalesLine" to update the value of "Shipping Agent Code" and "Shipping Agent Service Code"
    // DITW113.00.15 MSF 02/04/2019 NRQ#117628 Added Control on Document Type
    // DITW114.00.15 MSF 12/05/2020 NRQ#143673 Added Condition To Skip Preview Mode
    // DITW114.00.15 MSF 21/05/20 NRQ#117628 Split Function FctPostDoc in two
    // HEI.14 CHG2059200 IBM SAMANR01 04.22.2020
    //   #  Flow the "Free Reason Code" field value to "Loyalty Ledger Entry" Table
    // HEI.15 CHG2069113 IBM.GUNERE01 18.06.2020 #PostShippingCosts, CalcTotalPerUOMShippingCosts funcs modified
    // DITW111.00.13A AKH 25/06/2019 NRQ#110114 Added function HasBackorder()
    //                                          Adjusted code to include charge lines attached to a backorder item line in the posting check
    // HEI.16 CHG2089373 IBM SAMANR01 07.12.2020
    //   # Add code to change the due date calculation on posting date from document date
    // HEI.17 FDD-HB1880 CHG2089830 IBM NASTAA02 23.12.2020 # Fix Invoice Creation Date
    //   # Code added to update "Creation Date/Time" on posted documents
    // HEI.18 FDD-HB899 - CHG2093015 IBM NASTAA02  20.01.2021 # LSR - Sales And Payments
    //   # Code added on function "PostResJnlLine"
    // CHG2104608: DITW111.00.13 ISL 18/12/2018 NRQ#96024 Updated code (Deleted field "Prod. BOM Version Code")
    // NRQ#117628 17/02/2021 Wrong check in IC partner
    // HEI.20 CHG2100218 IBM SAXENA03 25.03.2021
    //   # Replaced SalesShptLine.FINDSET with SalesShptLine.FINDSET(FALSE,FALSE) in PostItemTracking().
    // NRQ#177003 DDR 29/03/2021 Add "Tax Due Posting to G/L" to post discount item charge like tax
    // HEI.21 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # Code added on Functions "DivideAmount", "FillInvoicePostingBuffer", "SumSalesLinesTemp"
    // HEI.22 CHG2119178 IBM.AS 30.06.2021
    //   # HeiLite Base Stability Changes for Posting functions at JOB NAS
    //   # Adding GUIAllowed function added in Functions CheckItemReservDisruption(),
    //   SendPostedDocumentRecord(),
    //   TestLineTariffNoMandatory(),
    //   PostAssocReturnOrders(),
    //   ShowPostedDocumentInfo() for JOB Execution to avoid any manual intervention
    // HEI.23 FDD-HB2376 - CHG2117381 IBM GAVANM01 27.09.2021 # Tolerance automatic application Panama
    //   #new function created: CheckPayTolerance, CallPmtTolWarning
    //   #code added in OnRun() section
    //   #global var PmtTolAmtToBeApplied
    // HEI.24 CHG2132399 INC3707788 IBM GAVANM01 20.10.2021 # Auto Sales give system error BrewCo
    //   # code added
    // HEI.25 INC4035415 - CHG2152991 IBM NASTAA02 31.03.2022 # Problem with a sales return order
    //   # Added ABS in the conditions from 'FillInvoicePostingBuffer' Function
    // HEI.26 CHG2117381 HB2376 IBM BHANDS01 25.11.2022 # Tolerance Payment Application Panama
    //   # Code added in function CheckPayTolerance
    // HEI.27 CHG2117381 HB2376 IBM BHANDS01 05.12.2022 # Tolerance Payment Application Panama
    //   # Code commented from OnRun() and added in function CheckAndUpdate()
    //   # Code added in function CheckPayTolerance()
    // HEI.28 CHG2117381 HB2376 IBM DEBUSD01 12.12.2022 # Tolerance Payment Application Panama
    //   # Fix calculation tolerance - getsalesline parameter 1
    // DITW114.00.15 DDR 24/04/2020 NRQ#102424 Fix skip checking discount(order) & promotion quantity Ship/Receive/Return/Invoice
    // DITW114.00.15 DDR 05/05/2020 NRQ#102424 Fix promotion checking with partial quantity Ship/Receive/Return/Invoice
    // HEI.29 CHG2188015 DEBUSD01 10.01.2023 Qty to Ship behavior on promotionline partialShipments
    //   # merge NRQ#102424
    // HEI.30 CHG2131424 IBM SISUM01 01/05/2023 HB2520 Dimension Validation HeiLite
    //   # Code change skip dimension combination validation only for Sales and if setup is TRUE
    // HEI.31 CHG2244491 IBM COSTES02 12/11/2024 Gate Control relation to having Zone and Bin Codes mandator
    //   # update condition from IsSalesGateEntryMandatory
    // HEI.32 CHG2282709 IBM COSTES02 03.03.2025 Gate Control relation to having Zone and Bin Codes mandator
    //   # update condition from IsSalesGateEntryMandatory
    // HEI.33 CHG2302652 IBM COSTES04 07.05.2025 Excluding Sales Invoice and Sales Credit Memo to the Change
    //   # skip gate control

    // BC Upgrade SHUKLP03 >>

    // Check codeunit 815 "Sales Post Invoice" to find procedure FillInvoicePostingBuffer() code because code shifted in 815 codeunit's procedure PrepareLine(). 

    // BC Upgrade SHUKLP03 >>
    // Subscribed event OnBeforeCheckHeaderShippingAdvice to add HEI.01 Code of procedure CheckAndUpdate().
    // NAIKH01 Fiscal printer => code of OnRun() is not added because reports called inside this code is highlighted with orange color.
    // HEI.03 => local procedure PostItemChargePerOrder() code is not because DIT has added one new parameter 'pblnIsDutyPoint'.
    // HEI.07 => Subscribed event OnAfterPostSalesDoc to add code of OnRun trigger also procedures MoveCustDiffLines() and DeleteCustDifflineafterPostingWhse. 
    // HEI.12 => Subscribed event OnBeforeSalesCrMemoLineInsert to add code of procedure PostSalesLine().
    // HEI.18 => Subscribed event OnAfterFinalizePostingOnBeforeCommit in codeunit InterfacePurchCode of interface extension to add code.
    // HEI.24 => local procedure FinalizePosting() code is not added because code is written between DIT tag. This code is for intercompany which needs to be taken in the Gap fit process.
    // HEI.21,HEI.25 => Procedure FillInvoicePostingBuffer(), RoundAmount(),IncrAmount() and SumSalesLinesTemp() code did not add because CAD functionality is used for execution of code.
    // HEI.09 => LOCAL procedure FillInvoicePostingBuffer code is not added because code is written between DIT tag.
    // HEI.21=> Procedure DivideAmount code is not added because CAD functionality is used for execution of code and also DIT has added one new parameter 'pblnCalcPriceBack'.
    // HEI.27 => Subscribed event OnBeforeCheckPostRestrictions to add code of trigger CheckAndUpdate also procedures CheckPayTolerance() and CallPmtTolWarning().
    // HEI.22 => It's not necessary to add GUIALLOWED code in the procedures CheckItemReservDisruption() and SendPostedDocumentRecord() because Business Central (BC) has replaced the Confirm function with ConfirmManagement.GetResponseOrDefault(), which works similarly to GUIALLOWED.
    // HEI.20 => procedure PostItemTracking() code is not added because not needed. 
    // HEI.22 => The code for the procedure PostAssocReturnOrders() is not being added because it is a DIT Procedure.
    // HEI.16 => The code for the procedure GetPaymentChargeType() is not being added because it is a DIT Procedure.
    // HEI.14 => The code for the procedure PostLoyaltyJnlLine() is not being added because it is a DIT Procedure.
    // HEI.02 => The code for the procedure InsertInvoiceHeader() is not being added because dependency on DIT field "Link Sales Document No.".
    // HEI.11, HEI.15, HEI.08 => The code for the procedures PostShippingCosts() and UpdatePostedShippingCost() is not being added because they are DIT Procedures.
    // HEI.22 => The code for the procedures TestLineTariffNoMandatory() and ShowPostedDocumentInfo() is not being added because code is written between DIT code.
    // HEI.11 => The code for the procedure CalcTotalPerUOMShippingCosts is added but blocked because DIT table "Posted Document Shipping Cost" is used as Parameter.
    // HEI.30 => Subscribed event OnBeforeCheckSalesDim to add code of Procedure CheckDimCombHeader() and CheckDimCombHeader(), Procedure name CheckSalesDim() in codeunit 80 and created in codeunit "Check Dimensions" in BC.
    // Procedures Added => IsSalesGateEntryMandatory(), CalcTotalPerUOMShippingCosts(), CheckPayTolerance(), CallPmtTolWarning(), MoveCustDiffLines(). DeleteCustDifflineafterPostingWhse(), SetupLinkedSalesDocNo(), UpdateOutboundGateEntry(), UpdateInboundGateEntry(), CheckDocumentType(), CheckSalesDimLines(), CheckSalesDimValuePostingHeader(),CheckSalesDimCombHeader(), GetWarehouseSetup(), CheckSalesDimCombLine(), CheckSalesDimValuePostingLine().
    // Event Added => OnCheckCustBlockageOnAfterTempLinesSetFilters, OnCheckSalesDimLinesOnAfterCalcShouldCheckDimensions, OnCheckDimValuePostingOnAfterCreateDimTableIDs.
    // Blocked Nav Procedures UpdateInboundGateEntry() and UpdateOutboundGateEntry(), created new procedures with same name and necessary parameters to replace LocationCode parameter with SalesShptHeader record and ReturnRcptHeader record parameter.
    // BC Upgrade SHUKLP03 <<
    //BC UPGRADE KUMARR78 >>
    // Changing for (FDD OTC 091)
    //Blocking ResetTempLines Function in OnBeforeCheckCustBlockage As creating Error while Sales Posting.
    //BC UPGARDE KUMARR78 <<

    // BC Upgrade SHUKLP03 >> OTC008 Testscript => Rewrite code for ResetTempLines Function in OnBeforeCheckCustBlockage because blocking will not work in case of job queue.

    var
        WarehouseSetup: Record "Warehouse Setup";
        WarehouseSetupGot: Boolean;
        ErrorMessageMgt: Codeunit "Error Message Management";
        DimMgt: Codeunit DimensionManagement;

        DimensionIsBlockedErr: Label 'The combination of dimensions used in %1 %2 is blocked', Comment = '%1 = Document Type, %2 = Document No, %3 = Error text';
        LineDimensionBlockedErr: Label 'The combination of dimensions used in %1 %2, line no. %3 is blocked', Comment = '%1 = Document Type, %2 = Document No, %3 = LineNo., %4 = Error text';
        InvalidDimensionsErr: Label 'The dimensions used in %1 %2 are invalid', Comment = '%1 = Document Type, %2 = Document No, %3 = Error text';
        LineInvalidDimensionsErr: Label 'The dimensions used in %1 %2, line no. %3 are invalid', Comment = '%1 = Document Type, %2 = Document No, %3 = LineNo., %4 = Error text';


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostSalesDoc, '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; SalesCrMemoHdrNo: Code[20]; SalesInvHdrNo: Code[20]; RetRcpHdrNo: Code[20])
    var
        ReturnRcptHeader: Record "Return Receipt Header";  // BC Upgrade SHUKLP03 << 
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";  // BC Upgrade SHUKLP03 << 
    begin
        // BC Upgrade SHUKLP03 >> Added code to get record.
        If RetRcpHdrNo <> '' then
            ReturnRcptHeader.Get(RetRcpHdrNo);

        IF SalesCrMemoHdrNo <> '' THEN
            SalesCrMemoHeader.Get(SalesCrMemoHdrNo);
        // BC Upgrade SHUKLP03 << Added code to get record.

        //HEI.07>>
        MoveCustDiffLines(SalesHeader, ReturnRcptHeader, SalesCrMemoHeader);
        //HEI.07<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeCalcInvoice, '', false, false)]
    local procedure OnBeforeCalcInvoice(SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var NewInvoice: Boolean; var TempSalesLineGlobal: Record "Sales Line" temporary)
    begin
        //HEI.27>>
        IF SalesHeader.Invoice THEN
            CheckPayTolerance(SalesHeader, TempSalesLineGlobal); //BC UPGRADE KUMARR78 ++
        //HEI.27<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeCheckHeaderShippingAdvice, '', false, false)]
    local procedure OnBeforeCheckHeaderShippingAdvice(SalesHeader: Record "Sales Header")
    var
        HeinekenGlobal: Codeunit "Heineken Global";
    begin
        //HEI.01>>
        HeinekenGlobal.CheckRPMReturns(SalesHeader);
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeSalesCrMemoLineInsert, '', false, false)]
    local procedure OnBeforeSalesCrMemoLineInsert(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesLine: Record "Sales Line")
    begin
        //HEI.12>>
        SalesCrMemoLine."Shipping Agent Code FND" := SalesLine."Shipping Agent Code";
        SalesCrMemoLine."Shipping Agent Service Cod FND" := SalesLine."Shipping Agent Service Code";
        //HEI.12<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Check Dimensions", OnBeforeCheckSalesDim, '', false, false)]
    local procedure OnBeforeCheckSalesDim(SalesHeader: Record "Sales Header"; var TempSalesLine: Record "Sales Line" temporary; var IsHandled: Boolean)
    var
        TempSalesLineLocal: Record "Sales Line" temporary;
        DimMgt: Codeunit DimensionManagement;
        SalesSetup: Record "Sales & Receivables Setup"; // BC Upgrade SHUKLP03 <<
    begin

        DimMgt.SetCollectErrorsMode();

        SalesSetup.Get();
        IF (SalesSetup."Dim. Comb. Not Appl. FND" = FALSE) THEN //HEI.30
            CheckSalesDimCombHeader(SalesHeader);

        CheckSalesDimValuePostingHeader(SalesHeader);

        TempSalesLineLocal.Copy(TempSalesLine, true);
        CheckSalesDimLines(SalesHeader, TempSalesLineLocal);

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeCheckCustBlockage, '', false, false)]
    local procedure OnBeforeCheckCustBlockage(SalesHeader: Record "Sales Header"; CustCode: Code[20]; var ExecuteDocCheck: Boolean; var IsHandled: Boolean; var TempSalesLine: Record "Sales Line" temporary)
    var
        Cust: Record Customer;
        SalesPostCU: Codeunit "Sales-Post";
        TempSalesLineLocal: Record "Sales Line" temporary; // BC Upgrade SHUKLP03 << OTC008 Testscript
    begin
        Cust.Get(CustCode);
        if SalesHeader.Receive then
            //Cust.CheckBlockedCustOnDocs(Cust, SalesHeader."Document Type", false, true)  //HEI.04
                Cust.CheckBlockedCustOnDocs2(Cust, SalesHeader."Document Type", FALSE, TRUE, 0, TRUE, FALSE, FALSE) //HEI.04
        else
            if SalesHeader.Ship and CheckDocumentType(SalesHeader, ExecuteDocCheck) then begin
                // BC Upgrade SHUKLP03 >> OTC008 Testscript
                SalesPostCU.ResetTempLines(TempSalesLineLocal);
                TempSalesLineLocal.SetFilter("Qty. to Ship", '<>0');
                TempSalesLineLocal.SetRange("Shipment No.", '');
                OnCheckCustBlockageOnAfterTempLinesSetFilters(SalesHeader, TempSalesLineLocal);
                if not TempSalesLineLocal.IsEmpty() then
                    // BC Upgrade SHUKLP03 << OTC008 Testscript
                    //Cust.CheckBlockedCustOnDocs(Cust, SalesHeader."Document Type", true, true);  //HEI.04
                    Cust.CheckBlockedCustOnDocs2(Cust, SalesHeader."Document Type", FALSE, TRUE, 0, TRUE, SalesHeader.Ship, SalesHeader.Invoice) //HEI.04
            end else
                //Cust.CheckBlockedCustOnDocs(Cust, SalesHeader."Document Type", false, true);  //HEI.04
                Cust.CheckBlockedCustOnDocs2(Cust, SalesHeader."Document Type", FALSE, TRUE, 0, TRUE, FALSE, FALSE); //HEI.04
        IsHandled := true;

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeSalesShptHeaderInsert, '', false, false)]
    local procedure OnBeforeSalesShptHeaderInsert(WhseShip: Boolean; WhseReceive: Boolean; var SalesShptHeader: Record "Sales Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary)
    begin
        //HEI.05>>
        IF WhseShip THEN
            SalesShptHeader."Gate Entry No. FND" := TempWhseShptHeader."Gate Entry No. FND"
        ELSE
            IF WhseReceive THEN
                SalesShptHeader."Gate Entry No. FND" := TempWhseRcptHeader."Gate Entry No. FND";
        //HEI.05<<

        //SalesShptHeader."Creation Date/Time" := CREATEDATETIME(TODAY, TIME); //HEI.17  // BC Upgrade SHUKLP03 << Blocked DIT field "Creation Date/Time".
        SalesShptHeader.SystemCreatedAt := CREATEDATETIME(TODAY, TIME);   // BC Upgrade SHUKLP03 << Replaced "Creation Date/Time" with SystemCreatedAt.
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeReturnRcptHeaderInsert, '', false, false)]
    local procedure OnBeforeReturnRcptHeaderInsert(WhseReceive: Boolean; WhseShip: Boolean; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; var ReturnRcptHeader: Record "Return Receipt Header"; SalesHeader: Record "Sales Header")
    begin
        //HEI.05>>
        IF WhseShip THEN
            ReturnRcptHeader."Gate Entry No. FND" := TempWhseShptHeader."Gate Entry No. FND"
        ELSE IF WhseReceive THEN
            ReturnRcptHeader."Gate Entry No. FND" := TempWhseRcptHeader."Gate Entry No. FND";
        //HEI.05<<
        ReturnRcptHeader."Ship Agent Service Code FND" := SalesHeader."Shipping Agent Service Code"; //HEI.08 FDD-HT658 IBM.GUNERE01 01.10.2019
        //ReturnRcptHeader."Creation Date/Time" := CREATEDATETIME(TODAY, TIME); //HEI.17  // BC Upgrade SHUKLP03 << Blocked DIT field "Creation Date/Time".
        ReturnRcptHeader.SystemCreatedAt := CREATEDATETIME(TODAY, TIME);   // BC Upgrade SHUKLP03 << Replaced "Creation Date/Time" with SystemCreatedAt.

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeSalesInvHeaderInsert, '', false, false)]
    local procedure OnBeforeSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header")
    begin
        //SalesInvHeader."Creation Date/Time" := CREATEDATETIME(TODAY, TIME); //HEI.17  // BC Upgrade SHUKLP03 << Blocked DIT field "Creation Date/Time".
        SalesInvHeader.SystemCreatedAt := CREATEDATETIME(TODAY, TIME);   // BC Upgrade SHUKLP03 << Replaced "Creation Date/Time" with SystemCreatedAt.
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeSalesCrMemoHeaderInsert, '', false, false)]
    local procedure OnBeforeSalesCrMemoHeaderInsert(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        //SalesCrMemoHeader."Creation Date/Time" := CREATEDATETIME(TODAY, TIME); //HEI.17  // BC Upgrade SHUKLP03 << Blocked DIT field "Creation Date/Time".
        SalesCrMemoHeader.SystemCreatedAt := CREATEDATETIME(TODAY, TIME); //HEI.17  // BC Upgrade SHUKLP03 << Replaced "Creation Date/Time" with SystemCreatedAt.

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterSalesShptLineInsert, '', false, false)]
    local procedure OnAfterSalesShptLineInsert(SalesShptHeader: Record "Sales Shipment Header"; WhseReceive: Boolean; WhseShip: Boolean; var SalesShipmentLine: Record "Sales Shipment Line"; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary)
    var
        GateEntryLoc: Code[20];
        GateEntryZone: Code[20];
    begin
        //HEI.05>>
        GateEntryLoc := SalesShptHeader."Location Code";
        IF WhseShip THEN BEGIN
            GateEntryLoc := TempWhseShptHeader."Location Code";
            GateEntryZone := TempWhseShptHeader."Zone Code";
        END ELSE IF WhseReceive THEN BEGIN
            GateEntryLoc := TempWhseRcptHeader."Location Code";
            GateEntryZone := TempWhseRcptHeader."Zone Code";
        END;

        IF WhseShip OR WhseReceive THEN//HEI.33
            IF IsSalesGateEntryMandatory(GateEntryLoc, GateEntryZone) THEN BEGIN
                SalesShptHeader.TESTFIELD("Gate Entry No. FND");
                SalesShipmentLine."Gate Entry No. FND" := SalesShptHeader."Gate Entry No. FND";
                // SalesShipmentLine.Modify(false);      // BC Upgrade SHUKLP03 << Added modify code to update record with "Gate Entry No.".//BC UPGRADE KUMARR78 FDD-MTC-007

                //HEI.33>>
                //IF WhseShip OR WhseReceive THEN
                //HEI.33<<
                // UpdateOutboundGateEntry(SalesShipmentLine."Gate Entry No. FND", SalesShipmentLine.Quantity, SalesShipmentLine."No.", SalesShipmentLine.Weight,  // BC Upgrade SHUKLP03 << Blocked because of DIT field Weight and also changed parameted from SalesShptHeader."Location Code" to SalesShptHeader..
                //                         SalesShipmentLine."Unit of Measure Code", SalesShptHeader);
                UpdateOutboundGateEntry(SalesShipmentLine."Gate Entry No. FND", SalesShipmentLine.Quantity, SalesShipmentLine."No.", 0,  // BC Upgrade SHUKLP03 << For now passed 0 in parameter because of blocking DIT field Weight will change once this field will add and also changed parameted from SalesShptHeader."Location Code" to SalesShptHeader.
                        SalesShipmentLine."Unit of Measure Code", SalesShptHeader);

            END;
        //HEI.05<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterReturnRcptLineInsert, '', false, false)]
    local procedure OnAfterReturnRcptLineInsert(WhseReceive: Boolean; WhseShip: Boolean; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; ReturnRcptHeader: Record "Return Receipt Header"; var ReturnRcptLine: Record "Return Receipt Line")
    var
        GateEntryLoc: Code[20];
        GateEntryZone: Code[20];
    begin
        //HEI.05>>
        GateEntryLoc := ReturnRcptHeader."Location Code";
        IF WhseShip THEN BEGIN
            GateEntryLoc := TempWhseShptHeader."Location Code";
            GateEntryZone := TempWhseShptHeader."Zone Code";
        END ELSE IF WhseReceive THEN BEGIN
            GateEntryLoc := TempWhseRcptHeader."Location Code";
            GateEntryZone := TempWhseRcptHeader."Zone Code";
        END;

        IF ReturnRcptLine.Quantity > 0 THEN
            IF WhseShip OR WhseReceive THEN//HEI.33
                IF IsSalesGateEntryMandatory(GateEntryLoc, GateEntryZone) THEN BEGIN
                    ReturnRcptHeader.TESTFIELD("Gate Entry No. FND");
                    ReturnRcptLine."Gate Entry No. FND" := ReturnRcptHeader."Gate Entry No. FND";
                    // ReturnRcptLine.Modify(False);        // BC Upgrade SHUKLP03 << Added modify code to update record with "Gate Entry No.".//BC UPGRADE KUMARR78 FDD-MTC-007
                    //HEI.33>>
                    //IF WhseShip OR WhseReceive THEN
                    //HEI.33<<
                    // UpdateInboundGateEntry(ReturnRcptLine."Gate Entry No. FND", ReturnRcptLine.Quantity, ReturnRcptLine."No.",    // BC Upgrade SHUKLP03 << Blocked because of DIT field Weight and also changed parameted from ReturnRcptHeader."Location Code" to ReturnRcptHeader.
                    //                         ReturnRcptLine.Weight, ReturnRcptLine."Unit of Measure Code", ReturnRcptHeader);

                    UpdateInboundGateEntry(ReturnRcptLine."Gate Entry No. FND", ReturnRcptLine.Quantity, ReturnRcptLine."No.", ReturnRcptLine."Gross Weight 1 101FDW", ReturnRcptLine."Unit of Measure Code", ReturnRcptHeader);
                    //BC UPGRADE KUMARR78 FDD-MTC-007 ++

                END;
        //HEI.05<<
    end;

    procedure IsSalesGateEntryMandatory(LocationCode: Code[20]; ZoneCode: Code[20]): Boolean
    var
        Location: Record Location;
        Zone: Record Zone;
    begin
        //HEI.05>>
        //HEI.31>>
        //IF Location.GET(LocationCode) AND Zone.GET(LocationCode,ZoneCode) THEN BEGIN
        //HEI.32>>
        //IF Location.GET(LocationCode) OR Zone.GET(LocationCode,ZoneCode) THEN BEGIN
        //IF Location."Sales Gate Entry Mandatory" OR Zone."Sales Gate Entry Mandatory" THEN
        IF (ZoneCode <> '') AND Zone.GET(LocationCode, ZoneCode) THEN
            EXIT(Zone."Sales Gate Entry Mandatory FND");

        IF Location.GET(LocationCode) THEN BEGIN
            IF Location."Sales Gate Entry Mandatory FND" THEN
                //HEI.32<<
                //HEI.31<<
                EXIT(TRUE)
            ELSE
                EXIT(FALSE);
        END ELSE
            EXIT(FALSE);
        //HEI.05<<
    end;

    // LOCAL procedure CheckPayTolerance(SalesH: Record "Sales Header)//BC UPGRADE KUMARR78 --11-05-2026
    LOCAL procedure CheckPayTolerance(SalesH: Record "Sales Header"; TempSalesL: Record "Sales Line") //BC UPGRADE KUMARR78 ++11-05-2026
    var
        Customer: Record Customer;
        AppliedCustLedgEntry: Record "Cust. Ledger Entry";
        ApplyingAmount: Decimal;
        AmounttoApply: Decimal;
        MaxPmtTolAmount: Decimal;
        AppliedAmount: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        NewPmtTolAmtToBeApplied: Decimal;
        SalesPost: Codeunit "Sales-Post";
        // TempSalesL: Record "Sales Line";//BC UPGRADE KUMARR78 --11-05-2026
        PmtTolAmtToBeApplied: Decimal;
        Currency: Record Currency;  // BC Upgrade SHUKLP03 <<
        GLSetup: Record "General Ledger Setup"; // BC Upgrade SHUKLP03 <<
        GenJnlPostLine: Codeunit "Gen Jnl Post Line CU CBN"; // BC Upgrade SHUKLP03 <<
    begin
        //HEI.23<<
        IF (SalesH."Applies-to Doc. No." <> '') AND (SalesH."Applies-to Doc. Type" = SalesH."Applies-to Doc. Type"::Payment) THEN BEGIN
            MaxPmtTolAmount := 0;
            ApplyingAmount := 0;
            AmounttoApply := 0;
            //HEI.26>>
            AppliedAmount := 0;
            PmtTolAmtToBeApplied := 0;
            NewPmtTolAmtToBeApplied := 0;
            //HEI.26<<

            //HEI.27>>
            //  SalesH.SETFILTER("Item Charge Type Filter",'<>%1',SalesH."Item Charge Type Filter"::Deposit); //HEI.26
            //  SalesH.CALCFIELDS(Amount,"Amount Including VAT");
            //HEI.28>>
            // SalesPost.GetSalesLines(SalesH, TempSalesL, 1);//BC UPGRADE KUMARR78 ++11-05-2026
            //HEI.28<<
            //must be combination in between Bill-to customer field "Split Deposit on Invoice" and same line value

            // BC Upgrade SHUKLP03 >> Blocked code because dependency on DIT field "Deposit Cust. Posting Group".
            // IF SalesH."Deposit Cust. Posting Group" <> '' THEN
            //     TempSalesL.SETRANGE("Split Deposit on Invoice", FALSE);
            // BC Upgrade SHUKLP03 << Blocked code because dependency on DIT field "Deposit Cust. Posting Group".
            //BC UPGRADE KUMARR78 ++14-05-2026 >>
            // TempSalesL.SetFilter("R2R Invoice Group Code NIQ",'<>%1', 'EGD');
            //BC UPGRADE KUMARR78 ++14-05-2026 <<


            TempSalesL.CALCSUMS(Amount, "Amount Including VAT");
            SalesH.Amount := TempSalesL.Amount;
            SalesH."Amount Including VAT" := TempSalesL."Amount Including VAT";
            //HEI.27<<

            IF Customer.GET(SalesH."Bill-to Customer No.") THEN
                IF NOT Customer."Block Payment Tolerance" THEN BEGIN
                    //HEI.26>>
                    IF SalesH."Currency Code" <> '' THEN BEGIN
                        Currency.GET(SalesH."Currency Code");
                        MaxPmtTolAmount := Currency."Max. Payment Tolerance Amount"
                    END ELSE
                        MaxPmtTolAmount := GLSetup."Max. Payment Tolerance Amount";
                    //HEI.26<<
                    ApplyingAmount := SalesH."Amount Including VAT";

                    AppliedCustLedgEntry.RESET(); //HEI.26
                    AppliedCustLedgEntry.SETCURRENTKEY("Customer No.", Open);
                    AppliedCustLedgEntry.SETRANGE("Customer No.", Customer."No.");
                    AppliedCustLedgEntry.SETRANGE(Open, TRUE);
                    AppliedCustLedgEntry.SETRANGE("Document No.", SalesH."Applies-to Doc. No.");
                    //HEI.26>>
                    AppliedCustLedgEntry.SETFILTER("Related Sales Order No. FND", '%1', '');
                    AppliedCustLedgEntry.SETAUTOCALCFIELDS("Remaining Amount");
                    //HEI.26<<
                    IF AppliedCustLedgEntry.FINDFIRST() THEN BEGIN
                        //HEI.26>>
                        IF AppliedCustLedgEntry."Currency Code" <> SalesH."Currency Code" THEN
                            AppliedCustLedgEntry."Remaining Amount" :=
                              ROUND(CurrExchRate.ExchangeAmtFCYToFCY(
                                          SalesH."Posting Date", AppliedCustLedgEntry."Currency Code", SalesH."Currency Code",
                                          AppliedCustLedgEntry."Remaining Amount"));

                        //HEI.26<<
                        AppliedAmount := AppliedCustLedgEntry."Remaining Amount"; //HEI.26
                                                                                  //        AmounttoApply := AppliedCustLedgEntry."Amount to Apply";  //HEI.26
                    END ELSE BEGIN  //HEI.26>>
                        AppliedCustLedgEntry.SETRANGE("Document No.");
                        AppliedCustLedgEntry.SETRANGE("Related Sales Order No. FND", SalesH."No.");
                        AppliedCustLedgEntry.SETAUTOCALCFIELDS("Remaining Amount"); //HEI.26
                        IF AppliedCustLedgEntry.FINDSET() THEN
                            REPEAT
                                //HEI.26>>
                                IF AppliedCustLedgEntry."Currency Code" <> SalesH."Currency Code" THEN
                                    AppliedCustLedgEntry."Remaining Amount" :=
                                      ROUND(CurrExchRate.ExchangeAmtFCYToFCY(
                                                  SalesH."Posting Date", AppliedCustLedgEntry."Currency Code", SalesH."Currency Code",
                                                  AppliedCustLedgEntry."Remaining Amount"));
                                //HEI.26<<
                                AppliedAmount += AppliedCustLedgEntry."Remaining Amount"; //HEI.26
                                                                                          //            AmounttoApply += AppliedCustLedgEntry."Amount to Apply";  //HEi.26
                            UNTIL AppliedCustLedgEntry.NEXT() = 0;
                    END;  //HEI.26<<

                    NewPmtTolAmtToBeApplied := ApplyingAmount + AppliedAmount; //HE.26

                    IF (ABS(AppliedAmount + ApplyingAmount) <= ABS(MaxPmtTolAmount)) AND
                       (MaxPmtTolAmount <> 0) AND (ABS(AppliedAmount + ApplyingAmount) <> 0)
                    THEN
                        IF GLSetup."Payment Tolerance Warning" THEN
                            //HEI.26>>
                            IF CallPmtTolWarning(
                                 SalesH."Posting Date", Customer."No.", SalesH."No.", SalesH."Currency Code", ApplyingAmount, AppliedAmount)
                            THEN
                                PmtTolAmtToBeApplied := NewPmtTolAmtToBeApplied
                            //HEI.26<<
                            ELSE
                                PmtTolAmtToBeApplied := NewPmtTolAmtToBeApplied;
                    GenJnlPostLine.SetPmtTolAmtToBeApplied(PmtTolAmtToBeApplied);  // BC Upgrade SHUKLP03 << 
                END;
        END;
        //HEI.23>>
    end;

    LOCAL procedure CallPmtTolWarning(PostingDate: Date; No: Code[20]; DocNo: Code[20]; CurrencyCode: Code[10]; VAR Amount: Decimal; VAR AppliedAmount: Decimal): Boolean
    var
        PmtTolWarning: Page "Payment Tolerance Warning";
        ActionType: Integer;
    begin
        //HEI.23<<
        PmtTolWarning.SetValues(PostingDate, No, DocNo, CurrencyCode, Amount, AppliedAmount, 0);
        PmtTolWarning.LOOKUPMODE(TRUE);
        IF ACTION::Yes = PmtTolWarning.RUNMODAL() THEN BEGIN
            PmtTolWarning.GetValues(ActionType);
            IF ActionType = 2 THEN BEGIN
                Amount := 0;
                AppliedAmount := 0;
            END;
        END ELSE
            EXIT(FALSE);
        EXIT(TRUE);
        //HEI.23>>
    end;


    LOCAL procedure MoveCustDiffLines(VAR SalesHeader: Record "Sales Header"; VAR ReturnReceiptHeader: Record "Return Receipt Header"; VAR SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        PostedCustomerDiffRPM: Record "Posted Customer Diff RPM FND";
        CustomerDifferencesRPM: Record "Customer Differences RPM FND";
        PostedWhseReceiptHeader: Record "Posted Whse. Receipt Header";
        LineNo: Integer;
    begin
        //HEI.07>>
        PostedCustomerDiffRPM.RESET();
        IF PostedCustomerDiffRPM.FINDLAST() THEN
            LineNo := PostedCustomerDiffRPM."Line No." + 10000
        ELSE
            LineNo := 10000;

        CustomerDifferencesRPM.RESET();
        CustomerDifferencesRPM.SETCURRENTKEY("Sales return order no.");
        CustomerDifferencesRPM.SETRANGE("Sales return order no.", SalesHeader."No.");
        IF CustomerDifferencesRPM.FINDSET() THEN
            REPEAT
                IF (CustomerDifferencesRPM."RPM Broken" <> 0) OR (CustomerDifferencesRPM."RPM Chipped" <> 0) OR (CustomerDifferencesRPM."RPM Missing Bottle" <> 0) OR (CustomerDifferencesRPM."RPM Missing crate" <> 0) THEN BEGIN //HEI.10
                    PostedCustomerDiffRPM.INIT();
                    PostedCustomerDiffRPM."Line No." := CustomerDifferencesRPM."Line No.";
                    PostedCustomerDiffRPM."Item No." := CustomerDifferencesRPM."Item No.";
                    PostedCustomerDiffRPM."UOM Code" := CustomerDifferencesRPM."UOM Code";
                    PostedCustomerDiffRPM."Item Description" := CustomerDifferencesRPM."Item Description";
                    PostedCustomerDiffRPM."Deposit Price" := CustomerDifferencesRPM."Deposit Price";
                    PostedCustomerDiffRPM."RPM Missing Bottle" := CustomerDifferencesRPM."RPM Missing Bottle";
                    PostedCustomerDiffRPM."RPM Broken" := CustomerDifferencesRPM."RPM Broken";
                    PostedCustomerDiffRPM."RPM Chipped" := CustomerDifferencesRPM."RPM Chipped";
                    PostedCustomerDiffRPM."RPM Missing crate" := CustomerDifferencesRPM."RPM Missing crate";
                    PostedCustomerDiffRPM."Sell-to customer no." := CustomerDifferencesRPM."Sell-to customer no.";
                    PostedCustomerDiffRPM."Sell-to Customer Name" := CustomerDifferencesRPM."Sell-to Customer Name";
                    PostedCustomerDiffRPM."Bill-to Customer No." := CustomerDifferencesRPM."Bill-to Customer No.";
                    PostedCustomerDiffRPM."Bill-to Customer name" := CustomerDifferencesRPM."Bill-to Customer name";
                    PostedCustomerDiffRPM."Compensation RPM Diff." := CustomerDifferencesRPM."Compensation RPM Diff.";
                    PostedCustomerDiffRPM."Sales return order no." := CustomerDifferencesRPM."Sales return order no.";
                    PostedCustomerDiffRPM."Posted Sales Return receipt No" := ReturnReceiptHeader."No.";
                    PostedCustomerDiffRPM."Posting Date" := ReturnReceiptHeader."Posting Date";
                    PostedCustomerDiffRPM."Document date" := ReturnReceiptHeader."Document Date";
                    PostedCustomerDiffRPM."Compensation RPM Diff." := TRUE;
                    PostedCustomerDiffRPM.INSERT(TRUE);
                END; //HEI.10

            UNTIL CustomerDifferencesRPM.NEXT() = 0;

        DeleteCustDifflineafterPostingWhse(SalesHeader);
        //HEI.07<<
    end;

    LOCAL procedure DeleteCustDifflineafterPostingWhse(SalesHeader: Record "Sales Header")
    var
        CustomerDifferencesRPM: Record "Customer Differences RPM FND";
    begin
        //HEI.07>>
        CustomerDifferencesRPM.SETRANGE("Sales return order no.", SalesHeader."No.");
        IF CustomerDifferencesRPM.FINDSET() THEN
            CustomerDifferencesRPM.DELETEALL(TRUE);
        //HEI.07<<

    end;


    LOCAL procedure SetupLinkedSalesDocNo(SalesInvoiceHeader2: Record "Sales Invoice Header"): Code[20]
    var
        SalesCrMemoHeader2: Record "Sales Cr.Memo Header";
    begin
        //HEI.02>>
        SalesCrMemoHeader2.SETRANGE("Return Order No.", SalesInvoiceHeader2."Order No.");
        IF SalesCrMemoHeader2.FINDFIRST() THEN
            EXIT(SalesCrMemoHeader2."No.")
        ELSE
            EXIT('');
        //HEI.02<<
    end;

    // BC Upgrade SHUKLP03 >> Blocked Nav Procedures and created new procedures with necessary parameters to replace LocationCode parameter with SalesShptHeader record and ReturnRcptHeader record parameter.
    // procedure UpdateOutboundGateEntry(GateEntryNo: Code[20]; OutboundQuantity: Decimal; ItemNo: Code[20]; OutboundWeight: Decimal; UnitOfMeasure: Code[20]; LocationCode: Code[20])
    // var
    //     GateEntryLine: Record "Gate Entry Line";
    //     GateEntryHeader: Record "Gate Entry Header";
    // begin
    //     //HEI.05>>
    //     GateEntryLine.RESET;
    //     GateEntryLine.SETRANGE("Gate Entry Document No.", GateEntryNo);
    //     GateEntryLine.SETRANGE("Unit Of Measure Code", UnitOfMeasure);
    //     GateEntryLine.SETRANGE("Location Code", LocationCode);
    //     IF GateEntryLine.FINDFIRST THEN BEGIN
    //         GateEntryLine."Posted Quantity Outbound" += OutboundQuantity;
    //         GateEntryLine."Reference Document" := GateEntryLine."Reference Document"::"Posted Shipment";
    //         GateEntryLine."Reference No." := SalesShptHeader."No.";
    //         GateEntryLine.MODIFY;
    //     END;
    //     IF GateEntryHeader.GET(GateEntryNo) THEN BEGIN
    //         GateEntryHeader."Posted Weight Outbound" += OutboundWeight;
    //         //GateEntryHeader."Document Type" := GateEntryHeader."Document Type"::"Sales Order";//HEI.06
    //         //GateEntryHeader."Document No." := SalesShptHeader."Order No.";//HEI.06
    //         GateEntryHeader."Reference Document" := GateEntryHeader."Reference Document"::"Posted Shipment";
    //         GateEntryHeader."Reference No." := SalesShptHeader."No.";
    //         GateEntryHeader.MODIFY;
    //     END;
    //     //HEI.05<<
    // end;

    // procedure UpdateInboundGateEntry(GateEntryNo: Code[20]; InboundQuantity: Decimal; ItemNo: Code[20]; InboundWeight: Decimal; UnitOfMeasure: Code[20]; LocationCode: Code[20])
    // var
    //     GateEntryLine: Record "Gate Entry Line";
    //     GateEntryHeader: Record "Gate Entry Header";
    // begin
    //     //HEI.05>>
    //     GateEntryLine.RESET;
    //     GateEntryLine.SETRANGE("Gate Entry Document No.", GateEntryNo);
    //     GateEntryLine.SETRANGE("Unit Of Measure Code", UnitOfMeasure);
    //     GateEntryLine.SETRANGE("Location Code", LocationCode);
    //     IF GateEntryLine.FINDFIRST THEN BEGIN
    //         GateEntryLine."Posted Quantity Inbound" += InboundQuantity;
    //         GateEntryLine."Reference Document" := GateEntryLine."Reference Document"::"Posted Return Receipt";
    //         GateEntryLine."Reference No." := ReturnRcptHeader."No.";
    //         GateEntryLine.MODIFY;
    //     END;
    //     IF GateEntryHeader.GET(GateEntryNo) THEN BEGIN
    //         GateEntryHeader."Posted Weight Inbound" += InboundWeight;
    //         //GateEntryHeader."Document Type" := GateEntryHeader."Document Type"::"Sales Return Order";//HEI.06
    //         //GateEntryHeader."Document No." := ReturnRcptHeader."Return Order No.";//HEI.06
    //         GateEntryHeader."Reference Document" := GateEntryHeader."Reference Document"::"Posted Return Receipt";
    //         GateEntryHeader."Reference No." := ReturnRcptHeader."No.";
    //         GateEntryHeader.MODIFY;
    //     END;
    //     //HEI.05<<
    // end;
    // BC Upgrade SHUKLP03 << Blocked Nav Procedures and created new procedures with necessary parameters to replace LocationCode parameter with SalesShptHeader record and ReturnRcptHeader record parameter.

    // BC Upgrade SHUKLP03 << Replaced LocationCode parameted with SalesShptHeader record and ReturnRcptHeader record parameted in below procedures.
    procedure UpdateOutboundGateEntry(GateEntryNo: Code[20]; OutboundQuantity: Decimal; ItemNo: Code[20]; OutboundWeight: Decimal; UnitOfMeasure: Code[20]; SalesShptHeader: Record "Sales Shipment Header") // BC Upgrade SHUKLP03 << Replaced LocationCode parameter with SalesShptHeader record parameter.
    var
        GateEntryLine: Record "Gate Entry Line FND";
        GateEntryHeader: Record "Gate Entry Header FND";
    begin
        //HEI.05>>
        GateEntryLine.RESET();
        GateEntryLine.SETRANGE("Gate Entry Document No.", GateEntryNo);
        GateEntryLine.SETRANGE("Unit Of Measure Code", UnitOfMeasure);
        GateEntryLine.SETRANGE("Location Code", SalesShptHeader."Location Code");  // BC Upgrade SHUKLP03 << Replaced LocationCode with SalesShptHeader."Location Code".
        IF GateEntryLine.FINDFIRST() THEN BEGIN
            GateEntryLine."Posted Quantity Outbound" += OutboundQuantity;
            GateEntryLine."Reference Document" := GateEntryLine."Reference Document"::"Posted Shipment";
            GateEntryLine."Reference No." := SalesShptHeader."No.";
            GateEntryLine.MODIFY();
        END;
        IF GateEntryHeader.GET(GateEntryNo) THEN BEGIN
            GateEntryHeader."Posted Weight Outbound" += OutboundWeight;
            //GateEntryHeader."Document Type" := GateEntryHeader."Document Type"::"Sales Order";//HEI.06
            //GateEntryHeader."Document No." := SalesShptHeader."Order No.";//HEI.06
            GateEntryHeader."Reference Document" := GateEntryHeader."Reference Document"::"Posted Shipment";
            GateEntryHeader."Reference No." := SalesShptHeader."No.";
            GateEntryHeader.MODIFY();
        END;
        //HEI.05<<
    end;

    procedure UpdateInboundGateEntry(GateEntryNo: Code[20]; InboundQuantity: Decimal; ItemNo: Code[20]; InboundWeight: Decimal; UnitOfMeasure: Code[20]; ReturnRcptHeader: Record "Return Receipt Header") // BC Upgrade SHUKLP03 << Replaced LocationCode parameter with ReturnRcptHeader record parameter.
    var
        GateEntryLine: Record "Gate Entry Line FND";
        GateEntryHeader: Record "Gate Entry Header FND";
    begin
        //HEI.05>>
        GateEntryLine.RESET();
        GateEntryLine.SETRANGE("Gate Entry Document No.", GateEntryNo);
        GateEntryLine.SETRANGE("Unit Of Measure Code", UnitOfMeasure);
        GateEntryLine.SETRANGE("Location Code", ReturnRcptHeader."Location Code");  // BC Upgrade SHUKLP03 << Replaced LocationCode with ReturnRcptHeader."Location Code".
        IF GateEntryLine.FINDFIRST() THEN BEGIN
            GateEntryLine."Posted Quantity Inbound" += InboundQuantity;
            GateEntryLine."Reference Document" := GateEntryLine."Reference Document"::"Posted Return Receipt";
            GateEntryLine."Reference No." := ReturnRcptHeader."No.";
            GateEntryLine.MODIFY();
        END;
        IF GateEntryHeader.GET(GateEntryNo) THEN BEGIN
            GateEntryHeader."Posted Weight Inbound" += InboundWeight;
            //GateEntryHeader."Document Type" := GateEntryHeader."Document Type"::"Sales Return Order";//HEI.06
            //GateEntryHeader."Document No." := ReturnRcptHeader."Return Order No.";//HEI.06
            GateEntryHeader."Reference Document" := GateEntryHeader."Reference Document"::"Posted Return Receipt";
            GateEntryHeader."Reference No." := ReturnRcptHeader."No.";
            GateEntryHeader.MODIFY();
        END;
        //HEI.05<<
    end;
    // BC Upgrade SHUKLP03 << Replaced LocationCode parameted with SalesShptHeader record and ReturnRcptHeader record parameted in below procedures.

    local procedure CheckDocumentType(SalesHeader: Record "Sales Header"; ExecuteDocCheck: Boolean): Boolean
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        if ExecuteDocCheck then
            exit(
              (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) or
              ((SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) and SalesSetup."Shipment on Invoice"));
        exit(true);
    end;


    local procedure CheckSalesDimLines(SalesHeader: Record "Sales Header"; var TempSalesLine: Record "Sales Line" temporary)
    var
        ShouldCheckDimensions: Boolean;
    begin
        TempSalesLine.Reset();
        TempSalesLine.SetFilter(Type, '<>%1', TempSalesLine.Type::" ");
        if TempSalesLine.FindSet() then
            repeat
                ShouldCheckDimensions := (SalesHeader.Invoice and (TempSalesLine."Qty. to Invoice" <> 0)) or
                                            (SalesHeader.Ship and (TempSalesLine."Qty. to Ship" <> 0)) or
                                            (SalesHeader.Receive and (TempSalesLine."Return Qty. to Receive" <> 0));
                OnCheckSalesDimLinesOnAfterCalcShouldCheckDimensions(SalesHeader, TempSalesLine, ShouldCheckDimensions);
                if ShouldCheckDimensions then begin
                    CheckSalesDimCombLine(TempSalesLine);
                    CheckSalesDimValuePostingLine(TempSalesLine);
                end
            until TempSalesLine.Next() = 0;
    end;

    local procedure CheckSalesDimCombLine(SalesLine: Record "Sales Line")
    var
        ErrorContextElement: Codeunit "Error Context Element";
        ContextErrorMessage: Text[250];
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        IF (SalesSetup."Dim. Comb. Not Appl. FND" = FALSE) THEN BEGIN  //HEI.30
            ContextErrorMessage := StrSubstNo(LineDimensionBlockedErr, SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.");
            ErrorMessageMgt.PushContext(ErrorContextElement, SalesLine.RecordId, 0, ContextErrorMessage);
            if not DimMgt.CheckDimIDComb(SalesLine."Dimension Set ID") then
                ErrorMessageMgt.ThrowError(ContextErrorMessage, DimMgt.GetDimErr());
            ErrorMessageMgt.PopContext(ErrorContextElement);
        END;  //HEI.30
    end;

    local procedure CheckSalesDimValuePostingLine(SalesLine: Record "Sales Line")
    var
        ErrorContextElement: Codeunit "Error Context Element";
        ContextErrorMessage: Text[250];
        TableIDArr: array[10] of Integer;
        NumberArr: array[10] of Code[20];
    begin
        TableIDArr[1] := DimMgt.SalesLineTypeToTableID(SalesLine.Type);
        NumberArr[1] := SalesLine."No.";
        TableIDArr[2] := Database::Job;
        NumberArr[2] := SalesLine."Job No.";
        TableIDArr[3] := Database::Location;
        NumberArr[3] := SalesLine."Location Code";
        DimMgt.SetSourceCode(Database::"Sales Line", SalesLine);
        OnCheckDimValuePostingOnAfterCreateDimTableIDs(SalesLine, TableIDArr, NumberArr);

        ContextErrorMessage := StrSubstNo(LineInvalidDimensionsErr, SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.");
        ErrorMessageMgt.PushContext(ErrorContextElement, SalesLine.RecordId, 0, ContextErrorMessage);
        if not DimMgt.CheckDimValuePosting(TableIDArr, NumberArr, SalesLine."Dimension Set ID") then
            ErrorMessageMgt.ThrowError(ContextErrorMessage, DimMgt.GetDimErr());
        ErrorMessageMgt.PopContext(ErrorContextElement);
    end;

    local procedure CheckSalesDimValuePostingHeader(SalesHeader: Record "Sales Header")
    var
        ErrorContextElement: Codeunit "Error Context Element";
        ContextErrorMessage: Text[250];
        TableIDArr: array[10] of Integer;
        NumberArr: array[10] of Code[20];
    begin
        TableIDArr[1] := Database::Customer;
        NumberArr[1] := SalesHeader."Bill-to Customer No.";
        TableIDArr[2] := Database::"Salesperson/Purchaser";
        NumberArr[2] := SalesHeader."Salesperson Code";
        TableIDArr[3] := Database::Campaign;
        NumberArr[3] := SalesHeader."Campaign No.";
        TableIDArr[4] := Database::"Responsibility Center";
        NumberArr[4] := SalesHeader."Responsibility Center";
        TableIDArr[5] := Database::Location;
        NumberArr[5] := SalesHeader."Location Code";
        OnCheckDimValuePostingOnAfterCreateDimTableIDs(SalesHeader, TableIDArr, NumberArr);

        DimMgt.SetSourceCode(Database::"Sales Header", SalesHeader);
        ContextErrorMessage := StrSubstNo(InvalidDimensionsErr, SalesHeader."Document Type", SalesHeader."No.");
        ErrorMessageMgt.PushContext(ErrorContextElement, SalesHeader.RecordId, 0, ContextErrorMessage);
        if not DimMgt.CheckDimValuePosting(TableIDArr, NumberArr, SalesHeader."Dimension Set ID") then
            ErrorMessageMgt.ThrowError(ContextErrorMessage, DimMgt.GetDimErr());
        ErrorMessageMgt.PopContext(ErrorContextElement);
    end;


    local procedure CheckSalesDimCombHeader(SalesHeader: Record "Sales Header")
    var
        ErrorContextElement: Codeunit "Error Context Element";
        ContextErrorMessage: Text[250];
    begin
        ContextErrorMessage := StrSubstNo(DimensionIsBlockedErr, SalesHeader."Document Type", SalesHeader."No.");
        ErrorMessageMgt.PushContext(ErrorContextElement, SalesHeader.RecordId, 0, ContextErrorMessage);
        if not DimMgt.CheckDimIDComb(SalesHeader."Dimension Set ID") then
            ErrorMessageMgt.ThrowError(ContextErrorMessage, DimMgt.GetDimErr());
        ErrorMessageMgt.PopContext(ErrorContextElement);
    end;

    LOCAL procedure GetWarehouseSetup()
    begin
        //>> HEI.11
        IF NOT WarehouseSetupGot THEN
            IF WarehouseSetup.GET() THEN;
        WarehouseSetupGot := TRUE
        //<< HEI.11
    end;

    // BC Upgrade SHUKLP03 >> Blocked code because of dependency on DIT record PostedDocumentShippingCost which is passed as parameter.
    // LOCAL procedure CalcTotalPerUOMShippingCosts(VAR PostedDocumentShippingCost: Record "Posted Document Shipping Cost"; VAR PrmRecRef: RecordRef) TotalPerUOM: Decimal
    // begin
    //     //>> HEI.11
    //     IF PrmRecRef.FINDSET THEN BEGIN
    //         RecID := PrmRecRef.RECORDID;
    //         SourceType := RecID.TABLENO;
    //         GetWarehouseSetup;
    //         REPEAT
    //             CASE SourceType OF
    //                 DATABASE::"Posted Whse. Shipment Line":
    //                     BEGIN
    //                         SearchByFieldNo := 6;
    //                         ItemNoFieldNo := 14;
    //                         QtyFieldNo := 15;
    //                         UOMFieldNo := 29;
    //                         QtyPerUOMFieldNo := 30;
    //                     END;
    //                 DATABASE::"Posted Whse. Receipt Line":
    //                     BEGIN
    //                         SearchByFieldNo := 6;
    //                         ItemNoFieldNo := 14;
    //                         QtyFieldNo := 15;
    //                         UOMFieldNo := 29;
    //                         QtyPerUOMFieldNo := 30;
    //                     END;
    //                 DATABASE::"Sales Shipment Line":
    //                     BEGIN
    //                         SearchByFieldNo := 3;
    //                         ItemNoFieldNo := 6;
    //                         QtyFieldNo := 15;
    //                         UOMFieldNo := 5407;
    //                         QtyPerUOMFieldNo := 5404;
    //                     END;
    //                 DATABASE::"Return Receipt Line":
    //                     BEGIN
    //                         SearchByFieldNo := 3;
    //                         ItemNoFieldNo := 6;
    //                         QtyFieldNo := 15;
    //                         UOMFieldNo := 5407;
    //                         QtyPerUOMFieldNo := 5404;
    //                     END;
    //                 DATABASE::"Sales Line":
    //                     BEGIN
    //                         SearchByFieldNo := 3;
    //                         ItemNoFieldNo := 6;
    //                         QtyFieldNo := 15;
    //                         UOMFieldNo := 5407;
    //                         QtyPerUOMFieldNo := 5404;
    //                     END;
    //                 //>>HEI.15
    //                 DATABASE::"Warehouse Shipment Line":
    //                     BEGIN
    //                         SearchByFieldNo := 1;
    //                         ItemNoFieldNo := 14;
    //                         QtyToShipFieldNo := 21; //HEI.15
    //                         QtyFieldNo := 15;
    //                         UOMFieldNo := 29;
    //                         QtyPerUOMFieldNo := 30;
    //                     END;
    //                 //<<HEI.15
    //                 //>>HEI.15
    //                 DATABASE::"Warehouse Receipt Line":
    //                     BEGIN
    //                         SearchByFieldNo := 1;
    //                         ItemNoFieldNo := 14;
    //                         QtyToReceiveFieldNo := 21; //HEI.15
    //                         QtyFieldNo := 15;
    //                         UOMFieldNo := 29;
    //                         QtyPerUOMFieldNo := 30;
    //                     END;
    //             //<<HEI.15
    //             END;

    //             QtyFieldRef := PrmRecRef.FIELD(QtyFieldNo);
    //             QtyPerUOMFieldRef := PrmRecRef.FIELD(QtyPerUOMFieldNo);
    //             UOMFieldRef := PrmRecRef.FIELD(UOMFieldNo);
    //             ItemNoFieldRef := PrmRecRef.FIELD(ItemNoFieldNo);
    //             QtyToShipFieldRef := PrmRecRef.FIELD(QtyToShipFieldNo); //HEI.15
    //             QtyToReceiveFieldRef := PrmRecRef.FIELD(QtyToReceiveFieldNo); //HEI.15
    //             CASE PostedDocumentShippingCost."Unit of Measure" OF

    //                 WarehouseSetup."Shortcut Unit of Measure1 Code":
    //                     BEGIN
    //                         CASE WarehouseSetup."Calc. Short. Qty per UOM1 Code" OF
    //                             WarehouseSetup."Calc. Short. Qty per UOM1 Code"::"Item UOM Codes":
    //                                 BEGIN
    //                                     ItemUnitofMeasure.SETRANGE("Item No.", FORMAT(ItemNoFieldRef.VALUE));
    //                                     ItemUnitofMeasure.SETRANGE(Code, WarehouseSetup."Shortcut Unit of Measure1 Code");
    //                                     EVALUATE(Qty, FORMAT(QtyFieldRef.VALUE));
    //                                     EVALUATE(QtyPerUOM, FORMAT(QtyPerUOMFieldRef.VALUE));
    //                                     EVALUATE(QtyToShip, FORMAT(QtyToShipFieldRef.VALUE)); //HEI.15
    //                                     EVALUATE(QtyToReceive, FORMAT(QtyToReceiveFieldRef.VALUE)); //HEI.15
    //                                                                                                 //>>HEI.15
    //                                     IF ItemUnitofMeasure.FINDFIRST THEN BEGIN
    //                                         IF WhseShip THEN
    //                                             //TotalPerUOM := TotalPerUOM + (Qty * QtyPerUOM / ItemUnitofMeasure."Qty. per Unit of Measure");
    //                                             TotalPerUOM := TotalPerUOM + (QtyToShip * QtyPerUOM / ItemUnitofMeasure."Qty. per Unit of Measure") //HEI.15
    //                                         ELSE IF WhseReceive THEN
    //                                             TotalPerUOM := TotalPerUOM + (QtyToReceive * QtyPerUOM / ItemUnitofMeasure."Qty. per Unit of Measure") //HEI.15
    //                                         ELSE
    //                                             TotalPerUOM := TotalPerUOM + (Qty * QtyPerUOM / ItemUnitofMeasure."Qty. per Unit of Measure"); //HEI.15
    //                                     END;
    //                                     //<<HEI.15
    //                                 END;
    //                             WarehouseSetup."Calc. Short. Qty per UOM1 Code"::"Source Line UOM Code":
    //                                 BEGIN
    //                                     EVALUATE(Qty, FORMAT(QtyFieldRef.VALUE));
    //                                     EVALUATE(QtyPerUOM, FORMAT(QtyPerUOMFieldRef.VALUE));
    //                                     EVALUATE(QtyToShip, FORMAT(QtyToShipFieldRef.VALUE)); //HEI.15
    //                                     EVALUATE(QtyToReceive, FORMAT(QtyToReceiveFieldRef.VALUE)); //HEI.15
    //                                     UnitofMeasureCoderelation.SETRANGE("Related Unit Of Measure Code", WarehouseSetup."Shortcut Unit of Measure1 Code");
    //                                     UnitofMeasureCoderelation.SETRANGE("Unit Of Measure Code", FORMAT(UOMFieldRef.VALUE));
    //                                     //>>HEI.15
    //                                     IF UnitofMeasureCoderelation.FINDFIRST THEN BEGIN
    //                                         IF WhseShip THEN
    //                                             //TotalPerUOM := TotalPerUOM + (Qty * UnitofMeasureCoderelation."Qty. per Unit of Measure");
    //                                             TotalPerUOM := TotalPerUOM + (QtyToShip * UnitofMeasureCoderelation."Qty. per Unit of Measure")
    //                                         ELSE IF WhseReceive THEN
    //                                             TotalPerUOM := TotalPerUOM + (QtyToReceive * UnitofMeasureCoderelation."Qty. per Unit of Measure")
    //                                         ELSE
    //                                             TotalPerUOM := TotalPerUOM + (Qty * UnitofMeasureCoderelation."Qty. per Unit of Measure");
    //                                     END;
    //                                     //<<HEI.15
    //                                 END;
    //                         END;
    //                     END;

    //                 WarehouseSetup."Shortcut Unit of Measure2 Code":
    //                     BEGIN
    //                         CASE WarehouseSetup."Calc. Short. Qty per UOM2 Code" OF
    //                             WarehouseSetup."Calc. Short. Qty per UOM2 Code"::"Item UOM Codes":
    //                                 BEGIN
    //                                     ItemUnitofMeasure.SETRANGE("Item No.", FORMAT(ItemNoFieldRef.VALUE));
    //                                     ItemUnitofMeasure.SETRANGE(Code, WarehouseSetup."Shortcut Unit of Measure2 Code");
    //                                     EVALUATE(Qty, FORMAT(QtyFieldRef.VALUE));
    //                                     EVALUATE(QtyPerUOM, FORMAT(QtyPerUOMFieldRef.VALUE));
    //                                     EVALUATE(QtyToShip, FORMAT(QtyToShipFieldRef.VALUE)); //HEI.15
    //                                     EVALUATE(QtyToReceive, FORMAT(QtyToReceiveFieldRef.VALUE)); //HEI.15
    //                                                                                                 //>>HEI.15
    //                                     IF ItemUnitofMeasure.FINDFIRST THEN BEGIN
    //                                         IF WhseShip THEN
    //                                             //TotalPerUOM := TotalPerUOM + (Qty * QtyPerUOM / ItemUnitofMeasure."Qty. per Unit of Measure");
    //                                             TotalPerUOM := TotalPerUOM + (QtyToShip * QtyPerUOM / ItemUnitofMeasure."Qty. per Unit of Measure")
    //                                         ELSE IF WhseReceive THEN
    //                                             TotalPerUOM := TotalPerUOM + (QtyToReceive * QtyPerUOM / ItemUnitofMeasure."Qty. per Unit of Measure")
    //                                         ELSE
    //                                             TotalPerUOM := TotalPerUOM + (Qty * QtyPerUOM / ItemUnitofMeasure."Qty. per Unit of Measure");
    //                                     END;
    //                                     //<<HEI.15
    //                                 END;
    //                             WarehouseSetup."Calc. Short. Qty per UOM2 Code"::"Source Line UOM Code":
    //                                 BEGIN
    //                                     EVALUATE(Qty, FORMAT(QtyFieldRef.VALUE));
    //                                     EVALUATE(QtyPerUOM, FORMAT(QtyPerUOMFieldRef.VALUE));
    //                                     EVALUATE(QtyToShip, FORMAT(QtyToShipFieldRef.VALUE)); //HEI.15
    //                                     EVALUATE(QtyToReceive, FORMAT(QtyToReceiveFieldRef.VALUE)); //HEI.15
    //                                     UnitofMeasureCoderelation.SETRANGE("Related Unit Of Measure Code", WarehouseSetup."Shortcut Unit of Measure2 Code");
    //                                     UnitofMeasureCoderelation.SETRANGE("Unit Of Measure Code", FORMAT(UOMFieldRef.VALUE));
    //                                     //>>HEI.15
    //                                     IF UnitofMeasureCoderelation.FINDFIRST THEN BEGIN
    //                                         IF WhseShip THEN
    //                                             //TotalPerUOM := TotalPerUOM + (Qty * UnitofMeasureCoderelation."Qty. per Unit of Measure");
    //                                             TotalPerUOM := TotalPerUOM + (QtyToShip * UnitofMeasureCoderelation."Qty. per Unit of Measure")
    //                                         ELSE IF WhseReceive THEN
    //                                             TotalPerUOM := TotalPerUOM + (QtyToReceive * UnitofMeasureCoderelation."Qty. per Unit of Measure")
    //                                         ELSE
    //                                             TotalPerUOM := TotalPerUOM + (Qty * UnitofMeasureCoderelation."Qty. per Unit of Measure");
    //                                     END;
    //                                     //<<HEI.15
    //                                 END;
    //                         END;
    //                     END;

    //                 WarehouseSetup."Shortcut Unit of Measure3 Code":
    //                     BEGIN
    //                         CASE WarehouseSetup."Calc. Short. Qty per UOM3 Code" OF
    //                             WarehouseSetup."Calc. Short. Qty per UOM3 Code"::"Item UOM Codes":
    //                                 BEGIN
    //                                     ItemUnitofMeasure.SETRANGE("Item No.", FORMAT(ItemNoFieldRef.VALUE));
    //                                     ItemUnitofMeasure.SETRANGE(Code, WarehouseSetup."Shortcut Unit of Measure3 Code");
    //                                     EVALUATE(Qty, FORMAT(QtyFieldRef.VALUE));
    //                                     EVALUATE(QtyPerUOM, FORMAT(QtyPerUOMFieldRef.VALUE));
    //                                     EVALUATE(QtyToShip, FORMAT(QtyToShipFieldRef.VALUE)); //HEI.15
    //                                     EVALUATE(QtyToReceive, FORMAT(QtyToReceiveFieldRef.VALUE)); //HEI.15
    //                                                                                                 //>>HEI.15
    //                                     IF ItemUnitofMeasure.FINDFIRST THEN BEGIN
    //                                         IF WhseShip THEN
    //                                             //TotalPerUOM := TotalPerUOM + (Qty * QtyPerUOM / ItemUnitofMeasure."Qty. per Unit of Measure");
    //                                             TotalPerUOM := TotalPerUOM + (QtyToShip * QtyPerUOM / ItemUnitofMeasure."Qty. per Unit of Measure")
    //                                         ELSE IF WhseReceive THEN
    //                                             TotalPerUOM := TotalPerUOM + (QtyToReceive * QtyPerUOM / ItemUnitofMeasure."Qty. per Unit of Measure")
    //                                         ELSE
    //                                             TotalPerUOM := TotalPerUOM + (Qty * QtyPerUOM / ItemUnitofMeasure."Qty. per Unit of Measure");
    //                                     END;
    //                                     //<<HEI.15
    //                                 END;
    //                             WarehouseSetup."Calc. Short. Qty per UOM3 Code"::"Source Line UOM Code":
    //                                 BEGIN
    //                                     EVALUATE(Qty, FORMAT(QtyFieldRef.VALUE));
    //                                     EVALUATE(QtyPerUOM, FORMAT(QtyPerUOMFieldRef.VALUE));
    //                                     EVALUATE(QtyToShip, FORMAT(QtyToShipFieldRef.VALUE)); //HEI.15
    //                                     EVALUATE(QtyToReceive, FORMAT(QtyToReceiveFieldRef.VALUE)); //HEI.15
    //                                     UnitofMeasureCoderelation.SETRANGE("Related Unit Of Measure Code", WarehouseSetup."Shortcut Unit of Measure3 Code");
    //                                     UnitofMeasureCoderelation.SETRANGE("Unit Of Measure Code", FORMAT(UOMFieldRef.VALUE));
    //                                     //>>HEI.15
    //                                     IF UnitofMeasureCoderelation.FINDFIRST THEN BEGIN
    //                                         IF WhseShip THEN
    //                                             //TotalPerUOM := TotalPerUOM + (Qty * UnitofMeasureCoderelation."Qty. per Unit of Measure");
    //                                             TotalPerUOM := TotalPerUOM + (QtyToShip * UnitofMeasureCoderelation."Qty. per Unit of Measure")
    //                                         ELSE IF WhseReceive THEN
    //                                             TotalPerUOM := TotalPerUOM + (QtyToReceive * UnitofMeasureCoderelation."Qty. per Unit of Measure")
    //                                         ELSE
    //                                             TotalPerUOM := TotalPerUOM + (Qty * UnitofMeasureCoderelation."Qty. per Unit of Measure");
    //                                     END
    //                                     //<<HEI.15
    //                                 END;
    //                         END;
    //                     END;
    //             END;
    //         UNTIL PrmRecRef.NEXT = 0;
    //     END;

    //     EXIT(TotalPerUOM);
    //     //<< HEI.11
    // end;
    // BC Upgrade SHUKLP03 << Blocked code because of dependency on DIT record PostedDocumentShippingCost which is passed as parameter.

    [IntegrationEvent(false, false)]
    local procedure OnCheckCustBlockageOnAfterTempLinesSetFilters(SalesHeader: Record "Sales Header"; var TempSalesLine: Record "Sales Line" temporary);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCheckSalesDimLinesOnAfterCalcShouldCheckDimensions(SalesHeader: Record "Sales Header"; TempSalesLine: Record "Sales Line" temporary; var ShouldCheckDimensions: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCheckDimValuePostingOnAfterCreateDimTableIDs(RecordVariant: Variant; var TableIDArr: array[10] of Integer; var NumberArr: array[10] of Code[20])
    begin
    end;





}
