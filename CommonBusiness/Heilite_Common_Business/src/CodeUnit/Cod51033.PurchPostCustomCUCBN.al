namespace ALProject.ALProject;
using Microsoft.Sales.Customer;
using Microsoft.Projects.Project.Journal;
using Microsoft.Sales.Setup;
using Microsoft.Foundation.Company;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Posting;
using System.Threading;
using Microsoft.FixedAssets.Journal;
using Microsoft.Foundation.Enums;
using Microsoft.FixedAssets.Posting;
using Microsoft.Finance.Analysis;
using Microsoft.FixedAssets.Setup;
using Microsoft.CRM.Contact;
using Microsoft.Foundation.Period;
using Microsoft.Foundation.Reporting;
using Microsoft.Foundation.NoSeries;
using Microsoft.Finance.FinancialReports;
using Microsoft.Inventory.Transfer;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Posting;
using Microsoft.Sales.Document;
using System.Text;
using Microsoft.Manufacturing.WorkCenter;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Finance.VAT.Setup;
using Microsoft.Inventory.Journal;
using Microsoft.Warehouse.Request;
using Microsoft.Warehouse.Structure;
using System.IO;
using Microsoft.Manufacturing.Document;
using Microsoft.Purchases.Payables;
using Microsoft.Finance.GeneralLedger.Setup;
using System.Environment;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Ledger;
using Microsoft.Purchases.Vendor;
using Microsoft.Assembly.Posting;
using Microsoft.EServices.EDocument;
using Microsoft.Projects.Project.Posting;
using Microsoft.Finance.SalesTax;
using System.Environment.Configuration;
using Heineken_BC_Upgrade.Heineken_BC_Upgrade;
using Microsoft.Bank.Check;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Inventory.Requisition;
using System.Telemetry;
using System.Automation;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Warehouse.Ledger;
using Microsoft.Manufacturing.Journal;
using Microsoft.Foundation.Navigate;
using Microsoft.Finance.GeneralLedger.Preview;
using Microsoft.Manufacturing.Capacity;
using Microsoft.Finance.Deferral;
using Microsoft.Finance.GeneralLedger.Reversal;
using Microsoft.Sales.Reminder;
using Microsoft.Warehouse.Setup;
using Microsoft.Warehouse.Journal;
using Microsoft.Projects.Project.Job;
using Microsoft.Inventory.Item.Attribute;
using Microsoft.Purchases.Comment;
using System.Security.User;
using Microsoft.Purchases.Archive;
using Microsoft.Foundation.Address;
using Microsoft.Utilities;
using Microsoft.Assembly.Document;
using Microsoft.Inventory.Availability;
using System.Utilities;
using Microsoft.Inventory.Setup;
using Microsoft.Manufacturing.Routing;
using Microsoft.HumanResources.Employee;
using Microsoft.CRM.Campaign;
using Microsoft.CRM.Team;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Intercompany.BankAccount;
using Microsoft.Intercompany.GLAccount;
using Microsoft.Intercompany.Partner;
using Microsoft.Finance.ReceivablesPayables;
using Microsoft.Purchases.Posting;
using Microsoft.Bank.Ledger;
using Microsoft.Sales.Receivables;
using Microsoft.Inventory.Counting.Journal;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.CostAccounting.Setup;
using Microsoft.CostAccounting.Account;
using Microsoft.Bank.BankAccount;
using Microsoft.Bank.Reconciliation;
using Microsoft.Purchases.History;
using Microsoft.Warehouse.Document;
using Microsoft.Sales.History;
using Microsoft.Warehouse.History;
using Microsoft.Warehouse.Reports;
using Microsoft.Inventory.BOM.Tree;
using Microsoft.Inventory.Costing;
using Microsoft.Inventory.BOM;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Foundation.UOM;
using Microsoft.Finance.Currency;
using Microsoft.Inventory;
using Microsoft.Finance.Dimension;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Warehouse.Activity;
using Microsoft.Inventory.Tracking;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.FixedAssets.Ledger;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Purchases.Setup;
using Microsoft.Finance.VAT.Calculation;

