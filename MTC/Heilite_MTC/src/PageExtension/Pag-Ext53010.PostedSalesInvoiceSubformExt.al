pageextension 53010 PostedSalesInvoiceSubformExt extends "Posted Sales Invoice Subform"
{
    // version NAVW110.0,DITW110.00.08,HEI.02
    /* 
    DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    DITW15.00.00.01 DDR 02/01/2008 Added column "Line No." (not editable)
                                   property Editable Form = yes (but all fields are non editable except Collapse button)
    DITW15.00.00.01 DDR 15/01/2008 Added property Form InsertAllowed,ModifyAllowed,DeleteAllowed=No
    DITW15.00.00.01 DDR 15/02/2008 Added function UpdateFormatField()
    DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    DITW15.00.00.19 DDR 04/04/2008 Certification rules
    DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
                                     "Empty Goods Item No."
    DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
                        21/08/2009 issue 727 Added HorzAlign property in field "Unit Price,"Line Amount"
    DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
                    DDR 30/07/2010           Remove OnFormat() field "No."
                                             Remove OnOpenForm() to set fields as non-editable
                    CEL 13/08/2010           Modification RTC buttons
    DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
                                     Remove functions FormTotalingField()
                                     Rewrite functions UpdateFields(),FormTotalingField()
                        17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
                                     non editable field "Free Item"
    DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
                                                Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    DITW16.00.00.39 DDR 26/09/2011 DIT-715 #141 Added "Total Amount" column for all line types
    DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
                                                     Added function SetDisableRefreshLines() to call before/after each report object
                                                    (don't use the <RunObject> property)
    DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added to call function SetFilterSubContractPostType() on AfterGetCurrRecord();
                                                Added to call function SetFilterSubContractPostType2() on OnNewRecord()
                                                Added fields "DIT Sub-Contract Type","Service Contract No.""Contract Group Code"
                    AHU 06/11/2012 DIT-715 #393 Added "Description 2" field

    FINXL7.00.001 RBE 25/03/2013 : Added field: "Auto. Acc. Group"

    DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    DITW17.10.05 WSA 05/11/2014 DIT-770 #185 Added Loyalty Fields
    DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Unit Price"
    DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    DITW18.00.06 MSF 16/02/2015 DIT-770 #1190 Added field Physical location
    DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
                                              Rename Field Service contract Type => Contract Type
    DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    HEI.01 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
      # New field "RPM Damage / Loss" added
      # New field "Transporter RPM Damage / Loss" added
    HEI.02 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
      # New Field added - "TIN No."

    HEI.04 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
      # New Field added: "Suppress POS Interface"
    HEI.05 CHG2024918 IBM POENAB02 16.09.2019 La RËÇÜunion_France Fiscal Year Closing
      # New function: LinesInvoiced
      # New action group: Invoice
      # New action in avtion group Invoice: Shipments
    DITW113.00.15 DDR 04/10/2019 NRQ#10495 Rename Loyalty 'Cost' -> 'Amount' (all fields)
    HEI.06 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
      # New Field added: "CAD Amount"
     */
    // BC Upgrade BHARDA11 >>
    // 1. Remove Drink-IT Fields and Related code.
    // 2. Remove Drink-IT Functions and related code.
    // 3. Remove Drink-IT Customization and Related code.
    // 4. Remove CAD Amount field and related code because As per discussion with Saikat and Yash, For now putting this object on hold because CAD functionality is running only in CONGO opco.
    // 5. Remove Interface related customization to Interface extension.
    // BC Upgrade BHARDA11 <<
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the line type.', FRA = 'Spécifie le type de ligne.';

            //Unsupported feature: Change Editable on "Type(Control 2)". Please convert manually.

        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of a general ledger account, item, resource, additional cost, or fixed asset, depending on the contents of the Type field.', FRA = 'Spécifie le numéro d''un compte général, d''un article, d''une ressource, d''un coût supplémentaire ou d''une immobilisation, selon ce que vous avez sélectionné dans le champ Type.';

            //Unsupported feature: Change Editable on ""No."(Control 4)". Please convert manually.

        }
        // BC Upgrade BHARDA11 >> ----Not Found
        // modify("Cross-Reference No.")
        // {
        //     ToolTipML = ENU = 'Specifies the cross-referenced item number. If you enter a cross reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the cross-reference number on a sales or purchase document.', FRA = 'Spécifie le numéro d''article à référence externe. Si vous saisissez une référence externe entre votre numéro d''article et celui de votre fournisseur ou client, ce numéro remplace le numéro d''article standard lorsque vous saisissez le numéro de référence externe sur un document vente ou achat.';

        //     //Unsupported feature: Change Editable on ""Cross-Reference No."(Control 26)". Please convert manually.

        // }
        // BC Upgrade BHARDA11 << ----Not Found
        modify("IC Partner Code")
        {
            ToolTipML = ENU = 'Specifies the code of the IC partner that the line has been distributed to.', FRA = 'Spécifie le code du partenaire IC auquel la ligne a été répartie.';

            //Unsupported feature: Change Editable on ""IC Partner Code"(Control 20)". Please convert manually.

        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant number of the items sold.', FRA = 'Spécifie le code variante des articles vendus.';

            //Unsupported feature: Change Editable on ""Variant Code"(Control 18)". Please convert manually.

        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the name of the item or general ledger account, or some descriptive text.', FRA = 'Spécifie le nom de l''article ou du compte général, ou un texte descriptif.';

            //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.

        }
        modify("Return Reason Code")
        {
            ToolTipML = ENU = 'Specifies a code that explains why the item is returned.', FRA = 'Spécifie un code expliquant la raison du renvoi de l''article.';

            //Unsupported feature: Change Editable on ""Return Reason Code"(Control 14)". Please convert manually.

        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item specified on the line.', FRA = 'Spécifie le nombre d''unités de l''article sur la ligne spécifiée.';

            //Unsupported feature: Change BlankZero on "Quantity(Control 8)". Please convert manually.


            //Unsupported feature: Change Editable on "Quantity(Control 8)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code for the items sold.', FRA = 'Spécifie le code unité de l''article vendu.';

            //Unsupported feature: Change Editable on ""Unit of Measure Code"(Control 24)". Please convert manually.

        }
        modify("Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the unit of measure for the item (bottle or piece, for example).', FRA = 'Spécifie l''unité de mesure de l''article (par exemple une bouteille ou une pièce).';

            //Unsupported feature: Change Editable on ""Unit of Measure"(Control 10)". Please convert manually.

        }
        modify("Unit Cost (LCY)")
        {
            ToolTipML = ENU = 'Specifies the unit cost of the item on the invoice line.', FRA = 'Spécifie le coût unitaire pour l''article sur la ligne facture.';

            //Unsupported feature: Change Editable on ""Unit Cost (LCY)"(Control 66)". Please convert manually.

        }
        modify("Unit Price")
        {
            ToolTipML = ENU = 'Specifies the price of one unit of the item on the invoice line.', FRA = 'Spécifie le prix d''une unité de l''article sur la ligne facture.';

            //Unsupported feature: Change BlankZero on ""Unit Price"(Control 12)". Please convert manually.


            //Unsupported feature: Change AutoFormatType on ""Unit Price"(Control 12)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Unit Price"(Control 12)". Please convert manually.


            //Unsupported feature: Change Editable on ""Unit Price"(Control 12)". Please convert manually.

        }
        modify("Line Amount")
        {
            ToolTipML = ENU = 'Specifies the net amount (before subtracting the invoice discount amount) that must be paid for the items on the line.', FRA = 'Spécifie le montant net (avant soustraction du montant remise facture) à payer pour les articles de la ligne.';

            //Unsupported feature: Change BlankZero on ""Line Amount"(Control 30)". Please convert manually.


            //Unsupported feature: Change AutoFormatType on ""Line Amount"(Control 30)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Line Amount"(Control 30)". Please convert manually.


            //Unsupported feature: Change Editable on ""Line Amount"(Control 30)". Please convert manually.

        }
        modify("Line Discount %")
        {
            ToolTipML = ENU = 'Specifies the line discount % that was given on the line.', FRA = 'Spécifie le pourcentage de remise ligne qui a été accordé sur la ligne.';

            //Unsupported feature: Change BlankZero on ""Line Discount %"(Control 16)". Please convert manually.


            //Unsupported feature: Change Editable on ""Line Discount %"(Control 16)". Please convert manually.

        }
        modify("Line Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of the discount given on the line.', FRA = 'Spécifie le montant de la remise accordée sur la ligne.';

            //Unsupported feature: Change Editable on ""Line Discount Amount"(Control 52)". Please convert manually.

        }
        modify("Allow Invoice Disc.")
        {
            ToolTipML = ENU = 'Specifies whether the invoice line could have been included in a possible invoice discount calculation.', FRA = 'Spécifie si la ligne facture aurait pu être incluse dans le calcul d''une remise sur facture.';

            //Unsupported feature: Change Editable on ""Allow Invoice Disc."(Control 50)". Please convert manually.

        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'Specifies the job number that the sales invoice line is linked to.', FRA = 'Spécifie le numéro de la tâche à laquelle la ligne facture vente est liée.';
            Editable = false;
            //Unsupported feature: Change Editable on ""Job No."(Control 40)". Please convert manually.

        }
        modify("Job Task No.")
        {
            ToolTipML = ENU = 'Specifies the number of the job task that the sales line is linked to.', FRA = 'Spécifie le numéro de la tâche projet auquel la ligne vente achat est associée.';
        }
        modify("Job Contract Entry No.")
        {
            ToolTipML = ENU = 'Specifies the entry number of the job planning line that the sales line is linked to.', FRA = 'Spécifie le numéro d''écriture de la ligne planning projet à laquelle la ligne vente est liée.';
        }
        modify("Appl.-to Item Entry")
        {
            ToolTipML = ENU = 'Specifies the number of the item ledger entry this invoice line was applied to.', FRA = 'Spécifie le numéro de l''écriture comptable article avec laquelle cette ligne facture a été lettrée.';
            Visible = false;
            Editable = false;
            //Unsupported feature: Change Editable on ""Appl.-to Item Entry"(Control 44)". Please convert manually.

        }
        modify("Deferral Code")
        {
            ToolTipML = ENU = 'Specifies the deferral template that governs how revenue earned with this sales document is deferred to the different accounting periods when the good or service was delivered.', FRA = 'Spécifie le modèle d''échelonnement qui régit la manière dont les revenus réalisés à l''aide de ce document vente sont reportés sur les différentes périodes de comptabilité lorsque le bien ou le service est livré.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 1 Code"(Control 72)". Please convert manually.

        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 2 Code"(Control 70)". Please convert manually.

        }
        modify("Invoice Discount Amount")
        {
            CaptionML = ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
            ToolTipML = ENU = 'Specifies a discount amount that is deducted from the value in the Total Incl. VAT field. You can enter or change the amount manually.', FRA = 'Spécifie un montant de remise qui est déduit de la valeur dans le champ Total TTC. Vous pouvez saisir ou modifier le montant manuellement.';
        }
        modify("Total Amount Excl. VAT")
        {

            //Unsupported feature: Change DrillDown on ""Total Amount Excl. VAT"(Control 7)". Please convert manually.

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

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Type(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Type(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Cross-Reference No."(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Cross-Reference No."(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""IC Partner Code"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""IC Partner Code"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Return Reason Code"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Return Reason Code"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Quantity(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Quantity(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit Cost (LCY)"(Control 66)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit Cost (LCY)"(Control 66)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit Price"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit Price"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line Amount"(Control 30)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line Amount"(Control 30)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line Discount %"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line Discount %"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line Discount Amount"(Control 52)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line Discount Amount"(Control 52)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Allow Invoice Disc."(Control 50)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Allow Invoice Disc."(Control 50)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Job No."(Control 40)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Job No."(Control 40)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Job Task No."(Control 15)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Job Task No."(Control 15)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Job Contract Entry No."(Control 17)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Job Contract Entry No."(Control 17)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Appl.-to Item Entry"(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Appl.-to Item Entry"(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Deferral Code"(Control 11)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Deferral Code"(Control 11)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 72)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 72)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 70)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 70)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control28(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control23(Control 23)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control9(Control 9)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Total VAT Amount"(Control 5)". Please convert manually.

        addfirst(Control1)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields (Collapse,"Has Item Charge")
            // field("Has Item Charge"; Rec."Has Item Charge")
            // {
            //     BlankZero = true;
            // }
            // field(Collapse; Rec.Collapse)
            // {
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW15.00.00.37 DDR 19/01/2010
            //         CurrPage.UPDATE(TRUE);
            //         // >>DITW15.00.00.37 DDR
            //     end;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields (Collapse,"Has Item Charge")
        }
        addafter("Variant Code")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Function(GetTrackingItemNo)
            // field(GetTrackingItemNo(); GetTrackingItemNo())
            // {
            //     CaptionML = ENU='Tracking Item No. (Item Charge)',
            //                 FRA='N° article traçable (Frais annexes)';
            //     DrillDownPageID = "Item List";
            //     Editable = false;
            //     LookupPageID = "Item List";
            //     TableRelation = IF (Item Charge Type=CONST(Tax)) Item WHERE (No.=FIELD(Tax Item No.))
            //                     ELSE IF (Item Charge Type=CONST(Deposit)) Item WHERE (No.=FIELD(Empty Goods Item No.));
            //                                                                                   Visible = false;

            //     trigger OnLookup(var Text: Text): Boolean;
            //     begin
            //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
            //         Text := GetTrackingItemNo();
            //         LookupItemNo(Text);
            //         EXIT(FALSE);
            //     end;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Function(GetTrackingItemNo)
        }
        addafter(Description)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
            // field("Description 2"; Rec."Description 2")
            // {
            //     Description = 'DIT-715 #393';
            //     Editable = false;
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
        }
        addafter("Line Amount")
        {
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                ApplicationArea = All;
                Visible = EnableCAD;
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
            // field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Unit Price"), TRUE))
            // {
            //     AutoFormatExpression = GetCurrencyCode;
            //     AutoFormatType = 2;
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassVar(PageText2014411);
            //     CaptionML = ENU = 'Total Unit Price',
            //                 FRA = 'Total prix unitaire';
            //     Description = 'DITW17.10.05 DIT-770 #988';
            //     Editable = false;
            //     QuickEntry = false;
            //     Visible = false;
            // }
            // field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), TRUE))
            // {
            //     AutoFormatExpression = GetCurrencyCode;
            //     AutoFormatType = 1;
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassVar(PageText2014410);
            //     CaptionML = ENU = 'Total Line Amount',
            //                 FRA = 'Montant total ligne';
            //     Description = 'DITW17.10.02B DIT-770 #541';
            //     Editable = false;
            //     QuickEntry = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Customization
        }
        addafter("Appl.-to Item Entry")
        {
            // BC Upgrade BHADA11 >> ----Drink-IT Fields("Free Item", "Free Item Posting Type", "Gen. Prod. Posting Free Group", "Contract Type", "DIT Sub-Contract Type", "Service Contract No.", "Financial Contract No.", "Contract Group Code", "Auto. Acc. Group")
            // field("Free Item"; Rec."Free Item")
            // {
            //     Editable = false;
            // }
            // field("Free Item Posting Type"; Rec."Free Item Posting Type")
            // {
            //     Visible = false;
            // }
            // field("Gen. Prod. Posting Free Group"; Rec."Gen. Prod. Posting Free Group")
            // {
            //     Visible = false;
            // }
            // field("Contract Type"; Rec."Contract Type")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
            // {
            //     Visible = false;
            // }
            // field("Service Contract No."; Rec."Service Contract No.")
            // {
            //     Visible = false;
            // }
            // field("Financial Contract No."; Rec."Financial Contract No.")
            // {
            //     Visible = false;
            // }
            // field("Contract Group Code"; Rec."Contract Group Code")
            // {
            //     Visible = false;
            // }
            // field("Auto. Acc. Group"; Rec."Auto. Acc. Group")
            // {
            //     Description = 'FINXL7.00.001';
            //     QuickEntry = false;
            //     Visible = false;
            // }
            // BC Upgrade BHADA11 << ----Drink-IT Fields("Free Item", "Free Item Posting Type", "Gen. Prod. Posting Free Group", "Contract Type", "DIT Sub-Contract Type", "Service Contract No.", "Financial Contract No.", "Contract Group Code", "Auto. Acc. Group")
        }
        addafter("Shortcut Dimension 2 Code")
        {
            // BC Upgrade BHARAD11 >> ----Drink-IT Fields("Loyalty Point Type", "Loyalty Unit Point", "Loyalty Points Qty. (Base)", "Loyalty Amount Type", "Loyalty Unit Amount (LCY)", "Loyalty Unit Amount", "Loyalty Amount", "Loyalty Amount (LCY)", "Loyalty Convert to Free Item")
            // field("Loyalty Point Type"; Rec."Loyalty Point Type")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Visible = false;
            // }
            // field("Loyalty Unit Point"; Rec."Loyalty Unit Point")
            // {
            //     Visible = false;
            // }
            // field("Loyalty Points Qty. (Base)"; Rec."Loyalty Points Qty. (Base)")
            // {
            //     Visible = false;
            // }
            // field("Loyalty Amount Type"; Rec."Loyalty Amount Type")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Visible = false;
            // }
            // field("Loyalty Unit Amount (LCY)"; Rec."Loyalty Unit Amount (LCY)")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Unit Amount"; Rec."Loyalty Unit Amount")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Visible = false;
            // }
            // field("Loyalty Amount"; Rec."Loyalty Amount")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Visible = false;
            // }
            // field("Loyalty Amount (LCY)"; Rec."Loyalty Amount (LCY)")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Visible = false;
            // }
            // field("Loyalty Convert to Free Item"; Rec."Loyalty Convert to Free Item")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }
            // BC Upgrade BHARAD11 << ----Drink-IT Fields("Loyalty Point Type", "Loyalty Unit Point", "Loyalty Points Qty. (Base)", "Loyalty Amount Type", "Loyalty Unit Amount (LCY)", "Loyalty Unit Amount", "Loyalty Amount", "Loyalty Amount (LCY)", "Loyalty Convert to Free Item")
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
            field("Transporter RPM Damage / Loss"; Rec."Trnsprtr. RPM Damage/Loss FND")
            {
                ApplicationArea = All;
            }
            field("TIN No."; Rec."TIN No. FND")
            {
                ApplicationArea = All;
            }

        }
        addafter("Total VAT Amount")
        {
            // BC Upgrade BHARDA11 >> 
            field(CADAmount; TotalSalesInvoiceHeader."CAD Amount FND")
            {
                ApplicationArea = Basic, Suite;
                AutoFormatExpression = TotalSalesInvoiceHeader."Currency Code";
                AutoFormatType = 1;
                // CaptionClass = DocumentTotals.GetTotalCADCaption(TotalSalesInvoiceHeader."Currency Code");
                CaptionClass = HeinekenBCCustomFunctions.GetTotalCADCaption(TotalSalesInvoiceHeader."Currency Code");
                CaptionML = ENU = 'CAD Amount',
                            FRA = 'CAD Montant';
                DrillDown = false;
                Editable = false;
                Visible = EnableCAD;
            }
            // BC Upgrade BHARAD11 << ----
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {

            //Unsupported feature: Change AccessByPermission on "Dimensions(Action 1901314304)". Please convert manually.

            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Comments)
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(ItemTrackingEntries)
        {
            CaptionML = ENU = 'Item &Tracking Entries', FRA = 'Écritures &traçabilité';
        }
        modify(ItemShipmentLines)
        {
            CaptionML = ENU = 'Item Shipment &Lines', FRA = '&Lignes expédition article';
        }
        modify(DeferralSchedule)
        {
            CaptionML = ENU = 'Deferral Schedule', FRA = 'Tableau d''échelonnement';
            ToolTipML = ENU = 'View the deferral schedule that governs how revenue made with this sales document was deferred to different accounting periods when the document was posted.', FRA = 'Affichez ou modifiez le tableau d''échelonnement qui régit la manière dont les revenus réalisés à l''aide de ce document vente étaient échelonnés sur différentes périodes de comptabilité lorsque le document a été validé.';
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Line"(Action 1907935204)". Please convert manually.



        //Unsupported feature: CodeModification on "ItemShipmentLines(Action 1905427604).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if not (Type in [Type::Item,Type::"Charge (Item)"]) then
          TESTFIELD(Type);
        ShowItemShipmentLines;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF NOT (Type IN [Type::Item,Type::"Charge (Item)"]) THEN
          TESTFIELD(Type);
        ShowItemShipmentLines;
        */
        //end;
        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
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
        //             ExpandLines := TRUE;
        //             CurrPage.UPDATE(TRUE);
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
        //             ExpandLines := FALSE;
        //             CurrPage.UPDATE(TRUE);
        //             // >>DITW17.10.03 DDR DIT-770 #541
        //         end;
        //     }
        //    
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Customization
        // addafter("&Line")
        // {
        //     group("&Invoice") // BC FR Upgrade KAIRAR01
        //     {
        //         CaptionML = ENU = '&Invoice',
        //                     FRA = 'Fa&cture';
        //         Enabled = FRLocAction;
        //         Image = Invoice;
        //         Visible = FRLocAction;
        //         action(Shipments) // BC FR Upgrade KAIRAR01
        //         {
        //             ApplicationArea = Basic, Suite;
        //             CaptionML = ENU = 'S&hipments',
        //                         FRA = 'E&xpéditions';
        //             Enabled = FRLocAction;
        //             Image = Shipment;
        //             Visible = FRLocAction;

        //             trigger OnAction();
        //             begin
        //                 LinesInvoiced;
        //             end;
        //         }
        //     }
        // }
    }


    //Unsupported feature: PropertyModification on "TotalSalesInvoiceHeader(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //TotalSalesInvoiceHeader : "Sales Invoice Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TotalSalesInvoiceHeader : 112;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DocumentTotals(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DocumentTotals : "Document Totals";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DocumentTotals : 57;
    //Variable type has not been exported.

    var
        HeinekenBCCustomFunctions: Codeunit "Heineken BC Custom Functions";
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Unit Price', FRA = 'Total prix unitaire';
        DisabledRefreshLines: Boolean;
        ExpandLines: Boolean;
        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        CompanyInfo: Record "Company Information";
        FRLocAction: Boolean;
        EnableCAD: Boolean;

    // BC Upgrade BHARAD11 >>
    trigger OnAfterGetRecord()
    begin
        TotalSalesInvoiceHeader.get(Rec."Document No.");
    end;
    // BC Upgrade BHARAD11 <<
    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    IndentLine := IndentRecordDIT(ExpandLines);
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnFindRecord". Please convert manually.

    //trigger OnFindRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    IF DisabledRefreshLines THEN
      EXIT(FALSE);
    // >>DITW16.00.00.40 DDR DIT-715 #197
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //EXIT(FIND(Which));
    EXIT(FindRecordDIT(Which,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNextRecord". Please convert manually.

    //trigger OnNextRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //EXIT(NEXT(Steps));
    EXIT(NextRecordDIT(Steps,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    trigger OnOpenPage()
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //HEI.06>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.06<<
    end;
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    ExpandLines := FALSE;
    ShowButtonsCE := IsShowButtonsCEDIT();
    // >>DITW17.10.03 DDR DIT-770 #541

    //HEI.06>>
    GeneralLedgerSetup.GET;
    EnableCAD := GeneralLedgerSetup."Enable CAD";
    //HEI.06<<
    */
    //end;

    procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
    begin
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        DisabledRefreshLines := NewDisabledRefreshLines;
    end;

    procedure LinesInvoiced();
    var
    // ShipmentInvoiced: Record "Shipment Invoiced"; //10825 // BC Upgrade BHARDA11 ----Record Not found In BC
    begin
        // BC Upgrade BHARDA11 >>----Record Not found In BC
        //HEI.05>>
        // ShipmentInvoiced.RESET;
        // ShipmentInvoiced.SETCURRENTKEY("Invoice No.", "Invoice Line No.", "Shipment No.", "Shipment Line No.");
        // ShipmentInvoiced.SETRANGE("Invoice No.", "Document No.");
        // ShipmentInvoiced.SETRANGE("Invoice Line No.", "Line No.");
        // PAGE.RUNMODAL(PAGE::"Shipments bound by Invoice", ShipmentInvoiced);
        //HEI.05<<
        // BC Upgrade BHARDA11 <<----Record Not found In BC
    end;

}

