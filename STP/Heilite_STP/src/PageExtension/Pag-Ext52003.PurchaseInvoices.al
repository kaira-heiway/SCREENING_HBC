pageextension 52003 PurchaseInvoicesExt extends "Purchase Invoices"
{
    // HEI.01 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //  # New Field added: "Fixed Asset Acquisition"
    // HEI.02 CHG2221624 HB3614 IBM SRIVAS07 10.04.2024 # Block Payment for Invoices with Price Difference higher than the tolerance
    //   # New Field added: "RUID" and Make Status Visible
    //**********************************************************************************************
    //BC UPGRADE PATHAA02- 21-11-25
    //HEI.01-Done, HEI.02-Done
    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the purchase document. The field is only visible if you have not set up a number series for the type of purchase document, or if the Manual Nos. field is selected for the number series.', FRA = 'Spécifie le numéro du document achat. Le champ n''est visible que si vous n''avez défini aucune souche de numéros pour ce type de document achat, ou si le champ N° manuels est sélectionné pour la souche de numéros.';
        }
        modify("Buy-from Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor that you buy from. When you enter the number, several other fields on the document are filled from the vendor card. You can change the vendor number as long as you have not posted the document.', FRA = 'Spécifie le numéro du fournisseur auprès duquel vous effectuez vos achats. Lorsque vous renseignez ce champ, la plupart des autres champs du document sont remplis à partir de la fiche fournisseur. Vous pouvez changer le numéro du fournisseur tant que vous n''avez pas validé le document.';
        }
        modify("Order Address Code")
        {
            ToolTipML = ENU = 'Specifies the order address code linked to the relevant vendor''s order address.', FRA = 'Spécifie le code adresse commande lié à l''adresse de commande du fournisseur concerné.';
        }
        modify("Buy-from Vendor Name")
        {
            ToolTipML = ENU = 'Specifies the name of the vendor who delivers the items.', FRA = 'Spécifie le nom du fournisseur qui livre les articles.';
        }
        modify("Vendor Authorization No.")
        {
            ToolTipML = ENU = 'Specifies the compensation agreement identification number, sometimes referred to as the RMA No. (Returns Materials Authorization).', FRA = 'Spécifie le numéro d''identification d''un accord de compensation. Ce numéro est parfois appelé numéro d''autorisation de retour de matériel (RMA).';
        }
        modify("Buy-from Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the address.', FRA = 'Spécifie le code postal de l''adresse.';
        }
        modify("Buy-from Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code of the address.', FRA = 'Spécifie le code pays/la région de l''adresse.';
        }
        modify("Buy-from Contact")
        {
            ToolTipML = ENU = 'Specifies the name of the person to contact about shipment of the item from this vendor.', FRA = 'Spécifie le nom de la personne à contacter à propos de l''expédition de l''article chez le fournisseur.';
        }
        modify("Pay-to Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the vendor who is sending the invoice.', FRA = 'Spécifie le fournisseur envoyant la facture.';
        }
        modify("Pay-to Name")
        {
            ToolTipML = ENU = 'Specifies the name of the vendor sending the invoice.', FRA = 'Spécifie le nom du fournisseur envoyant la facture.';
        }
        modify("Pay-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the address.', FRA = 'Spécifie le code postal de l''adresse.';
        }
        modify("Pay-to Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code of the address.', FRA = 'Spécifie le code pays/la région de l''adresse.';
        }
        modify("Pay-to Contact")
        {
            ToolTipML = ENU = 'Specifies the name of the person to contact about an invoice from this vendor.', FRA = 'Spécifie le nom de la personne à contacter au sujet d''une facture émise par ce fournisseur.';
        }
        modify("Ship-to Code")
        {
            ToolTipML = ENU = 'Specifies a ship-to code if you want a different shipment address from the one that has been automatically entered.', FRA = 'Spécifie un code destinataire si vous souhaitez utiliser une adresse destinataire différente de celle automatiquement renseignée.';
        }
        modify("Ship-to Name")
        {
            ToolTipML = ENU = 'Specifies the name of the company at the address to which you want the items to be shipped.', FRA = 'Spécifie le nom de la société située à l''adresse à laquelle vous voulez faire livrer les articles.';
        }
        modify("Ship-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the address.', FRA = 'Spécifie le code postal de l''adresse.';
        }
        modify("Ship-to Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code of the address.', FRA = 'Spécifie le code pays/la région de l''adresse.';
        }
        modify("Ship-to Contact")
        {
            ToolTipML = ENU = 'Specifies the name of a contact person for the address where the items should be shipped.', FRA = 'Spécifie le nom d''une personne contact pour l''adresse à laquelle les articles doivent être livrés.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date when the posting of the purchase document will be recorded.', FRA = 'Spécifie la date à laquelle la validation du document achat sera validée.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the purchase header.', FRA = 'Spécifie le code de la section analytique associée à l''en-tête achat.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the purchase header.', FRA = 'Spécifie le code de la section analytique associée à l''en-tête achat.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies a code for the location where you want the items to be placed when they are received.', FRA = 'Spécifie un code pour le magasin dans lequel vous souhaitez que les articles soient stockés lorsqu''ils sont réceptionnés.';
        }
        modify("Purchaser Code")
        {
            ToolTipML = ENU = 'Specifies which purchaser is assigned to the vendor.', FRA = 'Spécifie l''acheteur affecté au fournisseur.';
        }
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.', FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the code of the currency of the amounts on the purchase lines.', FRA = 'Spécifie le code de la devise des montants figurant sur les lignes achat.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date of the vendor''s invoice.', FRA = 'Spécifie la date de la facture du fournisseur.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.', FRA = 'Spécifie si l''enregistrement est ouvert, en attente d''approbation, a été facturé pour acompte ou a été lancé pour l''étape suivante du traitement.';

        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.', FRA = 'Spécifie une formule qui calcule la date d''échéance du paiement, la date d''escompte et le montant de l''escompte sur le document achat.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies when the invoice is due.', FRA = 'Spécifie la date d''échéance de la facture.';
        }
        modify("Payment Discount %")
        {
            ToolTipML = ENU = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.', FRA = 'Spécifie le pourcentage escompte accordé si le paiement est effectué au plus tard à la date saisie dans le champ Date d''escompte.';
        }
        modify("Payment Method Code")
        {
            ToolTipML = ENU = 'Specifies how payment for the purchase document must be submitted.', FRA = 'Spécifie la manière dont le paiement du document achat doit être réalisé.';
        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies the code that represents the shipment method for this purchase.', FRA = 'Spécifie le code qui représente les conditions de livraison de cet achat.';
        }
        modify("Requested Receipt Date")
        {
            ToolTipML = ENU = 'Specifies the date to have the vendor deliver your order to the ship-to address.', FRA = 'Indique la date à laquelle le fournisseur doit livrer votre commande à l''adresse destinataire.';
        }
        modify("Job Queue Status")
        {
            ToolTipML = ENU = 'Specifies the status of a job queue entry that handles the posting of purchase orders.', FRA = 'Spécifie le statut d''une écriture file d''attente des travaux qui gère la validation des commandes achat.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the sum of the amounts in the Amount field on the associated purchase lines.', FRA = 'Spécifie la somme des montants du champ Montant sur les lignes achat associées.';
        }

        //Unsupported feature: PropertyDeletion on "Status(Control 1102601003)". Please convert manually.

        addafter("Shortcut Dimension 2 Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.';
            }
            //BC UPGRADE PATHAA02 >>DITW Field
            // field("Physical Location Group Code";Rec."Physical Location Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            //BC UPGRADE PATHAA02 <<DITW Field
        }
        // BC Upgrade VAMSIU01 - Document SUbtype Field Added >>
        addafter("Job Queue Status")
        {
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        // BC Upgrade VAMSIU01 - Document SUbtype Field Added <<
        addafter(Amount)
        {
            //BC UPGRADE PATHAA02 >> A member of type Field with name 'Vendor Invoice No.' is already defined in Page 'Purchase Invoices' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
            // field("Vendor Invoice No.";Rec."Vendor Invoice No.")
            // {
            // }
            //BC UPGRADE PATHAA02<< A member of type Field with name 'Vendor Invoice No.' is already defined in Page 'Purchase Invoices' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
            field("Doc. Amount Incl. VAT"; Rec."Doc. Amount Incl. VAT")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Doc. Amount Incl. VAT field.';
            }
            field("Doc. Amount VAT"; Rec."Doc. Amount VAT")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Doc. Amount VAT field.';
            }
            field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND") //HEI.01
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Fixed Asset Acquisition field.';
            }
            field(RUID; Rec."RUID FND")//HEI.02
            {
                Visible = true;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RUID field.';
            }
        }
    }
    actions
    {
        modify("&Invoice")
        {
            CaptionML = ENU = '&Invoice', FRA = 'Fa&cture';
        }

        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Invoice)
        {
            CaptionML = ENU = 'Invoice', FRA = 'Facture';
        }
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify(Vendor)
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
            ToolTipML = ENU = 'View or edit detailed information about the vendor on the selected purchase document.', FRA = 'Affichez ou modifiez des informations détaillées concernant le fournisseur sur le document achat sélectionné.';
        }
        //BC UPGRADE PATHAA02 >>The action 'ActionGroup7' is not found in the target 'Purchase Invoices'
        // modify(ActionGroup7)
        // {
        //     CaptionML = ENU='Release',FRA='Lancer';
        // }
        //BC UPGRADE PATHAA02 <<The action 'ActionGroup7' is not found in the target 'Purchase Invoices'
        modify(Release)
        {
            CaptionML = ENU = 'Re&lease', FRA = '&Lancer';
        }
        modify(Reopen)
        {
            CaptionML = ENU = 'Re&open', FRA = 'R&ouvrir';
        }
        modify("Request Approval")
        {
            CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';
        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send A&pproval Request', FRA = 'Envoyer demande d''a&pprobation';
            ToolTipML = ENU = 'Send an approval request.', FRA = 'Envoyez une demande d''approbation.';
        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Re&quest', FRA = 'Annuler demande d''appro&bation';
            ToolTipML = ENU = 'Cancel the approval request.', FRA = 'Annulez la demande d''approbation.';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        //BC UPGRADE PATHAA02 >>The action 'Post' is not found in the target 'Purchase Invoices'
        //modify(Post)
        // {
        //     CaptionML = ENU='P&ost',FRA='&Valider';
        //     ToolTipML = ENU='Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.',FRA='Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';
        // }
        //BC UPGRADE PATHAA02 <<The action 'Post' is not found in the target 'Purchase Invoices'
        modify(Preview)
        {
            CaptionML = ENU = 'Preview Posting', FRA = 'Aperçu compta.';
            ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.', FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';
        }
        modify(TestReport)
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify(PostAndPrint)
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
        }
        modify(PostBatch)
        {
            CaptionML = ENU = 'Post &Batch', FRA = 'Valider par l&ot';
        }
        modify(RemoveFromJobQueue)
        {
            CaptionML = ENU = 'Remove From Job Queue', FRA = 'Supprimer de la file d''attente des travaux';
            ToolTipML = ENU = 'Remove the scheduled processing of this record from the job queue.', FRA = 'Supprimez le traitement planifié de cet enregistrement à partir de la file d''attente des travaux.';
        }
    }


    //Unsupported feature: PropertyModification on "OpenPostedPurchaseInvQst(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OpenPostedPurchaseInvQst : ENU=The invoice has been posted and moved to the Posted Purchase Invoice list.\\Do you want to open the posted invoice?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OpenPostedPurchaseInvQst : ENU=The invoice has been posted and moved to the Posted Purchase Invoice list.\\Do you want to open the posted invoice?;FRA=La facture a été validée et déplacée dans la liste des factures achat enregistrées.\\Souhaitez-vous ouvrir la facture validée ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "TotalsMismatchErr(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //TotalsMismatchErr : ENU=The invoice cannot be posted because the total is different from the total on the related incoming document.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TotalsMismatchErr : ENU=The invoice cannot be posted because the total is different from the total on the related incoming document.;FRA=Impossible de valider la facture car le total est différent du total sur le document entrant associé.;
    //Variable type has not been exported.

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

