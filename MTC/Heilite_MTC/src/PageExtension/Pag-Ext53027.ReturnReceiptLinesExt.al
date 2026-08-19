pageextension 53027 ReturnReceiptLinesExt extends "Return Receipt Lines"
{
    // version NAVW110.0,DITW110.00.08,HEI.02,HEI.03
    //BC UPGRADE SIVA Old Page ID 6667
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
    //                                            Added IndentationColumnName property value = ActualExpansionStatusInt
    //   DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field Added after "Quantity Invoiced" field
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW18.00.06 DDR 02/03/2015 DIT-770 #1191 Added fields "Responsiblity Center","Physical Location Group Code"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.01 FDD RPM Breakages IBM ISYED01 03.06.2019
    //     #"RPM comp.Sales Credit memo No." added new filed.
    //   HEI.02 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //     # Added New Fields - Zycus Order No.
    //                        - Zycus Order Line No.
    //   HEI.03 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //     # Added New Field - Zycus Movement Type
    //*********************************//
    //BC UPGRADE SIVA 20/01/2026
    // SUMMARY OF CHANGES:
    //1.HEI.01 Added field in page layout.
    //2.HEI.02,HEI.03 Moved fields to interface.
    layout
    {

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Document No.")
        {
            StyleExpr = "Document No.Emphasize";
            Style = Strong;
        }
        // BC UPGRADE SIVA >> Drink IT Code
        // addfirst(Control1)
        // {
        //     field("Has Item Charge"; Rec."Has Item Charge")
        //     {
        //         BlankZero = true;
        //     }
        //     field(Collapse; rec.Collapse)
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
        // BC UPGRADE SIVA << Drink IT Code
        addafter("Shortcut Dimension 2 Code")
        {
            field("Responsibility Center"; rec."Responsibility Center")
            {
                ApplicationArea = ALL;
                ToolTip = 'Responsibility Center';
                Editable = false;
                Visible = false;
            }
            // BC UPGRADE SIVA >> Drink IT Code
            // field("Physical Location Group Code"; rec."Physical Location Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // BC UPGRADE SIVA <<Drink IT Code
        }
        addafter("Quantity Invoiced")
        {
            // BC UPGRADE SIVA >>  In base layout already filed is existed 

            // field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
            // {
            // }
            // BC UPGRADE SIVA >>  In base layout already filed is existed 


            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
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


            // BC UPGRADE SIVA << Drink IT Fields
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
            // // BC UPGRADE SIVA >>
            // field("Unit Volume HL"; Rec."Unit Volume HL")
            // {
            // }
            //BC UPGRADE SIVA <<  Drink IT Fields
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

            //BC UPGRADE SIVA >> Drink IT Field
            // field("External Document No."; Rec."External Document No.")
            // {

            // }
            //BC UPGRADE SIVA<< Drink IT Field
            field("Posting Date"; Rec."Posting Date")
            {
                ToolTip = 'Posting Date';
                ApplicationArea = all;

            }
            field("RPM comp.Sales Credit memo No."; Rec."RPM comp.Sales Cr. memo No FND")
            {
                ToolTip = 'RPM comp.Sales Credit memo No.';
                ApplicationArea = all;
            }
            //BC UPGRADE SIVA >>Interface fields
            // field("Zycus Order No."; Rec."Zycus Order No.")
            // {
            //     ApplicationArea =all;
            //     Visible = false;
            // }
            // field("Zycus Order Line No."; Rec."Zycus Order Line No.")
            // {
            //     ApplicationArea =all;
            //     Visible = false;
            // }
            // field("Zycus Movement Type"; Rec."Zycus Movement Type")
            // {
            //     ApplicationArea =all;
            //     Visible = false;
            // }
            //BC UPGRADE SIVA << Interface fields

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
        //BC UPGRADE SIVA>> Drink IT Code
        // addfirst("&Line")
        // {
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
        //}
        //BC UPGRADE SIVA<< Drink IT Code
    }

    var
        TempRecOpenFilters: Record "Return Receipt Line" temporary;
        IsOpenPage: Boolean;

        "Document No.Emphasize": Boolean;

        ExpandLines: Boolean;

        ShowButtonsCE: Boolean;
        IndentLine: Integer;


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
    if AssignmentType = AssignmentType::Sale then
      SETRANGE("Sell-to Customer No.",SellToCustomerNo);
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
    #1..8
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

