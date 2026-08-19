pageextension 51162 PurchaseOrderSubformExtCBN extends "Purchase Order Subform"
{
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
    // DITW15.00.00.01 DDR 19/03/2008 move function InsertExtendedCharges()
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.16 DDR 26/03/2008 Remove (move into function) confirm message from function InsertExtendedCharges()
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.21 DDR 18/06/2008 added fields "Weight","Cubage" (not editable)
    // DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    // DITW15.00.00.23 DDR 29/07/2008 Remove call function InsertExtendedCharges() from trigger OnAfterValidate field "No."
    //                                Updated function into InsertExtendedCharges()
    //                     31/07/2008 Move NewRecord() function into OnNewRecord trigger
    //                     11/08/2008 Added UpdateFormatField() and Refresh for fields
    //                                  "Prepayment %","Prepmt. Line Amount","Prepmt. Amt. Inv.",
    //                                  "Prepmt Amt to Deduct","Prepmt Amt Deducted"
    //                                Update function UpdateFormatField() to show decimals
    // DITW15.00.00.25 DDR 17/10/2008 Added fields
    //                                  "Shipping Agent Code","Shipping Agent Service Code"
    // DITW15.00.00.28 DDR 24/11/2008 Added fields
    //                                  "AAD No." (editable)
    // DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
    //                                  "Empty Goods Item No."
    // DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //                     29/06/2009 Disabled standard call function InsertExtendedText() into Trigger field "No."
    //                     21/08/2009 issue 727 Added HorzAlign property in field "Direct Unit Cost"
    //                 DLE 06/09/2009 issue 516 Added field "Physical Location Group Code"
    //                 DDR 14/10/2009 issue 893 Removed fields "Gen. Prod. Posting Free Group"
    // DITW15.00.00.36 DDR 04/11/2009 issue 939 Performance SQL
    //                                Added function FormTotalingField()
    // DITW15.00.00.37 DDR 26/01/2009 issue 939 Performance SQL error call function into OnModify() trigger
    //                     02/06/2010 issue 1061 Added default Not visible fields "Physical Location Group Code"
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 23/06/2010 issue 1151 Added to remove Quarantine Quality test when delete purchase line
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    //                     10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    "LRN No.","ARC No.","SAD No."
    //                                  Hidden fields
    //                                    "AAD No."
    //                     17/09/2010   Remove field "LRN No."
    //                     30/09/2010   Added lookup field "ARC No."
    //                                  Added function ShowGetARCNoEDI()
    //                     17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    //                                          Added fields "Tax Item No."
    //                     27/01/2011 issue 1259 Added update() on field "Cross-Reference No."
    //                                           Added non-editable when item is (free) item charge
    // DITW15.00.00.38 PRODW14.00.00.17 DDR 08/02/2011 issue 1271
    //                                           Added function ShowQualityTests()
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
    // DITW15.00.00.39 DDR 11/07/2011 issue 1369 Added fields "Applies-to AAD Trck. Entry No."
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade Added/Review Total Line Amount (Collapsed RTC)
    // DITW15.00.00.39 PRODW14.00.00.08.18 DDR 18/08/2011 issue 1410
    //                                           Show all Quality tests, Removed source item ledger entry in flowfield
    //                     22/08/2011 issue 1399 Added fields "Whse. Shipment No. (Open)"
    //                     26/08/2011 issue 1393 Added AssistEdit property/trigger for field "Item No."
    //                     26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)"
    //                     11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  Added function SetDisableRefreshLines() to call before/after each report object
    //                                                 (don't use the <RunObject> property)
    //                     13/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                     03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                             Modified OnAssistEdit trigger field "No."
    //                     13/06/2012 DIT-715 #338 Added functions AllItemsAvailability()
    // DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added to call function SetFilterSubContractPostType() on AfterGetCurrRecord();
    //                                             Added to call function SetFilterSubContractPostType2() on OnNewRecord()
    //                                             Added fields "DIT Sub-Contract Type","Service Contract No.""Contract Group Code"
    //                 AHU 06/11/2012 DIT-715 #393 Added "Description 2" field
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added functions OpenSSCCTrackingLines()

    // FINXL7.00.001 RBE 20/03/2013: Added fields "Tariff No." & "Net Weight" (not visible)
    //                               Added field: "Auto. Acc. Group"
    // FINXL8.00.001 BSA 08/06/2015 #182 : Added Field "Emergency Order"
    // MANXL7.00.001 DAT 05/03/2014 #13: Added field "Revision No."
    // MANXL7.00.001 DAT 05/03/2014 #18: Added "Requester ID"

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 06/06/2013 DIT-770 #99 Added fields "Ship-to Country/Region Code"
    //                  04/07/2013 DIT-770 #99 Removed field "Ship-to Country/Region Code"
    //                                         Added fields "GWC Country/Region Code"
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #99
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0014.1
    //                             added approved prod group + approved line amount
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added
    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.03 DDR 10/06/2014 DIT-770 #541 Modified 'QuickEntry' property fields "Has Item Charge","Collapse"
    //                                          Removed 'IndentationControls' field1 Group Repeater
    // DITW17.10.03 DDR 10/07/2014 DIT-770 #541 Added editable other types than Item
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added field "Responsibity Center"
    // DITW17.10.05 MSF 17/07/2014 DIT-770 #698 (Customer)Vendor suspended tax determined per document line + internal taxes
    //                                           Added non-editable fields "Vendor DTax Group Code","Item DTax Group Code"
    // DITW17.10.05 MSF 18/07/2014 DIT-770 #692 : Employee free benefits with tax due and tax not due sales lines
    //                                            Added field "Free reason code"
    // DITW17.10.05 YHE 06/11/2014 DIT-770 #961 Approved Line amount and Approved PPG added, visible False
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Direct Unit Cost"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type
    // DITW18.00.07 VSC 25/05/2016 DIT-770 #1970 Set Quickentry on Type,"No.",Quantity
    //                                           Set Visible to False for fields "Revision No." and "Requester ID"
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields "Strength Spec. Code","Strength Spec. Value","Vol-Strength Spec. Code","Vol-Strength Spec. Value","Unit Volume HL"
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Removed 'Editable' property for fields "strength Spec. Value","vol-strength Spec. Value"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // FINXL9.00.000.01 ACH 05/01/2016 : set visibilities to false fields "Revision No.","Requester ID"
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Added new fields "Backorder Type"
    // DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackUnitPriceItem()
    // HEI.01 HLSRM02 IBM LAZARE02 07.08.2017
    //   #New fields for SRM integration: Cancelled, SRM Order No., SRM Order Line No.
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //   # New field for MDM integration: "WHT Absorb Base"
    // HEI.03 Defect #969 IBM NASTAA02 17.11.2017 # Link on Blanket Order on PO level
    //   # Made "Blanket Order No." and "Blanket Order Line No." non-editable
    //   # LAZARE02: Make "Blanket Order Line No." editable at customer's request
    // HEI.04 HLSRM03 IBM LAZARE02 07.12.2017
    //   # New action Get Blanket Order Price
    //   # New fields "Outstanding Qty.", "Qty. Rcd. Not Invoiced", "Amt. Rcd. Not Invoiced"

    // HEI.05 Defect#818 14/12/2017 IBM.CHAUHB01 Added fields "Machine Reference Number"

    // HEI.06 Defect#1867 IBM LAZARE02 07.08.2017
    //   # Make field "Line Amount" not editable

    // HEI.07 RTRGAP071 IBM POSTOI01 24.04.2018
    //   # show fields "Use Duplication List" , "Depreciatiuon Book Code"
    // HEI.08 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Field added: "TIN No."
    // DITW111.00.13 MSF 13/12/2018 NRQ#94671 Line and header alert for not fully assigned lines - in warehouse shipment and sales order
    //                                        Added field lot no.
    // HEI.09 FDD_Ethiopia_Tolerance field for SPOT PO  Overdelivery_V0.1_HT630 IBM HORTOC01 28.06.2019 # new field added "Tolerance Received Over %"
    // HEI.10 FDD-PO Layout - Ethiopia - HS Code-HT1079.V03 SHANKJ03 IBM
    //   # Field added H.S.Code
    // HEI.11 FDD- HB1421 CHG2065545 IBM SHANKJ03 10.09.2020
    //   # New action button added Additional costs for FA
    // Hei.12  CHG2096764 IBM. PANDES01  12.03.2021
    //  # Added field Requesters ID.
    // HEI.13 CHG2098629 HB2014 IBM NANDIS01 08.04.2021 - LOG_Automatic creation of Transfer Order for Import PO
    //   # Field shown - "Exp Physical Del Date(Imp)", "TO Reference" - Editable False
    // HEI.14 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field added: "CAD Amount"
    //   # Code added on 'OnOpenPage' trigger
    // HEI.15 CHG2132608 IBM BHATTA09 06.01.2022
    //   # Code added for Tolerance Received Over % field editability
    // HEI.16 FDD-HB2060 CHG2103752 IBM NANDIS01 02-03-2022 - Final delivery and PO closure HL  Global Maximo
    //   # Field "Delivery finalized" is uneditable if PO is having Maximo Requisition No.
    // HEI.17 CHG2155847 HB2821 IBM NANDIS01 08.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # "Astro Unique ID" shown in Page
    // HEI.18 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //   # SPL Code, SPL Name - fields created
    // HEI.19 CHG2217938 HB3565 SRIVAS07 IBM 17.11.23 - Provide an overview of future commitment payments based on open released Purchase Orders
    //   # "Due Date", "Estimated Pmt. Due Date" - fields added
    // HEI.20 CHG2210794 SAHAL01 19.03.2024 Zycus - BASE HL Integration Master Dimension
    //   # Added New Fields - Zycus Order No.
    //                      - Zycus Order Line No.
    // HEI.21 CHG2240166 HB3563 IBM SRIVAS07 12.04.2024 # Development CD_StP_Concat Code Missing in Purchase Lines
    //   # Added new field - "Concat Code"
    // HEI.22 CHG2210794 SAHAL01 19.04.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus PR Reference No.
    //                      - Zycus PO Type Code
    //                      - Zycus PO Line Type Code
    //                      - Zycus PO Line Validated
    // HEI.23 CHG2240166 HB3563 IBM SRIVAS07 23.04.2024 # Development CD_StP_Concat Code Missing in Purchase Lines
    //   # removed new field - "Concat Code"
    // HEI.24 CHG2240166 HB3563 IBM SRIVAS07 23.04.2024 # Development CD_StP_Concat Code Missing in Purchase Lines
    //   # New variable - ConcatCode - Text[20]
    //   # New Function - SetConcatCode()
    //   # Added code in OnAfterGetRecord trigger()
    // HEI.25 CHG2229933 HB3689 IBM SRIVAS07 25.04.2024 # SRM Reference Document Mapping - Development
    //   # Added field - "Vendor Shipment No."
    // HEI.26 CHG2210794 SAHAL01 10.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Field - Zycus Movement Type
    // HEI.27 CHG2270515 SHARMP16 25.09.2024 Issue Update the link contract with CMGs
    //   # Code is written on ONLookup of Blanket Order Line no. so that while selecting by lookup current page will be updated.
    // HEI.28 CHG2272838 SHARMP16 09.10.2024 Unable to link PO to the Blanket PO
    //   # Code is written on ONLookup of the Blanket Order Line No. block
    //     Block CurrPage.UPDATE
    //------------------------------------------------------------BC UPgrade SHARMP16---------------------------------------
    //BC Upgrade SHARMP16-- DocumentTotals Manisha Yadav dependency pending.
    //BC upgrade SHARMP16 -- custom code on triggers.
    //BC Upgrade SHARMP16-- commented Interface related fields and code on trigger OnAfterGetCurrRecord, OnAfterGetRecord and function SetConcat code  shifted to Interface Ext
    layout
    {
        modify(Type)
        {
            Enabled = TypeEnable;

            //Unsupported feature: Change Editable on "Type(Control 2)". Please convert manually.

            QuickEntry = True;
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.', ESP = 'Permite especificar el número de una cuenta contable, un producto, un coste adicional o un activo fijo, según lo que se haya seleccionado en el campo Tipo.', FRA = 'Spécifie le numéro d''un compte général, d''un article, d''un coût supplémentaire ou d''une immobilisation, selon la sélection effectuée dans le champ Type.';
            QuickEntry = True;
        }
        // modify("Cross-Reference No.")
        // {
        //     ToolTipML = ENU = 'Specifies the cross-referenced item number. If you enter a cross reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the cross-reference number on a sales or purchase document.', ESP = 'Especifica el número de producto de la referencia cruzada. Si introduce una referencia cruzada entre su número de producto y el del proveedor o el cliente, sobrescribirá el número de producto estándar cuando introduzca el número de referencia cruzada en un documento de venta o de compra.', FRA = 'Spécifie le numéro d''article à référence externe. Si vous saisissez une référence externe entre votre numéro d''article et celui de votre fournisseur ou client, ce numéro remplace le numéro d''article standard lorsque vous saisissez le numéro de référence externe sur un document vente ou achat.';

        //     //Unsupported feature: Change Editable on ""Cross-Reference No."(Control 62)". Please convert manually.

        //     QuickEntry = False;
        // }
        modify("IC Partner Code")
        {
            QuickEntry = False;
        }
        modify("IC Partner Ref. Type")
        {
            QuickEntry = False;
        }
        modify("IC Partner Reference")
        {
            QuickEntry = False;
        }
        modify("Variant Code")
        {
            QuickEntry = False;
        }
        modify(Nonstock)
        {
            QuickEntry = False;
        }
        modify("VAT Prod. Posting Group")
        {
            QuickEntry = False;
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the item or service on the line.', ESP = 'Permite especificar una descripción del producto o servicio en la línea.', FRA = 'Spécifie une description de l''article ou du service sur la ligne.';

            //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.

            QuickEntry = False;
        }
        modify("Drop Shipment")
        {
            ToolTipML = ENU = 'Specifies if your vendor will ship the items on the line directly to your customer.', ESP = 'Especifica si el proveedor enviará directamente al cliente los productos de la línea.', FRA = 'Spécifie si vous souhaitez que votre fournisseur livre les articles de la ligne directement à votre client.';
            QuickEntry = False;
        }
        modify("Return Reason Code")
        {
            QuickEntry = False;
        }
        modify("Location Code")
        {
            QuickEntry = False;
        }
        modify("Bin Code")
        {
            QuickEntry = False;
        }
        modify(Quantity)
        {
            // Enabled = QuantityEnable;// BC Upgrade SHARMP16 -- Drink-IT Property

            //Unsupported feature: Change Editable on "Quantity(Control 8)". Please convert manually.

            QuickEntry = True;
        }
        modify("Reserved Quantity")
        {
            QuickEntry = False;
        }
        modify("Job Remaining Qty.")
        {
            QuickEntry = False;
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code for the item.', ESP = 'Permite especificar el código de unidad de medida del producto.', FRA = 'Spécifie le code unité de mesure de l''article.';
            QuickEntry = False;
        }
        modify("Unit of Measure")
        {
            QuickEntry = False;
        }
        modify("Direct Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the direct cost of one item unit.', ESP = 'Permite especificar el coste directo de una unidad del producto.', FRA = 'Spécifie le coût direct d''une unité d''article.';

            //Unsupported feature: Change Editable on ""Direct Unit Cost"(Control 12)". Please convert manually.

            QuickEntry = False;
        }
        modify("Indirect Cost %")
        {
            QuickEntry = False;
        }
        modify("Unit Cost (LCY)")
        {
            QuickEntry = False;
        }
        modify("Unit Price (LCY)")
        {
            Enabled = "Unit Price (LCY)Enable";
            QuickEntry = False;
        }
        modify("Line Amount")
        {
            ToolTipML = ENU = 'Specifies the net amount (before subtracting the invoice discount amount) that must be paid for the items on the line.', ESP = 'Especifica el importe neto (antes de restar el importe de descuento de la factura) que se debe pagar por los productos de la línea.', FRA = 'Spécifie le montant net (avant soustraction du montant remise facture) à payer pour les articles de la ligne.';
            Enabled = "Line AmountEnable";

            //Unsupported feature: Change Editable on ""Line Amount"(Control 44)". Please convert manually.

            QuickEntry = False;
        }
        modify("Line Discount %")
        {
            ToolTipML = ENU = 'Specifies the line discount percentage.', ESP = 'Permite especificar el porcentaje de descuento de la línea.', FRA = 'Spécifie le pourcentage remise ligne.';
            QuickEntry = False;
        }
        modify("Line Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the discount amount that is granted on the line.', ESP = 'Permite especificar el importe de descuento que se concede en la línea.', FRA = 'Spécifie le montant de la remise accordée à la ligne.';
        }
        modify("Inv. Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the invoice discount amount for the line.', ESP = 'Especifica el importe de descuento en factura para la línea.', FRA = 'Spécifie le montant de la remise facture pour la ligne.';
        }
        modify("Qty. to Receive")
        {
            ToolTipML = ENU = 'Specifies the quantity that remains to be invoiced. It is calculated as Quantity - Qty. Invoiced.', ESP = 'Permite especificar la cantidad que queda por facturar. Se calcula como Cantidad menos Cdad. facturada.', FRA = 'Spécifie la quantité restante à facturer. Le calcul est effectué comme suit : Quantité - Qté facturée.';

            //Unsupported feature: Change Editable on ""Qty. to Receive"(Control 18)". Please convert manually.

        }
        modify("Quantity Received")
        {
            ToolTipML = ENU = 'Specifies how many units of the item on the line have already been invoiced.', ESP = 'Permite especificar cuántas unidades del producto de la línea se han facturado ya.', FRA = 'Spécifie le nombre d''unités de l''article sur la ligne qui ont déjà été facturées.';
        }
        modify("Qty. to Invoice")
        {
            ToolTipML = ENU = 'Specifies the quantity that remains to be invoiced. It is calculated as Quantity - Qty. Invoiced.', ESP = 'Permite especificar la cantidad que queda por facturar. Se calcula como Cantidad menos Cdad. facturada.', FRA = 'Spécifie la quantité restante à facturer. Le calcul est effectué comme suit : Quantité - Qté facturée.';

            //Unsupported feature: Change Editable on ""Qty. to Invoice"(Control 22)". Please convert manually.

            QuickEntry = False;
        }
        modify("Quantity Invoiced")
        {
            ToolTipML = ENU = 'Specifies how many units of the item on the line have already been invoiced.', ESP = 'Permite especificar cuántas unidades del producto de la línea se han facturado ya.', FRA = 'Spécifie le nombre d''unités de l''article sur la ligne qui ont déjà été facturées.';
        }
        modify("Requested Receipt Date")
        {
            ToolTipML = ENU = 'Specifies the date that you want the vendor to deliver to the ship-to address. The value in the field is used to calculate the latest date you can order the items to have them delivered on the requested receipt date. If you do not need delivery on a specific date, you can leave the field blank.', ESP = 'Permite especificar la fecha en la desea que el proveedor envíe el pedido a la dirección de envío. El valor del campo se usa para calcular la última fecha en la que puede solicitar los productos de forma que se envíen en la fecha de recepción solicitada. Si no necesita que se produzca el envío en una fecha específica, puede dejar el campo en blanco.', FRA = 'Spécifie la date à laquelle vous souhaitez que le fournisseur livre les articles à l''adresse destinataire. La valeur du champ est utilisée pour calculer la date limite de commande garantissant la livraison des articles à la date de réception demandée. Si vous ne souhaitez pas indiquer une date de livraison, vous pouvez laisser ce champ vide.';
        }
        modify("Planned Receipt Date")
        {
            QuickEntry = False;
        }
        modify("Expected Receipt Date")
        {
            QuickEntry = False;
        }
        modify("Order Date")
        {
            ToolTipML = ENU = 'Specifies the date when the item is ordered. It is calculated backwards from the Planned Receipt Date field in combination with the Lead Time Calculation field.', ESP = 'Permite especificar la fecha en que se solicitó el producto. Se calcula hacia atrás a partir del valor del campo Fecha recep. planificada junto con el campo Plazo entrega (días)', FRA = 'Spécifie la date de commande de l''article. Elle est calculée en amont à partir du champ Date planifiée de réception et du champ Délai de réappro.';
            QuickEntry = False;
        }

        //Unsupported feature: Change Description on ""Blanket Order Line No."(Control 48)". Please convert manually.

        modify("Appl.-to Item Entry")
        {
            ToolTipML = ENU = 'Specifies the item ledger entry number the line should be applied to.', ESP = 'Especifica el número del movimiento de producto al que se debería aplicar esta línea.', FRA = 'Spécifie le numéro de l''écriture comptable article avec laquelle la ligne doit être lettrée.';
        }
        modify("Deferral Code")
        {
            ToolTipML = ENU = 'Specifies the deferral template that governs how expenses paid with this purchase document are deferred to the different accounting periods when the expenses were incurred.', ESP = 'Especifica la plantilla de fraccionamiento que administra el modo de fraccionar los gastos pagados con este documento de compra en los diferentes periodos contables cuando se contraen gastos.', FRA = 'Spécifie le modèle échelonnement qui régit la manière dont les dépenses payées avec ce document achat sont échelonnées sur les différentes périodes de comptabilité lorsque les dépenses sont encourues.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', ESP = 'Especifica el código de la dimensión del acceso directo 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true; // BC Upgrade BHARAD11 
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', ESP = 'Especifica el código de la dimensión del acceso directo 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        modify("Invoice Discount Amount")
        {
            CaptionML = ENU = 'Invoice Discount Amount', ESP = 'Importe descuento factura', FRA = 'Montant remise facture';
            ToolTipML = ENU = 'Specifies the amount that is calculated and shown in the Invoice Discount Amount field. The invoice discount amount is deducted from the value shown in the Total Amount Incl. Tax field.', ESP = 'Especifica el importe que se calcula y se muestra en el campo Importe descuento factura. El importe de descuento en factura se deduce del valor que se muestra en el campo Importe total incl. IVA.', FRA = 'Spécifie le montant calculé et affiché dans le champ Montant remise facture. Le montant remise facture est déduit de la valeur indiquée dans le champ Montant total TTC.';
        }
        modify("Invoice Disc. Pct.")
        {
            CaptionML = ENU = 'Invoice Discount %', ESP = '% descuento en factura', FRA = '% remise facture';
            ToolTipML = ENU = 'Specifies a discount percentage that is granted if criteria that you have set up for the customer are met. The calculated discount amount is inserted in the Invoice Discount Amount field, but you can change it manually.', ESP = 'Especifica un porcentaje de descuento que se concede si se cumplen los criterios que configuró para el cliente. El importe de descuento calculado se inserta en el campo Importe descuento factura, pero lo puede cambiar de forma manual.', FRA = 'Spécifie le pourcentage de remise accordé si les critères que vous avez définis pour le client sont remplis. Le montant calculé de la remise est inséré dans le champ Montant remise facture, mais vous pouvez le modifier manuellement.';
        }
        modify("Total Amount Excl. VAT")
        {
            CaptionML = ENU = 'Total Amount Excl. Tax', ESP = 'Importe total excl. IVA', FRA = 'Montant total HT';
        }
        modify("Total VAT Amount")
        {
            CaptionML = ENU = 'Total Tax', ESP = 'IVA total', FRA = 'Total TVA';
            ToolTipML = ENU = 'Specifies the sum of Tax amounts on all lines in the document.', ESP = 'Especifica la suma de los importes de IVA en todas las líneas del documento.', FRA = 'Spécifie la somme des montants de TVA sur toutes les lignes du document.';
        }
        modify("Total Amount Incl. VAT")
        {
            CaptionML = ENU = 'Total Amount Incl. Tax', ESP = 'Importe total incl. IVA', FRA = 'Montant total TTC';
        }
        modify("Blanket Order Line No.")
        {
            Visible = true;//BC Upgrade SHARMP16 22janchanges
            trigger OnLookup(var Text: Text): Boolean
            var
                myInt: Integer;
            begin
                //HEI.27>>
                rec.BlanketOrderLookup();
                //HEI.28>>
                //CurrPage.UPDATE;
                //HEI.28<<
                //HEI.27<<

            end;
        }

        //Unsupported feature: CodeModification on "Type(Control 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        NoOnAfterValidate;
        TypeChosen := HasTypeToFillMandatotyFields;

        if xRec."No." <> '' then
          RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TypeOnAfterValidate;
        #1..5
        */
        //end;


        //Unsupported feature: CodeInsertion on ""No."(Control 4)". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.39 DDR 26/08/2011 #1393 - DITW16.00.00.40 DDR 03/05/2012 DIT-715 #276
        if AssistEditItemTreeview("No.") then begin
          // validate trigger
          ShowShortcutDimCode(ShortcutDimCode);
          // aftervalidate trigger
          CurrPage.UPDATE(true);
        end else
          CurrPage.UPDATE(false);
        // >>DITW15.00.00.39 DDR #1393 - DITW16.00.00.40 DDR DIT-715 #276
        */
        //end;


        //Unsupported feature: CodeModification on ""No."(Control 4).OnValidate". Please convert manually.

        //trigger "(Control 4)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        NoOnAfterValidate;

        if xRec."No." <> '' then
          RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW17.10.03 DDR 10/06/2014 DIT-770 #541
        if not ("No.Editable" or "No.Enable") then begin
          "No." := xRec."No.";
          exit;
        end;
        // >>DITW17.10.03 DDR DIT-770 #541
        #1..5
        */
        //end;


        //Unsupported feature: CodeModification on ""Cross-Reference No."(Control 62).OnLookup". Please convert manually.

        //trigger "(Control 62)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CrossReferenceNoLookUp;
        InsertExtendedText(false);
        NoOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CrossReferenceNoLookUp;
        // <<DITW15.00.00.38 DDR 27/01/2011 #1259
        //InsertExtendedText(FALSE);
        // >>DITW15.00.00.38 DDR #1259
        NoOnAfterValidate;
        // <<DITW15.00.00.38 DDR 27/01/2011 #1259
        CurrPage.UPDATE;
        // >>DITW15.00.00.38 DDR #1259
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Variant Code"(Control 32)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        VariantCodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Control 74)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        LocationCodeOnAfterValidate;
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        if xRec."Location Code" <> "Location Code" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 DDR DIT-770 #1191
        */
        //end;


        //Unsupported feature: CodeModification on "Quantity(Control 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        QuantityOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure Code"(Control 36).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        UnitofMeasureCodeOnAfterValida;
        */
        //end;


        //Unsupported feature: CodeModification on ""Direct Unit Cost"(Control 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        DirectUnitCostOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Amount"(Control 44).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        LineAmountOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Discount %"(Control 16).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        LineDiscount37OnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Discount Amount"(Control 60).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        LineDiscountAmountOnAfterValid;
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepayment %"(Control 108).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        Prepayment37OnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepmt. Line Amount"(Control 110).OnValidate". Please convert manually.

        //trigger  Line Amount"(Control 110)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        PrepmtLineAmountOnAfterValidat;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Qty. to Receive"(Control 18)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        QtytoReceiveOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Qty. to Invoice"(Control 22)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        QtytoInvoiceOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Prepmt Amt to Deduct"(Control 114)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        PrepmtAmttoDeductOnAfterValida;
        */
        //end;



        //Unsupported feature: CodeInsertion on ""Blanket Order Line No."(Control 48)". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.27>>
        BlanketOrderLookup();
        //HEI.28>>
        //CurrPage.UPDATE;
        //HEI.28<<
        //HEI.27<<
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Blanket Order Line No."(Control 48)". Please convert manually.
        modify("Line No.")
        {
            Visible = true;

        }//BC upgrade SHARMP16 22janchanges

        addfirst(Control1)
        {
            //BC Upgrade SHARMP16 BEGIN>> ----------- Drink-IT fields
            // field("Has Item Charge";Rec."Has Item Charge")
            // {
            //     BlankZero = true;
            //     QuickEntry = false;
            // }
            // field(Collapse;Rec.Collapse)
            // {
            //     QuickEntry = false;
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW15.00.00.37 DDR 19/01/2010
            //         CurrPage.UPDATE(true);
            //         // >>DITW15.00.00.37 DDR
            //     end;
            // }//BC Upgrade SHARMP16 end<< ----------- Drink-IT fields
            field("TO Reference"; Rec."TO Reference FND")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the TO Reference field.';
            }
            // }//BC Upgrade SHARMP16>>Interface Fields
            // field(Cancelled; Rec.Cancelled)
            // {
            //     ApplicationArea = All;
            // }
            // }//BC Upgrade SHARMP16<<Interface Fields
        }
        addafter("No.")
        {
            // field("Revision No."; Rec."Revision No.")
            // {
            //     Description = 'MANXL7.00.001';
            //     QuickEntry = false;
            //     Visible = false;
            // }//BC Upgrade SHARMP16 -----DRink-IT fields
            // field("Requester ID"; Rec."Requester ID")
            // {
            //     Description = 'MANXL7.00.001';
            //     QuickEntry = false;
            //     Visible = false;
            // }//BC Upgrade SHARMP16 -----DRink-IT fields

        }
        addafter("Variant Code")
        {
            // field("Emergency Order"; Rec."Emergency Order")
            // {
            // }//BC Upgrade SHARMP16 >-----DRink-IT fields
        }
        addafter(Nonstock)
        {
            // field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            // {
            //     Visible = false;
            // }//BC Upgrade SHARMP16 -- already defined on page.
        }
        addafter("VAT Prod. Posting Group")
        {
            //BC Upgrade SHARMP16 --- Drink-IT field
            // field("GetTrackingItemNo()"; GetTrackingItemNo())
            // {
            //     CaptionML = ENU = 'Tracking Item No. (Item Charge)',
            //                 FRA = 'N° article traçable (Frais annexes)';
            //     DrillDownPageID = "Item List";
            //     Editable = false;
            //     LookupPageID = "Item List";
            //     QuickEntry = false;
            //     TableRelation = IF ("Item Charge Type" = CONST(Tax)) Item where("No." = FIELD("Tax Item No."))
            //     else IF ("Item Charge Type" = CONST(Deposit)) Item where("No." = FIELD("Empty Goods Item No."));
            //     Visible = false;

            //     // trigger OnLookup(Text: Text): Boolean;
            //     // begin
            //     //     // <<DITW15.00.00.38 DDR 17/12/2010 #703
            //     //     Text := GetTrackingItemNo();
            //     //     LookupItemNo(Text);
            //     //     exit(false);
            //     // end;//BC Upgrade SHARMP16 --- Drink-IT code.
            // }/
        }//BC Upgrade SHARMP16 --- Drink-IT field.
        addafter(Description)
        {
            // field("Description 2"; Rec."Description 2")
            // {
            //     Description = 'DIT-715 #393';
            //     QuickEntry = false;
            //     Visible = false;
            // }//BC Upgrade SHARMP16 -- already defined on page.
        }
        addafter("Drop Shipment")
        {
            field("Vendor Shipment No."; Rec."Vendor Shipment No. FND")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Vendor Shipment No. field.';
            }
        }
        addafter("Return Reason Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;
                QuickEntry = false;
                Visible = false;
                ToolTip = 'Specifies the value of the Responsibility Center field.';

                trigger OnValidate();
                begin
                    // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                    if rec."Responsibility Center" <> xRec."Responsibility Center" then
                        CurrPage.UPDATE(true);
                    // >>DITW18.00.06 DDR DIT-770 #1191
                end;
            }
            //BC Upgrade SHARMP16 BEGIN>> ----------- Drink-IT fields
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     QuickEntry = false;
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
            //         if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
            //             CurrPage.UPDATE(true);
            //         // >>DITW18.00.06 DDR DIT-770 #1191
            //     end;
            // }//BC Upgrade SHARMP16 end<< ----------- Drink-IT fields
        }
        addafter(Quantity)
        {
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                ApplicationArea = All;
                Visible = EnableCAD;
                ToolTip = 'Specifies the value of the CAD Amount field.';
            }
            field("Exp Physical Del Date(Imp)"; Rec."Exp Physical Del Date(Imp) FND")
            {
                ApplicationArea = All;
                Caption = 'Expected Physical Delivery Date(Imp)';
                ToolTip = 'Specifies the value of the Expected Physical Delivery Date(Imp) field.';
            }
            // field("No. of Quality Tests"; Rec."No. of Quality Tests")
            // {
            //     QuickEntry = false;
            // }//BC Upgrade SHARMP16 BEGIN>>-----DRink-IT fields
        }
        // addafter("Unit of Measure")
        // {
        //     // field("Tariff No."; Rec."Tariff No.")
        // {
        //     Description = 'FINXL7.00.001';
        //     QuickEntry = false;
        //     Visible = false;
        // }//BC Upgrade SHARMP16 BEGIN>>-----DRink-IT fields
        // field("Net Weight"; Rec."Net Weight")
        // {
        //     Description = 'FINXL7.00.001';
        //     QuickEntry = false;
        //     Visible = false;
        // }//BC Upgrade SHARMP16 BEGIN>>-----defined by base
        addafter("Line Amount")
        {
            //BC Upgrade SHARMP16 BEGIN>>---------Drink-IT fields used.
            // field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Direct Unit Cost"), true))
            // {
            //     AutoFormatExpression = "Currency Code";
            //     AutoFormatType = 2;
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassVar(PageText2014411);
            //     CaptionML = ENU = 'Total Direct Unit Cost',
            //                 FRA = 'Total coût unitaire directe';
            //     Description = 'DITW17.10.05 DIT-770 #988';
            //     Editable = false;
            //     QuickEntry = false;
            //     Visible = false;
            // }
            // field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), true))
            // {
            //     AutoFormatExpression = "Currency Code";
            //     AutoFormatType = 1;
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassVar(PageText2014410);
            //     CaptionML = ENU = 'Total Line Amount',
            //                 FRA = 'Montant total ligne';
            //     Description = 'DITW17.10.02B DIT-770 #541';
            //     Editable = false;
            //     QuickEntry = false;
            // }
            //BC Upgrade SHARMP16 end<<---------Drink-IT fields used.
        }
        addafter("Line Discount Amount")
        {
            field("H.S.Code"; Rec."H.S.Code FND")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the H.S.Code field.';
            }
            field("Tolerance Received Over %"; Rec."Tolerance Received Over % FND")
            {
                ApplicationArea = All;
                Description = 'HEI.09';
                Editable = ToleranceReceivedOverEditable;
                ToolTip = 'Specifies the value of the Tolerance Received Over % field.';
            }
            //BC upgrade SHARMP16 BEGIN>> ---- Interface related fields
            // field("SRM Contract No."; Rec."SRM Contract No.")
            // {
            //     ApplicationArea = All;
            // }
            // field("SRM Contract Line No."; Rec."SRM Contract Line No.")
            // {
            //     ApplicationArea = All;
            // }
            // field("SRM Order No."; Rec."SRM Order No.")
            // {
            //     ApplicationArea = All;
            // }
            // field("SRM Order Line No."; Rec."SRM Order Line No.")
            // {
            //     ApplicationArea = all;
            // }
            //BC upgrade SHARMP16 end<< ---- Interface related fields
            field("Initial Quantity"; Rec."Initial Quantity FND")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Initial Quantity field.';
            }
            field("Initial Amount"; Rec."Initial Amount FND")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Initial Amount field.';
            }
            field("Remaining Amount"; Rec."Remaining Amount FND")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Remaining Amount field.';
            }
            field("Delivery Finalized"; Rec."Delivery Finalized FND")
            {
                ApplicationArea = All;
                Editable = DeliveryFinalizedEditable;
                ToolTip = 'Specifies the value of the Delivery Finalized field.';
            }
            // field("App. Prod. Posting Group"; Rec."App. Prod. Posting Group")
            // {
            //     Visible = false;
            // }//BC Upgrade SHARMP16 BEGIN>>-----DRink-IT fields
            // field("Approved Line Amount"; Rec."Approved Line Amount")
            // {
            //     Visible = false;
            // }//BC Upgrade SHARMP16 BEGIN>>-----DRink-IT fields
        }
        addafter("Quantity Invoiced")
        {
            field("Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies how many units on the order line have not yet been received.';
            }
            field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Qty. Rcd. Not Invoiced field.';
            }
            field("Amt. Rcd. Not Invoiced"; Rec."Amt. Rcd. Not Invoiced")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Amt. Rcd. Not Invoiced field.';
            }
        }
        addafter(Finished)
        {
            // field("Whse. Receipt No. (Open)"; Rec."Whse. Receipt No. (Open)")
            // {
            //     Description = '#1399';
            //     Lookup = false;
            //     Visible = false;
            // }//BC Upgrade SHARMP16 BEGIN>>-----DRink-IT fields
        }
        modify("Blanket Order No.")
        {
            Editable = false;
            Visible = false;
        }
        addafter("Inbound Whse. Handling Time")
        {
            // field("Blanket Order No."; Rec."Blanket Order No.")
            // {
            //     Editable = false;
            //     Visible = false;
            // }//BC Upgrade SHARMP16 already defined on the page by Base
        }
        addafter("Blanket Order Line No.")
        {
            //BC Upgrade SHARMP16 BEGIN>>-----DRink-IT fields
            // field("Shipping Agent Code"; Rec."Shipping Agent Code")
            // {
            //     Visible = false;
            // }
            // field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
            // {
            //     Visible = false;
            // }
            // field(Weight; Rec.Weight)
            // {
            //     Editable = false;
            // }
            // field(Cubage; Rec.Cubage)
            // {
            //     Editable = false;
            // }
            //BC Upgrade SHARMP16 end<<-----DRink-IT fields
            // field("ShortcutQtyUomValue[1]"; Rec.ShortcutQtyUomValue[1])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassUom(1);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }//BC Upgrade SHARMP16 BEGIN>>-----DRink-IT fields
            // field("ShortcutQtyUomValue[2]"; ShortcutQtyUomValue[2])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassUom(2);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }//BC Upgrade SHARMP16 BEGIN>>-----DRink-IT fields
            // field("ShortcutQtyUomValue[3]"; ShortcutQtyUomValue[3])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassUom(3);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }//BC Upgrade SHARMP16 BEGIN>>-----DRink-IT fields
            // field("Unit Volume HL"; Rec."Unit Volume HL")
            // {
            //     Editable = false;
            //     Visible = false;
            // }/BC Upgrade SHARMP16 BEGIN>>-----DRink-IT fields

            //BC Upgrade SHARMP16 BEGIN>>-----DRink-IT fields
            // field("Vendor DTax Group Code"; Rec."Vendor DTax Group Code")
            // {
            //     Description = 'DIT-770 #698';
            //     Editable = false;
            //     QuickEntry = false;
            //     Visible = false;
            // }
            // field("Item DTax Group Code"; Rec."Item DTax Group Code")
            // {
            //     Description = '<DITW15.00.00.01>- DIT-770 #698';
            //     Editable = false;
            //     QuickEntry = false;
            //     Visible = false;
            // }
            // field("Strength Spec. Code"; Rec."Strength Spec. Code")
            // {
            //     Editable = false;
            //     QuickEntry = false;
            //     Visible = false;
            // }
            // field("Strength Spec. Value"; Rec."Strength Spec. Value")
            // {
            //     QuickEntry = false;
            //     Visible = false;
            // }
            // field("Vol-Strength Spec. Code"; Rec."Vol-Strength Spec. Code")
            // {
            //     Editable = false;
            //     QuickEntry = false;
            //     Visible = false;
            // }
            // field("Vol-Strength Spec. Value"; Rec."Vol-Strength Spec. Value")
            // {
            //     QuickEntry = false;
            //     Visible = false;
            // }
            // field("AAD No."; Rec."AAD No.")
            // {
            //     Visible = false;
            // }
            // field("ARC No."; Rec."ARC No.")
            // {
            //     Description = 'DITW15.00.00.38 #1217';
            //     Visible = false;

            //     trigger OnLookup(Text: Text): Boolean;
            //     begin
            //         // <<DITW15.00.00.38 DDR 30/09/2010 #1217
            //         exit(
            //           EDILookupExtTrackingARC(Text));
            //         // >>DITW15.00.00.38 DDR
            //     end;
            // }
            //BC Upgrade SHARMP16 end<<-----DRink-IT fields
            //BC Upgrade SHARMP16 BEGIN>> ----------- Drink-IT fields
            // field("SAD No."; Rec."SAD No.")
            // {
            //     Description = 'DITW15.00.00.38 #1217';
            //     Visible = false;
            // }
            // field("Packaging Type Code"; Rec."Packaging Type Code")
            // {
            //     Visible = false;
            // }
            // field("Applies-to AAD Trck. Entry No."; Rec."Applies-to AAD Trck. Entry No.")
            // {
            //     Description = 'DITW15.00.00.39 #1369';
            //     Visible = false;
            // }
            // field("Free Reason Code"; Rec."Free Reason Code")
            // {
            //     CaptionML = ENU = 'Free Reason Code',
            //                 FRA = 'Code motif gratuit';
            //     Description = 'DITW17.10.05 DIT-770 #692';
            //     QuickEntry = false;
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692
            //         FreeReasoncodeOnAfterValidate
            //         // >>DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692
            //     end;
            // }
            // field("Free Item"; Rec."Free Item")
            // {
            //     QuickEntry = false;

            //     trigger OnValidate();
            //     begin
            //         FreeItemOnAfterValidate;
            //     end;
            // }
            //BC Upgrade SHARMP16 end<< ----------- Drink-IT fields
            // field("Allow VAT Calculation (Free)"; Rec."Allow VAT Calculation (Free)")
            // {
            //     Description = 'DITW16.00.00.40 DIT-715 #172';
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         AllowVATCalculationFreeOnAfter;
            //     end;
            // }//BC Upgrade SHARMP16 BEGIN>>-----DRink-IT fields
            // field("Free Item Posting Type"; Rec."Free Item Posting Type")
            // {
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         FreeItemPostingTypeOnAfterVali;
            //     end;
            // }//BC Upgrade SHARMP16 BEGIN>>-----DRink-IT fields
            //BC Upgrade SHARMP16 BEGIN<< ----------- Drink-IT fields
            //     field("Contract Type"; Rec."Contract Type")
            //     {
            //         Editable = false;
            //         Visible = false;
            //     }
            //     field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
            //     {
            //         Visible = false;
            //     }
            //     field("Service Contract No."; Rec."Service Contract No.")
            //     {
            //         Visible = false;
            //     }
            //     field("Financial Contract No."; Rec."Financial Contract No.")
            //     {
            //         Visible = false;
            //     }
            //     field("Contract Group Code"; Rec."Contract Group Code")
            //     {
            //         Visible = false;
            //     }
            //     field("Linked Customer No."; Rec."Linked Customer No.")
            //     {
            //         Visible = false;
            //     }
            //     field("Auto. Acc. Group"; Rec."Auto. Acc. Group")
            //     {
            //         Description = 'FINXL7.00.001';
            //         QuickEntry = false;
            //         Visible = false;
            //     }
            // }
            // addafter("Line No.")
            // {
            //     field(LotNo; Rec.LotNoText)
            //     {
            //         Caption = 'Lot No.';
            //         Description = 'NRQ#94671';
            //         Editable = false;
            //         Style = Attention;
            //         StyleExpr = LotNocolor;
            //         Visible = false;

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
            //     field("Backorder Type"; Rec."Backorder Type")
            //     {
            //         Caption = 'Backorder Type';
            //         Editable = false;
            //         Visible = false;
            //     }
            //BC Upgrade SHARMP16 end>> ----------- Drink-IT fields
            field("WHT Absorb Base"; Rec."WHT Absorb Base FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Absorb Base field.';
            }
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
            }
            field("WHT Product Posting Group"; Rec."WHT Product Posting Group FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Product Posting Group field.';
            }

            //BC Upgrade SHARMP16 BEGIN<< ----------- Interface related fields
            // field("Maximo Requisition No."; Rec."Maximo Requisition No.")
            // {
            //     ApplicationArea = All;
            // }
            // field("Maximo Requisition Line No."; Rec."Maximo Requisition Line No.")
            // {
            //     ApplicationArea = All;
            // }
            //BC Upgrade SHARMP16 end>> ----------- Interface related fields
            field("Machine Reference Number"; Rec."Machine Reference Number FND")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Machine Reference Number field.';
            }
            field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
            {
                ApplicationArea = All;
                ToolTip = 'You can use this field if you have selected Fixed Asset in the Type field for this line.';
            }
            field("Use Duplication List"; Rec."Use Duplication List")
            {
                ApplicationArea = All;
                ToolTip = 'You can use this field if you have selected Fixed Asset in the Type field for this line.';

            }
            field("Depreciation Book Code"; Rec."Depreciation Book Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the code for the depreciation book to which the line will be posted if you have selected Fixed Asset in the Type field for this line.';
            }
            field("TIN No."; Rec."TIN No. FND")
            {
                ApplicationArea = All;
                Caption = 'TIN No.';
                Description = 'HEI.08';
                ToolTip = 'Specifies the value of the TIN No. field.';
            }
            field("Tolerance Received Under %"; Rec."Tolerance Received Under % FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Tolerance Received Under % field.';
            }
            field("Requesters ID"; Rec."Requesters ID FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requesters ID field.';
            }
            field("SPL Code"; Rec."SPL Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SPL Code field.';
            }
            field("SPL Name"; Rec."SPL Name FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SPL Name field.';
            }
            field(ConcatCode; ConcatCode)
            {
                ApplicationArea = All;
                Caption = 'Concat Code';
                Editable = false;
                ToolTip = 'Specifies the value of the Concat Code field.';
            }
            field("Due Date"; Rec."Due Date FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Due Date field.';
            }
            field("Estimated Pmt. Due Date"; Rec."Estimated Pmt. Due Date FND")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Estimated Payment Due Date field.';
            }
            // BC Upgrade SHARMP16 BEGIN>>--- Interface related fields
            // field("Zycus Order No."; Rec."Zycus Order No.")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
            // field("Zycus Order Line No."; Rec."Zycus Order Line No.")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Zycus PR Reference No."; Rec."Zycus PR Reference No.")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Zycus PO Type Code"; Rec."Zycus PO Type Code")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Zycus PO Line Type Code"; Rec."Zycus PO Line Type Code")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Zycus PO Line Validated"; Rec."Zycus PO Line Validated")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Zycus Movement Type"; Rec."Zycus Movement Type")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }// BC Upgrade SHARMP16 end<<--- Interface related fields
        }
        addafter("Total VAT Amount")
        {
            field(TotalCADAmount; CADTotalAmount)//BC Upgrade SHARMP16 CAD
            {
                ApplicationArea = All;
                AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                CaptionClass = BCHNKCustomFunction.GetTotalCADCaption(rec."Currency Code");//BC Upgrade SHARMP16-- dependency from Manisha Yadav
                Caption = 'Total CAD Amount';
                Editable = false;
                Visible = EnableCAD;
                ToolTip = 'Specifies the value of the Total CAD Amount field.';
            }
        }
        addafter("Total Amount Incl. VAT")
        {
            field(TotalInclCAD; TotalInclCAD)
            {
                ApplicationArea = All;
                AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                CaptionClass = BCHNKCustomFunction.GetTotalInclCADCaption(rec."Currency Code");//BC Upgrade SHARMP16-- dependency from Manisha Yadav
                Caption = 'Total Incl. CAD';
                Editable = false;
                //  StyleExpr = TotalAmountStyle;
                Visible = EnableCAD;
                ToolTip = 'Specifies the value of the Total Incl. CAD field.';
            }
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', ESP = '&Línea', FRA = '&Ligne';
        }
        modify("Item Availability by")
        {
            CaptionML = ENU = 'Item Availability by', ESP = 'Disponibilidad prod. por', FRA = 'Disponibilité article par';
        }
        modify("Event")
        {
            CaptionML = ENU = 'Event', ESP = 'Evento', FRA = 'Événement';
        }
        modify(Period)
        {
            CaptionML = ENU = 'Period', ESP = 'Periodo', FRA = 'Période';
        }
        modify(Variant)
        {
            CaptionML = ENU = 'Variant', ESP = 'Variante', FRA = 'Variante';
        }
        modify(Location)
        {
            CaptionML = ENU = 'Location', ESP = 'Almacén', FRA = 'Magasin';
        }
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level', ESP = 'Nivel L.M.', FRA = 'Niveau nomenclature';
        }
        modify("Reservation Entries")
        {
            CaptionML = ENU = 'Reservation Entries', ESP = 'Movs. reserva', FRA = 'Écritures réservation';
        }
        modify("Item Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', ESP = 'Líns. se&guim. prod.', FRA = 'Lignes &traçabilité';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', ESP = 'Dimensiones', FRA = 'Axes analytiques';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', ESP = 'C&omentarios', FRA = 'Co&mmentaires';
        }
        modify(ItemChargeAssignment)
        {
            CaptionML = ENU = 'Item Charge &Assignment', ESP = '&Asignación cargos prod.', FRA = '&Affectation frais annexes';
        }
        modify(DeferralSchedule)
        {
            CaptionML = ENU = 'Deferral Schedule', ESP = 'Previsión fraccionamiento', FRA = 'Tableau d''échelonnement';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', ESP = 'Acci&ones', FRA = 'Fonction&s';
        }
        modify("E&xplode BOM")
        {
            CaptionML = ENU = 'E&xplode BOM', ESP = '&Desplegar L.M.', FRA = '&Eclater nomenclature';
        }
        modify("Insert Ext. Texts")
        {
            CaptionML = ENU = 'Insert &Ext. Text', ESP = 'Insertar t&extos adicionales', FRA = 'Insérer te&xtes étendus';
            ToolTipML = ENU = 'Insert the extended item description that is set up for the item on the purchase document line.', ESP = 'Permite insertar la descripción de producto ampliada que se ha configurado para el producto en la línea del documento de compra.', FRA = 'Insérez la description plus longue qui est paramétrée pour l''article sur la ligne document achat.';
        }
        modify(Reserve)
        {
            CaptionML = ENU = '&Reserve', ESP = '&Reserva', FRA = '&Réserver';
        }
        modify(OrderTracking)
        {
            CaptionML = ENU = 'Order &Tracking', ESP = '&Seguimiento pedido', FRA = 'C&haînage';
        }
        modify("O&rder")
        {
            CaptionML = ENU = 'O&rder', ESP = '&Pedido', FRA = '&Commande';
        }
        modify("Dr&op Shipment")
        {
            CaptionML = ENU = 'Dr&op Shipment', ESP = 'Enví&o directo', FRA = 'Livraison &directe';
        }
        modify("Sales &Order")
        {
            CaptionML = ENU = 'Sales &Order', ESP = 'Pedido &venta', FRA = 'Commande &vente';
        }
        modify("Speci&al Order")
        {
            CaptionML = ENU = 'Speci&al Order', ESP = '&Pedido especial', FRA = 'C&ommande spéciale';
        }
        modify(Action1901038504)
        {
            CaptionML = ENU = 'Sales &Order', ESP = 'Pedido &venta', FRA = 'Commande &vente';
        }
        modify(BlanketOrder)
        {
            CaptionML = ENU = 'Blanket Order', ESP = 'Pedido abierto', FRA = 'Commande ouverte';
            ToolTipML = ENU = 'View the blanket purchase order.', ESP = 'Permite ver el pedido de compra abierto.', FRA = 'Affichez la commande ouverte achat.';
        }
        //BC Upgrade SHARMP16 BEGIN<< ----------- Drink-IT fields
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
        //BC Upgrade SHARMP16 end>> ----------- Drink-IT fields
        addafter("Event")
        {
            //BC Upgrade SHARMP16 BEGIN<< Drink-IT action.
            // action("Items by Period")
            // {
            //     CaptionML = ENU = 'Items by Period',
            //                 FRA = 'Articles par période';
            //     Description = 'DIT-715 #338';

            //     trigger OnAction();
            //     begin
            //         // <<DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338
            //         //This functionality was copied from page #50. Unsupported part was commented. Please check it.
            //         /*CurrPage.PurchLines.PAGE.*/
            //         _AllItemsAvailability(1);

            //     end;
            // }
            //BC Upgrade SHARMP16 end>> Drink-IT action.
        }
        addafter(Location)
        {
            //BC Upgrade SHARMP16 BEGIN<< Drink-IT action.
            // action("Period (Items)")
            // {
            //     CaptionML = ENU = 'Period (Items)',
            //                 FRA = 'Période (Article)';
            //     Description = 'DIT-715 #338';

            //     trigger OnAction();
            //     begin
            //         // <<DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338
            //         //This functionality was copied from page #50. Unsupported part was commented. Please check it.
            //         /*CurrPage.PurchLines.PAGE.*/
            //         _AllItemsAvailability(0);

            //     end;
            // }
            //BC Upgrade SHARMP16 end>> Drink-IT action.
        }
        addafter("Item Tracking Lines")
        {
            //BC Upgrade SHARMP16 BEGIN<< Drink-IT action.
            // action("SSCC Tracking Lines")
            // {
            //     CaptionML = ENU = 'SSCC Tracking Lines',
            //                 FRA = 'Lignes Traçabilité SSCC';
            //     Description = 'DIT-715 #745';
            //     Image = ItemTrackingLines;

            //     trigger OnAction();
            //     begin
            //         //This functionality was copied from page #50. Unsupported part was commented. Please check it.
            //         /*CurrPage.PurchLines.FORM.*/
            //        // _OpenSSCCTrackingLines();

            //     end;
            // }//BC Upgrade SHARMP16 end>> Drink-IT action.
        }
        addafter(DeferralSchedule)
        {
            action("Additional costs for FA")
            {
                ApplicationArea = All;
                ToolTip = 'Executes the Additional costs for FA action.';

                trigger OnAction();
                begin
                    //HEI.11 >>
                    CTSProcureReport.SavePurchOrder(Rec."Document No.");
                    CTSProcureReport.RUN();
                    //HEI.11 <<
                end;
            }
        }
        addafter(OrderTracking)
        {
            action(GetBlanketOrderPrice)
            {
                ApplicationArea = All;
                Caption = 'Get Blanket Order Price';
                Image = Price;
                ToolTip = 'Executes the Get Blanket Order Price action.';

                trigger OnAction();
                begin
                    //HEI.04>>
                    if CONFIRM(GetBlanketOrderPriceQst) then
                        rec.GetBlanketOrderPrice();
                    //HEI.04<<
                end;
            }
        }
        addafter("Speci&al Order")
        {
            //BC Upgrade SHARMP16 BEGIN<< Drink-IT action.
            // action("Quality Tests")
            // {
            //     CaptionML = ENU = 'Quality Tests',
            //                 FRA = 'Testes qualité';

            //     trigger OnAction();
            //     begin
            //         // <<DITW15.00.00.38 PRODW14.00.00.17 DDR 08/02/2011 #1271
            //         //This functionality was copied from page #50. Unsupported part was commented. Please check it.
            //         /*CurrPage.PurchLines.PAGE.*/
            //         _ShowQualityTests();

            //     end;
            // }
            //BC Upgrade SHARMP16 end>> Drink-IT action.
        }
        addafter(BlanketOrder)
        {
            //BC Upgrade SHARMP16 BEGIN<< Drink-IT action.
            // action(Action2035090)
            // {
            //     CaptionML = ENU = 'Quality Tests',
            //                 FRA = 'Tests qualité';

            //     trigger OnAction();
            //     begin
            //         //<<QXL9.00.001 DAT 23/03/2016
            //         ShowQualityTests();
            //         //>>QXL9.00.001 DAT 23/03/2016
            //     end;
            // }
            //BC Upgrade SHARMP16 end>> Drink-IT action.
        }
    }

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        lPurchHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";


    //Unsupported feature: PropertyModification on "Text001(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot use the Explode BOM function because a prepayment of the purchase order has been invoiced.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot use the Explode BOM function because a prepayment of the purchase order has been invoiced.;ESP=No puede usar la función Desplegar L.M. puesto que se ha facturado un prepago del pedido de compra.;FRA=Vous ne pouvez pas utiliser la fonction Éclater nomenclature car un acompte de la commande achat a été facturé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "UpdateInvDiscountQst(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //UpdateInvDiscountQst : ENU=One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UpdateInvDiscountQst : ENU=One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?;ESP=Se han facturado una o varias líneas. No se tendrá en cuenta el descuento distribuido entre las líneas facturadas.\\¿Desea actualizar el descuento en factura?;FRA=Une ou plusieurs lignes ont été facturées. La remise répartie sur les lignes facturées n'est pas prise en compte.\\Voulez-vous mettre à jour la remise facture ?;
    //Variable type has not been exported.

    var
        CTSProcureReport: Report "CTS Procure Add Cost V1 CBN";
        DocumentTotals: Codeunit "Document Totals";
        BCHNKCustomFunction: Codeunit "Heineken BC Custom Functions";
        UserMgt: Codeunit "User Setup Management";
        xRecRef: RecordRef;

        "Cross-Reference No.Editable": Boolean;
        DeliveryFinalizedEditable: Boolean;

        "Direct Unit CostEditable": Boolean;
        DisabledRefreshLines: Boolean;
        EditableDesc: Boolean;
        // GeneralLedgerSetup: Record "General Ledger Setup";
        EnableCAD: Boolean;

        ExpandLines: Boolean;

        GlobalTax1ValueEditable: Boolean;

        GlobalTax2ValueEditable: Boolean;

        "Line AmountEditable": Boolean;

        "Line AmountEnable": Boolean;
        LotNocolor: Boolean;

        "No.Editable": Boolean;

        "No.Enable": Boolean;

        "Qty. to InvoiceEditable": Boolean;

        "Qty. to ReceiveEditable": Boolean;

        QuantityEditable: Boolean;

        QuantityEnable: Boolean;

        ShowButtonsCE: Boolean;
        ToleranceReceivedOverEditable: Boolean;


        TypeEditable: Boolean;

        TypeEnable: Boolean;

        "Unit Price (LCY)Enable": Boolean;
        LotNo: Code[20];
        ShortcutQtyUomValue: array[3] of Decimal;
        TotalInclCAD: Decimal;
        IndentLine: Integer;
        GetBlanketOrderPriceQst: Label 'Do you want to get the blanket order price?';
        LotNoText: Text;
        ConcatCode: Text[20];
        // cduAppMgt: Codeunit ApplicationManagement;
        // QualitySetup: Record "Quality Setup";
        // QualityManagement: Codeunit "Quality Management";
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Direct Unit Cost', FRA = 'Total coût unitaire directe';
        Text2014260: TextConst ENU = 'There are no valid lines to use this function.', FRA = 'Il n''a pas de lignes valide pour utiliser cette fonction';


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger (Variable: lPurchHeader)();
    //Parameters and return type have not been exported.*/
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
UpdateEditableOnRow;
if PurchHeader.GET("Document Type","Document No.") then;

