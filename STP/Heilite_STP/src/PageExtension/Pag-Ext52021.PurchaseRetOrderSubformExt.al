pageextension 52021 PurchaseRetOrderSubformExt extends "Purchase Return Order Subform"
{
    // version NAVW110.0,FINXL7.00.001,QXL9.00.001,DITW110.00.09,HEI.07,HEI.08
    // DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    //   DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.01 DDR 02/01/2007 Added column "Line No." (not editable)
    //                                  Bugfix AutoSplitKey process on new record with Collapse/Expand functionnality
    //   DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    //   DITW15.00.00.01 DDR 10/01/2008 Bugfix using F8 on new line
    //                                  Change property HorzAlign=Right for collapsed total fields (line amount)
    //                                  Added parameter BlankZero for function UpdateFormatField()
    //                                  Remove ProcessTaxItemCharge();ProcessUpdateUnitPrice();InsertTaxItemCharge();
    //   DITW15.00.00.01 DDR 23/01/2008 Added Drink-it Discount & Promotion Item Charges functionnalities
    //                                  Added field "Collapse"
    //                                  Bugfix Refresh columns
    //                                  Added function UpdateExpandStatus
    //                                  Change function UpdateFields for Discount & Promotion
    //   DITW15.00.00.01 DDR 19/03/2008 move function InsertExtendedCharges()
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.16 DDR 26/03/2008 Remove (move into function) confirm message from function InsertExtendedCharges()
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.23 DDR 29/07/2008 Remove call function InsertExtendedCharges() from trigger OnAfterValidate field "No."
    //                                  Updated function into InsertExtendedCharges()
    //                       31/07/2008 Move NewRecord() function into OnNewRecord trigger
    //   DITW15.00.00.28 DDR 24/11/2008 Added fields "AAD No. Series","Tariff No."
    //   DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
    //                                    "Empty Goods Item No."
    //   DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //                       21/08/2009 issue 727 Added HorzAlign property in field "Direct Unit Cost"
    //                   DLE 06/09/2009 issue 516 Added field "Physical Location Group Code"
    //                   DDR 14/10/2009 issue 893 Removed fields "Gen. Prod. Posting Free Group"
    //   DITW15.00.00.36 DDR 04/11/2009 issue 939 Performance SQL
    //                                  Added function FormTotalingField()
    //   DITW15.00.00.37 DDR 26/01/2009 issue 939 Performance SQL error call function into OnModify() trigger
    //                       01/06/2010 issue 959 Moved column field "AAD No."
    //                       02/06/2010 issue 1061 Added default Not visible fields "Physical Location Group Code"
    //   DITW15.00.00.37 PRODW14.00.00.16 DDR 23/06/2010 issue 1151 Added to remove Quarantine Quality test when delete purchase line
    //   DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                    Added parmater et return value for function ReadExpansionStatus()
    //                                    Remove functions FormTotalingField()
    //                                    Rewrite functions UpdateFields(),FormTotalingField()
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                   DDR 30/07/2010           Remove OnFormat() field "No."
    //                   CEL 13/08/2010           Modification RTC buttons
    //   DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                    Added fields
    //                                      "EMCS LRN Nos Series"
    //                                    Hidden fields
    //                                      "AAD Nos Series"
    //                       08/10/2010   Added fields
    //                                      "SAD No."
    //                       17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    //                       27/01/2011 issue 1259 Added update() on field "Cross-Reference No."
    //                                             Added non-editable when item is (free) item charge
    //   DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                               Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //   DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                             Added parameter line function RTCActionNewLine() into RTCNewLine button
    //   DITW16.00.00.38 DDR 03/03/2011 DIT-715 #1 RTC Upgrade Page functionnalities
    //                                               Modified function UpdateFields()
    //   DITW16.00.00.38 DDR 07/03/2011 DIT-715 #71 RTC Upgrade Page functionnalities
    //                                               Modified order position RTC buttons
    //                                                 contol1102601007 RTCNewLine
    //                                                 contol1102601008 RTCDeleteLine
    //                                                 contol1102601009 RTCDleteAllLines
    //                       15/03/2011 issue 1291 Modified trigger field "No." activate function InsertExtendedText() other than items
    //                       16/03/2011 issue 1217 (DIT711 161) Added field "Packaging Type Code"
    //   DITW15.00.00.39 DDR 11/07/2011 issue 1369 Added fields "Applies-to AAD Trck. Entry No."
    //   DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade Added/Review Total Line Amount (Collapsed RTC)
    //                       26/08/2011 issue 1393 Added AssistEdit property/trigger for field "Item No."
    //                       26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    //   DITW16.00.00.40 DDR 22/12/2011 issue 1429 Added functions OpenSSCCTrackingLines()
    //   DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)"
    //                       11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                    Added function SetDisableRefreshLines() to call before/after each report object
    //                                                   (don't use the <RunObject> property)
    //                       03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                               Modified OnAssistEdit trigger field "No."
    //   DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added to call function SetFilterSubContractPostType() on AfterGetCurrRecord();
    //                                               Added to call function SetFilterSubContractPostType2() on OnNewRecord()
    //                                               Added fields "DIT Sub-Contract Type","Service Contract No.""Contract Group Code"
    //                   AHU 06/11/2012 DIT-715 #393 Added "Description 2" field

    //   FINXL7.00.001 RBE 20/03/2013 : Added fields "Tariff No." & "Net Weight" (not visible)
    //                                  Added field: "Auto. Acc. Group"
    //   DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    //   DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0014.1
    //                               added approved prod group + approved line amount
    //   DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW17.10.03 DDR 10/06/2014 DIT-770 #541 Modified 'QuickEntry' property fields "Has Item Charge","Collapse"
    //                                            Removed 'IndentationControls' field1 Group Repeater
    //   DITW17.10.03 DDR 10/07/2014 DIT-770 #541 Added editable other types than Item
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added field "Responsibity Center"
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //   DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                             Rename Field Service contract Type => Contract Type

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   QXL9.00.001 DAT 23/03/2016 : Quality Management
    //   DITW110.00.09 DDR 13/04/2017 NRQ#13107 Added missing EMCS Fields
    //   DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackUnitPriceItem()
    //   HEI.01 HLSRM02 IBM LAZARE02 01.11.2017 # New fields for SRM integration: SRM Order No., SRM Order Line No.

    //   HEI.02 PATHAA02  15.11.17 # Description Non-Editable only for Type=Item.
    //   HEI.03 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //     # New Field added: "TIN No."
    //   HEI.04 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //     # New Field added: "CAD Amount"
    //     # Code added on 'OnOpenPage' trigger
    //   HEI.05 CHG2155847 HB2821 IBM NANDIS01 10.11.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //     # fields - "Astro Unique ID" and "Expected Receipt Date" made visible
    //   HEI.06 CHG2217161 SAHAL01 02.11.2023 SPL for Returns and GR cancellations
    //     # Added New Fields - SPL Code
    //                        - SPL Name
    //                        - Consumption SPL Code
    //   HEI.07 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //     # Added New Fields - Zycus Order No.
    //                        - Zycus Order Line No.
    //                        - Zycus PR Reference No.
    //                        - Zycus PO Type Code
    //                        - Zycus PO Line Type Code
    //                        - Zycus PO Line Validated
    //   HEI.08 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //     # Added New Field - Zycus Movement Type
    //****************************************//
    //BC UPGRADE SIVA 20/01/2026
    // SUMMARY OF CHANGES:
    //1.HEI.01 SRM Order No., SRM Order Line No. fields are not exist in NAV Page & BC Page layout and usage for Store SRM Order No & logic with integration
    //2.HEI.02 procedure is from drink it code hence commented Ediabled condtions fields 
    //3.HEI.03 No changes
    //4.HEI.04 No changes
    //5.HEI.05 Commneted Astro Unique ID field is not in scope
    //6 HEI.06 No 
    //7.HEI.07,HEI.08  SRM Contract No.,SRM Contract Line No. Moved fields to Interface app & pageextension 58050    
    layout
    {
        //BC UPGRADE SIVA >> Drink It CODE
        // modify(Type)
        // {
        //     Enabled = TypeEnable;

        //     //Unsupported feature: Change Editable on "Type(Control 2)". Please convert manually.

        // }

        // //Unsupported feature: Change Editable on ""Cross-Reference No."(Control 72)". Please convert manually.


        // //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.

        // modify(Quantity)
        // {
        //     Enabled = QuantityEnable;

        //     //Unsupported feature: Change Editable on "Quantity(Control 8)". Please convert manually.

        // }

        // //Unsupported feature: Change Editable on ""Direct Unit Cost"(Control 12)". Please convert manually.

        // modify("Unit Price (LCY)")
        // {
        //     Enabled = "Unit Price (LCY)Enable";
        // }
        // modify("Line Amount")
        // {
        //     Enabled = "Line AmountEnable";

        //     //Unsupported feature: Change Editable on ""Line Amount"(Control 76)". Please convert manually.

        // }
        //BC UPGRADE SIVA << Drink It CODE

        //Unsupported feature: Change Editable on ""Return Qty. to Ship"(Control 56)". Please convert manually.


        //Unsupported feature: Change Editable on ""Qty. to Invoice"(Control 38)". Please convert manually.


        //Unsupported feature: Change Visible on ""Blanket Order Line No."(Control 70)". Please convert manually.

        modify("Invoice Discount Amount")
        {
            CaptionML = ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
        }
        modify("Invoice Disc. Pct.")
        {
            CaptionML = ENU = 'Invoice Discount %', FRA = '% remise facture';
        }
        modify("Total Amount Excl. VAT")
        {
            CaptionML = ENU = 'Total Amount Excl. VAT', FRA = 'Montant total HT';
        }
        modify("Total VAT Amount")
        {
            CaptionML = ENU = 'Total VAT', FRA = 'Total TVA';
        }
        modify("Total Amount Incl. VAT")
        {
            CaptionML = ENU = 'Total Amount Incl. VAT', FRA = 'Montant total TTC';
        }

        //Unsupported feature: CodeModification on "Type(Control 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        NoOnAfterValidate;

        if xRec."No." <> '' then
          RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TypeOnAfterValidate;
        #1..4
        */
        //end;


        //Unsupported feature: CodeInsertion on ""No."(Control 4)". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.39 DDR 26/08/2011 #1393 - DITW16.00.00.40 DDR 03/05/2012 DIT-715 #276
        if AssistEditItemTreeview("No.") then begin
          // validate trigger
          ShowShortcutDimCode(ShortcutDimCode);
          // aftervalidate trigger
          CurrPage.UPDATE(true);
        end else
          CurrPage.UPDATE(false);
        // >>DITW15.00.00.39 DDR #1393 - DITW16.00.00.40 DDR DIT-715 #276
        */
        //end;


        //Unsupported feature: CodeModification on ""No."(Control 4).OnValidate". Please convert manually.

        //trigger "(Control 4)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        NoOnAfterValidate;

        if xRec."No." <> '' then
          RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW17.10.03 DDR 10/06/2014 DIT-770 #541
        if not ("No.Editable" or "No.Enable") then begin
          "No." := xRec."No.";
          exit;
        end;
        // >>DITW17.10.03 DDR DIT-770 #541
        #1..5
        */
        //end;


        //Unsupported feature: CodeModification on ""Cross-Reference No."(Control 72).OnLookup". Please convert manually.

        //trigger "(Control 72)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CrossReferenceNoLookUp;
        InsertExtendedText(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CrossReferenceNoLookUp;
        // <<DITW15.00.00.38 DDR 27/01/2011 #1259
        //InsertExtendedText(FALSE);
        CurrPage.UPDATE;
        // >>DITW15.00.00.38 DDR #1259
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Variant Code"(Control 32)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        VariantCodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Control 60)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        LocationCodeOnAfterValidate;
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        if xRec."Location Code" <> "Location Code" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 DDR DIT-770 #1191
        */
        //end;


        //Unsupported feature: CodeModification on "Quantity(Control 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        QuantityOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Direct Unit Cost"(Control 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        DirectUnitCostOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Amount"(Control 76).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        LineAmountOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Discount %"(Control 16).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        LineDiscount37OnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Discount Amount"(Control 52).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        LineDiscountAmountOnAfterValid;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Return Qty. to Ship"(Control 56)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        ReturnQtytoShipOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Qty. to Invoice"(Control 38)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        QtytoInvoiceOnAfterValidate;
        */
        //end;
        addfirst(Control1)
        {
            //BC UPGRADE SIVA >> Drink IT fields 
            // field("Has Item Charge"; Rec."Has Item Charge")
            // {
            //     BlankZero = true;
            //     QuickEntry = false;
            // }
            // field(Collapse; Rec.Collapse)
            // {
            //     QuickEntry = false;
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW15.00.00.37 DDR 19/01/2010
            //         CurrPage.UPDATE(true);
            //         // >>DITW15.00.00.37 DDR
            //     end;
            // }
            //BC UPGRADE SIVA<<
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
        }
        addafter("VAT Prod. Posting Group")
        {
            //BC UPGRADE SIVA >> Drink IT code
            // field("GetTrackingItemNo()"; GetTrackingItemNo())
            // {
            //     CaptionML = ENU = 'Tracking Item No. (Item Charge)',
            //                 FRA = 'N° article traçable (Frais annexes)';
            //     DrillDownPageID = "Item List";
            //     Editable = false;
            //     LookupPageID = "Item List";
            //     TableRelation = IF ("Item Charge Type" = CONST(Tax)) Item WHERE("No." = FIELD("Tax Item No."))
            //     ELSE IF ("Item Charge Type" = CONST(Deposit)) Item WHERE("No." = FIELD("Empty Goods Item No."));
            //     Visible = false;

            //     trigger OnLookup(Text: Text): Boolean;
            //     begin
            //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
            //         Text := GetTrackingItemNo();
            //         LookupItemNo(Text);
            //         exit(false);
            //     end;
            // }
            //BC UPGRADE SIVA<<
        }
        addafter(Description)
        {   //BC UPGRADE SIVA>>// Description 2 already there in Base layout 
            // field("Description 2"; Rec."Description 2")
            // {
            //     ApplicationArea =all;
            //     Description = 'DIT-715 #393';
            //     Visible = false;
            // }
            //BC UPGRADE SIVA<< 
        }
        addafter("Return Reason Code")
        {
            //BC UPGRADE SIVA>> Drink IT fields
            // field("Responsibility Center"; Rec."Responsibility Center")
            // {
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
            //         if "Responsibility Center" <> xRec."Responsibility Center" then
            //             CurrPage.UPDATE(true);
            //         // >>DITW18.00.06 DDR DIT-770 #1191
            //     end;
            // }
            // field("Physical Location Group Code"; "Physical Location Group Code")
            // {
            //     QuickEntry = false;
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
            //         if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
            //             CurrPage.UPDATE(true);
            //         // >>DITW18.00.06 DDR DIT-770 #1191
            //     end;
            // }
            //BC UPGRADE SIVA<<
        }
        addafter(Quantity)
        {
            //BC UPGRADE SIVA >>CAD
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                ApplicationArea = all;
                ToolTip = 'CAD Amount';
                Visible = EnableCAD;
            }
            //BC UPGRADE SIVA<<CAD
        }
        addafter("Unit of Measure")
        {
            //BC UPGRADE SIVA >> Drink IT fields 
            // field("Tariff No."; "Tariff No.")
            // {
            //     Description = 'FINXL7.00.001';
            //     Visible = false;
            // }
            // field("Net Weight"; "Net Weight")
            // {
            //     Description = 'FINXL7.00.001';
            //     Visible = false;
            // }
            //BC UPGRADE SIVA
        }
        addafter("Line Amount")
        {
            //BC UPGRADE SIVA >> Drink IT fields
            // field("Approved Line Amount"; "Approved Line Amount")
            // {
            //     Description = 'DITW17.00.02 DIT-770 #144';
            //     Visible = false;
            // }
            // field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Direct Unit Cost"), true))
            // {
            //     AutoFormatExpression = "Currency Code";
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
            //     AutoFormatExpression = "Currency Code";
            //     AutoFormatType = 1;
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassVar(PageText2014410);
            //     CaptionML = ENU = 'Total Line Amount',
            //                 FRA = 'Montant total ligne';
            //     Description = 'DITW17.10.02B DIT-770 #541';
            //     Editable = false;
            // }
            //BC UPGRADE SIVA<<
        }

        //BC UPGRADE SIVA>> InterfaceApp     
        // addafter("Blanket Order Line No.")
        //{

        // field("SRM Contract No."; Rec."SRM Contract No.")
        // {
        //     ApplicationArea = all;
        //     ToolTip = 'SRM Contract No.';

        // }
        // field("SRM Contract Line No."; REc."SRM Contract Line No.")
        // {
        //     ApplicationArea = all;
        //     ToolTip = 'SRM Contract Line No.';
        // }

        //}
        //BC UPGRADE SIVA>> InterfaceApp
        //BC UPGRADE SIVA>> Drink IT fields 
        // addafter("Job Line Type")
        // {
        //     field("Auto. Acc. Group"; REc."Auto. Acc. Group")
        //     {
        //         Description = 'FINXL7.00.001';
        //     }
        // }
        //  addafter("Returns Deferral Start Date")
        // {
        //     field("AAD No. Series"; REc."AAD No. Series")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("LRN No. Series"; Rec."LRN No. Series")
        //     {
        //         Description = 'DITW15.00.00.38 #1217';
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("LRN No."; REc."LRN No.")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("ARC No."; REc."ARC No.")
        //     {
        //         Editable = false;
        //         Lookup = false;
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("SAD No."; REc."SAD No.")
        //     {
        //         Visible = false;
        //     }
        //     field("ARC No. Mandatory"; REc."ARC No. Mandatory")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Packaging Type Code"; REc."Packaging Type Code")
        //     {
        //         Visible = false;
        //     }
        //     field("No. of Packages"; REc."No. of Packages")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Applies-to AAD Trck. Entry No."; REc."Applies-to AAD Trck. Entry No.")
        //     {
        //         Description = 'DITW15.00.00.39 #1369';
        //         Visible = false;
        //     }
        //     field("Free Item"; REc."Free Item")
        //     {

        //         trigger OnValidate();
        //         begin
        //             FreeItemOnAfterValidate;
        //         end;
        //     }
        //     field("Allow VAT Calculation (Free)"; REc."Allow VAT Calculation (Free)")
        //     {
        //         Description = 'DITW16.00.00.40 DIT-715 #172';
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             AllowVATCalculationFreeOnAfter();
        //         end;
        //     }
        //     field("Free Item Posting Type"; Rec."Free Item Posting Type")
        //     {
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             REc.FreeItemPostingTypeOnAfterVali();
        //         end;
        //     }
        //     field("Contract Type"; Rec."Contract Type")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
        //     {
        //         Visible = false;
        //     }
        //     field("Service Contract No."; Rec."Service Contract No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Financial Contract No."; Rec."Financial Contract No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Contract Group Code"; Rec."Contract Group Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Linked Customer No."; Rec."Linked Customer No.")
        //     {
        //         Visible = false;
        //     }
        // }
        //BC UPGRADE SIVA<<

        addafter(ShortcutDimCode8)
        {
            //BC UPGRADE SIVA>> Drink IT field
            // field("App. Prod. Posting Group"; Rec."App. Prod. Posting Group")
            // {
            //     Description = 'DITW17.00.02 DIT-770 #144';
            //     Visible = false;
            // }
            //BC UPGRADE SIVA<<
            field("TIN No."; Rec."TIN No. FND")
            {
                ApplicationArea = all;
                ToolTip = 'TIN No.';
            }
            //BC UPGRADE SIVA>> ASTRO 
            // field("Astro Unique ID"; Rec."Astro Unique ID")
            // {
            //     ToolTip = 'Astro Unique ID';
            //     ApplicationArea = all;
            // }
            //BC UPGRADE SIVA>> ASTRO <<
            field("Expected Receipt Date"; Rec."Expected Receipt Date")
            {
                ToolTip = 'Expected Receipt Date';
                ApplicationArea = all;
            }
            field("SPL Code"; Rec."SPL Code FND")
            {
                ToolTip = 'SPL Code';
                ApplicationArea = all;
            }
            field("SPL Name"; Rec."SPL Name FND")
            {
                ToolTip = 'SPL Name';
                ApplicationArea = all;
            }
            field("Consumption SPL Code"; Rec."Consumption SPL Code FND")
            {
                ToolTip = 'Consumption SPL Code';
                ApplicationArea = all;
                Visible = false;
            }

        }
        addafter("Total VAT Amount")
        {
            //BC UPGRADE SIVA<< CAD 
            field(TotalCADAmount; TotalPurchaseLine."CAD Amount FND")
            {
                ApplicationArea = All;
                AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                // CaptionClass = DocumentTotals.GetTotalCADCaption(TotalPurchaseHeader."Currency Code");
                CaptionClass = HeinekenBCCustomFunctions.GetTotalCADCaption(TotalPurchaseHeader."Currency Code");
                Caption = 'Total CAD Amount';
                Editable = false;
                Visible = EnableCAD;
            }
            //BC UPGRADE SIVA>> CAD
        }
        addafter("Total Amount Incl. VAT")
        {
            //BC UPGRADE SIVA<< CAD
            field(TotalInclCAD; TotalInclCAD)
            {
                ApplicationArea = All;
                AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                // CaptionClass = DocumentTotals.GetTotalInclCADCaption(PurchHeader."Currency Code");
                CaptionClass = HeinekenBCCustomFunctions.GetTotalInclCADCaption(PurchHeader."Currency Code");
                Caption = 'Total Incl. CAD';
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;
                Visible = EnableCAD;
            }
            //BC UPGRADE SIVA>> CAD
        }
    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("E&xplode BOM")
        {
            CaptionML = ENU = 'E&xplode BOM', FRA = '&Eclater nomenclature';
        }
        modify("Insert &Ext. Texts")
        {
            CaptionML = ENU = 'Insert &Ext. Texts', FRA = 'Insérer te&xtes étendus';
        }
        modify(Reserve)
        {
            CaptionML = ENU = '&Reserve', FRA = '&Réserver';
        }
        modify("Order &Tracking")
        {
            CaptionML = ENU = 'Order &Tracking', FRA = 'C&haînage';
        }
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify("Item Availability by")
        {
            CaptionML = ENU = 'Item Availability by', FRA = 'Disponibilité article par';
        }
        modify("Event")
        {
            CaptionML = ENU = 'Event', FRA = 'Événement';
        }
        modify(Period)
        {
            CaptionML = ENU = 'Period', FRA = 'Période';
        }
        modify(Variant)
        {
            CaptionML = ENU = 'Variant', FRA = 'Variante';
        }
        modify(Location)
        {
            CaptionML = ENU = 'Location', FRA = 'Magasin';
        }
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level', FRA = 'Niveau nomenclature';
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
        modify("Item Charge &Assignment")
        {
            CaptionML = ENU = 'Item Charge &Assignment', FRA = '&Affectation frais annexes';
        }
        modify(ItemTrackingLines)
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
        }
        modify(DeferralSchedule)
        {
            CaptionML = ENU = 'Deferral Schedule', FRA = 'Tableau d''échelonnement';
        }
        //addfirst(ActionContainer1900000004)
        //{
        //BC UPGRADE SIVA >> Drink IT Code
        // action("+ Expand")
        // {
        //     CaptionML = ENU = '+ Expand',
        //                 FRA = '+ Développer';
        //     Enabled = (NOT ExpandLines);
        //     Image = ViewDetails;
        //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //     //PromotedCategory = Process;
        //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
        //     //PromotedIsBig = true;
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
        //BC UPGRADE SIVA<< Drink IT Code
        //}
        //BC UPGRADE SIVA >> Drink IT Actions
        // addafter("Insert &Ext. Texts")
        // {
        //     action("Insert Item Char&ges")
        //     {
        //         CaptionML = ENU = 'Insert Item Char&ges',
        //                     FRA = 'Insérer frais annexes';
        //         ShortCutKey = 'Ctrl+Y';

        //         trigger OnAction();
        //         begin
        //             //This functionality was copied from page #6640. Unsupported part was commented. Please check it.
        //             /*CurrPage.PurchLines.PAGE.*/
        //             _InsertExtendedCharges(true);

        //         end;
        //     }
        // }
        // addafter(DeferralSchedule)
        // {
        //     action("SSCC Tracking Lines")
        //     {
        //         CaptionML = ENU = 'SSCC Tracking Lines',
        //                     FRA = 'Lignes Traçabilité SSCC';
        //         Image = ItemTrackingLines;

        //         trigger OnAction();
        //         begin
        //             // <<DITW16.00.00.40 DDR 22/12/2011 #1429
        //             //This functionality was copied from page #6640. Unsupported part was commented. Please check it.
        //             /*CurrPage.PurchLines.PAGE.*/
        //             _OpenSSCCTrackingLines();

        //         end;
        //     }
        // }
        //BC UPGRADE SIVA<< Drink IT Actions
    }
    trigger OnOpenPage()
    begin
        //BC UPGRADE SIVA>>CAD  
        //HEI.04>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.04<<
        //BC UPGRADE SIVA<<CAD

    end;


    var
        PurchaseLine: Record "Purchase Line";
    //  GeneralLedgerSetup: Record "General Ledger Setup";//BC UPGRADE SIVA

    var
        xRecRef: RecordRef;
        //BC UPGRADE SIVA >> Drink IT Code
        // cduAppMgt: Codeunit ApplicationManagement;
        // QualitySetup: Record "Quality Setup";
        // QualityManagement: Codeunit "Quality Management";
        //BC UPGRADE SIVA <<
        PurchHeader: Record "Purchase Header";
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Direct Unit Cost', FRA = 'Total coût unitaire directe';
        DisabledRefreshLines: Boolean;

        TypeEditable: Boolean;

        "No.Editable": Boolean;

        "Cross-Reference No.Editable": Boolean;

        QuantityEditable: Boolean;

        "Direct Unit CostEditable": Boolean;

        "Line AmountEditable": Boolean;

        "Return Qty. to ShipEditable": Boolean;

        "Qty. to InvoiceEditable": Boolean;

        TypeEnable: Boolean;

        "No.Enable": Boolean;

        QuantityEnable: Boolean;

        "Unit Price (LCY)Enable": Boolean;

        "Line AmountEnable": Boolean;

        ExpandLines: Boolean;

        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        UserMgt: Codeunit "User Setup Management";
        EditableDesc: Boolean;
        GeneralLedgerSetup: Record "General Ledger Setup";
        EnableCAD: Boolean;
        TotalInclCAD: Decimal;
        ShortcutDimCode: array[8] of Code[20];
        HeinekenBCCustomFunctions: Codeunit "Heineken BC Custom Functions";

    trigger OnAfterGetCurrRecord()
    begin
        //HEI.04>>
        TotalInclCAD := 0;
        GeneralLedgerSetup.GET();
        IF GeneralLedgerSetup."Enable CAD FND" THEN BEGIN
            IF TotalPurchaseLine."CAD Amount FND" <> 0 THEN BEGIN
                PurchaseLine.RESET;
                PurchaseLine.SETRANGE("Document Type", TotalPurchaseHeader."Document Type");
                PurchaseLine.SETRANGE("Document No.", TotalPurchaseHeader."No.");
                PurchaseLine.SETFILTER("CAD Attached to Line No. FND", '<>%1', 0);
                IF PurchaseLine.FINDFIRST THEN
                    TotalInclCAD := TotalPurchaseLine."Amount Including VAT"
                ELSE
                    TotalInclCAD := TotalPurchaseLine."Amount Including VAT" + TotalPurchaseLine."CAD Amount FND";
            END ELSE
                TotalInclCAD := TotalPurchaseLine."Amount Including VAT";
        END;
        //HEI.04<<
        // BC Upgrade BHARDA11 >>
        PurchHeader.get(TotalPurchaseHeader."Document Type", TotalPurchaseHeader."No.");
        // BC Upgrade BHARDA11 <<
    end;


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger (Variable: PurchaseLine)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if PurchHeader.GET("Document Type","Document No.") then;

    DocumentTotals.PurchaseUpdateTotalsControls(Rec,TotalPurchaseHeader,TotalPurchaseLine,RefreshMessageEnabled,
      TotalAmountStyle,RefreshMessageText,InvDiscAmountEditable,VATAmount);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4

    // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
    SETFILTER("Resp. Center Table Filter",
      UserMgt.GetRespCenterFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",
      UserMgt.GetRespPhysLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",
      UserMgt.GetRespLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 DDR DIT-770 #1191
    // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
    SetFilterSubContractPostType();
    // >>DITW16.00.00.41 AHU DIT-715 #327
    // <<DITW15.00.00.01 DDR 18/12/2007
    // VIGEO VS 29-12-2005: Toeslag regels mogen niet worden gewijzigd. Dit moet op het hoofdartikel worden gedaan.
    UpdateFields();

    //HEI.04>>
    TotalInclCAD := 0;
    GeneralLedgerSetup.GET;
    if GeneralLedgerSetup."Enable CAD" then begin
      if TotalPurchaseLine."CAD Amount" <> 0 then begin
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document Type",TotalPurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.",TotalPurchaseHeader."No.");
        PurchaseLine.SETFILTER("CAD Attached to Line No.",'<>%1',0);
        if PurchaseLine.FINDFIRST then
          TotalInclCAD := TotalPurchaseLine."Amount Including VAT"
        else
          TotalInclCAD := TotalPurchaseLine."Amount Including VAT" + TotalPurchaseLine."CAD Amount";
      end else
        TotalInclCAD := TotalPurchaseLine."Amount Including VAT";
    end;
    //HEI.04<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    IndentLine := IndentRecordDIT(ExpandLines);
    // >>DITW17.10.03 DDR DIT-770 #541
    ShowShortcutDimCode(ShortcutDimCode);


    //PATHAA02 07.11.2017>>
    if Type <> Type::Item then
      EditableDesc:= true
    else
      EditableDesc:= false;
    //PATHAA02 07.11.2017<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if (Quantity <> 0) and ItemExists("No.") then begin
      COMMIT;
      if not ReservePurchLine.DeleteLineConfirm(Rec) then
        exit(false);
      ReservePurchLine.DeleteLine(Rec);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.37 DDR 20/07/2010
    //IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
    //  COMMIT;
    //  IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
    //    EXIT(FALSE);
    //  ReservePurchLine.DeleteLine(Rec);
    //END;
    // Move to function TriggerOnDeleteRecord() to solve RTC Collapse delete records
    // Temporary until next Mirosoft release
    exit(TriggerOnDeleteRecord());
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
    "Line AmountEnable" := true;
    "Unit Price (LCY)Enable" := true;
    QuantityEnable := true;
    "No.Enable" := true;
    TypeEnable := true;
    "Qty. to InvoiceEditable" := true;
    "Return Qty. to ShipEditable" := true;
    "Line AmountEditable" := true;
    "Direct Unit CostEditable" := true;
    QuantityEditable := true;
    "Cross-Reference No.Editable" := true;
    "No.Editable" := true;
    TypeEditable := true;
    */
    //end;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InitType;
    CLEAR(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
    IndentLine := 0;
    if not ISEMPTY then
      InitLineNo(ExpandLines,BelowxRec);
    // >>DITW17.10.03 DDR DIT-770 #541
    InitType;
    CLEAR(ShortcutDimCode);
    // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
    SetFilterSubContractPostType2();
    // >>DITW16.00.00.41 AHU DIT-715 #327
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
    // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    ExpandLines := false;
    ShowButtonsCE := IsShowButtonsCEDIT();
    // >>DITW17.10.03 DDR DIT-770 #541

    //HEI.04>>
    GeneralLedgerSetup.GET;
    EnableCAD := GeneralLedgerSetup."Enable CAD";
    //HEI.04<<
    */
    //end;


    //Unsupported feature: CodeModification on "NoOnAfterValidate(PROCEDURE 19066594)". Please convert manually.

    //procedure NoOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InsertExtendedText(false);
    if (Type = Type::"Charge (Item)") and ("No." <> xRec."No.") and
       (xRec."No." <> '')
    then
      CurrPage.SAVERECORD;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW15.00.00.35 DDR 29/06/2009 - DITW15.00.00.38 DDR 15/03/2011 #1291
    if (Type <> Type::Item) and not "Is Item Charge" then
    // >>DITW15.00.00.35 DDR - DITW15.00.00.38 DDR #1291
      InsertExtendedText(false);
    #2..5

    // <<DITW15.00.00.23 DDR 30/07/2008
    CurrPage.UPDATE;
    // >>DITW15.00.00.23 DDR
    */
    //end;


    //Unsupported feature: CodeModification on "CrossReferenceNoOnAfterValidat(PROCEDURE 19048248)". Please convert manually.

    //procedure CrossReferenceNoOnAfterValidat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InsertExtendedText(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW15.00.00.38 DDR 27/01/2011 #1259
    //InsertExtendedText(FALSE);
    CurrPage.UPDATE;
    // >>DITW15.00.00.38 DDR #1259
    */
    //end;
    //BC UPGRADE SIVA>> Drink IT Ciode
    // local procedure UnitofMeasureCodeOnAfterValida();
    // var
    //     UpdateIsDone: Boolean;
    // begin
    //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     if (Type = Type::Item) and
    //        not UpdateIsDone
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure VariantCodeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     if (Type = Type::Item) and
    //        (xRec."Variant Code" <> "Variant Code")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LocationCodeOnAfterValidate();
    // var
    //     UpdateIsDone: Boolean;
    // begin
    //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     if (Type = Type::Item) and
    //        not UpdateIsDone
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure QuantityOnAfterValidate();
    // var
    //     UpdateIsDone: Boolean;
    // begin
    //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     if (Type = Type::Item) and
    //        (Quantity <> xRec.Quantity) and
    //        not UpdateIsDone
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // procedure _InsertExtendedCharges(FromHeader: Boolean);
    // begin
    //     // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
    //     if InsertChargeLines(FromHeader) then
    //         UpdateForm(true);
    //     // >>DITW15.00.00.23 DDR
    // end;

    // procedure InsertExtendedCharges(FromHeader: Boolean);
    // begin
    //     // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
    //     if InsertChargeLines(FromHeader) then
    //         UpdateForm(true);
    //     // >>DITW15.00.00.23 DDR
    // end;

    // local procedure UpdateFields();
    // var
    //     CollapsedLine: Boolean;
    // begin
    //     // <<DITW15.00.00.01 DDR 15/02/2008 - DITW15.00.00.38 DDR 16/07/2010 #1194
    //     // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
    //     CollapsedLine := not ExpandLines;
    //     // >>DITW17.10.03 DDR DIT-770 #541
    //     // <<DITW17.10.03 DDR 09/07/2014 DIT-770 #541
    //     CALCFIELDS("Has Item Charge");
    //     CollapsedLine := CollapsedLine and "Has Item Charge";
    //     // >>DITW17.10.03 DDR DIT-770 #541
    //     TypeEditable := FormEditableField(FIELDNO(Type));
    //     "No.Editable" := FormEditableField(FIELDNO("No."));
    //     // <<DITW15.00.00.38 DDR 27/01/2011 #1259
    //     "Cross-Reference No.Editable" := FormEditableField(FIELDNO("Cross-Reference No."));
    //     // >>DITW15.00.00.38 DDR #1259

    //     QuantityEditable := FormEditableField(FIELDNO(Quantity));
    //     "Direct Unit CostEditable" := FormEditableField(FIELDNO("Direct Unit Cost")) and not CollapsedLine;
    //     "Line AmountEditable" := FormEditableField(FIELDNO("Line Amount")) and not CollapsedLine;

    //     "Return Qty. to ShipEditable" := FormEditableField(FIELDNO("Return Qty. to Ship"));
    //     "Qty. to InvoiceEditable" := FormEditableField(FIELDNO("Qty. to Invoice"));

    //     // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    //     TypeEnable := FormEditableField(FIELDNO(Type));
    //     "No.Enable" := FormEditableField(FIELDNO("No."));
    //     QuantityEnable := FormEditableField(FIELDNO(Quantity));
    //     "Unit Price (LCY)Enable" := FormEditableField(FIELDNO("Unit Price (LCY)"));
    //     "Line AmountEnable" := FormEditableField(FIELDNO("Line Amount"));
    //     // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    // end;

    // procedure _OpenSSCCTrackingLines();
    // begin
    //     // <<DITW16.00.00.40 DDR 22/12/2011 #1429
    //     Rec.OpenSSCCTrackingLines();
    // end;

    // procedure OpenSSCCTrackingLines();
    // begin
    //     // <<DITW16.00.00.40 DDR 22/12/2011 #1429
    //     Rec.OpenSSCCTrackingLines();
    // end;

    // procedure TriggerOnDeleteRecord(): Boolean;
    // var
    //     ReservePurchLine: Codeunit "Purch. Line-Reserve";
    //     TempRec: Record "Purchase Line" temporary;
    // begin
    //     // DITW16.00.00.37 DDR 20/07/2010 (moved trigger bugfix RTC collapse page)
    //     if (Quantity <> 0) and ItemExists("No.") then begin
    //         COMMIT;
    //         if not ReservePurchLine.DeleteLineConfirm(Rec) then
    //             exit(false);
    //         // <<QXL9.00.001 DAT 23/03/2016
    //         if QualitySetup.READPERMISSION then begin
    //             if not QualityManagement.DeletePurchLineConfirm(Rec) then
    //                 exit(false);
    //         end;
    //         // >>QXL9.00.001 DAT 23/03/2016
    //         ReservePurchLine.DeleteLine(Rec);
    //         // <<QXL9.00.001 DAT 23/03/2016
    //         if QualitySetup.READPERMISSION then
    //             QualityManagement.DeletePurchLine(Rec);
    //         // >>QXL9.00.001 DAT 23/03/2016
    //     end;

    //     // <<DITW15.00.00.36 DDR 23/11/2009
    //     if "Is Item Charge" and "ItemCharge Incl. Price" then begin
    //         DELETE(true);
    //         TempRec := Rec;
    //         TempRec."Direct Unit Cost" := 0;
    //         TempRec."Line Amount" := 0;
    //         TempRec."Line Discount Amount" := 0;
    //         // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
    //         TempRec.CalcBackDirectCostItem();
    //         // >>DITW110.00.11 DDR NRQ#24875
    //         exit(false);
    //     end;
    //     // >>DITW15.00.00.36 DDR
    //     exit(true);
    // end;

    // procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
    // begin
    //     // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    //     DisabledRefreshLines := NewDisabledRefreshLines;
    // end;

    // local procedure TypeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 15/01/2008
    //     if Type <> xRec.Type then
    //         CurrPage.UPDATE;
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure DirectUnitCostOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Direct Unit Cost" <> xRec."Direct Unit Cost")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LineAmountOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Line Amount" <> xRec."Line Amount")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LineDiscount37OnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Line Discount %" <> xRec."Line Discount %")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LineDiscountAmountOnAfterValid();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Line Discount Amount" <> xRec."Line Discount Amount")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure ReturnQtytoShipOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Return Qty. to Ship" <> xRec."Return Qty. to Ship")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure QtytoInvoiceOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Qty. to Invoice" <> xRec."Qty. to Invoice")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure FreeItemOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.35 DDR 25/06/2009
    //     if (Type = Type::Item) and
    //        (xRec."Free Item" <> "Free Item")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.35 DDR
    // end;



    // local procedure FreeItemPostingTypeOnAfterVali();
    // begin
    //     // <<DITW15.00.00.35 DDR 25/06/2009
    //     if Type = Type::Item then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.35 DDR
    // end
    //BC UPGRADE SIVA<< Drink IT code
    local procedure AllowVATCalculationFreeOnAfter();
    begin
        CurrPage.UPDATE(true);
    end;

    trigger OnAfterGetRecord()
    begin
        REc.ShowShortcutDimCode(ShortcutDimCode);
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

