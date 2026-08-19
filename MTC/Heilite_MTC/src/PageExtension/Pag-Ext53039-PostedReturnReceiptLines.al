pageextension 53039 PostedReturnReceiptLinesExt extends "Posted Return Receipt Lines"
{
    // version NAVW110.0,DITW110.00.08,HEI.01,HEI.02

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
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 02/03/2015 DIT-770 #1191 Added fields "Responsiblity Center","Physical Location Group Code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - Zycus Order Line No.
    // HEI.02 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Field - Zycus Movement Type

    //Bc Upgrade YADAVM09 Page field property changes.
    //Bc Upgrade YADAVM09 Drink it fields commented.
    //Bc Upgrade YADAVM09 interface related fields added in Interface extension.
    //                            # Added New Field - Zycus Movement Type
    //                            # Added New Fields - Zycus Order No.
    //                             - Zycus Order Line No.

    layout
    {
        //Bc Upgrade YADAVM09 Field property Added<<
        modify("Document No.")
        {
            Editable = false;
        }
        modify("Sell-to Customer No.")
        {
            Editable = false;
        }
        modify("No.")
        {
            Editable = false;
        }
        modify("Variant Code")
        {
            Editable = false;
        }
        modify(Description)
        {
            Editable = false;
        }
        modify("Location Code")
        {
            Editable = false;
        }
        modify("Bin Code")
        {
            Editable = false;
        }
        modify(Quantity)
        {
            Editable = false;
        }
        modify("Quantity Invoiced")
        {
            Editable = false;
        }
        modify("Unit of Measure")
        {
            Editable = false;
        }
        modify("Unit of Measure Code")
        {
            Editable = false;
        }
        modify("Appl.-to Item Entry")
        {
            Editable = false;
        }
        //Bc Upgrade YADAVM09 Field property Added<<
        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change Editable on ""Document No."(Control 2)". Please convert manually.


        //Unsupported feature: Change Editable on ""Sell-to Customer No."(Control 4)". Please convert manually.


        //Unsupported feature: Change Editable on "Type(Control 6)". Please convert manually.


        //Unsupported feature: Change Editable on ""No."(Control 8)". Please convert manually.


        //Unsupported feature: Change Editable on ""Variant Code"(Control 10)". Please convert manually.


        //Unsupported feature: Change Editable on "Description(Control 12)". Please convert manually.


        //Unsupported feature: Change Editable on ""Shortcut Dimension 1 Code"(Control 14)". Please convert manually.


        //Unsupported feature: Change Editable on ""Shortcut Dimension 2 Code"(Control 16)". Please convert manually.


        //Unsupported feature: Change Editable on ""Location Code"(Control 18)". Please convert manually.


        //Unsupported feature: Change Editable on ""Bin Code"(Control 20)". Please convert manually.


        //Unsupported feature: Change Editable on "Quantity(Control 22)". Please convert manually.


        //Unsupported feature: Change Editable on ""Unit of Measure Code"(Control 24)". Please convert manually.


        //Unsupported feature: Change Editable on ""Unit of Measure"(Control 26)". Please convert manually.


        //Unsupported feature: Change Editable on ""Appl.-to Item Entry"(Control 32)". Please convert manually.


        //Unsupported feature: Change Editable on ""Quantity Invoiced"(Control 45)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 18)". Please convert manually.

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
        // } //Bc Upgrade YADAVM09 Drink it fields<<
        addafter("Shortcut Dimension 2 Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }//Bc Upgrade YADAVM09 Drink it field<<
        }
        // addafter("Quantity Invoiced")
        // {
        //     field("Zycus Order No."; Rec."Zycus Order No.")
        //     {
        //         Visible = false;
        //         ApplicationArea = All;//Bc Upgrade YADAVM09<<
        //     }
        //     field("Zycus Order Line No."; Rec."Zycus Order Line No.")
        //     {
        //         Visible = false;
        //         ApplicationArea = All;//Bc Upgrade YADAVM09<<
        //     }
        //     field("Zycus Movement Type"; Rec."Zycus Movement Type")
        //     {
        //         Visible = false;
        //         ApplicationArea = All;//Bc Upgrade YADAVM09<<
        //     }
        // }//Bc Upgrade YADAVM09 Interface Fields<<
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
        // }//Bc Upgrade YADAVM09 Drink it field<<
    }

    var
        TempRecOpenFilters: Record "Return Receipt Line" temporary;
        IsOpenPage: Boolean;
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
    // <<DITW15.00.00.01 DDR 27/12/2007 - DITW15.00.00.38 DDR 16/07/2010 #1194
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

