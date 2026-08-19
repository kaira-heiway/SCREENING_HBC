pageextension 52024 PostedPurchaseCreditMemosExt extends "Posted Purchase Credit Memos"
{
    // version NAVW110.0,DITW110.00.08

    //  DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields
    // "Physical Location Group Code";"Responsibility Center"
    //   DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field "Document Subtype Code" (Visible FALSE)
    //   DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code
    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.01 RFC-CHG0270099 IBM.ISYED01 18.01.2019
    //     Added field VAT Registration No on page
    //**************************************************//
    //BC UPGRADE SIVA 01/02/2026//
    //1.HEI.01 Added field VAT Registration No on page.
    //2.Commented drink it fields.
    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the posted credit memo number.', FRA = 'Spécifie le numéro d''avoir validé.';
        }
        modify("Buy-from Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor associated with the credit memo.', FRA = 'Spécifie le numéro du fournisseur associé à l''avoir.';
        }
        modify("Order Address Code")
        {
            ToolTipML = ENU = 'Specifies the order address code used in the credit memo.', FRA = 'Spécifie le code adresse commande utilisé pour l''avoir.';
        }
        modify("Buy-from Vendor Name")
        {
            ToolTipML = ENU = 'Specifies the name of the vendor who delivered the items.', FRA = 'Spécifie le nom du fournisseur qui a livré les articles.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code used to calculate the amounts on the credit memo.', FRA = 'Spécifie le code devise utilisé pour calculer les montants de l''avoir.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies when the credit memo is due. The program calculates the date using the Payment Terms Code and Posting Date fields on the purchase header.', FRA = 'Spécifie la date d''échéance de cet avoir. Le programme calcule la date à l''aide des champs Code condition paiement et Date comptabilisation de l''en-tête achat.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the total, in the currency of the credit memo, of the amounts on all the credit memo lines.', FRA = 'Spécifie le total, dans la devise de l''avoir, des montants de toutes les lignes avoir.';
        }
        modify("Amount Including VAT")
        {
            ToolTipML = ENU = 'Specifies the total, in the currency of the credit memo, of the amounts on all the credit memo lines - including VAT.', FRA = 'Spécifie le total, dans la devise de l''avoir, des montants de toutes les lignes avoir (y compris la TVA).';
        }
        modify("Remaining Amount")
        {
            ToolTipML = ENU = 'Specifies the amount that remains to be paid for the posted purchase invoice that relates to this purchase credit memo.', FRA = 'Indique le montant restant dû pour la facture achat validée liée à cet avoir achat.';
        }
        modify(Paid)
        {
            ToolTipML = ENU = 'Specifies if the posted purchase invoice that relates to this purchase credit memo is paid. The check box will also be selected if a credit memo for the remaining amount has been applied.', FRA = 'Spécifie si la facture achat validée liée à cet avoir achat est payée. La case à cocher est également activée si un avoir pour le montant ouvert a été lettré.';
        }
        modify(Cancelled)
        {
            ToolTipML = ENU = 'Specifies if the posted purchase invoice that relates to this purchase credit memo has been either corrected or canceled.', FRA = 'Spécifie si la facture achat validée liée à cet avoir achat a été corrigée ou annulée.';
        }
        modify(Corrective)
        {
            ToolTipML = ENU = 'Specifies if the posted purchase invoice has been either corrected or canceled by this purchase credit memo .', FRA = 'Indique si la facture achat validée a été corrigée ou annulée par cet avoir achat.';
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
            ToolTipML = ENU = 'Specifies the name of the person to contact at the vendor who shipped the items.', FRA = 'Spécifie le nom de la personne à contacter chez le fournisseur.';
        }
        modify("Pay-to Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor who you received the credit memo from.', FRA = 'Spécifie le numéro du fournisseur qui vous a fourni l''avoir.';
        }
        modify("Pay-to Name")
        {
            ToolTipML = ENU = 'Specifies the name of the vendor who you received the credit memo from.', FRA = 'Spécifie le nom du fournisseur qui vous a fourni l''avoir.';
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
            ToolTipML = ENU = 'Specifies the name of the person you should contact at the vendor who you received the credit memo from.', FRA = 'Spécifie le nom de la personne que vous devez contacter chez le fournisseur qui vous a envoyé l''avoir.';
        }
        modify("Ship-to Code")
        {
            ToolTipML = ENU = 'Specifies the shipment of the sales order that is linked to the purchase order for drop shipment from the vendor to a customer.', FRA = 'Spécifie l''expédition de la commande vente associée à la commande achat dans le cadre d''une livraison directe du fournisseur au client.';
        }
        modify("Ship-to Name")
        {
            ToolTipML = ENU = 'Specifies the name of the company at the address to which the items were shipped.', FRA = 'Spécifie le nom de la société située à l''adresse à laquelle les articles ont été livrés.';
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
            ToolTipML = ENU = 'Specifies the name of a contact person at the address that the items were shipped to.', FRA = 'Spécifie le nom d''un contact à l''adresse à laquelle les articles ont été expédiés.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date the credit memo was posted.', FRA = 'Spécifie la date de validation de l''avoir.';
        }
        modify("Purchaser Code")
        {
            ToolTipML = ENU = 'Specifies which purchaser is associated with the credit memo.', FRA = 'Spécifie le nom de l''acheteur associé à l''avoir.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension value associated with the credit memo.', FRA = 'Spécifie le code de la section analytique associée à l''avoir.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension value associated with the credit memo.', FRA = 'Spécifie le code de la section analytique associée à l''avoir.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code for the location used when you posted the credit memo.', FRA = 'Spécifie le code du magasin utilisé lorsque vous avez validé l''avoir.';
        }
        modify("No. Printed")
        {
            ToolTipML = ENU = 'Specifies how many times the credit memo has been printed.', FRA = 'Spécifie combien de fois l''avoir a été imprimé.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date when the purchase document was created.', FRA = 'Spécifie la date à laquelle vous avez créé le document achat.';
        }
        modify("Applies-to Doc. Type")
        {
            ToolTipML = ENU = 'Specifies whether the credit memo has been applied to an already-posted document.', FRA = 'Indique si l''avoir a été lettré avec un document déjà validé.';
        }
        addafter("Buy-from Vendor Name")
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = all;
                ToolTip = 'VAT Registration No.';

            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = all;
                ToolTip = 'Responsibility Center';
                Visible = false;
            }
            //BC UPGRADE SIVA >> Drink IT Field
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     ApplicationArea = all;
            //     Visible = false;
            // }
            //BC UPGRADE SIVA << Drink IT Field
        }
        addafter("Applies-to Doc. Type")
        {
            // BC Upgrade VAMSIU01 - Document Subtype Code field added >>
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                ApplicationArea = all;
                Visible = false;
            }
            // BC Upgrade VAMSIU01 - Document Subtype Code field added <<
            field("Payment User"; Rec."Payment User FND")
            {
                ApplicationArea = all;
                ToolTip = 'Payment User';
            }
            field("Payment Status"; Rec."Payment Status FND")
            {
                ApplicationArea = all;
                ToolTip = 'Payment Status';

            }
            field("Status Date"; Rec."Status Date FND")
            {
                ApplicationArea = all;
                ToolTip = 'Status Date';
            }
        }
    }
    actions
    {
        modify("&Cr. Memo")
        {
            CaptionML = ENU = '&Cr. Memo', FRA = 'Avoi&r';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
            ToolTipML = ENU = 'View or add notes about the posted purchase credit memo.', FRA = 'Affichez ou ajoutez des remarques sur l''avoir achat validé.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Vendor)
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
            ToolTipML = ENU = 'View or edit detailed information about the vendor on the selected posted purchase document.', FRA = 'Affichez ou modifiez des informations détaillées concernant le fournisseur sur le document achat sélectionné validé.';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            ToolTipML = ENU = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.', FRA = 'Préparez-vous à imprimer le document. Une fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document.';
        }
        modify(Cancel)
        {
            CaptionML = ENU = 'Cancel', FRA = 'Annuler';
        }
        modify(CancelCrMemo)
        {
            CaptionML = ENU = 'Cancel', FRA = 'Annuler';
            ToolTipML = ENU = 'Create and post a purchase invoice that reverses this posted purchase credit memo. This posted purchase credit memo will be canceled.', FRA = 'Créez et validez une facture achat qui contrepasse cet avoir achat enregistré. Cet avoir achat validé sera annulé.';
        }
        modify(ShowInvoice)
        {
            CaptionML = ENU = 'Show Canceled/Corrective Invoice', FRA = 'Afficher facture annulée/de correction';
            ToolTipML = ENU = 'Open the posted sales invoice that was created when you canceled the posted sales credit memo. If the posted sales credit memo is the result of a canceled sales invoice, then canceled invoice will open.', FRA = 'Ouvrez la facture vente validée qui a été créée lorsque vous avez annulé l''avoir vente validé. Si l''avoir vente validé est le résultat d''une facture vente annulée, cette dernière s''ouvrira.';
        }


        //Unsupported feature: CodeModification on ""&Print"(Action 21).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(PurchCrMemoHdr);
        PurchCrMemoHdr.PrintRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
        PurchCrMemoHdr := Rec;
        //>> DITW18.00.07 AKH DIT-770 #1508
        CurrPage.SETSELECTIONFILTER(PurchCrMemoHdr);
        PurchCrMemoHdr.PrintRecords(true);
        */
        //end;
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

