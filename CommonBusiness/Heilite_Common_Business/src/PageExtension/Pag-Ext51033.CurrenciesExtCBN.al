pageextension 51033 CurrenciesExtCBN extends Currencies
{
    // version NAVW110.0,DITW110.00.08,HEI.02
    // DITW15.00.00.24 DDR 22/09/2008 Drink-It Tax rounding functionnalities
    //                                Added tab "Drink-it"
    //                                Added fields into tab "Drink-it"
    //                                  Amount Decimal Places
    //                                  Unit-Amount Decimal Places
    //                                  Amount Rounding Precision
    //                                  Unit-Amount Rounding Precision
    // DITW15.00.00.28,HLW15.00.01.01 DDR 28/11/2008 Added our bank no.

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    // HEI.01 V1.05 HT84 IBM POENAB02 01.04.2019
    //   # Field added: "ISO Currency Code"
    // HEI.02 CHG2225264 IBM SISUM01 27.12.2023 HB3640_BRD_GT_FX on Working capital payables & receivables (excluding derivatives)
    //   # Add new fields from table. The ones marked with HEI.02 in description
    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a currency code that you can select. The code must comply with ISO 4217.', FRA = 'Spécifie un code devise que vous pouvez sélectionner. Le code doit être conforme à ISO 4217.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a text to describe the currency code.', FRA = 'Spécifie un texte pour décrire le code devise.';
        }
        modify(ExchangeRateDate)
        {
            CaptionML = ENU = 'Exchange Rate Date', FRA = 'Date du taux de change';
            ToolTipML = ENU = 'Specifies the date of the exchange rate in the Exchange Rate field. You can update the rate by choosing the Update Exchange Rates button.', FRA = 'Spécifie la date du taux de change dans le champ Taux de change. Vous pouvez mettre à jour le taux en choisissant le bouton Mettre à jour les taux de change.';
        }
        modify(ExchangeRateAmt)
        {
            CaptionML = ENU = 'Exchange Rate', FRA = 'Taux de change';
            ToolTipML = ENU = 'Specifies the currency exchange rate. You can update the rate by choosing the Update Exchange Rates button.', FRA = 'Spécifie le taux de change de la devise. Vous pouvez mettre à jour le taux en choisissant le bouton Mettre à jour les taux de change.';
        }
        modify("EMU Currency")
        {
            ToolTipML = ENU = 'Specifies whether the currency is an EMU currency, for example DEM or EUR.', FRA = 'Spécifie si la devise appartient à un pays de l''Union européenne, par exemple DM ou EUR.';
        }
        modify("Realized Gains Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which realized exchange rate gains will be posted.', FRA = 'Indique le numéro du compte général sur lequel les gains de change constatés sont validés.';
        }
        modify("Realized Losses Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which realized exchange rate losses will be posted.', FRA = 'Indique le numéro du compte général sur lequel les pertes de change constatées sont validées.';
        }
        modify("Unrealized Gains Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which unrealized exchange rate gains will be posted when the Adjust Exchange Rates batch job is run.', FRA = 'Spécifie le numéro du compte général sur lequel les gains de change non réalisés sont validés lorsque le traitement par lots Ajuster taux de change est exécuté.';
        }
        modify("Unrealized Losses Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which unrealized exchange rate losses will be posted when the Adjust Exchange Rates batch job is run.', FRA = 'Spécifie le numéro du compte général sur lequel les pertes de change prévues sont validées lorsque le traitement par lots Ajuster taux de change est exécuté.';
        }
        modify("Realized G/L Gains Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account to post exchange rate gains to for currency adjustments between LCY and the additional reporting currency.', FRA = 'Spécifie le numéro du compte général sur lequel les gains de change pour les ajustements de devise entre devise société et la devise report sont validés.';
        }
        modify("Realized G/L Losses Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account to post exchange rate gains to for currency adjustments between LCY and the additional reporting currency.', FRA = 'Spécifie le numéro du compte général sur lequel les gains de change pour les ajustements de devise entre devise société et la devise report sont validés.';
        }
        modify("Residual Gains Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account to post residual amount gains to, if you post in the general ledger application area in both LCY and an additional reporting currency.', FRA = 'Spécifie le compte général sur lequel valider les montants de gains résiduels, si vous validez dans le domaine d''application Comptabilité à la fois en devise société et en devise report.';
        }
        modify("Residual Losses Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account to post residual amount losses to, if you post in the general ledger application area in both LCY and an additional reporting currency.', FRA = 'Spécifie le compte général sur lequel valider les montants de pertes résiduels, si vous validez dans le domaine d''application Comptabilité à la fois en devise société et en devise report.';
        }
        modify("Amount Rounding Precision")
        {
            ToolTipML = ENU = 'Specifies the size of the interval to be used when rounding amounts in this currency.', FRA = 'Spécifie la taille de l''intervalle à utiliser lorsque vous arrondissez des montants dans cette devise.';
        }
        modify("Amount Decimal Places")
        {
            ToolTipML = ENU = 'Specifies the number of decimal places the program will display for amounts in this currency.', FRA = 'Spécifie le nombre de décimales que le programme affichera pour des montants dans cette devise.';
        }
        modify("Invoice Rounding Precision")
        {
            ToolTipML = ENU = 'Specifies the size of the interval to be used when rounding amounts in this currency. You can specify invoice rounding for each currency in the Currency table.', FRA = 'Spécifie la taille de l''intervalle à utiliser lorsque vous arrondissez des montants dans cette devise. Vous pouvez spécifier un arrondi facture pour chaque devise dans la table Devise.';
        }
        modify("Invoice Rounding Type")
        {
            ToolTipML = ENU = 'Specifies whether an invoice amount will be rounded up or down. The program uses this information together with the interval for rounding that you have specified in the Invoice Rounding Precision field.', FRA = 'Spécifie si le montant d''une facture est arrondi par excès ou par défaut. Le programme utilise cette information et l''intervalle d''arrondi que vous avez spécifié dans le champ Précision arrondi facture.';
        }
        modify("Unit-Amount Rounding Precision")
        {
            ToolTipML = ENU = 'Specifies the size of the interval to be used when rounding unit amounts (that is, item prices per unit) in this currency.', FRA = 'Spécifie la taille de l''intervalle à utiliser lorsque vous arrondissez des montants unitaires (c''est-à-dire des prix d''articles par unité) dans cette devise.';
        }
        modify("Unit-Amount Decimal Places")
        {
            ToolTipML = ENU = 'Specifies the number of decimal places the program will display for amounts in this currency.', FRA = 'Spécifie le nombre de décimales que le programme affichera pour des montants dans cette devise.';
        }
        modify("Appln. Rounding Precision")
        {
            ToolTipML = ENU = 'Specifies the size of the interval that will be allowed as a rounding difference when you apply entries in different currencies to one another.', FRA = 'Spécifie la taille de l''intervalle autorisé pour les différences d''arrondi lorsque vous lettrez différentes devises entre elles.';
        }
        modify("Conv. LCY Rndg. Debit Acc.")
        {
            ToolTipML = ENU = 'Specifies conversion information that must also contain a debit account if you wish to insert correction lines for rounding differences in the general journals using the Insert Conv. LCY Rndg. Lines function.', FRA = 'Spécifie les informations de conversion qui doivent également contenir un compte débit si vous souhaitez insérer des lignes correction pour les différences d''arrondi dans les feuilles comptabilité en utilisant la fonction Insérer lignes arr. conv. DS.';
        }
        modify("Conv. LCY Rndg. Credit Acc.")
        {
            ToolTipML = ENU = 'Specifies conversion information that must also contain a credit account if you wish to insert correction lines for rounding differences in the general journals using the Insert Conv. LCY Rndg. Lines function.', FRA = 'Spécifie les informations de conversion qui doivent également contenir un compte crédit si vous souhaitez insérer des lignes correction pour les différences d''arrondi dans les feuilles comptabilité en utilisant la fonction Insérer lignes arr. conv. DS.';
        }
        modify("Max. VAT Difference Allowed")
        {
            ToolTipML = ENU = 'Specifies the maximum VAT correction amount allowed for the currency.', FRA = 'Spécifie le montant maximal de différence TVA autorisée pour la devise.';
        }
        modify("VAT Rounding Type")
        {
            ToolTipML = ENU = 'Specifies how the program will round VAT when calculated for this currency.', FRA = 'Spécifie la manière dont le programme arrondit la TVA de cette devise.';
        }
        modify("Last Date Adjusted")
        {
            ToolTipML = ENU = 'Specifies when the exchange rates were last adjusted, that is, the last date on which the Adjust Exchange Rates batch job was run.', FRA = 'Spécifie la date du dernier ajustement des taux de change, c''est-à-dire, la date à laquelle le traitement par lots Ajuster taux de change a été exécuté pour la dernière fois.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies the last date on which any information in the Currency table was modified.', FRA = 'Spécifie la dernière date à laquelle des informations ont été modifiées dans la table Devise.';
        }
        modify("Payment Tolerance %")
        {
            ToolTipML = ENU = 'Specifies the percentage that the payment or refund is allowed to be, less than the amount on the invoice or credit memo.', FRA = 'Spécifie le pourcentage que le paiement ou le remboursement peut atteindre en dessous du montant de la facture ou de l''avoir.';
        }
        modify("Max. Payment Tolerance Amount")
        {
            ToolTipML = ENU = 'Specifies the maximum allowed amount that the payment or refund can differ from the amount on the invoice or credit memo.', FRA = 'Spécifie l''écart maximal autorisé entre le paiement ou le remboursement et le montant de la facture ou de l''avoir.';
        }
        modify(CurrencyFactor)
        {
            CaptionML = ENU = 'Currency Factor', FRA = 'Facteur devise';
            ToolTipML = ENU = 'Specifies the relationship between the additional reporting currency and the local currency. Amounts are recorded in both LCY and the additional reporting currency, using the relevant exchange rate and the currency factor.', FRA = 'Spécifie la relation entre la devise report et la devise locale. Des montants sont enregistrés à la fois en devise société et en devise report, en utilisant le facteur devise et le taux de change appropriés.';
        }
        addafter(Description)
        {
            field("ISO Currency Code"; Rec."ISO Currency Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the ISO Currency Code field.';
            }
            // field("Our Bank No."; "Our Bank No.")
            // {
            // }  // BC Upgrade NANDIS03
        }
        addafter("Residual Losses Account")
        {
            field("Unrealized Gain Acc. Payable"; Rec."Unrealized GainAcc.Payable FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unrealized Gain Acc. (WC Payable) field.';
            }
            field("Unrealized Loss Acc. Payable"; Rec."Unrealized LossAcc.Payable FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unrealized Loss Acc. (WC Payable) field.';
            }
            field("Realized Loss Acc. Payable"; Rec."Realized Loss Acc. Payable FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Realized Loss Acc. (WC Payable) field.';
            }
            field("Realized Gain Acc. Payable"; Rec."Realized Gain Acc. Payable FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Realized Gain Acc. (WC Payable) field.';
            }
            field("Unrealized Gain Acc. Receiv."; Rec."Unrealized GainAcc.Receiv. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unrealized Gain Acc. (WC Receivable) field.';
            }
            field("Unrealized Loss Acc. Receiv."; Rec."Unrealized LossAcc.Receiv. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unrealized Loss Acc. (WC Receivable) field.';
            }
            field("Realized Loss Acc. Receiv."; Rec."Realized Loss Acc. Receiv. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Realized Loss Acc. (WC Receivable) field.';
            }
            field("Realized Gain Acc. Receiv."; Rec."Realized Gain Acc. Receiv. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Realized Gain Acc. (WC Receivable) field.';
            }
        }
        // addafter("Amount Decimal Places")
        // {
        //     field("Tax Amount Rounding Prec."; "Tax Amount Rounding Prec.")
        //     {
        //     }
        //     field("Tax Amount Decimal Places"; "Tax Amount Decimal Places")
        //     {
        //     }
        // }
        // addafter("Unit-Amount Decimal Places")
        // {
        //     field("Tax Unit-Amount Rounding Prec."; "Tax Unit-Amount Rounding Prec.")
        //     {
        //     }
        //     field("Tax Unit-Amount Decimal Places"; "Tax Unit-Amount Decimal Places")
        //     {
        //     }
        // }  // BC Upgrade NANDIS03
    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Change Payment &Tolerance")
        {
            CaptionML = ENU = 'Change Payment &Tolerance', FRA = '&Modifier écart de règlement';
            ToolTipML = ENU = 'Change either or both the maximum payment tolerance and the payment tolerance percentage and filters by currency.', FRA = 'Modifiez l''écart de règlement maximum, le pourcentage d''écart de règlement ou les deux et filtre par devise.';
        }
        modify("Exch. &Rates")
        {
            CaptionML = ENU = 'Exch. &Rates', FRA = '&Taux change';
            ToolTipML = ENU = 'View updated exchange rates for the currencies that you use.', FRA = 'Affichez les taux de change mis à jour pour les devises que vous utilisez.';

            //Unsupported feature: Change RunPageLink on ""Exch. &Rates"(Action 4)". Please convert manually.

        }
        modify("Adjust Exchange Rate")
        {
            CaptionML = ENU = 'Adjust Exchange Rate', FRA = 'Ajuster taux de change';
            ToolTipML = ENU = 'Adjust general ledger, customer, vendor, and bank account entries to reflect a more updated balance if the exchange rate has changed since the entries were posted.', FRA = 'Ajustez les écritures compatibles, client, fournisseur et compte bancaire pour obtenir un solde mis à jour si le taux de change a évolué depuis la validation des écritures.';
        }
        modify("Exchange Rate Adjust. Register")
        {
            CaptionML = ENU = 'Exchange Rate Adjust. Register', FRA = 'Historique des transactions d''ajust. taux de change';
            ToolTipML = ENU = 'View the results of running the Adjust Exchange Rates batch job. One line is created for each currency or each combination of currency and posting group that is included in the adjustment.', FRA = 'Affichez les résultats de l''exécution du traitement par lots Ajuster taux de change. Une ligne est créée dans l''historique. Une ligne est créée pour chaque devise et pour chaque combinaison de devise et de groupe comptabilisation comprise dans l''ajustement.';

            //Unsupported feature: Change RunPageLink on ""Exchange Rate Adjust. Register"(Action 1900169904)". Please convert manually.

        }
        modify("Exchange Rate Services")
        {
            CaptionML = ENU = 'Exchange Rate Services', FRA = 'Services de taux de change';
            ToolTipML = ENU = 'View the results of running the Adjust Exchange Rates batch job. One line is created for each currency or each combination of currency and posting group that is included in the adjustment.', FRA = 'Affichez les résultats de l''exécution du traitement par lots Ajuster taux de change. Une ligne est créée dans l''historique. Une ligne est créée pour chaque devise et pour chaque combinaison de devise et de groupe comptabilisation comprise dans l''ajustement.';
        }
        modify(UpdateExchangeRates)
        {
            CaptionML = ENU = 'Update Exchange Rates', FRA = 'Mettre à jour les taux de change';
            ToolTipML = ENU = 'Get the latest currency exchange rates from a service provider.', FRA = 'Obtenez les récents taux de change des devises auprès d''un fournisseur de services.';
        }
        modify("Foreign Currency Balance")
        {
            CaptionML = ENU = 'Foreign Currency Balance', FRA = 'Solde comptes en devises';
            ToolTipML = ENU = 'View the balances for all customers and vendors in both foreign currencies and in local currency (LCY). The report displays two LCY balances. One is the foreign currency balance converted to LCY by using the exchange rate at the time of the transaction. The other is the foreign currency balance converted to LCY by using the exchange rate of the work date.', FRA = 'Affichez les soldes de tous les clients et fournisseurs en devise locale et en devise société. L''état affiche deux soldes en devise société : le solde en devise converti en devise société en utilisant le taux de change en vigueur au moment où la transaction a été effectuée et le solde en devise converti en devise société en utilisant le taux de change de la date de travail.';
        }
        // modify(NavigateTab)
        // {
        //     CaptionML = FRA = 'Naviguer';
        // }  // BC Upgrade NANDIS03
        modify(ActionGroupCRM)
        {
            CaptionML = ENU = 'Dynamics CRM', FRA = 'Dynamics CRM';
        }
        modify(CRMGotoTransactionCurrency)
        {
            CaptionML = ENU = 'Transaction Currency', FRA = 'Devise de transaction';
            ToolTipML = ENU = 'Open the coupled Microsoft Dynamics CRM transaction currency.', FRA = 'Ouvrez la devise de transaction Microsoft Dynamics CRM couplée.';
        }
        modify(CRMSynchronizeNow)
        {
            CaptionML = ENU = 'Synchronize Now', FRA = 'Synchroniser maintenant';
            ToolTipML = ENU = 'Send updated data to Microsoft Dynamics CRM.', FRA = 'Envoyez des données mises à jour à Microsoft Dynamics CRM.';
        }
        modify(Coupling)
        {
            //CaptionML = @@@='Coupling is a noun',ENU = 'Coupling', FRA = 'Couplage';  // BC Upgrade NANDIS03
            ToolTipML = ENU = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.', FRA = 'Créez, modifiez ou supprimez un couplage entre l''enregistrement Microsoft Dynamics NAV et un enregistrement Microsoft Dynamics CRM.';
        }
        modify(ManageCRMCoupling)
        {
            CaptionML = ENU = 'Set Up Coupling', FRA = 'Configurer le couplage';
            ToolTipML = ENU = 'Create or modify the coupling to a Microsoft Dynamics CRM Transaction Currency.', FRA = 'Créez ou modifiez le couplage avec une devise de transaction Microsoft Dynamics CRM.';
        }
        modify(DeleteCRMCoupling)
        {
            CaptionML = ENU = 'Delete Coupling', FRA = 'Supprimer le couplage';
            ToolTipML = ENU = 'Delete the coupling to a Microsoft Dynamics CRM Transaction Currency.', FRA = 'Supprimez le couplage avec une devise de transaction Microsoft Dynamics CRM.';
        }


        //Unsupported feature: CodeModification on "CRMSynchronizeNow(Action 16).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(Currency);
        Currency.NEXT;

        IF Currency.COUNT = 1 THEN
          CRMIntegrationManagement.UpdateOneNow(Currency.RECORDID)
        else BEGIN
          CurrencyRecordRef.GETTABLE(Currency);
          CRMIntegrationManagement.UpdateMultipleNow(CurrencyRecordRef);
        end
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if Currency.COUNT = 1 then
          CRMIntegrationManagement.UpdateOneNow(Currency.RECORDID)
        else begin
          CurrencyRecordRef.GETTABLE(Currency);
          CRMIntegrationManagement.UpdateMultipleNow(CurrencyRecordRef);
        end
        */
        //end;
    }


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CRMIsCoupledToRecord := CRMIntegrationEnabled and CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
    */
    //end;


    //Unsupported feature: CodeModification on "GetSelectionFilter(PROCEDURE 2)". Please convert manually.

    //procedure GetSelectionFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.SETSELECTIONFILTER(Currency);
    EXIT(SelectionFilterManagement.GetSelectionFilterForCurrency(Currency));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.SETSELECTIONFILTER(Currency);
    exit(SelectionFilterManagement.GetSelectionFilterForCurrency(Currency));
    */
    //end;


    //Unsupported feature: CodeModification on "DrillDownActionOnPage(PROCEDURE 4)". Please convert manually.

    //procedure DrillDownActionOnPage();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrExchRate.SETRANGE("Currency Code",Code);
    PAGE.RUNMODAL(0,CurrExchRate);
    CurrPage.UPDATE(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrExchRate.SETRANGE("Currency Code",Code);
    PAGE.RUNMODAL(0,CurrExchRate);
    CurrPage.UPDATE(false);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

