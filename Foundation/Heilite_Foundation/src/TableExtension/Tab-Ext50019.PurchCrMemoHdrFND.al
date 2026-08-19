tableextension 50019 PurchCrMemoHdrExtFND extends "Purch. Cr. Memo Hdr."
{
    // HEI.01 PTPGAP066 IBM SOICAD01 29.06.2017 Purchase to Pay– Bank account for payment
    //   # New field Vendor Bank Account
    // HEI.02 HLSRM02-05 IBM LAZARE02 27.07.2017
    //   #New fields for SRM integration
    // HEI.03 PURGAP05 IBM LAZARE02 31.07.2017
    //   #Extend City fields to 35; Extend Address and Address 2 fields to 60
    // HEI.04 PTPGAP009  IBM.CHAUHB01  18/08/2017
    //   # Added new field
    //     RUID
    // HEI.05 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //   # New fields for MDM integration
    // HEI.06 FDD-PURGAPINT002 IBM LAZARE02 25.09.2017
    //   # New field "Maximo Requisition No."
    // HEI.07 FDDPTPGAP080 IBM HORTOC01 19.03.2018
    //   #new fields
    // HEI.08 PTPGAP085 - IBM HORTOC01 20.03.2018
    //   # new fields
    // HEI.09 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field created: 50041 - Fixed Asset Acquisition
    // HEI.10 CHG2024557 FDD-HT821 IBM SHANKJ03 12.02.2020
    //   # New Field added Maximo Status
    // HEI.11 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Field created: 50050 - "CAD Amount"
    // BC Upgrade SHUKLP03 >> Added in interface ext. because of dependency on table "Purch. Cr. Memo Hdr. Addition".
    // field "Maximo Status"
    // BC Upgrade SHUKLP03 << Added in interface ext. because of dependency on table "Purch. Cr. Memo Hdr. Addition".
    //BC UPGRADE ATHUKUS01 FDD_STP007_GAP 14-16 >> Added Created By and Creation Date/Time fields for Copy of Purchase Document to track the source of creation for the copied document.

    // HEI.10 CHG2024557 FDD-HT821 IBM SHANKJ03 12.02.2020
    //   # New Field added Maximo Status

    // BC UPGRADE PATELP08 >>
    // Changed table name from "PurchCrMemoHdrInterfaceExt" to "PurchCrMemoHdrInterfaceExtFND"
    // BC UPGRADE PATELP08 <<


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

            //Unsupported feature: Change TableRelation on ""Ship-to Code"(Field 12)". Please convert manually.

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
            CaptionML = ENU = 'Due Date', FRA = 'Date d''échéance';
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

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 28)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Shortcut Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 1 Code"(Field 29)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 2 Code"(Field 30)". Please convert manually.

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
        modify("Prices Including VAT")
        {
            CaptionML = ENU = 'Prices Including VAT', FRA = 'Prix TTC';
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

            //Unsupported feature: Change TableRelation on ""Purchaser Code"(Field 43)". Please convert manually.

            CaptionML = ENU = 'Purchaser Code', FRA = 'Code acheteur';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 46)". Please convert manually.

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
            //OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement';
        }
        modify("Applies-to Doc. No.")
        {
            CaptionML = ENU = 'Applies-to Doc. No.', FRA = 'N° doc. lettrage';
        }
        modify("Bal. Account No.")
        {

            //Unsupported feature: Change TableRelation on ""Bal. Account No."(Field 55)". Please convert manually.

            CaptionML = ENU = 'Bal. Account No.', FRA = 'N° compte contrepartie';
        }
        modify(Amount)
        {

            //Unsupported feature: Change CalcFormula on "Amount(Field 60)". Please convert manually.

            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Amount Including VAT")
        {

            //Unsupported feature: Change CalcFormula on ""Amount Including VAT"(Field 61)". Please convert manually.

            CaptionML = ENU = 'Amount Including VAT', FRA = 'Montant TTC';
        }
        modify("Vendor Cr. Memo No.")
        {
            CaptionML = ENU = 'Vendor Cr. Memo No.', FRA = 'N° avoir fournisseur';
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

            //Unsupported feature: Change TableRelation on ""VAT Country/Region Code"(Field 78)". Please convert manually.

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

            //Unsupported feature: Change TableRelation on ""Pay-to Country/Region Code"(Field 87)". Please convert manually.

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

            //Unsupported feature: Change TableRelation on ""Buy-from Country/Region Code"(Field 90)". Please convert manually.

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

            //Unsupported feature: Change TableRelation on ""Ship-to Country/Region Code"(Field 93)". Please convert manually.

            CaptionML = ENU = 'Ship-to Country/Region Code', FRA = 'Code pays/région destinataire';
        }
        modify("Bal. Account Type")
        {
            CaptionML = ENU = 'Bal. Account Type', FRA = 'Type compte contrepartie';
            //OptionCaptionML = ENU = 'G/L Account,Bank Account', FRA = 'Général,Banque';
        }
        modify("Order Address Code")
        {

            //Unsupported feature: Change TableRelation on ""Order Address Code"(Field 95)". Please convert manually.

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
        modify("Pre-Assigned No. Series")
        {
            CaptionML = ENU = 'Pre-Assigned No. Series', FRA = 'Souche de n° pré-attribués';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Pre-Assigned No.")
        {
            CaptionML = ENU = 'Pre-Assigned No.', FRA = 'N° pré-attribués';
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
        modify("Prepmt. Cr. Memo No. Series")
        {
            CaptionML = ENU = 'Prepmt. Cr. Memo No. Series', FRA = 'N° de série avoir acompte';
        }
        modify("Prepayment Credit Memo")
        {
            CaptionML = ENU = 'Prepayment Credit Memo', FRA = 'Avoir acompte';
        }
        modify("Prepayment Order No.")
        {
            CaptionML = ENU = 'Prepayment Order No.', FRA = 'N° ordre acompte';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify(Paid)
        {

            //Unsupported feature: Change CalcFormula on "Paid(Field 1302)". Please convert manually.

            CaptionML = ENU = 'Paid', FRA = 'Payé';
        }
        modify("Remaining Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Remaining Amount"(Field 1303)". Please convert manually.

            CaptionML = ENU = 'Remaining Amount', FRA = 'Montant ouvert';
        }
        modify("Vendor Ledger Entry No.")
        {
            CaptionML = ENU = 'Vendor Ledger Entry No.', FRA = 'N° écriture comptable fourn.';
        }
        modify("Invoice Discount Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Invoice Discount Amount"(Field 1305)". Please convert manually.

            CaptionML = ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
        }
        modify(Cancelled)
        {

            //Unsupported feature: Change CalcFormula on "Cancelled(Field 1310)". Please convert manually.

            CaptionML = ENU = 'Cancelled', FRA = 'Annulé';
        }
        modify(Corrective)
        {

            //Unsupported feature: Change CalcFormula on "Corrective(Field 1311)". Please convert manually.

            CaptionML = ENU = 'Corrective', FRA = 'Correctif';
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
            Description = 'HEI.01';
            Caption = 'Vendor Bank Account';
            TableRelation = "Vendor Bank Account".Code where("Vendor No." = FIELD("Buy-from Vendor No."));
        }
        field(50001; "IBAN FND"; Code[50])
        {
            CalcFormula = Lookup("Vendor Bank Account".IBAN where("Vendor No." = FIELD("Pay-to Vendor No."),
                                                                   Code = FIELD("Vendor Bank Account FND")));
            Description = 'HEI.02';
            Caption = 'IBAN';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Payment User FND"; Code[50])
        {
            Description = 'HEI.07';
            Caption = 'Payment User';
            Editable = false;
            TableRelation = User."User Name";

            trigger OnLookup();
            var
                UserMgt: Codeunit "User Management";
            begin
            end;
        }
        field(50003; "Payment Status FND"; Option)
        {
            Description = 'HEI.07';
            Caption = 'Payment Status';
            OptionCaption = 'Pending Review,Payment Approved,Payment Rejected';
            OptionMembers = "Pending Review","Payment Approved","Payment Rejected";

            trigger OnValidate();
            var
                HeinekenGlobal: Codeunit "Heineken Global";
            begin
            end;
        }
        field(50004; "Status Date FND"; Date)
        {
            Description = 'HEI.07';
            Caption = 'Status Date';
            Editable = false;
        }
        field(50005; "SRM Contract No. FND"; Code[10])
        {
            Caption = 'SRM Contract No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50006; "SRM Contract Name FND"; Text[50])
        {
            Caption = 'SRM Contract Name';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50007; "SRM Contract Type FND"; Code[10])
        {
            Caption = 'Contract Type';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = "SRM Contract Type FND";
        }
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
        field(50013; "SRM Order No. FND"; Code[10])
        {
            Caption = 'SRM Order No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50014; "SRM Version No. FND"; Code[10])
        {
            Caption = 'SRM Version No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50015; "RUID FND"; Text[100])
        {
            CaptionML = ENU = 'RUID',
                        FRA = 'RUID';
            Description = 'ESKER1.0,HEI.04';
        }
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
            Description = 'HEI.05';
            TableRelation = "WHT Business Posting Group FND".Code;
        }
        field(50024; "Actual Vendor No. FND"; Code[20])
        {
            Caption = 'Actual Vendor No.';
            Description = 'HEI.05';
        }
        field(50025; "Rem. WHT Prepaid Amt (LCY) FND"; Decimal)
        {
            CalcFormula = Sum("WHT Entry FND"."Remaining Unrealized Amount" where("Document Type" = CONST("Credit Memo"),
                                                                               "Document No." = FIELD("No.")));
            Caption = 'Rem. WHT Prepaid Amount (LCY)';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(50026; "Paid WHT Prepaid Amt (LCY) FND"; Decimal)
        {
            CalcFormula = Sum("WHT Entry FND".Amount where("Document Type" = CONST(Refund),
                                                        "Document No." = FIELD("No.")));
            Caption = 'Paid WHT Prepaid Amount (LCY)';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(50027; "Total WHT Prepaid Amt LCY FND"; Decimal)
        {
            CalcFormula = Sum("WHT Entry FND"."Unrealized Amount" where("Document Type" = CONST("Credit Memo"),
                                                                     "Document No." = FIELD("No.")));
            Caption = 'Total WHT Prepaid Amount (LCY)';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(50030; "Maximo Requisition No. FND"; Code[20])
        {
            Caption = 'Maximo Requisition No.';
            Description = 'HEI.06';
            Editable = false;
        }
        field(50033; "On Hold UserID FND"; Code[50])
        {
            CalcFormula = Lookup("Purchase Additional Fields FND"."On Hold UserID" where(TableID = CONST(124),
                                                                                      "Document Type" = FILTER("Posted Cr. Memo"),
                                                                                      "Document No." = FIELD("No.")));
            Caption = 'On Hold UserID';
            Description = 'HEI.08';
            FieldClass = FlowField;
        }
        field(50034; "On Hold Date FND"; Date)
        {
            CalcFormula = Lookup("Purchase Additional Fields FND"."On Hold Date" where(TableID = CONST(124),
                                                                                    "Document Type" = FILTER("Posted Cr. Memo"),
                                                                                    "Document No." = FIELD("No.")));
            Caption = 'On Hold Date';
            Description = 'HEI.08';
            FieldClass = FlowField;
        }
        field(50041; "Fixed Asset Acquisition FND"; Boolean)
        {
            Caption = 'Fixed Asset Acquisition';
            Description = 'HEI.09';
            Editable = false;
        }
        // BC Upgrade SHUKLP03 >>
        field(50043; "Maximo Status FND"; Option)
        {
            CalcFormula = Lookup("Purch. Cr. Memo Hdr. Add FND"."Maximo Status FND" WHERE("No." = FIELD("No.")));
            Caption = 'Maximo Status';
            Description = 'HEI.11';
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = " ",Approved,Canceled,Closed,"Waiting on Approval";
        }
        // BC Upgrade SHUKLP03 <<

        // BC Upgrade SHUKLP03 >> Added in the interface ext.
        // field(50043; "Maximo Status"; Option)
        // {
        //     CalcFormula = Lookup("Purch. Cr. Memo Hdr. Addition"."Maximo Status" WHERE("No." = FIELD("No.")));
        //     Caption = 'Maximo Status';
        //     Description = 'HEI.11';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     OptionMembers = " ",Approved,Canceled,Closed,"Waiting on Approval";
        // }
        // BC Upgrade SHUKLP03 << Added in the interface ext.
        field(50050; "CAD Amount FND"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            // CalcFormula = Sum("Purch. Cr. Memo Line"."CAD Amount" where("Document No." = FIELD("No."),
            //                                                              "Item Charge Type" = FIELD("Item Charge Type Filter")));//BC UPGRADE SHARMP16 drink-it field used.
            CalcFormula = Sum("Purch. Cr. Memo Line"."CAD Amount FND" where("Document No." = FIELD("No.")));//,
                                                                                                            //  "Item Charge Type" = FIELD("Item Charge Type Filter")));//BC UPGRADE SHARMP16 drink-it field used.
            CaptionML = ENU = 'CAD Amount',
                        FRA = 'CAD Montant';
            Description = 'HEI.11';
            Editable = false;
            FieldClass = FlowField;
        }

        //BC UPGRADE VAMSIU01 - Document Subtype code field added >>
        field(50090; "Document Subtype Code FND"; Code[10])
        {
            CaptionML = ENU = 'Document Subtype Code',
                        FRA = 'Code Sous-Type Document';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = CONST(Purchase));
        }
        //BC UPGRADE VAMSIU01 - Document Subtype code field added <<

        //BC UPGRADE SHARMP16 drink-it fields<<

        //BC UPGRADE ATHUKUS01 FDD_STP007_GAP 14-16>>
        field(50096; "Created By IBM FND"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = "User Setup";
            Editable = false;
            ValidateTableRelation = true;
        }
        field(50098; "Creation Date/Time IBM FND"; DateTime)
        {
            Caption = 'Creation Date/Time';
            Editable = false;
        }
        //BC UPGRADE ATHUKUS01 FDD_STP007_GAP 14-16<<



        // field(2013610;"Vendor DDeposit Group Code";Code[10])
        // {
        //     CaptionML = ENU='Customer Deposit Group Code',
        //                 FRA='Code groupe consigne client';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code WHERE ("Source Type"=CONST(Vendor));
        // }
        // field(2013613;"Link Purch. Document No.";Code[20])
        // {
        //     CaptionML = ENU='Link Purch. Document No.',
        //                 FRA='Lien N° document achat';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013630;"Deposit Vendor Posting Group";Code[10])
        // {
        //     CaptionML = ENU='Deposit - Vendor Posting Group',
        //                 FRA='Consigne - Groupe compta. fournisseur';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = "Vendor Posting Group";
        // }
        // field(2013631;"Deposit Payment Terms Code";Code[10])
        // {
        //     CaptionML = ENU='Deposit - Payment Terms Code',
        //                 FRA='Consigne - Code conditions paiement';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = "Payment Terms";
        // }
        // field(2013632;"Deposit Payment Method Code";Code[10])
        // {
        //     CaptionML = ENU='Deposit - Payment Method Code',
        //                 FRA='Consigne - Code mode de règlement';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = "Payment Method";
        // }
        // field(2013633;"Deposit Bal. Account Type";Option)
        // {
        //     CaptionML = ENU='Deposit - Bal. Account Type',
        //                 FRA='Consigne - Type Compte Contrepartie';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     OptionCaptionML = ENU='G/L Account,Bank Account',
        //                       FRA='Général,Banque';
        //     OptionMembers = "G/L Account","Bank Account";
        // }
        // field(2013634;"Deposit Bal. Account No.";Code[20])
        // {
        //     CaptionML = ENU='Deposit - Bal. Account No.',
        //                 FRA='Consigne - N° compte contrepartie';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = IF ("Deposit Bal. Account Type"=CONST("G/L Account")) "G/L Account"
        //                     else IF ("Deposit Bal. Account Type"=CONST("Bank Account")) "Bank Account";
        // }
        // field(2013667;"Vendor DTax Group Code";Code[10])
        // {
        //     CaptionML = ENU='Vendor Tax Group Code',
        //                 FRA='Code groupe taxe fournisseur';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Vendor));
        // }
        // field(2013695;"Item Charge Type Filter";Option)
        // {
        //     CaptionML = ENU='Item Charge Type Filter',
        //                 FRA='Filtre type frais article';
        //     Description = 'DITW15.00.00.35';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU=' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA=' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost";
        // }
        // field(2013710;"Prices Incl. Reverse Calc.";Boolean)
        // {
        //     CaptionML = ENU='Prices Incl. Reverse Calc.',
        //                 FRA='Prix incl. calcul inverse';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013726;"Vendor Tax Registration No.";Text[20])
        // {
        //     CaptionML = ENU='Vendor Tax Registration No.',
        //                 FRA='N° ident. accise fournisseur';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        // }
        // field(2013730;"Fiscal Representative No.";Code[20])
        // {
        //     CaptionML = ENU='Fiscal Representative / Customs Agent No.',
        //                 FRA='N° représentant fiscal / Agent des douanes';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     TableRelation = "Fiscal Representative";
        // }
        // field(2013733;"Tax Date";Date)
        // {
        //     CaptionML = ENU='Tax Date',
        //                 FRA='Date taxe';
        //     Description = 'DITW15.00.00.39 #1363';
        // }
        // field(2013823;"Gen. Bus. Posting Free Group";Code[10])
        // {
        //     CaptionML = ENU='Gen. Bus. Posting Group Free item',
        //                 FRA='Groupe article gratuit compta. marché';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Gen. Business Posting Group";
        // }
        // field(2013825;"Free Item Posting Type";Option)
        // {
        //     CaptionML = ENU='Calculate Price on Free',
        //                 FRA='Calculer Prix sur gratuit';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     OptionCaptionML = ENU=' ,Price 0,Discount 100%',
        //                       FRA=' ,Prix 0,Remise 100%';
        //     OptionMembers = " ",Price,Amount;
        // }
        // field(2014064;"Shipping Charge Per";Option)
        // {
        //     CaptionML = ENU='Shipping Charge Per',
        //                 FRA='Frais transport par';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     OptionCaptionML = ENU='Shipment,Weight,Volume',
        //                       FRA='Expédition,Poids,Volume';
        //     OptionMembers = Shipment,Weight,Volume;
        // }
        // field(2014075;"Shipping Agent Code";Code[10])
        // {
        //     CaptionML = ENU='Shipping Agent Code',
        //                 FRA='Code transporteur';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     TableRelation = "Shipping Agent";
        // }
        // field(2014076;"Shipping Agent Service Code";Code[10])
        // {
        //     CaptionML = ENU='Shipping Agent Service Code',
        //                 FRA='Code prestation transporteur';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     TableRelation = "Shipping Agent Services".Code WHERE ("Shipping Agent Code"=FIELD("Shipping Agent Code"));
        // }
        // field(2014077;"Truck Code";Code[10])
        // {
        //     CaptionML = ENU='Truck Code',
        //                 FRA='Code camion';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Whse. Shipping Truck";
        // }
        // field(2014078;"Driver Code";Code[10])
        // {
        //     CaptionML = ENU='Driver Code',
        //                 FRA='Code chauffeur';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Whse. Shipping Driver";
        // }
        // field(2014080;"Vendor Delivery Type";Code[10])
        // {
        //     CaptionML = ENU='Vendor Delivery Type',
        //                 FRA='Type Livraison Fournisseur';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     TableRelation = "Delivery Type".Code WHERE (Type=CONST(Vendor));
        // }
        // field(2014087;Distance;Decimal)
        // {
        //     CaptionML = ENU='Distance',
        //                 FRA='Distance';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     MinValue = 0;
        // }
        // field(2014098;"Require 2 Drivers";Boolean)
        // {
        //     Caption = 'Require 2 Drivers';
        //     Description = 'NRQ16082';
        // }
        // field(2014099;"Driver 2 Code";Code[10])
        // {
        //     Caption = 'Driver 2 Code';
        //     Description = 'NRQ16082';
        // }
        // field(2014100;"Trailer Code";Code[10])
        // {
        //     Caption = 'Trailer Code';
        //     Description = 'NRQ16082';
        // }
        // field(2014107;Route;Code[20])
        // {
        //     Caption = 'Route';
        //     Description = 'NRQ16082';
        // }
        // field(2014109;"Route Planning No.";Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'DITW110.00.11 NRQ#17902';
        //     TableRelation = "Route Planning Worksheet";
        // }
        // field(2014271;"Vendor Tax Warehouse Ref.";Text[20])
        // {
        //     CaptionML = ENU='Vendor Tax Warehouse Reference',
        //                 FRA='Entrepôt fiscal de référence fournisseur';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        // }
        // field(2014277;"Transport Mode";Option)
        // {
        //     CalcFormula = Lookup("Transport Method"."Transport Mode" WHERE (Code=FIELD("Transport Method")));
        //     CaptionML = ENU='Transport Mode (EMCS)',
        //                 FRA='Mode de transport (EMCS)';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     OptionCaptionML = ENU='Other,Sea,Rail,Road,Air,Post,N/A,Fixed,Waterway',
        //                       FRA='Autre,Mer,Chemin de fer,Route,Air,Poste,N/C,Installation de transport fixes,Transport par voies navigables';
        //     OptionMembers = Other,Sea,Rail,Road,Air,Post,"N/A","Fixed",Waterway;
        // }
        // field(2014290;"Journey Time";DateFormula)
        // {
        //     CaptionML = ENU='Journey Time (EMCS)',
        //                 FRA='Temps de trajet (EMCS)';
        //     Description = 'DITW15.00.00.39 #1353';
        // }
        // field(2014291;"Transport Mode Comment";Boolean)
        // {
        //     CalcFormula = Exist("EMCS Comment Line" WHERE ("Table ID"=CONST(122),
        //                                                    "Document Type"=CONST(0),
        //                                                    "Document No."=FIELD("No."),
        //                                                    "Document Line No."=CONST(0),
        //                                                    "Field ID"=CONST(2014277)));
        //     CaptionML = ENU='Transport Mode Comment',
        //                 FRA='Commentaires Mode de transport';
        //     Description = 'DITW16.00.00.44 DIT-715 #910';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014313;"Financial Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Financial Contract No.',
        //                 FRA='N° Contrat Financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Financial Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                       "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
        // }
        // field(2014410;"Physical Location Group Code";Code[10])
        // {
        //     CaptionML = ENU='Physical Location Group Code',
        //                 FRA='Code groupe magasin réel';
        //     Description = 'DITW18.00.06 DIT-770 #1191';
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014411;"Creation Date/Time";DateTime)
        // {
        //     CaptionML = ENU='Creation Date/Time',
        //                 FRA='Date/Heure Création';
        //     Description = 'DITW18.00.07 DIT-770 #1282';
        //     Editable = false;
        // }
        // field(2014412;"Created By";Code[50])
        // {
        //     CaptionML = ENU='Created By',
        //                 FRA='Créé par';
        //     Description = 'DITW18.00.07 DIT-770 #1282';
        //     Editable = false;
        //     TableRelation = "User Setup";
        // }
        // field(2014420;"Sundry Vendor";Boolean)
        // {
        //     CaptionML = ENU='Sundry Vendor',
        //                 FRA='Fournisseur Divers';
        //     Description = 'DITW18.00.07 DIT-770 #1804';
        // }
        // field(2014421;"Document Subtype Code";Code[10])
        // {
        //     CaptionML = ENU='Document Subtype Code',
        //                 FRA='Code Sous-Type Document';
        //     Description = 'DITW18.00.07 DIT-770 #1508';
        //     TableRelation = "Document Subtype Code".Code WHERE ("Report Selection Type"=CONST(Purchase));
        // }
        // field(2014426;"Service Order No.";Code[20])
        // {
        //     CaptionML = ENU='Service Order No.',
        //                 FRA='N° commande de service';
        //     Description = 'DITW15.00.00.39 #1403 - DIT-715 #297';
        //     Editable = false;
        //     TableRelation = "Service Header"."No." WHERE ("Document Type"=CONST(Order));
        // }
        // field(2014460;"Tax Office Code";Code[10])
        // {
        //     CaptionML = ENU='Tax Office Code',
        //                 FRA='Code Bureau de taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Office";
        // }
        // field(2014495;"Delivery Sequence";Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU='Delivery Sequence',
        //                 FRA='Séquence de livraison';
        //     Description = 'DITW16.00.00.40 #1002';
        //     MinValue = 0;
        // }
        // field(2034850;"DIT Sub-Contract Type";Option)
        // {
        //     CaptionML = ENU='Sub Contract Type',
        //                 FRA='Sous type contrat';
        //     Description = 'DIT-715 #392';
        //     OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA=' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        // }
        // field(2034872;"Contract Group Code";Code[10])
        // {
        //     CaptionML = ENU='Contract Group Code',
        //                 FRA='Code groupe contrat';
        //     Description = 'DIT-715 #392';
        //     TableRelation = IF ("Contract Type"=CONST(Service)) "Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"))
        //                     else IF ("Contract Type"=CONST(Financial)) "Financial Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034915;"Service Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Service Contract No.',
        //                 FRA='N° contrat de service';
        //     Description = 'DIT-715 #392 - DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Service Purch. Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                            "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
        // }
        // field(2035393;"Contract Type";Option)
        // {
        //     CaptionML = ENU='Contract Type',
        //                 FRA='Type contrat';
        //     Description = 'DIT-715 #392 - DITW18.00.06 DIT-770 #1368';
        //     OptionCaptionML = ENU=' ,Service,Financial',
        //                       FRA=' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }
        //BC UPGRADE SHARMP16 drink-it fields>>
    }
    keys
    {
        // key(Key1; "Link Purch. Document No.")
        // {
        // }//BC UPGRADE SHARMP16 drink-it keys used.
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        Currency: Record Currency;
        TotalPurchCrMemoLine: Record "Purch. Cr. Memo Line";
        TotalPurchCrMemoLineLCY: Record "Purch. Cr. Memo Line";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
}

