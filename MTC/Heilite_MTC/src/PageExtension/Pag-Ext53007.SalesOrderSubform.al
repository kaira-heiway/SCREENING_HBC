pageextension 53007 SalesOrderSubformExt extends "Sales Order Subform"
{
    // version NAVW110.0.00.16177,FINXL10.00,MANXL7.00.001,DITW110.00.10,HEI.19
    //     DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Tax Item Charges functionnalities
    // DITW15.00.00.01 DDR 02/01/2007 Added column "Line No." (not editable)
    //                                Bugfix AutoSplitKey process on new record with Collapse/Expand functionnality
    // DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    // DITW15.00.00.01 DDR 10/01/2008 Bugfix using F8 on new line
    //                                Change property HorzAlign=Right for collapsed total fields (line amount)
    //                                Added parameter BlankZero for function UpdateFormatField()
    //                                Remove ProcessTaxItemCharge();ProcessUpdateUnitPrice();InsertTaxItemCharge();
    // DITW15.00.00.01 DDR 23/01/2008 Added Drink-it Discount & Promotion Item Charges functionnalities
    //                                Added field "Collapse"
    //                                Bugfix Refresh columns
    //                                Added function UpdateExpandStatus
    //                                Change function UpdateFields for Discount & Promotion
    // DITW15.00.00.01 DDR 05/02/2008 Performance Refresh lines
    // DITW15.00.00.01 DDR 19/03/2008 move function InsertExtendedCharges()
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.16 DDR 26/03/2008 Remove (move into function) confirm message from function InsertExtendedCharges()
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.23 DDR 29/07/2008 Remove call function InsertExtendedCharges() from trigger OnAfterValidate field "No."
    //                                Updated function into InsertExtendedCharges()
    //                     31/07/2008 Move NewRecord() function into OnNewRecord trigger
    //                     11/08/2008 Added UpdateFormatField() and Refresh for fields
    //                                  "Prepayment %","Prepmt. Line Amount","Prepmt. Amt. Inv.",
    //                                  "Prepmt Amt to Deduct","Prepmt Amt Deducted"
    // DITW15.00.00.24 DDR 14/08/2008 added fields "Weight","Cubage" (not editable)
    // DITW15.00.00.28 DDR 24/11/2008 Added fields
    //                                  "AAD No. Series","Tariff No."
    // DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
    //                                  "Empty Goods Item No."
    // DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //                     29/06/2009 issue 669 Disabled standard call function InsertExtendedText() into Trigger field "No."
    //                     21/08/2009 issue 727 Added HorzAlign property in field "Unit Price"
    //                 DLE 06/09/2009 issue 516 Added field "Physical Location Group Code"
    //                 DDR 14/10/2009 issue 893 Removed fields "Gen. Prod. Posting Free Group"
    // DITW15.00.00.36 DDR 04/11/2009 issue 939 Performance SQL
    //                                Added function FormatTotalingField()
    // DITW15.00.00.37 DDR 02/06/2010 issue 1061 Added default Not visible fields "Physical Location Group Code"
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                           Added global variables
    //                                             ActualExpansionStatusInt,TotalLineAmount
    //                                           Added column 1100076000 TotalLineAmount (non-editable,non-visible)
    //                                           Added IsServiceTier() to disable classic collapse
    //                                           Moved C/AL trigger OnDeleteRecord() into new function
    //                                           Added functions
    //                                             RTCActionNewLine(),RTCActionDeleteLine(),RTCActionDeleteLines()
    //                                             TriggerOnDeleteRecord()
    //                                           Moved all field.Editable from function UpdateFormatField() into UpdateFields()
    //                                           Upgrade function for return value + new 2nd argument
    //                                             <ActualExpansionStatusInt> := ReadExpansionStatus(ActualExpansionStatus,<isServiceTier>)
    //                                           Remove functions FormTotalingField()
    //                                           Rewrite functions UpdateFields(),FormTotalingField()
    //                     10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                           Added fields
    //                                             "EMCS LRN Nos Series"
    //                                           Hidden fields
    //                                             "AAD Nos Series"
    //                     08/10/2010            Added fields
    //                                             "SAD No."
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                 CEL 13/08/2010           Modification RTC buttons
    //                 DDR 14/01/2011 DIT-715 #56 missing header of column "Line Amount" (Control76 & 77)
    // DITW15.00.00.38 DDR 19/11/2010 issue 1139 SSCC Functionnalities
    //                                  Added functions OpenSSCCTrackingLines()
    //                     17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    //                     12/01/2011 issue 1251 Review NAV-RTC 6.0 (see issue 1194)
    //                                           Bugfix rounding & decimal places with item charge totaling
    //                                               "Unit Price","Line Amount","Line Discount Amount"
    //                                               All pre-paiment amount fields
    //                                             Removed 'AutoFormatType','AutoFormatExpr' properties fields
    //                                             Added OnFormat() fields
    //                     27/01/2011 issue 1259 Added update() on field "Cross-Reference No."
    //                                           Added non-editable when item is (free) item charge
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                           Added parameter line function RTCActionNewLine() into RTCNewLine button
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #1 RTC Upgrade Page functionnalities
    //                                             Modified function UpdateFields()
    // DITW16.00.00.38 DDR 07/03/2011 DIT-715 #71 RTC Upgrade Page functionnalities
    //                                             Modified order position RTC buttons
    //                                               contol1102601007 RTCNewLine
    //                                               contol1102601008 RTCDeleteLine
    //                                               contol1102601009 RTCDleteAllLines
    //                     15/03/2011 issue 1291 Modified trigger field "No." activate function InsertExtendedText() other than items
    //                     16/03/2011 issue 1217 (DIT711 161) Added field "Packaging Type Code"
    // DITW15.00.00.39 RBE 26/04/2011 issue 1230 Telesales functionnalities
    //                                  Added fields "Sales History","Quantity (Base) History"
    //                                  Review/Move to call function fctCalcQtyBaseHistory() and calculate sales history quantities
    //                     24/06/2011   Bugfix to drilldown "Quantity (Base) History","Average Qty. (Base) History"
    //                     11/07/2011 issue 1369 Added fields "Applies-to AAD Trck. Entry No."
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade Added/Review Total Line Amount (Collapsed RTC)
    // DITW15.00.00.39 DDR 22/08/2011 issue 1399 Added fields "Whse. Shipment No. (Open)"
    //                     26/08/2011 issue 1393 Added AssistEdit property/trigger for field "Item No."
    //                     26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)"
    //                     11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  Added function SetDisableRefreshLines() to call before/after each report object
    //                                                 (don't use the <RunObject> property)
    //                     03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
    //                                                  Added function CreateFEFOTracking()
    //                                                  Moved functions CreateFEFOTracking() into table37
    //                     13/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                     03/04/2012 DIT-715 #243 Loyalty functionnality
    //                                Added fields "Allow Loyalty","Unit Point","Points Qty. (Base)","Loyalty Unit Cost (LCY)"
    //                     03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                             Modified OnAssistEdit trigger field "No."
    //                     13/06/2012 DIT-715 #338 Added functions AllItemsAvailability()
    // DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added to call function SetFilterSubContractPostType() on AfterGetCurrRecord();
    //                                             Added to call function SetFilterSubContractPostType2() on OnNewRecord()
    //                                             Added fields "DIT Sub-Contract Type","Service Contract No.""Contract Group Code"
    //                 AHU 06/11/2012 DIT-715 #393 Added "Description 2" field
    //                 DDR 06/08/2013 DIT-715 #720 Added fields "LRN No.","ARC No.","SAD No.","ARC No. Mandatory",
    //                                               "Cancellation Reason Type","Cancellation Reason Comment"
    //                                             Added functions ShowLineCancelReasonCmts()
    //                 DDR 13/08/2013 DIT-715 #605 Added fields "Manual Unit Price","Last Price Calculated Date","Calculated Unit Price"
    //                                             Modified 'Visible' property fields
    //                                               "Quantity (Base) History","Average Qty. (Base) History"
    // DITW16.00.00.43 DDR 23/08/2013 DIT-715 #720 Added functions OpenEDIDocument()

    // FINXL7.00.001 RBE 20/03/2013 : Added fields "Tariff No." & "Net Weight" (not visible)
    //                                Added field: "Auto. Acc. Group"
    // MANXL7.00.001 DAT 04/03/2014 #15: Replenishment status
    // MANXL7.00.001 WSA 11/07/2014 #87: Added code MANXL security

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 13/08/2013 DIT-715 #720 merge
    //              DDR 14/08/2013 DIT-715 #605 merge
    //              DDR 23/08/2013 DIT-715 #720 merge
    // DITW17.00.02 AT  12/09/2013 DIT-770 #132 merge WHN-006 HIT0122.1
    //                             Add new field to DIT #376 promotion reason codes
    // DITW17.00.02 AT  12/09/2013 DIT-770 #154
    //                             Added fields
    //                             2014097 Picklist Printed (date/time)
    //                             2014096 Picking Type
    //                             Altered Quick Entry of all fields
    // DITW17.00.02 AT  24/09/2013 DIT-770 #132
    //                             Added field Free Reason Code
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 11/20/2013 DIT-770 #166 New Field "Delayed Sequence No." added
    // DITW17.10.03 DDR 22/04/2014 DIT-770 #570 Added menu 'Item Charge &Assignment (DIT)'
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.03 DDR 21/05/2014 DIT-770 #623 Added non-editable fields "Customer DTax Group Code","Item DTax Group Code"
    // DITW17.10.03 DDR 10/06/2014 DIT-770 #541 WORKAROUND NAV 2013 R2 Build 35473 (TESTED OK Build 36703 before workaround)
    //                                            - QuickEntry doesn't work with dynamic editable field
    //                                            - QuickEntry field doesn't work with IndentationControls property
    //                                          Modified 'QuickEntry' property fields "Has Item Charge","Collapse"
    //                                          Removed 'Editable','Enabled' dynamic properties field "No."
    //                                         Removed 'IndentationControls','IndentationColumnName' properities field1 Group Repeater
    // DITW17.10.03 DDR 11/06/2014 DIT-770 #570 Added shortcut for menu 'Item Charge Assignment (DIT)'
    // DITW17.10.03 DDR 10/07/2014 DIT-770 #541 Added editable other types than Item
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added field "Responsibity Center"
    // DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692 Employee free benefits with tax due and tax not due sales lines
    // DITW17.10.05 DDR 12/08/2014 DIT-770 #748 Added button insert new line at end
    // DITW17.10.05 DDR 04/09/2014 DIT-770 #695 Added fields "Allow Price Dit Discount"
    // DITW17.10.05 DDR 08/09/2014 DIT-770 #695 Modified non-editable "Allow Price Dit Discount"
    // DITW17.10.05 WSA 31/10/2014 DIT-770 #185 Added fields "Loyalty Point Type" "Loyalty Cost Type"
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Unit Price"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 MSF 11/11/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW17.10.05 WSA 02/02/2015 DIT-770 #185 Added code to update page
    // DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 Added Field 2014100 "Trailer Code"
    // DITW18.00.06 MSF 06/07/2015 DIT-770 #1035 Delete Field 2014100 "Trailer Code" Not Needed
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type
    // DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    // DITW18.00.07 VSC 03/06/2016 DIT-770 #2007 Fix merge issue. Deleted double action "Order".
    // DITW18.00.07 VSC 05/07/2016 DIT-770 #1782 Removed Function SalesHistoryCalculationOnAfter and fields
    //                                           "Sales History Calculation"
    //                                           "Quantity (Base) History"
    //                                           "Average Qty. (Base) History"
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields "Strength Spec. Code","Strength Spec. Value","Vol-Strength Spec. Code","Vol-Strength Spec. Value","Unit Volume HL"
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Removed 'Editable' property for fields "strength Spec. Value","vol-strength Spec. Value"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 24/02/2017 NRQ#21530 Bugfix NAV CU1 replaced by CU3
    // FINXL9.00.000.01 ACH 10/01/2017 : Recycle charges functionnalities
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.09 DDR 28/03/2017 NRQ#9647 automatically open Cancellation Reason Comments when changing Cancellation Reason Type
    // DITW110.00.09 AKH 10/04/2017 NRQ#24104 Adjusted Editable & Enabled properties for fields (DIT vs XL)
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Added new fields "Backorder Type", added action "Blanket Order (Back Order)"

    // HEI.01 FDD-OTCGAP063 IBM.NAIKH01 04/07/2017 -Block Invoice Discount Amount and Percentage value on the Sales Order
    //   # Changed the Editable property of field "InvoiceDiscountAmount" from "InvDiscAmountEditable" to False
    //   # Changed the Editable property of field "InvoiceDiscountPct" from "InvDiscAmountEditable" to False
    // HEI.02 FDD-OTCGAP065 IBM.HORTOC01 11.07.2017
    //   # Add code on "On lookup" trigger of "Location Code" field
    // HEI.03 FDD HNK SLSGAP009 IBM ISYED01 30/05/2017
    //   #change of unit price with Item expanded containing charge item and without charge item user should not be able to make changes.
    // HEI.04 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //   # New fields for MDM integration: WHT Business Posting Group, WHT Product Posting Group, WHT Absorb Base
    // HEI.05 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    //   # New field "RPM Damage / Loss" added
    //   # New field "Transporter RPM Damage / Loss" added
    // HEI.06 FDD-PRDGAP031 Def732 IBM PATHAA02 24.10.2017
    // # Description"-Editable Property changed from EditableLine to <FALSE>
    // # Description changed to Editable Desc
    // # Code on OnAfterGetRecord
    // HEI.07 Defect #745 IBM NASTAA02 11.01.2018 # Prevent User to change discounts
    //   # "Line Amount Excl VAT" and "Line Discount %" should not be changed by the user
    //   # "Line Discount Amount" should not be changed by the user
    // HEI.08 FDD-SLSGAP015 IBM NASTAA02 24.04.2018 # Default Dimensions in the Promotion Charges
    //   # Used function "UpdateFreeReasonCodeDimensions" on OnValidate Trigger of "Quantity" to update Free Reason Code Dimensions
    // HEI.09 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Field added: "TIN No."
    // DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackUnitPriceItem()
    // HEI.10 Defect 3457 IBM.NAIKH01 13.12.2018
    //   # Set the Field "VAT Bus. Posting Group" Visible to False
    // DITW111.00.13 MSF 06/12/2018 NRQ#94671 Line and header alert for not fully assigned lines - in warehouse shipment and sales order
    //                                        Added field lot no.
    // DITW111.00.13 MSF 13/12/2018 NRQ#94671 check based on outstanding Qty
    // HEI.11 FDD-SLSGAP023 IBM BULIMC01 14.06.2019 #code commented
    // HEI.13 FDD-HB570 IBM BULIMC01 28/08/2019 #disable the possibility to delete the item charges on an open sales order
    // HEI.14 FDD-HT581 IBM SURYAS01 28.08.2019
    //   #Added code on Free reason code Onvalidate trigger.
    // HEI.15 CHG2026335 HT653 FDD_La Reunion_EDI_EDI Order IBM GAVANM01 04.10.2019
    //   #new fields added: EDI unit of measure(visible=FALSE), Product GTIN code (visible=FALSE)
    // HEI.16 CHG2098524 Code Commented
    //   Code commented
    // HEI.17 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Field added: "CAD Amount"
    // HEI.18 CHG2178940 IBM COSTES04  16.01.2023 # Add Required Freshness field on Customer Card
    //   # Add new field RFreshness Date (min)
    // HEI.19 CHG2168337 HB2821 IBM BHANDS01 22.02.2023 Astro WMS Integration
    //   # Making the field "Freshness Date (min)" non editable
    // HEI.20 CHG2259343-HB4010 IBM BHANDS01 10.06.2025 Merge of Aptean fix NRQ#411060
    //   # NRQ#411060 DDR 22/05/2025 Add fields "Auto Post Non-Invt. via Whse.", "Attached Lines Count"
    //                           Add action "Attach to Inventory Item Line" in function button

    // BC Upgrade SHUKLP03 >>
    // Blocked CAD feature related code.
    // HEI.08,HEI.11 => Field quantity - OnValidate() code already blocked in Nav.
    // HEI.14 => code for field Free Reason Code - OnValidate() is not added because DIT field.
    // DIT fields and code is not added.
    // HEI.20 => Aptean fix NRQ#411060 is not added because DIT field and action.
    // BC Upgrade SHUKLP03 <<
    // BC Upgrade BHARDA11 >>
    // 1. Unblocked CAD Amount Commented code and enable CAD Amount Functionality.
    // BC Upgrade BHARAD11 <<


    layout
    {
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the type of entity that will be posted for this sales line, such as Item, Resource, or G/L Account.', FRA = 'Spécifie le type d''entité qui sera validé pour cette ligne vente, tel qu''Article, Ressource, ou Compte général.';
            // Enabled = TypeEnable; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on "Type(Control 2)". Please convert manually.

        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of a general ledger account, item, resource, additional cost, or fixed asset, depending on the contents of the Type field.', FRA = 'Spécifie le numéro d''un compte général, d''un article, d''une ressource, d''un coût supplémentaire ou d''une immobilisation, selon ce que vous avez sélectionné dans le champ Type.';
            //Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""No."(Control 4)". Please convert manually.

        }
        modify("IC Partner Code")
        {
            ToolTipML = ENU = 'Specifies the IC partner code of the partner to whom you want to distribute the revenue of the sales line.', FRA = 'Spécifie le code du partenaire IC du partenaire auquel vous voulez répartir le produit de la ligne vente.';
            //Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""IC Partner Code"(Control 1136)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("IC Partner Ref. Type")
        {
            ToolTipML = ENU = 'Specifies the item or account in your IC partner''s company that corresponds to the item or account on the line.', FRA = 'Spécifie l''article ou le compte de la société de votre partenaire IC correspondant à l''article ou au compte de la ligne.';
            //Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""IC Partner Ref. Type"(Control 130)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("IC Partner Reference")
        {
            ToolTipML = ENU = 'Specifies the item or account in your IC partner''s company that corresponds to the item or account on the line.', FRA = 'Spécifie l''article ou le compte de la société de votre partenaire IC correspondant à l''article ou au compte de la ligne.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""IC Partner Reference"(Control 132)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a variant code for the item.', FRA = 'Spécifie un code variante pour l''article.';
            //Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Variant Code"(Control 30)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Substitution Available")
        {
            ToolTipML = ENU = 'Specifies that a substitute is available for the item on the sales line.', FRA = 'Spécifie qu''un article de substitution est disponible pour l''article sur la ligne vente.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Substitution Available"(Control 104)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Purchasing Code")
        {
            ToolTipML = ENU = 'Specifies the purchasing code for the item.', FRA = 'Spécifie le code achat pour l''article.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Purchasing Code"(Control 74)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify(Nonstock)
        {
            ToolTipML = ENU = 'Specifies that this item is a nonstock item.', FRA = 'Spécifie que cet article est non stocké.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on "Nonstock(Control 70)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code for the VAT product posting group of the item, resource, or general ledger account on this line.', FRA = 'Spécifie le code du groupe comptabilisation produit TVA de l''article, de la ressource ou du compte général de la ligne.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""VAT Prod. Posting Group"(Control 78)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry, which is based on the contents of the Type and No. fields.', FRA = 'Spécifie une description de l''entrée qui est basée sur le contenu des champs Type et N°.';
            //Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.
            Editable = EditableDesc; // BC Upgrade SHUKLP03 << HEI.06
            //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.

        }
        modify("Drop Shipment")
        {
            ToolTipML = ENU = 'Specifies if your vendor will ship the items on the line directly to your customer.', FRA = 'Spécifie si vous souhaitez que votre fournisseur livre les articles de la ligne directement à votre client.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Drop Shipment"(Control 26)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Special Order")
        {
            ToolTipML = ENU = 'Specifies that the item on the sales line is a special-order item.', FRA = 'Spécifie que l''article de la ligne vente est une commande spéciale.';
            //Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Special Order"(Control 106)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Return Reason Code")
        {
            ToolTipML = ENU = 'Specifies a code that explains why the item is returned.', FRA = 'Spécifie un code expliquant la raison du renvoi de l''article.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Return Reason Code"(Control 110)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin from where items on the sales order line are taken from when they are shipped.', FRA = 'Spécifie l''emplacement à partir duquel les articles de la ligne commande vente ont été prélevés lorsqu''ils sont expédiés.';
            QuickEntry = FALSE;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = FALSE; // BC Upgrade SHUKLP03 << HEI.10
        }
        modify("Qty. to Assemble to Order")
        {
            ToolTipML = ENU = 'Specifies how many units of the sales line quantity that you want to supply by assembly.', FRA = 'Spécifie le nombre d''unités de la quantité de la ligne vente que vous souhaitez fournir par assemblage.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Qty. to Assemble to Order"(Control 3)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Reserved Quantity")
        {
            ToolTipML = ENU = 'Specifies how many units of the item on the line have been reserved.', FRA = 'Spécifie le nombre d''unités de la ligne qui ont été réservées.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure that is used to determine the value in the Unit Price field on the sales line.', FRA = 'Spécifie l''unité de mesure utilisée pour déterminer la valeur dans le champ Prix unitaire de la ligne vente.';
        }
        // BC Upgrade SHUKLP03 >> Added code on trigger OnAfterValidate for fields.

        modify("Unit Price")
        {
            trigger OnAfterValidate()
            var
            begin
                UnitPriceOnAfterValidate();
            end;
        }
        // BC Upgrade SHUKLP03 << Added code on trigger OnAfterValidate for fields.

        modify("Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the unit of measure for the item or resource on the sales line.', FRA = 'Spécifie l''unité de mesure de l''article ou de la ressource sur la ligne vente.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Unit of Measure"(Control 10)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Unit Cost (LCY)")
        {
            ToolTipML = ENU = 'Specifies the unit cost of the item on the line.', FRA = 'Spécifie le coût unitaire pour l''article sur la ligne.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Unit Cost (LCY)"(Control 38)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify(SalesPriceExist)
        {
            CaptionML = ENU = 'Sales Price Exists', FRA = 'Prix vente existant';
            ToolTipML = ENU = 'Specifies that there is a specific price for this customer.', FRA = 'Spécifie qu''un prix spécifique existe pour ce client.';
            QuickEntry = FALSE;
        }
        modify(SalesLineDiscExists)
        {
            CaptionML = ENU = 'Sales Line Disc. Exists', FRA = 'Rem. ligne vente existante';
            ToolTipML = ENU = 'Specifies that there is a specific discount for this customer.', FRA = 'Spécifie qu''une remise spécifique existe pour ce client.';
            QuickEntry = FALSE;
        }
        modify("Line Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of the discount that will be given on the invoice line.', FRA = 'Spécifie le montant de la remise qui est accordée sur la ligne facture.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Line Discount Amount"(Control 52)". Please convert manually.

            QuickEntry = FALSE;
            // BC Upgrade SHUKLP03 >> Added code on trigger OnAfterValidate for fields.

            trigger OnAfterValidate()
            var
            begin
                LineDiscountAmountOnAfterValid();
            end;
            // BC Upgrade SHUKLP03 >> Added code on trigger OnAfterValidate for fields.


        }
        // BC Upgrade SHUKLP03 << Added code on trigger OnAfterValidate for fields.

        modify("Line Discount %")
        {
            trigger OnAfterValidate()
            var
            begin
                LineDiscount37OnAfterValidate();
            end;
        }
        // BC Upgrade SHUKLP03 << Added code on trigger OnAfterValidate for fields.

        modify("Prepayment %")
        {
            ToolTipML = ENU = 'Specifies the prepayment percentage if a prepayment should apply to the sales line.', FRA = 'Spécifie le pourcentage acompte si un acompte doit être appliqué à la ligne vente.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Prepayment %"(Control 136)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Prepmt. Line Amount")
        {
            ToolTipML = ENU = 'Specifies the prepayment amount of the line in the currency of the sales document if a prepayment percentage is specified for the sales line.', FRA = 'Spécifie le montant de l''acompte de la ligne dans la devise du document vente si un pourcentage acompte est spécifié pour la ligne vente.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Prepmt. Line Amount"(Control 138)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Prepmt. Amt. Inv.")
        {
            ToolTipML = ENU = 'Specifies the prepayment amount that has already been invoiced to the customer for this sales line.', FRA = 'Spécifie le montant d''acompte qui a déjà été facturé au client pour cette ligne vente.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Prepmt. Amt. Inv."(Control 140)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Allow Invoice Disc.")
        {
            ToolTipML = ENU = 'Specifies whether the invoice line is included when the invoice discount is calculated.', FRA = 'Spécifie si la ligne facture est incluse lors du calcul de la remise facture.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Allow Invoice Disc."(Control 54)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Inv. Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the invoice discount amount for the line.', FRA = 'Spécifie le montant de la remise facture pour la ligne.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Inv. Discount Amount"(Control 90)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Qty. to Ship")
        {
            ToolTipML = ENU = 'Specifies how many units of the item are to be shipped when the sales order is posted.', FRA = 'Spécifie le nombre d''unités de l''article à expédier lorsque la commande vente est validée.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Qty. to Ship"(Control 18)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Quantity Shipped")
        {
            ToolTipML = ENU = 'Specifies the number of units of the ordered item that have been shipped.', FRA = 'Spécifie le nombre d''unités de l''article commandé qui ont été livrées.';
        }
        modify("Qty. to Invoice")
        {
            ToolTipML = ENU = 'Specifies how much of the line should be invoiced.', FRA = 'Indique la quantité à facturer pour la ligne.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Qty. to Invoice"(Control 22)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Quantity Invoiced")
        {
            ToolTipML = ENU = 'Specifies how many units of the item on the line have already been invoiced.', FRA = 'Spécifie le nombre d''unités de la ligne qui ont déjà été facturées.';
            QuickEntry = FALSE;
        }
        modify("Prepmt Amt to Deduct")
        {
            ToolTipML = ENU = 'Specifies the prepayment amount that will be deducted from the next ordinary invoice for this line.', FRA = 'Spécifie le montant d''acompte qui sera déduit de la prochaine facture ordinaire pour cette ligne.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Prepmt Amt to Deduct"(Control 142)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Prepmt Amt Deducted")
        {
            ToolTipML = ENU = 'Specifies the prepayment amount that has already been deducted from ordinary invoices posted for this sales order line.', FRA = 'Spécifie le montant d''acompte qui a déjà été déduit des factures ordinaires validées pour cette ligne commande vente.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Prepmt Amt Deducted"(Control 144)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Allow Item Charge Assignment")
        {
            ToolTipML = ENU = 'Specifies that you can assign item charges to this line.', FRA = 'Spécifie que vous pouvez affecter des frais annexes à cette ligne.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Allow Item Charge Assignment"(Control 46)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Qty. to Assign")
        {
            ToolTipML = ENU = 'Specifies the quantity of the item charge that will be assigned to a specified item when you post this sales line. You fill this field through the Qty. to Assign field in the Item Charge Assignment (Sales) window that you open with the Item Charge Assignment action on the Lines FastTab.', FRA = 'Spécifie la quantité de frais annexe qui sera affecté à un article spécifique lorsque vous validez cette ligne vente. Vous remplissez ce champ via le champ Qté à affecter dans la fenêtre Affect. frais annexes (vente) que vous ouvrez avec l''action Affectation frais annexes sur le raccourci Lignes.';
        }
        modify("Qty. Assigned")
        {
            ToolTipML = ENU = 'Specifies the quantity of the item charge that was assigned to a specified item when you posted this sales line.', FRA = 'Spécifie la quantité de frais annexes affectés à un élément spécifié lors de la validation de cette ligne vente.';
        }
        modify("Requested Delivery Date")
        {
            ToolTipML = ENU = 'Specifies the date that the customer has asked for the order to be delivered.', FRA = 'Spécifie la date à laquelle le client a demandé à être livré.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Requested Delivery Date"(Control 82)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Promised Delivery Date")
        {
            ToolTipML = ENU = 'Specifies the date that you have promised to deliver the order, as a result of the Order Promising function.', FRA = 'Spécifie la date à laquelle vous avez promis de livrer la commande via la fonction Promesse de livraison.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Promised Delivery Date"(Control 84)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Planned Delivery Date")
        {
            ToolTipML = ENU = 'Specifies the planned date that the shipment will be delivered at the customer''s address.', FRA = 'Spécifie la date planifiée à laquelle l''expédition doit être livrée à l''adresse du client.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Planned Delivery Date"(Control 86)". Please convert manually.

        }
        modify("Planned Shipment Date")
        {
            ToolTipML = ENU = 'Specifies the date that the shipment should ship from the warehouse.', FRA = 'Spécifie la date à laquelle l''expédition doit quitter l''entrepôt.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Planned Shipment Date"(Control 88)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Shipment Date")
        {
            ToolTipML = ENU = 'Specifies the date that the items on the line are in inventory and available to be picked.', FRA = 'Spécifie la date à laquelle les articles de la ligne sont en stock et disponibles pour le prélèvement.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Shipment Date"(Control 100)". Please convert manually.

        }
        modify("Shipping Agent Code")
        {
            ToolTipML = ENU = 'Specifies the code that represents the shipping agent.', FRA = 'Spécifie le code qui représente le transporteur.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Shipping Agent Code"(Control 92)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Shipping Agent Service Code")
        {
            ToolTipML = ENU = 'Specifies the code that represents a shipping agent service.', FRA = 'Spécifie le code qui représente une prestation transporteur.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Shipping Agent Service Code"(Control 94)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Shipping Time")
        {
            ToolTipML = ENU = 'Specifies how long it takes from when the sales order line is shipped from the warehouse to when the order is delivered.', FRA = 'Spécifie le délai nécessaire entre l''expédition de la ligne commande vente à partir de l''entrepôt et la livraison de la commande.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Shipping Time"(Control 96)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Work Type Code")
        {
            ToolTipML = ENU = 'Belongs to the Job application area.', FRA = 'Appartient au domaine d''application Projets.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Work Type Code"(Control 134)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Whse. Outstanding Qty.")
        {
            ToolTipML = ENU = 'Specifies how many units on the sales order line remain to be handled in warehouse documents.', FRA = 'Spécifie le nombre d''unités de la ligne commande vente qui restent à traiter dans les documents entrepôt.';
            QuickEntry = FALSE;
        }
        modify("Whse. Outstanding Qty. (Base)")
        {
            ToolTipML = ENU = 'Specifies how many units on the sales order line remain to be handled in warehouse documents.', FRA = 'Spécifie le nombre d''unités de la ligne commande vente qui restent à traiter dans les documents entrepôt.';
            QuickEntry = FALSE;
        }
        modify("ATO Whse. Outstanding Qty.")
        {
            ToolTipML = ENU = 'Specifies how many assemble-to-order units on the sales order line need to be assembled and handled in warehouse documents.', FRA = 'Spécifie le nombre d''unités à assembler pour commande de la ligne commande vente qui doivent être assemblées et traitées dans les documents entrepôt.';
            QuickEntry = FALSE;
        }
        modify("ATO Whse. Outstd. Qty. (Base)")
        {
            ToolTipML = ENU = 'Specifies how many assemble-to-order units on the sales order line remain to be assembled and handled in warehouse documents.', FRA = 'Spécifie le nombre d''unités à assembler pour commande de la ligne commande vente qui restent à assembler et traiter dans les documents entrepôt.';
            QuickEntry = FALSE;
        }
        modify("Outbound Whse. Handling Time")
        {
            ToolTipML = ENU = 'Specifies the outbound warehouse handling time.', FRA = 'Spécifie le délai désenlogement.';

            //Unsupported feature: Change Editable on ""Outbound Whse. Handling Time"(Control 98)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Blanket Order No.")
        {
            ToolTipML = ENU = 'Specifies the document number of the blanket order from which this sales line originates.', FRA = 'Spécifie le numéro de document de la commande ouverte qui est à l''origine de cette ligne vente.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Blanket Order No."(Control 62)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Blanket Order Line No.")
        {
            ToolTipML = ENU = 'Specifies the line number of the blanket order line from which this sales line originates.', FRA = 'Spécifie le numéro de ligne de la ligne de la commande ouverte qui est à l''origine de cette ligne vente.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Blanket Order Line No."(Control 66)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("FA Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date that will be used as the FA posting date on FA ledger entries.', FRA = 'Spécifie la date qui sera utilisée comme date comptabilisation immobilisation sur les écritures comptables immobilisation.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""FA Posting Date"(Control 14)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Depr. until FA Posting Date")
        {
            ToolTipML = ENU = 'You can use this field if you have selected Fixed Asset in the Type field for this line.', FRA = 'Vous pouvez utiliser ce champ si vous avez sélectionné Immobilisation dans le champ Type de cette ligne.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Depr. until FA Posting Date"(Control 40)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Depreciation Book Code")
        {
            ToolTipML = ENU = 'Specifies the code for the depreciation book to which the line will be posted if you have selected Fixed Asset in the Type field for this line.', FRA = 'Spécifie le code des lois d''amortissement sur lesquelles la ligne sera validée, si vous avez sélectionné Immobilisation dans le champ Type de cette ligne.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Depreciation Book Code"(Control 36)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Use Duplication List")
        {
            ToolTipML = ENU = 'You can use this field if you have selected Fixed Asset in the Type field for this line.', FRA = 'Vous pouvez utiliser ce champ si vous avez sélectionné Immobilisation dans le champ Type de cette ligne.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Use Duplication List"(Control 80)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Duplicate in Depreciation Book")
        {
            ToolTipML = ENU = 'You can use this field if you have selected Fixed Asset in the Type field for this line.', FRA = 'Vous pouvez utiliser ce champ si vous avez sélectionné Immobilisation dans le champ Type de cette ligne.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Duplicate in Depreciation Book"(Control 56)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Appl.-from Item Entry")
        {
            ToolTipML = ENU = 'Specifies the number of the item ledger entry that the sales credit memo line is applied from.', FRA = 'Spécifie le numéro de l''écriture comptable article à partir de laquelle la ligne avoir vente est lettrée.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Appl.-from Item Entry"(Control 108)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Appl.-to Item Entry")
        {
            ToolTipML = ENU = 'Specifies the item ledger entry number the line should be applied to.', FRA = 'Spécifie le numéro de l''écriture comptable article avec laquelle la ligne doit être lettrée.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Appl.-to Item Entry"(Control 60)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Shortcut Dimension 1 Code"(Control 32)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
            // Enabled = EditableLine; // BC Upgrade SHUKLP03 << Blocked this code because it is not required. As this variable value was getting updated in DIT code.

            //Unsupported feature: Change Editable on ""Shortcut Dimension 2 Code"(Control 34)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number.', FRA = 'Spécifie le numéro du document.';
            QuickEntry = FALSE;
        }
        modify("Line No.")
        {
            ToolTipML = ENU = 'Specifies the line number.', FRA = 'Spécifie le numéro de ligne.';
            QuickEntry = FALSE;
        }
        modify("TotalSalesLine.""Line Amount""")
        {
            CaptionML = ENU = 'Subtotal Excl. VAT', FRA = 'Sous-total HT';
            ToolTipML = ENU = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document.', FRA = 'Spécifie la somme de la valeur dans le champ Montant acompte HT sur toutes les lignes du document.';
        }
        modify("Invoice Discount Amount")
        {
            CaptionML = ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
            ToolTipML = ENU = 'Specifies a discount amount that is deducted from the value in the Total Incl. VAT field. You can enter or change the amount manually.', FRA = 'Spécifie un montant de remise qui est déduit de la valeur dans le champ Total TTC. Vous pouvez saisir ou modifier le montant manuellement.';
            Editable = FALSE;  // BC Upgrade SHUKLP03 << HEI.01 Change Editable property to FALSE

            //Unsupported feature: Change Editable on ""Invoice Discount Amount"(Control 43)". Please convert manually.

        }
        modify("Invoice Disc. Pct.")
        {
            CaptionML = ENU = 'Invoice Discount %', FRA = '% remise facture';
            ToolTipML = ENU = 'Specifies a discount percentage that is granted if criteria that you have set up for the customer are met.', FRA = 'Indique un pourcentage de remise qui est accordé si les critères que vous avez paramétrés pour le client sont réunis.';
            Editable = FALSE;  // BC Upgrade SHUKLP03 << HEI.01 Change Editable property to FALSE
            //Unsupported feature: Change Editable on ""Invoice Disc. Pct."(Control 41)". Please convert manually.

        }
        modify("Total Amount Excl. VAT")
        {
            CaptionML = ENU = 'Total Amount Excl. VAT', FRA = 'Montant total HT';
            ToolTipML = ENU = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.', FRA = 'Spécifie la somme de la valeur du champ Montant ligne HT sur toutes les lignes du document, moins l''éventuel montant remise indiqué dans le champ Montant remise facture.';
        }
        modify("Total VAT Amount")
        {
            CaptionML = ENU = 'Total VAT', FRA = 'Total TVA';
            ToolTipML = ENU = 'Specifies the sum of VAT amounts on all lines in the document.', FRA = 'Spécifie la somme des montants de TVA sur toutes les lignes du document.';
        }
        modify("Total Amount Incl. VAT")
        {
            CaptionML = ENU = 'Total Amount Incl. VAT', FRA = 'Montant total TTC';
            ToolTipML = ENU = 'Specifies the sum of the value in the Line Amount Incl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.', FRA = 'Spécifie la somme de la valeur du champ Montant TTC sur toutes les lignes du document, moins l''éventuel montant remise indiqué dans le champ Montant remise facture.';
        }
        modify("Line Amount")
        {
            trigger OnAfterValidate()
            var
            begin
                LineAmountOnAfterValidate;
            end;
        }

        // BC Upgrade SHUKLP03 >> Blocked Txt2Al file already blocked code with //.
        // //Unsupported feature: CodeInsertion on ""No."(Control 4)". Please convert manually.

        // //trigger OnAssistEdit();
        // //Parameters and return type have not been exported.
        // //begin
        // /*
        // // <<DITW15.00.00.39 DDR 26/08/2011 #1393 - DITW16.00.00.40 DDR 03/05/2012 DIT-715 #276
        // if AssistEditItemTreeview("No.") then begin
        //   // validate trigger
        //   ShowShortcutDimCode(ShortcutDimCode);

        //   // aftervalidate trigger
        //   CurrPage.SAVERECORD;

        //   if (Reserve = Reserve::Always) and
        //      ("Outstanding Qty. (Base)" <> 0) and
        //      ("No." <> xRec."No.")
        //   then
        //     AutoReserve;
        // end;

        // CurrPage.UPDATE(false);
        // // >>DITW15.00.00.39 DDR #1393 - DITW16.00.00.40 DDR DIT-715 #276
        // */
        // //end;


        // //Unsupported feature: CodeModification on ""No."(Control 4).OnValidate". Please convert manually.

        // //trigger "(Control 4)();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // NoOnAfterValidate;
        // UpdateEditableOnRow;
        // ShowShortcutDimCode(ShortcutDimCode);

        // QuantityOnAfterValidate;
        // if xRec."No." <> '' then
        //   RedistributeTotalsOnAfterValidate;
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // // <<DITW17.10.03 DDR 10/06/2014 DIT-770 #541
        // if not ("No.Editable" or "No.Enable") then begin
        //   "No." := xRec."No.";
        //   exit;
        // end;
        // // >>DITW17.10.03 DDR DIT-770 #541
        // #1..7
        // */
        // //end;


        // //Unsupported feature: CodeModification on ""Cross-Reference No."(Control 68).OnLookup". Please convert manually.

        // //trigger "(Control 68)();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // CrossReferenceNoLookUp;
        // NoOnAfterValidate;
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // CrossReferenceNoLookUp;
        // NoOnAfterValidate;
        // // <<DITW15.00.00.38 DDR 27/01/2011 #1259
        // CurrPage.UPDATE;
        // // >>DITW15.00.00.38 DDR #1259
        // */
        // //end;


        // //Unsupported feature: CodeModification on "Quantity(Control 8).OnValidate". Please convert manually.

        // //trigger OnValidate();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // QuantityOnAfterValidate;
        // RedistributeTotalsOnAfterValidate;
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // QuantityOnAfterValidate;
        // RedistributeTotalsOnAfterValidate;

        // //UpdateFreeReasonCodeDimensions; //HEI.08 //HEI.11
        // */
        // //end;


        // //Unsupported feature: CodeModification on ""Unit Price"(Control 12).OnValidate". Please convert manually.

        // //trigger OnValidate();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // RedistributeTotalsOnAfterValidate;
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // RedistributeTotalsOnAfterValidate;
        // UnitPriceOnAfterValidate;
        // */
        // //end;


        // //Unsupported feature: CodeModification on ""Line Amount"(Control 76).OnValidate". Please convert manually.

        // //trigger OnValidate();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // RedistributeTotalsOnAfterValidate;
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // RedistributeTotalsOnAfterValidate;
        // LineAmountOnAfterValidate;
        // */
        // //end;


        // //Unsupported feature: CodeModification on ""Line Discount %"(Control 16).OnValidate". Please convert manually.

        // //trigger OnValidate();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // RedistributeTotalsOnAfterValidate;
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // RedistributeTotalsOnAfterValidate;
        // LineDiscount37OnAfterValidate;
        // */
        // //end;


        // //Unsupported feature: CodeModification on ""Line Discount Amount"(Control 52).OnValidate". Please convert manually.

        // //trigger OnValidate();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // RedistributeTotalsOnAfterValidate;
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // RedistributeTotalsOnAfterValidate;
        // LineDiscountAmountOnAfterValid;
        // */
        // //end;


        // //Unsupported feature: CodeModification on ""Prepayment %"(Control 136).OnValidate". Please convert manually.

        // //trigger OnValidate();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // RedistributeTotalsOnAfterValidate;
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // RedistributeTotalsOnAfterValidate;
        // Prepayment37OnAfterValidate;
        // */
        // //end;


        // //Unsupported feature: CodeModification on ""Prepmt. Line Amount"(Control 138).OnValidate". Please convert manually.

        // //trigger  Line Amount"(Control 138)();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // RedistributeTotalsOnAfterValidate;
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // RedistributeTotalsOnAfterValidate;
        // PrepmtLineAmountOnAfterValidat;
        // */
        // //end;


        // //Unsupported feature: CodeModification on ""Qty. to Ship"(Control 18).OnValidate". Please convert manually.

        // //trigger  to Ship"(Control 18)();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // if "Qty. to Asm. to Order (Base)" <> 0 then begin
        //   CurrPage.SAVERECORD;
        //   CurrPage.UPDATE(false);
        // end;
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // QtytoShipOnAfterValidate;
        // #1..4
        // */
        // //end;


        // //Unsupported feature: CodeInsertion on ""Qty. to Invoice"(Control 22)". Please convert manually.

        // //trigger OnValidate();
        // //Parameters and return type have not been exported.
        // //begin
        // /*
        // QtytoInvoiceOnAfterValidate;
        // */
        // //end;


        // //Unsupported feature: CodeInsertion on ""Prepmt Amt to Deduct"(Control 142)". Please convert manually.

        // //trigger OnValidate();
        // //Parameters and return type have not been exported.
        // //begin
        // /*
        // PrepmtAmttoDeductOnAfterValida;
        // */
        // //end;
        // BC Upgrade SHUKLP03 << Blocked Txt2Al file already blocked code with //.


        // BC Upgrade SHUKLP03 >> Blocked DIT fields.
        // addfirst(Control1)
        // {
        //     field("Has Item Charge"; Rec."Has Item Charge")
        //     {
        //         BlankZero = true;
        //         QuickEntry = false;
        //     }
        //     field(Collapse; Collapse)
        //     {
        //         QuickEntry = false;
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW15.00.00.37 DDR 19/01/2010
        //             CurrPage.UPDATE(true);
        //             // >>DITW15.00.00.37 DDR
        //         end;
        //     }
        // }

        // addafter("No.")
        // {
        //     field("Item Charge Type"; Rec."Item Charge Type")
        //     {
        //         ApplicationArea = All;
        //     }

        // }
        // addafter("VAT Prod. Posting Group")
        // {
        //     field("GetTrackingItemNo()"; GetTrackingItemNo())
        //     {
        //         CaptionML = ENU = 'Tracking Item No. (Item Charge)',
        //                     FRA = 'N° article traçable (Frais annexes)';
        //         DrillDownPageID = "Item List";
        //         Editable = false;
        //         LookupPageID = "Item List";
        //         QuickEntry = false;
        //         TableRelation = IF ("Item Charge Type" = CONST(Tax)) Item WHERE("No." = FIELD("Tax Item No."))
        //         ELSE IF ("Item Charge Type" = CONST(Deposit)) Item WHERE("No." = FIELD("Empty Goods Item No."));
        //         Visible = false;
        //         ApplicationArea = All;

        //         trigger OnLookup(Text: Text): Boolean;
        //         begin
        //             // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //             Text := GetTrackingItemNo();
        //             LookupItemNo(Text);
        //             exit(false);
        //         end;
        //     }
        //     field(tbxReplenishmentStatus; txtReplenishmentStatus)
        //     {
        //         CaptionML = ENU = 'Replenishment Status',
        //                     FRA = 'Etat Réapprovisionnement';
        //         Description = 'MANXL7.00.001';
        //         Editable = false;
        //         QuickEntry = false;
        //         Style = Attention;
        //         StyleExpr = blnNoStock;
        //         Visible = false;
        //         ApplicationArea = All;

        //         // BC Upgrade SHUKLP03 >> Blocked DIT code.
        //         // trigger OnAssistEdit();
        //         // var
        //         //     lpgeOrderTracking: Page "Order Tracking";
        //         // begin
        //         //     //<<MANXL7.00.001 WSA 11/07/2014 #87
        //         //     if rMANXLSetup.READPERMISSION then begin
        //         //         //>>MANXL7.00.001 WSA 11/07/2014 #87
        //         //         //<<MANXL7.00.001 DAT 04/03/2014 #15
        //         //         lpgeOrderTracking.SetSalesLine(Rec);
        //         //         lpgeOrderTracking.RUNMODAL;
        //         //         //>>MANXL7.00.001 DAT 04/03/2014 #15
        //         //         //<<MANXL7.00.001 WSA 11/07/2014 #87
        //         //     end;
        //         //     //>>MANXL7.00.001 WSA 11/07/2014 #87
        //         // end;
        //         // BC Upgrade SHUKLP03 << Blocked DIT code.
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT fields.


        addafter("Return Reason Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                Visible = false;
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
                    if Rec."Responsibility Center" <> xRec."Responsibility Center" then
                        CurrPage.UPDATE(true);
                    // >>DITW18.00.06 DDR DIT-770 #1190
                end;
            }

            // BC Upgrade SHUKLP03 >> Blocked DIT fields.
            // field("Physical Location Group Code"; "Physical Location Group Code")
            // {
            //     QuickEntry = false;
            //     Visible = false;
            //     ApplicationArea = All;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
            //         if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
            //             CurrPage.UPDATE(true);
            //         // >>DITW18.00.06 DDR DIT-770 #1190
            //     end;
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT field.

        }
        modify("Location Code")
        {

            trigger OnLookup(var Text: Text): Boolean;
            var
                Location: Record Location;
                StockkeepingUnit: Record "Stockkeeping Unit";
                LocationFilter: Text;
            begin
                //HEI.02>>
                CLEAR(LocationFilter);
                StockkeepingUnit.RESET();
                StockkeepingUnit.SETRANGE(StockkeepingUnit."Item No.", Rec."No.");
                StockkeepingUnit.SETRANGE(StockkeepingUnit."SKU Type FND", Rec."Document Subtype Code FND"); // BC Upgrade SHUKLP03 << added field "Document Subtype Code".
                if not StockkeepingUnit.ISEMPTY then begin
                    repeat
                        if LocationFilter = '' then
                            LocationFilter := StockkeepingUnit."Location Code"
                        else
                            LocationFilter += '|' + StockkeepingUnit."Location Code";
                    until StockkeepingUnit.NEXT() = 0;
                end;

                Location.RESET();
                Location.FILTERGROUP(2);
                Location.SETFILTER(Location.Code, LocationFilter);
                Location.FILTERGROUP(0);
                if PAGE.RUNMODAL(15, Location) = ACTION::LookupOK then
                    Rec.VALIDATE("Location Code", Location.Code);
                //HEI.02<<
            end;

            // BC Upgrade SHUKLP03 >> Blocked DIT code.
            // trigger OnValidate();
            // begin
            //     LocationCodeOnAfterValidate;
            //     // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
            //     if xRec."Location Code" <> "Location Code" then
            //         CurrPage.UPDATE(true);
            //     // >>DITW18.00.06 DDR DIT-770 #1190
            // end;
            // BC Upgrade SHUKLP03 << Blocked DIT code.
        }
        // BC Upgrade BHARDA11 >>
        addafter("Line Amount")
        {
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                Visible = EnableCAD;
                ApplicationArea = All;
            }
        }
        // BC Upgrade BHARAD11 <<

        // BC Upgrade SHUKLP03 >> Blocked DIT field.
        // addafter("Unit of Measure")
        // {
        //     field("Tariff No. XL"; Rec."Tariff No. XL")
        //     {
        //         Description = 'FINXL7.00.001';
        //         Editable = EditableLine;
        //         Enabled = EditableLine;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }

        // }
        // addafter("Unit Price")
        // {
        //     field("Manual Unit Price"; Rec."Manual Unit Price")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Calculated Unit Price"; "Calculated Unit Price")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Last Price Calculated Date"; "Last Price Calculated Date")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT field.

        // BC Upgrade SHUKLP03 >> Blocked DIT field.
        // addafter("Line Amount")
        // {
        //     // BC Upgrade SHUKLP03 >> Blocked because not required.
        //     // field("CAD Amount"; Rec."CAD Amount")
        //     // {
        //     //     Visible = EnableCAD;
        //     //     ApplicationArea = All;
        //     // }
        //     // BC Upgrade SHUKLP03 << Blocked because not required.


        //     // field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Unit Price"), true))
        //     // {
        //     //     AutoFormatExpression = "Currency Code";
        //     //     AutoFormatType = 2;
        //     //     BlankZero = true;
        //     //     CaptionClass = GetCaptionClassVar(PageText2014411);
        //     //     CaptionML = ENU = 'Total Unit Price',
        //     //                 FRA = 'Total prix unitaire';
        //     //     Description = 'DITW17.10.05 DIT-770 #988';
        //     //     Editable = false;
        //     //     QuickEntry = false;
        //     //     Visible = false;
        //     //     ApplicationArea = All;
        //     // }
        //     // field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), true))
        //     // {
        //     //     AutoFormatExpression = "Currency Code";
        //     //     AutoFormatType = 1;
        //     //     BlankZero = true;
        //     //     CaptionClass = GetCaptionClassVar(PageText2014410);
        //     //     CaptionML = ENU = 'Total Line Amount',
        //     //                 FRA = 'Montant total ligne';
        //     //     Description = 'DITW17.10.02B DIT-770 #541';
        //     //     Editable = false;
        //     //     QuickEntry = false;
        //     //     ApplicationArea = All;
        //     // }

        // }
        // BC Upgrade SHUKLP03 << Blocked DIT field.

        // BC Upgrade SHUKLP03 >> Blocked DIT field.
        // addafter("Planned Shipment Date")
        // {
        //     field("Picklist Printed (date/time)"; Rec."Picklist Printed (date/time)")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Picking Type"; "Picking Type")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT field.


        addafter("Shipment Date")
        {
            field("Forecasted Shipment Date"; Rec."Forecasted Shipment Date FND")
            {
                ApplicationArea = All;
            }
            field("Freshness Date (min)"; Rec."Freshness Date (min) FND")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }

        // BC Upgrade SHUKLP03 >> Blocked DIT fields.
        // addafter("Work Type Code")
        // {
        //     field("Whse. Shipment No. (Open)"; Rec."Whse. Shipment No. (Open)")
        //     {
        //         Description = '#1399';
        //         Lookup = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        // }

        // addafter("Appl.-to Item Entry")
        // {
        //     field(Weight; Weight)
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         ApplicationArea = All;
        //     }
        //     field(Cubage; Cubage)
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         ApplicationArea = All;
        //     }
        //     field("Cubage (Base)"; "Cubage (Base)")
        //     {
        //         Editable = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Weight (Base)"; "Weight (Base)")
        //     {
        //         Editable = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("ShortcutQtyUomValue[1]"; ShortcutQtyUomValue[1])
        //     {
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassShortcutUom(1);
        //         DecimalPlaces = 0 : 5;
        //         Description = 'DIT-715 #244';
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("ShortcutQtyUomValue[2]"; ShortcutQtyUomValue[2])
        //     {
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassShortcutUom(2);
        //         DecimalPlaces = 0 : 5;
        //         Description = 'DIT-715 #244';
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("ShortcutQtyUomValue[3]"; ShortcutQtyUomValue[3])
        //     {
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassShortcutUom(3);
        //         DecimalPlaces = 0 : 5;
        //         Description = 'DIT-715 #244';
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("HL Cubage"; "HL Cubage")
        //     {
        //         Description = 'temp?';
        //         Editable = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Eq. UOM Quantity"; "Eq. UOM Quantity")
        //     {
        //         Description = 'temp?';
        //         Editable = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Unit Volume HL"; "Unit Volume HL")
        //     {
        //         Editable = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Customer DTax Group Code"; "Customer DTax Group Code")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Item DTax Group Code"; "Item DTax Group Code")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Strength Spec. Code"; "Strength Spec. Code")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Strength Spec. Value"; "Strength Spec. Value")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Vol-Strength Spec. Code"; "Vol-Strength Spec. Code")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Vol-Strength Spec. Value"; "Vol-Strength Spec. Value")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("LRN No. Series"; Rec."LRN No. Series")
        //     {
        //         Description = 'DITW15.00.00.38 #1217';
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("LRN No."; Rec."LRN No.")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("ARC No."; Rec."ARC No.")
        //     {
        //         Editable = false;
        //         Lookup = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("SAD No."; "SAD No.")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("ARC No. Mandatory"; "ARC No. Mandatory")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Packaging Type Code"; "Packaging Type Code")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("No. of Packages"; "No. of Packages")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Commercial Seal ID"; "Commercial Seal ID")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Cancellation Reason Type"; "Cancellation Reason Type")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW110.00.09 DDR 28/03/2017 NRQ#9647
        //             CurrPage.SAVERECORD;
        //             COMMIT;
        //             CancellationReasonCommenOnPush;
        //             CurrPage.UPDATE(false);
        //             // >>DITW110.00.09 DDR NRQ#9647
        //         end;
        //     }
        //     field("Cancellation Reason Comment"; "Cancellation Reason Comment")
        //     {
        //         Editable = false;
        //         OptionCaptionML = ENU = 'Bitmap7,Bitmap6',
        //                           FRA = 'Bitmap7,Bitmap6';
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;

        //         trigger OnValidate();
        //         begin
        //             CancellationReasonCommenOnPush;
        //         end;
        //     }
        //     field("Applies-to AAD Trck. Entry No."; "Applies-to AAD Trck. Entry No.")
        //     {
        //         Description = 'DITW15.00.00.39 #1369';
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Tariff No."; "Tariff No.")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Free Reason Code"; "Free Reason Code")
        //     {
        //         Description = 'DITW17.00.02 DIT-770 #132';
        //         Editable = true;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW17.00.10.05 MSF 30/07 /2014 DIT-770 #692
        //             FreeReasoncodeOnAfterValidate;
        //             // >>DITW17.00.10.05 MSF 30/07 /2014 DIT-770 #692
        //             //<<HEI.14
        //             UpdateFreeReasonCodeDimensions;
        //             //>>HEI.14
        //         end;
        //     }
        //     field("Free Item"; Rec."Free Item")
        //     {
        //         QuickEntry = false;
        //         ApplicationArea = All;

        //         trigger OnValidate();
        //         begin
        //             FreeItemOnAfterValidate;
        //         end;
        //     }
        //     field("Backorder Type"; Rec."Backorder Type")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Allow VAT Calculation (Free)"; "Allow VAT Calculation (Free)")
        //     {
        //         Description = 'DITW16.00.00.40 DIT-715 #172';
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;

        //         trigger OnValidate();
        //         begin
        //             AllowVATCalculationFreeOnAfter;
        //         end;
        //     }
        //     field("Free Item Posting Type"; "Free Item Posting Type")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;

        //         trigger OnValidate();
        //         begin
        //             FreeItemPostingTypeOnAfterVali;
        //         end;
        //     }
        //     field("Delayed Sequence No."; "Delayed Sequence No.")
        //     {
        //         Editable = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Allow Loyalty"; "Allow Loyalty")
        //     {
        //         Description = 'DIT715 #243';
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW17.10.05 WSA 02/02/2015 DIT-770 #185
        //             CurrPage.UPDATE;
        //             // >>DITW17.10.05 WSA 02/02/2015 DIT-770 #185
        //         end;
        //     }
        //     field("Loyalty Point Type"; "Loyalty Point Type")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Loyalty Unit Point"; "Loyalty Unit Point")
        //     {
        //         Description = 'DIT715 #243';
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Loyalty Points Qty. (Base)"; "Loyalty Points Qty. (Base)")
        //     {
        //         Description = 'DIT715 #243';
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Loyalty Amount Type"; "Loyalty Amount Type")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Loyalty Unit Amount"; "Loyalty Unit Amount")
        //     {
        //         Editable = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Loyalty Unit Amount (LCY)"; "Loyalty Unit Amount (LCY)")
        //     {
        //         Description = 'DIT715 #243';
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Loyalty Amount"; "Loyalty Amount")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Editable = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Loyalty Amount (LCY)"; "Loyalty Amount (LCY)")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Allow Price Dit Discount"; "Allow Price Dit Discount")
        //     {
        //         Editable = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Contract Type"; "Contract Type")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("DIT Sub-Contract Type"; "DIT Sub-Contract Type")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Financial Contract No."; "Financial Contract No.")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Service Contract No."; "Service Contract No.")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Contract Group Code"; "Contract Group Code")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Auto. Acc. Group"; "Auto. Acc. Group")
        //     {
        //         Description = 'FINXL7.00.001';
        //         Editable = EditableLine;
        //         Enabled = EditableLine;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        // }
        // addafter("ShortcutDimCode[8]")
        // {
        //     field(LotNo; LotNoText)
        //     {
        //         Caption = 'Lot No.';
        //         Description = 'NRQ#94671';
        //         Editable = false;
        //         Style = Attention;
        //         StyleExpr = LotNocolor;
        //         Visible = false;
        //         ApplicationArea = All;

        //         trigger OnLookup(Text: Text): Boolean;
        //         begin
        //             //<<DITW111.00.13 MSF 06/12/2018 NRQ#94671
        //             OpenItemTrackingLines;
        //             if QualitySetup.READPERMISSION and ("No." <> '') and (Type = Type::Item) then begin
        //                 LotNo :=
        //                   QualityManagement.GetLotNos(DATABASE::"Sales Line", "Document Type", "Document No.", '', 0, "Line No.", "No.",
        //                   10, Quantity < 0);
        //                 CurrPage.UPDATE;
        //             end;
        //         end;
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT field.

        addafter("Line No.")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
            {
                ApplicationArea = All;
            }
            field("WHT Product Posting Group"; Rec."WHT Product Posting Group FND")
            {
                ApplicationArea = All;
            }
            field("WHT Absorb Base"; Rec."WHT Absorb Base FND")
            {
                ApplicationArea = All;
            }
            field("Item Type"; Rec."Item Type FND")
            {
                ApplicationArea = All;
            }
            field("RPM Solution"; Rec."RPM Solution FND")
            {
                ApplicationArea = All;
            }
            field("RPM Type"; Rec."RPM Type FND")
            {
                ApplicationArea = All;
            }
            field("RPM Damage / Loss"; Rec."RPM Damage / Loss FND")
            {
                ApplicationArea = All;
            }
            field("Transporter RPM Damage / Loss"; Rec."TransporterRPM Damage/Loss FND")
            {
                ApplicationArea = All;
            }
            // BC Upgrade SHUKLP03 >> Blocked DIT field.
            // field("Empty Goods Item No."; Rec."Empty Goods Item No.")
            // {
            //     Editable = false;
            //     ApplicationArea = All;
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT field.

            field("TIN No."; Rec."TIN No. FND")
            {
                ApplicationArea = All;
            }
            field("EDI unit of measure"; Rec."EDI unit of measure FND")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Product GTIN code"; Rec."Product GTIN code FND")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        // BC Upgrade SHUKLP03 >> Blocked because not required.
        // BC Upgrade BHARDA11 >> Unblocked the code
        addafter("Total VAT Amount")
        {
            field(TotalCADAmount; TotalSalesLine."CAD Amount FND")
            {
                AutoFormatExpression = Currency.Code;
                // CaptionClass = DocumentTotals.GetTotalCADCaption(Currency.Code); // BC Upgrade SHUKLP03 << Blocked because function is moved to HeinekenBCCustomFunctions.
                CaptionClass = HeinekenBCCustomFunctions.GetTotalCADCaption(Currency.Code);  // BC Upgrade SHUKLP03 << 
                Caption = 'Total CAD Amount';
                Editable = false;
                Visible = EnableCAD;
                ApplicationArea = All;
            }
        }
        // BC Upgrade BHARDA11 << Unblocked the code
        // BC Upgrade SHUKLP03 << Blocked because not required.
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("ExplodeBOM_Functions")
        {
            CaptionML = ENU = 'E&xplode BOM', FRA = '&Eclater nomenclature';
        }
        modify("Insert Ext. Texts")
        {
            CaptionML = ENU = 'Insert &Ext. Texts', FRA = 'Insérer te&xtes étendus';
            ToolTipML = ENU = 'Insert the extended item description that is set up for the item on the sales document line.', FRA = 'Insérez la description plus longue qui est paramétrée pour l''article sur la ligne document vente.';
        }
        modify(Reserve)
        {
            CaptionML = ENU = '&Reserve', FRA = '&Réserver';
        }
        modify(OrderTracking)
        {
            CaptionML = ENU = 'Order &Tracking', FRA = 'C&haînage';
        }
        modify("Item Availability by")
        {
            CaptionML = ENU = 'Item Availability by', FRA = 'Disponibilité article par';
        }
        modify("<Action3>")
        {
            CaptionML = ENU = 'Event', FRA = 'Événement';
        }
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level', FRA = 'Niveau nomenclature';
        }
        modify("Related Information")
        {
            CaptionML = ENU = 'Related Information', FRA = 'Informations connexes';
        }
        modify("Reservation Entries")
        {
            CaptionML = ENU = 'Reservation Entries', FRA = 'Écritures réservation';
        }
        modify(ItemTrackingLines)
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
        }
        modify(SelectItemSubstitution)
        {
            CaptionML = ENU = 'Select Item Substitution', FRA = 'Sélectionner article de substitution';
            ToolTipML = ENU = 'Select another item that has been set up to be sold instead of the original item if it is unavailable.', FRA = 'Sélectionnez un autre article qui a été configuré pour être vendu à la place de l''article initial, s''il n''est pas disponible.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify("Item Charge &Assignment")
        {
            CaptionML = ENU = 'Item Charge &Assignment', FRA = '&Affectation frais annexes';
        }
        modify(OrderPromising)
        {
            CaptionML = ENU = 'Order &Promising', FRA = 'Pro&messe de livraison';
        }
        modify("Assemble to Order")
        {
            CaptionML = ENU = 'Assemble to Order', FRA = 'Assemblage à la commande';
        }
        modify(AssembleToOrderLines)
        {
            CaptionML = ENU = 'Assemble-to-Order Lines', FRA = 'Lignes Assemblage à la commande';
        }
        modify("Roll Up &Price")
        {
            CaptionML = ENU = 'Roll Up &Price', FRA = '&Prix relation';
        }
        modify("Roll Up &Cost")
        {
            CaptionML = ENU = 'Roll Up &Cost', FRA = '&Coûts relation';
        }
        modify(DeferralSchedule)
        {
            CaptionML = ENU = 'Deferral Schedule', FRA = 'Tableau d''échelonnement';
            ToolTipML = ENU = 'View or edit the deferral schedule that governs how revenue made with this sales document is deferred to different accounting periods when the document is posted.', FRA = 'Affichez ou modifiez le tableau d''échelonnement qui régit la manière dont les revenus réalisés à l''aide de ce document vente sont reportés sur différentes périodes de comptabilité lorsque le document est validé.';
        }
        modify("O&rder")
        {
            CaptionML = ENU = 'O&rder', FRA = '&Commande';
        }
        modify("Dr&op Shipment")
        {
            CaptionML = ENU = 'Dr&op Shipment', FRA = 'Livraison &directe';
        }
        modify("Purchase &Order")
        {
            CaptionML = ENU = 'Purchase &Order', FRA = '&Commande achat';
            ToolTipML = ENU = 'View the purchase order that is linked to the sales order, for drop shipment.', FRA = 'Affichez la commande achat associée à la commande vente pour une livraison directe.';
        }
        modify("Speci&al Order")
        {
            CaptionML = ENU = 'Speci&al Order', FRA = 'C&ommande spéciale';
        }
        modify(OpenSpecialPurchaseOrder)
        {
            CaptionML = ENU = 'Purchase &Order', FRA = '&Commande achat';
        }
        modify(BlanketOrder)
        {
            CaptionML = ENU = 'Blanket Order', FRA = 'Commande ouverte';
            ToolTipML = ENU = 'View the blanket sales order.', FRA = 'Affichez la commande ouverte vente.';
        }

        // BC Upgrade SHUKLP03 >> Blocked Txt2AL already blocked with //.
        // //Unsupported feature: CodeModification on "GetPrice(Action 1905623604).OnAction". Please convert manually.

        // //trigger OnAction();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // ShowPrices;
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // //This functionality was copied from page #42. Unsupported part was commented. Please check it.
        // {CurrPage.SalesLines.PAGE.}
        // ShowPrices
        // */
        // //end;


        // //Unsupported feature: CodeModification on ""Get Li&ne Discount"(Action 1901770504).OnAction". Please convert manually.

        // //trigger OnAction();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // ShowLineDisc
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // //This functionality was copied from page #42. Unsupported part was commented. Please check it.
        // {CurrPage.SalesLines.PAGE.}
        // ShowLineDisc
        // */
        // //end;


        // //Unsupported feature: CodeModification on ""ExplodeBOM_Functions"(Action 1901741804).OnAction". Please convert manually.

        // //trigger OnAction();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // ExplodeBOM;
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // //This functionality was copied from page #42. Unsupported part was commented. Please check it.
        // {CurrPage.SalesLines.PAGE.}
        // ExplodeBOM;
        // */
        // //end;


        // //Unsupported feature: CodeModification on ""Insert Ext. Texts"(Action 1903099004).OnAction". Please convert manually.

        // //trigger  Texts"(Action 1903099004)();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // InsertExtendedText(true);
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // //This functionality was copied from page #42. Unsupported part was commented. Please check it.
        // {CurrPage.SalesLines.PAGE.}
        // InsertExtendedText(true);
        // */
        // //end;


        // //Unsupported feature: CodeModification on "Reserve(Action 1905427504).OnAction". Please convert manually.

        // //trigger OnAction();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // FIND;
        // ShowReservation;
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // //This functionality was copied from page #42. Unsupported part was commented. Please check it.
        // {CurrPage.SalesLines.PAGE.}
        // FIND;
        // ShowReservation;
        // */
        // //end;


        // //Unsupported feature: CodeModification on "OrderTracking(Action 1903502504).OnAction". Please convert manually.

        // //trigger OnAction();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // ShowTracking;
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // //This functionality was copied from page #42. Unsupported part was commented. Please check it.
        // {CurrPage.SalesLines.PAGE.}
        // ShowTracking;
        // */
        // //end;


        // //Unsupported feature: CodeModification on ""Nonstoc&k Items"(Action 1905968604).OnAction". Please convert manually.

        // //trigger OnAction();
        // //Parameters and return type have not been exported.
        // //>>>> ORIGINAL CODE:
        // //begin
        // /*
        // ShowNonstockItems;
        // */
        // //end;
        // //>>>> MODIFIED CODE:
        // //begin
        // /*
        // //This functionality was copied from page #42. Unsupported part was commented. Please check it.
        // {CurrPage.SalesLines.PAGE.}
        // ShowNonstockItems;
        // */
        // //end;
        // BC Upgrade SHUKLP03 << Blocked Txt2AL already blocked with //.

        // BC Upgrade SHUKLP03 >> Blocked DIT actions.
        // addfirst(ActionContainer1900000004)
        // {
        //     action("+ Expand")
        //     {
        //         CaptionML = ENU = '+ Expand',
        //                     FRA = '+ Développer';
        //         Enabled = (NOT ExpandLines);
        //         Image = ViewDetails;
        //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //         //PromotedCategory = Process;
        //         //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
        //         //PromotedIsBig = true;
        //         Visible = (NOT ExpandLines) OR ShowButtonsCE;

        //         trigger OnAction();
        //         begin
        //             // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        //             ExpandLines := true;
        //             CurrPage.UPDATE(true);
        //             // >>DITW17.10.03 DDR DIT-770 #541
        //         end;
        //     }
        //     action("- Collapse")
        //     {
        //         CaptionML = ENU = '- Collapse',
        //                     FRA = '- Réduire';
        //         Enabled = ExpandLines;
        //         Image = ViewDetails;
        //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //         //PromotedCategory = Process;
        //         //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
        //         //PromotedIsBig = true;
        //         Visible = ExpandLines OR ShowButtonsCE;

        //         trigger OnAction();
        //         begin
        //             // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        //             ExpandLines := false;
        //             CurrPage.UPDATE(true);
        //             // >>DITW17.10.03 DDR DIT-770 #541
        //         end;
        //     }
        // }
        // addfirst("&Line")
        // {
        //     action("&New Line")
        //     {
        //         CaptionML = ENU = '&New Line',
        //                     FRA = '&Nouvelle ligne';
        //         Ellipsis = true;
        //         Image = New;
        //         ShortCutKey = 'Ctrl+F3';

        //         trigger OnAction();
        //         var
        //             SalesLastLine: Record "Sales Line";
        //         begin
        //             // <<DITW17.10.05 DDR 12/08/2014 DIT-770 #748
        //             CurrPage.SAVERECORD;
        //             COMMIT;
        //             CLEAR(ShortcutDimCode);
        //             SalesLastLine := Rec;
        //             SalesLastLine.SETRANGE("Document Type", "Document Type");
        //             SalesLastLine.SETRANGE("Document No.", "Document No.");
        //             if SalesLastLine.FINDLAST then;
        //             SalesLastLine.InitNewLastLineDIT();
        //             SalesLastLine.INSERT(true);
        //             Rec := SalesLastLine;
        //             CurrPage.UPDATE(false);
        //             // >>DITW17.10.05 DDR DIT-770 #748
        //         end;
        //     }
        // }
        // addafter("Nonstoc&k Items")
        // {
        //     action("&Automatic FEFO Tracking")
        //     {
        //         CaptionML = ENU = '&Automatic FEFO Tracking',
        //                     FRA = 'Traçabilité Automatique FEFO';
        //         Description = '#1331';
        //         ShortCutKey = 'Shift+Ctrl+T';

        //         trigger OnAction();
        //         begin
        //             // <<DITW16.00.00.40 DDR 03/02/2012 #1331
        //             //This functionality was copied from page #42. Unsupported part was commented. Please check it.
        //             /*CurrPage.SalesLines.PAGE.*/
        //             _CreateFEFOTracking();

        //         end;
        //     }
        //     action("Cancellation Reason Comments")
        //     {
        //         CaptionML = ENU = 'Cancellation Reason Comments',
        //                     FRA = 'Commentaires raison d''annulation';

        //         trigger OnAction();
        //         begin
        //             // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
        //             //This functionality was copied from page #42. Unsupported part was commented. Please check it.
        //             /*CurrPage.SalesLines.FORM.*/
        //             _ShowLineCancelReasonCmts;
        //             // >>DITW16.00.00.43 DDR DIT-715 #720

        //         end;
        //     }
        //     action("Items by Period")
        //     {
        //         CaptionML = ENU = 'Items by Period',
        //                     FRA = 'Articles par période';
        //         Description = 'DIT-715 #338';

        //         trigger OnAction();
        //         begin
        //             // <<DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338
        //             //This functionality was copied from page #42. Unsupported part was commented. Please check it.
        //             /*CurrPage.SalesLines.PAGE.*/
        //             _AllItemsAvailability(1);

        //         end;
        //     }
        // }
        // addafter(Location)
        // {
        //     action("Period (Items)")
        //     {
        //         CaptionML = ENU = 'Period (Items)',
        //                     FRA = 'Période (Article)';
        //         Description = 'DIT-715 #338';

        //         trigger OnAction();
        //         begin
        //             // <<DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338
        //             //This functionality was copied from page #42. Unsupported part was commented. Please check it.
        //             /*CurrPage.SalesLines.PAGE.*/
        //             _AllItemsAvailability(0);

        //         end;
        //     }
        // }
        // addafter(ItemTrackingLines)
        // {
        //     action("SSCC Tracking Lines")
        //     {
        //         CaptionML = ENU = 'SSCC Tracking Lines',
        //                     FRA = 'Lignes Traçabilité SSCC';
        //         Image = ItemTrackingLines;

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.38 DDR 19/11/2010 #1139
        //             //This functionality was copied from page #42. Unsupported part was commented. Please check it.
        //             /*CurrPage.SalesLines.PAGE.*/
        //             _OpenSSCCTrackingLines();

        //         end;
        //     }
        // }
        // addafter("Item Charge &Assignment")
        // {
        //     action("Item Charge &Assignment (DIT)")
        //     {
        //         CaptionML = ENU = 'Item Charge &Assignment (DIT)',
        //                     FRA = '&Affectation frais annexes (DIT)';
        //         ShortCutKey = 'Shift+Ctrl+M';

        //         trigger OnAction();
        //         begin
        //             ItemChargeAssgntDIT;
        //         end;
        //     }
        // }
        // addafter(OrderPromising)
        // {
        //     action("Blanket Order Lines (Back Order)")
        //     {
        //         Caption = 'Blanket Order Lines (Back Order)';
        //         Image = Document;

        //         trigger OnAction();
        //         begin
        //             // << DITW110.00.10 SFI 20/06/2017 BL#15657
        //             ShowOriginalSalesOrderOfBlanket;
        //         end;
        //     }
        // }
        // addafter("O&rder")
        // {
        //     group("&Print")
        //     {
        //         CaptionML = ENU = '&Print',
        //                     FRA = '&Imprimer';
        //         action("&AAD Document (EMCS)")
        //         {
        //             CaptionML = ENU = '&AAD Document (EMCS)',
        //                         FRA = 'Document D&AA (EMCS)';

        //             trigger OnAction();
        //             begin
        //                 // <<DITW16.00.00.43 DDR 23/08/2013 DIT-715 #720
        //                 //This functionality was copied from page #42. Unsupported part was commented. Please check it.
        //                 /*CurrPage.SalesLines.FORM.*/
        //                 _OpenEDIDocument();
        //                 // >>DITW16.00.00.43 DDR DIT-715 #720

        //             end;
        //         }
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT actions.
    }

    //Unsupported feature: PropertyModification on "Text001(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot use the Explode BOM function because a prepayment of the sales order has been invoiced.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot use the Explode BOM function because a prepayment of the sales order has been invoiced.;FRA=Vous ne pouvez pas utiliser la fonction Éclater nomenclature car un acompte de la commande vente a été facturé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "UpdateInvDiscountQst(Variable 1024)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //UpdateInvDiscountQst : ENU=One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UpdateInvDiscountQst : ENU=One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?;FRA=Une ou plusieurs lignes ont été facturées. La remise répartie sur les lignes facturées n'est pas prise en compte.\\Voulez-vous mettre à jour la remise facture ?;
    //Variable type has not been exported.

    var
        xRecRef: RecordRef;
        HeinekenBCCustomFunctions: Codeunit "Heineken BC Custom Functions";
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Unit Price', FRA = 'Total prix unitaire';
        DisabledRefreshLines: Boolean;
        ShortcutQtyUomValue: array[3] of Decimal;
        AverageQtyBaseHistoryVisible: Boolean;
        GeneralLedgerSetup: Record "General Ledger Setup";
        "Quantity (Base) HistoryVisible": Boolean;
        TypeEditable: Boolean;
        "No.Editable": Boolean;
        "Cross-Reference No.Editable": Boolean;
        QuantityEditable: Boolean;
        "Qty. to ShipEditable": Boolean;
        "Qty. to InvoiceEditable": Boolean;
        "Unit PriceEditable": Boolean;
        "Line AmountEditable": Boolean;
        "Line Discount AmountEditable": Boolean;
        TypeEnable: Boolean;
        "No.Enable": Boolean;
        QuantityEnable: Boolean;
        "Unit PriceEnable": Boolean;
        "Line AmountEnable": Boolean;
        ExpandLines: Boolean;
        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        UserMgt: Codeunit "User Setup Management";
        cduOrderTrackingMngt: Codeunit OrderTrackingManagement;
        txtReplenishmentStatus: Text[80];
        blnNoStock: Boolean;
        Text2036301: TextConst ENU = 'No Stock', FRA = 'Pas d''inv.';
        //rMANXLSetup: Record "Manufacturing XL Setup"; // BC Upgrade SHUKLP03 << Blocked DIT var.
        GlobalTax1ValueEditable: Boolean;
        GlobalTax2ValueEditable: Boolean;
        EditableLine: Boolean;
        Error004: Label 'You cannot change the %1 when the value has been filled in.';
        LotNo: Code[20];
        LotNoText: Text[50];
        LotNocolor: Boolean;
        // QualitySetup: Record "Quality Setup";     // BC Upgrade SHUKLP03 << Blocked DIT var.
        // QualityManagement: Codeunit "Quality Management"; // BC Upgrade SHUKLP03 << Blocked DIT var.
        EditableDesc: Boolean;
        FieldEditable: Boolean;
        Error005: Label 'You are not allowed to delete Charge Item lines.';
        EnableCAD: Boolean;  // BC Upgrade SHUKLP03 << Blocked CAD feature. // BC Upgrade BHARDA11 ---Unblocked

    // BC Upgrade SHUKLP03 >> Blocked Txt2AL already blocked code with //.
    // //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    // //trigger OnAfterGetCurrRecord();
    // //>>>> ORIGINAL CODE:
    // //begin
    // /*
    // CalculateTotals;
    // SetLocationCodeMandatory;
    // UpdateEditableOnRow;
    // */
    // //end;
    // //>>>> MODIFIED CODE:
    // //begin
    // /*
    // // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
    // SETFILTER("Resp. Center Table Filter",
    //   UserMgt.GetRespCenterFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    // SETFILTER("Phys. Location Table Filter",
    //   UserMgt.GetRespPhysLocationFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    // SETFILTER("Location Table Filter",
    //   UserMgt.GetRespLocationFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    // // >>DITW18.00.06 DDR DIT-770 #1190
    // // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
    // SetFilterSubContractPostType();
    // // >>DITW16.00.00.41 AHU DIT-715 #327

    // #1..3

    // /// FINXL9.00.000.01 ACH 10/01/2017 - DITW110.00.09 AKH 10/04/2017 NRQ#24104

    // // <<DITW15.00.00.01 DDR 18/12/2007
    // // VIGEO VS 29-12-2005: Toeslag regels mogen niet worden gewijzigd. Dit moet op het hoofdartikel worden gedaan.
    // UpdateFields();
    // // >>DITW15.00.00.01 DDR 18/12/2007
    // */
    // //end;
    // BC Upgrade SHUKLP03 << Blocked Txt2AL already blocked code with //.


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    trigger OnAfterGetRecord();
    begin
        //HEI.06 PATHAA02 07.11.2017>>
        if Rec.Type <> Rec.Type::Item then
            EditableDesc := true
        else
            EditableDesc := false;
        //PATHAA02 07.11.2017<<

        // BC Upgrade SHUKLP03 >> Blocked in Nav.
        //>>HEI.16
        //txtReplenishmentStatus:= cduOrderTrackingMngt.CalculateStatusString(cduOrderTrackingMngt.CalculateSalesLineStatus(Rec));
        //blnNoStock:= (STRPOS(txtReplenishmentStatus,Text2036301) <> 0);
        //<<HEI.16
        // BC Upgrade SHUKLP03 << Blocked in Nav.

        //>>MANXL7.00.001 DAT 04/03/2014 #15
        //<<MANXL7.00.001 WSA 11/07/2014 #87
    end;

    // BC Upgrade SHUKLP03 >> Blocked Txt2AL already blocked code with //.
    //Unsupported feature: CodeModification on "OnDeleteRecord". Please convert manually.

    // //trigger OnDeleteRecord() : Boolean;
    // //>>>> ORIGINAL CODE:
    // //begin
    // /*
    // if (Quantity <> 0) and ItemExists("No.") then begin
    //   COMMIT;
    //   if not ReserveSalesLine.DeleteLineConfirm(Rec) then
    //     exit(false);
    //   ReserveSalesLine.DeleteLine(Rec);
    // end;
    // */
    // //end;
    // //>>>> MODIFIED CODE:
    // //begin
    // /*
    // // <<DITW16.00.00.37 DDR 20/07/2010
    // //IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
    // //  COMMIT;
    // //  IF NOT ReserveSalesLine.DeleteLineConfirm(Rec) THEN
    // //    EXIT(FALSE);
    // //  ReserveSalesLine.DeleteLine(Rec);
    // //END;
    // // Move to function TriggerOnDeleteRecord() to solve RTC Collapse delete records
    // // Temporary until next Mirosoft release
    // exit(TriggerOnDeleteRecord());
    // */
    // //end;


    // //Unsupported feature: CodeInsertion on "OnFindRecord". Please convert manually.

    // //trigger OnFindRecord();
    // //Parameters and return type have not been exported.
    // //begin
    // /*
    // // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    // if DisabledRefreshLines then
    //   exit(false);
    // // >>DITW16.00.00.40 DDR DIT-715 #197
    // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    // exit(FindRecordDIT(Which,ExpandLines));
    // // >>DITW17.10.03 DDR DIT-770 #541
    // */
    // //end;


    // //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    // //trigger OnInit();
    // //Parameters and return type have not been exported.
    // //>>>> ORIGINAL CODE:
    // //begin
    // /*
    // SalesSetup.GET;
    // Currency.InitRoundingPrecision;
    // */
    // //end;
    // //>>>> MODIFIED CODE:
    // //begin
    // /*
    // // <<DITW15.00.00.01 DDR 18/12/2007
    // "Line AmountEnable" := true;
    // "Unit PriceEnable" := true;
    // QuantityEnable := true;
    // "No.Enable" := true;
    // TypeEnable := true;
    // "Line Discount AmountEditable" := true;
    // "Line AmountEditable" := true;
    // "Unit PriceEditable" := true;
    // "Qty. to InvoiceEditable" := true;
    // "Qty. to ShipEditable" := true;
    // QuantityEditable := true;
    // "Cross-Reference No.Editable" := true;
    // "No.Editable" := true;
    // TypeEditable := true;
    // //  >>DITW15.00.00.01 DDR 18/12/2007
    // // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    // GlobalTax1ValueEditable := true;
    // GlobalTax2ValueEditable := true;
    // // >>DITW19.00.08 DDR BL#10443

    // SalesSetup.GET;
    // Currency.InitRoundingPrecision;
    // */
    // //end;


    // //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    // //trigger OnNewRecord(BelowxRec : Boolean);
    // //>>>> ORIGINAL CODE:
    // //begin
    // /*
    // if ApplicationAreaSetup.IsFoundationEnabled then
    //   Type := Type::Item
    // else
    //   InitType;
    // CLEAR(ShortcutDimCode);
    // */
    // //end;
    // //>>>> MODIFIED CODE:
    // //begin
    // /*
    // // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
    // IndentLine := 0;
    // if not ISEMPTY then
    //   InitLineNo(ExpandLines,BelowxRec);
    // // >>DITW17.10.03 DDR DIT-770 #541

    // #1..5

    // // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
    // SetFilterSubContractPostType2();
    // // >>DITW16.00.00.41 AHU DIT-715 #327
    // //<<MANXL7.00.001 WSA 11/07/2014 #87
    // if rMANXLSetup.READPERMISSION then begin
    // //>>MANXL7.00.001 WSA 11/07/2014 #87
    //   //<<MANXL7.00.001 DAT 04/03/2014 #15
    //   txtReplenishmentStatus:= '';
    //   blnNoStock:= false;
    //   //>>MANXL7.00.001 DAT 04/03/2014 #15
    // //<<MANXL7.00.001 WSA 11/07/2014 #87
    // end;
    // //>>MANXL7.00.001 WSA 11/07/2014 #87
    // */
    // //end;


    // //Unsupported feature: CodeInsertion on "OnNextRecord". Please convert manually.

    // //trigger OnNextRecord();
    // //Parameters and return type have not been exported.
    // //begin
    // /*
    // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    // exit(NextRecordDIT(Steps,ExpandLines));
    // // >>DITW17.10.03 DDR DIT-770 #541
    // */
    // //end;
    // BC Upgrade SHUKLP03 << Blocked Txt2AL already blocked code with //.

    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    // BC Upgrade SHUKLP03 >> Blocked CAD feature.
    // BC Upgrade BHARAD11 >> Unblocked CAD Code
    trigger OnOpenPage();
    begin
        //HEI.17>>
        GeneralLedgerSetup.GET;
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.17<<
    end;

    // BC Upgrade SHUKLP03 >> Added code on trigger OnDeleteRecord.

    trigger OnDeleteRecord(): Boolean
    var
    begin
        TriggerOnDeleteRecord;
    end;
    // BC Upgrade SHUKLP03 << Added code on trigger OnDeleteRecord.

    // BC Upgrade BHARAD11 << Unblocked CAD Code
    // BC Upgrade SHUKLP03 << Blocked CAD feature.

    // BC Upgrade SHUKLP03 >> Blocked Txt2AL already blocked code with //.
    // //Unsupported feature: CodeModification on "NoOnAfterValidate(PROCEDURE 19066594)". Please convert manually.

    // //procedure NoOnAfterValidate();
    // //Parameters and return type have not been exported.
    // //>>>> ORIGINAL CODE:
    // //begin
    // /*
    // if ApplicationAreaSetup.IsFoundationEnabled then
    //   TESTFIELD(Type,Type::Item);

    // InsertExtendedText(false);
    // if (Type = Type::"Charge (Item)") and ("No." <> xRec."No.") and
    //    (xRec."No." <> '')
    // then
    // #8..15
    //     CurrPage.UPDATE(false);
    //   end;
    // end;
    // */
    // //end;
    // //>>>> MODIFIED CODE:
    // //begin
    // /*
    // #1..3
    // // <<DITW15.00.00.35 DDR 29/06/2009 - DITW15.00.00.38 DDR 15/03/2011 #1291
    // if (Type <> Type::Item) and not "Is Item Charge" then
    // // >>DITW15.00.00.35 DDR - DITW15.00.00.38 DDR #1291
    //   InsertExtendedText(false);
    // #5..18
    // // <<DITW15.00.00.23 DDR 30/07/2008
    // CurrPage.UPDATE;
    // // >>DITW15.00.00.23 DDR
    // */
    // //end;

    // //Unsupported feature: CodeModification on "UnitofMeasureCodeOnAfterValida(PROCEDURE 19057939)". Please convert manually.

    // //procedure UnitofMeasureCodeOnAfterValida();
    // //Parameters and return type have not been exported.
    // //>>>> ORIGINAL CODE:
    // //begin
    // /*
    // if Reserve = Reserve::Always then begin
    //   CurrPage.SAVERECORD;
    //   AutoReserve;
    //   CurrPage.UPDATE(false);
    // end;
    // */
    // //end;
    // //>>>> MODIFIED CODE:
    // //begin
    // /*
    // #1..5
    // // <<DITW15.00.00.01 DDR DDR 15/01/2008
    // if Type = Type::Item then
    //   CurrPage.UPDATE(true);
    // // >>DITW15.00.00.01 DDR
    // */
    // //end;
    // BC Upgrade SHUKLP03 << Blocked Txt2AL already blocked code with //.


    // BC Upgrade SHUKLP03 >> Blocked DIT procedures.
    // local procedure InsertExtendedCharges(FromHeader: Boolean);
    // begin
    //     // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
    //     if InsertChargeLines(FromHeader) then
    //         UpdateForm(true);
    //     // >>DITW15.00.00.23 DDR
    // end;

    // local procedure UpdateFields();
    // var
    //     CollapsedLine: Boolean;
    // begin
    //     // <<DITW15.00.00.01 DDR 15/02/2008 - DITW15.00.00.38 DDR 16/07/2010 #1194
    //     // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
    //     CollapsedLine := not ExpandLines;
    //     // <<DITW17.10.03 DDR 09/07/2014 DIT-770 #541
    //     CALCFIELDS("Has Item Charge");
    //     CollapsedLine := CollapsedLine and "Has Item Charge";
    //     // >>DITW17.10.03 DDR DIT-770 #541
    //     // >>DITW17.10.03 DDR DIT-770 #541

    //     //<< DITW110.00.09 AKH 10/04/2017 NRQ#24104
    //     fctUpdateFields();

    //     TypeEditable := FormEditableField(FIELDNO(Type)) and EditableLine;
    //     "No.Editable" := FormEditableField(FIELDNO("No.")) and EditableLine;
    //     //>> DITW110.00.09 AKH NRQ#24104
    //     // <<DITW15.00.00.38 DDR 27/01/2011 #1259 - DITW110.00.09 AKH 10/04/2017 NRQ#24104
    //     "Cross-Reference No.Editable" := FormEditableField(FIELDNO("Cross-Reference No.")) and EditableLine;
    //     // >>DITW15.00.00.38 DDR #1259 - DITW110.00.09 AKH NRQ#24104
    //     //<< DITW110.00.09 AKH 10/04/2017 NRQ#24104
    //     QuantityEditable := FormEditableField(FIELDNO(Quantity)) and EditableLine;
    //     "Qty. to ShipEditable" := FormEditableField(FIELDNO("Qty. to Ship")) and EditableLine;
    //     "Qty. to InvoiceEditable" := FormEditableField(FIELDNO("Qty. to Invoice")) and EditableLine;

    //     "Unit PriceEditable" := FormEditableField(FIELDNO("Unit Price")) and not CollapsedLine and EditableLine;
    //     "Line AmountEditable" := FormEditableField(FIELDNO("Line Amount")) and not CollapsedLine and EditableLine;
    //     "Line Discount AmountEditable" := FormEditableField(FIELDNO("Line Discount Amount")) and not CollapsedLine and EditableLine;
    //     //>> DITW110.00.09 AKH NRQ#24104
    //     // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1 - DITW110.00.09 AKH 10/04/2017 NRQ#24104
    //     TypeEnable := FormEditableField(FIELDNO(Type)) and EditableLine;
    //     "No.Enable" := FormEditableField(FIELDNO("No.")) and EditableLine;
    //     QuantityEnable := FormEditableField(FIELDNO(Quantity)) and EditableLine;
    //     "Unit PriceEnable" := FormEditableField(FIELDNO("Unit Price")) and EditableLine;
    //     "Line AmountEnable" := FormEditableField(FIELDNO("Line Amount")) and EditableLine;
    //     // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1- DITW110.00.09 AKH NRQ#24104
    //     // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    //     GlobalTax1ValueEditable := HasTaxSpecEditable("Strength Spec. Code");
    //     GlobalTax2ValueEditable := HasTaxSpecEditable("Vol-Strength Spec. Code");
    //     // >>DITW19.00.08 DDR BL#10443
    // end;

    // procedure _OpenSSCCTrackingLines();
    // begin
    //     // <<DITW15.00.00.38 DDR 19/11/2010 #1139
    //     Rec.OpenSSCCTrackingLines();
    // end;

    // procedure OpenSSCCTrackingLines();
    // begin
    //     // <<DITW15.00.00.38 DDR 19/11/2010 #1139
    //     Rec.OpenSSCCTrackingLines();
    // end;
    // BC Upgrade SHUKLP03 << Blocked DIT procedures.

    procedure TriggerOnDeleteRecord(): Boolean;
    var
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        TempRec: Record "Sales Line" temporary;
        Error005: Label 'You are not allowed to delete Charge Item lines.';
    begin

        //HEI.13>>
        if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."Attached to Line No." <> 0) then begin
            ERROR(Error005);
            exit(true);
        end;
        //HEI.13<<

        // BC Upgrade SHUKLP03 >> Blocked DIT code.
        // // <<DITW15.00.00.36 DDR 23/11/2009
        // if "Is Item Charge" and "ItemCharge Incl. Price" then begin
        //     DELETE(true);
        //     TempRec := Rec;
        //     TempRec."Unit Price" := 0;
        //     TempRec."Line Amount" := 0;
        //     TempRec."Line Discount Amount" := 0;
        //     // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
        //     TempRec.CalcBackUnitPriceItem();
        //     // >>DITW110.00.11 DDR NRQ#24875
        //     exit(false);
        // end;
        // // >>DITW15.00.00.36 DDR
        // BC Upgrade SHUKLP03 << Blocked DIT code.

        exit(true);
    end;

    // BC Upgrade SHUKLP03 >> Blocked DIT procedures.
    // procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
    // begin
    //     // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    //     DisabledRefreshLines := NewDisabledRefreshLines;
    // end;

    // procedure _CreateFEFOTracking();
    // begin
    //     // <<DITW16.00.00.40 DDR 03/02/2012 #1331
    //     Rec.CreateFEFOTracking();
    // end;

    // procedure CreateFEFOTracking();
    // begin
    //     // <<DITW16.00.00.40 DDR 03/02/2012 #1331
    //     Rec.CreateFEFOTracking();
    // end;

    // procedure _AllItemsAvailability(AvailabilityType: Option Date2,Date3);
    // begin
    //     // <<DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338
    //     Rec.AllItemsAvailability(AvailabilityType);
    // end;

    // procedure AllItemsAvailability(AvailabilityType: Option Date2,Date3);
    // begin
    //     // <<DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338
    //     Rec.AllItemsAvailability(AvailabilityType);
    // end;

    // procedure _ShowLineCancelReasonCmts();
    // begin
    //     // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
    //     Rec.ShowLineCancelReasonCmts();
    // end;

    // procedure ShowLineCancelReasonCmts();
    // begin
    //     // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
    //     Rec.ShowLineCancelReasonCmts();
    // end;

    // procedure _OpenEDIDocument();
    // var
    //     EmcsEdiMgt: Codeunit "EMCS EDI Mgt";
    // begin
    //     // <<DITW16.00.00.43 DDR 23/08/2013 DIT-715 #720
    //     EmcsEdiMgt.OpenEDIOutDocFile(DATABASE::"Sales Line", "Document Type", "Document No.", "LRN No.", "ARC No.");
    // end;

    // procedure OpenEDIDocument();
    // var
    //     EmcsEdiMgt: Codeunit "EMCS EDI Mgt";
    // begin
    //     // <<DITW16.00.00.43 DDR 23/08/2013 DIT-715 #720
    //     EmcsEdiMgt.OpenEDIOutDocFile(DATABASE::"Sales Line", "Document Type", "Document No.", "LRN No.", "ARC No.");
    // end;
    // BC Upgrade SHUKLP03 << Blocked DIT procedures.


    local procedure UnitPriceOnAfterValidate();
    begin
        //HEI.03>>
        if (Rec.Type = Rec.Type::Item) or (Rec.Type = Rec.Type::"Charge (Item)") then begin
            //IF ("Unit Price" <>0)AND ("Unit Price" <> xRec."Unit Price") THEN
            if (Rec."Unit Price" <> xRec."Unit Price") then
                ERROR(Error004, Rec.FIELDCAPTION("Unit Price"));
        end;
        //HEI.03<<

        // BC Upgrade SHUKLP03 >> Blocked DIT code.

        // // <<DITW15.00.00.01 DDR 21/12/2007
        // if (Type = Type::Item) and
        //    ("Unit Price" <> xRec."Unit Price")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << Blocked DIT code.

    end;

    local procedure LineAmountOnAfterValidate();
    begin
        //HEI.07>>
        if (Rec.Type = Rec.Type::Item) or (Rec.Type = Rec.Type::"Charge (Item)") then
            //IF ("Line Amount" <> 0) AND ("Line Amount" <> xRec."Line Amount") THEN
            if (Rec."Line Amount" <> xRec."Line Amount") then
                ERROR(Error004, Rec.FIELDCAPTION("Line Amount"));
        //HEI.07<<

        // BC Upgrade SHUKLP03 >> Blocked DIT code.
        // // <<DITW15.00.00.01 DDR 21/12/2007
        // if (Type = Type::Item) and
        //    ("Line Amount" <> xRec."Line Amount")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << Blocked DIT code.

    end;

    local procedure LineDiscount37OnAfterValidate();
    begin
        //HEI.07>>
        if (Rec.Type = Rec.Type::Item) or (Rec.Type = Rec.Type::"Charge (Item)") then
            //IF ("Line Discount %" <> 0) AND ("Line Discount %" <> xRec."Line Discount %") THEN
            if (Rec."Line Discount %" <> xRec."Line Discount %") then
                ERROR(Error004, Rec.FIELDCAPTION("Line Discount %"));
        //HEI.07<<

        // BC Upgrade SHUKLP03 >> Blocked DIT code.
        // // <<DITW15.00.00.01 DDR 21/12/2007
        // if (Type = Type::Item) and
        //    ("Line Discount %" <> xRec."Line Discount %")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << Blocked DIT code.

    end;

    local procedure LineDiscountAmountOnAfterValid();
    begin
        //HEI.07>>
        if (Rec.Type = Rec.Type::Item) or (Rec.Type = Rec.Type::"Charge (Item)") then
            //IF ("Line Discount Amount" <> 0) AND ("Line Discount Amount" <> xRec."Line Discount Amount") THEN
            if (Rec."Line Discount Amount" <> xRec."Line Discount Amount") then
                ERROR(Error004, Rec.FIELDCAPTION("Line Discount Amount"));
        //HEI.07<<

        // BC Upgrade SHUKLP03 >> Blocked DIT code.
        // // <<DITW15.00.00.01 DDR 21/12/2007
        // if (Type = Type::Item) and
        //    ("Line Discount Amount" <> xRec."Line Discount Amount")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << Blocked DIT code.

    end;

    // BC Upgrade SHUKLP03 >> Blocked DIT procedures.
    // local procedure Prepayment37OnAfterValidate();
    // begin
    //     // <<DITW15.00.00.23 DDR 11/08/2008
    //     if (Type = Type::Item) and
    //        ("Prepayment %" <> xRec."Prepayment %")
    //     then
    //       CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.23 DDR
    // end;

    // local procedure PrepmtLineAmountOnAfterValidat();
    // begin
    //     // <<DITW15.00.00.23 DDR 11/08/2008
    //     if (Type = Type::Item) and
    //        ("Prepmt. Line Amount" <> xRec."Prepmt. Line Amount")
    //     then
    //       CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.23 DDR
    // end;

    // local procedure QtytoShipOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Qty. to Ship" <> xRec."Qty. to Ship")
    //     then
    //       CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure QtytoInvoiceOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Qty. to Invoice" <> xRec."Qty. to Invoice")
    //     then
    //       CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure PrepmtAmttoDeductOnAfterValida();
    // begin
    //     // <<DITW15.00.00.23 DDR 11/08/2008
    //     if (Type = Type::Item) and
    //        ("Prepmt Amt to Deduct" <> xRec."Prepmt Amt to Deduct")
    //     then
    //       CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.23 DDR
    // end;

    // local procedure FreeItemOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.35 DDR 25/06/2009
    //     if (Type = Type::Item) and
    //        (xRec."Free Item" <> "Free Item")
    //     then
    //       CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.35 DDR
    // end;

    // local procedure AllowVATCalculationFreeOnAfter();
    // begin
    //     CurrPage.UPDATE(true);
    // end;

    // local procedure FreeItemPostingTypeOnAfterVali();
    // begin
    //     // <<DITW15.00.00.35 DDR 25/06/2009
    //     if Type = Type::Item then
    //       CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.35 DDR
    // end;

    // local procedure CancellationReasonCommenOnPush();
    // begin
    //     // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
    //     ShowLineCancelReasonCmts();
    //     // >>DITW16.00.00.43 DDR DIT-715 #720
    // end;

    // procedure ItemChargeAssgntDIT();
    // var
    //     SelectedRec : Record "Sales Line";
    // begin
    //     // <<DITW17.10.03 DDR 22/04/2014 DIT-770 #570
    //     CurrPage.SAVERECORD;
    //     COMMIT;
    //     CurrPage.SETSELECTIONFILTER(SelectedRec);
    //     GetNewItemChargeAssgnDIT(SelectedRec);
    //     CurrPage.UPDATE(false);
    // end;

    // local procedure FreeReasoncodeOnAfterValidate();
    // begin
    //     // <<DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692
    //     if (Type = Type::Item) and
    //        (xRec."Free Reason Code" <> "Free Reason Code")
    //     then
    //       CurrPage.UPDATE(true);
    //     // >>DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692
    // end;

    // local procedure fctUpdateFields();
    // begin
    //     EditableLine := ("Recycle Chrg. Attach. Line No." = 0); //FINXL9.00.000.01 ACH 10/01/2017
    // end;

    // local procedure ShowOriginalSalesOrderOfBlanket();
    // var
    //     SalesLine : Record "Sales Line";
    // begin
    //     // << DITW110.00.10 SFI 20/06/2017 BL#15657
    //     SalesLine.RESET;
    //     SalesLine.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
    //     SalesLine.FILTERGROUP(4);
    //     SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::"Blanket Order");
    //     SalesLine.SETRANGE("Original Sales Order No.", "Document No.");
    //     SalesLine.SETRANGE("Original Sales Order Line No.", "Line No.");
    //     SalesLine.FILTERGROUP(0);
    //     PAGE.RUNMODAL(PAGE::"Sales Lines",SalesLine);
    // end;

    // local procedure LotNoTextOnFormat(var Text : Text);
    // begin
    //     //<<DITW111.00.13 MSF 06/12/2018 NRQ#94671
    //     if QualitySetup.READPERMISSION and ("No." <>'') and (Type = Type::Item) then begin
    //       CALCFIELDS("Lot Reserved Qty. (Base)");
    //       //<<DITW111.00.13 MSF 13/12/2018 NRQ#94671
    //       LotNocolor := QualityManagement.IsRequired(Text) or ((ABS("Outstanding Qty. (Base)") - ABS("Lot Reserved Qty. (Base)") > 0) and ("Lot Reserved Qty. (Base)" <> 0));
    //       //>>DITW111.00.13 MSF 13/12/2018 NRQ#94671

    //     end;
    // end;
    // BC Upgrade SHUKLP03 << Blocked DIT procedures.

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

