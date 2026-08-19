pageextension 51114 JobGLJournalExtCBN extends "Job G/L Journal"
{
    // HEI.01 CHG2271823 IBM KAPOOV01 08.11.2024 Field to Block/Unblock General Journal templates
    //   #Modified Trigger/Functions- OnInit(),OnAfterGetRecord(),OnAfterGetCurrRecord()
    //   #Modified Enable Property of Various Actions & Action Groups

    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
            ToolTipML = ENU = 'Specifies the name of the journal batch.', FRA = 'Spécifie le nom de la comptabilité.';
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
            ToolTipML = ENU = 'Specifies the general posting type that will be used when you post the entry on this journal line.', FRA = 'Spécifie le type de validation général qui est utilisé lorsque vous validez l''écriture de cette ligne feuille.';
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
            ToolTipML = ENU = 'Specifies the vendor''s VAT specification to link transactions made for this vendor with the appropriate general ledger account according to the VAT posting setup.', FRA = 'Spécifie le détail TVA du fournisseur pour lier les transactions effectuées pour ce fournisseur au compte général approprié en fonction des paramètres de comptabilisation TVA.';
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the VAT product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation produit TVA utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("VAT %")
        {
            ToolTipML = ENU = 'Specifies the relevant VAT rate for the particular combination of VAT business posting group and VAT product posting group. Do not enter the percent sign, only the number. For example, if the VAT rate is 25 %, enter 25 in this field.', FRA = 'Spécifie le taux de TVA correspondant à cette combinaison spécifique de groupe comptabilisation marché TVA et de groupe comptabilisation produit TVA. Ne saisissez pas le signe pourcentage mais uniquement le nombre. Par exemple, si la TVA est de 25 %, saisissez 25 dans ce champ.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the total amount (including VAT) that the journal line consists of.', FRA = 'Spécifie le montant total (TVA incluse) qui constitue la ligne feuille.';
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
            ToolTipML = ENU = 'Specifies the code for the balancing account type that should be used in this journal line.', FRA = 'Spécifie le code pour le type de compte contrepartie qui devrait être utilisé pour cette ligne feuille.';
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
            ToolTipML = ENU = 'Specifies the code of the VAT business posting group associated with the balancing account that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation marché TVA associé au compte contrepartie qui est utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Bal. VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the VAT product posting group associated with the balancing account that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation produit TVA associé au compte contrepartie qui est utilisé lorsque vous validez l''écriture sur la ligne feuille.';
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
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies the code that represents the payments terms that apply to the entry on the journal line.', FRA = 'Spécifie le code qui représente les conditions de paiement qui s''appliquent à l''écriture de la ligne feuille.';
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
            ToolTipML = ENU = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.', FRA = 'Spécifie l''ID de lettrage des écritures lorsque vous choisissez l''action Ecr. ouvertes.';
        }
        modify("On Hold")
        {
            ToolTipML = ENU = 'Specifies if the journal line has been invoiced, and you execute the payment suggestions batch job, or you create a finance charge memo or reminder.', FRA = 'Indique si la ligne feuille a été facturée et si vous exécutez le traitement par lots de suggestion de paiements ou créez des intérêts ou une relance.';
        }
        modify("Bank Payment Type")
        {
            ToolTipML = ENU = 'Specifies the code for the payment type to be used for the entry on the payment journal line.', FRA = 'Spécifie le code du mode de paiement à utiliser pour l''écriture de la ligne feuille paiement.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code that has been entered on the journal lines.', FRA = 'Spécifie le code motif qui a été saisi sur les lignes feuille.';
        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'Specifies the related job.', FRA = 'Spécifie le projet concerné.';
        }
        modify("Job Task No.")
        {
            ToolTipML = ENU = 'Specifies the related job task number.', FRA = 'Spécifie le numéro de tâche projet concernée.';
        }
        modify("Job Planning Line No.")
        {
            ToolTipML = ENU = 'Specifies the job planning line number to which the usage should be linked when the Job Journal is posted. You can only link to Job Planning Lines that have the Apply Usage Link option enabled.', FRA = 'Spécifie le numéro de la ligne planning projet à laquelle l''utilisation doit être liée lorsque la feuille est validée. Vous pouvez seulement établir une liaison vers des lignes planning projet dont l''option Appliquer le lien d''utilisation est activée.';
        }
        modify("Job Line Type")
        {
            ToolTipML = ENU = 'Specifies the planning line(s) that was created together with the posting of a job ledger entry from the purchase line.', FRA = 'Spécifie les lignes planning créées avec l''enregistrement d''une écriture comptable projet à partir de la ligne achat.';
        }
        modify("Job Unit Of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code that is used to determine the unit price. This code specifies how the quantity is measured, for example, by the box or by the piece. The application retrieves this code from the corresponding item or resource card.', FRA = 'Spécifie le code unité utilisé pour déterminer le prix unitaire. Ce code spécifie la manière dont la quantité est mesurée, par exemple par boîte ou par pièce. L''application récupère ce code sur la fiche article ou ressource correspondante.';
        }
        modify("Job Quantity")
        {
            ToolTipML = ENU = 'Specifies the quantity for the job ledger entry that is derived from posting the journal line. If the Job Quantity is 0, the total amount on the job ledger entry will also be 0.', FRA = 'Spécifie la quantité pour l''écriture comptable projet qui est dérivée de la validation de la ligne feuille. Si la Quantité projet est égale à 0, le montant total de l''écriture comptable projet est aussi égal à 0.';
        }
        modify("Job Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the job cost of one unit of the item or resource on the journal line. The value is calculated as follows: Job Total Cost (LCY) / Job Quantity.', FRA = 'Spécifie le coût projet d''une unité de l''article ou de la ressource dans la ligne feuille. Cette valeur est calculée comme suit : Coût total projet DS / Quantité projet.';
        }
        modify("Job Unit Cost (LCY)")
        {
            ToolTipML = ENU = 'Specifies the job cost of one unit of the item or resource on the journal line, in the local currency. The value is calculated as follows: Job Total Cost (LCY) / Job Quantity.', FRA = 'Spécifie le coût projet d''une unité de l''article ou de la ressource dans la ligne feuille, en devise société. Cette valeur est calculée comme suit : Coût total projet DS / Quantité projet.';
        }
        modify("Job Total Cost")
        {
            ToolTipML = ENU = 'Specifies if you have assigned a job number and a job task number to the journal line. It shows the amount excluding VAT divided by the job quantity for the journal line. The amount is shown in the currency specified for the job. The value field is calculated as follows: (Amount - VAT Amount) x (Job Currency Rate/Currency Rate).', FRA = 'Spécifie si vous avez attribué un numéro de projet et un numéro de tâche projet à la ligne feuille. Il affiche le montant hors TVA divisé par la quantité projet pour la ligne feuille. Le montant est affiché dans la devise spécifiée pour le projet. Cette valeur est calculée comme suit : (Montant-Montant TVA) x (Taux devise projet/Taux devise).';
        }
        modify("Job Total Cost (LCY)")
        {
            ToolTipML = ENU = 'Specifies the job total cost if you have assigned a job number and a job task number to the journal line. It shows the Amount (LCY) excluding VAT Amount (LCY)for the journal line.', FRA = 'Spécifie le coût total projet si vous avez attribué un numéro de projet et un numéro de tâche projet à la ligne feuille. Il affiche le Montant DS hors montant TVA DS pour la ligne feuille.';
        }
        modify("Job Unit Price")
        {
            ToolTipML = ENU = 'Specifies the unit price for the selected account type and account number on the journal line.', FRA = 'Spécifie le prix unitaire du type compte et du N° compte sélectionnés dans la ligne feuille.';
        }
        modify("Job Unit Price (LCY)")
        {
            ToolTipML = ENU = 'Specifies the unit price, in the local currency, for the selected account type and account number on the journal line.', FRA = 'Spécifie le prix unitaire, en devise société, du type compte et du N° compte sélectionnés dans la ligne feuille.';
        }
        modify("Job Line Amount")
        {
            ToolTipML = ENU = 'Specifies the line amount of the job ledger entry that was posted from the purchase line.', FRA = 'Spécifie le montant ligne de l''écriture comptable projet validée à partir de la ligne achat.';
        }
        modify("Job Line Amount (LCY)")
        {
            ToolTipML = ENU = 'Specifies the line amount of the job ledger entry that was posted from the purchase line.', FRA = 'Spécifie le montant ligne de l''écriture comptable projet validée à partir de la ligne achat.';
        }
        modify("Job Line Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the line discount amount of the job ledger entry that was posted from the purchase line. The amount is shown in the currency specified for the job.', FRA = 'Spécifie le montant remise ligne de l''écriture comptable projet validée à partir de la ligne achat. Le montant est affiché dans la devise spécifiée pour le projet.';
        }
        modify("Job Line Discount %")
        {
            ToolTipML = ENU = 'Specifies the job line discount percentage that will be used for the job ledger entry. If you have set up a job-specific line discount percentage for the account type and account number, then it is inserted automatically. Otherwise, the discount percentage is based on the discount that is set up on the customer or item card.', FRA = 'Spécifie le pourcentage remise ligne du projet utilisé pour l''écriture comptable projet. Si vous avez configuré un pourcentage de remise ligne spécifique au projet pour le type compte et le N° compte, il est automatiquement inséré. Autrement, le pourcentage de remise est basé sur la remise configurée sur la fiche client ou article.';
        }
        modify("Job Total Price")
        {
            ToolTipML = ENU = 'Specifies the total price for the journal line. The value is calculated as follows: Quantity x Unit Price (LCY).', FRA = 'Spécifie le prix total pour la ligne feuille. Cette valeur est calculée comme suit : Quantité x Prix unitaire DS.';
        }
        modify("Job Total Price (LCY)")
        {
            ToolTipML = ENU = 'Specifies the total price for the journal line, in the local currency. The value is calculated as follows: Quantity x Unit Price (LCY).', FRA = 'Spécifie le prix total pour la ligne feuille, en devise société. Cette valeur est calculée comme suit : Quantité x Prix unitaire DS.';
        }
        modify("Job Remaining Qty.")
        {
            ToolTipML = ENU = 'Specifies the quantity of the item that remains to complete a job.', FRA = 'Spécifie la quantité restante de l''article pour réaliser un projet.';
        }
        modify("Account Name")
        {
            CaptionML = ENU = 'Account Name', FRA = 'Nom du compte';
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
        modify(Control1902759701)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
        }
        modify(Balance)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
            ToolTipML = ENU = 'Specifies the balance that has accumulated in the journal on the line that you selected.', FRA = 'Spécifie le solde du document cumulé dans la feuille comptabilité sur la ligne que vous avez sélectionnée.';
        }
        modify("Total Balance")
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
        }
        modify(TotalBalance)
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
            ToolTipML = ENU = 'Specifies the total balance in the journal.', FRA = 'Indique le solde final de la feuille.';
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
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
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
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Reconcile)
        {
            CaptionML = ENU = 'Reconcile', FRA = 'Simuler';
            ToolTipML = ENU = 'View what has been reconciled for the job. The window shows the quantity entered on the job journal lines, totaled by unit of measure and by work type.', FRA = 'Affichez les éléments qui ont fait l''objet du rapprochement pour le projet. La fenêtre affiche la quantité entrée sur les lignes feuille, totalisée par unité de mesure et type de travail.';
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify("P&ost")
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
    GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);
    UpdateBalance;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EnableActnIfTemplateNtBlck := EnableActionIfTemplateNtBlock;  //HEI.01
    GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);
    UpdateBalance;
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
    EnableActnIfTemplateNtBlck := EnableActionIfTemplateNtBlock;  //HEI.01
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
    //HEI.01>>
    CLEAR(EnableActnIfTemplateNtBlck);
    EnableActnIfTemplateNtBlck := true;
    //HEI.01<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    //BC UPGrade SHARMP16 begin>>
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //HEI.01>>
        CLEAR(EnableActnIfTemplateNtBlck);
        EnableActnIfTemplateNtBlck := TRUE;
        //HEI.01<<
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        EnableActnIfTemplateNtBlck := rec.EnableActionIfTemplateNtBlock();  //HEI.01
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        EnableActnIfTemplateNtBlck := rec.EnableActionIfTemplateNtBlock();  //HEI.01
    end;
    //BC Upgrade SHARMp16 end<<
}

