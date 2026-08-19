pageextension 52030 PostedReturnShipmentSubformExt extends "Posted Return Shipment Subform"
{
    // version NAVW113.02,DITW113.00.15,HEI.03,HEI.04

    //     DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 02/01/2008 Added column "Line No." (not editable)
    //                                property Editable Form = yes (but all fields are non editable except Collapse button)
    // DITW15.00.00.01 DDR 15/01/2008 Added property Form InsertAllowed,ModifyAllowed,DeleteAllowed=No
    // DITW15.00.00.01 DDR 15/02/2008 Added function UpdateFormatField()
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.28 DDR 24/11/2008 Added fields "AAD No."
    // DITW15.00.00.32 DDR 23/03/2009 Added fields (not editable) "Empty Goods Item No.","AAD No. Series"
    // DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //                     21/08/2009 issue 727 Added HorzAlign property in field "Direct Unit Cost"
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    "EMCS LRN Nos Series","EMCS LRN No.",
    //                                    "EMCS ARC No.","EMCS SAD No."
    //                                  Added editable fields
    //                                    "Packaging Type Code","No. of Packages","Commercial Seal ID"
    //                                  Hidden fields
    //                                    "AAD Nos Series","AAD No."
    //                     08/10/2010   Added fields
    //                                    "Cancellation Reason Code"
    //                                  Set not editable fields if undo is done
    //                     17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    //                                  non editable field "Free Item"
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    // DITW15.00.00.39 DDR 11/07/2011 issue 1369 Added fields "Applies-to AAD Trck. Entry No."
    // DITW16.00.00.40 DDR 22/12/2011 DIT-715 issue 187
    //                                        Resize Width Form
    //                                        Added fields "Cancellation Reason Comment"
    //                                        Added functions ShowLineCancelReasonCmts()
    //                     11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  Added function SetDisableRefreshLines() to call before/after each report object
    //                                                 (don't use the <RunObject> property)
    // DITW16.00.00.41 AHU 06/11/2012 DIT-715 #393 Added "Description 2" field
    // DITW16.00.00.43 DDR 23/08/2013 DIT-715 #720 Added functions

    // DITW17.00.02 DDR 23/08/2013 DIT-715 #720 merge
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 02/03/2015 DIT-770 #1190 Added fields "Responsiblity Center","Physical Location Group Code"
    // DITW17.10.05 MSF 17/07/2014 DIT-770 #698 (Customer)Vendor suspended tax determined per document line + internal taxes
    //                                           Added non-editable fields "Vendor DTax Group Code","Item DTax Group Code"
    // DITW17.10.05 WSA 05/11/2014 DIT-770 #185 Added Loyalty Fields
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Direct Unit Cost"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 28/03/2017 NRQ#9647 automatically open Cancellation Reason Comments when changing Cancellation Reason Type
    //                                       delete nav2009 function CancellationReasonTypeOnAfterV;
    //                                       Added fields "Line No.","ARC No. Mandatory"
    // DITW113.00.15 DDR 04/10/2019 NRQ#10495 Rename Loyalty 'Cost' -> 'Amount' (all fields)
    // HEI.01 FDD-HT2159 - CHG2105031 IBM NASTAA02 16.08.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field added: "CAD Amount"
    // HEI.02 CHG2217161 SAHAL01 02.11.2023 SPL for Returns and GR cancellations
    //   # Added New Fields - SPL Code
    //                      - SPL Name
    //                      - Consumption SPL Code
    // HEI.03 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - Zycus Order Line No.
    // HEI.04 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Field - Zycus Movement Type

    //Bc Upgrade YADAVM09 Drink it fields and actions are blocked.
    //Bc Upgrade YADAVM09 interface fields added in interface extension.


    layout
    {
        //Bc Upgrade YADAVM09>>
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
        modify("Return Reason Code")
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
        modify("Unit of Measure")
        {
            Editable = false;
        }
        modify("Unit of Measure Code")
        {
            Editable = false;
        }

        modify("Direct Unit Cost")
        {
            Editable = false;
        }

        modify("Prod. Order No.")
        {
            Editable = false;
        }
        modify("Appl.-to Item Entry")
        {
            Editable = false;
        }
        modify("Quantity Invoiced")
        {
            Editable = false;
        }

        //Bc Upgrade YADAVM09<<



        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change Editable on "Type(Control 2)". Please convert manually.


        //Unsupported feature: Change Editable on ""No."(Control 4)". Please convert manually.


        //Unsupported feature: Change Editable on ""Cross-Reference No."(Control 66)". Please convert manually.


        //Unsupported feature: Change Editable on ""Variant Code"(Control 46)". Please convert manually.


        //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.


        //Unsupported feature: Change Editable on ""Return Reason Code"(Control 16)". Please convert manually.


        //Unsupported feature: Change Editable on ""Location Code"(Control 40)". Please convert manually.


        //Unsupported feature: Change Editable on ""Bin Code"(Control 22)". Please convert manually.


        //Unsupported feature: Change Editable on "Quantity(Control 8)". Please convert manually.


        //Unsupported feature: Change Editable on ""Unit of Measure Code"(Control 64)". Please convert manually.


        //Unsupported feature: Change Editable on ""Unit of Measure"(Control 10)". Please convert manually.


        //Unsupported feature: Change AutoFormatType on ""Direct Unit Cost"(Control 12)". Please convert manually.


        //Unsupported feature: Change AutoFormatExpr on ""Direct Unit Cost"(Control 12)". Please convert manually.


        //Unsupported feature: Change Editable on ""Direct Unit Cost"(Control 12)". Please convert manually.


        //Unsupported feature: Change Editable on ""Quantity Invoiced"(Control 14)". Please convert manually.


        //Unsupported feature: Change Editable on ""Job No."(Control 34)". Please convert manually.


        //Unsupported feature: Change Editable on ""Prod. Order No."(Control 62)". Please convert manually.


        //Unsupported feature: Change Editable on ""Appl.-to Item Entry"(Control 36)". Please convert manually.


        //Unsupported feature: Change Editable on ""Shortcut Dimension 1 Code"(Control 56)". Please convert manually.


        //Unsupported feature: Change Editable on ""Shortcut Dimension 2 Code"(Control 54)". Please convert manually.

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
        // }
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
                ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            }
            // field("Physical Location Group Code"; "Physical Location Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
        }
        addafter("Direct Unit Cost")
        {
            field("Indirect Cost %"; Rec."Indirect Cost %")
            {
                Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
                Editable = false;
                Visible = false;
                ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            }
            field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
            {
                Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
                Editable = false;
                Visible = false;
                ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            }
            field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
            {
                Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
                Editable = false;
                Visible = false;
                ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            }
            // field("Line Amount"; Rec."Line Amount")
            // {
            //     // AutoFormatExpression = GetTotalingAutoFormatExpr(1, FIELDNO("Line Amount"), false);
            //     // AutoFormatType = 2014410;
            //     // BlankZero = true;
            //     // Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
            //     // Editable = false;
            //     // Visible = false;
            // }//Bc Upgrade YADAVM09 Drink it field<<
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                ApplicationArea = All;
            }//Bc Upgrade YADAVM09 <<
            // field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Direct Unit Cost"), true))
            // {
            //     AutoFormatExpression = GetCurrencyCode;
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
            //     AutoFormatExpression = GetCurrencyCode;
            //     AutoFormatType = 1;
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassVar(PageText2014410);
            //     CaptionML = ENU = 'Total Line Amount',
            //                 FRA = 'Montant total ligne';
            //     Description = 'DITW17.10.02B DIT-770 #541';
            //     Editable = false;
            // }//Bc Upgrade YADAVM09 Drink it field<<
        }
        // addafter("Appl.-to Item Entry")
        // {
        //     field("Vendor DTax Group Code"; "Vendor DTax Group Code")
        //     {
        //         Description = 'DIT-770 #698';
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Item DTax Group Code"; "Item DTax Group Code")
        //     {
        //         Description = '<DITW15.00.00.01>- DIT-770 #698';
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("AAD No. Series"; "AAD No. Series")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("AAD No."; "AAD No.")
        //     {
        //         Editable = false;
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
        //     field("LRN No. Series"; "LRN No. Series")
        //     {
        //         Description = 'DITW15.00.00.38 #1217';
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
        //         Visible = false;
        //     }
        //     field("Packaging Type Code"; Rec."Packaging Type Code")
        //     {
        //         Editable = "Packaging Type CodeEditable";
        //         Visible = false;
        //     }
        //     field("No. of Packages"; Rec."No. of Packages")
        //     {
        //         Editable = "No. of PackagesEditable";
        //         Visible = false;
        //     }
        //     field("Commercial Seal ID"; Rec."Commercial Seal ID")
        //     {
        //         Editable = "Commercial Seal IDEditable";
        //         Visible = false;
        //     }
        //     field("Cancellation Reason Type"; Rec."Cancellation Reason Type")
        //     {
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW110.00.09 DDR 28/03/2017 NRQ#9647
        //             CurrPage.SAVERECORD;
        //             COMMIT;
        //             CancellationReasonCommenOnPush;
        //             CurrPage.UPDATE(false);
        //             // >>DITW110.00.09 DDR NRQ#9647
        //         end;
        //     }
        //     field("Cancellation Reason Comment"; Rec."Cancellation Reason Comment")
        //     {
        //         Description = 'DIT715 #187';
        //         Editable = false;
        //         OptionCaptionML = ENU = 'Bitmap7,Bitmap6',
        //                           FRA = 'Bitmap7,Bitmap6';
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             CancellationReasonCommenOnPush;
        //         end;
        //     }
        //     field("Applies-to AAD Trck. Entry No."; Rec."Applies-to AAD Trck. Entry No.")
        //     {
        //         Description = 'DITW15.00.00.39 #1369';
        //         Visible = false;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it fields<<
        addafter(Correction)
        {
            // field("Loyalty Amount"; Rec."Loyalty Amount")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Amount (LCY)"; Rec."Loyalty Amount (LCY)")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Visible = false;
            // }
            // field("Loyalty Convert to Free Item"; Rec."Loyalty Convert to Free Item")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Point Type"; Rec."Loyalty Point Type")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Amount Type"; Rec."Loyalty Amount Type")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }//Bc Upgrade YADAVM09 Drink it fields<<
            field("Line No."; Rec."Line No.")
            {
                Visible = false;
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
            field("SPL Code"; Rec."SPL Code FND")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
            field("SPL Name"; Rec."SPL Name FND")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
            field("Consumption SPL Code"; Rec."Consumption SPL Code FND")
            {
                Visible = false;
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
            // field("Zycus Order No."; Rec."Zycus Order No.")
            // {
            //     Editable = false;
            //     Visible = false;
            //     ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            // }
            // field("Zycus Order Line No."; Rec."Zycus Order Line No.")
            // {
            //     Editable = false;
            //     ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            //     Visible = false;
            // }
            // field("Zycus Movement Type"; Rec."Zycus Movement Type")
            // {
            //     Editable = false;
            //     Visible = false;
            //     ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            // }//Bc Upgrade YADAVM09 fields added in Interface Extension<<
        }
    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("&Undo Return Shipment")
        {
            CaptionML = ENU = '&Undo Return Shipment', FRA = '&Annuler expédition retour';
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
        //  }
        //}//Bc Upgrade YADAVM09 Drink it action<<

        // addafter("F&unctions")
        // {
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
        //                 //This functionality was copied from page #6650. Unsupported part was commented. Please check it.
        //                 /*CurrPage.ReturnShptLines.FORM.*/
        //                 _OpenEDIDocument();
        //                 // >>DITW16.00.00.43 DDR DIT-715 #720

        //             end;
        //         }
        //     }
        //}//Bc Upgrade YADAVM09 Drink it action<<
        // addafter(Comments)
        // {
        //     action("Cancellation Reason Comments")
        //     {
        //         CaptionML = ENU = 'Cancellation Reason Comments',
        //                     FRA = 'Commentaires raison d''annulation';

        //         trigger OnAction();
        //         begin
        //             // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
        //             //This functionality was copied from page #6650. Unsupported part was commented. Please check it.
        //             /*CurrPage.ReturnShptLines.PAGE.*/
        //             _ShowLineCancelReasonCmts;

        //         end;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it action<<
    }

    var
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Direct Unit Cost', FRA = 'Total coût unitaire directe';
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
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    IndentLine := IndentRecordDIT(ExpandLines);
    // >>DITW17.10.03 DDR DIT-770 #541
    // <<DITW15.00.00.01 DDR 27/12/2007 - DITW15.00.00.38 DDR 16/07/2010 #1194
    // <<DITW15.00.00.38 DDR 12/10/2010 #1217
    "Packaging Type CodeEditable" := (not Correction) and ("ARC No." = '');
    "No. of PackagesEditable" := (not Correction) and ("ARC No." = '');
    "Commercial Seal IDEditable" := (not Correction) and ("ARC No." = '');
    // >>DITW15.00.00.38 DDR #1217
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


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    "Commercial Seal IDEditable" := true;
    "No. of PackagesEditable" := true;
    "Packaging Type CodeEditable" := true;
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
    */
    //end;

    procedure _ShowDimensions();
    begin
        Rec.ShowDimensions;
    end;

    // procedure ShowDimensions();
    // begin
    //     Rec.ShowDimensions;
    // end;

    procedure _ShowItemTrackingLines();
    begin
        Rec.ShowItemTrackingLines;
    end;

    // procedure _ShowLineCancelReasonCmts();
    // begin
    //     // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
    //     Rec.ShowLineCancelReasonCmts();
    // end;//Bc Upgrade YADAVM09 Drink it functions<<

    // procedure ShowLineCancelReasonCmts();
    // begin
    //     // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
    //     Rec.ShowLineCancelReasonCmts();
    // end;//Bc Upgrade YADAVM09 Drink it functions<<

    // procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
    // begin
    //     // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    //     DisabledRefreshLines := NewDisabledRefreshLines;
    // end;

    // procedure _OpenEDIDocument();
    // var
    //     EmcsEdiMgt: Codeunit "EMCS EDI Mgt";
    // begin
    //     // <<DITW16.00.00.43 DDR 23/08/2013 DIT-715 #720
    //     EmcsEdiMgt.OpenEDIOutDocFile(DATABASE::"Return Shipment Line", 0, "Document No.", "LRN No.", "ARC No.");
    // end;

    // procedure OpenEDIDocument();
    // var
    //     EmcsEdiMgt: Codeunit "EMCS EDI Mgt";
    // begin
    //     // <<DITW16.00.00.43 DDR 23/08/2013 DIT-715 #720
    //     EmcsEdiMgt.OpenEDIOutDocFile(DATABASE::"Return Shipment Line", 0, "Document No.", "LRN No.", "ARC No.");
    // end;

    // local procedure CancellationReasonCommenOnPush();
    // begin
    //     // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
    //     ShowLineCancelReasonCmts();
    //     // >>DITW16.00.00.40 DDR DIT-715 #187
    // end;////Bc Upgrade YADAVM09 Drink it functions<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