DocumentTotals.PurchaseUpdateTotalsControls(Rec,TotalPurchaseHeader,TotalPurchaseLine,RefreshMessageEnabled,
TotalAmountStyle,RefreshMessageText,InvDiscAmountEditable,VATAmount);
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
// <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
SetFilterSubContractPostType();
// >>DITW16.00.00.41 AHU DIT-715 #327

#1..5

// <<DITW15.00.00.01 DDR 18/12/2007
// VIGEO VS 29-12-2005: Toeslag regels mogen niet worden gewijzigd. Dit moet op het hoofdartikel worden gedaan.
UpdateFields();
// >>DITW15.00.00.01 DDR 18/12/2007

//HEI.16>>
lPurchHeader.RESET;
if lPurchHeader.GET("Document Type","Document No.") then begin
if lPurchHeader."Maximo Requisition No." <> '' then
DeliveryFinalizedEditable := false;
end;
//HEI.16<<

//HEI.14>>
TotalInclCAD := 0;
GeneralLedgerSetup.GET;
if GeneralLedgerSetup."Enable CAD" then begin
if TotalPurchaseLine."CAD Amount" <> 0 then begin
PurchaseLine.RESET;
PurchaseLine.SETRANGE("Document Type",TotalPurchaseHeader."Document Type");
PurchaseLine.SETRANGE("Document No.",TotalPurchaseHeader."No.");
PurchaseLine.SETFILTER("CAD Attached to Line No.",'<>%1',0);
if PurchaseLine.FINDFIRST then
TotalInclCAD := TotalPurchaseLine."Amount Including VAT"
else
TotalInclCAD := TotalPurchaseLine."Amount Including VAT" + TotalPurchaseLine."CAD Amount";
end else
TotalInclCAD := TotalPurchaseLine."Amount Including VAT";
end;
//HEI.14<<
*/
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
ShowShortcutDimCode(ShortcutDimCode);
TypeChosen := HasTypeToFillMandatotyFields;
CLEAR(DocumentTotals);
*/
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
// <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
IndentLine := IndentRecordDIT(ExpandLines);
// >>DITW17.10.03 DDR DIT-770 #541

