pageextension 51028 PurchasesnPayablesSetupExtCBN extends "Purchases & Payables Setup"
{
    // version NAVW110.0,FINXL10.01,DITW110.00.13,HEI.41


    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Discount Posting")
        {
            ToolTipML = ENU = 'Specifies the type of purchase discounts to post separately.', FRA = 'Spécifie le type de remises achat à valider séparément.';
        }
        modify("Receipt on Invoice")
        {
            ToolTipML = ENU = 'Specifies that a posted receipt and a posted invoice are automatically created when you post an invoice.', FRA = 'Spécifie qu''une réception validée et une facture enregistrée sont automatiquement créées lorsque vous enregistrez une facture.';
        }
        modify("Return Shipment on Credit Memo")
        {
            ToolTipML = ENU = 'Automatically creates a posted return shipment and a posted purchase credit memo when you post a credit memo.', FRA = 'Crée automatiquement une expédition retour enregistrée et qu''un avoir achat validé lorsque vous validez un avoir.';
        }
        modify("Invoice Rounding")
        {
            ToolTipML = ENU = 'Specifies that amounts are rounded for purchase invoices.', FRA = 'Spécifie que les montants sont arrondis pour les factures achat.';
        }
        modify("Ext. Doc. No. Mandatory")
        {
            ToolTipML = ENU = 'Specifies whether it is mandatory to enter an external document number.', FRA = 'Spécifie s''il est obligatoire de saisir un numéro de document externe.';
        }
        modify("Allow VAT Difference")
        {
            ToolTipML = ENU = 'Specifies whether to allow the manual adjustment of VAT amounts in purchase documents.', FRA = 'Indique s''il faut autoriser l''ajustement manuel des montants de TVA dans des documents achat.';
        }
        modify("Calc. Inv. Discount")
        {
            ToolTipML = ENU = 'Specifies whether the invoice discount amount is automatically calculated with purchase documents.', FRA = 'Spécifie si le montant de la remise facture est automatiquement calculé avec des documents achat.';
        }
        modify("Calc. Inv. Disc. per VAT ID")
        {
            ToolTipML = ENU = 'Specifies that the invoice discount is calculated according to VAT Identifier.', FRA = 'Spécifie que la remise facture est calculée en fonction de l''Identifiant TVA.';
        }
        modify("Appln. between Currencies")
        {
            ToolTipML = ENU = 'Specifies to what extent the application of entries in different currencies is allowed in the Purchases and Payables application area.', FRA = 'Spécifie les conditions d''autorisation de lettrage entre devises dans le domaine d''application Achats.';
        }
        modify("Copy Comments Blanket to Order")
        {
            ToolTipML = ENU = 'Specifies whether to copy comments from blanket orders to purchase orders.', FRA = 'Spécifie s''il faut copier les commentaires de commandes ouvertes vers des commandes achat.';
        }
        modify("Copy Comments Order to Invoice")
        {
            ToolTipML = ENU = 'Specifies whether to copy comments from purchase orders to purchase invoices.', FRA = 'Spécifie s''il faut copier les commentaires de commandes achat vers des factures achat.';
        }
        modify("Copy Comments Order to Receipt")
        {
            ToolTipML = ENU = 'Specifies whether to copy comments from purchase orders to receipts.', FRA = 'Spécifie s''il faut copier les commentaires de commandes achat vers des reçus.';
        }
        modify("Copy Cmts Ret.Ord. to Cr. Memo")
        {
            ToolTipML = ENU = 'Specifies whether to copy comments from purchase return orders to sales credit memos.', FRA = 'Spécifie s''il faut copier les commentaires de retours achat vers des avoirs vente.';
        }
        modify("Copy Cmts Ret.Ord. to Ret.Shpt")
        {
            ToolTipML = ENU = 'Specifies that comments are copied from the return order to the posted return shipment.', FRA = 'Spécifie que les commentaires sont copiés du retour vers l''expédition retour enregistrée.';
        }
        modify("Exact Cost Reversing Mandatory")
        {
            ToolTipML = ENU = 'Specifies that a return transaction cannot be posted unless the Appl.-to Item Entry field on the purchase order line Specifies an entry.', FRA = 'Spécifie qu''une transaction de retour ne peut pas être validée si le champ Écr. article à lettrer de la ligne commande achat contient une écriture.';
        }
        modify("Check Prepmt. when Posting")
        {
            ToolTipML = ENU = 'Specifies that a warning message is shown when you receive or invoice an order that has an unpaid prepayment amount.', FRA = 'Spécifie qu''un message d''avertissement est affiché lorsque vous recevez ou facturez une commande associée à un montant d''acompte impayé.';
        }
        // modify("Archive Quotes and Orders")
        // {
        //     ToolTipML = ENU = 'Specifies whether to automatically archive purchase quotes and purchase orders before they are deleted during the make order or posting processes.', FRA = 'Spécifie s''il faut archiver automatiquement les demandes de prix et commandes achat avant qu''elles ne soient supprimées au cours des processus de commande ou de validation.';
        // }  // BC Upgrade NANDIS03
        modify("Default Posting Date")
        {
            ToolTipML = ENU = 'Specifies how to use the Posting Date field on purchase documents.', FRA = 'Spécifie comment utiliser le champ Date comptabilisation sur les documents achat.';
        }
        modify("Default Qty. to Receive")
        {
            ToolTipML = ENU = 'Specifies the default value inserted in the Qty. to Receive field in purchase order lines and in the Return Qty. to Ship field in purchase return order lines.', FRA = 'Spécifie la valeur par défaut qui est insérée dans le champ Qté à recevoir sur les lignes commande achat et dans le champ Qté retour à expédier sur les lignes retour commande achat.';
        }
        modify("Allow Document Deletion Before")
        {
            ToolTipML = ENU = 'Specifies if and when posted purchase documents can be deleted. If you enter a date, posted purchase documents with a posting date on or after this date cannot be deleted.', FRA = 'Spécifie si, et quand, des documents achat validés peuvent être supprimés. Si vous saisissez une date, les documents achat validés dont la date comptabilisation est égale ou postérieure à cette date ne peuvent pas être supprimés.';
        }
        modify("Number Series")
        {
            CaptionML = ENU = 'Number Series', FRA = 'Souche de numéros';
        }
        modify("Vendor Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to vendors.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux fournisseurs.';
        }
        modify("Quote Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to purchase quotes.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux demandes de prix.';
        }
        modify("Blanket Order Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to blanket purchase orders.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux commandes achat ouvertes.';
        }
        modify("Order Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to purchase orders.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux commandes achat.';
        }
        modify("Return Order Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series that is used to assign numbers to new purchase return orders.', FRA = 'Spécifie la souche de numéros qui est utilisée pour affecter des numéros à de nouveaux retours achat.';
        }
        modify("Invoice Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to purchase invoices.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux factures achat.';
        }
        modify("Credit Memo Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to purchase credit memos.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux avoirs achat.';
        }
        modify("Posted Receipt Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to posted receipts.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux réceptions enregistrées.';
        }
        modify("Posted Return Shpt. Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series to be used when you post return shipments.', FRA = 'Spécifie la souche de numéros à utiliser lorsque vous validez les expéditions retour.';
        }
        modify("Background Posting")
        {
            CaptionML = ENU = 'Background Posting', FRA = 'Validation arrière-plan';
        }
        // modify(Post)
        // {
        //     CaptionML = ENU = 'Post', FRA = 'Valider';
        // }  // BC Upgrade NANDIS03
        modify("Post with Job Queue")
        {
            ToolTipML = ENU = 'Specifies if your business process uses job queues in the background to post documents, including orders, invoices, return orders, and credit memos.', FRA = 'Spécifie si votre processus entreprise utilise des files d''attente des travaux en arrière-plan pour valider des documents, y compris des commandes, des factures, des retours et des avoirs.';
        }
        // modify("Job Queue Priority for Post")
        // {
        //     ToolTipML = ENU = 'Specifies the priority of the job queue when you run it in the context of background posting. You can set different priorities for the post and post and print settings. The default setting is 1000.', FRA = 'Spécifie la priorité de la file d''attente des travaux lorsque vous l''exécutez dans le contexte d''une validation en arrière-plan. Vous pouvez définir différentes priorités pour les paramètres d''impression et de validation. Le paramètre par défaut est 1 000.';
        // }
        // modify("Post & Print")
        // {
        //     CaptionML = ENU = 'Post & Print', FRA = 'Valider et imprimer';
        // }  // BC Upgrade NANDIS03
        modify("Post & Print with Job Queue")
        {
            ToolTipML = ENU = 'Specifies whether your business process uses job queues to post and print purchase documents. Select this check box to enable background posting and printing.', FRA = 'Spécifie si votre processus entreprise utilise des files d''attente des travaux pour valider et imprimer des documents achat. Cochez cette case pour activer l''impression et la validation d''arrière-plan.';
        }
        // modify("Job Q. Prio. for Post & Print")
        // {
        //     ToolTipML = ENU = 'Specifies the priority of the job queue when you run it in the context of background posting. You can set different priorities for the post and post and print settings. The default setting is 1000.', FRA = 'Spécifie la priorité de la file d''attente des travaux lorsque vous l''exécutez dans le contexte d''une validation en arrière-plan. Vous pouvez définir différentes priorités pour les paramètres d''impression et de validation. Le paramètre par défaut est 1 000.';
        // }
        // modify(Control9)
        // {
        //     CaptionML = ENU = 'General', FRA = 'Général';
        // }  // BC Upgrade NANDIS03
        modify("Job Queue Category Code")
        {
            ToolTipML = ENU = 'Specifies the code for the category of the job queue that you want to associate with background posting.', FRA = 'Spécifie le code pour la catégorie de la file d''attente des travaux que vous voulez associer à une validation d''arrière-plan.';
        }
        modify("Notify On Success")
        {
            ToolTipML = ENU = 'Specifies if a notification is sent when posting and printing is successfully completed.', FRA = 'Spécifie si une notification est envoyée lorsque la validation et l''impression aboutissent.';
        }
        modify("Default Accounts")
        {
            CaptionML = ENU = 'Default Accounts', FRA = 'Comptes par défaut';
        }
        modify("Debit Acc. for Non-Item Lines")
        {
            CaptionML = ENU = 'Default Debit Account for Non-Item Lines', FRA = 'Compte débit par défaut pour lignes non-article';
            ToolTipML = ENU = 'Specifies the debit account that is inserted on purchase credit memo lines by default.', FRA = 'Spécifie le compte de débit qui est inséré sur les lignes avoir achat par défaut.';
        }
        modify("Credit Acc. for Non-Item Lines")
        {
            CaptionML = ENU = 'Default Credit Account for Non-Item Lines', FRA = 'Compte crédit par défaut pour lignes non-article';
            ToolTipML = ENU = 'Specifies the debit account that is inserted on purchase credit memo lines by default.', FRA = 'Spécifie le compte de débit qui est inséré sur les lignes avoir achat par défaut.';
        }
        addafter("Ext. Doc. No. Mandatory")
        {
            // field("Vendor Shipment No. Mandatory"; Rec."Vendor Shipment No. Mandatory")
            // {
            // }  // BC Upgrade NANDIS03
            field("Mandatory Region on Header"; Rec."Mandatory Region on Header FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Mandatory Region on Header field.';
                // BC Upgrade NANDIS03                                                                                                                                                                        ToolTip = 'Specifies the value of the Mandatory Region on Header field.';

            }
        }
        addafter("Archive Return Orders")
        {
            field("Auto.Arch.Deleted Inv&CrMemos"; Rec."Auto.Arch.Del. Inv&CrMemos FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Auto.Arch.Deleted Inv&CrMemos field.';
            }
        }  // BC Upgrade SHARMP16--
        addafter("Default Qty. to Receive")
        {
            // field("Check Totals on Purch. Inv./CM"; Rec."Check Totals on Purch. Inv./CM")
            // {
            //     Description = 'FINXL7.00.001';
            // }  // BC Upgrade NANDIS03
            field("Prepmt. Via deduction on final"; Rec."Prepmt.Via deduction final FND")
            {
                Visible = false; // BC Upgrade BHARDA11 --FDD STP 009 -- Remove "Prepmt. Via deduction on final" functionality
                Caption = 'Prepmt. Via deduction on final Invoice';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prepmt. Via deduction on final Invoice field.';
                // BC Upgrade NANDIS03                                                                                                                                                                                                                             ToolTip = 'Specifies the value of the Prepmt. Via deduction on final Invoice field.';

            }
            // field("Show Invoice No."; Rec."Show Invoice No.")
            // {
            //     Description = 'FINXL7.00.001';
            //     Visible = false;
            // }
            // field("Rcpt. Inv. Approval Margin Min"; Rec."Rcpt. Inv. Approval Margin Min")
            // {
            //     Description = 'FINXL7.00.001';
            // }
            // field("Rcpt. Inv. Approval Margin Max"; Rec."Rcpt. Inv. Approval Margin Max")
            // {
            //     Description = 'FINXL7.00.001';
            // }  // BC Upgrade NANDIS03
        }
        addafter("Allow Document Deletion Before")
        {
            field("Auto Release Purchase Order"; Rec."Auto Release Purch. Order FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Auto Release Purchase Order field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Auto Release Purchase Order field.';

            }
            field("Reason Code Block Vendor"; Rec."Reason Code Block Vendor FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Reason Code Block Vendor field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Reason Code Block Vendor field.';

            }
            field("Missing BankDetails ReasonCode"; Rec."MissingBnkDetailReasonCode FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Missing BankDetails ReasonCode field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Missing BankDetails ReasonCode field.';

            }
            field("Allow printing C&TP PO"; Rec."Allow printing C&TP PO FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow printing C&TP PO field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Allow printing C&TP PO field.';

            }
            field("Allow VAT Change C&TP Orders"; Rec."Allow VATChange C&TP Ord. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow VAT Change C&TP Orders field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Allow VAT Change C&TP Orders field.';

            }
            field("Auto E-mail Active"; Rec."Auto E-mail Active FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Auto E-mail Active field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Auto E-mail Active field.';

            }
            field("Enable FA Vendor Requirement"; Rec."Enable FA Vendor Req. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable FA Vendor Requirement field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Enable FA Vendor Requirement field.';

            }
            field("Auto Email to Requestor"; Rec."Auto Email to Requestor FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Auto Email to Requestor field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Auto Email to Requestor field.';

            }
            field("SPL Active"; Rec."SPL Active FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SPL Active field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the SPL Active field.';

            }
            field("SPL Account Group"; Rec."SPL Account Group FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SPL Account Group field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the SPL Account Group field.';

            }
            // field("Astro Whse Rcpt Manl Post"; Rec."Astro Whse Rcpt Manl Post")
            // {
            //     ApplicationArea = All;  // BC Upgrade NANDIS03
            //     Caption = 'ASTRO Whse. Receipt/Shipment Manual Posting';
            // }//BC Upgrade SHARMP16-- Astro related fields out of scope-- 
            field("Enable PQ to PO check"; Rec."Enable PQ to PO check FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable PQ to PO check field.';
                // BC Upgrade NANDIS03                                                                                                                                                                                                                                                                                                                                                    ToolTip = 'Specifies the value of the Enable PQ to PO check field.';

            }
            field("H&S Levy Tax"; Rec."H&S Levy Tax FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the H&S Levy Tax field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the H&S Levy Tax field.';

            }
            field("Enabled Overdue Notification"; Rec."Enabled Overdue Notifi. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enabled Overdue Notification field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Enabled Overdue Notification field.';

            }
            field("Overdue Days for Email Notify"; Rec."Overdue Days Email Notify FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Overdue Days for Email Notification field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Overdue Days for Email Notification field.';

            }
            field("CC Email ID for PO Send"; Rec."CC Email ID for PO Send FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CC Email ID for PO Send field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the CC Email ID for PO Send field.';

            }
            field("Exclude PO Document Subtype"; Rec."Exclude PO Doc. Subtype FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exclude PO Document Subtype field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Exclude PO Document Subtype field.';

            }
            field("No. of Emails to Send in Batch"; Rec."No. of Emails Send Batch FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No. of Emails to Send in Batch field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the No. of Emails to Send in Batch field.';

            }
            field("Disable Vendor Bank Add Check"; Rec."Disable VendorBankAddCheck FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Disable Vendor Bank Address Check field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Disable Vendor Bank Address Check field.';

            }
            field("Region Code for PO"; Rec."Region Code for POC FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Region Code for PO field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Region Code for PO field.';

            }
        }
        addafter(General)
        {
            group("Document Subtype Codes")
            {

                Caption = 'Document Subtype Codes';
                field("PO Subtype Code"; Rec."PO Subtype Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PO Subtype Code field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the PO Subtype Code field.';

                }
                field("NPO Subtype Code"; Rec."NPO Subtype Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NPO Subtype Code field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the NPO Subtype Code field.';

                }
                field("NPO Prepayment request subtype"; Rec."NPO Prepayment req.subtype FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NPO Prepayment request subtype field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the NPO Prepayment request subtype field.';

                }
                field("NPO Prepayment invoice subtype"; Rec."NPO Prepayment inv.subtype FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NPO Prepayment invoice subtype field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the NPO Prepayment invoice subtype field.';

                }
                field("NPO Prepayment CrdtMemo subtyp"; Rec."NPOPrepaymentCrdMemosubtyp FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NPO Prepayment CrdtMemo subtyp field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the NPO Prepayment CrdtMemo subtyp field.';

                }
                field("PO Prepayment request Subtype"; Rec."PO Prepayment req. Subtype FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PO Prepayment request Subtype field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the PO Prepayment request Subtype field.';

                }
                field("PO Prepayment invoice subtype"; Rec."PO Prepayment inv. subtype FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PO Prepayment invoice subtype field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the PO Prepayment invoice subtype field.';

                }
                field("PO Prepayment CrdtMemo subtype"; Rec."POPrepaymentCrdMemosubtype FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PO Prepayment CrdtMemo subtype field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the PO Prepayment CrdtMemo subtype field.';

                }
                field("Expense Claim Subdocument Type"; Rec."Expense Claim Subdoc. Type FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expense Claim Subdocument Type field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Expense Claim Subdocument Type field.';

                }
                field("Expense Claim CM Subdoc Type"; Rec."Expense ClaimCMSubdoc Type FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expense Claim CM Subdoc Type field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Expense Claim CM Subdoc Type field.';

                }
                field("Item Category"; Rec."Item Category FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Category field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Item Category field.';

                }
                field("Corrective CM Not Allowed"; Rec."Corrective CM Not Allowed FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Corrective Credit Memo Not allowed field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Corrective Credit Memo Not allowed field.';

                }
            }
        }
        addafter("Document Subtype Codes")
        {
            group(Heilite)
            {
                Caption = 'Heilite';
                group("Tolereance checking")
                {
                    Caption = 'Tolereance checking';
                    field("Invoice Toler. Check Enabled"; Rec."Invoice Toler.CheckEnabled FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Invoice Toler. Check Enabled field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the Invoice Toler. Check Enabled field.';

                    }
                    field("Check Tolerance Approval"; Rec."Check Tolerance Approval FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Check Tolerance Approval field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the Check Tolerance Approval field.';

                    }
                    field("Upper % Tolerance"; Rec."Upper % Tolerance FND")
                    {
                        ApplicationArea = All;  // BC Upgrade NANDIS03
                        Editable = Rec."Invoice Toler.CheckEnabled FND";
                        ToolTip = 'Specifies the value of the Upper % Tolerance field.';
                    }
                    field("Upper Amount Tolerance"; Rec."Upper Amount Tolerance FND")
                    {
                        ApplicationArea = All;  // BC Upgrade NANDIS03
                        Editable = Rec."Invoice Toler.CheckEnabled FND";
                        ToolTip = 'Specifies the value of the Upper Amount Tolerance field.';
                    }
                    field("Lower % Tolerance"; Rec."Lower % Tolerance FND")
                    {
                        ApplicationArea = All;  // BC Upgrade NANDIS03
                        Editable = Rec."Invoice Toler.CheckEnabled FND";
                        ToolTip = 'Specifies the value of the Lower % Tolerance field.';
                    }
                    field("Lower Amount Tolerance"; Rec."Lower Amount Tolerance FND")
                    {
                        ApplicationArea = All;  // BC Upgrade NANDIS03
                        Editable = Rec."Invoice Toler.CheckEnabled FND";
                        ToolTip = 'Specifies the value of the Lower Amount Tolerance field.';
                    }
                    field("Tolerance Exceptions"; Rec."Tolerance Exceptions FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Tolerance Exceptions field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the Tolerance Exceptions field.';

                    }
                    field(PoLegalText; PoLegalText)
                    {
                        ApplicationArea = All;  // BC Upgrade NANDIS03
                        Caption = 'PO Legal Text';
                        MultiLine = true;
                        ToolTip = 'Specifies the value of the PO Legal Text field.';

                        trigger OnValidate();
                        begin
                            //HEI.20>>
                            CLEAR(Rec."PO Legal Text FND");
                            Rec."PO Legal Text FND".CREATEOUTSTREAM(MemoWriter);
                            PoLegalText.WRITE(MemoWriter);
                            //HEI.20>>
                        end;
                    }
                    field(PoLegatTextInternational; PoLegatTextInternational)
                    {
                        ApplicationArea = All;  // BC Upgrade NANDIS03
                        Caption = 'PO Legal Text International';
                        MultiLine = true;
                        ToolTip = 'Specifies the value of the PO Legal Text International field.';

                        trigger OnValidate();
                        begin
                            //HEI.20>>
                            CLEAR(REc."PO Legal Txt International FND");
                            Rec."PO Legal Txt International FND".CREATEOUTSTREAM(MemoWriter);
                            PoLegatTextInternational.WRITE(MemoWriter);
                            //HEI.20>>
                        end;
                    }
                    field(FooterText; FooterText)
                    {
                        ApplicationArea = All;  // BC Upgrade NANDIS03
                        Caption = 'Footer text';
                        MultiLine = true;
                        ToolTip = 'Specifies the value of the Footer text field.';

                        trigger OnValidate();
                        begin
                            //HEI.22>>
                            CLEAR(Rec."Footer Text FND");
                            Rec."Footer Text FND".CREATEOUTSTREAM(MemoWriter_1);
                            FooterText.WRITE(MemoWriter_1);

                            //HEI.22>>
                        end;
                    }
                    field(FooterTextInternational; FooterTextInternational)
                    {
                        ApplicationArea = All;  // BC Upgrade NANDIS03
                        Caption = 'Footer Text International';
                        MultiLine = true;
                        ToolTip = 'Specifies the value of the Footer Text International field.';

                        trigger OnValidate();
                        begin
                            //HEI.22>>

                            CLEAR(Rec."Footer Text International FND");
                            Rec."Footer Text International FND".CREATEOUTSTREAM(MemoWriter_1);
                            FooterTextInternational.WRITE(MemoWriter_1);
                            //HEI.22>>
                        end;
                    }
                    field("Excluded Incoterms"; Rec."Excluded Incoterms FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Excluded Incoterms field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the Excluded Incoterms field.';

                    }
                    field("Excluded Countries (Import PO)"; Rec."Excluded Countries Imp PO FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Excluded Countries (Import PO) field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the Excluded Countries (Import PO) field.';

                    }
                }
            }
        }

        addafter("Posted Credit Memo Nos.")
        {
            field("Payment Journal Archive Nos."; Rec."Payment Jnl Archive Nos. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payment Journal Archive Nos. field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Payment Journal Archive Nos. field.';

            }
            field("Prepayment Request Nos."; Rec."Prepayment Request Nos. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prepayment Request Nos. field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Prepayment Request Nos. field.';

            }
            field("Expense Claim Invoices Nos"; Rec."Expense Claim Invoices Nos FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Expense Claim Invoices Nos field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Expense Claim Invoices Nos field.';

            }
            field("Posted Exp Claim Invoices Nos"; Rec."Posted Exp Claim Inv. Nos FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posted Exp Claim Invoices Nos field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Posted Exp Claim Invoices Nos field.';

            }
            field("Expense claim credit memos Nos"; Rec."Expense claim crd memos No FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Expense claim credit memos Nos field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Expense claim credit memos Nos field.';

            }
            field("Posted Exp Claim CM Nos"; Rec."Posted Exp Claim CM Nos FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posted Exp Claim CM Nos field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Posted Exp Claim CM Nos field.';

            }
            field("Posted Exp. Costs Doc. Nos."; Rec."Posted Exp. Cost Doc. Nos. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posted Exp. Costs Doc. Nos. field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Posted Exp. Costs Doc. Nos. field.';

            }
            field("GR IR Invoice Write off No."; Rec."GR IR Invoice Writeoff No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GR IR Invoice Write off No. field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the GR IR Invoice Write off No. field.';

            }
            field("Posted GRIR Invoice Wrt off No"; Rec."Posted GRIR Inv. Wrtoff No FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posted GRIR Invoice Wrt off No field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Posted GRIR Invoice Wrt off No field.';

            }
        }
        addafter("Number Series")
        {
            group(WHT)
            {

                Caption = 'WHT';
                field("WHT Certificate No. Series"; Rec."WHT Certificate No. Series FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the WHT Certificate No. Series field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the WHT Certificate No. Series field.';

                }
                field("Print Dialog"; Rec."Print Dialog FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Print Dialog field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Print Dialog field.';

                }
                field("Print WHT Docs. on Pay. Post"; Rec."Print WHT Docs. Pay. Post FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Print WHT Docs. on Pay. Post field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Print WHT Docs. on Pay. Post field.';

                }
            }
        }
        // group("Std. Vendor Purchase Codes")
        // {
        //     CaptionML = ENU = 'Std. Vendor Purchase Codes',
        //                 FRA = 'Codes Achat Fournisseur Std.';
        //     Description = 'FINXL7.00.006';
        //     field("Insert Std. Vend. Purch. Lines"; Rec."Insert Std. Vend. Purch. Lines")
        //     {
        //         Description = 'FINXL7.00.006';

        //         trigger OnValidate();
        //         begin
        //             //<< FINXL7.00.006 KLU 03/10/2013
        //             fctUpdatePage();
        //             //>> FINXL7.00.006 KLU 03/10/2013
        //         end;
        //     }
        //     field(Control2029626; '')
        //     {
        //         CaptionClass = Text2029610;
        //         Description = 'FINXL7.00.006';
        //     }
        //     field(Quotes; Rec.Quotes)
        //     {
        //         Description = 'FINXL7.00.006';
        //         Enabled = blnQuotesEnable;
        //     }
        //     field(Orders; Rec.Orders)
        //     {
        //         Description = 'FINXL7.00.006';
        //         Enabled = blnOrdersEnable;
        //     }
        //     field(Invoices; Rec.Invoices)
        //     {
        //         Description = 'FINXL7.00.006';
        //         Enabled = blnInvoicesEnable;
        //     }
        //     field("Credit Memos"; Rec."Credit Memos")
        //     {
        //         Description = 'FINXL7.00.006';
        //         Enabled = blnCreditMemosEnable;
        //     }
        // }  // BC Upgrade NANDIS03

        //         // group("Drink-It")
        //         // {
        //         //     CaptionML = ENU = 'Drink-It',
        //         //                 FRA = 'Drink-It';
        //         //     group(Deposit)
        //         //     {
        //         //         CaptionML = ENU = 'Deposit',
        //         //                     FRA = 'Consigne';
        //         //         field("Empty Goods Item No. Mandatory"; Rec."Empty Goods Item No. Mandatory")
        //         //         {
        //         //         }
        //         //         field("Allow Split Deposit per"; Rec."Allow Split Deposit per")
        //         //         {
        //         //             Description = 'DIT-715 #370';
        //         //         }
        //         //         field("Deposit Point"; Rec."Deposit Point")
        //         //         {
        //         //         }
        //         //     }  // BC Upgrade NANDIS03
        //         // group(Tax)
        //         // {
        //         //     CaptionML = ENU = 'Tax',
        //         //                 FRA = 'Taxes';
        //         //     field("Default Tax Date"; Rec."Default Tax Date")
        //         //     {
        //         //     }
        //         //     field("Duty Point"; Rec."Duty Point")
        //         //     {
        //         //     }
        //         //     field("DTax per Group Mandatory"; Rec."DTax per Group Mandatory")
        //         //     {
        //         //     }
        //         // }  // BC Upgrade NANDIS03
        //         // group(Other)
        //         // {
        //         //     CaptionML = ENU = 'Other',
        //         //                 FRA = 'Autre';
        //         //     field("Allow Reverse Document Amount"; Rec."Allow Reverse Document Amount")
        //         //     {
        //         //     }
        //         //     field("Show Posting Warnings"; Rec."Show Posting Warnings")
        //         //     {
        //         //     }
        //         //     field("Show Reopen Warnings"; Rec."Show Reopen Warnings")
        //         //     {
        //         //     }
        //         //     field("Auto.Release Document on Whse."; Rec."Auto.Release Document on Whse.")
        //         //     {
        //         //     }
        //         //     field("Max. Autom. VAT Amt. Adjustm."; Rec."Max. Autom. VAT Amt. Adjustm.")
        //         //     {
        //         //     }
        //         //     field("Max. Autom. Amount Adjustm."; Rec."Max. Autom. Amount Adjustm.")
        //         //     {
        //         //     }
        //         //     field("Autoblock Vendor On Changes"; Rec."Autoblock Vendor On Changes")
        //         //     {
        //         //     }
        //         //     field("Autoblock Vend. On  Dimension"; Rec."Autoblock Vend. On  Dimension")
        //         //     {
        //         //     }
        //         //     field("Autoblock Vend. On BankAccount"; Rec."Autoblock Vend. On BankAccount")
        //         //     {
        //         //     }
        //         //     field("Automatic Document Approval"; Rec."Automatic Document Approval")
        //         //     {
        //         //     }
        //         // }  // BC Upgrade NANDIS03
        //         // group(Transport)
        //         // {
        //         //     CaptionML = ENU = 'Transport',
        //         //                 FRA = 'Transport';
        //         //     field("Default Route"; Rec."Default Route")
        //         //     {
        //         //     }
        //         //     field("Route Mandatory"; Rec."Route Mandatory")
        //         //     {
        //         //     }
        //         //     field("Min. Volume Warning"; Rec."Min. Volume Warning")
        //         //     {
        //         //     }
        //         //     field("Min. Weight Warning"; Rec."Min. Weight Warning")
        //         //     {
        //         //     }
        //         //     field("Max. Volume Warning"; Rec."Max. Volume Warning")
        //         //     {
        //         //     }
        //         //     field("Max. Weight Warning"; Rec."Max. Weight Warning")
        //         //     {
        //         //     }
        //         // }  // BC Upgrade NANDIS03
        //         // group("Price & Condition")
        //         // {
        //         //     CaptionML = ENU = 'Price & Condition',
        //         //                 FRA = 'Prix & Condition';
        //         //     field("Prices Priority Method"; Rec."Prices Priority Method")
        //         //     {
        //         //         Description = 'DIT-715 #521';
        //         //     }
        //         //     field("Recalculate Prices"; Rec."Recalculate Prices")
        //         //     {
        //         //         Description = 'DITW18.00.07 DIT-770 #1975';
        //         //     }
        //         //     field("Pay-to/Buy-from Prices Calc."; Rec."Pay-to/Buy-from Prices Calc.")
        //         //     {
        //         //     }
        //         //     field("Pay-to/Buy-from Dimensions"; Rec."Pay-to/Buy-from Dimensions")
        //         //     {
        //         //         Description = 'DIT-715 #522';
        //         //     }
        //         //     field("Autofill End Date"; Rec."Autofill End Date")
        //         //     {
        //         //     }
        //         // }  // BC Upgrade NANDIS03
        //         // group(Discount)
        //         // {
        //         //     CaptionML = ENU = 'Discount',
        //         //                 FRA = 'Remise';
        //         //     field("Discounts Priority Method"; Rec."Discounts Priority Method")
        //         //     {
        //         //         Description = 'DIT-715 #521';
        //         //     }
        //         //     field("Order Discount Priority Method"; Rec."Order Discount Priority Method")
        //         //     {
        //         //     }
        //         // }  // BC Upgrade NANDIS03
        //         // group(Promotion)
        //         // {
        //         //     field("Order PromotionPriority Method"; Rec."Order PromotionPriority Method")
        //         //     {
        //         //     }
        //         // }  // BC Upgrade NANDIS03
        //         // group("Loyalty & Exclusivity")
        //         // {
        //         //     CaptionML = ENU = 'Loyalty & Exclusivity',
        //         //                     FRA = 'Fidélité & Exclusivité';
        //         // field("Item Exclusivity Warning"; Rec."Item Exclusivity Warning")
        //         // {
        //         // }
        //         // field("Exclusivity Group Mandatory"; Rec."Exclusivity Group Mandatory")
        //         // {
        //         //     Enabled = false;
        //         // }  // BC Upgrade NANDIS03
        //         // }
        //         // group("Batch Post Purchase Order Defaults")
        //         // {
        //         //     CaptionML = ENU = 'Batch Post Purchase Order Defaults',
        //         //                 FRA = 'TPL défauts Commande achat';
        //         //     field("Batch PostOrders Print"; Rec."Batch PostOrders Print")
        //         //     {
        //         //         CaptionML = ENU = 'Batch Post Orders Print',
        //         //                     FRA = 'TPL imprimer Commande vente';
        //         //     }
        //         //     field("Batch PostOrders Status Filter"; Rec."Batch PostOrders Status Filter")
        //         //     {
        //         //         AssistEdit = false;
        //         //     }
        //         //     field("Batch PO Receipt Statusfilter"; Rec."Batch PO Receipt Statusfilter")
        //         //     {
        //         //         AssistEdit = false;
        //         //     }
        //         // }  // BC Upgrade NANDIS03
        //     }

        //     addafter("Notify On Success")
        //     {
        //         // field("ON HOLD unsatisfactory receipt"; Rec."ON HOLD unsatisfactory receipt")
        //         // {
        //         //     Description = 'DITW17.00.02 DIT-770 #144';
        //         // }  // BC Upgrade NANDIS03
        addafter("Background Posting")
        {
            group(Application)
            {
                CaptionML = ENU = 'Application',
                                    FRA = 'Lettrage';
                Description = 'FINXL7.00.001';
                // field("Block Invoicing From Orders"; Rec."Block Invoicing From Orders")
                // {
                //     Description = 'FINXL7.00.001 - NRQ#10464';
                // }
                // field("Show Posted Document No."; Rec."Show Posted Document No.")
                // {
                //     Description = 'FINXL7.00.001';
                // }
                // field("Keep Orders After Posting"; Rec."Keep Orders After Posting")
                // {
                //     Description = 'FINXL7.00.001';
                // }
                // field("Purchase price mandatory"; Rec."Purchase price mandatory")
                // {
                //     Description = 'FINXL7.00.001';
                // }
                // field("No Invoicing Without PO Match"; Rec."No Invoicing Without PO Match")
                // {
                //     Description = 'FINXL7.00.001';
                // }
                // field("Receipt Tolerance (Negative)"; Rec."Receipt Tolerance (Negative)")
                // {
                //     Description = 'FINXL7.00.001';
                // }
                // field("Receipt Tolerance (Positive)"; Rec."Receipt Tolerance (Positive)")
                // {
                //     Description = 'FINXL7.00.001';
                // }
                // field("Show Jnl. Template Selection"; Rec."Show Jnl. Template Selection")
                // {
                //     Description = 'FINXL7.00.001';
                // }
                // field("Vendor Auto Dimension Code"; Rec."Vendor Auto Dimension Code")
                // {
                // }  // BC Upgrade NANDIS03

                field("Allow Over Consumption on Qty."; Rec."Allow OverConsumption Qty. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allow Over Consumption on Qty. on Blanket Orders field.';
                    // BC Upgrade NANDIS03                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ToolTip = 'Specifies the value of the Allow Over Consumption on Qty. on Blanket Orders field.';

                }
                field("Allow Over Consumption on Amt."; Rec."Allow OverConsumption Amt. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allow Over Consumption on Amt. on Blanket Orders field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Allow Over Consumption on Amt. on Blanket Orders field.';

                }
                field("Approv. Needed Before Call-Off"; Rec."Approv.Need Before CallOff FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approval Needed Before Blanket Order Call-Off field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Approval Needed Before Blanket Order Call-Off field.';

                }
                field("Requester ID Mandatory"; Rec."Requester ID Mandatory FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requester ID Mandatory field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Requester ID Mandatory field.';

                }
                field("Location Code for Import Proc."; Rec."Location Code Imp Proc. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code for Import Process field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Location Code for Import Process field.';

                }
                field("Zone Code for Import Process"; Rec."Zone Code for Import Proc. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Zone Code for Import Proc. field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Zone Code for Import Proc. field.';

                }
            }
        }

        addafter("Default Accounts")
        {
            group("ESKER Connector")
            {
                CaptionML = ENU = 'ESKER Connector',
                                FRA = 'ESKER Connecteur';
                group("SFTP Server Setup")
                {
                    CaptionML = ENU = 'SFTP Server Setup';
                    field("ESKER SFTP Host Name"; Rec."ESKER SFTP Host Name FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ESKER SFTP Host Name field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the ESKER SFTP Host Name field.';

                    }
                    field("ESKER SFTP Port Number"; Rec."ESKER SFTP Port Number FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ESKER SFTP Port Number field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the ESKER SFTP Port Number field.';

                    }
                    field("ESKER SFTP Out Folder"; Rec."ESKER SFTP Out Folder FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ESKER SFTP Out Folder field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the ESKER SFTP Out Folder field.';

                    }
                    field("ESKER SFTP ErpAck Folder"; Rec."ESKER SFTP ErpAck Folder FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ESKER SFTP ErpAck Folder field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the ESKER SFTP ErpAck Folder field.';

                    }
                    field("ESKER SFTP InMasterData Folder"; Rec."ESKER SFTPInMsterDataFoldr FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ESKER SFTP InMasterData Folder field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the ESKER SFTP InMasterData Folder field.';

                    }

                    field("ESKER Unpaid Invoices"; Rec."ESKER Unpaid Invoices FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ESKER Unpaid Invoices field.';
                        // BC Upgrade NANDIS03                          ToolTip = 'Specifies the value of the ESKER Unpaid Invoices field.';

                    }
                    field("ESKER Paid Invoices"; Rec."ESKER Paid Invoices FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ESKER Paid Invoices field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the ESKER Paid Invoices field.';

                    }

                    field("ESKER SFTP Login"; Rec."ESKER SFTP Login FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ESKER SFTP Login field.';
                        // BC Upgrade NANDIS03                          ToolTip = 'Specifies the value of the ESKER SFTP Login field.';

                    }
                    field("ESKER SFTP Password"; Rec."ESKER SFTP Password FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ESKER SFTP Password field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the ESKER SFTP Password field.';

                    }
                }


                group("Invoice Integration Setup")
                {
                    CaptionML = ENU = 'Invoice Integration Setup',
                                    FRA = 'ParamÙtres intÙgration des factures';
                    field("ESKER Max. Tolerance Amount"; Rec."ESKER Max. Tolerance Amt FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ESKER Max. Tolerance Amount field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the ESKER Max. Tolerance Amount field.';

                    }
                }
            }
        }
    }

    actions
    {
        modify("Vendor Posting Groups")
        {
            CaptionML = ENU = 'Vendor Posting Groups', FRA = 'Groupes compta. fournisseur';
            ToolTipML = ENU = 'Set up the posting groups to select from when you set up vendor cards to link business transactions made for the vendor with the appropriate account in the general ledger.', FRA = 'Paramétrez les groupes comptabilisation parmi lesquels opérer votre sélection lorsque vous définissez les fiches fournisseur pour lier les transactions commerciales effectuées pour le fournisseur au compte général approprié.';
        }
        modify("Incoming Documents Setup")
        {
            CaptionML = ENU = 'Incoming Documents Setup', FRA = 'Paramètres des documents entrants';
            ToolTipML = ENU = 'Set up the journal template that will be used to create general journal lines from electronic external documents, such as invoices from your vendors on email.', FRA = 'Paramétrez le modèle feuille qui est utilisé pour créer des lignes feuille comptabilité à partir de documents électroniques externes, par exemple les factures émises de vos fournisseurs par voie électronique.';
        }
    }

    var

        FooterText: BigText;
        FooterTextInternational: BigText;
        PoLegalText: BigText;
        PoLegatTextInternational: BigText;

        blnCreditMemosEnable: Boolean;

        blnInvoicesEnable: Boolean;

        blnOrdersEnable: Boolean;
        blnQuotesEnable: Boolean;
        MemoReader: InStream;
        MemoReader_1: InStream;
        MemoWriter: OutStream;
        MemoWriter_1: OutStream;
        Text2029610: TextConst ENU = 'Activate Window for:', FRA = 'Activer fenêtre pour:';


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW16.00.00.37 DIT-715 #1
    //<< FINXL7.00.006 KLU 04/10/2013
    blnCreditMemosEnable := true;
    blnInvoicesEnable := true;
    blnOrdersEnable := true;
    blnQuotesEnable := true;
    //>> FINXL7.00.006 KLU 04/10/2013
    // >>DITW16.00.00.37 DIT-715 #1
    */
    //end;


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
    // <<DITW15.00.00.39 DDR 27/04/2011 #1322 (BE5.00.01)
    //<< FINXL7.00.006 KLU 04/10/2013
    fctUpdatePage();
    //>> FINXL7.00.006 KLU 04/10/2013
    // >>DITW15.00.00.39 DDR #1322 (BE5.00.01)
    //HEI.20>>
    CALCFIELDS("PO Legal Text","PO Legal Text International");
    if "PO Legal Text".HASVALUE then begin
      "PO Legal Text".CREATEINSTREAM(MemoReader);
      PoLegalText.READ(MemoReader);
    end;
    if "PO Legal Text International".HASVALUE then begin
      "PO Legal Text International".CREATEINSTREAM(MemoReader);
      PoLegatTextInternational.READ(MemoReader);
    end;
    //HEI.20<<

    //HEI.22 >>
    CALCFIELDS("Footer Text","Footer Text International");
    if "Footer Text".HASVALUE then begin
      "Footer Text".CREATEINSTREAM(MemoReader_1);
      FooterText.READ(MemoReader_1);
    end;
    if "Footer Text International".HASVALUE then begin
      "Footer Text International".CREATEINSTREAM(MemoReader_1);
      FooterTextInternational.READ(MemoReader_1);
    end;
    //HEI.22 <<
    */
    //end;

    procedure fctUpdatePage();
    begin
        //<< FINXL7.00.006 KLU 03/10/2013
        // blnQuotesEnable := "Insert Std. Vend. Purch. Lines" <> "Insert Std. Vend. Purch. Lines"::Manual;
        // blnOrdersEnable := "Insert Std. Vend. Purch. Lines" <> "Insert Std. Vend. Purch. Lines"::Manual;
        // blnInvoicesEnable := "Insert Std. Vend. Purch. Lines" <> "Insert Std. Vend. Purch. Lines"::Manual;
        // blnCreditMemosEnable := "Insert Std. Vend. Purch. Lines" <> "Insert Std. Vend. Purch. Lines"::Manual;  // BC Upgrade NANDIS03
        //>> FINXL7.00.006 KLU 03/10/2013
    end;

    procedure fctGetFolderName(var ptxtArgument: Text[200]; ptxtDialogTitle: Text[200]; ptxtFilter: Text[200]; pblnShowOpen: Boolean);
    begin
        //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144
        //<< DITW18.00.07 AKH 28/03/2016 DIT-770 #1409 Commented code and deleted locxDialogControl variable (Temporary, page is not compiling otherwise)
        /*
        locxDialogControl.MaxFileSize := 2048;
        locxDialogControl.DialogTitle := ptxtDialogTitle;
        locxDialogControl.Filter      := ptxtFilter;
        locxDialogControl.DefaultExt  := '*.';
        locxDialogControl.FileName := ptxtDialogTitle;
        locxDialogControl.InitDir := ptxtDialogTitle;

        IF pblnShowOpen THEN
          locxDialogControl.ShowOpen
        else
          locxDialogControl.ShowSave;

        IF locxDialogControl.FileName <> '' THEN
          ptxtArgument := COPYSTR(locxDialogControl.FileName,1,STRLEN(locxDialogControl.FileName) - STRLEN(locxDialogControl.FileTitle));
        */
        //>> DITW18.00.07 AKH 28/03/2016 DIT-770 #1409
        //>>DITW17.00.02 TEC1 DIT-770 #144

    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

