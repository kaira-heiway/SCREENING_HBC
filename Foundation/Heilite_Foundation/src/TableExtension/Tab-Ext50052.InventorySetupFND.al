tableextension 50052 InventorySetupExtFND extends "Inventory Setup"
{
    // version NAVW19.00,FINXL10.01,DITW110.00.11,HEI.16

    // DITW15.00.00.23 DDR 28/07/2008 Added function GetUnitOfMeasureCaptionClass()
    //                                Added fields
    //                                  2013760 Volume Unit of Measure Code (default to show the caption)
    //                                Certification rules
    //                                  Remove Global text constant Text007
    // DITW15.00.00.33 DDR 08/05/2009 Added fields
    //                                  2013755 DTax per Group Mandatory
    // DITW15.00.00.38 DDR 20/12/2010 issue 717 Added fields
    //                                            2014114 Def. AAD Responsible No.
    //                                            2014115 Def. Std. Text Code (Area 23)
    //                                            2014116 Def. Transport Time
    //                                            2014117 Def. Other Details Transport
    //                                            2014118 Def. Tax Spec. Code
    //                                            2014119 Def. Tax Spec.2 Code
    //                                          Added functions GetUomCaptionClass()
    //                                          Added text constants Text2014560,Text2014561
    // DITW15.00.00.39 DDR 25/08/2011 issue 1393
    //                                  Added fields
    //                                    2014417 Item Treeview Method
    //                     15/09/2011 issue 1365
    //                                  Added fields
    //                                    2014506 Stockout Warning (Relation)
    //                                    2014507 Stockout Type (Relation)
    //                     20/10/2011 issue 1365 Modified caption + OptionCaption field2014506
    //                     28/10/2011 issue 1457 Modified many ML captions
    // DITW16.00.00.40 - PRODW16.00.00.08.19 DDR 17/01/2012 DIT-715 #189
    //                                  Added fields
    //                                    4 Allow WIP Acc. from component

    // DITW17.00.02 DDR 02/09/2013 DIT-770 #181 Added fields
    //                                            2014418 Check Transfer Header Dimensions
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 16/06/2014 DIT-770 #393 Price report - Extension to the price report in R2
    //                                          Added field - "2035195" Pallet
    // DITW18.00.07 VSC 09/05/2016 DIT-770 #1971 - #1976 Add fields "Min. Volume Warning","Max. Volume Warning","Max. Weight Warning""Min. Weight Warning"
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // FINXL10.01 AKH 19/07/2017 NRQ#33089 Added new field 2029610 "Item Auto Dimension Code"
    // DITW110.00.11 SFI 30/08/2017 BL#14417 New fields
    //                                         2013610 "Autom. Deposit Posting"
    //                                         2013611 "Expected Deposit Posting to GL"
    // DITW110.00.11 MSF 07/11/2017 NRQ#13577 Autoblock Customer, Item, Vendor card based on setup
    //                                  Added fields Autoblock Item On Changes
    //                                               Autoblock Item On  Dimension
    // DITW110.00.12A HBA 20/06/2018 NRQ#74529 Added field 2014430 "Auto Adjust Lot Track. Qty"
    // DITW110.00.12 AKH 30/03/2018 NRQ#16026 Order Shipment Planning: Sync Sales - Transfer

    // HEI.01 FDD-GAPID043 IBM LAZARE02 11.10.2017 # New field "Item Global ID As Cross Ref."
    // HEI.02 FDD-LB-GAPLOG04 IBM NASTAA02 25.07.2018 # Order Confirmation Almaza, Proforma Invoice and Export Invoice
    // HEI.03 RFC-CHG0248455 IBM.LS 03.12.2018
    //   # New Fields created: 50010 - "Active Best Before Date" (Caption - "Activate Expiry Notification")
    //                         50011 - "Item Category Typology" (Caption - "Expiry Notification Item Typology")
    // HEI.04 RFC-CHG0248455 IBM.LS 30.01.2019
    //   # New Field created: 50012 - "Send E-Mail on Day" (Caption - "Send Expiry Notification on Day")
    // HEI.05 FDD-BPMGAP BRD HB398 IBM NASTAA02 19.04.2019 # Actual Product Costing
    //   # New Fields created: 50002 - Raw & Pack Mat Item Cat Code
    //                         50003 - Semi Finish Prod Item Cat Code
    //                         50004 - Finished Goods Item Cat Code
    //                         50005 - Costing Method
    //                         50006 - In Plant Unit of Measure
    //                         50007 - Only SKUs
    // HEI.06 CHG2026978 IBM.LS 18.11.2019
    //   # New Field created: 50013 - Prevent Phys Invt Jnl Fraction
    // HEI.07 CHG2103832 IBM POENAB02 25.03.2021 Skip/step over error messages during running an batch job: send motification by mail
    //   # New field: 50014 Adj. Cost. Error Notif. Email
    // HEI.08 IBM.AK CHG2072471 14.04.21
    // # Field-50012 "Send Email on day" removed
    // HEI.09 CHG2120546 IBM.AK 27.07.21
    // # Field -50015 added
    // HEI.10 CHG2119017 IBM.LS      20.08.2021
    //   # Created New Field: 50016 - CMG Code for Empty Bin
    // HEI.11 CHG2132673 IBM BULIMC01 18/03/2022 #COGS Allocation - new fields added:
    //   #50017-"Raw Materials Item Cat. Code"
    //   #50018-"Pack. Materials Item Cat. Code"
    //   #50019-"COGS Costing Method"
    // HEI.12 CHG2143756 SAHAL01      12.04.2022
    //   # Created New Fields: 50021 - Activate Unit Cost Warning Msg
    //                         50022 - Exclude CMG Dimension Value
    // HEI.13 CHG2154339 HB2904 KOROLA04 27.07.2022
    //   # Created New Field: 50023 - SCRAP Jnl. Template

    // HEI.14 CHG2171815 HB3141 NORRIQ ZOGHLE01 10.1.2023 Caluclate COGS Allocations based on Inventory Posting Group
    //   # Add fields : "COGS Allocation Calc. based on","Fnished Pdct. produced Inv.Pos" & "pdct. Bought  Resale Inv. Pos"

    // HEI.15 CHG2193490 IBM SISUM01 24/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # Add fields with ID 50027, 50028, 50029
    // HEI.16 CHG2187702 SAHAL01 18.09.2023 Revaluation journal items in error
    //   # Created New Field: 50030 - Activate Rev. Jnl. Error Log

    fields
    {
        modify("Primary Key")
        {
            CaptionML = ENU = 'Primary Key', FRA = 'Clé primaire';
        }
        modify("Automatic Cost Posting")
        {
            CaptionML = ENU = 'Automatic Cost Posting', FRA = 'Compta. coûts automatique';
        }
        modify("Location Mandatory")
        {
            CaptionML = ENU = 'Location Mandatory', FRA = 'Magasin obligatoire';
        }
        modify("Item Nos.")
        {
            CaptionML = ENU = 'Item Nos.', FRA = 'N° article';
        }
        modify("Automatic Cost Adjustment")
        {
            CaptionML = ENU = 'Automatic Cost Adjustment', FRA = 'Ajustement automatique des coûts';
            //OptionCaptionML = ENU = 'Never,Day,Week,Month,Quarter,Year,Always', FRA = 'Jamais,Jour,Semaine,Mois,Trimestre,Année,Toujours';
        }
        modify("Prevent Negative Inventory")
        {
            CaptionML = ENU = 'Prevent Negative Inventory', FRA = 'Éviter stock négatif';
        }
        modify("Transfer Order Nos.")
        {
            CaptionML = ENU = 'Transfer Order Nos.', FRA = 'N° ordre transfert';
        }
        modify("Posted Transfer Shpt. Nos.")
        {
            CaptionML = ENU = 'Posted Transfer Shpt. Nos.', FRA = 'N° expéd. transfert enreg.';
        }
        modify("Posted Transfer Rcpt. Nos.")
        {
            CaptionML = ENU = 'Posted Transfer Rcpt. Nos.', FRA = 'N° récept. transfert enreg.';
        }
        modify("Copy Comments Order to Shpt.")
        {

            //Unsupported feature: Change InitValue on ""Copy Comments Order to Shpt."(Field 5703)". Please convert manually.

            CaptionML = ENU = 'Copy Comments Order to Shpt.', FRA = 'Copier com. cde -> expédition';
        }
        modify("Copy Comments Order to Rcpt.")
        {

            //Unsupported feature: Change InitValue on ""Copy Comments Order to Rcpt."(Field 5704)". Please convert manually.

            CaptionML = ENU = 'Copy Comments Order to Rcpt.', FRA = 'Copier com. cde -> réception';
        }
        modify("Nonstock Item Nos.")
        {
            CaptionML = ENU = 'Nonstock Item Nos.', FRA = 'N° article non stocké';
        }
        modify("Outbound Whse. Handling Time")
        {
            CaptionML = ENU = 'Outbound Whse. Handling Time', FRA = 'Délai désenlogement';
        }
        modify("Inbound Whse. Handling Time")
        {
            CaptionML = ENU = 'Inbound Whse. Handling Time', FRA = 'Délai enlogement';
        }
        modify("Expected Cost Posting to G/L")
        {
            CaptionML = ENU = 'Expected Cost Posting to G/L', FRA = 'Compta. coûts prévus';
        }
        modify("Average Cost Calc. Type")
        {
            CaptionML = ENU = 'Average Cost Calc. Type', FRA = 'Type calcul coût moyen';
            //OptionCaptionML = ENU = ' ,Item,Item & Location & Variant', FRA = ' ,Article,Article & Magasin & Variante';
        }
        modify("Average Cost Period")
        {
            CaptionML = ENU = 'Average Cost Period', FRA = 'Période coût moyen';
            // OptionCaptionML = ENU = ' ,Day,Week,Month,Quarter,Year,Accounting Period', FRA = ' ,Jour,Semaine,Mois,Trimestre,Année,Période comptable';
        }
        modify("Item Group Dimension Code")
        {
            CaptionML = ENU = 'Item Group Dimension Code', FRA = 'Code axe groupe articles';
        }
        modify("Inventory Put-away Nos.")
        {
            CaptionML = ENU = 'Inventory Put-away Nos.', FRA = 'N° rangement stock';
        }
        modify("Inventory Pick Nos.")
        {
            CaptionML = ENU = 'Inventory Pick Nos.', FRA = 'N° prélèvement stock';
        }
        modify("Posted Invt. Put-away Nos.")
        {
            CaptionML = ENU = 'Posted Invt. Put-away Nos.', FRA = 'N° rang. stock enreg.';
        }
        modify("Posted Invt. Pick Nos.")
        {
            CaptionML = ENU = 'Posted Invt. Pick Nos.', FRA = 'N° prélèv. stock enreg.';
        }
        modify("Inventory Movement Nos.")
        {
            CaptionML = ENU = 'Inventory Movement Nos.', FRA = 'N° de mouvements de stock';
        }
        modify("Registered Invt. Movement Nos.")
        {
            CaptionML = ENU = 'Registered Invt. Movement Nos.', FRA = 'N° de mouvements de stock enregistrés';
        }
        modify("Internal Movement Nos.")
        {
            CaptionML = ENU = 'Internal Movement Nos.', FRA = 'N° de mouvements internes';
        }

        //Unsupported feature: CodeModification on ""Automatic Cost Posting"(Field 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Automatic Cost Posting" THEN BEGIN
          IF GLSetup.GET THEN
            IF NOT GLSetup."Use Legacy G/L Entry Locking" THEN
              MESSAGE(Text006,
                FIELDCAPTION("Automatic Cost Posting"),
                "Automatic Cost Posting",
                GLSetup.FIELDCAPTION("Use Legacy G/L Entry Locking"),
                GLSetup.TABLECAPTION,
                GLSetup."Use Legacy G/L Entry Locking");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Automatic Cost Posting" then begin
          if GLSetup.GET then
            if not GLSetup."Use Legacy G/L Entry Locking" then
        #4..9
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Automatic Cost Adjustment"(Field 30).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Automatic Cost Adjustment" <> "Automatic Cost Adjustment"::Never THEN BEGIN
          Item.SETCURRENTKEY("Cost is Adjusted","Allow Online Adjustment");
          Item.SETRANGE("Cost is Adjusted",FALSE);
          Item.SETRANGE("Allow Online Adjustment",FALSE);

          UpdateInvtAdjmtEntryOrder;

          InvtAdjmtEntryOrder.SETCURRENTKEY("Cost is Adjusted","Allow Online Adjustment");
          InvtAdjmtEntryOrder.SETRANGE("Cost is Adjusted",FALSE);
          InvtAdjmtEntryOrder.SETRANGE("Allow Online Adjustment",FALSE);
          InvtAdjmtEntryOrder.SETRANGE("Is Finished",TRUE);

          IF NOT (Item.ISEMPTY AND InvtAdjmtEntryOrder.ISEMPTY) THEN
            MESSAGE(Text000);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Automatic Cost Adjustment" <> "Automatic Cost Adjustment"::Never then begin
          Item.SETCURRENTKEY("Cost is Adjusted","Allow Online Adjustment");
          Item.SETRANGE("Cost is Adjusted",false);
          Item.SETRANGE("Allow Online Adjustment",false);
        #5..8
          InvtAdjmtEntryOrder.SETRANGE("Cost is Adjusted",false);
          InvtAdjmtEntryOrder.SETRANGE("Allow Online Adjustment",false);
          InvtAdjmtEntryOrder.SETRANGE("Is Finished",true);

          if not (Item.ISEMPTY and InvtAdjmtEntryOrder.ISEMPTY) then
            MESSAGE(Text000);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Expected Cost Posting to G/L"(Field 5800).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Expected Cost Posting to G/L" <> xRec."Expected Cost Posting to G/L" THEN
          IF ItemLedgEntry.FINDFIRST THEN BEGIN
            ChangeExpCostPostToGL.ChangeExpCostPostingToGL(Rec,"Expected Cost Posting to G/L");
            FIND;
          end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Expected Cost Posting to G/L" <> xRec."Expected Cost Posting to G/L" then
          if ItemLedgEntry.FINDFIRST then begin
            ChangeExpCostPostToGL.ChangeExpCostPostingToGL(Rec,"Expected Cost Posting to G/L");
            FIND;
          end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Average Cost Calc. Type"(Field 5804).OnValidate". Please convert manually.

        //trigger  Type"(Field 5804)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Average Cost Calc. Type");
        IF "Average Cost Calc. Type" <> xRec."Average Cost Calc. Type" THEN
          UpdateAvgCostItemSettings(FIELDCAPTION("Average Cost Calc. Type"),FORMAT("Average Cost Calc. Type"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Average Cost Calc. Type");
        if "Average Cost Calc. Type" <> xRec."Average Cost Calc. Type" then
          UpdateAvgCostItemSettings(FIELDCAPTION("Average Cost Calc. Type"),FORMAT("Average Cost Calc. Type"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Average Cost Period"(Field 5805).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Average Cost Period");
        IF "Average Cost Period" <> xRec."Average Cost Period" THEN
          UpdateAvgCostItemSettings(FIELDCAPTION("Average Cost Period"),FORMAT("Average Cost Period"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Average Cost Period");
        if "Average Cost Period" <> xRec."Average Cost Period" then
          UpdateAvgCostItemSettings(FIELDCAPTION("Average Cost Period"),FORMAT("Average Cost Period"));
        */
        //end;
        field(50000; "Item Global ID Cross Ref. FND"; Boolean)
        {
            Caption = 'Item Global ID As Cross Ref.';
            Description = 'HEI.01';
        }
        field(50001; "Packing Property Code FND"; Code[20])
        {
            Description = 'HEI.02';
            Caption = 'Packing Property Code';
            //TableRelation = Property.Code WHERE ("Table ID"=CONST(27));  // BC Upgrade NANDIS03
        }
        field(50002; "Raw Pack Mat Item Cat Code FND"; Text[100])
        {
            Caption = 'Raw and Packaging Materials Item Category Code';
            Description = 'HEI.05';
            TableRelation = "Item Category";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50003; "SemiFinish ProdItemCatCode FND"; Text[100])
        {
            Caption = 'Semi-finished Products Item Category Code';
            Description = 'HEI.05';
            TableRelation = "Item Category";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50004; "Finished Goods ItemCatCode FND"; Text[100])
        {
            Caption = 'Finished Goods Item Category Code';
            Description = 'HEI.05';
            TableRelation = "Item Category";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50005; "Costing Method FND"; Option)
        {
            Caption = 'Costing Method';
            Description = 'HEI.05';
            OptionCaption = 'FIFO,LIFO,Specific,Average,Standard';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(50006; "Planning Unit of Measure FND"; Code[10])
        {
            Caption = 'Planning Unit of Measure';
            Description = 'HEI.05';
            TableRelation = "Unit of Measure";
        }
        field(50010; "Active Best Before Date FND"; Boolean)
        {
            Caption = 'Activate Expiry Notification';
            Description = 'HEI.03';
        }
        field(50011; "Item Category Typology FND"; Code[250])
        {
            Caption = 'Expiry Notification Item Typology';
            Description = 'HEI.03';
            TableRelation = "Item Category";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50013; "Prevent PhysInvt.Jnl Frac. FND"; Code[50])
        {
            Description = 'HEI.06';
            Caption = 'Prevent Physical Inventory Journal Fraction';
            TableRelation = "Unit of Measure";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50014; "Adj. Cost. Err Notif.Email FND"; Text[110])
        {
            Caption = 'Adj. Cost. Error Notif. Email';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
            //TableRelation = "2C User Profile"."User Profile";  // BC Upgrade NANDIS03
            //This property is currently not supported
            //TestTableRelation = false;
            //ValidateTableRelation = false;
        }
        field(50015; "Lots skipped FND"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
            Caption = 'Lots skipped';
            TableRelation = "Lot No. Information"."Lot No.";
            ValidateTableRelation = false;
        }
        field(50016; "CMG Code for Empty Bin FND"; Code[250])
        {
            Description = 'HEI.10';
            Caption = 'CMG Code for Empty Bin';
            TableRelation = "Dimension Value".Code where("Dimension Code" = CONST('CMG'));
            ValidateTableRelation = false;
        }
        field(50017; "Raw Materials Item CatCode FND"; Text[50])
        {
            Caption = 'Raw Materials Item Category Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
            TableRelation = "Item Category";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50018; "Pack. Material ItemCatCode FND"; Text[50])
        {
            Caption = 'Packaging Materials Item Category Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
            TableRelation = "Item Category";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50019; "COGS Costing Method FND"; Option)
        {
            Caption = 'Costing Method';
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
            OptionCaption = 'Average|Standard,Average,Standard';
            OptionMembers = "Average|Standard","Average",Standard;
        }
        field(50021; "Activate UnitCost Warn.Msg FND"; Boolean)
        {
            Caption = 'Activate Missing Unit Cost Warning Message';
            Description = 'HEI.12';
        }
        field(50022; "Exclude CMG Dime. Value FND"; Code[250])
        {
            Caption = 'Exclude CMG Dimension Value';
            Description = 'HEI.12';
            TableRelation = "Dimension Value".Code where("Dimension Code" = CONST('CMG'));
            ValidateTableRelation = false;
        }
        field(50023; "SCRAP Jnl. Template FND"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Caption = 'SCRAP Journal Template';
            TableRelation = "Item Journal Template".Name;
        }
        field(50024; "COGS Allocation Calc.based FND"; Option)
        {
            Caption = 'COGS Allocation Calculation based on';
            DataClassification = ToBeClassified;
            Description = 'HEI.14';
            InitValue = "Costing Method";
            OptionCaption = 'Costing Method,Inventory Posting Group';
            OptionMembers = "Costing Method","Inventory Posting Group";
        }
        field(50025; "Finish Pdct.prod. Inv.Pos FND"; Code[20])
        {
            Caption = 'Finished Products Produced - Inventory Posting Group';
            DataClassification = ToBeClassified;
            Description = 'HEI.14';
            InitValue = 'FGPX';
            TableRelation = "Inventory Posting Group";
        }
        field(50026; "pdct. BoughtResale Inv.Pos FND"; Code[20])
        {
            Caption = 'Products Bought for Resale Inv. Pos';
            DataClassification = ToBeClassified;
            Description = 'HEI.14';
            InitValue = 'FGBX';
            TableRelation = "Inventory Posting Group".Code;
        }
        field(50027; "PPV Gen. Journal Template FND"; Code[10])
        {
            Caption = 'PPV Gen. Journal Template';
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
            TableRelation = "Gen. Journal Template".Name where(Type = FILTER(General));
        }
        field(50028; "PPV Gen. Journal Batch FND"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
            Caption = 'PPV Gen. Journal Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = FIELD("PPV Gen. Journal Template FND"));
        }
        field(50029; "Exclude Invent. Val. Zero FND"; Boolean)
        {
            Caption = 'Exclude Inventory Value Zero equal True Items';
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
        }
        field(50030; "Activate Rev.Jnl.Error Log FND"; Boolean)
        {
            Caption = 'Activate Revaluation Jnl. Error Log';
            Description = 'HEI.16';
        }
        //PATHAA02 GAP014_DTW, IBM GAP DTW 43>>
        field(50031; "Quality On Hold FND"; Code[10])
        {
            Caption = 'Quality On Hold';
            DataClassification = ToBeClassified;
            TableRelation = InspectionStatusHeaderFDW.Code;

            trigger OnValidate()
            begin
                // If rec."Quality On Hold" <> xRec."Quality On Hold" then
                //     CheckILEForInspectionStatus();
            end;
        }

        field(50032; "Quality Unrestricted FND"; Code[10])
        {
            Caption = 'Quality Unrestricted';
            DataClassification = ToBeClassified;
            TableRelation = InspectionStatusHeaderFDW.Code;

            trigger OnValidate()
            begin
                // If rec."Quality Unrestricted" <> xRec."Quality Unrestricted" then
                //     CheckILEForInspectionStatus();
            end;
        }

        field(50033; "Quality Blocked FND"; Code[10])
        {
            Caption = 'Quality Blocked';
            DataClassification = ToBeClassified;
            TableRelation = InspectionStatusHeaderFDW.Code;

            trigger OnValidate()
            begin
                // If rec."Quality Blocked" <> xRec."Quality Blocked" then
                // CheckILEForInspectionStatus();
            end;
        }
        //PATHAA02 GAP014_DTW, IBM GAP DTW 43<<

        // field(2013610; "Autom. Deposit Posting"; Boolean)
        // {
        //     Caption = 'Automatic Deposit Value Posting';
        //     Description = 'DITW110.00.11 BL#14417';
        // }
        // field(2013611; "Expected Deposit Posting to GL"; Boolean)
        // {
        //     Caption = 'Expected Deposit Value Posting';
        //     Description = 'DITW110.00.11 BL#14417';
        // }
        // field(2013755; "DTax per Group Mandatory"; Boolean)
        // {
        //     CaptionML = ENU = 'Tax Group Mandatory',
        //                 FRA = 'Groupe taxe obligatoire';
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013760; "Volume Unit of Measure Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Unit Volume Caption',
        //                 FRA = 'Libellé unité volume';
        //     Description = 'DITW15.00.00.23';
        //     TableRelation = "Unit of Measure";
        // }
        // field(2013910; "Min. Volume Warning"; Option)
        // {
        //     CaptionML = ENU = 'Min. Volume (Cubage) Warning',
        //                 FRA = 'Alerte sur Minimum Volume (cubage)';
        //     Description = 'DITW18.00.07 DIT-770 #1971';
        //     OptionCaptionML = ENU = 'None,Warning,Blocking',
        //                       FRA = 'Aucun,Avertissement,Blocage';
        //     OptionMembers = "None",Warning,Blocking;
        // }
        // field(2013915; "Max. Volume Warning"; Option)
        // {
        //     CaptionML = ENU = 'Max. Volume (Cubage) Warning',
        //                 FRA = 'Avertissement maximum volume (Cubage)';
        //     Description = 'DITW18.00.07 DIT-770 #1971';
        //     OptionCaptionML = ENU = 'None,Warning,Blocking',
        //                       FRA = 'Aucun,Avertissement,Blocage';
        //     OptionMembers = "None",Warning,Blocking;
        // }
        // field(2013916; "Max. Weight Warning"; Option)
        // {
        //     CaptionML = ENU = 'Max. Weight Warning',
        //                 FRA = 'Avertissement Poids maximum';
        //     Description = 'DITW18.00.07 DIT-770 #1971';
        //     OptionCaptionML = ENU = 'None,Warning,Blocking',
        //                       FRA = 'Aucun,Avertissement,Blocage';
        //     OptionMembers = "None",Warning,Blocking;
        // }
        // field(2013918; "Min. Weight Warning"; Option)
        // {
        //     CaptionML = ENU = 'Min. Weight Warning',
        //                 FRA = 'Poids Minimum Pour Avertissement';
        //     Description = 'DITW18.00.07 DIT-770 #1971';
        //     OptionCaptionML = ENU = 'None,Warning,Blocking',
        //                       FRA = 'Aucun,Avertissement,Blocage';
        //     OptionMembers = "None",Warning,Blocking;
        // }
        // field(2014060; "Default Route"; Code[20])
        // {
        //     Caption = 'Default Route';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     TableRelation = Route;
        // }
        // field(2014061; "Route Mandatory"; Boolean)
        // {
        //     Caption = 'Route Mandatory';
        //     Description = 'DITW110.00.12 NRQ#16026';
        // }
        // field(2014114; "Def. AAD Responsible No."; Code[10])
        // {
        //     CaptionML = ENU = 'AAD Responsible No.',
        //                 FRA = 'N° responsable AAD';
        //     Description = 'DITW15.00.00.38 #717';
        //     TableRelation = "AAD Responsible";
        // }
        // field(2014115; "Def. Std. Text Code (Area 23)"; Code[10])
        // {
        //     CaptionML = ENU = 'Standard Text Code (Area 23)',
        //                 FRA = 'Code texte standard (champ 23)';
        //     Description = 'DITW15.00.00.38 #717';
        //     TableRelation = "Standard Text";
        // }
        // field(2014116; "Def. Transport Time"; Text[50])
        // {
        //     CaptionML = ENU = 'Transport Time (17)',
        //                 FRA = 'Temps de Transport (17)';
        //     Description = 'DITW15.00.00.38 #717';
        // }
        // field(2014117; "Def. Other Details Transport"; Text[30])
        // {
        //     CaptionML = ENU = 'Other Details Transport (11)',
        //                 FRA = 'Autres spécificités transport (11)';
        //     Description = 'DITW15.00.00.38 #717';
        // }
        // field(2014118; "Def. Tax Spec. Code"; Code[20])
        // {
        //     CaptionClass = GetUomCaptionClass(Text2014560);
        //     CaptionML = ENU = 'Code',
        //                 FRA = 'Code';
        //     Description = 'DITW15.00.00.38 #717';
        //     TableRelation = "Tax Specification".Code where(Type = CONST(Specification));
        // }
        // field(2014119; "Def. Tax Spec.2 Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Degrees plato',
        //                 FRA = 'Degrés plato';
        //     Description = 'DITW15.00.00.38 #717';
        //     TableRelation = "Tax Specification".Code where(Type = CONST(Specification));
        // }
        // field(2014417; "Item Treeview Method"; Option)
        // {
        //     CaptionML = ENU = 'Item Treeview Mode',
        //                 FRA = 'Mode article arborescence';
        //     Description = 'DITW15.00.00.39 #1393';
        //     OptionCaptionML = ENU = ' ,Item Links,Group Codes,Category,Category & Product Group',
        //                       FRA = ' ,Liens article,Codes groupe,Catégorie,Catégorie & Groupe produit';
        //     OptionMembers = " ",Item,Group,Category,CatProduct;
        // }
        // field(2014420; "Check Trsf.Header Dimensions"; Boolean)
        // {
        //     CaptionML = ENU = 'Check Transfer Header Dimensions',
        //                 FRA = 'Vérifier les axes analytiques de l''entête transfert';
        //     Description = 'DITW17.00.02 DIT-770 #181';
        // }
        // field(2014430; "Auto Adjust Lot Track. Qty"; Boolean)
        // {
        //     Caption = 'Auto Adjust Lot Track. Qty in Item jnl';
        //     Description = 'DITW110.00.12A NRQ#74529';
        // }
        // field(2014506; "Stockout Warning (Relation)"; Option)
        // {
        //     CaptionML = ENU = 'Location Relationship Warning',
        //                 FRA = 'Alerte Relation magasin';
        //     Description = 'DITW15.00.00.39 #1365';
        //     OptionCaptionML = ENU = ' ,Manually,Automatic',
        //                       FRA = ' ,Manuellement,Automatique';
        //     OptionMembers = " ",Warning,Automatic;

        //     trigger OnValidate();
        //     begin
        //         if "Stockout Warning (Relation)" <> "Stockout Warning (Relation)"::" " then begin
        //             if "Stockout Type (Relation)" = "Stockout Type (Relation)"::" " then
        //                 "Stockout Type (Relation)" := "Stockout Type (Relation)"::Projected;
        //         end else
        //             "Stockout Type (Relation)" := "Stockout Type (Relation)"::" ";
        //     end;
        // }
        // field(2014507; "Stockout Type (Relation)"; Option)
        // {
        //     CaptionML = ENU = 'Location Relationship Type',
        //                 FRA = 'Type Relation magasin';
        //     Description = 'DITW15.00.00.39 #1365';
        //     OptionCaptionML = ENU = ' ,Projected Inventory Balance,Expected Inventory,Available Inventory',
        //                       FRA = ' ,Stock prévisionnel,Stock prév. (hors propositions),Stock disponible';
        //     OptionMembers = " ",Projected,Expected,Available;

        //     trigger OnValidate();
        //     begin
        //         if ("Stockout Warning (Relation)" = "Stockout Warning (Relation)"::" ") and
        //           ("Stockout Type (Relation)" <> "Stockout Type (Relation)"::" ")
        //         then
        //             TESTFIELD("Stockout Warning (Relation)");
        //         if ("Stockout Warning (Relation)" <> "Stockout Warning (Relation)"::" ") and
        //           ("Stockout Type (Relation)" = "Stockout Type (Relation)"::" ")
        //         then
        //             FIELDERROR("Stockout Type (Relation)");
        //     end;
        // }
        // field(2014600; "Autoblock Item On Changes"; Boolean)
        // {
        //     Caption = 'Autoblock Item On Changes';
        //     Description = 'NRQ#13577';
        // }
        // field(2014601; "Autoblock Item On  Dimension"; Boolean)
        // {
        //     Caption = 'Autoblock Item On  Dimension';
        //     Description = 'NRQ#13577';
        // }
        // field(2029610; "Item Auto Dimension Code"; Code[20])
        // {
        //     Caption = 'Item Auto Dimension Code';
        //     Description = 'FINXL10.01';
        //     TableRelation = Dimension;
        // }
        // field(2035194; "Allow WIP Acc. from component"; Boolean)
        // {
        //     CaptionML = ENU = 'WIP Account from components',
        //                 FRA = 'Compte en-cours des composants';
        //     Description = 'PRODW16.00.00.08.19 DIT-715 #189';
        // }
        // field(2035195; Pallet; Code[10])
        // {
        //     CaptionML = ENU = 'Pallet',
        //                 FRA = 'Palette';
        //     Description = 'DIT-770 #393';
        //     TableRelation = "Unit of Measure";
        // }  // BC Upgrade NANDIS03
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Some unadjusted value entries will not be covered with the new setting. You must run the Adjust Cost - Item Entries batch job once to adjust these.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Some unadjusted value entries will not be covered with the new setting. You must run the Adjust Cost - Item Entries batch job once to adjust these.;FRA=Certaines écritures valeur non ajustées ne seront pas couvertes avec le nouveau paramètre. Vous devez exécuter une fois le traitement par lots Ajuster coûts : Écr. article pour les ajuster.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=If you change the %1, the program must adjust all item entries.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=If you change the %1, the program must adjust all item entries.;FRA=Si vous modifiez le/la %1, le programme va ajuster toutes les écritures article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=The adjustment of all entries can take several hours.\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=The adjustment of all entries can take several hours.\;FRA=L'ajustement de l'ensemble des écritures peut prendre plusieurs heures.\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Do you really want to change the %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Do you really want to change the %1?;FRA=Souhaitez-vous quand même modifier le/la %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=The program has cancelled the change that would have caused an adjustment of all items.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=The program has cancelled the change that would have caused an adjustment of all items.;FRA=Le programme a annulé la modification qui aurait entraîné l'ajustement de toutes les écritures.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=%1 has been changed to %2. You should now run %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=%1 has been changed to %2. You should now run %3.;FRA=La valeur du champ %1 a été modifiée en %2. Vous devez maintenant exécuter le traitement par lots %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=The field %1 should not be set to %2 if field %3 in %4 table is set to %5 because of possibility of deadlocks.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=The field %1 should not be set to %2 if field %3 in %4 table is set to %5 because of possibility of deadlocks.;FRA=Le champ %1 ne doit pas être défini sur %2 si le champ %3 dans la table %4 est défini sur %5 en raison d'éventuels blocages.;
    //Variable type has not been exported.
    //PATHAA02 GAP014_DTW, IBM GAP DTW 43>>
    local procedure CheckILEForInspectionStatus()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        Text50000: TextConst ENU = 'You cannot modify Quality Inspection Codes because Item Ledger Entries already exist with Inspection Status.', FRA = 'Vous ne pouvez pas modifier les codes d inspection de qualité car des écritures de registre d article existent déjà avec un statut d inspection.'; //PATHAA02 GAP014_DTW, IBM GAP DTW 43
    begin
        ItemLedgEntry.SetFilter(ItemLedgEntry."Inspection Status 07FDW", '<>%1', '');
        if ItemLedgEntry.FindFirst() then
            Error(Text50000);
    end;
    //PATHAA02 GAP014_DTW, IBM GAP DTW 43<<

    var
        Text2014560: TextConst ENU = 'Code', FRA = 'Code';
        Text2014561: TextConst ENU = 'Degrees plato', FRA = 'Degrés plato';
}

