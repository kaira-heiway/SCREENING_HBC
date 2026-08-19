tableextension 50100 ServiceMgtSetupExtFND extends "Service Mgt. Setup"
{
    // version NAVW18.00,FINXL7.00,DITW18.00,HEI.01
    // DITW16.00.00.42 DDR 11/02/2013 DIT-715 #523 Added fields
    //                                               2034869 Use Contract Close Reason

    // FINXL7.00.001 RBE 20/03/2013 : Created fields 2029610..2029611

    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // HEI.01 FDD-RW-GAPLOG02 IBM NASTAA02 10.09.2018 # Delivery Note
    //   # Created new Fields: 50000 - CTS Technician Property Code
    //                         50001 - CTS Document Subtype
    fields
    {
        modify("Primary Key")
        {
            CaptionML = ENU = 'Primary Key', FRA = 'Clé primaire';
        }
        modify("Fault Reporting Level")
        {
            CaptionML = ENU = 'Fault Reporting Level', FRA = 'Niveau reporting panne';
            OptionCaptionML = ENU = 'None,Fault,Fault+Symptom,Fault+Symptom+Area (IRIS)', FRA = 'Aucun,Panne,Panne+Symptôme,Panne+Symptôme+Zone (IRIS)';
        }
        modify("Link Service to Service Item")
        {
            CaptionML = ENU = 'Link Service to Service Item', FRA = 'Lier service à article de service';
        }
        modify("Salesperson Mandatory")
        {
            CaptionML = ENU = 'Salesperson Mandatory', FRA = 'Vendeur';
        }
        modify("Warranty Disc. % (Parts)")
        {
            CaptionML = ENU = 'Warranty Disc. % (Parts)', FRA = '% remise garantie (pièces)';
        }
        modify("Warranty Disc. % (Labor)")
        {
            CaptionML = ENU = 'Warranty Disc. % (Labor)', FRA = '% remise garantie (M.O.)';
        }
        modify("Contract Rsp. Time Mandatory")
        {
            CaptionML = ENU = 'Contract Rsp. Time Mandatory', FRA = 'Délai de réponse contrat';
        }
        modify("Service Order Starting Fee")
        {
            CaptionML = ENU = 'Service Order Starting Fee', FRA = 'Frais forfait. commande service';
        }
        modify("Register Contract Changes")
        {
            CaptionML = ENU = 'Register Contract Changes', FRA = 'Hist. modif. contrat';
        }
        modify("Contract Inv. Line Text Code")
        {
            CaptionML = ENU = 'Contract Inv. Line Text Code', FRA = 'Code texte ligne fact. contrat';
        }
        modify("Contract Line Inv. Text Code")
        {
            CaptionML = ENU = 'Contract Line Inv. Text Code', FRA = 'Code texte fact. ligne contrat';
        }
        modify("Contract Inv. Period Text Code")
        {
            CaptionML = ENU = 'Contract Inv. Period Text Code', FRA = 'Code texte période fact. contrat';
        }
        modify("Contract Credit Line Text Code")
        {
            CaptionML = ENU = 'Contract Credit Line Text Code', FRA = 'Code texte avoir contrat';
        }
        modify("Send First Warning To")
        {
            CaptionML = ENU = 'Send First Warning To', FRA = 'Envoyer première alerte à';
        }
        modify("Send Second Warning To")
        {
            CaptionML = ENU = 'Send Second Warning To', FRA = 'Envoyer deuxième alerte à';
        }
        modify("Send Third Warning To")
        {
            CaptionML = ENU = 'Send Third Warning To', FRA = 'Envoyer troisième alerte à';
        }
        modify("First Warning Within (Hours)")
        {
            CaptionML = ENU = 'First Warning Within (Hours)', FRA = '1ère alerte dans les (heures)';
        }
        modify("Second Warning Within (Hours)")
        {
            CaptionML = ENU = 'Second Warning Within (Hours)', FRA = '2ème alerte dans les (heures)';
        }
        modify("Third Warning Within (Hours)")
        {
            CaptionML = ENU = 'Third Warning Within (Hours)', FRA = '3ème alerte dans les (heures)';
        }
        modify("Next Service Calc. Method")
        {
            CaptionML = ENU = 'Next Service Calc. Method', FRA = 'Méthode calc. proch. service';
            OptionCaptionML = ENU = 'Planned,Actual', FRA = 'Prévu,Réel';
        }
        modify("Service Order Type Mandatory")
        {
            CaptionML = ENU = 'Service Order Type Mandatory', FRA = 'Type commande service';
        }
        modify("Service Zones Option")
        {
            CaptionML = ENU = 'Service Zones Option', FRA = 'Option zones service';
            OptionCaptionML = ENU = 'Code Shown,Warning Displayed,Not Used', FRA = 'Afficher code seulement,Utiliser alertes et afficher,Aucun affichage';
        }
        modify("Service Order Start Mandatory")
        {
            CaptionML = ENU = 'Service Order Start Mandatory', FRA = 'Début commande service';
        }
        modify("Service Order Finish Mandatory")
        {
            CaptionML = ENU = 'Service Order Finish Mandatory', FRA = 'Fin commande service';
        }
        modify("Resource Skills Option")
        {
            CaptionML = ENU = 'Resource Skills Option', FRA = 'Compétences ressources';
            OptionCaptionML = ENU = 'Code Shown,Warning Displayed,Not Used', FRA = 'Afficher code seulement,Utiliser alertes et afficher,Aucun affichage';
        }
        modify("One Service Item Line/Order")
        {
            CaptionML = ENU = 'One Service Item Line/Order', FRA = 'Une ligne article de service/cde';
        }
        modify("Unit of Measure Mandatory")
        {
            CaptionML = ENU = 'Unit of Measure Mandatory', FRA = 'Unité';
        }
        modify("Fault Reason Code Mandatory")
        {
            CaptionML = ENU = 'Fault Reason Code Mandatory', FRA = 'Code motif panne';
        }
        modify("Contract Serv. Ord.  Max. Days")
        {
            CaptionML = ENU = 'Contract Serv. Ord.  Max. Days', FRA = 'Nbre jours max. cde contrat';
        }
        modify("Last Contract Service Date")
        {
            CaptionML = ENU = 'Last Contract Service Date', FRA = 'Dern. date contrat de service';
        }
        modify("Work Type Code Mandatory")
        {
            CaptionML = ENU = 'Work Type Code Mandatory', FRA = 'Code type travail';
        }
        modify("Logo Position on Documents")
        {
            CaptionML = ENU = 'Logo Position on Documents', FRA = 'Position du logo sur les documents';
            OptionCaptionML = ENU = 'No Logo,Left,Center,Right', FRA = 'Aucun logo,Gauche,Centre,Droite';
        }
        modify("Use Contract Cancel Reason")
        {
            CaptionML = ENU = 'Use Contract Cancel Reason', FRA = 'Utiliser motif annulation contrat';
        }
        modify("Default Response Time (Hours)")
        {
            CaptionML = ENU = 'Default Response Time (Hours)', FRA = 'Délai de réponse par déf. (heures)';
        }
        modify("Default Warranty Duration")
        {
            CaptionML = ENU = 'Default Warranty Duration', FRA = 'Durée de garantie par défaut';
        }
        modify("Service Invoice Nos.")
        {
            CaptionML = ENU = 'Service Invoice Nos.', FRA = 'N° facture service';
        }
        modify("Contract Invoice Nos.")
        {
            CaptionML = ENU = 'Contract Invoice Nos.', FRA = 'N° facture contrat';
        }
        modify("Service Item Nos.")
        {
            CaptionML = ENU = 'Service Item Nos.', FRA = 'N° article de service';
        }
        modify("Service Order Nos.")
        {
            CaptionML = ENU = 'Service Order Nos.', FRA = 'N° commande service';
        }
        modify("Service Contract Nos.")
        {
            CaptionML = ENU = 'Service Contract Nos.', FRA = 'N° contrat de service';
        }
        modify("Contract Template Nos.")
        {
            CaptionML = ENU = 'Contract Template Nos.', FRA = 'N° modèle contrat';
        }
        modify("Troubleshooting Nos.")
        {
            CaptionML = ENU = 'Troubleshooting Nos.', FRA = 'N° incident';
        }
        modify("Prepaid Posting Document Nos.")
        {
            CaptionML = ENU = 'Prepaid Posting Document Nos.', FRA = 'N° doc. prépayé validation';
        }
        modify("Loaner Nos.")
        {
            CaptionML = ENU = 'Loaner Nos.', FRA = 'N° article de prêt';
        }
        modify("Serv. Job Responsibility Code")
        {
            CaptionML = ENU = 'Serv. Job Responsibility Code', FRA = 'Code responsabilité service';
        }
        modify("Contract Value Calc. Method")
        {
            CaptionML = ENU = 'Contract Value Calc. Method', FRA = 'Mode calcul valeur contrat';
            OptionCaptionML = ENU = 'None,Based on Unit Price,Based on Unit Cost', FRA = 'Aucun,Prix unitaire,Coût unitaire';
        }
        modify("Contract Value %")
        {
            CaptionML = ENU = 'Contract Value %', FRA = '% valeur contrat';
        }
        modify("Service Quote Nos.")
        {
            CaptionML = ENU = 'Service Quote Nos.', FRA = 'N° devis service';
        }
        modify("Posted Service Invoice Nos.")
        {
            CaptionML = ENU = 'Posted Service Invoice Nos.', FRA = 'N° factures service enreg.';
        }
        modify("Posted Serv. Credit Memo Nos.")
        {
            CaptionML = ENU = 'Posted Serv. Credit Memo Nos.', FRA = 'N° avoirs service enreg.';
        }
        modify("Posted Service Shipment Nos.")
        {
            CaptionML = ENU = 'Posted Service Shipment Nos.', FRA = 'N° expéditions service enreg.';
        }
        modify("Shipment on Invoice")
        {
            CaptionML = ENU = 'Shipment on Invoice', FRA = 'B.L sur facture';
        }
        modify("Copy Comments Order to Invoice")
        {

            //Unsupported feature: Change InitValue on ""Copy Comments Order to Invoice"(Field 81)". Please convert manually.

            CaptionML = ENU = 'Copy Comments Order to Invoice', FRA = 'Copier com. cde -> facture';
        }
        modify("Copy Comments Order to Shpt.")
        {

            //Unsupported feature: Change InitValue on ""Copy Comments Order to Shpt."(Field 82)". Please convert manually.

            CaptionML = ENU = 'Copy Comments Order to Shpt.', FRA = 'Copier com. cde -> expédition';
        }
        modify("Service Credit Memo Nos.")
        {
            CaptionML = ENU = 'Service Credit Memo Nos.', FRA = 'N° avoirs service';
        }
        modify("Copy Time Sheet to Order")
        {
            CaptionML = ENU = 'Copy Time Sheet to Order', FRA = 'Copier une feuille de temps dans commande';
        }
        modify("Base Calendar Code")
        {
            CaptionML = ENU = 'Base Calendar Code', FRA = 'Code calendrier principal';
        }
        modify("Contract Credit Memo Nos.")
        {
            CaptionML = ENU = 'Contract Credit Memo Nos.', FRA = 'N° avoir contrat';
        }
        field(50000; "CTS Technician Prpty. Code FND"; Code[20])
        {
            caption = 'CTS Technician Property Code';
            Description = 'HEI.01';
            //TableRelation = Property.Code where("Table ID" = CONST(18));  // BC Upgrade NANDIS03 - Blocked as Property is DIT table
        }
        field(50001; "CTS Document Subtype FND"; Code[10])
        {
            caption = 'CTS Document Subtype';
            Description = 'HEI.01';
            //TableRelation = "Document Subtype Code".Code;  // BC Upgrade NANDIS03 - Blocked as Document Subtype is DIT table
        }
        // field(2029610; "Use OGM"; Option)
        // {
        //     CaptionML = ENU = 'Use OGM',
        //                 FRA = 'Use OGM';
        //     Description = 'FINXL7.00.001';
        //     OptionCaptionML = ENU = ' ,Document,Customer + Document',
        //                       FRA = ' ,Document,Client + Document';
        //     OptionMembers = " ",Document,"Customer + Document";
        // }
        // field(2029611; "Print OGM"; Boolean)
        // {
        //     CaptionML = ENU = 'Print OGM',
        //                 FRA = 'Print OGM';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2034869; "Use Contract Close Reason"; Boolean)
        // {
        //     CaptionML = ENU = 'Use Contract Close Reason',
        //                 FRA = 'Utiliser motif clôture contrat';
        //     Description = 'DITW16.00.00.42 DIT-715 #523';
        // }  // BC Upgrade NANDIS03
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

