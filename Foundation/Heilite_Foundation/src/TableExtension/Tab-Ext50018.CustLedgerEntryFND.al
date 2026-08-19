tableextension 50018 CustLedgerExtryExtFND extends "Cust. Ledger Entry"
{
    // version NAVW110.0,FINXL7.00.001,DITW110.00.11,HEI.04
    // DITW15.00.00.01 DDR 27/12/2007 Added fields
    //                                  2034647 Drink Tax Group Code
    // DITW15.00.00.01 DDR 02/01/2008 rename field
    //                                  2034647 Customer DTax Group Code + Filter to the source table
    // DITW15.00.00.01 DDR 03/01/2008 added fields
    //                                  2013630 Item DDeposit Group Code
    // DITW15.00.00.01 DDR 22/01/2008 Added Drink-It Discount & Promotions Item Charges functionnalities
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.20 DDR 11/06/2008 Certification rules
    // DITW15.00.00.25 DDR 16/10/2008 Added fields
    //                                  2014077 Truck Code
    //                                  2014078 Driver Code
    // DITW15.00.00.35 DDR 21/04/2009 Added fields
    //                                  2034872 Contract Group Code
    // DITW15.00.00.37 DDR 28/01/2010 issue 879 Added fields
    //                                  2034840 Building No.
    //                     10/05/2010 issue 857 Added fields
    //                                  2034850 DIT Sub-Contract Type
    //                                  Changed property 'tablerelation' field2034872 Contract group code
    //                     20/05/2010 issue 929 Modified option caption field2034850 DIT Sub-Contract Type
    // DITW15.00.00.38 DDR 10/12/2010 issue 1221 Added fields
    //                                  2013726 Customer Tax Registration No.
    //                                  2014271 Customer Tax Warehouse Ref.
    // DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 Plant Maintenance Functionnality
    //                                             Added 'PlantMaintenance' option field2034850 "DIT Sub-Contract Type"
    //                 AHU 24/07/2012 DIT-715 #327 #392
    //                                Modified 'TableRelation' property field2034872 Contract Group Code
    //                                Added fields
    //                                  2034915 Service Contract No.
    //                                  2014310 Service Contract Line No.
    //                                  2014311 Service Contract Type
    //                 AHU 13/08/2012 DIT-715 #327 Renamed Captions fields2034915,2034310,2014311
    //                 AHU 16/08/2012 DIT-715 #327 Added key
    //                                               "Customer No.,Service Contract Type,DIT Sub-Contract Type,Service Contract No.,
    //                                               Posting Date,Currency Code,Contract Group Code,Building No."
    //                 AHU 06/11/2012 DIT-715 #393 Added functions DrillDownOnNetChangeEntries()
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields
    //                                               2013695 Item Charge Type
    //                                             Modified all keys to calculate flowfields
    //                                               ",Item Charge Type,DIT Sub-Contract Type,Service Contract No."
    // DITW16.00.00.43 DDR 14/08/2013 DIT-715 #678 Added fields
    //                                               2013611 Deposit Amount
    //                                               2013612 Deposit Amount (LCY)

    // FINXL7.00.001 RBE 20/03/2013 : Created key "Document No.,Document Type"
    //                                Created new field 2029610 OGM + key "OGM"
    // FINXL9.00.001 DAT 25/02/2016 : Extend field Description from 50 -> 80 chars

    // DITW17.00.02 DDR 19/08/2013 DIT-715 #678 merge
    // DITW17.00.02 SR 10/09/2013 DIT-770 #137 : Add options 'Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back' to "Document Type"
    //                                         : Add options 'Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back' to "Applies-to Doc. Type"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 AT  05/02/2014 DIT-770 #340 : Customer Posting Group Made Non Editable
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.05 WSA 04/08/14 DIT-770 #761 : Added field "Invoice List Document No."
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                           Added field 2014319  "Financial Contract No."
    //                                           Rename Caption Contract No. by Service contract No.
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Added blank Option to Contract Type
    // DITW18.00.06 MVN 13/10/2015 DIT-770 #1653 Added "Customer Posting Group" to Key 13: used for Flowfields in Table 18
    // DITW18.00.07 WSA 30/03/2016 DIT-770 #1723 Added code to update invoice list amounts

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.11 MSF 25/08/2017 NRQ#17902 Route settlement - Order Payments, Suggest customer and vendor payments
    //                                        2014109 Route Planning No.
    //                                        2014421 Document Subtype Code
    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP029 IBM ISYED01 28/06/2017
    //   # Added new feild Dispute Case
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //   # New fields:
    //     - 50002 Rem. Amt for WHT
    //     - 50003 Rem. Amt
    //     - 50004 WHT Amount
    //     - 50005 WHT Amount (LCY)
    // HEI.03 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Customer DTax Group Code" field length from 10 to 20 characters
    // HEI.04 Defect#116-BugFix IBM PATHAA02
    // #New field added "Comment"
    // HEI.05 FDD-KDD0TC002 IBM HORTOC01 04.10.2017 - new option on "Document type" field - "Interest Rate Credit"
    // HEI.06 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    //   # New option "RPM Damage or Loss" added on "Document Type" field
    //   # Added code on "ShowDoc" function when Document Type is "RPM Damage or Loss"

    // HEI.07 FDD-KDDOTC007 IBM.NAIKH01 RPM Full-For-Empty Customer.
    //   # New option "FFE Security Payment" added on "Document Type" field
    // HEI.08 FDD-ET-HT695 IBM NASTAA02 05.07.2019 # RPM Payment Reconciliation and Offset
    //   # New Fields created: 50008 - Empties Item No.
    //                         50009 - Deposit Quantity
    //   # Code added on function 'CopyFromGenJnlLine' to transfer value of the new Fields
    // HEI.09  FDD-SR_HT543a IBM HORTOC01 10.07.2019 # new flowfield "Customer Account Group"
    // HEI.10 FDD-HT704 IBM BULIMC01 29.07.2019 #new flowfield "Cashier ID"
    // HEI.11 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New keys:
    //     # "Source Code,Posting Date,Document No."
    //     # "Source Code,Document No.,Posting Date"
    //     # "Customer No.,Posting Date,Source Code"
    //     # "Customer No.,Document No.,Posting Date"
    //     # "Applies-to ID"
    // HEI.13 CHG2065153 IBM KUMARN15 23.06.2020
    //   # Added field "Source System Identifier" and code changed in function CopyFromGenJnlLine
    // HEI.14 CHG2066590 IBM KUMARN15 01.06.2020
    //   # Added key Document Type,Item Charge Type,Customer No. and include Deposit Quantity in SumIndexField
    // HEI.15 FDD-CD-HT1350 IBM BULIMC01 13.07.2020
    //   #new field added: 50061 - "Related Sales Order No."
    //   #new code added to "CopyFromGenJnlLine" function
    // DITW114.00.15 NLAB 11/02/2021 NRQ#172616 changed filter on remaining amount
    // HEI.16 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Field created: 50062 - Location Code

    // BC Upgrade SHUKLP03 >>
    // HEI.11 => Not added because that is for French localization.
    // HEI.14 => Not added because dependecy on DIT field "Item Charge Type".
    // HEI.06 => to add ShowDoc function code for RPM Damage or Loss, subscribed event OnAfterShowDoc in codeunit "Heineken Table Cu".
    // HEI.15,HEI.13,HEI.08 => to add CopyFromGenJnlLine function code, subscribed event OnAfterCopyCustLedgerEntryFromGenJnlLine in codeunit "Heineken Table Cu".
    // BC Upgrade SHUKLP03 <<

    // BC Upgrade SHUKLP03 >> Document Subtype Code related code added.
    // field(50063; "Document Subtype Code"; Code[10])
    // Subscribed event OnAfterCopyCustLedgerEntryFromGenJnlLine in codeunit HeinekenTableCu.
    // BC Upgrade SHUKLP03 << Document Subtype Code related code added.
    //BC UPGRADE KUMARR78 >>
    // Changing for (FDD OTC 091/090)
    //Adding Field and Table Relation for Vehical and Driver Code. 
    //BC UPGARDE KUMARR78 <<
    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Customer No.")
        {
            CaptionML = ENU = 'Customer No.', FRA = 'N° client';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
           // OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage / Loss,FFE Security Payment', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêt,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment';

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
        modify("Sales (LCY)")
        {
            CaptionML = ENU = 'Sales (LCY)', FRA = 'Ventes DS';
        }
        modify("Profit (LCY)")
        {
            CaptionML = ENU = 'Profit (LCY)', FRA = 'Marge DS';
        }
        modify("Inv. Discount (LCY)")
        {
            CaptionML = ENU = 'Inv. Discount (LCY)', FRA = 'Remise facture DS';
        }
        modify("Sell-to Customer No.")
        {
            CaptionML = ENU = 'Sell-to Customer No.', FRA = 'N° donneur d''ordre';
        }
        modify("Customer Posting Group")
        {
            CaptionML = ENU = 'Customer Posting Group', FRA = 'Groupe compta. client';

            //Unsupported feature: Change Editable on ""Customer Posting Group"(Field 22)". Please convert manually.

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
        modify("Salesperson Code")
        {

            //Unsupported feature: Change TableRelation on ""Salesperson Code"(Field 25)". Please convert manually.

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
            //OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset', FRA = 'Général,Client,Fournisseur,Banque,Immobilisation';
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
        modify("Last Issued Reminder Level")
        {
            CaptionML = ENU = 'Last Issued Reminder Level', FRA = 'Niveau dernière relance émise';
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
        modify("Direct Debit Mandate ID")
        {

            //Unsupported feature: Change TableRelation on ""Direct Debit Mandate ID"(Field 1200)". Please convert manually.

            CaptionML = ENU = 'Direct Debit Mandate ID', FRA = 'ID mandat domiciliation européenne';
        }

        field(50001; "Dispute Case FND"; Boolean)
        {
            CalcFormula = Exist("Dispute Case FND" where("Cust. Ledger Entry No." = FIELD("Entry No."),
                                                      Status = CONST(Open)));
            Description = 'HEI.01';
            Caption = 'Dispute Case';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Rem. Amt for WHT FND"; Decimal)
        {
            Caption = 'Rem. Amt for WHT';
        }
        field(50003; "Rem. Amt FND"; Decimal)
        {
            Caption = 'Rem. Amt';
        }
        field(50004; "WHT Amount FND"; Decimal)
        {
            CalcFormula = Sum("WHT Entry FND".Amount where("Bill-to/Pay-to No." = FIELD("Customer No."),
                                                        "Transaction No." = FIELD("Transaction No.")));
            Caption = 'WHT Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "WHT Amount (LCY) FND"; Decimal)
        {
            CalcFormula = Sum("WHT Entry FND"."Amount (LCY)" where("Bill-to/Pay-to No." = FIELD("Customer No."),
                                                                "Transaction No." = FIELD("Transaction No.")));
            Caption = 'WHT Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Comment FND"; Text[250])
        {
            Description = 'HEI.04';
            Caption = 'Comment';
        }
        field(50007; "WHT Payment FND"; Boolean)
        {
            Caption = 'WHT Payment';
        }
        field(50008; "Empties Item No. FND"; Code[20])
        {
            Caption = 'Empties Item No.';
            Description = 'HEI.08';
            Editable = false;
            TableRelation = Item where("Item Category Code" = FILTER(05));
        }
        field(50009; "Deposit Quantity FND"; Decimal)
        {
            Caption = 'Deposit Quantity';
            DecimalPlaces = 0 : 2;
            Description = 'HEI.08';
            Editable = false;
        }
        field(50010; "Customer Account Group FND"; Code[20])
        {
            CalcFormula = Lookup(Customer."Account Group FND" where("No." = FIELD("Sell-to Customer No.")));
            Description = 'HEI.09';
            Caption = 'Customer Account Group';
            FieldClass = FlowField;
        }
        field(50011; "Cashier ID FND"; Code[50])
        {
            CalcFormula = Lookup("Gen. Journal Batch"."Cashier ID FND" WHERE(Name = FIELD("Journal Batch Name")));
            Caption = 'Cashier ID';
            Description = 'HEI.10';
            FieldClass = FlowField;
        }
        field(50060; "Source System Identifier FND"; Code[10])
        {
            Caption = 'Source System Identifier';
            Description = 'HEI.13';
            Editable = false;
            TableRelation = "Source Sys Identifier API FND";
        }
        field(50061; "Related Sales Order No. FND"; Code[20])
        {
            Description = 'HEI.15';
            Caption = 'Related Sales Order No.';
        }
        field(50062; "Location Code FND"; Code[10])
        {
            CaptionML = ENU = 'Location Code',
                        FRA = 'Code magasin';
            DataClassification = ToBeClassified;
            Description = 'HEI.16';
            TableRelation = Location where("Use As In-Transit" = CONST(false));
        }

        //BC Upgrade SHUKLP03 >>
        //DRINKITFIELDS
        // field(2013610;"Customer DDeposit Group Code";Code[10])
        // {
        //     CaptionML = ENU='Customer Deposit Group Code',
        //                 FRA='Code groupe consigne client';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code WHERE ("Source Type"=CONST(Customer));
        // }
        // field(2013611;"Deposit Amount";Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Deposit Amount',
        //                 FRA='Montant consigne';
        //     Description = 'DITW16.00.00.43 DIT-715 #678';
        // }
        // field(2013612;"Deposit Amount (LCY)";Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Deposit Amount (LCY)',
        //                 FRA='Montant de la caution DS';
        //     Description = 'DITW16.00.00.43 DIT-715 #678';
        // }
        // field(2013667;"Customer DTax Group Code";Code[20])
        // {
        //     CaptionML = ENU='Customer Tax Group Code',
        //                 FRA='Code groupe taxe client';
        //     Description = 'DITW15.00.00.01,HEI.03';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Customer));
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
        // field(2013726;"Customer Tax Registration No.";Text[20])
        // {
        //     CaptionML = ENU='Customer Tax Registration No.',
        //                 FRA='N° ident. accise client';
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
        // field(2014271;"Customer Tax Warehouse Ref.";Text[20])
        // {
        //     CaptionML = ENU='Customer Tax Warehouse Reference',
        //                 FRA='Entrepôt fiscal de référence client';
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
        // field(2014410;"Invoice List Document No.";Code[20])
        // {
        //     CaptionML = ENU='Invoice List Document No.',
        //                 FRA='N° document liste facture';
        //     Description = 'DITW17.10.05 DIT-715 #761';

        //     trigger OnValidate();
        //     var
        //         recInvoiceList : Record "Invoice List";
        //         xrecInvoiceList : Record "Invoice List";
        //     begin
        //         // <<DITW18.00.07 WSA 30/03/2016 DIT-770 #1723
        //         if ("Invoice List Document No." <> xRec."Invoice List Document No.") then begin
        //           if "Invoice List Document No." <>'' then begin
        //             recInvoiceList.GET("Invoice List Document No.");
        //             recInvoiceList.RefreshAmounts();
        //           end;
        //           if xrecInvoiceList.GET(xRec."Invoice List Document No.") then;
        //             xrecInvoiceList.RefreshAmounts();
        //         end;
        //         // >>DITW18.00.07 WSA 30/03/2016 DIT-770 #1723
        //     end;
        // }
        field(50090; "Document Subtype Code FND"; Code[10])
        {
            Caption = 'Document Subtype Code';
            Description = 'NRQ17902';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales | "Fin.Contract"));
        }
        //BC UPGRADE KUMARR78 >> Field Adding for (Truck/Vehicle) Code
        field(50091; "Vehicle Code HNK FND"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vehicle Code';
            TableRelation = Vehicle101FDW;
        }
        //BC UPGRADE KUMARR78 << Field Adding for Truck/Vehicle Code
        //BC UPGRADE KUMARR78 >> Field Adding for (Driver) Code
        field(50092; "Driver Code HNK FND"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Driver';
            TableRelation = Vehicle101FDW;
        }
        //BC UPGRADE KUMARR78 << Field Adding for (Driver) Code
        // field(2029610;OGM;Text[30])
        // {
        //     CaptionML = ENU='OGM',
        //                 FRA='OGM';
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
        //     TableRelation = IF ("Contract Type"=CONST(Service),
        //                         "DIT Sub-Contract Type"=FILTER(<>" ")) "Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"))
        //                         else IF ("Contract Type"=CONST(Service),
        //                                  "DIT Sub-Contract Type"=CONST(" ")) "Contract Group".Code
        //                                  else IF ("Contract Type"=CONST(Financial)) "Financial Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"))
        //                                  else IF ("Contract Type"=CONST(Financial),
        //                                           "DIT Sub-Contract Type"=CONST(" ")) "Financial Contract Group".Code;
        // }
        // field(2034915;"Service Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Service Contract No.',
        //                 FRA='N° contrat de service';
        //     Description = 'DITW16.00.00.41 DIT-715 #392 #327 - DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Service Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                     "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
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
        //BC Upgrade SHUKLP03 << DIT fields blocked.
    }
    keys
    {

        //Unsupported feature: Deletion on ""Customer No.","Posting Date","Currency Code"(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""Document Type","Customer No.","Posting Date","Currency Code"(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""Customer No.","Global Dimension 1 Code","Global Dimension 2 Code","Posting Date","Currency Code"(Key)". Please convert manually.

        //BC Upgrade SHUKLP03 >> Blocked all keys because some are dependent on DIT fields "DIT Sub-Contract Type","Service Contract No.","Item Charge Type" and some are for French localization and we are not taking French localization code.
        // key(Key1;"Customer No.","Posting Date","Currency Code","Item Charge Type","DIT Sub-Contract Type","Service Contract No.")
        // {
        //     SumIndexFields = "Sales (LCY)","Profit (LCY)","Inv. Discount (LCY)";
        // }
        // key(Key2;"Document Type","Customer No.","Posting Date","Currency Code","Item Charge Type","DIT Sub-Contract Type","Service Contract No.")
        // {
        //     MaintainSIFTIndex = false;
        //     MaintainSQLIndex = false;
        //     SumIndexFields = "Sales (LCY)","Profit (LCY)","Inv. Discount (LCY)","Deposit Quantity";
        // }
        // key(Key3;"Customer No.","Global Dimension 1 Code","Global Dimension 2 Code","Posting Date","Currency Code","Item Charge Type","DIT Sub-Contract Type","Service Contract No.","Customer Posting Group")
        // {
        //     SumIndexFields = "Sales (LCY)","Profit (LCY)","Inv. Discount (LCY)";
        // }
        // key(Key4;"Customer No.","Contract Type","DIT Sub-Contract Type","Service Contract No.","Posting Date","Currency Code","Contract Group Code","Building No.","Item Charge Type")
        // {
        //     SumIndexFields = "Sales (LCY)","Profit (LCY)","Inv. Discount (LCY)";
        // }
        // key(Key5;"Document No.","Document Type")
        // {
        // }
        // key(Key6;OGM)
        // {
        // }
        // key(Key7;"Source Code","Posting Date","Document No.")
        // {
        // }
        // key(Key8;"Source Code","Document No.","Posting Date")
        // {
        // }
        // key(Key9;"Customer No.","Posting Date","Source Code")
        // {
        // }
        // key(Key10;"Customer No.","Document No.","Posting Date")
        // {
        // }
        // key(Key11;"Applies-to ID")
        // {
        // }
        // key(Key12;"Document Type","Item Charge Type","Customer No.")
        // {
        //     SumIndexFields = "Deposit Quantity";
        // }
        //BC Upgrade SHUKLP03 << Blocked all keys because some are dependent on DIT fields "DIT Sub-Contract Type","Service Contract No.","Item Charge Type" and some are for French localization and we are not taking French localization code.
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=must have the same sign as %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=must have the same sign as %1;FRA=doit avoir le même signe que %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=must not be larger than %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=must not be larger than %1;FRA=ne doit pas être supérieur(e) à %1;
    //Variable type has not been exported.
}

