page 52002 "BRC Bottle Recycle Subform"
{
    // BC Upgrade Kamnay01 Original(Heilite) page id 50240

    // version HEI.01

    // DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackDirectCostItem()
    // NRQ175506 NLAB 03/11/2021 Added DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix (Correctice Change no - CHG2102694)
    // 
    // HEI.01 HLSRM02 IBM LAZARE02 07.08.2017
    //   #New fields for SRM integration: Cancelled, SRM Order No., SRM Order Line No.
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //   # New field for MDM integration: "WHT Absorb Base"
    // HEI.03 Defect #969 IBM NASTAA02 17.11.2017 # Link on Blanket Order on PO level
    //   # Made "Blanket Order No." and "Blanket Order Line No." non-editable
    //   # LAZARE02: Make "Blanket Order Line No." editable at customer's request
    // HEI.04 HLSRM03 IBM LAZARE02 07.12.2017
    //   # New action Get Blanket Order Price
    //   # New fields "Outstanding Qty.", "Qty. Rcd. Not Invoiced", "Amt. Rcd. Not Invoiced"
    // 
    // HEI.05 Defect#818 14/12/2017 IBM.CHAUHB01 Added fields "Machine Reference Number"
    // 
    // HEI.06 Defect#1867 IBM LAZARE02 07.08.2017
    //   # Make field "Line Amount" not editable
    // 
    // HEI.07 RTRGAP071 IBM POSTOI01 24.04.2018
    //   # show fields "Use Duplication List" , "Depreciatiuon Book Code"
    // HEI.08 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Field added: "TIN No."
    // 
    // HEI.09 FDD-BA-PURGAP03- Bottle Recycling Centre - V2.6 IBM NAIKH01 16.10.2018
    //   # Created a new Page Copy of Page 54 - Purchase Order Subform
    //********************************************************************************************************************************
    //BC UPGRADE PATHAA02 31.10.25
    //1. SRM and Maximo related fields found
    //2. Field5705-Cross-Reference No. from Purchase Line table is deprecated in BC- Commented the field
    //3. ApplicationAreaSetup.IsFoundationEnabled, Function not found in NAV but not in BC-->Code commented


    // BC Upgrade PATELS08 >>
    // # Declared a global variablie 'PurchAvailabilityMgt'.
    // # 'ShowItemAvailFromPurchLine' and ByEvent(), ByPeriod(), ByVariant(), ByLocation(), ByBOM() is marked for removal, replaced with 'ShowItemAvailabilityFromPurchLine' and enum "Item Availability Type" repectively. Replacedment done in Actions : Event, Period, Variant, Location, BOM Level.
    // # Blocked Global Variable 'ItemAvailFormsMgt' Replaced with 'PurchAvailabilityMgt'
    // # 'SetPurchLine' is marked for removal, replaced with SetVariantRec in ShowTracking() procedure.
    // BC Upgrade PATELS08 <<


    AutoSplitKey = true;
    CaptionML = ENU = 'Lines',
                ESP = 'Líneas',
                FRA = 'Lignes';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                // field("Has Item Charge"; Rec."Has Item Charge")
                // {
                //     BlankZero = true;
                //     QuickEntry = false;
                // } //BC UPGRADE PATHAA02-DIT F2014500

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
                // }//BC UPGRADE PATHAA02-DIT F2014410
                field(Cancelled; Rec."Cancelled FND")
                {
                    ToolTip = 'Specifies the value of the Cancelled field.';
                }
                field(Type; Type1)
                {
                    Editable = TypeEditable;
                    Enabled = TypeEnable;
                    QuickEntry = true;
                    ToolTip = 'Specifies the value of the Type1 field.';

                    trigger OnValidate();
                    begin
                        //TypeOnAfterValidate;//BC UPGRADE PATHAA02-DIT Function
                        NoOnAfterValidate();
                        //TypeChosen := HasTypeToFillMandatotyFields; //BC UPGRADE PATHAA02
                        TypeChosen := TotalPurchaseLine.HasTypeToFillMandatoryFields(); //BC UPGRADE PATHAA02
                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate();

                        //NAIKH01
                        if Type1 = Type1::" " then
                            Rec.VALIDATE(Type, Rec.Type::" ");

                        if Type1 = Type1::Item then
                            Rec.VALIDATE(Type, Rec.Type::Item);
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Suite;
                    QuickEntry = true;
                    ShowMandatory = TypeChosen;
                    ToolTipML = ENU = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.',
                                ESP = 'Permite especificar el número de una cuenta contable, un producto, un coste adicional o un activo fijo, según lo que se haya seleccionado en el campo Tipo.',
                                FRA = 'Spécifie le numéro d''un compte général, d''un article, d''un coût supplémentaire ou d''une immobilisation, selon la sélection effectuée dans le champ Type.';

                    trigger OnAssistEdit();
                    begin
                        //BC UPGRADE PATHAA02-DIT>>
                        // <<DITW15.00.00.39 DDR 26/08/2011 #1393 - DITW16.00.00.40 DDR 03/05/2012 DIT-715 #276
                        // if AssistEditItemTreeview("No.") then begin
                        //   // validate trigger
                        //   ShowShortcutDimCode(ShortcutDimCode);
                        //   // aftervalidate trigger
                        //   CurrPage.UPDATE(true);
                        // end else
                        //   CurrPage.UPDATE(false);
                        // >>DITW15.00.00.39 DDR #1393 - DITW16.00.00.40 DDR DIT-715 #276
                        //BC UPGRADE PATHAA02-DIT<<
                    end;

                    trigger OnValidate();
                    begin
                        //BC UPGRADE PATHAA02-DIT>>
                        // <<DITW17.10.03 DDR 10/06/2014 DIT-770 #541
                        // if not ("No.Editable" or "No.Enable") then begin
                        //     Rec."No." := xRec."No.";
                        //     exit;
                        // end;
                        // >>DITW17.10.03 DDR DIT-770 #541
                        //BC UPGRADE PATHAA02-DIT<<

                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate();

                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate();

                        //<<NAIKH01
                        if Rec.Type = Rec.Type::Item then begin
                            if Item.GET(Rec."No.") then;
                            GeneralOpCoSetup.GET();
                            GeneralOpCoSetup.TESTFIELD("Item Category");

                            if Item."Item Category Code" <> GeneralOpCoSetup."Item Category" then
                                ERROR(Err001, Rec."No.", GeneralOpCoSetup."Item Category");

                        end;
                        //>>Naikh01
                    end;
                }
                // field("Revision No."; Rec."Revision No.")
                // {
                //     Description = 'MANXL7.00.001';
                //     QuickEntry = false;
                //     Visible = false;
                // } //BC UPGRADE PATHAA02-DIT F2036304
                // field("Requester ID"; Rec."Requester ID")
                // {
                //     Description = 'MANXL7.00.001';
                //     QuickEntry = false;
                //     Visible = false;
                // } //BC UPGRADE PATHAA02-DIT F2036305
                // field("Cross-Reference No."; "Cross-Reference No.")
                // {
                //     ApplicationArea = Suite;
                //     Editable = "Cross-Reference No.Editable";
                //     QuickEntry = false;
                //     ToolTipML = ENU = 'Specifies the cross-referenced item number. If you enter a cross reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the cross-reference number on a sales or purchase document.',
                //                 ESP = 'Especifica el número de producto de la referencia cruzada. Si introduce una referencia cruzada entre su número de producto y el del proveedor o el cliente, sobrescribirá el número de producto estándar cuando introduzca el número de referencia cruzada en un documento de venta o de compra.',
                //                 FRA = 'Spécifie le numéro d''article à référence externe. Si vous saisissez une référence externe entre votre numéro d''article et celui de votre fournisseur ou client, ce numéro remplace le numéro d''article standard lorsque vous saisissez le numéro de référence externe sur un document vente ou achat.';
                //     Visible = false;

                //     trigger OnLookup(Text: Text): Boolean;
                //     begin
                //         CrossReferenceNoLookUp;
                //         // <<DITW15.00.00.38 DDR 27/01/2011 #1259
                //         //InsertExtendedText(FALSE);
                //         // >>DITW15.00.00.38 DDR #1259
                //         NoOnAfterValidate;
                //         // <<DITW15.00.00.38 DDR 27/01/2011 #1259
                //         CurrPage.UPDATE;
                //         // >>DITW15.00.00.38 DDR #1259
                //     end;

                //     trigger OnValidate();
                //     begin
                //         CrossReferenceNoOnAfterValidat;
                //         NoOnAfterValidate;
                //     end;
                // } //BC UPGRADE PATHAA02-DIT F5705 from T39 Deprecateed in BC

                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the IC Partner Code field.';
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the IC Partner Ref. Type field.';
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the IC Partner Reference field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Variant Code field.';

                    trigger OnValidate();
                    begin
                        // VariantCodeOnAfterValidate; //BC UPGRADE PATHAA02-DIT Function
                    end;
                }
                // field("Emergency Order"; Rec."Emergency Order")
                // {
                // } //BC UPGRADE PATHAA02-DIT F2029615
                field(Nonstock; Rec.Nonstock)
                {
                    ApplicationArea = Suite;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Catalog field.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                // field("GetTrackingItemNo()"; GetTrackingItemNo())
                // {
                //     CaptionML = ENU = 'Tracking Item No. (Item Charge)',
                //                 FRA = 'N° article traçable (Frais annexes)';
                //     DrillDownPageID = "Item List";
                //     Editable = false;
                //     LookupPageID = "Item List";
                //     QuickEntry = false;
                //     TableRelation = IF (Rec."Item Charge Type" = CONST(Tax)) Item WHERE("No." = FIELD("Tax Item No."))
                //     ELSE IF ("Item Charge Type" = CONST(Deposit)) Item WHERE("No." = FIELD("Empty Goods Item No."));
                //         Visible = false;

                //     trigger OnLookup(Text: Text): Boolean;
                //     begin
                //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
                //         Text := GetTrackingItemNo();
                //         LookupItemNo(Text);
                //         exit(false);
                //     end;
                // } //BC UPGRADE PATHAA02-DIT (T27-F2013695(Item Charge type)
                field(Description; Rec.Description)
                {
                    ApplicationArea = Suite;
                    Editable = EditableDesc;
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies a description of the item or service on the line.',
                                ESP = 'Permite especificar una descripción del producto o servicio en la línea.',
                                FRA = 'Spécifie une description de l''article ou du service sur la ligne.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    Description = 'DIT-715 #393';
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Description 2 field.';
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    ApplicationArea = Suite;
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies if your vendor will ship the items on the line directly to your customer.',
                                ESP = 'Especifica si el proveedor enviará directamente al cliente los productos de la línea.',
                                FRA = 'Spécifie si vous souhaitez que votre fournisseur livre les articles de la ligne directement à votre client.';
                    Visible = false;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Return Reason Code field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';

                    trigger OnValidate();
                    begin
                        //BC UPGRADE PATHAA02-DIT>>
                        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        // if "Responsibility Center" <> xRec."Responsibility Center" then
                        //     CurrPage.UPDATE(true);
                        // >>DITW18.00.06 DDR DIT-770 #1191
                        //BC UPGRADE PATHAA02-DIT<<
                    end;
                }
                // field("Physical Location Group Code"; Rec."Physical Location Group Code")
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
                // } //BC UPGRADE PATHAA02-DIT Commented DIT Field
                field("Location Code"; Rec."Location Code")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the value of the Location Code field.';

                    trigger OnValidate();
                    begin
                        //BC UPGRADE PATHAA02-DIT>>
                        //LocationCodeOnAfterValidate;                        
                        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        // if xRec."Location Code" <> "Location Code" then
                        //     CurrPage.UPDATE(true);
                        // >>DITW18.00.06 DDR DIT-770 #1191
                        //BC UPGRADE PATHAA02-DIT<<

                        if PurchHeader."Location Code" <> '' then begin
                            if PurchHeader."Location Code" <> Rec."Location Code" then
                                ERROR('Location Code should be same as Location code in Header');
                        end else begin
                            GeneralOpCoSetup.GET();
                            GeneralOpCoSetup.TESTFIELD("BRC Location Code");
                            if GeneralOpCoSetup."BRC Location Code" <> Rec."Location Code" then
                                ERROR('Location Code must be %1', GeneralOpCoSetup."BRC Location Code");

                        end;
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Bin Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    Editable = QuantityEditable;
                    Enabled = QuantityEnable;
                    QuickEntry = true;
                    ShowMandatory = TypeChosen;
                    ToolTip = 'Specifies the value of the Quantity field.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        //QuantityOnAfterValidate; //BC UPGRADE PATHAA02-DIT Function
                    end;
                }
                // field("No. of Quality Tests"; Rec."No. of Quality Tests")
                // {
                //     QuickEntry = false;
                // } //BC UPGRADE PATHAA02-DIT T39-->F2035090
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    BlankZero = true;
                    QuickEntry = false;
                    ToolTip = 'Specifies the value of the Reserved Quantity field.';
                }
                field("Job Remaining Qty."; Rec."Job Remaining Qty.")
                {
                    BlankZero = true;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Project Remaining Qty. field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Suite;
                    Editable = UnitofMeasureCodeIsChangeable;
                    Enabled = UnitofMeasureCodeIsChangeable;
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies the unit of measure code for the item.',
                                ESP = 'Permite especificar el código de unidad de medida del producto.',
                                FRA = 'Spécifie le code unité de mesure de l''article.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        //UnitofMeasureCodeOnAfterValida; //BC UPGRADE PATHAA02-DIT Function
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Unit of Measure field.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                // field("Tariff No."; Rec."Tariff No.")
                // {
                //     Description = 'FINXL7.00.001';
                //     QuickEntry = false;
                //     Visible = false;
                // } //BC UPGRADE PATHAA02-DIT F2013729
                field("Net Weight"; Rec."Net Weight")
                {
                    Description = 'FINXL7.00.001';
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Net Weight field.';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    Editable = "Direct Unit CostEditable";
                    QuickEntry = false;
                    ShowMandatory = TypeChosen;
                    ToolTipML = ENU = 'Specifies the direct cost of one item unit.',
                                ESP = 'Permite especificar el coste directo de una unidad del producto.',
                                FRA = 'Spécifie le coût direct d''une unité d''article.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        //DirectUnitCostOnAfterValidate; //BC UPGRADE PATHAA02-DIT Function
                    end;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Indirect Cost % field.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Unit Cost (LCY) field.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    BlankZero = true;
                    Enabled = "Unit Price (LCY)Enable";
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Unit Price (LCY) field.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    Editable = "Line AmountEditable";
                    Enabled = "Line AmountEnable";
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies the net amount (before subtracting the invoice discount amount) that must be paid for the items on the line.',
                                ESP = 'Especifica el importe neto (antes de restar el importe de descuento de la factura) que se debe pagar por los productos de la línea.',
                                FRA = 'Spécifie le montant net (avant soustraction du montant remise facture) à payer pour les articles de la ligne.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        //LineAmountOnAfterValidate; //BC UPGRADE PATHAA02-DIT Function
                    end;
                }

                //BC UPGRADE PATHAA02-DIT>>
                // field(RTCTotalUnit; Rec.GetTotalingLine(2, FIELDNO("Direct Unit Cost"), true))
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
                // field(RTCTotalLine; Rec.GetTotalingLine(1, FIELDNO("Line Amount"), true))
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

                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies the line discount percentage.',
                                ESP = 'Permite especificar el porcentaje de descuento de la línea.',
                                FRA = 'Spécifie le pourcentage remise ligne.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        //LineDiscount37OnAfterValidate; //BC UPGRADE PATHAA02-DIT Function
                    end;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the discount amount that is granted on the line.',
                                ESP = 'Permite especificar el importe de descuento que se concede en la línea.',
                                FRA = 'Spécifie le montant de la remise accordée à la ligne.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        //LineDiscountAmountOnAfterValid; //BC UPGRADE PATHAA02-DIT Function
                    end;
                }
                field("SRM Contract No."; Rec."SRM Contract No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Contract No. field.';
                }
                field("SRM Contract Line No."; Rec."SRM Contract Line No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Contract Line No. field.';
                }
                field("SRM Order No."; Rec."SRM Order No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Order No. field.';
                }
                field("SRM Order Line No."; Rec."SRM Order Line No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Order Line No. field.';
                }
                field("Initial Quantity"; Rec."Initial Quantity FND")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Initial Quantity field.';
                }
                field("Initial Amount"; Rec."Initial Amount FND")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Initial Amount field.';
                }
                field("Remaining Amount"; Rec."Remaining Amount FND")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Remaining Amount field.';
                }
                field("Delivery Finalized"; Rec."Delivery Finalized FND")
                {
                    ToolTip = 'Specifies the value of the Delivery Finalized field.';
                }
                // field("App. Prod. Posting Group"; Rec."App. Prod. Posting Group")
                // {
                //     Visible = false;
                // }
                // field("Approved Line Amount"; Rec."Approved Line Amount")
                // {
                //     Visible = false;
                // } //BC UPGRADE PATHAA02-DIT Fields

                field("Prepayment %"; Rec."Prepayment %")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Prepayment % field.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        //Prepayment37OnAfterValidate; //BC UPGRADE PATHAA02-DIT Function
                    end;
                }
                field("Prepmt. Line Amount"; Rec."Prepmt. Line Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Prepmt. Line Amount field.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        //PrepmtLineAmountOnAfterValidat; //BC UPGRADE PATHAA02-DIT Function
                    end;
                }
                field("Prepmt. Amt. Inv."; Rec."Prepmt. Amt. Inv.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Prepmt. Amt. Inv. field.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Allow Invoice Disc. field.';
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the invoice discount amount for the line.',
                                ESP = 'Especifica el importe de descuento en factura para la línea.',
                                FRA = 'Spécifie le montant de la remise facture pour la ligne.';
                    Visible = false;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    Editable = "Qty. to ReceiveEditable";
                    ToolTipML = ENU = 'Specifies the quantity that remains to be invoiced. It is calculated as Quantity - Qty. Invoiced.',
                                ESP = 'Permite especificar la cantidad que queda por facturar. Se calcula como Cantidad menos Cdad. facturada.',
                                FRA = 'Spécifie la quantité restante à facturer. Le calcul est effectué comme suit : Quantité - Qté facturée.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        //QtytoReceiveOnAfterValidate;//BC UPGRADE PATHAA02-DIT Function
                    end;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    ToolTipML = ENU = 'Specifies how many units of the item on the line have already been invoiced.',
                                ESP = 'Permite especificar cuántas unidades del producto de la línea se han facturado ya.',
                                FRA = 'Spécifie le nombre d''unités de l''article sur la ligne qui ont déjà été facturées.';
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    Editable = "Qty. to InvoiceEditable";
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies the quantity that remains to be invoiced. It is calculated as Quantity - Qty. Invoiced.',
                                ESP = 'Permite especificar la cantidad que queda por facturar. Se calcula como Cantidad menos Cdad. facturada.',
                                FRA = 'Spécifie la quantité restante à facturer. Le calcul est effectué comme suit : Quantité - Qté facturée.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        //QtytoInvoiceOnAfterValidate; //BC UPGRADE PATHAA02-DIT Function
                    end;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    ToolTipML = ENU = 'Specifies how many units of the item on the line have already been invoiced.',
                                ESP = 'Permite especificar cuántas unidades del producto de la línea se han facturado ya.',
                                FRA = 'Spécifie le nombre d''unités de l''article sur la ligne qui ont déjà été facturées.';
                    Visible = false;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ToolTip = 'Specifies the value of the Outstanding Quantity field.';
                }
                field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
                {
                    ToolTip = 'Specifies the value of the Qty. Rcd. Not Invoiced field.';
                }
                field("Amt. Rcd. Not Invoiced"; Rec."Amt. Rcd. Not Invoiced")
                {
                    ToolTip = 'Specifies the value of the Amt. Rcd. Not Invoiced field.';
                }
                field("Prepmt Amt to Deduct"; Rec."Prepmt Amt to Deduct")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Prepmt Amt to Deduct field.';

                    trigger OnValidate();
                    begin
                        //PrepmtAmttoDeductOnAfterValida; //BC UPGRADE PATHAA02-DIT Function
                    end;
                }
                field("Prepmt Amt Deducted"; Rec."Prepmt Amt Deducted")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Prepmt Amt Deducted field.';
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Allow Item Charge Assignment field.';
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    BlankZero = true;
                    ToolTip = 'Specifies the value of the Qty. to Assign field.';

                    trigger OnDrillDown();
                    begin
                        CurrPage.SAVERECORD();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(false);
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    BlankZero = true;
                    ToolTip = 'Specifies the value of the Qty. Assigned field.';

                    trigger OnDrillDown();
                    begin
                        CurrPage.SAVERECORD();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(false);
                    end;
                }
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Project No. field.';
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Project Task No. field.';
                }
                field("Job Planning Line No."; Rec."Job Planning Line No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Project Planning Line No. field.';
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Project Line Type field.';
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Project Unit Price field.';
                }
                field("Job Line Amount"; Rec."Job Line Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Project Line Amount field.';
                }
                field("Job Line Discount Amount"; Rec."Job Line Discount Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Project Line Discount Amount field.';
                }
                field("Job Line Discount %"; Rec."Job Line Discount %")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Project Line Discount % field.';
                }
                field("Job Total Price"; Rec."Job Total Price")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Project Total Price field.';
                }
                field("Job Unit Price (LCY)"; Rec."Job Unit Price (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Project Unit Price (LCY) field.';
                }
                field("Job Total Price (LCY)"; Rec."Job Total Price (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Project Total Price (LCY) field.';
                }
                field("Job Line Amount (LCY)"; Rec."Job Line Amount (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Project Line Amount (LCY) field.';
                }
                field("Job Line Disc. Amount (LCY)"; Rec."Job Line Disc. Amount (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Project Line Disc. Amount (LCY) field.';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the date that you want the vendor to deliver to the ship-to address. The value in the field is used to calculate the latest date you can order the items to have them delivered on the requested receipt date. If you do not need delivery on a specific date, you can leave the field blank.',
                                ESP = 'Permite especificar la fecha en la desea que el proveedor envíe el pedido a la dirección de envío. El valor del campo se usa para calcular la última fecha en la que puede solicitar los productos de forma que se envíen en la fecha de recepción solicitada. Si no necesita que se produzca el envío en una fecha específica, puede dejar el campo en blanco.',
                                FRA = 'Spécifie la date à laquelle vous souhaitez que le fournisseur livre les articles à l''adresse destinataire. La valeur du champ est utilisée pour calculer la date limite de commande garantissant la livraison des articles à la date de réception demandée. Si vous ne souhaitez pas indiquer une date de livraison, vous pouvez laisser ce champ vide.';
                    Visible = false;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Promised Receipt Date field.';
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the value of the Planned Receipt Date field.';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the value of the Expected Receipt Date field.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = Suite;
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies the date when the item is ordered. It is calculated backwards from the Planned Receipt Date field in combination with the Lead Time Calculation field.',
                                ESP = 'Permite especificar la fecha en que se solicitó el producto. Se calcula hacia atrás a partir del valor del campo Fecha recep. planificada junto con el campo Plazo entrega (días)',
                                FRA = 'Spécifie la date de commande de l''article. Elle est calculée en amont à partir du champ Date planifiée de réception et du champ Délai de réappro.';
                    Visible = false;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Lead Time Calculation field.';
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Planning Flexibility field.';
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Prod. Order No. field.';
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Prod. Order Line No. field.';
                }
                field("Operation No."; Rec."Operation No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Operation No. field.';
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Work Center No. field.';
                }
                field(Finished; Rec.Finished)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Finished field.';
                }
                // field("Whse. Receipt No. (Open)"; Rec."Whse. Receipt No. (Open)")
                // {
                //     Description = '#1399';
                //     Lookup = false;
                //     Visible = false;
                // }//BC UPGRADE PATHAA02-DIT F2014103

                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Whse. Outstanding Qty. (Base) field.';
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Inbound Whse. Handling Time field.';
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Blanket Order No. field.';
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    Description = 'HEI.03';
                    ToolTip = 'Specifies the value of the Blanket Order Line No. field.';
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the item ledger entry number the line should be applied to.',
                                ESP = 'Especifica el número del movimiento de producto al que se debería aplicar esta línea.',
                                FRA = 'Spécifie le numéro de l''écriture comptable article avec laquelle la ligne doit être lettrée.';
                    Visible = false;
                }

                //BC UPGRADE PATHAA02-DIT>>
                // field("Shipping Agent Code"; Rec."Shipping Agent Code")
                // {
                //     Visible = false;
                // }
                // field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                // {
                //     Visible = false;
                // }
                // field(Weight; Rec.Weight)
                // {
                //     Editable = false;
                // }
                // field(Cubage; Rec.Cubage)
                // {
                //     Editable = false;
                // }
                // field("ShortcutQtyUomValue[1]"; ShortcutQtyUomValue[1])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassUom(1);
                //     DecimalPlaces = 0 : 5;
                //     Description = 'DIT-715 #244';
                //     Editable = false;
                //     Visible = false;
                // }
                // field("ShortcutQtyUomValue[2]"; ShortcutQtyUomValue[2])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassUom(2);
                //     DecimalPlaces = 0 : 5;
                //     Description = 'DIT-715 #244';
                //     Editable = false;
                //     Visible = false;
                // }
                // field("ShortcutQtyUomValue[3]"; ShortcutQtyUomValue[3])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassUom(3);
                //     DecimalPlaces = 0 : 5;
                //     Description = 'DIT-715 #244';
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Unit Volume HL"; Rec."Unit Volume HL")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Vendor DTax Group Code"; Rec."Vendor DTax Group Code")
                // {
                //     Description = 'DIT-770 #698';
                //     Editable = false;
                //     QuickEntry = false;
                //     Visible = false;
                // }
                // field("Item DTax Group Code"; Rec."Item DTax Group Code")
                // {
                //     Description = '<DITW15.00.00.01>- DIT-770 #698';
                //     Editable = false;
                //     QuickEntry = false;
                //     Visible = false;
                // }
                // field("Strength Spec. Code"; Rec."Strength Spec. Code")
                // {
                //     Editable = false;
                //     QuickEntry = false;
                //     Visible = false;
                // }
                // field("Strength Spec. Value"; Rec."Strength Spec. Value")
                // {
                //     QuickEntry = false;
                //     Visible = false;
                // }
                // field("Vol-Strength Spec. Code"; Rec."Vol-Strength Spec. Code")
                // {
                //     Editable = false;
                //     QuickEntry = false;
                //     Visible = false;
                // }
                // field("Vol-Strength Spec. Value"; Rec."Vol-Strength Spec. Value")
                // {
                //     QuickEntry = false;
                //     Visible = false;
                // }
                // field("AAD No."; Rec."AAD No.")
                // {
                //     Visible = false;
                // }
                // field("ARC No."; Rec."ARC No.")
                // {
                //     Description = 'DITW15.00.00.38 #1217';
                //     Visible = false;

                //     trigger OnLookup(Text: Text): Boolean;
                //     begin
                //         // <<DITW15.00.00.38 DDR 30/09/2010 #1217
                //         exit(
                //           EDILookupExtTrackingARC(Text));
                //         // >>DITW15.00.00.38 DDR
                //     end;
                // }
                // field("SAD No."; Rec."SAD No.")
                // {
                //     Description = 'DITW15.00.00.38 #1217';
                //     Visible = false;
                // }
                // field("Packaging Type Code"; Rec."Packaging Type Code")
                // {
                //     Visible = false;
                // }
                // field("Applies-to AAD Trck. Entry No."; Rec."Applies-to AAD Trck. Entry No.")
                // {
                //     Description = 'DITW15.00.00.39 #1369';
                //     Visible = false;
                // }
                // field("Free Reason Code"; Rec."Free Reason Code")
                // {
                //     CaptionML = ENU = 'Free Reason Code',
                //                 FRA = 'Code motif gratuit';
                //     Description = 'DITW17.10.05 DIT-770 #692';
                //     QuickEntry = false;
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         // <<DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692
                //         FreeReasoncodeOnAfterValidate
                //         // >>DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692
                //     end;
                // }
                // field("Free Item"; Rec."Free Item")
                // {
                //     QuickEntry = false;

                //     trigger OnValidate();
                //     begin
                //         FreeItemOnAfterValidate;
                //     end;
                // }
                // field("Allow VAT Calculation (Free)"; Rec."Allow VAT Calculation (Free)")
                // {
                //     Description = 'DITW16.00.00.40 DIT-715 #172';
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         AllowVATCalculationFreeOnAfter;
                //     end;
                // }
                // field("Free Item Posting Type"; Rec."Free Item Posting Type")
                // {
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         FreeItemPostingTypeOnAfterVali;
                //     end;
                // }
                // field("Contract Type"; Rec."Contract Type")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
                // {
                //     Visible = false;
                // }
                // field("Service Contract No."; Rec."Service Contract No.")
                // {
                //     Visible = false;
                // }
                // field("Financial Contract No."; Rec."Financial Contract No.")
                // {
                //     Visible = false;
                // }
                // field("Contract Group Code"; Rec."Contract Group Code")
                // {
                //     Visible = false;
                // }
                // field("Linked Customer No."; Rec."Linked Customer No.")
                // {
                //     Visible = false;
                // }
                // field("Auto. Acc. Group"; Rec."Auto. Acc. Group")
                // {
                //     Description = 'FINXL7.00.001';
                //     QuickEntry = false;
                //     Visible = false;
                // }

                //BC UPGRADE PATHAA02-DIT<<

                field("Deferral Code"; Rec."Deferral Code")
                {
                    ApplicationArea = Suite;
                    Enabled = (Rec.Type <> Rec.Type::"Fixed Asset") AND (Rec.Type <> Rec.Type::" ");
                    TableRelation = "Deferral Template"."Deferral Code";
                    ToolTipML = ENU = 'Specifies the deferral template that governs how expenses paid with this purchase document are deferred to the different accounting periods when the expenses were incurred.',
                                ESP = 'Especifica la plantilla de fraccionamiento que administra el modo de fraccionar los gastos pagados con este documento de compra en los diferentes periodos contables cuando se contraen gastos.',
                                FRA = 'Spécifie le modèle échelonnement qui régit la manière dont les dépenses payées avec ce document achat sont échelonnées sur les différentes périodes de comptabilité lorsque les dépenses sont encourues.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.',
                                ESP = 'Especifica el código de la dimensión del acceso directo 1.',
                                FRA = 'Spécifie le code pour Raccourci axe 1.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.',
                                ESP = 'Especifica el código de la dimensión del acceso directo 2.',
                                FRA = 'Spécifie le code pour Raccourci axe 2.';
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[3] field.';

                    trigger OnValidate();
                    begin
                        ValidateSaveShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[4] field.';

                    trigger OnValidate();
                    begin
                        ValidateSaveShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[5] field.';

                    trigger OnValidate();
                    begin
                        ValidateSaveShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[6] field.';

                    trigger OnValidate();
                    begin
                        ValidateSaveShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[7] field.';

                    trigger OnValidate();
                    begin
                        ValidateSaveShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[8] field.';

                    trigger OnValidate();
                    begin
                        ValidateSaveShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                // field("Backorder Type"; Rec."Backorder Type")
                // {
                //     Caption = 'Backorder Type';
                //     Editable = false;
                //     Visible = false;
                // } //BC UPGRADE PATHAA02-DIT
                field("WHT Absorb Base"; Rec."WHT Absorb Base FND")
                {
                    ToolTip = 'Specifies the value of the WHT Absorb Base field.';
                }
                field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
                {
                    ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
                }
                field("WHT Product Posting Group"; Rec."WHT Product Posting Group FND")
                {
                    ToolTip = 'Specifies the value of the WHT Product Posting Group field.';
                }
                field("Maximo Requisition No."; Rec."Maximo Requisition No. FND")
                {
                    ToolTip = 'Specifies the value of the Maximo Requisition No. field.';
                }
                field("Maximo Requisition Line No."; Rec."Maximo Requis. Line No. FND")
                {
                    ToolTip = 'Specifies the value of the Maximo Requisition Line No. field.';
                }
                field("Machine Reference Number"; Rec."Machine Reference Number FND")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Machine Reference Number field.';
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    ToolTip = 'Specifies the value of the Duplicate in Depreciation Book field.';
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    ToolTip = 'Specifies the value of the Use Duplication List field.';
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ToolTip = 'Specifies the value of the Depreciation Book Code field.';
                }
                field("TIN No."; Rec."TIN No. FND")
                {
                    Caption = 'TIN No.';
                    Description = 'HEI.08';
                    ToolTip = 'Specifies the value of the TIN No. field.';
                }
            }
            group(Control43)
            {
                group(Control37)
                {
                    field("Invoice Discount Amount"; TotalPurchaseLine."Inv. Discount Amount")
                    {
                        ApplicationArea = Suite;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionML = ENU = 'Invoice Discount Amount',
                                    ESP = 'Importe descuento factura',
                                    FRA = 'Montant remise facture';
                        Editable = InvDiscAmountEditable;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        ToolTipML = ENU = 'Specifies the amount that is calculated and shown in the Invoice Discount Amount field. The invoice discount amount is deducted from the value shown in the Total Amount Incl. Tax field.',
                                    ESP = 'Especifica el importe que se calcula y se muestra en el campo Importe descuento factura. El importe de descuento en factura se deduce del valor que se muestra en el campo Importe total incl. IVA.',
                                    FRA = 'Spécifie le montant calculé et affiché dans le champ Montant remise facture. Le montant remise facture est déduit de la valeur indiquée dans le champ Montant total TTC.';

                        trigger OnValidate();
                        var
                            PurchaseHeader: Record "Purchase Header";
                        begin
                            PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
                            if PurchaseHeader.InvoicedLineExists() then
                                if not CONFIRM(UpdateInvDiscountQst, false) then
                                    exit;

                            PurchCalcDiscByType.ApplyInvDiscBasedOnAmt(TotalPurchaseLine."Inv. Discount Amount", PurchaseHeader);
                            CurrPage.UPDATE(false);
                        end;
                    }
                    field("Invoice Disc. Pct."; PurchCalcDiscByType.GetVendInvoiceDiscountPct(Rec))
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Invoice Discount %',
                                    ESP = '% descuento en factura',
                                    FRA = '% remise facture';
                        DecimalPlaces = 0 : 2;
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        ToolTipML = ENU = 'Specifies a discount percentage that is granted if criteria that you have set up for the customer are met. The calculated discount amount is inserted in the Invoice Discount Amount field, but you can change it manually.',
                                    ESP = 'Especifica un porcentaje de descuento que se concede si se cumplen los criterios que configuró para el cliente. El importe de descuento calculado se inserta en el campo Importe descuento factura, pero lo puede cambiar de forma manual.',
                                    FRA = 'Spécifie le pourcentage de remise accordé si les critères que vous avez définis pour le client sont remplis. Le montant calculé de la remise est inséré dans le champ Montant remise facture, mais vous pouvez le modifier manuellement.';
                    }
                }
                group(Control19)
                {
                    field("Total Amount Excl. VAT"; TotalPurchaseLine.Amount)
                    {
                        ApplicationArea = Suite;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(PurchHeader."Currency Code");
                        CaptionML = ENU = 'Total Amount Excl. Tax',
                                    ESP = 'Importe total excl. IVA',
                                    FRA = 'Montant total HT';
                        DrillDown = false;
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        ToolTip = 'Specifies the value of the Amount field.';
                    }
                    field("Total VAT Amount"; VATAmount)
                    {
                        ApplicationArea = Suite;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalVATCaption(PurchHeader."Currency Code");
                        CaptionML = ENU = 'Total Tax',
                                    ESP = 'IVA total',
                                    FRA = 'Total TVA';
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        ToolTipML = ENU = 'Specifies the sum of Tax amounts on all lines in the document.',
                                    ESP = 'Especifica la suma de los importes de IVA en todas las líneas del documento.',
                                    FRA = 'Spécifie la somme des montants de TVA sur toutes les lignes du document.';
                    }
                    field("Total Amount Incl. VAT"; TotalPurchaseLine."Amount Including VAT")
                    {
                        ApplicationArea = Suite;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(PurchHeader."Currency Code");
                        CaptionML = ENU = 'Total Amount Incl. Tax',
                                    ESP = 'Importe total incl. IVA',
                                    FRA = 'Montant total TTC';
                        Editable = false;
                        StyleExpr = TotalAmountStyle;
                        ToolTip = 'Specifies the value of the Amount Including VAT field.';
                    }
                    field(RefreshTotals; RefreshMessageText)
                    {
                        ApplicationArea = Suite;
                        DrillDown = true;
                        Editable = false;
                        Enabled = RefreshMessageEnabled;
                        ShowCaption = false;

                        trigger OnDrillDown();
                        begin
                            DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
                            DocumentTotals.PurchaseUpdateTotalsControls(Rec, TotalPurchaseHeader, TotalPurchaseLine, RefreshMessageEnabled,
                              TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, VATAmount);
                        end;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("+ Expand")
            {
                CaptionML = ENU = '+ Expand',
                            FRA = '+ Développer';
                Enabled = (NOT ExpandLines);
                Image = ViewDetails;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                Visible = (NOT ExpandLines) OR ShowButtonsCE;
                ToolTip = 'Executes the + Expand action.';

                trigger OnAction();
                begin
                    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                    ExpandLines := true;
                    CurrPage.UPDATE(true);
                    // >>DITW17.10.03 DDR DIT-770 #541
                end;
            }
            action("- Collapse")
            {
                CaptionML = ENU = '- Collapse',
                            FRA = '- Réduire';
                Enabled = ExpandLines;
                Image = ViewDetails;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                Visible = ExpandLines OR ShowButtonsCE;
                ToolTip = 'Executes the - Collapse action.';

                trigger OnAction();
                begin
                    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                    ExpandLines := false;
                    CurrPage.UPDATE(true);
                    // >>DITW17.10.03 DDR DIT-770 #541
                end;
            }
            group("&Line")
            {
                CaptionML = ENU = '&Line',
                            ESP = '&Línea',
                            FRA = '&Ligne';
                Image = Line;
                group("Item Availability by")
                {
                    CaptionML = ENU = 'Item Availability by',
                                ESP = 'Disponibilidad prod. por',
                                FRA = 'Disponibilité article par';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        CaptionML = ENU = 'Event',
                                    ESP = 'Evento',
                                    FRA = 'Événement';
                        Image = "Event";
                        ToolTip = 'Executes the Event action.';

                        trigger OnAction();
                        begin
                            // BC Upgrade PATELS08 >> # 'ShowItemAvailFromPurchLine' and 'ByEvent()' is marked for removal, replaced with 'ShowItemAvailabilityFromPurchLine' and enum "Item Availability Type" repectively.
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::"Event");
                            // BC Upgrade PATELS08 >>
                        end;
                    }
                    // action("Items by Period")
                    // {
                    //     CaptionML = ENU = 'Items by Period',
                    //                 FRA = 'Articles par période';
                    //     Description = 'DIT-715 #338';

                    //     trigger OnAction();
                    //     begin
                    //         // <<DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338
                    //         //This functionality was copied from page #50. Unsupported part was commented. Please check it.
                    //         /*CurrPage.PurchLines.PAGE.*/
                    //         _AllItemsAvailability(1);

                    //     end;
                    // }
                    action(Period)
                    {
                        CaptionML = ENU = 'Period',
                                    ESP = 'Periodo',
                                    FRA = 'Période';
                        Image = Period;
                        ToolTip = 'Executes the Period action.';

                        trigger OnAction();
                        begin
                            // BC Upgrade PATELS08 >> # 'ShowItemAvailFromPurchLine' and 'ByPeriod()' is marked for removal, replaced with 'ShowItemAvailabilityFromPurchLine' and enum "Item Availability Type" repectively.
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByPeriod());
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Period);
                            // BC Upgrade PATELS08 <<
                        end;
                    }
                    action(Variant)
                    {
                        CaptionML = ENU = 'Variant',
                                    ESP = 'Variante',
                                    FRA = 'Variante';
                        Image = ItemVariant;
                        ToolTip = 'Executes the Variant action.';

                        trigger OnAction();
                        begin
                            // BC Upgrade PATELS08 >> # 'ShowItemAvailFromPurchLine' and 'ByVariant()' is marked for removal, replaced with 'ShowItemAvailabilityFromPurchLine' and enum "Item Availability Type" repectively.
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Variant);
                            // BC Upgrade PATELS08 <<
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData Location = R;
                        CaptionML = ENU = 'Location',
                                    ESP = 'Almacén',
                                    FRA = 'Magasin';
                        Image = Warehouse;
                        ToolTip = 'Executes the Location action.';

                        trigger OnAction();
                        begin
                            // BC Upgrade PATELS08 >> # 'ShowItemAvailFromPurchLine' and 'ByLocation()' is marked for removal, replaced with 'ShowItemAvailabilityFromPurchLine' and enum "Item Availability Type" repectively.
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Location);
                            // BC Upgrade PATELS08 <<
                        end;
                    }

                    //BC UPGRADE PATHAA02-DIT>>
                    // action("Period (Items)")
                    // {
                    //     CaptionML = ENU = 'Period (Items)',
                    //                 FRA = 'Période (Article)';
                    //     Description = 'DIT-715 #338';

                    //     trigger OnAction();
                    //     begin
                    //         // <<DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338
                    //         //This functionality was copied from page #50. Unsupported part was commented. Please check it.
                    //         /*CurrPage.PurchLines.PAGE.*/
                    //         _AllItemsAvailability(0);

                    //     end;
                    // } 
                    //BC UPGRADE PATHAA02-DIT<<
                    action("BOM Level")
                    {
                        CaptionML = ENU = 'BOM Level',
                                    ESP = 'Nivel L.M.',
                                    FRA = 'Niveau nomenclature';
                        Image = BOMLevel;
                        ToolTip = 'Executes the BOM Level action.';

                        trigger OnAction();
                        begin
                            // BC Upgrade PATELS08 >> # 'ShowItemAvailFromPurchLine' and 'ByBOM()' is marked for removal, replaced with 'ShowItemAvailabilityFromPurchLine' and enum "Item Availability Type" repectively.
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::BOM);
                            // BC Upgrade PATELS08 <<
                        end;
                    }
                }
                action("Reservation Entries")
                {
                    AccessByPermission = TableData Item = R;
                    CaptionML = ENU = 'Reservation Entries',
                                ESP = 'Movs. reserva',
                                FRA = 'Écritures réservation';
                    Image = ReservationLedger;
                    ToolTip = 'Executes the Reservation Entries action.';

                    trigger OnAction();
                    begin
                        Rec.ShowReservationEntries(true);
                    end;
                }
                action("Item Tracking Lines")
                {
                    CaptionML = ENU = 'Item &Tracking Lines',
                                ESP = 'Líns. se&guim. prod.',
                                FRA = 'Lignes &traçabilité';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'Executes the Item Tracking Lines action.';

                    trigger OnAction();
                    begin
                        Rec.OpenItemTrackingLines();
                    end;
                }

                //BC UPGRADE PATHAA02-DIT>>
                // action("SSCC Tracking Lines")
                // {
                //     CaptionML = ENU = 'SSCC Tracking Lines',
                //                 FRA = 'Lignes Traçabilité SSCC';
                //     Description = 'DIT-715 #745';
                //     Image = ItemTrackingLines;

                //     trigger OnAction();
                //     begin
                //         //This functionality was copied from page #50. Unsupported part was commented. Please check it.
                //         /*CurrPage.PurchLines.FORM.*/
                //         _OpenSSCCTrackingLines();

                //     end;
                // }
                //BC UPGRADE PATHAA02-DIT<<

                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    CaptionML = ENU = 'Dimensions',
                                ESP = 'Dimensiones',
                                FRA = 'Axes analytiques';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action.';

                    trigger OnAction();
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action("Co&mments")
                {
                    CaptionML = ENU = 'Co&mments',
                                ESP = 'C&omentarios',
                                FRA = 'Co&mmentaires';
                    Image = ViewComments;
                    ToolTip = 'Executes the Co&mments action.';

                    trigger OnAction();
                    begin
                        Rec.ShowLineComments();
                    end;
                }
                action(ItemChargeAssignment)
                {
                    AccessByPermission = TableData "Item Charge" = R;
                    CaptionML = ENU = 'Item Charge &Assignment',
                                ESP = '&Asignación cargos prod.',
                                FRA = '&Affectation frais annexes';
                    Image = ItemCosts;
                    ToolTip = 'Executes the ItemChargeAssignment action.';

                    trigger OnAction();
                    begin
                        Rec.ShowItemChargeAssgnt();
                    end;
                }
                action(DeferralSchedule)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Deferral Schedule',
                                ESP = 'Previsión fraccionamiento',
                                FRA = 'Tableau d''échelonnement';
                    Enabled = Rec."Deferral Code" <> '';
                    Image = PaymentPeriod;
                    ToolTip = 'Executes the DeferralSchedule action.';

                    trigger OnAction();
                    begin
                        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
                        Rec.ShowDeferrals(PurchHeader."Posting Date", PurchHeader."Currency Code")
                    end;
                }
            }
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions',
                            ESP = 'Acci&ones',
                            FRA = 'Fonction&s';
                Image = "Action";
                action("E&xplode BOM")
                {
                    AccessByPermission = TableData "BOM Component" = R;
                    CaptionML = ENU = 'E&xplode BOM',
                                ESP = '&Desplegar L.M.',
                                FRA = '&Eclater nomenclature';
                    Image = ExplodeBOM;
                    ToolTip = 'Executes the E&xplode BOM action.';

                    trigger OnAction();
                    begin
                        ExplodeBOM();
                    end;
                }
                action("Insert Ext. Texts")
                {
                    AccessByPermission = TableData "Extended Text Header" = R;
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Insert &Ext. Text',
                                ESP = 'Insertar t&extos adicionales',
                                FRA = 'Insérer te&xtes étendus';
                    Image = Text;
                    ToolTipML = ENU = 'Insert the extended item description that is set up for the item on the purchase document line.',
                                ESP = 'Permite insertar la descripción de producto ampliada que se ha configurado para el producto en la línea del documento de compra.',
                                FRA = 'Insérez la description plus longue qui est paramétrée pour l''article sur la ligne document achat.';

                    trigger OnAction();
                    begin
                        InsertExtendedText(true);
                    end;
                }
                action(Reserve)
                {
                    CaptionML = ENU = '&Reserve',
                                ESP = '&Reserva',
                                FRA = '&Réserver';
                    Ellipsis = true;
                    Image = Reserve;
                    ToolTip = 'Executes the Reserve action.';

                    trigger OnAction();
                    begin
                        Rec.FIND();
                        Rec.ShowReservation();
                    end;
                }
                action(OrderTracking)
                {
                    CaptionML = ENU = 'Order &Tracking',
                                ESP = '&Seguimiento pedido',
                                FRA = 'C&haînage';
                    Image = OrderTracking;
                    ToolTip = 'Executes the OrderTracking action.';

                    trigger OnAction();
                    begin
                        ShowTracking();
                    end;
                }
                action(GetBlanketOrderPrice)
                {
                    Caption = 'Get Blanket Order Price';
                    Image = Price;
                    ToolTip = 'Executes the Get Blanket Order Price action.';

                    trigger OnAction();
                    begin
                        //HEI.04>>
                        if CONFIRM(GetBlanketOrderPriceQst) then
                            Rec.GetBlanketOrderPrice();
                        //HEI.04<<
                    end;
                }
            }
            group("O&rder")
            {
                CaptionML = ENU = 'O&rder',
                            ESP = '&Pedido',
                            FRA = '&Commande';
                Image = "Order";
                group("Dr&op Shipment")
                {
                    CaptionML = ENU = 'Dr&op Shipment',
                                ESP = 'Enví&o directo',
                                FRA = 'Livraison &directe';
                    Image = Delivery;
                    action("Sales &Order")
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Sales &Order',
                                    ESP = 'Pedido &venta',
                                    FRA = 'Commande &vente';
                        Image = Document;
                        ToolTip = 'Executes the Sales &Order action.';

                        trigger OnAction();
                        begin
                            OpenSalesOrderForm();
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    CaptionML = ENU = 'Speci&al Order',
                                ESP = '&Pedido especial',
                                FRA = 'C&ommande spéciale';
                    Image = SpecialOrder;
                    action(Action1901038504)
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        CaptionML = ENU = 'Sales &Order',
                                    ESP = 'Pedido &venta',
                                    FRA = 'Commande &vente';
                        Image = Document;
                        ToolTip = 'Executes the Action1901038504 action.';

                        trigger OnAction();
                        begin
                            OpenSpecOrderSalesOrderForm();
                        end;
                    }
                }

                //BC UPGRADE PATHAA02-DIT>>
                // action("Quality Tests")
                // {
                //     CaptionML = ENU = 'Quality Tests',
                //                 FRA = 'Testes qualité';

                //     trigger OnAction();
                //     begin
                //         // <<DITW15.00.00.38 PRODW14.00.00.17 DDR 08/02/2011 #1271
                //         //This functionality was copied from page #50. Unsupported part was commented. Please check it.
                //         /*CurrPage.PurchLines.PAGE.*/
                //         _ShowQualityTests();

                //     end;
                // }
                //BC UPGRADE PATHAA02-DIT<<
                action(BlanketOrder)
                {
                    CaptionML = ENU = 'Blanket Order',
                                ESP = 'Pedido abierto',
                                FRA = 'Commande ouverte';
                    Image = BlanketOrder;
                    ToolTipML = ENU = 'View the blanket purchase order.',
                                ESP = 'Permite ver el pedido de compra abierto.',
                                FRA = 'Affichez la commande ouverte achat.';

                    trigger OnAction();
                    var
                        PurchaseHeader: Record "Purchase Header";
                        BlanketPurchaseOrder: Page "Blanket Purchase Order";
                    begin
                        Rec.TESTFIELD(Rec."Blanket Order No.");
                        PurchaseHeader.SETRANGE("No.", Rec."Blanket Order No.");
                        if not PurchaseHeader.ISEMPTY then begin
                            BlanketPurchaseOrder.SETTABLEVIEW(PurchaseHeader);
                            BlanketPurchaseOrder.EDITABLE := false;
                            BlanketPurchaseOrder.RUN();
                        end;
                    end;
                }
                //BC UPGRADE PATHAA02-DIT>>
                // action(Action2035090)
                // {
                //     CaptionML = ENU = 'Quality Tests',
                //                 FRA = 'Tests qualité';

                //     trigger OnAction();
                //     begin
                //         //<<QXL9.00.001 DAT 23/03/2016
                //         ShowQualityTests();
                //         //>>QXL9.00.001 DAT 23/03/2016
                //     end;
                // } //BC UPGRADE PATHAA02-DIT<<
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        //BC UPGRADE PATHAA02-DIT>>
        // // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        // Rec.SETFILTER("Resp. Center Table Filter",
        //   UserMgt.GetRespCenterFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // SETFILTER("Phys. Location Table Filter",
        //   UserMgt.GetRespPhysLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // SETFILTER("Location Table Filter",
        //   UserMgt.GetRespLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // // >>DITW18.00.06 DDR DIT-770 #1191

        // // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        // SetFilterSubContractPostType();
        // // >>DITW16.00.00.41 AHU DIT-715 #327
        //BC UPGRADE PATHAA02-DIT<<

        UpdateEditableOnRow();
        if PurchHeader.GET(Rec."Document Type", Rec."Document No.") then;

        DocumentTotals.PurchaseUpdateTotalsControls(Rec, TotalPurchaseHeader, TotalPurchaseLine, RefreshMessageEnabled,
          TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, VATAmount);

        //BC UPGRADE PATHAA02-DIT>>
        // // <<DITW15.00.00.01 DDR 18/12/2007
        // // VIGEO VS 29-12-2005: Toeslag regels mogen niet worden gewijzigd. Dit moet op het hoofdartikel worden gedaan.
        // UpdateFields();
        // // >>DITW15.00.00.01 DDR 18/12/2007
        //BC UPGRADE PATHAA02-DIT<<
    end;

    trigger OnAfterGetRecord();
    begin
        //BC UPGRADE PATHAA02-DIT>>
        // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        // IndentLine := IndentRecordDIT(ExpandLines);
        // // >>DITW17.10.03 DDR DIT-770 #541
        //BC UPGRADE PATHAA02-DIT<<

        Rec.ShowShortcutDimCode(ShortcutDimCode);

        //BC UPGRADE PATHAA02-DIT>>
        // // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
        // ShowShortcutUomValue(ShortcutQtyUomValue);
        // // >>DITW16.00.00.40 DDR DIT-715 #244
        //BC UPGRADE PATHAA02-DIT<<

        //TypeChosen := HasTypeToFillMandatotyFields; //BC UPGRADE PATHAA02
        TypeChosen := TotalPurchaseLine.HasTypeToFillMandatoryFields(); //BC UPGRADE PATHAA02
        CLEAR(DocumentTotals);

        //PATHAA02 07.11.2017>>
        if Rec.Type <> Rec.Type::Item then
            EditableDesc := true
        else
            EditableDesc := false;
        //PATHAA02 07.11.2017<<

        //HEI0.1 NAIKH01
        Type1 := Rec.Type.AsInteger();
    end;

    trigger OnDeleteRecord(): Boolean;
    var
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
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
    end;

    trigger OnFindRecord(Which: Text): Boolean;
    begin
        //BC UPGRADE PATHAA02-DIT>>
        // // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        // if DisabledRefreshLines then
        //     exit(false);
        // // >>DITW16.00.00.40 DDR DIT-715 #197

        // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        // //EXIT(FIND(Which));
        // exit(FindRecordDIT(Which, ExpandLines));
        // // >>DITW17.10.03 DDR DIT-770 #541
        //BC UPGRADE PATHAA02-DIT<<
    end;

    trigger OnInit();
    begin
        //BC UPGRADE PATHAA02-DIT>>
        // <<DITW15.00.00.01 DDR 18/12/2007
        // "Line AmountEnable" := true;
        // "Unit Price (LCY)Enable" := true;
        // QuantityEnable := true;
        // "No.Enable" := true;
        // TypeEnable := true;
        // "Qty. to InvoiceEditable" := true;
        // "Qty. to ReceiveEditable" := true;

        //HEI.06>>
        //"Line AmountEditable" := TRUE;
        "Line AmountEditable" := false;
        //HEI.06<<

        // "Direct Unit CostEditable" := true;
        // QuantityEditable := true;
        // "Cross-Reference No.Editable" := true;
        // "No.Editable" := true;
        // TypeEditable := true;
        // // >>DITW15.00.00.01 DDR 18/12/2007


        // // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        // GlobalTax1ValueEditable := true;
        // GlobalTax2ValueEditable := true;
        // // >>DITW19.00.08 DDR BL#10443
        //BC UPGRADE PATHAA02-DIT<<
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        // if ApplicationAreaSetup.IsFoundationEnabled then //BC UPGRADE PATHAA02-Commented as func not found in T9178
        //     Rec.Type := Rec.Type::Item;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        //BC PATHAA02-DIT>>
        // // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
        // IndentLine := 0;
        // if not ISEMPTY then
        //     InitLineNo(ExpandLines, BelowxRec);
        // // >>DITW17.10.03 DDR DIT-770 #541
        //BC PATHAA02-DIT<<

        // if ApplicationAreaSetup.IsFoundationEnabled then
        //     Rec.Type := Rec.Type::Item
        // else
        //     Rec.InitType; //BC UPGRADE PATHAA02-Commented as func not found in T9178
        CLEAR(ShortcutDimCode);

        //BC UPGRADE PATHAA02-DIT>>
        // // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        // SetFilterSubContractPostType2();
        // // >>DITW16.00.00.41 AHU DIT-715 #327
        //BC UPGRADE PATHAA02-DIT<<
    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    begin
        //BC UPGRADE PATHAA02-DIT>>
        // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        // exit(NextRecordDIT(Steps, ExpandLines));
        // // >>DITW17.10.03 DDR DIT-770 #541
        //BC UPGRADE PATHAA02-DIT<<
    end;

    trigger OnOpenPage();
    begin
        //BC UPGRADE PATHAA02-DIT>>
        // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        // ExpandLines := false;
        // ShowButtonsCE := IsShowButtonsCEDIT();
        // // >>DITW17.10.03 DDR DIT-770 #541
        //BC UPGRADE PATHAA02-DIT<<
    end;

    var
        TotalPurchaseHeader: Record "Purchase Header";
        TotalPurchaseLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        ApplicationAreaSetup: Record "Application Area Setup";
        TransferExtendedText: Codeunit "Transfer Extended Text";

        // BC Upgrade PATES08 >> # Replaced with 'PurchAvailabilityMgt'
        // ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        //  BC Upgrade PATELS08 <<
        Text001: TextConst ENU = 'You cannot use the Explode BOM function because a prepayment of the purchase order has been invoiced.', ESP = 'No puede usar la función Desplegar L.M. puesto que se ha facturado un prepago del pedido de compra.', FRA = 'Vous ne pouvez pas utiliser la fonction Éclater nomenclature car un acompte de la commande achat a été facturé.';
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        DocumentTotals: Codeunit "Document Totals";
        ShortcutDimCode: array[8] of Code[20];
        VATAmount: Decimal;
        InvDiscAmountEditable: Boolean;
        TotalAmountStyle: Text;
        RefreshMessageEnabled: Boolean;
        RefreshMessageText: Text;
        TypeChosen: Boolean;
        UnitofMeasureCodeIsChangeable: Boolean;
        UpdateInvDiscountQst: TextConst ENU = 'One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?', ESP = 'Se han facturado una o varias líneas. No se tendrá en cuenta el descuento distribuido entre las líneas facturadas.\\¿Desea actualizar el descuento en factura?', FRA = 'Une ou plusieurs lignes ont été facturées. La remise répartie sur les lignes facturées n''est pas prise en compte.\\Voulez-vous mettre à jour la remise facture ?';
        xRecRef: RecordRef;
        //cduAppMgt: Codeunit ApplicationManagement; //BC UPGRADE PATHAA02 CU1 not found in BC
        // QualitySetup: Record "Quality Setup"; //BC UPGRADE PATHAA02 T2035095
        //QualityManagement: Codeunit "Quality Management"; //BC UPGRADE PATHAA02 CU2035090
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Direct Unit Cost', FRA = 'Total coût unitaire directe';
        Text2014260: TextConst ENU = 'There are no valid lines to use this function.', FRA = 'Il n''a pas de lignes valide pour utiliser cette fonction';
        DisabledRefreshLines: Boolean;
        ShortcutQtyUomValue: array[3] of Decimal;

        TypeEditable: Boolean;

        "No.Editable": Boolean;

        "Cross-Reference No.Editable": Boolean;

        QuantityEditable: Boolean;

        "Direct Unit CostEditable": Boolean;

        "Line AmountEditable": Boolean;

        "Qty. to ReceiveEditable": Boolean;

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

        GlobalTax1ValueEditable: Boolean;

        GlobalTax2ValueEditable: Boolean;
        EditableDesc: Boolean;
        GetBlanketOrderPriceQst: Label 'Do you want to get the blanket order price?';
        Item: Record Item;
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        Err001: Label 'The Field "Item Category Code" in the Item Card page for Item "%1" must be Equal to "%2"';
        Type1: Option " ",,Item;
        // BC Upgrade PATELS08 >> # 'ShowItemAvailFromPurchLine' in codeunit "Item Availability Forms Mgt." is marked for removal, there by the replacement PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine()
        PurchAvailabilityMgt: Codeunit "Purch. Availability Mgt.";
    // BC Upgrade PATELS08 <<

    procedure ApproveCalcInvDisc();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    local procedure ExplodeBOM();
    begin
        if Rec."Prepmt. Amt. Inv." <> 0 then
            ERROR(Text001);
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;

    local procedure OpenSalesOrderForm();
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        Rec.TESTFIELD("Sales Order No.");
        SalesHeader.SETRANGE("No.", Rec."Sales Order No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := false;
        SalesOrder.RUN();
    end;

    local procedure InsertExtendedText(Unconditionally: Boolean);
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SAVERECORD();
            TransferExtendedText.InsertPurchExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate() then
            UpdateForm(true);
    end;

    procedure ShowTracking();
    var
        TrackingForm: Page "Order Tracking";
    begin
        // BC Upgrade PATELS08 >> # 'SetPurchLine' is marked for removal, replaced with SetVariantRec. 
        // TrackingForm.SetPurchLine(Rec);
        TrackingForm.SetVariantRec(
            Rec,
            Rec."No.",
            Rec."Outstanding Qty. (Base)",
            Rec."Expected Receipt Date",
            Rec."Expected Receipt Date"
        );
        // BC Upgrade PATELS08 <<
        TrackingForm.RUNMODAL();
    end;

    local procedure OpenSpecOrderSalesOrderForm();
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        Rec.TESTFIELD(Rec."Special Order Sales No.");
        SalesHeader.SETRANGE("No.", Rec."Special Order Sales No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := false;
        SalesOrder.RUN();
    end;

    procedure UpdateForm(SetSaveRecord: Boolean);
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    local procedure NoOnAfterValidate();
    begin
        UpdateEditableOnRow();
        //BC UPGRADE PATHAA02-DIT>>
        // // <<DITW15.00.00.35 DDR 29/06/2009 - DITW15.00.00.38 DDR 15/03/2011 #1291
        // if (Type <> Type::Item) and not "Is Item Charge" then
        //     // >>DITW15.00.00.35 DDR - DITW15.00.00.38 DDR #1291
        //BC UPGRADE PATHAA02-DIT<<

        InsertExtendedText(false);
        if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and
           (xRec."No." <> '')
        then
            CurrPage.SAVERECORD();

        //BC UPGRADE PATHAA02-DIT>>
        // // <<DITW15.00.00.23 DDR 30/07/2008
        // CurrPage.UPDATE;
        // // >>DITW15.00.00.23 DDR
        //BC UPGRADE PATHAA02-DIT<<
    end;

    //BC UPGRADE PATHAA02-DIT>>
    // local procedure CrossReferenceNoOnAfterValidat();
    // begin
    //     // <<DITW15.00.00.38 DDR 27/01/2011 #1259
    //     //InsertExtendedText(FALSE);
    //     CurrPage.UPDATE;
    //     // >>DITW15.00.00.38 DDR #1259
    // end;
    //BC UPGRADE PATHAA02-DIT<<

    local procedure RedistributeTotalsOnAfterValidate();
    begin
        CurrPage.SAVERECORD();

        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        if DocumentTotals.PurchaseCheckNumberOfLinesLimit(PurchHeader) then
            DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
        CurrPage.UPDATE();
    end;

    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
        CurrPage.SAVERECORD();
    end;

    local procedure UpdateEditableOnRow();
    begin
        //BC UPGRADE PATHAA02>>
        //UnitofMeasureCodeIsChangeable := CanEditUnitOfMeasureCode();
        UnitofMeasureCodeIsChangeable := TotalPurchaseLine.CanEditUnitOfMeasureCode();
        //BC UPGRADE PATHAA02<<
    end;

    //BC UPGRADE PATHAA02-DIT>>

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
    //     //HEI.06>>
    //     //"Line AmountEditable" := FormEditableField(FIELDNO("Line Amount")) AND NOT CollapsedLine;
    //     //HEI.06<<

    //     "Qty. to ReceiveEditable" := FormEditableField(FIELDNO("Qty. to Receive"));
    //     "Qty. to InvoiceEditable" := FormEditableField(FIELDNO("Qty. to Invoice"));

    //     // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    //     TypeEnable := FormEditableField(FIELDNO(Type));
    //     "No.Enable" := FormEditableField(FIELDNO("No."));
    //     QuantityEnable := FormEditableField(FIELDNO(Quantity));
    //     "Unit Price (LCY)Enable" := FormEditableField(FIELDNO("Unit Price (LCY)"));
    //     "Line AmountEnable" := FormEditableField(FIELDNO("Line Amount"));
    //     // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1

    //     // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    //     GlobalTax1ValueEditable := HasTaxSpecEditable("Strength Spec. Code");
    //     GlobalTax2ValueEditable := HasTaxSpecEditable("Vol-Strength Spec. Code");
    //     // >>DITW19.00.08 DDR BL#10443
    // end;


    // procedure _ShowGetARCNoEDI();
    // var
    //     SelectedPurchLines: Record "Purchase Line";
    //     NewARCNo: Code[30];
    //     NewText: Text[1024];
    // begin
    //     // <<DITW15.00.00.38 DDR 30/09/2010 #1217
    //     CLEAR(SelectedPurchLines);
    //     CurrPage.SETSELECTIONFILTER(SelectedPurchLines);
    //     SelectedPurchLines.SETFILTER("No.", '<>%1', '');
    //     SelectedPurchLines.SETRANGE(Rec."ARC No. Mandatory", true);//BC F2014267
    //     if SelectedPurchLines.FINDSET then begin
    //         repeat
    //             SelectedPurchLines.TESTFIELD(Rec."ARC No.", '');
    //         until SelectedPurchLines.NEXT = 0;
    //     end else
    //         ERROR(Text2014260);

    //     // <<DITW15.00.00.38 DDR 17/12/2010 #703
    //     if SelectedPurchLines.EDILookupExtTrackingARC(NewText) then begin
    //         NewARCNo := NewText;
    //         if SelectedPurchLines.FINDSET(true, false) then
    //             repeat
    //                 SelectedPurchLines.VALIDATE(Rec."ARC No.", NewARCNo);//BC F2014262
    //                 SelectedPurchLines.MODIFY(true);
    //             until SelectedPurchLines.NEXT = 0;
    //         Rec := SelectedPurchLines;
    //         CurrPage.UPDATE(false);
    //     end;
    // end;


    // procedure ShowGetARCNoEDI();
    // var
    //     SelectedPurchLines: Record "Purchase Line";
    //     NewARCNo: Code[30];
    //     NewText: Text[1024];
    // begin
    //     // <<DITW15.00.00.38 DDR 30/09/2010 #1217
    //     CLEAR(SelectedPurchLines);
    //     CurrPage.SETSELECTIONFILTER(SelectedPurchLines);
    //     SelectedPurchLines.SETFILTER("No.", '<>%1', '');
    //     SelectedPurchLines.SETRANGE("ARC No. Mandatory", true);
    //     if SelectedPurchLines.FINDSET then begin
    //         repeat
    //             SelectedPurchLines.TESTFIELD("ARC No.", '');
    //         until SelectedPurchLines.NEXT = 0;
    //     end else
    //         ERROR(Text2014260);

    //     // <<DITW15.00.00.38 DDR 17/12/2010 #703
    //     if SelectedPurchLines.EDILookupExtTrackingARC(NewText) then begin
    //         NewARCNo := NewText;
    //         if SelectedPurchLines.FINDSET(true, false) then
    //             repeat
    //                 SelectedPurchLines.VALIDATE("ARC No.", NewARCNo);
    //                 SelectedPurchLines.MODIFY(true);
    //             until SelectedPurchLines.NEXT = 0;
    //         Rec := SelectedPurchLines;
    //         CurrPage.UPDATE(false);
    //     end;
    // end;

    // procedure _ShowQualityTests();
    // var
    //     QualityTestHeader: Record "Quality Test Header";
    // begin
    //     // <<DITW15.00.00.38 PRODW14.00.00.17 DDR 08/02/2011 #1271
    //     QualityTestHeader.SETCURRENTKEY(
    //       "Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
    //     QualityTestHeader.FILTERGROUP(2);
    //     QualityTestHeader.SETRANGE("Source ID", "Document No.");
    //     QualityTestHeader.SETRANGE("Source Type", DATABASE::"Purchase Line");
    //     QualityTestHeader.SETRANGE("Source Subtype", "Document Type");
    //     QualityTestHeader.SETRANGE("Source Ref. No.", "Line No.");
    //     QualityTestHeader.FILTERGROUP(0);
    //     QualityTestHeader.SETRANGE("Item No.", "No."); //BC T2035096
    //     PAGE.RUNMODAL(0, QualityTestHeader);
    // end;

    // procedure ShowQualityTests();
    // var
    //     QualityTestHeader: Record "Quality Test Header";
    // begin
    //     //<<QXL9.00.001 DAT 23/03/2016
    //     QualityTestHeader.SETCURRENTKEY(
    //       "Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
    //     QualityTestHeader.FILTERGROUP(2);
    //     QualityTestHeader.SETRANGE("Source ID", "Document No.");
    //     QualityTestHeader.SETRANGE("Source Type", DATABASE::"Purchase Line");
    //     QualityTestHeader.SETRANGE("Source Subtype", "Document Type");
    //     QualityTestHeader.SETRANGE("Source Ref. No.", "Line No.");
    //     QualityTestHeader.FILTERGROUP(0);
    //     QualityTestHeader.SETRANGE("Item No.", "No.");
    //     PAGE.RUNMODAL(0, QualityTestHeader);
    //     //>>QXL9.00.001 DAT 23/03/2016
    // end;

    // procedure _OpenSSCCTrackingLines();
    // begin
    //     // <<DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745
    //     Rec.OpenSSCCTrackingLines();
    // end;

    // procedure OpenSSCCTrackingLines();
    // begin
    //     // <<DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745
    //     Rec.OpenSSCCTrackingLines();
    // end;
    //BC UPGRADE PATHAA02-DIT<<

    procedure TriggerOnDeleteRecord(): Boolean;
    var
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        TempRec: Record "Purchase Line" temporary;
    begin
        // cronus
        if (Rec.Quantity <> 0) and Rec.ItemExists(Rec."No.") then begin
            COMMIT();
            if not ReservePurchLine.DeleteLineConfirm(Rec) then
                exit(false);

            //BC UPGRADE PATHAA02-DIT>>
            // // <<QXL9.00.001 DAT 23/03/2016
            // if QualitySetup.READPERMISSION then begin
            //     if not QualityManagement.DeletePurchLineConfirm(Rec) then
            //         exit(false);
            // end;
            // // >>QXL9.00.001 DAT 23/03/2016
            //BC UPGRADE PATHAA02-DIT<<

            ReservePurchLine.DeleteLine(Rec);

            //BC UPGRADE PATHAA02-DIT>>
            // // <<QXL9.00.001 DAT 23/03/2016
            // if QualitySetup.READPERMISSION then
            //     QualityManagement.DeletePurchLine(Rec);
            // // >>QXL9.00.001 DAT 23/03/2016
            //BC UPGRADE PATHAA02-DIT<<
        end;

        //BC UPGRADE PATHAA02-DIT>>
        // // <<DITW15.00.00.36 DDR 23/11/2009
        // if "Is Item Charge" and "ItemCharge Incl. Price" then begin
        //     DELETE(true);
        //     TempRec := Rec;
        //     TempRec."Direct Unit Cost" := 0;
        //     TempRec."Line Amount" := 0;
        //     TempRec."Line Discount Amount" := 0;
        //     //<< DITW110.00.11 DDR 10/08/2017 NRQ#24875
        //     TempRec.CalcBackDirectCostItem();
        //     //>> DITW110.00.11 DDR 10/08/2017 NRQ#24875
        //     exit(false);
        // end;
        // // >>DITW15.00.00.36 DDR
        //BC UPGRADE PATHAA02-DIT<<
        exit(true);
    end;

    //BC UPGRADE PATHAA02-DIT>>
    // procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
    // begin
    //     // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    //     DisabledRefreshLines := NewDisabledRefreshLines;
    // end;

    // procedure _AllItemsAvailability(AvailabilityType: Option Date2,Date3);
    // begin
    //     // <<DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338
    //     Rec.AllItemsAvailability(AvailabilityType);
    // end;

    // procedure AllItemsAvailability(AvailabilityType: Option Date2,Date3);
    // begin
    //     // <<DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338
    //     Rec.AllItemsAvailability(AvailabilityType);
    // end;

    // local procedure TypeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 15/01/2008
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

    // local procedure Prepayment37OnAfterValidate();
    // begin
    //     // <<DITW15.00.00.23 DDR 11/08/2008
    //     if (Type = Type::Item) and
    //        ("Prepayment %" <> xRec."Prepayment %")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.23 DDR
    // end;

    // local procedure PrepmtLineAmountOnAfterValidat();
    // begin
    //     // <<DITW15.00.00.23 DDR 11/08/2008
    //     if (Type = Type::Item) and
    //        ("Prepmt. Line Amount" <> xRec."Prepmt. Line Amount")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.23 DDR
    // end;

    // local procedure QtytoReceiveOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Qty. to Receive" <> xRec."Qty. to Receive")
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

    // local procedure PrepmtAmttoDeductOnAfterValida();
    // begin
    //     // <<DITW15.00.00.23 DDR 11/08/2008
    //     if (Type = Type::Item) and
    //        ("Prepmt Amt to Deduct" <> xRec."Prepmt Amt to Deduct")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.23 DDR
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
    //BC UPGRADE PATHAA02-DIT<<

    local procedure AllowVATCalculationFreeOnAfter();
    begin
        CurrPage.UPDATE(true);
    end;

    //BC UPGRADE PATHAA02-DIT>>
    // local procedure FreeItemPostingTypeOnAfterVali();
    // begin
    //     // <<DITW15.00.00.35 DDR 25/06/2009
    //     if Type = Type::Item then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.35 DDR
    // end;

    // local procedure FreeReasoncodeOnAfterValidate();
    // begin
    //     // <<DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692
    //     if (Type = Type::Item) and
    //        (xRec."Free Reason Code" <> "Free Reason Code")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692
    // end;
    //BC UPGRADE PATHAA02-DIT<<
}

