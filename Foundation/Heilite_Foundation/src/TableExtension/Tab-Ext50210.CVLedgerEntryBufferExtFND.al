tableextension 50210 CVLedgerEntryBufferExtFND extends "CV Ledger Entry Buffer"
{
    // version NAVW110.0,DITW110.00.09,HEI.03
    //   FINXL9.00.001 DAT 25/02/2016 : Extend field Description from 50 -> 80 chars
    //   DITW17.00.02 SR 10/09/2013 DIT-770 #137 
    // : Add options 'Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back' to "Document Type"
    // : Add options 'Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back' to "Applies-to Doc. Type"
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    //   HEI.01 FDD-KDD0TC002 IBM HORTOC01 04.10.2017 - new option on "Document type" field - "Interest Rate Credit"
    //   HEI.02 FDD-HT1346 BULIMC01 IBM 27.05.2020 - new field added: 50000-"Fixed Asset Acquisition"
    //   HEI.03 CHG2117381 HB2376 IBM BHANDS01 25.11.2022 # Payment Tolerance Application Panama
    //     # add "Original amount" in RecalculateAmounts()
    //     # new function RecalculateAmountsHNK()

    // BC Upgrade KUMARS145 Table Extension 
    // BC Upgrade KUMARS145 alternative for HEI.02 for table 382 "CV Ledger Entry Buffer" OnAfterCopyFromVendLedgerEntry 
    // BC Upgrade KUMARS145 Procedure RecalculateAmountsHNK moved from Nav
    // BC Upgrade KUMARS145 alternative for HEI.03 for table 382 "CV Ledger Entry Buffer" OnAfterRecalculateAmounts>>

    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("CV No.")
        {
            CaptionML = ENU = 'CV No.', FRA = 'N° CF';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            // OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêt,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment';
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
        modify("Original Amt. (LCY)")
        {
            CaptionML = ENU = 'Original Amt. (LCY)', FRA = 'Montant initial DS';
        }
        modify("Remaining Amt. (LCY)")
        {
            CaptionML = ENU = 'Remaining Amt. (LCY)', FRA = 'Montant ouvert DS';
        }
        modify("Amount (LCY)")
        {
            CaptionML = ENU = 'Amount (LCY)', FRA = 'Montant DS';
        }
        modify("Sales/Purchase (LCY)")
        {
            CaptionML = ENU = 'Sales/Purchase (LCY)', FRA = 'Ventes/Achats DS';
        }
        modify("Profit (LCY)")
        {
            CaptionML = ENU = 'Profit (LCY)', FRA = 'Marge DS';
        }
        modify("Inv. Discount (LCY)")
        {
            CaptionML = ENU = 'Inv. Discount (LCY)', FRA = 'Remises facture DS';
        }
        modify("Bill-to/Pay-to CV No.")
        {
            CaptionML = ENU = 'Bill-to/Pay-to CV No.', FRA = 'N° CF donneur/preneur d''ordre';
        }
        modify("CV Posting Group")
        {
            CaptionML = ENU = 'CV Posting Group', FRA = 'Groupe compta. CF';
        }
        modify("Global Dimension 1 Code")
        {
            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {
            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Salesperson Code")
        {
            CaptionML = ENU = 'Salesperson Code', FRA = 'Code vendeur';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("On Hold")
        {
            CaptionML = ENU = 'On Hold', FRA = 'En attente';
        }
        modify("Applies-to Doc. Type")
        {
            CaptionML = ENU = 'Applies-to Doc. Type', FRA = 'Type doc. lettrage';
            // OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement';
            //Unsupported feature: Change OptionString on ""Applies-to Doc. Type"(Field 34)". Please convert manually.
        }
        modify("Applies-to Doc. No.")
        {
            CaptionML = ENU = 'Applies-to Doc. No.', FRA = 'N° doc. lettrage';
        }
        modify(Open)
        {
            CaptionML = ENU = 'Open', FRA = 'Ouvert';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Date d''échéance';
        }
        modify("Pmt. Discount Date")
        {
            CaptionML = ENU = 'Pmt. Discount Date', FRA = 'Date d''escompte';
        }
        modify("Original Pmt. Disc. Possible")
        {
            CaptionML = ENU = 'Original Pmt. Disc. Possible', FRA = 'Escompte initial possible';
        }
        modify("Pmt. Disc. Given (LCY)")
        {
            CaptionML = ENU = 'Pmt. Disc. Given (LCY)', FRA = 'Escompte accordé DS';
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
        modify("Closed by Amount")
        {
            CaptionML = ENU = 'Closed by Amount', FRA = 'Montant lettrage final';
        }
        modify("Applies-to ID")
        {
            CaptionML = ENU = 'Applies-to ID', FRA = 'ID lettrage';
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
            // OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset', FRA = 'Général,Client,Fournisseur,Banque,Immobilisation';
        }
        modify("Bal. Account No.")
        {
            CaptionML = ENU = 'Bal. Account No.', FRA = 'N° compte contrepartie';
        }
        modify("Transaction No.")
        {
            CaptionML = ENU = 'Transaction No.', FRA = 'N° transaction';
        }
        modify("Closed by Amount (LCY)")
        {
            CaptionML = ENU = 'Closed by Amount (LCY)', FRA = 'Montant lettr. final DS';
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
        modify("Calculate Interest")
        {
            CaptionML = ENU = 'Calculate Interest', FRA = 'Calculer intérêts';
        }
        modify("Closing Interest Calculated")
        {
            CaptionML = ENU = 'Closing Interest Calculated', FRA = 'Intérêts clôture calculés';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Closed by Currency Code")
        {
            CaptionML = ENU = 'Closed by Currency Code', FRA = 'Code devise lettrage final';
        }
        modify("Closed by Currency Amount")
        {
            CaptionML = ENU = 'Closed by Currency Amount', FRA = 'Montant devise lettrage final';
        }
        modify("Rounding Currency")
        {
            CaptionML = ENU = 'Rounding Currency', FRA = 'Devise arrondi';
        }
        modify("Rounding Amount")
        {
            CaptionML = ENU = 'Rounding Amount', FRA = 'Montant arrondi';
        }
        modify("Rounding Amount (LCY)")
        {
            CaptionML = ENU = 'Rounding Amount (LCY)', FRA = 'Montant DS arrondi';
        }
        modify("Adjusted Currency Factor")
        {
            CaptionML = ENU = 'Adjusted Currency Factor', FRA = 'Facteur devise ajusté';
        }
        modify("Original Currency Factor")
        {
            CaptionML = ENU = 'Original Currency Factor', FRA = 'Facteur devise initial';
        }
        modify("Original Amount")
        {
            CaptionML = ENU = 'Original Amount', FRA = 'Montant initial';
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            CaptionML = ENU = 'Remaining Pmt. Disc. Possible', FRA = 'Escompte ouvert possible';
        }
        modify("Pmt. Disc. Tolerance Date")
        {
            CaptionML = ENU = 'Pmt. Disc. Tolerance Date', FRA = 'Date écart d''escompte';
        }
        modify("Max. Payment Tolerance")
        {
            CaptionML = ENU = 'Max. Payment Tolerance', FRA = 'Ecart de règlement max.';
        }
        modify("Accepted Payment Tolerance")
        {
            CaptionML = ENU = 'Accepted Payment Tolerance', FRA = 'Ecart de règlement autorisé';
        }
        modify("Accepted Pmt. Disc. Tolerance")
        {
            CaptionML = ENU = 'Accepted Pmt. Disc. Tolerance', FRA = 'Ecart d''escompte autorisé';
        }
        modify("Pmt. Tolerance (LCY)")
        {
            CaptionML = ENU = 'Pmt. Tolerance (LCY)', FRA = 'Écart de règlement DS';
        }
        modify("Amount to Apply")
        {
            CaptionML = ENU = 'Amount to Apply', FRA = 'Montant à lettrer';
        }
        modify(Prepayment)
        {
            CaptionML = ENU = 'Prepayment', FRA = 'Acompte';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        field(50000; "Fixed Asset Acquisition FND"; Boolean)
        {
            CaptionML = ENU = 'Fixed Asset Acquisition', FRA = 'Acquisition d’actifs immobilisés';
        }

    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.

    procedure RecalculateAmountsHNK(FromCurrencyCode: Code[10]; ToCurrencyCode: Code[10]; PostingDate: Date)
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        // HEI.03 >>
        if ToCurrencyCode = FromCurrencyCode then
            exit;
        "Max. Payment Tolerance" := CurrExchRate.ExchangeAmount("Max. Payment Tolerance", FromCurrencyCode, ToCurrencyCode, PostingDate);
        "Accepted Payment Tolerance" := CurrExchRate.ExchangeAmount("Accepted Payment Tolerance", FromCurrencyCode, ToCurrencyCode, PostingDate);
        // HEI.03 <<
    end;
}