page 51057 "PostedPurchCrMemoLines CBN"
{
    // version NAVW110.0,FINXL9.00,DITW110.00.08

    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 02/01/2008 Added column "Line No." (not editable)
    //                                property Editable Form = yes (but all fields are non editable except Collapse button)
    // DITW15.00.00.01 DDR 15/01/2008 Added property Form InsertAllowed,ModifyAllowed,DeleteAllowed=No
    // DITW15.00.00.01 DDR 15/02/2008 Added function UpdateFormatField()
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
    //                                  "Empty Goods Item No."
    // DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //                     21/08/2009 issue 727 Added HorzAlign property in field "Direct Unit Cost","Line Amount"
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                                          Remove OnOpenForm() to set fields as non-editable
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    //                                  non editable field "Free Item"
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    // DITW16.00.00.39 DDR 26/09/2011 DIT-715 #141 Added "Total Amount" column for all line types
    // DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  Added function SetDisableRefreshLines() to call before/after each report object
    //                                                 (don't use the <RunObject> property)
    // DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added to call function SetFilterSubContractPostType() on AfterGetCurrRecord();
    //                                             Added to call function SetFilterSubContractPostType2() on OnNewRecord()
    //                                             Added fields "DIT Sub-Contract Type","Service Contract No.""Contract Group Code"
    //                 AHU 06/11/2012 DIT-715 #393 Added "Description 2" field
    // 
    // FINXL7.00.001 RBE 25/03/2013 : Added field: "Auto. Acc. Group"
    // 
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Direct Unit Cost"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field added: "CAD Amount"
    //   # Code added on 'OnOpenPage' trigger

    // Bc Upgrade YADAVM09 Cross-Reference No. Field obsolete in BC

    AutoSplitKey = true;
    Caption = 'Lines';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Purch. Cr. Memo Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = IndentLine;
                IndentationControls = Description;
                /* //Bc Upgrade YADAVM09 Drink it field Commented>>
                field("Has Item Charge";Rec."Has Item Charge")
                {
                    BlankZero = true;
                }
                field(Collapse;Rec.Collapse)
                {
                    Visible = false;

                    trigger OnValidate();
                    begin
                        // <<DITW15.00.00.37 DDR 19/01/2010
                        CurrPage.UPDATE(true);
                        // >>DITW15.00.00.37 DDR
                    end;
                }
                */ //Bc Upgrade YADAVM09 Drink it field Commented>>
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the line type.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies an item number that identifies the item or a general ledger account number that identifies the general ledger account used when posting the line.';
                }
                /* //Bc Upgrade YADAVM09 Cross-Reference No. Field obsolete in BC>>
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the cross-referenced item number. If you enter a cross reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the cross-reference number on a sales or purchase document.';
                }
                /* //Bc Upgrade YADAVM09 Cross-Reference No. Field obsolete in BC>>
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the code of the IC partner that the line has been distributed to.';
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the variant code for the item.';
                    Visible = false;
                }
                /* //Bc Upgrade YADAVM09 Drink it code commented>>
                field("GetTrackingItemNo()"; GetTrackingItemNo())
                {
                    Caption = 'Tracking Item No. (Item Charge)';
                    DrillDownPageID = "Item List";
                    Editable = false;
                    LookupPageID = "Item List";
                    TableRelation = IF ("Item Charge Type" = CONST(Tax)) Item where("No." = FIELD("Tax Item No."))
                    else IF ("Item Charge Type" = CONST(Deposit)) Item where("No." = FIELD("Empty Goods Item No."));
                    Visible = false;

                    trigger OnLookup(Text: Text): Boolean;
                    begin
                        // <<DITW15.00.00.38 DDR 17/12/2010 #703
                        Text := GetTrackingItemNo();
                        LookupItemNo(Text);
                        exit(false);
                    end;
                }
                */ //Bc Upgrade YADAVM09 Drink it code commented<<
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies either the name of, or a description of, the item or general ledger account.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    Description = 'DIT-715 #393';
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Description 2 field.';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies a code that explains why the item is returned.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = false;
                    ToolTip = 'Specifies the number of units of the item specified on the credit memo line.';
                }
                field("CAD Amount"; Rec."CAD Amount FND")
                {
                    Visible = EnableCAD;
                    ToolTip = 'Specifies the value of the CAD Amount field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the unit of measure code for the item.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    ToolTip = 'Specifies the unit of measure for the item (bottle or piece, for example).';
                    Visible = false;
                }
                field("Direct Unit Cost"; rec."Direct Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                    //AutoFormatExpression = Rec.GetTotalingAutoFormatExpr(2, FIELDNO(Rec."Direct Unit Cost"), false);//Bc Upgrade YADAVM09 Drink it function commented
                    AutoFormatType = 2014410;
                    BlankZero = true;
                    Editable = false;
                    ToolTip = 'Specifies the direct cost of one item unit.';
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the percentage indirect cost for the item.';
                    Visible = false;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the unit cost of the item on the line.';
                    Visible = false;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the price for one unit of the item.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = Basic, Suite;
                    //AutoFormatExpression = GetTotalingAutoFormatExpr(1, FIELDNO("Line Amount"), false);//Bc Upgrade YADAVM09 Drink it function Commented
                    AutoFormatType = 2014410;
                    BlankZero = true;
                    Editable = false;
                    ToolTip = 'Specifies the net amount (before subtracting the invoice discount amount) that must be paid for the items on the line.';
                }
                /* //Bc Upgrade YADAVM09 Drink it code Commented>>
                field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Direct Unit Cost"), true))
                {
                    AutoFormatExpression = GetCurrencyCode;
                    AutoFormatType = 2;
                    BlankZero = true;
                    CaptionClass = GetCaptionClassVar(PageText2014411);
                    Caption = 'Total Direct Unit Cost';
                    Description = 'DITW17.10.05 DIT-770 #988';
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                }
                field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), true))
                {
                    AutoFormatExpression = GetCurrencyCode;
                    AutoFormatType = 1;
                    BlankZero = true;
                    CaptionClass = GetCaptionClassVar(PageText2014410);
                    Caption = 'Total Line Amount';
                    Description = 'DITW17.10.02B DIT-770 #541';
                    Editable = false;
                    QuickEntry = false;
                }
                */ //Bc Upgrade YADAVM09 Drink it code commented<<
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = false;
                    ToolTip = 'Specifies the line discount % granted on items on each individual line.';
                }
                /* //Bc Upgrade YADAVM09 Drink it Function code commented>>
                field("Line Discount Amount"; GetTotalingAutoFormatExpr"Line Discount Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the discount amount that was granted on the line.';
                    Visible = false;
                }
                */ //Bc Upgrade YADAVM09 Drink it Function code commented<<
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Editable = false;
                    ToolTip = 'Specifies whether the credit memo line could have been included in an invoice discount calculation.';
                    Visible = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the job number the purchase invoice line is linked to.';
                    Visible = false;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the production order number.';
                    Visible = false;
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the insurance number on the purchase credit memo line.';
                    Visible = false;
                }
                field("Budgeted FA No."; Rec."Budgeted FA No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the budgeted FA number on the purchase credit memo line.';
                    Visible = false;
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the FA posting type of the purchase credit memo line.';
                    Visible = false;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies whether depreciation was calculated until the FA posting date of the line.';
                    Visible = false;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the depreciation book code on the purchase credit memo line.';
                    Visible = false;
                }
                field("Depr. Acquisition Cost"; Rec."Depr. Acquisition Cost")
                {
                    Editable = false;
                    ToolTip = 'Specifies whether, when this line was posted, the additional acquisition cost posted on the line was depreciated in proportion to the amount by which the fixed asset had already been depreciated.';
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of a particular item entry to which the credit memo was applied.';
                    Visible = false;
                }
                /* //Bc Upgrade YADAVM09 Drink it field Commented>>
                field("Free Item"; Rec."Free Item")
                {
                    Editable = false;
                }
                field("Free Item Posting Type"; Rec."Free Item Posting Type")
                {
                    Visible = false;
                }
                
                field("Gen. Prod. Posting Free Group"; Rec."Gen. Prod. Posting Free Group")
                {
                    Visible = false;
                }
                field("Contract Type"; "Contract Type")
                {
                    Editable = false;
                    Visible = false;
                }
                field("DIT Sub-Contract Type"; "DIT Sub-Contract Type")
                {
                    Visible = false;
                }
                field("Service Contract No."; "Service Contract No.")
                {
                    Visible = false;
                }
                field("Financial Contract No."; "Financial Contract No.")
                {
                    Visible = false;
                }
                field("Contract Group Code"; "Contract Group Code")
                {
                    Visible = false;
                }
                field("Auto. Acc. Group"; "Auto. Acc. Group")
                {
                    Description = 'FINXL7.00.001';
                    QuickEntry = false;
                    Visible = false;
                }
                 */ //Bc Upgrade YADAVM09 Drink it field Commented<<
                field("Deferral Code"; Rec."Deferral Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the deferral template that governs how expenses paid with this purchase document are deferred to the different accounting periods when the expenses were incurred.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2.';
                    Visible = false;
                }
            }
            group(Control33)
            {
                group(Control23)
                {
                    field("Invoice Discount Amount"; TotalPurchCrMemoHdr."Invoice Discount Amount")
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = TotalPurchCrMemoHdr."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetInvoiceDiscAmountWithVATCaption(TotalPurchCrMemoHdr."Prices Including VAT");
                        Caption = 'Invoice Discount Amount';
                        Editable = false;
                        ToolTip = 'Specifies a discount amount that is deducted from the value in the Total Incl. VAT field. You can enter or change the amount manually.';
                    }
                }
                group(Control9)
                {
                    field("Total Amount Excl. VAT"; TotalPurchCrMemoHdr.Amount)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = TotalPurchCrMemoHdr."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(TotalPurchCrMemoHdr."Currency Code");
                        Caption = 'Total Amount Excl. VAT';
                        DrillDown = false;
                        Editable = false;
                        ToolTip = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
                    }
                    field("Total VAT Amount"; VATAmount)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = TotalPurchCrMemoHdr."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalVATCaption(TotalPurchCrMemoHdr."Currency Code");
                        Caption = 'Total VAT';
                        Editable = false;
                        ToolTip = 'Specifies the sum of VAT amounts on all lines in the document.';
                    }
                    field("Total Amount Incl. VAT"; TotalPurchCrMemoHdr."Amount Including VAT")
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = TotalPurchCrMemoHdr."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(TotalPurchCrMemoHdr."Currency Code");
                        Caption = 'Total Amount Incl. VAT';
                        Editable = false;
                        Style = Strong;
                        StyleExpr = TRUE;
                        ToolTip = 'Specifies the sum of the value in the Line Amount Incl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            /* //Bc Upgrade YADAVM09 Drink it Action commented>>
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

               trigger OnAction();
               begin
                   // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                   ExpandLines := false;
                   CurrPage.UPDATE(true);
                   // >>DITW17.10.03 DDR DIT-770 #541
               end;
           }
            */ //Bc Upgrade YADAVM09 Drink it Action commented<<
            action(DeferralSchedule)
            {
                ApplicationArea = Suite;
                Caption = 'Deferral Schedule';
                Image = PaymentPeriod;
                ToolTip = 'View the deferral schedule that governs how expenses paid with this purchase document were deferred to different accounting periods when the document was posted.';

                trigger OnAction();
                begin
                    Rec.ShowDeferrals();
                end;
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
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
                action(Comments)
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ToolTip = 'Executes the Co&mments action.';

                    trigger OnAction();
                    begin
                        Rec.ShowLineComments();
                    end;
                }
                action(ItemTrackingEntries)
                {
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ToolTip = 'Executes the Item &Tracking Entries action.';

                    trigger OnAction();
                    begin
                        Rec.ShowItemTrackingLines();
                    end;
                }
                action(ItemReturnShipmentLines)
                {
                    AccessByPermission = TableData "Return Shipment Header" = R;
                    Caption = 'Item Return Shipment &Lines';
                    ToolTip = 'Executes the Item Return Shipment &Lines action.';

                    trigger OnAction();
                    begin
                        if not (Rec.Type in [Rec.Type::Item, Rec.Type::"Charge (Item)"]) then
                            Rec.TESTFIELD(Type);
                        Rec.ShowItemReturnShptLines();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        DocumentTotals.CalculatePostedPurchCreditMemoTotals(TotalPurchCrMemoHdr, VATAmount, Rec);
    end;
    /* //Bc Upgrade YADAVM09 Drink it function Commented>>
       trigger OnAfterGetRecord();
       begin
           // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
           IndentLine := IndentRecordDIT(ExpandLines);
           // >>DITW17.10.03 DDR DIT-770 #541
       end;

       trigger OnFindRecord(Which: Text): Boolean;
       begin
           // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
           if DisabledRefreshLines then
               exit(false);
           // >>DITW16.00.00.40 DDR DIT-715 #197
           // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
           //EXIT(FIND(Which));
           exit(FindRecordDIT(Which, ExpandLines));
           // >>DITW17.10.03 DDR DIT-770 #541
       end;

           trigger OnNextRecord(Steps: Integer): Integer;
           begin
               // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
               //EXIT(NEXT(Steps));
               exit(NextRecordDIT(Steps, ExpandLines));
               // >>DITW17.10.03 DDR DIT-770 #541
           end;
           */ //Bc Upgrade YADAVM09 Drink it function Commented>>

    trigger OnOpenPage();
    begin
        /* //Bc Upgrade YADAVM09 Drink it function Commented>>
        // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        ExpandLines := false;
        ShowButtonsCE := IsShowButtonsCEDIT();
        // >>DITW17.10.03 DDR DIT-770 #541
       */ //Bc Upgrade YADAVM09 Drink it function Commented<<
        //HEI.01>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.01<<
    end;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        TotalPurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        DocumentTotals: Codeunit "Document Totals";
        DisabledRefreshLines: Boolean;
        EnableCAD: Boolean;

        ExpandLines: Boolean;

        ShowButtonsCE: Boolean;
        VATAmount: Decimal;
        IndentLine: Integer;
        PageText2014410: Label 'Total Line Amount';
        PageText2014411: Label 'Total Direct Unit Cost';

    /* //Bc Upgrade YADAVM09 Drink it function commented>>
        procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
        begin
            // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
            DisabledRefreshLines := NewDisabledRefreshLines;
        end;
        */ //Bc Upgrade YADAVM09 Drink it function commented<<
}

