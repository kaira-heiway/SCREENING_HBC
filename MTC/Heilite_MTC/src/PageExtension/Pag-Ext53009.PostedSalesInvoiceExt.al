pageextension 53009 PostedSalesInvoiceExt extends "Posted Sales Invoice"
{
    // version NAVW110.0.00.15601,FINXL10.00,IPLXL9.00.001,DITW110.00.11,HEI.18
    /* 
    HEI.01 FDD-KDD0TC005 IBM NASTAA02 9.11.2017 # RPM Billing and Reporting
  # Action Button added to open linked Credit Memo
HEI.02 FDD-KDD0TC005 IBM NASTAA02 19.12.2017 # RPM Billing and Reporting
  # Action Button added to print the Global Sales Invoice Report
HEI.03 RW-GAPLOG08 IBM LAZARE02 23.10.2018 # New field EBM Status and new actions Send to EBM, EBM Details for EBM interface
HEI.04 HT453 - CHG2011093 IBM GAVANM01 20.06.2019
  # New fields added: "Bill Of Lading No.", "Vessel Name", "ETD", "ETA", "Air Way Bill No", "Commodity Code", "Custom Tariff Code", "InCo Terms"
HEI.05 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
  # New Field added: "Suppress POS Interface"
  # New Page Actions created: "Send to Maraki", "Maraki Details"
HEI.06 FDD-HT634 IBM GAVANM01 27.08.2019 # New field added in Foreign Trade tab - "Country of Origin"
HEI.07 CHG2010375 IBM.LS 21.01.2020
  # New Field added: "Send Document"
  # New Field added: "Mail Sent"
HEI.08 CHG2044105 IBM.AB 07.01.2020
  # New field Invoice Receipt No added in Invoice Details Group
HEI.09 CHG2010375 IBM.LS 26.02.2020
  # Code added.
HEI.11 CHG2064677 IBM SHANKJ03 27.02.2020
  #Added code to select burundi layouts
HEI.12 CHG2065153 IBM KUMARN15 23.06.2020
  # Added field "Source System Identifier"
HEI.13 CHG2070787-HB1562 IBM GAVANM01 03.09.2020 - Update all Billing documents in line with Global (for the BAHAMAS)
  # New action added in General tab, called 'Print Debit Note'
HEI.14 FDD-HB1880 CHG2089830 IBM NASTAA02 23.12.2020 # Fix Invoice Creation Date
  # Added field "Creation Date/Time"
HEI.15 CHG2151260-HB2788 SOICAD02 08.11.2022 Send to EBMS and EBMS Details
HEI.16 CHG2151260-HB2788 SOICAD02 23.12.2022 Send to EBMS and EBMS Details
  # Change send to EBMS to promoted
HEI.17 CHG2151260 HB2788 BHANDS01 03.01.2023 # Burundi Fiscal Invoice
  # Link to EBMS Page corrected
HEI.18 CHG2194603 HB3289 COSTES04 19.10.2023 new actions Send to PAC and PAC Details
  # New actions added
     */
    // BC Upgrade BHARDA11 >>
    // 1. Remove Drink-IT Fields and related code.
    // 2. Remove Interface Fields and Related code and actions to the Interface Extension.
    // 3. There is a custom code in Print Button for that code we use this event OnBeforeSalesInvHeaderPrintRecords in Codeunit heniken BC Upgrade MTC
    // 4. Blocked as PAC is not in scope.
    // 5. Remove Drink-IT Customization. 
    // 6. Add Application Area Property in Fields and Actions.
    // BC Upgrade BHARDA11 <<

    // BC Upgrade SHUKLP03  >> Added Fields("Document Subtype Code") and it's code.

    DeleteAllowed = false;

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the posted invoice number.', FRA = 'Spécifie le numéro de facture enregistrée.';
        }
        modify("Sell-to Customer Name")
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
            ToolTipML = ENU = 'Specifies the name of the customer that you shipped the items on the invoice to.', FRA = 'Spécifie le nom du client à qui vous avez expédié les articles mentionnés sur la facture.';
        }
        modify("Sell-to")
        {
            CaptionML = ENU = 'Sell-to', FRA = 'Donneur d''ordre';
        }
        modify("Sell-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address of the customer that the items on the invoice were shipped to.', FRA = 'Spécifie l''adresse du client à qui vous avez expédié les articles mentionnés sur la facture.';
        }
        modify("Sell-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';
        }
        modify("Sell-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Sell-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city the items on the invoice were shipped to.', FRA = 'Spécifie la ville vers laquelle les articles de la facture ont été expédiés.';
        }
        modify("Sell-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of the contact that the invoice was sent to.', FRA = 'Spécifie le numéro du contact auquel vous avez envoyé la facture.';
        }
        modify("Sell-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person to contact when you communicate with the customer who you shipped the items to.', FRA = 'Spécifie le nom de la personne que vous contactez lorsque vous communiquez avec le client auquel vous avez expédié les articles.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on which you created the sales document.', FRA = 'Spécifie la date à laquelle vous avez créé le document vente.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the invoice was posted.', FRA = 'Spécifie la date de validation de la facture.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the invoice is due for payment.', FRA = 'Spécifie la date à laquelle la facture doit être payée.';
        }
        modify("Document Exchange Status")
        {
            ToolTipML = ENU = 'Specifies the status of the document if you are using a document exchange service to send it as an electronic document. The status values are reported by the document exchange service.', FRA = 'Spécifie le statut du document si vous utilisez un service d''échange de documents pour l''envoyer en tant que document électronique. Les valeurs du statut sont rapportées par le service d''échange de documents.';
        }
        modify("Quote No.")
        {
            ToolTipML = ENU = 'Specifies the number of the sales quote document if a quote was used to start the sales process.', FRA = 'Spécifie le numéro du document devis si un devis a été utilisé pour démarrer le processus de vente.';

            //Unsupported feature: Change Editable on ""Quote No."(Control 114)". Please convert manually.

        }
        modify("Order No.")
        {
            ToolTipML = ENU = 'Specifies the number of the sales order that this invoice was posted from.', FRA = 'Spécifie le numéro de la commande vente à partir de laquelle la facture a été validée.';
        }
        modify("Pre-Assigned No.")
        {
            ToolTipML = ENU = 'Specifies the number of the sales document that the posted invoice was created for.', FRA = 'Spécifie le numéro du document vente pour lequel la facture enregistrée a été créée.';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies the external document number that is entered on the sales header that this line was posted from.', FRA = 'Spécifie le numéro de document externe qui est saisi sur l''en-tête vente à partir duquel la ligne a été validée.';
        }
        modify("Salesperson Code")
        {
            ToolTipML = ENU = 'Specifies which salesperson is associated with the invoice.', FRA = 'Spécifie le nom du vendeur associé à la facture.';
        }
        modify("Responsibility Center")
        {

            //Unsupported feature: Change AccessByPermission on ""Responsibility Center"(Control 92)". Please convert manually.

            ToolTipML = ENU = 'Specifies the code of the responsibility center associated with the user who created the invoice, your company, or the customer in the sales invoice.', FRA = 'Spécifie le code du centre de gestion associé à l''utilisateur qui a créé la facture, votre société ou le client de la facture vente.';
        }
        modify("No. Printed")
        {
            ToolTipML = ENU = 'Specifies how many times the invoice has been printed.', FRA = 'Spécifie combien de fois la facture a été imprimée.';
        }
        modify(Cancelled)
        {
            ToolTipML = ENU = 'Specifies if the posted sales invoice has been either corrected or canceled.', FRA = 'Spécifie si la facture vente validée a été corrigée ou annulée.';
        }
        modify(Corrective)
        {
            ToolTipML = ENU = 'Specifies if the posted sales invoice is a corrective document.', FRA = 'Indique si la facture vente validée est un document de correction.';
        }
        modify(Closed)
        {
            ToolTipML = ENU = 'Specifies if the posted invoice is paid. The check box will also be selected if a credit memo for the remaining amount has been applied.', FRA = 'Spécifie si la facture validée est payée. La case à cocher est également activée si un avoir pour le montant ouvert a été lettré à la facture achat enregistrée.';
        }
        modify("Work Description")
        {
            CaptionML = ENU = 'Work Description', FRA = 'Description du travail';
        }
        modify(GetWorkDescription)
        {

            //Unsupported feature: Change MultiLine on "GetWorkDescription(Control 82)". Please convert manually.

            ShowCaption = false;
        }

        //Unsupported feature: Change SubPageLink on "SalesInvLines(Control 54)". Please convert manually.


        //Unsupported feature: Change PagePartID on "SalesInvLines(Control 54)". Please convert manually.

        modify("Invoice Details")
        {
            CaptionML = ENU = 'Invoice Details', FRA = 'Détails facture';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code of the invoice.', FRA = 'Spécifie le code devise de la facture.';
        }
        modify("Shipment Date")
        {
            ToolTipML = ENU = 'Specifies the shipment date. It is copied from the Shipment Date field on the sales header and is used for planning purposes.', FRA = 'Spécifie la date d''expédition. La date est copiée à partir du champ Date de préparation de l''en-tête vente et utilisée à des fins de planification.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the sales document.', FRA = 'Spécifie une formule qui calcule la date d''échéance du paiement, la date d''escompte et le montant de la remise sur le document de vente.';
        }
        modify("Payment Method Code")
        {
            ToolTipML = ENU = 'Specifies how the customer must pay for products on the sales document.', FRA = 'Spécifie de quelle manière le client doit régler les produits figurant sur le document vente.';
        }
        modify(SelectedPayments)
        {
            CaptionML = ENU = 'Payment Service', FRA = 'Service de paiement';
            ToolTipML = ENU = 'Specifies the payment service, such as PayPal, that the sales invoice can be paid with.', FRA = 'Spécifie le service de paiement, comme PayPal, avec lequel il est possible de payer la facture vente.';

            //Unsupported feature: Change MultiLine on "SelectedPayments(Control 64)". Please convert manually.

        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the invoice.', FRA = 'Spécifie le code section analytique associé à la facture.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the invoice.', FRA = 'Spécifie le code section analytique associé à la facture.';
        }
        modify("Payment Discount %")
        {
            ToolTipML = ENU = 'Specifies the payment discount percentage granted if payment is made by the date entered in the Pmt. Discount Date field.', FRA = 'Spécifie le pourcentage escompte accordé si le paiement est effectué au plus tard à la date saisie dans le champ Date d''escompte.';
        }
        modify("Pmt. Discount Date")
        {
            ToolTipML = ENU = 'Specifies the date by which the invoice must be paid to obtain a payment discount.', FRA = 'Spécifie la date à laquelle la facture doit être payée pour obtenir un escompte.';
        }
        modify("Direct Debit Mandate ID")
        {
            ToolTipML = ENU = 'Specifies the direct-debit mandate that the customer has signed to allow direct debit collection of payments.', FRA = 'Spécifie le mandat de prélèvement que le client a signé pour autoriser un prélèvement automatique des paiements.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code for the location from which the items were shipped.', FRA = 'Spécifie le code du magasin à partir duquel les articles ont été expédiés.';
        }
        modify("Shipping and Billing")
        {
            CaptionML = ENU = 'Shipping and Billing', FRA = 'Expédition et facturation';
        }
        modify("Shipping Details")
        {
            CaptionML = ENU = 'Shipping Details', FRA = 'Détails expédition';
        }
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Method', FRA = 'Méthode';
            ToolTipML = ENU = 'Specifies the code that represents the shipment method for the invoice.', FRA = 'Spécifie le code qui représente les conditions de livraison de la facture.';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Agent', FRA = 'Agent';
            ToolTipML = ENU = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
        }
        modify("Package Tracking No.")
        {
            ToolTipML = ENU = 'Specifies the shipping agent''s package number.', FRA = 'Spécifie le numéro récépissé du transporteur.';
        }
        modify("Ship-to")
        {
            CaptionML = ENU = 'Ship-to', FRA = 'Destinataire';
        }
        modify("Ship-to Code")
        {
            CaptionML = ENU = 'Address Code', FRA = 'Code adresse';
            ToolTipML = ENU = 'Specifies the address on purchase orders shipped with a drop shipment directly from the vendor to a customer.', FRA = 'Spécifie l''adresse des bons de commande expédiés par livraison directe du fournisseur au client.';
        }
        modify("Ship-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the name of the customer that the items were shipped to.', FRA = 'Spécifie le nom du client auquel les articles ont été expédiés.';
        }
        modify("Ship-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address that the items on the invoice were shipped to.', FRA = 'Spécifie l''adresse à laquelle les articles mentionnés sur la facture ont été expédiés.';
        }
        modify("Ship-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';
        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Ship-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city the items on the invoice were shipped to.', FRA = 'Spécifie la ville vers laquelle les articles de la facture ont été expédiés.';
        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person you regularly contact at the address that the items were shipped to.', FRA = 'Spécifie le nom de la personne que vous contactez régulièrement à l''adresse à laquelle les articles ont été livrés.';
        }
        modify("Bill-to")
        {
            CaptionML = ENU = 'Bill-to', FRA = 'Facturation';
        }
        modify("Bill-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the name of the customer that the invoice was sent to.', FRA = 'Spécifie le nom du client auquel la facture a été envoyée.';
        }
        modify("Bill-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address of the customer that the invoice was sent to.', FRA = 'Spécifie l''adresse du client à laquelle la facture a été envoyée.';
        }
        modify("Bill-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';
        }
        modify("Bill-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Bill-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city of the customer that the invoice was sent to.', FRA = 'Spécifie la ville du client auquel la facture a été envoyée.';
        }
        modify("Bill-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of the contact the invoice was sent to.', FRA = 'Spécifie le numéro du contact auquel vous avez envoyé la facture.';
        }
        modify("Bill-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person you regularly contact when you communicate with the customer to whom the invoice was sent.', FRA = 'Spécifie le nom de la personne que vous contactez régulièrement lorsque vous communiquez avec le client facturé.';
        }
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        }
        modify("EU 3-Party Trade")
        {
            ToolTipML = ENU = 'Specifies whether the invoice was part of an EU 3-party trade transaction.', FRA = 'Spécifie si la facture faisait partie d''une transaction tripartite.';
        }
        modify("Transaction Specification")
        {
            ToolTipML = ENU = 'Specifies the transaction specification that was used in the invoice.', FRA = 'Spécifie le régime utilisé pour la facture.';
        }
        modify("Transport Method")
        {
            ToolTipML = ENU = 'Specifies the transport method of the sales header that this line was posted from.', FRA = 'Spécifie le mode de transport de l''en-tête vente à partir duquel cette ligne a été validée.';
        }
        modify("Exit Point")
        {
            ToolTipML = ENU = 'Specifies the code of the port of exit through which you shipped the items out of your country/region.', FRA = 'Spécifie le code du point de sortie par lequel les articles sortent de votre pays/région.';
        }
        modify("Area")
        {
            ToolTipML = ENU = 'Specifies the area code used in the invoice.', FRA = 'Spécifie le code zone utilisé pour la facture.';
        }

        //Unsupported feature: Change PagePartID on "IncomingDocAttachFactBox(Control 11)". Please convert manually.


        //Unsupported feature: Change ShowFilter on "IncomingDocAttachFactBox(Control 11)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "General(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Customer Name"(Control 61)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Customer Name"(Control 61)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to"(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Address"(Control 63)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Address"(Control 63)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Address 2"(Control 65)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Address 2"(Control 65)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Post Code"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Post Code"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to City"(Control 67)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to City"(Control 67)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact No."(Control 96)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact No."(Control 96)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact"(Control 69)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact"(Control 69)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Date"(Control 25)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Date"(Control 25)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Due Date"(Control 68)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Due Date"(Control 68)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control3(Control 3)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Exchange Status"(Control 27)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Exchange Status"(Control 27)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Quote No."(Control 114)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Quote No."(Control 114)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Order No."(Control 86)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Order No."(Control 86)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Pre-Assigned No."(Control 73)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Pre-Assigned No."(Control 73)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""External Document No."(Control 94)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""External Document No."(Control 94)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Salesperson Code"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Salesperson Code"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Responsibility Center"(Control 92)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Responsibility Center"(Control 92)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No. Printed"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No. Printed"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Cancelled(Control 77)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Cancelled(Control 77)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Corrective(Control 102)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Corrective(Control 102)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Closed(Control 76)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Closed(Control 76)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Work Description"(Control 83)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "GetWorkDescription(Control 82)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "GetWorkDescription(Control 82)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Invoice Details"(Control 16)". Please convert manually.


        //Unsupported feature: CodeModification on ""Currency Code"(Control 30).OnAssistEdit". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ChangeExchangeRate.SetParameter("Currency Code","Currency Factor","Posting Date");
        ChangeExchangeRate.EDITABLE(false);
        if ChangeExchangeRate.RUNMODAL = ACTION::OK then begin
          "Currency Factor" := ChangeExchangeRate.GetParameter;
          MODIFY;
        end;
        CLEAR(ChangeExchangeRate);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ChangeExchangeRate.SetParameter("Currency Code","Currency Factor","Posting Date");
        ChangeExchangeRate.EDITABLE(FALSE);
        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
          "Currency Factor" := ChangeExchangeRate.GetParameter;
          MODIFY;
        END;
        CLEAR(ChangeExchangeRate);
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Currency Code"(Control 30)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Currency Code"(Control 30)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 62)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 62)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Payment Terms Code"(Control 50)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Payment Terms Code"(Control 50)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Payment Method Code"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Payment Method Code"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control15(Control 15)". Please convert manually.



        //Unsupported feature: CodeModification on "SelectedPayments(Control 64).OnAssistEdit". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PaymentServiceSetup.ChangePaymentServicePostedInvoice(Rec);
        CurrPage.UPDATE(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PaymentServiceSetup.ChangePaymentServicePostedInvoice(Rec);
        CurrPage.UPDATE(FALSE);
        */
        //end;

        //Unsupported feature: PropertyDeletion on "SelectedPayments(Control 64)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 66)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 66)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Payment Discount %"(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Payment Discount %"(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Pmt. Discount Date"(Control 7)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Pmt. Discount Date"(Control 7)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Direct Debit Mandate ID"(Control 70)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Direct Debit Mandate ID"(Control 70)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 48)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 48)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping and Billing"(Control 53)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Details"(Control 80)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Method Code"(Control 71)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Method Code"(Control 71)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Code"(Control 79)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Code"(Control 79)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Package Tracking No."(Control 81)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Package Tracking No."(Control 81)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to"(Control 1905885101)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Code"(Control 56)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Code"(Control 56)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Name"(Control 46)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Name"(Control 46)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Address"(Control 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Address"(Control 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Address 2"(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Address 2"(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Post Code"(Control 40)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Post Code"(Control 40)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to City"(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to City"(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Contact"(Control 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Contact"(Control 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to"(Control 60)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Name"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Name"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Address"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Address"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Address 2"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Address 2"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Post Code"(Control 78)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Post Code"(Control 78)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to City"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to City"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact No."(Control 98)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact No."(Control 98)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Foreign Trade"(Control 1907468901)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""EU 3-Party Trade"(Control 52)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""EU 3-Party Trade"(Control 52)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transaction Specification"(Control 31)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transaction Specification"(Control 31)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transport Method"(Control 72)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transport Method"(Control 72)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Exit Point"(Control 74)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Exit Point"(Control 74)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Area(Control 75)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Area(Control 75)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

        addafter("Sell-to Contact")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Building No.", "Your Reference", "Posting Description", OGM)
            // field("Building No."; Rec."Building No.")
            // {
            //     Editable = false;
            // }
            // field("Your Reference"; Rec."Your Reference")
            // {
            //     Description = 'FINXL7.00.001';
            //     Editable = false;
            // }
            // field("Posting Description"; Rec."Posting Description")
            // {
            //     Description = 'FINXL7.00.001';
            //     Editable = false;
            // }
            // field(OGM; Rec.OGM)
            // {
            //     Description = 'FINXL7.00.001';
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Building No.", "Your Reference", "Posting Description", OGM)
        }
        addafter("Due Date")
        {
            field("Doc. Amount Incl. VAT"; Rec."Doc. Amount Incl. VAT FND")
            {
                ApplicationArea = All;
            }
            field("Doc. Amount VAT"; Rec."Doc. Amount VAT FND")
            {
                ApplicationArea = All;
            }
            field("Vans Sales Route"; Rec."Vans Sales Route FND")
            {
                ApplicationArea = All;
            }

            // BC Upgrade BHARDA11 >> ----Drink-IT Fields( "Creation Date/Time")

            // field("Creation Date/Time"; Rec."Creation Date/Time")
            // {
            //     ApplicationArea = All;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields(,  "Creation Date/Time")
        }
        addafter(Control3)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Tax Date")
            // field("Tax Date"; Rec."Tax Date")
            // {
            //     Editable = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Tax Date")
        }
        addafter("No. Printed")
        {
            field("Send Document"; Rec."Send Document FND")
            {
                ApplicationArea = All;
            }
            field("Mail Sent"; Rec."Mail Sent FND")
            {
                ApplicationArea = All;
            }
        }
        addafter("Payment Method Code")
        {
            // BC Upgrade SHUKLP03  >> Added Fields("Document Subtype Code")
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                Description = '<DITW18.00.07 DIT-770 #1508>-NRQ#17902';
                ApplicationArea = All;
                Importance = Additional;
            }

            // BC Upgrade SHUKLP03 << Added  ----Drink-IT Fields("Document Subtype Code")

            field("Invoice Receipt No."; Rec."Invoice Receipt No. FND")
            {
                ApplicationArea = All;
            }
        }
        addafter(Control15)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Customer DTax Group Code", "Invoice List Customer No.", "Invoice List Document No.")
            // field("Customer DTax Group Code"; Rec."Customer DTax Group Code")
            // {
            //     Editable = false;
            // }
            // field("Invoice List Customer No."; Rec."Invoice List Customer No.")
            // {
            //     Description = 'DITW17.10.05 DIT-715 #761';
            //     Editable = false;
            // }
            // field("Invoice List Document No."; Rec."Invoice List Document No.")
            // {
            //     Description = 'DITW17.10.05 DIT-715 #761';
            //     Editable = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Customer DTax Group Code", "Invoice List Customer No.", "Invoice List Document No.")

        }
        addafter("Bill-to")
        {

        }
        addafter("Location Code")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Physical Location Group Code", "Truck Code", "Driver Code")
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Editable = false;
            //     Importance = Additional;
            // }
            // field("Truck Code"; Rec."Truck Code")
            // {
            //     Editable = false;
            // }
            // field("Driver Code"; Rec."Driver Code")
            // {
            //     Editable = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Physical Location Group Code", "Truck Code", "Driver Code")

            field("Bill Of Lading No."; Rec."Bill Of Lading No. FND")
            {
                ApplicationArea = All;
            }
            field("Vessel Name"; Rec."Vessel Name FND")
            {
                ApplicationArea = All;
            }
            field(ETD; Rec."ETD FND")
            {
                ApplicationArea = All;
            }
            field(ETA; Rec."ETA FND")
            {
                ApplicationArea = All;
            }
            field("Air Way Bill No"; Rec."Air Way Bill No FND")
            {
                ApplicationArea = All;
            }
            field("Commodity Code"; Rec."Commodity Code FND")
            {
                ApplicationArea = All;
            }
            field("Custom Tariff Code"; Rec."Custom Tariff Code FND")
            {
                ApplicationArea = All;
            }
            field("InCo Terms"; Rec."InCo Terms FND")
            {
                ApplicationArea = All;
            }
        }
        addafter("Area")
        {
            field("Country of Origin"; Rec."Country of Origin FND")
            {
                ApplicationArea = All;
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Contract Type", "DIT Sub-Contract Type", "Service Contract No.", "Financial Contract No.", "Contract Group Code")
            // group("Service/Contract")
            // {
            //     CaptionML = ENU = 'Service/Contract',
            //                 FRA = 'Service/ Contrat';
            //     field("Contract Type"; Rec."Contract Type")
            //     {
            //         Editable = false;
            //     }
            //     field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
            //     {
            //     }
            //     field("Service Contract No."; Rec."Service Contract No.")
            //     {
            //     }
            //     field("Financial Contract No."; Rec."Financial Contract No.")
            //     {
            //     }
            //     field("Contract Group Code"; Rec."Contract Group Code")
            //     {
            //     }
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Contract Type", "DIT Sub-Contract Type", "Service Contract No.", "Financial Contract No.", "Contract Group Code")
        }
        // moveafter("Control 70"; Rec."Shipping and Billing")
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

            //Unsupported feature: Change RunObject on "Statistics(Action 8)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "Statistics(Action 8)". Please convert manually.

            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';

            //Unsupported feature: Change RunObject on ""Co&mments"(Action 57)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Co&mments"(Action 57)". Please convert manually.

            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Dimensions)
        {

            //Unsupported feature: Change AccessByPermission on "Dimensions(Action 89)". Please convert manually.

            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
            Promoted = true;
            PromotedIsBig = true;
            PromotedOnly = true;
        }
        modify(Approvals)
        {

            //Unsupported feature: Change AccessByPermission on "Approvals(Action 112)". Please convert manually.

            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
            Promoted = true;
            PromotedIsBig = true;
            PromotedOnly = true;
        }
        modify(ChangePaymentService)
        {
            CaptionML = ENU = 'Change Payment Service', FRA = 'Modifier le service de paiement';
            ToolTipML = ENU = 'Change or add the payment service, such as PayPal Standard, that will be included on the sales document so the customer can quickly access the payment site.', FRA = 'Modifiez ou ajoutez le service de paiement, comme PayPal Standard, qui sera inclus au document vente de sorte que le client pourra rapidement accéder au site de paiement.';
            Promoted = true;
            PromotedIsBig = true;
            PromotedOnly = true;
        }
        modify(ActionGroupCRM)
        {
            CaptionML = ENU = 'Dynamics CRM', FRA = 'Dynamics CRM';
        }
        modify(CRMGotoInvoice)
        {
            CaptionML = ENU = 'Invoice', FRA = 'Facturer';
            ToolTipML = ENU = 'Open the coupled Microsoft Dynamics CRM account.', FRA = 'Ouvrez le compte Microsoft Dynamics CRM couplé.';
        }
        modify(CreateInCRM)
        {
            CaptionML = ENU = 'Create Invoice in Dynamics CRM', FRA = 'Créer une facture dans Dynamics CRM';
            ToolTipML = ENU = 'Create a sales invoice in Dynamics CRM that is connected to this posted sales invoice.', FRA = 'Créez une facture vente dans Dynamics CRM en lien à cette facture vente validée.';
        }
        modify(SendCustom)
        {

            //Unsupported feature: Change Ellipsis on "SendCustom(Action 5)". Please convert manually.

            CaptionML = ENU = 'Send', FRA = 'Envoyer';
            ToolTipML = ENU = 'Prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.', FRA = 'Préparez-vous à envoyer le document en fonction du profil d''envoi du client, par exemple en pièce jointe d''un e-mail. La fenêtre Envoyer le document à s''ouvre en premier pour que vous puissiez confirmer ou sélectionner un profil d''envoi.';
            Promoted = true;
            PromotedIsBig = true;
            PromotedOnly = true;
        }
        modify(Print)
        {
            // BC Upgrade BHARDA11 ---There is a custom code in this button for that code we use this event OnBeforeSalesInvHeaderPrintRecords in Codeunit heniken BC Upgrade MTC
            //Unsupported feature: Change Ellipsis on "Print(Action 58)". Please convert manually.

            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            ToolTipML = ENU = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.', FRA = 'Préparez-vous à imprimer le document. Une fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';
        }

        modify(Email)
        {
            CaptionML = ENU = '&Email', FRA = '&Adresse e-mail';
            ToolTipML = ENU = 'Prepare to email the document. The Send Email window opens prefilled with the customer''s email address so you can add or edit information.', FRA = 'Préparez-vous à envoyer le document par e-mail. La fenêtre Envoyer e-mail s''ouvre préremplie avec l''adresse e-mail du client pour que vous puissiez ajouter ou modifier des informations.';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document.';
        }
        modify(ActivityLog)
        {
            CaptionML = ENU = 'Activity Log', FRA = 'Journal des activités';
            ToolTipML = ENU = 'View the status and any errors if the document was sent as an electronic document or OCR file through the document exchange service.', FRA = 'Affichez le statut et les erreurs si le document a été envoyé en tant que document électronique ou fichier OCR via le service d''échange de documents.';
        }
        modify(IncomingDocument)
        {
            CaptionML = ENU = 'Incoming Document', FRA = 'Document entrant';
        }
        modify(IncomingDocCard)
        {
            CaptionML = ENU = 'View Incoming Document', FRA = 'Afficher le document entrant';
        }
        modify(SelectIncomingDoc)
        {

            //Unsupported feature: Change AccessByPermission on "SelectIncomingDoc(Action 19)". Please convert manually.

            CaptionML = ENU = 'Select Incoming Document', FRA = 'Sélectionner le document entrant';
        }
        modify(IncomingDocAttachFile)
        {

            //Unsupported feature: Change Ellipsis on "IncomingDocAttachFile(Action 17)". Please convert manually.

            CaptionML = ENU = 'Create Incoming Document from File', FRA = 'Créer un document entrant à partir d''un fichier';
        }
        modify(Correct)
        {
            CaptionML = ENU = 'Correct', FRA = 'Corriger';
        }
        modify(CorrectInvoice)
        {
            CaptionML = ENU = 'Correct', FRA = 'Corriger';
            ToolTipML = ENU = 'Reverse this posted invoice and automatically create a new invoice with the same information that you can correct before posting. This posted invoice will automatically be canceled.', FRA = 'Contrepassez cette facture enregistrée et créez automatiquement une nouvelle facture avec les mêmes informations, que vous aurez la possibilité de corriger avant de procéder à la validation. Cette facture enregistrée sera automatiquement annulée.';
            Promoted = true;
            PromotedIsBig = true;
            PromotedOnly = true;
        }
        modify(CancelInvoice)
        {
            CaptionML = ENU = 'Cancel', FRA = 'Annuler';
            ToolTipML = ENU = 'Create and post a sales credit memo that reverses this posted sales invoice. This posted sales invoice will be canceled.', FRA = 'Créez et validez un avoir vente qui contrepasse cette facture vente validée. Cette facture vente validée sera annulée.';
            Promoted = true;
            PromotedIsBig = true;
            PromotedOnly = true;
        }
        modify(CreateCreditMemo)
        {
            CaptionML = ENU = 'Create Corrective Credit Memo', FRA = 'Créer un avoir correctif';
            ToolTipML = ENU = 'Create a credit memo for this posted invoice that you complete and post manually to reverse the posted invoice.', FRA = 'Créez un avoir pour cette facture enregistrée, à compléter et valider manuellement pour contrepasser la facture enregistrée.';
        }
        modify(Invoice)
        {
            CaptionML = ENU = 'Invoice', FRA = 'Facture';
        }
        modify(Customer)
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
            ToolTipML = ENU = 'View or edit detailed information about the customer.', FRA = 'Affichez ou modifiez des informations détaillées sur le client.';

            //Unsupported feature: Change RunObject on "Customer(Action 49)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "Customer(Action 49)". Please convert manually.

            Promoted = true;
            PromotedIsBig = true;
            PromotedOnly = true;
        }
        modify(ShowCreditMemo)
        {
            CaptionML = ENU = 'Show Canceled/Corrective Credit Memo', FRA = 'Afficher avoir annulé/de correction';
            ToolTipML = ENU = 'Open the posted sales credit memo that was created when you canceled the posted sales invoice. If the posted sales invoice is the result of a canceled sales credit memo, then canceled sales credit memo will open.', FRA = 'Ouvrez l''avoir vente validé qui a été créé lorsque vous avez annulé la facture vente validée. Si la facture vente validée est le résultat d''un avoir vente annulé, ce dernier s''ouvrira.';
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000003(Action 1900000003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Invoice"(Action 55)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Co&mments"(Action 57)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Approvals(Action 112)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Separator171(Action 171)". Please convert manually.



        //Unsupported feature: CodeModification on "CreateInCRM(Action 29).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CRMIntegrationManagement.CreateNewRecordInCRM(RECORDID,false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CRMIntegrationManagement.CreateNewRecordInCRM(RECORDID,FALSE);
        */
        //end;

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Print(Action 58).OnAction". Please convert manually.

        //trigger (Variable: SalesInvoiceHeaderL)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on "Print(Action 58).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SalesInvHeader := Rec;
        CurrPage.SETSELECTIONFILTER(SalesInvHeader);
        SalesInvHeader.PrintRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SalesInvHeader := Rec;
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.SalesInvLines.PAGE.SetDisableRefreshLines(TRUE);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
        SalesInvHeader := Rec;
        //>> DITW18.00.07 AKH DIT-770 #1508
        CurrPage.SETSELECTIONFILTER(SalesInvHeader);
        //HEI.09>>
        xPrintCountL := SalesInvHeader."No. Printed";
        //HEI.09<<
        //HEI.11 >>
        SalesSetup.RESET;
        SalesSetup.GET;
        CompanyInfoRec.RESET;
        CompanyInfoRec.GET;
        IF SalesSetup."Export Invoice"= TRUE THEN BEGIN
          IF CompanyInfoRec."Country/Region Code" <> Rec."Ship-to Country/Region Code" THEN
             REPORT.RUNMODAL(50385,TRUE,TRUE,SalesInvHeader)
           ELSE IF CompanyInfoRec."Country/Region Code" = Rec."Ship-to Country/Region Code" THEN
              SalesInvHeader.PrintRecords(TRUE)
            ELSE IF CompanyInfoRec."Country/Region Code" = '' THEN
              SalesInvHeader.PrintRecords(TRUE);
         END ELSE
          SalesInvHeader.PrintRecords(TRUE);
        //HEI.11 <<
        //HEI.09>>
        SalesInvoiceHeaderL.GET(SalesInvHeader."No.");
        PrintCountL := SalesInvoiceHeaderL."No. Printed";
        IF PrintCountL > xPrintCountL THEN BEGIN
          AutomationUtilityL.UpdateJQEntryAfterManualPrint(DocumentTypeL::Order,SalesInvoiceHeaderL."Order No.",
            SalesInvoiceHeaderL."No.",xPrintCountL,PrintCountL);
        END;
        //HEI.09<<
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.SalesInvLines.PAGE.SetDisableRefreshLines(FALSE);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        */
        //end;


        //Unsupported feature: CodeModification on "Email(Action 9).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SalesInvHeader := Rec;
        CurrPage.SETSELECTIONFILTER(SalesInvHeader);
        SalesInvHeader.EmailRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SalesInvHeader := Rec;
        CurrPage.SETSELECTIONFILTER(SalesInvHeader);
        SalesInvHeader.EmailRecords(TRUE);
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""&Navigate"(Action 59)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Correct(Action 41)". Please convert manually.



        //Unsupported feature: CodeModification on "CorrectInvoice(Action 39).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if CorrectPstdSalesInvYesNo.CorrectInvoice(Rec) then
          CurrPage.CLOSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF CorrectPstdSalesInvYesNo.CorrectInvoice(Rec) THEN
          CurrPage.CLOSE;
        */
        //end;


        //Unsupported feature: CodeModification on "CancelInvoice(Action 37).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if CancelPstdSalesInvYesNo.CancelInvoice(Rec) then
          CurrPage.CLOSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF CancelPstdSalesInvYesNo.CancelInvoice(Rec) THEN
          CurrPage.CLOSE;
        */
        //end;

        //Unsupported feature: PropertyDeletion on "Invoice(Action 51)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Customer(Action 49)". Please convert manually.

        addafter(ChangePaymentService)
        {
        }

        addafter(Print)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
            //     action("Print Shipment Specification")
            //     {
            //         CaptionML = ENU = 'Print Shipment Specification',
            //                     FRA = 'Imprimer spécification expédition';
            //         Image = PrintChecklistReport;
            //         Promoted = true;
            //         PromotedCategory = Process;

            //         trigger OnAction();
            //         begin
            //             //<<DITW17.00.02 RPG 18/12/2013 DIT-770 #235
            //             CurrPage.SalesInvLines.PAGE.SetDisableRefreshLines(TRUE);
            //             //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
            //             SalesInvHeader := Rec;
            //             //>> DITW18.00.07 AKH DIT-770 #1508
            //             CurrPage.SETSELECTIONFILTER(SalesInvHeader);
            //             SalesInvHeader.PrintShipmentSpecs(TRUE);
            //             CurrPage.SalesInvLines.PAGE.SetDisableRefreshLines(FALSE);
            //             //>>DITW17.00.02 RPG DIT-770 #235
            //         end;
            //     }
            // BC Upgrade BHARDA11 << ----Drink-IT Customization
            action("Print Debit Note")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Print Debit Note',
                            FRA = 'Imprimer note de débit';
                Image = PrintDocument;

                trigger OnAction();
                var
                    ReportSelections: Record "Report Selections";
                begin
                    //<<HEI.13
                    CurrPage.SalesInvLines.PAGE.SetDisableRefreshLines(TRUE);
                    SalesInvHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesInvHeader);

                    ReportSelections.RESET();
                    ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"Debit Note");
                    ReportSelections.SETFILTER("Report ID", '<>0');
                    ReportSelections.SETFILTER("Document Subtype Code FND", '=%1', SalesInvHeader."Document Subtype Code FND"); // BC Upgrade SHUKLP03 <<
                    ReportSelections.FINDSET();
                    REPORT.RUN(ReportSelections."Report ID", TRUE, FALSE, SalesInvHeader);

                    CurrPage.SalesInvLines.PAGE.SetDisableRefreshLines(FALSE);
                    //>>HEI.13
                end;
            }
        }
        addafter("&Navigate")
        {
            // BC Upgrade BHARAD11 >> ---Drink-IT Customization
            // action("Create Invoice List")
            // {
            //     CaptionML = ENU = 'Create Invoice List',
            //                 FRA = 'Créer liste des factures';
            //     Description = 'DITW17.10.05 DIT-770 #761';
            //     Image = CalculateLines;
            //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //     //PromotedCategory = Process;

            //     trigger OnAction();
            //     var
            //         lrepCreateInvoiceList: Report "2014421";
            //     begin
            //         TESTFIELD("Invoice List Customer No.");
            //         CLEAR(lrepCreateInvoiceList);
            //         SalesInvHeader.RESET;
            //         SalesInvHeader.SETFILTER("Posting Date", FORMAT("Posting Date"));
            //         SalesInvHeader.SETFILTER("Invoice List Customer No.", "Invoice List Customer No.");
            //         //<<DITW110.00.10 MSF 02/06/2017 NRQ#15500
            //         lrepCreateInvoiceList.SetReportFilters("Document Date");
            //         //>>DITW110.00.10 MSF 02/06/2017 NRQ#15500
            //         lrepCreateInvoiceList.SETTABLEVIEW(SalesInvHeader);
            //         lrepCreateInvoiceList.RUNMODAL;
            //     end;
            // }

            // BC Upgrade BHARAD11 << ---Drink-IT Customization
        }
        addafter(ActivityLog)
        {
            action("Print Global Sales Invoice")
            {
                ApplicationArea = All;
                Caption = 'Print Global Sales Invoice';
                Image = "Report";

                trigger OnAction();
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    //HEI.02>>
                    SalesInvoiceHeader.SETRANGE("Order No.", Rec."Order No.");
                    REPORT.RUNMODAL(REPORT::"Global Sales Invoice CBN", TRUE, TRUE, SalesInvoiceHeader);
                    //HEI.02<<
                end;
            }
            // BC Upgrade BHARDA11 >> - Blocked as PAC is not in scope

            // action("Send To PAC")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Send to PAC';
            //     Image = SendTo;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     trigger OnAction();
            //     var
            //         PACElectronicInvoiceMgt: Codeunit "PAC Electronic Invoice Mgt.";
            //     begin
            //         PACElectronicInvoiceMgt.ManualSalesInvoicePosting(Rec)//HEI.18
            //     end;
            // }
            // BC Upgrade BHARDA11 << - Blocked as PAC is not in scope

        }
        addafter(ShowCreditMemo)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
            // action("Invoice List")
            // {
            //     ApplicationArea = All;
            //     CaptionML = ENU = 'Invoice List',
            //                 FRA = 'Liste des factures';
            //     Description = 'DITW17.10.05  DIT-770 #761';
            //     Image = List;
            //     RunObject = Page 2014531;
            //     RunPageLink = Document No.=FIELD(Invoice List Document No.);
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Customization
            group("Open Link Posted Sales Credit Memo")
            {
                Caption = 'Open Link Posted Sales Credit Memo';
                Image = Invoice;
                action(OpenSalesCrMemoLinked)
                {
                    ApplicationArea = All;
                    Caption = 'Open Link Posted Sales Credit Memo';
                    Enabled = LinkSalesCreditMemoVisible;
                    Image = CreditMemo;

                    trigger OnAction();
                    begin
                        PAGE.RUN(PAGE::"Posted Sales Credit Memo", SalesCrMemoHeader); //HEI.01
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        //HEI.01>>
        // BC Upgrade BHARAD11 >> ---Drink-IT Field("Link Sales Document No.")
        // IF SalesCrMemoHeader.GET(Rec."Link Sales Document No.") THEN
        //     LinkSalesCreditMemoVisible := TRUE;
        // BC Upgrade BHARAD11 << ---Drink-IT Field("Link Sales Document No.")
        //HEI.01<<
    end;


    //Unsupported feature: PropertyModification on "Approvals(Action 112).OnAction.ApprovalsMgmt(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Approvals : "Approvals Mgmt.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Approvals : 1535;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ChangePaymentService(Action 35).OnAction.PaymentServiceSetup(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ChangePaymentService : "Payment Service Setup";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ChangePaymentService : 1060;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CRMGotoInvoice(Action 43).OnAction.CRMIntegrationManagement(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CRMGotoInvoice : "CRM Integration Management";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CRMGotoInvoice : 5330;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CreateInCRM(Action 29).OnAction.CRMIntegrationManagement(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CreateInCRM : "CRM Integration Management";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreateInCRM : 5330;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SendCustom(Action 5).OnAction.SalesInvHeader(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SendCustom : "Sales Invoice Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SendCustom : 112;
    //Variable type has not been exported.

    var
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
        xPrintCountL: Integer;
        PrintCountL: Integer;
        DocumentTypeL: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        AutomationUtilityL: Codeunit "Automation Utility";


    //Unsupported feature: PropertyModification on "IncomingDocCard(Action 21).OnAction.IncomingDocument(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //IncomingDocCard : "Incoming Document";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IncomingDocCard : 130;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SelectIncomingDoc(Action 19).OnAction.IncomingDocument(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SelectIncomingDoc : "Incoming Document";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SelectIncomingDoc : 130;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "IncomingDocAttachFile(Action 17).OnAction.IncomingDocumentAttachment(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //IncomingDocAttachFile : "Incoming Document Attachment";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IncomingDocAttachFile : 133;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CorrectInvoice(Action 39).OnAction.CorrectPstdSalesInvYesNo(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CorrectInvoice : "Correct PstdSalesInv (Yes/No)";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CorrectInvoice : 1322;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CancelInvoice(Action 37).OnAction.CancelPstdSalesInvYesNo(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CancelInvoice : "Cancel PstdSalesInv (Yes/No)";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CancelInvoice : 1323;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CreateCreditMemo(Action 33).OnAction.SalesHeader(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CreateCreditMemo : "Sales Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreateCreditMemo : 36;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CreateCreditMemo(Action 33).OnAction.CorrectPostedSalesInvoice(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CreateCreditMemo : "Correct Posted Sales Invoice";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreateCreditMemo : 1303;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on ""Document Exchange Status"(Control 27).OnDrillDown.DocExchServDocStatus(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //"Document Exchange Status" : "Doc. Exch. Serv.- Doc. Status";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Document Exchange Status" : 1420;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SelectedPayments(Control 64).OnAssistEdit.PaymentServiceSetup(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SelectedPayments : "Payment Service Setup";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SelectedPayments : 1060;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OnAfterGetCurrRecord.IncomingDocument(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OnAfterGetCurrRecord.IncomingDocument : "Incoming Document";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnAfterGetCurrRecord.IncomingDocument : 130;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OnAfterGetCurrRecord.CRMCouplingManagement(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OnAfterGetCurrRecord.CRMCouplingManagement : "CRM Coupling Management";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnAfterGetCurrRecord.CRMCouplingManagement : 5331;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OnOpenPage.CRMIntegrationManagement(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OnOpenPage.CRMIntegrationManagement : "CRM Integration Management";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnOpenPage.CRMIntegrationManagement : 5330;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OnOpenPage.OfficeMgt(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OnOpenPage.OfficeMgt : "Office Management";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnOpenPage.OfficeMgt : 1630;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "UpdatePaymentService(PROCEDURE 7).PaymentServiceSetup(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //UpdatePaymentService : "Payment Service Setup";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UpdatePaymentService : 1060;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SalesInvHeader(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SalesInvHeader : "Sales Invoice Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SalesInvHeader : 112;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ChangeExchangeRate(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ChangeExchangeRate : "Change Exchange Rate";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ChangeExchangeRate : 511;
    //Variable type has not been exported.

    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        LinkSalesCreditMemoVisible: Boolean;
        SalesSetup: Record "Sales & Receivables Setup";
        CompanyInfoRec: Record "Company Information";
        ReportSelecionRec: Record "Report Selections";



    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    HasIncomingDocument := IncomingDocument.PostedDocExists("No.","Posting Date");
    DocExchStatusStyle := GetDocExchStatusStyle;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    CRMIsCoupledToRecord := CRMIntegrationEnabled and CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
    UpdatePaymentService;
    DocExcStatusVisible := DocExchangeStatusIsSent;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
    UpdatePaymentService;
    DocExcStatusVisible := DocExchangeStatusIsSent;
    //HEI.01>>
    IF SalesCrMemoHeader.GET("Link Sales Document No.") THEN
      LinkSalesCreditMemoVisible := TRUE;
    //HEI.01<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocExcStatusVisible := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DocExcStatusVisible := TRUE;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

