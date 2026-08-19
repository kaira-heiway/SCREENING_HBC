tableextension 50082 ServiceHeaderExtFND extends "Service Header"
{
    //    HEI.01 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Bill-to Address", "Bill-to Address 2", "Ship-to Address", "Ship-to Address 2",
    //               "Address" and "Address 2" fields length from 50 to 60 characters
    //   # Increased "Bill-to City", "Ship-to City" and "City" fields length from 30 to 35 characters
    // HEI.02 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Function 'CheckStatus' from HEI2.0

    fields
    {
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo', FRA = 'Devis,Commande,Facture,Avoir';
        }
        modify("Customer No.")
        {

            //Unsupported feature: Change TableRelation on ""Customer No."(Field 2)". Please convert manually.

            CaptionML = ENU = 'Customer No.', FRA = 'N° client';
            //CaptionClass = GetCaptionClassPM(FIELDCAPTION("Customer No."),Text2014310_2); //BC Upgrade KAMNAY01 -Function is not found(DIT)
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Bill-to Customer No.")
        {

            //Unsupported feature: Change TableRelation on ""Bill-to Customer No."(Field 4)". Please convert manually.

            CaptionML = ENU = 'Bill-to Customer No.', FRA = 'N° client facturé';
        }
        modify("Bill-to Name")
        {
            CaptionML = ENU = 'Bill-to Name', FRA = 'Nom client facturé';
        }
        modify("Bill-to Name 2")
        {
            CaptionML = ENU = 'Bill-to Name 2', FRA = 'Nom client facturé 2';
        }
        modify("Bill-to Address")
        {

            //Unsupported feature: Change Data type on ""Bill-to Address"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Bill-to Address', FRA = 'Adresse facturation';

            //Unsupported feature: Change Description on ""Bill-to Address"(Field 7)". Please convert manually.

        }
        modify("Bill-to Address 2")
        {

            //Unsupported feature: Change Data type on ""Bill-to Address 2"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Bill-to Address 2', FRA = 'Adresse facturation 2';

            //Unsupported feature: Change Description on ""Bill-to Address 2"(Field 8)". Please convert manually.

        }
        modify("Bill-to City")
        {

            //Unsupported feature: Change Data type on ""Bill-to City"(Field 9)". Please convert manually.


            //Unsupported feature: InsertAfter on ""Bill-to City"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Bill-to City', FRA = 'Ville facturation';

            //Unsupported feature: Change Description on ""Bill-to City"(Field 9)". Please convert manually.

        }
        modify("Bill-to Contact")
        {
            CaptionML = ENU = 'Bill-to Contact', FRA = 'Contact facturation';
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


            //Unsupported feature: Change TableRelation on ""Ship-to City"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Ship-to City', FRA = 'Ville destinataire';

            //Unsupported feature: Change Description on ""Ship-to City"(Field 17)". Please convert manually.

        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Ship-to Contact', FRA = 'Contact destinataire';
        }
        modify("Order Date")
        {
            CaptionML = ENU = 'Order Date', FRA = 'Date commande';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Posting Description")
        {
            CaptionML = ENU = 'Posting Description', FRA = 'Libellé écriture';
        }
        modify("Payment Terms Code")
        {
            CaptionML = ENU = 'Payment Terms Code', FRA = 'Code conditions paiement';
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

            //Unsupported feature: Change Description on ""Location Code"(Field 28)". Please convert manually.

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
        modify("Customer Posting Group")
        {
            CaptionML = ENU = 'Customer Posting Group', FRA = 'Groupe compta. client';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Currency Factor")
        {
            CaptionML = ENU = 'Currency Factor', FRA = 'Facteur devise';
        }
        modify("Customer Price Group")
        {
            CaptionML = ENU = 'Customer Price Group', FRA = 'Groupe prix client';
        }
        modify("Prices Including VAT")
        {
            CaptionML = ENU = 'Prices Including VAT', FRA = 'Prix TTC';
        }
        modify("Invoice Disc. Code")
        {
            CaptionML = ENU = 'Invoice Disc. Code', FRA = 'Code remise facture';
        }
        modify("Customer Disc. Group")
        {
            CaptionML = ENU = 'Customer Disc. Group', FRA = 'Groupe rem. client';
        }
        modify("Language Code")
        {
            CaptionML = ENU = 'Language Code', FRA = 'Code langue';
        }
        modify("Salesperson Code")
        {

            //Unsupported feature: Change TableRelation on ""Salesperson Code"(Field 43)". Please convert manually.

            CaptionML = ENU = 'Salesperson Code', FRA = 'Code vendeur';
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

            //Unsupported feature: Change TableRelation on ""Bal. Account No."(Field 55)". Please convert manually.

            CaptionML = ENU = 'Bal. Account No.', FRA = 'N° compte contrepartie';
        }
        modify("Shipping No.")
        {
            CaptionML = ENU = 'Shipping No.', FRA = 'Utiliser B.L. N°';
        }
        modify("Posting No.")
        {
            CaptionML = ENU = 'Posting No.', FRA = 'N° validation';
        }
        modify("Last Shipping No.")
        {
            CaptionML = ENU = 'Last Shipping No.', FRA = 'N° dern. bon de livraison';
        }
        modify("Last Posting No.")
        {
            CaptionML = ENU = 'Last Posting No.', FRA = 'N° dern. facture';
        }
        modify("VAT Registration No.")
        {
            CaptionML = ENU = 'VAT Registration No.', FRA = 'N° identif. intracomm.';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("EU 3-Party Trade")
        {
            CaptionML = ENU = 'EU 3-Party Trade', FRA = 'Trans. tripartite UE';
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
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Name 2")
        {
            CaptionML = ENU = 'Name 2', FRA = 'Nom 2';
        }
        modify(Address)
        {

            //Unsupported feature: Change Data type on "Address(Field 81)". Please convert manually.

            CaptionML = ENU = 'Address', FRA = 'Adresse';

            //Unsupported feature: Change Description on "Address(Field 81)". Please convert manually.

        }
        modify("Address 2")
        {

            //Unsupported feature: Change Data type on ""Address 2"(Field 82)". Please convert manually.

            CaptionML = ENU = 'Address 2', FRA = 'Adresse 2';

            //Unsupported feature: Change Description on ""Address 2"(Field 82)". Please convert manually.

        }
        modify(City)
        {

            //Unsupported feature: Change Data type on "City(Field 83)". Please convert manually.


            //Unsupported feature: Change TableRelation on "City(Field 83)". Please convert manually.

            CaptionML = ENU = 'City', FRA = 'Ville';

            //Unsupported feature: Change Description on "City(Field 83)". Please convert manually.

        }
        modify("Contact Name")
        {
            CaptionML = ENU = 'Contact Name', FRA = 'Nom contact';
        }
        modify("Bill-to Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Bill-to Post Code"(Field 85)". Please convert manually.

            CaptionML = ENU = 'Bill-to Post Code', FRA = 'Code postal facturation';
        }
        modify("Bill-to County")
        {
            CaptionML = ENU = 'Bill-to County', FRA = 'Région facturation';
        }
        modify("Bill-to Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Bill-to Country/Region Code"(Field 87)". Please convert manually.

            CaptionML = ENU = 'Bill-to Country/Region Code', FRA = 'Code pays/région facturation';
        }
        modify("Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Post Code"(Field 88)". Please convert manually.

            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify(County)
        {
            CaptionML = ENU = 'County', FRA = 'Région';
        }
        modify("Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Country/Region Code"(Field 90)". Please convert manually.

            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify("Ship-to Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Ship-to Post Code"(Field 91)". Please convert manually.

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
           // OptionCaptionML = ENU = 'G/L Account,Bank Account', FRA = 'Général,Banque';
        }
        modify("Exit Point")
        {
            CaptionML = ENU = 'Exit Point', FRA = 'Pays destination';
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
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Posting No. Series")
        {
            CaptionML = ENU = 'Posting No. Series', FRA = 'Souches de n° validation';
        }
        modify("Shipping No. Series")
        {
            CaptionML = ENU = 'Shipping No. Series', FRA = 'Souche de n° expédition';
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
        modify(Reserve)
        {
            CaptionML = ENU = 'Reserve', FRA = 'Réserver';
           // OptionCaptionML = ENU = 'Never,Optional,Always', FRA = 'Jamais,Manuel,Toujours';
        }
        modify("Applies-to ID")
        {
            CaptionML = ENU = 'Applies-to ID', FRA = 'ID lettrage';
        }
        modify("VAT Base Discount %")
        {
            CaptionML = ENU = 'VAT Base Discount %', FRA = '% remise base TVA';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
           // OptionCaptionML = ENU = 'Pending,In Process,Finished,On Hold', FRA = 'Suspendu,En cours,Terminé,En attente';
        }
        modify("Invoice Discount Calculation")
        {
            CaptionML = ENU = 'Invoice Discount Calculation', FRA = 'Calcul remise facture';
            OptionCaptionML = ENU = 'None,%,Amount', FRA = 'Aucun,%,Montant';
        }
        modify("Invoice Discount Value")
        {
            CaptionML = ENU = 'Invoice Discount Value', FRA = 'Valeur remise facture';
        }
        modify("Release Status")
        {
            CaptionML = ENU = 'Release Status', FRA = 'Statut de lancement';
           // OptionCaptionML = ENU = 'Open,Released to Ship', FRA = 'Ouvert,Lancer pour expédition';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
        }
        modify("Bill-to Contact No.")
        {
            CaptionML = ENU = 'Bill-to Contact No.', FRA = 'N° contact facturation';
        }
        modify("Responsibility Center")
        {

            //Unsupported feature: Change TableRelation on ""Responsibility Center"(Field 5700)". Please convert manually.

            CaptionML = ENU = 'Responsibility Center', FRA = 'Centre de gestion';

            //Unsupported feature: Change Description on ""Responsibility Center"(Field 5700)". Please convert manually.

        }
        modify("Shipping Advice")
        {
            CaptionML = ENU = 'Shipping Advice', FRA = 'Option d''expédition';
           // OptionCaptionML = ENU = 'Partial,Complete', FRA = 'Partielle,Totale';
        }
        modify("Completely Shipped")
        {

            //Unsupported feature: Change CalcFormula on ""Completely Shipped"(Field 5752)". Please convert manually.

            CaptionML = ENU = 'Completely Shipped', FRA = 'Entièrement expédiée';
        }
        modify("Location Filter")
        {
            CaptionML = ENU = 'Location Filter', FRA = 'Filtre magasin';
        }
        modify("Shipping Time")
        {
            CaptionML = ENU = 'Shipping Time', FRA = 'Délai d''expédition';
        }
        modify("Shipping Agent Service Code")
        {

            //Unsupported feature: Change TableRelation on ""Shipping Agent Service Code"(Field 5794)". Please convert manually.

            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }
        modify("Service Order Type")
        {

            //Unsupported feature: Change TableRelation on ""Service Order Type"(Field 5904)". Please convert manually.

            CaptionML = ENU = 'Service Order Type', FRA = 'Type commande service';
            // CaptionClass = GetCaptionClassPM(FIELDCAPTION("Service Order Type"),Text2014310_5904);//BC Upgrade KAMNAY01 -Function is not found(DIT)
        }
        modify("Link Service to Service Item")
        {
            CaptionML = ENU = 'Link Service to Service Item', FRA = 'Lier service à article de service';
            // CaptionClass = GetCaptionClassPM(FIELDCAPTION("Link Service to Service Item"),Text2014310_5905);//BC Upgrade KAMNAY01 -Function is not found(DIT)
        }
        modify(Priority)
        {
            CaptionML = ENU = 'Priority', FRA = 'Priorité';
           // OptionCaptionML = ENU = 'Low,Medium,High', FRA = 'Faible,Moyenne,Haute';
        }
        modify("Allocated Hours")
        {

            //Unsupported feature: Change CalcFormula on ""Allocated Hours"(Field 5911)". Please convert manually.

            CaptionML = ENU = 'Allocated Hours', FRA = 'Heures affectées';
        }
        modify("Phone No.")
        {
            CaptionML = ENU = 'Phone No.', FRA = 'N° téléphone';
        }
        modify("E-Mail")
        {
            CaptionML = ENU = 'Email', FRA = 'Adresse e-mail';
        }
        modify("Phone No. 2")
        {
            CaptionML = ENU = 'Phone No. 2', FRA = 'N° téléphone 2';
        }
        modify("Fax No.")
        {
            CaptionML = ENU = 'Fax No.', FRA = 'N° télécopie';
        }
        modify("No. of Unallocated Items")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Unallocated Items"(Field 5921)". Please convert manually.

            CaptionML = ENU = 'No. of Unallocated Items', FRA = 'Nbre articles non affectés';
        }
        modify("Order Time")
        {
            CaptionML = ENU = 'Order Time', FRA = 'Heure commande';
        }
        modify("Default Response Time (Hours)")
        {
            CaptionML = ENU = 'Default Response Time (Hours)', FRA = 'Délai de réponse par déf. (heures)';
        }
        modify("Actual Response Time (Hours)")
        {
            CaptionML = ENU = 'Actual Response Time (Hours)', FRA = 'Délai de réponse réel (heures)';
        }
        modify("Service Time (Hours)")
        {
            CaptionML = ENU = 'Service Time (Hours)', FRA = 'Temps de service (heures)';
        }
        modify("Response Date")
        {
            CaptionML = ENU = 'Response Date', FRA = 'Date de réponse';
        }
        modify("Response Time")
        {
            CaptionML = ENU = 'Response Time', FRA = 'Délai de réponse';
        }
        modify("Starting Date")
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
        }
        modify("Starting Time")
        {
            CaptionML = ENU = 'Starting Time', FRA = 'Heure début';
        }
        modify("Finishing Date")
        {
            CaptionML = ENU = 'Finishing Date', FRA = 'Date fin';
        }
        modify("Finishing Time")
        {
            CaptionML = ENU = 'Finishing Time', FRA = 'Heure fin';
        }
        modify("Contract Serv. Hours Exist")
        {

            //Unsupported feature: Change CalcFormula on ""Contract Serv. Hours Exist"(Field 5933)". Please convert manually.

            CaptionML = ENU = 'Contract Serv. Hours Exist', FRA = 'Heures contrat de service définies';
        }
        modify("Reallocation Needed")
        {

            //Unsupported feature: Change CalcFormula on ""Reallocation Needed"(Field 5934)". Please convert manually.

            CaptionML = ENU = 'Reallocation Needed', FRA = 'Réaffectation nécessaire';
        }
        modify("Notify Customer")
        {
            CaptionML = ENU = 'Notify Customer', FRA = 'Informer client';
            OptionCaptionML = ENU = 'No,By Phone 1,By Phone 2,By Fax,By Email', FRA = 'Non,Par téléphone 1,Par téléphone 2,Par télécopie,Par e-mail';
            // CaptionClass = GetCaptionClassPM(FIELDCAPTION("Notify Customer"),Text2014310_5936);//BC Upgrade KAMNAY01 -Function is not found(DIT)
        }
        modify("Max. Labor Unit Price")
        {
            CaptionML = ENU = 'Max. Labor Unit Price', FRA = 'Prix unitaire max. M.O.';
        }
        modify("Warning Status")
        {
            CaptionML = ENU = 'Warning Status', FRA = 'Statut alerte';
            OptionCaptionML = ENU = ' ,First Warning,Second Warning,Third Warning', FRA = ' ,Première alerte,Deuxième alerte,Troisième alerte';
        }
        modify("No. of Allocations")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Allocations"(Field 5939)". Please convert manually.

            CaptionML = ENU = 'No. of Allocations', FRA = 'Nbre affectations';
        }
        modify("Contract No.")
        {

            //Unsupported feature: Change TableRelation on ""Contract No."(Field 5940)". Please convert manually.

            CaptionML = ENU = 'Contract No.', FRA = 'N° contrat';
            //CaptionClass = GetCaptionClassPM(FIELDCAPTION("Contract No."),Text2014310_5940);//BC Upgrade KAMNAY01 -Function is not found(DIT)
        }
        modify("Type Filter")
        {
            CaptionML = ENU = 'Type Filter', FRA = 'Filtre type';
            OptionCaptionML = ENU = ' ,Resource,Item,Service Cost,Service Contract', FRA = ' ,Ressource,Article,Coût service,Contrat de service';
        }
        modify("Customer Filter")
        {

            //Unsupported feature: Change TableRelation on ""Customer Filter"(Field 5952)". Please convert manually.

            CaptionML = ENU = 'Customer Filter', FRA = 'Filtre client';
            //CaptionClass = GetCaptionClassPM(FIELDCAPTION("Customer Filter"),Text2014310_5952);//BC Upgrade KAMNAY01 -Function is not found(DIT)
        }
        modify("Resource Filter")
        {
            CaptionML = ENU = 'Resource Filter', FRA = 'Filtre ressource';
        }
        modify("Contract Filter")
        {

            //Unsupported feature: Change TableRelation on ""Contract Filter"(Field 5954)". Please convert manually.

            CaptionML = ENU = 'Contract Filter', FRA = 'Filtre contrat';
        }
        modify("Ship-to Fax No.")
        {
            CaptionML = ENU = 'Ship-to Fax No.', FRA = 'N° télécopie destinataire';
        }
        modify("Ship-to E-Mail")
        {
            CaptionML = ENU = 'Ship-to Email', FRA = 'E-mail destinataire';
        }
        modify("Resource Group Filter")
        {
            CaptionML = ENU = 'Resource Group Filter', FRA = 'Filtre gpe ressources';
        }
        modify("Ship-to Phone")
        {
            CaptionML = ENU = 'Ship-to Phone', FRA = 'Tél. destinataire';
        }
        modify("Ship-to Phone 2")
        {
            CaptionML = ENU = 'Ship-to Phone 2', FRA = 'Tél. 2 destinataire';
        }
        modify("Service Zone Filter")
        {
            CaptionML = ENU = 'Service Zone Filter', FRA = 'Filtre zone service';
        }
        modify("Service Zone Code")
        {
            CaptionML = ENU = 'Service Zone Code', FRA = 'Code zone service';
        }
        modify("Expected Finishing Date")
        {
            CaptionML = ENU = 'Expected Finishing Date', FRA = 'Date fin prévue';
        }
        modify("Allow Line Disc.")
        {
            CaptionML = ENU = 'Allow Line Disc.', FRA = 'Autoriser remise ligne';
        }
        modify("Assigned User ID")
        {
            CaptionML = ENU = 'Assigned User ID', FRA = 'Code utilisateur affecté';
        }
        modify("Quote No.")
        {
            CaptionML = ENU = 'Quote No.', FRA = 'N° devis';
        }

        //Unsupported feature: CodeModification on ""Customer No."(Field 2).OnValidate". Please convert manually.

        //trigger "(Field 2)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Customer No." <> xRec."Customer No.") AND (xRec."Customer No." <> '') THEN BEGIN
          IF "Contract No." <> '' THEN
            ERROR(
              Text003,
              FIELDCAPTION("Customer No."),
              "Document Type",FIELDCAPTION("No."),"No.",
              FIELDCAPTION("Contract No."),"Contract No.");
          IF HideValidationDialog OR NOT GUIALLOWED THEN
            Confirmed := TRUE
          else
            IF ServItemLineExists THEN
              Confirmed :=
                CONFIRM(
                  Text004,
                  FALSE,FIELDCAPTION("Customer No."))
            else
              IF ServLineExists THEN
                Confirmed :=
                  CONFIRM(
                    Text057,
                    FALSE,FIELDCAPTION("Customer No."))
              else
                Confirmed := CONFIRM(Text005,FALSE,FIELDCAPTION("Customer No."));
          IF Confirmed THEN BEGIN
            ServLine.SETRANGE("Document Type","Document Type");
            ServLine.SETRANGE("Document No.","No.");
            IF "Document Type" = "Document Type"::Order THEN
              ServLine.SETFILTER("Quantity Shipped",'<>0')
            else
              IF "Document Type" = "Document Type"::Invoice THEN BEGIN
                ServLine.SETRANGE("Customer No.",xRec."Customer No.");
                ServLine.SETFILTER("Shipment No.",'<>%1','');
              end;

            IF ServLine.FINDFIRST THEN BEGIN
              IF "Document Type" = "Document Type"::Order THEN
                ServLine.TESTFIELD("Quantity Shipped",0)
              else
                ServLine.TESTFIELD("Shipment No.",'');
            end;
            MODIFY(TRUE);

            ServLine.LOCKTABLE;
            ServLine.RESET;
            ServLine.SETRANGE("Document Type","Document Type");
            ServLine.SETRANGE("Document No.","No.");
            ServLine.DELETEALL(TRUE);

            ServItemLine.LOCKTABLE;
            ServItemLine.RESET;
            ServItemLine.SETRANGE("Document Type","Document Type");
            ServItemLine.SETRANGE("Document No.","No.");
            ServItemLine.DELETEALL(TRUE);

            GET("Document Type","No.");
            IF "Customer No." = '' THEN BEGIN
              INIT;
              ServSetup.GET;
              "No. Series" := xRec."No. Series";
              InitRecord;
              IF xRec."Shipping No." <> '' THEN BEGIN
                "Shipping No. Series" := xRec."Shipping No. Series";
                "Shipping No." := xRec."Shipping No.";
              end;
              IF xRec."Posting No." <> '' THEN BEGIN
                "Posting No. Series" := xRec."Posting No. Series";
                "Posting No." := xRec."Posting No.";
              end;
              EXIT;
            end;
          end else BEGIN
            Rec := xRec;
            EXIT;
          end;
        end;

        GetCust("Customer No.");
        IF "Customer No." <> '' THEN BEGIN
          Cust.CheckBlockedCustOnDocs(Cust,"Document Type",FALSE,FALSE);
          Cust.TESTFIELD("Gen. Bus. Posting Group");
          Name := Cust.Name;
          "Name 2" := Cust."Name 2";
          Address := Cust.Address;
          "Address 2" := Cust."Address 2";
          City := Cust.City;
          "Post Code" := Cust."Post Code";
          County := Cust.County;
          "Country/Region Code" := Cust."Country/Region Code";
          IF NOT SkipContact THEN BEGIN
            "Contact Name" := Cust.Contact;
            "Phone No." := Cust."Phone No.";
            "E-Mail" := Cust."E-Mail";
          end;
          "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
          "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
          "Tax Area Code" := Cust."Tax Area Code";
          "Tax Liable" := Cust."Tax Liable";
          "VAT Registration No." := Cust."VAT Registration No.";
          "Shipping Advice" := Cust."Shipping Advice";
          "Responsibility Center" := UserSetupMgt.GetRespCenter(2,Cust."Responsibility Center");
          VALIDATE("Location Code",UserSetupMgt.GetLocation(2,Cust."Location Code","Responsibility Center"));
        end;

        IF "Customer No." = xRec."Customer No." THEN
          IF ShippedServLinesExist THEN BEGIN
            TESTFIELD("VAT Bus. Posting Group",xRec."VAT Bus. Posting Group");
            TESTFIELD("Gen. Bus. Posting Group",xRec."Gen. Bus. Posting Group");
          end;

        COMMIT;
        IF Cust."Bill-to Customer No." <> '' THEN
          VALIDATE("Bill-to Customer No.",Cust."Bill-to Customer No.")
        else BEGIN
          IF "Bill-to Customer No." = "Customer No." THEN
            SkipBillToContact := TRUE;
          VALIDATE("Bill-to Customer No.","Customer No.");
          SkipBillToContact := FALSE;
        end;

        VALIDATE("Ship-to Code",'');
        VALIDATE("Service Zone Code");

        IF NOT SkipContact THEN
          UpdateCont("Customer No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW16.00.00.41 DDR 18/09/2012 DIT-715 #436
        if "DIT Sub-Contract Type" = "DIT Sub-Contract Type"::PlantMaintenance then begin
          CLEAR(UserMgt);
          if UserSetupMgt.GetPMServiceFilter <> '' then
            TESTFIELD("Customer No.",UserSetupMgt.GetPMServiceFilter);
        end;
        // >>DITW16.00.00.41 DDR DIT-715 #436

        if ("Customer No." <> xRec."Customer No.") and (xRec."Customer No." <> '') then begin
          if "Contract No." <> '' then
        #3..7
          if HideValidationDialog or not GUIALLOWED then
            Confirmed := true
          else
            if ServItemLineExists then
        #12..14
                  false,FIELDCAPTION("Customer No."))
            else
              if ServLineExists then
        #18..20
                    false,FIELDCAPTION("Customer No."))
              else
                Confirmed := CONFIRM(Text005,false,FIELDCAPTION("Customer No."));
          if Confirmed then begin
            ServLine.SETRANGE("Document Type","Document Type");
            ServLine.SETRANGE("Document No.","No.");
            if "Document Type" = "Document Type"::Order then
              ServLine.SETFILTER("Quantity Shipped",'<>0')
            else
              if "Document Type" = "Document Type"::Invoice then begin
                ServLine.SETRANGE("Customer No.",xRec."Customer No.");
                ServLine.SETFILTER("Shipment No.",'<>%1','');
              end;

            if ServLine.FINDFIRST then begin
              if "Document Type" = "Document Type"::Order then
                ServLine.TESTFIELD("Quantity Shipped",0)
              else
                ServLine.TESTFIELD("Shipment No.",'');
            end;
            MODIFY(true);
        #42..46
            ServLine.DELETEALL(true);
        #48..52
            ServItemLine.DELETEALL(true);

            GET("Document Type","No.");
            if "Customer No." = '' then begin
              INIT;
              ServSetup.GET;
              // <<DITW15.00.00.35 DDR 17/04/2009
              // <<DITW18.00.06 DDR 20/04/2015 DIT-770 #1234
              if ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") and DitServSetup.READPERMISSION then
              // >>DITW18.00.06 DDR DIT-770 #1234
                DitServSetup.GET;
              // >>DITW15.00.00.35 DDR
              // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
              if "DIT Sub-Contract Type" = "DIT Sub-Contract Type"::PlantMaintenance then
                PlantMaintSetup.GET;
              // >>DITW16.00.00.41 DDR DIT-715 #297
              "No. Series" := xRec."No. Series";
              InitRecord;
              if xRec."Shipping No." <> '' then begin
                "Shipping No. Series" := xRec."Shipping No. Series";
                "Shipping No." := xRec."Shipping No.";
              end;
              if xRec."Posting No." <> '' then begin
                "Posting No. Series" := xRec."Posting No. Series";
                "Posting No." := xRec."Posting No.";
              end;
              exit;
            end;
          end else begin
            Rec := xRec;
            exit;
          end;
        end;

        // <<DITW16.00.00.41 DDR 19/09/2012 DIT-715 #436
        CLEAR(UserSetupMgt);
        // >>DITW16.00.00.41 DDR DIT-715 #436
        GetCust("Customer No.");
        if "Customer No." <> '' then begin
          Cust.CheckBlockedCustOnDocs(Cust,"Document Type",false,false);
        #80..88
          //<<FINXL8.00.001 BSA 29/06/2015 #177
          if recFinXLSetup.READPERMISSION then
            if Cust."Bill-to Adress Code" <> '' then
              VALIDATE("Bill-to Adress Code",Cust."Bill-to Adress Code");
          //>>FINXL8.00.001 BSA 29/06/2015 #177
          if not SkipContact then begin
        #90..92
          end;
        #94..99
           // <<DITW18.00.06 MSF 01/03/2015 DIT-770 #1193
          VALIDATE("Responsibility Center",UserSetupMgt.GetRespCenter(2,Cust."Responsibility Center"));
          VALIDATE("Physical Location Group Code",UserSetupMgt.GetphysicalLocation(2,'',"Responsibility Center"));
          // >>DITW18.00.06 MSF 01/03/2015 DIT-770 #1193
          VALIDATE("Location Code",UserSetupMgt.GetLocation(2,Cust."Location Code","Responsibility Center"));
          // <<DITW15.00.00.35 DDR 10/04/2009 - 04/09/2009
          // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
          if ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") and
            ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::PlantMaintenance)
          then begin
            "Building No." := Cust."Building No.";
            if "Building No." <> '' then begin
              Building.GET("Building No.");
              Building.TESTFIELD(Blocked,false);
            end;
          end;
          // >>DITW15.00.00.35 DDR
        end;

        if "Customer No." = xRec."Customer No." then
          if ShippedServLinesExist then begin
            TESTFIELD("VAT Bus. Posting Group",xRec."VAT Bus. Posting Group");
            TESTFIELD("Gen. Bus. Posting Group",xRec."Gen. Bus. Posting Group");
          end;

        // <<DITW15.00.00.35 DDR 02/10/2009 - DITW15.00.00.37 DDR 28/01/2010
        if DitServSetup.READPERMISSION and
        // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
          ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") and
          ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::PlantMaintenance)
        // >>DITW16.00.00.41 DDR DIT-715 #297
        then begin
          DitServSetup.GET;
          if DitServSetup."Bill-to/Sell-to Building Dim." = DitServSetup."Bill-to/Sell-to Building Dim."::"Sell-to" then
            VALIDATE("Building No.");
        end;
        // >>DITW15.00.00.37 DDR

        COMMIT;
        if Cust."Bill-to Customer No." <> '' then
          VALIDATE("Bill-to Customer No.",Cust."Bill-to Customer No.")
        else begin
          if "Bill-to Customer No." = "Customer No." then
            SkipBillToContact := true;
          VALIDATE("Bill-to Customer No.","Customer No.");
          SkipBillToContact := false;
        end;

        //<<FINXL8.00.001 BSA 29/06/2015 #177
        if recFinXLSetup.READPERMISSION then
          if "Ship-to Customer No." = xRec."Customer No." then
            VALIDATE("Ship-to Customer No.","Customer No.");
        //>>FINXL8.00.001 BSA 29/06/2015 #177
        #119..122
        if not SkipContact then
          UpdateCont("Customer No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""No."(Field 3).OnValidate". Please convert manually.

        //trigger "(Field 3)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." <> xRec."No." THEN BEGIN
          ServSetup.GET;
          TestNoSeriesManual;
          "No. Series" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "No." <> xRec."No." then begin
          ServSetup.GET;
          // <<DITW15.00.00.35 DDR 17/04/2009
          // <<DITW18.00.06 DDR 20/04/2015 DIT-770 #1234
          if ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") and DitServSetup.READPERMISSION then
          // >>DITW18.00.06 DDR DIT-770 #1234
            DitServSetup.GET;
          // >>DITW15.00.00.35 DDR
          // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
          if "DIT Sub-Contract Type" = "DIT Sub-Contract Type"::PlantMaintenance then
            PlantMaintSetup.GET;
          // >>DITW16.00.00.41 DDR DIT-715 #297
          TestNoSeriesManual;
          "No. Series" := '';
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bill-to Customer No."(Field 4).OnValidate". Please convert manually.

        //trigger "(Field 4)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (xRec."Bill-to Customer No." <> "Bill-to Customer No.") AND
           (xRec."Bill-to Customer No." <> '')
        THEN BEGIN
          IF HideValidationDialog OR NOT GUIALLOWED THEN
            Confirmed := TRUE
          else
            Confirmed := CONFIRM(Text005,FALSE,FIELDCAPTION("Bill-to Customer No."));
          IF Confirmed THEN BEGIN
            ServLine.SETRANGE("Document Type","Document Type");
            ServLine.SETRANGE("Document No.","No.");
            IF "Document Type" = "Document Type"::Order THEN
              ServLine.SETFILTER("Quantity Shipped",'<>0')
            else
              IF "Document Type" = "Document Type"::Invoice THEN
                ServLine.SETFILTER("Shipment No.",'<>%1','');

            IF ServLine.FINDFIRST THEN
              IF "Document Type" = "Document Type"::Order THEN
                ServLine.TESTFIELD("Quantity Shipped",0)
              else
                ServLine.TESTFIELD("Shipment No.",'');
            ServLine.RESET
          end else
            "Bill-to Customer No." := xRec."Bill-to Customer No.";
        end;

        GetCust("Bill-to Customer No.");
        Cust.CheckBlockedCustOnDocs(Cust,"Document Type",FALSE,FALSE);
        Cust.TESTFIELD("Customer Posting Group");

        IF GUIALLOWED AND NOT HideValidationDialog AND
           ("Document Type" IN ["Document Type"::Quote,"Document Type"::Order,"Document Type"::Invoice])
        THEN
          CustCheckCreditLimit.ServiceHeaderCheck(Rec);

        "Bill-to Name" := Cust.Name;
        "Bill-to Name 2" := Cust."Name 2";
        "Bill-to Address" := Cust.Address;
        "Bill-to Address 2" := Cust."Address 2";
        "Bill-to City" := Cust.City;
        "Bill-to Post Code" := Cust."Post Code";
        "Bill-to County" := Cust.County;
        "Bill-to Country/Region Code" := Cust."Country/Region Code";
        IF NOT SkipBillToContact THEN
          "Bill-to Contact" := Cust.Contact;
        "Payment Terms Code" := Cust."Payment Terms Code";

        IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
          "Payment Method Code" := '';
          IF PaymentTerms.GET("Payment Terms Code") THEN
            IF PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN
              "Payment Method Code" := Cust."Payment Method Code"
        end else
          "Payment Method Code" := Cust."Payment Method Code";
        GLSetup.GET;
        IF GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." THEN BEGIN
          "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
          "VAT Registration No." := Cust."VAT Registration No.";
          "VAT Country/Region Code" := Cust."Country/Region Code";
          "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
        end;
        "Customer Posting Group" := Cust."Customer Posting Group";
        "Currency Code" := Cust."Currency Code";
        "Customer Price Group" := Cust."Customer Price Group";
        "Prices Including VAT" := Cust."Prices Including VAT";
        "Allow Line Disc." := Cust."Allow Line Disc.";
        "Invoice Disc. Code" := Cust."Invoice Disc. Code";
        "Customer Disc. Group" := Cust."Customer Disc. Group";
        "Language Code" := Cust."Language Code";
        "Salesperson Code" := Cust."Salesperson Code";
        Reserve := Cust.Reserve;
        ValidateServPriceGrOnServItem;

        IF "Bill-to Customer No." = xRec."Bill-to Customer No." THEN
          IF ShippedServLinesExist THEN BEGIN
            TESTFIELD("Customer Disc. Group",xRec."Customer Disc. Group");
            TESTFIELD("Currency Code",xRec."Currency Code");
          end;

        CreateDim(
          DATABASE::"Service Order Type","Service Order Type",
          DATABASE::Customer,"Bill-to Customer No.",
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Service Contract Header","Contract No.");

        VALIDATE("Payment Terms Code");
        VALIDATE("Payment Method Code");
        VALIDATE("Currency Code");

        IF (xRec."Customer No." = "Customer No.") AND
           (xRec."Bill-to Customer No." <> "Bill-to Customer No.")
        THEN
          RecreateServLines(FIELDCAPTION("Bill-to Customer No."));

        IF NOT SkipBillToContact THEN
          UpdateBillToCont("Bill-to Customer No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (xRec."Bill-to Customer No." <> "Bill-to Customer No.") and
           (xRec."Bill-to Customer No." <> '')
        then begin
          if HideValidationDialog or not GUIALLOWED then
            Confirmed := true
          else
            Confirmed := CONFIRM(Text005,false,FIELDCAPTION("Bill-to Customer No."));
          if Confirmed then begin
            ServLine.SETRANGE("Document Type","Document Type");
            ServLine.SETRANGE("Document No.","No.");
            if "Document Type" = "Document Type"::Order then
              ServLine.SETFILTER("Quantity Shipped",'<>0')
            else
              if "Document Type" = "Document Type"::Invoice then
                ServLine.SETFILTER("Shipment No.",'<>%1','');

            if ServLine.FINDFIRST then
              if "Document Type" = "Document Type"::Order then
                ServLine.TESTFIELD("Quantity Shipped",0)
              else
                ServLine.TESTFIELD("Shipment No.",'');
            ServLine.RESET
          end else
            "Bill-to Customer No." := xRec."Bill-to Customer No.";
        end;

        GetCust("Bill-to Customer No.");
        Cust.CheckBlockedCustOnDocs(Cust,"Document Type",false,false);
        // <<DITW15.00.00.35 DDR 21/04/2009 - 21/09/2009 - 23/09/2009
        //Cust.TESTFIELD("Customer Posting Group");
        "Customer Posting Group" :=
          ServPostJnl.GetSourcePostGroupService(Cust."No.","DIT Sub-Contract Type");
        if "Customer Posting Group" = '' then begin
          Cust.TESTFIELD("Customer Posting Group");
          "Customer Posting Group" := Cust."Customer Posting Group";
        end;
        // >>DITW15.00.00.35 DDR
        // <<DITW15.00.00.35 DDR 10/04/2009 - 04/09/2009 - 21/09/2009 - DITW15.00.00.37 DDR 28/01/2010
        if DitServSetup.READPERMISSION and
          // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
          ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") and
          ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::PlantMaintenance)
          // >>DITW16.00.00.41 DDR DIT-715 #297
        then begin
          DitServSetup.GET;
          if ("Building No." <> Cust."Building No.") and
             (Cust."Building No." <> '') and
             (DitServSetup."Bill-to/Sell-to Building Dim." = DitServSetup."Bill-to/Sell-to Building Dim."::"Bill-to")
          then begin
            if Cust."Building No." <> '' then begin
              Building.GET(Cust."Building No.");
              Building.TESTFIELD(Blocked,false);
              "Building No." := Cust."Building No.";
            end;
          end;
        end;
        // >>DITW15.00.00.37 DDR

        if GUIALLOWED and not HideValidationDialog and
           ("Document Type" in ["Document Type"::Quote,"Document Type"::Order,"Document Type"::Invoice])
        then
        #34..43
        if not SkipBillToContact then
        #45..47
        if "Document Type" = "Document Type"::"Credit Memo" then begin
          "Payment Method Code" := '';
          if PaymentTerms.GET("Payment Terms Code") then
            if PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then
              "Payment Method Code" := Cust."Payment Method Code"
        end else
          "Payment Method Code" := Cust."Payment Method Code";
        GLSetup.GET;
        if GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." then begin
        #57..60
        end;
        // <<DITW15.00.00.35 DDR 21/04/2009
        // "Customer Posting Group" := Cust."Customer Posting Group";
        // >>DITW15.00.00.35 DDR
        #63..73
        if "Bill-to Customer No." = xRec."Bill-to Customer No." then
          if ShippedServLinesExist then begin
            TESTFIELD("Customer Disc. Group",xRec."Customer Disc. Group");
            TESTFIELD("Currency Code",xRec."Currency Code");
          end;
        #79..84
          DATABASE::"Service Contract Header","Contract No.",
          // <<DITW15.00.00.35 DDR 10/04/2009
          DATABASE::Building,"Building No.");
          // >>DITW15.00.00.35 DDR

        // <<DITW15.00.00.35 DDR 02/10/2009 - DITW15.00.00.37 DDR 28/01/2010
        if DitServSetup.READPERMISSION and
          // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
          ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") and
          ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::PlantMaintenance)
          // >>DITW16.00.00.41 DDR DIT-715 #297
        then begin
          DitServSetup.GET;
          if DitServSetup."Bill-to/Sell-to Building Dim." = DitServSetup."Bill-to/Sell-to Building Dim."::"Sell-to" then
            VALIDATE("Building No.");
        end;
        // >>DITW15.00.00.37 DDR
        #86..90
        if (xRec."Customer No." = "Customer No.") and
           (xRec."Bill-to Customer No." <> "Bill-to Customer No.")
        then
          RecreateServLines(FIELDCAPTION("Bill-to Customer No."));

        if not SkipBillToContact then
          UpdateBillToCont("Bill-to Customer No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Bill-to City"(Field 9).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Bill-to City","Bill-to Post Code","Bill-to County","Bill-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Bill-to City","Bill-to Post Code","Bill-to County","Bill-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Ship-to Code"(Field 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Ship-to Code" <> xRec."Ship-to Code") AND
           ("Customer No." = xRec."Customer No.")
        THEN BEGIN
          IF ("Contract No." <> '') AND NOT HideValidationDialog THEN
            ERROR(
              Text003,
              FIELDCAPTION("Ship-to Code"),
              "Document Type",FIELDCAPTION("No."),"No.",
              FIELDCAPTION("Contract No."),"Contract No.");
          IF ServItemLineExists THEN BEGIN
            IF NOT
               CONFIRM(
                 Text004,
                 FALSE,FIELDCAPTION("Ship-to Code"))
            THEN BEGIN
              "Ship-to Code" := xRec."Ship-to Code";
              EXIT;
            end;
          end else
            IF ServLineExists THEN
              IF NOT
                 CONFIRM(
                   Text057,
                   FALSE,FIELDCAPTION("Ship-to Code"))
              THEN BEGIN
                "Ship-to Code" := xRec."Ship-to Code";
                EXIT;
              end;
        end;

        IF "Document Type" <> "Document Type"::"Credit Memo" THEN
          IF "Ship-to Code" <> '' THEN BEGIN
            IF xRec."Ship-to Code" <> '' THEN BEGIN
              GetCust("Customer No.");
              IF Cust."Location Code" <> '' THEN
                "Location Code" := Cust."Location Code";
              "Tax Area Code" := Cust."Tax Area Code";
            end;
            ShiptoAddr.GET("Customer No.","Ship-to Code");
            "Ship-to Name" := ShiptoAddr.Name;
            "Ship-to Name 2" := ShiptoAddr."Name 2";
            "Ship-to Address" := ShiptoAddr.Address;
            "Ship-to Address 2" := ShiptoAddr."Address 2";
            "Ship-to City" := ShiptoAddr.City;
            "Ship-to Post Code" := ShiptoAddr."Post Code";
            "Ship-to County" := ShiptoAddr.County;
            VALIDATE("Ship-to Country/Region Code",ShiptoAddr."Country/Region Code");
            "Ship-to Contact" := ShiptoAddr.Contact;
            "Ship-to Phone" := ShiptoAddr."Phone No.";
            IF ShiptoAddr."Location Code" <> '' THEN
              "Location Code" := ShiptoAddr."Location Code";
            "Ship-to Fax No." := ShiptoAddr."Fax No.";
            "Ship-to E-Mail" := ShiptoAddr."E-Mail";
            IF ShiptoAddr."Tax Area Code" <> '' THEN
              "Tax Area Code" := ShiptoAddr."Tax Area Code";
            "Tax Liable" := ShiptoAddr."Tax Liable";
          end else
            IF "Customer No." <> '' THEN BEGIN
              GetCust("Customer No.");
              "Ship-to Name" := Cust.Name;
              "Ship-to Name 2" := Cust."Name 2";
              "Ship-to Address" := Cust.Address;
              "Ship-to Address 2" := Cust."Address 2";
              "Ship-to City" := Cust.City;
              "Ship-to Post Code" := Cust."Post Code";
              "Ship-to County" := Cust.County;
              VALIDATE("Ship-to Country/Region Code",Cust."Country/Region Code");
              "Ship-to Contact" := Cust.Contact;
              "Ship-to Phone" := Cust."Phone No.";
              "Tax Area Code" := Cust."Tax Area Code";
              "Tax Liable" := Cust."Tax Liable";
              IF Cust."Location Code" <> '' THEN
                "Location Code" := Cust."Location Code";
              "Ship-to Fax No." := Cust."Fax No.";
              "Ship-to E-Mail" := Cust."E-Mail";
            end;

        IF (xRec."Customer No." = "Customer No.") AND
           (xRec."Ship-to Code" <> "Ship-to Code")
        THEN
          IF (xRec."VAT Country/Region Code" <> "VAT Country/Region Code") OR
             (xRec."Tax Area Code" <> "Tax Area Code")
          THEN
            RecreateServLines(FIELDCAPTION("Ship-to Code"))
          else BEGIN
            IF xRec."Tax Liable" <> "Tax Liable" THEN
              VALIDATE("Tax Liable");
          end;

        VALIDATE("Service Zone Code");

        IF ("Ship-to Code" <> xRec."Ship-to Code") AND
           ("Customer No." = xRec."Customer No.")
        THEN BEGIN
          MODIFY(TRUE);
          ServLine.LOCKTABLE;
          ServItemLine.LOCKTABLE;
          ServLine.RESET;
          ServLine.SETRANGE("Document Type","Document Type");
          ServLine.SETRANGE("Document No.","No.");
          ServLine.DELETEALL(TRUE);
          ServItemLine.RESET;
          ServItemLine.SETRANGE("Document Type","Document Type");
          ServItemLine.SETRANGE("Document No.","No.");
          ServItemLine.DELETEALL(TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Ship-to Code" <> xRec."Ship-to Code") and
           ("Customer No." = xRec."Customer No.")
        then begin
          if ("Contract No." <> '') and not HideValidationDialog then
        #5..9
          if ServItemLineExists then begin
            if not
               CONFIRM(
                 Text004,
                 false,FIELDCAPTION("Ship-to Code"))
            then begin
              "Ship-to Code" := xRec."Ship-to Code";
              exit;
            end;
          end else
            if ServLineExists then
              if not
                 CONFIRM(
                   Text057,
                   false,FIELDCAPTION("Ship-to Code"))
              then begin
                "Ship-to Code" := xRec."Ship-to Code";
                exit;
              end;
        end;

        if "Document Type" <> "Document Type"::"Credit Memo" then
          if "Ship-to Code" <> '' then begin
            if xRec."Ship-to Code" <> '' then begin
              //<<FINXL8.00.001 BSA 29/06/2015 #177
              if recFinXLSetup.READPERMISSION then
                GetCust("Ship-to Customer No.")
              else
              //>>FINXL8.00.001 BSA 29/06/2015 #177
                GetCust("Customer No.");
              if Cust."Location Code" <> '' then
                "Location Code" := Cust."Location Code";
              "Tax Area Code" := Cust."Tax Area Code";
            end;
            //<<FINXL8.00.001 BSA 29/06/2015 #177
            if recFinXLSetup.READPERMISSION then
              ShiptoAddr.GET("Ship-to Customer No.","Ship-to Code")
            else
            //>>FINXL8.00.001 BSA 29/06/2015 #177
              ShiptoAddr.GET("Customer No.","Ship-to Code");
        #40..49
            if ShiptoAddr."Location Code" <> '' then
        #51..53
            if ShiptoAddr."Tax Area Code" <> '' then
              "Tax Area Code" := ShiptoAddr."Tax Area Code";
            "Tax Liable" := ShiptoAddr."Tax Liable";
            // <<DITW15.00.00.38 DDR 11/08/2010 #1217
            "Transaction Type" := ShiptoAddr."Transaction Type";
            "Transport Method" := ShiptoAddr."Transport Method";
            "Transaction Specification" := ShiptoAddr."Transaction Specification";
            "Exit Point" := ShiptoAddr."Exit Point";
            Area := ShiptoAddr.Area;
            // >>DITW15.00.00.38 DDR
          end else
            //<<FINXL8.00.001 BSA 29/06/2015 #177
            //IF "Customer No." <> '' THEN BEGIN
              //GetCust("Customer No.");
            if "Ship-to Customer No." <> '' then begin
              GetCust("Ship-to Customer No.");
            //>>FINXL8.00.001 BSA 29/06/2015 #177
        #60..71
              if Cust."Location Code" <> '' then
        #73..75
              // <<DITW15.00.00.38 DDR 11/08/2010 #1217
              "Transaction Type" := Cust."Transaction Type";
              "Transport Method" := Cust."Transport Method";
              "Transaction Specification" := Cust."Transaction Specification";
              "Exit Point" := Cust."Exit Point";
              Area := Cust.Area;
              // >>DITW15.00.00.38 DDR
            end;

        if (xRec."Customer No." = "Customer No.") and
           (xRec."Ship-to Code" <> "Ship-to Code")
        then
          if (xRec."VAT Country/Region Code" <> "VAT Country/Region Code") or
             (xRec."Tax Area Code" <> "Tax Area Code")
          then
            RecreateServLines(FIELDCAPTION("Ship-to Code"))
          else begin
            if xRec."Tax Liable" <> "Tax Liable" then
              VALIDATE("Tax Liable");
          end;
        #89..91
        if ("Ship-to Code" <> xRec."Ship-to Code") and
           ("Customer No." = xRec."Customer No.")
        then begin
          MODIFY(true);
        #96..100
          ServLine.DELETEALL(true);
        #102..104
          ServItemLine.DELETEALL(true);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Ship-to City"(Field 17).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Ship-to City","Ship-to Post Code","Ship-to County","Ship-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Ship-to City","Ship-to Post Code","Ship-to County","Ship-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Order Date"(Field 19).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Order Date" <> xRec."Order Date" THEN BEGIN
          IF ("Order Date" > "Starting Date") AND
             ("Starting Date" <> 0D)
          THEN
            ERROR(Text007,FIELDCAPTION("Order Date"),FIELDCAPTION("Starting Date"));

          IF ("Order Date" > "Finishing Date") AND
             ("Finishing Date" <> 0D)
          THEN
            ERROR(Text007,FIELDCAPTION("Order Date"),FIELDCAPTION("Finishing Date"));

          IF "Starting Time" <> 0T THEN
            VALIDATE("Starting Time");
          ServItemLine.RESET;
          ServItemLine.SETCURRENTKEY("Document Type","Document No.","Starting Date");
          ServItemLine.SETRANGE("Document Type","Document Type");
          ServItemLine.SETRANGE("Document No.","No.");
          ServItemLine.SETFILTER("Starting Date",'<>%1',0D);
          IF ServItemLine.FIND('-') THEN
            REPEAT
              IF ServItemLine."Starting Date" < "Order Date" THEN
                ERROR(
                  Text027,FIELDCAPTION("Order Date"),
                  ServItemLine.FIELDCAPTION("Starting Date"));
            UNTIL ServItemLine.NEXT = 0;

          ServItemLine.RESET;
          ServItemLine.SETRANGE("Document Type","Document Type");
          ServItemLine.SETRANGE("Document No.","No.");
          IF ServItemLine.FIND('-') THEN
            REPEAT
              ServItemLine.CheckWarranty("Order Date");
              ServItemLine.CalculateResponseDateTime("Order Date","Order Time");
              ServItemLine.MODIFY;
            UNTIL ServItemLine.NEXT = 0;
          UpdateServLines(FIELDCAPTION("Order Date"),FALSE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Order Date" <> xRec."Order Date" then begin
          if ("Order Date" > "Starting Date") and
             ("Starting Date" <> 0D)
          then
            ERROR(Text007,FIELDCAPTION("Order Date"),FIELDCAPTION("Starting Date"));

          if ("Order Date" > "Finishing Date") and
             ("Finishing Date" <> 0D)
          then
            ERROR(Text007,FIELDCAPTION("Order Date"),FIELDCAPTION("Finishing Date"));

          if "Starting Time" <> 000000T then
        #13..18
          if ServItemLine.FIND('-') then
            repeat
              if ServItemLine."Starting Date" < "Order Date" then
        #22..24
            until ServItemLine.NEXT = 0;
        #26..29
          if ServItemLine.FIND('-') then
            repeat
        #32..34
            until ServItemLine.NEXT = 0;
          UpdateServLines(FIELDCAPTION("Order Date"),false);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Posting Date"(Field 20).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Posting No." <> '') AND ("Posting No. Series" <> '') THEN BEGIN
          NoSeries.GET("Posting No. Series");
          IF NoSeries."Date Order" THEN
            ERROR(
              Text045,
              FIELDCAPTION("Posting Date"),FIELDCAPTION("Posting No. Series"),"Posting No. Series",
              NoSeries.FIELDCAPTION("Date Order"),NoSeries."Date Order","Document Type",
              FIELDCAPTION("Posting No."),"Posting No.");
        end;

        VALIDATE("Document Date","Posting Date");

        ServLine.SETRANGE("Document Type","Document Type");
        ServLine.SETRANGE("Document No.","No.");
        IF ServLine.findset THEN
          REPEAT
            IF "Posting Date" <> ServLine."Posting Date" THEN BEGIN
              ServLine."Posting Date" := "Posting Date";
              ServLine.MODIFY;
            end;
          UNTIL ServLine.NEXT = 0;

        IF ("Document Type" IN ["Document Type"::Invoice,"Document Type"::"Credit Memo"]) AND
           NOT ("Posting Date" = xRec."Posting Date")
        THEN BEGIN
          IF ServLineExists THEN
            ServLine.MODIFYALL("Posting Date","Posting Date");
        end;

        IF "Currency Code" <> '' THEN BEGIN
          UpdateCurrencyFactor;
          IF "Currency Factor" <> xRec."Currency Factor" THEN
            ConfirmUpdateCurrencyFactor;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Posting No." <> '') and ("Posting No. Series" <> '') then begin
          NoSeries.GET("Posting No. Series");
          if NoSeries."Date Order" then
        #4..8
        end;
        #10..14
        if ServLine.findset then
          repeat
            if "Posting Date" <> ServLine."Posting Date" then begin
              ServLine."Posting Date" := "Posting Date";
              ServLine.MODIFY;
            end;
          until ServLine.NEXT = 0;

        if ("Document Type" in ["Document Type"::Invoice,"Document Type"::"Credit Memo"]) and
           not ("Posting Date" = xRec."Posting Date")
        then begin
          if ServLineExists then
            ServLine.MODIFYALL("Posting Date","Posting Date");
        end;

        if "Currency Code" <> '' then begin
          UpdateCurrencyFactor;
          if "Currency Factor" <> xRec."Currency Factor" then
            ConfirmUpdateCurrencyFactor;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Terms Code"(Field 23).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
          PaymentTerms.GET("Payment Terms Code");
          IF ("Document Type" IN ["Document Type"::"Credit Memo"]) AND
             NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos"
          THEN BEGIN
            VALIDATE("Due Date","Document Date");
            VALIDATE("Pmt. Discount Date",0D);
            VALIDATE("Payment Discount %",0);
          end else BEGIN
            "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");
            "Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation","Document Date");
            VALIDATE("Payment Discount %",PaymentTerms."Discount %")
          end;
        end else BEGIN
          VALIDATE("Due Date","Document Date");
          VALIDATE("Pmt. Discount Date",0D);
          VALIDATE("Payment Discount %",0);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Payment Terms Code" <> '') and ("Document Date" <> 0D) then begin
          PaymentTerms.GET("Payment Terms Code");
          if ("Document Type" in ["Document Type"::"Credit Memo"]) and
             not PaymentTerms."Calc. Pmt. Disc. on Cr. Memos"
          then begin
        #6..8
          end else begin
        #10..12
          end;
        end else begin
        #15..17
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Discount %"(Field 25).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GLSetup.GET;
        IF "Payment Discount %" < GLSetup."VAT Tolerance %" THEN
          "VAT Base Discount %" := "Payment Discount %"
        else
          "VAT Base Discount %" := GLSetup."VAT Tolerance %";
        VALIDATE("VAT Base Discount %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GLSetup.GET;
        if "Payment Discount %" < GLSetup."VAT Tolerance %" then
          "VAT Base Discount %" := "Payment Discount %"
        else
          "VAT Base Discount %" := GLSetup."VAT Tolerance %";
        VALIDATE("VAT Base Discount %");
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Field 28).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Location Code" <> xRec."Location Code") AND
           ("Customer No." = xRec."Customer No.")
        THEN
          MessageIfServLinesExist(FIELDCAPTION("Location Code"));

        UpdateShipToAddress;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW18.00.06 MSF 01/03/2015 DIT-770 #1193
        if ("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> xRec."Location Code") and
          ("Location Code" <> '')
        then begin
          Location.GET("Location Code");
          VALIDATE("Responsibility Center",UserSetupMgt.GetFirstRespCenter(2,Location."Physical Location Group Code","Location Code"));
        end;
        if (("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> '')) or
          ("Responsibility Center" <> xRec."Responsibility Center")
        then
          if not UserSetupMgt.CheckLocation(2,"Location Code","Responsibility Center") then
            ERROR(
              Text2014412,
              Location.TABLECAPTION,"Location Code",
              RespCenter.TABLECAPTION,UserSetupMgt.GetServiceFilter);
        // >>DITW18.00.06 MSF 01/03/2015 DIT-770 #1193

        if ("Location Code" <> xRec."Location Code") and
           ("Customer No." = xRec."Customer No.")
        then
        #4..6
        // <<DITW18.00.06 MSF 01/03/2015 DIT-770 #1193
        if "Location Code" <> '' then begin
          Location.GET("Location Code");
          if Location."Physical Location Group Code" <> "Physical Location Group Code" then
            "Physical Location Group Code" := Location."Physical Location Group Code";
        end else
          if xRec."Physical Location Group Code" = "Physical Location Group Code" then
            "Physical Location Group Code" := '';
        if xRec."Physical Location Group Code" = "Physical Location Group Code" then
          VALIDATE("Physical Location Group Code");
        // >>DITW18.00.06 MSF 01/03/2015 DIT-770 #1193
        */
        //end;


        //Unsupported feature: CodeModification on ""Currency Code"(Field 32).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo <> FIELDNO("Currency Code") THEN
          UpdateCurrencyFactor
        else
          IF "Currency Code" <> xRec."Currency Code" THEN BEGIN
            IF ServLineExists AND ("Contract No." <> '') AND
               ("Document Type" IN ["Document Type"::Invoice,"Document Type"::"Credit Memo"])
            THEN
              ERROR(Text058,FIELDCAPTION("Currency Code"),"Document Type","No.","Contract No.");

            UpdateCurrencyFactor;
            ValidateServPriceGrOnServItem;
            RecreateServLines(FIELDCAPTION("Currency Code"));
          end else
            IF "Currency Code" <> '' THEN BEGIN
              UpdateCurrencyFactor;
              IF "Currency Factor" <> xRec."Currency Factor" THEN
                ConfirmUpdateCurrencyFactor;
            end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo <> FIELDNO("Currency Code") then
          UpdateCurrencyFactor
        else
          if "Currency Code" <> xRec."Currency Code" then begin
            if ServLineExists and ("Contract No." <> '') and
               ("Document Type" in ["Document Type"::Invoice,"Document Type"::"Credit Memo"])
            then
        #8..12
          end else
            if "Currency Code" <> '' then begin
              UpdateCurrencyFactor;
              if "Currency Factor" <> xRec."Currency Factor" then
                ConfirmUpdateCurrencyFactor;
            end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Currency Factor"(Field 33).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Currency Factor" <> xRec."Currency Factor" THEN
          UpdateServLines(FIELDCAPTION("Currency Factor"),FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Currency Factor" <> xRec."Currency Factor" then
          UpdateServLines(FIELDCAPTION("Currency Factor"),false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Prices Including VAT"(Field 35).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Prices Including VAT" <> xRec."Prices Including VAT" THEN BEGIN
          TESTFIELD("Max. Labor Unit Price",0);
          ServLine.SETRANGE("Document Type","Document Type");
          ServLine.SETRANGE("Document No.","No.");
          ServLine.SETFILTER(Type,'>0');
          ServLine.SETFILTER(Quantity,'<>0');
          IF ServLine.FIND('-') THEN
            REPEAT
              ServLine.Amount := 0;
              ServLine."Amount Including VAT" := 0;
              ServLine."VAT Base Amount" := 0;
              ServLine.InitOutstandingAmount;
              ServLine.MODIFY;
            UNTIL ServLine.NEXT = 0;
          ServLine.SETRANGE(Type);
          ServLine.SETRANGE(Quantity);

          ServLine.SETFILTER("Unit Price",'<>%1',0);
          ServLine.SETFILTER("VAT %",'<>%1',0);
          IF ServLine.FIND('-') THEN BEGIN
            RecalculatePrice :=
              CONFIRM(
                STRSUBSTNO(
                  Text055,
                  FIELDCAPTION("Prices Including VAT"),ServLine.FIELDCAPTION("Unit Price")),
                TRUE);
            ServLine.SetServHeader(Rec);

            IF "Currency Code" = '' THEN
              Currency.InitRoundingPrecision
            else
              Currency.GET("Currency Code");

            REPEAT
              ServLine.TESTFIELD("Quantity Invoiced",0);
              IF NOT RecalculatePrice THEN BEGIN
                ServLine."VAT Difference" := 0;
                ServLine.InitOutstandingAmount;
              end else
                IF "Prices Including VAT" THEN BEGIN
                  ServLine."Unit Price" :=
                    ROUND(
                      ServLine."Unit Price" * (1 + (ServLine."VAT %" / 100)),
                      Currency."Unit-Amount Rounding Precision");
                  IF ServLine.Quantity <> 0 THEN BEGIN
                    ServLine."Line Discount Amount" :=
                      ROUND(
                        ServLine.CalcChargeableQty * ServLine."Unit Price" * ServLine."Line Discount %" / 100,
                        Currency."Amount Rounding Precision");
                    ServLine.VALIDATE("Inv. Discount Amount",
                      ROUND(
                        ServLine."Inv. Discount Amount" * (1 + (ServLine."VAT %" / 100)),
                        Currency."Amount Rounding Precision"));
                  end;
                end else BEGIN
                  ServLine."Unit Price" :=
                    ROUND(
                      ServLine."Unit Price" / (1 + (ServLine."VAT %" / 100)),
                      Currency."Unit-Amount Rounding Precision");
                  IF ServLine.Quantity <> 0 THEN BEGIN
                    ServLine."Line Discount Amount" :=
                      ROUND(
                        ServLine.CalcChargeableQty * ServLine."Unit Price" * ServLine."Line Discount %" / 100,
                        Currency."Amount Rounding Precision");
                    ServLine.VALIDATE("Inv. Discount Amount",
                      ROUND(
                        ServLine."Inv. Discount Amount" / (1 + (ServLine."VAT %" / 100)),
                        Currency."Amount Rounding Precision"));
                  end;
                end;
              ServLine.MODIFY;
            UNTIL ServLine.NEXT = 0;
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Prices Including VAT" <> xRec."Prices Including VAT" then begin
        #2..6
          if ServLine.FIND('-') then
            repeat
        #9..13
            until ServLine.NEXT = 0;
        #15..19
          if ServLine.FIND('-') then begin
        #21..25
                true);
            ServLine.SetServHeader(Rec);

            if "Currency Code" = '' then
              Currency.InitRoundingPrecision
            else
              Currency.GET("Currency Code");

            repeat
              ServLine.TESTFIELD("Quantity Invoiced",0);
              if not RecalculatePrice then begin
                ServLine."VAT Difference" := 0;
                ServLine.InitOutstandingAmount;
              end else
                if "Prices Including VAT" then begin
        #41..44
                  if ServLine.Quantity <> 0 then begin
        #46..53
                  end;
                end else begin
        #56..59
                  if ServLine.Quantity <> 0 then begin
        #61..68
                  end;
                end;
              ServLine.MODIFY;
            until ServLine.NEXT = 0;
          end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Salesperson Code"(Field 43).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CreateDim(
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::Customer,"Bill-to Customer No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Service Order Type","Service Order Type",
          DATABASE::"Service Contract Header","Contract No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
          DATABASE::"Service Contract Header","Contract No.",
          // <<DITW15.00.00.35 DDR 10/04/2009
          DATABASE::Building,"Building No.");
          // >>DITW15.00.00.35 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-to Doc. No."(Field 53).OnLookup". Please convert manually.

        //trigger  No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Bal. Account No.",'');
        CustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive,"Due Date");
        CustLedgEntry.SETRANGE("Customer No.","Bill-to Customer No.");
        CustLedgEntry.SETRANGE(Open,TRUE);
        IF "Applies-to Doc. No." <> '' THEN BEGIN
          CustLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          CustLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          IF CustLedgEntry.FINDFIRST THEN;
          CustLedgEntry.SETRANGE("Document Type");
          CustLedgEntry.SETRANGE("Document No.");
        end else
          IF "Applies-to Doc. Type" <> 0 THEN BEGIN
            CustLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
            IF CustLedgEntry.FINDFIRST THEN
              CustLedgEntry.SETRANGE("Document Type");
          end;

        ApplyCustEntries.SetService(Rec,CustLedgEntry,ServHeader.FIELDNO("Applies-to Doc. No."));
        ApplyCustEntries.SETTABLEVIEW(CustLedgEntry);
        ApplyCustEntries.SETRECORD(CustLedgEntry);
        ApplyCustEntries.LOOKUPMODE(TRUE);
        IF ApplyCustEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
          ApplyCustEntries.GetCustLedgEntry(CustLedgEntry);
          GenJnlApply.CheckAgainstApplnCurrency(
            "Currency Code",CustLedgEntry."Currency Code",GenJnlLine."Account Type"::Customer,TRUE);
          "Applies-to Doc. Type" := CustLedgEntry."Document Type";
          "Applies-to Doc. No." := CustLedgEntry."Document No.";
        end;
        CLEAR(ApplyCustEntries);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        CustLedgEntry.SETRANGE(Open,true);
        if "Applies-to Doc. No." <> '' then begin
          CustLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          CustLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          if CustLedgEntry.FINDFIRST then;
          CustLedgEntry.SETRANGE("Document Type");
          CustLedgEntry.SETRANGE("Document No.");
        end else
          if "Applies-to Doc. Type" <> 0 then begin
            CustLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
            if CustLedgEntry.FINDFIRST then
              CustLedgEntry.SETRANGE("Document Type");
          end;
        #17..20
        ApplyCustEntries.LOOKUPMODE(true);
        if ApplyCustEntries.RUNMODAL = ACTION::LookupOK then begin
          ApplyCustEntries.GetCustLedgEntry(CustLedgEntry);
          GenJnlApply.CheckAgainstApplnCurrency(
            "Currency Code",CustLedgEntry."Currency Code",GenJnlLine."Account Type"::Customer,true);
          "Applies-to Doc. Type" := CustLedgEntry."Document Type";
          "Applies-to Doc. No." := CustLedgEntry."Document No.";
        end;
        CLEAR(ApplyCustEntries);
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-to Doc. No."(Field 53).OnValidate". Please convert manually.

        //trigger  No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Applies-to Doc. No." <> '' THEN
          TESTFIELD("Bal. Account No.",'');

        IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND (xRec."Applies-to Doc. No." <> '') AND
           ("Applies-to Doc. No." <> '')
        THEN BEGIN
          SetAmountToApply("Applies-to Doc. No.","Customer No.");
          SetAmountToApply(xRec."Applies-to Doc. No.","Customer No.");
        end else
          IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND (xRec."Applies-to Doc. No." = '') THEN
            SetAmountToApply("Applies-to Doc. No.","Customer No.")
          else
            IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND ("Applies-to Doc. No." = '') THEN
              SetAmountToApply(xRec."Applies-to Doc. No.","Customer No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Applies-to Doc. No." <> '' then
          TESTFIELD("Bal. Account No.",'');

        if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." <> '') and
           ("Applies-to Doc. No." <> '')
        then begin
          SetAmountToApply("Applies-to Doc. No.","Customer No.");
          SetAmountToApply(xRec."Applies-to Doc. No.","Customer No.");
        end else
          if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." = '') then
            SetAmountToApply("Applies-to Doc. No.","Customer No.")
          else
            if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and ("Applies-to Doc. No." = '') then
              SetAmountToApply(xRec."Applies-to Doc. No.","Customer No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. Account No."(Field 55).OnValidate". Please convert manually.

        //trigger  Account No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bal. Account No." <> '' THEN
          CASE "Bal. Account Type" OF
            "Bal. Account Type"::"G/L Account":
              BEGIN
                GLAcc.GET("Bal. Account No.");
                GLAcc.CheckGLAcc;
                GLAcc.TESTFIELD("Direct Posting",TRUE);
              end;
            "Bal. Account Type"::"Bank Account":
              BEGIN
                BankAcc.GET("Bal. Account No.");
                BankAcc.TESTFIELD(Blocked,FALSE);
                BankAcc.TESTFIELD("Currency Code","Currency Code");
              end;
          end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bal. Account No." <> '' then
          case "Bal. Account Type" of
            "Bal. Account Type"::"G/L Account":
              begin
                GLAcc.GET("Bal. Account No.");
                GLAcc.CheckGLAcc;
                GLAcc.TESTFIELD("Direct Posting",true);
              end;
            "Bal. Account Type"::"Bank Account":
              begin
                BankAcc.GET("Bal. Account No.");
                BankAcc.TESTFIELD(Blocked,false);
                BankAcc.TESTFIELD("Currency Code","Currency Code");
              end;
          end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Bus. Posting Group"(Field 74).OnValidate". Please convert manually.

        //trigger  Bus();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Gen. Bus. Posting Group" <> xRec."Gen. Bus. Posting Group" THEN BEGIN
          IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
            "VAT Bus. Posting Group" := GenBusPostingGrp."Def. VAT Bus. Posting Group";
          RecreateServLines(FIELDCAPTION("Gen. Bus. Posting Group"));
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Gen. Bus. Posting Group" <> xRec."Gen. Bus. Posting Group" then begin
          if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") then
            "VAT Bus. Posting Group" := GenBusPostingGrp."Def. VAT Bus. Posting Group";
          RecreateServLines(FIELDCAPTION("Gen. Bus. Posting Group"));
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Transaction Type"(Field 76).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdateServLines(FIELDCAPTION("Transaction Type"),FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdateServLines(FIELDCAPTION("Transaction Type"),false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Transport Method"(Field 77).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdateServLines(FIELDCAPTION("Transport Method"),FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdateServLines(FIELDCAPTION("Transport Method"),false);
        */
        //end;


        //Unsupported feature: CodeModification on "City(Field 83).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        UpdateShipToAddressFromGeneralAddress(FIELDNO("Ship-to City"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        UpdateShipToAddressFromGeneralAddress(FIELDNO("Ship-to City"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Bill-to Post Code"(Field 85).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Bill-to City","Bill-to Post Code","Bill-to County","Bill-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Bill-to City","Bill-to Post Code","Bill-to County","Bill-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Post Code"(Field 88).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        UpdateShipToAddressFromGeneralAddress(FIELDNO("Ship-to Post Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        UpdateShipToAddressFromGeneralAddress(FIELDNO("Ship-to Post Code"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Ship-to Post Code"(Field 91).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Ship-to City","Ship-to Post Code","Ship-to County","Ship-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Ship-to City","Ship-to Post Code","Ship-to County","Ship-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Ship-to Country/Region Code"(Field 93).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Ship-to Country/Region Code" <> '' THEN
          "VAT Country/Region Code" := "Ship-to Country/Region Code"
        else
          "VAT Country/Region Code" := "Country/Region Code"
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Ship-to Country/Region Code" <> '' then
          "VAT Country/Region Code" := "Ship-to Country/Region Code"
        else
          "VAT Country/Region Code" := "Country/Region Code"
        */
        //end;


        //Unsupported feature: CodeModification on ""Exit Point"(Field 97).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdateServLines(FIELDCAPTION("Exit Point"),FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdateServLines(FIELDCAPTION("Exit Point"),false);
        */
        //end;


        //Unsupported feature: CodeModification on "Area(Field 101).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdateServLines(FIELDCAPTION(Area),FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdateServLines(FIELDCAPTION(Area),false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Transaction Specification"(Field 102).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdateServLines(FIELDCAPTION("Transaction Specification"),FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdateServLines(FIELDCAPTION("Transaction Specification"),false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Method Code"(Field 104).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PaymentMethod.INIT;
        IF "Payment Method Code" <> '' THEN
          PaymentMethod.GET("Payment Method Code");
        "Bal. Account Type" := PaymentMethod."Bal. Account Type";
        "Bal. Account No." := PaymentMethod."Bal. Account No.";

        IF "Bal. Account No." <> '' THEN BEGIN
          TESTFIELD("Applies-to Doc. No.",'');
          TESTFIELD("Applies-to ID",'');
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PaymentMethod.INIT;
        if "Payment Method Code" <> '' then
          PaymentMethod.GET("Payment Method Code");
        // <<DITW18.00.07 MVN 11/03/2016 DIT-770 #1912
        if PaymentMethod."Direct Debit" then begin
          if "Direct Debit Mandate ID" = '' then
            "Direct Debit Mandate ID" := SEPADirectDebitMandate.GetDefaultMandate("Bill-to Customer No.","Due Date");
          if "Payment Terms Code" = '' then
            "Payment Terms Code" := PaymentMethod."Direct Debit Pmt. Terms Code";
        end;
        // >>DITW18.00.07 MVN DIT-770 #1912
        #4..6
        if "Bal. Account No." <> '' then begin
          TESTFIELD("Applies-to Doc. No.",'');
          TESTFIELD("Applies-to ID",'');
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Agent Code"(Field 105).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Release Status","Release Status"::Open);
        IF xRec."Shipping Agent Code" = "Shipping Agent Code" THEN
          EXIT;

        "Shipping Agent Service Code" := '';
        GetShippingTime(FIELDNO("Shipping Agent Code"));
        UpdateServLines(FIELDCAPTION("Shipping Agent Code"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Release Status","Release Status"::Open);
        if xRec."Shipping Agent Code" = "Shipping Agent Code" then
          exit;
        #4..7
        */
        //end;


        //Unsupported feature: CodeModification on ""Posting No. Series"(Field 108).OnLookup". Please convert manually.

        //trigger  Series"(Field 108)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WITH ServHeader DO BEGIN
          ServHeader := Rec;
          ServSetup.GET;
          TestNoSeries;
          IF NoSeriesMgt.LookupSeries(GetPostingNoSeriesCode,"Posting No. Series") THEN
            VALIDATE("Posting No. Series");
          Rec := ServHeader;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        with ServHeader do begin
        #2..4
          if NoSeriesMgt.LookupSeries(GetPostingNoSeriesCode,"Posting No. Series") then
            VALIDATE("Posting No. Series");
          Rec := ServHeader;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Posting No. Series"(Field 108).OnValidate". Please convert manually.

        //trigger  Series"(Field 108)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Posting No. Series" <> '' THEN BEGIN
          ServSetup.GET;
          TestNoSeries;
          NoSeriesMgt.TestSeries(GetPostingNoSeriesCode,"Posting No. Series");
        end;
        TESTFIELD("Posting No.",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Posting No. Series" <> '' then begin
          ServSetup.GET;
          // <<DITW15.00.00.35 DDR 17/04/2009
          // <<DITW18.00.06 DDR 20/04/2015 DIT-770 #1234
          if ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") and DitServSetup.READPERMISSION then
          // >>DITW18.00.06 DDR DIT-770 #1234
            DitServSetup.GET;
          // >>DITW15.00.00.35 DDR
          // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
          if "DIT Sub-Contract Type" = "DIT Sub-Contract Type"::PlantMaintenance then
            PlantMaintSetup.GET;
          // >>DITW16.00.00.41 DDR DIT-715 #297
          TestNoSeries;
          NoSeriesMgt.TestSeries(GetPostingNoSeriesCode,"Posting No. Series");
        end;
        TESTFIELD("Posting No.",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping No. Series"(Field 109).OnValidate". Please convert manually.

        //trigger  Series"(Field 109)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Shipping No. Series" <> '' THEN BEGIN
          ServSetup.GET;
          ServSetup.TESTFIELD("Posted Service Shipment Nos.");
          NoSeriesMgt.TestSeries(ServSetup."Posted Service Shipment Nos.","Shipping No. Series");
        end;
        TESTFIELD("Shipping No.",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Shipping No. Series" <> '' then begin
          ServSetup.GET;
          // <<DITW15.00.00.35 DDR 17/04/2009
          //ServSetup.TESTFIELD("Posted Service Shipment Nos.");
          //NoSeriesMgt.TestSeries(ServSetup."Posted Service Shipment Nos.","Shipping No. Series");

          if ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") then begin
            // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
            if "DIT Sub-Contract Type" = "DIT Sub-Contract Type"::PlantMaintenance then
              PlantMaintSetup.GET;
           // >>DITW16.00.00.41 DDR DIT-715 #297
           // <<DITW18.00.06 DDR 20/04/2015 DIT-770 #1234
           // <<DITW18.00.06 DDR 20/04/2015 DIT-770 #1234
           if DitServSetup.READPERMISSION then
           // >>DITW18.00.06 DDR DIT-770 #1234
              DitServSetup.GET;
            case "DIT Sub-Contract Type" of
              "DIT Sub-Contract Type"::Rent:
                begin
                  DitServSetup.TESTFIELD("Rent Post. Serv. Shipment Nos.");
                  NoSeriesMgt.TestSeries(DitServSetup."Rent Post. Serv. Shipment Nos.","Shipping No. Series");
                end;
              "DIT Sub-Contract Type"::Loan:
                begin
                  DitServSetup.TESTFIELD("Loan Post. Serv. Shipment Nos.");
                  NoSeriesMgt.TestSeries(DitServSetup."Loan Post. Serv. Shipment Nos.","Shipping No. Series");
                end;
              "DIT Sub-Contract Type"::LoanInUse:
                begin
                  DitServSetup.TESTFIELD("LoanU. Pst Serv. Shipment Nos.");
                  NoSeriesMgt.TestSeries(DitServSetup."LoanU. Pst Serv. Shipment Nos.","Shipping No. Series");
                end;
              "DIT Sub-Contract Type"::Maintenance:
                begin
                  DitServSetup.TESTFIELD("Maint. Pst Serv. Shipment Nos.");
                  NoSeriesMgt.TestSeries(DitServSetup."Maint. Pst Serv. Shipment Nos.","Shipping No. Series");
                end;
              "DIT Sub-Contract Type"::Other:
                begin
                  DitServSetup.TESTFIELD("Posted Service Shipment Nos.");
                  NoSeriesMgt.TestSeries(DitServSetup."Posted Service Shipment Nos.","Shipping No. Series");
                end;
              // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
              "DIT Sub-Contract Type"::PlantMaintenance:
                begin
                  PlantMaintSetup.TESTFIELD("Posted Service Shipment Nos.");
                  NoSeriesMgt.TestSeries(PlantMaintSetup."Posted Service Shipment Nos.","Shipping No. Series");
                end;
              // >>DITW16.00.00.41 DDR DIT-715 #297
            end;
          end else begin
            ServSetup.TESTFIELD("Posted Service Shipment Nos.");
            NoSeriesMgt.TestSeries(ServSetup."Posted Service Shipment Nos.","Shipping No. Series");
          end;
          // >>DITW15.00.00.35 DDR
        end;
        TESTFIELD("Shipping No.",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT Bus. Posting Group"(Field 116).OnValidate". Please convert manually.

        //trigger  Posting Group"(Field 116)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "VAT Bus. Posting Group" <> xRec."VAT Bus. Posting Group" THEN
          RecreateServLines(FIELDCAPTION("VAT Bus. Posting Group"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "VAT Bus. Posting Group" <> xRec."VAT Bus. Posting Group" then
          RecreateServLines(FIELDCAPTION("VAT Bus. Posting Group"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-to ID"(Field 118).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Applies-to ID" <> '' THEN
          TESTFIELD("Bal. Account No.",'');
        IF ("Applies-to ID" <> xRec."Applies-to ID") AND (xRec."Applies-to ID" <> '') THEN BEGIN
          CustLedgEntry.SETCURRENTKEY("Customer No.",Open);
          CustLedgEntry.SETRANGE("Customer No.","Bill-to Customer No.");
          CustLedgEntry.SETRANGE(Open,TRUE);
          CustLedgEntry.SETRANGE("Applies-to ID",xRec."Applies-to ID");
          IF CustLedgEntry.FINDFIRST THEN
            CustEntrySetApplID.SetApplId(CustLedgEntry,TempCustLedgEntry,'');
          CustLedgEntry.RESET;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Applies-to ID" <> '' then
          TESTFIELD("Bal. Account No.",'');
        if ("Applies-to ID" <> xRec."Applies-to ID") and (xRec."Applies-to ID" <> '') then begin
          CustLedgEntry.SETCURRENTKEY("Customer No.",Open);
          CustLedgEntry.SETRANGE("Customer No.","Bill-to Customer No.");
          CustLedgEntry.SETRANGE(Open,true);
          CustLedgEntry.SETRANGE("Applies-to ID",xRec."Applies-to ID");
          if CustLedgEntry.FINDFIRST then
            CustEntrySetApplID.SetApplId(CustLedgEntry,TempCustLedgEntry,'');
          CustLedgEntry.RESET;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT Base Discount %"(Field 119).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GLSetup.GET;
        IF "VAT Base Discount %" > GLSetup."VAT Tolerance %" THEN
          ERROR(
            Text011,
            FIELDCAPTION("VAT Base Discount %"),
            GLSetup.FIELDCAPTION("VAT Tolerance %"),
            GLSetup.TABLECAPTION);

        IF ("VAT Base Discount %" = xRec."VAT Base Discount %") AND
           (CurrFieldNo <> 0)
        THEN
          EXIT;

        ServLine.RESET;
        ServLine.SETRANGE("Document Type","Document Type");
        ServLine.SETRANGE("Document No.","No.");
        ServLine.SETFILTER(Type,'<>%1',ServLine.Type::" ");
        ServLine.SETFILTER(Quantity,'<>0');
        ServLine.LOCKTABLE;
        LOCKTABLE;
        IF ServLine.findset THEN BEGIN
          MODIFY;
          REPEAT
            IF (ServLine."Quantity Invoiced" <> ServLine.Quantity) OR
               ("Shipping Advice" <> "Shipping Advice"::Partial) OR
               (CurrFieldNo <> 0)
            THEN BEGIN
              ServLine.UpdateAmounts;
              ServLine.MODIFY;
            end;
          UNTIL ServLine.NEXT = 0;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GLSetup.GET;
        if "VAT Base Discount %" > GLSetup."VAT Tolerance %" then
        #3..8
        if ("VAT Base Discount %" = xRec."VAT Base Discount %") and
           (CurrFieldNo <> 0)
        then
          exit;
        #13..20
        if ServLine.findset then begin
          MODIFY;
          repeat
            if (ServLine."Quantity Invoiced" <> ServLine.Quantity) or
               ("Shipping Advice" <> "Shipping Advice"::Partial) or
               (CurrFieldNo <> 0)
            then begin
              ServLine.UpdateAmounts;
              ServLine.MODIFY;
            end;
          until ServLine.NEXT = 0;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on "Status(Field 120).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ServItemLine.RESET;
        ServItemLine.SETRANGE("Document Type","Document Type");
        ServItemLine.SETRANGE("Document No.","No.");
        LinesExist := TRUE;
        IF ServItemLine.FIND('-') THEN
          REPEAT
            IF ServItemLine."Repair Status Code" <> '' THEN BEGIN
              RepairStatus.GET(ServItemLine."Repair Status Code");
              IF ((Status = Status::Pending) AND NOT RepairStatus."Pending Status Allowed") OR
                 ((Status = Status::"In Process") AND NOT RepairStatus."In Process Status Allowed") OR
                 ((Status = Status::Finished) AND NOT RepairStatus."Finished Status Allowed") OR
                 ((Status = Status::"On Hold") AND NOT RepairStatus."On Hold Status Allowed")
              THEN
                ERROR(
                  Text031,
                  FIELDCAPTION(Status),FORMAT(Status),TABLECAPTION,"No.",ServItemLine.FIELDCAPTION("Repair Status Code"),
                  ServItemLine."Repair Status Code",ServItemLine.TABLECAPTION,ServItemLine."Line No.")
            end;
          UNTIL ServItemLine.NEXT = 0
        else
          LinesExist := FALSE;

        CASE Status OF
          Status::"In Process":
            BEGIN
              IF NOT LinesExist THEN BEGIN
                "Starting Date" := WORKDATE;
                VALIDATE("Starting Time",TIME);
              end else
                UpdateStartingDateTime;
            end;
          Status::Finished:
            BEGIN
              TestMandatoryFields(ServLine);
              IF Status <> xRec.Status THEN
                IF "Notify Customer" = "Notify Customer"::"By Email" THEN BEGIN
                  TESTFIELD("Customer No.");
                  CLEAR(NotifyCust);
                  NotifyCust.RUN(Rec);
                end;
              IF NOT LinesExist THEN BEGIN
                IF ("Finishing Date" = 0D) AND ("Finishing Time" = 0T) THEN BEGIN
                  "Finishing Date" := WORKDATE;
                  "Finishing Time" := TIME;
                end;
              end else
                UpdateFinishingDateTime;
            end;
        end;

        IF Status <> Status::Finished THEN BEGIN
          "Finishing Date" := 0D;
          "Finishing Time" := 0T;
          "Service Time (Hours)" := 0;
        end;

        IF ("Starting Date" <> 0D) AND
           ("Finishing Date" <> 0D) AND
           NOT LinesExist
        THEN BEGIN
          CALCFIELDS("Contract Serv. Hours Exist");
          "Service Time (Hours)" :=
            ServOrderMgt.CalcServTime(
              "Starting Date","Starting Time","Finishing Date","Finishing Time",
              "Contract No.","Contract Serv. Hours Exist");
        end;

        IF Status = Status::Pending THEN
          IF ServSetup.GET THEN
            IF ServSetup."First Warning Within (Hours)" <> 0 THEN
              IF JobQueueEntry.WRITEPERMISSION THEN BEGIN
                JobQueueEntry.SETRANGE("Object Type to Run",JobQueueEntry."Object Type to Run"::Codeunit);
                JobQueueEntry.SETRANGE("Object ID to Run",CODEUNIT::"ServOrder-Check Response Time");
                JobQueueEntry.SETRANGE(Status,JobQueueEntry.Status::"On Hold");
                IF JobQueueEntry.FINDFIRST THEN
                  JobQueueEntry.SetStatus(JobQueueEntry.Status::Ready);
              end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        LinesExist := true;
        if ServItemLine.FIND('-') then
          repeat
            if ServItemLine."Repair Status Code" <> '' then begin
              RepairStatus.GET(ServItemLine."Repair Status Code");
              if ((Status = Status::Pending) and not RepairStatus."Pending Status Allowed") or
                 ((Status = Status::"In Process") and not RepairStatus."In Process Status Allowed") or
                 ((Status = Status::Finished) and not RepairStatus."Finished Status Allowed") or
                 ((Status = Status::"On Hold") and not RepairStatus."On Hold Status Allowed")
              then
        #14..17
            end;
          until ServItemLine.NEXT = 0
        else
          LinesExist := false;

        case Status of
          Status::"In Process":
            begin
              if not LinesExist then begin
                "Starting Date" := WORKDATE;
                VALIDATE("Starting Time",TIME);
              end else
                UpdateStartingDateTime;
            end;
          Status::Finished:
            begin
              TestMandatoryFields(ServLine);
              if Status <> xRec.Status then
                if "Notify Customer" = "Notify Customer"::"By Email" then begin
        #37..39
                end;
              if not LinesExist then begin
                if ("Finishing Date" = 0D) and ("Finishing Time" = 000000T) then begin
                  "Finishing Date" := WORKDATE;
                  "Finishing Time" := TIME;
                end;
              end else
                UpdateFinishingDateTime;
            end;
        end;

        if Status <> Status::Finished then begin
          "Finishing Date" := 0D;
          "Finishing Time" := 000000T;
          "Service Time (Hours)" := 0;
        end;

        if ("Starting Date" <> 0D) and
           ("Finishing Date" <> 0D) and
           not LinesExist
        then begin
        #61..65
        end;

        if Status = Status::Pending then
          if ServSetup.GET then
            if ServSetup."First Warning Within (Hours)" <> 0 then
              if JobQueueEntry.WRITEPERMISSION then begin
        #72..74
                if JobQueueEntry.FINDFIRST then
                  JobQueueEntry.SetStatus(JobQueueEntry.Status::Ready);
              end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Contact No."(Field 5052).OnLookup". Please convert manually.

        //trigger "(Field 5052)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Customer No." <> '' THEN
          IF Cont.GET("Contact No.") THEN
            Cont.SETRANGE("Company No.",Cont."Company No.")
          else BEGIN
            ContBusinessRelation.RESET;
            ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
            ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Customer);
            ContBusinessRelation.SETRANGE("No.","Customer No.");
            IF ContBusinessRelation.FINDFIRST THEN
              Cont.SETRANGE("Company No.",ContBusinessRelation."Contact No.")
            else
              Cont.SETRANGE("No.",'');
          end;

        IF "Contact No." <> '' THEN
          IF Cont.GET("Contact No.") THEN ;
        IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
          xRec := Rec;
          VALIDATE("Contact No.",Cont."No.");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Customer No." <> '' then
          if Cont.GET("Contact No.") then
            Cont.SETRANGE("Company No.",Cont."Company No.")
          else begin
        #5..8
            if ContBusinessRelation.FINDFIRST then
              Cont.SETRANGE("Company No.",ContBusinessRelation."Contact No.")
            else
              Cont.SETRANGE("No.",'');
          end;

        if "Contact No." <> '' then
          if Cont.GET("Contact No.") then ;
        if PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK then begin
          xRec := Rec;
          VALIDATE("Contact No.",Cont."No.");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Contact No."(Field 5052).OnValidate". Please convert manually.

        //trigger "(Field 5052)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Contact No." <> xRec."Contact No.") AND
           (xRec."Contact No." <> '')
        THEN BEGIN
          IF HideValidationDialog THEN
            Confirmed := TRUE
          else
            Confirmed := CONFIRM(Text005,FALSE,FIELDCAPTION("Contact No."));
          IF Confirmed THEN BEGIN
            ServLine.RESET;
            ServLine.SETRANGE("Document Type","Document Type");
            ServLine.SETRANGE("Document No.","No.");
            IF ("Contact No." = '') AND ("Customer No." = '') THEN BEGIN
              IF NOT ServLine.ISEMPTY THEN
                ERROR(Text050,FIELDCAPTION("Contact No."));
              INIT;
              ServSetup.GET;
              InitRecord;
              "No. Series" := xRec."No. Series";
              IF xRec."Shipping No." <> '' THEN BEGIN
                "Shipping No. Series" := xRec."Shipping No. Series";
                "Shipping No." := xRec."Shipping No.";
              end;
              IF xRec."Posting No." <> '' THEN BEGIN
                "Posting No. Series" := xRec."Posting No. Series";
                "Posting No." := xRec."Posting No.";
              end;
              EXIT;
            end;
          end else BEGIN
            Rec := xRec;
            EXIT;
          end;
        end;

        IF ("Customer No." <> '') AND ("Contact No." <> '') THEN BEGIN
          Cont.GET("Contact No.");
          ContBusinessRelation.RESET;
          ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
          ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Customer);
          ContBusinessRelation.SETRANGE("No.","Customer No.");
          IF ContBusinessRelation.FINDFIRST AND
             (ContBusinessRelation."Contact No." <> Cont."Company No.")
          THEN
            ERROR(Text038,Cont."No.",Cont.Name,"Customer No.");
        end;

        UpdateCust("Contact No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Contact No." <> xRec."Contact No.") and
           (xRec."Contact No." <> '')
        then begin
          if HideValidationDialog then
            Confirmed := true
          else
            Confirmed := CONFIRM(Text005,false,FIELDCAPTION("Contact No."));
          if Confirmed then begin
        #9..11
            if ("Contact No." = '') and ("Customer No." = '') then begin
              if not ServLine.ISEMPTY then
        #14..16
              // <<DITW15.00.00.35 DDR 17/04/2009
              // <<DITW18.00.06 DDR 20/04/2015 DIT-770 #1234
              if ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") and DitServSetup.READPERMISSION then
              // >>DITW18.00.06 DDR DIT-770 #1234
                DitServSetup.GET;
              // >>DITW15.00.00.35 DDR
              // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
              if "DIT Sub-Contract Type" = "DIT Sub-Contract Type"::PlantMaintenance then
                PlantMaintSetup.GET;
              // >>DITW16.00.00.41 DDR DIT-715 #297
              InitRecord;
              "No. Series" := xRec."No. Series";
              if xRec."Shipping No." <> '' then begin
                "Shipping No. Series" := xRec."Shipping No. Series";
                "Shipping No." := xRec."Shipping No.";
              end;
              if xRec."Posting No." <> '' then begin
                "Posting No. Series" := xRec."Posting No. Series";
                "Posting No." := xRec."Posting No.";
              end;
              exit;
            end;
          end else begin
            Rec := xRec;
            exit;
          end;
        end;

        if ("Customer No." <> '') and ("Contact No." <> '') then begin
        #36..40
          if ContBusinessRelation.FINDFIRST and
             (ContBusinessRelation."Contact No." <> Cont."Company No.")
          then
            ERROR(Text038,Cont."No.",Cont.Name,"Customer No.");
        end;

        UpdateCust("Contact No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Bill-to Contact No."(Field 5053).OnLookup". Please convert manually.

        //trigger "(Field 5053)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bill-to Customer No." <> '' THEN
          IF Cont.GET("Bill-to Contact No.") THEN
            Cont.SETRANGE("Company No.",Cont."Company No.")
          else BEGIN
            ContBusinessRelation.RESET;
            ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
            ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Customer);
            ContBusinessRelation.SETRANGE("No.","Bill-to Customer No.");
            IF ContBusinessRelation.FINDFIRST THEN
              Cont.SETRANGE("Company No.",ContBusinessRelation."Contact No.")
            else
              Cont.SETRANGE("No.",'');
          end;

        IF "Bill-to Contact No." <> '' THEN
          IF Cont.GET("Bill-to Contact No.") THEN ;
        IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
          xRec := Rec;
          VALIDATE("Bill-to Contact No.",Cont."No.");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bill-to Customer No." <> '' then
          if Cont.GET("Bill-to Contact No.") then
            Cont.SETRANGE("Company No.",Cont."Company No.")
          else begin
        #5..8
            if ContBusinessRelation.FINDFIRST then
              Cont.SETRANGE("Company No.",ContBusinessRelation."Contact No.")
            else
              Cont.SETRANGE("No.",'');
          end;

        if "Bill-to Contact No." <> '' then
          if Cont.GET("Bill-to Contact No.") then ;
        if PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK then begin
          xRec := Rec;
          VALIDATE("Bill-to Contact No.",Cont."No.");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bill-to Contact No."(Field 5053).OnValidate". Please convert manually.

        //trigger "(Field 5053)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Bill-to Contact No." <> xRec."Bill-to Contact No.") AND
           (xRec."Bill-to Contact No." <> '')
        THEN BEGIN
          IF HideValidationDialog THEN
            Confirmed := TRUE
          else
            Confirmed := CONFIRM(Text005,FALSE,FIELDCAPTION("Bill-to Contact No."));
          IF Confirmed THEN BEGIN
            ServLine.RESET;
            ServLine.SETRANGE("Document Type","Document Type");
            ServLine.SETRANGE("Document No.","No.");
            IF ("Bill-to Contact No." = '') AND ("Bill-to Customer No." = '') THEN BEGIN
              IF NOT ServLine.ISEMPTY THEN
                ERROR(Text050,FIELDCAPTION("Bill-to Contact No."));
              INIT;
              ServSetup.GET;
              InitRecord;
              "No. Series" := xRec."No. Series";
              IF xRec."Shipping No." <> '' THEN BEGIN
                "Shipping No. Series" := xRec."Shipping No. Series";
                "Shipping No." := xRec."Shipping No.";
              end;
              IF xRec."Posting No." <> '' THEN BEGIN
                "Posting No. Series" := xRec."Posting No. Series";
                "Posting No." := xRec."Posting No.";
              end;
              EXIT;
            end;
          end else BEGIN
            "Bill-to Contact No." := xRec."Bill-to Contact No.";
            EXIT;
          end;
        end;

        IF ("Bill-to Customer No." <> '') AND ("Bill-to Contact No." <> '') THEN BEGIN
          Cont.GET("Bill-to Contact No.");
          ContBusinessRelation.RESET;
          ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
          ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Customer);
          ContBusinessRelation.SETRANGE("No.","Bill-to Customer No.");
          IF ContBusinessRelation.FINDFIRST AND
             (ContBusinessRelation."Contact No." <> Cont."Company No.")
          THEN
            ERROR(Text038,Cont."No.",Cont.Name,"Bill-to Customer No.");
        end;

        UpdateBillToCust("Bill-to Contact No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Bill-to Contact No." <> xRec."Bill-to Contact No.") and
           (xRec."Bill-to Contact No." <> '')
        then begin
          if HideValidationDialog then
            Confirmed := true
          else
            Confirmed := CONFIRM(Text005,false,FIELDCAPTION("Bill-to Contact No."));
          if Confirmed then begin
        #9..11
            if ("Bill-to Contact No." = '') and ("Bill-to Customer No." = '') then begin
              if not ServLine.ISEMPTY then
        #14..16
              // <<DITW15.00.00.35 DDR 17/04/2009
              if ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") then
                DitServSetup.GET;
              // >>DITW15.00.00.35 DDR
              // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
              if "DIT Sub-Contract Type" = "DIT Sub-Contract Type"::PlantMaintenance then
                PlantMaintSetup.GET;
              // >>DITW16.00.00.41 DDR DIT-715 #297
              InitRecord;
              "No. Series" := xRec."No. Series";
              if xRec."Shipping No." <> '' then begin
                "Shipping No. Series" := xRec."Shipping No. Series";
                "Shipping No." := xRec."Shipping No.";
              end;
              if xRec."Posting No." <> '' then begin
                "Posting No. Series" := xRec."Posting No. Series";
                "Posting No." := xRec."Posting No.";
              end;
              exit;
            end;
          end else begin
            "Bill-to Contact No." := xRec."Bill-to Contact No.";
            exit;
          end;
        end;

        if ("Bill-to Customer No." <> '') and ("Bill-to Contact No." <> '') then begin
        #36..40
          if ContBusinessRelation.FINDFIRST and
             (ContBusinessRelation."Contact No." <> Cont."Company No.")
          then
            ERROR(Text038,Cont."No.",Cont.Name,"Bill-to Customer No.");
        end;

        UpdateBillToCust("Bill-to Contact No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Responsibility Center"(Field 5700).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT UserSetupMgt.CheckRespCenter(2,"Responsibility Center") THEN
          ERROR(
            Text010,
            RespCenter.TABLECAPTION,UserSetupMgt.GetServiceFilter);

        UpdateShipToAddress;

        CreateDim(
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::Customer,"Bill-to Customer No.",
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::"Service Order Type","Service Order Type",
          DATABASE::"Service Contract Header","Contract No.");

        ServItemLine.RESET;
        ServItemLine.SETRANGE("Document Type","Document Type");
        ServItemLine.SETRANGE("Document No.","No.");
        IF ServItemLine.FIND('-') THEN
          REPEAT
            ServItemLine.VALIDATE("Responsibility Center","Responsibility Center");
            ServItemLine.MODIFY(TRUE);
          UNTIL ServItemLine.NEXT = 0;

        IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
          RecreateServLines(FIELDCAPTION("Responsibility Center"));
          VALIDATE("Location Code",UserSetupMgt.GetLocation(2,'',"Responsibility Center"));
          "Assigned User ID" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not UserSetupMgt.CheckRespCenter(2,"Responsibility Center") then
        #2..4
        // <<DITW18.00.06 MSF 01/03/2015 DIT-770 #1193
        if (CurrFieldNo <> FIELDNO("Location Code")) and
          (CurrFieldNo <> FIELDNO("Physical Location Group Code")) and
          (xRec."Physical Location Group Code" = "Physical Location Group Code") and
          (xRec."Location Code" = "Location Code")
        then begin
            SETRANGE("Phys. Location Table Filter");
            SETRANGE("Location Table Filter");
            VALIDATE("Physical Location Group Code", UserSetupMgt.GetphysicalLocation(2,'',"Responsibility Center"));
            LocationCode := UserSetupMgt.GetLocation(2,'',"Responsibility Center");
            if (LocationCode <> '') or ("Physical Location Group Code" = '') then
              VALIDATE("Location Code", LocationCode);
        end;
        // >>DITW18.00.06 MSF DIT-770 #1193

        #5..12
          DATABASE::"Service Contract Header","Contract No.",
          // <<DITW15.00.00.35 DDR 10/04/2009
          DATABASE::Building,"Building No.");
          // >>DITW15.00.00.35 DDR
        #14..17
        if ServItemLine.FIND('-') then
          repeat
            ServItemLine.VALIDATE("Responsibility Center","Responsibility Center");
            ServItemLine.MODIFY(true);
          until ServItemLine.NEXT = 0;

        if xRec."Responsibility Center" <> "Responsibility Center" then begin
        #25..27
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Advice"(Field 5750).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Release Status","Release Status"::Open);
        IF InventoryPickConflict("Document Type","No.","Shipping Advice") THEN
          ERROR(Text064,FIELDCAPTION("Shipping Advice"),FORMAT("Shipping Advice"),TABLECAPTION);
        IF WhseShpmntConflict("Document Type","No.","Shipping Advice") THEN
          ERROR(STRSUBSTNO(Text065,FIELDCAPTION("Shipping Advice"),FORMAT("Shipping Advice"),TABLECAPTION));
        WhseValidateSourceHeader.ServiceHeaderVerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Release Status","Release Status"::Open);
        if InventoryPickConflict("Document Type","No.","Shipping Advice") then
          ERROR(Text064,FIELDCAPTION("Shipping Advice"),FORMAT("Shipping Advice"),TABLECAPTION);
        if WhseShpmntConflict("Document Type","No.","Shipping Advice") then
          ERROR(STRSUBSTNO(Text065,FIELDCAPTION("Shipping Advice"),FORMAT("Shipping Advice"),TABLECAPTION));
        WhseValidateSourceHeader.ServiceHeaderVerifyChange(Rec,xRec);
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Time"(Field 5792).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Release Status","Release Status"::Open);
        IF "Shipping Time" <> xRec."Shipping Time" THEN
          UpdateServLines(FIELDCAPTION("Shipping Time"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Release Status","Release Status"::Open);
        if "Shipping Time" <> xRec."Shipping Time" then
          UpdateServLines(FIELDCAPTION("Shipping Time"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: CodeModification on ""Service Order Type"(Field 5904).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CreateDim(
          DATABASE::"Service Order Type","Service Order Type",
          DATABASE::Customer,"Bill-to Customer No.",
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Service Contract Header","Contract No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
          DATABASE::"Service Contract Header","Contract No.",
          // <<DITW15.00.00.35 DDR 10/04/2009
          DATABASE::Building,"Building No.");
          // >>DITW15.00.00.35 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Link Service to Service Item"(Field 5905).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Link Service to Service Item" <> xRec."Link Service to Service Item" THEN BEGIN
          ServLine.RESET;
          ServLine.SETRANGE("Document Type","Document Type");
          ServLine.SETRANGE("Document No.","No.");
          ServLine.SETFILTER(Type,'<>%1',ServLine.Type::Cost);
          IF ServLine.FIND('-') THEN
            MESSAGE(
              Text001,
              FIELDCAPTION("Link Service to Service Item"),
              "No.");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Link Service to Service Item" <> xRec."Link Service to Service Item" then begin
        #2..5
          if ServLine.FIND('-') then
        #7..10
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Order Time"(Field 5923).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Order Time" <> xRec."Order Time" THEN BEGIN
          IF ("Order Time" > "Starting Time") AND
             ("Starting Time" <> 0T) AND
             ("Order Date" = "Starting Date")
          THEN
            ERROR(Text007,FIELDCAPTION("Order Time"),FIELDCAPTION("Starting Time"));
          IF "Starting Time" <> 0T THEN
            VALIDATE("Starting Time");
          ServItemLine.RESET;
          ServItemLine.SETRANGE("Document Type","Document Type");
          ServItemLine.SETRANGE("Document No.","No.");
          IF ServItemLine.FIND('-') THEN
            REPEAT
              ServItemLine.CalculateResponseDateTime("Order Date","Order Time");
              ServItemLine.MODIFY;
            UNTIL ServItemLine.NEXT = 0;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Order Time" <> xRec."Order Time" then begin
          if ("Order Time" > "Starting Time") and
             ("Starting Time" <> 000000T) and
             ("Order Date" = "Starting Date")
          then
            ERROR(Text007,FIELDCAPTION("Order Time"),FIELDCAPTION("Starting Time"));
          if "Starting Time" <> 000000T then
        #8..11
          if ServItemLine.FIND('-') then
            repeat
              ServItemLine.CalculateResponseDateTime("Order Date","Order Time");
              ServItemLine.MODIFY;
            until ServItemLine.NEXT = 0;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Starting Date"(Field 5929).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Starting Date" <> 0D THEN BEGIN
          IF "Starting Date" < "Order Date" THEN
            ERROR(Text026,FIELDCAPTION("Starting Date"),FIELDCAPTION("Order Date"));

          IF ("Starting Date" > "Finishing Date") AND
             ("Finishing Date" <> 0D)
          THEN
            ERROR(Text007,FIELDCAPTION("Starting Date"),FIELDCAPTION("Finishing Time"));

          ServItemLine.RESET;
          ServItemLine.SETCURRENTKEY("Document Type","Document No.","Starting Date");
          ServItemLine.SETRANGE("Document Type","Document Type");
          ServItemLine.SETRANGE("Document No.","No.");
          ServItemLine.SETFILTER("Starting Date",'<>%1',0D);
          IF ServItemLine.FIND('-') THEN
            REPEAT
              IF ServItemLine."Starting Date" < "Starting Date" THEN
                ERROR(Text024,FIELDCAPTION("Starting Date"));
            UNTIL ServItemLine.NEXT = 0;

          IF TIME < "Order Time" THEN
            VALIDATE("Starting Time","Order Time")
          else
            VALIDATE("Starting Time",TIME);
        end else BEGIN
          "Starting Time" := 0T;
          "Actual Response Time (Hours)" := 0;
          "Finishing Date" := 0D;
          "Finishing Time" := 0T;
          "Service Time (Hours)" := 0;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Starting Date" <> 0D then begin
          if "Starting Date" < "Order Date" then
            ERROR(Text026,FIELDCAPTION("Starting Date"),FIELDCAPTION("Order Date"));

          if ("Starting Date" > "Finishing Date") and
             ("Finishing Date" <> 0D)
          then
        #8..14
          if ServItemLine.FIND('-') then
            repeat
              if ServItemLine."Starting Date" < "Starting Date" then
                ERROR(Text024,FIELDCAPTION("Starting Date"));
            until ServItemLine.NEXT = 0;

          if TIME < "Order Time" then
            VALIDATE("Starting Time","Order Time")
          else
            VALIDATE("Starting Time",TIME);
        end else begin
          "Starting Time" := 000000T;
          "Actual Response Time (Hours)" := 0;
          "Finishing Date" := 0D;
          "Finishing Time" := 000000T;
          "Service Time (Hours)" := 0;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Starting Time"(Field 5930).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Starting Date");

        IF ("Starting Date" = "Finishing Date") AND
           ("Starting Time" > "Finishing Time")
        THEN
          ERROR(Text007,FIELDCAPTION("Starting Time"),FIELDCAPTION("Finishing Time"));

        IF ("Starting Date" = "Order Date") AND
           ("Starting Time" < "Order Time")
        THEN
          ERROR(Text026,FIELDCAPTION("Starting Time"),FIELDCAPTION("Order Time"));

        IF ("Starting Time" = 0T) AND (xRec."Starting Time" <> 0T) THEN BEGIN
          "Finishing Time" := 0T;
          "Finishing Date" := 0D;
          "Service Time (Hours)" := 0;
        end;

        IF ("Starting Time" <> 0T) AND
           ("Starting Date" <> 0D)
        THEN BEGIN
          CALCFIELDS("Contract Serv. Hours Exist");
          "Actual Response Time (Hours)" :=
            ServOrderMgt.CalcServTime(
              "Order Date","Order Time","Starting Date","Starting Time",
              "Contract No.","Contract Serv. Hours Exist");
        end else
          "Actual Response Time (Hours)" := 0;
        IF "Finishing Time" <> 0T THEN
          VALIDATE("Finishing Time");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Starting Date");

        if ("Starting Date" = "Finishing Date") and
           ("Starting Time" > "Finishing Time")
        then
          ERROR(Text007,FIELDCAPTION("Starting Time"),FIELDCAPTION("Finishing Time"));

        if ("Starting Date" = "Order Date") and
           ("Starting Time" < "Order Time")
        then
          ERROR(Text026,FIELDCAPTION("Starting Time"),FIELDCAPTION("Order Time"));

        if ("Starting Time" = 000000T) and (xRec."Starting Time" <> 000000T) then begin
          "Finishing Time" := 000000T;
          "Finishing Date" := 0D;
          "Service Time (Hours)" := 0;
        end;

        if ("Starting Time" <> 000000T) and
           ("Starting Date" <> 0D)
        then begin
        #22..26
        end else
          "Actual Response Time (Hours)" := 0;
        if "Finishing Time" <> 000000T then
          VALIDATE("Finishing Time");
        */
        //end;


        //Unsupported feature: CodeModification on ""Finishing Date"(Field 5931).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Finishing Date" <> 0D THEN BEGIN
          IF "Finishing Date" < "Starting Date" THEN
            ERROR(Text026,FIELDCAPTION("Finishing Date"),FIELDCAPTION("Starting Date"));

          IF "Finishing Date" < "Order Date" THEN
            ERROR(
              Text026,
              FIELDCAPTION("Finishing Date"),
              FIELDCAPTION("Order Date"));

          IF "Starting Date" = 0D THEN BEGIN
            "Starting Date" := "Finishing Date";
            "Starting Time" := TIME;
            CALCFIELDS("Contract Serv. Hours Exist");
            "Actual Response Time (Hours)" :=
              ServOrderMgt.CalcServTime(
                "Order Date","Order Time","Starting Date","Starting Time",
                "Contract No.","Contract Serv. Hours Exist");
          end;

          IF "Finishing Date" <> xRec."Finishing Date" THEN BEGIN
            IF TIME < "Starting Time" THEN
              "Finishing Time" := "Starting Time"
            else
              "Finishing Time" := TIME;
            VALIDATE("Finishing Time");
          end;

          ServItemLine.RESET;
          ServItemLine.SETCURRENTKEY("Document Type","Document No.","Finishing Date");
          ServItemLine.SETRANGE("Document Type","Document Type");
          ServItemLine.SETRANGE("Document No.","No.");
          ServItemLine.SETFILTER("Finishing Date",'<>%1',0D);
          IF ServItemLine.FIND('-') THEN
            REPEAT
              IF ServItemLine."Finishing Date" > "Finishing Date" THEN
                ERROR(Text025,FIELDCAPTION("Finishing Date"));
            UNTIL ServItemLine.NEXT = 0;
        end else BEGIN
          "Finishing Time" := 0T;
          "Service Time (Hours)" := 0;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Finishing Date" <> 0D then begin
          if "Finishing Date" < "Starting Date" then
            ERROR(Text026,FIELDCAPTION("Finishing Date"),FIELDCAPTION("Starting Date"));

          if "Finishing Date" < "Order Date" then
        #6..10
          if "Starting Date" = 0D then begin
        #12..18
          end;

          if "Finishing Date" <> xRec."Finishing Date" then begin
            if TIME < "Starting Time" then
              "Finishing Time" := "Starting Time"
            else
              "Finishing Time" := TIME;
            VALIDATE("Finishing Time");
          end;
        #28..33
          if ServItemLine.FIND('-') then
            repeat
              if ServItemLine."Finishing Date" > "Finishing Date" then
                ERROR(Text025,FIELDCAPTION("Finishing Date"));
            until ServItemLine.NEXT = 0;
        end else begin
          "Finishing Time" := 000000T;
          "Service Time (Hours)" := 0;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Finishing Time"(Field 5932).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Finishing Date");
        IF "Finishing Time" <> 0T THEN BEGIN
          IF ("Starting Date" = "Finishing Date") AND
             ("Finishing Time" < "Starting Time")
          THEN
            ERROR(
              Text026,FIELDCAPTION("Finishing Time"),
              FIELDCAPTION("Starting Time"));

          IF ("Finishing Date" = "Order Date") AND
             ("Finishing Time" < "Order Time")
          THEN
            ERROR(
              Text026,FIELDCAPTION("Finishing Time"),
              FIELDCAPTION("Order Time"));
        #16..18
          ServItemLine.SETRANGE("Document Type","Document Type");
          ServItemLine.SETRANGE("Document No.","No.");
          ServItemLine.SETFILTER("Finishing Date",'<>%1',0D);
          IF ServItemLine.FIND('-') THEN
            REPEAT
              IF (ServItemLine."Finishing Date" = "Finishing Date") AND
                 (ServItemLine."Finishing Time" > "Finishing Time")
              THEN
                ERROR(Text025,FIELDCAPTION("Finishing Time"));
            UNTIL ServItemLine.NEXT = 0;

          CALCFIELDS("Contract Serv. Hours Exist");
          "Service Time (Hours)" :=
            ServOrderMgt.CalcServTime(
              "Starting Date","Starting Time","Finishing Date","Finishing Time",
              "Contract No.","Contract Serv. Hours Exist");
        end else
          "Service Time (Hours)" := 0;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Finishing Date");
        if "Finishing Time" <> 000000T then begin
          if ("Starting Date" = "Finishing Date") and
             ("Finishing Time" < "Starting Time")
          then
        #6..9
          if ("Finishing Date" = "Order Date") and
             ("Finishing Time" < "Order Time")
          then
        #13..21
          if ServItemLine.FIND('-') then
            repeat
              if (ServItemLine."Finishing Date" = "Finishing Date") and
                 (ServItemLine."Finishing Time" > "Finishing Time")
              then
                ERROR(Text025,FIELDCAPTION("Finishing Time"));
            until ServItemLine.NEXT = 0;
        #29..34
        end else
          "Service Time (Hours)" := 0;
        */
        //end;


        //Unsupported feature: CodeModification on ""Max. Labor Unit Price"(Field 5937).OnValidate". Please convert manually.

        //trigger  Labor Unit Price"(Field 5937)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ServLineExists THEN
          MESSAGE(
            Text001,
            FIELDCAPTION("Max. Labor Unit Price"),
            "No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ServLineExists then
        #2..5
        */
        //end;


        //Unsupported feature: CodeModification on ""Contract No."(Field 5940).OnLookup". Please convert manually.

        //trigger "(Field 5940)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Contract No." <> '' THEN BEGIN
          IF ServContract.GET(ServContract."Contract Type"::Contract,"Contract No.") THEN
            ServContractList.SETRECORD(ServContract);
        end;

        ServContract.RESET;
        ServContract.FILTERGROUP(2);
        #8..12
        ServContract.SETRANGE(Status,ServContract.Status::Signed);
        ServContract.SETFILTER("Starting Date",'<=%1',"Order Date");
        ServContract.SETFILTER("Expiration Date",'>=%1 | =%2',"Order Date",0D);
        ServContract.FILTERGROUP(0);
        CLEAR(ServContractList);
        ServContractList.SETTABLEVIEW(ServContract);
        ServContractList.LOOKUPMODE(TRUE);
        IF ServContractList.RUNMODAL = ACTION::LookupOK THEN BEGIN
          ServContractList.GETRECORD(ServContract);
          VALIDATE("Contract No.",ServContract."Contract No.");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Contract No." <> '' then begin
          if ServContract.GET(ServContract."Contract Type"::Contract,"Contract No.") then
            ServContractList.SETRECORD(ServContract);
        end;
        #5..15
        // <<DITW15.00.00.35 DDR 01/10/2009
        ServContract.SETRANGE("DIT Sub-Contract Type","DIT Sub-Contract Type");
        // >>DITW15.00.00.35 DDR
        #16..18
        ServContractList.LOOKUPMODE(true);
        if ServContractList.RUNMODAL = ACTION::LookupOK then begin
          ServContractList.GETRECORD(ServContract);
          VALIDATE("Contract No.",ServContract."Contract No.");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Contract No."(Field 5940).OnValidate". Please convert manually.

        //trigger "(Field 5940)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Contract No." <> xRec."Contract No." THEN BEGIN
          IF "Contract No." <> '' THEN BEGIN
            TESTFIELD("Order Date");
            ServContract.GET(ServContract."Contract Type"::Contract,"Contract No.");
            IF ServContract.Status <> ServContract.Status::Signed THEN
              ERROR(Text041,"Contract No.");
            IF ServContract."Starting Date" > "Order Date" THEN
              ERROR(Text042,"Contract No.");
            IF (ServContract."Expiration Date" <> 0D) AND
               (ServContract."Expiration Date" < "Order Date")
            THEN
              ERROR(Text043,"Contract No.");
          end;
          ServItemLine.RESET;
          ServItemLine.SETRANGE("Document Type","Document Type");
          ServItemLine.SETRANGE("Document No.","No.");
          IF ServItemLine.FIND('-') THEN
            ERROR(Text028,
              FIELDCAPTION("Contract No."),ServItemLine.TABLECAPTION);
          IF NOT
             CONFIRM(
               Text029,
               FALSE,ServContractLine.FIELDCAPTION("Next Planned Service Date"),
               ServContractLine.TABLECAPTION,
               FIELDCAPTION("Contract No."))
          THEN BEGIN
            "Contract No." := xRec."Contract No.";
            EXIT;
          end;

          IF "Contract No." <> '' THEN BEGIN
            TESTFIELD("Customer No.");
            TESTFIELD("Bill-to Customer No.");
            "Default Response Time (Hours)" := ServContract."Response Time (Hours)";
            TESTFIELD("Ship-to Code",ServContract."Ship-to Code");
            "Service Order Type" := ServContract."Service Order Type";
            VALIDATE("Currency Code",ServContract."Currency Code");
            "Max. Labor Unit Price" := ServContract."Max. Labor Unit Price";
            "Your Reference" := ServContract."Your Reference";
            "Service Zone Code" := ServContract."Service Zone Code";
          end;
        end;

        IF "Contract No." <> '' THEN
          CreateDim(
            DATABASE::"Service Contract Header","Contract No.",
            DATABASE::"Service Order Type","Service Order Type",
            DATABASE::Customer,"Bill-to Customer No.",
            DATABASE::"Salesperson/Purchaser","Salesperson Code",
            DATABASE::"Responsibility Center","Responsibility Center");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Contract No." <> xRec."Contract No." then begin
          if "Contract No." <> '' then begin
            TESTFIELD("Order Date");
            ServContract.GET(ServContract."Contract Type"::Contract,"Contract No.");
            // <<DITW15.00.00.35 DDR 01/10/2009
            ServContract.TESTFIELD("DIT Sub-Contract Type","DIT Sub-Contract Type");
            // >>DITW15.00.00.35 DDR
            if ServContract.Status <> ServContract.Status::Signed then
              ERROR(Text041,"Contract No.");
            if ServContract."Starting Date" > "Order Date" then
              ERROR(Text042,"Contract No.");
            if (ServContract."Expiration Date" <> 0D) and
               (ServContract."Expiration Date" < "Order Date")
            then
              ERROR(Text043,"Contract No.");
          // <<DITW15.00.00.35 DDR 17/04/2009
          end else
            if ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") or ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") then
              TESTFIELD("Contract No.");
          // >>DITW15.00.00.35 DDR
        #14..16
          if ServItemLine.FIND('-') then
            ERROR(Text028,
              FIELDCAPTION("Contract No."),ServItemLine.TABLECAPTION);
          if not
             CONFIRM(
               Text029,
               false,ServContractLine.FIELDCAPTION("Next Planned Service Date"),
               ServContractLine.TABLECAPTION,
               FIELDCAPTION("Contract No."))
          then begin
            "Contract No." := xRec."Contract No.";
            exit;
          end;

          if "Contract No." <> '' then begin
        #32..40
            // <<DITW15.00.00.35 DDR 17/04/2009
            "DIT Sub-Contract Type" := ServContract."DIT Sub-Contract Type";
            "Contract Group Code" := ServContract."Contract Group Code";
            // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
            if ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") and
              ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::PlantMaintenance)
            then begin
            // >>DITW16.00.00.41 DDR DIT-715 #297
              "Building No." := ServContract."Building No.";
            end;
            // >>DITW15.00.00.35 DDR
            // <<DITW16.00.00.41 DDR 24/09/2012 DIT-715 #438
            "Classification Group 1 Code" := ServContract."Classification Group 1 Code";
            "Classification Group 2 Code" := ServContract."Classification Group 2 Code";
            "Classification Group 3 Code" := ServContract."Classification Group 3 Code";
            // >>DITW16.00.00.41 DDR DIT-715 #438
          // <<DITW15.00.00.35 DDR 17/04/2009
          end else begin
            "DIT Sub-Contract Type" := xRec."DIT Sub-Contract Type";
            "Contract Group Code" := xRec."Contract Group Code";
            "Building No." := xRec."Building No.";
            if xRec."Contract No." <> '' then
              "DIT Sub-Contract Type" := "DIT Sub-Contract Type"::" ";
            // >>DITW15.00.00.35 DDR
            // <<DITW16.00.00.41 DDR 24/09/2012 DIT-715 #438
            "Classification Group 1 Code" := xRec."Classification Group 1 Code";
            "Classification Group 2 Code" := xRec."Classification Group 2 Code";
            "Classification Group 3 Code" := xRec."Classification Group 3 Code";
            // >>DITW16.00.00.41 DDR DIT-715 #438
          end;
          // >>DITW15.00.00.35 DDR 17/04/2009
        end;

        if "Contract No." <> '' then
        #45..49
            DATABASE::"Responsibility Center","Responsibility Center",
            // <<DITW15.00.00.35 DDR 10/04/2009
            DATABASE::Building,"Building No.");
            // >>DITW15.00.00.35 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Service Zone Code"(Field 5968).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ShiptoAddr.GET("Customer No.","Ship-to Code") THEN
          "Service Zone Code" := ShiptoAddr."Service Zone Code"
        else
          IF Cust.GET("Customer No.") THEN
            "Service Zone Code" := Cust."Service Zone Code"
          else
            "Service Zone Code" := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<FINXL8.00.001 BSA 29/06/2015 #177
        //IF ShiptoAddr.GET("Customer No.","Ship-to Code") THEN
        if ShiptoAddr.GET("Ship-to Customer No.","Ship-to Code") then
        //>>FINXL8.00.001 BSA 29/06/2015 #177
          "Service Zone Code" := ShiptoAddr."Service Zone Code"
        else
        //<<FINXL8.00.001 BSA 29/06/2015 #177
          //IF Cust.GET("Customer No.") THEN
          if Cust.GET("Ship-to Customer No.") then
        //>>FINXL8.00.001 BSA 29/06/2015 #177
            "Service Zone Code" := Cust."Service Zone Code"
          else
            "Service Zone Code" := '';
        */
        //end;


        //Unsupported feature: CodeModification on ""Assigned User ID"(Field 9000).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT UserSetupMgt.CheckRespCenter2(2,"Responsibility Center","Assigned User ID") THEN
          ERROR(
            Text060,"Assigned User ID",
            RespCenter.TABLECAPTION,UserSetupMgt.GetServiceFilter2("Assigned User ID"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not UserSetupMgt.CheckRespCenter2(2,"Responsibility Center","Assigned User ID") then
        #2..4
        */
        //end;
        //BC Upgrade KAMNAY01>>>>
        // field(2014410;"Physical Location Group Code";Code[10])
        // {
        //     CaptionML = ENU='Physical Location Group Code',
        //                 FRA='Code groupe magasin réel';
        //     Description = 'DITW18.00.06 DIT-770 #1193';
        //     TableRelation = "Physical Location Group" WHERE (Code=FIELD("Phys. Location Table Filter"));

        //     trigger OnValidate();
        //     var
        //         PhysLocationGr : Record "Physical Location Group";
        //     begin
        //         // <<DITW18.00.06 MSF 01/03/2015 DIT-770 #1193
        //         if ("Responsibility Center" = xRec."Responsibility Center") and
        //           ("Physical Location Group Code" <> xRec."Physical Location Group Code") and
        //           ("Physical Location Group Code" <> '')
        //         then
        //           VALIDATE("Responsibility Center",UserSetupMgt.GetFirstRespCenter(2,"Physical Location Group Code",''));

        //         if not UserSetupMgt.CheckPhysLocation(2,"Physical Location Group Code","Responsibility Center") then
        //           ERROR(
        //             Text2014412,
        //             PhysLocationGr.TABLECAPTION,"Physical Location Group Code",
        //             RespCenter.TABLECAPTION,UserSetupMgt.GetServiceFilter);

        //         if (xRec."Physical Location Group Code" <> "Physical Location Group Code") then begin
        //           CLEAR(Location);
        //           if "Location Code" <> '' then
        //             Location.GET("Location Code");
        //           if (Location."Physical Location Group Code" <> "Physical Location Group Code") then begin
        //             if ((CurrFieldNo <> FIELDNO("Location Code")) and (xRec."Responsibility Center" = "Responsibility Center")) then
        //               VALIDATE("Location Code",'')
        //             else
        //               "Location Code" := '';
        //           end;
        //         end;
        //          // >>DITW18.00.06 MSF DIT-770 #1193
        //     end;
        // }
        // field(2014411;"Resp. Center Table Filter";Code[10])
        // {
        //     CaptionML = ENU='Resp. Center Table Filter',
        //                 FRA='Filtre Centre de gestion (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1193';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Responsibility Center";
        // }
        // field(2014412;"Phys. Location Table Filter";Code[10])
        // {
        //     CaptionML = ENU='Phys. Location Table Filter',
        //                 FRA='Filtre groupe magasin réel (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1193';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014413;"Location Table Filter";Code[10])
        // {
        //     CaptionML = ENU='Location Table Filter',
        //                 FRA='Filtre Magasin (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1193';
        //     FieldClass = FlowFilter;
        //     TableRelation = Location;
        // }
        // field(2014421;"Document Subtype Code";Code[10])
        // {
        //     CaptionML = ENU='Document Subtype Code',
        //                 FRA='Code Sous-Type Document';
        //     Description = 'DITW18.00.07 DIT-770 #1508-NRQ#83542';
        //     TableRelation = "Document Subtype Code".Code WHERE ("Report Selection Type"=CONST(Service));

        //     trigger OnValidate();
        //     var
        //         DocumentSubtypeCode : Record "Document Subtype Code";
        //         PostingNoSeries : Code[20];
        //     begin
        //         //<<DITW111.00.13 MSF 04/09/2018 NRQ#83542-DITW111.00.13 MSF 05/09/2018 NRQ#83542
        //         if xRec."Document Subtype Code" <> Rec."Document Subtype Code" then begin
        //           if Rec."Document Subtype Code" <> '' then begin
        //             TESTFIELD("Posting No.",'');
        //             PostingNoSeries := DocumentSubtypeCode.GetPostedSerialNoforDocumentSubtype("Document Type","Document Subtype Code");
        //             if PostingNoSeries <> '' then
        //               "Posting No. Series" := PostingNoSeries
        //             else
        //               SetDefaultPostingSerialno;
        //           end else
        //             SetDefaultPostingSerialno;
        //         end;
        //         //>>DITW111.00.13 MSF 04/09/2018 NRQ#83542-DITW111.00.13 MSF 05/09/2018 NRQ#83542
        //     end;
        // }
        // field(2014500;"Direct Debit Mandate ID";Code[35])
        // {
        //     CaptionML = ENU='Direct Debit Mandate ID',
        //                 FRA='ID mandat domiciliation européenne';
        //     Description = 'DITW18.00.07 DIT-770 #1912';
        //     TableRelation = "SEPA Direct Debit Mandate" WHERE ("Customer No."=FIELD("Bill-to Customer No."),
        //                                                        Closed=CONST(false),
        //                                                        Blocked=CONST(false));
        // }
        // field(2029613;"Bill-to Adress Code";Code[10])
        // {
        //     CaptionML = ENU='Bill-to Adress Code',
        //                 FRA='Caude Adresse facturation';
        //     Description = 'FINXL8.00.001';
        //     TableRelation = "Ship-to Address".Code WHERE ("Customer No."=FIELD("Bill-to Customer No."),
        //                                                   "Bill-to"=CONST(true));

        //     trigger OnValidate();
        //     begin
        //         //<<FINXL8.00.001 BSA 29/06/2015 #177
        //         if recFinXLSetup.READPERMISSION then begin
        //           if "Bill-to Adress Code" <> '' then begin
        //             ShiptoAddr.GET("Bill-to Customer No.","Bill-to Adress Code");
        //             "Bill-to Name" := ShiptoAddr.Name;
        //             "Bill-to Name 2" := ShiptoAddr."Name 2";
        //             "Bill-to Address" := ShiptoAddr.Address;
        //             "Bill-to Address 2" := ShiptoAddr."Address 2";
        //             "Bill-to City" := ShiptoAddr.City;
        //             "Bill-to Post Code" := ShiptoAddr."Post Code";
        //             "Bill-to County" := ShiptoAddr.County;
        //             VALIDATE("Bill-to Country/Region Code",ShiptoAddr."Country/Region Code");
        //             "Bill-to Contact" := ShiptoAddr.Contact;
        //           end else begin
        //             if "Bill-to Customer No." <> '' then begin
        //               GetCust("Bill-to Customer No.");
        //               "Bill-to Name" := Cust.Name;
        //               "Bill-to Name 2" := Cust."Name 2";
        //               "Bill-to Address" := Cust.Address;
        //               "Bill-to Address 2" := Cust."Address 2";
        //               "Bill-to City" := Cust.City;
        //               "Bill-to Post Code" := Cust."Post Code";
        //               "Bill-to County" := Cust.County;
        //               VALIDATE("Bill-to Country/Region Code",Cust."Country/Region Code");
        //               "Bill-to Contact" := Cust.Contact;
        //             end;
        //           end;
        //         end;
        //         //>>FINXL8.00.001 BSA 29/06/2015 #177
        //     end;
        // }
        // field(2029614;"Ship-to Customer No.";Code[20])
        // {
        //     CaptionML = ENU='Ship-to Customer No.',
        //                 FRA='N° destinataire';
        //     Description = 'FINXL8.00.001';
        //     TableRelation = Customer."No.";
        // }
        // field(2034840;"Building No.";Code[20])
        // {
        //     CaptionML = ENU='Building No.',
        //                 FRA='N° immeuble';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = Building;

        //     trigger OnValidate();
        //     var
        //         Building : Record Building;
        //     begin
        //         // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
        //         if ("DIT Sub-Contract Type" in ["DIT Sub-Contract Type"::" ","DIT Sub-Contract Type"::PlantMaintenance]) and
        //           ("Building No." <> '')
        //         then
        //           FIELDERROR("DIT Sub-Contract Type");
        //         // >>DITW16.00.00.41 DDR DIT-715 #297

        //         // <<DITW15.00.00.35 DDR 10/04/2009
        //         if "Building No." <> '' then begin
        //           Building.GET("Building No.");
        //           Building.TESTFIELD(Blocked,false);
        //         end;

        //         CreateDim(
        //           DATABASE::Building,"Building No.",
        //           DATABASE::"Service Order Type","Service Order Type",
        //           DATABASE::Customer,"Bill-to Customer No.",
        //           DATABASE::"Salesperson/Purchaser","Salesperson Code",
        //           DATABASE::"Responsibility Center","Responsibility Center",
        //           DATABASE::"Service Contract Header","Contract No.");
        //     end;
        // }
        // field(2034850;"DIT Sub-Contract Type";Option)
        // {
        //     CaptionML = ENU='Sub Contract Type',
        //                 FRA='Sous type contrat';
        //     Description = 'DITW15.00.00.35- DIT-715 #297';
        //     OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA=' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        // }
        // field(2034872;"Contract Group Code";Code[10])
        // {
        //     CaptionML = ENU='Contract Group Code',
        //                 FRA='Code groupe contrat';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Contract Group" WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));

        //     trigger OnValidate();
        //     var
        //         ServContract : Record "Service Contract Header";
        //     begin
        //         // <<DITW15.00.00.35 DDR 21/04/2009
        //         if "Contract Group Code" <> '' then begin
        //           TESTFIELD("Contract No.");
        //           if ServContract.GET(ServContract."Contract Type"::Contract,"Contract No.") then
        //             TESTFIELD("Contract Group Code",ServContract."Contract Group Code");
        //         end else begin
        //           // <<DITW15.00.00.36 DDR 07/12/2009 - DITW15.00.00.37 DDR 04/06/2010
        //           DitServSetup.GET;
        //           if DitServSetup."Contract Group Mandatory" then
        //             TESTFIELD("Contract Group Code");
        //           // >>DITW15.00.00.36 DDR
        //         end;
        //         // >>DITW15.00.00.35 DDR
        //     end;
        // }
        // field(2034940;"PM Order Status";Option)
        // {
        //     CaptionML = ENU='Order Status',
        //                 FRA='Statut de la commande';
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        //     OptionCaptionML = ENU='Planned,Firm Planned,Released,Finished',
        //                       FRA='Planifié,Planifié ferme,Lancé,Terminé';
        //     OptionMembers = Planned,"Firm Planned",Released,Finished;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 - 25/09/2012 DIT-715 #440
        //         //IF (xRec."PM Order Status" = xRec."PM Order Status"::Finished) AND
        //         //  (xRec."PM Order Status" <> "PM Order Status")
        //         //THEN
        //         //  TESTFIELD("PM Order Status","PM Order Status"::Finished);
        //         TestLastOrderStatusFinished();
        //         // >>DITW16.00.00.41 DDR DIT-715 #440

        //         if not HideValidationDialog then
        //           Confirmed := CONFIRM(Text005,false,FIELDCAPTION("PM Order Status"))
        //         else
        //           Confirmed := true;

        //         if not Confirmed then
        //           "PM Order Status" := xRec."PM Order Status";
        //     end;
        // }
        // field(2034942;"Plant Maintenance Caption";Boolean)
        // {
        //     CaptionML = ENU='Plant Maintenance Caption',
        //                 FRA='Label Maintenance Usine';
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        //     FieldClass = FlowFilter;
        // }
        // field(2034954;"Down Time (Hours)";Decimal)
        // {
        //     CaptionML = ENU='Down Time (Hours)',
        //                 FRA='Délai d''arrêt (heures)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        // }
        // field(2034961;"TPM Code";Code[10])
        // {
        //     CaptionML = ENU='TPM Code',
        //                 FRA='Code TPM';
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        //     TableRelation = "TPM Code".Code;
        // }
        // field(2034962;"TPM Tag No.";Code[20])
        // {
        //     CaptionML = ENU='TPM Tag No.',
        //                 FRA='N° Tag TPM';
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        // }
        // field(2034968;"Classification Group 1 Code";Code[10])
        // {
        //     CaptionClass = '2034958,3,1';
        //     CaptionML = ENU='Contract Group 1 Code',
        //                 FRA='Code groupe contrat 1';
        //     Description = 'DITW16.00.00.41 DIT-715 #438';
        //     TableRelation = "Property Classification Group".Code WHERE ("Level Group"=CONST(1));
        // }
        // field(2034969;"Classification Group 2 Code";Code[10])
        // {
        //     CaptionClass = '2034958,3,2';
        //     CaptionML = ENU='Contract Group 2 Code',
        //                 FRA='Code groupe contrat 2';
        //     Description = 'DITW16.00.00.41 DIT-715 #438';
        //     TableRelation = "Property Classification Group".Code WHERE ("Level Group"=CONST(2));
        // }
        // field(2034970;"Classification Group 3 Code";Code[10])
        // {
        //     CaptionClass = '2034958,3,3';
        //     CaptionML = ENU='Contract Group 3 Code',
        //                 FRA='Code groupe contrat 3';
        //     Description = 'DITW16.00.00.41 DIT-715 #438';
        //     TableRelation = "Property Classification Group".Code WHERE ("Level Group"=CONST(3));
        // }
        // field(2034971;"Project Main No.";Code[20])
        // {
        //     CaptionML = ENU='Project No.',
        //                 FRA='N° Projet';
        //     Description = 'DITW16.00.00.41 DIT-715 #439';
        //     TableRelation = "Project Main Header";

        //     trigger OnValidate();
        //     var
        //         ProjectMainLine : Record "Project Main Line";
        //     begin
        //         // <<DITW16.00.00.41 DDR 25/09/2012 DIT-715 #439
        //         if "Project Main No." <> xRec."Project Main No." then begin
        //           if "Project Main No." <> '' then begin
        //             ProjectMainHeader.GET("Project Main No.");
        //             ProjectMainHeader.TESTFIELD(Blocked,false);
        //             ProjectMainLine.INIT;
        //             ProjectMainLine."Project Main No." := ProjectMainHeader."No.";
        //             ProjectMainLine."Service Header No." := "No.";
        //             ProjectMainLine.INSERT;
        //           end;
        //           if xRec."Project Main No." <> '' then begin
        //             ProjectMainHeader.GET(xRec."Project Main No.");
        //             ProjectMainHeader.TESTFIELD(Blocked,false);
        //             if ProjectMainLine.GET(ProjectMainHeader."No.","No.") then
        //               ProjectMainLine.DELETE;
        //           end;
        //         end;
        //     end;
        // }
        // field(2034972;"Service Item No.";Code[20])
        // {
        //     CalcFormula = Lookup("Service Item Line"."Service Item No." WHERE ("Document Type"=FIELD("Document Type"),
        //                                                                        "Document No."=FIELD("No.")));
        //     CaptionML = ENU='Object No.',
        //                 FRA='No. équipement';
        //     Description = 'DITW16.00.00.42 DIT-715 #455';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2034973;"Service Description";Text[50])
        // {
        //     CalcFormula = Lookup("Service Item Line".Description WHERE ("Document Type"=FIELD("Document Type"),
        //                                                                 "Document No."=FIELD("No.")));
        //     CaptionML = ENU='Service Description',
        //                 FRA='Désignation Service';
        //     Description = 'DITW16.00.00.42 DIT-715 #455';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2034974;"Parent No.";Code[20])
        // {
        //     CaptionML = ENU='Parent No.',
        //                 FRA='N° parent';
        //     Description = 'DITW16.00.00.42 DIT-715 #455';
        //     TableRelation = "Service Header"."No." WHERE ("Document Type"=CONST(Order),
        //                                                   "Plant Maintenance Caption"=CONST(true));
        // }
        //BC Upgrade KAMNAY01<<<<
    }
    keys
    {
        //BC Upgrade KAMNAY01<<<<
        // key(Key1;"DIT Sub-Contract Type")
        // {
        // }
        //BC Upgrade KAMNAY01>>>>
        //key(Key10; "Customer No.", "Currency Code", "Ship-to Code")  // BC Upgrade NANDIS03 - Key 10 is already in standard
        key(Key50001; "Customer No.", "Currency Code", "Ship-to Code")  // BC Upgrade NANDIS03 - Key 10 is already in standard
        {
        }
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: ExpectedServLine)();
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
    IF NOT UserSetupMgt.CheckRespCenter(2,"Responsibility Center") THEN
      ERROR(
        Text000,
        RespCenter.TABLECAPTION,UserSetupMgt.GetServiceFilter);

    IF "Document Type" = "Document Type"::Invoice THEN BEGIN
      ServLine.RESET;
      ServLine.SETRANGE("Document Type",ServLine."Document Type"::Invoice);
      ServLine.SETRANGE("Document No.","No.");
      ServLine.SETFILTER("Appl.-to Service Entry",'>%1',0);
      IF NOT ServLine.ISEMPTY THEN
        ERROR(Text046,"No.");
    end;

    ServPost.DeleteHeader(
      Rec,ServShptHeader,ServInvHeader,ServCrMemoHeader);
    #17..23
    WhseRequest.SETRANGE("Source Type",DATABASE::"Service Line");
    WhseRequest.SETRANGE("Source Subtype","Document Type");
    WhseRequest.SETRANGE("Source No.","No.");
    IF NOT WhseRequest.ISEMPTY THEN
      WhseRequest.DELETEALL(TRUE);

    ServLine.SETRANGE("Document Type","Document Type");
    ServLine.SETRANGE("Document No.","No.");
    ServLine.SuspendStatusCheck(TRUE);
    ServLine.DELETEALL(TRUE);

    ServCommentLine.RESET;
    ServCommentLine.SETRANGE("Table Name",ServCommentLine."Table Name"::"Service Header");
    ServCommentLine.SETRANGE("Table Subtype","Document Type");
    ServCommentLine.SETRANGE("No.","No.");
    ServCommentLine.DELETEALL;

    ServDocRegister.SETCURRENTKEY("Destination Document Type","Destination Document No.");
    CASE "Document Type" OF
      "Document Type"::Invoice:
        BEGIN
          ServDocRegister.SETRANGE("Destination Document Type",ServDocRegister."Destination Document Type"::Invoice);
          ServDocRegister.SETRANGE("Destination Document No.","No.");
          ServDocRegister.DELETEALL;
        end;
      "Document Type"::"Credit Memo":
        BEGIN
          ServDocRegister.SETRANGE("Destination Document Type",ServDocRegister."Destination Document Type"::"Credit Memo");
          ServDocRegister.SETRANGE("Destination Document No.","No.");
          ServDocRegister.DELETEALL;
        end;
    end;

    ServOrderAlloc.RESET;
    ServOrderAlloc.SETCURRENTKEY("Document Type");
    ServOrderAlloc.SETRANGE("Document Type","Document Type");
    ServOrderAlloc.SETRANGE("Document No.","No.");
    ServOrderAlloc.SETRANGE(Posted,FALSE);
    ServOrderAlloc.DELETEALL;
    ServAllocMgt.SetServOrderAllocStatus(Rec);

    ServItemLine.RESET;
    ServItemLine.SETRANGE("Document Type","Document Type");
    ServItemLine.SETRANGE("Document No.","No.");
    IF ServItemLine.FIND('-') THEN
      REPEAT
        IF ServItemLine."Loaner No." <> '' THEN BEGIN
          Loaner.GET(ServItemLine."Loaner No.");
          LoanerEntry.SETRANGE("Document Type","Document Type" + 1);
          LoanerEntry.SETRANGE("Document No.","No.");
          LoanerEntry.SETRANGE("Loaner No.",ServItemLine."Loaner No.");
          LoanerEntry.SETRANGE(Lent,TRUE);
          IF NOT LoanerEntry.ISEMPTY THEN
            ERROR(
              Text040,
              TABLECAPTION,
              ServItemLine."Document No.",
              ServItemLine."Line No.",
              ServItemLine.FIELDCAPTION("Loaner No."),
              ServItemLine."Loaner No.");

          LoanerEntry.SETRANGE(Lent,TRUE);
          LoanerEntry.DELETEALL;
        end;

        CLEAR(ServLogMgt);
        ServLogMgt.ServItemOffServOrder(ServItemLine);
        ServItemLine.DELETE;
      UNTIL ServItemLine.NEXT = 0;

    ServDocLog.RESET;
    ServDocLog.SETRANGE("Document Type","Document Type");
    #96..102
      ServDocLog."Document Type"::"Posted Credit Memo");
    ServDocLog.DELETEALL;

    IF (ServShptHeader."No." <> '') OR
       (ServInvHeader."No." <> '') OR
       (ServCrMemoHeader."No." <> '')
    THEN
      MESSAGE(PostedDocsToPrintCreatedMsg);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if not UserSetupMgt.CheckRespCenter(2,"Responsibility Center") then
    #2..5
    // <<DITW15.00.00.36 DDR 18/09/2009
    if DitServSetup.READPERMISSION then
      UndoServContractDoc.CheckDelPrevServHeaderInvoices(Rec)
    else
    // >>DITW15.00.00.36 DDR
      if "Document Type" = "Document Type"::Invoice then begin
        ServLine.RESET;
        ServLine.SETRANGE("Document Type",ServLine."Document Type"::Invoice);
        ServLine.SETRANGE("Document No.","No.");
        ServLine.SETFILTER("Appl.-to Service Entry",'>%1',0);
        if not ServLine.ISEMPTY then
          ERROR(Text046,"No.");
      end;
    #14..26
    if not WhseRequest.ISEMPTY then
      WhseRequest.DELETEALL(true);
    #29..31
    //? DITW110.00.08 DDR 02/01/2017 NRQ#0 check if work deleteall(true)
    ServLine.SuspendStatusCheck(true);
    // <<DITW15.00.00.36 DDR 18/09/2009 - 15/12/2009 - DITW17.00.01 DDR 21/11/2012 DIT-770 #001
    ServLine.SetDeleteFromHeader(true);
    // >>DITW15.00.00.36 DDR - DITW17.00.01 DDR 21/11/2012 DIT-770 #001
    ServLine.DELETEALL(true);
    #34..41
    case "Document Type" of
      "Document Type"::Invoice:
        begin
    #45..47
        end;
      "Document Type"::"Credit Memo":
        begin
    #51..53
        end;
    end;
    #56..60
    ServOrderAlloc.SETRANGE(Posted,false);
    #62..67
    if ServItemLine.FIND('-') then
      repeat
        if ServItemLine."Loaner No." <> '' then begin
    #71..74
          LoanerEntry.SETRANGE(Lent,true);
          if not LoanerEntry.ISEMPTY then
    #77..84
          LoanerEntry.SETRANGE(Lent,true);
          LoanerEntry.DELETEALL;
        end;
    #88..91

        // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
        ServItemLine.DeleteMTaskRelations();
        ServItemLine.DeleteExpectedServLines();
        // >>DITW16.00.00.41 DDR DIT-715 #297

      until ServItemLine.NEXT = 0;
    #93..105
    if (ServShptHeader."No." <> '') or
       (ServInvHeader."No." <> '') or
       (ServCrMemoHeader."No." <> '')
    then
      MESSAGE(PostedDocsToPrintCreatedMsg);
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInsert". Please convert manually.

    //trigger (Variable: OldHideValidationDialog)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ServSetup.GET ;
    IF "No." = '' THEN BEGIN
      TestNoSeries;
      NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series",0D,"No.","No. Series");
    end;

    ServShptHeader.SETRANGE("Order No.","No.");
    IF NOT ServShptHeader.ISEMPTY THEN
      ERROR(Text008,FORMAT("Document Type"),FIELDCAPTION("No."),"No.");

    InitRecord;

    CLEAR(ServLogMgt);
    ServLogMgt.ServHeaderCreate(Rec);

    IF GETFILTER("Customer No.") <> '' THEN BEGIN
      CLEAR(xRec."Ship-to Code");
      IF GETRANGEMIN("Customer No.") = GETRANGEMAX("Customer No.") THEN
        VALIDATE("Customer No.",GETRANGEMIN("Customer No."));
    end;

    IF GETFILTER("Contact No.") <> '' THEN
      IF GETRANGEMIN("Contact No.") = GETRANGEMAX("Contact No.") THEN
        VALIDATE("Contact No.",GETRANGEMIN("Contact No."));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ServSetup.GET;
    // <<DITW15.00.00.35 DDR 17/04/2009
    // <<DITW18.00.06 DDR 20/04/2015 DIT-770 #1234
    if ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") and DitServSetup.READPERMISSION then
    // >>DITW18.00.06 DDR DIT-770 #1234
      DitServSetup.GET;
    // >>DITW15.00.00.35 DDR
    // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
    if "DIT Sub-Contract Type" = "DIT Sub-Contract Type"::PlantMaintenance then
      PlantMaintSetup.GET;
    // >>DITW16.00.00.41 DDR DIT-715 #297
    if "No." = '' then begin
      TestNoSeries;
      NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series",0D,"No.","No. Series");
    end;

    ServShptHeader.SETRANGE("Order No.","No.");
    if not ServShptHeader.ISEMPTY then
    #9..12
    // <<DITW16.00.00.41 DDR 18/09/2012 DIT-715 #436
    if ("DIT Sub-Contract Type" = "DIT Sub-Contract Type"::PlantMaintenance) and
      ("Customer No." <> '') and ("Bill-to Customer No." = '') and
      (GETFILTER("Customer No.") = '')
    then begin
      OldHideValidationDialog := HideValidationDialog;
      HideValidationDialog := true;
      xRec."Customer No." := '';
      VALIDATE("Customer No.");
      HideValidationDialog := OldHideValidationDialog;
    end;
    // >>DITW16.00.00.41 DDR DIT-715 #436

    #13..15
    if GETFILTER("Customer No.") <> '' then begin
      CLEAR(xRec."Ship-to Code");
      if GETRANGEMIN("Customer No.") = GETRANGEMAX("Customer No.") then
        VALIDATE("Customer No.",GETRANGEMIN("Customer No."));
    end;

    if GETFILTER("Contact No.") <> '' then
      if GETRANGEMIN("Contact No.") = GETRANGEMAX("Contact No.") then
        VALIDATE("Contact No.",GETRANGEMIN("Contact No."));
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    //BC Upgrade KAMNAY01>>>>
    //var
    //LocationCode : Code[20];

    // var
    //ExpectedServLine : Record "Expected Service Line";
    //MTaskRelation : Record "Maintenance Task Relation";

    // var
    //OldHideValidationDialog : Boolean;

    // var
    // DocSubtypeCodeSetup : Record "Doc Subtype Code Setup FND";
    //BC Upgrade KAMNAY01<<<<


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : @@@="%1=Responsibility center table caption;%2=User management service filter;";ENU=You cannot delete this document. Your identification is set up to process from %1 %2 only.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : @@@="%1=Responsibility center table caption;%2=User management service filter;";ENU=You cannot delete this document. Your identification is set up to process from %1 %2 only.;FRA=Vous ne pouvez pas supprimer ce document. Le paramétrage de votre code utilisateur ne vous permet de travailler que sur %1 %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Changing %1 in service header %2 will not update the existing service lines.\You must update the existing service lines manually.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Changing %1 in service header %2 will not update the existing service lines.\You must update the existing service lines manually.;FRA=La modification de %1 dans l'en-tête de service %2 ne met pas à jour les lignes service existantes.\Vous devez mettre à jour les lignes service existantes manuellement.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : @@@="%1=Customer number field caption;%2=Document type;%3=Number field caption;%4=Number;%5=Contract number field caption;%6=Contract number; ";ENU=You cannot change the %1 because the %2 %3 %4 is associated with a %5 %6.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : @@@="%1=Customer number field caption;%2=Document type;%3=Number field caption;%4=Number;%5=Contract number field caption;%6=Contract number; ";ENU=You cannot change the %1 because the %2 %3 %4 is associated with a %5 %6.;FRA=Vous ne pouvez pas modifier le %1, car le %2 %3 %4 est associé à un %5 %6.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=When you change the %1 the existing Service item line and service line will be deleted.\Do you want to change the %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=When you change the %1 the existing Service item line and service line will be deleted.\Do you want to change the %1?;FRA=Si vous modifiez %1, la ligne article service et la ligne service existantes seront supprimées.\Voulez-vous modifier %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=Do you want to change the %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=Do you want to change the %1?;FRA=Souhaitez-vous modifier l'enregistrement %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=%1 cannot be greater than %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=%1 cannot be greater than %2.;FRA=L'%1 ne peut pas être supérieur à l'%2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : @@@="%1=Document type format;%2=Number field caption;%3=Number;";ENU="You cannot create Service %1 with %2=%3 because this number has already been used in the system.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : @@@="%1=Document type format;%2=Number field caption;%3=Number;";ENU="You cannot create Service %1 with %2=%3 because this number has already been used in the system.";FRA="Vous ne pouvez pas créer de %1 Service avec %2=%3 car cette valeur a déjà été utilisée dans le système.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text010(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : @@@="%1=Resposibility center table caption;%2=User management service filter;";ENU=Your identification is set up to process from %1 %2 only.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : @@@="%1=Resposibility center table caption;%2=User management service filter;";ENU=Your identification is set up to process from %1 %2 only.;FRA=Le paramétrage de votre code utilisateur ne vous permet de travailler que sur %1 %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text011(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=%1 cannot be greater than %2 in the %3 table.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=%1 cannot be greater than %2 in the %3 table.;FRA=%1 ne peut pas être supérieur(e) à %2 dans la table %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text012(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU=If you change %1, the existing service lines will be deleted and the program will create new service lines based on the new information on the header.\Do you want to change the %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : ENU=If you change %1, the existing service lines will be deleted and the program will create new service lines based on the new information on the header.\Do you want to change the %1?;FRA=Si vous modifiez %1, les lignes service existantes seront supprimées et le programme créera des lignes service basées sur les nouvelles informations de l'en-tête.\Voulez-vous modifier %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text013(Variable 1089)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text013 : ENU=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text013 : ENU=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche d'avoirs enregistrés. Un avoir enregistré vide %1 va être créé pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text015(Variable 1015)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text015 : ENU=Do you want to update the exchange rate?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text015 : ENU=Do you want to update the exchange rate?;FRA=Souhaitez-vous mettre à jour le taux de change ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text016(Variable 1016)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text016 : ENU=You have modified %1.\Do you want to update the service lines?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text016 : ENU=You have modified %1.\Do you want to update the service lines?;FRA=Vous avez modifié %1.\Voulez-vous mettre à jour les lignes service ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text018(Variable 1018)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text018 : @@@="%1=Service order type field caption;%2=table caption;%3=Document type field caption;%4=Document type format;%5=Number field caption;%6=Number format;";ENU="You have not specified the %1 for %2 %3=%4, %5=%6.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text018 : @@@="%1=Service order type field caption;%2=table caption;%3=Document type field caption;%4=Document type format;%5=Number field caption;%6=Number format;";ENU="You have not specified the %1 for %2 %3=%4, %5=%6.";FRA="Vous n'avez pas défini le %1 pour %2 %3=%4, %5=%6.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text019(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text019 : ENU=You have changed %1 on the service header, but it has not been changed on the existing service lines.\The change may affect the exchange rate used in the price calculation of the service lines.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text019 : ENU=You have changed %1 on the service header, but it has not been changed on the existing service lines.\The change may affect the exchange rate used in the price calculation of the service lines.;FRA=Vous avez modifié %1 dans l'en-tête service, mais il n'a pas été modifié dans les lignes service existantes.\Ce changement peut affecter le taux de change utilisé dans le calcul de prix des lignes service.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text021(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text021 : ENU=You have changed %1 on the %2, but it has not been changed on the existing service lines.\You must update the existing service lines manually.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text021 : ENU=You have changed %1 on the %2, but it has not been changed on the existing service lines.\You must update the existing service lines manually.;FRA=Vous avez modifié %1 du/de la %2, mais il/elle n'a pas été modifié(e) sur les lignes service existantes.\Vous devez mettre à jour les lignes service existantes manuellement.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text024(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text024 : ENU=The %1 cannot be greater than the minimum %1 of the\ Service Item Lines.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text024 : ENU=The %1 cannot be greater than the minimum %1 of the\ Service Item Lines.;FRA=Le/la %1 ne peut pas être supérieur(e) au/à la %1 minimum des\ lignes article service.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text025(Variable 1050)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text025 : ENU=The %1 cannot be less than the maximum %1 of the related\ Service Item Lines.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text025 : ENU=The %1 cannot be less than the maximum %1 of the related\ Service Item Lines.;FRA=Le/la %1 ne peut pas être inférieur(e) au/à la %1 maximum des\ lignes article service associées.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text026(Variable 1051)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text026 : ENU=%1 cannot be earlier than the %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text026 : ENU=%1 cannot be earlier than the %2.;FRA=%1 ne doit pas être antérieure au %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text027(Variable 1052)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text027 : ENU=The %1 cannot be greater than the minimum %2 of the related\ Service Item Lines.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text027 : ENU=The %1 cannot be greater than the minimum %2 of the related\ Service Item Lines.;FRA=Le/la %1 ne peut pas être supérieur(e) au/à la %2 minimum des\ lignes article service associées.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text028(Variable 1057)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text028 : ENU=You cannot change the %1 because %2 exists.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text028 : ENU=You cannot change the %1 because %2 exists.;FRA=Vous ne pouvez pas modifier %1 parce que il existe des %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text029(Variable 1056)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text029 : ENU=The %1 field on the %2 will be updated if you change %3 manually.\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text029 : ENU=The %1 field on the %2 will be updated if you change %3 manually.\Do you want to continue?;FRA=Le champ %1 du formulaire %2 sera mis à jour si vous modifiez manuellement la valeur %3.\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text031(Variable 1059)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text031 : @@@="%1=Status field caption;%2=Status format;%3=table caption;%4=Number;%5=ServItemLine repair status code field caption;%6=ServItemLine repair status code;%7=ServItemLine table caption;%8=ServItemLine line number;";ENU=You cannot change %1 to %2 in %3 %4.\\%5 %6 in %7 %8 line is preventing it.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text031 : @@@="%1=Status field caption;%2=Status format;%3=table caption;%4=Number;%5=ServItemLine repair status code field caption;%6=ServItemLine repair status code;%7=ServItemLine table caption;%8=ServItemLine line number;";ENU=You cannot change %1 to %2 in %3 %4.\\%5 %6 in %7 %8 line is preventing it.;FRA=Vous ne pouvez pas modifier %1 en %2 dans %3%4.\\%5%6 de la ligne %7 %8 vous empêche de le faire.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text037(Variable 1060)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text037 : @@@="%1=Contact number;%2=Contact name;%3=Customer number;";ENU=Contact %1 %2 is not related to customer %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text037 : @@@="%1=Contact number;%2=Contact name;%3=Customer number;";ENU=Contact %1 %2 is not related to customer %3.;FRA=Le contact %1 %2 n'est pas associé au client %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text038(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text038 : @@@="%1=Contact number;%2=Contact name;%3=Customer number;";ENU=Contact %1 %2 is related to a different company than customer %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text038 : @@@="%1=Contact number;%2=Contact name;%3=Customer number;";ENU=Contact %1 %2 is related to a different company than customer %3.;FRA=Le contact %1 %2 est associé à une société différente de celle du client %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text039(Variable 1061)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text039 : @@@="%1=Contact number;%2=Contact name;";ENU=Contact %1 %2 is not related to a customer.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text039 : @@@="%1=Contact number;%2=Contact name;";ENU=Contact %1 %2 is not related to a customer.;FRA=Le contact %1 %2 n'est associé à aucun client.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text040(Variable 1063)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text040 : @@@="%1=table caption;%2=ServItemLine document number;%3=ServItemLine line number;%4=ServItemLine loaner number field caption;%5=ServItemLine loaner number;";ENU=You cannot delete %1 %2 because the %4 %5 for Service Item Line %3 has not been received.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text040 : @@@="%1=table caption;%2=ServItemLine document number;%3=ServItemLine line number;%4=ServItemLine loaner number field caption;%5=ServItemLine loaner number;";ENU=You cannot delete %1 %2 because the %4 %5 for Service Item Line %3 has not been received.;FRA=Vous ne pouvez pas supprimer la %1 %2, car l'%4 %5 pour la ligne article de service %3 n'a pas été réceptionné.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text041(Variable 1068)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text041 : ENU=Contract %1 is not signed.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text041 : ENU=Contract %1 is not signed.;FRA=Le contrat %1 n'a pas été signé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text042(Variable 1069)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text042 : ENU=The service period for contract %1 has not yet started.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text042 : ENU=The service period for contract %1 has not yet started.;FRA=La période de service du contrat %1 n'a pas encore commencé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text043(Variable 1070)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text043 : ENU=The service period for contract %1 has expired.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text043 : ENU=The service period for contract %1 has expired.;FRA=La période de service du contrat %1 a expiré.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text044(Variable 1073)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text044 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text044 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text045(Variable 1083)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text045 : @@@="%1=Posting date field caption;%2=Posting number series field caption;%3=Posting number series;%4=NoSeries date order field caption;%5=NoSeries date order;%6=Document type;%7=posting number field caption;%8=Posting number;";ENU="You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text045 : @@@="%1=Posting date field caption;%2=Posting number series field caption;%3=Posting number series;%4=NoSeries date order field caption;%5=NoSeries date order;%6=Document type;%7=posting number field caption;%8=Posting number;";ENU="You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.";FRA="Vous ne pouvez pas modifier le champ %1 car %2 %3 a %4 = %5 et %6 a déjà été affecté(e) à %7 %8.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text046(Variable 1104)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text046 : ENU=You cannot delete invoice %1 because one or more service ledger entries exist for this invoice.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text046 : ENU=You cannot delete invoice %1 because one or more service ledger entries exist for this invoice.;FRA=Vous ne pouvez pas supprimer la facture %1 car il existe une ou plusieurs écritures comptables service pour cette facture.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text047(Variable 1100)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text047 : ENU=You cannot change %1 because reservation, item tracking, or order tracking exists on the sales order.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text047 : ENU=You cannot change %1 because reservation, item tracking, or order tracking exists on the sales order.;FRA=Vous ne pouvez pas modifier %1 car une réservation, une traçabilité ou un chaînage existe sur la commande vente.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text050(Variable 1094)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text050 : ENU=You cannot reset %1 because the document still has one or more lines.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text050 : ENU=You cannot reset %1 because the document still has one or more lines.;FRA=Impossible de réinitialiser %1 car le document contient une ou plusieurs ligne(s).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text051(Variable 1082)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text051 : @@@="%1=Document type format;%2=Number;";ENU=The service %1 %2 already exists.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text051 : @@@="%1=Document type format;%2=Number;";ENU=The service %1 %2 already exists.;FRA=Le service %1 %2 existe déjà.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text053(Variable 1093)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text053 : ENU=Deleting this document will cause a gap in the number series for shipments. An empty shipment %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text053 : ENU=Deleting this document will cause a gap in the number series for shipments. An empty shipment %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche expédition. Une expédition vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text054(Variable 1091)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text054 : ENU=Deleting this document will cause a gap in the number series for posted invoices. An empty posted invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text054 : ENU=Deleting this document will cause a gap in the number series for posted invoices. An empty posted invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des factures enregistrées. Une facture enregistrée vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text055(Variable 1079)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text055 : ENU=You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. Do you want to update the %2 field on the lines to reflect the new value of %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text055 : ENU=You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. Do you want to update the %2 field on the lines to reflect the new value of %1?;FRA=Vous avez modifié le champ %1. Le recalcul de la TVA va provoquer de petites différences et vous devrez donc vérifier les montants par la suite. Voulez-vous mettre à jour le champ %2 sur les lignes pour refléter la nouvelle valeur de %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text057(Variable 1103)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text057 : ENU=When you change the %1 the existing service line will be deleted.\Do you want to change the %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text057 : ENU=When you change the %1 the existing service line will be deleted.\Do you want to change the %1?;FRA=Si vous modifiez %1, la ligne service existante sera supprimée.\Voulez-vous vraiment modifier %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text058(Variable 1088)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text058 : @@@="%1=Currency code field caption;%2=Document type;%3=Number;%4=Contract number;";ENU=You cannot change %1 because %2 %3 is linked to Contract %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text058 : @@@="%1=Currency code field caption;%2=Document type;%3=Number;%4=Contract number;";ENU=You cannot change %1 because %2 %3 is linked to Contract %4.;FRA=Vous ne pouvez pas modifier le %1 car %2 %3 est lié(e) au contrat %4.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text060(Variable 1154)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text060 : @@@="%1=Assigned user ID;%2=Responsibility Center table caption;%2=User management service filter assigned user id;";ENU=%1 is set up to process from %2 %3 only.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text060 : @@@="%1=Assigned user ID;%2=Responsibility Center table caption;%2=User management service filter assigned user id;";ENU=%1 is set up to process from %2 %3 only.;FRA=%1 est paramétré pour traiter uniquement à partir de %2 %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text061(Variable 1099)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text061 : ENU=You may have changed a dimension.\\Do you want to update the lines?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text061 : ENU=You may have changed a dimension.\\Do you want to update the lines?;FRA=Vous avez probablement modifié un axe analytique.\\Souhaitez-vous mettre à jour les lignes ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text062(Variable 1087)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text062 : ENU=An open inventory pick exists for the %1 and because %2 is %3.\\You must first post or delete the inventory pick or change %2 to Partial.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text062 : ENU=An open inventory pick exists for the %1 and because %2 is %3.\\You must first post or delete the inventory pick or change %2 to Partial.;FRA=Il existe un prélèvement stock ouvert pour le %1 et parce que %2 est %3.\\Vous devez tout d'abord valider ou supprimer le prélèvement stock ou changer %2 par Partielle.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text063(Variable 1102)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text063 : ENU=An open warehouse shipment exists for the %1 and %2 is %3.\\You must add the item(s) as new line(s) to the existing warehouse shipment or change %2 to Partial.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text063 : ENU=An open warehouse shipment exists for the %1 and %2 is %3.\\You must add the item(s) as new line(s) to the existing warehouse shipment or change %2 to Partial.;FRA=Il existe une expédition entrepôt ouverte pour le %1 et %2 est %3.\\Vous devez ajouter les articles comme nouvelles lignes à l'expédition entrepôt existante ou changer %2 par Partielle.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text064(Variable 1105)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text064 : ENU=You cannot change %1 to %2 because an open inventory pick on the %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text064 : ENU=You cannot change %1 to %2 because an open inventory pick on the %3.;FRA=Vous ne pouvez pas modifier %1 en %2 car un prélèvement stock est ouvert sur %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text065(Variable 1106)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text065 : ENU=You cannot change %1  to %2 because an open warehouse shipment exists for the %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text065 : ENU=You cannot change %1  to %2 because an open warehouse shipment exists for the %3.;FRA=Vous ne pouvez pas modifier %1 en %2 car il existe une expédition entrepôt ouverte pour %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text066(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text066 : ENU=You cannot change the dimension because there are service entries connected to this line.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text066 : ENU=You cannot change the dimension because there are service entries connected to this line.;FRA=Vous ne pouvez pas modifier l'axe car des écritures service sont connectées à cette ligne.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "PostedDocsToPrintCreatedMsg(Variable 1022)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PostedDocsToPrintCreatedMsg : ENU=One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PostedDocsToPrintCreatedMsg : ENU=One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.;FRA=Un ou plusieurs documents validés connexes ont été générés lors de la suppression pour éviter une discontinuité dans la souche de numéros de validation. Vous pouvez afficher ou imprimer les documents à partir de l'archive de document correspondant.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DocumentNotPostedClosePageQst(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DocumentNotPostedClosePageQst : ENU=The document has not been posted.\Are you sure you want to exit?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DocumentNotPostedClosePageQst : ENU=The document has not been posted.\Are you sure you want to exit?;FRA=Le document n'a pas été validé.\Voulez-vous vraiment quitter ?;
    //Variable type has not been exported.

    var
        // DitServSetup : Record "Property Service Mgt. Setup";  //BC Upgrade KAMNAY01
        ContractGr: Record "Contract Group";
        Location: Record Location;
        SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
        //BC Upgrade KAMNAY01>>>>
        // UndoServContractDoc : Codeunit UndoSignServContractDoc;
        // SSCCSetup : Record "SSCC Setup;
        //BC Upgrade KAMNAY01<<<<
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        // Building : Record Building;  //BC Upgrade KAMNAY01
        ServPostJnl: Codeunit "Serv-Posting Journals Mgt.";
        ServLineReserve: Codeunit "Service Line-Reserve";
        //ProjectMainHeader : Record "Project Main Header";   //BC Upgrade KAMNAY01
        UserMgt: Codeunit "User Setup Management";
        //PlantMaintSetup : Record "Plant Maintenance Setup";  //BC Upgrade KAMNAY01
        RunModeCaptionPM: Boolean;
        // SSCCLineReserv : Codeunit "SSCC Line-Reserve";  //BC Upgrade KAMNAY01
        SSCCExistRecreateLine: Boolean;
        Text2014310_2: TextConst ENU = 'Plant- / Customer No.', FRA = 'N° Usine / Client';
        Text2014310_5904: TextConst ENU = 'Maintenance Activity Type', FRA = 'Type activité de maintenance';
        Text2014310_5905: TextConst ENU = 'Link Work to Object', FRA = 'Lier BT à Equipement';
        Text2014310_5936: TextConst ENU = 'Notify Plant', FRA = 'Informer Usine';
        Text2014310_5940: TextConst ENU = 'Maintenance Plan No.', FRA = 'N° Plan de Maintenance';
        Text2014310_5952: TextConst ENU = 'Plant Filter', FRA = 'Filtre Usine';
        Text2014410: TextConst ENU = 'If you change %1, all existing sales charge lines will be deleted and new sales charge lines based on the new information on the header will be created.\\', FRA = 'Si vous modifiez l''enregistrement %1, toutes les lignes de frais vente existantes seront supprimées et de nouvelles lignes de frais vente seront créées.\\';
        Text2014412: TextConst ENU = 'You cannot use the %1 %2 because your identification is set up to process from %3 %4 only.', FRA = 'Vous ne pouvez pas utiliser le %1 %2 parce que votre identification est configurée pour traiter de %3 %4 seulement.';
        Text2014413: TextConst ENU = 'If you change %1, all existing will be updated and all sales charge lines will be deleted and new sales charge lines based on the new information on the header will be created.\\', FRA = 'Si vous changez %1, tous les existants seront mis à jour et toutes les lignes de frais de souscription seront supprimés et de nouvelles lignes de frais d''acquisition sur la base de nouvelles informations sur l''en-tête seront créés \\.';
        Text2014414: TextConst ENU = '%1 %2 is assigned to %3 %4 and your identification is not set up to process.\\', FRA = '%1 %2 est affectée à %3 %4 et votre identification ne soit pas mis en place pour traiter. \\';
        Text2014415: TextConst ENU = 'Do you want to continue?', FRA = 'Souhaitez-vous continuer?';
        Text2014416: TextConst ENU = 'The user has been interrupted the process to respect the warning.', FRA = 'L''utilisateur a interrompu le processus pour respecter l''alerte.';
        Text2029610: TextConst ENU = 'Recycle charge lines exist. Do you want to recalculate?', FRA = 'Voulez-vous calculé des axionnes?';
        Text2029611: TextConst ENU = 'Do you want to calculate charges?', FRA = 'Voulez-vous calculé des axionnes?';
        Text2034940: TextConst ENU = 'Do you want to change the %1 to ''%2''?', FRA = 'Souhaitez-vous modifier le %1 sur ''%2'' ?';
        Text2035040: TextConst ENU = 'You cannot change %1 because reservation, item tracking, or order tracking exists on the sales order.', FRA = 'Vous ne pouvez pas modifier %1 car une réservation, une traçabilité ou un chaînage existe sur la commande vente.';
        Text2035041: TextConst ENU = 'The sales %1 %2 has also SSCC tracking. Do you want to delete it anyway?', FRA = 'La vente %1 %2 a aussi une traçabilité SSCC. Souhaitez-vous quand même la supprimer ?';
    // recFinXLSetup : Record "Finance XL Setup";  //BC Upgrade KAMNAY01

}