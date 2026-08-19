tableextension 50020 VendorLedgerEntryExtFND extends "Vendor Ledger Entry"
{
    //     HEI.01 PTPGAP066 IBM SOICAD01 29.06.2017 Purchase to Pay– Bank account for payment
    //   # New field Vendor Bank Account, IBAN
    //   # Code for handling Vendor Bank Account
    // HEI.02 PTPGAP029 IBM ISYED01 03.08.2017 Items included in payment proposal
    //   # New field Batch payment name added
    //   # Code for handling Batch payment name
    // HEI.03 PTPGAP041 IBM PATHAA02 20.08.2017
    // #New field '50004'Payment Status'added
    // #New field '50005' "Status Date" added
    // # New Field '50011' "Payment user" added
    // HEI.04 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //   # New fields for MDM integration
    // HEI.05 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Vendor DTax Group Code" field length from 10 to 20 characters
    // HEI.06 PTPGAP067 IBM ISYED01 08/09/2017 Purchase To Pay downPayment
    //   # Added options Prepayment Invoice,Prepayment Credit Memo to Field Document Type
    //   # added new feild prepayment document type
    // HEI.07 Defect#116-BugFix IBM PATHAA02
    // #New field added "Comments"
    // HEI.08 FDD-KDD0TC002 IBM HORTOC01 04.10.2017 - new option on "Document type" field - "Interest Rate Credit"
    // HEI.09 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    //   # New option "RPM Damage or Loss" added on "Document Type" field
    // HEI.10 FDD-PTPGAP041 IBM PATHAA02 26.10.2017
    // HEI.11 FDD-KDD0TC004 IBM NASTAA02 22.12.2017 # OTC - Returnable Packaging Material - RPM
    //   # Added missing options in "Document Type"
    // HEI.12 FDD PTPGAP030 IBM.NAIKH01 16.01.2018
    //   # Added a new field "Duplicate Entry No."
    // HEI.13 PTPGAP085 IBM HORTOC01 20.03.2018
    //   #validate On Hold field,add new fields
    // HEI.14 HT607 IBM NASTAA02 13.08.2019 # Translation of Reports
    //   # Added french captions for "Payment Status" Field
    // HEI.15 CHG2026314 IBM SAXENS01Ethiopia WHT Certificate No and date
    //   Two new fields are created
    //    # WHT Certificate No
    //    # WHT Certificate Date
    // HEI.16 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field created: 50041 - Fixed Asset Acquisition
    //   # Code added on function "CopyFromGenJnlLine"
    // HEI.18 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New keys:
    //     # "Source Code,Posting Date,Document No."
    //     # "Source Code,Document No.,Posting Date"
    //     # "Vendor No.,Posting Date,Source Code"
    //     # "Vendor No.,Document No.,Posting Date"
    //     # "Applies-to ID"
    //     # "Vendor No.,Applies-to ID"
    // HEI.19 FDD-HT2159 - CHG2105031 IBM NASTAA02 04.08.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field created: 50018 - Region Code

    // BC Upgrade SHUKLP03 >> 
    // Added Document subtype field 50090.
    // Added Document subtype code on event OnAfterCopyVendLedgerEntryFromGenJnlLine.
    // BC Upgrade SHUKLP03 <<
    //BC UPGRADE KUMARR78 WHT Fields

    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Vendor No.")
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêt,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss';

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

            //Unsupported feature: Change CalcFormula on "Amount(Field 13)". Please convert manually.

            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Remaining Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Remaining Amount"(Field 14)". Please convert manually.

            CaptionML = ENU = 'Remaining Amount', FRA = 'Montant ouvert';
        }
        modify("Original Amt. (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Original Amt. (LCY)"(Field 15)". Please convert manually.

            CaptionML = ENU = 'Original Amt. (LCY)', FRA = 'Montant initial DS';
        }
        modify("Remaining Amt. (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Remaining Amt. (LCY)"(Field 16)". Please convert manually.

            CaptionML = ENU = 'Remaining Amt. (LCY)', FRA = 'Montant ouvert DS';
        }
        modify("Amount (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Amount (LCY)"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Amount (LCY)', FRA = 'Montant DS';
        }
        modify("Purchase (LCY)")
        {
            CaptionML = ENU = 'Purchase (LCY)', FRA = 'Achats DS';
        }
        modify("Inv. Discount (LCY)")
        {
            CaptionML = ENU = 'Inv. Discount (LCY)', FRA = 'Remises facture DS';
        }
        modify("Buy-from Vendor No.")
        {
            CaptionML = ENU = 'Buy-from Vendor No.', FRA = 'Numéro fournisseur';
        }
        modify("Vendor Posting Group")
        {
            CaptionML = ENU = 'Vendor Posting Group', FRA = 'Groupe compta. fournisseur';

            //Unsupported feature: Change Editable on ""Vendor Posting Group"(Field 22)". Please convert manually.

        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 23)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 24)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Purchaser Code")
        {

            //Unsupported feature: Change TableRelation on ""Purchaser Code"(Field 25)". Please convert manually.

            CaptionML = ENU = 'Purchaser Code', FRA = 'Code acheteur';
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
            // OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêt';

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
        modify("Pmt. Disc. Rcd.(LCY)")
        {
            CaptionML = ENU = 'Pmt. Disc. Rcd.(LCY)', FRA = 'Escompte obtenu DS';
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

            //Unsupported feature: Change TableRelation on ""Bal. Account No."(Field 52)". Please convert manually.

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

            //Unsupported feature: Change CalcFormula on ""Debit Amount"(Field 58)". Please convert manually.

            CaptionML = ENU = 'Debit Amount', FRA = 'Montant débit';
        }
        modify("Credit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Credit Amount"(Field 59)". Please convert manually.

            CaptionML = ENU = 'Credit Amount', FRA = 'Montant crédit';
        }
        modify("Debit Amount (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Debit Amount (LCY)"(Field 60)". Please convert manually.

            CaptionML = ENU = 'Debit Amount (LCY)', FRA = 'Montant débit DS';
        }
        modify("Credit Amount (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Credit Amount (LCY)"(Field 61)". Please convert manually.

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

            //Unsupported feature: Change CalcFormula on ""Original Amount"(Field 75)". Please convert manually.

            CaptionML = ENU = 'Original Amount', FRA = 'Montant initial';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
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
        modify("IC Partner Code")
        {
            CaptionML = ENU = 'IC Partner Code', FRA = 'Code du partenaire IC';
        }
        modify("Applying Entry")
        {
            CaptionML = ENU = 'Applying Entry', FRA = 'Lettrage de l''écriture';
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
        modify(Prepayment)
        {
            CaptionML = ENU = 'Prepayment', FRA = 'Acompte';
        }
        modify("Creditor No.")
        {
            CaptionML = ENU = 'Creditor No.', FRA = 'N° créditeur';
        }
        modify("Payment Reference")
        {
            CaptionML = ENU = 'Payment Reference', FRA = 'Référence paiement';
        }
        modify("Payment Method Code")
        {
            CaptionML = ENU = 'Payment Method Code', FRA = 'Code mode de règlement';
        }
        modify("Applies-to Ext. Doc. No.")
        {
            CaptionML = ENU = 'Applies-to Ext. Doc. No.', FRA = 'N° ligne doc. ext. lettrage';
        }
        modify("Recipient Bank Account")
        {

            //Unsupported feature: Change TableRelation on ""Recipient Bank Account"(Field 288)". Please convert manually.

            CaptionML = ENU = 'Recipient Bank Account', FRA = 'Cpte bancaire destinataire';
        }
        modify("Message to Recipient")
        {
            CaptionML = ENU = 'Message to Recipient', FRA = 'Message au destinataire';
        }
        modify("Exported to Payment File")
        {
            CaptionML = ENU = 'Exported to Payment File', FRA = 'Exporté dans fichier paiement';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }

        //Unsupported feature: CodeModification on ""Due Date"(Field 37).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Open,TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Open,true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Pmt. Discount Date"(Field 38).OnValidate". Please convert manually.

        //trigger  Discount Date"(Field 38)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Open,TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Open,true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-to ID"(Field 47).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Open,TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Open,true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Remaining Pmt. Disc. Possible"(Field 77).OnValidate". Please convert manually.

        //trigger  Disc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Open,TRUE);
        CALCFIELDS(Amount,"Original Amount");

        IF "Remaining Pmt. Disc. Possible" * Amount < 0 THEN
          FIELDERROR("Remaining Pmt. Disc. Possible",STRSUBSTNO(MustHaveSameSignErr,FIELDCAPTION(Amount)));

        IF ABS("Remaining Pmt. Disc. Possible") > ABS("Original Amount") THEN
          FIELDERROR("Remaining Pmt. Disc. Possible",STRSUBSTNO(MustNotBeLargerErr,FIELDCAPTION("Original Amount")));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Open,true);
        CALCFIELDS(Amount,"Original Amount");

        if "Remaining Pmt. Disc. Possible" * Amount < 0 then
          FIELDERROR("Remaining Pmt. Disc. Possible",STRSUBSTNO(MustHaveSameSignErr,FIELDCAPTION(Amount)));

        if ABS("Remaining Pmt. Disc. Possible") > ABS("Original Amount") then
          FIELDERROR("Remaining Pmt. Disc. Possible",STRSUBSTNO(MustNotBeLargerErr,FIELDCAPTION("Original Amount")));
        */
        //end;


        //Unsupported feature: CodeModification on ""Pmt. Disc. Tolerance Date"(Field 78).OnValidate". Please convert manually.

        //trigger  Disc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Open,TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Open,true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Max. Payment Tolerance"(Field 79).OnValidate". Please convert manually.

        //trigger  Payment Tolerance"(Field 79)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Open,TRUE);
        CALCFIELDS(Amount,"Remaining Amount");

        IF "Max. Payment Tolerance" * Amount < 0 THEN
          FIELDERROR("Max. Payment Tolerance",STRSUBSTNO(MustHaveSameSignErr,FIELDCAPTION(Amount)));

        IF ABS("Max. Payment Tolerance") > ABS("Remaining Amount") THEN
          FIELDERROR("Max. Payment Tolerance",STRSUBSTNO(MustNotBeLargerErr,FIELDCAPTION("Remaining Amount")));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Open,true);
        CALCFIELDS(Amount,"Remaining Amount");

        if "Max. Payment Tolerance" * Amount < 0 then
          FIELDERROR("Max. Payment Tolerance",STRSUBSTNO(MustHaveSameSignErr,FIELDCAPTION(Amount)));

        if ABS("Max. Payment Tolerance") > ABS("Remaining Amount") then
          FIELDERROR("Max. Payment Tolerance",STRSUBSTNO(MustNotBeLargerErr,FIELDCAPTION("Remaining Amount")));
        */
        //end;


        //Unsupported feature: CodeModification on ""Amount to Apply"(Field 84).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Open,TRUE);
        CALCFIELDS("Remaining Amount");

        IF "Amount to Apply" * "Remaining Amount" < 0 THEN
          FIELDERROR("Amount to Apply",STRSUBSTNO(MustHaveSameSignErr,FIELDCAPTION("Remaining Amount")));

        IF ABS("Amount to Apply") > ABS("Remaining Amount") THEN
          FIELDERROR("Amount to Apply",STRSUBSTNO(MustNotBeLargerErr,FIELDCAPTION("Remaining Amount")));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Open,true);
        CALCFIELDS("Remaining Amount");

        if "Amount to Apply" * "Remaining Amount" < 0 then
          FIELDERROR("Amount to Apply",STRSUBSTNO(MustHaveSameSignErr,FIELDCAPTION("Remaining Amount")));

        if ABS("Amount to Apply") > ABS("Remaining Amount") then
          FIELDERROR("Amount to Apply",STRSUBSTNO(MustNotBeLargerErr,FIELDCAPTION("Remaining Amount")));
        */
        //end;


        //Unsupported feature: CodeModification on ""Creditor No."(Field 170).OnValidate". Please convert manually.

        //trigger "(Field 170)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Creditor No." <> '') AND ("Recipient Bank Account" <> '') THEN
          FIELDERROR("Recipient Bank Account",
            STRSUBSTNO(FieldIsNotEmptyErr,FIELDCAPTION("Creditor No."),FIELDCAPTION("Recipient Bank Account")));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Creditor No." <> '') and ("Recipient Bank Account" <> '') then
          FIELDERROR("Recipient Bank Account",
            STRSUBSTNO(FieldIsNotEmptyErr,FIELDCAPTION("Creditor No."),FIELDCAPTION("Recipient Bank Account")));
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Reference"(Field 171).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Payment Reference" <> '' THEN
          TESTFIELD("Creditor No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Payment Reference" <> '' then
          TESTFIELD("Creditor No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Method Code"(Field 172).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Open,TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Open,true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Recipient Bank Account"(Field 288).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Recipient Bank Account" <> '') AND ("Creditor No." <> '') THEN
          FIELDERROR("Creditor No.",
            STRSUBSTNO(FieldIsNotEmptyErr,FIELDCAPTION("Recipient Bank Account"),FIELDCAPTION("Creditor No.")));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Recipient Bank Account" <> '') and ("Creditor No." <> '') then
          FIELDERROR("Creditor No.",
            STRSUBSTNO(FieldIsNotEmptyErr,FIELDCAPTION("Recipient Bank Account"),FIELDCAPTION("Creditor No.")));
        */
        //end;


        //Unsupported feature: CodeModification on ""Message to Recipient"(Field 289).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Open,TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Open,true);
        */
        //end;
        field(50000; "Last Adjsted Curncy Factor FND"; Decimal)
        {
            Description = 'HEI.01';
            Caption = 'Last Adjusted Currency Factor';
        }
        field(50001; "IBAN FND"; Code[50])
        {
            CalcFormula = Lookup("Vendor Bank Account".IBAN where("Vendor No." = FIELD("Vendor No."),
                                                                   Code = FIELD("Vendor Bank Account FND")));
            Description = 'HEI.01 PTPGAP066';
            Editable = true;
            FieldClass = FlowField;
            Caption = 'IBAN';
        }
        field(50002; "Vendor Bank Account FND"; Code[10])
        {
            Description = 'HEI.01 PTPGAP066';
            Editable = true;
            Caption = 'Vendor Bank Account';
            TableRelation = "Vendor Bank Account".Code where("Vendor No." = FIELD("Vendor No."));
        }
        field(50003; "Batch payment name FND"; Code[30])
        {
            Description = 'HEI.02';
            Caption = 'Batch payment name';
        }
        field(50004; "Payment Status FND"; Option)
        {
            CaptionML = ENU = 'Payment Status',
                        FRA = 'Statut de Paiement';
            Description = 'HEI.03 PTPGAP041,HEI.14';
            OptionCaptionML = ENU = 'Pending Review,Payment Approved,Payment Rejected',
                              FRA = 'En attente,Paiement approuvé,Paiement rejeté';
            OptionMembers = "Pending Review","Payment Approved","Payment Rejected";
        }
        field(50005; "Status Date FND"; Date)
        {
            Description = 'HEI.03 PTPGAP041';
            Caption = 'Status Date';
            Editable = false;
        }
        field(50006; "Rem. Amt for WHT FND"; Decimal)
        {
            Caption = 'Rem. Amt for WHT';
        }
        field(50007; "Rem. Amt FND"; Decimal)
        {
            Caption = 'Rem. Amt';
        }
        field(50008; "WHT Amount FND"; Decimal)
        {
            CalcFormula = Sum("WHT Entry FND".Amount where("Bill-to/Pay-to No." = FIELD("Vendor No."),
                                                        "Original Document No." = FIELD("Document No.")));
            Caption = 'WHT Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50009; "WHT Amount (LCY) FND"; Decimal)
        {
            CalcFormula = Sum("WHT Entry FND"."Amount (LCY)" where("Bill-to/Pay-to No." = FIELD("Vendor No."),
                                                                "Original Document No." = FIELD("Document No.")));
            Caption = 'WHT Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Comments FND"; Text[250])
        {
            Description = 'HEI.07';
            Caption = 'Comments';
        }
        field(50011; "Payment User FND"; Code[50])
        {
            Description = 'HEI.03 PTPGAP041';
            Caption = 'Payment User';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(50012; "Duplicate Entry No. FND"; Text[30])
        {
            Description = 'HEI.12 PTPGAP030';
            Caption = 'Duplicate Entry No.';
        }
        field(50013; "On Hold UserID FND"; Code[50])
        {
            Caption = 'On Hold UserID';
            Description = 'HEI.13';
        }
        field(50014; "On Hold Date FND"; Date)
        {
            Caption = 'On Hold Date';
            Description = 'HEI.13';
        }
        field(50015; "WHT Certificate No FND"; Text[20])
        {
            Description = 'HEI.15';
            Caption = 'WHT Certificate No.';
        }
        field(50016; "WHT Certificate Date FND"; Date)
        {
            Description = 'HEI.15';
            Caption = 'WHT Certificate Date';
        }
        field(50017; "Fixed Asset Acquisition FND"; Boolean)
        {
            Description = 'HEI.16';
            Caption = 'Fixed Asset Acquisition';
        }
        field(50018; "Region Code FND"; Code[20])
        {
            Caption = 'Region Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.19';
            TableRelation = Location;
        }
        //BC Upgrade SHARMP16 begin drink it fields
        // field(2013610;"Vendor DDeposit Group Code";Code[10])
        // {
        //     CaptionML = ENU='Vendor Deposit Group Code',
        //                 FRA='Code groupe consigne fournisseur';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code WHERE ("Source Type"=CONST(Vendor));
        // }
        // field(2013667;"Vendor DTax Group Code";Code[20])
        // {
        //     CaptionML = ENU='Vendor Tax Group Code',
        //                 FRA='Code groupe taxe fournisseur';
        //     Description = 'DITW15.00.00.01,HEI.05';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Vendor));
        // }
        // field(2013695;"Item Charge Type";Option)
        // {
        //     CaptionML = ENU='Item Charge Type',
        //                 FRA='Type frais annexes';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     OptionCaptionML = ENU=' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA=' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        // }
        // field(2013726;"Vendor Tax Registration No.";Text[20])
        // {
        //     CaptionML = ENU='Vendor Tax Registration No.',
        //                 FRA='N° ident. accise fournisseur';
        //     Description = 'DITW15.00.00.38 #1221';
        // }
        // field(2014077;"Truck Code";Code[10])
        // {
        //     CaptionML = ENU='Truck Code',
        //                 FRA='Code camion';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Whse. Shipping Truck";
        // }
        // field(2014078;"Driver Code";Code[10])
        // {
        //     CaptionML = ENU='Driver Code',
        //                 FRA='Code chauffeur';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Whse. Shipping Driver";
        // }
        // field(2014109;"Route Planning No.";Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'NRQ17902';
        //     TableRelation = "Route Planning Worksheet";
        // }
        // field(2014271;"Vendor Tax Warehouse Ref.";Text[20])
        // {
        //     CaptionML = ENU='Vendor Tax Warehouse Reference',
        //                 FRA='Entrepôt fiscal de référence fournisseur';
        //     Description = 'DITW15.00.00.38 #1221';
        // }
        // field(2014310;"Service Contract Line No.";Integer)
        // {
        //     CaptionML = ENU='Contract Line No.',
        //                 FRA='N° ligne contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392 #327';
        // }
        // field(2014313;"Financial Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Financial Contract No.',
        //                 FRA='N° contrat financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Financial Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                       "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
        // }
        field(50090; "Document Subtype Code FND"; Code[10])
        {
            Caption = 'Document Subtype Code';
            Description = 'DITW110.00.11 NRQ#17902';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Purchase));
        }
        //BC UPGRADE KUMARR78 WHT Fields -->>
        field(50091; "WHT Business Posting Grp FND"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50092; "WHT Product Posting Grp FND"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        //BC UPGRADE KUMARR78 WHT Fields --<<
        // field(2014470;Comment;Boolean)
        // {
        //     CalcFormula = Exist("Comment Line" WHERE ("Table Name"=CONST("Vendor Ledger Entry")));
        //     CaptionML = ENU='Comment',
        //                 FRA='Commentaire';
        //     Description = 'DITW17.00.02 DIT-770 #144/#150';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2029610;OGM;Text[30])
        // {
        //     CaptionML = ENU='OGM',
        //                 FRA='VCS';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2034840;"Building No.";Code[20])
        // {
        //     CaptionML = ENU='Building No.',
        //                 FRA='N° immeuble';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = Building;
        // }
        // field(2034850;"DIT Sub-Contract Type";Option)
        // {
        //     CaptionML = ENU='Sub Contract Type',
        //                 FRA='Sous type contrat';
        //     Description = 'DITW15.00.00.37- DIT-715 #297';
        //     OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA=' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        // }
        // field(2034872;"Contract Group Code";Code[10])
        // {
        //     CaptionML = ENU='Contract Group Code',
        //                 FRA='Code groupe contrat';
        //     Description = 'DITW15.00.00.35-.37 - DIT-715 #392 #327';
        //     TableRelation = IF ("DIT Sub-Contract Type"=FILTER(<>" ")) "Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"))
        //                     else IF ("DIT Sub-Contract Type"=CONST(" ")) "Contract Group";
        // }
        // field(2034915;"Service Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Service Contract No.',
        //                 FRA='N° contrat de service';
        //     Description = 'DITW16.00.00.41 DIT-715 #392 #327 - DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Service Purch. Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                            "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
        // }
        // field(2035393;"Contract Type";Option)
        // {
        //     CaptionML = ENU='Contract Type',
        //                 FRA='Type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392 #327 - DITW18.00.06 DIT-770 #1368';
        //     OptionCaptionML = ENU=' ,Service,Financial',
        //                       FRA=' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }
        //BC Upgrade SHARMP16 end drink it fields
    }
    keys
    {

        //Unsupported feature: Deletion on ""Vendor No.","Posting Date","Currency Code"(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""Document Type","Vendor No.","Posting Date","Currency Code"(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""Vendor No.","Global Dimension 1 Code","Global Dimension 2 Code","Posting Date","Currency Code"(Key)". Please convert manually.

        ////BC Upgrade SHARMP16 begin drink it keys<<
        // key(Key26; "Vendor No.", "Posting Date", "Currency Code", "Item Charge Type", "DIT Sub-Contract Type", "Service Contract No.")
        // {
        //     SumIndexFields = "Purchase (LCY)", "Inv. Discount (LCY)";
        // }
        // key(Key27; "Document Type", "Vendor No.", "Posting Date", "Currency Code", "Item Charge Type", "DIT Sub-Contract Type", "Service Contract No.")
        // {
        //     MaintainSIFTIndex = false;
        //     MaintainSQLIndex = false;
        //     SumIndexFields = "Purchase (LCY)", "Inv. Discount (LCY)";
        // }
        //key(Key28; "Vendor No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date", "Currency Code", "Item Charge Type", "DIT Sub-Contract Type", "Service Contract No.", "Vendor Posting Group")
        // {
        //     SumIndexFields = "Purchase (LCY)", "Inv. Discount (LCY)";
        // }
        // key(Key29; "Vendor No.", "Contract Type", "DIT Sub-Contract Type", "Service Contract No.", "Posting Date", "Currency Code", "Contract Group Code", "Item Charge Type")
        // {
        //     SumIndexFields = "Purchase (LCY)", "Inv. Discount (LCY)";
        // }
        //BC Upgrade SHARMP16 end drink it keys<<

        //BC Upgrade SHARMP16 UPDATE KEYnO'S because the perviously used during conversion of object already exsists.>>
        key(key30; "Document No.", "Document Type")
        {
        }
        key(key31; "Source Code", "Posting Date", "Document No.")
        {
        }
        key(Key32; "Source Code", "Document No.", "Posting Date")
        {
        }
        key(Key33; "Vendor No.", "Posting Date", "Source Code")
        {
        }
        key(Key34; "Vendor No.", "Document No.", "Posting Date")
        {
        }
        key(Key35; "Applies-to ID")
        {
        }
        key(Key36; "Vendor No.", "Applies-to ID")
        {
        }
        //BC Upgrade SHARMP16 UPDATE KEYnO'S because the perviously used during conversion of object already exsists.<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
    //        FinancialUtils: Codeunit "Financial-Utils";//BC upgrade - Cu needs to be handled differently.


    //Unsupported feature: PropertyModification on "FieldIsNotEmptyErr(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //FieldIsNotEmptyErr : @@@="%1=Field;%2=Field";ENU=%1 cannot be used while %2 has a value.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //FieldIsNotEmptyErr : @@@="%1=Field;%2=Field";ENU=%1 cannot be used while %2 has a value.;FRA=%1 ne peut pas être utilisé si %2 comporte une valeur.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "MustHaveSameSignErr(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //MustHaveSameSignErr : ENU=must have the same sign as %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //MustHaveSameSignErr : ENU=must have the same sign as %1;FRA=doit avoir le même signe que %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "MustNotBeLargerErr(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //MustNotBeLargerErr : ENU=must not be larger than %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //MustNotBeLargerErr : ENU=must not be larger than %1;FRA=ne doit pas être supérieur(e) à %1;
    //Variable type has not been exported.

    var
        CheckConstant: Label 'INCLUDED IN PAYMENT PROPOSAL';
}

