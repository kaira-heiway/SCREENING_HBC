pageextension 53005 PostedSalesShptSubformExt extends "Posted Sales Shpt. Subform"
{
    // version NAVW110.0,DITW110.00.09,HEI.04
    /* 
    HEI.01 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
      # New field "RPM Damage / Loss" added
      # New field "Transporter RPM Damage / Loss" added
    HEI.02 CHG2024918 IBM POENAB02 16.09.2019 La RËÇÜunion_France Fiscal Year Closing
      # New function InvoiceLines
      # Added actiongroup Shipment
      # Added action Invoices in actiongroup Shipment
      # Code added in OnInit
    DITW113.00.15 DDR 04/10/2019 NRQ#10495 Rename Loyalty 'Cost' -> 'Amount' (all fields)
    HEI.03 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
      # New Field added: "CAD Amount"
    HEI.04 CHG2178940 IBM COSTES04  16.01.2023 # Add Required Freshness field on Customer Card
      # Add new field Freshness Date (min)
     */
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea Property in Fields and actions.
    // 2. Add Editable , InsertAllowed and DeleteAllowed property in Page.
    // 3. There is a code with tag HEI.2 in onInit Trigger . That code was originally written in the OnInit trigger. Since the OnInit trigger is not available in a page extension, we moved this code to the OnOpenPage trigger, as this trigger executes immediately after the initialization trigger.
    // 4. Remove Drink-IT Fields and related code.
    // 5. Remove Drink-IT Functions.
    // 6 REmove Drink-IT Related Customization.
    // 7. "Shipment Invoiced"  table not found in business central so we remove related code
    // 8. Comment French Localization related code.
    // 9. UnComment CAD related code.
    // BC Upgrade BHARDA11 <<
    Editable = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change Editable on "Type(Control 2)". Please convert manually.

        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the record.', FRA = 'Spécifie le numéro de l''enregistrement.';

            //Unsupported feature: Change Editable on ""No."(Control 4)". Please convert manually.

        }
        // BC Upgrade BHARDA11 >> ----Not Found
        // modify("Cross-Reference No.")
        // {
        //     ToolTipML = ENU = 'Specifies the cross-referenced item number. If you enter a cross reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the cross-reference number on a sales or purchase document.', FRA = 'Spécifie le numéro d''article à référence externe. Si vous saisissez une référence externe entre votre numéro d''article et celui de votre fournisseur ou client, ce numéro remplace le numéro d''article standard lorsque vous saisissez le numéro de référence externe sur un document vente ou achat.';

        //     //Unsupported feature: Change Editable on ""Cross-Reference No."(Control 24)". Please convert manually.

        // }
        // BC Upgrade BHARDA11 << ----Not Found

        //Unsupported feature: Change Editable on ""Variant Code"(Control 14)". Please convert manually.

        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the record.', FRA = 'Spécifie la description de l''enregistrement.';

            //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.

        }

        //Unsupported feature: Change Editable on ""Return Reason Code"(Control 20)". Please convert manually.


        //Unsupported feature: Change Editable on ""Location Code"(Control 46)". Please convert manually.


        //Unsupported feature: Change Name on ""Bin Code"(Control 54)". Please convert manually.


        //Unsupported feature: Change Editable on ""Bin Code"(Control 54)". Please convert manually.

        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item specified on the line.', FRA = 'Spécifie le nombre d''unités de l''article sur la ligne spécifiée.';

            //Unsupported feature: Change BlankZero on "Quantity(Control 8)". Please convert manually.


            //Unsupported feature: Change Editable on "Quantity(Control 8)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code for the item.', FRA = 'Spécifie le code unité de l''article.';

            //Unsupported feature: Change Editable on ""Unit of Measure Code"(Control 22)". Please convert manually.

        }

        //Unsupported feature: Change Editable on ""Unit of Measure"(Control 10)". Please convert manually.

        modify("Quantity Invoiced")
        {
            ToolTipML = ENU = 'Specifies how many units of the item on the line have already been invoiced.', FRA = 'Spécifie le nombre d''unités de la ligne qui ont déjà été facturées.';

            //Unsupported feature: Change BlankZero on ""Quantity Invoiced"(Control 12)". Please convert manually.


            //Unsupported feature: Change Editable on ""Quantity Invoiced"(Control 12)". Please convert manually.

        }
        modify("Qty. Shipped Not Invoiced")
        {
            ToolTipML = ENU = 'Specifies how many units of the item on the line have been shipped and not yet invoiced.', FRA = 'Spécifie le nombre d''unités de l''article sur la ligne qui ont été expédiées, mais pas encore facturées.';
        }
        modify("Requested Delivery Date")
        {
            ToolTipML = ENU = 'Specifies the date that the customer has asked for the order to be delivered.', FRA = 'Spécifie la date à laquelle le client a demandé à être livré.';

            //Unsupported feature: Change Editable on ""Requested Delivery Date"(Control 18)". Please convert manually.

        }

        //Unsupported feature: Change Editable on ""Promised Delivery Date"(Control 28)". Please convert manually.


        //Unsupported feature: Change Editable on ""Planned Delivery Date"(Control 36)". Please convert manually.


        //Unsupported feature: Change Editable on ""Planned Shipment Date"(Control 40)". Please convert manually.

        modify("Shipment Date")
        {
            ToolTipML = ENU = 'Specifies the date when the sales shipment was posted.', FRA = 'Spécifie la date à laquelle l''expédition vente a été validée.';

            //Unsupported feature: Change Editable on ""Shipment Date"(Control 16)". Please convert manually.

        }

        //Unsupported feature: Change Editable on ""Shipping Time"(Control 32)". Please convert manually.


        //Unsupported feature: Change Editable on ""Job No."(Control 38)". Please convert manually.


        //Unsupported feature: Change Editable on ""Outbound Whse. Handling Time"(Control 34)". Please convert manually.


        //Unsupported feature: Change Editable on ""Appl.-to Item Entry"(Control 42)". Please convert manually.

        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 1 Code"(Control 50)". Please convert manually.

        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 2 Code"(Control 48)". Please convert manually.

        }
        modify(Correction)
        {
            ToolTipML = ENU = 'Specifies that this sales shipment line has been posted as a corrective entry.', FRA = 'Indique que cette ligne expédition vente a été validée en tant qu''écriture de correction.';
        }

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Type(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Type(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Cross-Reference No."(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Cross-Reference No."(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Return Reason Code"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Return Reason Code"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 46)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 46)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bin Code"(Control 54)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Quantity(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Quantity(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Quantity Invoiced"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Quantity Invoiced"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Qty. Shipped Not Invoiced"(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Qty. Shipped Not Invoiced"(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Requested Delivery Date"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Requested Delivery Date"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Promised Delivery Date"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Promised Delivery Date"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Planned Delivery Date"(Control 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Planned Delivery Date"(Control 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Planned Shipment Date"(Control 40)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Planned Shipment Date"(Control 40)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Time"(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Time"(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Job No."(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Job No."(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Outbound Whse. Handling Time"(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Outbound Whse. Handling Time"(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Appl.-to Item Entry"(Control 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Appl.-to Item Entry"(Control 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 50)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 50)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 48)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 48)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Correction(Control 52)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Correction(Control 52)". Please convert manually.

        addfirst(Control1)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT fields("Has Item Charge",Collapse)
            // field("Has Item Charge"; Rec."Has Item Charge")
            // {

            //     BlankZero = true;
            // }
            // field(Collapse; Rec.Collapse)
            // {
            //     Visible = false;
            //     trigger OnValidate();
            //     begin
            //         // <<DITW15.00.00.37 DDR 19/01/2010
            //         CurrPage.UPDATE(TRUE);
            //         // >>DITW15.00.00.37 DDR
            //     end;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT fields("Has Item Charge",Collapse)
            // field("Line No."; Rec."Line No.")
            // {
            //     Visible = false;
            // }
        }
        addafter("Variant Code")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
            // field(TrackingItemNo; GetTrackingItemNo())
            // {
            //     CaptionML = ENU = 'Tracking Item No. (Item Charge)',
            //                 FRA = 'N° article traçable (Frais annexes)';
            //     DrillDownPageID = "Item List";
            //     Editable = false;
            //     LookupPageID = "Item List";
            //     TableRelation = IF (Item Charge Type=CONST(Tax)) Item WHERE (No.=FIELD(Tax Item No.))
            //                     ELSE IF (Item Charge Type=CONST(Deposit)) Item WHERE (No.=FIELD(Empty Goods Item No.));
            //                                                                                   Visible = false;

            //     trigger OnLookup(var Text: Text): Boolean;
            //     begin
            //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
            //         Text := GetTrackingItemNo();
            //         LookupItemNo(Text);
            //         EXIT(FALSE);
            //     end;
            // }
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
        }
        addafter(Description)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
            // field("Description 2"; Rec."Description 2")
            // {
            //     Description = 'DIT-715 #393';
            //     Editable = false;
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Customization
        }
        addafter(Quantity)
        {
            // BC Upgrade BHARDA11 >>
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                ApplicationArea = All;
                Visible = EnableCAD;
            }
            // BC Upgrade BHARDA11 <<

        }
        addafter("Unit of Measure")
        {
            // BC Upgrade BHARDA11 >>  ----Drink-IT Fields and code(Unit Price, Line Amount, RTCTotalUnit, RTCTotalLine)
            // field("Unit Price"; Rec."Unit Price")
            // {
            //     AutoFormatExpression = GetTotalingAutoFormatExpr(2, FIELDNO("Unit Price"), FALSE);
            //     AutoFormatType = 2014410;
            //     BlankZero = true;
            //     Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Line Amount"; Rec."Line Amount")
            // {
            //     AutoFormatExpression = GetTotalingAutoFormatExpr(1, FIELDNO("Line Amount"), TRUE);
            //     AutoFormatType = 2014410;
            //     BlankZero = true;
            //     Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
            //     Editable = false;
            //     Visible = false;
            // }
            // field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Unit Price"), TRUE))
            // {
            //     AutoFormatExpression = "Currency Code";
            //     AutoFormatType = 2;
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassVar(PageText2014411);
            //     CaptionML = ENU = 'Total Unit Price',
            //                 FRA = 'Total prix unitaire';
            //     Description = 'DITW17.10.05 DIT-770 #988';
            //     Editable = false;
            //     QuickEntry = false;
            //     Visible = false;
            // }
            // field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), TRUE))
            // {
            //     AutoFormatExpression = GetCurrencyCode;
            //     AutoFormatType = 1;
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassVar(PageText2014410);
            //     CaptionML = ENU = 'Total Line Amount',
            //                 FRA = 'Montant total ligne';
            //     Description = 'DITW17.10.02B DIT-770 #541';
            //     Editable = false;
            //     QuickEntry = false;
            // }
            // BC Upgrade BHARDA11 <<  ----Drink-IT Fields and code(Unit Price, Line Amount, RTCTotalUnit, RTCTotalLine)

        }
        addafter("Shipping Time")
        {
            field("Freshness Date (min)"; Rec."Freshness Date (min) FND")
            {
                ApplicationArea = All;
            }
        }
        addafter("Appl.-to Item Entry")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields(Weight, Cubage, Distance, "Customer DTax Group Code", "Item DTax Group Code", "AAD No. Series", "AAD No.", "ARC No. Mandatory", "Free Item", "Free Item Posting Type", "Gen. Prod. Posting Free Group", "LRN No. Series", "LRN No.", "ARC No.", "SAD No.", "Packaging Type Code", "No. of Packages", "Commercial Seal ID", "Cancellation Reason Type", "Cancellation Reason Comment", "Applies-to AAD Trck. Entry No.")
            // field(Weight; Weight)
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
            // field("Customer DTax Group Code"; Rec."Customer DTax Group Code")
            // {
            //     Editable = false;
            //     QuickEntry = false;
            //     Visible = false;
            // }
            // field("Item DTax Group Code"; Rec."Item DTax Group Code")
            // {
            //     Editable = false;
            //     QuickEntry = false;
            //     Visible = false;
            // }
            // field("AAD No. Series"; Rec."AAD No. Series")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("AAD No."; Rec."AAD No.")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ARC No. Mandatory"; Rec."ARC No. Mandatory")
            // {
            //     Editable = false;
            //     QuickEntry = false;
            //     Visible = false;
            // }
            // field("Free Item"; Rec."Free Item")
            // {
            //     Editable = false;
            // }
            // field("Free Item Posting Type"; Rec."Free Item Posting Type")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Gen. Prod. Posting Free Group"; Rec."Gen. Prod. Posting Free Group")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("LRN No. Series"; Rec."LRN No. Series")
            // {
            //     Description = 'DITW15.00.00.38 #1217';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("LRN No."; Rec."LRN No.")
            // {
            //     Description = 'DITW15.00.00.38 #1217';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ARC No."; Rec."ARC No.")
            // {
            //     Description = 'DITW15.00.00.38 #1217';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("SAD No."; Rec."SAD No.")
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
            //         // <<DITW110.00.09 DDR 28/03/2017 NRQ#9647
            //         CurrPage.SAVERECORD;
            //         COMMIT;
            //         CancellationReasonCommenOnPush;
            //         CurrPage.UPDATE(FALSE);
            //         // >>DITW110.00.09 DDR NRQ#9647
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
            // BC Upgrade BHARDA11 << ----Drink-IT Fields(Weight, Cubage, Distance, "Customer DTax Group Code", "Item DTax Group Code", "AAD No. Series", "AAD No.", "ARC No. Mandatory", "Free Item", "Free Item Posting Type", "Gen. Prod. Posting Free Group", "LRN No. Series", "LRN No.", "ARC No.", "SAD No.", "Packaging Type Code", "No. of Packages", "Commercial Seal ID", "Cancellation Reason Type", "Cancellation Reason Comment", "Applies-to AAD Trck. Entry No.")

        }
        addafter(Correction)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Loyalty Point Type", "Loyalty Points Qty. (Base)", "Loyalty Unit Point", "Loyalty Amount Type", "Loyalty Unit Amount", "Loyalty Unit Amount (LCY)", "Loyalty Amount", "Loyalty Amount (LCY)", "Loyalty Convert to Free Item")
            // field("Loyalty Point Type"; Rec."Loyalty Point Type")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Points Qty. (Base)"; Rec."Loyalty Points Qty. (Base)")
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
            // field("Loyalty Amount Type"; Rec."Loyalty Amount Type")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Unit Amount"; Rec."Loyalty Unit Amount")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Visible = false;
            // }
            // field("Loyalty Unit Amount (LCY)"; Rec."Loyalty Unit Amount (LCY)")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Amount"; Rec."Loyalty Amount")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Amount (LCY)"; Rec."Loyalty Amount (LCY)")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Convert to Free Item"; Rec."Loyalty Convert to Free Item")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Editable = false;
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Loyalty Point Type", "Loyalty Points Qty. (Base)", "Loyalty Unit Point", "Loyalty Amount Type", "Loyalty Unit Amount", "Loyalty Unit Amount (LCY)", "Loyalty Amount", "Loyalty Amount (LCY)", "Loyalty Convert to Free Item")
            field("Item Type"; Rec."Item Type FND")
            {
                ApplicationArea = All;
            }
            field("RPM Solution"; Rec."RPM Solution FND")
            {
                ApplicationArea = All;
            }
            field("RPM Type"; Rec."RPM Type FND")
            {
                ApplicationArea = All;
            }
            field("RPM Damage / Loss"; Rec."RPM Damage / Loss FND")
            {
                ApplicationArea = All;
            }
            field("Transporter RPM Damage / Loss"; Rec."Transport RPM Damage/Loss FND")
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
        modify("Order Tra&cking")
        {
            CaptionML = ENU = 'Order Tra&cking', FRA = '&Chaînage';
        }
        modify(UndoShipment)
        {
            CaptionML = ENU = '&Undo Shipment', FRA = '&Annuler expédition';
            ToolTipML = ENU = 'Withdraw the line from the shipment. This is useful for making corrections, because the line is not deleted. You can make changes and post it again.', FRA = 'Prélevez la ligne de l''expédition. Ceci est utile pour effectuer des corrections, car la ligne n''est pas supprimée. Vous pouvez effectuer des modifications et la valider à nouveau.';
        }
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {

            //Unsupported feature: Change AccessByPermission on "Dimensions(Action 1903100004)". Please convert manually.

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
        modify("Assemble-to-Order")
        {

            //Unsupported feature: Change AccessByPermission on ""Assemble-to-Order"(Action 3)". Please convert manually.

            CaptionML = ENU = 'Assemble-to-Order', FRA = 'Assemblage à la commande';
        }
        modify(ItemInvoiceLines)
        {
            CaptionML = ENU = 'Item Invoice &Lines', FRA = '&Lignes facture article';
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""F&unctions"(Action 1906587504)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Order Tra&cking"(Action 1903098504)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Line"(Action 1907935204)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Assemble-to-Order"(Action 3)". Please convert manually.
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
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Customization
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
        //                 //This functionality was copied from page #130. Unsupported part was commented. Please check it.
        //                 /*CurrPage.SalesShipmLines.FORM.*/
        //                 _OpenEDIDocument();
        //                 // >>DITW16.00.00.43 DDR DIT-715 #720

        //             end;
        //         }
        //     }
        // }
        // addafter(Comments)
        // {
        //     action("Cancellation Reason Comments")
        //     {
        //         CaptionML = ENU = 'Cancellation Reason Comments',
        //                     FRA = 'Commentaires raison d''annulation';

        //         trigger OnAction();
        //         begin
        //             // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
        //             //This functionality was copied from page #130. Unsupported part was commented. Please check it.
        //             /*CurrPage.SalesShipmLines.PAGE.*/
        //             _ShowLineCancelReasonCmts;

        //         end;
        //     }
        //     action("Service Items")
        //     {
        //         CaptionML = ENU = 'Service Items',
        //                     FRA = 'Articles de service';

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.35 DDR 04/09/2009
        //             //This functionality was copied from page #130. Unsupported part was commented. Please check it.
        //             /*CurrPage.SalesShipmLines.PAGE.*/
        //             _ShowItemServices;

        //         end;
        //     }
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Customization
        // addafter("&Line")
        // {
        //     group("&Shipment")
        //     {
        //         CaptionML = ENU = '&Shipment',
        //                     FRA = 'E&xpédition';
        //         Enabled = FRLocAction;
        //         Image = Shipment;
        //         Visible = FRLocAction;
        //         action(Invoices)  // BC FR Upgrade KAIRAR01
        //         {
        //             ApplicationArea = All;
        //             CaptionML = ENU = 'Invoices',
        //                         FRA = 'Factures';
        //             Enabled = FRLocAction;
        //             Image = Invoice;
        //             Visible = FRLocAction;

        //             trigger OnAction();
        //             begin
        //                 //HEI.02>>
        //                 InvoiceLines();
        //                 //HEI.02<<
        //             end;
        //         }
        //     }
        // }
    }


    //Unsupported feature: PropertyModification on "ShowTracking(PROCEDURE 1).ItemLedgEntry(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShowTracking : "Item Ledger Entry";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShowTracking : 32;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ShowTracking(PROCEDURE 1).TempItemLedgEntry(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShowTracking : "Item Ledger Entry";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShowTracking : 32;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ShowTracking(PROCEDURE 1).TrackingForm(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShowTracking : "Order Tracking";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShowTracking : 99000822;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "UndoShipmentPosting(PROCEDURE 2).SalesShptLine(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //UndoShipmentPosting : "Sales Shipment Line";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UndoShipmentPosting : 111;
    //Variable type has not been exported.

    var
        CompanyInfo: Record "Company Information";

        FRLocAction: Boolean;
        EnableCAD: Boolean;
        GeneralLedgerSetup: Record "General Ledger Setup";


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    IndentLine := IndentRecordDIT(ExpandLines);
    // >>DITW17.10.03 DDR DIT-770 #541
    // <<DITW15.00.00.01 DDR 27/12/2007 - DITW15.00.00.38 DDR 16/07/2010 #1194
    // <<DITW15.00.00.38 DDR 12/10/2010 #1217
    "Packaging Type CodeEditable" := (NOT Correction) AND ("ARC No." = '');
    "No. of PackagesEditable" := (NOT Correction) AND ("ARC No." = '');
    "Commercial Seal IDEditable" := (NOT Correction) AND ("ARC No." = '');
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

    trigger OnOpenPage()
    begin
        // BC Upgrade BHARDA11 >> ---This code was originally written in the OnInit trigger. Since the OnInit trigger is not available in a page extension, we moved this code to the OnOpenPage trigger, as this trigger executes immediately after the initialization trigger.
        //HEI.02>>
        FRLocAction := false;
        // BC Upgrade BHARAD11 >> ---- French Localization
        // CompanyInfo.GET();
        // IF CompanyInfo."Enable French Localization" then
        //     FRLocAction := true;
        // BC Upgrade BHARAD11 << ---- French Localization
        //HEI.02<<
        // BC Upgrade BHARDA11 << ---This code was originally written in the OnInit trigger. Since the OnInit trigger is not available in a page extension, we moved this code to the OnOpenPage trigger, as this trigger executes immediately after the initialization trigger.

        // BC Upgrade BHARDA11 >> 
        //HEI.03>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        // //HEI.03<<
        // BC Upgrade BHARDA11 <<

    end;
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    ExpandLines := FALSE;
    ShowButtonsCE := IsShowButtonsCEDIT();
    // >>DITW17.10.03 DDR DIT-770 #541

    //HEI.03>>
    GeneralLedgerSetup.GET;
    EnableCAD := GeneralLedgerSetup."Enable CAD";
    //HEI.03<<
    */
    //end;


    //Unsupported feature: CodeModification on "ShowTracking(PROCEDURE 1)". Please convert manually.

    //procedure ShowTracking();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD(Type,Type::Item);
    if "Item Shpt. Entry No." <> 0 then begin
      ItemLedgEntry.GET("Item Shpt. Entry No.");
      TrackingForm.SetItemLedgEntry(ItemLedgEntry);
    end else
      TrackingForm.SetMultipleItemLedgEntries(TempItemLedgEntry,
        DATABASE::"Sales Shipment Line",0,"Document No.",'',0,"Line No.");

    TrackingForm.RUNMODAL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TESTFIELD(Type,Type::Item);
    IF "Item Shpt. Entry No." <> 0 THEN BEGIN
      ItemLedgEntry.GET("Item Shpt. Entry No.");
      TrackingForm.SetItemLedgEntry(ItemLedgEntry);
    END ELSE
    #6..9
    */
    //end;
    // BC Upgrade BHARDA11 >> ----Drink-IT Functions(_ShowItemServices, ShowItemServices, _ShowLineCancelReasonCmts, ShowLineCancelReasonCmts, SetDisableRefreshLines, ShowSSCCTrackingLines, _OpenEDIDocument, OpenEDIDocument, CancellationReasonCommenOnPush)
    // procedure _ShowItemServices();
    // begin
    //     // <<DITW15.00.00.35 DDR 04/09/2009
    //     Rec.ShowItemServices;
    // end;

    // procedure ShowItemServices();
    // begin
    //     // <<DITW15.00.00.35 DDR 04/09/2009
    //     Rec.ShowItemServices;
    // end;

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

    // procedure ShowSSCCTrackingLines(ShowAll: Boolean);
    // begin
    //     // <<DITW16.00.00.40 DDR 19/03/2012 DIT-715 #275
    //     Rec.ShowSSCCTrackingLines(ShowAll);
    // end;

    // procedure _OpenEDIDocument();
    // var
    //     EmcsEdiMgt: Codeunit "2014261";
    // begin
    //     // <<DITW16.00.00.43 DDR 23/08/2013 DIT-715 #720
    //     EmcsEdiMgt.OpenEDIOutDocFile(DATABASE::"Sales Shipment Line", 0, "Document No.", "LRN No.", "ARC No.");
    // end;

    // procedure OpenEDIDocument();
    // var
    //     EmcsEdiMgt: Codeunit "2014261";
    // begin
    //     // <<DITW16.00.00.43 DDR 23/08/2013 DIT-715 #720
    //     EmcsEdiMgt.OpenEDIOutDocFile(DATABASE::"Sales Shipment Line", 0, "Document No.", "LRN No.", "ARC No.");
    // end;

    // local procedure CancellationReasonCommenOnPush();
    // begin
    //     // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
    //     ShowLineCancelReasonCmts();
    //     // >>DITW16.00.00.40 DDR DIT-715 #187
    // end;

    // BC Upgrade BHARDA11 >> ----Drink-IT Functions(_ShowItemServices, ShowItemServices, _ShowLineCancelReasonCmts, ShowLineCancelReasonCmts, SetDisableRefreshLines, ShowSSCCTrackingLines, _OpenEDIDocument, OpenEDIDocument, CancellationReasonCommenOnPush)

    local procedure InvoiceLines();
    var
    // ShipmentInvoiced: Record "Shipment Invoiced"; // BC Upgrade BHARDA11 ----Table not found in Business central
    begin
        //HEI.02>>
        // BC Upgrade BHARDA11 >>----Table not found in Business central
        // CompanyInfo.GET;
        // IF CompanyInfo."Enable French Localization" THEN BEGIN
        //     ShipmentInvoiced.RESET;
        //     ShipmentInvoiced.SETCURRENTKEY("Shipment No.", "Shipment Line No.");
        //     ShipmentInvoiced.SETRANGE("Shipment No.", "Document No.");
        //     ShipmentInvoiced.SETRANGE("Shipment Line No.", "Line No.");
        //     PAGE.RUNMODAL(PAGE::"Invoices bound by Shipment", ShipmentInvoiced);
        // END;
        // BC Upgrade BHARDA11 <<----Table not found in Business central
        //HEI.02<<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

