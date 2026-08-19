tableextension 50188 ReturnReceiptLineExtFND extends "Return Receipt Line"
{
    //   DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 27/12/2007 Added fields
    //                                  2034647 Drink Tax Group Code
    //                                  2034675 Item Charge Type
    // DITW15.00.00.01 DDR 02/01/2008 rename field
    //                                  2034647 Item DTax Group Code + Filter to the source table
    //                                Added key
    //                                  "Document No.,Attached to Line No.,Is Item Charge
    // DITW15.00.00.01 DDR 04/01/2008 added field
    //                                  2013610 Item DDeposit Group Code
    //                                  2013611 Empty Goods Item No.
    //                                  2013612 Item Charge Quantity per
    // DITW15.00.00.01 DDR 10/01/2008 Changed function InsertInvLineFromShptLine()
    //                                Added parameter function InsertInvLineFromShptLine()
    //                                Added fields
    //                                 2034688 Due Tax
    // DITW15.00.00.01 DDR 22/01/2008 Added Drink-It Discount & Promotions Item Charges functionnalities
    //                                Change optionstring field "Item Charge Type"
    //                                Change optionstring field "Extra Charge Type"
    //                                Added fields
    //                                  2014410 Collapse
    //                                  2013773 Customer DDisc. Group Code
    //                                  2013774 Item DDisc. Group Code
    //                                  2013775 Customer DPromo. Group Code
    //                                  2013776 Item DPromo. Group Code
    //                                  2013767 Unit Volume HL
    // DITW15.00.00.01 DDR 28/01/2008 Correct GetReturnReceipts into function InsertInvLineFromRetRcptLine()
    // DITW15.00.00.01 DDR 15/02/2008 added option into "Item Charge Calculate per"
    //                                added function FormTotalingField()
    // DITW15.00.00.01 DDR 20/02/2008 added field
    //                                  2013785 Periodic Disc.-Promo Entry No.
    // DITW15.00.00.01 DDR 13/03/2008 Rename Caption field "Unit Volume HL"
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.19 DDR 20/05/2008 Update workflow into function InsertInvLineFromShptLine()
    // DITW15.00.00.20 DDR 06/06/2008 Certification rules
    // DITW15.00.00.20 DDR 11/06/2008 Certification rules
    // DITW15.00.00.21 DDR 13/06/2008 Added flowfields
    //                                  2014430 Amount
    //                                  2014431 Amount Including VAT
    //                                  2014432 Line Amount Discount
    //                                  2014433 Inv. Discount Amount
    //                                  2014434 Line Amount
    //                                  2014435 VAT Difference
    //                                  2014436 VAT Identifier
    //                                  2014437 Prepayment Line
    //                                Added functions
    //                                  CalcVATAmountLines()
    //                                  GetFieldCaption()
    //                                  GetCaptionClass()
    // DITW15.00.00.23 DDR 28/07/2008 Change Caption & CaptionClass properties
    //                                  field "Unit Volume HL"
    //                                Added function GetUomCaptionClass()
    //                     11/08/2008 Update function FormTotalingField() to show decimal places
    //                                Certification Rules
    //                                 Remove local variable lCurrUnitPrice from field "Line Discount Amount"
    // DITW15.00.00.24 DDR 14/08/2008 Added fields
    //                                  2014064 Shipping Charge Per
    //                                  2014087 Distance
    //                                  2014079 Weight
    //                                  2014080 Cubage
    //                                Added new option ",Weight,Cubage,Distance" into field "Extra Charge Type"
    // DITW15.00.00.24 DDR 07/10/2008 Added fields
    //                                  2013722 Duty Tax Type (flowfield)
    // DITW15.00.00.25 DDR 10/10/2008 Added optionstring 'ShippingCost' for field "Item Charge Type"
    //                     21/10/2008 Deleted fields
    //                                  2013722 Duty Tax Type
    //                     24/10/2008 Renamed OptionStringML (VolumeHL -> Volume /Unit) for field "Extra Charge Type"
    // DITW15.00.00.26 DDR 31/10/2008 Added new option [,DelayOrder] into "Item Charge Calculate per"
    //                                Added fields
    //                                  2013810 Periodic Delayed Entry No.
    //                     17/11/2008 Added fields
    //                                  2014077 Truck Code
    //                                  2014078 Driver Code
    // DITW15.00.00.28 DDR 24/11/2008 Added fields
    //                                  2013726 Company Tax Registration No.
    //                                  2013727 AAD No. Series
    //                                  2013728 AAD No.
    //                                  2013729 Tariff No.
    //                                  2013747 Tax Spec. HL
    //                                  2013748 Tax Spec. Degrees Plato
    //                                Added key
    //                                  "Document No.,AAD No. Series,Company Tax Registration No.,Tariff No.,Type,No."
    // DITW15.00.00.31 DDR 11/02/2009 Added fields
    //                                  2013715 Tax Formula
    // DITW15.00.00.31 DDR 19/02/2009 Added fields
    //                                  2014444 Last Price Calculated Date
    // DITW15.00.00.32 DDR 07/04/2009 Added function GetAutoformatRoundingType() to use into property 'AutoformatRoundingType'
    // DITW15.00.00.33 DDR 08/05/2009 Added fields
    //                                  20113722 Duty Suspended
    // DITW15.00.00.34 DDR 12/06/2009 Added option 'Price Item' optionstring for "Extra Charge Type" field
    // DITW15.00.00.35 DDR 23/06/2009 Added flowfilters into function CalcVATAmountLines()
    //                                Added functions CalcVATAmountLinesTemp()
    //                     24/06/2009 issue 669 Added fields
    //                                  2013824 Gen. Prod. Posting Free Group
    //                                  2013825 Free Item Posting Type
    //                                  2013826 Free Item
    //                                  2013827 Free Calculation Type
    //                                  2013828 Include Free Qty. in Minimum
    //                                Update function InsertInvLineFromRetRcptLine()
    //                     25/08/2009 Review to allow free items and multi-level item charges
    //                 DLE 06/09/2009 issue 516 Added fields
    //                                  2013696 Location Group Code
    //                                  2014094 Physical Location Group Code
    //                     13/10/2009 issue 722 Updated Filters - TableRelation property field "Empty Goods Item No. Filter"
    //                     26/10/2009 issue 924 Rename captions + optioncaptions
    //                                  "Free Item Posting Type" -> "Calculate Price on Free"
    //                                    ' ,Price,Amount' -> 'Full Amount,Price 0,Discount 100%'
    //                                  "Free Calculation Type" -> Calculate on Free
    //                                    'None,Discount 100%,All' -> 'None,Discount 100%,Full Amount'
    // DITW15.00.00.36 DDR 21/12/2009 issue 971 Modified function InsertInvLineFromRetRcptLine() to include item charges per order
    //                                issue 786 Added fields
    //                                  2013778 Opposite Qty. Sign
    //                                  2013779 Using Qty. (Base)
    //                                  2013780 Free Quantity
    //                                  2013781 Multiple Quantity
    //                                  2013782 Maximum Free Quantity
    // DITW15.00.00.37 DDR 20/01/2010 issue 1020 Added transfer fields for function InsertInvLineFromRetRcptLine()
    //                                  "Location Group Code","Company Tax Registration No.","Physical Location Group Code"
    //                     04/02/2010 issue 1033 Added fields
    //                                 2013797 Disc.Promo. Order Calculated
    // DITW15.00.00.37 DDR 27/04/2010 issue 1085 Bugfix to retrieve free items and splitted discount/promotion per order
    //                     18/06/2010 issue 1145 Bugfix skip attached lines if quantity is 0
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                             Added functions GetAutoFormatExpr(),GetTotalingAutoFormatExpr()
    //                                             Removed functions FormTotalingField()
    //                     23/07/2010              Added function GetCaptionClassVar()
    //                                             Added function RefreshSalesHeader()
    //                     10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                           Added fields
    //                                             2014260 LRN Nos Series
    //                                             2014260 LRN No.
    //                                             2014262 ARC No.
    //                                             2014263 SAD No.
    //                                             2014267 ARC No. Mandatory
    //                                             2014265 Product Tax Code
    //                                             2014476 Packaging Type Code
    //                                             2014477 No. of Packages
    //                                             2014478 Commercial Seal ID
    //                                             2014271 Tax Warehouse Reference
    //                                           Removed fields "Tax Spec. HL","Tax Spec. Degrees Plato"
    //                     05/10/2010            Added fields
    //                                             2014283 ARC Line No.
    //                                             2014284 Unsatisfactory reason
    //                                             2014285 Unsatisfactory quantity
    //                                             2014286 Unsatisfactory comment
    //                                           Added functions
    //                                             ShowLineUnstatisfactoryCmts()
    //                                           Added keys
    //                                             'Document No.,ARC No.,Company Tax Registration No.,Tariff No.,Type,No.'
    //                                           Added functions
    //                                             TestExistEDIOutboxDocNo()
    //                     23/11/2010 #1217 (DIT711 56)
    //                                  Added field "ARc No.","SAD no." to synchronize with table2013673 AAD Tracking
    //                     26/11/2010 #1217 (DIT711 83)
    //                                  Added field "ARC Line No." into the key
    //                                    'Document No.,ARC No.,ARC Line No.,Company Tax Registration No.,Tariff No.,Type,No.'
    //                                  Added 'Unconditionally' parameter function TestExistEDIOutboxDocNo()
    //                     01/12/2010 issue 1217 (DIT711 88)
    //                                           Bugfix to skip the EMCS fields when it's not EMCS line or quantity = 0
    //                     17/12/2010 issue 703 Added fields
    //                                            2014113 Tax Item No.
    //                                          Added functions GetTrackingItemNo(),LookupItemNo()
    //                     31/01/2011 issue 1217 (DIT711 140)
    //                                          Added 'DecimalPlaces' = '0:0' property field "No. of Packages"
    //                                          Rounded the default No. of Packages from Quantity field
    //                     01/02/2011 issue 941 Modified OptionCaption property field2013825 "Free Item Posting Type"
    //                     16/02/2011 issue 1217 (DIT711 148)
    //                                          Added fields
    //                                            2014482 Pack Qty. Per Unit of Measure"
    //                                          Added calculation of field "No. of Packages" per unit of measure
    //                     22/02/2011 issue 1217 (DIT711 151) Added to update field "Pack Qty. Per Unit of Measure"
    //                     24/02/2011 issue 1217 (DIT711 157) Added table permission to modify records
    //                     11/03/2011 issue 458 Replaced caption field2013696 'Location Group' -> 'Location Tax Group'
    //                                                           field2014094 (dutch)
    // DITW15.00.00.39 RBE 20/04/2011 issue 1230 Telesales functionnalities
    //                                  Added fields
    //                                    2013919 Telesales
    //                                    2013937 Entry Type
    //                                    2013938 Promotion Code
    //                                    2013939 Promotion Line
    //                                  Added key "Document No.,Unit of Measure Code       SumIndexFields=Quantity"
    //                     09/05/2011 issue 1296 Added function TestExistPostedWhseReceipt()
    //                     11/07/2011 issue 1369
    //                                  Added fields
    //                                    2013731 Applies-to AAD Trck. Entry No.
    //                                  Added keys
    //                                    "Applies-to AAD Trck. Entry No."
    //                     23/09/2011 issue 1428 Modified NLB caption for fields2014284,2014285,2014286 EMCS Unsatisfactory
    // DITW16.00.00.39 DDR 27/09/2011 DIT-715 #141 Added function IsCalcTotalCollapseLine()
    //                     28/10/2011 issue 1457 Modified many ML captions
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
    //                                  Added fields
    //                                    2013803 Allow VAT Calculation (Free)
    //                     20/01/2012 DIT-715 #172 Modified workflow (+Rollback)
    //                     01/02/2012 DIT-715 #200 Removed test on "ARC Line No." value
    //                     06/04/2012 DIT-715 #243 Loyalty functionnality
    //                                Added fields
    //                                  2014511 Allow Loyalty
    //                                  2014513 Unit Point
    //                                  2014514 Points Qty. (Base)
    //                                  2014516 Loyalty Unit Cost (LCY)
    //                                  2014517 Loyalty Unit Cost
    // DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392
    //                                Added fields
    //                                  2034850 DIT Sub-Contract Type
    //                                  2034872 Contract Group Code
    //                                  2034915 Service Contract No.
    //                                  2014310 Service Contract Line No.
    //                                  2014311 Service Contract Type
    //                 AHU 31/08/2012 DIT-715 #327 Renamed Captions fields2034915,2034310,2014311
    // DITW16.00.00.42 DDR 08/01/2013 DIT-715 #533 Added transfer EMCS fields for function InsertInvLineFromRetRcptLine()
    //                 DDR 27/02/2013 DIT-715 #550 Modified checking on "Packaging Type Code"
    // DITW16.00.00.43 FBL 18/06/2013 DIT-715 #619 Add field 2034920 "Created by Contract Batch Job" (Boolean) to be copied from sales line
    //                 DDR 22/01/2014 DIT-715 #882 Added fields 2014415 Item Charge Qty. per Uom
    // DITW16.00.00.44 DDR 24/03/2014 DIT-715 #912 Added round up field "No. of Packages"

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 AT  12/09/2013 DIT-770 #132 merge WHN-006 HIT0122.1
    //                             Add new field to DIT #376 promotion reason codes
    //                             Added new field 2013829 Free Reason Code
    // DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field "2035391, 2035392" Added
    // DITW17.00.02 SR 25/09/2013 DIT-770 #142 : New Field "Rounding factor" Added for Deposit Rounding
    // DITW17.00.02 DDR 13/11/2013 DIT-770 #230 Added fields
    //                                            2013783 DDiscount Level Position
    //                                            2013788 DDiscount Include Tax
    //                                            2013789 DDiscount Include Deposit
    //                                            2013790 DDiscount Include Discount
    // DITW17.00.02 RPG 05/11/2013 DIT-770 #235 Added Code to flow Shipment Date, Return Order No. and Return Order Line No. in Cr. Memo Item Lines
    //                                          Added Code to update Description line
    // DITW17.00.02 SR 12/03/2013 DIT-770 #147 : New Field "2013760" Added
    // DITW17.00.02 SR  29/11/2013 DIT-770 #183 : New Option Added in "Extra Charge Type" field
    // DITW17.00.02 DDR 16/12/2013 DIT-770 #274 Added fields 2013784 "DDiscount Amount"
    // DITW17.00.02 SR 19/12/2013 DIT-770 #163 : Remove the "DIT Sub-Contract Type" filter in "Service Contract No." field
    //     DITW17.00.02 DDR 08/01/2014 DIT-770 #307 Added fields 2013811 Delayed Sequence No.
    // DITW17.00.02 AT  13/01/2014 DIT-770 #235 : Added field
    //                                          : 2014414 Goods Value
    //                                          : Code to flow Goods Value
    // DITW17.00.02 DDR 23/01/2014 DIT-715 #882-893 GetSalesCrMemoLines
    // DITW17.00.03 DDR 24/03/2014 DIT-715 #912 Merge
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #623 New Customer Exception Tax Group functionality
    //                                          Added field 2013666 Customer DTax Group Code
    // DITW17.10.03 DDR 18/06/2014 DIT-770 #327 (next DIT-770 #183) Added fields
    //                                             2014504 Calculate Minimum
    //                                             2014505 Recurring Min. Quantity
    //                                             2014506 Splitting Per
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05 DDR 04/09/2014 DIT-770 #695 Added fields
    //                                            2013768 Allow Price Dit Discount
    // DITW17.10.05 DDR 08/09/2014 DIT-770 #695 Modified caption field2013768
    // DITW17.10.05 WSA 05/11/2014 DIT-700 #185 Added Loyalty Fields
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                           Added field "Financial Contract No."
    //                                           Rename Caption Contract No. by Service contract No.
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Added blank Option to Contract Type
    // DITW18.00.06 DDR 20/10/2015 DIT-770 #1449 Added fields
    //                                             2014460 Production BOM No.
    //                                             2014461 Prod. BOM Version Code
    //                                             2014462 BOM Line No.
    //                                             2014463 BOM Item No.
    //                                             2014464 BOM Qty. per Unit of Measure
    //                                          Modified 'DecimalPlaces' property field "No. of Packages"
    // DITW19.00.07 MVN 30/12/2015 DIT-770 #001 Upgrade: Set Global GetSalesCrMemoLines
    // DITW18.00.07 DDR 18/01/2016 DIT-770 #822 New functionality "Mix & Match Promotion"
    //                                          Added 'List Item' optionstring field2013777 "Item Charge Calculate Per"
    // DITW18.00.07 VSC 22/02/2016 DIT-770 #1703 Added field "Original Quantity"
    // DITW18.00.07 AKH 29/04/2016 DIT-770 #1346 Added fields 2014085 "Item Delivery Type"
    //                                                        2014086 "Delivery Time (sec.)"
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW18.00.07A DDR 29/07/2016 DIT-770 #2131 Modified to save original discount quantity
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields
    //                                                        2013716 Strength Spec. Code
    //                                                        2013717 Strength Spec. Value
    //                                                        2013718 Vol-Strength Spec. Code
    //                                                        2013719 Vol-Strength Spec. Value
    // DITW19.00.08 AKH 06/10/2016 BL#11069 (DIT-770 #2144) Mix & Match Promotions per Order
    //                                                      Added new optionstring "List Order" to field 2013777 "Item Charge Calculate per"
    // DITW19.00.08 DDR 17/10/2016 BL#10443 Modified function GetTaxSpecCaption()
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Bugfix function GetTaxSpecCaption()
    // DITW19.00.08 AKH 02/11/2016 BL#10820 (DIT-770 #1713) Get "Item Charge Value" from order line

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // FINXL10.00 AKH 02/03/2017 NRQ#25695: Added field 2029614 "Rec. Charge Attach. Line No."
    // DITW110.00.09 AKH 12/04/2017 NRQ#24104 Merge from XL NRQ#25695
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Added new fields 2014067..2014072
    // DITW110.00.11 SFI 30/08/2017 BL#14417 New field
    //                                         2013637 Deposit Value
    // DITW110.00.11 ALE 11/01/2018 NRQ#43605 Added new field 2035394 "Show Item charge on Invoice"

    // HEI.01 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Customer DTax Group Code" field length from 10 to 20 characters
    // HEI.02 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    //   # New fields
    // HEI.05 CHG0257267 IBM.AB 16.01.2019
    //   # Field length for Prod. BOM Version Code is increased from 10 to 20
    //   HEI.06 RPM Breakages IBM 03.06.2019
    //   # RPM comp.Sales Credit memo No. added new filed.
    // DITW113.00.15 DDR 04/10/2019 NRQ#10495 Rename Loyalty 'Cost' -> 'Amount' (all fields)
    //                                        Rename/Renumber fields
    //                                          2014518 -> 2014523 Loyalty Amount (LCY)
    //                                          2014519 -> 2014524 Loyalty Amount
    // DITW113.00.15 DDR 16/10/2019 NRQ#120300 Add field 2014510 Loyalty-Created
    // DITW113.00.15 MSF 15/10/2019 NRQ#122686 Contract discounts should work with ranges in Min HL as well as the periodic discounts do
    //                                          Added field Minimum Quantity In HL to table Sales line
    // CHG2104608: DITW111.00.13 ISL 18/12/2018 NRQ#96024 Deleted field 2014461 "Prod. BOM Version Code"
    // HEI.07 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Field created 50024 - CAD Amount
    // HEI.08 CHG2210794 SAHAL01 10.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Created New Fields: 50075 - Zycus Order No.
    //                         50076 - Zycus Order Line No.
    //                         50085 - Zycus Movement Type

    //     HEI.08 CHG2210794 SAHAL01 10.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Created New Fields: 50075 - Zycus Order No.
    //                         50076 - Zycus Order Line No.
    //                         50085 - Zycus Movement Type
    //BC Upgrade SHARMP16---- Interface related fields shifted from main ext table.

    fields
    {
        modify("Sell-to Customer No.")
        {
            CaptionML = ENU = 'Sell-to Customer No.', FRA = 'N° donneur d''ordre';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            // OptionCaptionML = ENU = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)', FRA = ' ,Compte général,Article,Ressource,Immobilisation,Frais annexes';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Posting Group")
        {
            CaptionML = ENU = 'Posting Group', FRA = 'Groupe comptabilisation';
        }
        modify("Shipment Date")
        {
            CaptionML = ENU = 'Shipment Date', FRA = 'Date de préparation';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify("Unit of Measure")
        {
            CaptionML = ENU = 'Unit of Measure', FRA = 'Unité';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Unit Price")
        {
            CaptionML = ENU = 'Unit Price', FRA = 'Prix unitaire';

            //Unsupported feature: Change AutoFormatExpr on ""Unit Price"(Field 22)". Please convert manually.


            //Unsupported feature: Change Description on ""Unit Price"(Field 22)". Please convert manually.

            //CaptionClass = GetCaptionClass(FIELDNO("Unit Price"));
        }
        modify("Unit Cost (LCY)")
        {
            CaptionML = ENU = 'Unit Cost (LCY)', FRA = 'Coût unitaire DS';

            //Unsupported feature: Change Description on ""Unit Cost (LCY)"(Field 23)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Unit Cost (LCY)"(Field 23)". Please convert manually.

        }
        modify("VAT %")
        {
            CaptionML = ENU = 'VAT %', FRA = '% TVA';
        }
        modify("Line Discount %")
        {
            CaptionML = ENU = 'Line Discount %', FRA = '% remise ligne';
        }
        modify("Allow Invoice Disc.")
        {
            CaptionML = ENU = 'Allow Invoice Disc.', FRA = 'Remise facture autorisée';
        }
        modify("Gross Weight")
        {
            CaptionML = ENU = 'Gross Weight', FRA = 'Poids brut';
        }
        modify("Net Weight")
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
        }
        modify("Units per Parcel")
        {
            CaptionML = ENU = 'Units per Parcel', FRA = 'Conditionnement';
        }
        modify("Unit Volume")
        {
            CaptionML = ENU = 'Unit Volume', FRA = 'Volume unitaire';
        }
        modify("Appl.-to Item Entry")
        {
            CaptionML = ENU = 'Appl.-to Item Entry', FRA = 'Écr. article à lettrer';
        }
        modify("Item Rcpt. Entry No.")
        {
            CaptionML = ENU = 'Item Rcpt. Entry No.', FRA = 'N° séquence récept. article';
        }
        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Customer Price Group")
        {
            CaptionML = ENU = 'Customer Price Group', FRA = 'Groupe prix client';
        }
        modify("Job No.")
        {
            CaptionML = ENU = 'Job No.', FRA = 'N° projet';
        }
        modify("Work Type Code")
        {
            CaptionML = ENU = 'Work Type Code', FRA = 'Code type travail';
        }
        modify("Quantity Invoiced")
        {
            CaptionML = ENU = 'Quantity Invoiced', FRA = 'Quantité facturée';
        }
        modify("Bill-to Customer No.")
        {
            CaptionML = ENU = 'Bill-to Customer No.', FRA = 'N° client facturé';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("VAT Calculation Type")
        {
            CaptionML = ENU = 'VAT Calculation Type', FRA = 'Mode calcul TVA';
            // OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
        }
        modify("Transaction Type")
        {
            CaptionML = ENU = 'Transaction Type', FRA = 'Nature transaction';
        }
        modify("Transport Method")
        {
            CaptionML = ENU = 'Transport Method', FRA = 'Mode de transport';
        }
        modify("Attached to Line No.")
        {
            CaptionML = ENU = 'Attached to Line No.', FRA = 'Attaché à la ligne n°';
        }
        modify("Exit Point")
        {
            CaptionML = ENU = 'Exit Point', FRA = 'Pays destination';
        }
        modify("Area")
        {
            CaptionML = ENU = 'Area', FRA = 'Dépt destination/provenance';
        }
        modify("Transaction Specification")
        {
            CaptionML = ENU = 'Transaction Specification', FRA = 'Régime';
        }
        modify("Tax Area Code")
        {
            CaptionML = ENU = 'Tax Area Code', FRA = 'Code zone recouvrement';
        }
        modify("Tax Liable")
        {
            CaptionML = ENU = 'Tax Liable', FRA = 'Soumis à recouvrement';
        }
        modify("Tax Group Code")
        {
            CaptionML = ENU = 'Tax Group Code', FRA = 'Code groupe taxes';
        }
        modify("VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify("VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'VAT Prod. Posting Group', FRA = 'Groupe compta. produit TVA';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Blanket Order No.")
        {
            CaptionML = ENU = 'Blanket Order No.', FRA = 'N° commande ouverte';
        }
        modify("Blanket Order Line No.")
        {
            CaptionML = ENU = 'Blanket Order Line No.', FRA = 'N° ligne cde ouverte';
        }
        modify("VAT Base Amount")
        {
            CaptionML = ENU = 'VAT Base Amount', FRA = 'Montant base TVA';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';

            //Unsupported feature: Change AutoFormatExpr on ""Unit Cost"(Field 100)". Please convert manually.


            //Unsupported feature: Change Description on ""Unit Cost"(Field 100)". Please convert manually.

        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Bin Code")
        {
            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Quantity (Base)")
        {
            CaptionML = ENU = 'Quantity (Base)', FRA = 'Quantité (base)';
        }
        modify("Qty. Invoiced (Base)")
        {
            CaptionML = ENU = 'Qty. Invoiced (Base)', FRA = 'Quantité facturée (base)';
        }
        modify("FA Posting Date")
        {
            CaptionML = ENU = 'FA Posting Date', FRA = 'Date compta. immo.';
        }
        modify("Depreciation Book Code")
        {
            CaptionML = ENU = 'Depreciation Book Code', FRA = 'Code loi d''amortissement';
        }
        modify("Depr. until FA Posting Date")
        {
            CaptionML = ENU = 'Depr. until FA Posting Date', FRA = 'Amort. jusqu''à date compta.';
        }
        modify("Duplicate in Depreciation Book")
        {
            CaptionML = ENU = 'Duplicate in Depreciation Book', FRA = 'Dupliquer dans journaux amort.';
        }
        modify("Use Duplication List")
        {
            CaptionML = ENU = 'Use Duplication List', FRA = 'Utiliser liste duplication';
        }
        modify("Responsibility Center")
        {
            CaptionML = ENU = 'Responsibility Center', FRA = 'Centre de gestion';
        }
        //BC Upgrade SHARMP16 Begin<<----------- Obselete in BC functional query
        // modify("Cross-Reference No.")
        // {
        //     CaptionML = ENU = 'Cross-Reference No.', FRA = 'Référence externe';
        // }
        // modify("Unit of Measure (Cross Ref.)")
        // {
        //     CaptionML = ENU = 'Unit of Measure (Cross Ref.)', FRA = 'Unité référence externe';
        // }
        // modify("Cross-Reference Type")
        // {
        //     CaptionML = ENU = 'Cross-Reference Type', FRA = 'Type référence externe';
        //     OptionCaptionML = ENU = ' ,Customer,Vendor,Bar Code', FRA = ' ,Client,Fournisseur,Code barre';
        // }
        // modify("Cross-Reference Type No.")
        // {
        //     CaptionML = ENU = 'Cross-Reference Type No.', FRA = 'N° type référence externe';
        // }
        //BC Upgrade SHARMP16 End>>----------- Obselete in BC functional query
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
        // modify("Product Group Code")
        // {
        //     CaptionML = ENU = 'Product Group Code', FRA = 'Code groupe produits';
        // }
        //BC Upgrade SHARMP16 ----------- Obselete in BC functional query
        modify("Return Qty. Rcd. Not Invd.")
        {
            CaptionML = ENU = 'Return Qty. Rcd. Not Invd.', FRA = 'Qté retour reçue non facturée';
        }
        modify("Appl.-from Item Entry")
        {
            CaptionML = ENU = 'Appl.-from Item Entry', FRA = 'Écriture article à lettrer';
        }
        modify("Item Charge Base Amount")
        {
            CaptionML = ENU = 'Item Charge Base Amount', FRA = 'Montant base frais annexes';
        }
        modify(Correction)
        {
            CaptionML = ENU = 'Correction', FRA = 'Correction';
        }
        modify("Return Order No.")
        {
            CaptionML = ENU = 'Return Order No.', FRA = 'N° retour';
        }
        modify("Return Order Line No.")
        {
            CaptionML = ENU = 'Return Order Line No.', FRA = 'N° ligne retour';
        }
        modify("Return Reason Code")
        {
            CaptionML = ENU = 'Return Reason Code', FRA = 'Code motif retour';
        }
        modify("Allow Line Disc.")
        {
            CaptionML = ENU = 'Allow Line Disc.', FRA = 'Autoriser remise ligne';
        }
        modify("Customer Disc. Group")
        {
            CaptionML = ENU = 'Customer Disc. Group', FRA = 'Groupe rem. client';
        }
        field(50005; "RPM Solution FND"; Option)
        {
            Caption = 'RPM Solution';
            Description = 'HEI.02';
            Editable = false;
            OptionCaption = '" ,Deposit,Full-for-Empty with revenue impact (FFE with revenue),Full-for Empty without revenue impact (FFE w/o revenue)"';
            OptionMembers = " ",Deposit,"Full-for-Empty with revenue impact (FFE with revenue)","Full-for Empty without revenue impact (FFE w/o revenue)";
        }
        field(50006; "RPM Type FND"; Code[20])
        {
            Caption = 'RPM Type';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = "Return Pack Material Type FND".Code;
        }
        field(50007; "Item Type FND"; Option)
        {
            Caption = 'Item Type';
            Description = 'HEI.02';
            Editable = false;
            OptionCaption = '" ,RPM Related,Product Related"';
            OptionMembers = " ","RPM Related","Product Related";
        }
        field(50008; "Gate Entry No. FND"; Code[20])
        {
            Caption = 'Gate Entry No.';
            Description = 'HEI:EDD001';
            Editable = false;
            TableRelation = "Gate Entry Header FND";
        }
        field(50009; "RPM comp.Sales Cr. memo No FND"; Code[10])
        {
            Caption = 'RPM comp.Sales Credit memo No.';
            Description = 'HEI.06';
            TableRelation = "Sales Header"."No.";
        }
        field(50024; "CAD Amount FND"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'CAD Amount',
                        FRA = 'CAD Montant';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
            Editable = false;
        }

        field(50075; "Zycus Order No. FND"; Code[20])
        {
            Caption = 'Zycus Order No.';
            Description = 'HEI.08';
            Editable = false;
        }
        field(50076; "Zycus Order Line No. FND"; Integer)
        {
            Caption = 'Zycus Order Line No.';
            Description = 'HEI.08';
            Editable = false;
        }
        field(50085; "Zycus Movement Type FND"; Integer)
        {
            Caption = 'Zycus Movement Type';
            Description = 'HEI.08';
            Editable = false;
        }
        //BC UPGRADE KUMARR78 FDD-MTC-008 >> Adding Field with New ID
        field(50094; "Show Item charge on Inv. FND"; Option)
        {
            Caption = 'Show Item charge on Invoice';
            OptionCaption = ' ,Under item line,Include in item price,Order total';
            OptionMembers = " ","Under item line","Include in item price","Order total";
        }
        //BC UPGRADE KUMARR78 FDD-MTC-008 << Adding Field with New ID
        //BC Upgrade SHARMP16 Begin<<----------- Interface fields
        // field(50075; "Zycus Order No."; Code[20])
        // {
        //     Caption = 'Zycus Order No.';
        //     Description = 'HEI.08';
        //     Editable = false;
        // }
        // field(50076; "Zycus Order Line No."; Integer)
        // {
        //     Caption = 'Zycus Order Line No.';
        //     Description = 'HEI.08';
        //     Editable = false;
        // }
        // field(50085; "Zycus Movement Type"; Integer)
        // {
        //     Caption = 'Zycus Movement Type';
        //     Description = 'HEI.08';
        //     Editable = false;
        // }
        //BC Upgrade SHARMP16 End>>----------- Interface fields
        //BC Upgrade SHARMP16 Begin<< -------------------- Drink-IT fields
        // field(2013610; "Item DDeposit Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Deposit Group Code',
        //                 FRA = 'Code groupe consigne article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code where("Source Type" = CONST(Item));
        // }
        // field(2013611; "Empty Goods Item No."; Code[20])
        // {
        //     CaptionML = ENU = 'Empty Goods Item No.',
        //                 FRA = 'N° article vidange';
        //     Description = 'DITW15.00.00.01-.35';
        //     TableRelation = Item where("Empty Good" = CONST(true));
        // }
        // field(2013612; "Item Charge Quantity per"; Decimal)
        // {
        //     CaptionML = ENU = 'Item Charge Quantity per',
        //                 FRA = 'Quantité frais annexes par';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.01';
        //     MinValue = 0;
        // }
        // field(2013615; "Rounding factor"; Option)
        // {
        //     CaptionML = ENU = 'Rounding factor',
        //                 FRA = 'Unité d''affichage';
        //     Description = 'DITW17.00.02 DIT-770 #142';
        //     Editable = false;
        //     OptionCaptionML = ENU = 'Nearest,Up,Down',
        //                       FRA = 'Au plus près,Par excès,Par défaut';
        //     OptionMembers = Nearest,Up,Down;
        // }
        // field(2013637; "Deposit Value"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     Caption = 'Deposit Value';
        //     Description = 'DITW110.00.11 BL#14417';
        // }
        // field(2013660; "Extra Charge Type"; Option)
        // {
        //     CaptionML = ENU = 'Extra Charge Type',
        //                 FRA = 'Type frais extra';
        //     Description = 'VC8-DITW15.00.00.01-.34';
        //     OptionCaptionML = ENU = ' ,Amount,Price %,Amount %,Fixed Amount,Volume /Unit,Weight,Cubage,Distance,Sales Price,Unit of measure',
        //                       FRA = ' ,Montant,Prix %,Montant %,Montant Fixe,Volume /Unit,Poids,Cubage,Distance,Prix vente,Unit of Measure';
        //     OptionMembers = " ",Amount,"Price %","Amount %","Fixed Amount",VolumeHL,Weight,Cubage,Distance,"Price Item","Unit of Measure";
        // }
        // field(2013661; "Item Charge Value"; Decimal)
        // {
        //     AutoFormatExpression = GetAutoformatRoundingType(GetCurrencyCode);
        //     AutoFormatType = 2;
        //     CaptionML = ENU = 'Item Charge Value',
        //                 FRA = 'Valeur frais annexes';
        //     Description = 'DITW15.00.00.32';
        // }
        // field(2013662; "Is Item Charge"; Boolean)
        // {
        //     CaptionML = ENU = 'Is Item Charge',
        //                 FRA = 'Est frais annexes';
        //     Description = 'VC8-DITW15.00.00.01';
        // }
        // field(2013663; "ItemCharge Incl. Price"; Boolean)
        // {
        //     CaptionML = ENU = 'Item Charge Incl. Price',
        //                 FRA = 'Frais annexe inclus prix';
        //     Description = 'VC8-DITW15.00.00.01';
        // }
        // field(2013664; "Item Charge Discount %"; Decimal)
        // {
        //     CaptionML = ENU = 'Item Charge Discount %',
        //                 FRA = 'Remise frais annexes %';
        //     Description = 'VC8-DITW15.00.00.01';
        // }
        // field(2013665; "Allow Item Charge Line Disc."; Boolean)
        // {
        //     CaptionML = ENU = 'Allow Item Charge Line Discount',
        //                 FRA = 'Frais annexes remise ligne autorisé';
        //     Description = 'VC8-DITW15.00.00.01';
        //     InitValue = true;
        // }
        // field(2013666; "Customer DTax Group Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Customer Tax Group Code',
        //                 FRA = 'Code groupe taxe client';
        //     Description = 'DITW17.10.03 DIT-770 623,HEI.01';
        //     TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Customer));
        // }
        // field(2013667; "Item DTax Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Tax Group Code',
        //                 FRA = 'Code groupe taxe article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Item));
        // }
        // field(2013695; "Item Charge Type"; Option)
        // {
        //     CaptionML = ENU = 'Item Charge Type',
        //                 FRA = 'Type frais annexes';
        //     Description = 'DITW15.00.00.01';
        //     OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        // }
        // field(2013696; "Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Location Tax Group Code',
        //                 FRA = 'Code groupe magasin taxe';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Location Group";
        // }
        // field(2013708; "Due Tax"; Boolean)
        // {
        //     CaptionML = ENU = 'Due Tax',
        //                 FRA = 'Taxe due';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013715; "Tax Formula"; Code[80])
        // {
        //     CaptionML = ENU = 'Tax Formula',
        //                 FRA = 'Formule taxe';
        //     Description = 'DITW15.00.00.3&';
        // }
        // field(2013716; "Strength Spec. Code"; Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0, FIELDNO("Strength Spec. Code"));
        //     CaptionML = ENU = 'Strength Spec. Code',
        //                 FRA = 'Code contrainte spécification taxe';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" where(Type = CONST(Specification));
        // }
        // field(2013718; "Vol-Strength Spec. Code"; Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0, FIELDNO("Vol-Strength Spec. Code"));
        //     CaptionML = ENU = 'Vol-Strength Spec. Code',
        //                 FRA = 'Code spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" where(Type = CONST(Specification));
        // }
        // field(2013722; "Duty Suspended"; Boolean)
        // {
        //     CaptionML = ENU = 'Duty Suspended',
        //                 FRA = 'Taxe en suspension';
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013726; "Company Tax Registration No."; Text[20])
        // {
        //     CaptionML = ENU = 'Company Tax Registration No.',
        //                 FRA = 'N° identif. accise société';
        //     Description = 'DITW15.00.00.28';
        // }
        // field(2013727; "AAD No. Series"; Code[10])
        // {
        //     CaptionML = ENU = 'AAD No. Series',
        //                 FRA = 'Souches de n° DAA';
        //     Description = 'DITW15.00.00.28';
        //     TableRelation = "No. Series";
        // }
        // field(2013728; "AAD No."; Code[20])
        // {
        //     CaptionML = ENU = 'AAD No.',
        //                 FRA = 'N° DAA';
        //     Description = 'DITW15.00.00.28';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //         if CurrFieldNo = FIELDNO("AAD No.") then
        //             TESTFIELD("Applies-to AAD Trck. Entry No.", 0);
        //         // >>DITW15.00.00.39 DDR #1369
        //     end;
        // }
        // field(2013729; "Tariff No."; Code[10])
        // {
        //     CaptionML = ENU = 'Tariff No.',
        //                 FRA = 'Nomenclature produits';
        //     Description = 'DITW15.00.00.28';
        //     TableRelation = "Tariff Number";
        // }
        // field(2013731; "Applies-to AAD Trck. Entry No."; Integer)
        // {
        //     CaptionML = ENU = 'Applies-to Correction AAD Trck. Entry No.',
        //                 FRA = 'N° Ecriture correction suivi DAA lettrage';
        //     Description = 'DITW15.00.00.39 #1369';
        //     TableRelation = "AAD Tracking Entry"."Entry No." where("Entry Type" = CONST(Outbound),
        //                                                             "Source Type" = CONST(Customer),
        //                                                             "Source No." = FIELD("Sell-to Customer No."));

        //     trigger OnValidate();
        //     var
        //         AADTrackingEntry: Record "AAD Tracking Entry";
        //     begin
        //         TESTFIELD(Type, Type::Item);
        //         if "Applies-to AAD Trck. Entry No." <> 0 then begin
        //             TESTFIELD("LRN No.", '');
        //             AADTrackingEntry.GET("Applies-to AAD Trck. Entry No.");
        //             "AAD No." := AADTrackingEntry."AAD No.";
        //             "ARC No." := AADTrackingEntry."ARC No.";
        //         end;
        //     end;
        // }
        // field(2013760; "Unit Volume Sales Price"; Option)
        // {
        //     CaptionML = ENU = 'Unit Volume Sales Price',
        //                 FRA = 'Volume Unitaire Prix de Vente';
        //     Description = 'DITW17.00.02 DIT-770 #147';
        //     Editable = false;
        //     OptionCaptionML = ENU = 'No,Yes',
        //                       FRA = 'Non,Oui';
        //     OptionMembers = No,Yes;
        // }
        // field(2013767; "Unit Volume HL"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Unit Volume HL"));
        //     CaptionML = ENU = 'Unit Volume',
        //                 FRA = 'Volume unitaire';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.01';
        //     MinValue = 0;
        // }
        // field(2013768; "Allow Price Dit Discount"; Boolean)
        // {
        //     CaptionML = ENU = 'Special Price (Dit Discount)',
        //                 FRA = 'Prix special (Remise DIT)';
        //     Description = 'DITW17.10.05 DIT-770 #695';
        // }
        // field(2013773; "Customer DDisc. Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Customer Discount Group',
        //                 FRA = 'Groupe remise client';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Discount Group".Code where("Source Type" = CONST(Customer));
        // }
        // field(2013774; "Item DDisc. Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Discount Group',
        //                 FRA = 'Groupe remise article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Discount Group".Code where("Source Type" = CONST(Item));
        // }
        // field(2013775; "Customer DPromo. Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Customer Promotion Group',
        //                 FRA = 'Groupe promotion client';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Promotion Group".Code where("Source Type" = CONST(Customer));
        // }
        // field(2013776; "Item DPromo. Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Promotion Group',
        //                 FRA = 'Groupe promotion article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Promotion Group".Code where("Source Type" = CONST(Item));
        // }
        // field(2013777; "Item Charge Calculate per"; Option)
        // {
        //     CaptionML = ENU = 'Item Charge Calculate per',
        //                 FRA = 'Frais annexe calcul par';
        //     Description = 'DITW15.00.00.01 - DITW19.00.08 BL#11069';
        //     OptionCaptionML = ENU = 'Item,Order,Period,Delayed Order,List Item,List Order',
        //                       FRA = 'Article,Order,Périodique,Commande retardée,Liste Article,Liste Commande';
        //     OptionMembers = Item,"Order",Period,DelayOrder,ListItem,ListOrder;
        // }
        // field(2013778; "Opposite Qty. Sign"; Boolean)
        // {
        //     CaptionML = ENU = 'Opposite Qty. Sign',
        //                 FRA = 'Signe quantité opposé';
        //     Description = 'DITW15.00.00.36';
        // }
        // field(2013779; "Using Qty. (Base)"; Boolean)
        // {
        //     CaptionML = ENU = 'Using Qty. (Base)',
        //                 FRA = 'Utilisation quantité (Base)';
        //     Description = 'DITW15.00.00.36';
        // }
        // field(2013780; "Free Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Free Quantity',
        //                 FRA = 'Quantité gratuite';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.36';
        //     MinValue = 0;
        // }
        // field(2013781; "Multiple Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Multiple Quantity',
        //                 FRA = 'Quantité multiple';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.36';
        //     MinValue = 0;
        // }
        // field(2013782; "Maximum Free Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Maximum Free Quantity',
        //                 FRA = 'Quantité maximum gratuite';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.36';
        //     MinValue = 0;
        // }
        // field(2013783; "DDiscount Level Position"; Integer)
        // {
        //     CaptionML = ENU = 'Discount Level Position',
        //                 FRA = 'Position niveau de remise';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013784; "DDiscount Base Amount"; Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCode;
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'DDiscount Base Amount',
        //                 FRA = 'Montant base remise';
        //     Description = 'DITW17.00.02 DIT-770 #274';
        // }
        // field(2013785; "Periodic Disc.-Promo Entry No."; Integer)
        // {
        //     CaptionML = ENU = 'Periodic Disc.-Promo Entry No.',
        //                 FRA = 'N° écriture Remise-Promotion périodique';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Sales Discount.-Promo. Entry"."Entry No.";
        // }
        // field(2013788; "DDiscount Include Tax"; Boolean)
        // {
        //     CaptionML = ENU = 'Discount Include Tax',
        //                 FRA = 'Remise inculant taxe';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013789; "DDiscount Include Deposit"; Boolean)
        // {
        //     CaptionML = ENU = 'DDiscount Include Deposit',
        //                 FRA = 'Remise incluent caution';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013790; "DDiscount Include Discount"; Boolean)
        // {
        //     CaptionML = ENU = 'DDiscount Include Discount',
        //                 FRA = 'Remise incluent remise';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013797; "Disc.Promo. Order Calculated"; Boolean)
        // {
        //     CaptionML = ENU = 'Disc.Promo. Order Calculated',
        //                 FRA = 'Remise-Promotion cmde. calculé';
        //     Description = 'DITW15.00.00.37';
        // }
        // field(2013803; "Allow VAT Calculation (Free)"; Boolean)
        // {
        //     CaptionML = ENU = 'Allow VAT Calculation (Free)',
        //                 FRA = 'Autoriser calcul TVA (Gratuit)';
        //     Description = 'DITW16.00.00.40 DIT-715 #172';
        // }
        // field(2013810; "Periodic Delayed Entry No."; Integer)
        // {
        //     CaptionML = ENU = 'Periodic Disc.-Promo Entry No.',
        //                 FRA = 'N° écriture Remise-Promotion périodique';
        //     Description = 'DITW15.00.00.26';
        //     TableRelation = "Sales Discount.-Promo. Entry"."Entry No.";
        // }
        // field(2013811; "Delayed Sequence No."; Integer)
        // {
        //     CaptionML = ENU = 'Delayed Sequence No.',
        //                 FRA = 'N° séquence retardé';
        //     Description = 'DITW17.00.02 DIT-770 #307';
        // }
        // field(2013824; "Gen. Prod. Posting Free Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Gen. Prod. Posting Group Free Item',
        //                 FRA = 'Groupe article gratuit compta. produit';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Gen. Product Posting Group";
        // }
        // field(2013825; "Free Item Posting Type"; Option)
        // {
        //     CaptionML = ENU = 'Calculate Price on Free',
        //                 FRA = 'Calculer Prix sur gratuit';
        //     Description = 'DITW15.00.00.35';
        //     OptionCaptionML = ENU = ' ,Price 0,Discount 100%',
        //                       FRA = ' ,Prix 0,Remise 100%';
        //     OptionMembers = " ",Price,Amount;
        // }
        // field(2013826; "Free Item"; Boolean)
        // {
        //     CaptionML = ENU = 'Free Item',
        //                 FRA = 'Article gratuit';
        //     Description = 'DITW15.00.00.35';
        // }
        // field(2013827; "Free Calculation Type"; Option)
        // {
        //     CaptionML = ENU = 'Calculate on Free',
        //                 FRA = 'Calculer sur gratuit';
        //     Description = 'DITW15.00.00.35';
        //     OptionCaptionML = ENU = 'None,Discount 100%,Full Amount',
        //                       FRA = 'Aucun,Remise 100%,Montant';
        //     OptionMembers = "None","Discount 100%",All;
        // }
        // field(2013828; "Include Free Qty. in Minimum"; Boolean)
        // {
        //     CaptionML = ENU = 'Include Free Quantity in Minimum',
        //                 FRA = 'Inclure quantité gratuite avec minimum';
        //     Description = 'DITW15.00.00.35';
        // }
        // field(2013829; "Free Reason Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Free Reason Code',
        //                 FRA = 'Code motif gratuit';
        //     Description = 'DITW17.00.02 DIT-770 #132';
        //     TableRelation = "Free Reason Code";
        // }
        // field(2013919; "Added By Telesales"; Boolean)
        // {
        //     CaptionML = ENU = 'Telesales',
        //                 FRA = 'Télévente';
        //     Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
        // }
        // field(2013937; "Entry Type"; Option)
        // {
        //     CaptionML = ENU = 'Entry Type',
        //                 FRA = 'Type écriture';
        //     Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
        //     OptionCaptionML = ENU = 'Order,,Telesales',
        //                       FRA = 'Commande,,Télévente';
        //     OptionMembers = "Order",,Telesales;
        // }
        // field(2013938; "Promotion Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Promotion Code',
        //                 FRA = 'Code promotion';
        //     Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
        // }
        // field(2013939; "Promotion Line"; Boolean)
        // {
        //     CaptionML = ENU = 'Promotion Line',
        //                 FRA = 'Ligne promotion';
        //     Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
        // }
        // field(2014064; "Shipping Charge Per"; Option)
        // {
        //     CaptionML = ENU = 'Shipping Charge Per',
        //                 FRA = 'Frais transport par';
        //     Description = 'DITW15.00.00.24';
        //     OptionCaptionML = ENU = 'Shipment,Weight,Volume',
        //                       FRA = 'Expédition,Poids,Volume';
        //     OptionMembers = Shipment,Weight,Volume;
        // }
        // field(2014065; "Original Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Original Quantity',
        //                 FRA = 'Quantité initiale';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW18.00.07 DIT-770 #1703';
        //     MaxValue = 100;
        //     MinValue = 0;
        // }
        // field(2014067; "Backorder Type"; Option)
        // {
        //     Caption = 'Backorder Type';
        //     Description = 'DITW110.00.10 BL#15657';
        //     OptionCaption = '" ,Backorder,No Backorder"';
        //     OptionMembers = " ",Backorder,"No Backorder";

        //     trigger OnValidate();
        //     var
        //         ItemBackOrderNotification: Notification;
        //     begin
        //     end;
        // }
        // field(2014071; "Original Sales Order No."; Code[20])
        // {
        //     Caption = 'Original Sales Order No.';
        //     Description = 'DITW110.00.10 BL#15657';
        // }
        // field(2014072; "Original Sales Order Line No."; Integer)
        // {
        //     Caption = 'Original Sales Order Line No.';
        //     Description = 'DITW110.00.10 BL#15657';
        // }
        // field(2014077; "Truck Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Truck Code',
        //                 FRA = 'Code camion';
        //     Description = 'DITW15.00.00.26';
        //     TableRelation = "Whse. Shipping Truck";
        // }
        // field(2014078; "Driver Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Driver Code',
        //                 FRA = 'Code chauffeur';
        //     Description = 'DITW15.00.00.26';
        //     TableRelation = "Whse. Shipping Driver";
        // }
        // field(2014079; Cubage; Decimal)
        // {
        //     CaptionML = ENU = 'Volume (Cubage)',
        //                 FRA = 'Volume (cubage)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.24';
        // }
        // field(2014080; Weight; Decimal)
        // {
        //     CaptionML = ENU = 'Weight',
        //                 FRA = 'Poids';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.24';
        // }
        // field(2014085; "Item Delivery Type"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Delivery Type',
        //                 FRA = 'Type de Livraison Article';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     TableRelation = "Delivery Type".Code where(Type = CONST(Item));
        // }
        // field(2014086; "Delivery Time (sec.)"; Decimal)
        // {
        //     CaptionML = ENU = 'Delivery Time (sec.)',
        //                 FRA = 'Temps de Livraison (Sec.)';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     MinValue = 0;
        // }
        // field(2014087; Distance; Decimal)
        // {
        //     CaptionML = ENU = 'Distance',
        //                 FRA = 'Distance';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.24';
        //     MinValue = 0;
        // }
        // field(2014094; "Physical Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Physical Location Group Code',
        //                 FRA = 'Code groupe magasin réel';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014113; "Tax Item No."; Code[20])
        // {
        //     CaptionML = ENU = 'Tax Tracking Item No.',
        //                 FRA = 'N° article traçable Taxe';
        //     Description = 'DITW15.00.00.38 #703';
        //     TableRelation = Item;
        // }
        // field(2014260; "LRN No. Series"; Code[10])
        // {
        //     CaptionML = ENU = 'LRN No. Series',
        //                 FRA = 'Souches de n° LRN';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "No. Series";
        // }
        // field(2014261; "LRN No."; Code[20])
        // {
        //     CaptionML = ENU = 'LRN No.',
        //                 FRA = 'N° LRN';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014262; "ARC No."; Code[30])
        // {
        //     CaptionML = ENU = 'ARC No.',
        //                 FRA = 'N° ARC';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/11/2010 #1217 (DIT711 56)
        //         if "ARC No." <> xRec."ARC No." then
        //             if not LRNDocMgt.SynchDocToAADTracking(
        //               DATABASE::"Return Receipt Line", "Document No.", "Line No.", FIELDCAPTION("ARC No."), xRec."ARC No.", "ARC No.")
        //             then
        //                 FIELDERROR("ARC No.");
        //         // >>DITW15.00.00.38 #1217
        //         // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //         if CurrFieldNo = FIELDNO("ARC No.") then
        //             TESTFIELD("Applies-to AAD Trck. Entry No.", 0);
        //         // >>DITW15.00.00.39 DDR #1369
        //     end;
        // }
        // field(2014263; "SAD No."; Code[30])
        // {
        //     CaptionML = ENU = 'SAD No.',
        //                 FRA = 'N° SAD';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/11/2010 #1217 (DIT711 56)
        //         if "SAD No." <> xRec."SAD No." then
        //             if not LRNDocMgt.SynchDocToAADTracking(
        //               DATABASE::"Return Receipt Line", "Document No.", "Line No.", FIELDCAPTION("SAD No."), xRec."SAD No.", "SAD No.")
        //             then
        //                 FIELDERROR("SAD No.");
        //         // >>DITW15.00.00.38 #1217
        //     end;
        // }
        // field(2014265; "Product Tax Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Tax Product Code',
        //                 FRA = 'Code Produit taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Product";
        // }
        // field(2014267; "ARC No. Mandatory"; Boolean)
        // {
        //     CaptionML = ENU = 'ARC No. Mandatory (EMCS)',
        //                 FRA = 'N° ARC obligatoire (EMCS)';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014271; "Company Tax Warehouse Ref."; Text[20])
        // {
        //     CaptionML = ENU = 'Company Tax Warehouse Reference',
        //                 FRA = 'Entrepôt fiscal de référence société';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014283; "ARC Line No."; Integer)
        // {
        //     CaptionML = ENU = 'ARC Line No.',
        //                 FRA = 'N° ligne ARC';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     var
        //         ReturnRcptLine: Record "Return Receipt Line";
        //     begin
        //         // <<DITW15.00.00.38 DDR 26/11/2010 #1217 (DIT711 83)
        //         TESTFIELD(Correction, false);
        //         TESTFIELD("ARC No. Mandatory", true);
        //         TESTFIELD("ARC No.");
        //         if TestExistEDIOutboxDocNo(false) then
        //             TESTFIELD("ARC Line No.", xRec."ARC Line No.");
        //         // <<DITW15.00.00.39 DDR 09/05/2011 #1296
        //         ExistPostedWhseReceipt(FIELDCAPTION("ARC Line No."));
        //         // >>DITW15.00.00.39 DDR #1296
        //         // <<DITW16.00.00.40 DDR 01/02/2012 DIT-715 #200
        //         if "Unsatisfactory Type" > 0 then
        //             TESTFIELD("ARC Line No.")
        //         else
        //             TESTFIELD("ARC Line No.", 0);
        //         // >>DITW16.00.00.40 DDR DIT-715 #200

        //         if "ARC Line No." <> 0 then begin
        //             ReturnRcptLine.SETCURRENTKEY("Document No.", "ARC No.", "ARC Line No.");
        //             ReturnRcptLine.SETRANGE("Document No.", "Document No.");
        //             ReturnRcptLine.SETRANGE("ARC No.", "ARC No.");
        //             ReturnRcptLine.SETFILTER("Line No.", '<>%1', "Line No.");
        //             ReturnRcptLine.SETRANGE("ARC Line No.", "ARC Line No.");
        //             if ReturnRcptLine.FINDFIRST then
        //                 ReturnRcptLine.FIELDERROR("ARC Line No.");
        //         end;
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2014284; "Unsatisfactory Type"; Option)
        // {
        //     CaptionML = ENU = 'Unsatisfactory Type',
        //                 FRA = 'Type Insatisfaisant';
        //     Description = 'DITW15.00.00.38 #1217';
        //     OptionCaptionML = ENU = 'Other,Excess,Shortage,Good Damaged,Broken Seal,Reported by Export Control System,Incorrect Values',
        //                       FRA = 'Autre,En excès,En pénurie,Marchandise abimée,Sceau brisé,Rapporté par ECS,Valeurs incorrectes';
        //     OptionMembers = " ",Excess,Shortage,"Good damaged","Broken Seal","Reported by ECS","Incorrect Values";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 06/10/2010
        //         TESTFIELD(Correction, false);
        //         TESTFIELD("ARC No. Mandatory", true);
        //         TESTFIELD("ARC No.");
        //         if TestExistEDIOutboxDocNo(false) then
        //             TESTFIELD("Unsatisfactory Type", xRec."Unsatisfactory Type");
        //         // <<DITW15.00.00.39 DDR 09/05/2011 #1296
        //         if CurrFieldNo <> 0 then
        //             ExistPostedWhseReceipt(FIELDCAPTION("Unsatisfactory Type"));
        //         // >>DITW15.00.00.39 DDR #1296

        //         if "Unsatisfactory Type" = "Unsatisfactory Type"::" " then begin
        //             "Unsatisfactory Quantity" := 0;
        //             // <<DITW16.00.00.40 DDR 01/02/2012 DIT-715 #200
        //             "ARC Line No." := 0;
        //             // >>DITW16.00.00.40 DDR DIT-715 #200
        //         end;
        //         // >>DITW15.00.00.38 DDR
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2014285; "Unsatisfactory Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Unsatisfactory Quantity',
        //                 FRA = 'Quantité Insatisfaisant';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 06/10/2010
        //         TESTFIELD(Correction, false);
        //         TESTFIELD("ARC No. Mandatory", true);
        //         TESTFIELD("ARC No.");
        //         if TestExistEDIOutboxDocNo(false) then
        //             TESTFIELD("Unsatisfactory Quantity", xRec."Unsatisfactory Quantity");
        //         // <<DITW15.00.00.39 DDR 09/05/2011  #1296
        //         if CurrFieldNo <> 0 then
        //             ExistPostedWhseReceipt(FIELDCAPTION("Unsatisfactory Quantity"));
        //         // >>DITW15.00.00.39 DDR #1296

        //         if "Unsatisfactory Quantity" <> 0 then begin
        //             if "Unsatisfactory Type" = 0 then
        //                 FIELDERROR("Unsatisfactory Type");
        //         end else
        //             "Unsatisfactory Type" := "Unsatisfactory Type"::" ";
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2014286; "Unsatisfactory Comment"; Boolean)
        // {
        //     CalcFormula = Exist("EMCS Comment Line" where("Table ID" = CONST(6661),
        //                                                    "Document Type" = CONST(0),
        //                                                    "Document No." = FIELD("Document No."),
        //                                                    "Document Line No." = FIELD("Line No."),
        //                                                    "Field ID" = CONST(2014285)));
        //     CaptionML = ENU = 'Unsatisfactory Comment',
        //                 FRA = 'Commentaires insatisfaisant';
        //     Description = 'DITW15.00.00.38 #1217';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014310; "Service Contract Line No."; Integer)
        // {
        //     CaptionML = ENU = 'Contract Line No.',
        //                 FRA = 'N° ligne contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';
        // }
        // field(2014313; "Financial Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Financial Contract No.',
        //                 FRA = 'N° Contrat Financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Financial Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                       "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2014410; Collapse; Boolean)
        // {
        //     CaptionML = ENU = 'Collapse',
        //                 FRA = 'Réduire';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2014414; "Goods Value"; Boolean)
        // {
        //     CaptionML = ENU = 'Goods Value',
        //                 FRA = 'Valeur des marchandises';
        //     Description = 'DITW17.00.02 DIT-770 #235';
        // }
        // field(2014415; "Item Charge Qty. per Uom"; Decimal)
        // {
        //     CaptionML = ENU = 'Item Charge Qty. per Unit of Measure',
        //                 FRA = 'Qté frais annexe par unité de mesure';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.43 DIT-715 #882';
        //     InitValue = 1;
        // }
        // field(2014430; Amount; Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCode;
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Amount',
        //                 FRA = 'Montant';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        // }
        // field(2014431; "Amount Including VAT"; Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCode;
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Amount Including VAT',
        //                 FRA = 'Montant TTC';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        // }
        // field(2014432; "Line Discount Amount"; Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCode;
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Line Discount Amount',
        //                 FRA = 'Montant remise ligne';
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014433; "Inv. Discount Amount"; Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCode;
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Inv. Discount Amount',
        //                 FRA = 'Montant remise facture';
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014434; "Line Amount"; Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCode;
        //     AutoFormatType = 1;
        //     CaptionClass = GetCaptionClass(FIELDNO("Line Amount"));
        //     CaptionML = ENU = 'Line Amount',
        //                 FRA = 'Montant ligne';
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014435; "VAT Difference"; Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCode;
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'VAT Difference',
        //                 FRA = 'Différence TVA';
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014436; "VAT Identifier"; Code[10])
        // {
        //     CaptionML = ENU = 'VAT Identifier',
        //                 FRA = 'Identifiant TVA';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        // }
        // field(2014437; "Prepayment Line"; Boolean)
        // {
        //     CaptionML = ENU = 'Prepayment Line',
        //                 FRA = 'Ligne acompte';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        // }
        // field(2014444; "Last Price Calculated Date"; Date)
        // {
        //     CaptionML = ENU = 'Last Price Calculated Date',
        //                 FRA = 'Dernière date prix calculé';
        //     Description = 'DITW15.00.00.31';
        // }
        // field(2014460; "Production BOM No."; Code[20])
        // {
        //     CaptionML = ENU = 'Production BOM No.',
        //                 FRA = 'N° nomenclature production';
        //     Description = 'DITW18.00.06 DIT-770 #1449';
        //     TableRelation = "Production BOM Header";
        // }
        // field(2014462; "BOM Line No."; Integer)
        // {
        //     CaptionML = ENU = 'BOM Line No.',
        //                 FRA = 'N° ligne nomenclature';
        //     Description = 'DITW18.00.06 DIT-770 #1449';
        //     NotBlank = true;
        //     TableRelation = IF ("Production BOM No." = FILTER(<> '')) "Production BOM Line"."Line No." where("Production BOM No." = FIELD("Production BOM No."))
        //     else IF ("Production BOM No." = CONST('')) "BOM Component"."Line No." where("Parent Item No." = FIELD("BOM Item No."));
        // }
        // field(2014463; "BOM Item No."; Code[20])
        // {
        //     CaptionML = ENU = 'BOM Item No.',
        //                 FRA = 'N° article nomenclature';
        //     Description = 'DITW18.00.06 DIT-770 #1449';
        //     TableRelation = Item;
        // }
        // field(2014464; "BOM Qty. per Unit of Measure"; Decimal)
        // {
        //     CaptionML = ENU = 'BOM Qty. per Unit of Measure',
        //                 FRA = 'Quantité par unité nomenclature';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW18.00.06 DIT-770 #1449';
        // }
        // field(2014476; "Packaging Type Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Packaging Type Code',
        //                 FRA = 'Code Type de Conditionnement';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Packaging Type";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 14/09/2010 - 12/10/2010 #1217
        //         TESTFIELD(Correction, false);
        //         // <<DITW18.00.06 DDR 20/10/2015 DIT-770 #1449
        //         if (CurrFieldNo = FIELDNO("Packaging Type Code")) and ("Tax Item No." <> '') and
        //           ("Packaging Type Code" <> '') and (xRec."Packaging Type Code" <> "Packaging Type Code")
        //         then
        //             TESTFIELD("Packaging Type Code", xRec."Packaging Type Code");
        //         // >>DITW18.00.06 DDR DIT-770 #1449

        //         // <<DITW16.00.00.42 DDR 27/02/2013 DIT-715 #550
        //         if ("Packaging Type Code" <> '') and ((Type = Type::Item) or ("Tax Item No." <> '')) then begin
        //             // >>DITW16.00.00.42 DDR DIT-715 #550
        //             PackagingType.GET("Packaging Type Code");
        //             if PackagingType.Countable then begin
        //                 // <<DITW15.00.00.38 DDR 22/02/2010 #1217 (DIT711 151)
        //                 if "Tax Item No." <> '' then begin
        //                     Item.GET("Tax Item No.");
        //                     ItemUnitOfMeasure.GET("Tax Item No.", Item."Sales Unit of Measure");
        //                 end else
        //                     ItemUnitOfMeasure.GET("No.", "Unit of Measure Code");
        //                 if "Packaging Type Code" = ItemUnitOfMeasure."Packaging Type Code" then begin
        //                     ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
        //                     "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
        //                 end else
        //                     "Pack Qty. per Unit of Measure" := 1;
        //                 // >>DITW15.00.00.38 DDR #1217 (DIT711 151)
        //                 // <<DITW15.00.00.38 DDR 31/01/2011 #1217 (DIT711 140) - 16/02/2011 (DIT711 148)
        //                 TESTFIELD("Pack Qty. per Unit of Measure");
        //                 // <<DITW16.00.00.44 DDR 24/03/2014 DIT-715 #912
        //                 "No. of Packages" := ROUND(Quantity * "Pack Qty. per Unit of Measure", 1, '>');
        //                 // >>DITW16.00.00.44 DDR DIT-715 #912
        //                 // >>DITW15.00.00.38 DDR #1217 (DIT711 140) (DIT711 148)
        //             end else
        //                 "No. of Packages" := 0;
        //         end else
        //             // <<DITW15.00.00.38 DDR 22/02/2010 #1217 (DIT711 151)
        //             "No. of Packages" := 0;
        //         // >>DITW15.00.00.38 DDR #1217 (DIT711 151)
        //         // >>DITW15.00.00.38 DDR #1217
        //     end;
        // }
        // field(2014477; "No. of Packages"; Decimal)
        // {
        //     CaptionML = ENU = 'No. of Packages',
        //                 FRA = 'Nbre de colis';
        //     DecimalPlaces = 0 : 2;
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 16/09/2010 - 12/10/2010 #1217
        //         TESTFIELD(Correction, false);
        //         TESTFIELD(Quantity);
        //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //         if ("Tax Item No." = '') and (Type <> Type::Item) then
        //             TESTFIELD("No. of Packages", 0);
        //         // >>DITW15.00.00.38 DDR #703
        //         // <<DITW18.00.06 DDR 20/10/2015 DIT-770 #1449
        //         if ("Tax Item No." <> '') and (xRec."No. of Packages" <> "No. of Packages") then
        //             TESTFIELD("No. of Packages", xRec."No. of Packages");
        //         // >>DITW18.00.06 DDR DIT-770 #1449
        //     end;
        // }
        // field(2014478; "Commercial Seal ID"; Text[35])
        // {
        //     CaptionML = ENU = 'Commercial Seal ID',
        //                 FRA = 'ID sceau commerciale';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 16/09/2010 - 12/10/2010 #1217
        //         TESTFIELD(Correction, false);
        //         TESTFIELD(Quantity);
        //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //         if ("Tax Item No." = '') and (Type <> Type::Item) then
        //             TESTFIELD("Commercial Seal ID", '');
        //         // >>DITW15.00.00.38 DDR #703
        //     end;
        // }
        // field(2014482; "Pack Qty. per Unit of Measure"; Decimal)
        // {
        //     CaptionML = ENU = 'Packaging Qty. per Unit of Measure',
        //                 FRA = 'Quantité conditionnement par unité';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.38 #1217 (DIT711 148)';
        // }
        // field(2014500; "Has Item Charge"; Boolean)
        // {
        //     CalcFormula = Exist("Return Receipt Line" where("Document No." = FIELD("Document No."),
        //                                                      "Attached to Line No." = FIELD("Line No.")));
        //     CaptionML = ENU = 'Has Item Charge',
        //                 FRA = 'A des Frais Annexes';
        //     Description = 'DITW17.10.03 DIT-770 #541';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014503; "Equiv. Unit of Measure Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Equiv. Unit of Measure Code',
        //                 FRA = 'Unitié de mesure equiv.';
        //     Description = 'DITW17.00.02 DIT-770 #183';
        //     TableRelation = "Unit of Measure".Code;
        // }
        // field(2014504; "Calculate Minimum"; Option)
        // {
        //     CaptionML = ENU = 'Calculate Minimum',
        //                 FRA = 'Calculer minimum';
        //     Description = 'DITW17.10.03 DIT-770 #327-NRQ#14143';
        //     OptionCaptionML = ENU = ' ,Under,Over,Until,Until Including Min,Recurring Minimum,Recurring Over,Recurring Under,Recurring Until',
        //                       FRA = ' ,Under,Over,Until,Until Including Min,Recurring Minimum,Recurring Over,Recurring Under,Recurring Until';
        //     OptionMembers = " ",Under,Over,"Until","Until Including Min","Recurring Minimum","Recurring Over","Recurring Under","Recurring Until";
        // }
        // field(2014505; "Recurring Min. Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Recurring Min. Quantity',
        //                 FRA = 'Quantité Min. Recurrente';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW17.10.03 DIT-770 #327';
        //     MinValue = 0;
        // }
        // field(2014506; "Splitting per"; Option)
        // {
        //     CaptionML = ENU = 'Calculate Source Per',
        //                 FRA = 'Calculer source par';
        //     Description = 'DITW17.10.03 DIT-770 #327';
        //     InitValue = Item;
        //     OptionCaptionML = ENU = 'Group,Item',
        //                       FRA = 'Groupe,Article';
        //     OptionMembers = Group,Item;
        // }
        // field(2014507; "Minimum Quantity"; Decimal)
        // {
        //     Caption = 'Minimum Quantity';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'NRQ#14143';
        //     MinValue = 0;
        // }
        // field(2014508; "Minimum Quantity in HL"; Decimal)
        // {
        //     Caption = 'Minimum Quantity in HL';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW113.00.15 NRQ#122686';
        //     MinValue = 0;
        // }
        // field(2014509; "Minimum Amount"; Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCode;
        //     AutoFormatType = 1;
        //     Caption = 'Minimum Amount';
        //     Description = 'DITW113.00.15 NRQ#122686';
        //     MinValue = 0;
        // }
        // field(2014510; "Loyalty-Created"; Boolean)
        // {
        //     Caption = 'Loyalty-Created';
        //     Description = 'DITW113.00.15 NRQ#120300';
        // }
        // field(2014511; "Allow Loyalty"; Boolean)
        // {
        //     CaptionML = ENU = 'Allow Loyalty',
        //                 FRA = 'Autoriser Fidélité';
        //     Description = 'DITW16.00.00.40 DIT715 #243';
        // }
        // field(2014513; "Loyalty Unit Point"; Decimal)
        // {
        //     Caption = 'Loyalty Unit Point';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.40 DIT715 #243';
        // }
        // field(2014514; "Loyalty Points Qty. (Base)"; Decimal)
        // {
        //     Caption = 'Loyalty Points (Base)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.40 DIT715 #243';
        // }
        // field(2014516; "Loyalty Unit Amount (LCY)"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     Caption = 'Loyalty Unit Amount (LCY)';
        //     Description = 'DITW16.00.00.40 DIT715 #243';
        // }
        // field(2014517; "Loyalty Unit Amount"; Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCode;
        //     AutoFormatType = 2;
        //     Caption = 'Loyalty Unit Amount';
        //     Description = 'DITW16.00.00.40 DIT715 #243';
        // }
        // field(2014520; "Loyalty Convert to Free Item"; Boolean)
        // {
        //     CaptionML = ENU = 'Automatic Set Free Item',
        //                 FRA = 'Définir comme Article gratuit';
        //     Description = 'DITW17.10.05 DIT-770 #185';
        // }
        // field(2014521; "Loyalty Point Type"; Option)
        // {
        //     CaptionML = ENU = 'Loyalty Point Type',
        //                 FRA = 'Type Point de fidelisation';
        //     Description = 'DITW17.10.05 DIT-770 #185';
        //     OptionCaptionML = ENU = ' ,Exchange,Gain',
        //                       FRA = ' ,Change,Gain';
        //     OptionMembers = " ",Exchange,Gain;
        // }
        // field(2014522; "Loyalty Amount Type"; Option)
        // {
        //     Caption = 'Loyalty Amount Type';
        //     Description = 'DITW17.10.05 DIT-770 #185';
        //     OptionCaption = '" ,Exchange,Gain"';
        //     OptionMembers = " ",Exchange,Gain;
        // }
        // field(2014523; "Loyalty Amount (LCY)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     Caption = 'Loyalty Amount (LCY)';
        //     Description = 'DITW17.10.05 DIT-770 #185';
        // }
        // field(2014524; "Loyalty Amount"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     Caption = 'Loyalty Amount';
        //     Description = 'DITW17.10.05 DIT-770 #185';
        // }
        // field(2029614; "Recycle Chrg. Attach. Line No."; Integer)
        // {
        //     Caption = 'Recycle Chrg. Attach. Line No.';
        //     Description = 'NRQ 25694';
        //     Editable = false;
        //     TableRelation = "Return Receipt Line"."Line No." where("Document No." = FIELD("Document No."));
        // }
        // field(2034850; "DIT Sub-Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Sub Contract Type',
        //                 FRA = 'Sous type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';
        //     OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA = ' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        // }
        // field(2034872; "Contract Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Contract Group Code',
        //                 FRA = 'Code groupe contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';
        //     TableRelation = IF ("Contract Type" = CONST(Service)) "Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
        //     else IF ("Contract Type" = CONST(Financial)) "Financial Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034915; "Service Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Service Contract No.',
        //                 FRA = 'N° contrat de service';
        //     Description = 'DITW16.00.00.41 DIT-715 #392 - DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Service Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                     "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034920; "Created by Contract Batch Job"; Boolean)
        // {
        //     CaptionML = ENU = 'Created by Contract Batch Job',
        //                 FRA = 'Créé par traîtement périodique du contrat';
        //     Description = 'DITW16.00.00.43 DIT715 #619';
        // }
        // field(2035391; "External Document No."; Code[35])
        // {
        //     CalcFormula = Lookup("Return Receipt Header"."External Document No." where("No." = FIELD("Document No.")));
        //     CaptionML = ENU = 'External Document No.',
        //                 FRA = 'N° document externe';
        //     Description = 'DITW17.00.02 DIT-770 #180';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035392; "Sell-to Customer Name"; Text[50])
        // {
        //     CalcFormula = Lookup("Return Shipment Header"."Pay-to Vendor No." where("No." = FIELD("Document No.")));
        //     CaptionML = ENU = 'Sell-to Customer Name',
        //                 FRA = 'Nom du donneur d''ordre';
        //     Description = 'DITW17.00.02 DIT-770 #180';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035393; "Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Contract Type',
        //                 FRA = 'Type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392 - DITW18.00.06 DIT-770 #1368';
        //     OptionCaptionML = ENU = ' ,Service,Financial',
        //                       FRA = ' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }
        // field(2035394; "Show Item charge on Invoice"; Option)
        // {
        //     Caption = 'Show Item charge on Invoice';
        //     Description = 'DITW110.00.11 NRQ#43605';
        //     OptionCaption = '" ,Under item line,Include in item price,Order total"';
        //     OptionMembers = " ","Under item line","Include in item price","Order total";
        // }
        //BC Upgrade SHARMP16 End>> -------------------- Drink-IT fields
    }
    keys
    {

        //Unsupported feature: PropertyChange on ""Document No.","Line No."(Key)". Please convert manually.

        // key(Key1; "Document No.", "Attached to Line No.", "Is Item Charge")
        // {
        // }
        // key(Key2; "Document No.", "AAD No. Series", "Company Tax Registration No.", "Tariff No.", Type, "No.")
        // {
        // }
        // key(Key3; "Document No.", "ARC No.", "ARC Line No.", "Company Tax Registration No.", "Tariff No.", Type, "No.")
        // {
        // }//BC Upgrade SHARMP16 Begin<< -------------------- Drink-IT fields used in keys
        key(Key50000; "Document No.", "Unit of Measure Code")
        {
            SumIndexFields = Quantity;
        }
        // key(Key5; "Applies-to AAD Trck. Entry No.")
        // {
        // }//BC Upgrade SHARMP16 Begin<< -------------------- Drink-IT fields in keys

    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: EMCSDocLineComments)();
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
    SalesDocLineComments.SETRANGE("Document Type",SalesDocLineComments."Document Type"::"Posted Return Receipt");
    SalesDocLineComments.SETRANGE("No.","Document No.");
    SalesDocLineComments.SETRANGE("Document Line No.","Line No.");
    if not SalesDocLineComments.ISEMPTY then
      SalesDocLineComments.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    // <<DITW15.00.00.38 DDR 05/10/2010
    EMCSDocLineComments.SETRANGE("Table ID",DATABASE::"Return Receipt Line");
    EMCSDocLineComments.SETRANGE("Document Type",0);
    EMCSDocLineComments.SETRANGE("Document No.","Document No.");
    EMCSDocLineComments.SETRANGE("Document Line No.","Line No.");
    if not EMCSDocLineComments.ISEMPTY then
      EMCSDocLineComments.DELETEALL;
    // >>DITW15.00.00.38 DDR
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
    //  EMCSDocLineComments: Record "EMCS Comment Line";

    var
        ItemChargeReturnRcptLine: Record "Return Receipt Line";
        SalesGetReturnRcpt: Codeunit "Sales-Get Return Receipts";


    //Unsupported feature: PropertyModification on "Text000(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Return Receipt No. %1:;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Return Receipt No. %1:;FRA=N° réception retour %1 :;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=The program cannot find this purchase line.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=The program cannot find this purchase line.;FRA=Le programme ne trouve pas cette ligne achat.;
    //Variable type has not been exported.

    var
        SaveCurrency: Record Currency;
        InvtSetup: Record "Inventory Setup";
        // EmcsSetup: Record "EMCS Setup";
        // PackagingType: Record "Packaging Type";
        // LRNDocMgt: Codeunit "LRN Document Mgt.";
        Item: Record Item;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        SaveTransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
        Text2013760: TextConst ENU = 'You cannot modify %1 because it is attached to %2 %3.', FRA = 'Vous ne pouvez pas modifier %1, car il est attaché à %2 %3.';
        Text2014410: TextConst ENU = 'Return Receipt No. %1 %2', FRA = 'N° recéption retour %1 %2';
        Text2014411: TextConst ENU = 'Sell-to Customer No. %1', FRA = 'N° donneur d''ordre %1';
        Text2014412: TextConst ENU = 'Return Order No. %1', FRA = 'N° retour %1';
        Text2014413: TextConst ENU = 'Ext. Doc. No. %1', FRA = 'N° document externe %1';
}

