tableextension 50096 TransferLineExtFND extends "Transfer Line"
{
    // DITW15.00.00.25 DDR 10/10/2008 Added fields
    //                                  2014077 Truck Code
    //                                  2014078 Driver Code
    // DITW15.00.00.30 DDR 09/01/2009 Added function CheckCombLocationBins() to verify the location combination is valid.
    // DITW15.00.00.36 DDR 17/12/2009 issue 594 Added AAD fields
    //                                            2013726 Company Tax Registration No.
    //                                            2013727 AAD No. Series - Shipment
    //                                            2013728 AAD No. - Shipment
    //                                            2013729 Tariff No.
    //                                            2013757 AAD No. - Receipt
    //                                            2013767 Unit Volume HL
    //                                          Added functions
    //                                            GetCompanyInfoSetup(),UpdateAADInfo(),GetAADNoSeries()
    //                                          Added key
    //                                            'Document No.,AAD No. Series,Company Tax Registration No.,Tariff No.,Item No.'
    //                                          Added functions
    //                                            GetUomCaptionClass()
    // DITW15.00.00.37 DDR 04/02/2010 issue 480 Added fields
    //                                            2013660 Extra Charge Type
    //                                            2013661 Item Charge Value
    //                                            2013662 Is Item Charge
    //                                            2013663 ItemCharge Incl. Price
    //                                            2013664 Item Charge Discount %
    //                                            2013665 Allow Item Charge Line Disc.
    //                                            2013667 Item DTax Group Code
    //                                            2013694 Opposite Amount Sign
    //                                            2013695 Item Charge Type
    //                                            2013696 Location Group Code
    //                                            2013708 Due Tax
    //                                            2013715 Tax Formula
    //                                            2013722 Duty Suspended
    //                                            2013747 Tax Spec. HL
    //                                            2013748 Tax Spec. Degrees Plato
    //                                            2013759 Calculate Tax on Location
    //                                            2013798 Item Charge No.
    //                                            2014064 Shipping Charge Per
    //                                            2014079 Cubage
    //                                            2014080 Weight
    //                                            2014087 Distance
    //                                            2014094 Physical Location Group Code
    //                                            2014410 Collapse
    //                                            2014440 Attached to Line No.
    //                                            2014112 Unit Amount
    //                                          Added parameters Type2,No2 for function CreateDim()
    //                                          Added functions
    //                                            RoundThousandLineNo(),FormEditableField(),FormTotalingField(),
    //                                            DeleteAllChargeTransferLines(),InsertChargeLines(),UpdateCharges(),InsertCharges(),
    //                                            InsertCharges4(),ValidateCreateDimNo(),CalcCubageWeight(),CheckBinCubageWeight(),
    //                                            SetHideValidationDialog(),SetTransferHeader(),GetTransferHeader(),
    //                                            InsertChargesTemp4(),SetJnlLineDimToDimBuf(),MoveJnlLineDimToBuf(),GetTempJnlLineDim()
    //                                            SuspendStatusCheck(),GetTransHeaderOnly()
    //                                          Added key
    //                                            "Document No.,Attached to Line No.,Collapse,Is Item Charge,ItemCharge Incl. Price,
    //                     18/06/2010 issue 1169 Bugfix missing to fill in Gen. Prod. Posting Group when validate Item Charge No.
    //                                           Bugfix to validate Qty to receive and update item charge lines
    // DITW15.00.00.37 PRODW14.00.00.16 23/06/2010 issue 1051 Added fields
    //                                               2035090 No. of Quality Tests
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 23/06/2010 issue 1151
    //                                                   Added functions
    //                                                     ShowQualityTests(),CountQualityTests(),DrilldownQualityTests(),
    //                                                     QualityTestHeaderFilters()
    //                                                   Added to remove Quarantine Quality test when delete purchase line
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                             Add     functions GetAutoFormatExpr(),GetTotalingAutoFormatExpr()
    //                                             Remove  functions FormTotalingField()
    //                     10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                           Added fields
    //                                             2014260 LRN Nos Series - Shipment
    //                                             2014260 LRN No. - Shipment
    //                                             2014262 ARC No. - Shipment
    //                                             2014263 SAD No. - Shipment
    //                                             2014267 ARC No. Mandatory - Shipment
    //                                             2014265 Product Tax Code
    //                                             2014476 Packaging Type Code
    //                                             2014271 Tax Warehouse Reference
    //                                           Removed fields "Tax Spec. HL","Tax Spec. Degrees Plato"
    //                                           AAD Checking Rule Modified (combination Cust/Item Tax Groups)
    //                                           Rewrite/review functions
    //                                             UpdateAADInfo()
    //                                           Added functions
    //                                             TestAADNoSeriesMandatory(),TestDutySuspendMandatory(),TestTaxRegMandatory();
    //                                             GetLocationGr(),GetDrinkTaxGroups(),ExistLineChargeType(),ExistLineDutySuspended(),
    //                                             TestT
    //                                           Modified key to add "lRN No. Series - Shipment"
    //                                             'Document No.,AAD No. Series,EMCS LRN No. Series,Company Tax Registration No.,
    //                                              Tariff No.,Type,No.'
    //                     04/10/2010            Missing "LRN No. Series - Shipment","LRN No. - Shipment" triggers
    //                                           Missing copy value "Product Tax Code" from item
    //                                           Added fields
    //                                             2014281 ARC No. - Receipt
    // DITW15.00.00.38 DDR 15/11/2010 issue 1139 SSCC Functionnalities
    //                                       Added functions OpenSSCCTrackingLines()
    //                     10/12/2010 issue 1170 Bugfix to skip function UpdateAADInfo() on Transfer Receipt
    //                     21/12/2010 issue 1171 Added fields
    //                                             2014434 Line Amount
    //                                           Added functions
    //                                             UpdateAmount(),GetGLSetup()
    //                                           Modified captions field2014267,2014281
    //                     22/12/2010 issue 1217 (DIT711 103) Added new option AAD/ARC mandatory type to skip
    //                                                          when From/To location Tax Registration/Tax Whse Reference are identical
    //                                                        Added functions IsLocationGrMandatoryAAD(),IsLocationGrMandatoryARC()
    //                                                        Allow to call UpdateAAD() from Transfer Header
    //                     03/01/2011 issue 1217 (DIT711 103) Bugfix function UpdateAAD() when using Warehouse locations
    //                     04/01/2011                         Skip calling function UpdateAADInfo()
    //                                                          when the shipment/receipt dates are not changed.
    //                                                        Save Shipment/Receipt dates when modified from header
    //                                                        Missing to keep Collapse field when (re)validate Item No.
    //                     24/01/2011 issue 1255 Bugfix to update Qty. to ship/Receive (item charges) while posting Whse document
    //                                                  when increase quantity after a partial shipped/received
    //                                                    (don't recreate item charge lines)
    // DITW15.00.00.38 PRODW14.00.00.17 DDR 08/02/2011 issue 1271
    //                                          Modified 'CalcFormula' property field2035090 No. of Quality Tests
    // DITW15.0.00.38 DDR  16/02/2011 issue 1217 (DIT711 148) Added fields
    //                                            2014482 Pack Qty. Per Unit of Measure"
    //                     11/03/2011 issue 458 Replaced caption field2013696 'Location Group' -> 'Location Tax Group'
    //                                                           field2013758
    //                     11/03/2011 issue 703 Added fields
    //                                            2013612 Item Charge Quantity per
    //                                            2014113 Tax Item No.
    //                                          Added functions GetTrackingItemNo(),LookupItemNo()
    //                     16/03/2011 issue 1217 (DIT711 161) Added validate field "Packaging Type Code"
    // DITW15.00.00.39 DDR 15/04/2011 issue 1296 Added link to Warehouse receipt documents
    //                                           Added fields
    //                                             2014289 ARC No. Mandatory - Receipt
    //                                           Added 'TypeOfLocation' parameter functions IsLocationGrMandatoryARC()
    //                                           Added functions
    //                                             EDILookupExtTrackingARC(),EDIUpdateInboxDocNo(),TestOpenEDIInboxDocNo()
    //                     06/05/2011 issue 1296 Removed error message Text2014261 for warehouse receipts
    //                     11/07/2011 issue 1369 Added fields
    //                                  2013731 Applies-to AAD Trck. Entry No.
    // DITW16.00.00.39 DDR 05/08/2011 DIT-715 #148 Added Lookup trigger field2013731 "Applies-to AAD trck. Entry No."
    // DITW15.00.00.39 PRODW14.00.00.08.18 DDR 18/08/2011 issue 1410
    //                                           Show all Quality tests, Removed source item ledger entry in flowfield
    //                                           Modified 'CalcFormula' property field2035090 No. of Quality Tests
    //                     26/08/2011 issue 1393 Added function AssistEditItemTreeview()
    //                     23/09/2011 issue 1437 Bugfix remove check mandatory AAD & Lrn (only for Location-to)
    //                     06/10/2011 issue 1444 Bugfix batch mode to insert item charge lines
    //                     12/10/2011 issue 1433 Bugfix missing "ARC No. Mandatory - Receipt"
    //                     28/10/2011 issue 1457 Modified many ML captions
    // DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
    //                                Added fields
    //                                  2014069 Shortcut Unit of Measure1 Code
    //                                  2014089 Shortcut Unit of Measure2 Code
    //                                  2014093 Shortcut Unit of Measure3 Code
    //                                Added functions GetCaptionClassUom(),ShowShortcutUomValue()
    //                     03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                             Modified function AssistEditItemTreeview()
    //                                             Added text constants Text2014412
    //                     13/06/2012 DIT-715 #338 Added functions AllItemsAvailability()
    //                     03/07/2012 DIT-715 #371 Bugfix missing excises data when using "Tax Item No."
    // DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457 Added checking for "Work Order No." mandatory in Transfer Header
    // DITW16.00.00.42 DDR 08/01/2013 DIT-715 #531 Bugfix clear fields when "Item Charge No." is filled
    //                                               "Gross Weight","Net Weight","Unit Volume","Units per Parcel";
    // DITW16.00.00.43 DDR 27/09/2013 DIT-715 #733 Added "Exclude from EMCS" with From/To Location Code
    //                 DDR 25/09/2013 DIT-715 #519 Added link to Charge Bom Sales lines
    //                                             Bugfix function GetTrackingItemNo()
    //                                             Added functions InsertCharges2(),InsertCharges3()
    //                 DDR 21/10/2013 DIT-715 #768 Added get dimensions from "Tax Item No."
    //                                             Added Type3 parameter function CreateDim()
    //                 DDR 23/10/2013 DIT-715 #768 Bugfix to skip Tax fields with "Tax Item No." for Deposit charges
    //                 DDR 18/12/2013 DIT-715 #766 Bugfix missing "Physical location group code" while create tax item line
    //                 DDR 20/12/2013 DIT-715 #864 Bugfix "Tax item no." to keep current values while get header
    //                                             Bugfix editable "Packaging Type Code" with "Tax Item No."
    //                 DDR 17/01/2014 DIT-715 #863 Bugfix to read new transfer header before inserting tax lines
    //                 DDR 28/01/2014 DIT-715 #863 Bugfix skip test "In-Transit Code" field in background validation

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars
    // MANXL7.00.001 DAT 05/03/2014 #18: requester ID
    // MANXL7.00.001 WSA 15/07/2014 #76: Resize the field "Requester ID" 20 -> 50
    // FINXL8.00.001 BSA 02/06/2015 #178: Added field "Cross Reference" "Emergency Order"

    // DITW17.00.01 DDR 26/11/2012 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 21/08/2013 DIT-770 #112 Added 'CalledByFieldNo' parameter to function ValidateCreateDimNo()
    //              DDR 02/09/2013 DIT-770 #112 Added to update item charges from Item journal line Dimensions
    // DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field "2035391 , 2035392" Added
    //              DDR 27/09/2013 DIT-715 #733 merge
    //              DDR 01/10/2013 DIT-715 #519 Merge
    // DITW17.00.02 DDR 22/10/2013 DIT-715 #768 Merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 DDR 18/12/2013 DIT-715 #766 merge
    // DITW17.00.02 DDR 20/12/2013 DIT-715 #864 merge
    // DITW17.00.02 DDR 17/01/2014 DIT-770 #863 merge
    // DITW17.00.02 DDR 28/01/2014 DIT-770 #863 merge
    // DITW17.10.03 DDR 09/04/2014 DIT-770 #558 Bugfix getlocation with item charges when validating Qty. to Ship/Receive
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05 MSF 20/11/2014 DIT-770 #701 Added Function TestTaxDueMandatory
    //                                                         ExistLineTaxDue
    // DITW17.10.05 MSF 11/12/2014 DIT-770 #701
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW17.10.05 MSF 09/01/2015 DIT-770 #701
    // DITW17.10.05 MSF 10/03/2015 DIT-770 #701 Delete testfields on "Due Tax"
    // DITW18.00.06 MSF 22/05/2015 DIT-770 #1320  Merge OF (DITW16.00.00.45 DDR 30/03/2015 DIT-715 #950)
    // DITW18.00.06 MSF 25/05/2015 DIT-770 #1379 The auto assist list with ARC numbers for receipt of transferorders is linked to the wrong excise numbers
    // DITW18.00.06 MSF 24/06/2015 DIT-770 #1379 Change TESTFIELD Error by Confirmation message
    // DITW18.00.06 DDR 13/07/2015 DIT-770 #1258 Added key "Derived From Line No.,Item No."
    // DITW18.00.06 DDR 20/10/2015 DIT-770 #1449 Added fields
    //                                             2014460 Production BOM No.
    //                                             2014461 Prod. BOM Version Code
    //                                             2014462 BOM Line No.
    //                                             2014463 BOM Item No.
    //                                             2014464 BOM Qty. per Unit of Measure
    // DITW18.00.06 DDR 23/10/2015 DIT-770 #1395 Modified function GetTrackingItemNo
    //                                           Bugfix Tax Item Tracking calculation
    // DITW18.00.06 DDR 26/10/2015 DIT-770 #1412 Bugfix clear value relating item with normal item charges
    //                                           Added field 2014477 "No. of Packages"
    // DITW18.00.06 DDR 04/11/2015 DIT-770 #1395 Added Giftbox lines avoid delete record
    //                                           Added Giftbox field
    //                                             2013768 Trsf-to Unit Volume HL
    // DITW18.00.07 DDR 28/02/2016 DIT-770 #1836 Added validate with item charges without posting group
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields
    //                                                        2013716 Strength Spec. Code
    //                                                        2013717 Strength Spec. Value
    //                                                        2013718 Vol-Strength Spec. Code
    //                                                        2013719 Vol-Strength Spec. Value
    // DITW19.00.08 DDR 17/10/2016 BL#10443 Modified functions GetTaxSpecCaption()
    //                                      Added functions UpdateStrengthValues()
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Bugfix function GetTaxSpecCaption()
    //                                      Removed functions UpdateStrengthValues(),CalcVolumeStrength()
    //                                      Added functions AverageStrengthReserv(),SumVolStrengthReserv(),DrilldownReservEntryVS()
    //                                      Removed fields
    //                                        2013717 Strength Spec. Value
    //                                        2013719 Vol-Strength Spec. Value
    // DITW19.00.08 DDR 14/11/2016 BL#10443 Added from sales/purchase functionality
    //                                       Added fields
    //                                         2013720 New Strength Spec. Value
    //                                         2013721 New Vol-Strength Spec. Value

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.09 AKH 29/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.09 DDR 05/04/2017 NRQ#16737 Added field 2014417 Relation Location Code
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // FINXL10.00 YHE 15/06/2017 NXL#29836: added code in fctValidateCrossReference
    // DITW110.00.11 SFI 30/08/2017 BL#14417 New field
    //                                         2013637 Deposit Value
    // DITW110.00.11 SFI 31/08/2017 BL#30569 Added changes for SKU blocking
    // DITW110.00.12 AKH 21/03/2018 NRQ#64704 Adjusted code to use the "Inventory Unit of Measure" instead of "Base Unit of Measure" of the item
    // DITW111.00.13 MSF 06/12/2018 NRQ#94671 Line and header alert for not fully assigned lines - in warehouse shipment and sales order
    //                                        Added field "Lot Reserved Qty. (Base)"
    // DITW111.00.13A MSF 30/04/2019 NRQ#106834 AUTO FEFO and Undo Tracking Lines functions for transfer orders
    //                               Added function FEFOTracking

    // HEI.01 FDD-GAPID031 IBM.PATHAA02 17.08.2017
    //   # Description made non-Editable
    // HEI.02 CHG0257267 IBM.AB 16.01.2019
    //   # Field length for Prod. BOM Version Code is increased from 10 to 20
    // DITW110.00.12 AKH 30/03/2018 NRQ#16026 Order Shipment Planning: Sync Sales - Transfer

    // # DITW111.00.13A MSF 14/06/2019 NRQ#112871 Transfer receipt posts wrong HL Volume when Items base UOM different than Transfer line UOM
    // CHG2104608: DITW111.00.13 ISL 18/12/2018 NRQ#96024 Deleted field 2014461 "Prod. BOM Version Code"
    // HEI.03 CHG2095415 IBM BULIMC01 20.04.2021#new fields added:
    //     # 50001 - "RPM Related"
    //     # 50002 - "RPM Type"
    //     # 50003 - "Item Type"
    // NRQ195669.1 MVN 15/09/2021: merge DITW114.00.15 DDR 08/05/2020 NRQ#145254 Fix recalculate "Deposit Value" with Unit of Measure code
    // HEI.05 CHG2123219 BHATTA09 08.12.2021
    //   # Code added for getting SKU CCC Dimension


    // BC Upgrade SHUKLP03 >>
    // HEI.01 => Description made editable false on pages "Transfer Lines" and "Transfer Order Subform". 
    // HEI.02 => Not increased length because "Prod. BOM Version Code" is DrinkIT field.
    // HEI.03 => Field 50001 - "RPM Related" is not found in Nav.
    // HEI.03 => Trigger OnValidate() code of field Item No. is not added because dependency on DrinkIT procedure GetSKU(SKU).
    // HEI.05 => Proceudre CreateDim() Code is not added because code is written in-between DrinkIT code.
    // BC Upgrade SHUKLP03 <<


    fields
    {
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Unit of Measure")
        {
            CaptionML = ENU = 'Unit of Measure', FRA = 'Unité';
        }
        modify("Qty. to Ship")
        {
            CaptionML = ENU = 'Qty. to Ship', FRA = 'Qté à expédier';
        }
        modify("Qty. to Receive")
        {
            CaptionML = ENU = 'Qty. to Receive', FRA = 'Qté à recevoir';
        }
        modify("Quantity Shipped")
        {
            CaptionML = ENU = 'Quantity Shipped', FRA = 'Qté expédiée';
        }
        modify("Quantity Received")
        {
            CaptionML = ENU = 'Quantity Received', FRA = 'Quantité reçue';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            OptionCaptionML = ENU = 'Open,Released', FRA = 'Ouvert,Lancé';
        }
        modify("Shortcut Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 1 Code"(Field 11)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 2 Code"(Field 12)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';

            //Unsupported feature: Change Description on "Description(Field 13)". Please convert manually.


            //Unsupported feature: Change Editable on "Description(Field 13)". Please convert manually.

        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("Inventory Posting Group")
        {
            CaptionML = ENU = 'Inventory Posting Group', FRA = 'Groupe compta. stock';
        }
        modify("Quantity (Base)")
        {
            CaptionML = ENU = 'Quantity (Base)', FRA = 'Quantité (base)';
        }
        modify("Outstanding Qty. (Base)")
        {
            CaptionML = ENU = 'Outstanding Qty. (Base)', FRA = 'Quantité ouverte (base)';
        }
        modify("Qty. to Ship (Base)")
        {
            CaptionML = ENU = 'Qty. to Ship (Base)', FRA = 'Qté à expédier (base)';
        }
        modify("Qty. Shipped (Base)")
        {
            CaptionML = ENU = 'Qty. Shipped (Base)', FRA = 'Qté expédiée (base)';
        }
        modify("Qty. to Receive (Base)")
        {
            CaptionML = ENU = 'Qty. to Receive (Base)', FRA = 'Qté à recevoir (base)';
        }
        modify("Qty. Received (Base)")
        {
            CaptionML = ENU = 'Qty. Received (Base)', FRA = 'Quantité reçue (base)';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("Unit of Measure Code")
        {

            //Unsupported feature: Change TableRelation on ""Unit of Measure Code"(Field 23)". Please convert manually.

            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Outstanding Quantity")
        {
            CaptionML = ENU = 'Outstanding Quantity', FRA = 'Quantité restante';
        }
        modify("Gross Weight")
        {
            CaptionML = ENU = 'Gross Weight', FRA = 'Poids brut';
        }
        modify("Net Weight")
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
        }
        modify("Unit Volume")
        {
            CaptionML = ENU = 'Unit Volume', FRA = 'Volume unitaire';
        }
        modify("Variant Code")
        {

            //Unsupported feature: Change TableRelation on ""Variant Code"(Field 30)". Please convert manually.

            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Units per Parcel")
        {
            CaptionML = ENU = 'Units per Parcel', FRA = 'Conditionnement';
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify("In-Transit Code")
        {

            //Unsupported feature: Change TableRelation on ""In-Transit Code"(Field 33)". Please convert manually.

            CaptionML = ENU = 'In-Transit Code', FRA = 'Code transit';
        }
        modify("Qty. in Transit")
        {
            CaptionML = ENU = 'Qty. in Transit', FRA = 'Qté en transit';
        }
        modify("Qty. in Transit (Base)")
        {
            CaptionML = ENU = 'Qty. in Transit (Base)', FRA = 'Qté en transit (base)';
        }
        modify("Transfer-from Code")
        {

            //Unsupported feature: Change TableRelation on ""Transfer-from Code"(Field 36)". Please convert manually.

            CaptionML = ENU = 'Transfer-from Code', FRA = 'Code prov. transfert';
        }
        modify("Transfer-to Code")
        {

            //Unsupported feature: Change TableRelation on ""Transfer-to Code"(Field 37)". Please convert manually.

            CaptionML = ENU = 'Transfer-to Code', FRA = 'Code dest. transfert';
        }
        modify("Shipment Date")
        {
            CaptionML = ENU = 'Shipment Date', FRA = 'Date d''expédition';
        }
        modify("Receipt Date")
        {
            CaptionML = ENU = 'Receipt Date', FRA = 'Date de réception';
        }
        modify("Derived From Line No.")
        {

            //Unsupported feature: Change TableRelation on ""Derived From Line No."(Field 40)". Please convert manually.

            CaptionML = ENU = 'Derived From Line No.', FRA = 'Issue de ligne n°';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("Shipping Agent Service Code")
        {

            //Unsupported feature: Change TableRelation on ""Shipping Agent Service Code"(Field 42)". Please convert manually.

            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
        }
        modify("Appl.-to Item Entry")
        {
            CaptionML = ENU = 'Appl.-to Item Entry', FRA = 'Écr. article à lettrer';
        }
        modify("Reserved Quantity Inbnd.")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Quantity Inbnd."(Field 50)". Please convert manually.

            CaptionML = ENU = 'Reserved Quantity Inbnd.', FRA = 'Qté réservée enlogement';
        }
        modify("Reserved Quantity Outbnd.")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Quantity Outbnd."(Field 51)". Please convert manually.

            CaptionML = ENU = 'Reserved Quantity Outbnd.', FRA = 'Qté réservée désenlogement';
        }
        modify("Reserved Qty. Inbnd. (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Qty. Inbnd. (Base)"(Field 52)". Please convert manually.

            CaptionML = ENU = 'Reserved Qty. Inbnd. (Base)', FRA = 'Qté réservée enlogement (base)';
        }
        modify("Reserved Qty. Outbnd. (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Qty. Outbnd. (Base)"(Field 53)". Please convert manually.

            CaptionML = ENU = 'Reserved Qty. Outbnd. (Base)', FRA = 'Qté réservée désenlogement (base)';
        }
        modify("Shipping Time")
        {
            CaptionML = ENU = 'Shipping Time', FRA = 'Délai d''expédition';
        }
        modify("Reserved Quantity Shipped")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Quantity Shipped"(Field 55)". Please convert manually.

            CaptionML = ENU = 'Reserved Quantity Shipped', FRA = 'Quantité réservée livrée';
        }
        modify("Reserved Qty. Shipped (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Qty. Shipped (Base)"(Field 56)". Please convert manually.

            CaptionML = ENU = 'Reserved Qty. Shipped (Base)', FRA = 'Qté réservée livrée (base)';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Item Category Code")
        {
            CaptionML = ENU = 'Item Category Code', FRA = 'Code catégorie article';
        }
        //BC Upgrade Kamnay01 -Field is Deprecated >>
        // modify("Product Group Code")
        // {

        //     //Unsupported feature: Change TableRelation on ""Product Group Code"(Field 5707)". Please convert manually.

        //     CaptionML = ENU = 'Product Group Code', FRA = 'Code groupe produits';
        // }
        //BC Upgrade Kamnay01 -Field is Deprecated <<
        modify("Whse. Inbnd. Otsdg. Qty (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Whse. Inbnd. Otsdg. Qty (Base)"(Field 5750)". Please convert manually.

            CaptionML = ENU = 'Whse. Inbnd. Otsdg. Qty (Base)', FRA = 'Qté restante entrepôt enlogement (Base)';
        }
        modify("Whse Outbnd. Otsdg. Qty (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Whse Outbnd. Otsdg. Qty (Base)"(Field 5751)". Please convert manually.

            CaptionML = ENU = 'Whse Outbnd. Otsdg. Qty (Base)', FRA = 'Qté restante entrepôt désenlogement (Base)';
        }
        modify("Completely Shipped")
        {
            CaptionML = ENU = 'Completely Shipped', FRA = 'Entièrement expédiée';
        }
        modify("Completely Received")
        {
            CaptionML = ENU = 'Completely Received', FRA = 'Entièrement réceptionné';
        }
        modify("Outbound Whse. Handling Time")
        {
            CaptionML = ENU = 'Outbound Whse. Handling Time', FRA = 'Délai désenlogement';
        }
        modify("Inbound Whse. Handling Time")
        {
            CaptionML = ENU = 'Inbound Whse. Handling Time', FRA = 'Délai enlogement';
        }
        modify("Transfer-from Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Transfer-from Bin Code"(Field 7300)". Please convert manually.

            CaptionML = ENU = 'Transfer-from Bin Code', FRA = 'Transf. du code emplacement';
        }
        modify("Transfer-To Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Transfer-To Bin Code"(Field 7301)". Please convert manually.

            CaptionML = ENU = 'Transfer-To Bin Code', FRA = 'Transf. vers code emplacement';
        }
        modify("Planning Flexibility")
        {
            CaptionML = ENU = 'Planning Flexibility', FRA = 'Flexibilité planification';
            //OptionCaptionML = ENU = 'Unlimited,None', FRA = 'Illimitée,Aucune';
        }

        //Unsupported feature: CodeModification on ""Item No."(Field 3).OnValidate". Please convert manually.

        //trigger "(Field 3)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Quantity Shipped",0);
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        ReserveTransferLine.VerifyChange(Rec,xRec);
        CALCFIELDS("Reserved Qty. Inbnd. (Base)");
        #6..8
        TempTransferLine := Rec;
        INIT;
        "Item No." := TempTransferLine."Item No.";
        IF "Item No." = '' THEN
          EXIT;

        GetTransHeader;
        GetItem;
        GetDefaultBin("Transfer-from Code","Transfer-to Code");

        Item.TESTFIELD(Blocked,FALSE);

        VALIDATE(Description,Item.Description);
        VALIDATE("Gen. Prod. Posting Group",Item."Gen. Prod. Posting Group");
        VALIDATE("Inventory Posting Group",Item."Inventory Posting Group");
        VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");
        VALIDATE("Gross Weight",Item."Gross Weight");
        VALIDATE("Net Weight",Item."Net Weight");
        VALIDATE("Unit Volume",Item."Unit Volume");
        VALIDATE("Units per Parcel",Item."Units per Parcel");
        VALIDATE("Description 2",Item."Description 2");
        VALIDATE(Quantity,xRec.Quantity);
        "Item Category Code" := Item."Item Category Code";
        "Product Group Code" := Item."Product Group Code";

        CreateDim(DATABASE::Item,"Item No.");
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Quantity Shipped",0);
        if CurrFieldNo <> 0 then
        #3..11
        // <<DITW15.00.00.37 DDR 09/02/2010 - 31/05/2010
        "Attached to Line No." := TempTransferLine."Attached to Line No.";
        "Item Charge No." := TempTransferLine."Item Charge No.";
        "Item Charge Type" := TempTransferLine."Item Charge Type";
        "Calculate Tax on Location" := TempTransferLine."Calculate Tax on Location";
        "Is Item Charge" := TempTransferLine."Is Item Charge";
        // <<DITW15.00.00.38 DDR 04/01/2011 #1217 (DIT711 103)
        Collapse := TempTransferLine.Collapse;
        // >>DITW15.00.00.38 DDR #1217 (DIT711 103)
        if "Item No." = '' then
          DeleteAllChargeTransferLines(Rec,true);
        // >>DITW15.00.00.37 DDR
        // <<DITW110.00.09 DDR 05/04/2017 NRQ#16737
        "Relation Transfer-from Code" := '';
        // >>DITW110.00.09 DDR NRQ#16737

        if "Item No." = '' then
          exit;
        #14..18
        Item.TESTFIELD(Blocked,false);
        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        // TODO SF: Check if also "Transfer-to Code" should be checked
        Item.BlockedSKU("Transfer-from Code","Variant Code",true);
        Item.BlockedSKU("Transfer-to Code","Variant Code",true);
        // >> DITW110.00.11 SFI BL#30569
        #20..23
        //<< DITW110.00.12 AKH 21/03/2018 NRQ#64704
        //VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");
        VALIDATE("Unit of Measure Code",Item."Inventory Unit of Measure");
        //>> DITW110.00.12 AKH NRQ#64704
        #25..32
        // <<DITW15.00.00.36 DDR 17/12/2009
        "Tariff No." := Item."Tariff No.";
        // <<DITW15.00.00.01 DDR 24/01/2008 - DITW19.00.08 DDR 17/08/2016 14/11/2016 BL#10443
        "Unit Volume HL" := Item."Unit Volume HL" * UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
        // >>DITW15.00.00.01 DDR - DITW19.00.08 DDR BL#10443
        // >>DITW15.00.00.36 DDR
        // <<DITW18.00.06 DDR 03/11/2015 DIT-770 #1395-DITW111.00.13A MSF 14/06/2019 NRQ#112871
        "Trsf-to Unit Volume HL" := Item."Unit Volume HL" * UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
        // >>DITW18.00.06 DDR DIT-770 #1395-DITW111.00.13A MSF 14/06/2019 NRQ#112871
        // <<DITW15.00.00.37 DDR 08/02/2010
        "Item DTax Group Code":= Item."Item DTax Group Code";
        // >>DITW15.00.00.37 DDR
        // <<DITW15.00.00.38 DDR 04/10/2010 #1217
        "Product Tax Code" := Item."Product Tax Code";
        // >>DITW15.00.00.38 DDR
        // <<DITW15.00.00.38 DDR 14/09/2010 #1217
        ItemUnitOfMeasure.GET("Item No.","Unit of Measure Code");
        "Packaging Type Code" := ItemUnitOfMeasure."Packaging Type Code";
        // >>DITW15.00.00.38 DDR
        // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
        if ItemUnitOfMeasure."Packaging Type Code" <> '' then
          ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
        "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
        // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
        // <<DITW19.00.08 DDR 17/08/2016 17/10/2016 14/11/2016 BL#10443
        "Strength Spec. Code" := Item."Strength Spec. Code";
        "Vol-Strength Spec. Code" := Item."Vol-Strength Spec. Code";
        // >>DITW19.00.08 DDR BL#10443
        // << DITW110.00.11 SFI 30/08/2017 BL#14417
        GetDepositValue();
        // >> DITW110.00.11 SFI BL#14417
        CreateDim(DATABASE::Item,"Item No.",
          // <<DITW15.00.00.37 DDR 04/02/2010
          DATABASE::"Item Charge","Item Charge No.",
          // >>DITW15.00.00.37 DDR
          // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
          DATABASE::Item,"Tax Item No.");
          // >>DITW16.00.00.43 DDR DIT-715 #768

        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");

        //<<FINXL8.00.001 BSA 02/06/2015 #178
        if recFinXLSetup.READPERMISSION then
          fctGetCrossReference;
        //>>FINXL8.00.001 BSA 02/06/2015 #178

        // <<DITW15.00.00.37 DDR 08/02/2010
        if CurrFieldNo = FIELDNO("Item No.") then begin
          if (Quantity <> 0) or (xRec.Quantity <> Quantity) then begin
            CurrFieldNo := FIELDNO("Transfer-from Code");
            InsertCharges4(FIELDNO("Transfer-from Code"));
            CurrFieldNo := FIELDNO("Item No.");
          end else
            DeleteAllChargeTransferLines(Rec,true);
        end;
        // >>DITW15.00.00.37 DDR

        // <<DITW15.00.00.38 DDR 30/08/2010 #1217
        UpdateAADInfo();
        // >>DITW15.00.00.38 DDR
        // << HEI.03
        if GetSKU(SKU) then begin
          "RPM Solution" := SKU."RPM Solution";
          "RPM Type" := SKU."RPM Type";
          "Item Type" := SKU."Item Type";
        end else begin
          "RPM Solution" := Item."RPM Solution";
          "RPM Type" := Item."RPM Type";
          "Item Type" := Item."Item Type";
        end;
        // >>HEI.03
        */
        //end;


        //Unsupported feature: CodeModification on "Quantity(Field 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        IF Quantity <> 0 THEN
          TESTFIELD("Item No.");
        "Quantity (Base)" := CalcBaseQty(Quantity);
        IF ((Quantity * "Quantity Shipped") < 0) OR
           (ABS(Quantity) < ABS("Quantity Shipped"))
        THEN
          FIELDERROR(Quantity,STRSUBSTNO(Text002,FIELDCAPTION("Quantity Shipped")));
        IF (("Quantity (Base)" * "Qty. Shipped (Base)") < 0) OR
           (ABS("Quantity (Base)") < ABS("Qty. Received (Base)"))
        THEN
          FIELDERROR("Quantity (Base)",STRSUBSTNO(Text002,FIELDCAPTION("Qty. Shipped (Base)")));
        InitQtyInTransit;
        InitOutstandingQty;
        InitQtyToShip;
        InitQtyToReceive;
        CheckItemAvailable(FIELDNO(Quantity));

        ReserveTransferLine.VerifyQuantity(Rec,xRec);

        UpdateWithWarehouseShipReceive;

        WhseValidateSourceLine.TransLineVerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo <> 0 then
          TestStatusOpen;
        if Quantity <> 0 then
          TESTFIELD("Item No.");
        "Quantity (Base)" := CalcBaseQty(Quantity);
        if ((Quantity * "Quantity Shipped") < 0) or
           (ABS(Quantity) < ABS("Quantity Shipped"))
        then
          FIELDERROR(Quantity,STRSUBSTNO(Text002,FIELDCAPTION("Quantity Shipped")));
        if (("Quantity (Base)" * "Qty. Shipped (Base)") < 0) or
           (ABS("Quantity (Base)") < ABS("Qty. Received (Base)"))
        then
          FIELDERROR("Quantity (Base)",STRSUBSTNO(Text002,FIELDCAPTION("Qty. Shipped (Base)")));

        // <<DITW15.00.00.37 DDR 08/02/2010
        if (CurrFieldNo = FIELDNO(Quantity)) and
           (xRec.Quantity <> Quantity) and
           (Quantity <> 0) and
           ("Extra Charge Type" <> "Extra Charge Type"::" ") and
           ("Item Charge Type" <> "Item Charge Type"::Deposit) and
           ("Extra Charge Type" <> "Extra Charge Type"::"Fixed Amount")
          then
            TESTFIELD(Quantity, xRec.Quantity);
        // >>DITW15.00.00.37 DDR

        #14..24

        // <<DITW18.00.06 DDR 29/10/2015 DIT-770 #1412
        if "Tax Item No." = '' then
          VALIDATE("Packaging Type Code");
        // >>DITW18.00.06 DDR DIT-770 #1412

        // <<DITW15.00.00.39 DDR 06/10/2011 #1444
        if CurrFieldNo <> 0 then begin
        // >>DITW15.00.00.39 DDR #1444
          // <<DITW15.00.00.38 DDR 24/01/2011 #1255
          if ("Quantity Shipped" <> 0) or ("Quantity Received" <> 0) then
            UpdateCharges(FIELDNO(Quantity),true)
          else
            // <<DITW15.00.00.37 DDR 08/02/2010
            InsertCharges4(FIELDNO(Quantity));
            // >>DITW15.00.00.37 DDR
          // >>DITW15.00.00.38 DDR #1255
          // <<DITW16.00.00.43 DDR 25/09/2013 DIT-715 #519
          if Quantity = 0 then
            DeleteAllChargeTransferLines(Rec,true);
          // >>DITW16.00.00.43 DDR DIT-715 #519
        end;

        // <<DITW15.00.00.38 DDR 21/12/2010 #1171
        UpdateAmount();
        // >>DITW15.00.00.38 DDR #1171
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        if (xRec.Quantity <> Quantity) or (xRec."Quantity (Base)" <> "Quantity (Base)") then
          //UpdateRoutePlanRqstLines(FIELDNO(Quantity));
        //>> DITW110.00.12 AKH NRQ#16026
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure"(Field 5).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo <> 0 then
          TestStatusOpen;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Qty. to Ship"(Field 6).OnValidate". Please convert manually.

        //trigger (Variable: TransferLineItem)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Qty. to Ship"(Field 6).OnValidate". Please convert manually.

        //trigger  to Ship"(Field 6)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetLocation("Transfer-from Code");
        IF CurrFieldNo <> 0 THEN BEGIN
          IF Location."Require Shipment" AND
             ("Qty. to Ship" <> 0)
          THEN
            CheckWarehouse("Transfer-from Code",FALSE);
          WhseValidateSourceLine.TransLineVerifyChange(Rec,xRec);
        end;

        IF "Qty. to Ship" > "Outstanding Quantity" THEN
          IF "Outstanding Quantity" > 0 THEN
            ERROR(
              Text005,
              "Outstanding Quantity")
          else
            ERROR(Text006);
        "Qty. to Ship (Base)" := CalcBaseQty("Qty. to Ship");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW17.10.03 DDR 09/04/2014 DIT-770 #558
        if ("Item Charge No." <> '') and ("Transfer-from Code" = '') then begin
          if TransferLineItem.GET("Document No.","Attached to Line No.") then
            GetLocation(TransferLineItem."Transfer-from Code");
        end else
        // >>DITW17.10.03 DDR DIT-770 #558
          GetLocation("Transfer-from Code");
        if CurrFieldNo <> 0 then begin
          if Location."Require Shipment" and
             ("Qty. to Ship" <> 0)
          then
            CheckWarehouse("Transfer-from Code",false);
          WhseValidateSourceLine.TransLineVerifyChange(Rec,xRec);
        end;

        if "Qty. to Ship" > "Outstanding Quantity" then
          if "Outstanding Quantity" > 0 then
        #12..14
          else
            ERROR(Text006);
        "Qty. to Ship (Base)" := CalcBaseQty("Qty. to Ship");

        // <<DITW15.00.00.37 DDR 08/02/2010 - 31/05/2010 - DITW15.00.00.38 DDR 24/01/2011 #1255
        if (not "Is Item Charge") and ("Item Charge No." = '') then
          UpdateCharges(FIELDNO("Qty. to Ship"),true);
        // >>DITW15.00.00.37 DDR - DITW15.00.00.38 DDR #1255
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Qty. to Receive"(Field 7).OnValidate". Please convert manually.

        //trigger (Variable: TransferLineItem)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Qty. to Receive"(Field 7).OnValidate". Please convert manually.

        //trigger  to Receive"(Field 7)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetLocation("Transfer-to Code");
        IF CurrFieldNo <> 0 THEN BEGIN
          IF Location."Require Receive" AND
             ("Qty. to Receive" <> 0)
          THEN
            CheckWarehouse("Transfer-to Code",TRUE);
          WhseValidateSourceLine.TransLineVerifyChange(Rec,xRec);
        end;

        IF "Qty. to Receive" > "Qty. in Transit" THEN
          IF "Qty. in Transit" > 0 THEN
            ERROR(
              Text008,
              "Qty. in Transit")
          else
            ERROR(Text009);
        "Qty. to Receive (Base)" := CalcBaseQty("Qty. to Receive");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW17.10.03 DDR 09/04/2014 DIT-770 #558
        if ("Item Charge No." <> '') and ("Transfer-to Code" = '') then begin
          if TransferLineItem.GET("Document No.","Attached to Line No.") then
            GetLocation(TransferLineItem."Transfer-to Code");
        end else
        // >>DITW17.10.03 DDR DIT-770 #558
          GetLocation("Transfer-to Code");
        if CurrFieldNo <> 0 then begin
          if Location."Require Receive" and
             ("Qty. to Receive" <> 0)
          then
            CheckWarehouse("Transfer-to Code",true);
          WhseValidateSourceLine.TransLineVerifyChange(Rec,xRec);
        end;

        if "Qty. to Receive" > "Qty. in Transit" then
          if "Qty. in Transit" > 0 then
        #12..14
          else
            ERROR(Text009);
        "Qty. to Receive (Base)" := CalcBaseQty("Qty. to Receive");

        // <<DITW15.00.00.37 DDR 08/02/2010 - 31/05/2010 - 18/06/2010 - DITW15.00.00.38 DDR 24/01/2011 #1255
        if (not "Is Item Charge") and ("Item Charge No." = '') then
          UpdateCharges(FIELDNO("Qty. to Receive"),true);
        // >>DITW15.00.00.37 DDR - DITW15.00.00.38 DDR #1255
        */
        //end;


        //Unsupported feature: CodeInsertion on "Status(Field 10)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.37 DDR 18/06/2010
        if (not "Is Item Charge") and ("Item Charge No." = '') then
          UpdateCharges(FIELDNO(Status),true);
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Prod. Posting Group"(Field 14).OnValidate". Please convert manually.

        //trigger  Prod();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo <> 0 then
          TestStatusOpen;
        // <<DITW18.00.07 DDR 28/02/2016 DIT-770 #1836
        UpdateCharges(FIELDNO("Gen. Prod. Posting Group"),true);
        // >>DITW18.00.07 DDR DIT-770 #1836
        */
        //end;


        //Unsupported feature: CodeModification on ""Inventory Posting Group"(Field 15).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo <> 0 then
          TestStatusOpen;
        */
        //end;


        //Unsupported feature: CodeModification on ""Quantity (Base)"(Field 16).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        TESTFIELD("Qty. per Unit of Measure",1);
        VALIDATE(Quantity,"Quantity (Base)");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo <> 0 then
        #2..4
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Qty. per Unit of Measure"(Field 22)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        UpdateRoutePlanRqstLines(FIELDNO("Qty. per Unit of Measure"));
        //>> DITW110.00.12 AKH NRQ#16026
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure Code"(Field 23).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        TESTFIELD("Quantity Shipped",0);
        TESTFIELD("Qty. Shipped (Base)",0);
        TESTFIELD("Quantity Received",0);
        TESTFIELD("Qty. Received (Base)",0);
        ReserveTransferLine.VerifyChange(Rec,xRec);
        WhseValidateSourceLine.TransLineVerifyChange(Rec,xRec);
        IF "Unit of Measure Code" = '' THEN
          "Unit of Measure" := ''
        else BEGIN
          IF NOT UnitOfMeasure.GET("Unit of Measure Code") THEN
            UnitOfMeasure.INIT;
          "Unit of Measure" := UnitOfMeasure.Description;
        end;
        GetItem;
        VALIDATE("Qty. per Unit of Measure",UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code"));
        "Gross Weight" := Item."Gross Weight" * "Qty. per Unit of Measure";
        "Net Weight" := Item."Net Weight" * "Qty. per Unit of Measure";
        "Unit Volume" := Item."Unit Volume" * "Qty. per Unit of Measure";
        "Units per Parcel" := ROUND(Item."Units per Parcel" / "Qty. per Unit of Measure",0.00001);
        VALIDATE(Quantity);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo <> 0 then
        #2..8
        if "Unit of Measure Code" = '' then
          "Unit of Measure" := ''
        else begin
          if not UnitOfMeasure.GET("Unit of Measure Code") then
            UnitOfMeasure.INIT;
          "Unit of Measure" := UnitOfMeasure.Description;
        end;
        #16..21
        // <<DITW15.00.00.36 DDR 17/12/2009
        "Unit Volume HL" := Item."Unit Volume HL" * "Qty. per Unit of Measure";
        // >>DITW15.00.00.36 DDR
        // <<DITW18.00.06 DDR 03/11/2015 DIT-770 #1395
        "Trsf-to Unit Volume HL" := Item."Unit Volume HL" * "Qty. per Unit of Measure";
        // >>DITW18.00.06 DDR DIT-770 #1395
        // <<DITW15.00.00.38 DDR 14/09/2010 #1217
        "Tariff No." := Item."Tariff No.";

        // <<DITW114.00.15 DDR 08/05/2020 NRQ#145254
        GetDepositValue();
        // >>DITW114.00.15 DDR NRQ#145254
        // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
        if "Item Charge No." = '' then begin
          ItemUnitOfMeasure.GET("Item No.","Unit of Measure Code");
          "Packaging Type Code" := ItemUnitOfMeasure."Packaging Type Code";
          // >>DITW15.00.00.38 DDR
          // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
          if ItemUnitOfMeasure."Packaging Type Code" <> '' then
            ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
          "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
          // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
        end else begin
          "Packaging Type Code" := '';
          "Pack Qty. per Unit of Measure" := 0;
        end;
        // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
        // <<DITW18.00.06 DDR 29/10/2015 DIT-770 #1412
        if "Tax Item No." = '' then
          VALIDATE("Packaging Type Code");
        // >>DITW18.00.06 DDR DIT-770 #1412

        // <<DITW15.00.00.38 DDR 17/12/2010 #703
        if ("Item Charge Type" = "Item Charge Type"::Tax) and ("Tax Item No." <> '') then begin
          Item.GET("Tax Item No.");
          // <<DITW16.00.00.43 DDR 20/12/2013 DIT-715 #864
          "Qty. per Unit of Measure" := 1;
          // >>DITW16.00.00.43 DDR DIT-715 #864
          "Gross Weight" := Item."Gross Weight" * "Qty. per Unit of Measure";
          "Net Weight" := Item."Net Weight" * "Qty. per Unit of Measure";
          "Unit Volume" := Item."Unit Volume" * "Qty. per Unit of Measure";
          "Units per Parcel" := ROUND(Item."Units per Parcel" / "Qty. per Unit of Measure",0.00001);
          // <<DITW18.00.06 DDR 03/11/2015 DIT-770 #1395
          if "Transfer-from Code" <> '' then
            "Unit Volume HL" := Item."Unit Volume HL" * "Qty. per Unit of Measure";
          if "Transfer-to Code" <> '' then
            "Trsf-to Unit Volume HL" := Item."Unit Volume HL" * "Qty. per Unit of Measure";
          // >>DITW18.00.06 DDR DIT-770 #1395
          "Tariff No." := Item."Tariff No.";
          // <<DITW16.00.00.43 DDR 01/10/2013 DIT-715 #519
          ItemUnitOfMeasure.GET(Item."No.","Unit of Measure Code");
          // >>DITW16.00.00.43 DDR DIT-715 #519
          // <<DITW18.00.06 DDR 29/10/2015 DIT-770 #1412
          "Packaging Type Code" := ItemUnitOfMeasure."Packaging Type Code";
          // >>DITW18.00.06 DDR DIT-770 #1412
          if ItemUnitOfMeasure."Packaging Type Code" <> '' then
            ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
          "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
        end;
        // >>DITW15.00.00.38 DDR #703

        // <<DITW15.00.00.39 DDR 06/10/2011 #1444
        if CurrFieldNo <> 0 then
        // >>DITW15.00.00.39 DDR #1444
          // <<DITW15.00.00.37 DDR 08/02/2010
          InsertCharges4(FIELDNO("Unit of Measure Code"));
          // >>DITW15.00.00.37 DDR

        VALIDATE(Quantity);
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Outstanding Quantity"(Field 24)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.37 DDR 04/02/2010
        CalcCubageWeight();
        */
        //end;


        //Unsupported feature: CodeModification on ""Variant Code"(Field 30).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        ReserveTransferLine.VerifyChange(Rec,xRec);
        WhseValidateSourceLine.TransLineVerifyChange(Rec,xRec);

        IF "Variant Code" = '' THEN
          EXIT;

        GetDefaultBin("Transfer-from Code","Transfer-to Code");
        ItemVariant.GET("Item No.","Variant Code");
        Description := ItemVariant.Description;
        "Description 2" := ItemVariant."Description 2";

        CheckItemAvailable(FIELDNO("Variant Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo <> 0 then
        #2..5
        if "Variant Code" = '' then
          exit;
        #8..14

        // << DITW110.00.11 SFI 30/08/2017 BL#14417
        GetDepositValue();
        // >> DITW110.00.11 SFI BL#14417

        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        // TODO SF: Check if also "Transfer-to Code" should be checked
        GetItem;
        Item.BlockedSKU("Transfer-from Code","Variant Code",true);
        Item.BlockedSKU("Transfer-to Code","Variant Code",true);
        // >> DITW110.00.11 SFI BL#30569
        // <<DITW15.00.00.39 DDR 06/10/2011 #1444
        if CurrFieldNo <> 0 then
        // >>DITW15.00.00.39 DDR #1444
          // <<DITW15.00.00.37 DDR 08/02/2010
          InsertCharges4(FIELDNO("Variant Code"));
          // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Transfer-from Code"(Field 36).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Quantity Shipped",0);
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        IF "Transfer-from Code" <> xRec."Transfer-from Code" THEN BEGIN
          "Transfer-from Bin Code" := '';
          GetDefaultBin("Transfer-from Code",'');
        end;

        CheckItemAvailable(FIELDNO("Transfer-from Code"));
        ReserveTransferLine.VerifyChange(Rec,xRec);
        UpdateWithWarehouseShipReceive;
        WhseValidateSourceLine.TransLineVerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Quantity Shipped",0);
        if CurrFieldNo <> 0 then
          //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
          //TestStatusOpen;
          //>> DITW110.00.12 AKH NRQ#16026
        if "Transfer-from Code" <> xRec."Transfer-from Code" then begin
          "Transfer-from Bin Code" := '';
          GetDefaultBin("Transfer-from Code",'');
        end;

        // <<DITW15.00.00.30 DDR 09/01/2009
        CheckCombLocationBins();
        // >>DITW15.00.00.30 DDR
        #8..12

        // <<DITW15.00.00.37 DDR 28/05/2010
        // <<DITW15.00.00.38 DDR 22/12/2010 #1217 (DIT711 103)
        CLEAR(Location);
        if "Transfer-from Code" <> '' then
          GetLocation("Transfer-from Code");
        // >>DITW15.00.00.38 DDR #1217 (DIT711 103)
        "Transf.-from Location Gr. Code" := Location."Location Group Code";
        "Trsf-from Ph. Location Gr Code" := Location."Physical Location Group Code";
        // >>DITW15.00.00.37 DDR

        // <<DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457
        if Location."Work Order Mandatory" then begin
          if (TransHeader."No." <> "Document No.") then
            TransHeader.GET("Document No.");
          TransHeader.TESTFIELD("Work Order No.");
          if (Location."W.Order Alloc. Location Code" <> '') and
            (Location."W.Order Alloc. Location Code" <> "Transfer-to Code")
          then begin
            "Trsf-to Ph. Location Gr Code" := '';
            "Transf.-to Location Gr. Code" := '';
            VALIDATE("Transfer-to Code",Location."W.Order Alloc. Location Code");
          end;
        end;
        // >>DITW16.00.00.41 DDR DIT-715 #457

        // >>DITW110.00.09 DDR NRQ#16737
        if ("Transfer-from Code" <> xRec."Transfer-from Code") and (CurrFieldNo <> 0) then
          "Relation Transfer-from Code" := '';
        // >>DITW110.00.09 DDR NRQ#16737
        // << DITW110.00.11 SFI 30/08/2017 BL#14417
        GetDepositValue();
        // >> DITW110.00.11 SFI BL#14417

        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        // TODO SF: Check if also "Transfer-to Code" should be checked
        GetItem;
        Item.BlockedSKU("Transfer-from Code","Variant Code",true);
        Item.BlockedSKU("Transfer-to Code","Variant Code",true);
        // >> DITW110.00.11 SFI BL#30569

        // <<DITW15.00.00.39 DDR 06/10/2011 #1444
        if CurrFieldNo <> 0 then
        // >>DITW15.00.00.39 DDR #1444
          // <<DITW15.00.00.37 DDR 08/02/2010
          InsertCharges4(FIELDNO("Transfer-from Code"));
          // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Transfer-to Code"(Field 37).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Quantity Shipped",0);
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        IF "Transfer-to Code" <> xRec."Transfer-to Code" THEN BEGIN
          "Transfer-To Bin Code" := '';
          GetDefaultBin('',"Transfer-to Code");
        end;

        ReserveTransferLine.VerifyChange(Rec,xRec);
        UpdateWithWarehouseShipReceive;
        WhseValidateSourceLine.TransLineVerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Quantity Shipped",0);
        if CurrFieldNo <> 0 then
          //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
          //TestStatusOpen;
          //>> DITW110.00.12 AKH NRQ#16026
        if "Transfer-to Code" <> xRec."Transfer-to Code" then begin
          "Transfer-To Bin Code" := '';
          GetDefaultBin('',"Transfer-to Code");
        end;

        // <<DITW15.00.00.30 DDR 09/01/2009
        CheckCombLocationBins();
        // >>DITW15.00.00.30 DDR
        #8..11

        // <<DITW15.00.00.37 DDR 28/05/2010
        // <<DITW15.00.00.38 DDR 22/12/2010 #1217 (DIT711 103)
        CLEAR(Location);
        if "Transfer-to Code" <> '' then
          GetLocation("Transfer-to Code");
        // >>DITW15.00.00.38 DDR #1217 (DIT711 103)
        "Transf.-to Location Gr. Code" := Location."Location Group Code";
        "Trsf-to Ph. Location Gr Code" := Location."Physical Location Group Code";
        // >>DITW15.00.00.37 DDR

        // <<DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457
        if Location."Work Order Mandatory" then begin
          if (TransHeader."No." <> "Document No.") then
            TransHeader.GET("Document No.");
          TransHeader.TESTFIELD("Work Order No.");
        end;
        // >>DITW16.00.00.41 DDR DIT-715 #457

        // <<DITW15.00.00.39 DDR 06/10/2011 #1444
        if CurrFieldNo <> 0 then
        // >>DITW15.00.00.39 DDR #1444
          // <<DITW15.00.00.37 DDR 08/02/2010
          InsertCharges4(FIELDNO("Transfer-to Code"));
          // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipment Date"(Field 38).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        TransferRoute.CalcReceiptDate("Shipment Date","Receipt Date",
          "Shipping Time","Outbound Whse. Handling Time","Inbound Whse. Handling Time",
          "Transfer-from Code","Transfer-to Code","Shipping Agent Code","Shipping Agent Service Code");
        CheckItemAvailable(FIELDNO("Shipment Date"));
        DateConflictCheck;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo <> 0 then
        #2..7
        // <<DITW15.00.00.37 DDR 08/02/2010 - 04/01/2011 #1217 (DIT711 103)
        UpdateCharges(FIELDNO("Shipment Date"),true);
        // >>DITW15.00.00.38 DDR #1217 (DIT711 103)
        */
        //end;


        //Unsupported feature: CodeModification on ""Receipt Date"(Field 39).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        TransferRoute.CalcShipmentDate("Shipment Date","Receipt Date",
          "Shipping Time","Outbound Whse. Handling Time","Inbound Whse. Handling Time",
          "Transfer-from Code","Transfer-to Code","Shipping Agent Code","Shipping Agent Service Code");
        CheckItemAvailable(FIELDNO("Shipment Date"));
        DateConflictCheck;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo <> 0 then
        #2..7
        // <<DITW15.00.00.37 DDR 08/02/2010 - 04/01/2011 #1217 (DIT711 103)
        UpdateCharges(FIELDNO("Receipt Date"),true);
        // >>DITW15.00.00.38 DDR #1217 (DIT711 103)
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Agent Code"(Field 41).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        IF "Shipping Agent Code" <> xRec."Shipping Agent Code" THEN
          VALIDATE("Shipping Agent Service Code",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo <> 0 then
          //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
          //TestStatusOpen;
          //>> DITW110.00.12 AKH NRQ#16026
        if "Shipping Agent Code" <> xRec."Shipping Agent Code" then
          VALIDATE("Shipping Agent Service Code",'');
        // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        if (not "Is Item Charge") and ("Item Charge No." = '') then
          UpdateCharges(FIELDNO("Shipping Agent Code"),true);
        // >>DITW16.00.00.43 DDR DIT-715 #768
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Agent Service Code"(Field 42).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        TransferRoute.GetShippingTime(
          "Transfer-from Code","Transfer-to Code",
          "Shipping Agent Code","Shipping Agent Service Code",
        #6..8
          "Transfer-from Code","Transfer-to Code","Shipping Agent Code","Shipping Agent Service Code");
        CheckItemAvailable(FIELDNO("Shipping Agent Service Code"));
        DateConflictCheck;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo <> 0 then
          //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
          //TestStatusOpen;
          //>> DITW110.00.12 AKH NRQ#16026
        #3..11
        // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        if (not "Is Item Charge") and ("Item Charge No." = '') then
          UpdateCharges(FIELDNO("Shipping Agent Service Code"),true);
        // >>DITW16.00.00.43 DDR DIT-715 #768
        */
        //end;


        //Unsupported feature: CodeModification on ""Appl.-to Item Entry"(Field 43).OnValidate". Please convert manually.

        //trigger -to Item Entry"(Field 43)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Appl.-to Item Entry" <> 0 THEN BEGIN
          TESTFIELD(Quantity);
          ItemLedgEntry.GET("Appl.-to Item Entry");
          ItemLedgEntry.TESTFIELD(Positive,TRUE);
          IF (ItemLedgEntry."Lot No." <> '') OR (ItemLedgEntry."Serial No." <> '') THEN
            ERROR(MustUseTrackingErr,ItemTrackingLines.CAPTION,FIELDCAPTION("Appl.-to Item Entry"));
          IF ABS("Qty. to Ship (Base)") > ItemLedgEntry.Quantity THEN
            ERROR(ShippingMoreUnitsThanReceivedErr,ItemLedgEntry.Quantity,ItemLedgEntry."Document No.");

          ItemLedgEntry.TESTFIELD("Location Code","Transfer-from Code");
          IF NOT ItemLedgEntry.Open THEN
            MESSAGE(LedgEntryWillBeOpenedMsg,"Appl.-to Item Entry");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Appl.-to Item Entry" <> 0 then begin
          TESTFIELD(Quantity);
          ItemLedgEntry.GET("Appl.-to Item Entry");
          ItemLedgEntry.TESTFIELD(Positive,true);
          if (ItemLedgEntry."Lot No." <> '') or (ItemLedgEntry."Serial No." <> '') then
            ERROR(MustUseTrackingErr,ItemTrackingLines.CAPTION,FIELDCAPTION("Appl.-to Item Entry"));
          if ABS("Qty. to Ship (Base)") > ItemLedgEntry.Quantity then
        #8..10
          if not ItemLedgEntry.Open then
            MESSAGE(LedgEntryWillBeOpenedMsg,"Appl.-to Item Entry");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Time"(Field 54).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        TransferRoute.CalcReceiptDate("Shipment Date","Receipt Date",
          "Shipping Time","Outbound Whse. Handling Time","Inbound Whse. Handling Time",
          "Transfer-from Code","Transfer-to Code","Shipping Agent Code","Shipping Agent Service Code");
        DateConflictCheck;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo <> 0 then
          //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
          //TestStatusOpen;
          //>> DITW110.00.12 AKH NRQ#16026
        #3..6
        */
        //end;


        //Unsupported feature: CodeModification on ""Outbound Whse. Handling Time"(Field 5793).OnValidate". Please convert manually.

        //trigger  Handling Time"(Field 5793)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        TransferRoute.CalcReceiptDate("Shipment Date","Receipt Date",
          "Shipping Time","Outbound Whse. Handling Time","Inbound Whse. Handling Time",
          "Transfer-from Code","Transfer-to Code","Shipping Agent Code","Shipping Agent Service Code");
        DateConflictCheck;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo <> 0 then
        #2..6
        */
        //end;


        //Unsupported feature: CodeModification on ""Inbound Whse. Handling Time"(Field 5794).OnValidate". Please convert manually.

        //trigger  Handling Time"(Field 5794)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo <> 0 THEN
          TestStatusOpen;
        TransferRoute.CalcReceiptDate("Shipment Date","Receipt Date",
          "Shipping Time","Outbound Whse. Handling Time","Inbound Whse. Handling Time",
          "Transfer-from Code","Transfer-to Code","Shipping Agent Code","Shipping Agent Service Code");
        DateConflictCheck;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo <> 0 then
        #2..6
        */
        //end;


        //Unsupported feature: CodeModification on ""Transfer-from Bin Code"(Field 7300).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Transfer-from Bin Code" <> xRec."Transfer-from Bin Code" THEN BEGIN
          TESTFIELD("Transfer-from Code");
          IF "Transfer-from Bin Code" <> '' THEN BEGIN
            GetLocation("Transfer-from Code");
            Location.TESTFIELD("Bin Mandatory");
            Location.TESTFIELD("Directed Put-away and Pick",FALSE);
            GetBin("Transfer-from Code","Transfer-from Bin Code");
            TESTFIELD("Transfer-from Code",Bin."Location Code");
            HandleDedicatedBin(TRUE);
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Transfer-from Bin Code" <> xRec."Transfer-from Bin Code" then begin
          TESTFIELD("Transfer-from Code");
          if "Transfer-from Bin Code" <> '' then begin
            GetLocation("Transfer-from Code");
            Location.TESTFIELD("Bin Mandatory");
            Location.TESTFIELD("Directed Put-away and Pick",false);
            GetBin("Transfer-from Code","Transfer-from Bin Code");
            TESTFIELD("Transfer-from Code",Bin."Location Code");
            HandleDedicatedBin(true);
            // <<DITW15.00.00.37 DDR 08/02/2010
            if Location."Directed Put-away and Pick" then
              CheckBinCubageWeight(xRec.Cubage,xRec.Weight);
            // >>DITW15.00.00.37 DDR
          end;
        end;

        // <<DITW15.00.00.30 DDR 09/01/2009
        CheckCombLocationBins();
        // >>DITW15.00.00.30 DDR

        // <<DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457
        GetBin("Transfer-from Code","Transfer-from Bin Code");
        if Bin."Work Order Mandatory" then begin
          if (TransHeader."No." <> "Document No.") then
            TransHeader.GET("Document No.");
          TransHeader.TESTFIELD("Work Order No.");
        end;
        // >>DITW16.00.00.41 DDR DIT-715 #457

        // <<DITW15.00.00.39 DDR 06/10/2011 #1444
        if CurrFieldNo <> 0 then
        // >>DITW15.00.00.39 DDR #1444
          // <<DITW15.00.00.37 DDR 08/02/2010
          InsertCharges4(FIELDNO("Transfer-from Bin Code"));
          // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Transfer-To Bin Code"(Field 7301).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Transfer-To Bin Code" <> xRec."Transfer-To Bin Code" THEN BEGIN
          TESTFIELD("Transfer-to Code");
          IF "Transfer-To Bin Code" <> '' THEN BEGIN
            GetLocation("Transfer-to Code");
            Location.TESTFIELD("Bin Mandatory");
            Location.TESTFIELD("Directed Put-away and Pick",FALSE);
            GetBin("Transfer-to Code","Transfer-To Bin Code");
            TESTFIELD("Transfer-to Code",Bin."Location Code");
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Transfer-To Bin Code" <> xRec."Transfer-To Bin Code" then begin
          TESTFIELD("Transfer-to Code");
          if "Transfer-To Bin Code" <> '' then begin
            GetLocation("Transfer-to Code");
            Location.TESTFIELD("Bin Mandatory");
            Location.TESTFIELD("Directed Put-away and Pick",false);
            GetBin("Transfer-to Code","Transfer-To Bin Code");
            TESTFIELD("Transfer-to Code",Bin."Location Code");
          end;
        end;

        // <<DITW15.00.00.30 DDR 09/01/2009
        CheckCombLocationBins();
        // >>DITW15.00.00.30 DDR

        // <<DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457
        GetBin("Transfer-to Code","Transfer-To Bin Code");
        if Bin."Work Order Mandatory" then begin
          if (TransHeader."No." <> "Document No.") then
            TransHeader.GET("Document No.");
          TransHeader.TESTFIELD("Work Order No.");
        end;
        // >>DITW16.00.00.41 DDR DIT-715 #457

        // <<DITW15.00.00.39 DDR 06/10/2011 #1444
        if CurrFieldNo <> 0 then
        // >>DITW15.00.00.39 DDR #1444
          // <<DITW15.00.00.37 DDR 08/02/2010
          InsertCharges4(FIELDNO("Transfer-from Bin Code"));
          // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Planning Flexibility"(Field 99000755).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Planning Flexibility" <> xRec."Planning Flexibility" THEN
          ReserveTransferLine.UpdatePlanningFlexibility(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Planning Flexibility" <> xRec."Planning Flexibility" then
          ReserveTransferLine.UpdatePlanningFlexibility(Rec);
        */
        //end;
        field(50000; "Whse. Receipt No. (Open) FND"; Code[20])
        {

            CalcFormula = Lookup("Warehouse Receipt Line"."No." where("Source Type" = CONST(5741),
                                                                       "Source No." = FIELD("Document No."),
                                                                       "Source Line No." = FIELD("Line No.")));
            CaptionML = ENU = 'Whse. Receipt No. (Open)',
                        FRA = 'N° réception magasin (Ouvert)';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Warehouse Receipt Header";
        }
        field(50001; "RPM Solution FND"; Option)
        {
            Caption = 'RPM Solution';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Editable = false;
            OptionCaption = '" ,Deposit,Full-for-Empty with revenue impact (FFE with revenue),Full-for Empty without revenue impact (FFE w/o revenue)"';
            OptionMembers = " ",Deposit,"Full-for-Empty with revenue impact (FFE with revenue)","Full-for Empty without revenue impact (FFE w/o revenue)";
        }
        field(50002; "RPM Type FND"; Code[20])
        {
            caption = 'RPM Type';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Editable = false;
            TableRelation = "Return Pack Material Type FND".Code;
        }
        field(50003; "Item Type FND"; Option)
        {
            Caption = 'Item Type';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Editable = false;
            OptionCaption = '" ,RPM Related,Product Related"';
            OptionMembers = " ","RPM Related","Product Related";
        }

        //---BC Upgrade KAMNAY01>> DITW
        // field(2013612;"Item Charge Quantity per";Decimal)
        // {
        //     CaptionML = ENU='Item Charge Quantity per',
        //                 FRA='Quantité frais annexes par';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.38 #703';
        //     MinValue = 0;
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
        //     Description = 'DITW15.00.00.37';
        //     OptionCaptionML = ENU=' ,Amount,Price %,Amount %,Fixed Amount,Volume /Unit,Weight,Cubage,Distance,Sales Price',
        //                       FRA=' ,Montant,Prix %,Montant %,Montant Fixe,Volume /Unit,Poids,Cubage,Distance,Prix vente';
        //     OptionMembers = " ",Amount,"Price %","Amount %","Fixed Amount",VolumeHL,Weight,Cubage,Distance,"Price Item";
        // }
        // field(2013661;"Item Charge Value";Decimal)
        // {
        //     AutoFormatExpression = GetAutoformatRoundingType('');
        //     AutoFormatType = 2;
        //     CaptionML = ENU='Item Charge Value',
        //                 FRA='Valeur frais annexes';
        //     Description = 'DITW15.00.00.37';
        // }
        // field(2013662;"Is Item Charge";Boolean)
        // {
        //     CaptionML = ENU='Is Item Charge',
        //                 FRA='Est frais annexes';
        //     Description = 'DITW15.00.00.37';
        // }
        // field(2013663;"ItemCharge Incl. Price";Boolean)
        // {
        //     CaptionML = ENU='Item Charge Incl. Price',
        //                 FRA='Frais annexe inclus prix';
        //     Description = 'DITW15.00.00.37';
        // }
        // field(2013664;"Item Charge Discount %";Decimal)
        // {
        //     CaptionML = ENU='Item Charge Discount %',
        //                 FRA='Remise frais annexes %';
        //     Description = 'DITW15.00.00.37';
        // }
        // field(2013665;"Allow Item Charge Line Disc.";Boolean)
        // {
        //     CaptionML = ENU='Allow Item Charge Line Discount',
        //                 FRA='Frais annexes remise ligne autorisé';
        //     Description = 'DITW15.00.00.37';
        //     InitValue = true;
        // }
        // field(2013667;"Item DTax Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Tax Group Code',
        //                 FRA='Code groupe taxe article';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Item));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 04/02/2010
        //         TestStatusOpen;
        //         // <<DITW15.00.00.38 DDR 20/08/2010 #1217
        //         UpdateAADInfo();
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2013694;"Opposite Amount Sign";Boolean)
        // {
        //     CaptionML = ENU='Opposite Amount Sign',
        //                 FRA='Signe opposé montant';
        //     Description = 'DITW15.00.00.37';
        // }
        // field(2013695;"Item Charge Type";Option)
        // {
        //     CaptionML = ENU='Item Charge Type',
        //                 FRA='Type frais annexes';
        //     Description = 'DITW15.00.00.37';
        //     OptionCaptionML = ENU=' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA=' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        // }
        // field(2013696;"Transf.-from Location Gr. Code";Code[10])
        // {
        //     CaptionML = ENU='Transfer-from Location Tax Group Code',
        //                 FRA='Transfer du Code groupe magasin taxe';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Location Group";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 31/05/2010
        //         UpdateCharges(FIELDNO("Transf.-from Location Gr. Code"),true);
        //     end;
        // }
        // field(2013708;"Due Tax";Boolean)
        // {
        //     CaptionML = ENU='Due Tax',
        //                 FRA='Taxe due';
        //     Description = 'DITW15.00.00.37';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 04/02/2010
        //         TestStatusOpen;
        //         TESTFIELD("Item Charge Type","Item Charge Type"::Tax);
        //         // <<DITW15.00.00.38 DDR 20/08/2010 #1217
        //         TestDutySuspendMandatory();
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2013715;"Tax Formula";Code[80])
        // {
        //     CaptionML = ENU='Tax Formula',
        //                 FRA='Formule taxe';
        //     Description = 'DITW15.00.00.37';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 04/02/2010
        //         TESTFIELD("Item Charge Type","Item Charge Type"::Tax);
        //     end;
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
        //         // <<DITW19.00.08 DDR 17/08/2016 14/11/2016 BL#10443
        //         TestStatusOpen;
        //         TESTFIELD("Item No.");
        //     end;
        // }
        // field(2013717;"Strength Spec. Value";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CalcFormula = Average("Reservation Entry"."Strength Spec. Value" WHERE ("Source Type"=CONST(5741),
        //                                                                             "Source Subtype"=CONST("0"),
        //                                                                             "Source ID"=FIELD("Document No."),
        //                                                                             "Source Batch Name"=FILTER(''),
        //                                                                             "Source Prod. Order Line"=FIELD("Derived From Line No."),
        //                                                                             "Source Ref. No."=FIELD("Line No.")));
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("Strength Spec. Value"));
        //     CaptionML = ENU='Strength Spec. Value',
        //                 FRA='Valeur contrainte spécification';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013718;"Vol-Strength Spec. Code";Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0,FIELDNO("Vol-Strength Spec. Code"));
        //     CaptionML = ENU='Vol-Strength Spec. Code',
        //                 FRA='Code spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" WHERE (Type=CONST(Specification));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 17/08/2016 14/11/2016 BL#10443
        //         TestStatusOpen;
        //     end;
        // }
        // field(2013719;"Vol-Strength Spec. Value";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Vol-Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CalcFormula = Sum("Reservation Entry"."Vol-Strength Spec. Value" WHERE ("Source Type"=CONST(5741),
        //                                                                             "Source Subtype"=CONST("0"),
        //                                                                             "Source ID"=FIELD("Document No."),
        //                                                                             "Source Batch Name"=FILTER(''),
        //                                                                             "Source Prod. Order Line"=FIELD("Derived From Line No."),
        //                                                                             "Source Ref. No."=FIELD("Line No.")));
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("Vol-Strength Spec. Value"));
        //     CaptionML = ENU='Vol-Strength Spec. Value',
        //                 FRA='Valeur spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013720;"Trsf-To Strength Value";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Trsf-To Strength Value"));
        //     AutoFormatType = 2013664;
        //     CalcFormula = Average("Reservation Entry"."Strength Spec. Value" WHERE ("Source Type"=CONST(5741),
        //                                                                             "Source Subtype"=CONST("1"),
        //                                                                             "Source ID"=FIELD("Document No."),
        //                                                                             "Source Batch Name"=FILTER(''),
        //                                                                             "Source Prod. Order Line"=FIELD("Derived From Line No."),
        //                                                                             "Source Ref. No."=FIELD("Line No.")));
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("Trsf-To Strength Value"));
        //     CaptionML = ENU='Transfer-To Strength Spec. Value',
        //                 FRA='Transfert à valeur spécification contrainte';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 17/08/2016 29/09/2016 14/11/2016 BL#10443
        //     end;
        // }
        // field(2013721;"Trsf-To Vol-Strength Value";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Trsf-To Vol-Strength Value"));
        //     AutoFormatType = 2013664;
        //     CalcFormula = Sum("Reservation Entry"."Vol-Strength Spec. Value" WHERE ("Source Type"=CONST(5741),
        //                                                                             "Source Subtype"=CONST("1"),
        //                                                                             "Source ID"=FIELD("Document No."),
        //                                                                             "Source Batch Name"=FILTER(''),
        //                                                                             "Source Prod. Order Line"=FIELD("Derived From Line No."),
        //                                                                             "Source Ref. No."=FIELD("Line No.")));
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("Trsf-To Vol-Strength Value"));
        //     CaptionML = ENU='Transfer-To Vol-Strength Spec. Value',
        //                 FRA='Transfert à valeur spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 17/08/2016 29/09/2016 14/11/2016 BL#10443
        //     end;
        // }
        // field(2013722;"Duty Suspended";Boolean)
        // {
        //     CaptionML = ENU='Duty Suspended',
        //                 FRA='Taxe en suspension';
        //     Description = 'DITW15.00.00.37';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 04/02/2010
        //         TESTFIELD("Item Charge Type","Item Charge Type"::Tax);
        //         // <<DITW15.00.00.38 DDR 20/08/2010 #1217
        //         TestDutySuspendMandatory();
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2013726;"Company Tax Registration No.";Text[20])
        // {
        //     CaptionML = ENU='Company Tax Registration No.',
        //                 FRA='N° identif. accise société';
        //     Description = 'DITW15.00.00.36';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.36 DDR 17/12/2009
        //         TestStatusOpen;
        //         // <<DITW15.00.00.38 DDR 20/08/2010 #1217
        //         TestTaxRegMandatory();
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2013727;"AAD No. Series - Shipment";Code[10])
        // {
        //     CaptionML = ENU='AAD No. Series',
        //                 FRA='Souches de n° DAA';
        //     Description = 'DITW15.00.00.36';
        //     TableRelation = "No. Series";

        //     trigger OnLookup();
        //     var
        //         lrTempTransLine : Record "Transfer Line" temporary;
        //         lDefaultAADCode : Code[10];
        //     begin
        //         // <<DITW15.00.00.38 DDR 11/03/2011 #703
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW15.00.00.38 DDR #703
        //         // <<DITW15.00.00.36 DDR 17/12/2009
        //         with lrTempTransLine do begin
        //           lrTempTransLine := Rec;
        //           lDefaultAADCode := GetAADNoSeries();
        //           if NoSeriesMgt.LookupSeries(lDefaultAADCode,"AAD No. Series - Shipment") then
        //             VALIDATE("AAD No. Series - Shipment");
        //           Rec := lrTempTransLine;
        //         end;
        //     end;

        //     trigger OnValidate();
        //     var
        //         lDefaultAADCode : Code[10];
        //     begin
        //         // <<DITW15.00.00.36 DDR 17/12/2009
        //         TestStatusOpen;

        //         // <<DITW15.00.00.38 DDR 11/03/2011 #703
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW15.00.00.38 DDR #703

        //         if "AAD No. Series - Shipment" <> '' then begin
        //           lDefaultAADCode := GetAADNoSeries();
        //           if lDefaultAADCode <> '' then
        //             NoSeriesMgt.TestSeries(lDefaultAADCode,"AAD No. Series - Shipment");
        //           // <<DITW15.00.00.37 DDR 31/05/2010 - DITW15.00.00.38 DDR 20/08/2010 #1217
        //           TestAADNoSeriesMandatory();
        //           // >>DITW15.00.00.38 DDR
        //         end;
        //         TESTFIELD("AAD No. - Shipment",'');
        //     end;
        // }
        // field(2013728;"AAD No. - Shipment";Code[20])
        // {
        //     CaptionML = ENU='AAD No. - Shipment',
        //                 FRA='N° DAA - Expédition';
        //     Description = 'DITW15.00.00.36';

        //     trigger OnValidate();
        //     var
        //         lrNoSeries : Record "No. Series";
        //         lrTempTransLine : Record "Transfer Line" temporary;
        //     begin
        //         // <<DITW15.00.00.36 DDR 17/12/2009 - DITW15.00.00.37 DDR 28/05/2010
        //         TestStatusOpen;

        //         // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //         if CurrFieldNo = FIELDNO("AAD No. - Shipment") then
        //           TESTFIELD("Applies-to AAD Trck. Entry No.",0);
        //         // >>DITW15.00.00.39 DDR #1369

        //         // <<DITW15.00.00.38 DDR 11/03/2011 #703
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW15.00.00.38 DDR #703

        //         if "AAD No. - Shipment" <> xRec."AAD No. - Shipment" then begin
        //           NoSeriesMgt.TestManual("AAD No. Series - Shipment");
        //           "AAD No. Series - Shipment" := '';
        //         end;

        //         if "AAD No. - Shipment" <> '' then begin
        //           AADDocMgt.CheckAADNo("AAD No. - Shipment");
        //           if "AAD No. Series - Shipment" <> '' then
        //             lrNoSeries.GET("AAD No. - Shipment")
        //           else
        //             lrNoSeries."Manual Nos." := true;

        //           if lrNoSeries."Manual Nos." then begin
        //             TESTFIELD("AAD No. - Receipt",'');
        //             "AAD No. - Receipt" := "AAD No. - Shipment";
        //           end;

        //           // <<DITW15.00.00.37 DDR 31/05/2010 - DITW15.00.00.38 DDR 20/08/2010 #1217
        //           TestAADNoSeriesMandatory();
        //           // >>DITW15.00.00.38 DDR
        //         end;
        //     end;
        // }
        // field(2013729;"Tariff No.";Code[10])
        // {
        //     CaptionML = ENU='Tariff No.',
        //                 FRA='Nomenclature produits';
        //     Description = 'DITW15.00.00.36';
        //     TableRelation = "Tariff Number";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.36 DDR 17/12/2009
        //         TestStatusOpen;
        //     end;
        // }
        // field(2013731;"Applies-to AAD Trck. Entry No.";Integer)
        // {
        //     CaptionML = ENU='Applies-to Correction AAD Trck. Entry No.',
        //                 FRA='N° Ecriture correction suivi DAA lettrage';
        //     Description = 'DITW15.00.00.39 #1369';
        //     TableRelation = "AAD Tracking Entry"."Entry No." WHERE ("Entry Type"=CONST(Outbound),
        //                                                             "Source Type"=CONST(Location),
        //                                                             "Source No."=FIELD("Transfer-to Code"));

        //     trigger OnLookup();
        //     var
        //         AADTrackingEntry : Record "AAD Tracking Entry";
        //     begin
        //         // <<DITW16.00.00.39 DDR 05/08/2011 DIT-715 #148
        //         AADTrackingEntry.SETRANGE("Entry Type",AADTrackingEntry."Entry Type"::Outbound);
        //         AADTrackingEntry.SETRANGE("Source Type",AADTrackingEntry."Source Type"::Location);
        //         AADTrackingEntry.SETRANGE("Source No.","Transfer-to Code");
        //         AADTrackingEntry."Entry No." := "Applies-to AAD Trck. Entry No.";
        //         if PAGE.RUNMODAL(0,AADTrackingEntry) = ACTION::LookupOK then
        //           VALIDATE("Applies-to AAD Trck. Entry No.",AADTrackingEntry."Entry No.");
        //     end;

        //     trigger OnValidate();
        //     var
        //         AADTrackingEntry : Record "AAD Tracking Entry";
        //     begin
        //         TESTFIELD("Item No.");
        //         TestStatusOpen;

        //         if "Applies-to AAD Trck. Entry No." <> 0 then begin
        //           TESTFIELD("LRN No. - Shipment",'');
        //           AADTrackingEntry.GET("Applies-to AAD Trck. Entry No.");
        //           "AAD No. Series - Shipment" := '';
        //           "AAD No. - Shipment" := AADTrackingEntry."AAD No.";
        //           "LRN No. Series - Shipment" := '';
        //           "ARC No. - Shipment" := AADTrackingEntry."ARC No.";
        //           "ARC No. Mandatory - Shipment" := false;
        //           "AAD No. - Receipt" := '';
        //           "ARC No. - Receipt" := '';
        //           "ARC No. Mandatory - Receipt" := false;
        //         end else begin
        //           "AAD No. - Shipment" := '';
        //           "ARC No. - Shipment" := '';
        //           "AAD No. - Receipt" := '';
        //           "ARC No. - Receipt" := '';
        //           UpdateAADInfo();
        //         end;
        //     end;
        // }
        // field(2013757;"AAD No. - Receipt";Code[20])
        // {
        //     CaptionML = ENU='AAD No. - Receipt',
        //                 FRA='N° DAA - Réception';
        //     Description = 'DITW15.00.00.36';

        //     trigger OnValidate();
        //     var
        //         lrNoSeries : Record "No. Series";
        //     begin
        //         // <<DITW15.00.00.36 DDR 17/12/2009
        //         TestStatusOpen;

        //         // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //         if CurrFieldNo = FIELDNO("AAD No. - Receipt") then
        //           TESTFIELD("Applies-to AAD Trck. Entry No.",0);
        //         // >>DITW15.00.00.39 DDR #1369

        //         // <<DITW15.00.00.38 DDR 11/03/2011 #703
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW15.00.00.38 DDR #703

        //         // later
        //         /*
        //         IF "AAD No. - Receipt" <> xRec."AAD No. - Receipt" THEN BEGIN
        //           NoSeriesMgt.TestManual("AAD No. Series - Receipt");
        //           "AAD No. Series - Receipt" := '';
        //         end;
        //         */
        //         if "AAD No. - Receipt" <> '' then begin
        //           AADDocMgt.CheckAADNo("AAD No. - Receipt");

        //           // <<DITW15.00.00.37 DDR 28/05/2010
        //           if "AAD No. Series - Shipment" <> '' then
        //             lrNoSeries.GET("AAD No. - Shipment")
        //           else
        //             lrNoSeries."Manual Nos." := true;

        //           if not lrNoSeries."Manual Nos." and
        //             (CurrFieldNo = FIELDNO("AAD No. - Receipt"))
        //           then
        //             TESTFIELD("AAD No. - Receipt",xRec."AAD No. - Receipt");
        //           // >>DITW15.00.00.37 DDR

        //           GetItem();
        //           Item.TESTFIELD("Tariff No.");
        //         end;

        //     end;
        // }
        // field(2013758;"Transf.-to Location Gr. Code";Code[10])
        // {
        //     CaptionML = ENU='Transfer-to Location Tax Group Code',
        //                 FRA='Transfer vers code groupe magasin taxe';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Location Group";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 31/05/2010
        //         UpdateCharges(FIELDNO("Transf.-to Location Gr. Code"),true);
        //     end;
        // }
        // field(2013759;"Calculate Tax on Location";Option)
        // {
        //     CaptionML = ENU='Calculate Tax on Location',
        //                 FRA='Calculer taxe sur magasin';
        //     Description = 'DITW15.00.00.37';
        //     OptionCaptionML = ENU=' ,From,To,Both',
        //                       FRA=' ,De,Vers,Les deux';
        //     OptionMembers = " ",From,"To",Both;
        // }
        // field(2013767;"Unit Volume HL";Decimal)
        // {
        //     CaptionClass = GetUomCaptionClassHL(FIELDNO("Unit Volume HL"));
        //     CaptionML = ENU='Trsf-from Unit Volume',
        //                 FRA='Transfer-de Volume unitaire';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.36';
        //     MinValue = 0;
        // }
        // field(2013768;"Trsf-to Unit Volume HL";Decimal)
        // {
        //     CaptionClass = GetUomCaptionClassHL(FIELDNO("Trsf-to Unit Volume HL"));
        //     CaptionML = ENU='Trsf-to Unit Volume',
        //                 FRA='Transfer-vers Volume unitaire';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW18.00.06 DIT-770 #1395';
        //     MinValue = 0;
        // }
        // field(2013798;"Item Charge No.";Code[20])
        // {
        //     CaptionML = ENU='Item Charge No.',
        //                 FRA='N° frais annexes';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = IF ("Item Charge Type"=CONST(" ")) "Item Charge"
        //                     else IF ("Item Charge Type"=FILTER(<>" ")) "Item Charge" WHERE ("Item Charge Type"=FIELD("Item Charge Type"));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 04/02/2010
        //         if "Item Charge Type" <> "Item Charge Type"::" " then begin
        //           TESTFIELD("Item No.");
        //           TESTFIELD("Item Charge No.");
        //         end;

        //         if "Item Charge No." <> '' then begin
        //           ItemCharge.GET("Item Charge No.");
        //           TESTFIELD("Item Charge Type",ItemCharge."Item Charge Type");
        //           // <<DITW18.00.06 DDR 23/10/2015 DIT-770 #1395
        //           "Item Charge Type" := ItemCharge."Item Charge Type";
        //           Collapse := ItemCharge.Collapse;
        //           "Is Item Charge" := ("Attached to Line No." <> 0) or ("Item Charge Type" <> 0);
        //           // >>DITW18.00.06 DDR DIT-770 #1395
        //           Description := ItemCharge.Description;
        //           // <<DITW15.00.00.37 DDR 18/06/2010
        //           // <<DITW18.00.07 DDR 28/02/2016 DIT-770 #1836
        //           if (xRec."Item Charge No." <> "Item Charge No.") or (ItemCharge."Gen. Prod. Posting Group" <> '') then
        //           // >>DITW18.00.07 DDR DIT-770 #1836
        //           VALIDATE("Gen. Prod. Posting Group",ItemCharge."Gen. Prod. Posting Group");
        //           // >>DITW15.00.00.37 DDR
        //           // <<DITW15.00.00.37 DDR 29/01/2010
        //           "AAD No. Series - Shipment" := '';
        //           "AAD No. - Shipment" := '';
        //           "AAD No. - Receipt" := '';
        //           // >>DITW15.00.00.37 DDR
        //           // <<DITW15.00.00.38 DDR 20/08/2010 - 04/10/2010 #1217
        //           "LRN No. Series - Shipment" := '';
        //           "LRN No. - Shipment" := '';
        //           "ARC No. - Shipment" := '';
        //           "ARC No. - Receipt" := '';
        //           "SAD No. - Shipment" := '';
        //           "ARC No. Mandatory - Shipment" := false;
        //           // >>DITW15.00.00.38 DDR
        //           // <<DITW16.00.00.40 DDR 03/07/2012 DIT-715 #371
        //           if "Tax Item No." <> '' then
        //             UpdateAADInfo();
        //           // >>DITW16.00.00.40 DDR DIT-715 #371
        //           // <<DITW16.00.00.42 DDR 08/01/2013 DIT-715 #531
        //           "Gross Weight" := 0;
        //           "Net Weight" := 0;
        //           "Unit Volume" := 0;
        //           "Units per Parcel" := 0;
        //           // >>DITW16.00.00.42 DDR DIT-715 #531
        //           // <<DITW18.00.06 DDR 26/10/2015 DIT-770 #1412
        //           "Unit Volume HL" := 0;
        //           // <<DITW18.00.06 DDR 03/11/2015 DIT-770 #1395
        //           "Trsf-to Unit Volume HL" := 0;
        //           // >>DITW18.00.06 DDR DIT-770 #1395
        //           Cubage := 0;
        //           Weight := 0;
        //           Distance := 0;
        //           "Packaging Type Code" := '';
        //           "Pack Qty. per Unit of Measure" := 0;
        //           // >>DITW18.00.06 DDR DIT-770 #1412
        //         end;

        //         CreateDim(
        //           DATABASE::"Item Charge","Item Charge No.",
        //           DATABASE::Item,"Item No.",
        //           // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //           DATABASE::Item,"Tax Item No.");
        //           // >>DITW16.00.00.43 DDR DIT-715 #768
        //     end;
        // }
        // field(2014060;"Maximum Weight";Decimal)
        // {
        //     BlankZero = true;
        //     Caption = 'Maximum Weight';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     MinValue = 0;
        // }
        // field(2014061;"Maximum Cubage";Decimal)
        // {
        //     BlankZero = true;
        //     Caption = 'Maximum Volume (Cubage)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     MinValue = 0;
        // }
        // field(2014064;"Shipping Charge Per";Option)
        // {
        //     CaptionML = ENU='Shipping Charge Per',
        //                 FRA='Frais transport par';
        //     Description = 'DITW15.00.00.37';
        //     OptionCaptionML = ENU='Shipment,Weight,Volume',
        //                       FRA='Expédition,Poids,Volume';
        //     OptionMembers = Shipment,Weight,Volume;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 04/02/2010
        //         TestStatusOpen;
        //     end;
        // }
        // field(2014077;"Truck Code";Code[10])
        // {
        //     CaptionML = ENU='Truck Code',
        //                 FRA='Code camion';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Whse. Shipping Truck";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.25 DDR 10/10/2008 - DITW15.00.00.37 DDR 04/02/2010
        //         if (CurrFieldNo <> 0) then
        //           //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //           //TestStatusOpen;
        //           //>> DITW110.00.12 AKH NRQ#16026
        //         // >>DITW15.00.00.37 DDR
        //         // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //         if (not "Is Item Charge") and ("Item Charge No." = '') then
        //           UpdateCharges(FIELDNO("Truck Code"),true);
        //         // >>DITW16.00.00.43 DDR DIT-715 #768
        //     end;
        // }
        // field(2014078;"Driver Code";Code[10])
        // {
        //     CaptionML = ENU='Driver Code',
        //                 FRA='Code chauffeur';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Whse. Shipping Driver";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.25 DDR 10/10/2008 - DITW15.00.00.37 DDR 04/02/2010
        //         if (CurrFieldNo <> 0) then
        //           //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //           //TestStatusOpen;
        //           //>> DITW110.00.12 AKH NRQ#16026
        //         // >>DITW15.00.00.37 DDR
        //         // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //         if (not "Is Item Charge") and ("Item Charge No." = '') then
        //           UpdateCharges(FIELDNO("Driver Code"),true);
        //         // >>DITW16.00.00.43 DDR DIT-715 #768
        //     end;
        // }
        // field(2014079;Cubage;Decimal)
        // {
        //     CaptionML = ENU='Volume (Cubage)',
        //                 FRA='Volume (cubage)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.37';
        // }
        // field(2014080;Weight;Decimal)
        // {
        //     CaptionML = ENU='Weight',
        //                 FRA='Poids';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.37';
        // }
        // field(2014081;Route;Code[20])
        // {
        //     Caption = 'Route';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     TableRelation = Route;
        // }
        // field(2014082;"Route Planning No.";Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     TableRelation = "Route Planning Worksheet";
        // }
        // field(2014083;"Truck Zone";Option)
        // {
        //     Caption = 'Truck Zone';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     OptionCaption = '" ,Right,Left"';
        //     OptionMembers = " ",Right,Left;
        // }
        // field(2014084;"Shipment Status";Option)
        // {
        //     Caption = 'Shipping Status';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     OptionCaption = 'Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice';
        //     OptionMembers = Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;
        // }
        // field(2014085;"Cubage (Base)";Decimal)
        // {
        //     Caption = 'Volume (Cubage)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.12 NRQ#16026';
        // }
        // field(2014086;"Weight (Base)";Decimal)
        // {
        //     Caption = 'Weight';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.12 NRQ#16026';
        // }
        // field(2014087;Distance;Decimal)
        // {
        //     CaptionML = ENU='Distance',
        //                 FRA='Distance';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.37';
        //     MinValue = 0;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 04/02/2010
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         //TestStatusOpen;
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014094;"Trsf-from Ph. Location Gr Code";Code[10])
        // {
        //     CaptionML = ENU='Transfer-from Physical Location Group Code',
        //                 FRA='Transf. du Code groupe magasin réel';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Physical Location Group";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 04/02/2010
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         //TestStatusOpen;
        //         //>> DITW110.00.12 AKH NRQ#16026
        //         InvtSetup.GET;

        //         if xRec."Trsf-from Ph. Location Gr Code" <> "Trsf-from Ph. Location Gr Code" then begin
        //           TESTFIELD("Item No.");
        //           TESTFIELD("Qty. in Transit",0);
        //           if "Trsf-from Ph. Location Gr Code" <> '' then
        //             if InvtSetup."Location Mandatory" then
        //               TESTFIELD("Transfer-from Code");
        //         end;

        //         GetLocation("Transfer-from Code");
        //         if (Location."Physical Location Group Code" <> '') and
        //           ("Trsf-from Ph. Location Gr Code" <> '')
        //         then
        //           TESTFIELD("Trsf-from Ph. Location Gr Code",Location."Physical Location Group Code");

        //         // <<DITW15.00.00.37 DDR 31/05/2010
        //         UpdateCharges(FIELDNO("Trsf-from Ph. Location Gr Code"),true);
        //         // >>DITW15.00.00.37

        //         if (CurrFieldNo = FIELDNO("Trsf-from Ph. Location Gr Code")) and ("Trsf-from Ph. Location Gr Code" <> '') then
        //           VALIDATE("Transfer-from Code");
        //     end;
        // }
        // field(2014101;"Trsf-to Ph. Location Gr Code";Code[10])
        // {
        //     CaptionML = ENU='Transfer-to Physical Location Group Code',
        //                 FRA='Transfer vers code groupe magasin réel';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Physical Location Group";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 04/02/2010
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         //TestStatusOpen;
        //         //>> DITW110.00.12 AKH NRQ#16026
        //         InvtSetup.GET;

        //         if xRec."Trsf-to Ph. Location Gr Code" <> "Trsf-to Ph. Location Gr Code" then begin
        //           TESTFIELD("Item No.");
        //           TESTFIELD("Qty. in Transit",0);
        //           if "Trsf-to Ph. Location Gr Code" <> '' then
        //             if InvtSetup."Location Mandatory" then
        //               TESTFIELD("Transfer-to Code");
        //         end;

        //         GetLocation("Transfer-to Code");
        //         if (Location."Physical Location Group Code" <> '') and
        //           ("Trsf-to Ph. Location Gr Code" <> '')
        //         then
        //           TESTFIELD("Trsf-to Ph. Location Gr Code",Location."Physical Location Group Code");

        //         // <<DITW15.00.00.37 DDR 31/05/2010
        //         UpdateCharges(FIELDNO("Trsf-to Ph. Location Gr Code"),true);
        //         // >>DITW15.00.00.37

        //         if (CurrFieldNo = FIELDNO("Trsf-to Ph. Location Gr Code")) and ("Trsf-to Ph. Location Gr Code" <> '') then
        //           VALIDATE("Transfer-to Code");
        //     end;
        // }
        // field(2014112;"Unit Amount";Decimal)
        // {
        //     AutoFormatExpression = GetAutoformatRoundingType('');
        //     AutoFormatType = 2;
        //     CaptionML = ENU='Unit Amount',
        //                 FRA='Montant unitaire';
        //     Description = 'DITW15.00.00.37';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 28/05/2010
        //         if ("Extra Charge Type" <> "Extra Charge Type"::Amount) and
        //            ("Extra Charge Type" <> "Extra Charge Type"::"Fixed Amount") and
        //            ("Extra Charge Type" <> "Extra Charge Type"::VolumeHL) and
        //            ("Extra Charge Type" <> "Extra Charge Type"::"Price Item") and
        //            (CurrFieldNo = FIELDNO("Unit Amount")) and
        //            "Is Item Charge"
        //         then
        //           FIELDERROR("Extra Charge Type");

        //         if CurrFieldNo = FIELDNO("Unit Amount") then begin
        //           if not "Is Item Charge" then
        //             "Item Charge Value" := "Unit Amount";
        //         end;

        //         // <<DITW15.00.00.38 DDR 21/12/2010 #1171
        //         UpdateAmount();
        //         // >>DITW15.00.00.38 DDR #1171

        //         UpdateCharges(FIELDNO("Unit Amount"),(CurrFieldNo = FIELDNO("Unit Amount")));
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
        //         TempTransferLine : Record "Transfer Line" temporary;
        //         ItemTransferLine : Record "Sales Line";
        //     begin
        //         // <<DITW16.00.00.43 DDR 25/09/2013 DIT-715 #519
        //         TestStatusOpen();
        //         CLEAR(Item);
        //         CLEAR(TempTransferLine);
        //         if "Tax Item No." <> '' then begin
        //           Item.GET("Tax Item No.");
        //           TransHeader.GET("Document No.");
        //           // >>DITW16.00.00.43 DDR DIT-715 #864
        //           TempTransferLine.SetTransferHeader(TransHeader);
        //           TempTransferLine."Document No." := "Document No.";
        //           TempTransferLine.VALIDATE("Item No.","Tax Item No.");
        //           // <<DITW16.00.00.43 DDR 18/12/2013 DIT-715 #766
        //           TempTransferLine."Trsf-from Ph. Location Gr Code" := '';
        //           TempTransferLine."Trsf-to Ph. Location Gr Code" := '';
        //           // >>DITW16.00.00.43 DDR DIT-715 #766
        //           // <<DITW18.00.06 DDR 23/10/2015 DIT-770 #1395
        //           if "Transfer-from Code" <> '' then
        //           // >>DITW18.00.06 DDR DIT-770 #1395
        //             TempTransferLine.VALIDATE("Transfer-from Code","Transfer-from Code");
        //           // <<DITW18.00.06 DDR 23/10/2015 DIT-770 #1395
        //           if "Transfer-to Code" <> '' then
        //           // >>DITW18.00.06 DDR DIT-770 #1395
        //             TempTransferLine.VALIDATE("Transfer-to Code","Transfer-to Code");
        //           TempTransferLine.VALIDATE(Quantity,Quantity);
        //           // <<DITW16.00.00.43 DDR 01/10/2013 DIT-715 #519
        //           TempTransferLine.VALIDATE("Unit of Measure Code","Unit of Measure Code");
        //           // >>DITW16.00.00.43 DDR DIT-715 #519
        //           TempTransferLine.UpdateAADInfo();
        //           TempTransferLine.CalcCubageWeight();
        //         end;
        //         "Gross Weight" := TempTransferLine."Gross Weight";
        //         "Net Weight" := TempTransferLine."Net Weight";
        //         "Unit Volume" := TempTransferLine."Unit Volume";
        //         "Units per Parcel" := TempTransferLine."Units per Parcel";
        //         Cubage := TempTransferLine.Cubage;
        //         Weight := TempTransferLine.Weight;
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         "Cubage (Base)" := TempTransferLine."Cubage (Base)";
        //         "Weight (Base)" := TempTransferLine."Weight (Base)";
        //         //>> DITW110.00.12 AKH NRQ#16026
        //         Distance := TempTransferLine.Distance;
        //         // <<DITW16.00.00.43 DDR 25/09/2013 DIT-715 #519
        //         "Item Category Code" := TempTransferLine."Item Category Code";
        //         "Product Group Code" := TempTransferLine."Product Group Code";
        //         // <<DITW18.00.06 DDR 03/11/2015 DIT-770 #1395
        //         "Unit Volume HL" := 0;
        //         "Trsf-to Unit Volume HL" := 0;
        //         if "Transfer-from Code" <> '' then
        //           "Unit Volume HL" := TempTransferLine."Unit Volume HL";
        //         if "Transfer-to Code" <> '' then
        //           "Trsf-to Unit Volume HL" := TempTransferLine."Unit Volume HL";
        //         // >>DITW18.00.06 DDR DIT-770 #1395
        //         // >>DITW16.00.00.43 DDR DIT-715 #519

        //         if ("Line No." <> 0) and (CurrFieldNo <> 0) and ("Attached to Line No." <> 0) then begin
        //           ItemTransferLine.GET("Document No.","Attached to Line No.");
        //           "Gross Weight" := "Gross Weight" * ItemTransferLine."Qty. per Unit of Measure";
        //           "Net Weight" := "Net Weight" * ItemTransferLine."Qty. per Unit of Measure";
        //           "Unit Volume" := "Unit Volume" * ItemTransferLine."Qty. per Unit of Measure";
        //           "Units per Parcel" := ROUND("Units per Parcel" / ItemTransferLine."Qty. per Unit of Measure",0.00001);
        //           "Unit Volume HL" := "Unit Volume HL" * ItemTransferLine."Qty. per Unit of Measure";
        //           // <<DITW18.00.06 DDR 03/11/2015 DIT-770 #1395
        //           "Trsf-to Unit Volume HL" := "Unit Volume HL" * ItemTransferLine."Qty. per Unit of Measure";
        //           // >>DITW18.00.06 DDR DIT-770 #1395
        //           Cubage := Cubage * ItemTransferLine."Qty. per Unit of Measure";
        //           Weight := Weight * ItemTransferLine."Qty. per Unit of Measure";
        //           //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //           "Cubage (Base)" :=  "Cubage (Base)" * ItemTransferLine."Qty. per Unit of Measure";
        //           "Weight (Base)" :=  "Weight (Base)" * ItemTransferLine."Qty. per Unit of Measure";
        //           //>> DITW110.00.12 AKH NRQ#16026
        //         end;

        //         "Tariff No." := TempTransferLine."Tariff No.";

        //         // <<DITW16.00.00.43 DDR 23/10/2013 DIT-715 #768
        //         if "Item Charge Type" = "Item Charge Type"::Tax then begin
        //         // >>DITW16.00.00.43 DDR DIT-715 #768
        //           "Item DTax Group Code" := TempTransferLine."Item DTax Group Code";
        //           "AAD No. Series - Shipment" := TempTransferLine."AAD No. Series - Shipment";
        //           "Company Tax Registration No." := TempTransferLine."Company Tax Registration No.";
        //           "LRN No. Series - Shipment" := TempTransferLine."LRN No. Series - Shipment";
        //           "Product Tax Code" := TempTransferLine."Product Tax Code";
        //           "ARC No. Mandatory - Shipment" := TempTransferLine."ARC No. Mandatory - Shipment";
        //           "Company Tax Warehouse Ref." := TempTransferLine."Company Tax Warehouse Ref.";
        //           "Packaging Type Code" := TempTransferLine."Packaging Type Code";
        //           "Pack Qty. per Unit of Measure" := TempTransferLine."Pack Qty. per Unit of Measure";
        //           // <<DITW18.00.06 DDR 26/10/2015 DIT-770 #1412
        //           "No. of Packages" := TempTransferLine."No. of Packages";
        //           // >>DITW18.00.06 DDR DIT-770 #1412
        //           // <<DITW16.00.00.45 DDR 30/03/2015 DIT-715 #950
        //           "ARC No. Mandatory - Receipt" := TempTransferLine."ARC No. Mandatory - Receipt";
        //           // >>DITW16.00.00.45 DDR DIT-715 #950
        //         end;
        //         // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //         CreateDim(DATABASE::Item,"Tax Item No.",
        //           DATABASE::Item,"Item No.",
        //           DATABASE::"Item Charge","Item Charge No.");
        //         // >>DITW16.00.00.43 DDR DIT-715 #768
        //     end;
        // }
        // field(2014260;"LRN No. Series - Shipment";Code[10])
        // {
        //     CaptionML = ENU='LRN No. Series',
        //                 FRA='Souches de n° LRN';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "No. Series";

        //     trigger OnLookup();
        //     var
        //         lrTempTransLine : Record "Transfer Line" temporary;
        //         lDefaultLRNCode : Code[20];
        //     begin
        //         // <<DITW15.00.00.38 DDR 10/08/2010 #1217
        //         TestStatusOpen;

        //         // <<DITW15.00.00.38 DDR 11/03/2011 #703
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW15.00.00.38 DDR #703

        //         TestLRNNoSeriesMandatory();

        //         with lrTempTransLine do begin
        //           lrTempTransLine := Rec;
        //           EmcsSetup.GET;
        //           // <<DITW15.00.00.39 DDR 12/04/2011 #1296
        //           EmcsSetup.TESTFIELD("LRN Nos.");
        //           // >>DITW15.00.00.39 DDR #1296
        //           lDefaultLRNCode := EmcsSetup."LRN Nos.";
        //           if NoSeriesMgt.LookupSeries(lDefaultLRNCode,"LRN No. Series - Shipment") then
        //             VALIDATE("LRN No. Series - Shipment");
        //           Rec := lrTempTransLine;
        //         end;
        //     end;

        //     trigger OnValidate();
        //     var
        //         lDefaultLRNCode : Code[20];
        //     begin
        //         // <<DITW15.00.00.38 DDR 04/10/2010 #1217
        //         TestStatusOpen;

        //         // <<DITW15.00.00.38 DDR 11/03/2011 #703
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW15.00.00.38 DDR #703

        //         if "LRN No. Series - Shipment" <> '' then begin
        //           EmcsSetup.GET;
        //           // <<DITW15.00.00.39 DDR 12/04/2011 #1296
        //           EmcsSetup.TESTFIELD("LRN Nos.");
        //           // >>DITW15.00.00.39 DDR #1296
        //           lDefaultLRNCode := EmcsSetup."LRN Nos.";
        //           if lDefaultLRNCode <> '' then
        //             NoSeriesMgt.TestSeries(lDefaultLRNCode,"LRN No. Series - Shipment");
        //           TestLRNNoSeriesMandatory();
        //         end;
        //         TESTFIELD("LRN No. - Shipment",'');
        //     end;
        // }
        // field(2014261;"LRN No. - Shipment";Code[20])
        // {
        //     CaptionML = ENU='LRN No.',
        //                 FRA='N° LRN';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     var
        //         lrTempTransLine : Record "Transfer Line" temporary;
        //         lrNoSeries : Record "No. Series";
        //     begin
        //         // <<DITW15.00.00.38 DDR 04/10/2010 #1217
        //         TestStatusOpen;

        //         // <<DITW15.00.00.38 DDR 11/03/2011 #703
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW15.00.00.38 DDR #703

        //         if "LRN No. - Shipment" <> xRec."LRN No. - Shipment" then begin
        //           NoSeriesMgt.TestManual("LRN No. Series - Shipment");
        //           "LRN No. Series - Shipment" := '';
        //         end;

        //         if "LRN No. - Shipment" <> '' then begin
        //           LRNDocMgt.CheckLRNNo("LRN No. - Shipment");
        //           if "LRN No. Series - Shipment" <> '' then
        //             lrNoSeries.GET("LRN No. - Shipment")
        //           else
        //             lrNoSeries."Manual Nos." := true;

        //           /*
        //           IF lrNoSeries."Manual Nos." THEN BEGIN
        //             TESTFIELD("lrn No. - Receipt",'');
        //             "lrn No. - Receipt" := "lrn No. - Shipment";
        //           end;
        //           */

        //           TestLRNNoSeriesMandatory();
        //         end;

        //     end;
        // }
        // field(2014262;"ARC No. - Shipment";Code[30])
        // {
        //     CaptionML = ENU='ARC No. - Shipment',
        //                 FRA='N° ARC - Expédition';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 11/03/2011 #703
        //         if "Item Charge No." <> '' then
        //           TESTFIELD("Tax Item No.");
        //         // >>DITW15.00.00.38 DDR #703
        //         // <<DITW15.00.00.38 DDR 20/08/2010 #1217
        //         if "ARC No. - Shipment" <> '' then
        //           TESTFIELD("ARC No. Mandatory - Shipment")
        //         else
        //           if "ARC No. Mandatory - Shipment" then
        //             TESTFIELD("ARC No. - Shipment");
        //         // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //         if CurrFieldNo = FIELDNO("ARC No. - Shipment") then
        //           TESTFIELD("Applies-to AAD Trck. Entry No.",0);
        //         // >>DITW15.00.00.39 DDR #1369
        //     end;
        // }
        // field(2014263;"SAD No. - Shipment";Code[30])
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
        // field(2014267;"ARC No. Mandatory - Shipment";Boolean)
        // {
        //     CaptionML = ENU='ARC No. Mandatory - Shipment',
        //                 FRA='N° ARC obligatoire - Expédition';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014271;"Company Tax Warehouse Ref.";Text[20])
        // {
        //     CaptionML = ENU='Company Tax Warehouse Reference',
        //                 FRA='Entrepôt fiscal de référence société';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 13/09/2010 #1217
        //         TestStatusOpen;
        //         TestTaxWhseRefMandatory();
        //     end;
        // }
        // field(2014281;"ARC No. - Receipt";Code[30])
        // {
        //     CaptionML = ENU='ARC No. - Receipt',
        //                 FRA='N° ARC - Réception';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnLookup();
        //     var
        //         NewText : Text[250];
        //     begin
        //         // <<DITW15.00.00.39 DDR 12/04/2011 #1296
        //         TESTFIELD("ARC No. Mandatory - Receipt");
        //         NewText := "ARC No. - Receipt";
        //         if EDILookupExtTrackingARC(NewText) then
        //           VALIDATE("ARC No. - Receipt",NewText);
        //     end;

        //     trigger OnValidate();
        //     var
        //         TransLine2 : Record "Transfer Line";
        //     begin
        //         // <<DITW15.00.00.39 DDR 12/04/2011 #1296
        //         if "ARC No. - Receipt" <> '' then
        //           TESTFIELD("ARC No. Mandatory - Receipt")
        //         else
        //           if "ARC No. Mandatory - Receipt" then begin
        //             TransLine2.RESET;
        //             TransLine2 := Rec;
        //             TransLine2.SETRECFILTER;
        //             if GUIALLOWED and not HideValidationDialog and (CurrFieldNo <> 0) then
        //               MESSAGE(Text2014260,FIELDCAPTION("ARC No. - Receipt"),TABLECAPTION,TransLine2.GETFILTERS);
        //           end;
        //         if xRec."ARC No. - Receipt" <> "ARC No. - Receipt" then begin
        //           EDIUpdateInboxDocNo(xRec."ARC No. - Receipt","ARC No. - Receipt");
        //           if not TestOpenEDIInboxDocNo(xRec."ARC No. - Receipt") then
        //             TESTFIELD("ARC No. - Receipt",xRec."ARC No. - Receipt");
        //         end;
        //         // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //         if CurrFieldNo = FIELDNO("ARC No. - Receipt") then
        //           TESTFIELD("Applies-to AAD Trck. Entry No.",0);
        //         // >>DITW15.00.00.39 DDR #1369
        //     end;
        // }
        // field(2014289;"ARC No. Mandatory - Receipt";Boolean)
        // {
        //     CaptionML = ENU='ARC No. Mandatory - Receipt',
        //                 FRA='N° ARC obligatoire - Réception';
        //     Description = 'DITW15.00.00.39 #1296';
        // }
        // field(2014410;Collapse;Boolean)
        // {
        //     CaptionML = ENU='Collapse',
        //                 FRA='Réduire';
        //     Description = 'DITW15.00.00.37';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 04/02/2010
        //         if Collapse and
        //           ("Attached to Line No." = 0)
        //         then
        //           TESTFIELD(Collapse, false);
        //     end;
        // }
        // field(2014417;"Relation Transfer-from Code";Code[10])
        // {
        //     CaptionML = ENU='Relation Location Code',
        //                 FRA='Code Magasin Relation';
        //     Description = 'DITW110.00.09 NRQ#16737';
        //     TableRelation = IF ("Trsf-from Ph. Location Gr Code"=CONST('')) Location
        //                     else IF ("Trsf-from Ph. Location Gr Code"=FILTER(<>'')) Location WHERE ("Physical Location Group Code"=FIELD("Trsf-from Ph. Location Gr Code"));
        // }
        // field(2014418;"Lot Reserved Qty. (Base)";Decimal)
        // {
        //     CalcFormula = -Sum("Reservation Entry"."Quantity (Base)" WHERE ("Source Type"=CONST(5741),
        //                                                                     "Source ID"=FIELD("Document No."),
        //                                                                     "Source Subtype"=CONST("0"),
        //                                                                     "Source Ref. No."=FIELD("Line No."),
        //                                                                     "Lot No."=FILTER(<>''),
        //                                                                     "Reservation Status"=CONST(Surplus)));
        //     Caption = 'Lot Reserved Qty. (Base)';
        //     Description = 'NRQ#94671';
        //     FieldClass = FlowField;
        // }
        // field(2014434;"Line Amount";Decimal)
        // {
        //     AutoFormatExpression = GetAutoformatRoundingType('');
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Line Amount',
        //                 FRA='Montant ligne';
        //     Description = 'DITW15.00.00.38 #1171';
        // }
        // field(2014440;"Attached to Line No.";Integer)
        // {
        //     CaptionML = ENU='Attached to Line No.',
        //                 FRA='Attaché à la ligne n°';
        //     Description = 'DITW15.00.00.37';
        //     Editable = false;
        //     TableRelation = "Transfer Line"."Line No." WHERE ("Document No."=FIELD("Document No."),
        //                                                       "Line No."=FIELD("Attached to Line No."),
        //                                                       "Attached to Line No."=CONST(0));
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
        //             Item.GET("Tax Item No.");
        //             ItemUnitOfMeasure.GET("Tax Item No.",Item."Sales Unit of Measure");
        //           end else
        //             ItemUnitOfMeasure.GET("Item No.","Unit of Measure Code");
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
        //     begin
        //         // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
        //         TestStatusOpen;
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
        //     CalcFormula = Exist("Transfer Line" WHERE ("Document No."=FIELD("Document No."),
        //                                                "Attached to Line No."=FIELD("Line No.")));
        //     CaptionML = ENU='Has Item Charge',
        //                 FRA='A des Frais Annexes';
        //     Description = 'DITW17.10.03 DIT-770 #541';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2029610;"Cross-Reference No.";Code[20])
        // {
        //     CaptionML = ENU='Cross-Reference No.',
        //                 FRA='Référence externe';
        //     Description = 'FINXL8.00.001';

        //     trigger OnLookup();
        //     begin
        //         //<<FINXL8.00.001 BSA 02/06/2015 #178
        //         if recFinXLSetup.READPERMISSION then fctLookupCrossReference();
        //         //>>FINXL8.00.001 BSA 02/06/2015 #178
        //     end;

        //     trigger OnValidate();
        //     begin
        //         //<<FINXL8.00.001 BSA 02/06/2015 #178
        //         if recFinXLSetup.READPERMISSION then fctValidateCrossReference();
        //         //>>FINXL8.00.001 BSA 02/06/2015 #178
        //     end;
        // }
        // field(2029611;"Emergency Order";Boolean)
        // {
        //     CalcFormula = Lookup("Transfer Header"."Emergency Order" WHERE ("No."=FIELD("Document No.")));
        //     CaptionML = ENU='Emergency',
        //                 FRA='Urgence';
        //     Description = 'FINXL8.00.001';
        //     FieldClass = FlowField;
        // }
        // field(2029613;"Logistics Group";Code[10])
        // {
        //     CalcFormula = Lookup("Transfer Header"."Logistics Group" WHERE ("No."=FIELD("Document No.")));
        //     CaptionML = ENU='Logistics Group',
        //                 FRA='Groupe logisitique';
        //     Description = 'FINXL8.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035090;"No. of Quality Tests";Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" WHERE ("Source Type"=CONST(5741),
        //                                                      "Source ID"=FIELD("Document No."),
        //                                                      "Source Ref. No."=FIELD("Derived From Line No."),
        //                                                      "Item No."=FIELD("Item No.")));
        //     CaptionML = ENU='No. of Quality Tests (Transfer-To)',
        //                 FRA='N° de Tests de Qualité (Dest. transfer)';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035391;"External Document No.";Code[35])
        // {
        //     CalcFormula = Lookup("Transfer Header"."External Document No." WHERE ("No."=FIELD("Document No.")));
        //     CaptionML = ENU='External Document No.',
        //                 FRA='N° document externe';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035392;"Posting Date";Date)
        // {
        //     CalcFormula = Lookup("Transfer Header"."Posting Date" WHERE ("No."=FIELD("Document No.")));
        //     CaptionML = ENU='Posting Date',
        //                 FRA='Date comptabilisation';
        //     Description = 'QXL9.00.001';
        //     FieldClass = FlowField;
        // }
        // field(2036301;"Requester ID";Code[50])
        // {
        //     CaptionML = ENU='Requester ID',
        //                 FRA='ID demandeur';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = User;
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnLookup();
        //     var
        //         LoginMgt : Codeunit "User Management";
        //     begin
        //         //<<MANXL7.00.001 DAT 05/03/2014 #18
        //         CLEAR(cduLoginMgmt);
        //         cduLoginMgmt.LookupUserID("Requester ID");
        //         //>>MANXL7.00.001 DAT 05/03/2014 #18
        //     end;

        //     trigger OnValidate();
        //     var
        //         LoginMgt : Codeunit "User Management";
        //     begin
        //         //<<MANXL7.00.001 DAT 05/03/2014 #18
        //         CLEAR(cduLoginMgmt);
        //         cduLoginMgmt.ValidateUserID("Requester ID");
        //         //>>MANXL7.00.001 DAT 05/03/2014 #18
        //     end;
        // }

        //---BC Upgrade KAMNAY01<< DITW
    }
    keys
    {

        //Unsupported feature: Deletion on ""Transfer-to Code",Status,"Derived From Line No.","Item No.","Variant Code","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code","Receipt Date","In-Transit Code"(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""Transfer-from Code",Status,"Derived From Line No.","Item No.","Variant Code","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code","Shipment Date","In-Transit Code"(Key)". Please convert manually.

        //---BC Upgrade KAMNAY01>> DITW field
        // key(Key1; "Transfer-to Code", Status, "Derived From Line No.", "Item No.", "Variant Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Receipt Date", "In-Transit Code", "Item Charge No.", "Is Item Charge")
        // {
        //     MaintainSIFTIndex = false;
        //     SumIndexFields = "Qty. in Transit (Base)", "Outstanding Qty. (Base)";
        // }
        // key(Key2; "Transfer-from Code", Status, "Derived From Line No.", "Item No.", "Variant Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Shipment Date", "In-Transit Code", "Item Charge No.", "Is Item Charge")
        // {
        //     MaintainSIFTIndex = false;
        //     SumIndexFields = "Outstanding Qty. (Base)";
        // }

        // key(Key3; "Document No.", "AAD No. Series - Shipment", "LRN No. Series - Shipment", "Company Tax Registration No.", "Tariff No.", "Item No.")
        // {
        // }
        // key(Key4; "Document No.", "Attached to Line No.", Collapse, "Is Item Charge", "ItemCharge Incl. Price", "Extra Charge Type")
        // {
        // }
        //---BC Upgrade KAMNAY01<< DITW field
        key(Key9; "Derived From Line No.", "Item No.")
        {
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;

    TESTFIELD("Quantity Shipped","Quantity Received");
    TESTFIELD("Qty. Shipped (Base)","Qty. Received (Base)");
    CALCFIELDS("Reserved Qty. Inbnd. (Base)","Reserved Qty. Outbnd. (Base)");
    TESTFIELD("Reserved Qty. Inbnd. (Base)",0);
    TESTFIELD("Reserved Qty. Outbnd. (Base)",0);

    ReserveTransferLine.DeleteLine(Rec);
    WhseValidateSourceLine.TransLineDelete(Rec);

    ItemChargeAssgntPurch.SETCURRENTKEY(
      "Applies-to Doc. Type","Applies-to Doc. No.","Applies-to Doc. Line No.");
    ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Type",ItemChargeAssgntPurch."Applies-to Doc. Type"::"Transfer Receipt");
    ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. No.","Document No.");
    ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Line No.","Line No.");
    ItemChargeAssgntPurch.DELETEALL(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    // <<DITW18.00.06 DDR 03/11/2015 DIT-770 #1395
    if ("Line No." <> 0) and ("BOM Line No." <> 0) and
      ("Is Item Charge" or ("Item Charge Type" <> "Item Charge Type"::" ")) and
      not StatusCheckSuspended
    then
      TESTFIELD("BOM Line No.",0);
    // >>DITW18.00.06 DDR DIT-770 #1395

    ReserveTransferLine.DeleteLine(Rec);

    // <<DITW15.00.00.37 PRODW14.00.00.16 DDR 23/06/2010
    if rQualitySetup.READPERMISSION then
      cduQualityMgt.DeleteTransferLine(Rec);
    // >>DITW15.00.00.37 PRODW14.00.00.16 DDR

    #10..16
    ItemChargeAssgntPurch.DELETEALL(true);

    // <<DITW15.00.00.37 DDR 08/02/2010
    DeleteAllChargeTransferLines(Rec,true);
    // >>DITW15.00.00.37 DDR
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;
    TransLine2.RESET;
    TransLine2.SETFILTER("Document No.",TransHeader."No.");
    IF TransLine2.FINDLAST THEN
      "Line No." := TransLine2."Line No." + 10000;
    ReserveTransferLine.VerifyQuantity(Rec,xRec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TestStatusOpen;

    // <<DITW15.00.00.37 DDR 31/05/2010
    if ((not "Is Item Charge") and ("Item Charge No." = '')) and ("Line No." = 0) then begin
    // >>DITW15.00.00.37 DDR
      TransLine2.RESET;
      TransLine2.SETFILTER("Document No.",TransHeader."No.");
      if TransLine2.FINDLAST then
        "Line No." := TransLine2."Line No." + 10000;
    // <<DITW15.00.00.37 DDR 31/05/2010
    end;
    // >>DITW15.00.00.37 DDR

    ReserveTransferLine.VerifyQuantity(Rec,xRec);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    // var
    //     TransferLineItem: Record "Transfer Line";

    // var
    //     TransferLineItem: Record "Transfer Line";

    // var
    //     lrItemTransLine: Record "Transfer Line";


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=must not be less than %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=must not be less than %1;FRA=ne doit pas être inférieur(e) à %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU="Warehouse %1 is required for %2 = %3.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU="Warehouse %1 is required for %2 = %3.";FRA="Le entrepôt %1 est nécessaire pour %2 = %3.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=\The entered information may be disregarded by warehouse operations.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=\The entered information may be disregarded by warehouse operations.;FRA=\Les informations entrées peuvent être ignorées par les opérations de distribution.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=You cannot ship more than %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=You cannot ship more than %1 units.;FRA=Vous ne pouvez pas expédier plus de %1 unité(s).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=All items have been shipped.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=All items have been shipped.;FRA=Tous les articles ont été expédiés.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=You cannot receive more than %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=You cannot receive more than %1 units.;FRA=Vous ne pouvez pas recevoir plus de %1 unité(s).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=No items are currently in transit.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=No items are currently in transit.;FRA=Aucun article n'est en transit.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text011(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=Outbound,Inbound;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=Outbound,Inbound;FRA=Désenlogement,Enlogement;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text012(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU=You have changed one or more dimensions on the %1, which is already shipped. When you post the line with the changed dimension to General Ledger, amounts on the Inventory Interim account will be out of balance when reported per dimension.\\Do you want to keep the changed dimension?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : ENU=You have changed one or more dimensions on the %1, which is already shipped. When you post the line with the changed dimension to General Ledger, amounts on the Inventory Interim account will be out of balance when reported per dimension.\\Do you want to keep the changed dimension?;FRA=Vous avez modifié un ou plusieurs axes analytiques dans %1, qui a déjà été expédié. Lorsque vous validez la ligne avec l'axe analytique modifié dans la comptabilité, les montants de l'état intermédaire stock présentent un déséquilibre si un état est généré par axe analytique.\\Voulez-vous conserver l'axe analytique modifié ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text013(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text013 : ENU=Cancelled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text013 : ENU=Cancelled.;FRA=Annulé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "MustUseTrackingErr(Variable 1023)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //MustUseTrackingErr : @@@="%1 = Form Name, %2 = Value to Enter";ENU=You must use the %1 page to specify the %2, if you use item tracking.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //MustUseTrackingErr : @@@="%1 = Form Name, %2 = Value to Enter";ENU=You must use the %1 page to specify the %2, if you use item tracking.;FRA=Vous devez utiliser la page %1 pour indiquer %2, si vous utilisez la traçabilité.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "LedgEntryWillBeOpenedMsg(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //LedgEntryWillBeOpenedMsg : @@@="%1 = Entry No.";ENU=When posting the Applied to Ledger Entry %1 will be opened first.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //LedgEntryWillBeOpenedMsg : @@@="%1 = Entry No.";ENU=When posting the Applied to Ledger Entry %1 will be opened first.;FRA=Lors de la validation, l'écriture comptable lettrée %1 s'ouvre d'abord.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ShippingMoreUnitsThanReceivedErr(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShippingMoreUnitsThanReceivedErr : @@@="%1 = Quantity Value, %2 = Document No.";ENU=You cannot ship more than the %1 units that you have received for document no. %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShippingMoreUnitsThanReceivedErr : @@@="%1 = Quantity Value, %2 = Document No.";ENU=You cannot ship more than the %1 units that you have received for document no. %2.;FRA=Vous ne pouvez pas expédier plus que les %1 unités que vous avez reçues pour le document n° %2.;
    //Variable type has not been exported.

    var
        Text010: TextConst ENU = 'Change %1 from %2 to %3?', FRA = 'Remplacer %1 de %2 à %3 ?';

    var
        CompanyInfo: Record "Company Information";
        //   LRNDocMgt: Codeunit "LRN Document Mgt.";//---BC Upgrade KAMNAY01>> DITW
        GLSetup: Record "General Ledger Setup";
        SaveGLSetup: Record "General Ledger Setup" temporary;
        InvtSetup: Record "Inventory Setup";
        ItemCharge: Record "Item Charge";
        // LocationGrTo: Record "Location Group";//---BC Upgrade KAMNAY01>> DITW
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        //---BC Upgrade KAMNAY01>> DITW
        // EmcsSetup: Record "EMCS Setup";
        // ItemDrinkTaxGr: Record "Drink Tax Group";
        // LocationGr: Record "Location Group";
        //---BC Upgrade KAMNAY01<< DITW
        LocationTo: Record Location;
        SalesSetup: Record "Sales & Receivables Setup";
        SKU: Record "Stockkeeping Unit";
        //---BC Upgrade KAMNAY01 >>DITW
        // CommonItemChrgMgt: Codeunit "Common Item Charges Mgt.";
        //BomItemCharges: Codeunit "Bom Item Charges Mgt.";Bom Item Charges Mgt.
        //---BC Upgrade KAMNAY01 <<DITW
        GlobalTransferLine: Record "Transfer Line" temporary;
        rTempTransferLine: Record "Transfer Line" temporary;
        //---BC Upgrade KAMNAY01 >> DITW
        // rQualitySetup: Record "Quality Setup";
        //  QualityTestHeader: Record "Quality Test Header";
        //---BC Upgrade KAMNAY01<< DITW
        TransferDerivedRcptLine: Record "Transfer Line";
        WhseSetup: Record "Warehouse Setup";
        cduDistIntegration: Codeunit "Dist. Integration";
        //NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03 - Blocked
        NoSeriesMgt: Codeunit "No. Series";  // BC Upgrade NANDIS03 - Added
        //rMANXLSetup: Record "Manufacturing XL Setup"; //---BC Upgrade KAMNAY01 DITW
        UOMMgt: Codeunit "Unit of Measure Management";
        cduLoginMgmt: Codeunit "User Management";
        blnValidateCrossRef: Boolean;
        CompanySetupRead: Boolean;
        //TransferChargesMgt: Codeunit "Transfer Document Charges Mgt.";////---BC Upgrade KAMNAY01 DITW
        ForceDeleteItemCharges: Boolean;
        GLSetupRead: Boolean;
        HideValidationDialog: Boolean;
        // cduQualityMgt: Codeunit "Quality Management"; //---BC Upgrade KAMNAY01 DITW
        StatusCheckSuspended: Boolean;
        // AADDocMgt: Codeunit "AAD Document Mgt.";//---BC Upgrade KAMNAY01 DITW
        Text2013660: TextConst ENU = 'cannot ne greater than %1.', FRA = 'Ne peut pas être supérieure à %1';
        Text2013661: TextConst ENU = 'cannot be lower than %1.', FRA = 'Ne peut pas être inferieur à %1';
        Text2013662: TextConst ENU = 'You cannot change %1 because the value is automatically calculated with %2.', FRA = 'Vous ne pouvez pas modifier %1 car la valeur est calculé automatiquement avec %2.';
        Text2013663: TextConst ENU = 'At least one item charge tax line must exist with the %1 %2.', FRA = 'Il doit exister au moins une ligne de type taxe avec le %1 %2.';
        Text2013664: TextConst ENU = 'At least one item charge tax line must exist with the %1 %2 attached location %3', FRA = 'Au moins une ligne de taxe doit exister avec %1 %2 avec magasin attachée %3';
        Text2013760: TextConst ENU = 'You cannot input more than %1 units because it is attached to %2 %3 as %4.', FRA = 'Vous ne pouvez pas entrer plus de %1 unités car il est attaché à %2 %3 comme %4.';
        Text2013761: TextConst ENU = 'You cannot modify because it is attached to %1 %2 as %3.', FRA = 'Vous ne pouvez pas modifier, car il est attaché à %1 %2 comme %3.';
        Text2013762: TextConst ENU = 'You cannot change %1 when %2 is %3.', FRA = 'Vous ne pouvez pas modifier %1 si %2 est %3.';
        Text2014060: TextConst ENU = 'The combination of bins used in transfer order %1 is blocked. %2', FRA = 'La combinaison des emplacements utilisée pour l''ordre de transfert %1 est bloquée. %2';
        Text2014260: TextConst ENU = 'You must specify %1 in %2 %3.', FRA = 'Vous devez indiquer %1 dans %2 %3.';
        Text2014261: TextConst ENU = 'The warehouse document %1 is already assigned to %2 %3.', FRA = 'Le document entrepôt %1 possède déjà un %2 %3.';
        //recFinXLSetup: Record "Finance XL Setup";//---BC Upgrade KAMNAY01 DITW
        Text2014262: TextConst ENU = '''%1 in %2 Should be equal to %3.\Do you want to continue ?''', FRA = '''%1 dans %2 devrait être égale à %3.\Souhaitez-vous continuer?''';
        Text2014263: TextConst ENU = 'The user has been interrupted the process to respect the warning.', FRA = 'L''utilisateur a interrompu le processus pour respecter l''alerte.';
        Text2014412: TextConst ENU = 'Do you want to replace the existing item %1 using the item selection?', FRA = 'Souhaitez-vous remplacer l''actuel article %1 par les articles sélectionnés?';
}

