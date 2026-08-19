tableextension 50016 SourceCodeSetup_ExtFND extends "Source Code Setup"
{
    // version NAVW110.0,DITW110.00.08,HEI.04
    // DITW15.00.00.01 DDR 07/01/2008 Added Drink-it Tax Item Charges functionnalities
    //                                Added fields
    //                                  2034681 Tax Due Settlement
    //                                  2034689 Tax Due Post Cost

    // DITW15.00.00.01 DDR 23/01/2008 Added Drink-it Discount & Promotion Item Charges functionnalities
    //                                Added fields
    //                                  2013768 Discount Journal
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.20 DDR 11/06/2008 Certification rules
    // DITW15.00.00.35 DDR 11/09/2009 Added fields
    //                                  2034902  Purchase Service Management
    // DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 Plant Maintenance Functionnality
    //                                             Added fields
    //                                               2034948 Maintenance Counter Journal
    // DITW16.00.00.41 AHU 09/08/2012 DIT-715 #378 Added fields
    //                                               2034934 Indirect Sales Journal

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 SFI 30/08/2017 BL#14417 New field
    //                                         2013610 "Inventory Post Deposit"

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New fields for MDM integration

    // HEI.02 FDD PTPGAP078 IBM POSTOI01 26.05.2018
    //   # new field 50001 Payment Journal Tree, Code 10
    // HEI.03 CHG2105033 BULIMC01 IBM 05.11.2021#new field added: 50002 - "No. Series for Kyriba"
    // HEI.04 CHG2193490 IBM SISUM01 26/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # add field with Id 50003

    fields
    {
        modify("Primary Key")
        {
            CaptionML = ENU = 'Primary Key', FRA = 'Clé primaire';
        }
        modify(Sales)
        {
            CaptionML = ENU = 'Sales', FRA = 'Ventes';
        }
        modify(Purchases)
        {
            CaptionML = ENU = 'Purchases', FRA = 'Ac&hats';
        }
        modify("Inventory Post Cost")
        {
            CaptionML = ENU = 'Inventory Post Cost', FRA = 'Comptabilisation stock';
        }
        modify("Exchange Rate Adjmt.")
        {
            CaptionML = ENU = 'Exchange Rate Adjmt.', FRA = 'Ajust. taux de change';
        }
        modify("Post Recognition")
        {
            CaptionML = ENU = 'Post Recognition', FRA = 'Réception projet';
        }
        modify("Post Value")
        {
            CaptionML = ENU = 'Post Value', FRA = 'Valorisation projet';
        }
        modify("Close Income Statement")
        {
            CaptionML = ENU = 'Close Income Statement', FRA = 'Clôturer exercice comptable';
        }
        modify(Consolidation)
        {
            CaptionML = ENU = 'Consolidation', FRA = 'Consolidation';
        }
        modify("General Journal")
        {
            CaptionML = ENU = 'General Journal', FRA = 'Feuille comptabilité';
        }
        modify("Sales Journal")
        {
            CaptionML = ENU = 'Sales Journal', FRA = 'Feuille vente';
        }
        modify("Purchase Journal")
        {
            CaptionML = ENU = 'Purchase Journal', FRA = 'Feuille achat';
        }
        modify("Cash Receipt Journal")
        {
            CaptionML = ENU = 'Cash Receipt Journal', FRA = 'Feuille règlement';
        }
        modify("Payment Journal")
        {
            CaptionML = ENU = 'Payment Journal', FRA = 'Feuille paiement';
        }
        modify("Item Journal")
        {
            CaptionML = ENU = 'Item Journal', FRA = 'Feuille article';
        }
        modify("Resource Journal")
        {
            CaptionML = ENU = 'Resource Journal', FRA = 'Feuille ressource';
        }
        modify("Job Journal")
        {
            CaptionML = ENU = 'Job Journal', FRA = 'Feuille projet';
        }
        modify("Sales Entry Application")
        {
            CaptionML = ENU = 'Sales Entry Application', FRA = 'Lettrage écritures vente';
        }
        modify("Purchase Entry Application")
        {
            CaptionML = ENU = 'Purchase Entry Application', FRA = 'Lettrage écritures achat';
        }
        modify("VAT Settlement")
        {
            CaptionML = ENU = 'VAT Settlement', FRA = 'Déclaration de TVA';
        }
        modify("Compress G/L")
        {
            CaptionML = ENU = 'Compress G/L', FRA = 'Compr. écritures comptables';
        }
        modify("Compress VAT Entries")
        {
            CaptionML = ENU = 'Compress VAT Entries', FRA = 'Compr. écritures TVA';
        }
        modify("Compress Cust. Ledger")
        {
            CaptionML = ENU = 'Compress Cust. Ledger', FRA = 'Compr. écritures client';
        }
        modify("Compress Vend. Ledger")
        {
            CaptionML = ENU = 'Compress Vend. Ledger', FRA = 'Compr. écritures fournisseur';
        }
        modify("Compress Item Ledger")
        {
            CaptionML = ENU = 'Compress Item Ledger', FRA = 'Compr. écritures article';
        }
        modify("Compress Res. Ledger")
        {
            CaptionML = ENU = 'Compress Res. Ledger', FRA = 'Compr. écritures ressource';
        }
        modify("Compress Job Ledger")
        {
            CaptionML = ENU = 'Compress Job Ledger', FRA = 'Compr. écritures projet';
        }
        modify("Item Reclass. Journal")
        {
            CaptionML = ENU = 'Item Reclass. Journal', FRA = 'Feuille reclassement article';
        }
        modify("Phys. Inventory Journal")
        {
            CaptionML = ENU = 'Phys. Inventory Journal', FRA = 'Feuille inventaire';
        }
        modify("Compress Bank Acc. Ledger")
        {
            CaptionML = ENU = 'Compress Bank Acc. Ledger', FRA = 'Compr. écritures banque';
        }
        modify("Compress Check Ledger")
        {
            CaptionML = ENU = 'Compress Check Ledger', FRA = 'Compr. écritures chèque';
        }
        modify("Financially Voided Check")
        {
            CaptionML = ENU = 'Financially Voided Check', FRA = 'Chèque annulé financièrement';
        }
        modify("Finance Charge Memo")
        {
            CaptionML = ENU = 'Finance Charge Memo', FRA = 'Facture d''intérêts';
        }
        modify(Reminder)
        {
            CaptionML = ENU = 'Reminder', FRA = 'Relance';
        }
        modify("Deleted Document")
        {
            CaptionML = ENU = 'Deleted Document', FRA = 'Document supprimé';
        }
        modify("Adjust Add. Reporting Currency")
        {
            CaptionML = ENU = 'Adjust Add. Reporting Currency', FRA = 'Ajuster devise report';
        }
        modify("Trans. Bank Rec. to Gen. Jnl.")
        {
            CaptionML = ENU = 'Trans. Bank Rec. to Gen. Jnl.', FRA = 'Trans. rappr. banc. -> f. cpta';
        }
        modify("IC General Journal")
        {
            CaptionML = ENU = 'IC General Journal', FRA = 'Feuille comptabilité IC';
        }
        modify("Unapplied Sales Entry Appln.")
        {
            CaptionML = ENU = 'Unapplied Sales Entry Appln.', FRA = 'Lettrage écr vente non lettré';
        }
        modify("Unapplied Purch. Entry Appln.")
        {
            CaptionML = ENU = 'Unapplied Purch. Entry Appln.', FRA = 'Lettrage écritures achat non appliqué';
        }
        modify(Reversal)
        {
            CaptionML = ENU = 'Reversal', FRA = 'Contrepassation';
        }
        modify("Payment Reconciliation Journal")
        {
            CaptionML = ENU = 'Payment Reconciliation Journal', FRA = 'Feuille rapprochement bancaire';
        }
        modify("Cash Flow Worksheet")
        {
            CaptionML = ENU = 'Cash Flow Worksheet', FRA = 'Feuille trésorerie';
        }
        modify(Assembly)
        {
            CaptionML = ENU = 'Assembly', FRA = 'Assemblage';
        }
        modify("Job G/L Journal")
        {
            CaptionML = ENU = 'Job G/L Journal', FRA = 'Feuille compta. projet';
        }
        modify("Job G/L WIP")
        {
            CaptionML = ENU = 'Job G/L WIP', FRA = 'TEC compta. projet';
        }
        modify("G/L Entry to CA")
        {
            CaptionML = ENU = 'G/L Entry to CA', FRA = 'Écriture comptable vers CA';
        }
        modify("Cost Journal")
        {
            CaptionML = ENU = 'Cost Journal', FRA = 'Feuille de coûts';
        }
        modify("Cost Allocation")
        {
            CaptionML = ENU = 'Cost Allocation', FRA = 'Ventilation des coûts';
        }
        modify("Transfer Budget to Actual")
        {
            CaptionML = ENU = 'Transfer Budget to Actual', FRA = 'Transférer le budget vers Réel';
        }
        modify("Consumption Journal")
        {
            CaptionML = ENU = 'Consumption Journal', FRA = 'Feuille consommation';
        }
        modify("Output Journal")
        {
            CaptionML = ENU = 'Output Journal', FRA = 'Feuille de production';
        }
        modify(Flushing)
        {
            CaptionML = ENU = 'Flushing', FRA = 'Calcul consommation';
        }
        modify("Capacity Journal")
        {
            CaptionML = ENU = 'Capacity Journal', FRA = 'Feuille capacité';
        }
        modify("Production Journal")
        {
            CaptionML = ENU = 'Production Journal', FRA = 'Feuille production';
        }
        modify("Fixed Asset Journal")
        {
            CaptionML = ENU = 'Fixed Asset Journal', FRA = 'Feuille immobilisation';
        }
        modify("Fixed Asset G/L Journal")
        {
            CaptionML = ENU = 'Fixed Asset G/L Journal', FRA = 'Feuille compta. immo.';
        }
        modify("Insurance Journal")
        {
            CaptionML = ENU = 'Insurance Journal', FRA = 'Feuille assurance';
        }
        modify("Compress FA Ledger")
        {
            CaptionML = ENU = 'Compress FA Ledger', FRA = 'Compr. écritures immo.';
        }
        modify("Compress Maintenance Ledger")
        {
            CaptionML = ENU = 'Compress Maintenance Ledger', FRA = 'Compr. écritures maintenance';
        }
        modify("Compress Insurance Ledger")
        {
            CaptionML = ENU = 'Compress Insurance Ledger', FRA = 'Compr. écritures assurance';
        }
        modify(Transfer)
        {
            CaptionML = ENU = 'Transfer', FRA = 'Ordre de transfert';
        }
        modify("Revaluation Journal")
        {
            CaptionML = ENU = 'Revaluation Journal', FRA = 'Feuille réévaluation';
        }
        modify("Adjust Cost")
        {
            CaptionML = ENU = 'Adjust Cost', FRA = 'Ajustement des coûts';
        }
        modify("Service Management")
        {
            CaptionML = ENU = 'Service Management', FRA = 'Gestion des services';
        }
        modify("Compress Item Budget")
        {
            CaptionML = ENU = 'Compress Item Budget', FRA = 'Compresser le budget d''article';
        }
        modify("Whse. Item Journal")
        {
            CaptionML = ENU = 'Whse. Item Journal', FRA = 'Feuille article entrep.';
        }
        modify("Whse. Phys. Invt. Journal")
        {
            CaptionML = ENU = 'Whse. Phys. Invt. Journal', FRA = 'Feuille inventaire entrepôt';
        }
        modify("Whse. Reclassification Journal")
        {
            CaptionML = ENU = 'Whse. Reclassification Journal', FRA = 'Feuille reclassement entrepôt';
        }
        modify("Whse. Put-away")
        {
            CaptionML = ENU = 'Whse. Put-away', FRA = 'Rangement entrepôt';
        }
        modify("Whse. Pick")
        {
            CaptionML = ENU = 'Whse. Pick', FRA = 'Prélèvement entrepôt';
        }
        modify("Whse. Movement")
        {
            CaptionML = ENU = 'Whse. Movement', FRA = 'Mouvement entrepôt';
        }
        modify("Compress Whse. Entries")
        {
            CaptionML = ENU = 'Compress Whse. Entries', FRA = 'Compresser écritures entrepôt';
        }
        field(50000; "WHT Settlement FND"; Code[10])
        {
            Caption = 'WHT Settlement';
            Description = 'HEI.01';
            TableRelation = "Source Code";
        }
        field(50001; "Payment Journal Tree FND"; Code[10])
        {
            CaptionML = ENU = 'Payment Journal Tree',
                        FRA = 'Feuille paiement arbre';
            Description = 'HEI.02';
            TableRelation = "Source Code";
        }
        field(50002; "No. Series for Kyriba FND"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Caption = 'No. Series for Kyriba';
        }
        field(50003; "PPV Source Code FND"; Code[10])
        {
            Caption = 'PPV Source Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "Source Code".Code;
        }
        // BC Upgrade NANDIS03 - Blocked DIT code >>
        // field(2013610; "Inventory Post Deposit"; Code[10])
        // {
        //     CaptionML = DEU = 'Pfandregulierung',
        //                 ENU = 'Inventory Post Deposit';
        //     Description = 'DITW110.00.11 BL#14417';
        //     TableRelation = "Source Code";
        // }
        // field(2013701; "Tax Due Settlement"; Code[10])
        // {
        //     CaptionML = ENU = 'Tax Due Settlement',
        //                 FRA = 'Règlement taxe due';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Source Code";
        // }
        // field(2013709; "Tax Due Post"; Code[10])
        // {
        //     CaptionML = ENU = 'Tax Due Post',
        //                 FRA = 'Enregistrer taxe due';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Source Code";
        // }
        // field(2013768; "Discount Journal"; Code[10])
        // {
        //     CaptionML = ENU = 'Discount Journal',
        //                 FRA = 'Feuille Remise';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Source Code";
        // }
        // field(2034902; "Purchase Service Management"; Code[10])
        // {
        //     CaptionML = ENU = 'Purchase Service Management',
        //                 FRA = 'Gestion des services achat';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Source Code";
        // }
        // field(2034934; "Indirect Sales Journal"; Code[10])
        // {
        //     CaptionML = ENU = 'Indirect Sales Journal',
        //                 FRA = 'Feuille vente indirecte';
        //     Description = 'DITW16.00.00.41 DIT-715 #378';
        //     TableRelation = "Source Code";
        // }
        // field(2034948; "Counter Journal"; Code[10])
        // {
        //     CaptionML = ENU = 'Counter Journal',
        //                 FRA = 'Feuille compteur';
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        //     TableRelation = "Source Code";
        // }
        // field(2034959; "Reset Counter Journal"; Code[10])
        // {
        //     CaptionML = ENU = 'Reset Counter Journal',
        //                 FRA = 'Code feuille réinitialiser compteur';
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        //     TableRelation = "Source Code";
        // }
        // BC Upgrade NANDIS03 - Blocked DIT code <<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

