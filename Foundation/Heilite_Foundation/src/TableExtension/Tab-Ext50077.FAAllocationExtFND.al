tableextension 50077 FAAllocationExtFND extends "FA Allocation"
{
    // HEI.01 FDD-HT584 IBM NASTAA02 27.09.2019 # La Reunion FA Derogatory Depreciation
    //   # Added new option 'Derogatory' to "Allocation Type" Field
    // version NAVW17.00

    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Account No.")
        {
            CaptionML = ENU = 'Account No.', FRA = 'N° compte';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 5)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 6)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Allocation %")
        {
            CaptionML = ENU = 'Allocation %', FRA = '% ventilation';
        }
        modify("Allocation Type")
        {
            CaptionML = ENU = 'Allocation Type', FRA = 'Type ventilation';
            // OptionCaptionML = ENU = 'Acquisition,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance,Gain,Loss,Book Value (Gain),Book Value (Loss),Derogatory', FRA = 'Acquisition,Amortissement,Dépréciation,Réévaluation,Param. 1,Param. 2,Cession,Maintenance,Gain,Perte,Valeur comptable (gain),Valeur comptable (perte),Dérogatoire';

            //Unsupported feature: Change OptionString on ""Allocation Type"(Field 8)". Please convert manually.


            //Unsupported feature: Change Description on ""Allocation Type"(Field 8)". Please convert manually.

        }
        modify("Account Name")
        {

            //Unsupported feature: Change CalcFormula on ""Account Name"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Account Name', FRA = 'Nom du compte';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }

        //Unsupported feature: CodeModification on ""Account No."(Field 4).OnValidate". Please convert manually.

        //trigger "(Field 4)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Account No." = '' THEN
          EXIT;
        GLAcc.GET("Account No.");
        GLAcc.CheckGLAcc;
        IF "Allocation Type" < "Allocation Type"::Gain THEN
          GLAcc.TESTFIELD("Direct Posting");
        Description := GLAcc.Name;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Account No." = '' then
          exit;
        GLAcc.GET("Account No.");
        GLAcc.CheckGLAcc;
        if "Allocation Type" < "Allocation Type"::Gain then
          GLAcc.TESTFIELD("Direct Posting");
        Description := GLAcc.Name;
        */
        //end;
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


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
}

