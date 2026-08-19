pageextension 55006 AccountingManagerRoleCenterExt extends "Accounting Manager Role Center"
{
    // version NAVW110.0,MANXL7.00,DITW110.00.08

    //     MANXL7.00.001 WSA 12/08/2014 : Added Report Goods Shipped/Received not invoiced

    // DITW16.00.00.39 DDR 01/09/2011 DIT-715 #139 Modified caption menu id:10 VAT & TAX Statements
    //                                             Added menus
    //                                               Home\Account Schedules
    //                                               Home\Analysis by Dimensions
    //                                               Journals\Provision Shipping Cost Journal
    //                                               Posted Documents\Shipping Cost Document Entries
    //                                               Posted Documents\AAD Tracking Entries
    //                                               Posted Documents\Posted Periodic Discounts & Promotions
    //                                               Posted Documents\Posted Delayed Discounts & Promotions
    //                                             Disable control31 (new copy of Administration)

    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.05 WSA 04/08/14 DIT-770 #761 : Added menu Posted Documents\Invoice List
    // DITW17.10.04 MSF 11/11/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW19.00.07 MVN 25/01/2016 DIT-770 #1740: Removed Page 668 from Action

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Added in ActionContainer Report: "<Report G/L Detail Trial Balance", "<Report Bank Account Trial Balan", "<Report Bank Acc. Detail Trial B",
    //       "<Report FR Account Schedule>", "<Report Journals>" , "<Report Customer Journal>", "<Report Vendor Journal>", "<Report Bank Account Journal>",
    //       "<Report Payment List>", "<Report GL/Cust. Ledger Reconcil", "<Report GL/Vend. Ledger Reconcil"
    //   # Added in ActionGroup Journals: "<Page Payment Slip List>"
    //   # Added in ActionGroup "Posted Documents": "<Page Simulation Registers>", "<Page Payment Slip List Archive>"
    //   # Added in ActionGroup Administration: "<Page FR Account Schedule Names>"
    //   # Added ActionsItems: "<Page Payment Slip>", "<Page View/Edit Payment Line>", "<Page Payment Report>", "<Report Archive Payment Slips>",
    //       "<Codeunit Payment Management>"

    //Bc Upgrade YADAVM09 Drink it Pages and Reports are blocked.

    actions
    {
        modify("&G/L Trial Balance")
        {
            CaptionML = ENU = '&G/L Trial Balance', FRA = 'Balance comptes g&énéraux';
        }
        modify("&Bank Detail Trial Balance")
        {
            CaptionML = ENU = '&Bank Detail Trial Balance', FRA = 'Grand livre &bancaire';
        }
        modify("&Account Schedule")
        {
            CaptionML = ENU = '&Account Schedule', FRA = 'Tableau d''anal&yse';
        }
        modify("Bu&dget")
        {
            CaptionML = ENU = 'Bu&dget', FRA = 'Bu&dget';
        }
        modify("Trial Bala&nce/Budget")
        {
            CaptionML = ENU = 'Trial Bala&nce/Budget', FRA = 'Comparaison bala&nce/budget';
        }
        modify("Trial Balance by &Period")
        {
            CaptionML = ENU = 'Trial Balance by &Period', FRA = 'Balance par &période';
        }
        modify("&Fiscal Year Balance")
        {
            CaptionML = ENU = '&Fiscal Year Balance', FRA = '&Solde exercice comptable';
        }
        modify("Balance Comp. - Prev. Y&ear")
        {
            CaptionML = ENU = 'Balance Comp. - Prev. Y&ear', FRA = 'Comp. soldes - Anné&e préc.';
        }
        modify("&Closing Trial Balance")
        {
            CaptionML = ENU = '&Closing Trial Balance', FRA = 'Balance de &clôture';
        }
        modify("Cash Flow Date List")
        {
            CaptionML = ENU = 'Cash Flow Date List', FRA = 'Liste date trésorerie';
        }
        modify("Aged Accounts &Receivable")
        {
            CaptionML = ENU = 'Aged Accounts &Receivable', FRA = 'C&omptabilité client âgée';
        }
        modify("Aged Accounts Pa&yable")
        {
            CaptionML = ENU = 'Aged Accounts Pa&yable', FRA = 'Comptabilité &fournisseur âgée';
        }
        modify("Reconcile Cus&t. and Vend. Accs")
        {
            CaptionML = ENU = 'Reconcile Cus&t. and Vend. Accs', FRA = 'Concordance cp&tes clt/fourn.';
        }
        modify("&VAT Registration No. Check")
        {
            CaptionML = ENU = '&VAT Registration No. Check', FRA = '&Vérification n° identif. intracomm.';
        }
        modify("VAT E&xceptions")
        {
            CaptionML = ENU = 'VAT E&xceptions', FRA = 'E&xceptions TVA';
        }
        modify("VAT &Statement")
        {
            CaptionML = ENU = 'VAT &Statement', FRA = 'Décla&ration de TVA';
        }
        modify("VAT - VIES Declaration Dis&k")
        {
            CaptionML = ENU = 'VAT - VIES Declaration Dis&k', FRA = 'TVA - VIES : Déclaration (dis&quette)';
        }
        modify("EC Sales &List")
        {
            CaptionML = ENU = 'EC Sales &List', FRA = '&Liste des ventes UE';
        }

        modify("Cost Accounting P/L Statement")
        {
            CaptionML = ENU = 'Cost Accounting P/L Statement', FRA = 'Rapport pertes/profits de comptabilité analytique';
        }
        modify("CA P/L Statement per Period")
        {
            CaptionML = ENU = 'CA P/L Statement per Period', FRA = 'Rapport pertes/profits CA par période';
        }
        modify("CA P/L Statement with Budget")
        {
            CaptionML = ENU = 'CA P/L Statement with Budget', FRA = 'Rapport pertes/profits CA avec budget';
        }
        modify("Cost Accounting Analysis")
        {
            CaptionML = ENU = 'Cost Accounting Analysis', FRA = 'Analyse Comptabilité analytique';
        }
        modify("Chart of Accounts")
        {
            CaptionML = ENU = 'Chart of Accounts', FRA = 'Plan comptable';
        }
        modify(Vendors)
        {
            CaptionML = ENU = 'Vendors', FRA = 'Fournisseurs';
        }
        modify(VendorsBalance)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
        }
        modify("Purchase Orders")
        {
            CaptionML = ENU = 'Purchase Orders', FRA = 'Commandes achat';
        }
        modify(Budgets)
        {
            CaptionML = ENU = 'Budgets', FRA = 'Budgets';
        }
        modify("Bank Accounts")
        {
            CaptionML = ENU = 'Bank Accounts', FRA = 'Comptes bancaires';
        }
        modify("VAT Statements")
        {
            CaptionML = ENU = 'VAT & TAX Statements', FRA = 'Déclarations de TVA';

            //Unsupported feature: Change Name on ""VAT Statements"(Action 10)". Please convert manually.


            //Unsupported feature: Change Description on ""VAT Statements"(Action 10)". Please convert manually.

        }
        modify(Items)
        {
            CaptionML = ENU = 'Items', FRA = 'Articles';
        }
        modify(Customers)
        {
            CaptionML = ENU = 'Customers', FRA = 'Clients';
        }
        modify(CustomersBalance)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
        }
        modify("Sales Orders")
        {
            CaptionML = ENU = 'Sales Orders', FRA = 'Commandes vente';
        }
        modify(Reminders)
        {
            CaptionML = ENU = 'Reminders', FRA = 'Relances';
        }
        modify("Finance Charge Memos")
        {
            CaptionML = ENU = 'Finance Charge Memos', FRA = 'Factures d''intérêts';
        }
        modify("Incoming Documents")
        {
            CaptionML = ENU = 'Incoming Documents', FRA = 'Documents entrants';
        }
        modify(Journals)
        {
            CaptionML = ENU = 'Journals', FRA = 'Feuilles';

            //Unsupported feature: Change Name on "Journals(Action 107)". Please convert manually.

        }
        modify(PurchaseJournals)
        {
            CaptionML = ENU = 'Purchase Journals', FRA = 'Feuilles achat';
        }
        modify(SalesJournals)
        {
            CaptionML = ENU = 'Sales Journals', FRA = 'Feuilles vente';
        }
        modify(CashReceiptJournals)
        {
            CaptionML = ENU = 'Cash Receipt Journals', FRA = 'Feuilles règlement';
        }
        modify(ICGeneralJournals)
        {
            CaptionML = ENU = 'IC General Journals', FRA = 'Feuilles comptabilité IC';
        }
        modify(GeneralJournals)
        {
            CaptionML = ENU = 'General Journals', FRA = 'Feuilles comptabilité';
        }

        modify("Fixed Assets")
        {
            CaptionML = ENU = 'Fixed Assets', FRA = 'Immobilisations';
        }
        modify(Action17)
        {
            CaptionML = ENU = 'Fixed Assets', FRA = 'Immobilisations';
        }
        modify(Insurance)
        {
            CaptionML = ENU = 'Insurance', FRA = 'Assurance';
        }
        modify("Fixed Assets G/L Journals")
        {
            CaptionML = ENU = 'Fixed Assets G/L Journals', FRA = 'Feuilles comptabilisation immobilisations';
        }
        modify("Fixed Assets Journals")
        {
            CaptionML = ENU = 'Fixed Assets Journals', FRA = 'Feuilles immobilisations';
        }
        modify("Fixed Assets Reclass. Journals")
        {
            CaptionML = ENU = 'Fixed Assets Reclass. Journals', FRA = 'Feuilles reclass. immobilisations';
        }
        modify("Insurance Journals")
        {
            CaptionML = ENU = 'Insurance Journals', FRA = 'Feuilles assurance';
        }
        modify("<Action3>")
        {
            CaptionML = ENU = 'Recurring General Journals', FRA = 'Feuilles abonnement';
        }
        modify("Recurring Fixed Asset Journals")
        {
            CaptionML = ENU = 'Recurring Fixed Asset Journals', FRA = 'Feuilles abonnement immo.';
        }
        modify("Cash Flow")
        {
            CaptionML = ENU = 'Cash Flow', FRA = 'Trésorerie';
        }
        modify("Cash Flow Forecasts")
        {
            CaptionML = ENU = 'Cash Flow Forecasts', FRA = 'Prévisions de la trésorerie';
        }
        modify("Chart of Cash Flow Accounts")
        {
            CaptionML = ENU = 'Chart of Cash Flow Accounts', FRA = 'Plan comptable de trésorerie';
        }
        modify("Cash Flow Manual Revenues")
        {
            CaptionML = ENU = 'Cash Flow Manual Revenues', FRA = 'Revenus manuels de trésorerie';
        }
        modify("Cash Flow Manual Expenses")
        {
            CaptionML = ENU = 'Cash Flow Manual Expenses', FRA = 'Dépenses manuelles de trésorerie';
        }
        modify("Cost Accounting")
        {
            CaptionML = ENU = 'Cost Accounting', FRA = 'Comptabilité analytique';
        }
        modify("Cost Types")
        {
            CaptionML = ENU = 'Cost Types', FRA = 'Types de coûts';
        }
        modify("Cost Centers")
        {
            CaptionML = ENU = 'Cost Centers', FRA = 'Centres de coûts';
        }
        modify("Cost Objects")
        {
            CaptionML = ENU = 'Cost Objects', FRA = 'Objets de coûts';
        }
        modify("Cost Allocations")
        {
            CaptionML = ENU = 'Cost Allocations', FRA = 'Ventilations des coûts';
        }
        modify("Cost Budgets")
        {
            CaptionML = ENU = 'Cost Budgets', FRA = 'Budgets des coûts';
        }
        modify("Posted Documents")
        {
            CaptionML = ENU = 'Posted Documents', FRA = 'Documents validés';
        }
        modify("Posted Sales Invoices")
        {
            CaptionML = ENU = 'Posted Sales Invoices', FRA = 'Factures vente enregistrées';
        }
        modify("Posted Sales Credit Memos")
        {
            CaptionML = ENU = 'Posted Sales Credit Memos', FRA = 'Avoirs vente enregistrés';
        }
        modify("Posted Purchase Invoices")
        {
            CaptionML = ENU = 'Posted Purchase Invoices', FRA = 'Factures achat enregistrées';
        }
        modify("Posted Purchase Credit Memos")
        {
            CaptionML = ENU = 'Posted Purchase Credit Memos', FRA = 'Avoirs achat enregistrés';
        }
        modify("Issued Reminders")
        {
            CaptionML = ENU = 'Issued Reminders', FRA = 'Relances émises';
        }
        modify("Issued Fin. Charge Memos")
        {
            CaptionML = ENU = 'Issued Fin. Charge Memos', FRA = 'Factures d''intérêts émises';
        }
        modify("G/L Registers")
        {
            CaptionML = ENU = 'G/L Registers', FRA = 'Historiques des transactions comptabilité';
        }
        modify("Cost Accounting Registers")
        {
            CaptionML = ENU = 'Cost Accounting Registers', FRA = 'Historiques des transactions Comptabilité analytique';
        }
        modify("Cost Accounting Budget Registers")
        {
            CaptionML = ENU = 'Cost Accounting Budget Registers', FRA = 'Historiques des transactions budgétaires Comptabilité analytique';
        }
        modify(Administration)
        {
            CaptionML = ENU = 'Administration', FRA = 'Administration';

            //Unsupported feature: Change Visible on "Administration(Action 31)". Please convert manually.

        }
        modify(Currencies)
        {
            CaptionML = ENU = 'Currencies', FRA = 'Devises';
        }
        modify("Accounting Periods")
        {
            CaptionML = ENU = 'Accounting Periods', FRA = 'Périodes comptables';
        }
        modify("Number Series")
        {
            CaptionML = ENU = 'Number Series', FRA = 'Souche de numéros';
        }
        modify("Analysis Views")
        {
            CaptionML = ENU = 'Analysis Views', FRA = 'Vues d''analyse';
        }

        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Bank Account Posting Groups")
        {
            CaptionML = ENU = 'Bank Account Posting Groups', FRA = 'Groupes compta. banque';
        }
        modify("Sales &Credit Memo")
        {
            CaptionML = ENU = 'Sales &Credit Memo', FRA = '&Avoir vente';
        }
        modify("P&urchase Credit Memo")
        {
            CaptionML = ENU = 'P&urchase Credit Memo', FRA = 'A&voir achat';
        }
        modify(Tasks)
        {
            CaptionML = ENU = 'Tasks', FRA = 'Tâches';
        }
        modify("Cas&h Receipt Journal")
        {
            CaptionML = ENU = 'Cas&h Receipt Journal', FRA = 'Feuille règlemen&t';
        }

        modify("Analysis &Views")
        {
            CaptionML = ENU = 'Analysis &Views', FRA = '&Vues d''analyse';
        }

        modify("Calculate Deprec&iation")
        {
            CaptionML = ENU = 'Calculate Deprec&iation', FRA = 'Calculer amorti&ssement';
        }
        modify("Import Co&nsolidation from Database")
        {
            CaptionML = ENU = 'Import Co&nsolidation from Database', FRA = 'Importer co&nsolidation de base de données';
        }
        modify("Bank Account R&econciliation")
        {
            CaptionML = ENU = 'Bank Account R&econciliation', FRA = 'Rapproch&ement bancaire';
        }
        modify("Payment Reconciliation Journals")
        {
            CaptionML = ENU = 'Payment Reconciliation Journals', FRA = 'Feuilles rapprochement bancaire';
        }
        modify("Adjust E&xchange Rates")
        {
            CaptionML = ENU = 'Adjust E&xchange Rates', FRA = 'Ajuster tau&x de change';
        }
        modify("P&ost Inventory Cost to G/L")
        {
            CaptionML = ENU = 'P&ost Inventory Cost to G/L', FRA = 'Valider c&oûts ajustés en comptabilité';
        }
        modify("C&reate Reminders")
        {
            CaptionML = ENU = 'C&reate Reminders', FRA = 'C&réer relance';
        }
        modify("Create Finance Charge &Memos")
        {
            CaptionML = ENU = 'Create Finance Charge &Memos', FRA = 'Créer factures d''inté&rêts';
        }

        modify("Calc. and Pos&t VAT Settlement")
        {
            CaptionML = ENU = 'Calc. and Pos&t VAT Settlement', FRA = 'Calculer et valider &décl. TVA';
        }

        modify("General &Ledger Setup")
        {
            CaptionML = ENU = 'General &Ledger Setup', FRA = 'Paramètres comptabi&lité';
        }
        modify("&Sales && Receivables Setup")
        {
            CaptionML = ENU = '&Sales && Receivables Setup', FRA = 'Paramètres &ventes';
        }
        modify("&Purchases && Payables Setup")
        {
            CaptionML = ENU = '&Purchases && Payables Setup', FRA = 'Paramètres ac&hats';
        }
        modify("&Fixed Asset Setup")
        {
            CaptionML = ENU = '&Fixed Asset Setup', FRA = '&Paramètres immobilisations';
        }
        modify("Cash Flow Setup")
        {
            CaptionML = ENU = 'Cash Flow Setup', FRA = 'Paramètres trésorerie';
        }
        modify("Cost Accounting Setup")
        {
            CaptionML = ENU = 'Cost Accounting Setup', FRA = 'Paramètres comptabilité analytique';
        }
        modify(History)
        {
            CaptionML = ENU = 'History', FRA = 'Historique';
        }
        modify("Navi&gate")
        {
            CaptionML = ENU = 'Navi&gate', FRA = 'Navi&guer';
        }
        // addafter("&Bank Detail Trial Balance")
        // {
        //     action("G/L Detail Trial Balance")
        //     {
        //         CaptionML = ENU = 'G/L Detail Trial Balance',
        //                     FRA = 'Grand livre comptes généraux';
        //         Image = "Report";
        //         RunObject = Report "G/L Detail Trial Balance";
        //     }
        //     action("Bank Trial Balance")
        //     {
        //         CaptionML = ENU = 'Bank Trial Balance',
        //                     FRA = 'Balance bancaire';
        //         Image = "Report";
        //         RunObject = Report "Bank Account Trial Balance";
        //     }
        //     action(Action55002)
        //     {
        //         CaptionML = ENU = '&Bank Detail Trial Balance',
        //                     FRA = 'Grand livre &bancaire';
        //         Image = "Report";
        //         RunObject = Report "Bank Acc. Detail Trial Balance";
        //     }
        // }
        // addafter("&Account Schedule")
        // {
        //     action("FR Account Schedule")
        //     {
        //         CaptionML = ENU = 'FR Account Schedule',
        //                     FRA = 'Tableau analyse Bilan/Résultat';
        //         Image = "Report";
        //         RunObject = Report "FR Account Schedule";
        //     }
        // } //Bc Upgrade YADAVM09 French Localisation<<
        // addafter("Cost Accounting Analysis")
        // {
        // action("Goods Shipped/Received not invoiced")
        // {
        //     CaptionML = ENU = 'Goods Shipped/Received not invoiced',
        //                 FRA = 'Les marchandises expédiées / reçus pas facturés';
        //     Description = 'MANXL7.00.001';
        //     Image = Report2;
        //     RunObject = Report "Goods received/shipm. not inv.";
        // }
        // separator(Separator55012)
        // {
        // }//Bc Upgrade YADAVM09 Drink it report<<

        // action("Customer Journal")
        // {
        //     CaptionML = ENU = 'Customer Journal',
        //                 FRA = 'Journal comptes clients';
        //     Image = "Report";
        //     RunObject = Report "Customer Journal";
        // }
        // action("Vendor Journal")
        // {
        //     CaptionML = ENU = 'Vendor Journal',
        //                 FRA = 'Journal comptes fournisseurs';
        //     Image = "Report";
        //     RunObject = Report "Vendor Journal";
        // }
        // action("Bank Account Journal")
        // {
        //     CaptionML = ENU = 'Bank Account Journal',
        //                 FRA = 'Journal comptes bancaires';
        //     Image = "Report";
        //     RunObject = Report "Bank Account Journal";
        // } //Bc Upgrade YADAVM09 French localisation<<
        //     separator(Separator55007)
        //     {
        //     }
        //     action("Payments Lists")
        //     {
        //         CaptionML = ENU = 'Payments Lists',
        //                     FRA = 'Listes de règlements';
        //         Image = "Report";
        //         RunObject = Report "Payment List";
        //     }
        //     action("GL/Cust. Ledger Reconciliation")
        //     {
        //         CaptionML = ENU = 'GL/Cust. Ledger Reconciliation',
        //                     FRA = 'Rapprochement cpta. gén./client';
        //         Image = "Report";
        //         RunObject = Report "GL/Cust. Ledger Reconciliation";
        //     }
        //     action("GL/Vend. Ledger Reconciliation")
        //     {
        //         CaptionML = ENU = 'GL/Vend. Ledger Reconciliation',
        //                     FRA = 'Rapprochement cpta. gén./fourn.';
        //         Image = "Report";
        //         RunObject = Report "GL/Vend. Ledger Reconciliation";
        //     }
        // } //Bc Upgrade YADAVM09 French Localisation<<

        addafter("Cost Accounting Budget Registers")
        {
            // action("Payment Slips")
            // {
            //     CaptionML = ENU = 'Payment Slips',
            //                 FRA = 'Bordereaux paiement';
            //     RunObject = Page "Payment Slip List";
            // } //Bc Upgrade YADAVM09 Drink it field<<
            action("Provision Shipping Cost Journal")
            {
                CaptionML = ENU = 'Provision Shipping Cost Journal',
                            FRA = 'Feuille Provision - Coût transport';
                Description = 'DIT-715 #139';
                ToolTip = 'Provisional Shipping Cost Journal';
                ApplicationArea = All;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(General),
                                    Recurring = CONST(false));
            }
            // separator(Separator1100076040)
            // {
            //     IsHeader = true;
            // }
        }
        // addafter("Cost Accounting Budget Registers")
        // {
        //     action("Shipping Cost Document Entries")
        //     {
        //         CaptionML = ENU = 'Shipping Cost Document Entries',
        //                     FRA = 'Ecritures document coût transport';
        //         Description = 'DIT-715 #139';
        //         RunObject = Page "Shipping Hdr-Whse. Entries";
        //     }
        //     action("AAD Tracking Entries")
        //     {
        //         CaptionML = ENU = 'AAD Tracking Entries',
        //                     FRA = 'Ecritures DAA';
        //         Description = 'DIT-715 #139';
        //         RunObject = Page "AAD Tracking Entries";
        //     }
        //     action("Posted Periodic Discounts & Promotions")
        //     {
        //         CaptionML = ENU = 'Posted Periodic Discounts & Promotions',
        //                     FRA = 'Remises/Promotions périodiques enreg.';
        //         Description = 'DIT-715 #139';
        //         RunObject = Page "Sales Discount.-Promo. Entries";
        //     }
        //     action("Posted Delayed Discounts & Promotions")
        //     {
        //         CaptionML = ENU = 'Posted Delayed Discounts & Promotions',
        //                     FRA = 'Remises & Promotions (retardé) enregistées';
        //         Description = 'DIT-715 #139';
        //         RunObject = Page "Delayed Disc. & Promo. Entries";
        //     }
        //     action("Invoice List")
        //     {
        //         CaptionML = ENU = 'Invoice List',
        //                     FRA = 'Liste des factures';
        //         Description = 'DITW17.10.05  #761';
        //         RunObject = Page "Invoice List";
        //     }
        //     action("Simulation Registers")
        //     {
        //         CaptionML = ENU = 'Simulation Registers',
        //                     FRA = 'Hist. transactions simulation';
        //         RunObject = Page "Simulation Registers";
        //     }
        //     action("Payment Slip List Archives")
        //     {
        //         CaptionML = ENU = 'Payment Slip List Archives',
        //                     FRA = 'Archives liste bordereau paiement';
        //         RunObject = Page "Payment Slip List Archive";
        //     }
        // } // Bc Upgrade YADAVM09 Drink it Pages<<
        // addafter("Account Schedules")
        // {
        //     action("FR Account Schedules")
        //     {
        //         CaptionML = ENU = 'FR Account Schedules',
        //                     FRA = 'Tableaux analyse Bilan/Résultat';
        //         RunObject = Page "FR Account Schedule Names";
        //     }
        // } //Bc Upgrade YADAVM09 French Localisation<<
        addafter(Administration)
        {
            group(ActionGroup1100076002)
            {
                CaptionML = ENU = 'Administration',
                            FRA = 'Administration';
                action(Action1100076004)
                {
                    CaptionML = ENU = 'Accounting Periods',
                                FRA = 'Périodes comptables';
                    Image = AccountingPeriods;
                    ApplicationArea = All;
                    RunObject = Page "Accounting Periods";
                    ToolTip = 'Run Page Accounting Period';
                }
                action(Action1100076003)
                {
                    CaptionML = ENU = 'Currencies',
                                FRA = 'Devises';
                    ApplicationArea = All;
                    RunObject = Page Currencies;
                    ToolTip = 'Run page Currencies';
                }
                action(Action1100076006)
                {
                    CaptionML = ENU = 'Analysis Views',
                                FRA = 'Vues d''analyse';
                    ApplicationArea = All;
                    RunObject = Page "Analysis View List";
                    ToolTip = 'Run PAge Analysis View List';
                }
                action(Action1100076007)
                {
                    CaptionML = ENU = 'Account Schedules',
                                FRA = 'Tableaux d''analyse';
                    ApplicationArea = All;
                    RunObject = Page "Account Schedule Names";
                    ToolTip = 'Run page Account Schdule Names';
                }
                action(Action1100076008)
                {
                    CaptionML = ENU = 'Dimensions',
                                FRA = 'Axes analytiques';
                    Image = Dimensions;
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    RunObject = Page Dimensions;
                    ToolTip = 'Run Dimension Page';
                }
                action("Payment Terms")
                {
                    CaptionML = ENU = 'Payment Terms',
                                FRA = 'Conditions de paiement';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    RunObject = Page "Payment Terms";
                    ToolTip = 'Run Payment Terms Page';
                }
                action("Payment Methods")
                {
                    CaptionML = ENU = 'Payment Methods',
                                FRA = 'Modes de règlement';
                    ApplicationArea = All;//Bc Upgrade YADAVM09            
                    RunObject = Page "Payment Methods";
                    ToolTip = 'Run Payment Method Page';
                }
                action("Dimension Combinations")
                {
                    CaptionML = ENU = 'Dimension Combinations',
                                FRA = 'Croisements d''axes';
                    ApplicationArea = All;//Bc Upgrade YADAVM09            
                    RunObject = Page "Dimension List";
                    ToolTip = 'Run Dimension List Page';
                }
                action(Action1100076005)
                {
                    CaptionML = ENU = 'Number Series',
                                FRA = 'Souche de numéros';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    RunObject = Page "No. Series";
                    ToolTip = 'Run PAge No. Series';
                }
                action("Source Codes")
                {
                    CaptionML = ENU = 'Source Codes',
                                FRA = 'Codes journaux';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Source Code';
                    RunObject = Page "Source Codes";
                }
                action("Reason Codes")
                {
                    CaptionML = ENU = 'Reason Codes',
                                FRA = 'Codes motif';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Reason Code';
                    RunObject = Page "Reason Codes";
                }
                action("General Journal Templates")
                {
                    CaptionML = ENU = 'General Journal Templates',
                                FRA = 'Modèles feuille comptabilité';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    RunObject = Page "General Journal Templates";
                    ToolTip = 'Create and maintain journal templates that provide default settings for different types of general journal transactions.';
                }
                action("Item Journal Templates")
                {
                    CaptionML = ENU = 'Item Journal Templates',
                                FRA = 'Modèles feuille article';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    RunObject = Page "Item Journal Templates";
                    ToolTip = 'Set up and manage item journal templates used to organize inventory journal entries.';
                }
                action("User Setup")
                {
                    CaptionML = ENU = 'User Setup',
                                FRA = 'Paramètres utilisateur';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    RunObject = Page "User Setup";
                    ToolTip = 'Set up and manage user-specific permissions and business process settings.';
                }
                action("Approval User Setup")
                {
                    CaptionML = ENU = 'Approval User Setup',
                                FRA = 'Paramètres utilisateur approbation';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    RunObject = Page "Approval User Setup";
                    ToolTip = 'Set up approvers, approval limits, and other user-specific approval settings.';
                }
                action("Gen. Business Posting Groups")
                {
                    CaptionML = ENU = 'Gen. Business Posting Groups',
                                FRA = 'Groupes compta. marché';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Set up general business posting groups used to determine general ledger postings for business transactions.';
                    RunObject = Page "Gen. Business Posting Groups";
                }
                action("Gen. Product Posting Groups")
                {
                    CaptionML = ENU = 'Gen. Product Posting Groups',
                                FRA = 'Groupes compta. produit';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Set up general product posting groups used to determine general ledger postings for products and services.';
                    RunObject = Page "Gen. Product Posting Groups";
                }
                action(Customer)
                {
                    CaptionML = ENU = 'Customer',
                                FRA = 'Client';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Create, view, and manage customer information and related transactions.';
                    RunObject = Page "Customer Posting Groups";
                }
                action(Vendor)
                {
                    CaptionML = ENU = 'Vendor',
                                FRA = 'Fournisseur';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Set up and maintain vendor information used for purchasing, invoicing, and payables management.';
                    RunObject = Page "Vendor Posting Groups";
                }
                action("Fixed Asset")
                {
                    CaptionML = ENU = 'Fixed Asset',
                                FRA = 'Immobilisation';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'View and manage fixed assets, including asset information, depreciation settings, and related transactions.';
                    RunObject = Page "FA Posting Type Setup";
                }
                action(Action1100076009)
                {
                    CaptionML = ENU = 'Bank Account Posting Groups',
                                FRA = 'Groupes compta. banque';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Configure bank account posting groups used for posting bank transactions to the general ledger.';
                    RunObject = Page "Bank Account Posting Groups";
                }
                action(Inventory)
                {
                    CaptionML = ENU = 'Inventory',
                                FRA = 'Stocks';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Manage inventory items, stock levels, and item-related transactions.';
                    RunObject = Page "Inventory Posting Groups";
                }
                action("Item Charges")
                {
                    CaptionML = ENU = 'Item Charges',
                                FRA = 'Frais annexes';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Configure item charges used to allocate additional costs to inventory items and transactions.';
                    RunObject = Page "Item Charges";
                }
                action("Customer Template List")
                {
                    CaptionML = ENU = 'Customer Template List',
                                FRA = 'Liste des modèles client';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Set up and manage customer templates used to create new customers with predefined settings.';
                    RunObject = Page "Customer Templ. List";
                }
                // action("Vendor Template List")
                // {
                //     CaptionML = ENU = 'Vendor Template List',
                //                 FRA = 'Liste des modèles fournisseur';
                //     RunObject = Page "Vendor Template Gen. List";
                // }
                // action("Fixed Asset Template List")
                // {
                //     CaptionML = ENU = 'Fixed Asset Template List',
                //                 FRA = 'Liste modéle immobilisation';
                //     RunObject = Page "FA Template List";
                // }//Bc Upgrade YADAVM09 Drink it page<<
                action("VAT Business Posting Groups")
                {
                    CaptionML = ENU = 'VAT Business Posting Groups',
                                FRA = 'Groupes compta. marché TVA';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Configure VAT business posting groups used to calculate and post VAT for business transactions.';
                    RunObject = Page "VAT Business Posting Groups";
                }
                action("VAT Product Posting Groups")
                {
                    CaptionML = ENU = 'VAT Product Posting Groups',
                                FRA = 'Groupes compta. produit TVA';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Configure VAT product posting groups used to calculate and post VAT for items and services.';
                    RunObject = Page "VAT Product Posting Groups";
                }
                action("VAT Statement Names")
                {
                    CaptionML = ENU = 'VAT Statement Names',
                                FRA = 'Noms déclarations TVA';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Configure VAT statement names used for generating and managing VAT reports.';
                    RunObject = Page "VAT Statement Templates";
                }
                // action("Item Tax Groups")
                // {
                //     CaptionML = ENU = 'Item Tax Groups',
                //                 FRA = 'Groupes taxe article';
                //     RunObject = Page "Drink Item Tax Groups";
                // }
                // action("Customer Tax Groups")
                // {
                //     CaptionML = ENU = 'Customer Tax Groups',
                //                 FRA = 'Groupes taxe client';
                //     RunObject = Page "Drink Customer Tax Groups";
                // }
                // action("Vendor Tax Groups")
                // {
                //     CaptionML = ENU = 'Vendor Tax Groups',
                //                 FRA = 'Groupes taxe fournisseur';
                //     RunObject = Page "Drink Vendor Tax Groups";
                // }
                // action("Location Groups")
                // {
                //     CaptionML = ENU = 'Location Groups',
                //                 FRA = 'Groupes magasin';
                //     RunObject = Page "Location Groups";
                // }
                // action("Tax Specifications")
                // {
                //     CaptionML = ENU = 'Tax Specifications',
                //                 FRA = 'Spécification taxes';
                //     RunObject = Page "Tax Specifications";
                // }   //Bc Upgrade YADAVM09 Drink it Pages<<
                action("TAX Statement Templates")
                {
                    CaptionML = ENU = 'TAX Statement Templates',
                                FRA = 'Modèles déclaration Taxes';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Configure tax statement templates used for preparing and generating tax reports.';
                    RunObject = Page "VAT Statement Templates";
                }
                // action("Specification Templates (View Codes)")
                // {
                //     CaptionML = ENU = 'Specification Templates (View Codes)',
                //                 FRA = 'Modèles spécification (Codes vue)';
                //     RunObject = Page "View Specification Templates";
                // } 
                // action("Fiscal Representatives")
                // {
                //     CaptionML = ENU = 'Fiscal Representatives',
                //                 FRA = 'Représentants fiscaux';
                //     RunObject = Page "Fiscal Representatives List";
                // }
                // action("Tax Offices")
                // {
                //     CaptionML = ENU = 'Tax Offices',
                //                 FRA = 'Bureaux de taxe';
                //     RunObject = Page "Tax Office List";
                // }
                // action("Packaging Types")
                // {
                //     CaptionML = ENU = 'Packaging Types',
                //                 FRA = 'Types de Conditionnement';
                //     RunObject = Page "Packaging Types";
                // }
                // action("Wine Operation Codes")
                // {
                //     CaptionML = ENU = 'Wine Operation Codes',
                //                 FRA = 'Codes opération vin';
                //     RunObject = Page "Wine Operation Codes";
                // }
                // action("Wine Growing zones")
                // {
                //     CaptionML = ENU = 'Wine Growing zones',
                //                 FRA = 'Zones viticoles';
                //     RunObject = Page "Wine Growing zones";
                // }
                // action("Tax Product Categories")
                // {
                //     CaptionML = ENU = 'Tax Product Categories',
                //                 FRA = 'Catégories Produit taxe';
                //     RunObject = Page "Tax Product Categories";
                // }
                // action("Tax Products")
                // {
                //     CaptionML = ENU = 'Tax Products',
                //                 FRA = 'Produits taxe';
                //     RunObject = Page "Tax Products";
                // } //Bc Upgrade YADAVM09 Drink it Pages<<
                action("Tariff Numbers")
                {
                    CaptionML = ENU = 'Tariff Numbers',
                                FRA = 'Nomenclatures produits';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Set up and manage tariff numbers used to classify items for customs and international trade reporting.';
                    RunObject = Page "Tariff Numbers";
                }
                action("Transaction Types")
                {
                    CaptionML = ENU = 'Transaction Types',
                                FRA = 'Types de transactions';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Configure transaction types used to classify and report business transactions.';
                    RunObject = Page "Transaction Types";
                }
                action("Transport Methods")
                {
                    CaptionML = ENU = 'Transport Methods',
                                FRA = 'Modes de transport';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Configure transport methods used to determine how items are shipped or delivered.';
                    RunObject = Page "Transport Methods";

                }
                action("Transaction Specifications")
                {
                    CaptionML = ENU = 'Transaction Specifications',
                                FRA = 'Régimes';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Configure transaction specifications used to classify and analyze business transactions in detail.';
                    RunObject = Page "Transaction Specifications";
                }
                action("Entry/Exit Points")
                {
                    CaptionML = ENU = 'Entry/Exit Points',
                                FRA = 'Pays destination/provenance';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Configure entry and exit points used for customs and shipment tracking.';
                    RunObject = Page "Entry/Exit Points";
                }
                action(Areas)
                {
                    CaptionML = ENU = 'Areas',
                                FRA = 'Dépts destination/provenance';
                    ApplicationArea = All;//Bc Upgrade YADAVM09
                    ToolTip = 'Configure areas used to group locations for reporting and analysis.';
                    RunObject = Page Areas;
                }
                // action("Item Deposit Groups")
                // {
                //     CaptionML = ENU = 'Item Deposit Groups',
                //                 FRA = 'Groupes consigne article';
                //     RunObject = Page "Item Drink Deposit Groups";
                // }
                // action("Customer Deposit Groups")
                // {
                //     CaptionML = ENU = 'Customer Deposit Groups',
                //                 FRA = 'Groupes consigne client';
                //     RunObject = Page "Customer Drink Deposit Groups";
                // }
                // action("Vendor Deposit Groups")
                // {
                //     CaptionML = ENU = 'Vendor Deposit Groups',
                //                 FRA = 'Groupes consigne fournisseur';
                //     RunObject = Page "Vendor Drink Deposit Groups";
                // }
                // action("EDI Setup")
                // {
                //     CaptionML = ENU = 'EDI Setup',
                //                 FRA = 'Paramètres EDI';
                //     RunObject = Page "EDI Setup List";
                // }
                // action("EDI Data")
                // {
                //     CaptionML = ENU = 'EDI Data',
                //                 FRA = 'Données EDI';
                //     RunObject = Page "EDI Data List";
                // }//Bc Upgrade YADAVM09 Drink it Pages<<
            }
        }
        // addafter("Pa&yment Journal")
        // {
        //     action("Payment Slip")
        //     {
        //         CaptionML = ENU = 'Payment Slip',
        //                     FRA = 'Bordereau paiement';
        //         RunObject = Page "Payment Slip";
        //     }
        //     action("Look/Edit Payment Line")
        //     {
        //         CaptionML = ENU = 'Look/Edit Payment Line',
        //                     FRA = 'Consulter/Éditer ligne paiement';
        //         RunObject = Page "View/Edit Payment Line";
        //     }
        //     action("Payment Report")
        //     {
        //         CaptionML = ENU = 'Payment Report',
        //                     FRA = 'État règlement';
        //         RunObject = Page "Payment Report";
        //     }
        //     action("Archive Payment Journals")
        //     {
        //         CaptionML = ENU = 'Archive Payment Journals',
        //                     FRA = 'Archiver les feuilles paiement';
        //         Image = "Report";
        //         RunObject = Report "Archive Payment Slips";
        //     }
        //     action("Create Payment Slips")
        //     {
        //         CaptionML = ENU = 'Create Payment Slips',
        //                     FRA = 'Créer bordereaux paiement';
        //         RunObject = Codeunit "Payment Management";
        //     }
        // } //Bc Upgrade YADAVM09 French Localisation<<
        addafter("Pa&yment Journal")
        {
            action("Company Information")
            {
                CaptionML = ENU = 'Company Information',
                            FRA = 'Informations société';
                ApplicationArea = All;//Bc Upgrade YADAVM09
                ToolTip = 'Set up and manage company details used throughout the system for documents and reporting.';
                Image = CompanyInformation;
                RunObject = Page "Company Information";
            }
        }
        addafter("Cost Accounting Setup")
        {
            action("Inventory Setup")
            {
                CaptionML = ENU = 'Inventory Setup',
                            FRA = 'Paramètres stock';
                ApplicationArea = All;//Bc Upgrade YADAVM09
                ToolTip = 'Define settings that control inventory valuation, posting, and item management.';
                Image = InventorySetup;
                RunObject = Page "Inventory Setup";
            }
            action("Service Mgt. Setup")
            {
                CaptionML = ENU = 'Service Mgt. Setup',
                            FRA = 'Paramètres Gestion des services';
                ApplicationArea = All;//Bc Upgrade YADAVM09
                ToolTip = 'Define settings for service orders, contracts, and service-related posting and processes.';
                Image = ServiceSetup;
                RunObject = Page "Service Mgt. Setup";
            }
            //     action("Contract Mgt. Setup")
            //     {
            //         CaptionML = ENU = 'Contract Mgt. Setup',
            //                     FRA = 'Paramètres Gestion des contracts';
            //         Image = Setup;
            //         RunObject = Page "Property Service Mgt. Setup";
            //     }
            //     action("Purchase Contract Mgt. Setup")
            //     {
            //         CaptionML = ENU = 'Purchase Contract Mgt. Setup',
            //                     FRA = 'Paramètres Gestion des contracts achat';
            //         Image = Setup;
            //         RunObject = Page "Property Purch Serv Mgt. Setup";
            //     }
            //     action("Discount & Promotion Setup")
            //     {
            //         CaptionML = ENU = 'Discount & Promotion Setup',
            //                     FRA = 'Paramétrage Remise & Promotion';
            //         Image = Setup;
            //         RunObject = Page "Discount & Promotion Setup";
            //     }
            //     action("Discount & Promotion User Setup")
            //     {
            //         CaptionML = ENU = 'Discount & Promotion User Setup',
            //                     FRA = 'Paramétrage Remise & Promotion utilisateur';
            //         Image = UserSetup;
            //         RunObject = Page "Discount & Promo. User Setup";
            //     }
            //     action("Shipping-Warehouse Setup")
            //     {
            //         CaptionML = ENU = 'Shipping-Warehouse Setup',
            //                     FRA = 'Paramètres transport';
            //         Image = WarehouseSetup;
            //         RunObject = Page "Shipping-Warehouse Setup";
            //     } //Bc Upgrade YADAVM09 Drink it objects<<
        }
        addafter("Navi&gate")
        {
            separator(Separator1100076011)
            {
                IsHeader = true;
            }
        }
    }

    var


}

