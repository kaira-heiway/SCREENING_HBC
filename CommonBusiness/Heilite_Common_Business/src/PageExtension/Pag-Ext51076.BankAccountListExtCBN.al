pageextension 51076 BankAccountListExtCBN extends "Bank Account List"
{
    // HEI.01 Defect 3669 IBM.NAIKH01 08.02.2019
    //   # Added new fields Balance,"Balance (LCY)","Balance at Date", "Balance at Date (LCY)"
    // HEI.02 FDD-HT520 IBM.GUNERE01 26.08.2019
    //   # Added Report Bank Acc. Trial Balance FR, Report Bank Acc Det Trial Balance FR to Reports section
    //     in Page Actions
    // HEI.03 FDD-HT1146 IBM SURYAS01 20/04/2020
    //   # Added Report "Bank Acc. Trial Balance DRC","Bank Acc Det Trial Balan DRC" to Reports section
    //     in Page Actions

    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the bank account.', FRA = 'Spécifie le numéro du compte bancaire.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the bank where you have the bank account.', FRA = 'Spécifie le nom de la banque où vous avez ouvert le compte bancaire.';
        }
        modify(OnlineFeedStatementStatus)
        {
            CaptionML = ENU = 'Bank Account Linking Status', FRA = 'Statut de la liaison des comptes bancaires';
            ToolTipML = ENU = 'Specifies if the bank account is linked to an online bank account through the bank statement service.', FRA = 'Spécifie si le compte bancaire est lié à un compte bancaire en ligne via le service de relevés bancaires.';
        }
        modify("Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the address.', FRA = 'Spécifie le code postal de l''adresse.';
        }
        modify("Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code of the address.', FRA = 'Spécifie le code pays/la région de l''adresse.';
        }
        modify("Phone No.")
        {
            ToolTipML = ENU = 'Specifies the telephone number of the bank where you have the bank account.', FRA = 'Spécifie le numéro de téléphone de la banque où se trouve le compte bancaire.';
        }
        modify("Fax No.")
        {
            ToolTipML = ENU = 'Specifies the fax number associated with the address.', FRA = 'Spécifie le numéro de télécopie qui est associé à l''adresse.';
        }
        modify(Contact)
        {
            ToolTipML = ENU = 'Specifies the name of the bank employee regularly contacted in connection with this bank account.', FRA = 'Spécifie le nom de l''employé de banque contacté au sujet de ce compte bancaire.';
        }
        modify("Bank Account No.")
        {
            ToolTipML = ENU = 'Specifies the number used by the bank for the bank account.', FRA = 'Spécifie le numéro utilisé par la banque pour le compte bancaire.';
        }
        modify("SWIFT Code")
        {
            ToolTipML = ENU = 'Specifies the international bank identifier code (SWIFT) of the bank where you have the account.', FRA = 'Spécifie le code SWIFT (code international d''identification bancaire) de la banque qui détient le compte.';
        }
        modify(IBAN)
        {
            ToolTipML = ENU = 'Specifies the bank account''s international bank account number.', FRA = 'Spécifie le numéro du compte bancaire international.';
        }
        modify("Our Contact Code")
        {
            ToolTipML = ENU = 'Specifies a code to specify the employee who is responsible for this bank account.', FRA = 'Spécifie un code pour spécifier le nom de l''employé qui est responsable de ce compte bancaire.';
        }
        modify("Bank Acc. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a code for the bank account posting group for the bank account.', FRA = 'Spécifie un code pour le groupe comptabilisation banque du compte bancaire.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the relevant currency code for the bank account.', FRA = 'Spécifie le code devise approprié pour le compte bancaire.';
        }
        modify("Language Code")
        {
            ToolTipML = ENU = 'Specifies a code that determines the language associated with this bank account.', FRA = 'Spécifie un code qui détermine la langue associée à ce compte bancaire.';
        }
        modify("Search Name")
        {
            ToolTipML = ENU = 'Specifies a search name for the bank account.', FRA = 'Spécifie un nom de recherche pour le compte bancaire.';
        }
        addafter("Search Name")
        {
            field("Balance at Date"; Rec."Balance at Date")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the bank account''s balance on the last date included in the Date Filter field.';
            }
            field("Balance at Date (LCY)"; Rec."Balance at Date (LCY)")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the bank account''s balance in LCY on the last date included in the Date Filter field.';
            }
        }
    }
    actions
    {
        modify("&Bank Acc.")
        {
            CaptionML = ENU = '&Bank Acc.', FRA = '&Banque';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
            ToolTipML = ENU = 'View statistical information, such as the value of posted entries, for the record.', FRA = 'Affichez les informations statistiques telles que la valeur des écritures validées pour l''enregistrement.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
            ToolTipML = ENU = 'Create a comment attached to the selected bank account.', FRA = 'Créez un commentaire joint au compte bancaire sélectionné.';
        }
        modify(PositivePayExport)
        {
            CaptionML = ENU = 'Positive Pay Export', FRA = 'Exportation Positive Pay';
            ToolTipML = ENU = 'Export a Positive Pay file with relevant payment information that you then send to the bank for reference when you process payments to make sure that your bank only clears validated checks and amounts.', FRA = 'Exportez un fichier Positive Pay avec des informations de paiement pertinentes que vous envoyez à la banque pour référence lorsque vous traitez les paiements afin de vous assurer que votre banque efface uniquement les chèques et les montants validés.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
        }
        modify("Dimensions-Single")
        {
            CaptionML = ENU = 'Dimensions-Single', FRA = 'Affectations - Simples';
            ToolTipML = ENU = 'View or edit the single set of dimensions that are set up for the selected record.', FRA = 'Affichez ou modifiez l''ensemble unique de dimensions paramétrées pour l''enregistrement sélectionné.';
        }
        modify("Dimensions-&Multiple")
        {
            CaptionML = ENU = 'Dimensions-&Multiple', FRA = 'Affectations - &Multiples';
            ToolTipML = ENU = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.', FRA = 'Affichez ou modifiez les axes analytiques pour un groupe d''enregistrements. Vous pouvez affecter des codes axe aux transactions dans le but de répartir les coûts et d''analyser les informations d''historique.';
        }
        // modify(Balance)
        // {
        //     CaptionML = ENU = 'Balance', FRA = 'Solde';
        //     ToolTipML = ENU = 'View a summary of the bank account balance at different periods.', FRA = 'Affichez un résumé du solde compte bancaire à différentes périodes.';
        // }
        modify(Statements)
        {
            CaptionML = ENU = 'St&atements', FRA = '&Relevés';
            ToolTipML = ENU = 'View posted bank statements and reconciliations.', FRA = 'Affichez des rapprochements et des comptes bancaires validés.';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the history of transactions that have been posted for the selected record.', FRA = 'Affichez l''historique des transactions qui ont été validées pour l''enregistrement sélectionné.';
        }
        modify("Chec&k Ledger Entries")
        {
            CaptionML = ENU = 'Chec&k Ledger Entries', FRA = 'Écritures comptables c&hèque';
            ToolTipML = ENU = 'View check ledger entries that result from posting transactions in a payment journal for the relevant bank account.', FRA = 'Affichez des écritures comptables chèque qui proviennent de la validation de transactions dans une feuille paiement pour le compte bancaire approprié.';
        }
        modify("C&ontact")
        {
            CaptionML = ENU = 'C&ontact', FRA = '&Contact';
            ToolTipML = ENU = 'View or edit detailed information about the contact person at the customer.', FRA = 'Affichez ou modifiez des informations détaillées concernant la personne à contacter chez le client.';
        }
        modify(CreateNewLinkedBankAccount)
        {
            CaptionML = ENU = 'Create New Linked Bank Account', FRA = 'Créer un compte bancaire lié';
            ToolTipML = ENU = 'Create a new online bank account to link to the selected bank account.', FRA = 'Créez un compte bancaire en ligne à lier au compte bancaire sélectionné.';
        }
        modify(LinkToOnlineBankAccount)
        {
            CaptionML = ENU = 'Link to Online Bank Account', FRA = 'Lier au compte bancaire en ligne';
            ToolTipML = ENU = 'Create a link to an online bank account from the selected bank account.', FRA = 'Créez un lien vers un compte bancaire en ligne depuis le compte bancaire sélectionné.';
        }
        modify(UnlinkOnlineBankAccount)
        {
            CaptionML = ENU = 'Unlink Online Bank Account', FRA = 'Détacher le compte bancaire en ligne';
            ToolTipML = ENU = 'Remove a link to an online bank account from the selected bank account.', FRA = 'Supprimez un lien vers un compte bancaire en ligne depuis le compte bancaire sélectionné.';
        }
        modify(UpdateBankAccountLinking)
        {
            CaptionML = ENU = 'Update Bank Account Linking', FRA = 'Mettre à jour la liaison des comptes bancaires';
            ToolTipML = ENU = 'Link any non-linked bank accounts to their related bank accounts.', FRA = 'Liez tous les comptes bancaires non liés à leur compte bancaire.';
        }
        modify(AutomaticBankStatementImportSetup)
        {
            CaptionML = ENU = 'Automatic Bank Statement Import Setup', FRA = 'Configuration de l''importation de relevés bancaires automatique';
            ToolTipML = ENU = 'Set up the information for importing bank statement files.', FRA = 'Configurez les informations pour l''importation de fichiers de relevé bancaire.';
        }
        modify(PagePosPayEntries)
        {
            CaptionML = ENU = 'Positive Pay Entries', FRA = 'Écritures Positive Pay';
            ToolTipML = ENU = 'View the bank ledger entries that are related to Positive Pay transactions.', FRA = 'Affichez les écritures comptables banque relatives aux transactions Positive Pay.';
        }
        modify("Detail Trial Balance")
        {
            CaptionML = ENU = 'Detail Trial Balance', FRA = 'Grand livre';
            ToolTipML = ENU = 'View a detailed trial balance for selected checks.', FRA = 'Affichez la balance détaillée pour les chèques sélectionnés.';
        }
        modify("Check Details")
        {
            CaptionML = ENU = 'Check Details', FRA = 'Liste chèques émis';
            ToolTipML = ENU = 'View a detailed trial balance for selected checks.', FRA = 'Affichez la balance détaillée pour les chèques sélectionnés.';
        }
        modify("Trial Balance by Period")
        {
            CaptionML = ENU = 'Trial Balance by Period', FRA = 'Balance par période';
            ToolTipML = ENU = 'View a detailed trial balance for selected checks within a selected period.', FRA = 'Affichez la balance détaillée pour les chèques sélectionnés sur une période donnée.';
        }
        modify("Trial Balance")
        {
            CaptionML = ENU = 'Trial Balance', FRA = 'Balance';
            ToolTipML = ENU = 'View a detailed trial balance for the selected bank account.', FRA = 'Affichez une balance détaillée pour le compte bancaire sélectionné.';
        }
        modify("Bank Account Statements")
        {
            CaptionML = ENU = 'Bank Account Statements', FRA = 'Relevés bancaires';
            ToolTipML = ENU = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.', FRA = 'Affichez les relevés des comptes bancaires sélectionnés. Pour chaque transaction bancaire, l''état affiche une description, un montant rapproché, un montant de relevé et d''autres informations.';
        }
        addafter("Detail Trial Balance")
        {
            action("Bank Acc. Detail Trial Balance FR")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Bank Acc. Detail Trial Balance FR',
                            FRA = 'Grand livre comptes bancaires FR';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "BankAccDetTrialBal LR CBN";
                ToolTip = 'Executes the Bank Acc. Detail Trial Balance FR action.';
                ////BC Upgrade SHARMP16 reports will compile later                ToolTip = 'Executes the Bank Acc. Detail Trial Balance FR action.';

            }
        }
        addafter("Trial Balance")
        {
            action("Bank Acc. Trial Balance FR")
            {
                ApplicationArea = Suite;
                CaptionML = ENU = 'Bank Acc. Trial Balance FR',
                            FRA = 'Balance comptes bancaires FR';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Bank Acc.Trial Balance LR CBN";
                ToolTip = 'Executes the Bank Acc. Trial Balance FR action.';
                //BC Upgrade SHARMP16 reports will compile later                ToolTip = 'Executes the Bank Acc. Trial Balance FR action.';

            }
        }
        addafter("Bank Account Statements")
        {
            action("<Bank Acc Det Trial Balan DRC")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Bank Acc. Detail Trial Balance DRC',
                            FRA = 'Grand livre comptes bancaires DRC';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "BankAccDetTrialBalanceDRCCBN";
                ToolTip = 'Executes the <Bank Acc Det Trial Balan DRC action.';
                //BC Upgrade SHARMP16 reports will compile later                ToolTip = 'Executes the <Bank Acc Det Trial Balan DRC action.';

            }
            action("<Bank Acc. Trial Balance DRC")
            {
                ApplicationArea = Suite;
                CaptionML = ENU = 'Bank Acc. Trial Balance DRC',
                            FRA = 'Balance comptes bancaires DRC';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "BankAcc.TrialBalanceDRC CBN";
                ToolTip = 'Executes the <Bank Acc. Trial Balance DRC action.';
                //BC Upgrade SHARMP16 reports will compile later                ToolTip = 'Executes the <Bank Acc. Trial Balance DRC action.';

            }
        }
    }


    //Unsupported feature: PropertyModification on "MultiselectNotSupportedErr(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //MultiselectNotSupportedErr : ENU=You can only link to one online bank account at a time.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //MultiselectNotSupportedErr : ENU=You can only link to one online bank account at a time.;FRA=Vous pouvez créer un lien vers un seul compte bancaire en ligne à la fois.;
    //Variable type has not been exported.

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

