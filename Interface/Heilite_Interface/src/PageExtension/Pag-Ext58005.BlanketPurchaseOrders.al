pageextension 58005 BlanketPurchaseOrdersExt extends "Blanket Purchase Orders"
{
    // DITW18.00.06 DDR 02/03/2015 DIT-770 #1191 Added fields "Responsiblity Center","Physical Location Group Code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4

    // HEI.01 PURGAP11 IBM LAZARE02 04.09.2017
    //  # New fields for SRM integration: SRM Contract Type, SRM Contract No., Channel, Target Value Currency, Target Value Amount, 
    //                                    Valid From, Valid To, Shipment Method Code, Shipment Method Location, Payment Terms Code
    //**********************************************************************************************************************************
    //BC UPGRADE PATHAA02 21.11.25 -Done
    // 10 SRM related fields exist-->Need to put this in Interface Ext
    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the purchase document.', FRA = 'Spécifie le numéro du document achat.';
        }
        modify("Buy-from Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor you buy from.', FRA = 'Spécifie le numéro du fournisseur auprès duquel vous effectuez vos achats.';
        }
        modify("Order Address Code")
        {
            ToolTipML = ENU = 'Specifies the order address code linked to the relevant vendor''s order address.', FRA = 'Spécifie le code adresse commande lié à l''adresse de commande du fournisseur concerné.';
        }
        modify("Buy-from Vendor Name")
        {
            ToolTipML = ENU = 'Specifies the name of the vendor who sends the items.', FRA = 'Spécifie le nom du fournisseur qui envoie les articles.';
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
        addafter("Shortcut Dimension 2 Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.';
            }
            //BC UPGRADE PATHAA02-DIT>>
            // field("Physical Location Group Code";Rec."Physical Location Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            //BC UPGRADE PATHAA02-DIT <<
        }
        addafter("Currency Code")
        {
            field("SRM Contract Type"; Rec."SRM Contract Type FND")
            {
                ApplicationArea = Suite;
                ToolTip = 'Specifies the value of the Contract Type field.';
            }
            field("SRM Contract No."; Rec."SRM Contract No. FND")
            {
                ApplicationArea = Suite;
                ToolTip = 'Specifies the value of the SRM Contract No. field.';
            }
            field("Valid From"; Rec."Valid From FND")
            {
                ApplicationArea = Suite;
                ToolTip = 'Specifies the value of the Valid From field.';
            }
            field("Valid To"; Rec."Valid To FND")
            {
                ApplicationArea = Suite;
                ToolTip = 'Specifies the value of the Valid To field.';
            }
            field(Channel; Rec."Channel FND")
            {
                ApplicationArea = Suite;
                ToolTip = 'Specifies the value of the Channel field.';
            }
            field("Target Value Currency"; Rec."Target Value Currency FND")
            {
                ApplicationArea = Suite;
                ToolTip = 'Specifies the value of the Target Value Currency field.';
            }
            field("Target Value Amount"; Rec."Target Value Amount FND")
            {
                ApplicationArea = Suite;
                ToolTip = 'Specifies the value of the Target Value Amount field.';
            }
            field("Shipment Method Code"; Rec."Shipment Method Code")
            {
                ApplicationArea = Suite;
                ToolTip = 'Specifies the code that represents the shipment method for this purchase.';
            }
            field("Shipment Method Location"; Rec."Shipment Method Location FND")
            {
                ApplicationArea = Suite;
                ToolTip = 'Specifies the value of the Shipment Method Location field.';
            }
            field("Payment Terms Code"; Rec."Payment Terms Code")
            {
                ApplicationArea = Suite;
                ToolTip = 'Specifies the code that represents the payment terms that apply to the purchase order.';
            }
        }
    }
    actions
    {
        modify("O&rder")
        {
            CaptionML = ENU = 'O&rder', FRA = 'C&ommande';
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
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
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
        modify(MakeOrder)
        {
            CaptionML = ENU = 'Make &Order', FRA = '&Créer commande';
        }
        modify(Print)
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

