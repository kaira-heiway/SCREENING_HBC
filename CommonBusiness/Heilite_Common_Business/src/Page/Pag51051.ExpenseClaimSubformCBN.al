page 51051 "Expense Claim Subform CBN"
{
    // version NAVW110.0.15140,FINXL10.00,QXL9.00.001,DITW110.00.08,HEI.02

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
    // DITW15.00.00.21 DDR 25/06/2008 Added function GetPostedWhseDocument()
    // DITW15.00.00.23 DDR 29/07/2008 Remove call function InsertExtendedCharges() from trigger OnAfterValidate field "No."
    //                                Updated function into InsertExtendedCharges()
    //                     31/07/2008 Move NewRecord() function into OnNewRecord trigger
    // 
    //                     12/08/2008 Certification Rules
    //                                  Remove local variable (function GetPostedWhseDocument)
    // DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
    //                                  "Empty Goods Item No."
    // DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //                     21/08/2009 issue 727 Added HorzAlign property in field "Direct Unit Cost"
    //                 DDR 14/10/2009 issue 893 Removed fields "Gen. Prod. Posting Free Group"
    // DITW15.00.00.36 DDR 04/11/2009 issue 939 Performance SQL
    //                                          Added function FormTotalingField()
    // DITW15.00.00.37 DDR 11/05/2010 issue 1061 Added field "Physical Location Group Code"
    //                     01/06/2010 issue 959 Added field "AAD No."
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 23/06/2010 issue 1151 Added to remove Quarantine Quality test when delete purchase line
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    //                     17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
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
    //                                               "ARC No.","SAD No."
    //                     15/03/2011 issue 1291 Modified trigger field "No." activate function InsertExtendedText() other than items
    //                     16/03/2011 issue 1217 (DIT711 161) Added field "Packaging Type Code"
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade Added/Review Total Line Amount (Collapsed RTC)
    // DITW15.00.00.39 DDR 26/08/2011 issue 1393 Added AssistEdit property/trigger for field "Item No."
    //                     26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)"
    //                     11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  Added function SetDisableRefreshLines() to call before/after each report object
    //                                                 (don't use the <RunObject> property)
    //                     03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                             Modified OnAssistEdit trigger field "No."
    // DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added to call function SetFilterSubContractPostType() on AfterGetCurrRecord();
    //                                             Added to call function SetFilterSubContractPostType2() on OnNewRecord()
    //                                             Added fields "DIT Sub-Contract Type","Service Contract No.""Contract Group Code"
    //                 AHU 06/11/2012 DIT-715 #393 Added "Description 2" field
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added functions OpenSSCCTrackingLines()
    // 
    // FINXL7.00 RBE 20/03/2013 : Added fields "Tariff No." & "Net Weight" (not visible)
    //                                Added field: "Auto. Acc. Group"
    // 
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0014.1
    //                             added approved prod group + approved line amount
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added
    // DITW17.00.02 SR 23/09/2013 DIT-770 #152 : Page Action Added "Get Blanket Order" added
    //                                         : New "GetPurchBlanketOrder" Added
    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.03 DDR 10/06/2014 DIT-770 #541 Modified 'QuickEntry' property fields "Has Item Charge","Collapse"
    //                                          Removed 'IndentationControls' field1 Group Repeater
    // DITW17.10.03 DDR 10/07/2014 DIT-770 #541 Added editable other types than Item
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added field "Responsibity Center"
    // DITW17.10.05 MSF 17/07/2014 DIT-770 #698 (Customer)Vendor suspended tax determined per document line + internal taxes
    //                                           Added non-editable fields "Vendor DTax Group Code","Item DTax Group Code"
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Direct Unit Cost"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //                                          TEMP Disabled Call function UpdateVATAmounts()
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type
    // DITW18.00.07 VSC 08/03/2016 DIT-770 #1066 New Function + Action to get posted shipping agent costs
    // DITW18.00.07 VSC 08/03/2016 DIT-770 #1066 Deleted Functions _GetPostedWhseDocument and GetPostedWhseDocument
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 24/02/2017 NRQ#21530 Bugfix NAV CU1 replaced by CU3
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // FINXL9.00.000.01 ACH 05/01/2016 : Added field 2036306 - "Intrastat Mandatory" (Boolean)
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackDirectCostItem()
    // NRQ175506 NLAB 03/11/2021 Added DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix (Correctice Change no - CHG2102694)
    // 
    // HEI.01 FDD PTPGAP014 - No POGR lines in NPO invoice , IBM NAIKH01 27-06-2017
    //   # Created  a new page that is the Replica of Page 55 - "Purch. Invoice Subform" to show the Purchase Invoice with Document SubType 'NPO'
    // HEI.02 Defect #1410 IBM NASTAA02 22.01.2018 # Type column twice in NPO invoice
    //   # Deleted column "Type". Just "NPOType" should exist
    // HEI.03 Defect 673 BULIMC01 IBM 21/04/2021# new condition added on trigger "OnInsertRecord" to restrict lines with type <> GL Account

    //  IsFoundationArea() condition is not required anymore in business central Saas so blocked that condition.
    // DrinkIT code and fields are blocked.

    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = where("Document Type" = FILTER(Invoice));
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                // BC Upgrade SHUKLP03 >> DrinkIT created fields are blocked.
                // field("Has Item Charge";"Has Item Charge")
                // {
                //     BlankZero = true;
                //     QuickEntry = false;
                // }
                // field(Collapse;Collapse)
                // {
                //     QuickEntry = false;
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         // <<DITW15.00.00.37 DDR 19/01/2010
                //         CurrPage.UPDATE(true);
                //         // >>DITW15.00.00.37 DDR
                //     end;
                // } // BC Upgrade SHUKLP03 << DrinkIT created fields are blocked.
                field(NPOType; NPOType)
                {
                    ApplicationArea = ALL;
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Type field.';

                    trigger OnValidate();
                    begin
                        //HEI0.1 NAIKH01

                        if NPOType = NPOType::" " then
                            Rec.VALIDATE(Type, Rec.Type::" ");

                        if NPOType = NPOType::"G/L Account" then
                            Rec.VALIDATE(Type, Rec.Type::"G/L Account");

                        if NPOType = NPOType::"Charge (Item)" then
                            Rec.VALIDATE(Type, Rec.Type::"Charge (Item)");

                        if NPOType = NPOType::"Fixed Asset" then
                            Rec.VALIDATE(Type, Rec.Type::"Fixed Asset");
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of a general ledger account, an item, an additional cost or a fixed asset, depending on what you selected in the Type field.';

                    trigger OnAssistEdit();
                    begin
                        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
                        // // <<DITW15.00.00.39 DDR 26/08/2011 #1393 - DITW16.00.00.40 DDR 03/05/2012 DIT-715 #276
                        // if AssistEditItemTreeview("No.") then begin
                        //     // validate trigger
                        //     Rec.ShowShortcutDimCode(ShortcutDimCode);
                        //     // aftervalidate trigger
                        //     CurrPage.UPDATE(true);
                        // end else//SHARMP16 PTP160 BEGIN<<
                        // CurrPage.UPDATE(false);//SHARMP16 PTP160 BEGIN<<
                        // // >>DITW15.00.00.39 DDR #1393 - DITW16.00.00.40 DDR DIT-715 #276
                        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
                    end;

                    trigger OnValidate();
                    begin
                        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
                        // // <<DITW17.10.03 DDR 10/06/2014 DIT-770 #541
                        if not ("No.Editable" or "No.Enable") then begin
                            rec."No." := xRec."No.";
                            exit;
                        end;//SHARMP16 PTP160 BEGIN<<
                        // // >>DITW17.10.03 DDR DIT-770 #541
                        // BC Upgrade SHUKLP03 << DrinkIT code blocked.

                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate();

                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate();
                    end;
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field blocked.
                // field("Cross-Reference No.";"Cross-Reference No.")
                // {
                //     ApplicationArea = Basic,Suite;
                //     Editable = "Cross-Reference No.Editable";
                //     ToolTip = 'Specifies the cross-referenced item number. If you enter a cross reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the cross-reference number on a sales or purchase document.';
                //     Visible = false;

                //     trigger OnLookup(Text : Text) : Boolean;
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
                // } // BC Upgrade SHUKLP03 << DrinkIT code blocked.
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the IC partner code of the partner to whom you want to distribute the cost of the line.';
                    Visible = false;
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the item or account in your IC partner''s company that corresponds to the item or account on the line.';
                    Visible = false;
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'If the line is being sent to one of your intercompany partners, this field is used together with the IC Partner Ref. Type field to indicate the item or account in your partner''s company that corresponds to the line.';
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies a variant code for the item.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

                        VariantCodeOnAfterValidate();
                    end;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies that this item is a nonstock item.';
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the code for the VAT product posting group of the item or general ledger account on this line.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245
                    end;
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field is blocked. DrinkIT Replaced "Empty Goods Item No." -> Column "Tracking Item No."
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
                // } / BC Upgrade SHUKLP03 >> DrinkIT field is blocked. DrinkIT Replaced "Empty Goods Item No." -> Column "Tracking Item No."
                field(Description; Rec.Description)
                {
                    ApplicationArea = ALL;
                    Caption = 'Description/Comment';
                    ShowMandatory = true;
                    ToolTip = 'Specifies a description of the entry, which is based on the contents of the Type and No. fields.';

                    trigger OnValidate();
                    begin
                        UpdateEditableOnRow();

                        if Rec."No." = xRec."No." then
                            exit;

                        // Rec.ShowShortcutDimCode(ShortcutDimCode);
                        // NoOnAfterValidate();//BC Upgrade SHARMP16--PID853

                        // if xRec."No." <> '' then
                        //     RedistributeTotalsOnAfterValidate();//BC Upgrade SHARMP16--PID853
                    end;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = ALL;
                    Description = 'DIT-715 #393';
                    Visible = false;
                    ToolTip = 'Specifies information in addition to the description.';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies a code that explains why the item is returned.';
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = ALL;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';

                    trigger OnValidate();
                    begin
                        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
                        // // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        if rec."Responsibility Center" <> xRec."Responsibility Center" then//BC Upgrade SHARMP16--PID853
                            CurrPage.UPDATE(true);//BC Upgrade SHARMP16--PID853
                        // // >>DITW18.00.06 DDR DIT-770 #1191
                        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
                    end;
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field blocked.
                // field("Physical Location Group Code";Rec."Physical Location Group Code")
                // {
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                //         if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                //           CurrPage.UPDATE(true);
                //         // >>DITW18.00.06 DDR DIT-770 #1191
                //     end;
                // } // BC Upgrade SHUKLP03 >> DrinkIT field blocked.
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the code for the location where the items on the line will be located.';

                    trigger OnValidate();
                    begin
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

                        LocationCodeOnAfterValidate();
                        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
                        // // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        if xRec."Location Code" <> rec."Location Code" then//BC Upgrade SHARMP16--PID853
                            CurrPage.UPDATE(true);//BC Upgrade SHARMP16--PID853
                        // // >>DITW18.00.06 DDR DIT-770 #1191
                        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = ALL;//BC Upgrade SHARMP16--PID853
                    ToolTip = 'Specifies a bin code for the item.';
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = ALL;//BC Upgrade SHARMP16--PID853
                    BlankZero = true;
                    // Editable = NOT RowIsText;
                    // Enabled = NOT RowIsText;
                    ShowMandatory = Rec."No." <> '';
                    ToolTip = 'Specifies the number of units of the item that will be specified on the line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

                        // QuantityOnAfterValidate();//BC Upgrade SHARMP16--PID853
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = ALL;
                    Editable = UnitofMeasureCodeIsChangeable;
                    Enabled = UnitofMeasureCodeIsChangeable;
                    ToolTip = 'Specifies the unit of measure code that is valid for the purchase line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

                        UnitofMeasureCodeOnAfterValida();
                    end;
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field blocked.
                // field("Tariff No.";Rec."Tariff No.")
                // {
                //     Description = 'FINXL7.00';
                //     Visible = false;
                // } // BC Upgrade SHUKLP03 << DrinkIT field blocked.
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = ALL;
                    Description = 'FINXL7.00';
                    Visible = false;
                    ToolTip = 'Specifies the net weight of one unit of the item. In the purchase statistics window, the net weight on the line is included in the total net weight of all the lines for the particular purchase document.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the name of the unit of measure for the item, such as 1 bottle or 1 piece.';
                    Visible = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = ALL;
                    BlankZero = true;
                    Editable = NOT RowIsText;
                    Enabled = NOT RowIsText;
                    ShowMandatory = Rec."No." <> '';
                    ToolTip = 'Specifies the direct unit cost of the item on the line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

                        DirectUnitCostOnAfterValidate();
                    end;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the item''s indirect cost percentage.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the unit cost of the item on the line.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ApplicationArea = ALL;
                    Enabled = "Unit Price (LCY)Enable";
                    ToolTip = 'Specifies the price for one unit of the item.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = ALL;
                    BlankZero = true;
                    Editable = NOT RowIsText;
                    Enabled = NOT RowIsText;
                    ToolTip = 'Specifies the net amount (before subtracting the invoice discount amount) that must be paid for the items on the line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

                        LineAmountOnAfterValidate();
                    end;
                }
                // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
                // field("Approved Line Amount";Rec."Approved Line Amount")
                // {
                //     Description = 'DITW17.00.02 DIT-770 #144';
                //     Visible = false;
                // }
                // field(RTCTotalUnit;GetTotalingLine(2,FIELDNO("Direct Unit Cost"),true))
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
                // field(RTCTotalLine;GetTotalingLine(1,FIELDNO("Line Amount"),true))
                // {
                //     AutoFormatExpression = "Currency Code";
                //     AutoFormatType = 1;
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassVar(PageText2014410);
                //     Caption = 'Total Line Amount';
                //     Description = 'DITW17.10.02B DIT-770 #541';
                //     Editable = false;
                //     QuickEntry = false;
                // } // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = ALL;
                    BlankZero = true;
                    Editable = NOT RowIsText;
                    Enabled = NOT RowIsText;
                    ToolTip = 'Specifies the line discount percentage that is valid for the item on the line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

                        LineDiscount37OnAfterValidate();
                    end;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the amount of the line discount that will be granted on the purchase line.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

                        LineDiscountAmountOnAfterValid();
                    end;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies whether the invoice line is included when the invoice discount is calculated.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245
                    end;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the invoice discount amount for the line.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245
                    end;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies that you can assign item charges to this line.';
                    Visible = false;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    ApplicationArea = ALL;
                    BlankZero = true;
                    ToolTip = 'Specifies the quantity of the item charge that will be assigned when you post this line.';

                    trigger OnDrillDown();
                    begin
                        CurrPage.SAVERECORD();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(false);
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ApplicationArea = ALL;
                    BlankZero = true;
                    ToolTip = 'Specifies how much of the item charge that has been assigned.';

                    trigger OnDrillDown();
                    begin
                        CurrPage.SAVERECORD();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(false);
                    end;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'If you fill in this field and the Job Task No. field, then a job ledger entry will be posted together with the purchase order line.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number of the job task that corresponds to the purchase document (invoice or credit memo).';
                    Visible = false;
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies a Job Planning Line together with the posting of a job ledger entry.';
                    Visible = false;
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the sales price per unit that applies to the item or general ledger expense that will be posted.';
                    Visible = false;
                }
                field("Job Line Amount"; Rec."Job Line Amount")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the net amount of the line that the purchase line applies to.';
                    Visible = false;
                }
                field("Job Line Discount Amount"; Rec."Job Line Discount Amount")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the amount of the discount that the purchase line applies to.';
                    Visible = false;
                }
                field("Job Line Discount %"; Rec."Job Line Discount %")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the line discount percent that applies to the item or general ledger expense.';
                    Visible = false;
                }
                field("Job Total Price"; Rec."Job Total Price")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the gross amount of the line that the purchase line applies to.';
                    Visible = false;
                }
                field("Job Unit Price (LCY)"; Rec."Job Unit Price (LCY)")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the sales price per unit that applies to the item or general ledger expense that will be posted.';
                    Visible = false;
                }
                field("Job Total Price (LCY)"; Rec."Job Total Price (LCY)")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the gross amount of the line, in the local currency.';
                    Visible = false;
                }
                field("Job Line Amount (LCY)"; Rec."Job Line Amount (LCY)")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the net amount of the line that the purchase line applies to.';
                    Visible = false;
                }
                field("Job Line Disc. Amount (LCY)"; Rec."Job Line Disc. Amount (LCY)")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the amount of the discount that the purchase line applies to.';
                    Visible = false;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the number of the production order that the purchase order was created for.';
                    Visible = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the document number of the blanket order from which this purchase line originates.';
                    Visible = false;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the line number of the blanket order line from which this purchase line originates.';
                    Visible = false;
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    ToolTip = 'Specifies an insurance number if you have selected the Acquisition Cost option in the FA Posting Type field.';
                    Visible = false;
                }
                field("Budgeted FA No."; Rec."Budgeted FA No.")
                {
                    ToolTip = 'You can use this field if you have selected Fixed Asset in the Type field for this line.';
                    Visible = false;
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    ToolTip = 'Specifies the FA posting type if you have selected Fixed Asset in the Type field for this line.';
                    Visible = false;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ToolTip = 'Specifies the code for the depreciation book to which the line will be posted if you have selected Fixed Asset in the Type field for this line.';
                    Visible = false;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ToolTip = 'You can use this field if you have selected Fixed Asset in the Type field for this line.';
                    Visible = false;
                }
                field("Depr. Acquisition Cost"; Rec."Depr. Acquisition Cost")
                {
                    ToolTip = 'This field is relevant when you post an additional acquisition cost and a possible salvage value to an already acquired asset.';
                    Visible = false;
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    ToolTip = 'You can use this field if you have selected Fixed Asset in the Type field for this line.';
                    Visible = false;
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    ToolTip = 'You can use this field if you have selected Fixed Asset in the Type field for this line.';
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the item ledger entry number the line should be applied to.';
                    Visible = false;
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field blocked.
                // field("Auto. Acc. Group";Rec."Auto. Acc. Group")
                // {
                //     Description = 'FINXL7.00';
                // } // BC Upgrade SHUKLP03 << DrinkIT field blocked.
                field("Deferral Code"; Rec."Deferral Code")
                {
                    ApplicationArea = Suite;
                    Enabled = (Rec.Type <> Rec.Type::"Fixed Asset") AND (Rec.Type <> Rec.Type::" ");
                    TableRelation = "Deferral Template"."Deferral Code";
                    ToolTip = 'Specifies the deferral template that governs how expenses paid with this purchase document are deferred to the different accounting periods when the expenses were incurred.';
                    Visible = false;
                }
                // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
                // field("Vendor DTax Group Code";Rec."Vendor DTax Group Code")
                // {
                //     Description = 'DIT-770 #698';
                //     Editable = false;
                //     QuickEntry = false;
                //     Visible = false;
                // }
                // field("Item DTax Group Code";Rec."Item DTax Group Code")
                // {
                //     Description = '<DITW15.00.00.01>- DIT-770 #698';
                //     Editable = false;
                //     QuickEntry = false;
                //     Visible = false;
                // }
                // field("AAD No.";Rec."AAD No.")
                // {
                //     Visible = false;
                // }
                // field("ARC No.";Rec."ARC No.")
                // {
                //     Description = 'DITW15.00.00.38 #1217';
                //     Visible = false;

                //     trigger OnLookup(Text : Text) : Boolean;
                //     begin
                //         // <<DITW15.00.00.38 DDR 30/09/2010 #1217
                //         exit(
                //           EDILookupExtTrackingARC(Text));
                //         // >>DITW15.00.00.38 DDR
                //     end;
                // }
                // field("SAD No.";Rec."SAD No.")
                // {
                //     Description = 'DITW15.00.00.38 #1217';
                //     Visible = false;
                // }
                // field("Packaging Type Code";"Packaging Type Code")
                // {
                //     Visible = false;
                // }
                // field("Free Item";"Free Item")
                // {

                //     trigger OnValidate();
                //     begin
                //         FreeItemOnAfterValidate;
                //     end;
                // }
                // field("Allow VAT Calculation (Free)";"Allow VAT Calculation (Free)")
                // {
                //     Description = 'DITW16.00.00.40 DIT-715 #172';
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         AllowVATCalculationFreeOnAfter;
                //     end;
                // }
                // field("Free Item Posting Type";"Free Item Posting Type")
                // {
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         FreeItemPostingTypeOnAfterVali;
                //     end;
                // }
                // field("Contract Type";"Contract Type")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("DIT Sub-Contract Type";"DIT Sub-Contract Type")
                // {
                //     Visible = false;
                // }
                // field("Service Contract No.";"Service Contract No.")
                // {
                //     Visible = false;
                // }
                // field("Financial Contract No.";"Financial Contract No.")
                // {
                //     Visible = false;
                // }
                // field("Contract Group Code";"Contract Group Code")
                // {
                //     Visible = false;
                // }
                // field("Linked Customer No.";"Linked Customer No.")
                // {
                //     Visible = false;
                // }  // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2.';
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = ALL;
                    CaptionClass = '1,2,3';
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
                    ApplicationArea = ALL;
                    CaptionClass = '1,2,4';
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
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                    ToolTip = 'Specifies the document number.';
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                    ToolTip = 'Specifies the line''s number.';
                    Visible = false;
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field blocked.
                // field("Intrastat Mandatory";Rec."Intrastat Mandatory")
                // {
                //     Description = 'FINXL9.00.000.01';
                // } // BC Upgrade SHUKLP03 << DrinkIT field blocked.
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
                }
                field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field blocked.
                // field("App. Prod. Posting Group";Rec."App. Prod. Posting Group")
                // {
                //     Description = 'DITW17.00.02 DIT-770 #144';
                //     Visible = false;
                // } // BC Upgrade SHUKLP03 << DrinkIT field blocked.
            }
            group(Control39)
            {
                ShowCaption = false;//BC Upgrade SHARMP16--PID853

                group(Control33)
                {
                    ShowCaption = false;//BC Upgrade SHARMP16--PID853

                    field(AmountBeforeDiscount; TotalPurchaseLine."Line Amount")
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = Currency.Code;
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalLineAmountWithVATAndCurrencyCaption(Currency.Code, TotalPurchaseHeader."Prices Including VAT");
                        Caption = 'Subtotal Excl. VAT';
                        Editable = false;
                        ToolTip = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document.';
                    }
                    field(InvoiceDiscountAmount; InvoiceDiscountAmount)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FIELDCAPTION("Inv. Discount Amount"), Currency.Code);
                        Caption = 'Invoice Discount Amount';
                        Editable = InvDiscAmountEditable;
                        ToolTip = 'Specifies a discount amount that is deducted from the value in the Total Incl. VAT field. You can enter or change the amount manually.';

                        trigger OnValidate();
                        begin
                            ValidateInvoiceDiscountAmount();
                        end;
                    }
                    field("Invoice Disc. Pct."; InvoiceDiscountPct)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Invoice Discount %';
                        DecimalPlaces = 0 : 2;
                        Editable = InvDiscAmountEditable;
                        ToolTip = 'Specifies a discount amount that is deducted from the value in the Total Incl. VAT field. You can enter or change the amount manually.';

                        trigger OnValidate();
                        begin
                            InvoiceDiscountAmount := ROUND(TotalPurchaseLine."Line Amount" * InvoiceDiscountPct / 100, Currency."Amount Rounding Precision");
                            ValidateInvoiceDiscountAmount();
                        end;
                    }
                }
                group(Control15)
                {
                    ShowCaption = false;//BC Upgrade SHARMP16--PID853
                    field("Total Amount Excl. VAT"; TotalPurchaseLine.Amount)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = Currency.Code;
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(Currency.Code);
                        Caption = 'Total Amount Excl. VAT';
                        DrillDown = false;
                        Editable = false;
                        ToolTip = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
                    }
                    field("Total VAT Amount"; VATAmount)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = Currency.Code;
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalVATCaption(Currency.Code);
                        Caption = 'Total VAT';
                        Editable = false;
                        ToolTip = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
                    }
                    field(TotalCADAmount; TotalPurchaseLine."CAD Amount FND")
                    {
                        ApplicationArea = All;
                        Visible = EnableCAD;
                        Editable = false;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        // CaptionClass = DocumentTotals.GetTotalCADCaption(TotalPurchaseHeader."Currency Code");
                        CaptionClass = HenekenCustFuncti.GetTotalCADCaption(TotalPurchaseHeader."Currency Code");
                    }//BC Upgrade SHARMP16--PID853
                    field("Total Amount Incl. VAT"; TotalPurchaseLine."Amount Including VAT")
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = Currency.Code;
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(Currency.Code);
                        Caption = 'Total Amount Incl. VAT';
                        Editable = false;
                        ToolTip = 'Specifies the sum of the value in the Line Amount Incl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
                    }
                    field(TotalInclCAD; TotalInclCAD)
                    {
                        ApplicationArea = All;
                        Caption = 'Total Incl. CAD';
                        Visible = EnableCAD;
                        Editable = false;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        //CaptionClass = DocumentTotals.GetTotalInclCADCaption(TotalPurchaseHeader."Currency Code");
                        CaptionClass = HenekenCustFuncti.GetTotalInclCADCaption(TotalPurchaseHeader."Currency Code");
                    }//BC Upgrade SHARMP16--PID853
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
                ApplicationArea = ALL;
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
                ApplicationArea = ALL;
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
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("E&xplode BOM")
                {
                    ApplicationArea = ALL;
                    AccessByPermission = TableData "BOM Component" = R;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    ToolTip = 'Executes the E&xplode BOM action.';

                    trigger OnAction();
                    begin
                        ExplodeBOM();
                    end;
                }
                action(InsertExtTexts)
                {
                    ApplicationArea = ALL;
                    AccessByPermission = TableData "Extended Text Header" = R;
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;
                    ToolTip = 'Insert the extended description that is set up.';

                    trigger OnAction();
                    begin
                        InsertExtendedText(true);
                    end;
                }
                action("Insert Item Charge&s")
                {
                    ApplicationArea = ALL;
                    Caption = 'Insert Item Charge&s';
                    ShortCutKey = 'Ctrl+Y';
                    ToolTip = 'Executes the Insert Item Charge&s action.';

                    trigger OnAction();
                    begin
                        // 15-12-05, VS: ProcessArtikeltoeslagen
                        //This functionality was copied from page #51. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        _InsertExtendedCharges(true);

                    end;
                }
                // BC Upgrade SHUKLP03 >> Blocked because DrinkIT codeunits has been called inside "GetPurchBlanketOrder" and "GetShippingCostLines" procedure.
                // action("Get Blanket Order ")
                // {
                //     Caption = '"Get Blanket Order "';

                //     trigger OnAction();
                //     begin
                //         GetPurchBlanketOrder;//DITW17.00.02 SR 23/09/2013 DIT-770 #152
                //     end;
                // }
                // action("Get Shipping &Agent Costs")
                // {
                //     Caption = 'Get Shipping &Agent Costs';
                //     Ellipsis = true;

                //     trigger OnAction();
                //     begin
                //         //<< DITW18.00.07 VSC 08/03/2016 DIT-770 #1066
                //         GetShippingCostLines;
                //     end;
                // } // BC Upgrade SHUKLP03 >> Blocked because DrinkIT codeunits has been called inside "GetPurchBlanketOrder" and "GetShippingCostLines" procedure.
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
                        ApplicationArea = ALL;
                        Caption = 'Event';
                        Image = "Event";
                        ToolTip = 'Executes the Event action.';

                        trigger OnAction();
                        begin
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::"Event");
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Period';
                        Image = Period;
                        ToolTip = 'Executes the Period action.';

                        trigger OnAction();
                        begin
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByPeriod())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Period);
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ToolTip = 'Executes the Variant action.';

                        trigger OnAction();
                        begin
                            //  ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Variant);
                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = ALL;
                        AccessByPermission = TableData Location = R;
                        Caption = 'Location';
                        Image = Warehouse;
                        ToolTip = 'Executes the Location action.';

                        trigger OnAction();
                        begin
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Location);
                        end;
                    }
                    action("BOM Level")
                    {
                        ApplicationArea = ALL;
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        ToolTip = 'Executes the BOM Level action.';

                        trigger OnAction();
                        begin
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::BOM);
                        end;
                    }
                }
                action(Dimensions)
                {
                    ApplicationArea = ALL;
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
                    ApplicationArea = ALL;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ToolTip = 'Executes the Co&mments action.';

                    trigger OnAction();
                    begin
                        Rec.ShowLineComments();
                    end;
                }
                action(ItemChargeAssignment)
                {
                    ApplicationArea = ALL;
                    AccessByPermission = TableData "Item Charge" = R;
                    Caption = 'Item Charge &Assignment';
                    Image = ItemCosts;
                    ToolTip = 'Executes the Item Charge &Assignment action.';

                    trigger OnAction();
                    begin
                        Rec.ShowItemChargeAssgnt();
                    end;
                }
                action("Item &Tracking Lines")
                {
                    ApplicationArea = ALL;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'Executes the Item &Tracking Lines action.';

                    trigger OnAction();
                    begin
                        Rec.OpenItemTrackingLines();
                    end;
                }
                action(DeferralSchedule)
                {
                    ApplicationArea = Suite;
                    Caption = 'Deferral Schedule';
                    Enabled = Rec."Deferral Code" <> '';
                    Image = PaymentPeriod;
                    ToolTip = 'View or edit the deferral schedule that governs how expenses incurred with this purchase document is deferred to different accounting periods when the document is posted.';

                    trigger OnAction();
                    var
                        PurchHeader: Record "Purchase Header";
                    begin
                        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
                        Rec.ShowDeferrals(PurchHeader."Posting Date", PurchHeader."Currency Code");
                    end;
                }
                // BC Upgrade SHUKLP03 >> DrinkIT action blocked.
                // action("SSCC Tracking Lines")
                // {
                //     Caption = 'SSCC Tracking Lines';
                //     Description = 'DIT-715 #745';
                //     Image = ItemTrackingLines;

                //     trigger OnAction();
                //     begin
                //         // <<DITW15.00.00.38 DDR 19/11/2010 #1139
                //         //This functionality was copied from page #51. Unsupported part was commented. Please check it.
                //         /*CurrPage.PurchLines.FORM.*/
                //         _OpenSSCCTrackingLines();

                //     end;
                // } // BC Upgrade SHUKLP03 << DrinkIT action blocked.
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        // SETFILTER("Resp. Center Table Filter",
        //   UserMgt.GetRespCenterFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
        // SETFILTER("Phys. Location Table Filter",
        //   UserMgt.GetRespPhysLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
        // SETFILTER("Location Table Filter",
        //   UserMgt.GetRespLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
        // // >>DITW18.00.06 DDR DIT-770 #1191
        // // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        // SetFilterSubContractPostType();
        // // >>DITW16.00.00.41 AHU DIT-715 #327
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.

        CalculateTotals();
        UpdateEditableOnRow();

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
        //fctUpdateStyle(); //FINXL9.00.000.01 ACH 05/01/2016 // BC Upgrade SHUKLP03 << DrinkIT code blocked.

        //HEI0.1 NAIKH01
        NPOType := Rec.Type;
    end;

    trigger OnDeleteRecord(): Boolean;
    var
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

        // <<DITW16.00.00.37 DDR 20/07/2010
        // IF (rec.Quantity <> 0) AND ItemExists(rec."No.") THEN BEGIN
        //     COMMIT;
        //     IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
        //         EXIT(FALSE);
        //     ReservePurchLine.DeleteLine(Rec);
        // end;
        // Move to function TriggerOnDeleteRecord() to solve RTC Collapse delete records
        // Temporary until next Mirosoft release
        exit(TriggerOnDeleteRecord());
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        DocumentTotals.PurchaseCheckAndClearTotals(Rec, xRec, TotalPurchaseLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
        exit(Rec.Find(Which));
    end;//BC Upgrade SHARMP16--PID853

    // trigger OnFindRecord(Which: Text): Boolean;
    // begin
    //     // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
    //     // // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    //     // if DisabledRefreshLines then
    //     //   exit(false);
    //     // // >>DITW16.00.00.40 DDR DIT-715 #197
    //     // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //     // //EXIT(FIND(Which));
    //     // exit(FindRecordDIT(Which,ExpandLines));
    //     // // >>DITW17.10.03 DDR DIT-770 #541
    //     // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    // end;

    trigger OnInit();
    begin
        // <<DITW15.00.00.01 DDR 18/12/2007
        "Line AmountEnable" := true;
        "Unit Price (LCY)Enable" := true;
        QuantityEnable := true;
        "No.Enable" := true;
        TypeEnable := true;
        "Line AmountEditable" := true;
        "Direct Unit CostEditable" := true;
        QuantityEditable := true;
        "Cross-Reference No.Editable" := true;
        "No.Editable" := true;
        TypeEditable := true;
        // >>DITW15.00.00.01 DDR 18/12/2007

        PurchasesPayablesSetup.GET();
        Currency.InitRoundingPrecision();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    var
        ApplicationAreaSetup: Record "Application Area Setup";
    begin
        // IF ApplicationAreaSetup.IsFoundationEnabled THEN
        //     rec.Type := rec.Type::Item;//BC Upgrade SHARMP16--PID853

        //HEI.03<<
        if (Rec.Type <> Rec.Type::"G/L Account") then //and (Rec.Type <> Rec.Type::" ") then//BC Upgrade SHARMP16--PID853
            ERROR(Text001, Rec.Type);
        //HEI.03

    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
        // IndentLine := 0;
        // if not ISEMPTY then
        //   InitLineNo(ExpandLines,BelowxRec);
        // // >>DITW17.10.03 DDR DIT-770 #541
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
        // IF ApplicationAreaSetup.IsFoundationEnabled THEN // BC Upgrade SHUKLP03 << Blocked becaue no need of this condition.
        //rec.Type := rec.Type::Item;//SHARMP16 PTP160
        Rec.Type := Rec.Type::"G/L Account";//BC Upgrade SHARMP16--PID853
        NPOType := NPOType::"G/L Account";//BC Upgrade SHARMP16--PID853
        CLEAR(ShortcutDimCode);

        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        // SetFilterSubContractPostType2();
        // // >>DITW16.00.00.41 AHU DIT-715 #327
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    // trigger OnNextRecord(Steps: Integer): Integer;
    // begin
    //     // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
    //     // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //     // //EXIT(NEXT(Steps));
    //     // exit(NextRecordDIT(Steps,ExpandLines));
    //     // // >>DITW17.10.03 DDR DIT-770 #541
    //     // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    // end;//BC Upgrade SHARMP16--PID853

    trigger OnOpenPage();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // //<<FINXL7.00 RBE 06/08/2013
        PurchSetup.GET();//BC Upgrade SHARMP16--PID853
                         // //>>FINXL7.00 RBE 06/08/2013
                         // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                         // ExpandLines := false;
                         // ShowButtonsCE := IsShowButtonsCEDIT();
                         // // >>DITW17.10.03 DDR DIT-770 #541
                         // BC Upgrade SHUKLP03 << DrinkIT code blocked.
        GeneralLedgerSetup.Get();//BC Upgrade SHARMP16--PID853
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        GetTotalPurchHeader();   //BC Upgrade SHARMP16--PID853
        CalculateTotals();       //BC Upgrade SHARMP16--PID853

    end;

    var
        SuppressTotals: Boolean;//BC Upgrade SHARMP16--PID853
        TotalInclCAD: Decimal;//BC Upgrade SHARMP16--PID853
        HenekenCustFuncti: Codeunit "Heineken BC Custom Functions";
        EnableCAD: Boolean;
        GeneralLedgerSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        TotalPurchaseHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        SelectedPurchLine: Record "Purchase Line";
        TotalPurchaseLine: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        DocumentTotals: Codeunit "Document Totals";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        PurchAvailabilityMgt: Codeunit "Purch. Availability Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        UserMgt: Codeunit "User Setup Management";
        xRecRef: RecordRef;

        "Cross-Reference No.Editable": Boolean;

        "Direct Unit CostEditable": Boolean;
        DisabledRefreshLines: Boolean;
        Done: Boolean;

        ExpandLines: Boolean;
        InvDiscAmountEditable: Boolean;

        "Line AmountEditable": Boolean;

        "Line AmountEnable": Boolean;

        "No.Editable": Boolean;

        "No.Enable": Boolean;

        QuantityEditable: Boolean;

        QuantityEnable: Boolean;
        RowIsText: Boolean;

        ShowButtonsCE: Boolean;

        TypeEditable: Boolean;

        TypeEnable: Boolean;
        UnitofMeasureCodeIsChangeable: Boolean;

        "Unit Price (LCY)Enable": Boolean;
        ShortcutDimCode: array[8] of Code[20];
        InvoiceDiscountAmount: Decimal;
        InvoiceDiscountPct: Decimal;
        VATAmount: Decimal;
        IndentLine: Integer;
        //cduAppMgt : Codeunit ApplicationManagement;
        PageText2014410: Label 'Total Line Amount';
        PageText2014411: Label 'Total Direct Unit Cost';
        Text001: Label 'You are not allowed to insert lines with type %1.';
        //QualitySetup : Record "Quality Setup";
        //QualityManagement : Codeunit "Quality Management";

        // BC Upgrade MISHRS14 >>
        // Changed type from option to enum it has same field value.
        NPOType: Enum "Purchase Line Type";
        // BC Upgrade MISHRS14 <<
        //recFinXLSetup : Record "Finance XL Setup";
        txtIntrastatMandStyle: Text;

    procedure ApproveCalcInvDisc();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    local procedure ValidateInvoiceDiscountAmount();
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
        PurchCalcDiscByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount, PurchaseHeader);
        CurrPage.UPDATE(false);
    end;

    local procedure CalcInvDisc();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;

    local procedure ExplodeBOM();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;

    local procedure GetReceipt();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Get Receipt", Rec);
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

    local procedure NoOnAfterValidate();
    begin
        UpdateEditableOnRow();

        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // <<DITW15.00.00.36 DDR 25/11/2009 - DITW15.00.00.38 DDR 15/03/2011 #1291
        // if (Type <> Type::Item) and not "Is Item Charge" then
        // // >>DITW15.00.00.36 DDR - DITW15.00.00.38 DDR #1291
        //   InsertExtendedText(false);
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

    // BC Upgrade SHUKLP03 >> DrinkIT procedure blocked.
    // local procedure CrossReferenceNoOnAfterValidat();
    // begin
    //     /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

    //     // <<DITW15.00.00.38 DDR 27/01/2011 #1259
    //     //InsertExtendedText(FALSE);
    //     CurrPage.UPDATE;
    //     // >>DITW15.00.00.38 DDR #1259
    // end;
    // BC Upgrade SHUKLP03 << DrinkIT procedure blocked.

    local procedure RedistributeTotalsOnAfterValidate();
    begin
        if SuppressTotals then
            exit;//BC Upgrade SHARMP16--PID853

        CurrPage.SAVERECORD();//BC Upgrade SHARMP16--PID853

        DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
        CurrPage.UPDATE(false);//BC Upgrade SHARMP16--PID853
    end;

    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
        CurrPage.SAVERECORD();
    end;

    local procedure UpdateEditableOnRow();
    var
        PurchaseLine: Record "Purchase Line";
    begin
        RowIsText := (Rec."No." = '') and (Rec.Description <> '');
        if not RowIsText then
            UnitofMeasureCodeIsChangeable := Rec.CanEditUnitOfMeasureCode()
        else
            UnitofMeasureCodeIsChangeable := false;

        if TotalPurchaseHeader."No." <> '' then begin
            PurchaseLine.SETRANGE("Document No.", TotalPurchaseHeader."No.");
            PurchaseLine.SETRANGE("Document Type", TotalPurchaseHeader."Document Type");
            if not PurchaseLine.ISEMPTY then
                InvDiscAmountEditable :=
                  PurchCalcDiscByType.InvoiceDiscIsAllowed(TotalPurchaseHeader."Invoice Disc. Code") and CurrPage.EDITABLE;
        end;
    end;

    local procedure GetTotalPurchHeader();
    begin
        if not TotalPurchaseHeader.GET(Rec."Document Type", Rec."Document No.") then
            CLEAR(TotalPurchaseHeader);
        if Currency.Code <> TotalPurchaseHeader."Currency Code" then
            if not Currency.GET(TotalPurchaseHeader."Currency Code") then
                Currency.InitRoundingPrecision();
    end;

    procedure CalculateTotals()
    var
        PurchaseLine: Record "Purchase Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        if SuppressTotals then
            exit;
        GetTotalPurchHeader();   // <-- ADD THIS LINE

        DocumentTotals.PurchaseCheckIfDocumentChanged(Rec, xRec);
        DocumentTotals.CalculatePurchaseSubPageTotals(
          TotalPurchaseHeader, TotalPurchaseLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
        DocumentTotals.RefreshPurchaseLine(Rec);
        //BC Upgrade GUNREM01 >>
        //HEI.07>>
        TotalInclCAD := 0;
        GeneralLedgerSetup.GET();
        IF GeneralLedgerSetup."Enable CAD FND" THEN BEGIN
            IF TotalPurchaseLine."CAD Amount FND" <> 0 THEN BEGIN
                PurchaseLine.RESET();
                PurchaseLine.SETRANGE("Document Type", TotalPurchaseHeader."Document Type");
                PurchaseLine.SETRANGE("Document No.", TotalPurchaseHeader."No.");
                PurchaseLine.SETFILTER("CAD Attached to Line No. FND", '<>%1', 0);
                IF PurchaseLine.FINDFIRST() THEN
                    TotalInclCAD := TotalPurchaseLine."Amount Including VAT"
                ELSE
                    TotalInclCAD := TotalPurchaseLine."Amount Including VAT" + TotalPurchaseLine."CAD Amount FND";
            END ELSE
                TotalInclCAD := TotalPurchaseLine."Amount Including VAT";
        END;
        //HEI.07<<
        //BC Upgrade GUNREM01 << 
    end;//BC Upgrade SHARMP16--PID853

    procedure _InsertExtendedCharges(FromHeader: Boolean);
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
        // if InsertChargeLines(FromHeader) then
        //   UpdateForm(true);
        // // >>DITW15.00.00.23 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    procedure InsertExtendedCharges(FromHeader: Boolean);
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
        // if InsertChargeLines(FromHeader) then
        //   UpdateForm(true);
        // // >>DITW15.00.00.23 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    // BC Upgrade SHUKLP03 >> DrinkIT function blocked.
    // local procedure UpdateFields();
    // var
    //     CollapsedLine : Boolean;
    // begin
    //     BC Upgrade SHUKLP03 >> DrinkIT code blocked.
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
    //     BC Upgrade SHUKLP03 << DrinkIT code blocked.

    //     QuantityEditable := FormEditableField(FIELDNO(Quantity));
    //     "Direct Unit CostEditable" := FormEditableField(FIELDNO("Direct Unit Cost")) and not CollapsedLine;
    //     "Line AmountEditable" := FormEditableField(FIELDNO("Line Amount")) and not CollapsedLine;

    //     BC Upgrade SHUKLP03 << DrinkIT code blocked.
    //     // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    //     TypeEnable := FormEditableField(FIELDNO(Type));
    //     "No.Enable" := FormEditableField(FIELDNO("No."));
    //     QuantityEnable := FormEditableField(FIELDNO(Quantity));
    //     "Unit Price (LCY)Enable" := FormEditableField(FIELDNO("Unit Price (LCY)"));
    //     "Line AmountEnable" := FormEditableField(FIELDNO("Line Amount"));
    //     // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    //     BC Upgrade SHUKLP03 >> DrinkIT code blocked.
    // end;
    // BC Upgrade SHUKLP03 << DrinkIT function blocked.

    procedure NewLine();
    var
        PurchLine: Record "Purchase Line";
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW16.00.00.37 DIT-715 #1
        // if FINDLAST then;
        // PurchLine := Rec;
        // INIT;
        // "Document Type" := PurchLine."Document Type";
        // "Document No." := PurchLine."Document No.";
        // "Line No." := PurchLine."Line No." + 10000;
        // INSERT(true);
        // CurrPage.UPDATE(false);
        // // >>DITW16.00.00.37 DIT-715 #1
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    procedure DeleteLine();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW16.00.00.37 DIT-715 #1
        // DELETE(true);
        // CurrPage.UPDATE(false);
        // // >>DITW16.00.00.37 DIT-715 #1
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    // BC Upgrade SHUKLP03 >> DrinkIT functions are blocked.
    // procedure _OpenSSCCTrackingLines();
    // begin
    //     // <<DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745
    //     OpenSSCCTrackingLines();
    // end;

    // procedure OpenSSCCTrackingLines();
    // begin
    //     // <<DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745
    //     Rec.OpenSSCCTrackingLines();
    // end;
    // BC Upgrade SHUKLP03 << DrinkIT functions are blocked.

    local procedure TriggerOnDeleteRecord(): Boolean;
    var
        TempRec: Record "Purchase Line" temporary;
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
        if (Rec.Quantity <> 0) and Rec.ItemExists(Rec."No.") then begin
            COMMIT();
            if not ReservePurchLine.DeleteLineConfirm(Rec) then
                exit(false);

            // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
            // // <<QXL9.00.001 DAT 23/03/2016
            // if QualitySetup.READPERMISSION then begin
            //     if not QualityManagement.DeletePurchLineConfirm(Rec) then
            //         exit(false);
            // end;
            // // >>QXL9.00.001 DAT 23/03/2016
            // BC Upgrade SHUKLP03 << DrinkIT code blocked.

            ReservePurchLine.DeleteLine(Rec);

            // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
            // // <<QXL9.00.001 DAT 23/03/2016
            // if QualitySetup.READPERMISSION then
            //     QualityManagement.DeletePurchLine(Rec);
            // // >>QXL9.00.001 DAT 23/03/2016
            // BC Upgrade SHUKLP03 << DrinkIT code blocked.
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
        //     //>> DITW110.00.11 DDR 10/08/2017 NRQ#24875
        //     exit(false);
        // end;
        // // >>DITW15.00.00.36 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.

        exit(true);
    end;

    // BC Upgrade SHUKLP03 >> DrinkIT function blocked.
    // procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
    // begin
    //     // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    //     DisabledRefreshLines := NewDisabledRefreshLines;
    // end;
    // BC Upgrade SHUKLP03 << DrinkIT function blocked.
    procedure ClearTotalPurchaseHeader();
    begin
        Clear(TotalPurchaseHeader);
    end;//BC Upgrade SHARMP16--PID853

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
        //BC Upgrade SHARMP16--PID853 BEGIN<<
        if (rec.Type = rec.Type::Item) and
           (rec.Quantity <> xRec.Quantity) and
           not UpdateIsDone
        then
            CurrPage.UPDATE(true);
        //BC Upgrade SHARMP16--PID853 END>>
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

    // BC Upgrade SHUKLP03 >> DrinkIT codeunit Purch.-Get Blanket Order and Purch-Get Shipping Costs is called inside functions.
    // local procedure GetPurchBlanketOrder();
    // begin
    //     CODEUNIT.RUN(CODEUNIT::"Purch.-Get Blanket Order", Rec);//DITW17.00.02 SR 23/09/2013 DIT-770 #152
    // end;

    // local procedure GetShippingCostLines();
    // begin
    //     //<< DITW18.00.07 VSC 08/03/2016 DIT-770 #1066
    //     CODEUNIT.RUN(CODEUNIT::"Purch-Get Shipping Costs", Rec);
    // end;
    // BC Upgrade SHUKLP03 >> DrinkIT codeunit Purch.-Get Blanket Order and Purch-Get Shipping Costs is called inside functions.

    local procedure fctUpdateStyle();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // //<<FINXL9.00.000.01 ACH 05/01/2016
        // if "Intrastat Mandatory" then
        //     txtIntrastatMandStyle := 'Unfavorable'
        // else
        //     txtIntrastatMandStyle := 'Standard';
        // //>>FINXL9.00.000.01 ACH 05/01/2016
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;
}

