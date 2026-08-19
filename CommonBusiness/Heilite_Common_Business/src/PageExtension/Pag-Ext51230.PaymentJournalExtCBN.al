pageextension 51230 PaymentJournalExtCBN extends "Payment Journal"
{
    // version NAVW110.0.00.16177,DITW110.00.11,HEI.09
    /* DITW15.00.00.37 DDR 27/01/2010 issue 1036 Added field "Contract Group Code"
    DITW15.00.00.37 DDR 28/01/2010 issue 879 Added field "Building No."
                        10/05/2010 issue 857 Added field "DIT Sub-Contract Type"
    DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added fields "Service Contract Type","Service Contract No."
    DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields "item charge type"
    DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    DITW17.00.02 AT  17/12/2013 DIT-770 #163 :  Added Posting Group
    DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    DITW17.10.05 WSA 08/08/2014 DIT-770 #761 : Added Action Apply Invoice List
    DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
                                              Rename Field Service contract Type => Contract Type
    DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    DITW110.00.11 MSF 25/08/2017 NRQ#17902 Route settlement - Order Payments, Suggest customer and vendor payments
                                 Deleted Action Suggest Route Settlemen

    HEI.01 PTPGAP066 IBM SOICAD01 29.06.2017 Purchase to Pay– Bank account for payment
      # New field Vendor Bank Account
    HEI.02 PTPGAP029 IBM ISYED01 29.07.2017 Items included in payment proposal
      # Added functionality onDelete trigger to update vendor leddger entry when lines are deleted from Gen. jrnl line
    HEI.03 PTPGAP067 IBM ISYED01 08/09/2017 Purchase To Pay downPayment
      # Added code to create credit not while posting journal
    HEI.04 Defect 626 IBM.HORTOC01 18.10.2017
      # Add modify permission on VLE
    HEI.05 FDD-PTPGAP072 IBM NASTAA02 31.01.2017 # Cashier Order Creation
      # New Page Action created "Print Cashier Order"
    HEI.06 FDD_RW_PTPGAP01 IBM ISYED01 09.12.2018 #Remittance Advice
      # Code addded to post action to send email to Vendor with remittance email.
    HEI.07 V1.05 HT84 IBM POENAB02 01.04.2019
      # Code added in ExportPaymentsToFile - OnAction
      # Code added in ExportProtocolCode - OnValidate
      # New functions added: ExportProtocolCodeOnAfterValid, GetExportProtocol
      # New fields for Bank Connectivity interface
        # "Instruction Priority"
        # "HNK Bank Account"
        # "Customer/Vendor Bank"
    HEI.07 FDD-HT971 IBM POSTOI01 15.01.2020
      # show field WHT Business Posting Group
      # show field WHT Product Posting Group
      # show field WHT Amount
      # show field WHT Amount LCY
    HEI.08 CHG2133239 BHANDS01 11-17-2021
      # Code Commented on Post - OnAction() to resolve compilation error
    HEI.09 CHG2271823 IBM KAPOOV01 08.11.2024 Field to Block/Unblock General Journal templates
      #Modified Trigger/Functions- OnInit(),OnAfterGetRecord(),OnAfterGetCurrRecord()
      #Modified Enable Property of Various Actions & Action Groups */
    // BC Upgrade BHARDA11 >>
    // 1. Remove Drink-IT Fields and related code(("Contract Type","Service Contract No.","Financial Contract No.","DIT Sub-Contract Type","Contract Group Code","Building No.","Item Charge Type")
    // 2. Restructure the code for RemittanceAdvice: Report "Remittance Advice" saveas and download.
    // 3. Blocke Code with tage //HEI.09 because EnableActionIfTemplateNtBlock  mot found.
    // 4. Create new page extension for interfece related code in interface extension.
    // BC Upgrade BHARDA11 <<
    layout
    {
        modify(CurrentJnlBatchName)
        {

            //Unsupported feature: Change Lookup on "CurrentJnlBatchName(Control 33)". Please convert manually.

            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
            ToolTipML = ENU = 'Specifies the batch name on the payment journal.', FRA = 'Spécifie le nom de la feuille paiement.';
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
        modify("Incoming Document Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the incoming document that this general journal line is created for.', FRA = 'Spécifie le numéro du document entrant pour lequel cette ligne feuille comptabilité est créée.';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.', FRA = 'Spécifie un numéro de document qui fait référence au programme de numérotation du client ou du fournisseur.';
        }
        modify("Applies-to Ext. Doc. No.")
        {
            ToolTipML = ENU = 'Specifies the external document number that will be exported in the payment file.', FRA = 'Spécifie le numéro document externe exporté dans le fichier paiement.';
        }
        modify("Account Type")
        {
            ToolTipML = ENU = 'Specifies the type of account that the entry on the journal line will be posted to.', FRA = 'Spécifie le type de compte sur lequel l''écriture de la ligne feuille est validée.';
        }
        modify("Account No.")
        {
            ToolTipML = ENU = 'Specifies the account number that the entry on the journal line will be posted to.', FRA = 'Spécifie le numéro de compte sur lequel l''écriture de la ligne feuille est validée.';
        }
        modify("Recipient Bank Account")
        {
            ToolTipML = ENU = 'Specifies the bank account that the amount will be transferred to after it has been exported from the payment journal.', FRA = 'Indique le compte bancaire sur lequel le montant sera transféré après son exportation depuis la feuille paiement.';
        }
        modify("Message to Recipient")
        {
            ToolTipML = ENU = 'Specifies the message exported to the payment file when you use the Export Payments to File function in the Payment Journal window.', FRA = 'Spécifie le message exporté vers le fichier de paiement lorsque vous utilisez la fonction Exporter les paiements dans un fichier dans la fenêtre Feuille paiement.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry. The field is automatically filled when the Account No. field is filled.', FRA = 'Spécifie une description de l''écriture. Le champ est automatiquement rempli lorsque le champ N° compte est rempli.';
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

            //Unsupported feature: Change AssistEdit on ""Currency Code"(Control 55)". Please convert manually.

            ToolTipML = ENU = 'Specifies the code of the currency for the amounts on the journal line.', FRA = 'Spécifie le code de la devise des montants de la ligne feuille.';
        }
        modify("Gen. Posting Type")
        {
            ToolTipML = ENU = 'Specifies the general posting type that will be used when you post the entry on this journal line.', FRA = 'Spécifie le type validation général qui est utilisé lorsque vous validez l''écriture de cette ligne feuille.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the general business posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code du groupe comptabilisation marché utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the general product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation produit utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the VAT business posting group code that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation marché TVA qui est utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the VAT product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation produit TVA utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Payment Method Code")
        {
            ToolTipML = ENU = 'Specifies the payment method that was used to make the payment that resulted in the entry.', FRA = 'Spécifie le mode de paiement qui a été utilisé pour effectuer le paiement qui a abouti à l''écriture.';
        }
        modify("Payment Reference")
        {
            ToolTipML = ENU = 'Specifies the payment of the purchase invoice.', FRA = 'Spécifie le paiement de la facture achat.';
        }
        modify("Creditor No.")
        {
            ToolTipML = ENU = 'Specifies the vendor who sent the purchase invoice.', FRA = 'Spécifie le fournisseur qui a envoyé la facture achat.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the total amount (including VAT) that the journal line consists of.', FRA = 'Spécifie le montant total (TVA incluse) qui constitue la ligne feuille.';
        }
        modify("Debit Amount")
        {
            ToolTipML = ENU = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a debit amount. The amount must be entered in the currency represented by the currency code on the line.', FRA = 'Indique le montant total (TVA incluse) qui constitue la ligne feuille, s''il s''agit d''un montant débiteur. Le montant doit être saisi dans la devise représentée par le code devise de la ligne.';
        }
        modify("Credit Amount")
        {
            ToolTipML = ENU = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a credit amount. The amount must be entered in the currency represented by the currency code on the line.', FRA = 'Indique le montant total (TVA incluse) qui constitue la ligne feuille, s''il s''agit d''un montant créditeur. Le montant doit être saisi dans la devise représentée par le code devise de la ligne.';
        }
        modify("VAT Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of VAT included in the total amount.', FRA = 'Spécifie le montant de TVA incluse dans le montant total.';
        }
        modify("VAT Difference")
        {
            ToolTipML = ENU = 'Specifies the difference between the calculate VAT amount and the VAT amount that you have entered manually.', FRA = 'Spécifie la différence entre le montant TVA calculé et le montant TVA que vous avez entré manuellement.';
        }
        modify("Bal. VAT Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of Bal. VAT included in the total amount.', FRA = 'Spécifie le montant de TVA contrepartie incluse dans le montant total.';
        }
        modify("Bal. VAT Difference")
        {
            ToolTipML = ENU = 'Specifies the difference between the calculate VAT amount and the VAT amount that you have entered manually.', FRA = 'Spécifie la différence entre le montant TVA calculé et le montant TVA que vous avez entré manuellement.';
        }
        modify("Bal. Account Type")
        {
            ToolTipML = ENU = 'Specifies the code for the balancing account type that should be used in this journal line.', FRA = 'Spécifie le code du type de compte contrepartie à utiliser dans cette ligne feuille.';
        }
        modify("Bal. Account No.")
        {
            ToolTipML = ENU = 'Specifies the number of the general ledger, customer, vendor, or bank account to which a balancing entry for the journal line will posted (for example, a cash account for cash purchases).', FRA = 'Spécifie le numéro du compte général, client, fournisseur ou bancaire sur lequel une écriture contrepartie est insérée pour la ligne feuille (par exemple, un compte caisse pour les achats).';
        }
        modify("Bal. Gen. Posting Type")
        {
            ToolTipML = ENU = 'Specifies the general posting type that will be used when you post the entry on the journal line.', FRA = 'Spécifie le type de validation qui est utilisé lorsque vous validez l''écriture de la ligne feuille.';
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the general business posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code du groupe comptabilisation marché utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the general product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation produit utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Bal. VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the VAT business posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation marché TVA utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Bal. VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the VAT product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation produit TVA utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }

        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[3]"(Control 300)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[4]"(Control 302)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[5]"(Control 304)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[6]"(Control 306)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[7]"(Control 308)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[8]"(Control 310)". Please convert manually.

        modify("Applied (Yes/No)")
        {
            CaptionML = ENU = 'Applied (Yes/No)', FRA = 'Lettré (Oui/Non)';
            ToolTipML = ENU = 'Specifies if the payment has been applied.', FRA = 'Indique si le paiement a été lettré.';
        }
        modify("Applies-to Doc. Type")
        {
            ToolTipML = ENU = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.', FRA = 'Spécifie le type du document validé avec lequel ce document ou cette ligne feuille sera lettré lorsque vous validez, par exemple pour enregistrer un paiement.';
        }
        // modify("Applies-to Doc. No.")
        // {
        //     ToolTipML = ENU = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.', FRA = 'Spécifie le numéro du document validé avec lequel ce document ou cette ligne feuille sera lettré lorsque vous validez, par exemple pour enregistrer un paiement.';
        // }
        modify("Applies-to ID")
        {
            ToolTipML = ENU = 'Specifies the entries that will be applied to by the journal line if you use the Apply Entries facility.', FRA = 'Spécifie les écritures qui vont être lettrées avec la ligne feuille si vous utilisez l''option Ecr. ouvertes.';
        }
        modify(GetAppliesToDocDueDate)
        {
            CaptionML = ENU = 'Applies-to Doc. Due Date', FRA = 'Date d''échéance doc. lettrage';
            ToolTipML = ENU = 'Specifies the due date from the Applies-to Doc. on the journal line.', FRA = 'Spécifie la date d''échéance de Doc. lettrage sur la ligne feuille.';
        }
        modify("Bank Payment Type")
        {
            ToolTipML = ENU = 'Specifies the code for the payment type to be used for the entry on the payment journal line.', FRA = 'Spécifie le code du mode de paiement à utiliser pour l''écriture de la ligne feuille paiement.';
        }
        modify("Check Printed")
        {
            ToolTipML = ENU = 'Specifies whether a check has been printed for the amount on the payment journal line.', FRA = 'Spécifie si un chèque a été imprimé correspondant au montant de la ligne feuille paiement.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code that has been entered on the journal lines.', FRA = 'Spécifie le code motif qui a été saisi sur les lignes feuille.';
        }
        // modify(Comment)
        // {
        //     ToolTipML = ENU = 'Specifies a comment related to registering a payment.', FRA = 'Spécifie un commentaire lié à l''enregistrement d''un paiement.';
        // }
        modify("Exported to Payment File")
        {
            ToolTipML = ENU = 'Specifies that the payment journal line was exported to a payment file.', FRA = 'Indique que la ligne feuille paiement a été exportée vers un fichier de paiement.';
        }
        modify(TotalExportedAmount)
        {

            //Unsupported feature: Change DrillDown on "TotalExportedAmount(Control 28)". Please convert manually.

            CaptionML = ENU = 'Total Exported Amount', FRA = 'Montant total exporté';
            ToolTipML = ENU = 'Specifies the amount for the payment journal line that has been exported to payment files that are not canceled.', FRA = 'Spécifie le montant de la ligne feuille paiement qui a été exporté vers des fichiers de paiement qui ne sont pas annulés.';
        }
        modify("Has Payment Export Error")
        {
            ToolTipML = ENU = 'Specifies that an error occurred when you used the Export Payments to File function in the Payment Journal window.', FRA = 'Indique qu''une erreur s''est produite lorsque vous avez utilisé la fonction Exporter les paiements dans un fichier dans la fenêtre Feuille paiement.';
        }
        // modify(OverdueWarningText)
        // {
        //     ToolTipML = ENU = 'Specifies the text that is displayed for overdue payments.', FRA = 'Indique le texte qui s''affiche pour des Paiements échus.';
        // }
        modify("Account Name")
        {
            CaptionML = ENU = 'Account Name', FRA = 'Nom du compte';
        }
        modify(AccName)
        {
            ToolTipML = ENU = 'Specifies the name of the account.', FRA = 'Spécifie le nom du compte.';
            ShowCaption = false;
            CaptionML = ENU = 'Account', FRA = 'Compte';
        }
        modify("Bal. Account Name")
        {
            CaptionML = ENU = 'Bal. Account Name', FRA = 'Nom du compte contrepartie';
        }
        modify(BalAccName)
        {
            CaptionML = ENU = 'Bal. Account Name', FRA = 'Nom du compte contrepartie';
            ToolTipML = ENU = 'Specifies the name of the balancing account that has been entered on the journal line.', FRA = 'Indique le nom du compte contrepartie qui a été saisi sur la ligne feuille où se trouve le pointeur de la souris.';
        }
        modify(Control1900545401)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
        }
        modify(Balance)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
            ToolTipML = ENU = 'Specifies the balance that has accumulated in the payment journal on the line where the cursor is.', FRA = 'Indique le solde du document dans la feuille paiement sur la ligne où se trouve le pointeur de la souris.';
        }
        modify("Total Balance")
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
        }
        modify(TotalBalance)
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
            ToolTipML = ENU = 'Specifies the total balance in the payment journal.', FRA = 'Indique le solde final de la feuille paiement.';
        }

        //Unsupported feature: Change PagePartID on "IncomingDocAttachFactBox(Control 30)". Please convert manually.


        //Unsupported feature: Change ShowFilter on "IncomingDocAttachFactBox(Control 30)". Please convert manually.

        modify("Payment File Errors")
        {
            CaptionML = ENU = 'Payment File Errors', FRA = 'Erreurs fichier de paiement';

            //Unsupported feature: Change SubPageLink on ""Payment File Errors"(Control 7)". Please convert manually.


            //Unsupported feature: Change PagePartID on ""Payment File Errors"(Control 7)". Please convert manually.

        }

        //Unsupported feature: Change SubPageLink on "Control1900919607(Control 1900919607)". Please convert manually.


        //Unsupported feature: Change PagePartID on "Control1900919607(Control 1900919607)". Please convert manually.

        modify(WorkflowStatusBatch)
        {
            CaptionML = ENU = 'Batch Workflows', FRA = 'Flux de travail par lots';

            //Unsupported feature: Change PagePartID on "WorkflowStatusBatch(Control 88)". Please convert manually.


            //Unsupported feature: Change ShowFilter on "WorkflowStatusBatch(Control 88)". Please convert manually.

        }
        modify(WorkflowStatusLine)
        {
            CaptionML = ENU = 'Line Workflows', FRA = 'Flux de travail ligne';

            //Unsupported feature: Change PagePartID on "WorkflowStatusLine(Control 44)". Please convert manually.


            //Unsupported feature: Change ShowFilter on "WorkflowStatusLine(Control 44)". Please convert manually.

        }

        addfirst(Control1)
        {
            field("Skip WHT"; Rec."Skip WHT FND")
            {
                ApplicationArea = All;
            }
        }
        addafter("Account No.")
        {
            field("<Account No.>"; Rec."Vendor Bank Account FND")
            {
                ApplicationArea = All;
            }
        }
        addafter("Campaign No.")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields(("Contract Type","Service Contract No.","Financial Contract No."))
            // field("Contract Type"; Rec."Contract Type")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Service Contract No."; Rec."Service Contract No.")
            // {
            //     Visible = false;
            // }
            // field("Financial Contract No."; Rec."Financial Contract No.")
            // {
            //     Visible = false;
            // }
            // BC Upgrade BHARAD11 << ----Drink-IT Fields("Contract Type","Service Contract No.","Financial Contract No.")
            field("Posting Group1"; Rec."Posting Group")
            {
                ApplicationArea = All;
                Visible = false;
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields(("DIT Sub-Contract Type","Contract Group Code","Building No.","Item Charge Type"))
            // field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
            // {
            //     Visible = false;
            // }
            // field("Contract Group Code"; Rec."Contract Group Code")
            // {
            //     Visible = false;
            // }
            // field("Building No."; Rec."Building No.")
            // {
            //     Visible = false;
            // }
            // field("Item Charge Type"; Rec."Item Charge Type")
            // {
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields(("DIT Sub-Contract Type","Contract Group Code","Building No.","Item Charge Type"))
        }
        addafter("Has Payment Export Error")
        {
            field("Vendor Bank Account"; Rec."Vendor Bank Account FND")
            {
                ApplicationArea = All;
            }
            field("Instruction Priority"; Rec."Instruction Priority FND")
            {
                ApplicationArea = All;
            }
            field("HNK Bank Account"; Rec."HNK Bank Account FND")
            {
                ApplicationArea = All;
            }
            field("Customer/Vendor Bank"; Rec."Customer/Vendor Bank FND")
            {
                ApplicationArea = All;
            }
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
            {
                ApplicationArea = All;
            }
            field("WHT Product Posting Group"; Rec."WHT Product Posting Group FND")
            {
                ApplicationArea = All;
            }
            field("WHT Amount"; Rec."WHT Amount FND")
            {
                ApplicationArea = All;
            }
            field("WHT Amount (LCY)"; Rec."WHT Amount (LCY) FND")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(SuggestVendorPayments)
        {
            action(SuggestVendorPayments1)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                Caption = 'Suggest Vendor Payments';
                Ellipsis = true;
                Image = SuggestVendorPayments;
                ToolTip = 'Create payment suggestions as lines in the payment journal.';

                trigger OnAction()
                var
                    SuggestVendorPayments: Report "Suggest Vendor Payments Hei";
                    IsHandled: Boolean;
                begin
                    // IsHandled := false;
                    // OnBeforeSuggestVendorPaymentsAction(Rec, IsHandled);
                    // if IsHandled then
                    //     exit;
                    Clear(SuggestVendorPayments);
                    SuggestVendorPayments.SetGenJnlLine(Rec);
                    SuggestVendorPayments.RunModal();
                end;
            }
            action(ShowSuggestVendorPaymentsFilters)
            {
                ApplicationArea = All;
                Ellipsis = true;
                CaptionML = ENU = 'Show Suggest Vendor Payments Filters';
                Promoted = true;
                Enabled = EnableActnIfTemplateNtBlck;
                PromotedIsBig = true;
                Image = ShowSelected;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    SuggestVendorPayments: Report "Suggest Vendor Payments";
                    SuggestPaymentVendors: Codeunit "Suggest Vendor Payments CBN";
                    GenJournalBatch: Record "Gen. Journal Batch";
                    GenJournalLine2: Record "Gen. Journal Line";
                begin
                    //HEI.08>>
                    GenJournalBatch.GET(Rec."Journal Template Name", Rec."Journal Batch Name");
                    SuggestPaymentVendors.ShowParam(TRUE);
                    SuggestPaymentVendors.RUN(GenJournalBatch)
                    //HEI.08<<
                end;
            }
        }

        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Dimensions)
        {

            //Unsupported feature: Change AccessByPermission on "Dimensions(Action 58)". Please convert manually.

            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
            Promoted = true;
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(IncomingDoc)
        {
            //Unsupported feature: Change AccessByPermission on "IncomingDoc(Action 92)". Please convert manually.

            CaptionML = ENU = 'Incoming Document', FRA = 'Document entrant';
            ToolTipML = ENU = 'View or create an incoming document record that is linked to the entry or document.', FRA = 'Affichez ou créez un enregistrement de document entrant qui est lié à l''écriture ou au document.';
            Promoted = true;
            Enabled = EnableActnIfTemplateNtBlck;
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

            //Unsupported feature: Change RunObject on "Card(Action 38)". Please convert manually.

        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the history of transactions that have been posted for the selected record.', FRA = 'Affichez l''historique des transactions qui ont été validées pour l''enregistrement sélectionné.';

            //Unsupported feature: Change RunObject on ""Ledger E&ntries"(Action 39)". Please convert manually.

            Promoted = false;
        }
        modify("&Payments")
        {
            CaptionML = ENU = '&Payments', FRA = '&Paiements';
            // Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(SuggestVendorPayments)
        {

            //Unsupported feature: Change Ellipsis on "SuggestVendorPayments(Action 42)". Please convert manually.

            CaptionML = ENU = 'Suggest Vendor Payments', FRA = 'Proposer paiements fournisseur';
            ToolTipML = ENU = 'Create payment suggestion as lines in the payment journal.', FRA = 'Créez une proposition de paiement en tant que lignes dans la feuille paiement.';
            Promoted = true;
            Visible = false;
            // Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(PreviewCheck)
        {
            CaptionML = ENU = 'P&review Check', FRA = 'Ap&erçu chèque';
            ToolTipML = ENU = 'Preview the check before printing it.', FRA = 'Aperçu du chèque avant de l''imprimer.';

            //Unsupported feature: Change RunObject on "PreviewCheck(Action 63)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "PreviewCheck(Action 63)". Please convert manually.

        }
        modify(PrintCheck)
        {

            //Unsupported feature: Change AccessByPermission on "PrintCheck(Action 64)". Please convert manually.


            //Unsupported feature: Change Ellipsis on "PrintCheck(Action 64)". Please convert manually.

            CaptionML = ENU = 'Print Check', FRA = 'Imprimer chèque';
            ToolTipML = ENU = 'Prepare to print the check.', FRA = 'Préparez-vous à imprimer le chèque.';
            Promoted = true;
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Void Check")
        {
            CaptionML = ENU = 'Void Check', FRA = 'Annuler chèque';
            ToolTipML = ENU = 'Void the check if, for example, the check is not cashed by the bank.', FRA = 'Annulez le chèque si, par exemple, le chèque n''est pas encaissé par la banque.';
            Promoted = true;
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Void &All Checks")
        {
            CaptionML = ENU = 'Void &All Checks', FRA = '&Annuler tous les chèques';
            ToolTipML = ENU = 'Void all checks if, for example, the checks are not cashed by the bank.', FRA = 'Annulez tous les chèques si, par exemple, les chèques ne sont pas encaissés par la banque.';
        }
        modify(CreditTransferRegEntries)
        {
            CaptionML = ENU = 'Credit Transfer Reg. Entries', FRA = 'Écritures reg. virement';
            ToolTipML = ENU = 'View or edit the credit transfer entries that are related to file export for credit transfers.', FRA = 'Affichez ou modifiez les écritures de virement qui sont liées à l''exportation de fichiers pour les virements.';

            //Unsupported feature: Change RunObject on "CreditTransferRegEntries(Action 26)". Please convert manually.

            Promoted = true;
            PromotedIsBig = true;
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(CreditTransferRegisters)
        {
            CaptionML = ENU = 'Credit Transfer Registers', FRA = 'Registres virement';
            ToolTipML = ENU = 'View or edit the payment files that have been exported in connection with credit transfers.', FRA = 'Affichez ou modifiez les fichiers paiement qui ont été exportés dans le cadre de virements.';

            //Unsupported feature: Change RunObject on "CreditTransferRegisters(Action 23)". Please convert manually.

            Promoted = true;
            PromotedIsBig = true;
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Approvals)
        {

            //Unsupported feature: Change AccessByPermission on "Approvals(Action 54)". Please convert manually.

            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Renumber Document Numbers")
        {
            CaptionML = ENU = 'Renumber Document Numbers', FRA = 'Renuméroter des documents';
            ToolTipML = ENU = 'Resort the numbers in the Document No. column to avoid posting errors because the document numbers are not in sequence. Entry applications and line groupings are preserved.', FRA = 'Réaffectez les priorités des numéros dans la colonne N° document pour éviter les erreurs de validation dues au fait que les numéros de document ne sont pas dans l''ordre. Le lettrage des écritures et les groupements de lignes sont préservés.';
        }
        modify(ApplyEntries)
        {

            //Unsupported feature: Change Ellipsis on "ApplyEntries(Action 93)". Please convert manually.

            CaptionML = ENU = 'Apply Entries', FRA = 'Lettrer écritures';
            ToolTipML = ENU = 'Select one or more ledger entries that you want to apply this record to so that the related posted documents are closed as paid or refunded.', FRA = 'Sélectionnez une ou plusieurs écritures comptables que vous voulez lettrer avec cet enregistrement afin que les documents validés concernés soient fermés comme étant payés ou remboursés.';

            //Unsupported feature: Change RunObject on "ApplyEntries(Action 93)". Please convert manually.

            Promoted = true;
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(ExportPaymentsToFile)
        {
            Visible = false;

            //Unsupported feature: Change Ellipsis on "ExportPaymentsToFile(Action 15)". Please convert manually.

            CaptionML = ENU = 'Export Payments to File', FRA = 'Exporter les paiements dans un fichier';
            ToolTipML = ENU = 'Export a file with the payment information on the journal lines.', FRA = 'Exportez un fichier avec les informations sur le paiement vers la feuille.';
            Promoted = true;
            PromotedIsBig = true;
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(CalculatePostingDate)
        {
            CaptionML = ENU = 'Calculate Posting Date', FRA = 'Calculer date comptabilisation';
            ToolTipML = ENU = 'Calculate the date that will appear as the posting date on the journal lines.', FRA = 'Calculez la date qui apparaîtra en tant que date comptabilisation sur les lignes feuille.';
            Promoted = true;
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Insert Conv. LCY Rndg. Lines")
        {
            CaptionML = ENU = 'Insert Conv. LCY Rndg. Lines', FRA = 'Insérer lignes arr. conv. DS';
            ToolTipML = ENU = 'Insert a rounding correction line in the journal. This rounding correction line will balance in LCY when amounts in the foreign currency also balance. You can then post the journal.', FRA = 'Insérez une ligne correction arrondi dans la feuille. Cette ligne correction d''arrondi permet d''équilibrer en devise société lorsque les montants en devise étrangère sont également équilibrés. Vous pouvez alors valider la feuille.';

            //Unsupported feature: Change RunObject on ""Insert Conv. LCY Rndg. Lines"(Action 94)". Please convert manually.

        }
        modify(PositivePayExport)
        {
            CaptionML = ENU = 'Positive Pay Export', FRA = 'Exportation Positive Pay';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Reconcile)
        {
            CaptionML = ENU = 'Reconcile', FRA = 'Simuler';
            ToolTipML = ENU = 'View the balances on bank accounts that are marked for reconciliation, usually liquid accounts.', FRA = 'Affichez les soldes des comptes bancaires qui sont destinés au rapprochement, en général des comptes de liquidités.';
            Promoted = true;
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(PreCheck)
        {
            CaptionML = ENU = 'Vendor Pre-Payment Journal', FRA = 'Feuille acompte fournisseur';
            ToolTipML = ENU = 'View journal line entries, payment discounts, discount tolerance amounts, payment tolerance, and any errors associated with the entries. You can use the results of the report to review payment journal lines and to review the results of posting before you actually post.', FRA = 'Affichez les écritures ligne feuille, les escomptes, les montants de l''écart d''escompte, l''écart de règlement et toute erreur associée aux écritures. Vous pouvez utiliser les résultats de l''état pour examiner les lignes feuille paiement ainsi que les résultats de la validation avant la validation effective.';
        }
        modify("Test Report")
        {

            //Unsupported feature: Change Ellipsis on ""Test Report"(Action 45)". Please convert manually.

            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify(Post)
        {
            Visible = false;
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';
            // Promoted = true;
            // PromotedIsBig = true;
            Enabled = EnableActnIfTemplateNtBlck;
        }

        addafter(PreviewCheck)
        {
            action(CashierOrder)
            {
                ApplicationArea = All;
                Ellipsis = true;
                CaptionML = ENU = 'Print Cashier Order';
                Description = 'HEI.05';
                Promoted = true;
                Enabled = EnableActnIfTemplateNtBlck;
                Image = Report;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    GeneralJournalLine2: Record "Gen. Journal Line";
                    GenJournalBatch2: Record "Gen. Journal Batch";
                begin
                    //HEI.05>>
                    IF GenJournalBatch2.GET(Rec."Journal Template Name", Rec."Journal Batch Name") THEN;
                    GeneralJournalLine2.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    GeneralJournalLine2.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    GeneralJournalLine2.SETRANGE("Line No.", Rec."Line No.");
                    REPORT.RUNMODAL(GenJournalBatch2."Cashier Order Report ID FND", TRUE, TRUE, GeneralJournalLine2);
                    //HEI.05<<
                end;
            }
        }
        addafter("Test Report")
        {
            action(Post1)
            {
                Image = PostOrder;
                ShortCutKey = 'F9';
                ApplicationArea = All;
                CaptionML = ENU = 'P&ost', FRA = '&Valider';
                ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';
                Promoted = true;
                PromotedIsBig = true;
                Enabled = EnableActnIfTemplateNtBlck;
                trigger OnAction()
                var
                    TempBlob: Codeunit "Temp Blob";
                    InsStream: InStream;
                    OutStr: OutStream;
                    FileName: Text;
                    ToFile: Variant;
                begin
                    //HEI.06>>
                    //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",Rec); //old code

                    //TempGJNL := Rec;
                    TempGJNL.DELETEALL;
                    IF Rec.FINDSET THEN BEGIN
                        REPEAT
                            TempGJNL.INIT;
                            TempGJNL.COPY(Rec);
                            TempGJNL.INSERT;
                        UNTIL Rec.NEXT = 0;
                    END;

                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", Rec);
                    COMMIT;
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name", TempGJNL."Journal Template Name");
                    GenJournalLine.SETRANGE("Journal Batch Name", TempGJNL."Journal Batch Name");
                    GenJournalLine.SETRANGE("Document Type", TempGJNL."Document Type");
                    GenJournalLine.SETFILTER("Account No.", '<>%1', '');
                    IF GenJournalLine.ISEMPTY THEN
                        IF TempGJNL.FINDSET THEN BEGIN
                            //HeinekenGlobal.SendRemittanceAsPDF(TempGJNL);

                            //******************************** working code **************************************//
                            CompanyInformation.GET();
                            // ServerAttachmentFilePath := COPYSTR(FileManagement.ServerTempFileName('pdf'), 1, 250); // BC Upgrade BHARDA11 ::Blocked
                            // BC Upgrade BHARAD11 >> ---Restructure the Code
                            FileName := 'RemittanceAdvice' + 'pdf';
                            CLEAR(RemittanceAdvice);
                            RemittanceAdvice.SetFilterGNL(TempGJNL);
                            TempBlob.CreateOutStream(OutStr);
                            RemittanceAdvice.SaveAs('', ReportFormat::Pdf, OutStr);
                            TempBlob.CreateInStream(InsStream);
                            ToFile := FileName;
                            DownloadFromStream(InsStream, '', '', '', ToFile);
                            // BC Upgrade BHARAD11 << ---Restructure the Code
                            // RemittanceAdvice.SAVEASPDF(ServerAttachmentFilePath); // BC Upgrade BHARDA11 ::Blocked
                            // HEI.08 >>
                            //    IF TempGJNL."Account Type" = TempGJNL."Account Type"::Vendor THEN
                            //          BEGIN
                            //      IF TempGJNL."Account No." <>'' THEN
                            //       IF Vendor.GET(TempGJNL."Account No.") THEN
                            //              IF Vendor."Remittance Email" <> '' THEN
                            //                  SendRemittanceEmail := TRUE;
                            //          END;

                            //          IF  SendRemittanceEmail THEN
                            //            BEGIN
                            //              CompanyInformation.TESTFIELD("E-Mail");
                            //              SMTPMailSetup.GET;
                            //              SMTPMail.CreateMessage(
                            //                '',
                            //                CompanyInformation."E-Mail",
                            //                Vendor."Remittance Email",
                            //                TestMailTitleTxt,
                            //                STRSUBSTNO(
                            //                  TestMailBodyTxt,
                            //                  Vendor.Name,CompanyInformation.Name),
                            //                TRUE);
                            //              SMTPMail.AddAttachment(ServerAttachmentFilePath,'Payment Remittance Advice.'+ FORMAT(WORKDATE)+'.PDF');
                            //              SMTPMail.Send;
                            //              MESSAGE(TestMailSuccessMsg,Vendor."Remittance Email");
                            //            END;
                            // HEI.08 <<

                            //******************************** working code **************************************//
                        END;
                    //HEI.06<<

                    CurrPage.UPDATE(TRUE);
                    CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                    CurrPage.UPDATE(FALSE);

                end;
            }
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
            Promoted = true;
            PromotedIsBig = true;
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Request Approval")
        {
            CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send Approval Request', FRA = 'Envoyer demande d''approbation';
        }
        modify(SendApprovalRequestJournalBatch)
        {
            CaptionML = ENU = 'Journal Batch', FRA = 'Feuille';
            ToolTipML = ENU = 'Send all journal lines for approval, also those that you may not see because of filters.', FRA = 'Envoyez toutes les lignes feuilles pour approbation, y compris celles que vous ne voyez peut-être pas à cause de filtres.';
        }
        modify(SendApprovalRequestJournalLine)
        {
            CaptionML = ENU = 'Selected Journal Lines', FRA = 'Lignes feuille sélectionnées';
            ToolTipML = ENU = 'Send selected journal lines for approval.', FRA = 'Envoyez certaines lignes feuille pour approbation.';
        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Request', FRA = 'Annuler demande d''approbation';
        }
        modify(CancelApprovalRequestJournalBatch)
        {
            CaptionML = ENU = 'Journal Batch', FRA = 'Feuille';
            ToolTipML = ENU = 'Cancel sending all journal lines for approval, also those that you may not see because of filters.', FRA = 'Annulez l''envoi de toutes les lignes feuilles pour approbation, y compris celles que vous ne voyez peut-être pas à cause de filtres.';
        }
        modify(CancelApprovalRequestJournalLine)
        {
            CaptionML = ENU = 'Selected Journal Lines', FRA = 'Lignes feuille sélectionnées';
            ToolTipML = ENU = 'Cancel sending selected journal lines for approval.', FRA = 'Annulez l''envoi de certaines lignes feuilles pour approbation.';
        }
        modify(Workflow)
        {
            CaptionML = ENU = 'Workflow', FRA = 'Flux de travail';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(CreateApprovalWorkflow)
        {
            CaptionML = ENU = 'Create Approval Workflow', FRA = 'Créer flux de travail approbation';
            ToolTipML = ENU = 'Set up an approval workflow for payment journal lines, by going through a few pages that will guide you.', FRA = 'Configurez un flux de travail approbation pour des lignes feuille paiement en consultant quelques pages qui vous guideront.';
        }
        modify(ManageApprovalWorkflows)
        {
            CaptionML = ENU = 'Manage Approval Workflows', FRA = 'Gérer les flux de travail approbation';
            ToolTipML = ENU = 'View or edit existing approval workflows for payment journal lines.', FRA = 'Affichez ou modifiez des flux de travail approbation pour des lignes feuille paiement.';
        }
        modify(Approval)
        {
            CaptionML = ENU = 'Approval', FRA = 'Approbation';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Approve)
        {
            CaptionML = ENU = 'Approve', FRA = 'Approuver';
            ToolTipML = ENU = 'Approve the requested changes.', FRA = 'Approuvez les modifications requises.';
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Reject)
        {
            CaptionML = ENU = 'Reject', FRA = 'Rejeter';
            ToolTipML = ENU = 'Reject the approval request.', FRA = 'Rejetez la demande d''approbation.';
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Delegate)
        {
            CaptionML = ENU = 'Delegate', FRA = 'Déléguer';
            ToolTipML = ENU = 'Delegate the approval to a substitute approver.', FRA = 'Déléguez l''approbation à un approbateur remplaçant.';
            Promoted = true;
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comments', FRA = 'Commentaires';
            ToolTipML = ENU = 'View or add comments.', FRA = 'Affichez ou ajoutez des commentaires.';
            Promoted = true;
        }


    }
    trigger OnOpenPage()
    begin
        //HEI.09>>
        CLEAR(EnableActnIfTemplateNtBlck);
        EnableActnIfTemplateNtBlck := TRUE;
        //HEI.09<<
    end;

    trigger OnDeleteRecord(): Boolean
    var
        TempGenJournalLine: Record "Gen. Journal Line" temporary;
        foundRec: Boolean;
        VendorLedgerEntry_G: Record "Vendor Ledger Entry";
    begin
        //HEI.02>>
        //GetCurrentlySelectedLines(Rec);
        CurrPage.SETSELECTIONFILTER(GenJournalLine);
        //HeinekenGlobal.UpdatePaymentProposal4MGenJnlLine(GenJournalLine);
        IF GenJournalLine.FINDSET THEN
            //HeinekenGlobal.UpdatePaymentProposal4MGenJnlLine(GenJournalLine);
            //IF GenJournalLine.FINDSET THEN BEGIN
            IF GenJournalLine."Applies-to Doc. No." <> '' THEN
                VendorLedgerEntry_G.SETRANGE("Document No.", GenJournalLine."Applies-to Doc. No.")
            ELSE
                VendorLedgerEntry_G.SETRANGE("Document No.", GenJournalLine."Document No.");
        IF VendorLedgerEntry_G.FINDSET() THEN BEGIN
            REPEAT
                //IF VendorLedgerEntry_G.Open THEN BEGIN
                //     VendorLedgerEntry_G.VALIDATE("Batch payment name",'');
                VendorLedgerEntry_G."Batch payment name FND" := '';
                foundRec := TRUE;
            // END;
            UNTIL VendorLedgerEntry_G.NEXT() = 0;
        END;
        IF foundRec THEN
            VendorLedgerEntry_G.MODIFY();
        //END;
        //HEI.02<<
    end;

    trigger OnAfterGetRecord()
    begin
        EnableActnIfTemplateNtBlck := Rec.EnableActionIfTemplateNtBlock;   //HEI.09
    end;

    trigger OnAfterGetCurrRecord()
    begin
        EnableActnIfTemplateNtBlck := Rec.EnableActionIfTemplateNtBlock;   //HEI.09 
    end;

    PROCEDURE GetExportProtocol();
    BEGIN
        //HEI.07>>
        IF ExportProtocolCode = '' THEN
            ERROR(Text001);
        ExportProtocol.GET(ExportProtocolCode);
        //HEI.07<<
    END;

    LOCAL PROCEDURE ExportProtocolCodeOnAfterValid();
    BEGIN
        //HEI.07>>
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Export Protocol Code FND", ExportProtocolCode);
        Rec.FILTERGROUP(0);
        CurrPage.UPDATE(FALSE);
        //HEI.07<<
    END;

    var
        Text001: Label 'ENU=Void all printed checks?;FRA=Souhaitez-vous annuler tous les chŠques imprim‚s ?';
        GenJournalLine: Record "Gen. Journal Line";
        HeinekenGlobal: Codeunit "Heineken Global";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        TestMailSuccessMsg: Label '@@@="{Locked=""SMTP""} %1 is an email address.";ENU=Remittance email has been sent to ''%1'' .\Check your email for messages to make sure that the email was delivered successfully.;FRA=L''e-mail test a ‚t‚ envoy‚ … ®ÿ%1ÿ¯ en fonction des paramŠtres SMTP actuels.\Contr“lez vos messages pour v‚rifier que vous avez bien re‡u cet e-mail.';
        TestMailBodyTxt: Label 'ENU=Dear %1 <br><br> Please find attached your payment Remittance Advice. <br><Br> Best Regards, <br><Br> %2 <br><Br>';
        TestMailTitleTxt: Label 'ENU=Payment Remittance Advice.';
        TempGJNL: Record "Gen. Journal Line" temporary;
        TempGJNL1: Record "Gen. Journal Line" TEMPORARY;
        // SMTPMailSetup: Record 409;
        // SMTPMail: Codeunit 400;
        vendor: Record Vendor;
        CompanyInformation: Record "Company Information";
        ServerAttachmentFilePath: Text[1024];
        FileManagement: Codeunit "File Management";
        GenJournalLine2: Record "Gen. Journal Line";
        SendRemittanceEmail: Boolean;
        RemittanceAdvice: Report "Remittance Advice CBN";
        Text50000: Label 'ENU=Please verify Bank Export/Import Setup!';
        Text50001: Label 'ENU=Please verify Bank Export/Import Setup! Journal Template Name and Journal Batch Name cannot be blank!';
        ExportProtocolCode: Code[20];
        ExportProtocol: Record "Export Protocol FND";
        EnableActnIfTemplateNtBlck: Boolean;

}
