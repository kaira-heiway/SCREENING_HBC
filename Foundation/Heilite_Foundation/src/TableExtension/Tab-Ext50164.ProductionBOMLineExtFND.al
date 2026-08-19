tableextension 50164 ProductionBOMLineExtFND extends "Production BOM Line"
{
    // version NAVW110.0,FINXL8.00.001,MANXL9.00.001,DITW110.00.12A,HEI.01

    //     HEI.01 FDD-GAPID031 IBM.PATHAA02 17.08.2017
    //   # Description made non-Editable
    // HEI.02 FDD-CHG2003754 IBM.ISYED01 03.19.2019
    //   # Added fileds Zone code and Bin code to the table.
    // HEI.03 FDD-CHG2003754 IBM.MATHEJ01 07.23.2019
    //   # Added Validation.
    // HEI.04 Defect 4550 IBM.GUNERE01 09.10.2019 # GetManufacturingSetup func. added, TestRepeatItem func. modified.
    //                                 14.10.2019 # commented lines
    // HEI.05 FDD-CHG2136735 IBM.PATHAA02 07.02.2022
    // # Code on Zone Code-Onlookup
    // # Prefiltered Zone Code based on Linked SKU for all versions
    //****************************************************************************
    //HEI.06 FDD-DTW002 11.03.26 #Production jnl. flushing field added to Production BOM Line table as part of BC Upgrade.
    //Field ->(DIT-F2035266-->50002)-"Production jnl. flushing" added

    fields
    {
        modify("Production BOM No.")
        {
            CaptionML = ENU = 'Production BOM No.', FRA = 'N° nomenclature production';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Version Code")
        {
            CaptionML = ENU = 'Version Code', FRA = 'Code version';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            //OptionCaptionML = ENU = ' ,Item,Production BOM', FRA = ' ,Article,Nomenclature';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
            //editable = false;

            //Unsupported feature: Change Description on "Description(Field 12)". Please convert manually.


            //Unsupported feature: Change Editable on "Description(Field 12)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify(Position)
        {
            CaptionML = ENU = 'Position', FRA = 'Position';
        }
        modify("Position 2")
        {
            CaptionML = ENU = 'Position 2', FRA = 'Position 2';
        }
        modify("Position 3")
        {
            CaptionML = ENU = 'Position 3', FRA = 'Position 3';
        }
        modify("Lead-Time Offset")
        {
            CaptionML = ENU = 'Lead-Time Offset', FRA = 'Décalage du délai';
        }
        modify("Routing Link Code")
        {
            CaptionML = ENU = 'Routing Link Code', FRA = 'Code lien gamme';
        }
        modify("Scrap %")
        {
            CaptionML = ENU = 'Scrap %', FRA = '% perte';
        }
        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Starting Date")
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
        }
        modify("Ending Date")
        {
            CaptionML = ENU = 'Ending Date', FRA = 'Date fin';
        }
        modify(Length)
        {
            CaptionML = ENU = 'Length', FRA = 'Longueur';
        }
        modify(Width)
        {
            CaptionML = ENU = 'Width', FRA = 'Largeur';
        }
        modify(Weight)
        {
            CaptionML = ENU = 'Weight', FRA = 'Poids';
        }
        modify(Depth)
        {
            CaptionML = ENU = 'Depth', FRA = 'Profondeur';
        }
        modify("Calculation Formula")
        {
            CaptionML = ENU = 'Calculation Formula', FRA = 'Formule de calcul';
            //OptionCaptionML = ENU = ' ,Length,Length * Width,Length * Width * Depth,Weight', FRA = ' ,Longueur,Longueur * largeur,Longueur * largeur * profondeur,Poids';
        }
        modify("Quantity per")
        {
            CaptionML = ENU = 'Quantity per', FRA = 'Quantité par';
        }

        //Unsupported feature: CodeModification on ""No."(Field 11).OnValidate". Please convert manually.

        //trigger "(Field 11)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type);

        TestStatus;
        #4..10
              "Unit of Measure Code" := Item."Base Unit of Measure";
              if "No." <> xRec."No." then
                "Variant Code" := '';
            end;
          Type::"Production BOM":
            begin
        #17..19
              "Unit of Measure Code" := ProdBOMHeader."Unit of Measure Code";
            end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..13
              //<<FINXL8.00.001 BSA 02/06/2015 #178
              if recFinXLSetup.READPERMISSION then begin
                fctGetCrossReference;
                "Item Production BOM No." := Item."Production BOM No."; //MANXL9.00.001 DAT 28/12/2015
              end;
              //>>FINXL8.00.001 BSA 02/06/2015 #178
              // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
              "Special Component" := TestSpecialStatus;
              // >>DITW15.00.00.22 PRODW14.00.00.08 DDR
        #14..22
        */
        //end;
        field(50000; "Zone Code FND"; Code[10])
        {
            CaptionML = ENU = 'Zone Code',
                        FRA = 'Code zone';
            Description = 'HEI.02';
            Editable = true;
            TableRelation = Zone.Code;

            trigger OnLookup();
            var
                Zone: Record Zone;
                zonelist: Page "Zone List";
            begin
                //HEI.05<<
                if "Production BOM No." <> '' then begin
                    if ProductionBOMHeaderRec.GET(Rec."Production BOM No.") then
                        SKULocation := ProductionBOMHeaderRec."Linked SKU FND";

                    Zone.RESET();
                    Zone.SETCURRENTKEY("Location Code");
                    Zone.FILTERGROUP(50);
                    Zone.SETFILTER("Location Code", SKULocation);

                    zonelist.SETTABLEVIEW(Zone);
                    zonelist.LOOKUPMODE := true;

                    if zonelist.RUNMODAL() = ACTION::LookupOK then begin
                        "Zone Code FND" := zonelist.GetSelectionFilter();
                    end;
                    CLEAR(zonelist);
                    Zone.FILTERGROUP(0);
                end;
                //HEI.05>>
            end;

            trigger OnValidate();
            var
                Zone: Record Zone;
                zonelist: Page "Zone List";
            begin
                Zone.RESET();
                Zone.SETCURRENTKEY(Code);
                if Zone.GET("Zone Code FND") then
                    Locationfilter := Zone."Location Code";
            end;
        }
        field(50001; "Bin Code FND"; Code[20])
        {
            CaptionML = ENU = 'Bin Code',
                        FRA = 'Code emplacement';
            Description = 'HEI.02';
            TableRelation = Bin.Code;

            trigger OnLookup();
            var
                Zone: Record Zone;
                BinList: Page "Bin List";
            begin
                Bin.RESET();
                Bin.SETFILTER(Bin."Zone Code", "Zone Code FND");
                //Bin.SETFILTER(Bin."Location Code",Zone."Location Code");

                BinList.SETTABLEVIEW(Bin);

                BinList.LOOKUPMODE := true;
                if BinList.RUNMODAL() = ACTION::LookupOK then begin
                    BINCODEFilter := BinList.GetSelectionFilter();
                    "Bin Code FND" := DELCHR(BINCODEFilter, '=', Text);
                end;
                CLEAR(BinList);
            end;

            trigger OnValidate();
            var
                Zone: Record Zone;
            begin
            end;
        }
        field(50002; "Production jnl. flushing FND"; Boolean)
        {
            Caption = 'Production jnl. flushing';
            Description = 'HEI.06';
        }
        /* //BCUpgrade YADAVM09 Drink it fields commented>>
        field(2029610;"Cross-Reference No.";Code[20])
        {
            CaptionML = ENU='Cross-Reference No.',
                        FRA='Référence externe';
            Description = 'FINXL8.00.001';

            trigger OnLookup();
            begin
                //<<FINXL8.00.001 BSA 02/06/2015 #178
                fctLookupCrossReference();
                //>>FINXL8.00.001 BSA 02/06/2015 #178
            end;

            trigger OnValidate();
            begin
                //<<FINXL8.00.001 BSA 02/06/2015 #178
                fctValidateCrossReference;
                //>>FINXL8.00.001 BSA 02/06/2015 #178
            end;
        }
        field(2035176;"Show on Prod. Order";Boolean)
        {
            CaptionML = ENU='Show on Prod. Order',
                        FRA='Afficher sur Ordre de production';
            Description = 'Description=DITW15.00.00.22 PRODW14.00.00.08';
        }
        field(2035260;"Principal Component";Boolean)
        {
            CaptionML = ENU='Principal Component',
                        FRA='Composant principal';
            Description = 'Description=DITW15.00.00.22 PRODW14.00.00.08';

            trigger OnValidate();
            begin
                if Type <> Type::" " then
                  TestStatus;

                if "Principal Component" then begin
                  ProdBOMLine.RESET;
                  ProdBOMLine.SETRANGE("Production BOM No.","Production BOM No.");
                  ProdBOMLine.SETFILTER("Line No.",'<>%1',"Line No.");
                  ProdBOMLine.SETRANGE("Principal Component",true);
                  if ProdBOMLine.FIND('-') then begin
                    ProdBOMLine."Principal Component" := false;
                    ProdBOMLine.MODIFY;
                  end;
                end;

                "Special Component" := TestSpecialStatus;
            end;
        }
        field(2035263;"Special Component";Boolean)
        {
            CaptionML = ENU='Special Component',
                        FRA='Composant spécial';
            Description = 'Description=DITW15.00.00.22 PRODW14.00.00.08';
        }
        field(2035266;"Production jnl. flushing";Boolean)
        {
            Caption = 'Production jnl. flushing';
            Description = 'DITW110.00.12A HBA 07/06/2018 NRQ#51782';
        }
        field(2036301;"Show BOM Line";Boolean)
        {
            CaptionML = ENU='Show BOM Line',
                        FRA='Afficher ligne nomenclature';
            Description = 'MANXL7.00.001';
        }
        field(2036302;"BOM Level";Integer)
        {
            CaptionML = ENU='BOM Level',
                        FRA='Niveau nomenclature';
            Description = 'MANXL7.00.001';
        }
        field(2036303;"Expand BOM Level";Boolean)
        {
            CaptionML = ENU='Expand BOM Level',
                        FRA='Eclater niveau nomenclature';
            Description = 'MANXL7.00.001';

            trigger OnValidate();
            begin
                //<<MANXL7.00.001 DAT 24/02/2014 #1
                blnSuspendStatusCheck := true;
                //>>MANXL7.00.001 DAT 24/02/2014 #1
            end;
        }
        field(2036304;"Show BOLD";Boolean)
        {
            CaptionML = ENU='Show BOLD',
                        FRA='Afficher en gras';
            Description = 'MANXL7.00.001';
        }
        field(2036305;"BOM Quantity";Decimal)
        {
            CaptionML = ENU='BOM Quantity',
                        FRA='Quantité nomenclature';
            Description = 'MANXL7.00.001';
        }
        field(2036306;"Description 2";Text[50])
        {
            CaptionML = ENU='Description',
                        FRA='Désignation';
            Description = 'MANXL7.00.001';
        }
        field(2036307;"Description 3";Text[50])
        {
            CaptionML = ENU='Description',
                        FRA='Désignation';
            Description = 'MANXL7.00.001';
        }
        field(2036308;"Vendor No.";Code[20])
        {
            CaptionML = ENU='Vendor',
                        FRA='Fournisseur';
            Description = 'MANXL7.00.001';
            TableRelation = Vendor;

            trigger OnValidate();
            var
            Item  Item;
            begin
                //<<MANXL7.00.001 DAT 24/02/2014 #1
                if Item.GET("No.") then begin
                  Item."Vendor No." := "Description 3";
                  Item.MODIFY(true);
                end;
                //>>MANXL7.00.001 DAT 24/02/2014 #1
            end;
        }
        field(2036309;"Location Code";Code[10])
        {
            CaptionML = ENU='Location Code',
                        FRA='Code magasin';
            Description = 'MANXL7.00.001';
            TableRelation = Location;
        }
        field(2036310;"Product Group Code";Code[10])
        {
            CalcFormula = Lookup(Item."Product Group Code" WHERE ("No."=FIELD("No.")));
            CaptionML = ENU='Product Group Code',
                        FRA='Code groupe produits';
            Description = 'MANXL7.00.001';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2036311;"Item Production BOM No.";Code[20])
        {
            CaptionML = ENU='Item Production BOM No.',
                        FRA='N° nomenclature de production  article';
            Description = 'MANXL7.00.001';
        }
        field(2036312;"Item Routing No.";Code[20])
        {
            CaptionML = ENU='Item Routing No.',
                        FRA='N°gamme article';
            Description = 'MANXL7.00.001';
        }
        field(2036313;Critical;Boolean)
        {
            CaptionML = ENU='Critical',
                        FRA='Critique';
            Description = 'MANXL7.00.001';
        }
         */ //BCUpgrade YADAVM09 Drink it fields commented>>
    }
    keys
    {
        /*BcUpgrade YADAVM09 KEY alreeady in base>>
        //key(Key1; "Production BOM No.", "Line No.")
       // {
       // }
       *///BcUpgrade YADAVM09 KEY alreeady in base>>
    }


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatus;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TestStatus;
    //HEI.03>>
    //TestRepeatItem;//HEI.04
    //HEI.03<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Type <> Type::" " then
      TestStatus;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if Type <> Type::" " then
      TestStatus;
    //HEI.03>>
    //TestRepeatItem;//HEI.04
    //HEI.03<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=%1 must be later than %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=%1 must be later than %2.;FRA=%1 doit être postérieur(e) à %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "BOMVersionUOMErr(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //BOMVersionUOMErr : @@@="%1=UOM Code;%2=Item No.;%3=Production BOM No.;%4=Version Code";ENU="The Unit of Measure Code %1 for Item %2 does not exist. Identification fields and values: Production BOM No. = %3, Version Code = %4.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BOMVersionUOMErr : @@@="%1=UOM Code;%2=Item No.;%3=Production BOM No.;%4=Version Code";ENU="The Unit of Measure Code %1 for Item %2 does not exist. Identification fields and values: Production BOM No. = %3, Version Code = %4.";FRA="Le Code unité %1 de l'article %2 n'existe pas. Valeurs et champs d'identification : N° nomenclature production = %3, Code version = %4.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "BOMHeaderUOMErr(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //BOMHeaderUOMErr : @@@="%1=UOM Code;%2=Item No.;%3=Production BOM No.";ENU="The Unit of Measure Code %1 for Item %2 does not exist. Identification fields and values: Production BOM No. = %3.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BOMHeaderUOMErr : @@@="%1=UOM Code;%2=Item No.;%3=Production BOM No.";ENU="The Unit of Measure Code %1 for Item %2 does not exist. Identification fields and values: Production BOM No. = %3.";FRA="Le Code unité %1 de l'article %2 n'existe pas. Valeurs et champs d'identification : N° nomenclature production = %3.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "BOMLineUOMErr(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //BOMLineUOMErr : @@@="%1=UOM Code;%2=Item No.;%3=Production BOM No.;%4=Version Code;%5=Line No.";ENU="The Unit of Measure Code %1 for Item %2 does not exist. Identification fields and values: Production BOM No. = %3, Version Code = %4, Line No. = %5.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BOMLineUOMErr : @@@="%1=UOM Code;%2=Item No.;%3=Production BOM No.;%4=Version Code;%5=Line No.";ENU="The Unit of Measure Code %1 for Item %2 does not exist. Identification fields and values: Production BOM No. = %3, Version Code = %4, Line No. = %5.";FRA="Le Code unité %1 de l'article %2 n'existe pas. Valeurs et champs d'identification : N° nomenclature production = %3, Code version = %4, N° ligne = %5.";
    //Variable type has not been exported.

    var
        // recFinXLSetup: Record "Finance XL Setup";//BcUpgrade YADAVM09 Object not used anywhere in the code
        Bin: Record Bin;
        ItemAttributeValue: Record "Item Attribute Value";
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        ProductionBOMHeaderRec: Record "Production BOM Header";
        ProdBOMLine: Record "Production BOM Line";
        RoutingVersion: Record "Routing Version";
        blnSuspendStatusCheck: Boolean;
        blnValidateCrossRef: Boolean;
        SKULocation: Code[10];
        BINCODEFilter: Code[20];
        Locationfilter: Code[20];
        BOMLineRepeatItemErr: Label 'The Item No %1 already exists in BOM';
        Text: Label '''';
}

