tableextension 50186 ReturnShipmentHeaderExtFND extends "Return Shipment Header"
{
    // DITW15.00.00.01 DDR 27/12/2007 Added fields
    //                                  2034647 Drink Tax Group Code
    // DITW15.00.00.01 DDR 02/01/2008 rename field
    //                                  2034647 Vendor DTax Group Code + Filter to the source table
    // DITW15.00.00.01 DDR 04/01/2008 added field
    //                                  2013610 Customer DDeposit Group Code
    // DITW15.00.00.01 DDR 31/01/2008 Added Drink-it Reversing Calculation (Rounding) functionnalities
    //                                Added fields
    //                                  2034690 Price Incl. Reversing Calc.
    // DITW15.00.00.01 DDR 27/02/2008 Remove field (see lines)
    //                                  2034690 Price Incl. Reversing Calc.
    //                                Drink-it Return Deposit functionnalities
    //                                  added key "Applies-to Doc. Type,Applies-to Doc. No."
    //                                Added fields
    //                                  2013613 Link Purch. Document No.
    //                                Added key
    //                                  "Link Purch. Document No."
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.20 DDR 11/06/2008 Certification rules
    // DITW15.00.00.21 DDR 13/06/2008 Added flowfields
    //                                  2014430 Amount
    //                                  2014431 Amount Including VAT
    //                                  2014438 Prices Including VAT
    //                                  2013695 Item Charge Type Filter
    // DITW15.00.00.24 DDR 07/10/2008 Added fields
    //                                  2013722 Duty Tax Type
    // DITW15.00.00.25 DDR 10/10/2008 Added optionstring 'ShippingCost' for field "Item Charge Type"
    //                                Added fields
    //                                  2014075 Shipping Agent Code
    //                                  2014076 Shipping Agent Service Code
    //                                  2014077 Truck Code
    //                                  2014078 Driver Code
    //                     21/10/2008 Deleted fields
    //                                  2013722 Duty Tax Type
    // DITW15.00.00.28 DDR 24/11/2008 Added fields
    //                                  2013726 Tax Registration No.
    //                                  2013730 Fiscal Representative No.
    // DITW15.00.00.35 DDR 22/06/2009 Added functions
    //                                  GetReturnShptLines(),SumReturnShptLinesTemp(),
    //                                  SumReturnShptLines2(),IncrAmount(),Increment()
    //                     25/06/2009 Added fields
    //                                  2013824 Gen. Bus. Posting Free Group
    // DITW15.00.00.38 DDR 13/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    2014271 Tax Warehouse Reference
    //                     27/01/2011 issue 1217 (DIT711 137)
    //                                  Modified Caption field2013730 "Fiscal Representative No."
    //                                  Added fields
    //                                    2014460 Tax Office Code
    // DITW15.00.00.39 DDR 06/07/2011 issue 1353 Added fields
    //                                   2014290 Journey Time
    //                     04/08/2011 issue 1353 Modified caption field2014290 "Journey Time"
    //                     19/08/2011 issue 1363
    //                                  Added fields
    //                                    2013733 Tax Date
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields
    //                                    2014087 Distance
    //                                    2014495 Delivery Sequence
    //                     22/12/2011 DIT-715 issue 187
    //                                  Added fields
    //                                    2014277 Transport Mode (flowfield)
    //                                    2014291 Transport Mode Comment (flowfield)
    //                     05/01/2012 DIT-715 #172 Added fields "Allow VAT Calculation (Free)" to calculate VAT on free items
    //                     20/01/2012 DIT-715 #172 Modified workflow (+Rollback)
    // DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392
    //                                Added fields
    //                                  2034850 DIT Sub-Contract Type
    //                                  2034872 Contract Group Code
    //                                  2034915 Service Contract No.
    //                                  2014311 Service Contract Type
    //                 AHU 31/08/2012 DIT-715 #327 Renamed Captions fields2034915,2034310,2014311
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields
    //                                               2013630 Deposit Vendor Posting Group
    //                                               2013631 Deposit Payment Terms Code
    //                                               2013632 Deposit Payment Method Code
    //                                               2013633 Deposit Bal. Account Type
    //                                               2013634 Deposit Bal. Account No.
    //                 AHU 30/01/2013 DIT-715 #395 Added 'DrillDownFormID' property table
    // DITW16.00.00.44 DDR 19/03/2014 DIT-715 #910 Added DIT fields
    //                                               2014060 Maximum Weight
    //                                               2014061 Maximum Cubage
    //                                               2014064 Shipping Charge Per
    //                                               2014067 Total Weight
    //                                               2014068 Total Cubage
    //                                               2014426 Service Order No.
    //                                               2013825 Free Item Posting Type
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 19/12/2013 DIT-770 #163 : Remove the "DIT Sub-Contract Type" filter in "Service Contract No." field
    // DITW17.00.03 DDR 20/03/2014 DIT-715 #910 merge
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields
    //                                                          2014410 Physical Location Group Code
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1191 Multisite - Modified function SetSecurityFilterOnRespCenter()
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                           Added field "Financial Contract No."
    //                                           Rename Caption Contract No. by Service contract No.
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Added blank Option to Contract Type
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field 2014420 "Sundry Vendor"
    // DITW18.00.07 MVN 24/02/2016 DIT-770 #1397 Added Field 2014300 "Submission Type (EMCS)"
    // DITW18.00.07 MVN 17/03/2016 DIT-770 #1253 Check Permissions on Loyalty with License
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 New Field Flowfield "Document Shipping Costs"
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added new field 2014421 "Document Subtype Code"
    // DITW18.00.07 MVN 07/04/2016 DIT-770 #1397 Check Permissions on EMCS
    // DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code
    // DITW18.00.07 AKH 20/04/2016 DIT-770 #1508 Adjusted filtering code
    // DITW18.00.07 AKH 27/04/2016 DIT-770 #1346 Added field 2014080 "Vendor Delivery Type"
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time", "Created By"
    // DITW19.00.08 MSF 05/09/2016 BL#9640 (DIT-770#1819) Added field "Trailer Code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 16/02/2017 NRQ#20755 Update document subtype code table relation filter
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added Fields
    //                                "Require 2 Drivers"
    //                                "Driver 2 Code"
    //                                "Route Planning No."
    //                                 Route

    // HEI.01 PTPGAP066 IBM SOICAD01 29.06.2017 Purchase to Pay– Bank account for payment
    //   # New field Vendor Bank Account

    // HEI.02 HLSRM02 IBM LAZARE02 27.07.2017
    //   #New fields for SRM integration

    // HEI.03 PURGAP05 IBM LAZARE02 31.07.2017
    //   #Extend City fields to 35; Extend Address and Address 2 fields to 60

    // HEI.04 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New fields for MDM integration

    // HEI.05 FDD-PURGAPINT002 IBM LAZARE02 25.09.2017
    //   # New field "Maximo Requisition No."
    // HEI.06 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field created: 50031 - "Gate Entry No."
    // HEI.07 CHG2024557 FDD-HT821 IBM SHANKJ03 12.02.2020
    //   # New Field added "Maximo Status"
    // HEI.08 CHG2210794 SAHAL01 15.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Created New Fields: 50075 - Zycus Order No.
    //                         50078 - Zycus GR UUID
    //                         50079 - Zycus GR Cancel UUID
    //                         50081 - PO Transaction Interface Zycus
    //                         50082 - GR Transaction Interface Zycus
    //                         50085 - Processed PO Transaction Zycus
    //                         50086 - Processed GR Transaction Zycus
    //--------------------------------------------------------------------------------------------------------//   
    //BC Upgrade SHARMP16--- Interface related fields removed and shifed to Interface Ext

    // BC Upgrade SHUKLP03 >> Added field Document Subtype Code (50090).

    fields
    {
        modify("Buy-from Vendor No.")
        {
            CaptionML = ENU = 'Buy-from Vendor No.', FRA = 'N° fournisseur';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Pay-to Vendor No.")
        {
            CaptionML = ENU = 'Pay-to Vendor No.', FRA = 'N° fournisseur à payer';
        }
        modify("Pay-to Name")
        {
            CaptionML = ENU = 'Pay-to Name', FRA = 'Nom';
        }
        modify("Pay-to Name 2")
        {
            CaptionML = ENU = 'Pay-to Name 2', FRA = 'Nom 2';
        }
        modify("Pay-to Address")
        {

            //Unsupported feature: Change Data type on ""Pay-to Address"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Pay-to Address', FRA = 'Adresse';

            //Unsupported feature: Change Description on ""Pay-to Address"(Field 7)". Please convert manually.

        }
        modify("Pay-to Address 2")
        {

            //Unsupported feature: Change Data type on ""Pay-to Address 2"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Pay-to Address 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change Description on ""Pay-to Address 2"(Field 8)". Please convert manually.

        }
        modify("Pay-to City")
        {

            //Unsupported feature: Change Data type on ""Pay-to City"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Pay-to City', FRA = 'Ville';

            //Unsupported feature: Change Description on ""Pay-to City"(Field 9)". Please convert manually.

        }
        modify("Pay-to Contact")
        {
            CaptionML = ENU = 'Pay-to Contact', FRA = 'Contact';
        }
        modify("Your Reference")
        {
            CaptionML = ENU = 'Your Reference', FRA = 'Votre référence';
        }
        modify("Ship-to Code")
        {
            CaptionML = ENU = 'Ship-to Code', FRA = 'Code destinataire';
        }
        modify("Ship-to Name")
        {
            CaptionML = ENU = 'Ship-to Name', FRA = 'Nom du destinataire';
        }
        modify("Ship-to Name 2")
        {
            CaptionML = ENU = 'Ship-to Name 2', FRA = 'Nom du destinataire 2';
        }
        modify("Ship-to Address")
        {

            //Unsupported feature: Change Data type on ""Ship-to Address"(Field 15)". Please convert manually.

            CaptionML = ENU = 'Ship-to Address', FRA = 'Adresse destinataire';

            //Unsupported feature: Change Description on ""Ship-to Address"(Field 15)". Please convert manually.

        }
        modify("Ship-to Address 2")
        {

            //Unsupported feature: Change Data type on ""Ship-to Address 2"(Field 16)". Please convert manually.

            CaptionML = ENU = 'Ship-to Address 2', FRA = 'Adresse destinataire 2';

            //Unsupported feature: Change Description on ""Ship-to Address 2"(Field 16)". Please convert manually.

        }
        modify("Ship-to City")
        {

            //Unsupported feature: Change Data type on ""Ship-to City"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Ship-to City', FRA = 'Ville destinataire';

            //Unsupported feature: Change Description on ""Ship-to City"(Field 17)". Please convert manually.

        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Ship-to Contact', FRA = 'Contact destinataire';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Expected Receipt Date")
        {
            CaptionML = ENU = 'Expected Receipt Date', FRA = 'Date réception prévue';
        }
        modify("Posting Description")
        {
            CaptionML = ENU = 'Posting Description', FRA = 'Libellé écriture';
        }
        modify("Payment Terms Code")
        {
            CaptionML = ENU = 'Payment Terms Code', FRA = 'Code condition paiement';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Délai';
        }
        modify("Payment Discount %")
        {
            CaptionML = ENU = 'Payment Discount %', FRA = '% escompte';
        }
        modify("Pmt. Discount Date")
        {
            CaptionML = ENU = 'Pmt. Discount Date', FRA = 'Date d''escompte';
        }
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Shipment Method Code', FRA = 'Code condition livraison';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Vendor Posting Group")
        {
            CaptionML = ENU = 'Vendor Posting Group', FRA = 'Groupe compta. fournisseur';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Currency Factor")
        {
            CaptionML = ENU = 'Currency Factor', FRA = 'Facteur devise';
        }
        modify("Invoice Disc. Code")
        {
            CaptionML = ENU = 'Invoice Disc. Code', FRA = 'Code remise facture';
        }
        modify("Language Code")
        {
            CaptionML = ENU = 'Language Code', FRA = 'Code langue';
        }
        modify("Purchaser Code")
        {
            CaptionML = ENU = 'Purchaser Code', FRA = 'Code acheteur';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("No. Printed")
        {
            CaptionML = ENU = 'No. Printed', FRA = 'Nbre impressions';
        }
        modify("On Hold")
        {
            CaptionML = ENU = 'On Hold', FRA = 'En attente';
        }
        modify("Applies-to Doc. Type")
        {
            CaptionML = ENU = 'Applies-to Doc. Type', FRA = 'Type doc. lettrage';
            // OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement';
        }
        modify("Applies-to Doc. No.")
        {
            CaptionML = ENU = 'Applies-to Doc. No.', FRA = 'N° doc. lettrage';
        }
        modify("Bal. Account No.")
        {
            CaptionML = ENU = 'Bal. Account No.', FRA = 'N° compte contrepartie';
        }
        modify("VAT Registration No.")
        {
            CaptionML = ENU = 'VAT Registration No.', FRA = 'N° identif. intracomm.';
        }
        modify("Sell-to Customer No.")
        {
            CaptionML = ENU = 'Sell-to Customer No.', FRA = 'N° donneur d''ordre';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("Transaction Type")
        {
            CaptionML = ENU = 'Transaction Type', FRA = 'Nature transaction';
        }
        modify("Transport Method")
        {
            CaptionML = ENU = 'Transport Method', FRA = 'Mode de transport';
        }
        modify("VAT Country/Region Code")
        {
            CaptionML = ENU = 'VAT Country/Region Code', FRA = 'Code pays/région TVA';
        }
        modify("Buy-from Vendor Name")
        {
            CaptionML = ENU = 'Buy-from Vendor Name', FRA = 'Nom du fournisseur';
        }
        modify("Buy-from Vendor Name 2")
        {
            CaptionML = ENU = 'Buy-from Vendor Name 2', FRA = 'Nom du fournisseur 2';
        }
        modify("Buy-from Address")
        {

            //Unsupported feature: Change Data type on ""Buy-from Address"(Field 81)". Please convert manually.

            CaptionML = ENU = 'Buy-from Address', FRA = 'Adresse fournisseur';

            //Unsupported feature: Change Description on ""Buy-from Address"(Field 81)". Please convert manually.

        }
        modify("Buy-from Address 2")
        {

            //Unsupported feature: Change Data type on ""Buy-from Address 2"(Field 82)". Please convert manually.

            CaptionML = ENU = 'Buy-from Address 2', FRA = 'Adresse fournisseur 2';

            //Unsupported feature: Change Description on ""Buy-from Address 2"(Field 82)". Please convert manually.

        }
        modify("Buy-from City")
        {

            //Unsupported feature: Change Data type on ""Buy-from City"(Field 83)". Please convert manually.

            CaptionML = ENU = 'Buy-from City', FRA = 'Ville fournisseur';

            //Unsupported feature: Change Description on ""Buy-from City"(Field 83)". Please convert manually.

        }
        modify("Buy-from Contact")
        {
            CaptionML = ENU = 'Buy-from Contact', FRA = 'Contact fournisseur';
        }
        modify("Pay-to Post Code")
        {
            CaptionML = ENU = 'Pay-to Post Code', FRA = 'Code postal';
        }
        modify("Pay-to County")
        {
            CaptionML = ENU = 'Pay-to County', FRA = 'Région';
        }
        modify("Pay-to Country/Region Code")
        {
            CaptionML = ENU = 'Pay-to Country/Region Code', FRA = 'Code pays/région paiement';
        }
        modify("Buy-from Post Code")
        {
            CaptionML = ENU = 'Buy-from Post Code', FRA = 'Code postal fournisseur';
        }
        modify("Buy-from County")
        {
            CaptionML = ENU = 'Buy-from County', FRA = 'Région fournisseur';
        }
        modify("Buy-from Country/Region Code")
        {
            CaptionML = ENU = 'Buy-from Country/Region Code', FRA = 'Code pays/région fournisseur';
        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'Ship-to Post Code', FRA = 'Code postal destinataire';
        }
        modify("Ship-to County")
        {
            CaptionML = ENU = 'Ship-to County', FRA = 'Région destinataire';
        }
        modify("Ship-to Country/Region Code")
        {
            CaptionML = ENU = 'Ship-to Country/Region Code', FRA = 'Code pays/région destinataire';
        }
        modify("Bal. Account Type")
        {
            CaptionML = ENU = 'Bal. Account Type', FRA = 'Type compte contrepartie';
            // OptionCaptionML = ENU = 'G/L Account,Bank Account', FRA = 'Général,Banque';
        }
        modify("Order Address Code")
        {
            CaptionML = ENU = 'Order Address Code', FRA = 'Code adresse commande';
        }
        modify("Entry Point")
        {
            CaptionML = ENU = 'Entry Point', FRA = 'Pays provenance';
        }
        modify(Correction)
        {
            CaptionML = ENU = 'Correction', FRA = 'Correction';
        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
        }
        modify("Area")
        {
            CaptionML = ENU = 'Area', FRA = 'Dépt destination/provenance';
        }
        modify("Transaction Specification")
        {
            CaptionML = ENU = 'Transaction Specification', FRA = 'Régime';
        }
        modify("Payment Method Code")
        {
            CaptionML = ENU = 'Payment Method Code', FRA = 'Code mode de règlement';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("Tax Area Code")
        {
            CaptionML = ENU = 'Tax Area Code', FRA = 'Code zone recouvrement';
        }
        modify("Tax Liable")
        {
            CaptionML = ENU = 'Tax Liable', FRA = 'Soumis à recouvrement';
        }
        modify("VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify("VAT Base Discount %")
        {
            CaptionML = ENU = 'VAT Base Discount %', FRA = '% remise base TVA';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Campaign No.")
        {
            CaptionML = ENU = 'Campaign No.', FRA = 'N° campagne';
        }
        modify("Buy-from Contact No.")
        {
            CaptionML = ENU = 'Buy-from Contact No.', FRA = 'N° contact fournisseur';
        }
        modify("Pay-to Contact No.")
        {
            CaptionML = ENU = 'Pay-to Contact No.', FRA = 'N° contact à payer';
        }
        modify("Responsibility Center")
        {
            CaptionML = ENU = 'Responsibility Center', FRA = 'Centre de gestion';
        }
        modify("Vendor Authorization No.")
        {
            CaptionML = ENU = 'Vendor Authorization No.', FRA = 'N° autorisation fournisseur';
        }
        modify("Return Order No.")
        {
            CaptionML = ENU = 'Return Order No.', FRA = 'N° retour';
        }
        modify("Return Order No. Series")
        {
            CaptionML = ENU = 'Return Order No. Series', FRA = 'Souches de n° retour';
        }
        field(50000; "Vendor Bank Account FND"; Code[10])
        {
            Caption = 'Vendor Bank Account';
            Description = 'HEI.01';
            TableRelation = "Vendor Bank Account".Code where("Vendor No." = FIELD("Buy-from Vendor No."));
        }
        field(50001; "IBAN FND"; Code[50])
        {
            Caption = 'IBAN';
            CalcFormula = Lookup("Vendor Bank Account".IBAN where("Vendor No." = FIELD("Pay-to Vendor No."),
                                                                   Code = FIELD("Vendor Bank Account FND")));
            Description = 'HEI.02';
            Editable = false;
            FieldClass = FlowField;
        }

        //BC Upgrade SHARMP16 BEGIN>> --- field shifted to Interface Ext.
        // field(50005; "SRM Contract No."; Code[10])
        // {
        //     Caption = 'SRM Contract No.';
        //     Description = 'HEI.02';
        //     Editable = false;
        // }
        // field(50006; "SRM Contract Name"; Text[50])
        // {
        //     Caption = 'SRM Contract Name';
        //     Description = 'HEI.02';
        //     Editable = false;
        // }
        // field(50007; "SRM Contract Type"; Code[10])
        // {
        //     Caption = 'Contract Type';
        //     Description = 'HEI.02';
        //     Editable = false;
        //     TableRelation = "SRM Contract Type";
        // }
        //BC Upgrade SHARMP16 end<< --- field shifted to Interface Ext.
        field(50008; "Valid From FND"; Date)
        {
            Caption = 'Valid From';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50009; "Valid To FND"; Date)
        {
            Caption = 'Valid To';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50010; "Channel FND"; Code[1])
        {
            Caption = 'Channel';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = "Channel FND";
        }
        field(50011; "Shipment Method Location FND"; Text[30])
        {
            Caption = 'Shipment Method Location';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50012; "Contract Closed FND"; Boolean)
        {
            Caption = 'Contract Closed';
            Description = 'HEI.02';
            Editable = false;
        }
        //BC Upgrade SHARMP16 BEGIN>>--- field shifted to Interface Ext.

        // field(50013; "SRM Order No."; Code[10])
        // {
        //     Caption = 'SRM Order No.';
        //     Description = 'HEI.02';
        //     Editable = false;
        // }
        // field(50014; "SRM Version No."; Code[10])
        // {
        //     Caption = 'SRM Version No.';
        //     Description = 'HEI.02';
        //     Editable = false;
        // }
        //BC Upgrade SHARMP16 end<<--- field shifted to Interface Ext.
        field(50020; "Target Value Currency FND"; Code[10])
        {
            Caption = 'Target Value Currency';
            Description = 'HEI.02';
            TableRelation = Currency;
        }
        field(50021; "Target Value Amount FND"; Decimal)
        {
            Caption = 'Target Value Amount';
            Description = 'HEI.02';
        }
        field(50022; "Blanket Order No. FND"; Code[20])
        {
            Caption = 'Blanket Order No.';
            Description = 'HEI.02';
            TableRelation = "Purchase Header"."No." where("Document Type" = CONST("Blanket Order"));
        }
        field(50023; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            Description = 'HEI.04';
            TableRelation = "WHT Business Posting Group FND".Code;
        }
        field(50024; "Actual Vendor No. FND"; Code[20])
        {
            Caption = 'Actual Vendor No.';
            Description = 'HEI.04';
        }
        // field(50030; "Maximo Requisition No."; Code[20])
        // {
        //     Caption = 'Maximo Requisition No.';
        //     Description = 'HEI.05';
        //     Editable = false;
        // }//BC Upgrade SHARMP16---- shifted to Interface Ext.
        field(50031; "Gate Entry No. FND"; Code[20])
        {
            Caption = 'Gate Entry No.';
            Description = 'HEI.06';
            Editable = false;
            TableRelation = "Gate Entry Header FND";
        }
        // field(50043; "Maximo Status"; Option)
        // {
        //     Caption = 'Maximo Status';
        //     Description = 'HEI.07';
        //     Editable = false;
        //     OptionMembers = " ",Approved,Canceled,Closed,"Waiting on Approval";
        // }//BC Upgrade SHARMP16---- shifted to Interface Ext.
        //BC Upgrade SHARMP16 BEGIN>> --- field shifted to Interface Ext.
        // field(50075; "Zycus Order No."; Code[20])
        // {
        //     Caption = 'Zycus Order No.';
        //     Description = 'HEI.08';
        //     Editable = false;
        // }
        // field(50078; "Zycus GR UUID"; Text[50])
        // {
        //     Caption = 'Zycus GR UUID';
        //     Description = 'HEI.08';
        //     Editable = false;
        // }
        // field(50079; "Zycus GR Cancel UUID"; Text[50])
        // {
        //     Caption = 'Zycus GR Cancel UUID';
        //     Description = 'HEI.08';
        //     Editable = false;
        // }
        // field(50081; "PO Transaction Interface Zycus"; Code[20])
        // {
        //     Caption = 'PO Transaction Interface Zycus';
        //     Description = 'HEI.08';
        //     Editable = false;
        //     TableRelation = "Interface Setup";
        // }
        // field(50082; "GR Transaction Interface Zycus"; Code[20])
        // {
        //     Caption = 'GR Transaction Interface Zycus';
        //     Description = 'HEI.08';
        //     Editable = false;
        //     TableRelation = "Interface Setup";
        // }
        // field(50085; "Processed PO Transaction Zycus"; Boolean)
        // {
        //     Caption = 'Processed PO Transaction Zycus';
        //     Description = 'HEI.08';
        //     Editable = false;
        // }
        // field(50086; "Processed GR Transaction Zycus"; Boolean)
        // {
        //     Caption = 'Processed GR Transaction Zycus';
        //     Description = 'HEI.08';
        //     Editable = false;
        // }
        //BC Upgrade SHARMP16 end<< --- field shifted to Interface Ext.

        //BC UpgradeSHARMP16 Begin>>-- Drink-IT fields
        // field(2013610; "Vendor DDeposit Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Customer Depoist Group Code',
        //                 FRA = 'Code groupe consigne client';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code where("Source Type" = CONST(Vendor));
        // }
        // field(2013613; "Link Purch. Document No."; Code[20])
        // {
        //     CaptionML = ENU = 'Link Purch. Document No.',
        //                 FRA = 'Lien N° document achat';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013630; "Deposit Vendor Posting Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Deposit - Vendor Posting Group',
        //                 FRA = 'Consigne - Groupe compta. fournisseur';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = "Vendor Posting Group";
        // }
        // field(2013631; "Deposit Payment Terms Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Deposit - Payment Terms Code',
        //                 FRA = 'Consigne - Code conditions paiement';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = "Payment Terms";
        // }
        // field(2013632; "Deposit Payment Method Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Deposit - Payment Method Code',
        //                 FRA = 'Consigne - Code mode de règlement';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = "Payment Method";
        // }
        // field(2013633; "Deposit Bal. Account Type"; Option)
        // {
        //     CaptionML = ENU = 'Deposit - Bal. Account Type',
        //                 FRA = 'Consigne - Type Compte Contrepartie';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     OptionCaptionML = ENU = 'G/L Account,Bank Account',
        //                       FRA = 'Général,Banque';
        //     OptionMembers = "G/L Account","Bank Account";
        // }
        // field(2013634; "Deposit Bal. Account No."; Code[20])
        // {
        //     CaptionML = ENU = 'Deposit - Bal. Account No.',
        //                 FRA = 'Consigne - N° compte contrepartie';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = IF ("Deposit Bal. Account Type" = CONST("G/L Account")) "G/L Account"
        //     else IF ("Deposit Bal. Account Type" = CONST("Bank Account")) "Bank Account";
        // }
        // field(2013667; "Vendor DTax Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Vendor Tax Group Code',
        //                 FRA = 'Code groupe taxe fournisseur';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Vendor));
        // }
        // field(2013695; "Item Charge Type Filter"; Option)
        // {
        //     CaptionML = ENU = 'Item Charge Type Filter',
        //                 FRA = 'Filtre type frais article';
        //     Description = 'DITW15.00.00.01';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        // }
        // field(2013726; "Vendor Tax Registration No."; Text[20])
        // {
        //     CaptionML = ENU = 'Vendor Tax Registration No.',
        //                 FRA = 'N° ident. accise fournisseur';
        //     Description = 'DITW15.00.00.28';
        // }
        // field(2013730; "Fiscal Representative No."; Code[20])
        // {
        //     CaptionML = ENU = 'Fiscal Representative / Customs Agent No.',
        //                 FRA = 'N° représentant fiscal / Agent des douanes';
        //     Description = 'DITW15.00.00.28-.38 #1217';
        //     TableRelation = "Fiscal Representative";
        // }
        // field(2013733; "Tax Date"; Date)
        // {
        //     CaptionML = ENU = 'Tax Date',
        //                 FRA = 'Date taxe';
        //     Description = 'DITW15.00.00.39 #1363';
        // }
        // field(2013823; "Gen. Bus. Posting Free Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Gen. Bus. Posting Group Free item',
        //                 FRA = 'Groupe article gratuit compta. marché';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Gen. Business Posting Group";
        // }
        // field(2013825; "Free Item Posting Type"; Option)
        // {
        //     CaptionML = ENU = 'Calculate Price on Free',
        //                 FRA = 'Calculer Prix sur gratuit';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     OptionCaptionML = ENU = ' ,Price 0,Discount 100%',
        //                       FRA = ' ,Prix 0,Remise 100%';
        //     OptionMembers = " ",Price,Amount;
        // }
        // field(2014060; "Maximum Weight"; Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Maximum Weight',
        //                 FRA = 'Poids maximum';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     MinValue = 0;
        // }
        // field(2014061; "Maximum Cubage"; Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Maximum Volume (Cubage)',
        //                 FRA = 'Volume (Cubage) maximum';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     MinValue = 0;
        // }
        // field(2014064; "Shipping Charge Per"; Option)
        // {
        //     CaptionML = ENU = 'Shipping Charge Per',
        //                 FRA = 'Frais transport par';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     OptionCaptionML = ENU = 'Shipment,Weight,Volume',
        //                       FRA = 'Expédition,Poids,Volume';
        //     OptionMembers = Shipment,Weight,Volume;
        // }
        // field(2014067; "Total Weight"; Decimal)
        // {
        //     CalcFormula = Sum("Purch. Rcpt. Line".Weight where("Document No." = FIELD("No.")));
        //     CaptionML = ENU = 'Total Weight',
        //                 FRA = 'Poids total';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014068; "Total Cubage"; Decimal)
        // {
        //     CalcFormula = Sum("Purch. Rcpt. Line".Cubage where("Document No." = FIELD("No.")));
        //     CaptionML = ENU = 'Total Volume (Cubage)',
        //                 FRA = 'Volume (Cubage) total';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014071; "Document Shipping Costs"; Boolean)
        // {
        //     CalcFormula = Exist("Posted Document Shipping Cost" where("Source Type" = CONST(6650),
        //                                                                "Source No." = FIELD("No.")));
        //     CaptionML = ENU = 'Document Shipping Costs',
        //                 FRA = 'Document Frais livraison';
        //     Description = 'DIT-770 #1066';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014075; "Shipping Agent Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Shipping Agent Code',
        //                 FRA = 'Code transporteur';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Shipping Agent";
        // }
        // field(2014076; "Shipping Agent Service Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Shipping Agent Service Code',
        //                 FRA = 'Code prestation transporteur';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = FIELD("Shipping Agent Code"));

        //     trigger OnValidate();
        //     var
        //         lrShippingAgentService: Record "Shipping Agent Services";
        //     begin
        //     end;
        // }
        // field(2014077; "Truck Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Truck Code',
        //                 FRA = 'Code camion';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Whse. Shipping Truck";
        // }
        // field(2014078; "Driver Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Driver Code',
        //                 FRA = 'Code chauffeur';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Whse. Shipping Driver";
        // }
        // field(2014080; "Vendor Delivery Type"; Code[10])
        // {
        //     CaptionML = ENU = 'Vendor Delivery Type',
        //                 FRA = 'Type Livraison Fournisseur';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     TableRelation = "Delivery Type".Code where(Type = CONST(Vendor));
        // }
        // field(2014087; Distance; Decimal)
        // {
        //     CaptionML = ENU = 'Distance',
        //                 FRA = 'Distance';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.40 #1002';
        //     MinValue = 0;
        // }
        // field(2014098; "Require 2 Drivers"; Boolean)
        // {
        //     Caption = 'Require 2 Drivers';
        //     Description = 'NRQ16082';
        // }
        // field(2014099; "Driver 2 Code"; Code[10])
        // {
        //     Caption = 'Driver 2 Code';
        //     Description = 'NRQ16082';
        // }
        // field(2014100; "Trailer Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Trailer Code',
        //                 FRA = 'Code Remorque';
        //     Description = ' BL#9640';
        //     TableRelation = "Whse. Shipping Truck".Code where("Transport Unit Type" = CONST(Trailer));
        // }
        // field(2014107; Route; Code[20])
        // {
        //     Caption = 'Route';
        //     Description = 'NRQ#16082';
        // }
        // field(2014109; "Route Planning No."; Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'NRQ#16082';
        //     TableRelation = "Route Planning Worksheet";
        // }
        // field(2014271; "Vendor Tax Warehouse Ref."; Text[20])
        // {
        //     CaptionML = ENU = 'Vendor Tax Warehouse Reference',
        //                 FRA = 'Entrepôt fiscal de référence fournisseur';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014277; "Transport Mode"; Option)
        // {
        //     CalcFormula = Lookup("Transport Method"."Transport Mode" where(Code = FIELD("Transport Method")));
        //     CaptionML = ENU = 'Transport Mode (EMCS)',
        //                 FRA = 'Mode de transport (EMCS)';
        //     Description = 'DITW16.00.00.40 DIT715 #187';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     OptionCaptionML = ENU = 'Other,Sea,Rail,Road,Air,Post,N/A,Fixed,Waterway',
        //                       FRA = 'Autre,Mer,Chemin de fer,Route,Air,Poste,N/C,Installation de transport fixes,Transport par voies navigables';
        //     OptionMembers = Other,Sea,Rail,Road,Air,Post,"N/A","Fixed",Waterway;
        // }
        // field(2014290; "Journey Time"; DateFormula)
        // {
        //     CaptionML = ENU = 'Journey Time (EMCS)',
        //                 FRA = 'Temps de trajet (EMCS)';
        //     Description = 'DITW15.00.00.39 #1353';
        // }
        // field(2014291; "Transport Mode Comment"; Boolean)
        // {
        //     CalcFormula = Exist("EMCS Comment Line" where("Table ID" = CONST(6650),
        //                                                    "Document Type" = CONST(5),
        //                                                    "Document No." = FIELD("No."),
        //                                                    "Document Line No." = CONST(0),
        //                                                    "Field ID" = CONST(2014277)));
        //     CaptionML = ENU = 'Transport Mode Comment',
        //                 FRA = 'Commentaires Mode de transport';
        //     Description = 'DITW16.00.00.40 DIT715 #187';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014300; "Submission Type"; Option)
        // {
        //     CaptionML = ENU = 'Submission Type (EMCS)',
        //                 FRA = 'Type de demande (EMCS)';
        //     Description = 'DITW18.00.07 DIT-770 #1397';
        //     OptionCaptionML = ENU = ' ,Type 1,Type 2',
        //                       FRA = ' ,Type 1,Type 2';
        //     OptionMembers = " ","Type 1","Type 2";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW18.00.07 MVN 07/04/2016 DIT-770 #1397
        //         if ApplMgt.IsObjectLicense(5, CODEUNIT::"EMCS EDI Mgt", 4) <> 0 then
        //             // >>DITW18.00.07 MVN DIT-770 #1397
        //             // <<DITW18.00.07 MVN 24/02/2016 DIT-770 #1397
        //             "Submission Type" := EMCSEDIMgt.CheckSubmissionType(1, "Vendor DTax Group Code", "Location Code", "Submission Type");
        //         // >>DITW18.00.07 MVN DIT-770 #1397
        //     end;
        // }
        // field(2014313; "Financial Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Financial Contract No.',
        //                 FRA = 'N° Contrat Financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Financial Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                       "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2014410; "Physical Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Physical Location Group Code',
        //                 FRA = 'Code groupe magasin réel';
        //     Description = 'DITW18.00.06 DIT-770 #1191';
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014411; "Creation Date/Time"; DateTime)
        // {
        //     CaptionML = ENU = 'Creation Date/Time',
        //                 FRA = 'Date/Heure Création';
        //     Description = 'DITW18.00.07 DIT-770 #1282';
        //     Editable = false;
        // }
        // field(2014412; "Created By"; Code[50])
        // {
        //     CaptionML = ENU = 'Created By',
        //                 FRA = 'Créé par';
        //     Description = 'DITW18.00.07 DIT-770 #1282';
        //     Editable = false;
        //     TableRelation = "User Setup";
        // }
        // field(2014420; "Sundry Vendor"; Boolean)
        // {
        //     CaptionML = ENU = 'Sundry Vendor',
        //                 FRA = 'Fournisseur Divers';
        //     Description = 'DITW18.00.07 DIT-770 #1804';
        // }
        field(50090; "Document Subtype Code FND"; Code[10])
        {
            CaptionML = ENU = 'Document Subtype Code',
                        FRA = 'Code Sous-Type Document';
            Description = 'DITW18.00.07 DIT-770 #1508';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = CONST(Sales));
        }
        // field(2014426; "Service Order No."; Code[20])
        // {
        //     CaptionML = ENU = 'Service Order No.',
        //                 FRA = 'N° commande de service';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     Editable = false;
        //     TableRelation = "Service Header"."No." where("Document Type" = CONST(Order));
        // }
        // field(2014430; Amount; Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Return Shipment Line".Amount where("Document No." = FIELD("No."),
        //                                                            "Item Charge Type" = FIELD("Item Charge Type Filter")));
        //     CaptionML = ENU = 'Amount',
        //                 FRA = 'Montant';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014431; "Amount Including VAT"; Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Return Shipment Line"."Amount Including VAT" where("Document No." = FIELD("No."),
        //                                                                            "Item Charge Type" = FIELD("Item Charge Type Filter")));
        //     CaptionML = ENU = 'Amount Including VAT',
        //                 FRA = 'Montant TTC';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014438; "Prices Including VAT"; Boolean)
        // {
        //     CaptionML = ENU = 'Prices Including VAT',
        //                 FRA = 'Prix TTC';
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014460; "Tax Office Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Tax Office Code',
        //                 FRA = 'Code Bureau de taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Office";
        // }
        // field(2014495; "Delivery Sequence"; Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Delivery Sequence',
        //                 FRA = 'Séquence de livraison';
        //     Description = 'DITW16.00.00.40 #1002';
        //     MinValue = 0;
        // }
        // field(2034850; "DIT Sub-Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Sub Contract Type',
        //                 FRA = 'Sous type contrat';
        //     Description = 'DIT-715 #392';
        //     OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA = ' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        // }
        // field(2034872; "Contract Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Contract Group Code',
        //                 FRA = 'Code groupe contrat';
        //     Description = 'DIT-715 #392';
        //     TableRelation = IF ("Contract Type" = CONST(Service)) "Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
        //     else IF ("Contract Type" = CONST(Financial)) "Financial Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034915; "Service Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Service Contract No.',
        //                 FRA = 'N° contrat de service';
        //     Description = 'DIT-715 #392 -DITW18.00.06 MSF 31/07/2015 DIT-770 #1368';
        //     TableRelation = "Service Purch. Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                            "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2035393; "Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Contract Type',
        //                 FRA = 'Type contrat';
        //     Description = 'DIT-715 #392 - DITW18.00.06 DIT-770 #1368';
        //     OptionCaptionML = ENU = ' ,Service,Financial',
        //                       FRA = ' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }
        //BC UpgradeSHARMP16 End<<-- Drink-IT fields
    }
    keys
    {
        // key(Key1; "Link Purch. Document No.")
        // {
        // }//BC UpgradeSHARMP16 Begin>>-- Drink-IT field used in keys
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: EmcsCommentLine)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LOCKTABLE;
    PostPurchDelete.DeletePurchShptLines(Rec);

    PurchCommentLine.SETRANGE("Document Type",PurchCommentLine."Document Type"::"Posted Return Shipment");
    PurchCommentLine.SETRANGE("No.","No.");
    PurchCommentLine.DELETEALL;

    ApprovalsMgmt.DeletePostedApprovalEntries(RECORDID);

    if CertificateOfSupply.GET(CertificateOfSupply."Document Type"::"Return Shipment","No.") then
      CertificateOfSupply.DELETE(true);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
    EmcsCommentLine.SETRANGE("Table ID",DATABASE::"Return Shipment Header");
    EmcsCommentLine.SETRANGE("Document Type",0);
    EmcsCommentLine.SETRANGE("Document No.","No.");
    EmcsCommentLine.DELETEALL;
    // >>DITW16.00.00.40 DDR DIT-715 #187

    #8..11
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
    //   EmcsCommentLine: Record "EMCS Comment Line";


    //Unsupported feature: PropertyModification on "Text001(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Posted Document Dimensions;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Posted Document Dimensions;FRA=Axes analytiques document enregistré;
    //Variable type has not been exported.

    var
        Currency: Record Currency;
        TotalReturnShptLine: Record "Return Shipment Line";
        TotalReturnShptLineLCY: Record "Return Shipment Line";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
    // EMCSEDIMgt: Codeunit "EMCS EDI Mgt";
    // ApplMgt: Codeunit ApplicationManagement;
}

