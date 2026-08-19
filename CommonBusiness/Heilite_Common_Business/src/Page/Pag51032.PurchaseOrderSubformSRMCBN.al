page 51032 "Purchase Order Subform SRM CBN"
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
    //   # Code added on OnValidate Trigger of Fields "VAT Prod. Posting Group" and "Location Code" to update "VAT Prod. Posting Group" and "TIN No."
    //   # Code added on OnValidate Trigger of Field "Quantity" to check if "TIN No." is filled-in
    // HEI.09 FDD_Ethiopia_Tolerance field for SPOT PO  Overdelivery_V0.1_HT630 IBM HORTOC01 28.06.2019 # new field added "Tolerance Received Over %"

    //BC UPGRADE SHIKHD02>>
    //In procedure ShowTracking(), blocked TrackingForm.SetPurchLine(Rec) as it is obsolete, and replaced it with SetVariantRec(Rec, Rec."No.", Rec."Outstanding Qty. (Base)", Rec."Expected Receipt Date", Rec."Expected Receipt Date")
    //BC UPGRADE SHIKHD02<<

    AutoSplitKey = true;
    CaptionML = ENU = 'Lines',
                ESP = 'Líneas',
                FRA = 'Lignes';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = where("Document Type" = FILTER(Order));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                /* // BC Upgrade MAnisha Drink it field commented
                field("Has Item Charge";Rec."Has Item Charge")
                {
                    BlankZero = true;
                    QuickEntry = false;
                }
                field(Collapse;Rec.Collapse)
                {
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;

                    trigger OnValidate();
                    begin
                        // <<DITW15.00.00.37 DDR 19/01/2010
                        CurrPage.UPDATE(true);
                        // >>DITW15.00.00.37 DDR
                    end;
                }
                */ // BC Upgrade MAnisha Drink it field commented
                field(Cancelled; Rec."Cancelled FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cancelled field.';
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    Enabled = TypeEnable;
                    QuickEntry = true;
                    ToolTip = 'Specifies the line type.';

                    trigger OnValidate();
                    begin
                        // TypeOnAfterValidate;// BC Upgrade Manisha Drink it code Commented
                        NoOnAfterValidate();
                        // TypeChosen := HasTypeToFillMandatotyFields; //BC Upgrade code obeslete my Microsof

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
                    ToolTipML = ENU = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.',
                                ESP = 'Permite especificar el número de una cuenta contable, un producto, un coste adicional o un activo fijo, según lo que se haya seleccionado en el campo Tipo.',
                                FRA = 'Spécifie le numéro d''un compte général, d''un article, d''un coût supplémentaire ou d''une immobilisation, selon la sélection effectuée dans le champ Type.';

                    trigger OnAssistEdit();
                    begin
                        /* //BC Upgrade Manisha Drink it code Commented>>
                        // <<DITW15.00.00.39 DDR 26/08/2011 #1393 - DITW16.00.00.40 DDR 03/05/2012 DIT-715 #276
                        if AssistEditItemTreeview("No.") then begin
                            // validate trigger
                            ShowShortcutDimCode(ShortcutDimCode);
                            // aftervalidate trigger
                            CurrPage.UPDATE(true);
                        end else
                            CurrPage.UPDATE(false);
                        // >>DITW15.00.00.39 DDR #1393 - DITW16.00.00.40 DDR DIT-715 #276
                        */ //BC Upgrade Manisha Drink it code Commented>>
                    end;

                    trigger OnValidate();
                    begin
                        /* //BC Upgrade Manisha Drink it code Commented>>
                        // <<DITW17.10.03 DDR 10/06/2014 DIT-770 #541
                        if not ("No.Editable" or "No.Enable") then begin
                            "No." := xRec."No.";
                            exit;
                        end;
                        // >>DITW17.10.03 DDR DIT-770 #541
                        */ //BC Upgrade Manisha Drink it code Commented>>
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate();

                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate();
                    end;
                }
                /* //BC Upgrade Manisha Drink it code Commented>>
                field("Revision No."; rec."Revision No.")
                {
                    Description = 'MANXL7.00.001';
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                }
                field("Requester ID"; "Requester ID")
                {
                    Description = 'MANXL7.00.001';
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                }
                /* //BC Upgrade Manisha Unsupported feature commented>>

                field("Cross-Reference No."; "Cross-Reference No.")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies the cross-referenced item number. If you enter a cross reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the cross-reference number on a sales or purchase document.',
                                ESP = 'Especifica el número de producto de la referencia cruzada. Si introduce una referencia cruzada entre su número de producto y el del proveedor o el cliente, sobrescribirá el número de producto estándar cuando introduzca el número de referencia cruzada en un documento de venta o de compra.',
                                FRA = 'Spécifie le numéro d''article à référence externe. Si vous saisissez une référence externe entre votre numéro d''article et celui de votre fournisseur ou client, ce numéro remplace le numéro d''article standard lorsque vous saisissez le numéro de référence externe sur un document vente ou achat.';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CrossReferenceNoLookUp;
                        // <<DITW15.00.00.38 DDR 27/01/2011 #1259
                        //InsertExtendedText(FALSE);
                        // >>DITW15.00.00.38 DDR #1259
                        NoOnAfterValidate;
                        // <<DITW15.00.00.38 DDR 27/01/2011 #1259
                        CurrPage.UPDATE;
                        // >>DITW15.00.00.38 DDR #1259
                    end;

                    trigger OnValidate();
                    begin
                        CrossReferenceNoOnAfterValidat;
                        NoOnAfterValidate;
                    end;
                }
                 */ //BC Upgrade Manisha  Unsupported feature commented<<

                field("IC Partner Code"; rec."IC Partner Code")
                {
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the IC partner code of the partner to whom you want to distribute the cost of the line.';
                }
                field("IC Partner Ref. Type"; rec."IC Partner Ref. Type")
                {
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the item or account in your IC partner''s company that corresponds to the item or account on the line.';
                }
                field("IC Partner Reference"; rec."IC Partner Reference")
                {
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'If the line is being sent to one of your intercompany partners, this field is used together with the IC Partner Ref. Type field to indicate the item or account in your partner''s company that corresponds to the line.';
                }
                field("Variant Code"; rec."Variant Code")
                {
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies a variant code for the item.';

                    trigger OnValidate();
                    begin
                        //VariantCodeOnAfterValidate;//BC Upgrade Manisha Drink it code Commented
                    end;
                }
                /* BC Upgrade Manisha Drink it code commented>>
                field("Emergency Order"; rec."Emergency Order")
                {
                    Editable = false;
                }
                */ //BC Upgrade Manisha Drink it code commented<<
                field(Nonstock; rec.Nonstock)
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies that this item is a nonstock item.';
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    Visible = false;
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
                }
                field("VAT Prod. Posting Group"; rec."VAT Prod. Posting Group")
                {
                    QuickEntry = false;
                    Visible = true;
                    ToolTip = 'Specifies the code for the VAT product posting group of the item or general ledger account on this line.';

                    trigger OnValidate();
                    begin
                        Rec.UpdateTINBAndVATProdPostGrByLocation(); //HEI.08
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                /* //BC Upgrade Manisha Drink it code commented>>

                field("GetTrackingItemNo()"; GetTrackingItemNo())
                {
                    CaptionML = ENU = 'Tracking Item No. (Item Charge)',
                                FRA = 'N° article traçable (Frais annexes)';
                    DrillDownPageID = "Item List";
                    Editable = false;
                    LookupPageID = "Item List";
                    QuickEntry = false;
                    TableRelation = IF ("Item Charge Type" = CONST(Tax)) Item where("No." = FIELD("Tax Item No."))
                    else IF ("Item Charge Type" = CONST(Deposit)) Item where("No." = FIELD("Empty Goods Item No."));
                    Visible = false;

                    trigger OnLookup(Text: Text): Boolean;
                    begin
                        // <<DITW15.00.00.38 DDR 17/12/2010 #703
                        Text := rec.GetTrackingItemNo();
                        LookupItemNo(Text);
                        exit(false);
                    end;
                }
                */ //BC Upgrade Manisha Drink it code commented<<

                field(Description; rec.Description)
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies a description of the item or service on the line.',
                                ESP = 'Permite especificar una descripción del producto o servicio en la línea.',
                                FRA = 'Spécifie une description de l''article ou du service sur la ligne.';
                }
                field("Description 2"; rec."Description 2")
                {
                    Description = 'DIT-715 #393';
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies information in addition to the description.';
                }
                field("Drop Shipment"; rec."Drop Shipment")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies if your vendor will ship the items on the line directly to your customer.',
                                ESP = 'Especifica si el proveedor enviará directamente al cliente los productos de la línea.',
                                FRA = 'Spécifie si vous souhaitez que votre fournisseur livre les articles de la ligne directement à votre client.';
                    Visible = false;
                }
                field("Return Reason Code"; rec."Return Reason Code")
                {
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies a code that explains why the item is returned.';
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';

                    trigger OnValidate();
                    begin
                        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        if rec."Responsibility Center" <> xRec."Responsibility Center" then
                            CurrPage.UPDATE(true);
                        // >>DITW18.00.06 DDR DIT-770 #1191
                    end;
                }
                /* //BC Upgrade Manisha Drink it code commented>>
                field("Physical Location Group Code"; rec."Physical Location Group Code")
                {
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;

                    trigger OnValidate();
                    begin
                        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                            CurrPage.UPDATE(true);
                        // >>DITW18.00.06 DDR DIT-770 #1191
                    end;
                }*/ //BC Upgrade Manisha Drink it code Commented>>
                field("Location Code"; rec."Location Code")
                {
                    Editable = false;
                    QuickEntry = false;
                    ToolTip = 'Specifies the code for the location where the items on the line will be located.';

                    trigger OnValidate();
                    begin
                        rec.UpdateTINBAndVATProdPostGrByLocation(); //HEI.08
                                                                    //LocationCodeOnAfterValidate; //BC Upgrade Manisha Drink it function Commented

                        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        //if xRec."Location Code" <> rec."Location Code" then //BC Upgrade Manisha Drink it code Commented
                        //  CurrPage.UPDATE(true);//BC Upgrade Manisha Drink it code Commented
                        // >>DITW18.00.06 DDR DIT-770 #1191
                    end;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies a bin code for the item.';
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    Editable = false;
                    Enabled = QuantityEnable;
                    QuickEntry = true;
                    ShowMandatory = TypeChosen;
                    ToolTip = 'Specifies the number of units of the item that will be specified on the line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        //QuantityOnAfterValidate; //BC Upgrade Manisha Drink it function Commented


                        //HEI.08>>
                        if rec."TIN No. FND" = '' then
                            Rec.UpdateTINBAndVATProdPostGrByLocation();
                        //HEI.08<<
                    end;
                }
                /* //BC Upgrade Manisha Drink it code Commented>>
                field("No. of Quality Tests"; rec."No. of Quality Tests")
                {
                    Editable = false;
                    QuickEntry = false;
                }
                */ //BC Upgrade Manisha Drink it code Commented<<

                field("Reserved Quantity"; rec."Reserved Quantity")
                {
                    BlankZero = true;
                    Editable = false;
                    QuickEntry = false;
                    ToolTip = 'Specifies how many item units on this line have been reserved.';
                }
                field("Job Remaining Qty."; rec."Job Remaining Qty.")
                {
                    BlankZero = true;
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the quantity that remains to complete a project.';
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    Enabled = UnitofMeasureCodeIsChangeable;
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies the unit of measure code for the item.',
                                ESP = 'Permite especificar el código de unidad de medida del producto.',
                                FRA = 'Spécifie le code unité de mesure de l''article.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        // UnitofMeasureCodeOnAfterValida; //BC Upgrade Manisha Drink it function Commented

                    end;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the name of the unit of measure for the item, such as 1 bottle or 1 piece.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                /* //BC Upgrade Manisha Drink it code Commented>>

                field("Tariff No."; rec."Tariff No.")
                {
                    Description = 'FINXL7.00.001';
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                }
                */ //BC Upgrade Manisha Drink it code Commented<<

                field("Net Weight"; rec."Net Weight")
                {
                    Description = 'FINXL7.00.001';
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the net weight of one unit of the item. In the purchase statistics window, the net weight on the line is included in the total net weight of all the lines for the particular purchase document.';
                }
                field("Direct Unit Cost"; rec."Direct Unit Cost")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    Editable = false;
                    QuickEntry = false;
                    ShowMandatory = TypeChosen;
                    ToolTipML = ENU = 'Specifies the direct cost of one item unit.',
                                ESP = 'Permite especificar el coste directo de una unidad del producto.',
                                FRA = 'Spécifie le coût direct d''une unité d''article.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        // DirectUnitCostOnAfterValidate;//BC Upgrade Manisha Drink it function Commented

                    end;
                }
                field("Indirect Cost %"; rec."Indirect Cost %")
                {
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the item''s indirect cost percentage.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Unit Cost (LCY)"; rec."Unit Cost (LCY)")
                {
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the unit cost of the item on the line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Unit Price (LCY)"; rec."Unit Price (LCY)")
                {
                    BlankZero = true;
                    Editable = false;
                    Enabled = "Unit Price (LCY)Enable";
                    QuickEntry = false;
                    Visible = false;
                    ToolTip = 'Specifies the price for one unit of the item.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Line Amount"; rec."Line Amount")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    Editable = false;
                    Enabled = "Line AmountEnable";
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies the net amount (before subtracting the invoice discount amount) that must be paid for the items on the line.',
                                ESP = 'Especifica el importe neto (antes de restar el importe de descuento de la factura) que se debe pagar por los productos de la línea.',
                                FRA = 'Spécifie le montant net (avant soustraction du montant remise facture) à payer pour les articles de la ligne.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        //LineAmountOnAfterValidate; //BC Upgrade Manisha Drink it function Commented

                    end;
                }
                /* //BC Upgrade Manisha Drink it code Commented>>
                field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Direct Unit Cost"), true))
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                    BlankZero = true;
                    CaptionClass = GetCaptionClassVar(PageText2014411);
                    CaptionML = ENU = 'Total Direct Unit Cost',
                                FRA = 'Total coût unitaire directe';
                    Description = 'DITW17.10.05 DIT-770 #988';
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                }
                
                field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), true))
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    BlankZero = true;
                    CaptionClass = GetCaptionClassVar(PageText2014410);
                    CaptionML = ENU = 'Total Line Amount',
                                FRA = 'Montant total ligne';
                    Description = 'DITW17.10.02B DIT-770 #541';
                    Editable = false;
                    QuickEntry = false;
                }
                 */ //BC Upgrade Manisha Drink it code Commented<<
                field("Line Discount %"; rec."Line Discount %")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    Editable = false;
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies the line discount percentage.',
                                ESP = 'Permite especificar el porcentaje de descuento de la línea.',
                                FRA = 'Spécifie le pourcentage remise ligne.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        //LineDiscount37OnAfterValidate;//BC Upgrade Manisha Drink it function Commented

                    end;
                }
                field("Line Discount Amount"; rec."Line Discount Amount")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the discount amount that is granted on the line.',
                                ESP = 'Permite especificar el importe de descuento que se concede en la línea.',
                                FRA = 'Spécifie le montant de la remise accordée à la ligne.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        // LineDiscountAmountOnAfterValid;//BC Upgrade Manisha Drink it function Commented

                    end;
                }
                field("Tolerance Received Over %"; rec."Tolerance Received Over % FND")
                {
                    Description = 'HEI.09';
                    ToolTip = 'Specifies the value of the Tolerance Received Over % field.';
                }
                field("SRM Contract No."; rec."SRM Contract No. FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the SRM Contract No. field.';
                }
                field("SRM Contract Line No."; rec."SRM Contract Line No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Contract Line No. field.';
                }
                field("SRM Order No."; rec."SRM Order No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Order No. field.';
                }
                field("SRM Order Line No."; rec."SRM Order Line No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Order Line No. field.';
                }
                field("Initial Quantity"; rec."Initial Quantity FND")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Initial Quantity field.';
                }
                field("Initial Amount"; rec."Initial Amount FND")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Initial Amount field.';
                }
                field("Remaining Amount"; rec."Remaining Amount FND")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Remaining Amount field.';
                }
                field("Delivery Finalized"; rec."Delivery Finalized FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Delivery Finalized field.';
                }
                /* //BC Upgrade Manisha Drink it code Commented>>
                field("App. Prod. Posting Group"; rec."App. Prod. Posting Group")
                {
                    Visible = false;
                }
                field("Approved Line Amount"; rec."Approved Line Amount")
                {
                    Visible = false;
                }
                 */ //BC Upgrade Manisha Drink it code Commented<<

                field("Prepayment %"; rec."Prepayment %")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the prepayment percentage to use to calculate the prepayment for purchases.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        //Prepayment37OnAfterValidate;//BC Upgrade Manisha Drink it function Commented

                    end;
                }
                field("Prepmt. Line Amount"; rec."Prepmt. Line Amount")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the prepayment amount of the line in the currency of the purchase document if a prepayment percentage is specified for the purchase line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                        // PrepmtLineAmountOnAfterValidat;//BC Upgrade Manisha Drink it function Commented

                    end;
                }
                field("Prepmt. Amt. Inv."; rec."Prepmt. Amt. Inv.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the prepayment amount that has already been invoiced to the customer for this purchase line.';

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Allow Invoice Disc."; rec."Allow Invoice Disc.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies whether the invoice line is included when the invoice discount is calculated.';
                }
                field("Inv. Discount Amount"; rec."Inv. Discount Amount")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the invoice discount amount for the line.',
                                ESP = 'Especifica el importe de descuento en factura para la línea.',
                                FRA = 'Spécifie le montant de la remise facture pour la ligne.';
                    Visible = false;
                }
                field("Qty. to Receive"; rec."Qty. to Receive")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    Editable = true;
                    ToolTipML = ENU = 'Specifies the quantity that remains to be invoiced. It is calculated as Quantity - Qty. Invoiced.',
                                ESP = 'Permite especificar la cantidad que queda por facturar. Se calcula como Cantidad menos Cdad. facturada.',
                                FRA = 'Spécifie la quantité restante à facturer. Le calcul est effectué comme suit : Quantité - Qté facturée.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        //QtytoReceiveOnAfterValidate; //BC Upgrade Manisha Drink it function Commented
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
                    Editable = false;
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies the quantity that remains to be invoiced. It is calculated as Quantity - Qty. Invoiced.',
                                ESP = 'Permite especificar la cantidad que queda por facturar. Se calcula como Cantidad menos Cdad. facturada.',
                                FRA = 'Spécifie la quantité restante à facturer. Le calcul est effectué comme suit : Quantité - Qté facturée.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        //  QtytoInvoiceOnAfterValidate;//BC Upgrade Manisha Drink it function Commented

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
                    ToolTip = 'Specifies how many units on the order line have not yet been received.';
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
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the prepayment amount that has already been deducted from ordinary invoices posted for this purchase order line.';

                    trigger OnValidate();
                    begin
                        //PrepmtAmttoDeductOnAfterValida; //BC Upgrade Manisha Drink it function Commented

                    end;
                }
                field("Prepmt Amt Deducted"; Rec."Prepmt Amt Deducted")
                {
                    Visible = false;
                    ToolTip = 'Specifies the prepayment amount that has already been deducted from ordinary invoices posted for this purchase order line.';
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies that you can assign item charges to this line.';
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
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
                    Editable = false;
                    Visible = false;
                    ToolTip = 'If you fill in this field and the Job Task No. field, then a job ledger entry will be posted together with the purchase order line.';
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the number of the job task that corresponds to the purchase document (invoice or credit memo).';
                }
                field("Job Planning Line No."; Rec."Job Planning Line No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the project planning line number that the usage should be linked to when the project journal is posted. You can only link to project planning lines that have the Apply Usage Link option enabled.';
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies a Job Planning Line together with the posting of a job ledger entry.';
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the sales price per unit that applies to the item or general ledger expense that will be posted.';
                }
                field("Job Line Amount"; Rec."Job Line Amount")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the net amount of the line that the purchase line applies to.';
                }
                field("Job Line Discount Amount"; Rec."Job Line Discount Amount")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the amount of the discount that the purchase line applies to.';
                }
                field("Job Line Discount %"; Rec."Job Line Discount %")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the line discount percent that applies to the item or general ledger expense.';
                }
                field("Job Total Price"; Rec."Job Total Price")
                {
                    Visible = false;
                    ToolTip = 'Specifies the gross amount of the line that the purchase line applies to.';
                }
                field("Job Unit Price (LCY)"; Rec."Job Unit Price (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the sales price per unit that applies to the item or general ledger expense that will be posted.';
                }
                field("Job Total Price (LCY)"; Rec."Job Total Price (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the gross amount of the line, in the local currency.';
                }
                field("Job Line Amount (LCY)"; Rec."Job Line Amount (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the net amount of the line that the purchase line applies to.';
                }
                field("Job Line Disc. Amount (LCY)"; Rec."Job Line Disc. Amount (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the amount of the discount that the purchase line applies to.';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the date that you want the vendor to deliver to the ship-to address. The value in the field is used to calculate the latest date you can order the items to have them delivered on the requested receipt date. If you do not need delivery on a specific date, you can leave the field blank.',
                                ESP = 'Permite especificar la fecha en la desea que el proveedor envíe el pedido a la dirección de envío. El valor del campo se usa para calcular la última fecha en la que puede solicitar los productos de forma que se envíen en la fecha de recepción solicitada. Si no necesita que se produzca el envío en una fecha específica, puede dejar el campo en blanco.',
                                FRA = 'Spécifie la date à laquelle vous souhaitez que le fournisseur livre les articles à l''adresse destinataire. La valeur du champ est utilisée pour calculer la date limite de commande garantissant la livraison des articles à la date de réception demandée. Si vous ne souhaitez pas indiquer une date de livraison, vous pouvez laisser ce champ vide.';
                    Visible = false;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Promised Receipt Date field.';
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                    Editable = false;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date when the item is planned to arrive in inventory. Forward calculation: planned receipt date = order date + vendor lead time (per the vendor calendar and rounded to the next working day in first the vendor calendar and then the location calendar). If no vendor calendar exists, then: planned receipt date = order date + vendor lead time (per the location calendar). Backward calculation: order date = planned receipt date - vendor lead time (per the vendor calendar and rounded to the previous working day in first the vendor calendar and then the location calendar). If no vendor calendar exists, then: order date = planned receipt date - vendor lead time (per the location calendar).';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Editable = false;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date you expect the items to be available in your warehouse.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies the date when the item is ordered. It is calculated backwards from the Planned Receipt Date field in combination with the Lead Time Calculation field.',
                                ESP = 'Permite especificar la fecha en que se solicitó el producto. Se calcula hacia atrás a partir del valor del campo Fecha recep. planificada junto con el campo Plazo entrega (días)',
                                FRA = 'Spécifie la date de commande de l''article. Elle est calculée en amont à partir du champ Date planifiée de réception et du champ Délai de réappro.';
                    Visible = false;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies whether the supply represented by this line is considered by the planning system when calculating action messages.';
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the number of the production order that the purchase order was created for.';
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the number of the related production order line.';
                }
                field("Operation No."; Rec."Operation No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the number of the related production operation.';
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the work center number of the journal line.';
                }
                field(Finished; Rec.Finished)
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies that any related service or operation is finished.';
                }
                /* //BC Upgrade Manisha Drink it code Commented>>

                field("Whse. Receipt No. (Open)"; "Whse. Receipt No. (Open)")
                {
                    Description = '#1399';
                    Lookup = false;
                    Visible = false;
                }
                 */ //BC Upgrade Manisha Drink it code Commented<<

                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    Visible = false;
                    ToolTip = 'Specifies how many units on the purchase order line remain to be handled in warehouse documents.';
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the time it takes to make items part of available inventory, after the items have been posted as received.';
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the document number of the blanket order from which this purchase line originates.';
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    Description = 'HEI.03';
                    Editable = false;
                    ToolTip = 'Specifies the line number of the blanket order line from which this purchase line originates.';
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the item ledger entry number the line should be applied to.',
                                ESP = 'Especifica el número del movimiento de producto al que se debería aplicar esta línea.',
                                FRA = 'Spécifie le numéro de l''écriture comptable article avec laquelle la ligne doit être lettrée.';
                    Visible = false;
                }
                /* //BC Upgrade Manisha Drink it code Commented>>
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Shipping Agent Service Code";"Shipping Agent Service Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Weight; Rec.Weight)
                {
                    Editable = false;
                }
                field(Cubage; Rec.Cubage)
                {
                    Editable = false;
                }
             

                field("ShortcutQtyUomValue[1]"; ShortcutQtyUomValue[1])
                {
                    BlankZero = true;
                    CaptionClass = GetCaptionClassUom(1);
                    DecimalPlaces = 0 : 5;
                    Description = 'DIT-715 #244';
                    Editable = false;
                    Visible = false;
                }
                field("ShortcutQtyUomValue[2]"; ShortcutQtyUomValue[2])
                {
                    BlankZero = true;
                    CaptionClass = GetCaptionClassUom(2);
                    DecimalPlaces = 0 : 5;
                    Description = 'DIT-715 #244';
                    Editable = false;
                    Visible = false;
                }
                field("ShortcutQtyUomValue[3]"; ShortcutQtyUomValue[3])
                {
                    BlankZero = true;
                    CaptionClass = GetCaptionClassUom(3);
                    DecimalPlaces = 0 : 5;
                    Description = 'DIT-715 #244';
                    Editable = false;
                    Visible = false;
                }
                field("Unit Volume HL"; "Unit Volume HL")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Vendor DTax Group Code"; "Vendor DTax Group Code")
                {
                    Description = 'DIT-770 #698';
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                }
                   
                field("Item DTax Group Code"; "Item DTax Group Code")
                {
                    Description = '<DITW15.00.00.01>- DIT-770 #698';
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                }
                field("Strength Spec. Code"; "Strength Spec. Code")
                {
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                }
                field("Strength Spec. Value"; "Strength Spec. Value")
                {
                    QuickEntry = false;
                    Visible = false;
                }
                field("Vol-Strength Spec. Code"; "Vol-Strength Spec. Code")
                {
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                }
                field("Vol-Strength Spec. Value"; "Vol-Strength Spec. Value")
                {
                    QuickEntry = false;
                    Visible = false;
                }
                 
                field("AAD No."; "AAD No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("ARC No."; "ARC No.")
                {
                    Description = 'DITW15.00.00.38 #1217';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(Text: Text): Boolean;
                    begin
                        // <<DITW15.00.00.38 DDR 30/09/2010 #1217
                        exit(
                          EDILookupExtTrackingARC(Text));
                        // >>DITW15.00.00.38 DDR
                    end;
                }
             
                field("SAD No."; "SAD No.")
                {
                    Description = 'DITW15.00.00.38 #1217';
                    Editable = false;
                    Visible = false;
                }
                field("Packaging Type Code"; "Packaging Type Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Applies-to AAD Trck. Entry No."; "Applies-to AAD Trck. Entry No.")
                {
                    Description = 'DITW15.00.00.39 #1369';
                    Editable = false;
                    Visible = false;
                }
                field("Free Reason Code"; "Free Reason Code")
                {
                    CaptionML = ENU = 'Free Reason Code',
                                FRA = 'Code motif gratuit';
                    Description = 'DITW17.10.05 DIT-770 #692';
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;

                    trigger OnValidate();
                    begin
                        // <<DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692
                        FreeReasoncodeOnAfterValidate
                        // >>DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692
                    end;
                }
                field("Free Item"; "Free Item")
                {
                    Editable = false;
                    QuickEntry = false;

                    trigger OnValidate();
                    begin
                        FreeItemOnAfterValidate;
                    end;
                }
                field("Allow VAT Calculation (Free)"; "Allow VAT Calculation (Free)")
                {
                    Description = 'DITW16.00.00.40 DIT-715 #172';
                    Editable = false;
                    Visible = false;

                    trigger OnValidate();
                    begin
                        AllowVATCalculationFreeOnAfter;
                    end;
                }
                field("Free Item Posting Type"; "Free Item Posting Type")
                {
                    Editable = false;
                    Visible = false;

                    trigger OnValidate();
                    begin
                        FreeItemPostingTypeOnAfterVali;
                    end;
                }
                  
                field("Contract Type"; "Contract Type")
                {
                    Editable = false;
                    Visible = false;
                }
                field("DIT Sub-Contract Type"; "DIT Sub-Contract Type")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Service Contract No."; "Service Contract No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Financial Contract No."; "Financial Contract No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Contract Group Code";"Contract Group Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Linked Customer No."; "Linked Customer No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Auto. Acc. Group"; "Auto. Acc. Group")
                {
                    Description = 'FINXL7.00.001';
                    Editable = false;
                    QuickEntry = false;
                    Visible = false;
                }
                 */ //BC Upgrade Manisha Drink it code Commented<<
                field("Deferral Code"; Rec."Deferral Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
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
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.',
                                ESP = 'Especifica el código de la dimensión del acceso directo 1.',
                                FRA = 'Spécifie le code pour Raccourci axe 1.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.',
                                ESP = 'Especifica el código de la dimensión del acceso directo 2.',
                                FRA = 'Spécifie le code pour Raccourci axe 2.';
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Editable = false;
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
                    Editable = false;
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
                    Editable = false;
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
                    Editable = false;
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
                    Editable = false;
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
                    Editable = false;
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
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the document number.';
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the line''s number.';
                }
                /* //BC Upgrade Manisha Drink it code commented>>
                                field("Backorder Type"; "Backorder Type")
                                {
                                    Caption = 'Backorder Type';
                                    Editable = false;
                                    Visible = false;
                                }
                     */ //BC Upgrade Manisha Drink it code commented<<

                field("WHT Absorb Base"; Rec."WHT Absorb Base FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the WHT Absorb Base field.';
                }
                field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
                }
                field("WHT Product Posting Group"; Rec."WHT Product Posting Group FND")
                {
                    Editable = false;
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
                    Editable = false;
                    ToolTip = 'You can use this field if you have selected Fixed Asset in the Type field for this line.';
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    Editable = false;
                    ToolTip = 'You can use this field if you have selected Fixed Asset in the Type field for this line.';
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the code for the depreciation book to which the line will be posted if you have selected Fixed Asset in the Type field for this line.';
                }
                field("TIN No."; Rec."TIN No. FND")
                {
                    Caption = 'TIN No.';
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
                        Editable = false;
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
                        ToolTip = 'Specifies the sum of amounts in the Line Amount field on the purchase order lines.';
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
                            //ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::"Event"); //BCUPG
                        end;
                    }
                    action("Items by Period")
                    {
                        CaptionML = ENU = 'Items by Period',
                                    FRA = 'Articles par période';
                        Description = 'DIT-715 #338';
                        ToolTip = 'Executes the Items by Period action.';

                        trigger OnAction();
                        begin
                            // <<DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338
                            //This functionality was copied from page #50. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.PAGE.*/
                            // _AllItemsAvailability(1); //BC Upgrade Manisha Drink it function Commented


                        end;
                    }
                    action(Period)
                    {
                        CaptionML = ENU = 'Period',
                                    ESP = 'Periodo',
                                    FRA = 'Période';
                        Image = Period;
                        ToolTip = 'Executes the Period action.';

                        trigger OnAction();
                        begin
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByPeriod())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Period);//BCUPG

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
                            //     ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Variant);//BCUPG

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
                            //   ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Location); //BCUPG

                        end;
                    }
                    action("Period (Items)")
                    {
                        CaptionML = ENU = 'Period (Items)',
                                    FRA = 'Période (Article)';
                        Description = 'DIT-715 #338';
                        ToolTip = 'Executes the Period (Items) action.';

                        trigger OnAction();
                        begin
                            // <<DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338
                            //This functionality was copied from page #50. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.PAGE.*/
                            //_AllItemsAvailability(0);//BC Upgrade Manisha code commented

                        end;
                    }
                    action("BOM Level")
                    {
                        CaptionML = ENU = 'BOM Level',
                                    ESP = 'Nivel L.M.',
                                    FRA = 'Niveau nomenclature';
                        Image = BOMLevel;
                        ToolTip = 'Executes the BOM Level action.';

                        trigger OnAction();
                        begin
                            //   ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::BOM);//BCUPG

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
                action("SSCC Tracking Lines")
                {
                    CaptionML = ENU = 'SSCC Tracking Lines',
                                FRA = 'Lignes Traçabilité SSCC';
                    Description = 'DIT-715 #745';
                    Image = ItemTrackingLines;
                    ToolTip = 'Executes the SSCC Tracking Lines action.';

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #50. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        //_OpenSSCCTrackingLines();//BC Upgrade Manisha Drink it code commented

                    end;
                }
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
                        rec.ShowItemChargeAssgnt();
                    end;
                }
                action(DeferralSchedule)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Deferral Schedule',
                                ESP = 'Previsión fraccionamiento',
                                FRA = 'Tableau d''échelonnement';
                    Enabled = rec."Deferral Code" <> '';
                    Image = PaymentPeriod;
                    ToolTip = 'Executes the DeferralSchedule action.';

                    trigger OnAction();
                    begin
                        PurchHeader.GET(rec."Document Type", rec."Document No.");
                        rec.ShowDeferrals(PurchHeader."Posting Date", PurchHeader."Currency Code")
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
                        rec.FIND();
                        rec.ShowReservation();
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
                            rec.GetBlanketOrderPrice();
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
                action("Quality Tests")
                {
                    CaptionML = ENU = 'Quality Tests',
                                FRA = 'Testes qualité';
                    ToolTip = 'Executes the Quality Tests action.';

                    trigger OnAction();
                    begin
                        // <<DITW15.00.00.38 PRODW14.00.00.17 DDR 08/02/2011 #1271
                        //This functionality was copied from page #50. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        //_ShowQualityTests(); //BC Upgrade Manisha Drink it function Commented


                    end;
                }
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
                        rec.TESTFIELD("Blanket Order No.");
                        PurchaseHeader.SETRANGE("No.", rec."Blanket Order No.");
                        if not PurchaseHeader.ISEMPTY then begin
                            BlanketPurchaseOrder.SETTABLEVIEW(PurchaseHeader);
                            BlanketPurchaseOrder.EDITABLE := false;
                            BlanketPurchaseOrder.RUN();
                        end;
                    end;
                }
                /* //BC Upgrade Manisha Drink it code commented>>

                action(Action2035090)
                {
                    CaptionML = ENU = 'Quality Tests',
                                FRA = 'Tests qualité';

                    trigger OnAction();
                    begin
                        //<<QXL9.00.001 DAT 23/03/2016
                        ShowQualityTests();
                        //>>QXL9.00.001 DAT 23/03/2016
                    end;
                }
                */ //BC Upgrade Manisha Drink it code commented<<

            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        /* //BC Upgrade Manisha Drink it code Commented>>

        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        Rec.SETFILTER("Resp. Center Table Filter",
          UserMgt.GetRespCenterFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        SETFILTER("Phys. Location Table Filter",
          UserMgt.GetRespPhysLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        SETFILTER("Location Table Filter",
          UserMgt.GetRespLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // >>DITW18.00.06 DDR DIT-770 #1191
        // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        SetFilterSubContractPostType();
        // >>DITW16.00.00.41 AHU DIT-715 #327
       */ //BC Upgrade Manisha Drink it code Commented<<

        UpdateEditableOnRow();
        if PurchHeader.GET(Rec."Document Type", Rec."Document No.") then;

        DocumentTotals.PurchaseUpdateTotalsControls(Rec, TotalPurchaseHeader, TotalPurchaseLine, RefreshMessageEnabled,
          TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, VATAmount);

        // <<DITW15.00.00.01 DDR 18/12/2007
        // VIGEO VS 29-12-2005: Toeslag regels mogen niet worden gewijzigd. Dit moet op het hoofdartikel worden gedaan.
        // UpdateFields(); //BC Upgrade Manisha Drink it code commented
        // >>DITW15.00.00.01 DDR 18/12/2007
    end;

    trigger OnAfterGetRecord();
    begin
        /* //BC Upgrade Manisha Drink it code Commented>>

        // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        IndentLine := IndentRecordDIT(ExpandLines);
        // >>DITW17.10.03 DDR DIT-770 #541
         */ //BC Upgrade Manisha Drink it code Commented<<


        Rec.ShowShortcutDimCode(ShortcutDimCode);

        /* //BC Upgrade Manisha Drink it code Commented>>

        // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
        ShowShortcutUomValue(ShortcutQtyUomValue);
        // >>DITW16.00.00.40 DDR DIT-715 #244
        */ //BC Upgrade Manisha Drink it code Commented<<


        //TypeChosen := HasTypeToFillMandatotyFields;//BC Upgrade code obeslete my Microsoft
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

    trigger OnFindRecord(Which: Text): Boolean;
    begin
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        if DisabledRefreshLines then
            exit(false);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        //EXIT(FIND(Which));

        //exit(FindRecordDIT(Which, ExpandLines)); //BC Upgrade Manisha Drink it code Commented

        // >>DITW17.10.03 DDR DIT-770 #541
    end;

    trigger OnInit();
    begin
        // <<DITW15.00.00.01 DDR 18/12/2007
        "Line AmountEnable" := true;
        "Unit Price (LCY)Enable" := true;
        QuantityEnable := true;
        "No.Enable" := true;
        TypeEnable := true;
        "Qty. to InvoiceEditable" := true;
        "Qty. to ReceiveEditable" := true;
        //HEI.06>>
        //"Line AmountEditable" := TRUE;
        "Line AmountEditable" := false;
        //HEI.06<<
        "Direct Unit CostEditable" := true;
        QuantityEditable := true;
        "Cross-Reference No.Editable" := true;
        "No.Editable" := true;
        TypeEditable := true;
        // >>DITW15.00.00.01 DDR 18/12/2007
        // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        GlobalTax1ValueEditable := true;
        GlobalTax2ValueEditable := true;
        // >>DITW19.00.08 DDR BL#10443
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        // if ApplicationAreaSetup.IsFoundationEnabled then//BC Upgrade Manisha Function removed by Microsoft
        // rec.Type := rec.Type::Item;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        /* //BC Upgrade Manisha Drink it code commented>>

        // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
        IndentLine := 0;
        if not ISEMPTY then
            InitLineNo(ExpandLines, BelowxRec);
        // >>DITW17.10.03 DDR DIT-770 #541

        if ApplicationAreaSetup.IsFoundationEnabled then
            rec.Type := rec.Type::Item
        else
            InitType;
        CLEAR(ShortcutDimCode);

        // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        //SetFilterSubContractPostType2();//BC Upgrade Manisha Drink it code commented

        // >>DITW16.00.00.41 AHU DIT-715 #327
        */ //BC Upgrade Manisha Drink it code commented<<

    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    begin
        /* //BC Upgrade Manisha Drink it code commented>>

        // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        exit(NextRecordDIT(Steps, ExpandLines));
        // >>DITW17.10.03 DDR DIT-770 #541
        */ //BC Upgrade Manisha Drink it code commented<<

    end;

    trigger OnOpenPage();
    begin
        /* //BC Upgrade Manisha Drink it code commented>>

        // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        ExpandLines := false;
        ShowButtonsCE := IsShowButtonsCEDIT();
        // >>DITW17.10.03 DDR DIT-770 #541
        */ //BC Upgrade Manisha Drink it code commented<<

    end;

    var
        ApplicationAreaSetup: Record "Application Area Setup";
        PurchHeader: Record "Purchase Header";
        TotalPurchaseHeader: Record "Purchase Header";
        TotalPurchaseLine: Record "Purchase Line";
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
        EditableDesc: Boolean;

        ExpandLines: Boolean;

        GlobalTax1ValueEditable: Boolean;

        GlobalTax2ValueEditable: Boolean;
        InvDiscAmountEditable: Boolean;

        "Line AmountEditable": Boolean;

        "Line AmountEnable": Boolean;

        "No.Editable": Boolean;

        "No.Enable": Boolean;

        "Qty. to InvoiceEditable": Boolean;

        "Qty. to ReceiveEditable": Boolean;

        QuantityEditable: Boolean;

        QuantityEnable: Boolean;
        RefreshMessageEnabled: Boolean;

        ShowButtonsCE: Boolean;
        TypeChosen: Boolean;

        TypeEditable: Boolean;

        TypeEnable: Boolean;
        UnitofMeasureCodeIsChangeable: Boolean;

        "Unit Price (LCY)Enable": Boolean;
        ShortcutDimCode: array[8] of Code[20];
        ShortcutQtyUomValue: array[3] of Decimal;
        VATAmount: Decimal;
        IndentLine: Integer;
        GetBlanketOrderPriceQst: Label 'Do you want to get the blanket order price?';
        RefreshMessageText: Text;
        TotalAmountStyle: Text;
        //cduAppMgt: Codeunit ApplicationManagement;//BC Upgrade Manisha
        //cduAppMgt: Codeunit ui;
        //QualitySetup: Record "Quality Setup"; //BC Upgrade Manisha drink it object
        //QualityManagement: Codeunit "Quality Management";//BC Upgrade Manisha drink it object
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Direct Unit Cost', FRA = 'Total coût unitaire directe';
        Text001: TextConst ENU = 'You cannot use the Explode BOM function because a prepayment of the purchase order has been invoiced.', ESP = 'No puede usar la función Desplegar L.M. puesto que se ha facturado un prepago del pedido de compra.', FRA = 'Vous ne pouvez pas utiliser la fonction Éclater nomenclature car un acompte de la commande achat a été facturé.';
        Text2014260: TextConst ENU = 'There are no valid lines to use this function.', FRA = 'Il n''a pas de lignes valide pour utiliser cette fonction';
        UpdateInvDiscountQst: TextConst ENU = 'One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?', ESP = 'Se han facturado una o varias líneas. No se tendrá en cuenta el descuento distribuido entre las líneas facturadas.\\¿Desea actualizar el descuento en factura?', FRA = 'Une ou plusieurs lignes ont été facturées. La remise répartie sur les lignes facturées n''est pas prise en compte.\\Voulez-vous mettre à jour la remise facture ?';

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
        //BC UPGRADE SHIKHD02>>
        //Blocked TrackingForm.SetPurchLine(Rec) as it is obsolete, and added TrackingForm.SetVariantRec(...)
        //TrackingForm.SetPurchLine(Rec);
        TrackingForm.SetVariantRec(
        Rec,
        Rec."No.",
        Rec."Outstanding Qty. (Base)",
        Rec."Expected Receipt Date",
        Rec."Expected Receipt Date");
        //BC UPGRADE SHIKHD02<<
        TrackingForm.RUNMODAL();
    end;

    local procedure OpenSpecOrderSalesOrderForm();
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        rec.TESTFIELD(rec."Special Order Sales No.");
        SalesHeader.SETRANGE("No.", rec."Special Order Sales No.");
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
        /* //BC Upgrade Manisha Drink it code Commented>>

        // <<DITW15.00.00.35 DDR 29/06/2009 - DITW15.00.00.38 DDR 15/03/2011 #1291
        if (Rec.Type <> Rec.Type::Item) and not Rec."Is Item Charge" then
            // >>DITW15.00.00.35 DDR - DITW15.00.00.38 DDR #1291
            InsertExtendedText(false);
        if (Type = Type::"Charge (Item)") and ("No." <> xRec."No.") and
           (xRec."No." <> '')
        then
            CurrPage.SAVERECORD;

        // <<DITW15.00.00.23 DDR 30/07/2008
        CurrPage.UPDATE;
        // >>DITW15.00.00.23 DDR
         */ //BC Upgrade Manisha Drink it code Commented<<

    end;

    local procedure CrossReferenceNoOnAfterValidat();
    begin
        // <<DITW15.00.00.38 DDR 27/01/2011 #1259
        //InsertExtendedText(FALSE);
        CurrPage.UPDATE();
        // >>DITW15.00.00.38 DDR #1259
    end;

    local procedure RedistributeTotalsOnAfterValidate();
    begin
        CurrPage.SAVERECORD();

        PurchHeader.GET(rec."Document Type", rec."Document No.");
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

    /* //BC Upgrade Manisha Drink it code Commented>>

        procedure _InsertExtendedCharges(FromHeader: Boolean);
        begin
            // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
            if InsertChargeLines(FromHeader) then
                UpdateForm(true);
            // >>DITW15.00.00.23 DDR
        end;

        procedure InsertExtendedCharges(FromHeader: Boolean);
        begin
            // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
            if InsertChargeLines(FromHeader) then
                UpdateForm(true);
            // >>DITW15.00.00.23 DDR
        end;

        local procedure UpdateFields();
        var
            CollapsedLine: Boolean;
        begin
            // <<DITW15.00.00.01 DDR 15/02/2008 - DITW15.00.00.38 DDR 16/07/2010 #1194
            // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
            CollapsedLine := not ExpandLines;
            // >>DITW17.10.03 DDR DIT-770 #541
            // <<DITW17.10.03 DDR 09/07/2014 DIT-770 #541
            CALCFIELDS("Has Item Charge");
            CollapsedLine := CollapsedLine and "Has Item Charge";
            // >>DITW17.10.03 DDR DIT-770 #541
            TypeEditable := FormEditableField(FIELDNO(Type));
            "No.Editable" := FormEditableField(FIELDNO("No."));
            // <<DITW15.00.00.38 DDR 27/01/2011 #1259
            "Cross-Reference No.Editable" := FormEditableField(FIELDNO("Cross-Reference No."));
            // >>DITW15.00.00.38 DDR #1259

            QuantityEditable := FormEditableField(FIELDNO(Quantity));
            "Direct Unit CostEditable" := FormEditableField(FIELDNO("Direct Unit Cost")) and not CollapsedLine;
            //HEI.06>>
            //"Line AmountEditable" := FormEditableField(FIELDNO("Line Amount")) AND NOT CollapsedLine;
            //HEI.06<<

            "Qty. to ReceiveEditable" := FormEditableField(FIELDNO("Qty. to Receive"));
            "Qty. to InvoiceEditable" := FormEditableField(FIELDNO("Qty. to Invoice"));

            // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
            TypeEnable := FormEditableField(FIELDNO(Type));
            "No.Enable" := FormEditableField(FIELDNO("No."));
            QuantityEnable := FormEditableField(FIELDNO(Quantity));
            "Unit Price (LCY)Enable" := FormEditableField(FIELDNO("Unit Price (LCY)"));
            "Line AmountEnable" := FormEditableField(FIELDNO("Line Amount"));
            // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1

            // <<DITW19.00.08 DDR 17/08/2016 BL#10443
            GlobalTax1ValueEditable := HasTaxSpecEditable("Strength Spec. Code");
            GlobalTax2ValueEditable := HasTaxSpecEditable("Vol-Strength Spec. Code");
            // >>DITW19.00.08 DDR BL#10443
        end;
   

    procedure _ShowGetARCNoEDI();
    var
        SelectedPurchLines: Record "Purchase Line";
        NewARCNo: Code[30];
        NewText: Text[1024];
    begin
        // <<DITW15.00.00.38 DDR 30/09/2010 #1217
        CLEAR(SelectedPurchLines);
        CurrPage.SETSELECTIONFILTER(SelectedPurchLines);
        SelectedPurchLines.SETFILTER("No.", '<>%1', '');
        SelectedPurchLines.SETRANGE("ARC No. Mandatory", true);
        if SelectedPurchLines.findset then begin
            repeat
                SelectedPurchLines.TESTFIELD("ARC No.", '');
            until SelectedPurchLines.NEXT = 0;
        end else
            ERROR(Text2014260);

        // <<DITW15.00.00.38 DDR 17/12/2010 #703
        if SelectedPurchLines.EDILookupExtTrackingARC(NewText) then begin
            NewARCNo := NewText;
            if SelectedPurchLines.findset(true) then
                repeat
                    SelectedPurchLines.VALIDATE("ARC No.", NewARCNo);
                    SelectedPurchLines.MODIFY(true);
                until SelectedPurchLines.NEXT = 0;
            Rec := SelectedPurchLines;
            CurrPage.UPDATE(false);
        end;
    end;

    procedure ShowGetARCNoEDI();
    var
        SelectedPurchLines: Record "Purchase Line";
        NewARCNo: Code[30];
        NewText: Text[1024];
    begin
        // <<DITW15.00.00.38 DDR 30/09/2010 #1217
        CLEAR(SelectedPurchLines);
        CurrPage.SETSELECTIONFILTER(SelectedPurchLines);
        SelectedPurchLines.SETFILTER("No.", '<>%1', '');
        SelectedPurchLines.SETRANGE("ARC No. Mandatory", true);
        if SelectedPurchLines.findset then begin
            repeat
                SelectedPurchLines.TESTFIELD("ARC No.", '');
            until SelectedPurchLines.NEXT = 0;
        end else
            ERROR(Text2014260);

        // <<DITW15.00.00.38 DDR 17/12/2010 #703
        if SelectedPurchLines.EDILookupExtTrackingARC(NewText) then begin
            NewARCNo := NewText;
            if SelectedPurchLines.findset(true) then
                repeat
                    SelectedPurchLines.VALIDATE("ARC No.", NewARCNo);
                    SelectedPurchLines.MODIFY(true);
                until SelectedPurchLines.NEXT = 0;
            Rec := SelectedPurchLines;
            CurrPage.UPDATE(false);
        end;
    end;

    procedure _ShowQualityTests();
    var
        QualityTestHeader: Record "Quality Test Header";
    begin
        // <<DITW15.00.00.38 PRODW14.00.00.17 DDR 08/02/2011 #1271
        QualityTestHeader.SETCURRENTKEY(
          "Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
        QualityTestHeader.FILTERGROUP(2);
        QualityTestHeader.SETRANGE("Source ID", "Document No.");
        QualityTestHeader.SETRANGE("Source Type", DATABASE::"Purchase Line");
        QualityTestHeader.SETRANGE("Source Subtype", "Document Type");
        QualityTestHeader.SETRANGE("Source Ref. No.", "Line No.");
        QualityTestHeader.FILTERGROUP(0);
        QualityTestHeader.SETRANGE("Item No.", "No.");
        PAGE.RUNMODAL(0, QualityTestHeader);
    end;
     


    procedure ShowQualityTests();
    var
        QualityTestHeader: Record "Quality Test Header";
    begin
        //<<QXL9.00.001 DAT 23/03/2016
        QualityTestHeader.SETCURRENTKEY(
          "Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
        QualityTestHeader.FILTERGROUP(2);
        QualityTestHeader.SETRANGE("Source ID", rec."Document No.");
        QualityTestHeader.SETRANGE("Source Type", DATABASE::"Purchase Line");
        QualityTestHeader.SETRANGE("Source Subtype", "Document Type");
        QualityTestHeader.SETRANGE("Source Ref. No.", "Line No.");
        QualityTestHeader.FILTERGROUP(0);
        QualityTestHeader.SETRANGE("Item No.", "No.");
        PAGE.RUNMODAL(0, QualityTestHeader);
        //>>QXL9.00.001 DAT 23/03/2016
    end;

    procedure _OpenSSCCTrackingLines();
    begin
        // <<DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745
        Rec.OpenSSCCTrackingLines();
    end;

    procedure OpenSSCCTrackingLines();
    begin
        // <<DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745
        Rec.OpenSSCCTrackingLines();
    end;
 */ //BC Upgrade Manisha Drink it code Commented<<
    procedure TriggerOnDeleteRecord(): Boolean;
    var
        TempRec: Record "Purchase Line" temporary;
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
        // cronus
        /* //BC Upgrade Manisha Drink it code commented>>
        if (Quantity <> 0) and ItemExists("No.") then begin
            COMMIT;
            if not ReservePurchLine.DeleteLineConfirm(Rec) then
                exit(false);

            // <<QXL9.00.001 DAT 23/03/2016
            if QualitySetup.READPERMISSION then begin
                if not QualityManagement.DeletePurchLineConfirm(Rec) then
                    exit(false);
            end;
            // >>QXL9.00.001 DAT 23/03/2016

            ReservePurchLine.DeleteLine(Rec);

            // <<QXL9.00.001 DAT 23/03/2016
            if QualitySetup.READPERMISSION then
                QualityManagement.DeletePurchLine(Rec);
            // >>QXL9.00.001 DAT 23/03/2016
        end;
        
                // <<DITW15.00.00.36 DDR 23/11/2009
                if "Is Item Charge" and "ItemCharge Incl. Price" then begin
                    DELETE(true);
                    TempRec := Rec;
                    TempRec."Direct Unit Cost" := 0;
                    TempRec."Line Amount" := 0;
                    TempRec."Line Discount Amount" := 0;
                    //<< DITW110.00.11 DDR 10/08/2017 NRQ#24875
                    //TempRec.CalcBackDirectCostItem();///* //BC Upgrade Manisha Drink it code commented
                    //>> DITW110.00.11 DDR 10/08/2017 NRQ#24875
                    exit(false);
                end;
                // >>DITW15.00.00.36 DDR
                */ //BC Upgrade Manisha Drink it code commented<<
        exit(true);
    end;
    /* //BC Upgrade Manisha Drink it code Commented>>
        procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
        begin
            // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
            DisabledRefreshLines := NewDisabledRefreshLines;
        end;

        procedure _AllItemsAvailability(AvailabilityType: Option Date2,Date3);
        begin
            // <<DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338
            Rec.AllItemsAvailability(AvailabilityType);
        end;

        procedure AllItemsAvailability(AvailabilityType: Option Date2,Date3);
        begin
            // <<DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338
            Rec.AllItemsAvailability(AvailabilityType);
        end;

        local procedure TypeOnAfterValidate();
        begin
            // <<DITW15.00.00.01 DDR 15/01/2008
            if Type <> xRec.Type then
                CurrPage.UPDATE;
            // >>DITW15.00.00.01 DDR
        end;

        local procedure VariantCodeOnAfterValidate();
        begin
            // <<DITW15.00.00.01 DDR DDR 15/01/2008
            if (Type = Type::Item) and
               (xRec."Variant Code" <> "Variant Code")
            then
                CurrPage.UPDATE(true);
            // >>DITW15.00.00.01 DDR
        end;

        local procedure LocationCodeOnAfterValidate();
        var
            UpdateIsDone: Boolean;
        begin
            // <<DITW15.00.00.01 DDR DDR 15/01/2008
            if (Type = Type::Item) and
               not UpdateIsDone
            then
                CurrPage.UPDATE(true);
            // >>DITW15.00.00.01 DDR
        end;

        local procedure QuantityOnAfterValidate();
        var
            UpdateIsDone: Boolean;
        begin
            // <<DITW15.00.00.01 DDR DDR 15/01/2008
            if (Type = Type::Item) and
               (Quantity <> xRec.Quantity) and
               not UpdateIsDone
            then
                CurrPage.UPDATE(true);
            // >>DITW15.00.00.01 DDR
        end;

        local procedure UnitofMeasureCodeOnAfterValida();
        var
            UpdateIsDone: Boolean;
        begin
            // <<DITW15.00.00.01 DDR DDR 15/01/2008
            if (Type = Type::Item) and
               not UpdateIsDone
            then
                CurrPage.UPDATE(true);
            // >>DITW15.00.00.01 DDR
        end;

        local procedure DirectUnitCostOnAfterValidate();
        begin
            // <<DITW15.00.00.01 DDR 21/12/2007
            if (Type = Type::Item) and
               ("Direct Unit Cost" <> xRec."Direct Unit Cost")
            then
                CurrPage.UPDATE(true);
            // >>DITW15.00.00.01 DDR
        end;

        local procedure LineAmountOnAfterValidate();
        begin
            // <<DITW15.00.00.01 DDR 21/12/2007
            if (Type = Type::Item) and
               ("Line Amount" <> xRec."Line Amount")
            then
                CurrPage.UPDATE(true);
            // >>DITW15.00.00.01 DDR
        end;

        local procedure LineDiscount37OnAfterValidate();
        begin
            // <<DITW15.00.00.01 DDR 21/12/2007
            if (Type = Type::Item) and
               ("Line Discount %" <> xRec."Line Discount %")
            then
                CurrPage.UPDATE(true);
            // >>DITW15.00.00.01 DDR
        end;

        local procedure LineDiscountAmountOnAfterValid();
        begin
            // <<DITW15.00.00.01 DDR 21/12/2007
            if (Type = Type::Item) and
               ("Line Discount Amount" <> xRec."Line Discount Amount")
            then
                CurrPage.UPDATE(true);
            // >>DITW15.00.00.01 DDR
        end;

        local procedure Prepayment37OnAfterValidate();
        begin
            // <<DITW15.00.00.23 DDR 11/08/2008
            if (Type = Type::Item) and
               ("Prepayment %" <> xRec."Prepayment %")
            then
                CurrPage.UPDATE(true);
            // >>DITW15.00.00.23 DDR
        end;

        local procedure PrepmtLineAmountOnAfterValidat();
        begin
            // <<DITW15.00.00.23 DDR 11/08/2008
            if (Type = Type::Item) and
               ("Prepmt. Line Amount" <> xRec."Prepmt. Line Amount")
            then
                CurrPage.UPDATE(true);
            // >>DITW15.00.00.23 DDR
        end;

        local procedure QtytoReceiveOnAfterValidate();
        begin
            // <<DITW15.00.00.01 DDR 21/12/2007
            if (Type = Type::Item) and
               ("Qty. to Receive" <> xRec."Qty. to Receive")
            then
                CurrPage.UPDATE(true);
            // >>DITW15.00.00.01 DDR
        end;

        local procedure QtytoInvoiceOnAfterValidate();
        begin
            // <<DITW15.00.00.01 DDR 21/12/2007
            if (Type = Type::Item) and
               ("Qty. to Invoice" <> xRec."Qty. to Invoice")
            then
                CurrPage.UPDATE(true);
            // >>DITW15.00.00.01 DDR
        end;

        local procedure PrepmtAmttoDeductOnAfterValida();
        begin
            // <<DITW15.00.00.23 DDR 11/08/2008
            if (Type = Type::Item) and
               ("Prepmt Amt to Deduct" <> xRec."Prepmt Amt to Deduct")
            then
                CurrPage.UPDATE(true);
            // >>DITW15.00.00.23 DDR
        end;



            local procedure FreeItemOnAfterValidate();
            begin
                // <<DITW15.00.00.35 DDR 25/06/2009
                if (Type = Type::Item) and
                   (xRec."Free Item" <> "Free Item")
                then
                    CurrPage.UPDATE(true);
                // >>DITW15.00.00.35 DDR
            end;
             */ //BC Upgrade Manisha Drink it code Commented<<


    local procedure AllowVATCalculationFreeOnAfter();
    begin
        CurrPage.UPDATE(true);
    end;

    /* //BC Upgrade Manisha Drink it code Commented>>
        local procedure FreeItemPostingTypeOnAfterVali();
        begin
            // <<DITW15.00.00.35 DDR 25/06/2009
            if Type = Type::Item then
                CurrPage.UPDATE(true);
            // >>DITW15.00.00.35 DDR
        end;

        local procedure FreeReasoncodeOnAfterValidate();
        begin
            // <<DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692
            if (Type = Type::Item) and
               (xRec."Free Reason Code" <> Rec."Free Reason Code")
            then
                CurrPage.UPDATE(true);
            // >>DITW17.00.10.05 MSF 30/07/2014 DIT-770 #692
        end;
        */ //BC Upgrade Manisha Drink it code Commented>>

}

