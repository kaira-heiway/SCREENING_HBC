pageextension 55009 PaymentRecoJournalExt extends "Payment Reconciliation Journal"
{

    // version NAVW110.0


    //BC Upgrade KAPOOV01 >>
    //1.Commented-modify(OutstandingTransactions), modify(OutstandingPayments)- Not found in Base Page for "Payment Reconciliation Journal" 
    //2.Added new controls for -OutstandingTransactions, OutstandingPayments created as GridLayout.
    //3.Commented action-"Import Pan Transactions" as it related to Panama opco.
    //4.Added code to  Get reconciliation header record from "Bank Acc. Reconciliation Line"
    //BC Upgrade KAPOOV01 <<

    layout
    {
        modify("Match Confidence")
        {
            ToolTipML = ENU = 'Specifies the quality of the automatic payment application on the journal line.', ESP = 'Especifica la calidad de la liquidación de pagos automática en la línea del diario.', FRA = 'Précise la qualité du lettrage paiement automatique sur la ligne feuille.';

            //Unsupported feature: Change Editable on "Control 9". Please convert manually.

        }
        modify("Transaction Date")
        {
            ToolTipML = ENU = 'Specifies the date when the payment represented by the journal line was recorded in the bank account.', ESP = 'Especifica la fecha en la que se registró el pago representado mediante la línea del diario en la cuenta bancaria.', FRA = 'Spécifie la date d''enregistrement dans le compte bancaire du paiement représenté par la ligne feuille.';

            //Unsupported feature: Change Editable on "Control 11". Please convert manually.

        }
        modify("Transaction Text")
        {
            ToolTipML = ENU = 'Specifies the text that the customer or vendor entered on that payment transaction that is represented by the journal line.', ESP = 'Especifica el texto que escribió el cliente o el proveedor acerca de la transacción de pagos representada mediante la línea del diario.', FRA = 'Spécifie le texte que le client ou le fournisseur a saisi sur cette transaction de paiement représentée par la ligne feuille.';

            //Unsupported feature: Change Editable on "Control 16". Please convert manually.

        }
        modify("Transaction ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the imported bank transaction.', ESP = 'Especifica el id. de la transacción bancaria importada.', FRA = 'Spécifie l''lD de la transaction bancaire importée.';

            //Unsupported feature: Change Editable on "Control 62". Please convert manually.

        }
        modify("Statement Amount")
        {
            CaptionML = ENU = 'Transaction Amount', ESP = 'Importe de la transacción', FRA = 'Montant transaction';
            ToolTipML = ENU = 'Specifies the amount that was paid into the bank account and then imported as a bank statement line represented by the journal line.', ESP = 'Especifica el importe que se pagó en la cuenta bancaria y que se importó como una línea de extracto bancario representada mediante la línea del diario.', FRA = 'Spécifie le montant réglé dans le compte bancaire, puis importé comme ligne de relevé bancaire représentée par la ligne feuille.';

            //Unsupported feature: Change Editable on "Control 8". Please convert manually.

        }
        modify("Applied Amount")
        {
            ToolTipML = ENU = 'Specifies the amount that has been applied to one or more open entries.', ESP = 'Especifica el importe que se liquidó en uno o varios movimientos pendientes.', FRA = 'Spécifie le montant appliqué à une ou plusieurs écritures ouvertes.';

            //Unsupported feature: Change Editable on "Control 10". Please convert manually.

        }
        modify("Difference")
        {
            ToolTipML = ENU = 'Specifies the difference between the amount in the Statement Amount field and the amount in the Applied Amount field.', ESP = 'Especifica la diferencia de importes entre los campos Importe extracto e Importe liquidado.', FRA = 'Spécifie la différence entre les montant des champs Montant relevé et Montant lettré.';

            //Unsupported feature: Change Editable on "Control 12". Please convert manually.

        }
        modify(StatementToRemAmtDifference)
        {
            CaptionML = ENU = 'Difference from Remaining Amount', ESP = 'Diferencia con importe pendiente', FRA = 'Différence par rapport au montant ouvert';
            ToolTipML = ENU = 'Specifies the difference between the values in the Statement Amount and the Remaining Amount After Posting fields.', ESP = 'Especifica la diferencia entre los valores de los campos Importe extracto e Importe pendiente después del registro.', FRA = 'Spécifie la différence entre les valeurs des champs Montant relevé et Montant ouvert après validation.';
        }
        modify("GetAppliedToDocumentNo")
        {
            CaptionML = ENU = 'Document No.', ESP = 'Nº documento', FRA = 'N° document';
            ToolTipML = ENU = 'Specifies the document number of the open entry that the payment is applied to.', ESP = 'Especifica el número de documento del movimiento pendiente en el que se liquida el pago.', FRA = 'Spécifie le numéro de document de l''écriture ouverte avec laquelle le paiement est lettré.';

            //Unsupported feature: Change Editable on "Control 49". Please convert manually.

        }
        modify(DescAppliedEntry)
        {
            CaptionML = ENU = 'Description', ESP = 'Descripción', FRA = 'Description';
            ToolTipML = ENU = 'Specifies the description on the open entry that the payment is applied to.', ESP = 'Especifica la descripción del movimiento pendiente en el que se liquida el pago.', FRA = 'Spécifie la description de l''écriture ouverte avec laquelle le paiement est lettré.';

            //Unsupported feature: Change Editable on "DescAppliedEntry(Control 47)". Please convert manually.

        }
        modify(DueDateAppliedEntry)
        {
            CaptionML = ENU = 'Due Date', ESP = 'Fecha vencimiento', FRA = 'Date d''échéance';
            ToolTipML = ENU = 'Specifies the due date on the open entry that the payment is applied to.', ESP = 'Especifica la fecha de vencimiento del movimiento pendiente en el que se liquida el pago.', FRA = 'Spécifie la date d''échéance de l''écriture ouverte avec laquelle le paiement est lettré.';

            //Unsupported feature: Change Editable on "DueDateAppliedEntry(Control 50)". Please convert manually.

        }
        modify(AccountName)
        {
            CaptionML = ENU = 'Account Name', ESP = 'Nombre cuenta', FRA = 'Nom du compte';
            ToolTipML = ENU = 'Specifies the name of the customer or vendor that the payment is applied to.', ESP = 'Especifica el nombre del cliente o el proveedor al que se liquida el pago.', FRA = 'Spécifie le nom du client ou du fournisseur avec lequel le paiement est lettré.';
        }
        modify("Account Type")
        {
            ToolTipML = ENU = 'Specifies the type of account that the payment application will be posted to when you post the worksheet.', ESP = 'Especifica el tipo de cuenta en el que se registrará la liquidación de pago cuando registre la hoja de cálculo.', FRA = 'Spécifie le type de compte avec lequel le lettrage paiement est validé au moment où vous validez la feuille.';

            //Unsupported feature: Change Editable on "Control 4". Please convert manually.

        }
        modify("Account No.")
        {
            ToolTipML = ENU = 'Specifies the account number that the payment application will be posted to when you post the worksheet.', ESP = 'Especifica el número de cuenta en el que se registrará la liquidación de pago cuando registre la hoja de cálculo.', FRA = 'Spécifie le numéro de compte avec lequel le lettrage paiement est validé lorsque vous validez la feuille.';

            //Unsupported feature: Change Editable on "Control 13". Please convert manually.

        }
        modify(PostingDateAppliedEntry)
        {
            CaptionML = ENU = 'Posting Date', ESP = 'Fecha reg.', FRA = 'Date comptabilisation';
            ToolTipML = ENU = 'Specifies the posting date on the open entry that the payment is applied to.', ESP = 'Especifica la fecha registro del movimiento pendiente en el que se liquida el pago.', FRA = 'Spécifie la date comptabilisation de l''écriture ouverte avec laquelle le paiement est lettré.';

            //Unsupported feature: Change Editable on "PostingDateAppliedEntry(Control 46)". Please convert manually.

        }
        modify("AppliedPmtEntry.""Currency Code""")
        {
            CaptionML = ENU = 'Entry Currency Code', ESP = 'Cód. divisa movimiento', FRA = 'Code devise écriture';
            ToolTipML = ENU = 'Specifies the currency code on the open entry that the payment is applied to.', ESP = 'Especifica el código de divisa del movimiento pendiente en el que se liquida el pago.', FRA = 'Spécifie le code de devise de l''écriture ouverte avec laquelle le paiement est lettré.';

            //Unsupported feature: Change Editable on "Control 51". Please convert manually.

        }
        modify("Match Details")
        {
            CaptionML = ENU = 'Match Details', ESP = 'Detalles de correspondencia', FRA = 'Détails de correspondance';
            ToolTipML = ENU = 'Specifies details about the payment application on the journal line.', ESP = 'Especifica los detalles sobre la liquidación de pago de la línea del diario.', FRA = 'Spécifie les détails concernant le lettrage paiement automatique sur la ligne feuille.';

            //Unsupported feature: Change Editable on ""Match Details"(Control 2)". Please convert manually.

        }
        modify("Applied Entries")
        {
            ToolTipML = ENU = 'Specifies for a journal line where the payment has been applied, how many entries the payment has been applied to.', ESP = 'Especifica, en el caso de una línea del diario en la que se haya liquidado el pago, en cuántos movimientos se liquidó el pago.', FRA = 'Spécifie, pour une ligne feuille où le paiement a été lettré, le nombre d''écritures avec lesquelles le paiement a été lettré.';

            //Unsupported feature: Change Editable on "Control 14". Please convert manually.

        }
        modify(RemainingAmount)
        {
            CaptionML = ENU = 'Remaining Amount After Posting', ESP = 'Importe pendiente después del registro', FRA = 'Montant ouvert après validation';
            ToolTipML = ENU = 'Specifies the amount that remains to be paid on the open entry that the payment is applied to.', ESP = 'Especifica el importe pendiente de pago en el movimiento pendiente que en el que se liquida el pago.', FRA = 'Spécifie le montant qui reste à payer sur l''écriture ouverte avec laquelle le paiement est lettré.';
        }
        modify("Additional Transaction Info")
        {
            ToolTipML = ENU = 'Specifies additional information on the bank statement line for the payment.', ESP = 'Especifica información adicional en la línea de extracto bancario para el pago.', FRA = 'Spécifie des informations supplémentaires sur la ligne de relevé bancaire pour le paiement.';

            //Unsupported feature: Change Editable on "Control 7". Please convert manually.

        }
        modify("Related-Party Address")
        {
            ToolTipML = ENU = 'Specifies the address of the customer or vendor who made the payment that is represented by the journal line.', ESP = 'Especifica la dirección del cliente o el proveedor que realizó el pago que se representa en la línea del diario.', FRA = 'Spécifie l''adresse du client ou du fournisseur ayant effectué le paiement représenté par la ligne feuille.';
        }
        modify("Related-Party Bank Acc. No.")
        {
            ToolTipML = ENU = 'Specifies the bank account number of the customer or vendor who made the payment.', ESP = 'Especifica el número de cuenta bancaria del cliente o el proveedor que realizó el pago.', FRA = 'Spécifie le numéro de compte bancaire du client ou du fournisseur ayant effectué le paiement.';
        }
        modify("Related-Party City")
        {
            ToolTipML = ENU = 'Specifies the city name of the customer or vendor.', ESP = 'Especifica el nombre de la población del cliente o el proveedor.', FRA = 'Spécifie le nom de la ville du client ou du fournisseur.';
        }
        modify("Related-Party Name")
        {
            ToolTipML = ENU = 'Specifies the name of the customer or vendor who made the payment that is represented by the journal line.', ESP = 'Especifica el nombre del cliente o el proveedor que realizó el pago que se representa en la línea del diario.', FRA = 'Spécifie le nom du client ou du fournisseur qui a effectué le paiement qui est représenté par la ligne feuille.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', ESP = 'Especifica el código de la dimensión del acceso directo 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';

            //Unsupported feature: Change Editable on "Control 64". Please convert manually.

        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', ESP = 'Especifica el código de la dimensión del acceso directo 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';

            //Unsupported feature: Change Editable on "Control 65". Please convert manually.

        }
        modify("ShortcutDimCode3")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', ESP = 'Especifica el código del valor de dimensión vinculado a la línea del diario.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change Editable on "Control 71". Please convert manually.

        }
        modify("ShortcutDimCode4")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', ESP = 'Especifica el código del valor de dimensión vinculado a la línea del diario.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change Editable on "Control 70". Please convert manually.

        }
        modify("ShortcutDimCode5")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', ESP = 'Especifica el código del valor de dimensión vinculado a la línea del diario.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change Editable on "Control 69". Please convert manually.

        }
        modify("ShortcutDimCode6")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', ESP = 'Especifica el código del valor de dimensión vinculado a la línea del diario.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change Editable on "Control 68". Please convert manually.

        }
        modify("ShortcutDimCode7")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', ESP = 'Especifica el código del valor de dimensión vinculado a la línea del diario.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change Editable on "Control 67". Please convert manually.

        }
        modify("ShortcutDimCode8")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', ESP = 'Especifica el código del valor de dimensión vinculado a la línea del diario.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change Editable on "Control 66". Please convert manually.

        }
        modify(BalanceOnBankAccountFixedLayout)
        {
            CaptionML = ENU = 'Balance on Bank Account', ESP = 'Saldo en cuenta bancaria', FRA = 'Solde sur compte bancaire';
            ToolTipML = ENU = 'Specifies the balance of the bank account per the last time you reconciled the bank account.', ESP = 'Especifica el saldo de la cuenta bancaria según la última conciliación de dicha cuenta.', FRA = 'Spécifie le solde du compte bancaire lors de votre dernier rapprochement bancaire.';
        }
        modify(TotalTransactionAmountFixedLayout)
        {
            CaptionML = ENU = 'Total Transaction Amount', ESP = 'Importe total de la transacción', FRA = 'Montant transaction total';
            ToolTipML = ENU = 'Specifies the sum of values in the Statement Amount field on all the lines in the Payment Reconciliation Journal window.', ESP = 'Especifica la suma de los valores del campo Importe extracto en todas las líneas de la ventana Diario de conciliación de pagos.', FRA = 'Spécifie la somme des valeurs du champ Montant relevé sur toutes les lignes de la fenêtre Feuille rapprochement bancaire.';
        }
        modify(BalanceOnBankAccountAfterPostingFixedLayout)
        {
            CaptionML = ENU = 'Balance on Bank Account After Posting', ESP = 'Saldo en cuenta bancaria después del registro', FRA = 'Solde sur compte bancaire après validation';
            ToolTipML = ENU = 'Specifies the total amount that will exist on the bank account as a result of payment applications that you post in the Payment Reconciliation Journal window.', ESP = 'Especifica el importe total que existirá en la cuenta bancaria como resultado de las liquidaciones de pago que se registren en la ventana Diario de conciliación de pagos.', FRA = 'Spécifie le montant total qui figure sur le relevé bancaire comme résultat des lettrages de paiement que vous validez dans la fenêtre Feuille rapprochement bancaire.';
        }
        //BC Upgrade KAPOOV01 commented- Not found in Base Page for "Payment Reconciliation Journal" >>
        // modify(OutstandingTransactions)
        // {
        //     CaptionML = ENU = 'Outstanding Transactions', ESP = 'Transacciones pendientes', FRA = 'Transactions restantes';
        //     ToolTipML = ENU = 'Specifies the outstanding bank transactions that have not been applied.', ESP = 'Especifica las transacciones bancaria pendientes que no se han liquidado.', FRA = 'Spécifie les transactions bancaires restantes qui n''ont pas été appliquées.';
        // }
        // modify(OutstandingPayments)
        // {
        //     CaptionML = ENU = 'Outstanding Payments', ESP = 'Pagos pendientes', FRA = 'Paiements restants';
        //     ToolTipML = ENU = 'Specifies the outstanding check transactions that have not been applied.', ESP = 'Especifica las transacciones de cheques pendientes que no se liquidaron.', FRA = 'Spécifie les transactions par chèques restantes qui n''ont pas été appliquées.';
        // }
        //BC Upgrade KAPOOV01 commented- Not found in Base Page for "Payment Reconciliation Journal" <<
        modify(StatementEndingBalanceFixedLayout)
        {
            CaptionML = ENU = 'Statement Ending Balance', ESP = 'Saldo final extracto', FRA = 'Solde final du relevé';
            ToolTipML = ENU = 'Specifies the balance on your actual bank account after the bank has processed the payments that you have imported with the bank statement file.', ESP = 'Especifica el saldo de la cuenta bancaria real después de que el banco haya procesado los pagos que se importaron con el archivo de extracto bancario.', FRA = 'Spécifie le solde de votre compte bancaire réel après le traitement par la banque des paiements importés avec le fichier de relevé bancaire.';
        }
        addafter("Related-Party Name")
        {
            field("IBAN Matched"; Rec."IBAN Matched FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Add IBAN Matched';
            }
        }
        addafter("ShortcutDimCode8")
        {
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
            }
        }
        //BC Upgrade KAPOOV01 Added new fields for -OutstandingTransactions, OutstandingPayments created as GridLayout. >>
        addlast(Content)
        {
            grid(OutstandingPayment)
            {
                ShowCaption = false;
                GridLayout = Columns;

                group(OutstandingPaymentsGroup)
                {
                    ShowCaption = false;
                    field(OutstandingTransactionsFixedLayout; OutstandingTransactions)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Outstanding Transactions', ESP = 'Transacciones pendientes', FRA = 'Transactions restantes';
                        ToolTipML = ENU = 'Specifies the outstanding bank transactions that have not been applied.', ESP = 'Especifica las transacciones bancaria pendientes que no se han liquidado.', FRA = 'Spécifie les transactions bancaires restantes qui n''ont pas été appliquées.';
                        trigger OnDrillDown()
                        var
                            DummyOutstandingBankTransaction: Record "Outstanding Bank Transaction";
                        begin
                            DummyOutstandingBankTransaction.DrillDown(Rec."Bank Account No.",
     DummyOutstandingBankTransaction.Type::"Bank Account Ledger Entry", Rec."Statement Type".AsInteger(), Rec."Statement No.");
                        end;
                    }
                    field(OutstandingPaymentsFixedLayout; OutstandingPayments)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Outstanding Payments', ESP = 'Pagos pendientes', FRA = 'Paiements restants';
                        ToolTipML = ENU = 'Specifies the outstanding check transactions that have not been applied.', ESP = 'Especifica las transacciones de cheques pendientes que no se liquidaron.', FRA = 'Spécifie les transactions par chèques restantes qui n''ont pas été appliquées.';
                        trigger OnDrillDown()
                        var
                            DummyOutstandingBankTransaction: Record "Outstanding Bank Transaction";
                        begin
                            DummyOutstandingBankTransaction.DrillDown(
                                rec."Bank Account No.",
                                DummyOutstandingBankTransaction.Type::"Check Ledger Entry",
                                rec."Statement Type".AsInteger(),
                                rec."Statement No.");
                        end;
                    }
                }
            }
        }
        //BC Upgrade KAPOOV01 Added new fields for -OutstandingTransactions, OutstandingPayments created as GridLayout. <<
    }

    actions
    {
        modify("Process")
        {
            CaptionML = ENU = 'Process', ESP = 'Procesar', FRA = 'Traitement';
        }
        modify(ImportBankTransactions)
        {
            CaptionML = ENU = '&Import Bank Transactions', ESP = '&Importar transacciones bancarias', FRA = '&Importer les transactions bancaires';
            ToolTipML = ENU = 'Import a file for transaction payments that was made from your bank account and apply the payments to the entry. The file name must end in .csv, .txt, asc, or .xml.', ESP = 'Permite importar un archivo con los pagos de transacciones que se realizaron desde la cuenta bancaria y liquidar esos pagos en el movimiento. El nombre de archivo debe terminar en .csv, .txt, .asc o .xml.', FRA = 'Importez un fichier pour les paiements de transaction réalisés depuis votre compte bancaire et lettrez les paiements avec l''écriture. Le nom du fichier doit se terminer par .csv, .txt, asc ou .xml.';
        }
        modify(ApplyAutomatically)
        {
            CaptionML = ENU = 'Apply Automatically', ESP = 'Liquidar automáticamente', FRA = 'Lettrer automatiquement';
            ToolTipML = ENU = 'Apply payments to their related open entries based on data matches between bank transaction text and entry information.', ESP = 'Permite liquidar pagos en los movimientos pendientes relacionados con ellos en función de las coincidencias de datos entre el texto de las transacciones bancarias y la información de los movimientos.', FRA = 'Lettrez les paiements avec leurs écritures ouvertes associées selon les correspondances de données entre le texte de transaction bancaire et les informations d''écriture.';
        }
        modify(Action58)
        {
            CaptionML = ENU = 'Post', ESP = 'Registrar', FRA = 'Valider';
        }
        modify(TestReport)
        {
            CaptionML = ENU = '&Test Report', ESP = '&Informe prueba', FRA = '&Impression test';
            ToolTipML = ENU = 'Preview the resulting payment reconciliations to see the consequences before you perform the actual posting.', ESP = 'Permite obtener una vista previa de las conciliaciones de pagos resultantes para ver las consecuencias antes de proceder al registro real.', FRA = 'Affichez les rapprochements paiement résultants pour voir les conséquences avant d''effectuer la validation effective.';
        }
        modify("Post")
        {
            CaptionML = ENU = 'Post Payments and Reconcile Bank Account', ESP = 'Registrar pagos y conciliar banco', FRA = 'Valider les paiements et rapprocher les comptes bancaires';
            ToolTipML = ENU = 'Reconcile the bank account for payments that you post with the journal and close related ledger entries.', ESP = 'Permite conciliar la cuenta bancaria con los pagos que registró mediante el diario y cerrar los movimientos relacionados.', FRA = 'Rapprochez le compte bancaire pour les paiements que vous validez avec le journal et clôturez les écritures comptables associées.';
        }
        modify(PostPaymentsOnly)
        {
            CaptionML = ENU = 'Post Payments Only', ESP = 'Registrar solamente pagos', FRA = 'Valider les paiements uniquement';
            ToolTipML = ENU = 'Post payments but do not close related bank account ledger entries or reconcile the bank account.', ESP = 'Permite registrar pagos, pero no cerrar los movimientos de la cuenta bancaria relacionada o conciliar la cuenta bancaria.', FRA = 'Validez les paiements, mais ne clôturez pas les écritures comptables du compte bancaire associées ou rapprochez le compte bancaire.';

            //Unsupported feature: Change Visible on "PostPaymentsOnly(Action 60)". Please convert manually.

        }
        modify("New Documents")
        {
            CaptionML = ENU = 'New Documents', ESP = 'Nuevos documentos', FRA = 'Nouveaux documents';
        }
        modify(FinanceChargeMemo)
        {
            CaptionML = ENU = 'New Finance Charge Memo', ESP = 'Nuevo documento interés', FRA = 'Nouvelle facture d''intérêts';
            ToolTipML = ENU = 'Define a memo that includes information about the calculated interest on outstanding balances of an account. You can then send the memo in an email to the customer.', ESP = 'Permite definir una nota que incluya información acerca del interés calculado en función de los saldos pendientes de una cuenta. Dicha nota se puede enviar por correo electrónico al cliente.', FRA = 'Définissez un avoir comprenant les informations concernant l''intérêt calculé sur les soldes échus d''un compte. Vous pouvez ensuite envoyer l''avoir au client par e-mail.';
        }
        modify(OpenGenJnl)
        {
            CaptionML = ENU = 'General Journal', ESP = 'Diario general', FRA = 'Feuille comptabilité';
            ToolTipML = ENU = 'Open the general journal, for example, to record or post a payment that has no related document.', ESP = 'Permite abrir el diario general, por ejemplo, para registrar un pago que no tiene documentos relacionados.', FRA = 'Ouvrez la feuille comptabilité, par exemple pour enregistrer ou valider un paiement qui n''a aucun document associé.';
        }
        modify("Payment Journal")
        {
            CaptionML = ENU = 'Payment Journal', ESP = 'Diario de pagos', FRA = 'Feuille paiement';
            ToolTipML = ENU = 'View or edit the payment journal where you can register payments to vendors.', ESP = 'Permite ver o editar el diario de pagos en el que se pueden registrar los pagos a proveedores.', FRA = 'Affichez ou modifiez la feuille paiement où vous pouvez enregistrer les paiements aux fournisseurs.';
        }
        modify("Manual Application")
        {
            CaptionML = ENU = 'Manual Application', ESP = 'Liquidación manual', FRA = 'Application manuelle';
        }
        modify(TransferDiffToAccount)
        {
            CaptionML = ENU = 'Transfer Difference to Account', ESP = 'Transferir diferencia a cuenta', FRA = 'Transférer la différence vers un compte';
            ToolTipML = ENU = 'Specify the balancing account to which you want a non-applicable payment amount on a payment reconciliation journal line to be posted when you post the journal.', ESP = 'Permite especificar la cuenta de contrapartida en la que quiere registrar un importe de pago no liquidable en una línea del diario de conciliación de pagos en el momento de registrar ese diario.', FRA = 'Précisez le compte bancaire dans lequel vous souhaitez valider le montant d''un paiement non lettrable sur une ligne feuille rapprochement bancaire lorsque vous validez la feuille.';
        }
        modify(AddMappingRule)
        {
            CaptionML = ENU = 'Map Text to Account', ESP = 'Asignar texto a cuenta', FRA = 'Mapper le texte avec le compte';
            ToolTipML = ENU = 'Associate text on payments with debit, credit, and balancing accounts, so payments are posted to the accounts when you post payments. The payments are not applied to invoices or credit memos, and are suited for recurring cash receipts or expenses.', ESP = 'Permite asociar el texto acerca de los pagos con las cuentas de débito, crédito y contrapartida, para que los pagos se registren en las cuentas en el momento de registrar pagos. Estos pagos no se aplican a facturas ni abonos y son perfectos para recibos de cobro o gastos periódicos.', FRA = 'Associez le texte des paiements aux comptes débiteur, créditeur et de contrepartie, de telle sorte que les paiements soient validés dans les comptes lorsque vous validez les paiements. Les paiements ne peuvent pas être lettrés avec les factures ou les avoirs. Ils sont adaptés aux dépenses et aux règlements récurrents.';

            //Unsupported feature: Change Visible on "AddMappingRule(Action 30)". Please convert manually.

        }
        modify(ApplyEntries)
        {
            CaptionML = ENU = '&Apply Manually', ESP = '&Liquidar manualmente', FRA = '&Lettrer manuellement';
            ToolTipML = ENU = 'Review and apply payments that were applied automatically to wrong open entries or not applied at all.', ESP = 'Permite revisar y liquidar los pagos que se liquidaron de forma automática en movimientos pendientes erróneos o que directamente no se liquidaron.', FRA = 'Passez en revue et lettrez des paiements qui ont été lettrés automatiquement avec de mauvaises écritures ouvertes ou qui n''ont pas été lettrés du tout.';

            //Unsupported feature: Change Visible on "ApplyEntries(Action 31)". Please convert manually.

        }
        modify(Review)
        {
            CaptionML = ENU = 'Review', ESP = 'Revisar', FRA = 'Révision';
        }
        modify(Accept)
        {
            CaptionML = ENU = 'Accept Applications', ESP = 'Aceptar liquidaciones', FRA = 'Accepter lettrages';
            ToolTipML = ENU = 'Accept a payment application after reviewing it or manually applying it to entries. This closes the payment application and sets the Match Confidence to Accepted.', ESP = 'Permite aceptar una liquidación de pago después de revisarla o liquidarla manualmente en los movimientos. Esta acción cierra la liquidación de pago y establece el valor de la opción Confianza de la correspondencia en Aceptado.', FRA = 'Acceptez un lettrage paiement après l''avoir passé en revue ou après l''avoir manuellement lettré avec les écritures. Cela clôture le lettrage paiement et définit la Fiabilité correspondance sur Acceptée.';
        }
        modify(Reject)
        {
            CaptionML = ENU = 'Remove Applications', ESP = 'Eliminar liquidaciones', FRA = 'Supprimer lettrages';
            ToolTipML = ENU = 'Remove a payment application from an entry. This unapplies the payment.', ESP = 'Permite quitar una liquidación de pago de un movimiento. Esto desliquidará el pago.', FRA = 'Supprimez un lettrage paiement depuis une écriture. Cela annule le paiement.';
        }
        modify("Custom Sorting")
        {
            CaptionML = ENU = 'Custom Sorting', ESP = 'Ordenación personalizada', FRA = 'Tri personnalisé';
        }
        modify(ShowNonAppliedLines)
        {
            CaptionML = ENU = 'Show Non-Applied Lines', ESP = 'Mostrar líneas no liquidadas', FRA = 'Afficher les lignes non lettrées';
            ToolTipML = ENU = 'Display only payments in the list that have not been applied.', ESP = 'Permite mostrar solamente los pagos de la lista que no se hayan liquidado.', FRA = 'Affichez uniquement les paiements de la liste n''ayant pas été lettrés.';
        }
        modify(ShowAllLines)
        {
            CaptionML = ENU = 'Show All Lines', ESP = 'Mostrar todas las líneas', FRA = 'Afficher toutes les lignes';
            ToolTipML = ENU = 'Display all payments in the list no matter what their status is.', ESP = 'Permite mostrar todos los pagos de la lista sin importar el estado que tengan.', FRA = 'Affichez tous les paiements de la liste, peu importe leur statut.';
        }
        modify(SortForReviewDescending)
        {
            CaptionML = ENU = 'Sort for Review Descending', ESP = 'Ordenar descendente para revisión', FRA = 'Tri décroissant pour révision';
            ToolTipML = ENU = 'Sort the lines in ascending order.', ESP = 'Permite ordenar las líneas en orden ascendente.', FRA = 'Triez les lignes dans l''ordre croissant.';
        }
        modify(SortForReviewAscending)
        {
            CaptionML = ENU = 'Sort for Review Ascending', ESP = 'Ordenar ascendente para revisión', FRA = 'Tri croissant pour révision';
            ToolTipML = ENU = 'Sort the lines in descending order.', ESP = 'Permite ordenar las líneas en orden descendente.', FRA = 'Triez les lignes dans l''ordre décroissant.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', ESP = 'Dimensiones', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', ESP = 'Permite ver o editar dimensiones, como el área, el proyecto o el departamento, que pueden asignarse a los documentos de venta y compra para distribuir costes y analizar el historial de transacciones.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(LineDimensions)
        {
            CaptionML = ENU = 'Line Dimensions', ESP = 'Dimensiones línea', FRA = 'Analytique ligne';
            ToolTipML = ENU = 'View or edit the line dimensions sets that are set up for the current line.', ESP = 'Permite ver o editar los grupos de dimensiones de línea configurados para la línea actual.', FRA = 'Affichez ou modifiez les ensembles de dimensions de ligne paramétrés pour la ligne actuelle.';
        }
        modify("Bank Account Card")
        {
            CaptionML = ENU = 'Bank Account Card', ESP = 'Ficha banco', FRA = 'Fiche compte bancaire';
            ToolTipML = ENU = 'View or edit information about the bank account that is related to the payment reconciliation journal.', ESP = 'Permite ver o editar la información acerca de la cuenta bancaria relacionada con el diario de conciliación de pagos.', FRA = 'Affichez ou modifiez les informations sur le compte bancaire associé à la feuille rapprochement bancaire.';
        }
        modify("Details")
        {
            CaptionML = ENU = 'Details', ESP = 'Detalles', FRA = 'Détails';
        }
        modify(ShowBankTransactionDetails)
        {
            CaptionML = ENU = 'Bank Transaction Details', ESP = 'Detalles de transacción bancaria', FRA = 'Détails de transactions bancaires';
            ToolTipML = ENU = 'View the values that exist in an imported bank statement file for the selected line.', ESP = 'Permite ver o editar los valores que existen en un archivo de extracto bancario importado de la línea seleccionada.', FRA = 'Affichez le valeurs qui existent dans un fichier de relevé bancaire importé pour la ligne sélectionnée.';
        }


        //Unsupported feature: CodeModification on "ApplyAutomatically(Action 29).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        AppliedPaymentEntry.SETRANGE("Statement Type","Statement Type");
        AppliedPaymentEntry.SETRANGE("Bank Account No.","Bank Account No.");
        AppliedPaymentEntry.SETRANGE("Statement No.","Statement No.");

        IF AppliedPaymentEntry.COUNT > 0 THEN
          IF NOT CONFIRM(RemoveExistingApplicationsQst) THEN
            EXIT;

        BankAccReconciliation.GET("Statement Type","Bank Account No.","Statement No.");
        CODEUNIT.RUN(CODEUNIT::"Match Bank Pmt. Appl.",BankAccReconciliation);
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..8
        //soicad>>
        BankAccReconciliationLine.SETRANGE("Statement Type","Statement Type");
        BankAccReconciliationLine.SETRANGE("Bank Account No.","Bank Account No.");
        BankAccReconciliationLine.SETRANGE("Statement No.","Statement No.");
        BankAccReconciliationLine.MODIFYALL("IBAN Matched",FALSE);
        //soicad<<


        #9..11
        */
        //end;


        //Unsupported feature: CodeModification on "Post(Action 35).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        InvokePost(FALSE)
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //soicad>>
        IF (BankAccReconciliation."Total Balance on Bank Account" + BankAccReconciliation."Total Unposted Applied Amount")
          <> BankAccReconciliation."Statement Ending Balance" THEN BEGIN
          IF NOT CONFIRM(Text50000) THEN
            EXIT;
        END;
        //soicad<<
        InvokePost(FALSE)
        */
        //end;


        //Unsupported feature: CodeModification on "PostPaymentsOnly(Action 60).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        InvokePost(TRUE)
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //soicad>>
        IF (BankAccReconciliation."Total Balance on Bank Account" + BankAccReconciliation."Total Unposted Applied Amount")
          <> BankAccReconciliation."Statement Ending Balance" THEN BEGIN
          IF NOT CONFIRM(Text50000) THEN
            EXIT;
        END;
        //soicad<<
        InvokePost(TRUE)
        */
        //end;
        addafter(ImportBankTransactions)
        {
            //BC Upgrade KAPOOV01 Commented action-"Import Pan Transactions" as it related to Panama opco >>
            // action("Import Pan Transactions")
            // {
            //     Image = ImportLog;
            //     ApplicationArea = All;

            //     trigger OnAction();
            //     var
            //         ImportPANBank: XMLport "Import PAN Bank";
            //     begin
            //         //SOICAD>>
            //         ImportPANBank.SetTemplate(Rec);
            //         ImportPANBank.RUN;
            //         CurrPage.UPDATE(FALSE);
            //     end;
            // }
            //BC Upgrade KAPOOV01 Commented action-"Import Pan Transactions" as it related to Panama opco <<
            action("Import from File")
            {
                Caption = 'Import from File';
                Image = ImportExport;
                ApplicationArea = All;
                ToolTip = 'Import from File'; //BC Upgrade KAPOOV01 Added tootltip Property.

                trigger OnAction();
                var
                    BankAcc: Record "Bank Account";
                    ImportBOB: Report "Import BOB";
                    ImportBAHBankBNS: XMLport "Import BAH Bank BNS";
                    ImportBAHBankCITI: XMLport "Import BAH Bank CITI";
                    //ImportBAHBankRBC: XMLport "Import BAH Bank RBC";//Bc Upgrade YADAVM09 Warning Resolution variable not used anywhere in the code<<
                    ImportBAHBankFCIB: XMLport "Import BAH Bank FCIB";
                begin
                    BankAccReconciliation.Get(Rec."Statement Type", Rec."Bank Account No.", Rec."Statement No."); //BC Upgrade KAPOOV01 Added code to  Get reconciliation header record from "Bank Acc. Reconciliation Line"
                    //<<HEI.01
                    //NAIKH01<<
                    // ,Bahamas BNS,Bahamas CITI,Bahamas BOB,Bahamas RBC,Bahamas FCIB
                    ImportBAHBankBNS.SetTemplate(BankAccReconciliation);
                    ImportBAHBankFCIB.SetTemplate(BankAccReconciliation);
                    //ImportBAHBankRBC.SetTemplate(BankAccReconciliation); //NAIKH01
                    ImportBOB.SetTemplate(BankAccReconciliation);
                    ImportBAHBankCITI.SetTemplate(BankAccReconciliation);
                    IF BankAcc.GET(Rec."Bank Account No.") THEN BEGIN
                        IF BankAcc."Import Format FND" > 0 THEN //begin //Bc Upgrade YADAVM09 Warning Resolution<<
                            CASE BankAcc."Import Format FND" OF
                                BankAcc."Import Format FND"::"Bahamas BNS":
                                    ImportBAHBankBNS.RUN();
                                BankAcc."Import Format FND"::"Bahamas CITI":
                                    ImportBAHBankCITI.RUN();
                                BankAcc."Import Format FND"::"Bahamas FCIB":
                                    ImportBAHBankFCIB.RUN();
                                BankAcc."Import Format FND"::"Bahamas BOB":
                                    ImportBOB.RUN();
                                BankAcc."Import Format FND"::"Bahamas RBC":
                                    Test();
                            END;
                        EXIT;
                    END;
                END;
                //NAIKH01>>
                //>>HEI.01
                //end;//Bc Upgrade YADAVM09 Warning Resolution<<
            }
        }
    }

    var
        // BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line"; //BC Upgrade KAPOOV01 commented as Unused
        BankAccReconciliation: Record "Bank Acc. Reconciliation"; //BC Upgrade KAPOOV01

        OutstandingTransactions: Decimal; //BC Upgrade KAPOOV01
        OutstandingPayments: Decimal;//BC Upgrade KAPOOV01



    //Unsupported feature: PropertyModification on "PmtAppliedToTxt(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PmtAppliedToTxt : @@@="%1=integer value for number of entries";ENU=The payment has been applied to %1 entries.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PmtAppliedToTxt : @@@="%1=integer value for number of entries";ENU=The payment has been applied to %1 entries.;ESP=El pago se liquidó en %1 movimientos.;FRA=Le paiement a été lettré avec %1 écritures.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "RemoveExistingApplicationsQst(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //RemoveExistingApplicationsQst : ENU=When you run the Apply Automatically action, it will undo all previous applications.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RemoveExistingApplicationsQst : ENU=When you run the Apply Automatically action, it will undo all previous applications.\\Do you want to continue?;ESP=Al ejecutar la acción Liquidar automáticamente, se desharán todas las liquidaciones anteriores.\\¿Desea continuar?;FRA=Si vous exécutez l'action Lettrer automatiquement, tous les lettrages précédents seront annulés.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "PageMustCloseMsg(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PageMustCloseMsg : ENU=The Payment Reconciliation Journal window has been closed because the connection was suspended.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PageMustCloseMsg : ENU=The Payment Reconciliation Journal window has been closed because the connection was suspended.;ESP=La ventana Diarios de conciliación de pagos se cerró porque se suspendió la conexión.;FRA=La fenêtre Feuille rapprochement bancaire a été fermée parce que la connexion a été suspendue.;
    //Variable type has not been exported.

    var
        RBCBankImport: Report "RBC Bank Import";
    // Text50000: Label 'The statement ending balance differs from the bank account after posting. Continue to post ?';//Bc Upgrade YADAVM09 Warning Resolution variable not used anywhere in the code<<


    //Unsupported feature: CodeModification on "InvokePost(PROCEDURE 2)". Please convert manually.

    //procedure InvokePost();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    BankAccReconciliation.GET("Statement Type","Bank Account No.","Statement No.");
    BankAccReconciliation."Post Payments Only" := OnlyPayments;

    IF BankAccReconPostYesNo.BankAccReconPostYesNo(BankAccReconciliation) THEN BEGIN
      RESET;
      PageClosedByPosting := TRUE;
      CurrPage.CLOSE;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //soicad>>
    IF (BankAccReconciliation."Total Balance on Bank Account" + BankAccReconciliation."Total Unposted Applied Amount")
      <> BankAccReconciliation."Statement Ending Balance" THEN BEGIN
      IF NOT CONFIRM(Text50000) THEN
        EXIT;
    END;
    //soicad<<
    #1..8
    */
    //end;

    local procedure Test();
    begin
        //<<HEI.01
        RBCBankImport.SetTemplate(BankAccReconciliation);
        RBCBankImport.RUN();
        //<<HEI.01
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

