pageextension 53014 PostedSalesInvoicesExt extends "Posted Sales Invoices"
{
    // version NAVW110.0.00.15601,DITW110.00.10,HEI.14
    /* 
    DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    DITW17.00.02 AT 07/01/2014 DIT-770 #235 : Added Print Shipment Specification
    DITW17.10.05 WSA 04/08/14 DIT-770 #761 : Added Action "Invoice List" and "Create Invoice List"
                                             Added Fields "Invoice List Customer No." "Invoice List Document No."
    DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field "Document Subtype Code" (Visible FALSE)
    DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code
    DITW18.00.07 AKH 21/04/2016 DIT-770 #1508 Adjusted filter
    DITW18.00.07 WSA 22/04/2016 DIT-770 #1723 Added Code tu support invoice list for cr memo
    DITW18.00.07A VSC 27/07/2016 DIT-770 #2117 Bugfix filter error on print action

    DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    DITW110.00.10 MSF 02/06/2017 NRQ#15500  Modify Action Create Invoice List
    HEI.01 FDD-KDD0TC005 IBM NASTAA02 9.11.2017 # RPM Billing and Reporting
      # Action Button added to open linked Credit Memo

    HEI.02 Defect #1098 IBM.NAIKH01 12.12.2017
      # Added Code on trigger OnOpenPage() and OnAfterGetRecord() , when the Value for "DocExchStatusVisible" and "CRMIntegrationEnabled"
        is False and the field is checked on the "Posted sales Invoices" Web Page an standard Uncaught error is popped so to aviod this
        error on the Web Page the Value of the Variable is set to True.
    HEI.03 RW-GAPLOG08 IBM LAZARE02 23.10.2018 # New field EBM Status and new actions Send to EBM, EBM Details for EBM interface
    HEI.04 INC0998583 IBM HORTOC01 23.11.2018 # add new fields

    HEI.05 RFC-CHG0270099 IBM.ISYED01 2.15.2019
      Added field VAT Registration No on page
    HEI.06 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
      # New Fields added: "Fiscal Printer Status", "Supress POS Interface"
      # New Page Actions created: "Send to Maraki" and "Maraki Details"
    HEI.07 CHG2044105 IBM.AB 07.01.2020
      # New Column Invoice Receipt No Created
    HEI.08 CHG2010375 IBM.LS 21.01.2020
      # New Field added: "Send Document"
      # New Field added: "Mail Sent"
    HEI.09 CHG2010375 IBM.LS 26.02.2020
      # Code added.
    HEI.10 IBM SHANKJ03
      #Added code to select burundi layouts
    HEI.11 CHG2065153 IBM KUMARN15 23.06.2020
      # Added field "Source System Identifier"
    HEI.12 CHG2151260-HB2788 COSTES04 23.12.2022 new actions Send to EBMS and EBMS Details
    HEI.13 CHG2151260 HB2788 BHANDS01 04.01.2023 # Burundi Fiscal Invoice
      # Link to EBMS Page corrected
    HEI.14 CHG2194603 HB3289 COSTES04 19.10.2023 new actions Send to PAC and PAC Details
      # New actions added
     */
    // BC Upgrade BHARDA11 >>
    // 1. Remove Drink-IT Fields and related code("Invoice List Customer No.", "Invoice List Document No.", "Document Subtype Code","Tax Date") 
    // 2. Add ApplicationArea property in fields and actions
    // BC Upgrade BHARAD11 <<

    // BC Upgrade SHUKLP03 >> Created custom action(Email_Custom) and blocked base action(Email) to add document subtype code. 
    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the posted invoice number.', FRA = 'Spécifie le numéro de facture enregistrée.';
        }
        modify("Sell-to Customer No.")
        {
            CaptionML = ENU = 'Customer No.', FRA = 'N° client';
            ToolTipML = ENU = 'Specifies the number of the customer the invoice concerns.', FRA = 'Spécifie le numéro du client concerné par la facture.';
        }
        modify("Sell-to Customer Name")
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
            ToolTipML = ENU = 'Specifies the name of the customer that you shipped the items on the invoice to.', FRA = 'Spécifie le nom du client à qui vous avez expédié les articles mentionnés sur la facture.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code of the invoice.', FRA = 'Spécifie le code devise de la facture.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the invoice is due for payment.', FRA = 'Spécifie la date à laquelle la facture doit être payée.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the total, in the currency of the invoice, of the amounts on all the invoice lines. The amount does not include VAT.', FRA = 'Spécifie le total, dans la devise de la facture des montants de toutes les lignes facture. Le montant n''inclut pas la TVA.';
        }
        modify("Amount Including VAT")
        {
            ToolTipML = ENU = 'Specifies the total of the amounts in all the amount fields on the invoice, in the currency of the invoice. The amount includes VAT.', FRA = 'Spécifie le total des montants de tous les champs montants de la facture, dans la devise de la facture. Le montant inclut la TVA.';
        }
        modify("Remaining Amount")
        {
            ToolTipML = ENU = 'Specifies the amount that remains to be paid for the posted sales invoice.', FRA = 'Spécifie le montant qui reste à payer pour la facture vente validée.';
        }
        modify("Sell-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the address.', FRA = 'Spécifie le code postal de l''adresse.';
        }
        modify("Sell-to Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code of the address.', FRA = 'Spécifie le code pays/la région de l''adresse.';
        }
        modify("Sell-to Contact")
        {
            ToolTipML = ENU = 'Specifies the name of the person to contact when you communicate with the customer that you shipped the items to.', FRA = 'Spécifie le nom de la personne que vous contactez lorsque vous communiquez avec le client auquel vous avez expédié les articles.';
        }
        modify("Bill-to Customer No.")
        {
            ToolTipML = ENU = 'Specifies the number of the customer the invoice was sent to.', FRA = 'Spécifie le numéro du client auquel vous avez envoyé la facture.';
        }
        modify("Bill-to Name")
        {
            ToolTipML = ENU = 'Specifies the name of the customer that the invoice was sent to.', FRA = 'Spécifie le nom du client auquel la facture a été envoyée.';
        }
        modify("Bill-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the address.', FRA = 'Spécifie le code postal de l''adresse.';
        }
        modify("Bill-to Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code of the address.', FRA = 'Spécifie le code pays/la région de l''adresse.';
        }
        modify("Bill-to Contact")
        {
            ToolTipML = ENU = 'Specifies the name of the person you regularly contact when you communicate with the customer to whom the invoice was sent.', FRA = 'Spécifie le nom de la personne que vous contactez régulièrement lorsque vous communiquez avec le client facturé.';
        }
        modify("Ship-to Code")
        {
            ToolTipML = ENU = 'This field is used with shipments to customers with multiple ship-to addresses.', FRA = 'Ce champ est utilisé pour les livraisons à des clients qui ont plusieurs adresses destinataire.';
        }
        modify("Ship-to Name")
        {
            ToolTipML = ENU = 'Specifies the name of the customer that the items were shipped to.', FRA = 'Spécifie le nom du client auquel les articles ont été expédiés.';
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
            ToolTipML = ENU = 'Specifies the name of the person you regularly contact at the customer to whom the items were shipped.', FRA = 'Spécifie le nom de la personne que vous contactez régulièrement chez le client auquel les articles ont été livrés.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date when the invoice was posted.', FRA = 'Spécifie la date de validation de la facture.';
        }
        modify("Salesperson Code")
        {
            ToolTipML = ENU = 'Specifies which salesperson is associated with the invoice.', FRA = 'Spécifie le nom du vendeur associé à la facture.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the invoice.', FRA = 'Spécifie le code section analytique associé à la facture.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the invoice.', FRA = 'Spécifie le code section analytique associé à la facture.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code for the location from which the items were shipped.', FRA = 'Spécifie le code du magasin à partir duquel les articles ont été expédiés.';
        }
        modify("No. Printed")
        {
            ToolTipML = ENU = 'Specifies how many times the invoice has been printed.', FRA = 'Spécifie combien de fois la facture a été imprimée.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date when you created the sales document.', FRA = 'Spécifie la date à laquelle vous avez créé le document vente.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.', FRA = 'Spécifie une formule qui calcule la date d''échéance du paiement, la date d''escompte et le montant de l''escompte sur le document achat.';
        }
        modify("Payment Discount %")
        {
            ToolTipML = ENU = 'Specifies the payment discount percentage granted if payment is made by the date entered in the Pmt. Discount Date field.', FRA = 'Spécifie le pourcentage escompte accordé si le paiement est effectué au plus tard à la date saisie dans le champ Date d''escompte.';
        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies the code that represents the shipment method for the invoice.', FRA = 'Spécifie le code qui représente les conditions de livraison de la facture.';
        }
        modify("Shipping Agent Code")
        {
            ToolTipML = ENU = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
        }
        modify(Closed)
        {
            ToolTipML = ENU = 'Specifies if the posted sales invoice is paid. The check box will also be selected if a credit memo for the remaining amount has been applied.', FRA = 'Spécifie si la facture vente validée est payée. La case à cocher est également activée si un avoir pour le montant ouvert a été lettré.';
        }
        modify(Cancelled)
        {
            ToolTipML = ENU = 'Specifies if the posted sales invoice has been either corrected or canceled.', FRA = 'Spécifie si la facture vente validée a été corrigée ou annulée.';
        }
        modify(Corrective)
        {
            ToolTipML = ENU = 'Specifies if the posted sales invoice is a corrective document.', FRA = 'Indique si la facture vente validée est un document de correction.';
        }
        modify("Shipment Date")
        {
            ToolTipML = ENU = 'Copies the date for this field from the Shipment Date field on the sales header, which is used for planning purposes.', FRA = 'Copie la date de ce champ dans le champ Date de préparation de l''en-tête vente, que est utilisé à des fins de planification.';
        }
        modify("Document Exchange Status")
        {
            ToolTipML = ENU = 'Specifies the status of the document if you are using a document exchange service to send it as an electronic document. The status values are reported by the document exchange service.', FRA = 'Spécifie le statut du document si vous utilisez un service d''échange de documents pour l''envoyer en tant que document électronique. Les valeurs du statut sont rapportées par le service d''échange de documents.';
        }
        // modify("<Document Exchange Status>")
        // {
        //     ToolTipML = ENU = 'Specifies that the posted sales order is coupled to a sales order in Microsoft CRM.', FRA = 'Indique que la commande vente validée est couplée à un bon de commande dans Microsoft CRM.';
        // }

        //Unsupported feature: Change PagePartID on "IncomingDocAttachFactBox(Control 5)". Please convert manually.


        //Unsupported feature: Change ShowFilter on "IncomingDocAttachFactBox(Control 5)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Customer No."(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Customer No."(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Customer Name"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Customer Name"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Currency Code"(Control 37)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Currency Code"(Control 37)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Due Date"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Due Date"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Amount(Control 13)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Amount(Control 13)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Amount Including VAT"(Control 15)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Amount Including VAT"(Control 15)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Remaining Amount"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Remaining Amount"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Post Code"(Control 27)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Post Code"(Control 27)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Country/Region Code"(Control 23)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Country/Region Code"(Control 23)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact"(Control 35)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact"(Control 35)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Customer No."(Control 147)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Customer No."(Control 147)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Name"(Control 145)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Name"(Control 145)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Post Code"(Control 33)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Post Code"(Control 33)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Country/Region Code"(Control 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Country/Region Code"(Control 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact"(Control 129)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact"(Control 129)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Code"(Control 125)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Code"(Control 125)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Name"(Control 123)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Name"(Control 123)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Post Code"(Control 21)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Post Code"(Control 21)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Country/Region Code"(Control 17)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Country/Region Code"(Control 17)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Contact"(Control 113)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Contact"(Control 113)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 109)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 109)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Salesperson Code"(Control 69)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Salesperson Code"(Control 69)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 91)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 91)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 89)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 89)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 93)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 93)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No. Printed"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No. Printed"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Date"(Control 1102601001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Date"(Control 1102601001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Payment Terms Code"(Control 1102601003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Payment Terms Code"(Control 1102601003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Payment Discount %"(Control 1102601009)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Payment Discount %"(Control 1102601009)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Method Code"(Control 1102601011)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Method Code"(Control 1102601011)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Code"(Control 39)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Code"(Control 39)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Closed(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Closed(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Cancelled(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Cancelled(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Corrective(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Corrective(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 1102601013)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 1102601013)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Exchange Status"(Control 11)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Exchange Status"(Control 11)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""<Document Exchange Status>"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

        addafter("Sell-to Customer Name")
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
            }
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
        addafter("Shipment Date")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Invoice List Customer No.", "Invoice List Document No.", "Document Subtype Code")
            // field("Invoice List Customer No."; Rec."Invoice List Customer No.")
            // {
            //     Description = 'DITW17.10.05 DIT-715 #761';
            //     Visible = false;
            // }
            // field("Invoice List Document No."; Rec."Invoice List Document No.")
            // {
            //     Description = 'DITW17.10.05 DIT-715 #761';
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Invoice List Customer No.", "Invoice List Document No.", )

            // BC Upgrade SHUKLP03 >> "Document Subtype Code" added
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                ApplicationArea = All;
                Visible = false;
            }
            // BC Upgrade SHUKLP03 << "Document Subtype Code" added

        }
        addafter("Document Exchange Status")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
            field("Posted Warehouse Shipment No."; Rec."Posted Whse. Shpmt No. FND")
            {
                ApplicationArea = All;
            }
            field("Whse. Shipment No."; Rec."Whse. Shipment No. FND")
            {
                ApplicationArea = All;
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Field("Tax Date")
            // field("Tax Date"; Rec."Tax Date")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Field("Tax Date")
            field("Invoice Receipt No."; Rec."Invoice Receipt No. FND")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Whse. Shipment No."; "Order No.")
        moveafter("Order No."; "External Document No.")

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

            //Unsupported feature: Change RunObject on "Statistics(Action 31)". Please convert manually.
            //Unsupported feature: Change RunPageLink on "Statistics(Action 31)". Please convert manually.

            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';

            //Unsupported feature: Change RunObject on ""Co&mments"(Action 32)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Co&mments"(Action 32)". Please convert manually.

            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Dimensions)
        {

            //Unsupported feature: Change AccessByPermission on "Dimensions(Action 1102601000)". Please convert manually.

            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(IncomingDoc)
        {

            //Unsupported feature: Change AccessByPermission on "IncomingDoc(Action 9)". Please convert manually.

            CaptionML = ENU = 'Incoming Document', FRA = 'Document entrant';
            Promoted = true;
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
            ToolTipML = ENU = 'Generate the document in the coupled Microsoft Dynamics CRM account.', FRA = 'Générez le document dans le compte Microsoft Dynamics CRM couplé.';
        }
        modify(SendCustom)
        {

            //Unsupported feature: Change Ellipsis on "SendCustom(Action 7)". Please convert manually.

            CaptionML = ENU = 'Send', FRA = 'Envoyer';
            ToolTipML = ENU = 'Prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens where you can confirm or select a sending profile.', FRA = 'Préparez-vous à envoyer le document en fonction du profil d''envoi du client, par exemple en pièce jointe d''un e-mail. La fenêtre Envoyer le document à s''ouvre pour que vous puissiez confirmer ou sélectionner un profil d''envoi.';
            Promoted = true;
            PromotedIsBig = true;
            PromotedOnly = true;
        }
        modify(Print)
        {

            //Unsupported feature: Change Ellipsis on "Print(Action 20)". Please convert manually.

            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            ToolTipML = ENU = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.', FRA = 'Préparez-vous à imprimer le document. Une fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';
        }
        modify(Email)
        {
            CaptionML = ENU = 'Send by &Email', FRA = 'Envoyer par &e-mail';
            ToolTipML = ENU = 'Prepare to send the document by email. The Send Email window opens prefilled for the customer where you can add or change information before you send the email.', FRA = 'Préparez-vous à envoyer le document par e-mail. La fenêtre Envoyer e-mail s''ouvre préremplie pour le client pour que vous puissiez ajouter ou modifier des informations avant d''envoyer l''e-mail.';
            Visible = false; // BC Upgrade SHUKLP03 << Hide this because of our custom code in custom action(Email_Custom).
        }
        // BC Upgrade SHUKLP03 >> Custom action(Email_Custom) created to add Document subtype code.
        addafter(Print)
        {
            action("Email_HNK")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send by &Email';
                Image = Email;
                ToolTip = 'Prepare to send the document by email. The Send Email window opens prefilled for the customer where you can add or change information before you send the email.';

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    //<< DITW18.00.07 AKH 21/04/2016 DIT-770 #1508
                    IF (Rec."Document Subtype Code FND" <> '') THEN
                        SalesInvHeader.SETFILTER("Document Subtype Code FND", Rec."Document Subtype Code FND")
                    ELSE
                        SalesInvHeader.SETFILTER("Document Subtype Code FND", '%1', '');
                    //>> DITW18.00.07 AKH DIT-770 #1508
                    SalesInvHeader.EmailRecords(true);
                end;
            }
        }
        // BC Upgrade SHUKLP03 << Custom action(Email_Custom) created to add Document subtype code.

        modify(Navigate)
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document.';
        }
        modify(ActivityLog)
        {
            CaptionML = ENU = 'Activity Log', FRA = 'Journal des activités';
            ToolTipML = ENU = 'View the status and any errors if the document was sent as an electronic document or OCR file through the document exchange service.', FRA = 'Affichez le statut et les erreurs si le document a été envoyé en tant que document électronique ou fichier OCR via le service d''échange de documents.';
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

            //Unsupported feature: Change RunObject on "Customer(Action 41)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "Customer(Action 41)". Please convert manually.

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


        //Unsupported feature: PropertyDeletion on ""&Invoice"(Action 19)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Co&mments"(Action 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Dimensions(Action 1102601000)". Please convert manually.



        //Unsupported feature: CodeModification on "CreateInCRM(Action 12).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(SalesInvoiceHeader);
        SalesInvoiceHeader.NEXT;

        if SalesInvoiceHeader.COUNT = 1 then
          CRMIntegrationManagement.CreateNewRecordInCRM(RECORDID,false)
        else begin
          SalesInvoiceHeaderRecordRef.GETTABLE(SalesInvoiceHeader);
          CRMIntegrationManagement.CreateNewRecordsInCRM(SalesInvoiceHeaderRecordRef);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        IF SalesInvoiceHeader.COUNT = 1 THEN
          CRMIntegrationManagement.CreateNewRecordInCRM(RECORDID,FALSE)
        ELSE BEGIN
          SalesInvoiceHeaderRecordRef.GETTABLE(SalesInvoiceHeader);
          CRMIntegrationManagement.CreateNewRecordsInCRM(SalesInvoiceHeaderRecordRef);
        END;
        */
        //end;

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.



        //Unsupported feature: CodeModification on "Print(Action 20).OnAction". Please convert manually.

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
        //<< DITW18.00.07 AKH 11/04/2016 - 21/04/2016 DIT-770 #1508
        //<< DITW18.00.07A VSC 27/07/2016 DIT-770 #2117
        SalesInvHeader := Rec;
        //>> DITW18.00.07A VSC DIT-770 #2117

        CurrPage.SETSELECTIONFILTER(SalesInvHeader);
        //HEI.09>>
        xPrintCountL := SalesInvHeader."No. Printed";
        //HEI.09<<
        //HEI.10 >>
        //HEI.10 >>
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
        //HEI.10 <<

        //SalesInvHeader.PrintRecords(TRUE);//HEi.10

        //HEI.09>>
        SalesInvoiceHeaderL.GET(SalesInvHeader."No.");
        PrintCountL := SalesInvoiceHeaderL."No. Printed";
        IF PrintCountL > xPrintCountL THEN BEGIN
          AutomationUtilityL.UpdateJQEntryAfterManualPrint(DocumentTypeL::Order,SalesInvoiceHeaderL."Order No.",
            SalesInvoiceHeaderL."No.",xPrintCountL,PrintCountL);
        END;
        //HEI.09<<
        */
        //end;


        //Unsupported feature: CodeModification on "Email(Action 3).OnAction". Please convert manually.

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
        //<< DITW18.00.07 AKH 21/04/2016 DIT-770 #1508
        IF ("Document Subtype Code" <> '') THEN
          SalesInvHeader.SETFILTER("Document Subtype Code", "Document Subtype Code")
        ELSE
          SalesInvHeader.SETFILTER("Document Subtype Code",'%1','');
        //>> DITW18.00.07 AKH DIT-770 #1508
        SalesInvHeader.EmailRecords(FALSE);
        */
        //end;

        //Unsupported feature: PropertyDeletion on "Correct(Action 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Invoice(Action 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Customer(Action 41)". Please convert manually.

        addafter(Dimensions)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
            // action("Invoice List")
            // {
            //     CaptionML = ENU = 'Invoice List',
            //                 FRA = 'Liste des factures';
            //     Description = 'DITW17.10.05  DIT-770 #761';
            //     Image = List;
            //     RunObject = Page 2014531;
            //     RunPageLink = Document No.=FIELD(Invoice List Document No.);
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Customization
        }

        addafter(ActivityLog)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
            // action("Print Shipment Specification")
            // {
            //     ApplicationArea = All;
            //     CaptionML = ENU = 'Print Shipment Specification',
            //                 FRA = 'Imprimer spécification expédition';
            //     Image = PrintChecklistReport;

            //     trigger OnAction();
            //     var
            //         SalesInvHeader: Record 112;
            //     begin
            //         //<<DITW17.00.02 AT 07/01/2014 DIT-770 #235
            //         CurrPage.SETSELECTIONFILTER(SalesInvHeader);
            //         //<< DITW18.00.07 AKH 21/04/2016 DIT-770 #1508
            //         IF ("Document Subtype Code" <> '') THEN
            //             SalesInvHeader.SETFILTER("Document Subtype Code", "Document Subtype Code")
            //         ELSE
            //             SalesInvHeader.SETFILTER("Document Subtype Code", '%1', '');
            //         //>> DITW18.00.07 AKH DIT-770 #1508
            //         SalesInvHeader.PrintShipmentSpecs(TRUE);
            //         //>>DITW17.00.02 RPG DIT-770 #235
            //     end;
            // }
            // action("Create Invoice List")
            // {
            //     ApplicationArea = All;
            //     CaptionML = ENU = 'Create Invoice List',
            //                 FRA = 'Créer liste des factures';
            //     Description = 'DITW17.10.05 DIT-770 #761';
            //     Image = CalculateLines;
            //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //     //PromotedCategory = Process;

            //     trigger OnAction();
            //     var
            //         lrepCreateInvoiceList: Report "2014421";
            //         SalesInvoiceHeader: Record "112";
            //     begin
            //         TESTFIELD("Invoice List Customer No.");
            //         CLEAR(lrepCreateInvoiceList);
            //         //<<DITW110.00.10 MSF 02/06/2017 NRQ#15500
            //         SalesInvoiceHeader := Rec;
            //         CurrPage.SETSELECTIONFILTER(SalesInvoiceHeader);
            //         SalesInvoiceHeader.SETRANGE("No.");
            //         SalesInvoiceHeader.SETRANGE("Invoice List Customer No.", "Invoice List Customer No.");
            //         SalesInvoiceHeader.SETRANGE("Posting Date", "Posting Date");
            //         lrepCreateInvoiceList.SetReportFilters("Document Date");
            //         REPORT.RUN(REPORT::"Create Invoice List", TRUE, TRUE, SalesInvoiceHeader);
            //         //>>DITW110.00.10 MSF 02/06/2017 NRQ#15500
            //     end;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Customization

        }
        addafter(Invoice)
        {
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


    //Unsupported feature: PropertyModification on "IncomingDoc(Action 9).OnAction.IncomingDocument(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //IncomingDoc : "Incoming Document";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IncomingDoc : 130;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CRMGotoInvoice(Action 14).OnAction.CRMIntegrationManagement(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CRMGotoInvoice : "CRM Integration Management";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CRMGotoInvoice : 5330;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CreateInCRM(Action 12).OnAction.SalesInvoiceHeader(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CreateInCRM : "Sales Invoice Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreateInCRM : 112;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CreateInCRM(Action 12).OnAction.CRMIntegrationManagement(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CreateInCRM : "CRM Integration Management";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreateInCRM : 5330;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SendCustom(Action 7).OnAction.SalesInvHeader(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SendCustom : "Sales Invoice Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SendCustom : 112;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Print(Action 20).OnAction.SalesInvHeader(Variable 1102)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Print : "Sales Invoice Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Print : 112;
    //Variable type has not been exported.

    var
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
        xPrintCountL: Integer;
        PrintCountL: Integer;
        DocumentTypeL: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        AutomationUtilityL: Codeunit "Automation Utility";


    //Unsupported feature: PropertyModification on "Email(Action 3).OnAction.SalesInvHeader(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Email : "Sales Invoice Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Email : 112;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ActivityLog(Action 10).OnAction.ActivityLog(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ActivityLog : "Activity Log";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ActivityLog : 710;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CreateCreditMemo(Action 30).OnAction.SalesHeader(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CreateCreditMemo : "Sales Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreateCreditMemo : 36;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CreateCreditMemo(Action 30).OnAction.CorrectPostedSalesInvoice(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CreateCreditMemo : "Correct Posted Sales Invoice";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreateCreditMemo : 1303;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on ""Document Exchange Status"(Control 11).OnDrillDown.DocExchServDocStatus(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //"Document Exchange Status" : "Doc. Exch. Serv.- Doc. Status";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Document Exchange Status" : 1420;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OnAfterGetCurrRecord.CRMCouplingManagement(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OnAfterGetCurrRecord.CRMCouplingManagement : "CRM Coupling Management";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnAfterGetCurrRecord.CRMCouplingManagement : 5331;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OnAfterGetRecord.SalesInvoiceHeader(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OnAfterGetRecord.SalesInvoiceHeader : "Sales Invoice Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnAfterGetRecord.SalesInvoiceHeader : 112;
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

    var
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        LinkSalesCreditMemoVisible: Boolean;
        CompanyInfoRec: Record "Company Information";
        ReportSelecionRec: Record "Report Selections";
        SalesSetup: Record "Sales & Receivables Setup";


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocExchStatusStyle := GetDocExchStatusStyle;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    CRMIsCoupledToRecord := CRMIntegrationEnabled and CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DocExchStatusStyle := GetDocExchStatusStyle;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
    //HEI.01>>
    IF SalesCrMemoHeader.GET("Link Sales Document No.") THEN
      LinkSalesCreditMemoVisible := TRUE;
    //HEI.01<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocExchStatusStyle := GetDocExchStatusStyle;

    SalesInvoiceHeader.COPYFILTERS(Rec);
    SalesInvoiceHeader.SETFILTER("Document Exchange Status",'<>%1',"Document Exchange Status"::"Not Sent");
    DocExchStatusVisible := not SalesInvoiceHeader.ISEMPTY;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    DocExchStatusVisible := NOT SalesInvoiceHeader.ISEMPTY;
    DocExchStatusVisible := TRUE; //HEI.02
    */
    //end;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocExchStatusVisible := false;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DocExchStatusVisible := FALSE;
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;
    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    if FINDFIRST then;
    IsOfficeAddin := OfficeMgt.IsAvailable;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;
    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    CRMIntegrationEnabled := TRUE; //HEI.02
    IF FINDFIRST THEN;
    IsOfficeAddin := OfficeMgt.IsAvailable;
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

