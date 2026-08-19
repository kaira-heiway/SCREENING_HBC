pageextension 53011 PostedSalesCreditMemoExt extends "Posted Sales Credit Memo"
{
    // version NAVW110.0.00.15601,FINXL10.00,IPLXL9.00.001,DITW110.00.11,HEI.14
    /* 
    DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    DITW15.00.00.19 DDR 04/04/2008 Certification rules
    DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    DITW15.00.00.25 DDR 16/10/2008 Added "Truck Code","Driver Code" into "Shipping" tab
                        21/10/2008 Deleted field2013722 Duty Tax Type
                                   Added fields "Customer DTax Group Code" into Invoicing tab
    DITW15.00.00.35 DDR 14/10/2009 issue 788 Added Form property DeleteAllowed = No
                        13/10/2009 Added "Building No." into General tab
    DITW15.00.00.39 DDR 19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
                                                     call function SetDisableRefreshLines() before each report
                                                     (don't use the <RunObject> property)
    DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added 'Service/Contract' tab
                                                Added fields into 'Service/Contract' tab
                                                  "DIT Sub-Contract Type","Contract Group Code","Service Contract No."
                                                Moved "Building No." into 'Service/Contract' tab

    FINXL7.00.001 RBE 20/03/2013 : Added field "Your Reference","Posting Description" on page
                                   Added export to pdf and mail functionality
                                   Added field OGM on page
    FINXL8.00.001 RBE 01/12/2014 : Removed Print & Mail action
    FINXL8.00.001 BSA 11/06/2015 #67 :Added Action Print & Mail

    DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added fields "Physical Location Group Code"
    DITW17.10.05 WSA 04/08/14 DIT-770 #761 : Added field "Invoice List Customer No."
    DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    FINXL8.00.001 RBE 01/12/2014 : Removed Print & Mail action
    DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
                                              Rename Field Service contract Type => Contract Type
    DITW18.00.07 VSC 18/05/2016 DIT-770 #1972 Merge FINXL EDI Interface
    DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code

    DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    IPLXL9.00.001 IMI 10/06/2015 : Added Interface export
    FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    DITW110.00.11 MSF 25/08/2017 NRQ#17902 Route settlement - Order Payments, Suggest customer and vendor payments
                                           Added field Document Subtype Code ,

    HEI.01 FDD-KDD0TC005 IBM NASTAA02 19.12.2017 # RPM Billing and Reporting
      # Action Button added to print the Global Sales Invoice Report
    HEI.02 FDD-OTCGAP051 IBM NASTAA02 06.03.2018 # Document Subtype Code non-editable for Bonus Credit Memos
      # New Field added "Bonus Credit Memo"
    HEI.03 RW-GAPLOG08 IBM LAZARE02 23.10.2018 # New field EBM Status and new actions Send to EBM, EBM Details for EBM interface
    HEI.04 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
      # New Field added: "Suppress POS Interface"
      # New Page Action created: "Send to Maraki", "Maraki Details"
    HEI.05 CHG2010375 IBM.LS 21.01.2020
      # New Field added: "Send Document"
      # New Field added: "Mail Sent"
    HEI.06 CHG2044105 IBM.AB 07.01.2020
      # New field Invoice Receipt No added in Invoice Details Group
    HEI.07 CHG2010375 IBM.LS 26.02.2020
      # Code added.
    HEI.08 CHG2064677 IBM SHANKJ03
      # Added code to select burundi layouts.
    HEI.09 CHG2065153 IBM KUMARN15 23.06.2020
      # Added field "Source System Identifier"
    HEI.10 FDD-HB1880 CHG2089830 IBM NASTAA02 23.12.2020 # Fix Invoice Creation Date
      # Added field "Creation Date/Time"
    HEI.11 CHG2151260-HB2788 SOICAD02 08.11.2022 new actions Send to EBMS and EBMS Details
    HEI.12 CHG2151260-HB2788 SOICAD02 23.12.2022 new actions Send to EBMS and EBMS Details
    HEI.13 CHG2151260 HB2788 BHANDS01 03.01.2023 # Burundi Fiscal Invoice
      # Link to EBMS Page corrected
    HEI.14 CHG2194603 HB3289 COSTES04 19.10.2023 new actions Send to PAC and PAC Details
      # New actions added
     */
    // BC Upgrade BHARDA11 >>
    // 1. Remove Drink-IT Fields and related code.
    // 2. Remove Drink-IT Actions and Customizations.
    // 3. There is some HEI.08 code in Print button but in business central there is no event to modify this action so we create a new action with same caption and add that code in the new Action PrintNew and add code in the PrintNew button
    // 4. Add ApplicationArea property in Fields and actions.
    // 5. Remove Interface fields and customizations and add that fields in Interface extension
    // BC Upgrade BHARAD11 <<
    DeleteAllowed = false;

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the posted credit memo number.', FRA = 'Spécifie le numéro d''avoir validé.';
        }
        modify("Sell-to Customer Name")
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
            ToolTipML = ENU = 'Specifies the name of the customer that you shipped the items on the credit memo to.', FRA = 'Spécifie le nom du client à qui vous avez expédié les articles mentionnés sur l''avoir.';
        }
        modify("Sell-to")
        {
            CaptionML = ENU = 'Sell-to', FRA = 'Donneur d''ordre';
        }
        modify("Sell-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address of the customer that the items on the credit memo were sent to.', FRA = 'Spécifie l''adresse du client à qui les articles mentionnés sur l''avoir ont été envoyés.';
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
            ToolTipML = ENU = 'Specifies the city the items on the credit memo were shipped to.', FRA = 'Spécifie la ville vers laquelle les articles de l''avoir ont été expédiés.';
        }
        modify("Sell-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of the contact at the customer who handles the credit memo.', FRA = 'Spécifie le numéro du contact chez le client qui traite l''avoir.';
        }
        modify("Sell-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person to contact when you communicate with the customer who you shipped the items on the credit memo to.', FRA = 'Spécifie le nom de la personne que vous contactez lorsque vous communiquez avec le client auquel vous avez expédié les articles de l''avoir.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the credit memo was posted.', FRA = 'Spécifie la date d''enregistrement de l''avoir.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on which you created the sales document.', FRA = 'Spécifie la date à laquelle vous avez créé le document vente.';
        }
        modify("Document Exchange Status")
        {
            ToolTipML = ENU = 'Specifies the status of the document if you are using a document exchange service to send it as an electronic document. The status values are reported by the document exchange service.', FRA = 'Spécifie le statut du document si vous utilisez un service d''échange de documents pour l''envoyer en tant que document électronique. Les valeurs du statut sont rapportées par le service d''échange de documents.';
        }
        modify("Pre-Assigned No.")
        {
            ToolTipML = ENU = 'Specifies the number of the credit memo that the posted credit memo was created from.', FRA = 'Spécifie le numéro de l''avoir à partir duquel l''avoir validé a été créé.';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies the external document number that is entered on the sales header that this line was posted from.', FRA = 'Spécifie le numéro de document externe qui est saisi sur l''en-tête vente à partir duquel la ligne a été validée.';
        }
        modify("Salesperson Code")
        {
            ToolTipML = ENU = 'Specifies which salesperson is associated with the credit memo.', FRA = 'Spécifie le nom du vendeur associé à l''avoir.';
        }
        modify("Responsibility Center")
        {
            ToolTipML = ENU = 'Specifies the code for the responsibility center that serves the customer on this sales document.', FRA = 'Spécifie le code du centre de gestion qui dessert le client figurant sur ce document vente.';
        }
        modify(Cancelled)
        {
            ToolTipML = ENU = 'Specifies if the posted sales invoice that relates to this sales credit memo has been either corrected or canceled.', FRA = 'Indique si la facture vente validée liée à cet avoir vente a été corrigée ou annulée.';
        }
        modify(Corrective)
        {
            ToolTipML = ENU = 'Specifies if the posted sales invoice has been either corrected or canceled by this sales credit memo.', FRA = 'Indique si la facture vente validée a été corrigée ou annulée par cet avoir vente.';
        }
        modify("No. Printed")
        {
            ToolTipML = ENU = 'Specifies how many times the credit memo has been printed.', FRA = 'Spécifie combien de fois l''avoir a été imprimé.';
        }

        //Unsupported feature: Change SubPageLink on "SalesCrMemoLines(Control 46)". Please convert manually.


        //Unsupported feature: Change PagePartID on "SalesCrMemoLines(Control 46)". Please convert manually.

        modify("Invoice Details")
        {
            CaptionML = ENU = 'Invoice Details', FRA = 'Détails facture';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code of the credit memo.', FRA = 'Spécifie le code devise de l''avoir.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location where the credit memo was registered.', FRA = 'Spécifie le code du magasin où l''avoir a été enregistré.';
        }
        modify("Applies-to Doc. Type")
        {
            ToolTipML = ENU = 'Specifies the type of the posted document that this document or journal line is applied to.', FRA = 'Spécifie le type de document validé auquel ce document a été appliqué.';
        }
        modify("Applies-to Doc. No.")
        {
            ToolTipML = ENU = 'Specifies the number of the posted document that this document or journal line is applied to.', FRA = 'Spécifie le numéro du document validé avec lequel ce document ou cette ligne feuille est lettrée.';
        }
        modify("Payment Method Code")
        {
            ToolTipML = ENU = 'Specifies the customer''s method of payment. The program has copied the code from the Payment Method Code field on the sales header.', FRA = 'Spécifie le mode de règlement du client. Le programme copie le code du champ Code mode de règlement de l''en-tête vente.';
        }
        modify("EU 3-Party Trade")
        {
            ToolTipML = ENU = 'Specifies whether the invoice was part of an EU 3-party trade transaction.', FRA = 'Spécifie si la facture faisait partie d''une transaction tripartite.';
        }
        modify("Shipping and Billing")
        {
            CaptionML = ENU = 'Shipping and Billing', FRA = 'Expédition et facturation';
        }
        modify("Ship-to")
        {
            CaptionML = ENU = 'Ship-to', FRA = 'Destinataire';
        }
        modify("Ship-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the name of the customer that the items were shipped to.', FRA = 'Spécifie le nom du client auquel les articles ont été expédiés.';
        }
        modify("Ship-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address that the items were shipped to.', FRA = 'Spécifie l''adresse à laquelle les articles ont été expédiés.';
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
            ToolTipML = ENU = 'Specifies the city the items were shipped to.', FRA = 'Spécifie la ville vers laquelle les articles ont été expédiés.';
        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person you regularly contact at the customer to whom the items were shipped.', FRA = 'Spécifie le nom de la personne que vous contactez régulièrement chez le client auquel les articles ont été livrés.';
        }
        modify("Bill-to")
        {
            CaptionML = ENU = 'Bill-to', FRA = 'Facturation';
        }
        modify("Bill-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the name of the customer that the credit memo was sent to.', FRA = 'Spécifie le nom du client à qui l''avoir a été envoyé.';
        }
        modify("Bill-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address of the customer that the credit memo was sent to.', FRA = 'Spécifie l''adresse du client à qui l''avoir a été envoyé.';
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
            ToolTipML = ENU = 'Specifies the city the credit memo was sent to.', FRA = 'Spécifie la ville vers laquelle l''avoir a été envoyé.';
        }
        modify("Bill-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of the contact at the customer who handles the credit memo.', FRA = 'Spécifie le numéro du contact chez le client qui traite l''avoir.';
        }
        modify("Bill-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person you regularly contact when you communicate with the customer to whom the credit memo was sent.', FRA = 'Spécifie le nom de la personne que vous contactez régulièrement lorsque vous communiquez avec le client auquel l''avoir a été envoyé.';
        }

        //Unsupported feature: Change PagePartID on "IncomingDocAttachFactBox(Control 13)". Please convert manually.


        //Unsupported feature: Change ShowFilter on "IncomingDocAttachFactBox(Control 13)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "General(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Customer Name"(Control 53)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Customer Name"(Control 53)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to"(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Address"(Control 55)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Address"(Control 55)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Address 2"(Control 57)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Address 2"(Control 57)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Post Code"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Post Code"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to City"(Control 59)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to City"(Control 59)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact No."(Control 95)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact No."(Control 95)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact"(Control 61)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sell-to Contact"(Control 61)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Date"(Control 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Date"(Control 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control20(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Exchange Status"(Control 25)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Exchange Status"(Control 25)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Pre-Assigned No."(Control 65)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Pre-Assigned No."(Control 65)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""External Document No."(Control 84)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""External Document No."(Control 84)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Salesperson Code"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Salesperson Code"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Responsibility Center"(Control 80)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Responsibility Center"(Control 80)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Cancelled(Control 31)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Cancelled(Control 31)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Corrective(Control 37)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Corrective(Control 37)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No. Printed"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No. Printed"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Invoice Details"(Control 1905885101)". Please convert manually.


        //Unsupported feature: CodeModification on ""Currency Code"(Control 75).OnAssistEdit". Please convert manually.

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

        //Unsupported feature: PropertyDeletion on ""Currency Code"(Control 75)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Currency Code"(Control 75)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 7)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 7)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 66)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 66)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 68)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 68)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Applies-to Doc. Type"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Applies-to Doc. Type"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Applies-to Doc. No."(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Applies-to Doc. No."(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Payment Method Code"(Control 282)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Payment Method Code"(Control 282)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""EU 3-Party Trade"(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""EU 3-Party Trade"(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shipping and Billing"(Control 1906801201)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to"(Control 5)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Name"(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Name"(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Address"(Control 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Address"(Control 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Address 2"(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Address 2"(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Post Code"(Control 72)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Post Code"(Control 72)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to City"(Control 40)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to City"(Control 40)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Contact"(Control 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ship-to Contact"(Control 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to"(Control 27)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Name"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Name"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Address"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Address"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Address 2"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Address 2"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Post Code"(Control 70)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Post Code"(Control 70)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to City"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to City"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact No."(Control 97)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact No."(Control 97)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact"(Control 30)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bill-to Contact"(Control 30)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

        addafter("Sell-to Contact")
        {
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Building No.", "Your Reference", "Posting Description", OGM)
            // field("Building No."; Rec."Building No.")
            // {
            //     Editable = false;
            // }
            // field("Your Reference"; Rec."Your Reference")
            // {
            //     Description = 'FINXL2.00.009';
            //     Editable = false;
            // }
            // field("Posting Description"; Rec."Posting Description")
            // {
            //     Description = 'FINXL2.00.009';
            //     Editable = false;
            // }
            // field(OGM; Rec.OGM)
            // {
            //     Description = 'FINXL2.00.022';
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Building No.", "Your Reference", "Posting Description", OGM)
        }
        addafter("Document Date")
        {
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Created Date/Time';
                Editable = false;
            }
            field(SystemCreatedBy; Rec.SystemCreatedBy)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Created By';
                Editable = false;
            }
        }
        addafter("Work Description")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = ALL;
                Editable = false;
            }

        }

        addafter("Document Date")
        {
            field("Bonus Credit Memo"; Rec."Bonus Credit Memo FND")
            {
                ApplicationArea = All;
                Description = 'HEI.02';
            }

        }
        addafter("Responsibility Center")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Tax Date", "Customer DTax Group Code")
            // field("Tax Date"; Rec."Tax Date")
            // {
            //     Editable = false;
            // }
            // field("Customer DTax Group Code"; Rec."Customer DTax Group Code")
            // {
            //     Editable = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Tax Date", "Customer DTax Group Code")
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
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }


        }
        addafter("Location Code")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Creation Date/Time", "Truck Code", "Driver Code")
            // field("Creation Date/Time"; Rec."Creation Date/Time")
            // {
            //     ApplicationArea = All;
            // }
            // field("Truck Code"; Rec."Truck Code")
            // {
            //     Editable = false;
            // }
            // field("Driver Code"; Rec."Driver Code")
            // {
            //     Editable = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Creation Date/Time", "Truck Code", "Driver Code")
        }
        addafter("Payment Method Code")
        {

        }
        addafter("EU 3-Party Trade")
        {
            // BC Upgrade SHUKLP03 >> Added document subtype field.
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                ApplicationArea = All;
                Description = '<DITW18.00.07 DIT-770 #1508>-NRQ17902';
                Importance = Additional;
            }
            // BC Upgrade SHUKLP03 << Added document subtype field.

            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
            // field("Document Subtype Code"; Rec."Document Subtype Code")
            // {
            //     Description = '<DITW18.00.07 DIT-770 #1508>-NRQ17902';
            //     Importance = Additional;
            // }
            // field("Invoice List Customer No."; Rec."Invoice List Customer No.")
            // {
            //     Description = 'DITW17.10.05 DIT-715 #761';
            //     Editable = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Customization

            field("Invoice Receipt No."; Rec."Invoice Receipt No. FND")
            {
                ApplicationArea = All;
            }
            group("Service/Contract")
            {
                CaptionML = ENU = 'Service/Contract',
                            FRA = 'Service/ Contrat';
                // BC Upgrade BHARDA11 >> ---Drink-IT Fields("Contract Type", "DIT Sub-Contract Type", "Financial Contract No.", "Service Contract No.", "Contract Group Code")

                // field("Contract Type"; Rec."Contract Type")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
                // {
                // }
                // field("Financial Contract No."; Rec."Financial Contract No.")
                // {
                // }
                // field("Service Contract No."; Rec."Service Contract No.")
                // {
                // }
                // field("Contract Group Code"; Rec."Contract Group Code")
                // {
                // }
                // BC Upgrade BHARDA11 << ---Drink-IT Fields("Contract Type", "DIT Sub-Contract Type", "Financial Contract No.", "Service Contract No.", "Contract Group Code")

            }
        }
        addafter("Ship-to")
        {
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Editable = false;
            //     Importance = Additional;
            // }
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

            //Unsupported feature: Change RunObject on "Statistics(Action 9)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "Statistics(Action 9)". Please convert manually.

            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
            ToolTipML = ENU = 'View or add notes about the posted sales credit memo.', FRA = 'Affichez ou ajoutez des remarques sur l''avoir vente validé.';

            //Unsupported feature: Change RunObject on ""Co&mments"(Action 49)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Co&mments"(Action 49)". Please convert manually.

            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Dimensions)
        {

            //Unsupported feature: Change AccessByPermission on "Dimensions(Action 77)". Please convert manually.

            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Approvals)
        {

            //Unsupported feature: Change AccessByPermission on "Approvals(Action 92)". Please convert manually.

            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify(Customer)
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
            ToolTipML = ENU = 'View or edit detailed information about the customer on the posted sales document.', FRA = 'Affichez ou modifiez des informations détaillées concernant le client sur le document vente validé.';

            //Unsupported feature: Change RunObject on "Customer(Action 3)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "Customer(Action 3)". Please convert manually.

            Promoted = true;
        }
        modify(SendCustom)
        {

            //Unsupported feature: Change Ellipsis on "SendCustom(Action 8)". Please convert manually.

            CaptionML = ENU = 'Send', FRA = 'Envoyer';
            ToolTipML = ENU = 'Prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.', FRA = 'Préparez-vous à envoyer le document en fonction du profil d''envoi du client, par exemple en pièce jointe d''un e-mail. La fenêtre Envoyer le document à s''ouvre en premier pour que vous puissiez confirmer ou sélectionner un profil d''envoi.';
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Print)
        {
            Visible = false; // BC Upgrade BHARDA11 ---There is some HEI.08 code in this button but in business central there is no event to modify this action so we create a new action with same caption and add that code in the new Action
            //Unsupported feature: Change Ellipsis on "Print(Action 50)". Please convert manually.
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            ToolTipML = ENU = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.', FRA = 'Préparez-vous à imprimer le document. Une fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';
        }

        // BC Upgrade SHUKLP03 >> Hide base action and created same action with Document Subtype Code code.
        modify("Send by &Email")
        {
            CaptionML = ENU = 'Send by &Email', FRA = 'Envoyer par &e-mail';
            ToolTipML = ENU = 'Send the sales credit memo document as a PDF file attached to an email.', FRA = 'Envoyez le document avoir vente en tant que fichier PDF joint à un e-mail.';
            Visible = False;
        }
        addafter(Print)
        {
            action("Send by &Email_HNK")
            {
                ApplicationArea = All;
                Caption = 'Send by &Email';
                Image = Email;
                ToolTip = 'Send the sales credit memo document as a PDF file attached to an email.';

                trigger OnAction()
                var
                    SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                begin
                    SalesCrMemoHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesCrMemoHeader);
                    SalesCrMemoHeader.SETFILTER("Document Subtype Code FND", Rec."Document Subtype Code FND");
                    SalesCrMemoHeader.EmailRecords(true);
                end;

            }
        }
        // BC Upgrade SHUKLP03 << Hide base action and created same action with our code.


        // BC Upgrade BHARDA11 >> ---Added new button in the place of base Print button because of HEI custom code.
        addafter(SendCustom)
        {
            action(PrintNew)
            {
                ApplicationArea = All;
                Caption = '&Print';
                // CaptionML = ENU = '&Print', FRA = '&Imprimer';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                // Visible = not IsOfficeAddin;
                trigger OnAction()
                var
                    SalesCrMemoHeaderL, SalesCrMemoHeader : Record "Sales Cr.Memo Header";
                    AutomationUtilityL: Codeunit "Automation Utility";
                    xPrintCountL: Integer;
                    PrintCountL: Integer;
                    DocumentTypeL: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";

                begin
                    SalesCrMemoHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
                    //HEI.07>>
                    xPrintCountL := SalesCrMemoHeader."No. Printed";
                    //HEI.07<<
                    //HEI.08 >>
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
                    //HEI.08 <<
                    //SalesCrMemoHeader.PrintRecords(TRUE);//HEI.08
                    //HEI.07>>
                    SalesCrMemoHeaderL.GET(SalesCrMemoHeader."No.");
                    PrintCountL := SalesCrMemoHeaderL."No. Printed";
                    IF PrintCountL > xPrintCountL THEN BEGIN
                        AutomationUtilityL.UpdateJQEntryAfterManualPrint(DocumentTypeL::"Return Order", SalesCrMemoHeaderL."Return Order No.",
                          SalesCrMemoHeaderL."No.", xPrintCountL, PrintCountL);
                    END;
                    //HEI.07<<
                end;
            }

        }

        // addafter(Print)
        // {
        //     actionref(PrintNew_Promoted; PrintNew) { }
        // }
        // addfirst()
        // {
        //     actionref(PrintNew_Promoted; PrintNew) { }

        // }
        // addafter(SendCustom_Promoted)
        // {
        //     actionref(PrintNew_Promoted; PrintNew) { }
        // }
        // BC Upgrade BHARDA11 << ----Added new button in the place of base Print button because of HEI custom code.
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document.';
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(ActivityLog)
        {
            CaptionML = ENU = 'Activity Log', FRA = 'Journal des activités';
            ToolTipML = ENU = 'View the status and any errors if the document was sent as an electronic document or OCR file through the document exchange service.', FRA = 'Affichez le statut et les erreurs si le document a été envoyé en tant que document électronique ou fichier OCR via le service d''échange de documents.';
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
        modify(IncomingDocument)
        {
            CaptionML = ENU = 'Incoming Document', FRA = 'Document entrant';
        }
        modify(IncomingDocCard)
        {
            CaptionML = ENU = 'View Incoming Document', FRA = 'Afficher le document entrant';
            ToolTipML = ENU = 'View any incoming document records and file attachments that exist for the entry or document.', FRA = 'Affichez tout enregistrement et fichier joint de document entrant qui existe pour l''écriture ou le document.';
        }
        modify(SelectIncomingDoc)
        {

            //Unsupported feature: Change AccessByPermission on "SelectIncomingDoc(Action 17)". Please convert manually.

            CaptionML = ENU = 'Select Incoming Document', FRA = 'Sélectionner le document entrant';
            ToolTipML = ENU = 'Select an incoming document record and file attachment that you want to link to the entry or document.', FRA = 'Sélectionnez un fichier joint ou un enregistrement de document entrant que vous voulez associer à l''écriture ou au document.';
        }
        modify(IncomingDocAttachFile)
        {

            //Unsupported feature: Change Ellipsis on "IncomingDocAttachFile(Action 19)". Please convert manually.

            CaptionML = ENU = 'Create Incoming Document from File', FRA = 'Créer un document entrant à partir d''un fichier';
            ToolTipML = ENU = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.', FRA = 'Créez un enregistrement de document entrant en sélectionnant un fichier à joindre, puis associez l''enregistrement de document entrant à l''écriture ou au document.';
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000003(Action 1900000003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Cr. Memo"(Action 47)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Co&mments"(Action 49)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Dimensions(Action 77)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Approvals(Action 92)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Customer(Action 3)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Print(Action 50).OnAction". Please convert manually.

        //trigger (Variable: SalesCrMemoHeaderL)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on "Print(Action 50).OnAction". Please convert manually.

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
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.SalesCrMemoLines.PAGE.SetDisableRefreshLines(TRUE);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        SalesCrMemoHeader := Rec;
        CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
        //HEI.07>>
        xPrintCountL := SalesCrMemoHeader."No. Printed";
        //HEI.07<<
        //HEI.08 >>
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
        //HEI.08 <<

        //SalesCrMemoHeader.PrintRecords(TRUE);//HEI.08
        //HEI.07>>
        SalesCrMemoHeaderL.GET(SalesCrMemoHeader."No.");
        PrintCountL := SalesCrMemoHeaderL."No. Printed";
        IF PrintCountL > xPrintCountL THEN BEGIN
          AutomationUtilityL.UpdateJQEntryAfterManualPrint(DocumentTypeL::"Return Order",SalesCrMemoHeaderL."Return Order No.",
            SalesCrMemoHeaderL."No.",xPrintCountL,PrintCountL);
        END;
        //HEI.07<<
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.SalesCrMemoLines.PAGE.SetDisableRefreshLines(FALSE);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        */
        //end;


        //Unsupported feature: CodeModification on ""Send by &Email"(Action 11).OnAction". Please convert manually.

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
        //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
        SalesCrMemoHeader.SETFILTER("Document Subtype Code","Document Subtype Code");
        //>> DITW18.00.07 AKH DIT-770 #1508
        SalesCrMemoHeader.EmailRecords(TRUE);
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Send by &Email"(Action 11)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Navigate"(Action 51)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Cancel(Action 39)". Please convert manually.


        addafter("&Navigate")
        {

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
                    SalesInvoiceHeader: Record 112;
                begin
                    //HEI.01>>
                    SalesInvoiceHeader.SETRANGE("Order No.", Rec."Return Order No.");
                    REPORT.RUNMODAL(REPORT::"Global Sales Invoice CBN", TRUE, TRUE, SalesInvoiceHeader);
                    //HEI.01<<
                end;
            }

            // BC Upgrade BHARDA11 >> ----- Blocked as PAC is not in scope
            // action("Send To PAC")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Send to PAC';
            //     Image = SendTo;
            //     Promoted = true;
            //     PromotedCategory = Process;

            //     trigger OnAction();
            //     var
            //         PACElectronicInvoiceMgt: Codeunit "50060";
            //     begin
            //         PACElectronicInvoiceMgt.ManualSalesCreditMemoPosting(Rec)//HEI.14
            //     end;
            // }
            // BC Upgrade BHARAD11 << ----- Blocked as PAC is not in scope

        }
    }


    //Unsupported feature: PropertyModification on "Approvals(Action 92).OnAction.ApprovalsMgmt(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Approvals : "Approvals Mgmt.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Approvals : 1535;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SendCustom(Action 8).OnAction.SalesCrMemoHeader(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SendCustom : "Sales Cr.Memo Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SendCustom : 114;
    //Variable type has not been exported.

    var
        SalesCrMemoHeaderL: Record 114;
        xPrintCountL: Integer;
        PrintCountL: Integer;
        DocumentTypeL: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        AutomationUtilityL: Codeunit "Automation Utility";


    //Unsupported feature: PropertyModification on "IncomingDocCard(Action 23).OnAction.IncomingDocument(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //IncomingDocCard : "Incoming Document";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IncomingDocCard : 130;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SelectIncomingDoc(Action 17).OnAction.IncomingDocument(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SelectIncomingDoc : "Incoming Document";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SelectIncomingDoc : 130;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "IncomingDocAttachFile(Action 19).OnAction.IncomingDocumentAttachment(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //IncomingDocAttachFile : "Incoming Document Attachment";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IncomingDocAttachFile : 133;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on ""Document Exchange Status"(Control 25).OnDrillDown.DocExchServDocStatus(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //"Document Exchange Status" : "Doc. Exch. Serv.- Doc. Status";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Document Exchange Status" : 1420;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OnAfterGetCurrRecord.IncomingDocument(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OnAfterGetCurrRecord.IncomingDocument : "Incoming Document";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnAfterGetCurrRecord.IncomingDocument : 130;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OnOpenPage.OfficeMgt(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OnOpenPage.OfficeMgt : "Office Management";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnOpenPage.OfficeMgt : 1630;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SalesCrMemoHeader(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SalesCrMemoHeader : "Sales Cr.Memo Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SalesCrMemoHeader : 114;
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
        CompanyInfoRec: Record 79;
        SalesSetup: Record 311;

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

