pageextension 51136 ConsumptionJournalExtCBN extends "Consumption Journal"
{
    // version NAVW110.0,QXL9.00.001,DITW110.00.09,HEI.01,HEI.02

    //     DITW14.00.00.8 PROD: BrewIt & Quality
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

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.09 AKH 29/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
    //   #Add field "Zone Code"
    // DITW110.00.12 MSF 04/05/2018 NRQ#55899 Resp. centre with Phys. Location group and Location code gives conflict - part 3
    // HEI.02 CHG2140470 SAHAL01 14.09.2022 # Created New Button Suggest Consumption Lines and Added Code
    //                                      # Created New Button Allocate Inventory and Added Code
    //                                      # Added New Fields - Actual Posted Consumption
    //                                                         - Actual Posted Lot No.
    //                                                         - Consumption Suggested
    //                                                         - Consumption Allocated
    //                                                         - Quantity Allocated
    //                                      # Added New Page - Item Journal FactBox



    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
            ToolTipML = ENU = 'Specifies the name of the journal batch of the consumption journal.', FRA = 'Spécifie le nom de la feuille consommation.';
        }

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date for the entry.', FRA = 'Spécifie la date comptabilisation de l''écriture.';
        }
        modify("Order No.")
        {
            ToolTipML = ENU = 'Specifies the number of the order that created the entry.', FRA = 'Spécifie le numéro de la commande qui a créé l''écriture.';
        }
        modify("Order Line No.")
        {
            ToolTipML = ENU = 'Specifies the line number of the order that created the entry.', FRA = 'Spécifie le numéro de ligne ayant créé l''écriture.';
        }

        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on the document that provides the basis for the entry on the journal line.', FRA = 'Spécifie la date du document qui est utilisé comme document de base pour l''écriture de la ligne feuille.';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies a document number referring to the customer or vendor numbering system with whom you are trading items on this journal line.', FRA = 'Spécifie un numéro de document qui se réfère au programme de numérotation du client ou du fournisseur avec lequel vous traitez pour les articles de cette ligne feuille.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies a document number for the journal line.', FRA = 'Spécifie le numéro de document de la ligne feuille.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item on the journal line.', FRA = 'Spécifie le numéro de l''article de la ligne feuille.';

            //Unsupported feature: Change Editable on ""Item No."(Control 20)". Please convert manually.

        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a variant code for the item.', FRA = 'Spécifie un code variante pour l''article.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the item on the journal line.', FRA = 'Spécifie une description de l''article sur la ligne feuille.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code for the inventory location where the item on the journal line will be registered.', FRA = 'Spécifie le code du magasin où l''article de la ligne feuille sera enregistré.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies a bin code for the item.', FRA = 'Spécifie un code emplacement pour l''article.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general business posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le groupe comptabilisation marché utilisé lorsque vous validez l''écriture sur la ligne feuille.';

            //Unsupported feature: Change Editable on ""Gen. Bus. Posting Group"(Control 5)". Please convert manually.

        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le groupe comptabilisation produit utilisé lorsque vous validez l''écriture sur la ligne feuille.';

            //Unsupported feature: Change Editable on ""Gen. Prod. Posting Group"(Control 7)". Please convert manually.

        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item to be included on the journal line.', FRA = 'Spécifie le nombre d''unités de l''article à inclure sur la ligne feuille.';

            //Unsupported feature: Change Editable on "Quantity(Control 86)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the code if you have filled in the Sales Unit of Measure field on the item card.', FRA = 'Spécifie le code si vous avez renseigné le champ Unité de vente de la fiche article.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the unit cost of the item on the line.', FRA = 'Spécifie le coût unitaire pour l''article sur la ligne.';

            //Unsupported feature: Change Editable on ""Unit Cost"(Control 88)". Please convert manually.

        }
        modify("Unit Amount")
        {
            ToolTipML = ENU = 'Specifies the price of one unit of the item on the journal line.', FRA = 'Spécifie le prix d''une unité de l''article sur la ligne feuille.';

            //Unsupported feature: Change Editable on ""Unit Amount"(Control 90)". Please convert manually.

        }
        modify("Applies-to Entry")
        {
            ToolTipML = ENU = 'Specifies if the quantity in the item journal line should be applied to an already-posted document.', FRA = 'Spécifie si la quantité dans la ligne feuille article doit être lettrée dans un document déjà validé.';
        }
        modify("Applies-from Entry")
        {
            ToolTipML = ENU = 'Specifies the number of the outbound item ledger entry, whose cost is forwarded to the inbound item ledger entry.', FRA = 'Spécifie le numéro de l''écriture comptable article sortant, dont le coût est transmis à l''écriture comptable article entrant.';
        }
        modify("Prod. Order Name")
        {
            CaptionML = ENU = 'Prod. Order Name', FRA = 'Nom O.F.';
        }

        //Unsupported feature: CodeInsertion on ""Posting Date"(Control 66)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        PostingDateOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Order No."(Control 60).OnValidate". Please convert manually.

        //trigger "(Control 60)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ItemJnlMgt.GetConsump(Rec,ProdOrderDescription);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ItemJnlMgt.GetConsump(Rec,ProdOrderDescription);
        ProdOrderNoOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Order Line No."(Control 11)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        ProdOrderLineNoOnAfterValidate;
        */
        //end;
        modify("Prod. Order Comp. Line No.")
        {
            Visible = false;
        }


        //Unsupported feature: CodeInsertion on ""Prod. Order Comp. Line No."(Control 14)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        ProdOrderCompLineNoOnAfterVali;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Document Date"(Control 134)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        DocumentDateOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Document No."(Control 3)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        DocumentNoOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Item No."(Control 20)". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.39 DDR 26/08/2011 #1393 - DITW16.00.00.40 DDR 03/05/2012 DIT-715 #276
        if AssistEditItemTreeview("Item No.") then begin
          // validate trigger
          ShowShortcutDimCode(ShortcutDimCode);
          // aftervalidate trigger
          CurrPage.UPDATE(true);
        end else
          CurrPage.UPDATE(false);
        // >>DITW15.00.00.39 DDR #1393 - DITW16.00.00.40 DDR DIT-715 #276
        */
        //end;


        //Unsupported feature: CodeModification on ""Item No."(Control 20).OnValidate". Please convert manually.

        //trigger "(Control 20)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
          ItemNoOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Variant Code"(Control 108)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        VariantCodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Control 100)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        LocationCodeOnAfterValidate;
        // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
        if "Location Code" <> xRec."Location Code" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 DDR DIT-770 #1189
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Bin Code"(Control 22)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        BinCodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on "Quantity(Control 86)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        QuantityOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Unit of Measure Code"(Control 110)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        UnitofMeasureCodeOnAfterValida;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Unit Cost"(Control 88)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        UnitCostOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Unit Amount"(Control 90)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        UnitAmountOnAfterValidate;
        */
        //end;

        addfirst(Control1)
        {
            /* //Bc Upgrade YADAVM09 Drink it field commented>>
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
            }
            */ //Bc Upgrade YADAVM09 Drink it field commented<<
            field("Line No."; rec."Line No.")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the journal line.';
            }
        }
        addafter("Item No.")
        {
            field("Item Charge No."; Rec."Item Charge No.")
            {
                Editable = "Item Charge No.Editable";
                Enabled = "Item Charge No.Enable";
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Charge No. field.';
                /* //Bc Upgrade YADAVM09 Drink it function Commented>>
                     trigger OnValidate();
                       begin
                         ItemChargeNoOnAfterValidate;
                       end;
                */ //Bc Upgrade YADAVM09 Drink it function Commented>>
            }
        }
        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        addafter("ShortcutDimCode[8]")
        {
            field("Responsibility Center"; "Responsibility Center")
            {
                Visible = false;

                trigger OnValidate();
                begin
                    // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
                    if "Responsibility Center" <> xRec."Responsibility Center" then
                        CurrPage.UPDATE(true);
                    // >>DITW18.00.06 DDR DIT-770 #1189
                end;
            }
            field("Physical Location Group Code"; "Physical Location Group Code")
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
        }
        */ //Bc Upgrade YADAVM09 Drink it field commented>>
        addafter("Location Code")
        {
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zone Code field.';
            }
        }
        /* //Bc Upgrade YADAVM09 Drink it visibilty code commented>>
        addafter(Quantity)
        {
            field("Scrap Code"; "Scrap Code")
            {
                Editable = "Scrap CodeEditable";
                Visible = false;

                trigger OnValidate();
                begin
                    if "Line No." <> 0 then
                        CurrPage.UPDATE(true);
                end;
            }
            field("Scrap Quantity"; "Scrap Quantity")
            {
                Editable = "Scrap QuantityEditable";
                Visible = false;

                trigger OnAssistEdit();
                begin
                    // <<DITW19.00.08 DDR 17/08/2016 BL#10443
                    OpenLossBreakdownLines;
                    CurrPage.UPDATE;
                    // >>DITW19.00.08 DDR BL#10443
                end;

                trigger OnValidate();
                begin
                    if "Line No." <> 0 then
                        CurrPage.UPDATE(true);
                end;
            }
            field("Exist Loss Breakdown"; "Exist Loss Breakdown")
            {
                Visible = false;
            }
            field(LotNo; LotNoText)
            {
                CaptionML = ENU = 'Lot No.',
                            FRA = 'N° lot';
                Editable = false;
                Style = Attention;
                StyleExpr = LotNocolor;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    //<<QXL9.00.001 DAT 23/03/2016
                    OpenItemTrackingLines(false);
                    // <<DITW19.00.08 DDR 17/08/2016 BL#10443
                    if QualitySetup.READPERMISSION and ("Item Charge No." = '') then begin
                        // >>DITW19.00.08 DDR BL#10443
                        LotNo := QualityManagement.GetItemJnlLineLotNos(Rec);
                        CurrPage.UPDATE;
                    end;
                    //>>QXL9.00.001 DAT 23/03/2016
                end;
            }
        }
        
        addafter("Unit Amount")
        {
            
            field(RTCTotalLine; GetTotalingLine(1, FIELDNO(Amount), true))
            {
                AutoFormatType = 1;
                BlankZero = true;
                CaptionML = ENU = 'Total Amount',
                            FRA = 'Montant total';
                Description = 'DITW17.10.02B DIT-770 #541';
                Editable = false;
                QuickEntry = false;
            }
        }
         */ //Bc Upgrade YADAVM09 Drink it visibilty code commented<<
        addafter("Applies-from Entry")
        {
            /* //Bc Upgrade YADAVM09 Drink it visibilty code commented<<
            field("Due Tax"; "Due Tax")
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
            */ //Bc Upgrade YADAVM09 Drink it visibilty code commented<<
            field("Source No."; Rec."Source No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Source No. field.';
            }

            field("Actual Posted Consumption"; Rec."Actual Posted Consumption FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual Posted Consumption field.';
            }
            field("Actual Posted Lot No."; Rec."Actual Posted Lot No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual Posted Lot No. field.';
            }
            field("Consumption Suggested"; Rec."Consumption Suggested FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Consumption Suggested field.';
            }
            field("Consumption Allocated"; Rec."Consumption Allocated FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Consumption Allocated field.';
            }
            field("Quantity Allocated"; Rec."Quantity Allocated FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity Allocated field.';
            }
        }
        addafter(Control1905767507)
        {
            part("Item Journal FactBox CBN"; "Item Journal FactBox CBN")
            {
                Caption = 'Item Journal FactBox';
                SubPageLink = "Journal Template Name" = FIELD("Journal Template Name"),
                              "Journal Batch Name" = FIELD("Journal Batch Name"),
                              "Consumption Suggested FND" = CONST(true);
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
        }
        modify("Bin Contents")
        {
            CaptionML = ENU = 'Bin Contents', FRA = 'Contenu emplacement';
            Promoted = true;
            PromotedCategory = Process;
        }
        modify("Pro&d. Order")
        {
            CaptionML = ENU = 'Pro&d. Order', FRA = '&O.F.';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
            ToolTipML = ENU = 'View or change detailed information about the record that is being processed on the journal line.', FRA = 'Affichez ou modifiez les informations détaillées sur l''enregistrement qui sont traitées sur la ligne feuille.';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
        }
        modify("Item Ledger E&ntries")
        {
            CaptionML = ENU = 'Item Ledger E&ntries', FRA = 'É&critures comptables article';
            ToolTipML = ENU = 'View the item ledger entries of the item on the journal line.', FRA = 'Affichez les écritures comptables article pour l''article dans la ligne feuille actuelle.';
        }
        modify("Capacity Ledger Entries")
        {
            CaptionML = ENU = 'Capacity Ledger Entries', FRA = 'Écritures comptables capacité';
            ToolTipML = ENU = 'View the capacity ledger entries of the involved production order. Capacity is recorded either as time (run time, stop time, or setup time) or as quantity (scrap quantity or output quantity).', FRA = 'Affichez les écritures comptables capacité de l''ordre de fabrication concerné. La capacité est enregistrée en tant que temps (Temps d''exécution, Temps d''arrêt, Temps de préparation) ou en tant que quantité (Quantité perte, Quantité produite).';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Calc. Co&nsumption")
        {
            CaptionML = ENU = 'Calc. Co&nsumption', FRA = '&Calc. consommation';
            ToolTipML = ENU = 'Use a batch job to help you fill the consumption journal with actual or expected consumption figures.', FRA = 'Utilisez un traitement par lots pour remplir la feuille consommation à l''aide des chiffres de consommation réels ou attendus.';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify("P&ost")
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
            ToolTipML = ENU = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.', FRA = 'Finalisez et préparez-vous à imprimer le document ou la feuille. Les valeurs et les quantités sont validées en fonction des comptes associés. Une fenêtre de demande d''état où vous pouvez spécifier ce qu''il faut inclure sur l''élément à imprimer.';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            ToolTipML = ENU = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.', FRA = 'Préparez-vous à imprimer le document. Une fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';
        }
        addfirst("&Line")
        {
            separator(Separator1100083204)
            {
            }
        }
        /* //Bc Upgrade YADAVM09 Drink it Action code commented>>
        addafter("Item &Tracking Lines")
        {
            
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
                    Rec.CreateFEFOTracking(false);
                    CurrPage.UPDATE(false);
                end;
            }
        }
        addafter("Bin Contents")
        {
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
            separator(Separator1100066000)
            {
            }
            action("<Action1161021002>")
            {
                CaptionML = ENU = 'Show N-owm activities',
                            FRA = 'Visualiser Activitées N-owm';
                Description = 'DIT-715 #806';

                trigger OnAction();
                var
                    OWMUtils: Codeunit "N-owm Utils";
                begin
                    OWMUtils.ShowActivityStatus(OWMUtils.ActProdConsump, "Document No.", "Location Code");
                    //DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
                end;
            }
        }
        
        addfirst(ActionContainer1900000004)
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

                    trigger OnAction();
                    begin
                        // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                        ExpandLines := false;
                        CurrPage.UPDATE(true);
                        // >>DITW17.10.03 DDR DIT-770 #541
                    end;
                }
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it visibilty code commented<<
        addafter("Calc. Co&nsumption")
        {
            action("<Action3>")
            {
                ApplicationArea = All;
                Caption = 'Suggest Consumption Lines';
                Ellipsis = true;
                Image = SuggestLines;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Suggest Consumption Lines action.';

                trigger OnAction();
                var
                    ItemJnlLineL: Record "Item Journal Line";
                    SuggestConsJnlL: Report "Suggest Allocate Consump CBN";
                    Text000L: Label 'Would you like to delete the existing lines?';
                begin
                    //HEI.02>>
                    ItemJnlLineL.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    ItemJnlLineL.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    if not ItemJnlLineL.ISEMPTY then begin
                        if CONFIRM(Text000L, true) then
                            ItemJnlLineL.DELETEALL(true)
                        else
                            exit;
                    end else begin
                        SuggestConsJnlL.InitializeRequest(Rec."Journal Template Name", Rec."Journal Batch Name", 0);
                        SuggestConsJnlL.RUN();
                    end;
                    //HEI.02<<
                end;
            }
            action("<Action4>")
            {
                ApplicationArea = All;
                Caption = 'Allocate Inventory';
                Ellipsis = true;
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Allocate Inventory action.';

                trigger OnAction();
                var
                    ItemJnlLineL: Record "Item Journal Line";
                    AllocateConsJnlL: Report "Suggest Allocate Consump CBN";
                    Text000L: Label 'Please create Consumption lines first.';
                begin
                    //HEI.02>>
                    ItemJnlLineL.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    ItemJnlLineL.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    ItemJnlLineL.SETRANGE("Consumption Suggested FND", true);
                    if ItemJnlLineL.ISEMPTY then
                        ERROR(Text000L)
                    else begin
                        AllocateConsJnlL.InitializeRequest(Rec."Journal Template Name", Rec."Journal Batch Name", 1);
                        AllocateConsJnlL.RUN();
                    end;
                    //HEI.02<<
                end;
            }
            separator(Separator1100083008)
            {
            }
            /* //Bc Upgrade YADAVM09 Drink it Action commented>>
            action("&Insert Item Charges")
            {
                CaptionML = ENU = '&Insert Item Charges',
                            FRA = '&Inserer Frais Annexes';
                Image = TaxSetup;
                ShortCutKey = 'Ctrl+Y';
                
                                trigger OnAction();
                                begin
                                    // <<DITW15.00.00.37 DDR 19/01/2010
                                    InsertExtendedCharges(true);
                                end;
                                
            }
            */ // Bc Upgrade YADAVM09 Drink it function commented<<
            /* //Bc Upgrade Drink it action commented>>
            separator(Separator1100076700)
            {
            }

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
                    Rec.CreateFEFOTrackingJournal(false);
                    CurrPage.UPDATE(false);
                end;
            }
            */ //Bc Upgrade Drink it action commented<<
        }
    }

    var
        //QualitySetup: Record "Quality Setup";//Bc Upgrade YADAVM09 Drink it object>>
        ManufacturingSetup: Record "Manufacturing Setup";
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
        //QualityManagement: Codeunit "Quality Management";//Bc Upgrade YADAVM09 Drink it object>>
        LotNo: Code[20];
        IndentLine: Integer;

        LotNoText: Text[1024];


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemJnlMgt.GetConsump(Rec,ProdOrderDescription);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ItemJnlMgt.GetConsump(Rec,ProdOrderDescription);
    // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
    SETFILTER("Resp. Center Table Filter",
      UserSetupMgt.GetRespCenterFilter(EntryTypeToRespID,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",
      UserSetupMgt.GetRespPhysLocationFilter(EntryTypeToRespID,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",
      UserSetupMgt.GetRespLocationFilter(EntryTypeToRespID,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 DDR DIT-770 #1189
    // <<DITW15.00.00.37 DDR 19/01/2010
    UpdateFields();
    // >>DITW15.00.00.24 DDR
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    IndentLine := IndentRecordDIT(ExpandLines);
    // >>DITW17.10.03 DDR DIT-770 #541
    ShowShortcutDimCode(ShortcutDimCode);
    //<<QXL9.00.001 DAT 23/03/2016
    if QualitySetup.READPERMISSION and ("Item Charge No." = '') then
      LotNo := QualityManagement.GetItemJnlLineLotNos(Rec)
    else
      LotNo := '';
    LotNoText := FORMAT(LotNo);
    LotNoTextOnFormat(LotNoText);
    //>>QXL9.00.001 DAT 23/03/2016
    */
    //end;


    //Unsupported feature: CodeModification on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    COMMIT;
    if not ReserveItemJnlLine.DeleteLineConfirm(Rec) then
      exit(false);
    ReserveItemJnlLine.DeleteLine(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.37 DDR 20/07/2010
    //COMMIT;
    //IF NOT ReserveItemJnlLine.DeleteLineConfirm(Rec) THEN
    //  EXIT(FALSE);
    //ReserveItemJnlLine.DeleteLine(Rec);
    // Move to function TriggerOnDeleteRecord() to solve RTC Collapse delete records
    // Temporary until next Mirosoft release
    exit(TriggerOnDeleteRecord());
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnFindRecord". Please convert manually.

    //trigger OnFindRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW16.00.00.37 DIT-715 #1
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //EXIT(FIND(Which));
    exit(FindRecordDIT(Which,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    // >>DITW16.00.00.37 DIT-715 #1
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
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
    */
    //end;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetUpNewLine(xRec);
    VALIDATE("Entry Type","Entry Type"::Consumption);
    CLEAR(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
    //SetUpNewLine(xRec);
    //VALIDATE("Entry Type","Entry Type"::Consumption);
    //CLEAR(ShortcutDimCode);
    // Move to function TriggerOnNewRecord() to solve RTC Collapse delete records
    // Temporary until next Mirosoft release
    TriggerOnNewRecord(BelowxRec);
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNextRecord". Please convert manually.

    //trigger OnNextRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW16.00.00.37 DIT-715 #1
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //EXIT(NEXT(Steps));
    exit(NextRecordDIT(Steps,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    // >>DITW16.00.00.37 DIT-715 #1
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if IsOpenedFromBatch then begin
      CurrentJnlBatchName := "Journal Batch Name";
      ItemJnlMgt.OpenJnl(CurrentJnlBatchName,Rec);
      exit;
    end;
    ItemJnlMgt.TemplateSelection(PAGE::"Consumption Journal",4,false,Rec,JnlSelected);
    if not JnlSelected then
      ERROR('');
    ItemJnlMgt.OpenJnl(CurrentJnlBatchName,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      // <<DITW16.00.00.40 DDR 13/01/2012 DIT-715 #194
      // to run all custom C/AL into this trigger
      //EXIT;
    //end;
    end else begin
    // >>DITW16.00.00.40 DDR DIT-715 #194
      ItemJnlMgt.TemplateSelection(PAGE::"Consumption Journal",4,false,Rec,JnlSelected);
      if not JnlSelected then
        ERROR('');
      ItemJnlMgt.OpenJnl(CurrentJnlBatchName,Rec);
    // <<DITW16.00.00.40 DDR 13/01/2012 DIT-715 #194
    end;
    // >>DITW16.00.00.40 DDR DIT-715 #194

    // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189-DITW110.00.12 MSF 04/05/2018 NRQ#55899
    FILTERGROUP(2);
    SETFILTER("Responsibility Center",UserSetupMgt.GetProductionTextFilter);
    FILTERGROUP(0);
    // >>DITW18.00.06 DDR DIT-770 #1189-DITW110.00.12 MSF 04/05/2018 NRQ#55899

    // <<DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    if ManufacturingSetup.GET then begin
      GenBusPostingGroupEditable := ManufacturingSetup."Editable Item Posting Groups";
      GenProdPostingGroupEditable := GenBusPostingGroupEditable;
    end;
    // >>DITW15.00.00.35 PRODW14.00.00.08.14
    // <<DITW17.00.01 DDR 12/03/2013 DIT-770 #001
    if "Journal Template Name" = '' then
      "Journal Template Name" := GETRANGEMAX("Journal Template Name");
    if "Journal Batch Name" = '' then
      "Journal Batch Name" := GETRANGEMAX("Journal Batch Name");
    // >>DITW17.00.01 DDR DIT-770 #001
    // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
    if not ISEMPTY then
      FINDLAST;
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    ExpandLines := false;
    ShowButtonsCE := IsShowButtonsCEDIT();
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;

    /* //Bc Upgrade YADAVM09 Drink it Function >>
        procedure InsertExtendedCharges(FromHeader: Boolean);
        begin
            // <<DITW15.00.00.37 DDR 19/01/2010
            if InsertChargeLines(FromHeader) then
                CurrPage.UPDATE(true);
        end;
    
    local procedure UpdateFields();
    var
        CollapsedLine: Boolean;
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010 - DITW15.00.00.38 DDR 16/07/2010 #1194 04/08/2010 #1216
        // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
        CollapsedLine := not ExpandLines;
        // >>DITW17.10.03 DDR DIT-770 #541
        "Item No.Editable" := FormEditableField(FIELDNO("Item No."));
        // <<DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 - DITW17.00.01 DDR 10/12/2012 DIT-770 #001
        "Item Charge No.Editable" := false;
        "Item Charge No.Enable" := false;
        //"Item Charge No.Editable" := FormEditableField(FIELDNO("Item Charge No."));
        // >>DITW16.00.00.38 DDR DIT-715 #1
        QuantityEditable := FormEditableField(FIELDNO(Quantity));
        "Unit CostEditable" := FormEditableField(FIELDNO("Unit Cost")) and not CollapsedLine;
        "Unit AmountEditable" := FormEditableField(FIELDNO("Unit Amount")) and not CollapsedLine;
        // <<DITW15.00.00.37 DDR 29/01/2010
        "AAD No.Editable" := FormEditableField(FIELDNO("AAD No."));
        "AAD No. SeriesEditable" := FormEditableField(FIELDNO("AAD No. Series"));
        "Item DTax Group CodeEditable" := FormEditableField(FIELDNO("Item DTax Group Code"));
        CompanyTaxRegistrationNoEditab := FormEditableField(FIELDNO("Company Tax Registration No."));
        "Tariff No.Editable" := FormEditableField(FIELDNO("Tariff No."));
        // >>DITW15.00.00.37 DDR
        // <<DITW19.00.08 DDR 17/08/2016 29/09/2016 BL#10443
        "Scrap CodeEditable" := FormEditableField(FIELDNO("Scrap Code"));
        "Scrap QuantityEditable" := FormEditableField(FIELDNO("Scrap Quantity"));
        GlobalTax1ValueEditable := HasTaxSpecEditable("Strength Spec. Code") and not "Is Item Charge";
        GlobalTax2ValueEditable := HasTaxSpecEditable("Vol-Strength Spec. Code") and not "Is Item Charge";
        // >>DITW19.00.08 DDR BL#10443
    end;

    procedure TriggerOnDeleteRecord(): Boolean;
    var
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
    begin
        // DITW16.00.00.37 DDR 20/07/2010 (moved trigger bugfix RTC collapse page)
        COMMIT;
        if not ReserveItemJnlLine.DeleteLineConfirm(Rec) then
            exit(false);
        // <<QXL9.00.001 DAT 23/03/2016
        if QualitySetup.READPERMISSION then begin
            if not QualityManagement.DeleteItemJnlLineConfirm(Rec) then
                exit(false);
        end;
        // >>QXL9.00.001 DAT 23/03/2016
        ReserveItemJnlLine.DeleteLine(Rec);
        // <<QXL9.00.001 DAT 23/03/2016
        if QualitySetup.READPERMISSION then
            QualityManagement.DeleteItemJnlLine(Rec);
        // >>QXL9.00.001 DAT 23/03/2016

        exit(true);
    end;

    procedure TriggerOnNewRecord(BelowxRec: Boolean): Boolean;
    begin
        // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
        INIT;
        // >>DITW16.00.00.38 DDR DIT-715 #50
        // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        LotNoText := '';
        // >>DITW19.00.08 DDR BL#10443
        // <<DITW15.00.00.35 DDR 19/10/2009
        FILTERGROUP(2);
        if GETFILTER("Journal Template Name") <> '' then
            "Journal Template Name" := GETFILTER("Journal Template Name");
        if GETFILTER("Journal Batch Name") <> '' then
            "Journal Batch Name" := GETFILTER("Journal Batch Name");
        // <<DITW16.00.00.40 DDR 12/06/2012 DIT-715 #310
        if GETFILTER("Document No.") <> '' then
            EVALUATE("Document No.", GETFILTER("Document No."));
        // >>DITW16.00.00.40 DDR DIT-715 #310
        FILTERGROUP(0);
        // >>DITW15.00.00.35 DDR

        SetUpNewLine(xRec);
        // <<DITW16.00.00.40 DDR 12/06/2012 DIT-715 #310
        if "Document No." = '' then
            "Document No." := xRec."Document No.";
        // >>DITW16.00.00.40 DDR DIT-715 #310
        VALIDATE("Entry Type", "Entry Type"::Consumption);
        CLEAR(ShortcutDimCode);
        // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
        LotNo := '';
        // >>DITW15.00.00.22 PRODW14.00.00.08 DDR

        // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
        exit(true);
        // >>DITW16.00.00.38 DDR DIT-715 #50
    end;

    local procedure PostingDateOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.24 DDR
    end;

    local procedure ProdOrderNoOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.24 DDR
    end;

    local procedure ProdOrderLineNoOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.24 DDR
    end;

    local procedure ProdOrderCompLineNoOnAfterVali();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.24 DDR
    end;

    local procedure DocumentDateOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure DocumentNoOnAfterValidate();
    begin
        // <<DITW15.00.00.25 DDR 24/10/2008
        if "Line No." <> 0 then
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
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.24 DDR
    end;

    local procedure LocationCodeOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure BinCodeOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure QuantityOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure UnitofMeasureCodeOnAfterValida();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure UnitCostOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if xRec."Unit Cost" <> "Unit Cost" then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure UnitAmountOnAfterValidate();
    begin
        // <<DITW15.00.00.24 DDR 25/09/2008
        if xRec."Unit Amount" <> "Unit Amount" then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.24 DDR
    end;

    local procedure LotNoTextOnFormat(var Text: Text[1024]);
    begin
        // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        if ((Quantity = 0) and ("Output Quantity" = 0)) or ("Item Charge No." <> '') or ("Item No." = '') then begin
            LotNocolor := false;
            Text := '';
            exit;
        end;
        // >>DITW19.00.08 DDR BL#10443
        //<<QXL9.00.001 DAT 23/03/2016
        if QualitySetup.READPERMISSION and ("Item Charge No." = '') then begin
            LotNocolor := QualityManagement.IsRequired(Text);
        end;
        //>>QXL9.00.001 DAT 23/03/2016
    end;
    */ //Bc Upgrade YADAVM09 Drink it Function >>

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

