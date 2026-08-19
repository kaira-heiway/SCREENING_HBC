page 51046 "Blanket Purch.Ord Subform2 CBN"
{
    // version HEI.06

    // DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
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
    //                     21/08/2009 issue 727 Added HorzAlign property in field "Direct Unit Cost"
    //                     23/10/2009 issue 893 Removed fields "Gen. Prod. Posting Free Group"
    // DITW15.00.00.36 DDR 04/11/2009 issue 939 Performance SQL
    //                                Added function FormTotalingField()
    // DITW15.00.00.37 DDR 26/01/2009 issue 939 Performance SQL error call function into OnModify() trigger
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
    //                                               "AAD No.","ARC No.","SAD No."
    //                     15/03/2011 issue 1291 Modified trigger field "No." activate function InsertExtendedText() other than items
    //                     16/03/2011 issue 1217 (DIT711 161) Added field "Packaging Type Code"
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade Added/Review Total Line Amount (Collapsed RTC)
    //                     26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)"
    //                     11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  Added function SetDisableRefreshLines() to call before/after each report object
    //                                                 (don't use the <RunObject> property)
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0014.1
    //                             added approved fields
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.03 DDR 10/06/2014 DIT-770 #541 Modified 'QuickEntry' property fields "Has Item Charge","Collapse"
    //                                          Removed 'IndentationControls' field1 Group Repeater
    // DITW17.10.03 DDR 10/07/2014 DIT-770 #541 Added editable other types than Item
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added field "Responsibity Center","Physical Location Group Code"
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Direct Unit Cost"
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackDirectCostItem()
    // NRQ175506 NLAB 03/11/2021 Added DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix (Correctice Change no - CHG2102694)
    // 
    // HEI.01 HLSRM02 IBM LAZARE02 27.07.2017
    //   # New fields for SRM integration
    //   # New action Prices for SRM integration
    //   # New action Notes for SRM integration
    // 
    // HEI.02 HLSRM02 IBM LAZARE02 12.10.2017
    //   # Set all fields (except Consumption Location Code, Qty. to Receive, Direct Unit Cost) as non editable
    // 
    // HEI.03 IBM PATHAA02 07.11.17
    //  # Making Description noneditable only for Line Type=Item
    // 
    // HEI.05 CHG2042112 HB945 SHANKJ03 02.05.2020
    //   # Editable property of quantity changed to false
    // 
    // HEI.06 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //   # SPL Code, SPL Name, Consumption SPL Code - fields created

    // BC Upgrade SHUKLP03 >> Added in the interface ext.
    // HEI.01 HLSRM02 IBM LAZARE02 27.07.2017
    //   # New fields for SRM integration
    //   # New action Prices for SRM integration
    //   # New action Notes for SRM integration
    // BC Upgrade SHUKLP03 << Added in the interface ext.

    // BC Upgrade PATELS08 >>
    // # Declared a global variablie 'PurchAvailabilityMgt'.
    // # 'ShowItemAvailFromPurchLine' and ByEvent(), ByPeriod(), ByVariant(), ByLocation(), ByBOM() is marked for removal, replaced with 'ShowItemAvailabilityFromPurchLine' and enum "Item Availability Type" repectively. Replacedment done in Actions : Event, Period, Variant, Location, BOM Level.
    // # Blocked Global Variable 'ItemAvailFormsMgt' Replaced with 'PurchAvailabilityMgt'
    // BC Upgrade PATELS08 <<


    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = where("Document Type" = FILTER("Blanket Order"));
    ApplicationArea = ALL; //BC Upgrade Priya <<

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                //BC Upgrade Priya >> DrinkIT fields are blocked.
                // field("Has Item Charge"; "Has Item Charge")
                // {
                //     BlankZero = true;
                //     Editable = BlanketOrderEditable;
                //     QuickEntry = false;
                // }
                // field(Collapse; Rec.Collapse)
                // {
                //     Editable = BlanketOrderEditable;
                //     QuickEntry = false;
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         // <<DITW15.00.00.37 DDR 19/01/2010
                //         CurrPage.UPDATE(true);
                //         // >>DITW15.00.00.37 DDR
                //     end;
                // }
                //BC Upgrade Priya << DrinkIT fields are blocked.
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the line''s number.';
                }
                field(Type; Rec.Type)
                {
                    Editable = true;//BC Upgrade SHARMP16
                    // Enabled = TypeEnable;//BC Upgrade SHARMP16
                    ToolTip = 'Specifies the line type.';

                    trigger OnValidate();
                    begin
                        TypeOnAfterValidate();
                        NoOnAfterValidate();

                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("No."; Rec."No.")
                {
                    Editable = true;//BC Upgrade SHARMP16
                    ToolTip = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.';

                    trigger OnValidate();
                    begin
                        //BC Upgrade Priya >> DrinkIT code is blocked.
                        // // <<DITW17.10.03 DDR 10/06/2014 DIT-770 #541
                        // if not ("No.Editable" or "No.Enable") then begin
                        //     Rec."No." := xRec."No.";
                        //     exit;
                        // end;
                        // // >>DITW17.10.03 DDR DIT-770 #541
                        //BC Upgrade Priya << DrinkIT function is blocked.
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate();

                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate();
                    end;
                }
                //BC Upgrade Priya >> DrinkIT field is blocked.
                // field("Cross-Reference No."; Rec."Cross-Reference No.")
                // {
                //     Editable = BlanketOrderEditable;
                //     Visible = false;

                //     trigger OnLookup(Text: Text): Boolean;
                //     begin
                //         CrossReferenceNoLookUp;
                //         // <<DITW15.00.00.38 DDR 27/01/2011 #1259
                //         //InsertExtendedText(FALSE);
                //         CurrPage.UPDATE;
                //         // >>DITW15.00.00.38 DDR #1259
                //     end;

                //     trigger OnValidate();
                //     begin
                //         CrossReferenceNoOnAfterValidat;
                //     end;
                // }
                //BC Upgrade Priya << DrinkIT field is blocked.
                field("Variant Code"; Rec."Variant Code")
                {
                    Editable = true;//BC Upgrade SHARMP16
                    Visible = false;
                    ToolTip = 'Specifies a variant code for the item.';

                    trigger OnValidate();
                    begin
                        VariantCodeOnAfterValidate();
                    end;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Editable = true;//BC Upgrade SHARMP16
                    Visible = false;
                    ToolTip = 'Specifies the code for the VAT product posting group of the item or general ledger account on this line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                // BC Upgrade Priya >> DrinkIT field is blocked. DrinkIT Replaced "Empty Goods Item No." -> Column "Tracking Item No."
                // field("GetTrackingItemNo()"; GetTrackingItemNo())
                // {
                //     Caption = 'Tracking Item No. (Item Charge)';
                //     DrillDownPageID = "Item List";
                //     Editable = false;
                //     LookupPageID = "Item List";
                //     TableRelation = IF ("Item Charge Type" = CONST(Tax)) Item where("No." = FIELD("Tax Item No."))
                //     else IF ("Item Charge Type" = CONST(Deposit)) Item where("No." = FIELD("Empty Goods Item No."));
                //     Visible = false;

                //     trigger OnLookup(Text: Text): Boolean;
                //     begin
                //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
                //         Text := GetTrackingItemNo();
                //         LookupItemNo(Text);
                //         exit(false);
                //     end;
                // } BC Upgrade Priya << DrinkIT field is blocked. DrinkIT Replaced "Empty Goods Item No." -> Column "Tracking Item No."
                field(Description; Rec.Description)
                {
                    Editable = true;//BC Upgrade SHARMP16
                    // Enabled = EditableDesc;//BC Upgrade SHARMP16
                    ToolTip = 'Specifies a description of the item or service on the line.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = true;//BC Upgrade SHARMP16
                    Visible = false;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';

                    trigger OnValidate();
                    begin
                        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        if Rec."Responsibility Center" <> xRec."Responsibility Center" then
                            CurrPage.UPDATE(true);
                        // >>DITW18.00.06 DDR DIT-770 #1191
                    end;
                }
                //BC Upgrade Priya << DrinkIT field is blocked.
                // field("Physical Location Group Code"; Rec."Physical Location Group Code")
                // {
                //     Editable = BlanketOrderEditable;
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                //         if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                //             CurrPage.UPDATE(true);
                //         // >>DITW18.00.06 DDR DIT-770 #1191
                //     end;
                // } BC Upgrade Priya << DrinkIT field is blocked.
                field("Location Code"; Rec."Location Code")
                {
                    Editable = true;//BC Upgrade SHARMP16
                    ToolTip = 'Specifies the code for the location where the items on the line will be located.';

                    trigger OnValidate();
                    begin
                        LocationCodeOnAfterValidate();
                        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        if xRec."Location Code" <> Rec."Location Code" then
                            CurrPage.UPDATE(true);
                        // >>DITW18.00.06 DDR DIT-770 #1191
                    end;
                }
                field("Initial Quantity"; Rec."Initial Quantity FND")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Initial Quantity field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Editable = false;
                    //  Enabled = QuantityEnable;//BC Upgrade SHARMP16
                    ToolTip = 'Specifies the number of units of the item that will be specified on the line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        QuantityOnAfterValidate();
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = true;//BC Upgrade SHARMP16
                    ToolTip = 'Specifies the unit of measure code that is valid for the purchase line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        UnitofMeasureCodeOnAfterValida();
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = true;//BC Upgrade SHARMP16
                    Visible = false;
                    ToolTip = 'Specifies the name of the unit of measure for the item, such as 1 bottle or 1 piece.';
                }
                field("Consumption Location Code"; Rec."Consumption Location Code FND")
                {
                    ToolTip = 'Specifies the value of the Consumption Location Code field.';
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    BlankZero = true;
                    ToolTip = 'Specifies the quantity of items that remains to be received.';

                    trigger OnValidate();
                    begin
                        QtytoReceiveOnAfterValidate();
                    end;
                }
                field("Qty. to Return"; Rec."Qty. to Return FND")
                {
                    BlankZero = true;
                    ToolTip = 'Specifies the value of the Qty. to Return field.';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    BlankZero = true;
                    Editable = "Direct Unit CostEditable";
                    ToolTip = 'Specifies the direct cost of one item unit.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        DirectUnitCostOnAfterValidate();
                    end;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    Editable = true;//BC Upgrade SHARMP16
                    Visible = false;
                    ToolTip = 'Specifies the item''s indirect cost percentage.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Editable = true;//BC Upgrade SHARMP16
                    Visible = false;
                    ToolTip = 'Specifies the unit cost of the item on the line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    Editable = true;
                    //  Enabled = "Unit Price (LCY)Enable";//BC Upgrade SHARMP16
                    Visible = false;
                    ToolTip = 'Specifies the price for one unit of the item.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    Editable = true;
                    //  Enabled = "Line AmountEnable";//BC Upgrade SHARMP16
                    ToolTip = 'Specifies the net amount (before subtracting the invoice discount amount) that must be paid for the items on the line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        LineAmountOnAfterValidate();
                    end;
                }
                //BC Upgrade Priya << DinkIT fields are blocked.
                // field("Approved Line Amount"; Rec."Approved Line Amount")
                // {
                //     Description = 'DITW17.00.02 DIT-770 #144';
                //     Editable = BlanketOrderEditable;
                //     Visible = false;
                // }
                // field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Direct Unit Cost"), true))
                // {
                //     AutoFormatExpression = "Currency Code";
                //     AutoFormatType = 2;
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassVar(PageText2014411);
                //     Caption = 'Total Direct Unit Cost';
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
                //     Caption = 'Total Line Amount';
                //     Description = 'DITW17.10.02B DIT-770 #541';
                //     Editable = false;
                //     QuickEntry = false;
                // } //BC Upgrade Priya << DinkIT fields are blocked.
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                    Editable = true;//BC Upgrade SHARMP16
                    ToolTip = 'Specifies the line discount percentage that is valid for the item on the line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        LineDiscount37OnAfterValidate();
                    end;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Editable = true;//BC Upgrade SHARMP16
                    Visible = false;
                    ToolTip = 'Specifies the amount of the line discount that will be granted on the purchase line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        LineDiscountAmountOnAfterValid();
                    end;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Editable = true;//BC Upgrade SHARMP16
                    Visible = false;
                    ToolTip = 'Specifies whether the invoice line is included when the invoice discount is calculated.';
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    BlankZero = true;
                    ToolTip = 'Specifies how many units of the item on the line have been posted as received.';
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    BlankZero = true;
                    ToolTip = 'Specifies how many units of the item on the line have been posted as invoiced.';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Editable = true;//BC Upgrade SHARMP16
                    Visible = false;
                    ToolTip = 'Specifies the date you expect the items to be available in your warehouse.';
                }
                //BC Upgrade Priya >> DinkIT fields are blocked.
                // field("AAD No."; Rec."AAD No.")
                // {
                //     Editable = BlanketOrderEditable;
                //     Visible = false;
                // }
                // field("ARC No."; Rec."ARC No.")
                // {
                //     Description = 'DITW15.00.00.38 #1217';
                //     Editable = BlanketOrderEditable;
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
                //     Editable = BlanketOrderEditable;
                //     Visible = false;
                // }
                // field("Packaging Type Code"; Rec."Packaging Type Code")
                // {
                //     Editable = BlanketOrderEditable;
                //     Visible = false;
                // }
                // field("Free Item"; Rec."Free Item")
                // {
                //     Editable = BlanketOrderEditable;

                //     trigger OnValidate();
                //     begin
                //         FreeItemOnAfterValidate;
                //     end;
                // }
                // field("Allow VAT Calculation (Free)"; Rec."Allow VAT Calculation (Free)")
                // {
                //     Description = 'DITW16.00.00.40 DIT-715 #172';
                //     Editable = BlanketOrderEditable;
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         AllowVATCalculationFreeOnAfter;
                //     end;
                // }
                // field("Free Item Posting Type"; Rec."Free Item Posting Type")
                // {
                //     Editable = BlanketOrderEditable;
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         FreeItemPostingTypeOnAfterVali;
                //     end;
                // }
                // field("Linked Customer No."; Rec."Linked Customer No.")
                // {
                //     Editable = BlanketOrderEditable;
                //     Visible = false;
                // } //BC Upgrade Priya << DinkIT fields are blocked.
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = true;//BC Upgrade SHARMP16
                    Visible = false;
                    ToolTip = 'Specifies the dimension value code linked to the purchase.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = true;//BC Upgrade SHARMP16
                    Visible = false;
                    ToolTip = 'Specifies the dimension value code linked to the purchase.';
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    HideValue = true;//BC Upgrade SHARMP16
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(3),
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
                    Editable = true;//BC Upgrade SHARMP16
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(4),
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
                    Editable = true;//BC Upgrade SHARMP16
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(5),
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
                    Editable = true;//BC Upgrade SHARMP16
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(6),
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
                    Editable = true;//BC Upgrade SHARMP16
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(7),
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
                    Editable = true;//BC Upgrade SHARMP16
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(8),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[8] field.';

                    trigger OnValidate();
                    begin
                        ValidateSaveShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                //BC Upgrade Priya >> DinkIT fields are blocked.
                // field("GetTotalingLine(1,FIELDNO(""Line Amount""),true)"; GetTotalingLine(1, FIELDNO("Line Amount"), true))
                // {
                //     AutoFormatExpression = "Currency Code";
                //     AutoFormatType = 1;
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassVar(PageText2014410);
                //     Caption = 'Total Line Amount';
                //     Description = 'DITW16.00.00.37';
                //     Editable = false;
                //     Visible = false;
                // }
                // field("App. Prod. Posting Group"; "App. Prod. Posting Group")
                // {
                //     Description = 'DITW17.00.02 DIT-770 #144';
                //     Editable = BlanketOrderEditable;
                //     Visible = false;
                // }
                // field("Contract Type"; Rec."Contract Type")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
                // {
                //     Editable = BlanketOrderEditable;
                //     Visible = false;
                // }
                // field("Contract Group Code"; Rec."Contract Group Code")
                // {
                //     Editable = BlanketOrderEditable;
                //     Visible = false;
                // }
                // field("Service Contract No."; Rec."Service Contract No.")
                // {
                //     Editable = BlanketOrderEditable;
                //     Visible = false;
                // }
                // field("Financial Contract No."; Rec."Financial Contract No.")
                // {
                //     Editable = BlanketOrderEditable;
                //     Visible = false;
                // } //BC Upgrade Priya << DinkIT fields are blocked.
                field("SRM Contract No."; Rec."SRM Contract No. FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the SRM Contract No. field.';
                }
                field("SRM Contract Line No."; Rec."SRM Contract Line No. FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the SRM Contract Line No. field.';
                }
                field("SRM Contract Type"; Rec."SRM Contract Type FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the SRM Contract Type field.';
                }
                field("Valid From"; Rec."Valid From FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Valid From field.';
                }
                field("Valid To"; Rec."Valid To FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Valid To field.';
                }
                field("Type ID"; Rec."Type ID FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Type ID field.';
                }
                field("Block Line Ordering"; Rec."Block Line Ordering FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Block Line Ordering field.';
                }
                field("Delivery Finalized"; Rec."Delivery Finalized FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Delivery Finalized field.';
                }
                field("Tolerance Received Over %"; Rec."Tolerance Received Over % FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Tolerance Received Over % field.';
                }
                field("Tolerance Received Under %"; Rec."Tolerance Received Under % FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Tolerance Received Under % field.';
                }
                field("SPL Code"; Rec."SPL Code FND")
                {
                    ToolTip = 'Specifies the value of the SPL Code field.';
                }
                field("SPL Name"; Rec."SPL Name FND")
                {
                    ToolTip = 'Specifies the value of the SPL Name field.';
                }
                field("Consumption SPL Code"; Rec."Consumption SPL Code FND")
                {
                    ToolTip = 'Specifies the value of the Consumption SPL Code field.';
                }
            }
            group(Control37)
            {
                ShowCaption = false;
                group(Control33)
                {
                    ShowCaption = false;
                    field("Invoice Discount Amount"; TotalPurchaseLine."Inv. Discount Amount")
                    {
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        Caption = 'Invoice Discount Amount';
                        Editable = true;//BC Upgrade SHARMP16
                        Style = Subordinate;
                        //   StyleExpr = RefreshMessageEnabled;//BC Upgrade SHARMP16
                        ToolTip = 'Specifies the invoice discount amount for the line.';

                        trigger OnValidate();
                        var
                            PurchaseHeader: Record "Purchase Header";
                        begin
                            PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
                            PurchCalcDiscByType.ApplyInvDiscBasedOnAmt(TotalPurchaseLine."Inv. Discount Amount", PurchaseHeader);
                            CurrPage.UPDATE(false);
                        end;
                    }
                    field("Invoice Disc. Pct."; PurchCalcDiscByType.GetVendInvoiceDiscountPct(Rec))
                    {
                        Caption = 'Invoice Discount %';
                        DecimalPlaces = 0 : 2;
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        ToolTip = 'Specifies the value of the Invoice Discount % field.';
                    }
                }
                group(Control15)
                {
                    ShowCaption = false;
                    field("Total Amount Excl. VAT"; TotalPurchaseLine.Amount)
                    {
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(PurchHeader."Currency Code");
                        Caption = 'Total Amount Excl. VAT';
                        DrillDown = false;
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        ToolTip = 'Specifies the sum of amounts in the Line Amount field on the purchase order lines.';
                    }
                    field("Total VAT Amount"; VATAmount)
                    {
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalVATCaption(PurchHeader."Currency Code");
                        Caption = 'Total VAT';
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        ToolTip = 'Specifies the value of the Total VAT field.';
                    }
                    field("Total Amount Incl. VAT"; TotalPurchaseLine."Amount Including VAT")
                    {
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(PurchHeader."Currency Code");
                        Caption = 'Total Amount Incl. VAT';
                        Editable = false;
                        StyleExpr = TotalAmountStyle;
                        ToolTip = 'Specifies the value of the Total Amount Incl. VAT field.';
                    }
                    field(RefreshTotals; RefreshMessageText)
                    {
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
                Caption = '+ Expand';
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
                    //BC Upgrade Priya << DinkIT code is blocked.
                    // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                    // ExpandLines := true;
                    // CurrPage.UPDATE(true);
                    // // >>DITW17.10.03 DDR DIT-770 #541
                    //BC Upgrade Priya << DinkIT code is blocked.
                end;
            }
            action("- Collapse")
            {
                Caption = '- Collapse';
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
                    //BC Upgrade Priya >> DinkIT code is blocked.
                    // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                    // ExpandLines := false;
                    // CurrPage.UPDATE(true);
                    // // >>DITW17.10.03 DDR DIT-770 #541
                    //BC Upgrade Priya << DinkIT code is blocked.
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("E&xplode BOM")
                {
                    AccessByPermission = TableData "BOM Component" = R;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    ToolTip = 'Executes the E&xplode BOM action.';

                    trigger OnAction();
                    begin
                        ExplodeBOM();
                    end;
                }
                action("Insert &Ext. Texts")
                {
                    AccessByPermission = TableData "Extended Text Header" = R;
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;
                    ToolTip = 'Executes the Insert &Ext. Texts action.';

                    trigger OnAction();
                    begin
                        InsertExtendedText(true);
                    end;
                }
                action("Insert Item Char&ges")
                {
                    Caption = 'Insert Item Char&ges';
                    ShortCutKey = 'Ctrl+Y';
                    ToolTip = 'Executes the Insert Item Char&ges action.';

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #509. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        _InsertExtendedCharges(true);

                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;

                    action("Event")
                    {
                        Caption = 'Event';
                        Image = "Event";
                        ToolTip = 'Executes the Event action.';

                        trigger OnAction();
                        begin
                            // BC Upgrade PATELS08 >> # 'ShowItemAvailFromPurchLine' and 'ByEvent()' is marked for removal, replaced with 'ShowItemAvailabilityFromPurchLine' and enum "Item Availability Type" repectively.
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent());
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::"Event");
                            // BC Upgrade PATELS08 <<
                        end;
                    }
                    action(Period)
                    {
                        Caption = 'Period';
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
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ToolTip = 'Executes the Variant action.';

                        trigger OnAction();
                        begin
                            // BC Upgrade PATELS08 >> # 'ShowItemAvailFromPurchLine' and 'ByVariant()' is marked for removal, replaced with 'ShowItemAvailabilityFromPurchLine' and enum "Item Availability Type" repectively.
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant());
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Variant);
                            // BC Upgrade PATELS08 <<
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData Location = R;
                        Caption = 'Location';
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
                    action("BOM Level")
                    {
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        ToolTip = 'Executes the BOM Level action.';

                        trigger OnAction();
                        begin
                            // BC Upgrade PATELS08 >> # 'ShowItemAvailFromPurchLine' and 'ByBOM()' is marked for removal, replaced with 'ShowItemAvailabilityFromPurchLine' and enum "Item Availability Type" repectively.
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM());
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::BOM);
                            // BC Upgrade PATELS08 <<
                        end;
                    }
                }
                group("Unposted Lines")
                {
                    Caption = 'Unposted Lines';
                    Image = "Order";
                    action(Orders)
                    {
                        Caption = 'Orders';
                        Image = Document;
                        ToolTip = 'Executes the Orders action.';

                        trigger OnAction();
                        begin
                            ShowOrders();
                        end;
                    }
                    action(Invoices)
                    {
                        Caption = 'Invoices';
                        Image = Invoice;
                        ToolTip = 'Executes the Invoices action.';

                        trigger OnAction();
                        begin
                            ShowInvoices();
                        end;
                    }
                    action("Return Orders")
                    {
                        AccessByPermission = TableData "Return Shipment Header" = R;
                        Caption = 'Return Orders';
                        Image = ReturnOrder;
                        ToolTip = 'Executes the Return Orders action.';

                        trigger OnAction();
                        begin
                            ShowReturnOrders();
                        end;
                    }
                    action("Credit Memos")
                    {
                        Caption = 'Credit Memos';
                        Image = CreditMemo;
                        ToolTip = 'Executes the Credit Memos action.';

                        trigger OnAction();
                        begin
                            ShowCreditMemos();
                        end;
                    }
                }
                group("Posted Lines")
                {
                    Caption = 'Posted Lines';
                    Image = Post;
                    action(Receipts)
                    {
                        Caption = 'Receipts';
                        Image = PostedReceipts;
                        ToolTip = 'Executes the Receipts action.';

                        trigger OnAction();
                        begin
                            ShowPostedReceipts();
                        end;
                    }
                    action(Action1904522204)
                    {
                        Caption = 'Invoices';
                        Image = Invoice;
                        ToolTip = 'Executes the Invoices action.';

                        trigger OnAction();
                        begin
                            ShowPostedInvoices();
                        end;
                    }
                    action("Return Receipts")
                    {
                        Caption = 'Return Receipts';
                        Image = ReturnReceipt;
                        ToolTip = 'Executes the Return Receipts action.';

                        trigger OnAction();
                        begin
                            ShowPostedReturnReceipts();
                        end;
                    }
                    action(Action1902056104)
                    {
                        Caption = 'Credit Memos';
                        Image = CreditMemo;
                        ToolTip = 'Executes the Credit Memos action.';

                        trigger OnAction();
                        begin
                            ShowPostedCreditMemos();
                        end;
                    }
                    action("Page Purchase Line Prices")
                    {
                        Caption = 'Prices';
                        ApplicationArea = All;
                        Image = Price;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        RunObject = Page "Purchase Line Prices CBN";
                    }
                }

                // BC Upgrade SHUKLP03 >> Added in the interface extension
                // action(Prices)
                // {
                //     Caption = 'Prices';
                //     Image = Price;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     RunObject = Page "Purchase Line Prices";
                //     RunPageLink = "Document Type" = FIELD("Document Type"),
                //                   "Document No." = FIELD("Document No."),
                //                   "Document Line No." = FIELD("Line No.");
                //     ToolTip = 'Executes the Prices action.';
                // }
                // BC Upgrade SHUKLP03 << Added in the interface extension

                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction();
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ToolTip = 'Executes the Co&mments action.';

                    trigger OnAction();
                    begin
                        Rec.ShowLineComments();
                    end;
                }
                // BC Upgrade SHUKLP03 >> Added in the interface extension
                // action(Notes)
                // {
                //     Caption = 'Notes';
                //     Image = Notes;
                //     RunObject = Page "Purchase Line Notes";
                //     RunPageLink = "Document Type" = FIELD("Document Type"),
                //                   "Document No." = FIELD("Document No."),
                //                   "Line No." = FIELD("Line No.");
                //     ToolTip = 'Executes the Notes action.';
                // }
                // BC Upgrade SHUKLP03 << Added in the interface extension

            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        //BC Upgrade Priya >> DinkIT code is blocked.
        // // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        // SETFILTER("Resp. Center Table Filter",
        //   UserMgt.GetRespCenterFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // SETFILTER("Phys. Location Table Filter",
        //   UserMgt.GetRespPhysLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // SETFILTER("Location Table Filter",
        //   UserMgt.GetRespLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // // >>DITW18.00.06 DDR DIT-770 #1191
        //BC Upgrade Priya << DinkIT code is blocked.

        if PurchHeader.GET(Rec."Document Type", Rec."Document No.") then;

        DocumentTotals.PurchaseUpdateTotalsControls(Rec, TotalPurchaseHeader, TotalPurchaseLine, RefreshMessageEnabled,
          TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, VATAmount);

        //BC Upgrade Priya >> DinkIT code is blocked.
        // // <<DITW15.00.00.01 DDR 18/12/2007
        // // VIGEO VS 29-12-2005: Toeslag regels mogen niet worden gewijzigd. Dit moet op het hoofdartikel worden gedaan.
        // UpdateFields();
        // // >>DITW15.00.00.01 DDR 18/12/2007
        //BC Upgrade Priya << DinkIT code is blocked.
    end;

    trigger OnAfterGetRecord();
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        CLEAR(DocumentTotals);

        //PATHAA02 07.11.2017>>
        if Rec.Type <> Rec.Type::Item then
            EditableDesc := true
        else
            EditableDesc := false;
        //PATHAA02 07.11.2017<<
    end;

    trigger OnDeleteRecord(): Boolean;
    var
        TempRec: Record "Purchase Line" temporary;
    begin
        // <<DITW16.00.00.37 DDR 20/07/2010
        // Move to function TriggerOnDeleteRecord() to solve RTC Collapse delete records
        // Temporary until next Mirosoft release
        exit(TriggerOnDeleteRecord());
    end;
    //BC Upgrade SHARMP16 Begin<<
    // trigger OnFindRecord(Which: Text): Boolean;
    // begin
    //     //BC Upgrade Priya >> DinkIT code is blocked.
    //     // // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    //     // if DisabledRefreshLines then
    //     //     exit(false);
    //     // // >>DITW16.00.00.40 DDR DIT-715 #197
    //     // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //     // exit(FindRecordDIT(Which, ExpandLines));
    //     // // >>DITW17.10.03 DDR DIT-770 #541
    //     //BC Upgrade Priya << DinkIT code is blocked.
    // end;

    // trigger OnInit();
    // begin
    //     //BC Upgrade Priya >> DinkIT code is blocked.
    //     // // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    //     // "Line AmountEnable" := true;
    //     // "Unit Price (LCY)Enable" := true;
    //     // QuantityEnable := true;
    //     // "No.Enable" := true;
    //     // TypeEnable := true;
    //     // "Line AmountEditable" := true;
    //     // "Direct Unit CostEditable" := true;
    //     // QuantityEditable := true;
    //     // "Cross-Reference No.Editable" := true;
    //     // "No.Editable" := true;
    //     // TypeEditable := true;
    //     // // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    //     //BC Upgrade Priya << DinkIT code is blocked.
    // end;
    //BC Upgrade SHARMP16 END>>
    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        //BC Upgrade Priya >> DinkIT code is blocked.
        // // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
        // IndentLine := 0;
        // if not ISEMPTY then
        //     InitLineNo(ExpandLines, BelowxRec);
        // // >>DITW17.10.03 DDR DIT-770 #541
        //BC Upgrade Priya << DinkIT code is blocked.

        Rec.InitType();
        CLEAR(ShortcutDimCode);
    end;
    //BC Upgrade SHARMP16 Begin<<
    // trigger OnNextRecord(Steps: Integer): Integer;
    // begin
    //     //BC Upgrade Priya >> DinkIT code is blocked.
    //     // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //     // exit(NextRecordDIT(Steps, ExpandLines));
    //     // // >>DITW17.10.03 DDR DIT-770 #541
    //     //BC Upgrade Priya << DinkIT code is blocked.
    // end;
    //BC Upgrade SHARMP16 END>>
    trigger OnOpenPage();
    begin
        //BC Upgrade Priya >> DinkIT code is blocked.
        // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        // ExpandLines := false;
        // ShowButtonsCE := IsShowButtonsCEDIT();
        // // >>DITW17.10.03 DDR DIT-770 #541
        //BC Upgrade Priya << DinkIT code is blocked.

        //HEI.02>>
        //BlanketOrderEditable := InterfaceFrameworkMgt.CheckPermissionSet(USERID, '', true); //BC Upgrade Priya >> Interface part needs to be blocked.
        //HEI.02<<
    end;

    var
        PurchHeader: Record "Purchase Header";
        TotalPurchaseHeader: Record "Purchase Header";
        CurrentPurchLine: Record "Purchase Line";
        PurchLine: Record "Purchase Line";
        TotalPurchaseLine: Record "Purchase Line";
        DocumentTotals: Codeunit "Document Totals";

        // BC Upgrade PATES08 >> # Replaced with 'PurchAvailabilityMgt'
        // ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        //  BC Upgrade PATELS08 <<
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        UserMgt: Codeunit "User Setup Management";
        xRecRef: RecordRef;
        // InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt."; //BC Upgrade Priya >> "Interface Framework Mgt." codeunit is blocked.
        BlanketOrderEditable: Boolean;

        "Cross-Reference No.Editable": Boolean;

        "Direct Unit CostEditable": Boolean;
        DisabledRefreshLines: Boolean;
        EditableDesc: Boolean;

        ExpandLines: Boolean;
        InvDiscAmountEditable: Boolean;

        "Line AmountEditable": Boolean;

        "Line AmountEnable": Boolean;

        "No.Editable": Boolean;

        "No.Enable": Boolean;

        QuantityEditable: Boolean;

        QuantityEnable: Boolean;
        RefreshMessageEnabled: Boolean;

        ShowButtonsCE: Boolean;

        TypeEditable: Boolean;

        TypeEnable: Boolean;

        "Unit Price (LCY)Enable": Boolean;
        ShortcutDimCode: array[8] of Code[20];
        VATAmount: Decimal;
        IndentLine: Integer;
        //cduAppMgt: Codeunit ApplicationManagement;
        PageText2014410: Label 'Total Line Amount';
        PageText2014411: Label 'Total Direct Unit Cost';
        RefreshMessageText: Text;
        TotalAmountStyle: Text;
        // BC Upgrade PATELS08 >> # 'ShowItemAvailFromPurchLine' in codeunit "Item Availability Forms Mgt." is marked for removal, there by the replacement PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine()
        PurchAvailabilityMgt: Codeunit "Purch. Availability Mgt.";
    // BC Upgrade PATELS08 <<

    procedure ApproveCalcInvDisc();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    local procedure ExplodeBOM();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
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

    procedure UpdateForm(SetSaveRecord: Boolean);
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    local procedure ShowOrders();
    begin
        CurrentPurchLine := Rec;
        PurchLine.RESET();
        PurchLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        // <<DITW16.00.00.37 DIT-715 #1
        PurchLine.FILTERGROUP(4);
        // >>DITW16.00.00.37 DIT-715 #1
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        // <<DITW16.00.00.37 DIT-715 #1
        PurchLine.FILTERGROUP(0);
        // >>DITW16.00.00.37 DIT-715 #1
        PAGE.RUNMODAL(PAGE::"Purchase Lines", PurchLine);
    end;

    local procedure ShowInvoices();
    begin
        CurrentPurchLine := Rec;
        PurchLine.RESET();
        PurchLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        // <<DITW16.00.00.37 DIT-715 #1
        PurchLine.FILTERGROUP(4);
        // >>DITW16.00.00.37 DIT-715 #1
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Invoice);
        PurchLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        // <<DITW16.00.00.37 DIT-715 #1
        PurchLine.FILTERGROUP(0);
        // >>DITW16.00.00.37 DIT-715 #1
        PAGE.RUNMODAL(PAGE::"Purchase Lines", PurchLine);
    end;

    local procedure ShowReturnOrders();
    begin
        CurrentPurchLine := Rec;
        PurchLine.RESET();
        PurchLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        // <<DITW16.00.00.37 DIT-715 #1
        PurchLine.FILTERGROUP(4);
        // >>DITW16.00.00.37 DIT-715 #1
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::"Return Order");
        PurchLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        // <<DITW16.00.00.37 DIT-715 #1
        PurchLine.FILTERGROUP(0);
        // >>DITW16.00.00.37 DIT-715 #1
        PAGE.RUNMODAL(PAGE::"Purchase Lines", PurchLine);
    end;

    local procedure ShowCreditMemos();
    begin
        CurrentPurchLine := Rec;
        PurchLine.RESET();
        PurchLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        // <<DITW16.00.00.37 DIT-715 #1
        PurchLine.FILTERGROUP(4);
        // >>DITW16.00.00.37 DIT-715 #1
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::"Credit Memo");
        PurchLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        // <<DITW16.00.00.37 DIT-715 #1
        PurchLine.FILTERGROUP(0);
        // >>DITW16.00.00.37 DIT-715 #1
        PAGE.RUNMODAL(PAGE::"Purchase Lines", PurchLine);
    end;

    local procedure ShowPostedReceipts();
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        CurrentPurchLine := Rec;
        PurchRcptLine.RESET();
        PurchRcptLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        //BC Upgrade Priya >> DinkIT code is blocked.
        // // <<DITW16.00.00.37 DIT-715 #1
        // PurchRcptLine.FILTERGROUP(4);
        // // >>DITW16.00.00.37 DIT-715 #1
        //BC Upgrade Priya << DinkIT code is blocked.
        PurchRcptLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchRcptLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        //BC Upgrade Priya >> DinkIT code is blocked.
        // // <<DITW16.00.00.37 DIT-715 #1
        // PurchRcptLine.FILTERGROUP(0);
        // // >>DITW16.00.00.37 DIT-715 #1
        //BC Upgrade Priya << DinkIT code is blocked.
        PAGE.RUNMODAL(PAGE::"Posted Purchase Receipt Lines", PurchRcptLine);
    end;

    local procedure ShowPostedInvoices();
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        CurrentPurchLine := Rec;
        PurchInvLine.RESET();
        PurchInvLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        //BC Upgrade Priya >> DinkIT code is blocked.
        // // <<DITW16.00.00.37 DIT-715 #1
        // PurchInvLine.FILTERGROUP(4);
        // // >>DITW16.00.00.37 DIT-715 #1
        //BC Upgrade Priya << DinkIT code is blocked.
        PurchInvLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchInvLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        //BC Upgrade Priya >> DinkIT code is blocked.
        // // <<DITW16.00.00.37 DIT-715 #1
        // PurchInvLine.FILTERGROUP(0);
        // // >>DITW16.00.00.37 DIT-715 #1
        //BC Upgrade Priya << DinkIT code is blocked.
        PAGE.RUNMODAL(PAGE::"Posted Purchase Invoice Lines", PurchInvLine);
    end;

    local procedure ShowPostedReturnReceipts();
    var
        ReturnShptLine: Record "Return Shipment Line";
    begin
        CurrentPurchLine := Rec;
        ReturnShptLine.RESET();
        ReturnShptLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        //BC Upgrade Priya >> DinkIT code is blocked.
        // // <<DITW16.00.00.37 DIT-715 #1
        // ReturnShptLine.FILTERGROUP(4);
        // // >>DITW16.00.00.37 DIT-715 #1
        //BC Upgrade Priya << DinkIT code is blocked.
        ReturnShptLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        ReturnShptLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        //BC Upgrade Priya >> DinkIT code is blocked.
        // // <<DITW16.00.00.37 DIT-715 #1
        // ReturnShptLine.FILTERGROUP(0);
        // // >>DITW16.00.00.37 DIT-715 #1
        //BC Upgrade Priya << DinkIT code is blocked.
        PAGE.RUNMODAL(PAGE::"Posted Return Shipment Lines", ReturnShptLine);
    end;

    local procedure ShowPostedCreditMemos();
    var
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
    begin
        CurrentPurchLine := Rec;
        PurchCrMemoLine.RESET();
        PurchCrMemoLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        //BC Upgrade Priya >> DinkIT code is blocked.
        // // <<DITW16.00.00.37 DIT-715 #1
        // PurchCrMemoLine.FILTERGROUP(4);
        // // >>DITW16.00.00.37 DIT-715 #1
        //BC Upgrade Priya << DinkIT code is blocked.
        PurchCrMemoLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchCrMemoLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        //BC Upgrade Priya >> DinkIT code is blocked.
        // // <<DITW16.00.00.37 DIT-715 #1
        // PurchCrMemoLine.FILTERGROUP(0);
        // // >>DITW16.00.00.37 DIT-715 #1
        //BC Upgrade Priya << DinkIT code is blocked.
        PAGE.RUNMODAL(PAGE::"Posted Purchase Cr. Memo Lines", PurchCrMemoLine);
    end;

    local procedure NoOnAfterValidate();
    begin
        //BC Upgrade Priya >> DinkIT code is blocked.
        // // <<DITW15.00.00.36 DDR 25/11/2009 - DITW15.00.00.38 DDR 15/03/2011 #1291
        // if (Type <> Type::Item) and not "Is Item Charge" then
        //     // >>DITW15.00.00.36 DDR - DITW15.00.00.38 DDR #1291
        InsertExtendedText(false);

        // // <<DITW15.00.00.01 DDR 18/12/2007 - DITW15.00.00.23 DDR 30/07/2008
        // CurrPage.UPDATE;
        // // >>DITW15.00.00.23 DDR
        //BC Upgrade Priya << DinkIT code is blocked.
    end;

    //BC Upgrade Priya >> DinkIT code is blocked.
    // local procedure CrossReferenceNoOnAfterValidat();
    // begin
    //     // <<DITW15.00.00.38 DDR 27/01/2011 #1259
    //     //InsertExtendedText(FALSE);
    //     CurrPage.UPDATE;
    //     // >>DITW15.00.00.38 DDR #1259
    // end;
    //BC Upgrade Priya << DinkIT code is blocked.

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

    procedure _InsertExtendedCharges(FromHeader: Boolean);
    begin
        //BC Upgrade Priya >> DinkIT code is blocked.
        // // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
        // if InsertChargeLines(FromHeader) then
        //     UpdateForm(true);
        // // >>DITW15.00.00.23 DDR
        //BC Upgrade Priya << DinkIT code is blocked.
    end;

    //BC Upgrade Priya >> DinkIT code is blocked.
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

    //     // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    //     TypeEnable := FormEditableField(FIELDNO(Type));
    //     "No.Enable" := FormEditableField(FIELDNO("No."));
    //     QuantityEnable := FormEditableField(FIELDNO(Quantity));
    //     "Unit Price (LCY)Enable" := FormEditableField(FIELDNO("Unit Price (LCY)"));
    //     "Line AmountEnable" := FormEditableField(FIELDNO("Line Amount"));
    //     // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    // end;
    //BC Upgrade Priya << DinkIT code is blocked.

    local procedure TriggerOnDeleteRecord(): Boolean;
    var
        TempRec: Record "Purchase Line" temporary;
    begin
        // DITW16.00.00.37 DDR 20/07/2010 (moved trigger bugfix RTC collapse page)
        // cronus
        if (Rec.Quantity <> 0) and Rec.ItemExists(Rec."No.") then begin
            COMMIT();
        end;
        //BC Upgrade Priya >> DinkIT code is blocked.
        // <<DITW15.00.00.36 DDR 23/11/2009
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
        //BC Upgrade Priya << DinkIT code is blocked.
        exit(true);
    end;
    //BC Upgrade Priya >> DinkIT code is blocked.
    // procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
    // begin
    //     // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    //     DisabledRefreshLines := NewDisabledRefreshLines;
    // end;
    //BC Upgrade Priya << DrinkIT code is blocked.
    local procedure TypeOnAfterValidate();
    begin
        //BC Upgrade Priya >> DrinkIT code is blocked.
        //     // <<DITW15.00.00.01 DDR 15/01/2008
        //     if Type <> xRec.Type then
        //         CurrPage.UPDATE;
        //     // >>DITW15.00.00.01 DDR
        //BC Upgrade Priya << DrinkIT code is blocked.
    end;

    local procedure VariantCodeOnAfterValidate();
    begin
        //BC Upgrade Priya >> DrinkIT code is blocked.
        //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
        //     if (Type = Type::Item) and
        //        (xRec."Variant Code" <> "Variant Code")
        //     then
        //         CurrPage.UPDATE(true);
        //     // >>DITW15.00.00.01 DDR
        //BC Upgrade Priya << DrinkIT code is blocked.
    end;


    local procedure LocationCodeOnAfterValidate();
    var
        UpdateIsDone: Boolean;
    begin
        //BC Upgrade Priya >> DrinkIT code is blocked.
        //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
        //     if (Type = Type::Item) and
        //        not UpdateIsDone
        //     then
        //         CurrPage.UPDATE(true);
        //     // >>DITW15.00.00.01 DDR
        //BC Upgrade Priya << DrinkIT code is blocked.
    end;

    local procedure QuantityOnAfterValidate();
    var
        UpdateIsDone: Boolean;
    begin
        //BC Upgrade Priya >> DrinkIT code is blocked.
        //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
        //     if (Type = Type::Item) and
        //        (Quantity <> xRec.Quantity) and
        //        not UpdateIsDone
        //     then
        //         CurrPage.UPDATE(true);
        //     // >>DITW15.00.00.01 DDR
        //BC Upgrade Priya << DrinkIT code is blocked.
    end;

    local procedure UnitofMeasureCodeOnAfterValida();
    var
        UpdateIsDone: Boolean;
    begin
        //BC Upgrade Priya >> DrinkIT code is blocked.
        //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
        //     if (Type = Type::Item) and
        //        not UpdateIsDone
        //     then
        //         CurrPage.UPDATE(true);
        //     // >>DITW15.00.00.01 DDR
        //BC Upgrade Priya << DrinkIT code is blocked.
    end;

    local procedure DirectUnitCostOnAfterValidate();
    begin
        //BC Upgrade Priya >> DrinkIT code is blocked.
        //     // <<DITW15.00.00.01 DDR 21/12/2007
        //     if (Type = Type::Item) and
        //        ("Direct Unit Cost" <> xRec."Direct Unit Cost")
        //     then
        //         CurrPage.UPDATE(true);
        //     // >>DITW15.00.00.01 DDR
        //BC Upgrade Priya << DrinkIT code is blocked.
    end;

    local procedure LineAmountOnAfterValidate();
    begin
        //BC Upgrade Priya >> DrinkIT code is blocked.
        //     // <<DITW15.00.00.01 DDR 21/12/2007
        //     if (Type = Type::Item) and
        //        ("Line Amount" <> xRec."Line Amount")
        //     then
        //         CurrPage.UPDATE(true);
        //     // >>DITW15.00.00.01 DDR
        //BC Upgrade Priya << DrinkIT code is blocked.
    end;

    local procedure LineDiscount37OnAfterValidate();
    begin
        //BC Upgrade Priya >> DrinkIT code is blocked.  
        //     // <<DITW15.00.00.01 DDR 21/12/2007
        //     if (Type = Type::Item) and
        //        ("Line Discount %" <> xRec."Line Discount %")
        //     then
        //         CurrPage.UPDATE(true);
        //     // >>DITW15.00.00.01 DDR
        //BC Upgrade Priya << DrinkIT code is blocked.
    end;

    local procedure LineDiscountAmountOnAfterValid();
    begin
        //BC Upgrade Priya >> DinkIT code is blocked.
        //     // <<DITW15.00.00.01 DDR 21/12/2007
        //     if (Type = Type::Item) and
        //        ("Line Discount Amount" <> xRec."Line Discount Amount")
        //     then
        //         CurrPage.UPDATE(true);
        //     // >>DITW15.00.00.01 DDR
        //BC Upgrade Priya << DinkIT code is blocked.
    end;

    local procedure QtytoReceiveOnAfterValidate();
    begin
        //BC Upgrade Priya >> DinkIT code is blocked.
        //     // <<DITW15.00.00.01 DDR 21/12/2007
        //     if (Type = Type::Item) and
        //        ("Qty. to Receive" <> xRec."Qty. to Receive")
        //     then
        //         CurrPage.UPDATE(true);
        //     // >>DITW15.00.00.01 DDR
        //BC Upgrade Priya << DinkIT code is blocked.
    end;

    local procedure FreeItemOnAfterValidate();
    begin
        //BC Upgrade Priya >> DrinkIT code is blocked.
        //     // <<DITW15.00.00.35 DDR 25/06/2009
        //     if (Type = Type::Item) and
        //        (xRec."Free Item" <> "Free Item")
        //     then
        //         CurrPage.UPDATE(true);
        //     // >>DITW15.00.00.35 DDR
        //BC Upgrade Priya << DinkIT code is blocked.
    end;


    local procedure AllowVATCalculationFreeOnAfter();
    begin
        CurrPage.UPDATE(true);
    end;

    //BC Upgrade Priya >> DinkIT code is blocked.
    // local procedure FreeItemPostingTypeOnAfterVali();
    // begin
    //     // <<DITW15.00.00.35 DDR 25/06/2009
    //     if Type = Type::Item then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.35 DDR
    // end;
    //BC Upgrade Priya << DinkIT code is blocked.
}

