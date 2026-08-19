tableextension 50247 BankAccReconciliationExtFND extends "Bank Acc. Reconciliation"
{
    // version NAVW110.0.00.15052
    //     HEI.01 CHG2020184 IBM POENAB02 26.06.2019
    //   # New field: 50000 Statement No. Imported.


    fields
    {
        modify("Bank Account No.")
        {
            CaptionML = ENU = 'Bank Account No.', FRA = 'N° compte bancaire';
        }
        modify("Statement No.")
        {
            CaptionML = ENU = 'Statement No.', FRA = 'N° relevé';
        }
        modify("Statement Ending Balance")
        {
            CaptionML = ENU = 'Statement Ending Balance', FRA = 'Solde final du relevé';
        }
        modify("Statement Date")
        {
            CaptionML = ENU = 'Statement Date', FRA = 'Date relevé';
        }
        modify("Balance Last Statement")
        {
            CaptionML = ENU = 'Balance Last Statement', FRA = 'Solde dernier relevé';
        }
        modify("Bank Statement")
        {
            CaptionML = ENU = 'Bank Statement', FRA = 'Relevé bancaire';
        }
        modify("Total Balance on Bank Account")
        {
            CaptionML = ENU = 'Total Balance on Bank Account', FRA = 'Solde total sur compte bancaire';
        }
        modify("Total Applied Amount")
        {
            CaptionML = ENU = 'Total Applied Amount', FRA = 'Montant lettré total';
        }
        modify("Total Transaction Amount")
        {
            CaptionML = ENU = 'Total Transaction Amount', FRA = 'Montant transaction total';
        }
        modify("Total Unposted Applied Amount")
        {
            CaptionML = ENU = 'Total Unposted Applied Amount', FRA = 'Montant lettré total non validé';
        }
        modify("Total Difference")
        {
            CaptionML = ENU = 'Total Difference', FRA = 'Total différence';
        }
        modify("Statement Type")
        {
            CaptionML = ENU = 'Statement Type', FRA = 'Type relevé';
            //OptionCaptionML = ENU = 'Bank Reconciliation,Payment Application', FRA = 'Rapprochement bancaire,Lettrage paiement';
        }
        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Post Payments Only")
        {
            CaptionML = ENU = 'Post Payments Only', FRA = 'Valider les paiements uniquement';
        }
        modify("Import Posted Transactions")
        {
            CaptionML = ENU = 'Import Posted Transactions', FRA = 'Importer les transactions validées';
            OptionCaptionML = ENU = ' ,Yes,No', FRA = ' ,Oui,Non';
        }
        modify("Total Outstd Bank Transactions")
        {
            CaptionML = ENU = 'Total Outstd Bank Transactions', FRA = 'Total transactions bancaires restantes';
        }
        modify("Total Outstd Payments")
        {
            CaptionML = ENU = 'Total Outstd Payments', FRA = 'Total paiements restants';
        }

        modify("Bank Account Balance (LCY)")
        {
            CaptionML = ENU = 'Bank Account Balance (LCY)', FRA = 'Solde compte bancaire (DS)';
        }
        modify("Total Positive Adjustments")
        {
            CaptionML = ENU = 'Total Positive Adjustments', FRA = 'Ajustements positifs totaux';
        }
        modify("Total Negative Adjustments")
        {
            CaptionML = ENU = 'Total Negative Adjustments', FRA = 'Ajustements négatifs totaux';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        field(50000; "Statement No. Imported FND"; Text[250]) //BC Upgrade PATELP08  <<
        {
            Caption = 'Statement No. Imported';
            Description = 'HEI.01';
            Editable = false;
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "DuplicateStatementErr(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DuplicateStatementErr : @@@="%1=Statement No. value";ENU=Statement %1 already exists.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DuplicateStatementErr : @@@="%1=Statement No. value";ENU=Statement %1 already exists.;FRA=Le relevé %1 existe déjà.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "RenameErr(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //RenameErr : @@@="%1=Table name caption";ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RenameErr : @@@="%1=Table name caption";ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "BalanceQst(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //BalanceQst : @@@="%1=Balance Last Statement field caption;%2=field caption;%3=table caption";ENU=%1 is different from %2 on the %3. Do you want to change the value?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BalanceQst : @@@="%1=Balance Last Statement field caption;%2=field caption;%3=table caption";ENU=%1 is different from %2 on the %3. Do you want to change the value?;FRA=%1 est différent de %2 sur le %3. Souhaitez-vous modifier cette valeur ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "YouChangedDimQst(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //YouChangedDimQst : ENU=You may have changed a dimension.\\Do you want to update the lines?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //YouChangedDimQst : ENU=You may have changed a dimension.\\Do you want to update the lines?;FRA=Vous avez probablement modifié un axe analytique.\\Souhaitez-vous mettre à jour les lignes ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "NoBankAccountsMsg(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //NoBankAccountsMsg : ENU=You have not set up a bank account.\To use the payments import process, set up a bank account.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NoBankAccountsMsg : ENU=You have not set up a bank account.\To use the payments import process, set up a bank account.;FRA=Vous n'avez paramétré aucun compte bancaire.\Veuillez en paramétrer un pour utiliser le processus d'importation de paiements.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "NoBankAccWithFileFormatMsg(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //NoBankAccWithFileFormatMsg : ENU=No bank account exists that is ready for import of bank statement files.\Fill the Bank Statement Import Format field on the card of the bank account that you want to use.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NoBankAccWithFileFormatMsg : ENU=No bank account exists that is ready for import of bank statement files.\Fill the Bank Statement Import Format field on the card of the bank account that you want to use.;FRA=Il n'existe aucun compte bancaire prêt pour l'importation de fichiers de relevé bancaire.\Complétez le champ Format importation relevé bancaire sur la fiche du compte bancaire que vous souhaitez utiliser.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "PostHighConfidentLinesQst(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PostHighConfidentLinesQst : ENU=All imported bank statement lines were applied with high confidence level.\Do you want to post the payment applications?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PostHighConfidentLinesQst : ENU=All imported bank statement lines were applied with high confidence level.\Do you want to post the payment applications?;FRA=Toutes les lignes de relevé bancaire importées ont été lettrées avec un niveau de confiance élevé.\Voulez-vous valider les lettrages paiement ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "MustHaveValueQst(Variable 1015)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //MustHaveValueQst : ENU=The bank account must have a value in %1. Do you want to open the bank account card?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //MustHaveValueQst : ENU=The bank account must have a value in %1. Do you want to open the bank account card?;FRA=Le compte bancaire doit avoir une valeur dans %1. Voulez-vous ouvrir la fiche compte bancaire ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "NoTransactionsImportedMsg(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //NoTransactionsImportedMsg : ENU=No bank transactions were imported.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NoTransactionsImportedMsg : ENU=No bank transactions were imported.;FRA=Aucune transaction bancaire n'a été importée.;
    //Variable type has not been exported.
}

