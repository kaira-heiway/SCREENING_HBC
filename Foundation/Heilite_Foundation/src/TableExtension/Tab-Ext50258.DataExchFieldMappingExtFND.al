tableextension 50258 DataExchFieldMappingExtFND extends "Data Exch. Field Mapping"
{
    // version NAVW110.0,HEI.01
    // HEI.01 FDD-GAPID001 IBM LAZARE02 07.07.2017 # Change length of field Field Caption from 30 to 80
    fields
    {
        modify("Data Exch. Def Code")
        {
            CaptionML = ENU = 'Data Exch. Def Code', FRA = 'Code déf. échange données';
        }
        modify("Table ID")
        {
            CaptionML = ENU = 'Table ID', FRA = 'ID table';
        }
        modify("Column No.")
        {

            //Unsupported feature: Change TableRelation on ""Column No."(Field 3)". Please convert manually.

            CaptionML = ENU = 'Column No.', FRA = 'N° colonne';
        }
        modify("Field ID")
        {

            //Unsupported feature: Change TableRelation on ""Field ID"(Field 4)". Please convert manually.

            CaptionML = ENU = 'Field ID', FRA = 'ID champ';
        }
        modify(Optional)
        {
            CaptionML = ENU = 'Optional', FRA = 'En option';
        }
        modify("Use Default Value")
        {
            CaptionML = ENU = 'Use Default Value', FRA = 'Utiliser valeur par défaut';
        }
        modify("Default Value")
        {
            CaptionML = ENU = 'Default Value', FRA = 'Valeur par défaut';
        }
        modify("Data Exch. Line Def Code")
        {

            //Unsupported feature: Change TableRelation on ""Data Exch. Line Def Code"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Data Exch. Line Def Code', FRA = 'Code déf. ligne échange données';
        }
        modify(Multiplier)
        {
            CaptionML = ENU = 'Multiplier', FRA = 'Multiplicateur';
        }
        modify("Target Table ID")
        {

            //Unsupported feature: Change TableRelation on ""Target Table ID"(Field 10)". Please convert manually.

            CaptionML = ENU = 'Target Table ID', FRA = 'ID table cible';
        }
        modify("Target Field ID")
        {

            //Unsupported feature: Change TableRelation on ""Target Field ID"(Field 11)". Please convert manually.

            CaptionML = ENU = 'Target Field ID', FRA = 'ID champ cible';
        }
        modify("Target Table Caption")
        {

            //Unsupported feature: Change CalcFormula on ""Target Table Caption"(Field 12)". Please convert manually.

            CaptionML = ENU = 'Target Table Caption', FRA = 'Libellé table cible';
        }
        // BC Upgrade ANDIS03 >>
        // modify("Target Field Caption")
        // {

        //     //Unsupported feature: Change Data type on ""Target Field Caption"(Field 13)". Please convert manually.


        //     //Unsupported feature: Change CalcFormula on ""Target Field Caption"(Field 13)". Please convert manually.

        //     CaptionML = ENU = 'Target Field Caption', FRA = 'Libellé champ cible';
        // }  // BC Upgrade ANDIS03 << field removed from Standard
        modify("Transformation Rule")
        {
            CaptionML = ENU = 'Transformation Rule', FRA = 'Règle de transformation';
        }

        //Unsupported feature: CodeModification on ""Use Default Value"(Field 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT "Use Default Value" THEN
          "Default Value" := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not "Use Default Value" then
          "Default Value" := '';
        */
        //end;


        //Unsupported feature: CodeModification on ""Default Value"(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Use Default Value",TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE("Use Default Value",true);
        */
        //end;


        //Unsupported feature: CodeModification on "Multiplier(Field 9).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF IsValidToUseMultiplier AND (Multiplier = 0) THEN
          ERROR(ZeroNotAllowedErr);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if IsValidToUseMultiplier and (Multiplier = 0) then
          ERROR(ZeroNotAllowedErr);
        */
        //end;


        //Unsupported feature: CodeModification on ""Target Field ID"(Field 11).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Field.SETRANGE(TableNo,"Target Table ID");
        FieldsLookup.SETTABLEVIEW(Field);
        FieldsLookup.LOOKUPMODE(TRUE);
        IF FieldsLookup.RUNMODAL = ACTION::LookupOK THEN BEGIN
          FieldsLookup.GETRECORD(Field);
          VALIDATE("Target Field ID",Field."No.");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Field.SETRANGE(TableNo,"Target Table ID");
        FieldsLookup.SETTABLEVIEW(Field);
        FieldsLookup.LOOKUPMODE(true);
        if FieldsLookup.RUNMODAL = ACTION::LookupOK then begin
          FieldsLookup.GETRECORD(Field);
          VALIDATE("Target Field ID",Field."No.");
        end;
        */
        //end;
    }


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Column No.");

    IF IsValidToUseMultiplier AND (Multiplier = 0) THEN
      VALIDATE(Multiplier,1);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TESTFIELD("Column No.");

    if IsValidToUseMultiplier and (Multiplier = 0) then
      VALIDATE(Multiplier,1);
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF IsValidToUseMultiplier AND (Multiplier = 0) THEN
      VALIDATE(Multiplier,1);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if IsValidToUseMultiplier and (Multiplier = 0) then
      VALIDATE(Multiplier,1);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "ZeroNotAllowedErr(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ZeroNotAllowedErr : ENU=All numeric values are allowed except zero.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ZeroNotAllowedErr : ENU=All numeric values are allowed except zero.;FRA=Toutes les valeurs numériques sont autorisées, sauf zéro.;
    //Variable type has not been exported.
}

