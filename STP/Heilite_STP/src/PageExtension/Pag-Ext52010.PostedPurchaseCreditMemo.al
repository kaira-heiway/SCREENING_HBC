pageextension 52010 PostedPurchaseCReditmemoExt extends "Posted Purchase Credit Memo"
{
    // version NAVW110.0.00.15052,FINXL10.00,DITW110.00.11,HEI.01
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
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

    //   HEI.01 HLSRM02-05 IBM LAZARE02 31.07.2017
    //     #New fields for SRM integration added to SRM tab

    //   HEI.02 Defect 1722 IBM.NAIKH01 26.03.2018
    //     # Set the Property "Modifiedalloewd" to Yes on the page, to show the Eidt Button
    //   HEI.03 FDD-PURGAP027 IBM NASTAA02 14.06.2019 # Maximo POs Approval Flow
    //     # Created new Page Action "Purchase Receipt Additional"
    //   HEI.04 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //     # New Field added: "Fixed Asset Acquisition"
    //   HEI.05 CHG2024557 FDD-HT821 IBM SHANKJ03 12.02.2020
    //     # New field added "Maximo Status"
    //   HEI.06 FDD HT1136 CHG2055070 IBM Shankj03 01.10.2020
    //     # Added New Field License COde
    //HEI.01 - //BC Upgrade GUNREM01 added in interface
    // HEI.03 -//BC Upgrade GUNREM01 added in interface
    // BC Upgrade - RD03 Page Renamed
    // BC Upgrade - RD03 Made Reason Code Field Non Editable
    // BC Upgrade - RD03 Made Payment Status Field Non Editable
    // BC Upgrade - RD03 enabled Drilldown trigger to Payment Status and Reason Code fields.


    ModifyAllowed = true; //HEI.02- BC Upgrade GUNREM01 added
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

            //Unsupported feature: Change ImplicitType on ""Buy-from Address"(Control 53)". Please convert manually.

        }
        modify("Buy-from Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Buy-from Address 2"(Control 55)". Please convert manually.

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

            //Unsupported feature: Change ImplicitType on ""Buy-from City"(Control 57)". Please convert manually.

        }
        modify("Buy-from Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of the contact who you sent the purchase credit memo to.', FRA = 'Spécifie le numéro du contact auquel vous avez envoyé l''avoir achat.';
        }
        modify("Buy-from Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person to contact at the vendor who shipped the items.', FRA = 'Spécifie le nom de la personne à contacter chez le fournisseur.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date the credit memo was posted.', FRA = 'Spécifie la date de validation de l''avoir.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the purchase document was created.', FRA = 'Spécifie la date à laquelle vous avez créé le document achat.';
        }
        modify("Pre-Assigned No.")
        {
            ToolTipML = ENU = 'Specifies the number of the credit memo that the posted credit memo was created from.', FRA = 'Spécifie le numéro de l''avoir à partir duquel l''avoir validé a été créé.';
        }
        modify("Vendor Cr. Memo No.")
        {
            ToolTipML = ENU = 'Specifies the vendor''s number for this credit memo.', FRA = 'Spécifie le numéro du fournisseur pour cet avoir.';
        }
        modify("Order Address Code")
        {
            ToolTipML = ENU = 'Specifies the order address code used in the credit memo.', FRA = 'Spécifie le code adresse commande utilisé pour l''avoir.';
        }
        modify("Purchaser Code")
        {
            ToolTipML = ENU = 'Specifies which purchaser is associated with the credit memo.', FRA = 'Spécifie le nom de l''acheteur associé à l''avoir.';
        }
        modify("Responsibility Center")
        {
            ToolTipML = ENU = 'Specifies the code for the responsibility center that serves the vendor on this purchase document.', FRA = 'Spécifie le code du centre de gestion qui dessert le fournisseur figurant sur ce document achat.';
        }
        modify(Cancelled)
        {
            ToolTipML = ENU = 'Specifies if the posted purchase invoice that relates to this purchase credit memo has been either corrected or canceled.', FRA = 'Spécifie si la facture achat validée liée à cet avoir achat a été corrigée ou annulée.';
        }
        modify(Corrective)
        {
            ToolTipML = ENU = 'Specifies if the posted purchase invoice has been either corrected or canceled by this purchase credit memo .', FRA = 'Indique si la facture achat validée a été corrigée ou annulée par cet avoir achat.';
        }
        modify("No. Printed")
        {
            ToolTipML = ENU = 'Specifies how many times the credit memo has been printed.', FRA = 'Spécifie combien de fois l''avoir a été imprimé.';
        }
        modify("Invoice Details")
        {
            CaptionML = ENU = 'Invoice Details', FRA = 'Détails facture';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code used to calculate the amounts on the credit memo.', FRA = 'Spécifie le code devise utilisé pour calculer les montants de l''avoir.';
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
            ToolTipML = ENU = 'Specifies the code for the location used when you posted the credit memo.', FRA = 'Spécifie le code du magasin utilisé lorsque vous avez validé l''avoir.';
        }
        modify("Applies-to Doc. Type")
        {
            ToolTipML = ENU = 'Specifies the type of the posted document that this document or journal line is applied to.', FRA = 'Spécifie le type de document validé auquel ce document a été appliqué.';
        }
        modify("Applies-to Doc. No.")
        {
            ToolTipML = ENU = 'Specifies the number of the posted document that this document or journal line is applied to.', FRA = 'Spécifie le numéro du document validé avec lequel ce document ou cette ligne feuille est lettrée.';
        }
        modify("Shipping and Payment")
        {
            CaptionML = ENU = 'Shipping and Payment', FRA = 'Expédition et paiement';
        }
        modify("Ship-to")
        {
            CaptionML = ENU = 'Ship-to', FRA = 'Destinataire';
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

            //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 36)". Please convert manually.

        }
        modify("Ship-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 38)". Please convert manually.

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

            //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 40)". Please convert manually.

        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of a contact person at the address that the items were shipped to.', FRA = 'Spécifie le nom d''un contact à l''adresse à laquelle les articles ont été expédiés.';
        }
        modify("Pay-to")
        {
            CaptionML = ENU = 'Pay-to', FRA = 'Paiement';
        }
        modify("Pay-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the name of the vendor that you received the credit memo from.', FRA = 'Spécifie le nom du fournisseur qui vous a fourni l''avoir.';
        }
        modify("Pay-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address of the vendor that you received the credit memo from.', FRA = 'Spécifie l''adresse du fournisseur qui vous a fourni l''avoir.';

            //Unsupported feature: Change ImplicitType on ""Pay-to Address"(Control 26)". Please convert manually.

        }
        modify("Pay-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Pay-to Address 2"(Control 28)". Please convert manually.

        }
        modify("Pay-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Pay-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            ToolTipML = ENU = 'Specifies the city of the vendor you received the credit memo from.', FRA = 'Spécifie la ville du fournisseur qui vous a fourni l''avoir.';

            //Unsupported feature: Change ImplicitType on ""Pay-to City"(Control 30)". Please convert manually.

        }
        modify("Pay-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of the contact at the vendor who handles the credit memo.', FRA = 'Spécifie le numéro du contact chez le fournisseur qui traite l''avoir.';
        }
        modify("Pay-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person you should contact at the vendor who you received the credit memo from.', FRA = 'Spécifie le nom de la personne que vous devez contacter chez le fournisseur qui vous a envoyé l''avoir.';
        }
        //BC Upgrade GUNREM01 >> -DIT
        // modify("Foreign Trade")
        // {
        //     CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        // } BC Upgrade GUNREM01 Field is not available in BC
        // addafter("Buy-from Contact")
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
        // } 
        // addafter("Document Date")
        // {
        //     field("Tax Date"; "Tax Date")
        //     {
        //         Editable = false;
        //     }
        // }
        // addafter("Responsibility Center")
        // {
        //     field("Vendor DTax Group Code"; "Vendor DTax Group Code")
        //     {
        //         Editable = false;
        //     }
        // } //BC Upgrade GUNREM01 << -DIT
        addafter("No. Printed")
        {
            field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Fixed Asset Acquisition field.';
            }
            // field("Maximo Status"; "Maximo Status")
            // {
            // } //BC Upgrade GUNREM01 added in Interface
            field("License Code"; PUrchHdrAddtRec."License Code")
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
            field("Document Subtype Code"; REC."Document Subtype Code FND")
            {
                Description = '<DITW18.00.07 DIT-770 #1508>-NRQ17902';
                Importance = Additional;
                ApplicationArea = All; // BC Upgrade VAMSIU01 - Added >>
            }
            field("Payment User"; Rec."Payment User FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Payment User field.';

            }
            field("Payment Status"; Rec."Payment Status FND")
            {
                ApplicationArea = all;
                // BC Upgrade - RD03 Made Payment Status Field Non Editable ---- >>
                Editable = false;
                // BC Upgrade - RD03 Made Payment Status Field Non Editable ---- <<
                ToolTip = 'Specifies the value of the Payment Status field.';
                // BC Upgrade - RD03 enabled Drilldown trigger ---- >>
                trigger OnDrillDown()
                var
                    PurchCrMemoHeaderRec: Record "Purch. Cr. Memo Hdr.";
                    ChangePaymentStatusPage: Page "Change Payment Status CrM";
                begin
                    // BC Upgrade KUMARS145 PTP154-Approve Invoice (no workflow)....>>
                    if PurchCrMemoHeaderRec.Get(Rec."No.") then begin
                        ChangePaymentStatusPage.SetRecord(PurchCrMemoHeaderRec);
                        ChangePaymentStatusPage.RunModal();
                        CurrPage.Update();
                    end;
                    // BC Upgrade KUMARS145 PTP154-Approve Invoice (no workflow)....<<
                end;
                // BC Upgrade - RD03 enabled Drilldown trigger ---- <<
            }
            field("Status Date"; Rec."Status Date FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Status Date field.';
            }
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Reason Code field.';
                // BC Upgrade - RD03 Made Reason Code Field Non Editable --- >>
                Editable = false;
                // BC Upgrade - RD03 Made Reason Code Field Non Editable ---- <<
                // BC Upgrade - RD03 enabled Drilldown trigger ---- >>
                trigger OnDrillDown()
                var
                    PurchCrMemoHeaderRec: Record "Purch. Cr. Memo Hdr.";
                    ChangeReasonCodePage: Page "Change Reason Code CrM";
                begin
                    // BC Upgrade KUMARS145 added this section make the field Editable PTP099-Open prepayments report....>>
                    if PurchCrMemoHeaderRec.Get(Rec."No.") then begin
                        ChangeReasonCodePage.SetRecord(PurchCrMemoHeaderRec);
                        ChangeReasonCodePage.RunModal();
                        CurrPage.Update();
                    end;
                    // BC Upgrade KUMARS145 added this section make the field Editable PTP099-Open prepayments report....<<
                end;
                // BC Upgrade - RD03 enabled Drilldown trigger ---- >>
            }
            field("On Hold"; Rec."On Hold")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Specifies the value of the On Hold field.';
            }
            field("On Hold UserID"; Rec."On Hold UserID FND")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Specifies the value of the On Hold UserID field.';
            }
            field("On Hold Date"; Rec."On Hold Date FND")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Specifies the value of the On Hold Date field.';
            }
            //BC Upgrade GUNREM01 >> DIT
            // group("Service/Contract")
            // {
            //     CaptionML = ENU = 'Service/Contract',
            //                 FRA = 'Service/ Contrat';
            //     field("Contract Type"; Rec."Contract Type")
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
        }
        //BC Upgrade GUNREM01 >> DIT
        // addafter("Location Code")
        // {
        //     field("Truck Code"; "Truck Code")
        //     {
        //         Editable = false;
        //     }
        //     field("Driver Code"; "Driver Code")
        //     {
        //         Editable = false;
        //     }
        // }


        // addafter("Ship-to")
        // {
        //     field("Physical Location Group Code"; "Physical Location Group Code")
        //     {
        //         Editable = false;
        //         Importance = Additional;
        //     }
        // }  //BC Upgrade GUNREM01 << DIT
        // addafter("Foreign Trade")

        //BC Upgrade GUNREM01 >> added fields in Interface
        // addafter("Invoice Details")
        // {
        //     group(SRM)
        //     {
        //         Caption = 'SRM';
        //         field("SRM Contract No."; Rec."SRM Contract No.")
        //         {
        //             ApplicationArea = all;
        //         }
        //         field("SRM Contract Name"; Rec."SRM Contract Name")
        //         {
        //             ApplicationArea = all;
        //         }
        //         field("SRM Contract Type"; Rec."SRM Contract Type")
        //         {
        //             ApplicationArea = all;
        //         }
        //         field("Valid From"; Rec."Valid From")
        //         {
        //             ApplicationArea = all;
        //         }
        //         field("Valid To"; Rec."Valid To")
        //         {
        //             ApplicationArea = all;
        //         }
        //         field(Channel; Rec.Channel)
        //         {
        //             ApplicationArea = all;
        //         }
        //         field("Shipment Method Location"; Rec."Shipment Method Location")
        //         {
        //             ApplicationArea = all;
        //         }
        //         field("Contract Closed"; Rec."Contract Closed")
        //         {
        //             ApplicationArea = all;
        //         }
        //         field("SRM Order No."; Rec."SRM Order No.")
        //         {
        //             ApplicationArea = all;
        //         }
        //         field("Target Value Currency"; Rec."Target Value Currency")
        //         {
        //             ApplicationArea = all;
        //         }
        //         field("Target Value Amount"; Rec."Target Value Amount")
        //         {
        //             ApplicationArea = all;
        //         }
        //     }
        // }
        //BC Upgrade GUNREM01 << added fields in Interface
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
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
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


        //Unsupported feature: CodeModification on ""&Print"(Action 48).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(PurchCrMemoHeader);
        PurchCrMemoHeader.PrintRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.PurchCrMemoLines.PAGE.SetDisableRefreshLines(true);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
        PurchCrMemoHeader := Rec;
        //>> DITW18.00.07 AKH DIT-770 #1508
        CurrPage.SETSELECTIONFILTER(PurchCrMemoHeader);
        PurchCrMemoHeader.PrintRecords(true);
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.PurchCrMemoLines.PAGE.SetDisableRefreshLines(false);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        */
        //end;
        // addafter(Approvals)
        // {
        //     action("Purchase Credit Memo Additional")
        //     {
        //         Caption = 'Purchase Credit Memo Additional';
        //         Image = Purchase;
        //         RunObject = Page "Purch. Cr. Memo Additional";
        //         RunPageLink = "No." = FIELD("No.");
        //     }
        // } //BC Upgrade GUNREM01 Added in Interface 
    }

    var
        PUrchHdrAddtRec: Record "Purchase Header Additional FND";

    trigger OnAfterGetRecord();
    begin

        //HEI.06 >
        PUrchHdrAddtRec.RESET();
        PUrchHdrAddtRec.SETRANGE("No.", Rec."Pre-Assigned No.");
        if PUrchHdrAddtRec.FINDFIRST() then;
        //HEI.06 <<

    end;

    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    //HEI.06 >
    PUrchHdrAddtRec.RESET;
    PUrchHdrAddtRec.SETRANGE("No.","Pre-Assigned No.");
    if PUrchHdrAddtRec.FINDFIRST then;
    //HEI.06 <<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

