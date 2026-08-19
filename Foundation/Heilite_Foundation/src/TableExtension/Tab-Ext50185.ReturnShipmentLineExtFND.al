tableextension 50185 ReturnShipmentLineExtFND extends "Return Shipment Line"
{
    //     DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 27/12/2007 Added fields
    //                                  2034647 Drink Tax Group Code
    //                                  2034675 Item Charge Type
    // DITW15.00.00.01 DDR 02/01/2008 rename field
    //                                  2034647 Item DTax Group Code + Filter to the source table
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
    //                                  2013773 Vendor DDisc. Group Code
    //                                  2013774 Item DDisc. Group Code
    //                                  2013775 Vendor DPromo. Group Code
    //                                  2013776 Item DPromo. Group Code
    //                                  2013767 Unit Volume HL
    // DITW15.00.00.01 DDR 28/01/2008 Correct GetReturnShipments into function InsertInvLineFromRetShptLine()
    // DITW15.00.00.01 DDR 15/02/2008 added option into "Item Charge Calculate per"
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
    // DITW15.00.00.24 DDR 07/10/2008 Added fields
    //                                  2013722 Duty Tax Type (flowfield)
    // DITW15.00.00.25 DDR 10/10/2008 Added optionstring 'ShippingCost' for field "Item Charge Type"
    //                                Added new option ",Weight,Cubage,Distance" into field "Extra Charge Type"
    //                                Added fields
    //                                  2014064 Shipping Charge Per
    //                                  2014087 Distance
    //                                  2014079 Weight
    //                                  2014080 Cubage
    //                     21/10/2008 Deleted fields
    //                                  2013722 Duty Tax Type
    //                     24/10/2008 Renamed OptionStringML (VolumeHL -> Volume /Unit) for field "Extra Charge Type"
    // DITW15.00.00.26 DDR 17/11/2008 Added fields
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
    // DITW15.00.00.34 DDR 10/06/2009 added field
    //                                  2013785 Periodic Disc.-Promo Entry No.
    //                     12/06/2009 Added option 'Price Item' optionstring for "Extra Charge Type" field
    // DITW15.00.00.35 DDR 23/06/2009 issue 456 Added flowfilters into function CalcVATAmountLines()
    //                                Added functions CalcVATAmountLinesTemp()
    //                     24/06/2009 issue 669
    //                                Added fields
    //                                  2013824 Gen. Prod. Posting Free Group
    //                                  2013825 Free Item Posting Type
    //                                  2013826 Free Item
    //                                  2013827 Free Calculation Type
    //                                  2013828 Include Free Qty. in Minimum
    //                                Update function InsertInvLineFromRetShptLine()
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
    // DITW15.00.00.36 DDR 21/12/2009 issue 971 Modified function InsertInvLineFromRetShptLine() to include item charges per order
    //                                issue 786 Added fields
    //                                  2013778 Opposite Qty. Sign
    //                                  2013779 Using Qty. (Base)
    //                                  2013780 Free Quantity
    //                                  2013781 Multiple Quantity
    //                                  2013782 Maximum Free Quantity
    // DITW15.00.00.37 DDR 20/01/2010 issue 1020 Added transfer fields for function InsertInvLineFromRetShptLine()
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
    //                                           Added keys
    //                                             'Document No.,LRN No. Series,Company Tax Registration No.,Tariff No.,Type,No.'
    //                                             'ARC No.,Company Tax Registration No.,Tariff No.,Type,No.'
    //                     08/10/2010            Added fields
    //                                             2014287 Cancellation Reason Code
    //                                           Added keys
    //                                             'LRN No.,Company Tax Registration No.,Tariff No.,Type,No.'
    //                     15/10/2010            Modify key
    //                                             [Document Type,Document No.,AAD No. Series,Company Tax Registration No.,
    //                                             Company Tax Warehouse Ref.,Tariff No.,Type,No.]
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
    // DITW15.00.00.39 DDR 11/07/2011 issue 1369
    //                                  Added fields
    //                                    2013731 Applies-to AAD Trck. Entry No.
    //                                  Added keys
    //                                    "Applies-to AAD Trck. Entry No."
    // DITW16.00.00.39 DDR 27/09/2011 DIT-715 #141 Added function IsCalcTotalCollapseLine()
    //                     28/10/2011 issue 1457 Modified many ML captions
    // DITW16.00.00.40 DDR 22/12/2011 DIT-715 issue 187
    //                                  Added fields
    //                                    2014292 Cancellation Reason Comment (flowfield)
    //                                  Added functions ShowLineCancelReasonCmts()
    //                     05/01/2012 DIT-715 #172
    //                                  Added fields
    //                                    2013803 Allow VAT Calculation (Free)
    //                     20/01/2012 DIT-715 #172 Modified workflow (+Rollback)
    // DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392
    //                                Added fields
    //                                  2034850 DIT Sub-Contract Type
    //                                  2034872 Contract Group Code
    //                                  2034915 Service Contract No.
    //                                  2014310 Service Contract Line No.
    //                                  2014311 Service Contract Type
    //                 AHU 31/08/2012 DIT-715 #327 Renamed Captions fields2034915,2034310,2014311
    // DITW16.00.00.42 DDR 08/01/2013 DIT-715 #533 Added transfer EMCS fields for function InsertInvLineFromRetShptLine()
    //                 DDR 27/02/2013 DIT-715 #550 Modified checking on "Packaging Type Code"
    // DITW16.00.00.43 DDR 22/01/2014 DIT-715 #882 Added fields 2014415 Item Charge Qty. per Uom
    // DITW16.00.00.44 DDR 19/03/2014 DIT-715 #910 Added DIT fields
    //                                               2014075 Shipping Agent Code
    //                                               2014076 Shipping Agent Service Code
    // DITW16.00.00.44 DDR 24/03/2014 DIT-715 #912 Added round up field "No. of Packages"

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0014.1
    // DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field "2035391" Added
    // DITW17.00.02 AT  24/09/2013 DIT-770 #132
    //                             Added Field 2013829 Free Reason Code
    // DITW17.00.02 SR 25/09/2013 DIT-770 #142 : New Field "Rounding factor" Added for Deposit Rounding
    // DITW17.00.02 AT  26/09/2013 DIT-770 #149 Merge HIT124
    //                             New flowfelds Document Date and Vendor Shipment No.
    // DITW17.00.02 DDR 13/11/2013 DIT-770 #230 Added fields
    //                                            2013783 DDiscount Level Position
    //                                            2013788 DDiscount Include Tax
    //                                            2013789 DDiscount Include Deposit
    //                                            2013790 DDiscount Include Discount
    // DITW17.00.02 SR  29/11/2013 DIT-770 #183 : New Option added in "Extra Charge Type" field
    // DITW17.00.02 DDR 16/12/2013 DIT-770 #274 Added fields 201
    // DITW17.00.02 SR 19/12/2013 DIT-770 #163 : Remove the "DIT Sub-Contract Type" filter in "Service Contract No." field
    // DITW17.00.02 DDR 23/01/2014 DIT-715 #882-893 Merge
    // DITW17.00.03 DDR 20/03/2014 DIT-715 #910 merge
    // DITW17.00.03 DDR 24/03/2014 DIT-715 #912 Merge
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.03 DDR 18/06/2014 DIT-770 #327 (next DIT-770 #183) Added fields
    //                                             2014504 Calculate Minimum
    //                                             2014505 Recurring Min. Quantity
    //                                             2014506 Splitting Per
    // DITW17.10.05 MSF 17/07/2014 DIT-770 #698 (Customer)Vendor suspended tax determined per document line + internal
    //                                          Added field 2013666 Customer DTax Group Code
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05 WSA 05/11/2014 DIT-770 #185 Added fields 2014518..2014522
    // DITW17.00.05 YHE 06/11/2014 DIT-770 #961 Added field ID.2014440-"Approved Dimension set ID" + Added code fill "Approved Dimension set ID"
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 DDR 15/04/2015 DIT-770 #1329 EMCS Add license permissions
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
    // DITW19.00.07 MVN 30/12/2015 DIT-770 #001 Upgrade Set Global GetPurchCrMemoLines
    // DITW18.00.07 VSC 22/02/2016 DIT-770 #1703 Added field "Original Quantity"
    // DITW18.00.07 DDR 10/03/2016 DIT-770 #1844 (link DIT-770 #235) Added copy fields "Order No.","Order Line No."
    // DITW18.00.07 AKH 29/04/2016 DIT-770 #1346 Added fields 2014088 "Item Delivery Type"
    //                                                        2014089 "Delivery Time (sec.)"
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW18.00.07A DDR 29/07/2016 DIT-770 #2131 Modified to save original discount quantity
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields
    //                                                        2013716 Strength Spec. Code
    //                                                        2013717 Strength Spec. Value
    //                                                        2013718 Vol-Strength Spec. Code
    //                                                        2013719 Vol-Strength Spec. Value
    // DITW19.00.08 DDR 17/10/2016 BL#10443 Modified function GetTaxSpecCaption()
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Bugfix function GetTaxSpecCaption()
    //                                      Removed fields
    //                                        2013717 Strength Spec. Value
    //                                        2013719 Vol-Strength Spec. Value
    // DITW19.00.08 AKH 02/11/2016 BL#10820 (DIT-770 #1713) Get "Item Charge Value" from order line

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.09 DDR 13/04/2017 NRQ#13107 Fix 'CalcFormula' property of field2014292
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 YHE 28/06/2017 NRQ#14724 Extend DIT field "Vendor Shipment No." from Code20 to Code35
    // DITW110.00.11 SFI 30/08/2017 BL#14417 New field
    //                                         2013637 Deposit Value

    // HEI.01 HLSRM02 IBM LAZARE02 27.07.2017
    //   #New fields for SRM integration

    // HEI.02 FDD-PURGAPINT002 IBM LAZARE02 25.09.2017
    //   # New fields "Maximo Requisition No.", "Maximo Requisition Line No."
    // HEI.03 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field created: 50032 - "Gate Entry No."
    // HEI.05 CHG0257267 IBM.AB 16.01.2019
    //   # Field length for Prod. BOM Version Code is increased from 10 to 20
    // DITW113.00.15 DDR 04/10/2019 NRQ#10495 Rename Loyalty 'Cost' -> 'Amount' (all fields)
    //                                        Rename/Renumber fields
    //                                          2014518 -> 2014523 Loyalty Amount (LCY)
    //                                          2014519 -> 2014524 Loyalty Amount
    // DITW113.00.15 DDR 16/10/2019 NRQ#120300 Add field 2014510 Loyalty-Created
    // DITW110.00.11 MSF 20/12/2017 NRQ#14143  New Option Added to Field   2014504 Calculate Minimum
    //                                                                             Minimum Quantity
    // CHG2104608: DITW111.00.13 ISL 18/12/2018 NRQ#96024 Deleted field 2014461 "Prod. BOM Version Code"
    // HEI.06 HT2140 - CHG2105034 IBM NANDIS01 29.04.2021 - Brasco Congo: HT2140 - License Code Process Flow
    //   # New Field added - License COde(ID -50050) - Code - 20 - Flowfield
    // HEI.07 FDD-HT2159 - CHG2105031 IBM NASTAA02 16.08.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field created: 50051 - CAD Amount
    // HEI.08 CHG2217161 SAHAL01 02.11.2023 SPL for Returns and GR cancellations
    //   # Created New Fields: 50057 - SPL Code
    //                         50058 - SPL Name
    //                         50059 - Consumption SPL Code
    // HEI.09 CHG2224401 HB3624 YADAVM09 02.02.2024 Health and Security Levy Tax
    //  #New Function created #OnBeforeInsertShipmentForLevyTax
    // HEI.10 CHG2210794 SAHAL01 10.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Created New Fields: 50075 - Zycus Order No.
    //                         50076 - Zycus Order Line No.
    //                         50085 - Zycus Movement Type

    //     HEI.01 HLSRM02 IBM LAZARE02 27.07.2017
    //   #New fields for SRM integration
    //     HEI.02 FDD-PURGAPINT002 IBM LAZARE02 25.09.2017
    //   # New fields "Maximo Requisition No.", "Maximo Requisition Line No."
    // HEI.10 CHG2210794 SAHAL01 10.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Created New Fields: 50075 - Zycus Order No.
    //                         50076 - Zycus Order Line No.
    //                         50085 - Zycus Movement Type


    //BC Upgrade SHARMP16---- Interface related fields shifted from main ext table.

    fields
    {
        modify("Buy-from Vendor No.")
        {
            CaptionML = ENU = 'Buy-from Vendor No.', FRA = 'N° fournisseur';
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
            // OptionCaptionML = ENU = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)', FRA = ' ,Compte général,Article,,Immobilisation,Frais annexes';
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
        modify("Direct Unit Cost")
        {
            CaptionML = ENU = 'Direct Unit Cost', FRA = 'Coût unitaire direct';

            //Unsupported feature: Change AutoFormatExpr on ""Direct Unit Cost"(Field 22)". Please convert manually.


            //Unsupported feature: Change Description on ""Direct Unit Cost"(Field 22)". Please convert manually.

            //  CaptionClass = GetCaptionClass(FIELDNO("Direct Unit Cost"));
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
        modify("Unit Price (LCY)")
        {
            CaptionML = ENU = 'Unit Price (LCY)', FRA = 'Prix unitaire DS';

            //Unsupported feature: Change Description on ""Unit Price (LCY)"(Field 31)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Unit Price (LCY)"(Field 31)". Please convert manually.

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
        modify("Item Shpt. Entry No.")
        {
            CaptionML = ENU = 'Item Shpt. Entry No.', FRA = 'N° séquence expéd. article';
        }
        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Job No.")
        {
            CaptionML = ENU = 'Job No.', FRA = 'N° projet';
        }
        modify("Indirect Cost %")
        {
            CaptionML = ENU = 'Indirect Cost %', FRA = '% coût indirect';
        }
        modify("Quantity Invoiced")
        {
            CaptionML = ENU = 'Quantity Invoiced', FRA = 'Quantité facturée';
        }
        modify("Pay-to Vendor No.")
        {
            CaptionML = ENU = 'Pay-to Vendor No.', FRA = 'N° fournisseur à payer';
        }
        modify("Vendor Item No.")
        {
            CaptionML = ENU = 'Vendor Item No.', FRA = 'Référence fournisseur';
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
        modify("Entry Point")
        {
            CaptionML = ENU = 'Entry Point', FRA = 'Pays provenance';
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
        modify("Use Tax")
        {
            CaptionML = ENU = 'Use Tax', FRA = 'Use Tax';
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
        modify("Job Task No.")
        {
            CaptionML = ENU = 'Job Task No.', FRA = 'N° tâche projet';
        }
        modify("Prod. Order No.")
        {
            CaptionML = ENU = 'Prod. Order No.', FRA = 'N° ordre de fabrication';
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
        modify("FA Posting Type")
        {
            CaptionML = ENU = 'FA Posting Type', FRA = 'Type compta. immo.';
            // OptionCaptionML = ENU = ' ,Acquisition Cost,Maintenance', FRA = ' ,Coût acquisition,Maintenance';
        }
        modify("Depreciation Book Code")
        {
            CaptionML = ENU = 'Depreciation Book Code', FRA = 'Code loi d''amortissement';
        }
        modify("Salvage Value")
        {
            CaptionML = ENU = 'Salvage Value', FRA = 'Valeur résiduelle';
        }
        modify("Depr. until FA Posting Date")
        {
            CaptionML = ENU = 'Depr. until FA Posting Date', FRA = 'Amort. jusqu''à date compta.';
        }
        modify("Depr. Acquisition Cost")
        {
            CaptionML = ENU = 'Depr. Acquisition Cost', FRA = 'Amortir coût acquisition';
        }
        modify("Maintenance Code")
        {
            CaptionML = ENU = 'Maintenance Code', FRA = 'Code maintenance';
        }
        modify("Insurance No.")
        {
            CaptionML = ENU = 'Insurance No.', FRA = 'N° assurance';
        }
        modify("Budgeted FA No.")
        {
            CaptionML = ENU = 'Budgeted FA No.', FRA = 'N° immo. budgétée';
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
        // modify("Cross-Reference No.")
        // {
        //     CaptionML = ENU = 'Cross-Reference No.', FRA = 'Référence externe';
        // }//BC Upgarde SHARMP16 -- fields N/A in BC but Available in NAV functional Query
        // modify("Unit of Measure (Cross Ref.)")
        // {
        //     CaptionML = ENU = 'Unit of Measure (Cross Ref.)', FRA = 'Unité référence externe';
        // }//BC Upgarde SHARMP16 -- fields N/A in BC but Available in NAV functional Query
        // modify("Cross-Reference Type")
        // {
        //     CaptionML = ENU = 'Cross-Reference Type', FRA = 'Type référence externe';
        //     OptionCaptionML = ENU = ' ,Customer,Vendor,Bar Code', FRA = ' ,Client,Fournisseur,Code barre';
        // }//BC Upgarde SHARMP16 -- fields N/A in BC but Available in NAV functional Query
        // modify("Cross-Reference Type No.")
        // {
        //     CaptionML = ENU = 'Cross-Reference Type No.', FRA = 'N° type référence externe';
        // }//BC Upgarde SHARMP16 -- fields N/A in BC but Available in NAV functional Query
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
        // }//BC Upgarde SHARMP16 -- fields N/A in BC but Available in NAV functional Query
        modify("Return Qty. Shipped Not Invd.")
        {
            CaptionML = ENU = 'Return Qty. Shipped Not Invd.', FRA = 'Qté ret. expédiée non facturée';
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
        //BC Upgrade SHARMP16 BEGIN>> --- field shifted to Interface Ext.
        // field(50000; "SRM Contract No."; Code[10])
        // {
        //     Caption = 'SRM Contract No.';
        //     Description = 'HEI.01';
        //     Editable = false;
        // }
        // field(50001; "SRM Contract Line No."; Code[10])
        // {
        //     Caption = 'SRM Contract Line No.';
        //     Description = 'HEI.01';
        //     Editable = false;
        // }
        // field(50002; "SRM Contract Type"; Code[10])
        // {
        //     CalcFormula = Lookup("Purch. Rcpt. Header"."SRM Contract Type" where("No." = FIELD("Document No.")));
        //     Caption = 'SRM Contract Type';
        //     Description = 'HEI.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        //BC Upgrade SHARMP16 BEGIN<< --- field shifted to Interface Ext.
        field(50003; "Valid From FND"; Date)
        {
            CalcFormula = Lookup("Purch. Rcpt. Header"."Valid From FND" where("No." = FIELD("Document No.")));
            Caption = 'Valid From';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Valid To FND"; Date)
        {
            CalcFormula = Lookup("Purch. Rcpt. Header"."Valid To FND" where("No." = FIELD("Document No.")));
            Caption = 'Valid To';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Type ID FND"; Code[10])
        {
            Caption = 'Type ID';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50006; "CMG Code FND"; Code[20])
        {
            Caption = 'CMG Code';
            Description = 'HEI.01';
        }
        field(50007; "Block Line Ordering FND"; Option)
        {
            Caption = 'Block Line Ordering';
            Description = 'HEI.01';
            Editable = false;
            OptionCaption = '" ,B,F"';
            OptionMembers = " ",B,F;
        }
        field(50008; "Delivery Finalized FND"; Boolean)
        {
            Caption = 'Delivery Finalized';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50009; "Tolerance Received Over % FND"; Decimal)
        {
            Caption = 'Tolerance Received Over %';
            DecimalPlaces = 2 : 5;
            Description = 'HEI.01';
            Editable = false;
        }
        field(50010; "Tolerance Received Under % FND"; Decimal)
        {
            Caption = 'Tolerance Received Under %';
            DecimalPlaces = 2 : 5;
            Description = 'HEI.01';
            Editable = false;
        }
        field(50011; "Consumption Location Code FND"; Code[10])
        {
            Caption = 'Consumption Location Code';
            Description = 'HEI.01';
            TableRelation = Location;
        }
        field(50012; "Initial Quantity FND"; Decimal)
        {
            Caption = 'Initial Quantity';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.01';
            Editable = false;
        }
        field(50013; "Cancelled FND"; Boolean)
        {
            Caption = 'Cancelled';
            Description = 'HEI.01';
        }
        //BC Upgrade SHARMP16 BEGIN>> --- field shifted to Interface Ext.
        // field(50014; "SRM Order No."; Code[10])
        // {
        //     Caption = 'SRM Order No.';
        //     Description = 'HEI.01';
        //     Editable = false;
        // }
        // field(50015; "SRM Order Line No."; Code[10])
        // {
        //     Caption = 'SRM Order Line No.';
        //     Description = 'HEI.01';
        //     Editable = false;
        // }
        //BC Upgrade SHARMP16 BEGIN<< --- field shifted to Interface Ext.
        field(50020; "Target Value Currency FND"; Code[10])
        {
            Caption = 'Target Value Currency';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = Currency;
        }
        field(50021; "Target Value Amount FND"; Decimal)
        {
            Caption = 'Target Value Amount';
            Description = 'HEI.01';
            Editable = false;
        }
        //BC Upgrade SHARMP16 BEGIN>> --- field shifted to Interface Ext.
        // field(50030; "Maximo Requisition No."; Code[20])
        // {
        //     Caption = 'Maximo Requisition No.';
        //     Description = 'HEI.02';
        //     Editable = false;
        // }
        // field(50031; "Maximo Requisition Line No."; Integer)
        // {
        //     Caption = 'Maximo Requisition Line No.';
        //     Description = 'HEI.02';
        //     Editable = false;
        // }
        //BC Upgrade SHARMP16 BEGIN<< --- field shifted to Interface Ext.
        field(50032; "Gate Entry No. FND"; Code[20])
        {
            Caption = 'Gate Entry No.';
            Description = 'HEI.03';
            Editable = false;
            TableRelation = "Gate Entry Header FND";
        }
        field(50050; "License Code FND"; Code[20])
        {
            Caption = 'License Code';
            CalcFormula = Lookup("Purchase Header Additional FND"."License Code" where("Document Type" = CONST("Return Order"),
                                                                                    "No." = FIELD("Return Order No.")));
            Description = 'HEI.06';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50051; "CAD Amount FND"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'CAD Amount',
                        FRA = 'CAD Montant';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
            Editable = false;
        }
        field(50057; "SPL Code FND"; Code[20])
        {
            Caption = 'SPL Code';
            Description = 'HEI.08';
            Editable = false;
            TableRelation = "Vendor SPL Relation FND"."SPL Code" where("Vendor No." = FIELD("Buy-from Vendor No."),
                                                                    Blocked = CONST(false));

            trigger OnValidate();
            var
                VendorSPL: Record "Vendor SPL Relation FND";
            begin
            end;
        }
        field(50058; "SPL Name FND"; Text[50])
        {
            Caption = 'SPL Name';
            Description = 'HEI.08';
            Editable = false;
        }
        field(50059; "Consumption SPL Code FND"; Code[20])
        {
            Caption = 'Consumption SPL Code';
            Description = 'HEI.08';
            Editable = false;
            TableRelation = "Vendor SPL Relation FND"."SPL Code" where("Vendor No." = FIELD("Buy-from Vendor No."),
                                                                    Blocked = CONST(false));
        }

        field(50000; "SRM Contract No. FND"; Code[10])
        {
            Caption = 'SRM Contract No.';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50001; "SRM Contract Line No. FND"; Code[10])
        {
            Caption = 'SRM Contract Line No.';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50002; "SRM Contract Type FND"; Code[10])
        {
            CalcFormula = Lookup("Purch. Rcpt. Header"."SRM Contract Type FND" WHERE("No." = FIELD("Document No.")));
            Caption = 'SRM Contract Type';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50014; "SRM Order No. FND"; Code[10])
        {
            Caption = 'SRM Order No.';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50015; "SRM Order Line No. FND"; Code[10])
        {
            Caption = 'SRM Order Line No.';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50030; "Maximo Requisition No. FND"; Code[20])
        {
            Caption = 'Maximo Requisition No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50031; "Maximo Requisition LineNo. FND"; Integer)
        {
            Caption = 'Maximo Requisition Line No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50075; "Zycus Order No. FND"; Code[20])
        {
            Caption = 'Zycus Order No.';
            Description = 'HEI.10';
            Editable = false;
        }
        field(50076; "Zycus Order Line No. FND"; Integer)
        {
            Caption = 'Zycus Order Line No.';
            Description = 'HEI.10';
            Editable = false;
        }
        field(50085; "Zycus Movement Type FND"; Integer)
        {
            Caption = 'Zycus Movement Type';
            Description = 'HEI.10';
            Editable = false;
        }
        //BC Upgrade SHARMP16 BEGIN>> --- field shifted to Interface Ext.
        // field(50075; "Zycus Order No."; Code[20])
        // {
        //     Caption = 'Zycus Order No.';
        //     Description = 'HEI.10';
        //     Editable = false;
        // }
        // field(50076; "Zycus Order Line No."; Integer)
        // {
        //     Caption = 'Zycus Order Line No.';
        //     Description = 'HEI.10';
        //     Editable = false;
        // }
        // field(50085; "Zycus Movement Type"; Integer)
        // {
        //     Caption = 'Zycus Movement Type';
        //     Description = 'HEI.10';
        //     Editable = false;
        // }
        //BC Upgrade SHARMP16 BEGIN<< --- field shifted to Interface Ext.
        //BC UpgradeSHARMP16 begin>>-- Drink-IT field
        // field(2013610;"Item DDeposit Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Deposit Group Code',
        //                 FRA='Code groupe consigne article';
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
        // field(2013615;"Rounding factor";Option)
        // {
        //     CaptionML = ENU='Rounding factor',
        //                 FRA='Unité d''affichage';
        //     Description = 'DITW17.00.02 DIT-770 #142';
        //     Editable = false;
        //     OptionCaptionML = ENU='Nearest,Up,Down',
        //                       FRA='Au plus près,Par excès,Par défaut';
        //     OptionMembers = Nearest,Up,Down;
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
        //     Description = 'VC8-DITW15.00.00.01-.34';
        //     OptionCaptionML = ENU=' ,Amount,Price %,Amount %,Fixed Amount,Volume /Unit,Weight,Cubage,Distance,Purchase Price,Unit of measure',
        //                       FRA=' ,Montant,Prix %,Montant %,Montant Fixe,Volume /Unit,Poids,Cubage,Distance,Prix achat,Unit of measure';
        //     OptionMembers = " ",Amount,"Price %","Amount %","Fixed Amount",VolumeHL,Weight,Cubage,Distance,"Price Item","Unit of Measure";
        // }
        // field(2013661;"Item Charge Value";Decimal)
        // {
        //     AutoFormatExpression = GetAutoformatRoundingType(GetCurrencyCode);
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
        // field(2013663;"ItemCharge Incl. Price";Boolean)
        // {
        //     CaptionML = ENU='Item Charge Incl. Price',
        //                 FRA='Frais annexe inclus prix';
        //     Description = 'VC8-DITW15.00.00.01';
        // }
        // field(2013664;"Item Charge Discount %";Decimal)
        // {
        //     CaptionML = ENU='Item Charge Discount %',
        //                 FRA='Remise frais annexes %';
        //     Description = 'VC8-DITW15.00.00.01';
        // }
        // field(2013665;"Allow Item Charge Line Disc.";Boolean)
        // {
        //     CaptionML = ENU='Allow Item Charge Line Discount',
        //                 FRA='Frais annexes remise ligne autorisé';
        //     Description = 'VC8-DITW15.00.00.01';
        //     InitValue = true;
        // }
        // field(2013666;"Vendor DTax Group Code";Code[10])
        // {
        //     CaptionML = ENU='Vendor Tax Group Code',
        //                 FRA='Code groupe taxe fournisseur';
        //     Description = 'DITW17.10.05 DIT-770 698';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Vendor));
        // }
        // field(2013667;"Item DTax Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Tax Group Code',
        //                 FRA='Code groupe taxe article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Item));
        // }
        // field(2013695;"Item Charge Type";Option)
        // {
        //     CaptionML = ENU='Item Charge Type',
        //                 FRA='Type frais annexes';
        //     Description = 'DITW15.00.00.01';
        //     OptionCaptionML = ENU=' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA=' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        // }
        // field(2013696;"Location Group Code";Code[10])
        // {
        //     CaptionML = ENU='Location Tax Group Code',
        //                 FRA='Code groupe magasin taxe';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Location Group";
        // }
        // field(2013708;"Due Tax";Boolean)
        // {
        //     CaptionML = ENU='Due Tax',
        //                 FRA='Taxe due';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013715;"Tax Formula";Code[80])
        // {
        //     CaptionML = ENU='Tax Formula',
        //                 FRA='Formule taxe';
        //     Description = 'DITW15.00.00.3&';
        // }
        // field(2013716;"Strength Spec. Code";Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0,FIELDNO("Strength Spec. Code"));
        //     CaptionML = ENU='Strength Spec. Code',
        //                 FRA='Code contrainte spécification taxe';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" WHERE (Type=CONST(Specification));
        // }
        // field(2013718;"Vol-Strength Spec. Code";Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0,FIELDNO("Vol-Strength Spec. Code"));
        //     CaptionML = ENU='Vol-Strength Spec. Code',
        //                 FRA='Code spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" WHERE (Type=CONST(Specification));
        // }
        // field(2013722;"Duty Suspended";Boolean)
        // {
        //     CaptionML = ENU='Duty Suspended',
        //                 FRA='Taxe en suspension';
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013726;"Company Tax Registration No.";Text[20])
        // {
        //     CaptionML = ENU='Company Tax Registration No.',
        //                 FRA='N° identif. accise société';
        //     Description = 'DITW15.00.00.28';
        // }
        // field(2013727;"AAD No. Series";Code[10])
        // {
        //     CaptionML = ENU='AAD No. Series',
        //                 FRA='Souches de n° DAA';
        //     Description = 'DITW15.00.00.28';
        //     TableRelation = "No. Series";
        // }
        // field(2013728;"AAD No.";Code[20])
        // {
        //     CaptionML = ENU='AAD No.',
        //                 FRA='N° DAA';
        //     Description = 'DITW15.00.00.28';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //         if CurrFieldNo = FIELDNO("AAD No.") then
        //           TESTFIELD("Applies-to AAD Trck. Entry No.",0);
        //         // >>DITW15.00.00.39 DDR #1369
        //     end;
        // }
        // field(2013729;"Tariff No.";Code[10])
        // {
        //     CaptionML = ENU='Tariff No.',
        //                 FRA='Nomenclature produits';
        //     Description = 'DITW15.00.00.28';
        //     TableRelation = "Tariff Number";
        // }
        // field(2013731;"Applies-to AAD Trck. Entry No.";Integer)
        // {
        //     CaptionML = ENU='Applies-to Correction AAD Trck. Entry No.',
        //                 FRA='N° Ecriture correction suivi DAA lettrage';
        //     Description = 'DITW15.00.00.39 #1369';
        //     TableRelation = "AAD Tracking Entry"."Entry No." WHERE ("Entry Type"=CONST(Outbound),
        //                                                             "Source Type"=CONST(Vendor),
        //                                                             "Source No."=FIELD("Buy-from Vendor No."));

        //     trigger OnValidate();
        //     var
        //         AADTrackingEntry : Record "AAD Tracking Entry";
        //     begin
        //         TESTFIELD(Type,Type::Item);
        //         if "Applies-to AAD Trck. Entry No." <> 0 then begin
        //           TESTFIELD("LRN No.",'');
        //           AADTrackingEntry.GET("Applies-to AAD Trck. Entry No.");
        //           "AAD No." := AADTrackingEntry."AAD No.";
        //           "ARC No." := AADTrackingEntry."ARC No.";
        //         end;
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
        // }
        // field(2013773;"Vendor DDisc. Group Code";Code[10])
        // {
        //     CaptionML = ENU='Vendor Discount Group',
        //                 FRA='Groupe remise fournisseur';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Discount Group".Code WHERE ("Source Type"=CONST(Vendor));
        // }
        // field(2013774;"Item DDisc. Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Discount Group',
        //                 FRA='Groupe remise article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Discount Group".Code WHERE ("Source Type"=CONST(Item));
        // }
        // field(2013775;"Vendor DPromo. Group Code";Code[10])
        // {
        //     CaptionML = ENU='Vendor Promotion Group',
        //                 FRA='Groupe promotion fournisseur';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Promotion Group".Code WHERE ("Source Type"=CONST(Vendor));
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
        //     OptionCaptionML = ENU='Item,Order,Period',
        //                       FRA='Article,Commande,Périodique';
        //     OptionMembers = Item,"Order",Period;
        // }
        // field(2013778;"Opposite Qty. Sign";Boolean)
        // {
        //     CaptionML = ENU='Opposite Qty. Sign',
        //                 FRA='Signe quantité opposé';
        //     Description = 'DITW15.00.00.36';
        // }
        // field(2013779;"Using Qty. (Base)";Boolean)
        // {
        //     CaptionML = ENU='Using Qty. (Base)',
        //                 FRA='Utilisation quantité (Base)';
        //     Description = 'DITW15.00.00.36';
        // }
        // field(2013780;"Free Quantity";Decimal)
        // {
        //     CaptionML = ENU='Free Quantity',
        //                 FRA='Quantité gratuite';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.36';
        //     MinValue = 0;
        // }
        // field(2013781;"Multiple Quantity";Decimal)
        // {
        //     CaptionML = ENU='Multiple Quantity',
        //                 FRA='Quantité multiple';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.36';
        //     MinValue = 0;
        // }
        // field(2013782;"Maximum Free Quantity";Decimal)
        // {
        //     CaptionML = ENU='Maximum Free Quantity',
        //                 FRA='Quantité maximum gratuite';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.36';
        //     MinValue = 0;
        // }
        // field(2013783;"DDiscount Level Position";Integer)
        // {
        //     CaptionML = ENU='Discount Level Position',
        //                 FRA='Position niveau de remise';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013784;"DDiscount Base Amount";Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCode;
        //     AutoFormatType = 1;
        //     CaptionML = ENU='DDiscount Base Amount',
        //                 FRA='Montant base remise';
        //     Description = 'DITW17.00.02 DIT-770 #274';
        // }
        // field(2013785;"Periodic Disc.-Promo Entry No.";Integer)
        // {
        //     CaptionML = ENU='Periodic Disc.-Promo Entry No.',
        //                 FRA='N° écriture Remise-Promotion périodique';
        //     Description = 'DITW15.00.00.34';
        //     TableRelation = "Sales Discount.-Promo. Entry"."Entry No.";
        // }
        // field(2013788;"DDiscount Include Tax";Boolean)
        // {
        //     CaptionML = ENU='Discount Include Tax',
        //                 FRA='Remise inculant taxe';
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
        // field(2013797;"Disc.Promo. Order Calculated";Boolean)
        // {
        //     CaptionML = ENU='Disc.Promo. Order Calculated',
        //                 FRA='Remise-Promotion cmde. calculé';
        //     Description = 'DITW15.00.00.37';
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
        // field(2013826;"Free Item";Boolean)
        // {
        //     CaptionML = ENU='Free Item',
        //                 FRA='Article gratuit';
        //     Description = 'DITW15.00.00.35';
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
        // field(2014064;"Shipping Charge Per";Option)
        // {
        //     CaptionML = ENU='Shipping Charge Per',
        //                 FRA='Frais transport par';
        //     Description = 'DITW15.00.00.25';
        //     OptionCaptionML = ENU='Shipment,Weight,Volume',
        //                       FRA='Expédition,Poids,Volume';
        //     OptionMembers = Shipment,Weight,Volume;
        // }
        // field(2014065;"Original Quantity";Decimal)
        // {
        //     CaptionML = ENU='Original Quantity',
        //                 FRA='Quantité initiale';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW18.00.07 DIT-770 #1703';
        //     MaxValue = 100;
        //     MinValue = 0;
        // }
        // field(2014075;"Shipping Agent Code";Code[10])
        // {
        //     CaptionML = ENU='Shipping Agent Code',
        //                 FRA='Code transporteur';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     TableRelation = "Shipping Agent";
        // }
        // field(2014076;"Shipping Agent Service Code";Code[10])
        // {
        //     CaptionML = ENU='Shipping Agent Service Code',
        //                 FRA='Code prestation transporteur';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     TableRelation = "Shipping Agent Services".Code WHERE ("Shipping Agent Code"=FIELD("Shipping Agent Code"));
        // }
        // field(2014077;"Truck Code";Code[10])
        // {
        //     CaptionML = ENU='Truck Code',
        //                 FRA='Code camion';
        //     Description = 'DITW15.00.00.26';
        //     TableRelation = "Whse. Shipping Truck";
        // }
        // field(2014078;"Driver Code";Code[10])
        // {
        //     CaptionML = ENU='Driver Code',
        //                 FRA='Code chauffeur';
        //     Description = 'DITW15.00.00.26';
        //     TableRelation = "Whse. Shipping Driver";
        // }
        // field(2014079;Cubage;Decimal)
        // {
        //     CaptionML = ENU='Volume (Cubage)',
        //                 FRA='Volume (cubage)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.25';
        // }
        // field(2014080;Weight;Decimal)
        // {
        //     CaptionML = ENU='Weight',
        //                 FRA='Poids';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.25';
        // }
        // field(2014087;Distance;Decimal)
        // {
        //     CaptionML = ENU='Distance',
        //                 FRA='Distance';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.25';
        //     MinValue = 0;
        // }
        // field(2014088;"Item Delivery Type";Code[10])
        // {
        //     CaptionML = ENU='Item Delivery Type',
        //                 FRA='Type de Livraison Article';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     TableRelation = "Delivery Type".Code WHERE (Type=CONST(Item));
        // }
        // field(2014089;"Delivery Time (sec.)";Decimal)
        // {
        //     CaptionML = ENU='Delivery Time (sec.)',
        //                 FRA='Temps de Livraison (Sec.)';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     MinValue = 0;
        // }
        // field(2014094;"Physical Location Group Code";Code[10])
        // {
        //     CaptionML = ENU='Physical Location Group Code',
        //                 FRA='Code groupe magasin réel';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014113;"Tax Item No.";Code[20])
        // {
        //     CaptionML = ENU='Tax Tracking Item No.',
        //                 FRA='N° article traçable Taxe';
        //     Description = 'DITW15.00.00.38 #703';
        //     TableRelation = Item;
        // }
        // field(2014260;"LRN No. Series";Code[10])
        // {
        //     CaptionML = ENU='LRN No. Series',
        //                 FRA='Souches de n° LRN';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "No. Series";
        // }
        // field(2014261;"LRN No.";Code[20])
        // {
        //     CaptionML = ENU='LRN No.',
        //                 FRA='N° LRN';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014262;"ARC No.";Code[30])
        // {
        //     CaptionML = ENU='ARC No.',
        //                 FRA='N° ARC';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //         if CurrFieldNo = FIELDNO("ARC No.") then
        //           TESTFIELD("Applies-to AAD Trck. Entry No.",0);
        //         // >>DITW15.00.00.39 DDR #1369
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
        // }
        // field(2014271;"Company Tax Warehouse Ref.";Text[20])
        // {
        //     CaptionML = ENU='Company Tax Warehouse Reference',
        //                 FRA='Entrepôt fiscal de référence société';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014287;"Cancellation Reason Type";Option)
        // {
        //     CaptionML = ENU='Cancellation Reason Type',
        //                 FRA='Type motif d''annulation';
        //     Description = 'DITW15.00.00.38 #1217';
        //     OptionCaptionML = ENU=' ,Typing Error,Commercial Transaction Interrupt,Duplicate eAAD,State conflict',
        //                       FRA=' ,Erreur de frappe,Interruption transaction commerciale,Double eAAD,Conflit administration';
        //     OptionMembers = " ",TypingError,TransactInterrupt,DuplicAAD,StateConflict;

        //     trigger OnValidate();
        //     var
        //         EMCS810OutMgt : Codeunit "EMCS EDI-IE810 Outbox";
        //     begin
        //         // <<DITW15.00.00.38 DDR 08/10/2010
        //         TESTFIELD("ARC No. Mandatory",true);
        //         TESTFIELD("ARC No.");

        //         if xRec."Cancellation Reason Type" <> "Cancellation Reason Type" then begin
        //           EMCS810OutMgt.TestDocumentOutbox(
        //             DATABASE::"Return Shipment Line","Document No.","ARC No.",true);

        //           ReturnShptLine.RESET;
        //           ReturnShptLine.SETRANGE("Document No.","Document No.");
        //           ReturnShptLine.SETFILTER("Line No.",'<>%1',"Line No.");
        //           ReturnShptLine.SETRANGE("ARC No.","ARC No.");
        //           // <<DITW18.00.06 DDR 15/04/2015 DIT-770 #1329
        //           if not ReturnShptLine.ISEMPTY then
        //           // >>DITW18.00.06 DDR DIT-770 #1329
        //             ReturnShptLine.MODIFYALL("Cancellation Reason Type","Cancellation Reason Type");
        //         end;
        //     end;
        // }
        // field(2014292;"Cancellation Reason Comment";Boolean)
        // {
        //     CalcFormula = Exist("EMCS Comment Line" WHERE ("Table ID"=CONST(6651),
        //                                                    "Document Type"=CONST(0),
        //                                                    "Document No."=FIELD("Document No."),
        //                                                    "Document Line No."=FIELD("Line No."),
        //                                                    "Field ID"=CONST(2014287)));
        //     CaptionML = ENU='Cancellation Reason Comment',
        //                 FRA='Commentaire motif d''annulation';
        //     Description = 'DITW16.00.00.40 DIT715 #187';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014310;"Service Contract Line No.";Integer)
        // {
        //     CaptionML = ENU='Contract Line No.',
        //                 FRA='N° ligne contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';
        // }
        // field(2014313;"Financial Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Financial Contract No.',
        //                 FRA='N° Contrat Financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Financial Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                       "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
        // }
        // field(2014410;Collapse;Boolean)
        // {
        //     CaptionML = ENU='Collapse',
        //                 FRA='Réduire';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2014415;"Item Charge Qty. per Uom";Decimal)
        // {
        //     CaptionML = ENU='Item Charge Qty. per Unit of Measure',
        //                 FRA='Qté frais annexe par unité de mesure';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW16.00.00.43 DIT-715 #882';
        //     InitValue = 1;
        // }
        // field(2014430;Amount;Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCode;
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Amount',
        //                 FRA='Montant';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        // }
        // field(2014431;"Amount Including VAT";Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCode;
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Amount Including VAT',
        //                 FRA='Montant TTC';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        // }
        // field(2014432;"Line Discount Amount";Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCode;
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Line Discount Amount',
        //                 FRA='Montant remise ligne';
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014433;"Inv. Discount Amount";Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCode;
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Inv. Discount Amount',
        //                 FRA='Montant remise facture';
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014434;"Line Amount";Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCode;
        //     AutoFormatType = 1;
        //     CaptionClass = GetCaptionClass(FIELDNO("Line Amount"));
        //     CaptionML = ENU='Line Amount',
        //                 FRA='Montant ligne';
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014435;"VAT Difference";Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCode;
        //     AutoFormatType = 1;
        //     CaptionML = ENU='VAT Difference',
        //                 FRA='Différence TVA';
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014436;"VAT Identifier";Code[10])
        // {
        //     CaptionML = ENU='VAT Identifier',
        //                 FRA='Identifiant TVA';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        // }
        // field(2014437;"Prepayment Line";Boolean)
        // {
        //     CaptionML = ENU='Prepayment Line',
        //                 FRA='Ligne acompte';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        // }
        // field(2014440;"Approved Dimension set ID";Integer)
        // {
        //     CaptionML = ENU='Approved Dimension set ID',
        //                 FRA='ID ensemble de dimensions approuvé';
        //     Description = 'DITW17.00.05 DIT-770 #961';
        // }
        // field(2014444;"Last Price Calculated Date";Date)
        // {
        //     CaptionML = ENU='Last Price Calculated Date',
        //                 FRA='Dernière date prix calculé';
        //     Description = 'DITW15.00.00.31';
        // }
        // field(2014448;"Document Date";Date)
        // {
        //     CalcFormula = Lookup("Return Shipment Header"."Document Date" WHERE ("No."=FIELD("Document No.")));
        //     CaptionML = ENU='Document Date',
        //                 FRA='Date document';
        //     Description = 'DITW17.00.02 DIT-770 #149';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014449;"Vendor Shipment No.";Code[35])
        // {
        //     CalcFormula = Lookup("Return Shipment Header"."No." WHERE ("No."=FIELD("Document No.")));
        //     CaptionML = ENU='Vendor Shipment No.',
        //                 FRA='N° B.L. fournisseur';
        //     Description = 'DITW17.00.02 DIT-770 #149 - DITW110.00.10 NRQ#14724';
        //     Editable = false;
        //     FieldClass = FlowField;
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
        //     begin
        //         // <<DITW15.00.00.38 DDR 14/09/2010 - 12/10/2010 #1217
        //         TESTFIELD(Correction,false);
        //         // <<DITW18.00.06 DDR 20/10/2015 DIT-770 #1449
        //         if (CurrFieldNo = FIELDNO("Packaging Type Code")) and ("Tax Item No." <> '') and
        //           ("Packaging Type Code" <> '') and (xRec."Packaging Type Code" <> "Packaging Type Code")
        //         then
        //           TESTFIELD("Packaging Type Code",xRec."Packaging Type Code");
        //         // >>DITW18.00.06 DDR DIT-770 #1449

        //         // <<DITW16.00.00.42 DDR 27/02/2013 DIT-715 #550
        //         if ("Packaging Type Code" <> '') and ((Type = Type::Item) or ("Tax Item No." <> '')) then begin
        //         // >>DITW16.00.00.42 DDR DIT-715 #550
        //           PackagingType.GET("Packaging Type Code");
        //           if PackagingType.Countable then begin
        //             // <<DITW15.00.00.38 DDR 22/02/2010 #1217 (DIT711 151)
        //             if "Tax Item No." <> '' then begin
        //               Item.GET("Tax Item No.");
        //               ItemUnitOfMeasure.GET("Tax Item No.",Item."Sales Unit of Measure");
        //             end else
        //               ItemUnitOfMeasure.GET("No.","Unit of Measure Code");
        //             if "Packaging Type Code" = ItemUnitOfMeasure."Packaging Type Code" then begin
        //               ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
        //               "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
        //             end else
        //               "Pack Qty. per Unit of Measure" := 1;
        //             // >>DITW15.00.00.38 DDR #1217 (DIT711 151)
        //             // <<DITW15.00.00.38 DDR 31/01/2011 #1217 (DIT711 140) - 16/02/2011 (DIT711 148)
        //             TESTFIELD("Pack Qty. per Unit of Measure");
        //             // <<DITW16.00.00.44 DDR 24/03/2014 DIT-715 #912
        //             "No. of Packages" := ROUND(Quantity * "Pack Qty. per Unit of Measure",1,'>');
        //             // >>DITW16.00.00.44 DDR DIT-715 #912
        //             // >>DITW15.00.00.38 DDR #1217 (DIT711 140) (DIT711 148)
        //           end else
        //             "No. of Packages" := 0;
        //         end else
        //           // <<DITW15.00.00.38 DDR 22/02/2010 #1217 (DIT711 151)
        //           "No. of Packages" := 0;
        //           // >>DITW15.00.00.38 DDR #1217 (DIT711 151)

        //         // >>DITW15.00.00.38 DDR #1217
        //     end;
        // }
        // field(2014477;"No. of Packages";Decimal)
        // {
        //     CaptionML = ENU='No. of Packages',
        //                 FRA='Nbre de colis';
        //     DecimalPlaces = 0:2;
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 16/09/2010 - 12/10/2010 #1217
        //         TESTFIELD(Correction,false);
        //         TESTFIELD(Quantity);
        //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //         if ("Tax Item No." = '') and (Type <> Type::Item) then
        //           TESTFIELD("No. of Packages",0);
        //         // >>DITW15.00.00.38 DDR #703
        //         // <<DITW18.00.06 DDR 20/10/2015 DIT-770 #1449
        //         if ("Tax Item No." <> '') and (xRec."No. of Packages" <> "No. of Packages") then
        //           TESTFIELD("No. of Packages",xRec."No. of Packages");
        //         // >>DITW18.00.06 DDR DIT-770 #1449
        //     end;
        // }
        // field(2014478;"Commercial Seal ID";Text[35])
        // {
        //     CaptionML = ENU='Commercial Seal ID',
        //                 FRA='ID sceau commerciale';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 16/09/2010 - 12/10/2010 #1217
        //         TESTFIELD(Correction,false);
        //         TESTFIELD(Quantity);
        //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //         if ("Tax Item No." = '') and (Type <> Type::Item) then
        //           TESTFIELD("Commercial Seal ID",'');
        //         // >>DITW15.00.00.38 DDR #703
        //     end;
        // }
        // field(2014482;"Pack Qty. per Unit of Measure";Decimal)
        // {
        //     CaptionML = ENU='Packaging Qty. per Unit of Measure',
        //                 FRA='Quantité conditionnement par unité';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.38 #1217 (DIT711 148)';
        // }
        // field(2014500;"Has Item Charge";Boolean)
        // {
        //     CalcFormula = Exist("Return Shipment Line" WHERE ("Document No."=FIELD("Document No."),
        //                                                       "Attached to Line No."=FIELD("Line No.")));
        //     CaptionML = ENU='Has Item Charge',
        //                 FRA='A des Frais Annexes';
        //     Description = 'DITW17.10.03 DIT-770 #541';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014503;"Equiv. Unit of Measure Code";Code[10])
        // {
        //     CaptionML = ENU='Equiv. Unit of Measure Code',
        //                 FRA='Unitié de mesure equiv.';
        //     Description = 'DITW17.00.02 DIT-770 #183';
        //     TableRelation = "Unit of Measure".Code;
        // }
        // field(2014504;"Calculate Minimum";Option)
        // {
        //     CaptionML = ENU='Calculate Minimum',
        //                 FRA='Calculer minimum';
        //     Description = 'DITW17.10.03 DIT-770 #327-NRQ#14143';
        //     OptionCaptionML = ENU=' ,Under,Over,Until,Until Including Min,Recurring Minimum,Recurring Over,Recurring Under,Recurring Until',
        //                       FRA=' ,Under,Over,Until,Until Including Min,Recurring Minimum,Recurring Over,Recurring Under,Recurring Until';
        //     OptionMembers = " ",Under,Over,"Until","Until Including Min","Recurring Minimum","Recurring Over","Recurring Under","Recurring Until";
        // }
        // field(2014505;"Recurring Min. Quantity";Decimal)
        // {
        //     CaptionML = ENU='Recurring Min. Quantity',
        //                 FRA='Quantité Min. Recurrente';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW17.10.03 DIT-770 #327';
        //     MinValue = 0;
        // }
        // field(2014506;"Splitting per";Option)
        // {
        //     CaptionML = ENU='Calculate Source Per',
        //                 FRA='Calculer source par';
        //     Description = 'DITW17.10.03 DIT-770 #327';
        //     InitValue = Item;
        //     OptionCaptionML = ENU='Group,Item',
        //                       FRA='Groupe,Article';
        //     OptionMembers = Group,Item;
        // }
        // field(2014507;"Minimum Quantity";Decimal)
        // {
        //     Caption = 'Minimum Quantity';
        //     DecimalPlaces = 0:5;
        //     Description = 'NRQ#14143';
        //     MinValue = 0;
        // }
        // field(2014510;"Loyalty-Created";Boolean)
        // {
        //     Caption = 'Loyalty-Created';
        //     Description = 'DITW113.00.15 NRQ#120300';
        // }
        // field(2014518;"Loyalty Outstd. Cost Amt.";Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Outstanding  Loyalty Cost Amount',
        //                 FRA='Fidélité Coût en commande';
        //     Description = 'DITW17.10.05 DIT-770 #185';
        //     Editable = false;

        //     trigger OnValidate();
        //     var
        //         Currency2 : Record Currency;
        //     begin
        //     end;
        // }
        // field(2014519;"Loyalty Outst. Cost Amt. (LCY)";Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Outstanding  Loyalty Cost Amount (LCY)',
        //                 FRA='Fidélité Coût en commande DS';
        //     Description = 'DITW17.10.05 DIT-770 #185';
        //     Editable = false;
        // }
        // field(2014520;"Loyalty Convert to Free Item";Boolean)
        // {
        //     CaptionML = ENU='Automatic Set Free Item',
        //                 FRA='Définir comme Article gratuit';
        //     Description = 'DITW17.10.05 DIT-770 #185';
        // }
        // field(2014521;"Loyalty Point Type";Option)
        // {
        //     CaptionML = ENU='Loyalty Point Type',
        //                 FRA='Type Point de fidelisation';
        //     Description = 'DITW17.10.05 DIT-770 #185';
        //     OptionCaptionML = ENU=' ,Exchange,Gain',
        //                       FRA=' ,Change,Gain';
        //     OptionMembers = " ",Exchange,Gain;
        // }
        // field(2014522;"Loyalty Amount Type";Option)
        // {
        //     CaptionML = ENU='Loyalty Amount Type',
        //                 FRA='Type Point de FidËÇÜlisation';
        //     Description = 'DITW17.10.05 DIT-770 #185';
        //     OptionCaptionML = ENU=' ,Exchange,Gain',
        //                       FRA=' ,Change,Gain';
        //     OptionMembers = " ",Exchange,Gain;
        // }
        // field(2014523;"Loyalty Amount (LCY)";Decimal)
        // {
        //     AutoFormatType = 1;
        //     Caption = 'Loyalty Amount (LCY)';
        //     Description = 'DITW17.10.05 DIT-770 #185';
        // }
        // field(2014524;"Loyalty Amount";Decimal)
        // {
        //     AutoFormatType = 1;
        //     Caption = 'Loyalty Amount';
        //     Description = 'DITW17.10.05 DIT-770 #185';
        // }
        // field(2034850;"DIT Sub-Contract Type";Option)
        // {
        //     CaptionML = ENU='Sub Contract Type',
        //                 FRA='Sous type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';
        //     OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA=' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        // }
        // field(2034872;"Contract Group Code";Code[10])
        // {
        //     CaptionML = ENU='Contract Group Code',
        //                 FRA='Code groupe contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';
        //     TableRelation = IF ("Contract Type"=CONST(Service)) "Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"))
        //                     else IF ("Contract Type"=CONST(Financial)) "Financial Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034915;"Service Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Service Contract No.',
        //                 FRA='N° contrat de service';
        //     Description = 'DITW16.00.00.41 DIT-715 #392 - DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Service Purch. Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                            "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
        // }
        // field(2035391;"Buy-from Vendor Name";Text[50])
        // {
        //     CalcFormula = Lookup("Return Shipment Header"."Buy-from Vendor Name" WHERE ("No."=FIELD("Document No.")));
        //     CaptionML = ENU='Buy-from Vendor Name',
        //                 FRA='Nom du fournisseur';
        //     Description = 'DITW17.00.02 DIT-770 #180';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035393;"Contract Type";Option)
        // {
        //     CaptionML = ENU='Contract Type',
        //                 FRA='Type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392 - DITW18.00.06 DIT-770 #1368';
        //     OptionCaptionML = ENU=' ,Service,Financial',
        //                       FRA=' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }
        //BC UpgradeSHARMP16 End<<-- Drink-IT field
    }
    keys
    {

        //Unsupported feature: PropertyChange on ""Document No.","Line No."(Key)". Please convert manually.
        //BC UpgradeSHARMP16 Begin>>-- Drink-IT fields used in Keys
        // key(Key1; "Document No.", "Attached to Line No.", "Is Item Charge")
        // {
        // }
        // key(Key2; "Document No.", "AAD No. Series", "Company Tax Registration No.", "Tariff No.", Type, "No.")
        // {
        // }
        // key(Key3; "Document No.", "LRN No. Series", "Company Tax Registration No.", "Company Tax Warehouse Ref.", "Tariff No.", Type, "No.")
        // {
        // }
        // key(Key4; "ARC No.", "Company Tax Registration No.", "Tariff No.", Type, "No.")
        // {
        // }
        // key(Key5; "LRN No.", "Company Tax Registration No.", "Company Tax Warehouse Ref.", "Tariff No.", Type, "No.")
        // {
        // }
        // key(Key6; "Applies-to AAD Trck. Entry No.")
        // {
        // }
        //BC UpgradeSHARMP16 End<<-- Drink-IT fields used in Keys
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: EmcsCommentLine)();
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
    PurchDocLineComments.SETRANGE("Document Type",PurchDocLineComments."Document Type"::"Posted Return Shipment");
    PurchDocLineComments.SETRANGE("No.","Document No.");
    PurchDocLineComments.SETRANGE("Document Line No.","Line No.");
    if not PurchDocLineComments.ISEMPTY then
      PurchDocLineComments.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5

    // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
    EmcsCommentLine.SETRANGE("Table ID",DATABASE::"Return Shipment Line");
    EmcsCommentLine.SETRANGE("Document Type",0);
    EmcsCommentLine.SETRANGE("Document No.","Document No.");
    EmcsCommentLine.SETRANGE("Document Line No.","Line No.");
    EmcsCommentLine.DELETEALL;
    // >>DITW16.00.00.40 DDR DIT-715 #187
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
    //    EmcsCommentLine: Record "EMCS Comment Line";

    var
        ItemChargeReturnShptLine: Record "Return Shipment Line";
        SalesGetReturnSpht: Codeunit "Purch.-Get Return Shipments";


    //Unsupported feature: PropertyModification on "Text000(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Return Shipment No. %1:;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Return Shipment No. %1:;FRA=N° expédition retour %1 :;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=The program cannot find this purchase line.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=The program cannot find this purchase line.;FRA=Le programme ne trouve pas cette ligne achat.;
    //Variable type has not been exported.

    //HEI.09>>
    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertShipmentForLevyTax(VAR PurchLine: Record "Purchase Line")
    begin
    end;
    //HEI.09<<
    var
        SaveCurrency: Record Currency;
        InvtSetup: Record "Inventory Setup";
        Item: Record Item;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        // EmcsSetup: Record "EMCS Setup";
        // PackagingType: Record "Packaging Type";
        ReturnShptLine: Record "Return Shipment Line";
        SaveTransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
}

