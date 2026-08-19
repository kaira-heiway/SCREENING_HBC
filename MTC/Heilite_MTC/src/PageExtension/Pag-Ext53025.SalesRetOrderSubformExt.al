pageextension 53025 SalesRetOrderSubformExt extends "Sales Return Order Subform"
{
    // version NAVW110.0,FINXL9.00,DITW110.00.11,HEI.04
    //       DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    //   DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Tax Item Charges functionnalities
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
    //   DITW15.00.00.28 DDR 24/11/2008 Added fields "AAD No." (editable)
    //   DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
    //                                    "Empty Goods Item No."
    //   DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //                       21/08/2009 issue 727 Added HorzAlign property in field "Unit Price"
    //                   DLE 06/09/2009 issue 516 Added field "Physical Location Group Code"
    //                   DDR 14/10/2009 issue 893 Removed fields "Gen. Prod. Posting Free Group"
    //   DITW15.00.00.36 DDR 04/11/2009 issue 939 Performance SQL
    //                                  Added function FormTotalingField()
    //                       01/06/2010 issue 959 Not default visible field "AAD No."
    //   DITW15.00.00.37 DDR 02/06/2010 issue 1061 Added default Not visible fields "Physical Location Group Code"
    //   DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                    Added parmater et return value for function ReadExpansionStatus()
    //                                    Remove functions FormTotalingField()
    //                                    Rewrite functions UpdateFields(),FormTotalingField()
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                   DDR 30/07/2010           Remove OnFormat() field "No."
    //                   CEL 13/08/2010           Modification RTC buttons
    //   DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                    Added fields
    //                                      "EMCS LRN No.","EMCS ARC No.","EMCS SAD No."
    //                                    Hidden fields
    //                                      "AAD No."
    //                       17/09/2010   Remove field "EMCS LRN No."
    //                       30/09/2010   Added lookup field "ARC No."
    //                                    Added function ShowGetARCNoEDI()
    //                       19/11/2010 issue 1139 SSCC Functionnalities
    //                                    Added functions OpenSSCCTrackingLines()
    //                       17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    //                                            Added fields "Tax Item No."
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
    //                                  Added following field: "Auto. Acc. Group"

    //   DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    //   DITW17.00.02 AT  24/09/2013 DIT-770 #132
    //                               Added field Free Reason Code
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW17.10.03 DDR 10/06/2014 DIT-770 #541 Modified 'QuickEntry' property fields "Has Item Charge","Collapse"
    //                                            Removed 'IndentationControls' field1 Group Repeater
    //   DITW17.10.03 DDR 11/06/2014 DIT-770 #570 Added menu 'Item Charge &Assignment (DIT)'
    //                                            Added shortcut for menu 'Item Charge Assignment (DIT)'
    //   DITW17.10.03 DDR 10/07/2014 DIT-770 #541 Added editable other types than Item
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added field "Responsibity Center"
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.05 DDR 04/09/2014 DIT-770 #695 Added fields "Allow Price Dit Discount"
    //   DITW17.10.05 DDR 08/09/2014 DIT-770 #695 Modified non-editable "Allow Price Dit Discount"
    //   DITW17.10.05 WSA 05/11/2014 DIT-770 #185 Added Loyalty Fields
    //   DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Unit Price"
    //   DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //   DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 Added field "Trailer Code"
    //   DITW18.00.06 MSF 06/07/2015 DIT-770 #1035 Delete Field 2014100 "Trailer Code" Not Needed
    //   DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                             Rename Field Service contract Type => Contract Type
    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.01 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    //     # New field "RPM Damage / Loss" added
    //     # New field "Transporter RPM Damage / Loss" added

    //   HEI.02 PATHAA02  15.11.17 # Description Non-Editable only for Type=Item.

    //   HEI.03 FDD-SLSGAP015 IBM NASTAA02 24.04.2018 # Default Dimensions in the Promotion Charges
    //     # Used function "UpdateFreeReasonCodeDimensions" on OnValidate Trigger of "Quantity" to update Free Reason Code Dimensions
    //   HEI.04 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //     # New Field added: "TIN No."
    //   HEI.05 RPM Breakages IBM ISYED01 03.11.2019 # Rwanda
    //     # added code for creating reco for RPM breakages.
    //   DITW113.00.15 DDR 04/10/2019 NRQ#10495 Rename Loyalty 'Cost' -> 'Amount' (all fields)
    //   DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackUnitPriceItem()
    //   HEI.06 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //     # New Field added: "CAD Amount"
    //**********************************************//
    //BC UPGRADE SIVA 20/01/2026
    //1.HEI.01 Added fields in page_layout with application area all
    //2.HEI.02 Commented Type Non editable property depdency on Drink IT code.
    //3.HEI.03 Custom Code is added Qty_onaftervalidate due to Page ext not avilable Onvalidate trigger.
    //4.HEI.04 Added TIN No. in page layout with application area all.
    //5.HEI.05 Moved InsertRPMCustomerDifferences procedure from Customer Differences (RPM) action  General app CU Heineken Global to MTC app CUHeineken BC Upgrade MTC .. 
    //6.HEI.06 Commented CAD Amount field.  
    layout
    {
        //BC UPGRADE SIVA>> Drink IT code
        // modify(Type)
        // {
        //     Enabled = TypeEnable;

        //     //Unsupported feature: Change Editable on "Type(Control 2)". Please convert manually.

        // }
        //BC UPGRADE SIVA<< Drink IT code
        //BC UPGRADE SIVA >> Drink IT field 
        // modify("Cross-Reference No.")
        // {

        //     //Unsupported feature: Change Editable on ""Cross-Reference No."(Control 34)". Please convert manually.

        //     QuickEntry = False;
        // }
        //BC UPGRADE SIVA << Drink IT field
        modify("IC Partner Ref. Type")
        {
            QuickEntry = False;
        }
        modify("IC Partner Reference")
        {
            QuickEntry = False;
        }
        modify("Variant Code")
        {
            QuickEntry = False;
        }
        modify(Nonstock)
        {
            QuickEntry = False;
        }
        modify("VAT Prod. Posting Group")
        {
            QuickEntry = False;
        }

        //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.

        modify("Location Code")
        {
            QuickEntry = False;
        }
        modify("Bin Code")
        {
            QuickEntry = False;
        }
        //BC UPGRADE SIVA >> Base app Page layout field name is Control28 for Reserve field.
        modify(Control28)
        {
            QuickEntry = False;
        }
        //BC UPGRADE SIVA >> Base app Page layout field name is Control28 for Reserve field.
        //BC UPGRADE SIVA<< Drink IT code
        // modify(Quantity)
        // {
        //     Enabled = QuantityEnable;

        //     //Unsupported feature: Change Editable on "Quantity(Control 8)". Please convert manually.

        // }
        //BC UPGRADE SIVA>> Drink IT code
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                //UpdateFreeReasonCodeDimensions; //HEI.03 //HEI.06


            end;
        }
        modify("Unit Cost (LCY)")
        {
            QuickEntry = False;
        }
        //BC UPGRADE SIVA<< Drink IT code
        // modify("Unit Price")
        // {
        //     Enabled = "Unit PriceEnable";

        //     //Unsupported feature: Change Editable on ""Unit Price"(Control 12)". Please convert manually.

        //     QuickEntry = False;
        // }
        // modify("Line Amount")
        // {
        //     Enabled = "Line AmountEnable";

        //     //Unsupported feature: Change Editable on ""Line Amount"(Control 92)". Please convert manually.

        //     QuickEntry = False;
        // }
        //BC UPGRADE SIVA>> Drink IT code
        modify("Line Discount %")
        {
            QuickEntry = False;
        }
        modify("Line Discount Amount")
        {
            QuickEntry = False;
        }
        modify("Allow Invoice Disc.")
        {
            QuickEntry = False;
        }
        modify("Inv. Discount Amount")
        {
            QuickEntry = False;
        }
        modify("Return Qty. to Receive")
        {

            //Unsupported feature: Change Editable on ""Return Qty. to Receive"(Control 82)". Please convert manually.

            QuickEntry = False;
        }
        modify("Return Qty. Received")
        {
            QuickEntry = False;
        }
        modify("Qty. to Invoice")
        {

            //Unsupported feature: Change Editable on ""Qty. to Invoice"(Control 24)". Please convert manually.

            QuickEntry = False;
        }
        modify("Quantity Invoiced")
        {
            QuickEntry = False;
        }
        modify("Allow Item Charge Assignment")
        {
            QuickEntry = False;
        }
        modify("Requested Delivery Date")
        {
            QuickEntry = False;
        }
        modify("Promised Delivery Date")
        {
            QuickEntry = False;
        }
        modify("Planned Shipment Date")
        {
            QuickEntry = False;
        }
        modify("Shipping Agent Code")
        {
            QuickEntry = False;
        }
        modify("Shipping Agent Service Code")
        {
            QuickEntry = False;
        }
        modify("Shipping Time")
        {
            QuickEntry = False;
        }
        modify("Blanket Order No.")
        {
            QuickEntry = False;
        }
        modify("Blanket Order Line No.")
        {
            QuickEntry = False;
        }
        modify("Appl.-from Item Entry")
        {
            QuickEntry = False;
        }
        modify("Appl.-to Item Entry")
        {
            QuickEntry = False;
        }
        modify("Shortcut Dimension 1 Code")
        {
            QuickEntry = False;
        }
        modify("Shortcut Dimension 2 Code")
        {
            QuickEntry = False;
        }
        modify(ShortcutDimCode3)
        {
            QuickEntry = False;
        }
        modify(ShortcutDimCode4)
        {
            QuickEntry = False;
        }
        modify(ShortcutDimCode5)
        {
            QuickEntry = False;
        }
        modify(ShortcutDimCode6)
        {
            QuickEntry = False;
        }
        modify(ShortcutDimCode7)
        {
            QuickEntry = False;
        }
        modify(ShortcutDimCode8)
        {
            QuickEntry = False;
        }
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
        TypeChosen := HasTypeToFillMandatotyFields;

        if xRec."No." <> '' then
          RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TypeOnAfterValidate;
        #1..5
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


        //Unsupported feature: CodeModification on ""Cross-Reference No."(Control 34).OnLookup". Please convert manually.

        //trigger "(Control 34)();
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


        //Unsupported feature: CodeInsertion on ""Variant Code"(Control 18)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        VariantCodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Control 72)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        LocationCodeOnAfterValidate;
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        if xRec."Location Code" <> "Location Code" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 DDR DIT-770 #1190
        */
        //end;


        //Unsupported feature: CodeModification on "Quantity(Control 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        QuantityOnAfterValidate;
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        QuantityOnAfterValidate;
        RedistributeTotalsOnAfterValidate;

        //UpdateFreeReasonCodeDimensions; //HEI.03 //HEI.06
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit Price"(Control 12).OnValidate". Please convert manually.

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
        UnitPriceOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Amount"(Control 92).OnValidate". Please convert manually.

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


        //Unsupported feature: CodeModification on ""Line Discount Amount"(Control 56).OnValidate". Please convert manually.

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


        //Unsupported feature: CodeInsertion on ""Return Qty. to Receive"(Control 82)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        ReturnQtytoReceiveOnAfterValid;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Qty. to Invoice"(Control 24)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        QtytoInvoiceOnAfterValidate;
        */
        //end;

        addfirst(Control1)
        {
            // BC UPGRADE SIVA >> Drink IT field
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
            // BC UPGRADE SIVA << Drink IT field
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                Editable = false;
                QuickEntry = false;
                Visible = false;
            }
        }
        // BC Upgrade BHARDA11 >>
        addafter("VAT Prod. Posting Group")
        {
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                Visible = EnableCAD;
                ApplicationArea = All;
            }
        }
        // BC Upgrade BHARDA11 <<

        //BC UPGRADE SIVA >> Dirnk IT Code
        // addafter("VAT Prod. Posting Group")
        // {
        //     field("CAD Amount"; Rec."CAD Amount")
        //     {
        //         Visible = EnableCAD;
        //     }
        //     field("GetTrackingItemNo()"; rec.GetTrackingItemNo())
        //     {
        //         CaptionML = ENU = 'Tracking Item No. (Item Charge)',
        //                     FRA = 'N° article traçable (Frais annexes)';
        //         DrillDownPageID = "Item List";
        //         Editable = false;
        //         LookupPageID = "Item List";
        //         QuickEntry = false;
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
        //BC UPGRADE SIVA << Dirnk IT Code

        // BC UPGRADE SIVA >>  In base layout already filed is existed 
        // addafter(Description)
        // {
        //     field("Description 2"; Rec."Description 2")
        //     {
        //         Description = 'DIT-715 #393';
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        // }
        // BC UPGRADE SIVA >>  In base layout already filed is existed 

        //BC UPGRADE SIVA >> Drink IT code
        // addafter("Return Reason Code")
        // {
        //     field("Responsibility Center"; Rec."Responsibility Center")
        //     {
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        //             if REC."Responsibility Center" <> xRec."Responsibility Center" then
        //                 CurrPage.UPDATE(true);
        //             // >>DITW18.00.06 DDR DIT-770 #1190
        //         end;
        //     }
        //BC UPGRADE SIVA << Drink IT code
        // BC UPGRADE SIVA >> 
        // field("Physical Location Group Code"; Rec."Physical Location Group Code")
        // {
        //     QuickEntry = false;
        //     Visible = false;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        //         if Rec."Physical Location Group Code" <> xRec."Physical Location Group Code" then
        //             CurrPage.UPDATE(true);
        //         // >>DITW18.00.06 DDR DIT-770 #1190
        //     end;
        // }
        // BC UPGRADE SIVA <<

        // BC UPGRADE SIVA >> Drink IT fields
        //addafter("Unit of Measure")
        //{
        // field("Tariff No."; Rec."Tariff No.")
        // {
        //     Description = 'FINXL7.00.001';
        //     Visible = false;
        // }
        // BC UPGRADE SIVA << 

        // BC UPGRADE SIVA >>  In base layout already filed is existed 
        // field("Net Weight"; Rec."Net Weight")
        // {
        //     Description = 'FINXL7.00.001';
        //     Visible = false;
        // }

        // BC UPGRADE SIVA >>  In base layout already filed is existed 
        //}
        //BC UPGRADE SIVA>> Drink IT code 
        // addafter("Line Amount")
        // {
        //     field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Unit Price"), true))
        //     {
        //         AutoFormatExpression = "Currency Code";
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
        //         AutoFormatExpression = "Currency Code";
        //         AutoFormatType = 1;
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassVar(PageText2014410);
        //         CaptionML = ENU = 'Total Line Amount',
        //                     FRA = 'Montant total ligne';
        //         Description = 'DITW17.10.02B DIT-770 #541';
        //         Editable = false;
        //         QuickEntry = false;
        //     }
        // }
        //BC UPGRADE SIVA<< Drink IT code

        // BC UPGRADE SIVA >> Drink IT code 
        // addafter("Appl.-to Item Entry")
        // {
        //     field("Auto. Acc. Group"; Rec."Auto. Acc. Group")
        //     {
        //         Description = 'FINXL7.00.001';
        //     }
        //     field("AAD No."; Rec."AAD No.")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("ARC No."; Rec."ARC No.")
        //     {
        //         Description = 'DITW15.00.00.38 #1217';
        //         QuickEntry = false;
        //         Visible = false;

        //         trigger OnLookup(Text: Text): Boolean;
        //         begin
        //             // <<DITW15.00.00.38 DDR 30/09/2010 #1217
        //             exit(
        //               EDILookupExtTrackingARC(Text));
        //             // >>DITW15.00.00.38 DDR
        //         end;
        //     }
        //     field("SAD No."; Rec."SAD No.")
        //     {
        //         Description = 'DITW15.00.00.38 #1217';
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Packaging Type Code"; Rec."Packaging Type Code")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Applies-to AAD Trck. Entry No."; Rec."Applies-to AAD Trck. Entry No.")
        //     {
        //         Description = 'DITW15.00.00.39 #1369';
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Free Reason Code"; Rec."Free Reason Code")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Free Item"; Rec."Free Item")
        //     {
        //         QuickEntry = false;

        //         trigger OnValidate();
        //         begin
        //             FreeItemOnAfterValidate;
        //         end;
        //     }
        //     field("Backorder Type"; Rec."Backorder Type")
        //     {
        //         Description = 'DITW110.00.11  NRQ#33755';
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Allow VAT Calculation (Free)"; Rec."Allow VAT Calculation (Free)")
        //     {
        //         Description = 'DITW16.00.00.40 DIT-715 #172';
        //         QuickEntry = false;
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             AllowVATCalculationFreeOnAfter;
        //         end;
        //     }
        //     field("Free Item Posting Type"; Rec."Free Item Posting Type")
        //     {
        //         QuickEntry = false;
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             FreeItemPostingTypeOnAfterVali;
        //         end;
        //     }
        //     field("Allow Price Dit Discount"; Rec."Allow Price Dit Discount")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Allow Loyalty"; Rec."Allow Loyalty")
        //     {
        //     }
        //     field("Loyalty Point Type"; Rec."Loyalty Point Type")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Visible = false;
        //     }
        //     field("Loyalty Unit Point"; Rec."Loyalty Unit Point")
        //     {
        //         Description = 'DIT715 #243';
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Loyalty Points Qty. (Base)"; Rec."Loyalty Points Qty. (Base)")
        //     {
        //         Description = 'DIT715 #243';
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Loyalty Amount Type"; Rec."Loyalty Amount Type")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Visible = false;
        //     }
        //     field("Loyalty Unit Amount"; Rec."Loyalty Unit Amount")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Visible = false;
        //     }
        //     field("Loyalty Unit Amount (LCY)"; Rec."Loyalty Unit Amount (LCY)")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Loyalty Amount"; Rec."Loyalty Amount")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Visible = false;
        //     }
        //     field("Loyalty Amount (LCY)"; Rec."Loyalty Amount (LCY)")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Loyalty Convert to Free Item"; Rec."Loyalty Convert to Free Item")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Visible = false;
        //     }
        //     field("Contract Type"; Rec."Contract Type")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Service Contract No."; Rec."Service Contract No.")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Financial Contract No."; Rec."Financial Contract No.")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Contract Group Code"; Rec."Contract Group Code")
        //     {
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        // }
        //BC UPGRADE KUMARR78 >> FDD-MTC-007
        addafter(Description)
        {
            field("Depreciation Book Code"; Rec."Depreciation Book Code")
            {
                ApplicationArea = all;
                Editable = true;
            }
        }
        //BC UPGRADE KUMARR78 >> FDD-MTC-007


        addafter(ShortcutDimCode8)
        {
            field("Item Type"; Rec."Item Type FND")
            {
                ToolTip = 'Item Type';
                ApplicationArea = all;
            }
            field("RPM Solution"; Rec."RPM Solution FND")
            {
                ToolTip = 'Item Type';
                ApplicationArea = all;
            }
            field("RPM Type"; Rec."RPM Type FND")
            {
                ToolTip = 'Item Type';
                ApplicationArea = all;
            }
            field("RPM Damage / Loss"; Rec."RPM Damage / Loss FND")
            {
                ToolTip = 'Item Type';
                ApplicationArea = all;
            }
            field("Transporter RPM Damage / Loss"; Rec."TransporterRPM Damage/Loss FND")
            {
                ToolTip = 'Item Type';
                ApplicationArea = all;
            }
            //BC UPGRADE SIVA>> Drink IT field
            // field("Empty Goods Item No."; Rec."Empty Goods Item No.")
            // {
            //     ApplicationArea =all;
            //     Editable = false;
            // }
            //BC UPGRADE SIVA<<
            field("TIN No."; Rec."TIN No. FND")
            {
                ToolTip = 'TIN No.';
                ApplicationArea = all;
            }
        }

        // BC UPGRADE SIVA << Drink IT code

        //BC UPGRADE SIVA << CAD
        addafter("Total VAT Amount")
        {
            field(TotalCADAmount; TotalSalesLine."CAD Amount FND")
            {
                ApplicationArea = All;
                AutoFormatExpression = SalesHeader."Currency Code";
                CaptionClass = HeinekenBCCustomFunctions.GetTotalCADCaption(SalesHeader."Currency Code");
                Caption = 'Total CAD Amount';
                Editable = false;
                Visible = EnableCAD;
            }
        }
        //BC UPGRADE SIVA >> CAD
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
        // BC UPGRADE SIVA >>
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
        // BC UPGRADE SIVA <<
        //BC UPGRADE SIVA << Drink IT code
        // addafter("Insert &Ext. Texts")
        // {
        //     action("Insert Item Char&ges")
        //     {
        //         CaptionML = ENU = 'Insert Item Char&ges',
        //                     FRA = 'Insérer frais annexes';
        //         ShortCutKey = 'Ctrl+Y';

        //         trigger OnAction();
        //         begin
        //             //This functionality was copied from page #6630. Unsupported part was commented. Please check it.
        //             /*CurrPage.SalesLines.PAGE.*/
        //             _InsertExtendedCharges(true);

        //         end;
        //     }
        // }
        //BC UPGRADE SIVA >> Drink IT code
        addafter("Order &Tracking")
        {
            // BC UPGRADE SIVA >>
            // action("Get EMCS ARC No. to Apply")
            // {
            //     CaptionML = ENU = 'Get EMCS ARC No. to Apply',
            //                 FRA = 'Extraire N°ARC EMCS à affecter';

            //     trigger OnAction();
            //     begin
            //         // <<DITW15.00.00.38 DDR 30/09/2010 #1217
            //         //This functionality was copied from page #6630. Unsupported part was commented. Please check it.
            //         /*CurrPage.SalesLines.PAGE.*/
            //         _ShowGetARCNoEDI();

            //     end;
            // }
            // BC UPGRADE SIVA <<

            action("Customer Differences (RPM) CBN")
            {
                ApplicationArea = all;
                ToolTip = 'Customer Differences (RPM)';
                Caption = 'Customer Differences (RPM)';
                Visible = false;
                Image = Customer;
                trigger OnAction();
                var
                    HeinekenGlobal: Codeunit "Heineken Global";
                    HeinekenBCUpgradeMTC: Codeunit "Heineken BC Upgrade MTC";
                begin

                    //HEI.05>>
                    //HeinekenGlobal.InsertRPMCustomerDifferences(Rec);//BC UPGRADE SIVA
                    HeinekenBCUpgradeMTC.InsertRPMCustomerDifferences(Rec);//BC UPGRADE SIVA
                                                                           //HEI.05>>


                end;
            }
        }
        //BC UPGRADE SIVA >> Drink IT code
        // addafter(DeferralSchedule)
        // {

        //     action("SSCC Tracking Lines")
        //     {
        //         CaptionML = ENU = 'SSCC Tracking Lines',
        //                     FRA = 'Lignes Traçabilité SSCC';
        //         Image = ItemTrackingLines;

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.38 DDR 19/11/2010 #1139
        //             //This functionality was copied from page #6630. Unsupported part was commented. Please check it.
        //             /*CurrPage.SalesLines.PAGE.*/
        //             _OpenSSCCTrackingLines();

        //         end;
        //     }


        //     action("Item Charge &Assignment (DIT)")
        //     {
        //         CaptionML = ENU = 'Item Charge &Assignment (DIT)',
        //                     FRA = '&Affectation frais annexes (DIT)';
        //         ShortCutKey = 'Shift+Ctrl+M';

        //         trigger OnAction();
        //         begin
        //             ItemChargeAssgntDIT;
        //         end;
        //     }
        // }
        //BC UPGRADE SIVA << Drink IT code
    }

    var
        HeinekenBCCustomFunctions: Codeunit "Heineken BC Custom Functions";
        xRecRef: RecordRef;
        //BC UPGRADE SIVA >>
        //cduAppMgt: Codeunit ApplicationManagement;
        //BC UPGRADE SIVA <<
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Unit Price', FRA = 'Total prix unitaire';
        Text2014260: TextConst ENU = 'There are no valid lines to use this function.', FRA = 'Il n''a pas de lignes valide pour utiliser cette fonction';
        DisabledRefreshLines: Boolean;

        // TypeEditable: Boolean;

        "No.Editable": Boolean;

        "Cross-Reference No.Editable": Boolean;

        QuantityEditable: Boolean;

        "Unit PriceEditable": Boolean;

        "Line AmountEditable": Boolean;

        "Return Qty. to ReceiveEditable": Boolean;

        "Qty. to InvoiceEditable": Boolean;

        TypeEnable: Boolean;

        "No.Enable": Boolean;

        QuantityEnable: Boolean;

        "Unit PriceEnable": Boolean;

        "Line AmountEnable": Boolean;

        ExpandLines: Boolean;

        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        UserMgt: Codeunit "User Setup Management";
        EditableDesc: Boolean;
        CustomerDifferencesRPM: Record "Customer Differences RPM FND";
        CustomerDifferencesRPMPage: Page "Customer Differences (RPM) CBN";
        EnableCAD: Boolean;
        SalesHeader: Record "Sales Header";

    trigger OnOpenPage()
    begin
        //HEI.06>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.06<<
    end;

    trigger OnAfterGetCurrRecord()
    begin
        IF SalesHeader.GET(Rec."Document Type", Rec."Document No.") THEN;
    end;

    trigger OnAfterGetRecord()
    begin
        IF SalesHeader.GET(Rec."Document Type", Rec."Document No.") THEN;
    end;
    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if SalesHeader.GET("Document Type","Document No.") then;

    DocumentTotals.SalesUpdateTotalsControls(Rec,TotalSalesHeader,TotalSalesLine,RefreshMessageEnabled,
      TotalAmountStyle,RefreshMessageText,InvDiscAmountEditable,CurrPage.EDITABLE,VATAmount);

    TypeChosen := HasTypeToFillMandatotyFields;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6

    // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
    SETFILTER("Resp. Center Table Filter",
      UserMgt.GetRespCenterFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",
      UserMgt.GetRespPhysLocationFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",
      UserMgt.GetRespLocationFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 DDR DIT-770 #1190
    // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
    SetFilterSubContractPostType();
    // >>DITW16.00.00.41 AHU DIT-715 #327
    // <<DITW15.00.00.01 DDR 18/12/2007
    // VIGEO VS 29-12-2005: Toeslag regels mogen niet worden gewijzigd. Dit moet op het hoofdartikel worden gedaan.
    UpdateFields();
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
      if not ReserveSalesLine.DeleteLineConfirm(Rec) then
        exit(false);
      ReserveSalesLine.DeleteLine(Rec);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.37 DDR 20/07/2010
    //IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
    //  COMMIT;
    //  IF NOT ReserveSalesLine.DeleteLineConfirm(Rec) THEN
    //    EXIT(FALSE);
    //  ReserveSalesLine.DeleteLine(Rec);
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
    "Unit PriceEnable" := true;
    QuantityEnable := true;
    "No.Enable" := true;
    TypeEnable := true;
    "Qty. to InvoiceEditable" := true;
    "Return Qty. to ReceiveEditable" := true;
    "Line AmountEditable" := true;
    "Unit PriceEditable" := true;
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
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    ExpandLines := false;
    ShowButtonsCE := IsShowButtonsCEDIT();
    // >>DITW17.10.03 DDR DIT-770 #541

    //HEI.06>>
    GeneralLedgerSetup.GET;
    EnableCAD := GeneralLedgerSetup."Enable CAD";
    //HEI.06<<
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
    #5..11
      AutoReserve;
      CurrPage.UPDATE(false);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW15.00.00.36 DDR 25/11/2009 - DITW15.00.00.38 DDR 15/03/2011 #1291
    if (Type <> Type::Item) and not "Is Item Charge" then
    // >>DITW15.00.00.36 DDR - DITW15.00.00.38 DDR #1291
      InsertExtendedText(false);
    #2..14

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


    //Unsupported feature: CodeModification on "QuantityOnAfterValidate(PROCEDURE 19032465)". Please convert manually.

    //procedure QuantityOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Reserve = Reserve::Always then begin
      CurrPage.SAVERECORD;
      AutoReserve;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    // <<DITW15.00.00.01 DDR DDR 15/01/2008
    if (Type = Type::Item) and
       (Quantity <> xRec.Quantity)
    then
      CurrPage.UPDATE(true);
    // >>DITW15.00.00.01 DDR
    */
    //end;


    //Unsupported feature: CodeModification on "UnitofMeasureCodeOnAfterValida(PROCEDURE 19057939)". Please convert manually.

    //procedure UnitofMeasureCodeOnAfterValida();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Reserve = Reserve::Always then begin
      CurrPage.SAVERECORD;
      AutoReserve;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    // <<DITW15.00.00.01 DDR DDR 15/01/2008
    if Type = Type::Item then
      CurrPage.UPDATE(true);
    // >>DITW15.00.00.01 DDR
    */
    //end;


    // BC UPGRADE SIVA >>

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
    //TypeEditable := FormEditableField(FIELDNO(Type));
    //     "No.Editable" := FormEditableField(FIELDNO("No."));
    //     // <<DITW15.00.00.38 DDR 27/01/2011 #1259
    //     "Cross-Reference No.Editable" := FormEditableField(FIELDNO("Cross-Reference No."));
    //     // >>DITW15.00.00.38 DDR #1259

    //     QuantityEditable := FormEditableField(FIELDNO(Quantity));
    //     "Unit PriceEditable" := FormEditableField(FIELDNO("Unit Price")) and not CollapsedLine;
    //     "Line AmountEditable" := FormEditableField(FIELDNO("Line Amount")) and not CollapsedLine;

    //     "Return Qty. to ReceiveEditable" := FormEditableField(FIELDNO("Return Qty. to Receive"));
    //     "Qty. to InvoiceEditable" := FormEditableField(FIELDNO("Qty. to Invoice"));

    //     // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    //     TypeEnable := FormEditableField(FIELDNO(Type));
    //     "No.Enable" := FormEditableField(FIELDNO("No."));
    //     QuantityEnable := FormEditableField(FIELDNO(Quantity));
    //     "Unit PriceEnable" := FormEditableField(FIELDNO("Unit Price"));
    //     "Line AmountEnable" := FormEditableField(FIELDNO("Line Amount"));
    //     // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    // end;

    // procedure _ShowGetARCNoEDI();
    // var
    //     SelectedSalesLines: Record "Sales Line";
    //     NewARCNo: Code[30];
    //     NewText: Text[1024];
    // begin
    //     // <<DITW15.00.00.38 DDR 30/09/2010 #1217
    //     CLEAR(SelectedSalesLines);
    //     CurrPage.SETSELECTIONFILTER(SelectedSalesLines);
    //     SelectedSalesLines.SETFILTER("No.", '<>%1', '');
    //     SelectedSalesLines.SETRANGE(REC."ARC No. Mandatory", true);
    //     if SelectedSalesLines.FINDSET then begin
    //         repeat
    //             SelectedSalesLines.TESTFIELD("ARC No.", '');
    //         until SelectedSalesLines.NEXT = 0;
    //     end else
    //         ERROR(Text2014260);


    //     // <<DITW15.00.00.38 DDR 17/12/2010 #703
    //     if SelectedSalesLines.EDILookupExtTrackingARC(NewText) then begin
    //         NewARCNo := NewText;
    //         if SelectedSalesLines.FINDSET(true, false) then
    //             repeat
    //                 SelectedSalesLines.VALIDATE("ARC No.", NewARCNo);
    //                 SelectedSalesLines.MODIFY(true);
    //             until SelectedSalesLines.NEXT = 0;
    //         Rec := SelectedSalesLines;
    //         CurrPage.UPDATE(false);
    //     end;
    // end;

    // procedure ShowGetARCNoEDI();
    // var
    //     SelectedSalesLines: Record "Sales Line";
    //     NewARCNo: Code[30];
    //     NewText: Text[1024];
    // begin
    //     // <<DITW15.00.00.38 DDR 30/09/2010 #1217
    //     CLEAR(SelectedSalesLines);
    //     CurrPage.SETSELECTIONFILTER(SelectedSalesLines);
    //     SelectedSalesLines.SETFILTER("No.", '<>%1', '');
    //     SelectedSalesLines.SETRANGE("ARC No. Mandatory", true);
    //     if SelectedSalesLines.FINDSET then begin
    //         repeat
    //             SelectedSalesLines.TESTFIELD("ARC No.", '');
    //         until SelectedSalesLines.NEXT = 0;
    //     end else
    //         ERROR(Text2014260);


    //     // <<DITW15.00.00.38 DDR 17/12/2010 #703
    //     if SelectedSalesLines.EDILookupExtTrackingARC(NewText) then begin
    //         NewARCNo := NewText;
    //         if SelectedSalesLines.FINDSET(true, false) then
    //             repeat
    //                 SelectedSalesLines.VALIDATE("ARC No.", NewARCNo);
    //                 SelectedSalesLines.MODIFY(true);
    //             until SelectedSalesLines.NEXT = 0;
    //         Rec := SelectedSalesLines;
    //         CurrPage.UPDATE(false);
    //     end;
    // end;

    // procedure _OpenSSCCTrackingLines();
    // begin
    //     // <<DITW15.00.00.38 DDR 19/11/2010 #1139
    //     Rec.OpenSSCCTrackingLines();
    // end;

    // procedure OpenSSCCTrackingLines();
    // begin
    //     // <<DITW15.00.00.38 DDR 19/11/2010 #1139
    //     Rec.OpenSSCCTrackingLines();
    // end;

    // procedure NewLine();
    // var
    //     SalesLine: Record "Sales Line";
    // begin
    //     // <<DITW16.00.00.37 DIT-715 #1
    //     if FINDLAST then;
    //     SalesLine := Rec;
    //     INIT;
    //     "Document Type" := SalesLine."Document Type";
    //     "Document No." := SalesLine."Document No.";
    //     "Line No." := SalesLine."Line No." + 10000;
    //     INSERT(true);
    //     CurrPage.UPDATE(false);
    //     // >>DITW16.00.00.37 DIT-715 #1
    // end;

    // procedure DeleteLine();
    // begin
    //     // <<DITW16.00.00.37 DIT-715 #1
    //     DELETE(true);
    //     CurrPage.UPDATE(false);
    //     // >>DITW16.00.00.37 DIT-715 #1
    // end;

    // procedure TriggerOnDeleteRecord(): Boolean;
    // var
    //     ReserveSalesLine: Codeunit "Sales Line-Reserve";
    //     TempRec: Record "Sales Line" temporary;
    // begin
    //     // DITW16.00.00.37 DDR 20/07/2010 (moved trigger bugfix RTC collapse page)
    //     if (Quantity <> 0) and ItemExists("No.") then begin
    //         COMMIT;
    //         if not ReserveSalesLine.DeleteLineConfirm(Rec) then
    //             exit(false);
    //         ReserveSalesLine.DeleteLine(Rec);
    //     end;

    // <<DITW15.00.00.36 DDR 23/11/2009
    // if "Is Item Charge" and "ItemCharge Incl. Price" then begin
    //     DELETE(true);
    //     TempRec := Rec;
    //     TempRec."Unit Price" := 0;
    //     TempRec."Line Amount" := 0;
    //     TempRec."Line Discount Amount" := 0;
    //     // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
    //     TempRec.CalcBackUnitPriceItem();
    //     // >>DITW110.00.11 DDR NRQ#24875
    //     exit(false);
    // end;
    // // >>DITW15.00.00.36 DDR
    // exit(true);
    // end;

    // procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
    // begin
    //     // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    //     DisabledRefreshLines := NewDisabledRefreshLines;
    // end;

    // local procedure TypeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 15/01/2008
    //     // CurrForm.ItemPanel.VISIBLE := Type = Type::Item;
    //     if Type <> xRec.Type then
    //         CurrPage.UPDATE;
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

    // local procedure UnitPriceOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Unit Price" <> xRec."Unit Price")
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

    // local procedure ReturnQtytoReceiveOnAfterValid();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Return Qty. to Receive" <> xRec."Return Qty. to Receive")
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

    // BC UPGRADE SIVA <<

    local procedure AllowVATCalculationFreeOnAfter();
    begin
        CurrPage.UPDATE(true);
    end;

    //BC UPGRADE SIVA >>

    // local procedure FreeItemPostingTypeOnAfterVali();
    // begin
    //     // <<DITW15.00.00.35 DDR 25/06/2009
    //     if Type = Type::Item then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.35 DDR
    // end;



    // procedure ItemChargeAssgntDIT();
    // var
    //     SelectedRec: Record "Sales Line";
    // begin
    //     // <<DITW17.10.03 DDR 22/04/2014 DIT-770 #570
    //     CurrPage.SAVERECORD;
    //     COMMIT;
    //     CurrPage.SETSELECTIONFILTER(SelectedRec);
    //     GetNewItemChargeAssgnDIT(SelectedRec);
    //     CurrPage.UPDATE(false);
    // end;
    //BC UPGRADE SIVA <<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
}


