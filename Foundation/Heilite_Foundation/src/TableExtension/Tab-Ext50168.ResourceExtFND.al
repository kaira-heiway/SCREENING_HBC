tableextension 50168 ResourceExtFND extends Resource
{
    // version NAVW110.0.00.15601,FINXL10.00,DITW110.00.09
    // DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 Plant Maintenance Functionnalitty
    //                                             Added fields
    //                                               2034955 Customer No.
    //                     18/09/2012 DIT-715 #434 Added fields
    //                                               2034967 Planning Only
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW18.00.06 BCE 12/08/2015 DIT-770 #1535 Added table filter Plant Maintenance Plant=CONST(Yes) for field Customer No.
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties
    // DITW19.00.08 SFI 18/08/2016 BL#10868  (DIT-770 #2141) New field 2014411 "Allow Invoice Disc."
    //                                                       New function "SetupNewRec"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // HEI.01 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New fields for MDM integration
    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            //OptionCaptionML = ENU = 'Person,Machine', FRA = 'Homme,Machine';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Search Name")
        {
            CaptionML = ENU = 'Search Name', FRA = 'Nom de recherche';
        }
        modify("Name 2")
        {
            CaptionML = ENU = 'Name 2', FRA = 'Nom 2';
        }
        modify(Address)
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
        }
        modify("Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
        }
        modify(City)
        {

            //Unsupported feature: Change TableRelation on "City(Field 8)". Please convert manually.

            CaptionML = ENU = 'City', FRA = 'Ville';
        }
        modify("Social Security No.")
        {
            CaptionML = ENU = 'Social Security No.', FRA = 'N° sécurité sociale';
        }
        modify("Job Title")
        {
            CaptionML = ENU = 'Job Title', FRA = 'Fonction';
        }
        modify(Education)
        {
            CaptionML = ENU = 'Education', FRA = 'Formation/Qualification';
        }
        modify("Contract Class")
        {
            CaptionML = ENU = 'Contract Class', FRA = 'Type contrat';
        }
        modify("Employment Date")
        {
            CaptionML = ENU = 'Employment Date', FRA = 'Date d''entrée';
        }
        modify("Resource Group No.")
        {
            CaptionML = ENU = 'Resource Group No.', FRA = 'N° groupe ressources';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 16)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Base Unit of Measure")
        {
            CaptionML = ENU = 'Base Unit of Measure', FRA = 'Unité de base';
        }
        modify("Direct Unit Cost")
        {
            CaptionML = ENU = 'Direct Unit Cost', FRA = 'Coût unitaire direct';
        }
        modify("Indirect Cost %")
        {
            CaptionML = ENU = 'Indirect Cost %', FRA = '% coût indirect';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';
        }
        modify("Profit %")
        {
            CaptionML = ENU = 'Profit %', FRA = '% marge sur vente';
        }
        modify("Price/Profit Calculation")
        {
            CaptionML = ENU = 'Price/Profit Calculation', FRA = 'Calcul prix ou marge';
            OptionCaptionML = ENU = 'Profit=Price-Cost,Price=Cost+Profit,No Relationship', FRA = 'Marge=Prix-Coût,Prix=Coût+Marge,Sans relation';
        }
        modify("Unit Price")
        {
            CaptionML = ENU = 'Unit Price', FRA = 'Prix unitaire';
        }
        modify("Vendor No.")
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 27)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Unit of Measure Filter")
        {
            CaptionML = ENU = 'Unit of Measure Filter', FRA = 'Filtre unité';
        }
        modify(Capacity)
        {

            //Unsupported feature: Change CalcFormula on "Capacity(Field 41)". Please convert manually.

            CaptionML = ENU = 'Capacity', FRA = 'Capacité';
        }
        modify("Qty. on Order (Job)")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Order (Job)"(Field 42)". Please convert manually.

            CaptionML = ENU = 'Qty. on Order (Job)', FRA = 'Qté commandée (projet)';
        }
        modify("Qty. Quoted (Job)")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. Quoted (Job)"(Field 43)". Please convert manually.

            CaptionML = ENU = 'Qty. Quoted (Job)', FRA = 'Qté en devis (projet)';
        }
        modify("Usage (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Usage (Qty.)"(Field 44)". Please convert manually.

            CaptionML = ENU = 'Usage (Qty.)', FRA = 'Activité (qté)';
        }
        modify("Usage (Cost)")
        {

            //Unsupported feature: Change CalcFormula on ""Usage (Cost)"(Field 45)". Please convert manually.

            CaptionML = ENU = 'Usage (Cost)', FRA = 'Activité (coût)';
        }
        modify("Usage (Price)")
        {

            //Unsupported feature: Change CalcFormula on ""Usage (Price)"(Field 46)". Please convert manually.

            CaptionML = ENU = 'Usage (Price)', FRA = 'Activité (prix)';
        }
        modify("Sales (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Sales (Qty.)"(Field 47)". Please convert manually.

            CaptionML = ENU = 'Sales (Qty.)', FRA = 'Ventes (qté)';
        }
        modify("Sales (Cost)")
        {

            //Unsupported feature: Change CalcFormula on ""Sales (Cost)"(Field 48)". Please convert manually.

            CaptionML = ENU = 'Sales (Cost)', FRA = 'Ventes (coût)';
        }
        modify("Sales (Price)")
        {

            //Unsupported feature: Change CalcFormula on ""Sales (Price)"(Field 49)". Please convert manually.

            CaptionML = ENU = 'Sales (Price)', FRA = 'Ventes (prix)';
        }
        modify("Chargeable Filter")
        {
            CaptionML = ENU = 'Chargeable Filter', FRA = 'Filtre facturable';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        // modify(Picture)
        // {
        //     CaptionML = ENU = 'Picture', FRA = 'illustration';
        // }  // BC Upgrade ADHIKG01
        modify("Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Post Code"(Field 53)". Please convert manually.

            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify(County)
        {
            CaptionML = ENU = 'County', FRA = 'Région';
        }
        modify("Automatic Ext. Texts")
        {
            CaptionML = ENU = 'Automatic Ext. Texts', FRA = 'Textes étendus automatiques';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Tax Group Code")
        {
            CaptionML = ENU = 'Tax Group Code', FRA = 'Code groupe taxes';
        }
        modify("VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'VAT Prod. Posting Group', FRA = 'Groupe compta. produit TVA';
        }
        modify("Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Country/Region Code"(Field 59)". Please convert manually.

            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify("IC Partner Purch. G/L Acc. No.")
        {
            CaptionML = ENU = 'IC Partner Purch. G/L Acc. No.', FRA = 'N° cte gén achat parten IC';
        }
        modify(Image)
        {
            CaptionML = ENU = 'Image', FRA = 'Image';
        }
        modify("Qty. on Assembly Order")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Assembly Order"(Field 900)". Please convert manually.

            CaptionML = ENU = 'Qty. on Assembly Order', FRA = 'Qté sur ordre d''assemblage';
        }
        modify("Use Time Sheet")
        {
            CaptionML = ENU = 'Use Time Sheet', FRA = 'Utiliser la feuille de temps';
        }
        modify("Time Sheet Owner User ID")
        {
            CaptionML = ENU = 'Time Sheet Owner User ID', FRA = 'Code utilisateur du propriétaire de la feuille de temps';
        }
        modify("Time Sheet Approver User ID")
        {
            CaptionML = ENU = 'Time Sheet Approver User ID', FRA = 'Code utilisateur de l''approbateur de la feuille de temps';
        }
        modify("Default Deferral Template Code")
        {
            CaptionML = ENU = 'Default Deferral Template Code', FRA = 'Code modèle échelonnement par défaut';
        }
        modify("Qty. on Service Order")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Service Order"(Field 5900)". Please convert manually.

            CaptionML = ENU = 'Qty. on Service Order', FRA = 'Qté sur commande service';
        }
        modify("Service Zone Filter")
        {
            CaptionML = ENU = 'Service Zone Filter', FRA = 'Filtre zone service';
        }
        modify("In Customer Zone")
        {

            //Unsupported feature: Change CalcFormula on ""In Customer Zone"(Field 5902)". Please convert manually.

            CaptionML = ENU = 'In Customer Zone', FRA = 'En zone client';
        }

        //Unsupported feature: CodeModification on ""No."(Field 1).OnValidate". Please convert manually.

        //trigger "(Field 1)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." <> xRec."No." THEN BEGIN
          ResSetup.GET;
          NoSeriesMgt.TestManual(ResSetup."Resource Nos.");
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


        //Unsupported feature: CodeModification on "Name(Field 3).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Search Name" = UPPERCASE(xRec.Name)) OR ("Search Name" = '') THEN
          "Search Name" := Name;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Search Name" = UPPERCASE(xRec.Name)) or ("Search Name" = '') then
          "Search Name" := Name;
        */
        //end;


        //Unsupported feature: CodeModification on "City(Field 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Resource Group No."(Field 14).OnValidate". Please convert manually.

        //trigger "(Field 14)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Resource Group No." = xRec."Resource Group No." THEN
          EXIT;

        IF xRec."Resource Group No." <> '' THEN
          IF NOT
             CONFIRM(
               Text001,FALSE,
               FIELDCAPTION("Resource Group No."))
          THEN BEGIN
            "Resource Group No." := xRec."Resource Group No.";
            EXIT;
          end;

        IF xRec.GETFILTER("Resource Group No.") <> '' THEN
          SETFILTER("Resource Group No.","Resource Group No.");

        // Resource Capacity Entries
        ResCapacityEntry.SETCURRENTKEY("Resource No.");
        ResCapacityEntry.SETRANGE("Resource No.","No.");
        ResCapacityEntry.MODIFYALL("Resource Group No.","Resource Group No.");

        PlanningLine.SETCURRENTKEY(Type,"No.");
        PlanningLine.SETRANGE(Type,PlanningLine.Type::Resource);
        PlanningLine.SETRANGE("No.","No.");
        PlanningLine.SETRANGE("Schedule Line",TRUE);
        PlanningLine.MODIFYALL("Resource Group No.","Resource Group No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Resource Group No." = xRec."Resource Group No." then
          exit;

        if xRec."Resource Group No." <> '' then
          if not
             CONFIRM(
               Text001,false,
               FIELDCAPTION("Resource Group No."))
          then begin
            "Resource Group No." := xRec."Resource Group No.";
            exit;
          end;

        if xRec.GETFILTER("Resource Group No.") <> '' then
        #15..24
        PlanningLine.SETRANGE("Schedule Line",true);
        PlanningLine.MODIFYALL("Resource Group No.","Resource Group No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Base Unit of Measure"(Field 18).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Base Unit of Measure" <> xRec."Base Unit of Measure" THEN BEGIN
          TestNoEntriesExist(FIELDCAPTION("Base Unit of Measure"));

          IF "Base Unit of Measure" <> '' THEN BEGIN
            UnitOfMeasure.GET("Base Unit of Measure");
            IF NOT ResUnitOfMeasure.GET("No.","Base Unit of Measure") THEN BEGIN
              ResUnitOfMeasure.INIT;
              ResUnitOfMeasure.VALIDATE("Resource No.","No.");
              ResUnitOfMeasure.VALIDATE(Code,"Base Unit of Measure");
              ResUnitOfMeasure."Qty. per Unit of Measure" := 1;
              ResUnitOfMeasure.INSERT;
            end else BEGIN
              IF ResUnitOfMeasure."Qty. per Unit of Measure" <> 1 THEN
                ERROR(STRSUBSTNO(BaseUnitOfMeasureQtyMustBeOneErr,"Base Unit of Measure",ResUnitOfMeasure."Qty. per Unit of Measure"));
              ResUnitOfMeasure.TESTFIELD("Related to Base Unit of Meas.");
            end;
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Base Unit of Measure" <> xRec."Base Unit of Measure" then begin
          TestNoEntriesExist(FIELDCAPTION("Base Unit of Measure"));

          if "Base Unit of Measure" <> '' then begin
            UnitOfMeasure.GET("Base Unit of Measure");
            if not ResUnitOfMeasure.GET("No.","Base Unit of Measure") then begin
        #7..11
            end else begin
              if ResUnitOfMeasure."Qty. per Unit of Measure" <> 1 then
                ERROR(STRSUBSTNO(BaseUnitOfMeasureQtyMustBeOneErr,"Base Unit of Measure",ResUnitOfMeasure."Qty. per Unit of Measure"));
              ResUnitOfMeasure.TESTFIELD("Related to Base Unit of Meas.");
            end;
          end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Price/Profit Calculation"(Field 23).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CASE "Price/Profit Calculation" OF
          "Price/Profit Calculation"::"Profit=Price-Cost":
            IF "Unit Price" <> 0 THEN
              "Profit %" := ROUND(100 * (1 - "Unit Cost" / "Unit Price"),0.00001)
            else
              "Profit %" := 0;
          "Price/Profit Calculation"::"Price=Cost+Profit":
            IF "Profit %" < 100 THEN
              "Unit Price" := ROUND("Unit Cost" / (1 - "Profit %" / 100),0.00001);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        case "Price/Profit Calculation" of
          "Price/Profit Calculation"::"Profit=Price-Cost":
            if "Unit Price" <> 0 then
              "Profit %" := ROUND(100 * (1 - "Unit Cost" / "Unit Price"),0.00001)
            else
              "Profit %" := 0;
          "Price/Profit Calculation"::"Price=Cost+Profit":
            if "Profit %" < 100 then
              "Unit Price" := ROUND("Unit Cost" / (1 - "Profit %" / 100),0.00001);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Prod. Posting Group"(Field 51).OnValidate". Please convert manually.

        //trigger  Prod();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" THEN
          IF GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") THEN
            VALIDATE("VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
          if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") then
            VALIDATE("VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
        */
        //end;


        //Unsupported feature: CodeModification on ""Post Code"(Field 53).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Use Time Sheet"(Field 950).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Use Time Sheet" <> xRec."Use Time Sheet" THEN
          IF ExistUnprocessedTimeSheets THEN
            ERROR(Text005,FIELDCAPTION("Use Time Sheet"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Use Time Sheet" <> xRec."Use Time Sheet" then
          if ExistUnprocessedTimeSheets then
            ERROR(Text005,FIELDCAPTION("Use Time Sheet"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Time Sheet Owner User ID"(Field 951).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Time Sheet Owner User ID" <> xRec."Time Sheet Owner User ID" THEN BEGIN
          IF ExistUnprocessedTimeSheets THEN
            ERROR(Text005,FIELDCAPTION("Time Sheet Owner User ID"));

          IF (Type = Type::Person) AND ("Time Sheet Owner User ID" <> '') THEN
            TimeSheetMgt.CheckResourceTimeSheetOwner("Time Sheet Owner User ID","No.");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Time Sheet Owner User ID" <> xRec."Time Sheet Owner User ID" then begin
          if ExistUnprocessedTimeSheets then
            ERROR(Text005,FIELDCAPTION("Time Sheet Owner User ID"));

          if (Type = Type::Person) and ("Time Sheet Owner User ID" <> '') then
            TimeSheetMgt.CheckResourceTimeSheetOwner("Time Sheet Owner User ID","No.");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Time Sheet Approver User ID"(Field 952).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Time Sheet Approver User ID" <> xRec."Time Sheet Approver User ID" THEN
          IF ExistUnprocessedTimeSheets THEN
            ERROR(Text005,FIELDCAPTION("Time Sheet Approver User ID"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Time Sheet Approver User ID" <> xRec."Time Sheet Approver User ID" then
          if ExistUnprocessedTimeSheets then
            ERROR(Text005,FIELDCAPTION("Time Sheet Approver User ID"));
        */
        //end;
        field(50000; "WHT Product Posting Group FND"; Code[10])
        {
            Caption = 'WHT Product Posting Group';
            Description = 'HEI.01';
            TableRelation = "WHT Product Posting Group FND".Code;
        }
        // field(2014411; "Allow Invoice Disc."; Boolean)
        // {
        //     CaptionML = ENU = 'Allow Invoice Disc.',
        //                 FRA = 'Autoriser remise ligne';
        //     Description = 'DITW19.00.08 BL#10868';
        // }
        // field(2029610; "Shortcut Property 1 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,1/156';
        //     CaptionML = ENU = 'Shortcut Property 1 Code',
        //                 FRA = 'Code raccourci propriété 1';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(156),
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
        //     CaptionClass = '2029610,2,2/156';
        //     CaptionML = ENU = 'Shortcut Property 2 Code',
        //                 FRA = 'Code raccourci propriété 2';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(156),
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
        //     CaptionClass = '2029610,2,3/156';
        //     CaptionML = ENU = 'Shortcut Property 3 Code',
        //                 FRA = 'Code raccourci propriété 3';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(156),
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
        //     CaptionClass = '2029610,2,4/156';
        //     CaptionML = ENU = 'Shortcut Property 4 Code',
        //                 FRA = 'Code raccourci propriété 4';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(156),
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
        //     CaptionClass = '2029610,2,5/156';
        //     CaptionML = ENU = 'Shortcut Property 5 Code',
        //                 FRA = 'Code raccourci propriété 5';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(156),
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
        //     CaptionClass = '2029610,2,6/156';
        //     CaptionML = ENU = 'Shortcut Property 6 Code',
        //                 FRA = 'Code raccourci propriété 6';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(156),
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
        //     CaptionClass = '2029610,2,7/156';
        //     CaptionML = ENU = 'Shortcut Property 7 Code',
        //                 FRA = 'Code raccourci propriété 7';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(156),
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
        //     CaptionClass = '2029610,2,8/156';
        //     CaptionML = ENU = 'Shortcut Property 8 Code',
        //                 FRA = 'Code raccourci propriété 8';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(156),
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
        //     CaptionClass = '2029610,2,9/156';
        //     CaptionML = ENU = 'Shortcut Property 9 Code',
        //                 FRA = 'Code raccourci propriété 9';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(156),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(9));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 9 Code" := fctValidateShortcutPropertyCode(9, "Shortcut Property 9 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029619; "Shortcut Property 10 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,10/156';
        //     CaptionML = ENU = 'Shortcut Property 10 Code',
        //                 FRA = 'Code raccourci propriété 10';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(156),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(10));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 10 Code" := fctValidateShortcutPropertyCode(10, "Shortcut Property 10 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2034955; "Customer No."; Code[20])
        // {
        //     CaptionML = ENU = 'Plant No.',
        //                 FRA = 'N° usine';
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        //     TableRelation = Customer where("Plant Maintenance Caption" = CONST(true),
        //                                     "Plant Maintenance Plant" = CONST(true));
        //     ValidateTableRelation = true;

        //     trigger OnValidate();
        //     begin
        //         CALCFIELDS("Customer Name");
        //     end;
        // }
        // field(2034956; "Customer Name"; Text[50])
        // {
        //     CalcFormula = Lookup(Customer.Name where("No." = FIELD("Customer No.")));
        //     CaptionML = ENU = 'Plant Name',
        //                 FRA = 'Nom usine';
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2034967; "Planning Only"; Boolean)
        // {
        //     CaptionML = ENU = 'Planning Only',
        //                 FRA = 'Uniquement sur Planning';
        //     Description = 'DITW16.00.00.41 DIT-715 #434';
        // }  // BC Upgrade ADHIKG01
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CheckJobPlanningLine;

    MoveEntries.MoveResEntries(Rec);
    #4..19

    ExtTextHeader.SETRANGE("Table Name",ExtTextHeader."Table Name"::Resource);
    ExtTextHeader.SETRANGE("No.","No.");
    ExtTextHeader.DELETEALL(TRUE);

    ResSkill.RESET;
    ResSkill.SETRANGE(Type,ResSkill.Type::Resource);
    #27..42
    SalesOrderLine.SETCURRENTKEY(Type,"No.");
    SalesOrderLine.SETRANGE(Type,SalesOrderLine.Type::Resource);
    SalesOrderLine.SETRANGE("No.","No.");
    IF SalesOrderLine.FINDFIRST THEN
      ERROR(SalesDocumentExistsErr,"No.",SalesOrderLine."Document Type");

    IF ExistUnprocessedTimeSheets THEN
      ERROR(Text006,TABLECAPTION,"No.");

    DimMgt.DeleteDefaultDim(DATABASE::Resource,"No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..22
    ExtTextHeader.DELETEALL(true);
    #24..45
    if SalesOrderLine.FINDFIRST then
      ERROR(SalesDocumentExistsErr,"No.",SalesOrderLine."Document Type");

    if ExistUnprocessedTimeSheets then
    #50..52
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." = '' THEN BEGIN
      ResSetup.GET;
      ResSetup.TESTFIELD("Resource Nos.");
      NoSeriesMgt.InitSeries(ResSetup."Resource Nos.",xRec."No. Series",0D,"No.","No. Series");
    end;

    IF GETFILTER("Resource Group No.") <> '' THEN
      IF GETRANGEMIN("Resource Group No.") = GETRANGEMAX("Resource Group No.") THEN
        VALIDATE("Resource Group No.",GETRANGEMIN("Resource Group No."));

    DimMgt.UpdateDefaultDim(
      DATABASE::Resource,"No.",
      "Global Dimension 1 Code","Global Dimension 2 Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if "No." = '' then begin
    #2..4
    end;

    if GETFILTER("Resource Group No.") <> '' then
      if GETRANGEMIN("Resource Group No.") = GETRANGEMAX("Resource Group No.") then
    #9..13
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Do you want to change %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Do you want to change %1?;FRA=Souhaitez-vous modifier la valeur du champ %1?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You cannot change %1 because there are ledger entries for this resource.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You cannot change %1 because there are ledger entries for this resource.;FRA=Vous ne pouvez pas modifier l'enregistrement %1 car il existe des écritures comptables pour cette ressource.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1022)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.;FRA=Avant de pouvoir utiliser Online Map, vous devez compléter la fenêtre Configuration Online Map.\Consultez la section Configuration d'Online Map dans l'Aide.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1024)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=%1 cannot be changed since unprocessed time sheet lines exist for this resource.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=%1 cannot be changed since unprocessed time sheet lines exist for this resource.;FRA=Impossible de modifier %1 étant donné qu'il existe des lignes feuille de temps non traitées pour cette ressource.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1025)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : @@@=You cannot delete Resource LIFT since unprocessed time sheet lines exist for this resource.;ENU=You cannot delete %1 %2 because unprocessed time sheet lines exist for this resource.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : @@@=You cannot delete Resource LIFT since unprocessed time sheet lines exist for this resource.;ENU=You cannot delete %1 %2 because unprocessed time sheet lines exist for this resource.;FRA=Vous ne pouvez pas supprimer %1 %2 car il existe des lignes feuille de temps non traitées pour cette ressource.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "BaseUnitOfMeasureQtyMustBeOneErr(Variable 1026)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //BaseUnitOfMeasureQtyMustBeOneErr : @@@="%1 Name of Unit of measure (e.g. BOX, PCS, KG...), %2 Qty. of %1 per base unit of measure ";ENU=The quantity per base unit of measure must be 1. %1 is set up with %2 per unit of measure.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BaseUnitOfMeasureQtyMustBeOneErr : @@@="%1 Name of Unit of measure (e.g. BOX, PCS, KG...), %2 Qty. of %1 per base unit of measure ";ENU=The quantity per base unit of measure must be 1. %1 is set up with %2 per unit of measure.;FRA=La quantité par unité de base doit être de 1. %1 est paramétré avec %2 par unité.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CannotDeleteResourceErr(Variable 1027)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CannotDeleteResourceErr : @@@="%1 = Resource No.";ENU=You cannot delete resource %1 because it is used in one or more job planning lines.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CannotDeleteResourceErr : @@@="%1 = Resource No.";ENU=You cannot delete resource %1 because it is used in one or more job planning lines.;FRA=Vous ne pouvez pas supprimer la ressource %1 car elle est utilisée dans une ou plusieurs lignes planning projet.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SalesDocumentExistsErr(Variable 1028)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SalesDocumentExistsErr : @@@="%1 = Resource No.";ENU=You cannot delete resource %1 because there are one or more outstanding %2 that include this resource.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SalesDocumentExistsErr : @@@="%1 = Resource No.";ENU=You cannot delete resource %1 because there are one or more outstanding %2 that include this resource.;FRA=Vous ne pouvez pas supprimer la ressource %1 car il existe au moins un %2 ouvert qui inclut cette ressource.;
    //Variable type has not been exported.

    var
        GLSetup: Record "General Ledger Setup";
}

