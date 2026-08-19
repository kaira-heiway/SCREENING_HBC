page 50142 "Spare Part Journal"
{
    // version HEI.01

    // DITW14.00.00.8 PROD: BrewIt & Quality
    // DITW15.00.00.31-PRODW14.00.00.08.10 DLE 13/02/2009 License problem
    // DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    //                                issue 768 Added to set non-editable fields
    //                                  "Gen. Bus. Posting Group","Gen. Prod. Posting Group","Inventory Posting Group"
    // DITW15.00.00.37 DDR 19/01/2010 Added Item charges (expand/collapse)
    //                     29/01/2010 issue 1054 Added fields
    //                                  "AAD No. Series","ADD No.",
    //                                  "Tariff No.","item DTax Group Code","Company Tax Registration No."
    //                     20/05/2010 issue 1081 Added fields "Physical Location Group Code"
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 22/06/2010 issue 1151 Added to remove Quarantine Quality test when delete purchase line
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    // DITW15.00.00.38 DDR 04/08/2010 issue 1216 Bugfix field "Quantity" with dynamic editable
    // DITW16.00.00.38 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 17/08/2010           Remove OnFormat() field "Item No."
    //                 DDR 20/01/2011 DIT-715 #50 RTC bugfix trigger OnModifyTrigger' test to call function ActionInsertAutoBlankLine()
    // DITW15.00.00.38 DDR 04/08/2010 issue 1216 Bugfix field "Quantity" with dynamic editable
    // DITW15.00.00.38-PRODW14.00.00.17 DDR 14/12/2010 issue 1127 Bugfix don't show Lot column if item tracking line is not required (Produ
    //                                                            Replaced static text Lot required by call function IsRequired()
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //                                             Modified "Item Charge No." as non-editable (function UpdateFields)
    //                                             Removed/Moved CaptionML control74/75
    //                     02/03/2011 DIT-715 #50 RTC Page functionnalities
    //                                             Added/Moved OnNewRecord trigger into TriggerOnNewRecord() function
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #1 RTC Upgrade Page functionnalities
    //                                             Modified function UpdateFields()
    // DITW16.00.00.38 DDR 07/03/2011 DIT-715 #71 RTC Upgrade Page functionnalities
    //                                             Modified order position RTC buttons
    //                                               contol1102601007 RTCNewLine
    //                                               contol1102601008 RTCDeleteLine
    //                                               contol1102601009 RTCDleteAllLines
    // DITW16.00.00.39 PRODW14.00.00.08.18 DDR 19/07/2011 DIT-715 #73
    //                                            License: Modified OnFormat() column "LotNo"
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                              Added to insert first line automatically
    //                                              Added/Review Total Line Amount (Collapsed RTC)
    // DITW15.00.00.39 DDR 26/08/2011 issue 1393 Added AssistEdit property/trigger for field "Item No."
    //                     26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    // DITW16.00.00.40 DDR 22/12/2011 #1429 Added 'SSCC Item Tracking Lines' into 'Line' button
    //                     03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
    //                                           Added menuitem "Automatic FEFO Tracking" in menu Line & Functions
    //                                           Moved functions CreateFEFOTracking(),CreateFEFOTrackingJournal() into table83
    //                     03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                             Modified OnAssistEdit trigger field "No."
    //                     12/06/2012 DIT-715 #310 Added to keep the Document No. on new record (line)
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 12/07/2013 DIT-770 #105 Bugfix lost Template/Batch filters while opening page
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.00.03 DDR 07/03/2014 DIT-770 #502 Bugfix using Expand/Collapse and inserting new line
    // DITW17.10.03 DDR 07/04/2014 DIT-770 #559 (old DIT-770 214) Bugfix standard Expand-Collapse (ShowAsTree property) workaround
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1189 Multisite - Added field "Responsibility Center"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields "Strength Spec. Code","Strength Spec. Value","Vol-Strength Spec. Code","Vol-Strength Spec. Value","Unit Volume HL"
    // DITW19.00.08 DDR 29/09/2016 BL#10443 Added fields "Scrap Code","Scrap Quantity","Exist Loss Breakdown"
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Removed 'Editable' property for fields "strength Spec. Value","vol-strength Spec. Value"
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.09 AKH 29/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
    //   #Add field "Zone Code"

    // BC Upgrade PATELP08 >> 
    // # Replaced deprecated `ItemJnlMgt.GetConsump` with `MfgItemJournalMgt.GetConsump` in OnValidate Trigger of Field "Order No."
    // # Added the required codeunit variable for BC compatibility in OnValidate Trigger of Field "Order No.".
    // BC Upgrade PATELP08 <<

    AutoSplitKey = true;
    Caption = 'Spare Part Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Item Journal Line";
    ApplicationArea = All;  // BC Upgrade Manisha
    UsageCategory = Administration;  // BC Upgrade Manisha

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                ApplicationArea = Jobs;
                CaptionML = ENU = 'Batch Name',
                            FRA = 'Nom de la feuille';
                Lookup = true;
                ToolTipML = ENU = 'Specifies the name of the journal batch of the consumption journal.',
                            FRA = 'Spécifie le nom de la feuille consommation.';

                trigger OnValidate();
                begin
                    ItemJnlMgt.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali();
                end;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD();
                    ItemJnlMgt.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(false);
                    ItemJnlMgt.CheckName(CurrentJnlBatchName, Rec);
                end;
            }
            repeater(Control1)
            {
                IndentationColumn = IndentLine;
                IndentationControls = Description;
                /* //BCUPGRADE Manisha Drink it fields code Commented
                field("Has Item Charge"; "Has Item Charge")
                {
                    BlankZero = true;
                }
                field(Collapse; Collapse)
                {
                    Visible = false;

                    trigger OnValidate();
                    begin
                        // <<DITW15.00.00.37 DDR 19/01/2010
                        CurrPage.UPDATE(true);
                        // >>DITW15.00.00.37 DDR
                    end;
                }*/  //BCUPGRADE Manisha Drink it fields code Commented
                field("Line No."; rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the number of the journal line.';
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = Jobs;
                    ToolTipML = ENU = 'Specifies the posting date for the entry.',
                                FRA = 'Spécifie la date comptabilisation de l''écriture.';
                    /* //BCUPGRADE Manisha Drink it function code Commented
                    trigger OnValidate();
                    begin
                        PostingDateOnAfterValidate;
                    end;
                    */ //BCUPGRADE Manisha Drink it function code Commented
                }
                field("Order No."; rec."Order No.")
                {
                    ApplicationArea = Jobs;
                    ToolTipML = ENU = 'Specifies the number of the order that created the entry.',
                                FRA = 'Spécifie le numéro de la commande qui a créé l''écriture.';

                    // BC Upgrade PATELP08 >> # Replaced deprecated `ItemJnlMgt.GetConsump` with `MfgItemJournalMgt.GetConsump` and added the required codeunit variable for BC compatibility.
                    trigger OnValidate();
                    // BC Upgrade PATELP08 >> # Added the required codeunit variable for MfgItemJournalMgt.GetConsump
                    var
                        MfgItemJournalMgt: Codeunit "Mfg. Item Journal Mgt.";
                    // BC Upgrade PATELP08 <<
                    begin
                        // BC Upgrade PATELP08 >> # Replaced deprecated ItemJnlMgt.GetConsump call with MfgItemJournalMgt.GetConsump
                        //ItemJnlMgt.GetConsump(Rec, ProdOrderDescription);
                        MfgItemJournalMgt.GetConsump(Rec, ProdOrderDescription);
                        // BC Upgrade PATELP08 <<
                        //ProdOrderNoOnAfterValidate;// BCUPGRADE Manisha Drink it function 
                    end;
                    // BC Upgrade PATELP08 <<
                }
                field("Order Line No."; rec."Order Line No.")
                {
                    ApplicationArea = Jobs;
                    ToolTipML = ENU = 'Specifies the line number of the order that created the entry.',
                                FRA = 'Spécifie le numéro de ligne ayant créé l''écriture.';

                    trigger OnValidate();
                    begin
                        //ProdOrderLineNoOnAfterValidate;// BCUPGRADE Manisha Drink it function 
                    end;
                }
                field("Prod. Order Comp. Line No."; Rec."Prod. Order Comp. Line No.")
                {
                    ApplicationArea = Jobs;
                    ToolTipML = ENU = 'Specifies the production order component line number.',
                                FRA = 'Spécifie le numéro de ligne du composant O.F.';

                    trigger OnValidate();
                    begin
                        //ProdOrderCompLineNoOnAfterVali;// BCUPGRADE Manisha Drink it function 
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Jobs;
                    ToolTipML = ENU = 'Specifies the date on the document that provides the basis for the entry on the journal line.',
                                FRA = 'Spécifie la date du document qui est utilisé comme document de base pour l''écriture de la ligne feuille.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        //DocumentDateOnAfterValidate;// BCUPGRADE Manisha Drink it function 
                    end;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Jobs;
                    ToolTipML = ENU = 'Specifies a document number referring to the customer or vendor numbering system with whom you are trading items on this journal line.',
                                FRA = 'Spécifie un numéro de document qui se réfère au programme de numérotation du client ou du fournisseur avec lequel vous traitez pour les articles de cette ligne feuille.';
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Jobs;
                    ToolTipML = ENU = 'Specifies a document number for the journal line.',
                                FRA = 'Spécifie le numéro de document de la ligne feuille.';

                    trigger OnValidate();
                    begin
                        //DocumentNoOnAfterValidate;// BCUPGRADE Manisha Drink it function 
                    end;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = Jobs;
                    Editable = "Item No.Editable";
                    ToolTipML = ENU = 'Specifies the number of the item on the journal line.',
                                FRA = 'Spécifie le numéro de l''article de la ligne feuille.';
                    /* //BCUPGRADE Manisha drink it code commented>>
                    // trigger OnAssistEdit();
                    //begin
                // <<DITW15.00.00.39 DDR 26/08/2011 #1393 - DITW16.00.00.40 DDR 03/05/2012 DIT-715 #276
                if AssistEditItemTreeview(Rec."Item No.") then begin
                    // validate trigger
                    ShowShortcutDimCode(ShortcutDimCode);
                    // aftervalidate trigger
                    CurrPage.UPDATE(true);
                end else
                    CurrPage.UPDATE(false);
                // >>DITW15.00.00.39 DDR #1393 - DITW16.00.00.40 DDR DIT-715 #276
                */ //BCUPGRADE Manisha drink it code commented<<
                    // end;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Item: Record Item;
                        ManufacturingSetup: Record "Manufacturing Setup";
                    begin
                        ManufacturingSetup.GET();
                        ManufacturingSetup.TESTFIELD("SP Item Category Filter FND");
                        Item.FILTERGROUP(10);
                        Item.SETFILTER("Item Category Code", ManufacturingSetup."SP Item Category Filter FND");
                        Item.FILTERGROUP(0);
                        if PAGE.RUNMODAL(31, Item) = ACTION::LookupOK then
                            rec.VALIDATE("Item No.", Item."No.");
                    end;

                    trigger OnValidate();
                    var
                        Item: Record Item;
                        ManufacturingSetup: Record "Manufacturing Setup";
                    begin
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                        //ItemNoOnAfterValidate; // BCUPGRADE Manisha Drink it function 

                        ManufacturingSetup.GET();
                        ManufacturingSetup.TESTFIELD("SP Item Category Filter FND");
                        Item.SETFILTER("Item Category Code", ManufacturingSetup."SP Item Category Filter FND");
                        Item.SETFILTER("No.", rec."Item No.");
                        if not Item.FINDFIRST() then
                            ERROR(Text001, ManufacturingSetup."SP Item Category Filter FND");
                    end;
                }
                field("Item Charge No."; rec."Item Charge No.")
                {
                    Editable = "Item Charge No.Editable";
                    Enabled = "Item Charge No.Enable";
                    Visible = false;
                    ToolTip = 'Specifies the value of the Item Charge No. field.';

                    trigger OnValidate();
                    begin
                        //ItemChargeNoOnAfterValidate; // BCUPGRADE Manisha Drink it function 
                    end;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = Jobs;
                    ToolTipML = ENU = 'Specifies a variant code for the item.',
                                FRA = 'Spécifie un code variante pour l''article.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        // VariantCodeOnAfterValidate; // BCUPGRADE Manisha Drink it function 
                    end;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = Jobs;
                    ToolTipML = ENU = 'Specifies a description of the item on the journal line.',
                                FRA = 'Spécifie une description de l''article sur la ligne feuille.';
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Jobs;
                    ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.',
                                FRA = 'Spécifie le code pour Raccourci axe 1.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Jobs;
                    ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.',
                                FRA = 'Spécifie le code pour Raccourci axe 2.';
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[3] field.';

                    trigger OnValidate();
                    begin
                        rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[4] field.';

                    trigger OnValidate();
                    begin
                        rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[5] field.';

                    trigger OnValidate();
                    begin
                        rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[6] field.';

                    trigger OnValidate();
                    begin
                        rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(7),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[7] field.';

                    trigger OnValidate();
                    begin
                        rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(8),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[8] field.';

                    trigger OnValidate();
                    begin
                        rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                /* //BCUpgrade Manisha drink it field commented>>
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    Visible = false;

                    trigger OnValidate();
                    begin
                        // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
                        if "Responsibility Center" <> xRec."Responsibility Center" then
                            CurrPage.UPDATE(true);
                        // >>DITW18.00.06 DDR DIT-770 #1189
                    end;
                
                field("Physical Location Group Code"; rec."Physical Location Group Code")
                {
                    Visible = false;

                    trigger OnValidate();
                    begin
                        // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
                        if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                            CurrPage.UPDATE(true);
                        // >>DITW18.00.06 DDR DIT-770 #1189
                    end;
                }
                field("Location Code"; "Location Code")
                {
                    ToolTipML = ENU = 'Specifies the code for the inventory location where the item on the journal line will be registered.',
                                FRA = 'Spécifie le code du magasin où l''article de la ligne feuille sera enregistré.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        LocationCodeOnAfterValidate;
                        // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
                        if "Location Code" <> xRec."Location Code" then
                            CurrPage.UPDATE(true);
                        // >>DITW18.00.06 DDR DIT-770 #1189
                    end;
                }}*/ //BCUpgrade Manisha drink it field commented>>
                field("Zone Code"; rec."Zone Code FND")
                {
                    ToolTip = 'Specifies the value of the Zone Code field.';
                }
                field("Bin Code"; rec."Bin Code")
                {
                    ToolTipML = ENU = 'Specifies a bin code for the item.',
                                FRA = 'Spécifie un code emplacement pour l''article.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        //BinCodeOnAfterValidate;// BCUPGRADE Manisha Drink it function 
                    end;
                }
                field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Jobs;
                    Editable = GenBusPostingGroupEditable;
                    ToolTipML = ENU = 'Specifies the general business posting group that will be used when you post the entry on the journal line.',
                                FRA = 'Spécifie le groupe comptabilisation marché utilisé lorsque vous validez l''écriture sur la ligne feuille.';
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Jobs;
                    Editable = GenProdPostingGroupEditable;
                    ToolTipML = ENU = 'Specifies the general product posting group that will be used when you post the entry on the journal line.',
                                FRA = 'Spécifie le groupe comptabilisation produit utilisé lorsque vous validez l''écriture sur la ligne feuille.';
                    Visible = false;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = Jobs;
                    Editable = QuantityEditable;
                    ToolTipML = ENU = 'Specifies the number of units of the item to be included on the journal line.',
                                FRA = 'Spécifie le nombre d''unités de l''article à inclure sur la ligne feuille.';

                    trigger OnValidate();
                    begin
                        //QuantityOnAfterValidate;// BCUPGRADE Manisha Drink it function 
                    end;
                }
                field("Scrap Code"; rec."Scrap Code")
                {
                    Editable = "Scrap CodeEditable";
                    Visible = false;
                    ToolTip = 'Specifies the scrap code.';

                    trigger OnValidate();
                    begin
                        if rec."Line No." <> 0 then
                            CurrPage.UPDATE(true);
                    end;
                }
                field("Scrap Quantity"; rec."Scrap Quantity")
                {
                    Editable = "Scrap QuantityEditable";
                    Visible = false;
                    ToolTip = 'Specifies the number of units produced incorrectly, and therefore cannot be used.';
                    /* BCUPGRADE Manisha Drink it code commented>>
                       trigger OnAssistEdit();
                       begin
                           // <<DITW19.00.08 DDR 17/08/2016 BL#10443
                           OpenLossBreakdownLines;
                           CurrPage.UPDATE;
                           // >>DITW19.00.08 DDR BL#10443
                       end;
                       */ //BCUPGRADE Manisha Drink it code commented<<
                    trigger OnValidate();
                    begin
                        if rec."Line No." <> 0 then
                            CurrPage.UPDATE(true);
                    end;
                }
                /* BCUPGRADE Manisha Drink it field Commented>>
                field("Exist Loss Breakdown"; rec."Exist Loss Breakdown")
                {
                    Visible = false;
                }
                */ //BCUPGRADE Manisha Drink it field Commented<<
                field(LotNo; LotNoText)
                {
                    CaptionML = ENU = 'Lot No.',
                                FRA = 'N° lot';
                    Editable = false;
                    Style = Attention;
                    StyleExpr = LotNocolor;
                    ToolTip = 'Specifies the value of the LotNoText field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //<<QXL9.00.001 DAT 23/03/2016
                        rec.OpenItemTrackingLines(false);
                        //BCUPGRADE Manisha Drink it fields code Commented
                        // <<DITW19.00.08 DDR 17/08/2016 BL#10443
                        // if QualitySetup.READPERMISSION and (rec."Item Charge No." = '') then begin
                        //     // >>DITW19.00.08 DDR BL#10443
                        //     LotNo := QualityManagement.GetItemJnlLineLotNos(Rec);
                        //     CurrPage.UPDATE;
                        // end;
                        //BCUPGRADE Manisha Drink it fields code Commented
                        //>>QXL9.00.001 DAT 23/03/2016
                    end;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = Jobs;
                    ToolTipML = ENU = 'Specifies the code if you have filled in the Sales Unit of Measure field on the item card.',
                                FRA = 'Spécifie le code si vous avez renseigné le champ Unité de vente de la fiche article.';

                    trigger OnValidate();
                    begin
                        //UnitofMeasureCodeOnAfterValida;// BCUPGRADE Manisha Drink it function 
                    end;
                }
                field("Unit Cost"; rec."Unit Cost")
                {
                    ApplicationArea = Jobs;
                    Editable = "Unit CostEditable";
                    ToolTipML = ENU = 'Specifies the unit cost of the item on the line.',
                                FRA = 'Spécifie le coût unitaire pour l''article sur la ligne.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        //UnitCostOnAfterValidate;// BCUPGRADE Manisha Drink it function 
                    end;
                }
                field("Unit Amount"; rec."Unit Amount")
                {
                    ApplicationArea = Jobs;
                    Editable = "Unit AmountEditable";
                    ToolTipML = ENU = 'Specifies the price of one unit of the item on the journal line.',
                                FRA = 'Spécifie le prix d''une unité de l''article sur la ligne feuille.';

                    trigger OnValidate();
                    begin
                        // UnitAmountOnAfterValidate;//BCUPGRADE Manisha Drink it function
                    end;
                }
                /* BCUPGRADE Manisha Drink it code Commented
                field(RTCTotalLine; rec.GetTotalingLine(1, FIELDNO(Amount), true))
                {
                    AutoFormatType = 1;
                    BlankZero = true;
                    CaptionML = ENU = 'Total Amount',
                                FRA = 'Montant total';
                    Description = 'DITW17.10.02B DIT-770 #541';
                    Editable = false;
                    QuickEntry = false;
                }
                */ //BCUPGRADE Manisha Drink it code Commented
                field("Applies-to Entry"; rec."Applies-to Entry")
                {
                    ApplicationArea = Jobs;
                    ToolTipML = ENU = 'Specifies if the quantity in the item journal line should be applied to an already-posted document.',
                                FRA = 'Spécifie si la quantité dans la ligne feuille article doit être lettrée dans un document déjà validé.';
                }
                field("Applies-from Entry"; rec."Applies-from Entry")
                {
                    ApplicationArea = Jobs;
                    ToolTipML = ENU = 'Specifies the number of the outbound item ledger entry, whose cost is forwarded to the inbound item ledger entry.',
                                FRA = 'Spécifie le numéro de l''écriture comptable article sortant, dont le coût est transmis à l''écriture comptable article entrant.';
                }
                /* //BCUPGRADE Manisha Drink it field commented<<
               field("Due Tax"; rec."Due Tax")
               {
                   Visible = false;
               }
               field("Duty Suspended"; "Duty Suspended")
               {
                   Visible = false;
               }
               field("Item DTax Group Code"; "Item DTax Group Code")
               {
                   Editable = "Item DTax Group CodeEditable";
                   Visible = false;
               }
               field("Company Tax Registration No."; "Company Tax Registration No.")
               {
                   Editable = CompanyTaxRegistrationNoEditab;
                   Visible = false;
               }
               field("Strength Spec. Code"; "Strength Spec. Code")
               {
                   Editable = false;
               }
               
                field("AverageStrengthReserv(FIELDNO(""Strength Spec. Value""))"; AverageStrengthReserv(FIELDNO("Strength Spec. Value")))
                {
                    AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Strength Spec. Value"));
                    AutoFormatType = 2013664;
                    CaptionClass = GetTaxSpecCaption(1, FIELDNO("Strength Spec. Value"));
                    CaptionML = ENU = 'Strength Spec. Value',
                                FRA = 'Valeur contrainte spécification';
                    Editable = false;
                    Visible = false;

                    trigger OnDrillDown();
                    begin
                        // <<DITW19.00.08 DDR 20/10/2016 BL#10443
                        DrilldownReservEntryVS(FIELDNO("Strength Spec. Value"));
                    end;
                }
                
                field("Vol-Strength Spec. Code"; "Vol-Strength Spec. Code")
                {
                    Editable = false;
                }
                field("Vol-Strength Spec. Value"; "Vol-Strength Spec. Value")
                {
                }
                
                field("Unit Volume HL"; "Unit Volume HL")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Tariff No."; "Tariff No.")
                {
                    Editable = "Tariff No.Editable";
                    Visible = false;
                }
                field("AAD No. Series"; "AAD No. Series")
                {
                    Editable = "AAD No. SeriesEditable";
                    Visible = false;
                }
                field("AAD No."; "AAD No.")
                {
                    Editable = "AAD No.Editable";
                    Visible = false;
                }
                */ //BCUPGRADE Manisha Drink it field commented<<
                field("Source No."; Rec."Source No.")
                {
                    ToolTip = 'Specifies the value of the Source No. field.';
                }
                field("Project Code"; Rec."Project Code FND")
                {
                    ToolTip = 'Specifies the value of the Project Code field.';
                }
                field("Project Description"; Rec."Project Description FND")
                {
                    ToolTip = 'Specifies the value of the Project Description field.';
                }
            }
            group(Control73)
            {
                fixed(Control1902114901)
                {
                    group("Prod. Order Name")
                    {
                        CaptionML = ENU = 'Prod. Order Name',
                                    FRA = 'Nom O.F.';
                        field(ProdOrderDescription; ProdOrderDescription)
                        {
                            ApplicationArea = Jobs;
                            Editable = false;
                            ShowCaption = false;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                CaptionML = ENU = '&Line',
                            FRA = '&Ligne';
                Image = Line;
                separator(Separator1100083204)
                {
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Jobs;
                    CaptionML = ENU = 'Dimensions',
                                FRA = 'Axes analytiques';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.',
                                FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';

                    trigger OnAction();
                    begin
                        Rec.ShowDimensions();
                        CurrPage.SAVERECORD();
                    end;
                }
                action("Item &Tracking Lines")
                {
                    CaptionML = ENU = 'Item &Tracking Lines',
                                FRA = 'Lignes &traçabilité';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'Executes the Item &Tracking Lines action.';

                    trigger OnAction();
                    begin
                        Rec.OpenItemTrackingLines(false);
                    end;
                }
                /* //BCUPGRADE Manisha Drink it fields code Commented
              action("SSCC Tracking Lines")
              {
                  CaptionML = ENU = 'SSCC Tracking Lines',
                              FRA = 'Lignes Traçabilité SSCC';
                  Description = '#1429';
                  Image = ItemTrackingLines;

                  trigger OnAction();
                  begin
                      // <<DITW16.00.00.40 DDR 22/12/2011 #1429
                      OpenSSCCTrackingLines(false);
                  end;
              }

              action("&Automatic FEFO Tracking")
              {
                  CaptionML = ENU = '&Automatic FEFO Tracking',
                              FRA = 'Traçabilité Automatique FEFO';
                  Description = '#1331';
                  Image = ItemTracking;
                  ShortCutKey = 'Shift+Ctrl+T';

                  trigger OnAction();
                  begin
                      // <<DITW16.00.00.40 DDR 03/02/2012 #1331
                      CurrPage.SAVERECORD;
                      COMMIT;
                      CreateFEFOTracking(false);
                      CurrPage.UPDATE(false);
                  end;
              }
                 */ //BCUPGRADE Manisha Drink it fields code Commented
                action("Bin Contents")
                {
                    CaptionML = ENU = 'Bin Contents',
                                FRA = 'Contenu emplacement';
                    Image = BinContent;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bin Contents List";
                    RunPageLink = "Location Code" = FIELD("Location Code"),
                                  "Item No." = FIELD("Item No."),
                                  "Variant Code" = FIELD("Variant Code");
                    RunPageView = sorting("Location Code", "Bin Code", "Item No.", "Variant Code", "Unit of Measure Code");
                    ToolTip = 'Executes the Bin Contents action.';
                }
                /* //BCUPGRADE Manisha Drink it fields code Commented
             action("&Losses")
             {
                 CaptionML = ENU = '&Losses',
                             FRA = '&Pertes';
                 Image = GainLossEntries;

                 trigger OnAction();
                 begin
                     // <<DITW19.00.08 DDR 17/08/2016 BL#10443
                     OpenLossBreakdownLines;
                     CurrPage.UPDATE;
                     // >>DITW19.00.08 DDR BL#10443
                 end;
             }
                */ //BCUPGRADE Manisha Drink it fields code Commented
                separator(Separator1100066000)
                {
                }
                action("<Action1161021002>")
                {
                    CaptionML = ENU = 'Show N-owm activities',
                                FRA = 'Visualiser Activitées N-owm';
                    Description = 'DIT-715 #806';
                    ToolTip = 'Executes the <Action1161021002> action.';
                    /*
                        trigger OnAction();
                        var
                            OWMUtils: Codeunit "N-owm Utils";
                        begin
                            OWMUtils.ShowActivityStatus(OWMUtils.ActProdConsump, Rec."Document No.", Rec."Location Code");
                            //DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
                }
                        end;*/ //BCUPGRADE Manisha Drink it function
                }
            }
            group("Pro&d. Order")
            {
                CaptionML = ENU = 'Pro&d. Order',
                            FRA = '&O.F.';
                Image = "Order";
                action(Card)
                {
                    ApplicationArea = Jobs;
                    CaptionML = ENU = 'Card',
                                FRA = 'Fiche';
                    Image = EditLines;
                    RunObject = Page "Released Production Order";
                    RunPageLink = "No." = FIELD("Order No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTipML = ENU = 'View or change detailed information about the record that is being processed on the journal line.',
                                FRA = 'Affichez ou modifiez les informations détaillées sur l''enregistrement qui sont traitées sur la ligne feuille.';
                }
                group("Ledger E&ntries")
                {
                    CaptionML = ENU = 'Ledger E&ntries',
                                FRA = 'É&critures comptables';
                    Image = Entries;
                    action("Item Ledger E&ntries")
                    {
                        ApplicationArea = Jobs;
                        CaptionML = ENU = 'Item Ledger E&ntries',
                                    FRA = 'É&critures comptables article';
                        Image = ItemLedger;
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("Order No.");
                        ShortCutKey = 'Ctrl+F7';
                        ToolTipML = ENU = 'View the item ledger entries of the item on the journal line.',
                                    FRA = 'Affichez les écritures comptables article pour l''article dans la ligne feuille actuelle.';
                    }
                    action("Capacity Ledger Entries")
                    {
                        ApplicationArea = Jobs;
                        CaptionML = ENU = 'Capacity Ledger Entries',
                                    FRA = 'Écritures comptables capacité';
                        Image = CapacityLedger;
                        RunObject = Page "Capacity Ledger Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("Order No.");
                        ToolTipML = ENU = 'View the capacity ledger entries of the involved production order. Capacity is recorded either as time (run time, stop time, or setup time) or as quantity (scrap quantity or output quantity).',
                                    FRA = 'Affichez les écritures comptables capacité de l''ordre de fabrication concerné. La capacité est enregistrée en tant que temps (Temps d''exécution, Temps d''arrêt, Temps de préparation) ou en tant que quantité (Quantité perte, Quantité produite).';
                    }
                }
            }
        }
        area(processing)
        {
            group(ActionGroup1100910006)
            {
                action("+ Expand")
                {
                    CaptionML = ENU = '+ Expand',
                                FRA = '+ Développer';
                    Enabled = (NOT ExpandLines);
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
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
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
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
            }
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions',
                            FRA = 'Fonction&s';
                Image = "Action";
                action("Calc. Co&nsumption")
                {
                    ApplicationArea = Jobs;
                    CaptionML = ENU = 'Calc. Co&nsumption',
                                FRA = '&Calc. consommation';
                    Ellipsis = true;
                    Image = CalculateConsumption;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTipML = ENU = 'Use a batch job to help you fill the consumption journal with actual or expected consumption figures.',
                                FRA = 'Utilisez un traitement par lots pour remplir la feuille consommation à l''aide des chiffres de consommation réels ou attendus.';

                    trigger OnAction();
                    var
                        CalcConsumption: Report "Calc. Consumption";
                    begin
                        CalcConsumption.SetTemplateAndBatchName(Rec."Journal Template Name", Rec."Journal Batch Name");

                        CalcConsumption.RUNMODAL();
                    end;
                }
                separator(Separator1100083008)
                {
                }
                action("&Insert Item Charges")
                {
                    CaptionML = ENU = '&Insert Item Charges',
                                FRA = '&Inserer Frais Annexes';
                    Image = TaxSetup;
                    ShortCutKey = 'Ctrl+Y';
                    ToolTip = 'Executes the &Insert Item Charges action.';

                    trigger OnAction();
                    begin
                        // <<DITW15.00.00.37 DDR 19/01/2010
                        //InsertExtendedCharges(true);
                        //BCUPGRADE Manisha Drink it fields code Commented
                    end;
                }
                separator(Separator1100076700)
                {
                }
                /* //BCUPGRADE Manisha Drink it fields code Commented
                action("&Automatic FEFO Tracking for journal")
                {
                    CaptionML = ENU = '&Automatic FEFO Tracking for journal',
                                FRA = 'Traçabilité Automatique pour Feuille';
                    Description = '#1331';
                    Image = ItemTracking;
                    ShortCutKey = 'Shift+Ctrl+F';

                    trigger OnAction();
                    begin
                        // <<DITW16.00.00.40 DDR 03/02/2012 #1331
                        CurrPage.SAVERECORD;
                        COMMIT;
                        CreateFEFOTrackingJournal(false);
                        CurrPage.UPDATE(false);
                    end;
                    }
                    */ //BCUPGRADE Manisha Drink it fields code Commented

            }
            group("P&osting")
            {
                CaptionML = ENU = 'P&osting',
                            FRA = '&Validation';
                Image = Post;
                action("Test Report")
                {
                    ApplicationArea = Jobs;
                    CaptionML = ENU = 'Test Report',
                                FRA = 'Impression test';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.',
                                FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';

                    trigger OnAction();
                    begin
                        ReportPrint.PrintItemJnlLine(Rec);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = Jobs;
                    CaptionML = ENU = 'P&ost',
                                FRA = '&Valider';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.',
                                FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';

                    trigger OnAction();
                    var
                        ManufacturingSetup: Record "Manufacturing Setup";
                        ProdOrderLine: Record "Prod. Order Line";
                        ProductionOrder: Record "Production Order";
                    begin
                        //PostingItemJnlFromProduction(FALSE);

                        ManufacturingSetup.GET();
                        ManufacturingSetup.TESTFIELD("SP Consumption Prod. Order FND");
                        Rec.VALIDATE("Source No.", Rec."Item No.");
                        Rec."Order No." := ManufacturingSetup."SP Consumption Prod. Order FND";
                        CheckCreateProdOrderLine(Rec."Item No.");
                        ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Released);
                        ProdOrderLine.SETRANGE("Prod. Order No.", ManufacturingSetup."SP Consumption Prod. Order FND");
                        ProdOrderLine.SETRANGE("Item No.", Rec."Item No.");
                        ProdOrderLine.FINDFIRST();
                        Rec."Order Line No." := ProdOrderLine."Line No.";
                        if (Rec."Order Type" = Rec."Order Type"::Production) and (Rec."Order No." <> '') then
                            ProductionOrder.GET(ProductionOrder.Status::Released, Rec."Order No.");

                        Rec.MODIFY();
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Rec);

                        CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(false);
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = Jobs;
                    CaptionML = ENU = 'Post and &Print',
                                FRA = 'Valider et i&mprimer';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ToolTipML = ENU = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.',
                                FRA = 'Finalisez et préparez-vous à imprimer le document ou la feuille. Les valeurs et les quantités sont validées en fonction des comptes associés. Une fenêtre de demande d''état où vous pouvez spécifier ce qu''il faut inclure sur l''élément à imprimer.';

                    trigger OnAction();
                    var
                        ManufacturingSetup: Record "Manufacturing Setup";
                        ProdOrderLine: Record "Prod. Order Line";
                        ProductionOrder: Record "Production Order";
                    begin
                        //PostingItemJnlFromProduction(TRUE);

                        ManufacturingSetup.GET();
                        ManufacturingSetup.TESTFIELD("SP Consumption Prod. Order FND");
                        Rec.VALIDATE("Source No.", Rec."Item No.");
                        Rec."Order No." := ManufacturingSetup."SP Consumption Prod. Order FND";
                        CheckCreateProdOrderLine(Rec."Item No.");
                        ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Released);
                        ProdOrderLine.SETRANGE("Prod. Order No.", ManufacturingSetup."SP Consumption Prod. Order FND");
                        ProdOrderLine.SETRANGE("Item No.", Rec."Item No.");
                        ProdOrderLine.FINDFIRST();
                        Rec."Order Line No." := ProdOrderLine."Line No.";
                        if (Rec."Order Type" = Rec."Order Type"::Production) and (Rec."Order No." <> '') then
                            ProductionOrder.GET(ProductionOrder.Status::Released, Rec."Order No.");
                        Rec.MODIFY();
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post+Print", Rec);

                        CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(false);
                    end;
                }
            }
            action("&Print")
            {
                ApplicationArea = Jobs;
                CaptionML = ENU = '&Print',
                            FRA = '&Imprimer';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTipML = ENU = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.',
                            FRA = 'Préparez-vous à imprimer le document. Une fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';

                trigger OnAction();
                var
                    ItemJnlLine: Record "Item Journal Line";
                begin
                    ItemJnlLine.COPY(Rec);
                    ItemJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    REPORT.RUNMODAL(REPORT::"Inventory Movement", true, true, ItemJnlLine);
                end;
            }
        }
    }
    //BCUPGRADE Manisha Drink it fields code Commented
    /*
        trigger OnAfterGetCurrRecord();
        begin
            ItemJnlMgt.GetConsump(Rec, ProdOrderDescription);
            // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
            Rec.SETFILTER("Resp. Center Table Filter",
              UserSetupMgt.GetRespCenterFilter(EntryTypeToRespID, "Responsibility Center", "Physical Location Group Code", "Location Code"));
            Rec.SETFILTER("Phys. Location Table Filter",
              UserSetupMgt.GetRespPhysLocationFilter(EntryTypeToRespID, "Responsibility Center", "Physical Location Group Code", "Location Code"));
            Rec.SETFILTER("Location Table Filter",
              UserSetupMgt.GetRespLocationFilter(EntryTypeToRespID, "Responsibility Center", "Physical Location Group Code", "Location Code"));
            // >>DITW18.00.06 DDR DIT-770 #1189
            // <<DITW15.00.00.37 DDR 19/01/2010
            UpdateFields();
            // >>DITW15.00.00.24 DDR
        end;
        */
    //BCUPGRADE Manisha Drink it fields code Commented

    trigger OnAfterGetRecord();
    begin
        // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        //IndentLine := IndentRecordDIT(ExpandLines);
        //BCUPGRADE Manisha Drink it fields code Commented
        // >>DITW17.10.03 DDR DIT-770 #541

        Rec.ShowShortcutDimCode(ShortcutDimCode);
        //BCUPGRADE Manisha Drink it fields code Commented
        //<<QXL9.00.001 DAT 23/03/2016
        // if QualitySetup.READPERMISSION and (Rec."Item Charge No." = '') then
        //     LotNo := QualityManagement.GetItemJnlLineLotNos(Rec)
        // else
        //     LotNo := '';
        //BCUPGRADE Manisha Drink it fields code Commented
        LotNoText := FORMAT(LotNo);
        //LotNoTextOnFormat(LotNoText);//BCUPGRADE Manisha Drink it function
        //>>QXL9.00.001 DAT 23/03/2016
    end;

    trigger OnDeleteRecord(): Boolean;
    var
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
    begin
        // <<DITW16.00.00.37 DDR 20/07/2010
        //COMMIT;
        //IF NOT ReserveItemJnlLine.DeleteLineConfirm(Rec) THEN
        //  EXIT(FALSE);
        //ReserveItemJnlLine.DeleteLine(Rec);
        // Move to function TriggerOnDeleteRecord() to solve RTC Collapse delete records
        // Temporary until next Mirosoft release
        //exit(TriggerOnDeleteRecord());
        //BCUPGRADE Manisha Drink it fields code Commented
    end;

    trigger OnFindRecord(Which: Text): Boolean;
    begin
        // <<DITW16.00.00.37 DIT-715 #1
        // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        //EXIT(FIND(Which));
        //exit(FindRecordDIT(Which, ExpandLines));
        //BCUPGRADE Manisha Drink it fields code Commented
        // >>DITW17.10.03 DDR DIT-770 #541
        // >>DITW16.00.00.37 DIT-715 #1
    end;

    trigger OnInit();
    begin
        // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
        "Item Charge No.Enable" := true;
        "Tariff No.Editable" := true;
        CompanyTaxRegistrationNoEditab := true;
        "Item DTax Group CodeEditable" := true;
        "AAD No.Editable" := true;
        "Unit AmountEditable" := true;
        "Unit CostEditable" := true;
        QuantityEditable := true;
        "Item Charge No.Editable" := true;
        "Item No.Editable" := true;
        GenProdPostingGroupEditable := true;
        GenBusPostingGroupEditable := true;
        // >>DITW16.00.00.37 CEL DIT-715 #1
        // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        GlobalTax1ValueEditable := true;
        GlobalTax2ValueEditable := true;
        // >>DITW19.00.08 DDR BL#10443
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
        //SetUpNewLine(xRec);
        //VALIDATE("Entry Type","Entry Type"::Consumption);
        //CLEAR(ShortcutDimCode);
        // Move to function TriggerOnNewRecord() to solve RTC Collapse delete records
        // Temporary until next Mirosoft release
        // TriggerOnNewRecord(BelowxRec);
        //BCUPGRADE Manisha Drink it fields code Commented
    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    begin
        // <<DITW16.00.00.37 DIT-715 #1
        // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        //EXIT(NEXT(Steps));
        // exit(NextRecordDIT(Steps, ExpandLines));
        //BCUPGRADE Manisha Drink it fields code Commented
        // >>DITW17.10.03 DDR DIT-770 #541
        // >>DITW16.00.00.37 DIT-715 #1
    end;
    //BCUPGRADE Manisha Drink it fields code Commented
    // trigger OnOpenPage();
    // var
    //     JnlSelected: Boolean;
    // begin
    //     if Rec.IsOpenedFromBatch then begin
    //         CurrentJnlBatchName := Rec."Journal Batch Name";
    //         ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
    //         // <<DITW16.00.00.40 DDR 13/01/2012 DIT-715 #194
    //         // to run all custom C/AL into this trigger
    //         //EXIT;
    //         //end;
    //     end else begin
    //         // >>DITW16.00.00.40 DDR DIT-715 #194
    //         ItemJnlMgt.TemplateSelection(PAGE::"Consumption Journal", 4, false, Rec, JnlSelected);
    //         if not JnlSelected then
    //             ERROR('');
    //         ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
    //         // <<DITW16.00.00.40 DDR 13/01/2012 DIT-715 #194
    //     end;
    //     // >>DITW16.00.00.40 DDR DIT-715 #194

    //     // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
    //     Rec.FILTERGROUP(2);
    //     Rec.SETFILTER("Responsibility Center", UserSetupMgt.GetAllRespCenterFilter);
    //     Rec.FILTERGROUP(0);
    //     // >>DITW18.00.06 DDR DIT-770 #1189

    //     // <<DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    //     if ManufacturingSetup.GET then begin
    //         GenBusPostingGroupEditable := ManufacturingSetup."Editable Item Posting Groups";
    //         GenProdPostingGroupEditable := GenBusPostingGroupEditable;
    //     end;
    //     // >>DITW15.00.00.35 PRODW14.00.00.08.14
    //     // <<DITW17.00.01 DDR 12/03/2013 DIT-770 #001
    //     if "Journal Template Name" = '' then
    //         "Journal Template Name" := GETRANGEMAX("Journal Template Name");
    //     if "Journal Batch Name" = '' then
    //         "Journal Batch Name" := GETRANGEMAX("Journal Batch Name");
    //     // >>DITW17.00.01 DDR DIT-770 #001
    //     // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
    //     if not ISEMPTY then
    //         FINDLAST;
    //     // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //     ExpandLines := false;
    //     ShowButtonsCE := IsShowButtonsCEDIT();
    //     // >>DITW17.10.03 DDR DIT-770 #541
    // end;
    //BCUPGRADE Manisha Drink it fields code Commented
    var
        // QualitySetup: Record "Quality Setup";
        //BCUPGRADE Manisha Drink it fields code Commented
        ManufacturingSetup: Record "Manufacturing Setup";
        ItemJnlMgt: Codeunit ItemJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        UserSetupMgt: Codeunit "User Setup Management";
        xRecRef: RecordRef;

        "AAD No.Editable": Boolean;

        "AAD No. SeriesEditable": Boolean;

        CompanyTaxRegistrationNoEditab: Boolean;

        ExpandLines: Boolean;

        GenBusPostingGroupEditable: Boolean;

        GenProdPostingGroupEditable: Boolean;

        GlobalTax1ValueEditable: Boolean;

        GlobalTax2ValueEditable: Boolean;

        "Item Charge No.Editable": Boolean;

        "Item Charge No.Enable": Boolean;

        "Item DTax Group CodeEditable": Boolean;

        "Item No.Editable": Boolean;

        LotNocolor: Boolean;

        QuantityEditable: Boolean;

        "Scrap CodeEditable": Boolean;

        "Scrap QuantityEditable": Boolean;

        ShowButtonsCE: Boolean;

        "Tariff No.Editable": Boolean;

        "Unit AmountEditable": Boolean;

        "Unit CostEditable": Boolean;
        CurrentJnlBatchName: Code[10];
        //QualityManagement: Codeunit "Quality Management";
        //BCUPGRADE Manisha Drink it fields code Commented
        LotNo: Code[20];
        ShortcutDimCode: array[8] of Code[20];
        IndentLine: Integer;
        Text001: Label 'The Item Category Code for Spare Part items should be %1 !';
        ProdOrderDescription: Text[50];

        LotNoText: Text[1024];

    local procedure CurrentJnlBatchNameOnAfterVali();
    begin
        CurrPage.SAVERECORD();
        ItemJnlMgt.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(false);
    end;
    //BCUPGRADE Manisha Drink it fields code Commented
    // procedure InsertExtendedCharges(FromHeader: Boolean);
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     if InsertChargeLines(FromHeader) then
    //         CurrPage.UPDATE(true);
    // end;

    // local procedure UpdateFields();
    // var
    //     CollapsedLine: Boolean;
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010 - DITW15.00.00.38 DDR 16/07/2010 #1194 04/08/2010 #1216
    //     // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
    //     CollapsedLine := not ExpandLines;
    //     // >>DITW17.10.03 DDR DIT-770 #541
    //     "Item No.Editable" := FormEditableField(FIELDNO("Item No."));
    //     // <<DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 - DITW17.00.01 DDR 10/12/2012 DIT-770 #001
    //     "Item Charge No.Editable" := false;
    //     "Item Charge No.Enable" := false;
    //     //"Item Charge No.Editable" := FormEditableField(FIELDNO("Item Charge No."));
    //     // >>DITW16.00.00.38 DDR DIT-715 #1
    //     QuantityEditable := FormEditableField(FIELDNO(Quantity));
    //     "Unit CostEditable" := FormEditableField(FIELDNO("Unit Cost")) and not CollapsedLine;
    //     "Unit AmountEditable" := FormEditableField(FIELDNO("Unit Amount")) and not CollapsedLine;
    //     // <<DITW15.00.00.37 DDR 29/01/2010
    //     "AAD No.Editable" := FormEditableField(FIELDNO("AAD No."));
    //     "AAD No. SeriesEditable" := FormEditableField(FIELDNO("AAD No. Series"));
    //     "Item DTax Group CodeEditable" := FormEditableField(FIELDNO("Item DTax Group Code"));
    //     CompanyTaxRegistrationNoEditab := FormEditableField(FIELDNO("Company Tax Registration No."));
    //     "Tariff No.Editable" := FormEditableField(FIELDNO("Tariff No."));
    //     // >>DITW15.00.00.37 DDR
    //     // <<DITW19.00.08 DDR 17/08/2016 29/09/2016 BL#10443
    //     "Scrap CodeEditable" := FormEditableField(FIELDNO("Scrap Code"));
    //     "Scrap QuantityEditable" := FormEditableField(FIELDNO("Scrap Quantity"));
    //     GlobalTax1ValueEditable := HasTaxSpecEditable("Strength Spec. Code") and not "Is Item Charge";
    //     GlobalTax2ValueEditable := HasTaxSpecEditable("Vol-Strength Spec. Code") and not "Is Item Charge";
    //     // >>DITW19.00.08 DDR BL#10443
    // end;

    // procedure TriggerOnDeleteRecord(): Boolean;
    // var
    //     ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
    // begin
    //     // DITW16.00.00.37 DDR 20/07/2010 (moved trigger bugfix RTC collapse page)
    //     COMMIT;
    //     if not ReserveItemJnlLine.DeleteLineConfirm(Rec) then
    //         exit(false);
    //     // <<QXL9.00.001 DAT 23/03/2016
    //     if QualitySetup.READPERMISSION then begin
    //         if not QualityManagement.DeleteItemJnlLineConfirm(Rec) then
    //             exit(false);
    //     end;
    //     // >>QXL9.00.001 DAT 23/03/2016
    //     ReserveItemJnlLine.DeleteLine(Rec);
    //     // <<QXL9.00.001 DAT 23/03/2016
    //     if QualitySetup.READPERMISSION then
    //         QualityManagement.DeleteItemJnlLine(Rec);
    //     // >>QXL9.00.001 DAT 23/03/2016

    //     exit(true);
    // end;

    // procedure TriggerOnNewRecord(BelowxRec: Boolean): Boolean;
    // begin
    //     // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
    //     INIT;
    //     // >>DITW16.00.00.38 DDR DIT-715 #50
    //     // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    //     LotNoText := '';
    //     // >>DITW19.00.08 DDR BL#10443
    //     // <<DITW15.00.00.35 DDR 19/10/2009
    //     FILTERGROUP(2);
    //     if GETFILTER("Journal Template Name") <> '' then
    //         "Journal Template Name" := GETFILTER("Journal Template Name");
    //     if GETFILTER("Journal Batch Name") <> '' then
    //         "Journal Batch Name" := GETFILTER("Journal Batch Name");
    //     // <<DITW16.00.00.40 DDR 12/06/2012 DIT-715 #310
    //     if GETFILTER("Document No.") <> '' then
    //         EVALUATE("Document No.", GETFILTER("Document No."));
    //     // >>DITW16.00.00.40 DDR DIT-715 #310
    //     FILTERGROUP(0);
    //     // >>DITW15.00.00.35 DDR

    //     SetUpNewLine(xRec);
    //     // <<DITW16.00.00.40 DDR 12/06/2012 DIT-715 #310
    //     if "Document No." = '' then
    //         "Document No." := xRec."Document No.";
    //     // >>DITW16.00.00.40 DDR DIT-715 #310
    //     VALIDATE("Entry Type", "Entry Type"::Consumption);
    //     CLEAR(ShortcutDimCode);
    //     // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
    //     LotNo := '';
    //     // >>DITW15.00.00.22 PRODW14.00.00.08 DDR

    //     // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
    //     exit(true);
    //     // >>DITW16.00.00.38 DDR DIT-715 #50
    // end;
    /*
    local procedure PostingDateOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if Rec."Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.24 DDR
    end;

    local procedure ProdOrderNoOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if Rec."Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.24 DDR
    end;

    local procedure ProdOrderLineNoOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if Rec."Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.24 DDR
    end;

    local procedure ProdOrderCompLineNoOnAfterVali();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if Rec."Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.24 DDR
    end;

    local procedure DocumentDateOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if Rec."Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure DocumentNoOnAfterValidate();
    begin
        // <<DITW15.00.00.25 DDR 24/10/2008
        if Rec."Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.25 DDR
    end;

    local procedure ItemNoOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        CurrPage.UPDATE(true);
        // >>DITW15.00.00.24 DDR
    end;

    local procedure ItemChargeNoOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        CurrPage.UPDATE(true);
        // >>DITW15.00.00.24 DDR
    end;

    local procedure VariantCodeOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if Rec."Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.24 DDR
    end;

    local procedure LocationCodeOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if Rec."Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure BinCodeOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if Rec."Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure QuantityOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if Rec."Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure UnitofMeasureCodeOnAfterValida();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if Rec."Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure UnitCostOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if xRec."Unit Cost" <> Rec."Unit Cost" then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure UnitAmountOnAfterValidate();
    begin
        // <<DITW15.00.00.24 DDR 25/09/2008
        if xRec."Unit Amount" <> Rec."Unit Amount" then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.24 DDR
    end;

    local procedure LotNoTextOnFormat(var Text: Text[1024]);
    begin
        // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        if ((Rec.Quantity = 0) and (Rec."Output Quantity" = 0)) or (Rec."Item Charge No." <> '') or (Rec."Item No." = '') then begin
            LotNocolor := false;
            Text := '';
            exit;
        end;
        // >>DITW19.00.08 DDR BL#10443
        //<<QXL9.00.001 DAT 23/03/2016
        // if QualitySetup.READPERMISSION and (Rec."Item Charge No." = '') then begin
        //     LotNocolor := QualityManagement.IsRequired(Text);
        // end;//BCUPGRADE Manisha Drink it fields code Commented
        //>>QXL9.00.001 DAT 23/03/2016
    end;
   */ //BCUPGRADE Manisha Drink it function code Commented
    local procedure CheckCreateProdOrderLine(ItemNo: Code[20]);
    var
        MaufacturingSetup: Record "Manufacturing Setup";
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrder: Record "Production Order";
        NextLineNo: Integer;
    begin
        ManufacturingSetup.GET();
        ManufacturingSetup.TESTFIELD("SP Consumption Prod. Order FND");
        ProdOrder.GET(ProdOrder.Status::Released, ManufacturingSetup."SP Consumption Prod. Order FND");
        ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Released);
        ProdOrderLine.SETRANGE("Prod. Order No.", ManufacturingSetup."SP Consumption Prod. Order FND");
        ProdOrderLine.SETRANGE("Item No.", ItemNo);
        if not ProdOrderLine.ISEMPTY then
            exit;

        ProdOrderLine.SETRANGE("Item No.");
        if ProdOrderLine.FINDLAST() then
            NextLineNo := ProdOrderLine."Line No.";

        CLEAR(ProdOrderLine);
        ProdOrderLine.VALIDATE(Status, ProdOrder.Status);
        ProdOrderLine.VALIDATE("Prod. Order No.", ProdOrder."No.");
        NextLineNo := NextLineNo + 10000;
        ProdOrderLine."Line No." := NextLineNo;
        ProdOrderLine.VALIDATE("Item No.", ItemNo);
        ProdOrderLine.VALIDATE(Quantity, 100000);
        ProdOrderLine.INSERT();
    end;

}

