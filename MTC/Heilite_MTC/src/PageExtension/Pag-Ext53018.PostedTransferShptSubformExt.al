pageextension 53018 PostedTransferShptSubformExt extends "Posted Transfer Shpt. Subform"
{
    // version NAVW110.0,DITW110.00.08,HEI.01
    /*  DITW15.00.00.36 DDR 17/12/2009 issue 594 Added fields
                                       "Truck Code","Driver Code","AAD No. Series - Shipment","AAD No. - Shipment"
      DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
                                       Added parmater et return value for function ReadExpansionStatus()
                                       Remove functions FormTotalingField()
                                       Rewrite functions UpdateFields(),FormTotalingField()
      DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
                      DDR 30/07/2010           Remove OnFormat() field "Item No."
                      CEL 13/08/2010           Modification RTC buttons
      DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
                                       Added fields
                                         "EMCS LRN Nos Series","EMCS LRN No.",
                                         "EMCS ARC No.","EMCS SAD No."
                                       Added editable fields
                                         "Packaging Type Code","No. of Packages","Commercial Seal ID"
                                       Hidden fields
                                         "AAD Nos Series - Shipment","AAD No. - Shipment"
                          08/10/2010   Added fields
                                         "Cancellation Reason Code"
                                       Set not editable fields if undo is done
                          21/12/2010 issue 1171 Added fields "Unit Amount","Line Amount" (non-editable)
                          22/12/2010 issue 1217 (DIT711 103) Bugfix modified form properties InsertAllowed,DeleteAllowed = No
      DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
                                                  Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
                          11/03/2011 issue 703 Added Column "Item Charge No.","Tracking Item No." (on item charges)
      DITW15.00.00.39 DDR 11/07/2011 issue 1369 Added fields "Applies-to AAD Trck. Entry No."
      DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade Added/Review Total Line Amount (Collapsed RTC)
                                                              Added functions  UpdateFormatField()
                          26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
      DITW16.00.00.40 DDR 22/12/2011 DIT-715 issue 187
                                             Added fields "Cancellation Reason Comment"
                                             Added functions ShowLineCancelReasonCmts()
                          11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
                                                       Added function SetDisableRefreshLines() to call before/after each report object
                                                      (don't use the <RunObject> property)
      DITW16.00.00.43 DDR 23/08/2013 DIT-715 #720 Added functions OpenEDIDocument()

      DITW17.00.02 DDR 23/08/2013 DIT-715 #720 merge
      DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
      DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Unit Amount"

      DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

      HEI.01 FDD-GAPLOG015 IBM NASTAA02 18.04.2018 # Undo Transfer Shipment
        # Added new Action Button "Undo Transfer Shipment" and new function "UndoShipmentPosting"
      HEI.02 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
        # New Field added: "IC Shipment Adjusted" */
    // BC Upgrade BHARAD11 >>
    // 1. REmove Drink-It Fields("Has Item Charge","Has Item Charge","Item Charge No.","Unit Amount", "Line Amount", "RTCTotalUnit", "RTCTotalLine","Truck Code", "Driver Code", "AAD No. Series - Shipment", "AAD No. - Shipment", "LRN No. Series - Shipment", "LRN No. - Shipment", "ARC No. - Shipment", "SAD No. - Shipment", "Packaging Type Code", "No. of Packages", "Commercial Seal ID", "Cancellation Reason Type", "Cancellation Reason Comment", "Applies-to AAD Trck. Entry No.")
    // 2. Remove Drink-It Functions and Related customization(_ShowLineCancelReasonCmts, ShowLineCancelReasonCmts, SetDisableRefreshLines, _OpenEDIDocument, OpenEDIDocument, CancellationReasonTypeOnAfterV, CancellationReasonCommenOnPush,GetTrackingItemNo())
    // 3. Create new page extension in DTW extension for DTW related code(action(UndoShipment1)).
    // BC Upgrade BHARAD11 <<

    layout
    {

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that will be transferred.', FRA = 'Indique le numéro de l''article qui va être transféré.';

            //Unsupported feature: Change Editable on ""Item No."(Control 2)". Please convert manually.

        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant of the item on the line.', FRA = 'Indique la variante de l''article sur la ligne.';

            //Unsupported feature: Change Editable on ""Variant Code"(Control 18)". Please convert manually.

        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry.', FRA = 'Spécifie une description de l''écriture.';

            //Unsupported feature: Change Editable on "Description(Control 10)". Please convert manually.

        }
        modify("Transfer-from Bin Code")
        {
            ToolTipML = ENU = 'Specifies the code for the bin from which the items should be transferred.', FRA = 'Spécifie le code de l''emplacement à partir duquel les articles doivent être transférés.';

            //Unsupported feature: Change Editable on ""Transfer-from Bin Code"(Control 8)". Please convert manually.

        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the quantity of the item specified on the line.', FRA = 'Spécifie la quantité de l''article spécifié sur la ligne.';

            //Unsupported feature: Change BlankZero on "Quantity(Control 4)". Please convert manually.


            //Unsupported feature: Change Editable on "Quantity(Control 4)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code of the items that you are transferring.', FRA = 'Indique le code unité des articles transférés.';

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

            //Unsupported feature: Change Editable on ""Shipping Time"(Control 28)". Please convert manually.

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

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Bin Code"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transfer-from Bin Code"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Quantity(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Quantity(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Time"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Time"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 14)". Please convert manually.

        addfirst(Control1)
        {
            // BC Upgrade BHARAD11 >> ----Drink-IT Fields("Has Item Charge","Has Item Charge")
            // field("Has Item Charge"; Rec."Has Item Charge")
            // {
            //     BlankZero = true;
            // }
            // field(Collapse; Rec."Has Item Charge")
            // {
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW15.00.00.37 DDR 19/01/2010
            //         CurrPage.UPDATE(TRUE);
            //         // >>DITW15.00.00.37 DDR
            //     end;
            // }
            // BC Upgrade BHARAD11 << ----Drink-IT Fields("Has Item Charge","Has Item Charge")

            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
        }
        // addafter("Item No.")
        // {
        // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Item Charge No.") And Function(GetTrackingItemNo())
        // field("Item Charge No."; Rec."Item Charge No.")
        // {
        //     Editable = false;
        // }
        // field(GetTrackingItemNo(); GetTrackingItemNo())
        // {
        //     ApplicationArea = All;
        //     CaptionML = ENU = 'Tracking Item No. (Item Charge)',
        //                 FRA = 'N° article traçable (Frais annexes)';
        //     Editable = false;
        //     Visible = false;
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Fields("Item Charge No.") And Function(GetTrackingItemNo())

        // }
        // addafter("Unit of Measure")
        // {
        // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Unit Amount", "Line Amount", "RTCTotalUnit", "RTCTotalLine")
        // field("Unit Amount"; Rec."Unit Amount")
        // {
        //     BlankZero = true;
        //     Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
        //     Editable = false;
        // }
        // field("Line Amount"; Rec."Line Amount")
        // {
        //     BlankZero = true;
        //     Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
        //     Editable = false;
        // }
        // field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Unit Amount"), TRUE))
        // {
        //     AutoFormatType = 2;
        //     BlankZero = true;
        //     CaptionML = ENU = 'Total Unit Amount',
        //                 FRA = 'Montant unitaire total';
        //     Description = 'DITW17.10.05 DIT-770 #988';
        //     Editable = false;
        //     QuickEntry = false;
        //     Visible = false;
        // }
        // field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), TRUE))
        // {
        //     AutoFormatType = 1;
        //     BlankZero = true;
        //     CaptionML = ENU = 'Total Line Amount',
        //                 FRA = 'Montant total ligne';
        //     Description = 'DITW17.10.02B DIT-770 #541';
        //     Editable = false;
        //     QuickEntry = false;
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Fields("Unit Amount", "Line Amount", "RTCTotalUnit", "RTCTotalLine")

        // }
        // addafter("Shipping Time")
        // {
        // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Truck Code", "Driver Code", "AAD No. Series - Shipment", "AAD No. - Shipment", "LRN No. Series - Shipment", "LRN No. - Shipment", "ARC No. - Shipment", "SAD No. - Shipment", "Packaging Type Code", "No. of Packages", "Commercial Seal ID", "Cancellation Reason Type", "Cancellation Reason Comment", "Applies-to AAD Trck. Entry No.")
        // field("Truck Code"; Rec."Truck Code")
        // {
        //     Editable = false;
        //     Visible = false;
        // }
        // field("Driver Code"; Rec."Driver Code")
        // {
        //     Editable = false;
        //     Visible = false;
        // }
        // field("AAD No. Series - Shipment"; Rec."AAD No. Series - Shipment")
        // {
        //     Editable = false;
        //     Visible = false;
        // }
        // field("AAD No. - Shipment"; Rec."AAD No. - Shipment")
        // {
        //     Editable = false;
        //     Visible = false;
        // }
        // field("LRN No. Series - Shipment"; Rec."LRN No. Series - Shipment")
        // {
        //     Description = 'DITW15.00.00.38 #1217';
        //     Editable = false;
        //     Visible = false;
        // }
        // field("LRN No. - Shipment"; Rec."LRN No. - Shipment")
        // {
        //     Description = 'DITW15.00.00.38 #1217';
        //     Editable = false;
        //     Visible = false;
        // }
        // field("ARC No. - Shipment"; Rec."ARC No. - Shipment")
        // {
        //     Description = 'DITW15.00.00.38 #1217';
        //     Editable = false;
        //     Visible = false;
        // }
        // field("SAD No. - Shipment"; Rec."SAD No. - Shipment")
        // {
        //     Description = 'DITW15.00.00.38 #1217';
        //     Editable = false;
        //     Visible = false;
        // }
        // field("Packaging Type Code"; Rec."Packaging Type Code")
        // {
        //     Editable = "Packaging Type CodeEditable";
        //     Visible = false;
        // }
        // field("No. of Packages"; Rec."No. of Packages")
        // {
        //     Editable = "No. of PackagesEditable";
        //     Visible = false;
        // }
        // field("Commercial Seal ID"; Rec."Commercial Seal ID")
        // {
        //     Editable = "Commercial Seal IDEditable";
        //     Visible = false;
        // }
        // field("Cancellation Reason Type"; Rec."Cancellation Reason Type")
        // {
        //     Visible = false;

        //     trigger OnValidate();
        //     begin
        //         CancellationReasonTypeOnAfterV;
        //     end;
        // }
        // field("Cancellation Reason Comment"; Rec."Cancellation Reason Comment")
        // {
        //     Description = 'DIT715 #187';
        //     Editable = false;
        //     OptionCaptionML = ENU = 'Bitmap7,Bitmap6',
        //                       FRA = 'Bitmap7,Bitmap6';
        //     Visible = false;

        //     trigger OnValidate();
        //     begin
        //         CancellationReasonCommenOnPush;
        //     end;
        // }
        // field("Applies-to AAD Trck. Entry No."; Rec."Applies-to AAD Trck. Entry No.")
        // {
        //     Description = 'DITW15.00.00.39 #1369';
        //     Visible = false;
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Fields("Truck Code", "Driver Code", "AAD No. Series - Shipment", "AAD No. - Shipment", "LRN No. Series - Shipment", "LRN No. - Shipment", "ARC No. - Shipment", "SAD No. - Shipment", "Packaging Type Code", "No. of Packages", "Commercial Seal ID", "Cancellation Reason Type", "Cancellation Reason Comment", "Applies-to AAD Trck. Entry No.")
        // }
        addafter("Shortcut Dimension 2 Code")
        {
            field("IC Shipment Adjusted"; Rec."IC Shipment Adjusted FND")
            {
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
        modify(Dimensions)
        {

            //Unsupported feature: Change AccessByPermission on "Dimensions(Action 1901313004)". Please convert manually.

            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Line"(Action 1907935204)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Dimensions(Action 1901313004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item &Tracking Lines"(Action 1900545004)". Please convert manually.
        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
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
        //             ExpandLines := TRUE;
        //             CurrPage.UPDATE(TRUE);
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
        //             ExpandLines := FALSE;
        //             CurrPage.UPDATE(TRUE);
        //             // >>DITW17.10.03 DDR DIT-770 #541
        //         end;
        //     }
        //     group("&Print")
        //     {
        //         CaptionML = ENU = '&Print',
        //                     FRA = '&Imprimer';
        //         action("&AAD Document (EMCS)")
        //         {
        //             CaptionML = ENU = '&AAD Document (EMCS)',
        //                         FRA = 'Document D&AA (EMCS)';

        //             trigger OnAction();
        //             begin
        //                 // <<DITW16.00.00.43 DDR 23/08/2013 DIT-715 #720
        //                 //This functionality was copied from page #5743. Unsupported part was commented. Please check it.
        //                 /*CurrPage.TransferShipmentLines.FORM.*/
        //                 _OpenEDIDocument();
        //                 // >>DITW16.00.00.43 DDR DIT-715 #720

        //             end;
        //         }
        //     }
        // }
        // addafter("Item &Tracking Lines")
        // {
        //     action("Cancellation Reason Comments")
        //     {
        //         CaptionML = ENU = 'Cancellation Reason Comments',
        //                     FRA = 'Commentaires raison d''annulation';

        //         trigger OnAction();
        //         begin
        //             // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
        //             //This functionality was copied from page #5743. Unsupported part was commented. Please check it.
        //             /*CurrPage.TransferShipmentLines.PAGE.*/
        //             _ShowLineCancelReasonCmts;

        //         end;
        //     }

        // }
        // BC Upgrade BHARAD11 << ----Drink-IT Customization
    }

    var
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Unit Amount', FRA = 'Montant unitaire total';
        DisabledRefreshLines: Boolean;

        "Packaging Type CodeEditable": Boolean;

        "No. of PackagesEditable": Boolean;

        "Commercial Seal IDEditable": Boolean;

        ExpandLines: Boolean;

        ShowButtonsCE: Boolean;
        IndentLine: Integer;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    // <<DITW15.00.00.01 DDR 27/12/2007 - DITW15.00.00.38 DDR 16/07/2010 #1194
    // <<DITW15.00.00.38 DDR 12/10/2010 #1217
    "Packaging Type CodeEditable" := ("ARC No. - Shipment" = '');
    "No. of PackagesEditable" := ("ARC No. - Shipment" = '');
    "Commercial Seal IDEditable" := ("ARC No. - Shipment" = '');
    // >>DITW15.00.00.38 DDR #1217
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnFindRecord". Please convert manually.

    //trigger OnFindRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    IF DisabledRefreshLines THEN
      EXIT(FALSE);
    // >>DITW16.00.00.40 DDR DIT-715 #197
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //EXIT(FIND(Which));
    EXIT(FindRecordDIT(Which,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    "Commercial Seal IDEditable" := TRUE;
    "No. of PackagesEditable" := TRUE;
    "Packaging Type CodeEditable" := TRUE;
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNextRecord". Please convert manually.

    //trigger OnNextRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //EXIT(NEXT(Steps));
    EXIT(NextRecordDIT(Steps,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;
    // BC Upgrade BHARDA11 >> ----Drink-IT Functions(_ShowLineCancelReasonCmts, ShowLineCancelReasonCmts, SetDisableRefreshLines, _OpenEDIDocument, OpenEDIDocument, CancellationReasonTypeOnAfterV, CancellationReasonCommenOnPush)
    // procedure _ShowLineCancelReasonCmts();
    // begin
    //     // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
    //     Rec.ShowLineCancelReasonCmts();
    // end;

    // procedure ShowLineCancelReasonCmts();
    // begin
    //     // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
    //     Rec.ShowLineCancelReasonCmts();
    // end;

    // procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
    // begin
    //     // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    //     DisabledRefreshLines := NewDisabledRefreshLines;
    // end;

    // procedure _OpenEDIDocument();
    // var
    //     EmcsEdiMgt: Codeunit "2014261";
    // begin
    //     // <<DITW16.00.00.43 DDR 23/08/2013 DIT-715 #720
    //     EmcsEdiMgt.OpenEDIOutDocFile(
    //       DATABASE::"Transfer Shipment Line", 0, "Document No.", "LRN No. - Shipment", "ARC No. - Shipment");
    // end;

    // procedure OpenEDIDocument();
    // var
    //     EmcsEdiMgt: Codeunit "2014261";
    // begin
    //     // <<DITW16.00.00.43 DDR 23/08/2013 DIT-715 #720
    //     EmcsEdiMgt.OpenEDIOutDocFile(
    //       DATABASE::"Transfer Shipment Line", 0, "Document No.", "LRN No. - Shipment", "ARC No. - Shipment");
    // end;

    // local procedure CancellationReasonTypeOnAfterV();
    // begin
    //     // <<DITW15.00.00.38 DDR 11/10/2010 #1217
    //     CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.38 DDR #1217
    // end;

    // local procedure CancellationReasonCommenOnPush();
    // begin
    //     // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
    //     ShowLineCancelReasonCmts();
    //     // >>DITW16.00.00.40 DDR DIT-715 #187
    // end;
    // BC Upgrade BHARDA11 << ----Drink-IT Functions(_ShowLineCancelReasonCmts, ShowLineCancelReasonCmts, SetDisableRefreshLines, _OpenEDIDocument, OpenEDIDocument, CancellationReasonTypeOnAfterV, CancellationReasonCommenOnPush)


    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

