pageextension 51167 PurchaseJournalExtCBN extends "Purchase Journal"
{
    // HEI.01 PTPGAP066 IBM SOICAD01 29.06.2017 Purchase to Pay– Bank account for payment
    //   # New field Vendor Bank Account
    // HEI.02 CHG2271823 IBM KAPOOV01 08.11.2024 Field to Block/Unblock General Journal templates
    //   #Modified Trigger/Functions- OnInit(),OnAfterGetRecord(),OnAfterGetCurrRecord()
    //   #Modified Enable Property of Various Actions & Action Groups
    //----------------------------------------------------------------------------------------------------
    //BC Upgrade SHARMP16 ----- Custom code added.
    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
            ToolTipML = ENU = 'Specifies the batch name on the purchase journal.', FRA = 'Spécifie le nom de la feuille achat.';
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
        modify("Account Type")
        {
            ToolTipML = ENU = 'Specifies the type of account that the entry on the journal line will be posted to.', FRA = 'Spécifie le type de compte sur lequel l''écriture de la ligne feuille est validée.';
        }
        modify("Account No.")
        {
            ToolTipML = ENU = 'Specifies the account number that the entry on the journal line will be posted to.', FRA = 'Spécifie le numéro de compte sur lequel l''écriture de la ligne feuille est validée.';
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
            ToolTipML = ENU = 'Specifies the code of the currency for the amounts on the journal line.', FRA = 'Spécifie le code de la devise des montants de la ligne feuille.';
        }
        modify("Gen. Posting Type")
        {
            ToolTipML = ENU = 'Specifies the general posting type that will be used when you post the entry on this journal line.', FRA = 'Spécifie le type validation général qui est utilisé lorsque vous validez l''écriture de cette ligne feuille.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the vendor''s trade type to link transactions made for this vendor with the appropriate general ledger account according to the general posting setup.', FRA = 'Spécifie le type commercial du fournisseur pour lier les transactions effectuées pour ce fournisseur au compte général approprié en fonction des paramètres de validation généraux.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the vendor''s product type to link transactions made for this vendor with the appropriate general ledger account according to the general posting setup.', FRA = 'Spécifie le type de produit du fournisseur pour lier les transactions effectuées pour ce fournisseur au compte général approprié en fonction des paramètres de validation généraux.';
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
            ToolTipML = ENU = 'Specifies the general posting type associated with the balancing account that will be used when you post the entry on the journal line.', FRA = 'Spécifie le type de validation associé au compte contrepartie qui est utilisé lorsque vous validez l''écriture sur cette ligne feuille.';
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general business posting group code associated with the balancing account that will be used when you post the entry.', FRA = 'Spécifie le code groupe comptabilisation marché associé au compte contrepartie qui est utilisé lorsque vous validez l''écriture sur cette ligne feuille.';
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general product posting group code associated with the balancing account that will be used when you post the entry.', FRA = 'Spécifie le code groupe comptabilisation produit associé au compte contrepartie qui est utilisé lorsque vous validez l''écriture sur cette ligne feuille.';
        }
        modify("Bal. VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the VAT business posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation marché TVA utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Bal. VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the VAT product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation produit TVA utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Bill-to/Pay-to No.")
        {
            ToolTipML = ENU = 'Specifies the address code of the bill-to customer or pay-to vendor that the entry is linked to.', FRA = 'Spécifie le code adresse du client facturé ou du fournisseur à payer auquel l''écriture est liée.';
        }
        modify("Ship-to/Order Address Code")
        {
            ToolTipML = ENU = 'Specifies the address code of the ship-to customer or order-from vendor that the entry is linked to.', FRA = 'Spécifie le code adresse destinataire ou le code adresse de commande auquel l''écriture est liée.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        modify("Sales/Purch. (LCY)")
        {
            ToolTipML = ENU = 'Specifies the line''s net amount (the amount excluding VAT) if you are using this journal line for an invoice.', FRA = 'Indique le montant net de la ligne (le montant sans la TVA) dans ce champ si vous utilisez cette feuille pour une facture.';
        }
        modify("Inv. Discount (LCY)")
        {
            ToolTipML = ENU = 'Specifies the amount of the invoice discount if you are using this journal line for an invoice.', FRA = 'Indique le montant de la remise facture si vous utilisez cette ligne feuille pour une facture.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies the code that represents the payments terms that apply to the entry on the journal line.', FRA = 'Spécifie le code qui représente les conditions de paiement qui s''appliquent à l''écriture de la ligne feuille.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies the due date on the entry.', FRA = 'Spécifie la date d''échéance de l''écriture.';
        }
        modify("Pmt. Discount Date")
        {
            ToolTipML = ENU = 'Specifies the last date on which the amount in the journal line must be paid for the order to qualify for a payment discount.', FRA = 'Spécifie la dernière date à laquelle le montant de la ligne feuille doit être payé pour que la commande puisse faire l''objet d''un escompte.';
        }
        modify("Payment Discount %")
        {
            ToolTipML = ENU = 'Specifies the possible payment discount percentage for the journal line.', FRA = 'Spécifie le pourcentage d''escompte possible pour la ligne feuille.';
        }
        modify("Applies-to Doc. Type")
        {
            ToolTipML = ENU = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.', FRA = 'Spécifie le type du document validé avec lequel ce document ou cette ligne feuille sera lettré lorsque vous validez, par exemple pour enregistrer un paiement.';
        }
        modify("Applies-to Doc. No.")
        {
            ToolTipML = ENU = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.', FRA = 'Spécifie le numéro du document validé avec lequel ce document ou cette ligne feuille sera lettré lorsque vous validez, par exemple pour enregistrer un paiement.';
        }
        modify("Applies-to ID")
        {
            ToolTipML = ENU = 'Specifies the entries that will be applied to by the journal line if you use the Apply Entries facility.', FRA = 'Spécifie les écritures qui vont être lettrées avec la ligne feuille si vous utilisez l''option Ecr. ouvertes.';
        }
        modify("On Hold")
        {
            ToolTipML = ENU = 'Specifies if the journal line has been invoiced, and you execute the payment suggestions batch job, or you create a finance charge memo or reminder.', FRA = 'Spécifie si la ligne feuille a été facturée et si vous exécutez le traitement par lots de suggestion de paiements ou si vous créez une facture d''intérêts ou une relance.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code that has been entered on the journal lines.', FRA = 'Spécifie le code motif qui a été saisi sur les lignes feuille.';
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
        modify("Bal. Account Name")
        {
            CaptionML = ENU = 'Bal. Account Name', FRA = 'Nom du compte contrepartie';
        }
        modify(BalAccName)
        {
            CaptionML = ENU = 'Bal. Account Name', FRA = 'Nom du compte contrepartie';
            ToolTipML = ENU = 'Specifies the name of the balancing account that has been entered on the journal line.', FRA = 'Spécifie le nom du compte contrepartie qui a été saisi sur la ligne feuille.';
        }
        modify(Control1903866901)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
        }
        modify(Balance)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
            ToolTipML = ENU = 'Specifies the balance that has accumulated in the purchase journal on the line where the cursor is.', FRA = 'Indique le solde du document dans la feuille achat sur la ligne où se trouve le pointeur de la souris.';
        }
        modify("Total Balance")
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
        }
        modify(TotalBalance)
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
            ToolTipML = ENU = 'Specifies the total balance in the purchase journal.', FRA = 'Indique le solde final de la feuille achat.';
        }
        addafter(Comment)
        {
            field("Vendor Bank Account"; rec."Vendor Bank Account FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Bank Account field.';
            }
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
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
        modify("Renumber Document Numbers")
        {
            CaptionML = ENU = 'Renumber Document Numbers', FRA = 'Renuméroter des documents';
            ToolTipML = ENU = 'Resort the numbers in the Document No. column to avoid posting errors because the document numbers are not in sequence. Entry applications and line groupings are preserved.', FRA = 'Réaffectez les priorités des numéros dans la colonne N° document pour éviter les erreurs de validation dues au fait que les numéros de document ne sont pas dans l''ordre. Le lettrage des écritures et les groupements de lignes sont préservés.';
        }
        modify("Apply Entries")
        {
            CaptionML = ENU = 'Apply Entries', FRA = 'Lettrer écritures';
            ToolTipML = ENU = 'Select one or more ledger entries that you want to apply this record to so that the related posted documents are closed as paid or refunded.', FRA = 'Sélectionnez une ou plusieurs écritures comptables que vous voulez lettrer avec cet enregistrement afin que les documents validés concernés soient fermés comme étant payés ou remboursés.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Insert Conv. LCY Rndg. Lines")
        {
            CaptionML = ENU = 'Insert Conv. LCY Rndg. Lines', FRA = 'Insérer lignes arr. conv. DS';
            ToolTipML = ENU = 'Insert a rounding correction line in the journal. This rounding correction line will balance in LCY when amounts in the foreign currency also balance. You can then post the journal.', FRA = 'Insérez une ligne correction arrondi dans la feuille. Cette ligne correction d''arrondi permet d''équilibrer en devise société lorsque les montants en devise étrangère sont également équilibrés. Vous pouvez alors valider la feuille.';
        }
        modify(IncomingDocument)
        {
            CaptionML = ENU = 'Incoming Document', FRA = 'Document entrant';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(IncomingDocCard)
        {
            CaptionML = ENU = 'View Incoming Document', FRA = 'Afficher le document entrant';
            ToolTipML = ENU = 'View any incoming document records and file attachments that exist for the entry or document.', FRA = 'Affichez tout enregistrement et fichier joint de document entrant qui existe pour l''écriture ou le document.';
        }
        modify(SelectIncomingDoc)
        {
            CaptionML = ENU = 'Select Incoming Document', FRA = 'Sélectionner le document entrant';
            ToolTipML = ENU = 'Select an incoming document record and file attachment that you want to link to the entry or document.', FRA = 'Sélectionnez un fichier joint ou un enregistrement de document entrant que vous voulez associer à l''écriture ou au document.';
        }
        modify(IncomingDocAttachFile)
        {
            CaptionML = ENU = 'Create Incoming Document from File', FRA = 'Créer un document entrant à partir d''un fichier';
            ToolTipML = ENU = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.', FRA = 'Créez un enregistrement de document entrant en sélectionnant un fichier à joindre, puis associez l''enregistrement de document entrant à l''écriture ou au document.';
        }
        modify(RemoveIncomingDoc)
        {
            CaptionML = ENU = 'Remove Incoming Document', FRA = 'Supprimer le document entrant';
            ToolTipML = ENU = 'Remove the link to an incoming document record and file attachment.', FRA = 'Supprimez le lien dans un fichier joint ou un enregistrement de document entrant.';
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
    }

    var
        GenJnlTemplate: Record "Gen. Journal Template";
        EnableActnIfTemplateNtBlck: Boolean;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    HasIncomingDocument := "Incoming Document Entry No." <> 0;
    GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);
    UpdateBalance;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EnableActnIfTemplateNtBlck := EnableActionIfTemplateNtBlock;   //HEI.02
    #1..4
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
    EnableActnIfTemplateNtBlck := EnableActionIfTemplateNtBlock;   //HEI.02
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

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    //BC Upgrade SHARMP16 BEGIN>>----- Custom code
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //HEI.02>>
        CLEAR(EnableActnIfTemplateNtBlck);
        EnableActnIfTemplateNtBlck := TRUE;
        //HEI.02<<

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        EnableActnIfTemplateNtBlck := rec.EnableActionIfTemplateNtBlock();   //HEI.02
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        EnableActnIfTemplateNtBlck := rec.EnableActionIfTemplateNtBlock();   //HEI.02
    end;
    //BC Upgrade SHARMP16 end<<----- Custom code
}