ShowShortcutDimCode(ShortcutDimCode);
// <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
ShowShortcutUomValue(ShortcutQtyUomValue);
// >>DITW16.00.00.40 DDR DIT-715 #244

TypeChosen := HasTypeToFillMandatotyFields;
CLEAR(DocumentTotals);

//PATHAA02 07.11.2017>>
if Type<> Type::Item then
EditableDesc:= true
else
EditableDesc:= false;
//PATHAA02 07.11.2017<<
//<<DITW111.00.13 MSF 13/12/2018 NRQ#94671
if QualitySetup.READPERMISSION and ("No." <> '') and (Type=Type::Item) then begin
LotNo :=
QualityManagement.GetWhseLotNo(
DATABASE::"Purchase Line","Document Type","Document No.",'',0,"Line No.","No.",Quantity > 0);
end else
LotNo := '';

LotNoText := FORMAT(LotNo);
LotNoTextOnFormat(LotNoText);
//>>DITW111.00.13 MSF 13/12/2018 NRQ#94671
//HEI.09>>
if (Type = Type::Item) and ("Blanket Order No." = '') then
ToleranceReceivedOverEditable := true
//HEI.15>>
else
ToleranceReceivedOverEditable := false;
//HEI.15<<
//HEI.09<<
SetConcatCode(); //HEI.24
*/
    //end;


    //Unsupported feature: CodeModification on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
