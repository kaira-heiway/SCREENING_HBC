pageextension 52013 PoestedPurchaseInvExtSTP extends "Posted Purchase Invoices"
{
    // version NAVW110.0,DITW110.00.08,HEI.06
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field "Document Subtype Code" (Visible FALSE)
    //   DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.01 FDD-PTPGAP013 IBM.PATHAA02, 01.08.2017
    //   #Added field-'Payment Status'

    //   HEI.02 FDD-PTPGAP041 IBM.PATHAA02, 20.08.17
    //   # Added field-Status Date
    //   HEI.03 INC0050039 IBM HORTOC01 23.11.2018 # add field "tax date"
    //   HEI.04 RFC-CHG0270099 IBM.ISYED01 18.01.2019
    //     Added field VAT Registration No on page
    //   HEI.05 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //     # New Field added: "Fixed Asset Acquisition"
    //   HEI.06 FDD-HB2638 CHG2136725 IBM NANDIS01 23.02.2022 Block create Corrective Credit memo option in HL
    //       # Code added to control of using button - Create Corrective Credit Memo

    //BC Upgrade GUNREM01 >>
    // HEI.06 Code not added becuase its DIT.
    //BC Upgrade GUNREM01 <<


    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the posted invoice number.', FRA = 'Spécifie le numéro de facture enregistrée.';
        }
        modify("Buy-from Vendor No.")
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';
            ToolTipML = ENU = 'Specifies the number of the vendor that you bought the items from.', FRA = 'Indique le numéro du fournisseur auprès duquel vous avez acheté les articles.';
        }
        modify("Order Address Code")
        {
            ToolTipML = ENU = 'Specifies the order address code used in the invoice.', FRA = 'Spécifie le code adresse commande utilisé pour la facture.';
        }
        modify("Buy-from Vendor Name")
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
            ToolTipML = ENU = 'Specifies the name of the vendor who shipped the items.', FRA = 'Spécifie le nom du fournisseur qui a expédié les articles.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code used to calculate the amounts on the invoice.', FRA = 'Spécifie le code devise utilisé pour calculer les montants de la facture.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the total, in the currency of the invoice, of the amounts on all the invoice lines.', FRA = 'Spécifie le total, dans la devise de la facture des montants de toutes les lignes facture.';
        }
        modify("Amount Including VAT")
        {
            ToolTipML = ENU = 'Specifies the total, in the currency of the invoice, of the amounts on all the invoice lines - including VAT.', FRA = 'Spécifie le total, dans la devise de la facture des montants de toutes les lignes facture (y compris la TVA).';
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
            ToolTipML = ENU = 'Specifies the number of the vendor who you received the invoice from.', FRA = 'Spécifie le numéro du fournisseur qui vous a fourni la facture.';
        }
        modify("Pay-to Name")
        {
            ToolTipML = ENU = 'Specifies the name of the vendor who you received the invoice from.', FRA = 'Spécifie le nom du fournisseur qui vous a fourni la facture.';
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
            ToolTipML = ENU = 'Specifies the name of the person you should contact at the vendor who you received the invoice from.', FRA = 'Spécifie le nom de la personne que vous devez contacter chez le fournisseur qui vous a envoyé la facture.';
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
            ToolTipML = ENU = 'Specifies the date the purchase header was posted.', FRA = 'Spécifie la date de validation de l''en-tête achat.';
        }
        modify("Purchaser Code")
        {
            ToolTipML = ENU = 'Specifies which purchaser is associated with the invoice.', FRA = 'Spécifie l''acheteur associé à la facture.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension value associated with the invoice.', FRA = 'Spécifie le code de la section analytique associée à la facture.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension value associated with the invoice.', FRA = 'Spécifie le code de la section analytique associée à la facture.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code for the location where the items are registered.', FRA = 'Spécifie le code du magasin où les articles sont enregistrés.';
        }
        modify("No. Printed")
        {
            ToolTipML = ENU = 'Specifies how many times the invoice has been printed.', FRA = 'Spécifie combien de fois la facture a été imprimée.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date when the purchase document was created.', FRA = 'Spécifie la date à laquelle vous avez créé le document achat.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies the code to use to find the payment terms that apply to the purchase header.', FRA = 'Spécifie le code à utiliser pour trouver les conditions de paiement qui s''appliquent à l''en-tête achat.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies when the invoice is due. The program calculates the date using the Payment Terms Code and Document Date fields on the purchase header.', FRA = 'Spécifie la date d''échéance de la facture. Le programme calcule la date à l''aide des champs Code condition paiement et Date document de l''en-tête achat.';
        }
        modify("Payment Discount %")
        {
            ToolTipML = ENU = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.', FRA = 'Spécifie le pourcentage escompte accordé si le paiement est effectué au plus tard à la date saisie dans le champ Date d''escompte.';
        }
        modify("Payment Method Code")
        {
            ToolTipML = ENU = 'Specifies the method of payment for payments to vendors.', FRA = 'Spécifie le mode de règlement qui s''applique aux paiements aux fournisseurs.';
        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies the code that represents the shipment method for this invoice.', FRA = 'Spécifie le code qui représente les conditions de livraison de cette facture.';
        }
        modify("Remaining Amount")
        {
            ToolTipML = ENU = 'Specifies the amount that remains to be paid for the posted purchase invoice.', FRA = 'Spécifie le montant qui reste à payer pour la facture achat validée.';
        }
        modify(Closed)
        {
            ToolTipML = ENU = 'Specifies if the posted purchase invoice is paid. The check box will also be selected if a credit memo for the remaining amount has been applied.', FRA = 'Spécifie si la facture achat validée est payée. La case à cocher est également activée si un avoir pour le montant ouvert a été lettré.';
        }
        modify(Cancelled)
        {
            ToolTipML = ENU = 'Specifies if the posted purchase invoice has been either corrected or canceled.', FRA = 'Spécifie si la facture achat validée a été corrigée ou annulée.';
        }
        modify(Corrective)
        {
            ToolTipML = ENU = 'Specifies if the posted purchase invoice is a corrective document.', FRA = 'Indique si la facture achat validée est un document de correction.';
        }
        addafter("Buy-from Vendor Name")
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = all;
            }
        }

        addafter("Shipment Method Code")
        {
            // BC Upgrade VAMSIU01 - Added Document subtype field >>
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Remaining Amount")
        {
            field("Payment Status"; Rec."Payment Status FND")
            {
                ApplicationArea = all;

            }
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = all;

            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;

            }
            field("Blanket Order No."; Rec."Blanket Order No. FND")
            {
                ApplicationArea = all;

            }
        }
        addafter(Corrective)
        {
            // field("Tax Date"; "Tax Date")
            // {
            //     Visible = false;
            // }  //BC Upgrade GUNREM01 -DIT field

            // field("Vendor Invoice No.";Rec. "Vendor Invoice No.")
            // {
            //     Visible = false;
            // } //BC Upgrade GUNREM01 fields already available in BC 
            field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
    actions
    {
        modify("&Invoice")
        {
            CaptionML = ENU = '&Invoice', FRA = 'Fa&cture';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
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
        modify(IncomingDoc)
        {
            CaptionML = ENU = 'Incoming Document', FRA = 'Document entrant';
        }
        // modify(Navigation)
        // {
        //     CaptionML = ENU = 'Navigation', FRA = 'Navigation';
        // } //BC Upgrade GUNREM01 -Navigation action is not there is bC 
        modify(Vendor)
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
            ToolTipML = ENU = 'View or edit detailed information about the vendor on the selected posted purchase document.', FRA = 'Affichez ou modifiez des informations détaillées concernant le fournisseur sur le document achat sélectionné validé.';
        }
        modify(ShowCreditMemo)
        {
            CaptionML = ENU = 'Show Canceled/Corrective Credit Memo', FRA = 'Afficher avoir annulé/de correction';
            ToolTipML = ENU = 'Open the posted purchase credit memo that was created when you canceled the posted purchase invoice. If the posted purchase invoice is the result of a canceled purchase credit memo, then canceled purchase credit memo will open.', FRA = 'Ouvrez l''avoir achat validé qui a été créé lorsque vous avez annulé la facture achat validée. Si la facture achat validée est le résultat d''un avoir achat annulé, ce dernier s''ouvrira.';
        }
        modify(Navigate)
        {
            CaptionML = ENU = '&Navigate', FRA = '&Naviguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected posted purchase document.', FRA = 'Recherchez toutes les écritures et les documents qui existent pour le numéro de document et la date comptabilisation sur le document achat validé sélectionné.';
        }
        modify(Correct)
        {
            CaptionML = ENU = 'Correct', FRA = 'Corriger';
        }
        modify(CorrectInvoice)
        {
            CaptionML = ENU = 'Correct', FRA = 'Corriger';
            ToolTipML = ENU = 'Reverse this posted invoice and automatically create a new invoice with the same information that you can correct before posting. This posted invoice will automatically be canceled.', FRA = 'Contrepassez cette facture enregistrée et créez automatiquement une nouvelle facture avec les mêmes informations, que vous aurez la possibilité de corriger avant de procéder à la validation. Cette facture enregistrée sera automatiquement annulée.';
        }
        modify(CancelInvoice)
        {
            CaptionML = ENU = 'Cancel', FRA = 'Annuler';
            ToolTipML = ENU = 'Create and post a purchase credit memo that reverses this posted purchase invoice. This posted purchase invoice will be canceled.', FRA = 'Créez et validez un avoir achat qui contrepasse cette facture achat validée. Cette facture achat validée sera annulée.';
        }
        modify(CreateCreditMemo)
        {
            CaptionML = ENU = 'Create Corrective Credit Memo', FRA = 'Créer un avoir correctif';
            ToolTipML = ENU = 'Create a credit memo for this posted invoice that you complete and post manually to reverse the posted invoice.', FRA = 'Créez un avoir pour cette facture enregistrée, à compléter et valider manuellement pour contrepasser la facture enregistrée.';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            ToolTipML = ENU = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.', FRA = 'Préparez-vous à imprimer le document. Une fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';
        }


        //Unsupported feature: CodeModification on "CreateCreditMemo(Action 11).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CorrectPostedPurchInvoice.CreateCreditMemoCopyDocument(Rec,PurchaseHeader);
        PAGE.RUN(PAGE::"Purchase Credit Memo",PurchaseHeader);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.06>>
        if CheckDocSubTypeCode then
          ERROR(Text50000);
        //HEI.06<<

        CorrectPostedPurchInvoice.CreateCreditMemoCopyDocument(Rec,PurchaseHeader);
        PAGE.RUN(PAGE::"Purchase Credit Memo",PurchaseHeader);
        */
        //end;


        //Unsupported feature: CodeModification on ""&Print"(Action 22).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(PurchInvHeader);
        PurchInvHeader.PrintRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
        PurchInvHeader := Rec;
        //>> DITW18.00.07 AKH DIT-770 #1508
        CurrPage.SETSELECTIONFILTER(PurchInvHeader);
        PurchInvHeader.PrintRecords(true);
        */
        //end;
    }

    var
        Text50000: Label 'You cannot create a corrective credit memo for this Document Subtype';

    // BC Upgrade VAMSIU01 - Added Document Subtype Code >>
    local procedure CheckDocSubTypeCode(): Boolean;
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DocumentSubtypeCode: Record "Document Subtype Code FND";
    begin
        //HEI.06>>
        PurchasesPayablesSetup.GET;
        DocumentSubtypeCode.RESET;
        DocumentSubtypeCode.SETRANGE("Report Selection Type", DocumentSubtypeCode."Report Selection Type"::Purchase);
        DocumentSubtypeCode.SETFILTER(Code, PurchasesPayablesSetup."Corrective CM Not Allowed FND");
        if DocumentSubtypeCode.FINDSET then begin
            if (DocumentSubtypeCode.Code = Rec."Document Subtype Code FND") or (Rec."Document Subtype Code FND" = '') then
                exit(true);
        end;
        exit(false);
        //HEI.06<<
    end;
    // BC Upgrade VAMSIU01 - Added Document Subtype Code <<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

