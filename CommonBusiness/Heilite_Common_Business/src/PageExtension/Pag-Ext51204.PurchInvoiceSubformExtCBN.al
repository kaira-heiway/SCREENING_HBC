pageextension 51204 PurchInvoiceSubformExtCBN extends "Purch. Invoice Subform"
{
    // version NAVW110.0.00.15140,FINXL10.01,QXL9.00.001,DITW110.00.11,HEI.08

    //    DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
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
    // DITW15.00.00.21 DDR 25/06/2008 Added function GetPostedWhseDocument()
    // DITW15.00.00.23 DDR 29/07/2008 Remove call function InsertExtendedCharges() from trigger OnAfterValidate field "No."
    //                                Updated function into InsertExtendedCharges()
    //                     31/07/2008 Move NewRecord() function into OnNewRecord trigger

    //                     12/08/2008 Certification Rules
    //                                  Remove local variable (function GetPostedWhseDocument)
    // DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
    //                                  "Empty Goods Item No."
    // DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //                     21/08/2009 issue 727 Added HorzAlign property in field "Direct Unit Cost"
    //                 DDR 14/10/2009 issue 893 Removed fields "Gen. Prod. Posting Free Group"
    // DITW15.00.00.36 DDR 04/11/2009 issue 939 Performance SQL
    //                                          Added function FormTotalingField()
    // DITW15.00.00.37 DDR 11/05/2010 issue 1061 Added field "Physical Location Group Code"
    //                     01/06/2010 issue 959 Added field "AAD No."
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 23/06/2010 issue 1151 Added to remove Quarantine Quality test when delete purchase line
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    //                     17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
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
    //                     15/03/2011 issue 1217 (DIT711 163) Added EMCS fields
    //                                               "ARC No.","SAD No."
    //                     15/03/2011 issue 1291 Modified trigger field "No." activate function InsertExtendedText() other than items
    //                     16/03/2011 issue 1217 (DIT711 161) Added field "Packaging Type Code"
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade Added/Review Total Line Amount (Collapsed RTC)
    // DITW15.00.00.39 DDR 26/08/2011 issue 1393 Added AssistEdit property/trigger for field "Item No."
    //                     26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)"
    //                     11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  Added function SetDisableRefreshLines() to call before/after each report object
    //                                                 (don't use the <RunObject> property)
    //                     03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                             Modified OnAssistEdit trigger field "No."
    // DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added to call function SetFilterSubContractPostType() on AfterGetCurrRecord();
    //                                             Added to call function SetFilterSubContractPostType2() on OnNewRecord()
    //                                             Added fields "DIT Sub-Contract Type","Service Contract No.""Contract Group Code"
    //                 AHU 06/11/2012 DIT-715 #393 Added "Description 2" field
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added functions OpenSSCCTrackingLines()

    // FINXL7.00 RBE 20/03/2013 : Added fields "Tariff No." & "Net Weight" (not visible)
    //                                Added field: "Auto. Acc. Group"

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0014.1
    //                             added approved prod group + approved line amount
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added
    // DITW17.00.02 SR 23/09/2013 DIT-770 #152 : Page Action Added "Get Blanket Order" added
    //                                         : New "GetPurchBlanketOrder" Added
    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.03 DDR 10/06/2014 DIT-770 #541 Modified 'QuickEntry' property fields "Has Item Charge","Collapse"
    //                                          Removed 'IndentationControls' field1 Group Repeater
    // DITW17.10.03 DDR 10/07/2014 DIT-770 #541 Added editable other types than Item
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added field "Responsibity Center"
    // DITW17.10.05 MSF 17/07/2014 DIT-770 #698 (Customer)Vendor suspended tax determined per document line + internal taxes
    //                                           Added non-editable fields "Vendor DTax Group Code","Item DTax Group Code"
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Direct Unit Cost"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //                                          TEMP Disabled Call function UpdateVATAmounts()
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type
    // DITW18.00.07 VSC 08/03/2016 DIT-770 #1066 New Function + Action to get posted shipping agent costs
    // DITW18.00.07 VSC 08/03/2016 DIT-770 #1066 Deleted Functions _GetPostedWhseDocument and GetPostedWhseDocument

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 24/02/2017 NRQ#21530 Bugfix NAV CU1 replaced by CU3
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // FINXL9.00.000.01 ACH 05/01/2016 : Added field 2036306 - "Intrastat Mandatory" (Boolean)
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.11 AKH 05/10/2017 NRQ#36842 Changed Visible & Editable properties to FALSE for field "Gen. Prod. Posting Group"
    // FINXL10.01 MTR 16/08/2017 NRQ#30245: Removed old FINXL code related to "Show Totals on Purch. Inv/CM." setup
    // DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackUnitPriceItem()
    // HEI.01 FDD-PRDGAP031 IBM PATHAA02 09.11.2017
    // #Code on OnAfterGetRecord
    // HEI.02 FDD_PTPGAP071/RFC212 IBM PATHAA02 07.12.17
    //   # Dimensions are not allowed to be changed coming from PO
    //   # Code on Shortcut dimension1 -OnValidate & Shortcutdimension2-On validate
    // HEI.03 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Field added - "TIN No."
    // HEI.04 CHG2090912 HB1641 IBM NANDIS01 01.02.2021 General Ledger Entries Description
    //   # Make visible of new field - "Additional Description"
    // HEI.05 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field added: "CAD Amount"
    //   # Code added on 'OnOpenPage' trigger
    // HEI.06 CHG2217161 SAHAL01 02.11.2023 SPL for Returns and GR cancellations
    //   # Added New Fields - SPL Code
    //                      - SPL Name
    //                      - Consumption SPL Code

    // HEI.07 CHG2224401 HB3624 YADAVM09 01.04.2024 Health and Security Levy Tax
    //   # New field created #"H&S Levy Tax Amount"
    //                       #HS Posting Group
    // HEI.08 CHG2221624 HB3614 IBM SRIVAS07 05.04.2024 # Block Payment for Invoices with Price Difference higher than the tolerance
    //   # Created New Fields: - Tolerance Exceeded
    // HEI.09 CHG2229933 HB3689 IBM SRIVAS07 25.04.2024 # SRM Reference Document Mapping - Development
    //   # Added field - "Vendor Shipment No."

    //Bc Upgrade YADAVM09 Drink it Field,Functions,Actions are blocked.
    //Bc Upgrade YADAVM09 Type field propert Added for Editable.
    //Bc Upgrade YADAVM09 "Gen. Prod. Posting Group" and Description field added due to property changes
    //Bc Upgrade YADAVM09 //HEI.05>> code added to trigger on OnAftergetciurrrecord as not event found in function calculatetotal.


    // HEI.10 CHG2319994: IBM SAHAL01 06.11.2025 Purchase Invoices page blocking
    // # Added Code
    // HEI.11 CHG2332951: IBM SAHAL01 26.11.2025 Undo change request CHG2319994 HB4423
    // # Commented Code due to blocking month end closing for Ethiopia OpCo.

    // BC Upgrade MISHRS14 >>
    // Added HEI.10, HEI.11 Tag although whole code is blocked in NAV so not bringing into BC
    // BC Upgrade MISHRS14 << 


    layout
    {
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the line type.', FRA = 'Spécifie le type de ligne.';
            Enabled = TypeEnable;
            Editable = TypeEditable;//Bc Upgrade YADAVM09
            //Unsupported feature: Change Editable on "Type(Control 2)". Please convert manually.

        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of a general ledger account, an item, an additional cost or a fixed asset, depending on what you selected in the Type field.', FRA = 'Spécifie le numéro d''un compte général, d''un article, d''un coût supplémentaire ou d''une immobilisation, selon la sélection effectuée dans le champ Type.';
        }
        /* //Bc Upgrade YADAVM09 not exist in base page>>
        modify("Cross-Reference No.")
        {
            ToolTipML = ENU='Specifies the cross-referenced item number. If you enter a cross reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the cross-reference number on a sales or purchase document.',FRA='Spécifie le numéro d''article à référence externe. Si vous saisissez une référence externe entre votre numéro d''article et celui de votre fournisseur ou client, ce numéro remplace le numéro d''article standard lorsque vous saisissez le numéro de référence externe sur un document vente ou achat.';

            //Unsupported feature: Change Editable on ""Cross-Reference No."(Control 72)". Please convert manually.
        }
        */ //Bc Upgrade YADAVM09 not exist in base page <<
        modify("IC Partner Code")
        {
            ToolTipML = ENU = 'Specifies the IC partner code of the partner to whom you want to distribute the cost of the line.', FRA = 'Spécifie le code du partenaire IC du partenaire auquel vous voulez répartir le coût de la ligne.';
        }
        modify("IC Partner Ref. Type")
        {
            ToolTipML = ENU = 'Specifies the item or account in your IC partner''s company that corresponds to the item or account on the line.', FRA = 'Spécifie l''article ou le compte de la société de votre partenaire IC correspondant à l''article ou au compte de la ligne.';
        }
        modify("IC Partner Reference")
        {
            ToolTipML = ENU = 'If the line is being sent to one of your intercompany partners, this field is used together with the IC Partner Ref. Type field to indicate the item or account in your partner''s company that corresponds to the line.', FRA = 'Si la ligne est en cours d''envoi à l''un de vos partenaires intersociétés, ce champ, associé au champ Type de réf. du partenaire IC, permet d''indiquer l''article ou le compte qui correspond à la ligne dans la société de votre partenaire.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a variant code for the item.', FRA = 'Spécifie un code variante pour l''article.';
        }
        modify(Nonstock)
        {
            ToolTipML = ENU = 'Specifies that this item is a nonstock item.', FRA = 'Spécifie que cet article est non stocké.';
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code for the VAT product posting group of the item or general ledger account on this line.', FRA = 'Spécifie le code du groupe comptabilisation produit TVA de l''article ou du compte général de la ligne.';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description/Comment', FRA = 'Description/Commentaire';
            ToolTipML = ENU = 'Specifies a description of the entry, which is based on the contents of the Type and No. fields.', FRA = 'Spécifie une description de l''entrée qui est basée sur le contenu des champs Type et N°.';

            //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.

        }
        modify("Return Reason Code")
        {
            ToolTipML = ENU = 'Specifies a code that explains why the item is returned.', FRA = 'Spécifie un code expliquant la raison du renvoi de l''article.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code for the location where the items on the line will be located.', FRA = 'Spécifie le code du magasin où sont stockés les articles de la ligne.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies a bin code for the item.', FRA = 'Spécifie un code emplacement pour l''article.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item that will be specified on the line.', FRA = 'Spécifie le nombre d''unités de l''article qui seront spécifiées sur la ligne.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code that is valid for the purchase line.', FRA = 'Spécifie le code unité valable pour la ligne achat.';
        }
        modify("Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the name of the unit of measure for the item, such as 1 bottle or 1 piece.', FRA = 'Spécifie le nom de l''unité de l''article, par exemple, 1 bouteille ou 1 pièce.';
        }
        modify("Direct Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the direct unit cost of the item on the line.', FRA = 'Spécifie le coût unitaire direct pour l''article sur la ligne.';
        }
        modify("Indirect Cost %")
        {
            ToolTipML = ENU = 'Specifies the item''s indirect cost percentage.', FRA = 'Spécifie le pourcentage de coût indirect de l''article.';
        }
        modify("Unit Cost (LCY)")
        {
            ToolTipML = ENU = 'Specifies the unit cost of the item on the line.', FRA = 'Spécifie le coût unitaire pour l''article sur la ligne.';
        }
        modify("Unit Price (LCY)")
        {
            ToolTipML = ENU = 'Specifies the price for one unit of the item.', FRA = 'Spécifie le prix unitaire de l''article.';
            Enabled = "Unit Price (LCY)Enable";
        }
        modify("Line Amount")
        {
            ToolTipML = ENU = 'Specifies the net amount (before subtracting the invoice discount amount) that must be paid for the items on the line.', FRA = 'Spécifie le montant net (avant soustraction du montant remise facture) à payer pour les articles de la ligne.';
        }
        modify("Line Discount %")
        {
            ToolTipML = ENU = 'Specifies the line discount percentage that is valid for the item on the line.', FRA = 'Spécifie le pourcentage de remise ligne valable pour l''article de la ligne.';
        }
        modify("Line Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of the line discount that will be granted on the purchase line.', FRA = 'Spécifie le montant de la remise ligne qui est accordée sur la ligne achat.';
        }
        modify("Allow Invoice Disc.")
        {
            ToolTipML = ENU = 'Specifies whether the invoice line is included when the invoice discount is calculated.', FRA = 'Spécifie si la ligne facture est incluse lors du calcul de la remise facture.';
        }
        modify("Inv. Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the invoice discount amount for the line.', FRA = 'Spécifie le montant de la remise facture pour la ligne.';
        }
        modify("Allow Item Charge Assignment")
        {
            ToolTipML = ENU = 'Specifies that you can assign item charges to this line.', FRA = 'Spécifie que vous pouvez affecter des frais annexes à cette ligne.';
        }
        modify("Qty. to Assign")
        {
            ToolTipML = ENU = 'Specifies the quantity of the item charge that will be assigned when you post this line.', FRA = 'Spécifie la quantité de frais annexes qui sera affectée lorsque vous validez cette ligne.';
        }
        modify("Qty. Assigned")
        {
            ToolTipML = ENU = 'Specifies how much of the item charge that has been assigned.', FRA = 'Spécifie les frais annexes qui ont été affectés.';
        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'If you fill in this field and the Job Task No. field, then a job ledger entry will be posted together with the purchase order line.', FRA = 'Si vous renseignez ce champ et le champ N° tâche projet, alors une écriture comptable projet sera validée avec la ligne commande achat.';
        }
        modify("Job Task No.")
        {
            ToolTipML = ENU = 'Specifies the number of the job task that corresponds to the purchase document (invoice or credit memo).', FRA = 'Spécifie le numéro de la tâche projet qui correspond au document achat (facture ou avoir).';
        }
        modify("Job Line Type")
        {
            ToolTipML = ENU = 'Specifies a Job Planning Line together with the posting of a job ledger entry.', FRA = 'Spécifie une ligne planning projet lors de la validation d''une écriture comptable projet.';
        }
        modify("Job Unit Price")
        {
            ToolTipML = ENU = 'Specifies the sales price per unit that applies to the item or general ledger expense that will be posted.', FRA = 'Spécifie le prix de vente unitaire qui s''applique à l''article ou la dépense générale qui sera validée.';
        }
        modify("Job Line Amount")
        {
            ToolTipML = ENU = 'Specifies the net amount of the line that the purchase line applies to.', FRA = 'Spécifie le montant net de la ligne à laquelle la ligne achat s''applique.';
        }
        modify("Job Line Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of the discount that the purchase line applies to.', FRA = 'Spécifie le montant de la remise avec laquelle la ligne achat est lettrée.';
        }
        modify("Job Line Discount %")
        {
            ToolTipML = ENU = 'Specifies the line discount percent that applies to the item or general ledger expense.', FRA = 'Indique le pourcentage remise ligne applicable à la dépense générale ou à l''article.';
        }
        modify("Job Total Price")
        {
            ToolTipML = ENU = 'Specifies the gross amount of the line that the purchase line applies to.', FRA = 'Spécifie le montant brut de la ligne à laquelle la ligne achat s''applique.';
        }
        modify("Job Unit Price (LCY)")
        {
            ToolTipML = ENU = 'Specifies the sales price per unit that applies to the item or general ledger expense that will be posted.', FRA = 'Spécifie le prix de vente unitaire qui s''applique à l''article ou la dépense générale qui sera validée.';
        }
        modify("Job Total Price (LCY)")
        {
            ToolTipML = ENU = 'Specifies the gross amount of the line, in the local currency.', FRA = 'Spécifie le montant brut de la ligne dans la devise société.';
        }
        modify("Job Line Amount (LCY)")
        {
            ToolTipML = ENU = 'Specifies the net amount of the line that the purchase line applies to.', FRA = 'Spécifie le montant net de la ligne à laquelle la ligne achat s''applique.';
        }
        modify("Job Line Disc. Amount (LCY)")
        {
            ToolTipML = ENU = 'Specifies the amount of the discount that the purchase line applies to.', FRA = 'Spécifie le montant de la remise avec laquelle la ligne achat est lettrée.';
        }
        modify("Prod. Order No.")
        {
            ToolTipML = ENU = 'Specifies the number of the production order that the purchase order was created for.', FRA = 'Spécifie le numéro de l''O.F. pour lequel la commande achat a été créée.';
        }
        modify("Blanket Order No.")
        {
            ToolTipML = ENU = 'Specifies the document number of the blanket order from which this purchase line originates.', FRA = 'Spécifie le numéro de document de la commande ouverte qui est à l''origine de cette ligne achat.';
        }
        modify("Blanket Order Line No.")
        {
            ToolTipML = ENU = 'Specifies the line number of the blanket order line from which this purchase line originates.', FRA = 'Spécifie le numéro de ligne de la ligne de la commande ouverte qui est à l''origine de cette ligne achat.';
        }
        modify("Insurance No.")
        {
            ToolTipML = ENU = 'Specifies an insurance number if you have selected the Acquisition Cost option in the FA Posting Type field.', FRA = 'Spécifie un numéro d''assurance si vous avez sélectionné l''option Coût acquisition dans le champ Type compta. immo.';
        }
        modify("Budgeted FA No.")
        {
            ToolTipML = ENU = 'You can use this field if you have selected Fixed Asset in the Type field for this line.', FRA = 'Vous pouvez utiliser ce champ si vous avez sélectionné Immobilisation dans le champ Type de cette ligne.';
        }
        modify("FA Posting Type")
        {
            ToolTipML = ENU = 'Specifies the FA posting type if you have selected Fixed Asset in the Type field for this line.', FRA = 'Spécifie le type comptabilisation immobilisation si vous avez sélectionné Immobilisation dans le champ Type pour cette ligne.';
        }
        modify("Depreciation Book Code")
        {
            ToolTipML = ENU = 'Specifies the code for the depreciation book to which the line will be posted if you have selected Fixed Asset in the Type field for this line.', FRA = 'Spécifie le code des lois d''amortissement sur lesquelles la ligne sera validée, si vous avez sélectionné Immobilisation dans le champ Type de cette ligne.';
        }
        modify("Depr. until FA Posting Date")
        {
            ToolTipML = ENU = 'You can use this field if you have selected Fixed Asset in the Type field for this line.', FRA = 'Vous pouvez utiliser ce champ si vous avez sélectionné Immobilisation dans le champ Type de cette ligne.';
        }
        modify("Depr. Acquisition Cost")
        {
            ToolTipML = ENU = 'This field is relevant when you post an additional acquisition cost and a possible salvage value to an already acquired asset.', FRA = 'Ce champ est pertinent lorsque vous validez un coût d''acquisition supplémentaire et une valeur résiduelle possible sur une immobilisation déjà acquise.';
        }
        modify("Duplicate in Depreciation Book")
        {
            ToolTipML = ENU = 'You can use this field if you have selected Fixed Asset in the Type field for this line.', FRA = 'Vous pouvez utiliser ce champ si vous avez sélectionné Immobilisation dans le champ Type de cette ligne.';
        }
        modify("Use Duplication List")
        {
            ToolTipML = ENU = 'You can use this field if you have selected Fixed Asset in the Type field for this line.', FRA = 'Vous pouvez utiliser ce champ si vous avez sélectionné Immobilisation dans le champ Type de cette ligne.';
        }
        modify("Appl.-to Item Entry")
        {
            ToolTipML = ENU = 'Specifies the item ledger entry number the line should be applied to.', FRA = 'Spécifie le numéro de l''écriture comptable article avec laquelle la ligne doit être lettrée.';
        }
        modify("Deferral Code")
        {
            ToolTipML = ENU = 'Specifies the deferral template that governs how expenses paid with this purchase document are deferred to the different accounting periods when the expenses were incurred.', FRA = 'Spécifie le modèle d''échelonnement qui régit la manière dont les dépenses payées avec ce document achat sont reportées sur les différentes périodes de comptabilité lorsque des dépenses sont encourues.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
            trigger OnAfterValidate()
            begin
                //HEI.02 PATHAA02 PTPGAP071>>
                IF Rec."Document Type" = Rec."Document Type"::Invoice THEN BEGIN
                    IF xRec."Shortcut Dimension 1 Code" <> Rec."Shortcut Dimension 1 Code" THEN
                        ERROR(Text50000);
                END;

                //HEI.02 PATHAA02 PTPGAP071<<
            end;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
            trigger OnAfterValidate()
            begin
                //HEI.02 PATHAA02 PTPGAP071>>
                IF Rec."Document Type" = Rec."Document Type"::Invoice THEN BEGIN
                    IF xRec."Shortcut Dimension 2 Code" <> Rec."Shortcut Dimension 2 Code" THEN
                        ERROR(Text50000);
                END;
                //HEI.02 PATHAA02 PTPGAP071<<
            end;
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number.', FRA = 'Spécifie le numéro du document.';
        }
        modify("Line No.")
        {
            ToolTipML = ENU = 'Specifies the line''s number.', FRA = 'Spécifie le numéro de ligne.';
        }
        modify(AmountBeforeDiscount)
        {
            CaptionML = ENU = 'Subtotal Excl. VAT', FRA = 'Sous-total HT';
            ToolTipML = ENU = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document.', FRA = 'Spécifie la somme de la valeur dans le champ Montant acompte HT sur toutes les lignes du document.';
        }
        modify(InvoiceDiscountAmount)
        {
            CaptionML = ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
            ToolTipML = ENU = 'Specifies a discount amount that is deducted from the value in the Total Incl. VAT field. You can enter or change the amount manually.', FRA = 'Spécifie un montant de remise qui est déduit de la valeur dans le champ Total TTC. Vous pouvez saisir ou modifier le montant manuellement.';
        }
        modify("Invoice Disc. Pct.")
        {
            CaptionML = ENU = 'Invoice Discount %', FRA = '% remise facture';
            ToolTipML = ENU = 'Specifies a discount amount that is deducted from the value in the Total Incl. VAT field. You can enter or change the amount manually.', FRA = 'Spécifie un montant de remise qui est déduit de la valeur dans le champ Total TTC. Vous pouvez saisir ou modifier le montant manuellement.';
        }
        modify("Total Amount Excl. VAT")
        {
            CaptionML = ENU = 'Total Amount Excl. VAT', FRA = 'Montant total HT';
            ToolTipML = ENU = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.', FRA = 'Spécifie la somme de la valeur du champ Montant ligne HT sur toutes les lignes du document, moins l''éventuel montant remise indiqué dans le champ Montant remise facture.';
        }
        modify("Total VAT Amount")
        {
            CaptionML = ENU = 'Total VAT', FRA = 'Total TVA';
            ToolTipML = ENU = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.', FRA = 'Spécifie la somme de la valeur du champ Montant ligne HT sur toutes les lignes du document, moins l''éventuel montant remise indiqué dans le champ Montant remise facture.';
        }
        modify("Total Amount Incl. VAT")
        {
            CaptionML = ENU = 'Total Amount Incl. VAT', FRA = 'Montant total TTC';
            ToolTipML = ENU = 'Specifies the sum of the value in the Line Amount Incl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.', FRA = 'Spécifie la somme de la valeur du champ Montant TTC sur toutes les lignes du document, moins l''éventuel montant remise indiqué dans le champ Montant remise facture.';
        }
        //Bc Upgrade YADAVM09>>
        modify("Gen. Prod. Posting Group")
        {
            Editable = false;
            Visible = false;
        }
        modify("Description 2")
        {
            Description = 'DIT-715 #393';
            Visible = false;
        }
        //Bc Upgrade YADAVM09<<

        //Unsupported feature: CodeModification on "Type(Control 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        NoOnAfterValidate;

        if xRec."No." <> '' then
          RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

        TypeOnAfterValidate;
        #1..4
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


        //Unsupported feature: CodeModification on ""Cross-Reference No."(Control 72).OnLookup". Please convert manually.

        //trigger "(Control 72)();
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


        //Unsupported feature: CodeInsertion on ""Variant Code"(Control 30)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

        VariantCodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT Prod. Posting Group"(Control 14).OnValidate". Please convert manually.

        //trigger  Posting Group"(Control 14)();
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
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Control 58)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

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
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

        QuantityOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure Code"(Control 34).OnValidate". Please convert manually.

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
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

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
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

        DirectUnitCostOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Amount"(Control 52).OnValidate". Please convert manually.

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
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

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
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

        LineDiscount37OnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Discount Amount"(Control 48).OnValidate". Please convert manually.

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
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

        LineDiscountAmountOnAfterValid;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Allow Invoice Disc."(Control 46)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Inv. Discount Amount"(Control 36)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shortcut Dimension 1 Code"(Control 62)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.02 PATHAA02 PTPGAP071>>
        if "Document Type"="Document Type"::Invoice then begin
          if xRec."Shortcut Dimension 1 Code" <> Rec. "Shortcut Dimension 1 Code" then
           ERROR(Text50000);
        end;
        //HEI.02 PATHAA02 PTPGAP071<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shortcut Dimension 2 Code"(Control 60)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.02 PATHAA02 PTPGAP071>>
        if "Document Type"="Document Type"::Invoice then begin
          if xRec."Shortcut Dimension 2 Code" <> Rec. "Shortcut Dimension 2 Code" then
           ERROR(Text50000);
        end;
        //HEI.02 PATHAA02 PTPGAP071<<
        */
        //end;
        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        addafter("No.")
        {
            field("Has Item Charge"; Rec."Has Item Charge")
            {
                BlankZero = true;
                QuickEntry = false;
            }
            field(Collapse; Rec.Collapse)
            {
                QuickEntry = false;
                Visible = false;

                trigger OnValidate();
                begin
                    // <<DITW15.00.00.37 DDR 19/01/2010
                    CurrPage.UPDATE(true);
                    // >>DITW15.00.00.37 DDR
                end;
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
        addafter("VAT Prod. Posting Group")
        {
            field("Expected Receipt Date"; Rec."Expected Receipt Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date you expect the items to be available in your warehouse.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the Expected Receipt Date field.';

            }
            field("Planned Receipt Date"; Rec."Planned Receipt Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date when the item is planned to arrive in inventory. Forward calculation: planned receipt date = order date + vendor lead time (per the vendor calendar and rounded to the next working day in first the vendor calendar and then the location calendar). If no vendor calendar exists, then: planned receipt date = order date + vendor lead time (per the location calendar). Backward calculation: order date = planned receipt date - vendor lead time (per the vendor calendar and rounded to the previous working day in first the vendor calendar and then the location calendar). If no vendor calendar exists, then: order date = planned receipt date - vendor lead time (per the location calendar).';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the Planned Receipt Date field.';

            }
            /* //Bc Upgrade YADAVM09 Drink it field Dependency>>
            field("GetTrackingItemNo()"; Rec.GetTrackingItemNo())
            {
                CaptionML = ENU = 'Tracking Item No. (Item Charge)',
                            FRA = 'N° article traçable (Frais annexes)';
                DrillDownPageID = "Item List";
                Editable = false;
                LookupPageID = "Item List";
                TableRelation = IF ("Item Charge Type" = CONST(Tax)) Item WHERE("No." = FIELD("Tax Item No."))
                ELSE IF ("Item Charge Type" = CONST(Deposit)) Item WHERE("No." = FIELD("Empty Goods Item No."));
                Visible = false;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    // <<DITW15.00.00.38 DDR 17/12/2010 #703
                    Text := GetTrackingItemNo();
                    LookupItemNo(Text);
                    exit(false);
                end;
            }
             */ //Bc Upgrade YADAVM09 Drink it field Dependency<<
        }
        addafter(Description)
        {
            field("Additional Description"; Rec."Additional Description FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Additional Description field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the Additional Description field.';

            }
            /* //Bc Upgrade YADAVM09 field Already exsist>>
            field("Description 2"; Rec."Description 2")
            {
                Description = 'DIT-715 #393';
                Visible = false;
            }
            */ //Bc Upgrade YADAVM09 field Already exsist<<
        }
        addafter("Return Reason Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Responsibility Center field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the Responsibility Center field.';


                /* //Bc Upgrade YADAVM09 Drink it field>>
                                trigger OnValidate();
                                begin
                                    // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                                    if "Responsibility Center" <> xRec."Responsibility Center" then
                                        CurrPage.UPDATE(true);
                                    // >>DITW18.00.06 DDR DIT-770 #1191
                                end;
                */ //Bc Upgrade YADAVM09 Drink it field>>
            }
            /* //Bc Upgrade YADAVM09 Drink it field>>
            field("Physical Location Group Code"; "Physical Location Group Code")
            {
                Visible = false;

                trigger OnValidate();
                begin
                    // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                    if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                        CurrPage.UPDATE(true);
                    // >>DITW18.00.06 DDR DIT-770 #1191
                end;
            }*/ //Bc Upgrade YADAVM09 Drink it field<<
        }

        addafter(Quantity)
        {
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09
                Visible = EnableCAD;
                ToolTip = 'Specifies the value of the CAD Amount field.';
            }
        }
        /* //Bc Upgrade YADAVM09 Drink it field>>
        addafter("Unit of Measure Code")
        {
            field("Tariff No."; Rec."Tariff No.")
            {
                Description = 'FINXL7.00';
                Visible = false;
            }
            field("Net Weight"; "Net Weight")
            {
                Description = 'FINXL7.00';
                Visible = false;
            }
        }
       
        addafter("Line Amount")
        {
            field("Approved Line Amount"; Rec."Approved Line Amount")
            {
                Description = 'DITW17.00.02 DIT-770 #144';
                Visible = false;
            }
            field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Direct Unit Cost"), true))
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 2;
                BlankZero = true;
                CaptionClass = GetCaptionClassVar(PageText2014411);
                CaptionML = ENU = 'Total Direct Unit Cost',
                            FRA = 'Total coût unitaire directe';
                Description = 'DITW17.10.05 DIT-770 #988';
                Editable = false;
                QuickEntry = false;
                Visible = false;
            }
            field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), true))
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
                BlankZero = true;
                CaptionClass = GetCaptionClassVar(PageText2014410);
                CaptionML = ENU = 'Total Line Amount',
                            FRA = 'Montant total ligne';
                Description = 'DITW17.10.02B DIT-770 #541';
                Editable = false;
                QuickEntry = false;
            }
        }
         */ //Bc Upgrade YADAVM09 Drink it field<<
        addafter("Line Discount Amount")
        {
            field("Tolerance Exceeded"; Rec."Tolerance Exceeded FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09
                Editable = false;
                ToolTip = 'Specifies the value of the Tolerance Exceeded field.';
            }
            field("HS Posting Group"; Rec."HS Posting Group FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the HS Posting Group field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the HS Posting Group field.';


                trigger OnValidate();
                begin
                    CurrPage.UPDATE(true)//HEI.07
                end;
            }
            field("H&S Levy Tax Amount"; Rec."H&S Levy Tax Amount FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the H&S Levy Tax Amount field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the H&S Levy Tax Amount field.';

            }
        }
        /* //Bc Upgrade YADAVM09 Drink it field>>
       addafter("Appl.-to Item Entry")
       {
           field("Auto. Acc. Group"; Rec."Auto. Acc. Group")
           {
               Description = 'FINXL7.00';
           }
       }
        */ //Bc Upgrade YADAVM09 Drink it field<<
           /* //Bc Upgrade YADAVM09 Drink it field>>
          addafter("Deferral Code")
          {

              field("Vendor DTax Group Code"; "Vendor DTax Group Code")
              {
                  Description = 'DIT-770 #698';
                  Editable = false;
                  QuickEntry = false;
                  Visible = false;
              }
              field("Item DTax Group Code"; "Item DTax Group Code")
              {
                  Description = '<DITW15.00.00.01>- DIT-770 #698';
                  Editable = false;
                  QuickEntry = false;
                  Visible = false;
              }

              field("AAD No."; Rec."AAD No.")
              {
                  Visible = false;
              }
              field("ARC No."; "ARC No.")
              {
                  Description = 'DITW15.00.00.38 #1217';
                  Visible = false;

                  trigger OnLookup(Text: Text): Boolean;
                  begin
                      // <<DITW15.00.00.38 DDR 30/09/2010 #1217
                      exit(
                        EDILookupExtTrackingARC(Text));
                      // >>DITW15.00.00.38 DDR
                  end;
              }
              field("SAD No."; "SAD No.")
              {
                  Description = 'DITW15.00.00.38 #1217';
                  Visible = false;
              }
              field("Packaging Type Code"; Rec."Packaging Type Code")
              {
                  Visible = false;
              }
              field("Free Item"; Rec."Free Item")
              {

                  trigger OnValidate();
                  begin
                      FreeItemOnAfterValidate;
                  end;
              }
              field("Allow VAT Calculation (Free)"; "Allow VAT Calculation (Free)")
              {
                  Description = 'DITW16.00.00.40 DIT-715 #172';
                  Visible = false;

                  trigger OnValidate();
                  begin
                      AllowVATCalculationFreeOnAfter;
                  end;
              }
              field("Free Item Posting Type"; "Free Item Posting Type")
              {
                  Visible = false;

                  trigger OnValidate();
                  begin
                      FreeItemPostingTypeOnAfterVali;
                  end;
              }
              field("Contract Type"; "Contract Type")
              {
                  Editable = false;
                  Visible = false;
              }
              field("DIT Sub-Contract Type"; "DIT Sub-Contract Type")
              {
                  Visible = false;
              }
              field("Service Contract No."; "Service Contract No.")
              {
                  Visible = false;
              }
              field("Financial Contract No."; "Financial Contract No.")
              {
                  Visible = false;
              }
              field("Contract Group Code"; "Contract Group Code")
              {
                  Visible = false;
              }

              field("Linked Customer No."; Rec."Linked Customer No.")
              {
                  Visible = false;
              }

          }
          */ //Bc Upgrade YADAVM09 Drink it field<<
        addafter("Shortcut Dimension 2 Code")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
            }
            field("WHT Product Posting Group"; Rec."WHT Product Posting Group FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the WHT Product Posting Group field.';
            }
        }
        addafter("Line No.")
        {
            /* //Bc Upgrade YADAVM09 Drink it field<<
            field("Intrastat Mandatory"; "Intrastat Mandatory")
            {
                Description = 'FINXL9.00.000.01';
            }
            */ //Bc Upgrade YADAVM09 Drink it field<<
            /* //Bc Upgrade YADAVM09 Field already exists>>
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                Editable = false;
                Visible = false;
            }
             */ //Bc Upgrade YADAVM09 Field already exists<<
            /* //Bc Upgrade YADAVM09 Drink it field<<
            field("App. Prod. Posting Group"; Rec."App. Prod. Posting Group")
            {
                Description = 'DITW17.00.02 DIT-770 #144';
                Visible = false;
            }
            */ //Bc Upgrade YADAVM09 Drink it field<<
            field("Qty. to Invoice"; Rec."Qty. to Invoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity that remains to be invoiced. It is calculated as Quantity - Qty. Invoiced.';
                //Bc Upgrade YADAVM09                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ToolTip = 'Specifies the value of the Qty. to Invoice field.';

            }
            field("Vendor Shipment No."; Rec."Vendor Shipment No. FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Shipment No. field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the Vendor Shipment No. field.';

            }
            field("TIN No."; Rec."TIN No. FND")
            {
                Caption = 'TIN No.';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TIN No. field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the TIN No. field.';

            }
            field("SPL Code"; Rec."SPL Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SPL Code field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the SPL Code field.';

            }
            field("SPL Name"; Rec."SPL Name FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SPL Name field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the SPL Name field.';

            }
            field("Consumption SPL Code"; Rec."Consumption SPL Code FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Consumption SPL Code field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the Consumption SPL Code field.';

            }
        }
        addafter("Total VAT Amount")
        {
            field(TotalCADAmount; CADTotalAmount)//BC Upgrade SHARMP16 CAD
            {
                AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                CaptionClass = BCHNKCustomFunction.GetTotalCADCaption(rec."Currency Code");//BC Upgrade SHARMP16 CAD
                Caption = 'Total CAD Amount';
                Editable = false;
                Visible = EnableCAD;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total CAD Amount field.';
            }
        }
        addafter("Total Amount Incl. VAT")
        {
            field(TotalInclCAD; TotalInclCAD)
            {
                AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                // CaptionClass = 'DocumentTotals.GetTotalInclCADCaption,(TotalPurchaseHeader."Currency Code")';
                CaptionClass = BCHNKCustomFunction.GetTotalInclCADCaption(rec."Currency Code");//BC Upgrade SHARMP16 CAD
                Caption = 'Total Incl. CAD';
                Editable = false;
                Visible = EnableCAD;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total Incl. CAD field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the Total Incl. CAD field.';

            }
        }
    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("E&xplode BOM")
        {
            CaptionML = ENU = 'E&xplode BOM', FRA = '&Eclater nomenclature';
        }
        modify(InsertExtTexts)
        {
            CaptionML = ENU = 'Insert &Ext. Texts', FRA = 'Insérer te&xtes étendus';
            ToolTipML = ENU = 'Insert the extended description that is set up.', FRA = 'Insérez la description plus longue qui est configurée.';
        }
        modify(GetReceiptLines)
        {
            CaptionML = ENU = '&Get Receipt Lines', FRA = 'Extraire lignes réce&ption';
        }
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify("Item Availability by")
        {
            CaptionML = ENU = 'Item Availability by', FRA = 'Disponibilité article par';
        }
        modify("Event")
        {
            CaptionML = ENU = 'Event', FRA = 'Événement';
        }
        modify(Period)
        {
            CaptionML = ENU = 'Period', FRA = 'Période';
        }
        modify(Variant)
        {
            CaptionML = ENU = 'Variant', FRA = 'Variante';
        }
        modify(Location)
        {
            CaptionML = ENU = 'Location', FRA = 'Magasin';
        }
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level', FRA = 'Niveau nomenclature';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(ItemChargeAssignment)
        {
            CaptionML = ENU = 'Item Charge &Assignment', FRA = '&Affectation frais annexes';
        }
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
        }
        modify(DeferralSchedule)
        {
            CaptionML = ENU = 'Deferral Schedule', FRA = 'Tableau d''échelonnement';
            ToolTipML = ENU = 'View or edit the deferral schedule that governs how expenses incurred with this purchase document is deferred to different accounting periods when the document is posted.', FRA = 'Affichez ou modifiez le tableau d''échelonnement qui régit la manière dont les dépenses encourues à l''aide de ce document achat sont échelonnées sur différentes périodes comptables lorsque le document est validé.';
        }
        /* //Bc Upgrade YADAVM09 Drink it Action>>
       addfirst(ActionContainer1900000004)
       {
           action("+ Expand")
           {
               CaptionML = ENU = '+ Expand',
                           FRA = '+ Développer';
               Enabled = (NOT ExpandLines);
               Image = ViewDetails;
               //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
               //PromotedCategory = Process;
               //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
               //PromotedIsBig = true;
               Visible = (NOT ExpandLines) OR ShowButtonsCE;

               trigger OnAction();
               begin
                   // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                   ExpandLines := true;
                   CurrPage.UPDATE(true);
                   // >>DITW17.10.03 DDR DIT-770 #541
               end;
           }
           action("- Collapse")
           {
               CaptionML = ENU = '- Collapse',
                           FRA = '- Réduire';
               Enabled = ExpandLines;
               Image = ViewDetails;
               //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
               //PromotedCategory = Process;
               //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
               //PromotedIsBig = true;
               Visible = ExpandLines OR ShowButtonsCE;

               trigger OnAction();
               begin
                   // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                   ExpandLines := false;
                   CurrPage.UPDATE(true);
                   // >>DITW17.10.03 DDR DIT-770 #541
               end;
           }
       }
        */ //Bc Upgrade YADAVM09 Drink it Action<<
           /* //Bc Upgrade YADAVM09 Drink it Action>>
           addafter(InsertExtTexts)
           {
               action("Insert Item Charge&s")
               {
                   CaptionML = ENU = 'Insert Item Charge&s',
                               FRA = 'Insérer frais annexe';
                   ShortCutKey = 'Ctrl+Y';

                   trigger OnAction();
                   begin
                       // 15-12-05, VS: ProcessArtikeltoeslagen
                       //This functionality was copied from page #51. Unsupported part was commented. Please check it.
                       //CurrPage.PurchLines.PAGE.
                       _InsertExtendedCharges(true);

                   end;
               }


       }*/ //Bc Upgrade YADAVM09 Drink it Action<<
           /* //Bc Upgrade YADAVM09 Drink it Action>>
           addafter(GetReceiptLines)
           {
               action("Get Blanket Order ")
               {
                   CaptionML = ENU = 'Get Blanket Order ',
                               FRA = 'Extraire commandes ouvertes ';

                   trigger OnAction();
                   begin
                       GetPurchBlanketOrder;//DITW17.00.02 SR 23/09/2013 DIT-770 #152
                   end;
               }
               action("Get Shipping &Agent Costs")
               {
                   CaptionML = ENU = 'Get Shipping &Agent Costs',
                               FRA = 'Extraite coûts transporteur';
                   Ellipsis = true;

                   trigger OnAction();
                   begin
                       //<< DITW18.00.07 VSC 08/03/2016 DIT-770 #1066
                       GetShippingCostLines;
                   end;
               }
           }
            */ //Bc Upgrade YADAVM09 Drink it Action<<

        // addafter(DeferralSchedule)// */ //Bc Upgrade YADAVM09 Drink it Action>>
        // {
        //     action("SSCC Tracking Lines")
        //     {
        //         CaptionML = ENU = 'SSCC Tracking Lines',
        //                     FRA = 'Lignes Traçabilité SSCC';
        //         Description = 'DIT-715 #745';
        //         Image = ItemTrackingLines;

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.38 DDR 19/11/2010 #1139
        //             //This functionality was copied from page #51. Unsupported part was commented. Please check it.
        //             /*CurrPage.PurchLines.FORM.*/
        //             _OpenSSCCTrackingLines();

        //         end;
        //     }
        // } Bc Upgrade YADAVM09 Drink it Action<<


    }

    var
        xRecRef: RecordRef;
        // cduAppMgt: Codeunit ApplicationManagement;//Bc Upgrade YADAVM09 Not used anywhere in the code
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Direct Unit Cost', FRA = 'Total coût unitaire directe';
        DisabledRefreshLines: Boolean;

        TypeEditable: Boolean;

        "No.Editable": Boolean;

        "Cross-Reference No.Editable": Boolean;

        QuantityEditable: Boolean;

        "Direct Unit CostEditable": Boolean;

        "Line AmountEditable": Boolean;

        TypeEnable: Boolean;

        "No.Enable": Boolean;

        QuantityEnable: Boolean;

        "Unit Price (LCY)Enable": Boolean;

        "Line AmountEnable": Boolean;

        ExpandLines: Boolean;

        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        UserMgt: Codeunit "User Setup Management";
        SelectedPurchLine: Record "Purchase Line";
        PurchLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        Done: Boolean;
        // recFinXLSetup: Record "Finance XL Setup";//Bc Upgrade YADAVM09 Drink it object
        txtIntrastatMandStyle: Text;
        //QualitySetup: Record "Quality Setup";//Bc Upgrade YADAVM09 Drink it object
        //QualityManagement: Codeunit "Quality Management";//Bc Upgrade YADAVM09 Drink it object
        EditableDesc: Boolean;
        Text50000: Label 'Dimension changes are not allowed in PO Invoices';
        GeneralLedgerSetup: Record "General Ledger Setup";
        EnableCAD: Boolean;
        CADLineModifyErr: Label 'CAD Line cannot be modified.';
        TotalInclCAD: Decimal;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //Bc Upgrade YADAVM09 Code added to adjust function CalculateTotals code as no event found>>
    trigger OnAfterGetCurrRecord();
    var
        PurchaseLine: Record "Purchase Line";
    begin
        //HEI.05>>
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
        //         ELSE
        //             TotalInclCAD := TotalPurchaseLine."Amount Including VAT" + TotalPurchaseLine."CAD Amount FND";
        //     END ELSE
        //         TotalInclCAD := TotalPurchaseLine."Amount Including VAT";
        // END;

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
        //HEI.05<<   
    end;
    //Bc Upgrade YADAVM09 Code added to adjust function CalculateTotals code as no event found<<


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    trigger OnAfterGetRecord();
    begin
        //HEI.01 PATHAA02 07.11.2017>>
        if Rec.Type <> Rec.Type::Item then
            EditableDesc := true
        else
            EditableDesc := false;
        //PATHAA02 07.11.2017<<
        GeneralLedgerSetup.get();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";//BC Upgrade SHARMP16 CAD
    end;


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
    /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

    // <<DITW16.00.00.37 DDR 20/07/2010
    //IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
    //  COMMIT;
    //  IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
    //    EXIT(FALSE);
    //  ReservePurchLine.DeleteLine(Rec);
    //END;
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


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchasesPayablesSetup.GET;
    Currency.InitRoundingPrecision;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW15.00.00.01 DDR 18/12/2007
    "Line AmountEnable" := true;
    "Unit Price (LCY)Enable" := true;
    QuantityEnable := true;
    "No.Enable" := true;
    TypeEnable := true;
    "Line AmountEditable" := true;
    "Direct Unit CostEditable" := true;
    QuantityEditable := true;
    "Cross-Reference No.Editable" := true;
    "No.Editable" := true;
    TypeEditable := true;
    // >>DITW15.00.00.01 DDR 18/12/2007

    PurchasesPayablesSetup.GET;
    Currency.InitRoundingPrecision;
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnModifyRecord". Please convert manually.

    trigger OnModifyRecord(): Boolean;
    begin
        //HEI.05>>
        if Rec."CAD Attached to Line No. FND" <> 0 then
            ERROR(CADLineModifyErr);
        //HEI.05<<
    end;


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
    //EXIT(NEXT(Steps));
    exit(NextRecordDIT(Steps,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    trigger OnOpenPage();
    begin
        //HEI.05>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.05<<

    end;


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
    // <<DITW15.00.00.36 DDR 25/11/2009 - DITW15.00.00.38 DDR 15/03/2011 #1291
    if (Type <> Type::Item) and not "Is Item Charge" then
    // >>DITW15.00.00.36 DDR - DITW15.00.00.38 DDR #1291
      InsertExtendedText(false);
    #3..6
    /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

    // <<DITW15.00.00.23 DDR 30/07/2008
    CurrPage.UPDATE;
    // >>DITW15.00.00.23 DDR
    */
    //end;


    //Unsupported feature: CodeModification on "RedistributeTotalsOnAfterValidate(PROCEDURE 8)". Please convert manually.

    //procedure RedistributeTotalsOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.SAVERECORD;

    DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalPurchaseLine);

    CurrPage.UPDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    CurrPage.UPDATE;
    */
    //end;




    //Unsupported feature: CodeModification on "CalculateTotals(PROCEDURE 25)". Please convert manually.

    //procedure CalculateTotals();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetTotalPurchHeader;
    TotalPurchaseHeader.CALCFIELDS("Recalculate Invoice Disc.");

    #4..9
    DocumentTotals.CalculatePurchaseTotals(TotalPurchaseLine,VATAmount,Rec);
    InvoiceDiscountAmount := TotalPurchaseLine."Inv. Discount Amount";
    InvoiceDiscountPct := PurchCalcDiscByType.GetVendInvoiceDiscountPct(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12

    //HEI.05>>
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
    //HEI.05<<
    */
    //end;

    local procedure CrossReferenceNoOnAfterValidat();
    begin
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

        // <<DITW15.00.00.38 DDR 27/01/2011 #1259
        //InsertExtendedText(FALSE);
        CurrPage.UPDATE();
        // >>DITW15.00.00.38 DDR #1259
    end;

    /* //Bc Upgrade YADAVM09 Drink it function >>
        procedure _InsertExtendedCharges(FromHeader: Boolean);
        begin
            // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
            if InsertChargeLines(FromHeader) then
                UpdateForm(true);
            // >>DITW15.00.00.23 DDR
        end;
    */  //Bc Upgrade YADAVM09 Drink it function <<

    /*//Bc Upgrade YADAVM09 Drink it function>>
        procedure InsertExtendedCharges(FromHeader: Boolean);
        begin
            // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
            if InsertChargeLines(FromHeader) then
                UpdateForm(true);
            // >>DITW15.00.00.23 DDR
        end;

            local procedure UpdateFields();
            var
                CollapsedLine: Boolean;
            begin
                // <<DITW15.00.00.01 DDR 15/02/2008 - DITW15.00.00.38 DDR 16/07/2010 #1194
                // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
                CollapsedLine := not ExpandLines;
                // >>DITW17.10.03 DDR DIT-770 #541
                // <<DITW17.10.03 DDR 09/07/2014 DIT-770 #541
                CALCFIELDS("Has Item Charge");
                CollapsedLine := CollapsedLine and "Has Item Charge";
                // >>DITW17.10.03 DDR DIT-770 #541
                TypeEditable := FormEditableField(FIELDNO(Type));
                "No.Editable" := FormEditableField(FIELDNO("No."));
                // <<DITW15.00.00.38 DDR 27/01/2011 #1259
                "Cross-Reference No.Editable" := FormEditableField(FIELDNO("Cross-Reference No."));
                // >>DITW15.00.00.38 DDR #1259

                QuantityEditable := FormEditableField(FIELDNO(Quantity));
                "Direct Unit CostEditable" := FormEditableField(FIELDNO("Direct Unit Cost")) and not CollapsedLine;
                "Line AmountEditable" := FormEditableField(FIELDNO("Line Amount")) and not CollapsedLine;

                // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
                TypeEnable := FormEditableField(FIELDNO(Type));
                "No.Enable" := FormEditableField(FIELDNO("No."));
                QuantityEnable := FormEditableField(FIELDNO(Quantity));
                "Unit Price (LCY)Enable" := FormEditableField(FIELDNO("Unit Price (LCY)"));
                "Line AmountEnable" := FormEditableField(FIELDNO("Line Amount"));
                // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
            end;

            procedure NewLine();
            var
                PurchLine: Record "Purchase Line";
            begin
                // <<DITW16.00.00.37 DIT-715 #1
                if FINDLAST then;
                PurchLine := Rec;
                INIT;
                "Document Type" := PurchLine."Document Type";
                "Document No." := PurchLine."Document No.";
                "Line No." := PurchLine."Line No." + 10000;
                INSERT(true);
                CurrPage.UPDATE(false);
                // >>DITW16.00.00.37 DIT-715 #1
            end;

            procedure DeleteLine();
            begin
                // <<DITW16.00.00.37 DIT-715 #1
                DELETE(true);
                CurrPage.UPDATE(false);
                // >>DITW16.00.00.37 DIT-715 #1
            end;

            procedure _OpenSSCCTrackingLines();
            begin
                // <<DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745
                Rec.OpenSSCCTrackingLines();
            end;

            procedure OpenSSCCTrackingLines();
            begin
                // <<DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745
                Rec.OpenSSCCTrackingLines();
            end;

            local procedure TriggerOnDeleteRecord(): Boolean;
            var
                ReservePurchLine: Codeunit "Purch. Line-Reserve";
                TempRec: Record "Purchase Line" temporary;
            begin
                if (Quantity <> 0) and ItemExists("No.") then begin
                    COMMIT;
                    if not ReservePurchLine.DeleteLineConfirm(Rec) then
                        exit(false);
                    // <<QXL9.00.001 DAT 23/03/2016
                    if QualitySetup.READPERMISSION then begin
                        if not QualityManagement.DeletePurchLineConfirm(Rec) then
                            exit(false);
                    end;
                    // >>QXL9.00.001 DAT 23/03/2016
                    ReservePurchLine.DeleteLine(Rec);
                    // <<QXL9.00.001 DAT 23/03/2016
                    if QualitySetup.READPERMISSION then
                        QualityManagement.DeletePurchLine(Rec);
                    // >>QXL9.00.001 DAT 23/03/2016
                end;
                // <<DITW15.00.00.36 DDR 23/11/2009
                if "Is Item Charge" and "ItemCharge Incl. Price" then begin
                    DELETE(true);
                    TempRec := Rec;
                    TempRec."Direct Unit Cost" := 0;
                    TempRec."Line Amount" := 0;
                    TempRec."Line Discount Amount" := 0;
                    // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
                    TempRec.CalcBackDirectCostItem();
                    // >>DITW110.00.11 DDR NRQ#24875
                    exit(false);
                end;
                // >>DITW15.00.00.36 DDR
                exit(true);
            end;

            procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
            begin
                // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                DisabledRefreshLines := NewDisabledRefreshLines;
            end;

            local procedure TypeOnAfterValidate();
            begin
                // <<DITW15.00.00.01 DDR 15/01/2008
                if Type <> xRec.Type then
                    CurrPage.UPDATE;
                // >>DITW15.00.00.01 DDR
            end;

            local procedure VariantCodeOnAfterValidate();
            begin
                // <<DITW15.00.00.01 DDR DDR 15/01/2008
                if (Type = Type::Item) and
                   (xRec."Variant Code" <> "Variant Code")
                then
                    CurrPage.UPDATE(true);
                // >>DITW15.00.00.01 DDR
            end;

            local procedure LocationCodeOnAfterValidate();
            var
                UpdateIsDone: Boolean;
            begin
                // <<DITW15.00.00.01 DDR DDR 15/01/2008
                if (Type = Type::Item) and
                   not UpdateIsDone
                then
                    CurrPage.UPDATE(true);
                // >>DITW15.00.00.01 DDR
            end;

            local procedure QuantityOnAfterValidate();
            var
                UpdateIsDone: Boolean;
            begin
                // <<DITW15.00.00.01 DDR DDR 15/01/2008
                if (Type = Type::Item) and
                   (Quantity <> xRec.Quantity) and
                   not UpdateIsDone
                then
                    CurrPage.UPDATE(true);
                // >>DITW15.00.00.01 DDR
            end;

            local procedure UnitofMeasureCodeOnAfterValida();
            var
                UpdateIsDone: Boolean;
            begin
                // <<DITW15.00.00.01 DDR DDR 15/01/2008
                if (Type = Type::Item) and
                   not UpdateIsDone
                then
                    CurrPage.UPDATE(true);
                // >>DITW15.00.00.01 DDR
            end;

            local procedure DirectUnitCostOnAfterValidate();
            begin
                // <<DITW15.00.00.01 DDR 21/12/2007
                if (Type = Type::Item) and
                   ("Direct Unit Cost" <> xRec."Direct Unit Cost")
                then
                    CurrPage.UPDATE(true);
                // >>DITW15.00.00.01 DDR
            end;

            local procedure LineAmountOnAfterValidate();
            begin
                // <<DITW15.00.00.01 DDR 21/12/2007
                if (Type = Type::Item) and
                   ("Line Amount" <> xRec."Line Amount")
                then
                    CurrPage.UPDATE(true);
                // >>DITW15.00.00.01 DDR
            end;

            local procedure LineDiscount37OnAfterValidate();
            begin
                // <<DITW15.00.00.01 DDR 21/12/2007
                if (Type = Type::Item) and
                   ("Line Discount %" <> xRec."Line Discount %")
                then
                    CurrPage.UPDATE(true);
                // >>DITW15.00.00.01 DDR
            end;

            local procedure LineDiscountAmountOnAfterValid();
            begin
                // <<DITW15.00.00.01 DDR 21/12/2007
                if (Type = Type::Item) and
                   ("Line Discount Amount" <> xRec."Line Discount Amount")
                then
                    CurrPage.UPDATE(true);
                // >>DITW15.00.00.01 DDR
            end;

            local procedure FreeItemOnAfterValidate();
            begin
                // <<DITW15.00.00.35 DDR 25/06/2009
                if (Type = Type::Item) and
                   (xRec."Free Item" <> "Free Item")
                then
                    CurrPage.UPDATE(true);
                // >>DITW15.00.00.35 DDR
            end;
        *///Bc Upgrade YADAVM09 Drink it function<<
    local procedure AllowVATCalculationFreeOnAfter();
    begin
        CurrPage.UPDATE(true);
    end;

    /*//Bc Upgrade YADAVM09 Drink it function>>
        local procedure FreeItemPostingTypeOnAfterVali();
        begin
            // <<DITW15.00.00.35 DDR 25/06/2009
            if Type = Type::Item then
                CurrPage.UPDATE(true);
            // >>DITW15.00.00.35 DDR
        end;

        local procedure GetPurchBlanketOrder();
        begin
            CODEUNIT.RUN(CODEUNIT::"Purch.-Get Blanket Order", Rec);//DITW17.00.02 SR 23/09/2013 DIT-770 #152
        end;

        local procedure GetShippingCostLines();
        begin
            //<< DITW18.00.07 VSC 08/03/2016 DIT-770 #1066
            CODEUNIT.RUN(CODEUNIT::"Purch-Get Shipping Costs", Rec);
        end;

        local procedure fctUpdateStyle();
        begin
            //<<FINXL9.00.000.01 ACH 05/01/2016
            if "Intrastat Mandatory" then
                txtIntrastatMandStyle := 'Unfavorable'
            else
                txtIntrastatMandStyle := 'Standard';
            //>>FINXL9.00.000.01 ACH 05/01/2016
        end;
        *///Bc Upgrade YADAVM09 Drink it function<<

    //Unsupported feature: Change Editable on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    var
        BCHNKCustomFunction: Codeunit "Heineken BC Custom Functions";
        CADTotalAmount: Decimal;

}