if (Quantity <> 0) and ItemExists("No.") then begin
COMMIT;
if not ReservePurchLine.DeleteLineConfirm(Rec) then
exit(false);
ReservePurchLine.DeleteLine(Rec);
end;
*/
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
// <<DITW16.00.00.37 DDR 20/07/2010
//IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
//  COMMIT;
//  IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
//    EXIT(FALSE);
//  ReservePurchLine.DeleteLine(Rec);
//end;
// Move to function TriggerOnDeleteRecord() to solve RTC Collapse delete records
// Temporary until next Mirosoft release
exit(TriggerOnDeleteRecord());
*/
    //end;


    //Unsupported feature: CodeInsertion on "OnFindRecord". Please convert manually.

    //trigger OnFindRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
// <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
if DisabledRefreshLines then
exit(false);
// >>DITW16.00.00.40 DDR DIT-715 #197
// <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
//EXIT(FIND(Which));
exit(FindRecordDIT(Which,ExpandLines));
// >>DITW17.10.03 DDR DIT-770 #541
*/
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
// <<DITW15.00.00.01 DDR 18/12/2007
"Line AmountEnable" := true;
"Unit Price (LCY)Enable" := true;
QuantityEnable := true;
"No.Enable" := true;
TypeEnable := true;
"Qty. to InvoiceEditable" := true;
"Qty. to ReceiveEditable" := true;
//HEI.06>>
//"Line AmountEditable" := TRUE;
"Line AmountEditable" := false;
//HEI.06<<
"Direct Unit CostEditable" := true;
QuantityEditable := true;
"Cross-Reference No.Editable" := true;
"No.Editable" := true;
TypeEditable := true;
// >>DITW15.00.00.01 DDR 18/12/2007
// <<DITW19.00.08 DDR 17/08/2016 BL#10443
GlobalTax1ValueEditable := true;
GlobalTax2ValueEditable := true;
// >>DITW19.00.08 DDR BL#10443
ToleranceReceivedOverEditable := false;//HEI.09
DeliveryFinalizedEditable := true;
*/
    //end;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    /*
