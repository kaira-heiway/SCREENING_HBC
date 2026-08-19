pageextension 52015 PostedPurchaseInvLinesExtSTP extends "Posted Purchase Invoice Lines"
{
    // version NAVW110.0,DITW110.00.08,HEI.04,HEI.05

    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //       DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //       DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //       DITW15.00.00.21 DDR 08/07/2008 Bugfix refresh & show CExpandCollapse column
    //       DITW15.00.00.24 DDR 10/09/2008 Form Editable but all columns not editable except Collapse/Expand column
    //       DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                        Remove functions FormTotalingField()
    //                                        Rewrite functions UpdateFields(),FormTotalingField()
    //       DITW16.00.00.37 DDR 30/07/2010 DIT715 #1 RTC Page functionnalities & Nav SQL performances
    //                       DDR 30/07/2010           Remove OnFormat() field "No."
    //                       CEL 13/08/2010           Modification RTC buttons
    //                       DDR 18/08/2010 DIT717 #13 Added to keep open filters with expand-collapse (ShowAsTree in page)
    //       DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                                   Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //       DITW16.00.00.39 DDR 26/09/2011 DIT-715 #141 Added "Total Amount" column for all line types
    //       DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field Added after "Budgeted FA No." field
    //       DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    //       DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility

    //       DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //       HEI.01 CHG2090912 HB1641 IBM NANDIS01 01.02.2021 General Ledger Entries Description
    //         # Make visible of new field - "Additional Description"
    //       HEI.02 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //         # New Field added: "CAD Amount"
    //         # Code added on 'OnOpenPage' trigger
    //       HEI.03 FDD-HB2482 CHG2123206 IBM NANDIS01 03.11.2021 - Improvement of multiple HeiLite reports for StP  Procurement users
    //         # Shown new field - Purchase Order No.
    //       HEI.04 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //         # Added New Fields - Zycus Order No.
    //                            - Zycus Order Line No.
    //                            - Zycus PR Reference No.
    //                            - Zycus PO Type Code
    //                            - Zycus PO Line Type Code
    //                            - Zycus PO Line Validated
    //       HEI.05 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //         # Added New Field - Zycus Movement Type


    //BC Upgrade GUNREM01 >>
    //HEI.04 and HEI.05 fields added in interface
    //BC Upgrade GUNREM01 <<


    layout
    {

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number.', FRA = 'Spécifie le numéro du document.';

            //Unsupported feature: Change Editable on ""Document No."(Control 2)". Please convert manually.

        }
        modify("Buy-from Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor that you bought the items on the invoice from.', FRA = 'Indique le numéro du fournisseur auprès duquel vous avez acheté les articles de la facture.';

            //Unsupported feature: Change Editable on ""Buy-from Vendor No."(Control 4)". Please convert manually.

        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the line type.', FRA = 'Spécifie le type de ligne.';

            //Unsupported feature: Change Editable on "Type(Control 6)". Please convert manually.

        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies an item number that identifies the account number that identifies the general ledger account used when posting the line.', FRA = 'Spécifie un numéro d''article qui identifie le numéro de compte correspondant au compte général utilisé lors de la validation de la ligne.';

            //Unsupported feature: Change Editable on ""No."(Control 8)". Please convert manually.

        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant code for the item.', FRA = 'Spécifie le code variante pour l''article.';

            //Unsupported feature: Change Visible on ""Variant Code"(Control 10)". Please convert manually.


            //Unsupported feature: Change Editable on ""Variant Code"(Control 10)". Please convert manually.

        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies either the name of, or a description of, the item or general ledger account.', FRA = 'Spécifie soit le nom, soit une désignation du compte article ou général.';

            //Unsupported feature: Change Editable on "Description(Control 12)". Please convert manually.

        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension value associated with the invoice.', FRA = 'Spécifie le code de la section analytique associée à la facture.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 1 Code"(Control 14)". Please convert manually.

        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension value associated with the invoice.', FRA = 'Spécifie le code de la section analytique associée à la facture.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 2 Code"(Control 16)". Please convert manually.

        }
        modify("FA Posting Type")
        {
            ToolTipML = ENU = 'Specifies the FA posting type of the purchase invoice line.', FRA = 'Spécifie le type comptabilisation immobilisation de la ligne facture achat.';

            //Unsupported feature: Change Editable on ""FA Posting Type"(Control 20)". Please convert manually.

        }
        modify("Depreciation Book Code")
        {
            ToolTipML = ENU = 'Specifies the depreciation book code on the purchase invoice line.', FRA = 'Spécifie le code loi amortissement de la ligne facture achat.';

            //Unsupported feature: Change Editable on ""Depreciation Book Code"(Control 22)". Please convert manually.

        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the quantity posted from the line.', FRA = 'Spécifie la quantité validée à partir de la ligne.';

            //Unsupported feature: Change Editable on "Quantity(Control 24)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code for the item.', FRA = 'Spécifie le code unité de l''article.';

            //Unsupported feature: Change Editable on ""Unit of Measure Code"(Control 26)". Please convert manually.

        }
        modify("Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the unit of measure for the item (one bottle or one piece, for example).', FRA = 'Spécifie l''unité de mesure de l''article (par exemple, une bouteille ou une pièce).';

            //Unsupported feature: Change Editable on ""Unit of Measure"(Control 28)". Please convert manually.

        }
        modify("Direct Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the direct unit cost of one unit of the item.', FRA = 'Spécifie le coût unitaire d''achat d''une unité de l''article.';

            //Unsupported feature: Change AutoFormatType on ""Direct Unit Cost"(Control 30)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Direct Unit Cost"(Control 30)". Please convert manually.


            //Unsupported feature: Change Editable on ""Direct Unit Cost"(Control 30)". Please convert manually.

        }
        modify("Indirect Cost %")
        {
            ToolTipML = ENU = 'Specifies the item''s indirect cost, as a percentage.', FRA = 'Spécifie le coût indirect de l''article en tant que pourcentage.';

            //Unsupported feature: Change Editable on ""Indirect Cost %"(Control 32)". Please convert manually.

        }
        modify("Unit Cost (LCY)")
        {
            ToolTipML = ENU = 'Specifies the cost per unit.', FRA = 'Spécifie le coût par unité.';

            //Unsupported feature: Change Editable on ""Unit Cost (LCY)"(Control 34)". Please convert manually.

        }
        modify("Unit Price (LCY)")
        {
            ToolTipML = ENU = 'Specifies the price, in LCY, for one unit of the item.', FRA = 'Spécifie le prix unitaire, en DS, de l''article.';

            //Unsupported feature: Change Editable on ""Unit Price (LCY)"(Control 36)". Please convert manually.

        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the line''s net amount.', FRA = 'Spécifie le montant net de la ligne.';

            //Unsupported feature: Change AutoFormatType on "Amount(Control 38)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on "Amount(Control 38)". Please convert manually.


            //Unsupported feature: Change Editable on "Amount(Control 38)". Please convert manually.

        }
        modify("Amount Including VAT")
        {
            ToolTipML = ENU = 'Specifies the total, in the currency of the invoice, of the amount on the invoice line, including VAT.', FRA = 'Spécifie le total, dans la devise de la facture, du montant de la ligne facture (y compris la TVA).';

            //Unsupported feature: Change AutoFormatType on ""Amount Including VAT"(Control 40)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Amount Including VAT"(Control 40)". Please convert manually.


            //Unsupported feature: Change Editable on ""Amount Including VAT"(Control 40)". Please convert manually.

        }
        modify("Line Discount %")
        {
            ToolTipML = ENU = 'Specifies the line discount % granted on items on each individual line.', FRA = 'Spécifie le pourcentage de remise ligne accordé aux articles de chaque ligne.';

            //Unsupported feature: Change Editable on ""Line Discount %"(Control 42)". Please convert manually.

        }
        modify("Line Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the discount amount.', FRA = 'Spécifie le montant de la remise.';

            //Unsupported feature: Change Editable on ""Line Discount Amount"(Control 44)". Please convert manually.

        }
        modify("Allow Invoice Disc.")
        {
            ToolTipML = ENU = 'Specifies whether the invoice line could have been included in an invoice discount calculation.', FRA = 'Spécifie si la ligne facture aurait pu être incluse dans le calcul d''une remise sur facture.';

            //Unsupported feature: Change Editable on ""Allow Invoice Disc."(Control 46)". Please convert manually.

        }
        modify("Inv. Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the invoice discount amount for the line.', FRA = 'Spécifie le montant de la remise facture pour la ligne.';

            //Unsupported feature: Change Editable on ""Inv. Discount Amount"(Control 48)". Please convert manually.

        }
        modify("Appl.-to Item Entry")
        {
            ToolTipML = ENU = 'Specifies the number of a particular item entry to which the invoice line was applied when it was posted.', FRA = 'Spécifie le numéro d''une écriture article donnée avec laquelle la ligne facture a été lettrée lorsqu''elle a été validée.';

            //Unsupported feature: Change Editable on ""Appl.-to Item Entry"(Control 54)". Please convert manually.

        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'Specifies the number of the job that the purchase invoice line is linked to.', FRA = 'Spécifie le numéro du projet auquel la ligne facture achat est associée.';

            //Unsupported feature: Change Editable on ""Job No."(Control 56)". Please convert manually.

        }
        modify("Insurance No.")
        {
            ToolTipML = ENU = 'Specifies the insurance number on the purchase invoice line.', FRA = 'Spécifie le numéro d''assurance de la ligne facture achat.';

            //Unsupported feature: Change Editable on ""Insurance No."(Control 58)". Please convert manually.

        }
        modify("Depr. until FA Posting Date")
        {
            ToolTipML = ENU = 'Specifies whether depreciation was calculated until the FA posting date of the line. If the field contains a Yes or a check mark, depreciation was posted for the asset for the period from the FA posting date of the previous FA ledger entry to the FA posting date of this purchase line.', FRA = 'Indique si l''amortissement a été calculé jusqu''à la date comptabilisation immobilisation de la ligne. Si le champ est activé ou paramétré sur Oui, l''amortissement de l''immobilisation a été validé pour la période allant de la date comptabilisation immobilisation de l''écriture comptable immobilisation précédente à la date comptabilisation immobilisation de cette ligne achat.';

            //Unsupported feature: Change Editable on ""Depr. until FA Posting Date"(Control 60)". Please convert manually.

        }
        modify("Depr. Acquisition Cost")
        {
            ToolTipML = ENU = 'Specifies whether, when this line was posted, the additional acquisition cost posted on the line was depreciated in proportion to the amount by which the fixed asset had already been depreciated.', FRA = 'Indique si, lors de la validation de cette ligne, le coût d''acquisition supplémentaire validé sur cette ligne a été amorti proportionnellement au montant précédemment amorti.';

            //Unsupported feature: Change Editable on ""Depr. Acquisition Cost"(Control 62)". Please convert manually.

        }
        modify("Budgeted FA No.")
        {
            ToolTipML = ENU = 'Specifies the budgeted FA number on the purchase invoice line.', FRA = 'Spécifie le numéro d''immobilisation budgétée de la ligne facture achat.';

            //Unsupported feature: Change Editable on ""Budgeted FA No."(Control 64)". Please convert manually.

        }
        //BC Upgrade GUNREM01 >> DIT
        // addfirst(Control1)
        // {
        //     field("Has Item Charge"; "Has Item Charge")
        //     {
        //         BlankZero = true;
        //     }
        //     field(Collapse; Collapse)
        //     {
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW15.00.00.37 DDR 19/01/2010
        //             CurrPage.UPDATE(true);
        //             // >>DITW15.00.00.37 DDR
        //         end;
        //     }
        // }
        //BC Upgrade GUNREM01 << DIT
        addafter(Description)
        {
            field("Additional Description"; Rec."Additional Description FND")
            {
                ApplicationArea = all;
            }
        }
        addafter("Depreciation Book Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
            // field("Physical Location Group Code"; rec."Physical Location Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // } //BC upgrade GUNREM01 _DIT
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter(Quantity)
        {
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                ApplicationArea = All;
                Visible = EnableCAD;
            }
        } //BC Upgrade GUNREM01

        //BC upgrade GUNREM01 >> DIT
        // addafter(Amount)
        // {
        //     field(RTCTotalLine; GetTotalingLine(1, FIELDNO(Amount), true))
        //     {
        //         AutoFormatExpression = GetCurrencyCode;
        //         AutoFormatType = 1;
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassVar(PageText2014410);
        //         CaptionML = ENU = 'Total Amount',
        //                     FRA = 'Montant total';
        //         Description = 'DITW17.10.02B DIT-770 #541';
        //         Editable = false;
        //         QuickEntry = false;
        //     }
        // } //BC upgrade GUNREM01 << DIT
        addafter("Budgeted FA No.")
        {
            // field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
            // {
            // } //BC Upgrade GUNREM01 - fields already available in BC Base app
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = all;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = all;
            }
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = all;
            }
            // field("Unit Volume HL"; Rec."Unit Volume HL")
            // {
            // }//BC Upgrade GUNREM01 -DIT
            field("Blanket Order No."; Rec."Blanket Order No.")
            {
                ApplicationArea = all;
            }
            field("Blanket Order Line No."; Rec."Blanket Order Line No.")
            {
                ApplicationArea = all;
            }
            // field("Description 2"; Rec."Description 2")
            // {
            // } //BC Upgrade GUNREM01 - fields already available in BC Base app
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = all;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Purchase Order No."; Rec."Purchase Order No. FND")
            {
                ApplicationArea = all;
            }
            //BC Upgrade GUNREM01 << fields added in interface ext
            //     field("Zycus Order No."; "Zycus Order No.")
            //     {
            //         Visible = false;
            //     }
            //     field("Zycus Order Line No."; "Zycus Order Line No.")
            //     {
            //         Visible = false;
            //     }
            //     field("Zycus PR Reference No."; "Zycus PR Reference No.")
            //     {
            //         Visible = false;
            //     }
            //     field("Zycus PO Type Code"; "Zycus PO Type Code")
            //     {
            //         Visible = false;
            //     }
            //     field("Zycus PO Line Type Code"; "Zycus PO Line Type Code")
            //     {
            //         Visible = false;
            //     }
            //     field("Zycus PO Line Validated"; "Zycus PO Line Validated")
            //     {
            //         Visible = false;
            //     }
            //     field("Zycus Movement Type"; "Zycus Movement Type")
            //     {
            //         Visible = false;
            //     }
            // }
            //BC Upgrade GUNREM01 << fields added in interface ext
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify("Show Document")
        {
            CaptionML = ENU = 'Show Document', FRA = 'Afficher document';
            ToolTipML = ENU = 'Open the document that the selected line exists on.', FRA = 'Ouvrez le document sur lequel la ligne sélectionnée existe.';
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = '&Lignes traçabilité';
            ToolTipML = ENU = 'View or edit serial numbers and lot numbers that are assigned to the item on the document or journal line.', FRA = 'Affichez ou modifiez des numéros de série et de lot qui sont affectés à l''article sur le document ou la ligne feuille.';
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
        //BC Upgrade GUNREM01 << -DIT
        // addfirst("&Line")
        // {
        //     action("+ Expand")
        //     {
        //         CaptionML = ENU = '+ Expand',
        //                     FRA = '+ Développer';
        //         Enabled = (NOT ExpandLines);
        //         Image = ViewDetails;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;
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
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;
        //         Visible = ExpandLines OR ShowButtonsCE;

        //         trigger OnAction();
        //         begin
        //             // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        //             ExpandLines := GETFILTER("Attached to Line No.") <> '';
        //             CurrPage.UPDATE(true);
        //             // >>DITW17.10.03 DDR DIT-770 #541
        //         end;
        //     }
        // }
        //BC Upgrade GUNREM01 << -DIT
    }

    var
        TempRecOpenFilters: Record "Purch. Inv. Line" temporary;
        IsOpenPage: Boolean;
        PageText2014410: TextConst ENU = 'Total Amount', FRA = 'Montant total';
        // [InDataSet]
        ExpandLines: Boolean;
        // [InDataSet]
        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        GeneralLedgerSetup: Record "General Ledger Setup";
        EnableCAD: Boolean;

    trigger OnOpenPage()
    begin
        //HEI.02>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.02<<
    end;


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
    // <<DITW16.00.00.37 DIT-715 #1 - DDR DIT717 #13
    if IsOpenPage then begin
      COPY(TempRecOpenFilters);
      IsOpenPage := false;
    end;
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //EXIT(FIND(Which));
    exit(FindRecordDIT(Which,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    // >>DITW16.00.00.37 DIT-715 #13
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
    // >>DITW16.00.00.37 DIT-715 #1
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    // <<DITW16.00.00.37 DDR DIT717 #13
    TempRecOpenFilters.COPY(Rec);
    IsOpenPage := true;
    // >>DITW16.00.00.37 DDR DIT717 #13
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    ExpandLines := GETFILTER("Attached to Line No.") <> '';
    ShowButtonsCE := IsShowButtonsCEDIT();
    // >>DITW17.10.03 DDR DIT-770 #541

    //HEI.02>>
    GeneralLedgerSetup.GET;
    EnableCAD := GeneralLedgerSetup."Enable CAD";
    //HEI.02<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

