pageextension 58000 pageextension50678 extends "Purchase Lines"
{
    // version NAVW110.0,DITW110.00.10,HEI.05

    //     DITW15.00.00.21 DDR 13/06/2008 Added Columns "Weight","Cubage"
    // DITW15.00.00.36 DDR 06/11/2009 issue 777 Added columns
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                 CEL 13/08/2010           Modification RTC buttons
    //                 DDR 18/08/2010 DIT717 #13 Added to keep open filters with expand-collapse (ShowAsTree in page)
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //                                         !!  Added IndentationColumnName property value = ActualExpansionStatusInt
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field Added after  "Amt. Rcd. Not Invoiced (LCY)" field
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 02/03/2015 DIT-770 #1191 Added fields "Responsiblity Center","Physical Location Group Code"
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Direct Unit Cost"
    // DITW18.00.07 AKH 10/05/2016 DIT-770 #1346 Added field "Delivery Time (sec.)"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.10 YHE 30/06/2017 NRQ#13598 Remove DIT filed "Buy-from Vendor Name"

    // HEI.01 PURGAP11 IBM LAZARE02 04.09.2017
    //  # New fields for SRM integration: SRM Contract Type, SRM Contract No., SRM Contract Line No., Valid From, Valid To, Item Category Code,
    //                                    Block Line Ordering, Delivery Finalized
    // Hei.02    CHG2096764 IBM. PANDES01  12.03.2021
    //  # Added code for Requesters ID.
    // HEI.03 CHG2155847 HB2821 IBM NANDIS01 26.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Added "Astro Unique ID" in this page
    // HEI.04 CHG2217938 HB3565 SRIVAS07 IBM 17.11.23 - Provide an overview of future commitment payments based on open released Purchase Orders
    //   # VendorName,"Due Date", "Estimated Pmt. Due Date" - fields added
    // HEI.05 CHG2240166 HB3563 IBM SRIVAS07 29.04.2024 # Development CD_StP_Concat Code Missing in Purchase Lines
    //   # New variable - ConcatCode - Text[20]
    //   # New Function - SetConcatCode()
    //   # Added code in OnAfterGetRecord trigger()
    // HEI.06 CHG2352814 PATELS08 14.05.2026 - Add column with Expected Physical delivery date (Imp) on PO general header and purchase lines tables.
    //   # Added Field "Exp Physical Del Date(Imp)"
    //***************************************************************************************************************************
    //BC UPRADE PATHAA02 04-11-25 (Source Table-PurchaseLine)-Done with gen interface setup dependency-T50034-Saikat
    //1. "Buy-from Vendor Name" field check with Yash
    //2. DIT fields and code commented
    //3. SRM Related fields found.
    //4. Astro "Unique ID" field found-commented
    //5. Dependency with Gen Interface setup-T50034-Saikat
    //HEI.01-Done, HEI.02-"Requesters ID" field added but code not found, HEI.03-Astro field commented, HEI.04-Fields and code on OnafterGetRecord added, HEI.05-ConcatCode field and code added.

    // BC UPGRADE PATELS08 >>
    // # Tag HEI.06 added to documentation.
    // # Added Field "Exp Physical Del Date(Imp)" in layout 
    // BC UPGRADE PATELS08 <<

    layout
    {

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the type of document that you are about to create.', FRA = 'Spécifie le type de document que vous allez créer.';

            //Unsupported feature: Change Editable on ""Document Type"(Control 2)". Please convert manually.

        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number.', FRA = 'Spécifie le numéro du document.';

            //Unsupported feature: Change Editable on ""Document No."(Control 4)". Please convert manually.

        }
        modify("Buy-from Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor who will delivers the items.', FRA = 'Spécifie le numéro du fournisseur qui livre les articles.';

            //Unsupported feature: Change Editable on ""Buy-from Vendor No."(Control 8)". Please convert manually.

        }
        modify("Line No.")
        {
            ToolTipML = ENU = 'Specifies the line''s number.', FRA = 'Spécifie le numéro de ligne.';

            //Unsupported feature: Change Editable on ""Line No."(Control 6)". Please convert manually.

        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the line type.', FRA = 'Spécifie le type de ligne.';

            //Unsupported feature: Change Editable on "Type(Control 10)". Please convert manually.

        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of a general ledger account, item, resource, additional cost, or fixed asset, depending on the contents of the Type field.', FRA = 'Spécifie le numéro d''un compte général, d''un article, d''une ressource, d''un coût supplémentaire ou d''une immobilisation, selon ce que vous avez sélectionné dans le champ Type.';

            //Unsupported feature: Change Editable on ""No."(Control 12)". Please convert manually.

        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a variant code for the item.', FRA = 'Spécifie un code variante pour l''article.';

            //Unsupported feature: Change Editable on ""Variant Code"(Control 34)". Please convert manually.

        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry, which is based on the contents of the Type and No. fields.', FRA = 'Spécifie une description de l''entrée qui est basée sur le contenu des champs Type et N°.';

            //Unsupported feature: Change Editable on "Description(Control 23)". Please convert manually.

        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code for the location where the items on the line will be located.', FRA = 'Spécifie le code du magasin où sont stockés les articles de la ligne.';

            //Unsupported feature: Change Editable on ""Location Code"(Control 36)". Please convert manually.

        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item that will be specified on the line.', FRA = 'Spécifie le nombre d''unités de l''article qui seront spécifiées sur la ligne.';

            //Unsupported feature: Change Editable on "Quantity(Control 31)". Please convert manually.

        }
        modify("Reserved Qty. (Base)")
        {
            ToolTipML = ENU = 'Specifies the value in the Reserved Quantity field, expressed in the base unit of measure.', FRA = 'Spécifie la valeur dans le champ Quantité réservée, exprimée en unité de base.';

            //Unsupported feature: Change Editable on ""Reserved Qty. (Base)"(Control 18)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code that is valid for the purchase line.', FRA = 'Spécifie le code unité valable pour la ligne achat.';

            //Unsupported feature: Change Editable on ""Unit of Measure Code"(Control 28)". Please convert manually.

        }
        modify("Direct Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the direct unit cost of the item on the line.', FRA = 'Spécifie le coût unitaire direct pour l''article sur la ligne.';

            //Unsupported feature: Change SourceExpr on ""Direct Unit Cost"(Control 44)". Please convert manually.


            //Unsupported feature: Change Name on ""Direct Unit Cost"(Control 44)". Please convert manually.


            //Unsupported feature: Change ImplicitType on ""Direct Unit Cost"(Control 44)". Please convert manually.


            //Unsupported feature: Change AutoFormatType on ""Direct Unit Cost"(Control 44)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Direct Unit Cost"(Control 44)". Please convert manually.

            CaptionClass = Rec.FIELDCAPTION("Direct Unit Cost");

            //Unsupported feature: Change Editable on ""Direct Unit Cost"(Control 44)". Please convert manually.

        }
        modify("Indirect Cost %")
        {
            ToolTipML = ENU = 'Specifies the item''s indirect cost percentage.', FRA = 'Spécifie le pourcentage de coût indirect de l''article.';

            //Unsupported feature: Change Editable on ""Indirect Cost %"(Control 46)". Please convert manually.

        }
        modify("Unit Cost (LCY)")
        {
            ToolTipML = ENU = 'Specifies the unit cost of the item on the line.', FRA = 'Spécifie le coût unitaire pour l''article sur la ligne.';

            //Unsupported feature: Change Editable on ""Unit Cost (LCY)"(Control 48)". Please convert manually.

        }
        modify("Unit Price (LCY)")
        {
            ToolTipML = ENU = 'Specifies the price for one unit of the item.', FRA = 'Spécifie le prix unitaire de l''article.';

            //Unsupported feature: Change Editable on ""Unit Price (LCY)"(Control 50)". Please convert manually.

        }
        modify("Line Amount")
        {
            ToolTipML = ENU = 'Specifies the net amount (before subtracting the invoice discount amount) that must be paid for the items on the line.', FRA = 'Spécifie le montant net (avant soustraction du montant remise facture) à payer pour les articles de la ligne.';

            //Unsupported feature: Change AutoFormatType on ""Line Amount"(Control 16)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Line Amount"(Control 16)". Please convert manually.


            //Unsupported feature: Change Editable on ""Line Amount"(Control 16)". Please convert manually.

        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'If you fill in this field and the Job Task No. field, then a job ledger entry will be posted together with the purchase order line.', FRA = 'Si vous renseignez ce champ et le champ N° tâche projet, alors une écriture comptable projet sera validée avec la ligne commande achat.';

            //Unsupported feature: Change Editable on ""Job No."(Control 64)". Please convert manually.

        }
        modify("Job Task No.")
        {
            ToolTipML = ENU = 'Specifies the number of the job task that corresponds to the purchase document (invoice or credit memo).', FRA = 'Spécifie le numéro de la tâche projet qui correspond au document achat (facture ou avoir).';
        }
        modify("Job Line Type")
        {
            ToolTipML = ENU = 'Specifies a Job Planning Line together with the posting of a job ledger entry.', FRA = 'Spécifie une ligne planning projet lors de la validation d''une écriture comptable projet.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the purchase.', FRA = 'Spécifie le code section analytique lié à l''achat.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 1 Code"(Control 40)". Please convert manually.

        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the purchase.', FRA = 'Spécifie le code section analytique lié à l''achat.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 2 Code"(Control 42)". Please convert manually.

        }

        //Unsupported feature: Change Editable on ""ShortcutDimCode[3]"(Control 300)". Please convert manually.


        //Unsupported feature: Change Editable on ""ShortcutDimCode[4]"(Control 302)". Please convert manually.


        //Unsupported feature: Change Visible on ""ShortcutDimCode[5]"(Control 304)". Please convert manually.


        //Unsupported feature: Change Editable on ""ShortcutDimCode[5]"(Control 304)". Please convert manually.


        //Unsupported feature: Change Editable on ""ShortcutDimCode[6]"(Control 306)". Please convert manually.


        //Unsupported feature: Change Editable on ""ShortcutDimCode[7]"(Control 308)". Please convert manually.


        //Unsupported feature: Change Editable on ""ShortcutDimCode[8]"(Control 310)". Please convert manually.

        modify("Expected Receipt Date")
        {
            ToolTipML = ENU = 'Specifies the date that you expect the items to be available in your warehouse.', FRA = 'Spécifie la date à laquelle les articles doivent être disponibles dans votre entrepôt.';
        }
        modify("Outstanding Quantity")
        {
            ToolTipML = ENU = 'Specifies how many units on the order line have not yet been received.', FRA = 'Spécifie le nombre d''unités de la ligne vente qui n''ont pas encore été reçues.';
        }
        modify("Outstanding Amount (LCY)")
        {
            ToolTipML = ENU = 'Specifies the amount for the items on the order that have not yet been received in LCY.', FRA = 'Spécifie le montant en devise société des articles de la commande qui restent à recevoir.';
        }
        modify("Amt. Rcd. Not Invoiced (LCY)")
        {
            ToolTipML = ENU = 'Specifies the amount for the ordered items that have been received but not yet invoiced in LCY.', FRA = 'Spécifie le montant en devise société des articles commandés qui ont été reçus mais pas encore facturés.';
        }
        addfirst(Control1)
        {
            //BC UPGRADE PATHAA02-DIT>>
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
            //         CurrPage.UPDATE(true);
            //         // >>DITW15.00.00.37 DDR
            //     end;
            // }
            //BC UPGRADE PATHAA02-DIT<<
        }
        // addafter("Buy-from Vendor No.")
        // {
        // field("Buy-from Vendor Name"; PurchHeader."Buy-from Vendor Name")
        // {
        //     Caption = 'Vendor Name';
        // }
        // }
        addafter(Description)
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Responsibility Center field.';
            }
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }//BC UPGRADE PATHAA02-DIT-F2014094
        }
        addafter("Location Code")
        {
            // field("Location Group Code"; Rec."Location Group Code")
            // {
            //     Editable = false;
            // }//BC UPGRADE PATHAA02-DIT-F2013696
        }
        addafter("Line Amount")
        {
            //BC UPGRADE PATHAA02-DIT>>
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
            //     QuickEntry = false;
            // }
            //BC UPGRADE PATHAA02-DIT<<
        }
        addafter("Outstanding Quantity")
        {
            //BC UPGRADE PATHAA02-DIT>>

            // field("Item DDeposit Group Code"; Rec."Item DDeposit Group Code")
            // {
            //     Editable = false;
            // } //PATHAA02-DIT-F2013610
            // field("GetTrackingItemNo()"; GetTrackingItemNo())
            // {
            //     CaptionML = ENU = 'Tracking Item No. (Item Charge)',
            //                 FRA = 'N° article traçable (Frais annexes)';
            //     DrillDownPageID = "Item List";
            //     Editable = false;
            //     LookupPageID = "Item List";
            //     TableRelation = IF ("Item Charge Type" = CONST(Tax)) Item WHERE("No." = FIELD("Tax Item No."))
            //     ELSE IF ("Item Charge Type" = CONST(Deposit)) Item WHERE("No." = FIELD("Empty Goods Item No."));

            //     trigger OnLookup(Text: Text): Boolean;
            //     begin
            //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
            //         Text := GetTrackingItemNo();
            //         LookupItemNo(Text);
            //         exit(false);
            //     end;
            // }
            // field("Item Charge Quantity per"; Rec."Item Charge Quantity per")
            // {
            //     Editable = false;
            //     Visible = false;
            // } //PATHAA02-DIT-F2013612
            // field("Item DTax Group Code"; Rec."Item DTax Group Code")
            // {
            //     Editable = false;
            // } //PATHAA02-DIT-F2013667
            // field("Company Tax Registration No."; Rec."Company Tax Registration No.")
            // {
            //     Editable = false;
            //     Visible = false;
            // }//PATHAA02-DIT-F2013726
            // field("Tariff No."; Rec."Tariff No.")
            // {
            //     Editable = false;
            // }//PATHAA02-DIT-F2013729
            // field("AAD No. Series"; Rec."AAD No. Series")
            // {
            //     Editable = false;
            //     Visible = false;
            // }//PATHAA02-DIT-2013727
            // field("AAD No."; Rec."AAD No.")
            // {
            //     Editable = false;
            // } //PATHAA02-DIT-2013728
            // field("Vendor DDisc. Group Code"; Rec."Vendor DDisc. Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // } //PATHAA02-DIT-F2013773
            // field("Item DDisc. Group Code"; Rec."Item DDisc. Group Code")
            // {
            //     Editable = false;
            // } //F2013610
            // field("Vendor DPromo. Group Code"; Rec."Vendor DPromo. Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }//F2013773
            // field("Item DPromo. Group Code"; Rec."Item DPromo. Group Code")
            // {
            //     Editable = false;
            // }F2013776
            // field("Free Item Posting Type"; Rec."Free Item Posting Type")
            // {
            //     Editable = false;
            //     Visible = false;
            // } //F2013825
            // field("Free Item"; Rec."Free Item")
            // {
            //     Editable = false;
            // }//F2013826
            // field("Free Calculation Type"; Rec."Free Calculation Type")
            // {
            //     Editable = false;
            //     Visible = false;
            // }//F2013827
            // field("Shipping Agent Code"; Rec."Shipping Agent Code")
            // {
            //     Editable = false;
            // }//F2014075
            // field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
            // {
            //     Editable = false;
            // }//F2014076
            // field(Distance; Rec.Distance)
            // {
            //     Editable = false;
            // } //F2014087
            // field(Weight; Rec.Weight)
            // {
            //     Editable = false;
            // } //F2014080
            // field(Cubage; Rec.Cubage)
            // {
            //     Editable = false;
            // } //F2014079
            // field("Delivery Time (sec.)"; Rec."Delivery Time (sec.)")
            // {
            // }//F2014089
            // field("Shipping Charge Per"; Rec."Shipping Charge Per")
            // {
            //     Editable = false;
            //     Visible = false;
            // }//F2014064

            //BC UPGRADE PATHAA02-DIT<<
        }
        addafter("Amt. Rcd. Not Invoiced (LCY)")
        {
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the gross weight of one unit of the item. In the purchase statistics window, the gross weight on the line is included in the total gross weight of all the lines for the particular purchase document.';
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the net weight of one unit of the item. In the purchase statistics window, the net weight on the line is included in the total net weight of all the lines for the particular purchase document.';
            }
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity (Base) field.';
            }
            field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the outstanding quantity expressed in the base units of measure.';
            }
            field("Outstanding Amount"; Rec."Outstanding Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Outstanding Amount field.';
            }
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the code of the currency of the amounts on the purchase line.';
            }
            // field("Unit Volume HL"; Rec."Unit Volume HL")
            // {
            // }//BC UPGRADE PATHAA02-DIT-F2013767
            field("Blanket Order No."; Rec."Blanket Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the document number of the blanket order from which this purchase line originates.';
            }
            field("Blanket Order Line No."; Rec."Blanket Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the line number of the blanket order line from which this purchase line originates.';
            }
            // field("Description 2"; Rec."Description 2")
            // {
            // }//BC UPGRADE PATHAA02-Already exists in base page
            field("SRM Contract Type"; Rec."SRM Contract Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SRM Contract Type field.';
            }
            field("SRM Contract No."; Rec."SRM Contract No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SRM Contract No. field.';
            }
            field("SRM Contract Line No."; Rec."SRM Contract Line No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SRM Contract Line No. field.';
            }
            field("SRM Order No."; Rec."SRM Order No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SRM Order No. field.';
            }
            field("Valid From"; Rec."Valid From FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Valid From field.';
            }
            field("Valid To"; Rec."Valid To FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Valid To field.';
            }
            field("Block Line Ordering"; Rec."Block Line Ordering FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Block Line Ordering field.';
            }
            field("Delivery Finalized"; Rec."Delivery Finalized FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Delivery Finalized field.';
            }
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Category Code field.';
            }
            field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Qty. Rcd. Not Invoiced field.';
            }
            field("Quantity Received"; Rec."Quantity Received")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies how many units of the item on the line have been posted as received.';
            }
            field("Quantity Invoiced"; Rec."Quantity Invoiced")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies how many units of the item on the line have been posted as invoiced.';
            }
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the vendor''s or customer''s trade type to link transactions made for this business partner with the appropriate general ledger account according to the general posting setup.';
            }
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
            }
            field("Due Date"; Rec."Due Date FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Due Date field.';
            }
            field("Estimated Pmt. Due Date"; Rec."Estimated Pmt. Due Date FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Estimated Payment Due Date field.';
            }
            field("Requesters ID"; Rec."Requesters ID FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requesters ID field.';
            }
            // field("Astro Unique ID";Rec."Astro Unique ID")
            // {
            // } //BC UPGRADE PATHAA02-Astro
            field(ConcatCode; ConcatCode)
            {
                Caption = 'Concat Code';
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Concat Code field.';
            }
        }
        //  BC UPGRADE PATELS08 >> # HEI.06
        addbefore("Expected Receipt Date")
        {
            field("Exp Physical Del Date(Imp)"; Rec."Exp Physical Del Date(Imp) FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the expected physical delivery date of the item.';
                Description = 'HEI.06';
            }
        }
        //  BC UPGRADE PATELS08 << # HEI.06
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify("Show Document")
        {
            CaptionML = ENU = 'Show Document', FRA = 'Afficher document';
            ToolTipML = ENU = 'Open the document that the selected line exists on.', FRA = 'Ouvrez le document sur lequel la ligne sélectionnée existe.';
        }
        modify("Reservation Entries")
        {
            CaptionML = ENU = 'Reservation Entries', FRA = 'Écritures réservation';
        }
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = '&Lignes traçabilité';
        }
        addfirst("&Line")
        {
            //BC UPGRADE PATHAA02-DIT>>
            // action("+ Expand")
            // {
            //     CaptionML = ENU = '+ Expand',
            //                 FRA = '+ Développer';
            //     Enabled = (NOT ExpandLines);
            //     Image = ViewDetails;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
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
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Visible = ExpandLines OR ShowButtonsCE;

            //     trigger OnAction();
            //     begin
            //         // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
            //         ExpandLines := GETFILTER("Attached to Line No.") <> '';
            //         CurrPage.UPDATE(true);
            //         // >>DITW17.10.03 DDR DIT-770 #541
            //     end;
            // }
            //BC UPGRADE PATHAA02-DIT<<
        }
    }

    var
        PurchHeader: Record "Purchase Header"; //BC UPGRADE PATHAA02
        TempRecOpenFilters: Record "Purchase Line" temporary;
        IsOpenPage: Boolean;

        DirectUnitCostText: Text[1024];
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Direct Unit Cost', FRA = 'Total coût unitaire directe';

        ExpandLines: Boolean;

        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        ConcatCode: Text[20];


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:

    //BC UPGRADE PATHAA02>>
    trigger OnAfterGetRecord();
    begin

        //BC UPGRADE PATHAA02-DIT>>
        // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        // IndentLine := IndentRecordDIT(ExpandLines);
        // // >>DITW17.10.03 DDR DIT-770 #541
        //BC UPGRADE PATHAA02-DIT<<
        //ShowShortcutDimCode(ShortcutDimCode);//BC UPGRADE PATHAA02-Available in base page

        //HEI.04>>
        CLEAR(PurchHeader);
        if PurchHeader.GET(Rec."Document Type", Rec."Document No.") then
            //HEI.04<<
            SetConcatCode();//HEI.05                          
    end;
    //BC UPGRADE PATHAA02<<


    //Unsupported feature: CodeInsertion on "OnFindRecord". Please convert manually.

    //trigger OnFindRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW16.00.00.37 DIT-715 #1 - DDR DIT717 #13
    if IsOpenPage then begin
      COPY(TempRecOpenFilters);
      IsOpenPage := false;
    end;
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //EXIT(FIND(Which));
    exit(FindRecordDIT(Which,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    // >>DITW16.00.00.37 DIT-715 #13
    */
    //end;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CLEAR(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    IndentLine := 0;
    if not ISEMPTY then
      InitLineNo(ExpandLines,BelowxRec);
    // >>DITW17.10.03 DDR DIT-770 #541
    CLEAR(ShortcutDimCode);
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
    // <<DITW16.00.00.37 DDR DIT717 #13
    TempRecOpenFilters.COPY(Rec);
    IsOpenPage := true;
    // >>DITW16.00.00.37 DDR DIT717 #13
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    ExpandLines := GETFILTER("Attached to Line No.") <> '';
    ShowButtonsCE := IsShowButtonsCEDIT();
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;

    local procedure SetConcatCode();
    var
        DimensionSetEntry: Record "Dimension Set Entry";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
    begin
        //HEI.05>>
        if Rec."Dimension Set ID" <> 0 then begin
            GeneralInterfaceSetup.GET();

            DimensionSetEntry.RESET();
            DimensionSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
            DimensionSetEntry.SETRANGE("Dimension Code", GeneralInterfaceSetup."Project Dimension Code");
            if DimensionSetEntry.FINDFIRST() then
                ConcatCode := DimensionSetEntry."Dimension Value Code"
            else
                ConcatCode := '';
        end else
            ConcatCode := '';
        //HEI.05<<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

