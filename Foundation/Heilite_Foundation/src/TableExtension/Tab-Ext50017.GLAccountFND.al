tableextension 50017 GLAccountExtFND extends "G/L Account"
{
    // version NAVW110.0.00.15601,FINXL10.00,DITW110.00.09,HEI.07,HEI.20

    // DITW15.00.00.01 DDR 22/01/2008 Added Drink-it functionnalities
    //                                Added field "Collapse"
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327 Added fields
    //                                               2034850 DIT Sub-Contract Type Filter
    //                                               2034915 Contract DIT Filter
    //                                               2014312 DIT Sub-Contract Posting Type
    //                                             Modified 'CalcFormula' property fields
    //                                               Amount,Debit Amount,Credit Amount,Additional-Currency Amount,
    //                                               Add.-Currency Debit Amount,Add.-Currency Credit Amount
    // DITW16.00.00.41 AHU 13/08/2012 DIT-715 #327 Remove checking on field2014312 "DIT Sub-Contract Posting Type"
    // FINXL7.00.001 RBE 25/03/2013 : Created field 2029610
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05 YHE 12/09/2014 DIT-770 #758 : Remove cheecking on the filed14."Direct Posting"
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368  Rename Caption "DIT Contract Posting Type" to "Financial Contract Posting Type"
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties
    // DITW19.00.08 SFI 18/08/2016 BL#10868  (DIT-770 #2141) New field 2014411 "Allow Invoice Disc."
    //                                                       Extended function SetupNewGLAcc

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4

    // HEI.01 RTRGAP038 IBM.CHAUHB01 02/08/17 Added field from 50000 to 50005
    // HEI.02 FDD RTRGAP062 Heilite BASE IBM ISYED01 04/08/2017 HeiMatch Flatfile
    //   # Added new filed Std. Invoice Reference
    //   # Added new filed HeiMatch Code
    //   # Added new filed Export HeiMatch Payments
    // HEI.03 FDD RTRGAP047 Heilite BASE IBM ISYED01 07/08/2017 G/L account Creation
    //   # Added new filed CIL account
    //   # Added new filed Local Name
    // HEI.04 FDD-SLSGAP001 IBM POENAB01 19.08.2017 # MDM Customer Card
    //   # New fields:
    //     - 50017 WHT Business Posting Group
    //     - 50018 WHT Product Posting Group
    // HEI.05 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Added fileds "No Trading Partner","Posting Heineken","CIL3 Code","MR Code" table
    // HEI.06 FDD-RTRGAP001 IBM CHAUHB01 18.09.2017
    //   #Added fileds Cadency Transaction Export,Cadency Bank Export
    // HEI.07 FDD_Rwanda_Bralirwa_Esker_ Interface_V0.3_HT75 IBM POSTOI01
    //   # new key Direct Posting, Account Type,Blocked
    // HEI.08 CHG0248106 IBM POENAB02 #Heimatch
    //   # added filed Heimatch Sign to the table.
    // HEI.09 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New 10810 field G/L Entry Type Filter
    //   # Code added in No. - OnValidate
    // HEI.10 FDD-HT670 BULIMC01 30.09.2019 #new boolean field 50024 - "VAT Account" added
    // HEI.11 FDD-HT671 BULIMC01 07.10.2019 #new boolean field 50024 - "WHT Account" added
    // HEI.12 FDD-HT1143 SURYAS01  02.07.2020
    //   #Created New Field "Non Deductible VAT %"
    // HEI.13 CHG2065276 BULIMC01 IBM 29.09.2020 #new field created: 50027 - "Same Comment"
    // HEI.14 FDD-HT1330 IBM BULIMC01 08.02.2021 #Haiti new dimension - Maision Des Vins
    //     #new flowfilter added - "Maision des Vins Dim. Filter"
    //     #added to "CalcFormula" property for the next fields: Balance at Date, Net Change, Balance, Debit Amount, Credit Amount
    // HEI.15 CHG2093754 IBM PANDES01 23.02.2021
    //   # Added new field C&TP CODE.
    // HEI.16 CHG2255465 IBM YADAVM09 19/06/2024#Change required in HeiMatch sign values in COA
    // options string for field HeiMatch Sign updated
    // HEI.17 CHG2210794 MAJUMS03 22.01.2024 Zycus - BASE HL Integration Master Vendor and GL Account (*RLPPD)
    //   # Code added.
    //   # New Function "UpdateLocaltimestamp" is added.
    // HEI.18 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //   # New Field created #H&S Levy Tax Posting Group
    // HEI.19 CHG2210794 MAJUMS03 13.05.2024 Zycus - BASE HL Integration - Vendor GL Account Development Rework.
    //   # Code added.
    // HEI.20 CHG2210794 MAJUMS03 04.09.2024 Zycus - BASE HL Integration - Vendor GL Account Development Finetuning.
    //   # Code added.
    //   # New Function "CheckZycusEnable" is added
    // HEI.21 CHG2293817 SAHAL01 19.03.2025 Zycus - E2E test for Zycus HL integration - G/L CMG Rule Map
    //   # Added Code

    //Bc Upgrade YADAVM09 Optionmember and option caption corrected for field "Financial Statement version"
    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.09>>
                CompanyInfo.GET();
                IF CompanyInfo."Enable French Localization FND" THEN
                    CASE "No."[1] OF
                        '1' .. '5':
                            "Income/Balance" := "Income/Balance"::"Balance Sheet";
                        '6' .. '9':
                            "Income/Balance" := "Income/Balance"::"Income Statement";
                        else
                            ERROR(Text10800, FIELDCAPTION("No."));
                    end;
                //HEI.09<<
            end;
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Search Name")
        {
            CaptionML = ENU = 'Search Name', FRA = 'Nom de recherche';
        }
        modify("Account Type")
        {
            CaptionML = ENU = 'Account Type', FRA = 'Type compte';
            // OptionCaptionML = ENU = 'Posting,Heading,Total,Begin-Total,End-Total', FRA = 'Imputable,Titre,Total,Début total,Fin total';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 6)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Account Category")
        {
            CaptionML = ENU = 'Account Category', FRA = 'Catégorie du compte';
            //OptionCaptionML = ENU = ' ,Assets,Liabilities,Equity,Income,Cost of Goods Sold,Expense', FRA = ' ,Immobilisations,Emprunts et dettes,Capitaux propres,Revenus,Coût des marchandises vendues,Dépenses';
        }
        modify("Income/Balance")
        {
            CaptionML = ENU = 'Income/Balance', FRA = 'Gestion/Bilan';
            // OptionCaptionML = ENU = 'Income Statement,Balance Sheet', FRA = 'Gestion,Bilan';
        }
        modify("Debit/Credit")
        {
            CaptionML = ENU = 'Debit/Credit', FRA = 'Débit/Crédit';
            OptionCaptionML = ENU = 'Both,Debit,Credit', FRA = 'Les deux,Débit,Crédit';
        }
        modify("No. 2")
        {
            CaptionML = ENU = 'No. 2', FRA = 'N° 2';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 12)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
        }
        modify("Direct Posting")
        {

            //Unsupported feature: Change InitValue on ""Direct Posting"(Field 14)". Please convert manually.

            CaptionML = ENU = 'Direct Posting', FRA = 'Imputation directe';
        }
        modify("Reconciliation Account")
        {
            CaptionML = ENU = 'Reconciliation Account', FRA = 'Compte de simulation';
        }
        modify("New Page")
        {
            CaptionML = ENU = 'New Page', FRA = 'Nouvelle page';
        }
        modify("No. of Blank Lines")
        {
            CaptionML = ENU = 'No. of Blank Lines', FRA = 'Nbre lignes blanches';
        }
        modify(Indentation)
        {
            CaptionML = ENU = 'Indentation', FRA = 'Indentation';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Global Dimension 1 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Filter"(Field 29)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Filter', FRA = 'Filtre axe principal 1';
        }
        modify("Global Dimension 2 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Filter"(Field 30)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Filter', FRA = 'Filtre axe principal 2';
        }
        modify("Balance at Date")
        {

            //Unsupported feature: Change CalcFormula on ""Balance at Date"(Field 31)". Please convert manually.

            CaptionML = ENU = 'Balance at Date', FRA = 'Solde au';

            //Unsupported feature: Change Description on ""Balance at Date"(Field 31)". Please convert manually.

        }
        modify("Net Change")
        {

            //Unsupported feature: Change CalcFormula on ""Net Change"(Field 32)". Please convert manually.

            CaptionML = ENU = 'Net Change', FRA = 'Solde période';

            //Unsupported feature: Change Description on ""Net Change"(Field 32)". Please convert manually.

        }
        modify("Budgeted Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Budgeted Amount"(Field 33)". Please convert manually.

            CaptionML = ENU = 'Budgeted Amount', FRA = 'Montant budgété';
        }
        modify(Totaling)
        {
            CaptionML = ENU = 'Totaling', FRA = 'Totalisation';
        }
        modify("Budget Filter")
        {
            CaptionML = ENU = 'Budget Filter', FRA = 'Filtre budget';
        }
        modify(Balance)
        {

            //Unsupported feature: Change CalcFormula on "Balance(Field 36)". Please convert manually.

            CaptionML = ENU = 'Balance', FRA = 'Solde';

            //Unsupported feature: Change Description on "Balance(Field 36)". Please convert manually.

        }
        modify("Budget at Date")
        {

            //Unsupported feature: Change CalcFormula on ""Budget at Date"(Field 37)". Please convert manually.

            CaptionML = ENU = 'Budget at Date', FRA = 'Budget période';
        }
        modify("Consol. Translation Method")
        {
            CaptionML = ENU = 'Consol. Translation Method', FRA = 'Consolider la méthode de traduction';
            OptionCaptionML = ENU = 'Average Rate (Manual),Closing Rate,Historical Rate,Composite Rate,Equity Rate', FRA = 'Taux moyen (manuel),Cours de clôture,Taux historique,Taux composite,Taux des fonds propres';
        }
        modify("Consol. Debit Acc.")
        {
            CaptionML = ENU = 'Consol. Debit Acc.', FRA = 'Compte débit consolidation';
        }
        modify("Consol. Credit Acc.")
        {
            CaptionML = ENU = 'Consol. Credit Acc.', FRA = 'Compte crédit consolidation';
        }
        modify("Business Unit Filter")
        {
            CaptionML = ENU = 'Business Unit Filter', FRA = 'Filtre centre de profit';
        }
        modify("Gen. Posting Type")
        {
            CaptionML = ENU = 'Gen. Posting Type', FRA = 'Type compta. TVA';
            //  OptionCaptionML = ENU = ' ,Purchase,Sale', FRA = ' ,Achat,Vente';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify(Picture)
        {
            CaptionML = ENU = 'Picture', FRA = 'Image';
        }
        modify("Debit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Debit Amount"(Field 47)". Please convert manually.

            CaptionML = ENU = 'Debit Amount', FRA = 'Montant débit';

            //Unsupported feature: Change Description on ""Debit Amount"(Field 47)". Please convert manually.

        }
        modify("Credit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Credit Amount"(Field 48)". Please convert manually.

            CaptionML = ENU = 'Credit Amount', FRA = 'Montant crédit';

            //Unsupported feature: Change Description on ""Credit Amount"(Field 48)". Please convert manually.

        }
        modify("Automatic Ext. Texts")
        {
            CaptionML = ENU = 'Automatic Ext. Texts', FRA = 'Textes étendus automatiques';
        }
        modify("Budgeted Debit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Budgeted Debit Amount"(Field 52)". Please convert manually.

            CaptionML = ENU = 'Budgeted Debit Amount', FRA = 'Montant débit budgété';
        }
        modify("Budgeted Credit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Budgeted Credit Amount"(Field 53)". Please convert manually.

            CaptionML = ENU = 'Budgeted Credit Amount', FRA = 'Montant crédit budgété';
        }
        modify("Tax Area Code")
        {
            CaptionML = ENU = 'Tax Area Code', FRA = 'Code zone recouvrement';
        }
        modify("Tax Liable")
        {
            CaptionML = ENU = 'Tax Liable', FRA = 'Soumis à recouvrement';
        }
        modify("Tax Group Code")
        {
            CaptionML = ENU = 'Tax Group Code', FRA = 'Code groupe taxes';
        }
        modify("VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify("VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'VAT Prod. Posting Group', FRA = 'Groupe compta. produit TVA';
        }
        modify("Additional-Currency Net Change")
        {

            //Unsupported feature: Change CalcFormula on ""Additional-Currency Net Change"(Field 60)". Please convert manually.

            CaptionML = ENU = 'Additional-Currency Net Change', FRA = 'Solde période DR';
        }
        modify("Add.-Currency Balance at Date")
        {

            //Unsupported feature: Change CalcFormula on ""Add.-Currency Balance at Date"(Field 61)". Please convert manually.

            CaptionML = ENU = 'Add.-Currency Balance at Date', FRA = 'Solde au DR';
        }
        modify("Additional-Currency Balance")
        {

            //Unsupported feature: Change CalcFormula on ""Additional-Currency Balance"(Field 62)". Please convert manually.

            CaptionML = ENU = 'Additional-Currency Balance', FRA = 'Solde DR';
        }
        modify("Exchange Rate Adjustment")
        {
            CaptionML = ENU = 'Exchange Rate Adjustment', FRA = 'Ajustement taux de change';
            //  OptionCaptionML = ENU = 'No Adjustment,Adjust Amount,Adjust Additional-Currency Amount', FRA = 'Aucun ajustement,Ajuster montant,Ajuster montant DR';
        }
        modify("Add.-Currency Debit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Add.-Currency Debit Amount"(Field 64)". Please convert manually.

            CaptionML = ENU = 'Add.-Currency Debit Amount', FRA = 'Montant débit DR';
        }
        modify("Add.-Currency Credit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Add.-Currency Credit Amount"(Field 65)". Please convert manually.

            CaptionML = ENU = 'Add.-Currency Credit Amount', FRA = 'Montant crédit DR';
        }
        modify("Default IC Partner G/L Acc. No")
        {

            //Unsupported feature: Change TableRelation on ""Default IC Partner G/L Acc. No"(Field 66)". Please convert manually.

            CaptionML = ENU = 'Default IC Partner G/L Acc. No', FRA = 'N° cpte gén par déf parten IC';
        }
        modify("Omit Default Descr. in Jnl.")
        {
            CaptionML = ENU = 'Omit Default Descr. in Jnl.', FRA = 'Omettre la descr. par défaut dans la feuille';
        }
        modify("Account Subcategory Entry No.")
        {
            CaptionML = ENU = 'Account Subcategory Entry No.', FRA = 'N° écriture de sous-catégorie du compte';
        }
        modify("Account Subcategory Descript.")
        {

            //Unsupported feature: Change CalcFormula on ""Account Subcategory Descript."(Field 81)". Please convert manually.

            CaptionML = ENU = 'Account Subcategory Descript.', FRA = 'Description de sous-catégorie du compte';
        }
        modify("Cost Type No.")
        {
            CaptionML = ENU = 'Cost Type No.', FRA = 'N° type coût';
        }
        modify("Default Deferral Template Code")
        {
            CaptionML = ENU = 'Default Deferral Template Code', FRA = 'Code modèle échelonnement par défaut';
        }

        //Unsupported feature: CodeInsertion on ""No."(Field 1)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.09>>
        CompanyInfo.GET;
        if CompanyInfo."Enable French Localization" then
          case "No."[1] of
            '1'..'5': "Income/Balance" := "Income/Balance"::"Balance Sheet";
            '6'..'9': "Income/Balance" := "Income/Balance"::"Income Statement";
            else
              ERROR(Text10800,FIELDCAPTION("No."));
          end;
        //HEI.09<<
        */
        //end;


        //Unsupported feature: CodeModification on "Name(Field 2).OnValidate". Please convert manually.

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
        "Temp Description" := Name;//TMA
        */
        //end;


        //Unsupported feature: CodeModification on ""Account Type"(Field 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Account Type" <> "Account Type"::Posting) AND
           (xRec."Account Type" = xRec."Account Type"::Posting)
        THEN BEGIN
          GLEntry.SETRANGE("G/L Account No.","No.");
          IF NOT GLEntry.ISEMPTY THEN
            ERROR(
              Text000,
              FIELDCAPTION("Account Type"));
          GLBudgetEntry.SETRANGE("G/L Account No.","No.");
          IF NOT GLBudgetEntry.ISEMPTY THEN
            ERROR(
              Text001,
              FIELDCAPTION("Account Type"));
        end;
        Totaling := '';
        IF "Account Type" = "Account Type"::Posting THEN BEGIN
          IF "Account Type" <> xRec."Account Type" THEN
            "Direct Posting" := TRUE;
        end else
          "Direct Posting" := FALSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Account Type" <> "Account Type"::Posting) and
           (xRec."Account Type" = xRec."Account Type"::Posting)
        then begin
          GLEntry.SETRANGE("G/L Account No.","No.");
          if not GLEntry.ISEMPTY then
        #6..9
          if not GLBudgetEntry.ISEMPTY then
        #11..13
        end;
        Totaling := '';
        if "Account Type" = "Account Type"::Posting then begin
          if "Account Type" <> xRec."Account Type" then
            "Direct Posting" := true;
        end else
          "Direct Posting" := false;
        */
        //end;


        //Unsupported feature: CodeModification on ""Account Category"(Field 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Account Category" = "Account Category"::" " THEN
          EXIT;

        IF "Account Category" IN ["Account Category"::Income,"Account Category"::"Cost of Goods Sold","Account Category"::Expense] THEN
          "Income/Balance" := "Income/Balance"::"Income Statement"
        else
          "Income/Balance" := "Income/Balance"::"Balance Sheet";
        IF "Account Category" <> xRec."Account Category" THEN
          "Account Subcategory Entry No." := 0;

        UpdateAccountCategoryOfSubAccounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Account Category" = "Account Category"::" " then
          exit;

        if "Account Category" in ["Account Category"::Income,"Account Category"::"Cost of Goods Sold","Account Category"::Expense] then
          "Income/Balance" := "Income/Balance"::"Income Statement"
        else
          "Income/Balance" := "Income/Balance"::"Balance Sheet";
        if "Account Category" <> xRec."Account Category" then
        #9..11
        */
        //end;


        //Unsupported feature: CodeModification on ""Income/Balance"(Field 9).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Income/Balance" = "Income/Balance"::"Balance Sheet") AND ("Cost Type No." <> '') THEN BEGIN
          IF CostType.GET("No.") THEN BEGIN
            CostType."G/L Account Range" := '';
            CostType.MODIFY;
          end;
          "Cost Type No." := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Income/Balance" = "Income/Balance"::"Balance Sheet") and ("Cost Type No." <> '') then begin
          if CostType.GET("No.") then begin
            CostType."G/L Account Range" := '';
            CostType.MODIFY;
          end;
          "Cost Type No." := '';
        end;
        */
        //end;


        //Unsupported feature: CodeModification on "Totaling(Field 34).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT ("Account Type" IN ["Account Type"::Total,"Account Type"::"End-Total"]) THEN
          FIELDERROR("Account Type");
        CALCFIELDS(Balance);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not ("Account Type" in ["Account Type"::Total,"Account Type"::"End-Total"]) then
          FIELDERROR("Account Type");
        CALCFIELDS(Balance);
        */
        //end;


        //Unsupported feature: CodeModification on ""Consol. Translation Method"(Field 39).OnValidate". Please convert manually.

        //trigger  Translation Method"(Field 39)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF TranslationMethodConflict(ConflictGLAcc) THEN
          IF ConflictGLAcc.GETFILTER("Consol. Debit Acc.") <> '' THEN
            MESSAGE(
              Text002,ConflictGLAcc.TABLECAPTION,ConflictGLAcc."No.",ConflictGLAcc.FIELDCAPTION("Consol. Debit Acc."),
              ConflictGLAcc.FIELDCAPTION("Consol. Translation Method"),ConflictGLAcc."Consol. Translation Method")
          else
            MESSAGE(
              Text002,ConflictGLAcc.TABLECAPTION,ConflictGLAcc."No.",ConflictGLAcc.FIELDCAPTION("Consol. Credit Acc."),
              ConflictGLAcc.FIELDCAPTION("Consol. Translation Method"),ConflictGLAcc."Consol. Translation Method");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if TranslationMethodConflict(ConflictGLAcc) then
          if ConflictGLAcc.GETFILTER("Consol. Debit Acc.") <> '' then
        #3..5
          else
        #7..9
        */
        //end;


        //Unsupported feature: CodeModification on ""Consol. Debit Acc."(Field 40).OnValidate". Please convert manually.

        //trigger  Debit Acc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF TranslationMethodConflict(ConflictGLAcc) THEN
          MESSAGE(
            Text002,ConflictGLAcc.TABLECAPTION,ConflictGLAcc."No.",ConflictGLAcc.FIELDCAPTION("Consol. Debit Acc."),
            ConflictGLAcc.FIELDCAPTION("Consol. Translation Method"),ConflictGLAcc."Consol. Translation Method");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if TranslationMethodConflict(ConflictGLAcc) then
        #2..4
        */
        //end;


        //Unsupported feature: CodeModification on ""Consol. Credit Acc."(Field 41).OnValidate". Please convert manually.

        //trigger  Credit Acc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF TranslationMethodConflict(ConflictGLAcc) THEN
          MESSAGE(
            Text002,ConflictGLAcc.TABLECAPTION,ConflictGLAcc."No.",ConflictGLAcc.FIELDCAPTION("Consol. Credit Acc."),
            ConflictGLAcc.FIELDCAPTION("Consol. Translation Method"),ConflictGLAcc."Consol. Translation Method");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if TranslationMethodConflict(ConflictGLAcc) then
        #2..4
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Bus. Posting Group"(Field 44).OnValidate". Please convert manually.

        //trigger  Bus();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
          IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
            VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
          if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") then
            VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Prod. Posting Group"(Field 45).OnValidate". Please convert manually.

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


        //Unsupported feature: CodeModification on ""Account Subcategory Entry No."(Field 80).OnValidate". Please convert manually.

        //trigger "(Field 80)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Account Subcategory Entry No." = 0 THEN
          EXIT;
        GLAccountCategory.GET("Account Subcategory Entry No.");
        TESTFIELD("Income/Balance",GLAccountCategory."Income/Balance");
        "Account Category" := GLAccountCategory."Account Category";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Account Subcategory Entry No." = 0 then
          exit;
        #3..5
        */
        //end;
        // field(10810; "G/L Entry Type Filter"; Option)
        // {
        //     CaptionML = ENU = 'G/L Entry Type Filter',
        //                 FRA = 'Filtre type écriture';
        //     Description = 'HEI.09';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU = 'Definitive,Simulation',
        //                       FRA = 'Définitive,Simulation';
        //     OptionMembers = Definitive,Simulation;
        // }  // BC Upgrade NANDIS03
        field(50000; "Temp Description FND"; Text[100])
        {
            Description = 'TMA: Temporary table till naming problem will be solved.';
            Caption = 'Temp Description';
        }
        field(50001; "Test Description FND"; Text[100])
        {
            Description = 'SFA: temp field';
            Caption = 'Test Description';
        }
        field(50002; "Std. Invoice Reference FND"; Code[20])
        {
            CaptionML = ENU = 'Std. Invoice Reference',
                        FRA = 'Référence facture standard';
            Description = 'HEI.02 RTRGAP062';
        }
        field(50003; "HeiMatch Code FND"; Code[20])
        {
            Caption = 'HeiMatch Code';
            Description = 'HEI.02 RTRGAP062';
        }
        field(50004; "Automatic application mode FND"; Option)
        {
            Description = 'RTRGAP038';
            OptionCaptionML = ENU = ' ,Purchase Prepayment,Sales Prepayment,AR Control Account,AP Control Account,GS/IS Accounts Receivable,GR/IR Accounts Payable,Selection Criteria',
                              FRA = ' ,Purchase Prepayment,Sales Prepayment,AR Control Account,AP Control Account,GS/IS Accounts Receivable,GR/IR Accounts Payable,Selection Criteria';
            OptionMembers = " ","Purchase Prepayment","Sales Prepayment","AR Control Account","AP Control Account","GS/IS Accounts Receivable","GR/IR Accounts Payable","Selection Criteria";
            Caption = 'Automatic application mode';
        }
        field(50005; "Authorize other App. Modes FND"; Boolean)
        {
            Description = 'RTRGAP038';
            Caption = 'Authorize other Application Modes';

            trigger OnValidate();
            var
                UserSetup: Record "User Setup";
            begin
                //<< HEI.03 RTRGAP038 02/08/17
                UserSetup.GET(USERID);
                if not UserSetup."Allowed Change App. Mode FND" then
                    ERROR(txt50000);
                //<< HEI.03 RTRGAP038 02/08/17
            end;
        }
        field(50006; "Same Amount FND"; Boolean)
        {
            Description = 'RTRGAP038';
            Caption = 'Same Amount';
        }
        field(50007; "Same Remaining Amount FND"; Boolean)
        {
            Description = 'RTRGAP038';
            Caption = 'Same Remaining Amount';
        }
        field(50008; "Same Document No. FND"; Boolean)
        {
            Description = 'RTRGAP038';
            Caption = 'Same Document No.';
        }
        field(50009; "Same External Document No. FND"; Boolean)
        {
            Description = 'RTRGAP038';
            Caption = 'Same External Document No.';
        }
        field(50010; "Export HeiMatch Payments FND"; Boolean)
        {
            CaptionML = ENU = 'Export HeiMatch Payments',
                        FRA = 'Export paiements HeiMatch';
            Description = 'HEI.02 RTRGAP062';
        }
        field(50011; "CIL account FND"; Code[10])
        {
            Description = 'HEI.03 RTR GAP047';
            Caption = 'CIL account';
        }
        field(50012; "Local Name FND"; Text[50])
        {
            Description = 'HEI.03 RTR GAP047';
            Caption = 'Local Name';
        }
        field(50013; "No Trading Partner FND"; Boolean)
        {
            Description = 'HEI.05';
            Caption = 'No Trading Partner';
        }
        field(50014; "Posting Heineken FND"; Boolean)
        {
            CaptionML = ENU = 'Posting Heineken',
                        FRA = 'Validate Heineken';
            Description = 'HEI.05';
        }
        field(50015; "CIL3 Code FND"; Code[10])
        {
            Description = 'HEI.05';
            Caption = 'CIL3 Code';
        }
        field(50016; "MR Code FND"; Code[10])
        {
            Caption = 'MR Code';
            Description = 'HEI.05';
        }
        field(50017; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            Description = 'HEI.04';
            TableRelation = "WHT Business Posting Group FND".Code;
        }
        field(50018; "WHT Product Posting Group FND"; Code[10])
        {
            Caption = 'WHT Product Posting Group';
            Description = 'HEI.04';
            TableRelation = "WHT Product Posting Group FND".Code;
        }
        field(50019; "Cadency Transaction Export FND"; Boolean)
        {
            Description = 'HEI.06';
            Caption = 'Cadency Transaction Export';
        }
        field(50020; "Cadency Bank Export FND"; Option)
        {
            Description = 'HEI.06';
            Caption = 'Cadency Bank Export';
            OptionCaption = '" ,Bank Ledger Entry,G/L Entry"';
            OptionMembers = " ","Bank Ledger Entry","G/L Entry";
        }
        field(50021; "Financial Stmt version FND"; Option)
        {
            OptionMembers = " ",Local,Heineken,Common;
            OptionCaption = '  ,Local,Heineken,Common';
            Caption = 'Financial Statement version';

        }
        field(50022; "Heimatch Sign FND"; Option)
        {
            Description = 'HEI.08,HEI.16';
            Caption = 'HeiMatch Sign';
            OptionCaption = ' ,No Change,Reverse';
            OptionMembers = " ","No Change",Reverse;
        }
        field(50023; "Acc Type FND"; Option)
        {
            OptionMembers = " ",Revenue,Expense;
            Caption = 'Acc Type';
        }
        field(50024; "VAT Account FND"; Boolean)
        {
            Caption = 'VAT Account';
            Description = 'HEI.10';
        }
        field(50025; "WHT Account FND"; Boolean)
        {
            Caption = 'WHT Account';
            Description = 'HEI.11';
        }
        field(50026; "Non Deductible VAT % FND"; Decimal)
        {
            CaptionML = ENU = '% Non Deductible VAT',
                        FRB = '% TVA non-déductible',
                        NLB = '% Niet-aftrekbare BTW';
            Description = 'HEI.12';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50027; "Same Comment FND"; Boolean)
        {
            Caption = 'Same Comment';
            Description = 'HEI.13';
        }
        field(50028; "Maision desVins Dim. Flter FND"; Code[20])
        {
            Caption = 'Maision des Vins Dim. Filter';
            Description = 'HEI.14';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(15));
        }
        field(50029; "C&TP CODE FND"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
            Caption = 'C&TP CODE';
        }
        field(50030; "H&S Levy Tax Posting Group FND"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.18';
            Caption = 'H&S Levy Tax Posting Group';
            TableRelation = "H&S Tax Posting Group FND";
        }
        //BC UPGRADE KUMARR78 FDD-MTC-008 >> Adding Field with New ID
        field(50094; "Show Item charge on Inv. FND"; Option)
        {
            Caption = 'Show Item charge on Invoice';
            OptionCaption = ' ,Under item line,Include in item price,Order total';
            OptionMembers = " ","Under item line","Include in item price","Order total";
        }
        //BC UPGRADE KUMARR78 FDD-MTC-008 << Adding Field with New ID
        // field(2014312;"DIT Sub-Contract Posting Type";Option)
        // {
        //     CaptionML = ENU='Financial Contract Posting Type',
        //                 FRA='type d''écriture Contrat financier';
        //     Description = 'DITW16.00.00.41 DIT-715 #327 -DIT-770 #1368';
        //     OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance,,,,,All',
        //                       FRA=' ,Location,Prêt,Mise à disposition,Maintenance,Divers,Maintenance Usine,,,,,Tous';
        //     OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance,,,,,All;
        // }
        // field(2014410;Collapse;Boolean)
        // {
        //     CaptionML = ENU='Collapse',
        //                 FRA='Réduire';
        //     Description = 'DITW15.00.00.01';
        //     InitValue = true;
        // }
        // field(2014411;"Allow Invoice Disc.";Boolean)
        // {
        //     CaptionML = ENU='Allow Invoice Disc.',
        //                 FRA='Autoriser remise ligne';
        //     Description = 'DITW19.00.08 BL#10868';
        // }
        // field(2029610;"Auto. Acc. Group";Code[10])
        // {
        //     CaptionML = ENU='Auto. Acc. Group',
        //                 FRA='Groupe compte autom.';
        //     Description = 'FINXL7.00.001';
        //     TableRelation = "Automatic Acc. Header";
        // }
        // field(2029611;"Shortcut Property 1 Code";Code[20])
        // {
        //     CaptionClass = '2029610,2,1/15';
        //     CaptionML = ENU='Shortcut Property 1 Code',
        //                 FRA='Code raccourci propriété 1';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code WHERE ("Shortcut No."=CONST(1),
        //                                                  "Table ID"=CONST(15));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 1 Code" := fctValidateShortcutPropertyCode(1,"Shortcut Property 1 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029612;"Shortcut Property 2 Code";Code[20])
        // {
        //     CaptionClass = '2029610,2,2/15';
        //     CaptionML = ENU='Shortcut Property 2 Code',
        //                 FRA='Code raccourci propriété 2';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code WHERE ("Shortcut No."=CONST(2),
        //                                                  "Table ID"=CONST(15));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 2 Code" := fctValidateShortcutPropertyCode(2,"Shortcut Property 2 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029613;"Shortcut Property 3 Code";Code[20])
        // {
        //     CaptionClass = '2029610,2,3/15';
        //     CaptionML = ENU='Shortcut Property 3 Code',
        //                 FRA='Code raccourci propriété 3';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code WHERE ("Shortcut No."=CONST(3),
        //                                                  "Table ID"=CONST(15));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 3 Code" := fctValidateShortcutPropertyCode(3,"Shortcut Property 3 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029614;"Shortcut Property 4 Code";Code[20])
        // {
        //     CaptionClass = '2029610,2,4/15';
        //     CaptionML = ENU='Shortcut Property 4 Code',
        //                 FRA='Code raccourci propriété 4';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code WHERE ("Shortcut No."=CONST(4),
        //                                                  "Table ID"=CONST(15));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 4 Code" := fctValidateShortcutPropertyCode(4,"Shortcut Property 4 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029615;"Shortcut Property 5 Code";Code[20])
        // {
        //     CaptionClass = '2029610,2,5/15';
        //     CaptionML = ENU='Shortcut Property 5 Code',
        //                 FRA='Code raccourci propriété 5';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code WHERE ("Shortcut No."=CONST(5),
        //                                                  "Table ID"=CONST(15));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 5 Code" := fctValidateShortcutPropertyCode(5,"Shortcut Property 5 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029616;"Shortcut Property 6 Code";Code[20])
        // {
        //     CaptionClass = '2029610,2,6/15';
        //     CaptionML = ENU='Shortcut Property 6 Code',
        //                 FRA='Code raccourci propriété 6';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code WHERE ("Shortcut No."=CONST(6),
        //                                                  "Table ID"=CONST(15));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 6 Code" := fctValidateShortcutPropertyCode(6,"Shortcut Property 6 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029617;"Shortcut Property 7 Code";Code[20])
        // {
        //     CaptionClass = '2029610,2,7/15';
        //     CaptionML = ENU='Shortcut Property 7 Code',
        //                 FRA='Code raccourci propriété 7';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code WHERE ("Shortcut No."=CONST(7),
        //                                                  "Table ID"=CONST(15));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 7 Code" := fctValidateShortcutPropertyCode(7,"Shortcut Property 7 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029618;"Shortcut Property 8 Code";Code[20])
        // {
        //     CaptionClass = '2029610,2,8/15';
        //     CaptionML = ENU='Shortcut Property 8 Code',
        //                 FRA='Code raccourci propriété 8';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code WHERE ("Shortcut No."=CONST(8),
        //                                                  "Table ID"=CONST(15));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 8 Code" := fctValidateShortcutPropertyCode(8,"Shortcut Property 8 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029619;"Shortcut Property 9 Code";Code[20])
        // {
        //     CaptionClass = '2029610,2,9/15';
        //     CaptionML = ENU='Shortcut Property 9 Code',
        //                 FRA='Code raccourci propriété 9';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code WHERE ("Shortcut No."=CONST(9),
        //                                                  "Table ID"=CONST(15));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 9 Code" := fctValidateShortcutPropertyCode(9,"Shortcut Property 9 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029620;"Shortcut Property 10 Code";Code[20])
        // {
        //     CaptionClass = '2029610,2,10/15';
        //     CaptionML = ENU='Shortcut Property 10 Code',
        //                 FRA='Code raccourci propriété 10';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code WHERE ("Shortcut No."=CONST(10),
        //                                                  "Table ID"=CONST(15));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 10 Code" := fctValidateShortcutPropertyCode(10,"Shortcut Property 10 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2034850;"DIT Sub-Contract Type Filter";Option)
        // {
        //     CaptionML = ENU='Financial Sub Contract Type Filter',
        //                 FRA='Filtre Sous type de contrat financier';
        //     Description = 'DITW16.00.00.41 DIT-715 #327';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA=' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        // }
        // field(2034915;"Service Contract No. Filter";Code[20])
        // {
        //     CaptionML = ENU='Financial Contract No. Filter',
        //                 FRA='Filtre N° contrat financier';
        //     Description = 'DITW16.00.00.41 DIT-715 #327';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Financial Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract));
        // } // BC Upgrade NANDIS03 - Aptean fields
    }

    keys
    {
        //key(Key1; "Direct Posting", "Account Type", Blocked)  // BC Upgrade NANDIS03
        key(Key50000; "Direct Posting", "Account Type", Blocked)  // BC Upgrade NANDIS03

        {
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    MoveEntries.MoveGLEntries(Rec);

    GLBudgetEntry.SETCURRENTKEY("Budget Name","G/L Account No.");
    GLBudgetEntry.SETRANGE("G/L Account No.","No.");
    GLBudgetEntry.DELETEALL(TRUE);

    CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::"G/L Account");
    CommentLine.SETRANGE("No.","No.");
    CommentLine.DELETEALL;

    ExtTextHeader.SETRANGE("Table Name",ExtTextHeader."Table Name"::"G/L Account");
    ExtTextHeader.SETRANGE("No.","No.");
    ExtTextHeader.DELETEALL(TRUE);

    AnalysisViewEntry.SETRANGE("Account No.","No.");
    AnalysisViewEntry.DELETEALL;
    #17..21
    MyAccount.DELETEALL;

    DimMgt.DeleteDefaultDim(DATABASE::"G/L Account","No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    GLBudgetEntry.DELETEALL(true);
    #6..12
    ExtTextHeader.DELETEALL(true);
    #14..24

    //ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::"G/L Account","No.",TRUE); //HEI.17 //HEI.19
    if CheckZycusEnable then //HEI.20
      ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::"G/L Account","No.",true,false) //HEI.19
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DimMgt.UpdateDefaultDim(DATABASE::"G/L Account","No.",
      "Global Dimension 1 Code","Global Dimension 2 Code");

    IF CostAccSetup.GET THEN
      CostAccMgt.UpdateCostTypeFromGLAcc(Rec,xRec,0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    if CostAccSetup.GET then
      CostAccMgt.UpdateCostTypeFromGLAcc(Rec,xRec,0);

    //ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::"G/L Account","No.",FALSE); //HEI.17 //HEI.19
    if CheckZycusEnable then //HEI.20
      ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::"G/L Account","No.",false,false); //HEI.19
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;

    IF CostAccSetup.GET THEN
      CostAccMgt.UpdateCostTypeFromGLAcc(Rec,xRec,1);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;

    if CostAccSetup.GET then
      CostAccMgt.UpdateCostTypeFromGLAcc(Rec,xRec,1);
    if CheckZycusEnable then //HEI.20
      UpdateLocaltimestamp; //HEI.17
    */
    //end;


    //Unsupported feature: CodeModification on "OnRename". Please convert manually.

    //trigger OnRename();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesLine.RenameNo(SalesLine.Type::"G/L Account",xRec."No.","No.");
    PurchLine.RenameNo(PurchLine.Type::"G/L Account",xRec."No.","No.");
    "Last Date Modified" := TODAY;

    IF CostAccSetup.READPERMISSION THEN
      CostAccMgt.UpdateCostTypeFromGLAcc(Rec,xRec,3);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    if CostAccSetup.READPERMISSION then
      CostAccMgt.UpdateCostTypeFromGLAcc(Rec,xRec,3);

    //ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::"G/L Account","No.",FALSE); //HEI.17 //HEI.19
    if CheckZycusEnable then //HEI.20
      ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::"G/L Account","No.",false,false); //HEI.19
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot change %1 because there are one or more ledger entries associated with this account.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot change %1 because there are one or more ledger entries associated with this account.;FRA=Vous ne pouvez pas modifier %1 car il existe des écritures comptables associées à ce compte.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot change %1 because this account is part of one or more budgets.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot change %1 because this account is part of one or more budgets.;FRA=Vous ne pouvez pas modifier %1 car ce compte fait partie d'un ou plusieurs budget(s).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU="There is another %1: %2; which refers to the same %3, but with a different %4: %5.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU="There is another %1: %2; which refers to the same %3, but with a different %4: %5.";FRA=Il existe un autre %1 : %2, qui concerne le(la) même %3, mais avec un(e) autre %4 : %5.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "NoAccountCategoryMatchErr(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //NoAccountCategoryMatchErr : @@@="%1=account category value, %2=the user input.";ENU=There is no subcategory description for %1 that matches '%2'.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NoAccountCategoryMatchErr : @@@="%1=account category value, %2=the user input.";ENU=There is no subcategory description for %1 that matches '%2'.;FRA=Il n'existe aucune description de sous-catégorie pour %1 qui corresponde à '%2'.;
    //Variable type has not been exported.

    var
        CompanyInfo: Record "Company Information";
        ZycusMasterTimestamp: Record "Zycus Master Timestamp FND";
        Text10800: TextConst ENU = 'The first number in %1 must be from 1 to 9.', FRA = 'Le premier nombre dans %1 doit se trouver entre 1 et 9.';
        txt50000: TextConst ENU = 'Modification not allowed, please contact your administrator', FRA = 'Modification not allowed, please contact your administrator';

    // BC Upgrade NANDIS03 >>
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        //     //ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::"G/L Account","No.",FALSE); //HEI.17 //HEI.19
        //     IF CheckZycusEnable THEN //HEI.20
        //         ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::"G/L Account", "No.", FALSE, FALSE); //HEI.19

        //     //HEI.21>>
        //     IF CheckZycusEnable THEN
        //         ZycusInterfaceManagementL.GLAccountRuleMapToCreateOrUpdateOrDeleteInStaging_Zycus(Rec, xRec);
        //     //HEI.21<<  // BC Upgrade NANDIS03 - Dependency on Zycus Codeunit
    end;
    // BC Upgrade NANDIS03 <<

}

