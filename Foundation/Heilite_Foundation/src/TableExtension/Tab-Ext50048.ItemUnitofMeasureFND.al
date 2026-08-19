tableextension 50048 ItemUnitofMeasureExtFND extends "Item Unit of Measure"
{
    // version NAVW110.0,IPLXL9.00.001,DITW110.00.08,HEI.02
    // DITW15.00.00.21 DDR 25/06/2008 Change Caption of field41 "Cubage" > Caption "Volume (Cubage)"
    // DITW15.00.00.38 DDR 12/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    2014476 Packaging Type Code
    //                                  Added Table property 'DrillDownFormID'
    // DITW15.00.00.38 DDR 16/02/2011 issue 1217 (DIT711 148)
    //                                  Added fields
    //                                    2014482 Pack Qty. Per Unit of Measure"
    // DITW15.00.00.39 DDR 09/05/2011 issue 1328 Shop (iPos) Functionnalities
    //                                  Added fields
    //                                    2013960 Pos System
    //                                    2013961 Pos System Timestamp
    //                                  Added key "Pos System,Pos System Timestamp"
    //                                  Added functions SomSynchronize()
    //                                  (#1217 DIT711 148) bugfix default "Pack Qty. per Unit of Measure" while new record
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 12/03/2013 DIT-770 #147 : New code Added
    // DITW17.00.02 DDR 10/12/2013 DIT-770 #233 Bugfix (DIT-770 #147) missing rounding "unit volume HL"
    // DITW17.10.05 DDR 28/01/2015 DIT-770 #581 Modified 'DecimalPlaces' of field3 Qty. Per Unit of Measure
    // DITW18.00.07 VSC 18/05/2016 DIT-770 #1972 Merge FINXL EDI Interface

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // IPLXL9.00.001 IMI 15/06/2015: Added fields "EDI Unit of Measure", "Consumer UOM" and "Trade UOM"
    // HEI.01 FDD-OTCGAP064 IBM.NAIKH01 05/07/2017 -One unit of measure to be defined on the SKU level only
    //     # Added new code on the OnInsert() Trigger of the table

    // HEI.02 FDD-GAPID043 IBM LAZARE02 05.07.2017
    //     # New fields: Unit of Dimension, Unit of Weight, Net Weight, Weight into Gross Weight
    //     # Changed caption of field Weight to Gross Weight
    // HotFix001 -  FCE Temp deleted the code to actually be able to work
    // HEI.03 CHG2095242 IBM NANDIS01 20.04.2021 - Unit of Measure conversion Maximo-HeiLite interface
    //   #Field added - Last Update(Field ID - 50003)
    fields
    {
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';

            //Unsupported feature: Change DecimalPlaces on ""Qty. per Unit of Measure"(Field 3)". Please convert manually.

        }
        modify(Length)
        {
            CaptionML = ENU = 'Length', FRA = 'Longueur';
        }
        modify(Width)
        {
            CaptionML = ENU = 'Width', FRA = 'Largeur';
        }
        modify(Height)
        {
            CaptionML = ENU = 'Height', FRA = 'Hauteur';
        }
        modify(Cubage)
        {
            CaptionML = ENU = 'Volume (Cubage)', FRA = 'Cubage';

            //Unsupported feature: Change Description on "Cubage(Field 7303)". Please convert manually.

        }
        modify(Weight)
        {
            CaptionML = ENU = 'Gross Weight', FRA = 'Poids';
        }

        //Unsupported feature: CodeModification on ""Item No."(Field 1).OnValidate". Please convert manually.

        //trigger "(Field 1)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CalcWeight;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CalcWeight;
        // <<DITW15.00.00.39 DDR 09/05/2011 #1328
        Item.GET("Item No.");
        "Pos System" := Item."Pos System";
        // >>DITW15.00.00.39 DDR #1328
        */
        //end;


        //Unsupported feature: CodeInsertion on "Code(Field 2)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.38 DDR 25/08/2010 #1217
        UOM.GET(Code);
        // <<DITW15.00.00.39 DDR 09/05/2011 #1328 (#1217 DIT711 148)
        VALIDATE("Packaging Type Code",UOM."Packaging Type Code");
        // >>DITW15.00.00.39 DDR #1328 (#1217 DIT711 148)
        // >>DITW15.00.00.38 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Qty. per Unit of Measure"(Field 3).OnValidate". Please convert manually.

        //trigger  per Unit of Measure"(Field 3)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Qty. per Unit of Measure" <= 0 THEN
          FIELDERROR("Qty. per Unit of Measure",Text000);
        IF xRec."Qty. per Unit of Measure" <> "Qty. per Unit of Measure" THEN
          CheckNoEntriesWithUoM;
        Item.GET("Item No.");
        IF Item."Base Unit of Measure" = Code THEN
          TESTFIELD("Qty. per Unit of Measure",1);
        CalcWeight;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Qty. per Unit of Measure" <= 0 then
          FIELDERROR("Qty. per Unit of Measure",Text000);
        if xRec."Qty. per Unit of Measure" <> "Qty. per Unit of Measure" then
          CheckNoEntriesWithUoM;
        Item.GET("Item No.");
        if Item."Base Unit of Measure" = Code then
          TESTFIELD("Qty. per Unit of Measure",1);
        CalcWeight;
        //<<DITW17.00.02 SR 12/03/2013 DIT-770 #147
        RecItem.GET("Item No.");
        if RecItem."Volume Unit of Measure Code" <> '' then
         begin
          if RecItem."Volume Unit of Measure Code" = Code then
           begin
            // <<DITW17.00.02 DDR 10/12/2013 DIT-770 #233
            RecItem."Unit Volume HL" := ROUND(1 / "Qty. per Unit of Measure",0.00001);
            // >>DITW17.00.02 DDR DIT-770 #233
            RecItem.MODIFY;
           end;
         end;
        //<<DITW17.00.02 SR DIT-770 #147
        */
        //end;
        field(50000; "Unit of Dimension FND"; Code[20])
        {
            Caption = 'Unit of Dimension';
            Description = 'HEI.02';
            TableRelation = "Unit of Measure";
        }
        field(50001; "Unit of Weight FND"; Code[20])
        {
            Caption = 'Unit of Weight';
            Description = 'HEI.02';
            TableRelation = "Unit of Measure";
        }
        field(50002; "Net Weight FND"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
            MinValue = 0;
        }
        field(50003; "Last Update FND"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Caption = 'Last Update';
        }
        // field(2013960; "Pos System"; Option)
        // {
        //     CaptionML = ENU = 'POS System',
        //                 FRA = 'Système POS';
        //     Description = 'DITW15.00.00.39 #1328';
        //     OptionCaptionML = ENU = ' ,Yes,Blocked',
        //                       FRA = ' ,Oui,Bloqué';
        //     OptionMembers = " ",Yes,No;

        //     trigger OnValidate();
        //     begin
        //         if "Pos System" <> "Pos System"::" " then begin
        //             Item.GET("Item No.");
        //             Item.TESTFIELD("Pos System");
        //         end else
        //             CLEAR("Pos System Timestamp")
        //     end;
        // }
        // field(2013961; "Pos System Timestamp"; DateTime)
        // {
        //     CaptionML = ENU = 'POS System Timestamp',
        //                 FRA = 'Horodateur système POS';
        //     Description = 'DITW15.00.00.39 #1328';
        // }
        // field(2014476; "Packaging Type Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Packaging Type Code',
        //                 FRA = 'Code Type de Conditionnement';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Packaging Type";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
        //         if "Packaging Type Code" <> '' then
        //             "Pack Qty. per Unit of Measure" := 1
        //         else
        //             "Pack Qty. per Unit of Measure" := 0;
        //     end;
        // }
        // field(2014482; "Pack Qty. per Unit of Measure"; Decimal)
        // {
        //     CaptionML = ENU = 'Packaging Qty. per Unit of Measure',
        //                 FRA = 'Quantité conditionnement par unité';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.38 #1217 (DIT711 148)';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
        //         TESTFIELD("Packaging Type Code");
        //         if "Pack Qty. per Unit of Measure" <= 0 then
        //             FIELDERROR("Pack Qty. per Unit of Measure", Text000);
        //     end;
        // }
        // field(2030010; "EDI Unit of Measure"; Boolean)
        // {
        //     CaptionML = ENU = 'EDI Unit of Measure',
        //                 FRA = 'Unité de mesure EDI';
        //     Description = 'IPLXL9.00.001';
        // }
        // field(2030011; "Consumer UOM"; Boolean)
        // {
        //     CaptionML = ENU = 'Consumer UOM',
        //                 FRA = 'Unité de mesure Consommateur';
        //     Description = 'IPLXL9.00.001';
        // }
        // field(2030012; "Trade UOM"; Boolean)
        // {
        //     CaptionML = ENU = 'Trade UOM',
        //                 FRA = 'Unité de mesure Commerce';
        //     Description = 'IPLXL9.00.001';
        // }  // BC Upgrade NANDIS03
    }
    keys
    {
        // key(Key1; "Pos System", "Pos System Timestamp")
        // {
        // }  // BC Upgrade NANDIS03
    }


    //Unsupported feature: CodeInsertion on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //begin
    /*

    //<< HEI.01 NAIKH01
    // HotFix001 -- HeinekenGlobal.CheckUOM("Item No.",Code,0);
    //>> HEI.01 NAIKH01
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
    if "Packaging Type Code" <> '' then begin
      if (xRec."Packaging Type Code" <> "Packaging Type Code") and
        ("Pack Qty. per Unit of Measure" = 0)
      then
        "Pack Qty. per Unit of Measure" := 1;
    end else
      "Pack Qty. per Unit of Measure" := 0;
    // >>DITW15.00.00.38 DDR #1217 (DIT711 14)
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=must be greater than 0;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=must be greater than 0;FRA=doit être supérieur(e) à 0;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot rename %1 %2 for item %3 because it is the item's %4 and there are one or more open ledger entries for the item.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot rename %1 %2 for item %3 because it is the item's %4 and there are one or more open ledger entries for the item.;FRA=Vous ne pouvez pas renommer l'enregistrement %1 %2 de l'article %3 car il s'agit du %4 de l'article et il existe une ou plusieurs écritures comptables ouvertes pour cet article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CannotModifyBaseUnitOfMeasureErr(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CannotModifyBaseUnitOfMeasureErr : @@@=%1 Table name (Item Unit of measure), %2 Value of Measure (KG, PCS...), %3 Item ID, %4 Base unit of Measure;ENU=You cannot modify %1 %2 for item %3 because it is the item's %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CannotModifyBaseUnitOfMeasureErr : @@@=%1 Table name (Item Unit of measure), %2 Value of Measure (KG, PCS...), %3 Item ID, %4 Base unit of Measure;ENU=You cannot modify %1 %2 for item %3 because it is the item's %4.;FRA=Vous ne pouvez pas modifier %1 %2 de l'article %3, car il s'agit du %4 de l'article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CannotModifyUnitOfMeasureErr(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CannotModifyUnitOfMeasureErr : @@@=%1 Table name (Item Unit of measure), %2 Value of Measure (KG, PCS...), %3 Item ID, %4 Entry Table Name, %5 Field Caption;ENU=You cannot modify %1 %2 for item %3 because non-zero %5 with %2 exists in %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CannotModifyUnitOfMeasureErr : @@@=%1 Table name (Item Unit of measure), %2 Value of Measure (KG, PCS...), %3 Item ID, %4 Entry Table Name, %5 Field Caption;ENU=You cannot modify %1 %2 for item %3 because non-zero %5 with %2 exists in %4.;FRA=Vous ne pouvez pas modifier %1 %2 de l'article %3, car %5 non nul avec %2 existe dans %4.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CannotModifyUOMWithWhseEntriesErr(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CannotModifyUOMWithWhseEntriesErr : @@@="%1 = Item Unit of Measure %2 = Code %3 = Item No.";ENU=You cannot modify %1 %2 for item %3 because there are one or more warehouse adjustment entries for the item.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CannotModifyUOMWithWhseEntriesErr : @@@="%1 = Item Unit of Measure %2 = Code %3 = Item No.";ENU=You cannot modify %1 %2 for item %3 because there are one or more warehouse adjustment entries for the item.;FRA=Vous ne pouvez pas modifier %1 %2 pour l'article %3 car il existe une ou plusieurs écritures ajustement entrepôt pour cet article.;
    //Variable type has not been exported.

    var
        TEXT002: Label 'You cannot create more than one unit of measure for item No. %1';

    var
        //PosChangeLogMgt: Codeunit "Pos Change Log Management";  // BC Upgrade NANDIS03
        RecItem: Record Item;
        ItemUOM: Record "Item Unit of Measure";
        UOM: Record "Unit of Measure";
        HeinekenGlobal: Codeunit "Heineken Global";
}

