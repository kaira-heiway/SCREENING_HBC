pageextension 53028 PostedSalesShipmentLinesExt extends "Posted Sales Shipment Lines"
{
    // version NAVW110.0,DITW110.00.09

    //     DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.21 DDR 08/07/2008 Bugfix refresh & show CExpandCollapse column
    // DITW15.00.00.24 DDR 10/09/2008 Form Editable but all columns not editable except Collapse/Expand column
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                 CEL 13/08/2010           Modification RTC buttons
    //                 DDR 18/08/2010 DIT717 #13 Added to keep open filters with expand-collapse (ShowAsTree in page)
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //                                         !!  Added IndentationColumnName property value = ActualExpansionStatusInt
    // DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field Added after "Quantity Invoiced" field
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added field "Responsibity Center","Physical Location Group Code"
    // DITW18.00.07 AKH 16/05/2016 DIT-770 #1346 Added fields Cubage,Weight & "Delivery Time (sec.)"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 22/03/2017 NRQ#9661 Add EMCS fields
    //                                       Tiny NAV look&feel
    // DITW110.00.09 DDR 29/03/2017 NRQ#9661 Add "Correction" fields

    // HEI.01 FDD-HB1111 IBM NASTAA02 26.02.2020 # Adding Fields to existing Tables - Sales Reports enhancements
    //   # New Field added: "Requested Delivery Date"


    //Bc Upgrade YADAVM09 Migrated.
    //Bc upgrade YADAVM09 Drink it fields and Actions Blocked.

    layout
    {

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the shipment number.', FRA = 'Spécifie le numéro d''expédition.';
        }
        modify("Sell-to Customer No.")
        {
            ToolTipML = ENU = 'Specifies the number of the customer the items were shipped to.', FRA = 'Spécifie le numéro du client auquel les articles ont été expédiés.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the line type.', FRA = 'Spécifie le type de ligne.';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account or item number that identifies the general ledger account or item specified on the line.', FRA = 'Spécifie le numéro de compte général ou d''article qui identifie le compte général ou article spécifié lors de la validation sur la ligne.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant number of the items sold.', FRA = 'Spécifie le code variante des articles vendus.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the name of the item or general ledger account, or some descriptive text.', FRA = 'Spécifie le nom de l''article ou du compte général, ou un texte descriptif.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the sales line.', FRA = 'Spécifie le code section analytique associée à la ligne vente.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the sales line.', FRA = 'Spécifie le code section analytique associée à la ligne vente.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code for the location of the item on the shipment line which was posted.', FRA = 'Spécifie le code du magasin de l''article de la ligne expédition qui a été validée.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item specified on the line.', FRA = 'Spécifie le nombre d''unités de l''article sur la ligne spécifiée.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code for the items sold.', FRA = 'Spécifie le code unité de l''article vendu.';
        }
        modify("Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the unit of measure for the item (bottle or piece, for example).', FRA = 'Spécifie l''unité de mesure de l''article (par exemple une bouteille ou une pièce).';
        }
        modify("Appl.-to Item Entry")
        {
            ToolTipML = ENU = 'Specifies the number of the item ledger entry that the items were applied to when the shipment was posted.', FRA = 'Spécifie le numéro de l''écriture comptable article avec laquelle les articles ont été lettrés lorsque l''expédition a été validée.';
        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'Specifies the job number corresponding to the sales invoice or credit memo.', FRA = 'Spécifie le numéro de projet correspondant à la facture vente ou à l''avoir.';
        }
        modify("Shipment Date")
        {
            ToolTipML = ENU = 'Specifies the date the items were shipped.', FRA = 'Spécifie la date d''expédition prévue des articles.';
        }
        modify("Quantity Invoiced")
        {
            ToolTipML = ENU = 'Specifies how much of the line has been invoiced.', FRA = 'Spécifie ce qui, dans la ligne, a été facturé.';
        }

        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 18)". Please convert manually.

        addfirst(Control1)
        {
            // field("Has Item Charge"; Rec."Has Item Charge")
            // {
            //     BlankZero = true;
            // }//Bc Upgrade YADAVM09 Drink it field
            field("Line No."; Rec."Line No.")
            {
                Visible = false;
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            // field(Collapse; Rec.Collapse)
            // {
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW15.00.00.37 DDR 19/01/2010
            //         CurrPage.UPDATE(true);
            //         // >>DITW15.00.00.37 DDR
            //     end;
            //}//Bc Upgrade YADAVM09 Drink it field<<
        }
        // addafter("Sell-to Customer No.")
        // {
        //     field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
        //     {
        //         Visible = false;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it field<<
        // addafter(Description)
        // {
        //     field("Description 2"; Rec."Description 2")
        //     {
        //         Visible = false;
        //     }
        // }//Bc Upgrade YADAVM09 field is already defined in Base App
        addafter("Shortcut Dimension 2 Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                Visible = false;
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Visible = false;
            // }//Bc Upgrade YADAVM09 Drink it field<<
        }
        addafter("Quantity Invoiced")
        {
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            // field("Line Amount"; Rec."Line Amount")
            // {
            // }//Bc Upgrade YADAVM09 Drink it field<<
            // field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), true))
            // {
            //     AutoFormatExpression = GetCurrencyCode;
            //     AutoFormatType = 1;
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassVar(PageText2014410);
            //     CaptionML = ENU = 'Total Line Amount',
            //                 FRA = 'Montant total ligne';
            //     Description = 'DITW17.10.02B DIT-770 #541';
            //     QuickEntry = false;
            // }//Bc Upgrade YADAVM09 dependency on Drink it field<<
            field("Currency Code"; Rec."Currency Code")
            {
                Visible = false;
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            // field("Unit Volume HL"; Rec."Unit Volume HL")
            // {
            //     Visible = false;
            // }//Bc Upgrade YADAVM09 Drink it field<<
            field("Blanket Order No."; Rec."Blanket Order No.")
            {
                Visible = false;
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            field("Blanket Order Line No."; Rec."Blanket Order Line No.")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
            {
                Visible = false;
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            field("Unit Price"; Rec."Unit Price")
            {
                Visible = false;
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            // field("External Document No."; Rec."External Document No.")
            // {
            //     Visible = false;
            // }//Bc Upgrade YADAVM09 Drink it field<<
            field("Posting Date"; Rec."Posting Date")
            {
                Visible = false;
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            // field(Weight; Rec.Weight)
            // {
            //     Visible = false;
            // }
            // field(Cubage; Rec.Cubage)
            // {
            //     Visible = false;
            // }
            // field("Delivery Time (sec.)"; Rec."Delivery Time (sec.)")
            // {
            //     CaptionML = ENU = 'Delivery Time (sec.) (exp)',
            //                 FRA = 'Temps de livraison (sec.) (prév)';
            //     Visible = false;
            // }//Bc Upgrade YADAVM09 Drink it field<<
            field("Order No."; Rec."Order No.")
            {
                Visible = false;
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            field("Order Line No."; Rec."Order Line No.")
            {
                Visible = false;
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            // field("Due Tax"; Rec."Due Tax")
            // {
            //     Visible = false;
            // }
            // field("Duty Suspended"; Rec."Duty Suspended")
            // {
            //     Visible = false;
            // }
            // field("Company Tax Registration No."; Rec."Company Tax Registration No.")
            // {
            //     Visible = false;
            // }
            // field("Company Tax Warehouse Ref."; Rec."Company Tax Warehouse Ref.")
            // {
            //     Visible = false;
            // }
            // field("Customer DTax Group Code"; Rec."Customer DTax Group Code")
            // {
            //     Visible = false;
            // }
            // field("Tariff No."; Rec."Tariff No.")
            // {
            //     Visible = false;
            // }
            // field("Free Item"; Rec."Free Item")
            // {
            //     Visible = false;
            // }
            // field("Tax Item No."; Rec."Tax Item No.")
            // {
            //     Visible = false;
            // }
            // field("LRN No. Series"; Rec."LRN No. Series")
            // {
            //     Visible = false;
            // }
            // field("LRN No."; Rec."LRN No.")
            // {
            //     Visible = false;
            // }
            // field("ARC No."; Rec."ARC No.")
            // {
            //     Visible = false;
            // }
            // field("SAD No."; Rec."SAD No.")
            // {
            //     Visible = false;
            // }
            // field("Product Tax Code"; Rec."Product Tax Code")
            // {
            //     Visible = false;
            // }
            // field("ARC No. Mandatory"; Rec."ARC No. Mandatory")
            // {
            //     Visible = false;
            // }
            // field("Cancellation Reason Type"; Rec."Cancellation Reason Type")
            // {
            //     Visible = false;
            // }
            // field("Cancellation Reason Comment"; Rec."Cancellation Reason Comment")
            // {
            //     Visible = false;
            // }
            // field("Packaging Type Code"; Rec."Packaging Type Code")
            // {
            //     Visible = false;
            // }
            // field("No. of Packages"; Rec."No. of Packages")
            // {
            //     Visible = false;
            // }
            // field("Commercial Seal ID"; Rec."Commercial Seal ID")
            // {
            //     Visible = false;
            // }//Bc Upgrade YADAVM09 Drink it field<<
            field(Correction; Rec.Correction)
            {
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            // field("Truck Code"; Rec."Truck Code")
            // {
            //     Visible = false;
            // }
            // field("Driver Code"; Rec."Driver Code")
            // {
            //     Visible = false;
            // }//Bc Upgrade YADAVM09 Drink it field<<
            field("Planned Shipment Date"; Rec."Planned Shipment Date")
            {
                Visible = false;
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            field("Requested Delivery Date"; Rec."Requested Delivery Date")
            {
                Description = 'HEI.01';
                ApplicationArea = all;//Bc Upgrade YADAVM09
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
        TempRecOpenFilters: Record "Sales Shipment Line" temporary;
        IsOpenPage: Boolean;
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        ExpandLines: Boolean;
        ShowButtonsCE: Boolean;
        IndentLine: Integer;


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
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

