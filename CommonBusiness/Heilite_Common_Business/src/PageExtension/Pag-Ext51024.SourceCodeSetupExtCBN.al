pageextension 51024 SourceCodeSetup_ExtCBN extends "Source Code Setup"
{
    // version NAVW110.0,DITW110.00.08,HEI.04
    //     DITW15.00.00.01 DDR 07/01/2008 Drink-it Tax Item Charges functionnalities
    //                                added tab "Drink-It"
    // DITW15.00.00.01 DDR 23/01/2008 Added Drink-it Discount & Promotion Item Charges functionnalities
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.35 DDR 11/09/2009 Added field "Purchase Service Management" into 'Service' tab
    // DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 Plant Maintenance Functionnality
    //                                Added 'Maintenance' tab
    //                                Added fields "Maintenance Counter Journal"
    // DITW16.00.00.41 AHU 09/08/2012 DIT-715 #378
    //                                Added fields "Indirect Sales Journal" into 'Service' tab

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 SFI 30/08/2017 BL#14417 New field
    //                                         2013610 "Inventory Post Deposit"

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New fields for MDM integration: "WHT Settlement"

    // HEI.02 FDD PTPGAP078 IBM 26.05.2018
    //   # Show new field Payment Journal Tree
    // HEI.03 CHG2105033 BULIMC01 IBM 05.11.2021 #new field added to General tab - "No. Series for Kyriba"
    // HEI.04 CHG2193490 IBM SISUM01 26/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # add field Id "PPV Source Code" in the Inventory tab

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("General Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from a general journal of the general type.', FRA = 'Spécifie le code lié aux écritures qui sont validées à partir d''une feuille de type général.';
        }
        modify("IC General Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from an intercompany general journal.', FRA = 'Spécifie le code lié aux écritures validées à partir du journal d''une feuille comptabilité intersociété.';
        }
        modify("Close Income Statement")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted when you run the Close Income Statement batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées lorsque vous lancez le traitement par lots Clôturer exercice comptable.';
        }
        modify("VAT Settlement")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted using the Calc. and Post VAT Settlement batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées en utilisant le traitement par lots Calculer et valider décl. TVA.';
        }
        modify("Exchange Rate Adjmt.")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted when you run the Adjust Exchange Rates batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées lorsque vous lancez le traitement par lots Ajuster taux de change.';
        }
        modify("Deleted Document")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted in connection with the deletion of a document.', FRA = 'Spécifie le code lié aux écritures qui sont validées suite à la suppression d''un document.';
        }
        modify("Adjust Add. Reporting Currency")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted when you change the additional reporting currency in the General Ledger Setup table.', FRA = 'Spécifie le code lié aux écritures qui sont validées lorsque vous modifiez la devise report dans la table Paramètres comptabilité.';
        }
        modify("Compress G/L")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted using the Date Compress General Ledger batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées en utilisant le traitement par lots Compresser écritures compta.';
        }
        modify("Compress VAT Entries")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted using the Date Compress VAT Entries batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées en utilisant le traitement par lots Compresser écritures TVA.';
        }
        modify("Compress Bank Acc. Ledger")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted using the Date Compress Bank Acc. Ledger batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées en utilisant le traitement par lots Compresser écritures banque.';
        }
        modify("Compress Check Ledger")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted using the Delete Check Ledger Entries batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées en utilisant le traitement par lots Supprimer écritures comptables chèque.';
        }
        modify("Trans. Bank Rec. to Gen. Jnl.")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries posted after being transferred from a bank reconciliation by the Trans. Bank Rec. to Gen. Jnl. batch job.', FRA = 'Spécifie le code associé aux écritures validées après avoir été transmises à partir d''un rapprochement bancaire par le traitement par lots Trans. rappr. banc. -> f. cpta.';
        }
        modify(Reversal)
        {
            ToolTipML = ENU = 'Specifies the code assigned to entries that are posted from the Reverse Entries window.', FRA = 'Spécifie le code attribué aux écritures validées à partir de la fenêtre Contrepasser les écritures.';
        }
        modify("Cash Flow Worksheet")
        {
            ToolTipML = ENU = 'Specifies the source code assigned to entries that are posted from the cash flow worksheet.', FRA = 'Spécifie le code journal attribué aux écritures validées à partir de la feuille trésorerie.';
        }
        modify("Payment Reconciliation Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from a payment reconciliation journal.', FRA = 'Spécifie le code lié aux écritures validées à partir du journal d''une feuille rapprochement bancaire.';
        }
        modify(Sales)
        {
            CaptionML = ENU = 'Sales', FRA = 'Ventes';
        }
        modify(Control14)
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted in connection with sales, such as orders, invoices, and credit memos.', FRA = 'Spécifie le code lié aux écritures validées associées à des ventes, telles que des commandes, factures et avoirs.';
        }
        modify("Sales Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries posted from a general journal of the sales type.', FRA = 'Spécifie le code lié aux écritures qui sont validées à partir d''une feuille de type vente.';
        }
        modify("Cash Receipt Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from a general journal of the cash receipts type.', FRA = 'Spécifie le code lié aux écritures qui sont validées à partir d''une feuille de type règlements.';
        }
        modify("Sales Entry Application")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from the Apply Customer Entries window.', FRA = 'Spécifie le code lié aux écritures validées à partir de la fenêtre Lettrer écritures client.';
        }
        modify("Unapplied Sales Entry Appln.")
        {
            ToolTipML = ENU = 'Specifies the code assigned to entries that are posted from the Unapply Customer Entries window.', FRA = 'Spécifie le code attribué aux écritures validées à partir de la fenêtre Délettrer les écritures client.';
        }
        modify(Reminder)
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from a Reminder.', FRA = 'Spécifie le code lié aux écritures validées à partir d''une relance.';
        }
        modify("Finance Charge Memo")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from a Finance Charge Memo.', FRA = 'Spécifie le code lié aux écritures qui sont validées à partir d''une facture intérêts.';
        }
        modify("Compress Cust. Ledger")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted using the Date Compress Customer Ledger batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées en utilisant le traitement par lots Compresser écritures client.';
        }
        modify(Purchases)
        {
            CaptionML = ENU = 'Purchases', FRA = 'Achats';
        }
        modify(Control26)
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted in connection with purchases, such as orders, invoices, and credit memos.', FRA = 'Spécifie le code lié aux écritures validées associées à des achats, tels que des commandes, factures et avoirs.';
        }
        modify("Purchase Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from a general journal of the purchase type.', FRA = 'Spécifie le code lié aux écritures qui sont validées à partir d''une feuille de type d''achat.';
        }
        modify("Payment Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from a general journal of the payments type.', FRA = 'Spécifie le code lié aux écritures qui sont validées à partir d''une feuille de type de paiement.';
        }
        modify("Purchase Entry Application")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from the Apply Vendor Entries window.', FRA = 'Spécifie le code lié aux écritures validées à partir de la fenêtre Lettrer écritures fournisseur.';
        }
        modify("Unapplied Purch. Entry Appln.")
        {
            ToolTipML = ENU = 'Specifies the code assigned to entries that are posted from the Unapply Vendor Entries window.', FRA = 'Spécifie le code attribué aux écritures validées à partir de la fenêtre Délettrer les écritures fournisseur.';
        }
        modify("Compress Vend. Ledger")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted using the Date Compress Vendor Ledger batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées en utilisant le traitement par lots Compresser écritures fourn.';
        }
        modify(Inventory)
        {
            CaptionML = ENU = 'Inventory', FRA = 'Stocks';
        }
        modify(Transfer)
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted in connection with transfer orders.', FRA = 'Spécifie le code lié aux écritures validées en relation avec les ordres de transfert.';
        }
        modify("Item Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from an item journal.', FRA = 'Spécifie le code lié aux écritures validées à partir d''une feuille article.';
        }
        modify("Item Reclass. Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from an Item Reclass. Journal.', FRA = 'Spécifie le code lié aux écritures validées à partir du journal d''une Feuille reclassement article.';
        }
        modify("Phys. Inventory Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from a Physical Inventory Journal.', FRA = 'Spécifie le code lié aux écritures qui sont validées à partir d''une feuille inventaire physique.';
        }
        modify("Revaluation Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from a Revaluation Journal.', FRA = 'Spécifie le code lié aux écritures qui sont validées à partir d''une feuille réévaluation.';
        }
        modify("Inventory Post Cost")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted when you run the Post Inventory Cost to G/L batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées lorsque vous lancez le traitement par lots Valider coûts stocks en comptabilité.';
        }
        modify("Compress Item Ledger")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted using the Date Compress Item Ledger batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées en utilisant le traitement par lots Compresser écritures article.';
        }
        modify("Compress Item Budget")
        {
            ToolTipML = ENU = 'Specifies the code that is linked to the compressed item budget entries.', FRA = 'Spécifie le code lié aux écritures de budget article compressées.';
        }
        modify("Adjust Cost")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are the result of a cost adjustment.', FRA = 'Spécifie le code lié aux écritures qui résultent d''un ajustement du coût.';
        }
        modify(Assembly)
        {
            ToolTipML = ENU = 'Specifies the code that is linked to entries that are posted with assembly orders.', FRA = 'Spécifie le code qui est lié aux écritures validées en relation avec les ordres d''assemblage.';
        }
        modify(Resources)
        {
            CaptionML = ENU = 'Resources', FRA = 'Ressources';
        }
        modify("Resource Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from a Resource Journal.', FRA = 'Spécifie le code lié aux écritures qui sont validées à partir d''une feuille ressource.';
        }
        modify("Compress Res. Ledger")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted using the Date Compress Resource Ledger batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées en utilisant le traitement par lots Compresser écritures ress.';
        }
        modify(Jobs)
        {
            CaptionML = ENU = 'Jobs', FRA = 'Projets';
        }
        modify("Job Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from a job journal.', FRA = 'Spécifie le code lié aux écritures qui sont validées à partir d''une feuille projet.';
        }
        modify("Job G/L Journal")
        {
            ToolTipML = ENU = 'Specifies the code assigned to entries that are posted from a general journal of the Job G/L Journal type.', FRA = 'Spécifie le code affecté aux écritures qui sont validées à partir d''une feuille comptabilité de type Feuille compta. projet.';
        }
        modify("Job G/L WIP")
        {
            ToolTipML = ENU = 'Specifies the code assigned to entries that are posted from the Job Post WIP to G/L batch job in the Jobs module.', FRA = 'Spécifie le code affecté aux écritures qui sont validées à partir du traitement par lots Projet Valider TEC en comptabilité dans le module Projets.';
        }
        modify("Compress Job Ledger")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted using the Date Compress Job Ledger batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées en utilisant le traitement par lots Compresser écritures projets.';
        }
        modify("Fixed Assets")
        {
            CaptionML = ENU = 'Fixed Assets', FRA = 'Immobilisations';
        }
        modify("Fixed Asset G/L Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from a fixed asset G/L journal.', FRA = 'Spécifie le code lié aux écritures qui sont validées à partir d''une feuille compta. immo.';
        }
        modify("Fixed Asset Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from a fixed asset journal.', FRA = 'Spécifie le code lié aux écritures qui sont validées à partir d''une feuille immobilisation.';
        }
        modify("Insurance Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from an insurance journal.', FRA = 'Spécifie le code lié aux écritures validées à partir d''une feuille assurance.';
        }
        modify("Compress FA Ledger")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted using the Date Compress FA Ledger batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées en utilisant le traitement par lots Compresser écritures immo.';
        }
        modify("Compress Maintenance Ledger")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted using the Date Compress Maint. Ledger batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées en utilisant le traitement par lots Compresser écritures maint.';
        }
        modify("Compress Insurance Ledger")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted using the Date Compress Insurance Ledger batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées en utilisant le traitement par lots Compresser écritures assurance.';
        }
        modify(Manufacturing)
        {
            CaptionML = ENU = 'Manufacturing', FRA = 'Production';
        }
        modify("Consumption Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from a consumption journal.', FRA = 'Spécifie le code lié aux écritures qui sont validées à partir d''une feuille consommation.';
        }
        modify("Output Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from an output journal.', FRA = 'Spécifie le code lié aux écritures validées à partir du journal d''une feuille production.';
        }
        modify(Flushing)
        {
            ToolTipML = ENU = 'Specifies the code linked to consumption entries that are posted when you change the status of a released production order to Finished.', FRA = 'Spécifie le code lié aux écritures consommation qui sont validées lorsque vous faites passer l''état d''un ordre de fabrication de Sorti de production à Terminé.';
        }
        modify("Capacity Journal")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from a capacity journal.', FRA = 'Spécifie le code lié aux écritures qui sont validées à partir d''une feuille capacité.';
        }
        modify("Production Journal")
        {
            ToolTipML = ENU = 'Specifies the code that is linked to the entries that are posted from a production journal.', FRA = 'Spécifie le code qui est lié aux écritures qui sont validées à partir d''une feuille production.';
        }
        modify(Service)
        {
            CaptionML = ENU = 'Service', FRA = 'Service';
        }
        modify("Service Management")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted from the Service Management application area.', FRA = 'Spécifie le code lié aux écritures qui sont validées à partir du domaine d''application Gestion des services.';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("Whse. Item Journal")
        {
            ToolTipML = ENU = 'Specifies the code for the Warehouse Item Journal.', FRA = 'Spécifie le code de la feuille article entrepôt.';
        }
        modify("Whse. Reclassification Journal")
        {
            ToolTipML = ENU = 'Specifies the code for the Whse. Reclassification Journal.', FRA = 'Spécifie le code de la feuille reclassement entrepôt.';
        }
        modify("Whse. Phys. Invt. Journal")
        {
            ToolTipML = ENU = 'Specifies the code for the Whse. Phys. Invt. Journal.', FRA = 'Spécifie le code de la feuille inventaire entrepôt.';
        }
        modify("Whse. Put-away")
        {
            ToolTipML = ENU = 'Specifies the code for the Warehouse Put-away.', FRA = 'Spécifie le code du rangement entrepôt.';
        }
        modify("Whse. Pick")
        {
            ToolTipML = ENU = 'Specifies the code for the Warehouse Pick.', FRA = 'Spécifie le code du prélèvement entrepôt.';
        }
        modify("Whse. Movement")
        {
            ToolTipML = ENU = 'Specifies the code for the Warehouse movement.', FRA = 'Spécifie le code du mouvement entrepôt.';
        }
        modify("Compress Whse. Entries")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted using the Date Compress Whse. Entries batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées en utilisant le traitement par lots Compresser écritures entrepôt.';
        }
        modify("Cost Accounting")
        {
            CaptionML = ENU = 'Cost Accounting', FRA = 'Comptabilité analytique';
        }
        modify("G/L Entry to CA")
        {
            ToolTipML = ENU = 'Specifies the code assigned to entries that are posted from transferring general ledger entries to cost entries.', FRA = 'Spécifie le code affecté aux écritures qui sont validées à partir du transfert des écritures comptables aux écritures de coût.';
        }
        modify("Cost Journal")
        {
            ToolTipML = ENU = 'Specifies the code assigned to entries that are posted from a cost journal.', FRA = 'Spécifie le code attribué aux écritures qui sont validées à partir d''une feuille de coûts.';
        }
        modify("Cost Allocation")
        {
            ToolTipML = ENU = 'Specifies the code assigned to entries that are posted from cost allocations.', FRA = 'Spécifie le code attribué aux écritures qui sont validées à partir d''affectations de coûts.';
        }
        modify("Transfer Budget to Actual")
        {
            ToolTipML = ENU = 'Specifies the code linked to entries that are posted by running the Transfer Budget to Actual batch job.', FRA = 'Spécifie le code lié aux écritures qui sont validées en exécutant le traitement par lots Transférer le budget vers Réel.';
        }
        addafter("Payment Reconciliation Journal")
        {
            field("WHT Settlement"; Rec."WHT Settlement FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Settlement field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the WHT Settlement field.';

            }
            field("No. Series for Kyriba"; Rec."No. Series for Kyriba FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No. Series for Kyriba field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the No. Series for Kyriba field.';

            }
        }
        addafter("Payment Journal")
        {
            field("Payment Journal Tree"; Rec."Payment Journal Tree FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payment Journal Tree field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Payment Journal Tree field.';

            }
        }
        addafter(Assembly)
        {
            field("PPV Source Code"; Rec."PPV Source Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PPV Source Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the PPV Source Code field.';

            }
        }
        // BC Upgrade NANDIS03 - Blocked DIT fields >>
        // addafter("Service Management")
        // {
        //     field("Purchase Service Management"; Rec."Purchase Service Management")
        //     {
        //     }
        //     field("Indirect Sales Journal"; Rec."Indirect Sales Journal")
        //     {
        //     }
        // }
        // addafter("Cost Accounting")
        // {
        //     group("Drink-It")
        //     {
        //         CaptionML = ENU = 'Drink-It',
        //                     FRA = 'Drink-It';
        //         field("Tax Due Settlement"; Rec."Tax Due Settlement")
        //         {
        //         }
        //         field("Tax Due Post"; Rec."Tax Due Post")
        //         {
        //         }
        //         field("Discount Journal"; Rec."Discount Journal")
        //         {
        //         }
        //         field("Inventory Post Deposit"; Rec."Inventory Post Deposit")
        //         {
        //         }
        //     }
        //     group(Maintenance)
        //     {
        //         CaptionML = ENU = 'Maintenance',
        //                     FRA = 'Maintenance';
        //         field("Counter Journal"; Rec."Counter Journal")
        //         {
        //             Description = 'DIT-715 #297';
        //         }
        //         field("Reset Counter Journal"; Rec."Reset Counter Journal")
        //         {
        //         }
        //     }
        // }
        // BC Upgrade NANDIS03 - Blocked DIT fields >>
    }


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RESET;
    IF NOT GET THEN BEGIN
      INIT;
      INSERT;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RESET;
    if not GET then begin
      INIT;
      INSERT;
    end;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

