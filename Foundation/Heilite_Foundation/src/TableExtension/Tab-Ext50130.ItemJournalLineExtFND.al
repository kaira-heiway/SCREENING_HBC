tableextension 50130 ItemJournalLineExtFND extends "Item Journal Line"
{
    // version NAVW111.00.00.21836,FINXL10.00,MANXL10.01,QXL11.01,DITW111.00.13,HEI.47
    // DITW15.00.00.01 DDR 21/12/2007 Added fields
    //                                  2034642 Is Item Charge
    //                                  2034643 ItemCharge Incl. Price
    //                                  2034647 Drink Tax Group Code
    //                                  2034675 Item Charge Type
    // DITW15.00.00.01 DDR 02/01/2008 Rename field
    //                                  2034647 Drink Tax Group Code -> Item DTax Group Code + Filter to the source table
    // DITW15.00.00.01 DDR 07/01/2008 Added field
    //                                  2013610 Item DDeposit Group Code
    //                                  2013611 Empty Goods Item No.
    //                                  2013612 Item Charge Quantity per
    // DITW15.00.00.01 DDR 10/01/2008 Added fields
    //                                 2034688 Due Tax
    // DITW15.00.00.01 DDR 22/01/2008 Added Drink-It Discount & Promotions Item Charges functionnalities
    //                                Change optionstring field "Item Charge Type"
    //                                Added fields
    //                                  2014410 Collapse
    //                                  2013773 Customer DDisc. Group Code
    //                                  2013774 Item DDisc. Group Code
    //                                  2013775 Customer DPromo. Group Code
    //                                  2013776 Item DPromo. Group Code
    //                                  2013767 Unit Volume HL
    // DITW15.00.00.01 DDR 20/02/2008 added field
    //                                  2013785 Periodic Disc.-Promo Entry No.
    // DITW15.00.00.01 DDR 13/03/2008 Rename Caption field "Unit Volume HL"
    // DITW15.00.00.01 DDR 19/03/2008 added field
    //                                  2034691 Initial Entry Due Date
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //                                Added captions on fields "Is Item Charge","Item Charge Incl. Price"
    // DITW15.00.00.20 DDR 11/06/2008 Certification rules
    // DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    // DITW15.00.00.23 DDR 28/07/2008 Change Caption & CaptionClass properties
    //                                  field "Unit Volume HL"
    //                                Added function GetUomCaptionClass()
    // DITW15.00.00.24 DDR 25/09/2008 Added fields
    //                                  2013660 Extra Charge Type
    //                                  2013661 Item Charge Value
    //                                  2013778 Opposite Qty. Sign
    //                                  2013779 Using Qty. (Base)
    //                                  2014410 Collapse
    //                                  2014440 Attached to Line No.
    //                                Added key
    //                                  "Journal Template Name,Journal Batch Name,Document No.,Attached to Line No.,
    //                                    Is Item Charge,Item Charge Incl. Price,Extra Charge Type"
    //                                Added new parameter into function CreateDim()
    //                                Added functions
    //                                  RoundThousandLineNo()
    //                                  InsertChargeLines()
    //                                  FormEditableField()
    //                                  FormTotalingField()
    //                                  DeleteAllChargeJnlLines()
    //                                  UpdateCharges()
    //                                  InsertCharges()
    //                                  InsertCharges4()
    //                                  CheckNoItemChargeInclPrice()
    //                                  ExistItemChargeInclPrice()
    //                                  ValidateCreateDimNo()
    //                     03/10/2008 Added functions
    //                                  SetPhysInvtEntered()
    //                                  GetTempInsertChargesTo()
    //                                  GetDimBufToJnlLineDim()
    //                     07/10/2008 Added fields
    //                                  2013722 Duty Tax Type
    // DITW15.00.00.25 DDR 10/10/2008 Added optionstring 'ShippingCost' for field "Item Charge Type"
    //                     21/10/2008 Deleted fields
    //                                  2013722 Duty Tax Type
    //                     24/10/2008 Renamed OptionStringML (VolumeHL -> Volume /Unit) for field "Extra Charge Type"
    //                                Update Charge lines when changing field "Document No.","Document Date"
    //                     27/10/2008 Added fields
    //                                  2013694 Opposite Amount Sign
    //                     30/10/2008 Bugfix refresh charge lines when modify the location code
    // DITW15.00.00.29 DDR 19/12/2008 Bugfix remove internal tax when changing the new location code
    // DITW15.00.00.30 DDR 09/01/2009 Added checking for location combination is valid.
    //                                Added "Location code" copied from Item
    //                     19/01/2009 Added fields
    //                                  2013623 Source Deposit Group Code
    //                                  2013751 Source DTax Group Code
    // DITW15.00.00.25.01-PRODW14.00.00.08.05A DLE 21/01/2009 License problem
    // DITW15.00.00.31 DDR 19/02/2009 Added fields
    //                                  2014444 Last Price Calculated Date
    // DITW15.00.00.32 DDR 07/04/2009 Added function GetAutoformatRoundingType() to use into property 'AutoformatRoundingType'
    //                                Updated function ReadGLSetup()
    // DITW15.00.00.33 DDR 08/05/2009 Added fields
    //                                  20113722 Duty Suspended
    //                     15/05/2009 Bugfix "unit volume HL" when change Base unit of measure code
    // DITW15.00.00.34 PRODW14.00.00.13 DDR 11/06/2009
    //                                Added function AssignOpenItemTrackingLines()
    // DITW15.00.00.34 DDR 12/06/2009 Added option 'Price Item' optionstring for "Extra Charge Type" field
    //                                Skip function RetrieveCosts() with internal item charges
    //                                Bugfix while calculate unit amount & unit cost with internal item charges
    //                                Bugfix "unit cost","Amount" not editable when "Extra Charge Type" (Price% or Line%)
    //                     03/07/2009 Added fields
    //                                  2013715 Tax Formunla
    //                                  2013729 Tariff No.
    // DITW15.00.00.35 DDR 26/06/2009 Added fields
    //                                  2013824 Gen. Prod. Posting Free Group
    //                                  2013825 Free Item Posting Type
    //                                  2013826 Free Item
    //                    27/07/2009 Added fields
    //                                  2013827 Free Calculation Type
    //                                  2013828 Include Free Qty. in Minimum
    //                     13/10/2009 issue 722 Updated Filters - TableRelation property field "Empty Goods Item No. Filter"
    //                     26/10/2009 issue 924 Rename captions + optioncaptions
    //                                  "Free Item Posting Type" -> "Calculate Price on Free"
    //                                    ' ,Price,Amount' -> 'Full Amount,Price 0,Discount 100%'
    //                                  "Free Calculation Type" -> Calculate on Free
    //                                    'None,Discount 100%,All' -> 'None,Discount 100%,Full Amount'
    //                    18/09/2009 Added Purchase services - optionstring for field "Document Type"
    //                                  'Service Receipt,Service P.Invoice,Service P.Credit Memo'
    // DITW15.00.00.36 DDR 30/11/2009 issue 939 SQL Performance
    //                                Modified key for collapse
    //                                  [Journal Template Name,Journal Batch Name,Document No.,Attached to Line No.,Collapse,
    //                                   Is Item Charge,Item Charge Incl. Price,Extra Charge Type]
    // DITW15.00.00.37 DDR 19/01/2010 issue 1038 Allowed the item journal within 'output'/'consumption' entry types
    //                     20/01/2010 issue 1020 Added fields
    //                                  2013696 Location Group Code
    //                                  2013726 Company Tax Registration No.
    //                                  2014094 Physical Location Group Code
    //                     29/01/2010 issue 1054 Added fields
    //                                  2013727 AAD No. Series
    //                                  2013728 ADD No.
    //                                Added functions
    //                                  UpdateAADInfo(),GetAADNoSeries(),GetCompanyInfoSetup(),AssignNewAADNo()
    //                     01/02/2010 issue 1055 Bugfix the old item dimensions are not removed while change item no.
    //                     19/02/2010 issue 1054 Modified Field "AAD No. Series" empty by default
    //                     26/04/2010 issue 1070 Bugfix don't insert the item default location when already existing
    //                                            (batch mode has filled the field to create new journal line)
    //                     04/05/2010 issue 1070 Bugfix don't insert the item default location when (re)validate field "item no."
    //                     05/05/2010 issue 1136 Added functions
    //                                             InsertChargesTemp4(),SetJnlLineDimToDimBuf(),MoveJnlLineDimToBuf(),GetTempJnlLineDim()
    //                     20/05/2010 issue 1081 Added fields
    //                                             2014110 New Location Group Code
    //                                             2014111 New Phys. Location Group Code
    //                                           Modified Tablerelation for fields Location & New Location codes and use filter from
    //                                             Phys. location group code
    //                     21/06/2010 issue 1150 Caption for field2014110, field2014111
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 22/06/2010 issue 1151 Added to remove Quarantine Quality test when delete purchase line
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                             Add     functions GetAutoFormatExpr(),GetTotalingAutoFormatExpr()
    //                                             Remove  functions FormTotalingField()
    //                     10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                           Added fields
    //                                             2014260 LRN Nos Series
    //                                             2014261 LRN No.
    //                                             2014262 ARC No.
    //                                             2014263 SAD No.
    //                                             2014267 ARC No. Mandatory
    //                                             2014265 Product Tax Code
    //                                             2014476 Packaging Type Code
    //                                             2014271 Tax Warehouse Reference
    //                                           AAD Checking Rule Modified (combination Cust/Item Tax Groups/Location Groups)
    //                                           Rewrite/review functions
    //                                             UpdateAADInfo()
    //                                           Added functions
    //                                             TestAADNoSeriesMandatory(),TestDutySuspendMandatory(),TestTaxRegMandatory(),
    //                                             GetLocationGroup(),ExistLineChargeType(),GetDrinkTaxGroups(),ExistLineDutySuspended()
    //                     17/09/2010            Bugfix replace "No." -> "Item No." to get data of Item Unit of measure
    //                     28/09/2010            Disabled test AAD/ARC are mandatory
    //                     04/10/2010            Disabled to fill AAD/ARC No. Series
    //                                           Modified Text constant Text2013663
    //                     25/10/2010 issue 1139 SSCC Functionnalities
    //                                           Added fields
    //                                             2035040 SSCC No.
    //                                             2035042 New SSCC No.
    //                                           Added function OpenSSCCTrackingLines()
    //                     29/10/2010            Added parameter FormRunModeSSCC into function OpenSSCCTrackingLines()
    //                     14/12/2010 issue 1097 Modified function TestAADNoSeriesMandatory(),TestDutySuspendMandatory()
    //                     14/12/2010 issue 1158 Bugfix conflict between when input AAD no. series, block because AAD no. is required
    //                     17/12/2010 issue 703 Added fields
    //                                            2014113 Tax Item No.
    //                                          Added functions GetTrackingItemNo()
    //                                          Bugfix functions Test...NoSeriesMandatory() remove test when Location Group Code is blank
    //                     22/12/2010 issue 1217 (DIT711 103) Added new option AAD/ARC mandatory type to skip
    //                                                          when From/To location Tax Registration/Tax Whse Reference are identical
    //                                                        Added functions IsLocationGrMandatoryAAD(),IsLocationGrMandatoryARC()
    //                                                        Bugfix to keep the existing item charge description while update charge lines
    //                     01/02/2011 issue 941 Modified OptionCaption property field2013825 "Free Item Posting Type"
    // DITW15.00.00.38 PRODW14.00.00.17 DDR 08/02/2011 issue 1271
    //                                          Modified 'CalcFormula' property field2035090 No. of Quality Tests
    //                     16/02/2011 issue 1217 (DIT711 148) Added fields
    //                                            2014482 Pack Qty. Per Unit of Measure"
    //                     11/03/2011 issue 458 Replaced caption field2013696 'Location Group' -> 'Location Tax Group'
    //                                                           field2014110 'New Location Group'
    //                                                           field2014094 (dutch)
    //                                                           field2013751 (dutch)
    //                     16/03/2011 issue 1217 (DIT711 161) Added validate field "Packaging Type Code"
    //                     23/03/2011 issue 1297 Bugfix function UpdateAADInfo() to clear the location record
    // DITW15.00.00.39 DDR 21/06/2011 issue 1370 Bugfix TableRelation property field2013751 "Source DTax Group Code"
    //                     05/08/2011 issue 1230 Added fields
    //                                             2014508 Ship-to/Order Address code
    // DITW15.00.00.39 PRODW14.00.00.08.18 DDR 18/08/2011 issue 1410
    //                                           Show all Quality tests, Removed source item ledger entry in flowfield
    //                                           Modified 'CalcFormula' property field2035090 No. of Quality Tests
    //                     19/08/2011 issue 1363
    //                                  Added fields
    //                                    2013733 Tax Date
    //                     26/08/2011 issue 1393 Added function AssistEditItemTreeview()
    //                     15/09/2011 issue 1365 Modified function ItemAvailability()
    //                     19/10/2011 ossie 1363 Added to update item charges on field "Tax Date"
    //                     28/10/2011 issue 1457 Modified many ML captions
    // DITW16.00.00.40 DDR 15/11/2011 issue 1462 Bugfix several test on production fields for Internal item charges
    //                     05/01/2012 DIT-715 #172 Added fields
    //                                    2013803 Allow VAT Calculation (Free)
    //                     03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
    //                                      Added function FEFOTracking()
    //                                      Added functions CreateFEFOTracking(),CreateFEFOTrackingJournal()
    //                                      Rewrite function CreateFEFOTrackingJournal()
    //                                      Added error message on "Entry Type" field for FEFOTracking()
    //                     21/03/2012 #1331 Bugfix function CreateFEFOTrackingJournal()
    //                     03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                             Modified function AssistEditItemTreeview()
    //                                             Added text constants Text2014412
    //                     13/06/2012 DIT-715 #338 Added functions AllItemsAvailability()
    // DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457 Added fields
    //                                               2034983 Work Order No.
    //                                               2034986 Work Order Line No.
    // DITW16.00.00.43 DDR 27/08/2013 DIT-715 #699 Added to skip the item default location code with "Directed Put-away and Pick"
    //                 DDR 10/10/2013 DIT-715 #745 Extended SSCC non-Specific
    //                 DDR 21/10/2013 DIT-715 #768 Added link to Charge Bom Sales lines (#519)
    //                                             Added get dimensions from "Tax Item No."
    //                                             Added Type3 parameter function CreateDim()
    //                                             Added functions InsertCharges2()
    //                 DDR 23/10/2013 DIT-715 #768 Bugfix to skip Tax fields with "Tax Item No." for Deposit charges
    //                 DDR 03/12/2013 DIT-715 #861 Bugfix missing production fields while validating "Tax Item No."
    //                 DDR 18/12/2013 DIT-715 #766 Bugfix missing "Physical location group code" while create tax item line
    //                 DDR 20/12/2013 DIT-715 #864 Bugfix "Tax item no." for output journals

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars
    // FINXL8.00.001 BSA 02/06/2015 #178: Added new functionalities for "Cross-Reference No."

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 24/05/2013 DIT-770 #99 Added item charges including "Reason Code","Return Reason Code"
    //                  04/06/2013 DIT-770 #99 Added fields
    //                                           2014560 Ship-to Country/Region Code
    //                  04/07/2013 DIT-770 #99 Renamed field201460 "Ship-to Country/Region Code" -> "GWC Country/Region Code"
    //                  24/07/2013 DIT-770 #101 Added fields
    //                                           2013668 Cust/Vendor DTax Group Code
    //                  19/08/2013 DIT-770 #101 Remove double field2013668 Cust/Vendor DTax Group Code
    // DITW17.00.02 DDR 21/08/2013 DIT-770 #112 Added 'CalledByFieldNo' parameter to function ValidateCreateDimNo()
    //                  27/08/2013 DIT-715 #699 merge
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #99 (keep to update item charges)
    //                                          Remove DIT-770 #101
    //              DDR 02/09/2013 DIT-770 #112 Added to update item charges from Item journal line Dimensions
    // DITW17.00.02 SR 10/09/2013 DIT-770 #143 : Copy Gen. Bus. Posting Group from template (if filled in)
    // DITW17.00.02 AT  24/09/2013 DIT-770 #132
    //                             Added Field 2013829 Free Reason Code
    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.00.02 DDR 22/10/2013 DIT-715 #768 Merge
    // DITW17.00.02 DDR 13/11/2013 DIT-770 #230 Added fields
    //                                            2013783 DDiscount Level Position
    //                                            2013788 DDiscount Include Tax
    //                                            2013789 DDiscount Include Deposit
    //                                            2013790 DDiscount Include Discount
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 DDR 03/12/2013 DIT-715 #861 merge
    // DITW17.00.02 DDR 18/12/2013 DIT-715 #766 merge
    // DITW17.00.02 DDR 20/12/2013 DIT-715 #864 merge
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 MSF 16/02/2015 DIT-770 #1185 Get "Indirect Cost %" From SKU card
    // DITW18.00.06 AKH 17/02/2015 DIT-770 #1197 Multisite - Site dimension in item transactions : Added field 2014411 "Responsibility Center"
    //                                                                                             Added code to register the site dimension when selecting a location
    // DITW18.00.06 AKH 20/02/2015 DIT-770 #1197 Multisite - Site dimension in item transactions : Extended function CreateDim()
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1189 Multisite - Added relation "Responsiblity Center","Location","Phys. Location"
    //                                                       Added functions InitRespCenterCode(),InitRespLocationCode()
    //                                                                       GetRespCenterCode(),EntryTypeToRespID()
    //                                                       Removed Phys. Location on 'TableRelation' property field9 Location Code
    //                                                       Added default item location code check with Responsibitity Center
    //                                                       Added functions UpdateCharges()
    //                                                       Modified 'TableRelation' property fields "New Location Code","New Phys. Location Group Code"

    // DITW18.00.06 DDR 04/03/2015 DIT-770 #1189 Multisite - Bugfix to skip revalidation Resp.Center with Entry Type
    // DITW17.10.05 DDR 19/08/2014 DIT-770 #776 Added Deposit point functionality
    //                                          Added fields
    //                                            2014411 Item Shpt/Rcpt Line No.
    // DITW17.10.05 MSF 20/11/2014 DIT-770 #701 Added Function TestTaxDueMandatory
    //                                                         ExistLineTaxDue
    // DITW17.10.05 MSF 08/12/2014 DIT-770 #701 Bug Fix
    // DITW17.10.05 MSF 11/12/2014 DIT-770 #701 Adujust Function ExistLineTaxDue
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW17.10.05 MSF 09/01/2015 DIT-770 #701
    // DITW18.00.06 DDR 01/10/2015 DIT-770 #1618  Phys. Inv. journal removs location code for neg. adjustments
    // DITW18.00.06 DDR 20/10/2015 DIT-770 #1449 Added fields
    //                                             2014460 Production BOM No.
    //                                             2014461 Prod. BOM Version Code
    //                                             2014462 BOM Line No.
    //                                             2014463 BOM Item No.
    //                                             2014464 BOM Qty. per Unit of Measure
    // DITW18.00.06 DDR 23/10/2015 DIT-770 #1395 Modified function GetTrackingItemNo
    // DITW18.00.06 DDR 26/10/2015 DIT-770 #1412 Bugfix clear value relating item with normal item charges
    //                                           Added field 2014477 "No. of Packages"
    // DITW18.00.06 DDR 04/11/2015 DIT-770 #1395 Added Giftbox lines avoid delete record
    //                                           Added Giftbox field
    //                                             2013768 Trsf-to Unit Volume HL
    // DITW19.00.07 MVN 30/12/2015 DIT-770 #001 Upgrade
    // DITW18.00.07 DDR 28/02/2016 DIT-770 #1836 Added validate with item charges without posting group
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW19.00.08 MVN 31/08/2016 BL#11248 (DIT-770 #2162) Merge SSCC changes
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields
    //                                                        2013716 Strength Spec. Code
    //                                                        2013717 Strength Spec. Value
    //                                                        2013718 Vol-Strength Spec. Code
    //                                                        2013719 Vol-Strength Spec. Value
    //                                                        2013720 New Strength Spec. Value
    //                                                        2013721 New Vol-Strength Spec. Value
    //                                                        2035243 New Quantity (Brewing Base)
    //                                                      Removed fields
    //                                                        2035243 Quantity (Degrees)
    //                                                        2035273 Original Gravity
    //                                                      Various bugfixes
    //                                                      Added to delete LossBreakdown records
    // DITW19.00.08 DDR 29/09/2016 BL#10443 Bugfix consumption entry type
    //                                      Added strength with "Applies-to Entry","Applies-from Entry"
    //                                      Bugfix missing "Physical Location Group Code","Location Group Code" with Location Mgt.
    //                                      Bugfix reset "Packaging Type Code" while validating Item No.
    //                                      Added fields 2035248 Exist Loss Breakdown
    // DITW19.00.08 DDR 17/10/2016 BL#10443 Modified function GetTaxSpecCaption()
    //                                      Added functions CalcLossBreakdownVol(),UpdateStrengthValues()
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Bugfix function GetTaxSpecCaption()
    //                                      Renamed function CalcLossBreakdownVol -> CalcTotalLossBreakdown
    //                                      Removed functions UpdateStrengthValues()
    //                                      Added functions AverageStrengthReserv(),SumVolStrengthReserv(),DrilldownReservEntryVS()
    // DITW19.00.08 DDR 27/10/2016 BL#10443 Modified sign return value function SumVolStrengthReserv()
    // DITW19.00.08 DDR 14/11/2016 BL#10443 Bugfix function GetTaxSpecCaption()
    // DITW19.00.08 DDR 09/12/2016 BL#10443 Allowed Scrap Quantity on other journals
    // DITW19.00.08A VSC 23/12/2016 BL#10443 Add New Field Reverse and new function ValidateReverse;
    // DITW19.00.08A VSC 29/29/2016 BL#10443 Fix bug not delete LossJournal Should Link to "Journal Line No." not "Line No."
    // DITW19.00.08A VSC 04/01/2017 BL#10443 New Function DeleteLossBreakdownJnl move code from delete trigger
    //                                       Delete LossJournal on Changing item no
    // DITW19.00.08A VSC 05/01/2017 BL#10443 Extend ValidateReverse On Neg. Values
    // DITW19.00.08A VSC 06/01/2017 BL#10443 No error on Max setting input. Only on posting do the check
    // DITW19.00.08A VSC 17/01/2016 BL#10443 ValidateReverse on Item Validation

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 20/02/2017 NRQ#20783 Added function TrackingExistsSSCC
    // DITW110.00.09 YHE 15/03/2017 NRQ#24111 merge DIT2016 W1 R8A
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.09 AKH 30/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.09 DDR 22/03/2017 NRQ#9661 Fix multi-shipments
    //                                       Fix missing checking mandatory "No. of package"
    // DITW110.00.09 DDR 05/04/2017 NRQ#16737 Added field 2014417 Relation Location Code
    // DITW110.00.09 VSC 12/04/2017 NRQ#18376 Merge back remaining Alcohol Blance
    // DITW110.00.10 MSF 17/05/2017 NRQ#13295 Added code to calculate Dimension for charges lines
    // DITW110.00.10 MSF 19/05/2017 NRQ#13295 Added code Trigger ValidateNewshortcutDim
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 MSF 07/07/2017 NRQ#16224 Return Registration part 3
    //                                  Added fields : 2014109 : Route Planning No.
    //  Location Depend on Return Location from Order shipment planning
    // DITW110.00.10 VSC 19/07/2017 NRQ#27479 New field "OWM Transaction ID" fix problem OWM posting.
    // DITW110.00.11 SFI 30/08/2017 BL#14417 New field
    //                                         2013637 Deposit Value
    //                                       Changes for deposit valuation
    // DITW110.00.11 SFI 31/08/2017 BL#30569 Added changes for SKU blocking
    // DITW110.00.11 AKH 15/09/2017 NRQ#33638 Adjusted code to inherit dimensions of Prod. Order Line item
    // DITW110.00.11 VSC 27/09/2017 NRQ#18377 Merge - QXL10.01 VSC 27/09/2017 NRQ#33079 : Failures in creating Quality tests (from Lot. No. Information Card, from Tracking page)
    //                                     No. of Quality Test is wrong.
    // DITW110.00.11 MSF 06/11/2017 NRQ#43572 Return registration & Control û part 5
    //                                        Added Field Driver Code
    // DITW110.00.12 AKH 21/03/2018 NRQ#64704 Adjusted code to use the "Inventory Unit of Measure" instead of "Base Unit of Measure" of the item
    // DITW110.00.12A ISL 04/06/2018 NRQ#71912 Added key "Line No.,Item No.,Item Charge No."
    // DITW110.00.12A HBA 04/06/2018 NRQ#51789 Updated Setup and Run time while posting
    // DITW110.00.12A HBA 07/06/2018 NRQ#51782 Added field Production jnl. flushing 2035266
    //                                         Added function UpdateConsumptionLine()
    // DITW110.00.12A ISL 13/06/2018 NRQ#51789 Added check in "Output Quantity - OnValidate()"
    // DITW110.00.12A HBA 20/06/2018 NRQ#74529 Added function AutoAdjustLotTrackingQty()
    // QXL11.01 MTR 14/09/2018 NRQ#24975 : Added field 2035098 "Your Reference" (Text30)
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
    //   #new fields Zone Code,New Zone Code and code for these fields

    // HEI.02 FDD HNK HeiliteBASE GAPID001 IBM NAIKH01 16/06/2017
    //   # Created a new function "AllowPartialOutput"

    // HEI.03 FDD HNK GAPLOG002 IBM ISYED01 20/06/2012
    //   # Added new fields Vendor name and vendor no. and new function getvend.

    // HEI.04 FDD-HNK HeiliteBASE GAPID001 IBM NAIKH01 04/07/2017
    //   # Added code in the function "GetItem()" to Check the condition when the "Item No." is blank.
    // 20170622 PRDGAP018 : PRDGAP018- Seeing the Actual posted consumption quantity

    // HEI.05 FDDHNK-HeiliteBASE-PRDGAP018 IBM ISYED01 22/06/2017
    //   # Added new field Actual Posted Cons/Output to table.

    // HEI.06 FDD-GAPID027 No lot no. & BIN automatic suggested on the FPO, RPO and prod Jou,  IBM.NAIKH01 -24.07.2017
    //   # Added new code in the funnction "OpenItemTrackingLines" to chek the mandatory Bin Cod.

    // HEI.07 FDD-PRDGAP024 IBM POENAB01 01.08.2017 #Zone code development without whs advanced mgmt
    //   #changed table relation for field 5403 Bin Code

    // HEI.08 FDD-GAPID031 IBM.PATHAA02 17.08.2017
    //   # Description made non-Editable

    // HEI.09 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Source DTax Group Code" field length from 10 to 20 characters
    // HEI.10 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    //   # New fields
    // HEI.11 PRDGAP038 IBM HORTO01 16.10.2017 - New field "Quality status"
    // HEI.12 PRDGAO027 IBM.NAIKH01 28.01.2018 -
    //   # No Automatic Bin Code on Item Journal Page as per Mail from ANCA
    // HEI.13 FDD-BA-PRDGAP01 IBM POSTOI01 12.07.2018
    //   # add new field 50009 Project Code code 20
    //   # add new field 50010 Project Description text 80
    // HEI.14 FDD-BA-SLSGAP01 IBM NASTAA02 19.12.2018 # Counterpoint Interface
    //   # New Fields created: 50011 - Interface Code
    //                         50012 - CP Vendor Invoice No.
    // DITW111.00.13 ISL 13/12/2018 NRQ#95758 : Added code in function UpdateConsumptionLine()
    // DITW111.00.13 MSF 06/12/2018 NRQ#94671 Line and header alert for not fully assigned lines - in warehouse shipment and sales order
    //                              Added field "Lot Reserved Qty. (Base)"
    // HEI.16 Defect #3646 IBM ISYED01 01.25.2019 Unable to input new Bin code in item reclass journal (Replacing 3548)
    //   #changed code on New Bin code and Bincode to input value based on new location and  old location code's.
    // HEI.17 FDD-HT620 IBM BULIMC01 16.08.2019 #new function PostConsumptionItemLines to restrict the output posting in production journal
    // #Item Reclass Journal menu is not operating correctly (showing wrong zones)
    // HEI.18 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New fields:
    //     # 10800 Shipment Method Code
    // HEI.19 CHG2026978 KUMARN15 14.10.2019
    //   # New fields created "Qty. (Calculated) in Inv. UoM", "Qty. (Phys. Inv.) in Inv. UoM", "Quantity in Inv. UoM", "Invent. Unit of Measure Code"
    //   # Code added on OnValidate of "Qty. (Phys. Inventory)"
    // HEI.20 CHG2026978 IBM.LS      15.11.2019
    //   # New Field created: 50017 - Freeze Batch Lines
    //   # Code added.
    //   # New Function created: CreateReservationEntries
    // HEI.21 CHG2026978 IBM.LS      05.12.2019
    //   # New Field created: 50018 - Enable Phys. Inv. Round-off
    //   # New Function created: RoundOffPhysInvQty
    // HEI.22 CHG2026978 IBM.LS      03.01.2020
    //   # Code added to get the Round-off value of "Qty. (Phys. Inventory)".
    // HEI.22 CHG2050741 IBM.LS 10.02.2020
    //   # Code of HEI.22 has been removed from field trigger to Function (RoundOffPhysInvQty).
    // HEI.24 CHG2060990 IBM BULIMC01  19.06.2020# new function created to update the CCC Code from Bin Code
    // HEI.25 CHG2065153 IBM KUMARN15 23.06.2020
    //   # Added field "Source System Identifier" and code changed in function CopyFromSalesHeader
    // HEI.26 CC-CHG2074187 IBM.LS 18.08.2020
    //   # Code added.
    // CHG2088560: DITW114.00.15 EZOG 22/10/2020 NRQ#160431 Fill "Gen. Posting Group" when validating "Item No."
    // CHG2088560: DITW114.00.15 EZOG 27/10/2020 NRQ#160431 Fix Bug
    // CHG2090305: DITW111.00.13A ISL 07/05/2019 NRQ#110425 Added code to post dimensions in entries
    // CHG2104608: DITW111.00.13 ISL 18/12/2018 NRQ#96024 Deleted field 2014461 "Prod. BOM Version Code"
    // HEI.27 CHG2100218 IBM SAXENA03 25.03.2021
    //   # Added Journal Temple Name & Journal Batch Name fileds in FlowField relation of field Name: Has Item Charge(Field ID 2014500)
    // HEI.28 CHG2049056 IBM.LS      08.04.2021
    //   # Created New Field: 50019 - Sent for Approval
    //   # Added Code
    // HEI.29 CHG2119178 IBM.AS 30.06.2021
    //   # HeiLite Base Stability Changes for Posting functions at JOB NAS
    //   # Adding GUIAllowed function added in Functions Applies-to Entry - OnValidate() , Bin Code-OnValidate(),
    //   AllItemsAvailability(), AllowPartialOutput(), InsertChargeLines()
    // HEI.30 CHG2111923 IBM BHATTA09 26.08.2021
    //   # Code added in UpdateTime function to take BASE Quantity into consideration while calculating Run Time
    // HEI.31 CHG2124777 IBM SURYAS01  08-09-2021
    //   # new function created to update the "New CCC Code" from "Bin Code"
    // NRQ195669.1 MVN 15/09/2021: merge DITW114.00.15 DDR 08/05/2020 NRQ#145254 Fix function RetrieveDepositValue() for transfer orders
    // HEI.32 CHG2118467 IBM.LS      22.09.2021
    //   # Created New Field: 50020 - Bulk Transfer
    //   # Added Code
    // HEI.33 CHG2123219 BHATTA09 08.12.2021
    //   # Code added for getting SKU CCC Dimension
    // HEI.34 CHG2131272 IBM.LS      14.12.2021
    //   # Created New Field: 50025 - Reporting Type
    // HEI.36 CHG2145002 (Corrective Change against INC3953244) BHATTA09 02.02.2022
    //   # Code added for fixing the issue of missing CCC Dim in Item Journal
    // HEI.37 CHG2145896 BHATTA09 14.03.2022
    //   # Code fine tuning for getting SKU CCC Dimension
    // HEI.38 HB1487 - CHG2070737 IBM NASTAA02 06.05.2022 # Mass Upload of Production Orders
    //   # Code added on function 'PostingItemJnlFromProduction'
    // HEI.39 CHG2140470 SAHAL01 29.07.2022 # Created New Fields: 50021 - Actual Posted Consumption
    //                                                            50022 - Actual Posted Lot No.
    //                                                            50023 - Consumption Suggested
    //                                                            50024 - Consumption Allocated
    // HEI.40 CHG2145896 BHATTA09 19.07.2022 # Code added for picking right CCC Dim Value in Item Reclass Journal
    // HEI.41 CHG2140470 SAHAL01 14.09.2022 # Created New Field: 50027 - Quantity Allocated
    // HEI.42 CHG2140470 SAHAL01 01.09.2022 # Added Code to validate Negative Consumption on posting.
    // HEI.43 CHG2145896 Yadavm05 12.01.2023 # Rollback codefor picking right CCC Dim Value in Item Reclass Journal
    // HEI.44 CHG2180069 ZOGHLE01 03.02.2023 #Limiting selection options in Entry Type column in Item journal template SCRAP
    //   # Added Code in "OnInsert" and "Entry Type"-OnValidate triggers to limit selection for scrapping Item journal lines
    // HEI.45 CHG2187702 SAHAL01 18.08.2023 Revaluation journal items in error
    //   # Created New Field: 50030 - Post To (Include,Skip)
    // HEI.46 CHG2222964 IBM PATHAA02/Mimikos 21.11.2023 Physical inventory journal too slow
    //   # Code Optimisation to Improve performance
    // HEI.47 CHG2222964 IBM PATHAA02/Mimikos 27.11.2023 Physical inventory journal too slow
    //   # Code Optimisation to Improve performance
    //***********************************************************************************************************
    //BC UPGRADE PATHAA02 10.03.26 BC UPGRADE-"Production jnl. flushing" Functionality to be added 
    // HEI.48- "Production jnl. flushing" field(2036306-->50061) is moved to 50K series as part of BC Upgrade
    //HEI.48-->T83-NRQ#51782 Added function UpdateConsumptionLine() called from "Output Quantity"OnValidate-->(Quantity-OnAfterValidateEvent in BC) added in GenExt-->CU50280.Note-DIT fields dependency and warnings
    //BC UPGRADE ATHUKS01 05.04.26 BC UPGRADE- InterfaceMaximo
    //1.Added NAV Code in Entry Type - OnAfterValidate trigger to check the condition when the "Entry Type" is "Purchase" or "Sale" and update the location code based on the default location code of item journal template. Also added code to check the default location code of item journal template when user change the entry type from "Positive Adjmt." or "Negative Adjmt." to "Purchase" or "Sale".
    //BC UPGRADE ATHUKS01 05.04.26 BC UPGRADE- InterfaceMaximo

    //BC Upgrade Kamnay01  Created this table  extension to add the field  for "Your Reference" . This field is required for FDD-DTW 006
    // BC Upgrade - RD03 System will though the error if use choose Entry typer other than Positive or Negative Adj in Scrap Journal Template

    fields
    {
        modify("Journal Template Name")
        {
            CaptionML = ENU = 'Journal Template Name', FRA = 'Nom modèle feuille';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
            // BC UPGRADE KAIRAR01 PID-520 >>
            trigger OnAfterValidate()
            begin
                //HEI.24>>
                UpdateCCCfromBinCode();
                //HEI.24<<
                //BCUP0-92 PATHAA02 08.07.26>>
                IF "Gen. Bus. Posting Group" = '' THEN
                    IF ItemJnlTemplate.GET("Journal Template Name") THEN
                        "Gen. Bus. Posting Group" := ItemJnlTemplate."Def. Gen. Bus. Posting Group FND";
                //BCUP0-92 PATHAA02 08.07.26<<
            end;
            // BC UPGRADE KAIRAR01 PID-520 <<
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Entry Type")
        {
            CaptionML = ENU = 'Entry Type', FRA = 'Type écriture';
            // OptionCaptionML = ENU = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output', FRA = 'Achat,Vente,Positif (ajust.),Négatif (ajust.),Transfert,Consommation,Production, ,Consommation d''assemblage,Résultat d''assemblage';
            //---BC Upgrade KAMNAY01>>
            trigger OnBeforeValidate()
            begin
                // BC Upgrade - RD03 System will though the error if use choose Entry typer other than Positive or Negative Adj in Scrap Journal Template -- >>
                CheckEntryTypeC(false);
                // BC Upgrade - RD03 System will though the error if use choose Entry typer other than Positive or Negative Adj in Scrap Journal Template -- <<
            end;

            trigger OnAfterValidate()
            var
                lItemJournalTemplate: Record "Item Journal Template";
                WMSManagement: Codeunit "WMS Management";
            begin
                //BC UPGRADE ATHUKS01>> InterfaceMaximo
                IF NOT ("Entry Type" IN ["Entry Type"::"Positive Adjmt.", "Entry Type"::"Negative Adjmt."]) THEN
                    TESTFIELD("Phys. Inventory", FALSE);

                IF CurrFieldNo <> 0 THEN
                    WMSManagement.CheckItemJnlLineFieldChange(Rec, xRec, FIELDCAPTION("Entry Type"));

                IF ("Entry Type" <> xRec."Entry Type") AND ("Entry Type" IN ["Entry Type"::Purchase, "Entry Type"::Sale]) THEN BEGIN
                    "Location Code" := '';
                    //HEI.44>>
                    lItemJournalTemplate.GET("Journal Template Name");
                    IF lItemJournalTemplate."Limit Type Selection FND" THEN
                        ERROR(EntryTypeErrorTxt);
                    //HEI.44<<
                END;
                //BC UPGRADE ATHUKS01<< InterfaceMaximo
            end;
            //---BC Upgrade KAMNAY01<<
        }
        modify("Source No.")
        {

            //Unsupported feature: Change TableRelation on ""Source No."(Field 6)". Please convert manually.

            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';

            //Unsupported feature: Change Description on "Description(Field 8)". Please convert manually.


            //Unsupported feature: Change Editable on "Description(Field 8)". Please convert manually.

        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';

            //Unsupported feature: Change Description on ""Location Code"(Field 9)". Please convert manually.

        }
        modify("Inventory Posting Group")
        {
            CaptionML = ENU = 'Inventory Posting Group', FRA = 'Groupe compta. stock';
        }
        modify("Source Posting Group")
        {

            //Unsupported feature: Change TableRelation on ""Source Posting Group"(Field 11)". Please convert manually.

            CaptionML = ENU = 'Source Posting Group', FRA = 'Groupe compta. origine';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Invoiced Quantity")
        {
            CaptionML = ENU = 'Invoiced Quantity', FRA = 'Quantité facturée';
        }
        modify("Unit Amount")
        {
            CaptionML = ENU = 'Unit Amount', FRA = 'Montant unitaire';

            //Unsupported feature: Change Description on ""Unit Amount"(Field 16)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Unit Amount"(Field 16)". Please convert manually.

        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';

            //Unsupported feature: Change Description on ""Unit Cost"(Field 17)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Unit Cost"(Field 17)". Please convert manually.

        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Discount Amount")
        {
            CaptionML = ENU = 'Discount Amount', FRA = 'Montant remise';
        }
        modify("Salespers./Purch. Code")
        {

            //Unsupported feature: Change TableRelation on ""Salespers./Purch. Code"(Field 23)". Please convert manually.

            CaptionML = ENU = 'Salespers./Purch. Code', FRA = 'Code vendeur/acheteur';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("Applies-to Entry")
        {
            CaptionML = ENU = 'Applies-to Entry', FRA = 'Ecriture lettrage';
        }
        modify("Item Shpt. Entry No.")
        {
            CaptionML = ENU = 'Item Shpt. Entry No.', FRA = 'N° séquence expéd. article';
        }
        modify("Shortcut Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 1 Code"(Field 34)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 2 Code"(Field 35)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Indirect Cost %")
        {
            CaptionML = ENU = 'Indirect Cost %', FRA = '% coût indirect';
        }
        modify("Source Type")
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
            //OptionCaptionML = ENU = ' ,Customer,Vendor,Item', FRA = ' ,Client,Fournisseur,Article';
        }
        modify("Journal Batch Name")
        {

            //Unsupported feature: Change TableRelation on ""Journal Batch Name"(Field 41)". Please convert manually.

            CaptionML = ENU = 'Journal Batch Name', FRA = 'Nom feuille';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Recurring Method")
        {
            CaptionML = ENU = 'Recurring Method', FRA = 'Mode abonnement';
            OptionCaptionML = ENU = ',Fixed,Variable', FRA = ',Fixe,Variable';
        }
        modify("Expiration Date")
        {
            CaptionML = ENU = 'Expiration Date', FRA = 'Date d''expiration';
        }
        modify("Recurring Frequency")
        {
            CaptionML = ENU = 'Recurring Frequency', FRA = 'Périodicité abonnement';
        }
        modify("Drop Shipment")
        {
            CaptionML = ENU = 'Drop Shipment', FRA = 'Livraison directe';
        }
        modify("Transaction Type")
        {
            CaptionML = ENU = 'Transaction Type', FRA = 'Nature transaction';
        }
        modify("Transport Method")
        {
            CaptionML = ENU = 'Transport Method', FRA = 'Mode de transport';
        }
        modify("Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Country/Region Code"(Field 49)". Please convert manually.

            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify("New Location Code")
        {

            //Unsupported feature: Change TableRelation on ""New Location Code"(Field 50)". Please convert manually.

            CaptionML = ENU = 'New Location Code', FRA = 'Nouveau code magasin';

            //Unsupported feature: Change Description on ""New Location Code"(Field 50)". Please convert manually.

        }
        modify("New Shortcut Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""New Shortcut Dimension 1 Code"(Field 51)". Please convert manually.

            CaptionML = ENU = 'New Shortcut Dimension 1 Code', FRA = 'Nouveau code raccourci axe 1';
        }
        modify("New Shortcut Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""New Shortcut Dimension 2 Code"(Field 52)". Please convert manually.

            CaptionML = ENU = 'New Shortcut Dimension 2 Code', FRA = 'Nouveau code raccourci axe 2';
        }
        modify("Qty. (Calculated)")
        {
            CaptionML = ENU = 'Qty. (Calculated)', FRA = 'Qté (calculée)';
        }
        modify("Qty. (Phys. Inventory)")
        {
            CaptionML = ENU = 'Qty. (Phys. Inventory)', FRA = 'Qté (constatée)';
            //---BC Upgrade KAMNAY01>>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin

                //HEI.20>>
                RoundOffPhysInvQty();
                //HEI.20<<
            end;
            //---BC Upgrade KAMNAY01<<
        }
        modify("Last Item Ledger Entry No.")
        {
            CaptionML = ENU = 'Last Item Ledger Entry No.', FRA = 'Dern. n° écriture comptable article';
        }
        modify("Phys. Inventory")
        {
            CaptionML = ENU = 'Phys. Inventory', FRA = 'Inventaire phys.';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("Entry/Exit Point")
        {
            CaptionML = ENU = 'Entry/Exit Point', FRA = 'Pays destination/provenance';
        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
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
        modify("Posting No. Series")
        {
            CaptionML = ENU = 'Posting No. Series', FRA = 'Souches de n° validation';
        }
        modify("Reserved Quantity")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Quantity"(Field 68)". Please convert manually.

            CaptionML = ENU = 'Reserved Quantity', FRA = 'Quantité réservée';
        }
        modify("Unit Cost (ACY)")
        {
            CaptionML = ENU = 'Unit Cost (ACY)', FRA = 'Coût unitaire DR';

            //Unsupported feature: Change Description on ""Unit Cost (ACY)"(Field 72)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Unit Cost (ACY)"(Field 72)". Please convert manually.

        }
        modify("Source Currency Code")
        {
            CaptionML = ENU = 'Source Currency Code', FRA = 'Code devise origine';
        }
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //  OptionCaptionML = ENU = ' ,Shipment,S.Invoice,Ret. Receipt,S. Cr. Memo,Receipt,P. Invoice,Ret. Shipment,P. Cr. Memo,Transfer Shpt.,Transfer Rcpt.,Service Shpt.,Service Inv.,Service Cr.Memo,P.Assembly,,,,,Serv. Receipt,Serv. P.Invoice,Serv. P.Credit Memo', FRA = ' ,Expédition vente,Facture vente,Réception retour vente,Avoir vente,Réception achat,Facture achat,Expédition retour achat,Avoir achat,Expédition transfert,Réception transfert,Expédition service,Facture service,Avoir service,Assemblage validé,,,,,Rec. service,Facture service achat,Avoir service achat';

            //Unsupported feature: Change OptionString on ""Document Type"(Field 79)". Please convert manually.


            //Unsupported feature: Change Description on ""Document Type"(Field 79)". Please convert manually.

        }
        modify("Document Line No.")
        {
            CaptionML = ENU = 'Document Line No.', FRA = 'N° ligne document';
        }
        modify("Order Type")
        {
            CaptionML = ENU = 'Order Type', FRA = 'Type de commande';
            //  OptionCaptionML = ENU = ' ,Production,Transfer,Service,Assembly', FRA = ' ,Production,Transfert,Service,Assemblage';
        }
        modify("Order No.")
        {

            //Unsupported feature: Change TableRelation on ""Order No."(Field 91)". Please convert manually.

            CaptionML = ENU = 'Order No.', FRA = 'N° commande';
        }
        modify("Order Line No.")
        {

            //Unsupported feature: Change TableRelation on ""Order Line No."(Field 92)". Please convert manually.

            CaptionML = ENU = 'Order Line No.', FRA = 'N° ligne commande';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("New Dimension Set ID")
        {
            CaptionML = ENU = 'New Dimension Set ID', FRA = 'ID du nouvel ensemble de dimensions';
        }
        modify("Assemble to Order")
        {
            CaptionML = ENU = 'Assemble to Order', FRA = 'Assemblage à la commande';
        }
        modify("Job No.")
        {
            CaptionML = ENU = 'Job No.', FRA = 'N° projet';
        }
        modify("Job Task No.")
        {
            CaptionML = ENU = 'Job Task No.', FRA = 'N° tâche projet';
        }
        modify("Job Purchase")
        {
            CaptionML = ENU = 'Job Purchase', FRA = 'Achat projet';
        }
        modify("Job Contract Entry No.")
        {
            CaptionML = ENU = 'Job Contract Entry No.', FRA = 'N° séquence contrat projet';
        }
        modify("Variant Code")
        {

            //Unsupported feature: Change TableRelation on ""Variant Code"(Field 5402)". Please convert manually.

            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Bin Code"(Field 5403)". Please convert manually.

            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("New Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""New Bin Code"(Field 5406)". Please convert manually.

            CaptionML = ENU = 'New Bin Code', FRA = 'Nouveau code emplacement';
            //---BC Upgrade KAMNAY01>>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //<<HEI.31
                UpdateCCCfromNewBinCode()
                //<<HEI.31
            end;
            //---BC Upgrade KAMNAY01<<
        }
        modify("Unit of Measure Code")
        {

            //Unsupported feature: Change TableRelation on ""Unit of Measure Code"(Field 5407)". Please convert manually.

            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Derived from Blanket Order")
        {
            CaptionML = ENU = 'Derived from Blanket Order', FRA = 'Issue de commande ouverte';
        }
        modify("Quantity (Base)")
        {
            CaptionML = ENU = 'Quantity (Base)', FRA = 'Quantité (base)';
        }
        modify("Invoiced Qty. (Base)")
        {
            CaptionML = ENU = 'Invoiced Qty. (Base)', FRA = 'Quantité facturée (base)';
        }
        modify("Reserved Qty. (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Qty. (Base)"(Field 5468)". Please convert manually.

            CaptionML = ENU = 'Reserved Qty. (Base)', FRA = 'Quantité réservée (base)';
        }
        modify(Level)
        {
            CaptionML = ENU = 'Level', FRA = 'Niveau';
        }
        modify("Flushing Method")
        {
            CaptionML = ENU = 'Flushing Method', FRA = 'Méthode consommation';
            //  OptionCaptionML = ENU = 'Manual,Forward,Backward,Pick + Forward,Pick + Backward', FRA = 'Manuelle,Pré-déduction,Post-déduction,Prélèvement + Pré-déduction,Prélèvement + Post-déduction';
        }
        modify("Changed by User")
        {
            CaptionML = ENU = 'Changed by User', FRA = 'Modifié par l''utilisateur';
        }
        //---BC Upgrade KAMNAY01>> Field removed from BC 
        // modify("Cross-Reference No.")
        // {
        //     CaptionML = ENU = 'Cross-Reference No.', FRA = 'Référence externe';
        // }
        //---BC Upgrade KAMNAY01>>
        modify("Originally Ordered No.")
        {
            CaptionML = ENU = 'Originally Ordered No.', FRA = 'N° article substitué';
        }
        modify("Originally Ordered Var. Code")
        {

            //Unsupported feature: Change TableRelation on ""Originally Ordered Var. Code"(Field 5702)". Please convert manually.

            CaptionML = ENU = 'Originally Ordered Var. Code', FRA = 'Code variante substitué';
        }
        modify("Out-of-Stock Substitution")
        {
            CaptionML = ENU = 'Out-of-Stock Substitution', FRA = 'Substitution sur rupture';
        }
        modify("Item Category Code")
        {
            CaptionML = ENU = 'Item Category Code', FRA = 'Code catégorie article';
        }
        modify(Nonstock)
        {
            CaptionML = ENU = 'Nonstock', FRA = 'Non stocké';
        }
        modify("Purchasing Code")
        {
            CaptionML = ENU = 'Purchasing Code', FRA = 'Procédure achat';
        }
        //---BC Upgrade KAMNAY01>> Field removed from BC 
        // modify("Product Group Code")
        // {

        //     //Unsupported feature: Change TableRelation on ""Product Group Code"(Field 5707)". Please convert manually.

        //     CaptionML = ENU = 'Product Group Code', FRA = 'Code groupe produits';
        // }
        //---BC Upgrade KAMNAY01>> Field removed from BC 
        modify("Planned Delivery Date")
        {
            CaptionML = ENU = 'Planned Delivery Date', FRA = 'Date livraison planifiée';
        }
        modify("Order Date")
        {
            CaptionML = ENU = 'Order Date', FRA = 'Date commande';
        }
        modify("Value Entry Type")
        {
            CaptionML = ENU = 'Value Entry Type', FRA = 'Type écriture valeur';
            // OptionCaptionML = ENU = 'Direct Cost,Revaluation,Rounding,Indirect Cost,Variance', FRA = 'Coût direct,Réévaluation,Arrondi,Coût indirect,Écart';
        }
        modify("Item Charge No.")
        {

            //Unsupported feature: Change TableRelation on ""Item Charge No."(Field 5801)". Please convert manually.

            CaptionML = ENU = 'Item Charge No.', FRA = 'N° frais annexes';
        }
        modify("Inventory Value (Calculated)")
        {
            CaptionML = ENU = 'Inventory Value (Calculated)', FRA = 'Valeur stock (calculée)';
        }
        modify("Inventory Value (Revalued)")
        {
            CaptionML = ENU = 'Inventory Value (Revalued)', FRA = 'Valeur stock (réévaluée)';
        }
        modify("Variance Type")
        {
            CaptionML = ENU = 'Variance Type', FRA = 'Type écart';
            // OptionCaptionML = ENU = ' ,Purchase,Material,Capacity,Capacity Overhead,Manufacturing Overhead', FRA = ' ,Achat,Matière,Opératoire,Frais généraux opératoires,Frais généraux matière';
        }
        modify("Inventory Value Per")
        {
            CaptionML = ENU = 'Inventory Value Per', FRA = 'Valeur stock par';
            OptionCaptionML = ENU = ' ,Item,Location,Variant,Location and Variant', FRA = ' ,Article,Magasin,Variante,Magasin et variante';
        }
        modify("Partial Revaluation")
        {
            CaptionML = ENU = 'Partial Revaluation', FRA = 'Réévaluation partielle';
        }
        modify("Applies-from Entry")
        {
            CaptionML = ENU = 'Applies-from Entry', FRA = 'Lettrage à partir écriture';
        }
        modify("Invoice No.")
        {
            CaptionML = ENU = 'Invoice No.', FRA = 'N° facture';
        }
        modify("Unit Cost (Calculated)")
        {
            CaptionML = ENU = 'Unit Cost (Calculated)', FRA = 'Coût unitaire (calculé)';

            //Unsupported feature: Change Description on ""Unit Cost (Calculated)"(Field 5809)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Unit Cost (Calculated)"(Field 5809)". Please convert manually.

        }
        modify("Unit Cost (Revalued)")
        {
            CaptionML = ENU = 'Unit Cost (Revalued)', FRA = 'Coût unitaire (réévalué)';

            //Unsupported feature: Change Description on ""Unit Cost (Revalued)"(Field 5810)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Unit Cost (Revalued)"(Field 5810)". Please convert manually.

        }
        modify("Applied Amount")
        {
            CaptionML = ENU = 'Applied Amount', FRA = 'Montant lettré';

            //Unsupported feature: Change Description on ""Applied Amount"(Field 5811)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Applied Amount"(Field 5811)". Please convert manually.

        }
        modify("Update Standard Cost")
        {
            CaptionML = ENU = 'Update Standard Cost', FRA = 'MAJ coût standard';
        }
        modify("Amount (ACY)")
        {
            CaptionML = ENU = 'Amount (ACY)', FRA = 'Montant DR';
        }
        modify(Correction)
        {
            CaptionML = ENU = 'Correction', FRA = 'Correction';
        }
        modify(Adjustment)
        {
            CaptionML = ENU = 'Adjustment', FRA = 'Ajustement';
        }
        modify("Applies-to Value Entry")
        {
            CaptionML = ENU = 'Applies-to Value Entry', FRA = 'Ecriture valeur lettrage';
        }
        modify("Invoice-to Source No.")
        {

            //Unsupported feature: Change TableRelation on ""Invoice-to Source No."(Field 5820)". Please convert manually.

            CaptionML = ENU = 'Invoice-to Source No.', FRA = 'N° origine facturation';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            // OptionCaptionML = ENU = 'Work Center,Machine Center, ,Resource', FRA = 'Centre de charge,Poste de charge, ,Ressource';
        }
        modify("No.")
        {

            //Unsupported feature: Change TableRelation on ""No."(Field 5831)". Please convert manually.

            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Operation No.")
        {

            //Unsupported feature: Change TableRelation on ""Operation No."(Field 5838)". Please convert manually.

            CaptionML = ENU = 'Operation No.', FRA = 'N° opération';
        }
        modify("Work Center No.")
        {
            CaptionML = ENU = 'Work Center No.', FRA = 'N° centre de charge';
        }
        modify("Setup Time")
        {
            CaptionML = ENU = 'Setup Time', FRA = 'Temps de préparation';
        }
        modify("Run Time")
        {
            CaptionML = ENU = 'Run Time', FRA = 'Temps d''exécution';
        }
        modify("Stop Time")
        {
            CaptionML = ENU = 'Stop Time', FRA = 'Temps d''arrêt';
        }
        modify("Output Quantity")
        {
            CaptionML = ENU = 'Output Quantity', FRA = 'Quantité produite';

            //PATHAA02 14.04.26 [PID754,FDD-DTW-002,IBM GAP DTW 36]>>

            trigger OnAfterValidate()
            var
                Hnkupgradecu: Codeunit "Heineken BC Upgrade";
            begin
                IF ("Output Quantity" <> xRec."Output Quantity") then
                    UpdateConsumptionLine1(Rec);
                //BC Upgrade kamnay01 FDD_GAP002_DTW>>
                recManufacturingSetup.GET;
                IF (CurrFieldNo = FIELDNO("Output Quantity")) AND (recManufacturingSetup."Prod. Jnl. Flushing (Time) FND") THEN
                    Hnkupgradecu.UpdateTimes(Rec);
                //BC Upgrade kamnay01 FDD_GAP002_DTW<<
            end;

            //PATHAA02 14.04.26 [PID754,FDD-DTW-002,IBM GAP DTW 36]<<
        }
        modify("Scrap Quantity")
        {
            CaptionML = ENU = 'Scrap Quantity', FRA = 'Quantité perte';
        }
        modify("Concurrent Capacity")
        {
            CaptionML = ENU = 'Concurrent Capacity', FRA = 'Capacité simultanée';
        }
        modify("Setup Time (Base)")
        {
            CaptionML = ENU = 'Setup Time (Base)', FRA = 'Temps de préparation (base)';
        }
        modify("Run Time (Base)")
        {
            CaptionML = ENU = 'Run Time (Base)', FRA = 'Temps d''exécution (base)';
        }
        modify("Stop Time (Base)")
        {
            CaptionML = ENU = 'Stop Time (Base)', FRA = 'Temps d''arrêt (base)';
        }
        modify("Output Quantity (Base)")
        {
            CaptionML = ENU = 'Output Quantity (Base)', FRA = 'Quantité produite (base)';
        }
        modify("Scrap Quantity (Base)")
        {
            CaptionML = ENU = 'Scrap Quantity (Base)', FRA = 'Quantité perte (base)';
        }
        modify("Cap. Unit of Measure Code")
        {

            //Unsupported feature: Change TableRelation on ""Cap. Unit of Measure Code"(Field 5858)". Please convert manually.

            CaptionML = ENU = 'Cap. Unit of Measure Code', FRA = 'Code unité capacité';
        }
        modify("Qty. per Cap. Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Cap. Unit of Measure', FRA = 'Quantité par unité capacité';
        }
        modify("Starting Time")
        {
            CaptionML = ENU = 'Starting Time', FRA = 'Heure début';
        }
        modify("Ending Time")
        {
            CaptionML = ENU = 'Ending Time', FRA = 'Heure fin';
        }
        modify("Routing No.")
        {
            CaptionML = ENU = 'Routing No.', FRA = 'N° gamme';
        }
        modify("Routing Reference No.")
        {
            CaptionML = ENU = 'Routing Reference No.', FRA = 'N° référence gamme';
        }
        modify("Prod. Order Comp. Line No.")
        {

            //Unsupported feature: Change TableRelation on ""Prod. Order Comp. Line No."(Field 5884)". Please convert manually.

            CaptionML = ENU = 'Prod. Order Comp. Line No.', FRA = 'N° ligne composant O.F.';
        }
        modify(Finished)
        {
            CaptionML = ENU = 'Finished', FRA = 'Terminé';
        }
        modify("Unit Cost Calculation")
        {
            CaptionML = ENU = 'Unit Cost Calculation', FRA = 'Unité de coût';
            //  OptionCaptionML = ENU = 'Time,Units', FRA = 'Temps,Quantité';
        }
        modify(Subcontracting)
        {
            CaptionML = ENU = 'Subcontracting', FRA = 'Sous-traitance';
        }
        modify("Stop Code")
        {
            CaptionML = ENU = 'Stop Code', FRA = 'Code arrêt';
        }
        modify("Scrap Code")
        {
            CaptionML = ENU = 'Scrap Code', FRA = 'Code rebut';
        }
        modify("Work Center Group Code")
        {
            CaptionML = ENU = 'Work Center Group Code', FRA = 'Code groupe centres de charge';
        }
        modify("Work Shift Code")
        {
            CaptionML = ENU = 'Work Shift Code', FRA = 'Code équipe';
        }
        modify("Serial No.")
        {
            CaptionML = ENU = 'Serial No.', FRA = 'N° de série';
        }
        modify("Lot No.")
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
        }
        modify("Warranty Date")
        {
            CaptionML = ENU = 'Warranty Date', FRA = 'Date garantie';
        }
        modify("New Serial No.")
        {
            CaptionML = ENU = 'New Serial No.', FRA = 'Nouveau n° de série';
        }
        modify("New Lot No.")
        {
            CaptionML = ENU = 'New Lot No.', FRA = 'Nouveau n° lot';
        }
        modify("New Item Expiration Date")
        {
            CaptionML = ENU = 'New Item Expiration Date', FRA = 'Nouvelle date péremption article';
        }
        modify("Item Expiration Date")
        {
            CaptionML = ENU = 'Item Expiration Date', FRA = 'Date péremption article';
        }
        modify("Return Reason Code")
        {
            CaptionML = ENU = 'Return Reason Code', FRA = 'Code motif retour';
        }
        modify("Warehouse Adjustment")
        {
            CaptionML = ENU = 'Warehouse Adjustment', FRA = 'Ajustement entrepôt';
        }
        modify("Phys Invt Counting Period Code")
        {
            CaptionML = ENU = 'Phys Invt Counting Period Code', FRA = 'Code période inventaire stock';
        }
        modify("Phys Invt Counting Period Type")
        {
            CaptionML = ENU = 'Phys Invt Counting Period Type', FRA = 'Type période inventaire';
            OptionCaptionML = ENU = ' ,Item,SKU', FRA = ' ,Article,Point de stock';
        }
        modify("Overhead Rate")
        {
            CaptionML = ENU = 'Overhead Rate', FRA = 'Frais généraux';
        }
        modify("Single-Level Material Cost")
        {
            CaptionML = ENU = 'Single-Level Material Cost', FRA = 'Coût matière mono-niveau';
        }
        modify("Single-Level Capacity Cost")
        {
            CaptionML = ENU = 'Single-Level Capacity Cost', FRA = 'Coût opératoire mono-niveau';
        }
        modify("Single-Level Subcontrd. Cost")
        {
            CaptionML = ENU = 'Single-Level Subcontrd. Cost', FRA = 'Coût s/traitance mono-niveau';
        }
        modify("Single-Level Cap. Ovhd Cost")
        {
            CaptionML = ENU = 'Single-Level Cap. Ovhd Cost', FRA = 'Frais gén. opérat. mono-niv.';
        }
        modify("Single-Level Mfg. Ovhd Cost")
        {
            CaptionML = ENU = 'Single-Level Mfg. Ovhd Cost', FRA = 'Frais gén. matière mono-niv.';
        }
        modify("Rolled-up Material Cost")
        {
            CaptionML = ENU = 'Rolled-up Material Cost', FRA = 'Coût matière multi-niveau';
        }
        modify("Rolled-up Capacity Cost")
        {
            CaptionML = ENU = 'Rolled-up Capacity Cost', FRA = 'Coût opératoire multi-niveau';
        }
        modify("Rolled-up Subcontracted Cost")
        {
            CaptionML = ENU = 'Rolled-up Subcontracted Cost', FRA = 'Coût s/traitance multi-niv.';
        }
        modify("Rolled-up Mfg. Ovhd Cost")
        {
            CaptionML = ENU = 'Rolled-up Mfg. Ovhd Cost', FRA = 'Frais gén. matière multi-niv.';
        }
        modify("Rolled-up Cap. Overhead Cost")
        {
            CaptionML = ENU = 'Rolled-up Cap. Overhead Cost', FRA = 'Frais gén. opérat. multi-niv.';
        }



        //Unsupported feature: CodeInsertion on ""Item No."(Field 3).OnValidate". Please convert manually.

        //trigger (Variable: ProductGroup)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Item No."(Field 3).OnValidate". Please convert manually.

        //trigger "(Field 3)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Item No." <> xRec."Item No." THEN BEGIN
          "Variant Code" := '';
          "Bin Code" := '';
          IF CurrFieldNo <> 0 THEN
            WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION("Item No."));
          IF ("Location Code" <> '') AND ("Item No." <> '') THEN BEGIN
            GetLocation("Location Code");
            IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
              WMSManagement.GetDefaultBin("Item No.","Variant Code","Location Code","Bin Code")
          end;
          IF ("Entry Type" = "Entry Type"::Transfer) AND ("Location Code" = "New Location Code") THEN
            "New Bin Code" := "Bin Code";
        end;

        IF "Entry Type" IN ["Entry Type"::Consumption,"Entry Type"::Output] THEN
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        IF "Item No." = '' THEN BEGIN
          CreateDim(
            DATABASE::Item,"Item No.",
            DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
            DATABASE::"Work Center","Work Center No.");
          EXIT;
        end;

        GetItem;
        Item.TESTFIELD(Blocked,FALSE);
        Item.TESTFIELD(Type,Item.Type::Inventory);
        IF "Value Entry Type" = "Value Entry Type"::Revaluation THEN
          Item.TESTFIELD("Inventory Value Zero",FALSE);
        Description := Item.Description;
        "Inventory Posting Group" := Item."Inventory Posting Group";
        "Item Category Code" := Item."Item Category Code";
        "Product Group Code" := Item."Product Group Code";

        IF ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
           ("Item Charge No." <> '')
        THEN BEGIN
          IF "Item No." <> xRec."Item No." THEN BEGIN
            TESTFIELD("Partial Revaluation",FALSE);
            RetrieveCosts;
            "Indirect Cost %" := 0;
            "Overhead Rate" := 0;
            "Inventory Value Per" := "Inventory Value Per"::" ";
            VALIDATE("Applies-to Entry",0);
            "Partial Revaluation" := FALSE;
          end;
        end else BEGIN
          "Indirect Cost %" := Item."Indirect Cost %";
          "Overhead Rate" := Item."Overhead Rate";
          IF NOT "Phys. Inventory" OR (Item."Costing Method" = Item."Costing Method"::Standard) THEN BEGIN
            RetrieveCosts;
            "Unit Cost" := UnitCost;
          end else
            UnitCost := "Unit Cost";
        end;

        IF (("Entry Type" = "Entry Type"::Output) AND (WorkCenter."No." = '') AND (MachineCenter."No." = '')) OR
           ("Entry Type" <> "Entry Type"::Output) OR
           ("Value Entry Type" = "Value Entry Type"::Revaluation)
        THEN
          "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";

        CASE "Entry Type" OF
          "Entry Type"::Purchase,
          "Entry Type"::Output,
          "Entry Type"::"Assembly Output":
            PurchPriceCalcMgt.FindItemJnlLinePrice(Rec,FIELDNO("Item No."));
          "Entry Type"::"Positive Adjmt.",
          "Entry Type"::"Negative Adjmt.",
          "Entry Type"::Consumption,
          "Entry Type"::"Assembly Consumption":
            "Unit Amount" := UnitCost;
          "Entry Type"::Sale:
            SalesPriceCalcMgt.FindItemJnlLinePrice(Rec,FIELDNO("Item No."));
          "Entry Type"::Transfer:
            BEGIN
              "Unit Amount" := 0;
              "Unit Cost" := 0;
              Amount := 0;
            end;
        end;

        CASE "Entry Type" OF
          "Entry Type"::Purchase:
            "Unit of Measure Code" := Item."Purch. Unit of Measure";
          "Entry Type"::Sale:
            "Unit of Measure Code" := Item."Sales Unit of Measure";
          "Entry Type"::Output:
            BEGIN
              Item.TESTFIELD("Inventory Value Zero",FALSE);
              ProdOrderLine.SetFilterByReleasedOrderNo("Order No.");
              ProdOrderLine.SETRANGE("Item No.","Item No.");
              IF ProdOrderLine.FINDFIRST THEN BEGIN
                "Routing No." := ProdOrderLine."Routing No.";
                "Source Type" := "Source Type"::Item;
                "Source No." := ProdOrderLine."Item No.";
              end else
                IF ("Value Entry Type" <> "Value Entry Type"::Revaluation) AND
                   (CurrFieldNo <> 0)
                THEN
                  ERROR(Text031,"Item No.","Order No.");
              IF ProdOrderLine.COUNT = 1 THEN BEGIN
                VALIDATE("Order Line No.",ProdOrderLine."Line No.");
                "Unit of Measure Code" := ProdOrderLine."Unit of Measure Code";
                "Location Code" := ProdOrderLine."Location Code";
                VALIDATE("Variant Code",ProdOrderLine."Variant Code");
                VALIDATE("Bin Code",ProdOrderLine."Bin Code");
              end else
                "Unit of Measure Code" := Item."Base Unit of Measure";
            end;
          "Entry Type"::Consumption:
            BEGIN
              ProdOrderComp.SetFilterByReleasedOrderNo("Order No.");
              ProdOrderComp.SETRANGE("Item No.","Item No.");
              IF ProdOrderComp.COUNT = 1 THEN BEGIN
                ProdOrderComp.FINDFIRST;
                VALIDATE("Order Line No.",ProdOrderComp."Prod. Order Line No.");
                VALIDATE("Prod. Order Comp. Line No.",ProdOrderComp."Line No.");
                "Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                "Location Code" := ProdOrderComp."Location Code";
                VALIDATE("Variant Code",ProdOrderComp."Variant Code");
                VALIDATE("Bin Code",ProdOrderComp."Bin Code");
              end else BEGIN
                "Unit of Measure Code" := Item."Base Unit of Measure";
                VALIDATE("Prod. Order Comp. Line No.",0);
              end;
            end;
          else
            "Unit of Measure Code" := Item."Base Unit of Measure";
        end;

        IF "Value Entry Type" = "Value Entry Type"::Revaluation THEN
          "Unit of Measure Code" := Item."Base Unit of Measure";
        VALIDATE("Unit of Measure Code");
        IF "Variant Code" <> '' THEN
          VALIDATE("Variant Code");

        CheckItemAvailable(FIELDNO("Item No."));

        IF ((NOT ("Order Type" IN ["Order Type"::Production,"Order Type"::Assembly])) OR ("Order No." = '')) AND NOT "Phys. Inventory"
        THEN
          CreateDim(
            DATABASE::Item,"Item No.",
            DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
            DATABASE::"Work Center","Work Center No.");

        ReserveItemJnlLine.VerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Item No." <> xRec."Item No." then begin
          "Variant Code" := '';
          "Bin Code" := '';
          // <<DITW110.00.09 DDR 05/04/2017 NRQ#16737
          "Relation Location Code" := '';
          // >>DITW110.00.09 DDR NRQ#16737
          //<< DITW19.00.08A VSC 04/01/2017 BL#10443
          DeleteLossBreakdownJnl(Rec);
          //>> DITW19.00.08A VSC BL#10443
          // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
          if ("Responsibility Center" = '') and ("Item No." <> '') then
            InitRespCenterCode;
          // >>DITW18.00.06 DDR DIT-770 #1189
          // <<DITW15.00.00.37 DDR 21/05/2010
          GetItem;

          if (Item."Location Code" <> '') and (not "Phys. Inventory") and
            ((CurrFieldNo = FIELDNO("Item No.")) or ("Line No." = 0) or
             ((xRec."Item No." <> "Item No.") and (CurrFieldNo <> 0)))
          then begin
            // <<DITW16.00.00.43 DDR 27/08/2013 DIT-715 #699
            GetLocation(Item."Location Code");
            if not Location."Directed Put-away and Pick" then
            // >>DITW16.00.00.43 DDR DIT-715 #699
              // <<DITW19.00.08 DDR 29/09/2016 BL#10443
              "Physical Location Group Code" := Location."Physical Location Group Code";
              "Location Group Code" := Location."Location Group Code";
              // >>DITW19.00.08 DDR BL#10443
              "Location Code" := Item."Location Code";
          end;
          // >>DITW15.00.00.37 DDR

         //<<DITW110.00.10 MSF 14/07/2017 NRQ#16224
          if ("Route Planning No." <> '') and ("Route Planning No." = "Document No.") and
            (not "Phys. Inventory") and ("Entry Type" in["Entry Type"::"Positive Adjmt.","Entry Type"::"Negative Adjmt."]) and
            ((CurrFieldNo = FIELDNO("Item No.")) or ("Line No." = 0) or
             ((xRec."Item No." <> "Item No.") and (CurrFieldNo <> 0)))
          then begin
            if Item."Reverse Location Code" <> '' then
              "Location Code" := Item."Reverse Location Code"
            else if RoutePlanningWorksheet.GET("Route Planning No.") then begin
              if RoutePlanningWorksheet."Return Location Code" <> '' then
                "Location Code" := RoutePlanningWorksheet."Return Location Code"
              else if RoutePlanningWorksheet."Location Code"<> '' then
                "Location Code" := RoutePlanningWorksheet."Location Code";
            end;
          end;
        //>>DITW110.00.10 MSF 14/07/2017 NRQ#16224

          if CurrFieldNo <> 0 then
            WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION("Item No."));
          if ("Location Code" <> '') and ("Item No." <> '') then begin
            GetLocation("Location Code");
            // <<DITW15.00.00.37 DDR 20/01/2010
            "Physical Location Group Code" := Location."Physical Location Group Code";
            "Location Group Code" := Location."Location Group Code";
            // >>DITW15.00.00.37 DDR
            if Location."Bin Mandatory" and not Location."Directed Put-away and Pick" then
              WMSManagement.GetDefaultBin("Item No.","Variant Code","Location Code","Bin Code")
          end;
          if ("Entry Type" = "Entry Type"::Transfer) and ("Location Code" = "New Location Code") then
            "New Bin Code" := "Bin Code";
        end;

        if "Entry Type" in ["Entry Type"::Consumption,"Entry Type"::Output] then
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        if "Item No." = '' then begin
          // <<DITW15.00.00.24 DDR 25/09/2008
        #19..21
            DATABASE::"Work Center","Work Center No.",
            DATABASE::"Item Charge","Item Charge No.",
            // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
            DATABASE::Item,"Tax Item No.",
            //<<DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
            DATABASE::"Responsibility Center", "Responsibility Center");
            //>>DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
            // >>DITW16.00.00.43 DDR DIT-715 #768
          // >>DITW15.00.00.24 DDR
          UpdateCCCfromBinCode; //HEI.24
        exit;
        end;

        GetItem;
        Item.TESTFIELD(Blocked,false);
        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        Item.BlockedSKU("Location Code","Variant Code",true);
        // >> DITW110.00.11 SFI BL#30569
        Item.TESTFIELD(Type,Item.Type::Inventory);
        if "Value Entry Type" = "Value Entry Type"::Revaluation then
          Item.TESTFIELD("Inventory Value Zero",false);
        #31..34
        // <<DITW15.00.00.30 DDR 09/01/2009 - DITW15.00.00.37 DDR 26/04/2010 - 04/05/2010
        if (Item."Location Code" <> '') and (not "Phys. Inventory") and
          ((CurrFieldNo = FIELDNO("Item No.")) or ("Line No." = 0) or
           ((xRec."Item No." <> "Item No.") and (CurrFieldNo <> 0)))
        then begin
          // <<DITW16.00.00.43 DDR 27/08/2013 DIT-715 #699
          GetLocation(Item."Location Code");
          if not Location."Directed Put-away and Pick" then begin
          // >>DITW16.00.00.43 DDR DIT-715 #699
            // <<DITW19.00.08 DDR 29/09/2016 BL#10443
            "Physical Location Group Code" := Location."Physical Location Group Code";
            "Location Group Code" := Location."Location Group Code";
            // >>DITW19.00.08 DDR BL#10443
            "Location Code" := Item."Location Code";
          end;
        end;
        // >>DITW15.00.00.37 DDR
        // <<DITW15.00.00.01 DDR 27/12/2007
        "Item DTax Group Code":= Item."Item DTax Group Code";
        // >>DITW15.00.00.01 DDR
        // <<DITW15.00.00.01 DDR 04/01/2007
        "Item DDeposit Group Code" := Item."Item DDeposit Group Code";
        // >>DITW15.00.00.01 DDR
        // <<DITW15.00.00.34 DDR 03/07/2009
        "Tariff No." := Item."Tariff No.";
        // >>DITW15.00.00.34 DDR
        // <<DITW15.00.00.38 DDR 01/09/2010 #1217
        "Product Tax Code" := Item."Product Tax Code";
        // >>DITW15.00.00.38 DDR
        // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        "Packaging Type Code" := '';
        "Pack Qty. per Unit of Measure" := 0;
        "No. of Packages" := 0;
        // >>DITW19.00.08 DDR BL#10443

        // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008 - DITW19.00.08 DDR 29/09/2016 BL#10443
        if "Product Group Code" <> '' then begin
          TESTFIELD("Item Category Code");
          ProductGroup.GET("Item Category Code","Product Group Code");
          "Include in Losses" := ProductGroup."Include in Losses";
        end;
        // >>DITW19.00.08 DDR BL#10443

        if ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") or
           ("Item Charge No." <> '')
        then begin
          if "Item No." <> xRec."Item No." then begin
            TESTFIELD("Partial Revaluation",false);
        #41..45
            "Partial Revaluation" := false;
          end;
        end else begin
           //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
           if rStockkeepingUnit.GET("Location Code","Item No.","Variant Code") then begin
             "Indirect Cost %" := rStockkeepingUnit."Indirect Cost %";
             "Overhead Rate" := rStockkeepingUnit."Overhead Rate";
           end else begin ;
           //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
            "Indirect Cost %" := Item."Indirect Cost %";
            "Overhead Rate" := Item."Overhead Rate";
           //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
           end;
           //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185

          if not "Phys. Inventory" or (Item."Costing Method" = Item."Costing Method"::Standard) then begin
            RetrieveCosts;
            "Unit Cost" := UnitCost;
          end else
            UnitCost := "Unit Cost";
        end;

        // << DITW110.00.11 SFI 30/08/2017 BL#14417
        "Deposit Value" := RetrieveDepositValue();
        // >> DITW110.00.11 SFI BL#14417
        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        GetItem();
        Item.BlockedSKU("Location Code","Variant Code",true);
        // >> DITW110.00.11 SFI BL#30569
        if (("Entry Type" = "Entry Type"::Output) and (WorkCenter."No." = '') and (MachineCenter."No." = '')) or
           ("Entry Type" <> "Entry Type"::Output) or
           ("Value Entry Type" = "Value Entry Type"::Revaluation)
        then
          "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";

        // <<DITW15.00.00.24 DDR 25/09/2008 (Nav client lost currfieldno after called functions Sale or PurchPriceCalcMgt)
        lCurrFieldNo := CurrFieldNo;
        // >>DITW15.00.00.24 DDR

        case "Entry Type" of
        #65..72
            // <<DITW15.00.00.24 DDR 03/10/2008
            if "Item Charge No." = '' then
            // >>DITW15.00.00.24 DDR
              "Unit Amount" := UnitCost;
        #74..76
            begin
        #78..80
            end;
        end;

        // <<DITW15.00.00.24 DDR 25/09/2008
        CurrFieldNo := lCurrFieldNo;
        // >>DITW15.00.00.24 DDR

        case "Entry Type" of
        #85..89
            begin
              Item.TESTFIELD("Inventory Value Zero",false);
              ProdOrderLine.SetFilterByReleasedOrderNo("Order No.");
              ProdOrderLine.SETRANGE("Item No.","Item No.");
              if ProdOrderLine.FINDFIRST then begin
        #95..97
                // <<DITW15.00.00.24 DDR 29/09/2008
                VALIDATE("Source No.");
                // >>DITW15.00.00.24 DDR
              end else
                if ("Value Entry Type" <> "Value Entry Type"::Revaluation) and
                   (CurrFieldNo <> 0)
                then
                  ERROR(Text031,"Item No.","Order No.");
              if ProdOrderLine.COUNT = 1 then begin
        #104..106
                // <<DITW19.00.08 DDR 17/08/2016 20/10/2016 BL#10443
                "Physical Location Group Code" := ProdOrderLine."Physical Location Group Code";
                "Responsibility Center" := ProdOrderLine."Responsibility Center";
                "Item Category Code" := ProdOrderLine."Item Category Code";
                "Product Group Code" := ProdOrderLine."Item Product Group Code";
                "Cross-Reference No." := ProdOrderLine."Cross-Reference No.";
                "Unit Volume HL" := ProdOrderLine."Unit Volume HL";
                "Strength Spec. Code" := ProdOrderLine."Strength Spec. Code";
                "Vol-Strength Spec. Code" := ProdOrderLine."Vol-Strength Spec. Code";
                // >>DITW19.00.08 DDR BL#10443
                //HEI.01 PRDGAP024>>
                if ProdOrderLine."Bin Code" <> '' then begin
                  Bin.GET("Location Code",ProdOrderLine."Bin Code");
                  "Zone Code" := Bin."Zone Code";
                end;
                //HEI.01 PRDGAP024<<
                VALIDATE("Variant Code",ProdOrderLine."Variant Code");
                VALIDATE("Bin Code",ProdOrderLine."Bin Code");
              end else
                "Unit of Measure Code" := Item."Base Unit of Measure";
            end;
          "Entry Type"::Consumption:
            begin
              ProdOrderComp.SetFilterByReleasedOrderNo("Order No.");
              ProdOrderComp.SETRANGE("Item No.","Item No.");
              if ProdOrderComp.COUNT = 1 then begin
        #117..121
                // <<DITW19.00.08 DDR 17/08/2016 29/09/2016 BL#10443
                GetLocation("Location Code");
                "Physical Location Group Code" := Location."Physical Location Group Code";
                "Location Group Code" := Location."Location Group Code";
                "Responsibility Center" := ProdOrderLine."Responsibility Center";
                // >>DITW19.00.08 DDR BL#10443
                //HEI.01 PRDGAP024>>
                if ProdOrderLine."Bin Code" <> '' then begin
                  Bin.GET("Location Code",ProdOrderLine."Bin Code");
                  "Zone Code" := Bin."Zone Code";
                end;
                //HEI.01 PRDGAP024<<
                VALIDATE("Variant Code",ProdOrderComp."Variant Code");
                VALIDATE("Bin Code",ProdOrderComp."Bin Code");
              end else begin
                "Unit of Measure Code" := Item."Base Unit of Measure";
                VALIDATE("Prod. Order Comp. Line No.",0);
              end;
            end;
          else
          //<< DITW110.00.12 AKH 21/03/2018 NRQ#64704
           if not "Phys. Inventory" then begin
            "Unit of Measure Code" := Item."Inventory Unit of Measure";
           end else
            "Unit of Measure Code" := Item."Base Unit of Measure";
          //>> DITW110.00.12 AKH NRQ#64704
        end;

        if "Value Entry Type" = "Value Entry Type"::Revaluation then
          "Unit of Measure Code" := Item."Base Unit of Measure";

        // <<DITW15.00.00.01 DDR 24/01/2008 - DITW19.00.08 DDR 17/08/2016 BL#10443
        "Unit Volume HL" := Item."Unit Volume HL" * UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
        // >>DITW15.00.00.01 DDR - DITW19.00.08 DDR BL#10443
        // <<DITW18.00.06 DDR 03/11/2015 DIT-770 #1395 - DITW19.00.08 DDR 17/08/2016 BL#10443
        if "Entry Type" = "Entry Type"::Transfer then
          "New Unit Volume HL" := "Unit Volume HL";
        // >>DITW18.00.06 DDR DIT-770 #1395 - DITW19.00.08 DDR BL#10443

        // <<DITW19.00.08 DDR 17/08/2016 17/10/2016 20/10/2016 BL#10443
        "Strength Spec. Code" := Item."Strength Spec. Code";
        "Vol-Strength Spec. Code" := Item."Vol-Strength Spec. Code";
        // >>DITW19.00.08 DDR BL#10443

        // <<DITW15.00.00.38 DDR 02/09/2010 - 17/09/2010 #1217
        if "Item Charge No." = '' then begin
          ItemUnitOfMeasure.GET("Item No.","Unit of Measure Code");
          "Packaging Type Code" := ItemUnitOfMeasure."Packaging Type Code";
          // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
          if ItemUnitOfMeasure."Packaging Type Code" <> '' then
            ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
          "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
          // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
        end;
        // >>DITW15.00.00.38 DDR

        // <<DITW18.00.06 DDR 27/02/2015 DIT-770 #1189
        if "Location Code" <> xRec."Location Code" then begin
          if (("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> '')) or
            ("Responsibility Center" <> xRec."Responsibility Center")
          then
            if not UserSetupMgt.CheckLocation(EntryTypeToRespID,"Location Code","Responsibility Center") then
              ERROR(
                Text2014414,
                Location.TABLECAPTION,"Location Code",
                RespCenter.TABLECAPTION,GetRespCenterCode);

          VALIDATE("Location Code");
        end;
        // >>DITW18.00.06 DDR DIT-770 #1189

        VALIDATE("Unit of Measure Code");
        if "Variant Code" <> '' then
        #137..140
        if ((not ("Order Type" in ["Order Type"::Production,"Order Type"::Assembly])) or ("Order No." = '')) and not "Phys. Inventory"
        then
          begin //HEI.24
            CreateDim(
              DATABASE::Item,"Item No.",
              DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
              DATABASE::"Work Center","Work Center No.",
              DATABASE::"Item Charge","Item Charge No.",
              // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
              DATABASE::Item,"Tax Item No.",
              //<<DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
              DATABASE::"Responsibility Center", "Responsibility Center");
              //>>DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
              // >>DITW16.00.00.43 DDR DIT-715 #768
              // >>DITW15.00.00.24 DDR
            UpdateCCCfromBinCode; //HEI.24
        end; //HEI.24

        // <<DITW15.00.00.24 DDR 25/09/2008 (Nav client lost currfieldno after called function ReserveItemJnlLine())
        lCurrFieldNo := CurrFieldNo;
        // >>DITW15.00.00.24 DDR

        ReserveItemJnlLine.VerifyChange(Rec,xRec);

        //<<FINXL8.00.001 BSA 02/06/2015 #178
        if recFinXLSetup.READPERMISSION then
          cduDistIntegration.fctEnterItemJnlLineCrossRef(Rec);
        //>>FINXL8.00.001 BSA 02/06/2015 #178

        // <<DITW15.00.00.37 DDR 29/01/2010
        UpdateAADInfo();
        // >>DITW15.00.00.37 DDR

        // <<DITW15.00.00.24 DDR 25/09/2008
        CurrFieldNo := lCurrFieldNo;
        UpdateCharges(FIELDNO("Item No."),(CurrFieldNo = FIELDNO("Item No.")));
        // >>DITW15.00.00.24 DDR

        //<< DITW19.00.08A VSC 17/01/2016 BL#10443
        ValidateReverse;
        //>> DITW19.00.08A VSC BL#10443
        //<<DITW114.00.15 EZOG 22/10/2020 NRQ#160431
        if "Gen. Bus. Posting Group" = '' then
         //<<DITW114.00.15 EZOG 27/10/2020 NRQ#160431
         if  ItemJnlTemplate.GET("Journal Template Name") then
         //>>DITW114.00.15 EZOG 27/10/2020 NRQ#160431
          "Gen. Bus. Posting Group" := ItemJnlTemplate."Def. Gen. Bus. Posting Group";
        //>>DITW114.00.15 EZOG 22/10/2020 NRQ#160431
        */
        //end;


        //Unsupported feature: CodeModification on ""Posting Date"(Field 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Document Date","Posting Date");
        CheckDateConflict.ItemJnlLineCheck(Rec,CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE("Document Date","Posting Date");
        CheckDateConflict.ItemJnlLineCheck(Rec,CurrFieldNo <> 0);

        // <<DITW15.00.00.24 DDR 25/09/2008
        UpdateCharges(FIELDNO("Posting Date"),(CurrFieldNo = FIELDNO("Posting Date")));
        // >>DITW15.00.00.24 DDR
        // <<DITW15.00.00.39 DDR 19/10/2011 #1363
        UpdateAmount();
        // >>DITW15.00.00.39 DDR #1363
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Entry Type"(Field 5).OnValidate". Please convert manually.

        //trigger (Variable: lCurrFieldNo)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Entry Type"(Field 5).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT ("Entry Type" IN ["Entry Type"::"Positive Adjmt.","Entry Type"::"Negative Adjmt."]) THEN
          TESTFIELD("Phys. Inventory",FALSE);

        IF CurrFieldNo <> 0 THEN
          WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION("Entry Type"));

        CASE "Entry Type" OF
          "Entry Type"::Purchase:
            IF UserMgt.GetRespCenter(1,'') <> '' THEN
              "Location Code" := UserMgt.GetLocation(1,'',UserMgt.GetPurchasesFilter);
          "Entry Type"::Sale:
            IF UserMgt.GetRespCenter(0,'') <> '' THEN
              "Location Code" := UserMgt.GetLocation(0,'',UserMgt.GetSalesFilter);
          "Entry Type"::Consumption,"Entry Type"::Output:
            VALIDATE("Order Type","Order Type"::Production);
          "Entry Type"::"Assembly Consumption","Entry Type"::"Assembly Output":
            VALIDATE("Order Type","Order Type"::Assembly);
        end;

        IF xRec."Location Code" = '' THEN
          IF Location.GET("Location Code") THEN
            IF  Location."Directed Put-away and Pick" THEN
              "Location Code" := '';

        IF "Item No." <> '' THEN
          VALIDATE("Location Code");

        VALIDATE("Item No.");
        IF "Entry Type" <> "Entry Type"::Transfer THEN BEGIN
          "New Location Code" := '';
          "New Bin Code" := '';
        end;

        IF "Entry Type" <> "Entry Type"::Output THEN
          Type := Type::" ";

        ReserveItemJnlLine.VerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not ("Entry Type" in ["Entry Type"::"Positive Adjmt.","Entry Type"::"Negative Adjmt."]) then
          TESTFIELD("Phys. Inventory",false);

        if CurrFieldNo <> 0 then
          WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION("Entry Type"));

        // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1189
        // <<DITW18.00.06 DDR 01/10/2015 DIT-770 #1618
        if ("Entry Type" <> xRec."Entry Type") and ("Entry Type" in ["Entry Type"::Purchase,"Entry Type"::Sale])then begin
        // >>DITW18.00.06 DDR 01/10/2015 DIT-770 #1618
          SETRANGE("Location Table Filter");
          SETRANGE("Phys. Location Table Filter");
          "Location Code" := '';
          "Physical Location Group Code" := '';
          "Location Group Code" := '';
          InitRespCenterCode;
          //HEI.44>>
          lItemJournalTemplate.GET("Journal Template Name");
          if lItemJournalTemplate."Limit Type Selection" then
            ERROR(EntryTypeErrorTxt);
          //HEI.44<<
        end;
        // >>DITW18.00.06 DDR DIT-770 #1189

        case "Entry Type" of
          // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
          //"Entry Type"::Purchase:
          //  IF UserMgt.GetRespCenter(1,'') <> '' THEN
          //    "Location Code" := UserMgt.GetLocation(1,'',UserMgt.GetPurchasesFilter);
          //"Entry Type"::Sale:
          //  IF UserMgt.GetRespCenter(0,'') <> '' THEN
          //    "Location Code" := UserMgt.GetLocation(0,'',UserMgt.GetSalesFilter);
          // >>DITW18.00.06 DDR DIT-770 #1189
        #14..17
          // >>DITW18.00.06 DDR DIT-770 #1189
        end;

        // <<DITW18.00.06 DDR 26/02/2015 04/03/2015 DIT-770 #1189
        // <<DITW18.00.06 DDR 01/10/2015 DIT-770 #1618
        if ("Entry Type" <> xRec."Entry Type") and ("Entry Type" in ["Entry Type"::Purchase,"Entry Type"::Sale])then begin
        // >>DITW18.00.06 DDR 01/10/2015 DIT-770 #1618
          if UserMgt.GetRespCenter(EntryTypeToRespID,'') <> '' then
            InitRespLocationCode;
        end;
        // >>DITW18.00.06 DDR DIT-770 #1189

        if xRec."Location Code" = '' then
          if Location.GET("Location Code") then
            if  Location."Directed Put-away and Pick" then
              "Location Code" := '';

        // <<DITW15.00.00.37 DDR 20/01/2010
        // <<DITW18.00.06 DDR 25/02/2015 04/03/2015 DIT-770 #1189
        if "Location Code" <> xRec."Location Code" then begin
          GetLocation("Location Code");
        // >>DITW18.00.06 DDR DIT-770 #1189
          "Physical Location Group Code" := Location."Physical Location Group Code";
          "Location Group Code" := Location."Location Group Code";
        end;
        // >>DITW15.00.00.37 DDR

        if "Item No." <> '' then
        #26..28
        // <<DITW15.00.00.24 DDR 03/10/2008 - DITW15.00.00.37 DDR 05/05/2010
        if "Item Charge No." <> '' then
        VALIDATE("Item Charge No.");
        // >>DITW15.00.00.37 DDR

        if "Entry Type" <> "Entry Type"::Transfer then begin
          "New Location Code" := '';
          "New Bin Code" := '';
          // <<DITW15.00.00.37 DDR 20/05/2010
          "New Location Group Code" := '';
          "New Phys. Location Group Code" := '';
          // >>DITW15.00.00.37 DDR
          // <<DITW19.00.08 DDR 17/08/2016 20/10/2016 BL#10443
          "New Unit Volume HL" := 0;
          "New Quantity (Brewing Base)" := 0;
          // >>DITW19.00.08 DDR BL#10443
        end;

        if "Entry Type" <> "Entry Type"::Output then
          Type := Type::" ";

        // <<DITW15.00.00.24 DDR 25/09/2008 (Nav client lost currfieldno after called function ReserveItemJnlLine())
        lCurrFieldNo := CurrFieldNo;
        // >>DITW15.00.00.24 DDR

        ReserveItemJnlLine.VerifyChange(Rec,xRec);

        // <<DITW15.00.00.24 DDR 25/09/2008
        CurrFieldNo := lCurrFieldNo;
        UpdateCharges(FIELDNO("Entry Type"),(CurrFieldNo = FIELDNO("Entry Type")));
        // >>DITW15.00.00.24 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Source No."(Field 6)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.24 DDR 25/09/2008
        if "Source No." <> '' then begin
          case "Source Type" of
            "Source Type"::Customer:
              begin
                rCust.GET("Source No.");
                // <<DITW15.00.00.30 DDR 19/01/2009
                "Source DTax Group Code" := rCust."Customer DTax Group Code";
                "Source Deposit Group Code" := rCust."Customer DDeposit Group Code";
                // >>DITW15.00.00.30 DDR
              end;
            "Source Type"::Vendor:
              begin
                rVendor.GET("Source No.");
                // <<DITW15.00.00.30 DDR 19/01/2009
                "Source DTax Group Code" := rVendor."Vendor DTax Group Code";
                "Source Deposit Group Code" := rVendor."Vendor DDeposit Group Code";
                // >>DITW15.00.00.30 DDR
              end;
            "Source Type"::Item:
              begin
                Item.GET("Source No.");
              end;
            end;
        end else begin
          // <<DITW15.00.00.37 DDR 20/01/2010
          CLEAR("Source DTax Group Code");
          CLEAR("Source Deposit Group Code");
          // >>DITW15.00.00.37 DDR
        end;
        // >>DITW15.00.00.24 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Document No."(Field 7)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.25 DDR 24/10/2008
        TESTFIELD("Attached to Line No.",0);
        TESTFIELD("Is Item Charge",false);
        UpdateCharges(FIELDNO("Document No."),(CurrFieldNo = FIELDNO("Document No.")));
        // >>DITW15.00.00.25 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Field 9).OnValidate". Please convert manually.

        //trigger (Variable: lCurrFieldNo)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Field 9).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Entry Type" <= "Entry Type"::Transfer THEN
          TESTFIELD("Item No.");

        IF ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND
           ("Item Charge No." = '') AND
           ("No." = '')
        THEN BEGIN
          GetUnitAmount(FIELDNO("Location Code"));
          "Unit Cost" := UnitCost;
          VALIDATE("Unit Amount");
          CheckItemAvailable(FIELDNO("Location Code"));
        end;

        IF "Entry Type" IN ["Entry Type"::Consumption,"Entry Type"::Output] THEN
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        IF "Location Code" <> xRec."Location Code" THEN BEGIN
          "Bin Code" := '';
          IF CurrFieldNo <> 0 THEN
            WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION("Location Code"));
          IF ("Location Code" <> '') AND ("Item No." <> '') THEN BEGIN
            GetLocation("Location Code");
            IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
              WMSManagement.GetDefaultBin("Item No.","Variant Code","Location Code","Bin Code");
          end;
          IF "Entry Type" = "Entry Type"::Transfer THEN BEGIN
            "New Location Code" := "Location Code";
            "New Bin Code" := "Bin Code";
          end;
        end;

        VALIDATE("Unit of Measure Code");

        ReserveItemJnlLine.VerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1189
        if ("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> xRec."Location Code") and
          ("Location Code" <> '')
        then begin
          Location.GET("Location Code");
          VALIDATE("Responsibility Center",
            UserSetupMgt.GetFirstRespCenter(EntryTypeToRespID,Location."Physical Location Group Code","Location Code"));
        end;
        // >>DITW18.00.06 DDR DIT-770 #1189

        // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
        if (("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> '')) or
          ("Responsibility Center" <> xRec."Responsibility Center")
        then
          if not UserSetupMgt.CheckLocation(EntryTypeToRespID,"Location Code","Responsibility Center") then
            ERROR(
              Text2014414,
              Location.TABLECAPTION,"Location Code",
              RespCenter.TABLECAPTION,GetRespCenterCode);
        // >>DITW18.00.06 DDR DIT-770 #1189

        if "Entry Type" <= "Entry Type"::Transfer then
          TESTFIELD("Item No.");

        if ("Value Entry Type" = "Value Entry Type"::"Direct Cost") and
           ("Item Charge No." = '') and
           ("No." = '')
        then begin
        #8..11
        end;

        if "Entry Type" in ["Entry Type"::Consumption,"Entry Type"::Output] then
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        if "Location Code" <> xRec."Location Code" then begin
          "Bin Code" := '';

          // <<DITW15.00.00.37 DDR 20/01/2010
          "Location Group Code" := '';
          GetCompanyInfoSetup();
          "Company Tax Registration No." := rCompanyInfo."Tax Registration No.";
          // >>DITW15.00.00.37 DDR

          // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
          if "Location Code" <> '' then begin
            GetLocation("Location Code");
            if Location."Physical Location Group Code" <> "Physical Location Group Code" then
              "Physical Location Group Code" := Location."Physical Location Group Code";
          end;
          if xRec."Physical Location Group Code" = "Physical Location Group Code" then
            VALIDATE("Physical Location Group Code");
          // >>DITW18.00.06 DDR DIT-770 #1189

          if CurrFieldNo <> 0 then
            WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION("Location Code"));
          if ("Location Code" <> '') and ("Item No." <> '') then begin
            GetLocation("Location Code");
            // <<DITW15.00.00.37 DDR 20/01/2010
            "Location Group Code" := Location."Location Group Code";
            if Location."Tax Registration No." <> '' then
              "Company Tax Registration No." := Location."Tax Registration No.";
            // >>DITW15.00.00.37 DDR
            // << HEI.12
            if Location."Bin Mandatory" and not Location."Directed Put-away and Pick" then begin
              if "Entry Type" in ["Entry Type"::Sale,"Entry Type"::Purchase] then
                 WMSManagement.GetDefaultBin("Item No.","Variant Code","Location Code","Bin Code")
              else begin
                if "Source Code" = 'ITEMJNL' then begin
                  if "Entry Type" = "Entry Type"::"Positive Adjmt." then
                   "Bin Code" := Location."From-Production Bin Code"
                   else
                   "Bin Code" := Location."To-Production Bin Code";
                end;
               end;
              end;
              //>>  HEI.12
          end;
          if "Entry Type" = "Entry Type"::Transfer then begin
            "New Location Code" := "Location Code";
            "New Bin Code" := "Bin Code";
            // <<DITW15.00.00.37 DDR 20/05/2010
            "New Location Group Code" := "Location Group Code";
            "New Phys. Location Group Code" := "Physical Location Group Code";
            // >>DITW15.00.00.37 DDR
          end;
          //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
          if rStockkeepingUnit.GET("Location Code","Item No.","Variant Code") then begin
            "Indirect Cost %" := rStockkeepingUnit."Indirect Cost %";
            "Overhead Rate" := rStockkeepingUnit."Overhead Rate";
          end;
          //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
          // <<DITW110.00.09 DDR 05/04/2017 NRQ#16737
          if CurrFieldNo <> 0 then
            "Relation Location Code" := '';
          // >>DITW110.00.09 DDR NRQ#16737
        end;

        //<< DITW19.00.08A VSC 23/12/2016 BL#10443
        ValidateReverse;
        //>> DITW19.00.08A VSC BL#10443
        // <<DITW15.00.00.30 DDR 09/01/2009
        if "Entry Type" = "Entry Type"::Transfer then
          cduItemJnlCheckLine.CheckCombLocationBins(Rec);
        // >>DITW15.00.00.30 DDR

        // << DITW110.00.11 SFI 30/08/2017 BL#14417
        "Deposit Value" := RetrieveDepositValue();
        // >> DITW110.00.11 SFI BL#14417
        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        GetItem();
        Item.BlockedSKU("Location Code","Variant Code",true);
        if "New Location Code" <> '' then begin
          GetItem();
          Item.BlockedSKU("New Location Code","Variant Code",true);
        end;
        // >> DITW110.00.11 SFI BL#30569
        VALIDATE("Unit of Measure Code");

        // <<DITW15.00.00.24 DDR 25/09/2008 (Nav client lost currfieldno after called function ReserveItemJnlLine())
        lCurrFieldNo := CurrFieldNo;
        // >>DITW15.00.00.24 DDR

        ReserveItemJnlLine.VerifyChange(Rec,xRec);

        // <<DITW15.00.00.37 DDR 29/01/2010
        UpdateAADInfo();
        // >>DITW15.00.00.37 DDR

        // <<DITW15.00.00.24 DDR 25/09/2008 - DITW15.00.00.25 DDR 30/10/2008
        CurrFieldNo := lCurrFieldNo;
        UpdateCharges(FIELDNO("Location Code"),(CurrFieldNo = FIELDNO("Location Code")));
        UpdateAmount();
        // >>DITW15.00.00.25 DDR
        WHSUTILS.OnLocationChangedItemJnlLine(Rec,xRec,CurrFieldNo);//HEI.01 PRDGAP024
        //HEI.24>>
        //>>DITW111.00.13A ISL 07/05/2019 NRQ#110425
        if ("Line No." <> 0) and (("Order Type" <> "Order Type"::Production) or ("Order No." = '')) then begin
        //<<DITW111.00.13A ISL 07/05/2019 NRQ#110425
          CreateDim(
            DATABASE::Item,"Item No.",
            DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
            DATABASE::"Work Center","Work Center No.",
            DATABASE::"Item Charge","Item Charge No.",
            // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
            DATABASE::Item,"Tax Item No.",
            //<<DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
            DATABASE::"Responsibility Center", "Responsibility Center");
          UpdateCCCfromBinCode;
        end;
        //HEI.24>>
        */
        //end;


        //Unsupported feature: CodeModification on "Quantity(Field 13).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Entry Type" <= "Entry Type"::Transfer) AND (Quantity <> 0) THEN
          TESTFIELD("Item No.");

        IF NOT PhysInvtEntered THEN
          TESTFIELD("Phys. Inventory",FALSE);

        CallWhseCheck :=
          ("Entry Type" = "Entry Type"::"Assembly Consumption") OR
          ("Entry Type" = "Entry Type"::Consumption) OR
          ("Entry Type" = "Entry Type"::Output) AND
          LastOutputOperation(Rec);
        IF CallWhseCheck THEN
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        IF CurrFieldNo <> 0 THEN
          WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION(Quantity));

        "Quantity (Base)" := CalcBaseQty(Quantity);
        IF ("Entry Type" = "Entry Type"::Output) AND
           ("Value Entry Type" <> "Value Entry Type"::Revaluation)
        THEN
          "Invoiced Quantity" := 0
        else
          "Invoiced Quantity" := Quantity;
        "Invoiced Qty. (Base)" := CalcBaseQty("Invoiced Quantity");

        GetUnitAmount(FIELDNO(Quantity));
        UpdateAmount;

        CheckItemAvailable(FIELDNO(Quantity));

        IF "Entry Type" = "Entry Type"::Transfer THEN BEGIN
          "Qty. (Calculated)" := 0;
          "Qty. (Phys. Inventory)" := 0;
          "Last Item Ledger Entry No." := 0;
        end;

        CALCFIELDS("Reserved Qty. (Base)");
        IF ABS("Quantity (Base)") < ABS("Reserved Qty. (Base)") THEN
          ERROR(Text001,FIELDCAPTION("Reserved Qty. (Base)"));

        IF Item."Item Tracking Code" <> '' THEN
          ReserveItemJnlLine.VerifyQuantity(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Entry Type" <= "Entry Type"::Transfer) and (Quantity <> 0) then
          TESTFIELD("Item No.");

        if not PhysInvtEntered then
          TESTFIELD("Phys. Inventory",false);

        CallWhseCheck :=
          ("Entry Type" = "Entry Type"::"Assembly Consumption") or
          ("Entry Type" = "Entry Type"::Consumption) or
          ("Entry Type" = "Entry Type"::Output) and
          LastOutputOperation(Rec);
        if CallWhseCheck then
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        if CurrFieldNo <> 0 then
          WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION(Quantity));

        // <<DITW15.00.00.24 DDR 25/09/2008
        if (ABS(Quantity) <> 1) and (CurrFieldNo <> 0) then
          case "Extra Charge Type" of
            "Extra Charge Type"::"Fixed Amount":
              if Quantity >= 0 then
                TESTFIELD(Quantity, 1)
              else
                TESTFIELD(Quantity, -1);
            "Extra Charge Type"::VolumeHL:
              begin
                if "Attached to Line No." <> 0 then begin
                  rFromItemJnlLine.GET("Journal Template Name","Journal Batch Name","Attached to Line No.");
                  rFromItemJnlLine.TESTFIELD("Unit Volume HL");
                  if Quantity >= 0 then
                    TESTFIELD(Quantity, rFromItemJnlLine."Unit Volume HL")
                  else
                    TESTFIELD(Quantity, -rFromItemJnlLine."Unit Volume HL");
                end;
              end;
          end;

        if (CurrFieldNo = FIELDNO(Quantity)) and
           (xRec.Quantity <> Quantity) and
           (Quantity <> 0) and
           ("Extra Charge Type" <> "Extra Charge Type"::" ") and
           ("Item Charge Type" <> "Item Charge Type"::Deposit) and
           ("Extra Charge Type" <> "Extra Charge Type"::"Fixed Amount")
          then
            TESTFIELD(Quantity, xRec.Quantity);
        // >>DITW15.00.00.24 DDR

        // <<DITW18.00.06 DDR 29/10/2015 DIT-770 #1412
        if "Tax Item No." = '' then
          VALIDATE("Packaging Type Code");
        // >>DITW18.00.06 DDR DIT-770 #1412

        // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        // <<DITW16.00.00.43 DDR 20/12/2013 DIT-715 #864
        if ((CurrFieldNo = FIELDNO(Quantity)) or (CurrFieldNo = FIELDNO("Output Quantity"))) and
        // >>DITW16.00.00.43 DDR DIT-715 #864
           (xRec.Quantity <> Quantity) and
           (Quantity = 0)
        then
          DeleteAllChargeJnlLines(Rec,true);
        // >>DITW16.00.00.43 DDR DIT-715 #768

        "Quantity (Base)" := CalcBaseQty(Quantity);
        if ("Entry Type" = "Entry Type"::Output) and
           ("Value Entry Type" <> "Value Entry Type"::Revaluation)
        then
          "Invoiced Quantity" := 0
        else
        #24..31
        if "Entry Type" = "Entry Type"::Transfer then begin
        #33..35
        end;

        CALCFIELDS("Reserved Qty. (Base)");
        if ABS("Quantity (Base)") < ABS("Reserved Qty. (Base)") then
          ERROR(Text001,FIELDCAPTION("Reserved Qty. (Base)"));

        // <<DITW15.00.00.24 DDR 25/09/2008 (Nav client lost currfieldno after called function ReserveItemJnlLine())
        lCurrFieldNo := CurrFieldNo;
        // >>DITW15.00.00.24 DDR

        if Item."Item Tracking Code" <> '' then
          ReserveItemJnlLine.VerifyQuantity(Rec,xRec);

        // <<DITW15.00.00.24 DDR 25/09/2008
        CurrFieldNo := lCurrFieldNo;

        // <<DITW19.00.08 DDR 17/08/2016 20/10/2016 BL#10443
        if ("Item Charge No." = '') or ("Tax Item No." <> '') then begin
          if BeverageSetup.READPERMISSION then begin
            "Quantity (Brewing Base)" := ROUND(Quantity * "Unit Volume HL",0.00001);
            if "Entry Type" = "Entry Type"::Transfer then
              "New Quantity (Brewing Base)" := ROUND(Quantity * "New Unit Volume HL",0.00001);
          end;
        end;
        // >>DITW19.00.08 DDR BL#10443

        // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768 - DDR 20/12/2013 DIT-715 #864
        if ((CurrFieldNo = FIELDNO(Quantity)) or (CurrFieldNo = FIELDNO("Output Quantity"))) and
          (xRec.Quantity <> Quantity) and
          (Quantity <> 0)
        then
          InsertCharges(CurrFieldNo);
        // >>DITW16.00.00.43 DDR DIT-715 #768

        UpdateCharges(FIELDNO(Quantity),(CurrFieldNo = FIELDNO(Quantity)));
        // >>DITW15.00.00.24 DDR

        //<< DITW19.00.08A VSC 05/01/2017 BL#10443
        ValidateReverse;
        //>> DITW19.00.08A VSC BL#10443
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit Amount"(Field 16).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdateAmount;
        IF "Item No." <> '' THEN BEGIN
          IF "Value Entry Type" = "Value Entry Type"::Revaluation THEN
            "Unit Cost" := "Unit Amount"
          else
            CASE "Entry Type" OF
              "Entry Type"::Purchase,
              "Entry Type"::"Positive Adjmt.",
              "Entry Type"::"Assembly Output":
                BEGIN
                  IF "Entry Type" = "Entry Type"::"Positive Adjmt." THEN BEGIN
                    GetItem;
                    IF (CurrFieldNo = FIELDNO("Unit Amount")) AND
                       (Item."Costing Method" = Item."Costing Method"::Standard)
                    THEN
                      ERROR(
                        Text002,
                        FIELDCAPTION("Unit Amount"),Item.FIELDCAPTION("Costing Method"),Item."Costing Method");
                  end;

                  ReadGLSetup;
                  IF "Entry Type" = "Entry Type"::Purchase THEN
                    "Unit Cost" := "Unit Amount";
                  IF "Entry Type" = "Entry Type"::"Positive Adjmt." THEN
                    "Unit Cost" :=
                      ROUND(
                        "Unit Amount" * (1 + "Indirect Cost %" / 100),GLSetup."Unit-Amount Rounding Precision") +
                      "Overhead Rate" * "Qty. per Unit of Measure";
                  IF ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND
                     ("Item Charge No." = '')
                  THEN
                    VALIDATE("Unit Cost");
                end;
              "Entry Type"::"Negative Adjmt.",
              "Entry Type"::Consumption,
              "Entry Type"::"Assembly Consumption":
                BEGIN
                  GetItem;
                  IF (CurrFieldNo = FIELDNO("Unit Amount")) AND
                     (Item."Costing Method" = Item."Costing Method"::Standard)
                  THEN
                    ERROR(
                      Text002,
                      FIELDCAPTION("Unit Amount"),Item.FIELDCAPTION("Costing Method"),Item."Costing Method");
                  "Unit Cost" := "Unit Amount";
                  IF ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND
                     ("Item Charge No." = '')
                  THEN
                    VALIDATE("Unit Cost");
                end;
            end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.35 DDR 26/06/2009
        if "Free Item" and (CurrFieldNo = FIELDNO("Unit Amount")) then
          TESTFIELD("Unit Amount",0);
        // >>DITW15.00.00.35 DDR

        UpdateAmount;
        if "Item No." <> '' then begin
          if "Value Entry Type" = "Value Entry Type"::Revaluation then
            "Unit Cost" := "Unit Amount"
          else
            case "Entry Type" of
        #7..9
                begin
                  if "Entry Type" = "Entry Type"::"Positive Adjmt." then begin
                    GetItem;
                    if (CurrFieldNo = FIELDNO("Unit Amount")) and
                       (Item."Costing Method" = Item."Costing Method"::Standard)
                    then
        #16..18
                  end;

                  ReadGLSetup;
                  if "Entry Type" = "Entry Type"::Purchase then
                    "Unit Cost" := "Unit Amount";
                  if "Entry Type" = "Entry Type"::"Positive Adjmt." then
        #25..28
                  if ("Value Entry Type" = "Value Entry Type"::"Direct Cost") and
                     ("Item Charge No." = '')
                  then
                    VALIDATE("Unit Cost");
                end;
        #34..36
                begin
                  GetItem;
                  if (CurrFieldNo = FIELDNO("Unit Amount")) and
                     (Item."Costing Method" = Item."Costing Method"::Standard)
                  then
        #42..45
                  if ("Value Entry Type" = "Value Entry Type"::"Direct Cost") and
                     ("Item Charge No." = '')
                  then
                    VALIDATE("Unit Cost");
                end;
            end;
        end;

        // <<DITW15.00.00.24 DDR 25/09/2008 - DITW15.00.00.34 DDR 12/06/2009
        if ("Extra Charge Type" <> "Extra Charge Type"::Amount) and
           ("Extra Charge Type" <> "Extra Charge Type"::"Fixed Amount") and
           ("Extra Charge Type" <> "Extra Charge Type"::VolumeHL) and
           ("Extra Charge Type" <> "Extra Charge Type"::"Price Item") and
           (CurrFieldNo = FIELDNO("Unit Amount")) and
           "Is Item Charge"
        then
          FIELDERROR("Extra Charge Type");

        if CurrFieldNo = FIELDNO("Unit Amount") then begin
          if not "Is Item Charge" then
            "Item Charge Value" := "Unit Amount";

          CheckNoItemChargeInclPrice(FIELDCAPTION("Unit Amount"));
        end;

        // <<DITW15.00.00.39 DDR 19/10/2011 #1363
        "Last Price Calculated Date" := "Posting Date";
        // >>DITW15.00.00.39 DDR #1363

        UpdateCharges(FIELDNO("Unit Amount"),(CurrFieldNo = FIELDNO("Unit Amount")));
        // >>DITW15.00.00.24 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit Cost"(Field 17).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Item No.");
        RetrieveCosts;
        IF "Entry Type" IN ["Entry Type"::Purchase,"Entry Type"::"Positive Adjmt.","Entry Type"::Consumption] THEN BEGIN
          IF Item."Costing Method" = Item."Costing Method"::Standard THEN BEGIN
            IF CurrFieldNo = FIELDNO("Unit Cost") THEN
              ERROR(
                Text002,
                FIELDCAPTION("Unit Cost"),Item.FIELDCAPTION("Costing Method"),Item."Costing Method");
            "Unit Cost" := ROUND(UnitCost * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
          end;
        end;

        IF ("Item Charge No." = '') AND
           ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND
           (CurrFieldNo = FIELDNO("Unit Cost"))
        THEN BEGIN
          CASE "Entry Type" OF
            "Entry Type"::Purchase:
              "Unit Amount" := "Unit Cost";
            "Entry Type"::"Positive Adjmt.",
            "Entry Type"::"Assembly Output":
              BEGIN
                ReadGLSetup;
                "Unit Amount" :=
                  ROUND(
                    ("Unit Cost" - "Overhead Rate" * "Qty. per Unit of Measure") / (1 + "Indirect Cost %" / 100),
                    GLSetup."Unit-Amount Rounding Precision")
              end;
            "Entry Type"::"Negative Adjmt.",
            "Entry Type"::Consumption,
            "Entry Type"::"Assembly Consumption":
              BEGIN
                IF Item."Costing Method" = Item."Costing Method"::Standard THEN
                  ERROR(
                    Text002,
                    FIELDCAPTION("Unit Cost"),Item.FIELDCAPTION("Costing Method"),Item."Costing Method");
                "Unit Amount" := "Unit Cost";
              end;
          end;
          UpdateAmount;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Item No.");
        RetrieveCosts;
        if "Entry Type" in ["Entry Type"::Purchase,"Entry Type"::"Positive Adjmt.","Entry Type"::Consumption] then begin
          if Item."Costing Method" = Item."Costing Method"::Standard then begin
            if CurrFieldNo = FIELDNO("Unit Cost") then
        #6..9
          end;
        end;

        if ("Item Charge No." = '') and
           ("Value Entry Type" = "Value Entry Type"::"Direct Cost") and
           (CurrFieldNo = FIELDNO("Unit Cost"))
        then begin
          case "Entry Type" of
        #18..21
              begin
        #23..27
              end;
        #29..31
              begin
                if Item."Costing Method" = Item."Costing Method"::Standard then
        #34..37
              end;
          end;
          UpdateAmount;
        end;

        // <<DITW15.00.00.24 DDR 25/09/2008
        if "Is Item Charge" and ("Item Charge No." <> '') and
           ("Value Entry Type" = "Value Entry Type"::"Direct Cost") and
           (CurrFieldNo = FIELDNO("Unit Cost"))
        then begin
          "Unit Amount" := 0;
           UpdateAmount;
        end;

        // <<DITW15.00.00.39 DDR 19/10/2011 #1363
        "Last Price Calculated Date" := "Posting Date";
        // >>DITW15.00.00.39 DDR #1363

        UpdateCharges(FIELDNO("Unit Cost"),(CurrFieldNo = FIELDNO("Unit Cost")));
        // >>DITW15.00.00.24 DDR
        */
        //end;


        //Unsupported feature: CodeModification on "Amount(Field 18).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Quantity);
        "Unit Amount" := Amount / Quantity;
        VALIDATE("Unit Amount");
        ReadGLSetup;
        "Unit Amount" := ROUND("Unit Amount",GLSetup."Unit-Amount Rounding Precision");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Quantity);
        // <<DITW15.00.00.35 DDR 26/06/2009
        if "Free Item" and (CurrFieldNo = FIELDNO(Amount)) then
          TESTFIELD(Amount,0);
        // >>DITW15.00.00.35 DDR

        // <<DITW15.00.00.24 DDR 25/09/2008
        if "Is Item Charge" and
           ("Item Charge No." <> '') and
           ("Item Charge Type" = "Item Charge Type"::Tax)
        then begin
          "Unit Cost" := Amount / Quantity;
          VALIDATE("Unit Cost");
        end else begin
        // >>DITW15.00.00.24 DDR
          "Unit Amount" := Amount / Quantity;
          VALIDATE("Unit Amount");
        // <<DITW15.00.00.24 DDR 25/09/2008
        end;
        // >>DITW15.00.00.24 DDR

        ReadGLSetup;
        "Unit Amount" := ROUND("Unit Amount",GLSetup."Unit-Amount Rounding Precision");

        // <<DITW15.00.00.24 DDR 25/09/2008
        "Unit Cost" := ROUND("Unit Cost",GLSetup."Unit-Amount Rounding Precision");

        UpdateAmount();
        UpdateCharges(FIELDNO(Amount),(CurrFieldNo = FIELDNO(Amount)));
        // >>DITW15.00.00.24 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Salespers./Purch. Code"(Field 23).OnValidate". Please convert manually.

        //trigger /Purch();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Order Type" <> "Order Type"::Production) OR ("Order No." = '') THEN
          CreateDim(
            DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
            DATABASE::Item,"Item No.",
            DATABASE::"Work Center","Work Center No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //IF ("Order Type" <> "Order Type"::Production) OR ("Order No." = '') THEN //HEI.24 commented
        if ("Order Type" <> "Order Type"::Production) or ("Order No." = '') then begin //HEI.24
        #2..4
            DATABASE::"Work Center","Work Center No.",
            DATABASE::"Item Charge","Item Charge No.",
            // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
            DATABASE::Item,"Tax Item No.",
            //<<DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
            DATABASE::"Responsibility Center", "Responsibility Center");
            //>>DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
            // >>DITW16.00.00.43 DDR DIT-715 #768
            // >>DITW15.00.00.24 DDR
          //HEI.24<<
          UpdateCCCfromBinCode; //HEI.24
        end;
         //HEI.24>>
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-to Entry"(Field 29).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SelectItemEntry(FIELDNO("Applies-to Entry"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SelectItemEntry(FIELDNO("Applies-to Entry"));
        // <<DITW15.00.00.25 DDR 24/10/2008
        TESTFIELD("Attached to Line No.",0);
        TESTFIELD("Is Item Charge",false);
        // >>DITW15.00.00.25 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-to Entry"(Field 29).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Applies-to Entry" <> 0 THEN BEGIN
          ItemLedgEntry.GET("Applies-to Entry");

          IF "Value Entry Type" = "Value Entry Type"::Revaluation THEN BEGIN
            IF "Inventory Value Per" <> "Inventory Value Per"::" " THEN
              ERROR(Text006,FIELDCAPTION("Applies-to Entry"));

            IF "Inventory Value Per" = "Inventory Value Per"::" " THEN
              IF NOT RevaluationPerEntryAllowed("Item No.") THEN
                ERROR(Text034);

            InitRevalJnlLine(ItemLedgEntry);
            ItemLedgEntry.TESTFIELD(Positive,TRUE);
          end else BEGIN
            TESTFIELD(Quantity);
            IF Signed(Quantity) * ItemLedgEntry.Quantity > 0 THEN BEGIN
              IF Quantity > 0 THEN
                FIELDERROR(Quantity,Text030);
              IF Quantity < 0 THEN
                FIELDERROR(Quantity,Text029);
            end;
            IF ItemLedgEntry.TrackingExists THEN
              ERROR(Text033,FIELDCAPTION("Applies-to Entry"),ItemTrackingLines.CAPTION);

            IF NOT ItemLedgEntry.Open THEN
              MESSAGE(Text032,"Applies-to Entry");

            IF "Entry Type" = "Entry Type"::Output THEN BEGIN
              ItemLedgEntry.TESTFIELD("Order Type","Order Type"::Production);
              ItemLedgEntry.TESTFIELD("Order No.","Order No.");
              ItemLedgEntry.TESTFIELD("Order Line No.","Order Line No.");
              ItemLedgEntry.TESTFIELD("Entry Type","Entry Type");
            end;
          end;

          "Location Code" := ItemLedgEntry."Location Code";
          "Variant Code" := ItemLedgEntry."Variant Code";
        end else BEGIN
          IF "Value Entry Type" = "Value Entry Type"::Revaluation THEN BEGIN
            VALIDATE("Unit Amount",0);
            VALIDATE(Quantity,0);
            "Inventory Value (Calculated)" := 0;
            "Inventory Value (Revalued)" := 0;
            "Location Code" := '';
            "Variant Code" := '';
            "Bin Code" := '';
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Applies-to Entry" <> 0 then begin
          ItemLedgEntry.GET("Applies-to Entry");
          // <<DITW15.00.00.25 DDR 24/10/2008
          if CurrFieldNo <> 0 then begin
            TESTFIELD("Attached to Line No.",0);
            TESTFIELD("Is Item Charge",false);
          end;
          // >>DITW15.00.00.25 DDR

          if "Value Entry Type" = "Value Entry Type"::Revaluation then begin
            if "Inventory Value Per" <> "Inventory Value Per"::" " then
              ERROR(Text006,FIELDCAPTION("Applies-to Entry"));

            if "Inventory Value Per" = "Inventory Value Per"::" " then
              if not RevaluationPerEntryAllowed("Item No.") then
        #10..12
            ItemLedgEntry.TESTFIELD(Positive,true);
          end else begin
            TESTFIELD(Quantity);
            if Signed(Quantity) * ItemLedgEntry.Quantity > 0 then begin
              if Quantity > 0 then
                FIELDERROR(Quantity,Text030);
              if Quantity < 0 then
                FIELDERROR(Quantity,Text029);
            end;
            if ItemLedgEntry.TrackingExists then
              ERROR(Text033,FIELDCAPTION("Applies-to Entry"),ItemTrackingLines.CAPTION);
            //>>HEI.29
            //IF NOT ItemLedgEntry.Open THEN
            if ((not ItemLedgEntry.Open) and (GUIALLOWED)) then
            //<<HEI.29

              MESSAGE(Text032,"Applies-to Entry");

            if "Entry Type" = "Entry Type"::Output then begin
        #29..32
            end;
          end;
        #35..37
          // <<DITW19.00.08 DDR 29/09/2016 BL#10443
          "Physical Location Group Code" := ItemLedgEntry."Physical Location Group Code";
          "Location Group Code" := ItemLedgEntry."Location Group Code";
          CalcStrengthFromEntry(ItemLedgEntry);
          // >>DITW19.00.08 DDR BL#10443
        end else begin
          if "Value Entry Type" = "Value Entry Type"::Revaluation then begin
        #40..46
            // <<DITW19.00.08 DDR 29/09/2016 BL#10443
            "Physical Location Group Code" := '';
            "Location Group Code" := '';
            VALIDATE("Unit Volume HL",0);
            "Unit Volume HL (Calculated)" := 0;
            "Unit Volume HL (Revalued)" := 0;
            "Strength Spec. Value (Calcd.)" := 0;
            "Strength Spec. Value (Reval.)" := 0;
            "Vol-Strength Value (Calcd.)" := 0;
            "Vol-Strength Value (Reval.)" := 0;
            // >>DITW19.00.08 DDR BL#10443
          end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Indirect Cost %"(Field 37).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Item No.");
        TESTFIELD("Value Entry Type","Value Entry Type"::"Direct Cost");
        TESTFIELD("Item Charge No.",'');
        IF "Entry Type" IN ["Entry Type"::Sale,"Entry Type"::"Negative Adjmt."] THEN
          ERROR(
            Text002,
            FIELDCAPTION("Indirect Cost %"),FIELDCAPTION("Entry Type"),"Entry Type");

        GetItem;
        IF Item."Costing Method" = Item."Costing Method"::Standard THEN
          ERROR(
            Text002,
            FIELDCAPTION("Indirect Cost %"),Item.FIELDCAPTION("Costing Method"),Item."Costing Method");

        IF "Entry Type" <> "Entry Type"::Purchase THEN
          "Unit Cost" :=
            ROUND(
              "Unit Amount" * (1 + "Indirect Cost %" / 100) +
              "Overhead Rate" * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if "Entry Type" in ["Entry Type"::Sale,"Entry Type"::"Negative Adjmt."] then
        #5..9
        if Item."Costing Method" = Item."Costing Method"::Standard then
        #11..14
        if "Entry Type" <> "Entry Type"::Purchase then
        #16..19
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Reason Code"(Field 42)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW17.00.02 DDR 24/05/2013 DIT-770 #99 - 28/08/2013 DIT-770 #178
        UpdateCharges(FIELDNO("Reason Code"),true);
        // >>DITW17.00.02 DDR DIT-770 #99
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Drop Shipment"(Field 46)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.24 DDR 25/09/2008
        UpdateCharges(FIELDNO("Drop Shipment"),true);
        // >>DITW15.00.00.24 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on ""New Location Code"(Field 50).OnValidate". Please convert manually.

        //trigger (Variable: lCurrFieldNo)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""New Location Code"(Field 50).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Entry Type","Entry Type"::Transfer);
        IF "New Location Code" <> xRec."New Location Code" THEN BEGIN
          "New Bin Code" := '';
          IF ("New Location Code" <> '') AND ("Item No." <> '') THEN BEGIN
            GetLocation("New Location Code");
            IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
              WMSManagement.GetDefaultBin("Item No.","Variant Code","New Location Code","New Bin Code")
          end;
        end;

        ReserveItemJnlLine.VerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Entry Type","Entry Type"::Transfer);
        if "New Location Code" <> xRec."New Location Code" then begin
          "New Bin Code" := '';
          if ("New Location Code" <> '') and ("Item No." <> '') then begin
            GetLocation("New Location Code");
            // <<DITW15.00.00.37 DDR 20/01/2010 - 20/05/2010
            "New Phys. Location Group Code" := Location."Physical Location Group Code";
            "New Location Group Code" := Location."Location Group Code";
            // >>DITW15.00.00.37 DDR
            if Location."Bin Mandatory" and not Location."Directed Put-away and Pick" then
              WMSManagement.GetDefaultBin("Item No.","Variant Code","New Location Code","New Bin Code")
          end;
        end;

        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        if "New Location Code" <> '' then begin
          GetItem();
          Item.BlockedSKU("New Location Code","Variant Code",true);
        end;
        // >> DITW110.00.11 SFI BL#30569

        // <<DITW15.00.00.30 DDR 09/01/2009
        if "Entry Type" = "Entry Type"::Transfer then
          cduItemJnlCheckLine.CheckCombLocationBins(Rec);
        // >>DITW15.00.00.30 DDR

        // <<DITW15.00.00.24 DDR 25/09/2008 (Nav client lost currfieldno after called function ReserveItemJnlLine())
        lCurrFieldNo := CurrFieldNo;
        // >>DITW15.00.00.24 DDR

        ReserveItemJnlLine.VerifyChange(Rec,xRec);

        // <<DITW15.00.00.38 DDR 22/12/2010 #1217 (DIT711 103)
        UpdateAADInfo();
        // >>DITW15.00.00.38 DDR #1217 (DIT711 103)

        // <<DITW15.00.00.24 DDR 25/09/2008 - DITW15.00.00.25 DDR 30/10/2008
        CurrFieldNo := lCurrFieldNo;
        UpdateCharges(FIELDNO("New Location Code"),(CurrFieldNo = FIELDNO("New Location Code")));
        UpdateAmount();
        // >>DITW15.00.00.25 DDR
        //<< DITW19.00.08A VSC 23/12/2016 BL#10443
        ValidateReverse;
        //>> DITW19.00.08A VSC BL#10443
        */
        //end;


        //Unsupported feature: CodeModification on ""Qty. (Phys. Inventory)"(Field 54).OnValidate". Please convert manually.

        //trigger  (Phys();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Phys. Inventory",TRUE);

        IF CurrFieldNo <> 0 THEN
          WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION("Qty. (Phys. Inventory)"));

        PhysInvtEntered := TRUE;
        Quantity := 0;
        IF "Qty. (Phys. Inventory)" >= "Qty. (Calculated)" THEN BEGIN
          VALIDATE("Entry Type","Entry Type"::"Positive Adjmt.");
          VALIDATE(Quantity,"Qty. (Phys. Inventory)" - "Qty. (Calculated)");
        end else BEGIN
          VALIDATE("Entry Type","Entry Type"::"Negative Adjmt.");
          VALIDATE(Quantity,"Qty. (Calculated)" - "Qty. (Phys. Inventory)");
        end;
        PhysInvtEntered := FALSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Phys. Inventory",true);

        if CurrFieldNo <> 0 then
          WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION("Qty. (Phys. Inventory)"));

        PhysInvtEntered := true;
        Quantity := 0;
        if "Qty. (Phys. Inventory)" >= "Qty. (Calculated)" then begin
          VALIDATE("Entry Type","Entry Type"::"Positive Adjmt.");
          VALIDATE(Quantity,"Qty. (Phys. Inventory)" - "Qty. (Calculated)");
          //<< HEI.19
          // Assumption conversion in BUoM and Inv. UoM is positive
          GetItem;
          "Qty. (Phys. Inv.) in Inv. UoM" := UOMMgt.CalcQtyFromBase("Qty. (Phys. Inventory)",UOMMgt.GetQtyPerUnitOfMeasure(Item,"Invent. Unit of Measure Code"));
          VALIDATE("Quantity in Inv. UoM","Qty. (Phys. Inv.) in Inv. UoM" - "Qty. (Calculated) in Inv. UoM");
          //>> HEI.19
        end else begin
          VALIDATE("Entry Type","Entry Type"::"Negative Adjmt.");
          VALIDATE(Quantity,"Qty. (Calculated)" - "Qty. (Phys. Inventory)");
          //<< HEI.19
          // Assumption conversion in BUoM and Inv. UoM is positive
          GetItem;
          "Qty. (Phys. Inv.) in Inv. UoM" := UOMMgt.CalcQtyFromBase("Qty. (Phys. Inventory)",UOMMgt.GetQtyPerUnitOfMeasure(Item,"Invent. Unit of Measure Code"));
          VALIDATE("Quantity in Inv. UoM","Qty. (Calculated) in Inv. UoM" - "Qty. (Phys. Inv.) in Inv. UoM");
          //>> HEI.19
        end;

        // <<DITW15.00.00.24 DDR 25/09/2008
        if xRec."Entry Type" <> "Entry Type" then
          InsertCharges(FIELDNO("Entry Type"));

        UpdateCharges(FIELDNO("Qty. (Phys. Inventory)"),(CurrFieldNo = FIELDNO("Qty. (Phys. Inventory)")));
        // >>DITW15.00.00.24 DDR

        //HEI.20>>
        RoundOffPhysInvQty;
        //HEI.20<<

        PhysInvtEntered := false;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Gen. Prod. Posting Group"(Field 58)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW18.00.07 DDR 28/02/2016 DIT-770 #1836
        UpdateCharges(FIELDNO("Gen. Prod. Posting Group"),true);
        // >>DITW18.00.07 DDR DIT-770 #1836
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Document Date"(Field 60)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.25 DDR 24/10/2008
        UpdateCharges(FIELDNO("Document Date"),(CurrFieldNo = FIELDNO("Document Date")));
        // >>DITW15.00.00.25 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Order Type"(Field 90).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Order Type" = xRec."Order Type" THEN
          EXIT;
        VALIDATE("Order No.",'');
        "Order Line No." := 0;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Order Type" = xRec."Order Type" then
          exit;
        VALIDATE("Order No.",'');
        "Order Line No." := 0;
        */
        //end;


        //Unsupported feature: CodeModification on ""Order No."(Field 91).OnValidate". Please convert manually.

        //trigger "(Field 91)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CASE "Order Type" OF
          "Order Type"::Production,"Order Type"::Assembly:
            BEGIN
              IF "Order No." = '' THEN BEGIN
                CASE "Order Type" OF
                  "Order Type"::Production:
                    CreateProdDim;
                  "Order Type"::Assembly:
                    CreateAssemblyDim;
                end;
                EXIT;
              end;

              CASE "Order Type" OF
                "Order Type"::Production:
                  BEGIN
                    GetMfgSetup;
                    IF MfgSetup."Doc. No. Is Prod. Order No." THEN
                      "Document No." := "Order No.";
                    ProdOrder.GET(ProdOrder.Status::Released,"Order No.");
                    ProdOrder.TESTFIELD(Blocked,FALSE);
                    Description := ProdOrder.Description;
                  end;
                "Order Type"::Assembly:
                  BEGIN
                    AssemblyHeader.GET(AssemblyHeader."Document Type"::Order,"Order No.");
                    Description := AssemblyHeader.Description;
                  end;
              end;

              "Gen. Bus. Posting Group" := '';
              CASE TRUE OF
                "Entry Type" = "Entry Type"::Output:
                  BEGIN
                    "Inventory Posting Group" := ProdOrder."Inventory Posting Group";
                    "Gen. Prod. Posting Group" := ProdOrder."Gen. Prod. Posting Group";
                  end;
                "Entry Type" = "Entry Type"::"Assembly Output":
                  BEGIN
                    "Inventory Posting Group" := AssemblyHeader."Inventory Posting Group";
                    "Gen. Prod. Posting Group" := AssemblyHeader."Gen. Prod. Posting Group";
                  end;
                "Entry Type" = "Entry Type"::Consumption:
                  BEGIN
                    ProdOrderLine.SetFilterByReleasedOrderNo("Order No.");
                    IF ProdOrderLine.COUNT = 1 THEN BEGIN
                      ProdOrderLine.FINDFIRST;
                      VALIDATE("Order Line No.",ProdOrderLine."Line No.");
                    end;
                  end;
              end;

              IF ("Order No." <> xRec."Order No.") OR ("Order Type" <> xRec."Order Type") THEN
                CASE "Order Type" OF
                  "Order Type"::Production:
                    CreateProdDim;
                  "Order Type"::Assembly:
                    CreateAssemblyDim;
                end;
            end;
          "Order Type"::Transfer,"Order Type"::Service,"Order Type"::" ":
            ERROR(Text002,FIELDCAPTION("Order No."),FIELDCAPTION("Order Type"),"Order Type");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        case "Order Type" of
          "Order Type"::Production,"Order Type"::Assembly:
            begin
              if "Order No." = '' then begin
                case "Order Type" of
        #6..9
                end;
                exit;
              end;

              case "Order Type" of
                "Order Type"::Production:
                  begin
                    GetMfgSetup;
                    if MfgSetup."Doc. No. Is Prod. Order No." then
                      "Document No." := "Order No.";
                    ProdOrder.GET(ProdOrder.Status::Released,"Order No.");
                    ProdOrder.TESTFIELD(Blocked,false);
                    Description := ProdOrder.Description;
                  end;
                "Order Type"::Assembly:
                  begin
                    AssemblyHeader.GET(AssemblyHeader."Document Type"::Order,"Order No.");
                    Description := AssemblyHeader.Description;
                  end;
              end;

              "Gen. Bus. Posting Group" := '';
              case true of
                "Entry Type" = "Entry Type"::Output:
                  begin
                    "Inventory Posting Group" := ProdOrder."Inventory Posting Group";
                    "Gen. Prod. Posting Group" := ProdOrder."Gen. Prod. Posting Group";
                    // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
                    "Gyle No." := ProdOrder."Gyle No.";
                    // >>DITW15.00.00.22 PRODW14.00.00.08 DDR
                  end;
                "Entry Type" = "Entry Type"::"Assembly Output":
                  begin
                    "Inventory Posting Group" := AssemblyHeader."Inventory Posting Group";
                    "Gen. Prod. Posting Group" := AssemblyHeader."Gen. Prod. Posting Group";
                  end;
                "Entry Type" = "Entry Type"::Consumption:
                  begin
                    ProdOrderLine.SetFilterByReleasedOrderNo("Order No.");
                    if ProdOrderLine.COUNT = 1 then begin
                      ProdOrderLine.FINDFIRST;
                      VALIDATE("Order Line No.",ProdOrderLine."Line No.");
                    end;
                  end;
              end;

              if ("Order No." <> xRec."Order No.") or ("Order Type" <> xRec."Order Type") then
                case "Order Type" of
        #55..58
                end;
            end;
          "Order Type"::Transfer,"Order Type"::Service,"Order Type"::" ":
            ERROR(Text002,FIELDCAPTION("Order No."),FIELDCAPTION("Order Type"),"Order Type");
        end;
        // <<DITW15.00.00.37 DDR 19/01/2010 -- DITW17.00.01 DDR 13/02/2013 DIT-770 #001
        UpdateCharges(FIELDNO("Order No."),(CurrFieldNo = FIELDNO("Order No.")));
        // >>DITW15.00.00.37 DDR -DITW17.00.01 DDR DIT-770 #001
        */
        //end;


        //Unsupported feature: CodeModification on ""Order Line No."(Field 92).OnValidate". Please convert manually.

        //trigger "(Field 92)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Order No.");
        CASE "Order Type" OF
          "Order Type"::Production,"Order Type"::Assembly:
            BEGIN
              IF "Order Type" = "Order Type"::Production THEN BEGIN
                ProdOrderLine.SetFilterByReleasedOrderNo("Order No.");
                ProdOrderLine.SETRANGE("Line No.","Order Line No.");
                IF ProdOrderLine.FINDFIRST THEN BEGIN
                  "Source Type" := "Source Type"::Item;
                  "Source No." := ProdOrderLine."Item No.";
                  "Order Line No." := ProdOrderLine."Line No.";
                  "Routing No." := ProdOrderLine."Routing No.";
                  "Routing Reference No." := ProdOrderLine."Routing Reference No.";
                  IF "Entry Type" = "Entry Type"::Output THEN BEGIN
                    "Location Code" := ProdOrderLine."Location Code";
                    "Bin Code" := ProdOrderLine."Bin Code";
                  end;
                end;
              end;

              IF "Order Line No." <> xRec."Order Line No." THEN
                CASE "Order Type" OF
                  "Order Type"::Production:
                    CreateProdDim;
                  "Order Type"::Assembly:
                    CreateAssemblyDim;
                end;
            end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Order No.");
        case "Order Type" of
          "Order Type"::Production,"Order Type"::Assembly:
            begin
              if "Order Type" = "Order Type"::Production then begin
                ProdOrderLine.SetFilterByReleasedOrderNo("Order No.");
                ProdOrderLine.SETRANGE("Line No.","Order Line No.");
                if ProdOrderLine.FINDFIRST then begin
        #9..13
                  if "Entry Type" = "Entry Type"::Output then begin
                    "Location Code" := ProdOrderLine."Location Code";
                    //HEI.01 PRDGAP024>>
                    if ProdOrderLine."Bin Code" <> '' then begin
                      Bin.GET("Location Code",ProdOrderLine."Bin Code");
                      "Zone Code" := Bin."Zone Code";
                    end;
                    //HEI.01 PRDGAP024<<
                    "Bin Code" := ProdOrderLine."Bin Code";
                  end;
                end;
              end;

              if "Order Line No." <> xRec."Order Line No." then
                case "Order Type" of
        #23..26
                end;
            end;
        end;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Variant Code"(Field 5402).OnValidate". Please convert manually.

        //trigger (Variable: lCurrFieldNo)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Variant Code"(Field 5402).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Entry Type" IN ["Entry Type"::Consumption,"Entry Type"::Output] THEN
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        IF "Variant Code" <> xRec."Variant Code" THEN BEGIN
          "Bin Code" := '';
          IF CurrFieldNo <> 0 THEN
            WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION("Variant Code"));
          IF ("Location Code" <> '') AND ("Item No." <> '') THEN BEGIN
            GetLocation("Location Code");
            IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
              WMSManagement.GetDefaultBin("Item No.","Variant Code","Location Code","Bin Code")
          end;
          IF ("Entry Type" = "Entry Type"::Transfer) AND ("Location Code" = "New Location Code") THEN
            "New Bin Code" := "Bin Code";
        end;
        IF ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND
           ("Item Charge No." = '')
        THEN BEGIN
          GetUnitAmount(FIELDNO("Variant Code"));
          "Unit Cost" := UnitCost;
          VALIDATE("Unit Amount");
          VALIDATE("Unit of Measure Code");
          ReserveItemJnlLine.VerifyChange(Rec,xRec);
        end;

        IF "Variant Code" <> '' THEN BEGIN
          ItemVariant.GET("Item No.","Variant Code");
          Description := ItemVariant.Description;
        end else BEGIN
          GetItem;
          Description := Item.Description;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Entry Type" in ["Entry Type"::Consumption,"Entry Type"::Output] then
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        if "Variant Code" <> xRec."Variant Code" then begin
          "Bin Code" := '';
          if CurrFieldNo <> 0 then
            WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION("Variant Code"));
          if ("Location Code" <> '') and ("Item No." <> '') then begin
            GetLocation("Location Code");
            // <<DITW15.00.00.37 DDR 20/01/2010
            "Physical Location Group Code" := Location."Physical Location Group Code";
            "Location Group Code" := Location."Location Group Code";
            // >>DITW15.00.00.37 DDR
            if Location."Bin Mandatory" and not Location."Directed Put-away and Pick" then
              WMSManagement.GetDefaultBin("Item No.","Variant Code","Location Code","Bin Code");
            //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
            if rStockkeepingUnit.GET("Location Code","Item No.","Variant Code") then begin
              "Indirect Cost %" := rStockkeepingUnit."Indirect Cost %";
              "Overhead Rate" := rStockkeepingUnit."Overhead Rate";
            end;
            //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185

          end;
          if ("Entry Type" = "Entry Type"::Transfer) and ("Location Code" = "New Location Code") then
            "New Bin Code" := "Bin Code";
        end;
        if ("Value Entry Type" = "Value Entry Type"::"Direct Cost") and
           ("Item Charge No." = '')
        then begin
        #19..22

          // <<DITW15.00.00.24 DDR 25/09/2008 (Nav client lost currfieldno after called VerifyChange())
          lCurrFieldNo := CurrFieldNo;
          // >>DITW15.00.00.24 DDR
          ReserveItemJnlLine.VerifyChange(Rec,xRec);
          // <<DITW15.00.00.24 DDR 25/09/2008
          CurrFieldNo := lCurrFieldNo;
          // >>DITW15.00.00.24 DDR
        end;

        // << DITW110.00.11 SFI 30/08/2017 BL#14417
        "Deposit Value" := RetrieveDepositValue();
        // >> DITW110.00.11 SFI BL#14417
        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        GetItem();
        Item.BlockedSKU("Location Code","Variant Code",true);
        // >> DITW110.00.11 SFI BL#30569
        // <<DITW15.00.00.24 DDR 25/09/2008
        UpdateCharges(FIELDNO("Variant Code"),(CurrFieldNo = FIELDNO("Variant Code")));
        // >>DITW15.00.00.24 DDR

        if "Variant Code" <> '' then begin
          ItemVariant.GET("Item No.","Variant Code");
          Description := ItemVariant.Description;
        end else begin
          GetItem;
          Description := Item.Description;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 5403).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bin Code" <> xRec."Bin Code" THEN BEGIN
          TESTFIELD("Location Code");
          IF "Bin Code" <> '' THEN BEGIN
            GetBin("Location Code","Bin Code");
            GetLocation("Location Code");
            Location.TESTFIELD("Bin Mandatory");
            IF CurrFieldNo <> 0 THEN
              WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION("Bin Code"));
            TESTFIELD("Location Code",Bin."Location Code");
            WhseIntegrationMgt.CheckBinTypeCode(DATABASE::"Item Journal Line",
              FIELDCAPTION("Bin Code"),
              "Location Code",
              "Bin Code",
              "Entry Type");
          end;
          IF ("Entry Type" = "Entry Type"::Transfer) AND ("Location Code" = "New Location Code") THEN
            "New Bin Code" := "Bin Code";

          IF ("Entry Type" = "Entry Type"::Consumption) AND
             ("Bin Code" <> '') AND ("Prod. Order Comp. Line No." <> 0)
          THEN BEGIN
            TESTFIELD("Order Type","Order Type"::Production);
            TESTFIELD("Order No.");
            ProdOrderComp.GET(ProdOrderComp.Status::Released,"Order No.","Order Line No.","Prod. Order Comp. Line No.");
            IF (ProdOrderComp."Bin Code" <> '') AND (ProdOrderComp."Bin Code" <> "Bin Code") THEN
              IF NOT CONFIRM(
                   Text021,
                   FALSE,
                   "Bin Code",
                   ProdOrderComp."Bin Code",
                   "Order No.")
              THEN
                ERROR(Text012);
          end;
        end;

        ReserveItemJnlLine.VerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bin Code" <> xRec."Bin Code" then begin
          TESTFIELD("Location Code");
          if "Bin Code" <> '' then begin
        #4..6
            if CurrFieldNo <> 0 then
              WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION("Bin Code"));
            TESTFIELD("Location Code",Bin."Location Code");
            // <<DITW15.00.00.37 DDR 20/01/2010
            "Physical Location Group Code" := Location."Physical Location Group Code";
            "Location Group Code" := Location."Location Group Code";
            // >>DITW15.00.00.37 DDR
        #10..14
          end;

        //HEI.16>>
         // IF ("Entry Type" = "Entry Type"::Transfer) AND ("Location Code" = "New Location Code") THEN
          //  "New Bin Code" := "Bin Code";
        //HEI.16<<

          if ("Entry Type" = "Entry Type"::Consumption) and
             ("Bin Code" <> '') and ("Prod. Order Comp. Line No." <> 0)
          then begin
        #22..24
            //>>HEI.29
            //IF (ProdOrderComp."Bin Code" <> '') AND (ProdOrderComp."Bin Code" <> "Bin Code") THEN
            if (ProdOrderComp."Bin Code" <> '') and (ProdOrderComp."Bin Code" <> "Bin Code") and (GUIALLOWED) then
            //<<HEI.29
              if not CONFIRM(
                   Text021,
                   false,
        #29..31
              then
                ERROR(Text012);
          end;
        end;

        // <<DITW15.00.00.30 DDR 09/01/2009
        cduItemJnlCheckLine.CheckCombLocationBins(Rec);
        // >>DITW15.00.00.30 DDR

        // <<DITW15.00.00.24 DDR 25/09/2008 (Nav client lost currfieldno after called VerifyChange())
        lCurrFieldNo := CurrFieldNo;
        // >>DITW15.00.00.24 DDR

        ReserveItemJnlLine.VerifyChange(Rec,xRec);

        // <<DITW15.00.00.24 DDR 25/09/2008 - DITW15.00.00.25 DDR 27/10/2008
        CurrFieldNo := lCurrFieldNo;
        UpdateCharges(FIELDNO("Bin Code"),(CurrFieldNo <> 0));
        // >>DITW15.00.00.25 DDR
        WHSUTILS.OnAfterValidateItemJournalLineBinCode(Rec,xRec,CurrFieldNo);//HEI.01 PRDGAP024 single line

        //HEI.24>>
        //>>DITW111.00.13A ISL 07/05/2019 NRQ#110425
        if ("Line No." <> 0) and (("Order Type" <> "Order Type"::Production) or ("Order No." = '')) then begin
        //<<DITW111.00.13A ISL 07/05/2019 NRQ#110425
          CreateDim(
            DATABASE::Item,"Item No.",
            DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
            DATABASE::"Work Center","Work Center No.",
            DATABASE::"Item Charge","Item Charge No.",
            // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
            DATABASE::Item,"Tax Item No.",
            //<<DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
            DATABASE::"Responsibility Center", "Responsibility Center");
          UpdateCCCfromBinCode;
        end;
        //HEI.24>>
        */
        //end;


        //Unsupported feature: CodeModification on ""New Bin Code"(Field 5406).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Entry Type","Entry Type"::Transfer);
        IF "New Bin Code" <> xRec."New Bin Code" THEN BEGIN
          TESTFIELD("New Location Code");
          IF "New Bin Code" <> '' THEN BEGIN
            GetBin("New Location Code","New Bin Code");
            GetLocation("New Location Code");
            Location.TESTFIELD("Bin Mandatory");
            IF CurrFieldNo <> 0 THEN
              WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION("New Bin Code"));
            TESTFIELD("New Location Code",Bin."Location Code");
            WhseIntegrationMgt.CheckBinTypeCode(DATABASE::"Item Journal Line",
              FIELDCAPTION("New Bin Code"),
              "New Location Code",
              "New Bin Code",
              "Entry Type");
          end;
        end;

        ReserveItemJnlLine.VerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Entry Type","Entry Type"::Transfer);
        if "New Bin Code" <> xRec."New Bin Code" then begin
          TESTFIELD("New Location Code");
          if "New Bin Code" <> '' then begin
        #5..7
            if CurrFieldNo <> 0 then
        #9..15
          end;
        end;

        // <<DITW15.00.00.30 DDR 09/01/2009
        cduItemJnlCheckLine.CheckCombLocationBins(Rec);
        // >>DITW15.00.00.30 DDR

        // <<DITW15.00.00.24 DDR 25/09/2008 (Nav client lost currfieldno after called function ReserveItemJnlLine())
        lCurrFieldNo := CurrFieldNo;
        // >>DITW15.00.00.24 DDR

        ReserveItemJnlLine.VerifyChange(Rec,xRec);

        // <<DITW15.00.00.24 DDR 25/09/2008 - DITW15.00.00.25 DDR 27/10/2008
        CurrFieldNo := lCurrFieldNo;
        UpdateCharges(FIELDNO("New Bin Code"),(CurrFieldNo <> 0));
        // >>DITW15.00.00.25 DDR
        //HEI.16>>
        //WHSUTILS.OnBinChangedItemJnlLine(Rec,xRec,CurrFieldNo);//HEI.01 PRDGAP024
        //HEI.16<<

        //<<HEI.31
        UpdateCCCfromNewBinCode;
        //>>HEI.31
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure Code"(Field 5407).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetItem;
        "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");

        IF "Entry Type" IN ["Entry Type"::Consumption,"Entry Type"::Output] THEN
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        IF CurrFieldNo <> 0 THEN
          WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FIELDCAPTION("Unit of Measure Code"));

        GetUnitAmount(FIELDNO("Unit of Measure Code"));
        IF "Value Entry Type" = "Value Entry Type"::Revaluation THEN
          TESTFIELD("Qty. per Unit of Measure",1);

        ReadGLSetup;
        "Unit Cost" := ROUND(UnitCost * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");

        IF "Entry Type" = "Entry Type"::Consumption THEN BEGIN
          "Indirect Cost %" := ROUND(Item."Indirect Cost %" * "Qty. per Unit of Measure",1);
          "Overhead Rate" :=
            ROUND(Item."Overhead Rate" * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
          "Unit Amount" := ROUND(UnitCost * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
        end;

        IF "No." <> '' THEN
          VALIDATE("Cap. Unit of Measure Code");

        VALIDATE("Unit Amount");

        IF "Entry Type" = "Entry Type"::Output THEN BEGIN
          VALIDATE("Output Quantity");
          VALIDATE("Scrap Quantity");
        end else
          VALIDATE(Quantity);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if "Entry Type" in ["Entry Type"::Consumption,"Entry Type"::Output] then
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        if CurrFieldNo <> 0 then
        #8..10
        if "Value Entry Type" = "Value Entry Type"::Revaluation then
        #12..15
        // <<DITW114.00.15 MVN 14/09/2021 NRQ#195462
        "Deposit Value" := RetrieveDepositValue();
        // >>DITW114.00.15 MVN 14/09/2021 NRQ#195462
        // <<DITW15.00.00.33 DDR 15/05/2009
        "Unit Volume HL" := Item."Unit Volume HL" * "Qty. per Unit of Measure";
        // >>DITW15.00.00.33 DDR
        // <<DITW18.00.06 DDR 03/11/2015 DIT-770 #1395 - DITW19.00.08 DDR 17/08/2016 BL#10443
        if "Entry Type" = "Entry Type"::Transfer then
          "New Unit Volume HL" := Item."Unit Volume HL" * "Qty. per Unit of Measure";
        // >>DITW18.00.06 DDR DIT-770 #1395 - DITW19.00.08 DDR BL#10443

        if "Entry Type" = "Entry Type"::Consumption then begin
         //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
          if rStockkeepingUnit.GET("Location Code","Item No.","Variant Code") then begin
            "Indirect Cost %" := ROUND(rStockkeepingUnit."Indirect Cost %" * "Qty. per Unit of Measure",1);
            "Overhead Rate" :=
              ROUND(rStockkeepingUnit."Overhead Rate" * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
             "Unit Amount" := ROUND(UnitCost * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
          end else begin
          //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
            "Indirect Cost %" := ROUND(Item."Indirect Cost %" * "Qty. per Unit of Measure",1);
            "Overhead Rate" :=
              ROUND(Item."Overhead Rate" * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
            "Unit Amount" := ROUND(UnitCost * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
          end;
        end;

        if "No." <> '' then
          VALIDATE("Cap. Unit of Measure Code");

        // <<DITW15.00.00.38 DDR 02/09/2010 - 17/09/2010 #1217
        // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        "Packaging Type Code" := '';
        // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
        "Pack Qty. per Unit of Measure" := 0;
        // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
        // >>DITW19.00.08 DDR BL#10443

        if ("Item Charge No." = '') and ("Unit of Measure Code" <> '') then begin
          // <<DITW19.00.08 DDR 29/09/2016 BL#10443
          if ItemUnitOfMeasure.GET("Item No.","Unit of Measure Code") then begin
          // >>DITW19.00.08 DDR BL#10443
            "Packaging Type Code" := ItemUnitOfMeasure."Packaging Type Code";
            // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
            if ItemUnitOfMeasure."Packaging Type Code" <> '' then
              ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
            "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
            // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
        // <<DITW19.00.08 DDR 29/09/2016 BL#10443
          end;
        end;
        // >>DITW19.00.08 DDR BL#10443
        // >>DITW15.00.00.38 DDR
        // <<DITW18.00.06 DDR 29/10/2015 DIT-770 #1412
        if "Tax Item No." = '' then
          VALIDATE("Packaging Type Code");
        // >>DITW18.00.06 DDR DIT-770 #1412

        // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        // <<DITW18.00.06 DDR 04/11/2015 DIT-770 #1395
        if ("Tax Item No." <> '') then begin
        // >>DITW18.00.06 DDR DIT-770 #1395
          GetTaxItem;
          "Unit Volume HL" := Item."Unit Volume HL" * "Qty. per Unit of Measure";
          // <<DITW18.00.06 DDR 03/11/2015 DIT-770 #1395 - DITW19.00.08 DDR 17/08/2016 BL#10443
          if "Entry Type" = "Entry Type"::Transfer then
            VALIDATE("New Unit Volume HL",Item."Unit Volume HL" * "Qty. per Unit of Measure");
          // >>DITW18.00.06 DDR DIT-770 #1395 - DITW19.00.08 DDR BL#10443
          "Tariff No." := Item."Tariff No.";

          // <<DITW18.00.06 DDR 04/11/2015 DIT-770 #1395
          if "Item Charge Type" = "Item Charge Type"::Tax then begin
          // >>DITW18.00.06 DDR DIT-770 #1395
            ItemUnitOfMeasure.GET(Item."No.","Unit of Measure Code");
            "Packaging Type Code" := ItemUnitOfMeasure."Packaging Type Code";
            if ItemUnitOfMeasure."Packaging Type Code" <> '' then
              ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
            "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
          end;
        end;
        // >>DITW16.00.00.43 DDR DIT-715 #768


        // <<DITW15.00.00.24 DDR 25/09/2008
        if "Is Item Charge" and ("Item Charge No." <> '') then
          VALIDATE("Unit Cost")
        else
        // >>DITW15.00.00.24 DDR
          VALIDATE("Unit Amount");

        if "Entry Type" = "Entry Type"::Output then begin
          VALIDATE("Output Quantity");
          VALIDATE("Scrap Quantity");
        end else
          VALIDATE(Quantity);

        // <<DITW15.00.00.24 DDR 25/09/2008
        UpdateCharges(FIELDNO("Unit of Measure Code"),(CurrFieldNo = FIELDNO("Unit of Measure Code")));
        // >>DITW15.00.00.24 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Cross-Reference No."(Field 5700)". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<FINXL8.00.001 BSA 02/06/2015 #178
        if recFinXLSetup.READPERMISSION then
          fctLookupCrossReference();
        //>>FINXL8.00.001 BSA 02/06/2015 #178
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Cross-Reference No."(Field 5700)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        // var
        //lrecReturnedCrossRef: Record "Item Cross Reference";
        //begin
        /*
        //<<FINXL8.00.001 BSA 02/06/2015 #178
        if recFinXLSetup.READPERMISSION then begin
          lrecReturnedCrossRef.INIT;
          if "Cross-Reference No." <> '' then begin
            cduDistIntegration.fctICRLookupItemJnlLine(Rec,lrecReturnedCrossRef);
            if "Item No." <> lrecReturnedCrossRef."Item No." then
              VALIDATE("Item No.",lrecReturnedCrossRef."Item No.");

            if lrecReturnedCrossRef."Variant Code" <> '' then
              VALIDATE("Variant Code",lrecReturnedCrossRef."Variant Code");

            if lrecReturnedCrossRef."Unit of Measure" <> '' then
              VALIDATE("Unit of Measure Code",lrecReturnedCrossRef."Unit of Measure");

            "Cross-Reference No." := lrecReturnedCrossRef."Cross-Reference No.";
          end;
          if lrecReturnedCrossRef.Description <> '' then
            Description := lrecReturnedCrossRef.Description;
        end;
        //>>FINXL8.00.001 BSA 02/06/2015 #178
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Purchasing Code"(Field 5706)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.24 DDR 25/09/2008
        UpdateCharges(FIELDNO("Purchasing Code"),true);
        // >>DITW15.00.00.24 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Item Charge No."(Field 5801)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.01 DDR 27/12/2007 - DITW15.00.00.24 DDR 25/09/2008
        if "Item Charge Type" <> "Item Charge Type"::" " then begin
          TESTFIELD("Item No.");
          TESTFIELD("Item Charge No.");
        end;

        if "Item Charge No." <> '' then begin
          rItemCharge.GET("Item Charge No.");
          TESTFIELD("Item Charge Type",rItemCharge."Item Charge Type");
          // <<DITW15.00.00.38 DDR 22/12/2010 #1217 (DIT711 103)
          if (Description = '') or (CurrFieldNo <> 0) then
            Description := rItemCharge.Description;
          // >>DITW15.00.00.38 DDR #1217 (DIT711 103)

          // <<DITW18.00.07 DDR 28/02/2016 DIT-770 #1836
          if (xRec."Item Charge No." <> "Item Charge No.") or (rItemCharge."Gen. Prod. Posting Group" <> '') then
          // >>DITW18.00.07 DDR DIT-770 #1836
            VALIDATE("Gen. Prod. Posting Group",rItemCharge."Gen. Prod. Posting Group");

          // <<DITW15.00.00.37 DDR 29/01/2010
          "AAD No. Series" := '';
          "AAD No." := '';
          // >>DITW15.00.00.37 DDR
          // <<DITW15.00.00.38 DDR 04/10/2010 #1217
          "AAD No. Series" :='';
          "AAD No." := '';
          "LRN No. Series" := '';
          "LRN No." := '';
          "ARC No." := '';
          "SAD No." := '';
          "ARC No. Mandatory" := false;
          // >>DITW15.00.00.38 DDR
          // <<DITW18.00.06 DDR 26/10/2015 DIT-770 #1412
          "Unit Volume HL" := 0;
          // <<DITW18.00.06 DDR 03/11/2015 DIT-770 #1395
          "New Unit Volume HL" := 0;
          // >>DITW18.00.06 DDR DIT-770 #1395
          // <<DITW19.00.08 DDR 29/09/2016 BL#10443
          "Unit Volume HL (Calculated)" := 0;
          "Unit Volume HL (Revalued)" := 0;
          // >>DITW19.00.08 DDR BL#10443
          "Packaging Type Code" := '';
          "Pack Qty. per Unit of Measure" := 0;
          "No. of Packages" := 0;
          // >>DITW18.00.06 DDR DIT-770 #1412
          // <<DITW19.00.08 DDR 17/08/2016 29/09/2016 BL#10443
          "Quantity (Brewing Base)" := 0;
          "New Quantity (Brewing Base)" := 0;
          "Strength Spec. Code" := '';
          "Vol-Strength Spec. Code" := '';
          "Strength Spec. Value (Calcd.)" := 0;
          "Strength Spec. Value (Reval.)" := 0;
          "Vol-Strength Value (Calcd.)" := 0;
          "Vol-Strength Value (Reval.)" := 0;
          if BeverageSetup.READPERMISSION then begin
            "Quantity (Brewing Base)" := 0;
            "New Quantity (Brewing Base)" := 0;
            "Quantity (Brewing Base) Calcd." := 0;
            "Quantity (Brewing Base) Reval." := 0;
          end;
          // >>DITW19.00.08 DDR BL#10443
        end;

        // <<DITW15.00.00.24 DDR 25/09/2008
        //<< DITW110.00.11 AKH 15/09/2017 NRQ#33638
        if ("Order Type" <> "Order Type"::Production) or ("Order No." = '') then begin
        //>> DITW110.00.11 AKH NRQ#33638
          CreateDim(
            DATABASE::"Item Charge","Item Charge No.",
            DATABASE::Item,"Item No.",
            DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
            DATABASE::"Work Center","Work Center No.",
            // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
            DATABASE::Item,"Tax Item No.",
            //<<DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
            DATABASE::"Responsibility Center", "Responsibility Center");
            //>>DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
            // >>DITW16.00.00.43 DDR DIT-715 #768
            // >>DITW15.00.00.24 DDR
           //HEI.24<<
          UpdateCCCfromBinCode; //HEI.24
        end;
          //HEI.24>>
        */
        //end;


        //Unsupported feature: CodeModification on ""Inventory Value (Revalued)"(Field 5803).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Value Entry Type","Value Entry Type"::Revaluation);
        VALIDATE(Amount,"Inventory Value (Revalued)" - "Inventory Value (Calculated)");
        ReadGLSetup;
        IF ("Unit Cost (Revalued)" <> xRec."Unit Cost (Revalued)") OR
           ("Inventory Value (Revalued)" <> xRec."Inventory Value (Revalued)")
        THEN BEGIN
          IF CurrFieldNo <> FIELDNO("Unit Cost (Revalued)") THEN
            "Unit Cost (Revalued)" :=
              ROUND("Inventory Value (Revalued)" / Quantity,GLSetup."Unit-Amount Rounding Precision");

          IF CurrFieldNo <> 0 THEN
            ClearSingleAndRolledUpCosts;
        end
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if ("Unit Cost (Revalued)" <> xRec."Unit Cost (Revalued)") or
           ("Inventory Value (Revalued)" <> xRec."Inventory Value (Revalued)")
        then begin
          if CurrFieldNo <> FIELDNO("Unit Cost (Revalued)") then
        #8..10
          if CurrFieldNo <> 0 then
            ClearSingleAndRolledUpCosts;
        end
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-from Entry"(Field 5807).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Applies-from Entry" <> 0 THEN BEGIN
          TESTFIELD(Quantity);
          IF Signed(Quantity) < 0 THEN BEGIN
            IF Quantity > 0 THEN
              FIELDERROR(Quantity,Text030);
            IF Quantity < 0 THEN
              FIELDERROR(Quantity,Text029);
          end;
          ItemLedgEntry.GET("Applies-from Entry");
          ItemLedgEntry.TESTFIELD(Positive,FALSE);
          IF ItemLedgEntry.TrackingExists THEN
            ERROR(Text033,FIELDCAPTION("Applies-from Entry"),ItemTrackingLines.CAPTION);
          "Unit Cost" := CalcUnitCost(ItemLedgEntry);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Applies-from Entry" <> 0 then begin
          TESTFIELD(Quantity);
          if Signed(Quantity) < 0 then begin
            if Quantity > 0 then
              FIELDERROR(Quantity,Text030);
            if Quantity < 0 then
              FIELDERROR(Quantity,Text029);
          end;
          ItemLedgEntry.GET("Applies-from Entry");
          ItemLedgEntry.TESTFIELD(Positive,false);
          if ItemLedgEntry.TrackingExists then
            ERROR(Text033,FIELDCAPTION("Applies-from Entry"),ItemTrackingLines.CAPTION);
          "Unit Cost" := CalcUnitCost(ItemLedgEntry);
          // <<DITW19.00.08 DDR 29/09/2016 BL#10443
          CalcStrengthFromEntry(ItemLedgEntry);
          // >>DITW19.00.08 DDR BL#10443
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit Cost (Revalued)"(Field 5810).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReadGLSetup;
        TESTFIELD("Value Entry Type","Value Entry Type"::Revaluation);
        IF "Unit Cost (Revalued)" <> xRec."Unit Cost (Revalued)" THEN
          VALIDATE(
            "Inventory Value (Revalued)",
            ROUND(
              "Unit Cost (Revalued)" * Quantity,GLSetup."Amount Rounding Precision"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ReadGLSetup;
        TESTFIELD("Value Entry Type","Value Entry Type"::Revaluation);
        if "Unit Cost (Revalued)" <> xRec."Unit Cost (Revalued)" then
        #4..7
        */
        //end;


        //Unsupported feature: CodeModification on "Type(Field 5830).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type = Type::Resource THEN
          TESTFIELD("Entry Type","Entry Type"::"Assembly Output")
        else
          TESTFIELD("Entry Type","Entry Type"::Output);
        VALIDATE("No.",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Type = Type::Resource then
          TESTFIELD("Entry Type","Entry Type"::"Assembly Output")
        else
          TESTFIELD("Entry Type","Entry Type"::Output);
        VALIDATE("No.",'');
        // <<DITW15.00.00.37 DDR 30/04/2010
        if ("Item Charge No." <> '') and (Type <> Type::" ") then
          TESTFIELD(Type,Type::" ");
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""No."(Field 5831).OnValidate". Please convert manually.

        //trigger "(Field 5831)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type = Type::Resource THEN
          TESTFIELD("Entry Type","Entry Type"::"Assembly Output")
        else
          TESTFIELD("Entry Type","Entry Type"::Output);
        IF "No." = '' THEN BEGIN
          "Work Center No." := '';
          VALIDATE("Item No.");
          IF Type IN [Type::"Work Center",Type::"Machine Center"] THEN
            CreateDimWithProdOrderLine
          else
            CreateDim(
              DATABASE::"Work Center","Work Center No.",
              DATABASE::Item,"Item No.",
              DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code");
          EXIT;
        end;

        CASE Type OF
          Type::"Work Center":
            BEGIN
              WorkCenter.GET("No.");
              WorkCenter.TESTFIELD(Blocked,FALSE);
              "Work Center No." := WorkCenter."No.";
              Description := WorkCenter.Name;
              "Gen. Prod. Posting Group" := WorkCenter."Gen. Prod. Posting Group";
              "Unit Cost Calculation" := WorkCenter."Unit Cost Calculation";
            end;
          Type::"Machine Center":
            BEGIN
              MachineCenter.GET("No.");
              MachineCenter.TESTFIELD(Blocked,FALSE);
              "Work Center No." := MachineCenter."Work Center No.";
              Description := MachineCenter.Name;
              WorkCenter.GET("Work Center No.");
              WorkCenter.TESTFIELD(Blocked,FALSE);
              "Gen. Prod. Posting Group" := MachineCenter."Gen. Prod. Posting Group";
              "Unit Cost Calculation" := "Unit Cost Calculation"::Time;
            end;
          Type::Resource:
            BEGIN
              Resource.GET("No.");
              Resource.TESTFIELD(Blocked,FALSE);
            end;
        end;

        IF Type IN [Type::"Work Center",Type::"Machine Center"] THEN BEGIN
          "Work Center No." := WorkCenter."No.";
          VALIDATE("Cap. Unit of Measure Code",WorkCenter."Unit of Measure Code");
        end;

        IF "Work Center No." <> '' THEN
          CreateDimWithProdOrderLine;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Type = Type::Resource then
          TESTFIELD("Entry Type","Entry Type"::"Assembly Output")
        else
          TESTFIELD("Entry Type","Entry Type"::Output);
        // <<DITW15.00.00.37 DDR 30/04/2010
        if "Item Charge No." <> '' then begin
          if CurrFieldNo = FIELDNO("No.") then
            TESTFIELD("No.",'')
          else
            "No." := '';
          exit;
        end;
        // >>DITW15.00.00.37 DDR

        if "No." = '' then begin
          "Work Center No." := '';
          VALIDATE("Item No.");
          if Type in [Type::"Work Center",Type::"Machine Center"] then
            CreateDimWithProdOrderLine
          else
          CreateDim(
            DATABASE::"Work Center","Work Center No.",
            DATABASE::Item,"Item No.",
            DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
            DATABASE::"Item Charge","Item Charge No.",
            // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
            DATABASE::Item,"Tax Item No.",
            //<<DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
            DATABASE::"Responsibility Center", "Responsibility Center");
            //>>DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
            // >>DITW16.00.00.43 DDR DIT-715 #768
            // >>DITW15.00.00.24 DDR
          UpdateCCCfromBinCode; //HEI.24
          exit;
        end;

        case Type of
          Type::"Work Center":
            begin
              WorkCenter.GET("No.");
              WorkCenter.TESTFIELD(Blocked,false);
        #23..26
              // <<DITW19.00.08 DDR 17/08/2016 29/09/2016 BL#10443
              "Scrap Code" := WorkCenter."Scrap Code";
              // >>DITW19.00.08 DDR BL#10443
            end;
          Type::"Machine Center":
            begin
              MachineCenter.GET("No.");
              MachineCenter.TESTFIELD(Blocked,false);
        #32..34
              WorkCenter.TESTFIELD(Blocked,false);
              "Gen. Prod. Posting Group" := MachineCenter."Gen. Prod. Posting Group";
              "Unit Cost Calculation" := "Unit Cost Calculation"::Time;
              // <<DITW19.00.08 DDR 17/08/2016 BL#10443
              "Scrap Code" := MachineCenter."Scrap Code";
              // >>DITW19.00.08 DDR BL#10443
            end;
          Type::Resource:
            begin
              Resource.GET("No.");
              Resource.TESTFIELD(Blocked,false);
            end;
        end;

        if Type in [Type::"Work Center",Type::"Machine Center"] then begin
          "Work Center No." := WorkCenter."No.";
          VALIDATE("Cap. Unit of Measure Code",WorkCenter."Unit of Measure Code");
        end;

        //IF "Work Center No." <> '' THEN //HEI.24 commented
        if "Work Center No." <> '' then begin //HEI.24
          CreateDimWithProdOrderLine;
          UpdateCCCfromBinCode; //HEI.24
        end; //HEI.24
        */
        //end;


        //Unsupported feature: CodeModification on ""Operation No."(Field 5838).OnValidate". Please convert manually.

        //trigger "(Field 5838)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Entry Type","Entry Type"::Output);
        IF "Operation No." = '' THEN
          EXIT;

        TESTFIELD("Order Type","Order Type"::Production);
        TESTFIELD("Order No.");
        TESTFIELD("Item No.");

        GetProdOrderRtngLine(ProdOrderRtngLine);

        CASE ProdOrderRtngLine.Type OF
          ProdOrderRtngLine.Type::"Work Center":
            Type := Type::"Work Center";
          ProdOrderRtngLine.Type::"Machine Center":
            Type := Type::"Machine Center";
        end;
        VALIDATE("No.",ProdOrderRtngLine."No.");
        Description := ProdOrderRtngLine.Description;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Entry Type","Entry Type"::Output);

        // <<DITW15.00.00.37 DDR 30/04/2010
        // <<DITW16.00.00.40 DDR 15/11/2011 #1462
        if ("Item Charge No." <> '') and ("Attached to Line No." <> 0) and ("Line No." <> 0) then begin
          rFromItemJnlLine.GET("Journal Template Name","Journal Batch Name","Attached to Line No.");
          TESTFIELD("Operation No.",rFromItemJnlLine."Operation No.");
          Type := Type::" ";
          "No." := '';
          exit;
        end;
        UpdateCharges(FIELDNO("Operation No."),(CurrFieldNo = FIELDNO("Operation No.")));
        // >>DITW15.00.00.37 DDR

        if "Operation No." = '' then
          exit;
        #4..10
        case ProdOrderRtngLine.Type of
        #12..15
        end;
        VALIDATE("No.",ProdOrderRtngLine."No.");
        Description := ProdOrderRtngLine.Description;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Work Center No."(Field 5839)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.37 DDR 30/04/2010
        // <<DITW16.00.00.40 DDR 15/11/2011 #1462
        if ("Item Charge No." <> '') and ("Attached to Line No." <> 0) and ("Line No." <> 0) then begin
          rFromItemJnlLine.GET("Journal Template Name","Journal Batch Name","Attached to Line No.");
          TESTFIELD("Work Center No.",rFromItemJnlLine."Work Center No.");
          exit;
        end;
        UpdateCharges(FIELDNO("Work Center No."),(CurrFieldNo = FIELDNO("Work Center No.")));
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Setup Time"(Field 5841).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF SubcontractingWorkCenterUsed AND ("Setup Time" <> 0) THEN
          ERROR(STRSUBSTNO(SubcontractedErr,FIELDCAPTION("Setup Time"),"Line No."));
        "Setup Time (Base)" := CalcBaseTime("Setup Time");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.37 DDR 30/04/2010
        TESTFIELD("Item Charge No.",'');
        // >>DITW15.00.00.37 DDR

        if SubcontractingWorkCenterUsed and ("Setup Time" <> 0) then
          ERROR(STRSUBSTNO(SubcontractedErr,FIELDCAPTION("Setup Time"),"Line No."));
        "Setup Time (Base)" := CalcBaseTime("Setup Time");
        */
        //end;


        //Unsupported feature: CodeModification on ""Run Time"(Field 5842).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF SubcontractingWorkCenterUsed AND ("Run Time" <> 0) THEN
          ERROR(STRSUBSTNO(SubcontractedErr,FIELDCAPTION("Run Time"),"Line No."));

        "Run Time (Base)" := CalcBaseTime("Run Time");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.37 DDR 30/04/2010
        TESTFIELD("Item Charge No.",'');
        // >>DITW15.00.00.37 DDR

        if SubcontractingWorkCenterUsed and ("Run Time" <> 0) then
        #2..4
        */
        //end;


        //Unsupported feature: CodeModification on ""Stop Time"(Field 5843).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Stop Time (Base)" := CalcBaseTime("Stop Time");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.37 DDR 30/04/2010
        TESTFIELD("Item Charge No.",'');
        // >>DITW15.00.00.37 DDR
        "Stop Time (Base)" := CalcBaseTime("Stop Time");
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Output Quantity"(Field 5846).OnValidate". Please convert manually.

        //trigger (Variable: ProdOrderLine)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Output Quantity"(Field 5846).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Entry Type","Entry Type"::Output);
        IF SubcontractingWorkCenterUsed AND ("Output Quantity" <> 0) THEN
          ERROR(STRSUBSTNO(SubcontractedErr,FIELDCAPTION("Output Quantity"),"Line No."));

        IF LastOutputOperation(Rec) THEN
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        "Output Quantity (Base)" := CalcBaseQty("Output Quantity");

        VALIDATE(Quantity,"Output Quantity");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Entry Type","Entry Type"::Output);

        // <<DITW15.00.00.37 DDR 30/04/2010
        // <<DITW16.00.00.40 DDR 15/11/2011 #1462
        // <<DITW16.00.00.43 DDR 20/12/2013 DIT-715 #864
        if ("Item Charge No." = '') and ("Attached to Line No." = 0) then
        // >>DITW16.00.00.43 DDR DIT-715 #864
        // >>DITW15.00.00.37 DDR
        if SubcontractingWorkCenterUsed and ("Output Quantity" <> 0) then
          ERROR(STRSUBSTNO(SubcontractedErr,FIELDCAPTION("Output Quantity"),"Line No."));

        if LastOutputOperation(Rec) then
        #6..9
        // <<DITW16.00.00.43 DDR 20/12/2013 DIT-715 #864
        if (CurrFieldNo = FIELDNO("Output Quantity")) and
           (xRec."Output Quantity" <> "Output Quantity") and
           ("Output Quantity" <> 0) and
           ("Extra Charge Type" <> "Extra Charge Type"::" ") and
           ("Item Charge Type" <> "Item Charge Type"::Deposit) and
           ("Extra Charge Type" <> "Extra Charge Type"::"Fixed Amount")
          then
            TESTFIELD("Output Quantity", xRec."Output Quantity");
        // >>DITW16.00.00.43 DDR DIT-715 #864

        VALIDATE(Quantity,"Output Quantity");

        // <<DITW19.00.08 DDR 17/08/2016 29/09/2016 20/10/2016 BL#10443
        //ProdOrderLine.GET(ProdOrderLine.Status::Released,"Order No.","Order Line No.");
        //IF ("Output Quantity"+"Scrap Quantity") > ProdOrderLine."Remaining Quantity" THEN
        //  FIELDERROR("Output Quantity",STRSUBSTNO(Text2035141,ProdOrderLine."Remaining Quantity"-"Scrap Quantity"));

        if (("Item Charge No." = '') or ("Tax Item No." <> '')) and BeverageSetup.READPERMISSION then begin
            StrengthValue := AverageStrengthReserv(FIELDNO("Strength Spec. Value"));
            "Output Quantity (Brewing Base)" := ROUND("Output Quantity" * "Unit Volume HL",0.00001);
            "Output Quantity (Degrees)" := CalcVolumeStrength("Output Quantity",StrengthValue,"Unit Volume HL");
          end;
        // >>DITW19.00.08 DDR BL#10443
        //<<DITW110.00.12A ISL 13/06/2018 NRQ#51789
        recManufacturingSetup.GET;
        //<<DITW110.00.12A HBA 04/06/2018 NRQ#51793
        if (CurrFieldNo = FIELDNO("Output Quantity")) and (recManufacturingSetup."Prod. Jnl. Flushing (Time)") then
        //>>DITW110.00.12A ISL 13/06/2018 NRQ#51789
          UpdateTimes;
        //>>DITW110.00.12A HBA 04/06/2018 NRQ#51793

        // <<DITW15.00.00.37 DDR 19/01/2010
        UpdateCharges(FIELDNO("Output Quantity"),(CurrFieldNo = FIELDNO("Output Quantity")));
        // >>DITW15.00.00.37 DDR
        //<<DITW110.00.12A HBA 07/06/2018 NRQ#51782
        if ("Output Quantity" <> xRec."Output Quantity")  then
          UpdateConsumptionLine();
        //>>DITW110.00.12A HBA 07/06/2018 NRQ#51782
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Scrap Quantity"(Field 5847).OnValidate". Please convert manually.

        //trigger (Variable: ProdOrderLine)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Scrap Quantity"(Field 5847).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Entry Type","Entry Type"::Output);
        "Scrap Quantity (Base)" := CalcBaseQty("Scrap Quantity");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW19.00.08 DDR 29/09/2016 20/10/2016 BL#10443
        // <<DITW19.00.08 DDR 09/12/2016 BL#10443
        //TESTFIELD("Entry Type","Entry Type"::Output);
        // >>DITW19.00.08 DDR BL#10443
        if CurrFieldNo <> 0 then
          TestLossBreakdown(FIELDCAPTION("Scrap Quantity"));
        case "Entry Type" of
          "Entry Type"::Output:
            begin
              //ProdOrderLine.GET(ProdOrderLine.Status::Released,"Order No.","Order Line No.");
              //IF ("Output Quantity"+"Scrap Quantity") > ProdOrderLine."Remaining Quantity" THEN
              //  FIELDERROR("Scrap Quantity",STRSUBSTNO(Text2035141,ProdOrderLine."Remaining Quantity"-"Output Quantity"));
              //VALIDATE("Output Quantity",ProdOrderLine."Remaining Quantity" - "Scrap Quantity");
            end;
          else
            if "Scrap Quantity" > Quantity then
              FIELDERROR("Scrap Quantity",STRSUBSTNO(Text2035141,Quantity));
        end;
        // >>DITW19.00.08 DDR BL#10443
        "Scrap Quantity (Base)" := CalcBaseQty("Scrap Quantity");
        // <<DITW19.00.08 DDR 17/08/2016 29/09/2016 20/10/2016 BL#10443
        if (("Item Charge No." = '') or ("Tax Item No." <> '')) and BeverageSetup.READPERMISSION then begin
          StrengthValue := AverageStrengthReserv(FIELDNO("Strength Spec. Value"));
          "Loss Quantity (Brewing Base)" := ROUND("Scrap Quantity" * "Unit Volume HL",0.00001);
          "Loss Quantity (Degrees)" := CalcVolumeStrength("Scrap Quantity",StrengthValue,"Unit Volume HL");
        end;
        // >>DITW19.00.08 DDR BL#10443

        // <<DITW15.00.00.37 DDR 19/01/2010
        UpdateCharges(FIELDNO("Scrap Quantity"),(CurrFieldNo = FIELDNO("Scrap Quantity")));
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Concurrent Capacity"(Field 5849).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Entry Type","Entry Type"::Output);
        IF "Concurrent Capacity" = 0 THEN
          EXIT;

        TESTFIELD("Starting Time");
        TESTFIELD("Ending Time");
        TotalTime := CalendarMgt.CalcTimeDelta("Ending Time","Starting Time");
        IF "Ending Time" < "Starting Time" THEN
          TotalTime := TotalTime + 86400000;
        TESTFIELD("Work Center No.");
        WorkCenter.GET("Work Center No.");
        #12..14
          ROUND(
            TotalTime / CalendarMgt.TimeFactor("Cap. Unit of Measure Code") *
            "Concurrent Capacity",WorkCenter."Calendar Rounding Precision"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Entry Type","Entry Type"::Output);
        if "Concurrent Capacity" = 0 then
          exit;

        // <<DITW15.00.00.37 DDR 30/04/2010
        if "Item Charge No." <> '' then begin
          if CurrFieldNo = FIELDNO("Concurrent Capacity") then
            TESTFIELD("Concurrent Capacity",0)
          else
            "Concurrent Capacity" := 0;
          exit;
        end;
        // >>DITW15.00.00.37 DDR
        #4..7
        if "Ending Time" < "Starting Time" then
        #9..17
        */
        //end;


        //Unsupported feature: CodeModification on ""Cap. Unit of Measure Code"(Field 5858).OnValidate". Please convert manually.

        //trigger  Unit of Measure Code"(Field 5858)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type <> Type::Resource THEN BEGIN
          "Qty. per Cap. Unit of Measure" :=
            ROUND(
              CalendarMgt.QtyperTimeUnitofMeasure(
                "Work Center No.","Cap. Unit of Measure Code"),
              0.00001);

          VALIDATE("Setup Time");
          VALIDATE("Run Time");
          VALIDATE("Stop Time");
        end;

        IF "Order No." <> '' THEN
          CASE "Order Type" OF
            "Order Type"::Production:
              BEGIN
                GetProdOrderRtngLine(ProdOrderRtngLine);
                "Unit Cost" := ProdOrderRtngLine."Unit Cost per";

                CostCalcMgt.RoutingCostPerUnit(
                  Type,"No.","Unit Amount","Indirect Cost %","Overhead Rate","Unit Cost","Unit Cost Calculation");
              end;
            "Order Type"::Assembly:
              CostCalcMgt.ResourceCostPerUnit("No.","Unit Amount","Indirect Cost %","Overhead Rate","Unit Cost");
          end;

        ReadGLSetup;
        "Unit Cost" :=
          ROUND("Unit Cost" * "Qty. per Cap. Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
        "Unit Amount" :=
          ROUND("Unit Amount" * "Qty. per Cap. Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
        VALIDATE("Unit Amount");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Type <> Type::Resource then begin
        #2..7
        // <<DITW15.00.00.37 DDR 30/04/2010
        if "Item Charge No." <> '' then begin
          if CurrFieldNo = FIELDNO("Cap. Unit of Measure Code") then
            TESTFIELD("Cap. Unit of Measure Code",'')
          else
            "Cap. Unit of Measure Code" := '';
          exit;
        end;
        // >>DITW15.00.00.37 DDR

        #8..10
        end;

        if "Order No." <> '' then
          case "Order Type" of
            "Order Type"::Production:
              begin
        #17..21
              end;
            "Order Type"::Assembly:
              CostCalcMgt.ResourceCostPerUnit("No.","Unit Amount","Indirect Cost %","Overhead Rate","Unit Cost");
          end;
        #26..32

        // <<DITW15.00.00.37 DDR 19/01/2010
        UpdateCharges(FIELDNO("Cap. Unit of Measure Code"),(CurrFieldNo = FIELDNO("Cap. Unit of Measure Code")));
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Qty. per Cap. Unit of Measure"(Field 5859)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.37 DDR 30/04/2010
        if "Item Charge No." <> '' then begin
          if CurrFieldNo = FIELDNO("Qty. per Cap. Unit of Measure") then
            TESTFIELD("Qty. per Cap. Unit of Measure",0)
          else
            "Qty. per Cap. Unit of Measure" := 0;
          exit;
        end;
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Starting Time"(Field 5873).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Ending Time" < "Starting Time" THEN
          "Ending Time" := "Starting Time";

        VALIDATE("Concurrent Capacity");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Ending Time" < "Starting Time" then
        #2..4
        */
        //end;


        //Unsupported feature: CodeModification on ""Prod. Order Comp. Line No."(Field 5884).OnValidate". Please convert manually.

        //trigger  Order Comp();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Prod. Order Comp. Line No." <> xRec."Prod. Order Comp. Line No." THEN
          CreateProdDim;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.37 DDR 30/04/2010
        // <<DITW16.00.00.40 DDR 15/11/2011 #1462
        if ("Item Charge No." <> '') and ("Attached to Line No." <> 0) and ("Line No." <> 0) then begin
          rFromItemJnlLine.GET("Journal Template Name","Journal Batch Name","Attached to Line No.");
          TESTFIELD("Prod. Order Comp. Line No.",rFromItemJnlLine."Prod. Order Comp. Line No.");
          exit;
        end;
        // >>DITW15.00.00.37 DDR

        if "Prod. Order Comp. Line No." <> xRec."Prod. Order Comp. Line No." then
          CreateProdDim;

        // <<DITW15.00.00.37 DDR 19/01/2010
        UpdateCharges(FIELDNO("Prod. Order Comp. Line No."),(CurrFieldNo = FIELDNO("Prod. Order Comp. Line No.")));
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on "Finished(Field 5885)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.37 DDR 30/04/2010
        // <<DITW16.00.00.40 DDR 15/11/2011 #1462
        if ("Item Charge No." <> '') and ("Attached to Line No." <> 0) and ("Line No." <> 0) then begin
          rFromItemJnlLine.GET("Journal Template Name","Journal Batch Name","Attached to Line No.");
          TESTFIELD(Finished,rFromItemJnlLine.Finished);
          exit;
        end;
        UpdateCharges(FIELDNO(Finished),(CurrFieldNo = FIELDNO(Finished)));
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on "Subcontracting(Field 5888)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.37 DDR 30/04/2010
        // <<DITW16.00.00.40 DDR 15/11/2011 #1462
        if ("Item Charge No." <> '') and ("Attached to Line No." <> 0) and ("Line No." <> 0) then begin
          rFromItemJnlLine.GET("Journal Template Name","Journal Batch Name","Attached to Line No.");
          TESTFIELD(Subcontracting,rFromItemJnlLine.Subcontracting);
          exit;
        end;
        UpdateCharges(FIELDNO(Subcontracting),(CurrFieldNo = FIELDNO(Subcontracting)));
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Stop Code"(Field 5895)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.37 DDR 30/04/2010
        if "Item Charge No." <> '' then begin
          if CurrFieldNo = FIELDNO("Stop Code") then
            TESTFIELD("Stop Code",'')
          else
            "Stop Code" := '';
        end;
        UpdateCharges(FIELDNO("Stop Code"),(CurrFieldNo = FIELDNO("Stop Code")));
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Scrap Code"(Field 5896).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type,Type::"Machine Center");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //  TESTFIELD(Type,Type::"Machine Center");
        // >>DITW19.00.08 DDR BL#10443

        // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        if (CurrFieldNo <> 0) and ("Scrap Code" <> '') then
          TestLossBreakdown(FIELDCAPTION("Scrap Code"));
        // >>DITW19.00.08 DDR BL#10443

        // <<DITW15.00.00.37 DDR 30/04/2010
        if "Item Charge No." <> '' then begin
          if CurrFieldNo = FIELDNO("Scrap Code") then
            TESTFIELD("Scrap Code",'')
          else
            "Scrap Code" := '';
        end;
        UpdateCharges(FIELDNO("Scrap Code"),(CurrFieldNo = FIELDNO("Scrap Code")));
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Work Center Group Code"(Field 5898)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.37 DDR 30/04/2010
        if "Item Charge No." <> '' then begin
          if CurrFieldNo = FIELDNO("Work Center Group Code") then
            TESTFIELD("Work Center Group Code",'')
          else
            "Work Center Group Code" := '';
        end;
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Work Shift Code"(Field 5899)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.37 DDR 30/04/2010
        if "Item Charge No." <> '' then begin
          if CurrFieldNo = FIELDNO("Work Shift Code") then
            TESTFIELD("Work Shift Code",'')
          else
            "Work Shift Code" := '';
        end;
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Return Reason Code"(Field 6600)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW17.00.02 DDR 24/05/2013 DIT-770 #99
        UpdateCharges(FIELDNO("Return Reason Code"),true);
        // >>DITW17.00.02 DDR DIT-770 #99
        */
        //end;


        //Unsupported feature: CodeModification on ""Overhead Rate"(Field 99000755).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
           ("Item Charge No." <> '')
        THEN BEGIN
          "Overhead Rate" := 0;
          VALIDATE("Indirect Cost %",0);
        end else
          VALIDATE("Indirect Cost %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") or
           ("Item Charge No." <> '')
        then begin
          "Overhead Rate" := 0;
          VALIDATE("Indirect Cost %",0);
        end else
          VALIDATE("Indirect Cost %");
        */
        //end;
        // BC Upgrade KAMNAY01 -  Blocked FR localization fields >>
        // field(10800; "Shipment Method Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Shipment Method Code',
        //                 FRA = 'Code condition livraison';
        //     Description = 'HEI.18';
        //     TableRelation = "Shipment Method";
        // }
        // BC Upgrade KAMNAY01 -  Blocked FR localization fields <<
        field(50000; "Zone Code FND"; Code[10])
        {
            caption = 'Zone Code';
            Description = 'HEI.01 PRDGAP024';
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"),
                                             "Use As In-Transit FND" = FILTER(false));

            trigger OnValidate();
            begin
                //HEI.01 PRDGAP024>>
                if "Zone Code FND" <> xRec."New Zone Code FND" then
                    VALIDATE("Bin Code", '');
                if "Zone Code FND" <> '' then
                    WHSUTILS.CheckUserAuthorizedinZone("Location Code", "Zone Code FND");
                //HEI.01 PRDGAP024<<
            end;
        }
        field(50001; "New Zone Code FND"; Code[10])
        {
            caption = 'New Zone Code';
            Description = 'HEI.01 PRDGAP024';
            TableRelation = Zone.Code where("Location Code" = FIELD("New Location Code"));

            trigger OnValidate();
            begin
                //HEI.01 PRDGAP024>>
                if "New Zone Code FND" <> xRec."New Zone Code FND" then
                    VALIDATE("New Bin Code", '');
                if "New Zone Code FND" <> '' then
                    WHSUTILS.CheckUserAuthorizedinZone("New Location Code", "New Zone Code FND");
                //HEI.01 PRDGAP024<<
            end;
        }
        field(50002; "Actual Posted Cons/Output FND"; Decimal)
        {
            caption = 'Actual Posted Cons/Output';
            Description = 'HEI.05';
            Editable = false;
        }
        field(50003; "Vendor No. FND"; Code[20])
        {
            caption = 'Vendor No.';
            Description = 'HEI.03';
            TableRelation = Vendor."No.";

            trigger OnValidate();
            begin
                //HEI.03>>
                if (xRec."Vendor No. FND" <> "Vendor No. FND") and (xRec."Vendor No. FND" <> '') then begin
                    GetVend("Vendor No. FND");
                    Vend.CheckBlockedVendOnDocs(Vend, false);
                    "Vendor Name FND" := Vend.Name;
                end;
                //HEI.03<<
            end;
        }
        field(50004; "Vendor Name FND"; Text[50])
        {
            caption = 'Vendor Name';
            Description = 'HEI.03';
        }
        field(50005; "RPM Solution FND"; Option)
        {
            Caption = 'RPM Solution';
            Description = 'HEI.10';
            Editable = false;
            OptionCaption = '" ,Deposit,Full-for-Empty with revenue impact (FFE with revenue),Full-for Empty without revenue impact (FFE w/o revenue)"';
            OptionMembers = " ",Deposit,"Full-for-Empty with revenue impact (FFE with revenue)","Full-for Empty without revenue impact (FFE w/o revenue)";
        }
        field(50006; "RPM Type FND"; Code[20])
        {
            caption = 'RPM Type';
            Description = 'HEI.10';
            Editable = false;
            TableRelation = "Return Pack Material Type FND".Code;
        }
        field(50007; "Item Type FND"; Option)
        {
            Caption = 'Item Type';
            Description = 'HEI.10';
            Editable = false;
            OptionCaption = '" ,RPM Related,Product Related"';
            OptionMembers = " ","RPM Related","Product Related";
        }
        field(50008; "Quality Status FND"; Option)
        {
            Caption = 'Quality Status';
            Description = 'HEI.11';
            Editable = false;
            OptionCaption = 'Quality Hold,Unrestricted,Blocked';
            OptionMembers = "Quality Hold",Unrestricted,Blocked;
        }
        field(50009; "Project Code FND"; Code[20])
        {
            caption = 'Project Code';
            Description = 'HEI.13';
            TableRelation = "Project FND";

            trigger OnValidate();
            var
                Project: Record "Project FND";
            begin
                if Project.GET("Project Code FND") then
                    "Project Description FND" := Project.Description;
            end;
        }
        field(50010; "Project Description FND"; Text[80])
        {
            caption = 'Project Description';
            Description = 'HEI.13';
            Editable = false;
        }
        field(50011; "Interface Code FND"; Code[20])
        {
            Caption = 'Interface Code';
            Description = 'HEI.14';
            //TableRelation = "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension 
        }
        field(50012; "CP Vendor Invoice No. FND"; Code[20])
        {
            caption = 'CP Vendor Invoice No.';
            Description = 'HEI.14';
        }
        field(50013; "Qty. (Calc.) in Inv. UoM FND"; Decimal)
        {
            Caption = 'Qty. (Calculated) in Inv. UoM';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.19';
            Editable = false;

            trigger OnValidate();
            begin
                VALIDATE("Qty. Phys. Inv. in Inv.UoM FND");
            end;
        }
        field(50014; "Qty. Phys. Inv. in Inv.UoM FND"; Decimal)
        {
            Caption = 'Qty. (Phys. Inv.) in Inv. UoM';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.19';

            trigger OnValidate();
            var
                UOMMgt: Codeunit "Unit of Measure Management";
            begin
                GetItem();
                VALIDATE("Qty. (Phys. Inventory)", UOMMgt.CalcBaseQty("Qty. Phys. Inv. in Inv.UoM FND", UOMMgt.GetQtyPerUnitOfMeasure(Item, "Invent. Unit of Measur Cod FND")));

                //HEI.20>>
                TESTFIELD("Phys. Inventory", true);
                PhysInvtEntered := true;
                RoundOffPhysInvQty();
                PhysInvtEntered := false;
                //HEI.20<<
            end;
        }
        field(50015; "Quantity in Inv. UoM FND"; Decimal)
        {
            Caption = 'Quantity in Inv. UoM';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.19';
            Editable = false;
        }
        field(50016; "Invent. Unit of Measur Cod FND"; Code[10])
        {
            Caption = 'Invent. Unit of Measure Code';
            Description = 'HEI.19';
            Editable = false;
            TableRelation = "Item Unit of Measure".Code where("Item No." = FIELD("Item No."));
        }
        field(50017; "Freeze Batch Lines FND"; Boolean)
        {
            caption = 'Freeze Batch Lines';
            Description = 'HEI.20';
            Editable = false;
        }
        field(50018; "Enable Phys.Inv. Round-off FND"; Boolean)
        {
            caption = 'Enable Phys.Inv. Round-off';
            Description = 'HEI.21';
            Editable = false;
        }
        field(50019; "Sent for Approval FND"; Boolean)
        {
            caption = 'Sent for Approval';
            Description = 'HEI.28';
            Editable = false;
        }
        field(50020; "Bulk Transfer FND"; Boolean)
        {
            caption = 'Bulk Transfer';
            Description = 'HEI.32';
            Editable = false;
        }
        field(50021; "Actual Posted Consumption FND"; Decimal)
        {
            Caption = 'Actual Posted Consumption';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.39';
            Editable = false;
        }
        field(50022; "Actual Posted Lot No. FND"; Code[20])
        {
            Caption = 'Actual Posted Lot No.';
            Description = 'HEI.39';
            Editable = false;
            TableRelation = "Lot No. Information"."Lot No." where("Item No." = FIELD("Item No."),
                                                                   "Variant Code" = FIELD("Variant Code"));
        }
        field(50023; "Consumption Suggested FND"; Boolean)
        {
            Caption = 'Consumption Suggested';
            Description = 'HEI.39';
            Editable = false;
        }
        field(50024; "Consumption Allocated FND"; Boolean)
        {
            Caption = 'Consumption Allocated';
            Description = 'HEI.39';
            Editable = false;
        }
        field(50025; "Reporting Type FND"; Option)
        {
            Caption = 'Reporting Type';
            Description = 'HEI.34';
            OptionCaption = '" ,Interregional Transfer Inbound,Interregional Transfer Outbound"';
            OptionMembers = " ","Interregional Transfer Inbound","Interregional Transfer Outbound";
        }
        field(50027; "Quantity Allocated FND"; Decimal)
        {
            Caption = 'Quantity Allocated';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.41';
            Editable = false;
        }
        field(50030; "Post To FND"; Option)
        {
            Caption = 'Post To';
            Description = 'HEI.45';
            OptionCaption = 'Include,Skip';
            OptionMembers = Include,Skip;
        }
        field(50060; "Source System Identifier FND"; Code[10])
        {
            Caption = 'Source System Identifier';
            Description = 'HEI.25';
            Editable = false;
            TableRelation = "Source Sys Identifier API FND";
        }
        //HEI.48>>
        field(50061; "Production jnl. flushing FND"; Boolean)
        {
            Caption = 'Production jnl. flushing';
            Description = 'HEI.48';
        }
        //HEI.48<<

        //---BC Upgrade KAMNAY01>>
        //BC Upgrade GUNREM01 >> Added DIT field
        field(50062; "Gyle No. FND"; Code[20])
        {
            CaptionML = ENU = 'Gyle No.',
                        FRA = 'Gyle N°';
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        }

        field(54000; "Your Reference FND"; Text[30])
        {
            Caption = 'Your Reference';
            DataClassification = ToBeClassified;
        }

        // BC Upgrade Kamnay01  FDD DTW 011 >>Addeed Strength Value field as part of DIT requirement. This field will capture the average of "Strength 3 Value 101FDW" from Reservation Entry table for the given Journal Line.
        field(50063; "Strength Value FND"; Decimal)
        {
            caption = 'Strength Value';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = average("Reservation Entry"."Strength 3 Value 101FDW"
        WHERE(
            "Source Type" = CONST(83),
            "Source Subtype" = CONST(6),
            "Source ID" = FIELD("Journal Template Name"),
            "Source Batch Name" = FIELD("Journal Batch Name"),
            "Source Ref. No." = FIELD("Line No."),
            "Source Prod. Order Line" = CONST(0)
        ));
        }
        //BC Upgrade Kamnay01  FDD DTW 011 <<Added Strength Value field as part of DIT requirement. This field will capture the average of "Strength 3 Value 101FDW" from Reservation Entry table for the given Journal Line.
        //BC Upgrade GUNREM01 << Added DIT field 
        // field(2013610;"Item DDeposit Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Charge Deposit Group Code',
        //                 FRA='Code groupe frais annexes consigne';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code WHERE ("Source Type"=CONST(Item));
        // }
        // field(2013611;"Empty Goods Item No.";Code[20])
        // {
        //     CaptionML = ENU='Empty Goods Item No.',
        //                 FRA='N° article vidange';
        //     Description = 'DITW15.00.00.01-.35';
        //     TableRelation = Item WHERE ("Empty Good"=CONST(true));
        // }
        // field(2013612;"Item Charge Quantity per";Decimal)
        // {
        //     CaptionML = ENU='Item Charge Quantity per',
        //                 FRA='Quantité frais annexes par';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.01';
        //     MinValue = 0;
        // }
        // field(2013623;"Source Deposit Group Code";Code[10])
        // {
        //     CaptionML = ENU='Cust/Vend DepositChrg.Gr. Code',
        //                 FRA='Code groupe coût consigne Cleint/Fourn.';
        //     Description = 'DITW15.00.00.30';
        //     TableRelation = "Drink Deposit Group".Code WHERE ("Source Type"=FIELD("Source Type"));
        // }
        // field(2013637;"Deposit Value";Decimal)
        // {
        //     AutoFormatType = 2;
        //     Caption = 'Deposit Value';
        //     Description = 'DITW110.00.11 BL#14417';
        // }
        // field(2013660;"Extra Charge Type";Option)
        // {
        //     CaptionML = ENU='Extra Charge Type',
        //                 FRA='Type frais extra';
        //     Description = 'DITW15.00.00.24-.34';
        //     OptionCaptionML = ENU=' ,Amount,Price %,Amount %,Fixed Amount,Volume /Unit,Weight,Cubage,Distance,Price Item',
        //                       FRA=' ,Montant,Prix %,Montant %,Montant Fixe,Volume /Unit,Poids,Cubage,Distance,Prix Article';
        //     OptionMembers = " ",Amount,"Price %","Amount %","Fixed Amount",VolumeHL,Weight,Cubage,Distance,"Price Item";
        // }
        // field(2013661;"Item Charge Value";Decimal)
        // {
        //     AutoFormatExpression = GetAutoformatRoundingType('');
        //     AutoFormatType = 2;
        //     CaptionML = ENU='Item Charge Value',
        //                 FRA='Valeur frais annexes';
        //     Description = 'DITW15.00.00.32';
        // }
        // field(2013662;"Is Item Charge";Boolean)
        // {
        //     CaptionML = ENU='Is Item Charge',
        //                 FRA='Est frais annexes';
        //     Description = 'VC8-DITW15.00.00.01';
        // }
        // field(2013663;"Item Charge Incl. Price";Boolean)
        // {
        //     CaptionML = ENU='Item Charge Incl. Price',
        //                 FRA='Frais annexe inclus prix';
        //     Description = 'VC8-DITW15.00.00.01';
        // }
        // field(2013667;"Item DTax Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Charge Tax Group Code',
        //                 FRA='Code groupe frais annexes taxe';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Item));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/08/2010 #1217
        //         UpdateAADInfo();
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2013694;"Opposite Amount Sign";Boolean)
        // {
        //     CaptionML = ENU='Opposite Amount Sign',
        //                 FRA='Signe opposé montant';
        //     Description = 'DITW15.00.00.25';
        // }
        // field(2013695;"Item Charge Type";Option)
        // {
        //     CaptionML = ENU='Item Charge Type',
        //                 FRA='Type frais annexes';
        //     Description = 'DITW15.00.00.01';
        //     OptionCaptionML = ENU=' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA=' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;

        //     trigger OnValidate();
        //     begin
        //         if "Item Charge Type" <> "Item Charge Type"::" " then
        //           TESTFIELD("Item Charge No.");
        //     end;
        // }
        // field(2013696;"Location Group Code";Code[10])
        // {
        //     CaptionML = ENU='Location Tax Group Code',
        //                 FRA='Code groupe magasin taxe';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Location Group";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/08/2010 #1217
        //         UpdateAADInfo();
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2013708;"Due Tax";Boolean)
        // {
        //     CaptionML = ENU='Due Tax',
        //                 FRA='Taxe due';
        //     Description = 'DITW15.00.00.01';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.24 DDR 25/09/2008 - 07/10/2008
        //         TESTFIELD("Item Charge Type","Item Charge Type"::Tax);
        //         // >>DITW15.00.00.24 DDR
        //         // <<DITW15.00.00.38 DDR 23/08/2010 #1217
        //         TestDutySuspendMandatory();
        //         // >>DITW15.00.00.38 DDR

        //         // <<DITW17.10.05 MSF 20/11/2014 DIT-770 #701
        //         TestTaxDueMandatory ();
        //         // >>DITW17.10.05 MSF 20/11/2014 DIT-770 #701
        //     end;
        // }
        // field(2013711;"Initial Entry Due Date";Date)
        // {
        //     CaptionML = ENU='Initial Entry Due Date',
        //                 FRA='Date d''échéance écr. initiale';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013715;"Tax Formula";Code[80])
        // {
        //     CaptionML = ENU='Tax Formula',
        //                 FRA='Formule taxe';
        //     Description = 'DITW15.00.00.34';
        // }
        // field(2013716;"Strength Spec. Code";Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0,FIELDNO("Strength Spec. Code"));
        //     CaptionML = ENU='Strength Spec. Code',
        //                 FRA='Code contrainte spécification taxe';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" WHERE (Type=CONST(Specification));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        //     end;
        // }
        // field(2013717;"Strength Spec. Value";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("Strength Spec. Value"));
        //     CaptionML = ENU='Strength Spec. Value',
        //                 FRA='Valeur contrainte spécification';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        //     end;
        // }
        // field(2013718;"Vol-Strength Spec. Code";Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0,FIELDNO("Vol-Strength Spec. Code"));
        //     CaptionML = ENU='Vol-Strength Spec. Code',
        //                 FRA='Code spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" WHERE (Type=CONST(Specification));
        // }
        // field(2013719;"Vol-Strength Spec. Value";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Vol-Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("Vol-Strength Spec. Value"));
        //     CaptionML = ENU='Vol-Strength Spec. Value',
        //                 FRA='Valeur spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        //     end;
        // }
        // field(2013720;"New Strength Spec. Value";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("New Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("New Strength Spec. Value"));
        //     CaptionML = ENU='New Strength Spec. Value',
        //                 FRA='Nouvelle valeur spécification contrainte';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 17/08/2016 29/09/2016 BL#10443
        //     end;
        // }
        // field(2013721;"New Vol-Strength Spec. Value";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("New Vol-Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("New Vol-Strength Spec. Value"));
        //     CaptionML = ENU='New Vol-Strength Spec. Value',
        //                 FRA='Nouvelle valeur spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 17/08/2016 29/09/2016 BL#10443
        //     end;
        // }
        // field(2013722;"Duty Suspended";Boolean)
        // {
        //     CaptionML = ENU='Duty Suspended',
        //                 FRA='Taxe en suspension';
        //     Description = 'DITW15.00.00.33';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 29/01/2010
        //         TESTFIELD("Item Charge Type","Item Charge Type"::Tax);
        //         // >>DITW15.00.00.37 DDR
        //         // <<DITW15.00.00.38 DDR 23/08/2010 #1217
        //         TestDutySuspendMandatory();
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2013724;Reverse;Boolean)
        // {
        //     CaptionML = ENU='Reverse',
        //                 FRA='Contrepasser';
        //     Description = 'DITW19.00.08A BL#10443';
        // }
        // field(2013726;"Company Tax Registration No.";Text[20])
        // {
        //     CaptionML = ENU='Company Tax Registration No.',
        //                 FRA='N° identif. accise société';
        //     Description = 'DITW15.00.00.37';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 29/01/2010
        //         TESTFIELD("Item No.");
        //         // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW16.00.00.43 DDR DIT-715 #768
        //         // >>DITW15.00.00.37 DDR
        //     end;
        // }
        // field(2013727;"AAD No. Series";Code[10])
        // {
        //     CaptionML = ENU='AAD No. Series',
        //                 FRA='Souches de n° DAA';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "No. Series";

        //     trigger OnLookup();
        //     var
        //         lrSalesLine : Record "Sales Line";
        //         lrNoSeries : Record "No. Series";
        //         lDefaultAADCode : Code[10];
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/08/2010 #1217
        //         TESTFIELD("LRN No. Series",'');
        //         TESTFIELD("LRN No.",'');
        //         // >>DITW15.00.00.38 DDR
        //         // <<DITW15.00.00.37 DDR 29/01/2010
        //         TESTFIELD("Item No.");

        //         // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW16.00.00.43 DDR DIT-715 #768

        //         lDefaultAADCode := GetAADNoSeries();
        //         if lDefaultAADCode <> '' then begin
        //           if NoSeriesMgt.LookupSeries(lDefaultAADCode,"AAD No. Series") then
        //             VALIDATE("AAD No. Series");
        //         end else begin
        //           if PAGE.RUNMODAL(0,lrNoSeries) = ACTION::LookupOK then
        //             VALIDATE("AAD No. Series",lrNoSeries.Code);
        //         end;
        //     end;

        //     trigger OnValidate();
        //     var
        //         lDefaultAADCode : Code[10];
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/08/2010 #1217
        //         TESTFIELD("LRN No. Series",'');
        //         TESTFIELD("LRN No.",'');
        //         // >>DITW15.00.00.38 DDR
        //         // <<DITW15.00.00.37 DDR 29/01/2010
        //         TESTFIELD("Item No.");

        //         // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW16.00.00.43 DDR DIT-715 #768

        //         if "AAD No. Series" <> '' then begin
        //           lDefaultAADCode := GetAADNoSeries();
        //           if lDefaultAADCode <> '' then
        //             cduNoSeriesMgt.TestSeries(lDefaultAADCode,"AAD No. Series");
        //           // <<DITW15.00.00.38 DDR 23/08/2010 #1217
        //           TestAADNoSeriesMandatory();
        //           // >>DITW15.00.00.38 DDR
        //         end;
        //         TESTFIELD("AAD No.",'');
        //     end;
        // }
        // field(2013728;"AAD No.";Code[20])
        // {
        //     CaptionML = ENU='AAD No.',
        //                 FRA='N° DAA';
        //     Description = 'DITW15.00.00.37';

        //     trigger OnLookup();
        //     var
        //         lrAADTrackingEntry : Record "AAD Tracking Entry";
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/08/2010 #1217
        //         TESTFIELD("LRN No. Series",'');
        //         TESTFIELD("LRN No.",'');
        //         // >>DITW15.00.00.38 DDR
        //         // <<DITW15.00.00.37 DDR 29/01/2010
        //         TESTFIELD("Item No.");

        //         // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW16.00.00.43 DDR DIT-715 #768

        //         // <<DITW15.00.00.38 DDR 23/08/2010 #1217
        //         TestAADNoSeriesMandatory();
        //         // >>DITW15.00.00.38 DDR

        //         if "AAD No. Series" <> '' then
        //           NoSeriesMgt.TestManual("AAD No. Series");

        //         lrAADTrackingEntry.SETCURRENTKEY("AAD No.");
        //         lrAADTrackingEntry.FILTERGROUP(2);
        //         lrAADTrackingEntry.SETFILTER("AAD No.",'<>%1','');
        //         lrAADTrackingEntry.FILTERGROUP(0);
        //         lrAADTrackingEntry.SETRANGE("Item No.","Item No.");
        //         lrAADTrackingEntry.SETRANGE("Location Code","Location Code");
        //         if PAGE.RUNMODAL(PAGE::"AAD Tracking List",lrAADTrackingEntry) = ACTION::LookupOK then begin
        //           "AAD No." := lrAADTrackingEntry."AAD No.";
        //         end;
        //     end;

        //     trigger OnValidate();
        //     var
        //         lrAADTrackingEntry : Record "AAD Tracking Entry";
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/08/2010 #1217
        //         TESTFIELD("LRN No. Series",'');
        //         TESTFIELD("LRN No.",'');
        //         // >>DITW15.00.00.38 DDR
        //         // <<DITW15.00.00.37 DDR 29/01/2010
        //         if "AAD No." <> '' then begin
        //           if "AAD No. Series" <> '' then
        //             NoSeriesMgt.TestManual("AAD No. Series");
        //           cduAADDocMgt.CheckAADNo("AAD No.");
        //           TESTFIELD("Tariff No.");
        //         end;
        //     end;
        // }
        // field(2013729;"Tariff No.";Code[10])
        // {
        //     CaptionML = ENU='Tariff No.',
        //                 FRA='Nomenclature produits';
        //     Description = 'DITW15.00.00.34';
        //     TableRelation = "Tariff Number";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 29/01/2010
        //         TESTFIELD("Item No.");
        //         // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW16.00.00.43 DDR DIT-715 #768
        //         // >>DITW15.00.00.37 DDR
        //     end;
        // }
        // field(2013733;"Tax Date";Date)
        // {
        //     CaptionML = ENU='Tax Date',
        //                 FRA='Date taxe';
        //     Description = 'DITW15.00.00.39 #1363';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.39 DDR 19/10/2011 #1363
        //         UpdateCharges(FIELDNO("Tax Date"),(CurrFieldNo = FIELDNO("Tax Date")));
        //         UpdateAmount();
        //         // >>DITW15.00.00.39 DDR #1363
        //     end;
        // }
        // field(2013751;"Source DTax Group Code";Code[20])
        // {
        //     CaptionML = ENU='Cust/Vendor Tax Group Code',
        //                 FRA='Code groupe taxe Client/Fourn.';
        //     Description = 'DITW15.00.00.30-.39 #1370,HEI.09';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=FIELD("Source Type"));
        // }
        // field(2013752;"Strength Spec. Value (Calcd.)";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Strength Spec. Value (Calcd.)"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("Strength Spec. Value (Calcd.)"));
        //     CaptionML = ENU='Strength Spec. Value (Calculated)',
        //                 FRA='Valeur spécification contrainte (Calculée)';
        //     Description = 'DITW19.00.08 BL#10443';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //         TESTFIELD("Value Entry Type","Value Entry Type"::Revaluation);
        //         TESTFIELD("Strength Spec. Code");
        //         GetItem;
        //         if ("Strength Spec. Value (Calcd.)" <> xRec."Strength Spec. Value (Calcd.)") and (CurrFieldNo = FIELDNO("Strength Spec. Value (Calcd.)")) then
        //           Item.TESTFIELD("Strength Method",Item."Strength Method"::Variable);
        //         "Vol-Strength Value (Calcd.)" := CalcVolumeStrength(Quantity,"Strength Spec. Value (Calcd.)","Unit Volume HL (Calculated)");
        //     end;
        // }
        // field(2013753;"Vol-Strength Value (Calcd.)";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Vol-Strength Value (Calcd.)"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("Vol-Strength Value (Calcd.)"));
        //     CaptionML = ENU='Vol-Strength Spec. Value (Calculated)',
        //                 FRA='Valeur spécification contrainte volume (Calculée)';
        //     Description = 'DITW19.00.08 BL#10443';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //         TESTFIELD("Value Entry Type","Value Entry Type"::Revaluation);
        //         TESTFIELD("Vol-Strength Spec. Code");
        //     end;
        // }
        // field(2013754;"Strength Spec. Value (Reval.)";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Strength Spec. Value (Reval.)"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("Strength Spec. Value (Reval.)"));
        //     CaptionML = ENU='Strength Spec. Value (Revalued)',
        //                 FRA='Valeur spécification contrainte (Réévaluée)';
        //     Description = 'DITW19.00.08 BL#10443';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //         TESTFIELD("Value Entry Type","Value Entry Type"::Revaluation);
        //         TESTFIELD("Strength Spec. Code");
        //         TESTFIELD(Quantity);
        //         GetItem;
        //         if ("Strength Spec. Value (Reval.)" <> xRec."Strength Spec. Value (Reval.)") and (CurrFieldNo = FIELDNO("Strength Spec. Value (Reval.)")) then begin
        //           //CheckItemCarrySNLot(FIELDCAPTION("Strength Spec. Value"));
        //           Item.TESTFIELD("Strength Method",Item."Strength Method"::Variable);
        //         end;
        //         "Vol-Strength Value (Reval.)" := CalcVolumeStrength(Quantity,"Strength Spec. Value (Reval.)","Unit Volume HL (Revalued)");
        //         if "Strength Spec. Value (Reval.)" <> 0 then
        //           "Unit Volume HL (Revalued)" := ROUND("Vol-Strength Value (Reval.)" / ("Strength Spec. Value (Reval.)" * Quantity),0.00001)
        //         else
        //           "Unit Volume HL (Revalued)" := 0;
        //         if BeverageSetup.READPERMISSION then begin
        //           "Quantity (Brewing Base) Reval." := ROUND(Quantity * "Unit Volume HL (Revalued)",0.00001);
        //         end;
        //     end;
        // }
        // field(2013755;"Vol-Strength Value (Reval.)";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Vol-Strength Value (Reval.)"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("Vol-Strength Value (Reval.)"));
        //     CaptionML = ENU='Vol-Strength Spec. Value (Revalued)',
        //                 FRA='Valeur spécification contrainte volume (Réévaluée)';
        //     Description = 'DITW19.00.08 BL#10443';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //         TESTFIELD("Value Entry Type","Value Entry Type"::Revaluation);
        //         TESTFIELD("Vol-Strength Spec. Code");
        //         if ("Vol-Strength Value (Reval.)" <> xRec."Vol-Strength Value (Reval.)") and (CurrFieldNo = FIELDNO("Vol-Strength Value (Reval.)")) then begin
        //           //CheckItemCarrySNLot(FIELDCAPTION("Vol-Strength Spec. Value"));
        //         end;
        //         TESTFIELD(Quantity);
        //         if "Vol-Strength Value (Reval.)" <> 0 then
        //           VALIDATE("Strength Spec. Value (Reval.)",ROUND("Vol-Strength Value (Reval.)" / ("Unit Volume HL (Revalued)" * Quantity),0.00001))
        //         else
        //           VALIDATE("Strength Spec. Value (Reval.)",0);
        //     end;
        // }
        // field(2013767;"Unit Volume HL";Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Unit Volume HL"));
        //     CaptionML = ENU='Unit Volume',
        //                 FRA='Volume unitaire';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.01';
        //     MinValue = 0;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        //         if ("Item Charge No." = '') or ("Tax Item No." <> '') then begin
        //           if BeverageSetup.READPERMISSION then begin
        //             "Quantity (Brewing Base)" := ROUND(Quantity * "Unit Volume HL",0.00001);
        //           end;
        //         end;
        //     end;
        // }
        // field(2013768;"New Unit Volume HL";Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("New Unit Volume HL"));
        //     CaptionML = ENU='New Unit Volume',
        //                 FRA='Volume unitaire';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW18.00.06 DIT-770 #1395';
        //     MinValue = 0;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 17/08/2016 29/09/2016 20/10/2016 BL#10443
        //         TESTFIELD("Entry Type","Entry Type"::Transfer);
        //         if ("Item Charge No." = '') or ("Tax Item No." <> '') then begin
        //           if BeverageSetup.READPERMISSION then begin
        //             "New Quantity (Brewing Base)" := ROUND(Quantity * "New Unit Volume HL",0.00001);
        //           end;
        //         end;
        //     end;
        // }
        // field(2013769;"Unit Volume HL (Calculated)";Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Unit Volume HL (Calculated)"));
        //     CaptionML = ENU='Unit Volume (Calculated)',
        //                 FRA='Volume unitaire (Calculé)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW19.00.08 BL#10443';
        //     MinValue = 0;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //         TESTFIELD("Value Entry Type","Value Entry Type"::Revaluation);
        //         if ("Item Charge No." = '') or ("Tax Item No." <> '') then begin
        //           if "Strength Spec. Code" <> '' then
        //             VALIDATE("Strength Spec. Value (Calcd.)");
        //           if BeverageSetup.READPERMISSION then begin
        //             "Quantity (Brewing Base) Calcd." := ROUND(Quantity * "Unit Volume HL (Calculated)",0.00001);
        //           end;
        //         end;
        //     end;
        // }
        // field(2013770;"Unit Volume HL (Revalued)";Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Unit Volume HL (Revalued)"));
        //     CaptionML = ENU='Unit Volume (Revalued)',
        //                 FRA='Volume unitaire (Réévalué)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW19.00.08 BL#10443';
        //     MinValue = 0;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //         TESTFIELD("Value Entry Type","Value Entry Type"::Revaluation);
        //         if ("Item Charge No." = '') or ("Tax Item No." <> '') then begin
        //           if "Strength Spec. Code" <> '' then
        //             VALIDATE("Strength Spec. Value (Reval.)");
        //           if BeverageSetup.READPERMISSION then begin
        //             "Quantity (Brewing Base) Reval." := ROUND(Quantity * "Unit Volume HL (Revalued)",0.00001);
        //           end;
        //         end;
        //     end;
        // }
        // field(2013774;"Item DDisc. Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Discount Group',
        //                 FRA='Groupe remise article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Discount Group".Code WHERE ("Source Type"=CONST(Item));
        // }
        // field(2013776;"Item DPromo. Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Promotion Group',
        //                 FRA='Groupe promotion article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Promotion Group".Code WHERE ("Source Type"=CONST(Item));
        // }
        // field(2013777;"Item Charge Calculate per";Option)
        // {
        //     CaptionML = ENU='Item Charge Calculate per',
        //                 FRA='Frais annexe calcul par';
        //     Description = 'DITW15.00.00.01';
        //     OptionCaptionML = ENU='Item,Order',
        //                       FRA='Article,Commande';
        //     OptionMembers = Item,"Order";
        // }
        // field(2013778;"Opposite Qty. Sign";Boolean)
        // {
        //     CaptionML = ENU='Opposite Qty. Sign',
        //                 FRA='Signe opposé quantité';
        //     Description = 'DITW15.00.00.24';
        // }
        // field(2013779;"Using Qty. (Base)";Boolean)
        // {
        //     CaptionML = ENU='Using Qty. (Base)',
        //                 FRA='Utilisation quantité (Base)';
        //     Description = 'DITW15.00.00.24';
        // }
        // field(2013783;"Discount Level Position";Integer)
        // {
        //     CaptionML = ENU='Discount Level Position',
        //                 FRA='Position niveau de remise';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013785;"Periodic Disc.-Promo Entry No.";Integer)
        // {
        //     CaptionML = ENU='Periodic Disc.-Promo Entry No.',
        //                 FRA='N° écriture Remise-Promotion périodique';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Sales Discount.-Promo. Entry"."Entry No.";
        // }
        // field(2013788;"DDiscount Include Tax";Boolean)
        // {
        //     CaptionML = ENU='DDiscount Include Tax',
        //                 FRA='Remise inculent taxe';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013789;"DDiscount Include Deposit";Boolean)
        // {
        //     CaptionML = ENU='DDiscount Include Deposit',
        //                 FRA='Remise incluent caution';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013790;"DDiscount Include Discount";Boolean)
        // {
        //     CaptionML = ENU='DDiscount Include Discount',
        //                 FRA='Remise incluent remise';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013803;"Allow VAT Calculation (Free)";Boolean)
        // {
        //     CaptionML = ENU='Allow VAT Calculation (Free)',
        //                 FRA='Autoriser calcul TVA (Gratuit)';
        //     Description = 'DITW16.00.00.40 DIT-715 #172';
        // }
        // field(2013824;"Gen. Prod. Posting Free Group";Code[10])
        // {
        //     CaptionML = ENU='Gen. Prod. Posting Group Free Item',
        //                 FRA='Groupe article gratuit compta. produit';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Gen. Product Posting Group";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009
        //         if "Gen. Prod. Posting Free Group" <> '' then
        //           TESTFIELD("Free Item Posting Type")
        //         else begin
        //           "Free Item Posting Type" := "Free Item Posting Type"::" ";
        //           "Free Item" := false;
        //         end;
        //     end;
        // }
        // field(2013825;"Free Item Posting Type";Option)
        // {
        //     CaptionML = ENU='Calculate Price on Free',
        //                 FRA='Calculer Prix sur gratuit';
        //     Description = 'DITW15.00.00.35';
        //     OptionCaptionML = ENU=' ,Price 0,Discount 100%',
        //                       FRA=' ,Prix 0,Remise 100%';
        //     OptionMembers = " ",Price,Amount;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009
        //         if "Free Item Posting Type" = "Free Item Posting Type"::" " then begin
        //           "Gen. Prod. Posting Free Group" := '';
        //           "Free Item" := false;
        //         end;
        //     end;
        // }
        // field(2013826;"Free Item";Boolean)
        // {
        //     CaptionML = ENU='Free Item',
        //                 FRA='Article gratuit';
        //     Description = 'DITW15.00.00.35';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009
        //         if "Free Item" then begin
        //           if "Free Item Posting Type" = "Free Item Posting Type"::Price then
        //             TESTFIELD("Unit Amount",0);
        //           if "Free Item Posting Type" = "Free Item Posting Type"::Price then begin
        //             TESTFIELD(Amount,0);
        //             TESTFIELD("Discount Amount",0);
        //           end;
        //         end;
        //     end;
        // }
        // field(2013827;"Free Calculation Type";Option)
        // {
        //     CaptionML = ENU='Calculate on Free',
        //                 FRA='Calculer sur gratuit';
        //     Description = 'DITW15.00.00.35';
        //     OptionCaptionML = ENU='None,Discount 100%,Full Amount',
        //                       FRA='Aucun,Remise 100%,Montant';
        //     OptionMembers = "None","Discount 100%",All;
        // }
        // field(2013828;"Include Free Qty. in Minimum";Boolean)
        // {
        //     CaptionML = ENU='Include Free Quantity in Minimum',
        //                 FRA='Inclure quantité gratuite avec minimum';
        //     Description = 'DITW15.00.00.35';
        // }
        // field(2013829;"Free Reason Code";Code[10])
        // {
        //     CaptionML = ENU='Free Reason Code',
        //                 FRA='Code motif gratuit';
        //     Description = 'DITW17.00.02 DIT-770 #132';
        //     TableRelation = "Free Reason Code";

        //     trigger OnValidate();
        //     begin
        //         //<< DITW17.00.02 TEC1 12/09/2013 DIT-770 #132
        //         TESTFIELD("Free Item",true);
        //         //>> DITW17.00.02 TEC1 DIT-770 #132
        //     end;
        // }
        // field(2014078;"Driver Code";Code[10])
        // {
        //     Caption = 'Driver Code';
        //     Description = 'NRQ#43572';
        //     TableRelation = "Whse. Shipping Driver".Code;
        // }
        // field(2014094;"Physical Location Group Code";Code[10])
        // {
        //     CaptionML = ENU='Physical Location Group Code',
        //                 FRA='Code groupe magasin réel';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Physical Location Group" WHERE (Code=FIELD("Phys. Location Table Filter"));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 06/10/2009
        //         InvtSetup.GET;

        //         if xRec."Physical Location Group Code" <> "Physical Location Group Code" then begin
        //         end;

        //         // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1189
        //         if ("Responsibility Center" = xRec."Responsibility Center") and
        //           ("Physical Location Group Code" <> xRec."Physical Location Group Code") and
        //           ("Physical Location Group Code" <> '')
        //         then
        //           VALIDATE("Responsibility Center",
        //             UserSetupMgt.GetFirstRespCenter(EntryTypeToRespID,"Physical Location Group Code",''));
        //         // >>DITW18.00.06 DDR DIT-770 #1189


        //         // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
        //         if xRec."Physical Location Group Code" <> "Physical Location Group Code" then
        //           if not UserSetupMgt.CheckPhysLocation(EntryTypeToRespID,"Physical Location Group Code","Responsibility Center") then
        //             ERROR(
        //               Text2014414,
        //               PhysLocationGr.TABLECAPTION,"Physical Location Group Code",
        //               RespCenter.TABLECAPTION,GetRespCenterCode);
        //         // >>DITW18.00.06 DDR DIT-770 #1189

        //         GetLocation("Location Code");

        //         // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
        //         if ((xRec."Physical Location Group Code" <> "Physical Location Group Code") or (CurrFieldNo = 0)) and
        //           ("Location Code" <> '')
        //         then begin
        //           GetLocation("Location Code");
        //           if (Location."Physical Location Group Code" <> "Physical Location Group Code") then begin
        //             if ((CurrFieldNo <> FIELDNO("Location Code")) and (xRec."Responsibility Center" = "Responsibility Center")) or
        //               (CurrFieldNo = FIELDNO("Physical Location Group Code"))
        //             then
        //               VALIDATE("Location Code",'')
        //             else
        //               "Location Code" := '';
        //           end;
        //         end;
        //         // >>DITW18.00.06 DDR DIT-770 #1189

        //         // <<DITW18.00.06 DDR 27/02/2015 DIT-770 #1190
        //         if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
        //           UpdateCharges2(FIELDNO("Physical Location Group Code"),true);
        //         // >>DITW18.00.06 DDR DIT-770 #1190
        //     end;
        // }
        // field(2014109;"Route Planning No.";Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'DITW18.00.07 #1488 - NRQ16224';
        //     TableRelation = "Route Planning Worksheet";
        // }
        // field(2014110;"New Location Group Code";Code[10])
        // {
        //     CaptionML = ENU='New Location Tax Group Code',
        //                 FRA='Nouveau Code groupe magasin taxe';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Location Group";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //         TESTFIELD("Entry Type","Entry Type"::Transfer);
        //         // >>DITW19.00.08 DDR BL#10443
        //     end;
        // }
        // field(2014111;"New Phys. Location Group Code";Code[10])
        // {
        //     CaptionML = ENU='New Physical Location Group Code',
        //                 FRA='Nouveau Code groupe magasin réel';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Physical Location Group" WHERE (Code=FIELD("Phys. Location Table Filter"));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //         TESTFIELD("Entry Type","Entry Type"::Transfer);
        //         // >>DITW19.00.08 DDR BL#10443
        //         // <<DITW15.00.00.37 DDR 20/05/2010
        //         InvtSetup.GET;

        //         if xRec."New Phys. Location Group Code" <> "New Phys. Location Group Code" then begin
        //         end;

        //         GetLocation("New Location Code");
        //         if (Location."Physical Location Group Code" <> '') and
        //           ("New Phys. Location Group Code" <> '')
        //         then
        //           TESTFIELD("New Phys. Location Group Code",Location."Physical Location Group Code");

        //         if (CurrFieldNo = FIELDNO("New Phys. Location Group Code")) and ("New Phys. Location Group Code" <> '') then
        //           VALIDATE("New Location Code");
        //     end;
        // }
        // field(2014113;"Tax Item No.";Code[20])
        // {
        //     CaptionML = ENU='Tax Tracking Item No.',
        //                 FRA='N° article traçable Taxe';
        //     Description = 'DITW15.00.00.38 #703';
        //     TableRelation = Item;

        //     trigger OnValidate();
        //     var
        //         TempItemJnlLineTax : Record "Item Journal Line" temporary;
        //     begin
        //         // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //         CLEAR(Item);
        //         CLEAR(TempItemJnlLineTax);
        //         if "Tax Item No." <> '' then begin
        //           GetTaxItem;
        //           TempItemJnlLineTax."Journal Template Name" := "Journal Template Name";
        //           TempItemJnlLineTax."Journal Batch Name" := "Journal Batch Name";
        //           TempItemJnlLineTax."Document No." := "Document No.";
        //           TempItemJnlLineTax.VALIDATE("Posting Date","Posting Date");
        //           TempItemJnlLineTax.VALIDATE("Entry Type","Entry Type");
        //           // <<DITW16.00.00.43 DDR 03/12/2013 DIT-715 #861
        //           TempItemJnlLineTax.Type := Type;
        //           TempItemJnlLineTax."No." := "No.";
        //           TempItemJnlLineTax."Operation No." := "Operation No.";
        //           TempItemJnlLineTax."Work Center No." := "Work Center No.";
        //           // <<DITW17.00.02 DDR 02/12/2013 DIT-715 #861
        //           //TempItemJnlLineTax."Prod. Order No." := "Prod. Order No.";
        //           //TempItemJnlLineTax."Prod. Order Line No." := "Prod. Order Line No.";
        //           TempItemJnlLineTax."Order Type" := "Order Type";
        //           TempItemJnlLineTax."Order No." := "Order No.";
        //           TempItemJnlLineTax."Order Line No." := "Order Line No.";
        //           // >>DITW17.00.02 DDR DIT-715 #861
        //           TempItemJnlLineTax."Prod. Order Comp. Line No." := "Prod. Order Comp. Line No.";
        //           TempItemJnlLineTax."Output Quantity" := "Output Quantity";
        //           TempItemJnlLineTax."Scrap Quantity" := "Scrap Quantity";
        //           TempItemJnlLineTax."Output Quantity (Base)" := "Output Quantity (Base)";
        //           TempItemJnlLineTax."Scrap Quantity (Base)" := "Scrap Quantity (Base)";
        //           TempItemJnlLineTax."Session ID" := "Session ID";
        //           TempItemJnlLineTax."Gyle No." := "Gyle No.";
        //           TempItemJnlLineTax."Work Center Group Code" := "Work Center Group Code";
        //           TempItemJnlLineTax."Work Shift Code" := "Work Shift Code";
        //           TempItemJnlLineTax."Work Order No." := "Work Order No.";
        //           TempItemJnlLineTax."Work Order Line No." := "Work Order Line No.";
        //           TempItemJnlLineTax."Routing No." := "Routing No.";
        //           TempItemJnlLineTax."Routing Reference No." := "Routing Reference No.";
        //           TempItemJnlLineTax.Finished := Finished;
        //           TempItemJnlLineTax.Subcontracting := Subcontracting;
        //           TempItemJnlLineTax."Location Code" := "Location Code";
        //           //HEI.01 PRDGAP024>>
        //           if "Bin Code" <> '' then begin
        //             Bin.GET("Location Code","Bin Code");
        //             TempItemJnlLineTax."Zone Code" := Bin."Zone Code";
        //           end;
        //           //HEI.01 PRDGAP024<<
        //           TempItemJnlLineTax."Bin Code" := "Bin Code";
        //           // >>DITW16.00.00.43 DDR DIT-715 #861
        //           TempItemJnlLineTax.VALIDATE("Item No.","Tax Item No.");
        //           // <<DITW16.00.00.43 DDR 03/12/2013 DIT-715 #861
        //           if "Location Code" <> '' then begin
        //           // >>DITW16.00.00.43 DDR DIT-715 #861
        //             // <<DITW16.00.00.43 DDR 18/12/2013 DIT-715 #766
        //             TempItemJnlLineTax."Physical Location Group Code" := '';
        //             // >>DITW16.00.00.43 DDR DIT-715 #766
        //             TempItemJnlLineTax.VALIDATE("Location Code","Location Code");
        //           end;
        //           // <<DITW16.00.00.43 DDR 03/12/2013 DIT-715 #861
        //            //HEI.01 PRDGAP024>>
        //           if "Bin Code" <> '' then begin
        //             Bin.GET("Location Code","Bin Code");
        //             TempItemJnlLineTax."Zone Code" := Bin."Zone Code";
        //           end;
        //           //HEI.01 PRDGAP024<<
        //           if "Bin Code" <> '' then
        //             TempItemJnlLineTax.VALIDATE("Bin Code","Bin Code");
        //           TempItemJnlLineTax.VALIDATE("Unit of Measure Code","Unit of Measure Code");
        //           TempItemJnlLineTax.VALIDATE(Quantity,Quantity);
        //           // >>DITW16.00.00.43 DDR DIT-715 #861
        //           TempItemJnlLineTax.UpdateAADInfo();
        //         end;
        //         "Item Category Code" := TempItemJnlLineTax."Item Category Code";
        //         "Product Group Code" := TempItemJnlLineTax."Product Group Code";
        //         // <<DITW18.00.06 DDR 03/11/2015 DIT-770 #1395
        //         "Unit Volume HL" := 0;
        //         "New Unit Volume HL" := 0;
        //         if "Location Code" <> '' then
        //           "Unit Volume HL" := TempItemJnlLineTax."Unit Volume HL";
        //         // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        //         if "Entry Type" = "Entry Type"::Transfer then
        //           "New Unit Volume HL" := TempItemJnlLineTax."Unit Volume HL";
        //         // >>DITW19.00.08 DDR BL#10443
        //         // >>DITW18.00.06 DDR DIT-770 #1395

        //         if ("Line No." <> 0) and (CurrFieldNo <> 0) and ("Attached to Line No." <> 0) then begin
        //           if not ItemJnlLine.GET("Journal Template Name","Journal Batch Name","Attached to Line No.") then begin
        //             rTempItemJnlLine.GET("Journal Template Name","Journal Batch Name","Attached to Line No.");
        //             ItemJnlLine := rTempItemJnlLine;
        //           end;
        //           "Unit Volume HL" := "Unit Volume HL" * ItemJnlLine."Qty. per Unit of Measure";
        //           // <<DITW18.00.06 DDR 03/11/2015 DIT-770 #1395
        //           if "Entry Type" = "Entry Type"::Transfer then
        //             "New Unit Volume HL" := "New Unit Volume HL" * ItemJnlLine."Qty. per Unit of Measure";
        //           // >>DITW18.00.06 DDR DIT-770 #1395
        //         end;

        //         // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        //         VALIDATE("Unit Volume HL");
        //         VALIDATE("New Unit Volume HL");
        //         // >>DITW19.00.08 DDR BL#10443

        //         "Tariff No." := TempItemJnlLineTax."Tariff No.";

        //         // <<DITW16.00.00.43 DDR 23/10/2013 DIT-715 #768
        //         if "Item Charge Type" = "Item Charge Type"::Tax then begin
        //         // >>DITW16.00.00.43 DDR DIT-715 #768
        //           "Item DTax Group Code" := TempItemJnlLineTax."Item DTax Group Code";
        //           "Company Tax Registration No." := TempItemJnlLineTax."Company Tax Registration No.";
        //           "Product Tax Code" := TempItemJnlLineTax."Product Tax Code";
        //           "Company Tax Warehouse Ref." := TempItemJnlLineTax."Company Tax Warehouse Ref.";
        //           "Packaging Type Code" := TempItemJnlLineTax."Packaging Type Code";
        //           "Pack Qty. per Unit of Measure" := TempItemJnlLineTax."Pack Qty. per Unit of Measure";
        //           // <<DITW18.00.06 DDR 26/10/2015 DIT-770 #1412
        //           "No. of Packages" := TempItemJnlLineTax."No. of Packages";
        //           // >>DITW18.00.06 DDR DIT-770 #1412
        //         end;
        //         //<< DITW110.00.11 AKH 15/09/2017 NRQ#33638
        //         //IF ("Order Type" <> "Order Type"::Production) OR ("Order No." = '') THEN //HEI.24 commented
        //         if ("Order Type" <> "Order Type"::Production) or ("Order No." = '') then begin //HEI.24
        //         //>> DITW110.00.11 AKH NRQ#33638
        //           CreateDim(
        //             DATABASE::Item,"Tax Item No.",
        //             DATABASE::Item,"Item No.",
        //             DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
        //             DATABASE::"Work Center","Work Center No.",
        //             DATABASE::"Item Charge","Item Charge No.",
        //             //<<DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
        //             DATABASE::"Responsibility Center", "Responsibility Center");
        //             //>>DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
        //           UpdateCCCfromBinCode; //HEI.24
        //         end; //HEI.24
        //     end;
        // }
        // field(2014260;"LRN No. Series";Code[10])
        // {
        //     CaptionML = ENU='LRN No. Series',
        //                 FRA='Souches de n° LRN';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "No. Series";

        //     trigger OnLookup();
        //     var
        //         lrNoSeries : Record "No. Series";
        //         lDefaultLRNCode : Code[10];
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/08/2010 #1217
        //         TESTFIELD("AAD No. Series",'');
        //         TESTFIELD("AAD No.",'');
        //         TESTFIELD("Item No.");
        //         // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW16.00.00.43 DDR DIT-715 #768

        //         EmcsSetup.GET;
        //         lDefaultLRNCode := EmcsSetup."LRN Nos.";
        //         if lDefaultLRNCode <> '' then begin
        //           TestLRNNoSeriesMandatory();
        //           if NoSeriesMgt.LookupSeries(lDefaultLRNCode,"LRN No. Series") then
        //             VALIDATE("LRN No. Series");
        //         end else begin
        //           if PAGE.RUNMODAL(0,lrNoSeries) = ACTION::LookupOK then
        //             VALIDATE("LRN No. Series",lrNoSeries.Code);
        //         end;
        //     end;

        //     trigger OnValidate();
        //     var
        //         lDefaultLRNCode : Code[10];
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/08/2010 #1217
        //         TESTFIELD("AAD No. Series",'');
        //         TESTFIELD("AAD No.",'');
        //         TESTFIELD("Item No.");
        //         // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW16.00.00.43 DDR DIT-715 #768

        //         if "LRN No. Series" <> '' then begin
        //           EmcsSetup.GET;
        //           lDefaultLRNCode := EmcsSetup."LRN Nos.";
        //           if lDefaultLRNCode <> '' then
        //             cduNoSeriesMgt.TestSeries(lDefaultLRNCode,"LRN No. Series");
        //           TestLRNNoSeriesMandatory();
        //         end;
        //         TESTFIELD("LRN No.",'');
        //     end;
        // }
        // field(2014261;"LRN No.";Code[20])
        // {
        //     CaptionML = ENU='LRN No.',
        //                 FRA='N° LRN';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnLookup();
        //     var
        //         lrAADTrackingEntry : Record "AAD Tracking Entry";
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/08/2010 #1217
        //         TESTFIELD("AAD No. Series",'');
        //         TESTFIELD("AAD No.",'');
        //         TESTFIELD("Item No.");
        //         // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW16.00.00.43 DDR DIT-715 #768

        //         if "LRN No. Series" <> '' then
        //           NoSeriesMgt.TestManual("LRN No. Series");

        //         lrAADTrackingEntry.SETCURRENTKEY("LRN No.");
        //         lrAADTrackingEntry.FILTERGROUP(2);
        //         lrAADTrackingEntry.SETFILTER("LRN No.",'<>%1','');
        //         lrAADTrackingEntry.FILTERGROUP(0);
        //         lrAADTrackingEntry.SETRANGE("Item No.","Item No.");
        //         lrAADTrackingEntry.SETRANGE("Location Code","Location Code");
        //         if PAGE.RUNMODAL(PAGE::"AAD Tracking List",lrAADTrackingEntry) = ACTION::LookupOK then begin
        //           "LRN No." := lrAADTrackingEntry."LRN No.";
        //         end;
        //     end;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/08/2010 #1217
        //         TESTFIELD("AAD No. Series",'');
        //         TESTFIELD("AAD No.",'');
        //         if "LRN No." <> '' then begin
        //           if "LRN No. Series" <> '' then
        //             NoSeriesMgt.TestManual("LRN No. Series");
        //           cduAADDocMgt.CheckAADNo("LRN No.");
        //           TESTFIELD("Tariff No.");
        //         end;
        //     end;
        // }
        // field(2014262;"ARC No.";Code[30])
        // {
        //     CaptionML = ENU='ARC No.',
        //                 FRA='N° ARC';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/08/2010 - 04/10/2010 #1217
        //         // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW16.00.00.43 DDR DIT-715 #768
        //         if "ARC No." <> '' then
        //           TESTFIELD("ARC No. Mandatory")
        //         else
        //           if "ARC No. Mandatory" then
        //             TESTFIELD("ARC No.");
        //     end;
        // }
        // field(2014263;"SAD No.";Code[30])
        // {
        //     CaptionML = ENU='SAD No.',
        //                 FRA='N° SAD';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014265;"Product Tax Code";Code[10])
        // {
        //     CaptionML = ENU='Tax Product Code',
        //                 FRA='Code Produit taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Product";
        // }
        // field(2014267;"ARC No. Mandatory";Boolean)
        // {
        //     CaptionML = ENU='ARC No. Mandatory (EMCS)',
        //                 FRA='N° ARC obligatoire (EMCS)';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 04/10/2010 #1217
        //         // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW16.00.00.43 DDR DIT-715 #768
        //         if "ARC No. Mandatory" then begin
        //           EmcsSetup.GET;
        //           "LRN No. Series" := EmcsSetup."LRN Nos.";
        //         end else begin
        //           "LRN No. Series" :='';
        //         end;
        //         "LRN No." := '';
        //         "ARC No." := '';
        //         "SAD No." := '';
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2014271;"Company Tax Warehouse Ref.";Text[20])
        // {
        //     CaptionML = ENU='Company Tax Warehouse Reference',
        //                 FRA='Entrepôt fiscal de référence société';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014410;Collapse;Boolean)
        // {
        //     CaptionML = ENU='Collapse',
        //                 FRA='Réduire';
        //     Description = 'DITW15.00.00.24';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.01 DDR 23/01/2008
        //         if Collapse and
        //           ("Attached to Line No." = 0)
        //         then
        //           TESTFIELD(Collapse, false);
        //         // >>DITW15.00.00.01 DDR
        //     end;
        // }
        // field(2014411;"Item Shpt/Rcpt Line No.";Integer)
        // {
        //     CaptionML = ENU='Item Shpt/Rcpt Line No.',
        //                 FRA='N° ligne article Livraison/Réception';
        //     Description = 'DIT-770 #776';
        //     Editable = false;
        // }
        // field(2014412;"Responsibility Center";Code[10])
        // {
        //     CaptionML = ENU='Responsibility Center',
        //                 FRA='Centre de gestion';
        //     Description = 'DITW18.00.06 DIT-770 #1197';
        //     TableRelation = "Responsibility Center" WHERE (Code=FIELD("Resp. Center Table Filter"));

        //     trigger OnValidate();
        //     var
        //         LocationCode : Code[10];
        //     begin
        //         // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
        //         if xRec."Responsibility Center" <> "Responsibility Center" then begin
        //           if not UserSetupMgt.CheckRespCenter(EntryTypeToRespID,"Responsibility Center") then
        //             ERROR(
        //               Text2014413,
        //               RespCenter.TABLECAPTION,GetRespCenterCode);
        //         end;

        //         if (CurrFieldNo <> FIELDNO("Location Code")) and
        //           (CurrFieldNo <> FIELDNO("Physical Location Group Code")) and
        //           (xRec."Physical Location Group Code" = "Physical Location Group Code") and
        //           (xRec."Location Code" = "Location Code")
        //         then begin
        //             SETRANGE("Phys. Location Table Filter");
        //             SETRANGE("Location Table Filter");
        //             VALIDATE("Physical Location Group Code", UserSetupMgt.GetphysicalLocation(0,'',"Responsibility Center"));
        //             LocationCode := UserSetupMgt.GetLocation(EntryTypeToRespID,'',"Responsibility Center");
        //             // <<DITW18.00.06 DDR 27/02/2015 DIT-770 #1189
        //             if (LocationCode <> '') or ("Physical Location Group Code" <> xRec."Physical Location Group Code") then
        //             // >>DITW18.00.06 DDR DIT-770 #1189
        //               VALIDATE("Location Code", LocationCode);
        //         end;
        //         // >>DITW18.00.06 DDR DIT-770 #1189

        //         //<<DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
        //         // << DITW111.00.13A ISL 07/05/2019 NRQ#110425
        //         //<< DITW110.00.11 AKH 15/09/2017 NRQ#33638
        //         if ("Line No." <> 0) and (("Order Type" <> "Order Type"::Production) or ("Order No." = '')) then
        //         //>> DITW110.00.11 AKH NRQ#33638
        //         // >> DITW111.00.13A ISL NRQ#110425
        //           begin //HEI.24
        //             CreateDim(
        //               DATABASE::"Responsibility Center", "Responsibility Center",
        //               DATABASE::Item,"Item No.",
        //               DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
        //               DATABASE::"Work Center","Work Center No.",
        //               DATABASE::"Item Charge","Item Charge No.",
        //               DATABASE::Item,"Tax Item No.");
        //             UpdateCCCfromBinCode; //HEI.24
        //           end; //HEI.24
        //         //>>DITW18.00.06 AKH 20/02/2015 DIT-770 #1197

        //         // <<DITW18.00.06 DDR 27/02/2015 DIT-770 #1189
        //         if "Responsibility Center" <> xRec."Responsibility Center" then
        //           UpdateCharges2(FIELDNO("Responsibility Center"),(CurrFieldNo <> 0));
        //         // >>DITW18.00.06 DDR DIT-770 #1189
        //     end;
        // }
        // field(2014417;"Relation Location Code";Code[10])
        // {
        //     CaptionML = ENU='Relation Location Code',
        //                 FRA='Code Magasin Relation';
        //     Description = 'DITW110.00.09 NRQ#16737';
        //     TableRelation = Location WHERE ("Use As In-Transit"=CONST(false),
        //                                     Code=FIELD("Location Table Filter"));
        // }
        // field(2014418;"Lot Reserved Qty. (Base)";Decimal)
        // {
        //     CalcFormula = -Sum("Reservation Entry"."Quantity (Base)" WHERE ("Source Type"=CONST(83),
        //                                                                     "Source ID"=FIELD("Journal Template Name"),
        //                                                                     "Source Subtype"=FIELD("Entry Type"),
        //                                                                     "Source Ref. No."=FIELD("Line No."),
        //                                                                     "Lot No."=FILTER(<>''),
        //                                                                     "Reservation Status"=CONST(Prospect)));
        //     Caption = 'Lot Reserved Qty. (Base)';
        //     Description = 'NRQ#94671';
        //     FieldClass = FlowField;
        // }
        // field(2014440;"Attached to Line No.";Integer)
        // {
        //     CaptionML = ENU='Attached to Line No.',
        //                 FRA='Attaché à la ligne n°';
        //     Description = 'DITW15.00.00.24';
        //     Editable = false;
        //     TableRelation = "Item Journal Line"."Line No." WHERE ("Journal Template Name"=FIELD("Journal Template Name"),
        //                                                           "Journal Batch Name"=FIELD("Journal Batch Name"),
        //                                                           "Document No."=FIELD("Document No."),
        //                                                           "Line No."=FIELD("Attached to Line No."),
        //                                                           "Attached to Line No."=CONST(0));
        // }
        // field(2014444;"Last Price Calculated Date";Date)
        // {
        //     CaptionML = ENU='Last Price Calculated Date',
        //                 FRA='Dernière date prix calculé';
        //     Description = 'DITW15.00.00.31';
        // }
        // field(2014460;"Production BOM No.";Code[20])
        // {
        //     CaptionML = ENU='Production BOM No.',
        //                 FRA='N° nomenclature production';
        //     Description = 'DITW18.00.06 DIT-770 #1449';
        //     TableRelation = "Production BOM Header";
        // }
        // field(2014462;"BOM Line No.";Integer)
        // {
        //     CaptionML = ENU='BOM Line No.',
        //                 FRA='N° ligne nomenclature';
        //     Description = 'DITW18.00.06 DIT-770 #1449';
        //     NotBlank = true;
        //     TableRelation = IF ("Production BOM No."=FILTER(<>'')) "Production BOM Line"."Line No." WHERE ("Production BOM No."=FIELD("Production BOM No."))
        //                     else IF ("Production BOM No."=CONST('')) "BOM Component"."Line No." WHERE ("Parent Item No."=FIELD("BOM Item No."));
        // }
        // field(2014463;"BOM Item No.";Code[20])
        // {
        //     CaptionML = ENU='BOM Item No.',
        //                 FRA='N° article nomenclature';
        //     Description = 'DITW18.00.06 DIT-770 #1449';
        //     TableRelation = Item;
        // }
        // field(2014464;"BOM Qty. per Unit of Measure";Decimal)
        // {
        //     CaptionML = ENU='BOM Qty. per Unit of Measure',
        //                 FRA='Quantité par unité nomenclature';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW18.00.06 DIT-770 #1449';
        // }
        // field(2014476;"Packaging Type Code";Code[10])
        // {
        //     CaptionML = ENU='Packaging Type Code',
        //                 FRA='Code Type de Conditionnement';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Packaging Type";

        //     trigger OnValidate();
        //     var
        //         PackagingType : Record "Packaging Type";
        //     begin
        //         // <<DITW18.00.06 DDR 20/10/2015 DIT-770 #1449
        //         if (CurrFieldNo = FIELDNO("Packaging Type Code")) and ("Tax Item No." <> '') and
        //           ("Packaging Type Code" <> '') and (xRec."Packaging Type Code" <> "Packaging Type Code")
        //         then
        //           TESTFIELD("Packaging Type Code",xRec."Packaging Type Code");
        //         // >>DITW18.00.06 DDR DIT-770 #1449

        //         // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148) - 16/03/2011 (DIT711 161)
        //         if "Packaging Type Code" <> '' then begin
        //           PackagingType.GET("Packaging Type Code");
        //           if "Tax Item No." <> '' then begin
        //             GetTaxItem;
        //             ItemUnitOfMeasure.GET("Tax Item No.",Item."Sales Unit of Measure");
        //           end else
        //             // <<DITW18.00.06 DDR 29/10/2015 DIT-770 #1412
        //             ItemUnitOfMeasure.GET("Item No.","Unit of Measure Code");
        //             // >>DITW18.00.06 DDR DIT-770 #1412
        //           if "Packaging Type Code" = ItemUnitOfMeasure."Packaging Type Code" then begin
        //             ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
        //             "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
        //           end else
        //             "Pack Qty. per Unit of Measure" := 1;
        //           TESTFIELD("Pack Qty. per Unit of Measure");
        //         end else
        //           "Pack Qty. per Unit of Measure" := 0;
        //         // >>DITW15.00.00.38 DDR #1217 (DIT711 148) (DIT711 161)
        //         // <<DITW16.00.00.44 DDR 24/03/2014 DIT-715 #912 - DITW18.00.06 DDR 26/10/2015 DIT-770 #1412
        //         "No. of Packages" := ROUND(Quantity * "Pack Qty. per Unit of Measure",1,'>');
        //         // >>DITW16.00.00.44 DDR DIT-715 #912 - DITW18.00.06 DDR DIT-770 #1412
        //     end;
        // }
        // field(2014477;"No. of Packages";Decimal)
        // {
        //     CaptionML = ENU='No. of Packages',
        //                 FRA='Nbre de colis';
        //     DecimalPlaces = 0:2;
        //     Description = 'DITW18.00.06 DIT-770 #1412';

        //     trigger OnValidate();
        //     var
        //         PackagingType : Record "Packaging Type";
        //     begin
        //         // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
        //         TESTFIELD("ARC No. Mandatory",true);
        //         TESTFIELD("ARC No.",'');
        //         // >>DITW16.00.00.43 DDR DIT-715 #720
        //         TESTFIELD(Quantity);
        //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //         if ("Tax Item No." = '') and ("Item Charge No." <> '') then
        //           TESTFIELD("No. of Packages",0);
        //         // >>DITW15.00.00.38 DDR #703
        //         // <<DITW18.00.06 DDR 20/10/2015 DIT-770 #1449
        //         if ("Tax Item No." <> '') and (xRec."No. of Packages" <> "No. of Packages") then
        //           TESTFIELD("No. of Packages",xRec."No. of Packages");
        //         // >>DITW18.00.06 DDR DIT-770 #1449
        //         // <<DITW110.00.09 DDR 22/03/2017 NRQ#9661
        //         if ("Packaging Type Code" <> '') and (Quantity <> 0) then begin
        //           PackagingType.GET("Packaging Type Code");
        //           if PackagingType.Countable then
        //             TESTFIELD("No. of Packages");
        //         end;
        //         // >>DITW110.00.09 DDR NRQ#9661
        //     end;
        // }
        // field(2014482;"Pack Qty. per Unit of Measure";Decimal)
        // {
        //     CaptionML = ENU='Packaging Qty. per Unit of Measure',
        //                 FRA='Quantité conditionnement par unité';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.38 #1217 (DIT711 148)';
        // }
        // field(2014497;"Resp. Center Table Filter";Code[10])
        // {
        //     CaptionML = ENU='Resp. Center Table Filter',
        //                 FRA='Filtre Centre de gestion (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1189';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Responsibility Center";
        // }
        // field(2014498;"Phys. Location Table Filter";Code[10])
        // {
        //     CaptionML = ENU='Phys. Location Table Filter',
        //                 FRA='Filtre groupe magasin réel (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1189';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014499;"Location Table Filter";Code[10])
        // {
        //     CaptionML = ENU='Location Table Filter',
        //                 FRA='Filtre Magasin (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1189';
        //     FieldClass = FlowFilter;
        //     TableRelation = Location;
        // }
        // field(2014500;"Has Item Charge";Boolean)
        // {
        //     CalcFormula = Exist("Item Journal Line" WHERE ("Journal Template Name"=FIELD("Journal Template Name"),
        //                                                    "Journal Batch Name"=FIELD("Journal Batch Name"),
        //                                                    "Document No."=FIELD("Document No."),
        //                                                    "Attached to Line No."=FIELD("Line No.")));
        //     CaptionML = ENU='Has Item Charge',
        //                 FRA='A des Frais Annexes';
        //     Description = 'DITW17.10.03 DIT-770 #541, HEI.27';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014508;"Ship-to/Order Address Code";Code[10])
        // {
        //     CaptionML = ENU='Ship-to/Order Address Code',
        //                 FRA='Code adresse destinataire/adresse de commande';
        //     Description = 'DITW15.00.00.39 #1230';
        //     TableRelation = IF ("Source Type"=CONST(Customer)) "Ship-to Address".Code WHERE ("Customer No."=FIELD("Source No."))
        //                     else IF ("Source Type"=CONST(Vendor)) "Order Address".Code WHERE ("Vendor No."=FIELD("Source No."));
        // }
        // field(2034983;"Work Order No.";Code[20])
        // {
        //     CaptionML = ENU='Work Order No.',
        //                 FRA='N° cmde. d''intervention';
        //     Description = 'DIT-715 #457';
        //     TableRelation = "Service Header"."No." WHERE ("Document Type"=CONST(Order),
        //                                                   "PM Order Status"=CONST(Released));

        //     trigger OnValidate();
        //     var
        //         Location2 : Record Location;
        //     begin
        //         // <<DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457
        //         TESTFIELD("Item Charge No.",'');
        //         TESTFIELD("Is Item Charge",false);
        //         if "Location Code" <> '' then begin
        //           Location2.GET("Location Code");
        //           if Location."Work Order Mandatory" then
        //             TESTFIELD("Work Order No.");
        //           if ("Entry Type" = "Entry Type"::Transfer) or ("New Location Code" <> '') then begin
        //             if (Location2."W.Order Alloc. Location Code" <> '') and ("Work Order No." <> '') then begin
        //               if Location2."W.Order Alloc. Location Code" <> "New Location Code" then begin
        //                 "New Phys. Location Group Code" := '';
        //                 "New Location Group Code" := '';
        //                 "New Bin Code" := '';
        //                 VALIDATE("New Location Code",Location2."W.Order Alloc. Location Code");
        //               end;
        //               if (Location2."W. Order Allocation Bin Code" <> '') and
        //                 (Location2."W. Order Allocation Bin Code" <> "New Bin Code")
        //               then
        //                 VALIDATE("New Bin Code",Location2."W. Order Allocation Bin Code");
        //             end;
        //             Location2.GET("New Location Code");
        //             if Location2."Work Order Mandatory" then
        //               TESTFIELD("Work Order No.");
        //           end;
        //         end;
        //     end;
        // }
        // field(2034986;"Work Order Line No.";Integer)
        // {
        //     CaptionML = ENU='Work Order Line No.',
        //                 FRA='N° ligne cmde. d''intervention';
        //     Description = 'DIT-715 #457';
        // }
        // field(2035040;"SSCC No.";Code[50])
        // {
        //     CaptionML = ENU='SSCC No.',
        //                 FRA='N° SSCC';
        //     Description = 'DITW15.00.00.38 #1139';
        // }
        // field(2035042;"New SSCC No.";Code[50])
        // {
        //     CaptionML = ENU='New SSCC No.',
        //                 FRA='Nouveau N° de SSCC';
        //     Description = 'DITW15.00.00.38 #1139';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //         TESTFIELD("Entry Type","Entry Type"::Transfer);
        //         // >>DITW19.00.08 DDR BL#10443
        //     end;
        // }
        // field(2035090;"No. of Quality Tests";Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" WHERE ("Source Type"=CONST(83),
        //                                                      "Source Subtype"=FIELD("Entry Type"),
        //                                                      "Source ID"=FIELD("Journal Template Name"),
        //                                                      "Source Batch Name"=FIELD("Journal Batch Name"),
        //                                                      "Source Ref. No."=FIELD("Line No."),
        //                                                      "Item No."=FIELD("Item No.")));
        //     CaptionML = ENU='No. of Quality Tests',
        //                 FRA='<Nbre de Tests Qualité>';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035098;"Your Reference";Text[30])
        // {
        //     Caption = 'Your Reference';
        //     Description = 'QXL11.01';
        //     Editable = false;
        // }
        // field(2035099;"Session ID";Guid)
        // {
        //     CaptionML = ENU='Session ID',
        //                 FRA='ID session';
        //     Description = 'QXL9.00.001';
        // }
        // field(2035140;"OWM Transaction ID";Guid)
        // {
        //     Caption = 'OWM Transaction ID';
        //     Description = 'NRQ#27479';
        // }
        // field(2035172;"Gyle No.";Code[20])
        // {
        //     CaptionML = ENU='Gyle No.',
        //                 FRA='Gyle N°';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        // field(2035182;"Include in Losses";Boolean)
        // {
        //     CaptionML = ENU='Include in Losses',
        //                 FRA='Inclure en Pertes';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        // field(2035240;"Quantity (Brewing Base) Calcd.";Decimal)
        // {
        //     CaptionClass = GetQtyCaptionClass(FIELDNO("Quantity (Brewing Base) Calcd."),16);
        //     CaptionML = ENU='Quantity (Brewing Base) (Calculated)',
        //                 FRA='Qté (Base Prod. Brasserie) (Calculée)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW19.00.08 BL#10443';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //         TESTFIELD("Value Entry Type","Value Entry Type"::Revaluation);
        //         TESTFIELD(Quantity);
        //         VALIDATE("Unit Volume HL (Calculated)","Quantity (Brewing Base) Calcd." / "Quantity (Base)");
        //     end;
        // }
        // field(2035241;"Quantity (Brewing Base) Reval.";Decimal)
        // {
        //     CaptionClass = GetQtyCaptionClass(FIELDNO("Quantity (Brewing Base) Reval."),17);
        //     CaptionML = ENU='Quantity (Brewing Base) (Revalued)',
        //                 FRA='Qté (Base Prod. Brasserie) (Réévaluée)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW19.00.08 BL#10443';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //         TESTFIELD("Value Entry Type","Value Entry Type"::Revaluation);
        //         TESTFIELD(Quantity);
        //         VALIDATE("Unit Volume HL (Revalued)","Quantity (Brewing Base) Reval." / "Quantity (Base)");
        //     end;
        // }
        // field(2035242;"Quantity (Brewing Base)";Decimal)
        // {
        //     CaptionClass = GetQtyCaptionClass(FIELDNO("Quantity (Brewing Base)"),5);
        //     CaptionML = ENU='Quantity (Brewing Base)',
        //                 FRA='Qté (Base Prod. Brasserie)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        // field(2035243;"New Quantity (Brewing Base)";Decimal)
        // {
        //     CaptionClass = GetQtyCaptionClass(FIELDNO("New Quantity (Brewing Base)"),15);
        //     CaptionML = ENU='New Quantity (Brewing Base)',
        //                 FRA='Quantité (Degr.)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08 - DITW19.00.08 BL#10443';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //         TESTFIELD("Entry Type","Entry Type"::Transfer);
        //         TESTFIELD(Quantity);
        //         "New Unit Volume HL" := "New Quantity (Brewing Base)" / "Quantity (Base)";
        //         // >>DITW19.00.08 DDR BL#10443
        //     end;
        // }
        // field(2035245;"Output Quantity (Degrees)";Decimal)
        // {
        //     CaptionClass = GetQtyCaptionClass(FIELDNO("Output Quantity (Degrees)"),1);
        //     CaptionML = ENU='Output Quantity (Degrees)',
        //                 FRA='Quantité Production (Degr.)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        // field(2035246;"Loss Quantity (Brewing Base)";Decimal)
        // {
        //     CaptionClass = GetQtyCaptionClass(FIELDNO("Loss Quantity (Brewing Base)"),9);
        //     CaptionML = ENU='Loss Quantity (Brewing Base)',
        //                 FRA='Qté Perte (Base Prod. Brasserie)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        // field(2035247;"Loss Quantity (Degrees)";Decimal)
        // {
        //     CaptionClass = GetQtyCaptionClass(FIELDNO("Loss Quantity (Degrees)"),10);
        //     CaptionML = ENU='Loss Quantity (Degrees)',
        //                 FRA='Quantité Perte (Degr.)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        // field(2035248;"Exist Loss Breakdown";Boolean)
        // {
        //     CalcFormula = Exist("Loss Breakdown Journal" WHERE ("Journal Template Name"=FIELD("Journal Template Name"),
        //                                                         "Journal Batch Name"=FIELD("Journal Batch Name"),
        //                                                         "Journal Line No."=FIELD("Line No.")));
        //     CaptionML = ENU='Exist Loss Breakdown',
        //                 FRA='Détail Pertes Existe';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035266;"Production jnl. flushing";Boolean)
        // {
        //     Caption = 'Production jnl. flushing';
        //     Description = 'DITW110.00.12A HBA 07/06/2018 NRQ#51782';
        // }
        // field(2035275;"Output Quantity (Brewing Base)";Decimal)
        // {
        //     CaptionClass = GetQtyCaptionClass(FIELDNO("Output Quantity (Brewing Base)"),6);
        //     CaptionML = ENU='Output Quantity (Brewing Base)',
        //                 FRA='Qté Production (Base Prod. Brasserie)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        //---BC Upgrade KAMNAY01<<
    }
    keys
    {
        //---BC Upgrade KAMNAY01>>
        // key(Key1; "Journal Template Name", "Journal Batch Name", "Document No.", "Attached to Line No.", Collapse, "Is Item Charge", "Item Charge Incl. Price", "Extra Charge Type")
        // {
        //     SumIndexFields = Amount, "Discount Amount";
        // }
        //---BC Upgrade KAMNAY01<<
        //key(Key7; "Line No.", "Item No.", "Item Charge No.")  // BC Upgrade NANDIS03
        key(Key50000; "Line No.", "Item No.", "Item Charge No.")  // BC Upgrade NANDIS03
        {
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ReserveItemJnlLine.DeleteLine(Rec);

    CALCFIELDS("Reserved Qty. (Base)");
    TESTFIELD("Reserved Qty. (Base)",0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SETAUTOCALCFIELDS(); //HEI.47
    ReserveItemJnlLine.DeleteLine(Rec);
    //<<QXL9.00.001 DAT 23/03/2016
    if QualitySetup.READPERMISSION then
      cduQualityMgt.DeleteItemJnlLine(Rec);
    //>>QXL9.00.001 DAT 23/03/2016

    //CALCFIELDS("Reserved Qty. (Base)"); //HEI.46
    //TESTFIELD("Reserved Qty. (Base)",0); //HEI.46

    // <<DITW18.00.06 DDR 03/11/2015 DIT-770 #1395
    if ("Line No." <> 0) and ("BOM Line No." <> 0) and
      ("Is Item Charge" or ("Item Charge Type" <> "Item Charge Type"::" "))
    then
      TESTFIELD("BOM Line No.",0);
    // >>DITW18.00.06 DDR DIT-770 #1395

    if ("Phys. Inventory"=false) then begin //HEI.47
      // <<DITW15.00.00.24 DDR 25/09/2008
      DeleteAllChargeJnlLines(Rec,true);
      // >>DITW15.00.00.24 DDR

      //<< DITW19.00.08A VSC 04/01/2017 BL#10443
      DeleteLossBreakdownJnl(Rec);
      //>> DITW19.00.08A VSC BL#10443
    end; //HEI.47
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LOCKTABLE;
    ItemJnlTemplate.GET("Journal Template Name");
    ItemJnlBatch.GET("Journal Template Name","Journal Batch Name");

    ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
    ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
    ValidateNewShortcutDimCode(1,"New Shortcut Dimension 1 Code");
    ValidateNewShortcutDimCode(2,"New Shortcut Dimension 2 Code");

    CheckPlanningAssignment;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    //HEI.44>>
    if ItemJnlTemplate."Limit Type Selection" then begin
      if not ("Entry Type" in ["Entry Type"::"Negative Adjmt.","Entry Type"::"Positive Adjmt."]) then
        ERROR(EntryTypeErrorTxt);
    end;
    //HEI.44<<
    #5..9
    //<<DITW17.00.02 SR 10/09/2013 DIT-770 #143
    if ItemJnlTemplate."Def. Gen. Bus. Posting Group" <> '' then
      "Gen. Bus. Posting Group" := ItemJnlTemplate."Def. Gen. Bus. Posting Group";
    //>>DITW17.00.02 SR DIT-770 #143

    CheckPlanningAssignment;

    // <<DITW15.00.00.24 DDR 25/09/2008
    if xRec."Line No." = 0 then
      InsertCharges4(FIELDNO("Item No."));
    // >>DITW15.00.00.24 DDR

    //HEI.32>>
    ValidateBulkTransfer;
    //HEI.32<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ReserveItemJnlLine.VerifyChange(Rec,xRec);
    CheckPlanningAssignment;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ReserveItemJnlLine.VerifyChange(Rec,xRec);
    CheckPlanningAssignment;

    //HEI.32>>
    ValidateBulkTransfer;
    //HEI.32<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnRename". Please convert manually.

    //trigger OnRename();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ReserveItemJnlLine.RenameLine(Rec,xRec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ReserveItemJnlLine.RenameLine(Rec,xRec);
    //<<QXL9.00.001 DAT 23/03/2016
    if QualitySetup.READPERMISSION then
      cduQualityMgt.RenameItemJnlLine(Rec,xRec);
    //>>QXL9.00.001 DAT 23/03/2016
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    //---BC Upgrade KAMNAY01>> 
    // var
    //     ProductGroup: Record "Product Group";
    //     lCurrFieldNo: Integer;

    // var
    //     RoutePlanningWorksheet: Record "Route Planning Worksheet";
    //     Zone: Record Zone;
    //     Bin: Record Bin;

    // var
    //     lCurrFieldNo: Integer;
    //     lItemJournalTemplate: Record "Item Journal Template";

    // var
    //     lCurrFieldNo: Integer;
    //     lrResponsibilityCenter: Record "Responsibility Center";

    // var
    //     lCurrFieldNo: Integer;

    // var
    //     lCurrFieldNo: Integer;

    // var
    //     lCurrFieldNo: Integer;

    // var
    //     lCurrFieldNo: Integer;

    // var
    //     lCurrFieldNo: Integer;

    // var
    //     ProdOrderLine: Record "Prod. Order Line";
    //     StrengthValue: Decimal;

    // var
    //     ProdOrderLine: Record "Prod. Order Line";
    //     StrengthValue: Decimal;

    // var
    //     lrTempItemJnlLine: Record "Item Journal Line" temporary;

    // var
    //     lCurrFieldNo: Integer;

    // var
    //     InvtSetup: Record "Inventory Setup";
    //     QualityManagement: Codeunit "Quality Management";

    // var
    //     StrengthValue: Decimal;
    //     VStrengthValue: Decimal;

    // var
    //     ItemSalesLine: Record "Sales Line";

    // var
    //     ItemPurchLine: Record "Purchase Line";

    // var
    //     HeinekenGlobal: Codeunit "Heineken Global";
    //     Posted: Boolean;
    //     ImportProductionOrdersMgmt: Codeunit "Import Production Orders Mgmt";
    //     ProductionOrderNo: Code[20];

    //---BC Upgrade KAMNAY01<<

    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=%1 must be reduced.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=%1 must be reduced.;FRA=%1 doit être réduit.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You cannot change %1 when %2 is %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You cannot change %1 when %2 is %3.;FRA=Vous ne pouvez pas modifier %1 si %2 est %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=You must not enter %1 in a revaluation sum line.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=You must not enter %1 in a revaluation sum line.;FRA=Vous ne devez pas entrer %1 sur une ligne réévaluation.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU="New ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU="New ";FRA="Nouveau ";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text012(Variable 1045)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU=The update has been interrupted to respect the warning.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : ENU=The update has been interrupted to respect the warning.;FRA=La mise à jour a été interrompue pour respecter l'alerte.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text021(Variable 1051)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text021 : ENU=The entered bin code %1 is different from the bin code %2 in production order component %3.\\Are you sure that you want to post the consumption from bin code %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text021 : ENU=The entered bin code %1 is different from the bin code %2 in production order component %3.\\Are you sure that you want to post the consumption from bin code %1?;FRA=Le code emplacement entré %1 est différent du code emplacement %2 du composant O.F. %3.\\Útes-vous sûr de vouloir valider la consommation à partir du code emplacement %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text029(Variable 1047)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text029 : ENU=must be positive;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text029 : ENU=must be positive;FRA=doit être de signe positif;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text030(Variable 1046)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text030 : ENU=must be negative;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text030 : ENU=must be negative;FRA=doit être de signe négatif;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text031(Variable 1043)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text031 : ENU=You can not insert item number %1 because it is not produced on released production order %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text031 : ENU=You can not insert item number %1 because it is not produced on released production order %2.;FRA=Vous ne pouvez pas insérer l'article numéro %1 car il n'est pas produit dans l'O.F. lancé (%2).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text032(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text032 : ENU=When posting, the entry %1 will be opened first.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text032 : ENU=When posting, the entry %1 will be opened first.;FRA=Lors de la validation, l'écriture %1 s'ouvre d'abord.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text033(Variable 1049)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text033 : ENU=If the item carries serial or lot numbers, then you must use the %1 field in the %2 window.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text033 : ENU=If the item carries serial or lot numbers, then you must use the %1 field in the %2 window.;FRA=Si l'article porte des numéros de série ou de lot, alors vous devez utiliser le champ %1 dans la fenêtre %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text034(Variable 1050)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text034 : ENU=You cannot revalue individual item ledger entries for items that use the average costing method.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text034 : ENU=You cannot revalue individual item ledger entries for items that use the average costing method.;FRA=Vous ne pouvez pas réévaluer chaque écriture comptable pour les articles utilisant le mode évaluation stock moyen.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SubcontractedErr(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SubcontractedErr : @@@=%1 - Field Caption, %2 - Line No.;ENU=%1 must be zero in line number %2 because it is linked to the subcontracted work center.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SubcontractedErr : @@@=%1 - Field Caption, %2 - Line No.;ENU=%1 must be zero in line number %2 because it is linked to the subcontracted work center.;FRA=%1 doit être égal à zéro à la ligne numéro %2 en raison de son lien avec le centre de travaux de sous-traitance.;
    //Variable type has not been exported.

    var
        Text005: TextConst ENU = 'Change %1 from %2 to %3?', FRA = 'Remplacer %2 par %3 dans le champ %1 ?';

    var
        Text036: Label 'Output is already been posted ,You Cannot Post the Production Journal';
        Text037: Label 'An output is already posted for this order. Do you want to continue?';
        Text038: Label 'Please select the BIN Code';

    var
        rCompanyInfo: Record "Company Information";
        rCust: Record Customer;
        //QualitySetup: Record "Quality Setup";//---BC Upgrade KAMNAY01
        SaveGLSetup: Record "General Ledger Setup";
        InventorySetup: Record "Inventory Setup";
        InvtSetup: Record "Inventory Setup";
        Item: Record Item;//BC Upgrade KAMNAY01
        rItemCharge: Record "Item Charge";
        ItemJournalLine: Record "Item Journal Line";
        ItemJrlLine: Record "Item Journal Line";
        rFromItemJnlLine: Record "Item Journal Line";
        //---BC Upgrade KAMNAY01>> 
        // rDrinkTaxGroup: Record "Drink Tax Group";
        // rItemDrinkTaxGroup: Record "Drink Tax Group";
        //---BC Upgrade KAMNAY01<<
        rTempItemJnlLine: Record "Item Journal Line" temporary;
        ItemJnlTemplate: Record "Item Journal Template";//BC Upgrade KAMNAY01 HEI.44
        ILE: Record "Item Ledger Entry";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        recManufacturingSetup: Record "Manufacturing Setup";
        PurchaseSetup: Record "Purchases & Payables Setup";
        RespCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        SourceCodeSetup: Record "Source Code Setup";
        gSKU: Record "Stockkeeping Unit";
        rStockkeepingUnit: Record "Stockkeeping Unit";
        UserSetup: Record "User Setup";
        rVendor: Record Vendor;
        Vend: Record Vendor;
        cduItemJnlCheckLine: Codeunit "Item Jnl.-Check Line";//DITW
        //cduNoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03 - Blocked
        cduNoSeriesMgt: Codeunit "No. Series";  // BC Upgrade NANDIS03 - Added
        UserSetupMgt: Codeunit "User Setup Management";//DITW
        WHSUTILS: Codeunit "WHS-UTILS";
        AutoAssingItemTracking: Boolean;
        CompanySetupRead: Boolean;
        //cduAADDocMgt: Codeunit "AAD Document Mgt."; //---BC Upgrade KAMNAY01
        ForceDeleteItemCharges: Boolean;
        HideFEFOMessage: Boolean;
        ProdOrderExist: Boolean;
        EntryTypeErrorTxt: Label 'Selected Entry Type is not allowed in this Journal';
        FinishedOutputQst: Label 'The operation has been finished. Do you want to post output for the finished operation?';
        Text039: Label '"There is nothing to create ""Negative Adjmt."" entry in Reservation. "';
        Text040: Label '"There is nothing to create for Output entry in Reservation. "';
        UserDocType: Option Sales,Purchase,Service,Production,Assembly,Inventory;
        Text2013662: TextConst ENU = 'You cannot change %1 because the value is automatically calculated with %2.', FRA = 'Vous ne pouvez pas modifier %1 car la valeur est calculé automatiquement avec %2.';
        //---BC Upgrade KAMNAY01>>
        //LocationGr: Record "Location Group";
        //cduQualityMgt: Codeunit "Quality Management";//DITW
        //EmcsSetup: Record "EMCS Setup";
        //---BC Upgrade KAMNAY01<<
        Text2013663: TextConst ENU = 'At least one item charge %3 line must exist with the %1 %2.', FRA = 'Il doit exister au moins une ligne de type %3 avec le %1 %2.';
        Text2013664: TextConst ENU = 'You must either specify %1 or %2.', FRA = 'Vous devez spécifier %1 ou %2.';
        Text2013665: TextConst ENU = 'At least one item charge %3 line must exist with the %1 %2. for location %4', FRA = 'Au moins un élément chargé ligne %3 doit exister avec le %1 %2. pour l''emplacement %4';
        //cduIntTaxCharges: Codeunit "Tax Internal Item Charges Mgt.";//---BC Upgrade KAMNAY01
        Text2013760: TextConst ENU = 'You cannot input more than %1 units because it is attached to %2 %3 as %4.', FRA = 'Vous ne pouvez pas entrer plus de %1 unités car il est attaché à %2 %3 comme %4.';
        Text2013761: TextConst ENU = 'You cannot modify because it is attached to %1 %2 as %3.', FRA = 'Vous ne pouvez pas modifier, car il est attaché à %1 %2 comme %3.';
        Text2013763: TextConst ENU = 'If the item carries serial or lot numbers, then you must use the %1 field in the %2 window.', FRA = 'Si l''article porte des numéros de série ou de lot, alors vous devez utiliser le champ %1 dans la fenêtre %2.';
        //CommonItemChrgMgt: Codeunit "Common Item Charges Mgt.";// //---BC Upgrade KAMNAY01
        //BomItemCharges: Codeunit "Bom Item Charges Mgt."; //---BC Upgrade KAMNAY01
        Text2014410: TextConst ENU = 'Unauthorized location selected', FRA = 'Magasin non autorisé sélectionné';
        //PhysLocationGr: Record "Physical Location Group";//---BC Upgrade KAMNAY01
        Text2014412: TextConst ENU = 'Do you want to replace the existing item %1 using the item selection?', FRA = 'Souhaitez-vous remplacer l''actuel article %1 par les articles sélectionnés?';
        Text2014413: TextConst ENU = 'Your identification is set up to process from %1 %2 only.', FRA = 'Le paramétrage de votre code utilisateur ne vous permet de travailler que sur %1 %2.';
        Text2014414: TextConst ENU = 'You cannot use the %1 %2 because your identification is set up to process from %3 %4 only.', FRA = 'Vous ne pouvez pas utiliser le %1 %2 parce que votre identification est configurée pour traiter de %3 %4 seulement.';
        //---BC Upgrade KAMNAY01>>
        //cduDistIntegration: Codeunit "Dist. Integration"; 
        //recFinXLSetup: Record "Finance XL Setup";  
        //BeverageSetup: Record "Production Setup";
        //---BC Upgrade KAMNAY01<<
        Text2035140: TextConst ENU = 'You cannot change the %1 when one or more %2 lines have been filled in.', FRA = 'Vous ne pouvez pas changer le %1 lorsqu''une ou plusieurs lignes %2 ont été renseignées';
        //---BC Upgrade KAMNAY01>>
        // LossBreakdownJnl: Record "Loss Breakdown Journal";
        // DefaultTaxSpec: Record "Default Tax Specification";
        //---BC Upgrade KAMNAY01<<
        Text2035141: TextConst ENU = 'must not be greater than %1', FRA = 'Ne peut pas être supérieur à %1';

    //BC Upgrade KAMNAY01>>
    procedure AllowPartialOutput() Proceed: Boolean
    //<< HEI.02 FDD GAPID001 NAIKH01
    var
        WorkCenter: Record "Work Center";
    begin
        Proceed := TRUE;
        ItemJrlLine.RESET();
        ItemJrlLine.SETRANGE(ItemJrlLine."Entry Type", "Entry Type"::Output);
        ItemJrlLine.SETRANGE(ItemJrlLine.Type, Type::"Work Center");
        ItemJrlLine.SETRANGE(ItemJrlLine."Document No.", "Document No.");
        IF ItemJrlLine.FINDLAST() THEN BEGIN
            ILE.RESET();
            ILE.SETRANGE(ILE."Entry Type", ItemJrlLine."Entry Type"::Output);
            ILE.SETRANGE(ILE."Document No.", ItemJrlLine."Document No.");
            IF ILE.FINDFIRST() THEN
                ProdOrderExist := TRUE;

            IF ProdOrderExist THEN BEGIN
                IF WorkCenter.GET(ItemJrlLine."No.") THEN BEGIN
                    ;
                    IF NOT WorkCenter."Partial Output FND" THEN BEGIN
                        UserSetup.GET(USERID);
                        IF NOT UserSetup."Allow Partial Output FND" THEN BEGIN
                            IF ItemJrlLine."Output Quantity" <> 0 THEN   //ISSUE ID 194 & 115
                                ERROR(Text036);
                        end
                        else
                            //>>HEI.29
                            IF GUIALLOWED THEN BEGIN
                                //<<HEI.29
                                IF NOT CONFIRM(Text037, FALSE) THEN BEGIN

                                    Proceed := FALSE;
                                    EXIT;
                                end;
                                //>>HEI.29
                            end;
                        //<<HEI.29
                    end;
                end;
            end;
        end;
        //>> HEI.02 FDD GAPID001 NAIKH01
    end;


    procedure LookupBin()
    var
        Bin1: Record Bin;
        BinList: Page "Bin List";
    begin
        //HEI.01
        Bin1.FILTERGROUP(2);
        Bin1.SETRANGE("Location Code", "Location Code");
        Bin1.SETRANGE("Zone Code", "Zone Code FND");
        Bin1.FILTERGROUP(0);
        BinList.SETTABLEVIEW(Bin1);
        BinList.LOOKUPMODE(TRUE);
        IF BinList.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            BinList.GETRECORD(Bin1);
            VALIDATE("Bin Code", Bin1.Code);
        end;
    end;
    //BC Upgrade GUNREM01 >> to add the filer with new zone code FND field 
    procedure LookupBin1()
    var
        Bin1: Record Bin;
        BinList: Page "Bin List";
    begin
        //HEI.01
        Bin1.FILTERGROUP(2);
        Bin1.SETRANGE("Location Code", "Location Code");
        Bin1.SETRANGE("Zone Code", "New Zone Code FND");
        Bin1.FILTERGROUP(0);
        BinList.SETTABLEVIEW(Bin1);
        BinList.LOOKUPMODE(TRUE);
        IF BinList.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            BinList.GETRECORD(Bin1);
            VALIDATE("Bin Code", Bin1.Code);
        end;
    end;
    //BC Upgrade GUNREM01 >> to add the filer with new zone code FND field 
    procedure OpenItemTrackingLines(IsReclass: Boolean)
    var
        myInt: Integer;
    begin
        // << HEI.06
        IF ("Entry Type" = "Entry Type"::Output) AND ("Location Code" <> '') THEN BEGIN
            IF "Bin Code" = '' THEN
                ERROR(Text038);
        end;
        //>> HEI.06

    end;

    local procedure RoundOffPhysInvQty()
    var
        UnitofMeasureL: Record "Unit of Measure";
        Txt2L: Code[10];
        Txt1L: Code[50];
        iL: Integer;
        jL: Integer;
    begin
        //HEI.20>>
        SourceCodeSetup.GET();
        IF (SourceCodeSetup."Phys. Inventory Journal" = "Source Code") AND (CurrFieldNo <> 0) THEN BEGIN
            IF NOT ("Entry Type" IN ["Entry Type"::"Positive Adjmt.", "Entry Type"::"Negative Adjmt."]) THEN
                "Enable Phys.Inv. Round-off FND" := FALSE
            else BEGIN
                InventorySetup.GET();
                IF InventorySetup."Prevent PhysInvt.Jnl Frac. FND" <> '' THEN BEGIN
                    Txt1L := InventorySetup."Prevent PhysInvt.Jnl Frac. FND";
                    jL := STRLEN(InventorySetup."Prevent PhysInvt.Jnl Frac. FND");
                    FOR iL := 1 TO jL DO BEGIN
                        IF STRPOS(InventorySetup."Prevent PhysInvt.Jnl Frac. FND", '|') <> 0 THEN BEGIN
                            Txt2L := DELSTR(Txt1L, STRPOS(InventorySetup."Prevent PhysInvt.Jnl Frac. FND", '|'));
                            Txt1L := DELSTR(Txt1L, 1, STRPOS(InventorySetup."Prevent PhysInvt.Jnl Frac. FND", '|'));
                        end else
                            Txt2L := Txt1L;
                        IF ("Unit of Measure Code" = Txt2L) AND (Txt2L <> '') THEN BEGIN
                            UnitofMeasureL.GET(Txt2L);
                            //HEI.22>>
                            "Qty. (Phys. Inventory)" := ROUND("Qty. (Phys. Inventory)", 1);
                            IF "Unit of Measure Code" = "Invent. Unit of Measur Cod FND" THEN
                                "Qty. Phys. Inv. in Inv.UoM FND" := ROUND("Qty. Phys. Inv. in Inv.UoM FND", 1);
                            //HEI.22<<
                            VALIDATE(Quantity, ROUND(Quantity, 1));
                            //HEI.22>>
                            IF "Unit of Measure Code" = "Invent. Unit of Measur Cod FND" THEN
                                VALIDATE("Quantity in Inv. UoM FND", ROUND("Quantity in Inv. UoM FND", 1));
                            //HEI.22<<
                            "Enable Phys.Inv. Round-off FND" := TRUE;
                        end else BEGIN
                            IF Txt1L = '' THEN
                                iL := jL;
                        end;
                    end;
                end;
            end;
        end;
        //HEI.20<<
    end;

    procedure CreateReservationEntries(VAR ItemJnlTemplate: Code[10]; VAR ItemJnlBatch: Code[10]; VAR ItemJnlLineNo: Integer)
    var
        ItemJournalLineL: Record "Item Journal Line";
        ReservationEntryL: Record "Reservation Entry";
        ReservEntryNoL: Integer;
    begin
        //HEI.20>>
        ItemJournalLineL.SETRANGE("Journal Template Name", ItemJnlTemplate);
        ItemJournalLineL.SETRANGE("Journal Batch Name", ItemJnlBatch);
        ItemJournalLineL.SETRANGE("Line No.", ItemJnlLineNo);
        ItemJournalLineL.SETRANGE("Entry Type", "Entry Type"::"Negative Adjmt.");
        IF ItemJournalLineL.FINDFIRST() THEN BEGIN
            ReservationEntryL.LOCKTABLE();
            IF ReservationEntryL.FINDLAST() THEN
                ReservEntryNoL := ReservationEntryL."Entry No." + 1
            else
                ReservEntryNoL := 1;
            ReservationEntryL.INIT();
            ReservationEntryL."Entry No." := ReservEntryNoL;
            ReservationEntryL.Positive := FALSE;
            ReservationEntryL.VALIDATE("Item No.", ItemJournalLineL."Item No.");
            ReservationEntryL.VALIDATE("Location Code", ItemJournalLineL."Location Code");
            ReservationEntryL.VALIDATE("Lot No.", ItemJournalLineL."Lot No.");
            ReservationEntryL.VALIDATE(Quantity, (ItemJournalLineL.Quantity));
            ReservationEntryL.VALIDATE("Quantity (Base)", (-ItemJournalLineL.Quantity));
            ReservationEntryL."Reservation Status" := ReservationEntryL."Reservation Status"::Prospect;
            ReservationEntryL."Source Type" := DATABASE::"Item Journal Line";
            ReservationEntryL."Source Subtype" := ItemJournalLineL."Entry Type".AsInteger();
            ReservationEntryL."Source ID" := ItemJournalLineL."Journal Template Name";
            ReservationEntryL."Source Batch Name" := ItemJournalLineL."Journal Batch Name";
            ReservationEntryL."Source Prod. Order Line" := 0;
            ReservationEntryL."Source Ref. No." := ItemJournalLineL."Line No.";
            ReservationEntryL."Qty. per Unit of Measure" := ItemJournalLineL."Qty. per Unit of Measure";
            ReservationEntryL."Item Tracking" := ReservationEntryL."Item Tracking"::"Lot No.";
            //ReservationEntryL."Bin Code" := ItemJournalLineL."Bin Code"; // //---BC Upgrade KAMNAY01 "Bin code" is drinkit field
            ReservationEntryL."Shipment Date" := ItemJournalLineL."Posting Date";
            ReservationEntryL."Created By" := USERID;
            ReservationEntryL."Creation Date" := TODAY;
            ReservationEntryL.INSERT();
        end else
            ERROR(Text039);
        //HEI.20<<
    end;

    procedure UpdateCCCfromBinCode()
    var
        Bin: Record Bin;
    begin
        //HEI.24>>
        IF Rec."Entry Type" IN [Rec."Entry Type"::Consumption, Rec."Entry Type"::Output, Rec."Entry Type"::"Assembly Consumption", Rec."Entry Type"::"Assembly Output"] THEN BEGIN//HEI.37
                                                                                                                                                                                  //IF (Rec."Entry Type" = Rec."Entry Type"::Consumption) OR (Rec."Entry Type" = Rec."Entry Type"::Output) OR (Rec."Entry Type" = Rec."Entry Type"::"Assembly Consumption") OR (Rec."Entry Type" = Rec."Entry Type"::"Assembly Output") THEN BEGIN//HEI.33//Old Code commented//HEI.37
            IF Bin.GET("Location Code", "Bin Code") AND (Bin."Ccc Code FND" <> '') THEN
                VALIDATE("Shortcut Dimension 2 Code", Bin."Ccc Code FND");
            //HEI.33>>
        end
        else BEGIN
            IF Bin.GET("Location Code", "Bin Code") AND (Bin."Ccc Code FND" <> '') THEN
                VALIDATE("Shortcut Dimension 2 Code", Bin."Ccc Code FND")
            else BEGIN
                IF gSKU.GET("Location Code", "Item No.", '') THEN BEGIN//HEI.36
                    IF gSKU."CCC Dim. Code FND" <> '' THEN BEGIN//HEI.36
                        VALIDATE("Shortcut Dimension 2 Code", gSKU."CCC Dim. Code FND");
                        //HEI.40>>
                        // {//HEI.43
                        // IF (Rec."Entry Type" = Rec."Entry Type"::Transfer) AND (Rec."New Shortcut Dimension 2 Code" <> '') THEN
                        //                   VALIDATE("New Shortcut Dimension 2 Code", gSKU."CCC Dim. Code");
                        //   }//HEI.43
                        //HEI.40<<
                    end;
                end;//HEI.36
            end;
        end;
        //HEI.33<<
        //HEI.24<<
    end;

    local procedure UpdateCCCfromNewBinCode()
    var
        Bin: Record Bin;
    begin
        //HEI.31<<
        IF Bin.GET("New Location Code", "New Bin Code") AND (Bin."Ccc Code FND" <> '') THEN
            VALIDATE("New Shortcut Dimension 2 Code", Bin."Ccc Code FND");
        //HEI.31<<
    end;

    trigger OnInsert()
    begin
        SETAUTOCALCFIELDS(); //HEI.47

        //HEI.44>>
        IF ItemJnlTemplate."Limit Type Selection FND" THEN BEGIN
            IF NOT ("Entry Type" IN ["Entry Type"::"Negative Adjmt.", "Entry Type"::"Positive Adjmt."]) THEN
                ERROR(EntryTypeErrorTxt);
        end;
        //HEI.44<<

        //BCUP0-92 PATHAA02 08.07.26>>
        if ItemJnlTemplate."Def. Gen. Bus. Posting Group FND" <> '' then
            "Gen. Bus. Posting Group" := ItemJnlTemplate."Def. Gen. Bus. Posting Group FND";
        //BCUP0-92 PATHAA02 08.07.26<<

        //HEI.32>>
        ValidateBulkTransfer();
        //HEI.32<<
    end;

    trigger OnModify()
    begin
        //HEI.32>>
        ValidateBulkTransfer();
        //HEI.32<<
    end;

    procedure ValidateBulkTransfer()
    var
        ItemJournalBatchL: Record "Item Journal Batch";
    begin
        //HEI.32>>
        "Bulk Transfer FND" := FALSE;
        IF ("Journal Template Name" <> '') AND ("Entry Type" = "Entry Type"::Transfer) AND ("Journal Batch Name" <> '') THEN BEGIN
            IF ItemJournalBatchL.GET("Journal Template Name", "Journal Batch Name") AND ItemJournalBatchL."Use in Bulk Transfer FND" THEN
                "Bulk Transfer FND" := TRUE;
        end;
        //HEI.32<<
    end;

    procedure GetVend(VendNo: Code[20])
    var
        myInt: Integer;
    begin
        //HEI.0.3>>
        IF VendNo <> Vend."No." THEN
            Vend.GET(VendNo);
        //HEI.0.3<<
    end;

    LOCAL procedure GetItem()

    begin
        IF Item."No." <> "Item No." THEN BEGIN
            IF "Item No." <> '' THEN   //HEI.04 NAIKH01
                Item.GET("Item No.");
        end;
    end;
    //BC Upgrade KAMNAY01<<

    //PATHAA02 14.04.26 [PID754,FDD-DTW-002,IBM GAP DTW 36]>>
    procedure UpdateConsumptionLine1(var ItemJournalLine: Record "Item Journal Line") //PATHAA02 25.03.26
    var
        ConsumptionjnlLine: Record "Item Journal Line";
        OutputjnlLine: Record "Item Journal Line";
        ReservationEntry: Record "Reservation Entry";
        ItemJnlLineReserve: Codeunit "Item Jnl. Line-Reserve";
        ConsumptionQty: Decimal;
        CostCalculationManagement: Codeunit "Cost Calculation Management";
        ProdOrderComponent: Record "Prod. Order Component";
        ProdOrderLine: Record "Prod. Order Line";
        Item: Record "Item";
        UomMgt: Codeunit "Unit of Measure Management";
        RecItemUOM: Record "Item Unit of Measure";
    //MfgCostCalculationManagement: Codeunit "Mfg. Cost Calculation Mgt."; //BC UPGRADE PATHAA02
    begin
        //<<DITW110.00.12A HBA 07/06/2018 NRQ#51782
        OutputjnlLine.RESET;
        //OutputjnlLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Document No.", "Entry Type", "Flushing Method", "Item Charge Type");//BC UPGRADE-ItemChargeType is DIT-removed
        OutputjnlLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Document No.", "Entry Type", "Flushing Method");
        OutputjnlLine.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
        OutputjnlLine.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
        OutputjnlLine.SETRANGE("Document No.", ItemJournalLine."Document No.");
        OutputjnlLine.SETRANGE("Entry Type", OutputjnlLine."Entry Type"::Output);
        OutputjnlLine.SETRANGE("Flushing Method", OutputjnlLine."Flushing Method"::Manual);//BC UPGRADE PATHAA02-Manual is marked for removal.
        //OutputjnlLine.SETRANGE("Flushing Method", OutputjnlLine."Flushing Method"::"Pick + Manual"); //BC UPGRADE PATHAA02
        //OutputjnlLine.SETRANGE("Has Item Charge", OutputjnlLine."Has Item Charge"); //BC UPGRADE PATHAA02-DIT, TBD
        IF OutputjnlLine.FINDLAST THEN BEGIN
            IF OutputjnlLine."Line No." = ItemJournalLine."Line No." THEN BEGIN
                ConsumptionjnlLine.RESET;
                ConsumptionjnlLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Document No.", "Entry Type", "Flushing Method", "Production jnl. flushing FND");
                ConsumptionjnlLine.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
                ConsumptionjnlLine.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                ConsumptionjnlLine.SETRANGE("Document No.", ItemJournalLine."Document No.");
                ConsumptionjnlLine.SETRANGE("Entry Type", ConsumptionjnlLine."Entry Type"::Consumption);
                ConsumptionjnlLine.SETRANGE("Flushing Method", ConsumptionjnlLine."Flushing Method"::Manual);//BC UPGRADE PATHAA02-Manual is marked for removal.
                //ConsumptionjnlLine.SETRANGE("Flushing Method", ConsumptionjnlLine."Flushing Method"::"Pick + Manual"); //BC UPGRADE PATHAA02
                ConsumptionjnlLine.SETRANGE("Production jnl. flushing FND", TRUE);
                IF ConsumptionjnlLine.FINDSET THEN
                    REPEAT
                        CLEAR(ConsumptionQty);
                        ProdOrderComponent.RESET;
                        ProdOrderComponent.SetFilterByReleasedOrderNo(ItemJournalLine."Order No.");
                        ProdOrderComponent.SETRANGE("Item No.", ConsumptionjnlLine."Item No.");
                        ProdOrderLine.SetFilterByReleasedOrderNo(ItemJournalLine."Order No.");
                        ProdOrderLine.SETRANGE("Item No.", ItemJournalLine."Item No.");
                        Item.RESET;
                        Item.GET(ItemJournalLine."Item No.");
                        IF ProdOrderLine.FINDFIRST THEN;
                        IF ProdOrderComponent.FINDFIRST THEN BEGIN
                            ConsumptionQty := CostCalculationManagement.CalcQtyAdjdForBOMScrap(ItemJournalLine."Output Quantity (Base)" * (ProdOrderComponent."Quantity (Base)" / ProdOrderLine."Qty. per Unit of Measure"), ProdOrderComponent."Scrap %"); //BC UPGRADE PATHAA02-O/P quantity base is not in BC;
                                                                                                                                                                                                                                                            // ConsumptionQty := CostCalculationManagement.CalcQtyAdjdForBOMScrap(ItemJournalLine."Quantity (Base)" * (ProdOrderComponent."Quantity (Base)" / ProdOrderLine."Qty. per Unit of Measure"), ProdOrderComponent."Scrap %"); //BC UPGRADE PATHAA02-CalcQtyAdjdForBOMScrap is marked for removal;
                                                                                                                                                                                                                                                            //ConsumptionQty := CostCalculationManagement.CalcQtyAdjdForBOMScrap(ItemJournalLine."Quantity (Base)" * (ProdOrderComponent."Quantity (Base)" / ProdOrderLine."Qty. per Unit of Measure"), ProdOrderComponent."Scrap %"); //BC UPGRADE PATHAA02;

                            IF RecItemUOM.GET(ConsumptionjnlLine."Item No.", ConsumptionjnlLine."Unit of Measure Code") THEN
                                ConsumptionQty := UomMgt.CalcQtyFromBase(ConsumptionQty, RecItemUOM."Qty. per Unit of Measure");

                            ConsumptionjnlLine.VALIDATE(Quantity, ConsumptionQty);
                            IF ConsumptionQty <> 0 THEN
                                IF Item."Rounding Precision" > 0 THEN
                                    ConsumptionjnlLine.VALIDATE(Quantity, ROUND(ConsumptionQty, Item."Rounding Precision", '>'))
                                ELSE
                                    ConsumptionjnlLine.VALIDATE(Quantity, ROUND(ConsumptionQty, 0.00001));
                            ConsumptionjnlLine.MODIFY;
                        END;
                    UNTIL ConsumptionjnlLine.NEXT = 0;
            END;
        END;
    end;
    //PATHAA02 14.04.26 [PID754,FDD-DTW-002,IBM GAP DTW 36]<<
    // BC Upgrade - RD03 System will though the error if use choose Entry typer other than Positive or Negative Adj in Scrap Journal Template -- >>
    LOCAL PROCEDURE CheckEntryTypeC(CheckScrapCode: Boolean)
    var
        Text011: TextConst ENU = 'Scrap Code cannot be Blank for the Transaction %1, Line No. %2.';
    BEGIN
        //HEI.17>>
        //Parameter is added to the function //HEI.18
        InventorySetup.GET();
        IF (InventorySetup."SCRAP Jnl. Template FND" = Rec."Journal Template Name") THEN BEGIN
            IF ((Rec."Entry Type" = Rec."Entry Type"::Sale) OR (Rec."Entry Type" = Rec."Entry Type"::Purchase)) THEN
                ERROR('Entry type %1 is not allowed For Scrap journals.', Rec."Entry Type");
            //IF "Scrap Code" = '' THEN //HEI.18
            IF CheckScrapCode AND (Rec."Scrap Code" = '') THEN //HEI.18
                ERROR(Text011, Rec."Document No.", Rec."Line No.");
        end;
        //HEI.17<<
    end;
    // BC Upgrade - RD03 System will though the error if use choose Entry typer other than Positive or Negative Adj in Scrap Journal Template -- <<
}

