pageextension 51206 SalesCrMemoSubformExtCBN extends "Sales Cr. Memo Subform"
{
    // version NAVW110.0,FINXL9.00,DITW110.00.08,HEI.03

    // DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
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
    //                     21/08/2009 issue 727 Added HorzAlign property in field "Unit Price,"Line Amount"
    //                 DDR 14/10/2009 issue 893 Removed fields "Gen. Prod. Posting Free Group"
    // DITW15.00.00.36 DDR 04/11/2009 issue 939 Performance SQL
    //                                          Added function FormTotalingField()
    // DITW15.00.00.37 DDR 11/05/2010 issue 1061 Added field "Physical Location Group Code"
    //                     01/06/2010 issue 959 Added field "AAD No."
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

    // FINXL7.00.001 RBE 20/03/2013: Added fields "Tariff No." & "Net Weight" (not visible)
    //                               Added field: "Auto. Acc. Group"

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
    // DITW17.10.05 WSA 05/11/2014 DIT-770 #185 : Added Loaylty Fields
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Unit Price"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    //   # New field "RPM Damage / Loss" added
    //   # New field "Transporter RPM Damage / Loss" added
    // HEI.02 FDD-PRDGAP031 IBM PATHAA02 09.11.2017
    // #Code on OnAfterGetRecord
    // HEI.03 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Field added: "TIN No."
    // DITW113.00.15 DDR 04/10/2019 NRQ#10495 Rename Loyalty 'Cost' -> 'Amount' (all fields)
    // DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackUnitPriceItem()
    // HEI.04 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Field added: "CAD Amount"

    //Bc Upgrade YADAVM09 "Cross-Reference No." field Added.
    //Bc Upgrade YADAVM09 Drink it field and code commented.
    //Bc Upgrade YADAVM09 editable property added for field type.
    //Bc Upgrade YADAVM09 Description field property changes added.
    //BC UPGRADE KUMARR78 FDD-MTC-008 >>
    //1. Adding Show Item charge on Invoice Field
    //BC UPGRADE KUMARR78 FDD-MTC-008 <<
    layout
    {
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the type of entity that will be posted for this sales line, such as Item, Resource, or G/L Account.', FRA = 'Spécifie le type d''entité qui sera validé pour cette ligne vente, tel qu''Article, Ressource, ou Compte général.';
            Enabled = TypeEnable;
            ApplicationArea = all;
            Editable = TypeEditable;//Bc Upgrade YADAVM09
            //Unsupported feature: Change Editable on "Type(Control 2)". Please convert manually.
        }
        modify("No.")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the number of a general ledger account, item, resource, additional cost, or fixed asset, depending on the contents of the Type field.', FRA = 'Spécifie le numéro d''un compte général, d''un article, d''une ressource, d''un coût supplémentaire ou d''une immobilisation, selon ce que vous avez sélectionné dans le champ Type.';
        }
        /* //Bc Upgrade YADAVM09 Field not defined in Base App>>
        modify("Cross-Reference No.")
        {
            ToolTipML = ENU = 'Specifies the cross-referenced item number. If you enter a cross reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the cross-reference number on a sales or purchase document.', FRA = 'Spécifie le numéro d''article à référence externe. Si vous saisissez une référence externe entre votre numéro d''article et celui de votre fournisseur ou client, ce numéro remplace le numéro d''article standard lorsque vous saisissez le numéro de référence externe sur un document vente ou achat.';
            //Unsupported feature: Change Editable on ""Cross-Reference No."(Control 34)". Please convert manually.
        }
        */ //Bc Upgrade YADAVM09 Field not defined in Base App<<
        modify("IC Partner Code")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the IC partner code of the partner to whom you want to distribute the revenue of the sales line.', FRA = 'Spécifie le code du partenaire IC du partenaire auquel vous voulez répartir le produit de la ligne vente.';
        }
        modify("IC Partner Ref. Type")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the item or account in your IC partner''s company that corresponds to the item or account on the line.', FRA = 'Spécifie l''article ou le compte de la société de votre partenaire IC correspondant à l''article ou au compte de la ligne.';
        }
        modify("IC Partner Reference")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the item or account in your IC partner''s company that corresponds to the item or account on the line.', FRA = 'Spécifie l''article ou le compte de la société de votre partenaire IC correspondant à l''article ou au compte de la ligne.';
        }
        modify("Variant Code")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies a variant code for the item.', FRA = 'Spécifie un code variante pour l''article.';
        }
        modify(Nonstock)
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies that this item is a nonstock item.', FRA = 'Spécifie que cet article est non stocké.';
        }
        modify("VAT Prod. Posting Group")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the code for the VAT product posting group of the item, resource, or general ledger account on this line.', FRA = 'Spécifie le code du groupe comptabilisation produit TVA de l''article, de la ressource ou du compte général de la ligne.';
        }
        modify(Description)
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies a description of the entry, which is based on the contents of the Type and No. fields.', FRA = 'Spécifie une description de l''entrée qui est basée sur le contenu des champs Type et N°.';
            //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.
        }
        modify("Return Reason Code")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies a code that explains why the item is returned.', FRA = 'Spécifie un code expliquant la raison du renvoi de l''article.';

            // BC Upgrade SHUKLP03 >> Modified the OnLookup trigger of "Return Reason Code" field to filter out blocked return reasons in the lookup page, because we cannot modify base TableRelation
            trigger OnLookup(var Text: Text): Boolean
            var
                ReturnReason: Record "Return Reason";
                ReturnReasonList: Page "Return Reasons"; // adjust to actual lookup page
            begin
                ReturnReason.SetRange("Blocked FND", false);
                ReturnReasonList.SetTableView(ReturnReason);
                ReturnReasonList.LookupMode(true);
                if ReturnReasonList.RunModal() = Action::LookupOK then begin
                    ReturnReasonList.GetRecord(ReturnReason);
                    Text := ReturnReason.Code;
                    exit(true);
                end;
                exit(false);
            end;
            // BC Upgrade SHUKLP03 << Modified the OnLookup trigger of "Return Reason Code" field to filter out blocked return reasons in the lookup page, because we cannot modify base TableRelation.

        }
        modify("Location Code")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the inventory location from which the items sold should be picked and where the inventory decrease is registered.', FRA = 'Spécifie le magasin stock dans lequel les articles vendus devraient être pris et où la baisse de stock doit être enregistrée.';
        }
        modify("Bin Code")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the bin from where items on the sales order line are taken from when they are shipped.', FRA = 'Spécifie l''emplacement à partir duquel les articles de la ligne commande vente ont été prélevés lorsqu''ils sont expédiés.';
        }
        modify(Reserve)
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies whether a reservation can be made for items on this line.', FRA = 'Spécifie s''il est possible de réserver des articles sur cette ligne.';
        }
        modify(Quantity)
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies how many units are being sold.', FRA = 'Spécifie le nombre d''unités vendues.';
        }
        modify("Reserved Quantity")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies how many units of the item on the line have been reserved.', FRA = 'Spécifie le nombre d''unités de la ligne qui ont été réservées.';
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the unit of measure that is used to determine the value in the Unit Price field on the sales line.', FRA = 'Spécifie l''unité de mesure utilisée pour déterminer la valeur dans le champ Prix unitaire de la ligne vente.';
        }
        modify("Unit of Measure")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the unit of measure for the item or resource on the sales line.', FRA = 'Spécifie l''unité de mesure de l''article ou de la ressource sur la ligne vente.';
        }
        modify("Unit Cost (LCY)")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the unit cost of the item on the line.', FRA = 'Spécifie le coût unitaire pour l''article sur la ligne.';
        }
        modify("Unit Price")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the price for one unit on the sales line.', FRA = 'Spécifie le prix d''une unité de l''article vente.';
        }
        modify("Line Amount")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the net amount (before subtracting the invoice discount amount) that must be paid for the items on the line.', FRA = 'Spécifie le montant net (avant soustraction du montant remise facture) à payer pour les articles de la ligne.';
        }
        modify("Line Discount %")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the line discount percentage that is valid for the item quantity on the line.', FRA = 'Spécifie le pourcentage de remise ligne valable pour la quantité d''articles de la ligne.';
        }
        modify("Line Discount Amount")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the amount of the discount that will be given on the invoice line.', FRA = 'Spécifie le montant de la remise qui est accordée sur la ligne facture.';
        }
        modify("Allow Invoice Disc.")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies whether the invoice line is included when the invoice discount is calculated.', FRA = 'Spécifie si la ligne facture est incluse lors du calcul de la remise facture.';
        }
        modify("Inv. Discount Amount")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the invoice discount amount for the line.', FRA = 'Spécifie le montant de la remise facture pour la ligne.';
        }
        modify("Allow Item Charge Assignment")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies that you can assign item charges to this line.', FRA = 'Spécifie que vous pouvez affecter des frais annexes à cette ligne.';
        }
        modify("Qty. to Assign")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the quantity of the item charge that will be assigned to a specified item when you post this sales line.', FRA = 'Spécifie la quantité de frais annexes qui sera affectée à un élément spécifié lors de la validation de cette ligne vente.';
        }
        modify("Qty. Assigned")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the quantity of the item charge that was assigned to a specified item when you posted this sales line.', FRA = 'Spécifie la quantité de frais annexes affectés à un élément spécifié lors de la validation de cette ligne vente.';
        }
        modify("Job No.")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the job number that the sales line is linked to.', FRA = 'Spécifie le numéro de la tâche à laquelle la ligne vente est liée.';
        }
        modify("Job Task No.")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the number of the job task that the sales line is linked to.', FRA = 'Spécifie le numéro de la tâche projet auquel la ligne vente achat est associée.';
        }
        modify("Tax Category")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the VAT category in connection with electronic document sending. For example, when you send sales documents through the PEPPOL service, the value in this field is used to populate several fields, such as the ClassifiedTaxCategory element in the Item group. It is also used to populate the TaxCategory element in both the TaxSubtotal and AllowanceCharge group. The number is based on the UNCL5305 standard.', FRA = 'Spécifie la catégorie TVA en relation avec l''envoi de document électronique. Par exemple, lorsque vous envoyez des documents vente via le service PEPPOL, la valeur dans ce champ est utilisée pour remplir plusieurs champs, tels que l''élément ClassifiedTaxCategory du groupe Article. Elle est également utilisée pour remplir l''élément TaxCategory à la fois dans le groupe TaxSubtotal et dans le groupe AllowanceCharge. Le nombre est basé sur la norme UNCL5305.';
        }
        modify("Work Type Code")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Belongs to the Job application area.', FRA = 'Appartient au domaine d''application Projets.';
        }
        modify("Blanket Order No.")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the document number of the blanket order from which this sales line originates.', FRA = 'Spécifie le numéro de document de la commande ouverte qui est à l''origine de cette ligne vente.';
        }
        modify("Blanket Order Line No.")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the line number of the blanket order line from which this sales line originates.', FRA = 'Spécifie le numéro de ligne de la ligne de la commande ouverte qui est à l''origine de cette ligne vente.';
        }
        modify("Appl.-from Item Entry")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the number of the item ledger entry that the sales credit memo line is applied from.', FRA = 'Spécifie le numéro de l''écriture comptable article à partir de laquelle la ligne avoir vente est lettrée.';
        }
        modify("Appl.-to Item Entry")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the item ledger entry number the line should be applied to.', FRA = 'Spécifie le numéro de l''écriture comptable article avec laquelle la ligne doit être lettrée.';
        }
        modify("Deferral Code")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the deferral template that governs how revenue earned with this sales document is deferred to the different accounting periods when the good or service was delivered.', FRA = 'Spécifie le modèle d''échelonnement qui régit la manière dont les revenus réalisés à l''aide de ce document vente sont reportés sur les différentes périodes de comptabilité lorsque le bien ou le service est livré.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        modify("Invoice Discount Amount")
        {
            ApplicationArea = all;
            CaptionML = ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
            ToolTipML = ENU = 'Specifies a discount amount that is deducted from the value in the Total Incl. VAT field. You can enter or change the amount manually.', FRA = 'Spécifie un montant de remise qui est déduit de la valeur dans le champ Total TTC. Vous pouvez saisir ou modifier le montant manuellement.';
        }
        modify("Invoice Disc. Pct.")
        {
            ApplicationArea = all;
            CaptionML = ENU = 'Invoice Discount %', FRA = '% remise facture';
            ToolTipML = ENU = 'Specifies a discount percentage that is granted if criteria that you have set up for the customer are met.', FRA = 'Indique un pourcentage de remise qui est accordé si les critères que vous avez paramétrés pour le client sont réunis.';
        }
        modify("Total Amount Excl. VAT")
        {
            ApplicationArea = all;
            CaptionML = ENU = 'Total Amount Excl. VAT', FRA = 'Montant total HT';
            ToolTipML = ENU = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.', FRA = 'Spécifie la somme de la valeur du champ Montant ligne HT sur toutes les lignes du document, moins l''éventuel montant remise indiqué dans le champ Montant remise facture.';
        }
        modify("Total VAT Amount")
        {
            ApplicationArea = all;
            CaptionML = ENU = 'Total VAT', FRA = 'Total TVA';
            ToolTipML = ENU = 'Specifies the sum of VAT amounts on all lines in the document.', FRA = 'Spécifie la somme des montants de TVA sur toutes les lignes du document.';
        }
        modify("Total Amount Incl. VAT")
        {
            ApplicationArea = all;
            CaptionML = ENU = 'Total Amount Incl. VAT', FRA = 'Montant total TTC';
            ToolTipML = ENU = 'Specifies the sum of the value in the Line Amount Incl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.', FRA = 'Spécifie la somme de la valeur du champ Montant TTC sur toutes les lignes du document, moins l''éventuel montant remise indiqué dans le champ Montant remise facture.';
        }
        //Bc Upgrade YADAVM09>>
        modify("Description 2")
        {
            Visible = false;
        }

        //Bc Upgrade YADAVM09>>

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
        UpdateEditableOnRow;
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


        //Unsupported feature: CodeModification on ""Cross-Reference No."(Control 34).OnLookup". Please convert manually.

        //trigger "(Control 34)();
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


        //Unsupported feature: CodeInsertion on ""Variant Code"(Control 18)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        VariantCodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Control 72)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        LocationCodeOnAfterValidate;
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        if xRec."Location Code" <> "Location Code" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 DDR DIT-770 #1190
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit Price"(Control 12).OnValidate". Please convert manually.

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
        UnitPriceOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Amount"(Control 92).OnValidate". Please convert manually.

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


        //Unsupported feature: CodeModification on ""Line Discount Amount"(Control 56).OnValidate". Please convert manually.

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


        addfirst(Control1)
        {
            /* //Bc Upgrade YADAVM09 Drink it field commented>>
           field("Has Item Charge";Rec."Has Item Charge")
           {
               BlankZero = true;
               QuickEntry = false;
           }
           field(Collapse;Rec.Collapse)
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
       */ //Bc Upgrade YADAVM09 Drink it field commented<<
            field("Line No."; Rec."Line No.")
            {
                Editable = false;
                QuickEntry = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the line number.';
                //Bc Upgrade YADAVM09                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ToolTip = 'Specifies the value of the Line No. field.';

            }
            //Bc Upgrade YADAVM09 Field Added>>
            field("Cross-Reference No.Editable"; "Cross-Reference No.Editable")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cross-Reference No.Editable field.';
            }
            //Bc Upgrade YADAVM09 Field Added<<
        }
        /* //Bc Upgrade YADAVM09 Dependency on Drink field>> 
       addafter("VAT Prod. Posting Group")
       {
           field("GetTrackingItemNo()"; GetTrackingItemNo())
           {
               CaptionML = ENU = 'Tracking Item No. (Item Charge)',
                           FRA = 'N° article traçable (Frais annexes)';
               DrillDownPageID = "Item List";
               Editable = false;
               LookupPageID = "Item List";
               TableRelation = IF ("Item Charge Type" = CONST(Tax)) Item WHERE("No." = FIELD("Tax Item No."))
               ELSE IF ("Item Charge Type" = CONST(Deposit)) Item WHERE("No." = FIELD("Empty Goods Item No."));
               Visible = false;

               trigger OnLookup(Text: Text): Boolean;
               begin
                   // <<DITW15.00.00.38 DDR 17/12/2010 #703
                   Text := GetTrackingItemNo();
                   LookupItemNo(Text);
                   exit(false);
               end;
           }
       }
        */ //Bc Upgrade YADAVM09 Dependency on Drink field<<

        /* Bc Upgrade YADAVM09 Field already added in base field>>
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                Description = 'DIT-715 #393';
                Visible = false;
            }
        }
        */ //Bc Upgrade YADAVM09 Field already added in base field<<
        addafter("Return Reason Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Responsibility Center field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the Responsibility Center field.';


                /* //Bc Upgrade YADAVM09 Drink it code commented>>
                               trigger OnValidate();
                               begin
                                   // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
                                   if Rec."Responsibility Center" <> xRec."Responsibility Center" then
                                       CurrPage.UPDATE(true);
                                   // >>DITW18.00.06 DDR DIT-770 #1190
                               end;
             */ //Bc Upgrade YADAVM09 Drink it Code commented<<
            }
            /* //Bc Upgrade YADAVM09 Drink it field commented>>
           field("Physical Location Group Code"; "Physical Location Group Code")
           {
               Visible = false;

               trigger OnValidate();
               begin
                   // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
                   if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                       CurrPage.UPDATE(true);
                   // >>DITW18.00.06 DDR DIT-770 #1190
               end;
           }
       }
       addafter("Unit of Measure")
       {
           field("Tariff No. XL"; "Tariff No. XL")
           {
               Description = 'FINXL7.00.001';
               Visible = false;
           }
           field("Net Weight"; "Net Weight")
           {
               Description = 'FINXL7.00.001';
               Visible = false;
           }*/ //Bc Upgrade YADAVM09 Drink it field commented<<
        }

        addafter("Line Amount")
        {
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                Visible = EnableCAD;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CAD Amount field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the CAD Amount field.';

            }
            /* //Bc Upgrade YADAVM09 Dependency on Drink it object>>
            field(RTCTotalUnit; Rec.GetTotalingLine(2, Rec.FIELDNO(Rec."Unit Price"), true))
            {
                AutoFormatExpression = Rec."Currency Code";
                AutoFormatType = 2;
                BlankZero = true;
                CaptionClass = GetCaptionClassVar(PageText2014411);
                CaptionML = ENU = 'Total Unit Price',
                            FRA = 'Total prix unitaire';
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
            */ //Bc Upgrade YADAVM09 Dependency on Drink it object<<
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
                //Bc Upgrade YADAVM09                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ToolTip = 'Specifies the value of the WHT Business Posting Group field.';

            }
            field("WHT Product Posting Group"; Rec."WHT Product Posting Group FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the WHT Product Posting Group field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the WHT Product Posting Group field.';

            }
        }
        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        addafter("Appl.-to Item Entry")
        {
            field("Auto. Acc. Group"; "Auto. Acc. Group")
            {
                Description = 'FINXL7.00.001';
            }
        }
        
       addafter("Deferral Code")
       {
           field("Customer DTax Group Code"; Rec."Customer DTax Group Code")
           {
               Editable = false;
               QuickEntry = false;
               Visible = false;
           }
           field("Item DTax Group Code"; "Item DTax Group Code")
           {
               Editable = false;
               QuickEntry = false;
               Visible = false;
           }
           field("AAD No."; Rec."AAD No.")
           {
               Visible = false;
           }
           field("ARC No."; Rec."ARC No.")
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
           field("SAD No."; Rec."SAD No.")
           {
               Description = 'DITW15.00.00.38 #1217';
               Visible = false;
           }
           field("ARC No. Mandatory"; Rec."ARC No. Mandatory")
           {
               Editable = false;
               QuickEntry = false;
               Visible = false;
           }
           field("Packaging Type Code"; Rec."Packaging Type Code")
           {
               Visible = false;
           }
           field("Free Reason Code"; Rec."Free Reason Code")
           {
               Description = 'DITW17.00.02 DIT-770 #132';
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
           field("Free Item Posting Type"; Rec."Free Item Posting Type")
           {
               Visible = false;

               trigger OnValidate();
               begin
                   FreeItemPostingTypeOnAfterVali;
               end;
           }
           field("Allow Price Dit Discount"; Rec."Allow Price Dit Discount")
           {
               Editable = false;
               Visible = false;
           }
           field("Allow Loyalty"; Rec."Allow Loyalty")
           {
           }
           field("Loyalty Point Type"; Rec."Loyalty Point Type")
           {
               Description = 'DITW17.10.05 DIT-770 #185';
               Visible = false;
           }
           field("Loyalty Unit Point"; "Loyalty Unit Point")
           {
               Description = 'DIT715 #243';
               QuickEntry = false;
               Visible = false;
           }
           field("Loyalty Points Qty. (Base)"; "Loyalty Points Qty. (Base)")
           {
               Description = 'DIT715 #243';
               QuickEntry = false;
               Visible = false;
           }
           field("Loyalty Amount Type"; "Loyalty Amount Type")
           {
               Description = 'DITW17.10.05 DIT-770 #185';
               Visible = false;
           }
           field("Loyalty Unit Amount"; "Loyalty Unit Amount")
           {
               Description = 'DITW17.10.05 DIT-770 #185';
               Visible = false;
           }
           field("Loyalty Unit Amount (LCY)"; "Loyalty Unit Amount (LCY)")
           {
               Description = 'DITW17.10.05 DIT-770 #185';
               Editable = false;
               Visible = false;
           }
           field("Loyalty Amount"; "Loyalty Amount")
           {
               Description = 'DITW17.10.05 DIT-770 #185';
               Visible = false;
           }
           field("Loyalty Amount (LCY)"; "Loyalty Amount (LCY)")
           {
               Description = 'DITW17.10.05 DIT-770 #185';
               Editable = false;
               Visible = false;
           }
           field("Loyalty Convert to Free Item"; "Loyalty Convert to Free Item")
           {
               Description = 'DITW17.10.05 DIT-770 #185';
               Visible = false;
           }
           field("Contract Type"; Rec."Contract Type")
           {
               Editable = false;
               Visible = false;
           }
           field("DIT Sub-Contract Type"; "DIT Sub-Contract Type")
           {
               Visible = false;
           }
           field("Service Contract No."; Rec."Service Contract No.")
           {
               Visible = false;
           }
           field("Financial Contract No."; Rec."Financial Contract No.")
           {
               Visible = false;
           }
           field("Contract Group Code"; Rec."Contract Group Code")
           {
               Visible = false;
           }
       }
       */ //Bc Upgrade YADAVM09 Drink it field commented<<
        //addafter("ShortcutDimCode[8]")//Bc Upgrade YADAVM09
        addafter("Shortcut Dimension 2 Code")//Bc Upgrade YADAVM09
        {
            //BC UPGRADE KUMARR78 FDD-MTC-008 >>
            field("Show Item charge on Invoice"; Rec."Show Item charge on Inv. FND")
            {
                ApplicationArea = all;
            }
            //BC UPGRADE KUMARR78 FDD-MTC-008 <<
            field("Item Type"; Rec."Item Type FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Item Type field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the Item Type field.';

            }
            field("RPM Solution"; Rec."RPM Solution FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the RPM Solution field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the RPM Solution field.';

            }
            field("RPM Type"; Rec."RPM Type FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the RPM Type field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the RPM Type field.';

            }
            field("RPM Damage / Loss"; Rec."RPM Damage / Loss FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the RPM Damage / Loss field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the RPM Damage / Loss field.';

            }
            field("Transporter RPM Damage / Loss"; Rec."TransporterRPM Damage/Loss FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Transporter RPM Damage / Loss field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the Transporter RPM Damage / Loss field.';

            }
            field("TIN No."; Rec."TIN No. FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the TIN No. field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the TIN No. field.';

            }
        }
        addafter("Total VAT Amount")
        {
            field(TotalCADAmount; TotalSalesLine."CAD Amount FND")
            {
                AutoFormatExpression = rec."Currency Code";
                //CaptionClass = DocumentTotals.GetTotalCADCaption,(SalesHeader."Currency Code");//Bc Upgrade YADAVM09
                CaptionClass = 'DocumentTotals.GetTotalCADCaption,(SalesHeader."Currency Code")';//Bc Upgrade YADAVM09
                Caption = 'Total CAD Amount';
                Editable = false;
                Visible = EnableCAD;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total CAD Amount field.';
                //Bc Upgrade YADAVM09                ToolTip = 'Specifies the value of the Total CAD Amount field.';

            }
        }
    }
    actions
    {
        modify(InsertExtTexts)
        {
            CaptionML = ENU = 'Insert &Ext. Texts', FRA = 'Insérer te&xtes étendus';
            ToolTipML = ENU = 'Insert an extended description for the sales document.', FRA = 'Insérez une description plus longue pour le document vente.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(DeferralSchedule)
        {
            CaptionML = ENU = 'Deferral Schedule', FRA = 'Tableau d''échelonnement';
            ToolTipML = ENU = 'View or edit the deferral schedule that governs how revenue made with this sales document is deferred to different accounting periods when the document is posted.', FRA = 'Affichez ou modifiez le tableau d''échelonnement qui régit la manière dont les revenus réalisés à l''aide de ce document vente sont reportés sur différentes périodes de comptabilité lorsque le document est validé.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("E&xplode BOM")
        {
            CaptionML = ENU = 'E&xplode BOM', FRA = '&Eclater nomenclature';
        }
        modify("Get Return &Receipt Lines")
        {
            CaptionML = ENU = 'Get Return &Receipt Lines', FRA = 'Ext&raire lignes réception retour';
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
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify("Item Charge &Assignment")
        {
            CaptionML = ENU = 'Item Charge &Assignment', FRA = '&Affectation frais annexes';
        }
        modify(ItemTrackingLines)
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
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
            
        addafter("Item Charge &Assignment")
        {
            action("Item Charge &Assignment (DIT)")
            {
                CaptionML = ENU = 'Item Charge &Assignment (DIT)',
                            FRA = '&Affectation frais annexes (DIT)';
                ShortCutKey = 'Shift+Ctrl+M';

                trigger OnAction();
                begin
                    ItemChargeAssgntDIT;
                end;
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it Action<<

        // addafter(ItemTrackingLines)//Bc Upgrade YADAVM09 Drink it Action<<
        // {
        //     action("SSCC Tracking Lines")
        //     {
        //         CaptionML = ENU = 'SSCC Tracking Lines',
        //                     FRA = 'Lignes Traçabilité SSCC';
        //         Image = ItemTrackingLines;

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.38 DDR 19/11/2010 #1139
        //             //This functionality was copied from page #44. Unsupported part was commented. Please check it.
        //             ///*CurrPage.SalesLines.PAGE.*/
        //             _OpenSSCCTrackingLines();

        //         end;
        //     }
        //     action("Insert Item Char&ges")
        //     {
        //         CaptionML = ENU = 'Insert Item Char&ges',
        //                     FRA = 'Insérer frais annexe';
        //         ShortCutKey = 'Ctrl+Y';

        //         trigger OnAction();
        //         begin
        //             //This functionality was copied from page #44. Unsupported part was commented. Please check it.
        //             /*CurrPage.SalesLines.PAGE.*/
        //             _InsertExtendedCharges(true);

        //         end;
        //     }
        // } //Bc Upgrade YADAVM09 Drink it Action<<
    }

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
        EditableDesc: Boolean;
        EnableCAD: Boolean;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateEditableOnRow;

    if SalesHeader.GET("Document Type","Document No.") then;

    DocumentTotals.SalesUpdateTotalsControls(Rec,TotalSalesHeader,TotalSalesLine,RefreshMessageEnabled,
      TotalAmountStyle,RefreshMessageText,InvDiscAmountEditable,CurrPage.EDITABLE,VATAmount);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
    SETFILTER("Resp. Center Table Filter",
      UserMgt.GetRespCenterFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",
      UserMgt.GetRespPhysLocationFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",
      UserMgt.GetRespLocationFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 DDR DIT-770 #1190
    // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
    SetFilterSubContractPostType();
    // >>DITW16.00.00.41 AHU DIT-715 #327

    #1..6

    // <<DITW15.00.00.01 DDR 18/12/2007
    // VIGEO VS 29-12-2005: Toeslag regels mogen niet worden gewijzigd. Dit moet op het hoofdartikel worden gedaan.
    UpdateFields();
    // >>DITW15.00.00.01 DDR 18/12/2007
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    trigger OnAfterGetRecord();
    begin
        //HEI.02 PATHAA02 07.11.2017>>
        if Rec.Type <> Rec.Type::Item then
            EditableDesc := true
        else
            EditableDesc := false;
        //PATHAA02 07.11.2017<<

    end;


    //Unsupported feature: CodeModification on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if (Quantity <> 0) and ItemExists("No.") then begin
      COMMIT;
      if not ReserveSalesLine.DeleteLineConfirm(Rec) then
        exit(false);
      ReserveSalesLine.DeleteLine(Rec);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.37 DDR 20/07/2010
    //IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
    //  COMMIT;
    //  IF NOT ReserveSalesLine.DeleteLineConfirm(Rec) THEN
    //    EXIT(FALSE);
    //  ReserveSalesLine.DeleteLine(Rec);
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
    "Unit PriceEnable" := true;
    QuantityEnable := true;
    "No.Enable" := true;
    TypeEnable := true;
    "Line AmountEditable" := true;
    "Unit PriceEditable" := true;
    QuantityEditable := true;
    "Cross-Reference No.Editable" := true;
    "No.Editable" := true;
    TypeEditable := true;
    // >>DITW15.00.00.01 DDR 18/12/2007
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

    #1..6
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

    trigger OnOpenPage();
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //HEI.04>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.04<<
    end;


    //Unsupported feature: CodeModification on "NoOnAfterValidate(PROCEDURE 19066594)". Please convert manually.

    //procedure NoOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
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
    // <<DITW15.00.00.36 DDR 25/11/2009 - DITW15.00.00.38 DDR 15/03/2011 #1291
    if (Type <> Type::Item) and not "Is Item Charge" then
    // >>DITW15.00.00.36 DDR - DITW15.00.00.38 DDR #1291
      InsertExtendedText(false);
    #2..5
    // <<DITW15.00.00.01 DDR 18/12/2007 - DITW15.00.00.23 DDR 30/07/2008
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
    */
    //end;


    //Unsupported feature: CodeModification on "ReserveOnAfterValidate(PROCEDURE 19004502)". Please convert manually.

    //procedure ReserveOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if (Reserve = Reserve::Always) and ("Outstanding Qty. (Base)" <> 0) then begin
      CurrPage.SAVERECORD;
      AutoReserve;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      CurrPage.UPDATE(false);
    end;
    */
    //end;


    //Unsupported feature: CodeModification on "QuantityOnAfterValidate(PROCEDURE 19032465)". Please convert manually.

    //procedure QuantityOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Reserve = Reserve::Always then begin
      CurrPage.SAVERECORD;
      AutoReserve;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    // <<DITW15.00.00.01 DDR DDR 15/01/2008
    if (Type = Type::Item) and (Quantity <> xRec.Quantity) then
      CurrPage.UPDATE(true);
    // >>DITW15.00.00.01 DDR
    */
    //end;


    //Unsupported feature: CodeModification on "UnitofMeasureCodeOnAfterValida(PROCEDURE 19057939)". Please convert manually.

    //procedure UnitofMeasureCodeOnAfterValida();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Reserve = Reserve::Always then begin
      CurrPage.SAVERECORD;
      AutoReserve;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      CurrPage.UPDATE(false);
    end;
    // <<DITW15.00.00.01 DDR DDR 15/01/2008
    if Type = Type::Item then
      CurrPage.UPDATE(true);
    // >>DITW15.00.00.01 DDR
    */
    //end;

    /* //Bc Upgrade YADAVM09 Drink it function>>
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

        procedure _InsertExtendedCharges(FromHeader: Boolean);
        begin
            // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
            if InsertChargeLines(FromHeader) then
                UpdateForm(true);
            // >>DITW15.00.00.23 DDR
        end;

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
            "Unit PriceEditable" := FormEditableField(FIELDNO("Unit Price")) and not CollapsedLine;
            "Line AmountEditable" := FormEditableField(FIELDNO("Line Amount")) and not CollapsedLine;

            // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
            TypeEnable := FormEditableField(FIELDNO(Type));
            "No.Enable" := FormEditableField(FIELDNO("No."));
            QuantityEnable := FormEditableField(FIELDNO(Quantity));
            "Unit PriceEnable" := FormEditableField(FIELDNO("Unit Price"));
            "Line AmountEnable" := FormEditableField(FIELDNO("Line Amount"));
            // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
        end;

        procedure _OpenSSCCTrackingLines();
        begin
            // <<DITW15.00.00.38 DDR 19/11/2010 #1139
            Rec.OpenSSCCTrackingLines();
        end;

        procedure OpenSSCCTrackingLines();
        begin
            // <<DITW15.00.00.38 DDR 19/11/2010 #1139
            Rec.OpenSSCCTrackingLines();
        end;
    */ //Bc Upgrade YADAVM09 Drink it function<<
    procedure TriggerOnDeleteRecord(): Boolean;
    var
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        TempRec: Record "Sales Line" temporary;
    begin
        if (Rec.Quantity <> 0) and Rec.ItemExists(Rec."No.") then begin
            COMMIT();
            if not ReserveSalesLine.DeleteLineConfirm(Rec) then
                exit(false);
            ReserveSalesLine.DeleteLine(Rec);
        end;
        /* //Bc Upgrade YADAVM09 Drink it code>>
                // <<DITW15.00.00.36 DDR 23/11/2009
                if "Is Item Charge" and "ItemCharge Incl. Price" then begin
                    DELETE(true);
                    TempRec := Rec;
                    TempRec."Unit Price" := 0;
                    TempRec."Line Amount" := 0;
                    TempRec."Line Discount Amount" := 0;
                    // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
                    TempRec.CalcBackUnitPriceItem();
                    // >>DITW110.00.11 DDR NRQ#24875
                    exit(false);
                end;
                // >>DITW15.00.00.36 DDR
                exit(true);
                */ //Bc Upgrade YADAVM09 Drink it code<<
    end;

    /* //Bc Upgrade YADAVM09 Drink it function>>
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

       local procedure UnitPriceOnAfterValidate();
       begin
           // <<DITW15.00.00.01 DDR 21/12/2007
           if (Type = Type::Item) and
              ("Unit Price" <> xRec."Unit Price")
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
   */ //Bc Upgrade YADAVM09 Drink it function<<
    local procedure AllowVATCalculationFreeOnAfter();
    begin
        CurrPage.UPDATE(true);
    end;

    /* //Bc Upgrade YADAVM09 Drink it function>>
        local procedure FreeItemPostingTypeOnAfterVali();
        begin
            // <<DITW15.00.00.35 DDR 25/06/2009
            if Type = Type::Item then
                CurrPage.UPDATE(true);
            // >>DITW15.00.00.35 DDR
        end;

        procedure ItemChargeAssgntDIT();
        var
            SelectedRec: Record "Sales Line";
        begin
            // <<DITW17.10.03 DDR 22/04/2014 DIT-770 #570
            CurrPage.SAVERECORD;
            COMMIT;
            CurrPage.SETSELECTIONFILTER(SelectedRec);
            GetNewItemChargeAssgnDIT(SelectedRec);
            CurrPage.UPDATE(false);
        end;
    */ //Bc Upgrade YADAVM09 Drink it function<<
       //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

