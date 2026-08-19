tableextension 50089 ItemAnalysisViewExtFND extends "Item Analysis View"
{
    // version NAVW110.0
    // HEI.01 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Added fileds "LineExt.Dim Code incl.in BRAND", "Line Extension Dimension Code" to table
    // HEI.02 Defect #1328 #1329 IBM NASTAA02 19.12.2017 # Missing fields in file creation
    //   # Added new fields: 50002- Include Market Type
    //                       50003- Include Addit. Cust. Dim.1
    //                       50004- Add. Cust. Dim.1 Code
    //                       50005- Include Addit. Cust. Dim.2
    //                       50006- Add. Cust. Dim.2 Code
    //                       50007- Include Product Type
    //                       50008- Include Product Type R1
    //   # Added new field 50010 - "Product Type Dimension Code"
    // HEI.03 FDD-HB1425 BULIMC01 IBM 03.06.2020 #new fields created:
    //     #50011 - "Shortcut 1 Code"
    //     #50012 - "Shortcut 2 Code"
    //     #code added to "ModifyDim" function
    fields
    {
        modify("Analysis Area")
        {
            CaptionML = ENU = 'Analysis Area', FRA = 'Zone d''analyse';
            //OptionCaptionML = ENU = 'Sales,Purchase,Inventory', FRA = 'Ventes,Achats,Stocks';
        }
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Last Entry No.")
        {
            CaptionML = ENU = 'Last Entry No.', FRA = 'Dernier n° séquence';
        }
        modify("Last Budget Entry No.")
        {
            CaptionML = ENU = 'Last Budget Entry No.', FRA = 'Dernier n° séquence budget';
        }
        modify("Last Date Updated")
        {
            CaptionML = ENU = 'Last Date Updated', FRA = 'Date dernière mise à jour';
        }
        modify("Update on Posting")
        {
            CaptionML = ENU = 'Update on Posting', FRA = 'Mise à jour à la validation';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
        }
        modify("Item Filter")
        {
            CaptionML = ENU = 'Item Filter', FRA = 'Filtre article';
        }
        modify("Location Filter")
        {
            CaptionML = ENU = 'Location Filter', FRA = 'Filtre magasin';
        }
        modify("Starting Date")
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
        }
        modify("Date Compression")
        {
            CaptionML = ENU = 'Date Compression', FRA = 'Compression de données';
            OptionCaptionML = ENU = 'None,Day,Week,Month,Quarter,Year,Period', FRA = 'Aucune,Jour,Semaine,Mois,Trimestre,Année,Période';
        }
        modify("Dimension 1 Code")
        {
            CaptionML = ENU = 'Dimension 1 Code', FRA = 'Code axe 1';
        }
        modify("Dimension 2 Code")
        {
            CaptionML = ENU = 'Dimension 2 Code', FRA = 'Code axe 2';
        }
        modify("Dimension 3 Code")
        {
            CaptionML = ENU = 'Dimension 3 Code', FRA = 'Code axe 3';
        }
        modify("Include Budgets")
        {
            CaptionML = ENU = 'Include Budgets', FRA = 'Inclure budgets';
        }
        modify("Refresh When Unblocked")
        {
            CaptionML = ENU = 'Refresh When Unblocked', FRA = 'Rafraîchi quand débloqué';
        }

        //Unsupported feature: CodeModification on "Blocked(Field 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT Blocked AND "Refresh When Unblocked" THEN BEGIN
          ValidateDelete(FIELDCAPTION(Blocked));
          ItemAnalysisViewReset;
          "Refresh When Unblocked" := FALSE;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not Blocked and "Refresh When Unblocked" then begin
          ValidateDelete(FIELDCAPTION(Blocked));
          ItemAnalysisViewReset;
          "Refresh When Unblocked" := false;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Item Filter"(Field 9).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Blocked,FALSE);
        IF ("Last Entry No." <> 0) AND (xRec."Item Filter" = '') AND ("Item Filter" <> '') THEN BEGIN
          ValidateModify(FIELDCAPTION("Item Filter"));
          Item.SETFILTER("No.","Item Filter");
          IF Item.FIND('-') THEN
            REPEAT
              Item.MARK := TRUE;
            UNTIL Item.NEXT = 0;
          Item.SETRANGE("No.");
          IF Item.FIND('-') THEN
            REPEAT
              IF NOT Item.MARK THEN BEGIN
                ItemAnalysisViewEntry.SETRANGE("Analysis Area","Analysis Area");
                ItemAnalysisViewEntry.SETRANGE("Analysis View Code",Code);
                ItemAnalysisViewEntry.SETRANGE("Item No.",Item."No.");
                ItemAnalysisViewEntry.DELETEALL;
                ItemAnalysisViewBudgetEntry.SETRANGE("Analysis Area","Analysis Area");
                ItemAnalysisViewBudgetEntry.SETRANGE("Analysis View Code",Code);
                ItemAnalysisViewBudgetEntry.SETRANGE("Item No.",Item."No.");
                ItemAnalysisViewBudgetEntry.DELETEALL;
              end;
            UNTIL Item.NEXT = 0;
        end;
        IF ("Last Entry No." <> 0) AND ("Item Filter" <> xRec."Item Filter") AND (xRec."Item Filter" <> '') THEN BEGIN
          ValidateDelete(FIELDCAPTION("Item Filter"));
          ItemAnalysisViewReset;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Blocked,false);
        if ("Last Entry No." <> 0) and (xRec."Item Filter" = '') and ("Item Filter" <> '') then begin
          ValidateModify(FIELDCAPTION("Item Filter"));
          Item.SETFILTER("No.","Item Filter");
          if Item.FIND('-') then
            repeat
              Item.MARK := true;
            until Item.NEXT = 0;
          Item.SETRANGE("No.");
          if Item.FIND('-') then
            repeat
              if not Item.MARK then begin
        #13..20
              end;
            until Item.NEXT = 0;
        end;
        if ("Last Entry No." <> 0) and ("Item Filter" <> xRec."Item Filter") and (xRec."Item Filter" <> '') then begin
          ValidateDelete(FIELDCAPTION("Item Filter"));
          ItemAnalysisViewReset;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Filter"(Field 10).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Blocked,FALSE);
        IF ("Last Entry No." <> 0) AND (xRec."Location Filter" = '') AND
           ("Location Filter" <> xRec."Location Filter")
        THEN BEGIN
          ValidateModify(FIELDCAPTION("Location Filter"));
          IF Location.FIND('-') THEN
            REPEAT
              TempLocation := Location;
              TempLocation.INSERT;
            UNTIL Location.NEXT = 0;
          TempLocation.INIT;
          TempLocation.Code := '';
          TempLocation.INSERT;
          TempLocation.SETFILTER(Code,"Location Filter");
          TempLocation.DELETEALL;
          TempLocation.SETRANGE(Code);
          IF TempLocation.FIND('-') THEN
            REPEAT
              ItemAnalysisViewEntry.SETRANGE("Analysis Area","Analysis Area");
              ItemAnalysisViewEntry.SETRANGE("Analysis View Code",Code);
              ItemAnalysisViewEntry.SETRANGE("Location Code",TempLocation.Code);
              ItemAnalysisViewEntry.DELETEALL;
              ItemAnalysisViewBudgetEntry.SETRANGE("Analysis Area","Analysis Area");
              ItemAnalysisViewBudgetEntry.SETRANGE("Analysis View Code",Code);
              ItemAnalysisViewBudgetEntry.SETRANGE("Location Code",TempLocation.Code);
              ItemAnalysisViewBudgetEntry.DELETEALL;
            UNTIL TempLocation.NEXT = 0
        end;
        IF ("Last Entry No." <> 0) AND (xRec."Location Filter" <> '') AND
           ("Location Filter" <> xRec."Location Filter")
        THEN BEGIN
          ValidateDelete(FIELDCAPTION("Location Filter"));
          ItemAnalysisViewReset;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Blocked,false);
        if ("Last Entry No." <> 0) and (xRec."Location Filter" = '') and
           ("Location Filter" <> xRec."Location Filter")
        then begin
          ValidateModify(FIELDCAPTION("Location Filter"));
          if Location.FIND('-') then
            repeat
              TempLocation := Location;
              TempLocation.INSERT;
            until Location.NEXT = 0;
        #11..16
          if TempLocation.FIND('-') then
            repeat
        #19..26
            until TempLocation.NEXT = 0
        end;
        if ("Last Entry No." <> 0) and (xRec."Location Filter" <> '') and
           ("Location Filter" <> xRec."Location Filter")
        then begin
          ValidateDelete(FIELDCAPTION("Location Filter"));
          ItemAnalysisViewReset;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Starting Date"(Field 11).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Blocked,FALSE);
        IF ("Last Entry No." <> 0) AND ("Starting Date" <> xRec."Starting Date") THEN BEGIN
          ValidateDelete(FIELDCAPTION("Starting Date"));
          ItemAnalysisViewReset;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Blocked,false);
        if ("Last Entry No." <> 0) and ("Starting Date" <> xRec."Starting Date") then begin
          ValidateDelete(FIELDCAPTION("Starting Date"));
          ItemAnalysisViewReset;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Date Compression"(Field 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Blocked,FALSE);
        IF ("Last Entry No." <> 0) AND ("Date Compression" <> xRec."Date Compression") THEN BEGIN
          ValidateDelete(FIELDCAPTION("Date Compression"));
          ItemAnalysisViewReset;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Blocked,false);
        if ("Last Entry No." <> 0) and ("Date Compression" <> xRec."Date Compression") then begin
          ValidateDelete(FIELDCAPTION("Date Compression"));
          ItemAnalysisViewReset;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Dimension 1 Code"(Field 13).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Blocked,FALSE);
        IF Dim.CheckIfDimUsed("Dimension 1 Code",20,'',Code,"Analysis Area") THEN
          ERROR(Text000,Dim.GetCheckDimErr);
        ModifyDim(FIELDCAPTION("Dimension 1 Code"),"Dimension 1 Code",xRec."Dimension 1 Code");
        MODIFY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Blocked,false);
        if Dim.CheckIfDimUsed("Dimension 1 Code",20,'',Code,"Analysis Area") then
        #3..5
        */
        //end;


        //Unsupported feature: CodeModification on ""Dimension 2 Code"(Field 14).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Blocked,FALSE);
        IF Dim.CheckIfDimUsed("Dimension 2 Code",21,'',Code,"Analysis Area") THEN
          ERROR(Text000,Dim.GetCheckDimErr);
        ModifyDim(FIELDCAPTION("Dimension 2 Code"),"Dimension 2 Code",xRec."Dimension 2 Code");
        MODIFY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Blocked,false);
        if Dim.CheckIfDimUsed("Dimension 2 Code",21,'',Code,"Analysis Area") then
        #3..5
        */
        //end;


        //Unsupported feature: CodeModification on ""Dimension 3 Code"(Field 15).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Blocked,FALSE);
        IF Dim.CheckIfDimUsed("Dimension 3 Code",22,'',Code,"Analysis Area") THEN
          ERROR(Text000,Dim.GetCheckDimErr);
        ModifyDim(FIELDCAPTION("Dimension 3 Code"),"Dimension 3 Code",xRec."Dimension 3 Code");
        MODIFY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Blocked,false);
        if Dim.CheckIfDimUsed("Dimension 3 Code",22,'',Code,"Analysis Area") then
        #3..5
        */
        //end;


        //Unsupported feature: CodeModification on ""Include Budgets"(Field 17).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Blocked,FALSE);
        IF ("Last Entry No." <> 0) AND xRec."Include Budgets" AND NOT "Include Budgets" THEN BEGIN
          ValidateDelete(FIELDCAPTION("Include Budgets"));
          AnalysisviewBudgetReset;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Blocked,false);
        if ("Last Entry No." <> 0) and xRec."Include Budgets" and not "Include Budgets" then begin
          ValidateDelete(FIELDCAPTION("Include Budgets"));
          AnalysisviewBudgetReset;
        end;
        */
        //end;
        field(50000; "LineExt.DimCodIncl.inBRAND FND"; Boolean)
        {
            Description = 'HEI.01';
            Caption = ' Line Extension Dimensson Code Incl. in BRAND';

            trigger OnValidate();
            begin
                if "LineExt.DimCodIncl.inBRAND FND" then
                    "Line Ext. Dimension Code FND" := '';
            end;
        }
        field(50001; "Line Ext. Dimension Code FND"; Code[20])
        {
            CaptionML = ENU = 'Line Extension Dimension Code',
                        FRA = 'Line Extension Dimension Code';
            Description = 'HEI.01';
            TableRelation = Dimension;

            trigger OnValidate();
            begin
                TESTFIELD(Blocked, false);
                //<<HNK 100019 MRA-IBM 26/01/16
                if "Line Ext. Dimension Code FND" <> '' then
                    if "LineExt.DimCodIncl.inBRAND FND" then
                        ERROR(Text018, FIELDCAPTION("LineExt.DimCodIncl.inBRAND FND"));
                //>>HNK 100019 MRA-IBM 26/01/16
                if Dim.CheckIfDimUsed("Dimension 1 Code", 20, '', Code, "Analysis Area".AsInteger()) then
                    ERROR(Text000, Dim.GetCheckDimErr());
                //ModifyDim(FIELDCAPTION("Line Extension Dimension Code"), "Line Extension Dimension Code", xRec."Line Extension Dimension Code");  // BC Upgrade NANDIS03
                MODIFY();
            end;
        }
        field(50002; "Include Market Type FND"; Boolean)
        {
            Description = 'HEI.02';
            Caption = 'Include Market Type';
        }
        field(50003; "Include Addit. Cust. Dim.1 FND"; Boolean)
        {
            Description = 'HEI.02';
            Caption = 'Include Additional Customer Dimension 1';

            trigger OnValidate();
            begin
                if not "Include Addit. Cust. Dim.1 FND" then
                    "Add. Cust. Dim.1 Code FND" := '';
            end;
        }
        field(50004; "Add. Cust. Dim.1 Code FND"; Code[20])
        {
            Description = 'HEI.02';
            Caption = 'Additional Customer Dimension 1 Code';

            trigger OnValidate();
            begin
                if not "Include Addit. Cust. Dim.1 FND"
                  then
                    TESTFIELD("Add. Cust. Dim.1 Code FND", '');
            end;
        }
        field(50005; "Include Addit. Cust. Dim.2 FND"; Boolean)
        {
            Description = 'HEI.02';
            Caption = 'Include Additional Customer Dimension 2';

            trigger OnValidate();
            begin
                if not "Include Product Type R1 FND" then begin
                    "Add. Cust. Dim.2 Code FND" := '';
                    "Use Alt. Country Customer FND" := false;
                end;
            end;
        }
        field(50006; "Add. Cust. Dim.2 Code FND"; Code[20])
        {
            Description = 'HEI.02';
            Caption = 'Additional Customer Dimension 2 Code';

            trigger OnValidate();
            begin
                if not "Include Product Type R1 FND"
                  then
                    TESTFIELD("Add. Cust. Dim.2 Code FND", '');
            end;
        }
        field(50007; "Include Product Type FND"; Boolean)
        {
            Description = 'HEI.02';
            Caption = 'Include Product Type';
        }
        field(50008; "Include Product Type R1 FND"; Boolean)
        {
            Description = 'HEI.02';
            Caption = 'Include Product Type R1';
        }
        field(50009; "Use Alt. Country Customer FND"; Boolean)
        {
            CaptionML = ENU = 'Use Customer Country Code',
                        FRA = 'Utiliser Code pays client';
            Description = 'HEI.02';

            trigger OnValidate();
            begin
                TESTFIELD("Include Product Type R1 FND");
                if "Use Alt. Country Customer FND" then
                    "Add. Cust. Dim.2 Code FND" := '';
            end;
        }
        field(50010; "Product Type Dimen. Code FND"; Code[20])
        {
            Caption = 'Product Type Dimension Code';
            Description = 'HEI.02';
            TableRelation = Dimension;

            trigger OnValidate();
            begin
                //HEI.02>>
                if (xRec."Product Type Dimen. Code FND" <> "Product Type Dimen. Code FND")
                   and ("Product Type Dimen. Code FND" <> '')
                then
                    "Include Product Type FND" := false;
                //HEI.02<<
            end;
        }
        field(50011; "Shortcut 1 Code FND"; Code[20])
        {
            Caption = 'Shortcut 1 Code';
            Description = 'HEI.03';
            TableRelation = Dimension;

            trigger OnValidate();
            begin
                //HEI.03>>
                TESTFIELD(Blocked, false);
                if Dim.CheckIfDimUsed("Shortcut 1 Code FND", 23, '', Code, "Analysis Area".AsInteger()) then
                    ERROR(Text000, Dim.GetCheckDimErr());
                //ModifyDim(FIELDCAPTION("Shortcut 1 Code"), "Shortcut 1 Code", xRec."Shortcut 1 Code");  // BC Upgrade NANDIS03
                MODIFY();
                //HEI.03<<
            end;
        }
        field(50012; "Shortcut 2 Code FND"; Code[20])
        {
            Caption = 'Shortcut 2 Code';
            Description = 'HEI.03';
            TableRelation = Dimension;

            trigger OnValidate();
            begin
                //HEI.03>>
                TESTFIELD(Blocked, false);
                if Dim.CheckIfDimUsed("Shortcut 2 Code FND", 24, '', Code, "Analysis Area".AsInteger()) then
                    ERROR(Text000, Dim.GetCheckDimErr());
                //ModifyDim(FIELDCAPTION("Shortcut 2 Code"), "Shortcut 2 Code", xRec."Shortcut 2 Code");  // BC Upgrade NANDIS03
                MODIFY();
                //HEI.03<<
            end;
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=%1\You cannot use the same dimension twice in the same analysis view.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=%1\You cannot use the same dimension twice in the same analysis view.;FRA=%1\Vous ne pouvez pas utiliser deux fois le même axe analytique dans la même vue d'analyse.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=The dimension %1 is used in the analysis view %2 %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=The dimension %1 is used in the analysis view %2 %3.;FRA=L'axe analytique %1 est utilisé dans la vue d'analyse %2 %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=" You must therefore retain the dimension to keep consistency between the analysis view and the Item entries.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=" You must therefore retain the dimension to keep consistency between the analysis view and the Item entries.";FRA=" Vous devez donc conserver l'axe analytique pour préserver la cohérence entre la vue d'analyse et les écritures article.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=All analysis views must be updated with the latest Item entries and Item budget entries.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=All analysis views must be updated with the latest Item entries and Item budget entries.;FRA=Toutes les vues d'analyse doivent être mises à jour avec les dernières écritures article et budget article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=" Both blocked and unblocked analysis views must be updated.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=" Both blocked and unblocked analysis views must be updated.";FRA=" Les vues d'analyse bloquées et non bloquées doivent être mises a jour.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=" Note, you must remove the checkmark in the blocked field before updating the blocked analysis views.\";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=" Note, you must remove the checkmark in the blocked field before updating the blocked analysis views.\";FRA=" Attention, vous devez désactiver le champ Bloqué avant de mettre à jour les vues d'analyse bloquées.\";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=Currently, %1 analysis views are not updated.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=Currently, %1 analysis views are not updated.;FRA=%1 vues d'analyse ne sont actuellement pas à jour.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=" Do you wish to update these analysis views?";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=" Do you wish to update these analysis views?";FRA=" Souhaitez-vous mettre à jour ces vues d'analyse ?";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text010(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : ENU=All analysis views must be updated with the latest Item entries.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : ENU=All analysis views must be updated with the latest Item entries.;FRA=Toutes les vues d'analyse doivent être mises à jour avec les dernières écritures article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text011(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=If you change the contents of the %1 field, the analysis view entries will be deleted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=If you change the contents of the %1 field, the analysis view entries will be deleted.;FRA=Si vous modifiez le contenu du champ %1, les écritures vue d'analyse seront supprimées.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text012(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU=\You will have to update again.\\Do you want to enter a new value in the %1 field?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : ENU=\You will have to update again.\\Do you want to enter a new value in the %1 field?;FRA=\Vous allez devoir faire une nouvelle mise à jour.\\Souhaitez-vous entrer une nouvelle valeur dans le champ %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text013(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text013 : ENU=The update has been interrupted in response to the warning.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text013 : ENU=The update has been interrupted in response to the warning.;FRA=La mise à jour a été interrompue pour respecter l'alerte.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text014(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : ENU=If you change the contents of the %1 field, the analysis view entries will be changed as well.\\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : ENU=If you change the contents of the %1 field, the analysis view entries will be changed as well.\\;FRA=Si vous modifiez le contenu du champ %1, les écritures vue d'analyse seront également modifiées.\\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text015(Variable 1015)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text015 : ENU=Do you want to enter a new value in the %1 field?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text015 : ENU=Do you want to enter a new value in the %1 field?;FRA=Souhaitez-vous entrer une nouvelle valeur dans le champ %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text017(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text017 : ENU=When you enable %1, you need to update the analysis view. Do you want to update the analysis view now?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text017 : ENU=When you enable %1, you need to update the analysis view. Do you want to update the analysis view now?;FRA=Si vous activez %1, vous devez mettre à jour la vue d'analyse. Voulez-vous mettre à jour la vue d'analyse maintenant ?;
    //Variable type has not been exported.

    var
        Dim: Record Dimension;  // BC Upgrade NANDIS03
        Text018: Label 'A Line Extension Dimension Code can only be used if this code is not indicated as included in the Brand dimension (see field %1)';
        Text000: TextConst ENU = '%1\You cannot use the same dimension twice in the same analysis view.';
}

