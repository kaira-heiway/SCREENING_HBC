table 50396 "Imported Bank Stmt Line FND"
{
    // HEI.01 CHG2020184 IBM POENAB02 26.06.2019
    //   # New table for Bank Connectivity interface
    //BC Upgrade PATELS08  >>
    //   # NAV OLD ID 50149
    //BC Upgrade PATELS08  <<

    // BC Upgrade PATELP08>>
    // Moved table from Interface to Foundation Ext.
    // Changed name of table from "Imported Bank Statements Line" to "Imported Bank Stmt Line FND"
    // BC Upgrade PATELP08<<

    Caption = 'Imported Bank Statements Line';

    fields
    {
        field(1; "Bank Account No."; Code[20])
        {
            CaptionML = ENU = 'Bank Account No.',
                        ESP = 'Cód. cuenta banco',
                        FRA = 'N° compte bancaire';
            TableRelation = "Bank Account";
        }
        field(2; "Statement No."; Code[20])
        {
            CaptionML = ENU = 'Statement No.',
                        ESP = 'Nº estado de cta. banco',
                        FRA = 'N° relevé';
            TableRelation = "Bank Acc. Reconciliation"."Statement No." WHERE("Bank Account No." = FIELD("Bank Account No."));
        }
        field(3; "Statement Line No."; Integer)
        {
            CaptionML = ENU = 'Statement Line No.',
                        ESP = 'Nº lín. estado de cta. banco',
                        FRA = 'N° ligne relevé';
        }
        field(4; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        ESP = 'Nº documento',
                        FRA = 'N° document';
        }
        field(5; "Transaction Date"; Date)
        {
            CaptionML = ENU = 'Transaction Date',
                        ESP = 'Fecha movimiento',
                        FRA = 'Date transaction';
        }
        field(6; Description; Text[50])
        {
            CaptionML = ENU = 'Description',
                        ESP = 'Descripción',
                        FRA = 'Désignation';
        }
        field(7; "Statement Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CaptionML = ENU = 'Statement Amount',
                        ESP = 'Importe estado de cuenta',
                        FRA = 'Montant relevé';
        }
        field(8; Difference; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            BlankZero = true;
            CaptionML = ENU = 'Difference',
                        ESP = 'Diferencia',
                        FRA = 'Différence';
        }
        field(9; "Applied Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            BlankZero = true;
            CaptionML = ENU = 'Applied Amount',
                        ESP = 'Importe conciliado',
                        FRA = 'Montant lettré';
            Editable = false;
        }
        field(10; Type; Option)
        {
            CaptionML = ENU = 'Type',
                        ESP = 'Tipo',
                        FRA = 'Type';
            OptionCaptionML = ENU = 'Bank Account Ledger Entry,Check Ledger Entry,Difference',
                              ESP = 'Mov. banco,Mov. cheque,Diferencia',
                              FRA = 'Banque,Chèque,Différence';
            OptionMembers = "Bank Account Ledger Entry","Check Ledger Entry",Difference;
        }
        field(11; "Applied Entries"; Integer)
        {
            CaptionML = ENU = 'Applied Entries',
                        ESP = 'Movs. conciliados',
                        FRA = 'Écritures lettrées';
            Editable = false;
        }
        field(12; "Value Date"; Date)
        {
            CaptionML = ENU = 'Value Date',
                        ESP = 'Fecha valor',
                        FRA = 'Date de valeur';
        }
        field(13; "Ready for Application"; Boolean)
        {
            CaptionML = ENU = 'Ready for Application',
                        ESP = 'Listo para conciliar',
                        FRA = 'Prêt à lettrer';
        }
        field(14; "Check No."; Code[20])
        {
            CaptionML = ENU = 'Check No.',
                        ESP = 'Nº cheque',
                        FRA = 'N° chèque';
        }
        field(15; "Related-Party Name"; Text[250])
        {
            CaptionML = ENU = 'Related-Party Name',
                        ESP = 'Nombre de parte vinculada',
                        FRA = 'Nom partie associée';
        }
        field(16; "Additional Transaction Info"; Text[100])
        {
            CaptionML = ENU = 'Additional Transaction Info',
                        ESP = 'Información adicional de la transacción',
                        FRA = 'Info transaction supplémentaire';
        }
        field(17; "Data Exch. Entry No."; Integer)
        {
            CaptionML = ENU = 'Data Exch. Entry No.',
                        ESP = 'N.º mov. intercambio de datos',
                        FRA = 'N° écriture échange données';
            Editable = false;
            TableRelation = "Data Exch.";
        }
        field(18; "Data Exch. Line No."; Integer)
        {
            CaptionML = ENU = 'Data Exch. Line No.',
                        ESP = 'N.º línea intercambio de datos',
                        FRA = 'N° ligne échange données';
            Editable = false;
        }
        field(20; "Statement Type"; Option)
        {
            CaptionML = ENU = 'Statement Type',
                        ESP = 'Tipo de extracto',
                        FRA = 'Type relevé';
            OptionCaptionML = ENU = 'Bank Reconciliation,Payment Application',
                              ESP = 'Conciliación banco,liquidación de pago',
                              FRA = 'Rapprochement bancaire,Lettrage paiement';
            OptionMembers = "Bank Reconciliation","Payment Application";
        }
        field(21; "Account Type"; Option)
        {
            CaptionML = ENU = 'Account Type',
                        ESP = 'Tipo de cta.',
                        FRA = 'Type compte';
            OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner',
                              ESP = 'Cuenta,Cliente,Proveedor,Banco,Activo fijo,Empresa vinculada asociada',
                              FRA = 'Général,Client,Fournisseur,Banque,Immobilisation,Partenaire IC';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(22; "Account No."; Code[20])
        {
            CaptionML = ENU = 'Account No.',
                        ESP = 'Nº cuenta',
                        FRA = 'N° compte';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            ELSE IF ("Account Type" = CONST(Customer)) Customer
            ELSE IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE IF ("Account Type" = CONST("IC Partner")) "IC Partner";
        }
        field(23; "Transaction Text"; Text[140])
        {
            CaptionML = ENU = 'Transaction Text',
                        ESP = 'Texto transacción',
                        FRA = 'Texte transaction';
        }
        field(24; "Related-Party Bank Acc. No."; Text[100])
        {
            CaptionML = ENU = 'Related-Party Bank Acc. No.',
                        ESP = 'N.º cta. bancaria parte vinculada',
                        FRA = 'N° cpte bancaire partie associée';
        }
        field(25; "Related-Party Address"; Text[120])
        {
            CaptionML = ENU = 'Related-Party Address',
                        ESP = 'Dirección parte vinculada',
                        FRA = 'Adresse partie associée';
        }
        field(26; "Related-Party City"; Text[50])
        {
            CaptionML = ENU = 'Related-Party City',
                        ESP = 'Ciudad parte vinculada',
                        FRA = 'Ville partie associée';
        }
        field(31; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            CaptionML = ENU = 'Shortcut Dimension 1 Code',
                        ESP = 'Cód. dim. acceso dir. 1',
                        FRA = 'Code raccourci axe 1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(32; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            CaptionML = ENU = 'Shortcut Dimension 2 Code',
                        ESP = 'Cód. dim. acceso dir. 2',
                        FRA = 'Code raccourci axe 2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50; "Match Confidence"; Option)
        {
            CalcFormula = Max("Applied Payment Entry"."Match Confidence" WHERE("Statement Type" = FIELD("Statement Type"),
                                                                                "Bank Account No." = FIELD("Bank Account No."),
                                                                                "Statement No." = FIELD("Statement No."),
                                                                                "Statement Line No." = FIELD("Statement Line No.")));
            CaptionML = ENU = 'Match Confidence',
                        ESP = 'Confianza de la correspondencia',
                        FRA = 'Fiabilité correspondance';
            Editable = false;
            FieldClass = FlowField;
            InitValue = "None";
            OptionCaptionML = ENU = 'None,Low,Medium,High,High - Text-to-Account Mapping,Manual,Accepted',
                              ESP = 'Ninguna,Baja,Media,Alta,Alta: asignación de texto a cuentas,Manual,Aceptada',
                              FRA = 'Aucune,Faible,Moyenne,Élevée,Élevée - Correspondance texte et compte,Manuelle,Acceptée';
            OptionMembers = "None",Low,Medium,High,"High - Text-to-Account Mapping",Manual,Accepted;
        }
        field(51; "Match Quality"; Integer)
        {
            CalcFormula = Max("Applied Payment Entry".Quality WHERE("Bank Account No." = FIELD("Bank Account No."),
                                                                     "Statement No." = FIELD("Statement No."),
                                                                     "Statement Line No." = FIELD("Statement Line No."),
                                                                     "Statement Type" = FIELD("Statement Type")));
            CaptionML = ENU = 'Match Quality',
                        ESP = 'Corresponder calidad',
                        FRA = 'Qualité correspondance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Sorting Order"; Integer)
        {
            CaptionML = ENU = 'Sorting Order',
                        ESP = 'Orden clasificación',
                        FRA = 'Ordre de tri';
        }
        field(61; "Parent Line No."; Integer)
        {
            CaptionML = ENU = 'Parent Line No.',
                        ESP = 'N.º línea maestro',
                        FRA = 'N° ligne parent';
            Editable = false;
        }
        field(70; "Transaction ID"; Text[50])
        {
            CaptionML = ENU = 'Transaction ID',
                        ESP = 'Id. de transacción',
                        FRA = 'ID transaction';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            CaptionML = ENU = 'Dimension Set ID',
                        ESP = 'Id. grupo dimensiones',
                        FRA = 'ID ensemble de dimensions';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(50000; "IBAN Matched"; Boolean)
        {
        }
        field(50341; "Rem Amount"; Decimal)
        {
            CalcFormula = Sum("Applied Payment Entry"."Rem. Amount FND" WHERE("Bank Account No." = FIELD("Bank Account No."),
                                                                           "Statement No." = FIELD("Statement No."),
                                                                           "Statement Line No." = FIELD("Statement Line No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(70000; "Header Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(70001; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(70002; "Bank Statement No."; Code[20])
        {
            Caption = 'Bank Statement No.';
        }
        field(2014310; "Document Type"; Option)
        {
            CaptionML = ENU = 'Document Type',
                        FRA = 'Type document';
            OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment',
                              ESP = ' ,Pago,Factura,Abono,Docs. interés,Recordatorio,Reembolso,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment',
                              FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque réverse,Bank Charge,Paiement emprunte,Repaiement emprunte,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,"Bank Reverse","Bank Charge","Loan Pay Out","Loan Pay Back","Purchase Receipt","Interest Rate Credit","RPM Damage or Loss","FFE Security Payment";
        }
        field(2014311; "Applies-to Doc. Type"; Option)
        {
            CaptionML = ENU = 'Applies-to Doc. Type',
                        FRA = 'Type doc. lettrage';
            OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back',
                              FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêt';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,"Bank Reverse","Bank Charge","Loan Pay Out","Loan Pay Back";
        }
    }

    keys
    {
        key(PK; "Statement Type", "Bank Account No.", "Statement No.", "Statement Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        //HEI.01>>
        ERROR(Text001);
        //HEI.01<<
    end;

    var
        ImportPostedTransactionsQst: TextConst ENU = 'The bank statement contains payments that are already applied, but the related bank account ledger entries are not closed.\\Do you want to include these payments in the import?', ESP = 'El extracto bancario contiene pagos ya liquidados, pero los movimientos de banco relacionados no están cerrados.\\¿Quiere incluir estos pagos en la importación?', FRA = 'Le relevé bancaire contient les paiements déjà lettrés, mais les écritures comptables dans le compte bancaire associées ne sont pas clôturées.\\Voulez-vous inclure ces paiements à l''importation ?';
        Text001: Label 'You cannot delete this record!';

    local procedure GetCurrencyCode(): Code[10];
    var
        BankAcc2: Record "Bank Account";
    begin
        //HEI.01>>
        if "Bank Account No." = BankAcc2."No." then
            exit(BankAcc2."Currency Code");

        if BankAcc2.GET("Bank Account No.") then
            exit(BankAcc2."Currency Code");

        exit('');
    end;

    procedure CanImport(): Boolean;
    begin
        exit(true);
        //HEI.01<<
    end;
}

