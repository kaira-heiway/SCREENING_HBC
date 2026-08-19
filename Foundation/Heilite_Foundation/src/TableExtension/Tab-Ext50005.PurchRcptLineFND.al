tableextension 50005 PurchRcptLineExtFND extends "Purch. Rcpt. Line"
{
    // version NAVW110.0.00.16585,FINXL10.00,DITW110.00.10,HEI.19

    // BC Upgrade MISHRS14 >>
    // Blocked below property 'OptionCaptionML' due to warning in field - modify(Type)
    // Blocked below property 'OptionCaptionML' due to warning in field - modify(VAT Calculation Type)
    // Blocked below property 'OptionCaptionML' due to warning in field - modify(Job Line Type)
    // Blocked below property 'OptionCaptionML' due to warning in field - modify(FA Posting Type)
    // BC Upgrade MISHRS14 <<

    fields
    {
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

            // BC Upgrade MISHRS14 >>
            // Blocked below property 'OptionCaptionML' because it can only be set on elements of type Option and this will become error in future.
            //OptionCaptionML = ENU = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)', FRA = ' ,Compte général,Article,,Immobilisation,Frais annexes';
            // BC Upgrade MISHRS14 <<

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
        }
        modify("Posting Group")
        {

            //Unsupported feature: Change TableRelation on ""Posting Group"(Field 8)". Please convert manually.

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
        modify("Direct Unit Cost")
        {
            CaptionML = ENU = 'Direct Unit Cost', FRA = 'Coût unitaire direct';

            //Unsupported feature: Change AutoFormatExpr on ""Direct Unit Cost"(Field 22)". Please convert manually.


            //Unsupported feature: Change Description on ""Direct Unit Cost"(Field 22)". Please convert manually.

            CaptionClass = GetCaptionClass(FIELDNO("Direct Unit Cost"));
        }
        modify("Unit Cost (LCY)")
        {
            CaptionML = ENU = 'Unit Cost (LCY)', FRA = 'Coût unitaire DS';

            //Unsupported feature: Change Description on ""Unit Cost (LCY)"(Field 23)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Unit Cost (LCY)"(Field 23)". Please convert manually.

        }
        modify("VAT %")
        {
            CaptionML = ENU = 'VAT %', FRA = '% TVA';
        }
        modify("Line Discount %")
        {
            CaptionML = ENU = 'Line Discount %', FRA = '% remise ligne';
        }
        modify("Unit Price (LCY)")
        {
            CaptionML = ENU = 'Unit Price (LCY)', FRA = 'Prix unitaire DS';

            //Unsupported feature: Change Description on ""Unit Price (LCY)"(Field 31)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Unit Price (LCY)"(Field 31)". Please convert manually.

        }
        modify("Allow Invoice Disc.")
        {

            //Unsupported feature: Change InitValue on ""Allow Invoice Disc."(Field 32)". Please convert manually.

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
        modify("Item Rcpt. Entry No.")
        {
            CaptionML = ENU = 'Item Rcpt. Entry No.', FRA = 'N° séquence récept. article';
        }
        modify("Shortcut Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 1 Code"(Field 40)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 2 Code"(Field 41)". Please convert manually.

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
        modify("Qty. Rcd. Not Invoiced")
        {
            CaptionML = ENU = 'Qty. Rcd. Not Invoiced', FRA = 'Qté reçue non facturée';
        }
        modify("Quantity Invoiced")
        {
            CaptionML = ENU = 'Quantity Invoiced', FRA = 'Quantité facturée';
        }
        modify("Order No.")
        {
            CaptionML = ENU = 'Order No.', FRA = 'N° commande';
        }
        modify("Order Line No.")
        {
            CaptionML = ENU = 'Order Line No.', FRA = 'N° ligne commande';
        }
        modify("Pay-to Vendor No.")
        {
            CaptionML = ENU = 'Pay-to Vendor No.', FRA = 'N° fournisseur à payer';
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

            // BC Upgrade MISHRS14 >>
            // Blocked below property 'OptionCaptionML' because it can only be set on elements of type Option and this will become error in future.
            //OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
            // BC Upgrade MISHRS14 <<

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

            //Unsupported feature: Change TableRelation on ""Attached to Line No."(Field 80)". Please convert manually.

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

            //Unsupported feature: Change CalcFormula on ""Currency Code"(Field 91)". Please convert manually.

            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Blanket Order No.")
        {

            //Unsupported feature: Change TableRelation on ""Blanket Order No."(Field 97)". Please convert manually.

            CaptionML = ENU = 'Blanket Order No.', FRA = 'N° commande ouverte';
        }
        modify("Blanket Order Line No.")
        {

            //Unsupported feature: Change TableRelation on ""Blanket Order Line No."(Field 98)". Please convert manually.

            CaptionML = ENU = 'Blanket Order Line No.', FRA = 'N° ligne cde ouverte';
        }
        modify("VAT Base Amount")
        {
            CaptionML = ENU = 'VAT Base Amount', FRA = 'Montant base TVA';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';

            //Unsupported feature: Change AutoFormatExpr on ""Unit Cost"(Field 100)". Please convert manually.


            //Unsupported feature: Change Description on ""Unit Cost"(Field 100)". Please convert manually.

        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Job Task No.")
        {

            //Unsupported feature: Change TableRelation on ""Job Task No."(Field 1001)". Please convert manually.

            CaptionML = ENU = 'Job Task No.', FRA = 'N° tâche projet';
        }
        modify("Job Line Type")
        {
            CaptionML = ENU = 'Job Line Type', FRA = 'Type ligne projet';

            // BC Upgrade MISHRS14 >>
            // Blocked below property 'OptionCaptionML' because it can only be set on elements of type Option and this will become error in future.
            //OptionCaptionML = ENU = ' ,Budget,Billable,Both Budget and Billable', FRA = ' ,Budget,Facturable,Budget et Facturable';
            // BC Upgrade MISHRS14 <<

        }
        modify("Job Unit Price")
        {
            CaptionML = ENU = 'Job Unit Price', FRA = 'Prix unitaire projet';
        }
        modify("Job Total Price")
        {
            CaptionML = ENU = 'Job Total Price', FRA = 'Prix total projet';
        }
        modify("Job Line Amount")
        {
            CaptionML = ENU = 'Job Line Amount', FRA = 'Montant ligne projet';
        }
        modify("Job Line Discount Amount")
        {
            CaptionML = ENU = 'Job Line Discount Amount', FRA = 'Montant remise ligne projet';
        }
        modify("Job Line Discount %")
        {
            CaptionML = ENU = 'Job Line Discount %', FRA = '% remise ligne projet';
        }
        modify("Job Unit Price (LCY)")
        {
            CaptionML = ENU = 'Job Unit Price (LCY)', FRA = 'Prix unitaire projet DS';
        }
        modify("Job Total Price (LCY)")
        {
            CaptionML = ENU = 'Job Total Price (LCY)', FRA = 'Prix total projet DS';
        }
        modify("Job Line Amount (LCY)")
        {
            CaptionML = ENU = 'Job Line Amount (LCY)', FRA = 'Montant ligne projet DS';
        }
        modify("Job Line Disc. Amount (LCY)")
        {
            CaptionML = ENU = 'Job Line Disc. Amount (LCY)', FRA = 'Montant remise ligne projet DS';
        }
        modify("Job Currency Factor")
        {
            CaptionML = ENU = 'Job Currency Factor', FRA = 'Facteur devise projet';
        }
        modify("Job Currency Code")
        {
            CaptionML = ENU = 'Job Currency Code', FRA = 'Code devise projet';
        }
        modify("Prod. Order No.")
        {

            //Unsupported feature: Change TableRelation on ""Prod. Order No."(Field 5401)". Please convert manually.

            CaptionML = ENU = 'Prod. Order No.', FRA = 'N° ordre de fabrication';
        }
        modify("Variant Code")
        {

            //Unsupported feature: Change TableRelation on ""Variant Code"(Field 5402)". Please convert manually.

            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Bin Code"(Field 5403)". Please convert manually.

            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("Unit of Measure Code")
        {

            //Unsupported feature: Change TableRelation on ""Unit of Measure Code"(Field 5407)". Please convert manually.

            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Quantity (Base)")
        {
            CaptionML = ENU = 'Quantity (Base)', FRA = 'Quantité (base)';
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

            // BC Upgrade MISHRS14 >>
            // Blocked below property 'OptionCaptionML' because it can only be set on elements of type Option and this will become error in future.
            //OptionCaptionML = ENU = ' ,Acquisition Cost,Maintenance', FRA = ' ,Coût acquisition,Maintenance';
            // BC Upgrade MISHRS14 <<

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
        //BC UPGRADE SHARMP16 fields NA<<
        // modify("Cross-Reference No.")
        // {
        //     CaptionML = ENU = 'Cross-Reference No.', FRA = 'Référence externe';
        // }
        // modify("Unit of Measure (Cross Ref.)")
        // {

        //     //Unsupported feature: Change TableRelation on ""Unit of Measure (Cross Ref.)"(Field 5706)". Please convert manually.

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
        //BC UPGRADE SHARMP16 fields NA>>
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
        //BC UPGRADE SHARMP16 fields NA<<
        // modify("Product Group Code")
        // {

        //     //Unsupported feature: Change TableRelation on ""Product Group Code"(Field 5712)". Please convert manually.

        //     CaptionML = ENU = 'Product Group Code', FRA = 'Code groupe produits';
        // }
        //BC UPGRADE SHARMP16 fields NA>>
        modify("Special Order Sales No.")
        {
            CaptionML = ENU = 'Special Order Sales No.', FRA = 'N° vente cde spéciale';
        }
        modify("Special Order Sales Line No.")
        {
            CaptionML = ENU = 'Special Order Sales Line No.', FRA = 'N° ligne vente cde spéciale';
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
        modify("Item Charge Base Amount")
        {
            CaptionML = ENU = 'Item Charge Base Amount', FRA = 'Montant base frais annexes';
        }
        modify(Correction)
        {
            CaptionML = ENU = 'Correction', FRA = 'Correction';
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

            //Unsupported feature: Change TableRelation on ""Operation No."(Field 99000751)". Please convert manually.

            CaptionML = ENU = 'Operation No.', FRA = 'N° opération';
        }
        modify("Work Center No.")
        {
            CaptionML = ENU = 'Work Center No.', FRA = 'N° centre de charge';
        }
        modify("Prod. Order Line No.")
        {

            //Unsupported feature: Change TableRelation on ""Prod. Order Line No."(Field 99000754)". Please convert manually.

            CaptionML = ENU = 'Prod. Order Line No.', FRA = 'N° ligne O.F.';
        }
        modify("Overhead Rate")
        {
            CaptionML = ENU = 'Overhead Rate', FRA = 'Frais généraux';
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
            CalcFormula = Lookup("Purch. Rcpt. Header"."SRM Contract Type FND" where("No." = FIELD("Document No.")));
            Caption = 'SRM Contract Type';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Valid From FND"; Date)
        {
            CalcFormula = Lookup("Purch. Rcpt. Header"."Valid From FND" where("No." = FIELD("Document No.")));
            Caption = 'Valid From';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Valid To FND"; Date)
        {
            CalcFormula = Lookup("Purch. Rcpt. Header"."Valid To FND" where("No." = FIELD("Document No.")));
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
        field(50017; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            Description = 'HEI.02';
            TableRelation = "WHT Business Posting Group FND".Code;
        }
        field(50018; "WHT Product Posting Group FND"; Code[10])
        {
            Caption = 'WHT Product Posting Group';
            Description = 'HEI.02';
            TableRelation = "WHT Product Posting Group FND".Code;
        }
        field(50019; "WHT Absorb Base FND"; Decimal)
        {
            Caption = 'WHT Absorb Base';
            Description = 'HEI.02';
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
            Description = 'HEI.03';
            Editable = false;
        }
        field(50031; "Maximo Requis. Line No. FND"; Integer)
        {
            Caption = 'Maximo Requisition Line No.';
            Description = 'HEI.03';
            Editable = false;
        }
        field(50032; "Machine Reference Number FND"; Text[50])
        {
            CalcFormula = Lookup(Item."Machine Reference Number FND" where("No." = FIELD("No.")));
            Caption = 'Machine Reference Number';
            Description = 'HEI.06';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50042; "TIN No. FND"; Text[20])
        {
            Caption = 'TIN No.';
            Description = 'HEI.07';
            Editable = false;
            TableRelation = "TIN by Location FND"."TIN No.";
            ValidateTableRelation = false;
        }
        field(50043; "Gate Entry No. FND"; Code[20])
        {
            Description = 'HEI.08';
            Caption = 'Gate Entry No.';
            Editable = false;
            //TableRelation = "Gate Entry Header FND";  // BC UPGRADE SHARMP16 - Blocked as Gate ENtry Header is yet to be compiled
        }
        field(50044; "Self_Billing Inv. No. FND"; Code[20])
        {
            Description = 'HEI.09';
            Caption = 'Self-Billing Invoice No.';
        }
        field(50050; "License Code FND"; Code[20])
        {
            CalcFormula = Lookup("Purchase Header Additional FND"."License Code" where("Document Type" = CONST(Order),
                                                                                    "No." = FIELD("Order No.")));
            Description = 'HEI.11';
            Caption = 'License Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50051; "CAD Amount FND"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'CAD Amount',
                        FRA = 'CAD Montant';
            DataClassification = ToBeClassified;
            Description = 'HEI.12';
            Editable = false;
        }
        field(50052; "CAD Attached to Line No. FND"; Integer)
        {
            Caption = 'CAD Attached to Line No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.12';
            Editable = false;
        }
        field(50054; "Astro Unique ID FND"; Code[20])
        {
            Caption = 'Astro Unique ID';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50057; "SPL Code FND"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.14';
            Caption = 'SPL Code';
            TableRelation = "Vendor SPL Relation FND"."SPL Code";
        }
        field(50058; "SPL Name FND"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.14';
            Caption = 'SPL Name';
            Editable = false;
        }
        field(50062; "H&S Levy Tax % FND"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
            Caption = 'H&S Levy Tax %';
            TableRelation = "H&S Tax Posting Group FND";
        }
        field(50063; "H&S Levy Tax Amount FND"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
            Caption = 'H&S Levy Tax Amount';
        }
        field(50064; "Total Amount Excl VAT/H&S FND"; Decimal)
        {
            Caption = 'Total Amount Excl VAT/H&S';
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
        }
        field(50075; "Zycus Order No. FND"; Code[20])
        {
            Caption = 'Zycus Order No.';
            Description = 'HEI.16,HEI.17';
            Editable = false;
        }
        field(50076; "Zycus Order Line No. FND"; Integer)
        {
            Caption = 'Zycus Order Line No.';
            Description = 'HEI.16,HEI.17';
            Editable = false;
        }
        field(50077; "Zycus PR Reference No. FND"; Code[20])
        {
            Caption = 'Zycus PR Reference No.';
            Description = 'HEI.17';
            Editable = false;
        }
        field(50078; "Zycus PO Type Code FND"; Code[3])
        {
            Caption = 'Zycus PO Type Code';
            Description = 'HEI.17';
            Editable = false;
        }
        field(50079; "Zycus PO Line Type Code FND"; Code[1])
        {
            Caption = 'Zycus PO Line Type Code';
            Description = 'HEI.17';
            Editable = false;
        }
        field(50080; "Zycus PO Line Validated FND"; Boolean)
        {
            Caption = 'Zycus PO Line Validated';
            Description = 'HEI.17';
            Editable = false;
        }
        field(50085; "Zycus Movement Type FND"; Integer)
        {
            Caption = 'Zycus Movement Type';
            Description = 'HEI.19';
            Editable = false;
        }
        // BC Upgrade BHARDA11 >>  --Field Added
        field(50086; "Amount Heilite FND"; Decimal)
        {
            Caption = 'Line Amount';
            DataClassification = ToBeClassified;
        }
        field(50087; "Amount LCY Heilite FND"; Decimal)
        {
            Caption = 'Line Amount LCY';
            DataClassification = ToBeClassified;

        }
        // BC Upgrade BHARDA11 <<  --Field Added
        //BC UPGRADE SHARMP16 comment drink-it fields >>
        // field(2013610;"Item DDeposit Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Deposit Group Code',
        //                 FRA='Code groupe consigne article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code WHERE ("Source Type"=CONST(Item));
        // }
        // field(2013611;"Empty Goods Item No.";Code[20])
        // {
        //     CaptionML = ENU='Empty Goods Item No.',
        //                 FRA='N° article vidange';
        //     Description = 'DITW15.00.00.01-.35';
        //     TableRelation = Item WHERE ("Empty Good"=CONST(true));
        // }
        // field(2013612;"Item Charge Quantity per";Decimal)
        // {
        //     CaptionML = ENU='Item Charge Quantity per',
        //                 FRA='Quantité frais annexes par';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.01';
        //     MinValue = 0;
        // }
        // field(2013615;"Rounding factor";Option)
        // {
        //     CaptionML = ENU='Rounding factor',
        //                 FRA='Unité d''affichage';
        //     Description = 'DITW17.00.02 DIT-770 #142';
        //     Editable = false;
        //     OptionCaptionML = ENU='Nearest,Up,Down',
        //                       FRA='Au plus près,Par excès,Par défaut';
        //     OptionMembers = Nearest,Up,Down;
        // }
        // field(2013637;"Deposit Value";Decimal)
        // {
        //     AutoFormatType = 2;
        //     Caption = 'Deposit Value';
        //     Description = 'DITW110.00.11 BL#14417';
        // }
        // field(2013660;"Extra Charge Type";Option)
        // {
        //     CaptionML = ENU='Extra Charge Type',
        //                 FRA='Type frais extra';
        //     Description = 'VC8-DITW15.00.00.01-.34';
        //     OptionCaptionML = ENU=' ,Amount,Price %,Amount %,Fixed Amount,Volume /Unit,Weight,Cubage,Distance,Purchase Price,Unit of measure',
        //                       FRA=' ,Montant,Prix %,Montant %,Montant Fixe,Volume /Unit,Poids,Cubage,Distance,Prix achat,Unit of measure';
        //     OptionMembers = " ",Amount,"Price %","Amount %","Fixed Amount",VolumeHL,Weight,Cubage,Distance,"Price Item","Unit of Measure";
        // }
        // field(2013661;"Item Charge Value";Decimal)
        // {
        //     AutoFormatExpression = GetAutoformatRoundingType(GetCurrencyCodeFromHeader);
        //     AutoFormatType = 2;
        //     CaptionML = ENU='Item Charge Value',
        //                 FRA='Valeur frais annexes';
        //     Description = 'DITW15.00.00.32';
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
        // field(2013664;"Item Charge Discount %";Decimal)
        // {
        //     CaptionML = ENU='Item Charge Discount %',
        //                 FRA='Remise frais annexes %';
        //     Description = 'VC8-DITW15.00.00.01';
        // }
        // field(2013665;"Allow Item Charge Line Disc.";Boolean)
        // {
        //     CaptionML = ENU='Allow Item Charge Line Discount',
        //                 FRA='Frais annexes remise ligne autorisé';
        //     Description = 'VC8-DITW15.00.00.01';
        //     InitValue = true;
        // }
        // field(2013666;"Vendor DTax Group Code";Code[10])
        // {
        //     CaptionML = ENU='Customer Tax Group Code',
        //                 FRA='Code groupe taxe client';
        //     Description = 'DITW17.10.05 DIT-770 698';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Vendor));
        // }
        // field(2013667;"Item DTax Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Tax Group Code',
        //                 FRA='Code groupe taxe article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Item));
        // }
        // field(2013695;"Item Charge Type";Option)
        // {
        //     CaptionML = ENU='Item Charge Type',
        //                 FRA='Type frais annexes';
        //     Description = 'DITW15.00.00.01';
        //     OptionCaptionML = ENU=' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA=' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        // }
        // field(2013696;"Location Group Code";Code[10])
        // {
        //     CaptionML = ENU='Location Tax Group Code',
        //                 FRA='Code groupe magasin taxe';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Location Group";
        // }
        // field(2013708;"Due Tax";Boolean)
        // {
        //     CaptionML = ENU='Due Tax',
        //                 FRA='Taxe due';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013715;"Tax Formula";Code[80])
        // {
        //     CaptionML = ENU='Tax Formula',
        //                 FRA='Formule taxe';
        //     Description = 'DITW15.00.00.31';
        // }
        // field(2013716;"Strength Spec. Code";Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0,FIELDNO("Strength Spec. Code"));
        //     CaptionML = ENU='Strength Spec. Code',
        //                 FRA='Code contrainte spécification taxe';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" WHERE (Type=CONST(Specification));
        // }
        // field(2013718;"Vol-Strength Spec. Code";Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0,FIELDNO("Vol-Strength Spec. Code"));
        //     CaptionML = ENU='Vol-Strength Spec. Code',
        //                 FRA='Code spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" WHERE (Type=CONST(Specification));
        // }
        // field(2013722;"Duty Suspended";Boolean)
        // {
        //     CaptionML = ENU='Duty Suspended',
        //                 FRA='Taxe en suspension';
        //     Description = 'DITW15.00.00.33';
        // }
        // field(2013726;"Company Tax Registration No.";Text[20])
        // {
        //     CaptionML = ENU='Company Tax Registration No.',
        //                 FRA='N° identif. accise société';
        //     Description = 'DITW15.00.00.28';
        // }
        // field(2013727;"AAD No. Series";Code[10])
        // {
        //     CaptionML = ENU='AAD No. Series',
        //                 FRA='Souches de n° DAA';
        //     Description = 'DITW15.00.00.28';
        //     TableRelation = "No. Series";
        // }
        // field(2013728;"AAD No.";Code[20])
        // {
        //     CaptionML = ENU='AAD No.',
        //                 FRA='N° DAA';
        //     Description = 'DITW15.00.00.28';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //         if CurrFieldNo = FIELDNO("AAD No.") then
        //           TESTFIELD("Applies-to AAD Trck. Entry No.",0);
        //         // >>DITW15.00.00.39 DDR #1369
        //     end;
        // }
        // field(2013729;"Tariff No.";Code[10])
        // {
        //     CaptionML = ENU='Tariff No.',
        //                 FRA='Nomenclature produits';
        //     Description = 'DITW15.00.00.28';
        //     TableRelation = "Tariff Number";
        // }
        // field(2013731;"Applies-to AAD Trck. Entry No.";Integer)
        // {
        //     CaptionML = ENU='Applies-to Correction AAD Trck. Entry No.',
        //                 FRA='N° Ecriture correction suivi DAA lettrage';
        //     Description = 'DITW15.00.00.39 #1369';
        //     TableRelation = "AAD Tracking Entry"."Entry No." WHERE ("Entry Type"=CONST(Outbound),
        //                                                             "Source Type"=CONST(Vendor),
        //                                                             "Source No."=FIELD("Buy-from Vendor No."));

        //     trigger OnValidate();
        //     var
        //         AADTrackingEntry : Record "AAD Tracking Entry";
        //     begin
        //         TESTFIELD(Type,Type::Item);
        //         if "Applies-to AAD Trck. Entry No." <> 0 then begin
        //           TESTFIELD("LRN No.",'');
        //           AADTrackingEntry.GET("Applies-to AAD Trck. Entry No.");
        //           "AAD No." := AADTrackingEntry."AAD No.";
        //           "ARC No." := AADTrackingEntry."ARC No.";
        //         end;
        //     end;
        // }
        // field(2013761;"Disable DIT Disc. Prom.";Option)
        // {
        //     Caption = 'Disable DIT Discount Promotion';
        //     Description = 'DITW111.00.13A MSF 09/05/2019 NRQ#109271';
        //     OptionCaption = '" ,Discount,Promotion,All"';
        //     OptionMembers = " ",Discount,Promotion,All;
        // }
        // field(2013767;"Unit Volume HL";Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Unit Volume HL"));
        //     CaptionML = ENU='Unit Volume',
        //                 FRA='Volume unitaire';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.01';
        //     MinValue = 0;
        // }
        // field(2013773;"Vendor DDisc. Group Code";Code[10])
        // {
        //     CaptionML = ENU='Vendor Discount Group',
        //                 FRA='Groupe remise fournisseur';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Discount Group".Code WHERE ("Source Type"=CONST(Vendor));
        // }
        // field(2013774;"Item DDisc. Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Discount Group',
        //                 FRA='Groupe remise article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Discount Group".Code WHERE ("Source Type"=CONST(Item));
        // }
        // field(2013775;"Vendor DPromo. Group Code";Code[10])
        // {
        //     CaptionML = ENU='Vendor Promotion Group',
        //                 FRA='Groupe promotion fournisseur';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Promotion Group".Code WHERE ("Source Type"=CONST(Vendor));
        // }
        // field(2013776;"Item DPromo. Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Promotion Group',
        //                 FRA='Groupe promotion article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Promotion Group".Code WHERE ("Source Type"=CONST(Item));
        // }
        // field(2013777;"Item Charge Calculate per";Option)
        // {
        //     CaptionML = ENU='Item Charge Calculate per',
        //                 FRA='Frais annexe calcul par';
        //     Description = 'DITW15.00.00.01';
        //     OptionCaptionML = ENU='Item,Order,Period',
        //                       FRA='Article,Commande,Périodique';
        //     OptionMembers = Item,"Order",Period;
        // }
        // field(2013778;"Opposite Qty. Sign";Boolean)
        // {
        //     CaptionML = ENU='Opposite Qty. Sign',
        //                 FRA='Signe quantité opposé';
        //     Description = 'DITW15.00.00.36';
        // }
        // field(2013779;"Using Qty. (Base)";Boolean)
        // {
        //     CaptionML = ENU='Using Qty. (Base)',
        //                 FRA='Utilisation quantité (Base)';
        //     Description = 'DITW15.00.00.36';
        // }
        // field(2013780;"Free Quantity";Decimal)
        // {
        //     CaptionML = ENU='Free Quantity',
        //                 FRA='Quantité gratuite';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.36';
        //     MinValue = 0;
        // }
        // field(2013781;"Multiple Quantity";Decimal)
        // {
        //     CaptionML = ENU='Multiple Quantity',
        //                 FRA='Quantité multiple';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.36';
        //     MinValue = 0;
        // }
        // field(2013782;"Maximum Free Quantity";Decimal)
        // {
        //     CaptionML = ENU='Maximum Free Quantity',
        //                 FRA='Quantité maximum gratuite';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.36';
        //     MinValue = 0;
        // }
        // field(2013783;"DDiscount Level Position";Integer)
        // {
        //     CaptionML = ENU='Discount Level Position',
        //                 FRA='Position niveau de remise';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013784;"DDiscount Base Amount";Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCodeFromHeader;
        //     AutoFormatType = 1;
        //     CaptionML = ENU='DDiscount Base Amount',
        //                 FRA='Montant base remise';
        //     Description = 'DITW17.00.02 DIT-770 #274';
        // }
        // field(2013785;"Periodic Disc.-Promo Entry No.";Integer)
        // {
        //     CaptionML = ENU='Periodic Disc.-Promo Entry No.',
        //                 FRA='N° écriture Remise-Promotion périodique';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Sales Discount.-Promo. Entry"."Entry No.";
        // }
        // field(2013788;"DDiscount Include Tax";Boolean)
        // {
        //     CaptionML = ENU='Discount Include Tax',
        //                 FRA='Remise inculant taxe';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013789;"DDiscount Include Deposit";Boolean)
        // {
        //     CaptionML = ENU='DDiscount Include Deposit',
        //                 FRA='Remise incluent caution';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013790;"DDiscount Include Discount";Boolean)
        // {
        //     CaptionML = ENU='DDiscount Include Discount',
        //                 FRA='Remise incluent remise';
        //     Description = 'DITW17.00.02 DIT-770 #230';
        // }
        // field(2013797;"Disc.Promo. Order Calculated";Boolean)
        // {
        //     CaptionML = ENU='Disc.Promo. Order Calculated',
        //                 FRA='Remise-Promotion cmde. calculé';
        //     Description = 'DITW15.00.00.37';
        // }
        // field(2013803;"Allow VAT Calculation (Free)";Boolean)
        // {
        //     CaptionML = ENU='Allow VAT Calculation (Free)',
        //                 FRA='Autoriser calcul TVA (Gratuit)';
        //     Description = 'DITW16.00.00.40 DIT-715 #172';
        // }
        // field(2013824;"Gen. Prod. Posting Free Group";Code[10])
        // {
        //     CaptionML = ENU='Gen. Prod. Posting Group Free Item',
        //                 FRA='Groupe article gratuit compta. produit';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Gen. Product Posting Group";
        // }
        // field(2013825;"Free Item Posting Type";Option)
        // {
        //     CaptionML = ENU='Calculate Price on Free',
        //                 FRA='Calculer Prix sur gratuit';
        //     Description = 'DITW15.00.00.35';
        //     OptionCaptionML = ENU=' ,Price 0,Discount 100%',
        //                       FRA=' ,Prix 0,Remise 100%';
        //     OptionMembers = " ",Price,Amount;
        // }
        // field(2013826;"Free Item";Boolean)
        // {
        //     CaptionML = ENU='Free Item',
        //                 FRA='Article gratuit';
        //     Description = 'DITW15.00.00.35';
        // }
        // field(2013827;"Free Calculation Type";Option)
        // {
        //     CaptionML = ENU='Calculate on Free',
        //                 FRA='Calculer sur gratuit';
        //     Description = 'DITW15.00.00.35';
        //     OptionCaptionML = ENU='None,Discount 100%,Full Amount',
        //                       FRA='Aucun,Remise 100%,Montant';
        //     OptionMembers = "None","Discount 100%",All;
        // }
        // field(2013828;"Include Free Qty. in Minimum";Boolean)
        // {
        //     CaptionML = ENU='Include Free Quantity in Minimum',
        //                 FRA='Inclure quantité gratuite avec minimum';
        //     Description = 'DITW15.00.00.35';
        // }
        // field(2014064;"Shipping Charge Per";Option)
        // {
        //     CaptionML = ENU='Shipping Charge Per',
        //                 FRA='Frais transport par';
        //     Description = 'DITW15.00.00.25';
        //     OptionCaptionML = ENU='Shipment,Weight,Volume',
        //                       FRA='Expédition,Poids,Volume';
        //     OptionMembers = Shipment,Weight,Volume;
        // }
        // field(2014065;"Original Quantity";Decimal)
        // {
        //     CaptionML = ENU='Original Quantity',
        //                 FRA='Quantité initiale';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW18.00.07 DIT-770 #1703';
        //     MaxValue = 100;
        //     MinValue = 0;
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
        //     Description = 'DITW15.00.00.26';
        //     TableRelation = "Whse. Shipping Truck";
        // }
        // field(2014078;"Driver Code";Code[10])
        // {
        //     CaptionML = ENU='Driver Code',
        //                 FRA='Code chauffeur';
        //     Description = 'DITW15.00.00.26';
        //     TableRelation = "Whse. Shipping Driver";
        // }
        // field(2014079;Cubage;Decimal)
        // {
        //     CaptionML = ENU='Volume (Cubage)',
        //                 FRA='Volume (cubage)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014080;Weight;Decimal)
        // {
        //     CaptionML = ENU='Weight',
        //                 FRA='Poids';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014085;"Shipping Whse. Shipment No.";Code[20])
        // {
        //     CaptionML = ENU='Shipping Whse. Shipment No.',
        //                 FRA='N° expédition transport';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        //     TableRelation = "Posted Whse. Shipment Header";
        // }
        // field(2014086;"Shipping Whse. Receipt No.";Code[20])
        // {
        //     CaptionML = ENU='Shipping Whse. Receipt No.',
        //                 FRA='N° réception transport';
        //     Description = 'DITW15.00.00.25';
        //     Editable = false;
        //     TableRelation = "Posted Whse. Receipt Header";
        // }
        // field(2014087;Distance;Decimal)
        // {
        //     CaptionML = ENU='Distance',
        //                 FRA='Distance';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.25';
        //     MinValue = 0;
        // }
        // field(2014088;"Item Delivery Type";Code[10])
        // {
        //     CaptionML = ENU='Item Delivery Type',
        //                 FRA='Type de Livraison Article';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     TableRelation = "Delivery Type".Code WHERE (Type=CONST(Item));
        // }
        // field(2014089;"Delivery Time (sec.)";Decimal)
        // {
        //     CaptionML = ENU='Delivery Time (sec.)',
        //                 FRA='Temps de Livraison (Sec.)';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     MinValue = 0;
        // }
        // field(2014094;"Physical Location Group Code";Code[10])
        // {
        //     CaptionML = ENU='Physical Location Group Code',
        //                 FRA='Code groupe magasin réel';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014113;"Tax Item No.";Code[20])
        // {
        //     CaptionML = ENU='Tax Tracking Item No.',
        //                 FRA='N° article traçable Taxe';
        //     Description = 'DITW15.00.00.38 #703';
        //     TableRelation = Item;
        // }
        // field(2014260;"LRN No. Series";Code[10])
        // {
        //     CaptionML = ENU='LRN No. Series',
        //                 FRA='Souches de n° LRN';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "No. Series";
        // }
        // field(2014261;"LRN No.";Code[20])
        // {
        //     CaptionML = ENU='LRN No.',
        //                 FRA='N° LRN';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014262;"ARC No.";Code[30])
        // {
        //     CaptionML = ENU='ARC No.',
        //                 FRA='N° ARC';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //         if CurrFieldNo = FIELDNO("ARC No.") then
        //           TESTFIELD("Applies-to AAD Trck. Entry No.",0);
        //         // >>DITW15.00.00.39 DDR #1369
        //         // <<DITW15.00.00.38 DDR 23/11/2010 #1217 (DIT711 56)
        //         if "ARC No." <> xRec."ARC No." then
        //           if not LRNDocMgt.SynchDocToAADTracking(
        //             DATABASE::"Purch. Rcpt. Line","Document No.","Line No.",FIELDCAPTION("ARC No."),xRec."ARC No.","ARC No.")
        //           then
        //             FIELDERROR("ARC No.");
        //         // >>DITW15.00.00.38 #1217
        //     end;
        // }
        // field(2014263;"SAD No.";Code[30])
        // {
        //     CaptionML = ENU='SAD No.',
        //                 FRA='N° SAD';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/11/2010 #1217 (DIT711 56)
        //         if "SAD No." <> xRec."SAD No." then
        //           if not LRNDocMgt.SynchDocToAADTracking(
        //             DATABASE::"Purch. Rcpt. Line","Document No.","Line No.",FIELDCAPTION("SAD No."),xRec."SAD No.","SAD No.")
        //           then
        //             FIELDERROR("SAD No.");
        //         // >>DITW15.00.00.38 #1217
        //     end;
        // }
        // field(2014265;"Product Tax Code";Code[10])
        // {
        //     CaptionML = ENU='Tax Product Code',
        //                 FRA='Code Produit taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Product";
        // }
        // field(2014267;"ARC No. Mandatory";Boolean)
        // {
        //     CaptionML = ENU='ARC No. Mandatory (EMCS)',
        //                 FRA='N° ARC obligatoire (EMCS)';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014271;"Company Tax Warehouse Ref.";Text[20])
        // {
        //     CaptionML = ENU='Company Tax Warehouse Reference',
        //                 FRA='Entrepôt fiscal de référence société';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014283;"ARC Line No.";Integer)
        // {
        //     CaptionML = ENU='ARC Line No.',
        //                 FRA='N° ligne ARC';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     var
        //         PurchRcptLine : Record "Purch. Rcpt. Line";
        //     begin
        //         // <<DITW15.00.00.38 DDR 26/11/2010 #1217 (DIT711 83)
        //         TESTFIELD(Correction,false);
        //         TESTFIELD("ARC No. Mandatory",true);
        //         TESTFIELD("ARC No.");
        //         if TestExistEDIOutboxDocNo(false) then
        //           TESTFIELD("ARC Line No.",xRec."ARC Line No.");
        //         // <<DITW15.00.00.39 DDR 09/05/2011 #1296
        //         ExistPostedWhseReceipt(FIELDCAPTION("ARC Line No."));
        //         // >>DITW15.00.00.39 DDR #1296
        //         // <<DITW16.00.00.40 DDR 01/02/2012 DIT-715 #200
        //         if "Unsatisfactory Type" > 0 then
        //           TESTFIELD("ARC Line No.")
        //         else
        //           TESTFIELD("ARC Line No.",0);
        //         // >>DITW16.00.00.40 DDR DIT-715 #200

        //         if "ARC Line No." <> 0 then begin
        //           PurchRcptLine.SETCURRENTKEY("Document No.","ARC No.","ARC Line No.");
        //           PurchRcptLine.SETRANGE("Document No.","Document No.");
        //           PurchRcptLine.SETRANGE("ARC No.","ARC No.");
        //           PurchRcptLine.SETFILTER("Line No.",'<>%1',"Line No.");
        //           PurchRcptLine.SETRANGE("ARC Line No.","ARC Line No.");
        //           if PurchRcptLine.FINDFIRST then
        //             PurchRcptLine.FIELDERROR("ARC Line No.");
        //         end;
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2014284;"Unsatisfactory Type";Option)
        // {
        //     CaptionML = ENU='Unsatisfactory Type',
        //                 FRA='Type Insatisfaisant';
        //     Description = 'DITW15.00.00.38 #1217';
        //     OptionCaptionML = ENU='Other,Excess,Shortage,Good Damaged,Broken Seal,Reported by Export Control System,Incorrect Values',
        //                       FRA='Autre,En excès,En pénurie,Marchandise abimée,Sceau brisé,Rapporté par ECS,Valeurs incorrectes';
        //     OptionMembers = " ",Excess,Shortage,"Good damaged","Broken Seal","Reported by ECS","Incorrect Values";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 06/10/2010 - 12/10/2010 - 26/11/2010 #1217
        //         TESTFIELD(Correction,false);
        //         TESTFIELD("ARC No. Mandatory",true);
        //         TESTFIELD("ARC No.");
        //         if TestExistEDIOutboxDocNo(false) then
        //           TESTFIELD("Unsatisfactory Type",xRec."Unsatisfactory Type");
        //         // <<DITW15.00.00.39 DDR 09/05/2011 #1296
        //         if CurrFieldNo <> 0 then
        //           ExistPostedWhseReceipt(FIELDCAPTION("Unsatisfactory Type"));
        //         // >>DITW15.00.00.39 DDR #1296

        //         if "Unsatisfactory Type" = "Unsatisfactory Type"::" " then begin
        //           "Unsatisfactory Quantity" := 0;
        //           // <<DITW16.00.00.40 DDR 01/02/2012 DIT-715 #200
        //           "ARC Line No." := 0;
        //           // >>DITW16.00.00.40 DDR DIT-715 #200
        //         end;
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2014285;"Unsatisfactory Quantity";Decimal)
        // {
        //     CaptionML = ENU='Unsatisfactory Quantity',
        //                 FRA='Quantité Insatisfaisant';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 06/10/2010 - 12/10/2010 #1217
        //         TESTFIELD(Correction,false);
        //         TESTFIELD("ARC No. Mandatory",true);
        //         TESTFIELD("ARC No.");
        //         if TestExistEDIOutboxDocNo(false) then
        //           TESTFIELD("Unsatisfactory Quantity",xRec."Unsatisfactory Quantity");
        //         // <<DITW15.00.00.39 DDR 09/05/2011 #1296
        //         if CurrFieldNo <> 0 then
        //           ExistPostedWhseReceipt(FIELDCAPTION("Unsatisfactory Quantity"));
        //         // >>DITW15.00.00.39 DDR #1296

        //         if "Unsatisfactory Quantity" <> 0 then begin
        //           if "Unsatisfactory Type" = 0 then
        //             FIELDERROR("Unsatisfactory Type");
        //         end else
        //           "Unsatisfactory Type" := "Unsatisfactory Type"::" ";
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2014286;"Unsatisfactory Comment";Boolean)
        // {
        //     CalcFormula = Exist("EMCS Comment Line" WHERE ("Table ID"=CONST(121),
        //                                                    "Document Type"=CONST(0),
        //                                                    "Document No."=FIELD("Document No."),
        //                                                    "Document Line No."=FIELD("Line No."),
        //                                                    "Field ID"=CONST(2014285)));
        //     CaptionML = ENU='Unsatisfactory Comment',
        //                 FRA='Commentaires insatisfaisant';
        //     Description = 'DITW15.00.00.38 #1217';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014310;"Service Contract Line No.";Integer)
        // {
        //     CaptionML = ENU='Contract Line No.',
        //                 FRA='N° ligne contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';
        // }
        // field(2014313;"Financial Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Financial Contract No.',
        //                 FRA='N° Contrat Financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Financial Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                       "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
        // }
        // field(2014410;Collapse;Boolean)
        // {
        //     CaptionML = ENU='Collapse',
        //                 FRA='Réduire';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2014415;"Item Charge Qty. per Uom";Decimal)
        // {
        //     CaptionML = ENU='Item Charge Qty. per Unit of Measure',
        //                 FRA='Qté frais annexe par unité de mesure';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW16.00.00.43 DIT-715 #882';
        //     InitValue = 1;
        // }
        // field(2014426;"Service Order No.";Code[20])
        // {
        //     CaptionML = ENU='Service Order No.',
        //                 FRA='N° commande de service';
        //     Description = 'DITW15.00.00.39 #1403 - DIT-715 #297';
        //     Editable = false;
        //     TableRelation = "Service Header"."No." WHERE ("Document Type"=CONST(Order));
        // }
        // field(2014427;"Service Order Line No.";Integer)
        // {
        //     CaptionML = ENU='Service Order Line No.',
        //                 FRA='N° ligne commande de service';
        //     Description = 'DITW15.00.00.39 #1403 DIT-715 #297';
        // }
        // field(2014430;Amount;Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCodeFromHeader;
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Amount',
        //                 FRA='Montant';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        // }
        // field(2014431;"Amount Including VAT";Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCodeFromHeader;
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Amount Including VAT',
        //                 FRA='Montant TTC';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        // }
        // field(2014432;"Line Discount Amount";Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCodeFromHeader;
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Line Discount Amount',
        //                 FRA='Montant remise ligne';
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014433;"Inv. Discount Amount";Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCodeFromHeader;
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Inv. Discount Amount',
        //                 FRA='Montant remise facture';
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014434;"Line Amount";Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCodeFromHeader;
        //     AutoFormatType = 1;
        //     CaptionClass = GetCaptionClass(FIELDNO("Line Amount"));
        //     CaptionML = ENU='Line Amount',
        //                 FRA='Montant ligne';
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014435;"VAT Difference";Decimal)
        // {
        //     AutoFormatExpression = GetCurrencyCodeFromHeader;
        //     AutoFormatType = 1;
        //     CaptionML = ENU='VAT Difference',
        //                 FRA='Différence TVA';
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014436;"VAT Identifier";Code[10])
        // {
        //     CaptionML = ENU='VAT Identifier',
        //                 FRA='Identifiant TVA';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        // }
        // field(2014437;"Prepayment Line";Boolean)
        // {
        //     CaptionML = ENU='Prepayment Line',
        //                 FRA='Ligne acompte';
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        // }
        // field(2014440;"Approved Dimension set ID";Integer)
        // {
        //     CaptionML = ENU='Approved Dimension set ID',
        //                 FRA='ID ensemble de dimensions approuvé';
        //     Description = 'DITW17.00.05 DIT-770 #961';
        // }
        // field(2014444;"Last Price Calculated Date";Date)
        // {
        //     CaptionML = ENU='Last Price Calculated Date',
        //                 FRA='Dernière date prix calculé';
        //     Description = 'DITW15.00.00.31';
        // }
        // field(2014448;"Document Date";Date)
        // {
        //     CalcFormula = Lookup("Purch. Rcpt. Header"."Document Date" WHERE ("No."=FIELD("Document No.")));
        //     CaptionML = ENU='Document Date',
        //                 FRA='Date document';
        //     Description = 'DITW17.00.02 DIT-770 #149';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014449;"Vendor Shipment No.";Code[35])
        // {
        //     CalcFormula = Lookup("Purch. Rcpt. Header"."Vendor Shipment No." WHERE ("No."=FIELD("Document No.")));
        //     CaptionML = ENU='Vendor Shipment No.',
        //                 FRA='N° B.L. fournisseur';
        //     Description = 'DITW17.00.02 DIT-770 #149 - DITW110.00.10 NRQ#14724';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014460;"Production BOM No.";Code[20])
        // {
        //     CaptionML = ENU='Production BOM No.',
        //                 FRA='N° nomenclature production';
        //     Description = 'DITW18.00.06 DIT-770 #1449';
        //     TableRelation = "Production BOM Header";
        // }
        // field(2014462;"BOM Line No.";Integer)
        // {
        //     CaptionML = ENU='BOM Line No.',
        //                 FRA='N° ligne nomenclature';
        //     Description = 'DITW18.00.06 DIT-770 #1449';
        //     NotBlank = true;
        //     TableRelation = IF ("Production BOM No."=FILTER(<>'')) "Production BOM Line"."Line No." WHERE ("Production BOM No."=FIELD("Production BOM No."))
        //                     else IF ("Production BOM No."=CONST('')) "BOM Component"."Line No." WHERE ("Parent Item No."=FIELD("BOM Item No."));
        // }
        // field(2014463;"BOM Item No.";Code[20])
        // {
        //     CaptionML = ENU='BOM Item No.',
        //                 FRA='N° article nomenclature';
        //     Description = 'DITW18.00.06 DIT-770 #1449';
        //     TableRelation = Item;
        // }
        // field(2014464;"BOM Qty. per Unit of Measure";Decimal)
        // {
        //     CaptionML = ENU='BOM Qty. per Unit of Measure',
        //                 FRA='Quantité par unité nomenclature';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW18.00.06 DIT-770 #1449';
        // }
        // field(2014476;"Packaging Type Code";Code[10])
        // {
        //     CaptionML = ENU='Packaging Type Code',
        //                 FRA='Code Type de Conditionnement';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Packaging Type";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 14/09/2010 - 12/10/2010 #1217
        //         TESTFIELD(Correction,false);
        //         // <<DITW18.00.06 DDR 20/10/2015 DIT-770 #1449
        //         if (CurrFieldNo = FIELDNO("Packaging Type Code")) and ("Tax Item No." <> '') and
        //           ("Packaging Type Code" <> '') and (xRec."Packaging Type Code" <> "Packaging Type Code")
        //         then
        //           TESTFIELD("Packaging Type Code",xRec."Packaging Type Code");
        //         // >>DITW18.00.06 DDR DIT-770 #1449

        //         // <<DITW16.00.00.42 DDR 27/02/2013 DIT-715 #550
        //         if ("Packaging Type Code" <> '') and ((Type = Type::Item) or ("Tax Item No." <> '')) then begin
        //         // >>DITW16.00.00.42 DDR DIT-715 #550
        //           PackagingType.GET("Packaging Type Code");
        //           if PackagingType.Countable then begin
        //             // <<DITW15.00.00.38 DDR 22/02/2010 #1217 (DIT711 151)
        //             if "Tax Item No." <> '' then begin
        //               Item.GET("Tax Item No.");
        //               ItemUnitOfMeasure.GET("Tax Item No.",Item."Sales Unit of Measure");
        //             end else
        //               ItemUnitOfMeasure.GET("No.","Unit of Measure Code");
        //             if "Packaging Type Code" = ItemUnitOfMeasure."Packaging Type Code" then begin
        //               ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
        //               "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
        //             end else
        //               "Pack Qty. per Unit of Measure" := 1;
        //             // >>DITW15.00.00.38 DDR #1217 (DIT711 151)
        //             // <<DITW15.00.00.38 DDR 31/01/2011 #1217 (DIT711 140) - 16/02/2011 (DIT711 148)
        //             TESTFIELD("Pack Qty. per Unit of Measure");
        //             // <<DITW16.00.00.44 DDR 24/03/2014 DIT-715 #912
        //             "No. of Packages" := ROUND(Quantity * "Pack Qty. per Unit of Measure",1,'>');
        //             // >>DITW16.00.00.44 DDR DIT-715 #912
        //             // >>DITW15.00.00.38 DDR #1217 (DIT711 140) (DIT711 148)
        //           end else
        //             "No. of Packages" := 0;
        //         end else
        //           // <<DITW15.00.00.38 DDR 22/02/2010 #1217 (DIT711 151)
        //           "No. of Packages" := 0;
        //           // >>DITW15.00.00.38 DDR #1217 (DIT711 151)
        //         // >>DITW15.00.00.38 DDR #1217
        //     end;
        // }
        // field(2014477;"No. of Packages";Decimal)
        // {
        //     CaptionML = ENU='No. of Packages',
        //                 FRA='Nbre de colis';
        //     DecimalPlaces = 0:2;
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 16/09/2010 - 12/10/2010 #1217
        //         TESTFIELD(Correction,false);
        //         TESTFIELD(Quantity);
        //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //         if ("Tax Item No." = '') and (Type <> Type::Item) then
        //           TESTFIELD("No. of Packages",0);
        //         // >>DITW15.00.00.38 DDR #703
        //         // <<DITW18.00.06 DDR 20/10/2015 DIT-770 #1449
        //         if ("Tax Item No." <> '') and (xRec."No. of Packages" <> "No. of Packages") then
        //           TESTFIELD("No. of Packages",xRec."No. of Packages");
        //         // >>DITW18.00.06 DDR DIT-770 #1449
        //     end;
        // }
        // field(2014478;"Commercial Seal ID";Text[35])
        // {
        //     CaptionML = ENU='Commercial Seal ID',
        //                 FRA='ID sceau commerciale';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 16/09/2010 - 12/10/2010 #1217
        //         TESTFIELD(Correction,false);
        //         TESTFIELD(Quantity);
        //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //         if ("Tax Item No." = '') and (Type <> Type::Item) then
        //           TESTFIELD("Commercial Seal ID",'');
        //         // >>DITW15.00.00.38 DDR #703
        //     end;
        // }
        // field(2014482;"Pack Qty. per Unit of Measure";Decimal)
        // {
        //     CaptionML = ENU='Packaging Qty. per Unit of Measure',
        //                 FRA='Quantité conditionnement par unité';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.38 #1217 (DIT711 148)';
        // }
        // field(2014500;"Has Item Charge";Boolean)
        // {
        //     CalcFormula = Exist("Purch. Rcpt. Line" WHERE ("Document No."=FIELD("Document No."),
        //                                                    "Attached to Line No."=FIELD("Line No.")));
        //     CaptionML = ENU='Has Item Charge',
        //                 FRA='A des Frais Annexes';
        //     Description = 'DITW17.10.03 DIT-770 #541';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014503;"Equiv. Unit of Measure Code";Code[10])
        // {
        //     CaptionML = ENU='Equiv. Unit of Measure Code',
        //                 FRA='Unitié de mesure equiv.';
        //     Description = 'DITW17.00.02 DIT-770 #183';
        //     TableRelation = "Unit of Measure".Code;
        // }
        // field(2014504;"Calculate Minimum";Option)
        // {
        //     CaptionML = ENU='Calculate Minimum',
        //                 FRA='Calculer minimum';
        //     Description = 'DITW17.10.03 DIT-770 #327-NRQ#14143';
        //     OptionCaptionML = ENU=' ,Under,Over,Until,Until Including Min,Recurring Minimum,Recurring Over,Recurring Under,Recurring Until',
        //                       FRA=' ,Under,Over,Until,Until Including Min,Recurring Minimum,Recurring Over,Recurring Under,Recurring Until';
        //     OptionMembers = " ",Under,Over,"Until","Until Including Min","Recurring Minimum","Recurring Over","Recurring Under","Recurring Until";
        // }
        // field(2014505;"Recurring Min. Quantity";Decimal)
        // {
        //     CaptionML = ENU='Recurring Min. Quantity',
        //                 FRA='Quantité Min. Recurrente';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW17.10.03 DIT-770 #327';
        //     MinValue = 0;
        // }
        // field(2014506;"Splitting per";Option)
        // {
        //     CaptionML = ENU='Calculate Source Per',
        //                 FRA='Calculer source par';
        //     Description = 'DITW17.10.03 DIT-770 #327';
        //     InitValue = Item;
        //     OptionCaptionML = ENU='Group,Item',
        //                       FRA='Groupe,Article';
        //     OptionMembers = Group,Item;
        // }
        // field(2014507;"Minimum Quantity";Decimal)
        // {
        //     Caption = 'Minimum Quantity';
        //     DecimalPlaces = 0:5;
        //     Description = 'NRQ#14143';
        //     MinValue = 0;
        // }
        // field(2029611;"Auto. Acc. Group";Code[10])
        // {
        //     CaptionML = ENU='Auto. Acc. Group',
        //                 FRA='Groupe compte autom.';
        //     Description = 'FINXL7.00.001';
        //     TableRelation = "Automatic Acc. Header";
        // }
        // field(2029614;"Pay-to Vendor No. Reception";Code[20])
        // {
        //     CaptionML = ENU='Pay-to Vendor No. Reception',
        //                 FRA='N° Réception Fournisseur à Payer';
        //     Description = 'FINXL8.00.001';
        //     Editable = false;
        //     TableRelation = Vendor;
        //     ValidateTableRelation = false;
        // }
        // field(2034850;"DIT Sub-Contract Type";Option)
        // {
        //     CaptionML = ENU='Sub Contract Type',
        //                 FRA='Sous type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';
        //     OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA=' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        // }
        // field(2034872;"Contract Group Code";Code[10])
        // {
        //     CaptionML = ENU='Contract Group Code',
        //                 FRA='Code groupe contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';
        //     TableRelation = IF ("Contract Type"=CONST(Service)) "Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"))
        //                     else IF ("Contract Type"=CONST(Financial)) "Financial Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034915;"Service Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Service Contract No.',
        //                 FRA='N° contrat de service';
        //     Description = 'DITW16.00.00.41 DIT-715 #392 -DITW18.00.06 MSF 31/07/2015 DIT-770 #1368';
        //     TableRelation = "Service Purch. Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                            "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
        // }
        // field(2035391;"Buy-from Vendor Name";Text[50])
        // {
        //     CalcFormula = Lookup("Purch. Rcpt. Header"."Buy-from Vendor Name" WHERE ("No."=FIELD("Document No.")));
        //     CaptionML = ENU='Buy-from Vendor Name',
        //                 FRA='Nom du fournisseur';
        //     Description = 'DITW17.00.02 DIT-770 #180';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035393;"Contract Type";Option)
        // {
        //     CaptionML = ENU='Contract Type',
        //                 FRA='Type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392 - DITW18.00.06 DIT-770 #1368';
        //     OptionCaptionML = ENU=' ,Service,Financial',
        //                       FRA=' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }
        //BC UPGRADE SHARMP16 comment drink-it fields >>
    }
    keys
    {

        //Unsupported feature: PropertyChange on ""Document No.","Line No."(Key)". Please convert manually.
        //BC UPGRADE SHARMP16 comment drink-it keys <<
        // key(Key1;"Document No.","Attached to Line No.","Is Item Charge")
        // {
        //     SumIndexFields = "Line Amount";
        // }
        // key(Key2;"Document No.","AAD No. Series","Company Tax Registration No.","Tariff No.",Type,"No.")
        // {
        // }
        // key(Key3;"Document No.","ARC No.","ARC Line No.","Company Tax Registration No.","Tariff No.",Type,"No.")
        // {
        // }
        // key(Key4;"Applies-to AAD Trck. Entry No.")
        // {
        // }
        // key(Key5;"Service Order No.","Service Order Line No.")
        // {
        // }
        //BC UPGRADE SHARMP16 comment drink-it keys >>
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: EMCSDocLineComments)();
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
    PurchDocLineComments.SETRANGE("Document Type",PurchDocLineComments."Document Type"::Receipt);
    PurchDocLineComments.SETRANGE("No.","Document No.");
    PurchDocLineComments.SETRANGE("Document Line No.","Line No.");
    IF NOT PurchDocLineComments.ISEMPTY THEN
      PurchDocLineComments.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    if not PurchDocLineComments.ISEMPTY then
      PurchDocLineComments.DELETEALL;

    // <<DITW15.00.00.38 DDR 05/10/2010
    EMCSDocLineComments.SETRANGE("Table ID",DATABASE::"Purch. Rcpt. Line");
    EMCSDocLineComments.SETRANGE("Document Type",0);
    EMCSDocLineComments.SETRANGE("Document No.","Document No.");
    EMCSDocLineComments.SETRANGE("Document Line No.","Line No.");
    if not EMCSDocLineComments.ISEMPTY then
      EMCSDocLineComments.DELETEALL;
    // >>DITW15.00.00.38 DDR
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
    //EMCSDocLineComments: Record "EMCS Comment Line";

    var
        PaymentTerms: Record "Payment Terms";
        ItemChargePurchRcptLine: Record "Purch. Rcpt. Line";
        PurchaseHeader: Record "Purchase Header";
        PurchaseHeader2: Record "Purchase Header";
        PurchGetRcpt: Codeunit "Purch.-Get Receipt";
        PrePaymentFraction: Decimal;

    var
    // PostedDocumentShippingCost: Record "Posted Document Shipping Cost";


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Receipt No. %1:;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Receipt No. %1:;FRA=N° réception %1 :;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=The program cannot find this purchase line.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=The program cannot find this purchase line.;FRA=Le programme ne trouve pas cette ligne achat.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ItemNoFieldCaptionTxt(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ItemNoFieldCaptionTxt : ENU=Item No.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemNoFieldCaptionTxt : ENU=Item No.;FRA=N° article;
    //Variable type has not been exported.

    var
        SaveCurrency: Record Currency;
        InvtSetup: Record "Inventory Setup";
        // EmcsSetup: Record "EMCS Setup";
        // PackagingType: Record "Packaging Type";
        // LRNDocMgt: Codeunit "LRN Document Mgt.";
        Item: Record Item;
        recItemLedgEntry: Record "Item Ledger Entry";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        recPurchRcptLine: Record "Purch. Rcpt. Line";
        recUserSetup: Record "User Setup";
        recValueEntry: Record "Value Entry";
        recVATPostingSetup: Record "VAT Posting Setup";
        recVendor: Record Vendor;
        cduSalesTaxCalculate: Codeunit "Sales Tax Calculate";
        SaveTransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
        decTotalAmount: Decimal;
        decTotalAmountInclVAT: Decimal;
        decTotalInvDiscAmount: Decimal;
        decTotalLineAmount: Decimal;
        decTotalQuantityBase: Decimal;
        decTotalVATBaseAmount: Decimal;
        Text2013760: TextConst ENU = 'You cannot modify %1 because it is attached to %2 %3.', FRA = 'Vous ne pouvez pas modifier %1, car il est attaché à %2 %3.';
    //recFinXLSetup: Record "Finance XL Setup";
    //Text50000: ;
}

