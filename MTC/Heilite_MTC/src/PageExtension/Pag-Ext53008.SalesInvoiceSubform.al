pageextension 53008 SalesInvoiceSubformExt extends "Sales Invoice Subform"
{
    // version NAVW110.0.00.16996,FINXL10.00,DITW110.00.08,HEI.04
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
    // DITW15.00.00.23 DDR 29/07/2008 Remove call function InsertExtendedCharges() from trigger OnAfterValidate field "No."
    //                                Updated function into InsertExtendedCharges()
    //                     31/07/2008 Move NewRecord() function into OnNewRecord trigger
    // DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
    //                                  "Empty Goods Item No."
    // DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //                     21/08/2009 issue 727 Added HorzAlign property in field "Unit Price"
    //                 DDR 14/10/2009 issue 893 Removed fields "Gen. Prod. Posting Free Group"
    // DITW15.00.00.36 DDR 04/11/2009 issue 939 Performance SQL
    //                                          Added function FormTotalingField()
    // DITW15.00.00.37 DDR 11/05/2010 issue 1061 Added field "Physical Location Group Code"
    //                     01/06/2010 issue 959 Added field "AAD No. Series"
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    // DITW15.00.00.38 DDR 19/11/2010 issue 1139 SSCC Functionnalities
    //                                  Added functions OpenSSCCTrackingLines()
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
    //                                               "LRN No. Series","SAD No.","Tariff No."
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

    // FINXL7.00.001 RBE 20/03/2013: Added fields "Tariff No." & "Net Weight" (not visible)
    //                               Added following field: "Auto. Acc. Group"

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 AT  12/09/2013 DIT-770 #132 merge WHN-006 HIT0122.1
    //                             Add new field to DIT #376 promotion reason codes
    // DITW17.00.02 AT  24/09/2013 DIT-770 #132
    //                             Added field Free Reason Code
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.03 DDR 21/05/2014 DIT-770 #623 Added non-editable fields "Customer DTax Group Code","Item DTax Group Code",
    //                                           "ARC No. Mandatory"
    // DITW17.10.03 DDR 10/06/2014 DIT-770 #541 Modified 'QuickEntry' property fields "Has Item Charge","Collapse"
    //                                          Removed 'IndentationControls' field1 Group Repeater
    // DITW17.10.03 DDR 11/06/2014 DIT-770 #570 Added menu 'Item Charge &Assignment (DIT)'
    //                                          Added shortcut for menu 'Item Charge Assignment (DIT)'
    // DITW17.10.03 DDR 10/07/2014 DIT-770 #541 Added editable other types than Item
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added field "Responsibity Center"
    // DITW17.10.05 DDR 04/09/2014 DIT-770 #695 Added fields "Allow Price Dit Discount"
    // DITW17.10.05 DDR 08/09/2014 DIT-770 #695 Modified non-editable "Allow Price Dit Discount"
    // DITW17.10.05 WSA 05/11/2014 DIT-770 #185 Added Loyalty Fields
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Unit Price"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract T

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 24/02/2017 NRQ#21530 Bugfix NAV CU1 replaced by CU3
    // FINXL9.00.000.01 ACH 05/01/2016 : Added field 2029616 - "Intrastat Mandatory" (Boolean)
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //   # New fields for MDM integration: WHT Business Posting Group, WHT Product Posting Group, WHT Absorb Base
    // HEI.02 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    //   # New field "RPM Damage / Loss" added
    //   # New field "Transporter RPM Damage / Loss" added
    // HEI.03 FDD-PRDGAP031 IBM PATHAA02 09.11.2017
    // #Code on OnAfterGetRecord
    // FCE- Added the field "Gen Prod. Posting Group"to the lines
    // HEI.04 Defect #745 IBM NASTAA02 11.01.2018 # Prevent User to change discounts
    //   # "Line Amount Excl VAT" and "Line Discount %" should not be changed by the user
    //   # "Line Discount Amount" should not be changed by the user
    // HEI.05 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Field added: "TIN No."
    // DITW113.00.15 DDR 04/10/2019 NRQ#10495 Rename Loyalty 'Cost' -> 'Amount' (all fields)
    // DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackUnitPriceItem()
    // HEI.06 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Field added: "CAD Amount"

    // BC Upgrade SHUKLP03 >> Blocked CAD development.
    // BC Upgrade BHARDA11 --- Unlocked CAD Development


    layout
    {
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the type of entity that will be posted for this sales line, such as Item, Resource, or G/L Account.', FRA = 'Spécifie le type d''entité qui sera validé pour cette ligne vente, tel qu''Article, Ressource, ou Compte général.';
            Enabled = TypeEnable;

            //Unsupported feature: Change Editable on "Type(Control 2)". Please convert manually.

        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of a general ledger account, item, resource, additional cost, or fixed asset, depending on the contents of the Type field.', FRA = 'Spécifie le numéro d''un compte général, d''un article, d''une ressource, d''un coût supplémentaire ou d''une immobilisation, selon ce que vous avez sélectionné dans le champ Type.';
        }
        modify("IC Partner Code")
        {
            ToolTipML = ENU = 'Specifies the IC partner code of the partner to whom you want to distribute the revenue of the sales line.', FRA = 'Spécifie le code du partenaire IC du partenaire auquel vous voulez répartir le produit de la ligne vente.';
        }
        modify("IC Partner Ref. Type")
        {
            ToolTipML = ENU = 'Specifies the item or account in your IC partner''s company that corresponds to the item or account on the line.', FRA = 'Spécifie l''article ou le compte de la société de votre partenaire IC correspondant à l''article ou au compte de la ligne.';
        }
        modify("IC Partner Reference")
        {
            ToolTipML = ENU = 'Specifies the item or account in your IC partner''s company that corresponds to the item or account on the line.', FRA = 'Spécifie l''article ou le compte de la société de votre partenaire IC correspondant à l''article ou au compte de la ligne.';
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
            ToolTipML = ENU = 'Specifies the code for the VAT product posting group of the item, resource, or general ledger account on this line.', FRA = 'Spécifie le code du groupe comptabilisation produit TVA de l''article, de la ressource ou du compte général de la ligne.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry, which is based on the contents of the Type and No. fields.', FRA = 'Spécifie une description de l''entrée qui est basée sur le contenu des champs Type et N°.';

            //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.

        }
        modify("Return Reason Code")
        {
            ToolTipML = ENU = 'Specifies a code that explains why the item is returned.', FRA = 'Spécifie un code expliquant la raison du renvoi de l''article.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the inventory location from which the items sold should be picked and where the inventory decrease is registered.', FRA = 'Spécifie le magasin stock dans lequel les articles vendus devraient être pris et où la baisse de stock doit être enregistrée.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin from where items on the sales order line are taken from when they are shipped.', FRA = 'Spécifie l''emplacement à partir duquel les articles de la ligne commande vente ont été prélevés lorsqu''ils sont expédiés.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies how many units are being sold.', FRA = 'Spécifie le nombre d''unités vendues.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure that is used to determine the value in the Unit Price field on the sales line.', FRA = 'Spécifie l''unité de mesure utilisée pour déterminer la valeur dans le champ Prix unitaire de la ligne vente.';
        }
        modify("Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the unit of measure for the item or resource on the sales line.', FRA = 'Spécifie l''unité de mesure de l''article ou de la ressource sur la ligne vente.';
        }
        modify("Unit Cost (LCY)")
        {
            ToolTipML = ENU = 'Specifies the unit cost of the item on the line.', FRA = 'Spécifie le coût unitaire pour l''article sur la ligne.';
        }
        modify(PriceExists)
        {
            CaptionML = ENU = 'Sales Price Exists', FRA = 'Prix vente existant';
            ToolTipML = ENU = 'Specifies that there is a specific price for this customer.', FRA = 'Spécifie qu''un prix spécifique existe pour ce client.';
        }
        modify("Unit Price")
        {
            ToolTipML = ENU = 'Specifies the price for one unit on the sales line.', FRA = 'Spécifie le prix d''une unité de l''article vente.';
        }

        // BC Upgrade SHUKLP03 >> Added code on trigger OnAfterValidate for fields.
        modify("Line Amount")
        {
            ToolTipML = ENU = 'Specifies the net amount (before subtracting the invoice discount amount) that must be paid for the items on the line.', FRA = 'Spécifie le montant net (avant soustraction du montant remise facture) à payer pour les articles de la ligne.';
            trigger OnAfterValidate()
            var
            begin
                LineAmountOnAfterValidate();
            end;
        }
        modify("Line Discount %")
        {
            ToolTipML = ENU = 'Specifies the line discount percentage that is valid for the item quantity on the line.', FRA = 'Spécifie le pourcentage de remise ligne valable pour la quantité d''articles de la ligne.';
            trigger OnAfterValidate()
            var
            begin
                LineDiscount37OnAfterValidate();
            end;
        }
        modify("Line Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of the discount that will be given on the invoice line.', FRA = 'Spécifie le montant de la remise qui est accordée sur la ligne facture.';
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                LineDiscountAmountOnAfterValid();
            end;
        }
        // BC Upgrade SHUKLP03 << Added code on trigger OnAfterValidate for fields.

        modify(LineDiscExists)
        {
            CaptionML = ENU = 'Sales Line Disc. Exists', FRA = 'Rem. ligne vente existante';
            ToolTipML = ENU = 'Specifies that there is a specific discount for this customer.', FRA = 'Spécifie qu''une remise spécifique existe pour ce client.';
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
            ToolTipML = ENU = 'Specifies the quantity of the item charge that will be assigned to a specified item when you post this sales line.', FRA = 'Spécifie la quantité de frais annexes qui sera affectée à un élément spécifié lors de la validation de cette ligne vente.';
        }
        modify("Qty. Assigned")
        {
            ToolTipML = ENU = 'Specifies the quantity of the item charge that was assigned to a specified item when you posted this sales line.', FRA = 'Spécifie la quantité de frais annexes affectés à un élément spécifié lors de la validation de cette ligne vente.';
        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'Specifies the job number that the sales line is linked to.', FRA = 'Spécifie le numéro de la tâche à laquelle la ligne vente est liée.';
        }
        modify("Job Task No.")
        {
            ToolTipML = ENU = 'Specifies the number of the job task that the sales line is linked to.', FRA = 'Spécifie le numéro de la tâche projet auquel la ligne vente achat est associée.';
        }
        modify("Job Contract Entry No.")
        {
            ToolTipML = ENU = 'Specifies the entry number of the job planning line that the sales line is linked to.', FRA = 'Spécifie le numéro d''écriture de la ligne planning projet à laquelle la ligne vente est liée.';
        }
        modify("Tax Category")
        {
            ToolTipML = ENU = 'Specifies the VAT category in connection with electronic document sending. For example, when you send sales documents through the PEPPOL service, the value in this field is used to populate several fields, such as the ClassifiedTaxCategory element in the Item group. It is also used to populate the TaxCategory element in both the TaxSubtotal and AllowanceCharge group. The number is based on the UNCL5305 standard.', FRA = 'Spécifie la catégorie TVA en relation avec l''envoi de document électronique. Par exemple, lorsque vous envoyez des documents vente via le service PEPPOL, la valeur dans ce champ est utilisée pour remplir plusieurs champs, tels que l''élément ClassifiedTaxCategory du groupe Article. Elle est également utilisée pour remplir l''élément TaxCategory à la fois dans le groupe TaxSubtotal et dans le groupe AllowanceCharge. Le nombre est basé sur la norme UNCL5305.';
        }
        modify("Shipping Agent Code")
        {
            ToolTipML = ENU = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
        }
        modify("Shipping Agent Service Code")
        {
            ToolTipML = ENU = 'Specifies which shipping agent service is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
        }
        modify("Work Type Code")
        {
            ToolTipML = ENU = 'Belongs to the Job application area.', FRA = 'Appartient au domaine d''application Projets.';
        }
        modify("Blanket Order No.")
        {
            ToolTipML = ENU = 'Specifies the document number of the blanket order from which this sales line originates.', FRA = 'Spécifie le numéro de document de la commande ouverte qui est à l''origine de cette ligne vente.';
        }
        modify("Blanket Order Line No.")
        {
            ToolTipML = ENU = 'Specifies the line number of the blanket order line from which this sales line originates.', FRA = 'Spécifie le numéro de ligne de la ligne de la commande ouverte qui est à l''origine de cette ligne vente.';
        }
        modify("FA Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date that will be used as the FA posting date on FA ledger entries.', FRA = 'Spécifie la date qui sera utilisée comme date comptabilisation immobilisation sur les écritures comptables immobilisation.';
        }
        modify("Depr. until FA Posting Date")
        {
            ToolTipML = ENU = 'You can use this field if you have selected Fixed Asset in the Type field for this line.', FRA = 'Vous pouvez utiliser ce champ si vous avez sélectionné Immobilisation dans le champ Type de cette ligne.';
        }
        modify("Depreciation Book Code")
        {
            ToolTipML = ENU = 'Specifies the code for the depreciation book to which the line will be posted if you have selected Fixed Asset in the Type field for this line.', FRA = 'Spécifie le code des lois d''amortissement sur lesquelles la ligne sera validée, si vous avez sélectionné Immobilisation dans le champ Type de cette ligne.';
        }
        modify("Use Duplication List")
        {
            ToolTipML = ENU = 'You can use this field if you have selected Fixed Asset in the Type field for this line.', FRA = 'Vous pouvez utiliser ce champ si vous avez sélectionné Immobilisation dans le champ Type de cette ligne.';
        }
        modify("Duplicate in Depreciation Book")
        {
            ToolTipML = ENU = 'You can use this field if you have selected Fixed Asset in the Type field for this line.', FRA = 'Vous pouvez utiliser ce champ si vous avez sélectionné Immobilisation dans le champ Type de cette ligne.';
        }
        modify("Appl.-from Item Entry")
        {
            ToolTipML = ENU = 'Specifies the number of the item ledger entry that the sales credit memo line is applied from.', FRA = 'Spécifie le numéro de l''écriture comptable article à partir de laquelle la ligne avoir vente est lettrée.';
        }
        modify("Appl.-to Item Entry")
        {
            ToolTipML = ENU = 'Specifies the item ledger entry number the line should be applied to.', FRA = 'Spécifie le numéro de l''écriture comptable article avec laquelle la ligne doit être lettrée.';
        }
        modify("Deferral Code")
        {
            ToolTipML = ENU = 'Specifies the deferral template that governs how revenue earned with this sales document is deferred to the different accounting periods when the good or service was delivered.', FRA = 'Spécifie le modèle d''échelonnement qui régit la manière dont les revenus réalisés à l''aide de ce document vente sont reportés sur les différentes périodes de comptabilité lorsque le bien ou le service est livré.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number.', FRA = 'Spécifie le numéro du document.';
        }
        modify("Line No.")
        {
            ToolTipML = ENU = 'Specifies the line number.', FRA = 'Spécifie le numéro de ligne.';
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
        }
        modify("Invoice Disc. Pct.")
        {
            CaptionML = ENU = 'Invoice Discount %', FRA = '% remise facture';
            ToolTipML = ENU = 'Specifies a discount percentage that is granted if criteria that you have set up for the customer are met.', FRA = 'Indique un pourcentage de remise qui est accordé si les critères que vous avez paramétrés pour le client sont réunis.';
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
        // BC Upgrade BHARDA11 >>
        addafter("Unit of Measure")
        {
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                Visible = EnableCAD;
                ApplicationArea = All;
            }
        }
        // BC Upgrade BHARAD11 <<
        // BC Upgrade SHUKLP03 >> Blocked DIT fields.
        // addfirst(Control1)
        // {
        //     field("Has Item Charge"; "Has Item Charge")
        //     {
        //         BlankZero = true;
        //         QuickEntry = false;
        //         ApplicationArea = All;
        //     }
        //     field(Collapse; Collapse)
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW15.00.00.37 DDR 19/01/2010
        //             CurrPage.UPDATE(true);
        //             // >>DITW15.00.00.37 DDR
        //         end;
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
        // }
        // addafter(Description)
        // {
        //     field("Description 2"; "Description 2")
        //     {
        //         Description = 'DIT-715 #393';
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        // }
        // addafter("Return Reason Code")
        // {
        //     field("Responsibility Center"; "Responsibility Center")
        //     {
        //         Visible = false;
        //         ApplicationArea = All;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        //             if "Responsibility Center" <> xRec."Responsibility Center" then
        //                 CurrPage.UPDATE(true);
        //             // >>DITW18.00.06 DDR DIT-770 #1190
        //         end;
        //     }
        //     field("Physical Location Group Code"; "Physical Location Group Code")
        //     {
        //         Visible = false;
        //         ApplicationArea = All;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        //             if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
        //                 CurrPage.UPDATE(true);
        //             // >>DITW18.00.06 DDR DIT-770 #1190
        //         end;
        //     }
        // }
        // addafter("Unit of Measure")
        // {
        //     field("CAD Amount"; Rec."CAD Amount")  
        //     {
        //         Visible = EnableCAD;
        //         ApplicationArea = All;
        //     }

        //     // BC Upgrade SHUKLP03 >> Blocked DIT fields.
        //     // field("Tariff No. XL"; Rec."Tariff No. XL")
        //     // {
        //     //     Description = 'FINXL7.00.001';
        //     //     Visible = false;
        //     //     ApplicationArea = All;
        //     // }
        //     // field("Net Weight"; Rec."Net Weight")
        //     // {
        //     //     Description = 'FINXL7.00.001';
        //     //     Visible = false;
        //     //     ApplicationArea = All;
        //     // }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT fields.


        // BC Upgrade SHUKLP03 >> Blocked DIT fields.
        // addafter("Line Amount")
        // {
        //     field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Unit Price"), true))
        //     {
        //         AutoFormatExpression = "Currency Code";
        //         AutoFormatType = 2;
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassVar(PageText2014411);
        //         CaptionML = ENU = 'Total Unit Price',
        //                     FRA = 'Total prix unitaire';
        //         Description = 'DITW17.10.05 DIT-770 #988';
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), true))
        //     {
        //         AutoFormatExpression = "Currency Code";
        //         AutoFormatType = 1;
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassVar(PageText2014410);
        //         CaptionML = ENU = 'Total Line Amount',
        //                     FRA = 'Montant total ligne';
        //         Description = 'DITW17.10.02B DIT-770 #541';
        //         Editable = false;
        //         QuickEntry = false;
        //         ApplicationArea = All;
        //     }
        // }
        // addafter("Appl.-to Item Entry")
        // {
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
        //     field("AAD No. Series"; "AAD No. Series")
        //     {
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("LRN No. Series"; "LRN No. Series")
        //     {
        //         Description = 'DITW15.00.00.38 #1217';
        //         Editable = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("SAD No."; "SAD No.")
        //     {
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
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Tariff No."; "Tariff No.")
        //     {
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Free Reason Code"; "Free Reason Code")
        //     {
        //         Description = 'DITW17.00.02 DIT-770 #132';
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Free Item"; "Free Item")
        //     {
        //         ApplicationArea = All;

        //         trigger OnValidate();
        //         begin
        //             FreeItemOnAfterValidate;
        //         end;
        //     }
        //     field("Allow VAT Calculation (Free)"; "Allow VAT Calculation (Free)")
        //     {
        //         Description = 'DITW16.00.00.40 DIT-715 #172';
        //         Visible = false;
        //         ApplicationArea = All;

        //         trigger OnValidate();
        //         begin
        //             AllowVATCalculationFreeOnAfter;
        //         end;
        //     }
        //     field("Free Item Posting Type"; "Free Item Posting Type")
        //     {
        //         Visible = false;
        //         ApplicationArea = All;

        //         trigger OnValidate();
        //         begin
        //             FreeItemPostingTypeOnAfterVali;
        //         end;
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
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("DIT Sub-Contract Type"; "DIT Sub-Contract Type")
        //     {
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Service Contract No."; "Service Contract No.")
        //     {
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Financial Contract No."; "Financial Contract No.")
        //     {
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Contract Group Code"; "Contract Group Code")
        //     {
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Auto. Acc. Group"; "Auto. Acc. Group")
        //     {
        //         Description = 'FINXL7.00.001';
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        // }
        // addafter("ShortcutDimCode[8]")
        // {
        //     field("Allow Loyalty"; "Allow Loyalty")
        //     {
        //         Description = 'DITW17.10.05 DIT770 #185';
        //         ApplicationArea = All;
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
        //         QuickEntry = false;
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Loyalty Points Qty. (Base)"; "Loyalty Points Qty. (Base)")
        //     {
        //         Description = 'DIT715 #243';
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
        //     field("Loyalty Unit Amount (LCY)"; "Loyalty Unit Amount (LCY)")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Loyalty Unit Amount"; "Loyalty Unit Amount")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Loyalty Amount"; "Loyalty Amount")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Loyalty Amount (LCY)"; "Loyalty Amount (LCY)")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        //     field("Loyalty Convert to Free Item"; "Loyalty Convert to Free Item")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Visible = false;
        //         ApplicationArea = All;
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT fields.
        addafter("Line No.")
        {
            // BC Upgrade SHUKLP03 >> Blocked DIT field.
            // field("Intrastat Mandatory"; Rec."Intrastat Mandatory")
            // {
            //     Description = 'FINXL9.00.000.01';
            //     ApplicationArea = All;
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT field.

            // BC Upgrade SHUKLP03 >>
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
            field("Forecasted Shipment Date"; Rec."Forecasted Shipment Date FND")
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
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT field.

            field("8"; Rec."TIN No. FND") // BC Upgrade SHUKLP03 << Added TIN No. field.
            {
                ApplicationArea = All;
            }
            // BC Upgrade SHUKLP03 << 
        }
        moveafter("Transporter RPM Damage / Loss"; "Gen. Prod. Posting Group")
        // BC Upgrade SHUKLP03 >> Blocked CAD development.
        // BC Upgrade BHARDA11 >> UnBlocked CAD Development
        addafter("Total VAT Amount")
        {
            field(TotalCADAmount; TotalSalesLine."CAD Amount FND")
            {
                AutoFormatExpression = Currency.Code;
                // CaptionClass = DocumentTotals.GetTotalCADCaption(Currency.Code);  // BC Upgrade SHUKLP03 << code is moved to HeinekenBCCustomFunctions.
                CaptionClass = HeinekenBCCustomFunctions.GetTotalCADCaption(Currency.Code); // BC Upgrade SHUKLP03 << 
                Caption = 'Total CAD Amount';
                Editable = false;
                Visible = EnableCAD;
                ApplicationArea = All;
            }
        }
        // BC Upgrade BHARDA11 << UnBlocked CAD Development
        // BC Upgrade SHUKLP03 << Blocked CAD development.
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
        modify("E&xplode BOM")
        {
            CaptionML = ENU = 'E&xplode BOM', FRA = '&Eclater nomenclature';
        }
        modify(InsertExtTexts)
        {
            CaptionML = ENU = 'Insert &Ext. Texts', FRA = 'Insérer te&xtes étendus';
            ToolTipML = ENU = 'Insert the extended item description that is set up for the item on the sales document line.', FRA = 'Insérez la description plus longue qui est paramétrée pour l''article sur la ligne document vente.';
        }
        modify(GetShipmentLines)
        {
            CaptionML = ENU = 'Get &Shipment Lines', FRA = 'Extraire lignes expé&dition';
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
        modify("Related Information")
        {
            CaptionML = ENU = 'Related Information', FRA = 'Informations connexes';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify("Item Charge &Assignment")
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
            ToolTipML = ENU = 'View or edit the deferral schedule that governs how revenue made with this sales document is deferred to different accounting periods when the document is posted.', FRA = 'Affichez ou modifiez le tableau d''échelonnement qui régit la manière dont les revenus réalisés à l''aide de ce document vente sont reportés sur différentes périodes de comptabilité lorsque le document est validé.';
        }

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
        // addafter(InsertExtTexts)
        // {
        //     action("Insert Item Char&ges")
        //     {
        //         CaptionML = ENU = 'Insert Item Char&ges',
        //                     FRA = 'Insérer frais annexe';
        //         ShortCutKey = 'Ctrl+Y';

        //         trigger OnAction();
        //         begin
        //             //This functionality was copied from page #43. Unsupported part was commented. Please check it.
        //             /*CurrPage.SalesLines.PAGE.*/
        //             _InsertExtendedCharges(true);

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
        // addafter("Item &Tracking Lines")
        // {
        //     action("SSCC Tracking Lines")
        //     {
        //         CaptionML = ENU = 'SSCC Tracking Lines',
        //                     FRA = 'Lignes Traçabilité SSCC';
        //         Image = ItemTrackingLines;

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.38 DDR 19/11/2010 #1139
        //             //This functionality was copied from page #43. Unsupported part was commented. Please check it.
        //             /*CurrPage.SalesLines.PAGE.*/
        //             _OpenSSCCTrackingLines();

        //         end;
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT action.
    }

    var
        TempRec: Record "Sales Line" temporary;

        GeneralLedgerSetup: Record "General Ledger Setup";
        HeinekenBCCustomFunctions: Codeunit "Heineken BC Custom Functions";


    //Unsupported feature: PropertyModification on "Text000(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Unable to run this function while in View mode.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Unable to run this function while in View mode.;FRA=Impossible d'exécuter cette fonction en mode Afficher.;
    //Variable type has not been exported.

    var
        xRecRef: RecordRef;
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Unit Price', FRA = 'Total prix unitaire';
        DisabledRefreshLines: Boolean;
        TypeEditable: Boolean;
        "No.Editable": Boolean;
        "Cross-Reference No.Editable": Boolean;
        QuantityEditable: Boolean;
        "Unit PriceEditable": Boolean;
        "Line AmountEditable": Boolean;
        TypeEnable: Boolean;
        "No.Enable": Boolean;
        QuantityEnable: Boolean;
        "Unit PriceEnable": Boolean;
        "Line AmountEnable": Boolean;
        ExpandLines: Boolean;
        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        UserMgt: Codeunit "User Setup Management";
        txtIntrastatMandStyle: Text;
        EditableDesc: Boolean;
        Error004: Label 'You cannot change the %1 when the value has been filled in.';
        EnableCAD: Boolean; // BC Upgrade SHUKLP03 << blocked CAD development. // BC Upgrade BHARAD11 ::Unblocked


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    trigger OnAfterGetRecord();
    begin
        // BC Upgrade SHUKLP03 >> 
        //HEI.03 PATHAA02 07.11.2017>>
        if Rec.Type <> Rec.Type::Item then
            EditableDesc := true
        else
            EditableDesc := false;
        //PATHAA02 07.11.2017<<
        // BC Upgrade SHUKLP03 <<
    end;

    // BC Upgrade SHUKLP03 >> Blocked CAD development.
    // BC Upgrade BHARAD11 >> Unblocked CAD Development
    trigger OnOpenPage();
    begin
        //HEI.06>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.06<<
    end;
    // BC Upgrade BHARAD11 << Unblocked CAD Development
    // BC Upgrade SHUKLP03 << Blocked CAD development.


    // BC Upgrade SHUKLP03 >> Blocked DIT procedures.
    // procedure _InsertExtendedCharges(FromHeader: Boolean);
    // begin
    //     // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
    //     if InsertChargeLines(FromHeader) then
    //         UpdatePage(true);
    //     // >>DITW15.00.00.23 DDR
    // end;

    // procedure InsertExtendedCharges(FromHeader: Boolean);
    // begin
    //     // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
    //     if InsertChargeLines(FromHeader) then
    //         UpdatePage(true);
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
    //     "Unit PriceEditable" := FormEditableField(FIELDNO("Unit Price")) and not CollapsedLine;
    //     "Line AmountEditable" := FormEditableField(FIELDNO("Line Amount")) and not CollapsedLine;

    //     // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    //     TypeEnable := FormEditableField(FIELDNO(Type));
    //     "No.Enable" := FormEditableField(FIELDNO("No."));
    //     QuantityEnable := FormEditableField(FIELDNO(Quantity));
    //     "Unit PriceEnable" := FormEditableField(FIELDNO("Unit Price"));
    //     "Line AmountEnable" := FormEditableField(FIELDNO("Line Amount"));
    //     // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
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

    // procedure TriggerOnDeleteRecord(): Boolean;
    // var
    //     ReserveSalesLine: Codeunit "Sales Line-Reserve";
    //     TempRec: Record "Sales Line" temporary;
    // begin
    //     if (Quantity <> 0) and ItemExists("No.") then begin
    //         COMMIT;
    //         if not ReserveSalesLine.DeleteLineConfirm(Rec) then
    //             exit(false);
    //         ReserveSalesLine.DeleteLine(Rec);
    //     end;

    //     // <<DITW15.00.00.36 DDR 23/11/2009
    //     if "Is Item Charge" and "ItemCharge Incl. Price" then begin
    //         DELETE(true);
    //         TempRec := Rec;
    //         TempRec."Unit Price" := 0;
    //         TempRec."Line Amount" := 0;
    //         TempRec."Line Discount Amount" := 0;
    //         // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
    //         TempRec.CalcBackUnitPriceItem();
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

    // local procedure UnitPriceOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Unit Price" <> xRec."Unit Price")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;
    // BC Upgrade SHUKLP03 << Blocked DIT procedures.
    local procedure LineAmountOnAfterValidate();
    begin
        // BC Upgrade SHUKLP03 >>
        //HEI.04>>
        if (Rec.Type = Rec.Type::Item) or (Rec.Type = Rec.Type::"Charge (Item)") then
            if (Rec."Line Amount" <> 0) and (Rec."Line Amount" <> xRec."Line Amount") then
                ERROR(Error004, Rec.FIELDCAPTION("Line Amount"));
        //HEI.04<<
        // BC Upgrade SHUKLP03 <<

        // BC Upgrade SHUKLP03 >> Blocked DIT validation.
        // // <<DITW15.00.00.01 DDR 21/12/2007
        // if (Type = Type::Item) and
        //    ("Line Amount" <> xRec."Line Amount")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << Blocked DIT validation.

    end;

    local procedure LineDiscount37OnAfterValidate();
    begin
        // BC Upgrade SHUKLP03 >>
        //HEI.04>>
        if (Rec.Type = Rec.Type::Item) or (Rec.Type = Rec.Type::"Charge (Item)") then
            if (Rec."Line Discount %" <> 0) and (Rec."Line Discount %" <> xRec."Line Discount %") then
                ERROR(Error004, Rec.FIELDCAPTION("Line Discount %"));
        //HEI.04<<
        // BC Upgrade SHUKLP03 >>

        // BC Upgrade SHUKLP03 >> Blocked DIT validation.
        // // <<DITW15.00.00.01 DDR 21/12/2007
        // if (Type = Type::Item) and
        //    ("Line Discount %" <> xRec."Line Discount %")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << Blocked DIT validation.

    end;

    local procedure LineDiscountAmountOnAfterValid();
    begin
        // BC Upgrade SHUKLP03 >>
        //HEI.07>>
        if (Rec.Type = Rec.Type::Item) or (Rec.Type = Rec.Type::"Charge (Item)") then
            if (Rec."Line Discount Amount" <> 0) and (Rec."Line Discount Amount" <> xRec."Line Discount Amount") then
                ERROR(Error004, Rec.FIELDCAPTION("Line Discount Amount"));
        //HEI.07<<
        // BC Upgrade SHUKLP03 <<

        // BC Upgrade SHUKLP03 >> Blocked DIT validation.
        // // <<DITW15.00.00.01 DDR 21/12/2007
        // if (Type = Type::Item) and
        //    ("Line Discount Amount" <> xRec."Line Discount Amount")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << Blocked DIT validation.
    end;

    // BC Upgrade SHUKLP03 >> Blocked DIT procedures.
    // local procedure FreeItemOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.35 DDR 25/06/2009
    //     if (Type = Type::Item) and
    //        (xRec."Free Item" <> "Free Item")
    //     then
    //         CurrPage.UPDATE(true);
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
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.35 DDR
    // end;

    // procedure ItemChargeAssgntDIT();
    // var
    //     SelectedRec: Record "Sales Line";
    // begin
    //     // <<DITW17.10.03 DDR 22/04/2014 DIT-770 #570
    //     CurrPage.SAVERECORD;
    //     COMMIT;
    //     CurrPage.SETSELECTIONFILTER(SelectedRec);
    //     GetNewItemChargeAssgnDIT(SelectedRec);
    //     CurrPage.UPDATE(false);
    // end;

    // local procedure fctUpdateStyle();
    // begin
    //     //<<FINXL9.00.000.01 ACH 05/01/2016
    //     if "Intrastat Mandatory" then
    //         txtIntrastatMandStyle := 'Unfavorable'
    //     else
    //         txtIntrastatMandStyle := 'Standard';
    //     //>>FINXL9.00.000.01 ACH 05/01/2016
    // end;
    // BC Upgrade SHUKLP03 << Blocked DIT procedures.

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

