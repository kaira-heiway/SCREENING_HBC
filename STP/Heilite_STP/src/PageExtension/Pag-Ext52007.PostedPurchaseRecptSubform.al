pageextension 52007 PostedPurchaseRcptsubformExt extends "Posted Purchase Rcpt. Subform"
{
    // version NAVW110.0,DITW110.00.10,HEI.05,HEI.06
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.01 DDR 02/01/2008 Added column "Line No." (not editable)
    //                                  property Editable Form = yes (but all fields are non editable except Collapse button)
    //   DITW15.00.00.01 DDR 15/01/2008 Added property Form InsertAllowed,ModifyAllowed,DeleteAllowed=No
    //   DITW15.00.00.01 DDR 15/02/2008 Added function UpdateFormatField()
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.24 DDR 14/08/2008 Added fields (not editable) "Weight","Cubage",
    //   DITW15.00.00.25 DDR 17/10/2008 Non-Editable Cubage,Weight,Distance
    //   DITW15.00.00.28 DDR 24/11/2008 Added fields "AAD No."
    //   DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
    //                                    "Empty Goods Item No."
    //   DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //   DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                    Remove functions FormTotalingField()
    //                                    Rewrite functions UpdateFields(),FormTotalingField()
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                   DDR 30/07/2010           Remove OnFormat() field "No."
    //                   CEL 13/08/2010           Modification RTC buttons
    //   DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                    Added fields
    //                                      "LRN No.","ARC No.","SAD No."
    //                                    Hidden fields
    //                                      "AAD No."
    //                       05/10/2010   Added fields
    //                                      "ARC Line No.","Unsatisfactory reason","Unsatisfactory quantity","unsatisfactory comments"
    //                                    Added functions
    //                                      ShowLineUnstatisfactoryCmts()
    //                                    Set not editable fields if undo is done
    //                       26/11/2010 #1217 (DIT711 56)
    //                                    Added fields "Arc Line No." (editable)
    //                       17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    //                                    non editable field "Free Item"
    //                       03/01/2011 issue 1217 (DIT711 56) Removed non editable when Arc Line No. is filled
    //   DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                               Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //   DITW15.00.00.39 DDR 11/07/2011 issue 1369 Added fields "Applies-to AAD Trck. Entry No."
    //   DITW16.00.00.39 DDR 26/09/2011 DIT-715 #141 Added "Total Amount" column for all line types
    //   DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                    Added function SetDisableRefreshLines() to call before/after each report object
    //                                                   (don't use the <RunObject> property)
    //   DITW16.00.00.41 AHU 06/11/2012 DIT-715 #393 Added "Description 2" field

    //   DITW17.00.02 DDR 04/07/2013 DIT-770 #99 Removed field "Ship-to Country/Region Code"
    //                                           Added fields "GWC Country/Region Code"
    //                    28/08/2013 DIT-770 #178 Remove DIT-770 #99
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added field "Responsibity Center","Physical Location Group Code"
    //   DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Direct Unit Cost"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Changes for backorders
    //   HEI.01 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //     # New Field added: "CAD Amount"
    //     # Code added on 'OnOpenPage' trigger

    //   HEI.02 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //     # SPL Code, SPL Name - fields created
    //   HEI.03 CHG2201773 HB3442 IBM SRIVAS07 16.02.24 # Finetuning - Undoing a Goods Receipt for Fixed Asset
    //     # Added few code in UndoReceiptLine()
    //   HEI.04 CHG2229933 HB3689 IBM SRIVAS07 25.04.2024 # SRM Reference Document Mapping - Development
    //     # Added field - "Vendor Shipment No."
    //   HEI.05 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //     # Added New Fields - Zycus Order No.
    //                        - Zycus Order Line No.
    //                        - Zycus PR Reference No.
    //                        - Zycus PO Type Code
    //                        - Zycus PO Line Type Code
    //                        - Zycus PO Line Validated
    //   HEI.06 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //     # Added New Field - Zycus Movement Type
    //HEI.01 -//BC Upgrade GUNREM01
    //HEI.05 and HEI.06 -//BC Upgrade GUNREM01 Adde fields in Interface

    layout
    {

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change Editable on "Type(Control 2)". Please convert manually.

        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.', FRA = 'Spécifie le numéro d''un compte général, d''un article, d''un coût supplémentaire ou d''une immobilisation, selon la sélection effectuée dans le champ Type.';

            //Unsupported feature: Change Editable on ""No."(Control 4)". Please convert manually.

        }
        //BC Upgrade GUNREM01 Commented NA
        // modify("Cross-Reference No.")
        // {
        //     ToolTipML = ENU='Specifies the cross-referenced item number. If you enter a cross reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the cross-reference number on a sales or purchase document.',FRA='Spécifie le numéro d''article à référence externe. Si vous saisissez une référence externe entre votre numéro d''article et celui de votre fournisseur ou client, ce numéro remplace le numéro d''article standard lorsque vous saisissez le numéro de référence externe sur un document vente ou achat.';

        //     //Unsupported feature: Change Editable on ""Cross-Reference No."(Control 26)". Please convert manually.

        // }

        //Unsupported feature: Change Editable on ""Variant Code"(Control 16)". Please convert manually.

        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the item or service on the line.', FRA = 'Spécifie une description de l''article ou du service sur la ligne.';

            //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.

        }

        //Unsupported feature: Change Editable on ""Return Reason Code"(Control 20)". Please convert manually.


        //Unsupported feature: Change Editable on ""Location Code"(Control 38)". Please convert manually.


        //Unsupported feature: Change Editable on ""Bin Code"(Control 50)". Please convert manually.


        //Unsupported feature: Change Editable on "Quantity(Control 8)". Please convert manually.

        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code for the item.', FRA = 'Spécifie le code unité de mesure de l''article.';

            //Unsupported feature: Change Editable on ""Unit of Measure Code"(Control 24)". Please convert manually.

        }

        //Unsupported feature: Change Editable on ""Unit of Measure"(Control 10)". Please convert manually.

        modify("Quantity Invoiced")
        {
            ToolTipML = ENU = 'Specifies how many units of the item on the line have already been invoiced.', FRA = 'Spécifie le nombre d''unités de l''article sur la ligne qui ont déjà été facturées.';

            //Unsupported feature: Change Editable on ""Quantity Invoiced"(Control 12)". Please convert manually.

        }
        modify("Qty. Rcd. Not Invoiced")
        {
            ToolTipML = ENU = 'Specifies how many units of the item on the line have been received and not yet invoiced.', FRA = 'Spécifie le nombre d''unités de l''article sur la ligne qui ont été reçues, mais pas encore facturées.';
        }
        modify("Requested Receipt Date")
        {
            ToolTipML = ENU = 'Specifies the date that you want the vendor to deliver to the ship-to address. The value in the field is used to calculate the latest date you can order the items to have them delivered on the requested receipt date. If you do not need delivery on a specific date, you can leave the field blank.', FRA = 'Spécifie la date à laquelle vous souhaitez que le fournisseur livre les articles à l''adresse destinataire. La valeur du champ est utilisée pour calculer la date limite de commande garantissant la livraison des articles à la date de réception demandée. Si vous ne souhaitez pas indiquer une date de livraison, vous pouvez laisser ce champ vide.';

            //Unsupported feature: Change Editable on ""Requested Receipt Date"(Control 18)". Please convert manually.

        }

        //Unsupported feature: Change Editable on ""Promised Receipt Date"(Control 28)". Please convert manually.


        //Unsupported feature: Change Editable on ""Planned Receipt Date"(Control 44)". Please convert manually.


        //Unsupported feature: Change Editable on ""Expected Receipt Date"(Control 14)". Please convert manually.

        modify("Order Date")
        {
            ToolTipML = ENU = 'Specifies the date when the item is ordered. It is calculated backwards from the Planned Receipt Date field in combination with the Lead Time Calculation field.', FRA = 'Spécifie la date de commande de l''article. Elle est calculée en amont à partir du champ Date planifiée de réception et du champ Délai de réappro.';

            //Unsupported feature: Change Editable on ""Order Date"(Control 46)". Please convert manually.

        }

        //Unsupported feature: Change Editable on ""Lead Time Calculation"(Control 30)". Please convert manually.


        //Unsupported feature: Change Editable on ""Job No."(Control 32)". Please convert manually.


        //Unsupported feature: Change Editable on ""Prod. Order No."(Control 22)". Please convert manually.


        //Unsupported feature: Change Editable on ""Inbound Whse. Handling Time"(Control 36)". Please convert manually.

        modify("Appl.-to Item Entry")
        {
            ToolTipML = ENU = 'Specifies the number of the item ledger entry this receipt line was applied to.', FRA = 'Spécifie le numéro de l''écriture comptable article avec laquelle cette ligne réception a été lettrée.';

            //Unsupported feature: Change Editable on ""Appl.-to Item Entry"(Control 34)". Please convert manually.

        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 1 Code"(Control 42)". Please convert manually.

        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 2 Code"(Control 40)". Please convert manually.

        }

        //Unsupported feature: Change Editable on "Correction(Control 52)". Please convert manually.

        //BC Upgrade GUNREM01 >> DIT
        // addfirst(Control1)
        // {
        //     field("Has Item Charge"; Rec."Has Item Charge")
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
        //BC Upgrade GUNREM01 << DIT

        //BC Upgrade GUNREM01 >> DIT
        // addafter("Variant Code")
        // {
        //     field("GetTrackingItemNo()"; GetTrackingItemNo())
        //     {
        //         CaptionML = ENU = 'Tracking Item No. (Item Charge)',
        //                     FRA = 'N° article traçable (Frais annexes)';
        //         DrillDownPageID = "Item List";
        //         Editable = false;
        //         LookupPageID = "Item List";
        //         TableRelation = IF ("Item Charge Type" = CONST(Tax)) Item WHERE("No." = FIELD("Tax Item No."))
        //         ELSE IF ("Item Charge Type" = CONST(Deposit)) Item WHERE("No." = FIELD("Empty Goods Item No."));
        //         Visible = false;

        //         trigger OnLookup(Text: Text): Boolean;
        //         begin
        //             // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //             Text := GetTrackingItemNo();
        //             LookupItemNo(Text);
        //             exit(false);
        //         end;
        //     }
        // }
        // addafter(Description)
        // {
        //     field("Description 2"; "Description 2")
        //     {
        //         Description = 'DIT-715 #393';
        //         Editable = false;
        //         Visible = false;
        //     }
        // }  //BC Upgrade GUNREM01 << DIT
        addafter("Return Reason Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Responsibility Center field.';
            }
            // field("Physical Location Group Code"; rec."Physical Location Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }  //BC Upgrade GUNREM01 - DIT
        }
        addafter(Quantity)
        {
            // field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            // {
            // } //BC Upgrade GUNREM01 - DIT
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                ApplicationArea = All;
                Visible = EnableCAD;
            }//BC Upgrade GUNREM01 
            field("Direct Unit Cost"; Rec."Direct Unit Cost")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the cost of one unit of the selected item or resource.';

            }
        }
        addafter("Unit of Measure")
        {//BC Upgrade GUNREM01 >> DIT
            // field("Indirect Cost %"; "Indirect Cost %")
            // {
            //     Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Unit Cost (LCY)"; "Unit Cost (LCY)")
            // {
            //     Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Unit Price (LCY)"; "Unit Price (LCY)")
            // {
            //     Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Line Amount"; "Line Amount")
            // {
            //     AutoFormatExpression = GetTotalingAutoFormatExpr(1, FIELDNO("Line Amount"), false);
            //     AutoFormatType = 2014410;
            //     BlankZero = true;
            //     Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
            //     Editable = false;
            //     Visible = false;
            // }
            // field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Direct Unit Cost"), true))
            // {
            //     AutoFormatExpression = GetCurrencyCodeFromHeader;
            //     AutoFormatType = 2;
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassVar(PageText2014411);
            //     CaptionML = ENU = 'Total Direct Unit Cost',
            //                 FRA = 'Total coût unitaire directe';
            //     Description = 'DITW17.10.05 DIT-770 #988';
            //     Editable = false;
            //     QuickEntry = false;
            //     Visible = false;
            // }
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
            // } //BC Upgrade GUNREM01 << DIT
        }
        addafter("Appl.-to Item Entry")
        {
            //BC Upgrade GUNREM01 >> DIT
            // field(Weight; Rec.Weight)
            // {
            //     Editable = false;
            // }
            // field(Cubage; Cubage)
            // {
            //     Editable = false;
            // }
            // field(Distance; Distance)
            // {
            //     Editable = false;
            // }
            // field("AAD No."; "AAD No.")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("LRN No."; "LRN No.")
            // {
            //     Description = 'DITW15.00.00.38 #1217';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ARC No."; "ARC No.")
            // {
            //     Description = 'DITW15.00.00.38 #1217';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("SAD No."; "SAD No.")
            // {
            //     Description = 'DITW15.00.00.38 #1217';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ARC Line No."; "ARC Line No.")
            // {
            //     Visible = false;
            // }
            // field("Unsatisfactory Type"; "Unsatisfactory Type")
            // {
            //     Visible = false;
            // }
            // field("Unsatisfactory Quantity"; "Unsatisfactory Quantity")
            // {
            //     Visible = false;
            // }
            // field("Unsatisfactory Comment"; "Unsatisfactory Comment")
            // {
            //     Editable = false;
            //     OptionCaptionML = ENU = 'Bitmap7,Bitmap6',
            //                       FRA = 'Bitmap7,Bitmap6';
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         UnsatisfactoryCommentOnPush;
            //     end;
            // }
            // field("Applies-to AAD Trck. Entry No."; "Applies-to AAD Trck. Entry No.")
            // {
            //     Description = 'DITW15.00.00.39 #1369';
            //     Visible = false;
            // }
            // field("Free Item"; "Free Item")
            // {
            //     Editable = false;
            // }
            // field("Free Item Posting Type"; "Free Item Posting Type")
            // {
            //     Visible = false;
            // }
            // field("Gen. Prod. Posting Free Group"; "Gen. Prod. Posting Free Group")
            // {
            //     Visible = false;
            // }
            //BC Upgrade GUNREM01 << DIT
        }
        addafter(Correction)
        {
            field("SPL Code"; Rec."SPL Code FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the SPL Code field.';
            }
            field("SPL Name"; Rec."SPL Name FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the SPL Name field.';
            }
            //BC Upgrade GUNREM01 >> -Fields Added in interface

            // field("Zycus Order No."; Rec."Zycus Order No.")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Zycus Order Line No."; Rec."Zycus Order Line No.")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Zycus PR Reference No."; Rec."Zycus PR Reference No.")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Zycus PO Type Code"; Rec."Zycus PO Type Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Zycus PO Line Type Code"; Rec."Zycus PO Line Type Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Zycus PO Line Validated"; Rec."Zycus PO Line Validated")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Zycus Movement Type"; Rec."Zycus Movement Type")
            // {
            //     Editable = false;
            //     Visible = false;
            // } 
            //BC Upgrade GUNREM01 << -Fields added in interface
        }
    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(OrderTracking)
        {
            CaptionML = ENU = 'Order &Tracking', FRA = 'C&haînage';
        }
        //BC Upgrade GUNREM01 >> added in Interface
        modify("&Undo Receipt")
        {
            CaptionML = ENU = '&Undo Receipt', FRA = '&Annuler réception';
            ToolTipML = ENU = 'Cancel the quantity posting on the selected posted receipt line. A corrective line is inserted under the selected receipt line. If the quantity was received in a warehouse receipt, then a corrective line is inserted in the posted warehouse receipt. The Quantity Received and Qty. Rcd. Not Invoiced fields on the related purchase order are set to zero.', FRA = 'Annulez la validation de la quantité sur la ligne réception validée sélectionnée. Une ligne de correction est insérée sous la ligne réception sélectionnée. Si la quantité a été reçue dans une réception entrepôt, une ligne de correction est insérée dans la réception entrepôt validée. Les champs Quantité reçue et Qté reçue non facturée de la commande achat associée sont remis à zéro.';
            //BC Upgrade GUNREM01 >>
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //HEI.03>>
                PurchRcptHeader.GET(Rec."Document No.");
                IF (PurchRcptHeader."SRM Order No. FND" <> '') AND (rec.Type = rec.Type::"Fixed Asset") THEN
                    ERROR(UndoFASRMError);
                //HEI.03<<
            end;
            //BC Upgrade GUNREM01 >>
        } //BC Upgrade GUNREM01 << added in Interface
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Comments)
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(ItemTrackingEntries)
        {
            CaptionML = ENU = 'Item &Tracking Entries', FRA = 'Écritures &traçabilité';
        }
        modify(ItemInvoiceLines)
        {
            CaptionML = ENU = 'Item Invoice &Lines', FRA = '&Lignes facture article';
        }
        // addfirst(ActionContainer1900000004)//BC upgrade GUNREM01 >>DIT

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
        // }
        // action("- Collapse")
        // {
        //     CaptionML = ENU = '- Collapse',
        //                 FRA = '- Réduire';
        //     Enabled = ExpandLines;
        //     Image = ViewDetails;
        //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //     //PromotedCategory = Process;
        //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
        //     //PromotedIsBig = true;
        //     Visible = ExpandLines OR ShowButtonsCE;

        //     trigger OnAction();
        //     begin
        //         // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        //         ExpandLines := false;
        //         CurrPage.UPDATE(true);
        //         // >>DITW17.10.03 DDR DIT-770 #541
        //     end;
        // }
        //  }
        // addafter(Comments)
        // {
        //     action("Unsatisfactory Comment")
        //     {
        //         CaptionML = ENU = 'Unsatisfactory Comment',
        //                     FRA = 'Commentaires insatisfaisant';

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.38 DDR 05/10/2010
        //             //This functionality was copied from page #136. Unsupported part was commented. Please check it.
        //             /*CurrPage.PurchReceiptLines.PAGE.*/
        //             _ShowLineUnstatisfactoryCmts();

        //         end;
        //     }
        // }
        // BC Upgrade GUNREM01 << DIT
    }

    var
        UndoFASRMError: Label 'Undo Receipt is not allowed for SRM Orders Manually.Please cancel GR in SRM';
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Direct Unit Cost', FRA = 'Total coût unitaire directe';
        DisabledRefreshLines: Boolean;
        ExpandLines: Boolean;
        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        GlobItem: Record Item;
        GeneralLedgerSetup: Record "General Ledger Setup";
        EnableCAD: Boolean;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    IndentLine := IndentRecordDIT(ExpandLines);
    // >>DITW17.10.03 DDR DIT-770 #541
    // <<DITW15.00.00.01 DDR 27/12/2007 - DITW15.00.00.38 DDR 16/07/2010 #1194
    // <<DITW15.00.00.38 DDR 05/10/2010 #1217
    CALCFIELDS("Unsatisfactory Comment");
    // >>DITW15.00.00.38 DDR

    // << DITW110.00.10 SFI 20/06/2017 BL#15657
    if (GlobItem."No." <> "No.") and (Type = Type::Item) then begin
      if not GlobItem.GET("No.") then
        CLEAR(GlobItem);
    end else
      CLEAR(GlobItem);
    // >> DITW110.00.10 SFI BL#15657
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


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    ExpandLines := false;
    ShowButtonsCE := IsShowButtonsCEDIT();
    // >>DITW17.10.03 DDR DIT-770 #541

    //HEI.01>>
    GeneralLedgerSetup.GET;
    EnableCAD := GeneralLedgerSetup."Enable CAD";
    //HEI.01<<
    */
    //end;
    trigger OnOpenPage()
    begin
        //HEI.01>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.01<<
    end;
    // procedure UndoFASRMError();
    // begin
    // end;

    // procedure PurchRcptHeader();
    // begin
    // end;


    //Unsupported feature: CodeModification on "UndoReceiptLine(PROCEDURE 2)". Please convert manually.

    //procedure UndoReceiptLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchRcptLine.COPY(Rec);
    CurrPage.SETSELECTIONFILTER(PurchRcptLine);
    CODEUNIT.RUN(CODEUNIT::"Undo Purchase Receipt Line",PurchRcptLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //HEI.03>>
    PurchRcptHeader.GET("Document No.");
    if (PurchRcptHeader."SRM Order No."<>'') and (Type= Type::"Fixed Asset") then
       ERROR(UndoFASRMError);
    //HEI.03<<
    #1..3
    */
    //end;
    //BC Upgrade GUNREM01 >> DIT
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
    //BC Upgrade GUNREm01 << DIT
    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

