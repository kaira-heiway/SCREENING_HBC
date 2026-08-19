pageextension 54023 PostedTransferReceiptLinesExt extends "Posted Transfer Receipt Lines"
{
    // version NAVW110.0,DITW110.00.08
    //     DITW15.00.00.37 DDR 28/05/2010 issue 480 Added Expand/Collapse functions
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "Item No."
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //                                         !!  Added IndentationColumnName property value = ActualExpansionStatusInt
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field Added after "Receipt Date" field
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
    //   # New Field added: "IC Receipt Adjusted"


    layout
    {

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number associated with this transfer line.', FRA = 'Spécifie le numéro du document associé à cette ligne transfert.';

            //Unsupported feature: Change Editable on ""Document No."(Control 2)". Please convert manually.

        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that you want to transfer.', FRA = 'Indique le numéro de l''article que vous souhaitez transférer.';

            //Unsupported feature: Change Editable on ""Item No."(Control 4)". Please convert manually.

        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the item being transferred.', FRA = 'Spécifie la description de l''article en cours de transfert.';

            //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.

        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the quantity of the item specified on the line.', FRA = 'Spécifie la quantité de l''article spécifié sur la ligne.';

            //Unsupported feature: Change Editable on "Quantity(Control 8)". Please convert manually.

        }
        modify("Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code of the item.', FRA = 'Spécifie le code unité de l''article.';

            //Unsupported feature: Change Editable on ""Unit of Measure"(Control 10)". Please convert manually.

        }
        modify("Receipt Date")
        {
            ToolTipML = ENU = 'Specifies the receipt date of the transfer receipt line.', FRA = 'Spécifie la date de réception de la ligne réception transfert.';

            //Unsupported feature: Change Editable on ""Receipt Date"(Control 12)". Please convert manually.

        }
        addfirst(Control1)
        {
            // BC Upgrade SHUKLP03 >>
            // field("Has Item Charge"; "Has Item Charge")
            // {
            //     BlankZero = true;
            //     ApplicationArea = All;
            // }
            // field(Collapse; Rec.Collapse)
            // {
            //     Visible = false;
            //     ApplicationArea = All;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW15.00.00.37 DDR 19/01/2010
            //         CurrPage.UPDATE(true);
            //         // >>DITW15.00.00.37 DDR
            //     end;
            // }
            // BC Upgrade SHUKLP03 <<
            field("Line No."; Rec."Line No.")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
            }
        }
        // addafter("Item No.")
        // {
        //     field("Item Charge No."; Rec."Item Charge No.")
        //     {
        //         Editable = false;
        //         ApplicationArea = All;
        //     }
        // }
        addafter("Receipt Date")
        {
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
            }
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = All;
            }
            // BC Upgrade SHUKLP03 >> Blocked DIT fields.
            // field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), true))
            // {
            //     AutoFormatType = 1;
            //     BlankZero = true;
            //     CaptionML = ENU = 'Total Line Amount',
            //                 FRA = 'Montant total ligne';
            //     Description = 'DITW17.10.02B DIT-770 #541';
            //     Editable = false;
            //     QuickEntry = false;
            //     ApplicationArea = All;
            // }
            // field("Unit Volume HL"; Rec."Unit Volume HL")
            // {
            //     ApplicationArea = All;
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT field.

            field("Transfer-from Code"; Rec."Transfer-from Code")
            {
                ApplicationArea = All;
            }
            field("Transfer-to Code"; Rec."Transfer-to Code")
            {
                ApplicationArea = All;
            }
            // BC Upgrade SHUKLP03 >> Blocked DIT fields.
            // field("Posting Date"; Rec."Posting Date")
            // {
            //     ApplicationArea = All;
            // }
            // field("External Document No."; Rec."External Document No.")
            // {
            //     ApplicationArea = All;
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT fields.

            field("IC Receipt Adjusted"; Rec."IC Receipt Adjusted FND")
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
            }
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
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        // BC Upgrade SHUKLP03 >> Blocked DIT actions.
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
        //         ApplicationArea = All;

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
        //         ApplicationArea = All;

        //         trigger OnAction();
        //         begin
        //             // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        //             ExpandLines := Rec.GETFILTER(Rec."Attached to Line No.") <> '';
        //             CurrPage.UPDATE(true);
        //             // >>DITW17.10.03 DDR DIT-770 #541
        //         end;
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked DIT actions.
    }

    var
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


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
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

