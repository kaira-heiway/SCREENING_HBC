pageextension 53041 PostedReturnReceiptSubformExt extends "Posted Return Receipt Subform"
{
    // version NAVW113.02,DITW113.00.15,HEI.02,HEI.03


    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 02/01/2008 Added column "Line No." (not editable)
    //                                property Editable Form = yes (but all fields are non editable except Collapse button)
    // DITW15.00.00.01 DDR 15/01/2007 Added property Form InsertAllowed,ModifyAllowed,DeleteAllowed=No
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.28 DDR 24/11/2008 Added fields "AAD No."
    // DITW15.00.00.32 DDR 23/03/2009 Added fields  (zycus editable)
    //                                  "Empty Goods Item No."
    // DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    "LRN No.","ARC No.","SAD No."
    //                                  Hidden fields
    //                                    "AAD No."
    //                     05/10/2010   Added fields
    //                                    "ARC Line No.","Unsatisfactory reason","Unsatisfactory quantity","unsatisfactory comments"
    //                                  Added functions
    //                                    ShowLineUnstatisfactoryCmts()
    //                                  Set not editable fields if undo is done
    //                     26/11/2010 #1217 (DIT711 56)
    //                                  Added fields "Arc Line No." (editable)
    //                     17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    //                                  Non editable field "Free Item"
    //                     03/01/2011 issue 1217 (DIT711 56) Removed non editable when Arc Line No. is filled
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    // DITW15.00.00.39 DDR 11/07/2011 issue 1369 Added fields "Applies-to AAD Trck. Entry No."
    // DITW16.00.00.39 DDR 26/09/2011 DIT-715 #141 Added "Total Amount" column for all line types
    //                                             Added functions UpdateFormatField(),UpdateFields()
    // DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  Added function SetDisableRefreshLines() to call before/after each report object
    //                                                 (don't use the <RunObject> property)
    // DITW16.00.00.41 AHU 06/11/2012 DIT-715 #393 Added "Description 2" field
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.03 DDR 21/05/2014 DIT-770 #623 Added non-editable fields "Customer DTax Group Code","Item DTax Group Code",
    //                                           "ARC No. Mandatory"
    // DITW18.00.06 DDR 02/03/2015 DIT-770 #1191 Added fields "Responsiblity Center","Physical Location Group Code"
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Unit Price"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW113.00.15 DDR 04/10/2019 NRQ#10495 Rename Loyalty 'Cost' -> 'Amount' (all fields)
    // HEI.01 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Field added: "CAD Amount"
    // HEI.02 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - Zycus Order Line No.
    // HEI.03 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Field - Zycus Movement Type

    //Bc Upgrade YADAVM09 Drink it field commented.
    // BC Upgrade BHARDA11 Enable CAD Amount Field

    layout
    {
        modify(Type)
        {
            Editable = false;//BC Upgrade YADAVM09<<
        }
        modify("No.")
        {
            Editable = false;//BC Upgrade YADAVM09<<
        }
        modify("Variant Code")
        {
            Editable = false;//BC Upgrade YADAVM09<<
        }
        modify("Return Reason Code")
        {
            Editable = false;//BC Upgrade YADAVM09<<
        }
        modify(Description)
        {
            Editable = false;//BC Upgrade YADAVM09<<
        }
        modify("Location Code")
        {
            Editable = false;//BC Upgrade YADAVM09<<
        }
        modify("Bin Code")
        {
            Editable = false;//BC Upgrade YADAVM09<<
        }
        modify(Quantity)
        {
            Editable = false;//BC Upgrade YADAVM09<<
        }
        modify("Unit of Measure")
        {
            Editable = false;//BC Upgrade YADAVM09<<
        }
        modify("Unit of Measure Code")
        {
            Editable = false;//BC Upgrade YADAVM09<<
        }
        modify("Quantity Invoiced")
        {
            Editable = false;//BC Upgrade YADAVM09<<
        }
        modify("Shipment Date")
        {
            Editable = false;//BC Upgrade YADAVM09<<
        }
        modify("Appl.-to Item Entry")
        {
            Editable = false;//BC Upgrade YADAVM09<<
        }


        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change Editable on "Type(Control 2)". Please convert manually.


        //Unsupported feature: Change Editable on ""No."(Control 4)". Please convert manually.


        //Unsupported feature: Change Editable on ""Cross-Reference No."(Control 24)". Please convert manually.


        //Unsupported feature: Change Editable on ""Variant Code"(Control 14)". Please convert manually.


        //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.


        //Unsupported feature: Change Editable on ""Return Reason Code"(Control 18)". Please convert manually.


        //Unsupported feature: Change Editable on ""Location Code"(Control 46)". Please convert manually.


        //Unsupported feature: Change Editable on ""Bin Code"(Control 28)". Please convert manually.


        //Unsupported feature: Change Editable on "Quantity(Control 8)". Please convert manually.


        //Unsupported feature: Change Editable on ""Unit of Measure Code"(Control 22)". Please convert manually.


        //Unsupported feature: Change Editable on ""Unit of Measure"(Control 10)". Please convert manually.


        //Unsupported feature: Change Editable on ""Quantity Invoiced"(Control 12)". Please convert manually.


        //Unsupported feature: Change Editable on ""Return Qty. Rcd. Not Invd."(Control 20)". Please convert manually.


        //Unsupported feature: Change Editable on ""Shipment Date"(Control 16)". Please convert manually.


        //Unsupported feature: Change Editable on ""Job No."(Control 38)". Please convert manually.


        //Unsupported feature: Change Editable on ""Appl.-to Item Entry"(Control 42)". Please convert manually.


        //Unsupported feature: Change Editable on ""Shortcut Dimension 1 Code"(Control 50)". Please convert manually.


        //Unsupported feature: Change Editable on ""Shortcut Dimension 2 Code"(Control 48)". Please convert manually.

        // addfirst(Control1)
        // {
        //     field("Has Item Charge"; Rec."Has Item Charge")
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
        // }//Bc Upgrade YADAVM09 Drink it field<<
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
        // }//Bc Upgrade YADAVM09 Drink it field<<

        addafter("Return Reason Code")
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
        // BC Upgrade BHARDA11 >>
        addafter(Quantity)
        {
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                ApplicationArea = All;
                Visible = EnableCAD;
            }
        }
        // addafter("Unit of Measure")
        // {
        //     field("Unit Price"; Rec."Unit Price")
        //     {
        //         AutoFormatExpression = GetTotalingAutoFormatExpr(2, FIELDNO("Unit Price"), false);
        //         AutoFormatType = 2014410;
        //         BlankZero = true;
        //         Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Line Amount"; Rec."Line Amount")
        //     {
        //         AutoFormatExpression = GetTotalingAutoFormatExpr(1, FIELDNO("Line Amount"), false);
        //         AutoFormatType = 2014410;
        //         BlankZero = true;
        //         Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Unit Price"), true))
        //     {
        //         AutoFormatExpression = GetCurrencyCode;
        //         AutoFormatType = 2;
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassVar(PageText2014411);
        //         CaptionML = ENU = 'Total Unit Price',
        //                     FRA = 'Total prix unitaire';
        //         Description = 'DITW17.10.05 DIT-770 #988';
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //     }
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
        //     }
        // }//Bc Upgrade YADAVM09 Drink it field<<
        // addafter("Appl.-to Item Entry")
        // {
        //     field("Customer DTax Group Code"; "Customer DTax Group Code")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Item DTax Group Code"; "Item DTax Group Code")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("AAD No."; "AAD No.")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("LRN No."; "LRN No.")
        //     {
        //         Description = 'DITW15.00.00.38 #1217';
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("ARC No."; "ARC No.")
        //     {
        //         Description = 'DITW15.00.00.38 #1217';
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("SAD No."; "SAD No.")
        //     {
        //         Description = 'DITW15.00.00.38 #1217';
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("ARC No. Mandatory"; "ARC No. Mandatory")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
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
        //     field("Applies-to AAD Trck. Entry No."; Rec."Applies-to AAD Trck. Entry No.")
        //     {
        //         Description = 'DITW15.00.00.39 #1369';
        //         Visible = false;
        //     }
        //     field("Free Item"; Rec."Free Item")
        //     {
        //         Editable = false;
        //     }
        //     field("Free Item Posting Type"; Rec."Free Item Posting Type")
        //     {
        //         Visible = false;
        //     }
        //     field("Gen. Prod. Posting Free Group"; Rec."Gen. Prod. Posting Free Group")
        //     {
        //         Visible = false;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it field<<
        addafter("Shortcut Dimension 2 Code")
        {
            field("Item Type"; Rec."Item Type FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
            field("RPM Solution"; Rec."RPM Solution FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
            // field("Loyalty Point Type"; Rec."Loyalty Point Type")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Unit Point"; Rec."Loyalty Unit Point")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Points Qty. (Base)"; "Loyalty Points Qty. (Base)")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Amount Type"; "Loyalty Amount Type")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Unit Amount"; "Loyalty Unit Amount")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Unit Amount (LCY)"; "Loyalty Unit Amount (LCY)")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Amount"; "Loyalty Amount")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Amount (LCY)"; "Loyalty Amount (LCY)")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Visible = false;
            // }
            // field("Loyalty Convert to Free Item"; "Loyalty Convert to Free Item")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }//Bc Upgrade YADAVM09 Drink it field<<
            field("RPM Type"; Rec."RPM Type FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }

        }
    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("&Undo Return Receipt")
        {
            CaptionML = ENU = '&Undo Return Receipt', FRA = '&Annuler réception retour';
        }
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
        modify(ItemCreditMemoLines)
        {
            CaptionML = ENU = 'Item Credit Memo &Lines', FRA = '&Lignes avoir article';
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
        // }//Bc Upgrade YADAVM09 Drink it Action<<
        // addafter(Comments)
        // {
        //     action("Unsatisfactory Comment")
        //     {
        //         CaptionML = ENU = 'Unsatisfactory Comment',
        //                     FRA = 'Commentaires insatisfaisant';

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.38 DDR 05/10/2010
        //             //This functionality was copied from page #6660. Unsupported part was commented. Please check it.
        //             /*CurrPage.ReturnRcptLines.PAGE.*/
        //             _ShowLineUnstatisfactoryCmts();

        //         end;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it Action<<
    }

    var
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Unit Price', FRA = 'Total prix unitaire';
        DisabledRefreshLines: Boolean;
        ExpandLines: Boolean;
        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        EnableCAD: Boolean;


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
    trigger OnOpenPage()
    begin
        //HEI.01>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.01<<
    end;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
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

    // procedure _ShowLineUnstatisfactoryCmts();
    // begin
    //     // <<DITW15.00.00.38 DDR 05/10/2010
    //     Rec.ShowLineUnstatisfactoryCmts();
    // end;//Bc Upgrade YADAVM09 Drink it Function<<

    // procedure ShowLineUnstatisfactoryCmts();
    // begin
    //     // <<DITW15.00.00.38 DDR 05/10/2010
    //     Rec.ShowLineUnstatisfactoryCmts();
    // end;//Bc Upgrade YADAVM09 Drink it Function<<

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
    // end;//Bc Upgrade YADAVM09 Drink it Function<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

