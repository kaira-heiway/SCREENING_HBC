tableextension 50075 FADepriciationBookExtFND extends "FA Depreciation Book"
{
    // HEI.01 FDD-HT584 IBM NASTAA02 02.09.2019 # La Reunion FA Derogatory Depreciation
    //   # New Fields created: 10800 - Derogatory
    //                         10801 - Last Derogatory Date
    // HEI.02 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Code added
    // version NAVW110.0,DITW110.00.08

    //Bc Upgrade YADAVM09 Drink it field commented - Derogatory,Last Derogatory Date.
    fields
    {
        modify("FA No.")
        {
            CaptionML = ENU = 'FA No.', FRA = 'N° immo.';
        }
        modify("Depreciation Book Code")
        {
            CaptionML = ENU = 'Depreciation Book Code', FRA = 'Code loi d''amortissement';
        }
        modify("Depreciation Method")
        {
            CaptionML = ENU = 'Depreciation Method', FRA = 'Méthode amortissement';
            //OptionCaptionML = ENU = 'Straight-Line,Declining-Balance 1,Declining-Balance 2,DB1/SL,DB2/SL,User-Defined,Manual', FRA = 'Linéaire,Dégressif 1,Dégressif 2,Dégr. 1/Lin.,Dégr. 2/Lin.,Paramétrable,Manuelle';
        }
        modify("Depreciation Starting Date")
        {
            CaptionML = ENU = 'Depreciation Starting Date', FRA = 'Date début amortissement';
        }
        modify("Straight-Line %")
        {
            CaptionML = ENU = 'Straight-Line %', FRA = '% linéaire';
        }
        modify("No. of Depreciation Years")
        {
            CaptionML = ENU = 'No. of Depreciation Years', FRA = 'Nombre années amortissement';
        }
        modify("No. of Depreciation Months")
        {
            CaptionML = ENU = 'No. of Depreciation Months', FRA = 'Nombre mois amortissement';
        }
        modify("Fixed Depr. Amount")
        {
            CaptionML = ENU = 'Fixed Depr. Amount', FRA = 'Montant annuité amortissement';
        }
        modify("Declining-Balance %")
        {
            CaptionML = ENU = 'Declining-Balance %', FRA = '% dégressif';
        }
        modify("Depreciation Table Code")
        {
            CaptionML = ENU = 'Depreciation Table Code', FRA = 'Code table amortissement';
        }
        modify("Final Rounding Amount")
        {
            CaptionML = ENU = 'Final Rounding Amount', FRA = 'Montant arrondi final';
        }
        modify("Ending Book Value")
        {
            CaptionML = ENU = 'Ending Book Value', FRA = 'Valeur comptable finale';
        }
        modify("FA Posting Group")
        {
            CaptionML = ENU = 'FA Posting Group', FRA = 'Groupe compta. immo.';
        }
        modify("Depreciation Ending Date")
        {
            CaptionML = ENU = 'Depreciation Ending Date', FRA = 'Date fin amortissement';
        }
        modify("Acquisition Cost")
        {

            //Unsupported feature: Change CalcFormula on ""Acquisition Cost"(Field 15)". Please convert manually.

            CaptionML = ENU = 'Acquisition Cost', FRA = 'Coût acquisition';
        }
        modify(Depreciation)
        {

            //Unsupported feature: Change CalcFormula on "Depreciation(Field 16)". Please convert manually.

            CaptionML = ENU = 'Depreciation', FRA = 'Amortissement';
        }
        modify("Book Value")
        {

            //Unsupported feature: Change CalcFormula on ""Book Value"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Book Value', FRA = 'Valeur comptable';
        }
        modify("Proceeds on Disposal")
        {

            //Unsupported feature: Change CalcFormula on ""Proceeds on Disposal"(Field 18)". Please convert manually.

            CaptionML = ENU = 'Proceeds on Disposal', FRA = 'Produit de cession';
        }
        modify("Gain/Loss")
        {

            //Unsupported feature: Change CalcFormula on ""Gain/Loss"(Field 19)". Please convert manually.

            CaptionML = ENU = 'Gain/Loss', FRA = 'Gain/Perte';
        }
        modify("Write-Down")
        {

            //Unsupported feature: Change CalcFormula on ""Write-Down"(Field 20)". Please convert manually.

            CaptionML = ENU = 'Write-Down', FRA = 'Dépréciation';
        }
        modify(Appreciation)
        {

            //Unsupported feature: Change CalcFormula on "Appreciation(Field 21)". Please convert manually.

            CaptionML = ENU = 'Appreciation', FRA = 'Réévaluation';
        }
        modify("Custom 1")
        {

            //Unsupported feature: Change CalcFormula on ""Custom 1"(Field 22)". Please convert manually.

            CaptionML = ENU = 'Custom 1', FRA = 'Param. 1';
        }
        modify("Custom 2")
        {

            //Unsupported feature: Change CalcFormula on ""Custom 2"(Field 23)". Please convert manually.

            CaptionML = ENU = 'Custom 2', FRA = 'Param. 2';
        }
        modify("Depreciable Basis")
        {

            //Unsupported feature: Change CalcFormula on ""Depreciable Basis"(Field 24)". Please convert manually.

            CaptionML = ENU = 'Depreciable Basis', FRA = 'Base amortissement';
        }
        modify("Salvage Value")
        {

            //Unsupported feature: Change CalcFormula on ""Salvage Value"(Field 25)". Please convert manually.

            CaptionML = ENU = 'Salvage Value', FRA = 'Valeur résiduelle';
        }
        modify("Book Value on Disposal")
        {

            //Unsupported feature: Change CalcFormula on ""Book Value on Disposal"(Field 26)". Please convert manually.

            CaptionML = ENU = 'Book Value on Disposal', FRA = 'Valeur comptable sur cession';
        }
        modify(Maintenance)
        {

            //Unsupported feature: Change CalcFormula on "Maintenance(Field 27)". Please convert manually.

            CaptionML = ENU = 'Maintenance', FRA = 'Maintenance';
        }
        modify("Maintenance Code Filter")
        {
            CaptionML = ENU = 'Maintenance Code Filter', FRA = 'Filtre code maintenance';
        }
        modify("FA Posting Date Filter")
        {
            CaptionML = ENU = 'FA Posting Date Filter', FRA = 'Filtre date compta. immo.';
        }
        modify("Acquisition Date")
        {
            CaptionML = ENU = 'Acquisition Date', FRA = 'Date acquisition';
        }
        modify("G/L Acquisition Date")
        {
            CaptionML = ENU = 'G/L Acquisition Date', FRA = 'Date acquisition compta.';
        }
        modify("Disposal Date")
        {
            CaptionML = ENU = 'Disposal Date', FRA = 'Date cession';
        }
        modify("Last Acquisition Cost Date")
        {
            CaptionML = ENU = 'Last Acquisition Cost Date', FRA = 'Date dernier coût acq.';
        }
        modify("Last Depreciation Date")
        {
            CaptionML = ENU = 'Last Depreciation Date', FRA = 'Date dernier amortissement';
        }
        modify("Last Write-Down Date")
        {
            CaptionML = ENU = 'Last Write-Down Date', FRA = 'Date dernière dépréciation';
        }
        modify("Last Appreciation Date")
        {
            CaptionML = ENU = 'Last Appreciation Date', FRA = 'Date dernière réévaluation';
        }
        modify("Last Custom 1 Date")
        {
            CaptionML = ENU = 'Last Custom 1 Date', FRA = 'Date dernier param. 1';
        }
        modify("Last Custom 2 Date")
        {
            CaptionML = ENU = 'Last Custom 2 Date', FRA = 'Date dernier param. 2';
        }
        modify("Last Salvage Value Date")
        {
            CaptionML = ENU = 'Last Salvage Value Date', FRA = 'Date dern. valeur résiduelle';
        }
        modify("FA Exchange Rate")
        {
            CaptionML = ENU = 'FA Exchange Rate', FRA = 'Taux actualisation immo.';
        }
        modify("Fixed Depr. Amount below Zero")
        {
            CaptionML = ENU = 'Fixed Depr. Amount below Zero', FRA = 'Montant amortissement négatif';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify("First User-Defined Depr. Date")
        {
            CaptionML = ENU = 'First User-Defined Depr. Date', FRA = 'Date premier amortissement';
        }
        modify("Use FA Ledger Check")
        {

            //Unsupported feature: Change InitValue on ""Use FA Ledger Check"(Field 44)". Please convert manually.

            CaptionML = ENU = 'Use FA Ledger Check', FRA = 'Utiliser vérif. écriture immo.';
        }
        modify("Last Maintenance Date")
        {
            CaptionML = ENU = 'Last Maintenance Date', FRA = 'Date dernière maintenance';
        }
        modify("Depr. below Zero %")
        {
            CaptionML = ENU = 'Depr. below Zero %', FRA = '% amortissement négatif';
        }
        modify("Projected Disposal Date")
        {
            CaptionML = ENU = 'Projected Disposal Date', FRA = 'Date cession prévue';
        }
        modify("Projected Proceeds on Disposal")
        {
            CaptionML = ENU = 'Projected Proceeds on Disposal', FRA = 'Produit de cession prévu';
        }
        modify("Depr. Starting Date (Custom 1)")
        {
            CaptionML = ENU = 'Depr. Starting Date (Custom 1)', FRA = 'Date début amort. (param. 1)';
        }
        modify("Depr. Ending Date (Custom 1)")
        {
            CaptionML = ENU = 'Depr. Ending Date (Custom 1)', FRA = 'Date fin amort. (param. 1)';
        }
        modify("Accum. Depr. % (Custom 1)")
        {
            CaptionML = ENU = 'Accum. Depr. % (Custom 1)', FRA = '% total amort. (param. 1)';
        }
        modify("Depr. This Year % (Custom 1)")
        {
            CaptionML = ENU = 'Depr. This Year % (Custom 1)', FRA = '% annuel amort. (param. 1)';
        }
        modify("Property Class (Custom 1)")
        {
            CaptionML = ENU = 'Property Class (Custom 1)', FRA = 'Classe propriété (param. 1)';
            OptionCaptionML = ENU = ' ,Personal Property,Real Property', FRA = ' ,Bien mobilier,Bien immobilier';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
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
        modify("FA Add.-Currency Factor")
        {
            CaptionML = ENU = 'FA Add.-Currency Factor', FRA = 'Facteur devise immo.';
        }
        modify("Use Half-Year Convention")
        {
            CaptionML = ENU = 'Use Half-Year Convention', FRA = 'Utiliser règle demi-année';
        }
        modify("Use DB% First Fiscal Year")
        {
            CaptionML = ENU = 'Use DB% First Fiscal Year', FRA = 'Utiliser % dégr. 1er exercice';
        }
        modify("Temp. Ending Date")
        {
            CaptionML = ENU = 'Temp. Ending Date', FRA = 'Date fin temp.';
        }
        modify("Temp. Fixed Depr. Amount")
        {
            CaptionML = ENU = 'Temp. Fixed Depr. Amount', FRA = 'Montant annuité amortissement temp.';
        }
        modify("Ignore Def. Ending Book Value")
        {
            CaptionML = ENU = 'Ignore Def. Ending Book Value', FRA = 'Ignorer la valeur compta. finale par déf.';
        }
        modify("Default FA Depreciation Book")
        {
            CaptionML = ENU = 'Default FA Depreciation Book', FRA = 'Plan amortissement par défaut';
        }

        //Unsupported feature: CodeInsertion on ""FA No."(Field 1)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.35 DDR 31/08/2009
        if "FA No." <> '' then begin
          FA.GET("FA No.");
          if (FA."Depreciation Starting Date" <> 0D) and
            ("Depreciation Starting Date" = 0D) and
            (((FA."Depreciation Starting Date" <= "Depreciation Ending Date") and ("Depreciation Ending Date" <> 0D)) or
            ("Depreciation Ending Date" = 0D))
          then
            "Depreciation Starting Date" := FA."Depreciation Starting Date";


          if "Depreciation Ending Date" <> 0D then
            VALIDATE("Depreciation Starting Date")
          else
            if "Depreciation Book Code" <> '' then
              VALIDATE("No. of Depreciation Years");
        end;
        // >>DITW15.00.00.35 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Depreciation Method"(Field 3).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ModifyDeprFields;
        CASE "Depreciation Method" OF
          "Depreciation Method"::"Straight-Line":
            BEGIN
              "Declining-Balance %" := 0;
              "Depreciation Table Code" := '';
              "First User-Defined Depr. Date" := 0D;
              "Use DB% First Fiscal Year" := FALSE;
            end;
          "Depreciation Method"::"Declining-Balance 1",
          "Depreciation Method"::"Declining-Balance 2":
            BEGIN
              "Straight-Line %" := 0;
              "No. of Depreciation Years" := 0;
              "No. of Depreciation Months" := 0;
              "Fixed Depr. Amount" := 0;
              "Depreciation Ending Date" := 0D;
              "Depreciation Table Code" := '';
              "First User-Defined Depr. Date" := 0D;
              "Use DB% First Fiscal Year" := FALSE;
            end;
          "Depreciation Method"::"DB1/SL",
          "Depreciation Method"::"DB2/SL":
            BEGIN
              "Depreciation Table Code" := '';
              "First User-Defined Depr. Date" := 0D;
            end;
          "Depreciation Method"::"User-Defined":
            BEGIN
              "Straight-Line %" := 0;
              "No. of Depreciation Years" := 0;
              "No. of Depreciation Months" := 0;
              "Fixed Depr. Amount" := 0;
              "Depreciation Ending Date" := 0D;
              "Declining-Balance %" := 0;
              "Use DB% First Fiscal Year" := FALSE;
            end;
          "Depreciation Method"::Manual:
            BEGIN
              "Straight-Line %" := 0;
              "No. of Depreciation Years" := 0;
              "No. of Depreciation Months" := 0;
              "Fixed Depr. Amount" := 0;
              "Depreciation Ending Date" := 0D;
              "Declining-Balance %" := 0;
              "Depreciation Table Code" := '';
              "First User-Defined Depr. Date" := 0D;
              "Use DB% First Fiscal Year" := FALSE;
            end;
        end;
        TestHalfYearConventionMethod;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ModifyDeprFields;
        case "Depreciation Method" of
          "Depreciation Method"::"Straight-Line":
            begin
        #5..7
              "Use DB% First Fiscal Year" := false;
            end;
          "Depreciation Method"::"Declining-Balance 1",
          "Depreciation Method"::"Declining-Balance 2":
            begin
        #13..19
              "Use DB% First Fiscal Year" := false;
            end;
          "Depreciation Method"::"DB1/SL",
          "Depreciation Method"::"DB2/SL":
            begin
              "Depreciation Table Code" := '';
              "First User-Defined Depr. Date" := 0D;
            end;
          "Depreciation Method"::"User-Defined":
            begin
        #30..35
              "Use DB% First Fiscal Year" := false;
            end;
          "Depreciation Method"::Manual:
            begin
        #40..47
              "Use DB% First Fiscal Year" := false;
            end;
        end;
        TestHalfYearConventionMethod;
        */
        //end;


        //Unsupported feature: CodeModification on ""Straight-Line %"(Field 5).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ModifyDeprFields;
        IF ("Straight-Line %" <> 0) AND NOT LinearMethod THEN
          DeprMethodError;
        AdjustLinearMethod("No. of Depreciation Years","Fixed Depr. Amount");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ModifyDeprFields;
        if ("Straight-Line %" <> 0) and not LinearMethod then
          DeprMethodError;
        AdjustLinearMethod("No. of Depreciation Years","Fixed Depr. Amount");
        */
        //end;


        //Unsupported feature: CodeModification on ""No. of Depreciation Years"(Field 6).OnValidate". Please convert manually.

        //trigger  of Depreciation Years"(Field 6)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DeprBook2.GET("Depreciation Book Code");
        DeprBook2.TESTFIELD("Fiscal Year 365 Days",FALSE);

        TESTFIELD("Depreciation Starting Date");
        ModifyDeprFields;
        IF ("No. of Depreciation Years" <> 0) AND NOT LinearMethod THEN
          DeprMethodError;

        "No. of Depreciation Months" := ROUND("No. of Depreciation Years" * 12,0.00000001);
        AdjustLinearMethod("Straight-Line %","Fixed Depr. Amount");
        "Depreciation Ending Date" := CalcEndingDate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        DeprBook2.GET("Depreciation Book Code");
        DeprBook2.TESTFIELD("Fiscal Year 365 Days",false);
        #3..5
        if ("No. of Depreciation Years" <> 0) and not LinearMethod then
        #7..11
        */
        //end;


        //Unsupported feature: CodeModification on ""No. of Depreciation Months"(Field 7).OnValidate". Please convert manually.

        //trigger  of Depreciation Months"(Field 7)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DeprBook2.GET("Depreciation Book Code");
        DeprBook2.TESTFIELD("Fiscal Year 365 Days",FALSE);

        TESTFIELD("Depreciation Starting Date");
        ModifyDeprFields;
        IF ("No. of Depreciation Months" <> 0) AND NOT LinearMethod THEN
          DeprMethodError;

        "No. of Depreciation Years" := ROUND("No. of Depreciation Months" / 12,0.00000001);
        AdjustLinearMethod("Straight-Line %","Fixed Depr. Amount");
        "Depreciation Ending Date" := CalcEndingDate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        DeprBook2.GET("Depreciation Book Code");
        DeprBook2.TESTFIELD("Fiscal Year 365 Days",false);
        #3..5
        if ("No. of Depreciation Months" <> 0) and not LinearMethod then
        #7..11
        */
        //end;


        //Unsupported feature: CodeModification on ""Fixed Depr. Amount"(Field 8).OnValidate". Please convert manually.

        //trigger  Amount"(Field 8)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ModifyDeprFields;
        IF ("Fixed Depr. Amount" <> 0) AND NOT LinearMethod THEN
          DeprMethodError;
        AdjustLinearMethod("Straight-Line %","No. of Depreciation Years");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ModifyDeprFields;
        if ("Fixed Depr. Amount" <> 0) and not LinearMethod then
          DeprMethodError;
        AdjustLinearMethod("Straight-Line %","No. of Depreciation Years");
        */
        //end;


        //Unsupported feature: CodeModification on ""Declining-Balance %"(Field 9).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Declining-Balance %" >= 100 THEN
          FIELDERROR("Declining-Balance %",Text001);
        ModifyDeprFields;
        IF ("Declining-Balance %" <> 0) AND NOT DecliningMethod THEN
          DeprMethodError;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Declining-Balance %" >= 100 then
          FIELDERROR("Declining-Balance %",Text001);
        ModifyDeprFields;
        if ("Declining-Balance %" <> 0) and not DecliningMethod then
          DeprMethodError;
        */
        //end;


        //Unsupported feature: CodeModification on ""Depreciation Table Code"(Field 10).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ModifyDeprFields;
        IF ("Depreciation Table Code" <> '') AND NOT UserDefinedMethod THEN
          DeprMethodError;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ModifyDeprFields;
        if ("Depreciation Table Code" <> '') and not UserDefinedMethod then
          DeprMethodError;
        */
        //end;


        //Unsupported feature: CodeModification on ""Depreciation Ending Date"(Field 14).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Depreciation Starting Date");
        IF ("Depreciation Ending Date" <> 0D) AND NOT LinearMethod THEN
          DeprMethodError;
        ModifyDeprFields;
        CalcDeprPeriod;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Depreciation Starting Date");
        if ("Depreciation Ending Date" <> 0D) and not LinearMethod then
        #3..5
        */
        //end;


        //Unsupported feature: CodeModification on ""Fixed Depr. Amount below Zero"(Field 41).OnValidate". Please convert manually.

        //trigger  Amount below Zero"(Field 41)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ModifyDeprFields;
        "Depr. below Zero %" := 0;
        IF "Fixed Depr. Amount below Zero" > 0 THEN BEGIN
          DeprBook.GET("Depreciation Book Code");
          DeprBook.TESTFIELD("Allow Depr. below Zero",TRUE);
          TESTFIELD("Use FA Ledger Check",TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ModifyDeprFields;
        "Depr. below Zero %" := 0;
        if "Fixed Depr. Amount below Zero" > 0 then begin
          DeprBook.GET("Depreciation Book Code");
          DeprBook.TESTFIELD("Allow Depr. below Zero",true);
          TESTFIELD("Use FA Ledger Check",true);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""First User-Defined Depr. Date"(Field 43).OnValidate". Please convert manually.

        //trigger  Date"(Field 43)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ModifyDeprFields;
        IF ("First User-Defined Depr. Date" <> 0D) AND NOT UserDefinedMethod THEN
          DeprMethodError;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ModifyDeprFields;
        if ("First User-Defined Depr. Date" <> 0D) and not UserDefinedMethod then
          DeprMethodError;
        */
        //end;


        //Unsupported feature: CodeModification on ""Use FA Ledger Check"(Field 44).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT "Use FA Ledger Check" THEN BEGIN
          DeprBook.GET("Depreciation Book Code");
          DeprBook.TESTFIELD("Use FA Ledger Check",FALSE);
          TESTFIELD("Fixed Depr. Amount below Zero",0);
          TESTFIELD("Depr. below Zero %",0);
        end;
        ModifyDeprFields;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not "Use FA Ledger Check" then begin
          DeprBook.GET("Depreciation Book Code");
          DeprBook.TESTFIELD("Use FA Ledger Check",false);
          TESTFIELD("Fixed Depr. Amount below Zero",0);
          TESTFIELD("Depr. below Zero %",0);
        end;
        ModifyDeprFields;
        */
        //end;


        //Unsupported feature: CodeModification on ""Depr. below Zero %"(Field 46).OnValidate". Please convert manually.

        //trigger  below Zero %"(Field 46)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ModifyDeprFields;
        "Fixed Depr. Amount below Zero" := 0;
        IF "Depr. below Zero %" > 0 THEN BEGIN
          DeprBook.GET("Depreciation Book Code");
          DeprBook.TESTFIELD("Allow Depr. below Zero",TRUE);
          TESTFIELD("Use FA Ledger Check",TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ModifyDeprFields;
        "Fixed Depr. Amount below Zero" := 0;
        if "Depr. below Zero %" > 0 then begin
          DeprBook.GET("Depreciation Book Code");
          DeprBook.TESTFIELD("Allow Depr. below Zero",true);
          TESTFIELD("Use FA Ledger Check",true);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Use DB% First Fiscal Year"(Field 60).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Use DB% First Fiscal Year" THEN
          IF NOT (("Depreciation Method" = "Depreciation Method"::"DB1/SL") OR
                  ("Depreciation Method" = "Depreciation Method"::"DB2/SL"))
          THEN
            DeprMethodError;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Use DB% First Fiscal Year" then
          if not (("Depreciation Method" = "Depreciation Method"::"DB1/SL") or
                  ("Depreciation Method" = "Depreciation Method"::"DB2/SL"))
          then
            DeprMethodError;
        */
        //end;


        //Unsupported feature: CodeModification on ""Default FA Depreciation Book"(Field 70).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DefaultFADeprBook.SETRANGE("FA No.","FA No.");
        DefaultFADeprBook.SETRANGE("Default FA Depreciation Book",TRUE);
        IF NOT DefaultFADeprBook.ISEMPTY THEN
          FIELDERROR("Default FA Depreciation Book",OnlyOneDefaultDeprBookErr);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        DefaultFADeprBook.SETRANGE("FA No.","FA No.");
        DefaultFADeprBook.SETRANGE("Default FA Depreciation Book",true);
        if not DefaultFADeprBook.ISEMPTY then
          FIELDERROR("Default FA Depreciation Book",OnlyOneDefaultDeprBookErr);
        */
        //end;

        /* //Bc Upgrade YADAVM09 Drink it field commented>>
       field(10800; Derogatory; Decimal)
       {
           AutoFormatType = 1;
           CalcFormula = Sum("FA Ledger Entry".Amount where("FA No." = FIELD("FA No."),
                                                             "Depreciation Book Code" = FIELD("Depreciation Book Code"),
                                                             "FA Posting Category" = CONST(" "),
                                                              "FA Posting Type" = CONST(Derogatory),
                                                             "FA Posting Date" = FIELD("FA Posting Date Filter"),
                                                             "Exclude Derogatory" = CONST(false)));
           CaptionML = ENU = 'Derogatory',
                       FRA = 'Dérogatoire';
           Editable = false;
           FieldClass = FlowField;
       }
       field(10801; "Last Derogatory Date"; Date)
       {
           CaptionML = ENU = 'Last Derogatory Date',
                       FRA = 'Dernière date dérogatoire';
       }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
    }


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Acquisition Date" := 0D;
    "G/L Acquisition Date" := 0D;
    "Last Acquisition Cost Date" := 0D;
    #4..12
    FA.LOCKTABLE;
    DeprBook.LOCKTABLE;
    FA.GET("FA No.");
    DeprBook.GET("Depreciation Book Code");
    Description := FA.Description;
    "Main Asset/Component" := FA."Main Asset/Component";
    "Component of Main Asset" := FA."Component of Main Asset";
    IF ("No. of Depreciation Years" <> 0) OR ("No. of Depreciation Months" <> 0) THEN
      DeprBook.TESTFIELD("Fiscal Year 365 Days",FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..15
    // <<DITW15.00.00.35 DDR 31/08/2009
    VALIDATE("FA No.");
    // >>DITW15.00.00.35 DDR
    #16..19
    if ("No. of Depreciation Years" <> 0) or ("No. of Depreciation Months" <> 0) then
      DeprBook.TESTFIELD("Fiscal Year 365 Days",false);
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;
    LOCKTABLE;
    DeprBook.LOCKTABLE;
    DeprBook.GET("Depreciation Book Code");
    IF ("No. of Depreciation Years" <> 0) OR ("No. of Depreciation Months" <> 0) THEN
      DeprBook.TESTFIELD("Fiscal Year 365 Days",FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    if ("No. of Depreciation Years" <> 0) or ("No. of Depreciation Months" <> 0) then
      DeprBook.TESTFIELD("Fiscal Year 365 Days",false);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=must not be 100;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=must not be 100;FRA=ne doit pas être 100;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=%1 is later than %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=%1 is later than %2.;FRA=%1 est plus récent que %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=must not be %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=must not be %1;FRA=ne doit pas être %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=untitled;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=untitled;FRA=sans-titre;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OnlyOneDefaultDeprBookErr(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OnlyOneDefaultDeprBookErr : ENU=Only one fixed asset depreciation book can be marked as the default book;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnlyOneDefaultDeprBookErr : ENU=Only one fixed asset depreciation book can be marked as the default book;FRA=Un seul plan d'amortissement peut être marqué comme valeur par défaut;
    //Variable type has not been exported.

    var
        CompanyInfo: Record "Company Information";
}

