pageextension 52014 PostedPurchReciptLinesExtSTP extends "Posted Purchase Receipt Lines"
{
    // version NAVW110.0,DITW110.00.08,HEI.03,HEI.04
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.21 DDR 13/06/2008 Added Columns "Weight","Cubage"
    //   DITW15.00.00.21 DDR 08/07/2008 Bugfix refresh & show CExpandCollapse column
    //   DITW15.00.00.24 DDR 10/09/2008 Form Editable but all columns not editable except Collapse/Expand column
    //   DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                    Remove functions FormTotalingField()
    //                                    Rewrite functions UpdateFields(),FormTotalingField()
    //   DITW16.00.00.37 DDR 30/07/2010 DIT715 #1 RTC Page functionnalities & Nav SQL performances
    //                   DDR 30/07/2010           Remove OnFormat() field "No."
    //                   CEL 13/08/2010           Modification RTC buttons
    //                   DDR 18/08/2010 DIT717 #13 Added to keep open filters with expand-collapse (ShowAsTree in page)
    //   DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                               Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //                                           !!  Added IndentationColumnName property value = ActualExpansionStatusInt
    //   DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field Added after "Cubage" field
    //   DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added field "Responsibity Center","Physical Location Group Code"
    //   DITW18.00.07 AKH 16/05/2016 DIT-770 #1346 Added field "Delivery Time (sec.)"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.01 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //     # New Field added: "CAD Amount"
    //     # Code added on 'OnOpenPage' trigger
    //   HEI.02 CHG2207454 FDD-3487 IBM MAJUMS03 23.06.2023 # Add columns to Posted Purchase Receipt Lines Report
    //     # Fields added - "Order No."(Field ID. 65), "Order Line No."(Field ID. 66) and "Posting Date"(Field ID. 131).
    //   HEI.03 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //     # Added New Fields - Zycus Order No.
    //                        - Zycus Order Line No.
    //                        - Zycus PR Reference No.
    //                        - Zycus PO Type Code
    //                        - Zycus PO Line Type Code
    //                        - Zycus PO Line Validated
    //   HEI.04 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //     # Added New Field - Zycus Movement Type

    //BC Upgrade GUNREM01 >>
    //HEI.03 and HEI.04 Fields added in Interface Ext
    //BC Upgrade GUNREM01 <<

    layout
    {

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the receipt number.', FRA = 'Spécifie le numéro de réception.';

            //Unsupported feature: Change Editable on ""Document No."(Control 2)". Please convert manually.

        }
        modify("Buy-from Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor that you bought the items from.', FRA = 'Indique le numéro du fournisseur auprès duquel vous avez acheté les articles.';

            //Unsupported feature: Change Editable on ""Buy-from Vendor No."(Control 4)". Please convert manually.

        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the line type.', FRA = 'Spécifie le type de ligne.';

            //Unsupported feature: Change Editable on "Type(Control 6)". Please convert manually.

        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies an item number that identifies the item or a general ledger account number for the general ledger account used when posting.', FRA = 'Spécifie un numéro d''article qui identifie l''article ou le numéro du compte général pour le compte général utilisé pour la validation.';

            //Unsupported feature: Change Editable on ""No."(Control 8)". Please convert manually.

        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant code for the item.', FRA = 'Spécifie le code variante pour l''article.';

            //Unsupported feature: Change Editable on ""Variant Code"(Control 10)". Please convert manually.

        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies either the name of or a description of the item or general ledger account.', FRA = 'Spécifie soit le nom, soit une description de l''article ou du compte général.';

            //Unsupported feature: Change Editable on "Description(Control 12)". Please convert manually.

        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension value associated with the receipt.', FRA = 'Spécifie le code de la section analytique associée à la réception.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 1 Code"(Control 14)". Please convert manually.

        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension value associated with the receipt.', FRA = 'Spécifie le code de la section analytique associée à la réception.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 2 Code"(Control 16)". Please convert manually.

        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code for the location where the receipt line is registered.', FRA = 'Spécifie le code du magasin où la ligne réception est enregistrée.';

            //Unsupported feature: Change Editable on ""Location Code"(Control 18)". Please convert manually.

        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item specified on the line.', FRA = 'Spécifie le nombre d''unités de l''article sur la ligne spécifiée.';

            //Unsupported feature: Change Editable on "Quantity(Control 22)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code for the item.', FRA = 'Spécifie le code unité de l''article.';

            //Unsupported feature: Change Editable on ""Unit of Measure Code"(Control 24)". Please convert manually.

        }
        modify("Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the unit of measure for the item (bottle or piece, for example).', FRA = 'Spécifie l''unité de mesure de l''article (par exemple une bouteille ou une pièce).';

            //Unsupported feature: Change Editable on ""Unit of Measure"(Control 26)". Please convert manually.

        }
        modify("Appl.-to Item Entry")
        {
            ToolTipML = ENU = 'Specifies the number of the item ledger entry that the items were applied to when the receipt was posted.', FRA = 'Spécifie le numéro de l''écriture comptable article avec laquelle les articles ont été lettrés lorsque la réception a été validée.';

            //Unsupported feature: Change Editable on ""Appl.-to Item Entry"(Control 32)". Please convert manually.

        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'Specifies the job number corresponding to the purchase document (quote, order, invoice, or credit memo).', FRA = 'Spécifie le numéro du projet correspondant au document achat (demande de prix, commande, facture ou avoir).';

            //Unsupported feature: Change Editable on ""Job No."(Control 34)". Please convert manually.

        }
        modify("Prod. Order No.")
        {
            ToolTipML = ENU = 'Specifies the production order number.', FRA = 'Spécifie le numéro de commande de production.';

            //Unsupported feature: Change Editable on ""Prod. Order No."(Control 36)". Please convert manually.

        }
        modify("Expected Receipt Date")
        {
            ToolTipML = ENU = 'Specifies the date the items were expected.', FRA = 'Spécifie la date de réception prévue des articles.';

            //Unsupported feature: Change Editable on ""Expected Receipt Date"(Control 38)". Please convert manually.

        }
        modify("Quantity Invoiced")
        {
            ToolTipML = ENU = 'Specifies how much of the line has been invoiced.', FRA = 'Spécifie ce qui, dans la ligne, a été facturé.';

            //Unsupported feature: Change Editable on ""Quantity Invoiced"(Control 40)". Please convert manually.

        }

        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 18)". Please convert manually.

        //BC Upgrade GUNREM01 >> -DIT 
        // addfirst(Control1)
        // {
        //     field("Has Item Charge";"Has Item Charge")
        //     {
        //         BlankZero = true;
        //     }
        //     field(Collapse;Collapse)
        //     {
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW15.00.00.37 DDR 19/01/2010
        //             CurrPage.UPDATE(true);
        //             // >>DITW15.00.00.37 DDR
        //         end;
        //     }
        // } //BC Upgrade GUNREM01 << -DIT 
        addafter("Shortcut Dimension 2 Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = all;
            }
            // field("Physical Location Group Code"; rec."Physical Location Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // } //BC Upgrade GUNREM01 -DIT
        }
        addafter(Quantity)
        {
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                ApplicationArea = All;
                Visible = EnableCAD;
            }
        } //BC Upgrade GUNREM01 
        addafter("Quantity Invoiced")
        {
            //BC Upgrade GUNREM01 >> -DIT
            // field(Weight; Weight)
            // {
            //     Editable = false;
            // }
            // field(Cubage; Cubage)
            // {
            //     Editable = false;
            // }
            // field("Delivery Time (sec.)"; Rec."Delivery Time (sec.)")
            // {
            //     CaptionML = ENU = 'Delivery Time (sec.) (exp)',
            //                 FRA = 'Temps de livraison (sec.) (prév)';
            // }
            // field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
            // {
            // } //BC Upgrade GUNREM01 << -DIT
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
            // field("Line Amount"; Rec."Line Amount")
            // {
            // } //BC Upgrade GUNREM01 -DIT
            // field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), true))
            // {
            //     AutoFormatExpression = GetCurrencyCodeFromHeader;
            //     AutoFormatType = 1;
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassVar(PageText2014410);
            //     CaptionML = ENU = 'Total Line Amount',
            //                 FRA = 'Montant total ligne';
            //     Description = 'DITW17.10.02B DIT-770 #541';
            //     Editable = false;
            //     QuickEntry = false;
            // } //BC Upgrade GUNREM01 -DIT
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = all;
            }
            // field("Unit Volume HL"; rec."Unit Volume HL")
            // {
            // } //BC Upgrade GUNREM01 -DIT
            field("Blanket Order No."; rec."Blanket Order No.")
            {
                ApplicationArea = all;
            }
            field("Blanket Order Line No."; Rec."Blanket Order Line No.")
            {
                ApplicationArea = all;
            }
            // field("Description 2";Rec. "Description 2")
            // {
            // } //BC Upgrade GUNREM01 already available in BC Base extension
            field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
            {
                ApplicationArea = all;
            }
            field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
            {
                ApplicationArea = all;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            // field("Order No."; Rec."Order No.")
            // {
            // } //BC Upgrade GUNREM01 already available in BC Base extension
            field("Order Line No."; Rec."Order Line No.")
            {
                ApplicationArea = all;
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = all;
            }
            //BC Upgrade GUNREM01 >> fields added in Interface
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
            //BC Upgrade GUNREM01<<  fields added in Interface
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
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = '&Lignes traçabilité';
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
        //bC Upgrade GUNREM01 >> DIT
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
        //BC Upgrade GUNREM01 << DIT
    }

    var
        TempRecOpenFilters: Record "Purch. Rcpt. Line" temporary;
        IsOpenPage: Boolean;
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        // [InDataSet]
        ExpandLines: Boolean;
        // [InDataSet]
        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        GeneralLedgerSetup: Record "General Ledger Setup";
        EnableCAD: Boolean;

    trigger OnOpenPage()
    begin
        //HEI.01>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.01<<
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

    //HEI.01>>
    GeneralLedgerSetup.GET;
    EnableCAD := GeneralLedgerSetup."Enable CAD";
    //HEI.01<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

