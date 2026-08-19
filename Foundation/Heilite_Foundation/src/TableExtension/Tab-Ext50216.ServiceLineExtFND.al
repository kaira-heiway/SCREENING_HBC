tableextension 50216 ServiceLineExtFND extends "Service Line"
{
    //   DITW15.00.00.35 DDR 17/04/2009 Added fields
    //                                    2034840 Building No.
    //                                    2034850 DIT Sub-Contract Type
    //                                    2034872 Contract Group Code
    //                                  Added key "Document Type,Contract No."
    //                                  Added test when Item Service is blocked
    //                       26/08/2009 Added filter to Service Document Register (ServDocReg)
    //                                  Added functions IsDitContract(),GetSubContractFromContract()
    //                       24/09/2009 issue 817 Added to assign Qty to Invoice or Qty to Consume follwing Contract Group
    //                                   field "Def. Qty. Consume Serv. Wksh."
    //                       01/10/2009 issue 866 Added check and filter on field "contract no." with "DIT Sub-contract type"
    //   DITW15.00.00.36 DDR 03/12/2009 issue 927 Added fields
    //                                    2034924 Maintenance (Service) Code
    //                       18/09/2009 issue 806 Allow to delete service lines linked to service ledger entry
    //                                            Added function SetDeleteFromHeader()
    //                       15/12/2009 issue 806 Allow undo line per line while keep contract invoice date (see "posting date")
    //   DITW15.00.00.37 DDR 20/05/2010 issue 929 Modified option caption field2034850 DIT Sub-Contract Type
    //   DITW15.00.00.39 DDR 31/08/2011 issue 1403
    //                                    Added text constants Text2034840,Text2034841,Text2034842
    //                                    Added functions CheckPurchOrderExist(),CheckPurchReceiptExist()
    //   DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338 Added functions AllItemsAvailability()
    //   DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 Plant Maintenance Functionnality
    //                                               Added 'PlantMaintenance' option field2034850 "DIT Sub-Contract Type"
    //                                               Added functions GetCaptionClassPM(),SetCaptionClassPM(),SetResourceCustFilter()
    //                                               Added flowfilters
    //                                                 2034942 Plant Maintenance Caption
    //                                                 2034955 Customer Filter
    //                                               Added fields
    //                                                 2034954 Down Time (Hours)
    //                                                 2034960 Purchase Order Quantity
    //                                               Modified 'TableRelation' property field5931 "Fault Code"
    //                                               Modified 'TableRelation' property field6 "No." (for Resource record filters)
    //                                               Modified 'OptionString' property field1 "Document Type" (expected order lines)
    //                                               Modified 'TableRelation' property field1 "Document Type"
    //                   DDR 04/09/2012 DIT-715 #297 Added fields
    //                                                 2034961 TPM Code
    //                   DDR 17/09/2012 DIT-715 #297 Bugfix length local variables for function GetCaptionClassPM()
    //                   DDR 18/09/2012 DIT-715 #297 Modified function SetResourceCustFilter()
    //                   DDR 21/09/2012 DIT-715 #347 Added functions RecalculateCostPrices()
    //                   DDR 26/09/2012 DIT-715 #440 Added non-editable when "PM Order Status" = Finished
    //                                               Added functions TestLastOrderStatusFinished()
    //                   DDR 08/10/2012 DIT-715 #297 Added fields
    //                                                 2034980 Qty. on Purch. Order
    //                                                 2034981 Earliest Rcpt. Date Next PO
    //                   PVS 08/10/2012 DIT-715 #448 Corrected testing on existing purchase order
    //                   PVS 12/10/2012 DIT-715 #453 Changed Caption of Posting Date into "Requested Receipt Date"

    //   FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars
    //                                       extended Service Item Line Description from 30 -> 80
    //   FINXL7.00.001 KLU 27/06/2014 #42 : Added field: "Recycle Charge"
    //   FINXL8.00.001 BSA 25/05/2015 #176:Added Fields : "Starting Time", "Ending Time", "Registered Time", "Automatic Time Logging"
    //   FINXL8.00.001 BSA 02/06/2015 #178:Added Fields : "Cross-Reference No.", "Unit of Measure (Cross Ref.)", "Cross-Reference Type","Cross-Reference Type No."
    //   FINXL9.00 DAT 14/12/2015 : Changed function GetItemTranslation() to Not Local

    //   DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    //   DITW17.00.02 DDR 21/08/2013 DIT-715 #732 Removed "Plant Maintenance Caption" flowfilter from all flowfields (bug RTC?)
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW17.10.02 PVS 27/01/2014 DIT-770 #343 Copy DIT Sub Contract Type after Clearing Record
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW18.00.06 DDR 15/04/2015 DIT-770 #983 Review functions GetCaptionClassPM(),SetCaptionClassPM()
    //   DITW18.00.06 MSF 04/03/2015 DIT-770 #1193 Added fields
    //                                                         2014410 "Physical Location Group Code"
    //                                                         2014411 "Resp. Center Table Filter"
    //                                                         2014412 "Phys. Location Table Filter"
    //                                                         2014413 "Location Table Filter"
    //   DITW18.00.06 MSF 05/06/2015 DIT-770 #1416 #1417 Error message when no setup on Resp Center employee location
    //   DITW18.00.06 MSF 11/06/2015 DIT-770 #1416 #1417 Restore Code
    //   DITW18.00.06 BCE 17/08/2015 DIT-770 #1551 Deleted the CalcFormula "Expected Receipt Date,order date,no,no" for the field "qty. on purch. order"
    //   DITW18.00.06 BCE 19/08/2015 DIT-770 #1550 Do not update the related date field
    //   DITW18.00.06 MSF 10/09/2015 DIT-770 #1550 Bug Fix
    //   DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //   FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    //   DITW110.00.09 AKH 29/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    //   DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    //   DITW110.00.11 SFI 31/08/2017 BL#30569 Added changes for SKU blocking

    //   BC Upgrade KUMARS145 Table Ext 

    fields
    {
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            // OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo', FRA = 'Devis,Commande,Facture,Avoir';
        }
        modify("Customer No.")
        {
            //Unsupported feature: Change TableRelation on ""Customer No."(Field 2)". Please convert manually.
            CaptionML = ENU = 'Customer No.', FRA = 'N° client';
            // CaptionClass = GetCaptionClassPM(FIELDCAPTION("Customer No."), Text2014310_2); // BC Upgrade KUMARS145 GetCaptionClassPM is Drinkit Procedure
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
            // OptionCaptionML = ENU = ' ,Item,Resource,Cost,G/L Account', FRA = ' ,Article,Ressource,Coût,Compte général';
        }
        modify("No.")
        {
            //Unsupported feature: Change TableRelation on ""No."(Field 6)". Please convert manually.
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Location Code")
        {
            //Unsupported feature: Change TableRelation on ""Location Code"(Field 7)". Please convert manually.
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
            //Unsupported feature: Change Description on ""Location Code"(Field 7)". Please convert manually.
        }
        modify("Posting Group")
        {
            CaptionML = ENU = 'Posting Group', FRA = 'Groupe comptabilisation';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
            //Unsupported feature: Change Description on "Description(Field 11)". Please convert manually.
            //Unsupported feature: Change Editable on "Description(Field 11)". Please convert manually.
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Description 2';
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
        modify("Qty. to Ship")
        {
            CaptionML = ENU = 'Qty. to Ship', FRA = 'Qté à expédier';
        }
        modify("Unit Price")
        {
            CaptionML = ENU = 'Unit Price', FRA = 'Prix unitaire';
        }
        modify("Unit Cost (LCY)")
        {
            CaptionML = ENU = 'Unit Cost (LCY)', FRA = 'Coût unitaire DS';
        }
        modify("VAT %")
        {
            CaptionML = ENU = 'VAT %', FRA = '% TVA';
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
        modify("Customer Price Group")
        {
            CaptionML = ENU = 'Customer Price Group', FRA = 'Groupe prix client';
        }
        modify("Job No.")
        {
            CaptionML = ENU = 'Job No.', FRA = 'N° projet';
        }
        modify("Job Task No.")
        {
            CaptionML = ENU = 'Job Task No.', FRA = 'N° tâche projet';
        }
        modify("Job Line Type")
        {
            CaptionML = ENU = 'Job Line Type', FRA = 'Type ligne projet';
            // OptionCaptionML = ENU = ' ,Budget,Billable,Both Budget and Billable', FRA = ' ,Budget,Facturable,Budget et Facturable';
        }
        modify("Work Type Code")
        {
            CaptionML = ENU = 'Work Type Code', FRA = 'Code type travail';
        }
        modify("Outstanding Amount")
        {
            CaptionML = ENU = 'Outstanding Amount', FRA = 'Montant en commande';
        }
        modify("Qty. Shipped Not Invoiced")
        {
            CaptionML = ENU = 'Qty. Shipped Not Invoiced', FRA = 'Qté livrée non facturée';
        }
        modify("Shipped Not Invoiced")
        {
            CaptionML = ENU = 'Shipped Not Invoiced', FRA = 'Livré non facturé';
        }
        modify("Quantity Shipped")
        {
            CaptionML = ENU = 'Quantity Shipped', FRA = 'Qté expédiée';
        }
        modify("Quantity Invoiced")
        {
            CaptionML = ENU = 'Quantity Invoiced', FRA = 'Quantité facturée';
        }
        modify("Shipment No.")
        {
            CaptionML = ENU = 'Shipment No.', FRA = 'N° expédition';
        }
        modify("Shipment Line No.")
        {
            CaptionML = ENU = 'Shipment Line No.', FRA = 'N° ligne livraison';
        }
        modify("Bill-to Customer No.")
        {
            CaptionML = ENU = 'Bill-to Customer No.', FRA = 'N° client facturé';
        }
        modify("Inv. Discount Amount")
        {
            CaptionML = ENU = 'Inv. Discount Amount', FRA = 'Montant remise facture';
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
            //  OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
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
        modify("Exit Point")
        {
            CaptionML = ENU = 'Exit Point', FRA = 'Pays destination';
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
        modify("VAT Clause Code")
        {
            CaptionML = ENU = 'VAT Clause Code', FRA = 'Code clause TVA';
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
        modify("Shipped Not Invoiced (LCY)")
        {
            CaptionML = ENU = 'Shipped Not Invoiced (LCY)', FRA = 'Livré non facturé DS';
        }
        modify("Reserved Quantity")
        {
            CaptionML = ENU = 'Reserved Quantity', FRA = 'Quantité réservée';
        }
        modify(Reserve)
        {
            CaptionML = ENU = 'Reserve', FRA = 'Réserver';
            // OptionCaptionML = ENU = 'Never,Optional,Always', FRA = 'Jamais,Manuel,Toujours';
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
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Time Sheet No.")
        {
            CaptionML = ENU = 'Time Sheet No.', FRA = 'N° feuille de temps';
        }
        modify("Time Sheet Line No.")
        {
            CaptionML = ENU = 'Time Sheet Line No.', FRA = 'N° de ligne de la feuille de temps';
        }
        modify("Time Sheet Date")
        {
            CaptionML = ENU = 'Time Sheet Date', FRA = 'Date de la feuille de temps';
        }
        modify("Job Planning Line No.")
        {
            CaptionML = ENU = 'Job Planning Line No.', FRA = 'N° ligne planning projet';
        }
        modify("Job Remaining Qty.")
        {
            CaptionML = ENU = 'Job Remaining Qty.', FRA = 'Quantité travail à accomplir';
        }
        modify("Job Remaining Qty. (Base)")
        {
            CaptionML = ENU = 'Job Remaining Qty. (Base)', FRA = 'Quantité travail à accomplir (base)';
        }
        modify("Job Remaining Total Cost")
        {
            CaptionML = ENU = 'Job Remaining Total Cost', FRA = 'Coût total travail à accomplir';
        }
        modify("Job Remaining Total Cost (LCY)")
        {
            CaptionML = ENU = 'Job Remaining Total Cost (LCY)', FRA = 'Coût total travail à accomplir DS';
        }
        modify("Job Remaining Line Amount")
        {
            CaptionML = ENU = 'Job Remaining Line Amount', FRA = 'Montant ligne travail à accomplir';
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
        modify(Planned)
        {
            CaptionML = ENU = 'Planned', FRA = 'Planifié';
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
        modify("Qty. to Ship (Base)")
        {
            CaptionML = ENU = 'Qty. to Ship (Base)', FRA = 'Qté à expédier (base)';
        }
        modify("Qty. Shipped Not Invd. (Base)")
        {
            CaptionML = ENU = 'Qty. Shipped Not Invd. (Base)', FRA = 'Qté livrée non facturée (base)';
        }
        modify("Qty. Shipped (Base)")
        {
            CaptionML = ENU = 'Qty. Shipped (Base)', FRA = 'Qté expédiée (base)';
        }
        modify("Qty. Invoiced (Base)")
        {
            CaptionML = ENU = 'Qty. Invoiced (Base)', FRA = 'Quantité facturée (base)';
        }
        modify("Reserved Qty. (Base)")
        {
            CaptionML = ENU = 'Reserved Qty. (Base)', FRA = 'Quantité réservée (base)';
        }
        modify("Responsibility Center")
        {
            //Unsupported feature: Change TableRelation on ""Responsibility Center"(Field 5700)". Please convert manually.
            CaptionML = ENU = 'Responsibility Center', FRA = 'Centre de gestion';
        }
        modify("Substitution Available")
        {
            CaptionML = ENU = 'Substitution Available', FRA = 'Substitut disponible';
        }
        modify("Item Category Code")
        {
            CaptionML = ENU = 'Item Category Code', FRA = 'Code catégorie article';
        }
        modify(Nonstock)
        {
            CaptionML = ENU = 'Nonstock', FRA = 'Non stocké';
        }
        // BC Upgrade KUMARS145 Fields Removed in BC ..>>
        // modify("Product Group Code")
        // {
        //     CaptionML = ENU = 'Product Group Code', FRA = 'Code groupe produits';
        // }
        // BC Upgrade KUMARS145 Fields Removed in BC ..<<
        modify("Whse. Outstanding Qty. (Base)")
        {
            CaptionML = ENU = 'Whse. Outstanding Qty. (Base)', FRA = 'Qté restante entrepôt (base)';
        }
        modify("Completely Shipped")
        {
            CaptionML = ENU = 'Completely Shipped', FRA = 'Entièrement expédiée';
        }
        modify("Requested Delivery Date")
        {
            CaptionML = ENU = 'Requested Delivery Date', FRA = 'Date livraison demandée';
        }
        modify("Promised Delivery Date")
        {
            CaptionML = ENU = 'Promised Delivery Date', FRA = 'Date livraison confirmée';
        }
        modify("Shipping Time")
        {
            CaptionML = ENU = 'Shipping Time', FRA = 'Délai d''expédition';
        }
        modify("Planned Delivery Date")
        {
            CaptionML = ENU = 'Planned Delivery Date', FRA = 'Date livraison planifiée';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("Shipping Agent Service Code")
        {
            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
        }
        modify("Appl.-from Item Entry")
        {
            CaptionML = ENU = 'Appl.-from Item Entry', FRA = 'Écriture article à lettrer';
        }
        modify("Service Item No.")
        {
            CaptionML = ENU = 'Service Item No.', FRA = 'N° article de service';
            // CaptionClass = GetCaptionClassPM(FIELDCAPTION("Service Item No."), Text2014310_5902);// BC Upgrade KUMARS145 GetCaptionClassPM is Drinkit Procedure
        }
        modify("Appl.-to Service Entry")
        {
            CaptionML = ENU = 'Appl.-to Service Entry', FRA = 'Ecr. service à lettrer';
        }
        modify("Service Item Line No.")
        {
            CaptionML = ENU = 'Service Item Line No.', FRA = 'N° ligne article de service';
        }
        modify("Service Item Serial No.")
        {
            CaptionML = ENU = 'Service Item Serial No.', FRA = 'N° de série article de service';
        }
        modify("Service Item Line Description")
        {
            CaptionML = ENU = 'Service Item Line Description', FRA = 'Description ligne article de service';
            // CaptionClass = GetCaptionClassPM(FIELDCAPTION("Service Item Line Description"), Text2014310_5906);// BC Upgrade KUMARS145 GetCaptionClassPM is Drinkit Procedure
        }
        modify("Serv. Price Adjmt. Gr. Code")
        {
            CaptionML = ENU = 'Serv. Price Adjmt. Gr. Code', FRA = 'Code groupe ajust. prix serv.';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
            //Unsupported feature: Change Description on ""Posting Date"(Field 5908)". Please convert manually.
        }
        modify("Order Date")
        {
            CaptionML = ENU = 'Order Date', FRA = 'Date commande';
        }
        modify("Needed by Date")
        {
            CaptionML = ENU = 'Needed by Date', FRA = 'Requis par date';
        }
        modify("Ship-to Code")
        {
            CaptionML = ENU = 'Ship-to Code', FRA = 'Code destinataire';
        }
        modify("Qty. to Consume")
        {
            CaptionML = ENU = 'Qty. to Consume', FRA = 'Qté à consommer';
        }
        modify("Quantity Consumed")
        {
            CaptionML = ENU = 'Quantity Consumed', FRA = 'Quantité consommée';
        }
        modify("Qty. to Consume (Base)")
        {
            CaptionML = ENU = 'Qty. to Consume (Base)', FRA = 'Qté à consommer (base)';
        }
        modify("Qty. Consumed (Base)")
        {
            CaptionML = ENU = 'Qty. Consumed (Base)', FRA = 'Qté consommée (base)';
        }
        modify("Service Price Group Code")
        {
            CaptionML = ENU = 'Service Price Group Code', FRA = 'Code groupe tarifs service';
        }
        modify("Fault Area Code")
        {
            CaptionML = ENU = 'Fault Area Code', FRA = 'Code zone panne';
            // CaptionClass = GetCaptionClassPM(FIELDCAPTION("Fault Area Code"), Text2014310_5929);// BC Upgrade KUMARS145 GetCaptionClassPM is Drinkit Procedure
        }
        modify("Symptom Code")
        {
            CaptionML = ENU = 'Symptom Code', FRA = 'Code symptôme';
        }
        modify("Fault Code")
        {
            //Unsupported feature: Change TableRelation on ""Fault Code"(Field 5931)". Please convert manually.
            CaptionML = ENU = 'Fault Code', FRA = 'Code panne';
            // CaptionClass = GetCaptionClassPM(FIELDCAPTION("Fault Code"), Text2014310_5931);// BC Upgrade KUMARS145 GetCaptionClassPM is Drinkit Procedure
        }
        modify("Resolution Code")
        {
            CaptionML = ENU = 'Resolution Code', FRA = 'Code solution';
            // CaptionClass = GetCaptionClassPM(FIELDCAPTION("Resolution Code"), Text2014310_5932);// BC Upgrade KUMARS145 GetCaptionClassPM is Drinkit Procedure
        }
        modify("Exclude Warranty")
        {
            CaptionML = ENU = 'Exclude Warranty', FRA = 'Exclure garantie';
        }
        modify(Warranty)
        {
            CaptionML = ENU = 'Warranty', FRA = 'Garantie';
        }
        modify("Contract No.")
        {
            //Unsupported feature: Change TableRelation on ""Contract No."(Field 5936)". Please convert manually.
            CaptionML = ENU = 'Contract No.', FRA = 'N° contrat';
            // CaptionClass = GetCaptionClassPM(FIELDCAPTION("Contract No."), Text2014310_5936);// BC Upgrade KUMARS145 GetCaptionClassPM is Drinkit Procedure
        }
        modify("Contract Disc. %")
        {
            CaptionML = ENU = 'Contract Disc. %', FRA = '% remise contrat';
        }
        modify("Warranty Disc. %")
        {
            CaptionML = ENU = 'Warranty Disc. %', FRA = '% remise garantie';
        }
        modify("Component Line No.")
        {
            CaptionML = ENU = 'Component Line No.', FRA = 'N° ligne composant';
        }
        modify("Spare Part Action")
        {
            CaptionML = ENU = 'Spare Part Action', FRA = 'Action pièce de rechange';
            OptionCaptionML = ENU = ' ,Permanent,Temporary,Component Replaced,Component Installed', FRA = ' ,Permanent,Temporaire,Composant remplacé,Composant installé';
        }
        modify("Fault Reason Code")
        {
            CaptionML = ENU = 'Fault Reason Code', FRA = 'Code motif panne';
        }
        modify("Replaced Item No.")
        {
            //Unsupported feature: Change TableRelation on ""Replaced Item No."(Field 5968)". Please convert manually.
            CaptionML = ENU = 'Replaced Item No.', FRA = 'N° article remplacé';
            // CaptionClass = GetCaptionClassPM(FIELDCAPTION("Replaced Item No."), Text2014310_5968);// BC Upgrade KUMARS145 GetCaptionClassPM is Drinkit Procedure
        }
        modify("Exclude Contract Discount")
        {
            CaptionML = ENU = 'Exclude Contract Discount', FRA = 'Exclure remise contrat';
        }
        modify("Replaced Item Type")
        {
            CaptionML = ENU = 'Replaced Item Type', FRA = 'Type article remplacé';
            // OptionCaptionML = ENU = ' ,Service Item,Item', FRA = ' ,Article service,Article';
        }
        modify("Price Adjmt. Status")
        {
            CaptionML = ENU = 'Price Adjmt. Status', FRA = 'Statut ajust. prix';
            OptionCaptionML = ENU = ' ,Adjusted,Modified', FRA = ' ,Ajusté,Modifié';
        }
        modify("Line Discount Type")
        {
            CaptionML = ENU = 'Line Discount Type', FRA = 'Type remise ligne';
            // OptionCaptionML = ENU = ' ,Warranty Disc.,Contract Disc.,Line Disc.,Manual', FRA = ' ,Remise garantie,Remise contrat,Remise ligne,Manuelle';
        }
        modify("Copy Components From")
        {
            CaptionML = ENU = 'Copy Components From', FRA = 'Copier les composants à partir de';
            OptionCaptionML = ENU = 'None,Item BOM,Old Service Item,Old Serv.Item w/o Serial No.', FRA = 'Aucun,Nomenclature article,Ancien article de service,Ancien article de serv. sans n° de série';
        }
        modify("Return Reason Code")
        {
            CaptionML = ENU = 'Return Reason Code', FRA = 'Code motif retour';
        }
        modify("Allow Line Disc.")
        {
            CaptionML = ENU = 'Allow Line Disc.', FRA = 'Autoriser remise ligne';
        }
        modify("Customer Disc. Group")
        {
            CaptionML = ENU = 'Customer Disc. Group', FRA = 'Groupe rem. client';
        }
        modify("Qty. Picked")
        {
            CaptionML = ENU = 'Qty. Picked', FRA = 'Qté prélevée';
        }
        modify("Qty. Picked (Base)")
        {
            CaptionML = ENU = 'Qty. Picked (Base)', FRA = 'Qté prélevée (base)';
        }
        modify("Completely Picked")
        {
            CaptionML = ENU = 'Completely Picked', FRA = 'Entièrement prélévé';
        }
        modify("Pick Qty. (Base)")
        {
            CaptionML = ENU = 'Pick Qty. (Base)', FRA = 'Prélever qté (base)';
        }

        // BC Upgrade KUMARS145 Drinkit code commented ... >>
        //Unsupported feature: CodeModification on "Type(Field 5).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckIfCanBeModified;
        GetServHeader;
        TestStatusOpen;
        TESTFIELD("Qty. Shipped Not Invoiced",0);
        TESTFIELD("Quantity Shipped",0);
        TESTFIELD("Shipment No.",'');
        #8..30
          if ServHeader.WhseShpmntConflict("Document Type","Document No.",ServHeader."Shipping Advice") then
            DisplayConflictError(ServHeader.WhseShpmtConflictResolutionTxt);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        // <<DITW16.00.00.41 PVS 08/10/2012 DIT-715 #448
        if CheckPurchOrderExist() then
          ERROR(Text2034840,PurchLine."Document Type",PurchLine."No.",PurchLine."Line No.");
        if CheckPurchReceiptExist() then
          ERROR(Text2034840,Text2034842,PurchRcptLine."No.",PurchRcptLine."Line No.");
        // >>DITW16.00.00.41 PVS 08/10/2012 DIT-715 #448

        #5..33
        */
        //end;


        //Unsupported feature: CodeModification on ""No."(Field 6).OnValidate". Please convert manually.

        //trigger "(Field 6)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckIfCanBeModified;

        TESTFIELD("Qty. Shipped Not Invoiced",0);
        TESTFIELD("Quantity Shipped",0);
        TESTFIELD("Shipment No.",'');
        CheckItemAvailable(FIELDNO("No."));
        UpdateReservation(FIELDNO("No."));
        TestStatusOpen;
        #9..28
        if "Service Item Line No." <> 0 then begin
          ServItemLine.GET(ServHeader."Document Type",ServHeader."No.","Service Item Line No.");
          "Ship-to Code" := ServItemLine."Ship-to Code";
        end else
          "Ship-to Code" := ServHeader."Ship-to Code";
        if "Posting Date" = 0D then
          "Posting Date" := ServHeader."Posting Date";
        "Document Type" := ServHeader."Document Type";
        #37..70
        "Tax Area Code" := ServHeader."Tax Area Code";
        "Tax Liable" := ServHeader."Tax Liable";
        "Responsibility Center" := ServHeader."Responsibility Center";
        "Posting Date" := ServHeader."Posting Date";
        "Currency Code" := ServHeader."Currency Code";
        if "Service Item Line No." <> 0 then begin
          ServItemLine.GET("Document Type","Document No.","Service Item Line No.");
          VALIDATE("Contract No.",ServItemLine."Contract No.")
        #79..137
            begin
              GetItem;
              Item.TESTFIELD(Blocked,false);
              Item.TESTFIELD("Inventory Posting Group");
              Item.TESTFIELD("Gen. Prod. Posting Group");
              Description := Item.Description;
        #144..281

        if ServiceLine.GET("Document Type","Document No.","Line No.") then
          MODIFY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
        // <<DITW16.00.00.41 PVS 08/10/2012 DIT-715 #448
        if CheckPurchOrderExist() then
          ERROR(Text2034840,PurchLine."Document Type",PurchLine."No.",PurchLine."Line No.");
        if CheckPurchReceiptExist() then
          ERROR(Text2034840,Text2034842,PurchRcptLine."No.",PurchRcptLine."Line No.");
        // >>DITW16.00.00.41 PVS 08/10/2012 DIT-715 #448

        // <<DITW15.00.00.35 DDR 24/04/2009 - DITW17.00.01 DDR 21/11/2012 DIT-770 #001
        if ("No." <> '') and (Type = Type::Item) then begin
          if ServItem.GET("Service Item No.") then
            ServItem.TESTFIELD(Blocked,false);
        end;
        // >>DITW15.00.00.35 DDR - DITW17.00.01 DDR 21/11/2012 DIT-770 #001

        #6..31
          // <<DITW15.00.00.36 DDR 07/12/2009
          "Maintenance (Service) Code" := ServItemLine."Maintenance (Service) Code";
          "Contract Group Code" := ServItemLine."Contract Group Code";
          // >>DITW15.00.00.36 DDR
        end else begin
          "Ship-to Code" := ServHeader."Ship-to Code";
          // <<DITW15.00.00.35 DDR 24/04/2009 - DITW15.00.00.36 DDR 07/12/2009
          "Contract Group Code" := ServHeader."Contract Group Code";
          // >>DITW15.00.00.35 DDR
        end;
        #34..73
        //<<DITW18.00.06 MSF 04/03/2015 DIT-770 #1193
        "Physical Location Group Code" :=ServHeader."Physical Location Group Code";
        //>>DITW18.00.06 MSF 04/03/2015 DIT-770 #1193
        "Posting Date" := ServHeader."Posting Date";
        "Currency Code" := ServHeader."Currency Code";
        // <<DITW15.00.00.35 DDR 24/04/2009 - DITW15.00.00.36 DDR 07/12/2009
        "Building No." := ServHeader."Building No.";
        "DIT Sub-Contract Type" := ServHeader."DIT Sub-Contract Type";
        // >>DITW15.00.00.35 DDR

        #76..140
              // << DITW110.00.11 SFI 31/08/2017 BL#30569
              Item.BlockedSKU("Location Code","Variant Code",true);
              // >> DITW110.00.11 SFI BL#30569
        #141..284
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        UpdateWithWarehouseShip;
        GetServHeader;
        if Type = Type::Item then begin
        #5..13
          GetUnitCost;
        end;
        GetDefaultBin;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        // <<DITW16.00.00.41 PVS 08/10/2012 DIT-715 #448
        if CheckPurchOrderExist() then
          ERROR(Text2034840,PurchLine."Document Type",PurchLine."No.",PurchLine."Line No.");
        if CheckPurchReceiptExist() then
          ERROR(Text2034840,Text2034842,PurchRcptLine."No.",PurchRcptLine."Line No.");
        // >>DITW16.00.00.41 PVS 08/10/2012 DIT-715 #448
        // <<DITW18.00.06 MSF 04/03/2015 DIT-770 #1193
        if ("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> xRec."Location Code") and
          ("Location Code" <> '')
        then begin
          Location.GET("Location Code");
          VALIDATE("Responsibility Center",UserMgt.GetFirstRespCenter(2,Location."Physical Location Group Code","Location Code"));
        end;
        if (("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> '')) or
          ("Responsibility Center" <> xRec."Responsibility Center")
        then
          if not UserMgt.CheckLocation(2,"Location Code","Responsibility Center") then
            ERROR(
              Text2014412,
              Location.TABLECAPTION,"Location Code",
              RespCenter.TABLECAPTION,UserMgt.GetServiceFilter);
        if "Location Code" <> '' then begin
          Location.GET("Location Code");
          if Location."Physical Location Group Code" <> "Physical Location Group Code" then
            "Physical Location Group Code" := Location."Physical Location Group Code";
        end else
          if xRec."Physical Location Group Code" = "Physical Location Group Code" then
            "Physical Location Group Code" := '';
        if xRec."Physical Location Group Code" = "Physical Location Group Code" then
          VALIDATE("Physical Location Group Code");
        // >>DITW18.00.06 MSF 04/03/2015 DIT-770 #1193

        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        if (Type = Type::Item) then begin
          GetItem();
          Item.BlockedSKU("Location Code","Variant Code",true);
        end;
        // >> DITW110.00.11 SFI BL#30569
        #2..16
        */
        //end;


        //Unsupported feature: CodeModification on "Quantity(Field 15).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetServHeader;
        TESTFIELD(Type);
        TESTFIELD("No.");
        TestStatusOpen;

        if Quantity < 0 then
          FIELDERROR(Quantity,Text029);

        case "Spare Part Action" of
          "Spare Part Action"::Permanent,"Spare Part Action"::"Temporary":
            if Quantity <> 1 then
        #12..65
        end;
        if "Job Planning Line No." <> 0 then
          VALIDATE("Job Planning Line No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..8
        // <<DITW16.00.00.41 PVS 08/10/2012 DIT-715 #448
        if CheckPurchOrderExist() then
          ERROR(Text2034840,PurchLine."Document Type",PurchLine."No.",PurchLine."Line No.");
        if CheckPurchReceiptExist() then
          ERROR(Text2034840,Text2034842,PurchRcptLine."No.",PurchRcptLine."Line No.");
        // >>DITW16.00.00.41 PVS 08/10/2012 DIT-715 #448

        #9..68

        // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
        if "DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" " then
          VALIDATE("Purchase Order Quantity",Quantity);
        // >>DITW16.00.00.41 DDR DIT-715 #297
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipment No."(Field 63).OnLookup". Please convert manually.

        //trigger "(Field 63)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetServHeader;
        if "Document Type" = "Document Type"::"Credit Memo" then begin
          CLEAR(ServShptHeader);
        #4..6
          ServShptHeader.SETRANGE("Ship-to Code",ServHeader."Ship-to Code");
          ServShptHeader.SETRANGE("Bill-to Customer No.",ServHeader."Bill-to Customer No.");
          ServShptHeader.FILTERGROUP(0);
          ServShptHeader."No." := "Shipment No.";
          if PAGE.RUNMODAL(0,ServShptHeader) = ACTION::LookupOK then
            VALIDATE("Shipment No.",ServShptHeader."No.");
        end
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..9
          // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
          ServShptHeader.SETRANGE("Plant Maintenance Caption",RunModeCaptionPM);
          // >>DITW16.00.00.41 DDR DIT-715 #297
        #10..13
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shipment No."(Field 63).OnValidate". Please convert manually.

        //trigger (Variable: lrServShptHeader)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipment No."(Field 63).OnValidate". Please convert manually.

        //trigger "(Field 63)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Shipment No." <> xRec."Shipment No." then begin
          if "Shipment No." <> '' then begin
            GetServHeader;
        #4..16
          ServDocReg.SETRANGE("Destination Document No.","Document No.");
          ServDocReg.SETRANGE("Source Document Type",ServDocReg."Source Document Type"::Order);
          ServDocReg.SETRANGE("Source Document No.",xRec."Shipment No.");
          ServDocReg.DELETEALL;
          CLEAR(ServDocReg);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..19
          // <<DITW15.00.00.35 DDR 26/08/2009
          if not lrServShptHeader.GET(xRec."Shipment No.") then
            CLEAR(lrServShptHeader);
          ServDocReg.SETRANGE("Dest. DIT Sub-Contract Type",lrServShptHeader."DIT Sub-Contract Type");
          // >>DITW15.00.00.35 DDR
        #20..22
        */
        //end;


        //Unsupported feature: CodeModification on ""Variant Code"(Field 5402).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Variant Code" <> '' then
          TESTFIELD(Type,Type::Item);
        TestStatusOpen;
        #4..28
          exit;
        end;

        ItemVariant.GET("No.","Variant Code");
        Description := ItemVariant.Description;
        "Description 2" := ItemVariant."Description 2";

        GetServHeader;
        if ServHeader."Language Code" <> '' then
          GetItemTranslation;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..31
        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        if (Type = Type::Item) then begin
          GetItem();
          Item.BlockedSKU("Location Code","Variant Code",true);
        end;
        // >> DITW110.00.11 SFI BL#30569
        #32..38
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Responsibility Center"(Field 5700).OnValidate". Please convert manually.

        //trigger (Variable: LocationCode)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Responsibility Center"(Field 5700).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CreateDim(
          DATABASE::"Responsibility Center","Responsibility Center",
          DimMgt.TypeToTableID5(Type),"No.",
          DATABASE::Job,"Job No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW18.00.06 MSF 23/02/2015 DIT-770 #1193
        if xRec."Responsibility Center" <> "Responsibility Center" then begin
          if not UserMgt.CheckRespCenter(2,"Responsibility Center") then
            ERROR(
              Text2014413,
              RespCenter.TABLECAPTION,UserMgt.GetServiceFilter);
        end;
        if (CurrFieldNo <> FIELDNO("Location Code")) and
          (CurrFieldNo <> FIELDNO("Physical Location Group Code")) and
          (xRec."Physical Location Group Code" = "Physical Location Group Code") and
          (xRec."Location Code" = "Location Code")
        then begin
            VALIDATE("Physical Location Group Code", UserMgt.GetphysicalLocation(2,'',"Responsibility Center"));
            LocationCode := UserMgt.GetLocation(2,'',"Responsibility Center");
            if (LocationCode <> '') or ("Physical Location Group Code" <> xRec."Physical Location Group Code") then
              VALIDATE("Location Code", LocationCode);
        end;
        // >>DITW18.00.06 MSF DIT-770 #1193

        #1..4
        */
        //end;


        //Unsupported feature: CodeModification on ""Planned Delivery Date"(Field 5794).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Needed by Date","Planned Delivery Date");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW18.00.06 MSF 10/09/2015 DIT-770 #1550
        if not RunModeCaptionPM then
          VALIDATE("Needed by Date","Planned Delivery Date");
        //<<DITW18.00.06 MSF 10/09/2015 DIT-770 #1550
        */
        //end;


        //Unsupported feature: CodeModification on ""Service Item No."(Field 5902).OnLookup". Please convert manually.

        //trigger "(Field 5902)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Document Type" in ["Document Type"::Invoice,"Document Type"::"Credit Memo"] then begin
          ServItem.RESET;
          ServItem.SETCURRENTKEY("Customer No.");
          ServItem.FILTERGROUP(2);
          ServItem.SETRANGE("Customer No.","Customer No.");
          ServItem.FILTERGROUP(0);
          if PAGE.RUNMODAL(0,ServItem) = ACTION::LookupOK then
            VALIDATE("Service Item No.",ServItem."No.");
        end
        #10..13
          ServItemLine.SETRANGE("Document Type","Document Type");
          ServItemLine.SETRANGE("Document No.","Document No.");
          ServItemLine.FILTERGROUP(0);
          ServItemLine."Service Item No." := "Service Item No.";
          if PAGE.RUNMODAL(0,ServItemLine) = ACTION::LookupOK then
            VALIDATE("Service Item Line No.",ServItemLine."Line No.");
        end;

        if "Service Item No." <> xRec."Service Item No." then
          VALIDATE("No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
          // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
          ServItem.SETRANGE("Plant Maintenance Caption",RunModeCaptionPM);
          // >>DITW16.00.00.41 DDR DIT-715 #297
        #7..16
          // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
          ServItemLine.SETRANGE("Plant Maintenance Caption",RunModeCaptionPM);
          // >>DITW16.00.00.41 DDR DIT-715 #297
        #17..23
        */
        //end;


        //Unsupported feature: CodeModification on ""Service Item No."(Field 5902).OnValidate". Please convert manually.

        //trigger "(Field 5902)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Quantity Shipped",0);
        TESTFIELD("Shipment No.",'');
        if "Service Item No." <> '' then begin
        #4..8
          ServItemLine.SETRANGE("Service Item No.","Service Item No.");
          ServItemLine.FIND('-');
          VALIDATE("Service Item Line No.",ServItemLine."Line No.");
        end;

        if "Service Item No." <> xRec."Service Item No." then begin
          if "Service Item No." = '' then
            VALIDATE("Service Item Line No.",0);
          VALIDATE("No.");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11

          // <<DITW15.00.00.35 DDR 24/04/2009
          if ServItem.GET("Service Item No.") then
            ServItem.TESTFIELD(Blocked,false);
          // >>DITW15.00.00.35 DDR
        #12..18
        */
        //end;


        //Unsupported feature: CodeModification on ""Service Item Line No."(Field 5904).OnValidate". Please convert manually.

        //trigger "(Field 5904)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Quantity Shipped",0);
        ErrorIfAlreadySelectedSI("Service Item Line No.");
        if ServItemLine.GET("Document Type","Document No.","Service Item Line No.") then begin
        #4..8
          "Resolution Code" := ServItemLine."Resolution Code";
          "Service Price Group Code" := ServItemLine."Service Price Group Code";
          "Serv. Price Adjmt. Gr. Code" := ServItemLine."Serv. Price Adjmt. Gr. Code";
          if "No." <> '' then
            VALIDATE("Contract No.",ServItemLine."Contract No.");
        end else begin
          "Service Item No." := '';
          "Service Item Serial No." := '';
        end;
        CALCFIELDS("Service Item Line Description");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11
          // <<DITW16.00.00.41 DDR 04/09/2012 DIT-715 #297
          "TPM Code":= ServItemLine."TPM Code";
          // >>DITW16.00.00.41 DDR DIT-715 #297
        #12..18
        */
        //end;


        //Unsupported feature: CodeModification on ""Service Item Serial No."(Field 5905).OnLookup". Please convert manually.

        //trigger "(Field 5905)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ServItemLine.RESET;
        ServItemLine.SETRANGE("Document Type","Document Type");
        ServItemLine.SETRANGE("Document No.","Document No.");
        ServItemLine."Serial No." := "Service Item Serial No.";
        if PAGE.RUNMODAL(0,ServItemLine) = ACTION::LookupOK then
          VALIDATE("Service Item Line No.",ServItemLine."Line No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
        ServItemLine.SETRANGE("Plant Maintenance Caption",RunModeCaptionPM);
        // >>DITW16.00.00.41 DDR DIT-715 #297
        #4..6
        */
        //end;


        //Unsupported feature: CodeModification on ""Needed by Date"(Field 5910).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        if CurrFieldNo = FIELDNO("Needed by Date") then
          if xRec."Needed by Date" <> 0D then
        #4..7
          UpdateReservation(CurrFieldNo)
        else
          UpdateReservation(FIELDNO("Needed by Date"));
        "Planned Delivery Date" := "Needed by Date";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..10
        //<<DITW18.00.06 MSF 10/09/2015 DIT-770 #1550
        if not RunModeCaptionPM then
        //<<DITW18.00.06 MSF 10/09/2015 DIT-770 #1550
          "Planned Delivery Date" := "Needed by Date";
        */
        //end;


        //Unsupported feature: CodeModification on ""Contract No."(Field 5936).OnLookup". Please convert manually.

        //trigger "(Field 5936)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetServHeader;
        ServContractHeader.FILTERGROUP(2);
        ServContractHeader.SETRANGE("Customer No.",ServHeader."Customer No.");
        ServContractHeader.SETRANGE("Contract Type",ServContractHeader."Contract Type"::Contract);
        ServContractHeader.FILTERGROUP(0);
        if (PAGE.RUNMODAL(0,ServContractHeader) = ACTION::LookupOK) and
           ("Document Type" in ["Document Type"::Invoice,"Document Type"::"Credit Memo"])
        then
          VALIDATE("Contract No.",ServContractHeader."Contract No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        // <<DITW15.00.00.35 DDR 01/10/2009
        ServContractHeader.SETRANGE("DIT Sub-Contract Type","DIT Sub-Contract Type");
        // >>DITW15.00.00.35 DDR
        #5..9
        */
        //end;


        //Unsupported feature: CodeModification on ""Contract No."(Field 5936).OnValidate". Please convert manually.

        //trigger "(Field 5936)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Shipment Line No." <> 0 then
          if "Shipment No." <> '' then
            FIELDERROR("Contract No.");

        if "Document Type" in ["Document Type"::Invoice,"Document Type"::"Credit Memo"] then begin
          if "Contract No." <> xRec."Contract No." then begin
            TESTFIELD("Appl.-to Service Entry",0);
            UpdateServDocRegister(false);
          end;
        end else begin
          ServMgtSetup.GET;
          if not ServItem.GET("Service Item No.") then
            CLEAR(ServItem);
          if "Contract No." = '' then
            "Contract Disc. %" := 0
          else begin
            GetServHeader;
            if ServContract.GET(ServContract."Contract Type"::Contract,"Contract No.") then begin
              if (ServContract."Starting Date" <= WORKDATE) and not "Exclude Contract Discount" then begin
                if not ContractGr.GET(ServContract."Contract Group Code") then
                  CLEAR(ContractGr);
        #22..66
              end;
            end else
              "Contract Disc. %" := 0;
          end;

          if Warranty then
        #73..80

          UpdateDiscountsAmounts;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
        GetServHeader;
        // >>DITW16.00.00.41 DDR DIT-715 #297

        #5..8
          // <<DITW15.00.00.35 DDR 01/10/2009
          end else begin
            "Building No." := ServHeader."Building No.";
            "DIT Sub-Contract Type" := ServHeader."DIT Sub-Contract Type";
            "Contract Group Code" := ServHeader."Contract Group Code";
          end;
          // >>DITW15.00.00.35 DDR
        #10..13
          if "Contract No." = '' then begin
            "Contract Disc. %" := 0;
            // <<DITW15.00.00.35 DDR 17/04/2009
            // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
            "DIT Sub-Contract Type" := ServHeader."DIT Sub-Contract Type";
            // >>DITW16.00.00.41 DDR DIT-715 #297
            "Contract Group Code" := '';
            "Building No." := '';
            // >>DITW15.00.00.35 DDR
          end else begin
            GetServHeader;
            if ServContract.GET(ServContract."Contract Type"::Contract,"Contract No.") then begin
              // <<DITW15.00.00.35 DDR 01/10/2009
              ServContract.TESTFIELD("DIT Sub-Contract Type","DIT Sub-Contract Type");
              // >>DITW15.00.00.35 DDR
              // <<DITW15.00.00.35 DDR 17/04/2009
              "DIT Sub-Contract Type" := ServContract."DIT Sub-Contract Type";
              "Contract Group Code" := ServContract."Contract Group Code";
              "Building No." := ServContract."Building No.";
              // >>DITW15.00.00.35 DDR
        #19..69

            // <<DITW15.00.00.35 DDR 24/09/2009
            if not ContractGr.GET(ServContract."Contract Group Code") then
              CLEAR(ContractGr);
            if ContractGr."Def. Qty. Consume Serv. Wksh." and (xRec."Contract Group Code" <> "Contract Group Code") then
              VALIDATE(Quantity);
            // >>DITW15.00.00.35 DDR
        #70..83
        */
        //end;
        // BC Upgrade KUMARS145 Drinkit code commented ... <<

        // BC Upgrade KUMARS145 Drinkit Fields commented ... >>
        // field(2014410; "Physical Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Physical Location Group Code',
        //                 FRA = 'Code groupe magasin réel';
        //     Description = 'DITW18.00.06 DIT-770 #1193';
        //     TableRelation = "Physical Location Group" WHERE(Code = FIELD("Phys. Location Table Filter"));

        //     trigger OnValidate();
        //     var
        //         PhysLocationGr: Record "Physical Location Group";
        //     begin
        //         // <<DITW18.00.06 MSF 04/03/2015 DIT-770 #1193
        //         if ("Responsibility Center" = xRec."Responsibility Center") and
        //           ("Physical Location Group Code" <> xRec."Physical Location Group Code") and
        //           ("Physical Location Group Code" <> '')
        //         then
        //             VALIDATE("Responsibility Center", UserMgt.GetFirstRespCenter(2, "Physical Location Group Code", ''));

        //         if not UserMgt.CheckPhysLocation(2, "Physical Location Group Code", "Responsibility Center") then
        //             ERROR(
        //               Text2014412,
        //               PhysLocationGr.TABLECAPTION, "Physical Location Group Code",
        //               RespCenter.TABLECAPTION, UserMgt.GetServiceFilter);

        //         if (xRec."Physical Location Group Code" <> "Physical Location Group Code") then begin
        //             CLEAR(Location);
        //             if "Location Code" <> '' then
        //                 Location.GET("Location Code");
        //             if (Location."Physical Location Group Code" <> "Physical Location Group Code") then begin
        //                 if ((CurrFieldNo <> FIELDNO("Location Code")) and (xRec."Responsibility Center" = "Responsibility Center")) then
        //                     VALIDATE("Location Code", '')
        //                 else
        //                     "Location Code" := '';
        //             end;
        //         end;
        //         // >>DITW18.00.06 MSF DIT-770 #1193
        //     end;
        // }
        // field(2014411; "Resp. Center Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Resp. Center Table Filter',
        //                 FRA = 'Filtre Centre de gestion (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1193';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Responsibility Center";
        // }
        // field(2014412; "Phys. Location Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Phys. Location Table Filter',
        //                 FRA = 'Filtre groupe magasin réel (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1193';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014413; "Location Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Location Table Filter',
        //                 FRA = 'Filtre Magasin (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1193';
        //     FieldClass = FlowFilter;
        //     TableRelation = Location;
        // }
        // field(2029611; "Starting Time"; Time)
        // {
        //     CaptionML = ENU = 'Starting Time',
        //                 FRA = 'Heure début';
        //     Description = 'FINXL8.00.001 BSA 25/05/2015 #176';

        //     trigger OnValidate();
        //     begin
        //         //<<FINXL8.00.001 BSA 25/05/2015 #176
        //         if recFinXLSetup.READPERMISSION then
        //             fctUpdateTimeSheetDetail();
        //         //>>FINXL8.00.001 BSA 25/05/2015 #176

        //         //<<FINXL8.00.001 BSA 25/05/2015 #176
        //         if recFinXLSetup.READPERMISSION then
        //             fctCalcRegisteredTime();
        //         //>>FINXL8.00.001 BSA 25/05/2015 #176
        //     end;
        // }
        // field(2029612; "Ending Time"; Time)
        // {
        //     CaptionML = ENU = 'Ending Time',
        //                 FRA = 'Heure fin';
        //     Description = 'FINXL8.00.001 BSA 25/05/2015 #176';

        //     trigger OnValidate();
        //     begin
        //         //<<FINXL8.00.001 BSA 25/05/2015 #176
        //         if recFinXLSetup.READPERMISSION then
        //             fctUpdateTimeSheetDetail();
        //         //>>FINXL8.00.001 BSA 25/05/2015 #176


        //         //<<FINXL8.00.001 BSA 25/05/2015 #176
        //         if recFinXLSetup.READPERMISSION then
        //             fctCalcRegisteredTime();
        //         //>>FINXL8.00.001 BSA 25/05/2015 #176
        //     end;
        // }
        // field(2029613; "Registered Time"; Decimal)
        // {
        //     CaptionML = ENU = 'Registered Time',
        //                 FRA = 'Heure enregistrée';
        //     Description = 'FINXL8.00.001 BSA 25/05/2015 #176';
        //     Editable = false;

        //     trigger OnValidate();
        //     begin
        //         //<<FINXL8.00.001 BSA 25/05/2015 #176
        //         if recFinXLSetup.READPERMISSION then
        //             if not "Automatic Time Logging" then
        //                 VALIDATE(Quantity, "Registered Time");
        //         //>>FINXL8.00.001 BSA 25/05/2015 #176
        //     end;
        // }
        // field(2029614; "Automatic Time Logging"; Boolean)
        // {
        //     CaptionML = ENU = 'Automatic Time Logging',
        //                 FRA = 'Heure automatique d''enregistrement';
        //     Description = 'FINXL8.00.001 BSA 25/05/2015 #176';
        // }
        // field(2029615; "Cross-Reference No."; Code[20])
        // {
        //     CaptionML = ENU = 'Cross-Reference No.',
        //                 FRA = 'Référence externe';
        //     Description = 'FINXL8.00.001 BSA 02/06/2015 #178';

        //     trigger OnLookup();
        //     begin
        //         //<<FINXL8.00.001 BSA 02/06/2015 #178
        //         if recFinXLSetup.READPERMISSION then
        //             fctCrossReferenceNoLookUp;
        //         //>>FINXL8.00.001 BSA 02/06/2015 #178
        //     end;

        //     trigger OnValidate();
        //     var
        //         lrecReturnedCrossRef: Record "Item Cross Reference";
        //         lcduDistIntegration: Codeunit "Dist. Integration";
        //     begin
        //         //<<FINXL8.00.001 BSA 02/06/2015 #178
        //         if recFinXLSetup.READPERMISSION then begin
        //             GetServHeader;
        //             "Customer No." := ServHeader."Customer No.";
        //             lrecReturnedCrossRef.INIT;
        //             if "Cross-Reference No." <> '' then begin
        //                 lcduDistIntegration.fctICRLookupServItem(Rec, lrecReturnedCrossRef);
        //                 if "No." <> lrecReturnedCrossRef."Item No." then
        //                     VALIDATE("No.", lrecReturnedCrossRef."Item No.");
        //                 if lrecReturnedCrossRef."Variant Code" <> '' then
        //                     VALIDATE("Variant Code", lrecReturnedCrossRef."Variant Code");

        //                 if lrecReturnedCrossRef."Unit of Measure" <> '' then
        //                     VALIDATE("Unit of Measure Code", lrecReturnedCrossRef."Unit of Measure");
        //             end;

        //             "Unit of Measure (Cross Ref.)" := lrecReturnedCrossRef."Unit of Measure";
        //             "Cross-Reference Type" := lrecReturnedCrossRef."Cross-Reference Type";
        //             "Cross-Reference Type No." := lrecReturnedCrossRef."Cross-Reference Type No.";
        //             "Cross-Reference No." := lrecReturnedCrossRef."Cross-Reference No.";

        //             if lrecReturnedCrossRef.Description <> '' then
        //                 Description := lrecReturnedCrossRef.Description;

        //             UpdateUnitPrice(FIELDNO("Cross-Reference No."));
        //         end;
        //         //>>FINXL8.00.001 BSA 02/06/2015 #178
        //     end;
        // }
        // field(2029616; "Unit of Measure (Cross Ref.)"; Code[10])
        // {
        //     CaptionML = ENU = 'Unit of Measure (Cross Ref.)',
        //                 FRA = 'Unité référence externe';
        //     Description = 'FINXL8.00.001 BSA 02/06/2015 #178';
        //     TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        // }
        // field(2029617; "Cross-Reference Type"; Option)
        // {
        //     CaptionML = ENU = 'Cross-Reference Type',
        //                 FRA = 'Type référence externe';
        //     Description = 'FINXL8.00.001 BSA 02/06/2015 #178';
        //     OptionCaptionML = ENU = ' ,Customer,Vendor,Bar Code',
        //                       FRA = ' ,Client,Fournisseur,Code barre';
        //     OptionMembers = " ",Customer,Vendor,"Bar Code";
        // }
        // field(2029618; "Cross-Reference Type No."; Code[30])
        // {
        //     CaptionML = ENU = 'Cross-Reference Type No.',
        //                 FRA = 'N° type référence externe';
        //     Description = 'FINXL8.00.001 BSA 02/06/2015 #178';
        // }
        // field(2034840; "Building No."; Code[20])
        // {
        //     CaptionML = ENU = 'Building No.',
        //                 FRA = 'N° immeuble';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = Building;

        //     trigger OnValidate();
        //     var
        //         Building: Record Building;
        //     begin
        //         // <<DITW15.00.00.35 DDR 10/04/2009
        //         if "Building No." <> '' then begin
        //             Building.GET("Building No.");
        //             Building.TESTFIELD(Blocked, false);
        //         end;
        //     end;
        // }
        // field(2034850; "DIT Sub-Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Sub Contract Type',
        //                 FRA = 'Sous type contrat';
        //     Description = 'DITW15.00.00.35- DIT-715 #297';
        //     OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA = ' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        // }
        // field(2034872; "Contract Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Contract Group Code',
        //                 FRA = 'Code groupe contrat';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Contract Group" WHERE("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));

        //     trigger OnValidate();
        //     var
        //         ServContract: Record "Service Contract Header";
        //     begin
        //         // <<DITW15.00.00.35 DDR 21/04/2009
        //         if "Contract Group Code" <> '' then begin
        //             TESTFIELD("Contract No.");
        //             if ServContract.GET(ServContract."Contract Type"::Contract, "Contract No.") then
        //                 TESTFIELD("Contract Group Code", ServContract."Contract Group Code");
        //         end;
        //         // >>DITW15.00.00.35 DDR
        //     end;
        // }
        // field(2034924; "Maintenance (Service) Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Maintenance Code',
        //                 FRA = 'Code maintenance';
        //     Description = 'DITW15.00.00.36';
        //     TableRelation = "Maintenance (Service)";

        //     trigger OnValidate();
        //     begin
        //         if "Maintenance (Service) Code" <> '' then begin
        //             MaintenanceServ.GET("Maintenance (Service) Code");
        //             if MaintenanceServ.Description <> '' then
        //                 Description := MaintenanceServ.Description;
        //         end;
        //     end;
        // }
        // field(2034942; "Plant Maintenance Caption"; Boolean)
        // {
        //     CaptionML = ENU = 'Plant Maintenance Caption',
        //                 FRA = 'Label Maintenance Usine';
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        //     FieldClass = FlowFilter;
        // }
        // field(2034954; "Down Time (Hours)"; Decimal)
        // {
        //     CaptionML = ENU = 'Down Time (Hours)',
        //                 FRA = 'Délai d''arrêt (heures)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        // }
        // field(2034955; "Customer Filter"; Code[20])
        // {
        //     CaptionML = ENU = 'Plant Filter',
        //                 FRA = 'Filtre Usine';
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        //     FieldClass = FlowFilter;
        //     TableRelation = Customer;
        // }
        // field(2034960; "Purchase Order Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Purchase Order Quantity',
        //                 FRA = 'Quantité commande achat';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        // }
        // field(2034961; "TPM Code"; Code[10])
        // {
        //     CaptionML = ENU = 'TPM Code',
        //                 FRA = 'Code TPM';
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        //     TableRelation = "TPM Code".Code;
        // }
        // field(2034980; "Qty. on Purch. Order"; Decimal)
        // {
        //     CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST(Order),
        //                                                                        Type = CONST(Item),
        //                                                                        "No." = FIELD("No."),
        //                                                                        "Shortcut Dimension 1 Code" = FIELD("Shortcut Dimension 1 Code"),
        //                                                                        "Shortcut Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code"),
        //                                                                        "Location Code" = FIELD("Location Code"),
        //                                                                        "Variant Code" = FIELD("Variant Code")));
        //     CaptionML = ENU = 'Qty. on Purch. Order',
        //                 FRA = 'Qté sur commande achat';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2034981; "Earliest Rcpt. Date Next PO"; Date)
        // {
        //     CalcFormula = Lookup("Purchase Line"."Expected Receipt Date" WHERE("Document Type" = CONST(Order),
        //                                                                         Type = CONST(Item),
        //                                                                         "No." = FIELD("No."),
        //                                                                         "Shortcut Dimension 1 Code" = FIELD("Shortcut Dimension 1 Code"),
        //                                                                         "Shortcut Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code"),
        //                                                                         "Location Code" = FIELD("Location Code"),
        //                                                                         "Variant Code" = FIELD("Variant Code"),
        //                                                                         "Outstanding Qty. (Base)" = FILTER(<> 0)));
        //     CaptionML = ENU = 'Earliest Receipt Date Next Purchase Order',
        //                 FRA = 'Premiére date de recéption de la prochaine commande achat';
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // BC Upgrade KUMARS145 Drinkit Fields commented ... <<

    }
    keys
    {
        //Unsupported feature: Deletion on ""Type,""No."",""Variant Code"",""Location Code"",""Needed by Date"",""Document Type"",""Shortcut Dimension 1 Code"",""Shortcut Dimension 2 Code"""(Key)". Please convert manually.
        // BC Upgrade KUMARS145 Dependent on Drinkit's Field  ... >>
        // key(NewKey1; Type, "No.", "Variant Code", "Location Code", "Needed by Date", "Document Type", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "DIT Sub-Contract Type")
        // {
        //     SumIndexFields = "Quantity (Base)", "Outstanding Qty. (Base)";
        // }
        // BC Upgrade KUMARS145 Dependent on Drinkit's Field  ... <<
        key(NewKey2; "Document Type", "Contract No.") { } // BC Upgrade KUMARS145
    }

    // BC Upgrade KUMARS145 Drinkit code commented ... >>
    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: ServLedgPostRev)();
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
    TestStatusOpen;
    if Type = Type::Item then
      WhseValidateSourceLine.ServiceLineDelete(Rec);
    if Type in [Type::"G/L Account",Type::Cost,Type::Resource] then
      TESTFIELD("Qty. Shipped Not Invoiced",0);

    if ("Document Type" = "Document Type"::Invoice) and ("Appl.-to Service Entry" > 0) then
      ERROR(Text045);

    if (Quantity <> 0) and ItemExists("No.") then begin
      ReserveServLine.DeleteLine(Rec);
    #12..14
        TESTFIELD("Qty. Shipped Not Invoiced",0);
    end;

    ReserveServLine.DeleteLine(Rec);
    if (Type = Type::Item) and Item.GET("No.") then
      NonstockItemMgt.DelNonStockFSM(Rec);
    #21..32
      ServiceLine2.SETFILTER("Line No.",'<>%1',"Line No.");
      ServiceLine2.DELETEALL(true);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    // <<DITW15.00.00.35 DDR 20/04/2009
    GetServHeader;
    // >>DITW15.00.00.35 DDR

    // <<DITW15.00.00.36 DDR 18/09/2009 - 15/12/2009
    if DitPropServMgtSetup.READPERMISSION then begin
      if ("Document Type" = "Document Type" :: Invoice) and ("Appl.-to Service Entry" > 0) then begin
        UndoServContractDoc.CheckDelPrevServLineInvoices(Rec);
        UndoServContractDoc.UpdContrNextDateFromServLine(Rec);
        ServLedgPostRev.RevServLine(Rec);
        TESTFIELD("Appl.-to Item Entry",0);
      end;
    end else
    // >>DITW15.00.00.36 DDR
      if ("Document Type" = "Document Type"::Invoice) and ("Appl.-to Service Entry" > 0) then
        ERROR(Text045);
    #9..17
    // <<DITW15.00.00.39 DDR 01/09/2011 #1403
    if CheckPurchOrderExist() then
      ERROR(Text2034841,PurchLine."Document Type",PurchLine."No.",PurchLine."Line No.");

    if CheckPurchReceiptExist() then
      ERROR(Text2034841,Text2034842,PurchRcptLine."No.",PurchRcptLine."Line No.");
    // >>DITW15.00.00.39 DDR #1403

    #18..35
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
    // BC Upgrade KUMARS145 Drinkit Fields commented ... <<

    // BC Upgrade KUMARS145 Drinkit Variables commented ... >>
    // var
    //     lrServShptHeader: Record "Service Shipment Header";
    //     LocationCode: Code[20];
    //     ServLedgPostRev: Codeunit "Serv. Ledg.-Post Reverse Line";
    //     FoundHeader: Boolean;
    //     IsTempRec: Boolean;
    //     MaintenanceServ: Record "Maintenance (Service)";
    //     DitPropServMgtSetup: Record "Property Service Mgt. Setup";
    //     UndoServContractDoc: Codeunit UndoSignServContractDoc;
    //     DeleteLineFromHeader: Boolean;
    //     Text2034840: TextConst ENU = 'You cannot change because the purchase %1 %2 line %3  is associated with this line.', FRA = 'Vous ne pouvez pas modifier parce que la %1 achat %2 ligne %3 est associée à cette ligne.';
    //     Text2034841: TextConst ENU = 'You cannot delete because the purchase %1 %2 line %3 is associated with this line.', FRA = 'Vous ne pouvez pas supprimer parce que la %1 achat %2 ligne %3 est associée à cette ligne.';
    //     Text2034842: TextConst ENU = 'receipt', FRA = 'réception';
    //     PurchLine: Record "Purchase Line";
    //     PurchRcptLine: Record "Purch. Rcpt. Line";
    //     RunModeCaptionPM: Boolean;
    //     Text2014310_2: TextConst ENU = 'Plant No', FRA = 'N° Usine';
    //     Text2014310_5902: TextConst ENU = 'Equipment No', FRA = 'N° équipement';
    //     Text2014310_5906: TextConst ENU = 'Equipment Line Description', FRA = 'Désignation ligne équipement';
    //     Text2014310_5929: TextConst ENU = 'SCRA category Code', FRA = 'Code Catégorie SCRA';
    //     Text2014310_5931: TextConst ENU = 'Cause Comment', FRA = 'Commentaire panne';
    //     Text2014310_5932: TextConst ENU = 'Remedy Code', FRA = 'Code solution';
    //     Text2014310_5936: TextConst ENU = 'Plant Maintenance No.', FRA = 'N° Maintenance usine';
    //     Text2014310_5968: TextConst ENU = 'Replaced Equipment No.', FRA = 'N° Equipement remplacé';
    //     PlantMaintSetup: Record "Plant Maintenance Setup";
    //     Text2014410: TextConst ENU = 'If you change %1, all existing sales charge lines will be deleted and new sales charge lines based on the new information on the header will be created.\\', FRA = 'Si vous modifiez l''enregistrement %1, toutes les lignes de frais vente existantes seront supprimées et de nouvelles lignes de frais vente seront créées.\\';
    //     Text2014412: TextConst ENU = 'You cannot use the %1 %2 because your identification is set up to process from %3 %4 only.', FRA = 'Vous ne pouvez pas utiliser le %1 %2 parce que votre identification est configurée pour traiter de %3 %4 seulement.';
    //     Text2014413: TextConst ENU = 'If you change %1, all existing will be updated and all sales charge lines will be deleted and new sales charge lines based on the new information on the header will be created.\\', FRA = 'Si vous changez %1, tous les existants seront mis à jour et toutes les lignes de frais de souscription seront supprimés et de nouvelles lignes de frais d''acquisition sur la base de nouvelles informations sur l''en-tête seront créés \\.';
    //     Text2014414: TextConst ENU = '%1 %2 is assigned to %3 %4 and your identification is not set up to process.\\', FRA = '%1 %2 est affectée à %3 %4 et votre identification ne soit pas mis en place pour traiter. \\';
    //     Text2014415: TextConst ENU = 'Do you want to continue?', FRA = 'Souhaitez-vous continuer?';
    //     Text2014416: TextConst ENU = 'The user has been interrupted the process to respect the warning.', FRA = 'L''utilisateur a interrompu le processus pour respecter l''alerte.';
    //     UserMgt: Codeunit "User Setup Management";
    //     RespCenter: Record "Responsibility Center";
    //     Text2029610: TextConst ENU = 'You are modifying a line that has linked charges. You need to recalculate these charges manually.', FRA = 'La ligne que vous modifiez a des frais annexes liés. Vous devez recalculer ces frais annexes manuellement.';
    //     blnSkipUpdateTimeSheet: Boolean;
    //     Text2029611: TextConst ENU = 'Timesheet is already approved and can''t be changed.', FRA = 'La feuille de temps a été déjas approuvée et ne peut pas être modifiée';
    //     Text2029612: TextConst ENU = 'Do you want to update the related timesheet?', FRA = 'Voulez-vous mettre à jour la feuille de temps ?';
    //     recFinXLSetup: Record "Finance XL Setup";
    // BC Upgrade KUMARS145 Drinkit Variables commented ... <<
}

