page 51059 "POPrepayment Req Subform CBN"
{
    // version NAVW110.0.00.16177,FINXL9.00.000.01,MANXL7.00.001

    // DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Tax Item Charges functionnalities
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
    // DITW15.00.00.21 DDR 18/06/2008 added fields "Weight","Cubage" (not editable)
    // DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    // DITW15.00.00.23 DDR 29/07/2008 Remove call function InsertExtendedCharges() from trigger OnAfterValidate field "No."
    //                                Updated function into InsertExtendedCharges()
    //                     31/07/2008 Move NewRecord() function into OnNewRecord trigger
    //                     11/08/2008 Added UpdateFormatField() and Refresh for fields
    //                                  "Prepayment %","Prepmt. Line Amount","Prepmt. Amt. Inv.",
    //                                  "Prepmt Amt to Deduct","Prepmt Amt Deducted"
    //                                Update function UpdateFormatField() to show decimals
    // DITW15.00.00.25 DDR 17/10/2008 Added fields
    //                                  "Shipping Agent Code","Shipping Agent Service Code"
    // DITW15.00.00.28 DDR 24/11/2008 Added fields
    //                                  "AAD No." (editable)
    // DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
    //                                  "Empty Goods Item No."
    // DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //                     29/06/2009 Disabled standard call function InsertExtendedText() into Trigger field "No."
    //                     21/08/2009 issue 727 Added HorzAlign property in field "Direct Unit Cost"
    //                 DLE 06/09/2009 issue 516 Added field "Physical Location Group Code"
    //                 DDR 14/10/2009 issue 893 Removed fields "Gen. Prod. Posting Free Group"
    // DITW15.00.00.36 DDR 04/11/2009 issue 939 Performance SQL
    //                                Added function FormTotalingField()
    // DITW15.00.00.37 DDR 26/01/2009 issue 939 Performance SQL error call function into OnModify() trigger
    //                     02/06/2010 issue 1061 Added default Not visible fields "Physical Location Group Code"
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 23/06/2010 issue 1151 Added to remove Quarantine Quality test when delete purchase line
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    //                     10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    "LRN No.","ARC No.","SAD No."
    //                                  Hidden fields
    //                                    "AAD No."
    //                     17/09/2010   Remove field "LRN No."
    //                     30/09/2010   Added lookup field "ARC No."
    //                                  Added function ShowGetARCNoEDI()
    //                     17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    //                                          Added fields "Tax Item No."
    //                     27/01/2011 issue 1259 Added update() on field "Cross-Reference No."
    //                                           Added non-editable when item is (free) item charge
    // DITW15.00.00.38 PRODW14.00.00.17 DDR 08/02/2011 issue 1271
    //                                           Added function ShowQualityTests()
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
    //                     15/03/2011 issue 1291 Modified trigger field "No." activate function InsertExtendedText() other than items
    //                     16/03/2011 issue 1217 (DIT711 161) Added field "Packaging Type Code"
    // DITW15.00.00.39 DDR 11/07/2011 issue 1369 Added fields "Applies-to AAD Trck. Entry No."
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade Added/Review Total Line Amount (Collapsed RTC)
    // DITW15.00.00.39 PRODW14.00.00.08.18 DDR 18/08/2011 issue 1410
    //                                           Show all Quality tests, Removed source item ledger entry in flowfield
    //                     22/08/2011 issue 1399 Added fields "Whse. Shipment No. (Open)"
    //                     26/08/2011 issue 1393 Added AssistEdit property/trigger for field "Item No."
    //                     26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)"
    //                     11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  Added function SetDisableRefreshLines() to call before/after each report object
    //                                                 (don't use the <RunObject> property)
    //                     13/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                     03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                             Modified OnAssistEdit trigger field "No."
    //                     13/06/2012 DIT-715 #338 Added functions AllItemsAvailability()
    // DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added to call function SetFilterSubContractPostType() on AfterGetCurrRecord();
    //                                             Added to call function SetFilterSubContractPostType2() on OnNewRecord()
    //                                             Added fields "DIT Sub-Contract Type","Service Contract No.""Contract Group Code"
    //                 AHU 06/11/2012 DIT-715 #393 Added "Description 2" field
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added functions OpenSSCCTrackingLines()
    // 
    // FINXL7.00.001 RBE 20/03/2013: Added fields "Tariff No." & "Net Weight" (not visible)
    //                               Added field: "Auto. Acc. Group"
    // FINXL8.00.001 BSA 08/06/2015 #182 : Added Field "Emergency Order"
    // MANXL7.00.001 DAT 05/03/2014 #13: Added field "Revision No."
    // MANXL7.00.001 DAT 05/03/2014 #18: Added "Requester ID"
    // 
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 06/06/2013 DIT-770 #99 Added fields "Ship-to Country/Region Code"
    //                  04/07/2013 DIT-770 #99 Removed field "Ship-to Country/Region Code"
    //                                         Added fields "GWC Country/Region Code"
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #99
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0014.1
    //                             added approved prod group + approved line amount
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added
    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.03 DDR 10/06/2014 DIT-770 #541 Modified 'QuickEntry' property fields "Has Item Charge","Collapse"
    //                                          Removed 'IndentationControls' field1 Group Repeater
    // DITW17.10.03 DDR 10/07/2014 DIT-770 #541 Added editable other types than Item
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added field "Responsibity Center"
    // DITW17.10.05 MSF 17/07/2014 DIT-770 #698 (Customer)Vendor suspended tax determined per document line + internal taxes
    //                                           Added non-editable fields "Vendor DTax Group Code","Item DTax Group Code"
    // DITW17.10.05 MSF 18/07/2014 DIT-770 #692 : Employee free benefits with tax due and tax not due sales lines
    //                                            Added field "Free reason code"
    // DITW17.10.05 YHE 06/11/2014 DIT-770 #961 Approved Line amount and Approved PPG added, visible False
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Direct Unit Cost"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type
    // DITW18.00.07 VSC 25/05/2016 DIT-770 #1970 Set Quickentry on Type,"No.",Quantity
    //                                           Set Visible to False for fields "Revision No." and "Requester ID"
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields "Strength Spec. Code","Strength Spec. Value","Vol-Strength Spec. Code","Vol-Strength Spec. Value","Unit Volume HL"
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Removed 'Editable' property for fields "strength Spec. Value","vol-strength Spec. Value"
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // FINXL9.00.000.01 ACH 05/01/2016 : set visibilities to false fields "Revision No.","Requester ID"
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Added new fields "Backorder Type"
    // DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackDirectCostItem()
    // NRQ175506 NLAB 03/11/2021 Added DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix (Correctice Change no - CHG2102694)
    // 
    // HEI.01 HLSRM02 IBM LAZARE02 07.08.2017
    //   #New fields for SRM integration: Cancelled, SRM Order No., SRM Order Line No.

    // HEI.02 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //   # New field for MDM integration: "WHT Absorb Base"

    // HEI.03 Code already blocked in Navision.

    // HEI.04 IBM.NAIKH01 27.06.2018
    //   # Added the field "VAT Prod. Posting Group" on Page

    //  IsFoundationArea() condition is not required anymore in business central Saas so blocked that condition.

    // DrinkIT code and fields are blocked.
    // BC Upgrade BHARAD11 >>
    /* Remove OnNextRecord and OnFindRecord Trigger. PID-264 --We need to either remove this trigger completely or comment it out if it doesn’t contain any code, because otherwise the data is not displayed on the page. */
    // BC Upgrade BHARDA11 <<

    AutoSplitKey = true;
    Caption = 'Prepayment Request Lines';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = where("Document Type" = FILTER(Order));
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                // BC Upgrade SHUKLP03 >> DrinkIT field blocked.
                // field(Collapse;Collapse)
                // {
                //     Editable = false;
                //     QuickEntry = false;
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         // <<DITW15.00.00.37 DDR 19/01/2010
                //         CurrPage.UPDATE(true);
                //         // >>DITW15.00.00.37 DDR
                //     end;
                // } // BC Upgrade SHUKLP03 << DrinkIT field blocked.
                field(Cancelled; Rec."Cancelled FND")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cancelled field.';
                }
                field("SRM Order No."; Rec."SRM Order No. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SRM Order No. field.';

                }
                field("SRM Order Line No."; Rec."SRM Order Line No. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SRM Order Line No. field.';

                }
                field("WHT Absorb Base"; Rec."WHT Absorb Base FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the WHT Absorb Base field.';

                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                    QuickEntry = true;
                    ToolTip = 'Specifies the line type.';

                    trigger OnValidate();
                    begin
                        TypeOnAfterValidate();
                        NoOnAfterValidate();
                        TypeChosen := Rec.HasTypeToFillMandatoryFields();

                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    QuickEntry = true;
                    ShowMandatory = TypeChosen;
                    ToolTip = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.';

                    trigger OnAssistEdit();
                    begin
                        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
                        // // <<DITW15.00.00.39 DDR 26/08/2011 #1393 - DITW16.00.00.40 DDR 03/05/2012 DIT-715 #276
                        // if AssistEditItemTreeview("No.") then begin
                        //     // validate trigger
                        //     ShowShortcutDimCode(ShortcutDimCode);
                        //     // aftervalidate trigger
                        //     CurrPage.UPDATE(true);
                        // end else
                        //     CurrPage.UPDATE(false);
                        // // >>DITW15.00.00.39 DDR #1393 - DITW16.00.00.40 DDR DIT-715 #276
                        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
                    end;

                    trigger OnValidate();
                    begin
                        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
                        // // <<DITW17.10.03 DDR 10/06/2014 DIT-770 #541
                        // if not ("No.Editable" or "No.Enable") then begin
                        //     "No." := xRec."No.";
                        //     exit;
                        // end;
                        // // >>DITW17.10.03 DDR DIT-770 #541
                        // BC Upgrade SHUKLP03 << DrinkIT code blocked.

                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate();

                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    QuickEntry = false;
                    ToolTip = 'Specifies a description of the item or service on the line.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Description = 'DIT-715 #393';
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies information in addition to the description.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    Editable = false;
                    QuickEntry = true;
                    ShowMandatory = TypeChosen;
                    ToolTip = 'Specifies the number of units of the item that will be specified on the line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        QuantityOnAfterValidate();
                    end;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    QuickEntry = false;
                    ShowMandatory = TypeChosen;
                    ToolTip = 'Specifies the direct cost of one item unit.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        DirectUnitCostOnAfterValidate();
                    end;
                }
                field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
                }
                field("WHT Product Posting Group"; Rec."WHT Product Posting Group FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the WHT Product Posting Group field.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the VAT product posting group of the item or general ledger account on this line.';
                }
            }
            group(Control43)
            {
                ShowCaption = false; // BC Upgrade BHARDA11 -- PID-294
                group(Control19)
                {
                    ShowCaption = false; // BC Upgrade BHARDA11 -- PID-294
                    field("Total Amount Excl. VAT"; TotalPurchaseLine.Amount)
                    {
                        ApplicationArea = Suite;
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
                        ApplicationArea = Suite;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalVATCaption(PurchHeader."Currency Code");
                        Caption = 'Total VAT';
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        ToolTip = 'Specifies the sum of VAT amounts on all lines in the document.';
                    }
                    field("Total Amount Incl. VAT"; TotalPurchaseLine."Amount Including VAT")
                    {
                        ApplicationArea = Suite;
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
                    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                    ExpandLines := true;
                    CurrPage.UPDATE(true);
                    // >>DITW17.10.03 DDR DIT-770 #541
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
                    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                    ExpandLines := false;
                    CurrPage.UPDATE(true);
                    // >>DITW17.10.03 DDR DIT-770 #541
                end;
            }
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action("Sales &Order")
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        ApplicationArea = Suite;
                        Caption = 'Sales &Order';
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
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action(Action1901038504)
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        Caption = 'Sales &Order';
                        Image = Document;
                        ToolTip = 'Executes the Sales &Order action.';

                        trigger OnAction();
                        begin
                            OpenSpecOrderSalesOrderForm();
                        end;
                    }
                }
                // BC Upgrade SHUKLP03 >> Action blocked because dependency on DrinkIT. 
                // action("Quality Tests")
                // {
                //     Caption = 'Quality Tests';

                //     trigger OnAction();
                //     begin
                //         // <<DITW15.00.00.38 PRODW14.00.00.17 DDR 08/02/2011 #1271
                //         //This functionality was copied from page #50. Unsupported part was commented. Please check it.
                //         /*CurrPage.PurchLines.PAGE.*/
                //         _ShowQualityTests();

                //     end;
                // } // BC Upgrade SHUKLP03 << Action blocked because dependency on DrinkIT. 
                action(BlanketOrder)
                {
                    Caption = 'Blanket Order';
                    Image = BlanketOrder;
                    ToolTip = 'View the blanket purchase order.';

                    trigger OnAction();
                    var
                        PurchaseHeader: Record "Purchase Header";
                        BlanketPurchaseOrder: Page "Blanket Purchase Order";
                    begin
                        Rec.TESTFIELD("Blanket Order No.");
                        PurchaseHeader.SETRANGE("No.", Rec."Blanket Order No.");
                        if not PurchaseHeader.ISEMPTY then begin
                            BlanketPurchaseOrder.SETTABLEVIEW(PurchaseHeader);
                            BlanketPurchaseOrder.EDITABLE := false;
                            BlanketPurchaseOrder.RUN();
                        end;
                    end;
                }
                // BC Upgrade SHUKLP03 >> Action blocked because dependency on DrinkIT. 
                // action(Action2035090)
                // {
                //     Caption = 'Quality Tests';

                //     trigger OnAction();
                //     begin
                //         //<<QXL9.00.001 DAT 23/03/2016
                //         ShowQualityTests();
                //         //>>QXL9.00.001 DAT 23/03/2016
                //     end;
                // } // BC Upgrade SHUKLP03 << Action blocked because dependency on DrinkIT. 
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        // SETFILTER("Resp. Center Table Filter",
        //   UserMgt.GetRespCenterFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // SETFILTER("Phys. Location Table Filter",
        //   UserMgt.GetRespPhysLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // SETFILTER("Location Table Filter",
        //   UserMgt.GetRespLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // // >>DITW18.00.06 DDR DIT-770 #1191
        // // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        // SetFilterSubContractPostType();
        // // >>DITW16.00.00.41 AHU DIT-715 #327
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.

        UpdateEditableOnRow();
        if PurchHeader.GET(Rec."Document Type", Rec."Document No.") then;

        DocumentTotals.PurchaseUpdateTotalsControls(Rec, TotalPurchaseHeader, TotalPurchaseLine, RefreshMessageEnabled,
          TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, VATAmount);

        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR 18/12/2007
        // // VIGEO VS 29-12-2005: Toeslag regels mogen niet worden gewijzigd. Dit moet op het hoofdartikel worden gedaan.
        // UpdateFields();
        // // >>DITW15.00.00.01 DDR 18/12/2007
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    trigger OnAfterGetRecord();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        // IndentLine := IndentRecordDIT(ExpandLines);
        // // >>DITW17.10.03 DDR DIT-770 #541
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.

        Rec.ShowShortcutDimCode(ShortcutDimCode);

        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
        // ShowShortcutUomValue(ShortcutQtyUomValue);
        // // >>DITW16.00.00.40 DDR DIT-715 #244
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.

        TypeChosen := Rec.HasTypeToFillMandatoryFields();
        CLEAR(DocumentTotals);
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
        //end;
        // Move to function TriggerOnDeleteRecord() to solve RTC Collapse delete records
        // Temporary until next Mirosoft release
        exit(TriggerOnDeleteRecord());
    end;
    // BC Upgrade BHARAD11 >> --PID-264 --We need to either remove this trigger completely or comment it out if it doesn’t contain any code, because otherwise the data is not displayed on the page.
    // trigger OnFindRecord(Which: Text): Boolean;
    // begin
    //     // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
    //     // // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    //     // if DisabledRefreshLines then
    //     //     exit(false);
    //     // // >>DITW16.00.00.40 DDR DIT-715 #197
    //     // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //     // //EXIT(FIND(Which));
    //     // exit(FindRecordDIT(Which, ExpandLines));
    //     // // >>DITW17.10.03 DDR DIT-770 #541
    //     // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    // end;
    // BC Upgrade BHARAD11 << --PID-264 --We need to either remove this trigger completely or comment it out if it doesn’t contain any code, because otherwise the data is not displayed on the page.

    trigger OnInit();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR 18/12/2007
        // "Line AmountEnable" := true;
        // "Unit Price (LCY)Enable" := true;
        // QuantityEnable := true;
        // "No.Enable" := true;
        // TypeEnable := true;
        // "Qty. to InvoiceEditable" := true;
        // "Qty. to ReceiveEditable" := true;
        // "Line AmountEditable" := true;
        // "Direct Unit CostEditable" := true;
        // QuantityEditable := true;
        // "Cross-Reference No.Editable" := true;
        // "No.Editable" := true;
        // // >>DITW15.00.00.01 DDR 18/12/2007
        // // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        // GlobalTax1ValueEditable := true;
        // GlobalTax2ValueEditable := true;
        // // >>DITW19.00.08 DDR BL#10443
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.

        //HEI.03>>
        PrepaymentEnable := false;
        TypeEditable := false;
        //HEI.03<<
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        Rec.Type := Rec.Type::Item;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
        // IndentLine := 0;
        // if not ISEMPTY then
        //     InitLineNo(ExpandLines, BelowxRec);
        // // >>DITW17.10.03 DDR DIT-770 #541
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.

        // IF ApplicationAreaSetup.IsFoundationEnabled THEN // BC Upgrade SHUKLP03 << Blocked becaue no need of this condition.
        Rec.Type := Rec.Type::Item;
        CLEAR(ShortcutDimCode);

        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        // SetFilterSubContractPostType2();
        // // >>DITW16.00.00.41 AHU DIT-715 #327
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;
    // BC Upgrade BHARAD11 >> --PID-264 --We need to either remove this trigger completely or comment it out if it doesn’t contain any code, because otherwise the data is not displayed on the page.
    // trigger OnNextRecord(Steps: Integer): Integer;
    // begin
    //     // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
    //     // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //     // exit(NextRecordDIT(Steps, ExpandLines));
    //     // // >>DITW17.10.03 DDR DIT-770 #541
    //     // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    // end;
    // BC Upgrade BHARAD11 << --PID-264 --We need to either remove this trigger completely or comment it out if it doesn’t contain any code, because otherwise the data is not displayed on the page.


    trigger OnOpenPage();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        // ExpandLines := false;
        // ShowButtonsCE := IsShowButtonsCEDIT();
        // // >>DITW17.10.03 DDR DIT-770 #541
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    var
        ApplicationAreaSetup: Record "Application Area Setup";
        PurchHeader: Record "Purchase Header";
        TotalPurchaseHeader: Record "Purchase Header";
        TotalPurchaseLine: Record "Purchase Line";
        DocumentTotals: Codeunit "Document Totals";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        UserMgt: Codeunit "User Setup Management";
        xRecRef: RecordRef;

        "Cross-Reference No.Editable": Boolean;

        "Direct Unit CostEditable": Boolean;
        DisabledRefreshLines: Boolean;

        ExpandLines: Boolean;

        GlobalTax1ValueEditable: Boolean;

        GlobalTax2ValueEditable: Boolean;
        InvDiscAmountEditable: Boolean;

        "Line AmountEditable": Boolean;

        "Line AmountEnable": Boolean;

        "No.Editable": Boolean;

        "No.Enable": Boolean;
        PrepaymentEnable: Boolean;

        "Qty. to InvoiceEditable": Boolean;

        "Qty. to ReceiveEditable": Boolean;

        QuantityEditable: Boolean;

        QuantityEnable: Boolean;
        RefreshMessageEnabled: Boolean;

        ShowButtonsCE: Boolean;
        TypeChosen: Boolean;

        TypeEditable: Boolean;

        TypeEnable: Boolean;
        TypeEnabled: Boolean;
        UnitofMeasureCodeIsChangeable: Boolean;

        "Unit Price (LCY)Enable": Boolean;
        VendorVendorPostingGroup: Code[10];
        ShortcutDimCode: array[8] of Code[20];
        ShortcutQtyUomValue: array[3] of Decimal;
        VATAmount: Decimal;
        IndentLine: Integer;
        //cduAppMgt: Codeunit ApplicationManagement;
        //QualitySetup: Record "Quality Setup";
        //QualityManagement: Codeunit "Quality Management";
        PageText2014410: Label 'Total Line Amount';
        PageText2014411: Label 'Total Direct Unit Cost';
        Text001: Label 'You cannot use the Explode BOM function because a prepayment of the purchase order has been invoiced.';
        Text2014260: Label 'There are no valid lines to use this function.';
        UpdateInvDiscountQst: Label 'One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?';
        RefreshMessageText: Text;
        TotalAmountStyle: Text;

    procedure ApproveCalcInvDisc();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    local procedure ExplodeBOM();
    begin
        if rec."Prepmt. Amt. Inv." <> 0 then
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
        // TrackingForm.SetPurchLine(Rec);
        //TrackingForm.RUNMODAL();
        TrackingForm.SetVariantRec(Rec, Rec."No.", Rec."Outstanding Qty. (Base)", Rec."Expected Receipt Date", Rec."Expected Receipt Date");
        TrackingForm.RunModal();

    end;

    local procedure OpenSpecOrderSalesOrderForm();
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        Rec.TESTFIELD("Special Order Sales No.");
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

        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.35 DDR 29/06/2009 - DITW15.00.00.38 DDR 15/03/2011 #1291
        // if (Type <> Type::Item) and not "Is Item Charge" then
        //     // >>DITW15.00.00.35 DDR - DITW15.00.00.38 DDR #1291
        //     InsertExtendedText(false);
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.

        if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and
           (xRec."No." <> '')
        then
            CurrPage.SAVERECORD();

        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.23 DDR 30/07/2008
        // CurrPage.UPDATE;
        // // >>DITW15.00.00.23 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure CrossReferenceNoOnAfterValidat();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.38 DDR 27/01/2011 #1259
        // //InsertExtendedText(FALSE);
        // CurrPage.UPDATE;
        // // >>DITW15.00.00.38 DDR #1259
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

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
        UnitofMeasureCodeIsChangeable := Rec.CanEditUnitOfMeasureCode();
    end;

    procedure _InsertExtendedCharges(FromHeader: Boolean);
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
        // if InsertChargeLines(FromHeader) then
        //     UpdateForm(true);
        // // >>DITW15.00.00.23 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    procedure InsertExtendedCharges(FromHeader: Boolean);
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
        // if InsertChargeLines(FromHeader) then
        //     UpdateForm(true);
        // // >>DITW15.00.00.23 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    // BC Upgrade SHUKLP03 >> DrinkIT functions are blocked.
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
    //     //HEI.03>>
    //     //TypeEditable := FormEditableField(FIELDNO(Type));
    //     /*
    //     Type := Type::"G/L Account";
    //     "Prepayment %" := 100;
    //     Quantity :=1;
    //     IF PurchHeader.GET("Document Type","Document No.") THEN;
    //     SetVendorPostingGroup(PurchHeader);
    //     "No." := VendorVendorPostingGroup;*/
    //     //HEI.03<<
    //     "No.Editable" := FormEditableField(FIELDNO("No."));
    //     // <<DITW15.00.00.38 DDR 27/01/2011 #1259
    //     "Cross-Reference No.Editable" := FormEditableField(FIELDNO("Cross-Reference No."));
    //     // >>DITW15.00.00.38 DDR #1259

    //     QuantityEditable := FormEditableField(FIELDNO(Quantity));
    //     "Direct Unit CostEditable" := FormEditableField(FIELDNO("Direct Unit Cost")) and not CollapsedLine;
    //     "Line AmountEditable" := FormEditableField(FIELDNO("Line Amount")) and not CollapsedLine;

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
    // BC Upgrade SHUKLP03 << DrinkIT function blocked.

    // BC Upgrade SHUKLP03 >> DrinkIT function blocked.
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
    //     SelectedPurchLines.SETRANGE("ARC No. Mandatory", true);
    //     if SelectedPurchLines.findset then begin
    //         repeat
    //             SelectedPurchLines.TESTFIELD("ARC No.", '');
    //         until SelectedPurchLines.NEXT = 0;
    //     end else
    //         ERROR(Text2014260);

    //     // <<DITW15.00.00.38 DDR 17/12/2010 #703
    //     if SelectedPurchLines.EDILookupExtTrackingARC(NewText) then begin
    //         NewARCNo := NewText;
    //         if SelectedPurchLines.findset(true) then
    //             repeat
    //                 SelectedPurchLines.VALIDATE("ARC No.", NewARCNo);
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
    //     if SelectedPurchLines.findset then begin
    //         repeat
    //             SelectedPurchLines.TESTFIELD("ARC No.", '');
    //         until SelectedPurchLines.NEXT = 0;
    //     end else
    //         ERROR(Text2014260);

    //     // <<DITW15.00.00.38 DDR 17/12/2010 #703
    //     if SelectedPurchLines.EDILookupExtTrackingARC(NewText) then begin
    //         NewARCNo := NewText;
    //         if SelectedPurchLines.findset(true) then
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
    //     QualityTestHeader.SETRANGE("Item No.", "No.");
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
    // BC Upgrade SHUKLP03 >> DrinkIT functions are blocked.

    procedure TriggerOnDeleteRecord(): Boolean;
    var
        TempRec: Record "Purchase Line" temporary;
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
        // cronus
        if (Rec.Quantity <> 0) and Rec.ItemExists(Rec."No.") then begin
            COMMIT();
            if not ReservePurchLine.DeleteLineConfirm(Rec) then
                exit(false);

            // BC Upgrade SHUKLP03 << DrinkIT code blocked.
            // // <<QXL9.00.001 DAT 23/03/2016
            // if QualitySetup.READPERMISSION then begin
            //     if not QualityManagement.DeletePurchLineConfirm(Rec) then
            //         exit(false);
            // end;
            // // >>QXL9.00.001 DAT 23/03/2016
            // BC Upgrade SHUKLP03 >> DrinkIT code blocked.

            ReservePurchLine.DeleteLine(Rec);

            // BC Upgrade SHUKLP03 << DrinkIT code blocked.
            // // <<QXL9.00.001 DAT 23/03/2016
            // if QualitySetup.READPERMISSION then
            //     QualityManagement.DeletePurchLine(Rec);
            // // >>QXL9.00.001 DAT 23/03/2016
            // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        end;

        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.36 DDR 23/11/2009
        // if "Is Item Charge" and "ItemCharge Incl. Price" then begin
        //     DELETE(true);
        //     TempRec := Rec;
        //     TempRec."Direct Unit Cost" := 0;
        //     TempRec."Line Amount" := 0;
        //     TempRec."Line Discount Amount" := 0;
        //     //<< DITW110.00.11 DDR 10/08/2017 NRQ#24875
        //     TempRec.CalcBackDirectCostItem();
        //     //>>  DITW110.00.11 DDR 10/08/2017 NRQ#24875
        //     exit(false);
        // end;
        // // >>DITW15.00.00.36 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.

        exit(true);
    end;

    // // BC Upgrade SHUKLP03 << DrinkIT functions are blocked.
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
    // BC Upgrade SHUKLP03 << DrinkIT functions are blocked.

    local procedure TypeOnAfterValidate();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR 15/01/2008
        // if Type <> xRec.Type then
        //     CurrPage.UPDATE;
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure VariantCodeOnAfterValidate();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR DDR 15/01/2008
        // if (Type = Type::Item) and
        //    (xRec."Variant Code" <> "Variant Code")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure LocationCodeOnAfterValidate();
    var
        UpdateIsDone: Boolean;
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR DDR 15/01/2008
        // if (Type = Type::Item) and
        //    not UpdateIsDone
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure QuantityOnAfterValidate();
    var
        UpdateIsDone: Boolean;
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR DDR 15/01/2008
        // if (Type = Type::Item) and
        //    (Quantity <> xRec.Quantity) and
        //    not UpdateIsDone
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure UnitofMeasureCodeOnAfterValida();
    var
        UpdateIsDone: Boolean;
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR DDR 15/01/2008
        // if (Type = Type::Item) and
        //    not UpdateIsDone
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure DirectUnitCostOnAfterValidate();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR 21/12/2007
        // if (Type = Type::Item) and
        //    ("Direct Unit Cost" <> xRec."Direct Unit Cost")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure LineAmountOnAfterValidate();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR 21/12/2007
        // if (Type = Type::Item) and
        //    ("Line Amount" <> xRec."Line Amount")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure LineDiscount37OnAfterValidate();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR 21/12/2007
        // if (Type = Type::Item) and
        //    ("Line Discount %" <> xRec."Line Discount %")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure LineDiscountAmountOnAfterValid();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR 21/12/2007
        // if (Type = Type::Item) and
        //    ("Line Discount Amount" <> xRec."Line Discount Amount")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure Prepayment37OnAfterValidate();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.23 DDR 11/08/2008
        // if (Type = Type::Item) and
        //    ("Prepayment %" <> xRec."Prepayment %")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.23 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure PrepmtLineAmountOnAfterValidat();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.23 DDR 11/08/2008
        // if (Type = Type::Item) and
        //    ("Prepmt. Line Amount" <> xRec."Prepmt. Line Amount")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.23 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure QtytoReceiveOnAfterValidate();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR 21/12/2007
        // if (Type = Type::Item) and
        //    ("Qty. to Receive" <> xRec."Qty. to Receive")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure QtytoInvoiceOnAfterValidate();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR 21/12/2007
        // if (Type = Type::Item) and
        //    ("Qty. to Invoice" <> xRec."Qty. to Invoice")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.01 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure PrepmtAmttoDeductOnAfterValida();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.23 DDR 11/08/2008
        // if (Type = Type::Item) and
        //    ("Prepmt Amt to Deduct" <> xRec."Prepmt Amt to Deduct")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.23 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure FreeItemOnAfterValidate();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.35 DDR 25/06/2009
        // if (Type = Type::Item) and
        //    (xRec."Free Item" <> "Free Item")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.35 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure AllowVATCalculationFreeOnAfter();
    begin
        CurrPage.UPDATE(true);
    end;

    local procedure FreeItemPostingTypeOnAfterVali();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.35 DDR 25/06/2009
        // if Type = Type::Item then
        //     CurrPage.UPDATE(true);
        // // >>DITW15.00.00.35 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure FreeReasoncodeOnAfterValidate();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692
        // if (Type = Type::Item) and
        //    (xRec."Free Reason Code" <> "Free Reason Code")
        // then
        //     CurrPage.UPDATE(true);
        // // >>DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    local procedure SetVendorPostingGroup(var PurchaseHeader: Record "Purchase Header");
    var
        Vendor: Record Vendor;
    begin
        Vendor.RESET();
        Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
        VendorVendorPostingGroup := Vendor."Vendor Posting Group";
    end;
}

