tableextension 50071 FAPostingGroupExt extends "FA Posting Group"
{
    //  HEI.01 FDD RTRGAP071 IBM 24.04.2018
    //  Added following fields
    //  # 50003 Accum. Dep. Account Offset Code20
    //  # 50004 Dep. Expense Account Offset Code20
    //  # 50005 Acqi.Cost Acc. Disposal offset Code20
    //  # 50006 Gains Acc. on disposal Offset Code20
    //  # 50007 Sales bal.Acc. on disp. offset Code20
    //  # 50008 Accu.Dep. on Dis. acc offset Code20
    //  # 50009 Losses Acc. on Disp. Offset Code20
    //  HEI.02 FDD CHG2003709 IBM ISYED01 03.18.2019
    //   #New field  to add in FA Posting group table “Description”
    // HEI.01 FDD-HT584 IBM NASTAA02 27.09.2019 # La Reunion FA Derogatory Depreciation
    //   # New Fields created:
    //     # 10800Derogatory Account
    //     # 10801Derogatory Acc. (Decrease)
    //     # 10802Derog. Bal. Acc. (Decrease)
    //     # 10803Derogatory Expense Account
    //     # 10804Allocated Derogatory %
    // version NAVW110.0,HEI.01

    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify("Acquisition Cost Account")
        {
            CaptionML = ENU = 'Acquisition Cost Account', FRA = 'Compte coût acquisition';
        }
        modify("Accum. Depreciation Account")
        {
            CaptionML = ENU = 'Accum. Depreciation Account', FRA = 'Compte cumul amort.';
        }
        modify("Write-Down Account")
        {
            CaptionML = ENU = 'Write-Down Account', FRA = 'Compte dépréciation';
        }
        modify("Appreciation Account")
        {
            CaptionML = ENU = 'Appreciation Account', FRA = 'Compte réévaluation';
        }
        modify("Custom 1 Account")
        {
            CaptionML = ENU = 'Custom 1 Account', FRA = 'Compte param. 1';
        }
        modify("Custom 2 Account")
        {
            CaptionML = ENU = 'Custom 2 Account', FRA = 'Compte param. 2';
        }
        modify("Acq. Cost Acc. on Disposal")
        {
            CaptionML = ENU = 'Acq. Cost Acc. on Disposal', FRA = 'Compte coût acq. sur cession';
        }
        modify("Accum. Depr. Acc. on Disposal")
        {
            CaptionML = ENU = 'Accum. Depr. Acc. on Disposal', FRA = 'Compte cumul amort. cession';
        }
        modify("Write-Down Acc. on Disposal")
        {
            CaptionML = ENU = 'Write-Down Acc. on Disposal', FRA = 'Compte dépréciation cession';
        }
        modify("Appreciation Acc. on Disposal")
        {
            CaptionML = ENU = 'Appreciation Acc. on Disposal', FRA = 'Compte rééval. sur cession';
        }
        modify("Custom 1 Account on Disposal")
        {
            CaptionML = ENU = 'Custom 1 Account on Disposal', FRA = 'Compte param. 1 sur cession';
        }
        modify("Custom 2 Account on Disposal")
        {
            CaptionML = ENU = 'Custom 2 Account on Disposal', FRA = 'Compte param. 2 sur cession';
        }
        modify("Gains Acc. on Disposal")
        {
            CaptionML = ENU = 'Gains Acc. on Disposal', FRA = 'Compte gains sur cession';
        }
        modify("Losses Acc. on Disposal")
        {
            CaptionML = ENU = 'Losses Acc. on Disposal', FRA = 'Compte pertes sur cession';
        }
        modify("Book Val. Acc. on Disp. (Gain)")
        {
            CaptionML = ENU = 'Book Val. Acc. on Disp. (Gain)', FRA = 'Compte valeurs des élts d''actif cédés (gain)';
        }
        modify("Sales Acc. on Disp. (Gain)")
        {
            CaptionML = ENU = 'Sales Acc. on Disp. (Gain)', FRA = 'Compte produits des cessions d''élts d''actif (gain)';
        }
        modify("Write-Down Bal. Acc. on Disp.")
        {
            CaptionML = ENU = 'Write-Down Bal. Acc. on Disp.', FRA = 'Contrep. dépréciation cession';
        }
        modify("Apprec. Bal. Acc. on Disp.")
        {
            CaptionML = ENU = 'Apprec. Bal. Acc. on Disp.', FRA = 'Contrep. rééval. sur cession';
        }
        modify("Custom 1 Bal. Acc. on Disposal")
        {
            CaptionML = ENU = 'Custom 1 Bal. Acc. on Disposal', FRA = 'Contrep. param. 1 sur cession';
        }
        modify("Custom 2 Bal. Acc. on Disposal")
        {
            CaptionML = ENU = 'Custom 2 Bal. Acc. on Disposal', FRA = 'Contrep. param. 2 sur cession';
        }
        modify("Maintenance Expense Account")
        {
            CaptionML = ENU = 'Maintenance Expense Account', FRA = 'Compte frais maintenance';
        }
        modify("Maintenance Bal. Acc.")
        {
            CaptionML = ENU = 'Maintenance Bal. Acc.', FRA = 'Contrep. maintenance';
        }
        modify("Acquisition Cost Bal. Acc.")
        {
            CaptionML = ENU = 'Acquisition Cost Bal. Acc.', FRA = 'Contrep. coût acq.';
        }
        modify("Depreciation Expense Acc.")
        {
            CaptionML = ENU = 'Depreciation Expense Acc.', FRA = 'Compte dotations amort.';
        }
        modify("Write-Down Expense Acc.")
        {
            CaptionML = ENU = 'Write-Down Expense Acc.', FRA = 'Contrep. dépréciation';
        }
        modify("Appreciation Bal. Account")
        {
            CaptionML = ENU = 'Appreciation Bal. Account', FRA = 'Contrep. réévaluation';
        }
        modify("Custom 1 Expense Acc.")
        {
            CaptionML = ENU = 'Custom 1 Expense Acc.', FRA = 'Contrep. param. 1';
        }
        modify("Custom 2 Expense Acc.")
        {
            CaptionML = ENU = 'Custom 2 Expense Acc.', FRA = 'Contrep. param. 2';
        }
        modify("Sales Bal. Acc.")
        {
            CaptionML = ENU = 'Sales Bal. Acc.', FRA = 'Contrep. cession';
        }
        modify("Allocated Acquisition Cost %")
        {

            //Unsupported feature: Change CalcFormula on ""Allocated Acquisition Cost %"(Field 31)". Please convert manually.

            CaptionML = ENU = 'Allocated Acquisition Cost %', FRA = '% ventilation coût acq.';
        }
        modify("Allocated Depreciation %")
        {

            //Unsupported feature: Change CalcFormula on ""Allocated Depreciation %"(Field 32)". Please convert manually.

            CaptionML = ENU = 'Allocated Depreciation %', FRA = '% ventilation amortissement';
        }
        modify("Allocated Write-Down %")
        {

            //Unsupported feature: Change CalcFormula on ""Allocated Write-Down %"(Field 33)". Please convert manually.

            CaptionML = ENU = 'Allocated Write-Down %', FRA = '% ventilation dépréciation';
        }
        modify("Allocated Appreciation %")
        {

            //Unsupported feature: Change CalcFormula on ""Allocated Appreciation %"(Field 34)". Please convert manually.

            CaptionML = ENU = 'Allocated Appreciation %', FRA = '% ventilation réévaluation';
        }
        modify("Allocated Custom 1 %")
        {

            //Unsupported feature: Change CalcFormula on ""Allocated Custom 1 %"(Field 35)". Please convert manually.

            CaptionML = ENU = 'Allocated Custom 1 %', FRA = '% ventilation param. 1';
        }
        modify("Allocated Custom 2 %")
        {

            //Unsupported feature: Change CalcFormula on ""Allocated Custom 2 %"(Field 36)". Please convert manually.

            CaptionML = ENU = 'Allocated Custom 2 %', FRA = '% ventilation param. 2';
        }
        modify("Allocated Sales Price %")
        {

            //Unsupported feature: Change CalcFormula on ""Allocated Sales Price %"(Field 37)". Please convert manually.

            CaptionML = ENU = 'Allocated Sales Price %', FRA = '% ventilation prix vente';
        }
        modify("Allocated Maintenance %")
        {

            //Unsupported feature: Change CalcFormula on ""Allocated Maintenance %"(Field 38)". Please convert manually.

            CaptionML = ENU = 'Allocated Maintenance %', FRA = '% ventilation maintenance';
        }
        modify("Allocated Gain %")
        {

            //Unsupported feature: Change CalcFormula on ""Allocated Gain %"(Field 39)". Please convert manually.

            CaptionML = ENU = 'Allocated Gain %', FRA = '% ventilation gain';
        }
        modify("Allocated Loss %")
        {

            //Unsupported feature: Change CalcFormula on ""Allocated Loss %"(Field 40)". Please convert manually.

            CaptionML = ENU = 'Allocated Loss %', FRA = '% ventilation perte';
        }
        modify("Allocated Book Value % (Gain)")
        {

            //Unsupported feature: Change CalcFormula on ""Allocated Book Value % (Gain)"(Field 41)". Please convert manually.

            CaptionML = ENU = 'Allocated Book Value % (Gain)', FRA = '% ventilation valeur compta. (gain)';
        }
        modify("Allocated Book Value % (Loss)")
        {

            //Unsupported feature: Change CalcFormula on ""Allocated Book Value % (Loss)"(Field 42)". Please convert manually.

            CaptionML = ENU = 'Allocated Book Value % (Loss)', FRA = '% ventilation valeur compta. (perte)';
        }
        modify("Sales Acc. on Disp. (Loss)")
        {
            CaptionML = ENU = 'Sales Acc. on Disp. (Loss)', FRA = 'Cpte produits des cessions d''élts d''actif (perte)';
        }
        modify("Book Val. Acc. on Disp. (Loss)")
        {
            CaptionML = ENU = 'Book Val. Acc. on Disp. (Loss)', FRA = 'Compte valeurs des élts d''actif cédés (perte)';
        }

        //Unsupported feature: CodeModification on ""Acquisition Cost Account"(Field 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Acquisition Cost Account",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Acquisition Cost Account",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Accum. Depreciation Account"(Field 3).OnValidate". Please convert manually.

        //trigger  Depreciation Account"(Field 3)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Accum. Depreciation Account",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Accum. Depreciation Account",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Write-Down Account"(Field 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Write-Down Account",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Write-Down Account",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Appreciation Account"(Field 5).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Appreciation Account",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Appreciation Account",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Custom 1 Account"(Field 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Custom 1 Account",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Custom 1 Account",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Custom 2 Account"(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Custom 2 Account",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Custom 2 Account",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Acq. Cost Acc. on Disposal"(Field 8).OnValidate". Please convert manually.

        //trigger  Cost Acc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Acq. Cost Acc. on Disposal",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Acq. Cost Acc. on Disposal",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Accum. Depr. Acc. on Disposal"(Field 9).OnValidate". Please convert manually.

        //trigger  Depr();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Accum. Depr. Acc. on Disposal",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Accum. Depr. Acc. on Disposal",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Write-Down Acc. on Disposal"(Field 10).OnValidate". Please convert manually.

        //trigger  on Disposal"(Field 10)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Write-Down Acc. on Disposal",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Write-Down Acc. on Disposal",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Appreciation Acc. on Disposal"(Field 11).OnValidate". Please convert manually.

        //trigger  on Disposal"(Field 11)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Appreciation Acc. on Disposal",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Appreciation Acc. on Disposal",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Custom 1 Account on Disposal"(Field 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Custom 1 Account on Disposal",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Custom 1 Account on Disposal",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Custom 2 Account on Disposal"(Field 13).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Custom 2 Account on Disposal",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Custom 2 Account on Disposal",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Gains Acc. on Disposal"(Field 14).OnValidate". Please convert manually.

        //trigger  on Disposal"(Field 14)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Gains Acc. on Disposal",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Gains Acc. on Disposal",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Losses Acc. on Disposal"(Field 15).OnValidate". Please convert manually.

        //trigger  on Disposal"(Field 15)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Losses Acc. on Disposal",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Losses Acc. on Disposal",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Book Val. Acc. on Disp. (Gain)"(Field 16).OnValidate". Please convert manually.

        //trigger  Acc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Book Val. Acc. on Disp. (Gain)",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Book Val. Acc. on Disp. (Gain)",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Sales Acc. on Disp. (Gain)"(Field 17).OnValidate". Please convert manually.

        //trigger  on Disp();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Sales Acc. on Disp. (Gain)",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Sales Acc. on Disp. (Gain)",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Write-Down Bal. Acc. on Disp."(Field 18).OnValidate". Please convert manually.

        //trigger  Acc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Write-Down Bal. Acc. on Disp.",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Write-Down Bal. Acc. on Disp.",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Apprec. Bal. Acc. on Disp."(Field 19).OnValidate". Please convert manually.

        //trigger  Bal();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Apprec. Bal. Acc. on Disp.",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Apprec. Bal. Acc. on Disp.",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Custom 1 Bal. Acc. on Disposal"(Field 20).OnValidate". Please convert manually.

        //trigger  Acc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Custom 1 Bal. Acc. on Disposal",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Custom 1 Bal. Acc. on Disposal",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Custom 2 Bal. Acc. on Disposal"(Field 21).OnValidate". Please convert manually.

        //trigger  Acc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Custom 2 Bal. Acc. on Disposal",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Custom 2 Bal. Acc. on Disposal",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Maintenance Expense Account"(Field 22).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Maintenance Expense Account",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Maintenance Expense Account",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Maintenance Bal. Acc."(Field 23).OnValidate". Please convert manually.

        //trigger  Acc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Maintenance Bal. Acc.",TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Maintenance Bal. Acc.",true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Acquisition Cost Bal. Acc."(Field 24).OnValidate". Please convert manually.

        //trigger  Acc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Acquisition Cost Bal. Acc.",TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Acquisition Cost Bal. Acc.",true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Depreciation Expense Acc."(Field 25).OnValidate". Please convert manually.

        //trigger "(Field 25)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Depreciation Expense Acc.",TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Depreciation Expense Acc.",true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Write-Down Expense Acc."(Field 26).OnValidate". Please convert manually.

        //trigger "(Field 26)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Write-Down Expense Acc.",TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Write-Down Expense Acc.",true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Appreciation Bal. Account"(Field 27).OnValidate". Please convert manually.

        //trigger  Account"(Field 27)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Appreciation Bal. Account",TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Appreciation Bal. Account",true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Custom 1 Expense Acc."(Field 28).OnValidate". Please convert manually.

        //trigger "(Field 28)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Custom 1 Expense Acc.",TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Custom 1 Expense Acc.",true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Custom 2 Expense Acc."(Field 29).OnValidate". Please convert manually.

        //trigger "(Field 29)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Custom 2 Expense Acc.",TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Custom 2 Expense Acc.",true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Sales Bal. Acc."(Field 30).OnValidate". Please convert manually.

        //trigger  Acc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Sales Bal. Acc.",TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Sales Bal. Acc.",true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Sales Acc. on Disp. (Loss)"(Field 43).OnValidate". Please convert manually.

        //trigger  on Disp();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Sales Acc. on Disp. (Loss)",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Sales Acc. on Disp. (Loss)",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Book Val. Acc. on Disp. (Loss)"(Field 44).OnValidate". Please convert manually.

        //trigger  Acc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Book Val. Acc. on Disp. (Loss)",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Book Val. Acc. on Disp. (Loss)",false);
        */
        //end;
        // BC Upgrade NANDIS03 - Blocked French localisation fields >>
        // field(10800; "Derogatory Account"; Code[20])
        // {
        //     CaptionML = ENU = 'Derogatory Account',
        //                 FRA = 'Compte dérogatoire';
        //     Description = 'HEI.03';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Derogatory Account", false);
        //     end;
        // }
        // field(10801; "Derogatory Acc. (Decrease)"; Code[20])
        // {
        //     CaptionML = ENU = 'Derogatory Acc. (Decrease)',
        //                 FRA = 'Cpte dérogatoire (sortie)';
        //     Description = 'HEI.03';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Derogatory Acc. (Decrease)", false);
        //     end;
        // }
        // field(10802; "Derog. Bal. Acc. (Decrease)"; Code[20])
        // {
        //     CaptionML = ENU = 'Derog. Bal. Acc. (Decrease)',
        //                 FRA = 'Cpte de contrepartie dérog. (sortie)';
        //     Description = 'HEI.03';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Derog. Bal. Acc. (Decrease)", true);
        //     end;
        // }
        // field(10803; "Derogatory Expense Account"; Code[20])
        // {
        //     CaptionML = ENU = 'Derogatory Expense Account',
        //                 FRA = 'Cpte de charge dérogatoire';
        //     Description = 'HEI.03';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Derogatory Expense Account", true);
        //     end;
        // }
        // field(10804; "Allocated Derogatory %"; Decimal)
        // {
        //     CalcFormula = Sum("FA Allocation"."Allocation %" where(Code = FIELD(Code),
        //                                                             "Allocation Type" = CONST(Derogatory)));
        //     CaptionML = ENU = 'Allocated Derogatory %',
        //                 FRA = '% dérogatoire alloué';
        //     DecimalPlaces = 1 : 1;
        //     Description = 'HEI.03';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // BC Upgrade NANDIS03 - Blocked French localisation fields >>  <<
        field(50003; "Accum. Dep. Account Offset FND"; Code[20])
        {
            Caption = 'Accum. Depr Acc. Offset';
            Description = 'HEI.01';
            TableRelation = "G/L Account";
        }
        field(50004; "Dep. Expense Acc Offset FND"; Code[20])
        {
            Caption = 'Depreciation Exp. Acc. Offset';
            Description = 'HEI.01';
            TableRelation = "G/L Account";
        }
        field(50005; "Acqi.CostAcc.Dsposl Offset FND"; Code[20])
        {
            Caption = 'Acq. Cost On Disposal Offset';
            Description = 'HEI.01';
            TableRelation = "G/L Account";
        }
        field(50006; "GainAcc.on Disposal Offset FND"; Code[20])
        {
            Caption = 'Gains Acc. on Disposal Offset';
            Description = 'HEI.01';
            TableRelation = "G/L Account";
        }
        field(50007; "SaleBal.Acc.on Disp.Offset FND"; Code[20])
        {
            Caption = 'Sales Bal.Acc. on Disp. Offset';
            Description = 'HEI.01';
            TableRelation = "G/L Account";
        }
        field(50008; "Accum.Dep.onDisp.AccOffset FND"; Code[20])
        {
            Caption = 'Accum.Depr.Acc.Disposal Offset';
            Description = 'HEI.01';
            TableRelation = "G/L Account";
        }
        field(50009; "Losses Acc. on Disp. Off FND"; Code[20])
        {
            Caption = 'Losses Acc. on Disposal Offset';
            Description = 'HEI.01';
            TableRelation = "G/L Account";
        }
        field(50010; "Description FND"; Text[100])
        {
            Description = 'HEI.02';
            Caption = 'Description';
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FAAlloc.SETRANGE(Code,Code);
    FAAlloc.DELETEALL(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    FAAlloc.SETRANGE(Code,Code);
    FAAlloc.DELETEALL(true);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

