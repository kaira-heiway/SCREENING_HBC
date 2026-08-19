pageextension 51009 ChartofAccountsExtCBN extends "Chart of Accounts"
{
    // version NAVW110.0,FINXL9.00.000.01,DITW110.00.08,HEI.08
    //     DITW16.00.00.41 AHU 31/08/2012 DIT-715 #327 Added fields "DIT Sub-Contract Posting Type",Collapse

    // FINXL7.00.001 RBE 20/03/2013 : Added fields "No. 2" and "Search Name" on page

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // HEI.01 FDD-BPMGAP015 IBM ISYED01 13.11.2017
    //   #added new page with respect to defect 943 EBF matrix button on the chart of account to display the settings filtered by each account
    // HEI.02 FDD-HT520 IBM.GUNERE01 26.08.2019
    //   # Added Report Trial Balance FR, Report Detail Trial Balance FR to Reports section
    //     in Page Actions
    // HEI.03 FDD-ET-MARAKI POS Interface IBM POSTOI01 # Maraki POS Interface
    //   # show field No Trading Partner field
    // HEI.04 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New action: Navigate -> "Apply Enties"
    //   # Code added in OnOpenPage()
    // HEI.05 FDD-HT1146 IBM-SURYAS01 19.03.2020
    //   #Added Fields "Direct Amount" and "Credit Amount"
    //   # Added "G/L Trial Balance DRC", "G/L Detail Trial Balance DRC" to Reports section
    //     in Page Actions

    // HEI.06 CHG2093754 IBM PANDES01 23.02.2021
    //   # Added New field "C&TP CODE".

    // HEI.07 CHG2171687 IBM SISUM01 15/03/2023 #changes on Page action EBF Matrix G/L Account - the page is run from code, setting an account range
    // HEI.08 CHG2171687 IBM SISUM01 19/05/2023 HB3907 EBF Matrix
    //   #test Page Action EBF Matrix G/L Account if new version is enable

    // BC Upgrade SHUKLP03 >>
    // HEI.03 => Added in interface page extension
    // BC Upgrade SHUKLPO3 <<
    //Bc Upgrade YADAVM09 field Acc Type Unblocked.


    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the No. of the G/L Account you are setting up.', FRA = 'Spécifie le N° du compte général que vous configurez.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the general ledger account.', FRA = 'Spécifie le nom du compte général.';
        }
        modify("Income/Balance")
        {
            ToolTipML = ENU = 'Specifies whether a general ledger account is an income statement account or a balance sheet account.', FRA = 'Spécifie si un compte général est un compte résultats ou un compte de bilan.';
        }
        modify("Account Category")
        {
            ToolTipML = ENU = 'Specifies the category of the G/L account.', FRA = 'Spécifie la catégorie du compte général.';
        }
        modify("Account Subcategory Descript.")
        {
            CaptionML = ENU = 'Account Subcategory', FRA = 'Sous-catégorie du compte';
            ToolTipML = ENU = 'Specifies the subcategory of the account category of the G/L account.', FRA = 'Spécifie la sous-catégorie de la catégorie du compte général.';
        }
        modify("Account Type")
        {
            ToolTipML = ENU = 'Specifies the purpose of the account. Newly created accounts are automatically assigned the Posting account type, but you can change this.', FRA = 'Spécifie l''objet du compte. Les comptes nouvellement créés sont automatiquement affectés au type de compte Comptabilisation, mais vous pouvez le modifier.';
        }
        modify("Direct Posting")
        {
            ToolTipML = ENU = 'Specifies whether you will be able to post directly or only indirectly to this general ledger account.', FRA = 'Spécifie si vous pouvez choisir d''enregistrer directement ou uniquement indirectement sur ce compte général.';
        }
        modify(Totaling)
        {
            ToolTipML = ENU = 'Specifies an account interval or a list of account numbers.', FRA = 'Spécifie un intervalle de comptes ou une liste de numéros de compte.';
        }
        modify("Gen. Posting Type")
        {
            ToolTipML = ENU = 'Specifies the general posting type to use when posting to this account.', FRA = 'Spécifie le type de validation à utiliser lors de la validation sur ce compte.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general business posting group that applies to the entry.', FRA = 'Spécifie le groupe comptabilisation marché qui s''applique à cette écriture.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a general product posting group code.', FRA = 'Spécifie un code groupe comptabilisation produit.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a VAT Bus. Posting Group.', FRA = 'Spécifie un Groupe compta. marché TVA.';
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a VAT Prod. Posting Group code.', FRA = 'Spécifie un code Groupe compta. produit TVA.';
        }
        modify("Net Change")
        {
            ToolTipML = ENU = 'Specifies the net change in the account balance during the time period in the Date Filter field.', FRA = 'Spécifie le solde période du compte pendant la période indiquée dans le champ Filtre date.';
        }
        modify("Balance at Date")
        {
            ToolTipML = ENU = 'Specifies the G/L account balance on the last date included in the Date Filter field.', FRA = 'Spécifie le solde du compte général à la dernière date incluse dans le champ Filtre date.';
        }
        modify(Balance)
        {
            ToolTipML = ENU = 'Specifies the balance on this account.', FRA = 'Spécifie le solde du compte.';
        }
        modify("Additional-Currency Net Change")
        {
            ToolTipML = ENU = 'Specifies the net change in the account balance.', FRA = 'Spécifie le solde période du compte.';
        }
        modify("Add.-Currency Balance at Date")
        {
            ToolTipML = ENU = 'Specifies the G/L account balance (in the additional reporting currency) on the last date included in the Date Filter field.', FRA = 'Spécifie (en devise report) le solde du compte à la dernière date incluse dans le champ Filtre date.';
        }
        modify("Additional-Currency Balance")
        {
            ToolTipML = ENU = 'Specifies the balance on this account, in the additional reporting currency.', FRA = 'Spécifie le solde de ce compte, dans la devise report.';
        }
        modify("Consol. Debit Acc.")
        {
            ToolTipML = ENU = 'Specifies the account number in a consolidated company to transfer credit balances.', FRA = 'Indique le numéro de compte d''une société consolidée vers laquelle transférer tous les soldes crédit.';
        }
        modify("Consol. Credit Acc.")
        {
            ToolTipML = ENU = 'Specifies if amounts without any payment tolerance amount from the customer and vendor ledger entries are used.', FRA = 'Spécifie si des montants sans écart de règlement des écritures comptables client et fournisseur sont utilisés.';
        }
        modify("Cost Type No.")
        {
            ToolTipML = ENU = 'Specifies a cost type number to establish which cost type a general ledger account belongs to.', FRA = 'Spécifie un numéro de type de coût pour connaître le type de coût auquel appartient un compte général.';
        }
        modify("Consol. Translation Method")
        {
            ToolTipML = ENU = 'Specifies the consolidation translation method that will be used for the account.', FRA = 'Spécifie la méthode de traduction de consolidation qui sera utilisée pour le compte.';
        }
        modify("Default IC Partner G/L Acc. No")
        {
            ToolTipML = ENU = 'Specifies accounts that you often enter in the Bal. Account No. field on intercompany journal or document lines.', FRA = 'Spécifie des comptes que vous entrez régulièrement dans le champ N° compte contrepartie de la feuille intersociété ou des lignes de document.';
        }
        modify("Default Deferral Template Code")
        {
            CaptionML = ENU = 'Default Deferral Template', FRA = 'Modèle échelonnement par défaut';
            ToolTipML = ENU = 'Specifies the default deferral template that governs how to defer revenues and expenses to the periods when they occurred.', FRA = 'Spécifie le modèle d''échelonnement par défaut qui régit la manière de reporter les revenus et les dépenses aux périodes auxquelles ils se sont produits.';
        }

        //Unsupported feature: Change SubPageLink on "Control1905532107(Control 1905532107)". Please convert manually.


        //Unsupported feature: CodeModification on "Totaling(Control 10).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GLaccList.LOOKUPMODE(TRUE);
        IF NOT (GLaccList.RUNMODAL = ACTION::LookupOK) THEN
          EXIT(FALSE);

        Text := GLaccList.GetSelectionFilter;
        EXIT(TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GLaccList.LOOKUPMODE(true);
        if not (GLaccList.RUNMODAL = ACTION::LookupOK) then
          exit(false);

        Text := GLaccList.GetSelectionFilter;
        exit(true);
        */
        //end;
        addafter("No.")
        {
            // field("No. 2"; Rec."No. 2")
            // {
            //     Description = 'FINXL7.00.001';
            // }  // BC Upgrade NANDIS03 - already shown in standard page

            field("HeiMatch Code"; Rec."HeiMatch Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the HeiMatch Code field.';
                // BC Upgrade NANDIS03                                                                                                                                                                                                              ToolTip = 'Specifies the value of the HeiMatch Code field.';

            }
            field("Std. Invoice Reference"; Rec."Std. Invoice Reference FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Std. Invoice Reference field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Std. Invoice Reference field.';

            }
            field("MR Code"; Rec."MR Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MR Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the MR Code field.';

            }
            field("CIL3 Code"; Rec."CIL3 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CIL3 Code field.';
                // BC Upgrade NANDIS0                ToolTip = 'Specifies the value of the CIL3 Code field.';

            }
            field("CIL account"; Rec."CIL account FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CIL account field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the CIL account field.';

            }
            field("C&TP CODE"; Rec."C&TP CODE FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the C&TP CODE field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the C&TP CODE field.';

            }
            field("Financial Statement version"; Rec."Financial Stmt version FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Financial Statement version field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Financial Statement version field.';

            }
            field("Local Name"; Rec."Local Name FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Local Name field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Local Name field.';

            }
        }
        addafter(Name)
        {
            field("Search Name"; Rec."Search Name")
            {
                Description = 'FINXL7.00.001';
                ApplicationArea = All;
                ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
            }
            // field("DIT Sub-Contract Posting Type";Rec."DIT Sub-Contract Posting Type")
            // {
            //     Style = Strong;
            //     StyleExpr = DITSubContrPstTypeEmphasize;
            //     Visible = false;
            // }
            // field(Collapse;Rec.Collapse)
            // {
            //     Visible = false;
            // }  // BC Upgrade NANDIS03
        }
        addafter("VAT Prod. Posting Group")
        {
            field("No Trading Partner"; Rec."No Trading Partner FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the No Trading Partner';
            }
        }

        addafter("Default Deferral Template Code")
        {
            //     field("Shortcut Property 1 Code"; Rec."Shortcut Property 1 Code")
            //     {
            //         Visible = false;
            //     }
            //     field("Shortcut Property 2 Code"; "Shortcut Property 2 Code")
            //     {
            //         Visible = false;
            //     }
            //     field("Shortcut Property 3 Code"; "Shortcut Property 3 Code")
            //     {
            //         Visible = false;
            //     }
            //     field("Shortcut Property 4 Code"; "Shortcut Property 4 Code")
            //     {
            //         Visible = false;
            //     }
            //     field("Shortcut Property 5 Code"; "Shortcut Property 5 Code")
            //     {
            //         Visible = false;
            //     }
            //     field("Shortcut Property 6 Code"; "Shortcut Property 6 Code")
            //     {
            //         Visible = false;
            //     }
            //     field("Shortcut Property 7 Code"; "Shortcut Property 7 Code")
            //     {
            //         Visible = false;
            //     }
            //     field("Shortcut Property 8 Code"; "Shortcut Property 8 Code")
            //     {
            //         Visible = false;
            //     }
            //     field("Shortcut Property 9 Code"; "Shortcut Property 9 Code")
            //     {
            //         Visible = false;
            //     }
            //     field("Shortcut Property 10 Code"; "Shortcut Property 10 Code")
            //     {
            //         Visible = false;
            //     }
            field("Acc Type"; Rec."Acc Type FND")
            {
                ApplicationArea = all;
            }
            //     field("No Trading Partner"; "No Trading Partner")
            //     {
            //     }
        }  // BC Upgrade NANDIS03
    }
    actions
    {
        modify("A&ccount")
        {
            CaptionML = ENU = 'A&ccount', FRA = '&Compte';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the history of transactions that have been posted for the selected record.', FRA = 'Affichez l''historique des transactions qui ont été validées pour l''enregistrement sélectionné.';

            //Unsupported feature: Change RunPageView on ""Ledger E&ntries"(Action 28)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Ledger E&ntries"(Action 28)". Please convert manually.

        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
            ToolTipML = ENU = 'Show or add comments.', FRA = 'Affichez ou ajoutez des commentaires.';

            //Unsupported feature: Change RunPageLink on ""Co&mments"(Action 25)". Please convert manually.

        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
        }
        modify("Dimensions-Single")
        {
            CaptionML = ENU = 'Dimensions-Single', FRA = 'Affectations - Simples';
            ToolTipML = ENU = 'View or edit the single set of dimensions that are set up for the selected record.', FRA = 'Affichez ou modifiez l''ensemble unique de dimensions paramétrées pour l''enregistrement sélectionné.';

            //Unsupported feature: Change RunPageLink on ""Dimensions-Single"(Action 84)". Please convert manually.

        }
        modify("Dimensions-&Multiple")
        {
            CaptionML = ENU = 'Dimensions-&Multiple', FRA = 'Affectations - &Multiples';
            ToolTipML = ENU = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.', FRA = 'Affichez ou modifiez les axes analytiques pour un groupe d''enregistrements. Vous pouvez affecter des codes axe aux transactions dans le but de répartir les coûts et d''analyser les informations d''historique.';
        }
        modify("E&xtended Texts")
        {
            CaptionML = ENU = 'E&xtended Texts', FRA = '&Textes étendus';
            ToolTipML = ENU = 'View additional information that has been added to the description for the current account.', FRA = 'Affichez des informations supplémentaires qui ont été ajoutées à la description pour le compte actuel.';

            //Unsupported feature: Change RunPageView on ""E&xtended Texts"(Action 23)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""E&xtended Texts"(Action 23)". Please convert manually.

        }
        modify("Receivables-Payables")
        {
            CaptionML = ENU = 'Receivables-Payables', FRA = 'Échéancier';
            ToolTipML = ENU = 'Show a summary of receivables and payables.', FRA = 'Affichez un résumé des clients et des fournisseurs.';
        }
        modify("Where-Used List")
        {
            CaptionML = ENU = 'Where-Used List', FRA = 'Liste des cas d''emploi';
            ToolTipML = ENU = 'Show setup tables where the current account is used.', FRA = 'Affichez des tables de configuration où le compte actuel est utilisé.';
        }
        modify("&Balance")
        {
            CaptionML = ENU = '&Balance', FRA = 'Sol&de';
        }
        modify("G/L &Account Balance")
        {
            CaptionML = ENU = 'G/L &Account Balance', FRA = 'Solde &compte général';
            ToolTipML = ENU = 'View a summary of the debit and credit balances for different time periods for the current account.', FRA = 'Affichez un résumé des soldes débit et crédit pour différentes périodes pour le compte actuel.';

            //Unsupported feature: Change RunPageLink on ""G/L &Account Balance"(Action 36)". Please convert manually.

        }
        modify("G/L &Balance")
        {
            CaptionML = ENU = 'G/L &Balance', FRA = '&Solde par compte';
            ToolTipML = ENU = 'View a summary of the debit and credit balances for different time periods for all accounts.', FRA = 'Affichez un résumé des soldes débit et crédit pour différentes périodes pour tous les comptes.';

            //Unsupported feature: Change RunPageLink on ""G/L &Balance"(Action 132)". Please convert manually.

        }
        modify("G/L Balance by &Dimension")
        {
            CaptionML = ENU = 'G/L Balance by &Dimension', FRA = 'Solde par &axe';
            ToolTipML = ENU = 'View a summary of the debit and credit balances by dimensions for all accounts.', FRA = 'Affichez un résumé des soldes débit et crédit par axe pour tous les comptes.';
        }
        modify("G/L Account Balance/Bud&get")
        {
            CaptionML = ENU = 'G/L Account Balance/Bud&get', FRA = '&Réalisé/Budget compte général';
            ToolTipML = ENU = 'View a summary of the debit and credit balances and the budgeted amounts for different time periods for the current account.', FRA = 'Affichez un résumé des soldes débit et crédit et des montants budgétés pour différentes périodes pour le compte actuel.';

            //Unsupported feature: Change RunPageLink on ""G/L Account Balance/Bud&get"(Action 53)". Please convert manually.

        }
        modify("G/L Balance/B&udget")
        {
            CaptionML = ENU = 'G/L Balance/B&udget', FRA = 'Réalisé/B&udget par compte';
            ToolTipML = ENU = 'View a summary of the debit and credit balances and the budgeted amounts for different time periods for the current account.', FRA = 'Affichez un résumé des soldes débit et crédit et des montants budgétés pour différentes périodes pour le compte actuel.';

            //Unsupported feature: Change RunPageLink on ""G/L Balance/B&udget"(Action 35)". Please convert manually.

        }
        modify("Chart of Accounts &Overview")
        {
            CaptionML = ENU = 'Chart of Accounts &Overview', FRA = 'Vue d''ensemble du plan c&omptable';
            ToolTipML = ENU = 'View the chart of accounts with different levels of detail where you can expand or collapse a section of the chart of accounts.', FRA = 'Affichez le plan comptable avec différents niveaux de détail où vous pouvez développer ou réduire une section du plan comptable.';
        }
        modify("G/L Register")
        {
            CaptionML = ENU = 'G/L Register', FRA = 'Historique des transactions comptabilité';
            ToolTipML = ENU = 'View posted G/L entries.', FRA = 'Affichez les écritures comptables validées.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(IndentChartOfAccounts)
        {
            CaptionML = ENU = 'Indent Chart of Accounts', FRA = 'Indenter plan comptable';
            ToolTipML = ENU = 'Indent accounts between a Begin-Total and the matching End-Total one level to make the chart of accounts easier to read.', FRA = 'Indentez des comptes entre un Début total et le Fin total correspondant d''un niveau pour que le plan comptable soit plus simple à lire.';
        }
        modify("Periodic Activities")
        {
            CaptionML = ENU = 'Periodic Activities', FRA = 'Activités périodiques';
        }
        modify("General Journal")
        {
            CaptionML = ENU = 'General Journal', FRA = 'Feuille comptabilité';
            ToolTipML = ENU = 'Open the general journal, for example, to record or post a payment that has no related document.', FRA = 'Ouvrez la feuille comptabilité, par exemple pour enregistrer ou valider un paiement qui n''a aucun document associé.';
        }
        modify("Close Income Statement")
        {
            CaptionML = ENU = 'Close Income Statement', FRA = 'Clôturer exercice comptable';
            ToolTipML = ENU = 'Start the transfer of the year''s result to an account in the balance sheet and close the income statement accounts.', FRA = 'Démarrez le transfert des résultats de l''année sur un compte de bilan et clôturez les comptes de gestion.';
        }
        modify(DocsWithoutIC)
        {
            CaptionML = ENU = 'Posted Documents without Incoming Document', FRA = 'Documents validés sans document entrant';
            ToolTipML = ENU = 'Show a list of posted purchase and sales documents under the G/L account that do not have related incoming document records.', FRA = 'Affichez une liste des documents ventes et achats validés sous le compte général qui n''a pas d''enregistrement de document entrant associé.';
        }
        modify("Detail Trial Balance")
        {
            CaptionML = ENU = 'Detail Trial Balance', FRA = 'Grand livre';
            ToolTipML = ENU = 'View a detail trial balance for the general ledger accounts that you specify.', FRA = 'Affichez un grand livre pour les comptes généraux que vous spécifiez.';
        }
        modify("Trial Balance")
        {
            CaptionML = ENU = 'Trial Balance', FRA = 'Balance';
            ToolTipML = ENU = 'View the chart of accounts that have balances and net changes.', FRA = 'Affichez le plan comptable avec soldes et soldes périodes.';
        }
        modify("Trial Balance by Period")
        {
            CaptionML = ENU = 'Trial Balance by Period', FRA = 'Balance par période';
            ToolTipML = ENU = 'View the opening balance by general ledger account, the movements in the selected period of month, quarter, or year, and the resulting closing balance.', FRA = 'Affichez le solde d''ouverture par compte général, les mouvements pour la période sélectionnée de mois, de trimestre ou d''année et le solde de clôture qui en résulte.';
        }
        modify(Action1900210206)
        {
            CaptionML = ENU = 'G/L Register', FRA = 'Historique des transactions comptabilité';
            ToolTipML = ENU = 'View posted G/L entries.', FRA = 'Affichez les écritures comptables validées.';
        }


        //Unsupported feature: CodeModification on "DocsWithoutIC(Action 5).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Account Type" = "Account Type"::Posting THEN
          PostedDocsWithNoIncBuf.SETRANGE("G/L Account No. Filter","No.")
        else
          IF Totaling <> '' THEN
            PostedDocsWithNoIncBuf.SETFILTER("G/L Account No. Filter",Totaling)
          else
            EXIT;
        PAGE.RUN(PAGE::"Posted Docs. With No Inc. Doc.",PostedDocsWithNoIncBuf);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Account Type" = "Account Type"::Posting then
          PostedDocsWithNoIncBuf.SETRANGE("G/L Account No. Filter","No.")
        else
          if Totaling <> '' then
            PostedDocsWithNoIncBuf.SETFILTER("G/L Account No. Filter",Totaling)
          else
            exit;
        PAGE.RUN(PAGE::"Posted Docs. With No Inc. Doc.",PostedDocsWithNoIncBuf);
        */
        //end;
        addafter("Co&mments")
        {
            // action(Properties)
            // {
            //     CaptionML = ENU = 'Properties',
            //                 FRA = 'Propriétés';
            //     Description = 'FINXL9.00';
            //     Image = Category;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Master Data Properties";
            //     RunPageLink = "Table ID" = CONST(15),
            //                   Code = FIELD("No.");
            // }  // BC Upgrade NANDIS03
            action("<EBF Matrix G/L Account>")
            {
                Caption = 'EBF Matrix GL Accounts';
                Description = 'FINXL9.00';
                Image = MapAccounts;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Executes the EBF Matrix GL Accounts action.';
                // BC Upgrade NANDIS03                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ToolTip = 'Executes the EBF Matrix GL Accounts action.';


                trigger OnAction();
                var
                    EBFMatrix: Record "Ebf Combination FND";
                    GLAcc: Record "G/L Account";
                    WhseSetup: Record "Warehouse Setup";
                    EBFMatrixGLAccount: Page "EBF Matrix G/L Account CBN";
                    Text001: Label 'Account range %1 is not allowed to be defined if Financial Statement is not %2';
                begin
                    //HEI.08>>
                    if not EBFMatrix.CheckNewEBFMatrixIsActive() then begin
                        EBFMatrixGLAccount.GetGLAccountRange(Rec."No.");
                        EBFMatrixGLAccount.RUNMODAL();
                    end else begin
                        //HEI.08<<
                        //HEI.07>>
                        WhseSetup.GET();
                        GLAcc.SETRANGE("No.", Rec."No.");
                        GLAcc.SETFILTER("Financial Stmt version FND", WhseSetup."SCOA Financial Statement FND");
                        if GLAcc.ISEMPTY then
                            ERROR(Text001, Rec."No.", WhseSetup."SCOA Financial Statement FND");
                        EBFMatrixGLAccount.GetGLAccountRange(Rec."No.");
                        EBFMatrixGLAccount.RUNMODAL();
                        //HEI.07<<
                    end; //HEI.08
                end;
            }
        }
        addafter("Where-Used List")
        {
            action("Apply Entries")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Apply Entries',
                            FRA = 'Lettrage des écritures';
                Enabled = FRLocAction;
                Image = ApplyEntries;
                // RunObject = Page "Apply G/L Entries";  // BC Upgrade NANDIS03
                // RunPageLink = "G/L Account No." = FIELD("No.");  // BC Upgrade NANDIS03
                ShortCutKey = 'Shift+F11';
                Visible = FRLocAction;
                ToolTip = 'Executes the Apply Entries action.';
            }
        }
        addafter("Detail Trial Balance")
        {
            action("Detail Trial Balance FR")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Detail Trial Balance FR',
                            FRA = 'Grand livre comptes généraux FR';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Detail Trial Balance LR CBN";
                ToolTip = 'Executes the Detail Trial Balance FR action.';
                //BC Upgrade NANDIS03                ToolTip = 'Executes the Detail Trial Balance FR action.';

            }
        }
        addafter("Trial Balance")
        {
            action("Trial Balance FR")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Trial Balance FR',
                            FRA = 'Balance comptes généraux FR';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Trial Balance LR CBN";
                ToolTip = 'Executes the Trial Balance FR action.';
                //BC Upgrade NANDIS03                ToolTip = 'Executes the Trial Balance FR action.';

            }
            action("<G/L Trial Balance DRC>")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'G/L Trial Balance - DRC',
                            FRA = 'Balance comptes généraux DRC';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "G/L Trial Balance DRC CBN";
                ToolTip = 'Executes the <G/L Trial Balance DRC> action.';
                // BC Upgrade NANDIS03                ToolTip = 'Executes the <G/L Trial Balance DRC> action.';

            }
            action("<G/L Detail Trial Balance DRC>")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'G/L Detail Trial Balance -DRC',
                            FRA = 'Grand livre comptes généraux DRC';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "G/L DetailTrialBalanceDRCCBN";
                ToolTip = 'Executes the <G/L Detail Trial Balance DRC> action.';
                // BC Upgrade NANDIS03                ToolTip = 'Executes the <G/L Detail Trial Balance DRC> action.';

            }
        }
    }

    var
        CompanyInfo: Record "Company Information";
        DITSubContrPstTypeEmphasize: Boolean;
        FRLocAction: Boolean;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    NoEmphasize := "Account Type" <> "Account Type"::Posting;
    NameIndent := Indentation;
    NameEmphasize := "Account Type" <> "Account Type"::Posting;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW17.00.01 DDR 27/11/2012 DIT-770 #001
    DITSubContrPstTypeEmphasize := "Account Type" <> "Account Type"::Posting;
    // >>DITW17.00.01 DDR DIT-715 #001
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    //HEI.04>>
    FRLocAction := false;
    CompanyInfo.GET;
    if CompanyInfo."Enable French Localization" then
      begin
        SETRANGE("G/L Entry Type Filter","G/L Entry Type Filter"::Definitive);
        FRLocAction := true;
      end;
    //HEI.04<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: Change Editable. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

