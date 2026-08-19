pageextension 52008 PostedPurchaseInvExt extends "Posted Purchase Invoice"
{

    // version NAVW110.0.00.15052,FINXL10.00,DITW110.00.11,HEI.07
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.21 DDR 27/06/2008 Added button Shipping Transport
    //   DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    //   DITW15.00.00.25 DDR 16/10/2008 Added "Truck Code","Driver Code" into "Shipping" tab
    //                       21/10/2008 Deleted field2013722 Duty Tax Type
    //                                  Added fields "Vendor DTax Group Code" into Invoicing tab
    //   DITW15.00.00.35 DDR 14/10/2009 issue 788 Added Form property DeleteAllowed = No
    //   DITW15.00.00.39 DDR 19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    //   DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                    call function SetDisableRefreshLines() before each report
    //                                                    (don't use the <RunObject> property)
    //   DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added 'Service/Contract' tab
    //                                               Added fields into 'Service/Contract' tab
    //                                                 "DIT Sub-Contract Type","Contract Group Code","Service Contract No."
    //                                               Moved "Building No." into 'Service/Contract' tab

    //   FINXL7.00.001 RBE 20/03/2013 : Added field "Your Reference","Posting Description" on page
    //                                  Added PDF Functionality
    //   FINXL8.00.001 BSA 16/06/2015 : Added Field OGM

    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Physical Location Group Code"
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //   DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                             Rename Field Service contract Type => Contract Type
    //   DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //   FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    //   DITW110.00.11 MSF 25/08/2017 NRQ#17902 Route settlement - Order Payments, Suggest customer and vendor payments
    //                                          Added field Document Subtype Code ,

    //   HEI.01 FDD-PTPGAP013- IBM PATHAA02   31.07.2017
    //     #New field 'Payment Status' Aligned
    //     #Modify allowoed' property changed to 'Yes'

    //   HEI.02 HLSRM02-05 IBM LAZARE02 31.07.2017
    //     #New fields for SRM integration added to SRM tab

    //   HEI.03 FDD-PTPGAP041 IBM PATHAA02 20.08.17
    //   # Aligned new fields "Payment User" and "Status Date"//29.09.17
    //   # Removed Code from on Onqueryclose page//29.09.17
    //   HEI.04 FDD-PURGAP027 IBM NASTAA02 14.06.2019 # Maximo POs Approval Flow
    //     # Created new Page Action "Purchase Invoice Additional"
    //   HEI.05 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //     # New Field added: "Fixed Asset Acquisition"
    //   HEI.06 CHG2024557 FDD-HT821 IBM SHANKJ03 12.02.2020
    //     # New field added Maximo Status
    //   HEI.07 FDD-HB2638 CHG2136725 IBM NANDIS01 23.02.2022 Block create Corrective Credit memo option in HL
    //       # Code added to control of using button - Create Corrective Credit Memo
    //HEI.07- //BC Upgrade GUNREM01 Code not added becuase its DIT Code. 
    // HEI.04 and HEI.06- //BC Upgrade GUNREM01 added in interface
    // BC Upgrade - RD03 Page Renamed
    // BC Upgrade - RD03 Made Reason Code Field Non Editable
    // BC Upgrade - RD03 Made Payment Status Field Non Editable

    ModifyAllowed = true; //HEI.01 -//BC Upgrade
    layout
    {
        // BC Upgrade BHARDA11 >> --Enable Links
        modify(Control1900383207)
        {
            Visible = true;
        }
        // BC Upgrade BHARDA11 << --Enable Links

        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the posted invoice number.', FRA = 'Spécifie le numéro de facture enregistrée.';
        }
        modify("Buy-from Vendor Name")
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
            ToolTipML = ENU = 'Specifies the name of the vendor who shipped the items.', FRA = 'Spécifie le nom du fournisseur qui a expédié les articles.';
        }
        modify("Buy-from")
        {
            CaptionML = ENU = 'Buy-from', FRA = 'Fournisseur';
        }
        modify("Buy-from Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address of the vendor who shipped the items.', FRA = 'Spécifie l''adresse du fournisseur qui a expédié les articles.';

            //Unsupported feature: Change ImplicitType on ""Buy-from Address"(Control 61)". Please convert manually.

        }
        modify("Buy-from Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Buy-from Address 2"(Control 63)". Please convert manually.

        }
        modify("Buy-from Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Buy-from City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city of the vendor who shipped the items.', FRA = 'Spécifie la ville du fournisseur qui a expédié les articles.';

            //Unsupported feature: Change ImplicitType on ""Buy-from City"(Control 65)". Please convert manually.

        }
        modify("Buy-from Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of the contact you bought the items from.', FRA = 'Indique le numéro du contact auprès duquel vous avez acheté les articles.';
        }
        modify("Buy-from Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person to contact at the vendor who shipped the items.', FRA = 'Spécifie le nom de la personne à contacter chez le fournisseur.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date the purchase header was posted.', FRA = 'Spécifie la date de validation de l''en-tête achat.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the purchase document was created.', FRA = 'Spécifie la date à laquelle vous avez créé le document achat.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies when the invoice is due. The program calculates the date using the Payment Terms Code and Document Date fields on the purchase header.', FRA = 'Spécifie la date d''échéance de la facture. Le programme calcule la date à l''aide des champs Code condition paiement et Date document de l''en-tête achat.';
        }
        modify("Quote No.")
        {
            ToolTipML = ENU = 'Specifies the number of the purchase quote document if a quote was used to start the purchase process.', FRA = 'Spécifie le numéro du document devis achat si un devis a été utilisé pour démarrer le processus d''achat.';
        }
        modify("Order No.")
        {
            ToolTipML = ENU = 'Specifies the number of the purchase order that this invoice was posted from.', FRA = 'Spécifie le numéro de la commande achat à partir de laquelle la facture a été validée.';
        }
        modify("Vendor Invoice No.")
        {
            ToolTipML = ENU = 'Specifies the vendor''s own invoice number.', FRA = 'Spécifie le numéro de facture propre au fournisseur.';
        }
        modify("Vendor Order No.")
        {
            ToolTipML = ENU = 'Specifies the vendor''s order number.', FRA = 'Spécifie le numéro de commande du fournisseur.';
        }
        modify("Pre-Assigned No.")
        {
            ToolTipML = ENU = 'Specifies the number of the purchase document that the posted invoice was created for.', FRA = 'Spécifie le numéro du document achat pour lequel la facture enregistrée a été créée.';
        }
        modify("No. Printed")
        {
            ToolTipML = ENU = 'Specifies how many times the invoice has been printed.', FRA = 'Spécifie combien de fois la facture a été imprimée.';
        }
        modify("Order Address Code")
        {
            ToolTipML = ENU = 'Specifies the order address code used in the invoice.', FRA = 'Spécifie le code adresse commande utilisé pour la facture.';
        }
        modify("Purchaser Code")
        {
            ToolTipML = ENU = 'Specifies which purchaser is associated with the invoice.', FRA = 'Spécifie l''acheteur associé à la facture.';
        }
        modify("Responsibility Center")
        {
            ToolTipML = ENU = 'Specifies the code for the responsibility center that serves the vendor on this purchase document.', FRA = 'Spécifie le code du centre de gestion qui dessert le fournisseur figurant sur ce document achat.';
        }
        modify(Cancelled)
        {
            ToolTipML = ENU = 'Specifies if the posted purchase invoice has been either corrected or canceled.', FRA = 'Spécifie si la facture achat validée a été corrigée ou annulée.';
        }
        modify(Corrective)
        {
            ToolTipML = ENU = 'Specifies if the posted purchase invoice is a corrective document.', FRA = 'Indique si la facture achat validée est un document de correction.';
        }
        modify("Invoice Details")
        {
            CaptionML = ENU = 'Invoice Details', FRA = 'Détails facture';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code used to calculate the amounts on the invoice.', FRA = 'Spécifie le code devise utilisé pour calculer les montants de la facture.';
        }
        modify("Expected Receipt Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the invoiced items were expected.', FRA = 'Spécifie la date de réception prévue des articles facturés.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies the code to use to find the payment terms that apply to the purchase header.', FRA = 'Spécifie le code à utiliser pour trouver les conditions de paiement qui s''appliquent à l''en-tête achat.';
        }
        modify("Payment Method Code")
        {
            ToolTipML = ENU = 'Specifies the method of payment to vendors. The program has copied the code from the Payment Method Code field on the purchase header.', FRA = 'Spécifie le mode de règlement aux fournisseurs. Le programme copie le code du champ Code mode de règlement de l''en-tête achat.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension value associated with the invoice.', FRA = 'Spécifie le code de la section analytique associée à la facture.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension value associated with the invoice.', FRA = 'Spécifie le code de la section analytique associée à la facture.';
        }
        modify("Payment Discount %")
        {
            ToolTipML = ENU = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.', FRA = 'Spécifie le pourcentage escompte accordé si le paiement est effectué au plus tard à la date saisie dans le champ Date d''escompte.';
        }
        modify("Pmt. Discount Date")
        {
            ToolTipML = ENU = 'Specifies the last date on which you can pay the invoice and still receive a payment discount.', FRA = 'Spécifie la dernière date à laquelle vous pouvez régler la facture et bénéficier tout de même de l''escompte.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code for the location where the items are registered.', FRA = 'Spécifie le code du magasin où les articles sont enregistrés.';
        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies the code that represents the shipment method for this invoice.', FRA = 'Spécifie le code qui représente les conditions de livraison de cette facture.';
        }
        modify("Payment Reference")
        {
            ToolTipML = ENU = 'Identifies the payment of the purchase invoice.', FRA = 'Identifie le paiement de la facture achat.';
            trigger OnDrillDown()
            var
                PurchInvHeaderRec: Record "Purch. Inv. Header";
                ChangePaymentReferencePage: Page "Change Payment Reference";
            begin
                // BC Upgrade KUMARS145 added this section make the field Editable PTP099-Open prepayments report....>>
                if PurchInvHeaderRec.Get(Rec."No.") then begin
                    ChangePaymentReferencePage.SetRecord(PurchInvHeaderRec);
                    ChangePaymentReferencePage.RunModal();
                    CurrPage.Update();
                end;
                // BC Upgrade KUMARS145 added this section make the field Editable PTP099-Open prepayments report....<<
            end;
        }
        modify("Shipping and Payment")
        {
            CaptionML = ENU = 'Shipping and Payment', FRA = 'Expédition et paiement';
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
            ToolTipML = ENU = 'Specifies the name of the company at the address to which the items in the purchase order were shipped.', FRA = 'Spécifie le nom de la société située à l''adresse à laquelle les articles de la commande achat ont été livrés.';
        }
        modify("Ship-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address that the items in the purchase order were shipped to.', FRA = 'Spécifie l''adresse à laquelle les articles du bon de commande ont été expédiés.';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 40)". Please convert manually.

        }
        modify("Ship-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 42)". Please convert manually.

        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Ship-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city the items in the purchase order were shipped to.', FRA = 'Spécifie la ville vers laquelle les articles du bon de commande ont été expédiés.';

            //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 44)". Please convert manually.

        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of a contact person at the address that the items in the purchase order were shipped to.', FRA = 'Spécifie le nom d''un contact situé à l''adresse à laquelle les articles de la commande achat ont été expédiés.';
        }
        modify("Pay-to")
        {
            CaptionML = ENU = 'Pay-to', FRA = 'Paiement';
        }
        modify("Pay-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the name of the vendor who you received the invoice from.', FRA = 'Spécifie le nom du fournisseur qui vous a fourni la facture.';
        }
        modify("Pay-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address of the vendor that you received the invoice from.', FRA = 'Spécifie l''adresse du fournisseur qui vous a fourni la facture.';

            //Unsupported feature: Change ImplicitType on ""Pay-to Address"(Control 22)". Please convert manually.

        }
        modify("Pay-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Pay-to Address 2"(Control 24)". Please convert manually.

        }
        modify("Pay-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Pay-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city of the vendor you received the invoice from.', FRA = 'Spécifie la ville du fournisseur qui vous a fourni la facture.';

            //Unsupported feature: Change ImplicitType on ""Pay-to City"(Control 26)". Please convert manually.

        }
        modify("Pay-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of the contact you received the invoice from.', FRA = 'Spécifie le numéro du contact qui vous a fourni la facture.';
        }
        modify("Pay-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person you should contact at the vendor who you received the invoice from.', FRA = 'Spécifie le nom de la personne que vous devez contacter chez le fournisseur qui vous a envoyé la facture.';
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        //BC Upgrade GUNREM01 >> -DIT
        // addafter("Document Date")
        // {
        //     field("Tax Date"; "Tax Date")
        //     {
        //         Editable = false;
        //     }
        // }
        // addafter("No. Printed")
        // {
        //     field("Your Reference"; "Your Reference")
        //     {
        //         Description = 'FINXL7.00.001';
        //         Editable = false;
        //     }
        //     field("Posting Description"; "Posting Description")
        //     {
        //         Description = 'FINXL7.00.001';
        //         Editable = false;
        //     }
        //     field(OGM; OGM)
        //     {
        //     }
        //} //BC Upgrade GUNREM01 << -DIT
        // addafter("Responsibility Center")
        // {
        // field("Vendor DTax Group Code"; "Vendor DTax Group Code")
        // {
        //     Editable = false;
        // }  //BC Upgrade GUNREM01 -DIT
        // }
        addafter(Corrective)
        {
            field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Fixed Asset Acquisition field.';
            }
            // field("Maximo Status"; Rec."Maximo Status")
            // {
            // } //BC Upgrade GUNREM01 Field moved to Interface 
            field("License Code"; PurchHdrAddiRec."License Code")
            {
                Editable = false;
                Visible = true;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the License Code field.';
            }
        }
        addafter("Currency Code")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
            }
        }
        //BC Upgrade VAMSIU01 - Document Subtype code field added >>
        addafter("Pmt. Discount Date")
        {
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                Description = '<DITW18.00.07 DIT-770 #1508>-NRQ17902';
                Editable = false;
                Importance = Additional;
                ApplicationArea = All;
            }
        }
        //BC Upgrade VAMSIU01 - Document Subtype code field added <<
        addafter("Payment Reference")
        {
            // field("Creditor No.";"Creditor No.")
            // {
            //     Importance = Additional;
            //     ToolTip = 'Identifies the vendor who sent the purchase invoice.';
            // } //BC Upgrade GUNREM01 -Field already available in page
            field("Payment Status"; Rec."Payment Status FND")
            {
                OptionCaption = 'Pending Review,Payment Approved,Payment Rejected,OK for Payment';
                ApplicationArea = all;
                // BC Upgrade - RD03 Made Payment Status Field Non Editable ---- >>
                Editable = false;
                // BC Upgrade - RD03 Made Payment Status Field Non Editable ---- >>
                ToolTip = 'Specifies the value of the Payment Status field.';
                trigger OnDrillDown()
                var
                    PurchInvHeaderRec: Record "Purch. Inv. Header";
                    ChangePaymentStatusPage: Page "Change Payment Status PPI";
                begin
                    // BC Upgrade KUMARS145 PTP154-Approve Invoice (no workflow)....>>
                    if PurchInvHeaderRec.Get(Rec."No.") then begin
                        ChangePaymentStatusPage.SetRecord(PurchInvHeaderRec);
                        ChangePaymentStatusPage.RunModal();
                        CurrPage.Update();
                    end;
                    // BC Upgrade KUMARS145 PTP154-Approve Invoice (no workflow)....<<
                end;
            }
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = all;
                // BC Upgrade - RD03 Made Reason Code Field Non Editable ---- >>
                Editable = false;
                // BC Upgrade - RD03 Made Reason Code Field Non Editable ---- <<
                ToolTip = 'Specifies the value of the Reason Code field.';
                trigger OnDrillDown()
                var
                    PurchInvHeaderRec: Record "Purch. Inv. Header";
                    // BC Upgrade - RD03 Page Renamed ---- >>
                    ChangeReasonCodePage: Page "Change Reason Code PPI";
                // BC Upgrade - RD03 Page Renamed ---- <<
                begin
                    // BC Upgrade KUMARS145 added this section make the field Editable PTP099-Open prepayments report....>>
                    if PurchInvHeaderRec.Get(Rec."No.") then begin
                        ChangeReasonCodePage.SetRecord(PurchInvHeaderRec);
                        ChangeReasonCodePage.RunModal();
                        CurrPage.Update();
                    end;
                    // BC Upgrade KUMARS145 added this section make the field Editable PTP099-Open prepayments report....<<
                end;
            }
            field("On Hold"; rec."On Hold")
            {
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the On Hold field.';
            }
            field("On Hold UserID"; Rec."On Hold UserID FND")
            {
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the On Hold UserID field.';
            }
            field("On Hold Date"; Rec."On Hold Date FND")
            {
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the On Hold Date field.';
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the User ID field.';
            }
            field("Blanket Order No."; Rec."Blanket Order No. FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Blanket Order No. field.';
                trigger OnDrillDown()
                var
                    PurchInvHeaderRec: Record "Purch. Inv. Header";
                    ChangeBlanketOrderNoPage: Page "Change Blanket Order No.";
                begin
                    // BC Upgrade KUMARS145 added this section make the field Editable PTP099-Open prepayments report....>>
                    if PurchInvHeaderRec.Get(Rec."No.") then begin
                        ChangeBlanketOrderNoPage.SetRecord(PurchInvHeaderRec);
                        ChangeBlanketOrderNoPage.RunModal();
                        CurrPage.Update();
                    end;
                    // BC Upgrade KUMARS145 added this section make the field Editable PTP099-Open prepayments report....<<
                end;
            }
            field("Payment User"; Rec."Payment User FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Payment User field.';
            }
            field("Status Date"; Rec."Status Date FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Status Date field.';
            }
        }
        // addafter("Pay-to")
        // {
        // field("Physical Location Group Code"; rec."Physical Location Group Code")
        // {
        //     Editable = false;
        //     Importance = Additional;
        // } //BC Upgrade GUNREM01 -DIT
        //  }
        // addafter("Shipment Method Code")
        // {
        //BC Upgrade GUNREM01 >> DIT
        // field("Truck Code"; "Truck Code")
        // {
        //     Editable = false;
        // }
        // field("Driver Code"; "Driver Code")
        // {
        //     Editable = false;
        // }
        //BC Upgrade GUNREM01 << DIT

        //BC Upgrade GUNREM01 >> DIT
        // group("Service/Contract")
        // {
        //     CaptionML = ENU = 'Service/Contract',
        //                 FRA = 'Service/ Contrat';
        //     field("Contract Type"; "Contract Type")
        //     {
        //         Editable = false;
        //     }
        //     field("DIT Sub-Contract Type"; "DIT Sub-Contract Type")
        //     {
        //     }
        //     field("Service Contract No."; "Service Contract No.")
        //     {
        //     }
        //     field("Financial Contract No."; "Financial Contract No.")
        //     {
        //     }
        //     field("Contract Group Code"; "Contract Group Code")
        //     {
        //     }
        // }
        //BC Upgrade GUNREM01 << DIT
        //BC Upgrade GUNREM01 >> -Fields moved to interface
        // group(SRM)
        // {
        //     Caption = 'SRM';
        //     field("SRM Contract No."; Rec."SRM Contract No.")
        //     {
        //     }
        //     field("SRM Contract Name"; Rec."SRM Contract Name")
        //     {
        //     }
        //     field("SRM Contract Type"; Rec."SRM Contract Type")
        //     {
        //     }
        //     field("Valid From"; Rec."Valid From")
        //     {
        //     }
        //     field("Valid To"; Rec."Valid To")
        //     {
        //     }
        //     field(Channel; Rec.Channel)
        //     {
        //     }
        //     field("Shipment Method Location"; Rec."Shipment Method Location")
        //     {
        //     }
        //     field("Contract Closed"; Rec."Contract Closed")
        //     {
        //     }
        //     field("SRM Order No."; Rec."SRM Order No.")
        //     {
        //     }
        //     field("Target Value Currency"; Rec."Target Value Currency")
        //     {
        //     }
        //     field("Target Value Amount"; Rec."Target Value Amount")
        //     {
        //     }
        // }
        //BC Upgrade GUNREM01 << -Fields moved to interface
        // }
        moveafter("Pmt. Discount Date"; "Payment Reference")
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
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
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
            // BC Upgrade VAMSIU01 - Added Document Subtype related code >>
            trigger OnBeforeAction()
            begin
                //HEI.07>>
                if CheckDocSubTypeCode then
                    ERROR(Text50000);
                //HEI.07<<
            end;
            // BC Upgrade VAMSIU01 - Added Document Subtype related code >>
        }
        modify("Actions")
        {
            CaptionML = ENU = 'Actions', FRA = 'Actions';
        }
        modify(Vendor)
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
            ToolTipML = ENU = 'View or edit detailed information about the vendor on the posted purchase document.', FRA = 'Affichez ou modifiez des informations détaillées concernant le fournisseur sur le document achat validé.';
        }
        modify(ShowCreditMemo)
        {
            CaptionML = ENU = 'Show Canceled/Corrective Credit Memo', FRA = 'Afficher avoir annulé/de correction';
            ToolTipML = ENU = 'Open the posted purchase credit memo that was created when you canceled the posted purchase invoice. If the posted purchase invoice is the result of a canceled purchase credit memo, then canceled purchase credit memo will open.', FRA = 'Ouvrez l''avoir achat validé qui a été créé lorsque vous avez annulé la facture achat validée. Si la facture achat validée est le résultat d''un avoir achat annulé, ce dernier s''ouvrira.';
        }
        modify(Navigate)
        {
            CaptionML = ENU = '&Navigate', FRA = '&Naviguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the posted purchase document.', FRA = 'Recherchez toutes les écritures et les documents qui existent pour le numéro de document et la date comptabilisation sur le document achat validé.';
        }
        // modify(ActionGroup29)
        // {
        //     CaptionML = ENU = 'Print', FRA = 'Imprimer';
        // } //BC Upgrade GUNREM01 - print already there 
        modify(Print)
        {
            CaptionML = ENU = '&Print', FRA = 'Im&primer';
            ToolTipML = ENU = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.', FRA = 'Préparez-vous à imprimer le document. Une fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document.';
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
            CaptionML = ENU = 'Select Incoming Document', FRA = 'Sélectionner le document entrant';
            ToolTipML = ENU = 'Select an incoming document record and file attachment that you want to link to the entry or document.', FRA = 'Sélectionnez un fichier joint ou un enregistrement de document entrant que vous voulez associer à l''écriture ou au document.';
        }
        modify(IncomingDocAttachFile)
        {
            CaptionML = ENU = 'Create Incoming Document from File', FRA = 'Créer un document entrant à partir d''un fichier';
            ToolTipML = ENU = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.', FRA = 'Créez un enregistrement de document entrant en sélectionnant un fichier à joindre, puis associez l''enregistrement de document entrant à l''écriture ou au document.';
        }


        //Unsupported feature: CodeModification on "CreateCreditMemo(Action 21).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CorrectPostedPurchInvoice.CreateCreditMemoCopyDocument(Rec,PurchaseHeader);
        PAGE.RUN(PAGE::"Purchase Credit Memo",PurchaseHeader);
        CurrPage.CLOSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.07>>
        if CheckDocSubTypeCode then
          ERROR(Text50000);
        //HEI.07<<

        #1..3
        */
        //end;


        //Unsupported feature: CodeModification on "Print(Action 27).OnAction". Please convert manually.

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
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.PurchInvLines.PAGE.SetDisableRefreshLines(true);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
        PurchInvHeader := Rec;
        //>> DITW18.00.07 AKH DIT-770 #1508
        CurrPage.SETSELECTIONFILTER(PurchInvHeader);
        PurchInvHeader.PrintRecords(true);
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.PurchInvLines.PAGE.SetDisableRefreshLines(false);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        */
        //end;
        // addafter(Approvals)
        // {
        //     action("Purchase Invoice Additional")
        //     {
        //         Caption = 'Purchase Invoice Additional';
        //         Image = Purchase;
        //         RunObject = Page "Purch. Inv. Additional";
        //         RunPageLink = "No." = FIELD("No.");
        //     }
        // } //BC Upgrade GUNREM01 added in Interface
        //  moveafter(ActionContainer1900000004; "&Navigate") //BC Upgrade GUNREM01
    }

    trigger OnAfterGetRecord();
    begin
        //HEI.06 >>
        PurchHdrAddiRec.RESET();
        PurchHdrAddiRec.SETRANGE("No.", REC."Pre-Assigned No.");
        if PurchHdrAddiRec.FINDFIRST() then;
        //HEI.06 <<
    end;

    var
        Text50000: Label 'You cannot create a corrective credit memo for this Document Subtype';
        PurchHdrAddiRec: Record "Purchase Header Additional FND";


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    //HEI.06 >>
    PurchHdrAddiRec.RESET;
    PurchHdrAddiRec.SETRANGE("No.","Pre-Assigned No.");
    if PurchHdrAddiRec.FINDFIRST then;
    //HEI.06 <<
    */
    //end;

    // BC Upgrade VAMSIU01 - Added Document Subtype Code >>
    local procedure CheckDocSubTypeCode(): Boolean;
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DocumentSubtypeCode: Record "Document Subtype Code FND";
    begin
        //HEI.07>>
        PurchasesPayablesSetup.GET;
        DocumentSubtypeCode.RESET;
        DocumentSubtypeCode.SETRANGE("Report Selection Type", DocumentSubtypeCode."Report Selection Type"::Purchase);
        DocumentSubtypeCode.SETFILTER(Code, PurchasesPayablesSetup."Corrective CM Not Allowed FND");
        if DocumentSubtypeCode.FINDSET then begin
            if (DocumentSubtypeCode.Code = Rec."Document Subtype Code FND") or (Rec."Document Subtype Code FND" = '') then
                exit(true);
        end;
        exit(false);
        //HEI.07<<
    end;
    // BC Upgrade VAMSIU01 - Added Document Subtype Code <<    

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}
