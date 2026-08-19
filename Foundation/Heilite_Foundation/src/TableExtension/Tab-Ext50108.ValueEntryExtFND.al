tableextension 50108 ValueEntryExtFND extends "Value Entry"
{
    // version NAVW110.0.00.16996,FINXL10.00,DITW110.00.11,NRQ247628,HEI.11
    //BC Upgrade PATHAA02- Keys commeneted-DrinkIT
    //******************************************************************
    //HEI.12 PATHAA02 01.04.26  #FDD-Unit Volume HL-Assemnly Orders [FDD PID-750, PID-826, PID-76, PID-801, FDD DtW 017, IBM GAP DTW 76]
    //# Added new Field -"Unit Volume HL", "Volume 1" [Base Qty*Unit Volume from Item] as DIT has not added this field in Value Entry table

    //HEI.13 PATHAA02 05.04.26 #FDD-COGS-[PID803,FDD-DTW-022,IBM GAP DTW54]
    //# Added new field "Invoiced Quantity HL"

    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Item Ledger Entry Type")
        {
            CaptionML = ENU = 'Item Ledger Entry Type', FRA = 'Type écriture comptable article';
            // OptionCaptionML = ENU = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output', FRA = 'Achat,Vente,Positif (ajust.),Négatif (ajust.),Transfert,Consommation,Production, ,Consommation d''assemblage,Résultat d''assemblage';
        }
        modify("Source No.")
        {

            //Unsupported feature: Change TableRelation on ""Source No."(Field 5)". Please convert manually.

            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Inventory Posting Group")
        {
            CaptionML = ENU = 'Inventory Posting Group', FRA = 'Groupe compta. stock';
        }
        modify("Source Posting Group")
        {

            //Unsupported feature: Change TableRelation on ""Source Posting Group"(Field 10)". Please convert manually.

            CaptionML = ENU = 'Source Posting Group', FRA = 'Groupe compta. origine';
        }
        modify("Item Ledger Entry No.")
        {
            CaptionML = ENU = 'Item Ledger Entry No.', FRA = 'N° écriture comptable article';
        }
        modify("Valued Quantity")
        {
            CaptionML = ENU = 'Valued Quantity', FRA = 'Quantité valorisée';
        }
        modify("Item Ledger Entry Quantity")
        {
            CaptionML = ENU = 'Item Ledger Entry Quantity', FRA = 'Quantité écriture comptable article';
        }
        modify("Invoiced Quantity")
        {
            CaptionML = ENU = 'Invoiced Quantity', FRA = 'Quantité facturée';
        }
        modify("Cost per Unit")
        {
            CaptionML = ENU = 'Cost per Unit', FRA = 'Coût par unité';
        }
        modify("Sales Amount (Actual)")
        {
            CaptionML = ENU = 'Sales Amount (Actual)', FRA = 'Montant vente (réel)';
        }
        modify("Salespers./Purch. Code")
        {

            //Unsupported feature: Change TableRelation on ""Salespers./Purch. Code"(Field 22)". Please convert manually.

            CaptionML = ENU = 'Salespers./Purch. Code', FRA = 'Code vendeur/acheteur';
        }
        modify("Discount Amount")
        {
            CaptionML = ENU = 'Discount Amount', FRA = 'Montant remise';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("Applies-to Entry")
        {
            CaptionML = ENU = 'Applies-to Entry', FRA = 'Ecriture lettrage';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 33)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 34)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Source Type")
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
            // OptionCaptionML = ENU = ' ,Customer,Vendor,Item', FRA = ' ,Client,Fournisseur,Article';
        }
        modify("Cost Amount (Actual)")
        {
            CaptionML = ENU = 'Cost Amount (Actual)', FRA = 'Coût total (réel)';
        }
        modify("Cost Posted to G/L")
        {
            CaptionML = ENU = 'Cost Posted to G/L', FRA = 'Coût validé en comptabilité';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Drop Shipment")
        {
            CaptionML = ENU = 'Drop Shipment', FRA = 'Livraison directe';
        }
        modify("Journal Batch Name")
        {
            CaptionML = ENU = 'Journal Batch Name', FRA = 'Nom feuille';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        }
        modify("Cost Amount (Actual) (ACY)")
        {
            CaptionML = ENU = 'Cost Amount (Actual) (ACY)', FRA = 'Coût total (réel) DR';
        }
        modify("Cost Posted to G/L (ACY)")
        {
            CaptionML = ENU = 'Cost Posted to G/L (ACY)', FRA = 'Coût validé en comptabilité DR';
        }
        modify("Cost per Unit (ACY)")
        {
            CaptionML = ENU = 'Cost per Unit (ACY)', FRA = 'Coût par unité DR';
        }
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            // OptionCaptionML = ENU = ' ,Sales Shipment,Sales Invoice,Sales Return Receipt,Sales Credit Memo,Purchase Receipt,Purchase Invoice,Purchase Return Shipment,Purchase Credit Memo,Transfer Shipment,Transfer Receipt,Service Shipment,Service Invoice,Service Credit Memo,Posted Assembly,,,,,Service Receipt,Service P.Invoice,Service P.Credit Memo', FRA = ' ,Expédition vente,Facture vente,Réception retour vente,Avoir vente,Réception achat,Facture achat,Expédition retour achat,Avoir achat,Expédition transfert,Réception transfert,Expédition service,Facture service,Avoir service,Assemblage validé,,,,,Réception service,Facture service achat,Avoir service achat';

            //Unsupported feature: Change OptionString on ""Document Type"(Field 79)". Please convert manually.


            //Unsupported feature: Change Description on ""Document Type"(Field 79)". Please convert manually.

        }
        modify("Document Line No.")
        {
            CaptionML = ENU = 'Document Line No.', FRA = 'N° ligne document';
        }
        modify("Order Type")
        {
            CaptionML = ENU = 'Order Type', FRA = 'Type de commande';
            // OptionCaptionML = ENU = ' ,Production,Transfer,Service,Assembly', FRA = ' ,Production,Transfert,Service,Assemblage';
        }
        modify("Order No.")
        {
            CaptionML = ENU = 'Order No.', FRA = 'N° commande';
        }
        modify("Order Line No.")
        {
            CaptionML = ENU = 'Order Line No.', FRA = 'N° ligne commande';
        }
        modify("Expected Cost")
        {
            CaptionML = ENU = 'Expected Cost', FRA = 'Coût prévu';
        }
        modify("Item Charge No.")
        {
            CaptionML = ENU = 'Item Charge No.', FRA = 'N° frais annexes';
        }
        modify("Valued By Average Cost")
        {
            CaptionML = ENU = 'Valued By Average Cost', FRA = 'Valorisé par coût moyen';
        }
        modify("Partial Revaluation")
        {
            CaptionML = ENU = 'Partial Revaluation', FRA = 'Réévaluation partielle';
        }
        modify(Inventoriable)
        {
            CaptionML = ENU = 'Inventoriable', FRA = 'Valorisable';
        }
        modify("Valuation Date")
        {
            CaptionML = ENU = 'Valuation Date', FRA = 'Date évaluation';
        }
        modify("Entry Type")
        {
            CaptionML = ENU = 'Entry Type', FRA = 'Type écriture';
            // OptionCaptionML = ENU = 'Direct Cost,Revaluation,Rounding,Indirect Cost,Variance', FRA = 'Coût direct,Réévaluation,Arrondi,Coût indirect,Écart';
        }
        modify("Variance Type")
        {
            CaptionML = ENU = 'Variance Type', FRA = 'Type écart';
            // OptionCaptionML = ENU = ' ,Purchase,Material,Capacity,Capacity Overhead,Manufacturing Overhead,Subcontracted', FRA = ' ,Achat,Matière,Opératoire,Frais généraux opératoires,Frais généraux matière,Sous-traitance';
        }
        modify("Purchase Amount (Actual)")
        {
            CaptionML = ENU = 'Purchase Amount (Actual)', FRA = 'Montant achat (réel)';
        }
        modify("Purchase Amount (Expected)")
        {
            CaptionML = ENU = 'Purchase Amount (Expected)', FRA = 'Montant achat (prévu)';
        }
        modify("Sales Amount (Expected)")
        {
            CaptionML = ENU = 'Sales Amount (Expected)', FRA = 'Montant vente (prévu)';
        }
        modify("Cost Amount (Expected)")
        {
            CaptionML = ENU = 'Cost Amount (Expected)', FRA = 'Coût total (prévu)';
        }
        modify("Cost Amount (Non-Invtbl.)")
        {
            CaptionML = ENU = 'Cost Amount (Non-Invtbl.)', FRA = 'Coût total (non incorp.)';
        }
        modify("Cost Amount (Expected) (ACY)")
        {
            CaptionML = ENU = 'Cost Amount (Expected) (ACY)', FRA = 'Montant coût (prévu) DR';
        }
        modify("Cost Amount (Non-Invtbl.)(ACY)")
        {
            CaptionML = ENU = 'Cost Amount (Non-Invtbl.)(ACY)', FRA = 'Coût total non incorp. DR';
        }
        modify("Expected Cost Posted to G/L")
        {
            CaptionML = ENU = 'Expected Cost Posted to G/L', FRA = 'Coût prévu validé en comptabilité';
        }
        modify("Exp. Cost Posted to G/L (ACY)")
        {
            CaptionML = ENU = 'Exp. Cost Posted to G/L (ACY)', FRA = 'Coût prévu validé en compta DR';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Job No.")
        {

            //Unsupported feature: Change TableRelation on ""Job No."(Field 1000)". Please convert manually.

            CaptionML = ENU = 'Job No.', FRA = 'N° projet';
        }
        modify("Job Task No.")
        {

            //Unsupported feature: Change TableRelation on ""Job Task No."(Field 1001)". Please convert manually.

            CaptionML = ENU = 'Job Task No.', FRA = 'N° tâche projet';
        }
        modify("Job Ledger Entry No.")
        {
            CaptionML = ENU = 'Job Ledger Entry No.', FRA = 'N° écriture comptable projet';
        }
        modify("Variant Code")
        {

            //Unsupported feature: Change TableRelation on ""Variant Code"(Field 5402)". Please convert manually.

            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify(Adjustment)
        {
            CaptionML = ENU = 'Adjustment', FRA = 'Ajustement';
        }
        modify("Average Cost Exception")
        {
            CaptionML = ENU = 'Average Cost Exception', FRA = 'Exception coût moyen';
        }
        modify("Capacity Ledger Entry No.")
        {
            CaptionML = ENU = 'Capacity Ledger Entry No.', FRA = 'N° écriture comptable capacité';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            // OptionCaptionML = ENU = 'Work Center,Machine Center, ,Resource', FRA = 'Centre de charge,Poste de charge, ,Ressource';
        }
        modify("No.")
        {

            //Unsupported feature: Change TableRelation on ""No."(Field 5834)". Please convert manually.

            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Return Reason Code")
        {
            CaptionML = ENU = 'Return Reason Code', FRA = 'Code motif retour';
        }
        field(50000; "Rev. Jnl. Error Log FND"; Boolean)
        {
            Caption = 'Rev. Jnl. Error Log';
            Description = 'HEI.11';
        }
        field(50001; "Journal Template Name FND"; Code[10])
        {
            Caption = 'Journal Template Name';
            Description = 'HEI.11';
        }
        field(50002; "Line No. FND"; Integer)
        {
            Caption = 'Line No.';
            Description = 'HEI.11';
        }
        field(50005; "RPM Solution FND"; Option)
        {
            Caption = 'RPM Solution';
            Description = 'HEI.02';
            Editable = false;
            OptionCaption = '" ,Deposit,Full-for-Empty with revenue impact (FFE with revenue),Full-for Empty without revenue impact (FFE w/o revenue)"';
            OptionMembers = " ",Deposit,"Full-for-Empty with revenue impact (FFE with revenue)","Full-for Empty without revenue impact (FFE w/o revenue)";
        }
        field(50006; "RPM Type FND"; Code[20])
        {
            caption = 'RPM Type';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = "Return Pack Material Type FND".Code;
        }
        field(50007; "Item Type FND"; Option)
        {
            Caption = 'Item Type';
            Description = 'HEI.02';
            Editable = false;
            OptionCaption = '" ,RPM Related,Product Related"';
            OptionMembers = " ","RPM Related","Product Related";
        }
        field(50008; "Cost Amount (Purchase) FND"; Decimal)
        {
            Caption = 'Cost Amount (Purchase)';
            Description = 'HEI.04';
            Editable = false;
        }
        //HEI.12>>
        field(50009; "Unit Volume HL FND"; Decimal)
        {
            Caption = 'Unit Volume HL';
            Description = 'HEI.12';
        }
        field(50010; "Volume 1 FND"; Decimal)
        {
            Caption = 'Volume 1';
            Description = 'HEI.12';
        }
        //HEI.12<<

        //HEI.13 >>
        field(50011; "Invoiced Quantity HL FND"; Decimal)
        {
            Caption = 'Invoiced Quantity HL';
            Description = 'HEI.13';
        }
        //HEI.13<<

        field(50060; "Source System Identifier FND"; Code[10])
        {
            Caption = 'Source System Identifier';
            Description = 'HEI.06';
            Editable = false;
            TableRelation = "Source Sys Identifier API FND";
        }
        field(50061; "Zone Code FND"; Code[10])
        {
            Caption = 'Zone Code';
            Description = 'HEI.07';
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"));
        }
        field(50062; "Bin Code FND"; Code[20])
        {
            Caption = 'Bin Code';
            Description = 'HEI.07';
            TableRelation = Bin.Code where("Location Code" = FIELD("Location Code"),
                                            "Zone Code" = FIELD("Zone Code FND"));
        }
        //BC Upgrade PATHAA02>>

        //#BCUP0-30 Fix -BC Upgrade KAIRAR01 start>>
        field(50070; "Sales Dep Amt (Actual) FND"; Decimal)
        {
            Caption = 'Sales Deposit Amount (Actual)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(50071; "Sales Tax Amount (Actual) FND"; Decimal)
        {
            Caption = 'Sales Tax Amount (Actual)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(50072; "Invoiced Qty. in HL FND"; Decimal)
        {
            Caption = 'Invoiced Quantity in HL';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        //#BCUP0-30 Fix -BC Upgrade KAIRAR01 end<<

        // field(2013610; "Item DDeposit Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Deposit Group Code',
        //                 FRA = 'Code groupe consigne article';
        //     Description = 'DITW15.00.00.01-.30';
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
        // field(2013623; "Src. Deposit Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Source Deposit Group Code',
        //                 FRA = 'Code origine groupe coût consigne';
        //     Description = 'DITW15.00.00.30';
        //     TableRelation = "Drink Deposit Group".Code where("Source Type" = FIELD("Source Type"));
        // }
        // field(2013640; "Sales Deposit Amount (Actual)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Sales Deposit Amount (Actual)',
        //                 FRA = 'Montant consigne vente (réel)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013641; "Sales Deposit Amount (Exp)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Sales Deposit Amount (Expected)',
        //                 FRA = 'Montant consigne vente (Prévu)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013650; "Purchase Deposit Amt. (Actual)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Purchases Deposit Amount (Actual)',
        //                 FRA = 'Montant consigne vente (Actuel)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013651; "Purchase Deposit Amt. (Exp)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Purchases Deposit Amount (Expected)',
        //                 FRA = 'Montant consigne vente (Prévu)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013652; "Deposit Amount (Actual)"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     Caption = 'Deposit Amount (Actual)';
        //     Description = 'DITW110.00.11 BL#14417';
        // }
        // field(2013653; "Deposit Amount Posted to GL"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     Caption = 'Deposit Amount Posted to GL';
        //     Description = 'DITW110.00.11 BL#14417';
        // }
        // field(2013654; "Deposit Amount (Expected)"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     Caption = 'Deposit Amount (Expected)';
        //     Description = 'DITW110.00.11 BL#14417';
        // }
        // field(2013655; "Expected Deposit Posted to G/L"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     Caption = 'Expected Deposit Posted to G/L';
        //     Description = 'DITW110.00.11 BL#14417';
        // }
        // field(2013660; "Extra Charge Type"; Option)
        // {
        //     CaptionML = ENU = 'Extra Charge Type',
        //                 FRA = 'Type frais extra';
        //     Description = 'DITW15.00.00.24';
        //     OptionCaptionML = ENU = ' ,Amount,Price %,Amount %,Fixed Amount,Volume /Unit,Weight,Cubage,Distance',
        //                       FRA = ' ,Montant,Prix %,Montant %,Montant Fixe,Volume /Unit,Poids,Cubage,Distance';
        //     OptionMembers = " ",Amount,"Price %","Amount %","Fixed Amount",VolumeHL,Weight,Cubage,Distance;
        // }
        // field(2013661; "Item Charge Value"; Decimal)
        // {
        //     AutoFormatExpression = GetAutoformatRoundingType('');
        //     AutoFormatType = 2;
        //     CaptionML = ENU = 'Item Charge Value',
        //                 FRA = 'Valeur frais annexes';
        //     Description = 'DITW15.00.00.32';
        // }
        // field(2013663; "Item Charge Incl. Price"; Boolean)
        // {
        //     CaptionML = ENU = 'Item Charge Incl. Price',
        //                 FRA = 'Frais annexe inclus prix';
        //     Description = 'DITW15.00.00.24';
        // }
        // field(2013667; "Item DTax Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Tax Group Code',
        //                 FRA = 'Code groupe taxe article';
        //     Description = 'DITW15.00.00.01-.30';
        //     TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Item));
        // }
        // field(2013668; "Tax Posted to G/L"; Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CaptionML = ENU = 'Tax Due Posted to G/L',
        //                 FRA = 'Taxe validée en compta.';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013669; "Expected Tax Posted to G/L"; Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CaptionML = ENU = 'Expected Tax Due Posted to G/L',
        //                 FRA = 'Taxe pr''vue validé en Compta.';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013670; "Sales Tax Amount (Actual)"; Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CaptionML = ENU = 'Sales Tax Amount (Actual)',
        //                 FRA = 'Montant taxe vente (Actuel)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013671; "Sales Tax Amount (Expected)"; Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CaptionML = ENU = 'Sales Tax Amount (Expected)',
        //                 FRA = 'Montant taxe vente (Prévu)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013680; "Purchase Tax Amount (Actual)"; Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CaptionML = ENU = 'Purchases Tax Amount (Actual)',
        //                 FRA = 'Montant taxe achat (Actuel)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013681; "Purchase Tax Amount (Expected)"; Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CaptionML = ENU = 'Purchases Tax Amount (Expected)',
        //                 FRA = 'Montant taxe achat (Prévu)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013692; "Internal Tax Amount (Actual)"; Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CaptionML = ENU = 'Internal Tax Amount (Actual)',
        //                 FRA = 'Montant interne taxe (réel)';
        //     Description = 'DITW15.00.00.24';
        // }
        // field(2013693; "Internal Tax Amount (Exp)"; Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CaptionML = ENU = 'Internal Tax Amount (Expected)',
        //                 FRA = 'Montant interne taxe (prévu)';
        //     Description = 'DITW15.00.00.24';
        // }
        // field(2013695; "Item Charge Type"; Option)
        // {
        //     CaptionML = ENU = 'Item Charge Type',
        //                 FRA = 'Type frais annexes';
        //     Description = 'DITW15.00.00.01';
        //     OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        // }
        // field(2013698; "Closed by Entry No."; Integer)
        // {
        //     CaptionML = ENU = 'Closed by Entry No.',
        //                 FRA = 'N° séquence lettrage final';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "G/L Entry";
        // }
        // field(2013699; "Closed by Document No."; Code[20])
        // {
        //     CaptionML = ENU = 'Closed by Document No.',
        //                 FRA = 'N° Document lettrage final';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = IF ("Closed by Entry No." = FILTER(<> 0)) "G/L Entry"."Document No." where("Entry No." = FIELD("Closed by Entry No."));
        // }
        // field(2013700; "Closed at Date"; Date)
        // {
        //     CaptionML = ENU = 'Closed at Date',
        //                 FRA = 'Date lettrage final';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013701; Closed; Boolean)
        // {
        //     CaptionML = ENU = 'Closed',
        //                 FRA = 'Clôturé';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013708; "Due Tax"; Boolean)
        // {
        //     CaptionML = ENU = 'Due Tax',
        //                 FRA = 'Taxe due';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013711; "Initial Entry Due Date"; Date)
        // {
        //     CaptionML = ENU = 'Initial Entry Due Date',
        //                 FRA = 'Date d''échéance écr. initiale';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013715; "Tax Formula"; Code[80])
        // {
        //     CaptionML = ENU = 'Tax Formula',
        //                 FRA = 'Formule taxe';
        //     Description = 'DITW15.00.00.34';
        // }
        // field(2013716; "Strength Spec. Code"; Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0, FIELDNO("Strength Spec. Code"));
        //     CaptionML = ENU = 'Strength Spec. Code',
        //                 FRA = 'Code contrainte spécification taxe';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" where(Type = CONST(Specification));
        // }
        // field(2013717; "Strength Spec. Value"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1, FIELDNO("Strength Spec. Value"));
        //     CaptionML = ENU = 'Strength Spec. Value',
        //                 FRA = 'Valeur contrainte spécification';
        //     Description = 'DITW19.00.08 BL#10443';
        // }
        // field(2013718; "Vol-Strength Spec. Code"; Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0, FIELDNO("Vol-Strength Spec. Code"));
        //     CaptionML = ENU = 'Vol-Strength Spec. Code',
        //                 FRA = 'Code spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" where(Type = CONST(Specification));
        // }
        // field(2013719; "Vol-Strength Spec. Value"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Vol-Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1, FIELDNO("Vol-Strength Spec. Value"));
        //     CaptionML = ENU = 'Vol-Strength Spec. Value',
        //                 FRA = 'Valeur spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        // }
        // field(2013722; "Duty Suspended"; Boolean)
        // {
        //     CaptionML = ENU = 'Duty Suspended',
        //                 FRA = 'Taxe en suspension';
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013733; "Tax Date"; Date)
        // {
        //     CaptionML = ENU = 'Tax Date',
        //                 FRA = 'Date taxe';
        //     Description = 'DITW15.00.00.39 #1363';
        // }
        // field(2013751; "Src. DTax Group Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Source Tax Group Code',
        //                 FRA = 'Code groupe taxe Source';
        //     Description = 'DITW15.00.00.30-.39 #1370,HEI.01';
        //     TableRelation = "Drink Tax Group".Code;
        // }
        // field(2013759; "Tax Spec. Filter"; Code[20])
        // {
        //     CaptionML = ENU = 'Tax Specification Filter',
        //                 FRA = 'Filtre Spécification taxe';
        //     Description = 'DITW19.00.08 BL#10443';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Tax Specification" where(Type = CONST(Specification));
        // }
        // field(2013767; "Unit Volume HL"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Unit Volume HL"));
        //     CaptionML = ENU = 'Unit Volume',
        //                 FRA = 'Volume unitaire';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013774; "Item DDisc. Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Discount Group',
        //                 FRA = 'Groupe remise article';
        //     Description = 'DITW15.00.00.01-.30';
        //     TableRelation = "Drink Discount Group".Code where("Source Type" = CONST(Item));
        // }
        // field(2013776; "Item DPromo. Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Promotion Group',
        //                 FRA = 'Groupe promotion article';
        //     Description = 'DITW15.00.00.01.-30';
        //     TableRelation = "Drink Promotion Group".Code where("Source Type" = CONST(Item));
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
        // field(2013783; "Discount Level Position"; Integer)
        // {
        //     CaptionML = ENU = 'Discount Level Position',
        //                 FRA = 'Position niveau de remise';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013786; "Valued Quantity in HL"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Valued Quantity in HL"));
        //     CaptionML = ENU = 'Valued Quantity',
        //                 FRA = 'Quantité valorisée';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013787; "Item Ledger Entry Quantity HL"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Item Ledger Entry Quantity HL"));
        //     CaptionML = ENU = 'Item Ledger Entry Quantity',
        //                 FRA = 'Quantité écriture article';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.23';
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
        // field(2013796; "Invoiced Quantity in HL"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Invoiced Quantity in HL"));
        //     CaptionML = ENU = 'Invoiced Quantity',
        //                 FRA = 'Quantité facturée';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.23';
        // }
        // field(2013803; "Allow VAT Calculation (Free)"; Boolean)
        // {
        //     CaptionML = ENU = 'Allow VAT Calculation (Free)',
        //                 FRA = 'Autoriser calcul TVA (Gratuit)';
        //     Description = 'DITW16.00.00.40 DIT-715 #172';
        // }
        // field(2013804; "Item DDisc. Group Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Discount Group Filter',
        //                 FRA = 'Filtre groupe remise article';
        //     Description = 'DITW16.00.00.42 DIT-715 #395';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Drink Discount Group".Code where("Source Type" = CONST(Item));
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
        //     Editable = false;
        //     TableRelation = "Free Reason Code";
        // }
        // field(2014113; "Tax Item No."; Code[20])
        // {
        //     CaptionML = ENU = 'Tax Tracking Item No.',
        //                 FRA = 'N° article traçable Taxe';
        //     Description = 'DITW15.00.00.38 #703';
        //     TableRelation = Item;
        // }
        // field(2014114; "Qty. per Unit of Measure"; Decimal)
        // {
        //     CaptionML = ENU = 'Qty. per Unit of Measure',
        //                 FRA = 'Quantité par unité';
        //     DecimalPlaces = 0 : 10;
        //     Description = 'DITW16.00.00.43 DIT-715 #519';
        // }
        // field(2014115; "Unit of Measure Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Unit of Measure Code',
        //                 FRA = 'Code unité';
        //     Description = 'DITW16.00.00.43 DIT-715 #519';
        //     TableRelation = IF ("Tax Item No." = FILTER('')) "Item Unit of Measure".Code where("Item No." = FIELD("Item No."))
        //     else IF ("Tax Item No." = FILTER(<> '')) "Item Unit of Measure".Code where("Item No." = FIELD("Tax Item No."));
        // }
        // field(2014265; "Product Tax Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Tax Product Code',
        //                 FRA = 'Code Produit taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Product";
        // }
        // field(2014316; "Drink Discount Relation"; Boolean)
        // {
        //     CalcFormula = Exist("Drink Discount Relation" where("Source Type" = CONST(Item),
        //                                                          "Source No." = FIELD("Item No."),
        //                                                          Code = FIELD("Item DDisc. Group Filter")));
        //     CaptionML = ENU = 'Drink Discount Relation',
        //                 FRA = 'Relation remise Drink';
        //     Description = 'DITW16.00.00.42 DIT-715 #395';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014409; "Item Ledger Entry Source Type"; Option)
        // {
        //     Caption = 'Item Ledger Entry Source Type';
        //     Description = 'DITW110.00.10 NRQ#17909';
        //     OptionCaption = '" ,Customer,Vendor,Item"';
        //     OptionMembers = " ",Customer,Vendor,Item;
        // }
        // field(2014410; "Item Ledger Entry Source No."; Code[20])
        // {
        //     CaptionML = ENU = 'Item Ledger Entry Source No.',
        //                 FRA = 'N° d''origine écriture article';
        //     Description = 'DITW17.00.02 DIT-770 #239 - DITW110.00.10 NRQ#17909';
        //     TableRelation = IF ("Item Ledger Entry Source Type" = CONST(Customer)) Customer
        //     else IF ("Item Ledger Entry Source Type" = CONST(Vendor)) Vendor
        //     else IF ("Item Ledger Entry Source Type" = CONST(Item)) Item;
        // }
        // field(2014411; "Valued Quantity (Expected)"; Decimal)
        // {
        //     CaptionML = ENU = 'Valued Quantity (Expected)',
        //                 FRA = 'Quantité valorisée (prévue)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DIT-770 #776';
        // }
        // field(2014412; "Scrap Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Scrap Code',
        //                 FRA = 'Code rebut';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = Scrap;
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
        //BC Upgrade PATHAA02<<- DrinkIT fields
    }
    keys
    {

        //Unsupported feature: PropertyChange on ""Item No.","Valuation Date","Location Code","Variant Code"(Key)". Please convert manually.


        //Unsupported feature: PropertyChange on ""Source Type","Source No.","Global Dimension 1 Code","Global Dimension 2 Code","Item No.","Posting Date","Entry Type",Adjustment(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""Item Ledger Entry No.","Entry Type"(Key)". Please convert manually.

        //BC Upgrade PATHAA02>>
        // key(Key20; "Item Ledger Entry No.", "Entry Type", "Item Charge Type")
        // {
        //     MaintainSIFTIndex = false;
        //     SumIndexFields = "Invoiced Quantity", "Sales Amount (Expected)", "Sales Amount (Actual)", "Cost Amount (Expected)", "Cost Amount (Actual)", "Cost Amount (Non-Invtbl.)", "Cost Amount (Expected) (ACY)", "Cost Amount (Actual) (ACY)", "Cost Amount (Non-Invtbl.)(ACY)", "Purchase Amount (Actual)", "Purchase Amount (Expected)", "Discount Amount";
        // }
        // key(Key21; "Source Type", "Source No.", "Item No.", "Posting Date", "Entry Type", Adjustment, "Item Charge Type")
        // {
        //     SumIndexFields = "Discount Amount", "Cost Amount (Non-Invtbl.)", "Cost Amount (Actual)", "Cost Amount (Expected)", "Sales Amount (Actual)", "Sales Amount (Expected)", "Invoiced Quantity", "Valued Quantity", "Sales Tax Amount (Actual)", "Purchase Tax Amount (Actual)", "Sales Deposit Amount (Actual)", "Purchase Deposit Amt. (Actual)";
        // }
        // key(Key22; "Source Type", Closed, "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "Posting Date", "Item Charge No.", "Due Tax", "Return Reason Code")
        // {
        //     SumIndexFields = "Sales Tax Amount (Actual)", "Sales Tax Amount (Expected)", "Purchase Tax Amount (Actual)", "Purchase Tax Amount (Expected)", "Sales Deposit Amount (Actual)", "Sales Deposit Amount (Exp)", "Purchase Deposit Amt. (Actual)", "Purchase Deposit Amt. (Exp)";
        // }
        // key(Key23; "Item Charge No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Item Charge Type", "Location Code", "Global Dimension 1 Code", "Global Dimension 2 Code")
        // {
        //     SumIndexFields = "Invoiced Quantity", "Sales Tax Amount (Actual)", "Sales Tax Amount (Expected)", "Purchase Tax Amount (Actual)", "Purchase Tax Amount (Expected)", "Sales Deposit Amount (Actual)", "Sales Deposit Amount (Exp)", "Purchase Deposit Amt. (Actual)", "Purchase Deposit Amt. (Exp)";
        // }
        // key(Key24; "Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Item Charge No.", "Item Charge Type", "Location Code", "Global Dimension 1 Code", "Global Dimension 2 Code")
        // {
        //     SumIndexFields = "Invoiced Quantity in HL", "Sales Tax Amount (Actual)", "Sales Tax Amount (Expected)", "Purchase Tax Amount (Actual)", "Purchase Tax Amount (Expected)", "Sales Deposit Amount (Actual)", "Sales Deposit Amount (Exp)", "Purchase Deposit Amt. (Actual)", "Purchase Deposit Amt. (Exp)";
        // }
        // key(Key25; "Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Item Charge No.", "Item Charge Type", "Location Code", "Global Dimension 2 Code", "Global Dimension 1 Code")
        // {
        //     SumIndexFields = "Internal Tax Amount (Actual)", "Internal Tax Amount (Exp)", "Cost Amount (Actual)", "Cost Amount (Expected)";
        // }
        // key(Key26; "Empty Goods Item No.", "Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Location Code", "Source Type", "Source No.")
        // {
        //     SumIndexFields = "Valued Quantity", "Sales Deposit Amount (Actual)", "Purchase Deposit Amt. (Actual)";
        // }
        // key(Key27; "Item Ledger Entry No.", "Item Charge Type", "Item Charge No.")
        // {
        //     SumIndexFields = "Sales Amount (Actual)", "Sales Amount (Expected)", "Discount Amount";
        // }
        // key(Key28; "Item Ledger Entry No.", "Entry Type", "Item Charge No.", "Item Charge Type", "Item DDisc. Group Code")
        // {
        //     SumIndexFields = "Item Ledger Entry Quantity", "Item Ledger Entry Quantity HL", "Invoiced Quantity", "Invoiced Quantity in HL", "Internal Tax Amount (Actual)", "Internal Tax Amount (Exp)", "Discount Amount";
        // }
        // key(Key29; "Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge Type", "Item Charge No.", "Location Code", "Variant Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Empty Goods Item No.", "Item Ledger Entry Source No.")
        // {
        //     SumIndexFields = "Sales Deposit Amount (Actual)", "Sales Tax Amount (Actual)", "Purchase Deposit Amt. (Actual)", "Purchase Tax Amount (Actual)", "Discount Amount";
        // }
        // key(Key30; "Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge Type", "Item Charge No.", "Location Code", "Variant Code", "Global Dimension 2 Code", "Global Dimension 1 Code", "Empty Goods Item No.", "Item Ledger Entry Source No.")
        // {
        //     SumIndexFields = "Sales Deposit Amount (Exp)", "Sales Tax Amount (Expected)", "Purchase Deposit Amt. (Exp)", "Purchase Tax Amount (Expected)";
        // }
        // key(Key31; "Source Type", "Source No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Item No.", "Posting Date", "Initial Entry Due Date", "Entry Type", Adjustment, "Item Charge Type", "Item Charge No.")
        // {
        //     SumIndexFields = "Sales Deposit Amount (Actual)", "Purchase Deposit Amt. (Actual)", "Sales Tax Amount (Actual)", "Purchase Tax Amount (Actual)";
        // }
        // key(Key32; "Source Type", "Source No.", "Empty Goods Item No.", "Posting Date", "Entry Type", "Item Charge Type", Adjustment, "Initial Entry Due Date")
        // {
        //     SumIndexFields = "Discount Amount", "Cost Amount (Non-Invtbl.)", "Cost Amount (Actual)", "Cost Amount (Expected)", "Sales Amount (Actual)", "Sales Amount (Expected)", "Invoiced Quantity", "Valued Quantity", "Sales Tax Amount (Actual)", "Purchase Tax Amount (Actual)", "Sales Deposit Amount (Actual)", "Purchase Deposit Amt. (Actual)";
        // }
        //BC Upgrade PATHAA02<<
        key(Key33; "Document No.", "Posting Date")
        {
        }

        //BC Upgrade PATHAA02>>
        // key(Key34; "Item Ledger Entry No.", "Entry Type", "Document Line No.", "Item Charge Type", "Item Charge No.", "Tax Item No.")
        // {
        //     SumIndexFields = "Sales Deposit Amount (Actual)", "Sales Deposit Amount (Exp)", "Purchase Deposit Amt. (Actual)", "Purchase Deposit Amt. (Exp)", "Sales Tax Amount (Actual)", "Sales Tax Amount (Expected)", "Purchase Tax Amount (Actual)", "Purchase Tax Amount (Expected)", "Discount Amount", "Invoiced Quantity";
        // }
        // key(Key35; "Posting Date", "Due Tax", "Duty Suspended", "Location Code", "Item Charge Type", "Item No.")
        // {
        // }
        // key(Key36; "Item No.", "Document No.", "Posting Date", "Location Code", "Item Charge Type", "Due Tax", "Item Ledger Entry No.")
        // {
        // }
        // key(Key37; "Item No.", "Location Code", "Document No.", "Posting Date", "Item Charge Type", "Due Tax", "Item Ledger Entry No.")
        // {
        // }
        // key(Key38; "Tax Item No.", "Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Location Code", "Source Type", "Source No.")
        // {
        //     SumIndexFields = "Valued Quantity", "Sales Tax Amount (Actual)", "Purchase Tax Amount (Actual)";
        // }
        // key(Key39; "Source Type", "Source No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Item No.", "Posting Date", "Empty Goods Item No.", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Location Code", "Variant Code", "Item Charge Type", "Item Charge No.", "Tax Item No.")
        // {
        //     SumIndexFields = "Discount Amount";
        // }
        // key(Key40; "Source Type", "Source No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Item Ledger Entry Type", "Posting Date", "Item DDisc. Group Code", "Free Item")
        // {
        //     SumIndexFields = "Invoiced Quantity", "Invoiced Quantity in HL";
        // }
        // key(Key41; "Item Ledger Entry Type", "Item Charge Type", "Location Code", "Posting Date", "Item DTax Group Code", "Item Charge No.")
        // {
        //     SumIndexFields = "Item Ledger Entry Quantity", "Valued Quantity";
        // }
        // key(Key42; "Item Ledger Entry No.", "Tax Item No.", "Item No.", "Item Charge Type", "Due Tax")
        // {
        //     SumIndexFields = "Valued Quantity", "Valued Quantity in HL", "Item Ledger Entry Quantity", "Item Ledger Entry Quantity HL", "Invoiced Quantity", "Invoiced Quantity in HL", "Unit Volume HL", "Vol-Strength Spec. Value";
        // }
        // key(Key43; "Item Ledger Entry Source No.", "Posting Date", "Empty Goods Item No.", "Global Dimension 1 Code", "Global Dimension 2 Code")
        // {
        //     SumIndexFields = "Sales Deposit Amount (Actual)";
        // }
        // key(Key44; "Item Ledger Entry Type", "Source No.", "Posting Date", "Global Dimension 1 Code", "Global Dimension 2 Code", "Item DDeposit Group Code", "Free Item")
        // {
        //     SumIndexFields = "Invoiced Quantity in HL";
        // }
        //BC Upgrade PATHAA02<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        xItemLedgEntry: Record "Item Ledger Entry";

    var
        ValueEntry: Record "Value Entry";
        GoThroughChain: Boolean;

    var
        InvtSetup: Record "Inventory Setup";
        ContractExpiringDate: Date;
        ContractStartingDate: Date;
}

