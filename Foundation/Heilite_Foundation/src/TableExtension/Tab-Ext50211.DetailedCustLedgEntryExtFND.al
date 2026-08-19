tableextension 50211 DetailedCustLedgEntryExtFND extends "Detailed Cust. Ledg. Entry"
{
    //   DITW15.00.00.35 DDR 21/04/2009 Added fields + all keys
    //                                    2034872 Contract Group Code
    //   DITW15.00.00.37 DDR 01/06/2010 issue 857 Added fields + all keys
    //                                              2034850 DIT Sub-Contract Type
    //                                            Added TableRelation for field2034872
    //   DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 Plant Maintenance Functionnality
    //                                               Added 'PlantMaintenance' option field2034850 "DIT Sub-Contract Type"
    //                   AHU 24/07/2012 DIT-715 #327 #392 Modified 'TableRelation' property field2034872 Contract Group Code
    //                                                    Added fields
    //                                                      2034915 Service Contract No.
    //                                                      2014310 Service Contract Line No.
    //                                                      2014311 Service Contract Type
    //                   AHU 16/08/2012 DIT-715 #327 Added field2034915 Service Contract No. into keys using sumindexfields
    //                   AHU 27/08/2012 DIT-715 #393 Added field2014311 Service Contract Type into keys using sumindexfields
    //                   AHU 12/11/2012 DIT-715 #393 Added "Cust. Ledger Entry No." into keys
    //                                                 "Customer No.,Posting Date,Entry Type,Currency Code,Service Contract Type,
    //                                                ,DIT Sub-Contract Type,Service Contract No.,Contract Group Code,Cust. Ledger Entry No."
    //   DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields
    //                                    2013695 Item Charge Type
    //   DITW17.00.02 SR 10/09/2013 DIT-770 #137 : Add options 'Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back' to "Document Type"
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW17.10.03 MSF 28/03/2014 DIT-715 #340 Added field "Customer Posting Group"
    //                                            Added field "Customer Posting Group" Into 5 Key  (Key that contain field "Service contract No.")
    //   DITW17.10.03 MSF 29/04/2014 DIT-770 #670 Performance problem on Applying entries is back (was solved by Ludo van den Ende)
    //                                          Added Key  "Cust. Ledger Entry No.,Entry Type"
    //   DITW18.00.06 DDR 13/07/2015 DIT-770 #1258 Modified keys (sumindexes)
    //                                                 "Entry No."
    //                                               "Document No.,Customer No."
    //                                             Added key
    //                                               "Cust. Ledger Entry No.,Posting Date"
    //   DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                             Added field "Financial Contract No."
    //                                             Rename Caption Contract No. by Service contract No.
    //                                             Change ID of field Contract Type to Foundation layer 2035393
    //                                             Added blank Option to Contract Type
    //   DITW18.00.06 MVN 13/10/2015 DIT-770 #1653 Added 4 DRINK-IT Fields to Key 7: used for Flowfields in Table 18
    //                                               DIT Sub-Contract Type,Service Contract No.,Item Charge Type,Customer Posting Group
    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.01 FDD-KDD0TC002 IBM HORTOC01 04.10.2017 - new option on "Document type" field - "Interest Rate Credit"
    //   HEI.02 CHG2066589 IBM KUMARN15 01.06.2020
    //     # New key added Customer No.,Initial Entry Global Dim. 1,Initial Entry Global Dim. 2,Currency Code,Posting Date,
    //     DIT Sub-Contract Type,Service Contract No.,Item Charge Type,Customer Posting Group,Initial Document Type with SumIndexField Amount (LCY)
    //   HEI.03 CHG2066590 IBM KUMARN15 01.06.2020
    //     # Modified key Customer No.,Initial Entry Global Dim. 1,Initial Entry Global Dim. 2,Currency Code,Posting Date,
    //     DIT Sub-Contract Type,Service Contract No.,Item Charge Type,Customer Posting Group,Initial Document Type to Add Entry No.

    //   BC Upgrade KUMARS145 Table Ext
    //   BC Upgrade KUMARS145 Drink it DITW field commented

    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Cust. Ledger Entry No.")
        {
            CaptionML = ENU = 'Cust. Ledger Entry No.', FRA = 'N° écriture comptable clt';
        }
        modify("Entry Type")
        {
            CaptionML = ENU = 'Entry Type', FRA = 'Type écriture';
            //OptionCaptionML = ENU = ',Initial Entry,Application,Unrealized Loss,Unrealized Gain,Realized Loss,Realized Gain,Payment Discount,Payment Discount (VAT Excl.),Payment Discount (VAT Adjustment),Appln. Rounding,Correction of Remaining Amount,Payment Tolerance,Payment Discount Tolerance,Payment Tolerance (VAT Excl.),Payment Tolerance (VAT Adjustment),Payment Discount Tolerance (VAT Excl.),Payment Discount Tolerance (VAT Adjustment)', FRA = ',Écriture origine,Lettrage,Pertes prévues,Gains prévus,Pertes réalisées,Gains réalisés,Escompte,Escompte (HT),Escompte (ajust. TVA),Arrondi lettrage,Correction de montant ouvert,Écart de règlement,Écart d''escompte,Écart de règlement (HT),Écart de règlement (ajust. TVA),Écart d''escompte (HT),Écart d''escompte (ajust. TVA)';
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
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Amount (LCY)")
        {
            CaptionML = ENU = 'Amount (LCY)', FRA = 'Montant DS';
        }
        modify("Customer No.")
        {
            CaptionML = ENU = 'Customer No.', FRA = 'N° client';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("Transaction No.")
        {
            CaptionML = ENU = 'Transaction No.', FRA = 'N° transaction';
        }
        modify("Journal Batch Name")
        {
            CaptionML = ENU = 'Journal Batch Name', FRA = 'Nom feuille';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
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
        modify("Initial Entry Due Date")
        {
            CaptionML = ENU = 'Initial Entry Due Date', FRA = 'Date d''échéance écr. initiale';
        }
        modify("Initial Entry Global Dim. 1")
        {
            CaptionML = ENU = 'Initial Entry Global Dim. 1', FRA = 'Axe principal 1 écr. initiale';
        }
        modify("Initial Entry Global Dim. 2")
        {
            CaptionML = ENU = 'Initial Entry Global Dim. 2', FRA = 'Axe principal 2 écr. initiale';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
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
        modify("Initial Document Type")
        {
            CaptionML = ENU = 'Initial Document Type', FRA = 'Type document initial';
            // OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement';
        }
        modify("Applied Cust. Ledger Entry No.")
        {
            CaptionML = ENU = 'Applied Cust. Ledger Entry No.', FRA = 'N° écriture comptable clt lettrée';
        }
        modify(Unapplied)
        {
            CaptionML = ENU = 'Unapplied', FRA = 'Non lettré';
        }
        modify("Unapplied by Entry No.")
        {
            CaptionML = ENU = 'Unapplied by Entry No.', FRA = 'Non lettré par n° séquence';
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            CaptionML = ENU = 'Remaining Pmt. Disc. Possible', FRA = 'Escompte ouvert possible';
        }
        modify("Max. Payment Tolerance")
        {
            CaptionML = ENU = 'Max. Payment Tolerance', FRA = 'Ecart de règlement max.';
        }
        modify("Tax Jurisdiction Code")
        {
            CaptionML = ENU = 'Tax Jurisdiction Code', FRA = 'USA code autorités recouvrem.';
        }
        modify("Application No.")
        {
            CaptionML = ENU = 'Application No.', FRA = 'N° application';
        }
        modify("Ledger Entry Amount")
        {
            CaptionML = ENU = 'Ledger Entry Amount', FRA = 'Montant écriture comptable';
        }
        field(50000; "Last Adjusted Curr. Factor FND"; Decimal)
        {
            Caption = 'Last Adjusted Curr. Factor';
            DecimalPlaces = 2 : 10;
            Description = 'HEI.01';
        }
        field(50001; "Reversed FND"; Decimal)
        {
            Caption = 'Reversed';
            Description = 'HEI.01';
        }

        //   BC Upgrade KUMARS145 Drinkit "DITW" field commented .... >>
        // field(2013695; "Item Charge Type"; Option)
        // {
        //     CaptionML = ENU = 'Item Charge Type',
        //                 FRA = 'Type frais annexes';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        // }
        // field(2014310; "Service Contract Line No."; Integer)
        // {
        //     CaptionML = ENU = 'Service Contract Line No.',
        //                 FRA = 'N° ligne contrat de service';
        //     Description = 'DITW16.00.00.41 DIT-715 #392 #327';
        // }
        // field(2014313; "Financial Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Financial Contract No.',
        //                 FRA = 'N° Contrat Financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Financial Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract),
        //                                                                       "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034850; "DIT Sub-Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Sub Contract Type',
        //                 FRA = 'Sous type contrat';
        //     Description = 'DITW15.00.00.37- DIT-715 #297';
        //     OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA = ' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        // }
        // field(2034872; "Contract Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Contract Group Code',
        //                 FRA = 'Code groupe contrat';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = IF ("Contract Type" = CONST(Service),
        //                         "DIT Sub-Contract Type" = FILTER(<> " ")) "Contract Group".Code WHERE("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
        //     ELSE IF ("Contract Type" = CONST(Service),
        //                                  "DIT Sub-Contract Type" = CONST(" ")) "Contract Group".Code
        //     ELSE IF ("Contract Type" = CONST(Financial)) "Financial Contract Group".Code WHERE("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034915; "Service Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Service Contract No.',
        //                 FRA = 'N° contrat de service';
        //     Description = 'DITW16.00.00.41 DIT-715 #392 #327';
        //     TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract),
        //                                                                     "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034916; "Customer Posting Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Customer Posting Group',
        //                 FRA = 'Groupe compta. client';
        //     Description = 'DITW17.10.03 MSF 28/03/2014 DIT-715 #340';
        //     Editable = false;
        //     TableRelation = "Customer Posting Group";
        // }
        // field(2035393; "Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Contract Type',
        //                 FRA = 'Type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392 #327 - DITW18.00.06 DIT-770 #1368';
        //     OptionCaptionML = ENU = ' ,Service,Financial',
        //                       FRA = ' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }
        //   BC Upgrade KUMARS145 Drinkit "DITW" field commented .... <<
    }
    keys
    {
        //Unsupported feature: PropertyChange on ""Entry No."(Key)". Please convert manually.
        //Unsupported feature: PropertyChange on ""Cust. Ledger Entry No.","Posting Date"(Key)". Please convert manually.
        //Unsupported feature: Deletion on ""Cust. Ledger Entry No.","Entry Type","Posting Date"(Key)". Please convert manually.
        //Unsupported feature: Deletion on ""Customer No.","Currency Code","Initial Entry Global Dim. 1","Initial Entry Global Dim. 2","Initial Entry Due Date","Posting Date"(Key)". Please convert manually.
        key(Key50000; "Cust. Ledger Entry No.", "Entry Type") // BC Upgrade KUMARS145 
        {
            SumIndexFields = Amount, "Amount (LCY)", "Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)";
        }
        // BC Upgrade KUMARS145 Keys commented dependent on Drinkit fields.....>>
        // key(Key5000; "Cust. Ledger Entry No.", "Entry Type", "Posting Date", "Item Charge Type", "DIT Sub-Contract Type", "Service Contract No.", "Customer Posting Group")
        // {
        //     MaintainSQLIndex = false;
        //     SumIndexFields = "Amount (LCY)";
        // }
        // key(Key5000; "Customer No.", "Currency Code", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Initial Entry Due Date", "Posting Date", "DIT Sub-Contract Type", "Service Contract No.", "Item Charge Type", "Customer Posting Group")
        // {
        //     SumIndexFields = Amount, "Amount (LCY)";
        // }
        // BC Upgrade KUMARS145 Keys commented dependent on Drinkit fields.....>>
        key(Key50001; "Document No.", "Customer No.") // BC Upgrade KUMARS145
        {
            SumIndexFields = Amount;
        }
        // BC Upgrade KUMARS145 Keys commented dependent on Drinkit fields.....>>
        // key(Key5000; "Customer No.", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code", "Posting Date", "DIT Sub-Contract Type", "Service Contract No.", "Item Charge Type", "Customer Posting Group", "Initial Document Type", "Entry Type")
        // {
        //     SumIndexFields = "Amount (LCY)";
        // }
        // BC Upgrade KUMARS145 Keys commented dependent on Drinkit fields.....>>
    }
    //Unsupported feature: InsertAfter on "Documentation". Please convert maually.
    //Unsupported feature: PropertyChange. Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
}
