pageextension 53034 GetPostDocSInvLnSubformExt extends "Get Post.Doc - S.InvLn Subform"
{
    // version NAVW110.0,DITW110.00.08,HEI.01
    //  DITW15.00.00.01 DDR 02/01/2008 Added column "Line No." (not editable)
    //                                  property Editable Form = yes (but all fields are non editable except Collapse button)
    //   DITW15.00.00.01 DDR 15/01/2007 Added property Form InsertAllowed,ModifyAllowed,DeleteAllowed=No
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules: Remove function UpdateFormatField()
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.21 DDR 08/07/2008 Bugfix refresh & show CExpandCollapse column
    //   DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                    Added parmater et return value for function ReadExpansionStatus()
    //                                    Remove functions FormTotalingField()
    //                                    Rewrite functions UpdateFields(),FormTotalingField()
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                   DDR 30/07/2010           Remove OnFormat() field "No."
    //                   CEL 13/08/2010           Modification RTC buttons
    //   DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                               Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //                       04/08/2011 DIT-715 #141 RTC Upgrade Added/Review Total Line Amount (Collapsed RTC)
    //                                                           Added columns TotalLineAmount
    //                       26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.02 CHG2009225 IBM ISYED01 5/20/2019 # Reduce labor intensive entries in 1day returns process-FDD
    //    # New filed Created - "Qty to receive"
    //    # "Qty to receive" field to visible only for posted Invoice document.
    //   HEI.03 Defect #4370 IBM NASTAA02 06.09.2019 # Issue in return proces _ see also BRD_CHG2009225_Reduce labor intensive entries in 1day returns process _V4_HB531
    //     # Made Field "Qty. Not Returned" non editable

    //***************************************************//
    //BC UPGRADE SIVA 
    //1.HEI.02  Qty to receive not found in the page extention & table ext.
    //2 HEI.03  Made Field "Qty. Not Returned" non editable

    layout
    {

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the invoice number.', FRA = 'Spécifie le numéro de facture.';
        }
        modify("SalesInvHeader.""Posting Date""")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
            ToolTipML = ENU = 'Specifies the posting date of the record.', FRA = 'Spécifie la date comptabilisation de l''enregistrement.';
        }
        modify("Shipment Date")
        {
            ToolTipML = ENU = 'Copies the date for this field from the Shipment Date field on the sales line, which is used for planning purposes.', FRA = 'Copie la date de ce champ dans le champ Date de préparation de la ligne vente, qui est utilisé à des fins de planification.';
        }
        modify("Bill-to Customer No.")
        {
            ToolTipML = ENU = 'Specifies the number of the customer who paid you for the items.', FRA = 'Spécifie le numéro du client qui vous a réglé les articles.';
        }
        modify("Sell-to Customer No.")
        {
            ToolTipML = ENU = 'Specifies the number of the customer the invoice was sent to.', FRA = 'Spécifie le numéro du client auquel vous avez envoyé la facture.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the line type.', FRA = 'Spécifie le type de ligne.';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of a general ledger account, item, resource, additional cost, or fixed asset, depending on the contents of the Type field.', FRA = 'Spécifie le numéro d''un compte général, d''un article, d''une ressource, d''un coût supplémentaire ou d''une immobilisation, selon ce que vous avez sélectionné dans le champ Type.';
        }
        //BC UPGRADE SIVA >> Field Removed BC Base app
        // modify("Cross-Reference No.")
        // {
        //     ToolTipML = ENU = 'Specifies the cross-reference number of the item specified on the line.', FRA = 'Spécifie le numéro de référence externe de l''article sur la ligne spécifiée.';
        // }
        //BC UPGRADE SIVA << Field Removed BC Base app
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant number of the items sold.', FRA = 'Spécifie le code variante des articles vendus.';
        }
        modify(Nonstock)
        {
            ToolTipML = ENU = 'Specifies that this item is a nonstock item.', FRA = 'Spécifie que cet article est non stocké.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the name of the item or general ledger account, or some descriptive text.', FRA = 'Spécifie le nom de l''article ou du compte général, ou un texte descriptif.';
        }
        modify("Return Reason Code")
        {
            ToolTipML = ENU = 'Specifies a code that explains why the item is returned.', FRA = 'Spécifie un code expliquant la raison du renvoi de l''article.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location in which the invoice line was registered.', FRA = 'Indique le magasin dans lequel la ligne facture a été enregistrée.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the code of the bin from which the items were sold.', FRA = 'Indique le code emplacement à partir duquel les articles ont été vendus.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the invoice.', FRA = 'Spécifie le code section analytique associé à la facture.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the invoice.', FRA = 'Spécifie le code section analytique associé à la facture.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code for the items sold.', FRA = 'Spécifie le code unité de l''article vendu.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item specified on the line.', FRA = 'Spécifie le nombre d''unités de l''article sur la ligne spécifiée.';
        }
        modify(QtyNotReturned)
        {
            Editable = false;
            CaptionML = ENU = 'Qty. Not Returned', FRA = 'Qté non retournée';
            ToolTipML = ENU = 'Specifies the quantity from the posted document line that has been shipped to the customer and not returned by the customer.', FRA = 'Spécifie la quantité de la ligne document validée qui a été expédiée au client et n''a pas été retournée par ce dernier.';

            //Unsupported feature: Change Editable on "QtyNotReturned(Control 44)". Please convert manually.

        }
        // modify(CalcQtyReturned)
        // {
        //     CaptionML = ENU = 'Qty. Returned', FRA = 'Qté retournée';
        //     ToolTipML = ENU = 'Specifies the quantity that was returned.', FRA = 'Spécifie la quantité qui a été retournée.';
        // }
        modify("Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the unit of measure for the item (bottle or piece, for example).', FRA = 'Spécifie l''unité de mesure de l''article (par exemple une bouteille ou une pièce).';
        }
        modify("Unit Cost (LCY)")
        {
            ToolTipML = ENU = 'Specifies the unit cost of the item on the invoice line.', FRA = 'Spécifie le coût unitaire pour l''article sur la ligne facture.';
        }
        modify(RevUnitCostLCY)
        {
            CaptionML = ENU = 'Reverse Unit Cost (LCY)', FRA = 'Contrepasser coût unitaire DS';
            ToolTipML = ENU = 'Specifies the unit cost that will appear on the new document lines.', FRA = 'Indique le coût unitaire qui s''affiche sur les nouvelles lignes du document.';
        }
        modify(UnitPrice)
        {
            CaptionML = ENU = 'Unit Price', FRA = 'Prix unitaire';

            //Unsupported feature: Change AutoFormatType on "UnitPrice(Control 80)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on "UnitPrice(Control 80)". Please convert manually.

        }
        modify(LineAmount)
        {
            CaptionML = ENU = 'Line Amount', FRA = 'Montant ligne';
            ToolTipML = ENU = 'Specifies the amount on the line.', FRA = 'Spécifie le montant sur la ligne.';

            //Unsupported feature: Change AutoFormatType on "LineAmount(Control 76)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on "LineAmount(Control 76)". Please convert manually.

        }
        modify("SalesInvHeader.""Currency Code""")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("SalesInvHeader.""Prices Including VAT""")
        {
            CaptionML = ENU = 'Prices Including VAT', FRA = 'Prix TTC';
        }
        modify("Line Discount %")
        {
            ToolTipML = ENU = 'Specifies the line discount % that was given on the line.', FRA = 'Spécifie le pourcentage de remise ligne qui a été accordé sur la ligne.';
        }
        modify("Line Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of the discount given on the line.', FRA = 'Spécifie le montant de la remise accordée sur la ligne.';

            //Unsupported feature: Change AutoFormatType on ""Line Discount Amount"(Control 52)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Line Discount Amount"(Control 52)". Please convert manually.

        }
        modify("Allow Invoice Disc.")
        {
            ToolTipML = ENU = 'Specifies whether the invoice line could have been included in a possible invoice discount calculation.', FRA = 'Spécifie si la ligne facture aurait pu être incluse dans le calcul d''une remise sur facture.';
        }
        modify("Inv. Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the invoice discount amount calculated on the line.', FRA = 'Spécifie le montant de la remise facture calculée sur la ligne.';
        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'Specifies the job number that the sales invoice line is linked to.', FRA = 'Spécifie le numéro de la tâche à laquelle la ligne facture vente est liée.';
        }
        modify("Blanket Order No.")
        {
            ToolTipML = ENU = 'Specifies the number of the blanket order that the invoice originates from.', FRA = 'Spécifie le numéro de la commande ouverte d''où provient la facture.';
        }
        modify("Blanket Order Line No.")
        {
            ToolTipML = ENU = 'Specifies the number of the blanket order line that the invoice line originates from.', FRA = 'Spécifie le numéro de la ligne de la commande ouverte d''où provient la ligne facture.';
        }
        modify("Appl.-from Item Entry")
        {
            ToolTipML = ENU = 'Specifies the number of the item ledger entry that the sales invoice line is applied from.', FRA = 'Spécifie le numéro de l''écriture comptable article à partir de laquelle la ligne facture vente est lettrée.';
        }
        modify("Appl.-to Item Entry")
        {
            ToolTipML = ENU = 'Specifies the number of the item ledger entry this invoice line was applied to.', FRA = 'Spécifie le numéro de l''écriture comptable article avec laquelle cette ligne facture a été lettrée.';
        }
        //BC UPGRADE SIVA >> Drink IT Code
        //addfirst(Control1)
        //{  
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
        //     field("Line No."; "Line No.")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        // }
        // addafter(CalcQtyReturned)
        // {
        //BC 
        //     field("Quantity to Return"; Rec."Quantity to Return")
        //     {
        //         ApplicationArea = all;
        //         Caption = 'Quantity to Return';
        //         ToolTip = 'Quantity to Return';
        //         Editable = true;
        //         Enabled = true;

        //         trigger OnValidate();
        //         var
        //             Error80000: Label '''Quantity to Return'' cannot be more than ''Qty. Not Returned''';
        //         begin
        //             if Rec."Quantity to Return" > QtyNotReturned then
        //                 ERROR(Error80000);
        //         end;
        //     }
        // }

        // addafter(LineAmount)
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
        //     }
        //}
        // BC UPGRADE SIVA << Drink IT Code
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
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
            ToolTipML = ENU = 'View or edit serial numbers and lot numbers that are assigned to the item on the document or journal line.', FRA = 'Affichez ou modifiez des numéros de série et de lot qui sont affectés à l''article sur le document ou la ligne feuille.';
        }
        //BC UPGRADE SIVA >> Drink IT code
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
        //BC UPGRADE SIVA << Drink IT code
    }

    var
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';

        ExpandLines: Boolean;

        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        HideQtytoreturn: Boolean;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocumentNoHideValue := false;
    DocumentNoOnFormat;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    IndentLine := IndentRecordDIT(ExpandLines);
    // >>DITW17.10.03 DDR DIT-770 #541

    DocumentNoHideValue := false;
    DocumentNoOnFormat;
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
    */
    //end;


    //Unsupported feature: CodeModification on "IsShowRec(PROCEDURE 3)". Please convert manually.

    //procedure IsShowRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    with SalesInvLine2 do begin
      QtyNotReturned := 0;
      if "Document No." <> SalesInvHeader."No." then
        SalesInvHeader.GET("Document No.");
    #5..16
        exit(true);
      exit(QtyNotReturned > 0);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    with SalesInvLine2 do begin
      // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
      if not IsShowRecDIT(ExpandLines) then
        exit(false);
      // >>DITW17.10.03 DDR DIT-770 #541

    #2..19
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

