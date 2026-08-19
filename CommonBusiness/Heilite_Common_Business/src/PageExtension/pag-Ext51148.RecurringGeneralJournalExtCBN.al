pageextension 51148 RecurringGeneralJournalExtCBN extends "Recurring General Journal"
{
    // DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added fields "Service Contract Type","Service Contract No."
    //                                               "Contract Group Code","Building No.","DIT Sub-Contract Type"
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields "item charge type"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01  DefectID 909- IBM HORTOC01 03.11.2017 Add workflow actions
    // HEI.02 CHG2271823 IBM KAPOOV01 08.11.2024 Field to Block/Unblock General Journal templates
    //   #Modified Trigger/Functions- OnInit(),OnAfterGetRecord(),OnAfterGetCurrRecord()
    //   #Modified Enable Property of Various Actions & Action Groups
    //----------------------------------------------------------------------------------------------------------------------------------
    //BC Upgrade Kamnay01
    //HEI.01 In NAV, page 283 – Recurring General Journal called SetControlAppearance twice in OnOpenPage.In BC, subscribed to event OnAfterOnOpenPage of the same page in HeinekenPageCU (subscriber name: OnAfterOnOpenPage_RecurringGenJnl) to call SetControlAppearance once, covering both “opened from batch” and normal selection cases.
    //Hei.02 OnInit code is written in the OnOpen page because in BC we are not able to use it in PageExt.
    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
            ToolTipML = ENU = 'Specifies the batch name on the recurring general journal.', FRA = 'Spécifie le nom de la feuille sur la feuille récurrente.';
        }
        modify("Recurring Method")
        {
            ToolTipML = ENU = 'Specifies a recurring method if the Recurring field of the General Journal Template table indicates the journal is recurring.', FRA = 'Spécifie une méthode récurrente si le champ Récurrence de la table Modèle feuille comptabilité indique que la feuille est récurrente.';
        }
        modify("Recurring Frequency")
        {
            ToolTipML = ENU = 'Specifies a recurring frequency if the Recurring field of the General Journal Template table indicates the journal is recurring.', FRA = 'Spécifie une périodicité de récurrence, si le champ Récurrence de la table Modèle feuille comptabilité indique que la feuille est une feuille récurrente.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date for the entry.', FRA = 'Spécifie la date comptabilisation de l''écriture.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on the document that provides the basis for the entry on the journal line.', FRA = 'Spécifie la date du document qui est utilisé comme document de base pour l''écriture de la ligne feuille.';
        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the type of document that the entry on the journal line is.', FRA = 'Spécifie le type de document auquel appartient l''écriture de la ligne feuille.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies a document number for the journal line.', FRA = 'Spécifie le numéro de document de la ligne feuille.';
        }
        modify("Account Type")
        {
            ToolTipML = ENU = 'Specifies the type of account that the entry on the journal line will be posted to.', FRA = 'Spécifie le type de compte sur lequel l''écriture de la ligne feuille est validée.';
        }
        modify("Account No.")
        {
            ToolTipML = ENU = 'Specifies the account number that the entry on the journal line will be posted to.', FRA = 'Spécifie le numéro de compte sur lequel l''écriture de la ligne feuille est validée.';
        }
        modify("Depreciation Book Code")
        {
            ToolTipML = ENU = 'Specifies the code for the depreciation book to which the line will be posted, if you have selected Fixed Asset in the Account Type field.', FRA = 'Spécifie le code des lois d''amortissement sur lesquelles la ligne sera validée, si vous avez sélectionné Immobilisation dans le champ Type de compte.';
        }
        modify("FA Posting Type")
        {
            ToolTipML = ENU = 'Specifies the FA posting type, if you have selected Fixed Asset in the Account Type field.', FRA = 'Spécifie le type de validation IM, si vous avez sélectionné Immobilisation dans le champ Type compte.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry. The field is automatically filled when the Account No. field is filled.', FRA = 'Spécifie une description de l''écriture. Le champ est automatiquement rempli lorsque le champ N° compte est rempli.';
        }
        modify("Business Unit Code")
        {
            ToolTipML = ENU = 'Specifies the code of the business unit that the entry derives from in a consolidated company.', FRA = 'Spécifie le code du centre de profit duquel provient l''écriture dans une société consolidée.';
        }
        modify("Salespers./Purch. Code")
        {
            ToolTipML = ENU = 'Specifies the salesperson or purchaser who is linked to the journal line.', FRA = 'Spécifie le vendeur ou l''acheteur lié à la ligne feuille.';
        }
        modify("Campaign No.")
        {
            ToolTipML = ENU = 'Specifies the number of the campaign the journal line is linked to.', FRA = 'Spécifie le numéro de la campagne à laquelle la ligne feuille est liée.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the code of the currency for the amounts on the journal line.', FRA = 'Spécifie le code de la devise des montants de la ligne feuille.';
        }
        modify("Gen. Posting Type")
        {
            ToolTipML = ENU = 'Specifies the general posting type that will be used when you post the entry on this journal line.', FRA = 'Spécifie le type validation général qui est utilisé lorsque vous validez l''écriture de cette ligne feuille.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general business posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le groupe comptabilisation marché utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le groupe comptabilisation produit utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the VAT business posting group code that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation marché TVA qui est utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the VAT product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation produit TVA utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the total amount (including VAT) that the journal line consists of.', FRA = 'Spécifie le montant total (TVA incluse) qui constitue la ligne feuille.';
        }
        modify("Debit Amount")
        {
            ToolTipML = ENU = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a debit amount.', FRA = 'Spécifie le montant total (TVA incluse) qui constitue la ligne feuille, s''il s''agit d''un montant débiteur.';
        }
        modify("Credit Amount")
        {
            ToolTipML = ENU = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a credit amount.', FRA = 'Spécifie le montant total (TVA incluse) qui constitue la ligne feuille, s''il s''agit d''un montant crédit.';
        }
        modify("VAT Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of VAT included in the total amount.', FRA = 'Spécifie le montant de TVA incluse dans le montant total.';
        }
        modify("VAT Difference")
        {
            ToolTipML = ENU = 'Specifies the difference between the calculate VAT amount and the VAT amount that you have entered manually.', FRA = 'Spécifie la différence entre le montant TVA calculé et le montant TVA que vous avez entré manuellement.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies the code that represents the payments terms that apply to the entry on the journal line.', FRA = 'Spécifie le code qui représente les conditions de paiement qui s''appliquent à l''écriture de la ligne feuille.';
        }
        modify("Applies-to Doc. Type")
        {
            ToolTipML = ENU = 'Specifies if the journal line will be applied to an already-posted document.', FRA = 'Spécifie si la ligne feuille est lettrée avec un document déjà validé.';
        }
        modify("Applies-to Doc. No.")
        {
            ToolTipML = ENU = 'Specifies if the journal line will be applied to an already-posted document.', FRA = 'Spécifie si la ligne feuille est lettrée avec un document déjà validé.';
        }
        modify("Applies-to ID")
        {
            ToolTipML = ENU = 'Specifies the entries that will be applied to by the journal line if you use the Apply Entries facility.', FRA = 'Spécifie les écritures qui vont être lettrées avec la ligne feuille si vous utilisez l''option Ecr. ouvertes.';
        }
        modify("On Hold")
        {
            ToolTipML = ENU = 'Specifies if the journal line has been invoiced and you execute the payment suggestions batch job, or a finance charge memo or reminder.', FRA = 'Spécifie si la ligne feuille a été facturée et si vous exécutez le traitement par lots de suggestion de paiements, ou bien une facture d''intérêts ou une relance.';
        }
        modify("Bank Payment Type")
        {
            ToolTipML = ENU = 'Specifies the code for the payment type to be used for the entry on the payment journal line.', FRA = 'Spécifie le code du mode de paiement à utiliser pour l''écriture de la ligne feuille paiement.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code that has been entered on the journal lines.', FRA = 'Spécifie le code motif qui a été saisi sur les lignes feuille.';
        }
        modify("Allocated Amt. (LCY)")
        {
            ToolTipML = ENU = 'Specifies the amount that has been allocated when you have used the Allocations function in the Gen. Jnl. Allocation table.', FRA = 'Spécifie le montant qui a été imputé lorsque vous avez utilisé la fonction Affectations de la table Ventilation feuille compta.';
        }
        modify("Bill-to/Pay-to No.")
        {
            ToolTipML = ENU = 'Specifies the address code of the bill-to customer or pay-to vendor that the entry is linked to.', FRA = 'Spécifie le code adresse du client facturé ou du fournisseur à payer auquel l''écriture est liée.';
        }
        modify("Ship-to/Order Address Code")
        {
            ToolTipML = ENU = 'Specifies the address code of the ship-to customer or order-from vendor that the entry is linked to.', FRA = 'Spécifie le code adresse destinataire ou le code adresse de commande auquel l''écriture est liée.';
        }
        modify("Expiration Date")
        {
            ToolTipML = ENU = 'Specifies the last date the recurring journal will be posted, if you have indicated in the journal is recurring.', FRA = 'Spécifie la dernière date à laquelle le journal récurrence sera validé, si vous avez indiqué que la feuille est une feuille récurrente.';
        }
        modify(Comment)
        {
            ToolTipML = ENU = 'Specifies a comment related to registering a payment.', FRA = 'Spécifie un commentaire lié à l''enregistrement d''un paiement.';
        }
        modify("Account Name")
        {
            CaptionML = ENU = 'Account Name', FRA = 'Nom du compte';
        }
        modify(AccName)
        {
            ToolTipML = ENU = 'Specifies the name of the account.', FRA = 'Spécifie le nom du compte.';
        }
        modify(Control1903866901)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
        }
        modify(Balance)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
            ToolTipML = ENU = 'Specifies the balance that has accumulated in the recurring general journal on the line where the cursor is.', FRA = 'Spécifie le solde dans la feuille récurrente sur la ligne où se trouve le pointeur de la souris.';
        }
        modify("Total Balance")
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
        }
        modify(TotalBalance)
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
            ToolTipML = ENU = 'Specifies the total balance in the recurring general journal.', FRA = 'Spécifie le solde final de la feuille récurrente.';
        }
        //BC Update kamnay01>> DITW Fields
        // addafter("VAT Difference")
        // {
        //     field("Contract Type"; Rec."Contract Type")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Service Contract No."; Rec."Service Contract No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Financial Contract No."; Rec."Financial Contract No.")
        //     {
        //         Visible = false;
        //     }
        //     field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
        //     {
        //         Visible = false;
        //     }
        //     field("Contract Group Code"; Rec."Contract Group Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Building No."; Rec."Building No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Item Charge Type"; Rec."Item Charge Type")
        //     {
        //         Visible = false;
        //     }
        // }
        //BC Update kamnay01<< DITW Fields
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Allocations)
        {
            CaptionML = ENU = 'Allocations', FRA = 'Ventilations';
            ToolTipML = ENU = 'Allocate the amount on the selected journal line to the accounts that you specify.', FRA = 'Affecte le montant de la ligne de la feuille sélectionnée aux comptes spécifiés.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("A&ccount")
        {
            CaptionML = ENU = 'A&ccount', FRA = '&Compte';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
            ToolTipML = ENU = 'View or change detailed information about the record that is being processed on the journal line.', FRA = 'Affichez ou modifiez les informations détaillées sur l''enregistrement qui sont traitées sur la ligne feuille.';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the history of transactions that have been posted for the selected record.', FRA = 'Affichez l''historique des transactions qui ont été validées pour l''enregistrement sélectionné.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Insert Conv. LCY Rndg. Lines")
        {
            CaptionML = ENU = 'Insert Conv. LCY Rndg. Lines', FRA = 'Insérer lignes arr. conv. DS';
            ToolTipML = ENU = 'Insert a rounding correction line in the journal. This rounding correction line will balance in LCY when amounts in the foreign currency also balance. You can then post the journal.', FRA = 'Insérez une ligne correction arrondi dans la feuille. Cette ligne correction d''arrondi permet d''équilibrer en devise société lorsque les montants en devise étrangère sont également équilibrés. Vous pouvez alors valider la feuille.';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Preview)
        {
            CaptionML = ENU = 'Preview Posting', FRA = 'Aperçu compta.';
            ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.', FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
            ToolTipML = ENU = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.', FRA = 'Finalisez et préparez-vous à imprimer le document ou la feuille. Les valeurs et les quantités sont validées en fonction des comptes associés. Une fenêtre de demande d''état où vous pouvez spécifier ce qu''il faut inclure sur l''élément à imprimer.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        addafter("A&ccount")
        {
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                CaptionML = ENU = 'Approvals',
                            FRA = 'Approbations';
                Enabled = EnableActnIfTemplateNtBlck;
                Image = Approvals;
                ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.',
                            FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';

                trigger OnAction();
                var
                    GenJournalLine: Record "Gen. Journal Line";
                    ApprovalsMgmt: Codeunit 1535;


                begin
                    GetCurrentlySelectedLines(GenJournalLine);
                    ApprovalsMgmt.ShowJournalApprovalEntries(GenJournalLine);
                end;
            }
        }
        addafter("P&osting")
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Description = 'HEI.02';
                Enabled = EnableActnIfTemplateNtBlck;
                group(SendApprovalRequest)
                {
                    Caption = 'Send Approval Request';
                    Description = 'HEI.02';
                    Image = SendApprovalRequest;
                    action(SendApprovalRequestJournalBatch)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Journal Batch';
                        Description = 'HEI.02';
                        Enabled = NOT OpenApprovalEntriesOnBatchOrAnyJnlLineExist;
                        Image = SendApprovalRequest;
                        ToolTip = 'Send all journal lines for approval, also those that you may not see because of filters.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            ApprovalsMgmt.TrySendJournalBatchApprovalRequest(Rec);
                            SetControlAppearance();
                        end;
                    }
                    action(SendApprovalRequestJournalLine)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Selected Journal Lines';
                        Description = 'HEI.02';
                        Enabled = NOT OpenApprovalEntriesOnBatchOrCurrJnlLineExist;
                        Image = SendApprovalRequest;
                        ToolTip = 'Send selected journal lines for approval.';

                        trigger OnAction();
                        var
                            GenJournalLine: Record "Gen. Journal Line";
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            GetCurrentlySelectedLines(GenJournalLine);
                            ApprovalsMgmt.TrySendJournalLineApprovalRequests(GenJournalLine);
                        end;
                    }
                }
                group(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Request';
                    Description = 'HEI.02';
                    Image = Cancel;
                    action(CancelApprovalRequestJournalBatch)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Journal Batch';
                        Description = 'HEI.02';
                        Enabled = CanCancelApprovalForJnlBatch;
                        Image = CancelApprovalRequest;
                        ToolTip = 'Cancel sending all journal lines for approval, also those that you may not see because of filters.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            ApprovalsMgmt.TryCancelJournalBatchApprovalRequest(Rec);
                            SetControlAppearance();
                        end;
                    }
                    action(CancelApprovalRequestJournalLine)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Selected Journal Lines';
                        Description = 'HEI.02';
                        Enabled = CanCancelApprovalForJnlLine;
                        Image = CancelApprovalRequest;
                        ToolTip = 'Cancel sending selected journal lines for approval.';

                        trigger OnAction();
                        var
                            GenJournalLine: Record "Gen. Journal Line";
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            GetCurrentlySelectedLines(GenJournalLine);
                            ApprovalsMgmt.TryCancelJournalLineApprovalRequests(GenJournalLine);
                        end;
                    }
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                Description = 'HEI.02';
                Enabled = EnableActnIfTemplateNtBlck;
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Description = 'HEI.02';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveGenJournalLineRequest(Rec);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Description = 'HEI.02';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectGenJournalLineRequest(Rec);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Description = 'HEI.02';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category7;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateGenJournalLineRequest(Rec);
                    end;
                }
                // BC Upgrade MISHRS14 >>
                // Renamed action name added s to remove warning action and modify had same name.
                action(Comments)
                // BC Upgrade MISHRS14 <<
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Description = 'HEI.02';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category7;
                    ToolTip = 'View or add comments.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        GenJournalBatch: Record "Gen. Journal Batch";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if OpenApprovalEntriesOnJnlLineExist then
                            ApprovalsMgmt.GetApprovalComment(Rec)
                        else
                            if OpenApprovalEntriesOnJnlBatchExist then
                                if GenJournalBatch.GET(Rec."Journal Template Name", Rec."Journal Batch Name") then
                                    ApprovalsMgmt.GetApprovalComment(GenJournalBatch);
                    end;
                }
            }
        }
    }

    var
        GenJnlTemplate: Record "Gen. Journal Template";
        PayrollManagement: Codeunit "Payroll Management";
        CanCancelApprovalForJnlBatch: Boolean;
        CanCancelApprovalForJnlLine: Boolean;
        EnableActnIfTemplateNtBlck: Boolean;
        ImportPayrollTransactionsAvailable: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist: Boolean;
        OpenApprovalEntriesOnJnlBatchExist: Boolean;
        OpenApprovalEntriesOnJnlLineExist: Boolean;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);
    UpdateBalance;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EnableActnIfTemplateNtBlck := EnableActionIfTemplateNtBlock;  //HEI.02

    // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
    SetFilterSubContractPostType;
    // >>DITW16.00.00.41 AHU DIT-715 #327
    GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);
    UpdateBalance;
    SetControlAppearance;//HEI.01
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EnableActnIfTemplateNtBlck := EnableActionIfTemplateNtBlock;  //HEI.02
    ShowShortcutDimCode(ShortcutDimCode);
    */
    //end;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TotalBalanceVisible := true;
    BalanceVisible := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TotalBalanceVisible := true;
    BalanceVisible := true;
    //HEI.02>>
    CLEAR(EnableActnIfTemplateNtBlck);
    EnableActnIfTemplateNtBlck := true;
    //HEI.02<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if IsOpenedFromBatch then begin
      CurrentJnlBatchName := "Journal Batch Name";
      GenJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
      exit;
    end;
    GenJnlManagement.TemplateSelection(PAGE::"Recurring General Journal",0,true,Rec,JnlSelected);
    if not JnlSelected then
      ERROR('');
    GenJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      SetControlAppearance;//HEI.01
    #4..9
    SetControlAppearance;//HEI.01
    */
    //end;

    procedure SetControlAppearance();
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        //HEI.01>>
        if GenJournalBatch.GET(Rec."Journal Template Name", Rec."Journal Batch Name") then begin
            //ShowWorkflowStatusOnBatch := CurrPage.WorkflowStatusBatch.PAGE.SetFilterOnWorkflowRecord(GenJournalBatch.RECORDID);
            OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(GenJournalBatch.RECORDID);
            OpenApprovalEntriesOnJnlBatchExist := ApprovalsMgmt.HasOpenApprovalEntries(GenJournalBatch.RECORDID);
        end;
        OpenApprovalEntriesExistForCurrUser :=
          OpenApprovalEntriesExistForCurrUser or
          ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);

        OpenApprovalEntriesOnJnlLineExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist := OpenApprovalEntriesOnJnlBatchExist or OpenApprovalEntriesOnJnlLineExist;

        OpenApprovalEntriesOnBatchOrAnyJnlLineExist :=
          OpenApprovalEntriesOnJnlBatchExist or
          ApprovalsMgmt.HasAnyOpenJournalLineApprovalEntries(Rec."Journal Template Name", Rec."Journal Batch Name");

        //ShowWorkflowStatusOnLine := CurrPage.WorkflowStatusLine.PAGE.SetFilterOnWorkflowRecord(RECORDID);

        CanCancelApprovalForJnlBatch := ApprovalsMgmt.CanCancelApprovalForRecord(GenJournalBatch.RECORDID);
        CanCancelApprovalForJnlLine := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);

        SetPayrollAppearance();
        //HEI.01<<
    end;

    procedure GetCurrentlySelectedLines(var GenJournalLine: Record "Gen. Journal Line"): Boolean;
    begin
        //HEI.01>>
        CurrPage.SETSELECTIONFILTER(GenJournalLine);
        exit(GenJournalLine.findset());
        //HEI.01<<
    end;

    procedure SetPayrollAppearance();
    var
        TempPayrollServiceConnection: Record "Service Connection" temporary;
    begin
        //HEI.01>>
        PayrollManagement.OnRegisterPayrollService(TempPayrollServiceConnection);
        ImportPayrollTransactionsAvailable := not TempPayrollServiceConnection.ISEMPTY;
        //HEI.01<<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    //BC Update kamnay01 >> 
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //HEI.02>>  // This code is written in onint in Heilite
        CLEAR(EnableActnIfTemplateNtBlck);
        EnableActnIfTemplateNtBlck := TRUE;
        //HEI.02<<
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance();//HEI.02
        EnableActnIfTemplateNtBlck := Rec.EnableActionIfTemplateNtBlock();  //HEI.01
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        EnableActnIfTemplateNtBlck := Rec.EnableActionIfTemplateNtBlock();  //HEI.02
    end;
    //BC Update kamnay01 <<
}

