pageextension 53015 PostedSalesCreditMemosExt extends "Posted Sales Credit Memos"
{
    // version NAVW110.0.00.15601,DITW110.00.09,HEI.14
    /* 
    HEI.01 Defect #1098 IBM.NAIKH01 12.12.2017
            # Added Code on trigger OnAfterGetRecord() , when the Value for "DocExchStatusVisible" is False and the field is checked
              on the "Posted Sales Credit Memos" Web Page an standard Uncaught error is popped so to aviod this error on the Web Page
              the Value of the Variable is set to True.
          HEI.02 RW-GAPLOG08 IBM LAZARE02 23.10.2018 # New field EBM Status and new actions Send to EBM, EBM Details for EBM interface
          HEI.03 INC0998583 IBM HORTOC01 23.11.2018 # add new fields

          HEI.04 RFC-CHG0270099 IBM.ISYED01 18.01.2019
            Added field VAT Registration No on page
          HEI.05 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
            # New Fields added: "Fiscal Printer Status", "Supress POS Interface"
            # New Page Actions created: "Send to Maraki" and "Maraki Details"
          HEI.06 CHG2010375 IBM.LS 21.01.2020
            # New Field added: "Send Document"
            # New Field added: "Mail Sent"
          HEI.07 CHG2044105 IBM.AB 07.01.2020
            # New Column Invoice Receipt No Created
          HEI.08 CHG2010375 IBM.LS 26.02.2020
            # Code added.
          HEI.09 CHG2065153 IBM KUMARN15 23.06.2020
            # Added field "Source System Identifier"
          HEI.10 CHG2064677 IBM SHANKJ03
            # Added code to select burundi layouts.
          HEI.11 CHG2151260-HB2788 COSTES04 23.12.2022 new actions Send to EBMS and EBMS Details
          HEI.12 CHG2151260 HB2788 BHANDS01 03.01.2023 # Burundi Fiscal Invoice
            # Action Send To EBMS promoted
          HEI.13 CHG2151260 HB2788 BHANDS01 04.01.2023 # Burundi Fiscal Invoice
            # Link to EBMS Page corrected
          HEI.14 CHG2194603 HB3289 COSTES04 19.10.2023 new actions Send to PAC and PAC Details
            # New actions added
     */
    // BC Upgrade BHARDA11 >> 
    // 1. Create New Print button There was custom code on the base Print button, which I could not manage using EventSubscriber, OnAfterAction, or OnBeforeAction. Therefore, I removed the base button and created a new button in its place.
    // 2. Remove Drink-IT Fields and related code("Invoice List Customer No.", "Invoice List Document No.", "Document Subtype Code","Tax Date","Truck Code","Driver Code")
    // 3. Add ApplicationArea property in fields
    // BC Upgrade BHARDA11 <<
    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the posted credit memo number.', FRA = 'Spécifie le numéro d''avoir validé.';
        }
        modify("Sell-to Customer No.")
        {
            ToolTipML = ENU = 'Specifies the customer number associated with the credit memo.', FRA = 'Spécifie le numéro client associé à l''avoir.';
        }
        modify("Sell-to Customer Name")
        {
            CaptionML = ENU = 'Customer Name', FRA = 'Nom client';
            ToolTipML = ENU = 'Specifies the name of the customer that you shipped the items on the credit memo to.', FRA = 'Spécifie le nom du client à qui vous avez expédié les articles mentionnés sur l''avoir.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code of the credit memo.', FRA = 'Spécifie le code devise de l''avoir.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the shipment is due for payment.', FRA = 'Spécifie la date à laquelle l''expédition doit être payée.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the total of the amounts on all the credit memo lines, in the currency of the credit memo. The amount does not include VAT.', FRA = 'Spécifie le total des montants de toutes les lignes avoir, dans la devise de l''avoir. Le montant n''inclut pas la TVA.';
        }
        modify("Amount Including VAT")
        {
            ToolTipML = ENU = 'Specifies the total of the amounts in all the amount fields on the credit memo, in the currency of the credit memo. The amount includes VAT.', FRA = 'Spécifie le total des montants de tous les champs montant de l''avoir, dans la devise de l''avoir. Le montant inclut la TVA.';
        }
        modify("Remaining Amount")
        {
            ToolTipML = ENU = 'Specifies the amount that remains to be paid for the posted sales invoice.', FRA = 'Spécifie le montant qui reste à payer pour la facture vente validée.';
        }
        modify(Paid)
        {
            ToolTipML = ENU = 'Specifies if the posted sales invoice that relates to this sales credit memo is paid.', FRA = 'Indique si la facture vente validée liée à cet avoir vente a été payée.';
        }
        modify(Cancelled)
        {
            ToolTipML = ENU = 'Specifies if the posted sales invoice that relates to this sales credit memo has been either corrected or canceled.', FRA = 'Indique si la facture vente validée liée à cet avoir vente a été corrigée ou annulée.';
        }
        modify(Corrective)
        {
            ToolTipML = ENU = 'Specifies if the posted sales invoice has been either corrected or canceled by this sales credit memo.', FRA = 'Indique si la facture vente validée a été corrigée ou annulée par cet avoir vente.';
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
            ToolTipML = ENU = 'Specifies the name of the person to contact when you communicate with the customer that you shipped the items on the credit memo to.', FRA = 'Spécifie le nom de la personne que vous contactez lorsque vous communiquez avec le client auquel vous avez expédié les articles de l''avoir.';
        }
        modify("Bill-to Customer No.")
        {
            ToolTipML = ENU = 'Specifies the number of the customer the credit memo was sent to.', FRA = 'Spécifie le numéro du client à qui l''avoir a été envoyé.';
        }
        modify("Bill-to Name")
        {
            ToolTipML = ENU = 'Specifies the name of the customer that the credit memo was sent to.', FRA = 'Spécifie le nom du client à qui l''avoir a été envoyé.';
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
            ToolTipML = ENU = 'Specifies the name of the person you regularly contact when you communicate with the customer to whom the credit memo was sent.', FRA = 'Spécifie le nom de la personne que vous contactez régulièrement lorsque vous communiquez avec le client auquel l''avoir a été envoyé.';
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
            ToolTipML = ENU = 'Specifies the date when the credit memo was posted.', FRA = 'Spécifie la date de validation de l''avoir.';
        }
        modify("Salesperson Code")
        {
            ToolTipML = ENU = 'Specifies which salesperson is associated with the credit memo.', FRA = 'Spécifie le nom du vendeur associé à l''avoir.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the credit memo.', FRA = 'Spécifie le code section analytique associé à l''avoir.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the credit memo.', FRA = 'Spécifie le code section analytique associé à l''avoir.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location where the credit memo was registered.', FRA = 'Spécifie le code du magasin où l''avoir a été enregistré.';
        }
        modify("No. Printed")
        {
            ToolTipML = ENU = 'Specifies how many times the credit memo has been printed.', FRA = 'Spécifie combien de fois l''avoir a été imprimé.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date when you created the sales document.', FRA = 'Spécifie la date à laquelle vous avez créé le document vente.';
        }
        modify("Applies-to Doc. Type")
        {
            ToolTipML = ENU = 'Specifies whether the credit memo has been applied to an already-posted document.', FRA = 'Indique si l''avoir a été lettré avec un document déjà validé.';
        }
        modify("Document Exchange Status")
        {
            ToolTipML = ENU = 'Specifies the status of the document if you are using a document exchange service to send it as an electronic document. The status values are reported by the document exchange service.', FRA = 'Spécifie le statut du document si vous utilisez un service d''échange de documents pour l''envoyer en tant que document électronique. Les valeurs du statut sont rapportées par le service d''échange de documents.';
        }

        //Unsupported feature: Change PagePartID on "IncomingDocAttachFactBox(Control 7)". Please convert manually.


        //Unsupported feature: Change ShowFilter on "IncomingDocAttachFactBox(Control 7)". Please convert manually.


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


        //Unsupported feature: PropertyDeletion on ""Due Date"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Due Date"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Amount(Control 13)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Amount(Control 13)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Amount Including VAT"(Control 15)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Amount Including VAT"(Control 15)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Remaining Amount"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Remaining Amount"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Paid(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Paid(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Cancelled(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Cancelled(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Corrective(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Corrective(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Post Code"(Control 27)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Post Code"(Control 27)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Country/Region Code"(Control 23)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Country/Region Code"(Control 23)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact"(Control 35)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact"(Control 35)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Customer No."(Control 127)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Customer No."(Control 127)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Name"(Control 125)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Name"(Control 125)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Post Code"(Control 33)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Post Code"(Control 33)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Country/Region Code"(Control 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Country/Region Code"(Control 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact"(Control 115)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact"(Control 115)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Code"(Control 111)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Code"(Control 111)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Name"(Control 109)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Name"(Control 109)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Post Code"(Control 21)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Post Code"(Control 21)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Country/Region Code"(Control 17)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Country/Region Code"(Control 17)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Contact"(Control 99)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Contact"(Control 99)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 97)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 97)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Salesperson Code"(Control 65)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Salesperson Code"(Control 65)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 89)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 89)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 87)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 87)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 91)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 91)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No. Printed"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No. Printed"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Date"(Control 1102601003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Date"(Control 1102601003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Applies-to Doc. Type"(Control 1102601005)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Applies-to Doc. Type"(Control 1102601005)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Exchange Status"(Control 11)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Exchange Status"(Control 11)". Please convert manually.


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
        addafter("Shortcut Dimension 2 Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;
                Visible = false;
            }
            // BC Upgrade BHARAD11 >> ----Drink-IT Field("Physical Location Group Code")
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // BC Upgrade BHARAD11 << ----Drink-IT Field("Physical Location Group Code")
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
        addafter("Applies-to Doc. Type")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
            // BC Upgrade SHUKLP03 >> Added "Document Subtype Code"
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                ApplicationArea = All;
                Visible = false;
            }
            // BC Upgrade SHUKLP03 << Added "Document Subtype Code"

            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Invoice List Customer No.", "Invoice List Document No.")
            // field("Invoice List Customer No."; Rec."Invoice List Customer No.")
            // {
            //     Description = 'DITW18.00.07 DIT-770 #1723';
            // }
            // field("Invoice List Document No."; Rec."Invoice List Document No.")
            // {
            //     Description = 'DITW18.00.07 DIT-770 #1723';
            // }
            // field("Document Subtype Code"; Rec."Document Subtype Code")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Invoice List Customer No.", "Invoice List Document No.", "Document Subtype Code")

        }
        addafter("Document Exchange Status")
        {
            field("Return Order No."; Rec."Return Order No.")
            {
                ApplicationArea = All;
            }

            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Posted Warehouse Shipment No."; Rec."Posted Whse. Shpmt No. FND")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Whse. Shipment No."; Rec."Whse. Shipment No. FND")
            {
                ApplicationArea = All;
                Visible = false;
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Field("Tax Date","Truck Code","Driver Code")
            // field("Tax Date"; Rec."Tax Date")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }

            // field("Truck Code"; Rec."Truck Code")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // field("Driver Code"; Rec."Driver Code")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Field("Tax Date","Truck Code","Driver Code")
            field("Invoice Receipt No."; Rec."Invoice Receipt No. FND")
            {
                ApplicationArea = All;
            }
        }
        addafter("Invoice Receipt No.")
        {
            field("Document Exchange Statu"; Rec."Document Exchange Status")
            {
                Caption = 'Document Exchange Status';
                ApplicationArea = ALL;
            }
            field("Fiscal Printer Status FND"; Rec."Fiscal Printer Status FND")
            {
                ApplicationArea = ALL;
            }
            field("Suppress POS Interface FND"; Rec."Suppress POS Interface FND")
            {
                ApplicationArea = ALL;
            }
            field("Source System Identifier FND"; Rec."Source System Identifier FND")
            {
                ApplicationArea = ALL;
            }
        }

    }
    actions
    {

        modify("&Credit Memo")
        {
            CaptionML = ENU = '&Credit Memo', FRA = 'Avoi&r';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
            Promoted = true;
            PromotedIsBig = true;
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

            //Unsupported feature: Change AccessByPermission on "IncomingDoc(Action 10)". Please convert manually.

            CaptionML = ENU = 'Incoming Document', FRA = 'Document entrant';
            ToolTipML = ENU = 'View or create an incoming document record that is linked to the entry or document.', FRA = 'Affichez ou créez un enregistrement de document entrant qui est lié à l''écriture ou au document.';
            Promoted = true;
        }
        modify(Customer)
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
            ToolTipML = ENU = 'View or edit detailed information about the customer.', FRA = 'Affichez ou modifiez des informations détaillées sur le client.';

            //Unsupported feature: Change RunObject on "Customer(Action 12)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "Customer(Action 12)". Please convert manually.

            Promoted = true;
            PromotedIsBig = true;
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected posted sales document.', FRA = 'Recherchez toutes les écritures et les documents qui existent pour le numéro de document et la date comptabilisation sur le document vente validé sélectionné.';
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Cancel)
        {
            CaptionML = ENU = 'Cancel', FRA = 'Annuler';
        }
        modify(CancelCrMemo)
        {
            CaptionML = ENU = 'Cancel', FRA = 'Annuler';
            ToolTipML = ENU = 'Create and post a sales invoice that reverses this posted sales credit memo. This posted sales credit memo will be canceled.', FRA = 'Créez et validez une facture vente qui contrepasse cet avoir vente validé. Cet avoir vente validée sera annulé.';
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(ShowInvoice)
        {
            CaptionML = ENU = 'Show Canceled/Corrective Invoice', FRA = 'Afficher facture annulée/de correction';
            ToolTipML = ENU = 'Open the posted sales invoice that was created when you canceled the posted sales credit memo. If the posted sales credit memo is the result of a canceled sales invoice, then canceled invoice will open.', FRA = 'Ouvrez la facture vente validée qui a été créée lorsque vous avez annulé l''avoir vente validé. Si l''avoir vente validé est le résultat d''une facture vente annulée, cette dernière s''ouvrira.';
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Send)
        {
            CaptionML = ENU = 'Send', FRA = 'Envoyer';
        }
        modify(SendCustom)
        {

            //Unsupported feature: Change Ellipsis on "SendCustom(Action 5)". Please convert manually.

            CaptionML = ENU = 'Send', FRA = 'Envoyer';
            ToolTipML = ENU = 'Prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens where you can confirm or select a sending profile.', FRA = 'Préparez-vous à envoyer le document en fonction du profil d''envoi du client, par exemple en pièce jointe d''un e-mail. La fenêtre Envoyer le document à s''ouvre pour que vous puissiez confirmer ou sélectionner un profil d''envoi.';
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("&Print")
        {
            Visible = false; // BC Upgrade BHARDA11 ----In the place of Print button Create New button 
            //Unsupported feature: Change Ellipsis on ""&Print"(Action 20)". Please convert manually.
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            ToolTipML = ENU = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.', FRA = 'Préparez-vous à imprimer le document. Une fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';
        }
        modify("Send by &Email")
        {
            CaptionML = ENU = 'Send by &Email', FRA = 'Envoyer par &e-mail';
            ToolTipML = ENU = 'Prepare to send the document by email. The Send Email window opens prefilled for the customer where you can add or change information before you send the email.', FRA = 'Préparez-vous à envoyer le document par e-mail. La fenêtre Envoyer e-mail s''ouvre préremplie pour le client pour que vous puissiez ajouter ou modifier des informations avant d''envoyer l''e-mail.';
        }
        modify(ActivityLog)
        {
            CaptionML = ENU = 'Activity Log', FRA = 'Journal des activités';
            ToolTipML = ENU = 'View the status and any errors if the document was sent as an electronic document or OCR file through the document exchange service.', FRA = 'Affichez le statut et les erreurs si le document a été envoyé en tant que document électronique ou fichier OCR via le service d''échange de documents.';
        }
        addafter(SendCustom)
        {
            // BC Upgrade BHARDA11 >> ----There was custom code on the base Print button, which I could not manage using EventSubscriber, OnAfterAction, or OnBeforeAction. Therefore, I removed the base button and created a new button in its place.
            action(PrintNew)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Scope = Repeater;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                // Visible = not IsOfficeAddin;
                trigger OnAction()
                var
                    SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                    SalesCrMemoHeaderL: Record "Sales Cr.Memo Header";
                    AutomationUtilityL: Codeunit "Automation Utility";
                    xPrintCountL: Integer;
                    PrintCountL: Integer;
                    DocumentTypeL: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";

                begin
                    SalesCrMemoHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
                    //HEI.08>>
                    xPrintCountL := SalesCrMemoHeader."No. Printed";
                    //HEI.08<<
                    //HEI.10<<
                    SalesSetup.RESET();
                    SalesSetup.GET();
                    CompanyInfoRec.RESET();
                    CompanyInfoRec.GET();
                    IF SalesSetup."Export Invoice FND" = TRUE THEN BEGIN
                        IF CompanyInfoRec."Country/Region Code" <> Rec."Ship-to Country/Region Code" THEN
                            REPORT.RUNMODAL(50444, TRUE, TRUE, SalesCrMemoHeader)
                        ELSE IF CompanyInfoRec."Country/Region Code" = Rec."Ship-to Country/Region Code" THEN
                            SalesCrMemoHeader.PrintRecords(TRUE)
                        ELSE IF CompanyInfoRec."Country/Region Code" = '' THEN
                            SalesCrMemoHeader.PrintRecords(TRUE);
                    END ELSE
                        SalesCrMemoHeader.PrintRecords(TRUE);
                    //SalesCrMemoHeader.PrintRecords(TRUE);//HEi.09
                    //HEI.09>>
                    //HEI.08>>
                    SalesCrMemoHeaderL.GET(SalesCrMemoHeader."No.");
                    PrintCountL := SalesCrMemoHeaderL."No. Printed";
                    IF PrintCountL > xPrintCountL THEN BEGIN
                        AutomationUtilityL.UpdateJQEntryAfterManualPrint(DocumentTypeL::"Return Order", SalesCrMemoHeaderL."Return Order No.",
                          SalesCrMemoHeaderL."No.", xPrintCountL, PrintCountL);
                    END;
                    //HEI.08<<
                end;
            }
            // BC Upgrade BHARDA11 << ----There was custom code on the base Print button, which I could not manage using EventSubscriber, OnAfterAction, or OnBeforeAction. Therefore, I removed the base button and created a new button in its place.

        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Credit Memo"(Action 19)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Card(Action 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Co&mments"(Action 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Dimensions(Action 1102601000)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Customer(Action 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Navigate"(Action 25)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Cancel(Action 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Send(Action 98)". Please convert manually.



        //Unsupported feature: CodeModification on ""&Print"(Action 20).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SalesCrMemoHeader := Rec;
        CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
        SalesCrMemoHeader.PrintRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
        SalesCrMemoHeader := Rec;
        //>> DITW18.00.07 AKH DIT-770 #1508
        CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
        //HEI.08>>
        xPrintCountL := SalesCrMemoHeader."No. Printed";
        //HEI.08<<
        //HEI.10<<
        SalesSetup.RESET;
        SalesSetup.GET;
        CompanyInfoRec.RESET;
        CompanyInfoRec.GET;
        IF SalesSetup."Export Invoice" = TRUE THEN BEGIN
          IF CompanyInfoRec."Country/Region Code" <> Rec."Ship-to Country/Region Code" THEN
              REPORT.RUNMODAL(50444,TRUE,TRUE,SalesCrMemoHeader)
            ELSE IF CompanyInfoRec."Country/Region Code" = Rec."Ship-to Country/Region Code" THEN
              SalesCrMemoHeader.PrintRecords(TRUE)
            ELSE IF CompanyInfoRec."Country/Region Code" = '' THEN
              SalesCrMemoHeader.PrintRecords(TRUE);
         END ELSE
          SalesCrMemoHeader.PrintRecords(TRUE);
        //SalesCrMemoHeader.PrintRecords(TRUE);//HEi.09
        //HEI.09>>
        //HEI.08>>
        SalesCrMemoHeaderL.GET(SalesCrMemoHeader."No.");
        PrintCountL := SalesCrMemoHeaderL."No. Printed";
        IF PrintCountL > xPrintCountL THEN BEGIN
          AutomationUtilityL.UpdateJQEntryAfterManualPrint(DocumentTypeL::"Return Order",SalesCrMemoHeaderL."Return Order No.",
            SalesCrMemoHeaderL."No.",xPrintCountL,PrintCountL);
        END;
        //HEI.08<<
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""&Print"(Action 20)". Please convert manually.



        //Unsupported feature: CodeModification on ""Send by &Email"(Action 3).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SalesCrMemoHeader := Rec;
        CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
        SalesCrMemoHeader.EmailRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SalesCrMemoHeader := Rec;
        CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
        SalesCrMemoHeader.EmailRecords(TRUE);
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Send by &Email"(Action 3)". Please convert manually.


    }


    //Unsupported feature: PropertyModification on "IncomingDoc(Action 10).OnAction.IncomingDocument(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //IncomingDoc : "Incoming Document";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IncomingDoc : 130;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SendCustom(Action 5).OnAction.SalesCrMemoHeader(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SendCustom : "Sales Cr.Memo Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SendCustom : 114;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on ""&Print"(Action 20).OnAction.SalesCrMemoHeader(Variable 1102)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //"&Print" : "Sales Cr.Memo Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"&Print" : 114;
    //Variable type has not been exported.

    var
        SalesCrMemoHeaderL: Record "Sales Cr.Memo Header";
        xPrintCountL: Integer;
        PrintCountL: Integer;
        DocumentTypeL: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        AutomationUtilityL: Codeunit "Automation Utility";


    //Unsupported feature: PropertyModification on ""Send by &Email"(Action 3).OnAction.SalesCrMemoHeader(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //"Send by &Email" : "Sales Cr.Memo Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Send by &Email" : 114;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on ""Document Exchange Status"(Control 11).OnDrillDown.DocExchServDocStatus(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //"Document Exchange Status" : "Doc. Exch. Serv.- Doc. Status";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Document Exchange Status" : 1420;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OnAfterGetRecord.SalesCrMemoHeader(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OnAfterGetRecord.SalesCrMemoHeader : "Sales Cr.Memo Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnAfterGetRecord.SalesCrMemoHeader : 114;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OnOpenPage.OfficeMgt(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OnOpenPage.OfficeMgt : "Office Management";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnOpenPage.OfficeMgt : 1630;
    //Variable type has not been exported.

    var
        SalesSetup: Record "Sales & Receivables Setup";
        CompanyInfoRec: Record "Company Information";


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocExchStatusStyle := GetDocExchStatusStyle;

    SalesCrMemoHeader.COPYFILTERS(Rec);
    SalesCrMemoHeader.SETFILTER("Document Exchange Status",'<>%1',"Document Exchange Status"::"Not Sent");
    DocExchStatusVisible := not SalesCrMemoHeader.ISEMPTY;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    DocExchStatusVisible := NOT SalesCrMemoHeader.ISEMPTY;
    DocExchStatusVisible := TRUE; //HEI.01
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;
    if FINDFIRST then;
    IsOfficeAddin := OfficeMgt.IsAvailable;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;
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

}

