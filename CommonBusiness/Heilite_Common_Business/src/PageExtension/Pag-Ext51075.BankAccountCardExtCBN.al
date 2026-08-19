pageextension 51075 BankAccountCardExtCBN extends "Bank Account Card"
{
    //  FINXL7.00.001 RBE 20/03/2013:  Added "Batch Booking" on Posting Info

    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD PTPGAP024 IBM.NAIKH01
    //   # Added a New button in the Menu for "Bank Cheque Order" Report.
    //   # Added new code on BankChequeOrder - OnAction().

    // HEI.02 PBA-RTRGAP02,03,04,05,06 IBM.NAIKH01 - Bahamas Bank Statement Import
    //   # Added new field "Import Format"
    // HEI.03 FDD BA-PTPGAP03 IBM NASTAA02 04.02.2019 # Digital Checks Printout
    //   # Added new Fields: "Check Electronic Signature", "Check Payment Format"
    // HEI.04 FDD HT453 IBM GAVANM01 20.06.2019 # Cheque Printing
    //   # Added new Fields: "Check Report ID", "Check Report Name"
    // HEI.05 FDD-HT664 IBM SURYAS01 02-jan-2020
    //   #Added New Fields: "Agency Code","RIB Key","RIB checked" In -"Transfer Tab"
    // HEI.06 FDD CHG2037399 IBM NANDIS01 17.03.2020 - Cheque Printing
    //   # Remove Field "Check Payment Format"
    // HEI.07 CHG2059040 BULIMC01 IBM 29.04.2020 # new fields added on Transfer tab
    //    "Exp. Payments Bank Report ID" and "Exp. Payments Bank Report Name"
    // HEI.08 CHG2086827 IBM POENAB02 Bank Connectivity DRC  complementing BRD HT84
    //   # New field in Transfer Group: "Activate Amount LCY DRC"
    // HEI.09 CHG2096435 HT1805 IBM GAVANM01 12.02.2021 - Invoice Layout
    //   # Added field 'Bank for invoice layout' in General Tab

    //Bc Upgrade YADAVM09 Drink it field blocked
    //#Agency Code
    //#RIB Key
    //#RIB Checked
    //#Batch Booking

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the bank account.', FRA = 'Spécifie le numéro du compte bancaire.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the bank where you have the bank account.', FRA = 'Spécifie le nom de la banque où vous avez ouvert le compte bancaire.';
        }
        modify("Bank Branch No.")
        {
            CaptionML = ENU = 'Bank Branch No.', FRA = 'Code établissement';
            ToolTipML = ENU = 'Specifies a number of the bank branch.', FRA = 'Spécifie un numéro de l''établissement de la banque.';
        }
        modify("Bank Account No.")
        {
            CaptionML = ENU = 'Bank Account No.', FRA = 'N° compte bancaire';
            ToolTipML = ENU = 'Specifies the number used by the bank for the bank account.', FRA = 'Spécifie le numéro utilisé par la banque pour le compte bancaire.';
        }
        modify("Search Name")
        {
            ToolTipML = ENU = 'Specifies a search name for the bank account.', FRA = 'Spécifie un nom de recherche pour le compte bancaire.';
        }
        modify(Balance)
        {
            ToolTipML = ENU = 'Specifies the bank account''s current balance denominated in the applicable foreign currency.', FRA = 'Spécifie le solde actuel du compte bancaire dans la devise étrangère applicable.';
        }
        modify("Balance (LCY)")
        {
            ToolTipML = ENU = 'Specifies the bank account''s current balance in LCY.', FRA = 'Spécifie le solde actuel du compte bancaire en DS.';
        }
        modify("Min. Balance")
        {
            ToolTipML = ENU = 'Specifies a minimum balance for the bank account.', FRA = 'Spécifie un solde minimum pour le compte bancaire.';
        }
        modify("Our Contact Code")
        {
            ToolTipML = ENU = 'Specifies a code to specify the employee who is responsible for this bank account.', FRA = 'Spécifie un code pour spécifier le nom de l''employé qui est responsable de ce compte bancaire.';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies that transactions with the bank account cannot be posted.', FRA = 'Spécifie que les transactions avec le compte bancaire ne peuvent pas être validées.';
        }
        modify("SEPA Direct Debit Exp. Format")
        {
            ToolTipML = ENU = 'Specifies the SEPA format of the bank file that will be exported when you choose the Create Direct Debit File button in the Direct Debit Collect. Entries window.', FRA = 'Spécifie le format SEPA du fichier de banque qui est exporté lorsque vous choisissez le bouton Créer fichier prélèvement automatique dans la fenêtre Écritures recouvrement prélèvement.';
        }
        modify("Credit Transfer Msg. Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series for bank instruction messages that are created with the export file that you create from the Direct Debit Collect. Entries window.', FRA = 'Spécifie la souche de numéros pour les messages d''instruction bancaire qui sont créés avec le fichier d''exportation que vous créez depuis la fenêtre Écritures recouvrement prélèvement.';
        }
        modify("Direct Debit Msg. Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series that will be used on the direct debit file that you export for a direct-debit collection entry in the Direct Debit Collect. Entries window.', FRA = 'Spécifie la souche de numéros qui sera utilisée sur le fichier prélèvement que vous exportez pour une écriture recouvrement prélèvement dans la fenêtre Écritures recouvrement prélèvement.';
        }
        modify("Creditor No.")
        {
            ToolTipML = ENU = 'Specifies your company as the creditor in connection with payment collection from customers using SEPA Direct Debit.', FRA = 'Spécifie votre société en tant que créditeur en relation avec la collection des paiements de clients utilisant le prélèvement SEPA.';
        }

        // modify("Bank Name - Data Conversion")
        // {
        //     ToolTipML = ENU = 'Specifies your bank''s data format to enable conversion of bank data by a service provider when you import and export bank files.', FRA = 'Spécifie le format de vos données bancaires pour activer la conversion des données bancaires par un fournisseur de services lorsque vous importez et exportez des fichiers de banque.';
        // }//BC Upgrade SHARMP16 field obselete in Business Central
        modify("Bank Clearing Standard")
        {
            ToolTipML = ENU = 'Specifies the format standard to be used in bank transfers if you use the Bank Clearing Code field to identify you as the sender.', FRA = 'Spécifie la norme de format à utiliser dans des transferts bancaires si vous utilisez le champ Code compensation bancaire pour vous identifier en tant qu''expéditeur.';
        }
        modify("Bank Clearing Code")
        {
            ToolTipML = ENU = 'Specifies the code for bank clearing that is required according to the format standard you selected in the Bank Clearing Standard field.', FRA = 'Spécifie le code pour la compensation bancaire qui est requis selon la norme de format que vous avez sélectionnée dans le champ Standard compensation bancaire.';
        }
        modify(OnlineFeedStatementStatus)
        {
            CaptionML = ENU = 'Bank Account Linking Status', FRA = 'Statut de la liaison des comptes bancaires';
            ToolTipML = ENU = 'Specifies if the bank account is linked to an online bank account through the bank statement service.', FRA = 'Spécifie si le compte bancaire est lié à un compte bancaire en ligne via le service de relevés bancaires.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies the date when the Bank Account card was last modified.', FRA = 'Spécifie la date à laquelle la fiche compte bancaire a été modifiée pour la dernière fois.';
        }
        modify("Payment Match Tolerance")
        {
            CaptionML = ENU = 'Payment Match Tolerance', FRA = 'Écart de correspondance paiement';
        }
        modify("Match Tolerance Type")
        {
            ToolTipML = ENU = 'Specifies by which tolerance the automatic payment application function will apply the Amount Incl. Tolerance Matched rule for this bank account.', FRA = 'Spécifie suivant quel écart la fonction d''application de paiement automatique appliquera la règle Correspondance montant avec écart pour ce compte bancaire.';
        }
        modify("Match Tolerance Value")
        {
            ToolTipML = ENU = 'Specifies if the automatic payment application function will apply the Amount Incl. Tolerance Matched rule by Percentage or Amount.', FRA = 'Spécifie si la fonction d''application de paiement automatique appliquera la règle Correspondance montant avec écart par pourcentage ou par montant.';
        }
        modify(Communication)
        {
            CaptionML = ENU = 'Communication', FRA = 'Communication';
        }
        modify(Address)
        {
            ToolTipML = ENU = 'Specifies the address of the bank where you have the bank account.', FRA = 'Spécifie l''adresse de la banque où vous avez ouvert le compte bancaire.';
        }
        modify("Address 2")
        {
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';
        }
        modify("Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify(City)
        {
            ToolTipML = ENU = 'Specifies the city of the bank where you have the bank account.', FRA = 'Spécifie la ville de la banque où vous avez ouvert le compte bancaire.';
        }
        modify("Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region of the address.', FRA = 'Spécifie le pays/la région de l''adresse.';
        }
        modify("Phone No.")
        {
            ToolTipML = ENU = 'Specifies the telephone number of the bank where you have the bank account.', FRA = 'Spécifie le numéro de téléphone de la banque où se trouve le compte bancaire.';
        }
        modify(Contact)
        {
            ToolTipML = ENU = 'Specifies the name of the bank employee regularly contacted in connection with this bank account.', FRA = 'Spécifie le nom de l''employé de banque contacté au sujet de ce compte bancaire.';
        }
        modify("Phone No.2")
        {
            CaptionML = ENU = 'Phone No.', FRA = 'N° téléphone';
            ToolTipML = ENU = 'Specifies the telephone number of the bank where you have the bank account.', FRA = 'Spécifie le numéro de téléphone de la banque où se trouve le compte bancaire.';
        }
        modify("Fax No.")
        {
            ToolTipML = ENU = 'Specifies the fax number of the bank where you have the bank account.', FRA = 'Spécifie le numéro de télécopie de la banque où se trouve le compte bancaire.';
        }
        modify("E-Mail")
        {
            ToolTipML = ENU = 'Specifies the email address associated with the bank account.', FRA = 'Spécifie l''adresse e-mail qui est associée au compte bancaire.';
        }
        modify("Home Page")
        {
            ToolTipML = ENU = 'Specifies the home page address associated with the bank account.', FRA = 'Spécifie la page d''accueil qui est associée au compte bancaire.';
        }
        modify(Posting)
        {
            CaptionML = ENU = 'Posting', FRA = 'Validation';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the relevant currency code for the bank account.', FRA = 'Spécifie le code devise approprié pour le compte bancaire.';
        }
        modify("Last Check No.")
        {
            ToolTipML = ENU = 'Specifies the check number of the last check issued from the bank account.', FRA = 'Spécifie le numéro du dernier chèque émis sur le compte bancaire.';
        }
        modify("Transit No.")
        {
            ToolTipML = ENU = 'Specifies a bank identification number of your own choice.', FRA = 'Spécifie un numéro d''identification bancaire de votre choix.';
        }
        modify("Last Statement No.")
        {
            ToolTipML = ENU = 'Specifies the number of the last bank account statement that was reconciled with this bank account.', FRA = 'Spécifie le numéro du dernier relevé bancaire qui a été rapproché avec ce compte bancaire.';
        }
        modify("Last Payment Statement No.")
        {
            ToolTipML = ENU = 'Specifies the last bank statement that was imported.', FRA = 'Spécifie le dernier relevé bancaire qui a été importé.';
        }
        modify("Balance Last Statement")
        {
            ToolTipML = ENU = 'Specifies the balance amount of the last statement reconciliation on the bank account.', FRA = 'Spécifie le solde du dernier rapprochement de relevé du compte bancaire.';
        }
        modify("Bank Acc. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a code for the bank account posting group for the bank account.', FRA = 'Spécifie un code pour le groupe comptabilisation banque du compte bancaire.';
        }
        modify(Transfer)
        {
            CaptionML = ENU = 'Transfer', FRA = 'Virement';
        }
        modify("Bank Branch No.2")
        {
            CaptionML = ENU = 'Bank Branch No.', FRA = 'Code établissement';
            ToolTipML = ENU = 'Specifies a number of the bank branch.', FRA = 'Spécifie un numéro de l''établissement de la banque.';
        }
        modify("Bank Account No.2")
        {
            CaptionML = ENU = 'Bank Account No.', FRA = 'N° compte bancaire';
            ToolTipML = ENU = 'Specifies the number used by the bank for the bank account.', FRA = 'Spécifie le numéro utilisé par la banque pour le compte bancaire.';
        }
        modify("Transit No.2")
        {
            CaptionML = ENU = 'Transit No.', FRA = 'N° interne';
            ToolTipML = ENU = 'Specifies a bank identification number of your own choice.', FRA = 'Spécifie un numéro d''identification bancaire de votre choix.';
        }
        modify("SWIFT Code")
        {
            ToolTipML = ENU = 'Specifies the international bank identifier code (SWIFT) of the bank where you have the account.', FRA = 'Spécifie le code SWIFT (code international d''identification bancaire) de la banque qui détient le compte.';
        }
        modify(IBAN)
        {
            ToolTipML = ENU = 'Specifies the bank account''s international bank account number.', FRA = 'Spécifie le numéro du compte bancaire international.';
        }
        modify("Bank Statement Import Format")
        {
            ToolTipML = ENU = 'Specifies the format of the bank statement file that can be imported into this bank account.', FRA = 'Spécifie le format du fichier de relevé bancaire qui peut être importé dans ce compte bancaire.';
        }
        modify("Payment Export Format")
        {
            ToolTipML = ENU = 'Specifies the format of the bank file that will be exported when you choose the Export Payments to File button in the Payment Journal window.', FRA = 'Spécifie le format du fichier de banque qui est exporté lorsque vous choisissez le bouton Exporter les paiements dans un fichier dans la fenêtre Feuille paiement.';
        }
        modify("Positive Pay Export Code")
        {
            ToolTipML = ENU = 'Specifies a code for the data exchange definition that manages the export of positive-pay files.', FRA = 'Spécifie un code pour la définition d''échange de données qui gère l''exportation de fichiers Positive Pay.';
        }
        addafter("Bank Clearing Standard")
        {
            field("Account Type"; Rec."Account Type FND")
            {
                CaptionML = ENU = 'Account Type';
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Account Type field.';
            }
        }
        addafter("Bank Clearing Code")
        {
            field("Import Format"; Rec."Import Format FND")
            {
                CaptionML = ENU = 'Import Format';
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Import Format field.';
            }
            field("Check Electronic Signature"; Rec."Check Electronic Signature FND")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                CaptionML = ENU = 'Check Electronic Signature',
                            FRA = 'Check Electronic Signature';
                Description = 'HEI.03';
                ToolTip = 'Specifies the value of the Check Electronic Signature field.';
            }
            field("Check Report ID"; Rec."Check Report ID")
            {
                CaptionML = ENU = 'Check Report ID';
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Check Report ID field.';
                trigger OnValidate();
                begin
                    CurrPage.UPDATE();  //HEI.04
                end;
            }
            field("Check Report Name"; Rec."Check Report Name")
            {
                CaptionML = ENU = 'Check Report Name';
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Check Report Name field.';
            }
            field("Bank for invoice layout"; Rec."Bank for invoice layout FND")
            {
                CaptionML = ENU = 'Bank for invoice layout';
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Bank for invoice layout field.';
            }
        }
        addafter("Match Tolerance Value")
        {
            field("IBAN Matching Criteria"; Rec."IBAN Matching Criteria FND")
            {
                CaptionML = ENU = 'IBAN Matching Criteria';
                ApplicationArea = basic, suite;
                ToolTip = 'Specifies the value of the IBAN Matching Criteria field.';
            }
            field("Suspense Acc. for Paym. Reconc"; Rec."SuspnsAcc. for Paym.Reconc FND")
            {
                CaptionML = ENU = 'Suspense Acc. for Paym. Reconc';
                ApplicationArea = basic, suite;
                ToolTip = 'Specifies the value of the Suspense Acc. for Paym. Reconciliaton field.';
            }
        }
        /* //Bc Upgrade YADAVM09 Drink it field>>
        addafter("Bank Acc. Posting Group")
        {
            field("Batch Booking"; Rec."Batch Booking")
            {
                CaptionML = ENU = 'Batch Booking';
                ApplicationArea = basic, suite;

                Description = 'FINXL7.00.001';
            }
        }
         
        addafter("Bank Branch No.2")
        {
            field("Agency Code"; Rec."Agency Code")
            {
                CaptionML = ENU = 'Agency Code';
                ApplicationArea = basic, suite;
            }
        }
        addafter("Bank Account No.2")
        {
            field("RIB Key"; Rec."RIB Key")
            {
                CaptionML = ENU = 'RIB Key';
                ApplicationArea = basic, suite;
            }
            field("RIB Checked"; Rec."RIB Checked")
            {
                CaptionML = ENU = 'RIB Checked';
                ApplicationArea = basic, suite;
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it field<<
        addafter("Payment Export Format")
        {
            field("Electronic Pmt. Setup"; Rec."Electronic Pmt. Setup FND")
            {
                CaptionML = ENU = 'Electronic Pmt. Setup';
                ApplicationArea = basic, suite;
                ToolTip = 'Specifies the value of the Electronic Pmt. Setup field.';
            }
            field("Vendor Payment File"; Rec."Vendor Payment File FND")
            {
                CaptionML = ENU = 'Vendor Payment File';
                ApplicationArea = basic, suite;
                ToolTip = 'Specifies the value of the Vendor Payment File field.';
            }
        }
        addafter("Positive Pay Export Code")
        {
            field("Exp. Payments Bank Report ID"; Rec."Exp. Payments Bank Rep ID FND")
            {
                CaptionML = ENU = 'Exp. Payments Bank Report ID';
                ApplicationArea = basic, suite;
                ToolTip = 'Specifies the value of the Export Bank Payments Report ID field.';
            }
            field("Exp. Payments Bank Report Name"; Rec."Exp. Payment Bank Rep Name FND")
            {
                CaptionML = ENU = 'Exp. Payments Bank Report Name';
                ApplicationArea = basic, suite;
                ToolTip = 'Specifies the value of the Export Bank Payments Report Name field.';
            }
            field("Activate Amount LCY DRC"; Rec."Activate Amount LCY DRC FND")
            {
                CaptionML = ENU = 'Activate Amount LCY DRC';
                ApplicationArea = basic, suite;
                ToolTip = 'Specifies the value of the Activate Amount LCY DRC field.';
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
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        // modify(Balance)
        // {
        //     CaptionML = ENU = 'Balance', FRA = 'Solde';
        //     ToolTipML = ENU = 'View a summary of the bank account balance at different periods.', FRA = 'Affichez un résumé du solde compte bancaire à différentes périodes.';
        // }//BC Upgrade SHARMP16 action obselete.
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
            ToolTipML = ENU = 'Open the list of business contacts.', FRA = 'Ouvrez la liste des contacts professionnels.';
        }
        modify("Online Map")
        {
            CaptionML = ENU = 'Online Map', FRA = 'Online Map';
            ToolTipML = ENU = 'View the address on an online map.', FRA = 'Affichez l''adresse sur une carte en ligne.';
        }
        modify(PagePositivePayEntries)
        {
            CaptionML = ENU = 'Positive Pay Entries', FRA = 'Écritures Positive Pay';
            ToolTipML = ENU = 'View the bank ledger entries that are related to Positive Pay transactions.', FRA = 'Affichez les écritures comptables banque relatives aux transactions Positive Pay.';
        }
        modify(BankAccountReconciliations)
        {
            CaptionML = ENU = 'Payment Reconciliation Journals', FRA = 'Feuilles rapprochement bancaire';
            ToolTipML = ENU = 'Reconcile your bank account by importing transactions and applying them, automatically or manually, to open customer ledger entries, open vendor ledger entries, or open bank account ledger entries.', FRA = 'Effectuez un rapprochement de votre compte bancaire en important les transactions, puis en les lettrant, manuellement ou automatiquement, avec les écritures comptables client, les écritures comptables fournisseur ou les écritures comptables banque.';
        }
        modify("Receivables-Payables")
        {
            CaptionML = ENU = 'Receivables-Payables', FRA = 'Échéancier';
            ToolTipML = ENU = 'View a summary of receivables for customers and payables for vendors.', FRA = 'Affichez un résumé des soldes dus des clients et des soldes dus des fournisseurs.';
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
        modify(AutomaticBankStatementImportSetup)
        {
            CaptionML = ENU = 'Automatic Bank Statement Import Setup', FRA = 'Configuration de l''importation de relevés bancaires automatique';
            ToolTipML = ENU = 'Set up the information for importing bank statement files.', FRA = 'Configurez les informations pour l''importation de fichiers de relevé bancaire.';
        }
        modify("Cash Receipt Journals")
        {
            CaptionML = ENU = 'Cash Receipt Journals', FRA = 'Feuilles règlement';
            ToolTipML = ENU = 'Create a cash receipt journal line for the bank account, for example, to post a payment receipt.', FRA = 'Créez une ligne feuille règlement pour le compte bancaire, par exemple, pour valider un reçu de paiement.';
        }
        modify("Payment Journals")
        {
            CaptionML = ENU = 'Payment Journals', FRA = 'Feuilles paiement';
            ToolTipML = ENU = 'Create a payment journal line for the bank account, for example, to post a payment.', FRA = 'Créez une ligne feuille règlement pour le compte bancaire, par exemple, pour valider un paiement.';
        }
        modify(PagePosPayExport)
        {
            CaptionML = ENU = 'Positive Pay Export', FRA = 'Exportation Positive Pay';
            ToolTipML = ENU = 'Export a Positive Pay file with relevant payment information that you then send to the bank for reference when you process payments to make sure that your bank only clears validated checks and amounts.', FRA = 'Exportez un fichier Positive Pay avec des informations de paiement pertinentes que vous envoyez à la banque pour référence lorsque vous traitez les paiements afin de vous assurer que votre banque efface uniquement les chèques et les montants validés.';
        }
        modify(List)
        {
            CaptionML = ENU = 'List', FRA = 'Liste';
            ToolTipML = ENU = 'View a list of general information about bank accounts, such as posting group, currency code, minimum balance, and balance.', FRA = 'Affichez une liste d''informations générales sur les comptes bancaires, par exemple le groupe comptabilisation, le code devise, le solde minimum et le solde.';
        }
        modify("Detail Trial Balance")
        {
            CaptionML = ENU = 'Detail Trial Balance', FRA = 'Grand livre';
            ToolTipML = ENU = 'View a detailed trial balance for selected checks.', FRA = 'Affichez la balance détaillée pour les chèques sélectionnés.';
        }
        modify(Action1906306806)
        {
            CaptionML = ENU = 'Receivables-Payables', FRA = 'Échéancier';
            ToolTipML = ENU = 'View a summary of receivables for customers and payables for vendors.', FRA = 'Affichez un résumé des soldes dus des clients et des soldes dus des fournisseurs.';
        }
        modify("Check Details")
        {
            CaptionML = ENU = 'Check Details', FRA = 'Liste chèques émis';
            ToolTipML = ENU = 'View a detailed trial balance for selected checks.', FRA = 'Affichez la balance détaillée pour les chèques sélectionnés.';
        }
        addafter("Receivables-Payables")
        {
            action(BankChequeOrder)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Cheque Order(BCO)';
                Image = "Report";
                ToolTip = 'Executes the Bank Cheque Order(BCO) action.';

                trigger OnAction();
                var
                    BaseCheck: Report "Check Base";
                begin
                    //>>HEI.01
                    CLEAR(BaseCheck);
                    BaseCheck.SetReqPageFilter(rec."No.");
                    BaseCheck.RUNMODAL;
                    //<<HEI.01
                end;
            }
        }
    }


    //Unsupported feature: PropertyModification on "Text001(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=There may be a statement using the %1.\\Do you want to change Balance Last Statement?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=There may be a statement using the %1.\\Do you want to change Balance Last Statement?;FRA=Il se peut qu'un relevé utilise %1.\\Voulez-vous modifier le solde du dernier relevé ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=Canceled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=Canceled.;FRA=Annulé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OnlineBankAccountLinkingErr(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OnlineBankAccountLinkingErr : ENU=You must link the bank account to an online bank account.\\Choose the Link to Online Bank Account action.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnlineBankAccountLinkingErr : ENU=You must link the bank account to an online bank account.\\Choose the Link to Online Bank Account action.;FRA=Vous devez lier le compte bancaire à un compte bancaire en ligne.\\Choisissez l'action Lier au compte bancaire en ligne.;
    //Variable type has not been exported.

    var
    // BaseCheck: Report "Check Base";

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

