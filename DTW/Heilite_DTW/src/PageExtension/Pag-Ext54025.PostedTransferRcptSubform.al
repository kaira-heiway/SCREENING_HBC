pageextension 54025 PostedTransferRcptSubformExt extends "Posted Transfer Rcpt. Subform"
{
    // version NAVW110.0,DITW110.00.08

    //     DITW15.00.00.36 DDR 17/12/2009 issue 594 Added fields
    //                                  "Truck Code","Driver Code","AAD No. Series - Shipment","AAD No. - Shipment"
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "Item No."
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    "LRN Nos Series","LRN No.",
    //                                    "ARC No.","SAD No."
    //                                  Hidden fields
    //                                    "AAD No. - Receipt"
    //                     04/10/2010   Removed old fields
    //                     05/10/2010   Added fields
    //                                    "ARC Line No.","Unsatisfactory reason","Unsatisfactory quantity","unsatisfactory comments"
    //                                  Added functions
    //                                    ShowLineUnstatisfactoryCmts()
    //                                  Set not editable fields if undo is done
    //                     26/11/2010 #1217 (DIT711 56)
    //                                  Added fields "Arc Line No." (editable)
    //                     21/12/2010 issue 1171 Added fields "Unit Amount","Line Amount" (non-editable)
    //                     22/12/2010 issue 1217 (DIT711 103) Bugfix modified form properties InsertAllowed,DeleteAllowed = No
    //                     03/01/2011 issue 1217 (DIT711 56) Removed non editable when Arc Line No. is filled
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //                     11/03/2011 issue 703 Added Column "Item Charge No.","Tracking Item No." (on item charges)
    // DITW15.00.00.39 DDR 11/07/2011 issue 1369 Added fields "Applies-to AAD Trck. Entry No."
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade Added/Review Total Line Amount (Collapsed RTC)
    //                                                         Added functions  UpdateFormatField()
    //                     26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    // DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  Added function SetDisableRefreshLines() to call before/after each report object
    //                                                 (don't use the <RunObject> property)
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
    //   # New Field added: "IC Receipt Adjusted"

    //Bc Upgrade YADAVM09 Drink it fields and Actions are blocked.
    //Bc Upgrade YADAVM09 Field property changes.
    layout
    {

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that you want to transfer.', FRA = 'Indique le numéro de l''article que vous souhaitez transférer.';

            //Unsupported feature: Change Editable on ""Item No."(Control 2)". Please convert manually.

        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant of the item on the line.', FRA = 'Indique la variante de l''article sur la ligne.';

            //Unsupported feature: Change Editable on ""Variant Code"(Control 18)". Please convert manually.

        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the item being transferred.', FRA = 'Spécifie la description de l''article en cours de transfert.';

            //Unsupported feature: Change Editable on "Description(Control 10)". Please convert manually.

        }
        modify("Transfer-To Bin Code")
        {
            ToolTipML = ENU = 'Specifies the code of the bin code you to which you want to transfer the items.', FRA = 'Spécifie le code du code emplacement vers lequel vous souhaitez transférer les articles.';

            //Unsupported feature: Change Editable on ""Transfer-To Bin Code"(Control 8)". Please convert manually.

        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the quantity of the item specified on the line.', FRA = 'Spécifie la quantité de l''article spécifié sur la ligne.';

            //Unsupported feature: Change Editable on "Quantity(Control 4)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code of the items you are transferring.', FRA = 'Indique le code unité des articles transférés.';

            //Unsupported feature: Change Editable on ""Unit of Measure Code"(Control 16)". Please convert manually.

        }
        modify("Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code of the item.', FRA = 'Spécifie le code unité de l''article.';

            //Unsupported feature: Change Editable on ""Unit of Measure"(Control 6)". Please convert manually.

        }
        modify("Shipping Time")
        {
            ToolTipML = ENU = 'Specifies the shipping time, which the program uses to calculate the receipt date.', FRA = 'Spécifie le délai d''expédition utilisé par le programme pour calculer la date de réception.';

            //Unsupported feature: Change Editable on ""Shipping Time"(Control 24)". Please convert manually.

        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code for the dimension that has been chosen as Global Dimension 1.', FRA = 'Spécifie le code section analytique de l''axe choisi comme axe principal 1.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 1 Code"(Control 12)". Please convert manually.

        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code for the dimension that has been chosen as Global Dimension 2.', FRA = 'Spécifie le code section analytique de l''axe choisi comme axe principal 2.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 2 Code"(Control 14)". Please convert manually.

        }
        addfirst(Control1)
        {
            //     field("Has Item Charge";Rec."Has Item Charge")
            //     {
            //         BlankZero = true;
            //     }
            //     field(Collapse;Rec.Collapse)
            //     {
            //         Visible = false;

            //         trigger OnValidate();
            //         begin
            //             // <<DITW15.00.00.37 DDR 19/01/2010
            //             CurrPage.UPDATE(true);
            //             // >>DITW15.00.00.37 DDR
            //         end;
            //     }//Bc Upgrade YADAVM09 Drink it fields<<
            field("Line No."; Rec."Line No.")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
        }
        // addafter("Item No.")
        // {
        //     field("Item Charge No."; Rec."Item Charge No.")
        //     {
        //         Editable = false;
        //     }
        //     field("GetTrackingItemNo()"; GetTrackingItemNo())
        //     {
        //         CaptionML = ENU = 'Tracking Item No. (Item Charge)',
        //                     FRA = 'N° article traçable (Frais annexes)';
        //         Editable = false;
        //         Visible = false;
        //     }
        // }
        // addafter("Unit of Measure")
        // {
        //     field("Unit Amount"; Rec."Unit Amount")
        //     {
        //         BlankZero = true;
        //         Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
        //         Editable = false;
        //     }
        //     field("Line Amount"; Rec."Line Amount")
        //     {
        //         BlankZero = true;
        //         Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
        //         Editable = false;
        //     }
        //     field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), true))
        //     {
        //         AutoFormatType = 1;
        //         BlankZero = true;
        //         CaptionML = ENU = 'Total Line Amount',
        //                     FRA = 'Montant total ligne';
        //         Description = 'DITW17.10.02B DIT-770 #541';
        //         Editable = false;
        //     }
        // } 
        // addafter("Shipping Time")
        // {
        //     field("Truck Code"; Rec."Truck Code")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Driver Code"; Rec."Driver Code")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("AAD No. - Receipt"; Rec."AAD No. - Receipt")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("ARC No. - Receipt"; "ARC No. - Receipt")
        //     {
        //         Description = 'DITW15.00.00.38 #1217';
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("ARC Line No."; "ARC Line No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Unsatisfactory Type"; Rec."Unsatisfactory Type")
        //     {
        //         Visible = false;
        //     }
        //     field("Unsatisfactory Quantity"; Rec."Unsatisfactory Quantity")
        //     {
        //         Visible = false;
        //     }
        //     field("Unsatisfactory Comment"; Rec."Unsatisfactory Comment")
        //     {
        //         Editable = false;
        //         OptionCaptionML = ENU = 'Bitmap7,Bitmap6',
        //                           FRA = 'Bitmap7,Bitmap6';
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             UnsatisfactoryCommentOnPush;
        //         end;
        //     }
        //     field("Applies-to AAD Trck. Entry No."; "Applies-to AAD Trck. Entry No.")
        //     {
        //         Description = 'DITW15.00.00.39 #1369';
        //         Visible = false;
        //     }
        // } //Bc Upgrade YADAVM09 Drink it fields<<
        addafter("Shortcut Dimension 2 Code")
        {
            field("IC Receipt Adjusted"; Rec."IC Receipt Adjusted FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
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
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
        }
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
        // addafter(Dimensions)
        // {
        //     action("Unsatisfactory Comment")
        //     {
        //         CaptionML = ENU = 'Unsatisfactory Comment',
        //                     FRA = 'Commentaires insatisfaisant';

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.38 DDR 05/10/2010
        //             //This functionality was copied from page #5745. Unsupported part was commented. Please check it.
        //             /*CurrPage.TransferReceiptLines.PAGE.*/
        //             _ShowLineUnstatisfactoryCmts();

        //         end;
        //     }
        // }  //Bc Upgrade YADAVM09 Drink it Action<<
    }

    var
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        DisabledRefreshLines: Boolean;
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
    // <<DITW15.00.00.38 DDR 05/10/2010
    CALCFIELDS("Unsatisfactory Comment");
    // >>DITW15.00.00.38 DDR
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
    //Bc Upgrade YADAVM09 Drink it function>>
    // procedure _ShowLineUnstatisfactoryCmts();
    // begin
    //     // <<DITW15.00.00.38 DDR 05/10/2010
    //     Rec.ShowLineUnstatisfactoryCmts();
    // end;

    // procedure ShowLineUnstatisfactoryCmts();
    // begin
    //     // <<DITW15.00.00.38 DDR 05/10/2010
    //     Rec.ShowLineUnstatisfactoryCmts();
    // end;

    // procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
    // begin
    //     // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    //     DisabledRefreshLines := NewDisabledRefreshLines;
    // end;

    // local procedure UnsatisfactoryCommentOnPush();
    // begin
    //     // <<DITW15.00.00.38 DDR 05/10/2010
    //     ShowLineUnstatisfactoryCmts();
    //     // >>DITW15.00.00.38 DDR
    // end;

    //Bc Upgrade YADAVM09 Drink it function<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

