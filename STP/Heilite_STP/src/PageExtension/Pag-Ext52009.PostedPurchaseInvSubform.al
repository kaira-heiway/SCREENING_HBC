pageextension 52009 PostedPurchInvoicesubformExt extends "Posted Purch. Invoice Subform"
{
    // version NAVW110.0,FINXL9.00,DITW110.00.08,HEI.07,HEI.09
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.01 DDR 02/01/2008 Added column "Line No." (not editable)
    //                                  property Editable Form = yes (but all fields are non editable except Collapse button)
    //   DITW15.00.00.01 DDR 15/01/2008 Added property Form InsertAllowed,ModifyAllowed,DeleteAllowed=No
    //   DITW15.00.00.01 DDR 15/02/2008 Added function UpdateFormatField()
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.21 DDR 27/06/2008 Added Shipping Transport functions
    //                                    ShowItemShippingReceiptLines(),ShowItemShippingWShpttLines()
    //   DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
    //                                    "Empty Goods Item No."
    //   DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //                       21/08/2009 issue 727 Added HorzAlign property in field "Direct Unit Cost","Line Amount"
    //   DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                    Remove functions FormTotalingField()
    //                                    Rewrite functions UpdateFields(),FormTotalingField()
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                   DDR 30/07/2010           Remove OnFormat() field "No."
    //                                            Remove OnOpenForm() to set fields as non-editable
    //                   CEL 13/08/2010           Modification RTC buttons
    //   DITW15.00.00.38 DDR 17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    //                                    non editable field "Free Item"
    //   DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                               Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //   DITW16.00.00.39 DDR 26/09/2011 DIT-715 #141 Added "Total Amount" column for all line types
    //   DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                    Added function SetDisableRefreshLines() to call before/after each report object
    //                                                   (don't use the <RunObject> property)
    //   DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added 'Service/Contract' tab
    //                                               Added fields into 'Service/Contract' tab
    //                                                 "DIT Sub-Contract Type","Contract Group Code","Service Contract No."
    //                                               Moved "Building No." into 'Service/Contract' tab
    //                   AHU 06/11/2012 DIT-715 #393 Added "Description 2" field

    //   FINXL7.00.001 RBE 25/03/2013 : Added field: "Auto. Acc. Group"

    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Direct Unit Cost"
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //   DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                             Rename Field Service contract Type => Contract Type

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.01 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //     # New Field added: "TIN No."
    //   HEI.03 CHG2090912 HB1641 IBM NANDIS01 01.02.2021 General Ledger Entries Description
    //     # Make visible of new field - "Additional Description"
    //   HEI.04 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //     # New Field added: "CAD Amount"
    //     # Code added on 'OnOpenPage' trigger
    //   HEI.05 CHG2217161 SAHAL01 02.11.2023 SPL for Returns and GR cancellations
    //     # Added New Fields - SPL Code
    //                        - SPL Name
    //                        - Consumption SPL Code
    //   HEI.06 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //    #New field Added #H&S Levy Tax Amount
    //   HEI.07 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //     # Added New Fields - Zycus Order No.
    //                        - Zycus Order Line No.
    //                        - Zycus PR Reference No.
    //                        - Zycus PO Type Code
    //                        - Zycus PO Line Type Code
    //                        - Zycus PO Line Validated
    //   HEI.08 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //     # Added New Field - Zycus Movement Type
    //   HEI.09 CHG2221624 HB3614 IBM SRIVAS07 11.06.2024 # Block Payment for Invoices with Price Difference higher than the tolerance
    //     # Added New Field - Tolerance Exceeded
    //HEI.04- //BC Upgrade GUNREM01

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
            ToolTipML = ENU = 'Specifies an item number that identifies the account number that identifies the general ledger account used when posting the line.', FRA = 'Spécifie un numéro d''article qui identifie le numéro de compte correspondant au compte général utilisé lors de la validation de la ligne.';

            //Unsupported feature: Change Editable on ""No."(Control 4)". Please convert manually.

        }
        //BC Upgrade GUNREM01 NA
        // modify("Cross-Reference No.")
        // {
        //     ToolTipML = ENU='Specifies the cross-referenced item number. If you enter a cross reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the cross-reference number on a sales or purchase document.',FRA='Spécifie le numéro d''article à référence externe. Si vous saisissez une référence externe entre votre numéro d''article et celui de votre fournisseur ou client, ce numéro remplace le numéro d''article standard lorsque vous saisissez le numéro de référence externe sur un document vente ou achat.';

        //     //Unsupported feature: Change Editable on ""Cross-Reference No."(Control 62)". Please convert manually.

        // }
        modify("IC Partner Code")
        {
            ToolTipML = ENU = 'Specifies the code of the IC partner that the line has been distributed to.', FRA = 'Spécifie le code du partenaire IC auquel la ligne a été répartie.';

            //Unsupported feature: Change Editable on ""IC Partner Code"(Control 14)". Please convert manually.

        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant code for the item.', FRA = 'Spécifie le code variante pour l''article.';

            //Unsupported feature: Change Editable on ""Variant Code"(Control 32)". Please convert manually.

        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies either the name of, or a description of, the item or general ledger account.', FRA = 'Spécifie soit le nom, soit une désignation du compte article ou général.';

            //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.

        }
        modify("Return Reason Code")
        {
            ToolTipML = ENU = 'Specifies a code that explains why the item is returned.', FRA = 'Spécifie un code expliquant la raison du renvoi de l''article.';

            //Unsupported feature: Change Editable on ""Return Reason Code"(Control 38)". Please convert manually.

        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the quantity posted from the line.', FRA = 'Spécifie la quantité validée à partir de la ligne.';

            //Unsupported feature: Change Editable on "Quantity(Control 8)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code for the item.', FRA = 'Spécifie le code unité de l''article.';

            //Unsupported feature: Change Editable on ""Unit of Measure Code"(Control 30)". Please convert manually.

        }
        modify("Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the unit of measure for the item (bottle or piece, for example).', FRA = 'Spécifie l''unité de mesure de l''article (par exemple une bouteille ou une pièce).';

            //Unsupported feature: Change Editable on ""Unit of Measure"(Control 10)". Please convert manually.

        }
        modify("Direct Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the direct unit cost of one unit of the item.', FRA = 'Spécifie le coût unitaire d''achat d''une unité de l''article.';

            //Unsupported feature: Change AutoFormatType on ""Direct Unit Cost"(Control 12)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Direct Unit Cost"(Control 12)". Please convert manually.


            //Unsupported feature: Change Editable on ""Direct Unit Cost"(Control 12)". Please convert manually.

        }
        modify("Indirect Cost %")
        {
            ToolTipML = ENU = 'Specifies the item''s indirect cost, as a percentage.', FRA = 'Spécifie le coût indirect de l''article en tant que pourcentage.';

            //Unsupported feature: Change Editable on ""Indirect Cost %"(Control 54)". Please convert manually.

        }
        modify("Unit Cost (LCY)")
        {
            ToolTipML = ENU = 'Specifies the cost, in LCY, of one unit of the item on the line.', FRA = 'Spécifie le coût, en DS, d''une unité de l''article sur la ligne.';

            //Unsupported feature: Change Editable on ""Unit Cost (LCY)"(Control 50)". Please convert manually.

        }
        modify("Unit Price (LCY)")
        {
            ToolTipML = ENU = 'Specifies the price, in LCY, for one unit of the item.', FRA = 'Spécifie le prix unitaire, en DS, de l''article.';

            //Unsupported feature: Change Editable on ""Unit Price (LCY)"(Control 52)". Please convert manually.

        }
        modify("Line Amount")
        {
            ToolTipML = ENU = 'Specifies the net amount (before subtracting the invoice discount amount) that must be paid for the items on the line.', FRA = 'Spécifie le montant net (avant soustraction du montant remise facture) à payer pour les articles de la ligne.';

            //Unsupported feature: Change AutoFormatType on ""Line Amount"(Control 64)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Line Amount"(Control 64)". Please convert manually.


            //Unsupported feature: Change Editable on ""Line Amount"(Control 64)". Please convert manually.

        }
        modify("Line Discount %")
        {
            ToolTipML = ENU = 'Specifies the line discount % granted on items on each individual line.', FRA = 'Spécifie le pourcentage de remise ligne accordé aux articles de chaque ligne.';

            //Unsupported feature: Change Editable on ""Line Discount %"(Control 16)". Please convert manually.

        }
        modify("Line Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the discount amount that was granted on the invoice line.', FRA = 'Spécifie le montant de la remise accordée à la ligne facture.';

            //Unsupported feature: Change Editable on ""Line Discount Amount"(Control 44)". Please convert manually.

        }
        modify("Allow Invoice Disc.")
        {
            ToolTipML = ENU = 'Specifies whether the invoice line could have been included in an invoice discount calculation.', FRA = 'Spécifie si la ligne facture aurait pu être incluse dans le calcul d''une remise sur facture.';

            //Unsupported feature: Change Editable on ""Allow Invoice Disc."(Control 42)". Please convert manually.

        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'Specifies the number of the job that the purchase invoice line is linked to.', FRA = 'Spécifie le numéro du projet auquel la ligne facture achat est associée.';

            //Unsupported feature: Change Editable on ""Job No."(Control 34)". Please convert manually.

        }
        modify("Insurance No.")
        {
            ToolTipML = ENU = 'Specifies the insurance number on the purchase invoice line.', FRA = 'Spécifie le numéro d''assurance de la ligne facture achat.';

            //Unsupported feature: Change Editable on ""Insurance No."(Control 20)". Please convert manually.

        }
        modify("Budgeted FA No.")
        {
            ToolTipML = ENU = 'Specifies the budgeted FA number on the purchase invoice line.', FRA = 'Spécifie le numéro d''immobilisation budgétée de la ligne facture achat.';

            //Unsupported feature: Change Editable on ""Budgeted FA No."(Control 28)". Please convert manually.

        }
        modify("FA Posting Type")
        {
            ToolTipML = ENU = 'Specifies the FA posting type of the purchase invoice line.', FRA = 'Spécifie le type comptabilisation immobilisation de la ligne facture achat.';

            //Unsupported feature: Change Editable on ""FA Posting Type"(Control 18)". Please convert manually.

        }
        modify("Depr. until FA Posting Date")
        {
            ToolTipML = ENU = 'Specifies whether depreciation was calculated until the FA posting date of the line.', FRA = 'Spécifie si l''amortissement a été calculé jusqu''à la date comptabilisation immobilisation de la ligne.';

            //Unsupported feature: Change Editable on ""Depr. until FA Posting Date"(Control 22)". Please convert manually.

        }
        modify("Depreciation Book Code")
        {
            ToolTipML = ENU = 'Specifies the depreciation book code on the purchase invoice line.', FRA = 'Spécifie le code loi amortissement de la ligne facture achat.';

            //Unsupported feature: Change Editable on ""Depreciation Book Code"(Control 26)". Please convert manually.

        }
        modify("Depr. Acquisition Cost")
        {
            ToolTipML = ENU = 'Specifies whether, when this line was posted, the additional acquisition cost posted on the line was depreciated in proportion to the amount by which the fixed asset had already been depreciated.', FRA = 'Indique si, lors de la validation de cette ligne, le coût d''acquisition supplémentaire validé sur cette ligne a été amorti proportionnellement au montant précédemment amorti.';

            //Unsupported feature: Change Editable on ""Depr. Acquisition Cost"(Control 24)". Please convert manually.

        }
        modify("Appl.-to Item Entry")
        {
            ToolTipML = ENU = 'Specifies the number of a particular item entry to which the invoice line was applied when it was posted.', FRA = 'Spécifie le numéro d''une écriture article donnée avec laquelle la ligne facture a été lettrée lorsqu''elle a été validée.';

            //Unsupported feature: Change Editable on ""Appl.-to Item Entry"(Control 36)". Please convert manually.

        }
        modify("Deferral Code")
        {
            ToolTipML = ENU = 'Specifies the deferral template that governs how expenses paid with this purchase document are deferred to the different accounting periods when the expenses were incurred.', FRA = 'Spécifie le modèle d''échelonnement qui régit la manière dont les dépenses payées avec ce document achat sont reportées sur les différentes périodes de comptabilité lorsque des dépenses sont encourues.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 1 Code"(Control 60)". Please convert manually.

        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 2 Code"(Control 58)". Please convert manually.

        }
        modify("Invoice Discount Amount")
        {
            CaptionML = ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
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
            ToolTipML = ENU = 'Specifies the sum of VAT amounts on all lines in the document.', FRA = 'Spécifie la somme des montants de TVA sur toutes les lignes du document.';
        }
        modify("Total Amount Incl. VAT")
        {
            CaptionML = ENU = 'Total Amount Incl. VAT', FRA = 'Montant total TTC';
            ToolTipML = ENU = 'Specifies the sum of the value in the Line Amount Incl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.', FRA = 'Spécifie la somme de la valeur du champ Montant TTC sur toutes les lignes du document, moins l''éventuel montant remise indiqué dans le champ Montant remise facture.';
        }
        //BC Upgrade GUNREM01 >> DIT
        // addfirst(Control1)
        // {

        // field("Has Item Charge";R"Has Item Charge")
        // {
        //     BlankZero = true;
        // }
        // field(Collapse;Collapse)
        // {
        //     Visible = false;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 19/01/2010
        //         CurrPage.UPDATE(true);
        //         // >>DITW15.00.00.37 DDR
        //     end;
        // } 
        //}

        // addafter("Variant Code")
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

        //         trigger OnLookup(Text: Text): Boolean;
        //         begin
        //             // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //             Text := GetTrackingItemNo();
        //             LookupItemNo(Text);
        //             exit(false);
        //         end;
        //     }
        // }
        //BC Upgrade GUNREM01 << DIT
        addafter(Description)
        {
            field("Additional Description"; Rec."Additional Description FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Additional Description field.';
            }
            // field("Description 2"; "Description 2")
            // {
            //     Description = 'DIT-715 #393';
            //     Editable = false;
            //     Visible = false;
            // } //BC Upgrade GUNREM01 - DIT
        }
        addafter(Quantity)
        {
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                ApplicationArea = All;
                Visible = EnableCAD;
            } //BC Upgrade GUNREM01 
        }
        //BC Upgrade GUNREM01 >> DIT
        // addafter("Line Amount")
        // {
        //     field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Direct Unit Cost"), true))
        //     {
        //         AutoFormatExpression = GetCurrencyCode;
        //         AutoFormatType = 2;
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassVar(PageText2014411);
        //         CaptionML = ENU = 'Total Direct Unit Cost',
        //                     FRA = 'Total coût unitaire directe';
        //         Description = 'DITW17.10.05 DIT-770 #988';
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), true))
        //     {
        //         AutoFormatExpression = GetCurrencyCode;
        //         AutoFormatType = 1;
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassVar(PageText2014410);
        //         CaptionML = ENU = 'Total Line Amount',
        //                     FRA = 'Montant total ligne';
        //         Description = 'DITW17.10.02B DIT-770 #541';
        //         Editable = false;
        //         QuickEntry = false;
        //     }
        // }
        //BC Upgrade GUNREM01 << DIT
        addafter("Line Discount Amount")
        {
            field("H&S Levy Tax Amount"; Rec."H&S Levy Tax Amount FND")
            {
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the H&S Levy Tax Amount field.';
            }
        }
        //BC Upgrade GUNREM01 >> DIT
        // addafter("Appl.-to Item Entry")
        // {
        //     field("Free Item"; Rec."Free Item")
        //     {
        //         Editable = false;
        //     }
        //     field("Free Item Posting Type"; "Free Item Posting Type")
        //     {
        //         Visible = false;
        //     }
        //     field("Gen. Prod. Posting Free Group"; "Gen. Prod. Posting Free Group")
        //     {
        //         Visible = false;
        //     }
        //     field("Contract Type"; "Contract Type")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("DIT Sub-Contract Type"; "DIT Sub-Contract Type")
        //     {
        //         Visible = false;
        //     }
        //     field("Service Contract No."; "Service Contract No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Financial Contract No."; "Financial Contract No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Contract Group Code"; "Contract Group Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Auto. Acc. Group"; "Auto. Acc. Group")
        //     {
        //         Description = 'FINXL7.00.001';
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        // }  
        //BC Upgrade GUNREM01 << DIT
        addafter("Deferral Code")
        {
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
            field("WHT Absorb Base"; Rec."WHT Absorb Base FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Absorb Base field.';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("TIN No."; Rec."TIN No. FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the TIN No. field.';
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

            field("Consumption SPL Code"; Rec."Consumption SPL Code FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Consumption SPL Code field.';
            }
            field("Tolerance Exceeded"; Rec."Tolerance Exceeded FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Tolerance Exceeded field.';
            }
        }
        addafter("Total VAT Amount")
        {
            field(TotalCADAmount; TotalPurchInvHeader."CAD Amount FND")
            {
                ApplicationArea = All;
                AutoFormatExpression = TotalPurchInvHeader."Currency Code";
                // CaptionClass = DocumentTotals.GetTotalCADCaption(TotalPurchInvHeader."Currency Code");
                CaptionClass = HeinekenBCCustomFunctions.GetTotalCADCaption(TotalPurchInvHeader."Currency Code");
                Caption = 'Total CAD Amount';
                Editable = false;
                Visible = EnableCAD;
            }
        }
        addafter("Total Amount Incl. VAT")
        {
            field(TotalInclCAD; TotalInclCAD)
            {
                ApplicationArea = All;
                AutoFormatExpression = TotalPurchInvHeader."Currency Code";
                // CaptionClass = DocumentTotals.GetTotalInclCADCaption(TotalPurchInvHeader."Currency Code");
                CaptionClass = HeinekenBCCustomFunctions.GetTotalInclCADCaption(TotalPurchInvHeader."Currency Code");
                Caption = 'Total Incl. CAD';
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;
                Visible = EnableCAD;
            }
        } //BC Upgrade GUNREM01 -NA
        //BC Upgrade GUNREM01 >> -Fields moved to Interface Ext
        //   field("Zycus Order No."; Rec."Zycus Order No.")
        // {
        //     Editable = false;
        //     Visible = false;
        // }
        // field("Zycus Order Line No."; Rec."Zycus Order Line No.")
        // {
        //     Editable = false;
        //     Visible = false;
        // }
        // field("Zycus PR Reference No."; Rec."Zycus PR Reference No.")
        // {
        //     Editable = false;
        //     Visible = false;
        // }
        // field("Zycus PO Type Code"; Rec."Zycus PO Type Code")
        // {
        //     Editable = false;
        //     Visible = false;
        // }
        // field("Zycus PO Line Type Code"; Rec."Zycus PO Line Type Code")
        // {
        //     Editable = false;
        //     Visible = false;
        // }
        // field("Zycus PO Line Validated"; Rec."Zycus PO Line Validated")
        // {
        //     Editable = false;
        //     Visible = false;
        // }
        // field("Zycus Movement Type"; Rec."Zycus Movement Type")
        // {
        //     Editable = false;
        //     Visible = false;
        // }
        //BC Upgrade GUNREM01 << -Fields moved to Interface Ext
    }
    //BC Upgrade GUNREM01 >> NA



    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {
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
            //BC Upgrade SHARMP16--ProcessChanges BEGIN<<
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                if Rec.Type = Rec.Type::"Charge (Item)" then
                    ShowItemShippingLines();
            end;//BC Upgrade SHARMP16--ProcessChangesEND>>
        }
        modify(ItemReceiptLines)
        {
            CaptionML = ENU = 'Item Receipt &Lines', FRA = '&Lignes réception article';
        }
        modify(DeferralSchedule)
        {
            CaptionML = ENU = 'Deferral Schedule', FRA = 'Tableau d''échelonnement';
            ToolTipML = ENU = 'View the deferral schedule that governs how expenses paid with this purchase document were deferred to different accounting periods when the document was posted.', FRA = 'Affichez ou modifiez le tableau d''échelonnement qui régit la manière dont les dépenses réalisées à l''aide de ce document achat étaient échelonnées sur différentes périodes de comptabilité lorsque le document a été validé.';
        }
        //BC upgrade GUNREM01 >>DIT
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
        //BC upgrade GUNREM01 <<DIT

        //BC Upgrade GUNREM01 >> DIT
        // addafter(ItemReceiptLines)
        // {
        //     action("Item &Shipping Lines")
        //     {
        //         CaptionML = ENU = 'Item &Shipping Lines',
        //                     FRA = 'Lignes article & expéditon';

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.21 DDR 27/06/2008
        //             //This functionality was copied from page #138. Unsupported part was commented. Please check it.
        //             /*CurrPage.PurchInvLines.PAGE.*/
        //             _ShowItemShippingLines;
        //             // >>DITW15.00.00.21 DDR

        //         end;
        //     }
        // } //BC Upgrade GUNREM01 << DIT
    }



    var
        PurchInvLine: Record "Purch. Inv. Line";

        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Direct Unit Cost', FRA = 'Total coût unitaire directe';
        DisabledRefreshLines: Boolean;
        ExpandLines: Boolean;
        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        GeneralLedgerSetup: Record "General Ledger Setup";
        EnableCAD: Boolean;
        TotalInclCAD: Decimal;
        HeinekenBCCustomFunctions: Codeunit "Heineken BC Custom Functions";

    trigger OnOpenPage()
    begin
        //HEI.04>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.04<<
    end;

    trigger OnAfterGetCurrRecord()
    begin
        //HEI.04>>
        TotalInclCAD := 0;
        GeneralLedgerSetup.GET;
        IF GeneralLedgerSetup."Enable CAD FND" THEN BEGIN
            IF TotalPurchInvHeader."CAD Amount FND" <> 0 THEN BEGIN
                PurchInvLine.RESET;
                PurchInvLine.SETRANGE("Document No.", TotalPurchInvHeader."No.");
                PurchInvLine.SETFILTER("CAD Attached to Line No. FND", '<>%1', 0);
                IF PurchInvLine.FINDFIRST THEN
                    TotalInclCAD := TotalPurchInvHeader."Amount Including VAT"
                ELSE
                    TotalInclCAD := TotalPurchInvHeader."Amount Including VAT" + TotalPurchInvHeader."CAD Amount FND";
            END ELSE
                TotalInclCAD := TotalPurchInvHeader."Amount Including VAT";
        END;
        //HEI.04<<
    end;
    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger (Variable: GeneralLedgerSetup)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocumentTotals.CalculatePostedPurchInvoiceTotals(TotalPurchInvHeader,VATAmount,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DocumentTotals.CalculatePostedPurchInvoiceTotals(TotalPurchInvHeader,VATAmount,Rec);

    //HEI.04>>
    TotalInclCAD := 0;
    GeneralLedgerSetup.GET;
    if GeneralLedgerSetup."Enable CAD" then begin
      if TotalPurchInvHeader."CAD Amount" <> 0 then begin
        PurchInvLine.RESET;
        PurchInvLine.SETRANGE("Document No.",TotalPurchInvHeader."No.");
        PurchInvLine.SETFILTER("CAD Attached to Line No.",'<>%1',0);
        if PurchInvLine.FINDFIRST then
          TotalInclCAD := TotalPurchInvHeader."Amount Including VAT"
        else
          TotalInclCAD := TotalPurchInvHeader."Amount Including VAT" + TotalPurchInvHeader."CAD Amount";
      end else
        TotalInclCAD := TotalPurchInvHeader."Amount Including VAT";
    end;
    //HEI.04<<
    */
    //end;


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
    if DisabledRefreshLines then
      exit(false);
    // >>DITW16.00.00.40 DDR DIT-715 #197
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //EXIT(FIND(Which));
    exit(FindRecordDIT(Which,ExpandLines));
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

    //HEI.04>>
    GeneralLedgerSetup.GET;
    EnableCAD := GeneralLedgerSetup."Enable CAD";
    //HEI.04<<
    */
    //end;
    //BC Upgrade GUNREM01 >> Used in DIT action
    // procedure _ShowItemShippingLines();
    // begin
    //     if not (rec.Type in [rec.Type::"G/L Account", rec.Type::"Charge (Item)"]) then
    //         rec.TESTFIELD(Type);
    //     ShowItemShippingLines;
    // end;

    // procedure ShowItemShippingLines();
    // begin
    //     if not (Type in [Type::"G/L Account", Type::"Charge (Item)"]) then
    //         TESTFIELD(Type);
    //     Rec.ShowItemShippingLines;
    // end;
    //BC Upgrade GUNREM01 << Used in DIT action

    //BC Upgrade GUNREM01 >> DIT
    // procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
    // begin
    //     // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    //     DisabledRefreshLines := NewDisabledRefreshLines;
    // end;
    //BC Upgrade GUNREM01 << DIT
    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    //BC Upgrade SHARMP16--ProcessChanges BEGIN<<
    procedure ShowItemShippingLines()
    var
        TempPurchRcptLine: Record "Purch. Rcpt. Line" temporary;
        TempPostedWhseShptLine: Record "Posted Whse. Shipment Line" temporary;
    begin
        CASE rec.Type OF
            rec.Type::"G/L Account":
                BEGIN
                END;
            rec.Type::"Charge (Item)":
                BEGIN
                    GetPurchShippingPWShptLines(TempPostedWhseShptLine);
                    IF NOT TempPostedWhseShptLine.ISEMPTY THEN
                        PAGE.RUNMODAL(0, TempPostedWhseShptLine)
                    ELSE BEGIN
                        GetPurchShippingRcptLines(TempPurchRcptLine);
                        IF NOT TempPurchRcptLine.ISEMPTY THEN
                            PAGE.RUNMODAL(0, TempPurchRcptLine);
                    END;
                END;
        END;

    end;

    procedure GetPurchShippingRcptLines(VAR TempPurchRcptLine: Record "Purch. Rcpt. Line" temporary)
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ItemLedgEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
    begin
        TempPurchRcptLine.RESET;
        TempPurchRcptLine.DELETEALL;

        IF rec.Type <> rec.Type::"Charge (Item)" THEN
            EXIT;

        rec.FilterPstdDocLineValueEntries(ValueEntry);
        ValueEntry.SETFILTER("Item Charge No.", '<>%1', '');
        IF ValueEntry.FINDSET THEN
            REPEAT
                ItemLedgEntry.GET(ValueEntry."Item Ledger Entry No.");
                IF ItemLedgEntry."Document Type" = ItemLedgEntry."Document Type"::"Purchase Receipt" THEN
                    IF PurchRcptLine.GET(ItemLedgEntry."Document No.", ItemLedgEntry."Document Line No.") THEN BEGIN
                        IF NOT TempPurchRcptLine.GET(PurchRcptLine."Document No.", PurchRcptLine."Line No.") THEN BEGIN
                            TempPurchRcptLine.INIT;
                            TempPurchRcptLine := PurchRcptLine;
                            TempPurchRcptLine.INSERT;
                        END;
                    END;
            UNTIL ValueEntry.NEXT = 0;

    end;

    procedure GetPurchShippingPWShptLines(VAR TempPostedWhseShptLine: Record "Posted Whse. Shipment Line" temporary)

    var
        PostedWhseShptLine: Record "Posted Whse. Receipt Line";
        ItemLedgEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
    begin
        TempPostedWhseShptLine.RESET;
        TempPostedWhseShptLine.DELETEALL;

        IF Rec.Type <> Rec.Type::"Charge (Item)" THEN
            EXIT;

        PostedWhseShptLine.SETCURRENTKEY("Posted Source Document", "Posted Source No.");

        rec.FilterPstdDocLineValueEntries(ValueEntry);
        ValueEntry.SETFILTER("Item Charge No.", '<>%1', '');
        IF ValueEntry.FINDSET THEN
            REPEAT
                ItemLedgEntry.GET(ValueEntry."Item Ledger Entry No.");
                IF ItemLedgEntry."Document Type" = ItemLedgEntry."Document Type"::"Sales Shipment" THEN BEGIN
                    PostedWhseShptLine.SETRANGE("Posted Source Document", PostedWhseShptLine."Posted Source Document"::"Posted Shipment");
                    PostedWhseShptLine.SETRANGE("Posted Source No.", ItemLedgEntry."Document No.");
                    IF PostedWhseShptLine.FINDFIRST THEN BEGIN
                        IF NOT TempPostedWhseShptLine.GET(PostedWhseShptLine."No.", PostedWhseShptLine."Line No.") THEN BEGIN
                            TempPostedWhseShptLine.INIT;

                            TempPostedWhseShptLine.TransferFields(PostedWhseShptLine);

                            TempPostedWhseShptLine.INSERT;
                        END;
                    END;
                END;
            UNTIL ValueEntry.NEXT = 0;

    end;
    //BC Upgrade SHARMP16--ProcessChanges END>>
}

