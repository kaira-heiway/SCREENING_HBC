namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Purchases.Document;
using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.Request;
using Microsoft.Purchases.Setup;

pageextension 52001 PurchaseOrderListExt extends "Purchase Order List"
{
    // FINXL8.00.001 BSA 10/06/2015 #85 : Added Field "Last changed User ID", "Last changed Date/time"

    // DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Upgrade
    //                                             Convert Control55 Print -> Menu
    //                                             Added 'Shipping Agent Notice' menu into 'Print' button
    //                 20/02/2012 DIT-715 #244
    //                             Added shortcut (warehouse) fields
    //                                 Control1100079000 Shortcut Unit of Measure1 Code
    //                                 Control1100079001 Shortcut Unit of Measure2 Code
    //                                 Control1100079002 Shortcut Unit of Measure3 Code
    //                 17/02/2012 DIT-715 #244 Added/Moved columns

    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0012.2
    //                         Added field "Requester ID"
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Responsibility Center","Physical Location Group Code"
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field "Sundry Vendor"
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Add Action to Shipping Cost Page + Removed old Shipping Costs fields

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.09 AKH 30/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9

    // HEI.01 PURGAP11 IBM LAZARE02 04.09.2017
    // # New fields for SRM integration: SRM Contract Type, SRM Contract No., Channel, Target Value Currency, Target Value Amount, Valid From, Valid To, Shipment Method Location

    // HEI.02 FDD-PURGAPINT005 IBM NASTAA02 28.09.2017 # Purchase Order Layout Template Procurement
    // # Print button should be enabled just when "SRM Order No." is empty
    // HEI.03 SoicaD filtering by doc subtype

    // HEI.04 RFC-CHG0249183 IBM.LS 28.11.2018
    // # Added code to call SendEmailPurchaseOrder function. Code commented here and added in Codeunit-415.
    // # Added field - "BRC Purchase Order".
    // HEI.05 CHG0255725 IBM GAVANM01 18.04.2019
    // # Added field 'Payment User'
    // HEI.06 RFC-CHG0249183 IBM.LS 22.04.2019
    // # Added new field - "No. Printed".
    // DITW111.00.13A MSF 09/05/2019 NRQ#109271 Disable DIT Discounts and or Promotions for a sales documents
    //                             Added Field "Disable DIT Disc. Prom."
    // HEI.07 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    // # Removed Field "Payment User"
    // # Added Field “PQ Approver”
    // # Created new Page Action "Purchase Additional"
    // HEI.08 CHG2013470 IBM PATHAA02 17.06.2019
    // # Added new Field 'Your Reference' => BC Upgrade SHUKLP03 already added in base page.
    // HEI.09 CHG2024556 IBM PATHAA02 19.09.2019
    // # Show Fields 'Quote No.' & 'Maximo Requisition No'.
    // FINXL11.00 HBA 03/05/2018 NRQ#69018: Added Action "Auto. Send IC Order"
    // HEI.12 FDD-HT657 IBM NASTAA02 27.02.2020 # Ethiopia Intercompany Automation
    // # New Field added: "IC Document"
    // # Code added on OnAfterGetRecord trigger
    // FINXL14.00.15 MSF 13/05/2020 NRQ#117628 Enable /Disable AutoSend To IC
    // HEI.13 CHG2081091 IBM SHANKJ03  01.10.2020
    // # new field added Mail sent & Mail sent date time
    // HEI.14 CHG2083064 IBM.GUNERE01  21.10.2020 # Mail Sent, Mail sent date time fields set to editable false
    // HEI.15 FDD-HB1195 CHG2070051 IBM GUNERE01 04.02.2021 # Import Identifier field added
    // HEI.16 CHG2093868 HB899 IBM GAVANM01  06.04.2021 # LSR - Purchase
    // # New field added LSR Order No
    // HEI.17 CHG2098629 HB2014 IBM NANDIS01 08.04.2021 - LOG_Automatic creation of Transfer Order for Import PO
    // # Called a new function and added in ReOpen and Release, Send Approval button
    // HEI.18 FDD-HB2174 CHG2104952 IBM NANDIS01 22.06.2021 Ibecor - PO API
    // # New button - Ibecor Situational File added
    // HEI.19 FDD-HB2482 CHG2123206 IBM NANDIS01 03.11.2021 - Improvement of multiple HeiLite reports for StP  Procurement users
    // # Added "Created By" field in the page
    // # Added Limit PO in the page
    // HEI.20 CHG2121745 IBM BHATTA09 25.11.2021 - SRM - SC fields to be added in HL
    // # Added "Shopping card No." field in the page
    // # Added "Shopping Card Creation Date" in the page
    // HEI.21 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    // # Removed filter from properties button "Ibecor Situational File"
    // # Code added in button - Ibecor Situational FIle
    // HEI.22 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    // # Added New Fields - Zycus Order No.
    //                     - PO Transaction Interface Zycus
    //                     - Processed PO Transaction Zycus
    // HEI.23 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    // # Added New Fields - Zycus GR UUID
    //                     - Zycus GR Cancel UUID
    //                     - GR Transaction Interface Zycus
    //                     - Processed GR Transaction Zycus
    // HEI.24 CHG2251877 MAJUMS03 05.07.2024 Warehouse Receipt Lines creation issue
    // # Code added under OnValidate() Trigger of "Delivery Finalized" field to proper update of "Warehouse Rcpt/Shpt No." of Warehouse Request to fix
    // the bug related to "Delivery Finalized" field in Purchase Line table and "Warehouse Rcpt/Shpt No." of Warehouse Request table. Code written on
    // Page level to update "Warehouse Rcpt/Shpt No." of Warehouse Request table before triggering the function under Codeunit and to avoid COMMIT.
    // # TableData Warehouse Request=rm Permission added.
    // HEI.25 CHG2251877 MAJUMS03 11.07.2024 Warehouse Receipt Lines creation issue
    // # Code modified.
    // # TableData Warehouse Request=rm Permission is modified as Warehouse Request=rimd.
    // HEI.26 CHG2352814 PATELS08 14.05.2026 - Add column with Expected Physical delivery date (Imp) on PO general header and purchase lines tables.
    //   # Added Field "Exp Physical Del Date(Imp)"

    // BC Upgrade SHUKLP03 >>
    // Hei.12 field blocked because DrinkIT field "IC Document" is used.
    // HEI.21 action("Ibecor Situational File") shared with Sakshi because Interface related code is used. 
    // HEI.03 code blocked because DrinkIT record DocumentSubtypeCodeSetup is used.
    // HEI.24 and HEI.25 TableData "Warehouse Request" code is not added because permission property is removed from business central and we have to assign permission using permission set or manually on users page.
    // DrinkIT code is not added. DrinkIT fields are blocked.
    // BC Upgrade SHUKLP03 <<
    //BC Upgrade SHARMP16-- Page formatting changes

    // BC UPGRADE PATELS08 >>
    // # Tag HEI.26 added to documentation.
    // # Added Field "Exp Physical Del Date(Imp)" in layout
    // BC UPGRADE PATELS08 <<

    layout
    {
        modify("Your Reference")
        {
            Visible = true;
        }//BC upgrade SHARMP16-- page formatting changes
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
            ToolTipML = ENU = 'Specifies the name of the vendor who delivers the items.', FRA = 'Spécifie le nom du fournisseur qui livre les articles.';
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
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
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
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date of the vendor''s invoice.', FRA = 'Spécifie la date de la facture du fournisseur.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.', FRA = 'Spécifie si l''enregistrement est ouvert, en attente d''approbation, a été facturé pour acompte ou a été lancé pour l''étape suivante du traitement.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.', FRA = 'Spécifie une formule qui calcule la date d''échéance du paiement, la date d''escompte et le montant de l''escompte sur le document achat.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies when the purchase invoice is due for payment.', FRA = 'Spécifie la date à laquelle la facture achat doit être payée.';
        }
        modify("Payment Discount %")
        {
            ToolTipML = ENU = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.', FRA = 'Spécifie le pourcentage escompte accordé si le paiement est effectué au plus tard à la date saisie dans le champ Date d''escompte.';
        }
        modify("Payment Method Code")
        {
            ToolTipML = ENU = 'Specifies how payment for the purchase document must be submitted.', FRA = 'Spécifie la manière dont le paiement du document achat doit être réalisé.';
        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies the code that represents the shipment method for this purchase.', FRA = 'Spécifie le code qui représente les conditions de livraison de cet achat.';
        }
        modify("Requested Receipt Date")
        {
            ToolTipML = ENU = 'Specifies the date that you want the vendor to deliver to the ship-to address. The value in the field is used to calculate the latest date you can order the items to have them delivered on the requested receipt date. If you do not need delivery on a specific date, you can leave the field blank.', FRA = 'Spécifie la date à laquelle vous souhaitez que le fournisseur livre les articles à l''adresse destinataire. La valeur du champ est utilisée pour calculer la date limite de commande garantissant la livraison des articles à la date de réception demandée. Si vous ne souhaitez pas indiquer une date de livraison, vous pouvez laisser ce champ vide.';
        }
        modify("Job Queue Status")
        {
            ToolTipML = ENU = 'Specifies the status of a job queue entry that handles the posting of purchase orders.', FRA = 'Spécifie le statut d''une écriture file d''attente des travaux qui gère la validation des commandes achat.';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Total Excl. VAT', FRA = 'Montant';
        }
        modify("Amount Including VAT")
        {
            CaptionML = ENU = 'Total Incl. VAT', FRA = 'Montant TTC';
        }

        //Unsupported feature: PropertyDeletion on "Status(Control 1102601003)". Please convert manually.

        addafter("Shortcut Dimension 2 Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.';
            }
            // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Visible = false;
            // }
            // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.
        }
        // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
        // addafter("Purchaser Code")
        // {
        //     field("Requester ID"; Rec."Requester ID")
        //     {
        //         Description = 'DITW17.00.02 DIT-770 #144';
        //         Visible = false;
        //     }
        // }
        // addafter("Currency Code")
        // {
        //     field("Disc.Promo. Order Calculated"; Rec."Disc.Promo. Order Calculated")
        //     {
        //         Visible = false;
        //     }
        // }
        // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.
        // BC UPGRADE PATELS08 >> # HEI.26
        addbefore("Document Date")
        {
            field("Exp Physical Del Date (Imp)"; Rec."Exp Physical Del Date(Imp) FND")
            {
                CaptionML = ENU = 'Expected Physical Delivery Date (Imp)';
                Description = 'HEI.26';
                ApplicationArea = All; //PTE Build Issue 24June2026
            }
        }
        // BC UPGRADE PATELS08 << # HEI.26
        addafter("Document Date")
        {
            field("Campaign No."; Rec."Campaign No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the campaign number the document is linked to.';
            }
            field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
            {
                ApplicationArea = All;
                ToolTip = 'You can use this field when you post the purchase header, to have the program apply it to a document that has already been posted. In this case, enter here the type of document that you want it to be applied to.';
            }
            field("Expected Receipt Date"; Rec."Expected Receipt Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date you expect to receive the items on the purchase document.';
            }
        }
        addafter("Shipment Method Code")
        {
            field("Shipment Method Location"; Rec."Shipment Method Location FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipment Method Location field.';
            }
        }
        // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
        // addafter("Requested Receipt Date")
        // {
        //     field("Shipping Agent Code"; Rec."Shipping Agent Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
        //     {
        //         Visible = false;
        //     }
        //     field(Distance; Rec.Distance)
        //     {
        //         Visible = false;
        //     }
        //     field("Truck Code"; "Truck Code")
        //     {
        //         Description = 'DIT-715 #244';
        //         Visible = false;
        //     }
        //     field("Driver Code"; "Driver Code")
        //     {
        //         Description = 'DIT-715 #244';
        //         Visible = false;
        //     }
        //     field("Shipping Charge Per"; "Shipping Charge Per")
        //     {
        //         Description = 'DIT-715 #244';
        //         Visible = false;
        //     }
        //     field("Maximum Weight"; "Maximum Weight")
        //     {
        //         Description = 'DIT-715 #244';
        //         Visible = false;
        //     }
        //     field("Maximum Cubage"; "Maximum Cubage")
        //     {
        //         Description = 'DIT-715 #244';
        //         Visible = false;
        //     }
        //     field("Total Weight"; "Total Weight")
        //     {
        //         Visible = false;
        //     }
        //     field("Total Cubage"; "Total Cubage")
        //     {
        //         Visible = false;
        //     }
        //     field("ShortcutQtyUomValue[1]"; ShortcutQtyUomValue[1])
        //     {
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassUom(1);
        //         DecimalPlaces = 0 : 5;
        //         Description = 'DIT-715 #244';
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("ShortcutQtyUomValue[2]"; ShortcutQtyUomValue[2])
        //     {
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassUom(2);
        //         DecimalPlaces = 0 : 5;
        //         Description = 'DIT-715 #244';
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("ShortcutQtyUomValue[3]"; ShortcutQtyUomValue[3])
        //     {
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassUom(3);
        //         DecimalPlaces = 0 : 5;
        //         Description = 'DIT-715 #244';
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Link Purch. Document Type"; "Link Purch. Document Type")
        //     {
        //         Description = 'DIT-715 #244';
        //         Visible = false;
        //     }
        //     field("Link Purch. Document No."; "Link Purch. Document No.")
        //     {
        //         Description = 'DIT-715 #244';
        //         Visible = false;
        //     }
        //     field("Fiscal Representative No."; "Fiscal Representative No.")
        //     {
        //         Description = 'DIT-715 #244';
        //         Visible = false;
        //     }
        //     field("Vendor Tax Registration No."; "Vendor Tax Registration No.")
        //     {
        //         Description = 'DIT-715 #244';
        //         Visible = false;
        //     }
        //     field("Vendor Tax Warehouse Ref."; "Vendor Tax Warehouse Ref.")
        //     {
        //         Description = 'DIT-715 #244';
        //         Visible = false;
        //     }
        // }

        // addafter("Job Queue Status")
        // {
        //     field("Sundry Vendor"; Rec."Sundry Vendor")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Last changed User ID"; "Last changed User ID")
        //     {
        //         Editable = false;
        //     }
        //     field("Last changed Date/time"; "Last changed Date/time")
        //     {
        //         Editable = false;
        //     }
        // }
        // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.
        addafter(Amount)
        {
            field("Total VAT"; Rec."Amount Including VAT" - Rec.Amount)
            {
                Caption = 'Total VAT';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total VAT field.';
            }
        }
        addafter("Amount Including VAT")
        {
            field("SRM Contract Type"; Rec."SRM Contract Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Contract Type field.';
            }
            field("SRM Contract No."; Rec."SRM Contract No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SRM Contract No. field.';
            }
            field("SRM Order No."; Rec."SRM Order No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SRM Order No. field.';
            }
            field("Valid From"; Rec."Valid From FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Valid From field.';
            }
            field("Valid To"; Rec."Valid To FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Valid To field.';
            }
            field(Channel; Rec."Channel FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Channel field.';
            }
            field("Target Value Currency"; Rec."Target Value Currency FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Target Value Currency field.';
            }
            field("Target Value Amount"; Rec."Target Value Amount FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Target Value Amount field.';
            }
            // BC Upgrade VAMSIU01 - Document Subtype Field Added >>
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                Visible = false;
                ApplicationArea = All;
            }
            // BC Upgrade VAMSIU01 - Document Subtype Field Added >>
            field(Receive; Rec.Receive)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Receive field.';
            }
            field("BRC Purchase Order"; Rec."BRC Purchase Order FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the BRC Purchase Order field.';
            }
            field("No. Printed"; Rec."No. Printed")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No. Printed field.';
            }
            // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
            // field("Disable DIT Disc. Prom."; Rec."Disable DIT Disc. Prom.")
            // {
            //     Visible = false;
            // }
            // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.
            field("PQ Approver"; Rec."PQ Approver FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PQ Approver field.';
            }
            field("Quote No."; Rec."Quote No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quote number for the purchase order.';
            }
            field("Maximo Requisition No."; Rec."Maximo Requisition No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Maximo Requisition No. field.';
            }
            field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Fixed Asset Acquisition field.';
            }
            // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
            // field("Created By"; Rec."Created By")
            // {
            // }
            // field("IC Document"; PurchaseHeaderAdditional."IC Document")
            // {
            //     Description = 'HEI.12';
            //     Editable = false;
            // }
            // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.
            field("Mail Sent"; PurchaseHeaderAdditional."Mail Sent")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Mail Sent field.';
            }
            field("Mail Sent Date Time"; PurchaseHeaderAdditional."Mail Sent Date Time")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Mail Sent Date Time field.';
            }
            field("PurchaseHeaderAdditional.""Import Identifier"""; PurchaseHeaderAdditional."Import Identifier")
            {
                Caption = 'Import Identifier';
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Import Identifier field.';
            }
            //BC UPG MOVED TO INTERFACE
            // field("LSR Order No."; PurchaseHeaderAdditional."LSR Order No")
            // {
            //     Description = 'HEI.16';
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the LSR Order No field.';
            // }
            //BC UPG MOVED TO INTERFACE
            field("PurchaseHeaderAdditional.""Limit PO"""; PurchaseHeaderAdditional."Limit PO")
            {
                Caption = 'Limit PO';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Limit PO field.';
            }
            field("Shopping Card No."; Rec."Shopping Card No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shopping Card No. field.';
            }
            field("PurchaseHeaderAdditional.""Shopping Card Creation Date"""; PurchaseHeaderAdditional."Shopping Card Creation Date")
            {
                Caption = 'Shopping Card Creation Date';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shopping Card Creation Date field.';
            }
            // //BC UPG MOVED TO INTERFACE
            // field("PurchaseHeaderAdditional.""Zycus Order No."""; PurchaseHeaderAdditional."Zycus Order No.")
            // {
            //     Caption = 'Zycus Order No.';
            //     Visible = false;
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Zycus Order No. field.';
            // }
            // field("PurchaseHeaderAdditional.""PO Transaction Interface Zycus"""; PurchaseHeaderAdditional."PO Transaction Interface Zycus")
            // {
            //     Caption = 'PO Transaction Interface Zycus';
            //     Visible = false;
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the PO Transaction Interface Zycus field.';
            // }//BC UPG MOVED TO INTERFACE
            ////BC UPG MOVED TO INTERFACE
            // field("PurchaseHeaderAdditional.""Processed PO Transaction Zycus"""; PurchaseHeaderAdditional."Processed PO Transaction Zycus")
            // {
            //     Caption = 'Processed PO Transaction Zycus';
            //     Visible = false;
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Processed PO Transaction Zycus field.';
            // }
            // field("PurchaseHeaderAdditional.""Zycus GR UUID"""; PurchaseHeaderAdditional."Zycus GR UUID")
            // {
            //     Caption = 'Zycus GR UUID';
            //     Visible = false;
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Zycus GR UUID field.';
            // }
            // field("PurchaseHeaderAdditional.""Zycus GR Cancel UUID"""; PurchaseHeaderAdditional."Zycus GR Cancel UUID")
            // {
            //     Caption = 'Zycus GR Cancel UUID';
            //     Visible = false;
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Zycus GR Cancel UUID field.';
            // }
            //BC UPG MOVED TO INTERFACE
            ////BC UPG MOVED TO INTERFACE
            // field("PurchaseHeaderAdditional.""GR Transaction Interface Zycus"""; PurchaseHeaderAdditional."GR Transaction Interface Zycus")
            // {
            //     Caption = 'GR Transaction Interface Zycus';
            //     Visible = false;
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the GR Transaction Interface Zycus field.';
            // }
            // field("PurchaseHeaderAdditional.""Processed GR Transaction Zycus"""; PurchaseHeaderAdditional."Processed GR Transaction Zycus")
            // {
            //     Caption = 'Processed GR Transaction Zycus';
            //     Visible = false;
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Processed GR Transaction Zycus field.';
            // }
        }
        //moveafter("No."; Status)
    }

    actions
    {
        addafter("Co&mments")
        {
            action("Purchase Additional")
            {
                Caption = 'Purchase Additional';
                Image = Purchase;
                RunObject = Page "Purchase Additional";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                                "No." = FIELD("No.");
                ApplicationArea = All;
                ToolTip = 'Executes the Purchase Additional action.';
            }

        }
        addafter(Approvals_Promoted)
        {
            actionref(PurchaseAdditional; "Purchase Additional")

            {

            }
            actionref(prpeyamentinvoices; PostedPurchasePrepmtInvoices)
            {

            }
            actionref(PreptCrMemo; "Prepayment Credi&t Memos")
            {

            }
        }//BC Upgrade SHARMP16-- page formatting changes
        modify(Release)
        {
            trigger OnBeforeAction()
            var
            begin
                //HEI.17>>
                PurchasesPayablesSetupL.GET();
                IF PurchaseHeaderAdditional.GET(Rec."Document Type"::Order, Rec."No.") THEN BEGIN
                    IF PurchaseHeaderAdditional."Import Identifier" THEN BEGIN
                        Rec.TESTFIELD(Rec."Location Code");
                        PurchaseHeaderAdditional.TESTFIELD("Exp Physical Del Date(Imp)");
                        PurchLineRec.RESET();
                        PurchLineRec.SETRANGE("Document Type", PurchLineRec."Document Type"::Order);
                        PurchLineRec.SETRANGE("Document No.", Rec."No.");
                        PurchLineRec.SETRANGE(Type, PurchLineRec.Type::Item);
                        IF PurchLineRec.FINDSET() THEN
                            REPEAT
                                PurchLineRec.TESTFIELD("Exp Physical Del Date(Imp) FND");
                                IF (PurchLineRec."Location Code" <> PurchasesPayablesSetupL."Location Code Imp Proc. FND") THEN
                                    ERROR(Text50000, PurchLineRec."Document No.", PurchLineRec."Line No.", PurchasesPayablesSetupL."Location Code Imp Proc. FND");
                                IF (PurchLineRec."Location Code" = Rec."Location Code") THEN
                                    ERROR(Text50001, PurchLineRec."Document No.");
                            UNTIL PurchLineRec.NEXT() = 0;
                    END;
                END;
                //HEI.17<<
            end;

            trigger OnAfterAction()
            var
            begin
                //HEI.17>>
                IF Rec.Status = Rec.Status::Released THEN
                    g_CU_PurchasesUtils.ManageTOfromPO(Rec);
                //HEI.17<<
            end;
        }
        modify(Reopen)
        {
            trigger OnAfterAction()
            var
            begin
                //HEI.17>>
                IF Rec.Status = Rec.Status::Open THEN
                    g_CU_PurchasesUtils.ManageTOfromPO(Rec);
                //HEI.17<<
            end;
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
            begin
                //HEI.17>>
                PurchasesPayablesSetupL.GET();
                IF PurchaseHeaderAdditional.GET(Rec."Document Type"::Order, Rec."No.") THEN BEGIN
                    IF PurchaseHeaderAdditional."Import Identifier" THEN BEGIN
                        Rec.TESTFIELD("Location Code");
                        PurchaseHeaderAdditional.TESTFIELD("Exp Physical Del Date(Imp)");
                        PurchLineRec.RESET();
                        PurchLineRec.SETRANGE("Document Type", PurchLineRec."Document Type"::Order);
                        PurchLineRec.SETRANGE("Document No.", Rec."No.");
                        PurchLineRec.SETRANGE(Type, PurchLineRec.Type::Item);
                        IF PurchLineRec.FINDSET() THEN
                            REPEAT
                                PurchLineRec.TESTFIELD("Exp Physical Del Date(Imp) FND");
                                IF (PurchLineRec."Location Code" <> PurchasesPayablesSetupL."Location Code Imp Proc. FND") THEN
                                    ERROR(Text50000, PurchLineRec."Document No.", PurchLineRec."Line No.", PurchasesPayablesSetupL."Location Code Imp Proc. FND");
                                IF (PurchLineRec."Location Code" = Rec."Location Code") THEN
                                    ERROR(Text50001, PurchLineRec."Document No.");
                            UNTIL PurchLineRec.NEXT() = 0;
                    END;
                END;
                //HEI.17<<
            end;
        }
        // BC Upgrade SHUKLP03 << Code blocked because DrinkIT field "Warehouse Rcpt/Shpt No." is used.
        // modify("Create &Whse. Receipt")
        // {
        //     trigger OnBeforeAction()
        //     var
        //         GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
        //         WHRequest: Record "Warehouse Request";
        //         WHRcptHdr: Record "Warehouse Receipt Header";
        //     begin
        //         //HEI.24>>
        //         IF WHRequest.GET(WHRequest.Type::Inbound, Rec."Location Code", DATABASE::"Purchase Line", WHRequest."Source Subtype"::"1", Rec."No.") THEN BEGIN
        //             IF WHRequest."Warehouse Rcpt/Shpt No." <> '' THEN BEGIN
        //                 //IF WHRcptHdr.GET(WHRequest."Warehouse Rcpt/Shpt No.") THEN BEGIN //HEI.25
        //                 IF NOT WHRcptHdr.GET(WHRequest."Warehouse Rcpt/Shpt No.") THEN BEGIN //HEI.25
        //                     WHRequest."Warehouse Rcpt/Shpt No." := '';
        //                     WHRequest.MODIFY;
        //                 END;
        //             END;
        //         END;
        //         //HEI.24<<
        //     end;
        // }
        // BC Upgrade SHUKLP03 << Code blocked because DrinkIT field "Warehouse Rcpt/Shpt No." is used.

    }

    trigger OnOpenPage()
    var
    begin
        //HEI.03 SOICAD>>
        // BC Upgrade VAMSIU01 - Added Rec >>
        DocumentSubtypeCodeSetup.GET;
        DocumentSubtypeCodeSetup.TESTFIELD("Purchase - General");
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Document Subtype Code FND", '%1|%2', '', DocumentSubtypeCodeSetup."Purchase - General");
        Rec.FILTERGROUP(0);
        //HEI.03 SOICAD<<
    end;

    trigger OnAfterGetCurrRecord()
    var
    begin
        //>>HEI.02
        PrintEnabled := Rec."SRM Order No. FND" = '';
        //<<HEI.02
    end;

    trigger OnAfterGetRecord()
    var
    begin
        IF PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") THEN; //HEI.12
    end;

    var
        myInt: Integer;
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";

        PurchasesPayablesSetupL: Record "Purchases & Payables Setup";

        WHRequest: Record "Warehouse Request";
        WHRcptHdr: Record "Warehouse Receipt Header";

        DocumentSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";

        //cduICWebservice: Codeunit "IC Web Service";
        ShortcutQtyUomValue: array[3] of Decimal;
        PrintEnabled: Boolean;
        //PurchaseHeaderAdditional : Record "Purchase Header Additional FND";
        VisibleSendIC: Boolean;
        g_CU_PurchasesUtils: Codeunit "Purchases-Utils";
        PurchLineRec: Record "Purchase Line";
        Text50000: Label 'Location Code must have a value in Purhase Line- Document Type- Order,Document No- %1,Line Number- %2. %3 must be captured for Import PO';
        Text50001: TextConst ENU = 'Location Code must have a value in Purchase Header:Document Type=Order, Document No.= %1. Phisycal delivery location must be captured for Import PO.';


}
