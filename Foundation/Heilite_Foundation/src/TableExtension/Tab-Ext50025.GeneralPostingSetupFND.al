tableextension 50025 GeneralPostingSetupExtFND extends "General Posting Setup"
{
    // version NAVW17.10,DITW110.00.11,HEI.06
    // DITW15.00.00.01 DDR 27/12/2007 Added fields Drink-it Item Charges functionnalities
    //                                  2034650 "Sales Tax Due Account"
    //                                  2034651 "Sales Tax Recover Account"
    //                                  2034660 "Purch. Tax Due Account"
    //                                  2034661 "Purch. Tax Recover Account"
    // DITW15.00.00.01 DDR 02/01/2008 reverse fields
    //                                  2034650 <> 2034651
    //                                  2034660 <> 2034661
    // DITW15.00.00.01 DDR 23/01/2008 Added Drink-it Discount & Promotion Item Charges functionnalities
    //                                Added fields
    //                                  2013769 Sales Provision Account
    //                                  2013770 Sales Accrual Provision Acc.
    //                                  2013771 Purch. Provision Account
    //                                  2013772 Purch. Accrual Provision Acc.
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.20 DDR 11/06/2008 Certification rules
    // DITW15.00.00.24 DDR 25/09/2008 Drink-it Internal Taxes functionnalities
    //                                Added fields
    //                                 2013690 Internal Tax Recover Account
    //                                 2013691 Internal Tax Due Account
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW110.00.11 SFI 30/08/2017 BL#14417 New fields
    //                                 2013610 "Deposit In Goods Sold Acc."
    //                                 2013611 "Deposit IGS Acc. (Interim)"
    //                                 2013612 "Direct Deposit Applied Account"
    //                                 2013613 "Deposit Accrual Acc. (Int.)"
    //                                 2013614 "Deposit Adjustment Acc."

    // HEI.01 FDD-HB446 CHG2023340 IBM SURYAS01 05.09.2019
    //   #Created New field - "Accrual Acc. (Interim)"
    // HEI.02 FDD-HT581 IBM SURYAS01 27.09.2019
    //   #Created New Field VAT on Free Expense account
    // HEI.03 FDD-HB1609 CHG2074002 IBM BULIMC01 26.08.2020 # 2 new fields added:
    //     #50002 - "Cost of Free Goods (HNK)"
    //     #50003 - "HNK Free Goods Offset Acc."
    // HEI.04 FDD-HB899 - CHG2093015 IBM NASTAA02  19.01.2021 # LSR - Sales And Payments
    //   # New Field created: 50004 - Sales Resource Cost Acc.
    // HEI.05 CHG2119679 IBM BHATTA09  08.09.2021
    //   # New Field created: 50005 - Accrual Account Landed Cost
    // HEI.06 CHG2193490 IBM SISUM01 26/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //  # Add new field Id: 50006 PPV Adjustment Account
    fields
    {
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("Sales Account")
        {
            CaptionML = ENU = 'Sales Account', FRA = 'Compte ventes';
        }
        modify("Sales Line Disc. Account")
        {
            CaptionML = ENU = 'Sales Line Disc. Account', FRA = 'Compte remise ligne vente';
        }
        modify("Sales Inv. Disc. Account")
        {
            CaptionML = ENU = 'Sales Inv. Disc. Account', FRA = 'Compte remise fact. vente';
        }
        modify("Sales Pmt. Disc. Debit Acc.")
        {
            CaptionML = ENU = 'Sales Pmt. Disc. Debit Acc.', FRA = 'Compte débit escompte vente';
        }
        modify("Purch. Account")
        {
            CaptionML = ENU = 'Purch. Account', FRA = 'Compte achats';
        }
        modify("Purch. Line Disc. Account")
        {
            CaptionML = ENU = 'Purch. Line Disc. Account', FRA = 'Compte remise ligne achat';
        }
        modify("Purch. Inv. Disc. Account")
        {
            CaptionML = ENU = 'Purch. Inv. Disc. Account', FRA = 'Compte remise fact. achat';
        }
        modify("Purch. Pmt. Disc. Credit Acc.")
        {
            CaptionML = ENU = 'Purch. Pmt. Disc. Credit Acc.', FRA = 'Compte crédit escompte achat';
        }
        modify("COGS Account")
        {
            CaptionML = ENU = 'COGS Account', FRA = 'Compte variation stock';
        }
        modify("Inventory Adjmt. Account")
        {
            CaptionML = ENU = 'Inventory Adjmt. Account', FRA = 'Compte ajust. stock';
        }
        modify("Sales Credit Memo Account")
        {
            CaptionML = ENU = 'Sales Credit Memo Account', FRA = 'Compte avoir vente';
        }
        modify("Purch. Credit Memo Account")
        {
            CaptionML = ENU = 'Purch. Credit Memo Account', FRA = 'Compte avoir achat';
        }
        modify("Sales Pmt. Disc. Credit Acc.")
        {
            CaptionML = ENU = 'Sales Pmt. Disc. Credit Acc.', FRA = 'Compte crédit escompte vente';
        }
        modify("Purch. Pmt. Disc. Debit Acc.")
        {
            CaptionML = ENU = 'Purch. Pmt. Disc. Debit Acc.', FRA = 'Compte débit escompte achat';
        }
        modify("Sales Pmt. Tol. Debit Acc.")
        {
            CaptionML = ENU = 'Sales Pmt. Tol. Debit Acc.', FRA = 'Cpte écart règl. vente débit';
        }
        modify("Sales Pmt. Tol. Credit Acc.")
        {
            CaptionML = ENU = 'Sales Pmt. Tol. Credit Acc.', FRA = 'Cpte écart règl. vente crédit';
        }
        modify("Purch. Pmt. Tol. Debit Acc.")
        {
            CaptionML = ENU = 'Purch. Pmt. Tol. Debit Acc.', FRA = 'Cpte écart règl. achat débit';
        }
        modify("Purch. Pmt. Tol. Credit Acc.")
        {
            CaptionML = ENU = 'Purch. Pmt. Tol. Credit Acc.', FRA = 'Cpte écart règl. achat crédit';
        }
        modify("Sales Prepayments Account")
        {
            CaptionML = ENU = 'Sales Prepayments Account', FRA = 'Compte acomptes vente';
        }
        modify("Purch. Prepayments Account")
        {
            CaptionML = ENU = 'Purch. Prepayments Account', FRA = 'Compte acomptes achat';
        }
        modify("Purch. FA Disc. Account")
        {
            CaptionML = ENU = 'Purch. FA Disc. Account', FRA = 'Compte remise achat immo.';
        }
        modify("Invt. Accrual Acc. (Interim)")
        {
            CaptionML = ENU = 'Invt. Accrual Acc. (Interim)', FRA = 'Compte ajust. stock (attente)';
        }
        modify("COGS Account (Interim)")
        {
            CaptionML = ENU = 'COGS Account (Interim)', FRA = 'Compte variation stock (attente)';
        }
        modify("Direct Cost Applied Account")
        {
            CaptionML = ENU = 'Direct Cost Applied Account', FRA = 'Compte coût direct lettré';
        }
        modify("Overhead Applied Account")
        {
            CaptionML = ENU = 'Overhead Applied Account', FRA = 'Compte frais généraux lettrés';
        }
        modify("Purchase Variance Account")
        {
            CaptionML = ENU = 'Purchase Variance Account', FRA = 'Compte écart achat';
        }

        //Unsupported feature: CodeModification on ""Sales Pmt. Disc. Debit Acc."(Field 13).OnValidate". Please convert manually.

        //trigger  Disc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Sales Pmt. Disc. Debit Acc.");
        IF "Sales Pmt. Disc. Debit Acc." <> '' THEN BEGIN
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Sales Pmt. Disc. Debit Acc.");
        if "Sales Pmt. Disc. Debit Acc." <> '' then begin
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",true);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Purch. Pmt. Disc. Credit Acc."(Field 17).OnValidate". Please convert manually.

        //trigger  Pmt();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Purch. Pmt. Disc. Credit Acc.");
        IF "Purch. Pmt. Disc. Credit Acc." <> '' THEN BEGIN
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Purch. Pmt. Disc. Credit Acc.");
        if "Purch. Pmt. Disc. Credit Acc." <> '' then begin
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",true);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Sales Pmt. Disc. Credit Acc."(Field 30).OnValidate". Please convert manually.

        //trigger  Disc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Sales Pmt. Disc. Credit Acc.");
        IF "Sales Pmt. Disc. Credit Acc." <> '' THEN BEGIN
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Sales Pmt. Disc. Credit Acc.");
        if "Sales Pmt. Disc. Credit Acc." <> '' then begin
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",true);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Purch. Pmt. Disc. Debit Acc."(Field 31).OnValidate". Please convert manually.

        //trigger  Pmt();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Purch. Pmt. Disc. Debit Acc.");
        IF "Purch. Pmt. Disc. Debit Acc." <> '' THEN BEGIN
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Purch. Pmt. Disc. Debit Acc.");
        if "Purch. Pmt. Disc. Debit Acc." <> '' then begin
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",true);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Sales Pmt. Tol. Debit Acc."(Field 32).OnValidate". Please convert manually.

        //trigger  Tol();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Sales Pmt. Tol. Debit Acc.");
        IF "Purch. Pmt. Disc. Debit Acc." <> '' THEN BEGIN
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Sales Pmt. Tol. Debit Acc.");
        if "Purch. Pmt. Disc. Debit Acc." <> '' then begin
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",true);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Sales Pmt. Tol. Credit Acc."(Field 33).OnValidate". Please convert manually.

        //trigger  Tol();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Sales Pmt. Tol. Credit Acc.");
        IF "Purch. Pmt. Disc. Debit Acc." <> '' THEN BEGIN
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Sales Pmt. Tol. Credit Acc.");
        if "Purch. Pmt. Disc. Debit Acc." <> '' then begin
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",true);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Purch. Pmt. Tol. Debit Acc."(Field 34).OnValidate". Please convert manually.

        //trigger  Pmt();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Purch. Pmt. Tol. Debit Acc.");
        IF "Purch. Pmt. Disc. Debit Acc." <> '' THEN BEGIN
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Purch. Pmt. Tol. Debit Acc.");
        if "Purch. Pmt. Disc. Debit Acc." <> '' then begin
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",true);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Purch. Pmt. Tol. Credit Acc."(Field 35).OnValidate". Please convert manually.

        //trigger  Pmt();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Purch. Pmt. Tol. Credit Acc.");
        IF "Purch. Pmt. Disc. Debit Acc." <> '' THEN BEGIN
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Purch. Pmt. Tol. Credit Acc.");
        if "Purch. Pmt. Disc. Debit Acc." <> '' then begin
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",true);
        end;
        */
        //end;
        field(50000; "Accrual Acc. (Interim) FND"; Code[20])
        {
            CaptionML = ENU = 'GL Accrual Acc. (Interim)',
                        FRA = 'FNP pour comptes généraux  (attente)';
            Description = 'HEI.01';
            TableRelation = "G/L Account";
        }
        field(50001; "VAT on Free Expense Acc. FND"; Code[20])
        {
            Description = 'HEI.02';
            Caption = 'VAT on Free Expense Account';
            TableRelation = "G/L Account";
        }
        field(50002; "Cost of Free Goods (HNK) FND"; Code[20])
        {
            Description = 'HEI.03';
            Caption = 'Cost of Free Goods (HNK)';
            TableRelation = "G/L Account";
        }
        field(50003; "HNK Free Goods Offset Acc. FND"; Code[20])
        {
            Description = 'HEI.03';
            Caption = 'HNK Free Goods Offset Account';
            TableRelation = "G/L Account";
        }
        field(50004; "Sales Resource Cost Acc. FND"; Code[20])
        {
            Caption = 'Sales Resource Cost Account';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "G/L Account";
        }
        field(50005; "Accrual Acc. Landed Cost FND"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
            Caption = 'Accrual Account Landed Cost';
            TableRelation = "G/L Account";
        }
        field(50006; "PPV Adjustment Account FND"; Code[20])
        {
            Caption = 'PPV Adjustment Account';
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
            TableRelation = "G/L Account"."No.";
        }
        // field(2013610; "Deposit In Goods Sold Acc."; Code[20])
        // {
        //     Caption = 'Deposit In Goods Sold Account';
        //     Description = 'DITW110.00.11 BL#14417';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Deposit In Goods Sold Acc.");
        //     end;
        // }
        // field(2013611; "Deposit IGS Acc. (Interim)"; Code[20])
        // {
        //     Caption = 'Deposit In Goods Sold Account (Interim)';
        //     Description = 'DITW110.00.11 BL#14417';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Deposit IGS Acc. (Interim)");
        //     end;
        // }
        // field(2013612; "Direct Deposit Applied Account"; Code[20])
        // {
        //     Caption = 'Direct Deposit Applied Account';
        //     Description = 'DITW110.00.11 BL#14417';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Direct Deposit Applied Account");
        //     end;
        // }
        // field(2013613; "Deposit Accrual Acc. (Int.)"; Code[20])
        // {
        //     Caption = 'Deposit Accrual Account (Interim)';
        //     Description = 'DITW110.00.11 BL#14417';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Deposit Accrual Acc. (Int.)");
        //     end;
        // }
        // field(2013614; "Deposit Adjustment Acc."; Code[20])
        // {
        //     Caption = 'Deposit Adjustment Account';
        //     Description = 'DITW110.00.11 BL#14417';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Deposit Adjustment Acc.");
        //     end;
        // }
        // field(2013670; "Sales Tax Recover Account"; Code[20])
        // {
        //     CaptionML = ENU = 'Sales Tax Recover Account',
        //                 FRA = 'Compte récupération taxe vente';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Sales Tax Recover Account");
        //     end;
        // }
        // field(2013671; "Sales Tax Due Account"; Code[20])
        // {
        //     CaptionML = ENU = 'Sales Tax Due Account',
        //                 FRA = 'Compte taxe due vente';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Sales Tax Due Account");
        //     end;
        // }
        // field(2013680; "Purch. Tax Recover Account"; Code[20])
        // {
        //     CaptionML = ENU = 'Purch. Tax Recover Account',
        //                 FRA = 'Compte récupération taxe achat';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Purch. Tax Recover Account");
        //     end;
        // }
        // field(2013681; "Purch. Tax Due Account"; Code[20])
        // {
        //     CaptionML = ENU = 'Purch. Tax Due Account',
        //                 FRA = 'Compte taxe due achat';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Purch. Tax Due Account");
        //     end;
        // }
        // field(2013690; "Internal Tax Recover Account"; Code[20])
        // {
        //     CaptionML = ENU = 'Internal Tax Recover Account',
        //                 FRA = 'Compte interne récupération taxe';
        //     Description = 'DITW15.00.00.24';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Internal Tax Recover Account");
        //     end;
        // }
        // field(2013691; "Internal Tax Due Account"; Code[20])
        // {
        //     CaptionML = ENU = 'Internal Tax Due Account',
        //                 FRA = 'Compte interne taxe due';
        //     Description = 'DITW15.00.00.24';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Internal Tax Due Account");
        //     end;
        // }
        // field(2013769; "Sales Provision Account"; Code[20])
        // {
        //     CaptionML = ENU = 'Sales Provision Account',
        //                 FRA = 'Compte provision vente';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Sales Provision Account");
        //     end;
        // }
        // field(2013770; "Sales Accrual Provision Acc."; Code[20])
        // {
        //     CaptionML = ENU = 'Sales Accrual Provision Account',
        //                 FRA = 'Compte ajust. provision vente';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Sales Accrual Provision Acc.");
        //     end;
        // }
        // field(2013771; "Purch. Provision Account"; Code[20])
        // {
        //     CaptionML = ENU = 'Purch. Provision Account',
        //                 FRA = 'Compte provision achat';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Purch. Provision Account");
        //     end;
        // }
        // field(2013772; "Purch. Accrual Provision Acc."; Code[20])
        // {
        //     CaptionML = ENU = 'Purch. Accrual Provision Account',
        //                 FRA = 'Compte ajust. provision achat';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Purch. Accrual Provision Acc.");
        //     end;
        // }  // BC Upgrade NANDIS03
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

