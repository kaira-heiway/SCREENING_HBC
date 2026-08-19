tableextension 50074 DepreciationBookExt extends "Depreciation Book"
{
    // version NAVW110.0,DITW110.00.08,HEI.01

    //Bc Upgrade YADAVM09 Drink it field commented -Derogatory Calculation,Used with Derogatory Book,G/L Integration - Derogatory.
    //#CheckIntegrationFields function blocked dependency on drink it field.
    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("G/L Integration - Acq. Cost")
        {
            CaptionML = ENU = 'G/L Integration - Acq. Cost', FRA = 'Intégration cpta. - Coût acq.';
        }
        modify("G/L Integration - Depreciation")
        {
            CaptionML = ENU = 'G/L Integration - Depreciation', FRA = 'Intégration cpta. - Amort.';
        }
        modify("G/L Integration - Write-Down")
        {
            CaptionML = ENU = 'G/L Integration - Write-Down', FRA = 'Intégration cpta. - Dépr.';
        }
        modify("G/L Integration - Appreciation")
        {
            CaptionML = ENU = 'G/L Integration - Appreciation', FRA = 'Intégration cpta. - Rééval.';
        }
        modify("G/L Integration - Custom 1")
        {
            CaptionML = ENU = 'G/L Integration - Custom 1', FRA = 'Intégration cpta. - Param. 1';
        }
        modify("G/L Integration - Custom 2")
        {
            CaptionML = ENU = 'G/L Integration - Custom 2', FRA = 'Intégration cpta. - Param. 2';
        }
        modify("G/L Integration - Disposal")
        {
            CaptionML = ENU = 'G/L Integration - Disposal', FRA = 'Intégration cpta. - Cession';
        }
        modify("G/L Integration - Maintenance")
        {
            CaptionML = ENU = 'G/L Integration - Maintenance', FRA = 'Intégration cpta. - Maint.';
        }
        modify("Disposal Calculation Method")
        {
            CaptionML = ENU = 'Disposal Calculation Method', FRA = 'Méthode calcul cession';
            OptionCaptionML = ENU = 'Net,Gross', FRA = 'Net,Brut';
        }
        modify("Use Custom 1 Depreciation")
        {
            CaptionML = ENU = 'Use Custom 1 Depreciation', FRA = 'Utiliser amort. param. 1';
        }
        modify("Allow Depr. below Zero")
        {
            CaptionML = ENU = 'Allow Depr. below Zero', FRA = 'Autoriser amort. négatifs';
        }
        modify("Use FA Exch. Rate in Duplic.")
        {
            CaptionML = ENU = 'Use FA Exch. Rate in Duplic.', FRA = 'Utiliser taux actu. en duplic.';
        }
        modify("Part of Duplication List")
        {
            CaptionML = ENU = 'Part of Duplication List', FRA = 'Inclure dans liste duplication';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify("Allow Indexation")
        {
            CaptionML = ENU = 'Allow Indexation', FRA = 'Autoriser actualisation';
        }
        modify("Use Same FA+G/L Posting Dates")
        {

            //Unsupported feature: Change InitValue on ""Use Same FA+G/L Posting Dates"(Field 19)". Please convert manually.

            CaptionML = ENU = 'Use Same FA+G/L Posting Dates', FRA = 'Mêmes dates compta./immo.';
        }
        modify("Default Exchange Rate")
        {
            CaptionML = ENU = 'Default Exchange Rate', FRA = 'Taux actualisation par défaut';
        }
        modify("Use FA Ledger Check")
        {

            //Unsupported feature: Change InitValue on ""Use FA Ledger Check"(Field 23)". Please convert manually.

            CaptionML = ENU = 'Use FA Ledger Check', FRA = 'Utiliser vérif. écriture immo.';
        }
        modify("Use Rounding in Periodic Depr.")
        {
            CaptionML = ENU = 'Use Rounding in Periodic Depr.', FRA = 'Utiliser arrondi dans amort.';
        }
        modify("New Fiscal Year Starting Date")
        {
            CaptionML = ENU = 'New Fiscal Year Starting Date', FRA = 'Date début nouvel exercice';
        }
        modify("No. of Days in Fiscal Year")
        {
            CaptionML = ENU = 'No. of Days in Fiscal Year', FRA = 'Nombre jours dans exercice';
        }
        modify("Allow Changes in Depr. Fields")
        {
            CaptionML = ENU = 'Allow Changes in Depr. Fields', FRA = 'Autoriser modif. champ amort.';
        }
        modify("Default Final Rounding Amount")
        {
            CaptionML = ENU = 'Default Final Rounding Amount', FRA = 'Montant final arrondi par déf.';
        }
        modify("Default Ending Book Value")
        {
            CaptionML = ENU = 'Default Ending Book Value', FRA = 'Valeur compta. finale par déf.';
        }
        modify("Periodic Depr. Date Calc.")
        {
            CaptionML = ENU = 'Periodic Depr. Date Calc.', FRA = 'Calculer date amortissement';
            OptionCaptionML = ENU = 'Last Entry,Last Depr. Entry', FRA = 'Dernière écriture,Dernière écr. amort.';
        }
        modify("Mark Errors as Corrections")
        {
            CaptionML = ENU = 'Mark Errors as Corrections', FRA = 'Marquer correction si erreur';
        }
        modify("Add-Curr Exch Rate - Acq. Cost")
        {
            CaptionML = ENU = 'Add-Curr Exch Rate - Acq. Cost', FRA = 'Taux change DR - Coût acq.';
        }
        modify("Add.-Curr. Exch. Rate - Depr.")
        {
            CaptionML = ENU = 'Add.-Curr. Exch. Rate - Depr.', FRA = 'Taux change DR - Amort.';
        }
        modify("Add-Curr Exch Rate -Write-Down")
        {
            CaptionML = ENU = 'Add-Curr Exch Rate -Write-Down', FRA = 'Taux change DR - Dépr.';
        }
        modify("Add-Curr. Exch. Rate - Apprec.")
        {
            CaptionML = ENU = 'Add-Curr. Exch. Rate - Apprec.', FRA = 'Taux change DR - Rééval.';
        }
        modify("Add-Curr. Exch Rate - Custom 1")
        {
            CaptionML = ENU = 'Add-Curr. Exch Rate - Custom 1', FRA = 'Taux change DR - Param 1';
        }
        modify("Add-Curr. Exch Rate - Custom 2")
        {
            CaptionML = ENU = 'Add-Curr. Exch Rate - Custom 2', FRA = 'Taux change DR - Param 2';
        }
        modify("Add.-Curr. Exch. Rate - Disp.")
        {
            CaptionML = ENU = 'Add.-Curr. Exch. Rate - Disp.', FRA = 'Taux change DR - Cession';
        }
        modify("Add.-Curr. Exch. Rate - Maint.")
        {
            CaptionML = ENU = 'Add.-Curr. Exch. Rate - Maint.', FRA = 'Taux change DR - Maint.';
        }
        modify("Use Default Dimension")
        {
            CaptionML = ENU = 'Use Default Dimension', FRA = 'Utiliser affectation analytique';
        }
        modify("Subtract Disc. in Purch. Inv.")
        {
            CaptionML = ENU = 'Subtract Disc. in Purch. Inv.', FRA = 'Déduire remise dans fact. achat';
        }
        modify("Allow Correction of Disposal")
        {
            CaptionML = ENU = 'Allow Correction of Disposal', FRA = 'Autoriser la correction de la cession';
        }
        modify("Allow more than 360/365 Days")
        {
            CaptionML = ENU = 'Allow more than 360/365 Days', FRA = 'Autoriser > 360/365 jours';
        }
        modify("VAT on Net Disposal Entries")
        {
            CaptionML = ENU = 'VAT on Net Disposal Entries', FRA = 'TVA sur les écritures de cession nette';
        }
        modify("Allow Acq. Cost below Zero")
        {
            CaptionML = ENU = 'Allow Acq. Cost below Zero', FRA = 'Autoriser coût acquisition négatif';
        }
        modify("Allow Identical Document No.")
        {
            CaptionML = ENU = 'Allow Identical Document No.', FRA = 'Autoriser N° document identique';
        }
        modify("Fiscal Year 365 Days")
        {
            CaptionML = ENU = 'Fiscal Year 365 Days', FRA = 'Exercice comptable 365 jours';
        }

        //Unsupported feature: CodeModification on ""Use Custom 1 Depreciation"(Field 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Use Custom 1 Depreciation" THEN
          TESTFIELD("Fiscal Year 365 Days",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Use Custom 1 Depreciation" then
          TESTFIELD("Fiscal Year 365 Days",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Use FA Exch. Rate in Duplic."(Field 14).OnValidate". Please convert manually.

        //trigger  Rate in Duplic();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT "Use FA Exch. Rate in Duplic." THEN
          "Default Exchange Rate" := 0;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not "Use FA Exch. Rate in Duplic." then
          "Default Exchange Rate" := 0;
        */
        //end;


        //Unsupported feature: CodeModification on ""Default Exchange Rate"(Field 20).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Default Exchange Rate" > 0 THEN
          TESTFIELD("Use FA Exch. Rate in Duplic.",TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Default Exchange Rate" > 0 then
          TESTFIELD("Use FA Exch. Rate in Duplic.",true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Periodic Depr. Date Calc."(Field 32).OnValidate". Please convert manually.

        //trigger  Date Calc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Periodic Depr. Date Calc." <> "Periodic Depr. Date Calc."::"Last Entry" THEN
          TESTFIELD("Fiscal Year 365 Days",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Periodic Depr. Date Calc." <> "Periodic Depr. Date Calc."::"Last Entry" then
          TESTFIELD("Fiscal Year 365 Days",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Fiscal Year 365 Days"(Field 49).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Fiscal Year 365 Days" THEN BEGIN
          TESTFIELD("Use Custom 1 Depreciation",FALSE);
          TESTFIELD("Periodic Depr. Date Calc.","Periodic Depr. Date Calc."::"Last Entry");
        end;
        FADeprBook.LOCKTABLE;
        MODIFY;
        FADeprBook.SETCURRENTKEY("Depreciation Book Code","FA No.");
        FADeprBook.SETRANGE("Depreciation Book Code",Code);
        IF FADeprBook.findset(TRUE) THEN
          REPEAT
            FADeprBook.CalcDeprPeriod;
            FADeprBook.MODIFY;
          UNTIL FADeprBook.NEXT = 0;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Fiscal Year 365 Days" then begin
          TESTFIELD("Use Custom 1 Depreciation",false);
          TESTFIELD("Periodic Depr. Date Calc.","Periodic Depr. Date Calc."::"Last Entry");
        end;
        #5..8
        if FADeprBook.findset(true) then
          repeat
            FADeprBook.CalcDeprPeriod;
            FADeprBook.MODIFY;
          until FADeprBook.NEXT = 0;
        */
        //end;

        /* //Bc Upgrade YADAVM09 Drink it field commented>>
       field(10800; "Derogatory Calculation"; Code[10])
       {
           CaptionML = ENU = 'Derogatory Calculation',
                       FRA = 'Calcul dérogatoire';
           Description = 'HEI.02';
           TableRelation = "Depreciation Book";

           trigger OnValidate();
           var
               DeprBook: Record "Depreciation Book";
           begin
               if ("Derogatory Calculation" <> xRec."Derogatory Calculation") then begin
                   if xRec."Derogatory Calculation" <> '' then begin
                       FADeprBook.SETRANGE("Depreciation Book Code", xRec."Derogatory Calculation");
                       if FADeprBook.FIND('-') then
                           repeat
                               FADeprBook.CALCFIELDS(Derogatory);
                               FADeprBook.TESTFIELD(Derogatory, 0);
                           until FADeprBook.NEXT = 0;
                   end else begin
                       DeprBook.SETRANGE("Derogatory Calculation", "Derogatory Calculation");
                       if DeprBook.FIND('-') then
                           if DeprBook.Code <> Code then
                               ERROR(Text10802, "Derogatory Calculation", DeprBook.Code);
                       DeprBook.SETRANGE("Derogatory Calculation");
                       DeprBook.SETRANGE(Code, "Derogatory Calculation");
                       if DeprBook.FIND('-') then
                           if (DeprBook."Derogatory Calculation" <> '') then
                               ERROR(Text10804, "Derogatory Calculation");
                   end;
                   if ("Derogatory Calculation" <> xRec."Derogatory Calculation") then
                       if "Used with Derogatory Book" <> '' then
                           ERROR(Text10800, Code);

               end;


               if "Derogatory Calculation" = Code then
                   ERROR(Text10801, "Derogatory Calculation", Code);

               CheckIntegrationFields;
           end;
       }
       field(10801; "Used with Derogatory Book"; Code[10])
       {
           CalcFormula = Lookup("Depreciation Book".Code where("Derogatory Calculation" = FIELD(Code)));
           CaptionML = ENU = 'Used with Derogatory Book',
                       FRA = 'Utilisé avec la loi dérogatoire';
           Description = 'HEI.02';
           Editable = false;
           FieldClass = FlowField;
       }
       field(10802; "G/L Integration - Derogatory"; Boolean)
       {
           CaptionML = ENU = 'G/L Integration - Derogatory',
                       FRA = 'Intégration cpta. - Dérogatoire';
           Description = 'HEI.02';

           trigger OnValidate();
           begin
               CheckIntegrationFields; //HEI.02
           end;
       }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
        field(50000; "Default Depr. Book FND"; Boolean)
        {
            Caption = 'Default Depr. Book';
            Description = 'HEI.01';
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FASetup.GET;
    FADeprBook.SETCURRENTKEY("Depreciation Book Code");
    FADeprBook.SETRANGE("Depreciation Book Code",Code);
    IF NOT FADeprBook.ISEMPTY THEN
      ERROR(Text000);

    IF NOT InsCoverageLedgEntry.ISEMPTY AND (FASetup."Insurance Depr. Book" = Code) THEN
      ERROR(
        Text001,
        FASetup.TABLECAPTION,FASetup.FIELDCAPTION("Insurance Depr. Book"),Code);

    FAPostingTypeSetup.SETRANGE("Depreciation Book Code",Code);
    FAPostingTypeSetup.DELETEALL;

    FAJnlSetup.SETRANGE("Depreciation Book Code",Code);
    FAJnlSetup.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    if not FADeprBook.ISEMPTY then
      ERROR(Text000);

    if not InsCoverageLedgEntry.ISEMPTY and (FASetup."Insurance Depr. Book" = Code) then
    #8..15
    // <<DITW15.00.00.38 DDR 05/01/2011 #822
    //FAJnlSetup.DELETEALL;
    FAJnlSetup.DELETEALL(true);
    // >>DITW15.00.00.38 DDR #822
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH FAPostingTypeSetup DO BEGIN
      "Depreciation Book Code" := Code;
      "FA Posting Type" := "FA Posting Type"::Appreciation;
      "Part of Book Value" := TRUE;
      "Part of Depreciable Basis" := TRUE;
      "Include in Depr. Calculation" := TRUE;
      "Include in Gain/Loss Calc." := FALSE;
      "Depreciation Type" := FALSE;
      "Acquisition Type" := TRUE;
      Sign := Sign::Debit;
      INSERT;
      "FA Posting Type" := "FA Posting Type"::"Write-Down";
      "Part of Depreciable Basis" := FALSE;
      "Include in Gain/Loss Calc." := TRUE;
      "Depreciation Type" := TRUE;
      "Acquisition Type" := FALSE;
      Sign := Sign::Credit;
      INSERT;
      "FA Posting Type" := "FA Posting Type"::"Custom 1";
      INSERT;
      "FA Posting Type" := "FA Posting Type"::"Custom 2";
      INSERT;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    with FAPostingTypeSetup do begin
      "Depreciation Book Code" := Code;
      "FA Posting Type" := "FA Posting Type"::Appreciation;
      "Part of Book Value" := true;
      "Part of Depreciable Basis" := true;
      "Include in Depr. Calculation" := true;
      "Include in Gain/Loss Calc." := false;
      "Depreciation Type" := false;
      "Acquisition Type" := true;
    #10..12
      "Part of Depreciable Basis" := false;
      "Include in Gain/Loss Calc." := true;
      "Depreciation Type" := true;
      "Acquisition Type" := false;
    #17..22
    end;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=The book cannot be deleted because it is in use.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=The book cannot be deleted because it is in use.;FRA=Cette loi d'amortissement ne peut pas être supprimée car elle est utilisée par ailleurs.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU="The book cannot be deleted because %1 %2 = %3.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU="The book cannot be deleted because %1 %2 = %3.";FRA="Cette loi d'amortissement ne peut pas être supprimée car %1 %2 = %3.";
    //Variable type has not been exported.

    var
        FADeprBook: Record "FA Depreciation Book";

    var
        GLIntegration: array[13] of Boolean;
        Text10800: TextConst ENU = 'The Depreciation Book %1 is an accounting book and cannot be set up as a Derogatory Depreciation Book.', FRA = 'La loi d''amortissement %1 est un document comptable qui ne peut pas être défini comme loi d''amortissement dérogatoire.';
        Text10801: TextConst ENU = 'The Depreciation Book %1 cannot be set up as Derogatory for Depreciation Book %2.', FRA = 'La loi d''amortissement %1 est un document comptable qui ne peut pas être défini comme dérogatoire pour la loi d''amortissement %2.';
        Text10802: TextConst ENU = 'The Depreciation Book %1 is already set up in combination with Derogatory Depreciation Book %2.', FRA = 'La loi d''amortissement %1 est déjà définie avec la loi d''amortissement dérogatoire %2.';
        Text10803: TextConst ENU = 'Derogatory Depreciation Books cannot be integrated with the General Ledger. Please make sure that none of the fields on the Integration tab are checked.', FRA = 'Des lois d''amortissement dérogatoires ne peuvent pas être intégrées à la comptabilité. Vérifiez qu''aucun des champs de l''onglet Intégration n''est sélectionné.';
        Text10804: TextConst ENU = 'The Depreciation Book %1 is a Derogatory Depreciation Book.', FRA = 'Les lois d''amortissement %1 sont des lois d''amortissement dérogatoires.';

    // BC Upgrade NANDIS03 >>

    /* //Bc Upgrade YADAVM09 Dependency on drink it field>>
    procedure CheckIntegrationFields()
    var
        i: Integer;
    begin
        //HEI.02>>
        IF "Derogatory Calculation" <> '' THEN BEGIN
            IndexGLIntegration(GLIntegration);
            FOR i := 1 TO 13 DO
                IF GLIntegration[i] THEN
                    ERROR(Text10803);
        end;
        //HEI.02<<
    end;
    // BC Upgrade NANDIS03 <<
     */ //Bc Upgrade YADAVM09 Dependency on drink it field<<
}