if ApplicationAreaSetup.IsFoundationEnabled then
Type := Type::Item
else
InitType;
CLEAR(ShortcutDimCode);
*/
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
// <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
IndentLine := 0;
if not ISEMPTY then
InitLineNo(ExpandLines,BelowxRec);
// >>DITW17.10.03 DDR DIT-770 #541

#1..5

// <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
SetFilterSubContractPostType2();
// >>DITW16.00.00.41 AHU DIT-715 #327
*/
    //end;


    //Unsupported feature: CodeInsertion on "OnNextRecord". Please convert manually.

    //trigger OnNextRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
// <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
exit(NextRecordDIT(Steps,ExpandLines));
// >>DITW17.10.03 DDR DIT-770 #541
*/
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
// <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
ExpandLines := false;
ShowButtonsCE := IsShowButtonsCEDIT();
// >>DITW17.10.03 DDR DIT-770 #541

//HEI.14>>
GeneralLedgerSetup.GET;
EnableCAD := GeneralLedgerSetup."Enable CAD";
//HEI.14<<
*/
    //end;


    //Unsupported feature: CodeModification on "NoOnAfterValidate(PROCEDURE 19066594)". Please convert manually.

    //procedure NoOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
UpdateEditableOnRow;
InsertExtendedText(false);
if (Type = Type::"Charge (Item)") and ("No." <> xRec."No.") and
(xRec."No." <> '')
then
CurrPage.SAVERECORD;
*/
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
UpdateEditableOnRow;
// <<DITW15.00.00.35 DDR 29/06/2009 - DITW15.00.00.38 DDR 15/03/2011 #1291
if (Type <> Type::Item) and not "Is Item Charge" then
// >>DITW15.00.00.35 DDR - DITW15.00.00.38 DDR #1291
InsertExtendedText(false);
#3..6

