tableextension 50215 SalesLineArchiveExtFND extends "Sales Line Archive"
{
    // version NAVW110.0.00.16585,FINXL10.00,DITW110.00.11,HEI.02
    //   DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    //                                  Added fields
    //                                    2034647 "Drink Tax Group Code"
    //                                    2034675 Item Charge Type
    //   DITW15.00.00.01 DDR 02/01/2008 rename field
    //                                    2034647 Item DTax Group Code
    //   DITW15.00.00.01 DDR 03/01/2008 Change optionstring field "Item Charge Type"
    //   DITW15.00.00.01 DDR 04/01/2008 added field
    //                                    2013610 Item DDeposit Group Code
    //                                    2013611 Empty Goods Item No.
    //                                    2013612 Item Charge Quantity per
    //   DITW15.00.00.01 DDR 22/01/2008 Added Drink-It Discount & Promotions Item Charges functionnalities
    //                                  Change optionstring field "Item Charge Type"
    //                                  Change optionstring field "Extra Charge Type"
    //                                  Added fields
    //                                    2014410 Collapse
    //                                    2013773 Customer DDisc. Group Code
    //                                    2013774 Item DDisc. Group Code
    //                                    2013775 Customer DPromo. Group Code
    //                                    2013776 Item DPromo. Group Code
    //                                    2013767 Unit Volume HL
    //   DITW15.00.00.01 DDR 13/03/2008 Rename Caption field "Unit Volume HL"
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.20 DDR 11/06/2008 Certification rules
    //   DITW15.00.00.23 DDR 28/07/2008 Change Caption & CaptionClass properties
    //                                    field "Unit Volume HL"
    //                                  Added function GetUomCaptionClass()
    //   DITW15.00.00.25 DDR 24/10/2008 Renamed OptionStringML (VolumeHL -> Volume /Unit) for field "Extra Charge Type"
    //                                  Added new option ",Weight,Cubage,Distance" into field "Extra Charge Type"
    //   DITW15.00.00.33 DDR 08/05/2009 Added fields
    //                                    2013708 Due Tax
    //                                    2013715 Tax Formula
    //                                    2013722 Duty Suspended
    //                                    2013726 Company Tax Registration No.
    //                                    2013727 AAD No. Series
    //                                    2013728 AAD No.
    //                                    2013729 Tariff No.
    //                                    2013747 Tax Spec. HL;
    //                                    2013748 Tax Spec. Degrees Plato
    //                                    2013778 Opposite Qty. Sign
    //                                    2013779 Using Qty. (Base)
    //                                    2013780 Free Quantity
    //                                    2013781 Multiple Quantity
    //                                    2013782 Maximum Free Quantity
    //                                    2013785 Periodic Disc.-Promo Entry No.
    //                                    2013810 Periodic Delayed Entry No.
    //                                    2013811 Delayed Sequence No.
    //                                    2014064 Shipping Charge Per
    //                                    2014079 Cubage
    //                                    2014080 Weight
    //                                    2014087 Distance
    //                                    2014444 Last Price Calculated Date
    //   DITW15.00.00.34 DDR 12/06/2009 Added option 'Price Item' optionstring for "Extra Charge Type" field
    //   DITW15.00.00.35 DDR 24/06/2009 Added fields
    //                                    2013824 Gen. Prod. Posting Free Group
    //                                    2013825 Free Item Posting Type
    //                                    2013826 Free Item
    //                        27/07/2009 Added fields
    //                                    2013827 Free Calculation Type
    //                                    2013828 Include Free Qty. in Minimum
    //                       13/10/2009 issue 722 Updated Filters - TableRelation property field "Empty Goods Item No. Filter"
    //                       26/10/2009 issue 924 Rename captions + optioncaptions
    //                                    "Free Item Posting Type" -> "Calculate Price on Free"
    //                                      ' ,Price,Amount' -> 'Full Amount,Price 0,Discount 100%'
    //                                    "Free Calculation Type" -> Calculate on Free
    //                                      'None,Discount 100%,All' -> 'None,Discount 100%,Full Amount'
    //   DITW15.00.00.37 DDR 04/02/2010 issue 1033 Added fields
    //                                               2013797 Disc.Promo. Order Calculated
    //   DITW15.00.00.38 DDR 23/07/2010 issue 1194 Added function GetCaptionClassVar()
    //                       10/08/2010 issue 1217 Removed fields "Tax Spec. HL","Tax Spec. Degrees Plato"
    //                       13/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                    Added fields
    //                                      2014271 Tax Warehouse Reference
    //                       17/12/2010 issue 703 Added fields
    //                                              2014113 Tax Item No.
    //                                            Added functions GetTrackingItemNo(),LookupItemNo()
    //                       01/02/2011 issue 941 Modified OptionCaption property field2013825 "Free Item Posting Type"
    //   DITW15.00.00.39 DDR 28/10/2011 issue 1457 Modified many ML captions
    //   DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added fields
    //                                      2013803 Allow VAT Calculation (Free)

    //   FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //   DITW18.00.07 DDR 18/01/2016 DIT-770 #822 New functionality "Mix & Match Promotion"
    //                                            Added 'List Item' optionstring field2013777 "Item Charge Calculate Per"
    //   DITW18.00.07 MVN 24/02/2016 DIT-770 #1397 Added all missing DIT Fields
    //   DITW18.00.07 VSC 24/02/2016 DIT-770 #1703 Added field "Original Quantity"
    //   DITW18.00.07 AKH 29/04/2016 DIT-770 #1346 Added fields 2014085 "Item Delivery Type"
    //                                                          2014086 "Delivery Time (sec.)"
    //   DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    //   DITW19.00.08 AKH 06/10/2016 BL#11069 (DIT-770 #2144) Mix & Match Promotions per Order
    //                                                        Added new optionstring "List Order" to field 2013777 "Item Charge Calculate per"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    //   FINXL10.00 AKH 02/03/2017 NRQ#25695: Added field 2029614 "Rec. Charge Attach. Line No."
    //   DITW110.00.09 AKH 12/04/2017 NRQ#24104 Merge from XL NRQ#25695
    //   DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    //   DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Added new fields 2014067..2014072
    //   DITW110.00.11 SFI 30/08/2017 BL#14417 New field 2013637 Deposit Value
    //   DITW110.00.11 AKH 02/11/2017 NRQ#43605 Added new field 2035394 "Show Item charge on Invoice"
    //   HEI.01 FDD-SLSGAP001 IBM NASTAA02 19.09.2017 # MDM Customer Card
    //     # Increased "Customer DTax Group Code" field length from 10 to 20 characters
    //   HEI.02 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //     # New Field created: 50016 - "TIN No."
    //   DITW113.00.15 DDR 04/10/2019 NRQ#10495 Rename Loyalty 'Cost' -> 'Amount' (all fields)
    //                                          Add fields
    //                                            2014523 Loyalty Amount (LCY)
    //                                            2014524 Loyalty Amount
    //   DITW110.00.11 MSF 20/12/2017 NRQ#14143  New Option Added to Field   2014504 Calculate Minimum
    //                                                                               Minimum Quantity
    //   CHG2104608: DITW111.00.13 ISL 18/12/2018 NRQ#96024 Deleted field 2014461 "Prod. BOM Version Code"
    //   HEI.03 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //     # New Field created 50024 - CAD Amount
    //   HEI.04 CHG2109621 HT2170 IBM GAVANM01 10.06.2021 - Posting Setup for Sales Tax (Timbre), transport, free products
    //     # Added field: 50025 - Timbre applied

    //   BC Upgrade KUMARS145 Table Ext
    //   BC Upgrade KUMARS145 Drinkit fields commented.

    fields
    {
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order', FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
        }
        modify("Sell-to Customer No.")
        {
            CaptionML = ENU = 'Sell-to Customer No.', FRA = 'N° donneur d''ordre';
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
            //OptionCaptionML = ENU = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)', FRA = ' ,Compte général,Article,Ressource,Immobilisation,Frais annexes';
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
        modify("Quantity Disc. Code")
        {
            CaptionML = ENU = 'Quantity Disc. Code', FRA = 'Code remise quantité';
        }
        modify("Shipment Date")
        {
            CaptionML = ENU = 'Shipment Date', FRA = 'Date d''expédition';
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
        modify("Price Group Code")
        {
            CaptionML = ENU = 'Price Group Code', FRA = 'Code tarif';
        }
        modify("Allow Quantity Disc.")
        {
            CaptionML = ENU = 'Allow Quantity Disc.', FRA = 'Remise quantité autorisée';
        }
        modify("Job No.")
        {
            CaptionML = ENU = 'Job No.', FRA = 'N° projet';
        }
        modify("Work Type Code")
        {
            CaptionML = ENU = 'Work Type Code', FRA = 'Code type travail';
        }
        modify("Cust./Item Disc. %")
        {
            CaptionML = ENU = 'Cust./Item Disc. %', FRA = '% remise client/art.';
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
            CaptionML = ENU = 'Shipment No.', FRA = 'N° livraison';
        }
        modify("Shipment Line No.")
        {
            CaptionML = ENU = 'Shipment Line No.', FRA = 'N° ligne livraison';
        }
        modify("Profit %")
        {
            CaptionML = ENU = 'Profit %', FRA = '% marge sur vente';
        }
        modify("Bill-to Customer No.")
        {
            CaptionML = ENU = 'Bill-to Customer No.', FRA = 'N° client facturé';
        }
        modify("Inv. Discount Amount")
        {
            CaptionML = ENU = 'Inv. Discount Amount', FRA = 'Montant remise facture';
        }
        modify("Purchase Order No.")
        {
            CaptionML = ENU = 'Purchase Order No.', FRA = 'N° commande achat';
        }
        modify("Purch. Order Line No.")
        {
            CaptionML = ENU = 'Purch. Order Line No.', FRA = 'N° ligne commande achat';
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
            // OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
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
        modify(Reserve)
        {
            CaptionML = ENU = 'Reserve', FRA = 'Réserver';
            // OptionCaptionML = ENU = 'Never,Optional,Always', FRA = 'Jamais,Manuel,Toujours';
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
            // OptionCaptionML = ENU = ' ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No.', FRA = ' ,Compte général,Article,,,Frais annexes,Référence externe,N° article commun';
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
            // OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
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
        modify("FA Posting Date")
        {
            CaptionML = ENU = 'FA Posting Date', FRA = 'Date compta. immo.';
        }
        modify("Depreciation Book Code")
        {
            CaptionML = ENU = 'Depreciation Book Code', FRA = 'Code loi d''amortissement';
        }
        modify("Depr. until FA Posting Date")
        {
            CaptionML = ENU = 'Depr. until FA Posting Date', FRA = 'Amort. jusqu''à date compta.';
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
        modify("Out-of-Stock Substitution")
        {
            CaptionML = ENU = 'Out-of-Stock Substitution', FRA = 'Substitution sur rupture';
        }
        modify("Substitution Available")
        {
            CaptionML = ENU = 'Substitution Available', FRA = 'Substitut disponible';
        }
        modify("Originally Ordered No.")
        {
            CaptionML = ENU = 'Originally Ordered No.', FRA = 'N° article substitué';
        }
        modify("Originally Ordered Var. Code")
        {
            CaptionML = ENU = 'Originally Ordered Var. Code', FRA = 'Code variante substitué';
        }
        // modify("Reference No.")
        // {
        //     CaptionML = ENU = 'Reference No.', FRA = 'Référence externe';
        // }
        // modify("Unit of Measure (Cross Ref.)")
        // {
        //     CaptionML = ENU = 'Unit of Measure (Cross Ref.)', FRA = 'Unité référence externe';
        // }
        // modify("Cross-Reference Type")
        // {
        //     CaptionML = ENU = 'Cross-Reference Type', FRA = 'Type référence externe';
        //     OptionCaptionML = ENU = ' ,Customer,Vendor,Bar Code', FRA = ' ,Client,Fournisseur,Code barre';
        // }
        // modify("Cross-Reference Type No.")
        // {
        //     CaptionML = ENU = 'Cross-Reference Type No.', FRA = 'N° type référence externe';
        // }
        // BC Upgrade KUMARS145 Fields Removed..<<
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
        // BC Upgrade KUMARS145 Fields Removed..>>
        // modify("Product Group Code")
        // {
        //     CaptionML = ENU = 'Product Group Code', FRA = 'Code groupe produits';
        // }
        // BC Upgrade KUMARS145 Fields Removed..<<
        modify("Special Order")
        {
            CaptionML = ENU = 'Special Order', FRA = 'Commande spéciale';
        }
        modify("Special Order Purchase No.")
        {
            CaptionML = ENU = 'Special Order Purchase No.', FRA = 'N° achat cde spéciale';
        }
        modify("Special Order Purch. Line No.")
        {
            CaptionML = ENU = 'Special Order Purch. Line No.', FRA = 'N° ligne achat cde spéciale';
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
        modify("Outbound Whse. Handling Time")
        {
            CaptionML = ENU = 'Outbound Whse. Handling Time', FRA = 'Délai désenlogement';
        }
        modify("Planned Delivery Date")
        {
            CaptionML = ENU = 'Planned Delivery Date', FRA = 'Date livraison planifiée';
        }
        modify("Planned Shipment Date")
        {
            CaptionML = ENU = 'Planned Shipment Date', FRA = 'Date d''expédition planifiée';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("Shipping Agent Service Code")
        {
            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
        }
        modify("Allow Item Charge Assignment")
        {
            CaptionML = ENU = 'Allow Item Charge Assignment', FRA = 'Autoriser affectation frais annexes';
        }
        modify("Return Qty. to Receive")
        {
            CaptionML = ENU = 'Return Qty. to Receive', FRA = 'Qté retour à recevoir';
        }
        modify("Return Qty. to Receive (Base)")
        {
            CaptionML = ENU = 'Return Qty. to Receive (Base)', FRA = 'Qté retour à recevoir (base)';
        }
        modify("Return Qty. Rcd. Not Invd.")
        {
            CaptionML = ENU = 'Return Qty. Rcd. Not Invd.', FRA = 'Qté retour reçue non facturée';
        }
        modify("Ret. Qty. Rcd. Not Invd.(Base)")
        {
            CaptionML = ENU = 'Ret. Qty. Rcd. Not Invd.(Base)', FRA = 'Qté ret. reçue non facturée (base)';
        }
        modify("Return Amt. Rcd. Not Invd.")
        {
            CaptionML = ENU = 'Return Amt. Rcd. Not Invd.', FRA = 'Montant ret. reçu non facturé';
        }
        modify("Ret. Amt. Rcd. Not Invd. (LCY)")
        {
            CaptionML = ENU = 'Ret. Amt. Rcd. Not Invd. (LCY)', FRA = 'Montant ret. reçu non facturé DS';
        }
        modify("Return Qty. Received")
        {
            CaptionML = ENU = 'Return Qty. Received', FRA = 'Qté retour reçue';
        }
        modify("Return Qty. Received (Base)")
        {
            CaptionML = ENU = 'Return Qty. Received (Base)', FRA = 'Qté retour reçue (base)';
        }
        modify("Appl.-from Item Entry")
        {
            CaptionML = ENU = 'Appl.-from Item Entry', FRA = 'Écriture article à lettrer';
        }
        modify("Service Contract No.")
        {
            CaptionML = ENU = 'Service Contract No.', FRA = 'N° contrat de service';
        }
        modify("Service Order No.")
        {
            CaptionML = ENU = 'Service Order No.', FRA = 'N° commande service';
        }
        modify("Service Item No.")
        {
            CaptionML = ENU = 'Service Item No.', FRA = 'N° article de service';
        }
        modify("Appl.-to Service Entry")
        {
            CaptionML = ENU = 'Appl.-to Service Entry', FRA = 'Ecr. service à lettrer';
        }
        modify("Service Item Line No.")
        {
            CaptionML = ENU = 'Service Item Line No.', FRA = 'N° ligne article de service';
        }
        modify("Serv. Price Adjmt. Gr. Code")
        {
            CaptionML = ENU = 'Serv. Price Adjmt. Gr. Code', FRA = 'Code groupe ajust. prix serv.';
        }
        modify("BOM Item No.")
        {
            CaptionML = ENU = 'BOM Item No.', FRA = 'N° article nomenclature';
        }
        modify("Return Receipt No.")
        {
            CaptionML = ENU = 'Return Receipt No.', FRA = 'N° réception retour';
        }
        modify("Return Receipt Line No.")
        {
            CaptionML = ENU = 'Return Receipt Line No.', FRA = 'N° ligne réception retour';
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
        field(50016; "TIN No. FND"; Text[20])
        {
            Caption = 'TIN No.';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = "TIN by Location FND"."TIN No.";
            ValidateTableRelation = false;
        }
        field(50024; "CAD Amount FND"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'CAD Amount',
                        FRA = 'CAD Montant';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Editable = false;
        }
        field(50025; "Timbre applied FND"; Boolean)
        {
            Caption = 'Timbre applied';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        //BC UPGRADE KUMARR78 FDD-MTC-008 >> Adding Field with New ID
        field(50094; "Show Item charge on Inv. FND"; Option)
        {
            Caption = 'Show Item charge on Invoice';
            OptionCaption = ' ,Under item line,Include in item price,Order total';
            OptionMembers = " ","Under item line","Include in item price","Order total";
        }
        //BC UPGRADE KUMARR78 FDD-MTC-008 >> Adding Field with New ID
        // BC Upgrade KUMARS145 Drinkit Fields commented..>>
        // field(2013610; "Item DDeposit Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Deposit Group Code',
        //                 FRA = 'Code groupe consigne article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code WHERE("Source Type" = CONST(Item));
        // }
        // field(2013611; "Empty Goods Item No."; Code[20])
        // {
        //     CaptionML = ENU = 'Empty Goods Item No.',
        //                 FRA = 'N° article vidange';
        //     Description = 'DITW15.00.00.01-.35';
        //     TableRelation = Item WHERE("Empty Good" = CONST(true));
        // }
        // field(2013612; "Item Charge Quantity per"; Decimal)
        // {
        //     CaptionML = ENU = 'Item Charge Quantity per',
        //                 FRA = 'Quantité frais annexes par';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.01';
        //     MinValue = 0;
        // }
        // field(2013613; "Empty Goods Item No. Filter"; Code[20])
        // {
        //     CaptionML = ENU = 'Empty Goods Item No. Filter',
        //                 FRA = 'Filtre article vidange n°';
        //     Description = 'DITW17.00.01';
        //     FieldClass = FlowFilter;
        //     TableRelation = Item;
        // }
        // field(2013614; "Item Charge Type Filter"; Option)
        // {
        //     CaptionML = ENU = 'Item Charge Type Filter',
        //                 FRA = 'Filtre type frais article';
        //     Description = 'DITW17.00.01';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost";
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
        //     OptionCaptionML = ENU = ' ,Amount,Price %,Amount %,Fixed Amount,Volume /Unit,Weight,Cubage,Distance,Sales Price',
        //                       FRA = ' ,Montant,Prix %,Montant %,Montant Fixe,Volume /Unit,Poids,Cubage,Distance,Prix vente';
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
        // field(2013666; "Customer DTax Group Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Customer Tax Group Code',
        //                 FRA = 'Code groupe taxe client';
        //     Description = 'DITW17.10.03 DIT-770 623,HEI.01';
        //     TableRelation = "Drink Tax Group".Code WHERE("Source Type" = CONST(Customer));
        // }
        // field(2013667; "Item DTax Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Tax Group Code',
        //                 FRA = 'Code groupe taxe article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Tax Group".Code WHERE("Source Type" = CONST(Item));
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
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013715; "Tax Formula"; Code[80])
        // {
        //     CaptionML = ENU = 'Tax Formula',
        //                 FRA = 'Formule taxe';
        //     Description = 'DITW15.00.00.33';
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
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013727; "AAD No. Series"; Code[10])
        // {
        //     CaptionML = ENU = 'AAD No. Series',
        //                 FRA = 'Souches de n° DAA';
        //     Description = 'DITW15.00.00.33';
        //     TableRelation = "No. Series";
        // }
        // field(2013728; "AAD No."; Code[20])
        // {
        //     CaptionML = ENU = 'AAD No.',
        //                 FRA = 'N° DAA';
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013729; "Tariff No."; Code[10])
        // {
        //     CaptionML = ENU = 'Tariff No.',
        //                 FRA = 'Nomenclature produits';
        //     Description = 'DITW15.00.00.33';
        //     TableRelation = "Tariff Number";
        // }
        // field(2013731; "Applies-to AAD Trck. Entry No."; Integer)
        // {
        //     CaptionML = ENU = 'Applies-to Correction AAD Trck. Entry No.',
        //                 FRA = 'N° Ecriture correction suivi DAA lettrage';
        //     Description = 'DITW15.00.00.39 #1369';
        //     TableRelation = "AAD Tracking Entry"."Entry No." WHERE("Entry Type" = CONST(Outbound),
        //                                                             "Source Type" = CONST(Customer),
        //                                                             "Source No." = FIELD("Sell-to Customer No."));

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
        // field(2013760; "Unit Volume Sales Price"; Option)
        // {
        //     CaptionML = ENU = 'Unit Volume Sales Price',
        //                 FRA = 'Volume Unitaire Prix de Vente';
        //     Description = 'DITW17.00.02 DIT-770 #147';
        //     Editable = false;
        //     OptionCaptionML = ENU = 'No,Yes',
        //                       FRA = 'Non,Oui';
        //     OptionMembers = No,Yes;
        // }
        // field(2013767; "Unit Volume HL"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Unit Volume HL"));
        //     CaptionML = ENU = 'Unit Volume',
        //                 FRA = 'Volume unitaire';
        //     Description = 'DITW15.00.00.01';
        //     MinValue = 0;
        // }
        // field(2013768; "Allow Price Dit Discount"; Boolean)
        // {
        //     CaptionML = ENU = 'Special Price (Dit Discount)',
        //                 FRA = 'Prix special (Remise DIT)';
        //     Description = 'DITW17.10.05 DIT-770 #695';
        // }
        // field(2013773; "Customer DDisc. Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Customer Discount Group',
        //                 FRA = 'Groupe remise client';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Discount Group".Code WHERE("Source Type" = CONST(Customer));
        // }
        // field(2013774; "Item DDisc. Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Discount Group',
        //                 FRA = 'Groupe remise article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Discount Group".Code WHERE("Source Type" = CONST(Item));
        // }
        // field(2013775; "Customer DPromo. Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Customer Promotion Group',
        //                 FRA = 'Groupe promotion client';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Promotion Group".Code WHERE("Source Type" = CONST(Customer));
        // }
        // field(2013776; "Item DPromo. Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Promotion Group',
        //                 FRA = 'Groupe promotion article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Promotion Group".Code WHERE("Source Type" = CONST(Item));
        // }
        // field(2013777; "Item Charge Calculate per"; Option)
        // {
        //     CaptionML = ENU = 'Item Charge Calculate per',
        //                 FRA = 'Frais annexe calcul par';
        //     Description = 'DITW15.00.00.01 - DITW19.00.08 BL#11069';
        //     OptionCaptionML = ENU = 'Item,Order,Period,Delayed Order,List Item,List Order',
        //                       FRA = 'Article,Order,Périodique,Commande retardée,Liste Article,Liste Commande';
        //     OptionMembers = Item,"Order",Period,DelayOrder,ListItem,ListOrder;
        // }
        // field(2013778; "Opposite Qty. Sign"; Boolean)
        // {
        //     CaptionML = ENU = 'Opposite Qty. Sign',
        //                 FRA = 'Signe quantité opposé';
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013779; "Using Qty. (Base)"; Boolean)
        // {
        //     CaptionML = ENU = 'Using Qty. (Base)',
        //                 FRA = 'Utilisation quantité (Base)';
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013780; "Free Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Free Quantity',
        //                 FRA = 'Quantité gratuite';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.33';
        //     MinValue = 0;
        // }
        // field(2013781; "Multiple Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Multiple Quantity',
        //                 FRA = 'Quantité multiple';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.33';
        //     MinValue = 0;
        // }
        // field(2013782; "Maximum Free Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Maximum Free Quantity',
        //                 FRA = 'Quantité maximum gratuite';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.33';
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
        //     Description = 'DITW15.00.00.33';
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
        // field(2013810; "Periodic Delayed Entry No."; Integer)
        // {
        //     CaptionML = ENU = 'Periodic Delayed Entry No.',
        //                 FRA = 'N° écriture périod. retardée';
        //     Description = 'DITW15.00.00.33';
        //     TableRelation = "Sales Discount.-Promo. Entry"."Entry No.";
        // }
        // field(2013811; "Delayed Sequence No."; Integer)
        // {
        //     CaptionML = ENU = 'Delayed Sequence No.',
        //                 FRA = 'N° séquence retardé';
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013812; "Delayed Sequence No. Filter"; Integer)
        // {
        //     CaptionML = ENU = 'Delayed Sequence No.',
        //                 FRA = 'N° séquence retardé';
        //     Description = 'DITW17.00.01';
        //     FieldClass = FlowFilter;
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
        // field(2013914; "Quantity (Base) History"; Decimal)
        // {
        //     CalcFormula = - Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
        //                                                            "Entry Type" = CONST(Sale),
        //                                                            "Source Type" = CONST(Customer),
        //                                                            "Source No." = FIELD("Sell-to Customer No."),
        //                                                            "Posting Date" = FIELD("Date Filter")));
        //     CaptionML = ENU = 'Quantity (Base) History',
        //                 FRA = 'Historique Quantité (base)';
        //     Description = 'DITW15.00.00.39 RBE 26/04/2011 #1230';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013915; "Average Qty. (Base) History"; Decimal)
        // {
        //     CalcFormula = - Average("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
        //                                                                "Entry Type" = CONST(Sale),
        //                                                                "Source Type" = CONST(Customer),
        //                                                                "Source No." = FIELD("Sell-to Customer No."),
        //                                                                "Posting Date" = FIELD("Date Filter")));
        //     CaptionML = ENU = 'Average Qty. (Base) History',
        //                 FRA = 'Historique Quantité moyenne (base)';
        //     Description = 'DITW15.00.00.39 RBE 26/04/2011 #1230';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013916; "Date Filter"; Date)
        // {
        //     CaptionML = ENU = 'Date Filter',
        //                 FRA = 'Filtre date';
        //     Description = 'DITW15.00.00.39 RBE 26/04/2011 #1230';
        //     FieldClass = FlowFilter;
        // }
        // field(2013917; "Sales History Calculation"; DateFormula)
        // {
        //     CaptionML = ENU = 'Sales History Calculation',
        //                 FRA = 'Calcul Historique ventes';
        //     Description = 'DITW15.00.00.39 RBE 26/04/2011 #1230';
        // }
        // field(2014060; Route; Code[20])
        // {
        //     CaptionML = ENU = 'Route',
        //                 FRA = 'Itinéraire';
        //     Description = 'DITW17.00.02 DIT-770 #159';
        //     Editable = false;
        //     TableRelation = Route;
        // }
        // field(2014061; Status; Option)
        // {
        //     CaptionML = ENU = 'Status',
        //                 FRA = 'Statut';
        //     Description = 'DITW17.00.02 DIT-770 #159';
        //     Editable = false;
        //     OptionCaptionML = ENU = 'Open,Released,Pending Approval,Pending Prepayment',
        //                       FRA = 'Ouvert,Lancé,Approbation suspendue,Acompte suspendu';
        //     OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        // }
        // field(2014062; "Shipment Status"; Option)
        // {
        //     CaptionML = ENU = 'Shipment Status',
        //                 FRA = 'Statut expédition';
        //     Description = 'DITW17.00.02 DIT-770 #159';
        //     Editable = false;
        //     OptionCaptionML = ENU = 'Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice',
        //                       FRA = 'Ouvert,Prélèvement imprimé,Affecté,Prélevé,Expédié,Retour terminée,Facturée';
        //     OptionMembers = Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;
        // }
        // field(2014063; "Truck Zone"; Option)
        // {
        //     CaptionML = ENU = 'Truck Zone',
        //                 FRA = 'Zone de camion';
        //     Description = 'DITW17.00.02 DIT-770 #159';
        //     Editable = false;
        //     OptionCaptionML = ENU = ' ,Right,Left',
        //                       FRA = ' ,Droite,Gauche';
        //     OptionMembers = " ",Right,Left;
        // }
        // field(2014064; "Shipping Charge Per"; Option)
        // {
        //     CaptionML = ENU = 'Shipping Charge Per',
        //                 FRA = 'Frais transport par';
        //     Description = 'DITW15.00.00.33';
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
        // field(2014067; "Backorder Type"; Option)
        // {
        //     Caption = 'Backorder Type';
        //     Description = 'DITW110.00.10 BL#15657';
        //     OptionCaption = '" ,Backorder,No Backorder"';
        //     OptionMembers = " ",Backorder,"No Backorder";
        // }
        // field(2014071; "Original Sales Order No."; Code[20])
        // {
        //     Caption = 'Original Sales Order No.';
        //     Description = 'DITW110.00.10 BL#15657';
        // }
        // field(2014072; "Original Sales Order Line No."; Integer)
        // {
        //     Caption = 'Original Sales Order Line No.';
        //     Description = 'DITW110.00.10 BL#15657';
        // }
        // field(2014079; Cubage; Decimal)
        // {
        //     CaptionML = ENU = 'Volume (Cubage)',
        //                 FRA = 'Volume (cubage)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2014080; Weight; Decimal)
        // {
        //     CaptionML = ENU = 'Weight',
        //                 FRA = 'Poids';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2014081; "HL Cubage"; Decimal)
        // {
        //     CaptionML = ENU = 'Volume (Cubage)',
        //                 FRA = 'Volume (cubage)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW17.00.02 DIT-770 #189';
        // }
        // field(2014082; "Eq. UOM Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Eq. UOM Quantity',
        //                 FRA = 'Quantité équiv. unité mesure';
        //     Description = 'DITW17.00.02 DIT-770 #189';
        // }
        // field(2014085; "Item Delivery Type"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Delivery Type',
        //                 FRA = 'Type de Livraison Article';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     TableRelation = "Delivery Type".Code WHERE(Type = CONST(Item));
        // }
        // field(2014086; "Delivery Time (sec.)"; Decimal)
        // {
        //     CaptionML = ENU = 'Delivery Time (sec.)',
        //                 FRA = 'Temps de Livraison (Sec.)';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     MinValue = 0;
        // }
        // field(2014087; Distance; Decimal)
        // {
        //     CaptionML = ENU = 'Distance',
        //                 FRA = 'Distance';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.33';
        //     MinValue = 0;
        // }
        // field(2014094; "Physical Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Physical Location Group Code',
        //                 FRA = 'Code groupe magasin réel';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Physical Location Group" WHERE(Code = FIELD("Phys. Location Table Filter"));
        // }
        // field(2014096; "Picking Type"; Option)
        // {
        //     CaptionML = ENU = 'Picking Type',
        //                 FRA = 'Type de prélèvement';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        //     OptionCaptionML = ENU = ' ,Order,Combined',
        //                       FRA = ' ,Commande,Regroupée';
        //     OptionMembers = " ","Order",Combined;
        // }
        // field(2014097; "Picklist Printed (date/time)"; DateTime)
        // {
        //     CaptionML = ENU = 'Picklist Printed (date/time)',
        //                 FRA = 'Prélèvements entrepôt imprimé (date/heure)';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        // }
        // field(2014103; "Whse. Shipment No. (Open)"; Code[20])
        // {
        //     CalcFormula = Lookup("Warehouse Shipment Line"."No." WHERE("Source Type" = CONST(37),
        //                                                                 "Source Subtype" = FIELD("Document Type"),
        //                                                                 "Source No." = FIELD("Document No."),
        //                                                                 "Source Line No." = FIELD("Line No.")));
        //     CaptionML = ENU = 'Whse. Shipment No. (Open)',
        //                 FRA = 'N° expédition magasin (Ouvert)';
        //     Description = 'DITW15.00.00.39 #1399';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     TableRelation = "Warehouse Shipment Header";
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
        //         lrSalesLine: Record "Sales Line";
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
        // field(2014287; "Cancellation Reason Type"; Option)
        // {
        //     CaptionML = ENU = 'Cancellation Reason Type',
        //                 FRA = 'Type motif d''annulation';
        //     Description = 'DITW16.00.00.43 DIT-715 #720';
        //     OptionCaptionML = ENU = ' ,Typing Error,Commercial Transaction Interrupt,Duplicate eAAD,State conflict',
        //                       FRA = ' ,Erreur de frappe,Interruption transaction commerciale,Double eAAD,Conflit administration';
        //     OptionMembers = " ",TypingError,TransactInterrupt,DuplicAAD,StateConflict;

        //     trigger OnValidate();
        //     var
        //         EMCS810OutMgt: Codeunit "EMCS EDI-IE810 Outbox";
        //         SalesShptLineCancel: Record "Sales Shipment Line";
        //         SalesLineCancel: Record "Sales Line";
        //     begin
        //     end;
        // }
        // field(2014292; "Cancellation Reason Comment"; Boolean)
        // {
        //     CalcFormula = Exist("EMCS Comment Line" WHERE("Table ID" = CONST(37),
        //                                                    "Document Type" = CONST(1),
        //                                                    "Document No." = FIELD("Document No."),
        //                                                    "Document Line No." = FIELD("Line No."),
        //                                                    "Field ID" = CONST(2014287)));
        //     CaptionML = ENU = 'Cancellation Reason Comment',
        //                 FRA = 'Commentaire motif d''annulation';
        //     Description = 'DITW16.00.00.43 DIT-715 #720';
        //     Editable = false;
        //     FieldClass = FlowField;
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
        // field(2014362; "Ret. Receipt Date Calculation"; DateFormula)
        // {
        //     CaptionML = ENU = 'Return Receipt Date Calculation',
        //                 FRA = 'Calcul Date de retour réception';
        //     Description = 'DIT-715 #247';
        // }
        // field(2014367; "Event Doc. No."; Code[20])
        // {
        //     CaptionML = ENU = 'Event Doc. No.',
        //                 FRA = 'N° document Evénement';
        //     Description = 'DITW17.10.05 DIT-770 #779';
        //     Editable = false;
        //     TableRelation = "Event Header"."No." WHERE("Document Type" = FILTER(Event));
        // }
        // field(2014368; "Event Doc. Line No."; Integer)
        // {
        //     CaptionML = ENU = 'Event Doc. Line No.',
        //                 FRA = 'N° Line Evénement';
        //     Description = 'DITW17.10.05 DIT-770 #779';
        //     Editable = false;
        //     TableRelation = "Event Line"."Line No." WHERE("Document Type" = FILTER(Event),
        //                                                    "Document No." = FIELD("Event Doc. No."));
        // }
        // field(2014410; Collapse; Boolean)
        // {
        //     CaptionML = ENU = 'Collapse',
        //                 FRA = 'Réduire';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2014411; "Calculated Unit Price"; Boolean)
        // {
        //     CaptionML = ENU = 'Calculated Unit Price',
        //                 FRA = 'Calculer Prix Unitaire';
        //     Description = 'DITW16.00.00.43';
        // }
        // field(2014412; "Order No."; Code[20])
        // {
        //     CaptionML = ENU = 'Order No.',
        //                 FRA = 'N° commande';
        //     Description = 'DITW17.00.02 DIT-770 #235';
        // }
        // field(2014413; "Order Line No."; Integer)
        // {
        //     CaptionML = ENU = 'Order Line No.',
        //                 FRA = 'N° ligne commande';
        //     Description = 'DITW17.00.02 DIT-770 #235';
        // }
        // field(2014414; "Goods Value"; Boolean)
        // {
        //     CaptionML = ENU = 'Goods Value',
        //                 FRA = 'Valeur des marchandises';
        //     Description = 'DITW17.00.02 DIT-770 #235';
        // }
        // field(2014415; "Item Charge Qty. per Uom"; Decimal)
        // {
        //     CaptionML = ENU = 'Item Charge Qty. per Unit of Measure',
        //                 FRA = 'Qté frais annexe par unité de mesure';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.43 DIT-715 #882';
        //     InitValue = 1;
        // }
        // field(2014416; "Manual Item Charge"; Boolean)
        // {
        //     CaptionML = ENU = 'Manual Item Charge',
        //                 FRA = 'Frais annexe manuel';
        //     Description = 'DITW17.10.03 DIT-770 #570';
        // }
        // field(2014442; "Manual Unit Price"; Boolean)
        // {
        //     CaptionML = ENU = 'Manual Unit Price',
        //                 FRA = 'Prix unitaire manuel';
        //     Description = 'DITW16.00.00.43 DDR DIT-715 #605';
        // }
        // field(2014444; "Last Price Calculated Date"; Date)
        // {
        //     CaptionML = ENU = 'Last Price Calculated Date',
        //                 FRA = 'Dernière date prix calculé';
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2014457; "Collapse Totaling"; Decimal)
        // {
        //     CalcFormula = Sum("Sales Line"."Line Amount" WHERE("Document Type" = FIELD("Document Type"),
        //                                                         "Document No." = FIELD("Document No."),
        //                                                         "Attached to Line No." = FIELD("Line No.")));
        //     CaptionML = ENU = 'Collapse Totaling',
        //                 FRA = 'Réduire Totalisation';
        //     Description = 'DITW16.00.00.37 TEMP TEST';
        //     Editable = false;
        //     FieldClass = FlowField;
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
        //     TableRelation = IF ("Production BOM No." = FILTER(<> '')) "Production BOM Line"."Line No." WHERE("Production BOM No." = FIELD("Production BOM No."))
        //     ELSE IF ("Production BOM No." = CONST('')) "BOM Component"."Line No." WHERE("Parent Item No." = FIELD("BOM Item No."));
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
        //     Description = 'DITW16.00.00.43 DIT-715 #720';
        // }
        // field(2014478; "Commercial Seal ID"; Text[35])
        // {
        //     CaptionML = ENU = 'Commercial Seal ID',
        //                 FRA = 'ID sceau commerciale';
        //     Description = 'DITW16.00.00.43 DIT-715 #720';
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
        //     Description = 'DITW18.00.06 DIT-770 #1190';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Responsibility Center";
        // }
        // field(2014498; "Phys. Location Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Phys. Location Table Filter',
        //                 FRA = 'Filtre groupe magasin réel (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1190';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014499; "Location Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Location Table Filter',
        //                 FRA = 'Filtre Magasin (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1190';
        //     FieldClass = FlowFilter;
        //     TableRelation = Location;
        // }
        // field(2014500; "Has Item Charge"; Boolean)
        // {
        //     CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"),
        //                                             "Document No." = FIELD("Document No."),
        //                                             "Attached to Line No." = FIELD("Line No.")));
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
        // field(2014511; "Allow Loyalty"; Boolean)
        // {
        //     CaptionML = ENU = 'Allow Loyalty',
        //                 FRA = 'Autoriser Fidélité';
        //     Description = 'DITW16.00.00.40 DIT715 #243';
        // }
        // field(2014513; "Loyalty Unit Point"; Decimal)
        // {
        //     CaptionML = ENU = 'Loyalty Unit Point',
        //                 FRA = 'Loyalty Point unitaire';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.40 DIT715 #243';
        // }
        // field(2014514; "Loyalty Points Qty. (Base)"; Decimal)
        // {
        //     CaptionML = ENU = 'Loyalty Points (Base)',
        //                 FRA = 'Loyalty Points (base)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.40 DIT715 #243';
        // }
        // field(2014515; "Loyalty Outstd. Pts Qty (Base)"; Decimal)
        // {
        //     CaptionML = ENU = 'Outstanding Loyalty Points (Base)',
        //                 FRA = 'Loyalty Points ouvert (base)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.40 DIT715 #243';
        //     Editable = false;
        // }
        // field(2014516; "Loyalty Unit Amount (LCY)"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     CaptionML = ENU = 'Loyalty Unit Amount (LCY)',
        //                 FRA = 'CoËÇôt unitaire FidËÇÜlitËÇÜ DS';
        //     Description = 'DITW16.00.00.40 DIT715 #243';

        //     trigger OnValidate();
        //     var
        //         Currency2: Record Currency;
        //     begin
        //     end;
        // }
        // field(2014517; "Loyalty Unit Amount"; Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 2;
        //     CaptionML = ENU = 'Loyalty Unit Amount',
        //                 FRA = 'CoËÇôt unitaire FidËÇÜlitËÇÜ';
        //     Description = 'DITW16.00.00.40 DIT715 #243';
        // }
        // field(2014518; "Loyalty Outstanding Amount"; Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Outstanding  Loyalty Amount',
        //                 FRA = 'FidËÇÜlitËÇÜ CoËÇôt en commande';
        //     Description = 'DITW16.00.00.40 DIT715 #243';
        //     Editable = false;

        //     trigger OnValidate();
        //     var
        //         Currency2: Record Currency;
        //     begin
        //     end;
        // }
        // field(2014519; "Loyalty Outstd. Amount (LCY)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Outstanding  Loyalty Cost Amount (LCY)',
        //                 FRA = 'FidËÇÜlitËÇÜ CoËÇôt en commande DS';
        //     Description = 'DITW16.00.00.40 DIT715 #243';
        //     Editable = false;
        // }
        // field(2014520; "Loyalty Convert to Free Item"; Boolean)
        // {
        //     CaptionML = ENU = 'Automatic Set Free Item',
        //                 FRA = 'DËÇÜfinir comme Article gratuit';
        //     Description = 'DIT-770 #868';
        // }
        // field(2014521; "Loyalty Point Type"; Option)
        // {
        //     CaptionML = ENU = 'Loyalty Point Type',
        //                 FRA = 'Type Point de fidelisation';
        //     Description = 'DITW17.10.05 DIT-770 #185';
        //     OptionCaptionML = ENU = ' ,Exchange,Gain',
        //                       FRA = ' ,Change,Gain';
        //     OptionMembers = " ",Exchange,Gain;
        // }
        // field(2014522; "Loyalty Cost Type"; Option)
        // {
        //     CaptionML = ENU = 'Loyalty Amount Type',
        //                 FRA = 'Type Point de FidËÇÜlisation';
        //     Description = 'DITW17.10.05 DIT-770 #185';
        //     OptionCaptionML = ENU = ' ,Exchange,Gain',
        //                       FRA = ' ,Change,Gain';
        //     OptionMembers = " ",Exchange,Gain;
        // }
        // field(2014523; "Loyalty Amount (LCY)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     Caption = 'Loyalty Amount (LCY)';
        //     Description = 'DITW113.00.15 #10495';
        // }
        // field(2014524; "Loyalty Amount"; Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     Caption = 'Loyalty Amount';
        //     Description = 'DITW113.00.15 #10495';
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
        // field(2029614; "Recycle Chrg. Attach. Line No."; Integer)
        // {
        //     CaptionML = ENU = 'Recycle Chrg. Attach. Line No.',
        //                 FRA = 'Recyclage annexe';
        //     Description = 'NRQ 25694';
        //     Editable = false;
        //     TableRelation = "Sales Line Archive"."Line No." WHERE("Document Type" = FIELD("Document Type"),
        //                                                            "Document No." = FIELD("Document No."));
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
        //     TableRelation = IF ("Contract Type" = CONST(Service)) "Contract Group".Code WHERE("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
        //     ELSE IF ("Contract Type" = CONST(Financial)) "Financial Contract Group".Code WHERE("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034920; "Created by Contract Batch Job"; Boolean)
        // {
        //     CaptionML = ENU = 'Created by Contract Batch Job',
        //                 FRA = 'Créé par traîtement périodique du contrat';
        //     Description = 'DITW16.00.00.43 DIT715 #619';
        // }
        // field(2035390; "Shelf No."; Code[10])
        // {
        //     CaptionML = ENU = 'Shelf No.',
        //                 FRA = 'N° emplacement';
        //     Description = 'DITW17.00.02 DIT-770 #235';
        // }
        // field(2035391; "External Document No."; Code[35])
        // {
        //     CalcFormula = Lookup("Sales Header"."External Document No." WHERE("Document Type" = FIELD("Document Type"),
        //                                                                        "No." = FIELD("Document No.")));
        //     CaptionML = ENU = 'External Document No.',
        //                 FRA = 'N° document externe';
        //     Description = 'DITW17.00.02 DIT-770 #180';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035392; "Sell-to Customer Name"; Text[50])
        // {
        //     CalcFormula = Lookup("Sales Header"."Sell-to Customer Name" WHERE("Document Type" = FIELD("Document Type"),
        //                                                                        "No." = FIELD("Document No.")));
        //     CaptionML = ENU = 'Sell-to Customer Name',
        //                 FRA = 'Nom du donneur d''ordre';
        //     Description = 'DITW17.00.02 DIT-770 #180';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035393; "Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Contract Type',
        //                 FRA = 'Type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392 - DIT-770 #690 -DIT-770 #1368';
        //     OptionCaptionML = ENU = ' ,Service,Financial',
        //                       FRA = ' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }
        // field(2035394; "Show Item charge on Invoice"; Option)
        // {
        //     Caption = 'Show Item charge on Invoice';
        //     Description = 'DITW110.00.11 NRQ#43605';
        //     OptionCaption = '" ,Under item line,Include in item price,Order total"';
        //     OptionMembers = " ","Under item line","Include in item price","Order total";
        // }
        // BC Upgrade KUMARS145 Fields Removed..<<

    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.

}

