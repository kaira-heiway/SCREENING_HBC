tableextension 50036 BankAccountExtFND extends "Bank Account"
{
    // HEI.03 FDD BA-PTPGAP03 IBM NASTAA02 04.02.2019 # Digital Checks Printout
    //   # New Fields created: 50008 - Check Electronic Signature
    //                         50009 - Check Payment Format
    //   # "Check Payment Format" can be editable just when "Last Check No." is not empty
    //   # If "Last Check No." is cleared then "Check Payment Format" should be also cleared
    // HEI.04 FDD BA-PTPGAP01 CHG2025181 IBM GAVANM01 26.08.2019 # Digital Checks Printout
    //   # new option added "Saint Lucia FCIB" in "Check Payment Format" field
    // HEI.05 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New fields added
    //     # 10851Agency Code
    //     # 10852RIB Key
    //     # 10853RIB Checked
    //     # 10854National Issuer No.

    // HEI.06 FDD CHG2037399 IBM NANDIS01 17.03.2020 - Cheque Printing
    //   # Remove Field "Check Payment Format"(ID - 50009)
    //   # Validation of "Last Check No." and "Check Payment Format" blocked

    // HEI.07 CHG2059040 BULIMC01 IBM 29.04.2020 #2 new fields added:
    //    #50010 -"Export Bank Report ID" and 50011-"Export Bank Report Name"

    // HEI.08 CHG2086827 IBM POENAB02 Bank Connectivity DRC  complementing BRD HT84
    //  # New field: 50011 Activate Amount LCY DRC
    //  # Code added in Currency Code - OnValidate
    // HEI.09 CHG2096435 HT1805 IBM GAVANM01 12.02.2021 - Invoice Layout
    //   # Added field 50013 - Bank for invoice layout
    // HEI.10 CHG2119178 IBM.AS 30.06.2021
    //   # HeiLite Base Stability Changes for Posting functions at JOB NAS
    //   # Adding GUIAllowed function added in Functions
    //     ShowContact(),
    //     ScheduleBankStatementDownload()
    // version NAVW110.0,FINXL10.00,DITW110.00.08,HEI.03

    //Bc Upgrade YADAVM09 Drink it field blocked
    //#Agency Code
    //#RIB Key
    //#RIB Checked
    //#National Issuer No.
    //#Batch Booking

    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Search Name")
        {
            CaptionML = ENU = 'Search Name', FRA = 'Nom de recherche';
        }
        modify("Name 2")
        {
            CaptionML = ENU = 'Name 2', FRA = 'Nom 2';
        }
        modify(Address)
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
        }
        modify("Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
        }
        modify(City)
        {

            //Unsupported feature: Change TableRelation on "City(Field 7)". Please convert manually.

            CaptionML = ENU = 'City', FRA = 'Ville';
        }
        modify(Contact)
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        modify("Phone No.")
        {
            CaptionML = ENU = 'Phone No.', FRA = 'N° téléphone';
        }
        modify("Telex No.")
        {
            CaptionML = ENU = 'Telex No.', FRA = 'N° télex';
        }
        modify("Bank Account No.")
        {
            CaptionML = ENU = 'Bank Account No.', FRA = 'N° compte bancaire';
        }
        modify("Transit No.")
        {
            CaptionML = ENU = 'Transit No.', FRA = 'N° interne';
        }
        modify("Territory Code")
        {
            CaptionML = ENU = 'Territory Code', FRA = 'Code secteur';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 16)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Chain Name")
        {
            CaptionML = ENU = 'Chain Name', FRA = 'Nom du groupe';
        }
        modify("Min. Balance")
        {
            CaptionML = ENU = 'Min. Balance', FRA = 'Solde minimum';
        }
        modify("Bank Acc. Posting Group")
        {
            CaptionML = ENU = 'Bank Acc. Posting Group', FRA = 'Groupe compta. banque';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //BC Upgrade KAPOOV01>>
                //HEI.08>>
                IF "Activate Amount LCY DRC FND" = TRUE THEN BEGIN
                    IF (("Currency Code" <> '') AND ("Currency Code" <> 'CDF')) THEN BEGIN
                        "Activate Amount LCY DRC FND" := FALSE;
                        MESSAGE(Text50001, FIELDCAPTION("Activate Amount LCY DRC FND"));
                    end;
                end;
                //HEI.08<<
                //BC Upgrade KAPOOV01<<
            end;
        }
        modify("Language Code")
        {
            CaptionML = ENU = 'Language Code', FRA = 'Code langue';
        }
        modify("Statistics Group")
        {
            CaptionML = ENU = 'Statistics Group', FRA = 'Groupe statistiques';
        }
        modify("Our Contact Code")
        {

            //Unsupported feature: Change TableRelation on ""Our Contact Code"(Field 29)". Please convert manually.

            CaptionML = ENU = 'Our Contact Code', FRA = 'Code contact';
        }
        modify("Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Country/Region Code"(Field 35)". Please convert manually.

            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 38)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
        }
        modify("Last Statement No.")
        {
            CaptionML = ENU = 'Last Statement No.', FRA = 'N° dern. relevé';
        }
        modify("Last Payment Statement No.")
        {
            CaptionML = ENU = 'Last Payment Statement No.', FRA = 'N° dern. relevé paiement';
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

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Filter"(Field 56)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Filter', FRA = 'Filtre axe principal 1';
        }
        modify("Global Dimension 2 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Filter"(Field 57)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Filter', FRA = 'Filtre axe principal 2';
        }
        modify(Balance)
        {

            //Unsupported feature: Change CalcFormula on "Balance(Field 58)". Please convert manually.

            CaptionML = ENU = 'Balance', FRA = 'Solde';
        }
        modify("Balance (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Balance (LCY)"(Field 59)". Please convert manually.

            CaptionML = ENU = 'Balance (LCY)', FRA = 'Solde DS';
        }
        modify("Net Change")
        {

            //Unsupported feature: Change CalcFormula on ""Net Change"(Field 60)". Please convert manually.

            CaptionML = ENU = 'Net Change', FRA = 'Solde période';
        }
        modify("Net Change (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Net Change (LCY)"(Field 61)". Please convert manually.

            CaptionML = ENU = 'Net Change (LCY)', FRA = 'Solde période DS';
        }
        modify("Total on Checks")
        {

            //Unsupported feature: Change CalcFormula on ""Total on Checks"(Field 62)". Please convert manually.

            CaptionML = ENU = 'Total on Checks', FRA = 'Total sur chèques';
        }
        modify("Fax No.")
        {
            CaptionML = ENU = 'Fax No.', FRA = 'N° télécopie';
        }
        modify("Telex Answer Back")
        {
            CaptionML = ENU = 'Telex Answer Back', FRA = 'Télex retour';
        }
        //BC Upgrade KAPOOV01>>
        // modify(Picture)
        // {
        //     CaptionML = ENU = 'Picture', FRA = 'illustration';
        // }
        //BC Upgrade KAPOOV01 Already added as Image<<
        modify("Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Post Code"(Field 91)". Please convert manually.

            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify(County)
        {
            CaptionML = ENU = 'County', FRA = 'Région';
        }
        modify("Last Check No.")
        {
            CaptionML = ENU = 'Last Check No.', FRA = 'N° dern. chèque';

            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //BC Upgrade KAPVOO01>>
                //HEI.06>>
                //HEI.03>>
                //IF "Last Check No." = '' THEN
                //  "Check Payment Format" := "Check Payment Format"::" ";
                //HEI.03<<
                //HEI.06<<
                //BC Upgrade KAPVOO01<<
            end;
        }
        modify("Balance Last Statement")
        {
            CaptionML = ENU = 'Balance Last Statement', FRA = 'Solde dernier relevé';
        }
        modify("Balance at Date")
        {

            //Unsupported feature: Change CalcFormula on ""Balance at Date"(Field 95)". Please convert manually.

            CaptionML = ENU = 'Balance at Date', FRA = 'Solde au';
        }
        modify("Balance at Date (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Balance at Date (LCY)"(Field 96)". Please convert manually.

            CaptionML = ENU = 'Balance at Date (LCY)', FRA = 'Solde au (DS)';
        }
        modify("Debit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Debit Amount"(Field 97)". Please convert manually.

            CaptionML = ENU = 'Debit Amount', FRA = 'Montant débit';
        }
        modify("Credit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Credit Amount"(Field 98)". Please convert manually.

            CaptionML = ENU = 'Credit Amount', FRA = 'Montant crédit';
        }
        modify("Debit Amount (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Debit Amount (LCY)"(Field 99)". Please convert manually.

            CaptionML = ENU = 'Debit Amount (LCY)', FRA = 'Montant débit DS';
        }
        modify("Credit Amount (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Credit Amount (LCY)"(Field 100)". Please convert manually.

            CaptionML = ENU = 'Credit Amount (LCY)', FRA = 'Montant crédit DS';
        }
        modify("Bank Branch No.")
        {
            CaptionML = ENU = 'Bank Branch No.', FRA = 'Code établissement';
        }
        modify("E-Mail")
        {
            CaptionML = ENU = 'Email', FRA = 'Adresse e-mail';
        }
        modify("Home Page")
        {
            CaptionML = ENU = 'Home Page', FRA = 'Page d''accueil';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Check Report ID")
        {

            //Unsupported feature: Change TableRelation on ""Check Report ID"(Field 108)". Please convert manually.

            CaptionML = ENU = 'Check Report ID', FRA = 'Vérifier ID état';
        }
        modify("Check Report Name")
        {

            //Unsupported feature: Change CalcFormula on ""Check Report Name"(Field 109)". Please convert manually.

            CaptionML = ENU = 'Check Report Name', FRA = 'Vérifier nom état';
        }
        modify(IBAN)
        {
            CaptionML = ENU = 'IBAN', FRA = 'N° compte international (IBAN)';
        }
        modify("SWIFT Code")
        {
            CaptionML = ENU = 'SWIFT Code', FRA = 'Code SWIFT';
        }
        modify("Bank Statement Import Format")
        {
            CaptionML = ENU = 'Bank Statement Import Format', FRA = 'Format importation relevé bancaire';
        }
        modify("Credit Transfer Msg. Nos.")
        {
            CaptionML = ENU = 'Credit Transfer Msg. Nos.', FRA = 'N° msg. virement';
        }
        modify("Direct Debit Msg. Nos.")
        {
            CaptionML = ENU = 'Direct Debit Msg. Nos.', FRA = 'N° msg. prélèvement';
        }
        modify("SEPA Direct Debit Exp. Format")
        {
            CaptionML = ENU = 'SEPA Direct Debit Exp. Format', FRA = 'Format exp. domiciliation européenne SEPA';
        }
        modify("Bank Stmt. Service Record ID")
        {
            CaptionML = ENU = 'Bank Stmt. Service Record ID', FRA = 'ID enregistrement du service de relevés bancaires';
        }
        modify("Transaction Import Timespan")
        {
            CaptionML = ENU = 'Transaction Import Timespan', FRA = 'Période d''importation des transactions';
        }
        modify("Automatic Stmt. Import Enabled")
        {
            CaptionML = ENU = 'Automatic Stmt. Import Enabled', FRA = 'Importation relevé auto activée';
        }
        modify(Image)
        {
            CaptionML = ENU = 'Image', FRA = 'Image';
        }
        modify("Creditor No.")
        {
            CaptionML = ENU = 'Creditor No.', FRA = 'N° créditeur';
        }
        modify("Payment Export Format")
        {
            CaptionML = ENU = 'Payment Export Format', FRA = 'Format exportation paiement';
        }
        modify("Bank Clearing Code")
        {
            CaptionML = ENU = 'Bank Clearing Code', FRA = 'Code compensation bancaire';
        }
        modify("Bank Clearing Standard")
        {
            CaptionML = ENU = 'Bank Clearing Standard', FRA = 'Standard compensation bancaire';
        }
        //BC Upgrade KAPOOV01 Field removed>>
        // modify("Bank Name - Data Conversion")
        // {

        //     //Unsupported feature: Change TableRelation on ""Bank Name - Data Conversion"(Field 1213)". Please convert manually.

        //     CaptionML = ENU = 'Bank Name - Data Conversion', FRA = 'Nom banque - Conversion données';
        // }
        //BC Upgrade KAPOOV01 Field removed<<
        modify("Match Tolerance Type")
        {
            CaptionML = ENU = 'Match Tolerance Type', FRA = 'Type d''écart correspondance';
            OptionCaptionML = ENU = 'Percentage,Amount', FRA = 'Pourcentage,Montant';
        }
        modify("Match Tolerance Value")
        {
            CaptionML = ENU = 'Match Tolerance Value', FRA = 'Valeur écart correspondance';
        }
        modify("Positive Pay Export Code")
        {

            //Unsupported feature: Change TableRelation on ""Positive Pay Export Code"(Field 1260)". Please convert manually.

            CaptionML = ENU = 'Positive Pay Export Code', FRA = 'Code exportation Positive Pay';
        }

        //Unsupported feature: CodeModification on ""No."(Field 1).OnValidate". Please convert manually.

        //trigger "(Field 1)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." <> xRec."No." THEN BEGIN
          GLSetup.GET;
          NoSeriesMgt.TestManual(GLSetup."Bank Account Nos.");
          "No. Series" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "No." <> xRec."No." then begin
        #2..4
        end;
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
        */
        //end;


        //Unsupported feature: CodeModification on "City(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Currency Code"(Field 22).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Currency Code" = xRec."Currency Code" THEN
          EXIT;

        BankAcc.RESET;
        BankAcc := Rec;
        BankAcc.CALCFIELDS(Balance,"Balance (LCY)");
        BankAcc.TESTFIELD(Balance,0);
        BankAcc.TESTFIELD("Balance (LCY)",0);

        IF NOT BankAccLedgEntry.SETCURRENTKEY("Bank Account No.",Open) THEN
          BankAccLedgEntry.SETCURRENTKEY("Bank Account No.");
        BankAccLedgEntry.SETRANGE("Bank Account No.","No.");
        BankAccLedgEntry.SETRANGE(Open,TRUE);
        IF BankAccLedgEntry.FINDLAST THEN
          ERROR(
            Text000,
            FIELDCAPTION("Currency Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Currency Code" = xRec."Currency Code" then
          exit;
        #3..9
        if not BankAccLedgEntry.SETCURRENTKEY("Bank Account No.",Open) then
          BankAccLedgEntry.SETCURRENTKEY("Bank Account No.");
        BankAccLedgEntry.SETRANGE("Bank Account No.","No.");
        BankAccLedgEntry.SETRANGE(Open,true);
        if BankAccLedgEntry.FINDLAST then
        #15..17
        //HEI.08>>
        if "Activate Amount LCY DRC" = true then
          begin
            if (("Currency Code" <> '') and ("Currency Code" <> 'CDF')) then
              begin
                "Activate Amount LCY DRC" := false;
                MESSAGE(Text50001,FIELDCAPTION("Activate Amount LCY DRC"));
              end;
          end;
        //HEI.08<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Post Code"(Field 91).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Last Check No."(Field 93)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.06>>
        //HEI.03>>
        //IF "Last Check No." = '' THEN
        //  "Check Payment Format" := "Check Payment Format"::" ";
        //HEI.03<<
        //HEI.06<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Bank Stmt. Service Record ID"(Field 121).OnValidate". Please convert manually.

        //trigger  Service Record ID"(Field 121)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF FORMAT("Bank Stmt. Service Record ID") = '' THEN
          OnUnlinkStatementProviderEvent(Rec,Handled);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if FORMAT("Bank Stmt. Service Record ID") = '' then
          OnUnlinkStatementProviderEvent(Rec,Handled);
        */
        //end;


        //Unsupported feature: CodeModification on ""Transaction Import Timespan"(Field 123).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT ("Transaction Import Timespan" IN [0..9999]) THEN
          ERROR(TransactionImportTimespanMustBePositiveErr);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not ("Transaction Import Timespan" in [0..9999]) then
          ERROR(TransactionImportTimespanMustBePositiveErr);
        */
        //end;


        //Unsupported feature: CodeModification on ""Automatic Stmt. Import Enabled"(Field 124).OnValidate". Please convert manually.

        //trigger  Import Enabled"(Field 124)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Automatic Stmt. Import Enabled" THEN BEGIN
          IF NOT IsAutoLogonPossible THEN
            ERROR(MFANotSupportedErr);

          IF NOT ("Transaction Import Timespan" IN [0..9999]) THEN
            ERROR(TransactionImportTimespanMustBePositiveErr);
          ScheduleBankStatementDownload
        end else
          UnscheduleBankStatementDownload;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Automatic Stmt. Import Enabled" then begin
          if not IsAutoLogonPossible then
            ERROR(MFANotSupportedErr);

          if not ("Transaction Import Timespan" in [0..9999]) then
            ERROR(TransactionImportTimespanMustBePositiveErr);
          ScheduleBankStatementDownload
        end else
          UnscheduleBankStatementDownload;
        */
        //end;


        //Unsupported feature: CodeModification on ""Match Tolerance Type"(Field 1250).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Match Tolerance Type" <> xRec."Match Tolerance Type" THEN
          "Match Tolerance Value" := 0;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Match Tolerance Type" <> xRec."Match Tolerance Type" then
          "Match Tolerance Value" := 0;
        */
        //end;


        //Unsupported feature: CodeModification on ""Match Tolerance Value"(Field 1251).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Match Tolerance Value" < 0 THEN
          ERROR(InvalidValueErr);

        IF "Match Tolerance Type" = "Match Tolerance Type"::Percentage THEN
          IF "Match Tolerance Value" > 99 THEN
            ERROR(InvalidPercentageValueErr,FIELDCAPTION("Match Tolerance Type"),
              FORMAT("Match Tolerance Type"::Percentage));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Match Tolerance Value" < 0 then
          ERROR(InvalidValueErr);

        if "Match Tolerance Type" = "Match Tolerance Type"::Percentage then
          if "Match Tolerance Value" > 99 then
            ERROR(InvalidPercentageValueErr,FIELDCAPTION("Match Tolerance Type"),
              FORMAT("Match Tolerance Type"::Percentage));
        */
        //end;

        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        field(10851; "Agency Code"; Text[5])
        {
            CaptionML = ENU = 'Agency Code',
                        FRA = 'Code agence';
            Description = 'HEI.05';
            InitValue = '00000';

            trigger OnValidate();
            begin
                //HEI.05>>
                CompanyInfo.GET;
                if CompanyInfo."Enable French Localization" then begin
                    if STRLEN("Agency Code") < 5 then
                        "Agency Code" := PADSTR('', 5 - STRLEN("Agency Code"), '0') + "Agency Code";
                    //"RIB Checked" := RIBKey.Check("Bank Branch No.", "Agency Code", "Bank Account No.", "RIB Key"); //BC Upgrade KAPOOV01 Need to be handeled in CDs.
                end;
                //HEI.05<<
            end;
        }
        
        field(10852; "RIB Key"; Integer)
        {
            CaptionML = ENU = 'RIB Key',
                        FRA = 'Clé RIB';
            Description = 'HEI.05';

            trigger OnValidate();
            begin
                //HEI.05>>
                CompanyInfo.GET;
                if CompanyInfo."Enable French Localization" then;
                //"RIB Checked" := RIBKey.Check("Bank Branch No.", "Agency Code", "Bank Account No.", "RIB Key");//BC Upgrade KAPOOV01 Need to be handeled in CDs.
                //HEI.05<<
            end;
        }
        field(10853; "RIB Checked"; Boolean)
        {
            CaptionML = ENU = 'RIB Checked',
                        FRA = 'Vérification RIB';
            Description = 'HEI.05';
            Editable = false;
        }
        field(10854; "National Issuer No."; Code[6])
        {
            CaptionML = ENU = 'National Issuer No.',
                        FRA = 'N° émetteur national';
            Description = 'HEI.05';
            Numeric = true;

            trigger OnValidate();
            begin
                //HEI.05>>
                CompanyInfo.GET;
                if CompanyInfo."Enable French Localization" then
                    if (STRLEN("National Issuer No.") > 0) and (STRLEN("National Issuer No.") < 6) then
                        ERROR(Text10800);
                //HEI.05<<
            end;
        }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
        field(50000; "IBAN Matching Criteria FND"; Boolean)
        {
            Description = 'HEI.01';
            Caption = 'IBAN Matching Criteria';
        }
        field(50001; "SuspnsAcc. for Paym.Reconc FND"; Boolean)
        {
            Caption = 'Suspense Acc. for Paym. Reconciliaton';
            Description = 'HEI.01';

        }
        field(50002; "Electronic Pmt. Setup FND"; Option)
        {
            OptionCaptionML = ENU = ' ,Banco General,Citibank',
                              ESP = ' ,Banco General,Citibank';
            OptionMembers = " ","Banco General",Citibank;
        }
        field(50003; "Vendor Payment File FND"; Text[200])
        {
            CaptionML = ENU = 'Vendor Payment File',
                        ESP = 'Archivo pago proveedor';
        }
        field(50004; "Account Type FND"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = ' ,Current,Savings';
            OptionMembers = " ",Current,Savings;
        }
        field(50005; "Bank Entity Code FND"; Text[10])
        {
            Caption = 'Bank Entity Code';
        }
        field(50006; "Delete Characters FND"; Text[10])
        {
            CaptionML = ENU = 'Delete Characters',
                        ESP = 'Caracteres por eliminar';
        }
        field(50007; "Import Format FND"; Option)
        {
            Caption = 'Import Format';
            OptionMembers = " ","Bahamas BNS","Bahamas CITI","Bahamas BOB","Bahamas RBC","Bahamas FCIB";
        }
        field(50008; "Check Electronic Signature FND"; BLOB)
        {
            CaptionML = ENU = 'Picture',
                        FRA = 'Image';
            Description = 'HEI.03';
            SubType = Bitmap;
        }
        field(50010; "Exp. Payments Bank Rep ID FND"; Integer)
        {
            Caption = 'Export Bank Payments Report ID';
            Description = 'HEI.07';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = CONST(Report));
        }
        field(50011; "Exp. Payment Bank Rep Name FND"; Text[249])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" where("Object Type" = CONST(Report),
                                                                           "Object ID" = FIELD("Exp. Payments Bank Rep ID FND")));
            Caption = 'Export Bank Payments Report Name';
            Description = 'HEI.07';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; "Activate Amount LCY DRC FND"; Boolean)
        {
            Caption = 'Activate Amount LCY DRC';
            Description = 'HEI.08';

            trigger OnValidate();
            begin
                //HEI.08>>
                if (("Currency Code" <> '') and ("Currency Code" <> 'CDF')) then
                    ERROR(Text50000);
                //HEI.08<<
            end;
        }
        field(50013; "Bank for invoice layout FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
            Caption = 'Bank for invoice layout';
        }
        /* //Bc Upgrade YADAVM09 Drink it field blocked>>
        field(2029610; "Batch Booking"; Boolean)
        {
            CaptionML = ENU = 'Batch Booking',
                        FRA = 'Batch Booking';
            Description = 'FINXL7.00.001';
        }
        */ //Bc Upgrade YADAVM09 Drink it field blocked<<
    }


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." = '' THEN BEGIN
      GLSetup.GET;
      GLSetup.TESTFIELD("Bank Account Nos.");
      NoSeriesMgt.InitSeries(GLSetup."Bank Account Nos.",xRec."No. Series",0D,"No.","No. Series");
    end;

    IF NOT InsertFromContact THEN
      UpdateContFromBank.OnInsert(Rec);

    DimMgt.UpdateDefaultDim(
      DATABASE::"Bank Account","No.",
      "Global Dimension 1 Code","Global Dimension 2 Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if "No." = '' then begin
    #2..4
    end;

    if not InsertFromContact then
    #8..12
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;

    IF (Name <> xRec.Name) OR
       ("Search Name" <> xRec."Search Name") OR
       ("Name 2" <> xRec."Name 2") OR
       (Address <> xRec.Address) OR
       ("Address 2" <> xRec."Address 2") OR
       (City <> xRec.City) OR
       ("Phone No." <> xRec."Phone No.") OR
       ("Telex No." <> xRec."Telex No.") OR
       ("Territory Code" <> xRec."Territory Code") OR
       ("Currency Code" <> xRec."Currency Code") OR
       ("Language Code" <> xRec."Language Code") OR
       ("Our Contact Code" <> xRec."Our Contact Code") OR
       ("Country/Region Code" <> xRec."Country/Region Code") OR
       ("Fax No." <> xRec."Fax No.") OR
       ("Telex Answer Back" <> xRec."Telex Answer Back") OR
       ("Post Code" <> xRec."Post Code") OR
       (County <> xRec.County) OR
       ("E-Mail" <> xRec."E-Mail") OR
       ("Home Page" <> xRec."Home Page")
    THEN BEGIN
      MODIFY;
      UpdateContFromBank.OnModify(Rec);
      IF NOT FIND THEN BEGIN
        RESET;
        IF FIND THEN;
      end;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;

    if (Name <> xRec.Name) or
       ("Search Name" <> xRec."Search Name") or
       ("Name 2" <> xRec."Name 2") or
       (Address <> xRec.Address) or
       ("Address 2" <> xRec."Address 2") or
       (City <> xRec.City) or
       ("Phone No." <> xRec."Phone No.") or
       ("Telex No." <> xRec."Telex No.") or
       ("Territory Code" <> xRec."Territory Code") or
       ("Currency Code" <> xRec."Currency Code") or
       ("Language Code" <> xRec."Language Code") or
       ("Our Contact Code" <> xRec."Our Contact Code") or
       ("Country/Region Code" <> xRec."Country/Region Code") or
       ("Fax No." <> xRec."Fax No.") or
       ("Telex Answer Back" <> xRec."Telex Answer Back") or
       ("Post Code" <> xRec."Post Code") or
       (County <> xRec.County) or
       ("E-Mail" <> xRec."E-Mail") or
       ("Home Page" <> xRec."Home Page")
    then begin
      MODIFY;
      UpdateContFromBank.OnModify(Rec);
      if not FIND then begin
        RESET;
        if FIND then;
      end;
    end;
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
    //Text000 : ENU=You cannot change %1 because there are one or more open ledger entries for this bank account.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot change %1 because there are one or more open ledger entries for this bank account.;FRA=Vous ne pouvez pas modifier %1 car il existe une ou plusieurs écriture(s) comptable(s) ouverte(s) pour ce compte bancaire.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Do you wish to create a contact for %1 %2?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Do you wish to create a contact for %1 %2?;FRA=Souhaitez-vous créer un contact pour %1 %2 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.;FRA=Avant de pouvoir utiliser Online Map, vous devez compléter la fenêtre Configuration Online Map.\Consultez la section Configuration d'Online Map dans l'Aide.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "BankAccIdentifierIsEmptyErr(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //BankAccIdentifierIsEmptyErr : ENU=You must specify either a %1 or an %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BankAccIdentifierIsEmptyErr : ENU=You must specify either a %1 or an %2.;FRA=Vous devez spécifier un %1 ou un %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "InvalidPercentageValueErr(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //InvalidPercentageValueErr : @@@=%1 is "field caption and %2 is "Percentage";ENU=If %1 is %2, then the value must be between 0 and 99.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //InvalidPercentageValueErr : @@@=%1 is "field caption and %2 is "Percentage";ENU=If %1 is %2, then the value must be between 0 and 99.;FRA=Si %1 est %2, la valeur doit être comprise entre 0 et 99.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "InvalidValueErr(Variable 1015)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //InvalidValueErr : ENU=The value must be positive.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //InvalidValueErr : ENU=The value must be positive.;FRA=La valeur doit être positive.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DataExchNotSetErr(Variable 1016)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DataExchNotSetErr : ENU=The Data Exchange Code field must be filled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DataExchNotSetErr : ENU=The Data Exchange Code field must be filled.;FRA=Le champ Code échange de données doit être renseigné.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "BankStmtScheduledDownloadDescTxt(Variable 1018)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //BankStmtScheduledDownloadDescTxt : @@@=%1 - Bank Account name;ENU=%1 Bank Statement Import;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BankStmtScheduledDownloadDescTxt : @@@=%1 - Bank Account name;ENU=%1 Bank Statement Import;FRA=%1 Importation du relevé bancaire;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "JobQEntriesCreatedQst(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //JobQEntriesCreatedQst : ENU=A job queue entry for import of bank statements has been created.\\Do you want to open the Job Queue Entry window?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //JobQEntriesCreatedQst : ENU=A job queue entry for import of bank statements has been created.\\Do you want to open the Job Queue Entry window?;FRA=Une écriture de file d'attente des travaux pour l'importation de relevés bancaires a été créée.\\Voulez-vous ouvrir la fenêtre Écriture file d'attente des travaux ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "TransactionImportTimespanMustBePositiveErr(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //TransactionImportTimespanMustBePositiveErr : ENU=The value in the Number of Days Included field must be a positive number not greater than 9999.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TransactionImportTimespanMustBePositiveErr : ENU=The value in the Number of Days Included field must be a positive number not greater than 9999.;FRA=La valeur du champ Nombre de jours inclus doit être un nombre positif ne dépassant pas 9 999.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "MFANotSupportedErr(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //MFANotSupportedErr : ENU=Cannot setup automatic bank statement import because the selected bank requires multi-factor authentication.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //MFANotSupportedErr : ENU=Cannot setup automatic bank statement import because the selected bank requires multi-factor authentication.;FRA=Impossible de configurer l'importation de relevés bancaires automatique, car la banque sélectionnée nécessite une authentification à plusieurs facteurs.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "BankAccNotLinkedErr(Variable 1023)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //BankAccNotLinkedErr : ENU=This bank account is not linked to an online bank account.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BankAccNotLinkedErr : ENU=This bank account is not linked to an online bank account.;FRA=Ce compte bancaire n'est pas lié à un compte bancaire en ligne.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "AutoLogonNotPossibleErr(Variable 1024)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //AutoLogonNotPossibleErr : ENU=Automatic logon is not possible for this bank account.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AutoLogonNotPossibleErr : ENU=Automatic logon is not possible for this bank account.;FRA=La connexion automatique n'est pas possible pour ce compte bancaire.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CancelTxt(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CancelTxt : ENU=Cancel;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CancelTxt : ENU=Cancel;FRA=Annuler;
    //Variable type has not been exported.

    var
        CompanyInfo: Record "Company Information";
        Text50000: Label 'You cannot activate this field because Currency Code is not blank or CDF!';
        Text50001: Label 'Field %1 was deactivated!';
        //RIBKey: Codeunit "RIB Key"; //BC Upgrade KAPOOV01>>
        Text10800: TextConst ENU = 'You must enter 6 positions in this field.', FRA = 'Vous devez entrer 6 positions dans ce champ.';
}

