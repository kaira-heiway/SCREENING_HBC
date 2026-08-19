pageextension 53031 PostedSalesCreditMemoLinesExt extends "Posted Sales Credit Memo Lines"
{
    // version NAVW110.0,DITW110.00.08

    //     DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.21 DDR 08/07/2008 Bugfix refresh & show CExpandCollapse column
    // DITW15.00.00.24 DDR 10/09/2008 Form Editable but all columns not editable except Collapse/Expand column
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    // DITW16.00.00.37 DDR 30/07/2010 DIT715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                 CEL 13/08/2010           Modification RTC buttons
    //                 DDR 18/08/2010 DIT717 #13 Added to keep open filters with expand-collapse (ShowAsTree in page)
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    // DITW16.00.00.39 DDR 26/09/2011 DIT-715 #141 Added "Total Amount" column for all line types
    // DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field Added after "Job No." field
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    // HEI.01 FDD-HT709 IBM NASTAA02 24.07.2019 # Ethiopia Fiscal No in PSIL
    //   # New Field added "Maraki Fiscal No"
    // HEI.02 FDD-HB1111 IBM NASTAA02 26.02.2020 # Adding Fields to existing Tables - Sales Reports enhancements
    //   # New Fields added: "Return Reason Code", "Truck", "Driver", "Route", "Route Planning No.", "Sales Person Code", "Shipping Agent Code", "Shipping Agent Service Code"

    //Bc Upgrade YADAVM09 Drink it field and Action commented.
    //Bc Upgrade YADAVM09 "Maraki Fiscal No" field added in interface extension Page.
    layout
    {

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number.', FRA = 'Spécifie le numéro du document.';

            //Unsupported feature: Change Editable on ""Document No."(Control 2)". Please convert manually.

        }
        modify("Sell-to Customer No.")
        {
            ToolTipML = ENU = 'Specifies the customer that the credit memo was sent to.', FRA = 'Spécifie le client à qui l''avoir a été envoyé.';

            //Unsupported feature: Change Editable on ""Sell-to Customer No."(Control 4)". Please convert manually.

        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the line type.', FRA = 'Spécifie le type de ligne.';

            //Unsupported feature: Change Editable on "Type(Control 6)". Please convert manually.

        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies a general ledger account number or an item number that identifies the general ledger account or item specified when the line was posted.', FRA = 'Spécifie un numéro de compte général ou d''article qui identifie le compte général ou article spécifié lors de la validation de la ligne.';

            //Unsupported feature: Change Editable on ""No."(Control 8)". Please convert manually.

        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant number of the items sold.', FRA = 'Spécifie le code variante des articles vendus.';

            //Unsupported feature: Change Editable on ""Variant Code"(Control 10)". Please convert manually.

        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the name of the item or general ledger account, or some descriptive text.', FRA = 'Spécifie le nom de l''article ou du compte général, ou un texte descriptif.';

            //Unsupported feature: Change Editable on "Description(Control 12)". Please convert manually.

        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the credit memo.', FRA = 'Spécifie le code section analytique associé à l''avoir.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 1 Code"(Control 14)". Please convert manually.

        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the credit memo.', FRA = 'Spécifie le code section analytique associé à l''avoir.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 2 Code"(Control 16)". Please convert manually.

        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item specified on the line.', FRA = 'Spécifie le nombre d''unités de l''article sur la ligne spécifiée.';

            //Unsupported feature: Change Editable on "Quantity(Control 22)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code for the items sold.', FRA = 'Spécifie le code unité de l''article vendu.';

            //Unsupported feature: Change Editable on ""Unit of Measure Code"(Control 24)". Please convert manually.

        }
        modify("Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the unit of measure for the item (bottle or piece, for example).', FRA = 'Spécifie l''unité de mesure de l''article (par exemple une bouteille ou une pièce).';

            //Unsupported feature: Change Editable on ""Unit of Measure"(Control 26)". Please convert manually.

        }
        modify("Unit Price")
        {
            ToolTipML = ENU = 'Specifies the price of one unit of the item.', FRA = 'Spécifie le prix unitaire de l''article.';

            //Unsupported feature: Change AutoFormatType on ""Unit Price"(Control 28)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Unit Price"(Control 28)". Please convert manually.


            //Unsupported feature: Change Editable on ""Unit Price"(Control 28)". Please convert manually.

        }
        modify("Unit Cost (LCY)")
        {
            ToolTipML = ENU = 'Specifies the unit cost of the item on the line.', FRA = 'Spécifie le coût unitaire pour l''article sur la ligne.';

            //Unsupported feature: Change Editable on ""Unit Cost (LCY)"(Control 30)". Please convert manually.

        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the line''s net amount.', FRA = 'Spécifie le montant net de la ligne.';

            //Unsupported feature: Change AutoFormatType on "Amount(Control 32)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on "Amount(Control 32)". Please convert manually.


            //Unsupported feature: Change Editable on "Amount(Control 32)". Please convert manually.

        }
        modify("Amount Including VAT")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';

            //Unsupported feature: Change AutoFormatType on ""Amount Including VAT"(Control 34)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Amount Including VAT"(Control 34)". Please convert manually.


            //Unsupported feature: Change Editable on ""Amount Including VAT"(Control 34)". Please convert manually.

        }
        modify("Line Discount %")
        {
            ToolTipML = ENU = 'Specifies the line discount percentage that was given on the line.', FRA = 'Spécifie le pourcentage de remise ligne qui a été accordé sur la ligne.';

            //Unsupported feature: Change Editable on ""Line Discount %"(Control 36)". Please convert manually.

        }
        modify("Line Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of the discount given on the line.', FRA = 'Spécifie le montant de la remise accordée sur la ligne.';

            //Unsupported feature: Change Editable on ""Line Discount Amount"(Control 38)". Please convert manually.

        }
        modify("Allow Invoice Disc.")
        {
            ToolTipML = ENU = 'Specifies whether the credit memo line could have included a possible invoice discount calculation.', FRA = 'Spécifie si l''avoir aurait pu inclure un calcul de remise sur facture.';

            //Unsupported feature: Change Editable on ""Allow Invoice Disc."(Control 40)". Please convert manually.

        }
        modify("Inv. Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the invoice discount amount calculated on the line.', FRA = 'Spécifie le montant de la remise facture calculée sur la ligne.';

            //Unsupported feature: Change Editable on ""Inv. Discount Amount"(Control 42)". Please convert manually.

        }
        modify("Appl.-to Item Entry")
        {
            ToolTipML = ENU = 'Specifies the number of the item ledger entry this credit memo was applied to.', FRA = 'Spécifie le numéro de l''écriture comptable article avec laquelle cet avoir a été lettré.';

            //Unsupported feature: Change Editable on ""Appl.-to Item Entry"(Control 48)". Please convert manually.

        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'Specifies the job number that the sales line is linked to.', FRA = 'Spécifie le numéro de la tâche à laquelle la ligne vente est liée.';

            //Unsupported feature: Change Editable on ""Job No."(Control 50)". Please convert manually.

        }
        //Bc Upgrade YADAVM09 Drink it Field>>
        // addfirst(Control1)
        // {
        //     // field("Has Item Charge"; Rec."Has Item Charge")
        //     // {
        //     //     BlankZero = true;
        //     // } 
        //     field(Collapse; Rec.Collapse)
        //     {
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW15.00.00.37 DDR 19/01/2010
        //             CurrPage.UPDATE(true);
        //             // >>DITW15.00.00.37 DDR
        //         end;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it Field<<
        addafter("Shortcut Dimension 2 Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = ALL;//Bc Upgrade YADAVM09
            }
            field("Return Reason Code"; Rec."Return Reason Code")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09
            }
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }//Bc Upgrade YADAVM09 Drink it field<<
            field("Location Code"; Rec."Location Code")
            {
                Editable = false;
                ApplicationArea = All;//Bc Upgrade YADAVM09
            }
        }
        // addafter(Amount)
        // {
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
        // }//Bc Upgrade YADAVM09 Drink it Field<<
        addafter("Job No.")
        {

            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09
            }
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09
            }
            // field("Unit Volume HL"; Rec."Unit Volume HL")
            // {
            // }//Bc Upgrade Drink it Field<<
            field("Blanket Order No."; Rec."Blanket Order No.")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09
            }
            field("Blanket Order Line No."; Rec."Blanket Order Line No.")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09
            }

            // field("External Document No."; Rec."External Document No.")
            // {
            // } //Bc Upgrade YADAVM09 Drink it field<<
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09
            }
            field("Line No."; Rec."Line No.")
            {
                Visible = false;
                ApplicationArea = ALL;//Bc Upgrade YADAVM09
            }
            // field("Free Reason Code"; Rec."Free Reason Code")
            // {
            // } //Bc Upgrade YADAVM09 Drink it field<<
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09
            }

            field("Shipping Agent Code"; Rec."Shipping Agent Code FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09
            }
            field("Shipping Agent Service Code"; Rec."Shipping Agent Service Cod FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09
            }
            // field(Truck; SalesCrMemoHeader."Truck Code")
            // {
            //     Description = 'HEI.02';
            // }
            // field(Driver; SalesCrMemoHeader."Driver Code")
            // {
            //     Description = 'HEI.02';
            // }
            // field(Route; SalesCrMemoHeader.Route)
            // {
            //     Description = 'HEI.02';
            // }
            // field("Route Planning No."; SalesCrMemoHeader."Route Planning No.")
            // {
            //     Description = 'HEI.02';
            // }//Bc Upgrade YADAVM09 Drink it field<<
            field("Salesperson Code"; SalesCrMemoHeader."Salesperson Code")
            {
                Description = 'HEI.02';
                ApplicationArea = All;
            }
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
        // }//Bc Upgrade YADAVM09 Drink it Action<<
    }

    var
        TempRecOpenFilters: Record "Sales Cr.Memo Line" temporary;
        IsOpenPage: Boolean;
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        ExpandLines: Boolean;
        ShowButtonsCE: Boolean;
        IndentLine: Integer;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    trigger OnAfterGetRecord();

    begin

        SalesCrMemoHeader.GET(Rec."Document No."); //HEI.02

    end;


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
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";//Bc Upgrade YADAVM09

}

