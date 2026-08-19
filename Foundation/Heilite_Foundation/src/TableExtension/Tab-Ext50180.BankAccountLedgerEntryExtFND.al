tableextension 50180 "BankAccountLedgerEntryExtFND" extends "Bank Account Ledger Entry"
{
    // version NAVW110.0,DITW110.00.09,HEI.02

    //     FINXL9.00.001 DAT 25/02/2016 : Extend field Description from 50 -> 80 chars

    // DITW17.00.02 SR 10/09/2013 DIT-770 #137 : Add options 'Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back' to "Document Type"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // HEI.01 Defect#116-BugFix IBM PATHAA02
    // #New field added "Comment"
    // HEI.02 FDD-KDD0TC002 IBM HORTOC01 04.10.2017 - new option on "Document type" field - "Interest Rate Credit"
    // HEI.03 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New keys added
    //     # "Source Code,Posting Date,Document No."
    //     # "Source Code,Document No.,Posting Date"
    //     # "Bank Account No.,Posting Date,Source Code"
    //     # "Bank Account No.,Document No.,Posting Date"
    //   # Set key "Bank Account No.,Global Dimension 1 Code,Global Dimension 2 Code,Posting Date" Enabled = TRUE
    // HEI.04 CHG2020184 IBM POENAB02 26.06.2019
    //   # New field: 50000 Statement No. Imported
    //   # New key: "Statement No. Imported"

    // HEI.05 FDD-HT626 IBM SURYAS01 16-12-2019 FDD_Bank Connection Setup_La Réunion
    //  #Created New Following Fields:
    //   Transaction Code
    //   Exported
    //  #Added Code in Function-"CopyFromGenJnlLine"

    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Bank Account No.")
        {
            CaptionML = ENU = 'Bank Account No.', FRA = 'N° compte bancaire';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêt,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment';

            //Unsupported feature: Change OptionString on ""Document Type"(Field 5)". Please convert manually.

            //Unsupported feature: Change Description on ""Document Type"(Field 5)". Please convert manually.

        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Remaining Amount")
        {
            CaptionML = ENU = 'Remaining Amount', FRA = 'Montant ouvert';
        }
        modify("Amount (LCY)")
        {
            CaptionML = ENU = 'Amount (LCY)', FRA = 'Montant DS';
        }
        modify("Bank Acc. Posting Group")
        {
            CaptionML = ENU = 'Bank Acc. Posting Group', FRA = 'Groupe compta. banque';
        }
        modify("Global Dimension 1 Code")
        {
            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {
            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Our Contact Code")
        {
            CaptionML = ENU = 'Our Contact Code', FRA = 'Code contact';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify(Open)
        {
            CaptionML = ENU = 'Open', FRA = 'Ouvert';
        }
        modify(Positive)
        {
            CaptionML = ENU = 'Positive', FRA = 'Positif';
        }
        modify("Closed by Entry No.")
        {
            CaptionML = ENU = 'Closed by Entry No.', FRA = 'N° séquence lettrage final';
        }
        modify("Closed at Date")
        {
            CaptionML = ENU = 'Closed at Date', FRA = 'Date de clôture';
        }
        modify("Journal Batch Name")
        {
            CaptionML = ENU = 'Journal Batch Name', FRA = 'Nom feuille';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Bal. Account Type")
        {
            CaptionML = ENU = 'Bal. Account Type', FRA = 'Type compte contrepartie';
            //OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset', FRA = 'Général,Client,Fournisseur,Banque,Immobilisation';
        }
        modify("Bal. Account No.")
        {
            CaptionML = ENU = 'Bal. Account No.', FRA = 'N° compte contrepartie';
        }
        modify("Transaction No.")
        {
            CaptionML = ENU = 'Transaction No.', FRA = 'N° transaction';
        }
        modify("Statement Status")
        {
            CaptionML = ENU = 'Statement Status', FRA = 'Etat du relevé';
            OptionCaptionML = ENU = 'Open,Bank Acc. Entry Applied,Check Entry Applied,Closed', FRA = 'Ouvert,Rapproché sur compte bancaire,Rapproché sur compte chèque,Fermé';
        }
        modify("Statement No.")
        {
            CaptionML = ENU = 'Statement No.', FRA = 'N° relevé';
        }
        modify("Statement Line No.")
        {
            CaptionML = ENU = 'Statement Line No.', FRA = 'N° ligne relevé';
        }
        modify("Debit Amount")
        {
            CaptionML = ENU = 'Debit Amount', FRA = 'Montant débit';
        }
        modify("Credit Amount")
        {
            CaptionML = ENU = 'Credit Amount', FRA = 'Montant crédit';
        }
        modify("Debit Amount (LCY)")
        {
            CaptionML = ENU = 'Debit Amount (LCY)', FRA = 'Montant débit DS';
        }
        modify("Credit Amount (LCY)")
        {
            CaptionML = ENU = 'Credit Amount (LCY)', FRA = 'Montant crédit DS';
        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        }
        modify(Reversed)
        {
            CaptionML = ENU = 'Reversed', FRA = 'Contre-passé';
        }
        modify("Reversed by Entry No.")
        {
            CaptionML = ENU = 'Reversed by Entry No.', FRA = 'Contre-passé par n° écriture';
        }
        modify("Reversed Entry No.")
        {
            CaptionML = ENU = 'Reversed Entry No.', FRA = 'N° écriture contre-passée';
        }
        modify("Check Ledger Entries")
        {
            CaptionML = ENU = 'Check Ledger Entries', FRA = 'Écritures comptables chèque';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        field(50000; "Comment FND"; Text[250])
        {
            Description = 'HEI.01';
            Caption = 'Comment';
        }
        field(50001; "Statement No. Imported FND"; Text[250])
        {
            Caption = 'Statement No. Imported';
            Description = 'HEI.04';
            Editable = false;
        }
        field(55000; "Transaction Code FND"; Code[20])
        {
            Description = 'HEI.05';
            Caption = 'Transaction Code';
            TableRelation = "Transaction Codes FND";
        }
        field(55001; "Exported FND"; Boolean)
        {
            Description = 'HEI.05';
            Caption = 'Exported';
        }
    }
    keys
    {

        //Unsupported feature: PropertyDeletion on ""Bank Account No.","Global Dimension 1 Code","Global Dimension 2 Code","Posting Date"(Key)". Please convert manually.

        key(Key50000; "Source Code", "Posting Date", "Document No.")
        {
        }
        key(Key50001; "Source Code", "Document No.", "Posting Date")
        {
        }
        key(Key50002; "Bank Account No.", "Posting Date", "Source Code")
        {
        }
        key(Key50003; "Bank Account No.", "Document No.", "Posting Date")
        {
        }
        key(Key50004; "Statement No. Imported FND")
        {
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
}

