tableextension 50066 FALedgerEntryExtFND extends "FA Ledger Entry"
{
    // HEI.01 FDD-RTRGAP056 IBM HORTOC01 25.08.2017
    //   # New fields added
    //     Add new option to "Document type" field - ,Prepayment Invoice,Prepayment CreditMemo,Purchase Receipt
    // HEI.02 NAV-Bug-Fix IBM PATHAA02 19.09.17
    // # New Field "Comment" added
    // HEI.03 PTPGAP067 IBM ISYED01 08/09/2017 Purchase To Pay downPayment
    //   # Added options Prepayment Invoice,Prepayment Credit Memo to Field Document Type
    // HEI.04 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    //   # New option "RPM Damage or Loss" added on "Document Type" field
    // HEI.05 FDD-HT665 - Ethiopia Customize FA Ledger Entries IBM NASTAA02 09.07.2019 # Ethiopia Customize FA Ledger Entries
    //   # New Field created: 50002 - Vendor ID
    //                        50003 - PO Number
    //                        50004 - Reference Number
    //                        50005 - CAPEX Code
    // HEI.06 FDD-HT584 IBM NASTAA02 02.09.2019 # La Reunion FA Derogatory Depreciation
    //   # New Field created: 10800 - Exclude Derogatory
    //   # Added new option 'Derogatory' to "FA Posting Type" Field
    // HEI.07 CHG2100218 IBM POENAB02 24.02.2021 # FA Depreciation Calculation optimization
    //   # Added keys:
    //     # FA No.,Depreciation Book Code,Part of Book Value
    //     # FA No.,FA Posting Date,Depreciation Book Code,FA Posting Category,FA Posting Type,Part of Book Value
    //     # FA No.,Depreciation Book Code,FA Posting Category,FA Posting Type
    //     # FA No.,Depreciation Book Code

    // HEI.08 FDD-HB2311 CHG2200648 IBM NANDIS01 12-06-2023 #Correct posting flow FA invoicing (credit notes)
    //   # New Option String added - "Purchase Shipment" under field "Document Type"
    // version NAVW110.0,DITW110.00.08,HEI.08

    //Bc Upgrade YADAVM09 Drink it field blocked -Exclude Derogatory.

    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("G/L Entry No.")
        {
            CaptionML = ENU = 'G/L Entry No.', FRA = 'N° séquence compta.';
        }
        modify("FA No.")
        {
            CaptionML = ENU = 'FA No.', FRA = 'N° immo.';
        }
        modify("FA Posting Date")
        {
            CaptionML = ENU = 'FA Posting Date', FRA = 'Date compta. immo.';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment,Purchase Shipment', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêtk,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment,Purchase Shipment';

            //Unsupported feature: Change OptionString on ""Document Type"(Field 6)". Please convert manually.


            //Unsupported feature: Change Description on ""Document Type"(Field 6)". Please convert manually.

        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Depreciation Book Code")
        {
            CaptionML = ENU = 'Depreciation Book Code', FRA = 'Code loi d''amortissement';
        }
        modify("FA Posting Category")
        {
            CaptionML = ENU = 'FA Posting Category', FRA = 'Catégorie compta. immo.';
           // OptionCaptionML = ENU = ' ,Disposal,Bal. Disposal', FRA = ' ,Cession,Contrepartie cession';
        }
        modify("FA Posting Type")
        {
            CaptionML = ENU = 'FA Posting Type', FRA = 'Type compta. immo.';
           // OptionCaptionML = ENU = 'Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Proceeds on Disposal,Salvage Value,Gain/Loss,Book Value on Disposal,,,,,Derogatory', FRA = 'Coût acquisition,Amortissement,Dépréciation,Réévaluation,Param. 1,Param. 2,Produit de cession,Valeur résiduelle,Gain/Perte,Valeur comptable cession,,,,,Dérogatoire';

            //Unsupported feature: Change OptionString on ""FA Posting Type"(Field 13)". Please convert manually.

        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Debit Amount")
        {
            CaptionML = ENU = 'Debit Amount', FRA = 'Montant débit';
        }
        modify("Credit Amount")
        {
            CaptionML = ENU = 'Credit Amount', FRA = 'Montant crédit';
        }
        modify("Reclassification Entry")
        {
            CaptionML = ENU = 'Reclassification Entry', FRA = 'Ecriture reclass.';
        }
        modify("Part of Book Value")
        {
            CaptionML = ENU = 'Part of Book Value', FRA = 'Composant valeur comptable';
        }
        modify("Part of Depreciable Basis")
        {
            CaptionML = ENU = 'Part of Depreciable Basis', FRA = 'Composant base amort.';
        }
        modify("Disposal Calculation Method")
        {
            CaptionML = ENU = 'Disposal Calculation Method', FRA = 'Méthode calcul cession';
            OptionCaptionML = ENU = ' ,Net,Gross', FRA = ' ,Nette,Brute';
        }
        modify("Disposal Entry No.")
        {
            CaptionML = ENU = 'Disposal Entry No.', FRA = 'N° séquence cession';
        }
        modify("No. of Depreciation Days")
        {
            CaptionML = ENU = 'No. of Depreciation Days', FRA = 'Nbre jours amort.';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("FA No./Budgeted FA No.")
        {
            CaptionML = ENU = 'FA No./Budgeted FA No.', FRA = 'N° immo./N° immo. budgétée';
        }
        modify("FA Subclass Code")
        {
            CaptionML = ENU = 'FA Subclass Code', FRA = 'Code sous-classe immo.';
        }
        modify("FA Location Code")
        {
            CaptionML = ENU = 'FA Location Code', FRA = 'Code emplacement immo.';
        }
        modify("FA Posting Group")
        {
            CaptionML = ENU = 'FA Posting Group', FRA = 'Groupe compta. immo.';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 28)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 29)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 30)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Depreciation Method")
        {
            CaptionML = ENU = 'Depreciation Method', FRA = 'Méthode amortissement';
            //OptionCaptionML = ENU = 'Straight-Line,Declining-Balance 1,Declining-Balance 2,DB1/SL,DB2/SL,User-Defined,Manual', FRA = 'Linéaire,Dégressif 1,Dégressif 2,Dégr. 1/Lin.,Dégr. 2/Lin.,Paramétrable,Manuelle';
        }
        modify("Depreciation Starting Date")
        {
            CaptionML = ENU = 'Depreciation Starting Date', FRA = 'Date début amortissement';
        }
        modify("Straight-Line %")
        {
            CaptionML = ENU = 'Straight-Line %', FRA = '% linéaire';
        }
        modify("No. of Depreciation Years")
        {
            CaptionML = ENU = 'No. of Depreciation Years', FRA = 'Nombre années amortissement';
        }
        modify("Fixed Depr. Amount")
        {
            CaptionML = ENU = 'Fixed Depr. Amount', FRA = 'Montant annuité amortissement';
        }
        modify("Declining-Balance %")
        {
            CaptionML = ENU = 'Declining-Balance %', FRA = '% dégressif';
        }
        modify("Depreciation Table Code")
        {
            CaptionML = ENU = 'Depreciation Table Code', FRA = 'Code table amortissement';
        }
        modify("Journal Batch Name")
        {
            CaptionML = ENU = 'Journal Batch Name', FRA = 'Nom feuille';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Transaction No.")
        {
            CaptionML = ENU = 'Transaction No.', FRA = 'N° transaction';
        }
        modify("Bal. Account Type")
        {
            CaptionML = ENU = 'Bal. Account Type', FRA = 'Type compte contrepartie';
           // OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset', FRA = 'Général,Client,Fournisseur,Banque,Immobilisation';
        }
        modify("Bal. Account No.")
        {

            //Unsupported feature: Change TableRelation on ""Bal. Account No."(Field 45)". Please convert manually.

            CaptionML = ENU = 'Bal. Account No.', FRA = 'N° compte contrepartie';
        }
        modify("VAT Amount")
        {
            CaptionML = ENU = 'VAT Amount', FRA = 'Montant TVA';
        }
        modify("Gen. Posting Type")
        {
            CaptionML = ENU = 'Gen. Posting Type', FRA = 'Type compta. TVA';
           // OptionCaptionML = ENU = ' ,Purchase,Sale,Settlement', FRA = ' ,Achat,Vente,Règlement';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("FA Class Code")
        {
            CaptionML = ENU = 'FA Class Code', FRA = 'Code classe immo.';
        }
        modify("FA Exchange Rate")
        {
            CaptionML = ENU = 'FA Exchange Rate', FRA = 'Taux actualisation immo.';
        }
        modify("Amount (LCY)")
        {
            CaptionML = ENU = 'Amount (LCY)', FRA = 'Montant DS';
        }
        modify("Result on Disposal")
        {
            CaptionML = ENU = 'Result on Disposal', FRA = 'Résultat de cession';
            OptionCaptionML = ENU = ' ,Gain,Loss', FRA = ' ,Gain,Perte';
        }
        modify(Correction)
        {
            CaptionML = ENU = 'Correction', FRA = 'Correction';
        }
        modify("Index Entry")
        {
            CaptionML = ENU = 'Index Entry', FRA = 'Ecriture réévaluation';
        }
        modify("Canceled from FA No.")
        {
            CaptionML = ENU = 'Canceled from FA No.', FRA = 'Annulé par immo. n°';
        }
        modify("Depreciation Ending Date")
        {
            CaptionML = ENU = 'Depreciation Ending Date', FRA = 'Date fin amortissement';
        }
        modify("Use FA Ledger Check")
        {
            CaptionML = ENU = 'Use FA Ledger Check', FRA = 'Utiliser vérif. écriture immo.';
        }
        modify("Automatic Entry")
        {
            CaptionML = ENU = 'Automatic Entry', FRA = 'Ecriture automatique';
        }
        modify("Depr. Starting Date (Custom 1)")
        {
            CaptionML = ENU = 'Depr. Starting Date (Custom 1)', FRA = 'Date début amort. (param. 1)';
        }
        modify("Depr. Ending Date (Custom 1)")
        {
            CaptionML = ENU = 'Depr. Ending Date (Custom 1)', FRA = 'Date fin amort. (param. 1)';
        }
        modify("Accum. Depr. % (Custom 1)")
        {
            CaptionML = ENU = 'Accum. Depr. % (Custom 1)', FRA = '% total amort. (param. 1)';
        }
        modify("Depr. % this year (Custom 1)")
        {
            CaptionML = ENU = 'Depr. % this year (Custom 1)', FRA = '% amort. annuel (param. 1)';
        }
        modify("Property Class (Custom 1)")
        {
            CaptionML = ENU = 'Property Class (Custom 1)', FRA = 'Classe propriété (param. 1)';
            OptionCaptionML = ENU = ' ,Personal Property,Real Property', FRA = ' ,Bien mobilier,Bien immobilier';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Tax Area Code")
        {
            CaptionML = ENU = 'Tax Area Code', FRA = 'Code zone recouvrement';
        }
        modify("Tax Liable")
        {
            CaptionML = ENU = 'Tax Liable', FRA = 'Soumis à recouvrement';
        }
        modify("Tax Group Code")
        {
            CaptionML = ENU = 'Tax Group Code', FRA = 'Code groupe taxes';
        }
        modify("Use Tax")
        {
            CaptionML = ENU = 'Use Tax', FRA = 'Use Tax';
        }
        modify("VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify("VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'VAT Prod. Posting Group', FRA = 'Groupe compta. produit TVA';
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
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        field(10800; "Exclude Derogatory"; Boolean)
        {
            CaptionML = ENU = 'Exclude Derogatory',
                        FRA = 'Exclusion dérogatoire';
            Description = 'HEI.06';
            Editable = false;
        }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
        field(50000; "Purchase Receipt Line No. FND"; Integer)
        {
            Caption = 'Purchase Receipt Line No.';
            Description = 'HEI.01';
        }
        field(50001; "Comment FND"; Text[250])
        {
            Description = 'HEI.02';
            Caption = 'Comment';
        }
        field(50002; "Vendor ID FND"; Code[20])
        {
            Caption = 'Vendor ID';
            Description = 'HEI.05';
        }
        field(50003; "PO Number FND"; Code[20])
        {
            Caption = 'PO Number';
            Description = 'HEI.05';
        }
        field(50004; "Reference Number FND"; Code[20])
        {
            Caption = 'Reference Number';
            Description = 'HEI.05';
        }
        field(50005; "CAPEX Code FND"; Code[20])
        {
            Caption = 'CAPEX Code';
            Description = 'HEI.05';
        }
        // field(2014310;"Service Contract Line No.";Integer)
        // {
        //     CaptionML = ENU='Contract Line No.',
        //                 FRA='N° ligne contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #327';
        // }
        // field(2014313;"Financial Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Financial Contract No.',
        //                 FRA='N° Contrat Financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Financial Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                       "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034850;"DIT Sub-Contract Type";Option)
        // {
        //     CaptionML = ENU='Sub Contract Type',
        //                 FRA='Sous type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #327';
        //     OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA=' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        // }
        // field(2034872;"Contract Group Code";Code[10])
        // {
        //     CaptionML = ENU='Contract Group Code',
        //                 FRA='Code groupe contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #327';
        //     TableRelation = IF ("Contract Type"=CONST(Service),
        //                         "DIT Sub-Contract Type"=FILTER(<>" ")) "Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"))
        //                         else IF ("Contract Type"=CONST(Service),
        //                                  "DIT Sub-Contract Type"=CONST(" ")) "Contract Group".Code
        //                                  else IF ("Contract Type"=CONST(Financial)) "Financial Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034915;"Service Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Service Contract No.',
        //                 FRA='N° contrat de service';
        //     Description = 'DITW16.00.00.41 DIT-715 #327 - DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Service Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                     "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
        // }
        // field(2035393;"Contract Type";Option)
        // {
        //     CaptionML = ENU='Contract Type',
        //                 FRA='Type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #327 - DITW18.00.06 DIT-770 #1368';
        //     OptionCaptionML = ENU=' ,Service,Financial',
        //                       FRA=' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }  BC Upgrade NANDIS03
    }
    keys
    {
        // BC Upgrade NANDIS03 >>
        // key(Key1; "FA No.", "Depreciation Book Code", "Part of Book Value")
        // {
        //     SumIndexFields = Amount;
        // }
        // key(Key2; "FA No.", "FA Posting Date", "Depreciation Book Code", "FA Posting Category", "FA Posting Type", "Part of Book Value")
        // {
        //     SumIndexFields = Amount;
        // }
        // key(Key3; "FA No.", "Depreciation Book Code", "FA Posting Category", "FA Posting Type")
        // {
        //     SumIndexFields = Amount;
        // }
        // key(Key4; "FA No.", "Depreciation Book Code")
        // {
        // }
        key(Key50000; "FA No.", "Depreciation Book Code", "Part of Book Value")
        {
            SumIndexFields = Amount;
        }
        key(Key50001; "FA No.", "FA Posting Date", "Depreciation Book Code", "FA Posting Category", "FA Posting Type", "Part of Book Value")
        {
            SumIndexFields = Amount;
        }
        key(Key50002; "FA No.", "Depreciation Book Code", "FA Posting Category", "FA Posting Type")
        {
            SumIndexFields = Amount;
        }
        key(Key50003; "FA No.", "Depreciation Book Code")
        {
        }
        // BC Upgrade NANDIS03 <<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

