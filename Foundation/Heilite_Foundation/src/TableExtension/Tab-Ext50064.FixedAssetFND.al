tableextension 50064 FixedAssetExtFND extends "Fixed Asset"
{
    //     DITW15.00.00.35 DDR 24/04/2009 Added fields
    //                                  2034877 FA Template Code
    //                                Added functions
    //                                  TestFAEntries(),SetHideValidationDialog()
    //                    31/08/2009 Added fields
    //                                 2034892 Depreciation Starting Date
    //                                 2034893 Created by Service Item No.
    //                                 2034894 Exist Service Items
    //                                 2034895 Fixed Asset on Stock
    //                               Modified while creating Depreciation lines with a template code
    //                    02/09/2009 Added functions
    //                                 UpdateFADeprBookLines(),FADeprBookLinesExist(),PostFABackOnInventory()
    // DITW15.00.00.39 DDR 14/07/2011 issue 1258 Added fields
    //                                 2034883 Item No. (Service Item)
    // DITW16.00.00.40 DDR 13/01/2012 DIT-715 #177 Bugfix while validating a FA template, error in priorities of fields
    // DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327 Added fields
    //                                               2034850 DIT Sub-Contract Type (flowfield)
    //                                               2034915 DIT Contract No.
    //                                               2034955 Customer No.
    //                                               2034956 Customer Name
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties
    // DITW19.00.08 SFI 18/08/2016 BL#10868  (DIT-770 #2141) New field 2014411 "Allow Invoice Disc."
    //                                                       New function "SetupNewRec"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW114.00.15 EZOG 05/04/2022 NRQ#214426 Only Delete Customer Dimensions when deleting Customer
    // NRQ214424 EZOG 05/04/2022 Merge NRQ#214426
    // HEI.01 FDD RTRGAP057 IBM HORTOC01 27.07.2017
    //   # Add new field "Asset Indicator"
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New fields for MDM integration
    // HEI.03 FDD_CHG0246293 IBM ISYED01 10.10.2018 #Asset Quantity and Tag No info in FA Card  to incl. Quantiy, Tag No.
    //   # new filed Quantity and Tag No added to tale
    // HEI.05 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New field added:
    //     # 10810 Professional Tax
    // HEI.06 FDD-HB2373 - CHG2123486 IBM NANDIS01 23.09.2021 - Development - CMG mandatory on FA card
    //   # New field added - CMG Code(Field ID - 50004)
    // HEI.07 FDD-HB2373 - CHG2123486 IBM SRIVAS07 09-02-2023 - Development - CMG mandatory on FA
    //   # Validation added for Restricted CMG Dimension Value
    // HEI.08 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //   # New Field created #H&S Levy Tax Posting Group
    // version NAVW110.0.00.15601,FINXL10.00,DITW110.00.09,HEI.08,NRQ214424

    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Search Description")
        {
            CaptionML = ENU = 'Search Description', FRA = 'Désignation de recherche';
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify("FA Class Code")
        {
            CaptionML = ENU = 'FA Class Code', FRA = 'Code classe immo.';
        }
        modify("FA Subclass Code")
        {
            CaptionML = ENU = 'FA Subclass Code', FRA = 'Code sous-classe immo.';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("FA Location Code")
        {
            CaptionML = ENU = 'FA Location Code', FRA = 'Code emplacement immo.';
        }
        modify("Vendor No.")
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';
        }
        modify("Main Asset/Component")
        {
            CaptionML = ENU = 'Main Asset/Component', FRA = 'Immo. principale/Composant';
            //OptionCaptionML = ENU = ' ,Main Asset,Component', FRA = ' ,Immo. principale,Composant';
        }
        modify("Component of Main Asset")
        {
            CaptionML = ENU = 'Component of Main Asset', FRA = 'Composant immo. principale';
        }
        modify("Budgeted Asset")
        {
            CaptionML = ENU = 'Budgeted Asset', FRA = 'Immo. budgétée';
        }
        modify("Warranty Date")
        {
            CaptionML = ENU = 'Warranty Date', FRA = 'Date garantie';
        }
        modify("Responsible Employee")
        {
            CaptionML = ENU = 'Responsible Employee', FRA = 'Responsable';
        }
        modify("Serial No.")
        {
            CaptionML = ENU = 'Serial No.', FRA = 'N° de série';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify(Insured)
        {

            //Unsupported feature: Change CalcFormula on "Insured(Field 19)". Please convert manually.

            CaptionML = ENU = 'Insured', FRA = 'Assuré';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 20)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
        }
        // modify(Picture)
        // {
        //     CaptionML = ENU='Picture',FRA='illustration';
        // }//BC Upgrade KAPOOV01 Picture replaced by Image.
        modify("Maintenance Vendor No.")
        {
            CaptionML = ENU = 'Maintenance Vendor No.', FRA = 'N° société maintenance';
        }
        modify("Under Maintenance")
        {
            CaptionML = ENU = 'Under Maintenance', FRA = 'En maintenance';
        }
        modify("Next Service Date")
        {
            CaptionML = ENU = 'Next Service Date', FRA = 'Date prochain service';
        }
        modify(Inactive)
        {
            CaptionML = ENU = 'Inactive', FRA = 'Hors service';
        }
        modify("FA Posting Date Filter")
        {
            CaptionML = ENU = 'FA Posting Date Filter', FRA = 'Filtre date compta. immo.';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("FA Posting Group")
        {
            CaptionML = ENU = 'FA Posting Group', FRA = 'Groupe compta. immo.';
        }
        modify(Acquired)
        {

            //Unsupported feature: Change CalcFormula on "Acquired(Field 30)". Please convert manually.

            CaptionML = ENU = 'Acquired', FRA = 'Acquises';
        }
        modify(Image)
        {
            CaptionML = ENU = 'Image', FRA = 'Image';
        }

        //Unsupported feature: CodeModification on ""No."(Field 1).OnValidate". Please convert manually.

        //trigger "(Field 1)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." <> xRec."No." THEN BEGIN
          FASetup.GET;
          NoSeriesMgt.TestManual(FASetup."Fixed Asset Nos.");
          "No. Series" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "No." <> xRec."No." then begin
        #2..4
        end;
        */
        //end;


        //Unsupported feature: CodeModification on "Description(Field 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Search Description" = UPPERCASE(xRec.Description)) OR ("Search Description" = '') THEN
          "Search Description" := Description;
        IF Description <> xRec.Description THEN BEGIN
          FADeprBook.SETCURRENTKEY("FA No.");
          FADeprBook.SETRANGE("FA No.","No.");
          FADeprBook.MODIFYALL(Description,Description);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Search Description" = UPPERCASE(xRec.Description)) or ("Search Description" = '') then
          "Search Description" := Description;
        if Description <> xRec.Description then begin
        #4..6
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""FA Class Code"(Field 5).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "FA Subclass Code" = '' THEN
          EXIT;

        FASubclass.GET("FA Subclass Code");
        IF NOT (FASubclass."FA Class Code" IN ['',"FA Class Code"]) THEN
          "FA Subclass Code" := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "FA Subclass Code" = '' then
          exit;

        FASubclass.GET("FA Subclass Code");
        if not (FASubclass."FA Class Code" in ['',"FA Class Code"]) then
          "FA Subclass Code" := '';
        */
        //end;


        //Unsupported feature: CodeModification on ""FA Subclass Code"(Field 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        FASubclass.GET("FA Subclass Code");
        IF "FA Class Code" <> '' THEN BEGIN
          IF FASubclass."FA Class Code" IN ['',"FA Class Code"] THEN
            EXIT;

          ERROR(UnexpctedSubclassErr);
        end;

        VALIDATE("FA Class Code",FASubclass."FA Class Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        FASubclass.GET("FA Subclass Code");
        if "FA Class Code" <> '' then begin
          if FASubclass."FA Class Code" in ['',"FA Class Code"] then
            exit;

          ERROR(UnexpctedSubclassErr);
        end;

        VALIDATE("FA Class Code",FASubclass."FA Class Code");
        */
        //end;
        // BC Upgrade NANDIS03 - Blocked as FR localization field >>
        // field(10810; "Professional Tax"; Option)
        // {
        //     CaptionML = ENU = 'Professional Tax',
        //                 FRA = 'Taxe professionnelle';
        //     Description = 'HEI.05';
        //     OptionCaptionML = ENU = 'No Tax,Fixed Asset for more than 30 years 1,Fixed Asset for more than 30 years 2,Fixed Asset less than 30 years',
        //                       FRA = 'Pas de taxe,Immo. plus de 30 ans 1,Immo. plus de 30 ans 2,Immo. moins de 30 ans';
        //     OptionMembers = "No Tax","Fixed Asset for more than 30 years 1","Fixed Asset for more than 30 years 2","Fixed Asset less than 30 years";
        // }
        // BC Upgrade NANDIS03 - Blocked as FR localization field <<
        field(50000; "Asset Indicator FND"; Option)
        {
            Caption = 'Asset Indicator';
            Description = 'HEI.01';
            Editable = false;
            InitValue = "2";
            OptionCaption = 'OK,1,2';
            OptionMembers = OK,"1","2";
        }
        field(50001; "WHT Product Posting Group FND"; Code[10])
        {
            Caption = 'WHT Product Posting Group';
            Description = 'HEI.02';
            TableRelation = "WHT Product Posting Group FND".Code;
        }
        field(50002; "Quantity FND"; Decimal)
        {
            Description = 'HEI.03';
            Caption = 'Quantity';
        }
        field(50003; "Tag No FND"; Text[50])
        {
            Description = 'HEI.03';
            Caption = 'Tag No.';
        }
        field(50004; "CMG code FND"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
            Caption = 'CMG Code';

            trigger OnLookup();
            var
                DimValue: Record "Dimension Value";
                GLSetup: Record "General Ledger Setup";
                DimValueList: Page "Dimension Values";
            begin
                //HEI.06>>
                GLSetup.GET();
                if (GLSetup."CMG Dimension Code FND" <> '') then begin
                    DimValue.RESET();
                    DimValue.SETRANGE(DimValue."Dimension Code", GLSetup."CMG Dimension Code FND");
                    DimValueList.SETTABLEVIEW(DimValue);
                    DimValueList.LOOKUPMODE(true);

                    if DimValueList.RUNMODAL() = ACTION::LookupOK then begin
                        DimValueList.GETRECORD(DimValue);
                        "CMG code FND" := DimValue.Code;
                        VALIDATE("CMG code FND", DimValue.Code);
                    end;
                end;
                //HEI.06<<
            end;

            trigger OnValidate();
            var
                CMGRestriction: Label 'You can''t select %1 for Fixed Asset, for more information kindly check the Fixed Asset Setup.';
            begin
                //HEI.07>>
                FASetup.GET();
                if STRPOS(FASetup."Excluded CMG Dim. Values FND", "CMG code FND") <> 0 then
                    ERROR(CMGRestriction, "CMG code FND");
                //HEI.07<<
            end;
        }
        field(50005; "H&S Levy Tax Posting Group FND"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
            Caption = 'H&S Levy Tax Posting Group';
            TableRelation = "H&S Tax Posting Group FND";
        }
        //BC Upgrade KAPOOV01-drink-it>>
        // field(2014411; "Allow Invoice Disc."; Boolean)
        // {
        //     CaptionML = ENU = 'Allow Invoice Disc.',
        //                 FRA = 'Autoriser remise ligne';
        //     Description = 'DITW19.00.08 BL#10868';
        // }
        // field(2029610; "Shortcut Property 1 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,1/5600';
        //     CaptionML = ENU = 'Shortcut Property 1 Code',
        //                 FRA = 'Code raccourci propriété 1';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(5600),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(1));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 1 Code" := fctValidateShortcutPropertyCode(1, "Shortcut Property 1 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029611; "Shortcut Property 2 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,2/5600';
        //     CaptionML = ENU = 'Shortcut Property 2 Code',
        //                 FRA = 'Code raccourci propriété 2';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(5600),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(2));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 2 Code" := fctValidateShortcutPropertyCode(2, "Shortcut Property 2 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029612; "Shortcut Property 3 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,3/5600';
        //     CaptionML = ENU = 'Shortcut Property 3 Code',
        //                 FRA = 'Code raccourci propriété 3';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(5600),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(3));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 3 Code" := fctValidateShortcutPropertyCode(3, "Shortcut Property 3 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029613; "Shortcut Property 4 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,4/5600';
        //     CaptionML = ENU = 'Shortcut Property 4 Code',
        //                 FRA = 'Code raccourci propriété 4';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(5600),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(4));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 4 Code" := fctValidateShortcutPropertyCode(4, "Shortcut Property 4 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029614; "Shortcut Property 5 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,5/5600';
        //     CaptionML = ENU = 'Shortcut Property 5 Code',
        //                 FRA = 'Code raccourci propriété 5';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(5600),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(5));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 5 Code" := fctValidateShortcutPropertyCode(5, "Shortcut Property 5 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029615; "Shortcut Property 6 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,6/5600';
        //     CaptionML = ENU = 'Shortcut Property 6 Code',
        //                 FRA = 'Code raccourci propriété 6';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(5600),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(6));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 6 Code" := fctValidateShortcutPropertyCode(6, "Shortcut Property 6 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029616; "Shortcut Property 7 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,7/5600';
        //     CaptionML = ENU = 'Shortcut Property 7 Code',
        //                 FRA = 'Code raccourci propriété 7';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(5600),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(7));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 7 Code" := fctValidateShortcutPropertyCode(7, "Shortcut Property 7 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029617; "Shortcut Property 8 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,8/5600';
        //     CaptionML = ENU = 'Shortcut Property 8 Code',
        //                 FRA = 'Code raccourci propriété 8';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(5600),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(8));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 8 Code" := fctValidateShortcutPropertyCode(8, "Shortcut Property 8 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029618; "Shortcut Property 9 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,9/5600';
        //     CaptionML = ENU = 'Shortcut Property 9 Code',
        //                 FRA = 'Code raccourci propriété 9';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(5600),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(9));

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 9 Code" := fctValidateShortcutPropertyCode(9, "Shortcut Property 9 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029619; "Shortcut Property 10 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,10/5600';
        //     CaptionML = ENU = 'Shortcut Property 10 Code',
        //                 FRA = 'Code raccourci propriété 10';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(5600),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(10));

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 10 Code" := fctValidateShortcutPropertyCode(10, "Shortcut Property 10 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2034850; "DIT Sub-Contract Type"; Option)
        // {
        //     CalcFormula = Lookup("Financial Contract Header"."DIT Sub-Contract Type" where("Contract Type" = CONST(Contract),
        //                                                                                     "Contract No." = FIELD("Financial Contract No.")));
        //     CaptionML = ENU = 'Sub Contract Type',
        //                 FRA = 'Sous type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #327';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA = ' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance;
        // }
        // field(2034877; "FA Template Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Fixed Asset Template Code',
        //                 FRA = 'Code modèle immobilisation';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "FA Template";

        //     trigger OnValidate();
        //     var
        //         FATemplate: Record "FA Template";
        //         FADeprBookTempl: Record "FA Depreciation Book Template";
        //         ToFADeprBook: Record "FA Depreciation Book";
        //         LDeprBook: Record "Depreciation Book";
        //         DefaultDim: Record "Default Dimension";
        //         TempFA: Record "Fixed Asset" temporary;
        //         Confirmed: Boolean;
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/04/2009
        //         if ("FA Template Code" <> xRec."FA Template Code") and ("FA Template Code" <> '') then begin
        //             TESTFIELD(Blocked, false);
        //             TESTFIELD("Main Asset/Component", "Main Asset/Component"::" ");
        //             TestFAEntries(FIELDCAPTION("FA Template Code"));

        //             ToFADeprBook.SETCURRENTKEY("FA No.");
        //             ToFADeprBook.SETRANGE("FA No.", "No.");
        //             ToFADeprBook.DELETEALL(true);
        //             if not ToFADeprBook.ISEMPTY then
        //                 ERROR(Text001, TABLECAPTION, "No.");

        //             if HideValidationDialog then
        //                 Confirmed := true
        //             else
        //                 Confirmed := CONFIRM(Text2034841, false, FIELDCAPTION("FA Template Code"));
        //             if Confirmed then begin
        //                 FATemplate.GET("FA Template Code");
        //                 DimMgt.DeleteDefaultDim(DATABASE::"Fixed Asset", "No.");

        //                 // <<DITW15.00.00.35 DDR 31/08/2009
        //                 TempFA := Rec;
        //                 INIT;
        //                 "Depreciation Starting Date" := TempFA."Depreciation Starting Date";
        //                 // >>DITW15.00.00.35 DDR

        //                 "No. Series" := xRec."No. Series";
        //                 "FA Template Code" := FATemplate.Code;

        //                 Description := FATemplate.Description;
        //                 "FA Class Code" := FATemplate."FA Class Code";
        //                 "FA Subclass Code" := FATemplate."FA Subclass Code";
        //                 "Global Dimension 1 Code" := FATemplate."Global Dimension 1 Code";
        //                 "Global Dimension 2 Code" := FATemplate."Global Dimension 2 Code";
        //                 "Location Code" := FATemplate."Location Code";
        //                 "FA Location Code" := FATemplate."FA Location Code";
        //                 "Vendor No." := FATemplate."Vendor No.";
        //                 "Budgeted Asset" := FATemplate."Budgeted Asset";
        //                 "Responsible Employee" := FATemplate."Responsible Employee";
        //                 "Maintenance Vendor No." := FATemplate."Maintenance Vendor No.";
        //                 "FA Posting Group" := FATemplate."FA Posting Group";

        //                 FADeprBookTempl.SETRANGE("FA Template Code", "FA Template Code");
        //                 if FADeprBookTempl.FINDFIRST then
        //                     repeat
        //                         ToFADeprBook.INIT;
        //                         // <<DITW16.00.00.40 DDR 13/01/2012 DIT-715 #177
        //                         ToFADeprBook.VALIDATE("FA No.", "No.");
        //                         // >>DITW16.00.00.40 DDR DIT-715 #177
        //                         ToFADeprBook.TRANSFERFIELDS(FADeprBookTempl);
        //                         // <<DITW15.00.00.35 DDR 31/08/2009
        //                         // <<DITW16.00.00.40 DDR 13/01/2012 DIT-715 #177
        //                         ToFADeprBook."FA No." := "No.";
        //                         if ToFADeprBook."Depreciation Starting Date" = 0D then begin
        //                             TESTFIELD("Depreciation Starting Date");
        //                             ToFADeprBook."Depreciation Starting Date" := "Depreciation Starting Date";
        //                         end;
        //                         // >>DITW16.00.00.40 DDR DIT-715 #177
        //                         if ToFADeprBook.Description = '' then
        //                             ToFADeprBook.Description := Description;
        //                         ToFADeprBook."Main Asset/Component" := "Main Asset/Component";
        //                         ToFADeprBook."Component of Main Asset" := "Component of Main Asset";
        //                         LDeprBook.GET(ToFADeprBook."Depreciation Book Code");
        //                         if (ToFADeprBook."No. of Depreciation Years" <> 0) or
        //                           (ToFADeprBook."No. of Depreciation Months" <> 0)
        //                         then
        //                             LDeprBook.TESTFIELD("Fiscal Year 365 Days", false);
        //                         // >>DITW15.00.00.35 DDR
        //                         // <<DITW16.00.00.40 DDR 13/01/2012 DIT-715 #177
        //                         if ToFADeprBook."Straight-Line %" <> 0 then
        //                             ToFADeprBook.VALIDATE("Straight-Line %")
        //                         else
        //                             if ToFADeprBook."No. of Depreciation Years" <> 0 then
        //                                 ToFADeprBook.VALIDATE("No. of Depreciation Years")
        //                             else
        //                                 if ToFADeprBook."No. of Depreciation Months" <> 0 then
        //                                     ToFADeprBook.VALIDATE("No. of Depreciation Months");
        //                         // >>DITW16.00.00.40 DDR DIT-715 #177
        //                         ToFADeprBook.INSERT;
        //                     until FADeprBookTempl.NEXT = 0;

        //                 DefaultDim.SETRANGE("Table ID", DATABASE::"FA Template");
        //                 DefaultDim.SETRANGE("No.", "FA Template Code");
        //                 DimMgt.MoveDefaultDimToDefaultDim(DefaultDim, DATABASE::"Fixed Asset", "No.");

        //             end else begin
        //                 "FA Template Code" := xRec."FA Template Code";
        //                 exit;
        //             end;
        //         end;
        //     end;
        // }
        // field(2034883; "Item No. (Service Item)"; Code[20])
        // {
        //     CalcFormula = Lookup("Service Item"."Item No." where("FA No." = FIELD("No.")));
        //     CaptionML = ENU = 'Item No. (First Service Item)',
        //                 FRA = 'N° article (premier article de service)';
        //     Description = 'DITW15.00.00.39 #1258';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     TableRelation = Item;
        // }
        // field(2034892; "Depreciation Starting Date"; Date)
        // {
        //     CaptionML = ENU = 'Depreciation Starting Date',
        //                 FRA = 'Date début amortissement';
        //     Description = 'DITW15.00.00.35';
        //     Editable = true;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 02/09/2009
        //         if "Depreciation Starting Date" <> xRec."Depreciation Starting Date" then
        //             UpdateFADeprBookLines(FIELDCAPTION("Depreciation Starting Date"), CurrFieldNo <> 0);
        //     end;
        // }
        // field(2034893; "Created by Service Item No."; Code[20])
        // {
        //     CaptionML = ENU = 'Created by Service Item No.',
        //                 FRA = 'Créé par N° article de service';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Service Item"."No.";
        // }
        // field(2034894; "Exist Service Items"; Boolean)
        // {
        //     CalcFormula = Exist("Service Item" where("FA No." = FIELD("No.")));
        //     CaptionML = ENU = 'Exist Service Items',
        //                 FRA = 'Existe article(s) de service';
        //     Description = 'DITW15.00.00.35';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     TableRelation = "Service Item"."No.";
        // }
        // field(2034895; "Fixed Asset on Inventory"; Boolean)
        // {
        //     CaptionML = ENU = 'Fixed Asset on Inventory',
        //                 FRA = 'Immo. sur stock';
        //     Description = 'DITW15.00.00.35';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 02/09/2009
        //         if (xRec."Fixed Asset on Inventory" <> "Fixed Asset on Inventory") and
        //           "Fixed Asset on Inventory"
        //         then
        //             PostFABackOnInventory();
        //     end;
        // }
        // field(2034915; "Financial Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Financial Contract No.',
        //                 FRA = 'N° Contrat Financier';
        //     Description = 'DITW16.00.00.41 DIT-715 #327 - DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Financial Contract Header"."Contract No." where("Contract Type" = CONST(Contract));

        //     trigger OnValidate();
        //     var
        //         ContractHeaderDIT: Record "Financial Contract Header";
        //     begin
        //         // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //         if "Financial Contract No." <> '' then begin
        //             ContractHeaderDIT.GET(ContractHeaderDIT."Contract Type"::Contract, "Financial Contract No.");
        //             VALIDATE("Customer No.", ContractHeaderDIT."Customer No.");
        //         end;
        //         CALCFIELDS("DIT Sub-Contract Type");
        //     end;
        // }
        // field(2034955; "Customer No."; Code[20])
        // {
        //     CaptionML = ENU = 'Customer No.',
        //                 FRA = 'N° client';
        //     Description = 'DITW16.00.00.41 DIT-715 #327';
        //     TableRelation = Customer;
        //     ValidateTableRelation = true;

        //     trigger OnValidate();
        //     var
        //         DefaultDim: Record "Default Dimension";
        //         CustDim: Record "Default Dimension";
        //     begin
        //         // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //         CALCFIELDS("Customer Name");
        //         if "Customer No." <> '' then begin
        //             DefaultDim.SETRANGE("Table ID", DATABASE::Customer);
        //             DefaultDim.SETRANGE("No.", "Customer No.");
        //             DimMgt.MoveDefaultDimToDefaultDim(DefaultDim, DATABASE::"Fixed Asset", "No.");
        //         end else begin
        //             //<<DITW114.00.15 EZOG 05/04/2022 NRQ#214426
        //             CustDim.SETRANGE("Table ID", DATABASE::Customer);
        //             CustDim.SETRANGE("No.", xRec."Customer No.");
        //             if CustDim.findset then
        //                 repeat
        //                     DefaultDim.SETRANGE("Table ID", DATABASE::"Fixed Asset");
        //                     DefaultDim.SETRANGE("No.", "No.");
        //                     DefaultDim.SETFILTER("Dimension Code", CustDim."Dimension Code");
        //                     if DefaultDim.FINDFIRST then
        //                         DefaultDim.DELETE;
        //                 until CustDim.NEXT = 0;
        //             DefaultDim.RESET;
        //             //>>DITW114.00.15 EZOG 05/04/2022 NRQ#214426
        //             if "FA Template Code" <> '' then begin
        //                 DefaultDim.SETRANGE("Table ID", DATABASE::"FA Template");
        //                 DefaultDim.SETRANGE("No.", "FA Template Code");
        //                 DimMgt.MoveDefaultDimToDefaultDim(DefaultDim, DATABASE::"Fixed Asset", "No.");
        //             end;
        //         end;
        //     end;
        // }
        // field(2034956; "Customer Name"; Text[50])
        // {
        //     CalcFormula = Lookup(Customer.Name where("No." = FIELD("Customer No.")));
        //     CaptionML = ENU = 'Customer Name',
        //                 FRA = 'Nom client';
        //     Description = 'DITW16.00.00.41 DIT-715 #327';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        //BC Upgrade KAPOOV01-drink-it<<
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LOCKTABLE;
    MainAssetComp.LOCKTABLE;
    InsCoverageLedgEntry.LOCKTABLE;
    IF "Main Asset/Component" = "Main Asset/Component"::"Main Asset" THEN
      ERROR(Text000);
    FAMoveEntries.MoveFAInsuranceEntries("No.");
    FADeprBook.SETRANGE("FA No.","No.");
    FADeprBook.DELETEALL(TRUE);
    IF NOT FADeprBook.ISEMPTY THEN
      ERROR(Text001,TABLECAPTION,"No.");

    MainAssetComp.SETCURRENTKEY("FA No.");
    MainAssetComp.SETRANGE("FA No.","No.");
    MainAssetComp.DELETEALL;
    IF "Main Asset/Component" = "Main Asset/Component"::Component THEN BEGIN
      MainAssetComp.RESET;
      MainAssetComp.SETRANGE("Main Asset No.","Component of Main Asset");
      MainAssetComp.SETRANGE("FA No.",'');
      MainAssetComp.DELETEALL;
      MainAssetComp.SETRANGE("FA No.");
      IF NOT MainAssetComp.FINDFIRST THEN BEGIN
        FA.GET("Component of Main Asset");
        FA."Main Asset/Component" := FA."Main Asset/Component"::" ";
        FA."Component of Main Asset" := '';
        FA.MODIFY;
      end;
    end;

    MaintenanceRegistration.SETRANGE("FA No.","No.");
    MaintenanceRegistration.DELETEALL;
    #31..33
    CommentLine.DELETEALL;

    DimMgt.DeleteDefaultDim(DATABASE::"Fixed Asset","No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    if "Main Asset/Component" = "Main Asset/Component"::"Main Asset" then
    #5..7
    FADeprBook.DELETEALL(true);
    if not FADeprBook.ISEMPTY then
    #10..14
    if "Main Asset/Component" = "Main Asset/Component"::Component then begin
    #16..20
      if not MainAssetComp.FINDFIRST then begin
    #22..25
      end;
    end;
    #28..36
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." = '' THEN BEGIN
      FASetup.GET;
      FASetup.TESTFIELD("Fixed Asset Nos.");
      NoSeriesMgt.InitSeries(FASetup."Fixed Asset Nos.",xRec."No. Series",0D,"No.","No. Series");
    end;

    "Main Asset/Component" := "Main Asset/Component"::" ";
    "Component of Main Asset" := '';

    DimMgt.UpdateDefaultDim(
      DATABASE::"Fixed Asset","No.",
      "Global Dimension 1 Code","Global Dimension 2 Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if "No." = '' then begin
    #2..4
    end;
    #6..9
    // <<DITW15.00.00.35 DDR 31/08/2009
    if "Depreciation Starting Date" = 0D then
      "Depreciation Starting Date" := WORKDATE;
    // >>DITW15.00.00.35 DDR

    #10..12
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=A main asset cannot be deleted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=A main asset cannot be deleted.;FRA=Une immo. principale ne peut être supprimée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot delete %1 %2 because it has associated depreciation books.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot delete %1 %2 because it has associated depreciation books.;FRA=Vous ne pouvez pas supprimer l'enregistrement %1 %2 car il est lié à des lois d'amortissement.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "UnexpctedSubclassErr(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //UnexpctedSubclassErr : ENU=This fixed asset subclass belongs to a different fixed asset class.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UnexpctedSubclassErr : ENU=This fixed asset subclass belongs to a different fixed asset class.;FRA=Cette sous-classe d'immobilisations appartient à une classe d'immobilisations différente.;
    //Variable type has not been exported.

    var
        FADeprBook: Record "FA Depreciation Book";
        FASetup: Record "FA Setup";
        GLSetup: Record "General Ledger Setup";
        HideValidationDialog: Boolean;
        Text2034840: TextConst ENU = 'You cannot change %1 because there are one or more ledger entries (%2) for this fixed asset.', FRA = 'Vous ne pouvez pas modifier %1 car il existe des écritures (%2) associées à cet immobilisation.';
        Text2034841: TextConst ENU = 'Do you want to change %1?', FRA = 'Souhaitez-vous modifier la valeur du champ %1?';
        Text2034842: TextConst ENU = 'You have modified %1.\\', FRA = 'Vous avez modifié le champ %1.\\';
        Text2034843: TextConst ENU = 'Do you want to update the lines?', FRA = 'Souhaitez-vous mettre les lignes à jour ?';
        Text2034844: TextConst ENU = 'Recalculate %1,Recalculate %2', FRA = 'Recalculater %1,Recalculate %2';
}

