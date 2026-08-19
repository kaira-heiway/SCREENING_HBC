pageextension 52022 ReturnShipmentLinesExt extends "Return Shipment Lines"
{
    // version NAVW110.0,DITW110.00.08,HEI.02,HEI.03

    //  DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.21 DDR 08/07/2008 Bugfix refresh & show CExpandCollapse column
    //   DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                    Added parmater et return value for function ReadExpansionStatus()
    //                                    Remove functions FormTotalingField()
    //                                    Rewrite functions UpdateFields(),FormTotalingField()
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                   DDR 30/07/2010           Remove OnFormat() field "No."
    //                   CEL 13/08/2010           Modification RTC buttons
    //                   DDR 18/08/2010 DIT717 #13 Added to keep open filters with expand-collapse (ShowAsTree in page)
    //   DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                               Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //                                              Added IndentationColumnName property value = ActualExpansionStatusInt
    //   DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field Added after "Quantity Invoiced" field
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW18.00.06 DDR 02/03/2015 DIT-770 #1190 Added fields "Responsiblity Center","Physical Location Group Code"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    //   HEI.01 HT2140 - CHG2105034 IBM NANDIS01 29.04.2021 - Brasco Congo: HT2140 - License Code Process Flow
    //     # New field shown - "License Code"
    //   HEI.02 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //     # Added New Fields - Zycus Order No.
    //                        - Zycus Order Line No.
    //   HEI.03 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //     # Added New Field - Zycus Movement Type

    //**********************************************//
    //BC UPGRADE SIVA 20/01/2026
    // SUMMARY OF CHANGES:
    //1.HEI.01  Added "License Code" field in Page layout.
    //2.HEI.02,HEI.03 Moved fields to Interface . 
    layout
    {

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Document No.")
        {
            StyleExpr = "Document No.Emphasize";
            Style = Strong;
        }

        // BC UPGRADE SIVA >> Drink IT Fields

        // addfirst(Control1)
        // {
        //     field("Has Item Charge"; rec."Has Item Charge")
        //     {
        //         BlankZero = true;
        //     }
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
        // }
        // BC UPGRADE SIVA << Drink IT Fields

        addafter("Shortcut Dimension 2 Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = all;
                ToolTip = 'Responsibility Center';
                Editable = false;
                Visible = false;
            }
            // BC UPGRADE SIVA >> Drink IT field
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // BC UPGRADE SIVA << Drink IT field
        }
        addafter("Quantity Invoiced")
        {
            // BC UPGRADE SIVA >> In base layout already filed is existed 
            // field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
            // {
            // }
            //BC UPGRADE SIVA << In base layout already filed is existed 
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = all;
                ToolTip = 'Gross Weight';
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = all;
                ToolTip = 'Net Weight';
            }
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = all;
                ToolTip = 'Quantity (Base)';
            }
            // BC UPGRADE SIVA >> Drink it fields
            // field("Line Amount"; Rec."Line Amount")
            // {
            // }
            // field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), true))
            // {
            //     AutoFormatExpression = GetCurrencyCode;
            //     AutoFormatType = 1;
            //     BlankZero = true;
            //     CaptionML = ENU = 'Total Line Amount',
            //                 FRA = 'Montant total ligne';
            //     Description = 'DITW17.10.02B DIT-770 #541';
            //     Editable = false;
            //     QuickEntry = false;
            // } 
            // field("Unit Volume HL"; Rec."Unit Volume HL")
            // {
            // }
            //BC UPGRADE SIVA << Drink it fields
            field("Blanket Order No."; Rec."Blanket Order No.")
            {
                ApplicationArea = all;
                ToolTip = 'Blanket Order No.';
            }
            field("Blanket Order Line No."; Rec."Blanket Order Line No.")
            {
                ApplicationArea = all;
                ToolTip = 'Blanket Order Line No.';
            }
            //BC UPGRADE SIVA >> In base layout already filed is existed 
            // field("Description 2"; Rec."Description 2")
            // {
            // }
            //BC UPGRADE SIVA << In base layout already filed is existed 
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = all;
                ToolTip = 'Posting Date';
            }
            //BC UPGRADE SIVA >> In base layout already filed is existed 
            // field("Return Order No."; Rec."Return Order No.")
            // {
            //     ApplicationArea = all;
            //     ToolTip ='Return Order No.';
            // }
            //BC UPGRADE SIVA << In base layout already filed is existed

            field("License Code"; Rec."License Code FND")
            {
                ApplicationArea = all;
                ToolTip = 'License Code';
            }
            field("Return Order Line No."; Rec."Return Order Line No.")
            {
                ApplicationArea = all;
                ToolTip = 'Return Order Line No.';
            }
            // BC UPGRADE SIVA >> Interface Fields 
            // field("Zycus Order No."; Rec."Zycus Order No.")
            // {
            //     Visible = false;
            // }
            // field("Zycus Order Line No."; Rec."Zycus Order Line No.")
            // {
            //     Visible = false;
            // }
            // field("Zycus Movement Type"; Rec."Zycus Movement Type")
            // {
            //     Visible = false;
            // }
            // BC UPGRADE SIVA << Interface Fields
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
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        addfirst("&Line")
        {
            // BC UPGRADE SIVA >> Drink IT code
            // action("+ Expand")
            // {
            //     CaptionML = ENU = '+ Expand',
            //                 FRA = '+ Développer';
            //     Enabled = (NOT ExpandLines);
            //     Image = ViewDetails;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Visible = (NOT ExpandLines) OR ShowButtonsCE;

            //     trigger OnAction();
            //     begin
            //         // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
            //         ExpandLines := true;
            //         CurrPage.UPDATE(true);
            //         // >>DITW17.10.03 DDR DIT-770 #541
            //     end;
            // }

            // action("- Collapse")
            // {
            //     CaptionML = ENU = '- Collapse',
            //                 FRA = '- Réduire';
            //     Enabled = ExpandLines;
            //     Image = ViewDetails;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Visible = ExpandLines OR ShowButtonsCE;

            //     trigger OnAction();
            //     begin
            //         // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
            //         ExpandLines := GETFILTER("Attached to Line No.") <> '';
            //         CurrPage.UPDATE(true);
            //         // >>DITW17.10.03 DDR DIT-770 #541
            //     end;
            // }
            // BC UPGRADE SIVA << Drink IT Code
        }
    }

    var
        TempRecOpenFilters: Record "Return Shipment Line" temporary;
        IsOpenPage: Boolean;

        "Document No.Emphasize": Boolean;

        ExpandLines: Boolean;

        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        grec_PurchHdr: Record "Purchase Header";


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
    // >>DITW16.00.00.37 DIT-715 #13
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
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
    exit(NextRecordDIT(Steps,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FILTERGROUP(2);
    SETRANGE(Type,Type::Item);
    SETFILTER(Quantity,'<>0');
    SETRANGE(Correction,false);
    SETRANGE("Job No.",'');
    FILTERGROUP(0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6

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