// <<DITW15.00.00.23 DDR 30/07/2008
CurrPage.UPDATE;
// >>DITW15.00.00.23 DDR
*/
    //end;


    //Unsupported feature: CodeModification on "CrossReferenceNoOnAfterValidat(PROCEDURE 19048248)". Please convert manually.

    //procedure CrossReferenceNoOnAfterValidat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
InsertExtendedText(false);
*/
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
// <<DITW15.00.00.38 DDR 27/01/2011 #1259
//InsertExtendedText(FALSE);
CurrPage.UPDATE;
// >>DITW15.00.00.38 DDR #1259
*.00.38 DDR #1259
    */
    //end;
    //BC Upgrade SHARMP16 BEGIN>> ----------- Drink-IT fields
    // procedure _InsertExtendedCharges(FromHeader: Boolean);
    // begin
    //     // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
    //     if InsertChargeLines(FromHeader) then
    //         UpdateForm(true);
    //     // >>DITW15.00.00.23 DDR
    // end;

    // procedure InsertExtendedCharges(FromHeader: Boolean);
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
    //     // >>DITW17.10.03 DDR DIT-770 #541
    //     // <<DITW17.10.03 DDR 09/07/2014 DIT-770 #541
    //     CALCFIELDS("Has Item Charge");
    //     CollapsedLine := CollapsedLine and "Has Item Charge";
    //     // >>DITW17.10.03 DDR DIT-770 #541
    //     TypeEditable := FormEditableField(FIELDNO(Type));
    //     "No.Editable" := FormEditableField(FIELDNO("No."));
    //     // <<DITW15.00.00.38 DDR 27/01/2011 #1259
    //     "Cross-Reference No.Editable" := FormEditableField(FIELDNO("Cross-Reference No."));
    //     // >>DITW15.00.00.38 DDR #1259

    //     QuantityEditable := FormEditableField(FIELDNO(Quantity));
    //     "Direct Unit CostEditable" := FormEditableField(FIELDNO("Direct Unit Cost")) and not CollapsedLine;
    //     //HEI.06>>
    //     //"Line AmountEditable" := FormEditableField(FIELDNO("Line Amount")) AND NOT CollapsedLine;
    //     //HEI.06<<

    //     "Qty. to ReceiveEditable" := FormEditableField(FIELDNO("Qty. to Receive"));
    //     "Qty. to InvoiceEditable" := FormEditableField(FIELDNO("Qty. to Invoice"));

    //     // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    //     TypeEnable := FormEditableField(FIELDNO(Type));
    //     "No.Enable" := FormEditableField(FIELDNO("No."));
    //     QuantityEnable := FormEditableField(FIELDNO(Quantity));
    //     "Unit Price (LCY)Enable" := FormEditableField(FIELDNO("Unit Price (LCY)"));
    //     "Line AmountEnable" := FormEditableField(FIELDNO("Line Amount"));
    //     // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1

    //     // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    //     GlobalTax1ValueEditable := HasTaxSpecEditable("Strength Spec. Code");
    //     GlobalTax2ValueEditable := HasTaxSpecEditable("Vol-Strength Spec. Code");
    //     // >>DITW19.00.08 DDR BL#10443
    // end;

    // procedure _ShowGetARCNoEDI();
    // var
    //     SelectedPurchLines: Record "Purchase Line";
    //     NewARCNo: Code[30];
    //     NewText: Text[1024];
    // begin
    //     // <<DITW15.00.00.38 DDR 30/09/2010 #1217
    //     CLEAR(SelectedPurchLines);
    //     CurrPage.SETSELECTIONFILTER(SelectedPurchLines);
    //     SelectedPurchLines.SETFILTER("No.", '<>%1', '');
    //     SelectedPurchLines.SETRANGE("ARC No. Mandatory", true);
    //     if SelectedPurchLines.findset then begin
    //         repeat
    //             SelectedPurchLines.TESTFIELD("ARC No.", '');
    //         until SelectedPurchLines.NEXT = 0;
    //     end else
    //         ERROR(Text2014260);

    //     // <<DITW15.00.00.38 DDR 17/12/2010 #703
    //     if SelectedPurchLines.EDILookupExtTrackingARC(NewText) then begin
    //         NewARCNo := NewText;
    //         if SelectedPurchLines.findset(true) then
    //             repeat
    //                 SelectedPurchLines.VALIDATE("ARC No.", NewARCNo);
    //                 SelectedPurchLines.MODIFY(true);
    //             until SelectedPurchLines.NEXT = 0;
    //         Rec := SelectedPurchLines;
    //         CurrPage.UPDATE(false);
    //     end;
    // end;

    // procedure ShowGetARCNoEDI();
    // var
    //     SelectedPurchLines: Record "Purchase Line";
    //     NewARCNo: Code[30];
    //     NewText: Text[1024];
    // begin
    //     // <<DITW15.00.00.38 DDR 30/09/2010 #1217
    //     CLEAR(SelectedPurchLines);
    //     CurrPage.SETSELECTIONFILTER(SelectedPurchLines);
    //     SelectedPurchLines.SETFILTER("No.", '<>%1', '');
    //     SelectedPurchLines.SETRANGE("ARC No. Mandatory", true);
    //     if SelectedPurchLines.findset then begin
    //         repeat
    //             SelectedPurchLines.TESTFIELD("ARC No.", '');
    //         until SelectedPurchLines.NEXT = 0;
    //     end else
    //         ERROR(Text2014260);

    //     // <<DITW15.00.00.38 DDR 17/12/2010 #703
    //     if SelectedPurchLines.EDILookupExtTrackingARC(NewText) then begin
    //         NewARCNo := NewText;
    //         if SelectedPurchLines.findset(true) then
    //             repeat
    //                 SelectedPurchLines.VALIDATE("ARC No.", NewARCNo);
    //                 SelectedPurchLines.MODIFY(true);
    //             until SelectedPurchLines.NEXT = 0;
    //         Rec := SelectedPurchLines;
    //         CurrPage.UPDATE(false);
    //     end;
    // end;

    // procedure _ShowQualityTests();
    // var
    //     QualityTestHeader: Record "Quality Test Header";
    // begin
    //     // <<DITW15.00.00.38 PRODW14.00.00.17 DDR 08/02/2011 #1271
    //     QualityTestHeader.SETCURRENTKEY(
    //       "Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
    //     QualityTestHeader.FILTERGROUP(2);
    //     QualityTestHeader.SETRANGE("Source ID", "Document No.");
    //     QualityTestHeader.SETRANGE("Source Type", DATABASE::"Purchase Line");
    //     QualityTestHeader.SETRANGE("Source Subtype", "Document Type");
    //     QualityTestHeader.SETRANGE("Source Ref. No.", "Line No.");
    //     QualityTestHeader.FILTERGROUP(0);
    //     QualityTestHeader.SETRANGE("Item No.", "No.");
    //     PAGE.RUNMODAL(0, QualityTestHeader);
    // end;

    // procedure ShowQualityTests();
    // var
    //     QualityTestHeader: Record "Quality Test Header";
    // begin
    //     //<<QXL9.00.001 DAT 23/03/2016
    //     QualityTestHeader.SETCURRENTKEY(
    //       "Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
    //     QualityTestHeader.FILTERGROUP(2);
    //     QualityTestHeader.SETRANGE("Source ID", "Document No.");
    //     QualityTestHeader.SETRANGE("Source Type", DATABASE::"Purchase Line");
    //     QualityTestHeader.SETRANGE("Source Subtype", "Document Type");
    //     QualityTestHeader.SETRANGE("Source Ref. No.", "Line No.");
    //     QualityTestHeader.FILTERGROUP(0);
    //     QualityTestHeader.SETRANGE("Item No.", "No.");
    //     PAGE.RUNMODAL(0, QualityTestHeader);
    //     //>>QXL9.00.001 DAT 23/03/2016
    // end;

    // procedure _OpenSSCCTrackingLines();
    // begin
    //     // <<DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745
    //     Rec.OpenSSCCTrackingLines();
    // end;

    // procedure OpenSSCCTrackingLines();
    // begin
    //     // <<DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745
    //     Rec.OpenSSCCTrackingLines();
    // end;

    // procedure TriggerOnDeleteRecord(): Boolean;
    // var
    //     ReservePurchLine: Codeunit "Purch. Line-Reserve";
    //     TempRec: Record "Purchase Line" temporary;
    // begin
    //     // cronus
    //     if (Quantity <> 0) and ItemExists("No.") then begin
    //         COMMIT;
    //         if not ReservePurchLine.DeleteLineConfirm(Rec) then
    //             exit(false);

    //         // <<QXL9.00.001 DAT 23/03/2016
    //         if QualitySetup.READPERMISSION then begin
    //             if not QualityManagement.DeletePurchLineConfirm(Rec) then
    //                 exit(false);
    //         end;
    //         // >>QXL9.00.001 DAT 23/03/2016

    //         ReservePurchLine.DeleteLine(Rec);

    //         // <<QXL9.00.001 DAT 23/03/2016
    //         if QualitySetup.READPERMISSION then
    //             QualityManagement.DeletePurchLine(Rec);
    //         // >>QXL9.00.001 DAT 23/03/2016
    //     end;

    //     // <<DITW15.00.00.36 DDR 23/11/2009
    //     if "Is Item Charge" and "ItemCharge Incl. Price" then begin
    //         DELETE(true);
    //         TempRec := Rec;
    //         TempRec."Direct Unit Cost" := 0;
    //         TempRec."Line Amount" := 0;
    //         TempRec."Line Discount Amount" := 0;
    //         // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
    //         TempRec.CalcBackDirectCostItem();
    //         // >>DITW110.00.11 DDR NRQ#24875
    //         exit(false);
    //     end;
    //     // >>DITW15.00.00.36 DDR
    //     exit(true);
    // end;

    // procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
    // begin
    //     // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    //     DisabledRefreshLines := NewDisabledRefreshLines;
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

    // local procedure TypeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 15/01/2008
    //     if Type <> xRec.Type then
    //         CurrPage.UPDATE;
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure VariantCodeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     if (Type = Type::Item) and
    //        (xRec."Variant Code" <> "Variant Code")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LocationCodeOnAfterValidate();
    // var
    //     UpdateIsDone: Boolean;
    // begin
    //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     if (Type = Type::Item) and
    //        not UpdateIsDone
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure QuantityOnAfterValidate();
    // var
    //     UpdateIsDone: Boolean;
    // begin
    //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     if (Type = Type::Item) and
    //        (Quantity <> xRec.Quantity) and
    //        not UpdateIsDone
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure UnitofMeasureCodeOnAfterValida();
    // var
    //     UpdateIsDone: Boolean;
    // begin
    //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     if (Type = Type::Item) and
    //        not UpdateIsDone
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure DirectUnitCostOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Direct Unit Cost" <> xRec."Direct Unit Cost")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LineAmountOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Line Amount" <> xRec."Line Amount")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LineDiscount37OnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Line Discount %" <> xRec."Line Discount %")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LineDiscountAmountOnAfterValid();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Line Discount Amount" <> xRec."Line Discount Amount")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure Prepayment37OnAfterValidate();
    // begin
    //     // <<DITW15.00.00.23 DDR 11/08/2008
    //     if (Type = Type::Item) and
    //        ("Prepayment %" <> xRec."Prepayment %")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.23 DDR
    // end;

    // local procedure PrepmtLineAmountOnAfterValidat();
    // begin
    //     // <<DITW15.00.00.23 DDR 11/08/2008
    //     if (Type = Type::Item) and
    //        ("Prepmt. Line Amount" <> xRec."Prepmt. Line Amount")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.23 DDR
    // end;

    // local procedure QtytoReceiveOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Qty. to Receive" <> xRec."Qty. to Receive")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure QtytoInvoiceOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Qty. to Invoice" <> xRec."Qty. to Invoice")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure PrepmtAmttoDeductOnAfterValida();
    // begin
    //     // <<DITW15.00.00.23 DDR 11/08/2008
    //     if (Type = Type::Item) and
    //        ("Prepmt Amt to Deduct" <> xRec."Prepmt Amt to Deduct")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.23 DDR
    // end;

    // // local procedure FreeItemOnAfterValidate();
    // // begin
    // //     // <<DITW15.00.00.35 DDR 25/06/2009
    // //     if (rec.Type = Type::Item) and
    // //        (xRec."Free Item" <> "Free Item")
    // //     then
    // //         CurrPage.UPDATE(true);
    // //     // >>DITW15.00.00.35 DDR
    // // end;
    //BC Upgrade SHARMP16 end<< ----------- Drink-IT fields
    local procedure AllowVATCalculationFreeOnAfter();
    begin
        CurrPage.UPDATE(true);
    end;
    //BC Upgrade SHARMP16 BEGIN>>----------- Drink-IT fields
    // local procedure FreeItemPostingTypeOnAfterVali();
    // begin
    //     // <<DITW15.00.00.35 DDR 25/06/2009
    //     if Type = Type::Item then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.35 DDR
    // end;

    // local procedure FreeReasoncodeOnAfterValidate();
    // begin
    //     // <<DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692
    //     if (Type = Type::Item) and
    //        (xRec."Free Reason Code" <> "Free Reason Code")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692
    // end;

    // local procedure LotNoTextOnFormat(var Text: Text);
    // begin
    //     //<<DITW111.00.13 MSF 13/12/2018 NRQ#94671
    //     if QualitySetup.READPERMISSION and ("No." <> '') and (Type = Type::Item) then begin
    //         CALCFIELDS("Lot Reserved Qty. (Base)");
    //         LotNocolor := QualityManagement.IsRequired(Text) or ((ABS("Outstanding Qty. (Base)") - ABS("Lot Reserved Qty. (Base)") > 0) and ("Lot Reserved Qty. (Base)" <> 0));
    //     end;
    // end;
    //BC Upgrade SHARMP16 end<< ----------- Drink-IT fields

    //Bc upgrade SHARMP16 BEGIN>>----- Interface related code
    // local procedure SetConcatCode();
    // var
    //     DimensionSetEntry: Record "Dimension Set Entry";
    //     GeneralInterfaceSetup: Record "General Interface Setup INT";
    // begin
    //     //HEI.24>>
    //     if rec."Dimension Set ID" <> 0 then begin
    //         GeneralInterfaceSetup.GET();

    //         DimensionSetEntry.RESET;
    //         DimensionSetEntry.SETRANGE("Dimension Set ID", rec."Dimension Set ID");
    //         DimensionSetEntry.SETRANGE("Dimension Code", GeneralInterfaceSetup."Project Dimension Code");
    //         if DimensionSetEntry.FINDFIRST then
    //             ConcatCode := DimensionSetEntry."Dimension Value Code"
    //         else
    //             ConcatCode := '';
    //     end else
    //         ConcatCode := '';
    //     //HEI.24<<
    // end;
    //Bc upgrade SHARMP16 end<<----- Interface related code
    //BC Upgrade SHARMP16 BEGIN>> -- HEI.06, HEI.09, HEI.14 Custom Code.
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        "Line AmountEditable" := FALSE;
        ToleranceReceivedOverEditable := FALSE;
        //HEI.14>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.14<<
    end;
    //BC Upgrade SHARMP16 end<< -- HEI.06,HEI.09, HEI.14 Custom Code. 
    //BC Upgrade SHARMP16 BEGIN<< -- HEI.09,HEI.15, HEI.24 Custom Code.
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin

        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";//BC Upgrade SHARMP16 CAD
    end;
    //BC Upgrade SHARMP16 end>> -- HEI.09,HEI.15, HEI.24 Custom Code.  

    //BC Upgrade SHARMP16 BEGIN<< -- HEI.16 Custom Code.  
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        // //HEI.16>>
        // lPurchHeader.RESET;
        // IF lPurchHeader.GET(rec."Document Type", rec."Document No.") THEN BEGIN
        //     IF lPurchHeader."Maximo Requisition No." <> '' THEN
        //         DeliveryFinalizedEditable := FALSE;
        // end;
        // //HEI.16<<//BC Upgrade SHARMP16 Interface related code shifted to Interface Ext

        //HEI.14>>
        // TotalInclCAD := 0;
        // GeneralLedgerSetup.GET();
        // IF GeneralLedgerSetup."Enable CAD FND" THEN BEGIN
        //     IF TotalPurchaseLine."CAD Amount FND" <> 0 THEN BEGIN
        //         PurchaseLine.RESET();
        //         PurchaseLine.SETRANGE("Document Type", TotalPurchaseHeader."Document Type");
        //         PurchaseLine.SETRANGE("Document No.", TotalPurchaseHeader."No.");
        //         PurchaseLine.SETFILTER("CAD Attached to Line No. FND", '<>%1', 0);
        //         IF PurchaseLine.FINDFIRST() THEN
        //             TotalInclCAD := TotalPurchaseLine."Amount Including VAT"
        //         else
        //             TotalInclCAD := TotalPurchaseLine."Amount Including VAT" + TotalPurchaseLine."CAD Amount FND";
        //     end else
        //         TotalInclCAD := TotalPurchaseLine."Amount Including VAT";
        // end;
        TotalInclCAD := 0;//BC Upgrade SHARMP16 CAD
        CADTotalAmount := 0;
        GeneralLedgerSetup.GET();
        IF GeneralLedgerSetup."Enable CAD FND" THEN BEGIN
            // Sum line CAD Amount directly (don't rely on the TotalPurchaseLine running total)
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
            PurchaseLine.SETRANGE("Document No.", Rec."Document No.");
            PurchaseLine.CALCSUMS("CAD Amount FND");
            CADTotalAmount := PurchaseLine."CAD Amount FND";

            IF CADTotalAmount <> 0 THEN BEGIN
                PurchaseLine.SETFILTER("CAD Attached to Line No. FND", '<>%1', 0);
                IF PurchaseLine.FINDFIRST() THEN
                    TotalInclCAD := TotalPurchaseLine."Amount Including VAT"
                ELSE
                    TotalInclCAD := TotalPurchaseLine."Amount Including VAT" + CADTotalAmount;
            END ELSE
                TotalInclCAD := TotalPurchaseLine."Amount Including VAT";
        END;//BC Upgrade SHARMP16 CAD
        //HEI.14<<

    end;


    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    var
        CADTotalAmount: Decimal;//BC Upgrade SHARMP16 CAD

}