codeunit 51033 "Purch Post Custom CU CBN"
{
    //-------------------------------------------------------------------------------------------------//
    //--------------------------------------------BC UPgrade SHARMP16 CU 90 Purch.Post BEGIN>>----------------------------------------
    //     DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 21/12/2007 Added Drink-it Tax Item Charges functionnalities
    // DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    // DITW15.00.00.01 DDR 07/01/2008 bugfix copy field "Empty goods item no."
    //                                added field "Item Charge Quantity per"
    // DITW15.00.00.01 DDR 10/01/2008 Added field "Due Tax"
    // DITW15.00.00.01 DDR 22/01/2008 Added Drink-it Discount & Promotion Item Charges functionnalities
    // DITW15.00.00.01 DDR 28/01/2008 Update for Warehouse attached item lines and quantites after posting
    // DITW15.00.00.01 DDR 01/02/2008 Bugfix Auto Suggest ItemCharges Assgnt whith partial posting lines
    // DITW15.00.00.01 DDR 04/02/2008 Added Drink-it Reversing Calculation (Rounding) functionnalities
    // DITW15.00.00.01 DDR 18/02/2008 Discount item charge amounts into Item Journal "Discount Amount" (std. field)
    // DITW15.00.00.01 DDR 27/02/2008 Remove field2034690 Price Incl. Reversing Calc.
    //                                 replacing with "ItemCharge Incl. Price"
    // DITW15.00.00.01 DDR 27/02/2008 Drink-it Return Deposit functionnalities
    // DITW15.00.00.01 DDR 10/03/2008 change parameter function AutoSuggestItemChargeAssgnt()
    //                                added discount amount into PostItemCharge() for Periodic Cr.Memos discounts
    //                                bugfix Standard Navision into CopyAndCheckItemCharge() with partial shipment/return & invoice
    //                                transfer due date into item journal
    // DITW15.00.00.01 DDR 21/03/2008 Update function CalcDirectUnitPurchLine() to calculate back the item direct unit cost
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.15 DDR 26/03/2008 Update Tax function CalcDirectUnitPurchLine() new parameter
    //                                Added Attached to line no. for all documents
    // DITW15.00.00.17 DDR 03/04/2008 Bugfix skip item promotion to call function CalcUnitPricePurchLine()
    // DITW15.00.00.18 DDR 04/04/2008 Bugfix Navision to close the process completely (lock when called by batch report)
    //                                  rewrite function PostAssocReturnOrders()
    //                                Bugfix Partial Item Charges
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.19 DDR 07/04/2008 Review workflow price incl & back calculation
    //                                Remove setcurrentkey into function CopyAndCheckItemCharge()
    //                                Check Return Item Empty Goods with Negative Quantity
    // DITW15.00.00.20 DDR 27/05/2008 Added function SumPurchLinesTempTotal()
    // DITW15.00.00.20 DDR 06/06/2008 Certification rules
    //                     11/06/2008 Licence permission to write into table 5823 G/L - Item Ledger Relation
    // DITW15.00.00.21 DDR 13/06/2008 Added transfer Amount fields into Shipment & Return Receipt Lines
    //                                Added Qty invoiced transport calculation on receiption

    // DITW15.00.00.23 DDR 23/07/2008 Change parameter function CalcUnitPricePurchLine()
    //                                remove function CalcUnitPricePurchLine() from RoundAmount()
    //                     12/08/2008 Save prepayment Amounts into Ship or Receive
    //                                Certification Rules
    //                                  Add end period global text constant Text2014063,Text2014064,Text2014065
    // DITW15.00.00.23.04 DDR 15/09/2008 Added assign field "Shipping Qty. Not Invd.","Shipping Quantity Invoiced"
    //                                   Renamed lShippingQty -> lShippingTotalQty
    //                                   Renamed ShipRcptQtyToBeInvoiced,ShipShptQtyToBeInvoiced -> ShippingQtyToBeInvoiced
    //                                   Renamed ShipRcptRemQtyToBeInvoiced,ShipShptRemQtyToBeInvoiced -> ShippingRemQtyToBeInvoiced
    //                                   Bugfix Weight,Cubage into Purchase Receipt Line when partial posting
    // DITW15.00.00.23.04 DDR 15/09/2008 Added assign field "Shipping Qty. Not Invd.","Shipping Quantity Invoiced"
    //                                   Renamed lShippingQty -> lShippingTotalQty
    //                                   Renamed ShipRcptQtyToBeInvoiced,ShipShptQtyToBeInvoiced -> ShippingQtyToBeInvoiced
    //                                   Renamed ShipRcptRemQtyToBeInvoiced,ShipShptRemQtyToBeInvoiced -> ShippingRemQtyToBeInvoiced
    //                                   Bugfix Weight,Cubage into Purchase Receipt Line when partial posting
    // DITW15.00.00.24 DDR 29/08/2008 Added new parameter into std function DivideAmount()
    //                     25/09/2008 Added fields to fill in Item journal(s)
    //                     07/10/2008 Added field "Duty Tax Type" to transfer into Item  journal
    // DITW15.00.00.25 DDR 10/10/2008 Copied field "Driver Code" from Whse Header to Posted Receipt Header + Vendor Entry
    //                     16/10/2008 Remove update Purchase while invoicing shipping costs and replace by Posted Whse Receipt
    //                                Rename textconst Text2014064
    //                     17/10/2008 Updated fields "Weight","Volume" for all posted documents
    //                                Changed flow using "Duty Point" (Purch setup) to post (invoice) tax item charges
    //                                Added function IsTaxDutyPointLine()
    //                     21/10/2008 Removed flow "Duty Tax Type"
    //                                Removed OnRun() Local variables lShippingUnit,lShippingTotalQty (+ all c/al)
    //                     22/10/2008 Added parameter 'pblnIsDutyPoint' function PostItemChargePerOrder()
    // DITW15.00.00.26 DDR 31/10/2008 Added Driver & Truck code into Receipt Line, Return Shipment Line,Purch Shipment Line
    //                     21/11/2008 Bugfix to copy Driver & Truck into Vendor entry
    // DITW15.00.00.28 DDR 27/11/2008 Added to create AAD document entries
    //                     02/12/2008 Bugfix STANDARD rounding into function CopyAndCheckItemCharge()
    // DITW15.00.00.29 DDR 19/12/2008 Bugfix partial invoicing, the item charges (Discount/Promotion) are not updated correctly
    //                                  when the quantity is negative into function PostItemChargePerOrder()
    //                                Bugfix STANDARD rounding into function GetItemChargeLine()
    //                                Bugfix to clear the variable ShippingRemQtyToBeInvoiced and/or update the posted warehouse document
    // DITW15.00.00.31 DDR 17/02/2009 Navision bug SP1 Function TestGetRcptPPmtAmtToDeduct() local variable "OrderNo" Code 10 -> Code 20
    //                     19/02/2009 Removed function CheckEmptyGoodNeg()
    //                                Added to save "Last Price Calculated Date" into Item Journal lines
    // DITW15.00.00.32 DDR 12/03/2009 Bugfix to create any item charge (from return order) into item jnl line
    //                                  while use Duty point 'Post receipt'
    //                     25/03/2009 Bugfix to post Due tax (Duty COS) into G/L Entry & Value Entry with Ret.Orders & Credit Memos
    //                                  while use Duty point 'Posted shipment'.
    //                     09/04/2009 Added Drink Tax Rounding
    //                                Added mandatory "Tariff No." with AAD Documents
    // DITW15.00.00.33 DDR 08/05/2009 Added text constant Text2013660,Text2013661
    //                                Added field "Duty Suspended"
    //                                Added checking Drink Tax Group mandatory fields
    // DITW15.00.00.34 DDR 08/06/2009 Skipped checking AAD Nos Series when item has no attached Tax item charges
    //                     09/06/2009 Added function calls to post the periodic discount/promotion
    //                     16/06/2009 Added checking on "Empty goods item no." if mandatory
    //                     03/07/2009 Added transfer fields "Tariff no.","Tax Formula" into Item journal
    //                     07/07/2009 Bugfix error partial Tax due when duty point is shipment.
    //                     09/07/2009 Bugfix check "Tax registration" is mandatory in Header
    // DITW15.00.00.35 DDR  22/06/2009 Added checking if exists receipt or return shipment document when duty point if receipt
    //                                 (case 'receipt on invoice' or 'return shipment on cr.memo = No)
    //                                Added text constant Text2013613
    //                                Added flowfilters into functions
    //                                  GetPurchLines(),SumPurchLines2()
    //                     26/06/2009 Added transfer fields to Item journal
    //                                "Gen. Prod. Posting Free Group",
    //                                "Free Item Posting Type","Free Item","Free Calculation Type","Include Free Qty. in Minimum"
    //                     23/07/2009 Added function GetAttachedPurchLines()
    //                     14/08/2009 Added copy "Gen. Bus. Posting Group" from attached Item Charge lines
    //                     21/08/2009 issue 784 Missing to transfer 'Free' fields to item journal
    //                     08/10/2009 issue 781 Fill in "Discount Amount" into Item Journal for Item charges
    //                     16/10/2009 issue 802 Update Qty. Assigned of Tax item charges while duty point = receipt
    // DITW15.00.00.36 DDR 06/11/2009 issue 943 Bugfix Navsion standard for function GetItemChargeLine()
    // DITW15.00.00.36 DDR 18/11/2009 issue 676 Missing splitting and recalculating qty to ship/invoice whith G/L account per order
    //                                          Added function CopyAndCheckItemChargeOther()
    //                     10/12/2009 issue 986 Bugfix lost VAT while Invoice Whse. shipping costs
    //                     18/12/2009 issue 939 Error to recalculate price back
    // DITW15.00.00.37 DDR 07/01/2010 issue 959 Bugfix keep the AAD No. after all received (purchase order)
    //                     20/01/2010 issue 1020 Added transfer fields into Item journal
    //                                             "Location Group Code","Company Tax Registration No.","Physical Location Group Code"
    //                     29/01/2010 issue 1054 Added transfer fields into Item journal
    //                                             "AAD No. Series","AAD No.","Tariff No."
    //                                           Removed call to AAD document functions
    //                     03/02/2010 issue 1032 Added invoice discount for Purch amounts with discount item charge types
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
    //                                             the Item Charge Assignment (Purch) "unit cost" when there is an invoice discount amount
    //                     23/04/2010 issue 1123 Bugfix automatically assign all item charges after posted by ship only
    //                     27/04/2010 issue 1095 Bugfix check if all item charges are assigned (qty to assign <> 0)
    //                     29/04/2010 issue 1114 Bugfix to have discount/promotion per order into value entries
    //                                              because call Release function after the functions CopyAndCheckItemCharge(),
    //                                               CopyAndCheckItemChargeOther()
    //                     05/05/2010 issue 1136 Added to post item charges with subcontracting purchase prod. order
    //                                           Added function PostItemChargePerProdOrder(),IsTaxDutyPointItemJnlLine()
    //                     07/05/2010 issue 959 Bugfix keep AAD No. after the last receipt/return shipment
    //                     18/05/2010 issue 1137 Added function CheckAttachedItemCharges()
    //                     27/05/2010 issue 1121 Added security to check field "Shipment on Invoice" when field "Duty Point"
    //                     01/06/2010 issue 959 Bugfix test AAD mandatory on Qty. to receive or Return Qty to ship
    //                     03/06/2010 issue 1121 Added security to check field "Return Shipment on Credit Memo" when field "Duty Point"
    //                     03/06/2010 issue 1125 Bugfix function CheckAttachedItemCharges() with promotion item charges
    //                     09/06/2010 issue 1153 Remove test unit cost for item charge assignments
    //                     18/06/2010 issue 1165 Bugfix skipped testing for all other Purch line types to check attached lines
    // DITW16.00.00.37 DDR 16/06/2010 Upgrade NAV 2009 SP1
    // DITW15.00.00.38 DDR 05/07/2010 issue 1109 Added to split Due Taxes Item charge assignements by Lot/Serial tracking line
    //                                             and when Duty point Shipment
    //                     13/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                           AAD Checking Rule Modified (combination Cust/Item Tax Groups)
    //                                           Added checking fields + item journal
    //                                             "LRN No. Series","LRN No.","ARC No.","SAD No.","Product Tax Code"
    //                     17/09/2010            Modified to check "ARC No." when mandatory
    //                     22/09/2010            Validate field "Packaging Type Code" to fill in the default "No. of Packages"
    //                     30/09/2010            Validate EDI when posting a Purchase order within ARC no.
    //                     04/10/2010            Added call function to check the EMCS purchase return order documents
    //                     11/10/2010            Check license to skip EMCS if not need
    //                                           Bugfix to check if LRN is mandatory
    //                     14/10/2010 issue 1139 SSCC Functionnalities
    //                                           Added check on SSCC no. and quantities (required)
    //                     17/11/2010            Added to prepare sscc tracking for itemjnlline
    //                                           Added codeunit 'Permission' property for table2035045 "SSCC Entry Relation"
    //                                           Added functions InsertRcptEntryRelationSSCC(),InsertReturnEntryRelationSSCC(),
    //                                             TransfReservToItemJnlLineSSCC()
    //                                           Added Text constants Text2035042,Text2035043
    //                     03/12/2010 issue 1222 Bugfix manual Item charges
    //                                           Bugfix function IsTaxDutyPointLine()
    //                     09/12/2010            (DIT711 99) Bugfix Modified test mandatory on tax whse reference (Export only).
    //                     09/12/2010 issue 1242 Bugfix manual item charges to calculate for unit price & cost.
    //                     10/12/2010 issue 1117 Bugfix post excise value entry with item tracking (combine shipment)
    //                     10/12/2010 issue 1221 Added fields to copy into General journal line
    //                                  "Vendor Tax Registration No.","Vendor Tax Warehouse Ref."
    //                     14/12/2010 issue 1097 Added to check if duty tax line is mandatory
    //                                           Modified AAD tests for performance
    //                     17/12/2010 issue 703 Added fields "Tax Item No."
    //                                  "Vendor Tax Registration No.","Vendor Tax Warehouse Ref."
    //                     04/01/2011 issue 1217 (DIT711 105)
    //                                              field "vendor tax Registration no." is not mandatory when destination types
    //                                                (Tax Warehouse,Registered Consignee,Temporary Registered,Direct Delivery)
    //                                              field "vendor tax Warehouse Ref." is not mandatory when destination types
    //                                                (Registered Consignee,Temporary Registered,Direct Delivery,Exempted Organisation)
    //                     26/01/2011 issue 1117 Bugfix error on qty. assigned when posting partial invoice??
    //                     04/02/2011 issue 1141 Added parameter function PostFromPurchRcptLine() for Periodic Disc-Promo
    //                     16/02/2011 issue 1217 (DIT711 146) Check fields to create EMCS documents
    //                                                          "Shipping Agent Code","Shipping Agent Code","Shipping Time"
    //                     16/02/2011 issue 1217 (DIT711 148) Added transfer value field "Pack Qty. per Unit of Measure" into Item journal
    //                     21/02/2011 issue 1217 (DIT711 146) Bugfix check only the Shippent agent header fields.
    //                     24/02/2011 issue 1287 Bugfix opposite sign with item charge (like standard Navision)
    //                     03/03/2011 issue 1289 Bugfix to calculate/update "shipping quantity invoiced" (Whse Shpt. + P.Receipt)
    //                     08/03/2011 issue 1217 (DIT711 158) Bugfix skip "Shipping Agent" checking for inbound (only Purchase Return)
    //                                                               remove "Shipping Agent" checking equal header value
    //                     11/03/2011 issue 703 Bugfix to calculate Tax item no. with "Item Charge Quantity per"
    //                     15/03/2011 isue 1161 Bugfix missing AAD/ARC mandatory checking on Invoice
    //                     18/03/2011 issue 703 Copy the "Source No. FND" into "Tax Item no." following setup
    // DITW15.00.00.39 DDR 12/04/2011 issue 1296 Added link to Warehouse documents for EMCS/EDI Inbound
    // DITW16.00.00.39 DDR 29/04/2011 DIT-715 issue 98 Bugfix missing copy data into new W16 local variable TempWhseTrackingSpecification
    //                                          in function PostItemJnlLine()
    // DITW15.00.00.39 DDR 03/05/2011 issue 1325 Skip SSCC when not read permission (not in license)
    //                     05/05/2011 DIT-715 issue 118 Allow (split) to post Line Disc. & Invoice Disc. Accounts when 100%
    //                     05/07/2011 issue 1349 Bugfix don't update EMCS/EDI inbox when purchase receipt has quantity zero
    //                     11/07/2011 issue 1369 Added transfer fiuelds "Applies-to AAD Trck. Entry No."
    //                     27/07/2011 issue 1407 Added to insert item charges on posting (field "Autom. Item Charge")
    //                                           Added functions ReleasePostItemCharges()
    //                     05/08/2011 issue 1230 Added to transfer field "Ship-to/Order Address code" into item journal line
    //                     11/08/2011 issue 1407 Skip  item charges on posting (field "Autom. Item Charge") while posting by Whse
    //                     16/08/2011 issue 1407 Added to insert promotion charge lines when "Autom. Item Charge" is 'PostingExclIem'
    //                     19/08/2011 issue 1363 Added to transfer field "Tax Date" into item journal & document
    // DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187 EMCS phase v3 Added functions CopyEmcsCommentLines()
    //                     05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)" to calculate VAT on free items
    //                     20/01/2012 DIT-715 #172 Modified workflow (+Rollback)
    //                     24/01/2012 DIT-715 #172 Bugfix VAT on free items
    //                     24/02/2012 DIT-715 #211 (#172) Bugfix calculate Line Discount on normal item while splitting invoice
    //                     21/05/2012 DIT-715 #182 Review item charge workflow when Purchase order linked to Prod. order (subcontracting)
    //                     23/05/2012 DIT-715 #345 Updated functions CreatePrepaymentLines() for all DIT item charges
    // DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added to transfer fields into gen. journal line
    //                                               "DIT Sub-Contract Type","Service Contract No.","Service Contract Line No."
    //                                               "Contract Group Code","Service Contract Type"
    //                 AHU 16/08/2012 DIT-715 #392 Bugfix to transfer header contract fields into general journal
    //                                        #327 Added checking "Service contract No."
    //                 AHU 31/08/2012 DIT-715 #327 Bugfix to skip on "Document Type" for updating Contracts
    //                                             Bugfix fields "Service Contract Type" when no GenJnlLine."Service Contract No."
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added splitting vendor total (General Journal Line) per Item charge Type
    //                     07/12/2012 DIT-715 #370 Added fields "Split Deposit on" into Drink-it tab
    //                     17/12/2012 DIT-715 #430 Bugfix to calculate "Qty. to Assign" in item charge Tax Purch lines (duty on shipment)
    //                     08/01/2013 DIT-715 #533 Skip EMCS on Combined Invoice documents
    //                 DDR 18/01/2013 DIT-715 #370 Bugfix while filling the deposit into Item jnl line (bad Invoice No.)
    //                 DDR 27/02/2013 DIT-715 #556 (#370) Bugfix function DeleteHeader()
    //                 DDR 28/02/2013 DIT-715 #540 Bugfix function CopyAndCheckItemCharges() when posting from Whse
    // DITW16.00.00.43 DDR 03/05/2013 DIT-715 #634 Bugfix to transfer SSCC tracking lines to post Whse. shipment lines
    //                 DDR 02/09/2013 DIT-715 #733 Added to call EMCS/EDI functions after shipments and return receipts
    //                 DDR 25/09/2013 DIT-715 #519 Upgrade calculation using "Tax Item No."
    //                 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    //   NORRIQ owm - Online Warehouse Management
    //   Copyright 2008 by NORRIQ A/S, www.norriq.dk
    //   - Added code to OnRun
    //                 DDR 13/11/2013 DIT-715 #753 Bugfix missing "Service Contract Type" in Cust/Vendor entries
    //                 DDR 27/11/2013 DIT-715 #727 Modified Global variables array length
    //                                               TotalpurchLineChargeType,TotalpurchLineChargeTypeLCY,PostingNoCharge
    //                                               GenJnlLineDocNoCharge,GenJnlLineExtDocNoCharge,GenJnlLineDocTypeCharge
    //                 DDR 02/12/2013 DIT-715 #862 Bugfix to read tracking if SSCC only
    //                 DDR 05/12/2013 DIT-715 #862 Bugfix to read tracking if SSCC only
    //                 DDR 10/12/2013 DIT-715 #865 Bugfix calculate item jnl quantity with Composed items
    //                 DDR 20/12/2013 DIT-715 #864 Bugfix to calculate "Unit Volume HL" with "Tax item no."
    //                 DDR 05/12/2013 DIT-715 #761 Bugfix extended sscc non-specific
    //                 DDR 20/01/2014 DIT-715 #882 Bugfix when use or not "Unit of Measure Code"
    //                 DDR 21/01/2014 DIT-715 #882 Bugfix sign of item charges
    //                 DDR 21/01/2014 DIT-715 #893 Bugfix sign of discount amount on item charges
    // DITW16.00.00.44 DDR 17/02/2014 DIT-715 #906 Bugfix to split item charges (giftbox) with item tracking lines
    //                                             Added correction DIT-770 #375
    // DITW16.00.00.44 DDR 28/03/2014 DIT-715 #915 Added more checking attached DIT item charges

    // FINXL7.00.001 RBE 20/03/2013 : Added Permissions TableData 2029611=im
    //                                Added intrastat on G/L Account
    //                                Invoice No. is shown after posting
    //                                Added code for hiding receipt message when posting invoice
    //                                Added code to show Invoice No. after posting
    //                                Keep orders after posting when everything is invoiced
    //                                No invoicing without purchase order
    // FINXL8.00.001 BSA 08/05/2015 #158 : Fix added code to show invoice no. after posting
    // FINXL8.00.001 BSA 16/06/2015 #124 : OGM Functionnality on Purchase

    // DITW16.00.00.45 DDR 27/10/2014 DIT-715 #941 Modified giftbox calc. "Unit Volume HL"

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 03/05/2013 DIT-715 #634
    //                  04/06/2013 DIT-770 #99 Added fields "Ship-to Country/Region Code" for Item journal
    //                  05/06/2013 DIT-770 #101 Added fields "Consigned Country Mandatory"
    //                  04/07/2013 DIT-770 #88 Bugfix upgrade: Free item & VAT on Free
    //                  04/07/2013 DIT-770 #99 Renamed "ship-to Country/Region Code" -> "GWC Country/Region Code"
    //                                         Added check on "GWC Country/Region code"
    //                  24/07/2013 DIT-770 #101 Added fields ItemJnlLine "Cust/Vendor DTax Group Code"
    //              DDR 19/08/2013 DIT-770 #101 Remove double field ItemJnlLine "Cust/Vendor DTax Group Code"
    //              DDR 04/09/2013 DIT-715 #733 merge
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0013.1
    //                             added code on hold unsatisfactory receipt
    // DITW17.00.02 DDR 01/10/2013 DIT-715 #519 Merge
    // DITW17.00.02 SR 10/15/2013 DIT-770 #208 : Increase Variable Array "PostingNoCharge" Dimension 5 to 9
    // DITW17.00.02 DDR 14/11/2013 DIT-715 #827 merge
    // DITW17.00.02 DDR 14/11/2013 DIT-770 #230 Added fields "DDiscount Level Position""DDiscount Include Tax","DDiscount Include Deposit"
    //                                            "DDiscount Include Discount"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 DDR 27/11/2013 DIT-715 #727 merge
    // DITW17.00.02 DDR 03/12/2013 DIT-715 #862 Merge
    // DITW17.00.02 DDR 06/12/2013 DIT-715 #862 Merge
    // DITW17.00.02 AT  06/12/2013 DIT-770 #222 : If Post Inv. Line Desc. to G/L then Allow Line Description to G/L Entries
    // DITW17.00.02 DDR 10/12/2013 DIT-715 #865 merge
    // DITW17.00.02 SR 19/12/2013 DIT-770 #163 : New Code Added to Pass Posting Group
    // DITW17.00.02 DDR 20/12/2013 DIT-715 #864 merge
    // DITW17.00.02 DDR 14/01/2014 DIT-715 #761 Merge
    // DITW17.00.02 DDR 21/01/2014 DIT-715 #882 Merge
    // DITW17.00.02 DDR 21/01/2014 DIT-715 #893 Merge
    // DITW17.00.02 DDR 23/01/2014 DIT-715 #882-893 Merge
    // DITW17.00.03 DDR 07/02/2014 DIT-770 #375 Bugfix qty base with "Unit of Measure Code" of item charges and incl. item tracking
    // DITW17.00.03 DDR 17/02/2014 DIT-715 #906 Merge
    // DITW17.00.03 DDR 17/03/2014 DIT-770 #553 OWM Scanning check Nav license
    // DITW17.00.03 DDR 28/03/2014 DIT-715 #915 Merge
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.03 MSF 28/05/2014 DIT-770 #715 Upgrade W1 Rollup 6 ChangeLog.W1.36366 file 474255
    // DITW17.10.05 MSF 17/07/2014 DIT-770 #698 (Customer)Vendor suspended tax determined per document line + internal Taxes
    //                                          Read "Cust Dtax Group Code" Purch lines
    // DITW17.10.05 DDR 19/08/2014 DIT-770 #776 Added Deposit point functionality
    // DITW17.10.05 MSF 24/10/2014 DIT-770 #770 Bugfix function CopyAndCheckItemCharge() when tax duty point shipment and
    //                                          post invoice only (+ item line not shipped)
    //                                          Bugfix function CheckItemCharge() standard NAV2013
    // DITW17.10.05 DDR 29/10/2014 DIT-715 #941 merge
    // DITW17.10.05 MSF 20/11/2014 DIT-770 #701 Added function GetLocationGroup
    //              MSF 21/11/2014 DIT-770 #701 Bug Fix
    //              MSF 26/11/2014 DIT-770 #701 Bug Fix
    //              MSF 08/12/2014 DIT-770 #701 Bug Fix
    // DITW17.10.05 MSF 11/12/2014 DIT-770 #701
    // DITW17.10.05 DDR 15/12/2014 DIT-770 #770 Bug fix wrong assigned item charge quantity test
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW17.10.05 DDR 20/01/2015 DIT-770 #581 Recalculate Deposit RoundUp/Down
    // DITW17.10.05 DDR 28/01/2015 DIT-770 #581 (#1166) Bugfix Deposit RoundUp/Down
    // DITW17.10.05 WSA 05/02/2015 DIT-770 #1210 Added code to check dim  depending on setup
    // DITW18.00.06 MSF 28/05/2015 DIT-770 #1336 Perioric discount line are not deleted after posting Credit memo
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Option DIT Contract, Service contract to Financial,Service
    //                                           Rename Field Service contract Type => Contract Type
    // DITW18.00.06 DDR 07/08/2015 DIT-770 #1368 Various adjustments
    // DITW18.00.06 DDR 20/10/2015 DIT-770 #1449 Added fields "Production BOM No.","Prod. BOM Version Code","BOM Line No.",
    //                                             "BOM Item No.","BOM Qty. per Unit of Measure"
    // DITW18.00.06 DDR 23/10/2015 DIT-770 #1395 Added Giftbox Other charges
    // DITW18.00.06 DDR 26/10/2015 DIT-770 #1412 Removed validation "Packaging Type Code"
    // DITW18.00.06A DDR 11/12/2015 DIT-770 #1678 Bugfix post item charge std. NAV
    // DITW18.00.06A DDR 15/12/2015 DIT-770 #1684 Bugfix item charge calculate on item journal with "Qty. per Unit of Measure" &"Item Charge Quantity per"
    // DITW18.00.06A DDR 08/01/2016 DIT-770 #1678 Bugfix post discount per order conflict giftbox
    // DITW18.00.07 VSC 07/01/2016 DIT-770 #1824 Purchase Invoice - "ON HOLD" not saved (due to On Hold unsatisfactory receipt modifs)
    // DITW18.00.07 DDR 11/01/2016 merge DIT-770 #1678 fob correction
    // DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Post Shipping Costs + New Functions PostShippingCosts and UpdatePostedShippingCost
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Bugfix posting on Weight and Cubage
    // DITW18.00.07 VSC 21/03/2016 DIT-770 #1228 Drop Shipment Posting Attached lines
    // DITW18.00.07 VSC 21/03/2016 DIT-770 #1228 Add Param to Function PostAssocItemJnlLine for posting Attached Lines
    // DITW18.00.07 AKH 28/03/2016 DIT-770 #1409 Added check on "Vendor Shipment No." when posting purchase receipt
    // DITW19.00.07 MVN 30/12/2015 DIT-770 #1740 Set Global: ChargeTypeInt/VendorTruckCode/VendorDriverCode/SCTrackingSpecificationExists/CurrExchRate
    //                                           Removed: TrackingQtyHandled
    //                                           Upgrade functions CreateGLItemChargeRelation() for posting preview mode
    // DITW18.00.07 DDR 14/04/2016 DIT-770 #1402 Added "Show Posting Warnings"
    // DITW18.00.07 DDR 25/04/2016 DIT-770 #1684 Bugfix remove deposit quantity recalculation while posting
    // DITW18.00.07 AKH 29/04/2016 DIT-770 #1346 Added code to handle calculation of delivery times in posted documents (lines)
    // DITW18.00.07 AKH 12/05/2016 DIT-770 #1346 Adjusted code : use of "Outstanding Qty. (Base)" instead of Quantity
    //                                                           Commented double code for calculation in receipt lines
    // DITW18.00.07 VSC 13/05/2016 DIT-770 #1915 Calculate actual Cubage and Weight
    // DITW18.00.07 VSC 26/05/2016 DIT-770 #1981 -> #1488 Purchase: OSP integration
    // DITW18.00.07 DDR 29/06/2016 DIT-770 #1228 Bugfix remove double call update charges
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields "Strength Spec. Code","Strength Spec. Value","Vol-Strength Spec. Code";"Volume Spec. Value"
    //                                                                                                           Added functions DivideVolStrength()
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Removed "strength Spec. Value","vol-strength Spec. Value"
    //                                      Removed functions DivideVolStrength()

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 20/02/2017 NRQ#21523 Upgrade error functions TestLineShpRcvTaxMandatory, TestLineInvTaxMandatory, CopyAndCheckItemCharge
    //                                        Upgrade error workflow & variables RequestSplitChargeType,RequestDutyPoint_
    // DITW110.00.08 DDR 27/02/2017 NRQ#22601 Bugfix hidden deposit item charge splitted on posted invoice document
    // DITW110.00.08 DDR 02/03/2017 NRQ#22895 Upgrade missing "shipment status" on lines after posting (if 'Return completed' value)
    // DITW110.00.08 DDR 03/03/2017 NRQ#22865 Upgrade error functions PostItemChargePerOrder()
    // DITW110.00.08 DDR 03/03/2017 NRQ#22865 Bugfix sign of "Discount Amount" (of value entry) for discount charges in function PostItemChargePerOrder()
    // DITW110.00.08 DDR 03/03/2017 NRQ#23141 Bugfix function GetItemChargeLine() missing QtyToInvoice for credit memo charge after combine
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4

    // FINXL10.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL9.00.000.01 AKH 11/01/2017 Fixed the invoice rounding error in the FINXL amount check
    // FINXL10.00 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL10.00 AKH 20/01/2017 Adjusted code after upgrade
    // FINXL10.00 AKH 24/03/2017 NRQ#0 Adjusted code for the FINXL amount check
    //                                 Made variable CurrExchRate local in function PostIntrastatEntry()
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4

    // DITW110.00.09 DDR 05/04/2017 NRQ#25340 Fix function CheckAttachedItemCharges() for warehouse & inventory pick/putaway
    // DITW110.00.09 YHE 13/04/2017 NRQ#13619 post neg qty in sales line with whse "Whse ship mandatory", "Whse receive not mandatory"
    // DITW110.00.09 DDR 14/04/2017 NRQ#13065 Fix EMCS Multi-Receipts
    // DITW110.00.09 DDR 13/04/2017 NRQ#13107 Fix EMCS Multi-ReturnShipments
    // DITW110.00.09 YHE 19/04/2017 NRQ#13131 Fix sign for "Deposit Amount" and  "Deposit Amount (LCY)"
    // DITW110.00.10 DDR 02/05/2017 NRQ#10450 Drop Shipment switched on main posting flow (disabled secondary flow)
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 DDR 09/06/2017 NRQ#10450 Fix function CopyToTempLines2 remove temporary property of PurchLine2
    // DITW110.00.10 DDR 09/06/2017 NRQ#23505 (old NRQ#22865) Bugfix sign of "Discount Amount" (of value entry) for discount charges in function PostItemChargePerOrder()
    // DITW110.00.10 DDR 14/06/2017 NRQ#10450 Fix the wrong test activation in function TestTaxShippingAgent()
    // DITW110.00.10 DDR 16/06/2017 NRQ#13173 Value entry of deposit isn't created when invoicing an item line composed of more than one lot no.
    // DITW110.00.10 DDR 30/06/2017 NRQ#10450 Fix multi drop purchase orders
    // DITW110.00.10 DDR 20/07/2017 NRQ#13173 Impossible to delete Sales order after posting Sales invoice
    // DITW110.00.10 MSF 20/07/2017 NRQ#33039 Fix deposits & taxes (line discount%) don't post GL entry anymore
    // DITW110.00.10 DDR 26/07/2017 NRQ#33039 Update Fix
    // DITW110.00.10 AKH 28/07/2017 NRQ#17189 Added Payment Method Code to function GetPaymentChargeType()
    // DITW110.00.11 SFI 30/08/2017 BL#14417 Added changes for deposit valuation
    // DITW110.00.11 DDR 08/09/2017 NRQ#36849 Fix upgrade'17 missing checking item charge function CopyAndCheckItemCharge()
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Obsolete Code Deleted
    // DITW110.00.11 DDR 05/10/2017 NRQ#22843 Fix move call of function PostShippingCosts()
    // DITW110.00.11 DDR 09/10/2017 NRQ#22843 Fix move call of function PostShippingCosts()
    // DITW110.00.12 MSF 26/03/2018 NRQ#64208 Transfer Return Registration control lignes to Posted return registration Control
    // DITW110.00.12 MSF 27/03/2018 NRQ#64208 Modified parameters  MovetoPostedReturnRegisterControl
    // DITW110.00.12A ISL 21/06/2018 NRQ#67425 Enabled the creation of service items when posting a purchase receipt
    // DITW110.00.12A MSF 04/07/2018 NRQ#75686 Invoice and credit memo with entry application may give error
    //                                         Added Function CheckIsEntryToApply
    // DITW110.00.12A MSF 05/07/2018 NRQ#75686 Apply Entries depend on one field in General ledger Setup
    // DITW110.00.12A DDR 02/08/2018 NRQ#75686 Fix/review Invoice and credit memo customer application combination "Appln. per Charge Type" (G/L setup) & "Allow Split Deposit per" (Sales Setup)
    // HEI.01 FDD-PTPGAP005 IBM SOICAD01 27.06.2017 Purchase to Pay – 3-way matching
    //   #checking of direct unit cost limits

    // HEI.02 FDD-RTRGAP056 IBM HORTOC01 25.08.2017 - new functions
    // HEI.03 FDD-PTPGAP007 IBM PATHAA02 29.08.2017-Code written in checkandupdate function
    // HEI.04 DefectID 442 IBM HORTOC01 24.10.2017 code added
    // HEI.06 PTPGAP085 - IBM HORTOC01 20.03.2018
    //   # new code
    // HEI.07 FDD RTRGAP071 IBM POSTOI01 02.05.2018
    //   # modify function PostGLOnFaReceipt to post automatically FA G/L Journal lines
    // HEI.08 FDD PTPGAP081 IBM POSTOI01 08.05.2018
    //   # disable any archive when posting an invoice or credit memo
    // HEI.09 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Code added for checking mandatory Gate Entry
    //   # Added code for updating posted Gate Entry Details

    // HEI.10 FDD-PURGAP027 IBM NASTAA02 12.06.2019 # Maximo POs Approval Flow
    //   # Code added to update also Addition Purchase Fields
    // HEI.11 FDD-HT665 - Ethiopia Customize FA Ledger Entries IBM NASTAA02 09.07.2019 # Ethiopia Customize FA Ledger Entries
    //   # Code added on function "PostInvoicePostBufferLine"
    // DITW111.00.13 DDR 11/12/2018 NRQ#35372 Fix "Allow VAT Calculation (Free)" (Upgrade Nav2013)
    // DITW111.00.13A DDR 24/06/2019 NRQ#113530 Fix wrong double insert with promotion having attached item charges in function CheckAttachedItemCharges()
    // DITW111.00.13A DDR 02/07/2019 NRQ#113530 Fix find error in function CheckAttachedItemCharges()
    // HEI.12 FDD-HT658 IBM.GUNERE01 02.09.2019 # PostShippingCosts func. modified
    // HEI.13 FDD-HT584 IBM NASTAA02 02.09.2019 # La Reunion FA Derogatory Depreciation
    //   # New function created "GetDerogatorySetup"
    // HEI.14 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Modified function
    //     # PostItemJnlLine
    // HEI.15 FDD-HT594 IBM NASTAA02 07.10.2019 # La Reunion FA Requirements Vendor
    //   # Code added on function "PostVendorEntry"
    // HEI.16 FDD-CHG2026322 IBM SURYAS01 31/10/2019
    //   #Added code on Funtion-"FinalizePosting"
    // HEI.17 CHG2039144 FDD-HT949 IBM.GUNERE01 12.02.2019 # GetWarehouseSetup, CalcTotalPerUOMShippingCosts funcs. added
    //                                                     # PostShippingCosts, UpdatePostedShippingCost funcs. modified
    // HEI.18 FDD-CHG2026322 IBM PANDES01 17/12/2019
    //   # Added code on fuction -PostUpdateOrderLine.
    //   # Created new function CheckLinesCompletelyRcvdHdrUpdate.

    // HEI.19 CHG2038746 Defect #5245 IBM GUNERE01 11.02.2020 # OnRun func. modified, PostPurchLine func. modified
    // HEI.20 CHG2059236 Defect #5439 IBM GUNERE01 03.04.2020 # HEI.19 modifications commented
    // DITW113.00.15 MSF 02/04/2019 NRQ#117628 Added Control on Document Type
    // DITW114.00.15 MSF 21/05/20 NRQ#117628 Split Function fctPostDc in two
    // HEI.21 CHG2069113 IBM.GUNERE01 18.06.2020 #PostShippingCosts, CalcTotalPerUOMShippingCosts funcs modified
    // HEI.22 CHG2086092 IBM BULIMC01 03.04.2020 #code added to remove FA GL inconistency error
    // NRQ#157810 MSF 23/09/2020 Merge DIT PBI NRQ#34181 (partial Merge only for purchase)
    // HEI.23 CHG2078084 IBM NASTAA02 08.10.2020 # Retrofit Gate Control Ethiopia
    //   # Code added on function 'InsertReturnShipmentHeader' to fill-in Gate Entry No. for Purchase Return Orders also
    // NRQ#168174 MSF 07/01/2021 Error message when creating a purchase credit memo
    // HEI.25 CHG2090912 HB1641 IBM NANDIS01 01.02.2021 General Ledger Entries Description
    //   # Code added in function - FillInvoicePostBuffer, PostVendorEntry, PostBalancingEntry, PostInvicePostBufferLine
    //   # New function added - PopulateAdditionalDesc
    // HEI.24 CHG2068359 IBM BULIMC01 01/02/2021 #adjustments on the function "CreateGLItemChargeRelation" to create GL-Item relation for all the item charge lines
    // CHG2104608: DITW111.00.13 ISL 18/12/2018 NRQ#96024 Updated code (Deleted field "Prod. BOM Version Code")
    // HEI.26 CHG2100218 IBM SAXENA03 25.03.2021
    //   # Replace INSERT with INSERT(FALSE) of function CopyToTempLines()
    // NRQ#177003 DDR 29/03/2021 Add "Tax Due Posting to G/L" to post discount item charge like tax
    // HEI.27 CHG2119178 IBM.AS 30.06.2021
    //   # HeiLite Base Stability Changes for Posting functions at JOB NAS
    //   # Adding GUIAllowed function added in Functions CheckItemReservDisruption(),
    //     CheckICDocumentDuplicatePosting(),
    //     CheckAndUpdateOnHoldReasonCode(),
    //     TestLineTariffNoMandatory(),
    //     PostAssocReturnOrders(),
    //     ShowPostedDocumentInfo() for JOB Execution to avoid any manual intervention
    // HEI.28 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # VAT Centime - part 2 - Purchases
    //   # Code added on Functions 'SumPurchLinesTemp', 'PostPurchLine'
    // HEI.29 CHG2125067 IBM SHIVAS05 07-09-2021 Bypassing Testfield when Blanket order line type=G/L account
    //        and purchase order line=Fixed Asset for SRM blanket order on function UpdateBlanketOrderLine
    // HEI.30 Defect 5302 BULIMC01 IBM 18.09.2021 # fix inconsistency error when posting an invoice with CAD Amount and WHT amount
    //      #code added to function "PostVendorEntry"
    // HEI.31 CHG2126574 BULIMC01 IBM 04.10.2021 # fix inconsistency error when posting an invoice with prepayment roundings
    //      #code added to function "UpdatePrepmtPurchLineWithRounding"
    // HEI.32 CHG2132399 INC3707788 IBM GAVANM01 20.10.2021 # Auto Sales give system error BrewCo
    //   # Code added
    // HEI.33 INC3807811 - CHG2133559  IBM NASTAA02 04.11.2021 #CAD calculation on PQ for Maximo
    //   # Additional CAD lines should be added just just before posting
    // HEI.34 FDD-HB2482 CHG2123206 IBM NANDIS01 09.11.2021 - Improvement of multiple HeiLite reports for StP  Procurement users
    //   # Added code to flow Purchase Order No in POsted Purch Inv Line
    // DITW114.00.15 DDR 24/04/2020 NRQ#102424 Fix skip checking discount(order) & promotion quantity Ship/Receive/Return/Invoice
    // HEI.35 CHG2188015 DEBUSD01 10.01.2023 Qty to Ship behavior on promotionline partialShipments
    //   # merge NRQ#102424
    // HEI.36 CHG2155847 HB2821 IBM NANDIS01 24.02.2023 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Blank Astro Unique ID once doc is posted
    // HEI.38 CHG2132418 FDD-HB2311 IBM NANDIS01 10.03.2023 # Development Correct posting invoicing FA
    //   # Blocked function - UpdateFaGLEntry
    //   # Code modified in function - FillInvoicePostBuffer PostInvoicePostingBuffer
    // HEI.39 CHG2132418 FDD-HB2311 IBM NANDIS01 16.03.2023 # Development Correct posting invoicing FA
    //   # update the unit cost from "Unit COst(LCY)"
    // HEI.40 CHG2203172 CC IBM NANDIS01 03.05.2023 # Assistant on Base posting error notification
    //   # Rounded the amount field value to avoid error
    // HEI.42 CHG2200434 FDD-HB3431 IBM MAJUMS03 31.05.2023 # Column Data Availability of WH Shipment & WH Receipt No. stated in all Posted Documents for all Customer
    // Distribution, Inter-Brewery Transfers & Purchased Mater
    //   # New Code is added in "InsertReceiptHeader" Function to push the Posted Warehouse Receipet No. at newly added Field "Posted Warehouse Receipt No."(Field ID.
    //   50050) in "Purch. Rcpt. Header" Table(Table ID. 120).
    // HEI.37 CHG2148350 FDD-HB2777 IBM NANDIS01 28.02.2023 # develop confirmation check interface for HL
    //   # New function created - PreviewSRMInterface; similar to Preview function to get it called for SRM GR Validation interface only
    // HEI.43 FDD-HB2311 CHG2200648 IBM NANDIS01 12-06-2023 #Correct posting flow FA invoicing (credit notes)
    //   # New functionality of FA return order and credit memo introduced
    // HEI.44 FDD-HB2311 CHG2200648 IBM NANDIS01 20-06-2023 #Correct posting flow FA invoicing (credit notes)
    //   # Fix on credit memo as CAD was calculating wrong amount
    // HEI.41 CHG2190299 FDD-HB3316 IBM NANDIS01 24.05.2023 # POSM eshop SRM- HL interface
    //   # New function added to create outbound entries for POSM
    // HEI.45 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //   # New function created #Divideamount2
    // HEI.46 CHG2229933 HB3689 IBM SRIVAS07 25.04.2024 # SRM Reference Document Mapping - Development
    //   # Added code - InsertReceiptLine()
    // HEI.47 CHG2210794 HB3493 VERMAA03 14.06.2024 Zycus -BASE integration with POSM GR
    //   # Added Code - FinalizePosting()
    // HEI.48 CHG2210794 SAHAL01 28.06.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added Code
    // HEI.49 CHG2278614 SAHAL01 27.11.2024 E2E test for Zycus HL integration
    //   # Added Code
    // HEI.52 CHG2329064 IBM SAHAL01 10.11.2025 Invoices Posting Issue CAD
    // HEI.51 CHG2317685 SAHAL01 17.10.2025 Block Functionality Enhancement for Vendors
    //   # Added Code
    //---------------------------------------------BC UpgradeSHARMP16 Documentation-------------------------
    //HEI.04-->> Done,Interface related code--> need to shift to Interface Extension
    //HEI.05-->PostVendorEntry Pending Not Found in CU in BC need to check 826 Cu--> Used --OnPostLedgerEntryOnBeforeGenJnlPostLine- in Cu 886 used .
    //HEI.06-->PostVendorEntry Pending Not Found in CU in BC need to check 826 Cu--OnPostLedgerEntryOnBeforeGenJnlPostLine- in Cu 886 used .
    //HEI.09-->From line 7543 InsertReceiptLine procedure code-- rewrite the code in a correct way to pass the boolean
    //HEI.10-->TestDeleteHeader  procedure Not Found in BC and related Delete Header func. obsolete in BC -- So let the base functionality run
    //HEI.11-->PostInvoicePostBufferLine move to 826 CU--> used OnBeforeInitGenJnlLine in 826 Cu

    // BC UPGRADE PATELS08 >>
    // # In Procedures PostFaGlEntryDiff2CreditMemo, PostFaGlEntry, PostGLOnFaReceipt
    //      (1) Changed the parameter DocType to Enum "Gen. Journal Document Type" from Option to avoid implicit conversion.
    //      (2) Blocked 'With' statement as it is deprecated and prefixed variables with 'GenJnlLine' to give reference.
    // # In Procedure PostGLOnFaReceipt , blocked 'FindSet(FALSE, FALSE)' is being deprecated, thus using the oveloaded method instead.
    // # Changed the Global variable GenJnlLineDocType to Enum "Gen. Journal Document Type" from Integer to avoid implicit conversion.
    // BC UPGRADE PATELS08 <<
    //-------------------------------------------------------PurchPostFACaseBEGIN<<-------------------------------------------------------------------------------
    // Purch Post FA related posting Code completed and tested 
    //-------------------------------------------------------PurchPostFACaseEND>>-------------------------------------------------------------------------------

    Permissions = tabledata "Approval Entry" = RIMD,//BC Upgrade SHARMP16 PurchProcesschanges
  tabledata "Dimension Set Entry" = RIM,//BC Upgrade SHARMP16 GAPFitchanges
    tabledata "G/L Entry" = rimd;
    trigger OnRun()
    begin

    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterCheckPurchDoc, '', false, false)]
    // local procedure OnAfterCheckPurchDoc(var PurchHeader: Record "Purchase Header")
    // var
    //     PaymentMethod: record "Payment Method";
    // begin
    //     // HEI.03 FDD-PTPGAP007 IBM PATHAA02 29.08.17>>
    //     IF PurchHeader.Invoice THEN
    //         IF PurchHeader."Document Type" IN [PurchHeader."Document Type"::Order, PurchHeader."Document Type"::Invoice] THEN
    //             IF PaymentMethod.GET(PurchHeader."Payment Method Code") THEN
    //                 IF PaymentMethod."Mandatory Bank details" THEN BEGIN
    //                     PurchHeader.TESTFIELD("Vendor Bank Account");
    //                     // IF NOT  HeinekenGlobal.CheckBankDetails("Buy-from Vendor No.","Vendor Bank Account") THEN
    //                     //  ERROR(Text50000,"Vendor Bank Account");
    //                 END;
    //     //HEI.03 FDD-PTPGAP007 IBM PATHAA02 29.08.17<<
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnPostLedgerEntryOnBeforeGenJnlPostLine, '', false, false)]
    local procedure OnPostLedgerEntryOnBeforeGenJnlPostLine(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line")
    var
        PurchaseLine: record "Purchase Line";
        GeneralLedgerSetup: record "General Ledger Setup";
        TotalWHTLCY: Decimal;

        CurrExchRate: record "Currency Exchange Rate";
    begin
        //HEI.05 PATHAA02 PTPGAP041 26.10.17>>
        GenJnlLine."Payment Status FND" := PurchHeader."Payment Status FND";
        //HEI.05 PATHAA02 PTPGAP041 26.10.17<<
        //HEI.06>>
        PurchHeader.CALCFIELDS("On Hold Date FND", "On Hold UserID FND");
        GenJnlLine."On Hold Date FND" := PurchHeader."On Hold Date FND";
        GenJnlLine."On Hold UserID FND" := PurchHeader."On Hold UserID FND";
        //HEI.06<<
        GenJnlLine."Fixed Asset Acquisition FND" := PurchHeader."Fixed Asset Acquisition FND"; //HEI.15

        //HEI.28>>
        //Update Total Amount Incl. VAT to include also CAD
        GeneralLedgerSetup.GET();
        IF GeneralLedgerSetup."Enable CAD FND" AND (TotalPurchLine."CAD Amount FND" <> 0) THEN BEGIN
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", PurchHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchHeader."No.");
            PurchaseLine.SETFILTER("CAD Attached to Line No. FND", '<>%1', 0);
            IF NOT PurchaseLine.FINDFIRST() THEN BEGIN
                IF PurchHeader."Document Type" IN [PurchHeader."Document Type"::Order, PurchHeader."Document Type"::Invoice] THEN BEGIN
                    //HEI.30<<
                    TotalWHTLCY := 0;
                    IF TotalWHTAmount <> 0 THEN BEGIN
                        GenJnlLine.Amount := -(TotalPurchLine."Amount Including VAT" + TotalPurchLine."CAD Amount FND" - TotalWHTAmount);
                        GenJnlLine."Source Currency Amount" := -(TotalPurchLine."Amount Including VAT" + TotalPurchLine."CAD Amount FND" - TotalWHTAmount);
                        IF PurchHeader."Currency Code" <> '' THEN
                            TotalWHTLCY :=
                              ROUND(
                                CurrExchRate.ExchangeAmtFCYToLCY(
                                  PurchHeader."Posting Date", PurchHeader."Currency Code", TotalWHTAmount, PurchHeader."Currency Factor"));
                        GenJnlLine."Amount (LCY)" := -(TotalPurchLineLCY."Amount Including VAT" + TotalPurchLineLCY."CAD Amount FND" - TotalWHTLCY);
                    END ELSE BEGIN
                        //HEI.30>>
                        GenJnlLine.Amount := -TotalPurchLine."Amount Including VAT" - TotalPurchLine."CAD Amount FND";
                        GenJnlLine."Source Currency Amount" := -TotalPurchLine."Amount Including VAT" - TotalPurchLine."CAD Amount FND";
                        GenJnlLine."Amount (LCY)" := -TotalPurchLineLCY."Amount Including VAT" - TotalPurchLineLCY."CAD Amount FND";
                    END; //HEI.30
                END;
                IF PurchHeader."Document Type" IN [PurchHeader."Document Type"::"Return Order", PurchHeader."Document Type"::"Credit Memo"] THEN BEGIN
                    GenJnlLine.Amount := ABS(TotalPurchLine."Amount Including VAT" - TotalPurchLine."CAD Amount FND");
                    GenJnlLine."Source Currency Amount" := ABS(TotalPurchLine."Amount Including VAT" - TotalPurchLine."CAD Amount FND");
                    GenJnlLine."Amount (LCY)" := ABS(TotalPurchLineLCY."Amount Including VAT" - TotalPurchLineLCY."CAD Amount FND");
                END;
            END;
        END;
        //HEI.28<<


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterDeleteAfterPosting, '', false, false)]
    local procedure OnAfterDeleteAfterPosting(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; PurchHeader: Record "Purchase Header"; PurchInvHeader: Record "Purch. Inv. Header")
    var
        HeinekenGlobal: Codeunit "Heineken Global";
    begin
        //HEI.06>>
        HeinekenGlobal.DeletePurchHeaderExt(38, PurchHeader);
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterPurchCrMemoHeaderInsert, '', false, false)]
    local procedure OnAfterPurchCrMemoHeaderInsert(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchHeader: Record "Purchase Header")
    var
        PurchaseHeaderAdditional: record "Purchase Header Additional FND";
        PurchCrMemoHdrAddition: Record "Purch. Cr. Memo Hdr. Add FND";
        HeinekenGlobal: codeunit "Heineken Global";
        PurchHeaderExtDocType: Option "Posted Invoice","Posted Cr. Memo","Posted Receipt";
    begin
        //HEI.10>>
        IF PurchaseHeaderAdditional.GET(PurchHeader."Document Type", PurchHeader."No.") THEN
            IF NOT PurchCrMemoHdrAddition.GET(PurchaseHeaderAdditional."No.") THEN BEGIN
                PurchCrMemoHdrAddition.INIT();
                PurchCrMemoHdrAddition.TRANSFERFIELDS(PurchaseHeaderAdditional);
                PurchCrMemoHdrAddition."No." := PurchCrMemoHdr."No.";
                PurchCrMemoHdrAddition.INSERT();
            END;
        //HEI.10<<

        //HEI.06>>
        PurchHeader.CALCFIELDS("On Hold Date FND", "On Hold UserID FND");
        HeinekenGlobal.InsertPurchaseHeaderExt(PurchHeaderExtDocType::"Posted Cr. Memo", PurchCrMemoHdr."No.", PurchHeader."On Hold UserID FND", PurchHeader."On Hold Date FND");
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterPurchInvHeaderInsert, '', false, false)]
    local procedure OnAfterPurchInvHeaderInsert(var PurchHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header")
    var
        PurchInvHeaderAdditional: record "Purch. Inv. Header Add FND";
        SalesShipHeaderAdditional: Record "Sales Ship. Header Add FND";
        PurchaseHeaderAdditional: record "Purchase Header Additional FND";
        HeinekenGlobal: codeunit "Heineken Global";
        PurchHeaderExtDocType: Option "Posted Invoice","Posted Cr. Memo","Posted Receipt";
    begin
        //HEI.10>>
        IF PurchaseHeaderAdditional.GET(PurchHeader."Document Type", PurchHeader."No.") THEN
            IF NOT PurchInvHeaderAdditional.GET(PurchaseHeaderAdditional."No.") THEN BEGIN
                PurchInvHeaderAdditional.INIT();
                PurchInvHeaderAdditional.TRANSFERFIELDS(PurchaseHeaderAdditional);
                PurchInvHeaderAdditional."No." := PurchInvHeader."No.";
                PurchInvHeaderAdditional.INSERT();
            END;
        //HEI.10<<
        //HEI.06>>
        PurchHeader.CALCFIELDS("On Hold Date FND", "On Hold UserID FND");
        HeinekenGlobal.InsertPurchaseHeaderExt(PurchHeaderExtDocType::"Posted Invoice", PurchInvHeader."No.", PurchHeader."On Hold UserID FND", PurchHeader."On Hold Date FND");
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterPurchRcptHeaderInsert, '', false, false)]
    local procedure OnAfterPurchRcptHeaderInsert(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header")
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
        HeinekenGlobal: Codeunit "Heineken Global";
        PurchHeaderExtDocType: Option "Posted Invoice","Posted Cr. Memo","Posted Receipt";
    begin
        //HEI.10>>
        IF PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") THEN
            IF NOT PurchRcptHeaderAdditional.GET(PurchaseHeaderAdditional."No.") THEN BEGIN
                PurchRcptHeaderAdditional.INIT();
                PurchRcptHeaderAdditional.TRANSFERFIELDS(PurchaseHeaderAdditional);
                PurchRcptHeaderAdditional."No." := PurchRcptHeader."No.";
                PurchRcptHeaderAdditional.INSERT();
            END;
        //HEI.10<<
        //HEI.06>>
        PurchaseHeader.CALCFIELDS("On Hold Date FND", "On Hold UserID FND");
        HeinekenGlobal.InsertPurchaseHeaderExt(PurchHeaderExtDocType::"Posted Receipt", PurchRcptHeader."No.", PurchaseHeader."On Hold UserID FND", PurchaseHeader."On Hold Date FND");
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnFinalizePostingOnBeforeUpdateAfterPosting, '', false, false)]
    local procedure OnFinalizePostingOnBeforeUpdateAfterPosting(var PurchHeader: Record "Purchase Header")
    var
        ArchiveManagement: Codeunit ArchiveManagement;
    begin
        //HEI.08 comment line   ArchiveManagement.AutoArchivePurchDocument(PurchHeader);
        //<<HEI.08
        IF NOT ((PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice) OR (PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo")) THEN
            ArchiveManagement.AutoArchivePurchDocument(PurchHeader);
        //HEI.08<<
    end;
    //Bc Upgrade code rewrite one for WhsRcpt>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnInsertReceiptLineOnAfterInitPurchRcptLine, '', false, false)]
    local procedure OnInsertReceiptLineOnAfterInitPurchRcptLine(ItemLedgShptEntryNo: Integer; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header"; PurchLine: Record "Purchase Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchRcptLine: Record "Purch. Rcpt. Line"; var WhseRcptLine: Record "Warehouse Receipt Line"; WhseRcptHeader: Record "Warehouse Receipt Header"; xPurchLine: Record "Purchase Line")
    var
        GateEntryLoc: code[20];
        GateEntryZone: code[20];
        WhseShptHeader: Record "Warehouse Shipment Header";
        WhseShpt: Boolean;

    begin
        //BC Upgrade SHARMP16 Begin>>
        Clear(WhseShpt);
        WhseShptHeader.reset();
        WhseShptHeader.SetRange("Source Document Type FND", WhseShptHeader."Source Document Type FND"::"Purchase Order");
        WhseShptHeader.setrange("Source No. FND", PurchLine."Document No.");
        WhseShptHeader.setfilter("No.", '<>%1', '');
        if WhseShptHeader.findset() then begin
            WhseShpt := true;
        end;
        //BC Upgrade SHARMP16 END<<
        //HEI.09>>
        GateEntryLoc := PurchRcptHeader."Location Code";
        IF WhseShpt THEN BEGIN
            GateEntryLoc := WhseShptHeader."Location Code";
            GateEntryZone := WhseShptHeader."Zone Code";
        END ELSE IF WhseRcptHeader."No." <> '' THEN BEGIN
            GateEntryLoc := WhseRcptHeader."Location Code";
            GateEntryZone := WhseRcptHeader."Zone Code";
        END;

        IF IsPurchGateEntryMandatory(GateEntryLoc, GateEntryZone) THEN BEGIN
            PurchRcptHeader.TESTFIELD("Gate Entry No. FND");
            PurchRcptLine."Gate Entry No. FND" := PurchRcptHeader."Gate Entry No. FND";
            if (WhseRcptLine."No." <> '') or WhseShpt then
                //BC UPGRADE KUMARR78 >> FDD-MTC-007
                // UpdateInboundGateEntry(PurchRcptLine."Gate Entry No.", PurchRcptLine.Quantity, PurchRcptLine."No.", PurchRcptLine."Net Weight",
                //                        PurchRcptLine."Unit of Measure Code", PurchRcptHeader."Location Code");

                UpdateInboundGateEntry(PurchRcptLine."Gate Entry No. FND", PurchRcptLine.Quantity, PurchRcptLine."No.", PurchRcptLine."Gross Weight 1 101FDW",
                                       PurchRcptLine."Unit of Measure Code", PurchRcptHeader."Location Code");
            //BC UPGRADE KUMARR78 >> FDD-MTC-007
        END;


        //HEI.09<<
        //PurchRcptLine."Vendor Shipment No." := TempPurchLine3."Vendor Shipment No.";//HEI.46

    end;
    //Bc Upgrade code rewrite one for WhsRcpt<<
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforeReturnShptHeaderInsert, '', false, false)]
    local procedure OnBeforeReturnShptHeaderInsert(var PurchHeader: Record "Purchase Header"; var ReturnShptHeader: Record "Return Shipment Header"; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        PurchSetup: record "Purchases & Payables Setup";
    begin
        //HEI.23>>
        IF WarehouseReceiptHeader."Gate Entry No. FND" <> '' THEN
            ReturnShptHeader."Gate Entry No. FND" := WarehouseReceiptHeader."Gate Entry No. FND" //HEI.09
        ELSE IF WarehouseReceiptHeader."Gate Entry No. FND" <> '' THEN
            ReturnShptHeader."Gate Entry No. FND" := WarehouseReceiptHeader."Gate Entry No. FND";
        //HEI.23<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePurchRcptHeaderInsert, '', false, false)]
    local procedure OnBeforePurchRcptHeaderInsert(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WhseReceive: Boolean; WhseShip: Boolean)
    var

    begin
        //HEI.09>>
        IF WhseShip THEN
            PurchRcptHeader."Gate Entry No. FND" := WarehouseShipmentHeader."Gate Entry No. FND"
        ELSE IF WhseReceive THEN
            PurchRcptHeader."Gate Entry No. FND" := WarehouseReceiptHeader."Gate Entry No. FND";
        //HEI.09<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterReturnShptHeaderInsert, '', false, false)]
    local procedure OnAfterReturnShptHeaderInsert(var PurchHeader: Record "Purchase Header"; var ReturnShptHeader: Record "Return Shipment Header")
    var
        PurchaseHeaderAdditional: record "Purchase Header Additional FND";
        SalesShipHeaderAdditional: Record "Sales Ship. Header Add FND";
    begin
        //HEI.10>>
        IF PurchaseHeaderAdditional.GET(PurchHeader."Document Type", PurchHeader."No.") THEN BEGIN
            SalesShipHeaderAdditional.INIT();
            SalesShipHeaderAdditional.TRANSFERFIELDS(PurchaseHeaderAdditional);
            SalesShipHeaderAdditional."No." := ReturnShptHeader."No.";
            SalesShipHeaderAdditional.INSERT();
        END;
        //HEI.10<<
    end;
    //BCUpgrade SHARMP16 BEGIN<<--commented rewrite the logic
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnBeforeInitGenJnlLine, '', false, false)]
    // local procedure OnBeforeInitGenJnlLine(InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary; PurchHeader: Record "Purchase Header"; var GenJnlLine: Record "Gen. Journal Line")
    // var
    //     PurchRcptHeader2: record "Purch. Rcpt. Header";
    //     GLSetup: Record "General Ledger Setup";    // BC Upgrade SHUKLP03 <<
    // begin
    //     GLSetup.Get();  // BC Upgrade SHUKLP03 <<
    //     //HEI.11>>
    //     IF (GenJnlLine."Source Type" = GenJnlLine."Source Type"::Vendor) THEN BEGIN
    //         GenJnlLine."Reference Number FND" := PurchHeader."Your Reference";
    //         IF (PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice) OR
    //            (PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo")
    //         THEN BEGIN
    //             IF PurchHeader."Purchase Order No. FND" <> '' THEN
    //                 GenJnlLine."PO Number FND" := PurchHeader."Purchase Order No. FND"
    //             ELSE
    //                 IF PurchRcptHeader2.GET(InvoicePostingBuffer."Purchase Receipt No.") THEN
    //                     GenJnlLine."PO Number FND" := PurchRcptHeader2."Order No.";
    //         END ELSE
    //             IF (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) OR
    //                (PurchHeader."Document Type" = PurchHeader."Document Type"::"Return Order")
    //             THEN
    //                 GenJnlLine."PO Number FND" := PurchHeader."No.";
    //     END;
    //     //HEI.11<<
    //     //HEI.25>>
    //     GenJnlLine."Additional Description FND" := InvoicePostingBuffer."Additional Description FND";

    //     //HEI.25<<

    //     //HEI.02>>
    //     //IF FASetup."Post GL on Purch. Receive FND" AND (TempInvoicePostBuffer.Type = TempInvoicePostBuffer.Type::"Fixed Asset") AND (TempInvoicePostBuffer."Purchase Receipt Amount" <> 0 ) THEN BEGIN  //HEI.43
    //     IF (PurchHeader."Document Type" <> PurchHeader."Document Type"::"Credit Memo") AND   //HEI.43
    //             FASetup."Post GL on Purch. Receive FND" AND (InvoicePostingBuffer.Type = InvoicePostingBuffer.Type::"Fixed Asset") AND (InvoicePostingBuffer."Purchase Receipt Amount" <> 0) THEN BEGIN  //HEI.43
    //         IF PurchHeader.Invoice THEN BEGIN
    //             IF InvoicePostingBuffer.Amount <> InvoicePostingBuffer."Purchase Receipt Amount" THEN BEGIN
    //                 //   UpdateFaGLEntry(PurchInvHeader, InvoicePostingBuffer);//BC Upgrade SHARMP16 full code commmented inside this func in NAV
    //                 //HEI.38>>
    //                 //TempInvoicePostBuffer.Amount := TempInvoicePostBuffer.Amount - TempInvoicePostBuffer."Purchase Receipt Amount";
    //                 InvoicePostingBuffer.Amount := InvoicePostingBuffer.Amount - (InvoicePostingBuffer.Quantity * InvoicePostingBuffer."Purchase Receipt Unit Cost FND");
    //                 //HEI.38<<
    //                 InvoicePostingBuffer.Amount := ROUND(InvoicePostingBuffer.Amount, GLSetup."Amount Rounding Precision");//HEI.40
    //                                                                                                                        // GLEntryNo := PostInvoicePostBufferLine(PurchHeader, InvoicePostingBuffer);//BC Upgrade SHARMP16-- function obsolete in BC
    //                 PostGLOnFaDiffOnInvoice(PurchHeader, InvoicePostingBuffer);
    //             END ELSE BEGIN
    //                 // UpdateFaGLEntry(PurchInvHeader, InvoicePostingBuffer);//BC Upgrade SHARMP16 full code commmented inside this func in NAV
    //                 InvoicePostingBuffer.Amount := InvoicePostingBuffer.Amount - InvoicePostingBuffer."Purchase Receipt Amount";
    //                 // GLEntryNo := PostInvoicePostBufferLine(PurchHeader, InvoicePostingBuffer);//BC Upgrade SHARMP16-- function obsolete in BC
    //             END;
    //             //HEI.02<<
    //             // END ELSE
    //             // GLEntryNo := PostInvoicePostBufferLine(PurchHeader, InvoicePostingBuffer)//BC Upgrade SHARMP16-- function obsolete in BC
    //         end;
    //     end;
    //     FASetup.Get();
    //     IF (PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo") AND
    //     //(FASetup."Post GL on Purchase Return FND") AND (TempInvoicePostBuffer.Type = TempInvoicePostBuffer.Type::"Fixed Asset") AND PurchHeader.IsCreditDocType THEN BEGIN  //HEI.44
    //     (FASetup."Post GL on Purchase Return FND") AND (InvoicePostingBuffer.Type = InvoicePostingBuffer.Type::"Fixed Asset") AND (InvoicePostingBuffer."Purchase Receipt Amount" <> 0) THEN BEGIN  //HEI.44
    //         IF PurchHeader.Invoice THEN BEGIN
    //             IF InvoicePostingBuffer.Amount <> InvoicePostingBuffer."Purchase Receipt Amount" THEN BEGIN
    //                 //UpdateFaGLEntry(PurchCrMemoHeader,TempInvoicePostBuffer); //blank function commented
    //                 InvoicePostingBuffer.Amount := InvoicePostingBuffer.Amount + (InvoicePostingBuffer.Quantity * InvoicePostingBuffer."Purchase Receipt Unit Cost FND");
    //                 InvoicePostingBuffer.Amount := ROUND(InvoicePostingBuffer.Amount, GLSetup."Amount Rounding Precision");
    //                 // GLEntryNo := PostInvoicePostBufferLine(PurchHeader, InvoicePostingBuffer);//BC Upgrade SHARMP16-- function obsolete in BC
    //                 PostGLOnFaDiffOnCreditMemo(PurchHeader, InvoicePostingBuffer);
    //             END ELSE BEGIN
    //                 //UpdateFaGLEntry(PurchCrMemoHeader,TempInvoicePostBuffer); //blank function commented
    //                 InvoicePostingBuffer.Amount := InvoicePostingBuffer.Amount - InvoicePostingBuffer."Purchase Receipt Amount";
    //                 //GLEntryNo := PostInvoicePostBufferLine(PurchHeader, InvoicePostingBuffer);//BC Upgrade SHARMP16-- function obsolete in BC
    //             END;
    //             // END ELSE
    //             //GLEntryNo := PostInvoicePostBufferLine(PurchHeader, InvoicePostingBuffer)//BC Upgrade SHARMP16-- function obsolete in BC
    //             //HEI.43<<
    //             // END ELSE
    //             //     GLEntryNo := PostInvoicePostBufferLine(PurchHeader, InvoicePostingBuffer);//BC Upgrade SHARMP16-- function obsolete in BC
    //         end;
    //     end;
    // end;
    //BCUpgrade SHARMP16 END>>--commented rewrite the logic
    procedure PostGLOnFaDiffOnInvoice(VAR PurchHeader: Record "Purchase Header"; VAR TempInvoicePostBuffer: Record "Invoice Posting Buffer" temporary)
    var
        myInt: Integer;
    begin
        //HEI.02>>
        IF (TempInvoicePostBuffer.Type = TempInvoicePostBuffer.Type::"Fixed Asset") THEN BEGIN
            GenJnlLineDocType := GenJnlLineType."Document Type"::Invoice;
            GenJnlLineDocNo := PurchInvHeader."No.";
            GenJnlLineExtDocNo := PurchHeader."Vendor Invoice No.";
            TotalPurchLine.Amount := TotalPurchLine.Amount - TempInvoicePostBuffer."Purchase Receipt Amount FND";
            TotalPurchLine."Amount Including VAT" := TotalPurchLine."Amount Including VAT" - TempInvoicePostBuffer."Purchase Receipt Amount FND";

            //PostFaGlEntryDiff(
            //    PurchHeader,TotalPurchLine,TotalPurchLineLCY,GenJnlLineDocType,GenJnlLineDocNo,GenJnlLineExtDocNo,SrcCode);
            PostFaGlEntryDiff2(
                PurchHeader, TempInvoicePostBuffer, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode);
        END;
        //HEI.02<<

    end;

    procedure PostGLOnFaDiffOnCreditMemo(VAR PurchHeader: Record "Purchase Header"; VAR TempInvoicePostBuffer: Record "Invoice Posting Buffer" temporary)
    var
        myInt: Integer;
    begin
        //HEI.43>>
        IF (TempInvoicePostBuffer.Type = TempInvoicePostBuffer.Type::"Fixed Asset") THEN BEGIN
            GenJnlLineDocType := GenJnlLineType."Document Type"::"Credit Memo";
            GenJnlLineDocNo := PurchCrMemoHeader."No.";
            GenJnlLineExtDocNo := PurchHeader."Vendor Cr. Memo No.";
            TotalPurchLine.Amount := TotalPurchLine.Amount - TempInvoicePostBuffer."Purchase Receipt Amount FND";
            TotalPurchLine."Amount Including VAT" := TotalPurchLine."Amount Including VAT" - TempInvoicePostBuffer."Purchase Receipt Amount FND";

            PostFaGlEntryDiff2CreditMemo(
                PurchHeader, TempInvoicePostBuffer, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode);
        END;
        //HEI.43<<

    end;

    // BC UPGRADE PATELS08 >> # Changed the parameter DocType to Enum "Gen. Journal Document Type" from Option to avoid implicit conversion.
    // procedure PostFaGlEntryDiff2CreditMemo(PurchHeader: Record "Purchase Header"; TempInvoicePostBuffer: Record "Invoice Posting Buffer"; DocType: Option; DocNo: Code[20]; ExtDocNo: Code[35]; SourceCode: Code[10])
    procedure PostFaGlEntryDiff2CreditMemo(PurchHeader: Record "Purchase Header"; TempInvoicePostBuffer: Record "Invoice Posting Buffer"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20]; ExtDocNo: Code[35]; SourceCode: Code[10])
    // BC UPGRADE PATELS08 <<
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        //HEI.43>>
        FASetup.GET();
        FASetup.TESTFIELD("Payable Acc. Purch. Return FND");
        // BC UPGRADE PATELS08 >> # Blocked 'With' statement as it is deprecated and prefixed variables with 'GenJnlLine' to give reference.
        // WITH GenJnlLine DO BEGIN
        // InitNewLine(
        //   PurchHeader."Posting Date", PurchHeader."Document Date", 0D, PurchHeader."Posting Description",
        //   PurchHeader."Shortcut Dimension 1 Code", PurchHeader."Shortcut Dimension 2 Code",
        //   PurchHeader."Dimension Set ID", PurchHeader."Reason Code");
        GenJnlLine.InitNewLine(
          PurchHeader."Posting Date", PurchHeader."Document Date", 0D, PurchHeader."Posting Description",
          PurchHeader."Shortcut Dimension 1 Code", PurchHeader."Shortcut Dimension 2 Code",
          PurchHeader."Dimension Set ID", PurchHeader."Reason Code");

        // CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');
        GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');

        // "Account Type" := "Account Type"::"G/L Account";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";

        //"Account No." := FASetup."Payable Acc.Purch. Receipt FND";  //HEI.44
        // "Account No." := FASetup."Payable Acc. Purch. Return FND";  //HEI.44
        GenJnlLine."Account No." := FASetup."Payable Acc. Purch. Return FND";  //HEI.44

        // CopyFromPurchHeader(PurchHeader);
        GenJnlLine.CopyFromPurchHeader(PurchHeader);
        // SetCurrencyFactor(PurchHeader."Currency Code", PurchHeader."Currency Factor");
        GenJnlLine.SetCurrencyFactor(PurchHeader."Currency Code", PurchHeader."Currency Factor");
        // "System-Created Entry" := TRUE;
        GenJnlLine."System-Created Entry" := TRUE;

        // CopyFromPurchHeaderApplyTo(PurchHeader);
        GenJnlLine.CopyFromPurchHeaderApplyTo(PurchHeader);
        // CopyFromPurchHeaderPayment(PurchHeader);
        GenJnlLine.CopyFromPurchHeaderPayment(PurchHeader);
        // "Pmt. Discount Date" := 0D;
        GenJnlLine."Pmt. Discount Date" := 0D;

        // Amount := -TempInvoicePostBuffer.Amount;
        GenJnlLine.Amount := -TempInvoicePostBuffer.Amount;
        // "Source Currency Amount" := -TempInvoicePostBuffer.Amount;
        GenJnlLine."Source Currency Amount" := -TempInvoicePostBuffer.Amount;
        // "Amount (LCY)" := -TempInvoicePostBuffer.Amount;
        GenJnlLine."Amount (LCY)" := -TempInvoicePostBuffer.Amount;
        GenJnlPostLine.RunWithCheck(GenJnlLine);
        // END;
        // BC UPGRADE PATELS08 <<
        //HEI.43<<

    end;

    // procedure PostGLOnFaReceipt(VAR PurchHeader: Record "Purchase Header"; VAR TempInvoicePostBuffer: Record "Invoice Posting Buffer")
    // var
    //     GenJournalLine: Record "Gen. Journal Line";
    //     FAJnlSetup: Record "FA Journal Setup";
    //     DeprBook: Record "Depreciation Book";
    //     PurchRcptHeader2: record "Purch. Rcpt. Header";
    //     GenJournalLineL1: record "Gen. Journal Line";
    //     PurchPost: Codeunit "Purch.-Post";
    // begin
    //     //HEI.02>>
    //     GenJnlLineDocType := GenJnlLineType."Document Type"::"Purchase Receipt";
    //     GenJnlLineDocNo := PurchRcptHeader."No.";
    //     GenJnlLineExtDocNo := PurchHeader."Vendor Invoice No.";
    //     //PostInvoicePostingBuffer(PurchHeader, TempInvoicePostBuffer);
    //     PostFaGlEntry(
    //         // PurchHeader,TotalPurchLine,TotalPurchLineLCY,GenJnlLineDocType,GenJnlLineDocNo,GenJnlLineExtDocNo,SrcCode); //HEI.22 commented
    //         PurchHeader, TotalPurchLine, TotalPurchLineLCY, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, TotalFAPurchLine); //HEI.22
    //                                                                                                                                             //HEI.02<<

    //     //HEI.07>>
    //     DeprBook.RESET;
    //     DeprBook.SETRANGE("Part of Duplication List", TRUE);
    //     IF DeprBook.FINDFIRST THEN BEGIN
    //         FAJnlSetup.RESET;
    //         FAJnlSetup.SETFILTER("Depreciation Book Code", DeprBook.Code);
    //         FAJnlSetup.SETRANGE("User ID", USERID);
    //         IF FAJnlSetup.FINDFIRST THEN BEGIN
    //             //HEI.49>>
    //             GenJournalLineL1.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Document No.", "Account No.");
    //             GenJournalLineL1.SETRANGE("Journal Template Name", FAJnlSetup."FA Jnl. Template Name");
    //             GenJournalLineL1.SETRANGE("Journal Batch Name", FAJnlSetup."FA Jnl. Batch Name");
    //             GenJournalLineL1.SETRANGE("Document No.", PurchHeader."Receiving No.");
    //             GenJournalLineL1.SETRANGE("Account No.", '');
    //             // BC UPGRADE PATELS08 >> 'FindSet(FALSE, FALSE)' is being deprecated, thus using the oveloaded method instead.
    //             // IF GenJournalLineL1.FINDSET(FALSE, FALSE) THEN
    //             IF GenJournalLineL1.FINDSET(FALSE) THEN
    //                 // BC UPGRADE PATELS08 <<
    //                 GenJournalLineL1.DELETEALL(TRUE);
    //             //HEI.49<<

    //             GenJournalLine.RESET;
    //             GenJournalLine.SETRANGE("Journal Template Name", FAJnlSetup."FA Jnl. Template Name");
    //             GenJournalLine.SETRANGE("Journal Batch Name", FAJnlSetup."FA Jnl. Batch Name");
    //             GenJournalLine.SETRANGE("Document No.", PurchHeader."Receiving No.");
    //             GenJournalLine.SETRANGE("Posting Date", PurchHeader."Posting Date");
    //             IF GenJournalLine.FINDSET THEN BEGIN
    //                 //HEI.11>>
    //                 GenJournalLine."Reference Number FND" := PurchHeader."Your Reference";
    //                 IF (PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice) OR
    //                    (PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo")
    //                 THEN BEGIN
    //                     IF PurchHeader."Purchase Order No. FND" <> '' THEN
    //                         GenJournalLine."PO Number FND" := PurchHeader."Purchase Order No. FND"
    //                     ELSE
    //                         IF PurchRcptHeader2.GET(TempInvoicePostBuffer."Purchase Receipt No.") THEN
    //                             GenJournalLine."PO Number FND" := PurchRcptHeader2."Order No.";
    //                 END ELSE
    //                     IF (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) OR
    //                        (PurchHeader."Document Type" = PurchHeader."Document Type"::"Return Order")
    //                     THEN
    //                         GenJournalLine."PO Number FND" := PurchHeader."No.";
    //                 GenJournalLine."Source Type" := GenJournalLine."Source Type"::Vendor;
    //                 GenJournalLine."Source No. FND" := PurchHeader."Buy-from Vendor No.";
    //                 GenJournalLine.MODIFY;
    //                 //HEI.11<<
    //                 CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
    //             END; //HEI.11
    //         END;
    //     END;
    //     //HEI.07<<

    // end;

    // procedure PostFaGlEntry(PurchHeader: Record "Purchase Header"; TotalPurchLine2: Record "Purchase Line"; TotalPurchLineLCY2: Record "Purchase Line"; DocType: Option; DocNo: Code[20]; ExtDocNo: Code[35]; SourceCode: Code[10]; TotalFAPurchLine: Record "Purchase Line")
    // BC UPGRADE PATELS08 >> # Changed the parameter DocType to Enum "Gen. Journal Document Type" from Option to avoid implicit conversion.
    // procedure PostFaGlEntry(PurchHeader: Record "Purchase Header"; TotalPurchLine2: Record "Purchase Line"; TotalPurchLineLCY2: Record "Purchase Line"; DocType: Option; DocNo: Code[20]; ExtDocNo: Code[35]; SourceCode: Code[10]; TotalFAPurchLine: Record "Purchase Line")
    local procedure PostFaGlEntry(PurchHeader: Record "Purchase Header"; TotalPurchLine2:
   Record "Purchase Line"; TotalPurchLineLCY2: Record "Purchase Line"; DocType: Enum "Gen. Journal Document Type";
                                                                                    DocNo: Code[20];
                                                                                    ExtDocNo: Code[35];
                                                                                    SourceCode: Code[10];
                                                                                    TotalFAPurchLine: Record "Purchase Line")
    var
        FAPurchaseLine: Record "Purchase Line";
        GenJnlLine: Record "Gen. Journal Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        FASetup: Record "FA Setup";
        TempInvoicePostBuffer: Record "Invoice Posting Buffer";
        TotalInvAmount: Decimal;
        PurchFAGRIR: Record "purchase FA Heilite GRIR FND";
    begin
        //HEI.02>>
        FASetup.GET();
        FASetup.TESTFIELD("Payable Acc.Purch. Receipt FND");
        //HEI.43>>
        IF FASetup."Post GL on Purchase Return FND" THEN
            FASetup.TESTFIELD("Payable Acc. Purch. Return FND");
        //HEI.43<<

        // BC Upgrade MISHRS14 >>
        // Blocked with statement
        //WITH GenJnlLine DO BEGIN
        GenJnlLine.InitNewLine(
           PurchHeader."Posting Date", PurchHeader."Document Date", PurchHeader."Posting Date", PurchHeader."Posting Description",
           PurchHeader."Shortcut Dimension 1 Code", PurchHeader."Shortcut Dimension 2 Code",
           PurchHeader."Dimension Set ID", PurchHeader."Reason Code");

        //GenJnlLine.CopyDocumentFields(GenJnlLine."Document Type"::"Purchase Receipt", SingleInsCU.GetValue(), ExtDocNo, SourceCode, '');
        GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := FASetup."Payable Acc.Purch. Receipt FND";//horto
                                                                             //HEI.43>>
                                                                             //IF (GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Purchase Receipt") THEN
        IF ((GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Purchase Shipment") OR (GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo"))
                    AND FASetup."Post GL on Purchase Return FND" THEN
            GenJnlLine."Account No." := FASetup."Payable Acc. Purch. Return FND";
        //HEI.43<<
        GenJnlLine.CopyFromPurchHeader(PurchHeader);
        GenJnlLine.SetCurrencyFactor(PurchHeader."Currency Code", PurchHeader."Currency Factor");
        GenJnlLine."System-Created Entry" := TRUE;
        if not PurchHeader.Invoice then
            GenJnlLine."FA Receipt Line No. FND" := TotalFAPurchLine."Line No.";
        GenJnlLine.CopyFromPurchHeaderApplyTo(PurchHeader);
        GenJnlLine.CopyFromPurchHeaderPayment(PurchHeader);
        GenJnlLine."Pmt. Discount Date" := 0D;

        IF PurchHeader.Receive THEN BEGIN
            GenJnlLine.Amount := -TotalPurchLine2.Amount;
            GenJnlLine."Source Currency Amount" := -TotalPurchLine2.Amount;
            GenJnlLine."Amount (LCY)" := -TotalPurchLineLCY2.Amount;
            GenJnlLine."Sales/Purch. (LCY)" := -TotalPurchLineLCY2.Amount;
            GenJnlLine."Inv. Discount (LCY)" := -TotalPurchLineLCY2."Inv. Discount Amount";
        END ELSE

            //HEI.22<<
            //HEI.43>>
            IF PurchHeader.Ship AND (FASetup."Post GL on Purchase Return FND") THEN BEGIN
                GenJnlLine.Amount := -TotalPurchLine2.Amount;
                GenJnlLine."Source Currency Amount" := -TotalPurchLine2.Amount;
                GenJnlLine."Amount (LCY)" := -TotalPurchLineLCY2.Amount;
                GenJnlLine."Sales/Purch. (LCY)" := -TotalPurchLineLCY2.Amount;
                GenJnlLine."Inv. Discount (LCY)" := -TotalPurchLineLCY2."Inv. Discount Amount";
                // END;
            END ELSE BEGIN
                //HEI.43<<
                GenJnlLine.Amount := TotalFAPurchLine.Amount;
                GenJnlLine."Source Currency Amount" := TotalFAPurchLine.Amount;
                GenJnlLine."Amount (LCY)" := TotalFAPurchLine.Amount;
                GenJnlLine."Sales/Purch. (LCY)" := TotalFAPurchLine.Amount;
                GenJnlLine."Inv. Discount (LCY)" := TotalFAPurchLine."Inv. Discount Amount";
                //HEI.22>>
            END;
        //HEI.11>>
        GenJnlLine."Reference Number FND" := PurchHeader."Your Reference";
        IF (PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice) OR
           (PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo")
        THEN BEGIN
            IF PurchHeader."Purchase Order No. FND" <> '' THEN
                GenJnlLine."PO Number FND" := PurchHeader."Purchase Order No. FND";
        END ELSE
            IF (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) OR
                (PurchHeader."Document Type" = PurchHeader."Document Type"::"Return Order")
            THEN
                GenJnlLine."PO Number FND" := PurchHeader."No.";
        GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
        GenJnlLine."Source No." := PurchHeader."Buy-from Vendor No.";
        //HEI.11<<
        if not PurchHeader.Invoice then
            GenJnlPostLine.RunWithCheck(GenJnlLine)
        else begin
            if PurchFAGRIR.get(PurchHeader."Document Type", PurchHeader."No.") then
                PurchFAGRIR.DeleteAll();
            PurchFAGRIR.Init();
            PurchFAGRIR."Document Type" := PurchHeader."Document Type";
            PurchFAGRIR."No." := PurchHeader."No.";
            PurchFAGRIR."Shortcut Dimension 1 Code" := PurchHeader."Shortcut Dimension 1 Code";
            PurchFAGRIR."Shortcut Dimension 2 Code" := PurchHeader."Shortcut Dimension 2 Code";
            PurchFAGRIR."Dimension Set ID" := PurchHeader."Dimension Set ID";
            PurchFAGRIR."FA GRIR Amount" := TotalFAPurchLine.Amount;
            PurchFAGRIR.Insert();
        end;

        //end;
        // BC Upgrade MISHRS14 <<

    end;

    procedure UpdateOutboundGateEntry(GateEntryNo: Code[20]; OutboundQuantity: Decimal; ItemNo: Code[20]; OutboundWeight: Decimal; UnitOfMeasure: Code[20]; LocationCode: Code[20])
    var
        GateEntryLine: Record "Gate Entry Line FND";
        GateEntryHeader: Record "Gate Entry Header FND";
        ReturnShptHeader: Record "Return Shipment Header";
    begin
        //HEI.09>>
        //>>HEI:EDD151:1:1
        GateEntryLine.RESET();
        GateEntryLine.SETRANGE("Gate Entry Document No.", GateEntryNo);
        GateEntryLine.SETRANGE("Unit Of Measure Code", UnitOfMeasure);
        GateEntryLine.SETRANGE("Location Code", LocationCode);
        IF GateEntryLine.FINDFIRST() THEN BEGIN
            GateEntryLine."Posted Quantity Outbound" += OutboundQuantity;
            GateEntryLine."Reference Document" := GateEntryLine."Reference Document"::"Posted Return Shipment";
            GateEntryLine."Reference No." := ReturnShptHeader."No.";
            GateEntryLine.MODIFY();
        END;
        IF GateEntryHeader.GET(GateEntryNo) THEN BEGIN
            GateEntryHeader."Posted Weight Outbound" += OutboundWeight;
            GateEntryHeader."Document Type" := GateEntryHeader."Document Type"::"Purchase Return Order";
            GateEntryHeader."Document No." := ReturnShptHeader."Return Order No.";
            GateEntryHeader."Reference Document" := GateEntryHeader."Reference Document"::"Posted Return Shipment";
            GateEntryHeader."Reference No." := ReturnShptHeader."No.";
            GateEntryHeader.MODIFY();
        END;
        //<<HEI:EDD151:1:1
        //HEI.09<<
    end;

    procedure UpdateInboundGateEntry(GateEntryNo: Code[20]; InboundQuantity: Decimal; ItemNo: Code[20]; InboundWeight: Decimal; UnitOfMeasure: Code[20]; LocationCode: Code[20])
    var
        GateEntryLine: Record "Gate Entry Line FND";
        GateEntryHeader: Record "Gate Entry Header FND";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
    begin
        //HEI.09>>
        //>>HEI:EDD151:1:1
        GateEntryLine.RESET();
        GateEntryLine.SETRANGE("Gate Entry Document No.", GateEntryNo);
        GateEntryLine.SETRANGE("Unit Of Measure Code", UnitOfMeasure);
        GateEntryLine.SETRANGE("Location Code", LocationCode);
        IF GateEntryLine.FINDFIRST() THEN BEGIN
            GateEntryLine."Posted Quantity Inbound" += InboundQuantity;
            GateEntryLine."Reference Document" := GateEntryLine."Reference Document"::"Posted Receipt";
            GateEntryLine."Reference No." := PurchRcptHeader."No.";
            GateEntryLine.MODIFY();
        END;
        IF GateEntryHeader.GET(GateEntryNo) THEN BEGIN
            GateEntryHeader."Posted Weight Inbound" += InboundWeight;
            GateEntryHeader."Document Type" := GateEntryHeader."Document Type"::"Purchase Order";
            GateEntryHeader."Document No." := PurchRcptHeader."Order No.";
            GateEntryHeader."Reference Document" := GateEntryHeader."Reference Document"::"Posted Receipt";
            GateEntryHeader."Reference No." := PurchRcptHeader."No.";
            GateEntryHeader.MODIFY();
        END;
        //<<HEI:EDD151:1:1
        //HEI.09<<

    end;

    procedure IsPurchGateEntryMandatory(LocationCode: Code[20]; ZoneCode: Code[20]): Boolean
    var
        Zone: record Zone;
        Location: Record Location;
    begin
        //HEI.09>>
        //>>HEI:EDD001:1:1
        IF Location.GET(LocationCode) AND Zone.GET(LocationCode, ZoneCode) THEN BEGIN
            IF Location."Purchase Gate Entry Mandat FND" OR Zone."Sales Gate Entry Mandatory FND" THEN
                EXIT(TRUE)
            ELSE
                EXIT(FALSE);
        END ELSE
            EXIT(FALSE);
        //<<HEI:EDD001:1:1
        //HEI.09<<
    end;

    // BC UPGRADE PATELS08 >> # Changed the parameter DocType to Enum "Gen. Journal Document Type" from Option to avoid implicit conversion.
    // procedure PostFaGlEntryDiff2(PurchHeader: Record "Purchase Header"; TempInvoicePostBuffer: Record "Invoice Posting Buffer"; DocType: Option; DocNo: Code[20]; ExtDocNo: Code[35]; SourceCode: Code[10])
    local procedure PostFaGlEntryDiff2(PurchHeader: Record "Purchase Header"; TempInvoicePostBuffer: Record "Invoice Posting Buffer"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20];
                                                                                                                                                   ExtDocNo: Code[35];
                                                                                                                                                   SourceCode: Code[10])
    var
        GenJnlLine: Record "Gen. Journal Line";
        sourcecodesetup: Record "Source Code Setup";
    begin
        sourcecodesetup.Get();
        SourceCode := sourcecodesetup.Purchases;
        //HEI.02>>
        FASetup.GET();
        FASetup.TESTFIELD("Payable Acc.Purch. Receipt FND");

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with GenJnlLine
        //WITH GenJnlLine DO BEGIN
        GenJnlLine.InitNewLine(
          PurchHeader."Posting Date", PurchHeader."Document Date", PurchHeader."Posting Date", PurchHeader."Posting Description",
          PurchHeader."Shortcut Dimension 1 Code", PurchHeader."Shortcut Dimension 2 Code",
          PurchHeader."Dimension Set ID", PurchHeader."Reason Code");

        GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := FASetup."Payable Acc.Purch. Receipt FND";
        GenJnlLine.CopyFromPurchHeader(PurchHeader);
        GenJnlLine.SetCurrencyFactor(PurchHeader."Currency Code", PurchHeader."Currency Factor");
        GenJnlLine."System-Created Entry" := TRUE;

        GenJnlLine.CopyFromPurchHeaderApplyTo(PurchHeader);
        GenJnlLine.CopyFromPurchHeaderPayment(PurchHeader);
        GenJnlLine."Pmt. Discount Date" := 0D;

        GenJnlLine.Amount := -TempInvoicePostBuffer.Amount;
        GenJnlLine."Source Currency Amount" := -TempInvoicePostBuffer.Amount;
        GenJnlLine."Amount (LCY)" := -TempInvoicePostBuffer.Amount;
        //"Sales/Purch. (LCY)" := TempInvoicePostBuffer."Amount (ACY)";
        //"Inv. Discount (LCY)" := TempInvoicePostBuffer;
        GenJnlPostLine.RunWithCheck(GenJnlLine);
        //END;
        // BC Upgrade MISHRS14 <<

    end;
    //HEI.02<<
    //--------------------------------------------------//BCUpgrade SHARMP16 BEGIN<< FA Cases, Undo GR/IR Cases--------------------------------------------------
    //BC UPgrade SHARMP16 CU 90 BEGIN<<
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterPostPurchLine, '', false, false)]
    local procedure PurchPost_OnAfterPostPurchLine(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; CommitIsSupressed: Boolean; var PurchInvLine: Record "Purch. Inv. Line"; var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchLineACY: Record "Purchase Line"; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; SrcCode: Code[10]; xPurchaseLine: Record "Purchase Line")
    var
        PurchPostInv: Codeunit "Purch. Post Invoice";
        InvoicePostingParameters: Record "Invoice Posting Parameters";

    //TotalVAT: Decimal; TotalVATACY: Decimal; TotalAmount: Decimal; TotalAmountACY: Decimal; VATDifference: Decimal; TotalVATBase: Decimal; TotalVATBaseACY: Decimal
    begin
        FASetup.GET();
        IF FASetup."Post GL on Purch. Receive FND" THEN BEGIN
            // BC Upgrade MISHRS14 >>
            // Blocked below to remove implicit warning
            // IF ((PurchaseLine.Type >= PurchaseLine.Type::"G/L Account") AND (PurchaseLine."Qty. to Invoice" <> 0) AND (PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::"Credit Memo")) //HEI.43
            //                                   OR ((PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset") AND PurchaseHeader.Receive) THEN BEGIN  //HEI.43
            //     IF (PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset") AND (PurchaseHeader.Receive) THEN
            //         PostFaLedgerEntry := TRUE;
            // end;

            IF ((PurchaseLine.Type <> PurchaseLine.Type::" ") AND
                (PurchaseLine."Qty. to Invoice" <> 0) AND
                (PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::"Credit Memo"))
                OR
            ((PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset") AND PurchaseHeader.Receive)
            THEN BEGIN

                IF (PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset") AND (PurchaseHeader.Receive) THEN
                    PostFaLedgerEntry := TRUE;
            END;
            // BC Upgrade MISHRS14 <<    

            // Error(PurchaseHeader."Receiving No.");
            IF PurchaseHeader.Receive AND PostFaLedgerEntry AND
              (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) THEN Begin// OR (("Document Type" = "Document Type"::Invoice) AND PurchSetup."Receipt on Invoice")) THEN
                                                                                                 // Message('Intial %1', PurchaseLine.Amount);
                PurchPostInv.PrepareInvoicePostingBuffer(PurchaseLine, InvoicePostBufferGolbal);
                PostGLOnFaReceipt(PurchaseHeader, InvoicePostBufferGolbal,
                PurchaseLine, PurchaseLine, GenJnlLineDocNo, GenJnlLineExtDocNo, GenJnlLineDocType);
            end;


        END;
        if FASetup."Post GL on Purchase Return FND" then begin

            // BC Upgrade MISHRS14 >>
            // Blocked below to remove implicit warning   
            // IF ((PurchaseLine.Type >= PurchaseLine.Type::"G/L Account") AND (PurchaseLine."Qty. to Invoice" <> 0) AND (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo"))
            //                       OR ((PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset") AND PurchaseHeader.Ship) THEN BEGIN
            //     IF (PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset") AND (PurchaseHeader.Ship) THEN
            //         PostFaLedgerEntryOnReturn := TRUE;
            // end;

            IF (((PurchaseLine.Type <> PurchaseLine.Type::" ") AND
                (PurchaseLine."Qty. to Invoice" <> 0) AND
                (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo"))
                OR
                ((PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset") AND PurchaseHeader.Ship))
            THEN BEGIN

                IF (PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset") AND PurchaseHeader.Ship THEN
                    PostFaLedgerEntryOnReturn := TRUE;
            END;
            // BC Upgrade MISHRS14 <<    

            IF PurchaseHeader.Ship AND PostFaLedgerEntryOnReturn AND
             (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Return Order") THEN Begin// OR (("Document Type" = "Document Type"::Invoice) AND PurchSetup."Receipt on Invoice")) THEN
                                                                                                         // Message('Intial %1', PurchaseLine.Amount);
                PurchPostInv.PrepareInvoicePostingBuffer(PurchaseLine, InvoicePostBufferGolbal);
                PostGLOnFaReturnShipment(PurchaseHeader, InvoicePostBufferGolbal,
                PurchaseLine, PurchaseLine, GenJnlLineDocNo, GenJnlLineExtDocNo, GenJnlLineDocType);
            end;
        end;

    End;

    local procedure PostGLOnFaReceipt(VAR PurchHeader: Record "Purchase Header"; VAR TempInvoicePostBuffer: Record "Invoice Posting Buffer" temporary; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; GenJnlLineDocType: Enum "Gen. Journal Document Type")
    var
        GenJournalLine: Record "Gen. Journal Line";
        DeprBook: Record "Depreciation Book";
        PurchRcptHeader2: Record "Purch. Rcpt. Header";
        GenJournalLineL1: Record "Gen. Journal Line";
        FAJnlSetup: Record "FA Journal Setup";
    begin
        //HEI.02>>
        RecPurchRcptHeader.Get(PurchHeader."Receiving No.");
        GenJnlLineDocType := GenJnlLineDocType::"Purchase Receipt";
        GenJnlLineDocNo := RecPurchRcptHeader."No."; // need to change purchase rece no
        GenJnlLineExtDocNo := GenJnlLineDocNo;
        PostFAPostingBuffer(PurchHeader, TempInvoicePostBuffer, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo);
        PostFaGlEntry(
            // PurchHeader,TotalPurchLine,TotalPurchLineLCY,GenJnlLineDocType,GenJnlLineDocNo,GenJnlLineExtDocNo,SrcCode); //HEI.22 commented
            PurchHeader, TotalPurchLine, TotalPurchLineLCY, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, TotalPurchLine); //HEI.22
                                                                                                                                              //HEI.02<<

        //HEI.07>>
        DeprBook.RESET();
        DeprBook.SETRANGE("Part of Duplication List", TRUE);
        IF DeprBook.FINDFIRST() THEN BEGIN
            FAJnlSetup.RESET();
            FAJnlSetup.SETFILTER("Depreciation Book Code", DeprBook.Code);
            FAJnlSetup.SETRANGE("User ID", UserId);
            IF FAJnlSetup.FINDFIRST() THEN BEGIN
                //HEI.49>>
                GenJournalLineL1.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Document No.", "Account No.");
                GenJournalLineL1.SETRANGE("Journal Template Name", FAJnlSetup."FA Jnl. Template Name");
                GenJournalLineL1.SETRANGE("Journal Batch Name", FAJnlSetup."FA Jnl. Batch Name");
                GenJournalLineL1.SETRANGE("Document No.", PurchHeader."Receiving No.");
                GenJournalLineL1.SETRANGE("Account No.", '');
                IF GenJournalLineL1.FINDSET(FALSE) THEN
                    GenJournalLineL1.DELETEALL(TRUE);
                //HEI.49<<

                GenJournalLine.RESET();
                GenJournalLine.SETRANGE("Journal Template Name", FAJnlSetup."FA Jnl. Template Name");
                GenJournalLine.SETRANGE("Journal Batch Name", FAJnlSetup."FA Jnl. Batch Name");
                GenJournalLine.SETRANGE("Document No.", PurchHeader."Receiving No.");
                GenJournalLine.SETRANGE("Posting Date", PurchHeader."Posting Date");
                IF GenJournalLine.FINDSET() THEN BEGIN
                    //HEI.11>>
                    GenJournalLine."Reference Number FND" := PurchHeader."Your Reference";
                    IF (PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice) OR
                       (PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo")
                    THEN BEGIN
                        IF PurchHeader."Purchase Order No. FND" <> '' THEN
                            GenJournalLine."PO Number FND" := PurchHeader."Purchase Order No. FND"
                        ELSE
                            IF PurchRcptHeader2.GET(TempInvoicePostBuffer."Purchase Receipt No. FND") THEN
                                GenJournalLine."PO Number FND" := PurchRcptHeader2."Order No.";
                    END ELSE
                        IF (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) OR
                           (PurchHeader."Document Type" = PurchHeader."Document Type"::"Return Order")
                        THEN
                            GenJournalLine."PO Number FND" := PurchHeader."No.";
                    GenJournalLine."Source Type" := GenJournalLine."Source Type"::Vendor;
                    GenJournalLine."Source No." := PurchHeader."Buy-from Vendor No.";
                    GenJournalLine.MODIFY();
                    //HEI.11<<
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
                END; //HEI.11
            END;
        END;
    end;

    local procedure PostGLOnFaReturnShipment(VAR PurchHeader: Record "Purchase Header"; VAR TempInvoicePostBuffer: Record "Invoice Posting Buffer" temporary; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; GenJnlLineDocType: Enum "Gen. Journal Document Type")
    var
        GenJournalLine: Record "Gen. Journal Line";
        DeprBook: Record "Depreciation Book";
        PurchRcptHeader2: Record "Purch. Rcpt. Header";
        GenJournalLineL1: Record "Gen. Journal Line";
        FAJnlSetup: Record "FA Journal Setup";
        RecPurchShptHeader: Record "Return Shipment Header";
    begin
        //HEI.02>>
        RecPurchShptHeader.Get(PurchHeader."Return Shipment No.");
        GenJnlLineDocType := GenJnlLineDocType::"Purchase Shipment";
        GenJnlLineDocNo := RecPurchShptHeader."No."; // need to change purchase rece no
        GenJnlLineExtDocNo := RecPurchShptHeader."Return Order No.";

        PostFAReturnPostingBuffer(PurchHeader, TempInvoicePostBuffer, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo);
        //  Message('IN');
        PostFaGlEntry(
            // PurchHeader,TotalPurchLine,TotalPurchLineLCY,GenJnlLineDocType,GenJnlLineDocNo,GenJnlLineExtDocNo,SrcCode); //HEI.22 commented
            PurchHeader, TotalPurchLine, TotalPurchLineLCY, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, TotalPurchLine); //HEI.22
                                                                                                                                              //HEI.02<<

        //HEI.07>>
        DeprBook.RESET();
        DeprBook.SETRANGE("Part of Duplication List", TRUE);
        IF DeprBook.FINDFIRST() THEN BEGIN
            FAJnlSetup.RESET();
            FAJnlSetup.SETFILTER("Depreciation Book Code", DeprBook.Code);
            FAJnlSetup.SETRANGE("User ID", UserId);
            IF FAJnlSetup.FINDFIRST() THEN BEGIN
                //HEI.49>>
                GenJournalLineL1.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Document No.", "Account No.");
                GenJournalLineL1.SETRANGE("Journal Template Name", FAJnlSetup."FA Jnl. Template Name");
                GenJournalLineL1.SETRANGE("Journal Batch Name", FAJnlSetup."FA Jnl. Batch Name");
                GenJournalLineL1.SETRANGE("Document No.", PurchHeader."Return Shipment No.");
                GenJournalLineL1.SETRANGE("Account No.", '');
                IF GenJournalLineL1.FINDSET(FALSE) THEN
                    GenJournalLineL1.DELETEALL(TRUE);
                //HEI.49<<

                GenJournalLine.RESET();
                GenJournalLine.SETRANGE("Journal Template Name", FAJnlSetup."FA Jnl. Template Name");
                GenJournalLine.SETRANGE("Journal Batch Name", FAJnlSetup."FA Jnl. Batch Name");
                GenJournalLine.SETRANGE("Document No.", PurchHeader."Return Shipment No.");
                GenJournalLine.SETRANGE("Posting Date", PurchHeader."Posting Date");
                IF GenJournalLine.FINDSET() THEN BEGIN
                    //HEI.11>>
                    GenJournalLine."Reference Number FND" := PurchHeader."Your Reference";
                    // IF (PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice) OR
                    //    (PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo")
                    // THEN BEGIN
                    //     IF PurchHeader."Purchase Order No. FND" <> '' THEN
                    //         GenJournalLine."PO Number FND" := PurchHeader."Purchase Order No. FND"
                    //     ELSE
                    //         IF PurchRcptHeader2.GET(TempInvoicePostBuffer."Purchase Receipt No.") THEN
                    //             GenJournalLine."PO Number FND" := PurchRcptHeader2."Order No.";
                    // END ELSE
                    IF (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) OR
                       (PurchHeader."Document Type" = PurchHeader."Document Type"::"Return Order")
                    THEN
                        GenJournalLine."PO Number FND" := PurchHeader."No.";
                    GenJournalLine."Source Type" := GenJournalLine."Source Type"::Vendor;
                    GenJournalLine."Source No." := PurchHeader."Buy-from Vendor No.";
                    GenJournalLine.MODIFY();
                    //HEI.11<<
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
                END; //HEI.11
            END;
        END

    end;

    local procedure PostFAPostingBuffer(PurchHeader: Record "Purchase Header"; var TempInvoicePostBuffer: Record "Invoice Posting Buffer" temporary; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20];
                                                                                                                                                                  ExtDocNo: Code[35]) TotalInvAmount: Decimal
    var
        CurrencyDocument: Record Currency;
        VATPostingSetup: Record "VAT Posting Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        VATAmountRemainder: Decimal;
        VATAmountACYRemainder: Decimal;
        GLEntryNo: Integer;

    begin
        VATAmountRemainder := 0;
        VATAmountACYRemainder := 0;

        CurrencyDocument.Initialize(PurchHeader."Currency Code");
        LineCount := 0;
        IF TempInvoicePostBuffer.FIND('+') THEN
            REPEAT

                LineCount := LineCount + 1;
                FASetup.Get();
                IF FASetup."Post GL on Purch. Receive FND" = FALSE THEN BEGIN//HEI.02
                    IF GUIALLOWED THEN
                        Window.UPDATE(3, LineCount);
                END;

                CASE TempInvoicePostBuffer."VAT Calculation Type" OF
                    TempInvoicePostBuffer."VAT Calculation Type"::"Reverse Charge VAT":
                        BEGIN
                            VATPostingSetup.GET(
                              TempInvoicePostBuffer."VAT Bus. Posting Group", TempInvoicePostBuffer."VAT Prod. Posting Group");
                            TempInvoicePostBuffer."VAT Amount" :=
                              ROUND(
                                TempInvoicePostBuffer."VAT Base Amount" *
                                (1 - PurchHeader."VAT Base Discount %" / 100) * VATPostingSetup."VAT %" / 100);
                            TempInvoicePostBuffer."VAT Amount (ACY)" :=
                              ROUND(
                                TempInvoicePostBuffer."VAT Base Amount (ACY)" * (1 - PurchHeader."VAT Base Discount %" / 100) *
                                VATPostingSetup."VAT %" / 100, CurrencyDocument."Amount Rounding Precision");


                        END;
                    TempInvoicePostBuffer."VAT Calculation Type"::"Sales Tax":
                        IF TempInvoicePostBuffer."Use Tax" THEN BEGIN
                            TempInvoicePostBuffer."VAT Amount" :=
                              ROUND(
                                SalesTaxCalculate.CalculateTax(
                                  TempInvoicePostBuffer."Tax Area Code", TempInvoicePostBuffer."Tax Group Code",
                                  TempInvoicePostBuffer."Tax Liable", PurchHeader."Posting Date",
                                  TempInvoicePostBuffer.Amount, TempInvoicePostBuffer.Quantity, 0));
                            IF GLSetup."Additional Reporting Currency" <> '' THEN
                                TempInvoicePostBuffer."VAT Amount (ACY)" :=
                                  CurrExchRate.ExchangeAmtLCYToFCY(
                                    PurchHeader."Posting Date", GLSetup."Additional Reporting Currency",
                                    TempInvoicePostBuffer."VAT Amount", 0);
                        END;
                END;
                //HEI.02>>
                //IF FASetup."Post GL on Purch. Receive FND" AND (TempInvoicePostBuffer.Type = TempInvoicePostBuffer.Type::"Fixed Asset") AND (TempInvoicePostBuffer."Purchase Receipt Amount" <> 0 ) THEN BEGIN  //HEI.43
                IF (PurchHeader."Document Type" <> PurchHeader."Document Type"::"Credit Memo") AND   //HEI.43
                        FASetup."Post GL on Purch. Receive FND" AND (TempInvoicePostBuffer.Type = TempInvoicePostBuffer.Type::"Fixed Asset") AND (TempInvoicePostBuffer."Purchase Receipt Amount FND" <> 0) THEN BEGIN  //HEI.43
                    IF PurchHeader.Invoice THEN BEGIN
                        IF TempInvoicePostBuffer.Amount <> TempInvoicePostBuffer."Purchase Receipt Amount FND" THEN BEGIN
                            // UpdateFaGLEntry(PurchInvHeader, TempInvoicePostBuffer);
                            //HEI.38>>
                            //TempInvoicePostBuffer.Amount := TempInvoicePostBuffer.Amount - TempInvoicePostBuffer."Purchase Receipt Amount";
                            TempInvoicePostBuffer.Amount := TempInvoicePostBuffer.Amount - (TempInvoicePostBuffer.Quantity * TempInvoicePostBuffer."Purchase Receipt Unit Cost FND");
                            //HEI.38<<
                            TempInvoicePostBuffer.Amount := ROUND(TempInvoicePostBuffer.Amount, GLSetup."Amount Rounding Precision");//HEI.40
                            GLEntryNo := PostFAPostBufferLine(PurchHeader, TempInvoicePostBuffer, DocType, DocNo, ExtDocNo);
                            PostGLOnFaDiffOnInvoice(PurchHeader, TempInvoicePostBuffer);
                        END ELSE BEGIN
                            //UpdateFaGLEntry(PurchInvHeader, TempInvoicePostBuffer);//NAV Commened
                            TempInvoicePostBuffer.Amount := TempInvoicePostBuffer.Amount - TempInvoicePostBuffer."Purchase Receipt Amount FND";
                            GLEntryNo := PostFAPostBufferLine(PurchHeader, TempInvoicePostBuffer, DocType, DocNo, ExtDocNo);
                        END;
                        //HEI.02<<
                    END ELSE
                        GLEntryNo := PostFAPostBufferLine(PurchHeader, TempInvoicePostBuffer, DocType, DocNo, ExtDocNo)
                    //HEI.43>>

                END ELSE
                    GLEntryNo := PostFAPostBufferLine(PurchHeader, TempInvoicePostBuffer, DocType, DocNo, ExtDocNo);

                //HEI.02<<
                //GLEntryNo := PostInvoicePostBufferLine(PurchHeader,TempInvoicePostBuffer);Hei.02
                // <<DITW15.00.00.01 DDR 27/12/2007
                // Post G/L and Item Charges relation
                // CreateGLItemChargeRelation(TempInvoicePostBuffer."Item Charge Line No."); //HEI.24 commented
                // >>DITW15.00.00.01 DDR

                GetItemChargesLinesToCreateGLItemRelation(PurchHeader, TempInvoicePostBuffer); //HEI.24
                IF (TempInvoicePostBuffer."Job No." <> '') AND
                   (TempInvoicePostBuffer.Type = TempInvoicePostBuffer.Type::"G/L Account")
                THEN
                    PostPurchaseGLAccounts(TempInvoicePostBuffer, GLEntryNo);

            UNTIL TempInvoicePostBuffer.NEXT(-1) = 0;

        TempInvoicePostBuffer.CALCSUMS(Amount);
        TotalInvAmount := TempInvoicePostBuffer.Amount;

        TempInvoicePostBuffer.DELETEALL();
        //   Message('%1 TotalINVAmount', TotalInvAmount);

    end;

    local procedure PostFAPostBufferLine(VAR PurchHeader: Record "Purchase Header"; InvoicePostBuffer: Record "Invoice Posting Buffer"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20];
                                                                                                                                                     ExtDocNo: Code[35]): Integer
    var
        GenJnlLine: Record "Gen. Journal Line";
        PurchRcptHeader2: Record "Purch. Rcpt. Header";
        ChargeTypeInt: Integer;
        SourceCodeSetup: Record "Source Code Setup";
        RecPurchRcptHeader: Record "Purch. Rcpt. Header";
        GenJnlLineDocType: Enum "Gen. Journal Document Type";
        GenJnlLineDocNo: Code[20];
        GenJnlLineExtDocNo: Code[35];
        Purch: Codeunit "Purch. Post Invoice";

    begin
        SourceCodeSetup.Get();
        if GenJnlLineDocType = GenJnlLineDocType::"Purchase Receipt" then begin
            RecPurchRcptHeader.Get(PurchHeader."Receiving No.");
            GenJnlLineDocType := GenJnlLineDocType::"Purchase Receipt";
            GenJnlLineDocNo := RecPurchRcptHeader."No."; // need to change purchase rece no
            GenJnlLineExtDocNo := GenJnlLineDocNo;
        end else begin
            GenJnlLineDocType := DocType;
            GenJnlLineDocNo := DocNo;
            GenJnlLineExtDocNo := DocNo;
        end;

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with GenJnlLine
        //WITH GenJnlLine DO BEGIN
        GenJnlLine.InitNewLine(
          PurchHeader."Posting Date", PurchHeader."Document Date", PurchHeader."Posting Date", PurchHeader."Posting Description",
          InvoicePostBuffer."Global Dimension 1 Code", InvoicePostBuffer."Global Dimension 2 Code",
          InvoicePostBuffer."Dimension Set ID", PurchHeader."Reason Code");
        GenJnlLine.CopyDocumentFields(GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, SourceCodeSetup.Purchases, '');
        // GenJnlLine."Account No." := InvoicePostBuffer."G/L Account";
        //GenJnlLine.Validate(Amount);
        GenJnlLine.CopyFromPurchHeader(PurchHeader);

        //CopyFromInvoicePostBuffer(InvoicePostBuffer); //NAV code
        InvoicePostBuffer.CopyToGenJnlLine(GenJnlLine); //BC Code

        //HEI.02>>
        IF FASetup."Post GL on Purch. Receive FND" THEN BEGIN
            IF PurchHeader.Invoice THEN BEGIN
                GenJnlLine."Purchase Receipt Amount FND" := 0;
            END;
        END;
        //HEI.02<<

        IF InvoicePostBuffer.Type <> InvoicePostBuffer.Type::"Prepmt. Exch. Rate Difference" THEN
            GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::Purchase;
        IF InvoicePostBuffer.Type = InvoicePostBuffer.Type::"Fixed Asset" THEN BEGIN
            IF InvoicePostBuffer."FA Posting Type" = InvoicePostBuffer."FA Posting Type"::"Acquisition Cost" THEN
                GenJnlLine."FA Posting Type" := GenJnlLine."FA Posting Type"::"Acquisition Cost";
            IF InvoicePostBuffer."FA Posting Type" = InvoicePostBuffer."FA Posting Type"::Maintenance THEN
                GenJnlLine."FA Posting Type" := GenJnlLine."FA Posting Type"::Maintenance;
            if InvoicePostBuffer.Type = InvoicePostBuffer.Type::"Fixed Asset" then
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Fixed Asset";
            //CopyFromInvoicePostBufferFA(InvoicePostBuffer); //NAV Code
            InvoicePostBuffer.CopyToGenJnlLineFA(GenJnlLine)//BC Code.
        END;
        //HEI.11>>
        IF (GenJnlLine."Source Type" = GenJnlLine."Source Type"::Vendor) THEN BEGIN
            GenJnlLine."Reference Number FND" := PurchHeader."Your Reference";
            IF (PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice) OR
               (PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo")
            THEN BEGIN
                IF PurchHeader."Purchase Order No. FND" <> '' THEN
                    GenJnlLine."PO Number FND" := PurchHeader."Purchase Order No. FND"
                ELSE
                    IF PurchRcptHeader2.GET(InvoicePostBuffer."Purchase Receipt No. FND") THEN
                        GenJnlLine."PO Number FND" := PurchRcptHeader2."Order No.";
            END ELSE
                IF (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) OR
                   (PurchHeader."Document Type" = PurchHeader."Document Type"::"Return Order")
                THEN
                    GenJnlLine."PO Number FND" := PurchHeader."No.";
        END;
        //HEI.11<<
        //HEI.25>>


        GenJnlLine."Additional Description FND" := InvoicePostBuffer."Additional Description FND";

        //HEI.25<<
        EXIT(RunGenJnlPostLine(GenJnlLine, PurchHeader));
        //END;
        // BC Upgrade MISHRS14 <<
    end;

    local procedure PostFAReturnPostingBuffer(PurchHeader: Record "Purchase Header"; var TempInvoicePostBuffer: Record "Invoice Posting Buffer" temporary; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20];
                                                                                                                                                                        ExtDocNo: Code[35]) TotalInvAmount: Decimal
    var
        CurrencyDocument: Record Currency;
        VATPostingSetup: Record "VAT Posting Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        VATAmountRemainder: Decimal;
        VATAmountACYRemainder: Decimal;
        GLEntryNo: Integer;

    begin
        LineCount := 0;
        IF TempInvoicePostBuffer.FIND('+') THEN
            REPEAT

                LineCount := LineCount + 1;
                IF FASetup."Post GL on Purch. Receive FND" = FALSE THEN BEGIN//HEI.02
                    IF GUIALLOWED THEN
                        Window.UPDATE(3, LineCount);
                END;

                CASE TempInvoicePostBuffer."VAT Calculation Type" OF
                    TempInvoicePostBuffer."VAT Calculation Type"::"Reverse Charge VAT":
                        BEGIN
                            VATPostingSetup.GET(
                            TempInvoicePostBuffer."VAT Bus. Posting Group", TempInvoicePostBuffer."VAT Prod. Posting Group");
                            TempInvoicePostBuffer."VAT Amount" :=
                            ROUND(
                            TempInvoicePostBuffer."VAT Base Amount" *
                            (1 - PurchHeader."VAT Base Discount %" / 100) * VATPostingSetup."VAT %" / 100);
                            // TempInvoicePostBuffer."VAT Amount (ACY)" :=
                            // ROUND(
                            // TempInvoicePostBuffer."VAT Base Amount (ACY)" * (1 - PurchHeader."VAT Base Discount %" / 100) *
                            // VATPostingSetup."VAT %" / 100, Currency."Amount Rounding Precision");
                            //soicad>>
                            IF VATPostingSetup."Reverse Charge VAT % FND" <> 0 THEN BEGIN
                                TempInvoicePostBuffer."Real VAT Amount FND" := TempInvoicePostBuffer."VAT Amount";

                                TempInvoicePostBuffer."VAT Amount" := ROUND(TempInvoicePostBuffer."VAT Amount" * VATPostingSetup."Reverse Charge VAT % FND" / 100);
                                TempInvoicePostBuffer."VAT Amount (ACY)" := ROUND(TempInvoicePostBuffer."VAT Amount (ACY)" * VATPostingSetup."Reverse Charge VAT % FND" / 100);
                                TempInvoicePostBuffer."Real VAT Amount FND" := TempInvoicePostBuffer."Real VAT Amount FND" - TempInvoicePostBuffer."VAT Amount";
                                // VendorAddAmt += TempInvoicePostBuffer."Real VAT Amount";
                            END;
                            //soicad>>

                        END;
                    TempInvoicePostBuffer."VAT Calculation Type"::"Sales Tax":
                        IF TempInvoicePostBuffer."Use Tax" THEN BEGIN
                            TempInvoicePostBuffer."VAT Amount" :=
                            ROUND(
                            SalesTaxCalculate.CalculateTax(
                            TempInvoicePostBuffer."Tax Area Code", TempInvoicePostBuffer."Tax Group Code",
                            TempInvoicePostBuffer."Tax Liable", PurchHeader."Posting Date",
                            TempInvoicePostBuffer.Amount, TempInvoicePostBuffer.Quantity, 0));
                            IF GLSetup."Additional Reporting Currency" <> '' THEN
                                TempInvoicePostBuffer."VAT Amount (ACY)" :=
                                CurrExchRate.ExchangeAmtLCYToFCY(
                                PurchHeader."Posting Date", GLSetup."Additional Reporting Currency",
                                TempInvoicePostBuffer."VAT Amount", 0);
                        END;
                END;
                //HEI.02>>
                //IF FASetup."Post GL on Purch. Receive FND" AND (TempInvoicePostBuffer.Type = TempInvoicePostBuffer.Type::"Fixed Asset") AND (TempInvoicePostBuffer."Purchase Receipt Amount" <> 0 ) THEN BEGIN  //HEI.43
                IF (PurchHeader."Document Type" <> PurchHeader."Document Type"::"Credit Memo") AND   //HEI.43
                        FASetup."Post GL on Purch. Receive FND" AND (TempInvoicePostBuffer.Type = TempInvoicePostBuffer.Type::"Fixed Asset") AND (TempInvoicePostBuffer."Purchase Receipt Amount FND" <> 0) THEN BEGIN  //HEI.43
                    IF PurchHeader.Invoice THEN BEGIN
                        IF TempInvoicePostBuffer.Amount <> TempInvoicePostBuffer."Purchase Receipt Amount FND" THEN BEGIN
                            //   UpdateFaGLEntry(PurchInvHeader, TempInvoicePostBuffer);
                            //HEI.38>>
                            //TempInvoicePostBuffer.Amount := TempInvoicePostBuffer.Amount - TempInvoicePostBuffer."Purchase Receipt Amount";
                            TempInvoicePostBuffer.Amount := TempInvoicePostBuffer.Amount - (TempInvoicePostBuffer.Quantity * TempInvoicePostBuffer."Purchase Receipt Unit Cost FND");
                            //HEI.38<<
                            TempInvoicePostBuffer.Amount := ROUND(TempInvoicePostBuffer.Amount, GLSetup."Amount Rounding Precision");//HEI.40
                                                                                                                                     //  GLEntryNo := PostInvoicePostBufferLine(PurchHeader, TempInvoicePostBuffer);
                            PostGLOnFaDiffOnInvoice(PurchHeader, TempInvoicePostBuffer);
                        END ELSE BEGIN
                            // UpdateFaGLEntry(PurchInvHeader, TempInvoicePostBuffer);
                            // TempInvoicePostBuffer.Amount := TempInvoicePostBuffer.Amount - TempInvoicePostBuffer."Purchase Receipt Amount";
                            // GLEntryNo := PostInvoicePostBufferLine(PurchHeader, TempInvoicePostBuffer);
                        END;
                        //HEI.02<<
                    END ELSE
                        GLEntryNo := PostFAPostBufferLine(PurchHeader, TempInvoicePostBuffer, DocType, DocNo, ExtDocNo)
                    //HEI.43>>
                END ELSE IF (PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo") AND
                    //(FASetup."Post GL on Purchase Return FND") AND (TempInvoicePostBuffer.Type = TempInvoicePostBuffer.Type::"Fixed Asset") AND PurchHeader.IsCreditDocType THEN BEGIN  //HEI.44
                    (FASetup."Post GL on Purchase Return FND") AND (TempInvoicePostBuffer.Type = TempInvoicePostBuffer.Type::"Fixed Asset") AND (TempInvoicePostBuffer."Purchase Receipt Amount FND" <> 0) THEN BEGIN  //HEI.44
                    IF PurchHeader.Invoice THEN BEGIN
                        IF TempInvoicePostBuffer.Amount <> TempInvoicePostBuffer."Purchase Receipt Amount FND" THEN BEGIN
                            //UpdateFaGLEntry(PurchCrMemoHeader,TempInvoicePostBuffer); //blank function commented
                            TempInvoicePostBuffer.Amount := TempInvoicePostBuffer.Amount + (TempInvoicePostBuffer.Quantity * TempInvoicePostBuffer."Purchase Receipt Unit Cost FND");
                            TempInvoicePostBuffer.Amount := ROUND(TempInvoicePostBuffer.Amount, GLSetup."Amount Rounding Precision");
                            //  GLEntryNo := PostInvoicePostBufferLine(PurchHeader, TempInvoicePostBuffer);
                            //  PostGLOnFaDiffOnCreditMemo(PurchHeader, TempInvoicePostBuffer);
                        END ELSE BEGIN

                            //UpdateFaGLEntry(PurchCrMemoHeader,TempInvoicePostBuffer); //blank function commented
                            TempInvoicePostBuffer.Amount := TempInvoicePostBuffer.Amount - TempInvoicePostBuffer."Purchase Receipt Amount FND";
                            GLEntryNo := PostFAPostBufferLine(PurchHeader, TempInvoicePostBuffer, DocType, DocNo, ExtDocNo)
                        END;
                    END ELSE
                        GLEntryNo := PostFAPostBufferLine(PurchHeader, TempInvoicePostBuffer, DocType, DocNo, ExtDocNo)
                    //HEI.43<<
                END ELSE
                    GLEntryNo := PostFAPostBufferLine(PurchHeader, TempInvoicePostBuffer, DocType, DocNo, ExtDocNo);

            //HEI.02<<
            //GLEntryNo := PostInvoicePostBufferLine(PurchHeader,TempInvoicePostBuffer);Hei.02
            // <<DITW15.00.00.01 DDR 27/12/2007
            // Post G/L and Item Charges relation
            // CreateGLItemChargeRelation(TempInvoicePostBuffer."Item Charge Line No."); //HEI.24 commented
            // >>DITW15.00.00.01 DDR

            //     GetItemChargesLinesToCreateGLItemRelation(PurchHeader, TempInvoicePostBuffer); //HEI.24
            //     IF (TempInvoicePostBuffer."Job No." <> '') AND
            // (TempInvoicePostBuffer.Type = TempInvoicePostBuffer.Type::"G/L Account")
            // THEN
            //         JobPostLine.PostPurchaseGLAccounts(TempInvoicePostBuffer, GLEntryNo);

            UNTIL TempInvoicePostBuffer.NEXT(-1) = 0;

        TempInvoicePostBuffer.CALCSUMS(Amount);
        TotalInvAmount := TempInvoicePostBuffer.Amount;

        TempInvoicePostBuffer.DELETEALL();
    end;

    local procedure GetItemChargesLinesToCreateGLItemRelation(PurchHeader: Record "Purchase Header"; VAR TempInvoicePostBuffer: Record "Invoice Posting Buffer" temporary)
    var
        PurchLine: Record "Purchase Line";
    begin
        //HEI.24>>
        PurchLine.RESET();
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        PurchLine.SETRANGE(Type, PurchLine.Type::"Charge (Item)");
        PurchLine.SETRANGE("Gen. Bus. Posting Group", TempInvoicePostBuffer."Gen. Bus. Posting Group");
        PurchLine.SETRANGE("Gen. Prod. Posting Group", TempInvoicePostBuffer."Gen. Prod. Posting Group");
        PurchLine.SETRANGE("VAT Prod. Posting Group", TempInvoicePostBuffer."VAT Prod. Posting Group");
        PurchLine.SETRANGE("VAT Bus. Posting Group", TempInvoicePostBuffer."VAT Bus. Posting Group");
        PurchLine.SETRANGE("Dimension Set ID", TempInvoicePostBuffer."Dimension Set ID");
        IF PurchLine.FINDSET() THEN
            REPEAT
                CreateGLItemChargeRelation(PurchLine."Line No.");
            UNTIL PurchLine.NEXT() = 0;
        //HEI.24>>

    end;

    local procedure PostPurchaseGLAccounts(TempInvoicePostBuffer: Record "Invoice Posting Buffer" temporary; GLEntryNo: Integer)
    begin

        TempPurchaseLineJob.RESET();
        TempPurchaseLineJob.SETRANGE("Job No.", TempInvoicePostBuffer."Job No.");
        TempPurchaseLineJob.SETRANGE("No.", TempInvoicePostBuffer."G/L Account");
        TempPurchaseLineJob.SETRANGE("Gen. Bus. Posting Group", TempInvoicePostBuffer."Gen. Bus. Posting Group");
        TempPurchaseLineJob.SETRANGE("Gen. Prod. Posting Group", TempInvoicePostBuffer."Gen. Prod. Posting Group");
        TempPurchaseLineJob.SETRANGE("VAT Bus. Posting Group", TempInvoicePostBuffer."VAT Bus. Posting Group");
        TempPurchaseLineJob.SETRANGE("VAT Prod. Posting Group", TempInvoicePostBuffer."VAT Prod. Posting Group");
        IF TempPurchaseLineJob.FINDSET() THEN BEGIN
            REPEAT
                TempJobJournalLine.RESET();
                TempJobJournalLine.SETRANGE("Line No.", TempPurchaseLineJob."Line No.");
                TempJobJournalLine.FINDFIRST();
                JobJnlPostLine.SetGLEntryNo(GLEntryNo);
                JobJnlPostLine.RunWithCheck(TempJobJournalLine);
            UNTIL TempPurchaseLineJob.NEXT() = 0;
            TempPurchaseLineJob.DELETEALL();
        END;
    end;

    local procedure RunGenJnlPostLine(VAR GenJnlLine: Record "Gen. Journal Line"; PurchHeader: Record "Purchase Header"): Integer
    begin
        EXIT(GenJnlPostLine.RunWithCheck(GenJnlLine));
    end;

    local procedure CreateGLItemChargeRelation(pItemChargeLineNo: Integer)
    var
        lrGLReg: Record "G/L Register";
        lrGLItemLedgRelation: Record "G/L - Item Ledger Relation";
        lrTempGLEntry: Record "G/L Entry";
    begin

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with rTempGLItemLedgRelation. 
        //WITH rTempGLItemLedgRelation DO BEGIN
        rTempGLItemLedgRelation.RESET();
        rTempGLItemLedgRelation.SETRANGE("G/L Entry No.", pItemChargeLineNo);
        IF rTempGLItemLedgRelation.FINDSET() THEN BEGIN
            GenJnlPostLine.GetGLReg(lrGLReg);
            CollectGLEntryRelation(lrTempGLEntry);
            IF lrTempGLEntry.FINDSET() THEN
                REPEAT
                    lrGLItemLedgRelation := rTempGLItemLedgRelation;
                    lrGLItemLedgRelation."G/L Entry No." := lrTempGLEntry."Entry No.";
                    lrGLItemLedgRelation."G/L Register No." := lrGLReg."No.";
                    lrGLItemLedgRelation.INSERT();
                UNTIL rTempGLItemLedgRelation.NEXT() = 0;
        END;
        //END;
        // BC Upgrade MISHRS14 <<

    end;

    local procedure CollectGLEntryRelation(VAR TargetGLEntry: Record "G/L Entry" temporary): Boolean
    // <<DITW15.00.00.01 DDR 27/12/2007 - DITW17.10.02 DDR 22/11/2013 DIT-770 #000
    begin

        TempGLEntryBuf.RESET();
        TargetGLEntry.RESET();

        IF NOT TempGLEntryBuf.FINDFIRST() THEN
            EXIT(FALSE)
        ELSE
            REPEAT
                TargetGLEntry := TempGLEntryBuf;
                TargetGLEntry.INSERT();
            UNTIL TempGLEntryBuf.NEXT() = 0;

        // GLEntryTmp.DELETEALL;

        EXIT(TRUE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnPostPurchLineOnBeforeDivideAmount, '', false, false)]
    local procedure PurchPost_OnPostPurchLineOnBeforeDivideAmount(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var TempVATAmountLine: Record "VAT Amount Line" temporary; var TempVATAmountLineRemainder: Record "VAT Amount Line" temporary; var IsHandled: Boolean)
    var
    begin
        //Drink IT code
        FASetup.Get();
        //DivideAmount(PurchHeader,PurchLine,1,"Qty. to Invoice",TempVATAmountLine,TempVATAmountLineRemainder,TRUE);
        IF FASetup."Post GL on Purch. Receive FND" THEN BEGIN
            IF PurchHeader.Receive AND (PurchLine.Type = PurchLine.Type::"Fixed Asset") THEN
                PurchPost.DivideAmount(PurchHeader, PurchLine, 1, PurchLine."Qty. to Receive", TempVATAmountLine, TempVATAmountLineRemainder)//HEI.02
            ELSE IF ((FASetup."Post GL on Purchase Return FND") AND (PurchHeader.Ship)) AND (PurchLine.Type = PurchLine.Type::"Fixed Asset") THEN //HEI.43
                PurchPost.DivideAmount(PurchHeader, PurchLine, 1, PurchLine."Return Qty. to Ship", TempVATAmountLine, TempVATAmountLineRemainder)//HEI.43
            ELSE
                PurchPost.DivideAmount(PurchHeader, PurchLine, 1, PurchLine."Qty. to Invoice", TempVATAmountLine, TempVATAmountLineRemainder);

        END ELSE
            PurchPost.DivideAmount(PurchHeader, PurchLine, 1, PurchLine."Qty. to Invoice", TempVATAmountLine, TempVATAmountLineRemainder);
        IsHandled := true;

        //Drink IT code
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePostLines, '', false, false)]
    local procedure OnBeforePostLines(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; PreviewMode: Boolean)
    var
        FADepBook: Record "FA Depreciation Book";
        DepBook: Record "Depreciation Book";
        PurchLineCopy: Record "Purchase Line";
        ReturnAmtLCY: Decimal;
    begin

        //PurchLineCopy.Copy(PurchLine);
        if not PurchHeader.ship then
            exit;
        PurchLineCopy.Reset();
        PurchLineCopy.SetRange("Document No.", PurchHeader."No.");
        PurchLineCopy.SetRange("Document Type", PurchHeader."Document Type");
        PurchLineCopy.SetRange(Type, PurchLineCopy.Type::"Fixed Asset");
        if PurchLineCopy.FindFirst() then begin //BC Upgrade SHARMP16 BEGIN<<
            repeat
                Clear(ReturnAmtLCY);
                if (PurchLineCopy.Type = PurchLineCopy.Type::"Fixed Asset") and (PurchLineCopy."Return Qty. to Ship" <> 0) then begin
                    if PurchHeader."Currency Code" <> '' then
                        ReturnAmtLCY := (PurchLineCopy."Return Qty. to Ship" * PurchLineCopy."Direct Unit Cost") / PurchHeader."Currency Factor"
                    else
                        ReturnAmtLCY := (PurchLineCopy."Return Qty. to Ship" * PurchLineCopy."Direct Unit Cost");
                    DepBook.RESET();
                    IF DepBook.FINDFIRST() THEN BEGIN

                        //HEI.12>>
                        FADepBook.SETCURRENTKEY("FA No.", "Depreciation Book Code");
                        FADepBook.SETRANGE("FA No.", PurchLineCopy."No.");
                        FADepBook.SETRANGE("Depreciation Book Code", DepBook.Code);
                        IF FADepBook.FINDFIRST() THEN BEGIN
                            FADepBook.CalcFields("Book Value");
                            if FADepBook."Book Value" < ReturnAmtLCY then
                                Error('For fixed asset %1 and depr book code %2. The current book value is %3 which is lesser than return amount %4', FADepBook."FA No.", FADepBook."Depreciation Book Code", FADepBook."Book Value", ReturnAmtLCY);
                        end;
                    end;
                end;
            until PurchLineCopy.Next() = 0;

            //  Error('%1 count..%2 amount..%3 qty', PurchLine.Count, PurchLine.Amount, PurchLine."Return Qty. to Ship");
        end;//BC Upgrade SHARMP16 END>>
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnRunOnBeforePostInvoice, '', false, false)]
    local procedure OnRunOnBeforePostInvoice(PurchaseHeader: Record "Purchase Header"; var EverythingInvoiced: Boolean)
    begin
        FASetup.Get();

        IF FASetup."Post GL on Purch. Receive FND" THEN BEGIN
            IF PurchaseHeader.Invoice AND (PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::"Credit Memo") THEN BEGIN  //HEI.43
                ibmtemppostingglobal.SetRange("FA Invoice No.", PurchaseHeader."Posting No.");                                                                                                             //  if (PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset") and (PurchaseLine."Qty. to Invoice" <> 0) then begin
                if ibmtemppostingglobal.FindFirst() then begin
                    PostGLOnFaInvoice(PurchaseHeader, ibmtemppostingglobal); //HEI.22
                    ibmtemppostingglobal.DeleteAll();                                             // PostGLAndVendor(PurchaseHeader, InvoicePostBufferGolbal, PurchaseHeader."Document Type"::Invoice, PurchaseHeader."No.", PurchaseHeader."Vendor Invoice No.");
                end;                                                                  //  end;
            END; //HEI.22
        end;
        //-------------------------------Return------------------------------------
        IF FASetup."Post GL on Purchase Return FND" THEN BEGIN
            IF PurchaseHeader.Invoice AND (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo") THEN BEGIN  //HEI.43
                ibmtemppostingglobal.SetRange("FA Invoice No.", PurchaseHeader."Posting No.");                                                                                                             //  if (PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset") and (PurchaseLine."Qty. to Invoice" <> 0) then begin
                if ibmtemppostingglobal.FindFirst() then begin
                    PostGLOnFaCrMemo(PurchaseHeader, ibmtemppostingglobal); //HEI.22
                    ibmtemppostingglobal.DeleteAll();                                             // PostGLAndVendor(PurchaseHeader, InvoicePostBufferGolbal, PurchaseHeader."Document Type"::Invoice, PurchaseHeader."No.", PurchaseHeader."Vendor Invoice No.");
                end;                                                                  //  end;
            END; //HEI.22
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnAfterPrepareGenJnlLine, '', false, false)]
    local procedure OnAfterPrepareGenJnlLine(InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary; PurchHeader: Record "Purchase Header"; var GenJnlLine: Record "Gen. Journal Line")
    begin
        if InvoicePostingBuffer."FA GRIR Account FND" = true then begin
            GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
            GenJnlLine."Reference Number FND" := InvoicePostingBuffer."Purchase Reference FND";
            GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
            GenJnlLine."Source No." := InvoicePostingBuffer."Purchase Source No FND";
            GenJnlLine."PO Number FND" := InvoicePostingBuffer."Purchase Order No. FND";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnAfterPrepareInvoicePostingBuffer, '', false, false)]
    local procedure PurchPostInvoiceEvents_OnAfterPrepareInvoicePostingBuffer(var PurchaseLine: Record "Purchase Line"; var InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary)
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchaseHeader: Record "Purchase Header";
        PurchAccount: Code[20];
        Currency2: Record Currency;
        ReturnShipmentLine: Record "Return Shipment Line";
    //py:Codeunit "Purch. Post Invoice"
    begin

        PurchaseHeader.get(PurchaseLine."Document Type", PurchaseLine."Document No.");
        //HEI.02>>
        FASetup.GET();
        //IF FASetup."Post GL on Purch. Receive FND" THEN BEGIN  //HEI.43
        IF (FASetup."Post GL on Purch. Receive FND") AND (PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice]) THEN BEGIN  //HEI.43
            IF PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset" THEN BEGIN
                IF PurchaseHeader.Receive AND (PurchaseHeader.Invoice = FALSE) THEN begin
                    InvoicePostingBuffer."Purchase Receipt Line No. FND" := PurchaseLine."Line No.";
                    InvoicePostingBuffer.Amount := PurchaseLine.Amount;
                    //HEI.38<<
                end ELSE BEGIN
                    InvoicePostingBuffer."Purchase Receipt Line No. FND" := PurchaseLine."Receipt Line No.";
                    InvoicePostingBuffer."Purchase Receipt No. FND" := PurchaseLine."Receipt No.";
                    InvoicePostingBuffer.Amount := PurchaseLine.Amount;
                    InvoicePostingBuffer."Purchase Receipt Amount FND" := GetFaLedgerEntryCost(PurchaseLine);
                    //HEI.38>>
                    IF PurchRcptLine.GET(PurchaseLine."Receipt No.", PurchaseLine."Receipt Line No.") THEN BEGIN
                        InvoicePostingBuffer."Purchase Receipt Unit Cost FND" := PurchRcptLine."Unit Cost (LCY)";  //HEI.39
                        InvoicePostingBuffer.Quantity := PurchaseLine.Quantity;  //Quantity is from Invoice Line
                    END;
                    //HEI.38<<

                END;
            END;
        END;
        //HEI.02<<
        //HEI.43>>
        FASetup.GET();
        IF (FASetup."Post GL on Purchase Return FND") AND (PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::"Return Order", PurchaseHeader."Document Type"::"Credit Memo"]) THEN BEGIN
            IF PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset" THEN BEGIN
                IF PurchaseHeader.Ship AND (PurchaseHeader.Invoice = FALSE) THEN begin
                    InvoicePostingBuffer."Purchase Receipt Line No. FND" := PurchaseLine."Line No.";
                    InvoicePostingBuffer.Amount := PurchaseLine.Amount;

                end ELSE BEGIN

                    InvoicePostingBuffer."Purchase Receipt Line No. FND" := PurchaseLine."Return Shipment Line No.";
                    InvoicePostingBuffer."Purchase Receipt No. FND" := PurchaseLine."Return Shipment No.";
                    InvoicePostingBuffer.Amount := PurchaseLine.Amount;
                    InvoicePostingBuffer."Purchase Receipt Amount FND" := GetFaLedgerEntryCostforShipment(PurchaseLine);
                    IF ReturnShipmentLine.GET(PurchaseLine."Return Shipment No.", PurchaseLine."Return Shipment Line No.") THEN BEGIN
                        InvoicePostingBuffer."Purchase Receipt Unit Cost FND" := ReturnShipmentLine."Unit Cost (LCY)";
                        InvoicePostingBuffer.Quantity := PurchaseLine.Quantity;
                    END;
                END;
            END;
        END;
        //HEI.43<<
        IF PurchaseHeader.Receive or PurchaseHeader.ship then begin
            IF (PurchaseLine.Type = PurchaseLine.Type::"G/L Account") OR (PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset") THEN BEGIN
                PurchAccount := PurchaseLine."No.";
                InvoicePostingBuffer."G/L Account" := PurchAccount;
                //Message('%1 Purch Account', PurchAccount);
            end;

            if InvoicePostingBuffer.Type = InvoicePostingBuffer.Type::"Fixed Asset" then begin
                FALineNo := FALineNo + 1;
                InvoicePostingBuffer."Fixed Asset Line No." := PurchaseLine."Line No.";
                InvoicePostingBuffer.Update(InvoicePostingBuffer);
            end;//Bc upgrade sharmp16 -- need to check.
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin
        GLEntry."FA Receipt Line No. FND" := GenJournalLine."FA Receipt Line No. FND";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Make FA Ledger Entry", OnAfterCopyFromGenJnlLine, '', false, false)]
    local procedure MakeFALedgerEntry_OnAfterCopyFromGenJnlLine(var FALedgerEntry: Record "FA Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        FALedgerEntry."Purchase Receipt Line No. FND" := GenJournalLine."Purchase Receipt Line No. FND";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Invoice Posting Buffer", OnAfterCopyToGenJnlLine, '', false, false)]
    local procedure InvoicePostingBuffer_OnAfterCopyToGenJnlLine(var GenJnlLine: Record "Gen. Journal Line"; InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary)
    begin
        GenJnlLine."Purchase Receipt Line No. FND" := InvoicePostingBuffer."Purchase Receipt Line No. FND";
        //  GenJnlLine."Purchase Receipt Amount" := InvoicePostingBuffer."Purchase Receipt Amount";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnPrepareLineOnAfterUpdateInvoicePostingBuffer, '', false, false)]
    local procedure OnPrepareLineOnAfterUpdateInvoicePostingBuffer(PurchHeader: Record "Purchase Header"; PurchLine: Record "Purchase Line"; var InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary; var TempInvoicePostingBuffer: Record "Invoice Posting Buffer" temporary)
    var
        InvPostingbuffer1: Record "Invoice Posting Buffer" temporary;
    begin
        if not PurchHeader.Invoice then
            exit;
        TempInvoicePostingBuffer."Additional Description FND" := PurchLine."Additional Description FND";

        InvPostingbuffer1.Reset();
        InvPostingbuffer1.Copy(TempInvoicePostingBuffer);


        ibmtemppostingglobal.SetRange("Group ID", TempInvoicePostingBuffer."Group ID");
        if ibmtemppostingglobal.FindFirst() then
            ibmtemppostingglobal.DeleteAll();
        Clear(ibmtemppostingglobal);

        repeat
            ibmtemppostingglobal.Init();
            ibmtemppostingglobal.TransferFields(InvPostingbuffer1);
            ibmtemppostingglobal."FA Invoice No." := PurchHeader."Posting No.";

            if ibmtemppostingglobal.Type = ibmtemppostingglobal.Type::"Fixed Asset" then
                ibmtemppostingglobal.Insert();

        until InvPostingbuffer1.Next() = 0;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnCalculateVATAmountsOnAfterVatCalculationType, '', false, false)]
    local procedure OnCalculateVATAmountsOnAfterVatCalculationType(var PurchHeader: Record "Purchase Header"; var TempInvoicePostingBuffer: Record "Invoice Posting Buffer" temporary)
    var
        GroupIdtext: Text[1000];
        descrtext: Text[100];
        FAPurchGRIR: Record "purchase FA Heilite GRIR FND";
        DiffGRIRAmount: Decimal;
        Textconstgroup1: Label 'GRIR1';
        Textconstgroup2: Label 'GRIR2';
        FAFound: Boolean;
    begin

        if not PurchHeader.Invoice then
            exit;
        descrtext := TempInvoicePostingBuffer."Entry Description";
        FASetup.GET();
        IF (FASetup."Post GL on Purch. Receive FND") and (PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice) THEN BEGIN
            repeat
                //HEI.02>>
                IF (PurchHeader."Document Type" <> PurchHeader."Document Type"::"Credit Memo") AND   //HEI.43
                        FASetup."Post GL on Purch. Receive FND" AND (TempInvoicePostingBuffer.Type = TempInvoicePostingBuffer.Type::"Fixed Asset") AND (TempInvoicePostingBuffer."Purchase Receipt Amount FND" <> 0) THEN BEGIN  //HEI.43
                    IF PurchHeader.Invoice THEN BEGIN

                        IF TempInvoicePostingBuffer.Amount <> (TempInvoicePostingBuffer.Quantity * TempInvoicePostingBuffer."Purchase Receipt Unit Cost FND") THEN BEGIN

                            TempInvoicePostingBuffer.Amount := TempInvoicePostingBuffer.Amount - (TempInvoicePostingBuffer.Quantity * TempInvoicePostingBuffer."Purchase Receipt Unit Cost FND");
                            //HEI.38<<
                            TempInvoicePostingBuffer.Amount := ROUND(TempInvoicePostingBuffer.Amount, GLSetup."Amount Rounding Precision");//HEI.40
                            DiffGRIRAmount += TempInvoicePostingBuffer.Amount;
                            TempInvoicePostingBuffer.Modify();
                            FAFound := true;
                        END ELSE BEGIN
                            TempInvoicePostingBuffer.Amount := TempInvoicePostingBuffer.Amount - (TempInvoicePostingBuffer.Quantity * TempInvoicePostingBuffer."Purchase Receipt Unit Cost FND");
                            TempInvoicePostingBuffer.Modify();
                            FAFound := true;
                        END;


                        //HEI.02<<

                    END;
                end;
            until TempInvoicePostingBuffer.Next() = 0;
        END;



        FASetup.GET();
        FASetup.TESTFIELD("Payable Acc.Purch. Receipt FND");
        //HEI.43>>
        IF FASetup."Post GL on Purchase Return FND" THEN
            FASetup.TESTFIELD("Payable Acc. Purch. Return FND");

        //HEI.43<<

        IF (FASetup."Post GL on Purch. Receive FND") and (PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice) and FAFound THEN BEGIN
            FAPurchGRIR.Get(PurchHeader."Document Type", PurchHeader."No.");
            TempInvoicePostingBuffer.Init();
            TempInvoicePostingBuffer."Group ID" := Textconstgroup1;
            TempInvoicePostingBuffer.Type := TempInvoicePostingBuffer.Type::"G/L Account";
            TempInvoicePostingBuffer."G/L Account" := FASetup."Payable Acc.Purch. Receipt FND";
            TempInvoicePostingBuffer.Amount := FAPurchGRIR."FA GRIR Amount";
            TempInvoicePostingBuffer."System-Created Entry" := true;
            TempInvoicePostingBuffer."FA GRIR Account FND" := true;
            TempInvoicePostingBuffer."Purchase Reference FND" := PurchHeader."Your Reference";
            TempInvoicePostingBuffer."Purchase Source No FND" := PurchHeader."Buy-from Vendor No.";
            TempInvoicePostingBuffer."Purchase Order No. FND" := PurchHeader."Purchase Order No. FND";
            TempInvoicePostingBuffer."Entry Description" := descrtext;
            TempInvoicePostingBuffer."Dimension Set ID" := FAPurchGRIR."Dimension Set ID";
            TempInvoicePostingBuffer."Global Dimension 1 Code" := FAPurchGRIR."Shortcut Dimension 1 Code";
            TempInvoicePostingBuffer."Global Dimension 2 Code" := FAPurchGRIR."Shortcut Dimension 2 Code";

            TempInvoicePostingBuffer.Insert();
            if DiffGRIRAmount <> 0 then begin
                TempInvoicePostingBuffer.Init();
                TempInvoicePostingBuffer."Group ID" := Textconstgroup2;
                TempInvoicePostingBuffer.Type := TempInvoicePostingBuffer.Type::"G/L Account";
                TempInvoicePostingBuffer."G/L Account" := FASetup."Payable Acc.Purch. Receipt FND";
                TempInvoicePostingBuffer.Amount := -DiffGRIRAmount;
                TempInvoicePostingBuffer."System-Created Entry" := true;
                TempInvoicePostingBuffer."FA GRIR Account FND" := true;
                TempInvoicePostingBuffer."Purchase Reference FND" := PurchHeader."Your Reference";
                TempInvoicePostingBuffer."Purchase Source No FND" := PurchHeader."Buy-from Vendor No.";
                TempInvoicePostingBuffer."Purchase Order No. FND" := PurchHeader."Purchase Order No. FND";
                TempInvoicePostingBuffer."Entry Description" := descrtext;
                TempInvoicePostingBuffer."Dimension Set ID" := FAPurchGRIR."Dimension Set ID";
                TempInvoicePostingBuffer."Global Dimension 1 Code" := FAPurchGRIR."Shortcut Dimension 1 Code";
                TempInvoicePostingBuffer."Global Dimension 2 Code" := FAPurchGRIR."Shortcut Dimension 2 Code";
                TempInvoicePostingBuffer.Insert();
            end;
        end;


        //--------------------------------------------CrMemo----------------------------------------
        ////-----------------------------------------------------Cr Memo------------------------------------------

        IF (FASetup."Post GL on Purchase Return FND") and (PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo") THEN BEGIN
            repeat
                //HEI.02>>
                IF (PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo") AND   //HEI.43
                        FASetup."Post GL on Purchase Return FND" AND (TempInvoicePostingBuffer.Type = TempInvoicePostingBuffer.Type::"Fixed Asset") AND (TempInvoicePostingBuffer."Purchase Receipt Amount FND" <> 0) THEN BEGIN  //HEI.43
                    IF PurchHeader.Invoice THEN BEGIN
                        // Message('%1 amt..%2 qty..%3 unitcost', TempInvoicePostingBuffer.Amount, TempInvoicePostingBuffer.Quantity, TempInvoicePostingBuffer."Purchase Receipt Unit Cost FND");

                        IF (-TempInvoicePostingBuffer.Amount) <> (TempInvoicePostingBuffer.Quantity * TempInvoicePostingBuffer."Purchase Receipt Unit Cost FND") THEN BEGIN
                            TempInvoicePostingBuffer.Amount := TempInvoicePostingBuffer.Amount + (TempInvoicePostingBuffer.Quantity * TempInvoicePostingBuffer."Purchase Receipt Unit Cost FND");

                            //HEI.38<<
                            TempInvoicePostingBuffer.Amount := ROUND(TempInvoicePostingBuffer.Amount, GLSetup."Amount Rounding Precision");//HEI.40
                            DiffGRIRAmount += TempInvoicePostingBuffer.Amount;
                            TempInvoicePostingBuffer.Modify();
                            FAFound := true;
                        END ELSE BEGIN
                            TempInvoicePostingBuffer.Amount := TempInvoicePostingBuffer.Amount + (TempInvoicePostingBuffer.Quantity * TempInvoicePostingBuffer."Purchase Receipt Unit Cost FND");
                            TempInvoicePostingBuffer.Modify();
                            FAFound := true;
                        END;


                        //HEI.02<<

                    END;
                end;
            until TempInvoicePostingBuffer.Next() = 0;
        END;
        ////-----------------------------------------------------Cr Memo------------------------------------------


        IF (FASetup."Post GL on Purchase Return FND") and (PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo") and FAFound THEN BEGIN
            FAPurchGRIR.Get(PurchHeader."Document Type", PurchHeader."No.");
            TempInvoicePostingBuffer.Init();
            TempInvoicePostingBuffer."Group ID" := Textconstgroup1;
            TempInvoicePostingBuffer.Type := TempInvoicePostingBuffer.Type::"G/L Account";
            TempInvoicePostingBuffer."G/L Account" := FASetup."Payable Acc. Purch. Return FND";
            TempInvoicePostingBuffer.Amount := FAPurchGRIR."FA GRIR Amount";
            TempInvoicePostingBuffer."System-Created Entry" := true;
            TempInvoicePostingBuffer."FA GRIR Account FND" := true;
            TempInvoicePostingBuffer."Purchase Reference FND" := PurchHeader."Your Reference";
            TempInvoicePostingBuffer."Purchase Source No FND" := PurchHeader."Buy-from Vendor No.";
            TempInvoicePostingBuffer."Purchase Order No. FND" := PurchHeader."Purchase Order No. FND";
            TempInvoicePostingBuffer."Entry Description" := descrtext;
            TempInvoicePostingBuffer."Dimension Set ID" := FAPurchGRIR."Dimension Set ID";
            TempInvoicePostingBuffer."Global Dimension 1 Code" := FAPurchGRIR."Shortcut Dimension 1 Code";
            TempInvoicePostingBuffer."Global Dimension 2 Code" := FAPurchGRIR."Shortcut Dimension 2 Code";

            TempInvoicePostingBuffer.Insert();
            if DiffGRIRAmount <> 0 then begin
                TempInvoicePostingBuffer.Init();
                TempInvoicePostingBuffer."Group ID" := Textconstgroup2;
                TempInvoicePostingBuffer.Type := TempInvoicePostingBuffer.Type::"G/L Account";
                TempInvoicePostingBuffer."G/L Account" := FASetup."Payable Acc. Purch. Return FND";
                TempInvoicePostingBuffer.Amount := -DiffGRIRAmount;
                TempInvoicePostingBuffer."System-Created Entry" := true;
                TempInvoicePostingBuffer."FA GRIR Account FND" := true;
                TempInvoicePostingBuffer."Purchase Reference FND" := PurchHeader."Your Reference";
                TempInvoicePostingBuffer."Purchase Source No FND" := PurchHeader."Buy-from Vendor No.";
                TempInvoicePostingBuffer."Purchase Order No. FND" := PurchHeader."Purchase Order No. FND";
                TempInvoicePostingBuffer."Entry Description" := descrtext;
                TempInvoicePostingBuffer."Dimension Set ID" := FAPurchGRIR."Dimension Set ID";
                TempInvoicePostingBuffer."Global Dimension 1 Code" := FAPurchGRIR."Shortcut Dimension 1 Code";
                TempInvoicePostingBuffer."Global Dimension 2 Code" := FAPurchGRIR."Shortcut Dimension 2 Code";
                TempInvoicePostingBuffer.Insert();
            end;
        end;
        //--------------------------------------------CrMemo----------------------------------------

    end;

    local procedure PostGLOnFaInvoice(VAR PurchHeader: Record "Purchase Header"; VAR TempInvoicePostBuffer: Record "Inv Posting Bffr HeiliteFA FND" temporary)
    var
        GenJnlLineDocType: Enum "Gen. Journal Document Type";
        GenJnlLineDocNo: Code[20];
        GenJnlLineExtDocNo: Code[35];
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrmemoHeader: Record "Purch. Cr. Memo Hdr.";
    begin
        //HEI.02>>
        //HEI.22<<

        TotalFAPurchLine.RESET();
        IF TempInvoicePostBuffer.FIND('+') THEN begin
            REPEAT
                IF (TempInvoicePostBuffer.Type = TempInvoicePostBuffer.Type::"Fixed Asset") AND (TempInvoicePostBuffer."Purchase Receipt Amount" <> 0) THEN
                    TotalFAPurchLine.Amount += TempInvoicePostBuffer.Amount;

            UNTIL TempInvoicePostBuffer.NEXT(-1) = 0;
        end;

        //HEI.22>>

        PurchInvHeader.SetRange("Vendor Invoice No.", PurchHeader."Vendor Invoice No.");
        If PurchInvHeader.FindFirst() then;
        //IF (TempInvoicePostBuffer.Type = TempInvoicePostBuffer.Type::"Fixed Asset")  AND (TempInvoicePostBuffer."Purchase Receipt No." <> '') THEN BEGIN //HEI.22 commented
        IF TotalFAPurchLine.Amount <> 0 THEN BEGIN //HEI.22
            GenJnlLineDocType := GenJnlLineDocType::Invoice;
            GenJnlLineDocNo := PurchInvHeader."No.";
            GenJnlLineExtDocNo := PurchHeader."Vendor Invoice No.";
            PostFaGlEntry(
              //PurchHeader,TotalPurchLine,TotalPurchLineLCY,GenJnlLineDocType,GenJnlLineDocNo,GenJnlLineExtDocNo,SrcCode); //HEI.22 commented
              PurchHeader, TotalPurchLine, TotalPurchLineLCY, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, TotalFAPurchLine); //HEI.22
        END;

    end;
    //HEI.02<<
    local procedure PostGLOnFaCrMemo(VAR PurchHeader: Record "Purchase Header"; VAR TempInvoicePostBuffer: Record "Inv Posting Bffr HeiliteFA FND" temporary)
    var
        GenJnlLineDocType: Enum "Gen. Journal Document Type";
        GenJnlLineDocNo: Code[20];
        GenJnlLineExtDocNo: Code[35];
        PurchCrmemoHeader: Record "Purch. Cr. Memo Hdr.";
    begin
        //HEI.02>>
        //HEI.22<<

        TotalFAPurchLine.RESET();
        IF TempInvoicePostBuffer.FIND('+') THEN begin
            REPEAT
                IF (TempInvoicePostBuffer.Type = TempInvoicePostBuffer.Type::"Fixed Asset") AND (TempInvoicePostBuffer."Purchase Receipt Amount" <> 0) THEN
                    TotalFAPurchLine.Amount += TempInvoicePostBuffer.Amount;

            UNTIL TempInvoicePostBuffer.NEXT(-1) = 0;
        end;

        //HEI.22>>
        PurchCrmemoHeader.SetRange("No.", PurchHeader."Posting No.");
        If PurchCrmemoHeader.FindFirst() then;
        //IF (TempInvoicePostBuffer.Type = TempInvoicePostBuffer.Type::"Fixed Asset")  AND (TempInvoicePostBuffer."Purchase Receipt No." <> '') THEN BEGIN //HEI.22 commented
        IF TotalFAPurchLine.Amount <> 0 THEN BEGIN //HEI.22
            GenJnlLineDocType := GenJnlLineDocType::"Credit Memo";
            GenJnlLineDocNo := PurchCrmemoHeader."No.";
            GenJnlLineExtDocNo := PurchHeader."Vendor Cr. Memo No.";
            PostFaGlEntry(
              //PurchHeader,TotalPurchLine,TotalPurchLineLCY,GenJnlLineDocType,GenJnlLineDocNo,GenJnlLineExtDocNo,SrcCode); //HEI.22 commented
              PurchHeader, TotalPurchLine, TotalPurchLineLCY, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, TotalFAPurchLine); //HEI.22
        END;
    end;
    //HEI.02<<
    local procedure GetFaLedgerEntryCostforShipment(PurchLineReceipt: Record "Purchase Line"): Decimal
    var
        FALedgerEntry: Record "FA Ledger Entry";
    begin
        //HEI.43>>
        FALedgerEntry.RESET();
        FALedgerEntry.SETRANGE("Document Type", FALedgerEntry."Document Type"::"Purchase Shipment");
        FALedgerEntry.SETRANGE("Document No.", PurchLineReceipt."Return Shipment No.");
        FALedgerEntry.SETRANGE("Purchase Receipt Line No. FND", PurchLineReceipt."Return Shipment Line No.");//Reusing Receipt Line No. for return shipment
        IF FALedgerEntry.FINDFIRST() THEN
            EXIT(FALedgerEntry.Amount);
        //HEI.43<<
    end;

    local procedure GetFaLedgerEntryCost(PurchLineReceipt: Record "Purchase Line"): Decimal
    var
        FALedgerEntry: Record "FA Ledger Entry";
    begin
        //HEI.02>>
        FALedgerEntry.RESET();
        FALedgerEntry.SETRANGE("Document Type", FALedgerEntry."Document Type"::"Purchase Receipt");
        FALedgerEntry.SETRANGE("Document No.", PurchLineReceipt."Receipt No.");
        FALedgerEntry.SETRANGE("Purchase Receipt Line No. FND", PurchLineReceipt."Receipt Line No.");
        IF FALedgerEntry.FINDFIRST() THEN
            EXIT(FALedgerEntry.Amount);
        //HEI.02<<
    end;

    procedure PostLedgerEntry(PurchHeaderVar: Variant; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; TotalPurchLine: Record "Purchase Line"; TotalAmt: Decimal; TotalVatAmt: Decimal; GenJnlLineDocNo: Code[20])
    var
        PurchHeader: Record "Purchase Header";
        GenJnlLine: Record "Gen. Journal Line";
        IsHandled: Boolean;
        SourcSetup: Record "Source Code Setup";
        PurcPostInvoice: Codeunit "Purch. Post Invoice";
        CurrExchRate: Record "Currency Exchange Rate";

    begin
        SourcSetup.Get();
        PurchHeader := PurchHeaderVar;
        GenJnlLine.InitNewLine(
            PurchHeader."Posting Date", PurchHeader."Document Date", PurchHeader."VAT Reporting Date", PurchHeader."Posting Description",
            PurchHeader."Shortcut Dimension 1 Code", PurchHeader."Shortcut Dimension 2 Code",
            PurchHeader."Dimension Set ID", PurchHeader."Reason Code");

        GenJnlLine.CopyDocumentFields(
            PurchHeader."Document Type", GenJnlLineDocNo,
            PurchHeader."Vendor Invoice No.", SourcSetup.Purchases, '');

        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
        GenJnlLine."Account No." := PurchHeader."Pay-to Vendor No.";
        GenJnlLine.CopyFromPurchHeader(PurchHeader);
        GenJnlLine.SetCurrencyFactor(PurchHeader."Currency Code", PurchHeader."Currency Factor");
        GenJnlLine."System-Created Entry" := true;

        GenJnlLine.CopyFromPurchHeaderApplyTo(PurchHeader);
        GenJnlLine.CopyFromPurchHeaderPayment(PurchHeader);
        GenJnlLine.Amount := -TotalAmt;
        GenJnlLine."Source Currency Amount" := -TotalAmt;
        GenJnlLine."Amount (LCY)" := -TotalAmt;
        GenJnlLine."Sales/Purch. (LCY)" := -TotalAmt;
        GenJnlLine."Inv. Discount (LCY)" := -TotalPurchLineLCY."Inv. Discount Amount";
        GenJnlLine."Orig. Pmt. Disc. Possible" := -TotalPurchLine."Pmt. Discount Amount";
        GenJnlLine."Orig. Pmt. Disc. Possible(LCY)" :=
            CurrExchRate.ExchangeAmtFCYToLCY(
                PurchHeader.GetUseDate(), PurchHeader."Currency Code", -TotalPurchLine."Pmt. Discount Amount", PurchHeader."Currency Factor");

        GenJnlPostLine.RunWithCheck(GenJnlLine);
    end;

    local procedure CheckExternalDocumentNumberHeilite(var VendLedgEntry: Record "Vendor Ledger Entry"; var PurchaseHeader: Record "Purchase Header"; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineExtDocNo: Code[35])
    var
        VendorMgt: Codeunit "Vendor Mgt.";
        Handled: Boolean;
        PurchaseAlreadyExistsErr: Label 'Purchase %1 %2 already exists for this vendor.', Comment = '%1 = Document Type, %2 = Document No.';
    begin

        VendLedgEntry.RESET();
        VendLedgEntry.SETCURRENTKEY("External Document No.");
        VendLedgEntry.SETRANGE("Document Type", GenJnlLineDocType);
        VendLedgEntry.SETRANGE("External Document No.", GenJnlLineExtDocNo);
        VendLedgEntry.SETRANGE("Vendor No.", PurchaseHeader."Pay-to Vendor No.");
        VendLedgEntry.SETRANGE(Reversed, FALSE);
        if VendLedgEntry.FindFirst() then
            Error(
              PurchaseAlreadyExistsErr, VendLedgEntry."Document Type", GenJnlLineExtDocNo);
    end;

    local procedure UpdatePurchaseHeader(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var PurchaseHeader: Record "Purchase Header"; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20];
                                                                                                                                                                   GenJnlLineExtDocNo: Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        IsHandled: Boolean;
    begin

        case GenJnlLineDocType of
            GenJnlLine."Document Type"::Invoice:
                begin
                    FindVendorLedgerEntry(GenJnlLineDocType, GenJnlLineDocNo, VendorLedgerEntry);
                    PurchaseInvHeader."Vendor Ledger Entry No." := VendorLedgerEntry."Entry No.";
                    PurchaseInvHeader.Modify();
                end;
            GenJnlLine."Document Type"::"Credit Memo":
                begin
                    FindVendorLedgerEntry(GenJnlLineDocType, GenJnlLineDocNo, VendorLedgerEntry);
                    PurchaseCrmHeader."Vendor Ledger Entry No." := VendorLedgerEntry."Entry No.";
                    PurchaseCrmHeader.Modify();
                end;
        end;

    end;

    local procedure FindVendorLedgerEntry(DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20]; var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        VendorLedgerEntry.SetRange("Document Type", DocType);
        VendorLedgerEntry.SetRange("Document No.", DocNo);
        VendorLedgerEntry.FindLast();
    end;

    //BC UPgrade SHARMP16 CU 90 END>>
    //--------------------------------------------------//BCUpgrade SHARMP16 END>> FA Cases, Undo GR/IR Cases--------------------------------------------------
    //BC UPGRADE SHARMP16 BEGIN<<<<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforeTestPurchLine, '', false, false)]
    local procedure OnBeforeTestPurchLine(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line")
    var
        PurchasesUtils: Codeunit "Purchases-Utils";
    begin
        //HEI.01 PTPGAP005>>
        PurchasesUtils.OnBeforePostPurchLine(PurchaseLine);
        //HEI.01 PTPGAP005<<
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterCheckPurchDoc, '', false, false)]
    local procedure OnAfterCheckPurchDoc(var PurchHeader: Record "Purchase Header")
    var
        PaymentMethod: Record "Payment Method";
    begin
        // HEI.03 FDD-PTPGAP007 IBM PATHAA02 29.08.17>>
        IF PurchHeader.Invoice THEN
            IF PurchHeader."Document Type" IN [PurchHeader."Document Type"::Order, PurchHeader."Document Type"::Invoice] THEN
                IF PaymentMethod.GET(PurchHeader."Payment Method Code") THEN
                    IF PaymentMethod."Mandatory Bank details FND" THEN BEGIN
                        PurchHeader.TESTFIELD("Vendor Bank Account FND");
                        // IF NOT  HeinekenGlobal.CheckBankDetails("Buy-from Vendor No.","Vendor Bank Account") THEN
                        //  ERROR(Text50000,"Vendor Bank Account");
                    END;
        //HEI.03 FDD-PTPGAP007 IBM PATHAA02 29.08.17<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterPostPurchaseDoc, '', false, false)]
    local procedure OnAfterPostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20])
    var
        PurchUtilis: Codeunit "Purchases-Utils";
    begin
        //HEI.25>>
        PopulateAdditionalDesc(PurchaseHeader, PurchInvHdrNo, PurchCrMemoHdrNo);
        //HEI.25<<
        //HEI.34>>
        PurchUtilis.UpdatePONoinPostedInvoice(PurchaseHeader, PurchInvHdrNo);
        //HEI.34<<

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePostUpdateOrderLineModifyTempLine, '', false, false)]
    local procedure OnBeforePostUpdateOrderLineModifyTempLine(PurchHeader: Record "Purchase Header"; var TempPurchaseLine: Record "Purchase Line" temporary)
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        //>>HEI.18
        PurchSetup.GET();
        IF PurchSetup."Archive Orders" THEN BEGIN

            IF ((TempPurchaseLine.Quantity - TempPurchaseLine."Quantity Received") <= TempPurchaseLine."Tolerance Received Under % FND") AND
           (TempPurchaseLine."Tolerance Received Under % FND" <> 0) THEN BEGIN
                TempPurchaseLine."Delivery Finalized FND" := TRUE;
                TempPurchaseLine."Completely Received" := TRUE;
            END;
        END;
        //<<HEI.18

    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterProcessPurchLines, '', false, false)]
    // local procedure OnAfterProcessPurchLines(CommitIsSuppressed: Boolean; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; EverythingInvoiced: Boolean; var PurchHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var ReturnShipmentHeader: Record "Return Shipment Header")
    // var
    //     GLSetup: Record "General Ledger Setup";
    //     PurchLine2: Record "Purchase Line";

    // begin
    //     //HEI.28>>
    //     GLSetup.GET;
    //     IF GLSetup."Enable CAD" THEN BEGIN
    //         PurchLine2.RESET;
    //         PurchLine2.SETRANGE("Document Type", PurchHeader."Document Type");
    //         PurchLine2.SETRANGE("Document No.", PurchHeader."No.");
    //         IF PurchLine2.FINDSET THEN
    //             REPEAT
    //                 IF (PurchLine2."Document Type" IN [PurchLine2."Document Type"::Invoice, PurchLine2."Document Type"::"Credit Memo"]) AND
    //                    (PurchLine2."CAD Amount FND" <> 0) AND
    //                    (((PurchLine2.Type = PurchLine2.Type::Item) AND NOT LastTrckingSpec) OR
    //                    ((PurchLine2.Type = PurchLine2.Type::"Charge (Item)") AND (PurchLine2.Amount <> PurchLine2."VAT Base Amount") AND LastDistributeItemCharge) OR
    //                    ((PurchLine2.Type = PurchLine2.Type::"Charge (Item)") AND (PurchLine2.Amount = PurchLine2."VAT Base Amount")))
    //                 THEN
    //                     PostCADEntry(PurchHeader, PurchLine2);
    //             UNTIL PurchLine2.NEXT = 0;
    //     END;
    //     //HEI.28<<

    // end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnCopyToTempLinesOnAfterSetFilters, '', false, false)]
    local procedure OnCopyToTempLinesOnAfterSetFilters(PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line")
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        PurchaseLine.setfilter("Document No.", '%1', 'DUMMY');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterCopyToTempLines, '', false, false)]
    local procedure OnAfterCopyToTempLines(var PurchaseHeader: Record "Purchase Header"; var TempPurchLine: Record "Purchase Line" temporary)
    var
        PurchSetup: Record "Purchases & Payables Setup";
        PurchLine: Record "Purchase Line";
        PurchPost: Codeunit "Purch.-Post";
    begin
        PurchLine.Reset();
        PurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchaseHeader."No.");

        if PurchLine.FindSet() then
            repeat
                // OnCopyToTempLinesLoop(PurchLine);
                //UpdateChargeItemPurchaseLineGenProdPostingGroup(PurchLine);
                TempPurchLine := PurchLine;
                TempPurchLine.Insert(false);
            until PurchLine.Next() = 0;

        //OnAfterCopyToTempLines(TempPurchLine, PurchHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnAfterPostedWhseRcptHeaderInsert, '', false, false)]
    local procedure OnAfterPostedWhseRcptHeaderInsert(var PostedWhseReceiptHeader: Record "Posted Whse. Receipt Header"; WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        purchRcptheader: Record "Purch. Rcpt. Header";
    begin
        if purchRcptheader.get(WarehouseReceiptHeader."Receiving No.") then begin
            //>>HEI.42
            PurchRcptHeader."Posted Whse. Receipt No. FND" := PostedWhseReceiptHeader."No.";
            PurchRcptHeader.MODIFY();
            //<<HEI.42
        end;
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnDivideAmountOnAfterCalcVATBaseAmount, '', false, false)]
    // local procedure OnDivideAmountOnAfterCalcVATBaseAmount(var PurchaseLine: Record "Purchase Line")
    // var
    //     purchRcptheader: Record "Purch. Rcpt. Header";
    // begin

    //     //HEI.45>>
    //     IF PurchaseLine."H&S Levy Tax Amount" <> 0 THEN
    //         PurchaseLine."VAT Base Amount" :=
    //           ROUND(
    //             PurchaseLine.Amount + PurchaseLine."H&S Levy Tax Amount" * (1 - PurchaseLine."VAT Base Discount %" / 100), Currency."Amount Rounding Precision")//HEI.45
    //     ELSE //HEI.45<<

    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnFinalizePostingOnBeforeUpdateWhseDocuments, '', false, false)]
    local procedure OnFinalizePostingOnBeforeUpdateWhseDocuments(TempWarehouseReceiptHeader: Record "Warehouse Receipt Header" temporary; TempWarehouseShipmentHeader: Record "Warehouse Shipment Header" temporary; var PurchaseHeader: Record "Purchase Header")
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        //>>HEI.18
        CheckLinesCompletelyRcvdHdrUpdate(PurchaseHeader);
        //<<HEI.18
    end;

    LOCAL procedure CheckLinesCompletelyRcvdHdrUpdate(VAR P_PurchHdr: Record "Purchase Header")
    var
        l_PurchLn: Record "Purchase Line";
        i: Integer;
    begin
        //>>HEI.18
        i := 0;
        l_PurchLn.SETRANGE("Document Type", l_PurchLn."Document Type"::Order);
        l_PurchLn.SETRANGE("Document No.", P_PurchHdr."No.");
        IF l_PurchLn.FINDSET() THEN
            REPEAT
                IF (l_PurchLn."Delivery Finalized FND" AND l_PurchLn."Completely Received") THEN
                    i := i + 1;
            UNTIL l_PurchLn.NEXT() = 0;

        IF (i = l_PurchLn.COUNT) THEN BEGIN
            P_PurchHdr.CALCFIELDS("Completely Received");
            P_PurchHdr."Completely Received" := TRUE;
            P_PurchHdr.MODIFY();
        END;
        //<<HEI.18
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnUpdateBlanketOrderLineOnBeforeCheckBlanketOrderPurchLine, '', false, false)]
    local procedure OnUpdateBlanketOrderLineOnBeforeCheckBlanketOrderPurchLine(PurchaseLine: Record "Purchase Line"; var BlanketOrderPurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        IF (BlanketOrderPurchaseLine.Type <> BlanketOrderPurchaseLine.Type::"G/L Account") AND
      (PurchaseLine.Type <> PurchaseLine.Type::"Fixed Asset") AND (BlanketOrderPurchaseLine."SRM Contract No. FND" = '') THEN BEGIN
            BlanketOrderPurchaseLine.TESTFIELD(Type, PurchaseLine.Type);
            BlanketOrderPurchaseLine.TESTFIELD("No.", PurchaseLine."No.");
        END else begin
            //<<HEI.29
            BlanketOrderPurchaseLine.TESTFIELD("Buy-from Vendor No.", PurchaseLine."Buy-from Vendor No.");
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforeCheckPostRestrictions, '', false, false)]
    local procedure OnBeforeCheckPostRestrictions(var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header")
    var
        Vendor: Record Vendor;
        PurchasesUtilsL: Codeunit "Purchases-Utils";
    begin
        Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
        //HEI.51>>
        PurchasesUtilsL.CheckBlockedVendorOnDocuments(Vendor, PurchaseHeader);
        //HEI.51<<
        IF PurchaseHeader."Pay-to Vendor No." <> PurchaseHeader."Buy-from Vendor No." THEN BEGIN
            Vendor.GET(PurchaseHeader."Pay-to Vendor No.");
            //HEI.51>>
            CLEAR(PurchasesUtilsL);
            PurchasesUtilsL.CheckBlockedVendorOnDocuments(Vendor, PurchaseHeader);
            //HEI.51<<
        end;
    end;

    LOCAL procedure PopulateAdditionalDesc(PurchHeader: Record "Purchase Header"; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20])
    var
        lrecPurchInvLn: Record "Purch. Inv. Line";
        lrecILE: Record "Item Ledger Entry";
        lrecValueEntry: Record "Value Entry";
        lrecGLLedger: Record "G/L Entry";
        lrecGLItemRelation: Record "G/L - Item Ledger Relation";
        lrecGLLedgerMod: Record "G/L Entry";
        lrecPurchCrMemoLn: Record "Purch. Cr. Memo Line";
        lrecFALedgerEntry: Record "FA Ledger Entry";
        lrecGLLedgertobeBlank: Record "G/L Entry";
        lrecGLLedgertobeBlankCrMemo: Record "G/L Entry";
        lrecGLLedgerInvVAT: Record "G/L Entry";
        lrecPurchInvLnVAT: Record "Purch. Inv. Line";
        StoreVATLnDescInv: Text[100];
        StoreVATLnDescCrMo: Text[100];
        lrecPurchCrmLnVAT: Record "Purch. Cr. Memo Line";
        lrecGLLedgerCrMeVAT: Record "G/L Entry";
        lrecGLLedgerInvVATFA: Record "G/L Entry";
        lrecGLLedgerCrMeVATFA: Record "G/L Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        //HEI.25>>

        // BC Upgrade MISHRS14 >>
        // Blocked with statement
        //WITH PurchHeader DO BEGIN
        //For Invoice

        IF PurchInvHdrNo <> '' THEN BEGIN
            lrecPurchInvLn.RESET();
            lrecPurchInvLn.SETRANGE(lrecPurchInvLn."Document No.", PurchInvHdrNo);
            IF lrecPurchInvLn.FINDSET() THEN
                REPEAT

                    //Insert data for FA
                    lrecFALedgerEntry.RESET();
                    lrecFALedgerEntry.SETRANGE(lrecFALedgerEntry."Document No.", PurchInvHdrNo);
                    lrecFALedgerEntry.SETRANGE(lrecFALedgerEntry."FA No.", lrecPurchInvLn."No.");
                    lrecFALedgerEntry.SETRANGE(lrecFALedgerEntry.Amount, lrecPurchInvLn."Line Amount");
                    IF lrecFALedgerEntry.FINDSET() THEN
                        REPEAT
                            IF lrecGLLedgerMod.GET(lrecFALedgerEntry."G/L Entry No.") THEN BEGIN
                                lrecGLLedgerMod."Additional Description FND" := lrecPurchInvLn."Additional Description FND";
                                lrecGLLedgerMod.MODIFY();
                            END;
                        UNTIL lrecFALedgerEntry.NEXT() = 0;
                    //Insert data for FA

                    //
                    lrecILE.RESET();
                    lrecILE.SETRANGE(lrecILE."Document No.", PurchInvHdrNo);
                    lrecILE.SETRANGE(lrecILE."Document Line No.", lrecPurchInvLn."Line No.");
                    IF lrecILE.FINDSET() THEN BEGIN
                        REPEAT
                            lrecValueEntry.RESET();
                            lrecValueEntry.SETRANGE(lrecValueEntry."Item Ledger Entry No.", lrecILE."Entry No.");
                            IF lrecValueEntry.FINDFIRST() THEN BEGIN
                                lrecGLItemRelation.RESET();
                                lrecGLItemRelation.SETRANGE(lrecGLItemRelation."Value Entry No.", lrecValueEntry."Entry No.");
                                IF lrecGLItemRelation.FINDSET() THEN
                                    REPEAT
                                        lrecGLLedger.RESET();
                                        lrecGLLedger.SETRANGE(lrecGLLedger."Entry No.", lrecGLItemRelation."G/L Entry No.");
                                        IF lrecGLLedger.FINDFIRST() THEN BEGIN
                                            lrecGLLedgerMod.RESET();
                                            lrecGLLedgerMod.SETRANGE("Transaction No.", lrecGLLedger."Transaction No.");
                                            IF lrecGLLedgerMod.FINDSET() THEN
                                                REPEAT
                                                    lrecGLLedgerMod."Additional Description FND" := lrecPurchInvLn."Additional Description FND";
                                                    lrecGLLedgerMod.MODIFY();
                                                UNTIL lrecGLLedgerMod.NEXT() = 0;
                                        END;
                                    UNTIL lrecGLItemRelation.NEXT() = 0;
                            END;
                        UNTIL lrecILE.NEXT() = 0;
                        //
                    END ELSE BEGIN
                        lrecValueEntry.RESET();
                        lrecValueEntry.SETRANGE(lrecValueEntry."Document No.", lrecPurchInvLn."Document No.");
                        lrecValueEntry.SETRANGE(lrecValueEntry."Document Line No.", lrecPurchInvLn."Line No.");
                        IF lrecValueEntry.FINDSET() THEN
                            REPEAT
                                lrecGLItemRelation.RESET();
                                lrecGLItemRelation.SETRANGE(lrecGLItemRelation."Value Entry No.", lrecValueEntry."Entry No.");
                                IF lrecGLItemRelation.FINDSET() THEN
                                    REPEAT
                                        lrecGLLedger.RESET();
                                        lrecGLLedger.SETRANGE(lrecGLLedger."Entry No.", lrecGLItemRelation."G/L Entry No.");
                                        IF lrecGLLedger.FINDFIRST() THEN BEGIN
                                            lrecGLLedgerMod.RESET();
                                            lrecGLLedgerMod.SETRANGE("Transaction No.", lrecGLLedger."Transaction No.");
                                            IF lrecGLLedgerMod.FINDSET() THEN
                                                REPEAT
                                                    lrecGLLedgerMod."Additional Description FND" := lrecPurchInvLn."Additional Description FND";
                                                    lrecGLLedgerMod.MODIFY();
                                                UNTIL lrecGLLedgerMod.NEXT() = 0;
                                        END;
                                    UNTIL lrecGLItemRelation.NEXT() = 0;
                            UNTIL lrecValueEntry.NEXT() = 0;
                    END;
                UNTIL lrecPurchInvLn.NEXT() = 0;
            //For Invoice
            //For Cr Memo
        END ELSE BEGIN
            IF PurchCrMemoHdrNo <> '' THEN BEGIN
                lrecPurchCrMemoLn.RESET();
                lrecPurchCrMemoLn.SETRANGE(lrecPurchCrMemoLn."Document No.", PurchCrMemoHdrNo);
                IF lrecPurchCrMemoLn.FINDSET() THEN
                    REPEAT
                        //Insert data for FA
                        lrecFALedgerEntry.RESET();
                        lrecFALedgerEntry.SETRANGE(lrecFALedgerEntry."Document No.", PurchCrMemoHdrNo);
                        lrecFALedgerEntry.SETRANGE(lrecFALedgerEntry."FA No.", lrecPurchCrMemoLn."No.");
                        lrecFALedgerEntry.SETRANGE(lrecFALedgerEntry.Amount, (-lrecPurchCrMemoLn."Line Amount"));
                        IF lrecFALedgerEntry.FINDSET() THEN
                            REPEAT
                                IF lrecGLLedgerMod.GET(lrecFALedgerEntry."G/L Entry No.") THEN BEGIN
                                    lrecGLLedgerMod."Additional Description FND" := lrecPurchCrMemoLn."Additional Description FND";
                                    lrecGLLedgerMod.MODIFY();
                                END;
                            UNTIL lrecFALedgerEntry.NEXT() = 0;
                        //Insert data for FA

                        //
                        lrecILE.RESET();
                        lrecILE.SETRANGE(lrecILE."Document No.", PurchCrMemoHdrNo);
                        lrecILE.SETRANGE(lrecILE."Document Line No.", lrecPurchCrMemoLn."Line No.");
                        IF lrecILE.FINDSET() THEN BEGIN
                            REPEAT
                                lrecValueEntry.RESET();
                                lrecValueEntry.SETRANGE(lrecValueEntry."Item Ledger Entry No.", lrecILE."Entry No.");
                                IF lrecValueEntry.FINDFIRST() THEN BEGIN
                                    lrecGLItemRelation.RESET();
                                    lrecGLItemRelation.SETRANGE(lrecGLItemRelation."Value Entry No.", lrecValueEntry."Entry No.");
                                    IF lrecGLItemRelation.FINDSET() THEN
                                        REPEAT
                                            lrecGLLedger.RESET();
                                            lrecGLLedger.SETRANGE(lrecGLLedger."Entry No.", lrecGLItemRelation."G/L Entry No.");
                                            IF lrecGLLedger.FINDFIRST() THEN BEGIN
                                                lrecGLLedgerMod.RESET();
                                                lrecGLLedgerMod.SETRANGE("Transaction No.", lrecGLLedger."Transaction No.");
                                                IF lrecGLLedgerMod.FINDSET() THEN
                                                    REPEAT
                                                        lrecGLLedgerMod."Additional Description FND" := lrecPurchCrMemoLn."Additional Description FND";
                                                        lrecGLLedgerMod.MODIFY();
                                                    UNTIL lrecGLLedgerMod.NEXT() = 0;
                                            END;
                                        UNTIL lrecGLItemRelation.NEXT() = 0;
                                END;
                            UNTIL lrecILE.NEXT() = 0;
                            //
                        END ELSE BEGIN
                            lrecValueEntry.RESET();
                            lrecValueEntry.SETRANGE(lrecValueEntry."Document No.", PurchCrMemoHdrNo);
                            lrecValueEntry.SETRANGE(lrecValueEntry."Document Line No.", lrecPurchCrMemoLn."Line No.");
                            IF lrecValueEntry.FINDSET() THEN
                                REPEAT
                                    lrecGLItemRelation.RESET();
                                    lrecGLItemRelation.SETRANGE(lrecGLItemRelation."Value Entry No.", lrecValueEntry."Entry No.");
                                    IF lrecGLItemRelation.FINDSET() THEN
                                        REPEAT
                                            lrecGLLedger.RESET();
                                            lrecGLLedger.SETRANGE(lrecGLLedger."Entry No.", lrecGLItemRelation."G/L Entry No.");
                                            IF lrecGLLedger.FINDFIRST() THEN BEGIN
                                                lrecGLLedgerMod.RESET();
                                                lrecGLLedgerMod.SETRANGE("Transaction No.", lrecGLLedger."Transaction No.");
                                                IF lrecGLLedgerMod.FINDSET() THEN
                                                    REPEAT
                                                        lrecGLLedgerMod."Additional Description FND" := lrecPurchCrMemoLn."Additional Description FND";
                                                        lrecGLLedgerMod.MODIFY();
                                                    UNTIL lrecGLLedgerMod.NEXT() = 0;
                                            END;
                                        UNTIL lrecGLItemRelation.NEXT() = 0;
                                UNTIL lrecValueEntry.NEXT() = 0;
                        END;
                    UNTIL lrecPurchCrMemoLn.NEXT() = 0;
            END;
        END;
        //For Cr Memo
        //END;
        // BC upgrade MISHRS14 <<

        lrecGLLedgertobeBlank.RESET();
        lrecGLLedgertobeBlank.SETRANGE(lrecGLLedgertobeBlank."Document No.", lrecPurchInvLn."Document No.");
        lrecGLLedgertobeBlank.SETFILTER("Document Type", '%1', lrecGLLedgertobeBlank."Document Type"::Invoice);
        lrecGLLedgertobeBlank.SETFILTER("FA Entry No.", '%1', 0);
        lrecGLLedgertobeBlank.SETFILTER("VAT Prod. Posting Group", '%1', '');//NEW
        IF lrecGLLedgertobeBlank.FINDSET() THEN
            REPEAT
                IF (lrecGLLedgertobeBlank."Additional Description FND" <> '') THEN BEGIN
                    lrecGLLedgertobeBlank."Additional Description FND" := '';
                    lrecGLLedgertobeBlank.MODIFY();
                END;
            UNTIL lrecGLLedgertobeBlank.NEXT() = 0;

        //INVOICE - Populate desc in VAT lines, requirement came later so not changing anything which is tested fine above
        StoreVATLnDescInv := '';
        lrecPurchInvLnVAT.RESET();
        lrecPurchInvLnVAT.SETRANGE(lrecPurchInvLnVAT."Document No.", lrecPurchInvLn."Document No.");
        lrecPurchInvLnVAT.SETFILTER(Type, '<>%1', lrecPurchInvLnVAT.Type::" ");
        IF lrecPurchInvLnVAT.FINDFIRST() THEN
            StoreVATLnDescInv := lrecPurchInvLnVAT."Additional Description FND";

        lrecGLLedgerInvVAT.RESET();
        lrecGLLedgerInvVAT.SETRANGE(lrecGLLedgerInvVAT."Document No.", lrecPurchInvLn."Document No.");
        lrecGLLedgerInvVAT.SETFILTER("Document Type", '%1', lrecGLLedgerInvVAT."Document Type"::Invoice);
        lrecGLLedgerInvVAT.SETFILTER("Source Type", '<>%1', lrecGLLedgerInvVAT."Source Type"::"Fixed Asset");
        lrecGLLedgerInvVAT.SETFILTER("VAT Prod. Posting Group", '%1', '');
        IF lrecGLLedgerInvVAT.FINDSET() THEN
            REPEAT
                lrecGLLedgerInvVAT."Additional Description FND" := StoreVATLnDescInv;
                lrecGLLedgerInvVAT.MODIFY();
            UNTIL lrecGLLedgerInvVAT.NEXT() = 0;


        // {
        // lrecGLLedgerInvVAT.RESET;
        //         lrecGLLedgerInvVAT.SETRANGE(lrecGLLedgerInvVAT."Document No.", lrecPurchInvLn."Document No.");
        //         lrecGLLedgerInvVAT.SETFILTER("Document Type", '%1', lrecGLLedgerInvVAT."Document Type"::Invoice);
        //         lrecGLLedgerInvVAT.SETFILTER("Source Type", '<>%1', lrecGLLedgerInvVAT."Source Type"::"Fixed Asset");
        //         lrecGLLedgerInvVAT.SETFILTER("VAT Prod. Posting Group", '<>%1', '');
        //         IF lrecGLLedgerInvVAT.FINDSET THEN
        //             REPEAT
        //                 lrecPurchInvLn.RESET;
        //                 lrecPurchInvLn.SETRANGE(lrecPurchInvLn."Document No.", lrecGLLedgerInvVAT."Document No.");
        //                 lrecPurchInvLn.SETRANGE(lrecPurchInvLn."No.", lrecGLLedgerInvVAT."G/L Account No.");
        //                 IF lrecGLLedgerInvVAT.FINDFIRST THEN BEGIN
        //                     lrecGLLedgerInvVAT."Additional Description FND" := lrecPurchInvLn."Additional Description FND";
        //                     lrecGLLedgerInvVAT.MODIFY;
        //                 END;
        //             UNTIL lrecGLLedgerInvVAT.NEXT = 0;
        // }

        lrecGLLedgerInvVATFA.RESET();
        lrecGLLedgerInvVATFA.SETRANGE("Document No.", lrecPurchInvLn."Document No.");
        lrecGLLedgerInvVATFA.SETFILTER("Document Type", '%1', lrecGLLedgerInvVATFA."Document Type"::Invoice);
        lrecGLLedgerInvVATFA.SETFILTER("Source Type", '%1', lrecGLLedgerInvVATFA."Source Type"::"Fixed Asset");
        lrecGLLedgerInvVATFA.SETFILTER("Additional Description FND", '%1', '');
        IF lrecGLLedgerInvVATFA.FINDSET() THEN
            REPEAT
                lrecGLLedgerInvVATFA."Additional Description FND" := StoreVATLnDescInv;
                lrecGLLedgerInvVATFA.MODIFY();
            UNTIL lrecGLLedgerInvVATFA.NEXT() = 0;
        //<<INVOICE - Populate desc in VAT lines, requirement came later so not changing anything which is tested fine above

        lrecGLLedgertobeBlankCrMemo.RESET();
        lrecGLLedgertobeBlankCrMemo.SETRANGE(lrecGLLedgertobeBlankCrMemo."Document No.", lrecPurchCrMemoLn."Document No.");
        lrecGLLedgertobeBlankCrMemo.SETFILTER("Document Type", '%1', lrecGLLedgertobeBlankCrMemo."Document Type"::"Credit Memo");
        lrecGLLedgertobeBlankCrMemo.SETFILTER("FA Entry No.", '%1', 0);
        IF lrecGLLedgertobeBlankCrMemo.FINDSET() THEN
            REPEAT
                IF (lrecGLLedgertobeBlankCrMemo."Additional Description FND" <> '') THEN BEGIN
                    lrecGLLedgertobeBlankCrMemo."Additional Description FND" := '';
                    lrecGLLedgertobeBlankCrMemo.MODIFY();
                END;
            UNTIL lrecGLLedgertobeBlankCrMemo.NEXT() = 0;

        //>>CR MEMO - Populate desc in VAT lines, requirement came later so not changing anything which is tested fine above
        StoreVATLnDescCrMo := '';
        lrecPurchCrmLnVAT.RESET();
        lrecPurchCrmLnVAT.SETRANGE(lrecPurchCrmLnVAT."Document No.", lrecPurchCrMemoLn."Document No.");
        lrecPurchCrmLnVAT.SETFILTER(Type, '<>%1', lrecPurchCrmLnVAT.Type::" ");
        IF lrecPurchCrmLnVAT.FINDFIRST() THEN
            StoreVATLnDescCrMo := lrecPurchCrmLnVAT."Additional Description FND";

        lrecGLLedgerCrMeVAT.RESET();
        lrecGLLedgerCrMeVAT.SETRANGE(lrecGLLedgerCrMeVAT."Document No.", lrecPurchCrMemoLn."Document No.");
        lrecGLLedgerCrMeVAT.SETFILTER("Document Type", '%1', lrecGLLedgerCrMeVAT."Document Type"::"Credit Memo");
        lrecGLLedgerCrMeVAT.SETFILTER("Source Type", '<>%1', lrecGLLedgerCrMeVAT."Source Type"::"Fixed Asset");
        //lrecGLLedgerCrMeVAT.SETFILTER("VAT Prod. Posting Group",'<>%1','');
        IF lrecGLLedgerCrMeVAT.FINDSET() THEN
            REPEAT
                lrecGLLedgerCrMeVAT."Additional Description FND" := StoreVATLnDescCrMo;
                lrecGLLedgerCrMeVAT.MODIFY();
            UNTIL lrecGLLedgerCrMeVAT.NEXT() = 0;

        lrecGLLedgerCrMeVATFA.RESET();
        lrecGLLedgerCrMeVATFA.SETRANGE("Document No.", lrecPurchCrMemoLn."Document No.");
        lrecGLLedgerCrMeVATFA.SETFILTER("Document Type", '%1', lrecGLLedgerCrMeVATFA."Document Type"::"Credit Memo");
        //lrecGLLedgerCrMeVATFA.SETFILTER("Source Type",'%1',lrecGLLedgerCrMeVATFA."Source Type"::"Fixed Asset");
        lrecGLLedgerCrMeVATFA.SETFILTER("Additional Description FND", '%1', '');
        IF lrecGLLedgerCrMeVATFA.FINDSET() THEN
            REPEAT
                lrecGLLedgerCrMeVATFA."Additional Description FND" := StoreVATLnDescCrMo;
                lrecGLLedgerCrMeVATFA.MODIFY();
            UNTIL lrecGLLedgerCrMeVATFA.NEXT() = 0;
        //<<CR MEMO - Populate desc in VAT lines, requirement came later so not changing anything which is tested fine above
        //HEI.25<<
    end;

    //BC UPGRADE SHARMP16 END>>>>>
    var
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        // SrcCode: code[10];
        // TotalFAPurchLine: Record "Purchase Line";
        // TotalPurchLine: Record "Purchase Line";
        // TotalPurchLineLCY: record "Purchase Line";
        // GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        // FASetup: Record "FA Setup";
        TotalWHTAmount: Decimal;
        // BC Upgrade PATELS08 >> # Changed the GenJnlLineDocType to Enum "Gen. Journal Document Type" from Integer to avoid implicit conversion.
        // GenJnlLineDocType: Integer;
        GenJnlLineDocType: Enum "Gen. Journal Document Type";
        // BC Upgrade PATELS08 <<
        GenJnlLineDocNo: Code[20];
        GenJnlLineType: Record "Gen. Journal Line";
        GenJnlLineExtDocNo: Code[20];
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        //-----PostFA Variables

        TotalPurchLine: Record "Purchase Line";
        TotalPurchLineLCY: Record "Purchase Line";
        FASetup: Record "FA Setup";
        GLSetup: Record "General Ledger Setup";
        rTempGLItemLedgRelation: Record "G/L - Item Ledger Relation";
        TempJobJournalLine: Record "Job Journal Line";
        TempGLEntryBuf: Record "G/L Entry";
        PurchSetup: Record "Purchases & Payables Setup";
        VendLedgEntry: Record "Vendor Ledger Entry";
        InvoicePostingInterface: Interface "Invoice Posting";
        PurchaseInvHeader: Record "Purch. Inv. Header";
        PurchaseCrmHeader: Record "Purch. Cr. Memo Hdr.";
        TempPurchaseLineJob: Record "Purchase Line" temporary;
        InvoicePostBufferGolbal: Record "Invoice Posting Buffer" temporary;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        JobPostLine: Codeunit "Job Post-Line";
        JobJnlPostLine: Codeunit "Job Jnl.-Post Line";
        PurchPost: Codeunit "Purch.-Post";
        Window: Dialog;
        SrcCode: Code[20];
        //  SingleInsCU: Codeunit SingleIns;
        // GenJnlLineDocNo: Code[20];
        // GenJnlLineExtDocNo: Code[35];
        LineCount: Decimal;
        //  GenJnlLineDocType: Integer;
        PostFaLedgerEntry: Boolean;
        //  PurchaseRecNo: Code[20];
        InvoicePostingParameters: Record "Invoice Posting Parameters";
        RecPurchRcptHeader: Record "Purch. Rcpt. Header";

        TotalFAPurchLine: Record "Purchase Line";
        FALineNo: Integer;
        CurrExchRate: Record "Currency Exchange Rate";
        PostFaLedgerEntryOnReturn: Boolean;

        ibmtemppostingglobal: Record "Inv Posting Bffr HeiliteFA FND";
        TotalFAPurchLineAmount: Decimal;
    //-----PostFA Variables
    //--------------------------------------------BC UPgrade SHARMP16 CU 90 Purch.Post END<<----------------------------------------
    //------------------------------------------------------------------------------------------------------------------//

}