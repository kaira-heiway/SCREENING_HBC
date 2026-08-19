pageextension 51218 BlanketSalesOrderSubformExtCBN extends "Blanket Sales Order Subform"
{
    // version NAVW110.0,DITW110.00.10

    //     DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 02/01/2007 Added column "Line No." (not editable)
    //                                Bugfix AutoSplitKey process on new record with Collapse/Expand functionnality
    // DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    // DITW15.00.00.01 DDR 10/01/2008 Bugfix using F8 on new line
    //                                Change property HorzAlign=Right for collapsed total fields (line amount)
    //                                Added parameter BlankZero for function UpdateFormatField()
    //                                Remove ProcessTaxItemCharge();ProcessUpdateUnitPrice();InsertTaxItemCharge();
    // DITW15.00.00.01 DDR 23/01/2008 Added Drink-it Discount & Promotion Item Charges functionnalities
    //                                Added field "Collapse"
    //                                Bugfix Refresh columns
    //                                Added function UpdateExpandStatus
    //                                Change function UpdateFields for Discount & Promotion
    // DITW15.00.00.01 DDR 19/03/2008 move function InsertExtendedCharges()
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.16 DDR 26/03/2008 Remove (move into function) confirm message from function InsertExtendedCharges()
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.23 DDR 29/07/2008 Remove call function InsertExtendedCharges() from trigger OnAfterValidate field "No."
    //                                Updated function into InsertExtendedCharges()
    //                     31/07/2008 Move NewRecord() function into OnNewRecord trigger
    // DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
    //                                  "Empty Goods Item No."
    // DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //                     21/08/2009 issue 727 Added HorzAlign property in field "Unit Price,"Line Amount"
    //                     23/10/2009 issue 893 Removed fields "Gen. Prod. Posting Free Group"
    // DITW15.00.00.36 DDR 04/11/2009 issue 939 Performance SQL
    //                                Added function FormTotalingField()
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    //                     27/01/2011 issue 1259 Added update() on field "Cross-Reference No."
    //                                           Added non-editable when item is (free) item charge
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                           Added parameter line function RTCActionNewLine() into RTCNewLine button
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #1 RTC Upgrade Page functionnalities
    //                                             Modified function UpdateFields()
    // DITW16.00.00.38 DDR 07/03/2011 DIT-715 #71 RTC Upgrade Page functionnalities
    //                                             Modified order position RTC buttons
    //                                               contol1102601007 RTCNewLine
    //                                               contol1102601008 RTCDeleteLine
    //                                               contol1102601009 RTCDleteAllLines
    //                     15/03/2011 issue 1217 (DIT711 163) Added EMCS fields
    //                                               "AAD No. Series","LRN No. Series","SAD No.","Tariff No."
    //                     15/03/2011 issue 1291 Modified trigger field "No." activate function InsertExtendedText() other than items
    //                     16/03/2011 issue 1217 (DIT711 161) Added field "Packaging Type Code"
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade Added/Review Total Line Amount (Collapsed RTC)
    //                     26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)"
    //                     11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  Added function SetDisableRefreshLines() to call before/after each report object
    //                                                 (don't use the <RunObject> property)
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.03 DDR 10/06/2014 DIT-770 #541 Modified 'QuickEntry' property fields "Has Item Charge","Collapse"
    //                                          Removed 'IndentationControls' field1 Group Repeater
    // DITW17.10.03 DDR 11/06/2014 DIT-770 #570 Added menu 'Item Charge &Assignment (DIT)'
    //                                          Added shortcut for menu 'Item Charge Assignment (DIT)'
    // DITW17.10.03 DDR 10/07/2014 DIT-770 #541 Added editable other types than Item
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Unit Price"
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added field "Responsibity Center","Physical Location Group Code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Changes for Backorders (added action "reservation entries", "reserve", "Show Orig. Order"; added fields "Reserved Qty.")
    // HEI.01 FDD HNK SLSGAP009 IBM ISYED01 30/05/2017
    //   #change of unit price with Item expanded containing charge item and without charge item user should not be able to make changes.
    // DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackUnitPriceItem()
    // HEI.02 PATHAA02  15.11.17 # Description Non-Editable only for Type=Item.
    //BC UPGRADE KUMARR78 FDD-MTC-008 >>
    //1. Adding Show Item charge on Invoice Field
    //BC UPGRADE KUMARR78 FDD-MTC-008 <<

    layout
    {
        modify(Type)
        {
            Enabled = TypeEnable;

            //Unsupported feature: Change Editable on "Type(Control 2)". Please convert manually.

        }

        //Unsupported feature: Change Editable on ""Cross-Reference No."(Control 26)". Please convert manually.


        //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.

        modify(Quantity)
        {
            Enabled = QuantityEnable;

            //Unsupported feature: Change Editable on "Quantity(Control 8)". Please convert manually.

        }
        modify(PriceExists)
        {
            CaptionML = ENU = 'Sale Price Exists', FRA = 'Prix vente existant';
        }
        modify("Unit Price")
        {
            Enabled = "Unit PriceEnable";

            //Unsupported feature: Change Editable on ""Unit Price"(Control 12)". Please convert manually.

        }
        modify(LineDiscExists)
        {
            CaptionML = ENU = 'Sales Line Disc. Exists', FRA = 'Rem. ligne vente existante';
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


        //Unsupported feature: CodeModification on ""Cross-Reference No."(Control 26).OnLookup". Please convert manually.

        //trigger "(Control 26)();
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


        //Unsupported feature: CodeModification on ""Location Code"(Control 36).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        LocationCodeOnAfterValidate
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        LocationCodeOnAfterValidate;
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        if xRec."Location Code" <> "Location Code" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 DDR DIT-770 #1190
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
        UnitPriceOnAfterValidate;
        RedistributeTotalsOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Amount"(Control 28).OnValidate". Please convert manually.

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
        LineAmountOnAfterValidate;
        RedistributeTotalsOnAfterValidate;
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
        LineDiscount37OnAfterValidate;
        RedistributeTotalsOnAfterValidate;
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
        LineDiscountAmountOnAfterValid;
        RedistributeTotalsOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Qty. to Ship"(Control 18)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        QtytoShipOnAfterValidate;
        */
        //end;
        addfirst(Control1)
        {
            //Bc Upgrade YADAVM09 Drink it field commented>>
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
            // }//Bc Upgrade YADAVM09 Drink it field commented<<

            field("Line No."; Rec."Line No.")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = all;
            }
        }
        // addafter("VAT Prod. Posting Group")//Bc Upgrade YADAVM09 Drink it field commented>>
        // {
        //     field("GetTrackingItemNo()"; Rec.GetTrackingItemNo())
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
        //     field("Responsibility Center"; "Responsibility Center")
        //     {
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        //             if "Responsibility Center" <> xRec."Responsibility Center" then
        //                 CurrPage.UPDATE(true);
        //             // >>DITW18.00.06 DDR DIT-770 #1190
        //         end;
        //     }
        //     field("Physical Location Group Code"; "Physical Location Group Code")
        //     {
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        //             if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
        //                 CurrPage.UPDATE(true);
        //             // >>DITW18.00.06 DDR DIT-770 #1190
        //         end;
        //     }
        // }
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
        // }//Bc Upgrade YADAVM09 Drink it field commented<<
        addafter("Quantity Invoiced")
        {
            field("Reserved Quantity"; Rec."Reserved Quantity")
            {
                Visible = false;
                ApplicationArea = all;
            }
        }
        // addafter("Shipment Date")//Bc Upgrade YADAVM09 Drink it field commented>>
        // {
        //     field("AAD No. Series"; Rec."AAD No. Series")
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
        //     field("SAD No."; Rec."SAD No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Packaging Type Code"; Rec."Packaging Type Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Tariff No."; Rec."Tariff No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Free Item"; Rec."Free Item")
        //     {

        //         trigger OnValidate();
        //         begin
        //             FreeItemOnAfterValidate;
        //         end;
        //     }
        //     field("Allow VAT Calculation (Free)"; Rec."Allow VAT Calculation (Free)")
        //     {
        //         Description = 'DITW16.00.00.40 DIT-715 #172';
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             AllowVATCalculationFreeOnAfter;
        //         end;
        //     }
        //     field("Free Item Posting Type"; Rec."Free Item Posting Type")
        //     {
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             FreeItemPostingTypeOnAfterVali;
        //         end;
        //     }
        //     field("Allow Loyalty"; Rec."Allow Loyalty")
        //     {
        //         Description = 'DIT715 #243';
        //         QuickEntry = false;
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW17.10.05 WSA 02/02/2015 DIT-770 #185
        //             CurrPage.UPDATE;
        //             // >>DITW17.10.05 WSA 02/02/2015 DIT-770 #185
        //         end;
        //     }
        //     field("Loyalty Point Type"; "Loyalty Point Type")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Visible = false;
        //     }
        //     field("Loyalty Unit Point"; "Loyalty Unit Point")
        //     {
        //         Description = 'DIT715 #243';
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Loyalty Points Qty. (Base)"; "Loyalty Points Qty. (Base)")
        //     {
        //         Description = 'DIT715 #243';
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Loyalty Outstd. Pts Qty.(Base)"; Rec."Loyalty Outstd. Pts Qty.(Base)")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Loyalty Amount Type"; Rec."Loyalty Amount Type")
        //     {
        //         Description = 'DITW17.10.05 DIT-770 #185';
        //         Visible = false;
        //     }
        //     field("Loyalty Unit Amount"; Rec."Loyalty Unit Amount")
        //     {
        //         Visible = false;
        //     }
        //     field("Loyalty Unit Amount (LCY)"; Rec."Loyalty Unit Amount (LCY)")
        //     {
        //         Description = 'DIT715 #243';
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Loyalty Amount"; Rec."Loyalty Amount")
        //     {
        //         Visible = false;
        //     }
        //     field("Loyalty Amount (LCY)"; Rec."Loyalty Amount (LCY)")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it field commented<<
        addafter("ShortcutDimCode[8]")
        {
            field("RPM Damage / Loss"; Rec."RPM Damage / Loss FND")
            {
                ApplicationArea = All;
            }
            field("Transporter RPM Damage / Loss"; Rec."TransporterRPM Damage/Loss FND")
            {
                ApplicationArea = All;
            }
            //BC UPGRADE KUMARR78 FDD-MTC-008 >>
            field("Show Item charge on Invoice"; Rec."Show Item charge on Inv. FND")
            {
                ApplicationArea = all;
            }
            //BC UPGRADE KUMARR78 FDD-MTC-008 <<
        }
        // addafter(Control35)//Bc Upgrade YADAVM09 Drink it field commented>>
        // {
        //     field("GetTotalingLine(1,FIELDNO(""Line Amount""),true)"; GetTotalingLine(1, FIELDNO("Line Amount"), true))
        //     {
        //         AutoFormatExpression = "Currency Code";
        //         AutoFormatType = 1;
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassVar(PageText2014410);
        //         CaptionML = ENU = 'Total Line Amount',
        //                     FRA = 'Montant total ligne';
        //         Description = 'DITW16.00.00.37';
        //         Editable = false;
        //         Visible = false;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it field commented<<
    }
    actions
    {
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
        modify("Unposted Lines")
        {
            CaptionML = ENU = 'Unposted Lines', FRA = 'Lignes non validées';
        }
        modify(Orders)
        {
            CaptionML = ENU = 'Orders', FRA = 'Commandes';
        }
        modify(Invoices)
        {
            CaptionML = ENU = 'Invoices', FRA = 'Factures';
        }
        modify("Return Orders")
        {
            CaptionML = ENU = 'Return Orders', FRA = 'Retours';
        }
        modify("Credit Memos")
        {
            CaptionML = ENU = 'Credit Memos', FRA = 'Avoirs';
        }
        modify("Posted Lines")
        {
            CaptionML = ENU = 'Posted Lines', FRA = 'Lignes validées';
        }
        modify(Shipments)
        {
            CaptionML = ENU = 'Shipments', FRA = 'Livraisons';
        }
        modify(Action1901092104)
        {
            CaptionML = ENU = 'Invoices', FRA = 'Factures';
        }
        modify("Return Receipts")
        {
            CaptionML = ENU = 'Return Receipts', FRA = 'Réceptions retour';
        }
        modify(Action1901033504)
        {
            CaptionML = ENU = 'Credit Memos', FRA = 'Avoirs';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify("Assemble to Order")
        {
            CaptionML = ENU = 'Assemble to Order', FRA = 'Assemblage à la commande';
        }
        modify("Assemble-to-Order Lines")
        {
            CaptionML = ENU = 'Assemble-to-Order Lines', FRA = 'Lignes Assemblage à la commande';
        }
        modify("Roll Up &Price")
        {
            CaptionML = ENU = 'Roll Up &Price', FRA = '&Prix relation';
        }
        modify("Roll Up &Cost")
        {
            CaptionML = ENU = 'Roll Up &Cost', FRA = '&Coûts relation';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Get &Price")
        {
            CaptionML = ENU = 'Get &Price', FRA = 'Extraire &prix';
        }
        modify("Get Li&ne Discount")
        {
            CaptionML = ENU = 'Get Li&ne Discount', FRA = 'E&xtraire remise ligne';
        }
        modify("E&xplode BOM")
        {
            CaptionML = ENU = 'E&xplode BOM', FRA = '&Eclater nomenclature';
        }
        modify("Insert &Ext. Texts")
        {
            CaptionML = ENU = 'Insert &Ext. Texts', FRA = 'Insérer te&xtes étendus';
        }
        // addfirst(ActionContainer1900000004)//Bc Upgrade YADAVM09 Drink it field commented>>
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
        // addfirst("&Line")
        // {
        //     action("Insert Item Cha&rges")
        //     {
        //         CaptionML = ENU = 'Insert Item Cha&rges',
        //                     FRA = 'Insérer frais annexes';
        //         ShortCutKey = 'Ctrl+Y';

        //         trigger OnAction();
        //         begin
        //             //This functionality was copied from page #507. Unsupported part was commented. Please check it.
        //             /*CurrPage.SalesLines.PAGE.*/
        //             Rec._InsertExtendedCharges(true);

        //         end;
        //     }
        // }/
        // addafter(Orders)
        // {
        //     action("Original Order")
        //     {
        //         Caption = 'Original Order';
        //         Description = 'DITW110.00.10 SFI 20/06/2017 BL#15657';
        //         Image = Document;

        //         trigger OnAction();
        //         begin
        //             // << DITW110.00.10 SFI 20/06/2017 BL#15657
        //             ShowOrigOrder;
        //         end;
        //     }
        // }
        // addfirst("Posted Lines")
        // {
        //     action(Action1000000001)
        //     {
        //         Caption = 'Original Order';
        //         Description = 'DITW110.00.10 SFI 20/06/2017 BL#15657';
        //         Image = Document;

        //         trigger OnAction();
        //         begin
        //             // << DITW110.00.10 SFI 20/06/2017 BL#15657
        //             ShowOrigOrder;
        //         end;
        //     }
        // }
        // addafter("Insert &Ext. Texts")
        // {
        //     action(Reserve)
        //     {
        //         Caption = '&Reserve';
        //         Description = 'DITW110.00.10 SFI 20/06/2017 BL#15657';
        //         Ellipsis = true;
        //         Image = Reserve;

        //         trigger OnAction();
        //         begin
        //             FIND;
        //             ShowReservation;
        //         end;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it ACtion commented<<
    }

    var
        xRecRef: RecordRef;
        //cduAppMgt: Codeunit ApplicationManagement;//BC Upgrade YADAVM09 Obselete 
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Unit Price', FRA = 'Total prix unitaire';
        DisabledRefreshLines: Boolean;
        // BC Upgrade MISHRS14 >>
        // Blocked [InDataSet] TO REMOVE WARNING
        // [InDataSet]
        TypeEditable: Boolean;
        //[InDataSet]
        "No.Editable": Boolean;
        //[InDataSet]
        "Cross-Reference No.Editable": Boolean;
        //[InDataSet]
        QuantityEditable: Boolean;
        //[InDataSet]
        "Unit PriceEditable": Boolean;
        //[InDataSet]
        "Line AmountEditable": Boolean;
        //[InDataSet]
        TypeEnable: Boolean;
        //[InDataSet]
        "No.Enable": Boolean;
        //[InDataSet]
        QuantityEnable: Boolean;
        //[InDataSet]
        "Unit PriceEnable": Boolean;
        //[InDataSet]
        "Line AmountEnable": Boolean;
        // [InDataSet]
        ExpandLines: Boolean;
        // [InDataSet]
        // BC Upgrade MISHRS14 <<
        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        UserMgt: Codeunit "User Setup Management";
        Error004: Label 'You cannot change the %1 when the value has been filled in.';
        EditableDesc: Boolean;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if SalesHeader.GET("Document Type","Document No.") then;

    DocumentTotals.SalesUpdateTotalsControls(Rec,TotalSalesHeader,TotalSalesLine,RefreshMessageEnabled,
      TotalAmountStyle,RefreshMessageText,InvDiscAmountEditable,CurrPage.EDITABLE,VATAmount);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
    SETFILTER("Resp. Center Table Filter",
      UserMgt.GetRespCenterFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",
      UserMgt.GetRespPhysLocationFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",
      UserMgt.GetRespLocationFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 DDR DIT-770 #1190

    #1..4

    // <<DITW15.00.00.01 DDR 18/12/2007
    // VIGEO VS 29-12-2005: Toeslag regels mogen niet worden gewijzigd. Dit moet op het hoofdartikel worden gedaan.
    UpdateFields();
    // >>DITW15.00.00.01 DDR 18/12/2007
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    CLEAR(DocumentTotals);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    CLEAR(DocumentTotals);

    //PATHAA02 07.11.2017>>
    if Type <> Type::Item then
      EditableDesc:= true
    else
      EditableDesc:= false;
    //PATHAA02 07.11.2017<<
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    var
        TempRec: Record "Sales Line" temporary;
    //begin
    /*
    // <<DITW16.00.00.37 DDR 20/07/2010
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
    exit(FindRecordDIT(Which,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    "Line AmountEnable" := true;
    "Unit PriceEnable" := true;
    QuantityEnable := true;
    "No.Enable" := true;
    TypeEnable := true;
    "Line AmountEditable" := true;
    "Unit PriceEditable" := true;
    QuantityEditable := true;
    "Cross-Reference No.Editable" := true;
    "No.Editable" := true;
    TypeEditable := true;
    // >>DITW16.00.00.39 DDR DIT-715 #141
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
    ExpandLines := false;
    ShowButtonsCE := IsShowButtonsCEDIT();
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeModification on "ShowOrders(PROCEDURE 2)". Please convert manually.

    //procedure ShowOrders();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentSalesLine := Rec;
    SalesLine.RESET;
    SalesLine.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
    SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::Order);
    SalesLine.SETRANGE("Blanket Order No.",CurrentSalesLine."Document No.");
    SalesLine.SETRANGE("Blanket Order Line No.",CurrentSalesLine."Line No.");
    PAGE.RUNMODAL(PAGE::"Sales Lines",SalesLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.37 DIT-715 #1
    SalesLine.FILTERGROUP(4);
    // >>DITW16.00.00.37 DIT-715 #1
    #4..6
    // <<DITW16.00.00.37 DIT-715 #1
    SalesLine.FILTERGROUP(0);
    // >>DITW16.00.00.37 DIT-715 #1
    PAGE.RUNMODAL(PAGE::"Sales Lines",SalesLine);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowInvoices(PROCEDURE 4)". Please convert manually.

    //procedure ShowInvoices();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentSalesLine := Rec;
    SalesLine.RESET;
    SalesLine.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
    SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::Invoice);
    SalesLine.SETRANGE("Blanket Order No.",CurrentSalesLine."Document No.");
    SalesLine.SETRANGE("Blanket Order Line No.",CurrentSalesLine."Line No.");
    PAGE.RUNMODAL(PAGE::"Sales Lines",SalesLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.37 DIT-715 #1
    SalesLine.FILTERGROUP(4);
    // >>DITW16.00.00.37 DIT-715 #1
    #4..6
    // <<DITW16.00.00.37 DIT-715 #1
    SalesLine.FILTERGROUP(0);
    // >>DITW16.00.00.37 DIT-715 #1
    PAGE.RUNMODAL(PAGE::"Sales Lines",SalesLine);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowReturnOrders(PROCEDURE 9)". Please convert manually.

    //procedure ShowReturnOrders();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentSalesLine := Rec;
    SalesLine.RESET;
    SalesLine.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
    SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::"Return Order");
    SalesLine.SETRANGE("Blanket Order No.",CurrentSalesLine."Document No.");
    SalesLine.SETRANGE("Blanket Order Line No.",CurrentSalesLine."Line No.");
    PAGE.RUNMODAL(PAGE::"Sales Lines",SalesLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.37 DIT-715 #1
    SalesLine.FILTERGROUP(4);
    // >>DITW16.00.00.37 DIT-715 #1
    #4..6
    // <<DITW16.00.00.37 DIT-715 #1
    SalesLine.FILTERGROUP(0);
    // >>DITW16.00.00.37 DIT-715 #1
    PAGE.RUNMODAL(PAGE::"Sales Lines",SalesLine);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowCreditMemos(PROCEDURE 10)". Please convert manually.

    //procedure ShowCreditMemos();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentSalesLine := Rec;
    SalesLine.RESET;
    SalesLine.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
    SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::"Credit Memo");
    SalesLine.SETRANGE("Blanket Order No.",CurrentSalesLine."Document No.");
    SalesLine.SETRANGE("Blanket Order Line No.",CurrentSalesLine."Line No.");
    PAGE.RUNMODAL(PAGE::"Sales Lines",SalesLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.37 DIT-715 #1
    SalesLine.FILTERGROUP(4);
    // >>DITW16.00.00.37 DIT-715 #1
    #4..6
    // <<DITW16.00.00.37 DIT-715 #1
    SalesLine.FILTERGROUP(0);
    // >>DITW16.00.00.37 DIT-715 #1
    PAGE.RUNMODAL(PAGE::"Sales Lines",SalesLine);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowPostedOrders(PROCEDURE 17)". Please convert manually.

    //procedure ShowPostedOrders();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentSalesLine := Rec;
    SaleShptLine.RESET;
    SaleShptLine.SETCURRENTKEY("Blanket Order No.","Blanket Order Line No.");
    SaleShptLine.SETRANGE("Blanket Order No.",CurrentSalesLine."Document No.");
    SaleShptLine.SETRANGE("Blanket Order Line No.",CurrentSalesLine."Line No.");
    PAGE.RUNMODAL(PAGE::"Posted Sales Shipment Lines",SaleShptLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.37 DIT-715 #1
    SaleShptLine.FILTERGROUP(4);
    // >>DITW16.00.00.37 DIT-715 #1
    SaleShptLine.SETRANGE("Blanket Order No.",CurrentSalesLine."Document No.");
    SaleShptLine.SETRANGE("Blanket Order Line No.",CurrentSalesLine."Line No.");
    // <<DITW16.00.00.37 DIT-715 #1
    SaleShptLine.FILTERGROUP(0);
    // >>DITW16.00.00.37 DIT-715 #1
    PAGE.RUNMODAL(PAGE::"Posted Sales Shipment Lines",SaleShptLine);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowPostedInvoices(PROCEDURE 14)". Please convert manually.

    //procedure ShowPostedInvoices();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentSalesLine := Rec;
    SalesInvLine.RESET;
    SalesInvLine.SETCURRENTKEY("Blanket Order No.","Blanket Order Line No.");
    SalesInvLine.SETRANGE("Blanket Order No.",CurrentSalesLine."Document No.");
    SalesInvLine.SETRANGE("Blanket Order Line No.",CurrentSalesLine."Line No.");
    PAGE.RUNMODAL(PAGE::"Posted Sales Invoice Lines",SalesInvLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.37 DIT-715 #1
    SalesInvLine.FILTERGROUP(4);
    // >>DITW16.00.00.37 DIT-715 #1
    SalesInvLine.SETRANGE("Blanket Order No.",CurrentSalesLine."Document No.");
    SalesInvLine.SETRANGE("Blanket Order Line No.",CurrentSalesLine."Line No.");
    // <<DITW16.00.00.37 DIT-715 #1
    SalesInvLine.FILTERGROUP(0);
    // >>DITW16.00.00.37 DIT-715 #1
    PAGE.RUNMODAL(PAGE::"Posted Sales Invoice Lines",SalesInvLine);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowPostedReturnReceipts(PROCEDURE 13)". Please convert manually.

    //procedure ShowPostedReturnReceipts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentSalesLine := Rec;
    ReturnRcptLine.RESET;
    ReturnRcptLine.SETCURRENTKEY("Blanket Order No.","Blanket Order Line No.");
    ReturnRcptLine.SETRANGE("Blanket Order No.",CurrentSalesLine."Document No.");
    ReturnRcptLine.SETRANGE("Blanket Order Line No.",CurrentSalesLine."Line No.");
    PAGE.RUNMODAL(PAGE::"Posted Return Receipt Lines",ReturnRcptLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.37 DIT-715 #1
    ReturnRcptLine.FILTERGROUP(4);
    // >>DITW16.00.00.37 DIT-715 #1
    ReturnRcptLine.SETRANGE("Blanket Order No.",CurrentSalesLine."Document No.");
    ReturnRcptLine.SETRANGE("Blanket Order Line No.",CurrentSalesLine."Line No.");
    // <<DITW16.00.00.37 DIT-715 #1
    ReturnRcptLine.FILTERGROUP(0);
    // >>DITW16.00.00.37 DIT-715 #1
    PAGE.RUNMODAL(PAGE::"Posted Return Receipt Lines",ReturnRcptLine);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowPostedCreditMemos(PROCEDURE 11)". Please convert manually.

    //procedure ShowPostedCreditMemos();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentSalesLine := Rec;
    SalesCrMemoLine.RESET;
    SalesCrMemoLine.SETCURRENTKEY("Blanket Order No.","Blanket Order Line No.");
    SalesCrMemoLine.SETRANGE("Blanket Order No.",CurrentSalesLine."Document No.");
    SalesCrMemoLine.SETRANGE("Blanket Order Line No.",CurrentSalesLine."Line No.");
    PAGE.RUNMODAL(PAGE::"Posted Sales Credit Memo Lines",SalesCrMemoLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.37 DIT-715 #1
    SalesCrMemoLine.FILTERGROUP(4);
    // >>DITW16.00.00.37 DIT-715 #1
    SalesCrMemoLine.SETRANGE("Blanket Order No.",CurrentSalesLine."Document No.");
    SalesCrMemoLine.SETRANGE("Blanket Order Line No.",CurrentSalesLine."Line No.");
    // <<DITW16.00.00.37 DIT-715 #1
    SalesCrMemoLine.FILTERGROUP(0);
    // >>DITW16.00.00.37 DIT-715 #1
    PAGE.RUNMODAL(PAGE::"Posted Sales Credit Memo Lines",SalesCrMemoLine);
    */
    //end;


    //Unsupported feature: CodeModification on "NoOnAfterValidate(PROCEDURE 19066594)". Please convert manually.

    //procedure NoOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InsertExtendedText(false);

    SaveAndAutoAsmToOrder;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW15.00.00.36 DDR 25/11/2009 - DITW15.00.00.38 DDR 15/03/2011 #1291
    if (Type <> Type::Item) and not "Is Item Charge" then
    // >>DITW15.00.00.36 DDR - DITW15.00.00.38 DDR #1291
      InsertExtendedText(false);

    SaveAndAutoAsmToOrder;
    // <<DITW15.00.00.01 DDR 18/12/2007 - DITW15.00.00.23 DDR 30/07/2008
    CurrPage.UPDATE;
    // >>DITW15.00.00.23 DDR
    */
    //end;


    //Unsupported feature: CodeModification on "LocationCodeOnAfterValidate(PROCEDURE 20)". Please convert manually.

    //procedure LocationCodeOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SaveAndAutoAsmToOrder;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SaveAndAutoAsmToOrder;
    // <<DITW15.00.00.01 DDR 18/12/2007 - DITW15.00.00.23 DDR 30/07/2008
    CurrPage.UPDATE;
    // >>DITW15.00.00.23 DDR
    */
    //end;


    //Unsupported feature: CodeModification on "VariantCodeOnAfterValidate(PROCEDURE 19)". Please convert manually.

    //procedure VariantCodeOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SaveAndAutoAsmToOrder;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SaveAndAutoAsmToOrder;
    // <<DITW15.00.00.01 DDR 18/12/2007 - DITW15.00.00.23 DDR 30/07/2008
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

    // procedure _InsertExtendedCharges(FromHeader: Boolean);//Bc Upgrade YADAVM09 Drink it field commented>>
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
    //     "Unit PriceEditable" := FormEditableField(FIELDNO("Unit Price")) and not CollapsedLine;
    //     "Line AmountEditable" := FormEditableField(FIELDNO("Line Amount")) and not CollapsedLine;

    //     // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    //     TypeEnable := FormEditableField(FIELDNO(Type));
    //     "No.Enable" := FormEditableField(FIELDNO("No."));
    //     QuantityEnable := FormEditableField(FIELDNO(Quantity));
    //     "Unit PriceEnable" := FormEditableField(FIELDNO("Unit Price"));
    //     "Line AmountEnable" := FormEditableField(FIELDNO("Line Amount"));
    //     // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    // end;

    // local procedure TriggerOnDeleteRecord(): Boolean;
    // var
    //     TempRec: Record "Sales Line" temporary;
    // begin
    //     //cronus
    //     if (Rec.Quantity <> 0) and Rec.ItemExists(Rec."No.") then begin
    //         COMMIT;
    //     end;

    //     // <<DITW15.00.00.36 DDR 23/11/2009
    //     if "Is Item Charge" and "ItemCharge Incl. Price" then begin
    //         DELETE(true);
    //         TempRec := Rec;
    //         TempRec."Unit Price" := 0;
    //         TempRec."Line Amount" := 0;
    //         TempRec."Line Discount Amount" := 0;
    //         // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
    //         TempRec.CalcBackUnitPriceItem();
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
    //     // CurrPAGE.ItemPanel.VISIBLE := Type = Type::Item;
    //     if Type <> xRec.Type then
    //         CurrPage.UPDATE;
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure UnitPriceOnAfterValidate();
    // begin
    //     //HEI.01>>
    //     if (Type = Type::Item) or (Type = Type::"Charge (Item)") then begin
    //         if ("Unit Price" <> 0) and ("Unit Price" <> xRec."Unit Price") then
    //             ERROR(Error004, FIELDCAPTION("Unit Price"));
    //     end;
    //     //HEI.01<<
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

    // local procedure QtytoShipOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Qty. to Ship" <> xRec."Qty. to Ship")
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
    // end;//Bc Upgrade YADAVM09 Drink it function commented<<

    local procedure AllowVATCalculationFreeOnAfter();
    begin
        CurrPage.UPDATE(true);
    end;

    //Bc Upgrade YADAVM09 Drink it function commented>>
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

    // local procedure ShowOrigOrder();
    // begin
    //     // << DITW110.00.10 SFI 20/06/2017 BL#15657
    //     TESTFIELD("Original Sales Order No.");
    //     TESTFIELD("Original Sales Order Line No.");

    //     CurrentSalesLine := Rec;
    //     SalesLine.RESET;
    //     SalesLine.SETCURRENTKEY("Document Type", "No.", "Line No.");
    //     SalesLine.FILTERGROUP(4);
    //     SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
    //     SalesLine.SETRANGE("Document No.", CurrentSalesLine."Original Sales Order No.");
    //     SalesLine.SETRANGE("Line No.", CurrentSalesLine."Original Sales Order Line No.");
    //     SalesLine.FILTERGROUP(0);
    //     PAGE.RUNMODAL(PAGE::"Sales Lines", SalesLine);
    // end;//Bc Upgrade YADAVM09 Drink it function commented<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

