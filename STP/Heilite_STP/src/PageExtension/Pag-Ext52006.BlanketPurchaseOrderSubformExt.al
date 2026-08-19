pageextension 52006 BlanketPurchaseOrderSubformExt extends "Blanket Purchase Order Subform"
{
    // version NAVW110.0,DITW110.00.08,HEI.02
    /* 
    HEI.01 HLSRM02 IBM LAZARE02 27.07.2017
      # New fields for SRM integration
      # New action Prices for SRM integration
      # New action Notes for SRM integration
    HEI.02 CHG2109278 IBM NANDIS01 07/05/2021 - FAT UAT Defect 6291 - the column Qty to return doesn´t appear anymore
      Field shown - "Qty. to Return"
     */
    // BC Upgrade BHARDA11 >>
    // 1. Remove Drink-IT Field("Has Item Charge",Collapse,"Physical Location Group Code",RTCTotalLine,RTCTotalUnit,"Approved Line Amount","AAD No.","ARC No.","SAD No.","Packaging Type Code","Free Item","Allow VAT Calculation (Free)","Free Item Posting Type","Linked Customer No.",GetTotalingLine,"App. Prod. Posting Group").
    // 2. Remove Drink-IT Function(GetTrackingItemNo,_InsertExtendedCharges,InsertExtendedCharges,UpdateFields,TriggerOnDeleteRecord,SetDisableRefreshLines,TypeOnAfterValidate,VariantCodeOnAfterValidate,LocationCodeOnAfterValidate,QuantityOnAfterValidate,UnitofMeasureCodeOnAfterValida,DirectUnitCostOnAfterValidate,LineAmountOnAfterValidate,LineDiscount37OnAfterValidate,LineDiscountAmountOnAfterValid,QtytoReceiveOnAfterValidate,FreeItemOnAfterValidate,FreeItemPostingTypeOnAfterVali)
    // 3. Remove Drink-IT Customization (Actions and fields)
    // 4. Add Applicationarea property in fields.
    // BC Upgrade BHARDA11 <<


    layout
    {
        modify(Type)
        {
            Enabled = TypeEnable;

            //Unsupported feature: Change Editable on "Type(Control 2)". Please convert manually.

        }

        //Unsupported feature: Change Editable on ""Cross-Reference No."(Control 22)". Please convert manually.

        modify(Quantity)
        {

            //Unsupported feature: Change BlankZero on "Quantity(Control 8)". Please convert manually.

            Enabled = QuantityEnable;

            //Unsupported feature: Change Editable on "Quantity(Control 8)". Please convert manually.

        }

        //Unsupported feature: Change BlankZero on ""Direct Unit Cost"(Control 12)". Please convert manually.


        //Unsupported feature: Change Editable on ""Direct Unit Cost"(Control 12)". Please convert manually.

        modify("Unit Price (LCY)")
        {
            Enabled = "Unit Price (LCY)Enable";
        }
        modify("Line Amount")
        {

            //Unsupported feature: Change BlankZero on ""Line Amount"(Control 32)". Please convert manually.

            Enabled = "Line AmountEnable";

            //Unsupported feature: Change Editable on ""Line Amount"(Control 32)". Please convert manually.

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

            //Unsupported feature: Change DrillDown on ""Total Amount Excl. VAT"(Control 13)". Please convert manually.

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
        // modify(RefreshTotals)
        // {

        //     //Unsupported feature: Change DrillDown on "RefreshTotals(Control 7)". Please convert manually.

        //     ShowCaption = No;
        // }
        addfirst(Control1)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Field("Has Item Charge",Collapse)
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
            //         CurrPage.UPDATE(TRUE);
            //         // >>DITW15.00.00.37 DDR
            //     end;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Field("Has Item Charge",Collapse)

        }
        addafter("VAT Prod. Posting Group")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Function(GetTrackingItemNo)
            // field(GetTrackingItemNo(); Rec.GetTrackingItemNo())
            // {
            //     ApplicationArea = All;
            //     CaptionML = ENU = 'Tracking Item No. (Item Charge)',
            //                 FRA = 'N° article traçable (Frais annexes)';
            //     DrillDownPageID = "Item List";
            //     Editable = false;
            //     LookupPageID = "Item List";
            //     TableRelation = IF ("Item Charge Type" = CONST(Tax)) Item WHERE("No." = FIELD("Tax Item No."))
            //     ELSE IF (Item Charge Type=CONST(Deposit)) Item WHERE (No.=FIELD("Empty Goods Item No."));
            //         Visible = false;

            //     trigger OnLookup(var Text: Text): Boolean;
            //     begin
            //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
            //         Text := GetTrackingItemNo();
            //         LookupItemNo(Text);
            //         EXIT(FALSE);
            //     end;
            // }
            // BC Upgrade BHARDA11 >> ----Drink-IT Function(GetTrackingItemNo)
        }
        addafter(Description)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Code and Drink-IT Fields ("Physical Location Group Code")
            // field("Responsibility Center"; Rec."Responsibility Center")
            // {
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
            //         IF "Responsibility Center" <> xRec."Responsibility Center" THEN
            //             CurrPage.UPDATE(TRUE);
            //         // >>DITW18.00.06 DDR DIT-770 #1191
            //     end;
            // }
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
            //         IF "Physical Location Group Code" <> xRec."Physical Location Group Code" THEN
            //             CurrPage.UPDATE(TRUE);
            //         // >>DITW18.00.06 DDR DIT-770 #1191
            //     end;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Code and Drink-IT Fields ("Physical Location Group Code")
        }
        addafter("Line Amount")
        {

            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = All;
            }
            // BC Upgrade BHARDA11 >> ---- Drink-IT Fields (RTCTotalLine,RTCTotalUnit,"Approved Line Amount")

            // field("Approved Line Amount"; Rec."Approved Line Amount")
            // {
            //     Description = 'DITW17.00.02 DIT-770 #144';
            //     Visible = false;
            // }
            // field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Direct Unit Cost"), TRUE))
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
            // field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), TRUE))
            // {
            //     AutoFormatExpression = "Currency Code";
            //     AutoFormatType = 1;
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassVar(PageText2014410);
            //     CaptionML = ENU = 'Total Line Amount',
            //                 FRA = 'Montant total ligne';
            //     Description = 'DITW17.10.02B DIT-770 #541';
            //     Editable = false;
            //     QuickEntry = false;
            // }
            // BC Upgrade BHARDA11 << ---- Drink-IT Fields (RTCTotalLine,RTCTotalUnit,"Approved Line Amount")

        }
        addafter("Qty. to Receive")
        {
            field("Qty. to Return"; Rec."Qty. to Return FND")
            {
                ApplicationArea = All;
            }
        }
        // BC Upgrade BHARDA11 >> ----drink-IT Fields("AAD No.","ARC No.","SAD No.","Packaging Type Code","Free Item","Allow VAT Calculation (Free)","Free Item Posting Type","Linked Customer No.",GetTotalingLine,"App. Prod. Posting Group"
        // addafter("Expected Receipt Date")
        // {
        //     field("AAD No."; Rec."AAD No.")
        //     {
        //         Visible = false;
        //     }
        //     field("ARC No."; Rec."ARC No.")
        //     {
        //         Description = 'DITW15.00.00.38 #1217';
        //         Visible = false;

        //         trigger OnLookup(var Text: Text): Boolean;
        //         begin
        //             // <<DITW15.00.00.38 DDR 30/09/2010 #1217
        //             EXIT(
        //               EDILookupExtTrackingARC(Text));
        //             // >>DITW15.00.00.38 DDR
        //         end;
        //     }
        //     field("SAD No."; Rec."SAD No.")
        //     {
        //         Description = 'DITW15.00.00.38 #1217';
        //         Visible = false;
        //     }
        //     field("Packaging Type Code"; Rec."Packaging Type Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Free Item"; Rec."Free Item")
        //     {

        //         trigger OnValidate();
        //         begin
        //             Rec.FreeItemOnAfterValidate;
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
        //     field("Linked Customer No."; Rec."Linked Customer No.")
        //     {
        //         Visible = false;
        //     }
        // }
        // BC Upgrade BHARDA11 << ----drink-IT Fields("AAD No.","ARC No.","SAD No.","Packaging Type Code","Free Item","Allow VAT Calculation (Free)","Free Item Posting Type","Linked Customer No.")

        addafter("ShortcutDimCode[8]")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields (GetTotalingLine,"App. Prod. Posting Group","Contract Type","DIT Sub-Contract Type","Contract Group Code","Service Contract No.","Financial Contract No.")
            // field(GetTotalingLine(1,FIELDNO("Line Amount"),TRUE);GetTotalingLine(1,FIELDNO("Line Amount"),TRUE))
            // {
            //     AutoFormatExpression = "Currency Code";
            //     AutoFormatType = 1;
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassVar(PageText2014410);
            //     CaptionML = ENU='Total Line Amount',
            //                 FRA='Montant total ligne';
            //     Description = 'DITW16.00.00.37';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("App. Prod. Posting Group";"App. Prod. Posting Group")
            // {
            //     Description = 'DITW17.00.02 DIT-770 #144';
            //     Visible = false;
            // }
            // field("Contract Type"; Rec."Contract Type")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            //     Visible = false;
            // }
            // field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Contract Group Code"; Rec."Contract Group Code")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Service Contract No."; Rec."Service Contract No.")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Financial Contract No."; Rec."Financial Contract No.")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields (GetTotalingLine,"App. Prod. Posting Group","Contract Type","DIT Sub-Contract Type","Contract Group Code","Service Contract No.","Financial Contract No.")
            field("Consumption Location Code"; Rec."Consumption Location Code FND")
            {
                ApplicationArea = All;
            }
            field("SRM Contract No."; Rec."SRM Contract No. FND")
            {
                ApplicationArea = All;
            }
            field("SRM Contract Line No."; Rec."SRM Contract Line No. FND")
            {
                ApplicationArea = All;
            }
            field("SRM Contract Type"; Rec."SRM Contract Type FND")
            {
                ApplicationArea = All;
            }
            field("Valid From"; Rec."Valid From FND")
            {
                ApplicationArea = All;
            }
            field("Valid To"; Rec."Valid To FND")
            {
                ApplicationArea = All;
            }
            field("Type ID"; Rec."Type ID FND")
            {
                ApplicationArea = All;
            }
            field("Block Line Ordering"; Rec."Block Line Ordering FND")
            {
                ApplicationArea = All;
            }
            field("Delivery Finalized"; Rec."Delivery Finalized FND")
            {
                ApplicationArea = All;
            }
            field("Initial Quantity"; Rec."Initial Quantity FND")
            {
                ApplicationArea = All;
            }
            field("Tolerance Received Over %"; Rec."Tolerance Received Over % FND")
            {
                ApplicationArea = All;
            }
            field("Tolerance Received Under %"; Rec."Tolerance Received Under % FND")
            {
                ApplicationArea = All;
            }
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

            //Unsupported feature: Change AccessByPermission on ""E&xplode BOM"(Action 1901312904)". Please convert manually.

            CaptionML = ENU = 'E&xplode BOM', FRA = '&Eclater nomenclature';
        }
        modify("Insert &Ext. Texts")
        {

            //Unsupported feature: Change AccessByPermission on ""Insert &Ext. Texts"(Action 1901313304)". Please convert manually.

            CaptionML = ENU = 'Insert &Ext. Texts', FRA = 'Insérer te&xtes étendus';
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

            //Unsupported feature: Change AccessByPermission on "Location(Action 1901313404)". Please convert manually.

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

            //Unsupported feature: Change AccessByPermission on ""Return Orders"(Action 1903098504)". Please convert manually.

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
        modify(Receipts)
        {
            CaptionML = ENU = 'Receipts', FRA = 'Réceptions';
        }
        modify(Action1904522204)
        {
            CaptionML = ENU = 'Invoices', FRA = 'Factures';
        }
        modify("Return Receipts")
        {
            CaptionML = ENU = 'Return Receipts', FRA = 'Réceptions retour';
        }
        modify(Action1902056104)
        {
            CaptionML = ENU = 'Credit Memos', FRA = 'Avoirs';
        }
        modify(Dimensions)
        {

            //Unsupported feature: Change AccessByPermission on "Dimensions(Action 1906874004)". Please convert manually.

            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""F&unctions"(Action 1906587504)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""E&xplode BOM"(Action 1901312904)". Please convert manually.



        //Unsupported feature: CodeModification on ""Insert &Ext. Texts"(Action 1901313304).OnAction". Please convert manually.

        //trigger  Texts"(Action 1901313304)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        InsertExtendedText(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        InsertExtendedText(TRUE);
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Insert &Ext. Texts"(Action 1901313304)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Line"(Action 1907935204)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item Availability by"(Action 1901991404)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Event(Action 5)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Period(Action 1900205704)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Variant(Action 1901652104)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Location(Action 1901313404)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""BOM Level"(Action 3)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unposted Lines"(Action 1903868004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Orders(Action 1903100004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Invoices(Action 1900546404)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Return Orders"(Action 1903098504)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Credit Memos"(Action 1901992804)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posted Lines"(Action 1901314404)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Receipts(Action 1900296804)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Action1904522204(Action 1904522204)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Return Receipts"(Action 1903926304)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Action1902056104(Action 1902056104)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Dimensions(Action 1906874004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Co&mments"(Action 1900978604)". Please convert manually.
        // BC Upgrade BHARAD11 >> ----drink-IT Customization
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
        // }
        // BC Upgrade BHARAD11 << ----drink-IT Customization
        addafter("Insert &Ext. Texts")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
            // action("Insert Item Char&ges")
            // {
            //     CaptionML = ENU = 'Insert Item Char&ges',
            //                 FRA = 'Insérer frais annexes';
            //     ShortCutKey = 'Ctrl+Y';

            //     trigger OnAction();
            //     begin
            //         //This functionality was copied from page #509. Unsupported part was commented. Please check it.
            //         /*CurrPage.PurchLines.PAGE.*/
            //         _InsertExtendedCharges(TRUE);

            //     end;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Customization
        }
        addafter("Posted Lines")
        {
            action(Prices)
            {
                ApplicationArea = All;
                Caption = 'Prices';
                Image = Price;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedIsBig = true;

                RunObject = page "Purchase Line Prices CBN";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Document Line No." = FIELD("Line No.");
            }
        }
        addafter("Co&mments")
        {
            action(Notes)
            {
                ApplicationArea = All;
                Caption = 'Notes';
                Image = Notes;
                RunObject = Page "Purchase Line Notes CBN";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
            }
        }
    }


    //Unsupported feature: PropertyModification on ""Invoice Discount Amount"(Control 31).OnValidate.PurchaseHeader(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //"Invoice Discount Amount" : "Purchase Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Invoice Discount Amount" : 38;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ShowPostedReceipts(PROCEDURE 17).PurchRcptLine(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShowPostedReceipts : "Purch. Rcpt. Line";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShowPostedReceipts : 121;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ShowPostedInvoices(PROCEDURE 14).PurchInvLine(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShowPostedInvoices : "Purch. Inv. Line";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShowPostedInvoices : 123;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ShowPostedReturnReceipts(PROCEDURE 13).ReturnShptLine(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShowPostedReturnReceipts : "Return Shipment Line";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShowPostedReturnReceipts : 6651;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ShowPostedCreditMemos(PROCEDURE 11).PurchCrMemoLine(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShowPostedCreditMemos : "Purch. Cr. Memo Line";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShowPostedCreditMemos : 125;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "TotalPurchaseHeader(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //TotalPurchaseHeader : "Purchase Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TotalPurchaseHeader : 38;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "TotalPurchaseLine(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //TotalPurchaseLine : "Purchase Line";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TotalPurchaseLine : 39;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "PurchHeader(Variable 1016)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PurchHeader : "Purchase Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PurchHeader : 38;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "PurchLine(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PurchLine : "Purchase Line";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PurchLine : 39;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CurrentPurchLine(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CurrentPurchLine : "Purchase Line";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CurrentPurchLine : 39;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "TransferExtendedText(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //TransferExtendedText : "Transfer Extended Text";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TransferExtendedText : 378;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ItemAvailFormsMgt(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ItemAvailFormsMgt : "Item Availability Forms Mgt";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemAvailFormsMgt : 353;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "PurchCalcDiscByType(Variable 1015)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PurchCalcDiscByType : "Purch - Calc Disc. By Type";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PurchCalcDiscByType : 66;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DocumentTotals(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DocumentTotals : "Document Totals";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DocumentTotals : 57;
    //Variable type has not been exported.

    var
        xRecRef: RecordRef;
        // cduAppMgt: Codeunit "1";
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Direct Unit Cost', FRA = 'Total coût unitaire directe';
        DisabledRefreshLines: Boolean;

        TypeEditable: Boolean;

        "No.Editable": Boolean;

        "Cross-Reference No.Editable": Boolean;

        QuantityEditable: Boolean;

        "Direct Unit CostEditable": Boolean;

        "Line AmountEditable": Boolean;

        TypeEnable: Boolean;

        "No.Enable": Boolean;

        QuantityEnable: Boolean;

        "Unit Price (LCY)Enable": Boolean;

        "Line AmountEnable": Boolean;

        ExpandLines: Boolean;

        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        UserMgt: Codeunit 5700;


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
    // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
    SETFILTER("Resp. Center Table Filter",
      UserMgt.GetRespCenterFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",
      UserMgt.GetRespPhysLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",
      UserMgt.GetRespLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 DDR DIT-770 #1191

    IF PurchHeader.GET("Document Type","Document No.") THEN;
    #2..4
    // <<DITW15.00.00.01 DDR 18/12/2007
    // VIGEO VS 29-12-2005: Toeslag regels mogen niet worden gewijzigd. Dit moet op het hoofdartikel worden gedaan.
    UpdateFields();
    // >>DITW15.00.00.01 DDR 18/12/2007
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    var
        TempRec: Record 39 temporary;
    //begin
    /*
    // <<DITW16.00.00.37 DDR 20/07/2010
    // Move to function TriggerOnDeleteRecord() to solve RTC Collapse delete records
    // Temporary until next Mirosoft release
    EXIT(TriggerOnDeleteRecord());
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
    EXIT(FindRecordDIT(Which,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    "Line AmountEnable" := TRUE;
    "Unit Price (LCY)Enable" := TRUE;
    QuantityEnable := TRUE;
    "No.Enable" := TRUE;
    TypeEnable := TRUE;
    "Line AmountEditable" := TRUE;
    "Direct Unit CostEditable" := TRUE;
    QuantityEditable := TRUE;
    "Cross-Reference No.Editable" := TRUE;
    "No.Editable" := TRUE;
    TypeEditable := TRUE;
    // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
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
    IF NOT ISEMPTY THEN
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
    EXIT(NextRecordDIT(Steps,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    ExpandLines := FALSE;
    ShowButtonsCE := IsShowButtonsCEDIT();
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeModification on "InsertExtendedText(PROCEDURE 6)". Please convert manually.

    //procedure InsertExtendedText();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if TransferExtendedText.PurchCheckIfAnyExtText(Rec,Unconditionally) then begin
      CurrPage.SAVERECORD;
      TransferExtendedText.InsertPurchExtText(Rec);
    end;
    if TransferExtendedText.MakeUpdate then
      UpdateForm(true);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF TransferExtendedText.PurchCheckIfAnyExtText(Rec,Unconditionally) THEN BEGIN
      CurrPage.SAVERECORD;
      TransferExtendedText.InsertPurchExtText(Rec);
    END;
    IF TransferExtendedText.MakeUpdate THEN
      UpdateForm(TRUE);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowOrders(PROCEDURE 2)". Please convert manually.

    //procedure ShowOrders();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentPurchLine := Rec;
    PurchLine.RESET;
    PurchLine.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
    PurchLine.SETRANGE("Document Type",PurchLine."Document Type"::Order);
    PurchLine.SETRANGE("Blanket Order No.",CurrentPurchLine."Document No.");
    PurchLine.SETRANGE("Blanket Order Line No.",CurrentPurchLine."Line No.");
    PAGE.RUNMODAL(PAGE::"Purchase Lines",PurchLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.37 DIT-715 #1
    PurchLine.FILTERGROUP(4);
    // >>DITW16.00.00.37 DIT-715 #1
    #4..6
    // <<DITW16.00.00.37 DIT-715 #1
    PurchLine.FILTERGROUP(0);
    // >>DITW16.00.00.37 DIT-715 #1
    PAGE.RUNMODAL(PAGE::"Purchase Lines",PurchLine);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowInvoices(PROCEDURE 4)". Please convert manually.

    //procedure ShowInvoices();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentPurchLine := Rec;
    PurchLine.RESET;
    PurchLine.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
    PurchLine.SETRANGE("Document Type",PurchLine."Document Type"::Invoice);
    PurchLine.SETRANGE("Blanket Order No.",CurrentPurchLine."Document No.");
    PurchLine.SETRANGE("Blanket Order Line No.",CurrentPurchLine."Line No.");
    PAGE.RUNMODAL(PAGE::"Purchase Lines",PurchLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.37 DIT-715 #1
    PurchLine.FILTERGROUP(4);
    // >>DITW16.00.00.37 DIT-715 #1
    #4..6
    // <<DITW16.00.00.37 DIT-715 #1
    PurchLine.FILTERGROUP(0);
    // >>DITW16.00.00.37 DIT-715 #1
    PAGE.RUNMODAL(PAGE::"Purchase Lines",PurchLine);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowReturnOrders(PROCEDURE 9)". Please convert manually.

    //procedure ShowReturnOrders();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentPurchLine := Rec;
    PurchLine.RESET;
    PurchLine.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
    PurchLine.SETRANGE("Document Type",PurchLine."Document Type"::"Return Order");
    PurchLine.SETRANGE("Blanket Order No.",CurrentPurchLine."Document No.");
    PurchLine.SETRANGE("Blanket Order Line No.",CurrentPurchLine."Line No.");
    PAGE.RUNMODAL(PAGE::"Purchase Lines",PurchLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.37 DIT-715 #1
    PurchLine.FILTERGROUP(4);
    // >>DITW16.00.00.37 DIT-715 #1
    #4..6
    // <<DITW16.00.00.37 DIT-715 #1
    PurchLine.FILTERGROUP(0);
    // >>DITW16.00.00.37 DIT-715 #1
    PAGE.RUNMODAL(PAGE::"Purchase Lines",PurchLine);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowCreditMemos(PROCEDURE 10)". Please convert manually.

    //procedure ShowCreditMemos();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentPurchLine := Rec;
    PurchLine.RESET;
    PurchLine.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
    PurchLine.SETRANGE("Document Type",PurchLine."Document Type"::"Credit Memo");
    PurchLine.SETRANGE("Blanket Order No.",CurrentPurchLine."Document No.");
    PurchLine.SETRANGE("Blanket Order Line No.",CurrentPurchLine."Line No.");
    PAGE.RUNMODAL(PAGE::"Purchase Lines",PurchLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.37 DIT-715 #1
    PurchLine.FILTERGROUP(4);
    // >>DITW16.00.00.37 DIT-715 #1
    #4..6
    // <<DITW16.00.00.37 DIT-715 #1
    PurchLine.FILTERGROUP(0);
    // >>DITW16.00.00.37 DIT-715 #1
    PAGE.RUNMODAL(PAGE::"Purchase Lines",PurchLine);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowPostedReceipts(PROCEDURE 17)". Please convert manually.

    //procedure ShowPostedReceipts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentPurchLine := Rec;
    PurchRcptLine.RESET;
    PurchRcptLine.SETCURRENTKEY("Blanket Order No.","Blanket Order Line No.");
    PurchRcptLine.SETRANGE("Blanket Order No.",CurrentPurchLine."Document No.");
    PurchRcptLine.SETRANGE("Blanket Order Line No.",CurrentPurchLine."Line No.");
    PAGE.RUNMODAL(PAGE::"Posted Purchase Receipt Lines",PurchRcptLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.37 DIT-715 #1
    PurchRcptLine.FILTERGROUP(4);
    // >>DITW16.00.00.37 DIT-715 #1
    PurchRcptLine.SETRANGE("Blanket Order No.",CurrentPurchLine."Document No.");
    PurchRcptLine.SETRANGE("Blanket Order Line No.",CurrentPurchLine."Line No.");
    // <<DITW16.00.00.37 DIT-715 #1
    PurchRcptLine.FILTERGROUP(0);
    // >>DITW16.00.00.37 DIT-715 #1
    PAGE.RUNMODAL(PAGE::"Posted Purchase Receipt Lines",PurchRcptLine);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowPostedInvoices(PROCEDURE 14)". Please convert manually.

    //procedure ShowPostedInvoices();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentPurchLine := Rec;
    PurchInvLine.RESET;
    PurchInvLine.SETCURRENTKEY("Blanket Order No.","Blanket Order Line No.");
    PurchInvLine.SETRANGE("Blanket Order No.",CurrentPurchLine."Document No.");
    PurchInvLine.SETRANGE("Blanket Order Line No.",CurrentPurchLine."Line No.");
    PAGE.RUNMODAL(PAGE::"Posted Purchase Invoice Lines",PurchInvLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.37 DIT-715 #1
    PurchInvLine.FILTERGROUP(4);
    // >>DITW16.00.00.37 DIT-715 #1
    PurchInvLine.SETRANGE("Blanket Order No.",CurrentPurchLine."Document No.");
    PurchInvLine.SETRANGE("Blanket Order Line No.",CurrentPurchLine."Line No.");
    // <<DITW16.00.00.37 DIT-715 #1
    PurchInvLine.FILTERGROUP(0);
    // >>DITW16.00.00.37 DIT-715 #1
    PAGE.RUNMODAL(PAGE::"Posted Purchase Invoice Lines",PurchInvLine);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowPostedReturnReceipts(PROCEDURE 13)". Please convert manually.

    //procedure ShowPostedReturnReceipts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentPurchLine := Rec;
    ReturnShptLine.RESET;
    ReturnShptLine.SETCURRENTKEY("Blanket Order No.","Blanket Order Line No.");
    ReturnShptLine.SETRANGE("Blanket Order No.",CurrentPurchLine."Document No.");
    ReturnShptLine.SETRANGE("Blanket Order Line No.",CurrentPurchLine."Line No.");
    PAGE.RUNMODAL(PAGE::"Posted Return Shipment Lines",ReturnShptLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.37 DIT-715 #1
    ReturnShptLine.FILTERGROUP(4);
    // >>DITW16.00.00.37 DIT-715 #1
    ReturnShptLine.SETRANGE("Blanket Order No.",CurrentPurchLine."Document No.");
    ReturnShptLine.SETRANGE("Blanket Order Line No.",CurrentPurchLine."Line No.");
    // <<DITW16.00.00.37 DIT-715 #1
    ReturnShptLine.FILTERGROUP(0);
    // >>DITW16.00.00.37 DIT-715 #1
    PAGE.RUNMODAL(PAGE::"Posted Return Shipment Lines",ReturnShptLine);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowPostedCreditMemos(PROCEDURE 11)". Please convert manually.

    //procedure ShowPostedCreditMemos();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentPurchLine := Rec;
    PurchCrMemoLine.RESET;
    PurchCrMemoLine.SETCURRENTKEY("Blanket Order No.","Blanket Order Line No.");
    PurchCrMemoLine.SETRANGE("Blanket Order No.",CurrentPurchLine."Document No.");
    PurchCrMemoLine.SETRANGE("Blanket Order Line No.",CurrentPurchLine."Line No.");
    PAGE.RUNMODAL(PAGE::"Posted Purchase Cr. Memo Lines",PurchCrMemoLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.37 DIT-715 #1
    PurchCrMemoLine.FILTERGROUP(4);
    // >>DITW16.00.00.37 DIT-715 #1
    PurchCrMemoLine.SETRANGE("Blanket Order No.",CurrentPurchLine."Document No.");
    PurchCrMemoLine.SETRANGE("Blanket Order Line No.",CurrentPurchLine."Line No.");
    // <<DITW16.00.00.37 DIT-715 #1
    PurchCrMemoLine.FILTERGROUP(0);
    // >>DITW16.00.00.37 DIT-715 #1
    PAGE.RUNMODAL(PAGE::"Posted Purchase Cr. Memo Lines",PurchCrMemoLine);
    */
    //end;


    //Unsupported feature: CodeModification on "NoOnAfterValidate(PROCEDURE 19066594)". Please convert manually.

    //procedure NoOnAfterValidate();
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
    // <<DITW15.00.00.36 DDR 25/11/2009 - DITW15.00.00.38 DDR 15/03/2011 #1291
    IF (Type <> Type::Item) AND NOT "Is Item Charge" THEN
    // >>DITW15.00.00.36 DDR - DITW15.00.00.38 DDR #1291
      InsertExtendedText(FALSE);

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


    //Unsupported feature: CodeModification on "RedistributeTotalsOnAfterValidate(PROCEDURE 8)". Please convert manually.

    //procedure RedistributeTotalsOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.SAVERECORD;

    PurchHeader.GET("Document Type","Document No.");
    if DocumentTotals.PurchaseCheckNumberOfLinesLimit(PurchHeader) then
      DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalPurchaseLine);
    CurrPage.UPDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    IF DocumentTotals.PurchaseCheckNumberOfLinesLimit(PurchHeader) THEN
      DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalPurchaseLine);
    CurrPage.UPDATE;
    */
    //end;
    // BC Upgrade BHARDA11 >> ----Drink-IT Function(_InsertExtendedCharges,InsertExtendedCharges,UpdateFields,TriggerOnDeleteRecord,SetDisableRefreshLines,TypeOnAfterValidate,VariantCodeOnAfterValidate,LocationCodeOnAfterValidate,QuantityOnAfterValidate,UnitofMeasureCodeOnAfterValida,DirectUnitCostOnAfterValidate,LineAmountOnAfterValidate,LineDiscount37OnAfterValidate,LineDiscountAmountOnAfterValid,QtytoReceiveOnAfterValidate,FreeItemOnAfterValidate,FreeItemPostingTypeOnAfterVali)
    // procedure _InsertExtendedCharges(FromHeader: Boolean);
    // begin
    //     // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
    //     IF InsertChargeLines(FromHeader) THEN
    //         UpdateForm(TRUE);
    //     // >>DITW15.00.00.23 DDR
    // end;

    // procedure InsertExtendedCharges(FromHeader: Boolean);
    // begin
    //     // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
    //     IF InsertChargeLines(FromHeader) THEN
    //         UpdateForm(TRUE);
    //     // >>DITW15.00.00.23 DDR
    // end;

    // local procedure UpdateFields();
    // var
    //     CollapsedLine: Boolean;
    // begin
    //     // <<DITW15.00.00.01 DDR 15/02/2008 - DITW15.00.00.38 DDR 16/07/2010 #1194
    //     // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
    //     CollapsedLine := NOT ExpandLines;
    //     // >>DITW17.10.03 DDR DIT-770 #541
    //     // <<DITW17.10.03 DDR 09/07/2014 DIT-770 #541
    //     CALCFIELDS("Has Item Charge");
    //     CollapsedLine := CollapsedLine AND "Has Item Charge";
    //     // >>DITW17.10.03 DDR DIT-770 #541
    //     TypeEditable := FormEditableField(FIELDNO(Type));
    //     "No.Editable" := FormEditableField(FIELDNO("No."));
    //     // <<DITW15.00.00.38 DDR 27/01/2011 #1259
    //     "Cross-Reference No.Editable" := FormEditableField(FIELDNO("Cross-Reference No."));
    //     // >>DITW15.00.00.38 DDR #1259

    //     QuantityEditable := FormEditableField(FIELDNO(Quantity));
    //     "Direct Unit CostEditable" := FormEditableField(FIELDNO("Direct Unit Cost")) AND NOT CollapsedLine;
    //     "Line AmountEditable" := FormEditableField(FIELDNO("Line Amount")) AND NOT CollapsedLine;

    //     // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    //     TypeEnable := FormEditableField(FIELDNO(Type));
    //     "No.Enable" := FormEditableField(FIELDNO("No."));
    //     QuantityEnable := FormEditableField(FIELDNO(Quantity));
    //     "Unit Price (LCY)Enable" := FormEditableField(FIELDNO("Unit Price (LCY)"));
    //     "Line AmountEnable" := FormEditableField(FIELDNO("Line Amount"));
    //     // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    // end;

    // local procedure TriggerOnDeleteRecord(): Boolean;
    // var
    //     TempRec: Record "39" temporary;
    // begin
    //     // DITW16.00.00.37 DDR 20/07/2010 (moved trigger bugfix RTC collapse page)
    //     // cronus
    //     IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
    //         COMMIT;
    //     END;

    //     // <<DITW15.00.00.36 DDR 23/11/2009
    //     IF "Is Item Charge" AND "ItemCharge Incl. Price" THEN BEGIN
    //         DELETE(TRUE);
    //         TempRec := Rec;
    //         TempRec."Direct Unit Cost" := 0;
    //         TempRec."Line Amount" := 0;
    //         TempRec."Line Discount Amount" := 0;
    //         // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
    //         TempRec.CalcBackDirectCostItem();
    //         // >>DITW110.00.11 DDR NRQ#24875
    //         EXIT(FALSE);
    //     END;
    //     // >>DITW15.00.00.36 DDR
    //     EXIT(TRUE);
    // end;

    // procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
    // begin
    //     // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    //     DisabledRefreshLines := NewDisabledRefreshLines;
    // end;

    // local procedure TypeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 15/01/2008
    //     IF Type <> xRec.Type THEN
    //         CurrPage.UPDATE;
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure VariantCodeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     IF (Type = Type::Item) AND
    //        (xRec."Variant Code" <> "Variant Code")
    //     THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LocationCodeOnAfterValidate();
    // var
    //     UpdateIsDone: Boolean;
    // begin
    //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     IF (Type = Type::Item) AND
    //        NOT UpdateIsDone
    //     THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure QuantityOnAfterValidate();
    // var
    //     UpdateIsDone: Boolean;
    // begin
    //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     IF (Type = Type::Item) AND
    //        (Quantity <> xRec.Quantity) AND
    //        NOT UpdateIsDone
    //     THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure UnitofMeasureCodeOnAfterValida();
    // var
    //     UpdateIsDone: Boolean;
    // begin
    //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     IF (Type = Type::Item) AND
    //        NOT UpdateIsDone
    //     THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure DirectUnitCostOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     IF (Type = Type::Item) AND
    //        ("Direct Unit Cost" <> xRec."Direct Unit Cost")
    //     THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LineAmountOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     IF (Type = Type::Item) AND
    //        ("Line Amount" <> xRec."Line Amount")
    //     THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LineDiscount37OnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     IF (Type = Type::Item) AND
    //        ("Line Discount %" <> xRec."Line Discount %")
    //     THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LineDiscountAmountOnAfterValid();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     IF (Type = Type::Item) AND
    //        ("Line Discount Amount" <> xRec."Line Discount Amount")
    //     THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure QtytoReceiveOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     IF (Type = Type::Item) AND
    //        ("Qty. to Receive" <> xRec."Qty. to Receive")
    //     THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure FreeItemOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.35 DDR 25/06/2009
    //     IF (Type = Type::Item) AND
    //        (xRec."Free Item" <> "Free Item")
    //     THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.35 DDR
    // end;

    // local procedure AllowVATCalculationFreeOnAfter();
    // begin
    //     CurrPage.UPDATE(TRUE);
    // end;

    // local procedure FreeItemPostingTypeOnAfterVali();
    // begin
    //     // <<DITW15.00.00.35 DDR 25/06/2009
    //     IF Type = Type::Item THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.35 DDR
    // end;
    // BC Upgrade BHARDA11 << ----Drink-IT Function(_InsertExtendedCharges,InsertExtendedCharges,UpdateFields,TriggerOnDeleteRecord,SetDisableRefreshLines,TypeOnAfterValidate,VariantCodeOnAfterValidate,LocationCodeOnAfterValidate,QuantityOnAfterValidate,UnitofMeasureCodeOnAfterValida,DirectUnitCostOnAfterValidate,LineAmountOnAfterValidate,LineDiscount37OnAfterValidate,LineDiscountAmountOnAfterValid,QtytoReceiveOnAfterValidate,FreeItemOnAfterValidate,FreeItemPostingTypeOnAfterVali)

}

