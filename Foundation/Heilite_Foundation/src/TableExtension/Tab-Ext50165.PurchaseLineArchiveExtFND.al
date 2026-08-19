tableextension 50165 PurchaseLineArchiveExtFND extends "Purchase Line Archive"
{
    // version NAVW110.0.00.16585,QXL9.00.001,DITW110.00.09,HEI.12
    //     HEI.01 HLSRM02 IBM LAZARE02 17.08.2017
    //   #New fields for SRM integration
    // HEI.02 FDD-PURGAPINT002 IBM LAZARE02 25.09.2017
    //   # New fields "Maximo Requisition No.", "Maximo Requisition Line No."
    // HEI.03 DefectID 818 IBM.CHAUHB01 14.12.2017
    //  # Added new flow field "Machine Reference No."
    // HEI.04 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Field created: 50033 - "TIN No."
    // HEI.05 CHG0257267 IBM.AB 16.01.2019
    //   # Field length for Prod. BOM Version Code is increased from 10 to 20
    // DITW110.00.11 MSF 20/12/2017 NRQ#14143  New Option Added to Field   2014504 Calculate Minimum
    //                                                                             Minimum Quantity
    // HEI.06 CHG2024349 IBM.GUNERE01 10.08.2020 # "Machine Reference Number" field type changed to normal from flowfield
    // CHG2104608: DITW111.00.13 ISL 18/12/2018 NRQ#96024 Deleted field 2014461 "Prod. BOM Version Code"
    // HEI.07 CHG2098629 HB2014 IBM NANDIS01 08.04.2021 - LOG_Automatic creation of Transfer Order for Import PO
    //   # New field added - 50049 - TO Reference - Code - 20
    // HEI.08 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //   # New Fields created: 50051 - CAD Amount
    //                         50052 - CAD Attached to Line No.
    // HEI.09 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //   # SPL Code, SPL Name - fields created
    // HEI.10 CHG2210794 SAHAL01 19.03.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Fields: 50075 - Zycus Order No.
    //                         50076 - Zycus Order Line No.
    // HEI.11 CHG2210794 SAHAL01 19.04.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Created New Fields: 50077 - Zycus PR Reference No.
    //                         50078 - Zycus PO Type Code
    //                         50079 - Zycus PO Line Type Code
    //                         50080 - Zycus PO Line Validated
    //   # Modified Fields Properties.
    // HEI.12 CHG2210794 SAHAL01 10.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Created New Field: 50085 - Zycus Movement Type
    //********************************************************************************************
    //BC UPGRADE PATHAA02 06.11.25
    //SRM, MAXIMO, Zycus Interface Fields found
    //Fields Found in NAV(no customisations) are not in NAV-F5705-"Cross-Reference No.",F5706-"Unit of Measure (Cross Ref.)",F707-"Cross-Reference Type",F5708-"Cross-Reference Type No.",F5712-"Product Group Code"
    //BC UPGRADE ATHUKUS01 FDDSTP_007 Added new field "Original Quantity".

    fields
    {
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            // OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order', FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
        }
        modify("Buy-from Vendor No.")
        {
            CaptionML = ENU = 'Buy-from Vendor No.', FRA = 'N° fournisseur';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            //OptionCaptionML = ENU = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)', FRA = ' ,Compte général,Article,,Immobilisation,Frais annexes';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Posting Group")
        {
            CaptionML = ENU = 'Posting Group', FRA = 'Groupe comptabilisation';
        }
        modify("Expected Receipt Date")
        {
            CaptionML = ENU = 'Expected Receipt Date', FRA = 'Date réception prévue';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify("Unit of Measure")
        {
            CaptionML = ENU = 'Unit of Measure', FRA = 'Unité';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Outstanding Quantity")
        {
            CaptionML = ENU = 'Outstanding Quantity', FRA = 'Quantité restante';
        }
        modify("Qty. to Invoice")
        {
            CaptionML = ENU = 'Qty. to Invoice', FRA = 'Qté à facturer';
        }
        modify("Qty. to Receive")
        {
            CaptionML = ENU = 'Qty. to Receive', FRA = 'Qté à recevoir';
        }
        modify("Direct Unit Cost")
        {
            CaptionML = ENU = 'Direct Unit Cost', FRA = 'Coût unitaire direct';
        }
        modify("Unit Cost (LCY)")
        {
            CaptionML = ENU = 'Unit Cost (LCY)', FRA = 'Coût unitaire DS';
        }
        modify("VAT %")
        {
            CaptionML = ENU = 'VAT %', FRA = '% TVA';
        }
        modify("Quantity Disc. %")
        {
            CaptionML = ENU = 'Quantity Disc. %', FRA = '% remise quantité';
        }
        modify("Line Discount %")
        {
            CaptionML = ENU = 'Line Discount %', FRA = '% remise ligne';
        }
        modify("Line Discount Amount")
        {
            CaptionML = ENU = 'Line Discount Amount', FRA = 'Montant remise ligne';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Amount Including VAT")
        {
            CaptionML = ENU = 'Amount Including VAT', FRA = 'Montant TTC';
        }
        modify("Unit Price (LCY)")
        {
            CaptionML = ENU = 'Unit Price (LCY)', FRA = 'Prix unitaire DS';
        }
        modify("Allow Invoice Disc.")
        {
            CaptionML = ENU = 'Allow Invoice Disc.', FRA = 'Remise facture autorisée';
        }
        modify("Gross Weight")
        {
            CaptionML = ENU = 'Gross Weight', FRA = 'Poids brut';
        }
        modify("Net Weight")
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
        }
        modify("Units per Parcel")
        {
            CaptionML = ENU = 'Units per Parcel', FRA = 'Conditionnement';
        }
        modify("Unit Volume")
        {
            CaptionML = ENU = 'Unit Volume', FRA = 'Volume unitaire';
        }
        modify("Appl.-to Item Entry")
        {
            CaptionML = ENU = 'Appl.-to Item Entry', FRA = 'Écr. article à lettrer';
        }
        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Job No.")
        {
            CaptionML = ENU = 'Job No.', FRA = 'N° projet';
        }
        modify("Indirect Cost %")
        {
            CaptionML = ENU = 'Indirect Cost %', FRA = '% coût indirect';
        }
        modify("Outstanding Amount")
        {
            CaptionML = ENU = 'Outstanding Amount', FRA = 'Montant en commande';
        }
        modify("Qty. Rcd. Not Invoiced")
        {
            CaptionML = ENU = 'Qty. Rcd. Not Invoiced', FRA = 'Qté reçue non facturée';
        }
        modify("Amt. Rcd. Not Invoiced")
        {
            CaptionML = ENU = 'Amt. Rcd. Not Invoiced', FRA = 'Montant reçu non facturé';
        }
        modify("Quantity Received")
        {
            CaptionML = ENU = 'Quantity Received', FRA = 'Quantité reçue';
        }
        modify("Quantity Invoiced")
        {
            CaptionML = ENU = 'Quantity Invoiced', FRA = 'Quantité facturée';
        }
        modify("Receipt No.")
        {
            CaptionML = ENU = 'Receipt No.', FRA = 'N° bon de réception';
        }
        modify("Receipt Line No.")
        {
            CaptionML = ENU = 'Receipt Line No.', FRA = 'N° ligne bon de réception';
        }
        modify("Profit %")
        {
            CaptionML = ENU = 'Profit %', FRA = '% marge sur vente';
        }
        modify("Pay-to Vendor No.")
        {
            CaptionML = ENU = 'Pay-to Vendor No.', FRA = 'N° fournisseur à payer';
        }
        modify("Inv. Discount Amount")
        {
            CaptionML = ENU = 'Inv. Discount Amount', FRA = 'Montant remise facture';
        }
        modify("Vendor Item No.")
        {
            CaptionML = ENU = 'Vendor Item No.', FRA = 'Référence fournisseur';
        }
        modify("Sales Order No.")
        {
            CaptionML = ENU = 'Sales Order No.', FRA = 'N° commande vente';
        }
        modify("Sales Order Line No.")
        {
            CaptionML = ENU = 'Sales Order Line No.', FRA = 'N° ligne commande vente';
        }
        modify("Drop Shipment")
        {
            CaptionML = ENU = 'Drop Shipment', FRA = 'Livraison directe';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("VAT Calculation Type")
        {
            CaptionML = ENU = 'VAT Calculation Type', FRA = 'Mode calcul TVA';
            //OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
        }
        modify("Transaction Type")
        {
            CaptionML = ENU = 'Transaction Type', FRA = 'Nature transaction';
        }
        modify("Transport Method")
        {
            CaptionML = ENU = 'Transport Method', FRA = 'Mode de transport';
        }
        modify("Attached to Line No.")
        {
            CaptionML = ENU = 'Attached to Line No.', FRA = 'Attaché à la ligne n°';
        }
        modify("Entry Point")
        {
            CaptionML = ENU = 'Entry Point', FRA = 'Pays provenance';
        }
        modify("Area")
        {
            CaptionML = ENU = 'Area', FRA = 'Dépt destination/provenance';
        }
        modify("Transaction Specification")
        {
            CaptionML = ENU = 'Transaction Specification', FRA = 'Régime';
        }
        modify("Tax Area Code")
        {
            CaptionML = ENU = 'Tax Area Code', FRA = 'Code zone recouvrement';
        }
        modify("Tax Liable")
        {
            CaptionML = ENU = 'Tax Liable', FRA = 'Soumis à recouvrement';
        }
        modify("Tax Group Code")
        {
            CaptionML = ENU = 'Tax Group Code', FRA = 'Code groupe taxes';
        }
        modify("Use Tax")
        {
            CaptionML = ENU = 'Use Tax', FRA = 'Use Tax';
        }
        modify("VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify("VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'VAT Prod. Posting Group', FRA = 'Groupe compta. produit TVA';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Outstanding Amount (LCY)")
        {
            CaptionML = ENU = 'Outstanding Amount (LCY)', FRA = 'Montant en commande DS';
        }
        modify("Amt. Rcd. Not Invoiced (LCY)")
        {
            CaptionML = ENU = 'Amt. Rcd. Not Invoiced (LCY)', FRA = 'Montant reçu non fact. DS';
        }
        modify("Blanket Order No.")
        {
            CaptionML = ENU = 'Blanket Order No.', FRA = 'N° commande ouverte';
        }
        modify("Blanket Order Line No.")
        {
            CaptionML = ENU = 'Blanket Order Line No.', FRA = 'N° ligne cde ouverte';
        }
        modify("VAT Base Amount")
        {
            CaptionML = ENU = 'VAT Base Amount', FRA = 'Montant base TVA';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';
        }
        modify("System-Created Entry")
        {
            CaptionML = ENU = 'System-Created Entry', FRA = 'Écriture système';
        }
        modify("Line Amount")
        {
            CaptionML = ENU = 'Line Amount', FRA = 'Montant ligne';
        }
        modify("VAT Difference")
        {
            CaptionML = ENU = 'VAT Difference', FRA = 'Différence TVA';
        }
        modify("Inv. Disc. Amount to Invoice")
        {
            CaptionML = ENU = 'Inv. Disc. Amount to Invoice', FRA = 'Montant rem. fact. à facturer';
        }
        modify("VAT Identifier")
        {
            CaptionML = ENU = 'VAT Identifier', FRA = 'Identifiant TVA';
        }
        modify("IC Partner Ref. Type")
        {
            CaptionML = ENU = 'IC Partner Ref. Type', FRA = 'Type de réf. du partenaire IC';
            //OptionCaptionML = ENU = ' ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No.,Vendor Item No.', FRA = ' ,Compte général,Article,,,Frais annexes,Référence externe,N° article commun,Référence fournisseur';
        }
        modify("IC Partner Reference")
        {
            CaptionML = ENU = 'IC Partner Reference', FRA = 'Référence du partenaire IC';
        }
        modify("Prepayment %")
        {
            CaptionML = ENU = 'Prepayment %', FRA = '% acompte';
        }
        modify("Prepmt. Line Amount")
        {
            CaptionML = ENU = 'Prepmt. Line Amount', FRA = 'Montant ligne acompte';
        }
        modify("Prepmt. Amt. Inv.")
        {
            CaptionML = ENU = 'Prepmt. Amt. Inv.', FRA = 'Fact. montant acompte';
        }
        modify("Prepmt. Amt. Incl. VAT")
        {
            CaptionML = ENU = 'Prepmt. Amt. Incl. VAT', FRA = 'Montant acompte TTC';
        }
        modify("Prepayment Amount")
        {
            CaptionML = ENU = 'Prepayment Amount', FRA = 'Montant acompte';
        }
        modify("Prepmt. VAT Base Amt.")
        {
            CaptionML = ENU = 'Prepmt. VAT Base Amt.', FRA = 'Montant base TVA acompte';
        }
        modify("Prepayment VAT %")
        {
            CaptionML = ENU = 'Prepayment VAT %', FRA = '% TVA acompte';
        }
        modify("Prepmt. VAT Calc. Type")
        {
            CaptionML = ENU = 'Prepmt. VAT Calc. Type', FRA = 'Mode calc. TVA acompte';
            //OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
        }
        modify("Prepayment VAT Identifier")
        {
            CaptionML = ENU = 'Prepayment VAT Identifier', FRA = 'Identifiant TVA acompte';
        }
        modify("Prepayment Tax Area Code")
        {
            CaptionML = ENU = 'Prepayment Tax Area Code', FRA = 'Code zone recouvrement acompte';
        }
        modify("Prepayment Tax Liable")
        {
            CaptionML = ENU = 'Prepayment Tax Liable', FRA = 'Acompte soumis à recouvrement';
        }
        modify("Prepayment Tax Group Code")
        {
            CaptionML = ENU = 'Prepayment Tax Group Code', FRA = 'Code groupe taxes acompte';
        }
        modify("Prepmt Amt to Deduct")
        {
            CaptionML = ENU = 'Prepmt Amt to Deduct', FRA = 'Montant acompte à déduire';
        }
        modify("Prepmt Amt Deducted")
        {
            CaptionML = ENU = 'Prepmt Amt Deducted', FRA = 'Montant acompte déduit';
        }
        modify("Prepayment Line")
        {
            CaptionML = ENU = 'Prepayment Line', FRA = 'Ligne acompte';
        }
        modify("Prepmt. Amount Inv. Incl. VAT")
        {
            CaptionML = ENU = 'Prepmt. Amount Inv. Incl. VAT', FRA = 'Fact. montant acompte TTC';
        }
        modify("IC Partner Code")
        {
            CaptionML = ENU = 'IC Partner Code', FRA = 'Code du partenaire IC';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Deferral Code")
        {
            CaptionML = ENU = 'Deferral Code', FRA = 'Code échelonnement';
        }
        modify("Returns Deferral Start Date")
        {
            CaptionML = ENU = 'Returns Deferral Start Date', FRA = 'Renvoie la date de début de l''échelonnement';
        }
        modify("Version No.")
        {
            CaptionML = ENU = 'Version No.', FRA = 'N° version';
        }
        modify("Doc. No. Occurrence")
        {
            CaptionML = ENU = 'Doc. No. Occurrence', FRA = 'Occurrence n° doc.';
        }
        modify("Prod. Order No.")
        {
            CaptionML = ENU = 'Prod. Order No.', FRA = 'N° ordre de fabrication';
        }
        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Bin Code")
        {
            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Quantity (Base)")
        {
            CaptionML = ENU = 'Quantity (Base)', FRA = 'Quantité (base)';
        }
        modify("Outstanding Qty. (Base)")
        {
            CaptionML = ENU = 'Outstanding Qty. (Base)', FRA = 'Quantité ouverte (base)';
        }
        modify("Qty. to Invoice (Base)")
        {
            CaptionML = ENU = 'Qty. to Invoice (Base)', FRA = 'Qté à facturer (base)';
        }
        modify("Qty. to Receive (Base)")
        {
            CaptionML = ENU = 'Qty. to Receive (Base)', FRA = 'Qté à recevoir (base)';
        }
        modify("Qty. Rcd. Not Invoiced (Base)")
        {
            CaptionML = ENU = 'Qty. Rcd. Not Invoiced (Base)', FRA = 'Qté reçue non facturée (base)';
        }
        modify("Qty. Received (Base)")
        {
            CaptionML = ENU = 'Qty. Received (Base)', FRA = 'Quantité reçue (base)';
        }
        modify("Qty. Invoiced (Base)")
        {
            CaptionML = ENU = 'Qty. Invoiced (Base)', FRA = 'Quantité facturée (base)';
        }
        modify("FA Posting Date")
        {
            CaptionML = ENU = 'FA Posting Date', FRA = 'Date compta. immo.';
        }
        modify("FA Posting Type")
        {
            CaptionML = ENU = 'FA Posting Type', FRA = 'Type compta. immo.';
            //OptionCaptionML = ENU = ' ,Acquisition Cost,Maintenance', FRA = ' ,Coût acquisition,Maintenance';
        }
        modify("Depreciation Book Code")
        {
            CaptionML = ENU = 'Depreciation Book Code', FRA = 'Code loi d''amortissement';
        }
        modify("Salvage Value")
        {
            CaptionML = ENU = 'Salvage Value', FRA = 'Valeur résiduelle';
        }
        modify("Depr. until FA Posting Date")
        {
            CaptionML = ENU = 'Depr. until FA Posting Date', FRA = 'Amort. jusqu''à date compta.';
        }
        modify("Depr. Acquisition Cost")
        {
            CaptionML = ENU = 'Depr. Acquisition Cost', FRA = 'Amortir coût acquisition';
        }
        modify("Maintenance Code")
        {
            CaptionML = ENU = 'Maintenance Code', FRA = 'Code maintenance';
        }
        modify("Insurance No.")
        {
            CaptionML = ENU = 'Insurance No.', FRA = 'N° assurance';
        }
        modify("Budgeted FA No.")
        {
            CaptionML = ENU = 'Budgeted FA No.', FRA = 'N° immo. budgétée';
        }
        modify("Duplicate in Depreciation Book")
        {
            CaptionML = ENU = 'Duplicate in Depreciation Book', FRA = 'Dupliquer dans journaux amort.';
        }
        modify("Use Duplication List")
        {
            CaptionML = ENU = 'Use Duplication List', FRA = 'Utiliser liste duplication';
        }
        modify("Responsibility Center")
        {
            CaptionML = ENU = 'Responsibility Center', FRA = 'Centre de gestion';
        }
        //BC UPGRADE-fields missing in BC->>
        // modify("Cross-Reference No.") //F5705-NAV PATHAA02
        // {
        //     CaptionML = ENU = 'Cross-Reference No.', FRA = 'Référence externe';
        // }
        // modify("Unit of Measure (Cross Ref.)")//F5706-NAV PATHAA02
        // {
        //     CaptionML = ENU = 'Unit of Measure (Cross Ref.)', FRA = 'Unité référence externe';
        // }
        // modify("Cross-Reference Type") //F507-NAV PATHAA02
        // {
        //     CaptionML = ENU = 'Cross-Reference Type', FRA = 'Type référence externe';
        //     OptionCaptionML = ENU = ' ,Customer,Vendor,Bar Code', FRA = ' ,Client,Fournisseur,Code barre';
        // }
        // modify("Cross-Reference Type No.") //5708-NAV PATHAA02
        // {
        //     CaptionML = ENU = 'Cross-Reference Type No.', FRA = 'N° type référence externe';
        // }
        //BC UPGRADE-fields missing in BC<<
        modify("Item Category Code")
        {
            CaptionML = ENU = 'Item Category Code', FRA = 'Code catégorie article';
        }
        modify(Nonstock)
        {
            CaptionML = ENU = 'Nonstock', FRA = 'Non stocké';
        }
        modify("Purchasing Code")
        {
            CaptionML = ENU = 'Purchasing Code', FRA = 'Procédure achat';
        }
        // modify("Product Group Code")
        // {
        //     CaptionML = ENU = 'Product Group Code', FRA = 'Code groupe produits';
        // } //BC UPGRADE PATHAA02
        modify("Special Order")
        {
            CaptionML = ENU = 'Special Order', FRA = 'Commande spéciale';
        }
        modify("Special Order Sales No.")
        {
            CaptionML = ENU = 'Special Order Sales No.', FRA = 'N° vente cde spéciale';
        }
        modify("Special Order Sales Line No.")
        {
            CaptionML = ENU = 'Special Order Sales Line No.', FRA = 'N° ligne vente cde spéciale';
        }
        modify("Completely Received")
        {
            CaptionML = ENU = 'Completely Received', FRA = 'Entièrement réceptionné';
        }
        modify("Requested Receipt Date")
        {
            CaptionML = ENU = 'Requested Receipt Date', FRA = 'Date réception demandée';
        }
        modify("Promised Receipt Date")
        {
            CaptionML = ENU = 'Promised Receipt Date', FRA = 'Date réception confirmée';
        }
        modify("Lead Time Calculation")
        {
            CaptionML = ENU = 'Lead Time Calculation', FRA = 'Délai de réappro.';
        }
        modify("Inbound Whse. Handling Time")
        {
            CaptionML = ENU = 'Inbound Whse. Handling Time', FRA = 'Délai enlogement';
        }
        modify("Planned Receipt Date")
        {
            CaptionML = ENU = 'Planned Receipt Date', FRA = 'Date livraison fourn. prévue';
        }
        modify("Order Date")
        {
            CaptionML = ENU = 'Order Date', FRA = 'Date commande';
        }
        modify("Allow Item Charge Assignment")
        {
            CaptionML = ENU = 'Allow Item Charge Assignment', FRA = 'Autoriser affectation frais annexes';
        }
        modify("Return Qty. to Ship")
        {
            CaptionML = ENU = 'Return Qty. to Ship', FRA = 'Qté retour à expédier';
        }
        modify("Return Qty. to Ship (Base)")
        {
            CaptionML = ENU = 'Return Qty. to Ship (Base)', FRA = 'Qté retour à expédier (base)';
        }
        modify("Return Qty. Shipped Not Invd.")
        {
            CaptionML = ENU = 'Return Qty. Shipped Not Invd.', FRA = 'Qté ret. expédiée non facturée';
        }
        modify("Ret. Qty. Shpd Not Invd.(Base)")
        {
            CaptionML = ENU = 'Ret. Qty. Shpd Not Invd.(Base)', FRA = 'Qté ret. expéd. non fact. (base)';
        }
        modify("Return Shpd. Not Invd.")
        {
            CaptionML = ENU = 'Return Shpd. Not Invd.', FRA = 'Expédition retour non facturée';
        }
        modify("Return Shpd. Not Invd. (LCY)")
        {
            CaptionML = ENU = 'Return Shpd. Not Invd. (LCY)', FRA = 'Expédition retour non facturée DS';
        }
        modify("Return Qty. Shipped")
        {
            CaptionML = ENU = 'Return Qty. Shipped', FRA = 'Qté retour expédiée';
        }
        modify("Return Qty. Shipped (Base)")
        {
            CaptionML = ENU = 'Return Qty. Shipped (Base)', FRA = 'Qté retour expédiée (base)';
        }
        modify("Return Shipment No.")
        {
            CaptionML = ENU = 'Return Shipment No.', FRA = 'N° expédition retour';
        }
        modify("Return Shipment Line No.")
        {
            CaptionML = ENU = 'Return Shipment Line No.', FRA = 'N° ligne expédition retour';
        }
        modify("Return Reason Code")
        {
            CaptionML = ENU = 'Return Reason Code', FRA = 'Code motif retour';
        }
        modify("Routing No.")
        {
            CaptionML = ENU = 'Routing No.', FRA = 'N° gamme';
        }
        modify("Operation No.")
        {
            CaptionML = ENU = 'Operation No.', FRA = 'N° opération';
        }
        modify("Work Center No.")
        {
            CaptionML = ENU = 'Work Center No.', FRA = 'N° centre de charge';
        }
        modify(Finished)
        {
            CaptionML = ENU = 'Finished', FRA = 'Terminé';
        }
        modify("Prod. Order Line No.")
        {
            CaptionML = ENU = 'Prod. Order Line No.', FRA = 'N° ligne O.F.';
        }
        modify("Overhead Rate")
        {
            CaptionML = ENU = 'Overhead Rate', FRA = 'Frais généraux';
        }
        modify("MPS Order")
        {
            CaptionML = ENU = 'MPS Order', FRA = 'Ordre PDP';
        }
        modify("Planning Flexibility")
        {
            CaptionML = ENU = 'Planning Flexibility', FRA = 'Flexibilité planification';
            //OptionCaptionML = ENU = 'Unlimited,None', FRA = 'Illimitée,Aucune';
        }
        modify("Safety Lead Time")
        {
            CaptionML = ENU = 'Safety Lead Time', FRA = 'Délai de sécurité';
        }
        modify("Routing Reference No.")
        {
            CaptionML = ENU = 'Routing Reference No.', FRA = 'N° référence gamme';
        }
        field(50000; "SRM Contract No. FND"; Code[10])
        {
            Caption = 'SRM Contract No.';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50001; "SRM Contract Line No. FND"; Code[10])
        {
            Caption = 'SRM Contract Line No.';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50002; "SRM Contract Type FND"; Code[10])
        {
            CalcFormula = Lookup("Purchase Header"."SRM Contract Type FND" where("Document Type" = FIELD("Document Type"),
                                                                              "No." = FIELD("Document No.")));
            Caption = 'SRM Contract Type';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Valid From FND"; Date)
        {
            CalcFormula = Lookup("Purchase Header"."Valid From FND" where("Document Type" = FIELD("Document Type"),
                                                                       "No." = FIELD("Document No.")));
            Caption = 'Valid From';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Valid To FND"; Date)
        {
            CalcFormula = Lookup("Purchase Header"."Valid To FND" where("Document Type" = FIELD("Document Type"),
                                                                     "No." = FIELD("Document No.")));
            Caption = 'Valid To';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Type ID FND"; Code[10])
        {
            Caption = 'Type ID';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50006; "CMG Code FND"; Code[20])
        {
            Caption = 'CMG Code';
            Description = 'HEI.01';
        }
        field(50007; "Block Line Ordering FND"; Option)
        {
            Caption = 'Block Line Ordering';
            Description = 'HEI.01';
            Editable = false;
            OptionCaption = '" ,B,F"';
            OptionMembers = " ",B,F;
        }
        field(50008; "Delivery Finalized FND"; Boolean)
        {
            Caption = 'Delivery Finalized';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50009; "Tolerance Received Over % FND"; Decimal)
        {
            Caption = 'Tolerance Received Over %';
            DecimalPlaces = 2 : 5;
            Description = 'HEI.01';
            Editable = false;
        }
        field(50010; "Tolerance Received Under % FND"; Decimal)
        {
            Caption = 'Tolerance Received Under %';
            DecimalPlaces = 2 : 5;
            Description = 'HEI.01';
            Editable = false;
        }
        field(50011; "Consumption Location Code FND"; Code[10])
        {
            Caption = 'Consumption Location Code';
            Description = 'HEI.01';
            TableRelation = Location;
        }
        field(50012; "Initial Quantity FND"; Decimal)
        {
            Caption = 'Initial Quantity';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.01';
            Editable = false;
        }
        field(50013; "Cancelled FND"; Boolean)
        {
            Caption = 'Cancelled';
            Description = 'HEI.01';

            trigger OnValidate();
            begin
                //HEI.01>>
                VALIDATE("Qty. to Receive", 0);
                //HEI.01<<
            end;
        }
        field(50014; "SRM Order No. FND"; Code[10])
        {
            Caption = 'SRM Order No.';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50015; "SRM Order Line No. FND"; Code[10])
        {
            Caption = 'SRM Order Line No.';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50016; "Last Changed Date/Time FND"; DateTime)
        {
            Caption = 'Last Changed Date/Time';
            Description = 'HEI.01';
        }
        field(50020; "Target Value Currency FND"; Code[10])
        {
            Caption = 'Target Value Currency';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = Currency;
        }
        field(50021; "Target Value Amount FND"; Decimal)
        {
            Caption = 'Target Value Amount';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50030; "Maximo Requisition No. FND"; Code[20])
        {
            Caption = 'Maximo Requisition No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50031; "Maximo Requis. Line No. FND"; Integer)
        {
            Caption = 'Maximo Requisition Line No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50032; "Machine Reference Number FND"; Text[50])
        {
            Caption = 'Machine Reference Number';
            Description = 'HEI.03';
            Editable = false;
            FieldClass = Normal;
        }
        field(50042; "TIN No. FND"; Text[20])
        {
            Caption = 'TIN No.';
            Description = 'HEI.04';
            Editable = false;
            TableRelation = "TIN by Location FND"."TIN No.";
        }
        field(50049; "TO Reference FND"; Code[20])
        {
            Caption = 'TO Reference';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(50051; "CAD Amount FND"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'CAD Amount',
                        FRA = 'CAD Montant';
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
            Editable = false;
        }
        field(50052; "CAD Attached to Line No. FND"; Integer)
        {
            Caption = 'CAD Attached to Line No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
            Editable = false;
        }
        field(50057; "SPL Code FND"; Code[20])
        {
            Caption = 'SPL Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
            TableRelation = "Vendor SPL Relation FND"."SPL Code";
        }
        field(50058; "SPL Name FND"; Text[50])
        {
            Caption = 'SPL Name';
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
            Editable = false;
        }
        field(50075; "Zycus Order No. FND"; Code[20])
        {
            Caption = 'Zycus Order No.';
            Description = 'HEI.10,HEI.11';
            Editable = false;
        }
        field(50076; "Zycus Order Line No. FND"; Integer)
        {
            Caption = 'Zycus Order Line No.';
            Description = 'HEI.10,HEI.11';
            Editable = false;
        }
        field(50077; "Zycus PR Reference No. FND"; Code[20])
        {
            Caption = 'Zycus PR Reference No.';
            Description = 'HEI.11';
            Editable = false;
        }
        field(50078; "Zycus PO Type Code FND"; Code[3])
        {
            Caption = 'Zycus PO Type Code';
            Description = 'HEI.11';
            Editable = false;
        }
        field(50079; "Zycus PO Line Type Code FND"; Code[1])
        {
            Caption = 'Zycus PO Line Type Code';
            Description = 'HEI.11';
            Editable = false;
        }
        field(50080; "Zycus PO Line Validated FND"; Boolean)
        {
            Caption = 'Zycus PO Line Validated';
            Description = 'HEI.11';
            Editable = false;
        }
        field(50085; "Zycus Movement Type FND"; Integer)
        {
            Caption = 'Zycus Movement Type';
            Description = 'HEI.12';
            Editable = false;
        }
        //BC UPGRADE ATHUKUS01 FDDSTP_007>>
        field(50086; "Original Quantity FND"; Decimal)
        {
            Caption = 'Original Quantity';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        //BC UPGRADE ATHUKUS01 FDDSTP_007<<

        //BC UPGRADE PATHAA02>>
        // field(2013610; "Item DDeposit Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Deposit Group Code',
        //                 FRA = 'Code groupe consigne article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code where("Source Type" = CONST(Item));
        // }
        // field(2013611; "Empty Goods Item No."; Code[20])
        // {
        //     CaptionML = ENU = 'Empty Goods Item No.',
        //                 FRA = 'N° article vidange';
        //     Description = 'DITW15.00.00.01-.35';
        //     TableRelation = Item where("Empty Good" = CONST(true));
        // }
        // field(2013612; "Item Charge Quantity per"; Decimal)
        // {
        //     CaptionML = ENU = 'Item Charge Quantity per',
        //                 FRA = 'Quantité frais annexes par';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.01';
        //     MinValue = 0;
        // }
        // field(2013615; "Rounding factor"; Option)
        // {
        //     CaptionML = ENU = 'Rounding factor',
        //                 FRA = 'Unité d''affichage';
        //     Description = 'DITW17.00.02 DIT-770 #142';
        //     Editable = false;
        //     OptionCaptionML = ENU = 'Nearest,Up,Down',
        //                       FRA = 'Au plus près,Par excès,Par défaut';
        //     OptionMembers = Nearest,Up,Down;
        // }
        // field(2013636; "Split Deposit on Invoice"; Boolean)
        // {
        //     CaptionML = ENU = 'Split Deposit on Invoice (Entries)',
        //                 FRA = 'Diviser consigne sur facture (écritures)';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        // }
        // field(2013637; "Deposit Value"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     Caption = 'Deposit Value';
        //     Description = 'DITW110.00.11 BL#14417';
        // }
        // field(2013660; "Extra Charge Type"; Option)
        // {
        //     CaptionML = ENU = 'Extra Charge Type',
        //                 FRA = 'Type frais extra';
        //     Description = 'VC8-DITW15.00.00.01-.34';
        //     OptionCaptionML = ENU = ' ,Amount,Price %,Amount %,Fixed Amount,Volume /Unit,Weight,Cubage,Distance,Purchase Price',
        //                       FRA = ' ,Montant,Prix %,Montant %,Montant Fixe,Volume /Unit,Poids,Cubage,Distance,Prix achat';
        //     OptionMembers = " ",Amount,"Price %","Amount %","Fixed Amount",VolumeHL,Weight,Cubage,Distance,"Price Item";
        // }
        // field(2013661; "Item Charge Value"; Decimal)
        // {
        //     CaptionML = ENU = 'Item Charge Value',
        //                 FRA = 'Valeur frais annexes';
        //     Description = 'VC8-DITW15.00.00.01';
        // }
        // field(2013662; "Is Item Charge"; Boolean)
        // {
        //     CaptionML = ENU = 'Is Item Charge',
        //                 FRA = 'Est frais annexes';
        //     Description = 'VC8-DITW15.00.00.01';
        // }
        // field(2013663; "ItemCharge Incl. Price"; Boolean)
        // {
        //     CaptionML = ENU = 'Item Charge Incl. Price',
        //                 FRA = 'Frais annexe inclus prix';
        //     Description = 'VC8-DITW15.00.00.01';
        // }
        // field(2013664; "Item Charge Discount %"; Decimal)
        // {
        //     CaptionML = ENU = 'Item Charge Discount %',
        //                 FRA = 'Remise frais annexes %';
        //     Description = 'VC8-DITW15.00.00.01';
        // }
        // field(2013665; "Allow Item Charge Line Disc."; Boolean)
        // {
        //     CaptionML = ENU = 'Allow Item Charge Line Discount',
        //                 FRA = 'Frais annexes remise ligne autorisé';
        //     Description = 'VC8-DITW15.00.00.01';
        //     InitValue = true;
        // }
        // field(2013666; "Vendor DTax Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Vendor Tax Group Code',
        //                 FRA = 'Code groupe taxe fournisseur';
        //     Description = 'DITW17.10.03 DIT-770 698';
        //     TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Vendor));
        // }
        // field(2013667; "Item DTax Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Tax Group Code',
        //                 FRA = 'Code groupe taxe article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Item));
        // }
        // field(2013695; "Item Charge Type"; Option)
        // {
        //     CaptionML = ENU = 'Type',
        //                 FRA = 'Type';
        //     Description = 'DITW15.00.00.01';
        //     OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion',
        //                       FRA = ' ,Taxe,Consigne,Remise,Promotion';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion;
        // }
        // field(2013696; "Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Location Tax Group Code',
        //                 FRA = 'Code groupe magasin taxe';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Location Group";
        // }
        // field(2013708; "Due Tax"; Boolean)
        // {
        //     CaptionML = ENU = 'Due Tax',
        //                 FRA = 'Taxe due';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013715; "Tax Formula"; Code[80])
        // {
        //     CaptionML = ENU = 'Tax Formula',
        //                 FRA = 'Formule taxe';
        //     Description = 'DITW15.00.00.30';
        // }
        // field(2013722; "Duty Suspended"; Boolean)
        // {
        //     CaptionML = ENU = 'Duty Suspended',
        //                 FRA = 'Taxe en suspension';
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013726; "Company Tax Registration No."; Text[20])
        // {
        //     CaptionML = ENU = 'Company Tax Registration No.',
        //                 FRA = 'N° identif. accise société';
        //     Description = 'DITW15.00.00.28';
        // }
        // field(2013727; "AAD No. Series"; Code[10])
        // {
        //     CaptionML = ENU = 'AAD No. Series',
        //                 FRA = 'Souches de n° DAA';
        //     Description = 'DITW15.00.00.28';
        //     TableRelation = "No. Series";
        // }
        // field(2013728; "AAD No."; Code[20])
        // {
        //     CaptionML = ENU = 'AAD No.',
        //                 FRA = 'N° DAA';
        //     Description = 'DITW15.00.00.28';
        // }
        // field(2013729; "Tariff No."; Code[10])
        // {
        //     CaptionML = ENU = 'Tariff No.',
        //                 FRA = 'Nomenclature produits';
        //     Description = 'DITW15.00.00.28';
        //     TableRelation = "Tariff Number";
        // }
        // field(2013731; "Applies-to AAD Trck. Entry No."; Integer)
        // {
        //     CaptionML = ENU = 'Applies-to Correction AAD Trck. Entry No.',
        //                 FRA = 'N° Ecriture correction suivi DAA lettrage';
        //     Description = 'DITW15.00.00.39 #1369';
        //     TableRelation = "AAD Tracking Entry"."Entry No." where("Entry Type" = CONST(Outbound),
        //                                                             "Source Type" = CONST(Vendor),
        //                                                             "Source No." = FIELD("Buy-from Vendor No."));

        //     trigger OnLookup();
        //     var
        //         AADTrackingEntry: Record "AAD Tracking Entry";
        //     begin
        //     end;

        //     trigger OnValidate();
        //     var
        //         AADTrackingEntry: Record "AAD Tracking Entry";
        //     begin
        //     end;
        // }
        // field(2013767; "Unit Volume HL"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Unit Volume HL"));
        //     CaptionML = ENU = 'Unit Volume',
        //                 FRA = 'Volume unitaire';
        //     Description = 'DITW15.00.00.01';
        //     MinValue = 0;
        // }
        // field(2013773; "Vendor DDisc. Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Vendor Discount Group',
        //                 FRA = 'Groupe remise fournisseur';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Discount Group".Code where("Source Type" = CONST(Vendor));
        // }
        // field(2013774; "Item DDisc. Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Discount Group',
        //                 FRA = 'Groupe remise article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Discount Group".Code where("Source Type" = CONST(Item));
        // }
        // field(2013775; "Vendor DPromo. Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Vendor Promotion Group',
        //                 FRA = 'Groupe promotion fournisseur';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Promotion Group".Code where("Source Type" = CONST(Vendor));
        // }
        // field(2013776; "Item DPromo. Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Promotion Group',
        //                 FRA = 'Groupe promotion article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Promotion Group".Code where("Source Type" = CONST(Item));
        // }
        // field(2013777; "Item Charge Calculate per"; Option)
        // {
        //     CaptionML = ENU = 'Item Charge Calculate per',
        //                 FRA = 'Frais annexe calcul par';
        //     Description = 'DITW15.00.00.01';
        //     OptionCaptionML = ENU = 'Item,Order,Period',
        //                       FRA = 'Article,Commande,Périodique';
        //     OptionMembers = Item,"Order",Period;
        // }
        // field(2013778; "Opposite Qty. Sign"; Boolean)
        // {
        //     CaptionML = ENU = 'Opposite Qty. Sign',
        //                 FRA = 'Signe quantité opposé';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013779; "Using Qty. (Base)"; Boolean)
        // {
        //     CaptionML = ENU = 'Using Qty. (Base)',
        //                 FRA = 'Utilisation quantité (Base)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013780; "Free Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Free Quantity',
        //                 FRA = 'Quantité gratuite';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.01';
        //     MinValue = 0;
        // }
        // field(2013781; "Multiple Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Multiple Quantity',
        //                 FRA = 'Quantité multiple';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.01';
        //     MinValue = 0;
        // }
        // field(2013782; "Maximum Free Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Maximum Free Quantity',
        //                 FRA = 'Quantité maximum gratuite';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.01';
        //     MinValue = 0;
        // }
        // field(2013783; "DDiscount Level Position"; Integer)
        // {
        //     CaptionML = ENU = 'Discount Level Position',
        //                 FRA = 'Position niveau de remise';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013784; "DDiscount Base Amount"; Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'DDiscount Base Amount',
        //                 FRA = 'Montant base remise';
        //     Description = 'DITW17.00.02 DIT-770 #274';
        // }
        // field(2013785; "Periodic Disc.-Promo Entry No."; Integer)
        // {
        //     CaptionML = ENU = 'Periodic Disc.-Promo Entry No.',
        //                 FRA = 'N° écriture Remise-Promotion périodique';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Sales Discount.-Promo. Entry"."Entry No.";
        // }
        // field(2013788; "DDiscount Include Tax"; Boolean)
        // {
        //     CaptionML = ENU = 'DDiscount Include Tax',
        //                 FRA = 'Remise inculent taxe';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013789; "DDiscount Include Deposit"; Boolean)
        // {
        //     CaptionML = ENU = 'DDiscount Include Deposit',
        //                 FRA = 'Remise incluent caution';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013790; "DDiscount Include Discount"; Boolean)
        // {
        //     CaptionML = ENU = 'DDiscount Include Discount',
        //                 FRA = 'Remise incluent remise';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013797; "Disc.Promo. Order Calculated"; Boolean)
        // {
        //     CaptionML = ENU = 'Disc.Promo. Order Calculated',
        //                 FRA = 'Remise-Promotion cmde. calculé';
        //     Description = 'DITW15.00.00.37';
        // }
        // field(2013803; "Allow VAT Calculation (Free)"; Boolean)
        // {
        //     CaptionML = ENU = 'Allow VAT Calculation (Free)',
        //                 FRA = 'Autoriser calcul TVA (Gratuit)';
        //     Description = 'DITW16.00.00.40 DIT-715 #172';
        // }
        // field(2013824; "Gen. Prod. Posting Free Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Gen. Prod. Posting Group Free Item',
        //                 FRA = 'Groupe article gratuit compta. produit';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Gen. Product Posting Group";
        // }
        // field(2013825; "Free Item Posting Type"; Option)
        // {
        //     CaptionML = ENU = 'Calculate Price on Free',
        //                 FRA = 'Calculer Prix sur gratuit';
        //     Description = 'DITW15.00.00.35';
        //     OptionCaptionML = ENU = ' ,Price 0,Discount 100%',
        //                       FRA = ' ,Prix 0,Remise 100%';
        //     OptionMembers = " ",Price,Amount;
        // }
        // field(2013826; "Free Item"; Boolean)
        // {
        //     CaptionML = ENU = 'Free Item',
        //                 FRA = 'Article gratuit';
        //     Description = 'DITW15.00.00.35';
        // }
        // field(2013827; "Free Calculation Type"; Option)
        // {
        //     CaptionML = ENU = 'Calculate on Free',
        //                 FRA = 'Calculer sur gratuit';
        //     Description = 'DITW15.00.00.35';
        //     OptionCaptionML = ENU = 'None,Discount 100%,Full Amount',
        //                       FRA = 'Aucun,Remise 100%,Montant';
        //     OptionMembers = "None","Discount 100%",All;
        // }
        // field(2013828; "Include Free Qty. in Minimum"; Boolean)
        // {
        //     CaptionML = ENU = 'Include Free Quantity in Minimum',
        //                 FRA = 'Inclure quantité gratuite avec minimum';
        //     Description = 'DITW15.00.00.35';
        // }
        // field(2013829; "Free Reason Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Free Reason Code',
        //                 FRA = 'Code motif gratuit';
        //     Description = 'DITW17.00.02 DIT-770 #132';
        //     TableRelation = "Free Reason Code";

        //     trigger OnValidate();
        //     var
        //         lTempBatchInsertCheckSuspended: Boolean;
        //     begin
        //     end;
        // }
        // field(2014064; "Shipping Charge Per"; Option)
        // {
        //     CaptionML = ENU = 'Shipping Charge Per',
        //                 FRA = 'Frais transport par';
        //     Description = 'DITW15.00.00.25';
        //     OptionCaptionML = ENU = 'Shipment,Weight,Volume',
        //                       FRA = 'Expédition,Poids,Volume';
        //     OptionMembers = Shipment,Weight,Volume;
        // }
        // field(2014065; "Original Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Original Quantity',
        //                 FRA = 'Quantité initiale';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW18.00.07 DIT-770 #1703';
        //     MaxValue = 100;
        //     MinValue = 0;
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
        // }
        // field(2014079; Cubage; Decimal)
        // {
        //     CaptionML = ENU = 'Volume (Cubage)',
        //                 FRA = 'Volume (cubage)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014080; Weight; Decimal)
        // {
        //     CaptionML = ENU = 'Weight',
        //                 FRA = 'Poids';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014085; "Shipping Whse. Shipment No."; Code[20])
        // {
        //     CaptionML = ENU = 'Shipping Whse. Shipment No.',
        //                 FRA = 'N° expédition transport';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        //     TableRelation = "Posted Whse. Shipment Header";
        // }
        // field(2014086; "Shipping Whse. Receipt No."; Code[20])
        // {
        //     CaptionML = ENU = 'Shipping Whse. Receipt No.',
        //                 FRA = 'N° réception transport';
        //     Description = 'DITW15.00.00.25';
        //     Editable = false;
        //     TableRelation = "Posted Whse. Receipt Header";
        // }
        // field(2014087; Distance; Decimal)
        // {
        //     CaptionML = ENU = 'Distance',
        //                 FRA = 'Distance';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.25';
        //     MinValue = 0;
        // }
        // field(2014088; "Item Delivery Type"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Delivery Type',
        //                 FRA = 'Type de Livraison Article';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     TableRelation = "Delivery Type".Code where(Type = CONST(Item));
        // }
        // field(2014089; "Delivery Time (sec.)"; Decimal)
        // {
        //     CaptionML = ENU = 'Delivery Time (sec.)',
        //                 FRA = 'Temps de Livraison (Sec.)';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     MinValue = 0;
        // }
        // field(2014094; "Physical Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Physical Location Group Code',
        //                 FRA = 'Code groupe magasin réel';
        //     Description = 'DITW15.00.00.35';
        // }
        // field(2014103; "Whse. Receipt No. (Open)"; Code[20])
        // {
        //     CalcFormula = Lookup("Warehouse Receipt Line"."No." where("Source Type" = CONST(39),
        //                                                                "Source Subtype" = FIELD("Document Type"),
        //                                                                "Source No." = FIELD("Document No."),
        //                                                                "Source Line No." = FIELD("Line No.")));
        //     CaptionML = ENU = 'Whse. Receipt No. (Open)',
        //                 FRA = 'N° réception magasin (Ouvert)';
        //     Description = 'DITW15.00.00.39 #1399';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     TableRelation = "Warehouse Receipt Header";
        // }
        // field(2014113; "Tax Item No."; Code[20])
        // {
        //     CaptionML = ENU = 'Tax Tracking Item No.',
        //                 FRA = 'N° article traçable Taxe';
        //     Description = 'DITW15.00.00.38 #703';
        //     TableRelation = Item;
        // }
        // field(2014260; "LRN No. Series"; Code[10])
        // {
        //     CaptionML = ENU = 'LRN No. Series',
        //                 FRA = 'Souches de n° LRN';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "No. Series";

        //     trigger OnLookup();
        //     var
        //         lrpurchline: Record "Purchase Line";
        //         lDefaultAADCode: Code[10];
        //     begin
        //     end;

        //     trigger OnValidate();
        //     var
        //         lDefaultAADCode: Code[10];
        //     begin
        //     end;
        // }
        // field(2014261; "LRN No."; Code[20])
        // {
        //     CaptionML = ENU = 'LRN No.',
        //                 FRA = 'N° LRN';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014262; "ARC No."; Code[30])
        // {
        //     CaptionML = ENU = 'ARC No.',
        //                 FRA = 'N° ARC';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnLookup();
        //     var
        //         NewText: Text[1024];
        //     begin
        //     end;
        // }
        // field(2014263; "SAD No."; Code[30])
        // {
        //     CaptionML = ENU = 'SAD No.',
        //                 FRA = 'N° SAD';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014265; "Product Tax Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Tax Product Code',
        //                 FRA = 'Code Produit taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Product";
        // }
        // field(2014267; "ARC No. Mandatory"; Boolean)
        // {
        //     CaptionML = ENU = 'ARC No. Mandatory (EMCS)',
        //                 FRA = 'N° ARC obligatoire (EMCS)';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014271; "Company Tax Warehouse Ref."; Text[20])
        // {
        //     CaptionML = ENU = 'Company Tax Warehouse Reference',
        //                 FRA = 'Entrepôt fiscal de référence société';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014310; "Service Contract Line No."; Integer)
        // {
        //     CaptionML = ENU = 'Contract Line No.',
        //                 FRA = 'N° ligne contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';
        // }
        // field(2014312; "DIT Sub-Contr.Pst. Type Filter"; Option)
        // {
        //     CaptionML = ENU = 'Financial Contract Posting Type Filter',
        //                 FRA = 'Filtre Type Imputation contrat DIT';
        //     Description = 'DITW16.00.00.41 DIT-715 #327';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance,,,,,All',
        //                       FRA = ' ,Location,Prêt,Mise à disposition,Maintenance,Divers,Maintenance Usine,,,,,Tous';
        //     OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance,,,,,All;
        // }
        // field(2014313; "Financial Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Financial Contract No.',
        //                 FRA = 'N° Contrat Financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';

        //     trigger OnValidate();
        //     var
        //         FA2: Record "Fixed Asset";
        //     begin
        //     end;
        // }
        // field(2014410; Collapse; Boolean)
        // {
        //     CaptionML = ENU = 'Collapse',
        //                 FRA = 'Réduire';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2014415; "Item Charge Qty. per Uom"; Decimal)
        // {
        //     CaptionML = ENU = 'Item Charge Qty. per Unit of Measure',
        //                 FRA = 'Qté frais annexe par unité de mesure';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.43 DIT-715 #882';
        //     Editable = false;
        //     InitValue = 1;
        // }
        // field(2014426; "Service Order No."; Code[20])
        // {
        //     CaptionML = ENU = 'Service Order No.',
        //                 FRA = 'N° commande de service';
        //     Description = 'DITW15.00.00.39 #1403 - DIT-715 #297';
        //     Editable = false;
        //     TableRelation = "Service Header"."No." where("Document Type" = CONST(Order));
        // }
        // field(2014427; "Service Order Line No."; Integer)
        // {
        //     CaptionML = ENU = 'Service Order Line No.',
        //                 FRA = 'N° ligne commande de service';
        //     Description = 'DITW15.00.00.39 #1403 DIT-715 #297';
        // }
        // field(2014438; "App. Prod. Posting Group"; Code[10])
        // {
        //     CaptionML = ENU = 'App. Prod. Posting Group',
        //                 FRA = 'Groupe compta. produit';
        //     Description = 'DITW17.00.02 DIT-770 #144';
        //     Editable = false;
        //     TableRelation = "Gen. Product Posting Group";
        // }
        // field(2014439; "Approved Line Amount"; Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Approved Line Amount',
        //                 FRA = 'Montant  approuvé';
        //     Description = 'DITW17.00.02 DIT-770 #144';
        //     Editable = false;

        //     trigger OnValidate();
        //     var
        //         lCurrDirectUnitCost: Decimal;
        //     begin
        //     end;
        // }
        // field(2014440; "Approved Dimension set ID"; Integer)
        // {
        //     CaptionML = ENU = 'Approved Dimension set ID',
        //                 FRA = 'ID ensemble de dimensions approuvé';
        //     Description = 'DITW17.00.05 DIT-770 #961';
        // }
        // field(2014444; "Last Price Calculated Date"; Date)
        // {
        //     CaptionML = ENU = 'Last Price Calculated Date',
        //                 FRA = 'Dernière date prix calculé';
        //     Description = 'DITW15.00.00.31';
        // }
        // field(2014460; "Production BOM No."; Code[20])
        // {
        //     CaptionML = ENU = 'Production BOM No.',
        //                 FRA = 'N° nomenclature production';
        //     Description = 'DITW18.00.06 DIT-770 #1449';
        //     TableRelation = "Production BOM Header";
        // }
        // field(2014462; "BOM Line No."; Integer)
        // {
        //     CaptionML = ENU = 'BOM Line No.',
        //                 FRA = 'N° ligne nomenclature';
        //     Description = 'DITW18.00.06 DIT-770 #1449';
        //     NotBlank = true;
        //     TableRelation = IF ("Production BOM No." = FILTER(<> '')) "Production BOM Line"."Line No." where("Production BOM No." = FIELD("Production BOM No."))
        //     else IF ("Production BOM No." = CONST('')) "BOM Component"."Line No." where("Parent Item No." = FIELD("BOM Item No."));
        // }
        // field(2014463; "BOM Item No."; Code[20])
        // {
        //     CaptionML = ENU = 'BOM Item No.',
        //                 FRA = 'N° article nomenclature';
        //     Description = 'DITW18.00.06 DIT-770 #1449';
        //     TableRelation = Item;
        // }
        // field(2014464; "BOM Qty. per Unit of Measure"; Decimal)
        // {
        //     CaptionML = ENU = 'BOM Qty. per Unit of Measure',
        //                 FRA = 'Quantité par unité nomenclature';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW18.00.06 DIT-770 #1449';
        // }
        // field(2014476; "Packaging Type Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Packaging Type Code',
        //                 FRA = 'Code Type de Conditionnement';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Packaging Type";

        //     trigger OnValidate();
        //     var
        //         PackagingType: Record "Packaging Type";
        //     begin
        //     end;
        // }
        // field(2014477; "No. of Packages"; Decimal)
        // {
        //     CaptionML = ENU = 'No. of Packages',
        //                 FRA = 'Nbre de colis';
        //     DecimalPlaces = 0 : 2;
        //     Description = 'DITW18.00.06 DIT-770 #1412';
        // }
        // field(2014482; "Pack Qty. per Unit of Measure"; Decimal)
        // {
        //     CaptionML = ENU = 'Packaging Qty. per Unit of Measure',
        //                 FRA = 'Quantité conditionnement par unité';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.38 #1217 (DIT711 148)';
        // }
        // field(2014497; "Resp. Center Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Resp. Center Table Filter',
        //                 FRA = 'Filtre Centre de gestion (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1191';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Responsibility Center";
        // }
        // field(2014498; "Phys. Location Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Phys. Location Table Filter',
        //                 FRA = 'Filtre groupe magasin réel (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1191';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014499; "Location Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Location Table Filter',
        //                 FRA = 'Filtre Magasin (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1191';
        //     FieldClass = FlowFilter;
        //     TableRelation = Location;
        // }
        // field(2014500; "Has Item Charge"; Boolean)
        // {
        //     CalcFormula = Exist("Purchase Line" where("Document Type" = FIELD("Document Type"),
        //                                                "Document No." = FIELD("Document No."),
        //                                                "Attached to Line No." = FIELD("Line No.")));
        //     CaptionML = ENU = 'Has Item Charge',
        //                 FRA = 'A des Frais Annexes';
        //     Description = 'DITW17.10.03 DIT-770 #541';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014503; "Equiv. Unit of Measure Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Equiv. Unit of Measure Code',
        //                 FRA = 'Unitié de mesure equiv.';
        //     Description = 'DITW17.00.02 DIT-770 #183';
        //     TableRelation = "Unit of Measure".Code;
        // }
        // field(2014504; "Calculate Minimum"; Option)
        // {
        //     CaptionML = ENU = 'Calculate Minimum',
        //                 FRA = 'Calculer minimum';
        //     Description = 'DITW17.10.03 DIT-770 #327-NRQ#14143';
        //     OptionCaptionML = ENU = ' ,Under,Over,Until,Until Including Min,Recurring Minimum,Recurring Over,Recurring Under,Recurring Until',
        //                       FRA = ' ,Under,Over,Until,Until Including Min,Recurring Minimum,Recurring Over,Recurring Under,Recurring Until';
        //     OptionMembers = " ",Under,Over,"Until","Until Including Min","Recurring Minimum","Recurring Over","Recurring Under","Recurring Until";
        // }
        // field(2014505; "Recurring Min. Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Recurring Min. Quantity',
        //                 FRA = 'Quantité Min. Recurrente';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW17.10.03 DIT-770 #327';
        //     MinValue = 0;
        // }
        // field(2014506; "Splitting per"; Option)
        // {
        //     CaptionML = ENU = 'Calculate Source Per',
        //                 FRA = 'Calculer source par';
        //     Description = 'DITW17.10.03 DIT-770 #327';
        //     InitValue = Item;
        //     OptionCaptionML = ENU = 'Group,Item',
        //                       FRA = 'Groupe,Article';
        //     OptionMembers = Group,Item;
        // }
        // field(2014507; "Minimum Quantity"; Decimal)
        // {
        //     Caption = 'Minimum Quantity';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'NRQ#14143';
        //     MinValue = 0;
        // }
        // field(2029610; "_Tariff No."; Code[20])
        // {
        //     CaptionML = ENU = 'Tariff No.',
        //                 FRA = 'Nomenclature produits';
        //     Description = 'FINXL7.00.001';
        //     Enabled = false;
        //     NotBlank = true;
        //     TableRelation = "Tariff Number";
        // }
        // field(2029611; "Auto. Acc. Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Auto. Acc. Group',
        //                 FRA = 'Groupe compte autom.';
        //     Description = 'FINXL7.00.001';
        //     TableRelation = "Automatic Acc. Header";
        // }
        // field(2029612; "Periodic Template Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Periodic Template Code',
        //                 FRA = 'Code modèle périodique';
        //     Description = 'FINXL7.00.001';
        //     TableRelation = "Periodic Template".Code;
        // }
        // field(2029613; "Periodic Starting Date"; Date)
        // {
        //     CaptionML = ENU = 'Periodic Starting Date',
        //                 FRA = 'Date début périodique';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2034850; "DIT Sub-Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Sub Contract Type',
        //                 FRA = 'Sous type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';
        //     OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA = ' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        // }
        // field(2034872; "Contract Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Contract Group Code',
        //                 FRA = 'Code groupe contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';
        // }
        // field(2034915; "Service Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Service Contract No.',
        //                 FRA = 'N° contrat de service';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';

        //     trigger OnValidate();
        //     var
        //         FA2: Record "Fixed Asset";
        //     begin
        //     end;
        // }
        // field(2035090; "No. of Quality Tests"; Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" where("Document Type" = CONST("Lot/SN Test"),
        //                                                      "Source Type" = CONST(39),
        //                                                      "Source Subtype" = FIELD("Document Type"),
        //                                                      "Source ID" = FIELD("Document No."),
        //                                                      "Source Ref. No." = FIELD("Line No."),
        //                                                      "Item No." = FIELD("No.")));
        //     CaptionML = ENU = 'No. of Quality Tests',
        //                 FRA = '<Nbre de Tests Qualité>';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035209; "Last Operation"; Boolean)
        // {
        //     CalcFormula = Exist("Prod. Order Routing Line" where(Status = FILTER(Planned | Released),
        //                                                           "Prod. Order No." = FIELD("Prod. Order No."),
        //                                                           "Routing No." = FIELD("Routing No."),
        //                                                           "Routing Reference No." = FIELD("Routing Reference No."),
        //                                                           "Operation No." = FIELD("Operation No."),
        //                                                           "Next Operation No." = CONST('')));
        //     CaptionML = ENU = 'Last Operation No.',
        //                 FRA = 'Dern. N° opération';
        //     Description = 'DIT-715 #182';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035390; "Linked Customer No."; Code[20])
        // {
        //     CaptionML = ENU = 'Linked Customer No.',
        //                 FRA = 'N° Cilent Lié';
        //     Description = 'DITW17.00.02 DIT-770 #153';
        //     TableRelation = Customer."No.";

        //     trigger OnValidate();
        //     var
        //         RecDimesionSetEntry: Record "Dimension Set Entry";
        //         Tgtext0001: TextConst ENU = 'Please remove the header Link Customer No. before changing line Link Customer No..', FRA = 'S''il vous plaît enlever la tête Lien n ° de client avant de changer de ligne Lien N° client';
        //     begin
        //     end;
        // }
        // field(2035391; "Buy-from Vendor Name"; Text[50])
        // {
        //     CalcFormula = Lookup("Purchase Header"."Buy-from Vendor Name" where("Document Type" = FIELD("Document Type"),
        //                                                                          "No." = FIELD("Document No.")));
        //     CaptionML = ENU = 'Buy-from Vendor Name',
        //                 FRA = 'Nom du fournisseur';
        //     Description = 'DITW17.00.02 DIT-770 #180';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035393; "Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Contract Type',
        //                 FRA = 'Type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392 - DIT-770 #690 -DITW18.00.06 MSF 31/07/2015 DIT-770 #1368';
        //     OptionCaptionML = ENU = ' ,Service,Financial',
        //                       FRA = ' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }
        // field(2036301; "Valid Until"; Date)
        // {
        //     CaptionML = ENU = 'Valid Until',
        //                 FRA = 'Valide jusqu''au';
        //     Description = 'MANXL7.00.001';
        // }
        // field(2036302; "Document Date"; Date)
        // {
        //     CaptionML = ENU = 'Document Date',
        //                 FRA = 'Date document';
        //     Description = 'MANXL7.00.001';
        // }
        // field(2036304; "Revision No."; Code[10])
        // {
        //     CaptionML = ENU = 'Revision No.',
        //                 FRA = 'N° révision';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = IF (Type = CONST(Item)) "Item Minor Revision"."Revision No." where("Item No." = FIELD("No."));
        // }
        // field(2036305; "Requester ID"; Code[50])
        // {
        //     CaptionML = ENU = 'Requester ID',
        //                 FRA = 'ID demandeur';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = User;
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnLookup();
        //     var
        //         LoginMgt: Codeunit "User Management";
        //     begin
        //     end;

        //     trigger OnValidate();
        //     var
        //         LoginMgt: Codeunit "User Management";
        //     begin
        //     end;
        // }
        //BC UPGRADE PATHAA02-DIT<<

    }


    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

