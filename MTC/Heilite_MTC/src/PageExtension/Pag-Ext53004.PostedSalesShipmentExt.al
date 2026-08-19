pageextension 53004 PostedSalesShipmentExt extends "Posted Sales Shipment"
{
    // version NAVW110.0.00.16585,FINXL10.00,IPLXL9.00.001,DITW110.00.09,HEI.01
    /* 
    HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
      # New Field added "Gate Entry No."
    HEI.02 CHG2065153 IBM KUMARN15 23.06.2020
      # Added field "Source System Identifier"
    HEI.03 HB1582 IBM NASTAA02 02.09.2020 # Actual Delivery Date for Case Fill Rate - CHG2071900
      # New Field cadded: "Actual Delivery Date"
    HEI.04 FDD-HB1880 CHG2089830 IBM NASTAA02 23.12.2020 # Fix Invoice Creation Date
      # Added field "Creation Date/Time"
     */
    // BC Upgrade BHARDA11 >>
    // 1. Remove Drink-IT Fields nd related code.
    // 2. Remove drink-it objects related actions.
    // 3. Remove Drink-IT Functions.
    // BC Upgrade BHARDA11 <<
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';

            //Unsupported feature: Change Editable on "General(Control 1)". Please convert manually.

        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the record.', FRA = 'Spécifie le numéro de l''enregistrement.';
        }
        modify("Sell-to Customer Name")
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
            ToolTipML = ENU = 'Specifies the name of customer at the sell-to address.', FRA = 'Spécifie le nom du client à l''adresse donneur d''ordre.';
        }
        modify("Sell-to")
        {
            CaptionML = ENU = 'Sell-to', FRA = 'Donneur d''ordre';
        }
        modify("Sell-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the customer''s sell-to address.', FRA = 'Spécifie l''adresse donneur d''ordre du client.';
        }
        modify("Sell-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies the customer''s extended sell-to address.', FRA = 'Spécifie l''adresse donneur d''ordre étendue du client.';
        }
        modify("Sell-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the post code of the customer''s sell-to address.', FRA = 'Spécifie le code postal de l''adresse donneur d''ordre du client.';
        }
        modify("Sell-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city of the customer''s sell-to address.', FRA = 'Spécifie la ville de l''adresse donneur d''ordre du client.';
        }
        modify("Sell-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the contact number.', FRA = 'Spécifie le numéro contact.';
        }
        modify("Sell-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the contact at the customer''s sell-to address.', FRA = 'Spécifie le nom de la personne à l''adresse donneur d''ordre du client.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date for the entry.', FRA = 'Spécifie la date comptabilisation de l''écriture.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the posting date of the document.', FRA = 'Spécifie la date comptabilisation du document.';
        }
        modify("Requested Delivery Date")
        {
            ToolTipML = ENU = 'Specifies the date that the customer has asked for the order to be delivered.', FRA = 'Spécifie la date à laquelle le client a demandé à être livré.';
            Importance = Additional;
        }
        modify("Promised Delivery Date")
        {
            Importance = Additional;
        }
        modify("Quote No.")
        {
            ToolTipML = ENU = 'Specifies the number of the sales quote document if a quote was used to start the sales process.', FRA = 'Spécifie le numéro du document devis si un devis a été utilisé pour démarrer le processus de vente.';
            Importance = Additional;
        }
        modify("Order No.")
        {
            ToolTipML = ENU = 'Specifies the number of the sales order that this invoice was posted from.', FRA = 'Spécifie le numéro de la commande vente à partir de laquelle la facture a été validée.';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies the number that the customer uses in their own system to refer to this sales document.', FRA = 'Spécifie le numéro que le client doit utiliser dans son propre système pour faire référence à ce document vente.';
        }
        modify("Salesperson Code")
        {
            ToolTipML = ENU = 'Specifies a code for the salesperson who normally handles this customer''s account.', FRA = 'Spécifie un code pour le vendeur qui s''occupe habituellement du compte de ce client.';
        }

        //Unsupported feature: Change SubPageLink on "SalesShipmLines(Control 46)". Please convert manually.


        //Unsupported feature: Change PagePartID on "SalesShipmLines(Control 46)". Please convert manually.

        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping', FRA = 'Livraison';

            //Unsupported feature: Change Editable on "Shipping(Control 1906801201)". Please convert manually.

        }
        modify("Ship-to Code")
        {
            CaptionML = ENU = 'Address Code', FRA = 'Code adresse';
            ToolTipML = ENU = 'Specifies the code for the customer''s additional shipment address.', FRA = 'Spécifie le code de l''adresse complémentaire de livraison du client.';
        }
        modify("Ship-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the name of the customer that you delivered the items to.', FRA = 'Spécifie le nom du client auquel les articles sont livrés.';
        }
        modify("Ship-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address that you delivered the items to.', FRA = 'Spécifie l''adresse à laquelle les articles sont livrés.';
        }
        modify("Ship-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies the extended address that you delivered the items to.', FRA = 'Spécifie l''adresse étendue à laquelle les articles sont livrés.';
        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the post code of the customer''s ship-to address.', FRA = 'Spécifie le code postal de l''adresse destinataire du client.';
        }
        modify("Ship-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city of the customer''s ship-to address.', FRA = 'Spécifie la ville de l''adresse destinataire du client.';
        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person you regularly contact at the address that the items were shipped to.', FRA = 'Spécifie le nom de la personne que vous contactez régulièrement à l''adresse à laquelle les articles ont été livrés.';
        }
        modify("Shipping Time")
        {
            Importance = Additional;
        }
        modify("Shipment Method")
        {
            CaptionML = ENU = 'Shipment Method', FRA = 'Conditions de livraison';

            //Unsupported feature: Change Editable on ""Shipment Method"(Control 7)". Please convert manually.

        }
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            ToolTipML = ENU = 'Specifies the shipment method for the shipment.', FRA = 'Spécifie le mode de transport de l''expédition.';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Agent', FRA = 'Agent';
            ToolTipML = ENU = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';

            //Unsupported feature: Change Editable on ""Shipping Agent Code"(Control 62)". Please convert manually.

        }
        modify("Shipping Agent Service Code")
        {
            CaptionML = ENU = 'Agent Service', FRA = 'Service agent';
            ToolTipML = ENU = 'Specifies which shipping agent service is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';

            //Unsupported feature: Change Editable on ""Shipping Agent Service Code"(Control 93)". Please convert manually.

        }
        modify("Package Tracking No.")
        {
            ToolTipML = ENU = 'Specifies the shipping agent''s package number.', FRA = 'Spécifie le numéro récépissé du transporteur.';

            //Unsupported feature: Change Editable on ""Package Tracking No."(Control 72)". Please convert manually.

        }
        modify("Shipment Date")
        {
            ToolTipML = ENU = 'Specifies the date when the sales shipment was posted.', FRA = 'Spécifie la date à laquelle l''expédition vente a été validée.';
        }
        modify(Billing)
        {
            CaptionML = ENU = 'Billing', FRA = 'Facturation';

            //Unsupported feature: Change Editable on "Billing(Control 1905885101)". Please convert manually.

        }
        modify("Bill-to Customer No.")
        {
            CaptionML = ENU = 'Customer No.', FRA = 'N° client';
            ToolTipML = ENU = 'Specifies the number of the customer at the billing address.', FRA = 'Spécifie le numéro du client à l''adresse de facturation.';
        }
        modify("Bill-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the name of the customer that you sent the invoice to.', FRA = 'Spécifie le nom du client auquel la facture a été envoyée.';
        }
        modify("Bill-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address that you sent the invoice to.', FRA = 'Spécifie l''adresse à laquelle vous avez envoyé la facture.';
        }
        modify("Bill-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies the extended address that you sent the invoice to.', FRA = 'Spécifie l''adresse étendue à laquelle vous avez envoyé la facture.';
        }
        modify("Bill-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the post code of the customer''s bill-to address.', FRA = 'Spécifie le code postal de l''adresse facturation du client.';
        }
        modify("Bill-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city of the customer''s bill-to address.', FRA = 'Spécifie la ville de l''adresse facturation du client.';
        }
        modify("Bill-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of the contact at the customer''s bill-to address.', FRA = 'Spécifie le numéro du contact à l''adresse facturation du client.';
        }
        modify("Bill-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person you regularly contact at the customer to whom you sent the invoice.', FRA = 'Spécifie le nom de la personne que vous contactez régulièrement chez le client auquel vous avez envoyé la facture.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "General(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Customer Name"(Control 52)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Customer Name"(Control 52)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Address"(Control 54)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Address"(Control 54)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Address 2"(Control 56)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Address 2"(Control 56)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Post Code"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Post Code"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to City"(Control 58)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to City"(Control 58)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact No."(Control 112)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact No."(Control 112)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact"(Control 60)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact"(Control 60)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No. Printed"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No. Printed"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Date"(Control 27)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Date"(Control 27)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Requested Delivery Date"(Control 84)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Requested Delivery Date"(Control 84)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Promised Delivery Date"(Control 87)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Promised Delivery Date"(Control 87)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Quote No."(Control 111)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Quote No."(Control 111)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Order No."(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Order No."(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""External Document No."(Control 89)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""External Document No."(Control 89)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Salesperson Code"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Salesperson Code"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Responsibility Center"(Control 82)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Responsibility Center"(Control 82)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Shipping(Control 1906801201)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Code"(Control 30)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Code"(Control 30)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Name"(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Name"(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Address"(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Address"(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Address 2"(Control 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Address 2"(Control 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Post Code"(Control 69)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Post Code"(Control 69)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to City"(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to City"(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Contact"(Control 40)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Contact"(Control 40)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 65)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 65)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Outbound Whse. Handling Time"(Control 91)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Outbound Whse. Handling Time"(Control 91)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Time"(Control 95)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Time"(Control 95)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Method"(Control 7)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Method Code"(Control 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Method Code"(Control 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Code"(Control 62)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Code"(Control 62)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Service Code"(Control 93)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping Agent Service Code"(Control 93)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Package Tracking No."(Control 72)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Package Tracking No."(Control 72)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Billing(Control 1905885101)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Customer No."(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Customer No."(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Name"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Name"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Address"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Address"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Address 2"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Address 2"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Post Code"(Control 67)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Post Code"(Control 67)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to City"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to City"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact No."(Control 114)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact No."(Control 114)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 9)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 9)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 63)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 63)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

        moveafter("Sell-to City"; "Sell-to Country/Region Code")
        // addafter("Sell-to City")
        // {
        //     field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
        //     {
        //         ApplicationArea = All;
        //         CaptionML = ENU = 'Country/Region',
        //                     FRA = 'Pays/région';
        //         Editable = false;
        //     }
        // }
        addafter("No. Printed")
        {
            // field("Your Reference"; Rec."Your Reference")
            // {
            //     Description = 'FINXL7.00.001';
            //     Editable = false;
            // }
            // group()
            // {
            // }
        }
        addafter("Document Date")
        {
            // BC Upgrade BHARAD11  >> ----Drink-IT Field("Tax Date")
            // field("Tax Date"; Rec."Tax Date")
            // {
            //     Editable = false;
            // }
            // BC Upgrade BHARAD11  >> ----Drink-IT Field("Tax Date")
        }
        addafter("External Document No.")
        {
            // BC Upgrade BHARAD11  >> ----Drink-IT Field("Building No.")
            // field("Building No."; Rec."Building No.")
            // {
            //     Editable = false;
            //     Importance = Additional;
            // }
            // BC Upgrade BHARAD11  << ----Drink-IT Field("Building No.")
        }
        addafter("Responsibility Center")
        {
            // BC Upgrade BHARAD11  >> ----Drink-IT Field("Document Shipping Costs")
            // field("Document Shipping Costs"; Rec."Document Shipping Costs")
            // {
            //     ApplicationArea = All;
            // }
            // BC Upgrade BHARAD11  << ----Drink-IT Field("Document Shipping Costs")
            field("Gate Entry No."; Rec."Gate Entry No. FND")
            {
                ApplicationArea = All;
            }
            field("Source System Identifier"; Rec."Source System Identifier FND")
            {
                ApplicationArea = All;
            }
            field("Actual Delivery Date"; Rec."Actual Delivery Date FND")
            {
                ApplicationArea = All;
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Field("Creation Date/Time")
            // field("Creation Date/Time"; Rec."Creation Date/Time")
            // {
            //     ApplicationArea = All;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Field("Creation Date/Time")
        }
        moveafter("Ship-to City"; "Ship-to Country/Region Code")
        // addafter("Ship-to City")
        // {
        //     field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
        //     {
        //         ApplicationArea = All;
        //         CaptionML = ENU = 'Country/Region',
        //                     FRA = 'Pays/région';
        //         Editable = false;

        //     }
        // }
        // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Physical Location Group Code","Fiscal Representative No.","Tax Office Code","Journey Time","Submission Type","Transport Mode","Delivery Time")
        // addafter("Ship-to Contact")
        // {
        //     field("Physical Location Group Code"; Rec."Physical Location Group Code")
        //     {
        //         Editable = false;
        //         Importance = Additional;
        //     }
        // }
        // addafter("Location Code")
        // {
        //     field("Fiscal Representative No."; Rec."Fiscal Representative No.")
        //     {
        //         Editable = false;
        //     }
        //     field("Tax Office Code"; Rec."Tax Office Code")
        //     {
        //         Editable = false;
        //     }
        //     field("Journey Time"; Rec."Journey Time")
        //     {
        //         Description = 'DITW15.00.00.39 #1353';
        //         Editable = false;
        //     }
        //     field("Submission Type"; Rec."Submission Type")
        //     {
        //         Editable = false;
        //     }
        //     field("Transport Mode"; Rec."Transport Mode")
        //     {
        //         Description = 'DIT715 #187';
        //         Editable = false;
        //     }
        // }
        // addafter("Promised Delivery Date")
        // {
        //     field("Delivery Time"; Rec."Delivery Time")
        //     {
        //         Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230';
        //         Editable = false;
        //         Importance = Additional;
        //     }
        // }
        // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Physical Location Group Code","Fiscal Representative No.","Tax Office Code","Journey Time","Submission Type","Transport Mode","Delivery Time")

        addafter("Shipment Date")
        {
            field("Exit Point"; Rec."Exit Point")
            {
                ApplicationArea = All;
                Editable = false;
                Importance = Additional;
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields(Distance, Truck Code, Trailer Code, Driver Code, Driver 2 Code, Route, Route Planning No., Picking Type, Delivery Sequence, Shipping Charge Per, Maximum Weight, Maximum Cubage, Total Weight, Total Cubage, Customer Delivery Type, Delivery Time (sec.))
            // field(Distance; Rec.Distance)
            // {
            //     Editable = false;
            // }
            // field("Truck Code"; Rec."Truck Code")
            // {
            //     Editable = false;
            // }
            // field("Trailer Code"; Rec."Trailer Code")
            // {
            //     Editable = false;
            // }
            // field("Driver Code"; Rec."Driver Code")
            // {
            //     Editable = false;
            // }
            // field("Driver 2 Code"; Rec."Driver 2 Code")
            // {
            //     Editable = false;
            // }
            // field(Route; Route)
            // {
            //     Editable = false;
            // }
            // field("Route Planning No."; Rec."Route Planning No.")
            // {
            //     Editable = false;
            // }
            // field("Picking Type"; Rec."Picking Type")
            // {
            //     Editable = false;
            //     Importance = Additional;
            // }
            // field("Delivery Sequence"; Rec."Delivery Sequence")
            // {
            //     Editable = false;
            //     Importance = Additional;
            // }
            // field("Shipping Charge Per"; Rec."Shipping Charge Per")
            // {
            //     Editable = false;
            //     Importance = Additional;
            // }
            // field("Maximum Weight"; Rec."Maximum Weight")
            // {
            //     Editable = false;
            // }
            // field("Maximum Cubage"; Rec."Maximum Cubage")
            // {
            //     Editable = false;
            // }
            // field("Total Weight"; Rec."Total Weight")
            // {
            //     Editable = false;
            // }
            // field("Total Cubage"; Rec."Total Cubage")
            // {
            //     Editable = false;
            // }
            // field("Customer Delivery Type"; Rec."Customer Delivery Type")
            // {
            //     Editable = false;
            //     Importance = Additional;
            // }
            // field("Delivery Time (sec.)"; Rec."Delivery Time (sec.)")
            // {
            //     Importance = Additional;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields(Distance, Truck Code, Trailer Code, Driver Code, Driver 2 Code, Route, Route Planning No., Picking Type, Delivery Sequence, Shipping Charge Per, Maximum Weight, Maximum Cubage, Total Weight, Total Cubage, Customer Delivery Type, Delivery Time (sec.))
        }
        moveafter("Bill-to City"; "Bill-to Country/Region Code")
        // addafter("Bill-to City")
        // {
        //     field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
        //     {
        //         ApplicationArea = All;
        //         CaptionML = ENU = 'Country/Region',
        //                     FRA = 'Pays/région';
        //         Editable = false;
        //     }
        // }
        // BC Upgrade BHARDA11 >> ----Drink-IT Fields(Customer DTax Group Code, Invoice List Customer No.)
        // addafter("Shortcut Dimension 2 Code")
        // {
        //     field("Customer DTax Group Code"; Rec."Customer DTax Group Code")
        //     {
        //         Editable = false;
        //     }
        //     field("Invoice List Customer No."; Rec."Invoice List Customer No.")
        //     {
        //         Description = 'DITW17.10.05 DIT-715 #761';
        //         Editable = false;
        //     }
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Fields(Customer DTax Group Code, Invoice List Customer No.)
        moveafter("Document Date"; "Quote No.")
        moveafter("Bill-to Customer No."; "Bill-to Contact No.")
        addafter("Actual Delivery Date")
        {
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                Caption = 'Created Date/Time';
                Editable = false;
            }
        }
    }
    actions
    {
        modify("&Shipment")
        {
            CaptionML = ENU = '&Shipment', FRA = 'E&xpédition';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';

            //Unsupported feature: Change RunObject on "Statistics(Action 10)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "Statistics(Action 10)". Please convert manually.

            Promoted = true;
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';

            //Unsupported feature: Change RunObject on ""Co&mments"(Action 78)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Co&mments"(Action 78)". Please convert manually.

        }
        modify(Dimensions)
        {

            //Unsupported feature: Change AccessByPermission on "Dimensions(Action 80)". Please convert manually.

            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Approvals)
        {

            //Unsupported feature: Change AccessByPermission on "Approvals(Action 107)". Please convert manually.

            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify(CertificateOfSupplyDetails)
        {
            CaptionML = ENU = 'Certificate of Supply Details', FRA = 'Détails certificat d''approvisionnement';

            //Unsupported feature: Change RunObject on "CertificateOfSupplyDetails(Action 3)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "CertificateOfSupplyDetails(Action 3)". Please convert manually.

        }
        modify(PrintCertificateofSupply)
        {
            CaptionML = ENU = 'Print Certificate of Supply', FRA = 'Imprimer le certificat d''approvisionnement';
            Promoted = false;
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("&Track Package")
        {
            CaptionML = ENU = '&Track Package', FRA = '&Suivre colis';
        }
        modify("&Print")
        {

            //Unsupported feature: Change Ellipsis on ""&Print"(Action 49)". Please convert manually.

            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            Promoted = true;
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            Promoted = true;
        }


        //Unsupported feature: PropertyDeletion on "ActionContainer1900000003(Action 1900000003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Shipment"(Action 47)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Statistics(Action 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Co&mments"(Action 78)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Dimensions(Action 80)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Approvals(Action 107)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""F&unctions"(Action 74)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Track Package"(Action 79)". Please convert manually.



        //Unsupported feature: CodeModification on ""&Print"(Action 49).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(SalesShptHeader);
        SalesShptHeader.PrintRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.02>>
        ReportSelection.RESET();
        //ReportSelection.SETRANGE(Usage,ReportSelection.Usage::"Delivery Note(SUR)"); //commented HEI.03
        ReportSelection.SETRANGE(Usage,ReportSelection.Usage::"Delivery Note(Whse Ship)"); //HEI.03
        IF ReportSelection.FINDFIRST THEN BEGIN
          SalesShptHeader.RESET();
          SalesShptHeader.SETRANGE(SalesShptHeader."No.","No.");
          IF SalesShptHeader.FINDSET THEN;
           // REPEAT
             // PostedWhseShipmentHeader.RESET();//commented HEI.03
             // PostedWhseShipmentHeader.SETRANGE("No.",SalesShptHeader."Posted Warehouse Shipment No."); //commented HEI.03
             // IF PostedWhseShipmentHeader.FINDFIRST THEN BEGIN//commented HEI.03
                REPORT.RUNMODAL(ReportSelection."Report ID",TRUE,FALSE,SalesShptHeader) //HEI.03
             // END;//commented HEI.03
           // UNTIL SalesShptHeader.NEXT = 0;//commented HEI.03
          END
        ELSE BEGIN
        //HEI.02<<
          // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
          CurrPage.SalesShipmLines.PAGE.SetDisableRefreshLines(TRUE);
          // >>DITW16.00.00.40 DDR DIT-715 #197
          CurrPage.SETSELECTIONFILTER(SalesShptHeader);
          SalesShptHeader.PrintRecords(TRUE);
          // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
          CurrPage.SalesShipmLines.PAGE.SetDisableRefreshLines(FALSE);
          // >>DITW16.00.00.40 DDR DIT-715 #197
        END; //HEI.02
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""&Print"(Action 49)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Navigate"(Action 50)". Please convert manually.

        addafter("Co&mments")
        {
            // BC Upgrade BHARDA11 >> ---Drink-IT Button("Comments - Transport Mode")
            // action("Comments - Transport Mode")
            // {
            //     ApplicationArea = All;
            //     CaptionML = ENU = 'Comments - Transport Mode',
            //                 FRA = 'Commantaires - Mode de transport';
            //     Description = 'DIT715 #187';
            //     RunObject = Page 2014270;
            //     RunPageLink = Table ID=CONST(110),
            //                   Document Type=CONST(0),
            //                   Document No.=FIELD(No.),
            //                   Document Line No.=CONST(0),
            //                   Field ID=CONST(2014277);
            // }
            // BC Upgrade BHARDA11 << ---Drink-IT Button("Comments - Transport Mode")
        }
        addafter(PrintCertificateofSupply)
        {
            action("Service Items")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Service Items',
                            FRA = 'Articles de service';
                Image = ServiceAgreement;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Service Item List";
                RunPageLink = "Sales/Serv. Shpt. Document No." = FIELD("No.");
                RunPageView = SORTING("Sales/Serv. Shpt. Document No.", "Sales/Serv. Shpt. Line No.")
                              WHERE("Sales/Serv. Shpt. Line No." = FILTER(<> 0));
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
            // action("Packing List")
            // {
            //     ApplicationArea = All;
            //     CaptionML = ENU = 'Packing List',
            //                 FRA = 'Liste emballage';
            //     Image = TaskList;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page 2014416;
            //     RunPageLink = Table ID=CONST(110),
            //                   Posted Source Document=CONST(Posted Shipment),
            //                   Posted Source No.=FIELD(No.);
            // }
            // action("Item/SSCC &Tracking Entries")
            // {
            //     ApplicationArea = All;
            //     CaptionML = ENU='Item/SSCC &Tracking Entries',
            //                 FRA='Ecritures traçabilité article/SSCC';
            //     Image = ItemTrackingLedger;

            //     trigger OnAction();
            //     var
            //         SSCCSetup : Record 2035040;
            //         ItemTrackingMgt : Codeunit 6500;
            //         SSCCTrackingMgt : Codeunit 2035041;
            //     begin
            //         // HIT9007.1 MVN 30/12/2015: to check Item Tracking
            //         // <<DITW16.00.00.40 DDR 20/03/2012 DIT-715 #275
            //         IF SSCCSetup.READPERMISSION THEN
            //           SSCCTrackingMgt.CallPostedSSCCTrackingForm(
            //             DATABASE::"Sales Shipment Line",0,"No.",'',0,0)
            //         ELSE
            //           ItemTrackingMgt.CallPostedItemTrackingForm(
            //             DATABASE::"Sales Shipment Line",0,"No.",'',0,0);
            //     end;
            // }
            // action("Shipping Costs")
            // {
            //     ApplicationArea = All;
            //     CaptionML = ENU='Shipping Costs',
            //                 FRA='Coûts transport';
            //     Image = Costs;
            //     RunObject = Page 2014097;
            //                     RunPageLink = Source Type=CONST(110),
            //                   Source No.=FIELD(No.);
            // }
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
        }
        addafter("&Track Package")
        {
            separator(as)
            {

            }
            // BC Upgrade BHARAD11 >> ----Drink-IT Customization
            // action("Register Route Shipment entries")
            // {
            //     ApplicationArea = All;
            //     CaptionML = ENU = 'Register Route Shipment entries',
            //                 FRA = 'Registre route écritures éxpéditions';
            //     Image = Register;
            //     RunObject = Page 2014088;
            //     RunPageLink = Route Planning No.=FIELD(Route Planning No.),
            //                   Source Type=CONST(110),
            //                   Source No.=FIELD(No.);
            // }
            // group(EMCS)
            // {

            //     CaptionML = ENU = 'EMCS',
            //                 FRA = 'EMCS';
            //     action("Send e-AAD Request")
            //     {
            //         ApplicationArea = All;
            //         CaptionML = ENU = 'Send e-AAD Request',
            //                     FRA = 'Envoyer requête e-DAA';
            //         Image = SendElectronicDocument;

            //         trigger OnAction();
            //         var
            //             EMCSExport: Codeunit "2014262";
            //         begin
            //             //<<DITW17.00.02 DDR 28/08/2013 DIT-770 #178 - 29/08/2013 DIT-770 #179
            //             EMCSExport.CreateOutboxSalesShipment(Rec);
            //             //>>DITW17.00.02 DDR 28/08/2013 DIT-770 #178 - 29/08/2013 DIT-770 #179
            //         end;
            //     }
            //     action("Send e-Cancelling Request")
            //     {
            //         ApplicationArea = All;
            //         CaptionML = ENU = 'Send e-Cancelling Request',
            //                     FRA = 'Envoyer e-Annulation requête';
            //         Image = SendElectronicDocument;

            //         trigger OnAction();
            //         var
            //             EMCSExport: Codeunit "2014267";
            //         begin
            //             //<<DITW17.00.02 DDR 28/08/2013 DIT-770 #178 - 29/08/2013 DIT-770 #179
            //             IF EMCSExport.CheckShipmentUndo(Rec) THEN
            //                 EMCSExport.CreateOutboxSalesShipment(Rec);
            //             //>>DITW17.00.02 DDR 28/08/2013 DIT-770 #178 - 29/08/2013 DIT-770 #179
            //         end;
            //     }
            // }
            // BC Upgrade BHARAD11 << ----Drink-IT Customization
        }

        addafter("&Print")
        {
            // BC Upgrade BHARAD11 >> ----Drink-IT Customization
            // action("Shipment (Packing)")
            // {
            //     ApplicationArea = All;
            //     CaptionML = ENU = 'Shipment (Packing)',
            //                 FRA = 'Expédtion (Emballage)';
            //     Image = Print;

            //     trigger OnAction();
            //     begin
            //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
            //         CurrPage.SalesShipmLines.PAGE.SetDisableRefreshLines(TRUE);
            //         // >>DITW16.00.00.40 DDR DIT-715 #197
            //         // <<DITW15.00.00.35 DDR 05/08/2009
            //         DocPrint.PrintSalesShptHeaderPacking(Rec, FALSE);
            //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
            //         CurrPage.SalesShipmLines.PAGE.SetDisableRefreshLines(FALSE);
            //         // >>DITW16.00.00.40 DDR DIT-715 #197
            //     end;
            // }
            // action("Shipment (&Invoice)")
            // {
            //     ApplicationArea = All;
            //     CaptionML = ENU = 'Shipment (&Invoice)',
            //                 FRA = 'Expédtion (Facture)';
            //     Description = 'NRQ#20678 ';
            //     Enabled = false;
            //     Image = Print;
            //     Visible = false;

            //     trigger OnAction();
            //     begin
            //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
            //         CurrPage.SalesShipmLines.PAGE.SetDisableRefreshLines(TRUE);
            //         // >>DITW16.00.00.40 DDR DIT-715 #197
            //         // <<DITW15.00.00.34 DDR 05/06/2009
            //         DocPrint.PrintSalesShptHeaderInv(Rec, FALSE);
            //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
            //         CurrPage.SalesShipmLines.PAGE.SetDisableRefreshLines(FALSE);
            //         // >>DITW16.00.00.40 DDR DIT-715 #197
            //     end;
            // }
            // BC Upgrade BHARAD11 << ----Drink-IT Customization
            action("Delivery Note")
            {
                ApplicationArea = All;
                Caption = 'Delivery Note';
                Image = Print;

                trigger OnAction();
                var

                    SalesShptHeader: Record "Sales Shipment Header";
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    //HEI.03<<
                    ReportSelection.RESET();
                    ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Delivery Note(Sales Invoice)");
                    ReportSelection.SETFILTER("Report ID", '<>0');
                    IF ReportSelection.FINDSET THEN BEGIN
                        SalesShptHeader.RESET();
                        SalesShptHeader.SETRANGE(SalesShptHeader."No.", Rec."No.");
                        IF SalesShptHeader.FINDSET THEN
                            REPEAT
                                SalesInvoiceHeader.RESET();
                                SalesInvoiceHeader.SETRANGE("Order No.", SalesShptHeader."Order No.");
                                IF SalesInvoiceHeader.FIND THEN;
                                REPORT.RUNMODAL(ReportSelection."Report ID", TRUE, FALSE, SalesInvoiceHeader)
                            UNTIL SalesShptHeader.NEXT = 0;
                    END;
                    //HEI.03>>
                end;
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
            // action("&AAD Document")
            // {
            //     ApplicationArea = All;
            //     CaptionML = ENU = '&AAD Document',
            //                 FRA = 'Document D&AA';
            //     Image = Print;

            //     trigger OnAction();
            //     begin
            //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
            //         CurrPage.SalesShipmLines.PAGE.SetDisableRefreshLines(TRUE);
            //         // >>DITW16.00.00.40 DDR DIT-715 #197
            //         // <<DITW15.00.00.28 DDR 26/11/2008
            //         DocPrint.PrintSalesShptHeaderAAD(Rec, FALSE);
            //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
            //         CurrPage.SalesShipmLines.PAGE.SetDisableRefreshLines(FALSE);
            //         // >>DITW16.00.00.40 DDR DIT-715 #197
            //     end;
            // }

            // separator(s)
            // {
            // }
            // action("Packing List")
            // {
            //     ApplicationArea = All;
            //     CaptionML = ENU = 'Packing List',
            //                 FRA = 'Liste emballage';
            //     Image = Print;

            //     trigger OnAction();
            //     begin
            //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
            //         CurrPage.SalesShipmLines.PAGE.SetDisableRefreshLines(TRUE);
            //         // >>DITW16.00.00.40 DDR DIT-715 #197
            //         // <<DITW15.00.00.35 DDR 05/08/2009
            //         DocPrint.PrintSalesShptHeaderPackingLst(Rec, FALSE);
            //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
            //         CurrPage.SalesShipmLines.PAGE.SetDisableRefreshLines(FALSE);
            //         // >>DITW16.00.00.40 DDR DIT-715 #197
            //     end;
            // }
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
        }
        addafter("&Navigate")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
            // action("Interface Export ")
            // {
            //     ApplicationArea = All;
            //     CaptionML = ENU = 'Interface Export ',
            //                 FRA = 'Exporter interface ';
            //     Description = 'IPLXL9.00.001';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;

            //     trigger OnAction();
            //     var
            //         lcduExportStandard: Codeunit "2030016";
            //         lrptInitOutbox: Report "2030014";
            //         lrecPartnerMessage: Record "2030012";
            //         lrecCustomer: Record "18";
            //         loptDocumentType: Option Custom,"Sales Order","Sales Return Order","Pick Confirmation","Ship Confirmation","Receipt Confirmation","Put Away Confirmation","Purchase Invoice","Sales Invoice",Payment,"Inventory Report","Purchase Cr.Memo","Pick Request","Put Away Request","Sales Credit Memo";
            //     begin
            //         //<<IPLXL9.00.001 IMI 10/06/2015
            //         lrecCustomer.GET("Sell-to Customer No.");

            //         lrecPartnerMessage.SETRANGE("Message Code", 'SALESSHIPMENT');
            //         lrecPartnerMessage.SETRANGE("Interface Partner Code", lrecCustomer."Interface Partner");

            //         lrptInitOutbox.SETTABLEVIEW(lrecPartnerMessage);
            //         lrptInitOutbox.USEREQUESTPAGE(FALSE);
            //         lrptInitOutbox.fctSetParameters(loptDocumentType::"Ship Confirmation", "No.");
            //         lrptInitOutbox.RUNMODAL;
            //         //>>IPLXL9.00.001 IMI 10/06/2015
            //     end;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Customization
        }
    }


    //Unsupported feature: PropertyModification on "Approvals(Action 107).OnAction.ApprovalsMgmt(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Approvals : "Approvals Mgmt.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Approvals : 1535;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "PrintCertificateofSupply(Action 5).OnAction.CertificateOfSupply(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PrintCertificateofSupply : "Certificate of Supply";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PrintCertificateofSupply : 780;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SalesShptHeader(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SalesShptHeader : "Sales Shipment Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SalesShptHeader : 110;
    //Variable type has not been exported.

    var
        DocPrint: Codeunit "Document-Print";
        ReportSelection: Record "Report Selections";
        PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header";

}

