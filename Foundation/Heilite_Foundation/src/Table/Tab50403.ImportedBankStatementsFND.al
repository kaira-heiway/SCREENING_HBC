table 50403 "Imported Bank Statements FND"
{
    // HEI.01 CHG2020184 IBM POENAB02 26.06.2019
    //   # New table for Bank Connectivity interface
    //BC Upgrade PATELP08  >>
    //   # NAV OLD ID 50147
    //BC Upgrade PATELP08  <<

    // BC UPGRADE PATELS08 >>
    // # Table moved from Interface to Foundation Layer.
    // # Table name changed from Imported Bank Statements to Imported Bank Statements FND.
    // BC UPGRADE PATELS08 <<
    // BC Upgrade PATELP08>>
    // Changed name of table from "Imported Bank Statements Line" to "Imported Bank Stmt Line FND"
    // BC Upgrade PATELP08<<

    Caption = 'Imported Bank Statements';

    fields
    {
        field(1; "Bank Account No."; Code[20])
        {
            CaptionML = ENU = 'Bank Account No.',
                        FRA = 'N° compte bancaire';
            NotBlank = true;
            TableRelation = "Bank Account";
        }
        field(2; "Statement No."; Code[20])
        {
            CaptionML = ENU = 'Statement No.',
                        FRA = 'N° relevé';
            Editable = false;
            NotBlank = true;
        }
        field(3; "Statement Ending Balance"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CaptionML = ENU = 'Statement Ending Balance',
                        FRA = 'Solde final du relevé';
        }
        field(4; "Statement Date"; Date)
        {
            CaptionML = ENU = 'Statement Date',
                        FRA = 'Date relevé';
        }
        field(5; "Balance Last Statement"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CaptionML = ENU = 'Balance Last Statement',
                        FRA = 'Solde dernier relevé';
        }
        field(6; "Bank Statement"; BLOB)
        {
            CaptionML = ENU = 'Bank Statement',
                        FRA = 'Relevé bancaire';
        }
        field(7; "Total Balance on Bank Account"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FIELD("Bank Account No.")));
            CaptionML = ENU = 'Total Balance on Bank Account',
                        FRA = 'Solde total sur compte bancaire';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Total Applied Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Imported Bank Stmt Line FND"."Applied Amount" WHERE("Statement Type" = FIELD("Statement Type"),
                                                                                      "Bank Account No." = FIELD("Bank Account No."),
                                                                                      "Statement No." = FIELD("Statement No.")));
            CaptionML = ENU = 'Total Applied Amount',
                        FRA = 'Montant lettré total';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Total Transaction Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Imported Bank Stmt Line FND"."Statement Amount" WHERE("Statement Type" = FIELD("Statement Type"),
                                                                                        "Bank Account No." = FIELD("Bank Account No."),
                                                                                        "Statement No." = FIELD("Statement No.")));
            CaptionML = ENU = 'Total Transaction Amount',
                        FRA = 'Montant transaction total';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Total Unposted Applied Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Imported Bank Stmt Line FND"."Applied Amount" WHERE("Statement Type" = FIELD("Statement Type"),
                                                                                      "Bank Account No." = FIELD("Bank Account No."),
                                                                                      "Statement No." = FIELD("Statement No."),
                                                                                      "Account Type" = FILTER(<> "Bank Account")));
            CaptionML = ENU = 'Total Unposted Applied Amount',
                        FRA = 'Montant lettré total non validé';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Total Difference"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Imported Bank Stmt Line FND".Difference WHERE("Statement Type" = FIELD("Statement Type"),
                                                                                "Bank Account No." = FIELD("Bank Account No."),
                                                                                "Statement No." = FIELD("Statement No.")));
            CaptionML = ENU = 'Total Difference',
                        FRA = 'Total différence';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Statement Type"; Option)
        {
            CaptionML = ENU = 'Statement Type',
                        FRA = 'Type relevé';
            OptionCaptionML = ENU = 'Bank Reconciliation,Payment Application',
                              FRA = 'Rapprochement bancaire,Lettrage paiement';
            OptionMembers = "Bank Reconciliation","Payment Application";
        }
        field(21; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            CaptionML = ENU = 'Shortcut Dimension 1 Code',
                        FRA = 'Code raccourci axe 1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(22; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            CaptionML = ENU = 'Shortcut Dimension 2 Code',
                        FRA = 'Code raccourci axe 2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(23; "Post Payments Only"; Boolean)
        {
            CaptionML = ENU = 'Post Payments Only',
                        FRA = 'Valider les paiements uniquement';
        }
        field(24; "Import Posted Transactions"; Option)
        {
            CaptionML = ENU = 'Import Posted Transactions',
                        FRA = 'Importer les transactions validées';
            OptionCaptionML = ENU = ' ,Yes,No',
                              FRA = ' ,Oui,Non';
            OptionMembers = " ",Yes,No;
        }
        field(25; "Total Outstd Bank Transactions"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FIELD("Bank Account No."),
                                                                        Open = CONST(true),
                                                                        "Check Ledger Entries" = CONST(0)));
            CaptionML = ENU = 'Total Outstd Bank Transactions',
                        FRA = 'Total transactions bancaires restantes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Total Outstd Payments"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FIELD("Bank Account No."),
                                                                        Open = CONST(true),
                                                                        "Check Ledger Entries" = FILTER(> 0)));
            CaptionML = ENU = 'Total Outstd Payments',
                        FRA = 'Total paiements restants';
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Total Applied Amount Payments"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Imported Bank Stmt Line FND"."Applied Amount" WHERE("Statement Type" = FIELD("Statement Type"),
                                                                                      "Bank Account No." = FIELD("Bank Account No."),
                                                                                      "Statement No." = FIELD("Statement No."),
                                                                                      Type = CONST("Check Ledger Entry")));
            CaptionML = ENU = 'Total Applied Amount Payments',
                        FRA = 'Montant total paiements lettrés';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Bank Account Balance (LCY)"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry"."Amount (LCY)" WHERE("Bank Account No." = FIELD("Bank Account No.")));
            CaptionML = ENU = 'Bank Account Balance (LCY)',
                        FRA = 'Solde compte bancaire (DS)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; "Total Positive Adjustments"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Imported Bank Stmt Line FND"."Applied Amount" WHERE("Statement Type" = FIELD("Statement Type"),
                                                                                      "Bank Account No." = FIELD("Bank Account No."),
                                                                                      "Statement No." = FIELD("Statement No."),
                                                                                      "Account Type" = FILTER(<> "Bank Account"),
                                                                                      "Statement Amount" = FILTER(> 0)));
            CaptionML = ENU = 'Total Positive Adjustments',
                        FRA = 'Ajustements positifs totaux';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Total Negative Adjustments"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Imported Bank Stmt Line FND"."Applied Amount" WHERE("Statement Type" = FIELD("Statement Type"),
                                                                                      "Bank Account No." = FIELD("Bank Account No."),
                                                                                      "Statement No." = FIELD("Statement No."),
                                                                                      "Account Type" = FILTER(<> "Bank Account"),
                                                                                      "Statement Amount" = FILTER(< 0)));
            CaptionML = ENU = 'Total Negative Adjustments',
                        FRA = 'Ajustements négatifs totaux';
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Total Positive Difference"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Imported Bank Stmt Line FND"."Applied Amount" WHERE("Account Type" = FIELD("Statement Type"),
                                                                                      "Bank Account No." = FIELD("Bank Account No."),
                                                                                      "Statement No." = FIELD("Statement No."),
                                                                                      Type = CONST(Difference),
                                                                                      "Applied Amount" = FILTER(> 0)));
            CaptionML = ENU = 'Total Positive Difference',
                        FRA = 'Différence positive totale';
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Total Negative Difference"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Imported Bank Stmt Line FND"."Applied Amount" WHERE("Account Type" = FIELD("Statement Type"),
                                                                                      "Bank Account No." = FIELD("Bank Account No."),
                                                                                      "Statement No." = FIELD("Statement No."),
                                                                                      Type = CONST(Difference),
                                                                                      "Applied Amount" = FILTER(< 0)));
            CaptionML = ENU = 'Total Negative Difference',
                        FRA = 'Différence négative totale';
            Editable = false;
            FieldClass = FlowField;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            CaptionML = ENU = 'Dimension Set ID',
                        FRA = 'ID ensemble de dimensions';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(70000; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(70001; "Import Date"; Date)
        {
            Caption = 'Import Date';
        }
        field(70002; "File Imported"; Text[250])
        {
            Caption = 'File Imported';
        }
        field(70003; Processed; Boolean)
        {
            Caption = 'Processed';
        }
        field(70004; "Processing Date"; Date)
        {
            Caption = 'Processing Date';
        }
        field(70005; "Processing Time"; Time)
        {
            Caption = 'Processing Time';
        }
        field(70006; "Bank Account Code"; Code[20])
        {
            Caption = 'Bank Account Code';
        }
        field(70007; "Import Time"; Time)
        {
            Caption = 'Import Time';
        }
        field(70008; "File Type"; Option)
        {
            OptionMembers = " ",CAMT053,MT940;
        }
        field(70009; "Processed by User"; Code[50])
        {
            Caption = 'Processed by User';
        }
        field(70011; IBAN; Code[50])
        {
            CaptionML = ENU = 'IBAN',
                        FRA = 'N° compte international (IBAN)';

            trigger OnValidate();
            var
                CompanyInfo: Record "Company Information";
            begin
            end;
        }
        field(70012; "Bank Branch No."; Text[20])
        {
            CaptionML = ENU = 'Bank Branch No.',
                        FRA = 'Code établissement';
        }
        field(70013; "Number Of Records"; Integer)
        {
            Caption = 'Number Of Records';
        }
        field(70014; "Bank Statement No."; Code[20])
        {
            Caption = 'Bank Statement No.';
        }
        field(70015; "Bank Account No. from XML"; Text[30])
        {
            Caption = 'Bank Account No. from XML';
        }
        field(70016; "Bank Acc. Rec. Statement No."; Code[20])
        {
            Caption = 'Bank Acc. Rec. Statement No.';
            Editable = false;

            trigger OnLookup();
            var
                lBankAccReconciliation: Record "Bank Acc. Reconciliation";
                lBankAccReconciliationPage: Page "Bank Acc. Reconciliation";
            begin
                //HEI.01>>
                lBankAccReconciliation.RESET();
                if lBankAccReconciliation.GET(lBankAccReconciliation."Statement Type"::"Bank Reconciliation", "Bank Account No.", "Bank Acc. Rec. Statement No.") then begin
                    lBankAccReconciliationPage.SETRECORD(lBankAccReconciliation);
                    lBankAccReconciliationPage.RUN();
                end;
                //HEI.01<<
            end;
        }
        field(70017; "Reprocessed by User"; Code[50])
        {
            Caption = 'Reprocessed by User';
        }
        field(70018; "Reprocessing Date"; Date)
        {
            Caption = 'Processing Date';
        }
        field(70019; "Reprocessing Time"; Time)
        {
            Caption = 'Processing Time';
        }
    }

    keys
    {
        key(PK; "Statement Type", "Bank Account No.", "Statement No.")
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
        Text001: Label 'You cannot delete this record!';

    local procedure GetCurrencyCode(): Code[10];
    var
        BankAcc2: Record "Bank Account";
    begin
    end;

    procedure Process();
    var
        lBankAccReconciliation: Record "Bank Acc. Reconciliation";
        lBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        lImportedBankStatementsLine: Record "Imported Bank Stmt Line FND";
        lBankAccount: Record "Bank Account";
        lText001: Label 'Bank Acc. Reconciliation %1 for Bank Account No. %2  has been created';
        lText002: Label 'Bank Statement %1 has already been processed! You cannot process it again!';
        lText003: Label 'Bank Account Reconciliation %1 has already been created for Statement No. Imported %2! Do you want to continue?';
        lBankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        lText004: Label 'Bank Account Ledger Entry %1 has already been created! Do you want to continue?';
    begin
        //HEI.01>>
        if Processed then
            ERROR(lText002, "Statement No.");

        if "File Imported" <> '' then begin
            lBankAccReconciliation.RESET();
            lBankAccReconciliation.SETRANGE("Statement No. Imported FND", "File Imported");
            if lBankAccReconciliation.FINDFIRST() then
                if not CONFIRM(STRSUBSTNO(lText003, lBankAccReconciliation."Statement No.", "File Imported")) then
                    exit;

            lBankAccountLedgerEntry.RESET();
            lBankAccountLedgerEntry.SETCURRENTKEY("Statement No. Imported FND");
            lBankAccountLedgerEntry.SETRANGE("Statement No. Imported FND", "File Imported");
            if lBankAccountLedgerEntry.FINDFIRST() then
                if not CONFIRM(STRSUBSTNO(lText004, lBankAccReconciliation."Statement No.")) then
                    exit;
        end;

        lBankAccReconciliation.RESET();
        lBankAccReconciliation.TRANSFERFIELDS(Rec);
        lBankAccReconciliation."Statement No." := '';
        lBankAccReconciliation.VALIDATE("Bank Account No.");
        lBankAccReconciliation."Statement No. Imported FND" := "File Imported";
        lBankAccReconciliation.INSERT();

        lImportedBankStatementsLine.RESET();
        lImportedBankStatementsLine.SETRANGE("Statement Type", "Statement Type");
        lImportedBankStatementsLine.SETRANGE("Bank Account No.", "Bank Account No.");
        lImportedBankStatementsLine.SETRANGE("Statement No.", "Statement No.");
        if lImportedBankStatementsLine.FINDFIRST() then
            repeat
                lBankAccReconciliationLine.TRANSFERFIELDS(lImportedBankStatementsLine);
                lBankAccReconciliationLine."Statement No." := lBankAccReconciliation."Statement No.";
                lBankAccReconciliationLine.VALIDATE("Statement Amount");
                lBankAccReconciliationLine.INSERT();
            until lImportedBankStatementsLine.NEXT() = 0;

        lBankAccount.RESET();
        lBankAccount.GET("Bank Account No.");
        lBankAccount."Last Statement No." := lBankAccReconciliation."Statement No.";
        lBankAccount.MODIFY();

        Processed := true;
        "Processing Date" := TODAY;
        "Processing Time" := TIME;
        "Processed by User" := USERID;
        "Bank Acc. Rec. Statement No." := lBankAccReconciliation."Statement No.";
        MODIFY();

        MESSAGE(STRSUBSTNO(lText001, lBankAccReconciliation."Statement No.", "Bank Account No."));
        //HEI.01<<
    end;

    procedure Reprocess();
    var
        lBankAccReconciliation: Record "Bank Acc. Reconciliation";
        lBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        lImportedBankStatementsLine: Record "Imported Bank Stmt Line FND";
        lBankAccount: Record "Bank Account";
        lText001: Label 'Bank Acc. Reconciliation %1 for Bank Account No. %2  has been created';
        lText002: Label 'Bank Statement %1 has already been processed! You cannot process it again!';
        lText003: Label 'Bank Account Reconciliation %1 has already been created for Statement No. Imported %2! Do you want to continue?';
        lBankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        lText004: Label 'Bank Account Ledger Entry %1 has already been created! Do you want to continue?';
        lText005: Label 'You cannot reprocess because the message has not been processed!';
        lText006: Label 'You are not allowed to reprocess this message!';
        lUserSetup: Record "User Setup";
    begin
        //HEI.01>>
        if Processed = false then
            ERROR(lText005);

        lUserSetup.GET(USERID);
        if lUserSetup."Allow to Rep CAMT053 WS FND" = false then
            ERROR(lText006);

        if "File Imported" <> '' then begin
            lBankAccReconciliation.RESET();
            lBankAccReconciliation.SETRANGE("Statement No. Imported FND", "File Imported");
            if lBankAccReconciliation.FINDFIRST() then
                if not CONFIRM(STRSUBSTNO(lText003, lBankAccReconciliation."Statement No.", "File Imported")) then
                    exit;

            lBankAccountLedgerEntry.RESET();
            lBankAccountLedgerEntry.SETCURRENTKEY("Statement No. Imported FND");
            lBankAccountLedgerEntry.SETRANGE("Statement No. Imported FND", "File Imported");
            if lBankAccountLedgerEntry.FINDFIRST() then
                if not CONFIRM(STRSUBSTNO(lText004, lBankAccReconciliation."Statement No.")) then
                    exit;
        end;

        lBankAccReconciliation.RESET();
        lBankAccReconciliation.TRANSFERFIELDS(Rec);
        lBankAccReconciliation."Statement No." := '';
        lBankAccReconciliation.VALIDATE("Bank Account No.");
        lBankAccReconciliation."Statement No. Imported FND" := "File Imported";
        lBankAccReconciliation.INSERT();

        lImportedBankStatementsLine.RESET();
        lImportedBankStatementsLine.SETRANGE("Statement Type", "Statement Type");
        lImportedBankStatementsLine.SETRANGE("Bank Account No.", "Bank Account No.");
        lImportedBankStatementsLine.SETRANGE("Statement No.", "Statement No.");
        if lImportedBankStatementsLine.FINDFIRST() then
            repeat
                lBankAccReconciliationLine.TRANSFERFIELDS(lImportedBankStatementsLine);
                lBankAccReconciliationLine."Statement No." := lBankAccReconciliation."Statement No.";
                lBankAccReconciliationLine.VALIDATE("Statement Amount");
                lBankAccReconciliationLine.INSERT();
            until lImportedBankStatementsLine.NEXT() = 0;

        lBankAccount.RESET();
        lBankAccount.GET("Bank Account No.");
        lBankAccount."Last Statement No." := lBankAccReconciliation."Statement No.";
        lBankAccount.MODIFY();

        Processed := true;
        "Reprocessing Date" := TODAY;
        "Reprocessing Time" := TIME;
        "Reprocessed by User" := USERID;
        "Bank Acc. Rec. Statement No." := lBankAccReconciliation."Statement No.";
        MODIFY();

        MESSAGE(STRSUBSTNO(lText001, lBankAccReconciliation."Statement No.", "Bank Account No."));
        //HEI.01<<
    end;
}

