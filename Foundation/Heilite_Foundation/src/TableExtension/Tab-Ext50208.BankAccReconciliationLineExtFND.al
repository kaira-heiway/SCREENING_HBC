tableextension 50208 BankAccReconciliatLineExtFND extends "Bank Acc. Reconciliation Line"
{
    // DITW17.00.02 SR 10/09/2013 DIT-770 #137 : Add options 'Bank Reverse,,Loan Pay Out,Loan Pay Back' to "Document Type"
    //                                         : New Field "2014310, 2014311" added
    //                                         : Add options 'Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back' to "Applies-to Doc. Type"
    //                                         : Option 'Bank Charge' was missing for "Document Type" and "Applies-to Doc. Type"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4

    // HEI.01 PURGAP05 IBM LAZARE02 31.07.2017 # Extend Related-Party Address to 120

    // HEI.02 FDD-KDD0TC002 IBM HORTOC01 04.10.2017 - new option on "Document type" field - "Interest Rate Credit"

    // HEI.03 FDD-KDD0TC004 IBM NASTAA02 22.12.2017 # OTC - Returnable Packaging Material - RPM
    //   # Added missing options in "Document Type"

    // version NAVW110.0.00.15601,DITW110.00.09,HEI.01

    fields
    {
        modify("Bank Account No.")
        {
            CaptionML = ENU = 'Bank Account No.', ESP = 'Cód. cuenta banco', FRA = 'N° compte bancaire';
        }
        modify("Statement No.")
        {
            CaptionML = ENU = 'Statement No.', ESP = 'Nº estado de cta. banco', FRA = 'N° relevé';
        }
        modify("Statement Line No.")
        {
            CaptionML = ENU = 'Statement Line No.', ESP = 'Nº lín. estado de cta. banco', FRA = 'N° ligne relevé';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', ESP = 'Nº documento', FRA = 'N° document';
        }
        modify("Transaction Date")
        {
            CaptionML = ENU = 'Transaction Date', ESP = 'Fecha movimiento', FRA = 'Date transaction';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', ESP = 'Descripción', FRA = 'Désignation';
        }
        modify("Statement Amount")
        {
            CaptionML = ENU = 'Statement Amount', ESP = 'Importe estado de cuenta', FRA = 'Montant relevé';
        }
        modify(Difference)
        {
            CaptionML = ENU = 'Difference', ESP = 'Diferencia', FRA = 'Différence';
        }
        modify("Applied Amount")
        {
            CaptionML = ENU = 'Applied Amount', ESP = 'Importe conciliado', FRA = 'Montant lettré';
        }
        // modify(Type)
        // {
        //     CaptionML = ENU='Type',ESP='Tipo',FRA='Type';
        //     OptionCaptionML = ENU='Bank Account Ledger Entry,Check Ledger Entry,Difference',ESP='Mov. banco,Mov. cheque,Diferencia',FRA='Banque,Chèque,Différence';
        // }//BC Upgrade KAPOOV01
        modify("Applied Entries")
        {
            CaptionML = ENU = 'Applied Entries', ESP = 'Movs. conciliados', FRA = 'Écritures lettrées';
        }
        modify("Value Date")
        {
            CaptionML = ENU = 'Value Date', ESP = 'Fecha valor', FRA = 'Date de valeur';
        }
        modify("Ready for Application")
        {
            CaptionML = ENU = 'Ready for Application', ESP = 'Listo para conciliar', FRA = 'Prêt à lettrer';
        }
        modify("Check No.")
        {
            CaptionML = ENU = 'Check No.', ESP = 'Nº cheque', FRA = 'N° chèque';
        }
        modify("Related-Party Name")
        {
            CaptionML = ENU = 'Related-Party Name', ESP = 'Nombre de parte vinculada', FRA = 'Nom partie associée';
        }
        modify("Additional Transaction Info")
        {
            CaptionML = ENU = 'Additional Transaction Info', ESP = 'Información adicional de la transacción', FRA = 'Info transaction supplémentaire';
        }
        modify("Data Exch. Entry No.")
        {
            CaptionML = ENU = 'Data Exch. Entry No.', ESP = 'N.º mov. intercambio de datos', FRA = 'N° écriture échange données';
        }
        modify("Data Exch. Line No.")
        {
            CaptionML = ENU = 'Data Exch. Line No.', ESP = 'N.º línea intercambio de datos', FRA = 'N° ligne échange données';
        }
        modify("Statement Type")
        {
            CaptionML = ENU = 'Statement Type', ESP = 'Tipo de extracto', FRA = 'Type relevé';
            //OptionCaptionML = ENU = 'Bank Reconciliation,Payment Application', ESP = 'Conciliación banco,liquidación de pago', FRA = 'Rapprochement bancaire,Lettrage paiement';
        }
        modify("Account Type")
        {
            CaptionML = ENU = 'Account Type', ESP = 'Tipo de cta.', FRA = 'Type compte';
            // OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner', ESP = 'Cuenta,Cliente,Proveedor,Banco,Activo fijo,Empresa vinculada asociada', FRA = 'Général,Client,Fournisseur,Banque,Immobilisation,Partenaire IC';
        }
        modify("Account No.")
        {
            CaptionML = ENU = 'Account No.', ESP = 'Nº cuenta', FRA = 'N° compte';
        }
        modify("Transaction Text")
        {
            CaptionML = ENU = 'Transaction Text', ESP = 'Texto transacción', FRA = 'Texte transaction';
        }
        modify("Related-Party Bank Acc. No.")
        {
            CaptionML = ENU = 'Related-Party Bank Acc. No.', ESP = 'N.º cta. bancaria parte vinculada', FRA = 'N° cpte bancaire partie associée';
        }
        modify("Related-Party Address")
        {

            //Unsupported feature: Change Data type on ""Related-Party Address"(Field 25)". Please convert manually.

            CaptionML = ENU = 'Related-Party Address', ESP = 'Dirección parte vinculada', FRA = 'Adresse partie associée';
        }
        modify("Related-Party City")
        {
            CaptionML = ENU = 'Related-Party City', ESP = 'Ciudad parte vinculada', FRA = 'Ville partie associée';
        }
        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', ESP = 'Cód. dim. acceso dir. 1', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', ESP = 'Cód. dim. acceso dir. 2', FRA = 'Code raccourci axe 2';
        }
        modify("Match Confidence")
        {
            CaptionML = ENU = 'Match Confidence', ESP = 'Confianza de la correspondencia', FRA = 'Fiabilité correspondance';
            //OptionCaptionML = ENU = 'None,Low,Medium,High,High - Text-to-Account Mapping,Manual,Accepted', ESP = 'Ninguna,Baja,Media,Alta,Alta: asignación de texto a cuentas,Manual,Aceptada', FRA = 'Aucune,Faible,Moyenne,Élevée,Élevée - Correspondance texte et compte,Manuelle,Acceptée';
        }
        modify("Match Quality")
        {
            CaptionML = ENU = 'Match Quality', ESP = 'Corresponder calidad', FRA = 'Qualité correspondance';
        }
        modify("Sorting Order")
        {
            CaptionML = ENU = 'Sorting Order', ESP = 'Orden clasificación', FRA = 'Ordre de tri';
        }
        modify("Parent Line No.")
        {
            CaptionML = ENU = 'Parent Line No.', ESP = 'N.º línea maestro', FRA = 'N° ligne parent';
        }
        modify("Transaction ID")
        {
            CaptionML = ENU = 'Transaction ID', ESP = 'Id. de transacción', FRA = 'ID transaction';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', ESP = 'Id. grupo dimensiones', FRA = 'ID ensemble de dimensions';
        }
        field(50000; "IBAN Matched FND"; Boolean)
        {
            Caption = 'IBAN Matched';
            Description = 'HEI.01';
        }
        field(50341; "Rem Amount FND"; Decimal)
        {
            Caption = 'Rem Amount';
            CalcFormula = Sum("Applied Payment Entry"."Rem. Amount FND" where("Bank Account No." = FIELD("Bank Account No."),
                                                                           "Statement No." = FIELD("Statement No."),
                                                                           "Statement Line No." = FIELD("Statement Line No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        //BC Upgrade KAPOOV01 Drink-it>>
        // field(2014310; "Document Type"; Option)
        // {
        //     CaptionML = ENU = 'Document Type',
        //                 FRA = 'Type document';
        //     Description = 'HEI.02,HEI.03';
        //     OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment',
        //                       ESP = ' ,Pago,Factura,Abono,Docs. interés,Recordatorio,Reembolso,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment',
        //                       FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque réverse,Bank Charge,Paiement emprunte,Repaiement emprunte,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment';
        //     OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,"Bank Reverse","Bank Charge","Loan Pay Out","Loan Pay Back","Purchase Receipt","Interest Rate Credit","RPM Damage or Loss","FFE Security Payment";
        // }
        // field(2014311; "Applies-to Doc. Type"; Option)
        // {
        //     CaptionML = ENU = 'Applies-to Doc. Type',
        //                 FRA = 'Type doc. lettrage';
        //     OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back',
        //                       FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêt';
        //     OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,"Bank Reverse","Bank Charge","Loan Pay Out","Loan Pay Back";
        // }
        //BC Upgrade KAPOOV01 Drink-it<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot rename a %1.;ESP=No se puede cambiar el nombre a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Delete application?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Delete application?;ESP=¿Confirma que desea eliminar la conciliación?;FRA=Souhaitez-vous supprimer le lettrage ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=Update canceled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=Update canceled.;ESP=Actualización cancelada.;FRA=Mise à jour annulée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "AmountWithinToleranceRangeTok(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //AmountWithinToleranceRangeTok : @@@={Locked};ENU=">=%1&<=%2";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AmountWithinToleranceRangeTok : @@@={Locked};ENU=">=%1&<=%2";ESP=">=%1&<=%2";FRA=">=%1&<=%2";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "AmountOustideToleranceRangeTok(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //AmountOustideToleranceRangeTok : @@@={Locked};ENU=<%1|>%2;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AmountOustideToleranceRangeTok : @@@={Locked};ENU=<%1|>%2;ESP=<%1|>%2;FRA=<%1|>%2;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "TransactionAmountMustNotBeZeroErr(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //TransactionAmountMustNotBeZeroErr : ENU=The Transaction Amount field must have a value that is not 0.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TransactionAmountMustNotBeZeroErr : ENU=The Transaction Amount field must have a value that is not 0.;ESP=El campo Importe de la transacción debe tener un valor que no sea 0.;FRA=La valeur du champ Montant transaction doit être différente de 0.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CreditTheAccountQst(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CreditTheAccountQst : @@@=%1 is the account name, %2 is the amount that is not applied (there is filed on the page named Remaining Amount To Apply);ENU=The remaining amount to apply is %2.\\Do you want to create a new payment application line that will debit or credit %1 with the remaining amount when you post the payment?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreditTheAccountQst : @@@=%1 is the account name, %2 is the amount that is not applied (there is filed on the page named Remaining Amount To Apply);ENU=The remaining amount to apply is %2.\\Do you want to create a new payment application line that will debit or credit %1 with the remaining amount when you post the payment?;ESP=El Importe pendiente de liquidación es %2.\\¿Quiere crear una nueva línea de liquidación de pago que debitará o acreditará en %1 el importe pendiente cuando registre el pago?;FRA=Le montant ouvert à lettrer est %2.\\Souhaitez-vous créer une ligne lettrage paiement qui débitera ou créditera %1 du montant ouvert lors de la validation du paiement ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ExcessiveAmountErr(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ExcessiveAmountErr : @@@=%1 is the amount that is not applied (there is filed on the page named Remaining Amount To Apply);ENU=The remaining amount to apply is %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ExcessiveAmountErr : @@@=%1 is the amount that is not applied (there is filed on the page named Remaining Amount To Apply);ENU=The remaining amount to apply is %1.;ESP=El importe pendiente de liquidación es %1.;FRA=Le montant ouvert à lettrer est %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ImportPostedTransactionsQst(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ImportPostedTransactionsQst : ENU=The bank statement contains payments that are already applied, but the related bank account ledger entries are not closed.\\Do you want to include these payments in the import?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ImportPostedTransactionsQst : ENU=The bank statement contains payments that are already applied, but the related bank account ledger entries are not closed.\\Do you want to include these payments in the import?;ESP=El extracto bancario contiene pagos ya liquidados, pero los movimientos de banco relacionados no están cerrados.\\¿Quiere incluir estos pagos en la importación?;FRA=Le relevé bancaire contient les paiements déjà lettrés, mais les écritures comptables dans le compte bancaire associées ne sont pas clôturées.\\Voulez-vous inclure ces paiements à l'importation ?;
    //Variable type has not been exported.
}

