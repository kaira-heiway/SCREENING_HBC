tableextension 50053 ItemLedgerEntryExtFND extends "Item Ledger Entry"
{
    // HEI.01 FDD PRDGAP038 IBM COSTES02 07.08.2017 # Added field Quality Status

    // HEI.02 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    //   # New fields
    // HEI.03 FDD-BA-PRDGAP01 IBM POSTOI01 12.07.2018
    //   # new field 50008 Project Code Code 20
    //   HEI.04 FDD-BA-SLSGAP01 IBM NASTAA02 11.12.2018 # Counterpoint Interface
    //   # New Fields created: 50009 - Interface Code
    //                         50012 - CP Vendor Invoice No.

    // HEI.05 CHG2025677 IBM KUMARN15 09.08.2019
    //   # Added key Item No.,Quality Status,Lot No.
    // HEI.06 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New field: 10800 Shipment Method Code
    // HEI.07 CHG2012342 IBM GAVANM01 19/11/2019 # Your Reference added
    // HEI.08 BRD HB398 IBM BULIMC01 14/02/2020 #new field created: 50013 - "Value Entry Source No."
    // HEI.10 CHG2065153 IBM KUMARN15 23.06.2020
    //   # Added field "Source System Identifier"
    // HEI.11 HT1615 BULIMC01 IBM 16.09.2020#new field added: 50061 - "Zone Code"
    // HEI.12 CHG2131272 IBM.LS      14.12.2021
    //   # Created New Field: 50025 - Reporting Type
    // HEI.13 CHG2156228 IBM PATHAA02 26.04.2022 Permissions added for ILE-RIMD in Properties
    //  # CU50153 Job has issue with the Permission on ILE-Modify
    // HEI.14 CHG2228022 IBM-PATHAA02/VORGIM01 14.11.2023
    //  # Optimization for Adjust Cost-Item Entries, Remove Table Locking

    //Bc Upgrade YADAVM09 Drink it field commented - shipment method code.
    //*******************************************************************
    //HEI.15 PATHAA02 01.04.26  #FDD-Unit Volume HL-Assemnly Orders [FDD PID-750, PID-826, PID-76, PID-801, FDD DtW 017, IBM GAP DTW 76]
    //# Added new Field -"Unit Volume HL"  

    //BC Upgrade Kamnay01  Created this table  extension to add the field  for "Your Reference" . This field is required for FDD-DTW 006
    // BC Upgrade PATELP08>>
    // Changed Ext name from "ItemLedgerEntryExtDTW" to "ItemLedgerEntryExtDTWFND"
    // BC Upgrade PATEP08<<


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
        modify("Entry Type")
        {
            CaptionML = ENU = 'Entry Type', FRA = 'Type écriture';
            //OptionCaptionML = ENU = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output', FRA = 'Achat,Vente,Positif (ajust.),Négatif (ajust.),Transfert,Consommation,Production, ,Consommation d''assemblage,Résultat d''assemblage';
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
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Remaining Quantity")
        {
            CaptionML = ENU = 'Remaining Quantity', FRA = 'Quantité restante';
        }
        modify("Invoiced Quantity")
        {
            CaptionML = ENU = 'Invoiced Quantity', FRA = 'Quantité facturée';
        }
        modify("Applies-to Entry")
        {
            CaptionML = ENU = 'Applies-to Entry', FRA = 'Ecriture lettrage';
        }
        modify(Open)
        {
            CaptionML = ENU = 'Open', FRA = 'Ouvert';
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
        modify(Positive)
        {
            CaptionML = ENU = 'Positive', FRA = 'Positif';
        }
        modify("Source Type")
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
            // OptionCaptionML = ENU = ' ,Customer,Vendor,Item', FRA = ' ,Client,Fournisseur,Article';
        }
        modify("Drop Shipment")
        {
            CaptionML = ENU = 'Drop Shipment', FRA = 'Livraison directe';
        }
        modify("Transaction Type")
        {
            CaptionML = ENU = 'Transaction Type', FRA = 'Nature transaction';
        }
        modify("Transport Method")
        {
            CaptionML = ENU = 'Transport Method', FRA = 'Mode de transport';
        }
        modify("Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Country/Region Code"(Field 52)". Please convert manually.

            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify("Entry/Exit Point")
        {
            CaptionML = ENU = 'Entry/Exit Point', FRA = 'Pays destination/provenance';
        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        }
        modify("Area")
        {
            CaptionML = ENU = 'Area', FRA = 'Dépt destination/provenance';
        }
        modify("Transaction Specification")
        {
            CaptionML = ENU = 'Transaction Specification', FRA = 'Régime';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Reserved Quantity")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Quantity"(Field 70)". Please convert manually.

            CaptionML = ENU = 'Reserved Quantity', FRA = 'Quantité réservée';
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
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Assemble to Order")
        {
            CaptionML = ENU = 'Assemble to Order', FRA = 'Assemblage à la commande';
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
        modify("Job Purchase")
        {
            CaptionML = ENU = 'Job Purchase', FRA = 'Achat projet';
        }
        modify("Variant Code")
        {

            //Unsupported feature: Change TableRelation on ""Variant Code"(Field 5402)". Please convert manually.

            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';

            //Unsupported feature: Change DecimalPlaces on ""Qty. per Unit of Measure"(Field 5404)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {

            //Unsupported feature: Change TableRelation on ""Unit of Measure Code"(Field 5407)". Please convert manually.

            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Derived from Blanket Order")
        {
            CaptionML = ENU = 'Derived from Blanket Order', FRA = 'Issue de commande ouverte';
        }
        //BC Upgrade KAMNAY01 -Field is Deprecated >>>>
        // modify("Cross-Reference No.")
        // {
        //     CaptionML = ENU='Cross-Reference No.',FRA='Référence externe';
        // }
        //BC Upgrade KAMNAY01 -Field is Deprecated >>
        modify("Originally Ordered No.")
        {
            CaptionML = ENU = 'Originally Ordered No.', FRA = 'N° article substitué';
        }
        modify("Originally Ordered Var. Code")
        {

            //Unsupported feature: Change TableRelation on ""Originally Ordered Var. Code"(Field 5702)". Please convert manually.

            CaptionML = ENU = 'Originally Ordered Var. Code', FRA = 'Code variante substitué';
        }
        modify("Out-of-Stock Substitution")
        {
            CaptionML = ENU = 'Out-of-Stock Substitution', FRA = 'Substitution sur rupture';
        }
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
            CaptionML = ENU = 'Purchasing Code', FRA = 'Code achat';
        }
        //BC Upgrade KAMNAY01 -Field is Deprecated >>>>
        // modify("Product Group Code")
        // {

        //     //Unsupported feature: Change TableRelation on ""Product Group Code"(Field 5707)". Please convert manually.

        //     CaptionML = ENU='Product Group Code',FRA='Code groupe produits';
        // }
        //BC Upgrade KAMNAY01 -Field is Deprecated >>>>
        modify("Completely Invoiced")
        {
            CaptionML = ENU = 'Completely Invoiced', FRA = 'Entièrement facturé';
        }
        modify("Last Invoice Date")
        {
            CaptionML = ENU = 'Last Invoice Date', FRA = 'Dernière date facturation';
        }
        modify("Applied Entry to Adjust")
        {
            CaptionML = ENU = 'Applied Entry to Adjust', FRA = 'Ecriture lettrée à ajuster';
        }
        modify("Cost Amount (Expected)")
        {

            //Unsupported feature: Change CalcFormula on ""Cost Amount (Expected)"(Field 5803)". Please convert manually.

            CaptionML = ENU = 'Cost Amount (Expected)', FRA = 'Coût total (prévu)';
        }
        modify("Cost Amount (Actual)")
        {

            //Unsupported feature: Change CalcFormula on ""Cost Amount (Actual)"(Field 5804)". Please convert manually.

            CaptionML = ENU = 'Cost Amount (Actual)', FRA = 'Coût total (réel)';
        }
        modify("Cost Amount (Non-Invtbl.)")
        {

            //Unsupported feature: Change CalcFormula on ""Cost Amount (Non-Invtbl.)"(Field 5805)". Please convert manually.

            CaptionML = ENU = 'Cost Amount (Non-Invtbl.)', FRA = 'Coût total (non incorp.)';
        }
        modify("Cost Amount (Expected) (ACY)")
        {

            //Unsupported feature: Change CalcFormula on ""Cost Amount (Expected) (ACY)"(Field 5806)". Please convert manually.

            CaptionML = ENU = 'Cost Amount (Expected) (ACY)', FRA = 'Montant coût (prévu) DR';
        }
        modify("Cost Amount (Actual) (ACY)")
        {

            //Unsupported feature: Change CalcFormula on ""Cost Amount (Actual) (ACY)"(Field 5807)". Please convert manually.

            CaptionML = ENU = 'Cost Amount (Actual) (ACY)', FRA = 'Coût total (réel) DR';
        }
        modify("Cost Amount (Non-Invtbl.)(ACY)")
        {

            //Unsupported feature: Change CalcFormula on ""Cost Amount (Non-Invtbl.)(ACY)"(Field 5808)". Please convert manually.

            CaptionML = ENU = 'Cost Amount (Non-Invtbl.)(ACY)', FRA = 'Coût total non incorp. DR';
        }
        modify("Purchase Amount (Expected)")
        {

            //Unsupported feature: Change CalcFormula on ""Purchase Amount (Expected)"(Field 5813)". Please convert manually.

            CaptionML = ENU = 'Purchase Amount (Expected)', FRA = 'Montant achat (prévu)';
        }
        modify("Purchase Amount (Actual)")
        {

            //Unsupported feature: Change CalcFormula on ""Purchase Amount (Actual)"(Field 5814)". Please convert manually.

            CaptionML = ENU = 'Purchase Amount (Actual)', FRA = 'Montant achat (réel)';
        }
        modify("Sales Amount (Expected)")
        {

            //Unsupported feature: Change CalcFormula on ""Sales Amount (Expected)"(Field 5815)". Please convert manually.

            CaptionML = ENU = 'Sales Amount (Expected)', FRA = 'Montant vente (prévu)';
        }
        modify("Sales Amount (Actual)")
        {

            //Unsupported feature: Change CalcFormula on ""Sales Amount (Actual)"(Field 5816)". Please convert manually.

            CaptionML = ENU = 'Sales Amount (Actual)', FRA = 'Montant vente (réel)';
        }
        modify(Correction)
        {
            CaptionML = ENU = 'Correction', FRA = 'Correction';
        }
        modify("Shipped Qty. Not Returned")
        {
            CaptionML = ENU = 'Shipped Qty. Not Returned', FRA = 'Qté livrée non renvoyée';
        }
        modify("Prod. Order Comp. Line No.")
        {
            CaptionML = ENU = 'Prod. Order Comp. Line No.', FRA = 'N° ligne composant O.F.';
        }
        modify("Serial No.")
        {
            CaptionML = ENU = 'Serial No.', FRA = 'N° de série';
        }
        modify("Lot No.")
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
        }
        modify("Warranty Date")
        {
            CaptionML = ENU = 'Warranty Date', FRA = 'Date garantie';
        }
        modify("Expiration Date")
        {
            CaptionML = ENU = 'Expiration Date', FRA = 'Date d''expiration';
        }
        modify("Item Tracking")
        {
            CaptionML = ENU = 'Item Tracking', FRA = 'Traçabilité';
            // OptionCaptionML = ENU = 'None,Lot No.,Lot and Serial No.,Serial No.', FRA = 'Aucun,N° lot,N° lot et de série,N° de série';
        }
        modify("Return Reason Code")
        {
            CaptionML = ENU = 'Return Reason Code', FRA = 'Code motif retour';
        }
        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        field(10800; "Shipment Method Code"; Code[10])
        {
            CaptionML = ENU = 'Shipment Method Code',
                        FRA = 'Code condition livraison';
            Description = 'HEI.06';
            TableRelation = "Shipment Method";
        }
        *///Bc Upgrade YADAVM09 Drink it field commented<<
        field(50000; "Quality Status FND"; Option)
        {
            Caption = 'Quality Status';
            Description = 'HEI.01';
            OptionCaption = 'Quality Hold,Unrestricted,Blocked';
            OptionMembers = "Quality Hold",Unrestricted,Blocked;
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
        field(50008; "Project Code FND"; Code[20])
        {
            Description = 'HEI.03';
            Caption = 'Project Code';
        }
        //BC Upgrade GUNREM01 -Moved to interface extension >>
        // field(50009; "Interface Code"; Code[20])
        // {
        //     Caption = 'Interface Code';
        //     Description = 'HEI.04';
        //     //TableRelation = "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension 
        // }
        // field(50012; "CP Vendor Invoice No."; Code[20])
        // {
        //     Description = 'HEI.04';
        // }
        //BC Upgrade GUNREM01 -Moved to interface extension <<
        field(50013; "Value Entry Source No. FND"; Code[20])
        {
            CalcFormula = Lookup("Value Entry"."Source No." where("Item Ledger Entry No." = FIELD("Entry No.")));
            FieldClass = FlowField;
            Caption = 'Value Entry Source No.';
        }
        field(50025; "Reporting Type FND"; Option)
        {
            Caption = 'Reporting Type';
            Description = 'HEI.12';
            OptionCaption = '" ,Interregional Transfer Inbound,Interregional Transfer Outbound"';
            OptionMembers = " ","Interregional Transfer Inbound","Interregional Transfer Outbound";
        }
        field(50060; "Source System Identifier FND"; Code[10])
        {
            Caption = 'Source System Identifier';
            Description = 'HEI.10';
            Editable = false;
            TableRelation = "Source Sys Identifier API FND";
        }
        field(50061; "Zone Code FND"; Code[10])
        {
            Caption = 'Zone Code';
            Description = 'HEI.11';
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"));
        }
        //HEI.15>>
        field(50062; "Unit Volume HL FND"; Decimal)
        {
            Caption = 'Unit Volume HL';
            Description = 'HEI.15';
        }
        //HEI.15<<
        field(54000; "Your Reference FND"; Text[30])
        {
            Caption = 'Your Reference';
            DataClassification = ToBeClassified;
        }
        //BC Upgrade GUNREM01 IBM GAP DTW 73 >> Instead of DIT field added new field added new field to flow the flow the value from item journal to item leder entry.
        field(54001; "Scrap code FND"; Code[10])
        {
            Caption = 'Scrap code';
            DataClassification = ToBeClassified;
            TableRelation = Scrap;
        }
        //BC Upgrade GUNREM01 IBM GAP DTW 73 << Instead of DIT field added new field added new field to flow the flow the value from item journal to item leder entry.
        field(80000; "Vendor No. FND"; Code[20])
        {
            Description = 'FDD GAPL0G002';
            Caption = 'Vendor No.';
        }
        field(80001; "Vendor Name FND"; Text[50])
        {
            Description = 'FDD GAPL0G002';
            Caption = 'Vendor Name';
        }

        //BC Upgrade KAMNAY01 >>>> 
        // field(2013610;"Item DDeposit Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item DDeposit Group Code',
        //                 FRA='Code groupe consigne article';
        //     Description = 'DITW15.00.00.01-.39 #1373';
        //     TableRelation = "Drink Deposit Group".Code WHERE ("Source Type"=CONST(Item));
        // }
        // field(2013640;"Sales Deposit Amount (Actual)";Decimal)
        // {
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Value Entry"."Sales Deposit Amount (Actual)" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
        //     CaptionML = ENU='Sales Deposit Amount (Actual)',
        //                 FRA='Montant consigne vente (réel)';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013641;"Sales Deposit Amount (Exp)";Decimal)
        // {
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Value Entry"."Sales Deposit Amount (Exp)" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
        //     CaptionML = ENU='Sales Deposit Amount (Exp)',
        //                 FRA='Montant consigne vente (Prévu)';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013650;"Purchase Deposit Amt. (Actual)";Decimal)
        // {
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Value Entry"."Purchase Deposit Amt. (Actual)" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
        //     CaptionML = ENU='Purchase Deposit Amt. (Actual)',
        //                 FRA='Montant consigne achat (Actuel)';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013651;"Purchase Deposit Amt. (Exp)";Decimal)
        // {
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Value Entry"."Purchase Deposit Amt. (Exp)" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
        //     CaptionML = ENU='Purchase Deposit Amt. (Exp)',
        //                 FRA='Montant consigne achat (Prévu)';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013652;"Deposit Amount (Actual)";Decimal)
        // {
        //     CalcFormula = Sum("Value Entry"."Deposit Amount (Actual)" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
        //     Caption = 'Deposit Amount (Actual)';
        //     Description = 'DITW110.00.11 BL#14417';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013653;"Deposit Amount Posted to GL";Decimal)
        // {
        //     CalcFormula = Sum("Value Entry"."Deposit Amount Posted to GL" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
        //     Caption = 'Deposit Amount Posted to GL';
        //     Description = 'DITW110.00.11 BL#14417';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013654;"Deposit Amount (Expected)";Decimal)
        // {
        //     CalcFormula = Sum("Value Entry"."Deposit Amount (Expected)" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
        //     Caption = 'Deposit Amount (Expected)';
        //     Description = 'DITW110.00.11 BL#14417';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013655;"Expected Deposit Posted to G/L";Decimal)
        // {
        //     CalcFormula = Sum("Value Entry"."Expected Deposit Posted to G/L" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
        //     Caption = 'Deposit Amount Posted to GL';
        //     Description = 'DITW110.00.11 BL#14417';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013662;"Is Item Charge";Boolean)
        // {
        //     CaptionML = ENU='Is Item Charge',
        //                 FRA='Est frais annexes';
        //     Description = 'VC8-DITW15.00.00.01';
        // }
        // field(2013663;"ItemCharge Incl. Price";Boolean)
        // {
        //     CaptionML = ENU='Item Charge Incl. Price',
        //                 FRA='Frais annexe inclus prix';
        //     Description = 'VC8-DITW15.00.00.01';
        // }
        // field(2013667;"Item DTax Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Tax Group Code',
        //                 FRA='Code groupe taxe article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Item));
        // }
        // field(2013670;"Sales Tax Amount (Actual)";Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CalcFormula = Sum("Value Entry"."Sales Tax Amount (Actual)" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
        //     CaptionML = ENU='Sales Tax Amount (Actual)',
        //                 FRA='Montant taxe vente (Actuel)';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013671;"Sales Tax Amount (Expected)";Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CalcFormula = Sum("Value Entry"."Sales Tax Amount (Expected)" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
        //     CaptionML = ENU='Sales Tax Amount (Expected)',
        //                 FRA='Montant taxe vente (Prévu)';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013680;"Purchase Tax Amount (Actual)";Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CalcFormula = Sum("Value Entry"."Purchase Tax Amount (Actual)" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
        //     CaptionML = ENU='Purchase Tax Amount (Actual)',
        //                 FRA='Montant taxe achat (Acutel)';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013681;"Purchase Tax Amount (Expected)";Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CalcFormula = Sum("Value Entry"."Purchase Tax Amount (Expected)" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
        //     CaptionML = ENU='Purchase Tax Amount (Expected)',
        //                 FRA='Montant tawe achat (Prévu)';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013692;"Internal Tax Amount (Actual)";Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CalcFormula = Sum("Value Entry"."Internal Tax Amount (Actual)" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
        //     CaptionML = ENU='Internal Tax Amount (Actual)',
        //                 FRA='Montant interne taxe (réel)';
        //     Description = 'DITW15.00.00.25';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013693;"Internal Tax Amount (Exp)";Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CalcFormula = Sum("Value Entry"."Internal Tax Amount (Exp)" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
        //     CaptionML = ENU='Internal Tax Amount (Expected)',
        //                 FRA='Montant interne taxe (prévu)';
        //     Description = 'DITW15.00.00.25';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013696;"Location Group Code";Code[10])
        // {
        //     CaptionML = ENU='Location Tax Group Code',
        //                 FRA='Code groupe magasin taxe';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Location Group";
        // }
        // field(2013716;"Strength Spec. Code";Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0,FIELDNO("Strength Spec. Code"));
        //     CaptionML = ENU='Strength Spec. Code',
        //                 FRA='Code contrainte spécification taxe';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" WHERE (Type=CONST(Specification));
        // }
        // field(2013717;"Strength Spec. Value";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CalcFormula = Average("Value Entry"."Strength Spec. Value" WHERE ("Item Ledger Entry No."=FIELD("Entry No."),
        //                                                                       "Strength Spec. Value"=FILTER(<>0)));
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("Strength Spec. Value"));
        //     CaptionML = ENU='Strength Spec. Value',
        //                 FRA='Valeur contrainte spécification';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013718;"Vol-Strength Spec. Code";Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0,FIELDNO("Vol-Strength Spec. Code"));
        //     CaptionML = ENU='Vol-Strength Spec. Code',
        //                 FRA='Code spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" WHERE (Type=CONST(Specification));
        // }
        // field(2013719;"Vol-Strength Spec. Value";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Vol-Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("Vol-Strength Spec. Value"));
        //     CaptionML = ENU='Vol-Strength Spec. Value',
        //                 FRA='Valeur spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        // }
        // field(2013722;"Loss Vol-Strength Spec. Value";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Loss Vol-Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CalcFormula = Sum("Loss Breakdown Entry"."Vol-Strength Spec. Value" WHERE ("Item Ledger Entry No."=FIELD("Entry No."),
        //                                                                                "Capacity Ledger Entry No."=CONST(0)));
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("Loss Vol-Strength Spec. Value"));
        //     CaptionML = ENU='Loss Vol-Strength Spec. Value',
        //                 FRA='Valeur spécification perte contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013723;"Item Strength Spec. Value";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Item Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("Item Strength Spec. Value"));
        //     CaptionML = ENU='Strength Spec. Value',
        //                 FRA='Valeur contrainte spécification';
        //     Description = 'DITW19.00.08 BL#10443';
        // }
        // field(2013724;Reverse;Boolean)
        // {
        //     CaptionML = ENU='Reverse',
        //                 FRA='Contrepasser';
        //     Description = 'DITW19.00.08A BL#10443';
        // }
        // field(2013726;"Company Tax Registration No.";Text[20])
        // {
        //     CaptionML = ENU='Company Tax Registration No.',
        //                 FRA='N° identif. accise société';
        //     Description = 'DITW15.00.00.30';
        // }
        // field(2013729;"Tariff No.";Code[10])
        // {
        //     CaptionML = ENU='Tariff No.',
        //                 FRA='Nomenclature produits';
        //     Description = 'DITW15.00.00.34';
        //     TableRelation = "Tariff Number";
        // }
        // field(2013759;"Tax Spec. Filter";Code[20])
        // {
        //     CaptionML = ENU='Tax Specification Filter',
        //                 FRA='Filtre Spécification taxe';
        //     Description = 'DITW19.00.08 BL#10443';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Tax Specification" WHERE (Type=CONST(Specification));
        // }
        // field(2013767;"Unit Volume HL";Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Unit Volume HL"));
        //     CaptionML = ENU='Unit Volume',
        //                 FRA='Volume unitaire';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013774;"Item DDisc. Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Discount Group',
        //                 FRA='Groupe remise article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Discount Group".Code WHERE ("Source Type"=CONST(Item));
        // }
        // field(2013776;"Item DPromo. Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Promotion Group',
        //                 FRA='Groupe promotion article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Promotion Group".Code WHERE ("Source Type"=CONST(Item));
        // }
        // field(2013785;"Periodic Disc.-Promo Entry No.";Integer)
        // {
        //     CaptionML = ENU='Periodic Disc.-Promo Entry No.',
        //                 FRA='N° écriture Remise-Promotion périodique';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Sales Discount.-Promo. Entry"."Entry No.";
        // }
        // field(2013787;"Quantity in HL";Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Quantity in HL"));
        //     CaptionML = ENU='Quantity',
        //                 FRA='Quantité';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013826;"Free Item";Boolean)
        // {
        //     CaptionML = ENU='Free Item',
        //                 FRA='Article gratuit';
        //     Description = 'DITW15.00.00.35';
        // }
        // field(2013829;"Free Reason Code";Code[10])
        // {
        //     CaptionML = ENU='Free Reason Code',
        //                 FRA='Code motif gratuit';
        //     Description = 'DITW17.00.02 DIT-770 #132';
        //     Editable = false;
        //     TableRelation = "Free Reason Code";
        // }
        // field(2014078;"Driver Code";Code[10])
        // {
        //     Caption = 'Driver Code';
        //     Description = 'NRQ#43572';
        //     TableRelation = "Whse. Shipping Driver".Code;
        // }
        // field(2014094;"Physical Location Group Code";Code[10])
        // {
        //     CaptionML = ENU='Physical Location Group Code',
        //                 FRA='Code groupe magasin réel';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014109;"Route Planning No.";Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'DITW18.00.07 #1488 - NRQ#16224';
        //     Editable = false;
        //     TableRelation = "Route Planning Worksheet";
        // }
        // field(2014265;"Product Tax Code";Code[10])
        // {
        //     CaptionML = ENU='Tax Product Code',
        //                 FRA='Code Produit taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Product";
        // }
        // field(2014271;"Company Tax Warehouse Ref.";Text[20])
        // {
        //     CaptionML = ENU='Company Tax Warehouse Reference',
        //                 FRA='Entrepôt fiscal de référence société';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014412;"Scrap Code";Code[10])
        // {
        //     CaptionML = ENU='Scrap Code',
        //                 FRA='Code rebut';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = Scrap;
        // }
        // field(2014444;"Last Price Calculated Date";Date)
        // {
        //     CaptionML = ENU='Last Price Calculated Date',
        //                 FRA='Dernière date prix calculé';
        //     Description = 'DITW15.00.00.31';
        // }
        // field(2014508;"Ship-to/Order Address Code";Code[10])
        // {
        //     CaptionML = ENU='Ship-to/Order Address Code',
        //                 FRA='Code adresse destinataire/adresse de commande';
        //     Description = 'DITW15.00.00.39 #1230';
        //     TableRelation = IF ("Source Type"=CONST(Customer)) "Ship-to Address".Code WHERE ("Customer No."=FIELD("Source No."))
        //                     else IF ("Source Type"=CONST(Vendor)) "Order Address".Code WHERE ("Vendor No."=FIELD("Source No."));
        // }
        // field(2034983;"Work Order No.";Code[20])
        // {
        //     CaptionML = ENU='Work Order No.',
        //                 FRA='N° ordre d''intervention';
        //     Description = 'DIT-715 #457';
        //     TableRelation = "Service Header"."No." WHERE ("Document Type"=CONST(Order),
        //                                                   "PM Order Status"=CONST(Released));
        // }
        // field(2034986;"Work Order Line No.";Integer)
        // {
        //     CaptionML = ENU='Work Order Line No.',
        //                 FRA='N° ligne cmde. d''intervention';
        //     Description = 'DIT-715 #457';
        // }
        // field(2035048;"Lot SSCC Tracking";Boolean)
        // {
        //     CalcFormula = Exist("SSCC Ledger Entry" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
        //     CaptionML = ENU='Lot SSCC Tracking',
        //                 FRA='N° Lot SSCC - Traçabilité';
        //     Description = 'DITW15.00.00.38 #1139';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035098;"Your Reference";Text[30])
        // {
        //     Caption = 'Your Reference';
        //     Description = 'QXL11.01, HEI.07';
        //     Editable = false;
        // }
        // field(2035172;"Gyle No.";Code[20])
        // {
        //     CaptionML = ENU='Gyle No.',
        //                 FRA='Gyle N°';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        // field(2035244;"Recovered Beer";Boolean)
        // {
        //     CaptionML = ENU='Recovered Beer',
        //                 FRA='Bière Récuperé';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        // field(2035248;"Exist Loss Breakdown";Boolean)
        // {
        //     CalcFormula = Exist("Loss Breakdown Entry" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
        //     CaptionML = ENU='Exist Loss Breakdown',
        //                 FRA='Détail Pertes Existe';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2036301;"Bin Code";Code[20])
        // {
        //     CaptionML = ENU='Bin Code',
        //                 FRA='Code emplacement';
        //     Description = 'MANXL7.00.001';
        // }
        //BC Upgrade KAMNAY01<<<<
    }
    keys
    {

        //Unsupported feature: PropertyChange on ""Item No.","Entry Type","Variant Code","Drop Shipment","Location Code","Posting Date"(Key)". Please convert manually.


        //Unsupported feature: PropertyChange on ""Item No.",Open,"Variant Code",Positive,"Location Code","Posting Date","Expiration Date","Lot No.","Serial No."(Key)". Please convert manually.


        //Unsupported feature: PropertyChange on ""Item No.","Entry Type","Variant Code","Drop Shipment","Global Dimension 1 Code","Global Dimension 2 Code","Location Code","Posting Date"(Key)". Please convert manually.


        //Unsupported feature: PropertyChange on ""Order Type","Order No.","Order Line No.","Entry Type","Prod. Order Comp. Line No."(Key)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item No.","Location Code",Open,"Variant Code","Unit of Measure Code","Lot No.","Serial No."(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""Item No.",Open,"Variant Code",Positive,"Lot No.","Serial No."(Key)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot No."(Key)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Serial No."(Key)". Please convert manually.

        key(Key26; "Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
        }
        //BC Upgrade KAMNAY01>>>>
        // key(Key27;"Entry Type","Item No.",Open,Positive,"Posting Date","Recovered Beer")
        // {
        //     SumIndexFields = "Vol-Strength Spec. Value","Quantity in HL";
        // }
        // key(Key3;"Source Type","Source No.","Global Dimension 1 Code","Global Dimension 2 Code","Item No.","Variant Code","Location Code","Unit of Measure Code","Posting Date")
        // {
        //     SumIndexFields = Quantity,"Invoiced Quantity","Quantity in HL";
        // }
        // key(Key4;"Item No.","Variant Code","Source Type","Source No.","Location Code","Unit of Measure Code","Global Dimension 1 Code","Global Dimension 2 Code","Posting Date")
        // {
        //     SumIndexFields = Quantity,"Invoiced Quantity","Quantity in HL";
        // }
        //BC Upgrade KAMNAY01<<<<
        key(Key27; "Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date")
        {
        }
        key(Key28; "Completely Invoiced", "Posting Date", "Item No.", "Lot No.", "Serial No.", "Entry Type")
        {
            SumIndexFields = Quantity, "Remaining Quantity", "Invoiced Quantity";
        }
        //BC Version 28.0 Compatibility Fix >>
        // key(Key7; "Item No.", "Entry Type", "Source Type", "Source No.", "Posting Date", "Document Type", "Document No.", "Unit of Measure Code")
        // {
        //     SumIndexFields = Quantity;
        // }
        key(Key51000; "Item No.", "Entry Type", "Source Type", "Source No.", "Posting Date", "Document Type", "Document No.", "Unit of Measure Code")
        {
            SumIndexFields = Quantity;
        }
        //BC Version 28.0 Compatibility Fix <<
        //BC Upgrade KAMNAY01<<<<
        // key(Key29;"Source Type","Source No.","Entry Type","Document Type","Posting Date","Document No.","Item No.","Ship-to/Order Address Code")
        // {
        //     SumIndexFields = Quantity;
        // }
        //BC Upgrade KAMNAY01>>>>
        key(Key30; "Entry Type", "Source Type", "Source No.", "Posting Date")
        {
        }
        //BC Upgrade KAMNAY01>>>>
        // key(Key10;"Work Order No.","Work Order Line No.","Location Code","Item No.",Open)
        // {
        //     SumIndexFields = Quantity,"Remaining Quantity";
        // }
        // key(Key11;"Periodic Disc.-Promo Entry No.","Entry Type","Source Type","Source No.","Item No.","Posting Date","Variant Code","Location Code","Unit of Measure Code","Free Item")
        // {
        // }
        //BC Upgrade KAMNAY01<<<<
        key(Key31; "Item No.", Open, "Variant Code", "Location Code", "Lot No.")
        {
            SumIndexFields = "Remaining Quantity";
        }
        key(Key32; "Entry Type", "Document Type", "Item No.", "Source No.", "Location Code", "Variant Code", "Posting Date")
        {
            SumIndexFields = Quantity;
        }
        //BC Upgrade KAMNAY01>>>>
        // key(Key14;"Item No.","Entry Type","Source No.","Variant Code","Drop Shipment","Global Dimension 1 Code","Global Dimension 2 Code","Location Code","Free Item","Posting Date")
        // {
        //     SumIndexFields = Quantity,"Quantity in HL","Vol-Strength Spec. Value";
        // }
        //BC Upgrade KAMNAY01<<<<
        key(Key15; "Order No.", "Order Line No.", "Entry Type", "Location Code")
        {
            SumIndexFields = Quantity;
        }
        key(Key16; "Order No.", "Order Line No.", "Prod. Order Comp. Line No.", "Entry Type")
        {
        }
        key(Key33; "Document No.", "Posting Date")
        {
        }
        //BC Upgrade KAMNAY01>>>>
        // key(Key18;"Order No.","Order Line No.","Entry Type","Location Code","Bin Code")
        // {
        //     SumIndexFields = Quantity;
        // }

        // key(Key19;"Source Type","Source No.","Item DDeposit Group Code","Posting Date")
        // {
        // }

        // key(Key34;"Item No.","Quality Status","Lot No.")
        // {
        //     SumIndexFields = Quantity;
        // }
        //BC Upgrade KAMNAY01<<<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "IsNotOnInventoryErr(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //IsNotOnInventoryErr : ENU=You have insufficient quantity of Item %1 on inventory.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IsNotOnInventoryErr : ENU=You have insufficient quantity of Item %1 on inventory.;FRA=La quantité d'articles %1 en stock est insuffisante.;
    //Variable type has not been exported.

    var
        InvtSetup: Record "Inventory Setup";
        ContractExpiringDate: Date;
        ContractStartingDate: Date;
        Text2013723: TextConst ENU = 'Source', FRA = 'Source';
}

